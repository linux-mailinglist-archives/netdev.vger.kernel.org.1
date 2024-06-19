Return-Path: <netdev+bounces-104759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F21E90E454
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472941C221D8
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043C07F7F7;
	Wed, 19 Jun 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2XjrxS7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqTkAmLs"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B67C6C9;
	Wed, 19 Jun 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781807; cv=none; b=jvdCEDlJQL0S3MUwTDf0A1+wZ9ys6PDQhULU2BgpBkywalOoeyorwwp8jQrrEerYQqVfpwK9PWL0vZZK5Ao3vR8Pg8AJdwl7Z3wcmXG4AAptFD6Mn9Ltu/1OMVYKFY4VJprp/Smcf0uCOG+kBBv0NdxljdINwcLcVQ3dP/ilKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781807; c=relaxed/simple;
	bh=pSf/Z0JsPY9xuccDTq3qRsA+msduJP12GujlmQ1ybu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo20xSI/hfv2/mRANgWQU457PBtyK9DIGzgNlGRTWnCQRJx6F466eXTpx9JRALSCeYByhJdDmaT1ZGG9DbKCNnlQrZYWVSVOdKlXEamqCLJI7Sa4MBj060d+JMpGhBxjT0SowAITrvH0VC6E/hSkw4aFhvJ9QGdjhljR+DN3K5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2XjrxS7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqTkAmLs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718781804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I13A++imoQhao8gFnSZ3Ll5CYpEUTnm71Pum08/yKbQ=;
	b=L2XjrxS7T4a9bSZpE0LhfaK/UjPzBnACRKvlHyeFN4Bjt4fwn7SAym2AXMuR7R0cLFfFEh
	c3VQtwA6zx1iLEFDCUJw7Gwb88TzS5N8qnA7ioaX1Ve5wmL4E+R84OjSIgl6bKm4yUV6xe
	QaBaD9RD3MWpvpkmWQUXf3cgIybBDChN8q7sKyFmVbkw3CUAWgaluQqImIRJDp8f1biMJn
	UVQE8uNoHBHqBtkJfULXkhF7RFTntt98pdM8m/ZN0nK/KtEt9oHlcX6jRgTsofgtGiz8wB
	+NXoMI8RBLL/dD80UWaXP6h4X3JMZWpliHdZnHc4ruJD2w4IjF7lcshk6FyOdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718781804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I13A++imoQhao8gFnSZ3Ll5CYpEUTnm71Pum08/yKbQ=;
	b=LqTkAmLsAEnpSlS7pHdW5aCra/01nOVVsfeNfkXG2xWaG2sTRmk2+5U2JGRZl4o0DhkHTg
	iHNBb5v+A4GrekCg==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v8 net-next 09/15] dev: Remove PREEMPT_RT ifdefs from backlog_lock.*().
Date: Wed, 19 Jun 2024 09:17:00 +0200
Message-ID: <20240619072253.504963-10-bigeasy@linutronix.de>
In-Reply-To: <20240619072253.504963-1-bigeasy@linutronix.de>
References: <20240619072253.504963-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The backlog_napi locking (previously RPS) relies on explicit locking if
either RPS or backlog NAPI is enabled. If both are disabled then locking
was achieved by disabling interrupts except on PREEMPT_RT. PREEMPT_RT
was excluded because the needed synchronisation was already provided
local_bh_disable().

Since the introduction of backlog NAPI and making it mandatory for
PREEMPT_RT the ifdef within backlog_lock.*() is obsolete and can be
removed.

Remove the ifdefs in backlog_lock.*().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c15b0215a66b7..2745001d09eb4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -229,7 +229,7 @@ static inline void backlog_lock_irq_save(struct softnet=
_data *sd,
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_save(*flags);
 }
=20
@@ -237,7 +237,7 @@ static inline void backlog_lock_irq_disable(struct soft=
net_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_disable();
 }
=20
@@ -246,7 +246,7 @@ static inline void backlog_unlock_irq_restore(struct so=
ftnet_data *sd,
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_restore(*flags);
 }
=20
@@ -254,7 +254,7 @@ static inline void backlog_unlock_irq_enable(struct sof=
tnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_enable();
 }
=20
--=20
2.45.2


