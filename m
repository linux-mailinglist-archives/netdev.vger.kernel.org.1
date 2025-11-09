Return-Path: <netdev+bounces-237088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59880C447C9
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 22:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1BB74E1526
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08721F0E32;
	Sun,  9 Nov 2025 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfXS36cw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BC/hizWm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71E273F9
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724086; cv=none; b=hUDD8LSd0Nc4EgT4ASHQ8xesSQYGQFl9KY7vgp9Lp5CAdqZEn1HAvdM++N3dKCAluTdht/QPjltoEHziKlZmDm9VS++DglJTnD1m4nhAeMopc/h42gG8ibgU+mHVn2UdT4ghZlVRvFW6vGeinUiDuJbYfwlAf3wDdThzr2oK/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724086; c=relaxed/simple;
	bh=/k/tM7aN+VJfQPu1HR8zVVK7SFTOdEvY3M4sRoeTLCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+83JGaDkeOvXqpm/CY4a/+0BAAQgLCk+gWQUUsyjy2uYJwzwneW87s5brjHUYqaegLEUMYgui7Z8eZWolhcR5M3iE7oAJnur8MHCNkR6J4aL+5huNwid9CWVjQINVHAH4uwRJxb+4vq9uZJ3n3tOu43dKJKecFvLmhFeUh+jzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfXS36cw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BC/hizWm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762724083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuRvVMzBCOjz0UYXFyj845DdF5Y6IRoz7uN2lJXI1Vk=;
	b=dfXS36cwr01c6K5er7wJIXvydhy39YJtI37m+zcNUN2LvF2prMXT2bjrlyMVcYgeltklNP
	iamgeodwtM7ANgAd2Ffz7QRikYRc4RSRZTCLSem3jpRx0BXxorNX47UfGS7FemUCGaS7OE
	rN9yuNQQ+PokC66hZkQyNgIifKMVlRQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-q6WWSY4EMSyE9CpADLLZWg-1; Sun, 09 Nov 2025 16:34:42 -0500
X-MC-Unique: q6WWSY4EMSyE9CpADLLZWg-1
X-Mimecast-MFC-AGG-ID: q6WWSY4EMSyE9CpADLLZWg_1762724081
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso18730725e9.2
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 13:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762724081; x=1763328881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yuRvVMzBCOjz0UYXFyj845DdF5Y6IRoz7uN2lJXI1Vk=;
        b=BC/hizWmy7f9cAjZIrnyX4o9L9HJBeRKDG6r0ie6TQ81FuYcsNDbBYVg5KWJX8b2Cq
         I8skxEyxLVnZYAZxRWvUezGJhPi1gIWcqlUgF8MNpaOQO4nfIf5m5uhZVL8n8pkG5vNL
         F+qGwF1QbtKJjPH2HTtjzR6pe/2AZ+ARqlvjb32M75KKf968IZpDGBmzneiuZGgh4waa
         n8jqjGkwf2Jtu27unuScOuEkd9UwOcN34V7z7tWiDwRPZ5snTpSlxOMswd80Eff97lPd
         YhdupwF2W5cjY4dxtI0HG3NEbCm1lNw+1u8847IGLYobILjZ20VHUsX4VtrsvoCOsISQ
         +6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724081; x=1763328881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuRvVMzBCOjz0UYXFyj845DdF5Y6IRoz7uN2lJXI1Vk=;
        b=nUQCvNC+BpCk97nETTpgqqG0QfQnEEUq739b16fSRGiTBpm7JEpryFyaW37R8GC6FD
         wgsVBEo4uJ+R8p8siwN53/rbnsW2T3te7QcxGs/FIVmS0B8O5pXN3ENAPIZDmDbtLbvh
         Hrh3mEiMrIFL6OnKcuGFYAqy16YzMWBKaGGgp+bq7Ng2v0EjA/lT7ZehcEdN5vtKmFO5
         YS8c2oqoF9cUeVmqPF4WCE00680gfHrY4D31GAVzBeiZ5NvGYzOMCssOVNQr9FOc6eS6
         Bu0LL2jk/+bpaOn6d3Gafl7EVNKcpxU/MXRMiYNhTwwddvU1ZjFgYVRJvSdZSAY1MlPy
         ZqHg==
X-Gm-Message-State: AOJu0YzLCFYIyfn2MRSJTLgzeFthmH7WIs9uIyV0NMRCYU7LQtlV3BID
	/Z2f9QWJxcFUCKggJ5Mesd9V2sVr7DHBmWQEUPBvB2QRls5AjrMZbSnmd6X+EAectnCC6RkO08Q
	TEYJl/G/Q50eYaVmT1MicX/WHT062jtIe+HanczYFtgkHgEt5gXUOWnvAzg==
X-Gm-Gg: ASbGnct+VljiNOEHiiwb+dY1JroAvavtrkCq/Dpjr2EvwMaVE8o/NWUa8j5NJgAaA0j
	o/wzUkq3PbQL+iuK5ieJc54GsTstXhxsQ5l4ejta4vk9z9Y8i8D6FWST+ZNiAPcmPRYK/4vrTlO
	izW2o0stNNIQWo8D6MxYl4vzCsK+9Nlf4r280KSxK9K5SkQGmnqw0allX1aNdqVN5/n1TlIs/WR
	61CRTbAMSFSLVaagiZ4wHXbL1tzgCvyzownSa+4X5rADV8VZOpoIVyfWvqPNOoxHHMZqbPQZqrW
	ieL28cQrrAin7nuhydl9PGy5+tNPg0hZodmAxosHFd9jTlB6WjECUQEPOl+REHZH/Wc=
X-Received: by 2002:a05:600c:4ed2:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-4777d945f1dmr1196785e9.27.1762724081117;
        Sun, 09 Nov 2025 13:34:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW9iA+CzK/FjpBM/e7D6gQ+zW6aVjSPr8rNlm1S3UdLgIp9ALg50OwxbW/747hMDqIG1CnxA==
X-Received: by 2002:a05:600c:4ed2:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-4777d945f1dmr1196595e9.27.1762724080621;
        Sun, 09 Nov 2025 13:34:40 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm7761055f8f.0.2025.11.09.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:34:40 -0800 (PST)
Date: Sun, 9 Nov 2025 16:34:37 -0500
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
Subject: Re: [PATCH net v4 1/4] virtio-net: fix incorrect flags recording in
 big mode
Message-ID: <20251109163431-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029030913.20423-2-xuanzhuo@linux.alibaba.com>

On Wed, Oct 29, 2025 at 11:09:10AM +0800, Xuan Zhuo wrote:
> The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> checksummed packets handling") is to record the flags in advance, as
> their value may be overwritten in the XDP case. However, the flags
> recorded under big mode are incorrect, because in big mode, the passed
> buf does not point to the rx buffer, but rather to the page of the
> submitted buffer. This commit fixes this issue.
> 
> For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> buf address when unmapping for small packets") fixed it.
> 
> Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..59f116b609f6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2625,22 +2625,28 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  		return;
>  	}
>  
> -	/* 1. Save the flags early, as the XDP program might overwrite them.
> +	/* About the flags below:
> +	 * 1. Save the flags early, as the XDP program might overwrite them.
>  	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>  	 * stay valid after XDP processing.
>  	 * 2. XDP doesn't work with partially checksummed packets (refer to
>  	 * virtnet_xdp_set()), so packets marked as
>  	 * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
>  	 */
> -	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>  
> -	if (vi->mergeable_rx_bufs)
> +	if (vi->mergeable_rx_bufs) {
> +		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>  					stats);
> -	else if (vi->big_packets)
> +	} else if (vi->big_packets) {
> +		void *p = page_address((struct page *)buf);
> +
> +		flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
>  		skb = receive_big(dev, vi, rq, buf, len, stats);
> -	else
> +	} else {
> +		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>  		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
> +	}
>  
>  	if (unlikely(!skb))
>  		return;
> -- 
> 2.32.0.3.g01195cf9f


