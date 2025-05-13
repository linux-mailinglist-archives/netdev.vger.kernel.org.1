Return-Path: <netdev+bounces-190188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E951AB5831
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AB7466A6F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A302BE7DF;
	Tue, 13 May 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FQ8qF6Vp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VlobM1Iq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D52BE7BF;
	Tue, 13 May 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149186; cv=none; b=Bj+yt3TTJ1ktujlwkD1/z5JUuGRjZsgYXgPsxaVjdc85s+6J8Uuft9YJXltLfzkn+EmGgNLGAXk/6+J/bDH+MRWVRJzb2eNk4EUz3sEBGzR3VL2gknvc8o8hayemGmW4BE541x/AQZXQ8mATykS0wD0wL9I3C+gUIY+m2TBvQgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149186; c=relaxed/simple;
	bh=tO94s04cwNa0K8JKWvxpUkZ4hglOVVlX8obWhhM6690=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=cXWcXsyFGRcPeAciBtA5lSVhy0CIrQAWB0cftck1Lof7TuGCzzO47jJJyRvlPZ9afi7PSgTfHChdjs+dDJ5wcv12PjOaSnyS5UfthJYnJHHgSMzMyVl7gNJss+XrNwiqHTCdvflcLtPKQcf7IL+DYxdom0v9RIca7VQwLPX2ujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FQ8qF6Vp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VlobM1Iq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145136.908036915@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ITg02Kv4JkJ6MviaQE7ufCrtvZ0fwMzABnGHEcpC8Ak=;
	b=FQ8qF6VpnFWdXYYX1Jj/rCC/PAZVUJD1XU1oz4Mz0l4VNfWrUjiAhLYlM6ygU3KhTsEKfN
	U4wByozt5uN8wjk2ijN9ahMUsWYsZiah0HWUSSexlTr/BVVgbgdmv3JSEoyF/T/ZYGJKtu
	dm+UCompcuR6uRZC/oEKg7jbSF06B5ZJ4Dqo2ss0DG2CWwAXldIurOOUwgfKB37Tv+0eLJ
	fb7Bt0P7SzKEn/8DQlZ2ZhiCg1JdPCyXzQMTFbDHhxbzeAzYIU2k/wOLWerzjmObhU6Y/H
	9y4YngcGVPYzP9eiiiVztUkDlFjf9kMDk2LVZh/vpGKg4lZT+j+dI7NBkCtIAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ITg02Kv4JkJ6MviaQE7ufCrtvZ0fwMzABnGHEcpC8Ak=;
	b=VlobM1IqkzUtzAI11rX4KS4DSt5vomcHunf9MjVq+8JyDP0hIu7aQe8IKa/Cx9025EjohV
	bd/TsNvdU9vRiGAQ==
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
Subject: [patch 04/26] timekeeping: Introduce timekeeper ID
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:02 +0200 (CEST)

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

As long as there is only a single timekeeper, there is no need to clarify
which timekeeper is used. But with the upcoming reusage of the timekeeper
infrastructure for per PTP clock timekeepers, an ID is required to
differentiate.

Introduce an enum for timekeeper IDs, introduce a field in struct tk_data
to store this timekeeper id and add also initialization. The id struct
field is added at the end of the second cachline, as there is a 4 byte hole
anyway.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/timekeeper_internal.h |   14 +++++++++++++-
 kernel/time/timekeeping.c           |    5 +++--
 2 files changed, 16 insertions(+), 3 deletions(-)
---
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -12,6 +12,16 @@
 #include <linux/time.h>
 
 /**
+ * timekeeper_ids - IDs for various time keepers in the kernel
+ * @TIMEKEEPER_CORE:	The central core timekeeper managing system time
+ * @TIMEKEEPERS_MAX:	The maximum number of timekeepers managed
+ */
+enum timekeeper_ids {
+	TIMEKEEPER_CORE,
+	TIMEKEEPERS_MAX,
+};
+
+/**
  * struct tk_read_base - base structure for timekeeping readout
  * @clock:	Current clocksource used for timekeeping.
  * @mask:	Bitmask for two's complement subtraction of non 64bit clocks
@@ -52,6 +62,7 @@ struct tk_read_base {
  * @offs_boot:			Offset clock monotonic -> clock boottime
  * @offs_tai:			Offset clock monotonic -> clock tai
  * @coarse_nsec:		The nanoseconds part for coarse time getters
+ * @id:				The timekeeper ID
  * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
  * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
  * @clock_was_set_seq:		The sequence number of clock was set events
@@ -101,7 +112,7 @@ struct tk_read_base {
  * which results in the following cacheline layout:
  *
  * 0:	seqcount, tkr_mono
- * 1:	xtime_sec ... coarse_nsec
+ * 1:	xtime_sec ... id
  * 2:	tkr_raw, raw_sec
  * 3,4: Internal variables
  *
@@ -123,6 +134,7 @@ struct timekeeper {
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
 	u32			coarse_nsec;
+	enum timekeeper_ids	id;
 
 	/* Cacheline 2: */
 	struct tk_read_base	tkr_raw;
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1658,10 +1658,11 @@ read_persistent_wall_and_boot_offset(str
 	*boot_offset = ns_to_timespec64(local_clock());
 }
 
-static __init void tkd_basic_setup(struct tk_data *tkd)
+static __init void tkd_basic_setup(struct tk_data *tkd, enum timekeeper_ids tk_id)
 {
 	raw_spin_lock_init(&tkd->lock);
 	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
+	tkd->timekeeper.id = tkd->shadow_timekeeper.id = tk_id;
 }
 
 /*
@@ -1691,7 +1692,7 @@ void __init timekeeping_init(void)
 	struct timekeeper *tks = &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
 
-	tkd_basic_setup(&tk_core);
+	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&


