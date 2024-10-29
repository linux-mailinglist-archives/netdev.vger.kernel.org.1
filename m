Return-Path: <netdev+bounces-139872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8C9B478F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A4AB23891
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FC4205ADB;
	Tue, 29 Oct 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIPVaf2x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2F1205AD7;
	Tue, 29 Oct 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198993; cv=none; b=qzAU8ngHFuwIuXlLtggdG8yeXgoMhQE3HXbvoe1Mx9WGhTPx9ZZCE9tafhSRlNvP4he3omxVUwcnJd+LHW91dLy5yf8JltnCBYSHvvXi0YpRdx59/OO4/YyCocBuq7/PlYI63L779/J5cbh2F4cbUjLVsZJ/vto6fSkWogdolEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198993; c=relaxed/simple;
	bh=9VKFZMUstwMaH/9t+HXD0FIBj7ZYrsQtl8nWIdYn38s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6FWwv/+w8Z+6e86VpnSWM+SXbUDY609cjoqPLDeAExWRSKXqXIHYeMF158SvBH06jqAeu9IjuJwBfdw+OXzAZ5yOqz2w7nWT25LPWgAd7JEnZItvASIHHg4AdXYWlkQlWV6KmR2y4CwBynrYNwD8HGTjPztPCOInlDcP6l58CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIPVaf2x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso6549325e9.0;
        Tue, 29 Oct 2024 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730198990; x=1730803790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjJPVC3mKCXT7L43M53qjMnk52v0YKTGfpZRaqikLUk=;
        b=XIPVaf2xZqlSVzO9wPamXh7kw9tYgeP95ehatu9cnWd0RdSEA6SYmjkLoizzI5rvwS
         f54VpvZDx0rBVy+dnP2CwqyW9WZXwFCNbcZSdBr2Hx/WlGxM3tylNgm2365LcaDxF/RE
         Or5ogvAAz6EdOEG7PBUFv41JBvsH7/Ctge3GEbaKRP6Qsu/0Gctc3tipMWkGAetkciUt
         TCspRDoR34OWQxRT282MhvZDvyLD9JyVo2S06sitNVg72ttpUtl4SKtwKyVjPeuIxyAA
         Mz00pGmPy2HSB8kjfrY8xA2A46H+lHlb0MMB/dnq4fnOxhp/DYUBuu3hNESNtq87IU8T
         Q2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198990; x=1730803790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjJPVC3mKCXT7L43M53qjMnk52v0YKTGfpZRaqikLUk=;
        b=omlHQ2ebZibzzBG1g9HAw+Z/CDPO3AGcWc8K6SYAx69PVPz/CHP6f0DLpKzOUsGv2J
         AyUXIFSvpcbelap9VxQ/CgXO0OhKnq9kF+vIbV/HO1Ic2JfC3tyHKRYmQb5SBjVFyHTx
         MFc1jJls1w7nj6kltG5W4DTtn1UHX9cUQqmUl90maizoypGT1zSu2nzd+8921MzaKA7f
         vbFP58vFGf0Qj7YdohUYbLmAZPTM4/nC2024DD6W0Dv7dqHGVFC3DRSYCSuCFo81fVt+
         TMBv9jm0Y3Rw0aBTx5KP+ssw4+TUXK6z+VkilIewxKrIR3NFDA65bYJCLTXjNvKxWjRN
         p9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUMmzbBU8LRQZd5eVD5ZniQ5VfAX+hSi2WSoHjd+0W/vzc7Pqh+nRBZiN4fJBhTaLE9cqb5Y5AVL0//x5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb18GbJ9fTX3PvRKODf/Auz8n9ZxSU7l/xx2D/uXz4eReccd36
	jRuIKtAPu3s+tW2wYtl06FfZf4haNed6yc7eCHOIUq7MD1fL40gf
X-Google-Smtp-Source: AGHT+IG4vqwkhe98DdxXKJqj48XgMx30nS0o7sfGHbWh/5q2io876Uq9Mws/CoWLdnC7Hih2nVUEzA==
X-Received: by 2002:a05:600c:3b0a:b0:431:5316:6752 with SMTP id 5b1f17b1804b1-4319ac6fb40mr40118775e9.2.1730198989539;
        Tue, 29 Oct 2024 03:49:49 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55df56sm169342695e9.10.2024.10.29.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:49:48 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:49:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: Remove self from DSA entry
Message-ID: <20241029104946.epsq2sw54ahkvv26@skbuf>
References: <20241029003659.3853796-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029003659.3853796-1-f.fainelli@gmail.com>

On Mon, Oct 28, 2024 at 05:36:58PM -0700, Florian Fainelli wrote:
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f39ab140710f..cde4a51fd3a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16031,7 +16031,6 @@ F:	drivers/net/wireless/
>  
>  NETWORKING [DSA]
>  M:	Andrew Lunn <andrew@lunn.ch>
> -M:	Florian Fainelli <f.fainelli@gmail.com>
>  M:	Vladimir Oltean <olteanv@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/dsa/
> -- 
> 2.43.0
> 

This is unexpected. What has happened?

