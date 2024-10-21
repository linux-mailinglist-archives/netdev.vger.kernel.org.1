Return-Path: <netdev+bounces-137612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1E19A7271
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83381F22DBC
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2D1FA254;
	Mon, 21 Oct 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t0Ml+7s0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529B11946CF
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535745; cv=none; b=pN0z3EEK1a5aY5E1bLDCPSxAfXsTrpdUNxqLEH4eImmi7Bmzwie7zWfglkojIN/rcX7XpiKvwef47IODFmzjQ4P+HFaF65mg16tLkvp6o5S/FlCBAexM8QrhO5yynEVCKMD9nHlZTOTkDuiDNTSJg+YsXZeFdl/Zvpi4av0ujRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535745; c=relaxed/simple;
	bh=0sBocFyC95CCZULRBABEiGPpCg4bKhHJvFJlw+9hnw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1u4d0CZUfw/bU5nt8URz8euaLGYKCEjkZSyqqPImYsbaZG3xUE20RBE+a/5K/WUGS08SVhSvwrlwuvE3pSMxEhU6+JKKMVgFYKtQNpUjgFtcD8eDaOwGpyFzoGWkCMNVxD6OlMXX9h4ztLklEMGxnc94D8mYPJ2DtoVSApPoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t0Ml+7s0; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535743; x=1761071743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rNLahvehk8SurtCcM/l+ofeT5tjadMg+JUtu7/Mv72I=;
  b=t0Ml+7s02BUNjEDcdDaAQUSN/f79pzVKL08bQsdX5mAqC4uGGQISLYUa
   Mgjy1m3/AOka+2b4l6scCYWWefvAT1l4JRyHmdl+O2dcKWJUR6LXJvFZr
   fixtBOND4jzXIJbZXJb141tV+SHF08QK0JY/LtiKq1ko2J9Ow98Lh1OFd
   k=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="345304439"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:35:38 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:38339]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 5e0c8953-8fb6-4147-a3fe-e8f0b6cb6cbe; Mon, 21 Oct 2024 18:35:36 +0000 (UTC)
X-Farcaster-Flow-ID: 5e0c8953-8fb6-4147-a3fe-e8f0b6cb6cbe
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:35:36 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:35:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/12] rtnetlink: Define rtnl_net_trylock().
Date: Mon, 21 Oct 2024 11:32:36 -0700
Message-ID: <20241021183239.79741-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
References: <20241021183239.79741-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will need the per-netns version of rtnl_trylock().

rtnl_net_trylock() calls __rtnl_net_lock() only when rtnl_trylock()
successfully holds RTNL.

When RTNL is removed, we will use mutex_trylock() for per-netns RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/rtnetlink.h |  6 ++++++
 net/core/rtnetlink.c      | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 0e62918de63b..14b88f551920 100644
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


