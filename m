Return-Path: <netdev+bounces-61861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05FF825157
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD341C21525
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2ED24A1C;
	Fri,  5 Jan 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgHgGLPF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D681249FA
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55679552710so6454a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 01:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704448736; x=1705053536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s2WgUp2uwUQXzqO9cBgyU5Zr8leiFxlRGNJ1vYv0Dw=;
        b=wgHgGLPF/4pmwqtpKGyRRzEUDBNVHsanWh+stIS1absDp5cjbmXjY6Geg0HjrdIl0E
         9aeMtYtKAtx4ihKOhAfumLucu+I7rRr94TZT4D/5wZ54L9J3nxwX2CgXrR9Sg8nuiNtM
         v0WzhRBM+z+OOptCIZ4CThp9GPnh1ij2cQubuOz0bxs8ieSW3SAnqEeOcf+B06sUgyUa
         0+OIIAF2zZyTxlz+zYoEmga/9fpTFbj+z/vDOzhsMJ26/SKM1fpb44G8ATwQEMlJnQ5R
         mVrBE6+T7Dcpp052gjtqvSlT9bWs+DVtOgpjv02EQIAwCFl+PVibdFXzUYDtAZheL2JS
         0ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448736; x=1705053536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s2WgUp2uwUQXzqO9cBgyU5Zr8leiFxlRGNJ1vYv0Dw=;
        b=G3aIUNA2q0bF9lk7Trh8LQO2Fkee8C5IXFi6vgi8V+x1F6gW4CF/viliwjgtRjLphd
         joVO/gMHN277chWcN+OPVunH6c5nE2n+DgtWFfCyEVCC9ATm8IUHJQqbSY3K2XKpodWi
         eUjBEBdmJWnu5rOh72LbAM3sR4zqrBih7kaalgnJPNPo7dun1DZqCbUtjHYEKXveNvOr
         G61a+bxvlXbBiYVSnTUpfoce/1gNEd8rnBmc7Xj2/MN4mvd7X72rR8aQQP99cmQBELBa
         yPcQEy2b93Jxa0PIrzsMThFZnTHBPLzhdNjJuOU/FVgEOwmKlKVrOzcpXG8GXUsqoX7l
         sljg==
X-Gm-Message-State: AOJu0Yymy7DDZ1W/lkqwkCu3wfezC0FaUZvBYD6sCHYEBAXmM4NnN13c
	I3UrXEqJheNRQ/WE8hK+MAzzYZUs1+9aAxc/SZAb7yqMotN0
X-Google-Smtp-Source: AGHT+IGo7jibauBuN19b7YPIMXdE4o8bzKuR2Wyh4RI9gBM3m94poauJEZy+g8VlmFYxEhnFLZw28+1UZucXoNdFHv0=
X-Received: by 2002:a05:6402:35d4:b0:557:3c8a:7242 with SMTP id
 z20-20020a05640235d400b005573c8a7242mr22196edc.3.1704448735539; Fri, 05 Jan
 2024 01:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105091556.15516-1-petr@tesarici.cz>
In-Reply-To: <20240105091556.15516-1-petr@tesarici.cz>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Jan 2024 10:58:42 +0100
Message-ID: <CANn89iLuYZBersxq4aH-9Fg_ojD0fh=0xtdLbRdbMrup=nvrkA@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: protect statistics updates with a spinlock
To: Petr Tesarik <petr@tesarici.cz>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 10:16=E2=80=AFAM Petr Tesarik <petr@tesarici.cz> wro=
te:
>
> Add a spinlock to fix race conditions while updating Tx/Rx statistics.
>
> As explained by a comment in <linux/u64_stats_sync.h>, write side of stru=
ct
> u64_stats_sync must ensure mutual exclusion, or one seqcount update could
> be lost on 32-bit platforms, thus blocking readers forever.
>
> Such lockups have been actually observed on 32-bit Arm after stmmac_xmit(=
)
> on one core raced with stmmac_napi_poll_tx() on another core.
>
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>

This is going to add more costs to 64bit platforms ?

It seems to me that the same syncp can be used from two different
threads : hard irq and napi poller...

At this point, I do not see why you keep linux/u64_stats_sync.h if you
decide to go for a spinlock...

Alternative would use atomic64_t fields for the ones where there is no
mutual exclusion.

RX : napi poll is definitely safe (protected by an atomic bit)
TX : each TX queue is also safe (protected by an atomic exclusion for
non LLTX drivers)

This leaves the fields updated from hardware interrupt context ?

