Return-Path: <netdev+bounces-191431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84321ABB788
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CED3BBE61
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827A27781E;
	Mon, 19 May 2025 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3QQh7B/J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="prdP/94x"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74526A0FC;
	Mon, 19 May 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643628; cv=none; b=f45skPl3C8tlgJisSSQYzeYyDn/rMzjOgAoUXRn9DGfFTP1xWbCyeR81uNjTWQrVrFtn6O+7rfhR+rD4nceEyt6XuGVV+BTk+rXrTFaVTgVMk18B6+YpX8txkpr5AfJ0pmPzQvNQsI+Vv+BjWrsUC9G+HfkLK/cxqIP+m4NK4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643628; c=relaxed/simple;
	bh=pwZXtl/WvAETVW2Q9kzZx42EnMu4I6m9m2c2dTOLLAU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KX6N4i8ftyYB+OqxOUcEOqVxv60s4Km2ilPzI6U7bBXKOjGP4YVtWdTftqjLF7torMoQ/BpQSb8d307LXN+rGEpUipYPfaltH1ESAJH7w9OVqDaZoiEXgaJvpK0WifR7pVhWsxvrruE1mTdj+bSMCag5lCR19Wn5DYtqjSP+lKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3QQh7B/J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=prdP/94x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083027.146958941@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PCA8zcYARmCtjK0DZG8HOTyBlYYfkMraqZDIC30JbuM=;
	b=3QQh7B/J2X7PG2PHnvqTeLRKRL28cid3zt9CtR6doa/32ySyBx4LDPuJrkljQoawQ/uLxF
	u3gIjcAfJzClEB3glfYaR+CnzXVwsasSEQMeIQWLWZcnyICGhgkjO2PnZ2h8HMDrtglC69
	fKQEyjyK7nfLAPZHVw1GFrq4Q6Y2m7YiKCf1LPUqKey8jo8XV2MKP6307BcUE0jHwLCEB3
	3u9Zm+V9BlufZuZZKjk+5OWmpX2sqeZEYb/oOAC1bq2YbQvrnFyssZ/btVGVNm3nNPHGqJ
	EpByuQz6ruEVBPTJEZsDWP3YsYdW4YrH4IdoIEKuWLPlvyDSlZdpcmmhmbLxFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PCA8zcYARmCtjK0DZG8HOTyBlYYfkMraqZDIC30JbuM=;
	b=prdP/94xr3oBJJsoVGryQaTzpivn1oQLX5k7XXf/iMU7ivv8X7YYRp5xJHtP8h9bDKVMhR
	db03X8I5U6nCHbDA==
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
Subject: [patch V2 25/26] timekeeping: Provide update for auxiliary
 timekeepers
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:44 +0200 (CEST)

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
+		struct tk_data *tkd = &timekeeper_data[id + TIMEKEEPER_AUX];
+
+		guard(raw_spinlock)(&tkd->lock);
+		if (tkd->shadow_timekeeper.clock_valid)
+			__timekeeping_advance(tkd, TK_ADV_TICK);
+	}
+}
+
 /**
  * ktime_get_aux - Get TAI time for a AUX clock
  * @id:	ID of the clock to read (CLOCK_AUX...)


