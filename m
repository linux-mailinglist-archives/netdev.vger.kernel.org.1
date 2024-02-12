Return-Path: <netdev+bounces-71047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1EF851CF9
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D381280C34
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB33FB3E;
	Mon, 12 Feb 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JFDhUgd0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5A41232
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763198; cv=none; b=doZ5Msbz2a6/pcPp1CHGoFWHWU2OiGFjmwBdgWNyx/hUb3ljrROhcr4qYFgf3WFEvXFzjphMuj6iKnEqH58kuWp4GeM+wa2jTi/s7jzs+zJVRiyjjK90lkvzlRWEQrdkVYFWEmICbrXJLaHff3PZg5gSLpj8WgA2/MdFtu8JDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763198; c=relaxed/simple;
	bh=7KtAdzkHlAnlWvBMfwT8WuB4d0+O69tA+YUmbppsXYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF/JtiYsbbMtBcjw8OHFeNHRjW/GuarxNSUYtkNGGwdqx/WQ5OicI2DFMVZHmsB7QKDBwiyxFPGzAWJmdQdDZuUr8p8rKBCQv/eIJObhz39ZW8xJv3IVWyMBKksX91Pe0ocH6dAOehae1ivMsucQ3xxTauw/vTDvl60NkJlWLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JFDhUgd0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d746856d85so26102165ad.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707763196; x=1708367996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YijPAo9UAwvKC5x3U10lyWMs/fUv03XEPORJYdFtyCY=;
        b=JFDhUgd0nlRV6kKZ2ZArI8mQDAHMqmA1jv5I5v7A9PDsiow3lsndcAw7Y4feSypY2f
         2PzwTAxVtQ255Qa1BuIQ0huvSTe0kwf1LQ1NT8WGwpT7Tq2vSWZCi24W2GOMHCe3t9cO
         poTjyzd8xXGu4WtfK3Kfu18NKr2vPV36eahYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763196; x=1708367996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YijPAo9UAwvKC5x3U10lyWMs/fUv03XEPORJYdFtyCY=;
        b=BccuMbnfp5bXE3ZKoKWFL0/eEoFol3Z2/c+yh3whva/nkkjFEtqCHVhfx9DNvgStON
         /QRIgOzj0fev5r6iDpgYo4YtktXH05Jm+A6Og0yETeHP5X/FOvZLK25+lchbvM6tR/oy
         Ll+hY9edPV6UgokMniymGwVz6Xc+zOSOx8TapGecDXMOcTwePdRmworclcUEdNCMK7/c
         W0djPp4zpHm8z12Kutpw89jhsgrSDLEg+ccGbAtY04xUw77sqvXUyqHYZw/k5E05WChH
         Layp2P/ZvigkV9MNxP7vZyDrL841TlMZ8tFGxAoztd3aMLKpvxobRqMb9hYgg0vY08xq
         B95g==
X-Gm-Message-State: AOJu0YyFezYXsYE5gYKEXgMC4dvKUA5b4A2a6eMF1PjPP00jWTnTvgsK
	VD94j0x0bUpEOZN0lQTTLJaVPYgiHsO0xLhOiIucbmOOP3n6DhX4e7GTjQKTWA==
X-Google-Smtp-Source: AGHT+IFNcP+SAxS7irWemqCnEtzUPbDRNv7kDAYXRdvsinYmZVPoZxaqJoA4GLxcd3SxCHhrzLfHKA==
X-Received: by 2002:a17:903:643:b0:1d9:f5dd:2480 with SMTP id kh3-20020a170903064300b001d9f5dd2480mr6438396plb.54.1707763196526;
        Mon, 12 Feb 2024 10:39:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkSQrFxcWP1o0ZHsxTq6YWmTvkekg3UtzXbispm3ZC82vaz4gnDazH6bGYamsNT0Ix+wPRjHrJzl/hnlZnJTjvX2ya1cGzvLypKkd5rsfVF8Luo3EZGRKp3Sa1DRT66UK0NL7/w1w1ZkEFX06lirixckwb5i5dUm9xWEvGP3ukeMVkNNxLjpB7IYca0F/BJ6SgGeCABxuSjpSgPKeijZrq/CxNmOpX10wEqvU9WDEypPV5ePHIVPlm7DWOI3yCm90l4uWFb0L2gaLgrHbv59EnaeSyGULKK2SQRKTZ9idGsg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170902f98e00b001d95eec000esm664121plb.27.2024.02.12.10.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:39:55 -0800 (PST)
Date: Mon, 12 Feb 2024 10:39:55 -0800
From: Kees Cook <keescook@chromium.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qian Cai <quic_qiancai@quicinc.com>, mptcp@lists.linux.dev,
	netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] configs/debug: add NET debug config
Message-ID: <202402121039.E14DF37@keescook>
References: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>

On Mon, Feb 12, 2024 at 11:47:14AM +0100, Matthieu Baerts (NGI0) wrote:
> The debug.config file is really great to easily enable a bunch of
> general debugging features on a CI-like setup. But it would be great to
> also include core networking debugging config.
> 
> A few CI's validating features from the Net tree also enable a few other
> debugging options on top of debug.config. A small selection is quite
> generic for the whole net tree. They validate some assumptions in
> different parts of the core net tree. As suggested by Jakub Kicinski in
> [1], having them added to this debug.config file would help other CIs
> using network features to find bugs in this area.
> 
> Note that the two REFCNT configs also select REF_TRACKER, which doesn't
> seem to be an issue.
> 
> Link: https://lore.kernel.org/netdev/20240202093148.33bd2b14@kernel.org/T/ [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - It looks like this debug.config doesn't have a specific maintainer.
>     If this patch is not rejected, I don't know if this modification can
>     go through the net tree, or if it should be handled by Andrew.
>     Probably the latter? I didn't add [net-next] in the subject for this
>     reason.

Adding these seem reasonable. I touched debug.config last, so I can take
it via the kernel hardening tree if netdev doesn't want to take it.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/configs/debug.config | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index 4722b998a324..509ee703de15 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -40,6 +40,12 @@ CONFIG_UBSAN_ENUM=y
>  CONFIG_UBSAN_SHIFT=y
>  CONFIG_UBSAN_UNREACHABLE=y
>  #
> +# Networking Debugging
> +#
> +CONFIG_NET_DEV_REFCNT_TRACKER=y
> +CONFIG_NET_NS_REFCNT_TRACKER=y
> +CONFIG_DEBUG_NET=y
> +#
>  # Memory Debugging
>  #
>  # CONFIG_DEBUG_PAGEALLOC is not set
> 
> ---
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> change-id: 20240212-kconfig-debug-enable-net-c2dc61002252
> 
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 

-- 
Kees Cook

