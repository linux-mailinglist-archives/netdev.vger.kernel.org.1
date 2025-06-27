Return-Path: <netdev+bounces-201753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 727B2AEAE6A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00917A80AE
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 05:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7231C84C6;
	Fri, 27 Jun 2025 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnPGvrfS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7BE19EED3
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751001781; cv=none; b=kffCrT5Pc+A4TNa1sRy1DK/XNjtT7psSIbOHKPl0iWBjiMuDBUQz89MEc8xG+UlEj1W1y0nYpMP3glknm9NrOuzEPz04ylSenz35VGryQ90VECEwq/ZyAqrNeBKvXmiOD8VY16a5k19anHEe2/ERezb62SJA5vui6D4hUz9teLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751001781; c=relaxed/simple;
	bh=aUr8TZECzOn15DZq6wR7TF8mTexxly6x410wdhMAY7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gU3oiq0gCoG58gGArXBVZfUygEguh/TEwGGgX1eiECVibxmxBe7PInO4nS3e+95iX9XR/Z4szoqNsJkvEcRsaSUGwDw17cGDR2hUn3vpcCVlm1hSyLXsmtz7BqUL5iiOgCcsI7LZ/hkVGmKPiVtaPXefeSJUZAENFsO5BhGTRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnPGvrfS; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so3186736e87.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 22:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751001778; x=1751606578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMR9DDKVoZLB02tWU9/iY5aDzbALx9JilNraIO+BE6Q=;
        b=hnPGvrfSfQ3otJOzl5lJbph+h3siZaEjBDky4v2kxmqdRvI3pyd50WNFCp7k2DGEU6
         1EE2xtoOaE4kOT++FD7hhuzlrSkdPDorjt2GTnTjcv/BIWs5PD3gDs7NRYB3oHBvDsnB
         78BwRA9rwRESc4/fkuwiQxCY9HFHejbeg5F4NmhZuxZkCvWFjn5sgOZ5tAuXoAO9o2RH
         5NJTb3uhaaFRKt/VGCWv8Bu0E0LIXZ/UpwGCo8ddK9/2kNuaJ2gNoRCkKSUFaal3tOfT
         pfYD4nX120P2N1Y/o+CSyQfUPpTI6jaS5Se8upfh5MdX6ibxNf4Xo4AOYCpO04N8CcCk
         BSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751001778; x=1751606578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMR9DDKVoZLB02tWU9/iY5aDzbALx9JilNraIO+BE6Q=;
        b=Lj8Ap1qee1/eQTXEhM2rPY61bi8Y9aDVu8wzCF0XWrtdaP+gSpa747RKY9Zj4hU1Sf
         l2EwhH4HkurPAqBtPhIj4RzKNEGRZYL5vNDQu33qJoOGsLuOL5EkINI0oKpTVM27th8z
         pSg/eh+3WAFnvPx1qQgBfCn2dBlMtfvJjPVOQlwgaZEkoS0IasrN6fw4vrf04YI4JiW2
         QmEHiiOHTIvyVT8OWPL2BcAfjpApHB2Dgn8aCwTKuVIQkHmR3OUzPUALZiICmNfjDf5+
         o52DM6tANyvtwiRTD/C/4B18xNATwBhpWwjqwSePUkxWiUw7uVPGWmlFb5dTEqr4NFWQ
         ztqw==
X-Forwarded-Encrypted: i=1; AJvYcCVSo7IhCTG2wVHOQTS+zVa36SZXEkMnxITL94FYc2VtSidNrRzKBmGYrI9ZrFplEuB3w1wBPdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr0jj9kpwiV7RjjWiEtKeIKSUNhj1tX1UQdMbUVXHFjZWZfKB9
	yGhsGdssPTKB07Z2Sy0GRasZSc99zDaK43xpshDHfpri480mwohHZR0M8kgV/4MXQUMALGj5P5u
	j4W1jxOEZ6o7UVXpdbkUIpk1p4hFW9HpzeGGbC9I=
X-Gm-Gg: ASbGncsNXlV4yBpjdnuVR5hJZs2AXpO/UwFNnWLd+iojr85mYtYo2fyVgFHMr9SM2sC
	YKknh5Q8TY63tO6q+fdkCa5u/o1whGAmVaNKzbBYPPpZVs8CQarFjc+bS4o4AnNi6O1Zy6PwFCy
	xi0PaZt/wvLt5bCGkL8jU4t3tTjszkcqzWCrzLOy9e5x75Sc6cUlHJp2Z4JYKFq3TXNRtyYjww
X-Google-Smtp-Source: AGHT+IGBUmLHUHlyHy3bRmJvqlQWLFAu6V4YAO5HstEpvKInbDwkITqOvl/+ZrRmAUVfyeJuXU3HuKGr/IzzVao21Hk=
X-Received: by 2002:ac2:57c5:0:b0:553:cf72:45d3 with SMTP id
 2adb3069b0e04-5550c2bfeaemr338971e87.3.1751001777848; Thu, 26 Jun 2025
 22:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626124327.667087805@linutronix.de> <20250626131708.419101339@linutronix.de>
In-Reply-To: <20250626131708.419101339@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 22:22:46 -0700
X-Gm-Features: Ac12FXxEqKGa622Jk3Wd1qpsoRqhXK8q4rXtoQYbAaF1kiVczxTsdIaAUY9DiaU
Message-ID: <CANDhNCrxj9w+mcKOiGuOuLgJ26SairQTJ0Sqv8XteUtJRyWdwA@mail.gmail.com>
Subject: Re: [patch 1/3] timekeeping: Provide ktime_get_clock_ts64()
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

On Thu, Jun 26, 2025 at 6:27=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> PTP implements an inline switch case for taking timestamps from various
> POSIX clock IDs, which already consumes quite some text space. Expanding =
it
> for auxiliary clocks really becomes too big for inlining.
>
> Provide a out of line version.
>
> The function invalidates the timestamp in case the clock is invalid. The
> invalidation allows to implement a validation check without the need to
> propagate a return value through deep existing call chains.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/timekeeping.h |    1 +
>  kernel/time/timekeeping.c   |   34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -44,6 +44,7 @@ extern void ktime_get_ts64(struct timesp
>  extern void ktime_get_real_ts64(struct timespec64 *tv);
>  extern void ktime_get_coarse_ts64(struct timespec64 *ts);
>  extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
> +extern void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts);
>
>  /* Multigrain timestamp interfaces */
>  extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1636,6 +1636,40 @@ void ktime_get_raw_ts64(struct timespec6
>  EXPORT_SYMBOL(ktime_get_raw_ts64);
>
>  /**
> + * ktime_get_clock_ts64 - Returns time of a clock in a timespec
> + * @id:                POSIX clock ID of the clock to read
> + * @ts:                Pointer to the timespec64 to be set
> + *
> + * The timestamp is invalidated (@ts->sec is set to -1) if the
> + * clock @id is not available.
> + */
> +void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts)
> +{
> +       /* Invalidate time stamp */
> +       ts->tv_sec =3D -1;
> +       ts->tv_nsec =3D 0;
> +
> +       switch (id) {
> +       case CLOCK_REALTIME:
> +               ktime_get_real_ts64(ts);
> +               return;
> +       case CLOCK_MONOTONIC:
> +               ktime_get_ts64(ts);
> +               return;
> +       case CLOCK_MONOTONIC_RAW:
> +               ktime_get_raw_ts64(ts);
> +               return;
> +       case CLOCK_AUX ... CLOCK_AUX_LAST:
> +               if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
> +                       ktime_get_aux_ts64(id, ts);
> +               return;
> +       default:
> +               WARN_ON_ONCE(1);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(ktime_get_clock_ts64);

While I recognize this is mainly focused on the ptp use case, as the
interface looks generic from headers point of view, should we add the
other clockids for completeness?

Other than that,
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

