Return-Path: <netdev+bounces-192497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC52AC00D0
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516CB189FC4B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39CC23AE95;
	Wed, 21 May 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XPdBFHMy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE342356B4
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747871516; cv=none; b=DS8MlBmotUzjR/wl+Qm0vUcs/gfoW3hMwaHjk5d1iUBNfiZhSkoiotwIoCaxt3CrHFEuMYakPsRA1MAElV4Vqgk7PlGQftfIFnk0WNYdE8WvmOmXHNfFY8jSMdr4py9JaM47/0v26RggrcV4ppVCQ8JT9p74+dlY3akCYkkiz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747871516; c=relaxed/simple;
	bh=shHXBB3coCQypIwl6wJ0Ke65sD39lWEF8uZBG2+9XW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjdcpYz3DxwBMPNQGTJ+SWFXEkWMUvxnibaDvzZqA87QUzLCX60w6CcrGQUkpxRLPU9E1qm70+10plJDXeQe3K6kw+fbZ351e/pvueN7tPnRk17vSRuwlHqgo6IAp4knINakYGCwuGbxpPzXmISeCyPWJUsMpC5KmoyOMJPYiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=XPdBFHMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38F3C4CEEA
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XPdBFHMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747871512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shHXBB3coCQypIwl6wJ0Ke65sD39lWEF8uZBG2+9XW8=;
	b=XPdBFHMyUARTaXO8Of1MYeI1Nf1oN6dguaNkXzwfqVQDJp6LF5AR+27e4u8byeqIY9TgJ4
	GEIcNlMZfo//dOUyGYU1jUuzToiDs1jESRW321ygebZ9huOEfSgWhIrycQFTVbXZevQMrX
	DM/UzAFvBSQ4GcD9EA/hFfrfr3OL1gI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c6a7c590 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Wed, 21 May 2025 23:51:51 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40356cb3352so5179529b6e.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 16:51:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwFOa5ESH+YqwTcd9d19mgVizk2E+Gv04xPT2e0ZjzDo6dG2giYahzB+24CajgTnU7uNHMUSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2vjSNhj0ozx9lGUTE0IxhzwKRKMHM4uEDSg0z/lg8ACXHNzd
	yIMvGLOZoZIRszaJxn5mlQFIk/H/vBQOxVDJGS3pB9QYmmGEkEMXI4gtMvxW9ez+q+8Q4uHUm7E
	vmJVq32icygp0B/NwMnol+/uF7hRqtWs=
X-Google-Smtp-Source: AGHT+IEIwHNcIpd5V7g/BVe78OFddhwilZu8M9OB/QCWuixELJ53rxcsxekdN+C+d28lwhuGnID+84vasEalnWbuMXI=
X-Received: by 2002:a05:6808:3090:b0:3f9:176a:3958 with SMTP id
 5614622812f47-404cd6a9338mr15020638b6e.11.1747871510514; Wed, 21 May 2025
 16:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517192955.594735-1-jordan@jrife.io> <aCzirk7xt3K-5_ql@zx2c4.com>
 <aCzvxmD5eHRTIoAF@zx2c4.com> <vq4hbaffjqdgdvzszf5j56mikssy2v2qtqn2s5vxap3q5gi4kz@ydrbhsdfeocr>
In-Reply-To: <vq4hbaffjqdgdvzszf5j56mikssy2v2qtqn2s5vxap3q5gi4kz@ydrbhsdfeocr>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 22 May 2025 01:51:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9rbRpNZ1pP-y_=EzPxRMqBbPobjpBazec+swr+2wwDCWg@mail.gmail.com>
X-Gm-Features: AX0GCFuMANmqfDSG4JH6SXWxpZ4_QbTk3_0NFmDMO-JkLf12gfBrPBxF6YfJbtY
Message-ID: <CAHmME9rbRpNZ1pP-y_=EzPxRMqBbPobjpBazec+swr+2wwDCWg@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 wireguard-tools] ipc: linux: Support incremental
 allowed ips updates
To: Jordan Rife <jordan@jrife.io>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 1:02=E2=80=AFAM Jordan Rife <jordan@jrife.io> wrote=
:
> > > Merged here:
> > > https://git.zx2c4.com/wireguard-tools/commit/?id=3D0788f90810efde88cf=
a07ed96e7eca77c7f2eedd
> > >
> > > With a followup here:
> > > https://git.zx2c4.com/wireguard-tools/commit/?id=3Ddce8ac6e2fa30f8b07=
e84859f244f81b3c6b2353
> >
> > Also,
> > https://git.zx2c4.com/wireguard-go/commit/?id=3D256bcbd70d5b4eaae2a9f21=
a9889498c0f89041c
>
> Nice, cool to see this extended to wireguard-go as well. As a follow up,
> I was planning to also create a patch for golang.zx2c4.com/wireguard/wgct=
rl
> so the feature can be used from there too.

Wonderful, please do! Looking forward to merging that.

There's already an open PR in FreeBSD too.

