Return-Path: <netdev+bounces-138197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9185D9AC930
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BF31C20D77
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1259C1ABEC1;
	Wed, 23 Oct 2024 11:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851F1AB6FD;
	Wed, 23 Oct 2024 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683524; cv=none; b=TsvLapRM20oioTueMSmW25+eu9Psy8suzYKcDoj4cu7VHSLA+fK1D/wJRvo/5KG18AgWlvCvsFtkrVaDjIvfsaKk5pwRjGNK4hzJW+37v6oUO77m7CvVSHmV/ZSu17O7I0TYaDUwVpbcyZb1EeDfYcN/XGio/8Y63+Phzc/Ca2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683524; c=relaxed/simple;
	bh=i31XyK2vgwX1NPpOXxt6wlqyNMDW4ACm5lZTNmYd/1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QYw8hlUh3+IRiHX5ZNCEyzT9/iOvcXvlpXvn0TiXgFnGK/7HWYU9ATxtVucaw43sCEjpXiq80//ImCDRJ6/S5i44wHeRT8qRTVrqLIneTT5YDGkpNgCHkAj/oKofoJsC+5NDP075D3rm3tAixdB0JY5tfTJa57drkE5PZM7pLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99ebb390a5so139653066b.1;
        Wed, 23 Oct 2024 04:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729683520; x=1730288320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aecJTtuPvMKah+MwPqDZCjfTbDSusZK+Dg/YuoYbP24=;
        b=iKRLKwJDrMlD4BScEmTLv8H/dgTOgTO/fJHCjRvkN9Wuj1CZi6BOMOE7toG+ZLFxKO
         qlIItP0uxtQ89xCaO/e9yUNnZ6+fslYLkudt9qLKtSgjcRuV591tdW/ziMr1ei3HyqhT
         6NE6a0DGuVKMrgsdeiekaeqQv6C07X6w5+R7j8iLaQvSRdNZ72gBWLyVEgiCFcSPmkR6
         TWQCQxA9SGgNF1A8kR5yUFmjc5Vkj7+UfbBfgqj/tNm3RiPAdGZ3Oec9YFpdpppfaMET
         YhNRAhYO7g15cZB/AEWibDIqHpevYq+a4/SM/pivYWwjtTFvkYiWps97G6gm5OGdPcYE
         zDDw==
X-Forwarded-Encrypted: i=1; AJvYcCUNBXhnQZC1zeQkpS/eiEwwXGzXu2Dla9Umi4/IHtTW9BFiUZTySYwuQkivU78sZzVVI5n3xYlCYjCH3KrE@vger.kernel.org, AJvYcCWFshWTttDcxRqBOl0e6NjpJxCFcAdfJ7w5nwQUD2AVHQJk2+i/Q9SBlO4PaKgKtYkNV0kzCRqK@vger.kernel.org, AJvYcCXbdsbPcjZRzWyLQc5XFmOFtFPE2OK80czq/i0nFEsSGtPbaVg6+f548USRbGKFC+yt+txUyyGSmgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcPg5crSeSmvVzLkalgBk+rVVxbQesu0nHyy6nezle0Lxf6Cm
	cavv/8KnDsJv/LMyinw8BOG5LVUKM0jkDOu1KR5b/JE/qKNBeBvB
X-Google-Smtp-Source: AGHT+IGRqxUvtj9gIfXPKcYqA0sxjCnULqij7OnxanjBxZ80LBaAhwWZvXM+bxDpD2T4EpmT9NIRVA==
X-Received: by 2002:a17:907:3e10:b0:a9a:3c94:23c4 with SMTP id a640c23a62f3a-a9abf1ff5dbmr251809366b.22.1729683519696;
        Wed, 23 Oct 2024 04:38:39 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9157221asm462868966b.161.2024.10.23.04.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 04:38:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@meta.com,
	Thomas Huth <thuth@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH net-next v4] net: Implement fault injection forcing skb reallocation
Date: Wed, 23 Oct 2024 04:38:01 -0700
Message-ID: <20241023113819.3395078-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a fault injection mechanism to force skb reallocation. The
primary goal is to catch bugs related to pointer invalidation after
potential skb reallocation.

The fault injection mechanism aims to identify scenarios where callers
retain pointers to various headers in the skb but fail to reload these
pointers after calling a function that may reallocate the data. This
type of bug can lead to memory corruption or crashes if the old,
now-invalid pointers are used.

By forcing reallocation through fault injection, we can stress-test code
paths and ensure proper pointer management after potential skb
reallocations.

Add a hook for fault injection in the following functions:

 * pskb_trim_rcsum()
 * pskb_may_pull_reason()
 * pskb_trim()

As the other fault injection mechanism, protect it under a debug Kconfig
called CONFIG_FAIL_SKB_REALLOC.

This patch was *heavily* inspired by Jakub's proposal from:
https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/

CC: Akinobu Mita <akinobu.mita@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
Changelog:
v4:
 * Add entry in kernel-parameters.txt (Paolo)
 * Renamed the config to fail_skb_realloc (Akinobu)
 * Fixed the documentation format (Bagas)

v3:
 * Remove decision part of skb_might_realloc() into a new function
   should_fail_net_realloc_skb(). Marked it as ALLOW_ERROR_INJECTION,
   so it could be controlled by fail_function and BPF (Paolo)
 * https://lore.kernel.org/all/20241014135015.3506392-1-leitao@debian.org/

v2:
 * Moved the CONFIG_FAIL_SKB_FORCE_REALLOC Kconfig entry closer to other
   fault injection Kconfigs.  (Kuniyuki Iwashima)
 * Create a filter mechanism (Akinobu Mita)
 * https://lore.kernel.org/all/20241008111358.1691157-1-leitao@debian.org/

v1:
 * https://lore.kernel.org/all/20241002113316.2527669-1-leitao@debian.org/

 .../admin-guide/kernel-parameters.txt         |   1 +
 .../fault-injection/fault-injection.rst       |  36 ++++++
 include/linux/skbuff.h                        |   9 ++
 lib/Kconfig.debug                             |  10 ++
 net/core/Makefile                             |   1 +
 net/core/skb_fault_injection.c                | 103 ++++++++++++++++++
 6 files changed, 160 insertions(+)
 create mode 100644 net/core/skb_fault_injection.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..2fb830453dcc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1546,6 +1546,7 @@
 	failslab=
 	fail_usercopy=
 	fail_page_alloc=
+	fail_skb_realloc=
 	fail_make_request=[KNL]
 			General fault injection mechanism.
 			Format: <interval>,<probability>,<space>,<times>
diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 8b8aeea71c68..c50c8023200a 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -45,6 +45,28 @@ Available fault injection capabilities
   ALLOW_ERROR_INJECTION() macro, by setting debugfs entries
   under /sys/kernel/debug/fail_function. No boot option supported.
 
+- fail_skb_realloc
+
+  inject skb (socket buffer) reallocation events into the network path. The
+  primary goal is to identify and prevent issues related to pointer
+  mismanagement in the network subsystem.  By forcing skb reallocation at
+  strategic points, this feature creates scenarios where existing pointers to
+  skb headers become invalid.
+
+  When the fault is injected and the reallocation is triggered, these pointers
+  no longer reference valid memory locations. This deliberate invalidation
+  helps expose code paths where proper pointer updating is neglected after a
+  reallocation event.
+
+  By creating these controlled fault scenarios, the system can catch instances
+  where stale pointers are used, potentially leading to memory corruption or
+  system instability.
+
+  To select the interface to act on, write the network name to the following file:
+  `/sys/kernel/debug/fail_skb_realloc/devname`
+  If this field is left empty (which is the default value), skb reallocation
+  will be forced on all network interfaces.
+
 - NVMe fault injection
 
   inject NVMe status code and retry flag on devices permitted by setting
@@ -216,6 +238,19 @@ configuration of fault-injection capabilities.
 	use a negative errno, you better use 'printf' instead of 'echo', e.g.:
 	$ printf %#x -12 > retval
 
+- /sys/kernel/debug/fail_skb_realloc/devname:
+
+        Specifies the network interface on which to force SKB reallocation.  If
+        left empty, SKB reallocation will be applied to all network interfaces.
+
+        Example usage::
+
+          # Force skb reallocation on eth0
+          echo "eth0" > /sys/kernel/debug/fail_skb_realloc/devname
+
+          # Clear the selection and force skb reallocation on all interfaces
+          echo "" > /sys/kernel/debug/fail_skb_realloc/devname
+
 Boot option
 ^^^^^^^^^^^
 
@@ -227,6 +262,7 @@ use the boot option::
 	fail_usercopy=
 	fail_make_request=
 	fail_futex=
+	fail_skb_realloc=
 	mmc_core.fail_request=<interval>,<probability>,<space>,<times>
 
 proc entries
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 48f1e0fa2a13..285e36a5e5d7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2681,6 +2681,12 @@ static inline void skb_assert_len(struct sk_buff *skb)
 #endif /* CONFIG_DEBUG_NET */
 }
 
+#if defined(CONFIG_FAIL_SKB_REALLOC)
+void skb_might_realloc(struct sk_buff *skb);
+#else
+static inline void skb_might_realloc(struct sk_buff *skb) {}
+#endif
+
 /*
  *	Add data to an sk_buff
  */
@@ -2781,6 +2787,7 @@ static inline enum skb_drop_reason
 pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
 {
 	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_might_realloc(skb);
 
 	if (likely(len <= skb_headlen(skb)))
 		return SKB_NOT_DROPPED_YET;
@@ -3216,6 +3223,7 @@ static inline int __pskb_trim(struct sk_buff *skb, unsigned int len)
 
 static inline int pskb_trim(struct sk_buff *skb, unsigned int len)
 {
+	skb_might_realloc(skb);
 	return (len < skb->len) ? __pskb_trim(skb, len) : 0;
 }
 
@@ -3970,6 +3978,7 @@ int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len);
 
 static inline int pskb_trim_rcsum(struct sk_buff *skb, unsigned int len)
 {
+	skb_might_realloc(skb);
 	if (likely(len >= skb->len))
 		return 0;
 	return pskb_trim_rcsum_slow(skb, len);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..52bb27115185 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2115,6 +2115,16 @@ config FAIL_SUNRPC
 	  Provide fault-injection capability for SunRPC and
 	  its consumers.
 
+config FAIL_SKB_REALLOC
+	bool "Fault-injection capability forcing skb to reallocate"
+	depends on FAULT_INJECTION_DEBUG_FS
+	help
+	  Provide fault-injection capability that forces the skb to be
+	  reallocated, caughting possible invalid pointers to the skb.
+
+	  For more information, check
+	  Documentation/dev-tools/fault-injection/fault-injection.rst
+
 config FAULT_INJECTION_CONFIGFS
 	bool "Configfs interface for fault-injection capabilities"
 	depends on FAULT_INJECTION
diff --git a/net/core/Makefile b/net/core/Makefile
index 5a72a87ee0f1..d9326600e289 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -46,3 +46,4 @@ obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
 obj-$(CONFIG_NET_DEVMEM) += devmem.o
 obj-$(CONFIG_DEBUG_NET_SMALL_RTNL) += rtnl_net_debug.o
+obj-$(CONFIG_FAIL_SKB_REALLOC) += skb_fault_injection.o
diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
new file mode 100644
index 000000000000..21b0ea48c139
--- /dev/null
+++ b/net/core/skb_fault_injection.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/fault-inject.h>
+#include <linux/netdevice.h>
+#include <linux/debugfs.h>
+#include <linux/skbuff.h>
+
+static struct {
+	struct fault_attr attr;
+	char devname[IFNAMSIZ];
+	bool filtered;
+} skb_realloc = {
+	.attr = FAULT_ATTR_INITIALIZER,
+	.filtered = false,
+};
+
+static bool should_fail_net_realloc_skb(struct sk_buff *skb)
+{
+	struct net_device *net = skb->dev;
+
+	if (skb_realloc.filtered &&
+	    strncmp(net->name, skb_realloc.devname, IFNAMSIZ))
+		/* device name filter set, but names do not match */
+		return false;
+
+	if (!should_fail(&skb_realloc.attr, 1))
+		return false;
+
+	return true;
+}
+ALLOW_ERROR_INJECTION(should_fail_net_realloc_skb, TRUE);
+
+void skb_might_realloc(struct sk_buff *skb)
+{
+	if (!should_fail_net_realloc_skb(skb))
+		return;
+
+	pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
+}
+EXPORT_SYMBOL(skb_might_realloc);
+
+static int __init fail_skb_realloc_setup(char *str)
+{
+	return setup_fault_attr(&skb_realloc.attr, str);
+}
+__setup("fail_skb_realloc=", fail_skb_realloc_setup);
+
+static void reset_settings(void)
+{
+	skb_realloc.filtered = false;
+	memzero_explicit(&skb_realloc.devname, IFNAMSIZ);
+}
+
+static ssize_t devname_write(struct file *file, const char __user *buffer,
+			     size_t count, loff_t *ppos)
+{
+	ssize_t ret;
+
+	reset_settings();
+	ret = simple_write_to_buffer(&skb_realloc.devname, IFNAMSIZ,
+				     ppos, buffer, count);
+	if (ret < 0)
+		return ret;
+	strim(skb_realloc.devname);
+
+	if (strnlen(skb_realloc.devname, IFNAMSIZ))
+		skb_realloc.filtered = true;
+
+	return count;
+}
+
+static ssize_t devname_read(struct file *file,
+			    char __user *buffer,
+			    size_t size, loff_t *ppos)
+{
+	if (!skb_realloc.filtered)
+		return 0;
+
+	return simple_read_from_buffer(buffer, size, ppos, &skb_realloc.devname,
+				       strlen(skb_realloc.devname));
+}
+
+static const struct file_operations devname_ops = {
+	.write = devname_write,
+	.read = devname_read,
+};
+
+static int __init fail_skb_realloc_debugfs(void)
+{
+	umode_t mode = S_IFREG | 0600;
+	struct dentry *dir;
+
+	dir = fault_create_debugfs_attr("fail_skb_realloc", NULL,
+					&skb_realloc.attr);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	debugfs_create_file("devname", mode, dir, NULL, &devname_ops);
+
+	return 0;
+}
+
+late_initcall(fail_skb_realloc_debugfs);
-- 
2.43.5


