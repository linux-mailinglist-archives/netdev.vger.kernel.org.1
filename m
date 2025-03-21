Return-Path: <netdev+bounces-176642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ADEA6B2DA
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 03:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B524879DB
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 02:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB151E4929;
	Fri, 21 Mar 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nl9CTovh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63EC182D7
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523327; cv=none; b=im69Y0I30GmU52eQ8B+k1oWSiZTj5o3h4vxTTR0kXHbaRZQrdh5wpC3lc5aN8vBTs8vXUsTmGojmtvNeyd1ggRc2Ekp4XvinyQRNiWZU7Z+dJUwKD0MYpAtYZ2Ec8LlSeOMSbPenlUgqetyk4i/T7VYXvmQA7TGsxJ2nzTgoRWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523327; c=relaxed/simple;
	bh=v9lKllO+EaxYK+XLc6qmx1h5TIntS8dRfw6omLBkia8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0D44cTPWJUJUZwiTgAbEJiC0lrJ17v3DMOwOTAstpnLyhu2jShAp8Vefw4jyrtDYZ2u9JX+/c9uoYA9OlxUvr0NB1X8kczDZkgj8EdmHTehTRA0npjEmHh7BMwIlk1dq9s7i+JubJ62xYlu0Q4WzGFYpMOT3qzs9/NL549Ud6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nl9CTovh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-300fefb8e25so2432776a91.3
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 19:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742523324; x=1743128124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgg67l2ddT81lq2PrpVL9qfCbJxbVOzHOcgUW7oDbBI=;
        b=nl9CTovh57XvCSf+vu1BxG+9cW4AwnZaG8uXLQdEQAtX01kS1yADjUf1mvmFsTK9s6
         JyW+TUTKvpKGSKjOEC7XxkSf2ICEUlFH5c0TTXzOcNB7EoUKZyqLjOqa/1wnNb2cybk5
         Ljc9uuY8jcEDSm3G9cZHqN+JJm614TlVxUs99caTEySk7jOOPv63sotZiDD9DPhdHqME
         QgFVxS8P3AIcA1Z6OlJ7o4oOFUme00L8JBEaJ2rPODnPlSjoNGDEpaQjLAwFUlGYJVEL
         68ccBuxJZHAyYMcWX9iqPbwlKN411AUPKLaVh/03kWd64tfn5RY0Uojs/tkZbrzbQ3OI
         fr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742523324; x=1743128124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgg67l2ddT81lq2PrpVL9qfCbJxbVOzHOcgUW7oDbBI=;
        b=YT6+pZBrRQP2EGrgsfvzr4lhJXghEuSKbNLtvY3tsPk4D+eIPVDm4JMFt1IV3fCU6p
         AOPjUARwTaTz1dOhLOsDoP0ieBet+/hA6kwjwyRLsS4ALK6FtY9sNO+B7n0mwotLcgu2
         hUa1/bh62zvfZx+x5MIrRDoHj1Y/ldrkCgVJAy343C9glG/S9xsuWBWNQDu/Eoy3DxJl
         qdnOMZStphZxt/KIeeAopl8qgNI0s+lYXYFGk+PM9MUElIz/h5UXJBQO3L7AR3gWtscq
         +oTUhgOVNTSmGyWVmPyCqeoWBDEQWKNv62wcawxjwvJi/20JP8yaJ4z+wM2p0Me8rr4h
         COBg==
X-Gm-Message-State: AOJu0YxzUQ7w7ER7kWpGqz3NVVH+KOK/2AeiJuB0M939N0Zl8JX313Pi
	B0L4CbsZHB5DsGwEpyQMZPydhN8oIpPEavSEDF8N0Ieta0rgj73vbI8Q7ju6u3fSsg6EYo2yFnd
	N5s+kjCjS/Q==
X-Google-Smtp-Source: AGHT+IEHuYBM2tyj9x+UauLvYUE2c4iX1A4Y1elLDelRsI6lS3ojR9ommM+hpoI7pcjuJtzP8yiHlY5PjrneeQ==
X-Received: from pjbqn11.prod.google.com ([2002:a17:90b:3d4b:b0:301:ab99:6880])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f0c:b0:2ff:7ad4:77b1 with SMTP id 98e67ed59e1d1-3030fe561eemr2703159a91.2.1742523324219;
 Thu, 20 Mar 2025 19:15:24 -0700 (PDT)
Date: Fri, 21 Mar 2025 02:15:18 +0000
In-Reply-To: <20250321021521.849856-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321021521.849856-1-skhawaja@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321021521.849856-2-skhawaja@google.com>
Subject: [PATCH net-next v4 1/4] Add support to set napi threaded for
 individual napi
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

A net device has a threaded sysctl that can be used to enable threaded
napi polling on all of the NAPI contexts under that device. Allow
enabling threaded napi polling at individual napi level using netlink.

Extend the netlink operation `napi-set` and allow setting the threaded
attribute of a NAPI. This will enable the threaded polling on a napi
context.

Tested using following command in qemu/virtio-net:
./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
  --do napi-set       --json '{"id": 66, "threaded": 1}'

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 Documentation/netlink/specs/netdev.yaml | 10 ++++++++
 Documentation/networking/napi.rst       | 13 ++++++++++-
 include/linux/netdevice.h               | 10 ++++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/dev.c                          | 31 +++++++++++++++++++++++++
 net/core/netdev-genl-gen.c              |  5 ++--
 net/core/netdev-genl.c                  |  9 +++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 8 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index f5e0750ab71d..92f98f2a6bd7 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -280,6 +280,14 @@ attribute-sets:
         doc: The timeout, in nanoseconds, of how long to suspend irq
              processing, if event polling finds events
         type: uint
+      -
+        name: threaded
+        doc: Whether the napi is configured to operate in threaded polling
+             mode. If this is set to `1` then the NAPI context operates
+             in threaded polling mode.
+        type: u32
+        checks:
+          max: 1
   -
     name: xsk-info
     attributes: []
@@ -691,6 +699,7 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+            - threaded
       dump:
         request:
           attributes:
@@ -743,6 +752,7 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+            - threaded
 
 kernel-family:
   headers: [ "net/netdev_netlink.h"]
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index d0e3953cae6a..63f98c05860f 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -444,7 +444,18 @@ dependent). The NAPI instance IDs will be assigned in the opposite
 order than the process IDs of the kernel threads.
 
 Threaded NAPI is controlled by writing 0/1 to the ``threaded`` file in
-netdev's sysfs directory.
+netdev's sysfs directory. It can also be enabled for a specific napi using
+netlink interface.
+
+For example, using the script:
+
+.. code-block:: bash
+
+  $ kernel-source/tools/net/ynl/pyynl/cli.py \
+            --spec Documentation/netlink/specs/netdev.yaml \
+            --do napi-set \
+            --json='{"id": 66,
+                     "threaded": 1}'
 
 .. rubric:: Footnotes
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0c5b1f7f8f3a..3c244fd9ae6d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -369,6 +369,7 @@ struct napi_config {
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
 	cpumask_t affinity_mask;
+	bool threaded;
 	unsigned int napi_id;
 };
 
@@ -590,6 +591,15 @@ static inline bool napi_complete(struct napi_struct *n)
 
 int dev_set_threaded(struct net_device *dev, bool threaded);
 
+/*
+ * napi_set_threaded - set napi threaded state
+ * @napi: NAPI context
+ * @threaded: whether this napi does threaded polling
+ *
+ * Return 0 on success and negative errno on failure.
+ */
+int napi_set_threaded(struct napi_struct *napi, bool threaded);
+
 void napi_disable(struct napi_struct *n);
 void napi_disable_locked(struct napi_struct *n);
 
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7600bf62dbdf..fac1b8ffeb55 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -134,6 +134,7 @@ enum {
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+	NETDEV_A_NAPI_THREADED,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/dev.c b/net/core/dev.c
index 235560341765..b92e4e8890d1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6806,6 +6806,30 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+int napi_set_threaded(struct napi_struct *napi, bool threaded)
+{
+	if (napi->dev->threaded)
+		return -EINVAL;
+
+	if (threaded) {
+		if (!napi->thread) {
+			int err = napi_kthread_create(napi);
+
+			if (err)
+				return err;
+		}
+	}
+
+	if (napi->config)
+		napi->config->threaded = threaded;
+
+	/* Make sure kthread is created before THREADED bit is set. */
+	smp_mb__before_atomic();
+	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+
+	return 0;
+}
+
 int dev_set_threaded(struct net_device *dev, bool threaded)
 {
 	struct napi_struct *napi;
@@ -6817,6 +6841,11 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 		return 0;
 
 	if (threaded) {
+		/* Check if threaded is set at napi level already */
+		list_for_each_entry(napi, &dev->napi_list, dev_list)
+			if (test_bit(NAPI_STATE_THREADED, &napi->state))
+				return -EINVAL;
+
 		list_for_each_entry(napi, &dev->napi_list, dev_list) {
 			if (!napi->thread) {
 				err = napi_kthread_create(napi);
@@ -7063,6 +7092,8 @@ static void napi_restore_config(struct napi_struct *n)
 		napi_hash_add(n);
 		n->config->napi_id = n->napi_id;
 	}
+
+	napi_set_threaded(n, n->config->threaded);
 }
 
 static void napi_save_config(struct napi_struct *n)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 739f7b6506a6..c2e5cee857d2 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -92,11 +92,12 @@ static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 };
 
 /* NETDEV_CMD_NAPI_SET - do */
-static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT + 1] = {
+static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_THREADED + 1] = {
 	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
 	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
 	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 /* Ops table for netdev */
@@ -187,7 +188,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.cmd		= NETDEV_CMD_NAPI_SET,
 		.doit		= netdev_nl_napi_set_doit,
 		.policy		= netdev_napi_set_nl_policy,
-		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+		.maxattr	= NETDEV_A_NAPI_THREADED,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a186fea63c09..057001c3bbba 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -186,6 +186,9 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
 		goto nla_put_failure;
 
+	if (nla_put_u32(rsp, NETDEV_A_NAPI_THREADED, !!napi->thread))
+		goto nla_put_failure;
+
 	if (napi->thread) {
 		pid = task_pid_nr(napi->thread);
 		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
@@ -324,8 +327,14 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 {
 	u64 irq_suspend_timeout = 0;
 	u64 gro_flush_timeout = 0;
+	u32 threaded = 0;
 	u32 defer = 0;
 
+	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
+		threaded = nla_get_u32(info->attrs[NETDEV_A_NAPI_THREADED]);
+		napi_set_threaded(napi, !!threaded);
+	}
+
 	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
 		defer = nla_get_u32(info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]);
 		napi_set_defer_hard_irqs(napi, defer);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7600bf62dbdf..fac1b8ffeb55 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -134,6 +134,7 @@ enum {
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+	NETDEV_A_NAPI_THREADED,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.49.0.395.g12beb8f557-goog


