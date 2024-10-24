Return-Path: <netdev+bounces-138888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAAA9AF4D8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476E81F224D3
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0232178E1;
	Thu, 24 Oct 2024 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrwhWteU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4A18A6C0
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806896; cv=none; b=PR7/WgPnKC+R4lUZcIdHs1/r/32IalBIC7DdpduGA/+DHUoreTSzK1Vkn1cwfxXQShzw/rmdTDfvASPL/Ah2r8BjY57gh84IG8BdweNiVMOwwllhFWKQvVFSppOZ6Y2Bhrw2cQzFoqXuvteyWjWm55GmwNovIlwlhgxq5wudA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806896; c=relaxed/simple;
	bh=5UbODAlsq4Ad6QPz37YHAcHZB3oToSQdAEz+iE+GGS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVDJ+jWUFz71Dt38uE9XhLk9xkxNPT+hMjPcs6ilIWde0KpE4uSP6IasKAbnmmugw5FNiMMgnw9BEoDrgFdUt6Hl6CcgE2eRkz/CyqOfRBIv3j/3Tpak+C+BFtYZ+DsWrFDqqjzArnMZX82Nf3Ler9+oRz/r+pyNS/8KoeZba/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YrwhWteU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso155329466b.3
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729806892; x=1730411692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGWC+dNwv8ydzuQXg+CSwKCjsUbZv8vbUjXJY+36+fM=;
        b=YrwhWteUKJFNYNH4aXXdb9siSZIWrFZeUKT3qfY8S4Q/2RJFh75YC7OMgUWBcPFD9Q
         XlOHcwgHiQcEEy1ry86rKhxTUhCqPGQhfHfiZlfkZhlokR+4FbSt3APSTguD88i8oynP
         IfheqvtNqUSGWphnkZTsKCfR4CkqEwIQA0FQsxqD14Uc1BA2xPcTHaXrCuLV7ImikwI5
         pousUY9t/lCZa/PsihsGg4KYV7dDUXVZw+HHveZKR3v1gY2s3/VuWtOgz6aznA0AZbyQ
         BTihIaeNwsO/OnlC1tMqnsp72lY6J1abiuMsRQ8SMYYVsTjnohxnAKUfIBzG/YAX4srY
         eLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729806892; x=1730411692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGWC+dNwv8ydzuQXg+CSwKCjsUbZv8vbUjXJY+36+fM=;
        b=G7Rze86Rga+SR661Yit2sLhPcCBpu0fhjdChXl8Dl6U1u1qYgnNpHANGo310LNjTSP
         Aqpky5dAsxa9hQUFrewCYRoFfNqgeY9EReICwwzrx58lqKElDSKNstlW5jICLZNSs0Dx
         uEEZgKkiEyg18sqCWbEEJDnu9IozHUwnApNDo1UOFecDC9q60ZuSAZ7yzCY83xO+KgLb
         9Mwwl6pOqGDvtSO15P+FX0qrUJpeE9Zb0DNROKgzZ9eFbbKwOdqv8dHW2nEH+AICA3R/
         6nkS6HESKCheXS24LHYZb/x+WajLg/goNtTS9xxLltJwLhDhsydhuucMfyAnlg8TxibT
         +X/g==
X-Forwarded-Encrypted: i=1; AJvYcCUs9AKS+Dgg7Loi3/o+IcsoSeBVm9oIO2Xr3p7TDiIXgv5kI1ST8MJRl1xsiHQhQMOM1f1qPFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0lfRaJwJn2mMWmPBnsZgmYB76wACArHS7HBvgs+i9e0D9zxRI
	v1n7epSsozNMRjpD9n5gll4/2KNbOFyqKWddOxSmckJXLiN7DvnJbFHAE2y1mr/sBC/JsxBh8nx
	lJp0/hdx25uTdV5sheXK5eWO548RDxzPjWj4=
X-Google-Smtp-Source: AGHT+IHFBGg0dPX+vpqNJloNmtfsV6w2Lu0DOBBFKrBsz1+6gRhdEHWEmClxnB+eaAbPZTlD2vB40oOgH6MOlsqqQL4=
X-Received: by 2002:a17:907:7f24:b0:a9a:1094:55de with SMTP id
 a640c23a62f3a-a9ad27127d2mr330538566b.13.1729806891967; Thu, 24 Oct 2024
 14:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-16-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-16-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:54:40 -0700
Message-ID: <CANDhNCoN4Xug6XKSF+-cuXxRUiLhJPrBjiCmFmsTxxknvwN7nQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/25] timekeeping: Rework do_settimeofday64() to use shadow_timekeeper
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
> Convert do_settimeofday64() to use this scheme.
>
> That allows to use a scoped_guard() for locking the timekeeper lock as th=
e
> usage of the shadow timekeeper allows a rollback in the error case instea=
d
> of the full timekeeper update of the original code.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 42 ++++++++++++++++-------------------------=
-
>  1 file changed, 16 insertions(+), 26 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 41d88f645868..cc01ad53d96d 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1479,45 +1479,35 @@ EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_bas=
e);
>   */
>  int do_settimeofday64(const struct timespec64 *ts)
>  {
> -       struct timekeeper *tk =3D &tk_core.timekeeper;
>         struct timespec64 ts_delta, xt;
> -       unsigned long flags;
> -       int ret =3D 0;
>
>         if (!timespec64_valid_settod(ts))
>                 return -EINVAL;
>
> -       raw_spin_lock_irqsave(&tk_core.lock, flags);
> -       write_seqcount_begin(&tk_core.seq);
> -
> -       timekeeping_forward_now(tk);
> -
> -       xt =3D tk_xtime(tk);
> -       ts_delta =3D timespec64_sub(*ts, xt);
> +       scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
> +               struct timekeeper *tk =3D &tk_core.shadow_timekeeper;

nit: maybe shadow_tk instead, so it is additionally clear in the
following logic which is being modified.

Otherwise,
Acked-by: John Stultz <jstultz@google.com>

