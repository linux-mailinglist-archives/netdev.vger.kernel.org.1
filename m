Return-Path: <netdev+bounces-50403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6407F5A08
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455621F20ED2
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40DBE6F;
	Thu, 23 Nov 2023 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA38A3
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 00:32:05 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vwyn4UG_1700728321;
Received: from 30.221.145.52(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vwyn4UG_1700728321)
          by smtp.aliyun-inc.com;
          Thu, 23 Nov 2023 16:32:03 +0800
Message-ID: <b87c060f-efec-4efe-a03d-a42242d6cec7@linux.alibaba.com>
Date: Thu, 23 Nov 2023 16:31:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/4] virtio-net: support rx netdim
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, horms@kernel.org, xuanzhuo@linux.alibaba.com
References: <cover.1700478183.git.hengqi@linux.alibaba.com>
 <c00b526f32d9f9a5cd2e98a212ee5306d6b6d71c.1700478183.git.hengqi@linux.alibaba.com>
 <CACGkMEtt-Anog6gS1YvKi2Bt+Q32BnQEtY7E-wLWJwKjRMTUrA@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEtt-Anog6gS1YvKi2Bt+Q32BnQEtY7E-wLWJwKjRMTUrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/11/22 下午1:52, Jason Wang 写道:
> On Mon, Nov 20, 2023 at 8:38 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> By comparing the traffic information in the complete napi processes,
>> let the virtio-net driver automatically adjust the coalescing
>> moderation parameters of each receive queue.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> ---
>> v2->v3:
>> - Some minor modifications.
>>
>> v1->v2:
>> - Improved the judgment of dim switch conditions.
>> - Cancel the work when vq reset.
>>
>>   drivers/net/virtio_net.c | 191 ++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 169 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 69fe09e99b3c..bc32d5aae005 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/average.h>
>>   #include <linux/filter.h>
>>   #include <linux/kernel.h>
>> +#include <linux/dim.h>
>>   #include <net/route.h>
>>   #include <net/xdp.h>
>>   #include <net/net_failover.h>
>> @@ -172,6 +173,17 @@ struct receive_queue {
>>
>>          struct virtnet_rq_stats stats;
>>
>> +       /* The number of rx notifications */
>> +       u16 calls;
>> +
>> +       /* Is dynamic interrupt moderation enabled? */
>> +       bool dim_enabled;
>> +
>> +       /* Dynamic Interrupt Moderation */
>> +       struct dim dim;
>> +
>> +       u32 packets_in_napi;
>> +
>>          struct virtnet_interrupt_coalesce intr_coal;
>>
>>          /* Chain pages by the private ptr. */
>> @@ -305,6 +317,9 @@ struct virtnet_info {
>>          u8 duplex;
>>          u32 speed;
>>
>> +       /* Is rx dynamic interrupt moderation enabled? */
>> +       bool rx_dim_enabled;
>> +
>>          /* Interrupt coalescing settings */
>>          struct virtnet_interrupt_coalesce intr_coal_tx;
>>          struct virtnet_interrupt_coalesce intr_coal_rx;
>> @@ -2001,6 +2016,7 @@ static void skb_recv_done(struct virtqueue *rvq)
>>          struct virtnet_info *vi = rvq->vdev->priv;
>>          struct receive_queue *rq = &vi->rq[vq2rxq(rvq)];
>>
>> +       rq->calls++;
>>          virtqueue_napi_schedule(&rq->napi, rvq);
>>   }
>>
>> @@ -2141,6 +2157,26 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>>          }
>>   }
>>
>> +static void virtnet_rx_dim_work(struct work_struct *work);
>> +
>> +static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
>> +{
>> +       struct dim_sample cur_sample = {};
>> +
>> +       if (!rq->packets_in_napi)
>> +               return;
>> +
>> +       u64_stats_update_begin(&rq->stats.syncp);
>> +       dim_update_sample(rq->calls,
>> +                         u64_stats_read(&rq->stats.packets),
>> +                         u64_stats_read(&rq->stats.bytes),
>> +                         &cur_sample);
>> +       u64_stats_update_end(&rq->stats.syncp);
>> +
>> +       net_dim(&rq->dim, cur_sample);
>> +       rq->packets_in_napi = 0;
>> +}
>> +
>>   static int virtnet_poll(struct napi_struct *napi, int budget)
>>   {
>>          struct receive_queue *rq =
>> @@ -2149,17 +2185,22 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>>          struct send_queue *sq;
>>          unsigned int received;
>>          unsigned int xdp_xmit = 0;
>> +       bool napi_complete;
>>
>>          virtnet_poll_cleantx(rq);
>>
>>          received = virtnet_receive(rq, budget, &xdp_xmit);
>> +       rq->packets_in_napi += received;
>>
>>          if (xdp_xmit & VIRTIO_XDP_REDIR)
>>                  xdp_do_flush();
>>
>>          /* Out of packets? */
>> -       if (received < budget)
>> -               virtqueue_napi_complete(napi, rq->vq, received);
>> +       if (received < budget) {
>> +               napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>> +               if (napi_complete && rq->dim_enabled)
>> +                       virtnet_rx_dim_update(vi, rq);
>> +       }
>>
>>          if (xdp_xmit & VIRTIO_XDP_TX) {
>>                  sq = virtnet_xdp_get_sq(vi);
>> @@ -2179,6 +2220,7 @@ static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>>          virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
>>          napi_disable(&vi->rq[qp_index].napi);
>>          xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>> +       cancel_work_sync(&vi->rq[qp_index].dim.work);
>>   }
>>
>>   static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>> @@ -2196,6 +2238,9 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>>          if (err < 0)
>>                  goto err_xdp_reg_mem_model;
>>
>> +       INIT_WORK(&vi->rq[qp_index].dim.work, virtnet_rx_dim_work);
>> +       vi->rq[qp_index].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
> So in V2, you explained it can be done here but I want to know why it
> must be done here.

It is not must be done here. We can place it in probe and make sure that 
INIT_WORK() is
done before napi is enabled for the first time.

So then I'll don't call INIT_WORK() every time after "napi_disable -> 
napi_enable" happens,
and use the following process:
Call INIT_WORK() in the driver probe and do cancel_work() after each 
related napi_disable.

This will be clearer.

Additionally, Yinjun Zhang found that cancel_work_sync() will cause a 
deadlock
when ndo_stop and virtnet_rx_dim_work occurs at the same time, so 
cancel_work() will be used.

>
> For example, the refill_work is initialized in alloc_queues().
>
>> +
>>          virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>>          virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
>>
>> @@ -2393,8 +2438,10 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
>>
>>          qindex = rq - vi->rq;
>>
>> -       if (running)
>> +       if (running) {
>>                  napi_disable(&rq->napi);
>> +               cancel_work_sync(&rq->dim.work);
>> +       }
>>
>>          err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
>>          if (err)
>> @@ -2403,8 +2450,10 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
>>          if (!try_fill_recv(vi, rq, GFP_KERNEL))
>>                  schedule_delayed_work(&vi->refill, 0);
>>
>> -       if (running)
>> +       if (running) {
>> +               INIT_WORK(&rq->dim.work, virtnet_rx_dim_work);
>>                  virtnet_napi_enable(rq->vq, &rq->napi);
>> +       }
>>          return err;
>>   }
>>
>> @@ -3341,24 +3390,55 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
>>   static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>>                                            struct ethtool_coalesce *ec)
>>   {
>> +       bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
>> +       bool update = false, switch_dim;
>>          struct scatterlist sgs_rx;
>>          int i;
>>
>> -       vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
>> -       vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
>> -       sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
>> -
>> -       if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>> -                                 VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
>> -                                 &sgs_rx))
>> -               return -EINVAL;
>> +       switch_dim = rx_ctrl_dim_on != vi->rx_dim_enabled;
>> +       if (switch_dim) {
>> +               if (rx_ctrl_dim_on) {
>> +                       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> So basically, I'm asking why we need to duplicate the check here?

Here is VIRTIO_NET_F_*VQ*_NOTF_COAL.

>
> E.g caller has done the check for us:
>
>          if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
>                  ret = virtnet_send_notf_coal_cmds(vi, ec);
>          else
>                  ret = virtnet_coal_params_supported(ec);
>
> ?
>
> Please also check other nested if/else, usually, too many levels of
> nesting is a hint that the logic needs to be optimized.

I will optimize this.

Thanks!

>
> Thanks


