Return-Path: <netdev+bounces-127362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE06297536F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA58289AC7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543A19CC0F;
	Wed, 11 Sep 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qrgzpckx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3oRPYxu5"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D8187FFF;
	Wed, 11 Sep 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060681; cv=none; b=fQ70KFVzaSYenJxwHo3pIeg47Pigt4ldK5bm+5rdUCb/V33x4cNbY2Idy6Hl2gnb7aLT5Zuz7KbqlFhwWyZWLYjcyfEKoF0UDuv0cUmRilGj9PTvSx/wVFGGgmhT79pMkoE0jA7uZZOYmM2uqWZMtOt3mVye6WxhDwgb/EyDtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060681; c=relaxed/simple;
	bh=08HPs+IfvuwCCWG8S9QQOxt572MHOvLnXjxrXmk4d3M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bRQdpu/gjVmKqxyWUSq4MzbeR+gW/2NBDqs69VrGAcOtCA5iY3TsAcMfXp986b1B0NkAsmlqPfNahiD5qDqtO04ZxnH3ko9bTUaqhYLNFmcuuF3pWWZKxu+0PMr3ipzhgP7TYQsWoJouv55/CXXrd+/WOXspY94VzLcXNlZyQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qrgzpckx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3oRPYxu5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5h0u8V4Ds5ZnkfCDN2EzW4vp0zGqRzmCmbm5kacKrVI=;
	b=qrgzpckxcLZK+GxU1BhAjbcb1wV8Pi7Kw9y/x+alamA0A9Kdvp+5ds7nfij6jJwOPxMJCM
	hDarp7H62zAodzbILuagj09fIWV4uy7jAuAmDFRPWj6seQuj5vpoqJbwLyeUXICDX7RQfn
	Ck6eyxMq9SZnPn/KneB9N0iaFycn752m4kFYA57YO5D/hrF1dH5pFdAh7M08WM5FJkz1H6
	pGJ0bZy1UiwfDaH7Dq5wAuvkBFwyWyR+LI6qtT8o2hBbBcVza+QGgpEYEIlR+OBIQ8QDPo
	nY4G7bZczXpwtr+LXGhlFW0FZ9zY5kKi/ll/dohjubwN0UDE7KNG/TMPQkqLAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5h0u8V4Ds5ZnkfCDN2EzW4vp0zGqRzmCmbm5kacKrVI=;
	b=3oRPYxu5QMaG81i5n8ejSsQTp0s3NeYIg7q2rT66YfI6SiHY0Hsb2jo7sbxLH9zaS6dJa1
	PWM3TTwBdH8BtVCA==
Subject: [PATCH 00/21] ntp: Rework to prepare support of indenpendent PTP
 clocks
Date: Wed, 11 Sep 2024 15:17:36 +0200
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCY4WYC/x2NwQqDQAwFf0VybsC1guivlB6eGjWg6ZIVKYj/7
 uJhDnOZOSmJqyTqipNcDk36syzhVdCwwGZhHbNTVVZ12YbAoxyyMszAG1zBfc27buKJ4x7ZMgj
 NNPQN0OJNORRdJv0/k8/3um6FtzfidAAAAA==
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
all of them into the new struct type ntp_data to make it reusable.

Even without the furture support for independent PTP clocks, the
generalization of timekeeping and NTP/adjtimex() improves the structure and
readability of the already existing code.

Once this is implemented clock_gettime() support for these clocks via vdso
can be implement as well but this is an orthogonal task.

This queue covers only the generalization of ntp:

- Patch 1-6:  Basic cleanups
- Patch 7-21: Introduction of struct ntp_data and move all static variables
	      to the struct

The queue is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/ptp/ntp

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
Anna-Maria Behnsen (1):
      ntp: Cleanup formatting of code

Thomas Gleixner (20):
      ntp: Remove unused tick_nsec
      ntp: Make tick_usec static
      ntp: Clean up comments
      ntp: Convert functions with only two states to bool
      ntp: Read reference time only once
      ntp: Introduce struct ntp_data
      ntp: Move tick_length* into ntp_data
      ntp: Move tick_stat* into ntp_data
      ntp: Move time_offset/constant into ntp_data
      ntp: Move time_max/esterror into ntp_data
      ntp: Move time_freq/reftime into ntp_data
      ntp: Move time_adj/ntp_tick_adj into ntp_data
      ntp: Move ntp_next_leap_sec into ntp_data
      ntp: Move pps_valid into ntp_data
      ntp: Move pps_ft into ntp_data
      ntp: Move pps_jitter into ntp_data
      ntp: Move pps_fbase into ntp_data
      ntp: Move pps_shift/intcnt into ntp_data
      ntp: Move pps_freq/stabil into ntp_data
      ntp: Move pps monitors into ntp_data

 arch/x86/include/asm/timer.h |   2 -
 include/linux/timex.h        |   8 -
 kernel/time/ntp.c            | 840 +++++++++++++++++++++----------------------
 3 files changed, 419 insertions(+), 431 deletions(-)


