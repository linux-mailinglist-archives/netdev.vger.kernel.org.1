Return-Path: <netdev+bounces-226519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84EBA16B8
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 22:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE60166909
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B269320CAB;
	Thu, 25 Sep 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJKzv4Dj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50F271A9A
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833280; cv=none; b=gVSbyq7YVc6BpOgIyk5zW98Ktlf3fR1jIMQyiz1id/f3oWrQbUSvaxVxI+GcqY7gjziaL4f85xSd0fSCJZEciq786naq73kUXsL9+zxb7tQrhb/3T17HlqHrV0QMr61w5Gv+TnzMwsOuPv68uzuAA/pnxkMaJEjaOJ5TOndJd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833280; c=relaxed/simple;
	bh=vv1qT8fOOxz4P2aDEkoamPsKw/+5vRplAQYBiNFpwgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utg5QVaT4JXjYGFAuv1NHQVGClF7qyI3NFHp8IUqwnOZ0lX23Wqm7Hhq+Opp+xiSD+6EnbYtKYaipdmrciO1YJXW7K4BgUYEJVZKv4JjfmCOiGilelyrC8ETdfyf/+PK/QVCFpTnjvV9D/Rle2ov7rSOV+rQ//pKquIdv7n8rv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJKzv4Dj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758833277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sG0c/Qg9PuQWEUfT6xJTnuG9wSgs8VT4bht8XQ+1qgg=;
	b=SJKzv4DjxfxWlOCM4OzaHSt6+3rdGUd6I+/jNgLbgiPiIRtITlaCS/QGGdvgYMBRw0ugdW
	+AbGZ5j7HCF+agiwEWsFSBiL2sCshsGGy7bIK+HBreqy3hJRDXsn4Y1aRxY/jK8GVbM/0q
	tViPnk0ejhp+jiBbml+JeX35HLT9Rjg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-E28yWEFvO-iDkazVTLtEng-1; Thu, 25 Sep 2025 16:47:55 -0400
X-MC-Unique: E28yWEFvO-iDkazVTLtEng-1
X-Mimecast-MFC-AGG-ID: E28yWEFvO-iDkazVTLtEng_1758833275
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f42b54d159so1030316f8f.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833275; x=1759438075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG0c/Qg9PuQWEUfT6xJTnuG9wSgs8VT4bht8XQ+1qgg=;
        b=LsXSohGnmiFZWAPec3AKDiqyb2PWrQDBzG7s5B8R8Rcv78icWo1+JMHmiFanq0Ej+0
         tMs8yOQR7R/eWm4MhX5lk2QDbpgIFXN3mY4HegtrMx31xwbukwBsCjIvHxru5K3bIR+w
         phmigbkUKXtlDkTvJ9ClA+7W0wVn9L0/439HZLhZocQo6YZbI9njbVX0qePjHWYTCdF4
         WIoUwTP/MV6UUWJzuJMeEbu8x4uqOXFeHGrku9nxlqB5p6iv9jXlaB+uMVv37BYCe5Tx
         UnNnOq0KjFhVCzx6xMued1p2CFCQq2qCMDr5ybGZIgCynAP4YwDMgJwMaMGo/4CIxhlF
         Fw2A==
X-Gm-Message-State: AOJu0Yw1ati6FFeDiHhfU/icOG4v8DjjXZov5tyHR/rHE7fY+gN+9seW
	v/VeJHMq6z7Pyi8hM4fQgyW3VNIftS3nx9T6pf9Mnl0ZS4pMHCZzWWtXP5mXRbXJb+TQLzJmEuD
	K8041M6SFaE/eI9z5MIE+XYPJkh7mI8MTcyRk6R+jISDsQYhQv13rJBufog==
X-Gm-Gg: ASbGncuczSVM+5Lt33CPskoVaGz/zizMkyj2NXHFhVsusxLLWuhcMC0oy3x/GTvhfhH
	KB8bTGJIXIuNAM4+tE4g0f2oteP61Mv4KuVpFiQOreyZInB5wIGX0aEzgvx/3XXVUm19K4Dyjcz
	DUFdowowhXziSRQGrxslWzxfcHPRnoQxMJuE26yWVmKq9ZIzv3O6bDje/5z/DQp+wL5I2NRXtPE
	H/sAch94+U5CRB+ubXpajW0mJWN1kcWBEtHXWIP08qqno+ckyVzRiZ523I22MyPJ6i8MTc21i1Q
	zOm/5vpRqw7osiQk3F7bPjrj29VeE+6AFw==
X-Received: by 2002:a05:600c:3b8e:b0:45f:2cf9:c236 with SMTP id 5b1f17b1804b1-46e329d4744mr61060875e9.4.1758833274635;
        Thu, 25 Sep 2025 13:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDfEyEaPjw+sH25J0AnTpfCAxI5nak9eeL4uYfANblZHdjS1y/uomSUQxYhcmeiuL/n546Ag==
X-Received: by 2002:a05:600c:3b8e:b0:45f:2cf9:c236 with SMTP id 5b1f17b1804b1-46e329d4744mr61060695e9.4.1758833274178;
        Thu, 25 Sep 2025 13:47:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac55esm100238695e9.6.2025.09.25.13.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:47:53 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:47:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 09/11] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20250925164519-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-10-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923141920.283862-10-danielj@nvidia.com>

On Tue, Sep 23, 2025 at 09:19:18AM -0500, Daniel Jurgens wrote:
> Implement support for IPV6_USER_FLOW type rules.
> 
> Example:
> $ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
> Added rule with ID 0
> 
> The example rule will forward packets with the specified soure and


source


> destination IP addresses to RX ring 3.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net/virtio_net_ff.c | 89 +++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
> index 0374676d1342..ce59fb36dae9 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.c
> +++ b/drivers/net/virtio_net/virtio_net_ff.c
> @@ -118,6 +118,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
>  	return true;
>  }
>  
> +static bool validate_ip6_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct ipv6hdr *cap, *mask;
> +
> +	cap = (struct ipv6hdr *)&sel_cap->mask;
> +	mask = (struct ipv6hdr *)&sel->mask;
> +
> +	if (!ipv6_addr_any(&mask->saddr) &&
> +	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
> +			       sizeof(cap->saddr), partial_mask))
> +		return false;
> +
> +	if (!ipv6_addr_any(&mask->daddr) &&
> +	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
> +			       sizeof(cap->daddr), partial_mask))
> +		return false;
> +
> +	if (mask->nexthdr &&
> +	    !check_mask_vs_cap(&mask->nexthdr, &cap->nexthdr,
> +	    sizeof(cap->nexthdr), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -132,6 +160,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  
>  	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
>  		return validate_ip4_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return validate_ip6_mask(ff, sel, sel_cap);
>  	}
>  
>  	return false;
> @@ -154,11 +185,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  	}
>  }
>  
> +static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> +		      const struct ethtool_rx_flow_spec *fs)
> +{
> +	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
> +	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
> +
> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
> +		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
> +		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
> +	}
> +
> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
> +		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
> +		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
> +	}
> +
> +	if (l3_mask->l4_proto) {
> +		mask->nexthdr = l3_mask->l4_proto;
> +		key->nexthdr = l3_val->l4_proto;
> +	}
> +}
> +
>  static bool has_ipv4(u32 flow_type)
>  {
>  	return flow_type == IP_USER_FLOW;
>  }
>  
> +static bool has_ipv6(u32 flow_type)
> +{
> +	return flow_type == IPV6_USER_FLOW;
> +}
> +
>  static int setup_classifier(struct virtnet_ff *ff,
>  			    struct virtnet_classifier **c)
>  {
> @@ -291,6 +349,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
>  	case IP_USER_FLOW:
> +	case IPV6_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -332,7 +391,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  	(*num_hdrs)++;
>  	if (has_ipv4(fs->flow_type))
>  		size += sizeof(struct iphdr);
> -
> +	else if (has_ipv6(fs->flow_type))
> +		size += sizeof(struct ipv6hdr);
>  done:
>  	*key_size = size;
>  	/*
> @@ -369,18 +429,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
>  			     const struct ethtool_rx_flow_spec *fs)
>  {
> +	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> +	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
>  	struct iphdr *v4_k = (struct iphdr *)key;
>  
> -	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> -	selector->length = sizeof(struct iphdr);
> +	if (has_ipv6(fs->flow_type)) {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
> +		selector->length = sizeof(struct ipv6hdr);
>  
> -	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> -	    fs->h_u.usr_ip4_spec.tos ||
> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> -		return -EOPNOTSUPP;
> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip6_spec.tclass)
> +			return -EOPNOTSUPP;
>  
> -	parse_ip4(v4_m, v4_k, fs);
> +		parse_ip6(v6_m, v6_k, fs);
> +	} else {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +		selector->length = sizeof(struct iphdr);
> +
> +		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip4_spec.tos ||
> +		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> +			return -EOPNOTSUPP;
> +
> +		parse_ip4(v4_m, v4_k, fs);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.45.0


