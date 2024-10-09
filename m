Return-Path: <netdev+bounces-133530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA49962C9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B743281224
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67E81917ED;
	Wed,  9 Oct 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ILGBnHgS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5yrMPzp0"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E518F2C5;
	Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462565; cv=none; b=a4vxjwRSQZmS7+HnQwy+zhduIjyRlyfD0Pgw8Yqp3QpRVGoaGaOp2OLbVCM0/CMHJdijE6Qj1o3kOZ/j3v2I3FICpHjPMF8WgJgYy9VTdwxkzAl6nJ8kZO1R5tazoQyw5jN36S04GXLcNgdnwXhhX27u7W03RxkVsPJA3xVa0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462565; c=relaxed/simple;
	bh=WDO3Ytc4nrYwYDexC/hZyP3VzuTayhrvdBH51HROiRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwKe96EevdIeaoFv7XHuJ2HRDBfTW1vRlS+PB670E6tz7qmzpj6a+Kn/LgZFVEVs7qV9MSqzz94oYK4cSusGrq4tqCSuD63ArmxriaVD4oqG+qgjq2IwtsXf5gnM5EZ5kepAyFLndZuarQgMI850WyvyhPZkZ76FKGoWNthaJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ILGBnHgS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5yrMPzp0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO9lJ4hSftezkW1I9W2pEnXRBh82ke3Ir/FYPjmdFQA=;
	b=ILGBnHgSrrLIhi25h9e7ZIZIi4daXPW80PgxWgepOKxU2d0QXUjUS4Z0OeAWmlFS6jLOtM
	FFlERkiPKafxhBHsOtMH5uOymkmSSgiADQq0h/Fdji/4CSjFcYiYXwIi4YSwbkNkhHh4BF
	hQqTGPlngjHHqIeiYWuWCPdpqxNGF2opRCN2kxFB4YCLboOrR4I/hxkloW+ukY2Al9Hpft
	3RA7NaGRzDUdJ83Ijroinxi4qhxbSZY8K2pppLUlx5TBaDxh9W70ArvKNq3xROg5dac93e
	0uFoh+G/LC2yCqdYjSel3LAZZqakmoKoBmFEK++oOQoAltuBsV0zg3jNXSIPUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO9lJ4hSftezkW1I9W2pEnXRBh82ke3Ir/FYPjmdFQA=;
	b=5yrMPzp0wLf7oBogJPnocNULhLeWTDZDmUixeWyUuS0pMK2ggsYjrkD0P4LcidGwl9k2sN
	32UIBLIJtfKl2bBg==
Date: Wed, 09 Oct 2024 10:29:11 +0200
Subject: [PATCH v2 18/25] timekeeping: Rework change_clocksource() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-18-554456a44a15@linutronix.de>
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

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert change_clocksource() to use this scheme.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 051041e92e54..6d21e9bf5c35 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1596,9 +1596,7 @@ static void __timekeeping_set_tai_offset(struct timekeeper *tk, s32 tai_offset)
  */
 static int change_clocksource(void *data)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *new = data, *old = NULL;
-	unsigned long flags;
 
 	/*
 	 * If the clocksource is in a module, get a module reference.
@@ -1614,16 +1612,14 @@ static int change_clocksource(void *data)
 		return 0;
 	}
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-	old = tk->tkr_mono.clock;
-	tk_setup_internals(tk, new);
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tk = &tk_core.shadow_timekeeper;
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		timekeeping_forward_now(tk);
+		old = tk->tkr_mono.clock;
+		tk_setup_internals(tk, new);
+		timekeeping_update_staged(&tk_core, TK_UPDATE_ALL);
+	}
 
 	if (old) {
 		if (old->disable)

-- 
2.39.5


