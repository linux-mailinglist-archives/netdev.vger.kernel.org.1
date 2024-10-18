Return-Path: <netdev+bounces-136791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C7A9A3208
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6911F22685
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AC55478E;
	Fri, 18 Oct 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YhTIEX8m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A253B192
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214711; cv=none; b=NwluRkucZwzzJWVPTQtRcRbosgAwDHj+4kXb6N9i7WnaqZMiY3gPsa/xVigsiQRQXN1jCnUNmmNeGX6prTYKQE+XsJY5MuVtyc0/5VlK5HbiTtuAlTvpC7/D+VzfIKm4gF0dnG/Kic0U0kZ16V8MbFnkymqKtZ+dm7uVYAMHeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214711; c=relaxed/simple;
	bh=g3lOm2tE7DSmNfXwpqo52bV22fwI+wW8pSQcoPFfCKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBw/usxFvtYBREFYDKyFXtXG+szFAAsJRaT2vcTifQI+PSHzlGkSlBWJO8S2Pq3EVo5RhZ7+cQ3BnV+7bdYEdIKut5mFaSrisZNGwFGO/pi+i/pZLz1hchr8ETbUbHhfuakUs625NrsjDRMqevyhFccb7/5S2xgniMX2a0bicC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YhTIEX8m; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214709; x=1760750709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kTsTs4HjLbhckmWwaJZ5if9B2cchKlIK+lHIAKfmVwg=;
  b=YhTIEX8mRBp3LcuKocPUSrg72ZcF+20s87ITv1Q7s5vrboAnXC22YFD0
   MrmpVOJ+ZlOTsG1AeerTCMGJF4E1o9GHMJQQPkjSOfBBHyBczkbhX5Zr3
   T9PpcccAeYjqxINVpxHx1eYeZAlCDePmN79k7F7P7f1A2XQy7npaHw+Mb
   U=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="767837293"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:25:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:22398]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 48d46014-15a4-468c-8e6a-849c3e5d52a6; Fri, 18 Oct 2024 01:25:08 +0000 (UTC)
X-Farcaster-Flow-ID: 48d46014-15a4-468c-8e6a-849c3e5d52a6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:25:08 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:25:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/11] rtnetlink: Define rtnl_net_lock().
Date: Thu, 17 Oct 2024 18:22:22 -0700
Message-ID: <20241018012225.90409-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018012225.90409-1-kuniyu@amazon.com>
References: <20241018012225.90409-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will need the per-netns version of rtnl_trylock().

rtnl_net_trylock() calls __rtnl_net_lock() only when rtnl_trylock()
successfully holds RTNL.

When RTNL is removed, we will use mutex_trylock() for per-netns RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/rtnetlink.h |  6 ++++++
 net/core/rtnetlink.c      | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 8468a4ce8510..b34d610b1249 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -101,6 +101,7 @@ void __rtnl_net_lock(struct net *net);
 void __rtnl_net_unlock(struct net *net);
 void rtnl_net_lock(struct net *net);
 void rtnl_net_unlock(struct net *net);
+int rtnl_net_trylock(struct net *net);
 int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b);
 
 bool rtnl_net_is_locked(struct net *net);
@@ -132,6 +133,11 @@ static inline void rtnl_net_unlock(struct net *net)
 	rtnl_unlock();
 }
 
+static inline int rtnl_net_trylock(struct net *net)
+{
+	return rtnl_trylock();
+}
+
 static inline void ASSERT_RTNL_NET(struct net *net)
 {
 	ASSERT_RTNL();
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a9c92392fb1d..bb4927da0275 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -210,6 +210,17 @@ void rtnl_net_unlock(struct net *net)
 }
 EXPORT_SYMBOL(rtnl_net_unlock);
 
+int rtnl_net_trylock(struct net *net)
+{
+	int ret = rtnl_trylock();
+
+	if (ret)
+		__rtnl_net_lock(net);
+
+	return ret;
+}
+EXPORT_SYMBOL(rtnl_net_trylock);
+
 static int rtnl_net_cmp_locks(const struct net *net_a, const struct net *net_b)
 {
 	if (net_eq(net_a, net_b))
-- 
2.39.5 (Apple Git-154)


