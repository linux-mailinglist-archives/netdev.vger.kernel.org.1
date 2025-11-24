Return-Path: <netdev+bounces-241336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8758DC82C96
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 00:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1923E4E38B9
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D44B2F656A;
	Mon, 24 Nov 2025 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccuXeqhI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9/eLG/5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACBC2F363C
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025951; cv=none; b=oi0z9NJrLCducVMEYF+KYAd9BlQizpW/dw2/jiB7xlopfougoSfjDBPE5ARuzVUUCWgnSXF7L9O4Dl2KO0HCUQjqc35JNGYEv0WDar4Egix4fmkO18V81sr8qIPxySEsXKdD2XpMCvHgEwqvxjvXSg/MFnbhie47SawDsEe9nHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025951; c=relaxed/simple;
	bh=t+dQyxsBUhLUAbNkjKawqLLJkl8sAq5hrGHFsew7x/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4XatH6SlenW5stXCZTPPIfV+uIUlR7i83bsEXFAXIPt5wvRAp7Me6NXWwyOAVGCp8tJ/Am9n4eAruEJ83JeT+nkEFZJdwo8weYQJhSet6Y5HQDigUdsSUToi3C8Bzn+A02AiuCRepzvVc5gqETt0fblj9jgRUaOFjpt7fn8X0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccuXeqhI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9/eLG/5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764025948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbkmiqvkCCftq3VuUnSJTTGS10mvI3AeaWokAUq0+2o=;
	b=ccuXeqhIejNUupROJs72e+Cdk9AiW9mpA3YU+h5MMaBdE+J0PvUKb+HlxSuBBuF8A2IIDY
	wnN55EpuWVUW4v0zmAt/juBrDNHVNoT7FPNYlcXE/tnF1IpBNMFH6DUX0bbSEUHzsPqCRs
	S48jMzbLdGV62WT9n84R9Ql5O4a6or8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-W7sDxujFNC2vyeKe7SyIMA-1; Mon, 24 Nov 2025 18:12:26 -0500
X-MC-Unique: W7sDxujFNC2vyeKe7SyIMA-1
X-Mimecast-MFC-AGG-ID: W7sDxujFNC2vyeKe7SyIMA_1764025945
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477212937eeso28394375e9.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 15:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764025945; x=1764630745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bbkmiqvkCCftq3VuUnSJTTGS10mvI3AeaWokAUq0+2o=;
        b=V9/eLG/5ZsY09tPo1LTpcLMGqvh3GP1u9MvRu3lHQndymW2gRYgjMRp2Q5uyHY7aKH
         n+jXl5G4u4/43IcnRlDs2UKMLcWYINgtQXkqzcAFJtY8FcUFTCFfYzWpmiUeEmAJd7c3
         oUWxxcqcnoGN43vgUjAOI9p/BzKPq0duBmnOVpEe/hnRicQedXXehonkJ6n3bEDW6OGC
         bXyFhHYz67kU60lRDWilAiNOMwTMk3B30N4MYy0pSBzl37Lz3BvrDr1dUdMUYXLiPUG1
         Kv36rcM6mYC7AvYcgX6E0s7uQ1t4IZ0a7MyC6rFSFd0X5plYoB8MfGjQjoAHK1GHSNZl
         tIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764025945; x=1764630745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbkmiqvkCCftq3VuUnSJTTGS10mvI3AeaWokAUq0+2o=;
        b=DOn58e2pGr0InLHMEAHRodbwxvxeOTP+FFsdqAgXP4p2/pcrHwjccsiJQluvHK7uTp
         SJZkQYYLPENlXIjBRzslBZcosAOz0iIPH6onm3ndSXj5W9SkNO3j9qIVOzfcdc+HUkFo
         z4N+bJ8QpWsbhtTKViofzqejhF6wu9HFGromjwm8GE9BnVy/U36Jzh/6EcNwvjX8E4Ep
         z5Pk/yY2oXtTZkLt8PgbPjHuU0FdPc/zeT3skaLxp7b28U5UFOTE7ci/kjC6zi2GacYk
         VTpjgxdXpPKqZxebHUmlt+/ISkCTLhYBT3NB++SYdo5KFSg1BqtA3jRr8LgIOylGVk0A
         meWQ==
X-Gm-Message-State: AOJu0Yy1ta7VeXSF90DNkH/KdQh6jqzaKMtyeg+il5hysxM7RxDDTFoh
	fV4m3KLVJ+bEWjJnwQtleqlQYl3RWYTMuSbkvbgx9g85PeJd9pwilwX2kzCT7WGbOmTtkCHCTnU
	U6k2LghuSM2f9C+aVrOuD/ziTq8S1nGPERGHHIfChHyb079cWUNPIgxycNg==
X-Gm-Gg: ASbGncvbNeCtkykNh7MPOK7GXvlI+hlkzCG6eyextJFuiNGFJ8eoLBMUsBZetfGIudT
	ewkEEGlrNffuYZgy0pTu9+jISG7tRYxg0/+lopb5tkVH8yJhoxa0OfvbIRDQgLuUVU+UeXdMIG5
	3SRdlcN4akCV30QNWiItay8NEg6IVsqJOwMjBOXAVwU6QK5vZmSwh8C1FMy0cuEAmncz1s5EeeE
	IRzrSAek9tNjpL+DztCtoWjSrmqZX0wtfRStGSp1RBsENV8YZk1P2cYNv+Ztydha5ivn26RZs63
	H4bRPbKjnKc/Dl6QDNJ5CzFOJyWF54cRsrnikJXNNuUxg9QKSsiQflbUNsMh0ogfgjNQkZnMgE9
	i42Rs09/5YUYJNTbWxlmbV1EJE3aTYQ==
X-Received: by 2002:a05:600c:4f46:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-477c1103099mr131145985e9.2.1764025945312;
        Mon, 24 Nov 2025 15:12:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE97kAFAAvBCPRt2eYieLcnYMtDDOkrkjPisgwhzw+CQWl2ZNHnhkcNLeBayfDzFQDI18+Wbg==
X-Received: by 2002:a05:600c:4f46:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-477c1103099mr131145785e9.2.1764025944867;
        Mon, 24 Nov 2025 15:12:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bd1580cbsm104150135e9.2.2025.11.24.15.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:12:24 -0800 (PST)
Date: Mon, 24 Nov 2025 18:12:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20251124180941-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-11-danielj@nvidia.com>
 <20251124165246-mutt-send-email-mst@kernel.org>
 <16f665a8-6b4b-4722-93d7-69f792798be4@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f665a8-6b4b-4722-93d7-69f792798be4@nvidia.com>

On Mon, Nov 24, 2025 at 05:04:30PM -0600, Dan Jurgens wrote:
> On 11/24/25 3:59 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:15:21PM -0600, Daniel Jurgens wrote:
> >> Implement support for IPV6_USER_FLOW type rules.
> >>
> 
> >>  	return false;
> >> @@ -5958,11 +5989,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> >>  	}
> >>  }
> >>  
> >> +static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> >> +		      const struct ethtool_rx_flow_spec *fs)
> >> +{
> > 
> > I note logic wise it is different from ipv4, it is looking at the fs.
> 
> I'm not following you here. They both get the l3_mask and l3_val from
> the flow spec.

yes but ipv4 is buggy in your patch.

> > 
> >> +	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
> >> +	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
> >> +
> >> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
> >> +		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
> >> +		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
> >> +	}
> >> +
> >> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
> >> +		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
> >> +		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
> >> +	}
> > 
> > Is this enough?
> > For example, what if user tries to set up a filter by l4_proto ?
> > 
> 
> That's in the next patch.

yes but if just this one is applied (e.g. by bisect)?


> > 
> >> +}
> >> +
> >>  static bool has_ipv4(u32 flow_type)
> >>  {
> >>  	return flow_type == IP_USER_FLOW;
> >>  }
> >>  
> >> +static bool has_ipv6(u32 flow_type)
> >> +{
> >> +	return flow_type == IPV6_USER_FLOW;
> >> +}
> >> +
> dr);
> >>  
> >> -	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> >> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> >> -	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> >> -	    fs->m_u.usr_ip4_spec.ip_ver ||
> >> -	    fs->m_u.usr_ip4_spec.proto)
> >> -		return -EINVAL;
> >> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> >> +		    fs->m_u.usr_ip6_spec.l4_4_bytes)
> >> +			return -EINVAL;
> >>  
> >> -	parse_ip4(v4_m, v4_k, fs);
> >> +		parse_ip6(v6_m, v6_k, fs);
> > 
> > 
> > why does ipv6 not check unsupported fields unlike ipv4?
> 
> The UAPI for user_ip6 doesn't make the same assertions:
> 
> /**
> 
>  * struct ethtool_usrip6_spec - general flow specification for IPv6
> 
>  * @ip6src: Source host
> 
>  * @ip6dst: Destination host
> 
>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
> 
>  * @tclass: Traffic Class
> 
>  * @l4_proto: Transport protocol number (nexthdr after any Extension
> Headers)                                          ]
>  */
> 
> /**
>  * struct ethtool_usrip4_spec - general flow specification for IPv4
>  * @ip4src: Source host
>  * @ip4dst: Destination host
>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
>  * @tos: Type-of-service
>  * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
>  * @proto: Transport protocol number; mask must be 0
>  */
> 
> A check of l4_proto is probably reasonable though, since this is adding
> filter by IP only, so l4_proto should be unset.


maybe run this by relevant maintainers.
> 
> > 
> >> +	} else {
> >> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> >> +		selector->length = sizeof(struct iphdr);
> >> +
> >> +		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> >> +		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> >> +		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> >> +		    fs->m_u.usr_ip4_spec.ip_ver ||
> >> +		    fs->m_u.usr_ip4_spec.proto)
> >> +			return -EINVAL;
> >> +
> >> +		parse_ip4(v4_m, v4_k, fs);
> >> +	}
> >>  
> >>  	return 0;
> >>  }
> >> -- 
> >> 2.50.1
> > 


