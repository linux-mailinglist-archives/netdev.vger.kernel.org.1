Return-Path: <netdev+bounces-80705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6394288074C
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 23:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE5C283E92
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02D45FB89;
	Tue, 19 Mar 2024 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofVfAAXS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046AE3C6AC
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887408; cv=none; b=pUKWjgH5Q3f/UoPfPQuUYKZG6chYXSI9Y824L601KBIZ0gAj32TvslSGC50YzK1Z7ugCifQe8i99fw1/mBiVYU68TDMWSHBuN28DkOkp4fVAJzfMZR6xKZk7TekEckZstgFGRDUBdIMmaxn9eO8EU9g2KhR7spSSeqVuY2j4pF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887408; c=relaxed/simple;
	bh=wtbRGprG246JSinZ1zeJ0g2NwwsbkPDYzZmmC7vbRTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YI6uy8QNFOR9IdF8CsP6G96OGCBiGg8zv8RaGzx/XGO84YFN6pp/3RChi9pETY6yRDfBkw95xgwUgR173HdK//vV6Anx03t8vfZv78CeIx0OKG6zMIssb7uOh7f/R6TcnJXpBFdfB6xrZOpMx4UJg1dW0yADFlpd8SlcgvUSpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofVfAAXS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41467b42b98so14325e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710887404; x=1711492204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8EtD8zegIhUQWzA/oDS70j+Z9o9c4kykZ4EUai9up0=;
        b=ofVfAAXSVDz8umrvv14pK2V/4/3P3kzsOjuxfKAom8Ki59bDmUAF1ZZeWjIBSUQbKQ
         OfXIJR+vPGDajLBH9qCmNiEbA/7RtRlba9C8M12whYQ7Q67DVEqA9GaoZs0lhuWOpVsn
         inK1zngi7gQ3VUaCl+YdO3Br3OP9NWCD/Hr3L3Y7i6AeaQYmq5ZHTl/gBOsxC5D8xsrA
         UjLIBbcUUEjz+IYZaereQMCv89gJ6b4wMcPFly4nwrKNvTVIH/+kesT7ruQbm4BCG0ON
         Ho93su6n6Xp9Bt+rc1w4GoRvH5It59jwEoy0Cxl4snlxWSL2R+YpWUfjti9Mx8VlOOe1
         WgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710887404; x=1711492204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8EtD8zegIhUQWzA/oDS70j+Z9o9c4kykZ4EUai9up0=;
        b=i6PlIN/vekrPe6ZkvdgnPovTloesuRTQvhOjhFTNgSzW74PQLmrELCWSxmU+q7SSdA
         bG2lS4I56hoCjzKjUz+UrzimX9rMc6+jMl1614EqpB3+fXqthGolnOzhFj3lsNk5EJI1
         Po6MyC1EHuDFwNTK9lBMlWfe8QqtISaExaYF229zWxjCb5G28cTz0b9tkXvf6t61S0DW
         by2wyxLl54BHseP7704GUMZXJDdwmhyTjGnN0Y07yKN5Snz0NSzp/4F2HQq7LgThdz85
         2xG6m3KbYLtdLLE42lbC361sPKJlJez1gb+78EHQi2SJLhWK45UrwpffmP9gPJ9Wl+rh
         keMw==
X-Forwarded-Encrypted: i=1; AJvYcCWaoAzS1ImeilpJH3eh0p/+WHvNGHGLt1dxSxS/YM4LBHgGOtGSTA9/Wgz+LOBgEhuGyi1j6mNJAPrjcEvQmZOHGpkHnOAs
X-Gm-Message-State: AOJu0YxEtCmIIIsBM0C7sBvGk1QJwQ49ZfpjCbh2u047VE7ES6iEuAjo
	N+rpoLduT1iAIycL5Ea+AX2Xt7rPlxmhw6UxGbROJohnSJTYHlr/vdXpxuaQkF51x4H9WHcdVRb
	QiPBHnMFwCH8zxEE4WhtzA7L07MfJdSIO8bU=
X-Google-Smtp-Source: AGHT+IFnGQzm4jMjcrzDlbzN56akGGgkj3uAyRKTIsnW0UhcIBF+MbiMv0KxT6M+rBMt9Ny+pOt1FU4BU9vpN+72B78=
X-Received: by 2002:a05:600c:3051:b0:414:1ee:f399 with SMTP id
 n17-20020a05600c305100b0041401eef399mr89401wmh.2.1710887404353; Tue, 19 Mar
 2024 15:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com> <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 19 Mar 2024 15:29:51 -0700
Message-ID: <CANDhNCpP6Nd_iYtdgW+RyH1g7c-eyHR+j-LV4gv8rKWu9QkzhQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] timekeeping: Add function to convert realtime to
 base clock
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, giometti@enneenne.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, x86@kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	andriy.shevchenko@linux.intel.com, eddie.dong@intel.com, 
	christopher.s.hall@intel.com, jesse.brandeburg@intel.com, davem@davemloft.net, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, mcoquelin.stm32@gmail.com, 
	perex@perex.cz, linux-sound@vger.kernel.org, anthony.l.nguyen@intel.com, 
	peter.hilber@opensynergy.com, pandith.n@intel.com, 
	mallikarjunappa.sangannavar@intel.com, subramanian.mohan@intel.com, 
	basavaraj.goudar@intel.com, thejesh.reddy.t.r@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 6:06=E2=80=AFAM <lakshmi.sowjanya.d@intel.com> wrot=
e:
>
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> PPS(Pulse Per Second) generates signals in realtime, but Timed IO
> hardware understands time in base clock reference. Add an interface,
> ktime_real_to_base_clock() to convert realtime to base clock.
>
> Convert the base clock to the system clock using convert_base_to_cs() in
> get_device_system_crosststamp().
>
> Add the helper function timekeeping_clocksource_has_base(), to check
> whether the current clocksource has the same base clock. This will be
> used by Timed IO device to check if the base clock is X86_ART(Always
> Running Timer).
>
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
> Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> ---
>  include/linux/timekeeping.h |   6 +++
>  kernel/time/timekeeping.c   | 105 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 109 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index 7e50cbd97f86..1b2a4a37bf93 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -275,12 +275,18 @@ struct system_device_crosststamp {
>   *             timekeeping code to verify comparability of two cycle val=
ues.
>   *             The default ID, CSID_GENERIC, does not identify a specifi=
c
>   *             clocksource.
> + * @nsecs:     @cycles is in nanoseconds.
>   */
>  struct system_counterval_t {
>         u64                     cycles;
>         enum clocksource_ids    cs_id;
> +       bool                    nsecs;

Apologies, this is a bit of an annoying bikeshed request, but maybe
use_nsecs here?
There are plenty of places where nsecs fields hold actual nanoseconds,
so what you have might be easy to misread in the future.

Also, at least in this series, I'm not sure I see where this nsecs
value gets set? Maybe something to split out and add in a separate
patch, where its use is more clear?

> +bool timekeeping_clocksource_has_base(enum clocksource_ids id)
> +{
> +       unsigned int seq;
> +       bool ret;
> +
> +       do {
> +               seq =3D read_seqcount_begin(&tk_core.seq);
> +               ret =3D tk_core.timekeeper.tkr_mono.clock->base ?
> +               tk_core.timekeeper.tkr_mono.clock->base->id =3D=3D id : f=
alse;

Again, bikeshed nit: I know folks like ternaries for conciseness, but
once you've crossed a single line, I'd often prefer to read an if
statement.

thanks
-john

