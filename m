Return-Path: <netdev+bounces-127384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162519753F3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEA9288C5A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A551A3024;
	Wed, 11 Sep 2024 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hcgx5shT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mTykQoqQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786F19CC38;
	Wed, 11 Sep 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061405; cv=none; b=uCkoEvwIc99lBfc9XsfWva/iYUS2r/QT3lvlSu22WiIZ4gArXsFbIkcLXUxIJxYMAiw5lyfWOSWsKfCrisHvsCgnBPEqEcGrYr74Bl6+tR4Y92UejD6hPQpJnf1qKBt4wgxAOWVHm0RrWl4Hqua+BOoP1hEwzBFFAZu1xSAHTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061405; c=relaxed/simple;
	bh=+/aatAAiCH15R6VhkwD1iHjBqaQ+y686NMi5tV/lbM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mc/mO5x/W6NoVJmlGk0LShChUIqj8ch9lgoaZ7quDYmyu4LOmX8sUU9zajVzpvH0DJ1Bc1sKMWIfZWM8bjoU7C1/Ay/NnP37tauWMu2VsFdwaM4Fpdb+MyeCjBluvAyNovOaiajIgbQtuBJeQNfaOTIuquoO1nuBU3pRpCpoKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hcgx5shT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mTykQoqQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JF7nVikN+HjS8VpIH1kU477XnGTf/XwkOQenK2xlllM=;
	b=hcgx5shTMy9PKonKL10+O0zDf7HcpC6KKwx/Bl4CHTQyqtyJqoRMCrHu7Gv7g2mhC8yerA
	9mQSCkk88NFe0C2uB8uRuB4TR9VkwejtlyXV6zBinPZeYalmc2uSx+ZMB1Qi8yWXRFUgjF
	SaLFD11QKQP1WFwSduINJGmV/QmUFETg7XyP/qALVQQVxhE11mlhsCtXYQztCy2ZO0Akod
	YID7ZqjZhtqfsMT9UtoQJlpfz4S1fRTHKgUh6rXFqGEO89Oa6uIixlQ3J1SpGapuv378hq
	lQQtdCdg27KpXaNj6Ylfmgby14RF3BqnhCtpRG2JXlCRlwvUqCsGnDGMer1AZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JF7nVikN+HjS8VpIH1kU477XnGTf/XwkOQenK2xlllM=;
	b=mTykQoqQ/rFTp24vM45Zw3vIr9bHy7OHzyNAoVno4IMOUh4PlyWg5ZQtpGaYCyY2O7RrGJ
	rjhqLPRGW8RiS8BA==
Date: Wed, 11 Sep 2024 15:29:47 +0200
Subject: [PATCH 03/24] timekeeping: Avoid duplicate leap state update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-3-f7cae09e25d6@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

do_adjtimex() invokes tk_update_leap_state() unconditionally even when a
previous invocation of timekeeping_update() already did that update.

Put it into the else path which is invoked when timekeeping_update() is not
called.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f09752bae05d..bdc4a6fe040d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2594,8 +2594,9 @@ int do_adjtimex(struct __kernel_timex *txc)
 		__timekeeping_set_tai_offset(tk, tai);
 		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 		clock_set = true;
+	} else {
+		tk_update_leap_state(tk);
 	}
-	tk_update_leap_state(tk);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);

-- 
2.39.2


