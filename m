Return-Path: <netdev+bounces-131189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8B98D242
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37E51F22612
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD11EC00B;
	Wed,  2 Oct 2024 11:37:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B477198A1A;
	Wed,  2 Oct 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869065; cv=none; b=ftwMEZW+EqHbFrd6h1S0cpPAmQBdk+EDZ6bnUbEHg282ppJeRKVc6sSK9CxwTive68AD7ncXtkiXu4nYf1k76h9nxOuCHW8a6Q/tiA1eiS8NJEZbbM9nLsCRi+zd+dsACFnAvhu0B2+ZfGl4Cp1x52t7qARszVRjLLnAqmqdS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869065; c=relaxed/simple;
	bh=K8bg9lGUnE7Jh9JkSZitpXa3/BeNhnNn95rKVl1afT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nvsm2oR9KjQOLf2RRWedzowbEVb7+bgf1MLr+0ytKJtUGpf3ZLoSENZl6cwx77DmzXaLLEgunV4qDoJD7Ygl+gaTP9HoQJPgYt9NsfHEgKgw+5a5FSnu1UBHdKy7Wnvq7Hf9VUb62WXrLhmNDJr3La6CbGNUe2P1ej6HEWIm/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so1198725a12.1;
        Wed, 02 Oct 2024 04:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727869062; x=1728473862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qiqrbk6ckT1jqk1LGrt+kprIciL1RtioVG8ryZRNgoE=;
        b=uZEIqZdlrcdl/0M96jUGGWNJoYg0wzGDq1Rq+MMqqg9jQD8ZsuTFCAT35j1pZK7EDN
         cnK0bOjvT5+93PF+2FZBtrlq6n0quDNvcmc2RI6CMg8Kv0XhBwdCKef51sWNe85g/q67
         j0y7T0UIKKzTEnCHugNFXINAC6O4Ua5Q8/IalWLQCJbI8FIuAO8uMXJF4blA81Ba/HLi
         Iar3ZVGkKA/cMD/aRdQVEK7eGBKZp6LJ0p+Q1pPKXty9wSDQTeGBZk3DEioTTcpolPS6
         0n+mGqkneZHOqKoUqqE4LUh6l+39Jg9KKlP/ZtND95G11bvvQZcZq4hLsMvC0V4bFBeO
         KgDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlrgbl6byXWbLaesl0iRAq9PGWFNpOAFy6lNK+2/VmIGN7i1yqMRX/k/S4XlfPJwBYQRAYDweOU7tmhp56@vger.kernel.org, AJvYcCW+iMIo/vr8rHjhfJlaAdpFj/APBfZ5v8uEKqEfFCRoTWuagJGn8SI3EL0ED04OR4cpr1bp5qslNGM=@vger.kernel.org, AJvYcCXOdfIy5ermenlqN3WIYouzcgs0y0WY0RdOHkFCsjeQPQwXXwqaa1UhJ0RdMbfmLVwoKryG/BJ6@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLKe224yTZYNmAG8ifMnNGd0lDHsErHPj9aw22tpmff42hYaF
	5w4nK84WgQ32f1fQ6EcJE17/RYyIMwYkCsyVDwlMDN4UT0WWB80lMgDIZQ==
X-Google-Smtp-Source: AGHT+IH5mIzz5jPBwPmPH5jWp2me+sKrWNXZhSKQQkt/msS3jhL5a4GgIYqQi0MDrXRrMwlAy8TI5A==
X-Received: by 2002:a05:6402:34c5:b0:5c8:a023:6b8b with SMTP id 4fb4d7f45d1cf-5c8b1381e00mr2703356a12.15.1727869061981;
        Wed, 02 Oct 2024 04:37:41 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ab33da14sm2256116a12.36.2024.10.02.04.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:37:41 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH net-next] net: Implement fault injection forcing skb reallocation
Date: Wed,  2 Oct 2024 04:32:54 -0700
Message-ID: <20241002113316.2527669-1-leitao@debian.org>
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
called CONFIG_FAIL_SKB_FORCE_REALLOC.

This patch was *heavily* inspired by Jakub's proposal from:
https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/

CC: Akinobu Mita <akinobu.mita@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../fault-injection/fault-injection.rst       | 18 ++++++++++
 include/linux/skbuff.h                        |  9 +++++
 net/Kconfig.debug                             | 11 +++++++
 net/core/Makefile                             |  1 +
 net/core/skb_fault_injection.c                | 33 +++++++++++++++++++
 5 files changed, 72 insertions(+)
 create mode 100644 net/core/skb_fault_injection.c

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 70380a2a01b4..2fc71330c761 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -45,6 +45,23 @@ Available fault injection capabilities
   ALLOW_ERROR_INJECTION() macro, by setting debugfs entries
   under /sys/kernel/debug/fail_function. No boot option supported.
 
+- fail_net_force_skb_realloc
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
 - NVMe fault injection
 
   inject NVMe status code and retry flag on devices permitted by setting
@@ -219,6 +236,7 @@ use the boot option::
 	fail_usercopy=
 	fail_make_request=
 	fail_futex=
+	fail_net_force_skb_realloc=
 	mmc_core.fail_request=<interval>,<probability>,<space>,<times>
 
 proc entries
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f3628..d9ee756a64fc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2681,6 +2681,12 @@ static inline void skb_assert_len(struct sk_buff *skb)
 #endif /* CONFIG_DEBUG_NET */
 }
 
+#if defined(CONFIG_FAIL_SKB_FORCE_REALLOC)
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
@@ -3210,6 +3217,7 @@ static inline int __pskb_trim(struct sk_buff *skb, unsigned int len)
 
 static inline int pskb_trim(struct sk_buff *skb, unsigned int len)
 {
+	skb_might_realloc(skb);
 	return (len < skb->len) ? __pskb_trim(skb, len) : 0;
 }
 
@@ -3964,6 +3972,7 @@ int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len);
 
 static inline int pskb_trim_rcsum(struct sk_buff *skb, unsigned int len)
 {
+	skb_might_realloc(skb);
 	if (likely(len >= skb->len))
 		return 0;
 	return pskb_trim_rcsum_slow(skb, len);
diff --git a/net/Kconfig.debug b/net/Kconfig.debug
index 5e3fffe707dd..f61935e028bd 100644
--- a/net/Kconfig.debug
+++ b/net/Kconfig.debug
@@ -24,3 +24,14 @@ config DEBUG_NET
 	help
 	  Enable extra sanity checks in networking.
 	  This is mostly used by fuzzers, but is safe to select.
+
+config FAIL_SKB_FORCE_REALLOC
+	bool "Fault-injection capability forcing skb to reallocate"
+	depends on FAULT_INJECTION && DEBUG_NET
+	default n
+	help
+	  Provide fault-injection capability that forces the skb to be
+	  reallocated, caughting possible invalid pointers to the skb.
+
+	  For more information, check
+	  Documentation/dev-tools/fault-injection/fault-injection.rst
diff --git a/net/core/Makefile b/net/core/Makefile
index c3ebbaf9c81e..02658807242b 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
 obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
 obj-$(CONFIG_NET_DEVMEM) += devmem.o
+obj-$(CONFIG_FAIL_SKB_FORCE_REALLOC) += skb_fault_injection.o
diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
new file mode 100644
index 000000000000..ccdc0f9c41be
--- /dev/null
+++ b/net/core/skb_fault_injection.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/fault-inject.h>
+#include <linux/skbuff.h>
+
+static DECLARE_FAULT_ATTR(fail_net_force_skb_realloc);
+
+void skb_might_realloc(struct sk_buff *skb)
+{
+	if (should_fail(&fail_net_force_skb_realloc, 1))
+		pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
+}
+EXPORT_SYMBOL(skb_might_realloc);
+
+static int __init fail_net_force_skb_realloc_setup(char *str)
+{
+	return setup_fault_attr(&fail_net_force_skb_realloc, str);
+}
+__setup("fail_net_force_skb_realloc=", fail_net_force_skb_realloc_setup);
+
+static int __init fail_net_force_skb_realloc_debugfs(void)
+{
+	struct dentry *dir;
+
+	dir = fault_create_debugfs_attr("fail_net_force_skb_realloc", NULL,
+					&fail_net_force_skb_realloc);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	return 0;
+}
+
+late_initcall(fail_net_force_skb_realloc_debugfs);
-- 
2.43.5


