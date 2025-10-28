Return-Path: <netdev+bounces-233647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF5C16C7A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D32F1C2541D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A622C3768;
	Tue, 28 Oct 2025 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPV9dThi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A22C3248
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683413; cv=none; b=ERoAQv/D1gL5o1KNUJe+0MdPsFZMhZEFtVu2Tn9L0X5xL75TiY7GQlcEnrIsPqO+28Z+jiv8B6t1VnFEh0BPNIVq439yzxQ+jDzvQwT7rTxoIzx0FIS5NQ1cxrLbl0+14b7myIImZP7WWxV3g1iNjAzOScGTm5/dcjFOIedyHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683413; c=relaxed/simple;
	bh=mqe32BxQgsZCPQ+P4UOWut6rHaZXjVOuo/FxpA2Ctx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iYM65aOxFjz4oSwvw/i4gYVDrj/L8AHEGv5iezsNPyPQdeBmq2rsbP11uz9OJhJMbVSLmN6NaJVLalQJ41li2/CKv3ZLCAqQLYNXcmnQmnSF1DiNtopP8Hqi+IXpJ0+oiiaJ46qMNwbq6W7K4AC63/X2SjCM6JQ3L+rPpJRU1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPV9dThi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27c62320f16so64200805ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761683410; x=1762288210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+oSgZR/DeGfNReqLiYBpbTFyaHKgoFvWQBxoglTZQg=;
        b=tPV9dThigTT2yywy2kFJU5tYNPUKVYuqmFq3aY/vkTqn0K1jBA+nquMlsaBfh3ib22
         yPzHVQluhIAnmWIgRpJIC/mvtgeHySRMpLXo4Gf+vES5SkjudcbmJwaCNWZ2Qww+2MB+
         pgiRUNqgaZ+XQHNHRx8zpVqUHCnGWKGqpI3bA8uSNKM3BXNNPD2BP9K/AaAsg3QWHgkD
         W/lnRPiL7QTs4fOlIA7VEyYU6fOH8dKwUix6VS0x8miPa0wQ6DiR7q4dhMVsoD5lgJ3k
         oBc05K/OTZgOFgLC4lr3E8kaQVEEE0/8mSyKUv5CFi5pJWcjUrgEjWDkI/K1U6R5jeUJ
         iuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761683410; x=1762288210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+oSgZR/DeGfNReqLiYBpbTFyaHKgoFvWQBxoglTZQg=;
        b=BVeIaCo4sVZwGM2T3SvsT5hzt40BDXikMCaDMTlSpoClYRZGQnsnyLyWUiBD1LWMlD
         ReQDS3rz0Iun93+xrwXM0jWJIyIqMExGL48CPDost7m9m2imJ0+EIPSfJm+S1UcXt1Eu
         78Qgk4h4JYlQ0/7UB5H8DpPW9u2wweFqOBK4PQ+/Xaub42kzXcQx7LLp2Bua0Dm8hPZy
         KBBms3AMidFp9v/DMHQSOrfbsuvXle88kqBJFhv8xitcQ+b6UuTjo4H7JICA3L9OPKQA
         2WUmrqUrcO9DTv/801AeSmojDOWxwMEApns+U8gv5WEtGPfQm/2DJwcAOMkCLI3A09OA
         3drw==
X-Forwarded-Encrypted: i=1; AJvYcCV+MajbzCFaj1x5QyC86ywWpUZbRNuKyX8RJcl9BU8NwtOPcbG7K7JScKVLypLtNkBV0naha6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpwcyv+REblnLxT8BX6cPZiBoPIyDgX+jLSrvOO4o2exEpYLpW
	DFDdjN/Yq3GKgg4D8VFZeu4HKp98iSSFAsMiHQHV3bJu7djvpZmN34hX27m11TDn8OA0l0UNSKo
	CmDWyL1O1SG9p2w==
X-Google-Smtp-Source: AGHT+IGNcQ/ncV8isD0aNblVmw1PXTQ2wtNzsbqW3MaEqCFQFto6XpAWwSSUT7tMSAUgARAgksCgp+me5MauDQ==
X-Received: from pllq21.prod.google.com ([2002:a17:902:7895:b0:268:1af:fcff])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:f6b:b0:290:afe9:76ef with SMTP id d9443c01a7336-294deec5341mr3232585ad.40.1761683410163;
 Tue, 28 Oct 2025 13:30:10 -0700 (PDT)
Date: Tue, 28 Oct 2025 20:30:05 +0000
In-Reply-To: <20251028203007.575686-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028203007.575686-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028203007.575686-2-skhawaja@google.com>
Subject: [PATCH net-next v10 1/2] net: Extend NAPI threaded polling to allow
 kthread based busy polling
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com
Cc: Joe Damato <joe@dama.to>, mkarsten@uwaterloo.ca, netdev@vger.kernel.org, 
	skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Add a new state NAPI_STATE_THREADED_BUSY_POLL to the NAPI state enum to
enable and disable threaded busy polling.

When threaded busy polling is enabled for a NAPI, enable
NAPI_STATE_THREADED also.

When the threaded NAPI is scheduled, set NAPI_STATE_IN_BUSY_POLL to
signal napi_complete_done not to rearm interrupts.

Whenever NAPI_STATE_THREADED_BUSY_POLL is unset, the
NAPI_STATE_IN_BUSY_POLL will be unset, napi_complete_done unsets the
NAPI_STATE_SCHED_THREADED bit also, which in turn will make the kthread
go to sleep.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/netlink/specs/netdev.yaml |  5 ++-
 Documentation/networking/napi.rst       | 50 ++++++++++++++++++++-
 include/linux/netdevice.h               |  4 +-
 include/uapi/linux/netdev.h             |  1 +
 net/core/dev.c                          | 58 ++++++++++++++++++++-----
 net/core/dev.h                          |  3 ++
 net/core/netdev-genl-gen.c              |  2 +-
 tools/include/uapi/linux/netdev.h       |  1 +
 8 files changed, 109 insertions(+), 15 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index e00d3fa1c152..10c412b7433f 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -88,7 +88,7 @@ definitions:
   -
     name: napi-threaded
     type: enum
-    entries: [disabled, enabled]
+    entries: [disabled, enabled, busy-poll]
 
 attribute-sets:
   -
@@ -291,7 +291,8 @@ attribute-sets:
         name: threaded
         doc: Whether the NAPI is configured to operate in threaded polling
              mode. If this is set to enabled then the NAPI context operates
-             in threaded polling mode.
+             in threaded polling mode. If this is set to busy-poll, then the
+             threaded polling mode also busy polls.
         type: u32
         enum: napi-threaded
   -
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 7dd60366f4ff..4e008efebb35 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -263,7 +263,9 @@ are not well known).
 Busy polling is enabled by either setting ``SO_BUSY_POLL`` on
 selected sockets or using the global ``net.core.busy_poll`` and
 ``net.core.busy_read`` sysctls. An io_uring API for NAPI busy polling
-also exists.
+also exists. Threaded polling of NAPI also has a mode to busy poll for
+packets (:ref:`threaded busy polling<threaded_busy_poll>`) using the NAPI
+processing kthread.
 
 epoll-based busy polling
 ------------------------
@@ -426,6 +428,52 @@ Therefore, setting ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` is
 the recommended usage, because otherwise setting ``irq-suspend-timeout``
 might not have any discernible effect.
 
+.. _threaded_busy_poll:
+
+Threaded NAPI busy polling
+--------------------------
+
+Threaded NAPI busy polling extends threaded NAPI and adds support to do
+continuous busy polling of the NAPI. This can be useful for forwarding or
+AF_XDP applications.
+
+Threaded NAPI busy polling can be enabled on per NIC queue basis using Netlink.
+
+For example, using the following script:
+
+.. code-block:: bash
+
+  $ ynl --family netdev --do napi-set \
+            --json='{"id": 66, "threaded": "busy-poll"}'
+
+The kernel will create a kthread that busy polls on this NAPI.
+
+The user may elect to set the CPU affinity of this kthread to an unused CPU
+core to improve how often the NAPI is polled at the expense of wasted CPU
+cycles. Note that this will keep the CPU core busy with 100% usage.
+
+Once threaded busy polling is enabled for a NAPI, PID of the kthread can be
+retrieved using Netlink so the affinity of the kthread can be set up.
+
+For example, the following script can be used to fetch the PID:
+
+.. code-block:: bash
+
+  $ ynl --family netdev --do napi-get --json='{"id": 66}'
+
+This will output something like following, the pid `258` is the PID of the
+kthread that is polling this NAPI.
+
+.. code-block:: bash
+
+  $ {'defer-hard-irqs': 0,
+     'gro-flush-timeout': 0,
+     'id': 66,
+     'ifindex': 2,
+     'irq-suspend-timeout': 0,
+     'pid': 258,
+     'threaded': 'busy-poll'}
+
 .. _threaded:
 
 Threaded NAPI
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7f5aad5cc9a1..07118c0424b8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -422,11 +422,12 @@ enum {
 	NAPI_STATE_NPSVC,		/* Netpoll - don't dequeue from poll_list */
 	NAPI_STATE_LISTED,		/* NAPI added to system lists */
 	NAPI_STATE_NO_BUSY_POLL,	/* Do not add in napi_hash, no busy polling */
-	NAPI_STATE_IN_BUSY_POLL,	/* sk_busy_loop() owns this NAPI */
+	NAPI_STATE_IN_BUSY_POLL,	/* Do not rearm NAPI interrupt */
 	NAPI_STATE_PREFER_BUSY_POLL,	/* prefer busy-polling over softirq processing*/
 	NAPI_STATE_THREADED,		/* The poll is performed inside its own thread*/
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
 	NAPI_STATE_HAS_NOTIFIER,	/* Napi has an IRQ notifier */
+	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded NAPI poller will busy poll */
 };
 
 enum {
@@ -441,6 +442,7 @@ enum {
 	NAPIF_STATE_THREADED		= BIT(NAPI_STATE_THREADED),
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
 	NAPIF_STATE_HAS_NOTIFIER	= BIT(NAPI_STATE_HAS_NOTIFIER),
+	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
 };
 
 enum gro_result {
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 48eb49aa03d4..048c8de1a130 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -80,6 +80,7 @@ enum netdev_qstats_scope {
 enum netdev_napi_threaded {
 	NETDEV_NAPI_THREADED_DISABLED,
 	NETDEV_NAPI_THREADED_ENABLED,
+	NETDEV_NAPI_THREADED_BUSY_POLL,
 };
 
 enum {
diff --git a/net/core/dev.c b/net/core/dev.c
index 378c2d010faf..7feb4cad4a71 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7086,7 +7086,8 @@ static void napi_stop_kthread(struct napi_struct *napi)
 		 */
 		if ((val & NAPIF_STATE_SCHED_THREADED) ||
 		    !(val & NAPIF_STATE_SCHED)) {
-			new = val & (~NAPIF_STATE_THREADED);
+			new = val & (~(NAPIF_STATE_THREADED |
+				       NAPIF_STATE_THREADED_BUSY_POLL));
 		} else {
 			msleep(20);
 			continue;
@@ -7110,6 +7111,16 @@ static void napi_stop_kthread(struct napi_struct *napi)
 	napi->thread = NULL;
 }
 
+static void napi_set_threaded_state(struct napi_struct *napi,
+				    enum netdev_napi_threaded threaded_mode)
+{
+	bool threaded = threaded_mode != NETDEV_NAPI_THREADED_DISABLED;
+	bool busy_poll = threaded_mode == NETDEV_NAPI_THREADED_BUSY_POLL;
+
+	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+	assign_bit(NAPI_STATE_THREADED_BUSY_POLL, &napi->state, busy_poll);
+}
+
 int napi_set_threaded(struct napi_struct *napi,
 		      enum netdev_napi_threaded threaded)
 {
@@ -7136,7 +7147,7 @@ int napi_set_threaded(struct napi_struct *napi,
 	} else {
 		/* Make sure kthread is created before THREADED bit is set. */
 		smp_mb__before_atomic();
-		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+		napi_set_threaded_state(napi, threaded);
 	}
 
 	return 0;
@@ -7528,7 +7539,9 @@ void napi_disable_locked(struct napi_struct *n)
 		}
 
 		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
-		new &= ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY_POLL);
+		new &= ~(NAPIF_STATE_THREADED |
+			 NAPIF_STATE_THREADED_BUSY_POLL |
+			 NAPIF_STATE_PREFER_BUSY_POLL);
 	} while (!try_cmpxchg(&n->state, &val, new));
 
 	hrtimer_cancel(&n->timer);
@@ -7740,7 +7753,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
-static void napi_threaded_poll_loop(struct napi_struct *napi)
+static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
@@ -7769,22 +7782,47 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 		}
 		skb_defer_free_flush();
 		bpf_net_ctx_clear(bpf_net_ctx);
+
+		/* When busy poll is enabled, the old packets are not flushed in
+		 * napi_complete_done. So flush them here.
+		 */
+		if (busy_poll)
+			gro_flush_normal(&napi->gro, HZ >= 1000);
 		local_bh_enable();
 
+		/* Call cond_resched here to avoid watchdog warnings. */
+		if (repoll || busy_poll) {
+			rcu_softirq_qs_periodic(last_qs);
+			cond_resched();
+		}
+
 		if (!repoll)
 			break;
-
-		rcu_softirq_qs_periodic(last_qs);
-		cond_resched();
 	}
 }
 
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
+	bool want_busy_poll;
+	bool in_busy_poll;
+	unsigned long val;
+
+	while (!napi_thread_wait(napi)) {
+		val = READ_ONCE(napi->state);
+
+		want_busy_poll = val & NAPIF_STATE_THREADED_BUSY_POLL;
+		in_busy_poll = val & NAPIF_STATE_IN_BUSY_POLL;
 
-	while (!napi_thread_wait(napi))
-		napi_threaded_poll_loop(napi);
+		if (unlikely(val & NAPIF_STATE_DISABLE))
+			want_busy_poll = false;
+
+		if (want_busy_poll != in_busy_poll)
+			assign_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state,
+				   want_busy_poll);
+
+		napi_threaded_poll_loop(napi, want_busy_poll);
+	}
 
 	return 0;
 }
@@ -13094,7 +13132,7 @@ static void run_backlog_napi(unsigned int cpu)
 {
 	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
 
-	napi_threaded_poll_loop(&sd->backlog);
+	napi_threaded_poll_loop(&sd->backlog, false);
 }
 
 static void backlog_napi_setup(unsigned int cpu)
diff --git a/net/core/dev.h b/net/core/dev.h
index 900880e8b5b4..4d872a79bafb 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -317,6 +317,9 @@ static inline void napi_set_irq_suspend_timeout(struct napi_struct *n,
 
 static inline enum netdev_napi_threaded napi_get_threaded(struct napi_struct *n)
 {
+	if (test_bit(NAPI_STATE_THREADED_BUSY_POLL, &n->state))
+		return NETDEV_NAPI_THREADED_BUSY_POLL;
+
 	if (test_bit(NAPI_STATE_THREADED, &n->state))
 		return NETDEV_NAPI_THREADED_ENABLED;
 
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index e9a2a6f26cb7..ff20435c45d2 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -97,7 +97,7 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_THREADED
 	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
 	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
-	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 2),
 };
 
 /* NETDEV_CMD_BIND_TX - do */
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 48eb49aa03d4..048c8de1a130 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -80,6 +80,7 @@ enum netdev_qstats_scope {
 enum netdev_napi_threaded {
 	NETDEV_NAPI_THREADED_DISABLED,
 	NETDEV_NAPI_THREADED_ENABLED,
+	NETDEV_NAPI_THREADED_BUSY_POLL,
 };
 
 enum {
-- 
2.51.1.838.g19442a804e-goog


