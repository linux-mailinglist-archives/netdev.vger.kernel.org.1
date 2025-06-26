Return-Path: <netdev+bounces-201567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEBBAE9EC0
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F9163E26
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561302E7170;
	Thu, 26 Jun 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QwyLPdFw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lz0sz8iw"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0A82E62AD;
	Thu, 26 Jun 2025 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944457; cv=none; b=ZBh/GCh1SLn0vX8iZICAlhtEI+rve1FG/bodbGAO2NS4GhGLZWYWJ92T46CSQ0THuTb0gIpiXLD3zEWipIEcHbdo9x2fSwf9jHz9CcItKkVdKBX0TvJVdYv50807pVGpKNDj4fdPT9XCLv8RxUYkd1uu2wOlUu3Tprhj4yO0thg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944457; c=relaxed/simple;
	bh=hdkXS2zPS05MylX9NsfoU4bC44QsxXSw2hQjbhoIp0g=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VymoUWJ8i8gBqelkpTuooeeY2HgtQFI/fPudeogfv+XkYwFeWD732cKgi9dQMBr/2VQMIN9cENYevSpbPp1q5ksqPKq8I5Ih5wQCwJKLcGk8csfjJ/0gJwt6MtBjkaWphhOD78cmPBoXK98pjgu9dhpqOHk9MZNbh7BV51VNKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QwyLPdFw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lz0sz8iw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250626131708.482362835@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750944453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2B6a0np2Ef6lES3YZRHCRVSuzy1PUmYaASOyD3FWdbM=;
	b=QwyLPdFw1sCXqR0yjB4jgTFo1nJbpeCD+OAqbRc4sf5OMfih3v6uQpDuxqc0qWYjYyQF9O
	tfz8oxh2adtkxN0V8w3/jvD7hpiQ8rGUErsKywmF3JaM5G4u/9eMzZGSbANWgZcB3btK2/
	/1p0pvjqhaFf8geW9XSbYg+Bigc1wISh3fbsLvGLCCmK6rZym2kgS9mbvjD+W7YGflV1XO
	ImFVjDd/uwI3/ZLiFc4B/uNgdiuzIBWo3sEs6Ei1TzJE49vkmXYmWW/6JbzZ9X7JpY+XBh
	3SKsYhiAzVyDKfO6dO+ZsqL59FQ3V4WmjISKdUxzURa5RaohqiVpl3CJirFYgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750944453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2B6a0np2Ef6lES3YZRHCRVSuzy1PUmYaASOyD3FWdbM=;
	b=Lz0sz8iwXNkxkzVTQWEdYBXu2OEMFQGeXzwgLkwuPGn1aMAwksv6hQkU0ucjeh3uYBgGU6
	n/q/JB160dmY0RDw==
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
Subject: [patch 2/3] ptp: Use ktime_get_clock_ts64() for timestamping
References: <20250626124327.667087805@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 15:27:32 +0200 (CEST)

The inlined ptp_read_system_[pre|post]ts() switch cases expand to a copious
amount of text in drivers, e.g. ~500 bytes in e1000e. Adding auxiliary
clock support to the inlines would increase it further.

Replace the inline switch case with a call to ktime_get_clock_ts64(), which
reduces the code size in drivers and allows to access auxiliary clocks once
they are enabled in the IOCTL parameter filter.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/ptp_clock_kernel.h |   34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -477,40 +477,14 @@ static inline ktime_t ptp_convert_timest
 
 static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
 {
-	if (sts) {
-		switch (sts->clockid) {
-		case CLOCK_REALTIME:
-			ktime_get_real_ts64(&sts->pre_ts);
-			break;
-		case CLOCK_MONOTONIC:
-			ktime_get_ts64(&sts->pre_ts);
-			break;
-		case CLOCK_MONOTONIC_RAW:
-			ktime_get_raw_ts64(&sts->pre_ts);
-			break;
-		default:
-			break;
-		}
-	}
+	if (sts)
+		ktime_get_clock_ts64(sts->clockid, &sts->pre_ts);
 }
 
 static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 {
-	if (sts) {
-		switch (sts->clockid) {
-		case CLOCK_REALTIME:
-			ktime_get_real_ts64(&sts->post_ts);
-			break;
-		case CLOCK_MONOTONIC:
-			ktime_get_ts64(&sts->post_ts);
-			break;
-		case CLOCK_MONOTONIC_RAW:
-			ktime_get_raw_ts64(&sts->post_ts);
-			break;
-		default:
-			break;
-		}
-	}
+	if (sts)
+		ktime_get_clock_ts64(sts->clockid, &sts->post_ts);
 }
 
 #endif


