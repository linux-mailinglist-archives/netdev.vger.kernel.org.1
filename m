Return-Path: <netdev+bounces-92223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53BA8B6037
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB69286CBA
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 17:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778D9126F02;
	Mon, 29 Apr 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eq+VGPhl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA08664A
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412187; cv=none; b=stPx+rxdExa7OYLUMtKhC+MVtPZZGbpu1Ry0GOjIQLC52bPGYjb1J2LfVAOGU0IWg7LWZ2XZa/8WnwQPfEBL8Lv74PB4rNcsDn5klwzf9+FT7Ur7NLPNQ0wWIL349IxAv2Z+taJXywgWFJm8AvvHJHdLXQzL6s9XGVqGi3SWg9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412187; c=relaxed/simple;
	bh=F2AZ41y1R6424JjFgSyicWp4fFZ1oOk1ynLixJHhpUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/l3yuF63svN/8x/dNRjDIo8fu0GrirsEAY442ob+fGNPSLGTpfS2x4j1dVfj1Z8JC/UbUTorMFmYGDOsg0PGmj1rvTe8W/3x47tHxMZbaIEdaGVxCPdyU1NTgykhuwdRkDw49FpXt6WfyTzONc7QlqX3ywgf6Y11wj1Y+LsRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eq+VGPhl; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23333dddd8aso2199387fac.1
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714412185; x=1715016985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+a9g8XAN2Fg2Xk7kKiOoerz6VrBxpW3xT1NbWHfL1ig=;
        b=Eq+VGPhlgBNmW0HlgHsKNytRMLkJAa++00t4c0v6tiV2NFbPH+y6SlXWccSPuUpaXv
         OcAqqcyiZvLk5L9DmWwMWeAHHwUY9Yvv2kkPQMeqRaea2nVKz8H26h5etYcxgmZaAxTq
         Wj3MxN8nYk10UYyKQaG8ZWTjJYiUk0Lik/k/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412185; x=1715016985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a9g8XAN2Fg2Xk7kKiOoerz6VrBxpW3xT1NbWHfL1ig=;
        b=b1NjNfY69YKBwLj4vY+1IjDbhDzom5F4w6wBJMw1T5Zju3qY5MWy6or3cK2/y8ZA/P
         sGObwATIpbKnQp7OKz3fayJY5XzlvO+NafwdiRsZ7KyC4IIxMOA1dtc1zwUOp5Dc/9sm
         rWjsFVDbKreyaH4GjzKMB3w4+YyN+jmKOiD3pQbjL0RcJGKUNmRJpDMSOEEd/XecFezt
         pDo7H2o3InF3WIL6OPP0Ni6eaILi0e3SBcpDnscxAgHWMBBDYKyMR58kjW1K0+zHUKo5
         HY3xK5hhEmzmZ99RPjknIUWuhpKSpj83EKOC1udvJOXCg7oIuSiCF1fG4MZv/GgYLiw3
         +8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUj8/GGVoXGaAPzUoh0uS0mb7DBS7/LvdzJR4QXeJ7KDIwA7kUyaSLkzOs0uPrc2Bn5zRHW97VLiwuBGXo87rdz+XM2rAp+
X-Gm-Message-State: AOJu0Yznm1QOSURjAjQ/Esncvwem6nq9+Idx6Ona+SPxp+7lNZBOpX0d
	wWUdt41SyccLq0cZ+G9GdOz8+PZYdiidPwzl8CkIuUuwq6xakTl06KVLvpyVTA==
X-Google-Smtp-Source: AGHT+IFkeheTXy7RqOcikC0mcBdqOX+uMYNFLcJxynabJyF4Wfd8rC11HWehnWpDbNdIEuOmUrxZAg==
X-Received: by 2002:a05:6870:e3d2:b0:21e:b8f7:9a1b with SMTP id y18-20020a056870e3d200b0021eb8f79a1bmr12046278oad.25.1714412185006;
        Mon, 29 Apr 2024 10:36:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e131-20020a636989000000b005e43cce33f8sm19368253pgc.88.2024.04.29.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:36:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:36:23 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID: <202404291030.F760C26@keescook>
References: <AS8PR02MB723756E3D1366C4E8FCD14BF8B162@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB723756E3D1366C4E8FCD14BF8B162@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Fri, Apr 26, 2024 at 07:22:47PM +0200, Erick Archer wrote:
> The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
> trailing elements. Specifically, it uses an array of structures of type
> "batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
> declaring a flexible array [1].
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions). In this case, it is important to note
> that the attribute used is specifically __counted_by_be since variable
> "num_vlan" is of type __be16.
> 
> The order in which the structure batadv_tvlv_tt_data and the structure
> batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
> type error.
> 
> Also, avoid the open-coded arithmetic in memory allocator functions [2]
> using the "struct_size" macro and use the "flex_array_size" helper to
> clarify some calculations, when possible.
> 
> Moreover, the new structure member also allow us to avoid the open-coded
> arithmetic on pointers in some situations. Take advantage of this.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Thanks for this! I think the readability is significantly improved.

> [...]
> @@ -3957,17 +3947,18 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
>  
>  	num_vlan = ntohs(tt_data->num_vlan);
>  
> -	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
> +	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
> +	if (tvlv_value_len < flex_size)
>  		return;
>  
> -	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
> -	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
> -	tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
> +	tt_change = (struct batadv_tvlv_tt_change *)(tt_data->vlan_data +
> +						     num_vlan);

This is the only part I'm a little worried about. The math all checks
out, but the compiler may get bothered about performing a pointer
calculation using the vlan_data flexible array memory. As in, this may
be calculated as an array offset, since it is the same as:

	&tt_data->vlan_data[num_vlan]

Which, for big endian where __counted_by is in effect, the bounds
checker may throw a fit since we're going past the end of the array. In
other "multiple trailing flexible array" situations, we've done the
addressing from the base pointer, since the compiler either knows the
full allocation size or it knows nothing about it (this case, since it
came from a "void *" function argument). I would suggest:

tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data + flex_size);


-Kees

-- 
Kees Cook

