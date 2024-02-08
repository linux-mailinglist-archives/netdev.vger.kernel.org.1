Return-Path: <netdev+bounces-70244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED4F84E235
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE05E281AB1
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6326676C65;
	Thu,  8 Feb 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS1cWCgc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1A6768E9
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399962; cv=none; b=lg8qIH56pARay9DCcAo4v0rzz2iZYnyPsv0oRT0yTdmUOZKmwJAz6uioaASFOQeUmJ9FFy2x6fnGvik7IRQxpT0vy1znUBlMa0pTmHaTTaRF2YbLQUXSFLBLxSM2+rlSEQTwE3qEMUvTZpxSmCZ0bgixDbDsrIsc+9FzbivgrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399962; c=relaxed/simple;
	bh=3Z83bGwl01Wr3WbUX+5tVgLmLYdm/GKUvlZdQnG6ruY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=gLDooOcTgh+hn+MWqQfOOyE1+teAaGO/YOqCN+AooznJb1zm6yguU6+B2qxTGVP5UUod1bdp+Z6fiYtLCyVcH05X4Qhve1nWTJtBiGYauThLajtD3ic927OIzhsbJPDJItvdmuoxcjl+rYHxhNd+bPkJFOM/3NjwZ1Ev0QoY4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS1cWCgc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fff96d5daso15499455e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707399958; x=1708004758; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErYYRBi8THEZ2RrVtl6FxQRuYTqoNIFAo9ffDOLfMug=;
        b=cS1cWCgcD/COfA5epTc2Rx5cGYkthvAvQDivoahoaHMwcGEUwn5XNwT2xaHBVWl8GO
         ZmA8sqWxn+nBePtUvHk29xZrhuPJb1fnw89m4CRgcCjCRYbFIAdZzzEE9OYflBpdjBvs
         8pKLiIA2p1VL3xYLLUbcOtfkM7hVahsSWdhjCq2Meq04TN+52bIfP029cQfScBnoWvFF
         O9pzPwaVdv6yjiOX3S+HdsKW2gZ51wU6587uVufx29sKFGY+Y9E/ShxB4p2ce0rTwlco
         BmoTOqHfrIR5F/pYYw3+anWHwOvmCoR7YIFlPUM5r/uzROFvEFatXV5OxQA5wk2uagC+
         NxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399958; x=1708004758;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErYYRBi8THEZ2RrVtl6FxQRuYTqoNIFAo9ffDOLfMug=;
        b=tsjXJPPFK57QyyGanbBK7elMEDn4TOS+1VLlF3qXkWTbk/txkU7EXdLKrWgetdYKn+
         RE+SIk2LHHOsPr8/Zb5uURktxLbBeFjd1LzCsJ7HGPVW4VuyxA8Nghsk5c1hrWTQUc33
         sfoPBPFoA6S75u3QecaEtamN813UDFvpcNaCpcN353IvElFhEU8bx5gW9IfpVdNB1P4q
         tp9u6BfUBR7HX1vp5QzixO2FEFZgAgFyDOgMJj5NOyrpzx72Vmkgq3T9qzgSxpGesgTC
         p0Sdw1rNz8eTtiJCqFDO6Aj4/2fTI5rRsTCjY+sCF8j7e/pNAPGZmHayM0RpCuVBMqOL
         T++g==
X-Forwarded-Encrypted: i=1; AJvYcCVBlORxWJC01zH4+ZIuMiC9s5J6dh++0X6fbRBAjzWDlRbfl4RpMi2dX0OFmyLV4fSMLyz4BJdM5xh3DArpl4PI6G29N/9R
X-Gm-Message-State: AOJu0YwFu/RF8Z8LAvoyB5L0Mmh6HGQKz3XVo5uReuMYzl4QnMU3wfCW
	X2K1ajtzo9nTe4eewbenL0o8uTQsx4/9o20XOmsAJJGK7LokQ4TasqoEYhhzaXY=
X-Google-Smtp-Source: AGHT+IGJxOX+INhiCBYeSWVra6arZthsGoXC887ny5VGFFbbTijtTPvXL/pH5O6i6VjLpqnsGsWglw==
X-Received: by 2002:a05:600c:4587:b0:40e:38c4:e7a0 with SMTP id r7-20020a05600c458700b0040e38c4e7a0mr6761715wmo.30.1707399958597;
        Thu, 08 Feb 2024 05:45:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYwo+PXT8a6idsqaOpYTlW3Oa79J9/3a1QRuGt3HkeMz044xAQLXdEy+MZQpqtuoMVIIFdZwtmdvGqOPIyes1GEJVGdP47
Received: from imac ([2a02:8010:60a0:0:4c4b:7e8e:f012:825c])
        by smtp.gmail.com with ESMTPSA id g15-20020a056000118f00b0033af5716a7fsm3620826wrx.61.2024.02.08.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:45:57 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,  netdev@vger.kernel.org
Subject: Re: [PATCH] ll_map: Fix descriptor leak in ll_link_get()
In-Reply-To: <20240207203239.10851-1-maks.mishinFZ@gmail.com> (Maks Mishin's
	message of "Wed, 7 Feb 2024 23:32:39 +0300")
Date: Thu, 08 Feb 2024 13:33:14 +0000
Message-ID: <m2zfwbrsh1.fsf@gmail.com>
References: <20240207203239.10851-1-maks.mishinFZ@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maks Mishin <maks.mishinfz@gmail.com> writes:

> Found by RASU JSC
>
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  lib/ll_map.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/ll_map.c b/lib/ll_map.c
> index 8970c20f..711708a5 100644
> --- a/lib/ll_map.c
> +++ b/lib/ll_map.c
> @@ -278,8 +278,10 @@ static int ll_link_get(const char *name, int index)
>  	struct nlmsghdr *answer;
>  	int rc = 0;
>  
> -	if (rtnl_open(&rth, 0) < 0)
> +	if (rtnl_open(&rth, 0) < 0) {
> +		rtnl_close(&rth);

There's no need to call rtnl_close() if the call to rtnl_open() just
failed.

>  		return 0;
> +	}
>  
>  	addattr32(&req.n, sizeof(req), IFLA_EXT_MASK, filt_mask);
>  	if (name)

