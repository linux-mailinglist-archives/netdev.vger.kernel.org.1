Return-Path: <netdev+bounces-155135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6BEA01345
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1003A40F9
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EC51487E9;
	Sat,  4 Jan 2025 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T8ldL3NY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720E4437
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735978962; cv=none; b=hCFUzhFLd4dzNlXndOlXd1xCdki91VBC2f9t07fG07YgZVhWjLdDGTzkJVkF9ARnaeLICP5JXrsCUveRlOtIetcErobdUiLIpFJyVSz3jnv8cy1EtjAYU9Sf+/c0LWCA5p468SYKye/fUYk9TU6Xcyhp6k5gknQCKCAdBayawmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735978962; c=relaxed/simple;
	bh=RW2ZDvhL4XUVql8Gs8szCc8yq9CzKPrtDz+YPhhqL2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgzVngHiPaZFZaqq5xxkpRkciMVs8UNryB3sxy5UxJwUZg++w2B/fTf2royoH3huFQXbfAc/7r/I7U2RZJPjBG4cIeo1L7qhn2bieP+a/jwcGFE+5sjvu1i4jNQjDg2Xzpe2Lc0Qf7OUKm7xd3Jt4MVrsUYj0QnnPpdZchxFwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=T8ldL3NY; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735978960; x=1767514960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xK6VzpqdgHxcp/FOk7BaW42jV84HFXVtSYhGsUCrVTg=;
  b=T8ldL3NYs+/pvC69uO0ljHYGTx26i8ccz4YfJhnFQ2uDH9cYK3j+iMFd
   agHYiIjwAV9baEUm5znI1sh7ZyLnzULzMMREdxjizxUmcT+egZDaE4dnf
   l9m/jeItthsyWDL8rk2Ch4Fcr8Ihi/Elh9RJW8GNkms5AVe018FzWZnoO
   M=;
X-IronPort-AV: E=Sophos;i="6.12,288,1728950400"; 
   d="scan'208";a="708417326"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 08:22:37 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:34860]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.3:2525] with esmtp (Farcaster)
 id e4ef0f70-1d82-43be-845a-35698379454d; Sat, 4 Jan 2025 08:22:37 +0000 (UTC)
X-Farcaster-Flow-ID: e4ef0f70-1d82-43be-845a-35698379454d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 08:22:37 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.9.250) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 08:22:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/2] rtnetlink: Add rtnl_net_lock_killable().
Date: Sat, 4 Jan 2025 17:21:48 +0900
Message-ID: <20250104082149.48493-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250104082149.48493-1-kuniyu@amazon.com>
References: <20250104082149.48493-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

rtnl_lock_killable() is used only in register_netdev()
and will be converted to per-netns RTNL.

Let's unexport it and add the corresponding helper.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/rtnetlink.h |  6 ++++++
 net/core/rtnetlink.c      | 11 ++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 3b9d132cbc9e..4bc2ee0b10b0 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -102,6 +102,7 @@ void __rtnl_net_unlock(struct net *net);
 void rtnl_net_lock(struct net *net);
 void rtnl_net_unlock(struct net *net);
 int rtnl_net_trylock(struct net *net);
+int rtnl_net_lock_killable(struct net *net);
 int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b);
 
 bool rtnl_net_is_locked(struct net *net);
@@ -138,6 +139,11 @@ static inline int rtnl_net_trylock(struct net *net)
 	return rtnl_trylock();
 }
 
+static inline int rtnl_net_lock_killable(struct net *net)
+{
+	return rtnl_lock_killable();
+}
+
 static inline void ASSERT_RTNL_NET(struct net *net)
 {
 	ASSERT_RTNL();
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6b745096809d..1f4d4b5570ab 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -84,7 +84,6 @@ int rtnl_lock_killable(void)
 {
 	return mutex_lock_killable(&rtnl_mutex);
 }
-EXPORT_SYMBOL(rtnl_lock_killable);
 
 static struct sk_buff *defer_kfree_skb_list;
 void rtnl_kfree_skbs(struct sk_buff *head, struct sk_buff *tail)
@@ -221,6 +220,16 @@ int rtnl_net_trylock(struct net *net)
 }
 EXPORT_SYMBOL(rtnl_net_trylock);
 
+int rtnl_net_lock_killable(struct net *net)
+{
+	int ret = rtnl_lock_killable();
+
+	if (!ret)
+		__rtnl_net_lock(net);
+
+	return ret;
+}
+
 static int rtnl_net_cmp_locks(const struct net *net_a, const struct net *net_b)
 {
 	if (net_eq(net_a, net_b))
-- 
2.39.5 (Apple Git-154)


