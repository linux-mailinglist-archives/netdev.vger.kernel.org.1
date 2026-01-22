Return-Path: <netdev+bounces-252469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEQjJHFlcmmrjwAAu9opvQ
	(envelope-from <netdev+bounces-252469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:59:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 287096BD52
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4E1E30D952F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A42638FF0A;
	Thu, 22 Jan 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRFalYIU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rWdvoH1v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6B331CA4A
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102498; cv=none; b=HrC6/bG5cW6ICQso3xXMvHZ5w3a6ZCarS+mH2fSF3tFh2Ma/oIpkYRO4x9VqUHeMtiLMDNNk9AghoJqlVtk9ZbBoadr/0i5TnB92Myea8NAWRZSZah3VuDJdFIz/pcn4dE/6ZdEaS+W5yXbNmb+U2vw5/IlXDy7CO0b9GoTpf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102498; c=relaxed/simple;
	bh=YKqy4dOSjpxRjuWOZfiiaS8IFhLQkNGhBeaum7DfH9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3QkP7zf7vN0qE5/2oMmYcLF0Z4JStFShFo7nXRU/R0tIQJ2PncFHX0ANRUJSQ2ZPuU7ReUY25bXcD7sdXyGZzapguRcSvBtzV7eJ9Q3z51lgF27dR9wr4Rf5MCugFmzPk1roVPAdIxxe6WfyQd0APiBdesSuPOFIJX0oPopSME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRFalYIU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rWdvoH1v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769102488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LW3W2gA/isNxioIH5fWqQEKCicVcLJNySRCeMcQHGvQ=;
	b=DRFalYIUo/HUgxn9VDaT0eIiCjCOCUsIYAO5y4VzLhL1Q3/KcONESp4zj3tRXX5BAKMOU2
	LC2lt1u2zOh1ALJ/gvVGejRCm7pAp5MGtAtykTYc0nDM+alJ3BlzkXAjrt0IR7Z3xxtA9Z
	XVyX8SytGC2gOqgeFfnmNSnparaeXiQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-XVwN5UtUNf-liuP_L3xJ7g-1; Thu, 22 Jan 2026 12:21:26 -0500
X-MC-Unique: XVwN5UtUNf-liuP_L3xJ7g-1
X-Mimecast-MFC-AGG-ID: XVwN5UtUNf-liuP_L3xJ7g_1769102485
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47fff4fd76dso10084785e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769102485; x=1769707285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LW3W2gA/isNxioIH5fWqQEKCicVcLJNySRCeMcQHGvQ=;
        b=rWdvoH1vGdJYEjWmLF6fmJUAdhz7x+uKNrKTomR7npbsrq5D48ctCUhgC66uuWgYv9
         NzodvpKX7E+YmjJD0uwnEP8irwo55VLhLxCif54dA3hi3zuFfyxnMa4d/XMcrOvRrUM2
         cTzDy44D3iu1TyG8EFJL9ID/9/Py9S9mzpHPS14M7SCS71N+fxbckOs+4bD0YhS3RU0m
         a+AuFC1fyRGVLyi7MFNUjROfxZB22LYAaMEippe6KKZi20s3ItLYx11/9GIxFLw1j9Xh
         ND6577OGcsewDXXuqln9qn+tlhRi0pcd5dbJBwtj0YOuFdtLfgDtkDrFsAo0GZaYVL8M
         7kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102485; x=1769707285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW3W2gA/isNxioIH5fWqQEKCicVcLJNySRCeMcQHGvQ=;
        b=saqcNs37mU6e3B5xgST/JbfRWqgvfdatl1CASy1qw5XNwUKdFeHC5lLbgzQ3fZVPgk
         B6GNQQQMgUkJVqomv838n9Z08m2WZs3T72nuxsu/Wte87FAF2urtFYShf5zGUK/SD+76
         8J/Df98Uaqsw8gAv0moPb6R6wzDnGdotdarbrz+xizdYKqeLc5p6auYUenmWiHZJ4RVM
         A8DCLN7y39AsZeash+sLE1fvL/kF1oUh16L+f2j1CeAqMLCWLa1GJ3Ycgu6LiGzv3in0
         7w8ABY+TusXi0nNsKZj2Wy0zbX1n/IiEoyzgKRkytigJdaFlIzju0EnHUv/nsNJlepsX
         7Kcg==
X-Gm-Message-State: AOJu0Yy62X5KfVnLh2J/hgsHOEwHyCwpXRS5UedGoWG+8A3CxOF51YWa
	Ctb0bbkAmBESYslM8Gj3lE/THXuc9BJ9MUh25JrohXPWk9Gwk3NzESwe91ydCp+F4WzAM/695/f
	XwnJ1bi4zNcZvaK9RQWX27BxAv84yP2A0NgnBJzKk5VQRvsRakORJTByggg==
X-Gm-Gg: AZuq6aJ9DwjtcPM9DGv6s/vX0jJR/4SGWT8Ly3GO/dSgv/x6CmbZhFS7MP13v4S6NcI
	/lrvZhW/SO4HQjCsbCiK3ilcAMuNzoQPpjrlJGaR6S3T5szkBb10gYttZrAEA+x4F8SqqCSTnF4
	7t/pNFLVjYxERqPLZVXmqK6FGc1uNuJbwVo1kPpC3z9DTTf2W7HijcVG+NTijogXbFnFOLLiMXM
	RoLEOUT1+nErwgvndQCln88O9PAir/Sjt7iOUBswODy0JwA8Xup45msSBHZ/yNXVLbL5XECmyvF
	HeL1+/uQQJckxM6CZxCRSKE6N26X+Z1dfyowYY/O9Mg2kUk34/z6kt74ZIl+PvFbGRIXRxtXrVr
	8L3yUGtw43Uo7CJOt13Vma3yp9gn0ZaeWhA==
X-Received: by 2002:a05:600c:3b24:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-4804c94f82amr5685095e9.7.1769102484604;
        Thu, 22 Jan 2026 09:21:24 -0800 (PST)
X-Received: by 2002:a05:600c:3b24:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-4804c94f82amr5684275e9.7.1769102483618;
        Thu, 22 Jan 2026 09:21:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470cf1acsm81696635e9.14.2026.01.22.09.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:21:22 -0800 (PST)
Date: Thu, 22 Jan 2026 12:21:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v16 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20260122115857-mutt-send-email-mst@kernel.org>
References: <20260121220652.894364-1-danielj@nvidia.com>
 <20260121220652.894364-10-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121220652.894364-10-danielj@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252469-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 287096BD52
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 04:06:49PM -0600, Daniel Jurgens wrote:
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
> 
> v12
>     - refactor calculate_flow_sizes to remove goto. MST
>     - refactor build_and_insert to remove goto validate. MST
>     - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
>     - Check saddr/daddr mask before copying in parse_ip4. MST
>     - Remove tos check in setup_ip_key_mask.
>     - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
>     - changed return of setup_ip_key_mask to -EINVAL.
>     - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST
> 
> v13:
>     - Set tos field if applicable in parse_ip4. MST
>     - Check tos in validate_ip4_mask. MST
>     - check l3_mask before setting addr and mask in parse_ip4. MST
>     - use has_ipv4 vs numhdrs for branching in build_and_insert. MST
> ---
> ---
>  drivers/net/virtio_net.c | 129 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 123 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ba231f10b803..7ce120baeb41 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5818,6 +5818,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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


this cast is only portable if sel and sel_cap are properly aligned.



Because if not then at least saddr/daddr accesses below are
not portable and need
Documentation/core-api/unaligned-memory-access.rst

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
> +	if (mask->tos &&
> +	    !check_mask_vs_cap(&mask->tos, &cap->tos,
> +			       sizeof(u8), partial_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>  			  const struct virtio_net_ff_selector *sel)
>  {
> @@ -5829,11 +5862,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
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

this cast is only portable if sel and sel_cap are properly aligned.



Because if not then at least saddr/daddr accesses below are
not portable and need
Documentation/core-api/unaligned-memory-access.rst

> +
> +	if (l3_mask->ip4src) {
> +		mask->saddr = l3_mask->ip4src;
> +		key->saddr = l3_val->ip4src;
> +	}
> +
> +	if (l3_mask->ip4dst) {
> +		mask->daddr = l3_mask->ip4dst;
> +		key->daddr = l3_val->ip4dst;
> +	}
> +
> +	if (l3_mask->tos) {
> +		mask->tos = l3_mask->tos;
> +		key->tos = l3_val->tos;
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
> @@ -5969,6 +6032,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  {
>  	switch (fs->flow_type) {
>  	case ETHER_FLOW:
> +	case IP_USER_FLOW:
>  		return true;
>  	}
>  
> @@ -6000,8 +6064,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>  				 u8 *key_size, size_t *classifier_size,
>  				 int *num_hdrs)
>  {
> +	size_t size = sizeof(struct ethhdr);
> +
>  	*num_hdrs = 1;
> -	*key_size = sizeof(struct ethhdr);
> +
> +	if (fs->flow_type != ETHER_FLOW) {
> +		++(*num_hdrs);
> +		if (has_ipv4(fs->flow_type))
> +			size += sizeof(struct iphdr);
> +	}
> +
> +	BUG_ON(size > 0xff);
> +	*key_size = size;
>  	/*
>  	 * The classifier size is the size of the classifier header, a selector
>  	 * header for each type of header in the match criteria, and each header
> @@ -6013,8 +6087,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
> @@ -6022,8 +6097,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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

Are mask and key guaranteed to be aligned here?


Because if not then at least saddr/daddr accesses in parse_ip4
call below are not portable and need
Documentation/core-api/unaligned-memory-access.rst




> +
> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +	selector->length = sizeof(struct iphdr);
> +
> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> +	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> +	    fs->m_u.usr_ip4_spec.ip_ver ||
> +	    fs->m_u.usr_ip4_spec.proto)
> +		return -EINVAL;
> +
> +	parse_ip4(v4_m, v4_k, fs);
> +
> +	return 0;
>  }
>  
>  static int
> @@ -6045,6 +6147,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
> @@ -6082,7 +6191,15 @@ static int build_and_insert(struct virtnet_ff *ff,
>  	classifier->count = num_hdrs;
>  	selector = (void *)&classifier->selectors[0];
>  
> -	setup_eth_hdr_key_mask(selector, key, fs);
> +	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);

So this will set sel->length to 14.


> +
> +	if (has_ipv4(fs->flow_type)) {
> +		selector = next_selector(selector);


And this will point next one at an offset 8 + 14 then?

> +
> +		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);


and this will pass unaligned mask and key?

> +		if (err)
> +			goto err_classifier;
> +	}
>  
>  	err = validate_classifier_selectors(ff, classifier, num_hdrs);
>  	if (err)
> -- 
> 2.50.1


