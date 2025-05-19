Return-Path: <netdev+bounces-191407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2F7ABB746
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5D23B42E4
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73504269D15;
	Mon, 19 May 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5LwOrtE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ZmZEzJX"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C824469C;
	Mon, 19 May 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643599; cv=none; b=jYhbmDLK6YzkcGEH3g4JghAis6/TI4J1pwDtwVWv/7G6v/V3HUi5qgUMefE33TUJBBBdxhz82NGCLgyt+ZXU7SPPsu9zYEYlKri97fbpTBFNJQ9939bNdGH5/bsdiVJuwwT53loiiahZavvhKJjsFX2B1teobvW8brtKx32ZZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643599; c=relaxed/simple;
	bh=LPkGYirmxlcgEMUb15oRjZPUqQf+NoyNtB77yQ6nDEY=;
	h=Message-ID:From:To:Cc:Subject:Date; b=HL/Vupy2LuGv4rPk6bhchKAzwgRiB1HK3GtANYVi4rt3w138LMl0+0/HQTW899yQTkZFGRrIn6C0KaTM7jqWg+NUX2PiwKxOck0IumY966F+hB/d145HGwlqSpVr4QIpYC09tUqz1nUQr1D+gIVQpbLqvwHYRGSt+8Pw3SJJhiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5LwOrtE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ZmZEzJX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519082042.742926976@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=wJnbJUJbRo+M8Mfb2KSXnAv7QkIxC52cS3IWp5g1yus=;
	b=S5LwOrtE4KpTCGKxldJXdU7BNryhKw7v/cTDU30hms4h9XFd9kuKEL6y/dzfElaA6Uo3Ny
	+EOk5/F/zodUW5btFMXjh+PHM2SvvpxHwd6FBPgKqX+b7/44Vu1+Kq8mMyp6NlHrjEccA9
	tnLK4PpOFshS40Xv8811jN8srd0daSWQYAajNm6D9TSJzHHaR+mz35GaIA5YTlDfpMCtSs
	JR5DeB1WHqYHG/ClLc5GbO+uzprmnZ2w8basAE99a8FLDG0nPtzamjiuqxrAIJPOjrNtzm
	Wo4pVnBn+7dHCdBfXhUeXZ7fTfd+PjGbMLVHTrrfE+hLtyBsuU9IWxLAd/58BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=wJnbJUJbRo+M8Mfb2KSXnAv7QkIxC52cS3IWp5g1yus=;
	b=8ZmZEzJXB9InDThzQqMqdmT6JRR/2roaze5meQ4aez2GYeUb4EeTQlZGzfBhIhSxMganJq
	L5S3ZuX4D7rQSoBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>
Subject: [patch V2 00/26] timekeeping: Provide support for auxiliary
 timekeepers
Date: Mon, 19 May 2025 10:33:14 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This is an update to the initial series, which can be found here:

     https://lore.kernel.org/all/20250513144615.252881431@linutronix.de

The kernel supports PTP clocks pretty well at the hardware level and the
ability to steer the core time keeper, but there is a major gap for other
PTP use cases especially in the context of TSN.

TSN use cases in automation, automotive, audio and other areas utilize PTP
for synchronizing nodes in a network accurately, but the underlying master
clock is not necessarily related to clock TAI. They are completely
independent and just represent a common notion of time in a network for an
application specific purpose. This comes with problems obvioulsy:

   1) Applications have no fast access to the time of such independent PTP
      clocks. The only way is to utilize the file descriptor of the PTP
      device with clock_gettime(). That's slow as it has to go all the way
      out to the hardware.

   2) The network stack cannot access PTP time at all because accessing the
      PTP hardware requires preemptible task context in quite some cases.

There has been attempts to solve this by creating a new PTP specific
infrastructure independent of the core timekeeping code, but that's a
patently bad idea as it would just create duplicated code with new bugs and
also be in the way of supporting these clocks in the VDSO and hrtimers
based on such clocks down the road.

This series addresses the timekeeping part by utilizing the existing
timekeeping and NTP infrastructure, which has been prepared for
multi-instance in recent kernels.

The approach is the same as for core timekeeping:

    The clock readout uses the system clocksource, e.g. TSC, ARM
    architected timer..., and converts it to a "nanoseconds" timestamp with
    the underlying conversion factors.

    The conversion factors are steered via clock_adjtimex(2) to provide the
    required accuracy. That means tools like chrony can be reused with a
    small amount of modifications.

The infrastructure supports up to eight auxiliary clocks and timekeepers,
which can be accessed by the new CLOCK_AUX0 .. CLOCK_AUX7 POSIX clock IDs.

The timekeepers are off by default and can be individually enabled/disabled
via a new sysfs interface. In the disabled case the overhead introduced by
these timekeepers is practically zero. Only if enabled, the periodic update
in the timekeeper tick adds extra work.

The infrastructure provides:

    1) In-kernel time getter interfaces similar to the existing
       ktime_get*() interfaces. The main difference is that they have a
       boolean return value, which indicates whether the clock is enabled
       and valid. These interfaces are lockless and sequence count
       protected as the other ktime_get*() variants, so the same
       restrictions apply (not usable from the timekeeper context or from
       NMI).

    2) clock_gettime() support

       Same as the existing clock_gettime() for CLOCK_..., but returns
       -ENODEV if the clock is disabled.

    3) clock_settime() support

       Same as clock_settime(CLOCK_REALTIME), but does not affect the
       system timekeeping

    4) clock_adjtime() support

       Same as clock_settime(CLOCK_REALTIME), but does not affect the
       system timekeeping. It has some restrictions: no support for PPS,
       leap seconds and other tiny details which are only relevant for
       CLOCK_REALTIME steering.

The timekeeper updates for these auxiliary clocks are not yet propagated to
VDSO and paravirt interfaces as this has to be addressed separately once
the core infrastructure is in place. Thomas W. has a prototype
implementation for the VDSO support ready, which will be posted once the
dust has settled here.

Once the timekeeping infrastructure is in place, the road is paved for
supporting hrtimers on these clocks, which is another problem in the
context of applications and the network stack. The idea is to convert the
independent expiry time to clock MONOTONIC internally under the assumption
that both involved clocks will have halfways stable conversion factors
within the expiry time of the timer. If one of the clocks starts to jump
around via their respective clock_adjtime(2) steering, then there are
bigger problems to solve than a timer expiring late. But that's just an
concept in my head and on some scribbled notes. It will take some time to
materialize. But let's get the timekeeping part sorted first. :)

Changes from V1:

   - Rename to auxiliary clocks/timekeepers - Miroslav

   - Fix the sysfs documentation - Antoine

The series applies on top of 6.15-rc7 + tip timers/core and is available
from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/ptp/clocks

Thanks,

	tglx
---
 Documentation/ABI/stable/sysfs-kernel-time-aux-clocks |    5 
 include/linux/timekeeper_internal.h                   |   28 
 include/linux/timekeeping.h                           |   11 
 include/uapi/linux/time.h                             |   11 
 kernel/time/Kconfig                                   |   15 
 kernel/time/ntp.c                                     |   72 +-
 kernel/time/ntp_internal.h                            |   13 
 kernel/time/posix-timers.c                            |    3 
 kernel/time/posix-timers.h                            |    1 
 kernel/time/timekeeping.c                             |  576 +++++++++++++++---
 kernel/time/timekeeping_internal.h                    |    3 
 11 files changed, 619 insertions(+), 119 deletions(-)



