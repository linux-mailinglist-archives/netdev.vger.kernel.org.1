Return-Path: <netdev+bounces-302814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZWLyAprFQmouBQoAu9opvQ
	(envelope-from <netdev+bounces-302814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:20:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCE6DE41D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:20:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="BG/uMnA8";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302814-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302814-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C17AD303A8D4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FF53A3E7A;
	Mon, 29 Jun 2026 19:20:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB5B36494C
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 19:20:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760837; cv=none; b=PZfK9kdeEszEVY5xQne99c8jH3Pp6zlEgHLakejste2Iy1qCWOQeapYMwrMCJkD4tbonLzHSaSdErzZO2r4LguGoq//xXOsANmW82II2lEBT9Hgc0UyM4sR/gyZxgLCUcItyMgbpP6u54NCZD5+1khRDSduBdrWgq8fEE2lWpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760837; c=relaxed/simple;
	bh=jJAUvERCBWJyLyHVf75IIN3+hRb/+x4SCNyciPSZI0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=INRIDuksakI0aW1c47zho34Kf6VOha6yDFsrNNcexC+tSzdtMPlbz0e0AHYFfoiL7jEyJXhghfT6ADeG3bB/jyR9Rn8+DCscDHoGfh90F25ymkyraHGemycsRdZ7pfmTK2YGUMsgJzf5oFzv3VR8GL+/m6efnbvoL+izOHnxEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tanshuhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BG/uMnA8; arc=none smtp.client-ip=74.125.82.74
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13980b6561dso10569865c88.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782760835; x=1783365635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JpinYq+HYvghk8YdIRt9bOuD2hk4FEWzgEV2yDIPBj0=;
        b=BG/uMnA8fDQ4tFzwR8EJOy5BAxkADJz7T5fIqDHdrJFYsFMF43ZO6qlT5g2SpG8brZ
         TncHteXAzPkWITsiByDU1AuMSYZBhmq9m83vyibilWcks59FNPuvAVqU9xB5oh/vp+aO
         bHNLfzfX/PMGvPWszr+v35Y9KmnQXUxBtXeeccnrFndJdW5mONYocsWbJjcNTfPPHyQP
         +7YEWBzeFExCY4lF4gKZXc9KIBe5yKWOT9ZvSEIqv6XBl5ridc8M7zxt9hHufWeC9ZW4
         fVVRuKFZnlC33S1M2mGLuGDklpM6QBoWUw+msRTuTN0R1bZGYqsg6OKPjFDGnFtf9HP1
         JN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760835; x=1783365635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpinYq+HYvghk8YdIRt9bOuD2hk4FEWzgEV2yDIPBj0=;
        b=IE4DNE/Tk2jK3h1oAYvl6ZwyXr6GkB9rSS9DWoKNxy7QF8DXApCom9CvxabRI4cHDE
         3QJnikPLgRNQx5a3rhgEOYxH4OM9G6ZdxqcOkrEdK/Xwq9Gva7kAdM06icaqncC2QQQ7
         ZBJ5Bb4QUaGe3mjO6tCItR3CNzGMs/ZwcPX+n5FCdrChaDB2gzufIuGIk8cHBKsP+71a
         +xLzX4wZKtzcsD81QQKzHBfldY04vGj6aZzb372m3ql3MCNKs3nRNMcB7odf5MNuw9d0
         nW0dm8anEKtSGS3lwTSw8mJ/pNJcTCikZ2SZ005jfkezMyl+oLLOTdH3Q2All7tO725e
         9Chw==
X-Forwarded-Encrypted: i=1; AFNElJ/Q8F3TH7Z0CKSdhvrOU0+2cUo+J02jPDDCv93qx3HyedhXFlLFNSEw+7Yl5KoEqvc81ZoUyE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVya/+8/en0bnjteCCPeGGlTX4tBLVqpaqsV9DzXvaIQUjhb3
	6TliGImMWxGMxqXx0XeE0giN7ooVxtMmFjHDmNgv5PVQjd7vTbQpRto07RSDrslt6baPrx3oDnY
	7MRPqmeIWcEBq67vOuw==
X-Received: from dlbpj2.prod.google.com ([2002:a05:7022:3802:b0:139:fc9b:86dc])
 (user=tanshuhao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:fa0:b0:139:f094:7b35 with SMTP id a92af1059eb24-13b2a1dcbc1mr453997c88.37.1782760834544;
 Mon, 29 Jun 2026 12:20:34 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:20:26 -0700
In-Reply-To: <20260629192029.4013794-1-tanshuhao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629192029.4013794-1-tanshuhao@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629192029.4013794-2-tanshuhao@google.com>
Subject: [PATCH net-next v1 1/2] net: Save kthread of threaded NAPI in
 napi_config and restore it when trying to create a new kthread.
From: Shuhao Tan <tanshuhao@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Shuhao Tan <tanshuhao@google.com>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:tanshuhao@google.com,m:almasrymina@google.com,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302814-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62CCE6DE41D

Add a napi_thread_ctx struct that has a back pointer to napi_struct.

Make the NAPI kthread to use the thread_ctx as data pointer so that
it can poll on different NAPIs thoughout its lifetime.

Mirror the thread and thread_ctx in napi_config all the time.

Park the thread on napi_del instead of stopping if napi_config is
available.

Restore the thread and context when trying to create a new NAPI
kthread.

Signed-off-by: Shuhao Tan <tanshuhao@google.com>
---
 include/linux/netdevice.h |  12 +++++
 net/core/dev.c            | 106 +++++++++++++++++++++++++++++++-------
 2 files changed, 99 insertions(+), 19 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..05e430f10aba 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -63,6 +63,7 @@ struct dsa_port;
 struct ip_tunnel_parm_kern;
 struct macsec_context;
 struct macsec_ops;
+struct napi_struct;
 struct netdev_config;
 struct netdev_name_node;
 struct sd_flow_limit;
@@ -363,6 +364,10 @@ struct gro_node {
 	u32			cached_napi_id;
 };
 
+struct napi_thread_ctx {
+	struct napi_struct *napi;
+};
+
 /*
  * Structure for per-NAPI config
  */
@@ -371,6 +376,12 @@ struct napi_config {
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
 	cpumask_t affinity_mask;
+	/* thread and thread_ctx mirrors fields of napi_struct when napi_struct
+	 * is alive. When the napi_struct gets destroyed, napi_config holds the
+	 * sole reference to the now parked kthread.
+	 */
+	struct task_struct *thread;
+	struct napi_thread_ctx *thread_ctx;
 	u8 threaded;
 	unsigned int napi_id;
 };
@@ -404,6 +415,7 @@ struct napi_struct {
 	struct hrtimer		timer;
 	/* all fields past this point are write-protected by netdev_lock */
 	struct task_struct	*thread;
+	struct napi_thread_ctx	*thread_ctx;
 	unsigned long		gro_flush_timeout;
 	unsigned long		irq_suspend_timeout;
 	u32			defer_hard_irqs;
diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..c81992c929d9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1647,20 +1647,45 @@ static int napi_threaded_poll(void *data);
 
 static int napi_kthread_create(struct napi_struct *n)
 {
+	struct napi_thread_ctx *thread_ctx = NULL;
 	int err = 0;
 
+	if (n->config && n->config->thread) {
+		n->thread_ctx = n->config->thread_ctx;
+		n->thread = n->config->thread;
+		WRITE_ONCE(n->thread_ctx->napi, n);
+		kthread_unpark(n->thread);
+		return 0;
+	}
+
+	thread_ctx = kvzalloc_obj(*thread_ctx);
+	if (!thread_ctx)
+		return -ENOMEM;
+
 	/* Create and wake up the kthread once to put it in
 	 * TASK_INTERRUPTIBLE mode to avoid the blocked task
 	 * warning and work with loadavg.
 	 */
-	n->thread = kthread_run(napi_threaded_poll, n, "napi/%s-%d",
+	thread_ctx->napi = n;
+	n->thread = kthread_run(napi_threaded_poll, thread_ctx, "napi/%s-%d",
 				n->dev->name, n->napi_id);
 	if (IS_ERR(n->thread)) {
 		err = PTR_ERR(n->thread);
 		pr_err("kthread_run failed with err %d\n", err);
 		n->thread = NULL;
+		goto free_thread_ctx;
+	}
+	n->thread_ctx = thread_ctx;
+	if (n->config) {
+		n->config->thread = n->thread;
+		n->config->thread_ctx = thread_ctx;
 	}
 
+	return 0;
+
+free_thread_ctx:
+	kvfree(thread_ctx);
+
 	return err;
 }
 
@@ -7183,7 +7208,13 @@ static void napi_stop_kthread(struct napi_struct *napi)
 	}
 
 	kthread_stop(napi->thread);
+	kvfree(napi->thread_ctx);
 	napi->thread = NULL;
+	napi->thread_ctx = NULL;
+	if (napi->config) {
+		napi->config->thread = NULL;
+		napi->config->thread_ctx = NULL;
+	}
 }
 
 static void napi_set_threaded_state(struct napi_struct *napi,
@@ -7199,13 +7230,11 @@ static void napi_set_threaded_state(struct napi_struct *napi,
 int napi_set_threaded(struct napi_struct *napi,
 		      enum netdev_napi_threaded threaded)
 {
-	if (threaded) {
-		if (!napi->thread) {
-			int err = napi_kthread_create(napi);
+	if (threaded && !napi->thread) {
+		int err = napi_kthread_create(napi);
 
-			if (err)
-				return err;
-		}
+		if (err)
+			return err;
 	}
 
 	if (napi->config)
@@ -7255,8 +7284,15 @@ int netif_set_threaded(struct net_device *dev,
 		WARN_ON_ONCE(napi_set_threaded(napi, threaded));
 
 	/* Override the config for all NAPIs even if currently not listed */
-	for (i = 0; i < dev->num_napi_configs; i++)
+	for (i = 0; i < dev->num_napi_configs; i++) {
 		dev->napi_config[i].threaded = threaded;
+		if (!threaded && dev->napi_config[i].thread) {
+			kthread_stop(dev->napi_config[i].thread);
+			kvfree(dev->napi_config[i].thread_ctx);
+			dev->napi_config[i].thread = NULL;
+			dev->napi_config[i].thread_ctx = NULL;
+		}
+	}
 
 	return err;
 }
@@ -7501,6 +7537,8 @@ static void napi_save_config(struct napi_struct *n)
 	n->config->defer_hard_irqs = n->defer_hard_irqs;
 	n->config->gro_flush_timeout = n->gro_flush_timeout;
 	n->config->irq_suspend_timeout = n->irq_suspend_timeout;
+	n->config->thread = n->thread;
+	n->config->thread_ctx = n->thread_ctx;
 	napi_hash_del(n);
 }
 
@@ -7695,6 +7733,21 @@ void __netif_napi_del_locked(struct napi_struct *napi)
 	if (test_and_clear_bit(NAPI_STATE_HAS_NOTIFIER, &napi->state))
 		irq_set_affinity_notifier(napi->irq, NULL);
 
+	if (napi->thread) {
+		if (napi->config) {
+			kthread_park(napi->thread);
+			/* napi->config holds the only reference to the thread
+			 * from now on.
+			 */
+			napi->thread_ctx->napi = NULL;
+		} else {
+			kthread_stop(napi->thread);
+			kvfree(napi->thread_ctx);
+		}
+		napi->thread = NULL;
+		napi->thread_ctx = NULL;
+	}
+
 	if (napi->config) {
 		napi->index = -1;
 		napi->config = NULL;
@@ -7704,11 +7757,6 @@ void __netif_napi_del_locked(struct napi_struct *napi)
 	napi_free_frags(napi);
 
 	gro_cleanup(&napi->gro);
-
-	if (napi->thread) {
-		kthread_stop(napi->thread);
-		napi->thread = NULL;
-	}
 }
 EXPORT_SYMBOL(__netif_napi_del_locked);
 
@@ -7804,11 +7852,18 @@ static int napi_poll(struct napi_struct *n, struct list_head *repoll)
 	return work;
 }
 
-static int napi_thread_wait(struct napi_struct *napi)
+static struct napi_struct *napi_thread_wait(struct napi_thread_ctx *thread_ctx)
 {
+	struct napi_struct *napi = READ_ONCE(thread_ctx->napi);
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
+		if (kthread_should_park()) {
+			kthread_parkme();
+			napi = READ_ONCE(thread_ctx->napi);
+			/* Might be awakened for stopping */
+			continue;
+		}
 		/* Testing SCHED_THREADED bit here to make sure the current
 		 * kthread owns this napi and could poll on this napi.
 		 * Testing SCHED bit is not enough because SCHED bit might be
@@ -7817,7 +7872,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 		if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state)) {
 			WARN_ON(!list_empty(&napi->poll_list));
 			__set_current_state(TASK_RUNNING);
-			return 0;
+			return napi;
 		}
 
 		schedule();
@@ -7825,7 +7880,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 	}
 	__set_current_state(TASK_RUNNING);
 
-	return -1;
+	return NULL;
 }
 
 static void napi_threaded_poll_loop(struct napi_struct *napi,
@@ -7882,13 +7937,18 @@ static void napi_threaded_poll_loop(struct napi_struct *napi,
 
 static int napi_threaded_poll(void *data)
 {
-	struct napi_struct *napi = data;
+	struct napi_thread_ctx *thread_ctx = data;
 	unsigned long last_qs = jiffies;
+	struct napi_struct *napi;
 	bool want_busy_poll;
 	bool in_busy_poll;
 	unsigned long val;
 
-	while (!napi_thread_wait(napi)) {
+	while (1) {
+		napi = napi_thread_wait(thread_ctx);
+		if (!napi)
+			break;
+
 		val = READ_ONCE(napi->state);
 
 		want_busy_poll = val & NAPIF_STATE_THREADED_BUSY_POLL;
@@ -12128,11 +12188,11 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		goto free_all;
 	dev->cfg_pending = dev->cfg;
 
-	dev->num_napi_configs = maxqs;
 	napi_config_sz = array_size(maxqs, sizeof(*dev->napi_config));
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
 	if (!dev->napi_config)
 		goto free_all;
+	dev->num_napi_configs = maxqs;
 
 	strscpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
@@ -12160,6 +12220,8 @@ EXPORT_SYMBOL(alloc_netdev_mqs);
 
 static void netdev_napi_exit(struct net_device *dev)
 {
+	unsigned int i;
+
 	if (!list_empty(&dev->napi_list)) {
 		struct napi_struct *p, *n;
 
@@ -12171,6 +12233,12 @@ static void netdev_napi_exit(struct net_device *dev)
 		synchronize_net();
 	}
 
+	for (i = 0; i < dev->num_napi_configs; i++) {
+		if (dev->napi_config[i].thread) {
+			kthread_stop(dev->napi_config[i].thread);
+			kvfree(dev->napi_config[i].thread_ctx);
+		}
+	}
 	kvfree(dev->napi_config);
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


