Return-Path: <netdev+bounces-239713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6E7C6BC07
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 75B392B314
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7AA37031B;
	Tue, 18 Nov 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzPX3M90";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsSvSiOU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D924C676
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502328; cv=none; b=oEXIxuJKiUfJZgCbwtpm8LoiibJZYhL0keZGGlIEq05MZQkQ4AU82l5C1fxQSXj3onLUPFw560VqRqEzQJ/lZcHjX4QWnAShGlDUvowq9lax490vsCeWQe9jM8VebZJZj8waIp+6oJ5N3jb1gyz8227CZycxT0eYpUx2l8PYNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502328; c=relaxed/simple;
	bh=EWVoiStL8xxc8fjRAlKEGJa+L4prc8/ogGMYl/n3jNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF4q2Qgtc9xRF8q37WtXfzVW+ntq8MVsqagEj7N4mRKxxkibaDU3gynRrKno98wsMtlnWWd0r21u2D5dPuUDYfUIVMCtktCWi12wYCx9PEBMIoSR7l+0hsGu9xmUopEAomSrn2wvDv/iLEMsHYT1Gjw+uHKXGzMvN4bhF4QKRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TzPX3M90; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsSvSiOU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763502325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xmcD+jsjC8wZ84+RswPoQFo8c1DNHek5aHXjd3P3kGk=;
	b=TzPX3M90fdG7GZOXl/WZsYay2G6OZtHJIFyX5r7c64Q0dR5u8gzNf5cbEzVAhMRNSWr7dV
	+9XHgn52puWbqX2U951kSRFJMRXcKGHi3gEzvreIfL02OdGriaI8A0DljztocefNEv/GE/
	hrF/ALCqSmlDrk0i7hqL2JZpMJrZN8k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-QMIDcjCSNLWlEzj_tKMDnA-1; Tue, 18 Nov 2025 16:45:19 -0500
X-MC-Unique: QMIDcjCSNLWlEzj_tKMDnA-1
X-Mimecast-MFC-AGG-ID: QMIDcjCSNLWlEzj_tKMDnA_1763502318
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b366a76ffso3180718f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763502318; x=1764107118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xmcD+jsjC8wZ84+RswPoQFo8c1DNHek5aHXjd3P3kGk=;
        b=CsSvSiOUslfrnu6eju6JJCDc9sEAVN8jgTzv+8eENnbX8640khnggiXj86Lb2hrM22
         fmXuBM/+L5EB62rTifGH3Q727EkT/k+Kfc1oweqK2w0B+Bu289Tw40VBc0V7JzN1JcUx
         u6Wom7uebbFMC6GKwL/KGCHRnMhjcKbqnvikLIAZTIccksSSrG95WIFbhMVR6UigeEDq
         dinzJJ/W3MMa36JbhtFsKkAsOTMmKiYYe0jikDWpqBb7lJRnGrkPj+H5vdoQyCDiCGGj
         odDdWgEpn8H1pTiVuUmjdzu4kRx9IZFvfYRZDFMwaR05qo7Tc200VgYWgcI4uaD0sH1i
         l8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763502318; x=1764107118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmcD+jsjC8wZ84+RswPoQFo8c1DNHek5aHXjd3P3kGk=;
        b=s9WCeJGHX2KkOGvVRcL4JH8kWn2vlH0uk0Yku0zRFobPcD44guiW4S30NDeSHs82et
         Acm29AxQHAjkFhu2WOBmAnCDogy9U7gz9aaHAfnTj/MhZbdkS0MQ4dNiG+HKU3i4G81l
         BYG+Dj0XjxaqwmMQ3N/Wfmn+DQyV/pLhAuQ/O54UBPg+S6Gx5M/TNo5dXKS0rc+7UzL4
         iR1zD3akzepHL9ETFtdCoTVgmu8DggYv0y/AyHzr6uC6oH+Updczrj503uSm23s9bTZh
         gTKToLNthRsKlDRiNnAj4e6WLbLoeSusH0ouDnCLkCDJDY9cMocFK8/rLJeFVuGhU/4u
         lUZQ==
X-Gm-Message-State: AOJu0Yz/hs07HDUoBfNYVD3yw5usF2q3Pepyg5Bq0UU3ilvA653MGred
	AZqYhVXpOxtdo1hKIXAtQaKnvdbWCu/ctYpPSQfXQ/KsXdhfBTEMnEQGI9iCClDpHbV4rXjRuu8
	bqISMbJ8CP+bqZeiG1OOghS/S0I4ctPH3BqD/IQnJV8ELmQ4syi4TYEGOj4Za4d3Mfg==
X-Gm-Gg: ASbGncuqGAznsP6gfRC9KQJQ3ro6bE48bcntEn9rzNDVHSs6iTFzk9B4A16bZqPjpcc
	xPawRkvsNcUNfpy64gvnmnqayMGefxbD/p9XocCQVY/ZQouXoy3kwynkfiGWHjTIBbZ5BoST2iW
	1ynfBXXPy+Hy1BD0soasj2vYcn8Kxwj79gpPN04WglThKbCjt1AVGZLRt/AsQqSWycxMYhctcNX
	Y49GleN5cdJmDVU0P3VF3qdRloMTNkckVuoFH0aaMgHYCDoaIJ6VCv47fUw8djmAxv2p41n9xUk
	aMQAGQ3+L1MfzzV6tEF5Vv6MBVtzmIDw8D5RYVlHnIlphHRBHcN5nc08Az0DLp0+iRgzF4Ea952
	6NMWW4hGD/RORtD4Uluf5FvVtsMIZgg==
X-Received: by 2002:a05:6000:615:b0:425:75c6:7125 with SMTP id ffacd0b85a97d-42b5934f2famr15507762f8f.16.1763502318142;
        Tue, 18 Nov 2025 13:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6pbEaOuD4MXi0DZA4VBiHWLk/LNDtUUFYZniNj6WmjWygzYmgIegGsNOm3BN26F6K9mlM8g==
X-Received: by 2002:a05:6000:615:b0:425:75c6:7125 with SMTP id ffacd0b85a97d-42b5934f2famr15507746f8f.16.1763502317590;
        Tue, 18 Nov 2025 13:45:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f174afsm33416600f8f.33.2025.11.18.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:45:17 -0800 (PST)
Date: Tue, 18 Nov 2025 16:45:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20251118164400-mutt-send-email-mst@kernel.org>
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


I find it weird that this does not modify setup_eth_hdr_key_mask

So it still hardcodes ETH_P_IP for all IP flows?
For IPv6, should it not use ETH_P_IPV6 instead?

how does it work?

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


