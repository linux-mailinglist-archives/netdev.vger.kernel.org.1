Return-Path: <netdev+bounces-201748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C9AEAE46
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F42316934D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 05:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050A13AA2F;
	Fri, 27 Jun 2025 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToLZklSG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2781B4236
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000462; cv=none; b=p3EwkZlIm0ha1KjL0b9U92bB4x3FfW2ry6cENXZWXlzGvm9wxfEHYxBZeVJpr/eOd3VYBx5n8gbXwuZOKMQvOGujUiNvHSVRTUGo74l5nuYZGy03cK3K7TWOC+pu7h2UgDWSGrL8x8toBwlIGcqI2sUeMWq/65rDg0woaM6HKk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000462; c=relaxed/simple;
	bh=5sxsybdkrGUBKXYDIe9p1RkmhM54REE83fhDh4dcVmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJWTZUjDIbcuNHhwmpeXeCf0/dJOTH+ocyRx/ftgCG/8HPwWcIyn7AUvuK4vZ9N3YjtMPZR4wChBpegkuljtxqcQlq0hlmPr4sbp8K1TJ3skP1Dk0TGfaCmudiL9lqYN9MW+gg+Dh3qSuRbkcQClF1Z4ezjbnF2XMMEjcoZwwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToLZklSG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-555024588b0so1646221e87.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 22:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751000459; x=1751605259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR7cWCLMq3WenuSXEigSyJAepuKCkZmxv9Gwd3tBBUg=;
        b=ToLZklSGOkPtFPZZWuR6NcV5H+o/JuuyEyVpFIY0mM82JdZecd7d7kBfdyR4mFTnSr
         MHqkRg+v/lo8kSgXXPxs0xLYqI+O4e8FC8rLwgDOnetIctvjzMqTphwVbBu7jD+eIR2U
         lQSmxx0yC6131nCzrZn3Jw4mDU/OfOnBWBe6Ea9e8KKmxlqJyLfNTAtpyBVutTneP3rI
         Woo0PGYFnpNSuFAk37dmmh/fnrGotJ/RR0QFn3n25DrSKNRR0kMfqR3NM/EzF49ORsX2
         ypdJqIH6YuqHcHkMcsbEr6QKYsqsZ7VZLywM6IjG0V86h/RAxA1U5KI0lwzoZAy4uG7b
         vGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751000459; x=1751605259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR7cWCLMq3WenuSXEigSyJAepuKCkZmxv9Gwd3tBBUg=;
        b=o9XU3DKIPPzNhfLF2yWTElsFRmfYQr04AETyKBz4j1eyF1Y5ft/Eu1YBg+yfoioaCT
         hmCQakBBHLQPQnV9LOr+PRppMiWbGO+2QRmWumXOJU1xlRgVP0KuajjT0JTd0CBBYlHd
         rYamYKjI8KHPdXLPRl3h3vmJrSLRsNOoLnHpvUJSestPdGfgJFb7slOfvPZy9L7tur0D
         ixZuVV5DErXKV86oZoexnN48IedMukDKo7Lf3xasEe7azIQoA/PnSIY85Qhuq8Wq4GBy
         pZLWYpBnADng2uErRci480yRKyBCYpzIR83pgwGZCLRYGpTCTPy3OmFI3dP9V/8v+xPj
         Meyg==
X-Forwarded-Encrypted: i=1; AJvYcCUzdVpq1j2xe+H88VayPRjfjM0SuGy7RfnrBUDNn+FDbaTEpcZjh3abXNrdDwYblf2Dpy9nm9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YztsU5iBGb/iInuDvSxijQmbi2lKy6GgYlVsHhQu5S+XZDU+q1o
	YebNFLVhv4x/YRsIM/d9+OKYM1K+dzQEL0zJ8Zaqpm30gVLBdI/bja/2Jx4QQgL8u4B2XoSK/po
	noqq0h+HVaPlKFrOe+O9+ogSxQTl72QFYbW5bc+c=
X-Gm-Gg: ASbGncsZKdV58iXmZrCnOwjRKAjYRBBv+gnti7rUDdlfR0/0f6oNTuAWym2w7E1hQgs
	9qEgaEvI2yqlZO/DlAvlXyIMvS7EMu3ySFzQ33BJg/zoNXnXmJTgBEtkV/6k3D2mnv22wYvgZno
	9cV5PJcNcDCXytLHaRtE9VZ+aSx+1ZbTr/lC8xnw6RsoDezgJzkykOSJ7FaaCO9Ti+axzpGpoR
X-Google-Smtp-Source: AGHT+IEO2uMlU4rN6MBnIyvwrGM1yh/mJea89i3Hmq8wQ6a2bo5jIt5NoGFTwwlABG8RudFiMl+2V4oucyLUfHnSqjU=
X-Received: by 2002:a05:6512:138a:b0:553:2d93:d31 with SMTP id
 2adb3069b0e04-5550b84f9f6mr673078e87.22.1751000458926; Thu, 26 Jun 2025
 22:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182951.587377878@linutronix.de> <20250625183758.253203783@linutronix.de>
In-Reply-To: <20250625183758.253203783@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 22:00:47 -0700
X-Gm-Features: Ac12FXybFViwuxBjL7kR7zDd-ff0Ky-2hj1TeYZ2UKuwfof9-sf8-ZR30AbwiSc
Message-ID: <CANDhNCqY5TzY5qWLrZMJYrmwW3XUStvrut2Dd8pc9T+LMaibpg@mail.gmail.com>
Subject: Re: [patch V3 08/11] timekeeping: Prepare do_adtimex() for auxiliary clocks
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
> Exclude ADJ_TAI, leap seconds and PPS functionality as they make no sense
> in the context of auxiliary clocks and provide a time stamp based on the
> actual clock.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/timekeeping.c |   39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> ---
>
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2562,6 +2573,21 @@ static int timekeeping_validate_timex(co
>                         return -EINVAL;
>         }
>
> +       if (!aux_clock)
> +               return 0;
> +
> +       /* Auxiliary clocks are similar to TAI and do not have leap secon=
ds */
> +       if (txc->status & (STA_INS | STA_DEL))
> +               return -EINVAL;
> +
> +       /* No TAI offset setting */
> +       if (txc->modes & ADJ_TAI)
> +               return -EINVAL;
> +
> +       /* No PPS support either */
> +       if (txc->status & (STA_PPSFREQ | STA_PPSTIME))
> +               return -EINVAL;
> +

Just a taste issue, but I think it would be more clear if these checks
were nested under the
  if (aux_clock) {
      ...
  }

As otherwise if you read-over and miss the !aux_clock early return it
seems like you're erroring out on normally valid cases.

But it's a minor thing.


> @@ -2592,15 +2618,22 @@ static int __do_adjtimex(struct tk_data
>         struct timekeeper *tks =3D &tkd->shadow_timekeeper;
>         struct timespec64 ts;
>         s32 orig_tai, tai;
> +       bool aux_clock;
>         int ret;
>
> +       aux_clock =3D IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS) && tkd->timekee=
per.id !=3D TIMEKEEPER_CORE;
> +

Again, the is_core_timekeeper() check would be helpful here (or
alternatively is_aux_timekeeper())

Otherwise:
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

