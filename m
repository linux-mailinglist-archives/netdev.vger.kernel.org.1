Return-Path: <netdev+bounces-190200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 654CDAB584C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4462B188F334
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D62C10B8;
	Tue, 13 May 2025 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IlN4cJWZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5kqH16Q"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BADB2BE104;
	Tue, 13 May 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149208; cv=none; b=UYL9TMZNDXZP8pGkFG+XGsHuQVCYVXh5R4ONwZuk7D3qHk1ZtXdGfDKqTsG/J21uEHpKVhfhocSbHkbzOpD0WRDXt3ZQIOtcjdcFonIepwwlXwqaVaIT9U9bSAiPQioIWY957x8EpssTwIWlcmoEYM+6RkAfsedVuIlew8dYzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149208; c=relaxed/simple;
	bh=/2HR3MTj/BexmwQI5vGzCFXQo8FFBtvur8fQXTcZstc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JalklNRYFhiaid+yCKa5cjxCs32Yv0G3dhm1yZUzaAKRxFl5ZiIq1ahMACWcUF06KdmMGaejTF4x7V9MuAFb35bx+U2yuyLTZe7og9h5RymAmEQLiv3wA0sZqvdxwPte88P1VfXwXEOHdnh/mn262WuIURRJLER6BPygZ4qHHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IlN4cJWZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5kqH16Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.623310147@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/NY1OD3UTfB7Efwoanw6NMCyC9WIGsZ7YVimvudzegs=;
	b=IlN4cJWZyngtmFmSCfybh/aNM5ShLaz2qawe49RxCujSqhPj9KRpBgaKEW6MQC/MMsZcYy
	yf72xgNgD/n9dXNlzjBfsKwNiPTwEks5lSfO1LTMXuTLwuUXDCfz/iTuU6eBMng5l5nlni
	JRUt3cHihplahPrkJHcpgKxxcLjAHOj2AmI7dtaAI95/AYLROz1v5+RG0V/SR5gKw+c1Lf
	vKknoGjM6sLApYOXaHQhTP5hXSIJkkmiKUXjK21gvOqDcdf6YNAkVwmpMHqk7A9tgskclQ
	ENwafnvXdk7O2KsTHQZL7RhY/eawUP6TYKrX4EdJNC3XaRxVSbXf9s5X/RhWlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/NY1OD3UTfB7Efwoanw6NMCyC9WIGsZ7YVimvudzegs=;
	b=G5kqH16QNDzFaAwUDTtl5dwOOi6to9Nwi0gcmTGwY0iW1FRikAsw620q69aLklcDuloU4X
	u+EkQSaA+tLDzMCw==
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
Subject: [patch 16/26] timekeeping: Update PTP timekeepers on clocksource
 change
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:24 +0200 (CEST)

Propagate a system clocksource change to the PTP timekeepers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -119,8 +119,10 @@ static struct tk_fast tk_fast_raw  ____c
 
 #ifdef CONFIG_POSIX_PTP_CLOCKS
 static __init void tk_ptp_setup(void);
+static void tk_ptp_update_clocksource(void);
 #else
 static inline void tk_ptp_setup(void) { }
+static inline void tk_ptp_update_clocksource(void) { }
 #endif
 
 unsigned long timekeeper_lock_irqsave(void)
@@ -1548,6 +1550,8 @@ static int change_clocksource(void *data
 		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
 	}
 
+	tk_ptp_update_clocksource();
+
 	if (old) {
 		if (old->disable)
 			old->disable(old);
@@ -2653,6 +2657,30 @@ EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
 
 #ifdef CONFIG_POSIX_PTP_CLOCKS
+
+/* Bitmap for the activated PTP timekeepers */
+static unsigned long ptp_timekeepers;
+
+/* Invoked from timekeeping after a clocksource change */
+static void tk_ptp_update_clocksource(void)
+{
+	unsigned long active = READ_ONCE(ptp_timekeepers);
+	unsigned int id;
+
+	for_each_set_bit(id, &active, BITS_PER_LONG) {
+		struct tk_data *tkd = &timekeeper_data[id + TIMEKEEPER_PTP];
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
 static __init void tk_ptp_setup(void)
 {
 	for (int i = TIMEKEEPER_PTP; i <= TIMEKEEPER_PTP_LAST; i++)


