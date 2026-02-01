Return-Path: <netdev+bounces-255676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QxHiNjnAf2ncxAIAu9opvQ
	(envelope-from <netdev+bounces-255676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 22:06:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33814C73F6
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 22:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66AF930063A3
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6A2D97BB;
	Sun,  1 Feb 2026 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN4RfNF0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028C239E9A
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769979958; cv=none; b=GF3VL0/BJmHjGhjAZptxN9PmH1IoMDlm1aYAn7vaxRdp8UxU+FoYYxeVDxH5oAMi6PeUrUemP51IjLCIhhoHot5jFLA1Wyu57uKIOXW1fERfDi0gOV8amhrF4j2ItGPgFWZ4pSnlcDta6kNn2F2ZZctbsHyHrhhlG1A54iJ4Rrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769979958; c=relaxed/simple;
	bh=cUPx5Q7xx6Jy2wsnxLkWAR5IwZgcpNJobVR4vZaUMPs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qcoqYu2D7SLDdqNOWTjrfHxSeDqUJ0zcsahAqpP5cWDqWxXAIKAqo9oTyUL90vRnwrZbpsJgntB15dDnuB2sQ0upCmC30MsK+dgoigILdkmxYjDOt8HiGOaTcaKAt9BIwWRX/xSkBDsyyDR2ogJx4mL/UIJxaOGOngVpAB01W3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN4RfNF0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-794cbd4bb51so4451327b3.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769979956; x=1770584756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UUAg8v3MGxJ4llU6RoqAdqIKbKp0wnYdA7XJKJYYMs=;
        b=LN4RfNF0zd5dh6Qq3Rk5EtNu6FIpHrq9Y5Ytnu8ntxEEGlCflEB8S3sHSVCBnNYyEX
         4cr6mRMy82zKq/zoBNXW5aDSw44RjwgcgtsBEpBZ+WX5WlYIMxmYW2L/Ot/sUQHE8UXw
         aNDfUzIM34Mo51O9A63guF4izcunckDkclEqbKRiOJAcLiMul/pAu7OgF0tfHUrMXDNK
         TNOBZtG4Xf6L49niM2A2ARdhgME6KrlPs4QCRHOxNAxT5GbSbNktVyc2w6OYYE50PPTd
         qdXidROW2xtOnrkhL1qePJ08NknRlCTv54BteENNwKJbrIJVW3TnpgoJplcva0jg1QH6
         3rnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769979956; x=1770584756;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UUAg8v3MGxJ4llU6RoqAdqIKbKp0wnYdA7XJKJYYMs=;
        b=fGMlZBA74Zjwyglxxe+vBP+SI7s6y9vhYYD9UzAE5SviQonyJVNyJ9WaVCuA5sN+oW
         TJma7upcpbJeZeB3/hszZMshD3rt9vxt627pnKP7B1uo5oLf5CqxfEgreIgIxNFAhoQ+
         fFFIlBBl3flKGs4RExW7rhidxQv8Gz0j/tW5kTrdFg0STRFy4NLfZ9q+6mWxOQnJyhri
         lEs/ZGc8y5pTqOlWdO7lIS8G513xrOFpl9BeAEaBDv3vMH1XLxaKsKsIDsfBOaKlJ1Bn
         LEIRdKremXs2PfFb59LW3+4ZVpCt2vNhA/akOBgSIkKTgD08xJoqxnonZPIsytTNZR5C
         bXEw==
X-Forwarded-Encrypted: i=1; AJvYcCWrf/zZ5ZuG+02bgn5pd/4hXsfk0vLPKi8eAfw3X2sxu8lt8gMSqBw+KZBphlaClBcUChBuaRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAMKILFBxmDSftYKBugEYDnneI9S/uQAiWBBBO32PtmftsAnAW
	BBu+hYegCVo7NtZv+HHKCOn7iusjWPTAFMrgxuVZGG0djdT4vtNuowxw
X-Gm-Gg: AZuq6aKUspDEvoW2M6XL3VsaWNUpy8UGlVlssxxxygpuNfNDnwDYtQpJT5WD2pak7AK
	FupHrv82yBQQucCePpYFeJvAUWsHaSY+PM3MXzTJbcaZafeQZIfU5PSqmWgvyF/nXzNuYJ3D6ob
	FiFWDnj1p7J01WqiG+nvtEvFH+/xSmV5iqIwCPkWhqF8AuQh/V4KWkTC0JATHA/o2ZZiCMh+ncv
	nFe9DCQywegqshyQdyLADgHpIQR50xZ2pSg5B2MeTkRMzU9dUth1+qHAu5yYejUile2KeDwKI0b
	oeGNgwX6gHGl4p2ecyagjyRTL6dLUKzk6EM33rz+omcH/OqlvOILGkIe3OrFlNz7s0qFTz4E/Vg
	lHjwGIfG3XW5ecJvhgl+uFiJT8r8yzmYHcmksW7BFeuoerSBdsoYAxy3e4PpwRxwPw177sADQ/a
	SPJs9OfVLP/P/VbPsPiiAAo63B67gloZXjiVV+Z6KBmBOFRO+logwhHxxnNEw=
X-Received: by 2002:a05:690c:c4f5:b0:794:c6fa:156e with SMTP id 00721157ae682-794c6fa23d7mr23841487b3.56.1769979955928;
        Sun, 01 Feb 2026 13:05:55 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794828cb2f7sm68895277b3.43.2026.02.01.13.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 13:05:55 -0800 (PST)
Date: Sun, 01 Feb 2026 16:05:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Message-ID: <willemdebruijn.kernel.37516e24f10fa@gmail.com>
In-Reply-To: <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255676-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33814C73F6
X-Rspamd-Action: no action

Steffen Trumtrar wrote:
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

Jason, Michael: creating a new struct for every field is not very
elegant. Is it time to find a more forward looking approach to
expanding with new fields? Like a TLV, or how netlink structs like
tcp_info are extended with support for legacy users that only use
a truncated struct?

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

It's fine to implement filters, but also fine to only support ALL or
NONE for simplicity.

In the end it probably depends on what the underlying physical device
supports.

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

Why the multiple fields, rather than u64.

More broadly: can my old patchset be dusted off as is. Does it require
significant changes?

I only paused it at the time, because I did not have a real device
back-end that was going to support it.

> +
>  #ifndef VIRTIO_NET_NO_LEGACY
>  /* This header comes first in the scatter-gather list.
>   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
> 
> -- 
> 2.52.0
> 



