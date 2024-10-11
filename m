Return-Path: <netdev+bounces-134459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C80999B25
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 05:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9819428393A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 03:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6101F131B;
	Fri, 11 Oct 2024 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1vWD3w2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98011C6F45
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616966; cv=none; b=qLzkKDVttOCzivaFeMnulAtgE2Xv2PtXjm/mE/WKTq5FLv2lWkw7jknuORiTVpjgGzXCVzOkBJBWEjzdn4XMQ/2+E5fliJ+lkPqOZ9fVNRypkG6D5VjfyB3nfJX5GSeZGB7G78hGms2fug/PfvyE62t2i1drB4msQsktcYku8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616966; c=relaxed/simple;
	bh=qZqs+Ajew32BPQ6rtfu5JxBsNR4I8QR+Zf9fCStEjRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaLsDvHTVwaw+hPmCk66Mad4MU+9WRV4rNQaiibVSb8+npSsjOYAXXCE1Ce2GPgU3EXYhxcg+gcOIyA0Z1wXaEBOgYEOKK3RLwo8HVOGlNmMkrQzPi9LBjiPBh9P82cif6R5+95b4iR0iS85WGqB8xRbhu9jubvQbfcDPer8wNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1vWD3w2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so24429281fa.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728616963; x=1729221763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkN/0WHHrpqhDdE0d9w2GWLwNq6MmZY9B1ghXefh6y0=;
        b=f1vWD3w2kolcmwzj9rvD7/UpVi7c4CmaNyk5Fl6GF46U6h1xVO7xJ1G55reSlupJLG
         unYPzG6+Kkb/jODRGN6L2WergtqQhPZs3qPke405zlygtcSgOctm8KyjSqetbvnM9Bzq
         r7j6ngrkHJYB+MMJUEczAxl5vVURx1dzet6iSAZzQNgLfnWSz8BO1JskCvEYocAX41RQ
         T9lqCru3qOx/3/jheQXBM1m7TcYAYkSNgCi8riV8iFWC4njimIIhLRSiSVRtz5e/xpcw
         5fVXc0AuUrDU069i1jaOMz3Wz7tSl83LEdUSfcBWlqaeowa/pDnqugBOtQs2zsME56rf
         AEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728616963; x=1729221763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkN/0WHHrpqhDdE0d9w2GWLwNq6MmZY9B1ghXefh6y0=;
        b=f2qvrCgMHHDM+0JtAx4pd4rbqq+cVBbMXnNQTqamfpA2X/ydqG61xe0e8HOZbIhwZ9
         2PH6gLySCDDneB59A2PVBzY4RPsMS/zuCjSQZlVHckPqu43bonS/I5mSRWWk6rejiHLW
         zt6+nVn5blFFkMhhjvbnzkHbn3i3TGKF9LcWlRYZBQcS4tT747hTBxYQCiTFeXsyZcGE
         oSf3Qa4b8WIjYD/jg+TFbQl4BIPE3hLO0Gu5KRzGGr+h/JRPymkMYuJQTZrYdcf0UHlM
         qewv7IUtTsyM82G7hoQoLQD7ki9A9y+txmAdfD0GH1Wh/aHHEMRDlVqoHS1UIX0wWb/h
         Kltg==
X-Forwarded-Encrypted: i=1; AJvYcCVDMsX/fUox/XxKo6KZQQxX4EXSDLVv/5ZIlql6Hp+lYCeMjOLoqPMbcTHa6I0CnFkEnXMCorA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5kLFN63tvrtXWsc096C9Be1pOvOzblTe9KstZvJBUeXJU6YD
	My0HJvVZkowz68LpI2nDEDrLgJJQ/b+zJoXjwoeqUwkzjj65xFheWfmVdx0UPURO4to/sBquDAe
	qRwiGzqJjGwHzx2/eBdIvEKHJ+AhTMOs3GAc=
X-Google-Smtp-Source: AGHT+IH7xLk5y341mTNBxpKsVU1/TDbcQAXb2bsjLqCiSOkW9SakKrOII/RFjBinwZLpZ9ln5kT4y0D+MTzEsFUKSWg=
X-Received: by 2002:a2e:a271:0:b0:2fb:cc0:2a04 with SMTP id
 38308e7fff4ca-2fb32777d90mr4105841fa.25.1728616962799; Thu, 10 Oct 2024
 20:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-6-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-6-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 10 Oct 2024 20:22:30 -0700
Message-ID: <CANDhNCpPhS5nebGH_bA3G06Dmt6eFXAw9GyBEYmNZe2Z1WhS_Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/25] timekeeping: Reorder struct timekeeper
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
> From: Thomas Gleixner <tglx@linutronix.de>
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> struct timekeeper is ordered suboptimal vs. cachelines. The layout,
> including the preceding seqcount (see struct tk_core in timekeeper.c) is:
>
>  cacheline 0:   seqcount, tkr_mono
>  cacheline 1:   tkr_raw, xtime_sec
>  cacheline 2:   ktime_sec ... tai_offset, internal variables
>  cacheline 3:   next_leap_ktime, raw_sec, internal variables
>  cacheline 4:   internal variables
>
> So any access to via ktime_get*() except for access to CLOCK_MONOTONIC_RA=
W
> will use either cachelines 0 + 1 or cachelines 0 + 2. Access to
> CLOCK_MONOTONIC_RAW uses cachelines 0 + 1 + 3.
>
> Reorder the members so that the result is more efficient:
>
>  cacheline 0:   seqcount, tkr_mono
>  cacheline 1:   xtime_sec, ktime_sec ... tai_offset
>  cacheline 2:   tkr_raw, raw_sec
>  cacheline 3:   internal variables
>  cacheline 4:   internal variables
>
> That means ktime_get*() will access cacheline 0 + 1 and CLOCK_MONOTONIC_R=
AW
> access will use cachelines 0 + 2.
>
> Update kernel-doc and fix formatting issues while at it. Also fix a typo
> in struct tk_read_base kernel-doc.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

> ---
>  include/linux/timekeeper_internal.h | 102 +++++++++++++++++++++---------=
------
>  1 file changed, 61 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeep=
er_internal.h
> index 902c20ef495a..430e40549136 100644
> --- a/include/linux/timekeeper_internal.h
> +++ b/include/linux/timekeeper_internal.h
> @@ -26,7 +26,7 @@
>   * occupies a single 64byte cache line.
>   *
>   * The struct is separate from struct timekeeper as it is also used
> - * for a fast NMI safe accessors.
> + * for the fast NMI safe accessors.
>   *
>   * @base_real is for the fast NMI safe accessor to allow reading clock
>   * realtime from any context.
> @@ -44,33 +44,41 @@ struct tk_read_base {
>
>  /**
>   * struct timekeeper - Structure holding internal timekeeping values.
> - * @tkr_mono:          The readout base structure for CLOCK_MONOTONIC
> - * @tkr_raw:           The readout base structure for CLOCK_MONOTONIC_RA=
W
> - * @xtime_sec:         Current CLOCK_REALTIME time in seconds
> - * @ktime_sec:         Current CLOCK_MONOTONIC time in seconds
> - * @wall_to_monotonic: CLOCK_REALTIME to CLOCK_MONOTONIC offset
> - * @offs_real:         Offset clock monotonic -> clock realtime
> - * @offs_boot:         Offset clock monotonic -> clock boottime
> - * @offs_tai:          Offset clock monotonic -> clock tai
> - * @tai_offset:                The current UTC to TAI offset in seconds
> - * @clock_was_set_seq: The sequence number of clock was set events
> - * @cs_was_changed_seq:        The sequence number of clocksource change=
 events
> - * @next_leap_ktime:   CLOCK_MONOTONIC time value of a pending leap-seco=
nd
> - * @raw_sec:           CLOCK_MONOTONIC_RAW  time in seconds
> - * @monotonic_to_boot: CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
> - * @cycle_interval:    Number of clock cycles in one NTP interval
> - * @xtime_interval:    Number of clock shifted nano seconds in one NTP
> - *                     interval.
> - * @xtime_remainder:   Shifted nano seconds left over when rounding
> - *                     @cycle_interval
> - * @raw_interval:      Shifted raw nano seconds accumulated per NTP inte=
rval.
> - * @ntp_error:         Difference between accumulated time and NTP time =
in ntp
> - *                     shifted nano seconds.
> - * @ntp_error_shift:   Shift conversion between clock shifted nano secon=
ds and
> - *                     ntp shifted nano seconds.
> - * @last_warning:      Warning ratelimiter (DEBUG_TIMEKEEPING)
> - * @underflow_seen:    Underflow warning flag (DEBUG_TIMEKEEPING)
> - * @overflow_seen:     Overflow warning flag (DEBUG_TIMEKEEPING)
> + * @tkr_mono:                  The readout base structure for CLOCK_MONO=
TONIC
> + * @xtime_sec:                 Current CLOCK_REALTIME time in seconds
> + * @ktime_sec:                 Current CLOCK_MONOTONIC time in seconds
> + * @wall_to_monotonic:         CLOCK_REALTIME to CLOCK_MONOTONIC offset
> + * @offs_real:                 Offset clock monotonic -> clock realtime
> + * @offs_boot:                 Offset clock monotonic -> clock boottime
> + * @offs_tai:                  Offset clock monotonic -> clock tai
> + * @tai_offset:                        The current UTC to TAI offset in =
seconds
> + * @tkr_raw:                   The readout base structure for CLOCK_MONO=
TONIC_RAW
> + * @raw_sec:                   CLOCK_MONOTONIC_RAW  time in seconds
> + * @clock_was_set_seq:         The sequence number of clock was set even=
ts
> + * @cs_was_changed_seq:                The sequence number of clocksourc=
e change events
> + * @monotonic_to_boot:         CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
> + * @cycle_interval:            Number of clock cycles in one NTP interva=
l
> + * @xtime_interval:            Number of clock shifted nano seconds in o=
ne NTP
> + *                             interval.
> + * @xtime_remainder:           Shifted nano seconds left over when round=
ing
> + *                             @cycle_interval
> + * @raw_interval:              Shifted raw nano seconds accumulated per =
NTP interval.
> + * @next_leap_ktime:           CLOCK_MONOTONIC time value of a pending l=
eap-second
> + * @ntp_tick:                  The ntp_tick_length() value currently bei=
ng
> + *                             used. This cached copy ensures we consist=
ently
> + *                             apply the tick length for an entire tick,=
 as
> + *                             ntp_tick_length may change mid-tick, and =
we don't
> + *                             want to apply that new value to the tick =
in
> + *                             progress.
> + * @ntp_error:                 Difference between accumulated time and N=
TP time in ntp
> + *                             shifted nano seconds.
> + * @ntp_error_shift:           Shift conversion between clock shifted na=
no seconds and
> + *                             ntp shifted nano seconds.
> + * @ntp_err_mult:              Multiplication factor for scaled math con=
version
> + * @skip_second_overflow:      Flag used to avoid updating NTP twice wit=
h same second
> + * @last_warning:              Warning ratelimiter (DEBUG_TIMEKEEPING)
> + * @underflow_seen:            Underflow warning flag (DEBUG_TIMEKEEPING=
)
> + * @overflow_seen:             Overflow warning flag (DEBUG_TIMEKEEPING)
>   *
>   * Note: For timespec(64) based interfaces wall_to_monotonic is what
>   * we need to add to xtime (or xtime corrected for sub jiffy times)
> @@ -88,10 +96,25 @@ struct tk_read_base {
>   *
>   * @monotonic_to_boottime is a timespec64 representation of @offs_boot t=
o
>   * accelerate the VDSO update for CLOCK_BOOTTIME.
> + *
> + * The cacheline ordering of the structure is optimized for in kernel us=
age
> + * of the ktime_get() and ktime_get_ts64() family of time accessors. Str=
uct
> + * timekeeper is prepended in the core timekeeeping code with a sequence
> + * count, which results in the following cacheline layout:
> + *
> + * 0:  seqcount, tkr_mono
> + * 1:  xtime_sec ... tai_offset
> + * 2:  tkr_raw, raw_sec
> + * 3,4: Internal variables
> + *
> + * Cacheline 0,1 contain the data which is used for accessing
> + * CLOCK_MONOTONIC/REALTIME/BOOTTIME/TAI, while cacheline 2 contains the
> + * data for accessing CLOCK_MONOTONIC_RAW.  Cacheline 3,4 are internal
> + * variables which are only accessed during timekeeper updates once per
> + * tick.

Would it make sense to add divider comments or something in the struct
to make this more visible? I fret in the context of a patch, a + line
adding a new structure element that breaks the ordered alignment might
not be obvious.

thanks
-john

