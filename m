Return-Path: <netdev+bounces-190186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD89AB582D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341064650F7
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7C02BE10F;
	Tue, 13 May 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PTuw/Lp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yv8qNF4p"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3F2BDC21;
	Tue, 13 May 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149182; cv=none; b=NrtlKwWyZ9mwVtEuFUNnf6hz08s/eKU0EH3Mym2tmXzD8ThuxHdXSHTQ/iEZ70qoszdzR8V6NN8bO9XbxRk4Qial0u6CXrQYwSXZcluyS59NBB8IqA7udgOj4EBDSAHACIN5SRJ8tDGofC5eqTFZ1kJxqXgHJMMd3hy8FK5q7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149182; c=relaxed/simple;
	bh=wlpwNyknMfR1RoDXQOsQOLe9nGuz+tJKa17ta22S/mA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=C6iwNG3+9uSNHqnV6QZYUw6ns4H0eXzjWmOAcV1ZkMUtRdAs7v1lxwdPgRZvQTVR5SjPL/Aem1Qqi0eSSNq7QuJY3AV2q3zZmBzvFiAGaZ2D/QgXeLpb6R16sTwqeUgPxRoE0+jKlv0GTQnX7SmmNa6xoJv85l2rtdvyvPDLjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PTuw/Lp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yv8qNF4p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145136.789188877@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PLK3LOofu2itK9FE/VIdqa3Xxrw13vea1Zi9cuZZRM0=;
	b=0PTuw/Lp3X4Op/SjEz/31xA7jO0ZZnLGQzp9AsG0QUOfbxE8m44p9j1sKBJvi0TpiUqFbW
	BCBapiFNf0Hf60Smuf6MXEmr2NvCq189syMstHx1R8afPyvtriY+wXa0wtG+OyzNQcW2HF
	iXSuhckWF3JzRQ/iTOuwRX9+0IWf403v11hXQ93TM6BHS2Xb9j2jifP2tmx6mg0ct3m+r0
	h/VMGcJTCscd7Hw6vYNFxUcTE4ywcsHkwAie7up22LrdNhawNRJfnDIIjJNKMgyEO6pnt7
	2gbe2wLBPEeOz1cK5FteKo+0yN1mp23viS4n1fg6X8bVXRWnCpA7OmDchlnrCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PLK3LOofu2itK9FE/VIdqa3Xxrw13vea1Zi9cuZZRM0=;
	b=yv8qNF4pQFWbgKJeOVR5qe1q8cwIBsUHw10zzloRFjAIehDLAp1IShRMnRJ2kanIhMAdly
	p6Fcfgl7zrYYy+DA==
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
Subject: [patch 02/26] timekeeping: Cleanup kernel doc of
 __ktime_get_real_seconds()
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:12:58 +0200 (CEST)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -975,9 +975,14 @@ time64_t ktime_get_real_seconds(void)
 EXPORT_SYMBOL_GPL(ktime_get_real_seconds);
 
 /**
- * __ktime_get_real_seconds - The same as ktime_get_real_seconds
- * but without the sequence counter protect. This internal function
- * is called just when timekeeping lock is already held.
+ * __ktime_get_real_seconds - Unprotected access to CLOCK_REALTIME seconds
+ *
+ * The same as ktime_get_real_seconds() but without the sequence counter
+ * protection. This function is used in restricted contexts like the x86 MCE
+ * handler and in KGDB. It's unprotected on 32-bit vs. concurrent half
+ * completed modification and only to be used for such critical contexts.
+ *
+ * Returns: Racy snapshot of the CLOCK_REALTIME seconds value
  */
 noinstr time64_t __ktime_get_real_seconds(void)
 {


