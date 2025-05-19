Return-Path: <netdev+bounces-191410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA7ABB74E
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8BC1899DFE
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D2D26B08D;
	Mon, 19 May 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p/HtvDsb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ygLGRzFg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24F26A1AF;
	Mon, 19 May 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643602; cv=none; b=Hsr1tXk10z0avP/+cUnSk93P4niKJmXDM0CtMTrZ33TuYkWUY92mUo0LH3kN7mUlTtvSeGFDkz0HOGFaEyS7C68WYjARSalOCKgghp3y+G7EjUN15rXQGXNzHpVS/62QsQ0oSs3zSJjb7w7LkB6vIpIVUbl2onpEb/RRP0byJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643602; c=relaxed/simple;
	bh=Sx6rncooqkhKOzat2v2on7x2T8s4Z9UMGZUwfEwbSWE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=n4YvH1n1DLM65XuJbwC4EHkSZHwo6zVRPvKAQ2prJ4uOBEkyrtK/sfPKUmlJ0vy+j3+iC4v9rjSfpwJNG1oyd+WKY7Q2C8CrlZkjvvQCjxrDzeFG9RxLhMTCq+fKbih7lMNcB3ZHJLEa7yFzHGldgKAR7o35F1fD0+lZ8JH8s4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p/HtvDsb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ygLGRzFg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083025.842476378@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3906OWgNj05DnYmkA1aciBB3X1N0MG0VN+Nbx7YbBLY=;
	b=p/HtvDsb27Py71nJos+HecxF56B6gdkErX21gDy8TcXL56d68Gj4X/Kiq9V3iaPcFPeUtK
	ejx1NQX/nlDfOBwypvDgd0gUdECOu6LNg2oPrVhcMDcqDu4aMXqkI7NaJYa+15+72gJsoE
	QBQGUnftOGAHUT/XuxFlREgCUhlGPWykepxqYahCnl9QJv+4Jg4IlQt1a5Dqw574HxmtFc
	72LMQuXzJzO4BWZbu2psgW04p1CZW26ShcLNc9uWGz1tm/cYHPUV6bUcMaC6XzI5wW8IYt
	TPTIHeqSdUFtgZX34RbrPug5/SkPskX82z/aXF5THO6+MkaKt6sBWq/TZBtPVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3906OWgNj05DnYmkA1aciBB3X1N0MG0VN+Nbx7YbBLY=;
	b=ygLGRzFgM/88PJRFPuOSRaxDi3MF+SQXqHf8px/QOkuhS2rc5EFOHv2oMj6EJdaDqe5pkX
	ANAA9BR2Wi8gopDw==
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
Subject: [patch V2 04/26] timekeeping: Introduce timekeeper ID
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:19 +0200 (CEST)

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

As long as there is only a single timekeeper, there is no need to clarify
which timekeeper is used. But with the upcoming reusage of the timekeeper
infrastructure for auxiliary clock timekeepers, an ID is required to
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
@@ -1663,10 +1663,11 @@ read_persistent_wall_and_boot_offset(str
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
@@ -1696,7 +1697,7 @@ void __init timekeeping_init(void)
 	struct timekeeper *tks = &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
 
-	tkd_basic_setup(&tk_core);
+	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&


