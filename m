Return-Path: <netdev+bounces-78983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF6287734B
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 19:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B1C282153
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 18:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433B4779C;
	Sat,  9 Mar 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN+jKKzt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0687481B1
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009305; cv=none; b=ZyijZk9sHTZWrU/VZcgh/8r093Yt0kHpRgZLTrpqAsIna8AD3iuo6L5aNvwWlHJVLb8LYYwfE76Ag81buA2VnN/B+WwTWdI5Q7SOhoavsySFdifgBvsCG4R0luplOllyXr7wsYjte1Zj2wDq5d4onkg8SP7+rhOJ8eTcYdfoSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009305; c=relaxed/simple;
	bh=8/w0VA1oi6faXDss+0olvw5p222l62kwa/NtjCIeLsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvnbvF3nDGBL6g08WG0K3mfzuYG4TqsxXW7EnZWeOXKXSycXDjWnx0dgO3pOI7XXOToxAeS7z9mD49VXPrbP9N2bQEhE5grWwx6QPzLrwtvjAne3sqJIvegpHIBrFzMXl1eUbLwDl0wb6ajLHaGTaATtFyita4G3I0YZGSeKtlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN+jKKzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77BEC43394;
	Sat,  9 Mar 2024 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009305;
	bh=8/w0VA1oi6faXDss+0olvw5p222l62kwa/NtjCIeLsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qN+jKKztx+UAEmDBrXAtoHdFjvQ0Znlg+e4szilW+ILKVYSMDcF9alFGMHScKGhq+
	 DznQ6Dt+C9tbVUhop+KgYr+i0KjEFOmwCa44BCHqT2ykdyL6jiHf6xVbEPZwMrolcN
	 eeHo9CatK1ibfKkSVl4rhN008K/TBmXmhaatDap3pa+w2RTo6wMmWlTBg9tT2wWfLq
	 yKNe8g6P65fDDYSYIbtkRcb/gtdYbY4qsHVOpub8FBcRwaIEri3pNI3cySXo5Rcmq9
	 RYRxm4sPIMGL7CHQHfJkH7A2I1LadWml6m682LJCD5Mf/JI8myrTaNsFjYHd3cUjf9
	 OHnzoPLSs0CPA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>,
	kuniyu@amazon.com
Subject: [PATCH net-next 1/3] netlink: create a new header for internal genetlink symbols
Date: Sat,  9 Mar 2024 10:34:56 -0800
Message-ID: <20240309183458.3014713-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240309183458.3014713-1-kuba@kernel.org>
References: <20240309183458.3014713-1-kuba@kernel.org>
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
index da846212fb9b..621ef3d7f044 100644
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


