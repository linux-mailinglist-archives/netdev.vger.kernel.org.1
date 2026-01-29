Return-Path: <netdev+bounces-254677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OPRA70te2mbCAIAu9opvQ
	(envelope-from <netdev+bounces-254677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:51:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCEAAE46C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CF7D30028FB
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9552377573;
	Thu, 29 Jan 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OMNFC21b"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4A37107A;
	Thu, 29 Jan 2026 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680308; cv=none; b=uUG5n8ZfI3S0WyBJLJIeTTYX5WGvK4U5Infejc10pNxGtiU/QxuU335hPVOTrFcRHRQqAI2J3+8GNp1j0JpIdviaP3DespfXrYqgOtpNZZ4tJ53loSa0pIQf8XJsrSHP8GBMnOGzbQ6AKK9DHHydgSSUZt82caf9wzFn753h93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680308; c=relaxed/simple;
	bh=55fkgyMa5KZnkX57ju+SGbrWhY3WOJUg/JpVndE1Cso=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=UK+Ko/hf6LGIdg4n2bGgaOeNKjDs1c2Dbb+LuefxonheqtIZ6gny7/WcN0yCsrttlp7nme8OvyF3aXcAFgUxwgb8x6pKemQj8BBADhLxO+H0VwCpqlnVKY/KZV6ByboTf3fI/klJmi/adsLY9xzBQE08izOm4yJNS96U5J5DTyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OMNFC21b; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769680302; h=Message-ID:Subject:Date:From:To;
	bh=pEppn9QCwRC6bHz8KvmcpcbUTlzm4KOe0Qh7ji/Rg5s=;
	b=OMNFC21bfpELHSg3juK82EiygxXQa5+m8L54C9S1GNHGMglhV+nfkGm2nGYPFZjYf0g/JbzPp2kcA9//2cA1vUheexPGRtFtM8c5Pwo0a3Vjsl+YZQxco6rfpDJsF+ACG/fVxMW3UnO7j9U66R+3byA3komyiD3FA9tdHUFq4Xs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wy7.EFS_1769680302 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 17:51:42 +0800
Message-ID: <1769680105.7884188-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Date: Thu, 29 Jan 2026 17:48:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
In-Reply-To: <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,pengutronix.de,redhat.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254677-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 2BCEAAE46C
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 09:06:42 +0100, Steffen Trumtrar <s.trumtrar@pengutronix.de> wrote:
> Add optional hardware rx timestamp offload for virtio-net.
>
> Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> virtio-net header is expanded with room for a timestamp.
>
> To get and set the hwtstamp the functions ndo_hwtstamp_set/get need
> to be implemented. This allows filtering the packets and only time stamp
> the packets where the filter matches. This way, the timestamping can
> be en/disabled at runtime.
>
> Tested:
>   guest: ./timestamping eth0 \
>           SOF_TIMESTAMPING_RAW_HARDWARE \
>           SOF_TIMESTAMPING_RX_HARDWARE
>   host: nc -4 -u 192.168.1.1 319
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> --
>   Changes to last version:
>   - rework series to use flow filters
>   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
>   - original work done by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_net.h |   9 +++
>  2 files changed, 133 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -429,6 +429,9 @@ struct virtnet_info {
>  	struct virtio_net_rss_config_trailer rss_trailer;
>  	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>
> +	/* Device passes time stamps from the driver */
> +	bool has_tstamp;
> +
>  	/* Has control virtqueue */
>  	bool has_cvq;
>
> @@ -475,6 +478,8 @@ struct virtnet_info {
>
>  	struct control_buf *ctrl;
>
> +	struct kernel_hwtstamp_config tstamp_config;
> +
>  	/* Ethtool settings */
>  	u8 duplex;
>  	u32 speed;
> @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
>  		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
>  		struct virtio_net_hdr_v1_hash hash_v1_hdr;
>  		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> +		struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
>  	};
>  };
>
> @@ -682,6 +688,13 @@ skb_vnet_common_hdr(struct sk_buff *skb)
>  	return (struct virtio_net_common_hdr *)skb->cb;
>  }
>
> +static inline struct virtio_net_hdr_v1_hash_tunnel_ts *skb_vnet_hdr_ts(struct sk_buff *skb)
> +{
> +	BUILD_BUG_ON(sizeof(struct virtio_net_hdr_v1_hash_tunnel_ts) > sizeof(skb->cb));
> +
> +	return (void *)skb->cb;
> +}
> +
>  /*
>   * private is used to chain pages for big packets, put the whole
>   * most recent used list in the beginning for reuse
> @@ -2560,6 +2573,15 @@ virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
>  		(__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
>  }
>
> +static inline u64
> +virtio_net_tstamp_value(const struct virtio_net_hdr_v1_hash_tunnel_ts *hdr_hash_ts)
> +{
> +	return  (u64)__le16_to_cpu(hdr_hash_ts->tstamp_0) |
> +	       ((u64)__le16_to_cpu(hdr_hash_ts->tstamp_1) << 16) |
> +	       ((u64)__le16_to_cpu(hdr_hash_ts->tstamp_2) << 32) |
> +	       ((u64)__le16_to_cpu(hdr_hash_ts->tstamp_3) << 48);
> +}
> +
>  static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
>  				struct sk_buff *skb)
>  {
> @@ -2589,6 +2611,18 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
>  	skb_set_hash(skb, virtio_net_hash_value(hdr_hash), rss_hash_type);
>  }
>
> +static inline void virtnet_record_rx_tstamp(const struct virtnet_info *vi,
> +					    struct sk_buff *skb)
> +{
> +	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> +	const struct virtio_net_hdr_v1_hash_tunnel_ts *h = skb_vnet_hdr_ts(skb);
> +	u64 ts;
> +
> +	ts = virtio_net_tstamp_value(h);
> +	memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
> +	shhwtstamps->hwtstamp = ns_to_ktime(ts);
> +}
> +
>  static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>  				 struct sk_buff *skb, u8 flags)
>  {
> @@ -2617,6 +2651,8 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>  		goto frame_err;
>  	}
>
> +	if (vi->has_tstamp && vi->tstamp_config.rx_filter != HWTSTAMP_FILTER_NONE)
> +		virtnet_record_rx_tstamp(vi, skb);
>  	skb_record_rx_queue(skb, vq2rxq(rq->vq));
>  	skb->protocol = eth_type_trans(skb, dev);
>  	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> @@ -3321,7 +3357,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  {
>  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
> -	struct virtio_net_hdr_v1_hash_tunnel *hdr;
> +	struct virtio_net_hdr_v1_hash_tunnel_ts *hdr;
>  	int num_sg;
>  	unsigned hdr_len = vi->hdr_len;
>  	bool can_push;
> @@ -3329,8 +3365,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>
>  	/* Make sure it's safe to cast between formats */
> -	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr));
> -	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr.hdr));
> +	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->tnl.hash_hdr));
> +	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->tnl.hash_hdr.hdr));
>
>  	can_push = vi->any_header_sg &&
>  		!((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
> @@ -3338,18 +3374,18 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  	/* Even if we can, don't push here yet as this would skew
>  	 * csum_start offset below. */
>  	if (can_push)
> -		hdr = (struct virtio_net_hdr_v1_hash_tunnel *)(skb->data -
> -							       hdr_len);
> +		hdr = (struct virtio_net_hdr_v1_hash_tunnel_ts *)(skb->data -
> +								  hdr_len);
>  	else
> -		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
> +		hdr = &skb_vnet_common_hdr(skb)->ts_hdr;
>
> -	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> +	if (virtio_net_hdr_tnl_from_skb(skb, &hdr->tnl, vi->tx_tnl,
>  					virtio_is_little_endian(vi->vdev), 0,
>  					false))
>  		return -EPROTO;
>
>  	if (vi->mergeable_rx_bufs)
> -		hdr->hash_hdr.hdr.num_buffers = 0;
> +		hdr->tnl.hash_hdr.hdr.num_buffers = 0;
>
>  	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
>  	if (can_push) {
> @@ -5563,6 +5599,22 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
>  	return 0;
>  }
>
> +static int virtnet_get_ts_info(struct net_device *dev,
> +			       struct kernel_ethtool_ts_info *info)
> +{
> +	/* setup default software timestamp */
> +	ethtool_op_get_ts_info(dev, info);
> +
> +	info->rx_filters = (BIT(HWTSTAMP_FILTER_NONE) |
> +			    BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
> +			    BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
> +			    BIT(HWTSTAMP_FILTER_ALL));
> +
> +	info->tx_types = HWTSTAMP_TX_OFF;
> +
> +	return 0;
> +}
> +
>  static void virtnet_init_settings(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -5658,7 +5710,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.get_ethtool_stats = virtnet_get_ethtool_stats,
>  	.set_channels = virtnet_set_channels,
>  	.get_channels = virtnet_get_channels,
> -	.get_ts_info = ethtool_op_get_ts_info,
> +	.get_ts_info = virtnet_get_ts_info,
>  	.get_link_ksettings = virtnet_get_link_ksettings,
>  	.set_link_ksettings = virtnet_set_link_ksettings,
>  	.set_coalesce = virtnet_set_coalesce,
> @@ -6242,6 +6294,58 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
>  		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
>  }
>
> +static int virtnet_hwtstamp_get(struct net_device *dev,
> +				struct kernel_hwtstamp_config *tstamp_config)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +
> +	if (!netif_running(dev))
> +		return -EINVAL;
> +
> +	*tstamp_config = vi->tstamp_config;
> +
> +	return 0;
> +}
> +
> +static int virtnet_hwtstamp_set(struct net_device *dev,
> +				struct kernel_hwtstamp_config *tstamp_config,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +
> +	if (!netif_running(dev))
> +		return -EINVAL;
> +
> +	switch (tstamp_config->rx_filter) {
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +		tstamp_config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> +		break;
> +	case HWTSTAMP_FILTER_NONE:
> +		break;
> +	case HWTSTAMP_FILTER_ALL:
> +		tstamp_config->rx_filter = HWTSTAMP_FILTER_ALL;
> +		break;
> +	default:
> +		tstamp_config->rx_filter = HWTSTAMP_FILTER_ALL;
> +		return -ERANGE;
> +	}
> +
> +	vi->tstamp_config = *tstamp_config;
> +
> +	return 0;
> +}
> +
>  static int virtnet_init_irq_moder(struct virtnet_info *vi)
>  {
>  	u8 profile_flags = 0, coal_flags = 0;
> @@ -6289,6 +6393,8 @@ static const struct net_device_ops virtnet_netdev = {
>  	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
>  	.ndo_set_features	= virtnet_set_features,
>  	.ndo_tx_timeout		= virtnet_tx_timeout,
> +	.ndo_hwtstamp_set	= virtnet_hwtstamp_set,
> +	.ndo_hwtstamp_get	= virtnet_hwtstamp_get,
>  };
>
>  static void virtnet_config_changed_work(struct work_struct *work)
> @@ -6911,6 +7017,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>  		vi->has_rss_hash_report = true;
>
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_TSTAMP))
> +		vi->has_tstamp = true;
> +
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
>  		vi->has_rss = true;
>
> @@ -6945,8 +7054,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
>  	}
>
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
> +	if (vi->has_tstamp)
> +		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel_ts);
> +	else if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
> +		 virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
>  		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
>  	else if (vi->has_rss_hash_report)
>  		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
> @@ -7269,7 +7380,8 @@ static struct virtio_device_id id_table[] = {
>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
>  	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
>  	VIRTIO_NET_F_VQ_NOTF_COAL, \
> -	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
> +	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS, \
> +	VIRTIO_NET_F_TSTAMP
>
>  static unsigned int features[] = {
>  	VIRTNET_FEATURES,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 1db45b01532b5..9f967575956b8 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_TSTAMP	  49	/* Device sends TAI receive time */
>  #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
>  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
> @@ -215,6 +216,14 @@ struct virtio_net_hdr_v1_hash_tunnel {
>  	__le16 inner_nh_offset;
>  };
>
> +struct virtio_net_hdr_v1_hash_tunnel_ts {
> +	struct virtio_net_hdr_v1_hash_tunnel tnl;
> +	__le16 tstamp_0;
> +	__le16 tstamp_1;
> +	__le16 tstamp_2;
> +	__le16 tstamp_3;
> +};


Since patch #1 used this struct, this one should be placed first in the series.
Also, has the virtio specification process accepted such a draft proposal?

Thanks


> +
>  #ifndef VIRTIO_NET_NO_LEGACY
>  /* This header comes first in the scatter-gather list.
>   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
>
> --
> 2.52.0
>

