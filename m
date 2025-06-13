Return-Path: <netdev+bounces-197614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3354AD956E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CF33AFCBB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0290243379;
	Fri, 13 Jun 2025 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lB7+7FF/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFED82561B9
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842210; cv=none; b=O2KnSDMQ7mamAfrCWzyYqyHxKLN1T0d+0x9X5+qTItcVy3jM90Do/5pBtiPfs00kr1M2sH+Ab+oxpq+BirCzd2y27FKLsyQk/sNPaMsMJ+GYuD6ebmd7EFbUIuumCsUUlTZuK9/IM1t9LVTUE4IDwccscvaBLCojlQ1GDVlnsU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842210; c=relaxed/simple;
	bh=pUWHxNjcPHF2088rp/dBgcj0W1nDQ752yF4C1O5TE7c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HdVFm040fyzgZPJzuSDGYmCWr4ufnpzh14928y6yV5ljVIeIq5MMCwgpirnlKEWsElNBrIEl2u0StGhW8UmWXo+W1TghDdY5+J13EsYCut7euS9lHcdBrVtRTUDw3YRS6+wtKLb0lOsQBAPzczHoVIcP35tGAAFXiiJv2rfVfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lB7+7FF/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7377139d8b1so2320652b3a.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842208; x=1750447008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3DrMyPAIIRkCIAnmS+Qckn0e30sqgbunoo4v3gkAdEw=;
        b=lB7+7FF/4xomPv4LTcd149OWmLI0Ul5UMUjdjnWDnfRSWnSj5m3P8mJbiBT7BPN3AR
         qiL72pguD5k50n7kVDqvRPF6q2hr7UxUqNiYeb9r8RdlDQmhRP/e8wTUDMhupiOtsLXy
         q3SLzSEKk/2tFDepyGCNrhrMUexqQG8UHGslYGPcunmQ8maaKXtXOrH4qQ7Z2c3IUjJ9
         0CjcN4EMqZXZqXuyTXGdD2Y+EodGdybESsny1N1THe1R32O2NGeiGxupj+Ha0Oa4nCQV
         VFgjTFQCqPx7yObsrOEICvNPHz2x+S3LvE4QD6VHzctulk7HkV8LzivfKMYTko0obRCb
         10Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842208; x=1750447008;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DrMyPAIIRkCIAnmS+Qckn0e30sqgbunoo4v3gkAdEw=;
        b=AGqBodrr6yUPFoOjN/ndGaa88MJAjBwqJOCaurJmEsbXjV4ZacwL08ellN23x0dFEm
         kE5v6Sjcpk89J9ox68bQ7Lefyz+A9edxFsfIr7kszX/OWrFXSbrJmLidju0ZZ7l83qj4
         w2ootjIm/TxJELWZgmEW2l5UhjJFBx66i7xdgH3ZoIIU+fwhscd+78ollJQP2pFtTaXl
         B7VvX3r7ZwekLIshjjvLeKDd+NJO2fN0Rheivd838dXecrJSZxwPNO0VSxcmJwo9wnse
         BgwuM1VNTY9w5sAXyuJxSeYHXhIUt0kCAA+MQ2vKaE7mNrjqbYgiWv+tAbLeZv/0Vd/p
         zleQ==
X-Gm-Message-State: AOJu0YyoyCAbiO435Mddrv43edBw/kmT9Hc+oCaUi2xOfE59Xy1jR4Vd
	2gOJmNQdoj+9joNlVqzOT7XA3dpdio1RZkInXIgC/EQXMq8gPDOfuHLAmokhn3Q/KXf2Q5STBao
	UojaPQqGEnladCA==
X-Google-Smtp-Source: AGHT+IFGLJSSLjzdYiuUjXPB7aHEgNORCeNhUttXcAq48W/tR4kLWTWiD4WkWEuOzVuLsjWsx3U66eh9oag2Zw==
X-Received: from pfun19.prod.google.com ([2002:a05:6a00:7d3:b0:746:7f72:5c50])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23d6:b0:747:b04e:941a with SMTP id d2e1a72fcca58-7489cfee87cmr538308b3a.17.1749842207968;
 Fri, 13 Jun 2025 12:16:47 -0700 (PDT)
Date: Fri, 13 Jun 2025 19:16:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613191646.3693841-1-skhawaja@google.com>
Subject: [PATCH net-next v7] Add support to set napi threaded for individual napi
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

Add a test in `nl_netdev.py` that verifies various cases of threaded
napi being set at napi and at device level.

Tested
 ./tools/testing/selftests/net/nl_netdev.py
 TAP version 13
 1..7
 ok 1 nl_netdev.empty_check
 ok 2 nl_netdev.lo_check
 ok 3 nl_netdev.page_pool_check
 ok 4 nl_netdev.napi_list_check
 ok 5 nl_netdev.dev_set_threaded
 ok 6 nl_netdev.napi_set_threaded
 ok 7 nl_netdev.nsim_rxq_reset_down
 # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---

v7:
 - rebase
 - stop kthread when napi threaded is unset at napi level.
 - Update selftest to verify that kthread PID is not set when threaded
   is disabled at napi level.

v6:
 - Set the threaded property at device level even if the currently set
   value is same. This is to override any per napi settings. Update
   selftest to verify this scenario.
 - Use u8 instead of uint in netdev_nl_napi_set_config implementation.
 - Extend the selftest to verify the existing behaviour that the PID
   stays valid once threaded napi is enabled. It stays valid even after
   disabling the threaded napi. Also verify that the same kthread(PID)
   is reused when threaded napi is enabled again. Will keep this
   behaviour as based on the discussion on v5.

v5:
 - This patch was part of:
 https://lore.kernel.org/netdev/Z92e2kCYXQ_RsrJh@LQ3V64L9R2/T/
 It is being sent separately for the first time.
 - Change threaded attribute type to uint
 - Set napi threaded state when set at napi level. When set at device
   level overwrite the state of each napi. This is the `write all`
   symantics that is also followed by other configurations.
 - Add a test to verify `write all` symantics.

 Documentation/netlink/specs/netdev.yaml  | 10 +++
 Documentation/networking/napi.rst        | 13 +++-
 include/linux/netdevice.h                |  1 +
 include/uapi/linux/netdev.h              |  1 +
 net/core/dev.c                           | 30 +++++++-
 net/core/dev.h                           | 20 ++++++
 net/core/netdev-genl-gen.c               |  5 +-
 net/core/netdev-genl.c                   | 10 +++
 tools/include/uapi/linux/netdev.h        |  1 +
 tools/testing/selftests/net/nl_netdev.py | 91 +++++++++++++++++++++++-
 10 files changed, 175 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index ce4cfec82100..ec2c9d66519b 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -283,6 +283,14 @@ attribute-sets:
         doc: The timeout, in nanoseconds, of how long to suspend irq
              processing, if event polling finds events
         type: uint
+      -
+        name: threaded
+        doc: Whether the napi is configured to operate in threaded polling
+             mode. If this is set to `1` then the NAPI context operates
+             in threaded polling mode.
+        type: uint
+        checks:
+          max: 1
   -
     name: xsk-info
     attributes: []
@@ -694,6 +702,7 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+            - threaded
       dump:
         request:
           attributes:
@@ -746,6 +755,7 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+            - threaded
     -
       name: bind-tx
       doc: Bind dmabuf to netdev for TX
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
index adb14db25798..35947d3e5f93 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -369,6 +369,7 @@ struct napi_config {
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
 	cpumask_t affinity_mask;
+	bool threaded;
 	unsigned int napi_id;
 };
 
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7eb9571786b8..1f3719a9a0eb 100644
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
index 5baa4691074f..78b0f005fffd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6963,6 +6963,31 @@ static void napi_stop_kthread(struct napi_struct *napi)
 	napi->thread = NULL;
 }
 
+int napi_set_threaded(struct napi_struct *napi, bool threaded)
+{
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
+	if (!threaded && napi->thread) {
+		napi_stop_kthread(napi);
+	} else {
+		/* Make sure kthread is created before THREADED bit is set. */
+		smp_mb__before_atomic();
+		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+	}
+
+	return 0;
+}
+
 int dev_set_threaded(struct net_device *dev, bool threaded)
 {
 	struct napi_struct *napi;
@@ -6970,9 +6995,6 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 
 	netdev_assert_locked_or_invisible(dev);
 
-	if (dev->threaded == threaded)
-		return 0;
-
 	if (threaded) {
 		list_for_each_entry(napi, &dev->napi_list, dev_list) {
 			if (!napi->thread) {
@@ -7223,6 +7245,8 @@ static void napi_restore_config(struct napi_struct *n)
 		napi_hash_add(n);
 		n->config->napi_id = n->napi_id;
 	}
+
+	napi_set_threaded(n, n->config->threaded);
 }
 
 static void napi_save_config(struct napi_struct *n)
diff --git a/net/core/dev.h b/net/core/dev.h
index e93f36b7ddf3..b50d118ad014 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -315,6 +315,26 @@ static inline void napi_set_irq_suspend_timeout(struct napi_struct *n,
 	WRITE_ONCE(n->irq_suspend_timeout, timeout);
 }
 
+/**
+ * napi_get_threaded - get the napi threaded state
+ * @n: napi struct to get the threaded state from
+ *
+ * Return: the per-NAPI threaded state.
+ */
+static inline bool napi_get_threaded(struct napi_struct *n)
+{
+	return test_bit(NAPI_STATE_THREADED, &n->state);
+}
+
+/**
+ * napi_set_threaded - set napi threaded state
+ * @n: napi struct to set the threaded state on
+ * @threaded: whether this napi does threaded polling
+ *
+ * Return 0 on success and negative errno on failure.
+ */
+int napi_set_threaded(struct napi_struct *n, bool threaded);
+
 int rps_cpumask_housekeeping(struct cpumask *mask);
 
 #if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 4fc44587f493..0994bd68a7e6 100644
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
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_UINT, 1),
 };
 
 /* NETDEV_CMD_BIND_TX - do */
@@ -193,7 +194,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.cmd		= NETDEV_CMD_NAPI_SET,
 		.doit		= netdev_nl_napi_set_doit,
 		.policy		= netdev_napi_set_nl_policy,
-		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+		.maxattr	= NETDEV_A_NAPI_THREADED,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2afa7b2141aa..754f1ffba3e2 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -184,6 +184,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
 		goto nla_put_failure;
 
+	if (nla_put_uint(rsp, NETDEV_A_NAPI_THREADED,
+			 napi_get_threaded(napi)))
+		goto nla_put_failure;
+
 	if (napi->thread) {
 		pid = task_pid_nr(napi->thread);
 		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
@@ -322,8 +326,14 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 {
 	u64 irq_suspend_timeout = 0;
 	u64 gro_flush_timeout = 0;
+	u8 threaded = 0;
 	u32 defer = 0;
 
+	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
+		threaded = nla_get_u8(info->attrs[NETDEV_A_NAPI_THREADED]);
+		napi_set_threaded(napi, !!threaded);
+	}
+
 	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
 		defer = nla_get_u32(info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]);
 		napi_set_defer_hard_irqs(napi, defer);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7eb9571786b8..1f3719a9a0eb 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -134,6 +134,7 @@ enum {
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+	NETDEV_A_NAPI_THREADED,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index c9109627a741..c8ffade79a52 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -35,6 +35,91 @@ def napi_list_check(nf) -> None:
                 ksft_eq(len(napis), 100,
                         comment=f"queue count after reset queue {q} mode {i}")
 
+def napi_set_threaded(nf) -> None:
+    """
+    Test that verifies various cases of napi threaded
+    set and unset at napi and device level.
+    """
+    with NetdevSimDev(queue_count=2) as nsimdev:
+        nsim = nsimdev.nsims[0]
+
+        ip(f"link set dev {nsim.ifname} up")
+
+        napis = nf.napi_get({'ifindex': nsim.ifindex}, dump=True)
+        ksft_eq(len(napis), 2)
+
+        napi0_id = napis[0]['id']
+        napi1_id = napis[1]['id']
+
+        # set napi threaded and verify
+        nf.napi_set({'id': napi0_id, 'threaded': 1})
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+        ksft_ne(napi0.get('pid'), None)
+
+        # check it is not set for napi1
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1.get('pid'), None)
+
+        ip(f"link set dev {nsim.ifname} down")
+        ip(f"link set dev {nsim.ifname} up")
+
+        # verify if napi threaded is still set
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+        ksft_ne(napi0.get('pid'), None)
+
+        # check it is still not set for napi1
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1.get('pid'), None)
+
+        # unset napi threaded and verify
+        nf.napi_set({'id': napi0_id, 'threaded': 0})
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0.get('pid'), None)
+
+        # set threaded at device level
+        system(f"echo 1 > /sys/class/net/{nsim.ifname}/threaded")
+
+        # check napi threaded is set for both napis
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+        ksft_ne(napi0.get('pid'), None)
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 1)
+        ksft_ne(napi1.get('pid'), None)
+
+        # unset threaded at device level
+        system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
+
+        # check napi threaded is unset for both napis
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0.get('pid'), None)
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1.get('pid'), None)
+
+        # set napi threaded for napi0
+        nf.napi_set({'id': napi0_id, 'threaded': 1})
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+        ksft_ne(napi0.get('pid'), None)
+
+        # unset threaded at device level
+        system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
+
+        # check napi threaded is unset for both napis
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0.get('pid'), None)
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1.get('pid'), None)
+
 def dev_set_threaded(nf) -> None:
     """
     Test that verifies various cases of napi threaded
@@ -56,8 +141,10 @@ def dev_set_threaded(nf) -> None:
 
         # check napi threaded is set for both napis
         napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
         ksft_ne(napi0.get('pid'), None)
         napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 1)
         ksft_ne(napi1.get('pid'), None)
 
         # unset threaded
@@ -65,8 +152,10 @@ def dev_set_threaded(nf) -> None:
 
         # check napi threaded is unset for both napis
         napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 0)
         ksft_eq(napi0.get('pid'), None)
         napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 0)
         ksft_eq(napi1.get('pid'), None)
 
 def nsim_rxq_reset_down(nf) -> None:
@@ -156,7 +245,7 @@ def page_pool_check(nf) -> None:
 def main() -> None:
     nf = NetdevFamily()
     ksft_run([empty_check, lo_check, page_pool_check, napi_list_check,
-              dev_set_threaded, nsim_rxq_reset_down],
+              dev_set_threaded, napi_set_threaded, nsim_rxq_reset_down],
              args=(nf, ))
     ksft_exit()
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


