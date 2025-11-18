Return-Path: <netdev+bounces-239709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0DDC6BB88
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 61E0629A93
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA8B285CB6;
	Tue, 18 Nov 2025 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haEpFLim";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="URGMwFbK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDAC299931
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763501483; cv=none; b=C0YbphMuU0od4piwrmjq658oY2vThCmWXkrNdbK7h0mcN2YfnskJSMhNf/9xvyJdFevGMDY0iTasr/Vz2sH0A3WVa9NC3zn29y460gifkqWkOsRsyYL8sTvsjsSOJHtR2uP3sWqt44AOi7gHZoUTB6//nHv8tIT8ZNRi7Qf9elA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763501483; c=relaxed/simple;
	bh=Rpu6WiuC87Ce+ui/bfvmt+q6RF6yHHIfC9lqi0kEvcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4Zs7px0StEOSydEbmpuOD9R6sBN6+WwXrkRbvqDhx9Wj/GWDzLhHixaNdkkqqwkJ3zWTTymJ4aX1UQDPLBbuBxZplNidx4iT9slQo9XNSTuYsdv+rE8CaPHYV61QIBZb7kJCV1T+V86CMBqn7Dzrjykw8Nvx7QbPa7MhbbiSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haEpFLim; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=URGMwFbK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763501479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXuVUW9cULZrgMlSP3F/R09NU+THIw38zacHvgl+tdo=;
	b=haEpFLimvsF9F9eSCiE+Mv15DLZPngjHJqi6rMcKaYAB8Qbr0RsgXg6UW6Wb8gr1uRxxx0
	FOEEi1MgZdSz4rZY2isP4BCykf/PT5Grjod4cL0sEr759RuUzHb9MMOrOewA7B+Z/CRTIA
	EebKyzVRjdn+NR1UvMKOH6vimtt0u8I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-TUyi2lBeM-qsN1dzVUA2uQ-1; Tue, 18 Nov 2025 16:31:16 -0500
X-MC-Unique: TUyi2lBeM-qsN1dzVUA2uQ-1
X-Mimecast-MFC-AGG-ID: TUyi2lBeM-qsN1dzVUA2uQ_1763501476
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso3288216f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763501475; x=1764106275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXuVUW9cULZrgMlSP3F/R09NU+THIw38zacHvgl+tdo=;
        b=URGMwFbKRcczWdfpOeU0QHEF56m7GXnZVxlQPJWW/YZqZKr9i0JyEFevmuxybHXbkt
         SFQ5qnRJvkBeYsC+iEh1+YgLLQXGqmWk9/P3qxK2O7WdSr3UwxdrDx2/vCXbW9uX0V3r
         uYpTkuDApbwvCgHrEBtRuI4oRSRAkHrVO5mN++AVKafAcuEWDrB1/gsEMlaS7f175cXI
         sntX21oktiU4uubzDvrZhfAKEdiuWldajCNYNFic0Z8TKY9yLdfvicmm5tHtxp9mDrLC
         s3g+wlSemnClV44lx+crt+3uZNNaQnYNaIyFkDfCXSaSscX58bTFD77dh5jmU7m6CRK7
         wtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763501475; x=1764106275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXuVUW9cULZrgMlSP3F/R09NU+THIw38zacHvgl+tdo=;
        b=RAmQEliyLbeA6mHsZ5TeGcXplkbr/bbs2lQEjX5Xmaq8bMARDoeyvAazWugHqOcXPA
         MVGNJnA6QUVIqPKX+98YsjDNOfFnRbL+kuU2M0k+bwimne9kTcxpYlanq+2Oz8szl1pf
         2j6yzI/bMApS8/MQfE+T/xwq9C0Es0871SF4+P2m1PPKgjFWJtO4mqd2Y0eLOlM60U/3
         t7D1u1yWz1e6I6/Quqhm3S/0DR28U/udBHRgWmvoY9TyDRYIxsOARMofMg0JwvdW9KlC
         eg8GlLEdUr6+r7jCxaBl88+KM0Hkuo0l2OxXWD0pGmxd07Li7THv3L7Da73WbgYSK0sR
         C5jQ==
X-Gm-Message-State: AOJu0YzxXWOFUHi82CNq5X6XhbIDTRIuohZtpSLTIAK5ngZtTioRT1sk
	bI+zEFr8DgCIhDwEF+rfrJ+DwHPPIwvozudaDWQK0DY+08+Q3jvBoYLD0zblxUm8MFoXkP2uBhG
	cLo80zE87zuB3zXBbwSkcqWx/6FV4j0Sw19tthdE96iumxBaSIH5NdtIBOg==
X-Gm-Gg: ASbGncslTP/sXJSvwwFE7JSqXa338Rr5vdr8ieEzbwfD4E/6uNdeCZgu32zTvxkHq69
	pom7tjNAOeK6CDmlfTo3zySsRgP3dFvhOKOIJFk08ZkIOW5ZeUbGXYxz+LLAuTVnvJzSE7gey/H
	viC4pfXHLDZEiPGcZl+XROkdSz6MZsrjBDHEuUWi9UEqUoyBzlyUPK4512+l3tgv9n3fcWS5XLL
	Gz4XZTT9vmsgB7kUalqGMsaq1hoPOpSASJxKWpGR892OcwDMHxInnMmuw2MXPvr8dWK5avewdPc
	QgbHkQ6ewfHGnJPMsDutSbktwqc9w/iIn7ZUDnziTqP880eOKJCLZtOkwhrfT2LNA9JVXy7BfUn
	RWBJAoZg1Is1kSlJ/lPZLMFvrzzTXKQ==
X-Received: by 2002:a05:6000:4202:b0:429:f050:adbb with SMTP id ffacd0b85a97d-42b5935092dmr17736305f8f.26.1763501473474;
        Tue, 18 Nov 2025 13:31:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu38DvC86w3LRimVQliXUo6EbnnHvWPNcGjX4pRxB9qHJOJk/98ijr3Q/Yz/69RWLRzwM+Mw==
X-Received: by 2002:a05:6000:4202:b0:429:f050:adbb with SMTP id ffacd0b85a97d-42b5935092dmr17736172f8f.26.1763501469376;
        Tue, 18 Nov 2025 13:31:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42c97745f79sm20005459f8f.23.2025.11.18.13.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:31:08 -0800 (PST)
Date: Tue, 18 Nov 2025 16:31:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251118161734-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-10-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:38:59AM -0600, Daniel Jurgens wrote:
> Add support for IP_USER type rules from ethtool.
> 
> Example:
> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
> Added rule with ID 1
> 
> The example rule will drop packets with the source IP specified.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4:
>     - Fixed bug in protocol check of parse_ip4
>     - (u8 *) to (void *) casting.
>     - Alignment issues.
> ---
>  drivers/net/virtio_net.c | 122 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 115 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f392ea30f2c7..c1adba60b6a8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6904,6 +6904,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
>  	return true;
>  }
>  
> +static bool validate_ip4_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct iphdr *cap, *mask;
> +
> +	cap = (struct iphdr *)&sel_cap->mask;
> +	mask = (struct iphdr *)&sel->mask;
> +
> +	if (mask->saddr &&
> +	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
> +			       sizeof(__be32), partial_mask))
> +		return false;
> +
> +	if (mask->daddr &&
> +	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
> +			       sizeof(__be32), partial_mask))
> +		return false;
> +
> +	if (mask->protocol &&
> +	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
> +			       sizeof(u8), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -6915,11 +6943,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
>  	switch (sel->type) {
>  	case VIRTIO_NET_FF_MASK_TYPE_ETH:
>  		return validate_eth_mask(ff, sel, sel_cap);
> +
> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +		return validate_ip4_mask(ff, sel, sel_cap);
>  	}
>  
>  	return false;
>  }
>  
> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> +		      const struct ethtool_rx_flow_spec *fs)
> +{
> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
> +
> +	mask->saddr = l3_mask->ip4src;
> +	mask->daddr = l3_mask->ip4dst;
> +	key->saddr = l3_val->ip4src;
> +	key->daddr = l3_val->ip4dst;
> +
> +	if (l3_mask->proto) {

you seem to check mask for proto here but the ethtool_usrip4_spec doc
seems to say the mask for proto must be 0. 


what gives?


> +		mask->protocol = l3_mask->proto;
> +		key->protocol = l3_val->proto;
> +	}
> +}
> +
> +static bool has_ipv4(u32 flow_type)
> +{
> +	return flow_type == IP_USER_FLOW;
> +}
> +
>  static int setup_classifier(struct virtnet_ff *ff,
>  			    struct virtnet_classifier **c)
>  {
> @@ -7054,6 +7107,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  {
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
> +	case IP_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -7082,11 +7136,23 @@ static int validate_flow_input(struct virtnet_ff *ff,
>  }
>  
>  static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
> -				 size_t *key_size, size_t *classifier_size,
> -				 int *num_hdrs)
> +				size_t *key_size, size_t *classifier_size,
> +				int *num_hdrs)
>  {
> +	size_t size = sizeof(struct ethhdr);
> +
>  	*num_hdrs = 1;
>  	*key_size = sizeof(struct ethhdr);

So *key_size  is assigned here ...

> +
> +	if (fs->flow_type == ETHER_FLOW)
> +		goto done;
> +
> +	++(*num_hdrs);
> +	if (has_ipv4(fs->flow_type))
> +		size += sizeof(struct iphdr);
> +

... never used

> +done:
> +	*key_size = size;

and over-written here.


what is going on here, is that this is spaghetti code
misusing goto for if instructions which obscures the flow.

It should be if (fs->flow_type != ETHER_FLOW) {

	... rest of code ...
}

and then it will be clear doing *key_size = size once is enough.


>  	/*
>  	 * The classifier size is the size of the classifier header, a selector
>  	 * header for each type of header in the match criteria, and each header
> @@ -7098,8 +7164,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  }
>  
>  static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
> -				   u8 *key,
> -				   const struct ethtool_rx_flow_spec *fs)
> +				  u8 *key,
> +				  const struct ethtool_rx_flow_spec *fs,
> +				  int num_hdrs)
>  {
>  	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
>  	struct ethhdr *eth_k = (struct ethhdr *)key;
> @@ -7107,8 +7174,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>  	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
>  	selector->length = sizeof(struct ethhdr);
>  
> -	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> -	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +	if (num_hdrs > 1) {
> +		eth_m->h_proto = cpu_to_be16(0xffff);
> +		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
> +	} else {
> +		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> +		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +	}
> +}
> +
> +static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
> +			     u8 *key,
> +			     const struct ethtool_rx_flow_spec *fs)
> +{
> +	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> +	struct iphdr *v4_k = (struct iphdr *)key;
> +
> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +	selector->length = sizeof(struct iphdr);
> +
> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +	    fs->h_u.usr_ip4_spec.tos ||
> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> +		return -EOPNOTSUPP;

So include/uapi/linux/ethtool.h says:

 * struct ethtool_usrip4_spec - general flow specification for IPv4
 * @ip4src: Source host
 * @ip4dst: Destination host
 * @l4_4_bytes: First 4 bytes of transport (layer 4) header
 * @tos: Type-of-service
 * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
 * @proto: Transport protocol number; mask must be 0

I guess this ETH_RX_NFC_IP4 check validates that userspace follows this
documentation? But then shouldn't you check the mask
as well? and mask for proto?





> +
> +	parse_ip4(v4_m, v4_k, fs);
> +
> +	return 0;
>  }
>  
>  static int
> @@ -7130,6 +7222,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
>  	return 0;
>  }
>  
> +static
> +struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
> +{
> +	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
> +		sel->length;
> +}
> +
>  static int build_and_insert(struct virtnet_ff *ff,
>  			    struct virtnet_ethtool_rule *eth_rule)
>  {
> @@ -7167,8 +7266,17 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	classifier->count = num_hdrs;
>  	selector = (void *)&classifier->selectors[0];
>  
> -	setup_eth_hdr_key_mask(selector, key, fs);
> +	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
> +	if (num_hdrs == 1)
> +		goto validate;


Please stop abusing goto's for if.
this is not error handling, not breaking out of loops ...


please do not.


> +
> +	selector = next_selector(selector);
> +
> +	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
> +	if (err)
> +		goto err_classifier;
>  
> +validate:
>  	err = validate_classifier_selectors(ff, classifier, num_hdrs);
>  	if (err)
>  		goto err_key;
> -- 
> 2.50.1


