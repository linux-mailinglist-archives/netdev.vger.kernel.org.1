Return-Path: <netdev+bounces-254575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Di6CIfwemkiAAIAu9opvQ
	(envelope-from <netdev+bounces-254575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:30:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B2ABEE1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0B98301570E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279232DD608;
	Thu, 29 Jan 2026 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqla/a0S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427A2D7394
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664636; cv=none; b=CiwYw0WAbvoDspz0fFdwg7y8u50G8DhVLZtfoE7jJOiYQfj2Hbo+H/j2ME9icMQ6jacLxKVbHCdWTy1Pba59wZTnpc2Hy8XGhXEAFwm0kd8DIPUollBfPJ0sWYHwHu4uXWt6Qrib2zC8356eWm1vg7Ks9laiP7KFgP2BUn5g+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664636; c=relaxed/simple;
	bh=1O7cwy6hZjXpVnnCgMRUy7d2ofsehUXxO6O0OI8b05E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Gd7l5ORBXfYgLQc4djeZhfmYC6G8IA7EZ8Ak4EM0+12ye94Q1fcXRlXCdV1h5SfTkn2hTBxDXzkXOLfiwYQzudpmyxHlsNJEMpuPxlJGut3neTMi/RutMMtjqg+LyjBJEXAAA7LXUJ/uBAVEcIt7h3rK1rHrOUrNE8/XY6Uq0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zqla/a0S; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-649488dc7bdso506736d50.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769664633; x=1770269433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGKXRwN8IRAA/CVNT/tNROOm2kXqNhpzXybBMt82hSM=;
        b=Zqla/a0SVlHokWH5mybO3JbfqyIsn6kR2wKMiOmo2CTJkzLHZyMkolkk8+me9bkiW7
         FX13lARa6xXYJgqSm++zsCxGXUDgar3sAlYw68a9OLAKMRAVvncK8bl66Imlvz1QiZHC
         WhyYpOCsEwP0Py6EPOmT41j5xYDpjqnXz+vIGCGRx9YgcU1UZuHefj/0oj7XZMUSIhDM
         WzP/aRY8cVILZ+Acxag7Ri765NA9MQD8ekKwfOoUmyFlO0qe/DHMzNi18UIN0DtfHVoM
         Cu4Q8OUzIgWdnVhi8l/wlD6ImV5b+h6+Qo09LxLSxLvNrTTacNBO3PqS2zOxzxRj8ahF
         nzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769664633; x=1770269433;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGKXRwN8IRAA/CVNT/tNROOm2kXqNhpzXybBMt82hSM=;
        b=WtOPJBPOBSCncjwq3+CIqlE+KmibkzjH2UVtJTr4thnIlSyLW6mJ2LAAp5l1ZD2htq
         vJvrOd2fw+MjrcwntGvCLoL2BZuQ5leqPqXbP2YtwkoKgn7jHTfh+o+DbWkBfJEDQlFY
         uKGfmoMGEQ8Ml0qQHBxSwPnrZIWirhjVba9hsRgrZHqojH0gSbcE5PMqftnfN5D/u86s
         VYs0gtIXF9vGygzEd5/uzBVYp8PDGvyj9mj/Ga1NwisQyn4X9eYH8jyr3I152GPnfUr7
         //dh23ZIAXYGU+udlIXdUhY1WKpCZ+3dF1IIvCirugf7TBrpId4D4hVhKgrZj9abeFCT
         J/vg==
X-Forwarded-Encrypted: i=1; AJvYcCVyQYml6IpDvlt9qkTLtAZzonBSaVH9Kaof8+u/wWZ+CknZXICmUGisLBRaPlLrSogAVRcT5II=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLN8V9hCTG4v6K7SceO0R9rl+GArWbvwKgufc/YwW2sFv/8Kf
	RviEHW0RyQDfpD2gpI0ZD52EheP5muC4lApqLluxsszYh4/0vupeD9Xa
X-Gm-Gg: AZuq6aLB2tbKBq2bkJGYoK4YO6Homir/7anIh/ELes1h9nmGkDTE/471LKJ3c/aQiCU
	eU6d+SBZYtzmv1/xotXpqQTrNYg4Ky8kAthfAyCywUPSgkILEwvqx8g7mjfSqeTTkR/hLzFJzQD
	ZfBMUXqPKQucCPap+acOtXZI+smsA7Wh0pN7DhI65sblLNQ+Lw1Mpgm7KVYUrVfwNbZLMkEWZ8K
	0Ldk/ZRuwiiv9xPb4JkyUD7pJwMcjuZ2pXDZIm1pXSeOKg+JEQJGzYL5krLOy7nkaaa5sAltN2C
	VJe3PbJYmil2DdWrBYYYyt1N4I7exf7ll3qVl7k3wYpdt4TTgFwVCOl5LNpMwdPl59FV+jZmnJo
	cD2Chkt/0dWP3BsVrTEHAdIEEaedKZfyBNUbqPVUSUxrVeVEefKOkpFjI4o41B84OnEBVFvq9k9
	WNb7cQ8i4JTKOyhO8ASC8A2RyfPCXR2Rwj07R1JKWi6xmnScQQ82Xytof9MS0=
X-Received: by 2002:a53:d016:0:b0:644:4eec:222 with SMTP id 956f58d0204a3-6498fc61cd1mr5170715d50.85.1769664633538;
        Wed, 28 Jan 2026 21:30:33 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64996077bfdsm1872842d50.7.2026.01.28.21.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:30:33 -0800 (PST)
Date: Thu, 29 Jan 2026 00:30:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 netdev@vger.kernel.org, 
 justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <willemdebruijn.kernel.235a1f46c52f8@gmail.com>
In-Reply-To: <20260126194826.236075-3-tom@herbertland.com>
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-3-tom@herbertland.com>
Subject: Re: [PATCH net-next v5 2/7] ipv6: Cleanup IPv6 TLV definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254575-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,herbertland.com:email]
X-Rspamd-Queue-Id: B46B2ABEE1
X-Rspamd-Action: no action

Tom Herbert wrote:
> Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
> of the TLV definitions. Label each of the TLV definitions as to whether
> they are a Hop-by-Hop option, Destination option, or both.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  include/uapi/linux/in6.h        | 21 ++++++++++++++-------
>  include/uapi/linux/ip6_tunnel.h |  1 -
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
> index 5a47339ef7d7..438283dc5fde 100644
> --- a/include/uapi/linux/in6.h
> +++ b/include/uapi/linux/in6.h
> @@ -140,14 +140,21 @@ struct in6_flowlabel_req {
>  
>  /*
>   *	IPv6 TLV options.
> + *
> + *	Hop-by-Hop and Destination options share the same number space.
> + *	For each option below whether it is a Hop-by-Hop option or
> + *	a Destination option is indicated by HBH or DestOpt.
>   */
> -#define IPV6_TLV_PAD1		0
> -#define IPV6_TLV_PADN		1
> -#define IPV6_TLV_ROUTERALERT	5
> -#define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
> -#define IPV6_TLV_IOAM		49	/* RFC 9486 */
> -#define IPV6_TLV_JUMBO		194
> -#define IPV6_TLV_HAO		201	/* home address option */
> +#define IPV6_TLV_PAD1		0	/* HBH or DestOpt */
> +#define IPV6_TLV_PADN		1	/* HBH or DestOpt */
> +#define IPV6_TLV_TNL_ENCAP_LIMIT 4	/* RFC 2473, DestOpt */
> +#define IPV6_TLV_ROUTERALERT	5	/* HBH */
> +#define IPV6_TLV_CALIPSO	7	/* RFC 5570, HBH */
> +#define IPV6_TLV_IOAM		49	/* RFC 9486, HBH or Destopt
> +					 * IOAM sent and rcvd as HBH

Explicit labeling with HBH or Destopt is quite informative.

Does this mean that IPV6_TLV_IOAM should also be accepted in ip6_parse_tlv
in the Destopt branch? RFC 9486 indeed did reserve a number.

> +					 */
> +#define IPV6_TLV_JUMBO		194	/* HBH */
> +#define IPV6_TLV_HAO		201	/* home address option, DestOpt */
>  
>  /*
>   *	IPV6 socket options
> diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip6_tunnel.h
> index 85182a839d42..35af4d9c35fb 100644
> --- a/include/uapi/linux/ip6_tunnel.h
> +++ b/include/uapi/linux/ip6_tunnel.h
> @@ -6,7 +6,6 @@
>  #include <linux/if.h>		/* For IFNAMSIZ. */
>  #include <linux/in6.h>		/* For struct in6_addr. */
>  
> -#define IPV6_TLV_TNL_ENCAP_LIMIT 4
>  #define IPV6_DEFAULT_TNL_ENCAP_LIMIT 4
>  
>  /* don't add encapsulation limit if one isn't present in inner packet */
> -- 
> 2.43.0
> 



