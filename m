Return-Path: <netdev+bounces-241307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A444C829E4
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B59E3ACB36
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6EF334C28;
	Mon, 24 Nov 2025 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JicxD7QX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRN4Antg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE52F39B9
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021787; cv=none; b=c29sGKkkb6OT9xSa0MGlubAb3WeGTCPqPLm7sMRYPqcGkUg6Y6DV+KpDk2hGtWRfB8rrerbiAVSpc87Ly/UOaptha7rMFZblMT8wK4pvewOr+7EsflCj0gznoSK+kY1Bh8XuD4vyKuW0mD4k7PHaJ/FhNmPJReGcJB7LQt7dEmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021787; c=relaxed/simple;
	bh=UzmZ4JZ4FIRYr0P3sojXXIpUWGlp2SOuZbJ+WJiq8C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFY5hQcZM1kk8hbqSbGVTvidqcw7OMMjsBOovmYge5yYEDPpwC06LLdLqdQ+9NQMKpN8/xWfj/hVWmh18uSoKe+SC9Sj5IofPE1m2GsrhrGxUlnZOoQFMJDOAdtzEcWiJPiJHCDyXH1vsImXeqDSir22oO1UKF+tES7kTkoqp+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JicxD7QX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRN4Antg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764021783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0JhuHVIms7jkxQWWfNx7f+RKOZNrOLy8i2f1ZMv9aa0=;
	b=JicxD7QXRrUXi5APCOw8njquSGL2sGy60L5rWBpgni18h0DGFe2GvbfZRuKsfneSd4xE9j
	0D70Zf+VZ6Zopxk6q8iJJRf96o/aGfuNgX0f7vbRK4cu8F/ZvgzvgM1RWqjtHH27ycmKBH
	pLYXiPrFJ7ZZBYgV5BRya34FHpGzIuc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-Moe5pkOZOCmuDIl1VArRYw-1; Mon, 24 Nov 2025 17:03:01 -0500
X-MC-Unique: Moe5pkOZOCmuDIl1VArRYw-1
X-Mimecast-MFC-AGG-ID: Moe5pkOZOCmuDIl1VArRYw_1764021780
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cce847c4so3390833f8f.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 14:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764021780; x=1764626580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JhuHVIms7jkxQWWfNx7f+RKOZNrOLy8i2f1ZMv9aa0=;
        b=YRN4AntgQkE6rro6NFDmrOv58ztc4Hzo/+GhJDRiXfv7O0uU+eegsccGO/ySH+1uvo
         Onkv5g2OVXDTL8tKVP20G1Cqj2aJ3FyEGzHQjW7GOU8+UcMHhg4y/Yf9Khr19C0SNjQk
         zS8ZFrSA9iX1SkBO+eAGyN3jvlo2NWq4F4eOPep42FHWU9z08FjXgRSfqm8ibIsECoN6
         lrK2wHNlOWMEZwteEHFy1ZxDdLhpvw00MnGlibAMAD0c4gPcxph+eI0Yqp5UkF28vY5r
         AkqmbBhE17Kp0Hsw4rO5IxMweN4hO2Lyr4filMWLYgyApPpuaH2hK8m39zG4+gSGV/X8
         7pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764021780; x=1764626580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JhuHVIms7jkxQWWfNx7f+RKOZNrOLy8i2f1ZMv9aa0=;
        b=rVBIiCyeQ6ssL3WGscSScuv+wu84IXe131eYK/hc+1PnRumcWdIn1uGyvlhRltDYpK
         iJPGy/WguxEyHlMS9PQu3l3Uow9L97hxIYm/OyZOmgk/3P3QtJYBe3/XzDRRwimBezSu
         U3sVe6f05i3LrJcaSz/c96YcLLp9U/QTjJ+DLH984D53cvItdue7Ehk/rBoerCcR+eFb
         65vS5J+FVMROWvWofWLU1LIm5TwIeoZt65/vhqdMnNv4nJsPr7joknenpH1WkV1D6aYs
         Hl3Coo0uWcMGyCvZqkEqOtOJlfzrNRA+C2Rt4MZFKSVkpXzSXeNSPWKcztrzdO2dNtAT
         SsSQ==
X-Gm-Message-State: AOJu0YxiKl7o/OE/jDrTfzlpTKNdQ5GpFMaoKWf1IcKP0EFiwDQPhWIF
	1Q6wpwE2ZaZ+1oSphrNgi0ZlPKWoWd9RlSmAbsepsj0P77VQ3I3pYkWCXIErX3BGmQ8vrWgfQT6
	kC7ppUS2hAl2TQmLGPQuOQCYMc7V3zLPmag+A2yA1zaCPPzWSkTdsakcvOA==
X-Gm-Gg: ASbGncvhC6ECjOxjEbBlfKqKk9wX1cY3RBSmuNYNUtiKUDHPGwTXeNmdxg1/Rvi5F+z
	DTp6A+UeK5VbWC8Nj7DhTs+AFhCHKwJkRFw1xifOPomisSgbLSXU7voHX6Yb1CvABAcKPITTmGT
	tV7mnb/TGE7xvvF2cc+Aw2DJuUryp5WDMnA93D/BIo719l99ZsKe055cDH42/v1xRPbXq30gHyh
	L79uQWHstBzkaIVUyOt1Fa0w8LGOgQKa+0LSnA7pNRi0VVDp63HVE3VLUeFBuH8WykHP/LzePOR
	hkpmQizSiqi43qHkB5CNiNm3L9Wrx4wDvZ2AATwLBBcTTqDG+kLVKmni+ViSwFVE1dkXD6Vf7TE
	473KwH7THWLGY+926dZyUFPdOx4wJpQ==
X-Received: by 2002:a05:6000:186b:b0:42b:3dbe:3a53 with SMTP id ffacd0b85a97d-42cc1d0c716mr15152369f8f.40.1764021780241;
        Mon, 24 Nov 2025 14:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh9ZIHDZbys51wQMG/TUIVh5V+sCNtsy4yhJ+PKJR3RAQlsBA/V34iuOCd3W/fC9BI7f84tw==
X-Received: by 2002:a05:6000:186b:b0:42b:3dbe:3a53 with SMTP id ffacd0b85a97d-42cc1d0c716mr15152332f8f.40.1764021779636;
        Mon, 24 Nov 2025 14:02:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7ec454csm29446534f8f.0.2025.11.24.14.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:02:58 -0800 (PST)
Date: Mon, 24 Nov 2025 17:02:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20251124165953-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-12-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119191524.4572-12-danielj@nvidia.com>

On Wed, Nov 19, 2025 at 01:15:22PM -0600, Daniel Jurgens wrote:
> Implement TCP and UDP V4/V6 ethtool flow types.
> 
> Examples:
> $ ethtool -U ens9 flow-type udp4 dst-ip 192.168.5.2 dst-port\
> 4321 action 20
> Added rule with ID 4
> 
> This example directs IPv4 UDP traffic with the specified address and
> port to queue 20.
> 
> $ ethtool -U ens9 flow-type tcp6 src-ip 2001:db8::1 src-port 1234 dst-ip\
> 2001:db8::2 dst-port 4321 action 12
> Added rule with ID 5
> 
> This example directs IPv6 TCP traffic with the specified address and
> port to queue 12.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4: (*num_hdrs)++ to ++(*num_hdrs)
> 
> v12:
>   - Refactor calculate_flow_sizes. MST
>   - Refactor build_and_insert to remove goto validate. MST
>   - Move parse_ip4/6 l3_mask check here. MST
> ---
> ---
>  drivers/net/virtio_net.c | 223 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 212 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index bb8ec4265da5..e6c7e8cd4ab4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5950,6 +5950,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
>  	return true;
>  }
>  
> +static bool validate_tcp_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct tcphdr *cap, *mask;
> +
> +	cap = (struct tcphdr *)&sel_cap->mask;
> +	mask = (struct tcphdr *)&sel->mask;
> +
> +	if (mask->source &&
> +	    !check_mask_vs_cap(&mask->source, &cap->source,
> +	    sizeof(cap->source), partial_mask))
> +		return false;
> +
> +	if (mask->dest &&
> +	    !check_mask_vs_cap(&mask->dest, &cap->dest,
> +	    sizeof(cap->dest), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool validate_udp_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct udphdr *cap, *mask;
> +
> +	cap = (struct udphdr *)&sel_cap->mask;
> +	mask = (struct udphdr *)&sel->mask;
> +
> +	if (mask->source &&
> +	    !check_mask_vs_cap(&mask->source, &cap->source,
> +	    sizeof(cap->source), partial_mask))
> +		return false;
> +
> +	if (mask->dest &&
> +	    !check_mask_vs_cap(&mask->dest, &cap->dest,
> +	    sizeof(cap->dest), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -5967,11 +6013,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  
>  	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
>  		return validate_ip6_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_TCP:
> +		return validate_tcp_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_UDP:
> +		return validate_udp_mask(ff, sel, sel_cap);
>  	}
>  
>  	return false;
>  }
>  
> +static void set_tcp(struct tcphdr *mask, struct tcphdr *key,
> +		    __be16 psrc_m, __be16 psrc_k,
> +		    __be16 pdst_m, __be16 pdst_k)
> +{
> +	if (psrc_m) {
> +		mask->source = psrc_m;
> +		key->source = psrc_k;
> +	}
> +	if (pdst_m) {
> +		mask->dest = pdst_m;
> +		key->dest = pdst_k;
> +	}
> +}
> +
> +static void set_udp(struct udphdr *mask, struct udphdr *key,
> +		    __be16 psrc_m, __be16 psrc_k,
> +		    __be16 pdst_m, __be16 pdst_k)
> +{
> +	if (psrc_m) {
> +		mask->source = psrc_m;
> +		key->source = psrc_k;
> +	}
> +	if (pdst_m) {
> +		mask->dest = pdst_m;
> +		key->dest = pdst_k;
> +	}
> +}
> +
>  static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  		      const struct ethtool_rx_flow_spec *fs)
>  {
> @@ -5987,6 +6067,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  		mask->daddr = l3_mask->ip4dst;
>  		key->daddr = l3_val->ip4dst;
>  	}
> +
> +	if (l3_mask->proto) {
> +		mask->protocol = l3_mask->proto;
> +		key->protocol = l3_val->proto;
> +	}
>  }
>  
>  static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> @@ -6004,16 +6089,35 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
>  		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
>  		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
>  	}
> +
> +	if (l3_mask->l4_proto) {
> +		mask->nexthdr = l3_mask->l4_proto;
> +		key->nexthdr = l3_val->l4_proto;
> +	}
>  }
>  
>  static bool has_ipv4(u32 flow_type)
>  {
> -	return flow_type == IP_USER_FLOW;
> +	return flow_type == TCP_V4_FLOW ||
> +	       flow_type == UDP_V4_FLOW ||
> +	       flow_type == IP_USER_FLOW;
>  }
>  
>  static bool has_ipv6(u32 flow_type)
>  {
> -	return flow_type == IPV6_USER_FLOW;
> +	return flow_type == TCP_V6_FLOW ||
> +	       flow_type == UDP_V6_FLOW ||
> +	       flow_type == IPV6_USER_FLOW;
> +}
> +
> +static bool has_tcp(u32 flow_type)
> +{
> +	return flow_type == TCP_V4_FLOW || flow_type == TCP_V6_FLOW;
> +}
> +
> +static bool has_udp(u32 flow_type)
> +{
> +	return flow_type == UDP_V4_FLOW || flow_type == UDP_V6_FLOW;
>  }
>  
>  static int setup_classifier(struct virtnet_ff *ff,
> @@ -6153,6 +6257,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  	case ETHER_FLOW:
>  	case IP_USER_FLOW:
>  	case IPV6_USER_FLOW:
> +	case TCP_V4_FLOW:
> +	case TCP_V6_FLOW:
> +	case UDP_V4_FLOW:
> +	case UDP_V6_FLOW:
>  		return true;
>  	}
>  
> @@ -6194,6 +6302,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  			size += sizeof(struct iphdr);
>  		else if (has_ipv6(fs->flow_type))
>  			size += sizeof(struct ipv6hdr);
> +
> +		if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
> +			++(*num_hdrs);
> +			size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
> +							 sizeof(struct udphdr);
> +		}
>  	}
>  
>  	BUG_ON(size > 0xff);
> @@ -6233,7 +6347,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>  
>  static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
> -			     const struct ethtool_rx_flow_spec *fs)
> +			     const struct ethtool_rx_flow_spec *fs,
> +			     int num_hdrs)
>  {
>  	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> @@ -6244,23 +6359,95 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
>  		selector->length = sizeof(struct ipv6hdr);
>  
> -		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> -		    fs->m_u.usr_ip6_spec.l4_4_bytes)
> +		if (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +				      fs->m_u.usr_ip6_spec.l4_4_bytes))
>  			return -EINVAL;
>  
>  		parse_ip6(v6_m, v6_k, fs);
> +
> +		if (num_hdrs > 2) {
> +			v6_m->nexthdr = 0xff;
> +			if (has_tcp(fs->flow_type))
> +				v6_k->nexthdr = IPPROTO_TCP;
> +			else
> +				v6_k->nexthdr = IPPROTO_UDP;
> +		}
>  	} else {
>  		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
>  		selector->length = sizeof(struct iphdr);
>  
> -		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> -		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> -		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> -		    fs->m_u.usr_ip4_spec.ip_ver ||
> -		    fs->m_u.usr_ip4_spec.proto)
> +		if (num_hdrs == 2 &&
> +		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> +		     fs->m_u.usr_ip4_spec.l4_4_bytes ||
> +		     fs->m_u.usr_ip4_spec.ip_ver ||
> +		     fs->m_u.usr_ip4_spec.proto))
>  			return -EINVAL;
>  
>  		parse_ip4(v4_m, v4_k, fs);
> +
> +		if (num_hdrs > 2) {
> +			v4_m->protocol = 0xff;
> +			if (has_tcp(fs->flow_type))
> +				v4_k->protocol = IPPROTO_TCP;
> +			else
> +				v4_k->protocol = IPPROTO_UDP;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int setup_transport_key_mask(struct virtio_net_ff_selector *selector,
> +				    u8 *key,
> +				    struct ethtool_rx_flow_spec *fs)
> +{
> +	struct tcphdr *tcp_m = (struct tcphdr *)&selector->mask;
> +	struct udphdr *udp_m = (struct udphdr *)&selector->mask;
> +	const struct ethtool_tcpip6_spec *v6_l4_mask;
> +	const struct ethtool_tcpip4_spec *v4_l4_mask;
> +	const struct ethtool_tcpip6_spec *v6_l4_key;
> +	const struct ethtool_tcpip4_spec *v4_l4_key;
> +	struct tcphdr *tcp_k = (struct tcphdr *)key;
> +	struct udphdr *udp_k = (struct udphdr *)key;
> +
> +	if (has_tcp(fs->flow_type)) {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_TCP;
> +		selector->length = sizeof(struct tcphdr);
> +
> +		if (has_ipv6(fs->flow_type)) {
> +			v6_l4_mask = &fs->m_u.tcp_ip6_spec;
> +			v6_l4_key = &fs->h_u.tcp_ip6_spec;
> +
> +			set_tcp(tcp_m, tcp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
> +				v6_l4_mask->pdst, v6_l4_key->pdst);
> +		} else {
> +			v4_l4_mask = &fs->m_u.tcp_ip4_spec;
> +			v4_l4_key = &fs->h_u.tcp_ip4_spec;
> +
> +			set_tcp(tcp_m, tcp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
> +				v4_l4_mask->pdst, v4_l4_key->pdst);
> +		}
> +
> +	} else if (has_udp(fs->flow_type)) {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_UDP;
> +		selector->length = sizeof(struct udphdr);
> +
> +		if (has_ipv6(fs->flow_type)) {
> +			v6_l4_mask = &fs->m_u.udp_ip6_spec;
> +			v6_l4_key = &fs->h_u.udp_ip6_spec;
> +
> +			set_udp(udp_m, udp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
> +				v6_l4_mask->pdst, v6_l4_key->pdst);
> +		} else {
> +			v4_l4_mask = &fs->m_u.udp_ip4_spec;
> +			v4_l4_key = &fs->h_u.udp_ip4_spec;
> +
> +			set_udp(udp_m, udp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
> +				v4_l4_mask->pdst, v4_l4_key->pdst);
> +		}
> +	} else {
> +		return -EOPNOTSUPP;
>  	}
>  
>  	return 0;
> @@ -6300,6 +6487,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	struct virtio_net_ff_selector *selector;
>  	struct virtnet_classifier *c;
>  	size_t classifier_size;
> +	size_t key_offset;
>  	int num_hdrs;
>  	u8 key_size;
>  	u8 *key;
> @@ -6332,11 +6520,24 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
>  
>  	if (num_hdrs != 1) {
> +		key_offset = selector->length;
>  		selector = next_selector(selector);
>  
> -		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
> +		err = setup_ip_key_mask(selector, key + key_offset,
> +					fs, num_hdrs);
>  		if (err)
>  			goto err_classifier;
> +
> +		if (num_hdrs >= 2) {


So elsewhere it is num_hdrs > 2 here it's >= 2 ...

all this is confusing.



Can you please add some constants so reader can understand why
is each condition checked.



For example, is this not invoked on ip only filters? num_hdrs will be 2,
right?

> +			key_offset += selector->length;
> +			selector = next_selector(selector);
> +
> +			err = setup_transport_key_mask(selector,
> +						       key + key_offset,
> +						       fs);
> +			if (err)
> +				goto err_classifier;
> +		}
>  	}
>  
>  	err = validate_classifier_selectors(ff, classifier, num_hdrs);
> -- 
> 2.50.1


