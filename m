Return-Path: <netdev+bounces-92693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659E28B8458
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 04:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB5028388E
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 02:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD90210A2B;
	Wed,  1 May 2024 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sar+UtNa"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B84437
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714530341; cv=none; b=mkomOHc0yN6biQ5vTMYRHZj6HFbF0HStWb18oWYZa3bQWjhdaXU+OdVNZrSJgjqgXXC6k7oUar/HzrJ/klsBaZm/mEYee7CMX2JH9QcTjuDjjf6I3xVzw6zq5pGhRymNnswnGVSeoQFn1jQ80jmRfA1EtWd8Uz7R/SMdMwIC/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714530341; c=relaxed/simple;
	bh=Co6/QgXgK3gwRjvKiz0r7BVqBfj4a9CRJWGg0I3Q+RI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=LwWzgFgMLB/mEYBC1UOQ8wknL6BhjvT4RDoLZR5XLBa0AC8njw4s2aJO3S9eOjCD/uvdhEE2XabdG/mx6QdXx+sJMgpUB5EoS4zq0aB/l62nrbQ0Jn8ta62rM+uxYAHG7iHy8MC4CaL+BuS0IHDlIJf9MELIXN8BCj6IK2uxc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sar+UtNa; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714530331; h=Message-ID:Subject:Date:From:To;
	bh=olWaF8ImN/d9b/PDr3bc/b75qVo9e0+R4o2a4x1KaB0=;
	b=sar+UtNaVjR2f2Ks6IqVeHeGRjl0NiZjuKWzpz1upgR+QTOeYwnr/8Yo/Y+wi/Kr6uH5nsNLx0urpEX/bKODjM/0eRRrpkFqhZrhX7toO6ljhVKhrN2bM53tGhuQ6dzdd67U7x+hDnP/yZXhlssbXaLLc1192z/OGKx4OQkyElU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5dhl1V_1714530329;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5dhl1V_1714530329)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 10:25:30 +0800
Message-ID: <1714530132.167469-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 2/6] virtio_net: Remove command data from control_buf
Date: Wed, 1 May 2024 10:22:12 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <virtualization@lists.linux.dev>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <pabeni@redhat.com>,
 <jiri@nvidia.com>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>
References: <20240423035746.699466-1-danielj@nvidia.com>
 <20240423035746.699466-3-danielj@nvidia.com>
In-Reply-To: <20240423035746.699466-3-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 23 Apr 2024 06:57:42 +0300, Daniel Jurgens <danielj@nvidia.com> wrote:
> Allocate memory for the data when it's used. Ideally the could be on the
> stack, but we can't DMA stack memory. With this change only the header
> and status memory are shared between commands, which will allow using a
> tighter lock than RTNL.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 111 ++++++++++++++++++++++++++-------------
>  1 file changed, 75 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7248dae54e1c..0ee192b45e1e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -240,14 +240,6 @@ struct virtio_net_ctrl_rss {
>  struct control_buf {
>  	struct virtio_net_ctrl_hdr hdr;
>  	virtio_net_ctrl_ack status;
> -	struct virtio_net_ctrl_mq mq;
> -	u8 promisc;
> -	u8 allmulti;
> -	__virtio16 vid;
> -	__virtio64 offloads;
> -	struct virtio_net_ctrl_coal_tx coal_tx;
> -	struct virtio_net_ctrl_coal_rx coal_rx;
> -	struct virtio_net_ctrl_coal_vq coal_vq;

Since Xuan's device-stats series was merged before, please remember
to rebase the net-next branch in the next version.

Thanks!

>  };
>  
>  struct virtnet_info {
> @@ -2672,14 +2664,19 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
>  
>  static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  {
> +	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>  	struct scatterlist sg;
>  	struct net_device *dev = vi->dev;
>  
>  	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>  		return 0;
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
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
>  				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg)) {
> @@ -2708,6 +2705,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  
>  static int virtnet_close(struct net_device *dev)
>  {
> +	u8 *promisc_allmulti  __free(kfree) = NULL;
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
>  
> @@ -2732,6 +2730,7 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  	struct scatterlist sg[2];
>  	struct virtio_net_ctrl_mac *mac_data;
>  	struct netdev_hw_addr *ha;
> +	u8 *promisc_allmulti;
>  	int uc_count;
>  	int mc_count;
>  	void *buf;
> @@ -2743,22 +2742,27 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  
>  	rtnl_lock();
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
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
>  				  VIRTIO_NET_CTRL_RX_PROMISC, sg))
>  		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
> -			 vi->ctrl->promisc ? "en" : "dis");
> +			 *promisc_allmulti ? "en" : "dis");
>  
> -	sg_init_one(sg, &vi->ctrl->allmulti, sizeof(vi->ctrl->allmulti));
> +	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
> +	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>  
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
>  				  VIRTIO_NET_CTRL_RX_ALLMULTI, sg))
>  		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
> -			 vi->ctrl->allmulti ? "en" : "dis");
> +			 *promisc_allmulti ? "en" : "dis");
>  
>  	netif_addr_lock_bh(dev);
>  
> @@ -2819,10 +2823,15 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
>  				   __be16 proto, u16 vid)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	__virtio16 *_vid __free(kfree) = NULL;
>  	struct scatterlist sg;
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
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
>  				  VIRTIO_NET_CTRL_VLAN_ADD, &sg))
> @@ -2834,10 +2843,15 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
>  				    __be16 proto, u16 vid)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	__virtio16 *_vid __free(kfree) = NULL;
>  	struct scatterlist sg;
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
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
>  				  VIRTIO_NET_CTRL_VLAN_DEL, &sg))
> @@ -2950,12 +2964,17 @@ static void virtnet_cpu_notif_remove(struct virtnet_info *vi)
>  static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
>  					 u16 vqn, u32 max_usecs, u32 max_packets)
>  {
> +	struct virtio_net_ctrl_coal_vq *coal_vq __free(kfree) = NULL;
>  	struct scatterlist sgs;
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
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>  				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> @@ -3101,11 +3120,15 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>  
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
>  				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
> -				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
> -		dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
> -		return false;
> -	}
> +				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs))
> +		goto err;
> +
>  	return true;
> +
> +err:
> +	dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
> +	return false;
> +
>  }
>  
>  static void virtnet_init_default_rss(struct virtnet_info *vi)
> @@ -3410,12 +3433,17 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
>  static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
>  					  struct ethtool_coalesce *ec)
>  {
> +	struct virtio_net_ctrl_coal_tx *coal_tx __free(kfree) = NULL;
>  	struct scatterlist sgs_tx;
>  	int i;
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
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>  				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
> @@ -3435,6 +3463,7 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
>  static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  					  struct ethtool_coalesce *ec)
>  {
> +	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
>  	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
>  	struct scatterlist sgs_rx;
>  	int i;
> @@ -3453,6 +3482,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  		return 0;
>  	}
>  
> +	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
> +	if (!coal_rx)
> +		return -ENOMEM;
> +
>  	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
>  		vi->rx_dim_enabled = false;
>  		for (i = 0; i < vi->max_queue_pairs; i++)
> @@ -3463,9 +3496,9 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  	 * we need apply the global new params even if they
>  	 * are not updated.
>  	 */
> -	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
> -	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
> -	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
> +	coal_rx->rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
> +	coal_rx->rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
> +	sg_init_one(&sgs_rx, coal_rx, sizeof(*coal_rx));
>  
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>  				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> @@ -3951,10 +3984,16 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  
>  static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
>  {
> +	__virtio64 *_offloads __free(kfree) = NULL;
>  	struct scatterlist sg;
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
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
>  				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
> -- 
> 2.34.1
> 
> 

