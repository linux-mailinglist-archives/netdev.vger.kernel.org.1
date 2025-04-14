Return-Path: <netdev+bounces-182349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B0BA88870
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1796189905C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE55288C83;
	Mon, 14 Apr 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xh2wKKOI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95F284677
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647482; cv=none; b=VQXbecQTmHIpcOpQG0itATjWTWD+PL5Xm3Oqs+faBjw1jeIN7mfseX1AsGnsrWvPqe18R0RqUXSrH47zIwI1MGVpa/tCoQxrWHtXFq238yDsZpBGnKZNGAknoppxlw6ifmc0VA+0LwDB9myVjVD5f1Hfcre3J+XvOC5TDzYNluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647482; c=relaxed/simple;
	bh=6wis8Wgyzp4IZe/WwXpzV98FizK/UCCFtwSLNaJ3uoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnxz5DbQVs7eS8d+Sd9e39W1eHQMM5cnwvBe5HrEFcnUEZ5DjPDhMefjF2Ab8bTqHXyOdM2319tMw94OW8BIErtm/gvCRuXr6t+KA1hDIQwb9zfcU6xVlf1c5awjTgPrrLqnxwywfg19iubvZ7jpMjYrHad2TTS+Z8fCkexzYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xh2wKKOI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54b166fa41bso5422971e87.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744647479; x=1745252279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTf2mrFUD2jik0yS8vwFp9uJKMZhjGFsSRmmDNqFWZw=;
        b=xh2wKKOIG2BK34QRpmG6xPQ7koU+L/+kdF+dV5W5mPe4PBpBQ9vTvU786j528EC3CA
         YP/HuTQehWDfd9o8w0zjHby6rdlKT7WN6cJML9U3uQU63jWdytg61pK/CHdpl58aGvrS
         lF9m6sR2KbOLe+/4G3PfpwKPHHfAJBKfxdKslInVbTMu7s9GUyxORloM0tXoKjA8zoro
         BCkJ07NdsMzVc/8xzq6ZRPg4kM+VSANsICByVvQ/3zgK6Tkk6hqCvBpAlY/VFOiWOep3
         uw0XqPcT21X6gPaLSLtM2IgbZxI7v1/w3e/nY6Jr3CSn7uRXYRq8FjuKpAmxQJtY2y9h
         +Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647479; x=1745252279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTf2mrFUD2jik0yS8vwFp9uJKMZhjGFsSRmmDNqFWZw=;
        b=edmvEJVOHGLlrQHtBqXVSdQLcockep/krV1nEqKMpx4CML/O2miW5vR1fZpfI3FMxd
         crRm/3G5J2+nzRCvdh9vwUTIm9SF7SvSzFQr41jSjWat+BsKLCtVdEHCyDsDdj2PR+5O
         xW0VjRcdNOu4jRwK4JBX1BfC4PmCKI7COFLQW2Y4mH9KG0jYhmL9vq7joRCnu52M5vbj
         Ss148+peZ0dyv2O3S/nHqYRMbHMQ8+zd6JYYFZhg/sMnY4ZPSvnIambZyTasDTyEcwfB
         FLRxaxfHgZFaF6QcC8StiPxEx4o/KPmfP/LWYQbs13zEiylJuA3LnBign2ywtqPz68Bh
         kS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8SxobjJuOhbjnAejoNAdB70U+9tU1+UZGPDSted/vxF5FQAK8qUPVBSLqFPsQhPyXcDEdPD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxB5L62Dtq6rSbXGHcrJWCi0G4c3qcggVWvbOb1uX2toEj4IK4
	3uzgC1EO7CEiUuyBZc6pDw3qb+zzcf0TeOAxetBmZ8imOzNXofN4nyQMsAG+LBGjdSG6hY444BO
	Ih0mI4Pfb7xUdfbNsZixXaGNlOLL6W0oHe1M=
X-Gm-Gg: ASbGncvupa8ch6HhlU3tKoKkQgvHHNeA+9T68obe4ptnq18lXUs8/uDKvxeNGTzgSD3
	ofHGGjitz7MZI5WAU9vLmpHuavsYAWI+pykEdH2Hl5JDn85mKBm3pXnGU8G0wBOfo40evcuvMYv
	FpF01MpPnWwLj/rBp1xr2ThJgWg/zLx9h46Ob88xOcSDK6ySIaau6vwqem67oe1w==
X-Google-Smtp-Source: AGHT+IEEJxH5Gw/VYXYZjvTUymJBjR3SCI7KnWmqVgjCywuTuPnFXsALmpLzpiyXHKdY3sWQZCk2jMydzsd9wD+VzK4=
X-Received: by 2002:a05:6512:2341:b0:549:43f8:824 with SMTP id
 2adb3069b0e04-54d4529e92amr2615930e87.26.1744647478694; Mon, 14 Apr 2025
 09:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250406013445.124688-1-fujita.tomonori@gmail.com> <20250406013445.124688-6-fujita.tomonori@gmail.com>
In-Reply-To: <20250406013445.124688-6-fujita.tomonori@gmail.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 14 Apr 2025 09:17:45 -0700
X-Gm-Features: ATxdqUHa_B4vLGWeqAXElK4MBxPg7kybL6ZAOzLmRudCKwhJmX-6Ncn6LtVt6Gw
Message-ID: <CANDhNCoLfQUZ8akUT1PW=GJ=O67b=_M6TT-c7KzGH1qbdJxaGA@mail.gmail.com>
Subject: Re: [PATCH v12 5/5] MAINTAINERS: rust: Add a new section for all of
 the time stuff
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, sboyd@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev, 
	david.laight.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 6:35=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add a new section for all of the time stuff to MAINTAINERS file, with
> the existing hrtimer entry fold.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  MAINTAINERS | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d32ce85c5c66..fafb79c42ac3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10581,20 +10581,23 @@ F:    kernel/time/timer_list.c
>  F:     kernel/time/timer_migration.*
>  F:     tools/testing/selftests/timers/
>
> -HIGH-RESOLUTION TIMERS [RUST]
> +DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
>  M:     Andreas Hindborg <a.hindborg@kernel.org>
>  R:     Boqun Feng <boqun.feng@gmail.com>
> +R:     FUJITA Tomonori <fujita.tomonori@gmail.com>
>  R:     Frederic Weisbecker <frederic@kernel.org>
>  R:     Lyude Paul <lyude@redhat.com>
>  R:     Thomas Gleixner <tglx@linutronix.de>
>  R:     Anna-Maria Behnsen <anna-maria@linutronix.de>
> +R:     John Stultz <jstultz@google.com>

I've got some learning to do, so I may not chime in much, but I'm
happy to be helpful, if I can...
Acked-by: John Stultz <jstultz@google.com>

