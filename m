Return-Path: <netdev+bounces-162809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F28A27FFD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 01:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89C57A2066
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A5210F2;
	Wed,  5 Feb 2025 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4B+bMqbE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A380173
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714257; cv=none; b=mk0g/fHFZflNiiCL5bmAeCHFHhODcx+ri2RBf4q1qT3B5OPmc9Aj0YtOR2wabeZFygyGwm2yNiLQVHya2cXlqxgIc0qk+BbioedW3a5S+tyqKwgXv895aedk5XD9de3i8Yrn1Len2PhuT9aB5PeMzZCezrgSZjcnMMUPUTk43rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714257; c=relaxed/simple;
	bh=OLxBWuMtx2j+M5ovKxsDKNL+5xuxny2f+qy2VU/2IcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RQAK/zSHFXZqJwQ1KFVUUNrzs5EMBCvjtw71gO++kl+HsBAT70D9hfYp2MylIyx9C50HVyM049VM/Xrn9ChXKjPNLE3p6kvTGme0V8Hlsabzl7YXauxtSQhpi5ZF4/ZA6LDTulPgmV31seEioaW2ebPNkK+eYbJfHH21Yflnhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4B+bMqbE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2165433e229so138891695ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738714255; x=1739319055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bqYgWXXqNFnskflJl/nYbOag3BEs1qo+1KlWIC2iDTQ=;
        b=4B+bMqbEi2bVZXGkhn+DwJFwayjx2SgQPU1s6KFzdKH8tFqw5+sqSqk4bDGVi2ln2C
         E51MEh1gi8It7yjy64bCO5NF/5PQ5vAuAiP7y0kvVMoXx6KHK5ND+1pKLvNDMXau1gM5
         u59Oa0R6wujGmvheEL/Ir2168GkJBSfnXSd0yGpt/dwXN8H7ZjGjwdwzTFIyhTcJnN1P
         HTiU/C0JAz2XnGizoGOloc2grMohSmRp6hxlgY6UHB0Rar8Zn+i5/MS6DQ5wu5uFASes
         t2+RCHtp/RlHDvAQadq2iyG10cV8VrSzFk4SwP4eu3BR/PZvGfASBqa6tlVeokOs9W61
         wq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714255; x=1739319055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqYgWXXqNFnskflJl/nYbOag3BEs1qo+1KlWIC2iDTQ=;
        b=p9RqkToVQt1jdlDlz1AN57PjnU7AVRyXizy4DceuUbBs9aOPSzPSyMZGklOSkGBK2E
         UKdLfQi9DGMmkopZEiZRAsKcHKA0QC4NQ41frF08vXqFzXPqfVNda2sjPYrUFP2xKVP/
         1KuDKkX6VSGUWPcOrVfxIyBoJ1l3nOJfxxnZsu3XM0Gf+GBGGSdGdXp0A9LQXNJULXyt
         dhZ04EZPSUFd/5m5jvdn1lZeGC6YtFJyPGLqTXUOp/kO/nbeRKECCZOWpO+mJJrucM98
         FbB5Wk+3Sqvj4V90bbH+77dBtOE31mqwgv+fJLuzpx6uC9agM/9a9N+1OsVe5x6EDWFS
         F4Cw==
X-Gm-Message-State: AOJu0YzrBbAH5m1ncAD3SfG1hwr8DVN6OV+sYcGwpPKc27QFJ5yopuMq
	vpQtm/Ej5Tky4/xt1pFaX1CygcQaDkN1lJPChfbl6nfumiRGUrp3it+4pJJsJDiSmd1Yfu1kzHz
	K3ku9rfiC2g==
X-Google-Smtp-Source: AGHT+IHPHx/xCoQgsoowBgqGWc4DZUWKMwSERm9iODPEl5bb7IT28JnuAD0o94g66wu3BJZ2Y0gfLwIviFw/NA==
X-Received: from pga24.prod.google.com ([2002:a05:6a02:4f98:b0:ac8:c775:4d06])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce07:b0:216:414e:aa53 with SMTP id d9443c01a7336-21f17f01ac1mr14372565ad.52.1738714255499;
 Tue, 04 Feb 2025 16:10:55 -0800 (PST)
Date: Wed,  5 Feb 2025 00:10:49 +0000
In-Reply-To: <20250205001052.2590140-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205001052.2590140-2-skhawaja@google.com>
Subject: [PATCH net-next v3 1/4] Add support to set napi threaded for
 individual napi
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com
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
index cbb544bd6c84..785240d60df6 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -268,6 +268,14 @@ attribute-sets:
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
     name: queue
     attributes:
@@ -659,6 +667,7 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+            - threaded
       dump:
         request:
           attributes:
@@ -711,6 +720,7 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+            - threaded
 
 kernel-family:
   headers: [ "linux/list.h"]
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index f970a2be271a..73c83b4533dc 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -413,7 +413,18 @@ dependent). The NAPI instance IDs will be assigned in the opposite
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
index 2a59034a5fa2..a0e485722ed9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -352,6 +352,7 @@ struct napi_config {
 	u64 gro_flush_timeout;
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
+	bool threaded;
 	unsigned int napi_id;
 };
 
@@ -572,6 +573,15 @@ static inline bool napi_complete(struct napi_struct *n)
 
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
index e4be227d3ad6..829648b2ef65 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -125,6 +125,7 @@ enum {
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+	NETDEV_A_NAPI_THREADED,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..50fb234dd7a0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6787,6 +6787,30 @@ static void init_gro_hash(struct napi_struct *napi)
 	napi->gro_bitmask = 0;
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
@@ -6798,6 +6822,11 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
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
@@ -6880,6 +6909,8 @@ static void napi_restore_config(struct napi_struct *n)
 		napi_hash_add(n);
 		n->config->napi_id = n->napi_id;
 	}
+
+	napi_set_threaded(n, n->config->threaded);
 }
 
 static void napi_save_config(struct napi_struct *n)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 996ac6a449eb..a1f80e687f53 100644
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
index 715f85c6b62e..208c3dd768ec 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -183,6 +183,9 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
 		goto nla_put_failure;
 
+	if (nla_put_u32(rsp, NETDEV_A_NAPI_THREADED, !!napi->thread))
+		goto nla_put_failure;
+
 	if (napi->thread) {
 		pid = task_pid_nr(napi->thread);
 		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
@@ -321,8 +324,14 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
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
index e4be227d3ad6..829648b2ef65 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -125,6 +125,7 @@ enum {
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+	NETDEV_A_NAPI_THREADED,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.48.1.362.g079036d154-goog


