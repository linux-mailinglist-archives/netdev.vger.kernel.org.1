Return-Path: <netdev+bounces-201303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32041AE8CBB
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541495A1CC2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56162E424D;
	Wed, 25 Jun 2025 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1gLUyO0W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="azNXTnOV"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0D2E173C;
	Wed, 25 Jun 2025 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876731; cv=none; b=XdR55Mg/vnSLCpZOr/iuB/ONYrWk+sDR+b6/2Adj6yV1N/L98E+KSbWv8iw6F6jmHkfRVggn2lYGlaBKtulgfiaGze5twVHz7DHnpEtQL0wNMWiWMKeHkkAHtUO3YVr1AMYJKQU1p2IP4j1CrfGMHqu2DW8awUpByfdTcJ0jdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876731; c=relaxed/simple;
	bh=dlw8KDSGu+ehPJAe+navRVPjiPuj28L8LmFkc1hGo6U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FPkiJ3nes3nmcsXFLAFzh1ORaC4U2BP/ew/0H7cCH5TtnFcyhQoFWie0L1jCcm6+Pnm27Zx0S+kPegqkejox5qwFcKCw7M6QjxsJsvqhgK4cMy80ZcKNY6Ev4FhtODGfAjxukL56D5Tsn7amU8t2cof3wdbqE0hWGsmPejuwneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1gLUyO0W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=azNXTnOV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625183758.382451331@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rgazCkd3u3F5i4CrLdkq+/PjRiwjzzoSmk6V32qkK3I=;
	b=1gLUyO0W1GJamInYQ2FeJDYwutkPTRLou2YJcNFHXCXJKBlEEO6K7HoQzL3qdoNzl9qV2P
	j7/iPeSyM/0c2wV2KUcc7mCYx4drBGhB9paoRLI//gMxjLxAZaZrXcmjrIUIzubSA17zna
	f0dqi2H9tQG3bcC4tI2WwnvL9yyrmxvAIv5TK96PHJV3gGNGtsEH7tCGHN0LOKvjGAYYXr
	CqzJooFRLbcyLGuHHgLqpSD1EUlK92S5v2PGOMv4YcopeUOIv5Jxm8GvJnl6oEAdEVQsa1
	5fJg6aZsfbrB3+BAYzJSfnFX+1eW5GyRUIok28YW+h8pVcv5h7yz7WcThPJKVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rgazCkd3u3F5i4CrLdkq+/PjRiwjzzoSmk6V32qkK3I=;
	b=azNXTnOV9H7Fx2+NFomVcQD0LzodKYeFxbrd8WBXpqpAWI1XVJrPEwRTwBME1GD7dZaI4E
	Ctr0D6DRh0T8OHAA==
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
Subject: [patch V3 10/11] timekeeping: Provide update for auxiliary
 timekeepers
References: <20250625182951.587377878@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 20:38:47 +0200 (CEST)

Update the auxiliary timekeepers periodically. For now this is tied to the system
timekeeper update from the tick. This might be revisited and moved out of the tick.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
---

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -131,9 +131,11 @@ static struct tk_fast tk_fast_raw  ____c
 #ifdef CONFIG_POSIX_AUX_CLOCKS
 static __init void tk_aux_setup(void);
 static void tk_aux_update_clocksource(void);
+static void tk_aux_advance(void);
 #else
 static inline void tk_aux_setup(void) { }
 static inline void tk_aux_update_clocksource(void) { }
+static inline void tk_aux_advance(void) { }
 #endif
 
 unsigned long timekeeper_lock_irqsave(void)
@@ -2312,11 +2314,13 @@ static bool timekeeping_advance(enum tim
 /**
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
+ * It also updates the enabled auxiliary clock timekeepers
  */
 void update_wall_time(void)
 {
 	if (timekeeping_advance(TK_ADV_TICK))
 		clock_was_set_delayed();
+	tk_aux_advance();
 }
 
 /**
@@ -2762,6 +2766,20 @@ static void tk_aux_update_clocksource(vo
 	}
 }
 
+static void tk_aux_advance(void)
+{
+	unsigned long active = READ_ONCE(aux_timekeepers);
+	unsigned int id;
+
+	for_each_set_bit(id, &active, BITS_PER_LONG) {
+		struct tk_data *tkd = &timekeeper_data[id + TIMEKEEPER_AUX_FIRST];
+
+		guard(raw_spinlock)(&tkd->lock);
+		if (tkd->shadow_timekeeper.clock_valid)
+			__timekeeping_advance(tkd, TK_ADV_TICK);
+	}
+}
+
 /**
  * ktime_get_aux - Get time for a AUX clock
  * @id:	ID of the clock to read (CLOCK_AUX...)


