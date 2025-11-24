Return-Path: <netdev+bounces-241306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE99C829D8
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9347234A7AF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662BC331A78;
	Mon, 24 Nov 2025 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYjwwmWJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJMyp1Ix"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A044331A5D
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021564; cv=none; b=fBXHxyWuRrdj0JCSxnXyo+iqyVt9cpKraW1a8CZDGcdsVueGj5XMRC0RWLsPidgzsJQrZXGK8d6SwjnhBkQAchrFTDiKLghYjuIpk9WcxIICeJlQ9wurzYnbQBDK7we6EXagjA8U4HTzHfwVjgWxZcZSXLT1/hg4/sJYqL7F2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021564; c=relaxed/simple;
	bh=Js9zql4OgnnEBD7cr5m1CxyZi+lfX0iqvKkLedjQ8QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ+stGsgoDafBo1Xe2c3eEzv9ABFl3FfRGAH+KaP44OpScQpATjqlV+586ZmfhugtuYuf/OcycmJ+Q0oEdhT1nT68LCDfgzBEvMxWUzcCkxcs2TKw37QbbX4G9czF+KdMW+McaP1vJyHHNGYisgFBd7t3pjRoFTHJe38JNgibpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYjwwmWJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJMyp1Ix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764021561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+YMo5H3YOL7jAqTWtFFIZqMJZpECBZ8f74TJyFBR38=;
	b=QYjwwmWJfz/DiEHYGHcSmu9tHiZ+CAAUxZjDs1pWgTafYYcIRpGOJf4t/99K3jg7G/2ETZ
	O7azMIpQ37TtIRGaFxc2AbAprayrMxE+SK2BxVLe1gvC/5V1T5UJU9JqJ1HHeYFtJeP+Qx
	q0rGr7dW52OhY8cm1Ia4PmvlM3bnh4I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-dNbbSN_0PVG8N2M99FvPQg-1; Mon, 24 Nov 2025 16:59:20 -0500
X-MC-Unique: dNbbSN_0PVG8N2M99FvPQg-1
X-Mimecast-MFC-AGG-ID: dNbbSN_0PVG8N2M99FvPQg_1764021559
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cbed2b8fso2665712f8f.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764021559; x=1764626359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+YMo5H3YOL7jAqTWtFFIZqMJZpECBZ8f74TJyFBR38=;
        b=hJMyp1Ixw9fdCh+1Q+phI+rBDp4Ki+kv1GABPQECVYz5D7qp3vHu9MNZH/iUzyJ40/
         E8XknxomVEppBmhBQ+6zHj/wmbmb6WNDaCYCnpoaGViv/GVsbbQdK38PpYSFr4gnqr3T
         ZUdbrQQ4+3mX1jMymO/1648zgVSt0T07oXmCQ41JlImAi2ejPC3F6nN5kaM/pU6Y5cje
         s8Es6WIc9Ts8WOm8P2lzuCgVbQju9dkS7Vfp7nryu3fdRtiH0+zJmEjkW/fJqJR/jdPt
         HdpHXHUJ0CWq2jBFFyUfFdTC5V8yggoZFvbPxAbWsjV5i7ce3Kja5/NSMiDNaZz8Ha4e
         gGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764021559; x=1764626359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+YMo5H3YOL7jAqTWtFFIZqMJZpECBZ8f74TJyFBR38=;
        b=s2Lktwjbw4Xkduy9p5rvI+tjMlXA4mFIGocQWzHqOxUfmH2rTvyYjX1jS064lgEixY
         9jHIPZ8j1KCkPZAx3FZ6TS+tEvaLLVHOrcbw9GOS0/vG0v29On9cUsfbDZJxZ4rmD7+R
         YT5TF0huwBEZBWcL/ZX93Yb/JwPjl/pIyXOPqqMGSLuWFP4nsukSF2FOX9MWPsVaVh0Y
         scZyfkqDjWf/ZCm4qKMgIEQeyDomD9BrmNeqtdEj6CMN1v2r/xint5ioVSVRpWSQe9Zs
         NdfVDD711ebHFFkSJrQW/rQBVdAG7+ROUEwGk7HsRMAV9Iaf/wid4yrguHm/kjAa/nao
         P2nw==
X-Gm-Message-State: AOJu0Yw3HADo5FdcvYhrV7pyXds+GyOOx1kZCSMdhZxYKp0beLurhE1W
	rF8QgXzgsEE2m/5zE076yHQqFiAN4oW64kI7U96WLbpowy2NjJMqrwUTg3C+inMHFuFPXVl8zqE
	cO8PuAr/vcxt/AuwIEy97SDvs5zovmb/w/xJy+VHHcPsblffxdvKE4T5iYiFrZPylvQ==
X-Gm-Gg: ASbGncu1Ln8+zBYnZH3E1cuG6muvlsEkFXcwiMvbOejQgXC5fZwXUpkcInx3iu5YTyj
	HiFsXHks5KZUGJujCftXmkVLAyS3vED7rbLUZNvtwyFAkjk1gsd9BvMXrRzHLI5gX/oSmQCzKej
	i/wWfCpA8wt2W6Y9PsurBOY5y5SqSfl3S9CnWkukQ39FulUJFBxKIxZOoR3mlkBDL3FQ6iV1F76
	yFYsW7iXZbHIdctOr5DxZTu3eVunQVcxobRs51aqrQVSrFxHC1YC4D+y15/YLa/JO42R/5rUX3T
	X415v3g9zRfzVlzft5MLqyab91xFWX8aDFCvZ83t70KXLFqlkvAPlIUJt058qlwWw/ozcDw3dxD
	Rf2venKM27X8v7AD2ybckB8NhmHkl3g==
X-Received: by 2002:a05:6000:420e:b0:426:d5a0:bac8 with SMTP id ffacd0b85a97d-42cc1d19624mr15321383f8f.56.1764021558706;
        Mon, 24 Nov 2025 13:59:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOmSX5mj9MaFFqRaX6/7n+Y65AhzF6tbw5qWchg4LDEwTyYYy89Tcq3gxbCKSQXJxm4RNtRQ==
X-Received: by 2002:a05:6000:420e:b0:426:d5a0:bac8 with SMTP id ffacd0b85a97d-42cc1d19624mr15321363f8f.56.1764021558157;
        Mon, 24 Nov 2025 13:59:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ffesm31331232f8f.10.2025.11.24.13.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:59:17 -0800 (PST)
Date: Mon, 24 Nov 2025 16:59:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20251124165246-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-11-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119191524.4572-11-danielj@nvidia.com>

On Wed, Nov 19, 2025 at 01:15:21PM -0600, Daniel Jurgens wrote:
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
> 
> v12:
>   - refactor calculate_flow_sizes. MST
>   - Move parse_ip6 l3_mask check to TCP/UDP patch. MST
>   - Set eth proto to ipv6 as needed. MST
>   - Also check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
>   - Remove tclass check in setup_ip_key_mask. If it's not suppored it
>     will be caught in validate_classifier_selectors.  MST
>   - Changed error return in setup_ip_key_mask to -EINVAL
> ---
> ---
>  drivers/net/virtio_net.c | 92 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 82 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b0b9972fe624..bb8ec4265da5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5922,6 +5922,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
> +			       sizeof(cap->nexthdr), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -5936,6 +5964,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  
>  	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
>  		return validate_ip4_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +		return validate_ip6_mask(ff, sel, sel_cap);
>  	}
>  
>  	return false;
> @@ -5958,11 +5989,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  	}
>  }
>  
> +static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> +		      const struct ethtool_rx_flow_spec *fs)
> +{

I note logic wise it is different from ipv4, it is looking at the fs.

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

Is this enough?
For example, what if user tries to set up a filter by l4_proto ?


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
> @@ -6099,6 +6152,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
>  	case IP_USER_FLOW:
> +	case IPV6_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -6138,6 +6192,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  		++(*num_hdrs);
>  		if (has_ipv4(fs->flow_type))
>  			size += sizeof(struct iphdr);
> +		else if (has_ipv6(fs->flow_type))
> +			size += sizeof(struct ipv6hdr);
>  	}
>  
>  	BUG_ON(size > 0xff);
> @@ -6165,7 +6221,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>  
>  	if (num_hdrs > 1) {
>  		eth_m->h_proto = cpu_to_be16(0xffff);
> -		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
> +		if (has_ipv4(fs->flow_type))
> +			eth_k->h_proto = cpu_to_be16(ETH_P_IP);
> +		else
> +			eth_k->h_proto = cpu_to_be16(ETH_P_IPV6);
>  	} else {
>  		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
>  		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> @@ -6176,20 +6235,33 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> -	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> -	    fs->m_u.usr_ip4_spec.ip_ver ||
> -	    fs->m_u.usr_ip4_spec.proto)
> -		return -EINVAL;
> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +		    fs->m_u.usr_ip6_spec.l4_4_bytes)
> +			return -EINVAL;
>  
> -	parse_ip4(v4_m, v4_k, fs);
> +		parse_ip6(v6_m, v6_k, fs);


why does ipv6 not check unsupported fields unlike ipv4?

> +	} else {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +		selector->length = sizeof(struct iphdr);
> +
> +		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> +		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> +		    fs->m_u.usr_ip4_spec.ip_ver ||
> +		    fs->m_u.usr_ip4_spec.proto)
> +			return -EINVAL;
> +
> +		parse_ip4(v4_m, v4_k, fs);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.50.1


