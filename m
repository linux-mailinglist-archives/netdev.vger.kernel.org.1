Return-Path: <netdev+bounces-190191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7109DAB583B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286B34A33EB
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AB2BF3EC;
	Tue, 13 May 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dpUZ+NEI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6JN7qSr0"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4B2BF3CC;
	Tue, 13 May 2025 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149193; cv=none; b=ZQ2Eo+HLPzJW2cVItBwSXAlzZj5nZ4OmdfC0+WbpiWn+JVWcQDXoO9qjIxcq9sEcy01AIU+f0eh2LewabGA/LHxhoOL66gkMlUAOXZIx6N9ls6PFPXI879Q/GSadhOcYJJ6/mDBnSeZlQU63+d1ofLXzfOGYmPyXmzBJNGsEKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149193; c=relaxed/simple;
	bh=nRDu08MROYo+GlEghQBNTn6DIxcSl1cp2QYWZDZ8ZgE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Xo+OEroEJ+kiGP8+qm39CQRwf11OGES3319gMoJnFvGpY1C3a/JlBKvfor+tQFOEiJemJxUl3+UH0XYVY4ZdNDfwqwoIfEUdlT/W3hxPD2P96Isy/Nk6L3MUiOd3k/CMlQ6owZ33s37Op3nD8aoxzvwWF7FzWGEEj3yACw1itio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dpUZ+NEI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6JN7qSr0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.148177019@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=s7TqIjnwY+PkYxiPiQqY19Q4pa5q82PO4/E+388ZxbI=;
	b=dpUZ+NEIJ1Ejyt2bERI3z9R5xdDDMdefbjIb0kly4HRhvUHY0FRkFgET26Mnnldw5ZeMoh
	e8UCvqcIt/VnPype7jhKg8McGjDEYJoBp1HFqomwb6hFfRMMW6t9gMquwhil+BbzpXdxaZ
	Ws3WkygJNxT1GtYn36RBwpUHhL880n0bWl+XFE6o78QhLqPxOu/8sjmlSCL2Wi+BVRuH+I
	Xd15Vi5QcksD/PI+6gv6MBrN8qXkHGQPtqZVWFek6XxijY1AAcN1M0m0mBxuGdmDWEBxah
	5Zlb7nA/fpchuXiHr/SSgOEqIg6Lbvv/a8aVYpilEfh2p6thD5zBaSvOTs21lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=s7TqIjnwY+PkYxiPiQqY19Q4pa5q82PO4/E+388ZxbI=;
	b=6JN7qSr0fPBV4eo2Dsun+ZdCupZOj6S5WrAKZQKYM9P8VigweNxo6Hp0LcUWXXFfPjASkS
	kCtxJyR0+9Lm7LAA==
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
Subject: [patch 08/26] ntp: Rename __do_adjtimex() to ntp_adjtimex()
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:09 +0200 (CEST)

Clean up the name space. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/ntp.c          |    4 ++--
 kernel/time/ntp_internal.h |    4 ++--
 kernel/time/timekeeping.c  |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
---
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -767,8 +767,8 @@ static inline void process_adjtimex_mode
  * adjtimex() mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
-int __do_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
-		  s32 *time_tai, struct audit_ntp_data *ad)
+int ntp_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
+		 s32 *time_tai, struct audit_ntp_data *ad)
 {
 	struct ntp_data *ntpdata = &tk_ntp_data[tkid];
 	int result;
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -8,8 +8,8 @@ extern void ntp_clear(unsigned int tkid)
 extern u64 ntp_tick_length(unsigned int tkid);
 extern ktime_t ntp_get_next_leap(unsigned int tkid);
 extern int second_overflow(unsigned int tkid, time64_t secs);
-extern int __do_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
-			 s32 *time_tai, struct audit_ntp_data *ad);
+extern int ntp_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
+			s32 *time_tai, struct audit_ntp_data *ad);
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
 
 #if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2581,7 +2581,7 @@ int do_adjtimex(struct __kernel_timex *t
 		}
 
 		orig_tai = tai = tks->tai_offset;
-		ret = __do_adjtimex(tks->id, txc, &ts, &tai, &ad);
+		ret = ntp_adjtimex(tks->id, txc, &ts, &tai, &ad);
 
 		if (tai != orig_tai) {
 			__timekeeping_set_tai_offset(tks, tai);


