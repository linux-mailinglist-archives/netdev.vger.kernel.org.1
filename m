Return-Path: <netdev+bounces-190193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5B8AB5837
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F208C7ACD75
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C82BF999;
	Tue, 13 May 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JJXFwiG+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G1SVjBGk"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568C2BF97A;
	Tue, 13 May 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149197; cv=none; b=q6gzkRFpFN12bkBwb248gK05DaYU5IWDi2Okvi6m/6ez6uMsttZ/ywXdNTXK1tOODnu9OdnzHB0+BuxTXGjTtw9DhUdsQNYhA7e1sxaxZeGaAgQIoyTjy1kl2z39/s8mhovhxJYUMEOgL13HiwwHIwH+ESZrorI7lf7+eK6vApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149197; c=relaxed/simple;
	bh=cQGO/ovmi8i2iRU2Z3kxXxA6wSOAvbYSAmle/UPq1gg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=WIshCPiH4kc2nQuVgDg3P278/7XGSsl/8+VH89Q8wUwP0E3v06FLDf3VVkvF4MHrAY3xAbaGZ4mS/5Etmi0oGGQUklPxEN/olvXn3XJzplM/AXtoasOhljnY7ykdYzzKuvPr37w5e2u5juF1CtZkJO7fySzcvVNGSgb0RlVo0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JJXFwiG+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G1SVjBGk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.269189575@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TEV58ThXX4TBUZI1Gy/a/wWIqOz+0plScOcb5MlAa40=;
	b=JJXFwiG++gZucr3fnGMd8TIVzC11VmBYMU1gcng2pmXLNe0VvbsLtDTiq87G/a61XXJig9
	p94+WwFj+wlDALl31tqq03HPgvKitwt06k8vBNJ5AITWBZ3KE3pDIik2yFskV8bz8KHhfq
	xxT9w3PMljuxw+3mWIHTO0c4NigVxKl651J2rFEI2qhY3oeqfxoKV6Iy3+41WJhIddVSOt
	g5JHpPlaWVVliJ5HcA6lRIm3XUQoawp6UqYMwQtv1HnzUrTB3Gz9Yt8XYuIyz1u54MVuPv
	jT0pci9P6AUOqNrlPHV0PTz5KII+E3Xyl919ULbrEAHHaoz2nJDn+YUvSKxPoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TEV58ThXX4TBUZI1Gy/a/wWIqOz+0plScOcb5MlAa40=;
	b=G1SVjBGkQM5qzWAvLjNqX+JHx6zSCi+j/vqjgoOxVSdFPQSPuTU6QFprenN3dO4D9RNYt/
	ELrZ3Ja6guEAJQAg==
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
Subject: [patch 10/26] timekeeping: Prepare timekeeping_update_from_shadow()
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:13 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Don't invoke the VDSO and paravirt updates when utilized for independent
PTP clocks. This is a temporary workaround until the VDSO and paravirt
interfaces have been worked out.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -683,13 +683,15 @@ static void timekeeping_update_from_shad
 
 	tk_update_leap_state(tk);
 	tk_update_ktime_data(tk);
+	tk->tkr_mono.base_real = tk->tkr_mono.base + tk->offs_real;
 
-	update_vsyscall(tk);
-	update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
+	if (tk->id == TIMEKEEPER_CORE) {
+		update_vsyscall(tk);
+		update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
 
-	tk->tkr_mono.base_real = tk->tkr_mono.base + tk->offs_real;
-	update_fast_timekeeper(&tk->tkr_mono, &tk_fast_mono);
-	update_fast_timekeeper(&tk->tkr_raw,  &tk_fast_raw);
+		update_fast_timekeeper(&tk->tkr_mono, &tk_fast_mono);
+		update_fast_timekeeper(&tk->tkr_raw,  &tk_fast_raw);
+	}
 
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;


