Return-Path: <netdev+bounces-237585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D2CC4D6B5
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607BA3AB236
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D01355800;
	Tue, 11 Nov 2025 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TerlkwwX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTLM+08h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F03570C5
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860796; cv=none; b=UUSMO2/+QyizcMKzFKgDi5BL72KFfCqSReG2Dfx3ISmWsze5R6syL5Yz7WmUF/xRDo8cyI6klGnH7Vmn7Vu4ry7nCwpyCXfxg0F5vliWB7n4CktYiWA3NYGWOJoap1P2SV57HCm1xQnSt6TaFKNpomYrqywbp7UiwyXbXGHSG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860796; c=relaxed/simple;
	bh=iFbiv1k8lnyld6l1UO0yaMKd6dJwpnbIAOIG3SRI4cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAttu5cLNxio8ZzbDoUyKRB2oNk5i4jjw/k44s/N9kxP1el3+6D47wd5MejAaMvLLyKJNhExybUckJYBl25LS/3fof8B+gl48AGY9w5CZXC02AX8osVtcX+o7o3biYx8C3PJcslbFdRATPEqSZYHihbQ87B07JebztXo8NVScTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TerlkwwX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTLM+08h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762860791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjCGGcQyKaDkEEr1GFCr8tFawZ6AhFcGLUOM7JGRy/g=;
	b=TerlkwwX9k2Zupj65dpdmLbk2ESLvy8/e/32zJA1HlfrU/2D1f9MQnO4ownUH3/ODLN/V8
	19S2votvbk9k6M/Kg9DpH4/o02oz5WEVyi3OVXudHHfhKyCi2oKjMw4JT3ldVKVtravzEv
	05XzI+HBEzPUa+g+wkGAhubU+o2zFO0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-CKvihemsMDi8r2kXkbcrsg-1; Tue, 11 Nov 2025 06:33:10 -0500
X-MC-Unique: CKvihemsMDi8r2kXkbcrsg-1
X-Mimecast-MFC-AGG-ID: CKvihemsMDi8r2kXkbcrsg_1762860789
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775fcf67d8so34498175e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 03:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762860789; x=1763465589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjCGGcQyKaDkEEr1GFCr8tFawZ6AhFcGLUOM7JGRy/g=;
        b=DTLM+08hiaHUrBYHmSER1ZtTVzv3MbVKm3Eig4yAZmZk1vqIBAEZfGIE3oBa69u4J9
         72yY3eTGBRECol1/G0EeIhIU6m1cI2Vdj5BgX+8FX1JPYh+xOeeUMnAinsjFsAikZ7A6
         edHz4Pi92i2KMPZA1WzCroDi4b23Qer7UJIvB2XCRWHBRkeLUIR4eRAJZoAfDtmRsJ4Y
         o/CLBJx3SBca+qidlyS2sJ/EzfAe1B3RVydtn1lIWblL2ffpZVT7h5XHONL51TG4d9rt
         2UUL6Uw22hkVcColV/cSj8cFypL1vfdXOdT4xnqzCTBUtNOUXlopwhA46xIxXhuFkirx
         Z2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762860789; x=1763465589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjCGGcQyKaDkEEr1GFCr8tFawZ6AhFcGLUOM7JGRy/g=;
        b=RLP/HbcuooOpsSXZJDwbAQ0w0sVfE8zxTRwK0yjL9yrQvTgeO3gXnlEsa9pjJsRsXr
         hdRjzav0/Wzm23QEhASYoMNSAYCaA5BNPqVXPJJZcm/IIw0c5xudykuvUqt3btwurMPF
         +qODrfEtc2runk4lvjh0mWrojT5JxhLYquHMNNFlY0Lyaq0tYw9DlauWNjRnJ1xdfuX5
         o2PlEQ1afyRgIpQvYMdMxomKAej9rikH+o1gkbkMSvIc6OHtBFQs8EcQuDTxyaJr1qGH
         rlXuVpBJmoXcWSWGRSGwvR0Ykd7RsDFB7W/Wr1Nbq8p+hCMTeMBmGl3bGixJmHXs3rHB
         WQrg==
X-Gm-Message-State: AOJu0YyjBn544ZqPe6jUMbiLjv7NWp/XOL3CnqQEJXcK+BBAwda7NRKV
	DZLWNz7Ojsh5KwcEmiUNUTAXJys2lKf+wr/gMqPwI7H0YAEOTszS5Pa61BJw665gkqng+7/3mHY
	jIhn0kSOeonB7JyyKm5U9TkuSP7+yUzAkHnGuF1eOTGhiLFHA1uF1CYMZ3Q==
X-Gm-Gg: ASbGncvyopYrTkqk9IscqvsnV3PyWnPwxW360exafU33esD4RgMHr5FXQYzvZfrUNrY
	HBYNEM8DLaO7+sB3XMuzid09zoonx2Iqmzxe8HSyoN4Q5D5b0+i4CNzsznMnrz5JzC5cftJyJ6D
	2QjsqRpZCaq0gf1IGl1jsijyp1/2zLULsc19sqxMoUt02KhnND9oENqC27vv58JSI8IVkafS3VD
	s1wlEdI3meAsqS4MNz8nGiU7/lkZBlejvJeuAf6OvVVYGrM9x7Vh6knKQzm5VlydPyNSgCzIXAH
	rydWvePADYKbL/FWd/slI63sKE6YHakQeir86iAFKe6/pvOFEZU3rXGxx3debOGgu2Y=
X-Received: by 2002:a05:600c:1c1c:b0:475:dac3:699f with SMTP id 5b1f17b1804b1-4777322f0c4mr107508015e9.9.1762860788991;
        Tue, 11 Nov 2025 03:33:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9ZCOmzxqJgcOY7n4UNMc5skj2Q4Gv3GNfnYtKyWdcU0NAs5MYuDVCV20onYhye1hP6smGaQ==
X-Received: by 2002:a05:600c:1c1c:b0:475:dac3:699f with SMTP id 5b1f17b1804b1-4777322f0c4mr107507485e9.9.1762860788450;
        Tue, 11 Nov 2025 03:33:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47781d3875csm17005245e9.3.2025.11.11.03.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:33:08 -0800 (PST)
Date: Tue, 11 Nov 2025 06:33:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net v5 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251111062859-mutt-send-email-mst@kernel.org>
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
 <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>

On Tue, Nov 11, 2025 at 07:12:11PM +0800, Xuan Zhuo wrote:
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
> 
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
> 
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.
> 
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  arch/um/drivers/vector_transports.c |  1 +
>  drivers/net/tun_vnet.h              |  4 ++--
>  drivers/net/virtio_net.c            |  9 +++++++--
>  include/linux/virtio_net.h          | 26 +++++++++++++++++++++-----
>  net/packet/af_packet.c              |  5 +++--
>  5 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index 0794d23f07cb..03c5baa1d0c1 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -121,6 +121,7 @@ static int raw_form_header(uint8_t *header,
>  		vheader,
>  		virtio_legacy_is_little_endian(),
>  		false,
> +		false,
>  		0
>  	);
>  
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 81662328b2c7..0d376bc70dd7 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -214,7 +214,7 @@ static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>  
>  	if (virtio_net_hdr_from_skb(skb, hdr,
>  				    tun_vnet_is_little_endian(flags), true,
> -				    vlan_hlen)) {
> +				    false, vlan_hlen)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
>  		if (net_ratelimit()) {
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>  					tun_vnet_is_little_endian(flags),
> -					vlan_hlen)) {
> +					false, vlan_hlen)) {
>  		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0369dda5ed60..b335c88a8cd6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3317,9 +3317,13 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	struct virtio_net_hdr_v1_hash_tunnel *hdr;
> -	int num_sg;
>  	unsigned hdr_len = vi->hdr_len;
> +	bool hdrlen_negotiated;
>  	bool can_push;
> +	int num_sg;
> +
> +	hdrlen_negotiated = virtio_has_feature(vi->vdev,
> +					       VIRTIO_NET_F_GUEST_HDRLEN);
>  
>  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>  
> @@ -3339,7 +3343,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> -					virtio_is_little_endian(vi->vdev), 0))
> +					virtio_is_little_endian(vi->vdev),
> +					hdrlen_negotiated, 0))
>  		return -EPROTO;
>  
>  	if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b673c31569f3..3cd8b2ebc197 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -211,16 +211,15 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  					  struct virtio_net_hdr *hdr,
>  					  bool little_endian,
>  					  bool has_data_valid,
> +					  bool hdrlen_negotiated,
>  					  int vlan_hlen)

Took me a while to figure out why does tun pass false here.

The reason is that this flag is really only dealing with guest
hdrlen.  so how about guest_hdrlen to mirror spec
or if you like xmit_hdrlen?





>  {
>  	memset(hdr, 0, sizeof(*hdr));   /* no info leak */
>  
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> +		u16 hdr_len;
>  
> -		/* This is a hint as to how much should be linear. */
> -		hdr->hdr_len = __cpu_to_virtio16(little_endian,
> -						 skb_headlen(skb));
>  		hdr->gso_size = __cpu_to_virtio16(little_endian,
>  						  sinfo->gso_size);
>  		if (sinfo->gso_type & SKB_GSO_TCPV4)
> @@ -231,6 +230,21 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
>  		else
>  			return -EINVAL;
> +
> +		if (hdrlen_negotiated) {
> +			hdr_len = skb_transport_offset(skb);
> +
> +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +				hdr_len += sizeof(struct udphdr);
> +			else
> +				hdr_len += tcp_hdrlen(skb);
> +		} else {
> +			/* This is a hint as to how much should be linear. */
> +			hdr_len = skb_headlen(skb);
> +		}
> +
> +		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> +
>  		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>  			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
>  	} else
> @@ -384,6 +398,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
>  			    bool tnl_hdr_negotiated,
>  			    bool little_endian,
> +			    bool hdrlen_negotiated,
>  			    int vlan_hlen)
>  {
>  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
> @@ -395,7 +410,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  						    SKB_GSO_UDP_TUNNEL_CSUM);
>  	if (!tnl_gso_type)
>  		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> -					       vlan_hlen);
> +					       hdrlen_negotiated, vlan_hlen);
>  
>  	/* Tunnel support not negotiated but skb ask for it. */
>  	if (!tnl_hdr_negotiated)
> @@ -408,7 +423,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  
>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
> -	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> +	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, hdrlen_negotiated,
> +				      vlan_hlen);
>  	skb_shinfo(skb)->gso_type |= tnl_gso_type;
>  	if (ret)
>  		return ret;
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 173e6edda08f..6982f4ab1c73 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2093,7 +2093,8 @@ static int packet_rcv_vnet(struct msghdr *msg, const struct sk_buff *skb,
>  		return -EINVAL;
>  	*len -= vnet_hdr_sz;
>  
> -	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr, vio_le(), true, 0))
> +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr,
> +				    vio_le(), true, false, 0))
>  		return -EINVAL;
>  
>  	return memcpy_to_msg(msg, (void *)&vnet_hdr, vnet_hdr_sz);
> @@ -2361,7 +2362,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (vnet_hdr_sz &&
>  	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
>  				    sizeof(struct virtio_net_hdr),
> -				    vio_le(), true, 0)) {
> +				    vio_le(), true, false, 0)) {
>  		if (po->tp_version == TPACKET_V3)
>  			prb_clear_blk_fill_status(&po->rx_ring);
>  		goto drop_n_account;
> -- 
> 2.32.0.3.g01195cf9f


