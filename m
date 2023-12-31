Return-Path: <netdev+bounces-60673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A265B820E60
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 22:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EE31C21885
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F5BE5F;
	Sun, 31 Dec 2023 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMsJYrtq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6DBA34
	for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 21:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA67C433CB
	for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704057026;
	bh=ADVGoneIdstsKr16ibvhATBX2Jiv5nuTwiT5ZmAB7uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mMsJYrtqq4LMq2n82y8wETztYdodApGnxwGg+GmF/fsg+Ly8iBq4pnLPsBnVMhmh4
	 5c1ztsuoXvvKITo/k+/Vmjxg+rJzZqA81oNlBN5ir1oAVYR+LcDVDeK3w6ZAWm5ELh
	 m2nWVIhPKsQGoxi7n568Y2ubOQOtj20Ip/DwZrY/0aIyMEK20UWg50hnG1T3+NRni0
	 kLWpnlH5vzNhFzHbKy0FXmcv/Wzfg7DMyIsB+AP35SPMtVTtI9StVywzJ8F8wmkFBd
	 8Ki/lYpXU/t/z4a4c53Bpi+eyHRDja4BlUIgGrxQxD6Px1GSgaIXmuy5LX9q7ikYY5
	 ti/+oUy7oT4zA==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6808c3938afso19440536d6.1
        for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 13:10:26 -0800 (PST)
X-Gm-Message-State: AOJu0YykgtA2fO3rekPY+qaYjCNwXP8u2bRRgZJfE88lBCVPD/QC2qqC
	lnoJwMD3Af5Ey9nB+4NNPWTLWjMl7O98BrzoZRaRrHAnTxhW
X-Google-Smtp-Source: AGHT+IFE+RuDfp0wNzIxM7ulzxdLkwtysZpnvjF5g2Rdw2duSR/L0bQDW47w7X+fmx+mIfbo4pFi/FYf4uHacQVW2Sw=
X-Received: by 2002:a05:620a:22d:b0:781:e26:a513 with SMTP id
 u13-20020a05620a022d00b007810e26a513mr17770518qkm.14.1704057004460; Sun, 31
 Dec 2023 13:10:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231170721.3381-1-maimon.sagi@gmail.com>
In-Reply-To: <20231231170721.3381-1-maimon.sagi@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 31 Dec 2023 13:09:52 -0800
X-Gmail-Original-Message-ID: <CALCETrUd=16gAYvx93EsyMaaSJ-6mLvSru8Gie48Y+_dXq5FGA@mail.gmail.com>
Message-ID: <CALCETrUd=16gAYvx93EsyMaaSJ-6mLvSru8Gie48Y+_dXq5FGA@mail.gmail.com>
Subject: Re: [PATCH v4] posix-timers: add multi_clock_gettime system call
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, luto@kernel.org, datglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org, peterz@infradead.org, 
	hannes@cmpxchg.org, sohil.mehta@intel.com, rick.p.edgecombe@intel.com, 
	nphamcs@gmail.com, palmer@sifive.com, keescook@chromium.org, 
	legion@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 9:07=E2=80=AFAM Sagi Maimon <maimon.sagi@gmail.com>=
 wrote:
>
> Some user space applications need to read some clocks.
> Each read requires moving from user space to kernel space.
> The syscall overhead causes unpredictable delay between N clocks reads
> Removing this delay causes better synchronization between N clocks.
>
> Introduce a new system call multi_clock_gettime, which can be used to mea=
sure
> the offset between multiple clocks, from variety of types: PHC, virtual P=
HC
> and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
> The offset includes the total time that the driver needs to read the cloc=
k
> timestamp.

Knowing this offset sounds quite nice, but...

>
> New system call allows the reading of a list of clocks - up to PTP_MAX_CL=
OCKS.
> Supported clocks IDs: PHC, virtual PHC and various system clocks.
> Up to PTP_MAX_SAMPLES times (per clock) in a single system call read.
> The system call returns n_clocks timestamps for each measurement:
> - clock 0 timestamp
> - ...
> - clock n timestamp

Could this instead be arranged to read the actual, exact offset?

> +       kernel_tp =3D kernel_tp_base;
> +       for (j =3D 0; j < n_samples; j++) {
> +               for (i =3D 0; i < n_clocks; i++) {
> +                       if (put_timespec64(kernel_tp++, (struct __kernel_=
timespec __user *)
> +                                       &ptp_multi_clk_get->ts[j][i])) {
> +                               error =3D -EFAULT;
> +                               goto out;
> +                       }
> +               }
> +       }

There are several pairs of clocks that tick at precisely same rate
(and use the same underlying hardware clock), and the offset could be
computed exactly instead of doing this noisy loop that is merely
somewhat less bad than what user code could do all by itself.

