Return-Path: <netdev+bounces-139486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937D59B2CA0
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6075B226FD
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCB1D54C1;
	Mon, 28 Oct 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mM8gDk2E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A91D1F7E
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110806; cv=none; b=H8FJtqjfhuJ7xCRQ0nzryRwQ4doiuVDVbpWsrHo0TBMPDMAdauek3zLyKzWDc8d2M4Bca2sN3hJdUuRb3B+ZUsz3NdS5Rjvf4T8WA4mPX2f5ZqRIupNKyvvqwhBj+OICk7/1sVhryUB7GaJkQo9mB0+345QzqgdsKHcrYO64jqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110806; c=relaxed/simple;
	bh=6ouPVA0C1fooLqC1+p1brS+fmhNNGieXihw1nT/W5g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fC6dfHH3QqQo/PeFzlKLWxznNflZcQPKyPn1ya3hpdpLoHkX2RutOzKi1ZMrlgZgCEJexAKHzglECnPoWXbv2nsMpSRCamlxyXX5mMzCcGrE3mK08f1okVsBpxhn4PTBeC2PyVh3ptghcwVzT/bEv0LjDEpgNh8BcuDbOeA1u2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mM8gDk2E; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so579647a12.2
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730110801; x=1730715601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmbHUiCEFtZjUI30Dz6mtbcLx34oGjlBqHO+UMzy/yw=;
        b=mM8gDk2E2tOSMFLmqJRk0wvYtuJKaKEf7VgBpsWQEVID3XwJYM7xEyD6EM2MKAHVgw
         FqYeY7mZv/rxz+ScwO1stO6IiCCgiwJOjx+dUmhWEndByX5S0d9fT4lK+YkN6EvEfkrm
         poirmqei/T+WleKfH/WwTr7EMe0gNkCa78hPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110801; x=1730715601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmbHUiCEFtZjUI30Dz6mtbcLx34oGjlBqHO+UMzy/yw=;
        b=pK03wMM+Bzn88BooMfgRKFIAKwehoP51NWbFKhEzXpWJNC4rVc7EnvwDOGG9MwSFCa
         BOfCoInDpUuVbg+N6n42FCW/qSuLXYmSCfATOwpqzAjNWr/a1ozJffaTtC+gO5cv/kH9
         u8C/G+dHN+zff+MnpbHIpL5JtJceNnjsKC6pWvtbqjsk7iZ2rK+8r2MnZGHizMaxteGB
         mvP8oLg+H+xzM8DTdRn4AB5OFqFLxhQ4Aw3S+Ti0/OZw+zAwS+nSBXnmUtU7tky3nFQt
         aRwXDy1CmrsApcrWsxaBd3H4zpasndrlx5pJmEUf182DCbwZ+7B4wVDJic33ApBXbGXv
         Ow3A==
X-Forwarded-Encrypted: i=1; AJvYcCWnBE4OjJZmf/sf/Zc+IY3Z6jjJlwDYuLakH5K23FQWeVymV9ijqdVksUJef0hRne3fhe5eITU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxad0PO818X+PpF/9E4vja++xePIYaE6793wFSfoV/SFMzqbB1j
	IFJfgaBB3ws922Yl870RMn4WB2W20fA2TNLE9D18yANHCFtclE5t7+J3ox1ZFA==
X-Google-Smtp-Source: AGHT+IH+gHdoqPwafzqzimvqQyAT0FYy2rrB2bcy48Ec7wJIPyJXwcfswWvazKIFYa4en9prP/Y2jQ==
X-Received: by 2002:a05:6a21:44ca:b0:1d9:6a6b:f7a4 with SMTP id adf61e73a8af0-1d9a8520321mr10548904637.49.1730110801009;
        Mon, 28 Oct 2024 03:20:01 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (51.193.125.34.bc.googleusercontent.com. [34.125.193.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3749977sm6768202a91.43.2024.10.28.03.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:20:00 -0700 (PDT)
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
	bagasdotme@gmail.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	hridya@google.com,
	smoreland@google.com
Cc: kernel-team@android.com
Subject: [PATCH net-next v6 1/1] binder: report txn errors via generic netlink
Date: Mon, 28 Oct 2024 03:19:51 -0700
Message-ID: <20241028101952.775731-2-dualli@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241028101952.775731-1-dualli@chromium.org>
References: <20241028101952.775731-1-dualli@chromium.org>
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

Introduce generic netlink messages into the binder driver so that the
Linux/Android system administration process can listen to important
events and take corresponding actions, like stopping a broken app from
attacking the OS by sending huge amount of spamming binder transactions.

The new binder genl sources and headers are automatically generated from
the corresponding binder_genl YAML spec. Don't modify them directly.

Signed-off-by: Li Li <dualli@google.com>
---
 Documentation/admin-guide/binder_genl.rst    |  93 ++++++
 Documentation/admin-guide/index.rst          |   1 +
 Documentation/netlink/specs/binder_genl.yaml |  59 ++++
 drivers/android/Kconfig                      |   1 +
 drivers/android/Makefile                     |   2 +-
 drivers/android/binder.c                     | 302 ++++++++++++++++++-
 drivers/android/binder_genl.c                |  38 +++
 drivers/android/binder_genl.h                |  18 ++
 drivers/android/binder_internal.h            |  22 ++
 drivers/android/binder_trace.h               |  37 +++
 drivers/android/binderfs.c                   |   4 +
 include/uapi/linux/android/binder.h          |  31 ++
 include/uapi/linux/binder_genl.h             |  42 +++
 13 files changed, 642 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_genl.rst
 create mode 100644 Documentation/netlink/specs/binder_genl.yaml
 create mode 100644 drivers/android/binder_genl.c
 create mode 100644 drivers/android/binder_genl.h
 create mode 100644 include/uapi/linux/binder_genl.h

diff --git a/Documentation/admin-guide/binder_genl.rst b/Documentation/admin-guide/binder_genl.rst
new file mode 100644
index 000000000000..32d8693b2243
--- /dev/null
+++ b/Documentation/admin-guide/binder_genl.rst
@@ -0,0 +1,93 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================
+Generic Netlink for the Android Binder Driver (Binder Genl)
+===========================================================
+
+The Generic Netlink subsystem in the Linux kernel provides a generic way for
+the Linux kernel to communicate to the user space applications via binder
+driver. It is used to report various kinds of binder transactions to user
+space administration process. The driver allows multiple binder devices and
+their corresponding binder contexts. Each context has an independent Generic
+Netlink for security reason. To prevent untrusted user applications from
+accessing the netlink data, the kernel driver uses unicast mode instead of
+multicast.
+
+Basically, the user space code uses the "set" command to request what kind
+of binder transactions reported by the kernel binder driver. The driver then
+uses "reply" command to acknowledge the request. The "set" command also
+registers the current user space process to receive the reports. When the
+user space process exits, the previous request will be reset to prevent any
+potential leaks.
+
+Currently the driver can report binder transactions that "failed" to reach
+the target process, or that are "delayed" due to the target process being
+frozen by cgroup freezer, or that are considered "spam" according to existing
+logic in binder_alloc.c.
+
+When the specified binder transactions happen, the driver uses the "report"
+command to send a generic netlink message to the registered process,
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
+drivers. Userspace application uses a raw netlink socket to send commands
+to and receive packets from the kernel driver.
+
+.. note::
+    If the userspace application that talks to the driver exits, the kernel
+    driver will automatically reset the configuration to the default and
+    stop sending more reports to prevent leaking memory.
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
index 000000000000..6c536340ba0d
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
+definitions:
+  -
+    type: flags
+    name: flag
+    doc: |
+      Used with "set" and "reply" command below, defining what kind of binder
+      transactions reported to the user space administration process.
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
+        doc: |
+          Used by "set" and "reply" command below, indicating the binder proc
+          or context to set the flags.
+      -
+        name: flags
+        type: u32
+        doc: |
+          Used by "set" and "reply" command below, indicating the flags to set.
+      -
+        name: report
+        type: binary
+        doc: Used by "report" command below, containing struct binder_report.
+
+operations:
+  list:
+    -
+      name: set
+      doc: |
+        Set flags from user space, requesting what kinds of binder
+        transactions to report.
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
index 978740537a1a..e12760ad77fa 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -72,6 +72,7 @@
 
 #include <linux/cacheflush.h>
 
+#include "binder_genl.h"
 #include "binder_internal.h"
 #include "binder_trace.h"
 
@@ -2984,6 +2985,131 @@ static void binder_set_txn_from_error(struct binder_transaction *t, int id,
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
+ * @context:	the binder context to set the flags
+ * @pid:	the target process
+ * @flags:	the flags to set
+ *
+ * If pid is 0, the flags are applied to the whole binder context.
+ * Otherwise, the flags are applied to the specific process only.
+ */
+static int binder_genl_set_report(struct binder_context *context, u32 pid,
+				  u32 flags)
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
+				    struct binder_report *report, int len)
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
@@ -3678,10 +3804,25 @@ static void binder_transaction(struct binder_proc *proc,
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
@@ -3731,8 +3872,24 @@ static void binder_transaction(struct binder_proc *proc,
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
@@ -3794,6 +3951,21 @@ static void binder_transaction(struct binder_proc *proc,
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
@@ -6114,6 +6286,11 @@ static int binder_release(struct inode *nodp, struct file *filp)
 
 	binder_defer_work(proc, BINDER_DEFERRED_RELEASE);
 
+	if (proc->pid == proc->context->report_portid) {
+		proc->context->report_portid = 0;
+		proc->context->report_flags = 0;
+	}
+
 	return 0;
 }
 
@@ -6311,6 +6488,84 @@ binder_defer_work(struct binder_proc *proc, enum binder_deferred_state defer)
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
@@ -6894,6 +7149,28 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
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
@@ -6913,13 +7190,24 @@ static int __init init_binder_device(const char *name)
 	mutex_init(&binder_device->context.context_mgr_node_lock);
 
 	ret = misc_register(&binder_device->miscdev);
-	if (ret < 0) {
-		kfree(binder_device);
-		return ret;
-	}
+	if (ret < 0)
+		goto err_free_dev;
+
+	binder_device->context.report_seq = (atomic_t)ATOMIC_INIT(0);
+	ret = binder_genl_init(&binder_device->context.genl_family, name);
+	if (ret < 0)
+		goto err_misc_deregister;
 
 	hlist_add_head(&binder_device->hlist, &binder_devices);
 
+	return ret;
+
+err_misc_deregister:
+	misc_deregister(&binder_device->miscdev);
+
+err_free_dev:
+	kfree(binder_device);
+
 	return ret;
 }
 
diff --git a/drivers/android/binder_genl.c b/drivers/android/binder_genl.c
new file mode 100644
index 000000000000..8105765706eb
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
+#include <uapi/linux/binder_genl.h>
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
index 000000000000..a728e44bf161
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
+#include <uapi/linux/binder_genl.h>
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
 
diff --git a/include/uapi/linux/binder_genl.h b/include/uapi/linux/binder_genl.h
new file mode 100644
index 000000000000..a2dd9036c953
--- /dev/null
+++ b/include/uapi/linux/binder_genl.h
@@ -0,0 +1,42 @@
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
+/**
+ * enum binder_genl_flag - Used with "set" and "reply" command below, defining
+ *   what kind of binder transactions reported to the user space administration
+ *   process.
+ */
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
2.47.0.163.g1226f6d8fa-goog


