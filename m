Return-Path: <netdev+bounces-83412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807A6892312
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15981C211EA
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCA6137774;
	Fri, 29 Mar 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXfJlfE5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF3137742
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735056; cv=none; b=SlO/r7DcrYXbZHIpVH1ohFlkiuaFYgNOoj+jBvQqstlDBXwCaZ71HStINWZH5kBtBuBhuxkv9MIBpRwf3+oRQF+tQCr04JSa5XbuZH8J70dWTAJVnWe+30fXjYfUG3OTYzR8aGxfzytrqcjzaQDnBjj1IA9U7A0ZIOGlMmY7ajQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735056; c=relaxed/simple;
	bh=71/3YUKHSYP3wNa970mRxUmp9Wfm8Z0TR5LXphIqR0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaEdqqiqWHECBFOcQrv2CPNzk2LfLFPeGWmEJLMidHDtqrsOWVxPLZKPHVo+w81FoliuXgYQ5/cTIS0ndE3N+wT7ues7CxzkPWdbs7xoV9gu+8wiaSI6k6WLz6pzK5eAlxGnqf1+McpxleYhz9kfTzgyT8S2kthFiLacMOSpwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXfJlfE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48077C43394;
	Fri, 29 Mar 2024 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711735055;
	bh=71/3YUKHSYP3wNa970mRxUmp9Wfm8Z0TR5LXphIqR0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXfJlfE5jiMCEokZ7rhw9BDQ7R2J8zFdTlnFE4ljNwWN80Ye2UasgUUAClwI+xQmO
	 wqdTypJP3d5VIRwEcDg6B/qoQlHqqQkxyQ6DZjAb8ffg1Bn71xtwvwaL8XQB5biD30
	 MOd35UKoRA5Q1b8aDDVj5SU3ru2Do/ZSKy5ZlVcWVM9ka5QfjgvsxqIZGeGxy+nQ3t
	 K+onnLoqMjT24eTz63a0R3SvFC6ZPPWQdooPJkky1VZ2PDlnad6SbN5hja+OCNjoH1
	 aO50ABthCk9rqqaSVlDyIhxak5/jMOzJXRr3yExHcg3smiQH25nD549REyQaKLNeF0
	 w7R8MdcO5XhBA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	jiri@resnulli.us,
	andriy.shevchenko@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>,
	kuniyu@amazon.com
Subject: [PATCH net-next v3 1/3] netlink: create a new header for internal genetlink symbols
Date: Fri, 29 Mar 2024 10:57:08 -0700
Message-ID: <20240329175710.291749-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329175710.291749-1-kuba@kernel.org>
References: <20240329175710.291749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are things in linux/genetlink.h which are only used
under net/netlink/. Move them to a new local header.
A new header with just 2 externs isn't great, but alternative
would be to include af_netlink.h in genetlink.c which feels
even worse.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kuniyu@amazon.com
CC: jiri@resnulli.us
---
 include/linux/genetlink.h |  5 -----
 net/netlink/af_netlink.c  |  2 +-
 net/netlink/genetlink.c   |  2 ++
 net/netlink/genetlink.h   | 11 +++++++++++
 4 files changed, 14 insertions(+), 6 deletions(-)
 create mode 100644 net/netlink/genetlink.h

diff --git a/include/linux/genetlink.h b/include/linux/genetlink.h
index c285968e437a..9dbd7ba9b858 100644
--- a/include/linux/genetlink.h
+++ b/include/linux/genetlink.h
@@ -4,15 +4,10 @@
 
 #include <uapi/linux/genetlink.h>
 
-
 /* All generic netlink requests are serialized by a global lock.  */
 extern void genl_lock(void);
 extern void genl_unlock(void);
 
-/* for synchronisation between af_netlink and genetlink */
-extern atomic_t genl_sk_destructing_cnt;
-extern wait_queue_head_t genl_sk_destructing_waitq;
-
 #define MODULE_ALIAS_GENL_FAMILY(family)\
  MODULE_ALIAS_NET_PF_PROTO_NAME(PF_NETLINK, NETLINK_GENERIC, "-family-" family)
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 7554803218a2..dc8c3c01d51b 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -59,7 +59,6 @@
 #include <linux/rhashtable.h>
 #include <asm/cacheflush.h>
 #include <linux/hash.h>
-#include <linux/genetlink.h>
 #include <linux/net_namespace.h>
 #include <linux/nospec.h>
 #include <linux/btf_ids.h>
@@ -73,6 +72,7 @@
 #include <trace/events/netlink.h>
 
 #include "af_netlink.h"
+#include "genetlink.h"
 
 struct listeners {
 	struct rcu_head		rcu;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 3b7666944b11..feb54c63a116 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -22,6 +22,8 @@
 #include <net/sock.h>
 #include <net/genetlink.h>
 
+#include "genetlink.h"
+
 static DEFINE_MUTEX(genl_mutex); /* serialization of message processing */
 static DECLARE_RWSEM(cb_lock);
 
diff --git a/net/netlink/genetlink.h b/net/netlink/genetlink.h
new file mode 100644
index 000000000000..89bd9d2631c3
--- /dev/null
+++ b/net/netlink/genetlink.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_GENETLINK_H
+#define __NET_GENETLINK_H
+
+#include <linux/wait.h>
+
+/* for synchronisation between af_netlink and genetlink */
+extern atomic_t genl_sk_destructing_cnt;
+extern wait_queue_head_t genl_sk_destructing_waitq;
+
+#endif	/* __LINUX_GENERIC_NETLINK_H */
-- 
2.44.0


