Return-Path: <netdev+bounces-127394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14197540A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A33B2931D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF881AC451;
	Wed, 11 Sep 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7bQGwF/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cj9j3dOf"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785CB1AB50B;
	Wed, 11 Sep 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061411; cv=none; b=frHEn2nLs333FWHyNiGO8N6OEFjD1n36p0lF9Auby4EiH7NBC1MTqJa6KR20feTEFHA8tgXj94BdkkQ07oi9wrI5suNuozMyLaVVfGS3dmaujXGigkFHeHf2DSXmb2q5MfeompzTxL51gloYoKZo3x3Jm6OHHoN0Uz5oFH4nkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061411; c=relaxed/simple;
	bh=Zap0Yi50WGWo/Qq3DJFBEab4/jczvRrU1rzrv+RNAB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFmuvSu4m0xofWYHm885FVkA/01bhIjzhHH7UGJ/AQIcwxYtbiQNwahT8/b/5YYsn7Q54WWvTU7UL1va27wsaRl2DPO8gP1T7WxlHUAkka+TYy9WP9l2HY0vuMRXb3il5OGmF1g7oiTfn9Jlq7/ad7JsVtxsS8QdWmMI25qXb3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J7bQGwF/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cj9j3dOf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEUQhs/7XdMxctBGjdLZslFFIm8tsdgWFqBbte1umNA=;
	b=J7bQGwF/Ykf28YVcZIS/+8zktL8XcNHsqMvkuTWiP6VJKqspZ9unfDb7s0kNm5Bam8IhJF
	y8jYkGXtHMTz5rYbdC8ChX0323fNdXVQqD1+JqYYVOQYeX9lrzsWK2xv+cW6sJI32vUC7v
	AZR/TPbCmiZIn40wxG0ilGpYN4Y88hIZle5SGWa9BrFL3xj2CZ5rMpf65sEO9XRZSZ6ETa
	aGctmm2UYSaqCkKnssz9xiypkzC/sqPeSSMRi8UpMAZ3X1Ln2KzxqYV87YSUpgNFTvs2Dl
	oU4sXqkuYwl6j+Gdm+ctz71+T+WdwczuvZpk91TCtwx/3kpl29+EZzmHVfLlEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEUQhs/7XdMxctBGjdLZslFFIm8tsdgWFqBbte1umNA=;
	b=cj9j3dOfp6KG27Eo/id/h5JmNkTq8HL3W1p+pOwGAPymc1qaUwzP4DkH7waM1N0Bg4n16R
	Svk0BycF9KuRhYAQ==
Date: Wed, 11 Sep 2024 15:29:59 +0200
Subject: [PATCH 15/24] timekeeping: Rework do_settimeofday64() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-15-f7cae09e25d6@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert do_settimeofday64() to use this scheme.

That allows to use a scoped_guard() for locking the timekeeper lock as the
usage of the shadow timekeeper allows a rollback in the error case instead
of the full timekeeper update of the original code.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 345117ff665d..efcfb0da351e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1479,45 +1479,35 @@ EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_base);
  */
 int do_settimeofday64(const struct timespec64 *ts)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
 	struct timespec64 ts_delta, xt;
-	unsigned long flags;
-	int ret = 0;
 
 	if (!timespec64_valid_settod(ts))
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-
-	xt = tk_xtime(tk);
-	ts_delta = timespec64_sub(*ts, xt);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tk = &tk_core.shadow_timekeeper;
 
-	if (timespec64_compare(&tk->wall_to_monotonic, &ts_delta) > 0) {
-		ret = -EINVAL;
-		goto out;
-	}
+		timekeeping_forward_now(tk);
 
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, ts_delta));
+		xt = tk_xtime(tk);
+		ts_delta = timespec64_sub(*ts, xt);
 
-	tk_set_xtime(tk, ts);
-out:
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+		if (timespec64_compare(&tk->wall_to_monotonic, &ts_delta) > 0) {
+			timekeeping_restore_shadow(&tk_core);
+			return -EINVAL;
+		}
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, ts_delta));
+		tk_set_xtime(tk, ts);
+		timekeeping_update_staged(&tk_core, TK_UPDATE_ALL);
+	}
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
 
-	if (!ret) {
-		audit_tk_injoffset(ts_delta);
-		add_device_randomness(ts, sizeof(*ts));
-	}
-
-	return ret;
+	audit_tk_injoffset(ts_delta);
+	add_device_randomness(ts, sizeof(*ts));
+	return 0;
 }
 EXPORT_SYMBOL(do_settimeofday64);
 

-- 
2.39.2


