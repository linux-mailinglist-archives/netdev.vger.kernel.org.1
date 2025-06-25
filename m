Return-Path: <netdev+bounces-201294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306EAE8CA4
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44603AA0D9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166A52D9ECF;
	Wed, 25 Jun 2025 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fCdPmwJR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Cyx31IM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58B2D540B;
	Wed, 25 Jun 2025 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876714; cv=none; b=LaaRh7+3nyWQKI1+yyFnuZCFfuXkHRrrGr1l4uNzMX93GvJqCdUrc6tsst2tLA8PRIor3dfAnUsHlV9tDfickhAI2LdcIBRPCthR/N3+Vvhev87M+VYUx1uW763Q+PQhgrg2O+kOyzdl7cn+DlwHByoMCM6jjE5O4uVy1Loldoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876714; c=relaxed/simple;
	bh=96e9cJKXFPDju4/QSz3RUdC00J74o8uGRyHcUOVWnN8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SRDg1B7NiGkA9kKgUY5CcdcP9nuHmvc/gKOcztiUUiiFqBsChD/HzjxlwsL4gj1pnrPl6gfv4GTL9Rzh9q3uRzDAWKh5QPmXiX5jFE4QmjnXKUmXo0q3EM6HR2E1RIn22/gXd/haVwpzfZOL4zXG/A9l62EZ+1ydGMpUxRQISmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fCdPmwJR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Cyx31IM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625183757.803890875@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SJrzO2St6DYrac8L0oTt1CLLzIVb9v9DvCiT5mXNVHY=;
	b=fCdPmwJRg7Ou2R4hHzMxhWnOPrZgDleYTMjSd/DcmB/d9Xu8+2O3QWSYF8QcI6OadknX3q
	7FpyZWxmWLn5SymB+NVBqp3YQF68rUg+SATplPniamuvgNLTPrmza+9R5W/GMel0BnuVnq
	4SVUbEJ58J/c2o9pguJCH+U7UaTnaiewkYJzW8T+1gzPdgb+77YZyRpEsp5hnipJqIuBs7
	XtTzpDjH121XIy/w2Z0lSL1M/on2YuHeVAQfZ6eUiv+o1oXHbvs9ju81XO5AwssI18a+JE
	uMjjRlilLp0FllCUPDUUErgZvWz7gjEx4OjO4c4NMJc7ayuNbPC5bh80N/PQrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SJrzO2St6DYrac8L0oTt1CLLzIVb9v9DvCiT5mXNVHY=;
	b=+Cyx31IMUHC8B125ju7SNCfyAAxBtEY//FGD0F2HUgWll/CpH4QMghvxlfE0B3r5PmQ1MI
	ktxNhZx7bo2uejDA==
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
Subject: [patch V3 01/11] timekeeping: Update auxiliary timekeepers on
 clocksource change
References: <20250625182951.587377878@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 20:38:29 +0200 (CEST)

Propagate a system clocksource change to the auxiliary timekeepers so that
they can pick up the new clocksource.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
---

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -119,8 +119,10 @@ static struct tk_fast tk_fast_raw  ____c
 
 #ifdef CONFIG_POSIX_AUX_CLOCKS
 static __init void tk_aux_setup(void);
+static void tk_aux_update_clocksource(void);
 #else
 static inline void tk_aux_setup(void) { }
+static inline void tk_aux_update_clocksource(void) { }
 #endif
 
 unsigned long timekeeper_lock_irqsave(void)
@@ -1548,6 +1550,8 @@ static int change_clocksource(void *data
 		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
 	}
 
+	tk_aux_update_clocksource();
+
 	if (old) {
 		if (old->disable)
 			old->disable(old);
@@ -2651,6 +2655,30 @@ EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
 
 #ifdef CONFIG_POSIX_AUX_CLOCKS
+
+/* Bitmap for the activated auxiliary timekeepers */
+static unsigned long aux_timekeepers;
+
+/* Invoked from timekeeping after a clocksource change */
+static void tk_aux_update_clocksource(void)
+{
+	unsigned long active = READ_ONCE(aux_timekeepers);
+	unsigned int id;
+
+	for_each_set_bit(id, &active, BITS_PER_LONG) {
+		struct tk_data *tkd = &timekeeper_data[id + TIMEKEEPER_AUX_FIRST];
+		struct timekeeper *tks = &tkd->shadow_timekeeper;
+
+		guard(raw_spinlock_irqsave)(&tkd->lock);
+		if (!tks->clock_valid)
+			continue;
+
+		timekeeping_forward_now(tks);
+		tk_setup_internals(tks, tk_core.timekeeper.tkr_mono.clock);
+		timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+	}
+}
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX_FIRST; i <= TIMEKEEPER_AUX_LAST; i++)


