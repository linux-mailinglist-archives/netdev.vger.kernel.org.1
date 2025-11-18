Return-Path: <netdev+bounces-239714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C88DC6BC31
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 361813671B8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E60430E837;
	Tue, 18 Nov 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpZGPWG6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tdlqrdnh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338830649B
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502516; cv=none; b=bw6f5w/AJ8L9ULMiKH019HeP6SEfuF0KhEqZhagvVfWfpXqsyYlMxNyQuxdA1lEPXsiGyedFPCkvTBcH43Yp2CMF6SQ/ShLvs3pZl9fBZo9Ek48Au+n1lAEtxpu8HV6blHzgJFjLsvKdACnpwdu/Smub6c1fVfs7fTkSXl1R8aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502516; c=relaxed/simple;
	bh=TPTgzrbVMNecIPQUYlT9kC0lc8aPV7SNalegsNW6Hz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYAsYtenQxrSAgls/M2M/igQmm1q2DteeVBq6DnUGMnJjs1v/u1dXwEEfUn+b6f6G8CHw1JjGZ1Wj8ZTYmo4yXGzZoH/kHatcSnPOtBTqdAJSxTVIy/QuaEnyNTdW4c3P58dj1e8hs+lA/j4ommb+xReAUKZXBigqjX2PpVt9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpZGPWG6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tdlqrdnh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763502513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sStvlBcr8OSiAiHYVCz0UTg8SNcwHDImj6MEoWSIFfM=;
	b=IpZGPWG6JHv57Qx9u1MXFOwhXWpTt7+2fi/GcF+WjI+m4N+YM4lmDFUCuAyPm4ijfS9hKV
	QhEYYBMXnmFMOzkT8919KjIMXuhHiRJtliFUx4X9Z7lKgw89xIduTHryIk4jGFxjcOpEeG
	Foqx/UHHT1+wLIYOZ8zRUxAjD5TunfU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-dS3xd-UvNumb0o_xk0-mKw-1; Tue, 18 Nov 2025 16:48:26 -0500
X-MC-Unique: dS3xd-UvNumb0o_xk0-mKw-1
X-Mimecast-MFC-AGG-ID: dS3xd-UvNumb0o_xk0-mKw_1763502505
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779981523fso28809675e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763502505; x=1764107305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sStvlBcr8OSiAiHYVCz0UTg8SNcwHDImj6MEoWSIFfM=;
        b=TdlqrdnhA3VxCsRJwGoVgh79BhlyUxCTUVERlkYsWbU0lDxh9H1pja/+ZcxGsojgCe
         Q85I3x+t7NHel+DBmQ0t30LUBiGJVB+9VVGSaT4hkVNuOPy4jsjmO51iLPlBwprgrA8I
         Yylx5aOBqqkrtjIx8jO1MXg1oEQ3WD4uiGZQmfrYbnko1todpN9LdlBxSAHAzQrXzY0w
         wicPXq4tv39ZsLYq+C/7bZqqHKJSibRXzg/SBBj8nFGJkkSVvrFm6NmIDi0G2d9WQyhN
         NGJe7hydOjJReHe+XikoiYtK4kFKp985fDa+1QRzi+i/mKJMSp3DOgvHPMdErHTrWwpp
         XQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763502505; x=1764107305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sStvlBcr8OSiAiHYVCz0UTg8SNcwHDImj6MEoWSIFfM=;
        b=PAl5/4vRXusJ4XU+grvx7zz2UZ+RlSwGsEYjAUd6j03meabOTL4UybQnD1GG5DC5KE
         H8lrHIvoCkjYym6zlvIdcN79AYT/d2jMCFgqRi2WP2fX7HZWLbue1S8Rwy1gMqshCGB7
         0/GqLVOq05itpYWTecLdpmnMw7fwEHHDSP7GKfDyM5WXH/kpOBSR927hafKovjLCScBI
         8GFTJX64eTgreV3VLoNOUYEBOeQBG8DaXFuwMIKGZAR94Z/PStX25HLy/bSvYtQsgG2l
         qGdujaOCqCWI2x+MHdWSpr980GxZ9Z/QhDoLi0B/fjVjDKAN4fVYWaW2KL/LKujpRqd2
         oHXA==
X-Gm-Message-State: AOJu0YxQLCdQv7dQgW55KGsGKMMT536cvvt7qxlLz8/HHof3msQBfi8y
	V7pcz6o+pHrkCYcU71uoCl1uGNjDV1bauSAkf4Vrav+eiWfKLraeeJfnxbxTS6aFjYlju9qFE4W
	uh8qFdnUg1eKQ4T4o+QJJanMe0CS96PicrTFTYmkOPQ6ROSpKo+TTrhjfOg==
X-Gm-Gg: ASbGnctudu3w6M2ZbbufWCiSj5Z6Iq22RbE9FyP6ja2sRzAfqVwOWKASpoNY2SFzQeb
	hhOd72vtQdfEJetbV+4t7ZH76E5xswSKu0o/ZxIWIoiPdXHiOPlYoVhPmtfOxdoI1P0ZEQXHnfp
	er+BU6icwfbd+P+uujKrEK7ygcG6ftwsKKaYdaNcvZGpXjqLpOMXrw6E0GLgXp2AjMqGlqzYLT+
	NSP3qV7TDZKjo7DuICA3jEYdbGDzYTCax0ASW/A2+YEXaDmPqp4hHyakDT6UoTGm1MHKoqhM8+o
	r2tfHGZNL9t63F4o6kLgd4j1oSXe2ZsKDZQJNvrr5kch0pHNKKJg1GWeWSYFHYPSoA8P954+Rkp
	IcUe8ffArt0Zj6KNBNKyIAJhiPwNiJQ==
X-Received: by 2002:a05:600c:45d4:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-4778fe5dde3mr222607785e9.16.1763502505362;
        Tue, 18 Nov 2025 13:48:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDmYO+o8e4AVZRDDZCetiy0Wy+fznwXJqQNCxPGDtsL+2uC5fri5NSn3L4Zgrurw3FDKvkYA==
X-Received: by 2002:a05:600c:45d4:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-4778fe5dde3mr222607595e9.16.1763502504967;
        Tue, 18 Nov 2025 13:48:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1022a32sm15144355e9.8.2025.11.18.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:48:24 -0800 (PST)
Date: Tue, 18 Nov 2025 16:48:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20251118164552-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-11-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-11-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:39:00AM -0600, Daniel Jurgens wrote:
> Implement support for IPV6_USER_FLOW type rules.
> 
> Example:
> $ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
> Added rule with ID 0
> 
> The example rule will forward packets with the specified source and
> destination IP addresses to RX ring 3.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4: commit message typo
> ---
>  drivers/net/virtio_net.c | 89 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 81 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c1adba60b6a8..78fc8f01b6c4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6932,6 +6932,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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

indent sizeof here please - align on ( not on !.

> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -6946,6 +6974,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  
>  	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
>  		return validate_ip4_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return validate_ip6_mask(ff, sel, sel_cap);
>  	}
>  
>  	return false;
> @@ -6968,11 +6999,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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

so this checks mask then copies but parse_ip4 copies unconditionally?
why?

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
> @@ -7108,6 +7166,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
>  	case IP_USER_FLOW:
> +	case IPV6_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -7150,7 +7209,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  	++(*num_hdrs);
>  	if (has_ipv4(fs->flow_type))
>  		size += sizeof(struct iphdr);
> -
> +	else if (has_ipv6(fs->flow_type))
> +		size += sizeof(struct ipv6hdr);
>  done:
>  	*key_size = size;
>  	/*
> @@ -7187,18 +7247,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
> 2.50.1


