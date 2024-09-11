Return-Path: <netdev+bounces-127382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A56D9753F0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE0D288B55
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7941B1A264B;
	Wed, 11 Sep 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B7RSF/oR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBlec/9y"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE319CC29;
	Wed, 11 Sep 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061404; cv=none; b=neDnzlkwWnPQdDfXEWDJ511J+A5H7r9eaE4fyyHMKA4hleksOLFPOUCSFL0Iyae2uWQt1qKIYZpnLNfddnGUDo/qTGYv12VsKFhZ/zyhLxsyDyTpWQISToCQRIQSHFtqfAhOJ3X4YpbrssjsyReKslSAxPacup5U0YJ5QSW9zdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061404; c=relaxed/simple;
	bh=dkFOCyvalwHeNMvRypyWO4UnX7mhw0JQw9NqQjLVCbM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ocuWJWAZcCMqy2/JJww6o/4XkAnin9fJHrjZ73OCQSitRoGfkkDCu61pUb5Q1kENgfu6ry+Gy82GrlS9kcldbIMj5qM5+Rm+FeLPHhzWsAzTzb9kIU5m9g8gTy7Z/U1w7aR6rWsuYkIEArNI5WD71aXYNfJ/wsdTSrLvEyqQf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B7RSF/oR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBlec/9y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5MgnnLW0tJEzYRXxpu+WsPzEVtvVIfkgrh1D7ZrkxY=;
	b=B7RSF/oRKCMzSKVtci4WJz4W+oyEoQMFd0R4zuh5TkoJaQrHVsIXa1PEi/N0S2Pb+Y+FuI
	XU1FxbqIjlHGa7YNwLhs5QN09trBnXEDXYPuHgoqAHSALk16OSkp8xF2ePsW4XG7fakQQ3
	sCoxpCJRC9GQktKv28TEWzu2sHw37CYOOzeDXPmXBZUfElVfjUTBc6k480ixLAxZWLt8kS
	tg60ZqT9rsjvMW1CyVlYDHBpKwnlpGm9b6ojdlMQzf10TGd+lu8GGDXNsKKsc51mBzPcZu
	pUSXCInednXSCvFvUVz1FHUf4C4U6eRE6Bg4OplxeKW3kLj6Uea8014QzhirWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5MgnnLW0tJEzYRXxpu+WsPzEVtvVIfkgrh1D7ZrkxY=;
	b=uBlec/9y10Kd50pV4M2TGWhctyFcBO5g9eyU9P//oa4BIbDVrhxNPbUYGN++twjUKdKsA9
	I0/4t6+LPSUiGdDQ==
Subject: [PATCH 00/24] timekeeping: Rework to prepare support of
 indenpendent PTP clocks
Date: Wed, 11 Sep 2024 15:29:44 +0200
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEib4WYC/x2NwQrCMBAFf6Xs2YVNDIj+injYts+6aNeQlCKU/
 ruht5nLzEYVxVDp1m1UsFq1rzcJp46Gl/oEtrE5RYlJriHwiBUfVnflWYsp94kXm1Eq5yUf+Aa
 y+cRDEjn3F0lRArVgLnja75jdH/v+Bxtfyhd8AAAA
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

The generic clock and timekeeping infrastructure supports only the already
defined clocks and as they are not independent there is no need of
generalization of data structures. But PTP clocks can be independent from
CLOCK_TAI.

PTP clocks already have clock_gettime() support via the file descriptor
based posix clocks. These interfaces access the PTP hardware and are
therefore slow and cannot be used from within the kernel, e.g. TSN
networking.

This problem can be solved by emulating clock_gettime() via the system
clock source e.g. TSC on x86. Such emulation requires:

1. timekeeping mechanism similar to the existing system timekeeping
2. clock steering equivalent to NTP/adjtimex()

In the already existing system timekeeping implementation the lock and
shadow timekeeper are separate from the timekeeper and sequence
counter. Move this information into a new struct type "tk_data" to be able
to recycle it for the above explained approach.

NTP/adjtimex() related information is all stored in static variables. Move
all of them into the new struct type ntp_data to make it reusable. (See
https://lore.kernel.org/r/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de)

Even without the future support for independent PTP clocks, the
generalization of timekeeping and NTP/adjtimex() improves the structure and
readability of the already existing code.

Once this is implemented clock_gettime() support for these clocks via vdso
can be implement as well but this is an orthogonal task.

This queue covers only the generalization of timekeeping:

- Patch 1-5:   Basic cleanups
- Patch 6-10:  Generalization of tk_data
- Patch 11-24: Use always shadow timekeeper for updates

The queue is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/ptp/timekeeping

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Christopher S Hall <christopher.s.hall@intel.com>
To: John Stultz <jstultz@google.com>
To: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Thanks,

Anna-Maria

---
Anna-Maria Behnsen (16):
      timekeeping: Avoid duplicate leap state update
      timekeeping: Move timekeeper_lock into tk_core
      timekeeping: Define a struct type for tk_core to make it reusable
      timekeeping: Add struct tk_data as argument to timekeeping_update()
      timekeeping: Split out timekeeper update of timekeeping_advanced()
      timekeeping: Introduce combined timekeeping action flag
      timekeeping: Rework do_settimeofday64() to use shadow_timekeeper
      timekeeping: Rework timekeeping_inject_offset() to use shadow_timekeeper
      timekeeping: Rework change_clocksource() to use shadow_timekeeper
      timekeeping: Rework timekeeping_init() to use shadow_timekeeper
      timekeeping: Rework timekeeping_inject_sleeptime64() to use shadow_timekeeper
      timekeeping: Rework timekeeping_resume() to use shadow_timekeeper
      timekeeping: Rework timekeeping_suspend() to use shadow_timekeeper
      timekeeping: Rework do_adjtimex() to use shadow_timekeeper
      timekeeping: Remove TK_MIRROR timekeeping_update() action
      timekeeping: Merge timekeeping_update_staged() and timekeeping_update()

Thomas Gleixner (8):
      timekeeping: Read NTP tick length only once
      timekeeping: Don't stop time readers across hard_pps() update
      timekeeping: Abort clocksource change in case of failure
      timekeeping: Simplify code in timekeeping_advance()
      timekeeping: Reorder struct timekeeper
      timekeeping: Move shadow_timekeeper into tk_core
      timekeeping: Encapsulate locking/unlocking of timekeeper_lock
      timekeeping: Provide timekeeping_restore_shadow()

 include/linux/timekeeper_internal.h | 102 ++++++----
 kernel/time/timekeeping.c           | 369 +++++++++++++++++-------------------
 kernel/time/timekeeping_internal.h  |   3 +-
 kernel/time/vsyscall.c              |   5 +-
 4 files changed, 238 insertions(+), 241 deletions(-)


