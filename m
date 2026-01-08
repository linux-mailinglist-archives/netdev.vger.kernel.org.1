Return-Path: <netdev+bounces-247972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB3AD01413
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 07:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6ABBC3002515
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 06:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19B33D6C2;
	Thu,  8 Jan 2026 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0Suw0Kw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EAB33C1B3
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854190; cv=none; b=HQ6RqcKeQU/fIAs0QuCtj5KCKOhuGYorR4o1gwAG7Anmf7mDClk6Siq09WYkDgADTvxUTlOf5tRCVZ3qs2L+oBgdrjl/uxE8jxyPrgCtOg7eMFsJJMJjBmh7RutXK328mNRD2wn7KsiL9O3dd3l+bBEbSYNDtBhBQnrSYv8eF2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854190; c=relaxed/simple;
	bh=maWf8E4/nR6r4iZkfiudPX2lmDBux7LpubjWVpgYQew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ersfcH0kRwQl+57bMcvDwyT0N5YKfJuYacD6MBwmCMbb7EEDVEb+pA1lEkPYEJkAjyvXRoybW5U4g9wlrYkgDW4EgY0ioa1+U+fSwmLdPheAerT3EVaRwFsKd7qfk45niHuqpf1rJpPMjIS3dzgOkEO3WoeKupR+dfEnn7Fme4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0Suw0Kw; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b05fe2bf14so3143566eec.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 22:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767854162; x=1768458962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZuFRSJyxVGvc7rvYjVUrIZJ8+nTlCmoSPS+Ihaf2wKk=;
        b=G0Suw0KwSdJldq9NXSlwsFQPNzWOl/cWYNbOT1hXUCRVZBO3hL2BrURlzj2dZcG1Z8
         hJXCLMTRX+cWP9EBU6Z5k7nyib7bJaRZG5Azv7lxIpsfGvP8X6T+GULhQKbr22Bfsloq
         GyGMdXNjlaKfbYa0KabzzAEAjoBgtj0WONQwEOdte7/pi0tgJd3JnaW6LUy/+peMJteG
         AwBPk0rL6/O0Qma0W9XR1AMicdhDrTIk8v1BYQoqQ04tr+jm6TvydmepenBbgFu60wAO
         IRfOlvj8zQfL8RPAwVD/vGtCpep6Adb7hoQI018/hiRzeC1ebGeuBJiPcOK9iEMtH5mV
         C0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767854162; x=1768458962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuFRSJyxVGvc7rvYjVUrIZJ8+nTlCmoSPS+Ihaf2wKk=;
        b=svEtW07lbdrrU60eKXZfqCeuqerHHNY429MKdxZ0OuF6tkyInNEhvSPY9A0ZpHegtY
         4fFbfk+Zo5Om7Y0O9azpL2o3IO0wPz9p9/Gbezf8mMQ0oUdY9EM5K0w06G/69Uo/Npix
         09w12+wL81xfHHwtcnLSADnxG3Mpz4P7KTQBhtwOj7SJMEPsxDEuDiH/Lxen2+y/BfLX
         yF158I5qlBUbBOO6A0CcKX83EUlDmW9CSOEbgFGqNpd5XJMjjSBUDMrCK5LyrWwOQcS1
         t7tmmWp2hK5dRMj0Vo3uvSIXGxH6QgM2xsxDemeEidaqRk3SMvGTwd95XGYDz1Cg0+Xv
         Se8A==
X-Forwarded-Encrypted: i=1; AJvYcCUGM9/epokOgLSjLlNJjl2TIDc8KgXAilNmyhca+Hv+578rOErrC3IYyo/v5JqnIx0Ym1UsWNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrSzymjinNatWlhlKvnVY5Z0ptYHeAFgvkaDN+Fx5JpJELRmZx
	MCsqMhmPpUy6zgyifakc15DcC+ki9UyQvg70EpcjMkPDFmDA19tGMlZDIzK63w==
X-Gm-Gg: AY/fxX4XUzO8/AYV1DZb5/TIxN8qwjRdzI7iplmIhzHjhk57rEY18qSC0oY54tCq73O
	i1nm/2XNNiDknRwDWKxvd1fF9xQdljfJLZQb90dKhg1iEHYDbzVjmb8enpPvOrbaKGTnnTGkLJn
	xJubqOL0++h0n3JZp1plik+gXLIILi/93dlfHs7QK0cYQrn1YEkc7ngQa10RHN6tRiiqagTQmEj
	UttE7kHGK2T4naohLbUgypwIjmndV11FyqQ85K3/wz9Z/GAqPeDV5AT06XzIqvSKOo46qu0pGZl
	0clmOyZ5cEuO6PcOm3M952YfM1FuaRniRsAeENxjcRC+n+83+pmJJ35g7oiHu8+8B81fjOsyoTz
	RMeQsifOAiD0v62CfGQOsNYzSSaQar/Hv8IXoLiU5sEJwioQ3PaZxOrF+7uPMMSngIOk0cyhMoV
	Ag/Pp7k5uyRYkqhlaekpLUQugqpPVIWAHx32w=
X-Google-Smtp-Source: AGHT+IHr+qha1eOTfp4wLQhnqwmJ68KneYOC7GXQfwKel51U3gavmvexU6VxrRyZtU0m6yrWXG1P3w==
X-Received: by 2002:a53:e239:0:b0:63f:ba88:e8e9 with SMTP id 956f58d0204a3-64716bd5e88mr3638566d50.43.1767847054268;
        Wed, 07 Jan 2026 20:37:34 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a4d00sm25981107b3.41.2026.01.07.20.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 20:37:33 -0800 (PST)
Date: Wed, 7 Jan 2026 20:37:32 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>, asml.silence@gmail.com,
	matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aV80jCHD9PGaOr87@devvm11784.nha0.facebook.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
 <20260107193013.0984ab97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107193013.0984ab97@kernel.org>

On Wed, Jan 07, 2026 at 07:30:13PM -0800, Jakub Kicinski wrote:
> On Wed, 07 Jan 2026 16:57:34 -0800 Bobby Eshleman wrote:
> > This series improves the CPU cost of RX token management by adding an
> > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > binding to avoid the xarray allocator and instead use a per-binding niov
> > array and a uref field in niov.
> 
> net/ipv4/tcp.c:2600:41: error: implicit declaration of function ‘net_devmem_dmabuf_binding_get’; did you mean ‘net_devmem_dmabuf_binding_put’? [-Wimplicit-function-declaration]
>  2600 |                                         net_devmem_dmabuf_binding_get(binding);
>       |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                         net_devmem_dmabuf_binding_put
> -- 
> pw-bot: cr

I see that net_devmem_dmabuf_binding_get() is lacking a
stub for CONFIG_NET_DEVMEM=n ...

Just curious how pw works... is this a randconfig catch? I ask because
all of the build targets pass for this series (build_allmodconfig_warn,
build_clang, etc.. locally and on patchwork.kernel.org), and if there is
a config that pw uses that I'm missing in my local checks I'd like to
add it.

Best,
Bobby

