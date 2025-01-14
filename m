Return-Path: <netdev+bounces-158012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F3A101B7
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E321882423
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB2924635B;
	Tue, 14 Jan 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kps3Q7Pl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DF246327
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842025; cv=none; b=t6L+z7UhAOHTfw5qKEJ6PQIb4RSvEsqRxEbGpNjnxaFIX75JjBsj0fc6TOVAFHqq4RSz09OPr94EEHUcHf8UU474jV2s2f0b+AYySxvr2gWgYdUhdYnUUyb3Kl1JXs5QdfGhfShQEKZ2fVUcshvRwdwCC/kTcabaODr19k2miB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842025; c=relaxed/simple;
	bh=4zglpwGOFXNlQxQ4SW65AFnRGhsFcVKDT7CLU2GS9So=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfos384+agHDgKBpvF74F/jpUy4zq/HweXHMaRwz0rRmvhQoDvj3Bd+BhiUgrqURKQ75UFARn8zEEq+GR0dDbA63QuwYs0QmxU5SSxktiOEsJmJmNJXdq9qDcObRDKCq4R9vb/k+KYdUSGSTrIXP4PWCzy58ZX1MuJif1yeGBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Kps3Q7Pl; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736842021; x=1768378021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d+ZrDEkjvWf0BJUc8AFOKP1uBzysKKemrFWx8dCPvn4=;
  b=Kps3Q7Pl9fKm5Bz/2DrvS0AmJjBSz8fFfmiMeSkB+aHEO3OeBleV+cwe
   jFIvB5JjhFsa3UOH0kAO/t5G2/4KVT9BUbQV2TlQV3V8PYmOGuXrYSYCE
   SfjRACGexJBjUxu38yS1THC5HKmARbBJGI4ibY1iSXmufc6qwtYf04vCz
   8=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="262894646"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:06:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:36231]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.5:2525] with esmtp (Farcaster)
 id 92c301d3-35d6-4bff-937a-fd40efecb923; Tue, 14 Jan 2025 08:06:58 +0000 (UTC)
X-Farcaster-Flow-ID: 92c301d3-35d6-4bff-937a-fd40efecb923
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:06:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:06:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/11] ipv6: Hold rtnl_net_lock() in addrconf_verify_work().
Date: Tue, 14 Jan 2025 17:05:08 +0900
Message-ID: <20250114080516.46155-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114080516.46155-1-kuniyu@amazon.com>
References: <20250114080516.46155-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

addrconf_verify_work() is per-netns work to call addrconf_verify_rtnl()
under RTNL.

Let's use rtnl_net_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index fb0ef98c79b0..fe85cb2d49c8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4751,9 +4751,9 @@ static void addrconf_verify_work(struct work_struct *w)
 	struct net *net = container_of(to_delayed_work(w), struct net,
 				       ipv6.addr_chk_work);
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 	addrconf_verify_rtnl(net);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 }
 
 static void addrconf_verify(struct net *net)
-- 
2.39.5 (Apple Git-154)


