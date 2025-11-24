Return-Path: <netdev+bounces-241304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553CC8293C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6953834521E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5532F74B;
	Mon, 24 Nov 2025 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRH2cE1D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJTv0dp6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3DC32ED21
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021128; cv=none; b=f+4EajNt4md/hO4OBYhLSYbu/ON9sYQUerXvgSmz60mu9CK7rfsy1RNz/rV9HRz7RsmHx/OBBAVcXfzaOyijY2hMsV1u81vg2pELVJe590k0amm7Uho9RM76bC1dhoao5cng5CGU9XWhbBrKR1/+P5PMI9yCGLCw2Tes9Xl4HhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021128; c=relaxed/simple;
	bh=69dAMBVYbztyVdrlAwio7Tlwu8BnjSF7DoB7OI2TWQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qgl2ZsVbSlXnERN6RUOPaseKbolQr8vCqX/gq7vARC3N6Iq86fY0JYNFNmxk3xBv9cfdYf5jq3r17VzmPX06es1O0L5QQInDynhj9U6jimFKrT9YviMZDFhU5PmXAJ5sashcaNYiVqG1bOlM237pLF+lhuJDA0UNbkRh08mF0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRH2cE1D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJTv0dp6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764021125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e72N/nLYBkd3gASLyDGIbv2w/OuUmcz0uSrgBqx4nMM=;
	b=bRH2cE1DV+gnUA8y5Y8zhhn7P19RXd2PlNW0n35Ox8gxW9ypGski0oXnkMYUBmyl0KXGWG
	M64je4NQoEInQ8QRxL/uG5LTLMbLnXzs9IsqGiY/CqOARi4GN5/2nZ6QqkuX641ybeBx5W
	sy2PMFlg1SW6IDvPovqykpiyqhTXzYs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-UTvYoBRdO4e1T8YhaQesaA-1; Mon, 24 Nov 2025 16:52:04 -0500
X-MC-Unique: UTvYoBRdO4e1T8YhaQesaA-1
X-Mimecast-MFC-AGG-ID: UTvYoBRdO4e1T8YhaQesaA_1764021123
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so41534365e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764021123; x=1764625923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e72N/nLYBkd3gASLyDGIbv2w/OuUmcz0uSrgBqx4nMM=;
        b=bJTv0dp6j9sEM9na0+7F4RnhsHrpm74xFkJJWxulojd2tCv+j4M+eLwoYulpsx3WdN
         /GJ/Zw29dEJSDue2+S4FqzQct90mRDfW3Bf9QlYRmnuHCrTiKfJFnG1bBXujp0FTpjm6
         pmvzz6wy2bk90ZZqa+7oM2bFYqhUXW/UARXp3+ZZsE04oas93W5NHv0VHQ5N9R6Ur0xR
         +zJbIN0Yzl61hhv/v/tmYSLnMoXYU5gPTY6FpbC+CtE6eVCnhAPMtx6pizHdG1lv0OVK
         fGQo4QH1wzbQAL3ok9cj9KMv7XRKRXvl6dTEVAA9XgeyaXTbfa5Je03t8Buw3gvvQcQ3
         cdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764021123; x=1764625923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e72N/nLYBkd3gASLyDGIbv2w/OuUmcz0uSrgBqx4nMM=;
        b=GZNCh39d8lnIHfIfWr+Y2Xl41AIOIDfP+VribNLbMnaHpBOR0wm+Lk+v16yejQ8neP
         a3qN45TrkV2fmm0IiW2zDsnbqnhsYD0THgqChw25hBqaVDCtWASPEtjnNHMWujDDX8od
         DuvooIQ0A0/GboqWbWI8RjUjDgYGmD4csSUERKSySx6kKopJQcYAxLhP61ldSPc/12AU
         Mp8/1JcjZHvUTcj3l7IqgLVCnCiuXnOIffGKWDjnYhyX6MroQqd3KIFB4KMSmbuYQzKc
         0GODAlVQIOd7CXWh43FlDMzDjDbcaUbatZFS9JJxiV6YD/hF/oScTx88aZnfk1CC51Wh
         79Bg==
X-Gm-Message-State: AOJu0YwZ5/myCXPIzKcHsuWn8aKOmZtL8IxzLJBsUDMyU/1EoGN9uwYS
	XBhCYiNwLTvHIA5Ke/f7YU+twxLC6yDXk3pZyf0rtvTEX0h4blmD6x89njYC06gS61SjVhG7FoS
	wsk5JTAW/raK/1N0F3Fc8vN7uPmdt9KsFjeppn5mAYmRfoo4uPEncCarXgA==
X-Gm-Gg: ASbGncv+X/zShsiB8995M8Nt8INre5rbxK5ZpJs13h6eJXRtL1Y0IbeXqWDysH9XUeI
	lIuTd0VBQ6w1LVNrnBiuS8j+zWud40/PzBdF6j4OWr9fYP6GTzDb5mQHLOdSriUnRCkFcI2DA3G
	WL+hSlz0gJiHusarDWj7BjnyboI/5FlDOvERL4eHZjDQGImRg1M+ByFFF3S2ny8lnOCeoRtWnst
	Zl02KYcNQNG4bH4ArAUL2dSO/tuwwJkYZUTsNwico7LTlrctahxa4b+h9fHjCguwLGNAWdZIF8P
	0oz3e8wcHqYsV+KX9mSMsvD4vY+dOuApbfRZzFfbsQ3lMqB2xlX9P792ZbKXX7C64GFLmbOP+h8
	pA5hq1StJudXSvkt8lSn7JkImfnqkUw==
X-Received: by 2002:a05:600c:3b05:b0:477:9a28:b09a with SMTP id 5b1f17b1804b1-477c00e7900mr151196295e9.0.1764021123261;
        Mon, 24 Nov 2025 13:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6hVPBmzcjYWA4CqHGLf4Muh92XaXgWBSJ5z9lrobTdgS5JPAenWyhhlTP0Vz5JFQJrG2rwg==
X-Received: by 2002:a05:600c:3b05:b0:477:9a28:b09a with SMTP id 5b1f17b1804b1-477c00e7900mr151196065e9.0.1764021122799;
        Mon, 24 Nov 2025 13:52:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790552c39dsm89035e9.1.2025.11.24.13.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:52:02 -0800 (PST)
Date: Mon, 24 Nov 2025 16:51:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251124164600-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-10-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119191524.4572-10-danielj@nvidia.com>

On Wed, Nov 19, 2025 at 01:15:20PM -0600, Daniel Jurgens wrote:
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

So if user attempts to set a filter by tos now, what blocks it?
because parse_ip4 seems to ignore it ...

>     - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
>     - changed return of setup_ip_key_mask to -EINVAL.
>     - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST
> ---
> ---
>  drivers/net/virtio_net.c | 119 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5e49cd78904f..b0b9972fe624 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5894,6 +5894,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
> @@ -5905,11 +5933,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
> +	if (mask->saddr) {
> +		mask->saddr = l3_mask->ip4src;
> +		key->saddr = l3_val->ip4src;
> +	}

So if mast->saddr is already set you over-write it?

But what sets it? Don't you really mean l3_mask->ip4src maybe?



> +
> +	if (mask->daddr) {
> +		mask->daddr = l3_mask->ip4dst;
> +		key->daddr = l3_val->ip4dst;
> +	}
> +}


Same question.




