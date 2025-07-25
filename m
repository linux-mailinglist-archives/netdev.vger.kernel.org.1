Return-Path: <netdev+bounces-210181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6D0B1242A
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10D21898C5E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91C1DF247;
	Fri, 25 Jul 2025 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zcn4GCaG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6666A2417DE
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468725; cv=none; b=EYRLrZHYbVeu2ZG+vLFsnzF3SHqlqqxpoEl67LKm6oZkOkBosL3lC5d1fAHT59LxYYWpryLVT7G0kcn3S/6gc5T2RMYm6GHLBaD9TL6+kNid0OcdgdiYjWTogwEuwQaM/+hLJz8ZDBLFIreHchu86cte2uRZdYh24typTbGzGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468725; c=relaxed/simple;
	bh=ZeGfMMRhTnAG2ctNVuCX1noxNGJYbnkcz1g3/yd2XdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eiQTaYXGnnPBvY5CXnG26YHcwEBhhLaKYVuJwaVUX2QtnjQP+kzpYTrRGuk09U+Gfnry+K3iWnL1Hr57GYWj+de4fX3oyAXxgm3sjBeKZU/TTo3K9IVIa5AJfSRV8l9ygmjaGgTLEl1hwwucPQgQWgMwhW2ytLANItLZLy//CFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zcn4GCaG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23fba8fd56bso2665075ad.2
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753468723; x=1754073523; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hERtp2g6Pc7QoTZ98mMyXxU41JG0va0Re9zNA1XThII=;
        b=zcn4GCaGT2kLhYWeca0zbOccYioV/CxH+cfRs9RPQPvp9jdoNxSQqPsPXp7fFuVunr
         xfuunE32gq3tTVkc4KhiX2gGoxH6AEAqif0M6yHs4kfdA3SdgZglAxMv0d9gqQKJl0Al
         pcTKLD0yHHULukaDJpUGII52RFHuE6yQ+cAztXficfHemKlvUoH9Dp9/ny7nXM29Yq27
         QWBNqJ4+oM1ersI4wf7k0bfbWyaRwHTcfgvO18icxIXYvJXK0r1Orb6oaRAAgHS6De5n
         zYquv4oQfMfFDvZyhKwvApOKjkKgA/rP0l1tNQsW+iLprzNV39ONK9lJjBJWCvVzyHSg
         4o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468723; x=1754073523;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hERtp2g6Pc7QoTZ98mMyXxU41JG0va0Re9zNA1XThII=;
        b=wgkDeCzYlo3ZzkAj0Qes4Lqd4Zss9Op1xP5x79SttnZ8mVNqVr+kIK/aJH24oK9SeX
         N+TUF528v6OAeyrV/BwmmCqJWbj+quOfJL8U2ls/4qNCqTeD0h34oa/F8+YUOhn9ugn+
         JWNmU3ytSOBtyFH1JGYZ+Zsf5GmDjESmNZcyjAspFQRqIAQhT22lSUJSbrO3boQJ9lT7
         ZM0E9meGG6xoCRQ2wMwfUzHFTfSpWS111aB0f/z/QJAmHMUQHr6ovNPa033nc27BpGAo
         QL3tjjw2XXFonK1BvDXULLw+hPBJm5ZRrSw+i+GWNESn870NkY8QQyGreJM7sKaq6Igh
         TIZg==
X-Forwarded-Encrypted: i=1; AJvYcCVI8vXsvMAbwEPtcaiafjPM8AFD46N9AalTItNZHFNVqzKQHuM5I/vV85FK0y4QyVZp+B+hDNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQCvZSR+/fcfegIz/6rPSq873TqDwRPbpeLdwnP/pGpCPbC0i
	bk8JYP2CC5FRgtWgoy7jCeFS8WaGOPw5jDyiWEAJ8vQ1OPTSOBjxPDLpN3LOrGjZKLjVqj7amYg
	VIsAK3QkhwnH71w==
X-Google-Smtp-Source: AGHT+IElnQ3ltmUEMUOrnqr+/5aFfilQzhfxMYT2GQzuCKhfrb3hO0WPIinsgr69dSU9OKlubrsJp7mniL69pw==
X-Received: from plht16.prod.google.com ([2002:a17:903:2f10:b0:23e:3914:f342])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:490b:b0:234:d7c5:a0f6 with SMTP id d9443c01a7336-23fb30aaf67mr34769985ad.31.1753468722686;
 Fri, 25 Jul 2025 11:38:42 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:37:46 +0000
In-Reply-To: <20250725183811.409580-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725183811.409580-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725183811.409580-4-cmllamas@google.com>
Subject: [PATCH v19 3/5] binder: introduce transaction reports via netlink
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Li Li <dualli@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, 
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
index 000000000000..a2e54aa42448
--- /dev/null
+++ b/Documentation/netlink/specs/binder.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Copyright 2025 Google LLC
+#
+---
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
+  headers: ["binder_internal.h"]
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


