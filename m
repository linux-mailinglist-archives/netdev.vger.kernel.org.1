Return-Path: <netdev+bounces-73832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CA385EBDA
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C11C2129E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0671F3A1BC;
	Wed, 21 Feb 2024 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7eWPbii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5017553
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554724; cv=none; b=eb4E0gx1nR+911A2eOG6WBLV7Awti3ATtYPylD/cVXdrDrQkq+wIkI1fOYZiRacGUSb9j0xZeezbgRMpRjD6Kk5xYKFPMcAiCVva1OjNHDn1PJm3Ngl8h5gs/P5TA+04sj9lc5EngGJvfOZpKLCDOnB/rDpn579eAmbC3QyLX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554724; c=relaxed/simple;
	bh=e8beQZH/8dTcH2SlskyquNhTiyiTGjmTdYwL9ADmD5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgYTFUbdFSekEGFlj08wPB/pskhWYQeipp0tjUKsA/YyDHJzcOGI+FWh3DLI5LHjgpN4XmSydiLkbdf/ysKejGj+FU4nNbQQ65uEx2/Mp63riUvc9FL+Z8XnT25eyXY+BCzpw9cGueBDjFNGxRUKw+nU2YF9U2DFZIKje+kvaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y7eWPbii; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso4988050a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708554722; x=1709159522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwSF+RHtQzi0FDht5gRWAtF1IQMU5qPXVryp4kceArc=;
        b=Y7eWPbii295F/mG+P8YTasvWDx2FuBmKjgvv4552ytiXXUXVORhKS/HJkSxxi/3qqu
         4dCCMxpp1Ibf6zPJpTyv+scpQKyxFfG06yNYDAu2wZVebptFyRRq7GwMdm0S4Hobuyb5
         jesQQRuah3lszyM1Qh7eOjxHiZTr5IqvKmI6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708554722; x=1709159522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwSF+RHtQzi0FDht5gRWAtF1IQMU5qPXVryp4kceArc=;
        b=nJaBTW/rk+J0yTyfYVQu/UeUxgoIVEsP5MDSnuaMmSlD5bajaoR8DRFLFQZnVvGX4d
         i/kfW/+R5BfIpOKg3UfBys/QBEANw6cW4rR9lZAxaQiF/n6TKOLF3cXCjcJr/RFVd+E5
         tchSIWE6js4LNuoBdNTSpXtDywxDtk9ziAqDHoo9JZMvCXhjhgC+I8OAxVfSCAQdroLs
         gECdBhap464d+jaQryNpHhI+C6sXvOda4r5tqVn/ojZTrST2nTZapNXtr9b3Ejx7ML2y
         ViGHnrzGTJHsl55v1dvzDVqmKRAlWN2dssL1z38M6ExDFxVoZq/A6zMtdBpIzq5UOCAP
         pZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIWEeDiBv1CIluGdHYF51rHb8jPJF0AnsZZB99XRoM8ly7dS9pI5n3XjtTnF4fKPyU1C9TvEhpphfNW7hg/1k9sR0QkiAM
X-Gm-Message-State: AOJu0YyVCmqo1CW+XyQbGmO64y3ll6h/SIZBKu895h6DKhQ51KfsYmIE
	JOkvgJIb3rKZHAzC8pSEmKX78z+l0l2JigpaSLF1vFshwjzCnyQMHi1n5UYOCQ==
X-Google-Smtp-Source: AGHT+IHRmg+Wo0dAlYaTnjM+LFEy1m1wh/Bq5UQjRL3JwQIIceR9LfrEx3PAPsdmBFeTyj7ADIPXVA==
X-Received: by 2002:a05:6a21:1394:b0:1a0:aa34:8733 with SMTP id oa20-20020a056a21139400b001a0aa348733mr8310173pzb.17.1708554722256;
        Wed, 21 Feb 2024 14:32:02 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q69-20020a17090a17cb00b0029954a48c38sm10780321pja.38.2024.02.21.14.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:32:01 -0800 (PST)
Date: Wed, 21 Feb 2024 14:32:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, morbo@google.com, justinstitt@google.com,
	netdev@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net] xfrm: Avoid clang fortify warning in
 copy_to_user_tmpl()
Message-ID: <202402211431.ECE9690@keescook>
References: <20240221-xfrm-avoid-clang-fortify-warning-copy_to_user_tmpl-v1-1-254a788ab8ba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-xfrm-avoid-clang-fortify-warning-copy_to_user_tmpl-v1-1-254a788ab8ba@kernel.org>

On Wed, Feb 21, 2024 at 02:46:21PM -0700, Nathan Chancellor wrote:
> After a couple recent changes in LLVM, there is a warning (or error with
> CONFIG_WERROR=y or W=e) from the compile time fortify source routines,
> specifically the memset() in copy_to_user_tmpl().
> 
>   In file included from net/xfrm/xfrm_user.c:14:
>   ...
>   include/linux/fortify-string.h:438:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>     438 |                         __write_overflow_field(p_size_field, size);
>         |                         ^
>   1 error generated.
> 
> While ->xfrm_nr has been validated against XFRM_MAX_DEPTH when its value
> is first assigned in copy_templates() by calling validate_tmpl() first
> (so there should not be any issue in practice), LLVM/clang cannot really
> deduce that across the boundaries of these functions. Without that
> knowledge, it cannot assume that the loop stops before i is greater than
> XFRM_MAX_DEPTH, which would indeed result a stack buffer overflow in the
> memset().
> 
> To make the bounds of ->xfrm_nr clear to the compiler and add additional
> defense in case copy_to_user_tmpl() is ever used in a path where
> ->xfrm_nr has not been properly validated against XFRM_MAX_DEPTH first,
> add an explicit bound check and early return, which clears up the
> warning.
> 
> Cc: stable@vger.kernel.org
> Link: https://github.com/ClangBuiltLinux/linux/issues/1985
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

This seems reasonable to me. Thanks for chasing all this down!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  net/xfrm/xfrm_user.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index f037be190bae..912c1189ba41 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -2017,6 +2017,9 @@ static int copy_to_user_tmpl(struct xfrm_policy *xp, struct sk_buff *skb)
>  	if (xp->xfrm_nr == 0)
>  		return 0;
>  
> +	if (xp->xfrm_nr > XFRM_MAX_DEPTH)
> +		return -ENOBUFS;
> +
>  	for (i = 0; i < xp->xfrm_nr; i++) {
>  		struct xfrm_user_tmpl *up = &vec[i];
>  		struct xfrm_tmpl *kp = &xp->xfrm_vec[i];
> 
> ---
> base-commit: 14dec56fdd4c70a0ebe40077368e367421ea6fef
> change-id: 20240221-xfrm-avoid-clang-fortify-warning-copy_to_user_tmpl-40cb10b003e3
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 

-- 
Kees Cook

