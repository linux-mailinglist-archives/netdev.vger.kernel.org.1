Return-Path: <netdev+bounces-133963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ACB99790C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334DC1C21C11
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42021E32B1;
	Wed,  9 Oct 2024 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wCX9FfzB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D71183CC1
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516084; cv=none; b=InDnFXHxDsSd50LHl7zm2MV6o3tbo5nXj0n9pYTtaUZUwPXi14+VCvqy5pBO4resiYdKTkSY7mrgRjKT6PI06jKjOccFx/+7JhjKfzrIa5uXD9FVmBSWVc+xYBolc182l9NWttOKfyXCk4lw7YB9tKU+HsKM+w3G42PzYbpTYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516084; c=relaxed/simple;
	bh=ZS5cD5yDMwXD96804APs2GmYoiqkTD/BdgYD5SpLcgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPWyrEgcmryqG1k0beLc8xZYLiNoy9FJGYJVGoctTasW0jyA6Gx8XL/myLHTTAWnXRnLqDU+RUlTT3xIEXlB+FjhgEF1DNlXx3FGzuz+3z/fG6aYk+SSywfxjZ6WwdgT/Lt0w/DkftXZtQotofU3gsrWICkswsVnfFeIc/X4FCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=wCX9FfzB; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728516083; x=1760052083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FNi5QTLoXORCyp6CACGML50FSf6uZDms2QJaIm+W1HM=;
  b=wCX9FfzB2s/LAZJdUgxncUqqqGPe/Pb8HC+1483JZI5iHpQl/RfTUALz
   vj01nI829ExctqSKT7Z/TWEVC66+O8xOy47PUhaCBwidUe0eBDlXyzyHI
   5BnTQpwCbyrvdXIAcOo0wW/6EID7L2lrGb42MGYwmWD7+5RbuJkxuQB1n
   A=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="137233948"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:21:21 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:20711]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id fe186db5-1ac9-4f69-994e-95c5ba74e322; Wed, 9 Oct 2024 23:21:20 +0000 (UTC)
X-Farcaster-Flow-ID: fe186db5-1ac9-4f69-994e-95c5ba74e322
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:21:20 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:21:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 13/13] rtnetlink: Protect struct rtnl_af_ops with SRCU.
Date: Wed, 9 Oct 2024 16:16:56 -0700
Message-ID: <20241009231656.57830-14-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009231656.57830-1-kuniyu@amazon.com>
References: <20241009231656.57830-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once RTNL is replaced with rtnl_net_lock(), we need a mechanism to
guarantee that rtnl_af_ops is alive during inflight RTM_SETLINK
even when its module is being unloaded.

Let's use SRCU to protect rtnl_af_ops.

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
 include/net/rtnetlink.h |  5 +++-
 net/core/rtnetlink.c    | 58 +++++++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index c873fd6193ed..407a2f56f00a 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -150,7 +150,8 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops);
 /**
  * 	struct rtnl_af_ops - rtnetlink address family operations
  *
- *	@list: Used internally
+ *	@list: Used internally, protected by RTNL and SRCU
+ *	@srcu: Used internally
  * 	@family: Address family
  * 	@fill_link_af: Function to fill IFLA_AF_SPEC with address family
  * 		       specific netlink attributes.
@@ -163,6 +164,8 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops);
  */
 struct rtnl_af_ops {
 	struct list_head	list;
+	struct srcu_struct	srcu;
+
 	int			family;
 
 	int			(*fill_link_af)(struct sk_buff *skb,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a0702e531331..817165f6d5ef 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -660,18 +660,31 @@ static size_t rtnl_link_get_size(const struct net_device *dev)
 
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
@@ -683,6 +696,7 @@ static const struct rtnl_af_ops *rtnl_af_lookup(const int family)
 void rtnl_af_register(struct rtnl_af_ops *ops)
 {
 	rtnl_lock();
+	init_srcu_struct(&ops->srcu);
 	list_add_tail_rcu(&ops->list, &rtnl_af_ops);
 	rtnl_unlock();
 }
@@ -699,6 +713,7 @@ void rtnl_af_unregister(struct rtnl_af_ops *ops)
 	rtnl_unlock();
 
 	synchronize_rcu();
+	synchronize_srcu(&ops->srcu);
 }
 EXPORT_SYMBOL_GPL(rtnl_af_unregister);
 
@@ -2571,20 +2586,24 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 		int rem, err;
 
 		nla_for_each_nested(af, tb[IFLA_AF_SPEC], rem) {
-			const struct rtnl_af_ops *af_ops;
+			struct rtnl_af_ops *af_ops;
+			int srcu_ops_index;
 
-			af_ops = rtnl_af_lookup(nla_type(af));
+			af_ops = rtnl_af_lookup(nla_type(af), &srcu_ops_index);
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
+			rtnl_af_put(af_ops, srcu_ops_index);
+
+			if (err < 0)
+				return err;
 		}
 	}
 
@@ -3164,11 +3183,18 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		int rem;
 
 		nla_for_each_nested(af, tb[IFLA_AF_SPEC], rem) {
-			const struct rtnl_af_ops *af_ops;
+			struct rtnl_af_ops *af_ops;
+			int srcu_ops_index;
 
-			BUG_ON(!(af_ops = rtnl_af_lookup(nla_type(af))));
+			af_ops = rtnl_af_lookup(nla_type(af), &srcu_ops_index);
+			if (!af_ops) {
+				err = -EAFNOSUPPORT;
+				goto errout;
+			}
 
 			err = af_ops->set_link_af(dev, af, extack);
+			rtnl_af_put(af_ops, srcu_ops_index);
+
 			if (err < 0)
 				goto errout;
 
-- 
2.39.5 (Apple Git-154)


