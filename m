Return-Path: <netdev+bounces-137600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29A9A7251
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDCB1C228D9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6E81FAC5E;
	Mon, 21 Oct 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LXfUmyr0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CA1FA26D
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535316; cv=none; b=pCOVS+DA4Azn9m0K5EcucZ/jSo8e2RwM33cN1d9qcIGEBP65ktUJm5xMt027hh8HwQERtTuDCqarPfwVI4eYWcUj2JJXP83BpWQD0Y9F+16zIlh0eNfxSSi2ODD/1UqbgdkaLWH40FUweAEPayLbXLTNhWJHdcpeejKxMHtaVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535316; c=relaxed/simple;
	bh=9phmniRB+p2YydWbCMYDY+gb0TGXKGXiJYSX9CmTGpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy+LuNGlzBWPRCA4CYDvrS/EMhuLjl5t7ZDzvfXJkHHHlCxGlCKjr6r1EboFAWE2Lu80jnXb7yTzWTJrF0EYvX0NwbKnUdBvyoLl7bSLc2WZYmulVdNnSYZXt9tx2mLi4ngPnGcnsZ+cQpDCt2yepdQj6IVXNI1uyS861ThC3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LXfUmyr0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c805a0753so40864345ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729535312; x=1730140112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSyI3CyUaFFHrGu+rJ3IzJTwLh2a5uYdcOGIQaWuWS4=;
        b=LXfUmyr0bc773X8qGvFN4Nk/+u1TdZZPWQmkTCnRurKINVx6PXyMV+dqD9Gsj+X5Xe
         n20URlqKoiwrSs/A3RMq8f1/jcDE99iLeSmS2oxP5oYEbI7DHCae/0aA7v8y72aHR5XZ
         WXnMXvevp5TmLQm+anQYxNShmhIu1WaXn3GKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535312; x=1730140112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSyI3CyUaFFHrGu+rJ3IzJTwLh2a5uYdcOGIQaWuWS4=;
        b=RwEhCbdRVKRV3KrkOsW5fMxPiaLh1gM51h0OExvRCMr2p53iAU7T5xg4mtJuLw9zoS
         mV5KOxfZWd6Tjv/KkEK3H503bfhfW+zg9f+bdVdn0rsZRslZEUHCEtRDJUuflcgHSkwD
         ly7uFfghmlV7R9Ph/bOrGBoa0+BNDonk+r1U7vNaRmw7KxoC97a0x05gUN2ke+HMW45Y
         Al/I8lDLswSaxtOmdFqdwlgZ3Mg4Uhrx7m8gWc0qmnnA7XhrGpEeTmET6YlTGkiJH77s
         Y3QTktmNIPTAwou6FXEmeRZipfh6RhG+CZSDlthBrl8/wDLz/cT06E4akfF7xpOVTRNB
         HryQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeUXSZtneyghnaCsEAc6B0xG+NpN34fGEW+nitTJXaIIpC5FAvfO4CGTe2Ox1cuxhYNfRGCCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5qerqXnHZpwQXBMl6VDtLtf9VYKw2+pziwH1cGBK7dTBsfmD9
	RXQPn7bm4AdBzP/XlPK1/X2YaWDAugbLfD8w97emFrpCbFaxKjV+sp10AHZ51g==
X-Google-Smtp-Source: AGHT+IFxQz1H0UseuXuzzeZtw9wA7Tw0sqwLOlCbZRcJDXCVQegZM8dPZxHPZBqWGuAzf6f+jSHs5g==
X-Received: by 2002:a17:902:ce88:b0:20c:a97d:cc7f with SMTP id d9443c01a7336-20e5a8fb24dmr219693765ad.41.1729535311790;
        Mon, 21 Oct 2024 11:28:31 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (43.222.125.34.bc.googleusercontent.com. [34.125.222.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f3c95sm28914195ad.253.2024.10.21.11.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 11:28:31 -0700 (PDT)
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
Subject: [PATCH v3 1/1] binder: report txn errors via generic netlink
Date: Mon, 21 Oct 2024 11:28:20 -0700
Message-ID: <20241021182821.1259487-2-dualli@chromium.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
In-Reply-To: <20241021182821.1259487-1-dualli@chromium.org>
References: <20241021182821.1259487-1-dualli@chromium.org>
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

To prevent making the already bloated binder.c even bigger, a new source
file binder_genl.c is created to host those generic netlink code.

Signed-off-by: Li Li <dualli@google.com>
---
 Documentation/admin-guide/binder_genl.rst |  71 ++++++
 Documentation/admin-guide/index.rst       |   1 +
 drivers/android/Kconfig                   |   1 +
 drivers/android/Makefile                  |   2 +-
 drivers/android/binder.c                  |  82 ++++++-
 drivers/android/binder_genl.c             | 249 ++++++++++++++++++++++
 drivers/android/binder_internal.h         |  31 +++
 drivers/android/binder_trace.h            |  37 ++++
 drivers/android/binderfs.c                |   4 +
 include/uapi/linux/android/binder.h       | 132 ++++++++++++
 10 files changed, 606 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/binder_genl.rst
 create mode 100644 drivers/android/binder_genl.c

diff --git a/Documentation/admin-guide/binder_genl.rst b/Documentation/admin-guide/binder_genl.rst
new file mode 100644
index 000000000000..923a67bbf8ec
--- /dev/null
+++ b/Documentation/admin-guide/binder_genl.rst
@@ -0,0 +1,71 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================
+Generic Netlink for the Android Binder Driver (Binder Genl)
+===========================================================
+
+The Generic Netlink subsystem in the Linux kernel provides a generic way for
+the Linux kernel to communicate to the user space applications. In the kernel
+binder driver, it is used to report various kinds of binder transactions to
+user space administratioin process. The binder driver allows multiple binder
+devices and their correspondign binder contexts. Each binder context has a
+independent Generic Netlink for security reason. To prevent untrusted user
+applications from accessing the netlink data, the kernel driver uses unicast
+mode instead of multicast.
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
+    send(fd, id, BINDER_GENL_SET_REPORT, 0, BINDER_REPORT_ALL);
+
+    // confirm the per-context configuration
+    void *data = recv(fd, BINDER_GENL_CMD_REPLY);
+    __u32 pid =  nla(data)[BINDER_GENL_ATTR_PID];
+    __u32 flags = nla(data)[BINDER_GENL_ATTR_FLAGS];
+
+    // set optional per-process report, overriding the per-context one
+    send(fd, id, BINDER_GENL_SET_REPORT, getpid(),
+                    BINDER_REPORT_FAILED | BINDER_REPORT_OVERRIDE);
+
+    // confirm the optional per-process configuration
+    void *data = recv(fd, BINDER_GENL_CMD_REPLY);
+    __u32 pid =  nla(data)[BINDER_GENL_ATTR_PID];
+    __u32 flags = nla(data)[BINDER_GENL_ATTR_FLAGS];
+
+    // wait and read all binder reports
+    while (running) {
+            void *data = recv(fd, BINDER_GENL_CMD_REPORT);
+            struct binder_report report = nla(data)[BINDER_GENL_ATTR_REPORT];
+
+            // process struct binder_report
+            do_something(&report);
+    }
+
+    // clean up
+    send(fd, id, BINDER_GENL_SET_REPORT, 0, 0);
+    send(fd, id, BINDER_GENL_SET_REPORT, getpid(), 0);
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
index 978740537a1a..c99d6c6ff13b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3678,10 +3678,25 @@ static void binder_transaction(struct binder_proc *proc,
 		return_error_line = __LINE__;
 		goto err_copy_data_failed;
 	}
-	if (t->buffer->oneway_spam_suspect)
+	if (t->buffer->oneway_spam_suspect) {
 		tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
-	else
+		if (binder_genl_report_enabled(proc, BINDER_REPORT_SPAM)) {
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
@@ -3731,8 +3746,24 @@ static void binder_transaction(struct binder_proc *proc,
 		 * process and is put in a pending queue, waiting for the target
 		 * process to be unfrozen.
 		 */
-		if (return_error == BR_TRANSACTION_PENDING_FROZEN)
+		if (return_error == BR_TRANSACTION_PENDING_FROZEN) {
 			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
+			if (binder_genl_report_enabled(proc, BINDER_REPORT_DELAYED)) {
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
@@ -3794,6 +3825,21 @@ static void binder_transaction(struct binder_proc *proc,
 		binder_dec_node_tmpref(target_node);
 	}
 
+	if (binder_genl_report_enabled(proc, BINDER_REPORT_FAILED)) {
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
@@ -6114,6 +6160,11 @@ static int binder_release(struct inode *nodp, struct file *filp)
 
 	binder_defer_work(proc, BINDER_DEFERRED_RELEASE);
 
+	if (proc->pid == proc->context->report_portid) {
+		proc->context->report_portid = 0;
+		proc->context->report_flags = 0;
+	}
+
 	return 0;
 }
 
@@ -6311,6 +6362,26 @@ binder_defer_work(struct binder_proc *proc, enum binder_deferred_state defer)
 	mutex_unlock(&binder_deferred_lock);
 }
 
+/**
+ * binder_find_proc() - set binder report flags
+ * @pid:	the target process
+ */
+struct binder_proc *binder_find_proc(int pid)
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
 static void print_binder_transaction_ilocked(struct seq_file *m,
 					     struct binder_proc *proc,
 					     const char *prefix,
@@ -6920,6 +6991,11 @@ static int __init init_binder_device(const char *name)
 
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
index 000000000000..8f82f039bc17
--- /dev/null
+++ b/drivers/android/binder_genl.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* binder_genl.c
+ *
+ * Android IPC Subsystem
+ *
+ * Copyright (C) 2024 Google, Inc.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/skbuff.h>
+#include <linux/string.h>
+#include <net/sock.h>
+#include <uapi/linux/android/binder.h>
+
+#include "binder_internal.h"
+#include "binder_trace.h"
+
+/*
+ * The default multicast group
+ */
+static const struct genl_multicast_group binder_genl_mcgrps[] = {
+	{ .name = "binder_genl", },
+};
+
+/*
+ * The policy to verify the type of the binder genl data
+ */
+static const struct nla_policy binder_report_policy[BINDER_GENL_ATTR_MAX + 1] = {
+	[BINDER_GENL_ATTR_PID] = { .type = NLA_U32 },
+	[BINDER_GENL_ATTR_FLAGS] = { .type = NLA_U32 },
+};
+
+/**
+ * binder_genl_cmd_doit() - .doit handler for BINDER_GENL_CMD_SET_REPORT
+ * @skb:	the metadata struct passed from netlink driver
+ * @info:	the generic netlink struct passed from netlink driver
+ *
+ * Implements the .doit function to process binder genl commands.
+ */
+static int binder_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	int len;
+	int portid;
+	u32 pid;
+	u32 flags;
+	void *hdr;
+	struct binder_context *context;
+
+	/* Both attributes are required for BINDER_GENL_CMD_SET_REPORT */
+	if (!info->attrs[BINDER_GENL_ATTR_PID] || !info->attrs[BINDER_GENL_ATTR_FLAGS]) {
+		pr_err("Attributes not set\n");
+		return -EINVAL;
+	}
+
+	portid = nlmsg_hdr(skb)->nlmsg_pid;
+	pid = nla_get_u32(info->attrs[BINDER_GENL_ATTR_PID]);
+	flags = nla_get_u32(info->attrs[BINDER_GENL_ATTR_FLAGS]);
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
+	if (nla_put_u32(skb, BINDER_GENL_ATTR_PID, pid))
+		goto cancel_skb;
+
+	if (nla_put_u32(skb, BINDER_GENL_ATTR_FLAGS, flags))
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
+/*
+ * binder_genl_ops - the small version of generic netlink operations
+ */
+static struct genl_small_ops binder_genl_ops[] = {
+	{
+		.cmd = BINDER_GENL_CMD_SET_REPORT,
+		.doit = binder_genl_cmd_doit,
+	}
+};
+
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
+	strscpy(family->name, name, GENL_NAMSIZ);
+	family->version = BINDER_GENL_VERSION;
+	family->maxattr = BINDER_GENL_ATTR_MAX;
+	family->policy	= binder_report_policy;
+	family->small_ops = binder_genl_ops;
+	family->n_small_ops = ARRAY_SIZE(binder_genl_ops);
+	family->mcgrps = binder_genl_mcgrps;
+	family->n_mcgrps = ARRAY_SIZE(binder_genl_mcgrps);
+	ret = genl_register_family(family);
+	if (ret) {
+		pr_err("Failed to register binder genl: %s\n", name);
+		return ret;
+	}
+
+	return 0;
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
+int binder_genl_set_report(struct binder_context *context, u32 pid, u32 flags)
+{
+	struct binder_proc *proc;
+
+	if (flags != (flags & (BINDER_REPORT_ALL | BINDER_REPORT_OVERRIDE))) {
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
+inline bool binder_genl_report_enabled(struct binder_proc *proc, u32 mask)
+{
+	struct binder_context *context = proc->context;
+
+	if (!context->report_portid)
+		return false;
+
+	if (proc->report_flags & BINDER_REPORT_OVERRIDE)
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
+ * Packs the report data into a BINDER_GENL_ATTR_REPORT packet and send it.
+ */
+void binder_genl_send_report(struct binder_context *context,
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
+	if (nla_put(skb, BINDER_GENL_ATTR_REPORT, len, report)) {
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
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index f8d6be682f23..7264d8bedf90 100644
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
@@ -582,4 +602,15 @@ struct binder_object {
 	};
 };
 
+struct binder_proc *binder_find_proc(int pid);
+
+int binder_genl_init(struct genl_family *family, const char *name);
+
+int binder_genl_set_report(struct binder_context *context, u32 pid, u32 flags);
+
+bool binder_genl_report_enabled(struct binder_proc *proc, u32 mask);
+
+void binder_genl_send_report(struct binder_context *context,
+			     struct binder_report *report, int len);
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
index 1fd92021a573..19c49a2a0301 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -588,5 +588,137 @@ enum binder_driver_command_protocol {
 	 */
 };
 
+/*
+ * Name of binder generic netlink
+ */
+#define BINDER_GENL_FAMILY_NAME	"binder"
+
+/*
+ * Version of binder generic netlink
+ */
+#define BINDER_GENL_VERSION	1
+
+/*
+ * Used with BINDER_ENABLE_REPORT, defining what kind of binder transactions
+ * should be reported to user space administration process.
+ */
+enum binder_report_flag {
+	/*
+	 * Report failed binder transactions,
+	 * when the sender gets BR_{FAILED|FROZEN|DEAD}_REPLY
+	 */
+	BINDER_REPORT_FAILED = 0x1,
+
+	/*
+	 * Report delayed async binder transactions due to frozen target,
+	 * when the sender gets BR_TRANSACTION_PENDING_FROZEN.
+	 */
+	BINDER_REPORT_DELAYED = 0x2,
+
+	/*
+	 * Report spamming binder transactions,
+	 * when the sender gets BR_ONEWAY_SPAM_SUSPECT.
+	 */
+	BINDER_REPORT_SPAM = 0x4,
+
+	/*
+	 * Report all of the above
+	 */
+	BINDER_REPORT_ALL = BINDER_REPORT_FAILED
+			| BINDER_REPORT_DELAYED
+			| BINDER_REPORT_SPAM,
+
+	/*
+	 * Enable the per-process flag, which overrides the global one.
+	 */
+	BINDER_REPORT_OVERRIDE = 0x8000000,
+};
+
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
+/*
+ * The supported attributes of binder generic netlink.
+ */
+enum binder_genl_attr {
+	BINDER_GENL_ATTR_UNSPEC = 0,
+
+	/*
+	 * The attribute for BINDER_GENL_CMD_SET_REPORT and its REPLY.
+	 * Contains payload u32 pid.
+	 */
+	BINDER_GENL_ATTR_PID = 1,
+
+	/*
+	 * The attribute for BINDER_GENL_CMD_SET_REPORT and its REPLY.
+	 * Contains payload u32 report_flags;.
+	 */
+	BINDER_GENL_ATTR_FLAGS = 2,
+
+	/*
+	 * The attribute for BINDER_GENL_CMD_REPORT.
+	 * Contains payload struct binder_report.
+	 */
+	BINDER_GENL_ATTR_REPORT = 3,
+
+	BINDER_GENL_ATTR_MAX = BINDER_GENL_ATTR_REPORT,
+};
+
+/*
+ * The supported commands of binder generic netlink.
+ */
+enum binder_genl_cmd {
+	BINDER_GENL_CMD_UNSPEC = 0,
+
+	/*
+	 * The user space administrator process uses this command to set what
+	 * kinds of binder transactions are reported via generic netlink.
+	 */
+	BINDER_GENL_CMD_SET_REPORT = 1,
+
+	/*
+	 * After receiving BINDER_GENL_SET_REPORT from the user space
+	 * administrator process, the kernel binder driver uses this command
+	 * to acknowledge the request.
+	 */
+	BINDER_GENL_CMD_REPLY = 2,
+
+	/*
+	 * After enabling binder report, the kernel binder driver uses this
+	 * command to send the requested reports to the user space.
+	 */
+	BINDER_GENL_CMD_REPORT = 3,
+
+	BINDER_GENL_CMD_MAX = BINDER_GENL_CMD_REPORT,
+};
+
 #endif /* _UAPI_LINUX_BINDER_H */
 
-- 
2.47.0.105.g07ac214952-goog


