Return-Path: <netdev+bounces-237099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA52C4485A
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 22:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D4FC4E4525
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456AF264612;
	Sun,  9 Nov 2025 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y25dum1j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyrjTR69"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115323A9B0
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724577; cv=none; b=TYy2dJ5Gy2jGEfSvT5NgUITs4v+tlvLV1rYgPYQyFGD68yZDVmzEJiUy27c12RkG4dgkceG3/ZaBtPg7P9e3gQokg5tYm/yAl/I/dOa5nW6eEOp2A0BwC+7sxHTTeoQ/n5fSDNTh3PAg5j/4AYvvUcxwRHP5D+P7WvkR8jGOYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724577; c=relaxed/simple;
	bh=LmKB2duQIVCAvE+Z+ImdR2aiNTNb7iGVbnE+RW0CfL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4hVUNedIqktvVuX4dpIGL3WTOkoptLutSehEobJUvX9AkMG1NyOS5h8sz7zMvtHTOmP17xRdTp+AI063v4HHwMd+IOohKiHN+5eV/NhMvOwS218VVlVmjLBxeLeaPC7XHkiSsAtrVq2DS2MZtn9ugq+aOzLb13Yy9CzeF/qF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y25dum1j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyrjTR69; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762724574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6IXQ9UBlHWYywhU0Xh3V4xPK5ResoKCt5ne0jLzblXQ=;
	b=Y25dum1jJWnHzR5cnAVLiw3T0PDUnIR20m6JHPsO8HX3RbjeJb2M8tYzjfCeRG0LZtfswM
	rsifkULpJtOV5plyIihDWX0ENBS+qDizmZp38ncWGGODtaREKpKVTPxIkKZK0iiPBXBh63
	e8gk7VSz0SavVv+8mVIyBKY6skQSL/o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-C9EjPrXvPNms6b1blAmSOg-1; Sun, 09 Nov 2025 16:42:52 -0500
X-MC-Unique: C9EjPrXvPNms6b1blAmSOg-1
X-Mimecast-MFC-AGG-ID: C9EjPrXvPNms6b1blAmSOg_1762724572
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475e032d81bso12814925e9.3
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 13:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762724571; x=1763329371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6IXQ9UBlHWYywhU0Xh3V4xPK5ResoKCt5ne0jLzblXQ=;
        b=hyrjTR69OMmYtJvXJshKmA9SIZQ2fUDlVQLP+DqgvQVt3QYS9nLHl7rG8STPn2+XVD
         I85r+j8oLeNMFJvsspfcYJO7fgLkDebN0HL5oYudU9uBH8Qu58zC5QWIJWqIFCFSSD1C
         YuVk3zJ/r+NQHCMlpaoCkHYeL5KKmELSgj91C/QAe/rGcUFcVaBQnAXuT2zdbpYd89hf
         10ox7pfFgClayy0rDPwMFf4hmc7z+H0ommfuoKQuJ96Rm2eGqi+t5RVs83e2wn6foGac
         rSYtF6DSBt2N7/JY8bw/bPiUJtiUWneMxb/AV9aja96OXzGjoO07hV3V6+tzqsvx48q+
         pzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724571; x=1763329371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IXQ9UBlHWYywhU0Xh3V4xPK5ResoKCt5ne0jLzblXQ=;
        b=erF19ucLggKpRxbN/5FfnxwkT/XUUSj9jNiHe7YEBJ9yfpWpkILTXQKjumJhJsqq1D
         YNJILqFxMUCUVRbmhz6Iuauqa+tbzkcw1EgM9gxFYHR+KfWE0FFrKwpnwTFK0fXy8NGP
         PIS/CE88CLlJa2VgQNAtSKMjUvkGurppAYyObue7VKbQFcb+Ho520QTOlmRpjG9iNcqQ
         S57Aw70p19GS0wmLf8AAHRt0bV2W/+j7paZbmYiUUAYjrJPCMCmOiQ9hLM23b4LzETK6
         G+HAdqJdh9ZNUmKQIJ/tYuqrgs75TxHUXyCmQaF5JS9gSAQeBZmkoNyN6Ni8MKp5HVLH
         lU8g==
X-Gm-Message-State: AOJu0YwLbh/GsizKFWJCtUeJ10nHJ97SofkVw380f5jm6ybGv7ixc9oU
	rylSrkUGTskePkjleGonZ7h3CWjOvwCOsnAct/9eKXjBESI8EhLzHpi/jGiOqXd11hHcGh2fpDz
	2kMOjZFns6c2uoAa3pThEdc3NMRP9SCgLvkVnJIC3Nip4kVsZmFaQhvj2UQ==
X-Gm-Gg: ASbGnctZLU+W6x2tVw59txjQTl9RqVPv8G/pbtkOZhOSvMEkAZfuNYMDRDxO+Q//VCD
	m1hvy7E3VsnU7/egEWch8plHIKnoThttBSS5Gzjeclb+xIR8t3bSJEfWC1yICScUXSk0atbMAm1
	50mrBlyXLCK9Yhw5Er5GZ6Zh4WA+YKPY3ZUwbukvRn959rOUbhJ1NNOgD2amIJLyoo6TVHav1UF
	Gao9kAYajOwA/FQ8Jd9AUEyZ5Ph+KlNEmcpKs8WHmIi4aKDQwhtykXF52NK6v97NWcZnRpNXjb7
	VHEZLIpcLm0HEMF9zjaoJVvDqofEPj4RmsUoQFiyoTbtPsYhijuuFu6tjmAG7GFORGc=
X-Received: by 2002:a05:600c:c4a1:b0:471:1717:40f with SMTP id 5b1f17b1804b1-4777326eb4dmr52273985e9.22.1762724571428;
        Sun, 09 Nov 2025 13:42:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoJBOUKmXnSs/COEMtg4usMh/sEWfzcIqGkN8whiHWFiHxtB0SnSQIC6SRXRLiuUoPaGqZVg==
X-Received: by 2002:a05:600c:c4a1:b0:471:1717:40f with SMTP id 5b1f17b1804b1-4777326eb4dmr52273875e9.22.1762724571022;
        Sun, 09 Nov 2025 13:42:51 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774d3557csm97500045e9.8.2025.11.09.13.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:42:50 -0800 (PST)
Date: Sun, 9 Nov 2025 16:42:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251109164133-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>

On Wed, Oct 29, 2025 at 11:09:12AM +0800, Xuan Zhuo wrote:
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

ca you supply some examples when this is wrong please?

> ---
>  include/linux/virtio_net.h | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 710ae0d2d336..6ef0b737d548 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -217,25 +217,35 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> +		u16 hdr_len = 0;
>  
>  		/* In certain code paths (such as the af_packet.c receive path),
>  		 * this function may be called without a transport header.
>  		 * In this case, we do not need to set the hdr_len.
>  		 */



you actually do initialize it, just to 0.
the comment is confusing.

>  		if (skb_transport_header_was_set(skb))
> -			hdr->hdr_len = __cpu_to_virtio16(little_endian,
> -							 skb_headlen(skb));
> +			hdr_len = skb_transport_offset(skb);

better:
	else
		hdr_len = 0;



>  
>  		hdr->gso_size = __cpu_to_virtio16(little_endian,
>  						  sinfo->gso_size);
> -		if (sinfo->gso_type & SKB_GSO_TCPV4)
> +		if (sinfo->gso_type & SKB_GSO_TCPV4) {
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> -		else if (sinfo->gso_type & SKB_GSO_TCPV6)
> +			if (hdr_len)
> +				hdr_len += tcp_hdrlen(skb);
> +		} else if (sinfo->gso_type & SKB_GSO_TCPV6) {
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> -		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> +			if (hdr_len)
> +				hdr_len += tcp_hdrlen(skb);
> +		} else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
> -		else
> +			if (hdr_len)
> +				hdr_len += sizeof(struct udphdr);
> +		} else {
>  			return -EINVAL;
> +		}
> +
> +		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> +
>  		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>  			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
>  	} else
> -- 
> 2.32.0.3.g01195cf9f


