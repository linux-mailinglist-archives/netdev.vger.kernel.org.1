Return-Path: <netdev+bounces-186880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2462AA3B69
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEACC7B4126
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50F72749ED;
	Tue, 29 Apr 2025 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KuwOcnqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2E26B96E
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965620; cv=none; b=MT5uqfX5IA3xTeZan4/mI7TmGbnVCplH9WYuHPsuBMzTIl8SGOLBhHiV4901GQTc2KeKEm86i+VIUCKmA0pg1LmCh5HFjcP3+mwbvr453tWfAvtaOjoBz0XdkUlh0J8707GBHPM3TSMSI1Rpm89Pdv0mnP4rVLQ5mFRBtLYnnXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965620; c=relaxed/simple;
	bh=P19oN3TSB41Zb9Rp2rMUpEqqjsH9knNLQf/ODY+iQEQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V8tR8lR0o9uUqiAblT8B3idxHaentdosVj7BSCuR5iKOdZclF8fih4Gt5OM3auAFPNMLEytNKwSOOGywutaYbd06r6r8Ps3LRJ0UtMobrldbU0KmBNaZyJBXjJKWDQrWJ+LF8UogbM7sk5d2VYVV4C0/7PYWIqAUTQ+Tb/EZ87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KuwOcnqz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-309c6e43a9aso10007912a91.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745965618; x=1746570418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MYojEMOzYbDBNQaXXNQDx0qi67ucH9z/J6brMAnDm2A=;
        b=KuwOcnqz7fXT3ZQlMZP4uTARcMMFLsGouJjkerrv4ynn5d+42gWebOkaFeNk/y+UWU
         NYq5uNZTbQzHRGdRwlFrWnsaZqXMaY9n45TAztGWpqbIbACHtH4YDuSXOm2bNs+lw49w
         AzE3xHeFH5NOO31lPnck37REDBdpz30oj8AezLd/cDar2r90ymL8Xl4YvmwYtLx1T3FX
         EB/y6KTGGbBr3Zb00il8xG4U2F3XPGrTJeU8s8LjG+6d4Npg96tYKQ6BeqJ5lFwrLt1Y
         2PFIOMHqHDER+kSTlncZtgOunKNL440+tVeDsaom8zyG48QgL//oDDOSIAo60DJoFUrn
         2fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745965618; x=1746570418;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYojEMOzYbDBNQaXXNQDx0qi67ucH9z/J6brMAnDm2A=;
        b=SLqcHOps7TLY7NO0dGM7VrijQjpmx0GJjSMsuw1csdEz22DmZq0QKqmnvNudF66q5h
         MQoBZteANTOqVVWovbpPMGAFGf4JZh3NjqM6vuK6gMwMtsZiIInpmdzFiFmC/erPG9pF
         34lisS9Zvjx0AkCR7+4Ka/DZGdA9VaCrksJYT50AQXn1OF63+SZac8ulyJigoWFDhE2I
         cIdNi3pKRUWFUPtkFFO+vEqyETOMzIIj6nHhQ0+e4qHJZ59Cku70cWwnr8LIIIytlER4
         dmBtw0z9jZLwmDoIpbGmL9ZoZgS9KnqakuSfAWGep3pzwDwFa1DYRzvbquuXAPWxmkD2
         UhVg==
X-Gm-Message-State: AOJu0Ywk1jwh8kqKwginMzidtS4UtgAy9ptLCkzjz1aop0TQL/lGywm9
	YGlnyYmOaCg0MGi5lT/0MMXeZsOLaqxFUb+vnrnmT2iVd5pVzIRhLHzxREZa/xhKzd8OI/bA6kW
	2xQ0/LMaMzQ==
X-Google-Smtp-Source: AGHT+IG/qN45nQ9othtPkoxH9YDurHLv+DjwfVAfvvMrc8VLCrpCG/Gg0c+zj+Bd5fZn5WB9XBCIRE/nST45MQ==
X-Received: from pjj13.prod.google.com ([2002:a17:90b:554d:b0:2fa:1803:2f9f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4984:b0:2ff:58b8:5c46 with SMTP id 98e67ed59e1d1-30a344025abmr514554a91.8.1745965618206;
 Tue, 29 Apr 2025 15:26:58 -0700 (PDT)
Date: Tue, 29 Apr 2025 22:26:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429222656.936279-1-skhawaja@google.com>
Subject: [PATCH net-next v6] Add support to set napi threaded for individual napi
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
 1..6
 ok 1 nl_netdev.empty_check
 ok 2 nl_netdev.lo_check
 ok 3 nl_netdev.page_pool_check
 ok 4 nl_netdev.napi_list_check
 ok 5 nl_netdev.napi_set_threaded
 ok 6 nl_netdev.nsim_rxq_reset_down
 # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

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

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 Documentation/netlink/specs/netdev.yaml  | 10 +++
 Documentation/networking/napi.rst        | 13 +++-
 include/linux/netdevice.h                |  1 +
 include/uapi/linux/netdev.h              |  1 +
 net/core/dev.c                           | 26 ++++++-
 net/core/dev.h                           | 20 ++++++
 net/core/netdev-genl-gen.c               |  5 +-
 net/core/netdev-genl.c                   | 10 +++
 tools/include/uapi/linux/netdev.h        |  1 +
 tools/testing/selftests/net/nl_netdev.py | 89 +++++++++++++++++++++++-
 10 files changed, 169 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index f5e0750ab71d..c9d190fe1f05 100644
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
+        type: uint
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
index d8544f6a680c..3817720e8b24 100644
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
index d0563ddff6ca..4197bfaf2c33 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6888,6 +6888,27 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
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
@@ -6895,9 +6916,6 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 
 	netdev_assert_locked_or_invisible(dev);
 
-	if (dev->threaded == threaded)
-		return 0;
-
 	if (threaded) {
 		list_for_each_entry(napi, &dev->napi_list, dev_list) {
 			if (!napi->thread) {
@@ -7144,6 +7162,8 @@ static void napi_restore_config(struct napi_struct *n)
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
index 739f7b6506a6..2791b6b232fa 100644
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
index b64c614a00c4..60bad7a23c94 100644
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
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index beaee5e4e2aa..79379b94491f 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import time
+from os import system
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_eq, ksft_ge, ksft_busy_wait
 from lib.py import NetdevFamily, NetdevSimDev, ip
@@ -34,6 +35,92 @@ def napi_list_check(nf) -> None:
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
+
+        ip(f"link set dev {nsim.ifname} down")
+        ip(f"link set dev {nsim.ifname} up")
+
+        # verify if napi threaded is still set
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+        # save napi0 pid
+        napi0_pid = napi0['pid']
+
+        # unset napi threaded and verify
+        nf.napi_set({'id': napi0_id, 'threaded': 0})
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0['pid'], napi0_pid)
+
+        # set napi threaded for napi0
+        nf.napi_set({'id': napi0_id, 'threaded': 1})
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+
+        # check it is not set for napi1
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1.get('pid'), None)
+
+        # set threaded at device level
+        system(f"echo 1 > /sys/class/net/{nsim.ifname}/threaded")
+
+        # check napi threaded is set for both napis
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['pid'], napi0_pid)
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 1)
+
+        # save napi1 pid
+        napi1_pid = napi1['pid']
+
+        # unset threaded at device level
+        system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
+
+        # check napi threaded is unset for both napis
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0['pid'], napi0_pid)
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1['pid'], napi1_pid)
+
+        # set napi threaded for napi0
+        nf.napi_set({'id': napi0_id, 'threaded': 1})
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+        ksft_eq(napi0['pid'], napi0_pid)
+
+        # unset threaded at device level
+        system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
+
+        # check napi threaded is unset for both napis
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 0)
+        ksft_eq(napi0['pid'], napi0_pid)
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 0)
+        ksft_eq(napi1['pid'], napi1_pid)
 
 def nsim_rxq_reset_down(nf) -> None:
     """
@@ -122,7 +209,7 @@ def page_pool_check(nf) -> None:
 def main() -> None:
     nf = NetdevFamily()
     ksft_run([empty_check, lo_check, page_pool_check, napi_list_check,
-              nsim_rxq_reset_down],
+              napi_set_threaded, nsim_rxq_reset_down],
              args=(nf, ))
     ksft_exit()
 

base-commit: b65999e7238e6f2a48dc77c8c2109c48318ff41b
-- 
2.49.0.850.g28803427d3-goog


