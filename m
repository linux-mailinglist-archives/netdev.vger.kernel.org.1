Return-Path: <netdev+bounces-190197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F32AAB5847
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421C33A253D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052E2C0847;
	Tue, 13 May 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYGZeexd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bcd/h5tn"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8062C030F;
	Tue, 13 May 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149202; cv=none; b=B/cr74VcZtGz+zCYujvtSyYvDGH02/YKPNwRQFyKni4qICG7tbjCZjzRlAVaQlh0BLaO6BBv2SadOITXE5krRBxZbvGR0fibSAfMLQCESZfblGXXKZfZmZV7p+A8FCmykBGpAZwKiDSEAWgpvfvFyQBXEr5I3K/AFM+hZrs1PQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149202; c=relaxed/simple;
	bh=iD+Kcf0L16tFt0BYOWblZLMLXQ/SDxHWJWT4Krt2br0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sja1eUjWFh8wDaPgFBeJCegB3REh9MIaSCQAaGLTxeA9XbfM/sx33kVXELf5LzeeZ9yyLVfzRcaAknU+f0UXEpNSHgYZdhzqSrY5rEo/UGPzUfTOinZQpE20KQ155M4LNyJ9Jgl1z09Vzz39PQssGtfBCnaNvycYixoI4S9YWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYGZeexd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bcd/h5tn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.446283287@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wK3kKijwAh9tE7s5X+OhXxFEfHd8a5JPnG7m6/+F1gk=;
	b=cYGZeexdo3ogM0CruXYBBARqi4Pk2m3aGVgcGbi1cUlnAqjNEueL8SmPeyCvIky6+ueB+K
	CS9bgJqdvALrYsaC76cof3Uuq/82NtexlybvITg8hzHGZTvIYr6dhqSCYzkKbocRZJpVob
	Jc5Um+Ans1/Y0EZKsBMydj5LSdjU5gbAN3GmtMcavRAi7DfUSZeHO871+MwDpb4mk0+qgV
	+pq6Rpn1IRR0ws/JLXpLDYr/41D1rzjNQMnzeBeUzay+2YJ18AmC1nPo9sZu/sdH9Gofx9
	lpRcl4mwSlrd6G+gZ9DPl3da6Oi7clX1V3/h1RhwMzYzNEKszmVp7je0PDKf3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wK3kKijwAh9tE7s5X+OhXxFEfHd8a5JPnG7m6/+F1gk=;
	b=Bcd/h5tncOafB/p7gkWzOKCV7z5793M5+uIm3/t+V9Rxs1WA4dlR/oFew3cCKWpXUAHKGP
	LdtfL7q7e1dr78DQ==
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
Subject: [patch 13/26] timekeeping: Provide ktime_get_ntp_seconds()
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:18 +0200 (CEST)

ntp_adjtimex() requires access to the actual time keeper per timekeeper
ID. Provide an interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c          |    9 +++++++++
 kernel/time/timekeeping_internal.h |    3 +++
 2 files changed, 12 insertions(+)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2622,6 +2622,15 @@ int do_adjtimex(struct __kernel_timex *t
 	return ret;
 }
 
+/*
+ * Invoked from NTP with the time keeper lock held, so lockless access is
+ * fine.
+ */
+long ktime_get_ntp_seconds(unsigned int id)
+{
+	return timekeeper_data[id].timekeeper.xtime_sec;
+}
+
 #ifdef CONFIG_NTP_PPS
 /**
  * hardpps() - Accessor function to NTP __hardpps function
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -45,4 +45,7 @@ static inline u64 clocksource_delta(u64
 unsigned long timekeeper_lock_irqsave(void);
 void timekeeper_unlock_irqrestore(unsigned long flags);
 
+/* NTP specific interface to access the current seconds value */
+long ktime_get_ntp_seconds(unsigned int id);
+
 #endif /* _TIMEKEEPING_INTERNAL_H */


