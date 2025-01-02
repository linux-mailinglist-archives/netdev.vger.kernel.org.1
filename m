Return-Path: <netdev+bounces-154832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 527FF9FFF46
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 20:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC43A38D5
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376A1B3959;
	Thu,  2 Jan 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xTLe0AmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD747E782
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735845152; cv=none; b=LKogbF+yNeB67zUOEX+LkLkH7hFBOhyX042wS2MQk4wa7fHmbcKDqufGVv3gI0JYaUdb6KZWK1C6zhK2VtnSlN+2AxA1peEzmN2dWdA89FFzeFwBSmsG6tqoB9IhilWD00a+9vpkAIyMoAVjMk8/V/iAnBBbgjmXB5onm1+nt0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735845152; c=relaxed/simple;
	bh=zo6/8YAQCyIQuXU4/lKWCrSVK2VkXmHdu/PtgZdpa6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ce0JnjfccAyen580t0BnLi7tNQKqhwWQ2jLryBw9X3hOQBZIqUw6wCBcxYKmE9BoYWLZmcwEh8nlttPo49nExIH9nomqZZXbFbX9Jq4zP/gKntahEaSrIb43A1abOH/wsIxaNP5Xs0U6NMMAHlLpJR5MjecSNqfxZC2FMby0VDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xTLe0AmZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163a2a1ec2so271687175ad.1
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 11:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735845150; x=1736449950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WsLhQBPN9vpFHw6ruKqynGPJwCPsFOx/EOpt8eKOwxk=;
        b=xTLe0AmZxd3weyfw4Dm/e98tamYSZyv4UCL49HEGHeyLrIObWW4zPtIJWtxnIwDh8r
         Go3QcqYVG7JeFZT905v/Tsb+2+eMnNQ/gBpUmgTdcSS724dEjmoMMAsFCRq2OiHiI17V
         Clxe4SOdy+4MMw0j1KgZ/EBZog04MMLJQx5IZ3DSgX/qiZ5I1PnyoScXR4fe30WE6D1A
         agmSks/1s7olsyPbXdOSfN4PuUvrUOedi77iRjI/x7aAET9bOnaXvKMYvf8r+mHND+3H
         tka8DaFA1A1o+sfu4U7wRPs+CPTG8e61EYlhHkKo7Ml9+8DKpr/rxnb7o1thzmTbEOfv
         mmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735845150; x=1736449950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsLhQBPN9vpFHw6ruKqynGPJwCPsFOx/EOpt8eKOwxk=;
        b=XfDqhvIbTs46gRSG4kv/zjPh5bXGGHziQEnBQ1LN2m6OBgpXMOeC31hhhPNeNp+jmO
         o/xZ+p3iDxsHw7a6DHWZUzJcBW2icsKPIXcWJeSWxj4GQ+cLk9MlM9PT9dALv8sNAhLc
         IBDnpKWF2dWwRtNLs7ydIvsCtpPQ42BXbYqUTcSaVd9nCqS/Pzt2P9OOdZdIvVa1ET9i
         bzFcmNjwzeFqREDXKt8adpLk0u7YYWe+xQSG5PRqWHNHlQQ+I4x8+PJUWZXwXFfOWPLb
         OERGweeV0XKGMxpxY1SoACCVPUH09376ajhxmI8gGf0Th7hHqlbPj0zHJYvWMrRP0SpE
         lUYA==
X-Gm-Message-State: AOJu0Yw1Ecy7GiBOsb0WFkGcmU3O/a8FJAozXlndbV1Uw+MUMLZXptWK
	zaqDHNt6mtIXIzRTDfaphTH/gPWZbBi2T5RlSlj2Dtb9ziwK35Puy1yLOsxrOO2dHvpoahgw3/Q
	sY6B709AP9w==
X-Google-Smtp-Source: AGHT+IEs7b2LezGkPyqG6g4+y0GSDtp1RTM7wZ3zQ+o0LDc/6w1z0smL+0/aaGywFM1ThLnqMHa9NXmTYNAEow==
X-Received: from pfbmc2.prod.google.com ([2002:a05:6a00:7682:b0:72b:ccb:c99b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7289:b0:1e0:d4f4:5b39 with SMTP id adf61e73a8af0-1e5e04a0ee8mr77764260637.24.1735845150209;
 Thu, 02 Jan 2025 11:12:30 -0800 (PST)
Date: Thu,  2 Jan 2025 19:12:25 +0000
In-Reply-To: <20250102191227.2084046-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250102191227.2084046-1-skhawaja@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250102191227.2084046-2-skhawaja@google.com>
Subject: [PATCH net-next 1/3] Add support to set napi threaded for individual napi
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

A net device has a threaded sysctl that can be used to enable threaded
napi polling on all of the NAPI contexts under that device. Allow
enabling threaded napi polling at individual napi level using netlink.

Add a new netlink operation `napi-set-threaded` that takes napi `id` and
`threaded` attributes. This will enable the threaded polling on napi
context.

Tested using following command in qemu/virtio-net:
./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
  --do napi-set-threaded       --json '{"id": 513, "threaded": 1}'

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/netlink/specs/netdev.yaml | 19 +++++++++++++
 include/linux/netdevice.h               |  9 ++++++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/dev.c                          | 26 +++++++++++++++++
 net/core/netdev-genl-gen.c              | 13 +++++++++
 net/core/netdev-genl-gen.h              |  2 ++
 net/core/netdev-genl.c                  | 37 +++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h       |  2 ++
 8 files changed, 110 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index cbb544bd6c84..aac343af7246 100644
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
@@ -711,6 +720,16 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+    -
+      name: napi-set-threaded
+      doc: Set threaded napi mode on this napi.
+      attribute-set: napi
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - id
+            - threaded
 
 kernel-family:
   headers: [ "linux/list.h"]
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2593019ad5b1..8f531d528869 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -570,6 +570,15 @@ static inline bool napi_complete(struct napi_struct *n)
 
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
 /**
  *	napi_disable - prevent NAPI from scheduling
  *	@n: NAPI context
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e4be227d3ad6..cefbb8f39ae7 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -125,6 +125,7 @@ enum {
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+	NETDEV_A_NAPI_THREADED,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
@@ -203,6 +204,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_NAPI_SET_THREADED,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/dev.c b/net/core/dev.c
index c7f3dea3e0eb..3c95994323ea 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6628,6 +6628,27 @@ static void init_gro_hash(struct napi_struct *napi)
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
@@ -6637,6 +6658,11 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
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
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index a89cbd8d87c3..93dc74dad6de 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -99,6 +99,12 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPE
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
 };
 
+/* NETDEV_CMD_NAPI_SET_THREADED - do */
+static const struct nla_policy netdev_napi_set_threaded_nl_policy[NETDEV_A_NAPI_THREADED + 1] = {
+	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -190,6 +196,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NETDEV_CMD_NAPI_SET_THREADED,
+		.doit		= netdev_nl_napi_set_threaded_doit,
+		.policy		= netdev_napi_set_threaded_nl_policy,
+		.maxattr	= NETDEV_A_NAPI_THREADED,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index e09dd7539ff2..00c229569b7a 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -34,6 +34,8 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_napi_set_threaded_doit(struct sk_buff *skb,
+				     struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2d3ae0cd3ad2..ace22b24be7e 100644
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
@@ -311,6 +314,40 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+int netdev_nl_napi_set_threaded_doit(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct napi_struct *napi;
+	u32 napi_threaded;
+	u32 napi_id;
+	int err = 0;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_THREADED))
+		return -EINVAL;
+
+	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
+	napi_threaded = nla_get_u32(info->attrs[NETDEV_A_NAPI_THREADED]);
+
+	rtnl_lock();
+
+	napi = napi_by_id(napi_id);
+	if (!napi) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
+		err = -ENOENT;
+		goto napi_set_threaded_failure;
+	}
+
+	err = napi_set_threaded(napi, napi_threaded);
+	if (err)
+		NL_SET_ERR_MSG(info->extack,
+			       "unable to set threaded state of napi");
+
+napi_set_threaded_failure:
+	rtnl_unlock();
+	return err;
+}
+
 static int
 netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e4be227d3ad6..cefbb8f39ae7 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -125,6 +125,7 @@ enum {
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+	NETDEV_A_NAPI_THREADED,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
@@ -203,6 +204,7 @@ enum {
 	NETDEV_CMD_QSTATS_GET,
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
+	NETDEV_CMD_NAPI_SET_THREADED,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.47.1.613.gc27f4b7a9f-goog


