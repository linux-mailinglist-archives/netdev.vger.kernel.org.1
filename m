Return-Path: <netdev+bounces-102946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE091905975
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9569C1F22FA7
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703A6184109;
	Wed, 12 Jun 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0IAPGSi3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BFccWuo7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654518307C;
	Wed, 12 Jun 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211806; cv=none; b=OeVXwNOsL6ovdCPK6ZBugyvZpN+WnYJaOYyeUQX/vrHmCzu90uheTBX+qdTnhqB/GM15ORsqG9YlSnb/C2UuYSGD1aXRgislU0W3LVISxRGPpUGK4BetYYjEOwqeDr8V5M4T+asykFv8dwaqOyy3Cv+tzl+NP73JuMlOaHdSZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211806; c=relaxed/simple;
	bh=+cemsJe985z4jsKXPhyNAjOVtSf1Tt7T/0jsg14mEe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5YJ3vKbGngxOUVDH/Jn1bwWhfqEprXg0FnDQAU3gxdzXOHkTcH+nKdmpql0gTxyBJc0m7zGwqzdc4w1Ro+08ncXKUmIS9acEx41oYp2ZERvi9h8SZhpEWbReoFiTpP9jpDWomUqjZFf+o2U7g7PUwHxof7z9Df9D18dbabXA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0IAPGSi3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BFccWuo7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718211797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHAA9JKkIO+I90WJT4X6Hovgce35PNbJ/xPvrfjbWUU=;
	b=0IAPGSi3+2CucVDe243Q+KH+Xp68yCbCCzTOpTDh7rdwbQyq6Z0ikZAU1L2gUSDcuGln4p
	+qZduXOvituC6tOdoIvWIZQkWxMTzrCw0bFxTwRe7a2nswX3tZR3KEdt2qZA0974oCsVYC
	tjNzXo4Hncn0brD+xfTVqSKl3+O+6ijh7o3PSbPTW0IEWAVboPuD9VkWSzra+6CBa37wIM
	B4+AMgv0rKukOru2x7GNF2zb+qhHpQwRjicno16zEl0fEXsjwIfsF2DKrfpK684LjAm598
	SDpAabAMLDb+KJJn2g8P5cdU93ATNe4yL0S0ekxKJ5DJOvBUR1eIUlo7HbyB3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718211797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHAA9JKkIO+I90WJT4X6Hovgce35PNbJ/xPvrfjbWUU=;
	b=BFccWuo7pCzzWxG1C/jLtx330qlA4ImEv413lZxiTtvNuNuE2Pp+3MTckV03/+nvADVWYv
	6sjteRzKctTQbkCA==
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
Subject: [PATCH v6 net-next 09/15] dev: Remove PREEMPT_RT ifdefs from backlog_lock.*().
Date: Wed, 12 Jun 2024 18:44:35 +0200
Message-ID: <20240612170303.3896084-10-bigeasy@linutronix.de>
In-Reply-To: <20240612170303.3896084-1-bigeasy@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
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
index e62698c7a0e63..db6b6fc997e6d 100644
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


