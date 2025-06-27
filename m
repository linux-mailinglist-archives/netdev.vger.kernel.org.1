Return-Path: <netdev+bounces-201745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE3AEAE0A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC0E4E0D85
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD341C860A;
	Fri, 27 Jun 2025 04:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="haRnRn2d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDD41A8F
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999435; cv=none; b=GnKU19fWy3qoi4itLvWZcrE22Z/+LEDuP+OP5f1joapDTYNEMQqUnUv71uvOULhjiK7IKXNXW8edk8Q9nGc7CBx9rSM2fw9BxCuguRYOTFCC+qJCnfg6PUCQCQu4FFwYLKRDWAnqRoXbx9sEo6Xmy25K/k/nnbZlP3jvXDlux4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999435; c=relaxed/simple;
	bh=SXpaVowOjROKHvD2g7AaoOxQ67iSJN5+F0KXnXlPtX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FX1lNDFbS68dOrqzZaAz0+gdVyoKtV6ODCSZH4SEqinZJ6ZuteiI0zxWrIz0laehD+xZxY6YZs5sgTneFKwKQLs9dY7ZFu1e3EMqbV7Zs8AaSFi9vxUI4UFy9mkdZsyMSKLyyvqouz3PxdDUr27rDoXF+0gl04sz/xYgG+XRddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=haRnRn2d; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso17523661fa.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750999432; x=1751604232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxPgQ7YUs21ZfESgNsIrJgnZYu8Jg67aIbBn648ji8M=;
        b=haRnRn2d58Yfsip+nrXshivEk1zvZtov3Ri9CtI4G0iWk4eZosMp1GaGvyDf4lX3VP
         7A1fd8lcIUbLfxxVAKcBuNA+yVrYQHurKS9L3ot9Sf0N5zl9ztoTq7wG0xSFwuP2QCf7
         uwruHmEIhOxIRiq3lu7/r8uKRCivKdKq3LVGpdEjUHciHOG6B/Ag+GWx5hTsmaXL5NZs
         xhtXgKIQ/OCHf/+UG9mKX7O6o3xVO41MW2mGT7UwJ0PUtfTRgKJzphPYK7LTwqQXmmRU
         VDLzWCDJ4+f7NwemJyomM4+dmx/THgyMHPEj904mCLlq9sCm+sgCz8fyltfGANtjXhQA
         lcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750999432; x=1751604232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxPgQ7YUs21ZfESgNsIrJgnZYu8Jg67aIbBn648ji8M=;
        b=Hg81WMqhILu8oVYxVy9ehq/cYrxPXSgp9L9i56OCpHWVori3tziGBnEAbcWm0urNkq
         xOj6+H5Imlpxur45Xr55WyotmUyF9eNJFndqNyjGSu5yg8yyeyv+pXMg5cffZFR8476Z
         kp/DcYi7FIad5reQwb+LoR1oOj00dUgkccpsR8GjUZQHY4F51aDop41a46cw2QVDVlVp
         X57j/Dp3wMZUD43VL7lF6vd6BdXIAnvza1+vYUoJmwWNfhfP4Co+TQPwK095W/y61TXF
         cBQrBWW94VDRmnMbCNnf4e5cEcZjczpR+VjxPF1/sonUoUdA2WOzuSIZ9mmMpHkS0apG
         MI8w==
X-Forwarded-Encrypted: i=1; AJvYcCWoILPFowE0CjQe6qta+294us0gmL5TXukckQt0C+hNb9U1p9Iyk3rx6uBQY8sC5Zd3y6+kiB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6b7sE1Wf/wkWXaaeaxaO4WwA4MXlhHJpQonjN8nlTOaBrKyNc
	5JfI6q8A9oWfAAIFiLEN47t/qe4rOTXPA6JNfHNc+NoE90ie1wyUJ2z6RsXBkwUn7mVLWh2nBEJ
	0RJg69X5kIBcuMe80lWy/CTw5yMcs0nCM0l6hdTo=
X-Gm-Gg: ASbGncsawNpDpkccPsKziHaKekLgE3E4aeT4rKgOkdlNo814SwC/ClLr4fF5SipSgmZ
	y4GyivFnhUrnFrsuDZ2YF76dGkZG2Z3zWFf85lCebusiTKFocPUAMVd2mJf5LBAeaa796hfdXI0
	2W/YfUN+D1j627+1A5kHV67wWAo9ZSNCMshRClpQwJH8/6XcBgaxFzuqWxpxY8T6hBlW4e4QQ8
X-Google-Smtp-Source: AGHT+IEJJskJkIq/rBPDCOQfkGK9/Z5x+dlpvposQwrNHH1cCAWTKZ152aNAZQbtOKXqX5n+tdSL+eqcG1ys62JJS3c=
X-Received: by 2002:a05:6512:3b0c:b0:553:3621:efd5 with SMTP id
 2adb3069b0e04-5550b87b616mr612145e87.16.1750999431682; Thu, 26 Jun 2025
 21:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182951.587377878@linutronix.de> <20250625183757.803890875@linutronix.de>
In-Reply-To: <20250625183757.803890875@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 21:43:40 -0700
X-Gm-Features: Ac12FXzxzb2F3LJMt-X1SlkA3_Sy6GTLLbGhXFe3WHH7ObEPrc8R9eRDfCgOAI8
Message-ID: <CANDhNCqLST-im8WJXTWPsXmqhq2JM9+nVB6phixxH2PT-tQ3Tg@mail.gmail.com>
Subject: Re: [patch V3 01/11] timekeeping: Update auxiliary timekeepers on
 clocksource change
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> Propagate a system clocksource change to the auxiliary timekeepers so tha=
t
> they can pick up the new clocksource.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/timekeeping.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> ---
>
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -119,8 +119,10 @@ static struct tk_fast tk_fast_raw  ____c
>
>  #ifdef CONFIG_POSIX_AUX_CLOCKS
>  static __init void tk_aux_setup(void);
> +static void tk_aux_update_clocksource(void);
>  #else
>  static inline void tk_aux_setup(void) { }
> +static inline void tk_aux_update_clocksource(void) { }
>  #endif
>
>  unsigned long timekeeper_lock_irqsave(void)
> @@ -1548,6 +1550,8 @@ static int change_clocksource(void *data
>                 timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
>         }
>
> +       tk_aux_update_clocksource();
> +
>         if (old) {
>                 if (old->disable)
>                         old->disable(old);
> @@ -2651,6 +2655,30 @@ EXPORT_SYMBOL(hardpps);
>  #endif /* CONFIG_NTP_PPS */
>
>  #ifdef CONFIG_POSIX_AUX_CLOCKS
> +
> +/* Bitmap for the activated auxiliary timekeepers */
> +static unsigned long aux_timekeepers;
> +

Nit: Would it be useful to clarify this is accessed without locks, and
the related tks->clock_valid *must* be checked while holding the lock
before using a timekeeper that is considered activated in the
aux_timekeepers bitmap?

Otherwise,
 Acked-by: John Stultz <jstultz@google.com>

