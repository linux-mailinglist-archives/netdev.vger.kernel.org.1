Return-Path: <netdev+bounces-190205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497CAAB5859
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97D24A778E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FDB2C2AC5;
	Tue, 13 May 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fheNSDQK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y0ET2vDb"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280D2C2AA8;
	Tue, 13 May 2025 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149217; cv=none; b=ltymLq5YQYFKt7Eo2D30vPiWyToLyJNVcvgtQmx6rTELTD9+oitOGojvUAvLAvOmmxsi4xBHeOvoXP1HUIN5kLuNP4awgg2Ao/OIUpZQ4ue0x3LnSVpRDdNugpNm6M+V+i/62bc33qhL75iIVS0wGAKrki8qGoay0q+w72xlpi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149217; c=relaxed/simple;
	bh=q0OLLkf2kUwS/yqPJjKV/EGMjakB97BItyqHxvQT36k=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VehzDRxeP3Xed58cEtBoLBI1f1Lxou42ySPu1PZ6sKZOqDYsOxwkBTqBNx6tbtQ68CzTUVNUIMBtgDvfYEFAWJtz9oJ8WnSkgMTSa5DmWxLxNWpHycpaoPyq74HygP66b4Qj2ZBiYEyvE1bLK+OlmPai20Ro7uH2c7sBFKo0BrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fheNSDQK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y0ET2vDb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.919542613@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=c3VDQSpxT2VVjCswcVkkZBuHllPOrYNSkdgO67m/MB8=;
	b=fheNSDQKMNENPum6m4F9BC4fjQceYCWPNb8dCdG+bPOPj9Ug2Lkxkycai66yVCi6e+kJjW
	QeBhk5A8GuwExw7wPOj/VwUmsdg1kRq732ObIS3SKcOjlCkng3WrkvwWeGMIGHnNwjxUZD
	Q3hE2CKkvRY6jU1ytmoLBO9LjWf9xLtBHdZb2ndiLIqwF6RaSOyUHeCXxywFDvWKavKr/D
	3EFlqJ14goXPC2Tx1/T7/2Rc/wn3o/acJRs1NFkYPqsF7JuTFdcCEZQiCL6khg7HRGgs+r
	04m3kOChV+WYGjRX/x16PHy6FzESDI7TCoQyfacbtjAT26THi6k7FCrtQsYNCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=c3VDQSpxT2VVjCswcVkkZBuHllPOrYNSkdgO67m/MB8=;
	b=Y0ET2vDbQcr24pKUVwgttwD15oau71IAMWtEuLLmrTkI+VYLZe/9tuLQeioyakBAmWsB04
	cwlwejXWAqXiWfDQ==
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
Subject: [patch 21/26] timekeeping: Add PTP clock support to
 __timekeeping_inject_offset()
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:33 +0200 (CEST)

Redirect the relative offset adjustment to the PTP clock offset instead of
modifying CLOCK_REALTIME, which has no meaning in context of these clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1448,16 +1448,34 @@ static int __timekeeping_inject_offset(s
 
 	timekeeping_forward_now(tks);
 
-	/* Make sure the proposed value is valid */
-	tmp = timespec64_add(tk_xtime(tks), *ts);
-	if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
-	    !timespec64_valid_settod(&tmp)) {
-		timekeeping_restore_shadow(tkd);
-		return -EINVAL;
+	if (!IS_ENABLED(CONFIG_POSIX_PTP_CLOCKS) || tks->id == TIMEKEEPER_CORE) {
+		/* Make sure the proposed value is valid */
+		tmp = timespec64_add(tk_xtime(tks), *ts);
+		if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
+		    !timespec64_valid_settod(&tmp)) {
+			timekeeping_restore_shadow(tkd);
+			return -EINVAL;
+		}
+
+		tk_xtime_add(tks, ts);
+		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
+	} else {
+		struct tk_read_base *tkr_mono = &tks->tkr_mono;
+		ktime_t now, offs;
+
+		/* Get the current time */
+		now = ktime_add_ns(tkr_mono->base, timekeeping_get_ns(tkr_mono));
+		/* Add the relative offset change */
+		offs = ktime_add(tks->offs_ptp, timespec64_to_ktime(*ts));
+
+		/* Prevent that the resulting time becomes negative */
+		if (ktime_add(now, offs) < 0) {
+			timekeeping_restore_shadow(tkd);
+			return -EINVAL;
+		}
+		tks->offs_ptp = offs;
 	}
 
-	tk_xtime_add(tks, ts);
-	tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
 	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
 	return 0;
 }


