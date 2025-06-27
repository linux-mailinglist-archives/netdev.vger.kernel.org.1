Return-Path: <netdev+bounces-201743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC15AEADD0
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1893A5B89
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CDB1C5D5A;
	Fri, 27 Jun 2025 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GpTstop"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285D18DB35
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750998389; cv=none; b=rvVltZQovnO4cT46EBldavKhHZoB6jMdaU4YkAnOC7KG4sFmuBcwGo6rYO+vP+6s96T+K2wj53yO5jUtsnA+8x2ARaaB88/5M4MKo/U+08sZJ0ZQgJuPXOfMHbxxXbwTvba4yPR7DgGWAnEyAnQju8CWqus+YfwqNj+9pVeLJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750998389; c=relaxed/simple;
	bh=VfNg7i8DnarIz0vddVP/BSr8IV38z86RUZ7+o6IvmQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSglsDQkkUYZUyMtoNVJZuguhz0+7QPKy+INhyqWE+4GiEXIWdCUmQIV30ABWczV/Fw2Yf6eqJwvOYfYe1NAn/gTWHT/9vQl8tHd/cmjUsULv2UWEVbIKmzNVh7CO/tnDmOP5OkmBsgTrBhOfMrqEC9c8D+EGHCBFDCgnVeE6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GpTstop; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553b82f3767so1787647e87.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750998385; x=1751603185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfNg7i8DnarIz0vddVP/BSr8IV38z86RUZ7+o6IvmQ8=;
        b=2GpTstop6QMTk0pSOfbkzxb/r2vJXp4ElRxzbfx+SD2kLaZSnCA5kQzDjxBDttnHGs
         lJT5jIH12q8QHH0UvYrKZA1Kq1MF+2QLa3hpjBZGqzQQWspJmIadP5U53mXZdbOiBYLJ
         DbD2b7dOgZxbHMXDRfwWgiF3UgHgCbjWe5UR67/eusFGgPVuBD3hXWg6ZwvnHqu6i/YO
         ij/ojtlQ57wtxgHVMpbdRQUGq3P1N8Ggo1LJpKity7wL7AG3XrW67IcN4qTpePzeS9zx
         ZaVQjZPaAgPkcA6E2TEY+U1MWpnyBQifKTek1N+aCAt/4/MX4Uc14+pGFyIwdMgG6nyW
         mxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750998385; x=1751603185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfNg7i8DnarIz0vddVP/BSr8IV38z86RUZ7+o6IvmQ8=;
        b=rwoyh7nnryyiVOt8BJpwlcy6qIqCpJ9dchD6wAi3Wy1nOOpmVHTT50yYRSDp0BcaQd
         ScI2bRog09WSwL7Gd6aI2lSJwdd1nTIKSkcmetlwh+VNpRvoquWxIIOeJ3l8FpoO96+C
         dCLjzV1CybP9O4S3hh9/qtyj2i1lrb7163BgEP60Fw3UvuqNITgUh9lRW4f/CKvg6j8D
         jlsbGzz8wIAbBJ72Aokl/QM12wUmLUIea5lGGYsyJqZTEeOeWJ39vK96UW4OfmpUdXAH
         f/d8P5xDs8uiIFrwJ2MI3mauSEAjxPbKbSgIaLY5Lf/eZDjechQSSI/IF3h10HYnnpUc
         7sTg==
X-Forwarded-Encrypted: i=1; AJvYcCWabnUWdGuoeP/aRJTfEDgxEWsBPnr0CbDQJhxFPx+Fo3rJ6JrN5vUbsmz+b9gsSUzL6BkGqR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuLoPZEEeDc84R2HnPUJgct2LOevEGgeUefB2fcuYoUj3EVHbo
	VEZYqgFh4cM4j0ZiKEv6D0SXHx1bGVJAzlsufkMilkLGEKlWIYb117KnJ8CJ9rj01h9v1YDaXfD
	i7vSJvzZzWx8QrZZyrBuwRZvnoYFU8R76272I2bk=
X-Gm-Gg: ASbGncs/pyCT/kHlk4ITJ6CYshP2T+vgWku6EkzjL2rA9Lp5YFo7k+ZAWIC8jNgjKZg
	splhbxUY2qdsBN5uwJHiSPVA9L22/aEBZ/J2ZVsmM5H2N96lEiNVJUl3KfyWoJ70pBlqd4haaXM
	HvENz4TfIivwu85mU1+rP8NRyOXgGy6jtSM4cjb8fi1/BKpFJiYgkU0oYv+4S2kuODKYi47kVO
X-Google-Smtp-Source: AGHT+IEN0up3efKrhLZsd3nBpPiaMWt0HTAJctuZuXsO4lV9GjEKhsowTIRAiuY8Spw+0nSc6ymf2ZnARGVEAMJ3rL0=
X-Received: by 2002:a05:6512:3b9d:b0:553:a2c0:da70 with SMTP id
 2adb3069b0e04-5550b9e5d1bmr591838e87.26.1750998385370; Thu, 26 Jun 2025
 21:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182951.587377878@linutronix.de> <20250625183758.059934561@linutronix.de>
In-Reply-To: <20250625183758.059934561@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 21:26:13 -0700
X-Gm-Features: Ac12FXw5F6Tv9EinXUyVRVWX0w62FmgD8aJPlvktltqCpTRwogZjjuf3K6zok1o
Message-ID: <CANDhNCp+Zu4aAy4G__QZd40B2z0uiLJ=WSa_6h+bQkeRE3Ga-g@mail.gmail.com>
Subject: Re: [patch V3 05/11] timekeeping: Make timekeeping_inject_offset() reusable
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
> Split out the inner workings for auxiliary clock support and feed the cor=
e time
> keeper into it.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks ok to me.

Acked-by: John Stultz <jstultz@google.com>

