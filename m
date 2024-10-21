Return-Path: <netdev+bounces-137626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3221C9A7309
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51711F22726
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649F41FBF6D;
	Mon, 21 Oct 2024 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lIDDq02/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F91FBC8D
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537967; cv=none; b=ikHi8YIjqHUYBprrV0HfspPRyTHDA1g2UDmwpJARKfjOxktRYQtZVmcKNuHrzWGZ2tSU1brmLKFvaEMO9pFJ+22+s/sDq3uiXqzZmGltzNeAXpLjJWxpjOuILoUiW0imGUnVsBGOMXwvKfBeNJyPxNT1fZ1inRJIBkTieWBaxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537967; c=relaxed/simple;
	bh=9jggd3ON4wK9aV6YaKGwpmp8+SzBMupxurHwRrMZVUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=il2xIBj7ltYsLxv5VtQUagiLOrmRw89YqvbhEIMUsJrLt8W37Kvpv49BYnruTxWNT9EGKMQXwkRwBoQt5a7nECaCsg9rL5XhnvYRo1o7iFT6nNWEKXqurWpSiF+3RyGTDHn+QlF1wlmfzf/AwWi6Vh3fmyBNRngKazU6Dyhb5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lIDDq02/; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a3b4663e40so19362045ab.2
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729537963; x=1730142763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Anr0+EzXgd1eI04Md+SE/fDROHbIBSuwkHP3qBMXgI4=;
        b=lIDDq02/7YgiXlvb++pgehSR4or4cYSSBjH/k0PYKqBNUQpfNLS2U3cKsnGXk0nsM4
         i72CTWp3uMSRUScj/DQckDionHkkiRUDCwYIgGbL6AUJOjnMHUWdjRARY5dKimkiICVq
         U3Nc5ntwZpE37VzlwYpLgwle3k5nyhIMNwvQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537963; x=1730142763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Anr0+EzXgd1eI04Md+SE/fDROHbIBSuwkHP3qBMXgI4=;
        b=nTye4/Bk49A/+hoXjke90NxSdaT0BwPMw1kSQnHNryHfTc8PNb4naBXdl5SPnqXsRB
         quHBcX/rsGcbobmJGhz7Tr2qn0R89t133RpgjqY2/KQb2BxCMWLLT3UYlyjkSxrlKX0U
         Tn+xnC59fPb5IVcmoVUxmKJKT/WLYsrYlxIvkX6jYJkLRGtJcY9yja0jFXpym/DFJgzR
         IkTXYZaTxHW2qn8WBGt3YTFQObDhW0ee/S3x4SgeLsIxA8PjaeYSXd3PitULFwLuqajV
         Zq3HgkiV3CGMoMp3uCBWWMIINE/82dkVSEYJnWK9XYtElKIaMqL77vCalktyHCwcqmSu
         BpJw==
X-Forwarded-Encrypted: i=1; AJvYcCWcHIbgfGrV3iNeVTouuzDCfy4uVP38ZGJbeF5dkfx28/lmQX5IeZS9b1AjWdbeY/lQBpDzWcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DkB+HxyzJkpyq6YcqsvykpOCZ1qrW0Z0EOmdzvjv4Nzmj6XE
	kU334GX7ueHlf1ijrQkY+KzKxThww/oMxdVnLc8lCpQu/gSDM09RsQp+3q2kDg==
X-Google-Smtp-Source: AGHT+IEvOOIl6Cuf40UgRfN3JqqutIVBEaFO8ntW+7WAisnxIWuCOn2nyeqLYjvECGbXU+VpdGF9hA==
X-Received: by 2002:a05:6e02:1a83:b0:3a0:c23f:9647 with SMTP id e9e14a558f8ab-3a3f4046c67mr113842635ab.1.1729537962397;
        Mon, 21 Oct 2024 12:12:42 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab581e4sm3502386a12.50.2024.10.21.12.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:12:41 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	arnd@arndb.de,
	masahiroy@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	hridya@google.com,
	smoreland@google.com
Cc: kernel-team@android.com
Subject: [PATCH v4 1/1] binder: report txn errors via generic netlink (genl)
Date: Mon, 21 Oct 2024 12:12:33 -0700
Message-ID: <20241021191233.1334897-2-dualli@chromium.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
In-Reply-To: <20241021191233.1334897-1-dualli@chromium.org>
References: <20241021191233.1334897-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

Frozen tasks can't process binder transactions, so sync binder
transactions will fail with BR_FROZEN_REPLY and async binder
transactions will be queued in the kernel async binder buffer.
As these queued async transactions accumulates over time, the async
buffer will eventually be running out, denying all new transactions
after that with BR_FAILED_REPLY.

In addition to the above cases, different kinds of binder error codes
might be returned to the sender. However, the core Linux, or Android,
system administration process never knows what's actually happening.

This patch introduces the Linux generic netlink messages into the binder
driver so that the Linux/Android system administration process can
listen to important events and take corresponding actions, like stopping
a broken app from attacking the OS by sending huge amount of spamming
binder transactions.

The new binder genl sources and headers are automatically generated from
the corresponding binder_genl YAML spec. Don't modify them directly.

Signed-off-by: Li Li <dualli@google.com>
---
 Documentation/admin-guide/binder_genl.rst    |  92 ++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder_genl.yaml |  59 ++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 287 ++++++++++++++++++-
 drivers/android/binder_genl.c                |  38 +++
 drivers/android/binder_genl.h                |  18 ++
 drivers/android/binder_internal.h            |  22 ++
 drivers/android/binder_trace.h               |  37 +++
 drivers/android/binderfs.c                   |   4 +
 include/uapi/linux/android/binder.h          |  31 ++
 include/uapi/linux/android/binder_genl.h     |  37 +++
 13 files changed, 625 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_genl.rst
 create mode 100644 Documentation/netlink/specs/binder_genl.yaml
 create mode 100644 drivers/android/binder_genl.c
 create mode 100644 drivers/android/binder_genl.h
 create mode 100644 include/uapi/linux/android/binder_genl.h

diff --git a/Documentation/admin-guide/binder_genl.rst b/Documentation/admin-guide/binder_genl.rst
new file mode 100644
index 000000000000..48a0ceab6552
--- /dev/null
+++ b/Documentation/admin-guide/binder_genl.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================
+Generic Netlink for the Android Binder Driver (Binder Genl)
+===========================================================
+
+The Generic Netlink subsystem in the Linux kernel provides a generic way for
+the Linux kernel to communicate to the user space applications. In the kernel
+binder driver, it is used to report various kinds of binder transactions to
+user space administration process. The binder driver allows multiple binder
+devices and their corresponding binder contexts. Each binder context has a
+independent Generic Netlink for security reason. To prevent untrusted user
+applications from accessing the netlink data, the kernel driver uses unicast
+mode instead of multicast.
+
+Basically, the user space code use the "set" command to request what kinds
+of binder transactions should be reported by the kernel binder driver. The
+kernel binder driver use "reply" command to acknowledge the request. The
+"set" command also register the current user space process to receive the
+reports. When the user space process exits, the previous request will be
+reset to prevent any potential leaks.
+
+Currently the binder driver can report binder trasnactiosn that "failed"
+to reach the target process, or that are "delayed" due to the target process
+being frozen by cgroup freezer, or that are considered "spam" according to
+existing logic in binder_alloc.c.
+
+When the specified binder transactions happened, the binder driver uses the
+"report" command to send a generic netlink message to the registered process,
+containing the payload struct binder_report.
+
+More details about the flags, attributes and operations can be found at the
+the doc sections in Documentations/netlink/specs/binder_genl.yaml and the
+kernel-doc comments of the new source code in binder.{h|c}.
+
+Using Binder Genl
+-----------------
+
+The Binder Genl can be used in the same way as any other generic netlink
+drivers. The user space application uses a raw netlink socket to send commands
+to and receive packets from the kernel driver.
+
+NOTE: if the user applications that talks to the Binder Genl driver exits,
+the kernel driver will automatically reset the configuration to the default
+and stop sending more reports to prevent leaking memory.
+
+Usage example (user space pseudo code):
+
+::
+
+    // open netlink socket
+    int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+
+    // bind netlink socket
+    bind(fd, struct socketaddr);
+
+    // get the family id of the binder genl
+    send(fd, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME, "binder");
+    void *data = recv(CTRL_CMD_NEWFAMILY);
+    __u16 id = nla(data)[CTRL_ATTR_FAMILY_ID];
+
+    // enable per-context binder report
+    send(fd, id, BINDER_GENL_CMD_SET, 0, BINDER_GENL_FLAG_FAILED |
+            BINDER_GENL_FLAG_DELAYED);
+
+    // confirm the per-context configuration
+    void *data = recv(fd, BINDER_GENL_CMD_REPLY);
+    __u32 pid =  nla(data)[BINDER_GENL_ATTR_PID];
+    __u32 flags = nla(data)[BINDER_GENL_ATTR_FLAGS];
+
+    // set optional per-process report, overriding the per-context one
+    send(fd, id, BINDER_GENL_CMD_SET, getpid(),
+            BINDER_GENL_FLAG_SPAM | BINDER_REPORT_OVERRIDE);
+
+    // confirm the optional per-process configuration
+    void *data = recv(fd, BINDER_GENL_CMD_REPLY);
+    __u32 pid =  nla(data)[BINDER_GENL_A_ATTR_PID];
+    __u32 flags = nla(data)[BINDER_GENL_A_ATTR_FLAGS];
+
+    // wait and read all binder reports
+    while (running) {
+            void *data = recv(fd, BINDER_GENL_CMD_REPORT);
+            struct binder_report report = nla(data)[BINDER_GENL_A_ATTR_REPORT];
+
+            // process struct binder_report
+            do_something(&report);
+    }
+
+    // clean up
+    send(fd, id, BINDER_GENL_CMD_SET, 0, 0);
+    send(fd, id, BINDER_GENL_CMD_SET, getpid(), 0);
+    close(fd);
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index e85b1adf5908..b3b5cfadffe5 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -79,6 +79,7 @@ configure specific aspects of kernel behavior to your liking.
    aoe/index
    auxdisplay/index
    bcache
+   binder_genl
    binderfs
    binfmt-misc
    blockdev/index
diff --git a/Documentation/netlink/specs/binder_genl.yaml b/Documentation/netlink/specs/binder_genl.yaml
new file mode 100644
index 000000000000..8479580a2856
--- /dev/null
+++ b/Documentation/netlink/specs/binder_genl.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: binder_genl
+protocol: genetlink
+
+doc: Netlink protocol to report binder transaction errors and warnings.
+
+uapi-header: linux/android/binder_genl.h
+
+definitions:
+  -
+    type: flags
+    name: flag
+    doc: Used with "set" and "reply" command below, defining what kind \
+         of binder transactions should be reported to the user space \
+         administration process.
+    value-start: 0
+    entries: [ failed, delayed, spam, override ]
+
+attribute-sets:
+  -
+    name: attr
+    doc: The supported attributes of binder genl.
+    attributes:
+      -
+        name: pid
+        type: u32
+        doc: Used by "set" and "reply" command below, indicating the \
+             binder proc or context to set the flags.
+      -
+        name: flags
+        type: u32
+        doc: Used by "set" and "reply" command below, indicating the \
+             flags to set.
+      -
+        name: report
+        type: binary
+        doc: Used by "report" command below, containing struct binder_report.
+
+operations:
+  list:
+    -
+      name: set
+      doc: Set flags from user space, requesting what kinds of binder \
+           transactions to report.
+      attribute-set: attr
+
+      do:
+        request: &params
+          attributes:
+            - pid
+            - flags
+        reply: *params
+    -
+      name: reply
+      doc: Acknowledge the above "set" request, echoing the same params.
+    -
+      name: report
+      doc: Send the requested binder transaction reports to user space.
diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 07aa8ae0a058..e2fa620934e2 100644
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
index c9d3d0c99c25..d818447fbc4c 100644
--- a/drivers/android/Makefile
+++ b/drivers/android/Makefile
@@ -2,5 +2,5 @@
 ccflags-y += -I$(src)			# needed for trace events
 
 obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
-obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
+obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o binder_genl.o
 obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 978740537a1a..26941338c965 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -72,6 +72,7 @@
 
 #include <linux/cacheflush.h>
 
+#include "binder_genl.h"
 #include "binder_internal.h"
 #include "binder_trace.h"
 
@@ -2984,6 +2985,130 @@ static void binder_set_txn_from_error(struct binder_transaction *t, int id,
 	binder_thread_dec_tmpref(from);
 }
 
+/**
+ * binder_find_proc() - set binder report flags
+ * @pid:	the target process
+ */
+static struct binder_proc *binder_find_proc(int pid)
+{
+	struct binder_proc *proc;
+
+	mutex_lock(&binder_procs_lock);
+	hlist_for_each_entry(proc, &binder_procs, proc_node) {
+		if (proc->pid == pid) {
+			mutex_unlock(&binder_procs_lock);
+			return proc;
+		}
+	}
+	mutex_unlock(&binder_procs_lock);
+
+	return NULL;
+}
+
+/**
+ * binder_genl_set_report() - set binder report flags
+ * @proc:	the binder_proc calling the ioctl
+ * @pid:	the target process
+ * @flags:	the flags to set
+ *
+ * If pid is 0, the flags are applied to the whole binder context.
+ * Otherwise, the flags are applied to the specific process only.
+ */
+static int binder_genl_set_report(struct binder_context *context, u32 pid, u32 flags)
+{
+	struct binder_proc *proc;
+
+	if (flags != (flags & (BINDER_GENL_FLAG_OVERRIDE
+			| BINDER_GENL_FLAG_FAILED
+			| BINDER_GENL_FLAG_DELAYED
+			| BINDER_GENL_FLAG_SPAM))) {
+		pr_err("Invalid binder report flags: %u\n", flags);
+		return -EINVAL;
+	}
+
+	if (!pid) {
+		/* Set the global flags for the whole binder context */
+		context->report_flags = flags;
+	} else {
+		/* Set the per-process flags */
+		proc = binder_find_proc(pid);
+		if (!proc) {
+			pr_err("Invalid binder report pid %u\n", pid);
+			return -EINVAL;
+		}
+
+		proc->report_flags = flags;
+	}
+
+	return 0;
+}
+
+/**
+ * binder_genl_report_enabled() - check if binder genl reports are enabled
+ * @proc:	the binder_proc to check
+ * @mask:	the categories of binder genl reports
+ *
+ * Returns true if certain binder genl reports are enabled for this binder
+ * proc (when per-process overriding takes effect) or context.
+ */
+static bool binder_genl_report_enabled(struct binder_proc *proc, u32 mask)
+{
+	struct binder_context *context = proc->context;
+
+	if (!context->report_portid)
+		return false;
+
+	if (proc->report_flags & BINDER_GENL_FLAG_OVERRIDE)
+		return (proc->report_flags & mask) != 0;
+	else
+		return (context->report_flags & mask) != 0;
+}
+
+/**
+ * binder_genl_send_report() - send one binder genl report
+ * @context:	the binder context
+ * @report:	the binder genl report to send
+ * @len:	the length of the report data
+ *
+ * Packs the report data into a BINDER_GENL_A_ATTR_REPORT packet and send it.
+ */
+static void binder_genl_send_report(struct binder_context *context,
+			     struct binder_report *report, int len)
+{
+	int ret;
+	struct sk_buff *skb;
+	void *hdr;
+
+	trace_binder_send_report(context->name, report, len);
+
+	skb = genlmsg_new(nla_total_size(len), GFP_KERNEL);
+	if (!skb) {
+		pr_err("Failed to alloc binder genl message\n");
+		return;
+	}
+
+	hdr = genlmsg_put(skb, 0, atomic_inc_return(&context->report_seq),
+			  &context->genl_family, 0, BINDER_GENL_CMD_REPORT);
+	if (!hdr) {
+		pr_err("Failed to set binder genl header\n");
+		kfree_skb(skb);
+		return;
+	}
+
+	if (nla_put(skb, BINDER_GENL_A_ATTR_REPORT, len, report)) {
+		genlmsg_cancel(skb, hdr);
+		nlmsg_free(skb);
+		return;
+	}
+
+	genlmsg_end(skb, hdr);
+
+	ret = genlmsg_unicast(&init_net, skb, context->report_portid);
+	if (ret < 0)
+		pr_err("Failed to send binder genl message to %d: %d\n",
+		       context->report_portid, ret);
+}
+
 static void binder_transaction(struct binder_proc *proc,
 			       struct binder_thread *thread,
 			       struct binder_transaction_data *tr, int reply,
@@ -3678,10 +3803,25 @@ static void binder_transaction(struct binder_proc *proc,
 		return_error_line = __LINE__;
 		goto err_copy_data_failed;
 	}
-	if (t->buffer->oneway_spam_suspect)
+	if (t->buffer->oneway_spam_suspect) {
 		tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
-	else
+		if (binder_genl_report_enabled(proc, BINDER_GENL_FLAG_SPAM)) {
+			struct binder_report report;
+
+			report.err = BR_ONEWAY_SPAM_SUSPECT;
+			report.from_pid = proc->pid;
+			report.from_tid = thread->pid;
+			report.to_pid = target_proc ? target_proc->pid : 0;
+			report.to_tid = target_thread ? target_thread->pid : 0;
+			report.reply = reply;
+			report.flags = tr->flags;
+			report.code = tr->code;
+			report.data_size = tr->data_size;
+			binder_genl_send_report(context, &report, sizeof(report));
+		}
+	} else {
 		tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
+	}
 	t->work.type = BINDER_WORK_TRANSACTION;
 
 	if (reply) {
@@ -3731,8 +3871,24 @@ static void binder_transaction(struct binder_proc *proc,
 		 * process and is put in a pending queue, waiting for the target
 		 * process to be unfrozen.
 		 */
-		if (return_error == BR_TRANSACTION_PENDING_FROZEN)
+		if (return_error == BR_TRANSACTION_PENDING_FROZEN) {
 			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
+			if (binder_genl_report_enabled(proc, BINDER_GENL_FLAG_DELAYED)) {
+				struct binder_report report;
+
+				report.err = return_error;
+				report.from_pid = proc->pid;
+				report.from_tid = thread->pid;
+				report.to_pid = target_proc ? target_proc->pid : 0;
+				report.to_tid = target_thread ? target_thread->pid : 0;
+				report.reply = reply;
+				report.flags = tr->flags;
+				report.code = tr->code;
+				report.data_size = tr->data_size;
+				binder_genl_send_report(context, &report,
+							sizeof(report));
+			}
+		}
 		binder_enqueue_thread_work(thread, tcomplete);
 		if (return_error &&
 		    return_error != BR_TRANSACTION_PENDING_FROZEN)
@@ -3794,6 +3950,21 @@ static void binder_transaction(struct binder_proc *proc,
 		binder_dec_node_tmpref(target_node);
 	}
 
+	if (binder_genl_report_enabled(proc, BINDER_GENL_FLAG_FAILED)) {
+		struct binder_report report;
+
+		report.err = return_error;
+		report.from_pid = proc->pid;
+		report.from_tid = thread->pid;
+		report.to_pid = target_proc ? target_proc->pid : 0;
+		report.to_tid = target_thread ? target_thread->pid : 0;
+		report.reply = reply;
+		report.flags = tr->flags;
+		report.code = tr->code;
+		report.data_size = tr->data_size;
+		binder_genl_send_report(context, &report, sizeof(report));
+	}
+
 	binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
 		     "%d:%d transaction %s to %d:%d failed %d/%d/%d, size %lld-%lld line %d\n",
 		     proc->pid, thread->pid, reply ? "reply" :
@@ -6114,6 +6285,11 @@ static int binder_release(struct inode *nodp, struct file *filp)
 
 	binder_defer_work(proc, BINDER_DEFERRED_RELEASE);
 
+	if (proc->pid == proc->context->report_portid) {
+		proc->context->report_portid = 0;
+		proc->context->report_flags = 0;
+	}
+
 	return 0;
 }
 
@@ -6311,6 +6487,84 @@ binder_defer_work(struct binder_proc *proc, enum binder_deferred_state defer)
 	mutex_unlock(&binder_deferred_lock);
 }
 
+/**
+ * binder_genl_nl_set_doit() - .doit handler for BINDER_GENL_CMD_SET
+ * @skb:	the metadata struct passed from netlink driver
+ * @info:	the generic netlink struct passed from netlink driver
+ *
+ * Implements the .doit function to process binder genl commands.
+ */
+int binder_genl_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	int len;
+	int portid;
+	u32 pid;
+	u32 flags;
+	void *hdr;
+	struct binder_context *context;
+
+	/* Both attributes are required for BINDER_GENL_CMD_SET */
+	if (!info->attrs[BINDER_GENL_A_ATTR_PID] || !info->attrs[BINDER_GENL_A_ATTR_FLAGS]) {
+		pr_err("Attributes not set\n");
+		return -EINVAL;
+	}
+
+	portid = nlmsg_hdr(skb)->nlmsg_pid;
+	pid = nla_get_u32(info->attrs[BINDER_GENL_A_ATTR_PID]);
+	flags = nla_get_u32(info->attrs[BINDER_GENL_A_ATTR_FLAGS]);
+	context = container_of(info->family, struct binder_context,
+			       genl_family);
+
+	if (context->report_portid && context->report_portid != portid) {
+		pr_err("No permission to set report flags from %u\n", portid);
+		return -EPERM;
+	}
+
+	if (binder_genl_set_report(context, pid, flags) < 0) {
+		pr_err("Failed to set report flags %u for %u\n", flags, pid);
+		return -EINVAL;
+	}
+
+	len = nla_total_size(sizeof(pid)) + nla_total_size(sizeof(flags));
+	skb = genlmsg_new(len, GFP_KERNEL);
+	if (!skb) {
+		pr_err("Failed to alloc binder genl reply message\n");
+		return -ENOMEM;
+	}
+
+	hdr = genlmsg_put_reply(skb, info, info->family, 0,
+				BINDER_GENL_CMD_REPLY);
+	if (!hdr)
+		goto free_skb;
+
+	if (nla_put_u32(skb, BINDER_GENL_A_ATTR_PID, pid))
+		goto cancel_skb;
+
+	if (nla_put_u32(skb, BINDER_GENL_A_ATTR_FLAGS, flags))
+		goto cancel_skb;
+
+	genlmsg_end(skb, hdr);
+
+	if (genlmsg_reply(skb, info)) {
+		pr_err("Failed to send binder genl reply message\n");
+		return -EFAULT;
+	}
+
+	if (!context->report_portid)
+		context->report_portid = portid;
+
+	return 0;
+
+cancel_skb:
+	pr_err("Failed to add genl header to reply message\n");
+	genlmsg_cancel(skb, hdr);
+
+free_skb:
+	pr_err("Failed to add genl attribute to reply message\n");
+	nlmsg_free(skb);
+	return -EMSGSIZE;
+}
+
 static void print_binder_transaction_ilocked(struct seq_file *m,
 					     struct binder_proc *proc,
 					     const char *prefix,
@@ -6894,6 +7148,28 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
 	{} /* terminator */
 };
 
+/**
+ * binder_genl_init() - initialize binder generic netlink
+ * @family:	the generic netlink family
+ * @name:	the binder device name
+ *
+ * Registers the binder generic netlink family.
+ */
+int binder_genl_init(struct genl_family *family, const char *name)
+{
+	int ret;
+
+	memcpy(family, &binder_genl_nl_family, sizeof(*family));
+	strscpy(family->name, name, GENL_NAMSIZ);
+	ret = genl_register_family(family);
+	if (ret) {
+		pr_err("Failed to register binder genl: %s\n", name);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int __init init_binder_device(const char *name)
 {
 	int ret;
@@ -6920,6 +7196,11 @@ static int __init init_binder_device(const char *name)
 
 	hlist_add_head(&binder_device->hlist, &binder_devices);
 
+	binder_device->context.report_seq = (atomic_t)ATOMIC_INIT(0);
+	ret = binder_genl_init(&binder_device->context.genl_family, name);
+	if (ret < 0)
+		kfree(binder_device);
+
 	return ret;
 }
 
diff --git a/drivers/android/binder_genl.c b/drivers/android/binder_genl.c
new file mode 100644
index 000000000000..c9b9bc5cdfb6
--- /dev/null
+++ b/drivers/android/binder_genl.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder_genl.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "binder_genl.h"
+
+#include <uapi/linux/android/binder_genl.h>
+
+/* BINDER_GENL_CMD_SET - do */
+static const struct nla_policy binder_genl_set_nl_policy[BINDER_GENL_A_ATTR_FLAGS + 1] = {
+	[BINDER_GENL_A_ATTR_PID] = { .type = NLA_U32, },
+	[BINDER_GENL_A_ATTR_FLAGS] = { .type = NLA_U32, },
+};
+
+/* Ops table for binder_genl */
+static const struct genl_split_ops binder_genl_nl_ops[] = {
+	{
+		.cmd		= BINDER_GENL_CMD_SET,
+		.doit		= binder_genl_nl_set_doit,
+		.policy		= binder_genl_set_nl_policy,
+		.maxattr	= BINDER_GENL_A_ATTR_FLAGS,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+};
+
+struct genl_family binder_genl_nl_family __ro_after_init = {
+	.name		= BINDER_GENL_FAMILY_NAME,
+	.version	= BINDER_GENL_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= binder_genl_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(binder_genl_nl_ops),
+};
diff --git a/drivers/android/binder_genl.h b/drivers/android/binder_genl.h
new file mode 100644
index 000000000000..9d68c155b7c4
--- /dev/null
+++ b/drivers/android/binder_genl.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder_genl.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_BINDER_GENL_GEN_H
+#define _LINUX_BINDER_GENL_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/android/binder_genl.h>
+
+int binder_genl_nl_set_doit(struct sk_buff *skb, struct genl_info *info);
+
+extern struct genl_family binder_genl_nl_family;
+
+#endif /* _LINUX_BINDER_GENL_GEN_H */
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index f8d6be682f23..4abc8e3940c3 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -12,15 +12,32 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/uidgid.h>
+#include <net/genetlink.h>
 #include <uapi/linux/android/binderfs.h>
 #include "binder_alloc.h"
 #include "dbitmap.h"
 
+/**
+ * struct binder_context - information about a binder domain
+ * @binder_context_mgr_node: the context manager
+ * @context_mgr_node_lock:   the lock protecting the above context manager node
+ * @binder_context_mgr_uid:  the uid of the above context manager
+ * @name:                    the name of the binder device
+ * @genl_family:             the generic netlink family
+ * @report_portid:           the netlink socket to receive binder reports
+ * @report_flags:            the categories of binder transactions that would
+ *                           be reported (see enum binder_report_flag).
+ * @report_seq:              the seq number of the generic netlink report
+ */
 struct binder_context {
 	struct binder_node *binder_context_mgr_node;
 	struct mutex context_mgr_node_lock;
 	kuid_t binder_context_mgr_uid;
 	const char *name;
+	struct genl_family genl_family;
+	u32 report_portid;
+	u32 report_flags;
+	atomic_t report_seq;
 };
 
 /**
@@ -415,6 +432,8 @@ struct binder_ref {
  * @binderfs_entry:       process-specific binderfs log file
  * @oneway_spam_detection_enabled: process enabled oneway spam detection
  *                        or not
+ * @report_flags:         the categories of binder transactions that would
+ *                        be reported (see enum binder_report_flag).
  *
  * Bookkeeping structure for binder processes
  */
@@ -453,6 +472,7 @@ struct binder_proc {
 	spinlock_t outer_lock;
 	struct dentry *binderfs_entry;
 	bool oneway_spam_detection_enabled;
+	u32 report_flags;
 };
 
 /**
@@ -582,4 +602,6 @@ struct binder_object {
 	};
 };
 
+int binder_genl_init(struct genl_family *family, const char *name);
+
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index fe38c6fc65d0..16e0a7efbe3a 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -423,6 +423,43 @@ TRACE_EVENT(binder_return,
 			  "unknown")
 );
 
+TRACE_EVENT(binder_send_report,
+	TP_PROTO(const char *name, struct binder_report *report, int len),
+	TP_ARGS(name, report, len),
+	TP_STRUCT__entry(
+		__field(const char *, name)
+		__field(uint32_t, err)
+		__field(uint32_t, from_pid)
+		__field(uint32_t, from_tid)
+		__field(uint32_t, to_pid)
+		__field(uint32_t, to_tid)
+		__field(uint32_t, reply)
+		__field(uint32_t, flags)
+		__field(uint32_t, code)
+		__field(binder_size_t, data_size)
+		__field(uint32_t, len)
+	),
+	TP_fast_assign(
+		__entry->name = name;
+		__entry->err = report->err;
+		__entry->from_pid = report->from_pid;
+		__entry->from_tid = report->from_tid;
+		__entry->to_pid = report->to_pid;
+		__entry->to_tid = report->to_tid;
+		__entry->reply = report->reply;
+		__entry->flags = report->flags;
+		__entry->code = report->code;
+		__entry->data_size = report->data_size;
+		__entry->len = len;
+	),
+	TP_printk("%s: %d %d:%d -> %d:%d %s flags=0x08%x code=%d %llu %d",
+		  __entry->name, __entry->err, __entry->from_pid,
+		  __entry->from_tid, __entry->to_pid, __entry->to_tid,
+		  __entry->reply ? "reply" : "",
+		  __entry->flags, __entry->code, __entry->data_size,
+		  __entry->len)
+);
+
 #endif /* _BINDER_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index ad1fa7abc323..b2c5b04bf2ab 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -207,6 +207,10 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	fsnotify_create(root->d_inode, dentry);
 	inode_unlock(d_inode(root));
 
+	ret = binder_genl_init(&device->context.genl_family, name);
+	if (ret < 0)
+		goto err;
+
 	return 0;
 
 err:
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 1fd92021a573..d95776448db9 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -588,5 +588,36 @@ enum binder_driver_command_protocol {
 	 */
 };
 
+/*
+ * struct binder_report - reports an abnormal binder transaction
+ * @err:	copy of binder_driver_return_protocol returned to the sender
+ * @from_pid:	sender pid of the corresponding binder transaction
+ * @from_tid:	sender tid of the corresponding binder transaction
+ * @to_pid:	target pid of the corresponding binder transaction
+ * @to_tid:	target tid of the corresponding binder transaction
+ * @reply:	1 means the txn is a reply, 0 otherwise
+ * @flags:	copy of binder_transaction_data->flags
+ * @code:	copy of binder_transaction_data->code
+ * @data_size:	copy of binder_transaction_data->data_size
+ *
+ * When a binder transaction fails to reach the target process or is not
+ * delivered on time, an error command BR_XXX is returned from the kernel
+ * binder driver to the user space sender. This is considered an abnormal
+ * binder transaction. The most important information about this abnormal
+ * binder transaction will be packed into this binder_report struct and sent
+ * to the registered user space administration process via generic netlink.
+ */
+struct binder_report {
+	__u32 err;
+	__u32 from_pid;
+	__u32 from_tid;
+	__u32 to_pid;
+	__u32 to_tid;
+	__u32 reply;
+	__u32 flags;
+	__u32 code;
+	binder_size_t data_size;
+};
+
 #endif /* _UAPI_LINUX_BINDER_H */
 
diff --git a/include/uapi/linux/android/binder_genl.h b/include/uapi/linux/android/binder_genl.h
new file mode 100644
index 000000000000..ef5289133be5
--- /dev/null
+++ b/include/uapi/linux/android/binder_genl.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder_genl.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_BINDER_GENL_H
+#define _UAPI_LINUX_BINDER_GENL_H
+
+#define BINDER_GENL_FAMILY_NAME		"binder_genl"
+#define BINDER_GENL_FAMILY_VERSION	1
+
+enum binder_genl_flag {
+	BINDER_GENL_FLAG_FAILED = 1,
+	BINDER_GENL_FLAG_DELAYED = 2,
+	BINDER_GENL_FLAG_SPAM = 4,
+	BINDER_GENL_FLAG_OVERRIDE = 8,
+};
+
+enum {
+	BINDER_GENL_A_ATTR_PID = 1,
+	BINDER_GENL_A_ATTR_FLAGS,
+	BINDER_GENL_A_ATTR_REPORT,
+
+	__BINDER_GENL_A_ATTR_MAX,
+	BINDER_GENL_A_ATTR_MAX = (__BINDER_GENL_A_ATTR_MAX - 1)
+};
+
+enum {
+	BINDER_GENL_CMD_SET = 1,
+	BINDER_GENL_CMD_REPLY,
+	BINDER_GENL_CMD_REPORT,
+
+	__BINDER_GENL_CMD_MAX,
+	BINDER_GENL_CMD_MAX = (__BINDER_GENL_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_BINDER_GENL_H */
-- 
2.47.0.105.g07ac214952-goog


