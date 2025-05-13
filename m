Return-Path: <netdev+bounces-190199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A0AB584E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1133A79CC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50F2C1095;
	Tue, 13 May 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uqv9NzW5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s6/VxClc"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F02C087C;
	Tue, 13 May 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149206; cv=none; b=jlqw+dOnbuNDAJs1Ki4R3E13Ev/8UXAnMXnrNdCw2k0bc5Wr2dvXIEfPm4oiOKQ/wS5eyDFC6MuO0FD48QELC/u/ePjKibIzVmmHcMlJMDNjqsgAyVlJF7NZ2NE607SJ6XDWFZ0rSPOmIUqpSxcq01Bn7UfOHoEVArSZInXs848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149206; c=relaxed/simple;
	bh=LhQREkONcb+tLt5GRK6qgTzA/6KmCZWf9yMBEfO/yeQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ty3hni48zZbEEGWLwRGdW/FiS4X1DKHLCKe7AOWcuaxOkMkPT/j+OcQdS6wjWNQ+LPfkgQJBkT5fW6WU64RZfQhE+I8Q7gGrp29w0/5HwUtfwD5KF6Xdr+5VrbfuXJTqch68gBhvVkyGxSn6Z3vF7KkWJUcjNdrp5iKUuv5g5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uqv9NzW5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s6/VxClc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.563966518@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8XNmnyHFdARnwNRX2BFu6/xrrFBJ/FwOA2GC3ntaejs=;
	b=uqv9NzW5/9OF80V7xvFVFXBnft0/dhCLJUmXt4y9TqbnExOnjvyeuGVBMtRLWHVRKYhhiJ
	F+1YZUOeEz536uuDB/SDXGJfQr1g42fgHD1H0VaVixH20Um5yCKsmwsaSq1/MbgCGuaLB2
	LOF7nCovIokYQMxveVZodWvM/wmJj6OD3xBw3Kn1pdQ0kKWSFau0HJdpZij5yDuEMRVLRv
	8AMUphIqxj/+ZYuwleAdDiC9z1V86uXFetlH+MY74La1+PMfYXB/lpgx/I9upqQoeseIbP
	zaIRczVV181IxvBWsWagpX7oZvkgeCfV9YHSQgDzWU+nwQGGJXcGV2u6Z4MpZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8XNmnyHFdARnwNRX2BFu6/xrrFBJ/FwOA2GC3ntaejs=;
	b=s6/VxClc6B5EPIFL8IcDiID+cdJNrqsOvtjk+KyQswhlcz9uPeMIOmYk67SVV0CVYBAGvM
	GuikIQ806YCP14Bg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 David Zage <david.zage@intel.com>,
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
 Alex Gieringer <gieri@linutronix.de>
Subject: [patch 15/26] timekeeping: Add PTP offset to timekeeper
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:22 +0200 (CEST)

This offset will be used in the time getters of independent PTP clocks. It
is added to the "monotonic" clock readout.

As independent PTP clocks do not utilize the offset fields of the core time
keeper, this is just an alias for offs_tai, so that the cache line layout
stays the same.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timekeeper_internal.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -67,6 +67,7 @@ struct tk_read_base {
  * @offs_real:			Offset clock monotonic -> clock realtime
  * @offs_boot:			Offset clock monotonic -> clock boottime
  * @offs_tai:			Offset clock monotonic -> clock tai
+ * @offs_ptp:			Offset clock monotonic -> clock PTP
  * @coarse_nsec:		The nanoseconds part for coarse time getters
  * @id:				The timekeeper ID
  * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
@@ -139,7 +140,10 @@ struct timekeeper {
 	struct timespec64	wall_to_monotonic;
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
-	ktime_t			offs_tai;
+	union {
+		ktime_t		offs_tai;
+		ktime_t		offs_ptp;
+	};
 	u32			coarse_nsec;
 	enum timekeeper_ids	id;
 


