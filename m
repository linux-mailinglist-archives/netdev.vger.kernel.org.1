Return-Path: <netdev+bounces-81919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E987B88BAF1
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 08:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3071AB221E3
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFC312AAEC;
	Tue, 26 Mar 2024 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mNIVnv9k"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C3129E99
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436814; cv=none; b=b6CIWFcevZqeLLonywMUUtVFrl55qTWYxJlTMEIn0sYFKO+64Ynyw24Pdkc28BuGCUCW0gdgTFfhmTr9xLkkj62Ljq/LY7jx+eknCyJ4v1ZtTnOm0Efh2Kgb+0sWg/dBaDPnm4qMxU6PcH3cTdNiwJgyl65AI7So4KjWOW1FALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436814; c=relaxed/simple;
	bh=SM7/wtXj4RB89IBwhHF+vcoa0LZcbSXCiJQJjk9y3IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9/y61Nepd2XuOsyRYarpgkFWw6nvw6ns+UgmCdnPlJ6IfxZFfd84qflLRy+KEsD/WzMjzH6Jxq7wwUaN5gMTL93GuH2iA8gramNSIE6Dz6UqlZXv7C1YhId1p2lhcYdL2XnM/6bDIZe2WIy8aslC1guFjpGFUtJfX4Y3yRB3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mNIVnv9k; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711436804; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/0QlwJ2edQh7Sh9ibZNTAZPbKA98FsDhFB636sT2f4I=;
	b=mNIVnv9kUhjDHvmvPS+AkZeT/nB0Gus7ayPdLQd0tFtKBbwkTX2JAGFmEhmLJYAxnx7a5jai1vGGKr9EeGgXK0AKQtayI+Li4KzR6ZuvZqQ+TUn60h6XYoxuHjVNx6pA1yhdzq6p1iSvUgOUHKTehnohR+CBflvRgN1Hepx5lYU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3K38sE_1711436800;
Received: from 30.221.149.28(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3K38sE_1711436800)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 15:06:43 +0800
Message-ID: <413cc507-4cd0-431a-8efb-fab09cb2d490@linux.alibaba.com>
Date: Tue, 26 Mar 2024 15:06:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] virtio_net: Remove command data from
 control_buf
To: Daniel Jurgens <danielj@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
References: <20240325214912.323749-1-danielj@nvidia.com>
 <20240325214912.323749-3-danielj@nvidia.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240325214912.323749-3-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/26 上午5:49, Daniel Jurgens 写道:
> Allocate memory for the data when it's used. Ideally the could be on the
> stack, but we can't DMA stack memory. With this change only the header
> and status memory are shared between commands, which will allow using a
> tighter lock than RTNL.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   drivers/net/virtio_net.c | 110 ++++++++++++++++++++++++++-------------
>   1 file changed, 74 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7419a68cf6e2..6780479a1e6c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -235,14 +235,6 @@ struct virtio_net_ctrl_rss {
>   struct control_buf {
>   	struct virtio_net_ctrl_hdr hdr;
>   	virtio_net_ctrl_ack status;
> -	struct virtio_net_ctrl_mq mq;
> -	u8 promisc;
> -	u8 allmulti;
> -	__virtio16 vid;
> -	__virtio64 offloads;
> -	struct virtio_net_ctrl_coal_tx coal_tx;
> -	struct virtio_net_ctrl_coal_rx coal_rx;
> -	struct virtio_net_ctrl_coal_vq coal_vq;
>   };
>   
>   struct virtnet_info {
> @@ -2654,14 +2646,19 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
>   
>   static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>   {
> +	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>   	struct scatterlist sg;
>   	struct net_device *dev = vi->dev;
>   
>   	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>   		return 0;
>   
> -	vi->ctrl->mq.virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
> -	sg_init_one(&sg, &vi->ctrl->mq, sizeof(vi->ctrl->mq));
> +	mq = kzalloc(sizeof(*mq), GFP_KERNEL);
> +	if (!mq)
> +		return -ENOMEM;
> +
> +	mq->virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
> +	sg_init_one(&sg, mq, sizeof(*mq));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
>   				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg)) {
> @@ -2708,6 +2705,7 @@ static int virtnet_close(struct net_device *dev)
>   
>   static void virtnet_set_rx_mode(struct net_device *dev)

You need to rebase next branch in the next version,
.ndo_set_rx_mode has been completed using workqueue in that.

Regards,
Heng

>   {
> +	u8 *promisc_allmulti  __free(kfree) = NULL;
>   	struct virtnet_info *vi = netdev_priv(dev);
>   	struct scatterlist sg[2];
>   	struct virtio_net_ctrl_mac *mac_data;
> @@ -2721,22 +2719,27 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>   	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>   		return;
>   
> -	vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
> -	vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
> +	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
> +	if (!promisc_allmulti) {
> +		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
> +		return;
> +	}
>   
> -	sg_init_one(sg, &vi->ctrl->promisc, sizeof(vi->ctrl->promisc));
> +	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
> +	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
>   				  VIRTIO_NET_CTRL_RX_PROMISC, sg))
>   		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
> -			 vi->ctrl->promisc ? "en" : "dis");
> +			 *promisc_allmulti ? "en" : "dis");
>   
> -	sg_init_one(sg, &vi->ctrl->allmulti, sizeof(vi->ctrl->allmulti));
> +	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
> +	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
>   				  VIRTIO_NET_CTRL_RX_ALLMULTI, sg))
>   		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
> -			 vi->ctrl->allmulti ? "en" : "dis");
> +			 *promisc_allmulti ? "en" : "dis");
>   
>   	uc_count = netdev_uc_count(dev);
>   	mc_count = netdev_mc_count(dev);
> @@ -2780,10 +2783,15 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
>   				   __be16 proto, u16 vid)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
> +	__virtio16 *_vid __free(kfree) = NULL;
>   	struct scatterlist sg;
>   
> -	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
> -	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
> +	_vid = kzalloc(sizeof(*_vid), GFP_KERNEL);
> +	if (!_vid)
> +		return -ENOMEM;
> +
> +	*_vid = cpu_to_virtio16(vi->vdev, vid);
> +	sg_init_one(&sg, _vid, sizeof(*_vid));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
>   				  VIRTIO_NET_CTRL_VLAN_ADD, &sg))
> @@ -2795,10 +2803,15 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
>   				    __be16 proto, u16 vid)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
> +	__virtio16 *_vid __free(kfree) = NULL;
>   	struct scatterlist sg;
>   
> -	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
> -	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
> +	_vid = kzalloc(sizeof(*_vid), GFP_KERNEL);
> +	if (!_vid)
> +		return -ENOMEM;
> +
> +	*_vid = cpu_to_virtio16(vi->vdev, vid);
> +	sg_init_one(&sg, _vid, sizeof(*_vid));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
>   				  VIRTIO_NET_CTRL_VLAN_DEL, &sg))
> @@ -2911,12 +2924,17 @@ static void virtnet_cpu_notif_remove(struct virtnet_info *vi)
>   static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>   					 u16 vqn, u32 max_usecs, u32 max_packets)
>   {
> +	struct virtio_net_ctrl_coal_vq *coal_vq __free(kfree) = NULL;
>   	struct scatterlist sgs;
>   
> -	vi->ctrl->coal_vq.vqn = cpu_to_le16(vqn);
> -	vi->ctrl->coal_vq.coal.max_usecs = cpu_to_le32(max_usecs);
> -	vi->ctrl->coal_vq.coal.max_packets = cpu_to_le32(max_packets);
> -	sg_init_one(&sgs, &vi->ctrl->coal_vq, sizeof(vi->ctrl->coal_vq));
> +	coal_vq = kzalloc(sizeof(*coal_vq), GFP_KERNEL);
> +	if (!coal_vq)
> +		return -ENOMEM;
> +
> +	coal_vq->vqn = cpu_to_le16(vqn);
> +	coal_vq->coal.max_usecs = cpu_to_le32(max_usecs);
> +	coal_vq->coal.max_packets = cpu_to_le32(max_packets);
> +	sg_init_one(&sgs, coal_vq, sizeof(*coal_vq));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>   				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> @@ -3062,11 +3080,15 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
>   				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
> -				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
> -		dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
> -		return false;
> -	}
> +				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs))
> +		goto err;
> +
>   	return true;
> +
> +err:
> +	dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
> +	return false;
> +
>   }
>   
>   static void virtnet_init_default_rss(struct virtnet_info *vi)
> @@ -3371,12 +3393,17 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
>   static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
>   					  struct ethtool_coalesce *ec)
>   {
> +	struct virtio_net_ctrl_coal_tx *coal_tx __free(kfree) = NULL;
>   	struct scatterlist sgs_tx;
>   	int i;
>   
> -	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
> -	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
> -	sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
> +	coal_tx = kzalloc(sizeof(*coal_tx), GFP_KERNEL);
> +	if (!coal_tx)
> +		return -ENOMEM;
> +
> +	coal_tx->tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
> +	coal_tx->tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
> +	sg_init_one(&sgs_tx, coal_tx, sizeof(*coal_tx));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>   				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
> @@ -3396,6 +3423,7 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
>   static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>   					  struct ethtool_coalesce *ec)
>   {
> +	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
>   	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
>   	struct scatterlist sgs_rx;
>   	int i;
> @@ -3414,6 +3442,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>   		return 0;
>   	}
>   
> +	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
> +	if (!coal_rx)
> +		return -ENOMEM;
> +
>   	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
>   		vi->rx_dim_enabled = false;
>   		for (i = 0; i < vi->max_queue_pairs; i++)
> @@ -3424,9 +3456,9 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>   	 * we need apply the global new params even if they
>   	 * are not updated.
>   	 */
> -	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
> -	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
> -	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
> +	coal_rx->rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
> +	coal_rx->rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
> +	sg_init_one(&sgs_rx, coal_rx, sizeof(*coal_rx));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>   				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> @@ -3893,10 +3925,16 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>   
>   static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
>   {
> +	u64 *_offloads __free(kfree) = NULL;
>   	struct scatterlist sg;
> -	vi->ctrl->offloads = cpu_to_virtio64(vi->vdev, offloads);
>   
> -	sg_init_one(&sg, &vi->ctrl->offloads, sizeof(vi->ctrl->offloads));
> +	_offloads = kzalloc(sizeof(*_offloads), GFP_KERNEL);
> +	if (!_offloads)
> +		return -ENOMEM;
> +
> +	*_offloads = cpu_to_virtio64(vi->vdev, offloads);
> +
> +	sg_init_one(&sg, _offloads, sizeof(*_offloads));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
>   				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {


