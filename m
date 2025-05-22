Return-Path: <netdev+bounces-192862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989BAC16C9
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B747C1BC807D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8827510C;
	Thu, 22 May 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS0aFKqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70F253345
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952985; cv=none; b=ZL3KD2bpxbGxXMFjciHD5H06FiGPWHwE5YfyTTipjSiXXZcA3XDFsNNv3j9Kdp7X3wJyZhBHOLqmklXPeL4Bsd6HkI+7nFlT4gCkToCUh+4YDo2/x6Vn+EB8XDKlM7QsC7gq6JhukXJAsgM30bSXDb2rkrPlYToSxF+QZUaWeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952985; c=relaxed/simple;
	bh=mBzrVELxOdIzxz/kddB1RMi5LBNnlDAA+4YU7sIdM4g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sNOOe8QiGflYP16omDqfRO78PrvgwaJA1jna6n5Ae+JJNS362HkebXY7TLSlsCZRlJJRr0DaP+nqp25hksBULugP5/iwpn3yLxdYlLoUG+UpeBzDzMbpEzZzp2/V3RAyl8umgczmyS0ADVYEXlukv9SYI9TuE5EUR0k368rcw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS0aFKqz; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7cadd46eb07so903071385a.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747952982; x=1748557782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvajL2YecSqVsIZW32nwz7pzwzttwEnJfCfWZasK7sc=;
        b=aS0aFKqzOpoTqnmabMLL1W0/AoliqBWmBayEWZiDa1WkXNQpL3xYyuvhRyErmWyzi5
         djYQI4fzeM9pz787Rh2wGTHDqNIP2IIh65bOJDBQBi5eSKbdlX5juZKARX2S6kmeoUL4
         zFnnjazZHxOLCBTFtTFW++t+OLeekEYlpdEhDBuzQFyBQJQfcfh38qEsqMKAitj1qWLr
         Q9zxTvCkiSCqJNhZDfW8OFgcdC8xr+vKium6jtr7jBm1fduwPBTzOjGWd+lklpdUfTLC
         7JnIGixxJDrANGdyHuPzpxlP4ye6UpvIoDi0OtD3xpssJIvWHX+6OoWAxuvEFQCj4tQo
         kGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747952982; x=1748557782;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HvajL2YecSqVsIZW32nwz7pzwzttwEnJfCfWZasK7sc=;
        b=dla23yOQtemG22mqKr3lWYnuHw7ASzKuBBtdV76XhH29mp0dD81STBH9lVLuYmEuz5
         YEQdXSiAKvze+IDzi2+3x15LvNQnAxyjebMl2nyFdA5sHNbcKwG5heuKMLFLCQBpQLNB
         6xe3mpMT6AOh9mSbC7+2ukR6peMLmATws6NJ1ZSMQZABpzk8PmkC8UhUnRP7dwfoQIri
         uE1xIIkvKxab6AeQFG/FZ/nO10dIrZ6L4op7B1Fei4UGfNM1d8ol0v7okQxoWm/4Sws4
         9q2Rj9EIL6RQLVYupSY6ekRlDZ2xMKORUEvrUn/PZRCzmr5UL5fYEuCqQhKyoh32PAer
         EkIw==
X-Forwarded-Encrypted: i=1; AJvYcCVm511GePTkF0VPYcXaWq2gpS/1SgaVv6QuYoRSGiGnhfLUU/vQu1c8omE9dVLwno4EZgOGl48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKFNy4/l8KTEp+hn5fXCjo9XQkkpbTNQKGpKvcnKasMmFktNo
	IRX2pI2EjxEU60TGBI9axhWXlsL/n7PUUeSSCeKILZzJcU+ZdDAmaoPJ
X-Gm-Gg: ASbGncs/xeoNl1cic65HQ1VsN0NOxf3/hbmYfGWuqOVbonaOd6hieSOmloOTF1Zr+WY
	QZSUjPrVVwD9ITuJ9pR6ZU7Ce8AVyNO3uKgeiHx7VRZz6pFnFyplCFw2goE55VePqRdHf/3cUT1
	pilr1B2fQx1f3fPOrIVIiLD+b4H12kDX/dGuhQbLP24TZSh/4mh2jQEg4ZG0zteYG13Qs1FrW86
	VLDtIjXogQQkUY5P3Wvr7o2bX1NkhI/P5x+PzEdTkiEQESg/e4zGHpAGhvhgcxk5KAEB5OHyg48
	yRzBDQzD5DJ69RMLSgMY7v9fzyqQV/rK84yqlmM1OcE5C4I0I76ZoT1OuAuph5Fome2Kaf6AQoO
	Y6iyGkr654s5IOKzCQTrE3K5OOVmLjtKRgA==
X-Google-Smtp-Source: AGHT+IH5gtFu43ffHV3A5cCcvLvYesNykcRHyTWxl6Fown5Z5YYVXNfSVzq5CgMy6bMvCSl7lJtc+g==
X-Received: by 2002:a05:620a:430a:b0:7cd:3f01:7c83 with SMTP id af79cd13be357-7cd4677d302mr3037209685a.39.1747952982574;
        Thu, 22 May 2025 15:29:42 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467d7eddsm1075249285a.34.2025.05.22.15.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 15:29:42 -0700 (PDT)
Date: Thu, 22 May 2025 18:29:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>
Message-ID: <682fa555b2bcc_13d837294a8@willemb.c.googlers.com.notmuch>
In-Reply-To: <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/8] net: implement virtio helpers to handle UDP
 GSO tunneling.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> The virtio specification are introducing support for GSO over
> UDP tunnel.
> 
> This patch brings in the needed defines and the additional
> virtio hdr parsing/building helpers.
> 
> The UDP tunnel support uses additional fields in the virtio hdr,
> and such fields location can change depending on other negotiated
> features - specifically VIRTIO_NET_F_HASH_REPORT.
> 
> Try to be as conservative as possible with the new field validation.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

No major concerns from me on this series. Much of the design
conversations took place earlier on the virtio list.

Maybe consider test coverage. If end-to-end testing requires qemu,
then perhaps KUnit is more suitable for testing basinc to/from skb
transformations. Just a thought.

> ---
>  include/linux/virtio_net.h      | 177 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_net.h |  33 ++++++
>  2 files changed, 202 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 02a9f4dc594d0..cf9c712a67cd4 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -47,9 +47,9 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static inline int virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> +					    const struct virtio_net_hdr *hdr,
> +					    unsigned int tnl_hdr_offset,
> +					    bool tnl_csum_negotiated,
> +					    bool little_endian)
> +{
> +	u8 gso_tunnel_type = hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL;
> +	unsigned int inner_nh, outer_th, inner_th;
> +	unsigned int inner_l3min, outer_l3min;
> +	struct virtio_net_hdr_tunnel *tnl;
> +	u8 gso_inner_type;
> +	bool outer_isv6;
> +	int ret;
> +
> +	if (!gso_tunnel_type)
> +		return virtio_net_hdr_to_skb(skb, hdr, little_endian);
> +
> +	/* Tunnel not supported/negotiated, but the hdr asks for it. */
> +	if (!tnl_hdr_offset)
> +		return -EINVAL;
> +
> +	/* Either ipv4 or ipv6. */
> +	if (gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 &&
> +	    gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
> +		return -EINVAL;
> +
> +	/* No UDP fragments over UDP tunnel. */

What are udp fragments and why is TCP with ECN not supported?

> +	gso_inner_type = hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN |
> +					   gso_tunnel_type);
> +	if (!gso_inner_type || gso_inner_type == VIRTIO_NET_HDR_GSO_UDP)
> +		return -EINVAL;
> +
> +	/* Relay on csum being present. */

Rely

>  #endif /* _LINUX_VIRTIO_NET_H */
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 963540deae66a..1f1ff88a5749f 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -70,6 +70,28 @@
>  					 * with the same MAC.
>  					 */
>  #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO 65 /* Driver can receive
> +					      * GSO-over-UDP-tunnel packets
> +					      */
> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM 66 /* Driver handles
> +						   * GSO-over-UDP-tunnel
> +						   * packets with partial csum
> +						   * for the outer header
> +						   */
> +#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO 67 /* Device can receive
> +					     * GSO-over-UDP-tunnel packets
> +					     */
> +#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM 68 /* Device handles
> +						  * GSO-over-UDP-tunnel
> +						  * packets with partial csum
> +						  * for the outer header
> +						  */
> +
> +/* Offloads bits corresponding to VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO{,_CSUM}
> + * features
> + */
> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED	46
> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED	47

I don't quite follow this. These are not real virtio bits?
  

