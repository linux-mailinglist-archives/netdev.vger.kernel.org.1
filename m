Return-Path: <netdev+bounces-191417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F59ABB764
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDC2189A6BC
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F626FDA8;
	Mon, 19 May 2025 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lQ8VNKyO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVNm7qRF"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9113526FA50;
	Mon, 19 May 2025 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643611; cv=none; b=Uu5ozdwgsDAx1FtEpJFED7kkBCm5kwQhA0JOM2ism7sn7TtbV+m5U4sbQLHz42sXo+L2qFdtOcOKZPlcqEf8liS1chPESJwWcXGwgcXFNd9rEPxqmx/VrGf9CEaKBZ2f57yqZfAzK1BQ2FVmFtpFU6vsaZv31aUTpXCgWoXaomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643611; c=relaxed/simple;
	bh=v2CnstdLIXMf6usycAYVnie0z2f9rUAXKX2icLofJLY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=o4Q9l8lhHBMaYn2VSkSuSw02+JzCEjaf+i9I/EfR1dl8ILFAmM4Kka31d3/rmZ4NhwZVZzHFwvSw6677f54X6sdMuWXU/XIJEWSAOldpvk9I9kkgHcfb/miDZGDezJfWwN6vt5D7F06so2HDx65yPILJYGA42KCyRuJcjvEWxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lQ8VNKyO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KVNm7qRF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.287145536@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KU3LaI1wfhZWx046ayWmUOBaJZ+N4sC2ljBYeM/Rzlk=;
	b=lQ8VNKyOx9Nyv/C0fuO+6qs24jw7XNfMURf6YaKmKPhFmVvUhfVfVuZ96H3/0KtRNEqoyj
	lHNufJfcfulrYM1oNxW9ql05gaXlMHrXM0I1U2qwjmQcDt6sr+74CHtXkOXnredgn+j8PN
	7IVo02PyYUtSzPcVybBKlOvoPmij0/Kr5qfcnJJolV2F9rs/L9++rT4uH3w5tr8fQidVgf
	rBQDz30Z/L6J/b4d7SD0uSA0aZiNRYJ1MDXonXyK9+kInVTrZ76ZtwkcFVB7qpxG2I4Kq7
	1N7oytuaWLWl/YEw+Ja6pS0axaBJmzbRQ8P737t6hF5XGZ7FrRYsqTdaGvyrIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KU3LaI1wfhZWx046ayWmUOBaJZ+N4sC2ljBYeM/Rzlk=;
	b=KVNm7qRF+fM81O67uDIUxjCJD1LhOL5OMe6Vw3XVNMKRayg47o8SLvlAExb2hvrPOMtAGN
	sIaaNX4CbVHajSCw==
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
Subject: [patch V2 11/26] timekeeping: Add clock_valid flag to timekeeper
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:27 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

In preparation for supporting independent auxiliary timekeepers, add a
clock valid field and set it to true for the system timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/timekeeper_internal.h |    2 ++
 kernel/time/timekeeping.c           |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)
---
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -73,6 +73,7 @@ struct tk_read_base {
  * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
  * @clock_was_set_seq:		The sequence number of clock was set events
  * @cs_was_changed_seq:		The sequence number of clocksource change events
+ * @clock_valid:		Indicator for valid clock
  * @monotonic_to_boot:		CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
  * @cycle_interval:		Number of clock cycles in one NTP interval
  * @xtime_interval:		Number of clock shifted nano seconds in one NTP
@@ -149,6 +150,7 @@ struct timekeeper {
 	/* Cachline 3 and 4 (timekeeping internal variables): */
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
+	u8			clock_valid;
 
 	struct timespec64	monotonic_to_boot;
 
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1665,11 +1665,12 @@ read_persistent_wall_and_boot_offset(str
 	*boot_offset = ns_to_timespec64(local_clock());
 }
 
-static __init void tkd_basic_setup(struct tk_data *tkd, enum timekeeper_ids tk_id)
+static __init void tkd_basic_setup(struct tk_data *tkd, enum timekeeper_ids tk_id, bool valid)
 {
 	raw_spin_lock_init(&tkd->lock);
 	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
 	tkd->timekeeper.id = tkd->shadow_timekeeper.id = tk_id;
+	tkd->timekeeper.clock_valid = tkd->shadow_timekeeper.clock_valid = valid;
 }
 
 /*
@@ -1699,7 +1700,7 @@ void __init timekeeping_init(void)
 	struct timekeeper *tks = &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
 
-	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE);
+	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE, true);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&


