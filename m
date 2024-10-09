Return-Path: <netdev+bounces-133524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C329962BA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906EF1F23C1C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C409618FC91;
	Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R1yQIBYc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SzauA7G8"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348318DF68;
	Wed,  9 Oct 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462563; cv=none; b=sluKOrwDyZLosmsplEwHqygqnKljYeVTeuw2KaXfcS6g/ZxPT5uNNAcqBY0hy8uuKr52wT+k97S/bRLmunBjXuBCuu9STHJ9nEw/NhPCSUUMcjYKbPzAo83VMEPVN4X/I0XbnIrnr04K9GB3xETZspfTgZMgTU7/HJbcEbki5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462563; c=relaxed/simple;
	bh=XgL8cfM/IWJXb5ZekypyN3VDBOsxqkLZwkvFEHABaYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJpNE+kM/4bppETQVMmexSq+DDwR7fVjm954/dNARibBQU9507twsimVpW1/ciLRuWzzLKlBMmY43kQFYdl902G5cC0cq4O9CSEfoZd835VxCPlUiWkB6ahcJtKP5gOx5GchRl4GWJWAZHDbWAbFl8WkUk03rM+kCHPQxZLAM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R1yQIBYc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SzauA7G8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DT27laaYnC7O8oK5GmcQbcmPPnUUBCGdfOGBs/sIYMk=;
	b=R1yQIBYcbfDDAyar1DjECFO2S+WteoEXatodGI1OS26Zo5Sqj9g8IQbHAGWuZyh7XS7j1e
	gKGOgQ+w5Eizb4Fui1Dg3PR8xpcXzDp4x7HZ76PSLFES9yXkxxbqNnXiuCDTWTpYszueTe
	4aWFNafU4HIMknVk3gJHX6nvYBR3IvGYQoEINh0Nw2t/xunw4W9v1m9+sTSOt+QhcD2Gf4
	WCyvAOujP8gXHdPz9nrlR5LDzcceSf/MgJ3LMirg27NhvCuWOMou9zLAD2SzJWECUbR/5j
	yFnYBM6Q7YlJqTucVSitCkCXYDCULQW6L8NF4xUujp+d3r8Jj9K+cvKZXluuOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DT27laaYnC7O8oK5GmcQbcmPPnUUBCGdfOGBs/sIYMk=;
	b=SzauA7G8H1YFB+Es4FrwX+NDz0ceFKpUkDy4MgwtMutxcVP1aYuB/XhiAne9hKd4oTmyye
	cMvkbo3pDrzL7NCA==
Date: Wed, 09 Oct 2024 10:29:06 +0200
Subject: [PATCH v2 13/25] timekeeping: Split out timekeeper update of
 timekeeping_advanced()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-13-554456a44a15@linutronix.de>
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

timekeeping_advance() is the only optimized function which uses
shadow_timekeeper for updating the real timekeeper to keep the sequence
counter protected region as small as possible.

To be able to transform timekeeper updates in other functions to use the
same logic, split out functionality into a separate function
timekeeper_update_staged().

While at it, document the reason why the sequence counter must be write
held over the call to timekeeping_update() and the copying to the real
timekeeper and why using a pointer based update is suboptimal.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 878f9606946d..fcb2b8b232d2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -780,7 +780,32 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 	 * timekeeper structure on the next update with stale data
 	 */
 	if (action & TK_MIRROR)
-		memcpy(&tk_core.shadow_timekeeper, &tk_core.timekeeper, sizeof(tk_core.timekeeper));
+		memcpy(&tkd->shadow_timekeeper, tk, sizeof(*tk));
+}
+
+static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)
+{
+	/*
+	 * Block out readers before invoking timekeeping_update() because
+	 * that updates VDSO and other time related infrastructure. Not
+	 * blocking the readers might let a reader see time going backwards
+	 * when reading from the VDSO after the VDSO update and then
+	 * reading in the kernel from the timekeeper before that got updated.
+	 */
+	write_seqcount_begin(&tkd->seq);
+
+	timekeeping_update(tkd, &tkd->shadow_timekeeper, action);
+
+	/*
+	 * Update the real timekeeper.
+	 *
+	 * We could avoid this memcpy() by switching pointers, but that has
+	 * the downside that the reader side does not longer benefit from
+	 * the cacheline optimized data layout of the timekeeper and requires
+	 * another indirection.
+	 */
+	memcpy(&tkd->timekeeper, &tkd->shadow_timekeeper, sizeof(tkd->shadow_timekeeper));
+	write_seqcount_end(&tkd->seq);
 }
 
 /**
@@ -2333,21 +2358,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	 */
 	clock_set |= accumulate_nsecs_to_secs(tk);
 
-	write_seqcount_begin(&tk_core.seq);
-	/*
-	 * Update the real timekeeper.
-	 *
-	 * We could avoid this memcpy by switching pointers, but that
-	 * requires changes to all other timekeeper usage sites as
-	 * well, i.e. move the timekeeper pointer getter into the
-	 * spinlocked/seqcount protected sections. And we trade this
-	 * memcpy under the tk_core.seq against one before we start
-	 * updating.
-	 */
-	timekeeping_update(&tk_core, tk, clock_set);
-	memcpy(real_tk, tk, sizeof(*tk));
-	/* The memcpy must come last. Do not put anything here! */
-	write_seqcount_end(&tk_core.seq);
+	timekeeping_update_staged(&tk_core, clock_set);
 
 	return !!clock_set;
 }

-- 
2.39.5


