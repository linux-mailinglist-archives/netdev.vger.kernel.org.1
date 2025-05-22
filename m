Return-Path: <netdev+bounces-192868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48AAAC16E3
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F66C5010C7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C0527AC2C;
	Thu, 22 May 2025 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhG7qy4G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7E2798F9
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953224; cv=none; b=sUpVPbi+ujgVd7YoapuY3NU6qGX8np/j2Bv4lX2ox8Id3Vm70udiQdMtjgy9qkCb3GWdpIBoW1qhN2ZCQ7i3nGM63YtA/+BQiqyS2lQLQ9KRtgr5ZKtD+Hdv0rIZiW+QeDHinoGZ0cWcriaNKqA/NKLJgpzKNeEIEWZB7vn7e4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953224; c=relaxed/simple;
	bh=rlV74owtlLZxOsX/UaNbJlFwOkVPv4oyaAVJACHDqck=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oCS47c17mrDYvvRvUTdAAi0C9xS4TWzQrvXeaJMKeA5fVnTvesA+81xRdmNJnOafIw6MtGsVQTZBboanPnylQDmfAsFKGsZNmPMNDoxwuFE6fY9MTDEC+XDuvgXUkAhsRIZ2aITsZy+S+VmoM4wWydPZAPYLK8VIyApCY+VbrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhG7qy4G; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c54f67db99so38222885a.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747953222; x=1748558022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGaQFmcO1JVQYqBeTPReiTwqsPkWDyFeRyBvzVNLp68=;
        b=NhG7qy4GmI+KlAhMXNMBo3xOvQaWBnMZ3+uilL6lRh6NDrFZeKMHS+P1OtCdVqIZUU
         fNw44Re7ygi3R9JzJqge9jS1EFQeYw31jgW12I3GYKNYIkb7Z02+wR7++ppaJ5TBRkgn
         o6Yugn9qDbHnuDBKMIVLyzVKfL15YvcIZdbkY6gpKV6MAZXq76C2dOEjEm1G0DaAytSm
         RrMYg1QgGT8QXpFGrR6V5dKw1M56+kQ/v1t60GVCmMqkmRgLIKMXPJWFe26sitviuMnf
         pE4M2q66YdXiMz+Gw0l4TWIib1/rm3PZzDz7PmbfPSKa/ZPv87AG8FU6ifNuPM6Nw9j+
         pYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747953222; x=1748558022;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NGaQFmcO1JVQYqBeTPReiTwqsPkWDyFeRyBvzVNLp68=;
        b=sFUMVOX3PrxFfH7MqGI1DRnqMcEdY3PaQIdyOCYGz9uy4tIcRuYAsj0/HE5ncwU5az
         AmHX0WFNUD/+v/lXEszLGh3yxJA3ar7Fo6zLfSBnqxU4dJy2pBNCQV1xiEDcI6csEqGF
         dtP78YfcR2AW02w58tf0bbDwFYbRvjIXj8C5TEMbJjrLpqgAd890HJ63UH3Ux9x2/pjU
         yVetMWs5RUcvg57L07vRNxSkP1yeKwZ5s0Pm/e7hUjMI4y11aiDUEk9Etlwq8FHEB6AR
         w75DrLSsAsO/be8r7gTg3fMMmveUgKRnx/UbjqEuF6xi+7oWHq32eYeQfdQ2ThxcSwax
         +rBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwoOfqvEmrOxYAD03W6kksEQVE5UeylXPTsiMx8wlb2Ost3AtWNNVLhRAGPKSREp5XiJkEr4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP7ol6rfN1UhfAMMFLtmFrX9IFSRqXOkTn3jDOqJUf0Ey3hE5P
	01BEX0eVmEGu1PpoDVkLB2Cd18x4pVRLCPfhJFmkMhimRHG+jd/UJPiX
X-Gm-Gg: ASbGncujsBLX+8QwsvGOOK+0Su4HbEOcnbkIgUOioX2wjVtzkvc1BvEh2UpZnwLqOUS
	X+NZiCY8gsFhkiLfnnHQgI9NHAbCeMxOgajxH+M7dxUl88oRk//mfpsI6EdeWCCXIw5dkBnZvb8
	XyiezPQ1/bAQVOJwtUa6kLK+FD3h+Nk4Z+XK3uilcs64I093qsp1UeXT0R4vwMRDAkBzj24jraK
	JkBM9MEa5N++yLyepCoG8czBOc6LwA5VZDHHlkWiRE11g3/M4T0PsqPH7RxrA8z7cLQxWej3aMz
	HJqm2t28xKk/VuN8IzsQDx1wczCguVbI9mD9PQ+D7cTclFRQycytRcITL1o89iOpmnzGbSPG//w
	uKULozm+OVS5WQ8EllwZa2ceSXBkB40lJYg==
X-Google-Smtp-Source: AGHT+IEnEcstKuBkGYDk9epUiUan0tChuvxfxSlPvlTZmHtCyoG87GDQ5Xr6gk4CL7vNE6Skc801uQ==
X-Received: by 2002:a05:620a:1913:b0:7c5:9480:7cb4 with SMTP id af79cd13be357-7cee226cdd9mr188001485a.9.1747953222027;
        Thu, 22 May 2025 15:33:42 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467ee660sm1082394085a.65.2025.05.22.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 15:33:41 -0700 (PDT)
Date: Thu, 22 May 2025 18:33:41 -0400
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
Message-ID: <682fa6453d18f_13d837294ac@willemb.c.googlers.com.notmuch>
In-Reply-To: <239bacdac9febd6f604f43fa8571aa2c44fd0f0b.1747822866.git.pabeni@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <239bacdac9febd6f604f43fa8571aa2c44fd0f0b.1747822866.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next 6/8] virtio_net: enable gso over UDP tunnel
 support.
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
> If the related virtio feature is set, enable transmission and reception
> of gso over UDP tunnel packets.
> 
> Most of the work is done by the previously introduced helper, just need
> to determine the UDP tunnel features inside the virtio_net_hdr and
> update accordingly the virtio net hdr size.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++++++++---------
>  1 file changed, 62 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 71a972f20f19b..3ca275ab887fe 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -46,11 +46,6 @@ static bool virtio_is_mapped_offload(unsigned int obit)
>  	       obit <= VIRTIO_OFFLOAD_MAP_MAX;
>  }
>  
> -#define VIRTIO_FEATURE_TO_OFFLOAD(fbit)	\
> -	({								\
> -		unsigned int __f = fbit;				\
> -		__f >= VIRTIO_FEATURES_MAP_MIN ? __f - VIRTIO_O2F_DELTA : __f; \
> -	})

This was introduced two patches ago. Never used. Remove entirely from the series.

>  #define VIRTIO_OFFLOAD_TO_FEATURE(obit)	\
>  	({								\
>  		unsigned int __o = obit;				\
> @@ -85,16 +80,30 @@ static const unsigned long guest_offloads[] = {
>  	VIRTIO_NET_F_GUEST_CSUM,
>  	VIRTIO_NET_F_GUEST_USO4,
>  	VIRTIO_NET_F_GUEST_USO6,
> -	VIRTIO_NET_F_GUEST_HDRLEN
> +	VIRTIO_NET_F_GUEST_HDRLEN,
> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
> +	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED,
> +	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED,
> +#endif
>  };
>  
> -#define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> +#define __GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
>  				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
>  				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
>  				(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
>  				(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
>  				(1ULL << VIRTIO_NET_F_GUEST_USO6))
>  
> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
> +
> +#define GUEST_OFFLOAD_GRO_HW_MASK (__GUEST_OFFLOAD_GRO_HW_MASK | \
> +	(1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED) | \
> +	(1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED))
> +#else
> +
> +#define GUEST_OFFLOAD_GRO_HW_MASK __GUEST_OFFLOAD_GRO_HW_MASK
> +#endif
> +
>  struct virtnet_stat_desc {
>  	char desc[ETH_GSTRING_LEN];
>  	size_t offset;
> @@ -443,9 +452,14 @@ struct virtnet_info {
>  	/* Packet virtio header size */
>  	u8 hdr_len;
>  
> +	/* UDP tunnel support*/

space before closing asterisk

> +	u8 tnl_offset;
> +
>  	/* Work struct for delayed refilling if we run low on memory. */
>  	struct delayed_work refill;
>  
> +	bool rx_tnl_csum;
> +

There are an awful lot of non consecutive bools here. Probably would
be a nice cleanup to conver to an integer bitfield. Maybe not for this
series.

>  	/* Is delayed refill enabled? */
>  	bool refill_enabled;
>  

