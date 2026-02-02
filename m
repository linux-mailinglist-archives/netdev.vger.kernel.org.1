Return-Path: <netdev+bounces-255773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHjJJ3NZgGns6wIAu9opvQ
	(envelope-from <netdev+bounces-255773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:59:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C94D9C96DB
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6038F3001A42
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 07:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE8308F03;
	Mon,  2 Feb 2026 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFDR2SBR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORG2d99t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AA62F0C5B
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019181; cv=none; b=TJlIU4dAbsQjh4QWe49n4rih7n5nMk6fw/ASFDv4BuBbs5zDsGSyE6kHeCFcNHReHQHQnq7UUsazASCu8ZRCy1nNN9tInEXq7y7FJUuyZKUDdX2fXbo+QA2Cvbee/sRNU1ay9mG67/7eBq5gFGC4Ik2JCpHYRUVq9Bn4NkTkCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019181; c=relaxed/simple;
	bh=gjneGoWxHALdU8GQA1yNRD5tWtF45ZQOghEiHUhCkhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNIaV3X/Y6Yd+iNAnw0UohssjPfqY+iKVHYOR0EJJu+aCMxqPQkfxal81iFJvp+2lJ5tkcwcIYWGHoBzDhpst/IgIjWxITG/5TuFwLYzw664p/GofRn+OP5UaAmtw+8Cddifzt1SEir5dSvoZkhM05D7++GdnrFwURvr6phV+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFDR2SBR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORG2d99t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770019178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUdYTNDY3+ArzbH2XqDLfxrZg+wmSQMN8VZo/kU83No=;
	b=dFDR2SBR2IvMGkGxqddtM0BGAknirVeq4cdsyKj4SHSghydjO7E0ek2GRZG51M75jDtizs
	TLNRUO2xF9jNR4tmv0SLL7v6gfUtERWmvAvibQs70Q9IR+10unsF1YUDLSYHjYHDFitIVj
	0xyxDEnA1MCkURqxpy2dgW3M6vExLOE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-p7QF7aPUNPea1ljKgodYEQ-1; Mon, 02 Feb 2026 02:59:36 -0500
X-MC-Unique: p7QF7aPUNPea1ljKgodYEQ-1
X-Mimecast-MFC-AGG-ID: p7QF7aPUNPea1ljKgodYEQ_1770019176
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so49554145e9.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 23:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770019175; x=1770623975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUdYTNDY3+ArzbH2XqDLfxrZg+wmSQMN8VZo/kU83No=;
        b=ORG2d99tZhXjzDzGYoPbtl4mUt/ojxBxZsk8hoJ0E6BdRrFhjGwmsLrXpGF89udUzN
         FDcb1Eg1Ab7xG6WWziNxLxh9hZbs0/ARjZjpPG5H3LUOtQHl5smWYK4s2AOsNsVC3fXE
         Y5Qbk5CueZgj2Y/LLBMvHrd/SmBU3Mb2Lxu6fXMxPiUzQoUDmKbkKC8VEoAtAfYT0DZ6
         /Sn89ha6dsVGATHJBxWxcDdtYR1G9qC/PDXcFj4wuGjl/ssWNXsl4Fv1Rl8lw9ZHj04d
         Zo6wR/mUUOQle/AGFXHSHn+cI1TPqULlfzGA6Jp1ZZRbU9Ed7SyEsmagcnmZxbj++gMk
         yM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770019175; x=1770623975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUdYTNDY3+ArzbH2XqDLfxrZg+wmSQMN8VZo/kU83No=;
        b=cNa7ossCmKYXXyJ5AKpUa9sMdn80xVilTapghxbpfrU0vfNXspbS7SS11zLk9xy7sq
         NE55UE3jc5TDEazjnQhdGVS0G6Fn6fCPidUzfa6DxRJOt4rBVazWKWSuhxdJlXLoQwwp
         bpR/XOy5vvc4bVl79fN7ReAhjsbk2f+vYNEaoujZ47wdQ78iSAQRPA1N910k9bNKVKKO
         MiUTBasEFG9IF8hppUpFxv/nW/6xosI8eWfV+4FGNefwvo2JhxxK/u6hPL8LcTzU+9/O
         ffAMOFrEPMHU4rnxeJb5ZVjYHmeKqLWcfEUT3kae7PIEIq0kHZehg/cYau12cHvXnoS9
         UE3w==
X-Forwarded-Encrypted: i=1; AJvYcCUxsBFTMo94ZrQF/q2jZ1g9Nlfm4ykkNC8PB2kNFi6JYuO+3ghVSwIwNhvj4VEcUeK9EjeT1yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mc0WUxvl/5NzP0QXwz1bpZNpIp/hOguamfGVngDctHMVr+jl
	EvEep8I9292itAcJaytmqLs8VEtsSPHAItYQe3AQOhekiNCfHnw4XeNnycIwaAm7R27OioZkiTs
	EeJymE7ZQracDcf7sIhJJpdUCR4PNx/DOv75v4bZOQmjtt8wxTe0jQwAnQw==
X-Gm-Gg: AZuq6aJQPtl4ZvjX03MMtwg2q5IlrQHXLCqp0WyiaeRnePisDlt0HcgrzPlyYGvCmzJ
	zn3Ppux7Ht47vZfCGXpEBEQkCu1yQeVLXc7R7QiBbFYhInOIfGwHmHVAxTF9EcUdUGaIrWut2pH
	aLjQRZXiJilQ1Rom20dJ9x5mRoFV8b9mvDHgtVhXvmdcV9YXI81gY1igZfDZKPqS26nvcOpgC/D
	OfVFukKrCn7k9R9rRjbXgnjs+NZTYipiPzqjI5x3+qYc5glsp91q8nyoRUjD5lSiZQMru1EzuZq
	DR8j8D061/K1bpeYG0ghFbfdrnADzHksDx/foboVhSOyazFRoMbgtrctw8dW1yCVKaW7643G0Tx
	L3UPKOaxWRUK44/Paw6IArhPz5rFblUEX7w==
X-Received: by 2002:a05:600c:8b42:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-482db49728bmr116146705e9.32.1770019175453;
        Sun, 01 Feb 2026 23:59:35 -0800 (PST)
X-Received: by 2002:a05:600c:8b42:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-482db49728bmr116146405e9.32.1770019174868;
        Sun, 01 Feb 2026 23:59:34 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce5ec6bsm404156725e9.15.2026.02.01.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 23:59:34 -0800 (PST)
Date: Mon, 2 Feb 2026 02:59:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Message-ID: <20260202025322-mutt-send-email-mst@kernel.org>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <willemdebruijn.kernel.37516e24f10fa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.37516e24f10fa@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: C94D9C96DB
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 04:05:54PM -0500, Willem de Bruijn wrote:
> Steffen Trumtrar wrote:
> > Add optional hardware rx timestamp offload for virtio-net.
> > 
> > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > virtio-net header is expanded with room for a timestamp.
> > 
> > To get and set the hwtstamp the functions ndo_hwtstamp_set/get need
> > to be implemented. This allows filtering the packets and only time stamp
> > the packets where the filter matches. This way, the timestamping can
> > be en/disabled at runtime.
> > 
> > Tested:
> >   guest: ./timestamping eth0 \
> >           SOF_TIMESTAMPING_RAW_HARDWARE \
> >           SOF_TIMESTAMPING_RX_HARDWARE
> >   host: nc -4 -u 192.168.1.1 319
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > 
> > --
> >   Changes to last version:
> >   - rework series to use flow filters
> >   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
> >   - original work done by: Willem de Bruijn <willemb@google.com>
> > ---
> >  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++++++----
> >  include/uapi/linux/virtio_net.h |   9 +++
> >  2 files changed, 133 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -429,6 +429,9 @@ struct virtnet_info {
> >  	struct virtio_net_rss_config_trailer rss_trailer;
> >  	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >  
> > +	/* Device passes time stamps from the driver */
> > +	bool has_tstamp;
> > +
> >  	/* Has control virtqueue */
> >  	bool has_cvq;
> >  
> > @@ -475,6 +478,8 @@ struct virtnet_info {
> >  
> >  	struct control_buf *ctrl;
> >  
> > +	struct kernel_hwtstamp_config tstamp_config;
> > +
> >  	/* Ethtool settings */
> >  	u8 duplex;
> >  	u32 speed;
> > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> >  		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
> >  		struct virtio_net_hdr_v1_hash hash_v1_hdr;
> >  		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > +		struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
> 
> Jason, Michael: creating a new struct for every field is not very
> elegant. Is it time to find a more forward looking approach to
> expanding with new fields? Like a TLV, or how netlink structs like
> tcp_info are extended with support for legacy users that only use
> a truncated struct?

I certainly wouldn't mind, though I suspect tlv is too complex as
hardware implementations can't efficiently follow linked lists.  I'll
try to ping some hardware designers for what works well for offloads.


> >  	};
> >  };
> >  
> > @@ -682,6 +688,13 @@ skb_vnet_common_hdr(struct sk_buff *skb)
> >  	return (struct virtio_net_common_hdr *)skb->cb;
> >  }
> >  
> > +static inline struct virtio_net_hdr_v1_hash_tunnel_ts *skb_vnet_hdr_ts(struct sk_buff *skb)
> > +{
> > +	BUILD_BUG_ON(sizeof(struct virtio_net_hdr_v1_hash_tunnel_ts) > sizeof(skb->cb));
> > +
> > +	return (void *)skb->cb;
> > +}
> > +
> >  /*
> >   * private is used to chain pages for big packets, put the whole
> >   * most recent used list in the beginning for reuse
> > @@ -2560,6 +2573,15 @@ virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
> >  		(__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
> >  }
> >  
> > +static inline u64
> > +virtio_net_tstamp_value(const struct virtio_net_hdr_v1_hash_tunnel_ts *hdr_hash_ts)
> > +{
> > +	return  (u64)__le16_to_cpu(hdr_hash_ts->tstamp_0) |
> > +	       ((u64)__le16_to_cpu(hdr_hash_ts->tstamp_1) << 16) |
> > +	       ((u64)__le16_to_cpu(hdr_hash_ts->tstamp_2) << 32) |
> > +	       ((u64)__le16_to_cpu(hdr_hash_ts->tstamp_3) << 48);
> > +}
> > +
> >  static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
> >  				struct sk_buff *skb)
> >  {
> > @@ -2589,6 +2611,18 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
> >  	skb_set_hash(skb, virtio_net_hash_value(hdr_hash), rss_hash_type);
> >  }
> >  
> > +static inline void virtnet_record_rx_tstamp(const struct virtnet_info *vi,
> > +					    struct sk_buff *skb)
> > +{
> > +	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> > +	const struct virtio_net_hdr_v1_hash_tunnel_ts *h = skb_vnet_hdr_ts(skb);
> > +	u64 ts;
> > +
> > +	ts = virtio_net_tstamp_value(h);
> > +	memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
> > +	shhwtstamps->hwtstamp = ns_to_ktime(ts);
> > +}
> > +
> >  static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
> >  				 struct sk_buff *skb, u8 flags)
> >  {
> > @@ -2617,6 +2651,8 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
> >  		goto frame_err;
> >  	}
> >  
> > +	if (vi->has_tstamp && vi->tstamp_config.rx_filter != HWTSTAMP_FILTER_NONE)
> > +		virtnet_record_rx_tstamp(vi, skb);
> >  	skb_record_rx_queue(skb, vq2rxq(rq->vq));
> >  	skb->protocol = eth_type_trans(skb, dev);
> >  	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> > @@ -3321,7 +3357,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
> >  {
> >  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
> >  	struct virtnet_info *vi = sq->vq->vdev->priv;
> > -	struct virtio_net_hdr_v1_hash_tunnel *hdr;
> > +	struct virtio_net_hdr_v1_hash_tunnel_ts *hdr;
> >  	int num_sg;
> >  	unsigned hdr_len = vi->hdr_len;
> >  	bool can_push;
> > @@ -3329,8 +3365,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
> >  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> >  
> >  	/* Make sure it's safe to cast between formats */
> > -	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr));
> > -	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr.hdr));
> > +	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->tnl.hash_hdr));
> > +	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->tnl.hash_hdr.hdr));
> >  
> >  	can_push = vi->any_header_sg &&
> >  		!((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
> > @@ -3338,18 +3374,18 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
> >  	/* Even if we can, don't push here yet as this would skew
> >  	 * csum_start offset below. */
> >  	if (can_push)
> > -		hdr = (struct virtio_net_hdr_v1_hash_tunnel *)(skb->data -
> > -							       hdr_len);
> > +		hdr = (struct virtio_net_hdr_v1_hash_tunnel_ts *)(skb->data -
> > +								  hdr_len);
> >  	else
> > -		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
> > +		hdr = &skb_vnet_common_hdr(skb)->ts_hdr;
> >  
> > -	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> > +	if (virtio_net_hdr_tnl_from_skb(skb, &hdr->tnl, vi->tx_tnl,
> >  					virtio_is_little_endian(vi->vdev), 0,
> >  					false))
> >  		return -EPROTO;
> >  
> >  	if (vi->mergeable_rx_bufs)
> > -		hdr->hash_hdr.hdr.num_buffers = 0;
> > +		hdr->tnl.hash_hdr.hdr.num_buffers = 0;
> >  
> >  	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
> >  	if (can_push) {
> > @@ -5563,6 +5599,22 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
> >  	return 0;
> >  }
> >  
> > +static int virtnet_get_ts_info(struct net_device *dev,
> > +			       struct kernel_ethtool_ts_info *info)
> > +{
> > +	/* setup default software timestamp */
> > +	ethtool_op_get_ts_info(dev, info);
> > +
> > +	info->rx_filters = (BIT(HWTSTAMP_FILTER_NONE) |
> > +			    BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
> > +			    BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
> > +			    BIT(HWTSTAMP_FILTER_ALL));
> > +
> > +	info->tx_types = HWTSTAMP_TX_OFF;
> > +
> > +	return 0;
> > +}
> > +
> >  static void virtnet_init_settings(struct net_device *dev)
> >  {
> >  	struct virtnet_info *vi = netdev_priv(dev);
> > @@ -5658,7 +5710,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
> >  	.get_ethtool_stats = virtnet_get_ethtool_stats,
> >  	.set_channels = virtnet_set_channels,
> >  	.get_channels = virtnet_get_channels,
> > -	.get_ts_info = ethtool_op_get_ts_info,
> > +	.get_ts_info = virtnet_get_ts_info,
> >  	.get_link_ksettings = virtnet_get_link_ksettings,
> >  	.set_link_ksettings = virtnet_set_link_ksettings,
> >  	.set_coalesce = virtnet_set_coalesce,
> > @@ -6242,6 +6294,58 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
> >  		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
> >  }
> >  
> > +static int virtnet_hwtstamp_get(struct net_device *dev,
> > +				struct kernel_hwtstamp_config *tstamp_config)
> > +{
> > +	struct virtnet_info *vi = netdev_priv(dev);
> > +
> > +	if (!netif_running(dev))
> > +		return -EINVAL;
> > +
> > +	*tstamp_config = vi->tstamp_config;
> > +
> > +	return 0;
> > +}
> > +
> > +static int virtnet_hwtstamp_set(struct net_device *dev,
> > +				struct kernel_hwtstamp_config *tstamp_config,
> > +				struct netlink_ext_ack *extack)
> > +{
> > +	struct virtnet_info *vi = netdev_priv(dev);
> > +
> > +	if (!netif_running(dev))
> > +		return -EINVAL;
> > +
> > +	switch (tstamp_config->rx_filter) {
> > +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> > +		break;
> > +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> > +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> > +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> > +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> > +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> > +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> > +		tstamp_config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> > +		break;
> > +	case HWTSTAMP_FILTER_NONE:
> > +		break;
> > +	case HWTSTAMP_FILTER_ALL:
> > +		tstamp_config->rx_filter = HWTSTAMP_FILTER_ALL;
> > +		break;
> 
> It's fine to implement filters, but also fine to only support ALL or
> NONE for simplicity.
> 
> In the end it probably depends on what the underlying physical device
> supports.
> 
> > +	default:
> > +		tstamp_config->rx_filter = HWTSTAMP_FILTER_ALL;
> > +		return -ERANGE;
> > +	}
> > +
> > +	vi->tstamp_config = *tstamp_config;
> > +
> > +	return 0;
> > +}
> > +
> >  static int virtnet_init_irq_moder(struct virtnet_info *vi)
> >  {
> >  	u8 profile_flags = 0, coal_flags = 0;
> > @@ -6289,6 +6393,8 @@ static const struct net_device_ops virtnet_netdev = {
> >  	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
> >  	.ndo_set_features	= virtnet_set_features,
> >  	.ndo_tx_timeout		= virtnet_tx_timeout,
> > +	.ndo_hwtstamp_set	= virtnet_hwtstamp_set,
> > +	.ndo_hwtstamp_get	= virtnet_hwtstamp_get,
> >  };
> >
> >  static void virtnet_config_changed_work(struct work_struct *work)
> > @@ -6911,6 +7017,9 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
> >  		vi->has_rss_hash_report = true;
> >  
> > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_TSTAMP))
> > +		vi->has_tstamp = true;
> > +
> >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> >  		vi->has_rss = true;
> >  
> > @@ -6945,8 +7054,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> >  	}
> >  
> > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
> > -	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
> > +	if (vi->has_tstamp)
> > +		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel_ts);
> > +	else if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
> > +		 virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
> >  		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
> >  	else if (vi->has_rss_hash_report)
> >  		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
> > @@ -7269,7 +7380,8 @@ static struct virtio_device_id id_table[] = {
> >  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> >  	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
> >  	VIRTIO_NET_F_VQ_NOTF_COAL, \
> > -	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
> > +	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS, \
> > +	VIRTIO_NET_F_TSTAMP
> >  
> >  static unsigned int features[] = {
> >  	VIRTNET_FEATURES,
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > index 1db45b01532b5..9f967575956b8 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -56,6 +56,7 @@
> >  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
> >  					 * Steering */
> >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> > +#define VIRTIO_NET_F_TSTAMP	  49	/* Device sends TAI receive time */
> >  #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
> >  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
> >  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
> > @@ -215,6 +216,14 @@ struct virtio_net_hdr_v1_hash_tunnel {
> >  	__le16 inner_nh_offset;
> >  };
> >  
> > +struct virtio_net_hdr_v1_hash_tunnel_ts {
> > +	struct virtio_net_hdr_v1_hash_tunnel tnl;
> > +	__le16 tstamp_0;
> > +	__le16 tstamp_1;
> > +	__le16 tstamp_2;
> > +	__le16 tstamp_3;
> > +};
> 
> Why the multiple fields, rather than u64.
> 
> More broadly: can my old patchset be dusted off as is. Does it require
> significant changes?
> 
> I only paused it at the time, because I did not have a real device
> back-end that was going to support it.
> 
> > +
> >  #ifndef VIRTIO_NET_NO_LEGACY
> >  /* This header comes first in the scatter-gather list.
> >   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
> > 
> > -- 
> > 2.52.0
> > 
> 


