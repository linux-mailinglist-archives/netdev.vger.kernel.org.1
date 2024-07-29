Return-Path: <netdev+bounces-113820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ABC940024
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111AC282C71
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4397218D4BD;
	Mon, 29 Jul 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mY0ckokR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2718EFC5
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287353; cv=none; b=GOXQ7aOROVIdXInFR76vmMzKpYVM1iQh0h9+AME7Ur+a/rdunsHVSaJnSPkP3b4PhkecK3qI4UY5otlcSgWanqmGnfvITA/EfQBOM4MqHs37hEIMq6LEzRDmYNVrRFfqGMRFSvRRsCzyWDig4d6iD71XlKH4cXmPHcOmQDKHjME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287353; c=relaxed/simple;
	bh=C0l4SpLSVZXerdseMvfCdTM1V+32oo/tVAA6+V+i0vA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCkTGtNSJ9xbWpb/L+2rr01G8VS2Izomcy6I66qCxsD5uEIsRCPHmR0JH0o6e95YzxbA7bQVBFIPkUIs+jP9/rjx6DvECwBDeYTP//pQ3hL1kqJgkmT2ebq8Rsqxs+bxDDP1n/O2FE6m/GxDo3jdDo66X3m0L16Yi9GfBDXsH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mY0ckokR; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722287351; x=1753823351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Io+BolqBVZ81cwVOvITGKy65FQ+whaKMDZt+guPh3lg=;
  b=mY0ckokRSEhOOprbwLLnrz13lLsvY9q2TD0GYyt7a72CFrBgR5NewY21
   Yv4k3S23ysi3ycmrfnvQzrjZQgiYXBxNDO8hnuTY0VwhU27yuKOv0yau7
   igm3rZg0gp9wdp19r/vlZSZPglZziBSHAhxsahXaCKpnYcYY4ZvGOm/FG
   A=;
X-IronPort-AV: E=Sophos;i="6.09,246,1716249600"; 
   d="scan'208";a="316341805"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 21:09:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:40708]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.198:2525] with esmtp (Farcaster)
 id ebbdadb2-ba4b-4b68-8170-e6d3651b7560; Mon, 29 Jul 2024 21:09:09 +0000 (UTC)
X-Farcaster-Flow-ID: ebbdadb2-ba4b-4b68-8170-e6d3651b7560
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:09:08 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:09:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/6] net: Don't register pernet_operations if only one of id or size is specified.
Date: Mon, 29 Jul 2024 14:07:57 -0700
Message-ID: <20240729210801.16196-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240729210801.16196-1-kuniyu@amazon.com>
References: <20240729210801.16196-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We can allocate per-netns memory for struct pernet_operations by specifying
id and size.

register_pernet_operations() assigns an id to pernet_operations and later
ops_init() allocates the specified size of memory as net->gen->ptr[id].

If id is missing, no memory is allocated.  If size is not specified,
pernet_operations just wastes an entry of net->gen->ptr[] for every netns.

net_generic is useful only when both id and size are specified, so let's
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
index 6a823ba906c6..1d164ae097a5 100644
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
 
+	if (WARN_ON((ops->id && !ops->size) || (!ops->id && ops->size)))
+		return -EINVAL;
+
 	if (ops->id) {
 		error = ida_alloc_min(&net_generic_ids, MIN_PERNET_OPS_ID,
 				GFP_KERNEL);
-- 
2.30.2


