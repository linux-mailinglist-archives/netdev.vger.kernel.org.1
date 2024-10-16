Return-Path: <netdev+bounces-136273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69EB9A122C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BB8B214D7
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449B213EE9;
	Wed, 16 Oct 2024 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bp9VL3rY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FBD2139C9
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105126; cv=none; b=a7hXKMuTgG6n63hrGf9EI6SRv0+pYAuOcKJmwAaeVm9oFJBAqfzW8HlvqXER5LLik5hlPN0WXeRt/0kk0MxFzB3WLK8uAWCmze5kusDCbVGfgIq7zztFxwdvm8rg+XW4lXN+752uamkmOFGiLo4NzEBFAMkAY8I62JqAY+3s4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105126; c=relaxed/simple;
	bh=5NRBzRivDOMNjlbQcpMre70KnP/rrhVPAVf2G+PCX0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0ig/xFJWDqPXecXMd67sJMGT9VsSpOcEv3XQrMsOBKfwA7KgfGMoMrJhxTIex8o9puVWGVnEHufMLjvIW0vRWtNdnam0PcUqcKCtwpY4bd8WiKFORQ0ysgRxU/0xGO9mjbaMeHxU264xLF5+EPC5qvnR/ocTzIBYTP2gcXsdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bp9VL3rY; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729105125; x=1760641125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9/7PPlQYIGCXCrtSQGZc7QUpGK+6wpHcoyVOViVaNvI=;
  b=bp9VL3rYhoi1trkAzR7Qfezes0Djn5wvkKHri9IYU4D6g4mSX2o65Wvv
   vnfJ9vICnEg4nOMvMinQ/mEqd6kdnfhp9hLcoo9dsSPo/ySp9Z/LdRS4/
   4L5GQy/X9BReuAHpU9C0iRKHPl+lpwjLbAulGm1+62Ri8OQj/tFdTQN3r
   M=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="435633568"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:58:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:49671]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id 14da01c4-8912-4f1d-8bf0-361486e91b1b; Wed, 16 Oct 2024 18:58:42 +0000 (UTC)
X-Farcaster-Flow-ID: 14da01c4-8912-4f1d-8bf0-361486e91b1b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:58:41 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:58:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 14/14] rtnetlink: Protect struct rtnl_af_ops with SRCU.
Date: Wed, 16 Oct 2024 11:53:57 -0700
Message-ID: <20241016185357.83849-15-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016185357.83849-1-kuniyu@amazon.com>
References: <20241016185357.83849-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once RTNL is replaced with rtnl_net_lock(), we need a mechanism to
guarantee that rtnl_af_ops is alive during inflight RTM_SETLINK
even when its module is being unloaded.

Let's use SRCU to protect ops.

rtnl_af_lookup() now iterates rtnl_af_ops under RCU and returns
SRCU-protected ops pointer.  The caller must call rtnl_af_put()
to release the pointer after the use.

Also, rtnl_af_unregister() unlinks the ops first and calls
synchronize_srcu() to wait for inflight RTM_SETLINK requests to
complete.

Note that rtnl_af_ops needs to be protected by its dedicated lock
when RTNL is removed.

Note also that BUG_ON() in do_setlink() is changed to the normal
error handling as a different af_ops might be found after
validate_linkmsg().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Handle error of init_srcu_struct().
  * Call cleanup_srcu_struct() after synchronize_srcu().
---
 include/net/rtnetlink.h |  5 +++-
 net/core/rtnetlink.c    | 63 ++++++++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 969138ae2f4b..e0d9a8eae6b6 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -172,7 +172,8 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops);
 /**
  * 	struct rtnl_af_ops - rtnetlink address family operations
  *
- *	@list: Used internally
+ *	@list: Used internally, protected by RTNL and SRCU
+ *	@srcu: Used internally
  * 	@family: Address family
  * 	@fill_link_af: Function to fill IFLA_AF_SPEC with address family
  * 		       specific netlink attributes.
@@ -185,6 +186,8 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops);
  */
 struct rtnl_af_ops {
 	struct list_head	list;
+	struct srcu_struct	srcu;
+
 	int			family;
 
 	int			(*fill_link_af)(struct sk_buff *skb,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 70b663aca209..194a81e5f608 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -666,18 +666,31 @@ static size_t rtnl_link_get_size(const struct net_device *dev)
 
 static LIST_HEAD(rtnl_af_ops);
 
-static const struct rtnl_af_ops *rtnl_af_lookup(const int family)
+static struct rtnl_af_ops *rtnl_af_lookup(const int family, int *srcu_index)
 {
-	const struct rtnl_af_ops *ops;
+	struct rtnl_af_ops *ops;
 
 	ASSERT_RTNL();
 
-	list_for_each_entry(ops, &rtnl_af_ops, list) {
-		if (ops->family == family)
-			return ops;
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(ops, &rtnl_af_ops, list) {
+		if (ops->family == family) {
+			*srcu_index = srcu_read_lock(&ops->srcu);
+			goto unlock;
+		}
 	}
 
-	return NULL;
+	ops = NULL;
+unlock:
+	rcu_read_unlock();
+
+	return ops;
+}
+
+static void rtnl_af_put(struct rtnl_af_ops *ops, int srcu_index)
+{
+	srcu_read_unlock(&ops->srcu, srcu_index);
 }
 
 /**
@@ -688,6 +701,11 @@ static const struct rtnl_af_ops *rtnl_af_lookup(const int family)
  */
 int rtnl_af_register(struct rtnl_af_ops *ops)
 {
+	int err = init_srcu_struct(&ops->srcu);
+
+	if (err)
+		return err;
+
 	rtnl_lock();
 	list_add_tail_rcu(&ops->list, &rtnl_af_ops);
 	rtnl_unlock();
@@ -707,6 +725,8 @@ void rtnl_af_unregister(struct rtnl_af_ops *ops)
 	rtnl_unlock();
 
 	synchronize_rcu();
+	synchronize_srcu(&ops->srcu);
+	cleanup_srcu_struct(&ops->srcu);
 }
 EXPORT_SYMBOL_GPL(rtnl_af_unregister);
 
@@ -2579,20 +2599,24 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 		int rem, err;
 
 		nla_for_each_nested(af, tb[IFLA_AF_SPEC], rem) {
-			const struct rtnl_af_ops *af_ops;
+			struct rtnl_af_ops *af_ops;
+			int af_ops_srcu_index;
 
-			af_ops = rtnl_af_lookup(nla_type(af));
+			af_ops = rtnl_af_lookup(nla_type(af), &af_ops_srcu_index);
 			if (!af_ops)
 				return -EAFNOSUPPORT;
 
 			if (!af_ops->set_link_af)
-				return -EOPNOTSUPP;
-
-			if (af_ops->validate_link_af) {
+				err = -EOPNOTSUPP;
+			else if (af_ops->validate_link_af)
 				err = af_ops->validate_link_af(dev, af, extack);
-				if (err < 0)
-					return err;
-			}
+			else
+				err = 0;
+
+			rtnl_af_put(af_ops, af_ops_srcu_index);
+
+			if (err < 0)
+				return err;
 		}
 	}
 
@@ -3172,11 +3196,18 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		int rem;
 
 		nla_for_each_nested(af, tb[IFLA_AF_SPEC], rem) {
-			const struct rtnl_af_ops *af_ops;
+			struct rtnl_af_ops *af_ops;
+			int af_ops_srcu_index;
 
-			BUG_ON(!(af_ops = rtnl_af_lookup(nla_type(af))));
+			af_ops = rtnl_af_lookup(nla_type(af), &af_ops_srcu_index);
+			if (!af_ops) {
+				err = -EAFNOSUPPORT;
+				goto errout;
+			}
 
 			err = af_ops->set_link_af(dev, af, extack);
+			rtnl_af_put(af_ops, af_ops_srcu_index);
+
 			if (err < 0)
 				goto errout;
 
-- 
2.39.5 (Apple Git-154)


