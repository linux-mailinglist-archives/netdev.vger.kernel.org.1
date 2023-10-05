Return-Path: <netdev+bounces-38177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EC67B9AC9
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 06:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B3D90281865
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 04:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F015C9;
	Thu,  5 Oct 2023 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WnudJe1b"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134951104
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 04:55:52 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2248A4692
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 21:55:50 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3af5b5d7f16so390623b6e.0
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 21:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696481749; x=1697086549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qTkmLJbkNoH1DEt071Z4Lj6n0F0uZ101JE698BdGD4=;
        b=WnudJe1bYEmqh6BpAvVgjxOCcYYaNDC48bvl4Byn5OG7VzY1wDDFbdVqvBnGqTpuhF
         WYKtiSLBdwoIgYq3DAFJ6DETUj260vaG5bDR/pkhwhYGvWG/zFka+8jgI2lW40HI33V0
         PlDmcbMs9G11G9G7y5FP2QcJXRBwgxWKUFu8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696481749; x=1697086549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qTkmLJbkNoH1DEt071Z4Lj6n0F0uZ101JE698BdGD4=;
        b=mOFsClUdH7bucXCL3bGoaF9KmZbCA7tFtpK1XhgvEGFsSz6kT1ed387i8PLOsXGQQT
         F6z8HjIC57ok3s0vI7TA2nB1FF0PIQrxfLCdb9Gch7SThyib7Y9l+0tuhM8y4BcPUp0t
         tz8cw5TUVhZPlOK+hRv07GJCBlrMKN6L3LtY8oueDgcGe772093Ck3OU7kCVbrLHcGlZ
         hyYA3wGM0hWhg/3AXz1FFL1N3FesZkk8wJTZzCiORqrDmfngaYVW33+r1RgiTcbE4w66
         5FbhWEQOpFBB3QjU73DSJ1qJ/OICPw2T8lHOoR7xNOtVBRRCi7dtEdKh52X/YL84QbtD
         kovw==
X-Gm-Message-State: AOJu0YwIcohgQwyquynvvlZKLBzQPnMioX8/C47JXuL02/ri2Rq2ZWuj
	tHfFqkaPjbQkDij65vlTLqHr3Q==
X-Google-Smtp-Source: AGHT+IHoPEyS18WZeo7CvnM9KyZsJnDedFeLw5UokGAmsFPXerM25wZNgmkPytL1cmoHB1Stp2V7dw==
X-Received: by 2002:a54:4e8c:0:b0:3ae:5e0e:1671 with SMTP id c12-20020a544e8c000000b003ae5e0e1671mr4451630oiy.4.1696481749435;
        Wed, 04 Oct 2023 21:55:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a63be4c000000b00577e62e13c5sm369420pgo.32.2023.10.04.21.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 21:55:48 -0700 (PDT)
Date: Wed, 4 Oct 2023 21:55:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ax88796c: replace deprecated strncpy with strscpy
Message-ID: <202310042155.BDF8674@keescook>
References: <20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-v1-1-6fafdc38b170@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-v1-1-6fafdc38b170@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 01:06:26AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> It should be noted that there doesn't currently exist a bug here as
> DRV_NAME is a small string literal which means no overread bugs are
> present.
> 
> Also to note, other ethernet drivers are using strscpy in a similar
> pattern:
> |       dec/tulip/tulip_core.c
> |       861:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> |
> |       8390/ax88796.c
> |       582:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> |
> |       dec/tulip/dmfe.c
> |       1077:   strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> |
> |       8390/etherh.c
> |       558:    strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, this looks like the others.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

