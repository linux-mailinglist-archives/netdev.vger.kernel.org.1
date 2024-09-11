Return-Path: <netdev+bounces-127358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655A975368
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A831C21785
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D49D191F8C;
	Wed, 11 Sep 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PDaUN+uT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xbnGAfVX"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9761885BA;
	Wed, 11 Sep 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060680; cv=none; b=EIGEZlt2RGXikXd44MSsLYGdlkSnG5is4X8MKtTpsbs7iTLp1b8Fw6+apEZTzyoAeEnJ8KYfJNFqhitlBUB3mxH6WIktIas1T8xBoqlbwW4s9yKuBKOB77OuUE8ZYHoyVOl3WotypGeA2nBLm10JsrjsOm8o37H6sElvu0N/fbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060680; c=relaxed/simple;
	bh=Gs6TIXLeUjG4fKw4xPe2jcwyoi6PVKidrGkI3LXAN38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATAv4T6pClz2f635dVJWRZesNgZ9Xi9EkkOZCmVQXdeNla33DmJBGRGxCyncSQ2jm53qHng7NCngT8gAEcxViGzPO5iEwgprzncnrfkfb4Lu7HlIGd/FDlcufH6s1rIHAgIOTxVwsUjwZARk8MJU8yS+dEPflysMbPjy9rLMLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PDaUN+uT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xbnGAfVX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CupHS51cjv4Y/d3KwHj+m1FSExruPPTR+LTby/r2ODQ=;
	b=PDaUN+uTjH4ELqQ4E891Hj1lfMWWCGwdfx7r0+knTdAliu/TT84ZQAoZtd6paEY52W85O7
	lo2qeF9DbCk9VzX6dcM1/TunGKouWNfDEPfw86ZqONG4mKK/cUbxIhZFWofBmkhR90+RCX
	aYSnbB5Lj8Jh2wOrITdn8cwUkzcsaEa13CzQQKYnNJKYZqEFwJr88GuzdtTDFFgA2T9nbE
	I4ud10/aoJP9oyHx3gSD2A4Ze7ISOachYVJ42H8UooBw5eeJQ43Hi104oOGqVWOFyqhaOb
	c9qNpzVx8nlfSBl2XPCVKzKB7sC+8CSpNyq/sBtlCYumfi5Gjo4DsO2K9N6bOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CupHS51cjv4Y/d3KwHj+m1FSExruPPTR+LTby/r2ODQ=;
	b=xbnGAfVXFq7LvnwN26eT5oQHcQ6arWsSAyg+alVSlXnaM7fPDOdJpHZYgdITECH1jg/4mQ
	FEAEjWtYEvBggFCw==
Date: Wed, 11 Sep 2024 15:17:38 +0200
Subject: [PATCH 02/21] ntp: Make tick_usec static
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-2-2d52f4e13476@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

There are no users of tick_usec outside of the NTP core code. Therefore
make tick_usec static.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/timex.h | 7 -------
 kernel/time/ntp.c     | 5 ++++-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/timex.h b/include/linux/timex.h
index 7f7a12fd8200..4ee32eff3f22 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -139,13 +139,6 @@ unsigned long random_get_entropy_fallback(void);
 #define MAXSEC 2048		/* max interval between updates (s) */
 #define NTP_PHASE_LIMIT ((MAXPHASE / NSEC_PER_USEC) << 5) /* beyond max. dispersion */
 
-/*
- * kernel variables
- * Note: maximum error = NTP sync distance = dispersion + delay / 2;
- * estimated error = NTP dispersion.
- */
-extern unsigned long tick_usec;		/* USER_HZ period (usec) */
-
 /* Required to safely shift negative values */
 #define shift_right(x, s) ({	\
 	__typeof__(x) __x = (x);	\
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 0dba1179d81d..8e68a85996f7 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -31,7 +31,7 @@
 
 
 /* USER_HZ period (usecs): */
-unsigned long			tick_usec = USER_TICK_USEC;
+static unsigned long		tick_usec = USER_TICK_USEC;
 
 static u64			tick_length;
 static u64			tick_length_base;
@@ -44,6 +44,9 @@ static u64			tick_length_base;
 
 /*
  * phase-lock loop variables
+ *
+ * Note: maximum error = NTP sync distance = dispersion + delay / 2;
+ * estimated error = NTP dispersion.
  */
 
 /*

-- 
2.39.2


