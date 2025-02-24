Return-Path: <netdev+bounces-169095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD794A4293C
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653F31633E2
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F482627F7;
	Mon, 24 Feb 2025 17:13:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06290260A5E
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417188; cv=none; b=h1KffSU1oBsW+ISwn/7jcUd4uqY1P4JnXj3wECwVwlxGFFARjDsSJVVMeaTUq5MPDYn3ldMbXiXt3lEwMCVgESjtgw3Y5Yx5OxdQdP7+yRd1VKQOFV9VZXxTtCSlwW7VIq2M3dgF4uxpNfUKbV5soLANAfXuRxRub1bwc2LAJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417188; c=relaxed/simple;
	bh=gPTfwriVQjSGeFtBMlTIYFvUySMeG5zETRqC4lnfHrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gEOnpywe5S32V9+vu69nrTLxEZAhMGrjzXw8yjYLTOYLOrZ18P7AkwSOu01pTB37v63EMdF1J+8RDopoWlZsiiaWn0ZiNicdYk/PtBe3dVImWrml0LCZBP6IXMkqHt4WDNm/o6BjT6UqmD8v6GLoTZxtabS5MbPj8K0vObZTOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1tmc0s-00040l-Cv; Mon, 24 Feb 2025 18:13:02 +0100
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next] xfrm: remove hash table alloc/free helpers
Date: Mon, 24 Feb 2025 18:10:50 +0100
Message-ID: <20250224171055.15951-1-fw@strlen.de>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions predate kvmalloc, update xfrm to use that instead.
This also allows to drop the 'size' argument passed to xfrm_hash_free().

xfrm_hash_free() is kept around because of 'struct hlist_head *' arg type
instead of 'void *'.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/xfrm/Makefile      |  2 +-
 net/xfrm/xfrm_hash.c   | 40 ---------------------------------------
 net/xfrm/xfrm_hash.h   | 10 ++++++++--
 net/xfrm/xfrm_policy.c | 15 ++++++---------
 net/xfrm/xfrm_state.c  | 43 +++++++++++++++++++-----------------------
 5 files changed, 34 insertions(+), 76 deletions(-)
 delete mode 100644 net/xfrm/xfrm_hash.c

diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index 5a1787587cb3..38a710684848 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -11,7 +11,7 @@ else ifeq ($(CONFIG_XFRM_INTERFACE),y)
 xfrm_interface-$(CONFIG_DEBUG_INFO_BTF) += xfrm_interface_bpf.o
 endif
 
-obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_hash.o \
+obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o \
 		      xfrm_input.o xfrm_output.o \
 		      xfrm_sysctl.o xfrm_replay.o xfrm_device.o \
 		      xfrm_nat_keepalive.o
diff --git a/net/xfrm/xfrm_hash.c b/net/xfrm/xfrm_hash.c
deleted file mode 100644
index eca8d84d99bf..000000000000
--- a/net/xfrm/xfrm_hash.c
+++ /dev/null
@@ -1,40 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* xfrm_hash.c: Common hash table code.
- *
- * Copyright (C) 2006 David S. Miller (davem@davemloft.net)
- */
-
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/memblock.h>
-#include <linux/vmalloc.h>
-#include <linux/slab.h>
-#include <linux/xfrm.h>
-
-#include "xfrm_hash.h"
-
-struct hlist_head *xfrm_hash_alloc(unsigned int sz)
-{
-	struct hlist_head *n;
-
-	if (sz <= PAGE_SIZE)
-		n = kzalloc(sz, GFP_KERNEL);
-	else if (hashdist)
-		n = vzalloc(sz);
-	else
-		n = (struct hlist_head *)
-			__get_free_pages(GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
-					 get_order(sz));
-
-	return n;
-}
-
-void xfrm_hash_free(struct hlist_head *n, unsigned int sz)
-{
-	if (sz <= PAGE_SIZE)
-		kfree(n);
-	else if (hashdist)
-		vfree(n);
-	else
-		free_pages((unsigned long)n, get_order(sz));
-}
diff --git a/net/xfrm/xfrm_hash.h b/net/xfrm/xfrm_hash.h
index d12bb906c9c9..0a91b4d84fda 100644
--- a/net/xfrm/xfrm_hash.h
+++ b/net/xfrm/xfrm_hash.h
@@ -193,7 +193,13 @@ static inline unsigned int __addr_hash(const xfrm_address_t *daddr,
 	return h & hmask;
 }
 
-struct hlist_head *xfrm_hash_alloc(unsigned int sz);
-void xfrm_hash_free(struct hlist_head *n, unsigned int sz);
+static inline struct hlist_head *xfrm_hash_alloc(unsigned int sz)
+{
+	return kvzalloc(sz, GFP_KERNEL);
+}
 
+static inline void xfrm_hash_free(struct hlist_head *n)
+{
+	kvfree(n);
+}
 #endif /* _XFRM_HASH_H */
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6551e588fe52..e75be29865ff 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -655,7 +655,7 @@ static void xfrm_bydst_resize(struct net *net, int dir)
 
 	synchronize_rcu();
 
-	xfrm_hash_free(odst, (hmask + 1) * sizeof(struct hlist_head));
+	xfrm_hash_free(odst);
 }
 
 static void xfrm_byidx_resize(struct net *net)
@@ -680,7 +680,7 @@ static void xfrm_byidx_resize(struct net *net)
 
 	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
 
-	xfrm_hash_free(oidx, (hmask + 1) * sizeof(struct hlist_head));
+	xfrm_hash_free(oidx);
 }
 
 static inline int xfrm_bydst_should_resize(struct net *net, int dir, int *total)
@@ -4253,9 +4253,9 @@ static int __net_init xfrm_policy_init(struct net *net)
 		struct xfrm_policy_hash *htab;
 
 		htab = &net->xfrm.policy_bydst[dir];
-		xfrm_hash_free(htab->table, sz);
+		xfrm_hash_free(htab->table);
 	}
-	xfrm_hash_free(net->xfrm.policy_byidx, sz);
+	xfrm_hash_free(net->xfrm.policy_byidx);
 out_byidx:
 	return -ENOMEM;
 }
@@ -4263,7 +4263,6 @@ static int __net_init xfrm_policy_init(struct net *net)
 static void xfrm_policy_fini(struct net *net)
 {
 	struct xfrm_pol_inexact_bin *b, *t;
-	unsigned int sz;
 	int dir;
 
 	flush_work(&net->xfrm.policy_hash_work);
@@ -4278,14 +4277,12 @@ static void xfrm_policy_fini(struct net *net)
 		struct xfrm_policy_hash *htab;
 
 		htab = &net->xfrm.policy_bydst[dir];
-		sz = (htab->hmask + 1) * sizeof(struct hlist_head);
 		WARN_ON(!hlist_empty(htab->table));
-		xfrm_hash_free(htab->table, sz);
+		xfrm_hash_free(htab->table);
 	}
 
-	sz = (net->xfrm.policy_idx_hmask + 1) * sizeof(struct hlist_head);
 	WARN_ON(!hlist_empty(net->xfrm.policy_byidx));
-	xfrm_hash_free(net->xfrm.policy_byidx, sz);
+	xfrm_hash_free(net->xfrm.policy_byidx);
 
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
 	list_for_each_entry_safe(b, t, &net->xfrm.inexact_bins, inexact_bins)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ad2202fa82f3..5efe7af68f1a 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -162,8 +162,8 @@ static void xfrm_hash_resize(struct work_struct *work)
 {
 	struct net *net = container_of(work, struct net, xfrm.state_hash_work);
 	struct hlist_head *ndst, *nsrc, *nspi, *nseq, *odst, *osrc, *ospi, *oseq;
-	unsigned long nsize, osize;
 	unsigned int nhashmask, ohashmask;
+	unsigned long nsize;
 	int i;
 
 	nsize = xfrm_hash_new_size(net->xfrm.state_hmask);
@@ -172,20 +172,20 @@ static void xfrm_hash_resize(struct work_struct *work)
 		return;
 	nsrc = xfrm_hash_alloc(nsize);
 	if (!nsrc) {
-		xfrm_hash_free(ndst, nsize);
+		xfrm_hash_free(ndst);
 		return;
 	}
 	nspi = xfrm_hash_alloc(nsize);
 	if (!nspi) {
-		xfrm_hash_free(ndst, nsize);
-		xfrm_hash_free(nsrc, nsize);
+		xfrm_hash_free(ndst);
+		xfrm_hash_free(nsrc);
 		return;
 	}
 	nseq = xfrm_hash_alloc(nsize);
 	if (!nseq) {
-		xfrm_hash_free(ndst, nsize);
-		xfrm_hash_free(nsrc, nsize);
-		xfrm_hash_free(nspi, nsize);
+		xfrm_hash_free(ndst);
+		xfrm_hash_free(nsrc);
+		xfrm_hash_free(nspi);
 		return;
 	}
 
@@ -211,14 +211,12 @@ static void xfrm_hash_resize(struct work_struct *work)
 	write_seqcount_end(&net->xfrm.xfrm_state_hash_generation);
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
-	osize = (ohashmask + 1) * sizeof(struct hlist_head);
-
 	synchronize_rcu();
 
-	xfrm_hash_free(odst, osize);
-	xfrm_hash_free(osrc, osize);
-	xfrm_hash_free(ospi, osize);
-	xfrm_hash_free(oseq, osize);
+	xfrm_hash_free(odst);
+	xfrm_hash_free(osrc);
+	xfrm_hash_free(ospi);
+	xfrm_hash_free(oseq);
 }
 
 static DEFINE_SPINLOCK(xfrm_state_afinfo_lock);
@@ -3277,36 +3275,33 @@ int __net_init xfrm_state_init(struct net *net)
 	return 0;
 
 out_state_cache_input:
-	xfrm_hash_free(net->xfrm.state_byseq, sz);
+	xfrm_hash_free(net->xfrm.state_byseq);
 out_byseq:
-	xfrm_hash_free(net->xfrm.state_byspi, sz);
+	xfrm_hash_free(net->xfrm.state_byspi);
 out_byspi:
-	xfrm_hash_free(net->xfrm.state_bysrc, sz);
+	xfrm_hash_free(net->xfrm.state_bysrc);
 out_bysrc:
-	xfrm_hash_free(net->xfrm.state_bydst, sz);
+	xfrm_hash_free(net->xfrm.state_bydst);
 out_bydst:
 	return -ENOMEM;
 }
 
 void xfrm_state_fini(struct net *net)
 {
-	unsigned int sz;
-
 	flush_work(&net->xfrm.state_hash_work);
 	flush_work(&xfrm_state_gc_work);
 	xfrm_state_flush(net, 0, false, true);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
 
-	sz = (net->xfrm.state_hmask + 1) * sizeof(struct hlist_head);
 	WARN_ON(!hlist_empty(net->xfrm.state_byseq));
-	xfrm_hash_free(net->xfrm.state_byseq, sz);
+	xfrm_hash_free(net->xfrm.state_byseq);
 	WARN_ON(!hlist_empty(net->xfrm.state_byspi));
-	xfrm_hash_free(net->xfrm.state_byspi, sz);
+	xfrm_hash_free(net->xfrm.state_byspi);
 	WARN_ON(!hlist_empty(net->xfrm.state_bysrc));
-	xfrm_hash_free(net->xfrm.state_bysrc, sz);
+	xfrm_hash_free(net->xfrm.state_bysrc);
 	WARN_ON(!hlist_empty(net->xfrm.state_bydst));
-	xfrm_hash_free(net->xfrm.state_bydst, sz);
+	xfrm_hash_free(net->xfrm.state_bydst);
 	free_percpu(net->xfrm.state_cache_input);
 }
 
-- 
2.45.3


