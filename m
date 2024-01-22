Return-Path: <netdev+bounces-64571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B326835B91
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 08:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB47B21473
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A09FBF1;
	Mon, 22 Jan 2024 07:24:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D895F4F9
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908263; cv=none; b=gtTrbBdDDQuG/eSAuAR720caa8B1+axd1lrdEi2Q4bL/f8ImeZTfQUHcNwBfxyYa0yII1xBlNS2/qEa32z+q6QAPuSih+nnRcu6vqkM/5+rO5PdVnVE+KoQYse2ZiBIpnh7Yt4H0/0Wh7ZtBPB2Y9nX95WMybFV/+TC6CVHKeKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908263; c=relaxed/simple;
	bh=GXha2rQ/gaCQ2b20s/N8ajIYNplOpKBLyO7ZhZHES24=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=bInPOB5obhJW9wBP5y6n8jnXHlo/whoQF6ELQvNaBzqXoqxenrger8VjJk/TrbMvel3G4ndPKXJHCk0W6gnTZGozwKkryWjOsRqg1foJdnBRBR6eD1Rdo1MFznv/j808oYZ2UvqdNQe6/5PdHRsqTFiPeAsqLf0Z4kvDlTPwDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W.3mmrp_1705908255;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.3mmrp_1705908255)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 15:24:15 +0800
Message-ID: <1705907964.8769045-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 3/3] virtio-net: reduce the CPU consumption of dim worker
Date: Mon, 22 Jan 2024 15:19:24 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
 <1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com>
In-Reply-To: <1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 16 Jan 2024 21:11:33 +0800, Heng Qi <hengqi@linux.alibaba.com> wrote:
> Accumulate multiple request commands to kick the device once,
> and obtain the processing results of the corresponding commands
> asynchronously. The batch command method is used to optimize the
> CPU overhead of the DIM worker caused by the guest being busy
> waiting for the command response result.
>
> On an 8-queue device, without this patch, the guest cpu overhead
> due to waiting for cvq could be 10+% and above. With this patch,
> the corresponding overhead is basically invisible.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 185 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 158 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e4305ad..9f22c85 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -33,6 +33,8 @@
>  module_param(gso, bool, 0444);
>  module_param(napi_tx, bool, 0644);
>
> +#define BATCH_CMD 25
> +
>  /* FIXME: MTU in config. */
>  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
>  #define GOOD_COPY_LEN	128
> @@ -134,6 +136,9 @@ struct virtnet_interrupt_coalesce {
>  };
>
>  struct virtnet_batch_coal {
> +	struct virtio_net_ctrl_hdr hdr;
> +	virtio_net_ctrl_ack status;
> +	__u8 usable;
>  	__le32 num_entries;
>  	struct virtio_net_ctrl_coal_vq coal_vqs[];
>  };
> @@ -299,6 +304,7 @@ struct virtnet_info {
>
>  	/* Work struct for delayed refilling if we run low on memory. */
>  	struct delayed_work refill;
> +	struct delayed_work get_cvq;
>
>  	/* Is delayed refill enabled? */
>  	bool refill_enabled;
> @@ -326,6 +332,7 @@ struct virtnet_info {
>  	bool rx_dim_enabled;
>
>  	/* Interrupt coalescing settings */
> +	int cvq_cmd_nums;
>  	struct virtnet_batch_coal *batch_coal;
>  	struct virtnet_interrupt_coalesce intr_coal_tx;
>  	struct virtnet_interrupt_coalesce intr_coal_rx;
> @@ -2512,6 +2519,46 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
>  	return err;
>  }
>
> +static bool virtnet_process_dim_cmd(struct virtnet_info *vi, void *res)
> +{
> +	struct virtnet_batch_coal *batch_coal;
> +	u16 queue;
> +	int i;
> +
> +	if (res != ((void *)vi)) {
> +		batch_coal = (struct virtnet_batch_coal *)res;
> +		batch_coal->usable = true;
> +		vi->cvq_cmd_nums--;
> +		for (i = 0; i < batch_coal->num_entries; i++) {
> +			queue = batch_coal->coal_vqs[i].vqn / 2;
> +			vi->rq[queue].dim.state = DIM_START_MEASURE;
> +		}
> +	} else {
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool virtnet_cvq_response(struct virtnet_info *vi, bool poll)
> +{
> +	unsigned tmp;
> +	void *res;
> +
> +	if (!poll) {
> +		while ((res = virtqueue_get_buf(vi->cvq, &tmp)) &&
> +		       !virtqueue_is_broken(vi->cvq))
> +			virtnet_process_dim_cmd(vi, res);
> +		return 0;
> +	}
> +
> +	while (!(res = virtqueue_get_buf(vi->cvq, &tmp)) &&
> +	       !virtqueue_is_broken(vi->cvq))
> +		cpu_relax();
> +
> +	return virtnet_process_dim_cmd(vi, res);


How about?

	while (true) {
		res = virtqueue_get_buf(vi->cvq, &tmp);
		if (!res) {
			if (poll) {
				if (virtqueue_is_broken(vi->cvq))
					return 0;

				cpu_relax();
				continue;
			}

			return false;
		}

		if (res == ((void *)vi))
			return true;

		virtnet_process_dim_cmd(vi, res);
	}

Thanks.



> +}
> +
>  /*
>   * Send command via the control virtqueue and check status.  Commands
>   * supported by the hypervisor, as indicated by feature bits, should
> @@ -2521,7 +2568,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  				 struct scatterlist *out)
>  {
>  	struct scatterlist *sgs[4], hdr, stat;
> -	unsigned out_num = 0, tmp;
> +	unsigned out_num = 0;
>  	int ret;
>
>  	/* Caller should know better */
> @@ -2555,9 +2602,9 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  	/* Spin for a response, the kick causes an ioport write, trapping
>  	 * into the hypervisor, so the request should be handled immediately.
>  	 */
> -	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -	       !virtqueue_is_broken(vi->cvq))
> -		cpu_relax();
> +	while (true)
> +		if (virtnet_cvq_response(vi, true))
> +			break;
>
>  	return vi->ctrl->status == VIRTIO_NET_OK;
>  }
> @@ -2709,6 +2756,7 @@ static int virtnet_close(struct net_device *dev)
>  		cancel_work_sync(&vi->rq[i].dim.work);
>  	}
>
> +	cancel_delayed_work_sync(&vi->get_cvq);
>  	return 0;
>  }
>
> @@ -3520,22 +3568,99 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>  	return 0;
>  }
>
> +static bool virtnet_add_dim_command(struct virtnet_info *vi,
> +				    struct virtnet_batch_coal *ctrl)
> +{
> +	struct scatterlist *sgs[4], hdr, stat, out;
> +	unsigned out_num = 0;
> +	int ret;
> +
> +	/* Caller should know better */
> +	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
> +
> +	ctrl->hdr.class = VIRTIO_NET_CTRL_NOTF_COAL;
> +	ctrl->hdr.cmd = VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET;
> +
> +	/* Add header */
> +	sg_init_one(&hdr, &ctrl->hdr, sizeof(ctrl->hdr));
> +	sgs[out_num++] = &hdr;
> +
> +	/* Add body */
> +	sg_init_one(&out, &ctrl->num_entries, sizeof(ctrl->num_entries) +
> +		    ctrl->num_entries * sizeof(struct virtnet_coal_entry));
> +	sgs[out_num++] = &out;
> +
> +	/* Add return status. */
> +	ctrl->status = VIRTIO_NET_OK;
> +	sg_init_one(&stat, &ctrl->status, sizeof(ctrl->status));
> +	sgs[out_num] = &stat;
> +
> +	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> +	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, ctrl, GFP_ATOMIC);
> +	if (ret < 0) {
> +		dev_warn(&vi->vdev->dev, "Failed to add sgs for command vq: %d\n.", ret);
> +		return false;
> +	}
> +
> +	virtqueue_kick(vi->cvq);
> +
> +	ctrl->usable = false;
> +	vi->cvq_cmd_nums++;
> +
> +	return true;
> +}
> +
> +static void get_cvq_work(struct work_struct *work)
> +{
> +	struct virtnet_info *vi =
> +		container_of(work, struct virtnet_info, get_cvq.work);
> +
> +	if (!rtnl_trylock()) {
> +		schedule_delayed_work(&vi->get_cvq, 5);
> +		return;
> +	}
> +
> +	if (!vi->cvq_cmd_nums)
> +		goto ret;
> +
> +	virtnet_cvq_response(vi, false);
> +
> +	if (vi->cvq_cmd_nums)
> +		schedule_delayed_work(&vi->get_cvq, 5);
> +
> +ret:
> +	rtnl_unlock();
> +}
> +
>  static void virtnet_rx_dim_work(struct work_struct *work)
>  {
>  	struct dim *dim = container_of(work, struct dim, work);
>  	struct receive_queue *rq = container_of(dim,
>  			struct receive_queue, dim);
>  	struct virtnet_info *vi = rq->vq->vdev->priv;
> +	struct virtnet_batch_coal *avail_coal;
>  	struct dim_cq_moder update_moder;
> -	struct virtnet_batch_coal *coal = vi->batch_coal;
> -	struct scatterlist sgs;
> -	int i, j = 0;
> +	int i, j = 0, position;
> +	u8 *buf;
>
>  	if (!rtnl_trylock()) {
>  		schedule_work(&dim->work);
>  		return;
>  	}
>
> +	if (vi->cvq_cmd_nums == BATCH_CMD || vi->cvq->num_free < 3 ||
> +	    vi->cvq->num_free <= (virtqueue_get_vring_size(vi->cvq) / 3))
> +		virtnet_cvq_response(vi, true);
> +
> +	for (i = 0; i < BATCH_CMD; i++) {
> +		buf = (u8 *)vi->batch_coal;
> +		position = i * (sizeof(struct virtnet_batch_coal) +
> +				vi->max_queue_pairs * sizeof(struct virtnet_coal_entry));
> +		avail_coal = (struct virtnet_batch_coal *)(&buf[position]);
> +		if (avail_coal->usable)
> +			break;
> +	}
> +
>  	/* Each rxq's work is queued by "net_dim()->schedule_work()"
>  	 * in response to NAPI traffic changes. Note that dim->profile_ix
>  	 * for each rxq is updated prior to the queuing action.
> @@ -3552,30 +3677,26 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>  		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
>  		if (update_moder.usec != rq->intr_coal.max_usecs ||
>  		    update_moder.pkts != rq->intr_coal.max_packets) {
> -			coal->coal_vqs[j].vqn = cpu_to_le16(rxq2vq(i));
> -			coal->coal_vqs[j].coal.max_usecs = cpu_to_le32(update_moder.usec);
> -			coal->coal_vqs[j].coal.max_packets = cpu_to_le32(update_moder.pkts);
> +			avail_coal->coal_vqs[j].vqn = cpu_to_le16(rxq2vq(i));
> +			avail_coal->coal_vqs[j].coal.max_usecs = cpu_to_le32(update_moder.usec);
> +			avail_coal->coal_vqs[j].coal.max_packets = cpu_to_le32(update_moder.pkts);
>  			rq->intr_coal.max_usecs = update_moder.usec;
>  			rq->intr_coal.max_packets = update_moder.pkts;
>  			j++;
> -		}
> +		} else if (dim->state == DIM_APPLY_NEW_PROFILE)
> +			dim->state = DIM_START_MEASURE;
>  	}
>
>  	if (!j)
>  		goto ret;
>
> -	coal->num_entries = cpu_to_le32(j);
> -	sg_init_one(&sgs, coal, sizeof(struct virtnet_batch_coal) +
> -		    j * sizeof(struct virtio_net_ctrl_coal_vq));
> -	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> -				  VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET,
> -				  &sgs))
> -		dev_warn(&vi->vdev->dev, "Failed to add dim command\n.");
> +	avail_coal->num_entries = cpu_to_le32(j);
> +	if (!virtnet_add_dim_command(vi, avail_coal))
> +		goto ret;
>
> -	for (i = 0; i < j; i++) {
> -		rq = &vi->rq[(coal->coal_vqs[i].vqn) / 2];
> -		rq->dim.state = DIM_START_MEASURE;
> -	}
> +	virtnet_cvq_response(vi, false);
> +	if (vi->cvq_cmd_nums)
> +		schedule_delayed_work(&vi->get_cvq, 1);
>
>  ret:
>  	rtnl_unlock();
> @@ -4402,7 +4523,9 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>
>  static int virtnet_alloc_queues(struct virtnet_info *vi)
>  {
> -	int i, len;
> +	struct virtnet_batch_coal *batch_coal;
> +	int i, position;
> +	u8 *buf;
>
>  	if (vi->has_cvq) {
>  		vi->ctrl = kzalloc(sizeof(*vi->ctrl), GFP_KERNEL);
> @@ -4418,13 +4541,21 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>  	if (!vi->rq)
>  		goto err_rq;
>
> -	len = sizeof(struct virtnet_batch_coal) +
> -	      vi->max_queue_pairs * sizeof(struct virtio_net_ctrl_coal_vq);
> -	vi->batch_coal = kzalloc(len, GFP_KERNEL);
> -	if (!vi->batch_coal)
> +	buf = kzalloc(BATCH_CMD * (sizeof(struct virtnet_batch_coal) +
> +		      vi->max_queue_pairs * sizeof(struct virtnet_coal_entry)), GFP_KERNEL);
> +	if (!buf)
>  		goto err_coal;
>
> +	vi->batch_coal = (struct virtnet_batch_coal *)buf;
> +	for (i = 0; i < BATCH_CMD; i++) {
> +		position = i * (sizeof(struct virtnet_batch_coal) +
> +				vi->max_queue_pairs * sizeof(struct virtnet_coal_entry));
> +		batch_coal = (struct virtnet_batch_coal *)(&buf[position]);
> +		batch_coal->usable = true;
> +	}
> +
>  	INIT_DELAYED_WORK(&vi->refill, refill_work);
> +	INIT_DELAYED_WORK(&vi->get_cvq, get_cvq_work);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		vi->rq[i].pages = NULL;
>  		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
> --
> 1.8.3.1
>

