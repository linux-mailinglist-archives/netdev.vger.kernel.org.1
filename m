Return-Path: <netdev+bounces-142433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30729BF171
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B2D1F21FED
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A881DF738;
	Wed,  6 Nov 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SrJHzT37"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC21D07BA
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906425; cv=none; b=Qt8CKftPnCr/WdzkQJduTvPPtli+2FnvRYatpUAqLtY2D40knXJeW/t4Sk8XdHaoExG3xQ1NGshBBoR6cHcf9ngETFN12nKsbZ0vHPpk2Pq0sZ0c+gwJobAOCfn7CBu8gZ51yzPqNmdf4JeBDdF3z/3jGMmaNRjwf4hbaXiVbfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906425; c=relaxed/simple;
	bh=06qQ40VPBO8i2b5XFmxi3IY5hNXmmOQBABVvlwKL840=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRRHRUxopfRv0RaK93dZltqbabdGL7WepoVRbk6vYSoFg4in+atfbRq5GTdT+BkX0Mee4I0sArFgeiXuHwSvNeeD866ULC5Wdyvt0d/59Hbkwcgppj1DaaScQRH2xf6QS0gp871GNk/h8Xplj7rT2k77+6pJjnajOgGUQ2poAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SrJHzT37; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43169902057so53554225e9.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 07:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730906421; x=1731511221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Rbc040G2DwEixD7LnDz0ERHniRWs9U35z85JLiTWkM=;
        b=SrJHzT37/OzREq+D4Pagt/g+JYHKNrY1ImixrrDlICO6ZQ06v63xgE8lNXRGhwWGl2
         h9bouuTKiocy+f9eMTKwdfD1Pr8L3zzoPXydWkuOPP43Hw7sUs4Zy1Di0RG2biFqzpvN
         B4fqc2IhuRBTqChvz/LlrWlMaHLk8dBp8wF+FkqLm3oNMh+2O/E3Ktc+z8GilxJ8OoeQ
         fjwL6E14YBQ8tvBb6IW/i3KEayuDVf5It4ZwjJRGaWjZNdT2u5hwqV78mVM/gW3o2B+n
         xhgDwP9PrwDugIr/si+nLhte9HwNPvC48+wbphZCfm5CQxJHuIt8N6N+tFruWF1u371f
         fZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906421; x=1731511221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Rbc040G2DwEixD7LnDz0ERHniRWs9U35z85JLiTWkM=;
        b=mh4LXVpuI1xr+F1BU6eU2VQaiYVnz/RCeXsuVinEbfy5DQ1R3fjFHsv3LRUY/s/Vba
         A9cYc8LsWUz2bW+EFPmj9+Z/SaxBeipDIOiPpu4B0rmKnsRBS/38n6YVCJYu7ktkZA0R
         U7wseZ09rOExNmfmCylGyoOBIoHsO49uC0plPuIa21Z+sG8oCeZZIyl+hGuNvpajDhHm
         WeRHafhIBYTZaQ5Pp2HVHn2uE7kqbwK6s7wfeI9Cxw/5UFBYJV+rSi8IGjAz9DTBv97f
         mMZnSkUe2hgcchEM/sLw/aXKxSeg1VMeXAEsWBxlFapDyFwGAwu38V74eTco3ARKpipQ
         2zJg==
X-Forwarded-Encrypted: i=1; AJvYcCV2a0GJavO/TOFFSfqUkfo5BYxdR/wB5UAd2uN5dFpLikOqznWNPRI5mPHS5sAzxEEu3b2lZTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXP4TKE/GCIkrD79KWylrK/hWC+0ajU87kf8vxiVndr3hwBoaq
	jn6RfEVk/ggV/hgQLq18CZtgQH4bPVjN5laDvPbVix5TCx5Gulb0KL97G1EThNQ=
X-Google-Smtp-Source: AGHT+IEG+q/tbTZpkHFjlxIWTpbOlXM6JmOeMSMQgfCGyv45b+Edm4GYpWnt7AEi3KaUQUaXS8NlGQ==
X-Received: by 2002:a05:600c:1c29:b0:431:588a:4498 with SMTP id 5b1f17b1804b1-431bb985df9mr251593635e9.14.1730906420718;
        Wed, 06 Nov 2024 07:20:20 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6ae615sm26424965e9.8.2024.11.06.07.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:20:20 -0800 (PST)
Date: Wed, 6 Nov 2024 16:20:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Wentao Liang <liangwentao@iscas.ac.cn>
Cc: viro@zeniv.linux.org.uk, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: miss media cleanup behavior
Message-ID: <ZyuJMJSTLLRg5NOz@nanopsycho.orion>
References: <20241106141152.1943-1-liangwentao@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106141152.1943-1-liangwentao@iscas.ac.cn>

Wed, Nov 06, 2024 at 03:11:52PM CET, liangwentao@iscas.ac.cn wrote:
>In the de21041_media_timer(), line 1081, when media type is locked,
>the code jumps to line 1136 to perform cleanup operations. However,
>in the de21040_media_timer(), line 991, the same condition leads to
>an immediate return without any cleanup.

Don't use line numbers please.


>
>To address this inconsistency, we have added a jump statement to the

Who's "we"? Just tell the codebase what to do, what to add, what to
change, etc.


>de21040_media_timer() to ensure that cleanup operations are executed
>before the function returns.
>
>Signed-off-by: Wentao Liang <liangwentao@iscas.ac.cn>

You are missing "Fixes" tag blaming the commit that introduced the
issue.


Actually, just to make things in the same way de21041_media_timer() has
it is not a good reason to do so. What are you trying to fix? What issue
you see. Why the code change is ok?

The code itself looks okay to me.


>---
> drivers/net/ethernet/dec/tulip/de2104x.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/dec/tulip/de2104x.c b/drivers/net/ethernet/dec/tulip/de2104x.c
>index 0a161a4db242..724c0b3b3966 100644
>--- a/drivers/net/ethernet/dec/tulip/de2104x.c
>+++ b/drivers/net/ethernet/dec/tulip/de2104x.c
>@@ -988,7 +988,7 @@ static void de21040_media_timer (struct timer_list *t)
> 	de_link_down(de);
> 
> 	if (de->media_lock)
>-		return;
>+		goto set_media;
> 
> 	if (de->media_type == DE_MEDIA_AUI) {
> 		static const u32 next_state = DE_MEDIA_TP;
>@@ -998,6 +998,7 @@ static void de21040_media_timer (struct timer_list *t)
> 		de_next_media(de, &next_state, 1);
> 	}
> 
>+set_media:
> 	spin_lock_irqsave(&de->lock, flags);
> 	de_stop_rxtx(de);
> 	spin_unlock_irqrestore(&de->lock, flags);
>-- 
>2.42.0.windows.2
>
>

