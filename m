Return-Path: <netdev+bounces-165625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6676A32DBA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634663A22CA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3452225E454;
	Wed, 12 Feb 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YibhAP9D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598625E44D;
	Wed, 12 Feb 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382221; cv=none; b=L8nvuO89t5Hya4frJppt9iSY2Tqc0WSUmNIFR9cy3F7h1M9W6VZvxosounm4wtfMVeEUA4I58w6+btG0MBsDBNhe/LawNCb397iqCZ1JqOenvi4d+xy5n3QbOW08MX6uA1QjUjXLcJtC3idMMFgjxoE+tR9HdLdmVp2WHMTOTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382221; c=relaxed/simple;
	bh=GQmd9aEaFFJWA/wdYX4hixqzMoeMSS0iUsiiREnVfhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFg8asbX8VQia297hG3SS7UCFI0vgIzQvWeg/eEtVVEGAzhDbfhx/v7sPeFRlp2UqnVcJBzep1Jdb2HhutkrGBXxqz+sVc9mYpSprsinHqDO68c5cLFLEgBua5aGWPupU/aSS3aT8rpm3CmH+bTmVztTRNrWau7BsXByDaoRrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YibhAP9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F41C4CEE4;
	Wed, 12 Feb 2025 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739382220;
	bh=GQmd9aEaFFJWA/wdYX4hixqzMoeMSS0iUsiiREnVfhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YibhAP9D9GHeFXcpD/BLCQRgN7CFZMO/UIImcBXHyMZapI01T6+179VRSsruoSrxw
	 rbuln/CDTxmYTmu2ftErkjXnR5fZ9is1mMKbNTaBHHckCh0+nCJK7Yj4sRWzWPHrsM
	 dPBiWWWFnUKq8j0vHtHr6FmhrAhvWBNqVKRMNf4fIXLFL9ldUQqqyNwMgeIKY6Exhi
	 ddMJRdvG6mHqxnLr+5/sdXghswZyrXc+KtOqVPtYEyL/qcoJ/UuMJ7sCPwQDtrHdLn
	 CTy5XluVYd/2taA3nW9JJ38uLl7LyKQZoOhJeGol3PpQfLtg2KPYPWJ2bXxhPNq2h7
	 eYSaketI4aLxw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2] net: Assert proper context while calling napi_schedule()
Date: Wed, 12 Feb 2025 18:43:28 +0100
Message-ID: <20250212174329.53793-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250212174329.53793-1-frederic@kernel.org>
References: <20250212174329.53793-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_schedule() is expected to be called either:

* From an interrupt, where raised softirqs are handled on IRQ exit

* From a softirq disabled section, where raised softirqs are handled on
  the next call to local_bh_enable().

* From a softirq handler, where raised softirqs are handled on the next
  round in do_softirq(), or further deferred to a dedicated kthread.

Other bare tasks context may end up ignoring the raised NET_RX vector
until the next random softirq handling opportunity, which may not
happen before a while if the CPU goes idle afterwards with the tick
stopped.

Report inappropriate calling contexts when neither of the three above
conditions are met.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/lockdep.h | 12 ++++++++++++
 net/core/dev.c          |  1 +
 2 files changed, 13 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 67964dc4db95..1bd730b881f0 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -619,6 +619,17 @@ do {									\
 		     (!in_softirq() || in_irq() || in_nmi()));		\
 } while (0)
 
+/*
+ * Assert to be either in hardirq or in serving softirq or with
+ * softirqs disabled. Verifies a safe context to queue a softirq
+ * with __raise_softirq_irqoff().
+ */
+#define lockdep_assert_in_interrupt()				\
+do {								\
+	WARN_ON_ONCE(__lockdep_enabled && !in_interrupt());	\
+} while (0)
+
+
 extern void lockdep_assert_in_softirq_func(void);
 
 #else
@@ -634,6 +645,7 @@ extern void lockdep_assert_in_softirq_func(void);
 # define lockdep_assert_preemption_enabled() do { } while (0)
 # define lockdep_assert_preemption_disabled() do { } while (0)
 # define lockdep_assert_in_softirq() do { } while (0)
+# define lockdep_assert_in_interrupt() do { } while (0)
 # define lockdep_assert_in_softirq_func() do { } while (0)
 #endif
 
diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..80e415ccf2c8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4666,6 +4666,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 	struct task_struct *thread;
 
 	lockdep_assert_irqs_disabled();
+	lockdep_assert_in_interrupt();
 
 	if (test_bit(NAPI_STATE_THREADED, &napi->state)) {
 		/* Paired with smp_mb__before_atomic() in
-- 
2.46.0


