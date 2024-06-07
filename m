Return-Path: <netdev+bounces-101679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596298FFC9F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AA11C28E2F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDD2155A47;
	Fri,  7 Jun 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="El/853dM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="szSt6j+J"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BBF155333;
	Fri,  7 Jun 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743878; cv=none; b=itVkDfNBrLME3Vo6rQsyE4KUbfHCFlLMJALEd+UXwYHKc9fzoNYHhHCeh6vaoW1OUyLZ1ioR7oB9pQA1ZXIpguxGdjySta05pGIIDROD/mfbknvEfp9RuZniVJI/sbvcG2PBI0xYR62xaKiqTw87kImhujnnbRKgRW2qxPVB34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743878; c=relaxed/simple;
	bh=eD4dt4fw0aatk5xk1+CFhA4XLqiGzZDl6PGjHb3adRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+lZ1BIbm587oKPVZOF5y0Sb5FEf0Eosoc6dicwyzZcwr4gI33kX82hjhN7prdPzKJ1BFMjCvaM2zUmOFZ+EIZw3ipRI6EotIb+WeFCxgjsZzCLWSlq5Knqte/9DUGvqIAEjYocv8FyhZtLZiFfQtOlA7Uy38C8m3165/hxLgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=El/853dM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=szSt6j+J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717743874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YzaWGKH4pdlOZgRx7nAozero4nCYBfUB40Jz5/zFVM=;
	b=El/853dMSIc6CvyTPHun/CuKs4C23uJ2sIb9gHZkWGN7+kJT66y/o/mf7HQQoyvipQBLey
	eQ6ATsldjcRPhcN9FFk1hCPlpV0KmERmJ9PgSwA1YHuxUSMcMr7LPTBM+t4MgHHbcjQoG0
	Dld71D3/vRqSXXB0agQrQbZC+XgwBpt2OHzMjK3jxKiNA4U7SfFtm90t38NllVGa4t3drs
	v6UbFLZW1CfRbhvx9norMq0J9ekdpWV8zIjTEGDE5KyMwDU9Wl9vsUOklEhqCNUxVonxfw
	p2HbqXFzj9b9F9OIqIOz3mdaLjhGZ2t6/etKmw3wbXJaot7cJZMtMWLwprk/2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717743874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YzaWGKH4pdlOZgRx7nAozero4nCYBfUB40Jz5/zFVM=;
	b=szSt6j+J5bFpE+tTpbTT+JPtFiN6txotlT9NL4NL95kpuWvwwEg+yi86I3SneY7bom/ODa
	CvGbbGoYLt0CUqAA==
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
Subject: [PATCH v5 net-next 09/15] dev: Remove PREEMPT_RT ifdefs from backlog_lock.*().
Date: Fri,  7 Jun 2024 08:53:12 +0200
Message-ID: <20240607070427.1379327-10-bigeasy@linutronix.de>
In-Reply-To: <20240607070427.1379327-1-bigeasy@linutronix.de>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
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
index 85fe8138f3e4e..a66e4e744bbb4 100644
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
2.45.1


