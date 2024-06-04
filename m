Return-Path: <netdev+bounces-100650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB84E8FB837
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20AE4B23235
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3EC149018;
	Tue,  4 Jun 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z1zD58wg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FwMBvCAf"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FEA148314;
	Tue,  4 Jun 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515893; cv=none; b=t/xNXVCDfcjurNYQuuZQjRKTXVQt5Or2WXo7oqbmD5O0h7qH9sGUSuCzMZlMfuUl0vY7VHsI97mm6GLK6c+re/t+kWxYAj+fL37645qbcX+YgFLI31aehCudCinCi4rche9Yt1j9NXWRWKvYeRnGCopdtkThcBwM4d0Azi4VjrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515893; c=relaxed/simple;
	bh=eD4dt4fw0aatk5xk1+CFhA4XLqiGzZDl6PGjHb3adRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSXA4K4vWOO4ufAp+JqXgASs6t0gkU5QPuG/Fa/6rLu7F90RhIfl+7w9iCNjYP8T+yrkTZ+c2v6BVPVABCY3j3ycWeHjQ5mtmfzqISoIwTSdKG+pCRiUUBJ3PAzmQcyU07XGojDYbZSIjbw7UHq1UcTJXCNZ4fk7ZdYJ4tm9ezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z1zD58wg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FwMBvCAf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717515890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YzaWGKH4pdlOZgRx7nAozero4nCYBfUB40Jz5/zFVM=;
	b=z1zD58wgDp/B9bAoECyJgRwYqrPA7v5I6bbFPAkqt3Diy4d3fKsiohyWxDo40b9WjCT7Jl
	IqNi0ysE1HdocbGYtDDhYmTf0eEU5Dtp1cCjcmtK3mhX5wI3YLH70Fu5xkFi1nxe4q2bW8
	+n+SksrzgE/mrbE75rz1fVSoScF/VQD/phXwW59z891Vbpq7iQAPWGF8t3faPtQCWd8zI+
	GdAWpfZh+GUp2z9v10nRqDyrfGckWPYzjQmMMpq/U94pA7teyofbkyj/ZvxRuaqO2DOgD3
	OdzVqT+9+WWGKRvL+TSjFM9QwZJ9eyILIimbaOIAdmkQvB+rsJ1AzvERgBFTeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717515890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YzaWGKH4pdlOZgRx7nAozero4nCYBfUB40Jz5/zFVM=;
	b=FwMBvCAfwBIvOI9xgKntmhP/zfKri5pOv/2ig/IdSp85vHr3XU+Nu9ndZXca0tVSr2hyVu
	acAUPRuuhli4b0BQ==
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
Subject: [PATCH v4 net-next 08/14] dev: Remove PREEMPT_RT ifdefs from backlog_lock.*().
Date: Tue,  4 Jun 2024 17:24:15 +0200
Message-ID: <20240604154425.878636-9-bigeasy@linutronix.de>
In-Reply-To: <20240604154425.878636-1-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
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


