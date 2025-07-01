Return-Path: <netdev+bounces-202915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EBCAEFAA0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455CB4A0E80
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DAD277CA5;
	Tue,  1 Jul 2025 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KXYdhH9E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P1S3Ax6R"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694E277C81;
	Tue,  1 Jul 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376424; cv=none; b=fDa8aXTC5yF424eFGCvLk+zGiD/OPOL4JOzxQSVeEX7uvPQTg945E6S54IjIGHK4ULIl/fkWWe1JeO65PFDASrWGWmaqvGZRSDwl0CuZtBliN4DRVm+BlctWjfrnTK+LIdqvlt3RITKxQQ83CGSOTjlbIP6aLIlxCZ1niO6ddf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376424; c=relaxed/simple;
	bh=Ozepf7bbvdcsHM/gkfoXhsMGYOgiN2b9GLaX1QJJIbU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=WwXKziwL/ok5UOA3VhyuQzKnG3bRpACYlI1BcrlLtzPoDz6VKNWSVD8PNHzez2QDKibFNEV96N2yy6gKz2z8rumr4Y4jAxoDDjatDX2/HKhxPFot4YQ6pQRxlPcE35cpWqW/jBdaNd0MNvTeSP3mwgiie68eNekNQ/W0L/TB8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KXYdhH9E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P1S3Ax6R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250701132628.426168092@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751376421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=i+rYpaHQ/A+B/vV8jab08TqrZFqFKvErIYJvB81SlaY=;
	b=KXYdhH9EHGkB+BA04bYe5mq964v9rlKLUeE77Z5311CmjazorURDaGAHuXWr25yyL/NdWS
	uAcsj3BJqxAnEjzZn/mBIrQq5ws/4ge7rec9pS7O/e7GDu/cQuzHpyKDDZpPkORQ0N9Hh0
	/TmoRMG+HvJcr4Zzj1uyXGXkRfaDqXSt4cLS4d7TqkPmfE/D7cpL9GKXKvPZQPQwv4i1XN
	zDLZXFjj/QeINpIkcweAO40ll46lAzt8rcN+ydxmBOvculAlZ9yDPjucSuGL+TIS3NsuOh
	cuevmyXYVIxfbXm02VQGUtl3Nd5jtvlB55Bdij7r9vKf8euagVtL/fjnfI+IvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751376421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=i+rYpaHQ/A+B/vV8jab08TqrZFqFKvErIYJvB81SlaY=;
	b=P1S3Ax6RX/6eYUTc/7bjOthkf39IY85/at0Xqj44P0KMurW+Fy4+1LQKUWc4bD2jQbtp16
	jeWVCNp9BCzWMHAw==
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
 Antoine Tenart <atenart@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [patch V2 2/3] ptp: Use ktime_get_clock_ts64() for timestamping
References: <20250701130923.579834908@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Jul 2025 15:27:00 +0200 (CEST)

The inlined ptp_read_system_[pre|post]ts() switch cases expand to a copious
amount of text in drivers, e.g. ~500 bytes in e1000e. Adding auxiliary
clock support to the inlines would increase it further.

Replace the inline switch case with a call to ktime_get_clock_ts64(), which
reduces the code size in drivers and allows to access auxiliary clocks once
they are enabled in the IOCTL parameter filter.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Acked-by: John Stultz <jstultz@google.com>

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




