Return-Path: <netdev+bounces-114674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A584A9436DA
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB41F210C1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5577F482DB;
	Wed, 31 Jul 2024 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ca1RWSwh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1E381AD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456510; cv=none; b=NpqNAyZTh1QXKaCQ3DLON3ZCgRnbMTEHRxnGYWmjwCvwfgXfadwXp5oPaD09A52nR0E2AoRZThS/t7HxNBO8u1aM1/kUm5swpHCjzonKIHnMSwEQcMLbZvU8gxAsbhdquLu0VU1ALtnnLNcbwxv13Oe0wpPW8b4R2kj3TpEnFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456510; c=relaxed/simple;
	bh=aBHFXUTnb8TQUoI6mH3at7zpujXlyUxBwI4ZyEdfPGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qm1VQJenj65PZLdxiORn3UNqoCXZJpxk5wDAWMRRsz0dLRQcwbggOD8N09L5awJNslK8iYeHStWZ3QNc+zmdtlmlkQhHuvrnDuzQVIvSdaoxL+zjgmf/uShCsRYqjRNwn37L5cQl2zFp5SuCqX6GtYdDYLelOxdSsXjx67oiTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ca1RWSwh; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722456508; x=1753992508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vxXtyAxAD1NiENGc2umwMm+RTGJGGCl9fYzTyZ+1ZkE=;
  b=Ca1RWSwhP9iLlKZukx7+4CNfNPIU2mg+iKj5tLSxm3pmJNPEgQ1wgSTm
   b0hJ/gBk3wZ2IJlrW0ydVxinI2UnD+G2k77gEgXStI9iFVx6mISkl+CO0
   ddg8YOiv/EdUYDQJTiJXWDj/60AmlrCHTWuqvPg7FS3A6k1KSW/tDXljt
   I=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="671232422"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 20:08:25 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:38929]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.107:2525] with esmtp (Farcaster)
 id e8947b03-b413-4f0a-928a-66d4fcfe9833; Wed, 31 Jul 2024 20:08:25 +0000 (UTC)
X-Farcaster-Flow-ID: e8947b03-b413-4f0a-928a-66d4fcfe9833
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:08:24 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:08:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/6] net: Don't register pernet_operations if only one of id or size is specified.
Date: Wed, 31 Jul 2024 13:07:17 -0700
Message-ID: <20240731200721.70601-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240731200721.70601-1-kuniyu@amazon.com>
References: <20240731200721.70601-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We can allocate per-netns memory for struct pernet_operations by specifying
id and size.

register_pernet_operations() assigns an id to pernet_operations and later
ops_init() allocates the specified size of memory as net->gen->ptr[id].

If id is missing, no memory is allocated.  If size is not specified,
pernet_operations just wastes an entry of net->gen->ptr[] for every netns.

net_generic is available only when both id and size are specified, so let's
ensure that.

While we are at it, we add const to both fields.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/net_namespace.h |  4 ++--
 net/core/net_namespace.c    | 12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 20c34bd7a077..e67b483cc8bb 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -451,8 +451,8 @@ struct pernet_operations {
 	/* Following method is called with RTNL held. */
 	void (*exit_batch_rtnl)(struct list_head *net_exit_list,
 				struct list_head *dev_kill_list);
-	unsigned int *id;
-	size_t size;
+	unsigned int * const id;
+	const size_t size;
 };
 
 /*
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 6a823ba906c6..1cd87df13f39 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -125,7 +125,7 @@ static int ops_init(const struct pernet_operations *ops, struct net *net)
 	int err = -ENOMEM;
 	void *data = NULL;
 
-	if (ops->id && ops->size) {
+	if (ops->id) {
 		data = kzalloc(ops->size, GFP_KERNEL);
 		if (!data)
 			goto out;
@@ -140,7 +140,7 @@ static int ops_init(const struct pernet_operations *ops, struct net *net)
 	if (!err)
 		return 0;
 
-	if (ops->id && ops->size) {
+	if (ops->id) {
 		ng = rcu_dereference_protected(net->gen,
 					       lockdep_is_held(&pernet_ops_rwsem));
 		ng->ptr[*ops->id] = NULL;
@@ -182,7 +182,8 @@ static void ops_free_list(const struct pernet_operations *ops,
 			  struct list_head *net_exit_list)
 {
 	struct net *net;
-	if (ops->size && ops->id) {
+
+	if (ops->id) {
 		list_for_each_entry(net, net_exit_list, exit_list)
 			kfree(net_generic(net, *ops->id));
 	}
@@ -1244,7 +1245,7 @@ static int __register_pernet_operations(struct list_head *list,
 	LIST_HEAD(net_exit_list);
 
 	list_add_tail(&ops->list, list);
-	if (ops->init || (ops->id && ops->size)) {
+	if (ops->init || ops->id) {
 		/* We held write locked pernet_ops_rwsem, and parallel
 		 * setup_net() and cleanup_net() are not possible.
 		 */
@@ -1310,6 +1311,9 @@ static int register_pernet_operations(struct list_head *list,
 {
 	int error;
 
+	if (WARN_ON(!!ops->id ^ !!ops->size))
+		return -EINVAL;
+
 	if (ops->id) {
 		error = ida_alloc_min(&net_generic_ids, MIN_PERNET_OPS_ID,
 				GFP_KERNEL);
-- 
2.30.2


