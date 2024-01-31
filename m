Return-Path: <netdev+bounces-67456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB08843913
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9961F21364
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD5458137;
	Wed, 31 Jan 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOEqZ+SQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A55DF0F
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689767; cv=none; b=N/rHs9uD8p5vIaNgkoiiFkBeCrZBlcDjjtgltcrHbwMTU67VYW2sZ4LkgiZFrUBTuPAstEs4Du1EC2egwsr1wA6KmCznG0mIG+iPyvUtqjBwck+H1xcHlCTpmUS5Ugv24MkHJNhKOBl5ZY5K4Fj8J641UerQ34fs8VlkyivRiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689767; c=relaxed/simple;
	bh=qHqlMlQnXte+AmjyNaYMnTz7hhx+M+0ybBYhztyMIBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnS0xejMnOtJDZfWqzPxG9NxYTQgcnNrTEOcnqJZx+jl0UqKpcS1eOj8NMlkSM4Z/AULyRFM1ZOpLBy2LZmlXxUvTY3YuC8cGZ9Gs8q+4xAegds2nuvKWvqzFzug2HNzcKRVXBEx5RksVYISYegdUpuqWmG9c1cK9zm0b1aVDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOEqZ+SQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso3010196a12.3
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 00:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706689766; x=1707294566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hee4KxOESGcnFuVhzIUlvEi1hJhpnBFPuBPZHUpVrHI=;
        b=VOEqZ+SQH+9vVMKvPiNz7O9K7AHWF8cDb3AueghofpPmnp314BmvxOeViBNbAk/j0w
         kD7Ft6iAMFc+LzXaWSMq0GB535brwkDGHctwsAD8nz29kHFy6jWAMZPgymgEfC4xaXuF
         7uPVtgxF8UlmDlFa9c89XGGSi+3Z6/sfqRLv5H+4tpf53QAQ8w2nRJOZd0Vy8RXqrUU6
         9FSX1UazLN36XquCJXn3S3HVdVI+T34GehTBf12lQ+fe1WZiYfEl0kZOW2O+GojQr1FQ
         GCjzeISLAv2vYmuRd4W5HPSyqmlxpDOWg2v2By1Sn6QCP3Zl/34WLEsLob/xF3VWoWaZ
         jSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689766; x=1707294566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hee4KxOESGcnFuVhzIUlvEi1hJhpnBFPuBPZHUpVrHI=;
        b=YyVw40kfDKoHa6ktAWUNI89siG1/sWjmZMlkhUE1ZO+QUlLZbhvh8HEIQ393CBZKHS
         Iq9S1oXt75/S3GfxLzrktUyIcHwPFq34WfYyAholvT4sjNPfEnV0vZbtgRCKT2h3thiS
         y8KX50wLAe/ml22yprGCisKwaZhY0Q+obfXSNVJu5LFwX4H6f6EqHdG0yAsNhzVTwKhm
         IEYegykDINjfi/dEq0vNzBuxXeEmHpeAIlM/aa2jSxlEwRVIAqufYhe6ZvUBTtVd41Ls
         fA+50V2C2w96M6gXByzMM/yOy0d7MDm2ijAEQX/zjUPoDSGO9NZSNbbCEQxU/HFGrx0b
         nJHQ==
X-Gm-Message-State: AOJu0Yxlx1C5FaXZKCdKgz+8GR5qkEegV2NNNyNo55WCvxzpj7qPUtYm
	FGQ0YD0MdBPjkdowLU8w1aSXIu1blxpbYnqScgBz7KG0wWxXSz/X
X-Google-Smtp-Source: AGHT+IFVHs4uJbqV2iXd1k1rbwUNPHrGUotgbuSMVwg8MrQU4IHzHIXEy8yG/U/vV0m4Uu3QK85Hbg==
X-Received: by 2002:a17:90a:1289:b0:28e:82c0:db91 with SMTP id g9-20020a17090a128900b0028e82c0db91mr787971pja.43.1706689765608;
        Wed, 31 Jan 2024 00:29:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW6A1oDChLZ8ph/IRgSFthOsjgJIEcuZne5/kKVN3l5fICKnRR0OVJo7sBPvzdnpjRZypCRN6k/CujAspC7ykc5LNgWM2JbOPeuOXYKjct3qgCYne4Dp2lw3gMbIVFFIFn311uYnRXh8CflN6V+kwla3qIPVknQ8KbrMLQTQAFDLu4SPIGNYu/tcqaMuOPG6RyTNVCGaqr/X4Sa561vKU3o0YvmRj+cuTxpvoYU2a7BvD0ZQtI8EbTxlk2jE6YcPa9OyJ8oVZZNJEluZVAXdVXqzSc1Z+7KA3VTNTaWYYopI+GGTTJIEbmvVzkWRyao2JL37Nc=
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id iq24-20020a17090afb5800b002906e09e1d1sm843605pjb.18.2024.01.31.00.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:29:24 -0800 (PST)
Date: Wed, 31 Jan 2024 16:29:19 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH net-next 2/5] net/ipv6: Remove unnecessary clean.
Message-ID: <ZboE35ahg7t-YSMC@Laptop-X1>
References: <20240131064041.3445212-1-thinker.li@gmail.com>
 <20240131064041.3445212-3-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131064041.3445212-3-thinker.li@gmail.com>

On Tue, Jan 30, 2024 at 10:40:38PM -0800, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The route here is newly created. It is unnecessary to call
> fib6_clean_expires() on it.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  net/ipv6/route.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 98abba8f15cd..dd6ff5b20918 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3765,8 +3765,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
>  	if (cfg->fc_flags & RTF_EXPIRES)
>  		fib6_set_expires(rt, jiffies +
>  				clock_t_to_jiffies(cfg->fc_expires));
> -	else
> -		fib6_clean_expires(rt);
>  
>  	if (cfg->fc_protocol == RTPROT_UNSPEC)
>  		cfg->fc_protocol = RTPROT_BOOT;
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

