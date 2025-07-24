Return-Path: <netdev+bounces-209862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136FDB1114D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 21:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA267AE4EFD
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2DB2E543A;
	Thu, 24 Jul 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxiUYZvS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1452741CE
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383594; cv=none; b=Tcqti4Y7ieyOCsNxtMK52p69uUHpUqTdMqCDqaGBPF9ARso+n3N87rZ0+CG8Tq/haI3XMB7cOvZpnXmyPFeVhgCKG3w8RhITwI1m6M5ShKnevXELn4+hG+Yb+LDfrtes/Z4hxCxQWGFKx6BruJv8mPDHZyoe5JsY4a3j+Rk4hJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383594; c=relaxed/simple;
	bh=uAuKJZCvjNtt6wWp7CzjUCYamLKix0eG2xjEx6ZEcYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cAr1StJm///sqK2AwD5D6oy7KY8SnzDrRuFitRtufNhmbgtFCUOQMAcgfwWii6n7m83cXpl3vG0owtP8+9JHSDXqdXOzsYyadpiSNoYfI1Mkkex8rRFdPoBSXHwO4Cgf/CPcKEt90U2IplltdO/VimvU5uubHpQ2cQMo9MalJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxiUYZvS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23dc7d3e708so9424935ad.3
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753383592; x=1753988392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXG+vZLdSX2QJ24jkyWG0CJkvCMrtxSxSKFgmKZlKx4=;
        b=HxiUYZvSZ6I0FTChZSRalnffQVDRG/Bi1sjiQKbMq6iznx6KNSljrwLPQfPlcMYe4Z
         lI6jiVQm/zU536RDEOpDDxNQHGuPD1WqOpWqhAixPDKocQN8tyUsd7KkJCRHOxYOV5Ml
         gfMppfg8e4pLO7Mm8VPbz4KEqs4zgYpxe6epTESVNl0gnXwCSxLAc3YUbXIvCZcQxXfz
         1tmvrGeO/HT7hAz60QIRlw0BQuyyukLTwxNtqIO1Y/SluTMdg5sdbGR6nkaM2rOsBSq7
         MFB8olRpSMRA99NkIUTrC1mCkB6onUXEy1dK4ep5GFdREi/N8WLIPxId7gBVoVQIKosP
         NwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383592; x=1753988392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXG+vZLdSX2QJ24jkyWG0CJkvCMrtxSxSKFgmKZlKx4=;
        b=bKQ+rnlN1NlbN3JSX06aDqlYk39x0Pm/1sIqtMxzl5qdim9lglYhVjsAH9k0QgISEW
         tEx+MKRp4cupyZbpNQRZ4MPbEED5wx0XF9T7KyWfGLops/Zn6T4ZwHrii+m0MnMMue1L
         Kagat9wOrKqE3rpSa5qphZsQqrnztWAk06PUe3PBGK+4K3WplCGe8luiesyVPB+yiiVS
         8HN1BefQsPgfZ36DY+70LVpe4JUImWVhZWZM8W0oTvTn+4Ita4abXnbi0ggA/0g0W2Fa
         8zQLucgnEnnjfckzregMUI9YFAWSnLyFGgrYruyPL0do34VNyOyfwzdkSX0DYPUuDA60
         em9g==
X-Forwarded-Encrypted: i=1; AJvYcCWX6qew0B2duP2TX7TpwOVD0XRef2fv2P2TDNM1r2FZZxpBVlfTYoagauWAWuWwL6ChM14hHWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXmI/LbVJIh//dLmdgObG8+d4EY90TXaQyhMpbuuKPd7sPKyHF
	ruFcjMuiaphRvUolH1E2qTcFTKYX5Wh20fq2OrnaP2RpyaG+TmYs39rdR3tNR/XxWO976FY8awC
	q4PoWo5gwiwwJIQ==
X-Google-Smtp-Source: AGHT+IEQRExwDvQOH3E7pGEALDcTa7cv41UJ2Ef9Rm7xlBqzyPLOGeWSgQtpaPTNvbLii6U29j+4tadYQVQJVw==
X-Received: from pjbtc16.prod.google.com ([2002:a17:90b:5410:b0:311:462d:cb60])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f391:b0:23c:8f2d:5e22 with SMTP id d9443c01a7336-23f981aed9dmr74699865ad.27.1753383591621;
 Thu, 24 Jul 2025 11:59:51 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:58:57 +0000
In-Reply-To: <20250724185922.486207-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724185922.486207-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724185922.486207-4-cmllamas@google.com>
Subject: [PATCH v18 3/5] binder: introduce transaction reports via netlink
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Li Li <dualli@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Li Li <dualli@google.com>

Introduce a generic netlink multicast event to report binder transaction
failures to userspace. This allows subscribers to monitor these events
and take appropriate actions, such as stopping a misbehaving application
that is spamming a service with huge amount of transactions.

The multicast event contains full details of the failed transactions,
including the sender/target PIDs, payload size and specific error code.
This interface is defined using a YAML spec, from which the UAPI and
kernel headers and source are auto-generated.

Signed-off-by: Li Li <dualli@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 Documentation/netlink/specs/binder.yaml     | 96 +++++++++++++++++++++
 MAINTAINERS                                 |  1 +
 drivers/android/Kconfig                     |  1 +
 drivers/android/Makefile                    |  2 +-
 drivers/android/binder.c                    | 85 +++++++++++++++++-
 drivers/android/binder_netlink.c            | 32 +++++++
 drivers/android/binder_netlink.h            | 21 +++++
 include/uapi/linux/android/binder_netlink.h | 37 ++++++++
 8 files changed, 270 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h

diff --git a/Documentation/netlink/specs/binder.yaml b/Documentation/netlink/specs/binder.yaml
new file mode 100644
index 000000000000..9bf7268dde3d
--- /dev/null
+++ b/Documentation/netlink/specs/binder.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Copyright 2025 Google LLC
+#
+
+name: binder
+protocol: genetlink
+uapi-header: linux/android/binder_netlink.h
+doc: Binder interface over generic netlink
+
+attribute-sets:
+  -
+    name: report
+    doc: |
+      Attributes included within a transaction failure report. The elements
+      correspond directly with the specific transaction that failed, along
+      with the error returned to the sender e.g. BR_DEAD_REPLY.
+
+    attributes:
+      -
+        name: error
+        type: u32
+        doc: The enum binder_driver_return_protocol returned to the sender.
+      -
+        name: context
+        type: string
+        doc: The binder context where the transaction occurred.
+      -
+        name: from_pid
+        type: u32
+        doc: The PID of the sender process.
+      -
+        name: from_tid
+        type: u32
+        doc: The TID of the sender thread.
+      -
+        name: to_pid
+        type: u32
+        doc: |
+          The PID of the recipient process. This attribute may not be present
+          if the target could not be determined.
+      -
+        name: to_tid
+        type: u32
+        doc: |
+          The TID of the recipient thread. This attribute may not be present
+          if the target could not be determined.
+      -
+        name: is_reply
+        type: flag
+        doc: When present, indicates the failed transaction is a reply.
+      -
+        name: flags
+        type: u32
+        doc: The bitmask of enum transaction_flags from the transaction.
+      -
+        name: code
+        type: u32
+        doc: The application-defined code from the transaction.
+      -
+        name: data_size
+        type: u32
+        doc: The transaction payload size in bytes.
+
+operations:
+  list:
+    -
+      name: report
+      doc: |
+        A multicast event sent to userspace subscribers to notify them about
+        binder transaction failures. The generated report provides the full
+        details of the specific transaction that failed. The intention is for
+        programs to monitor these events and react to the failures as needed.
+
+      attribute-set: report
+      mcgrp: report
+      event:
+        attributes:
+          - error
+          - context
+          - from_pid
+          - from_tid
+          - to_pid
+          - to_tid
+          - is_reply
+          - flags
+          - code
+          - data_size
+
+kernel-family:
+  headers: [ "binder_internal.h" ]
+
+mcast-groups:
+  list:
+    -
+      name: report
diff --git a/MAINTAINERS b/MAINTAINERS
index f8c8f682edf6..df8f6b31f2f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1769,6 +1769,7 @@ M:	Suren Baghdasaryan <surenb@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
+F:	Documentation/netlink/specs/binder.yaml
 F:	drivers/android/
 
 ANDROID GOLDFISH PIC DRIVER
diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 5b3b8041f827..75af3cf472c8 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -4,6 +4,7 @@ menu "Android"
 config ANDROID_BINDER_IPC
 	bool "Android Binder IPC Driver"
 	depends on MMU
+	depends on NET
 	default n
 	help
 	  Binder is used in Android for both communication between processes,
diff --git a/drivers/android/Makefile b/drivers/android/Makefile
index c5d47be0276c..f422f91e026b 100644
--- a/drivers/android/Makefile
+++ b/drivers/android/Makefile
@@ -2,5 +2,5 @@
 ccflags-y += -I$(src)			# needed for trace events
 
 obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
-obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
+obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o binder_netlink.o
 obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= tests/
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 95aa1fae53e2..0d37eca514f9 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -74,6 +74,7 @@
 
 #include <linux/cacheflush.h>
 
+#include "binder_netlink.h"
 #include "binder_internal.h"
 #include "binder_trace.h"
 
@@ -2993,6 +2994,67 @@ static void binder_set_txn_from_error(struct binder_transaction *t, int id,
 	binder_thread_dec_tmpref(from);
 }
 
+/**
+ * binder_netlink_report() - report a transaction failure via netlink
+ * @proc:	the binder proc sending the transaction
+ * @t:		the binder transaction that failed
+ * @data_size:	the user provided data size for the transaction
+ * @error:	enum binder_driver_return_protocol returned to sender
+ */
+static void binder_netlink_report(struct binder_proc *proc,
+				  struct binder_transaction *t,
+				  u32 data_size,
+				  u32 error)
+{
+	const char *context = proc->context->name;
+	struct sk_buff *skb;
+	void *hdr;
+
+	if (!genl_has_listeners(&binder_nl_family, &init_net,
+				BINDER_NLGRP_REPORT))
+		return;
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	hdr = genlmsg_put(skb, 0, 0, &binder_nl_family, 0, BINDER_CMD_REPORT);
+	if (!hdr)
+		goto free_skb;
+
+	if (nla_put_u32(skb, BINDER_A_REPORT_ERROR, error) ||
+	    nla_put_string(skb, BINDER_A_REPORT_CONTEXT, context) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_FROM_PID, t->from_pid) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_FROM_TID, t->from_tid))
+		goto cancel_skb;
+
+	if (t->to_proc &&
+	    nla_put_u32(skb, BINDER_A_REPORT_TO_PID, t->to_proc->pid))
+		goto cancel_skb;
+
+	if (t->to_thread &&
+	    nla_put_u32(skb, BINDER_A_REPORT_TO_TID, t->to_thread->pid))
+		goto cancel_skb;
+
+	if (t->is_reply && nla_put_flag(skb, BINDER_A_REPORT_IS_REPLY))
+		goto cancel_skb;
+
+	if (nla_put_u32(skb, BINDER_A_REPORT_FLAGS, t->flags) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_CODE, t->code) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_DATA_SIZE, data_size))
+		goto cancel_skb;
+
+	genlmsg_end(skb, hdr);
+	genlmsg_multicast(&binder_nl_family, skb, 0, BINDER_NLGRP_REPORT,
+			  GFP_KERNEL);
+	return;
+
+cancel_skb:
+	genlmsg_cancel(skb, hdr);
+free_skb:
+	nlmsg_free(skb);
+}
+
 static void binder_transaction(struct binder_proc *proc,
 			       struct binder_thread *thread,
 			       struct binder_transaction_data *tr, int reply,
@@ -3679,10 +3741,13 @@ static void binder_transaction(struct binder_proc *proc,
 		return_error_line = __LINE__;
 		goto err_copy_data_failed;
 	}
-	if (t->buffer->oneway_spam_suspect)
+	if (t->buffer->oneway_spam_suspect) {
 		tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
-	else
+		binder_netlink_report(proc, t, tr->data_size,
+				      BR_ONEWAY_SPAM_SUSPECT);
+	} else {
 		tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
+	}
 
 	if (reply) {
 		binder_enqueue_thread_work(thread, tcomplete);
@@ -3730,8 +3795,11 @@ static void binder_transaction(struct binder_proc *proc,
 		 * process and is put in a pending queue, waiting for the target
 		 * process to be unfrozen.
 		 */
-		if (return_error == BR_TRANSACTION_PENDING_FROZEN)
+		if (return_error == BR_TRANSACTION_PENDING_FROZEN) {
 			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
+			binder_netlink_report(proc, t, tr->data_size,
+					      return_error);
+		}
 		binder_enqueue_thread_work(thread, tcomplete);
 		if (return_error &&
 		    return_error != BR_TRANSACTION_PENDING_FROZEN)
@@ -3789,6 +3857,8 @@ static void binder_transaction(struct binder_proc *proc,
 		binder_dec_node(target_node, 1, 0);
 		binder_dec_node_tmpref(target_node);
 	}
+
+	binder_netlink_report(proc, t, tr->data_size, return_error);
 	kfree(t);
 	binder_stats_deleted(BINDER_STAT_TRANSACTION);
 err_alloc_t_failed:
@@ -7067,12 +7137,19 @@ static int __init binder_init(void)
 		}
 	}
 
-	ret = init_binderfs();
+	ret = genl_register_family(&binder_nl_family);
 	if (ret)
 		goto err_init_binder_device_failed;
 
+	ret = init_binderfs();
+	if (ret)
+		goto err_init_binderfs_failed;
+
 	return ret;
 
+err_init_binderfs_failed:
+	genl_unregister_family(&binder_nl_family);
+
 err_init_binder_device_failed:
 	hlist_for_each_entry_safe(device, tmp, &binder_devices, hlist) {
 		misc_deregister(&device->miscdev);
diff --git a/drivers/android/binder_netlink.c b/drivers/android/binder_netlink.c
new file mode 100644
index 000000000000..f62fbca3143c
--- /dev/null
+++ b/drivers/android/binder_netlink.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "binder_netlink.h"
+
+#include <uapi/linux/android/binder_netlink.h>
+#include <binder_internal.h>
+
+/* Ops table for binder */
+static const struct genl_split_ops binder_nl_ops[] = {
+};
+
+static const struct genl_multicast_group binder_nl_mcgrps[] = {
+	[BINDER_NLGRP_REPORT] = { "report", },
+};
+
+struct genl_family binder_nl_family __ro_after_init = {
+	.name		= BINDER_FAMILY_NAME,
+	.version	= BINDER_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= binder_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(binder_nl_ops),
+	.mcgrps		= binder_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(binder_nl_mcgrps),
+};
diff --git a/drivers/android/binder_netlink.h b/drivers/android/binder_netlink.h
new file mode 100644
index 000000000000..f78b8ec54c53
--- /dev/null
+++ b/drivers/android/binder_netlink.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_BINDER_GEN_H
+#define _LINUX_BINDER_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/android/binder_netlink.h>
+#include <binder_internal.h>
+
+enum {
+	BINDER_NLGRP_REPORT,
+};
+
+extern struct genl_family binder_nl_family;
+
+#endif /* _LINUX_BINDER_GEN_H */
diff --git a/include/uapi/linux/android/binder_netlink.h b/include/uapi/linux/android/binder_netlink.h
new file mode 100644
index 000000000000..b218f96d6668
--- /dev/null
+++ b/include/uapi/linux/android/binder_netlink.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_ANDROID_BINDER_NETLINK_H
+#define _UAPI_LINUX_ANDROID_BINDER_NETLINK_H
+
+#define BINDER_FAMILY_NAME	"binder"
+#define BINDER_FAMILY_VERSION	1
+
+enum {
+	BINDER_A_REPORT_ERROR = 1,
+	BINDER_A_REPORT_CONTEXT,
+	BINDER_A_REPORT_FROM_PID,
+	BINDER_A_REPORT_FROM_TID,
+	BINDER_A_REPORT_TO_PID,
+	BINDER_A_REPORT_TO_TID,
+	BINDER_A_REPORT_IS_REPLY,
+	BINDER_A_REPORT_FLAGS,
+	BINDER_A_REPORT_CODE,
+	BINDER_A_REPORT_DATA_SIZE,
+
+	__BINDER_A_REPORT_MAX,
+	BINDER_A_REPORT_MAX = (__BINDER_A_REPORT_MAX - 1)
+};
+
+enum {
+	BINDER_CMD_REPORT = 1,
+
+	__BINDER_CMD_MAX,
+	BINDER_CMD_MAX = (__BINDER_CMD_MAX - 1)
+};
+
+#define BINDER_MCGRP_REPORT	"report"
+
+#endif /* _UAPI_LINUX_ANDROID_BINDER_NETLINK_H */
-- 
2.50.1.470.g6ba607880d-goog


