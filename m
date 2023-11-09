Return-Path: <netdev+bounces-46774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C97E655E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C891F214F0
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECB1EC0;
	Thu,  9 Nov 2023 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8F10A07
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:34:20 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396D273E
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 00:34:18 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vw01fIT_1699518853;
Received: from 30.221.148.83(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vw01fIT_1699518853)
          by smtp.aliyun-inc.com;
          Thu, 09 Nov 2023 16:34:14 +0800
Message-ID: <4ed04b2e-b4be-4841-8484-7e7087cc90f4@linux.alibaba.com>
Date: Thu, 9 Nov 2023 16:34:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] virtio-net: return -EOPNOTSUPP for
 adaptive-tx
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>
References: <cover.1698929590.git.hengqi@linux.alibaba.com>
 <4d57c072ca7d12034a1be4d9284e2be5988e1330.1698929590.git.hengqi@linux.alibaba.com>
 <CACGkMEt23Xm=dpwJMwX9dnwVjmQZqBp0SBxnpY19fgc=xMpcjA@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEt23Xm=dpwJMwX9dnwVjmQZqBp0SBxnpY19fgc=xMpcjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/11/9 下午12:45, Jason Wang 写道:
> On Thu, Nov 2, 2023 at 9:10 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> We do not currently support tx dim, so respond to -EOPNOTSUPP.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> ---
>> v1->v2:
>> - Use -EOPNOTSUPP instead of specific implementation.
>>
>>   drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
>>   1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 5473aa1ee5cd..03edeadd0725 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3364,9 +3364,15 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
>>   static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
>>                                            struct ethtool_coalesce *ec)
>>   {
>> +       bool tx_ctrl_dim_on = !!ec->use_adaptive_tx_coalesce;
>>          struct scatterlist sgs_tx;
>>          int i;
>>
>> +       if (tx_ctrl_dim_on) {
>> +               pr_debug("Failed to enable adaptive-tx, which is not supported\n");
>> +               return -EOPNOTSUPP;
>> +       }
> When can we hit this?

When user tries to enable tx dim using following cmd:
'ethtool -C eth0 adaptive-tx on'

Thanks!

>
> Thanks
>
>> +
>>          vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
>>          vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
>>          sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
>> @@ -3497,6 +3503,25 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
>>          return 0;
>>   }
>>
>> +static int virtnet_send_tx_notf_coal_vq_cmds(struct virtnet_info *vi,
>> +                                            struct ethtool_coalesce *ec,
>> +                                            u16 queue)
>> +{
>> +       bool tx_ctrl_dim_on = !!ec->use_adaptive_tx_coalesce;
>> +       int err;
>> +
>> +       if (tx_ctrl_dim_on) {
>> +               pr_debug("Enabling adaptive-tx for txq%d is not supported\n", queue);
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>> +       err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
>> +                                              ec->tx_coalesce_usecs,
>> +                                              ec->tx_max_coalesced_frames);
>> +
>> +       return err;
>> +}
>> +
>>   static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>>                                            struct ethtool_coalesce *ec,
>>                                            u16 queue)
>> @@ -3507,9 +3532,7 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>>          if (err)
>>                  return err;
>>
>> -       err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
>> -                                              ec->tx_coalesce_usecs,
>> -                                              ec->tx_max_coalesced_frames);
>> +       err = virtnet_send_tx_notf_coal_vq_cmds(vi, ec, queue);
>>          if (err)
>>                  return err;
>>
>> --
>> 2.19.1.6.gb485710b
>>


