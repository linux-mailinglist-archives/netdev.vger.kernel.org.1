Return-Path: <netdev+bounces-94681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82718C0318
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2572F1C20BFA
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DEA2E3E8;
	Wed,  8 May 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6JP2IHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0D1E4BE
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189443; cv=none; b=f8iZhXbeYg3OIUR0hwjW2rPJt9KXx0kYljXpBWyJn8jatMETu/svBg0VqgUHjlREtjJsvwB/gkQ/kxiykp8pPx2VFSARhHqK6EZM4blWYhV/nlkhU8nH/uCqixT+LjCaymqurp6oibDeXCgG0YgAIww/LzP7b7H9V4+fxA0ZC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189443; c=relaxed/simple;
	bh=Pz2VI/tUnCe2PTX/epLY/zIwUao0PXF5XSpGrBWENXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVhKuFwKO5uC+S2S9O4HYbw46le/dp26eS1IUTXnuqfh112XIwMGDJZAbWGCBHNpLM+DO9vUiVytmCKdgdqtcXfTrUYE5XMreC6nVrmMdJv2vaQJmpLbftYDu+wsGaA+bqcSunGZjzZEvU8g4M5j+NbJykjtJSqvVrzd9HRYpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6JP2IHs; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7e182550dd1so85220639f.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715189441; x=1715794241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mgm/AtxEukOMRpXROxzGV8zR2nPhcjaYsjDxy8RLMoE=;
        b=m6JP2IHs/XzCbhFIT4yUp3GiQV4zMVUmxZNmQJmCuQWeUx/lNBC5j0tebUMLOi1wtX
         f+meWUyxFMEYhvT3FAHyJ/jYkgC3+5lVPWGgOEpwwBObOgYSPmQCjRElf+doO7fM73Nv
         cidlZXQyhyAP4clHgTkMaVgiqJ75xuNGrOLLRF8GSyerK06oOSKcS7YvVe1RoS1vWFwV
         Ab0itJLWp+6PmilCIKIGIEJ4Tmx+qd7tg+5jZrzeZcG//Sz+/lxDHUwtee+LvxwL2oCS
         bjrtiHhMHVRfzZcGEhctyU722SaFoAAuy3Z1CF0kju4LquP640xA53+vm4nqTnbaetqv
         opqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189441; x=1715794241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mgm/AtxEukOMRpXROxzGV8zR2nPhcjaYsjDxy8RLMoE=;
        b=YnoksSZntTp2f4xoEAqvIu5szHYYUZ6hSLH8N20yvZPGgM3avRxue3iI4sVg+dlD8/
         MLhpdDUSNCV+QJxq/Goo1baatKTlqNAwlMA/x1tMTD9FsgfhHcCq6lrC1dQYNL2OCNce
         v1FoZGdDnBPIl4l55/1578e6xebNMCCPZaok2BIijKykqw+O0TmsY97aAZPf28WtvAyl
         nESjh5LG8JiWp7MN5WC1QmyB77LzxwSFDtCZNMamJwIffP/43cIg0GPLtFVkg/1saK6S
         kagyh+DsyQmhx6/WlP7YIi4lSU74R67S/Cozd5MkbLF01GtwF5TWF2T6hWY/8rQHQI2E
         5fyA==
X-Forwarded-Encrypted: i=1; AJvYcCXhD4tyUZ8TglBKG5ecw0ZC6JghEUjZ7Kldf6J/0YE8lhTJ8zPIahdW8req6rI0j8NIQ0SFzEkiUiW8qmtP2ECAPljN6brs
X-Gm-Message-State: AOJu0Yx2+iucGBx99serCHIhlDns/tAKm4c4U0Oc1Un9d0xdh+bCPkfo
	uHdONVvZzHVHf4W4qYX4u094fmSLg0B+Wdzf64JSqICsUplAg5/mnkb7pscuIQ==
X-Google-Smtp-Source: AGHT+IG4qUlJD1aPV5UJ4KvhFf5gOtyA8cYn/UXu+JKeaXX6SvVh6CB/+n/AvLPMv49pJsB3HndHlA==
X-Received: by 2002:a05:6e02:b23:b0:36c:4348:35d7 with SMTP id e9e14a558f8ab-36caece1c45mr33919075ab.9.1715189440618;
        Wed, 08 May 2024 10:30:40 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id p6-20020a056e02144600b0036c4d8185b6sm3300996ilo.69.2024.05.08.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:30:40 -0700 (PDT)
Date: Wed, 8 May 2024 17:30:35 +0000
From: Justin Stitt <justinstitt@google.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] gve: Use ethtool_sprintf/puts() to fill
 stats strings
Message-ID: <c4feqxslfjh6arvmwww3vylrfue3xl7ywj3eeg3wcujmjyteai@i7ymdkg2ihd6>
References: <20240508-gve-comma-v2-0-1ac919225f13@kernel.org>
 <20240508-gve-comma-v2-2-1ac919225f13@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508-gve-comma-v2-2-1ac919225f13@kernel.org>

Hi, 

On Wed, May 08, 2024 at 09:32:20AM +0100, Simon Horman wrote:
> Make use of standard helpers to simplify filling in stats strings.
> 
> The first two ethtool_puts() changes address the following fortification
> warnings flagged by W=1 builds with clang-18. (The last ethtool_puts
> change does not because the warning relates to writing beyond the first
> element of an array, and gve_gstrings_priv_flags only has one element.)
> 
> .../fortify-string.h:562:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
>   562 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^
> .../fortify-string.h:562:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
> 
> Likewise, the same changes resolve the same problems flagged by Smatch.
> 
> .../gve_ethtool.c:100 gve_get_strings() error: __builtin_memcpy() '*gve_gstrings_main_stats' too small (32 vs 576)
> .../gve_ethtool.c:120 gve_get_strings() error: __builtin_memcpy() '*gve_gstrings_adminq_stats' too small (32 vs 512)
> 
> Compile tested only.
> 
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Simon Horman <horms@kernel.org>

This patch looks good and follows similar replacements [1] I've made in
the past.

Acked-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 42 +++++++++++----------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index 156b7e128b53..fe1741d482b4 100644
>

[1]: https://lore.kernel.org/all/?q=f%3A%22Justin+stitt%22+AND+dfb%3A%22ethtool_puts%22

Thanks
Justin

