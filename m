Return-Path: <netdev+bounces-138891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518229AF4E8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1BF1C221FB
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE05200BA2;
	Thu, 24 Oct 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pC2CAK4V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D9189F3E
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729807149; cv=none; b=HVqSD59ZVb0+T250sxjxMmbxfJlJor5hCB3SXtBeS9PWAUC+iPK8223+kiuJl0bpiGERWrlYs/SunxzscfubWp4k/6cjzIWCUa6IsatQPbLgz5OV5u4n+tkoSdxlxAqsheqRzIdK/FJhMsIwf8E4hSmCcaKzEbH7tqjW3Oc6de4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729807149; c=relaxed/simple;
	bh=CQZuW0ZhZ+rfDcXxJLhOZ48DoK6DGU9gz/6dmcFGmrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEMEdR7jhN84vsSQ2IeU8qxyfR3YejzX5wKEkrrMLGzC4saV/wL4EE5InvrR1AXZaC8aMwsEjmHLODfu7OGg+qBg+wvGrrUJnwDKi9uanavVLlSRzFhb6P/HwO9GYYo1qpo5/dlXN2UJNCSXEDc7WQm5a7nwxf084kJhfJkocOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pC2CAK4V; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so1505724a12.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729807146; x=1730411946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CVld3u2L6MiVTEJjZxu0VtndismFneCtY/FK3k43WI=;
        b=pC2CAK4VURmbxQCBWwe/uSCKN8p74Cuo0rULzpvU6rUyyrOXC/T3cKYrO9CdbTbQBB
         nKhYGe2DoKaxsqRUwSwsMtPvrpYOTz6YiO6n/a9S86D7DyXs7wsRMBV5M1wcqIO8pv3G
         CR7vMqvq4YD30njlbhs0uYHazc6OtHLl2+M8MIlr7BUB6hv78JXWHL2CsJggxhmPjhBs
         2NboyznyaD8yhQg7YYc/5cmYKE72sJcqEzHN7qB8breTNP3wRxL7FdhaZuUlZKshuJS1
         yu2MjxIBUk+gvCVq2kht15mmG5dPQ6oZB1gqqJcTcGmRuX20LpJIC89jo/rD357sY1N6
         nj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729807146; x=1730411946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CVld3u2L6MiVTEJjZxu0VtndismFneCtY/FK3k43WI=;
        b=n4f4z6wg1rJHSD/q2CD/4UBdPGwl92UzbYGZph9jr8TxuijcewjWXuuHmUoY9Q4OKS
         5l/vVIsRr2DhmfnuRfDq7uxJAF2lfrHpStnp6aL4cpIzyP3+KpXHEzApERZBRwFnEnnt
         TNErZcL7kwUL/akTvDUsIiGtTAix97S2Wdk51SiYdzQwH0Qe7PGcPsaUAru3Pk9ZgRhR
         +oQXejB9fBKGiOC/yEoCo4OixcOZj5IJksw6HJgQhCwNslMTvfPjb2mYdndekt0uPCdT
         MAJCjv+mf1TnUFWdVgvE0euQ+Aa7QFZbaGtiW0awG0OIHxjny2pNIpC1SGv6dHBSDsqK
         JfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMo8f18VGjwnJ8gd+ThyFdUzr2fqWKJjyPt9n6eAvAg9cg/rj/K+yl8JAno1UXZMWpXc54QXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNpg2zCns12/sGpS/NHhdqCe04FwU0MraAYzdNQ+U//sLnoq58
	Vyenkz++3zehkI28LS+hBz80ktUJKZZdiheAnAroYYgf4kvE2ZUyst1uNi0x+WI04witolp7wJH
	naDUFtITW0eeroPCc6sva8ndluPLeShWp/l4=
X-Google-Smtp-Source: AGHT+IE3zE5/S1hYq+BPbzcUsp3bXFKju0UJrXh54KBGF+yu4rcoq/1dxO3EkXRwsV6L5Bm+tyufHi3KCcMhGFnb2dg=
X-Received: by 2002:a17:907:3e90:b0:a9a:634:dd2 with SMTP id
 a640c23a62f3a-a9ad281453bmr341527666b.43.1729807145608; Thu, 24 Oct 2024
 14:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-18-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-18-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:58:54 -0700
Message-ID: <CANDhNCrvQeEzDuY+K+fV73tNzOjacsu9JY3rjXqKfAgfG8rgyg@mail.gmail.com>
Subject: Re: [PATCH v2 18/25] timekeeping: Rework change_clocksource() to use shadow_timekeeper
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Updates of the timekeeper can be done by operating on the shadow timekeep=
er
> and afterwards copying the result into the real timekeeper. This has the
> advantage, that the sequence count write protected region is kept as smal=
l
> as possible.
>
> Convert change_clocksource() to use this scheme.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 051041e92e54..6d21e9bf5c35 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1596,9 +1596,7 @@ static void __timekeeping_set_tai_offset(struct tim=
ekeeper *tk, s32 tai_offset)
>   */
>  static int change_clocksource(void *data)
>  {
> -       struct timekeeper *tk =3D &tk_core.timekeeper;
>         struct clocksource *new =3D data, *old =3D NULL;
> -       unsigned long flags;
>
>         /*
>          * If the clocksource is in a module, get a module reference.
> @@ -1614,16 +1612,14 @@ static int change_clocksource(void *data)
>                 return 0;
>         }
>
> -       raw_spin_lock_irqsave(&tk_core.lock, flags);
> -       write_seqcount_begin(&tk_core.seq);
> -
> -       timekeeping_forward_now(tk);
> -       old =3D tk->tkr_mono.clock;
> -       tk_setup_internals(tk, new);
> -       timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
> +       scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
> +               struct timekeeper *tk =3D &tk_core.shadow_timekeeper;

Same nit: tk_shadow maybe?

Acked-by: John Stultz <jstultz@google.com>

