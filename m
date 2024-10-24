Return-Path: <netdev+bounces-138894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEB69AF52D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 00:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1B61C20D77
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E022178F4;
	Thu, 24 Oct 2024 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZ11TKYu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8831C4A32
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808224; cv=none; b=ero3jyeYN1lAkyyu4pjxW1t31a3QrGgTBLScVjFAMkGt06n3OIRs5GObOifoUXVJoQ05BH1b7or5DdxTvn+Hf2yy39EMWsKhTpyCcOc/xigsHv+3oSokhy/ojh+8jRRvi6fV/ZDdOExSYyPHQhOJOWif78P66+P27odESaF6oY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808224; c=relaxed/simple;
	bh=+fdXlpqMk9lXjHG5hck/VmhWVDUIl/UM2AAo6ilLGQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gq3S7hQtUNAc8yqqNBa98/Qf6A5EeIRKLBo+A3Eua4vftKaKEtoGfRVi33gZVbw9rkKfOlPOJj8LG8FV12f5H9YOml0X7Dz7KcEbCLMcxgvDQ+CDLn0zzo9aG8GuRV6oGo8BPNl/0fs4/7jqS/dh8UwI8xU4MZEWc1LAGtw8gR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZ11TKYu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86e9db75b9so192880366b.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729808220; x=1730413020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m82t+bGKWCHxJyqrbTnu2tP/AjOfVbnQoKLg9+UraA0=;
        b=pZ11TKYu5ffJzTQTOcqD/fjuaOzglfSiZkAlFepr3Hulv+Um55S/HpdGWh/2twSXiE
         ilGolCO7nLoR02/6J4oQdI7IKcDkhcTR4DUSu9RFX+rs2hKN/CAYMrIa7rEJkNQjSMuV
         4Gg0Cyb9WonToeombNMSnFqG4yAwLq+W53MZbvPhXxmttSJ10r0jiDb3mpLv6+TnFhbw
         TlIduHh7EHzmTDUD7J3E00mO5LKy7SLdntfoLfGJBJJUHB6EO1Dcqd0q1lSQS4Fx2so1
         CnlKkVGhN0Gau14cJ5Xg/5zAhEaBbLdWdmXFnHBmpwd68nO/Gk96YWhWGzTNngydLKGt
         kWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808220; x=1730413020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m82t+bGKWCHxJyqrbTnu2tP/AjOfVbnQoKLg9+UraA0=;
        b=MgUJbubQvsNuYTFbs/3ydIcICLj8SqYSJMOcB0aqqZsV/JN1kXt9xjispUcuPDZUHc
         qeEfHhB9dLFgViZr0ulZly0wuQ9/siGcGgHewlhFtyvEVUlhVzq+8S92TpWZxf8lrb66
         OEboMg83EjCNAvvJCPXU2JTlMqutJalWijx0KfB5Nrcwj/o7N//e+QHaipJmGheNG3Pa
         YGY+x6h8pQ9t/QryVH+En+9YIwTI/bqgAsPFDUlUo/RnX65HZpBoWjWDu9CxSeFxUYi+
         3jpbddwpKpNnre1fOQFikTxvgxD8ueTloYLHpx8Hbj1wDo+0uxCxKPSQfgO1G3zBZO+5
         LVUA==
X-Forwarded-Encrypted: i=1; AJvYcCUNrkqFyNVp9m+vaSAt2nQi359aoRKCgVDtMPhinomCcx/QliOqsX2y36fncJrKfda0kzTPsYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztEI9NLMwT47XjdW5AVpGfLP34v/jXVkXTNBGSe0s6t1tdaBzm
	K7szmi95zi7wRJcJz4j5+LnQNjZCSdVlMOgRxhmLKyq1ZETvj1pYFLmJtYay6qJCb4wRBLv5sGF
	tDiPZrEkmJE/AxdlmWjhUlnC7eZUxbvIWzFQ=
X-Google-Smtp-Source: AGHT+IHvsd54q7H0Cux+j3inwm2+NVV934SOq1cxzzfsRzcUF0E/WQOyKHMMfrlhg4lPG5P7AftdSMSAQYm9bOQRohA=
X-Received: by 2002:a17:907:9453:b0:a9a:8ee:594f with SMTP id
 a640c23a62f3a-a9abf86eaeemr782033966b.21.1729808219583; Thu, 24 Oct 2024
 15:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-20-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-20-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:16:48 -0700
Message-ID: <CANDhNCr8rWc=1LMoW-fujpXVP2xbNH9HZ+7tbVU+tUSCYAUeow@mail.gmail.com>
Subject: Re: [PATCH v2 20/25] timekeeping: Rework timekeeping_inject_sleeptime64()
 to use shadow_timekeeper
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
> Convert timekeeping_inject_sleeptime64() to use this scheme.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index bb225534fee1..c1a2726a0d41 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1893,22 +1893,14 @@ bool timekeeping_rtc_skipsuspend(void)
>   */
>  void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
>  {
> -       struct timekeeper *tk =3D &tk_core.timekeeper;
> -       unsigned long flags;
> -
> -       raw_spin_lock_irqsave(&tk_core.lock, flags);
> -       write_seqcount_begin(&tk_core.seq);
> -
> -       suspend_timing_needed =3D false;
> -
> -       timekeeping_forward_now(tk);
> -
> -       __timekeeping_inject_sleeptime(tk, delta);
> -
> -       timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
> +       scoped_guard(raw_spinlock_irqsave, &tk_core.lock) {
> +               struct timekeeper *tk =3D &tk_core.shadow_timekeeper;

Same nit as the rest, otherwise
Acked-by: John Stultz <jstultz@google.com>

