Return-Path: <netdev+bounces-185270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DC6A99941
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8251B83AAE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 20:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5C8269806;
	Wed, 23 Apr 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XR9Fa2T8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64A4315F
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439257; cv=none; b=uBqKpICZAICBNC/h3mazv60Bj1UHdSZXtUJP0Oo2jHOR8VeEkRkQkmy5fcCcsiS40slCjJ4Q8TkIA7ACEtkFzDpwsQ5PuGo/uw1FC6fpMTLsSxABVmNb4cP9TOfQNBRqFrdeG5o9vaGyeDI0SCznLv3HHmXnCB7R/vhmzYu+hm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439257; c=relaxed/simple;
	bh=giqXU66Qp44/2I8kPfwPk6dUTdoaKY7evOr+govLgEI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=diDgdD1OuguBFnavXiMubNkm6cbWCEy+ldWCtbh6u6gGRV56xtdOA3r9g88RsxRGkcarC/2DoI4jbJQfGvJQKPJwvmn0tgqJlutLSlvjecs7jVlGduAwnWzXvg04t4WsDpifgldXQerg1PloHL5BcLFWGkzhkPHW2rWH4WOw5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XR9Fa2T8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225107fbdc7so2160635ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745439255; x=1746044055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KFo7I0MhqS943fs6zOBhjkTKOe3h41ioDOIoLqxpYHQ=;
        b=XR9Fa2T8n3TeTkd575ZeuIKsHfNWzcvnep+scoifF1F49/NBivNWC2wr6FIgdWswry
         +FI9wqlKnO51Bt+fgiR00Nza9agOqL2XN2f4v8yZMyogMnjZXSIkGhNAsmH4pxUpsEEs
         y732t33Vyed8Dyhj/jfvkMWhn+0650foVKlfMb8L/oHNfP3AuRG/DUGW9elDApz3dPvI
         0hSHoyy7Bf+CPfpax0PSo9tg7cKo2GqVHx4NROdMvd88Qil6iy7FuWi/oe4XeahbyoLX
         d5/kdkK8ysbausl55vt2QaXk4C96XfDzlgOi21KwnbhglojI/5OE9YsbZHw7cJy9nHbl
         ApZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439255; x=1746044055;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFo7I0MhqS943fs6zOBhjkTKOe3h41ioDOIoLqxpYHQ=;
        b=N2S5z+KqDuZ5qLhMKUFIfKvXTallAwSv7rSDjL+tmcufrXcijaUTSij2Kogv/NAi94
         rKJCE8yR7Rxj/WpQo/YPoSSq+3RLIEGtMSMEV+Mt35Ip1p99g67jjIOPdEz3cRm6A5E6
         uMjCHMKIo3ikncmVZKM2i9kjaBj6p5qewF8Cm+if5afQ357mTu/W2tt23iZwEospGJ8I
         C2r3I6Aa4heL1KUeRaR0qansUZVE3LIcnGyjsI5/cED+y5r8uF3bR9hxRvsEzyaSb6Uw
         rLegqPEo7G70q34U4y1TdWJp3uROlSYsmguTplbCOso3HHB589OcboyPXR8WejHI9h/1
         6OTA==
X-Gm-Message-State: AOJu0YxZsh6eE5B8UJzovJwkdy6U1sqSJuFJwQnW3levMUwHbpMYubTv
	YtBWf7jw6JMd1X/AdsaUWKsBCoh/ccMBm1o9h8l9nq+HF2qrsV17OlMgTDXnB6Dqf4FnPZ5Ech+
	kTahbmhvZ+g==
X-Google-Smtp-Source: AGHT+IHzxVPMZBjeU/bzivT5kaiHOpXUkHmQBtibCygEyBNXPlI5HNO14GE9Njl47kezro9Qd3H31HkVeIUySA==
X-Received: from pjbqa5.prod.google.com ([2002:a17:90b:4fc5:b0:2fa:15aa:4d2b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3d0d:b0:224:78e:4eb4 with SMTP id d9443c01a7336-22c53611112mr321035445ad.39.1745439254886;
 Wed, 23 Apr 2025 13:14:14 -0700 (PDT)
Date: Wed, 23 Apr 2025 20:14:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250423201413.1564527-1-skhawaja@google.com>
Subject: [PATCH net-next v5] Add support to set napi threaded for individual napi
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
 Documentation/netlink/specs/netdev.yaml  | 10 ++++
 Documentation/networking/napi.rst        | 13 ++++-
 include/linux/netdevice.h                |  1 +
 include/uapi/linux/netdev.h              |  1 +
 net/core/dev.c                           | 23 ++++++++
 net/core/dev.h                           | 20 +++++++
 net/core/netdev-genl-gen.c               |  5 +-
 net/core/netdev-genl.c                   | 10 ++++
 tools/include/uapi/linux/netdev.h        |  1 +
 tools/testing/selftests/net/nl_netdev.py | 67 +++++++++++++++++++++++-
 10 files changed, 147 insertions(+), 4 deletions(-)

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
index d0563ddff6ca..ea3c8a30bb97 100644
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
@@ -7144,6 +7165,8 @@ static void napi_restore_config(struct napi_struct *n)
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
index b64c614a00c4..f7d000a600cf 100644
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
+	uint threaded = 0;
 	u32 defer = 0;
 
+	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
+		threaded = nla_get_uint(info->attrs[NETDEV_A_NAPI_THREADED]);
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
index beaee5e4e2aa..505564818fa8 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import time
+from os import system
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_eq, ksft_ge, ksft_busy_wait
 from lib.py import NetdevFamily, NetdevSimDev, ip
@@ -34,6 +35,70 @@ def napi_list_check(nf) -> None:
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
+
+        # unset napi threaded and verify
+        nf.napi_set({'id': napi0_id, 'threaded': 0})
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 0)
+
+        # set napi threaded for napi0
+        nf.napi_set({'id': napi0_id, 'threaded': 1})
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+
+        # check it is not set for napi1
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 0)
+
+        # set threaded at device level
+        system(f"echo 1 > /sys/class/net/{nsim.ifname}/threaded")
+
+        # check napi threaded is set for both napis
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 1)
+
+        # set napi threaded for napi0
+        nf.napi_set({'id': napi0_id, 'threaded': 1})
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 1)
+
+        # unset threaded at device level
+        system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
+
+        # check napi threaded is unset for both napis
+        napi0 = nf.napi_get({'id': napi0_id})
+        ksft_eq(napi0['threaded'], 0)
+        napi1 = nf.napi_get({'id': napi1_id})
+        ksft_eq(napi1['threaded'], 0)
 
 def nsim_rxq_reset_down(nf) -> None:
     """
@@ -122,7 +187,7 @@ def page_pool_check(nf) -> None:
 def main() -> None:
     nf = NetdevFamily()
     ksft_run([empty_check, lo_check, page_pool_check, napi_list_check,
-              nsim_rxq_reset_down],
+              napi_set_threaded, nsim_rxq_reset_down],
              args=(nf, ))
     ksft_exit()
 

base-commit: b65999e7238e6f2a48dc77c8c2109c48318ff41b
-- 
2.49.0.805.g082f7c87e0-goog


