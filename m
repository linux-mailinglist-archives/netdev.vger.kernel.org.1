Return-Path: <netdev+bounces-191427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91091ABB77F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0394D3B27B8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F18F2750F7;
	Mon, 19 May 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="feMAx2Pc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u5Sd0nyM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1644274FE2;
	Mon, 19 May 2025 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643624; cv=none; b=I5Bh4Xpc+OMbosbnT1Vbsh7nemFD7LM+1tK1VrPZjVYYOBsogIxZOVFicdlxR67HqaUuH5gXokCuybSEHYDwlbv6PYe52EBDP+iITsaSoXUmxr1SiTl6gFFTS4ilCROgG5Kp5y8p7c/USkzPU6nFaGHx1kqrJwMVXq5ZaoPTOAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643624; c=relaxed/simple;
	bh=nFcMK+6lPZe+YpkhPLYFJyLJekReTYSnzfGNuzN6WJk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RYATq/tUBa6qmmhi5M3wT37u4Ug2ATyayJejdnNDul5YbL/gUMLZWN6ic09rwf8IlDuDR/QrEAkzQw7SR8PuHxEPI9WzLB0MidbI7M2IIpaPA6QfHVwH73NdprGmTD6ThkH7WIWcpBxO3W4EX2R9RbDOGlsarbrZBv2tDflzkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=feMAx2Pc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u5Sd0nyM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.902859779@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BlCFLlYGEJMn/hJAuqbje0heodY/q/pXL2lfUeZb078=;
	b=feMAx2PcECUhCm9/UTStnSM/24poCWSQqc/2FgsgkT+Q+LpN3pc2fmiPWiFlUT/ucTyRNe
	NxJn8GlYAYH/6KScsfdJowCjEBdEa0aIBfvZ3JO2GfbFVk5zelTol+JucXC+GeEbJqpMgD
	2OhafMeDOluq4C+BcRuA6C4O9JDzqL5oH9eeaf03q3ZsFXQKUShDLbALXfKwLTyLC6nkD2
	cMsOw6GoEAEhYN8ewsYe5ldEMFn1PvkWuxsgP9ANYDgUtKSi+rkc5Duelv+JUHksLLVdxe
	053YtoNcs2ffUB8T9KVQf6IjqQkJnPoUZFQIy5oJrzB0GU0Uq5q02qkpG9Ne1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BlCFLlYGEJMn/hJAuqbje0heodY/q/pXL2lfUeZb078=;
	b=u5Sd0nyMQEgf5OwVEWBuZ9USopGkGyjW7Z9wiqBsDcTxfMcMqIxChsrcez4up2/g1/bj24
	FnP4aG3dhV5LK4Cw==
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
Subject: [patch V2 21/26] timekeeping: Add auxiliary clock support to
 __timekeeping_inject_offset()
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:40 +0200 (CEST)

Redirect the relative offset adjustment to the auxiliary clock offset
instead of modifying CLOCK_REALTIME, which has no meaning in context of
these clocks.

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
+	if (!IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS) || tks->id == TIMEKEEPER_CORE) {
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
+		offs = ktime_add(tks->offs_aux, timespec64_to_ktime(*ts));
+
+		/* Prevent that the resulting time becomes negative */
+		if (ktime_add(now, offs) < 0) {
+			timekeeping_restore_shadow(tkd);
+			return -EINVAL;
+		}
+		tks->offs_aux = offs;
 	}
 
-	tk_xtime_add(tks, ts);
-	tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
 	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
 	return 0;
 }


