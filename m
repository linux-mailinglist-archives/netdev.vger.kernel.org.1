Return-Path: <netdev+bounces-243007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26547C980B6
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB3B3A35D6
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB34032C928;
	Mon,  1 Dec 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHVUuRJi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFa7U5k4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A632B9BA
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602775; cv=none; b=pB56va009GoeRrxNvMI2sOxvZLYY5JWT2vw7ZhzCDAkUlt4uNdxjiWwwWlG+s3TeNtNtp3kzWsuErsUC39qS6SXqYpUXF3h+uLs0IqrZznnuskPUi23wKOXpPkgCYoSyiZjy8jcJMuvZGXWfWrOks9k3cbXo5rDs2c0SgRPtUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602775; c=relaxed/simple;
	bh=o8FwZFVQ2xFRn5zK/Fo7fYLnpOCexob3KmOkeJg/AUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqlKd8h7ane9YSdzJgsG+UU6xXi8RDNVRpruKIgfprHfEpWbkOrG0O6YjN+M5l9k41tURt2btEMng6/ve6PvSKKJTUw23yXdFQAjblyJE1NHquRmsJhQb/Gql8QwV6D2tdVp52XMLuJ51vTEeAmi/366VJVtAijVYLxJ1UglSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHVUuRJi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFa7U5k4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764602771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eTikolJriVieHtqa7nqQrvJ8OFM9g4/uewLustTZkbs=;
	b=FHVUuRJiCInf0VyhLylyv9zTRkwZvqZcwga5x6gIyZg374DMEYEptpNYx/DVcLeWp6jvku
	oooUER56phxGkZqqlvluDBqrsBtsWWpmLpVmqMCKnRHmF+wLemiQMg75+IIviAGBxUI7H2
	Bi+RAmPjzY7iCy9Z3m0oIuuMTyBdaIc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-Y7kvQXP6NViQoSwJ6mZrtw-1; Mon, 01 Dec 2025 10:26:10 -0500
X-MC-Unique: Y7kvQXP6NViQoSwJ6mZrtw-1
X-Mimecast-MFC-AGG-ID: Y7kvQXP6NViQoSwJ6mZrtw_1764602769
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b771bfe9802so95399866b.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 07:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764602769; x=1765207569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTikolJriVieHtqa7nqQrvJ8OFM9g4/uewLustTZkbs=;
        b=YFa7U5k4nKos/HtsPTjdnVuytKA7GNSWiRSXdzrBurNHTaPB3VgJqabllDNAQTv2a3
         nuTnhcSxqCihQc8vS4rmo3okAjZEmFNzMqoGlxsbjbVbEXJmq5J3+CgE1MBscYmXyM97
         3saTNMksFsvckcvXoWMwZJNzPrbVQwc2NcGDfoihotB6vSbZb8sBIe5uJhKqohb1Cst8
         5kpg2XIvJeG330p9pMr1gtY7YL/XxYnsIt7ESWUAGt57vmoaaCS1ZQ8lhfPlPMIJEEG1
         cFJLVAc/7GSxt2W3FgSEJyoXoxnUstCgmVXAN4U7OruWYdttPZDDtPsTNMphARDDCQHp
         jZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764602769; x=1765207569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTikolJriVieHtqa7nqQrvJ8OFM9g4/uewLustTZkbs=;
        b=oTDV+zTwnz7Ntauq85prQrShRg4jtTcVawduLSWF/htvNaP+fgvyIbbbrvRU/Vv+66
         hlc7JlRqYw27REV/vWtNr9hsMRxvKojqpl5hljTRFSJiOK8SGKfuAc2WY4x1NfAm8MzQ
         Iy2+gislimjKmYJ8vxV/IgdtDddRHETPbTFUWVEXfoR5M3QM4ZuB6k5hq+pW0WbqxHJk
         Dh2+ZqZRI3tohwcY68IgKeWmMzC5DgQJxCq00DXHIsH0r85p8W9e+nmxBdTXIbB4RofJ
         qthJ6U5IvMAYNOZLHCu7E/I0wZQ1HDTydPaWCzZ1NgDfOc7jv52flCx/ywPngEvSNCnh
         TEBA==
X-Gm-Message-State: AOJu0YwBTBWllgORZDEhGqeVm7hZZv2gGAZX4ywS7ge83bC/a0oZYsJd
	io8HQq4c/zNpDomIg6rYp6uVsDmLcprEffUYVvXkfLKoTtGjDurqAJLbY/6O4da8A2QYJgsCPLX
	v+SYI40UwjtU7TAGhKh2khDi1VX+ZRPZW87w+tcs6eHrMOOJ1Gx8H7pl7Rg==
X-Gm-Gg: ASbGncsezpMaZjA3Xjs4nqMvKE6SFzl635J5lNQiANZTkHXGY1kGNxGb2xWJRJZFVzt
	PTrsArNDrczyGz0RXBPoHIlIvEI/bPMzePO0XnLsmvoMV6+Yt5LgT64t90eJ6PgDZGgCgbN4SAc
	HzyqcMQjpT6SDDGJUqCuhdHCfSonr3bzE1M6yYwjgfnF8raq3tpd68RTBGRQPp7QjfNMqTe2Tib
	rLKSSmzStr2/PP0+LR8c35B/TPvjADyvotWRI4Me/5zoT0r8U/v6jfI+vY2LcAmPUuPtYeXZGFa
	rS/BzKRFD+Om8j4+WUypptBh9kgPLUTQOLzPpGslmcfKcdwAJX/3cmqH6CU6Sm+lbZD/Tej5PR6
	haZD7
X-Received: by 2002:a17:907:984:b0:b76:bcf5:a388 with SMTP id a640c23a62f3a-b76c563c139mr2865406466b.50.1764602769016;
        Mon, 01 Dec 2025 07:26:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/R1Nj40/3I+dbcJE/UMwSYe/bAkEM9LSlgj2Lgf/+8Z9Zt4nu3arZ5g20uw9nPnbXsrts1Q==
X-Received: by 2002:a17:907:984:b0:b76:bcf5:a388 with SMTP id a640c23a62f3a-b76c563c139mr2865402266b.50.1764602768441;
        Mon, 01 Dec 2025 07:26:08 -0800 (PST)
Received: from redhat.com ([2a06:c701:73f0:bd00:7951:f7c0:f4c7:a98f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a7afb4sm1229484066b.70.2025.12.01.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 07:26:07 -0800 (PST)
Date: Mon, 1 Dec 2025 10:26:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20251201102256-mutt-send-email-mst@kernel.org>
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-12-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126193539.7791-12-danielj@nvidia.com>

On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
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
>  drivers/net/virtio_net.c | 229 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 215 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 28d53c8bdec6..908e903272db 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5963,6 +5963,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
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


given you are parsing tcphdr you should include uapi/linux/tcp.h 

for udp - uapi/linux/udp.h

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
> @@ -5980,11 +6026,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>  		mask->tos = l3_mask->tos;
>  		key->tos = l3_val->tos;
>  	}
> +
> +	if (l3_mask->proto) {
> +		mask->protocol = l3_mask->proto;
> +		key->protocol = l3_val->proto;
> +	}
>  }
>  
>  static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> @@ -6022,16 +6107,35 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
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
> @@ -6171,6 +6275,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
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
> @@ -6212,6 +6320,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
> @@ -6251,7 +6365,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>  
>  static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
> -			     const struct ethtool_rx_flow_spec *fs)
> +			     const struct ethtool_rx_flow_spec *fs,
> +			     int num_hdrs)
>  {
>  	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> @@ -6263,27 +6378,99 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  		selector->length = sizeof(struct ipv6hdr);
>  
>  		/* exclude tclass, it's not exposed properly struct ip6hdr */
> -		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> -		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
> -		    fs->h_u.usr_ip6_spec.tclass ||
> +		if (fs->h_u.usr_ip6_spec.tclass ||
>  		    fs->m_u.usr_ip6_spec.tclass ||
> -		    fs->h_u.usr_ip6_spec.l4_proto ||
> -		    fs->m_u.usr_ip6_spec.l4_proto)
> +		    (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +				      fs->m_u.usr_ip6_spec.l4_4_bytes ||
> +				      fs->h_u.usr_ip6_spec.l4_proto ||
> +				      fs->m_u.usr_ip6_spec.l4_proto)))
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
> @@ -6323,6 +6510,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	struct virtio_net_ff_selector *selector;
>  	struct virtnet_classifier *c;
>  	size_t classifier_size;
> +	size_t key_offset;
>  	int num_hdrs;
>  	u8 key_size;
>  	u8 *key;
> @@ -6355,11 +6543,24 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
>  
>  	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
> +		key_offset = selector->length;
>  		selector = next_selector(selector);
>  
> -		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
> +		err = setup_ip_key_mask(selector, key + key_offset,
> +					fs, num_hdrs);
>  		if (err)
>  			goto err_classifier;
> +
> +		if (has_udp(fs->flow_type) || has_tcp(fs->flow_type)) {
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


