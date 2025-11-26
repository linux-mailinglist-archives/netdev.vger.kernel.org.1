Return-Path: <netdev+bounces-241794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 489E6C8845B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26E0F4E5FCF
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB93F316905;
	Wed, 26 Nov 2025 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeERevFy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q6P+HnYn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281D3168E4
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138549; cv=none; b=VNBiZ1hLU9FOAcBTfkVWW4SP/5A4nRmGoQcWsWc4u1+Wt+YPyQlEj3A+U1dzJyRvhq2Oj598X4XVCEFAjf5KQ1Vm2ec51fqkc+70DDlyDA9smWdx31iHhQBDHZ0uNfAPLPHACrZCtIsJCktg6M7eVlR7+Sh2Z69MaYOPWrtpjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138549; c=relaxed/simple;
	bh=3/pwaE5kNWc6xvRP4byT6Z1o7udkRNYHajixp1MyjGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO2Bgt1h7vTGbKoVieyPv2pIzH6L+7SbJhAH2uGwlMdkHL3+FRdR1kMQ9ssd7vdyUcxW0SnUMjfFOfjthnl8b56SsfEfxV1aQI3Pzq6Smjj2XTjCRIZ4ssxTFvvjruexR4hky/ob9o1sd7bvW5EZEwzgbSsZB6VMEanmdBpCW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LeERevFy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q6P+HnYn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764138547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRoHaibIPNdZFAseTrDimat8Kh1F+X2mpCLBomjQqzI=;
	b=LeERevFyZZA6AN/x7Kwov1CLw+hRjvYo894ALx1hHF/hSb7FZcih35Lr4v2yNkXFVf8/vW
	+IUIKC4c8Em5hkKnhmACy7TtoWEQKWRE+ZyeV5ln+ckB9NJkeeEWV1GNuUcHJt5YCV0Gt9
	TQvQssCYXVRjB1BOaCcX9f7Qg9XdJSE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-nqYIi7iIPjOHUlnubJcFcw-1; Wed, 26 Nov 2025 01:29:02 -0500
X-MC-Unique: nqYIi7iIPjOHUlnubJcFcw-1
X-Mimecast-MFC-AGG-ID: nqYIi7iIPjOHUlnubJcFcw_1764138542
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cdb0706aso4207979f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764138542; x=1764743342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRoHaibIPNdZFAseTrDimat8Kh1F+X2mpCLBomjQqzI=;
        b=q6P+HnYnDqRdSG9UEngNiqptElEo3b6BRx7+tJavTSIIf6yw4hxQ6HWc9xIsI8unik
         RJJd/q3SDp1RYUNZ8hNmdhpqshYlsYbTXsyECNwo0Jp2GwraMcQ6lSsmEZeV/EO7SnRh
         +NSpJ0e4KQsX8zyH7vNdlfWPIKEjmrlGIR/xUPW7b55HSYciAXFodD0I63KzWPq5v+u1
         +v5jZ1dXqnftawX8bisfZP8C4VX3hzEK7mAneilcdn+zu+5SUo+dOM/T01YFh6syboF/
         d2q6Vl1EwCF+vXtePCAid8loTqZlxeYEG8XRqmSm+KrlfIXk2aWGVXoSoJDJNna4/oJY
         YQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138542; x=1764743342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRoHaibIPNdZFAseTrDimat8Kh1F+X2mpCLBomjQqzI=;
        b=a1aWQ8SsUrHW3TNXITXifxCtWsrwmyrCVqoHVk1QxMrQfNzF+khLK6enLB0ui1/btw
         ElNF8jOkzKCCT9Jj4zHW0QO5QW5J+CmzfxxyyY4eHnz1QKZvo4kHVj4doiX+LHiHItL7
         3pTyRFwYBTLz/49etDwI/FBPWGD/FANfSk5IKHn+891xSn4ZbtEJx6tAyyqOYpKyx+zj
         C4yTpNyJuVWioM9ghlvwtlwKIKsVRzb3vPYO/xxsleIAGa07WUwV7RWvHplvZC94W6a3
         s48LyJXKpsQWiU/1OEKE8CTRKZYgLB808ZoCk2Oqx86z6lC+T4pHTZWNpOaP8fPAE5Vm
         Pn9g==
X-Forwarded-Encrypted: i=1; AJvYcCXu7URQ4L568TAIyPsiyeVOD9NZtegn9MsRKxCcj92evE7EdLYQDufQgO2dsKmNJ0/UVT3sLhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Goz0o4nLcNHwix8/Isd4/umAbBxBtW92lx5PWvxKD5r85rNI
	2nZXH2EJRRfeQFrIH/KgQZnCzYS3McVxNMcMF+p1AtsK192Uv7miQ6hJ29H0Aeg4Osv1DRgPQcb
	OLKTNWlaZDXnRVlPD1NmzwmBWxeiZjyf6zA+cnIQ7K/irQ8GutJ94jsp9Rw==
X-Gm-Gg: ASbGncsQYD3yePqy2Ln7uas4uGWvb77Ir/4Nl3M0x8mIj0zYSg7neAGc+zCicAY+k9Y
	neTN5PYrtkzTD5GXw7J5r1gPApdXHwkC7kOQsKQTg9mWfWvBz/V9oUvn8SXTQv9KXOYUlNsUo/w
	JVaCxGz/MZX/LP4OXxqZE11IaeknR7Oc5qnqM4WRv/re57mijQqwbCfDHzFXKsWWfjEbwE5GSqV
	PAFdI19A1ZpIwdv1z/G/JckdTx/euiUeLnKmtzTFgIVAeq0eELZu5zc6mTfvlC1WH2XilUU6qKW
	aZL5+g5o97LGNnYoHdyyAfgOcj0BD853ZMlqNQWttNeSUXc8A0WJV5Zyf9h1VEpI8dct9LnrN4N
	RhF43MxYzM/Amd7RNM3mZZ2j/QqA2Pg==
X-Received: by 2002:a05:6000:1445:b0:42b:3ed2:c08a with SMTP id ffacd0b85a97d-42cc1cbd06dmr19876145f8f.13.1764138541588;
        Tue, 25 Nov 2025 22:29:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz3A2mfZSj7obvLm5ShaXHAmTMrtQXHYWQePIsCFH4Le2VTsSdvCCTNjdEfLEsFspW6+5HWQ==
X-Received: by 2002:a05:6000:1445:b0:42b:3ed2:c08a with SMTP id ffacd0b85a97d-42cc1cbd06dmr19876120f8f.13.1764138541147;
        Tue, 25 Nov 2025 22:29:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e574sm38233964f8f.3.2025.11.25.22.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:29:00 -0800 (PST)
Date: Wed, 26 Nov 2025 01:28:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v3] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Message-ID: <20251126012848-mutt-send-email-mst@kernel.org>
References: <20251125222754.1737443-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125222754.1737443-1-jon@nutanix.com>

On Tue, Nov 25, 2025 at 03:27:53PM -0700, Jon Kohler wrote:
> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") inadvertently altered checksum offload behavior
> for guests not using UDP GSO tunneling.
> 
> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> has_data_valid = true to virtio_net_hdr_from_skb.
> 
> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
> which passes has_data_valid = false into both call sites.
> 
> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
> for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
> guests are forced to recalculate checksums unnecessarily.
> 
> Restore the previous behavior by ensuring has_data_valid = true is
> passed in the !tnl_gso_type case, but only from tun side, as
> virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
> which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.
> 
> Cc: Paolo Abeni <pabeni@redhat.com>
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2-v3: Add net tag (whoops, sorry!)
> v1-v2: Add arg to avoid conflict from driver (Paolo) and send to net
>        instead of net-next.
>  drivers/net/tun_vnet.h     | 2 +-
>  drivers/net/virtio_net.c   | 3 ++-
>  include/linux/virtio_net.h | 7 ++++---
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 81662328b2c7..a5f93b6c4482 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>  					tun_vnet_is_little_endian(flags),
> -					vlan_hlen)) {
> +					vlan_hlen, true)) {
>  		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cfa006b88688..96f2d2a59003 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3339,7 +3339,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
>  
>  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> -					virtio_is_little_endian(vi->vdev), 0))
> +					virtio_is_little_endian(vi->vdev), 0,
> +					false))
>  		return -EPROTO;
>  
>  	if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b673c31569f3..75dabb763c65 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -384,7 +384,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
>  			    bool tnl_hdr_negotiated,
>  			    bool little_endian,
> -			    int vlan_hlen)
> +			    int vlan_hlen,
> +			    bool has_data_valid)
>  {
>  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
>  	unsigned int inner_nh, outer_th;
> @@ -394,8 +395,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
>  						    SKB_GSO_UDP_TUNNEL_CSUM);
>  	if (!tnl_gso_type)
> -		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> -					       vlan_hlen);
> +		return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +					       has_data_valid, vlan_hlen);
>  
>  	/* Tunnel support not negotiated but skb ask for it. */
>  	if (!tnl_hdr_negotiated)
> -- 
> 2.43.0


