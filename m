Return-Path: <netdev+bounces-175946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC2FA680BD
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B077716B170
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D2206F19;
	Tue, 18 Mar 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dB+T7DEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F951F7076
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340872; cv=none; b=NXGL5SgPHR361Pp4/URTinRXypqdsANzpCEPE/vOR8XHWUsjgg7MM2JKGefBD/K4oaw+oBhPSd9lY5+ukqAkygZwRqT95yY6ugFL1+wSe5IyhN862IHQL5ENYShdevygEgV/PDcckm5qHieyB+/tWa6kDgPWgLzk+4meJumVBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340872; c=relaxed/simple;
	bh=j/sk7MslS7mFqzEh7zsg5n06Y1dgeBPY3a8mqGL6Ybg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGYNwojlWfskws9Ivsg4h2JdZ7eJWfwOkYDro9Rr+Uo71i84QEbQYmib8OCrUFg8NTPxQ89bl+oHDt2pXlXLQhkjeRJUO8b1+jFVnSZ7r4tlP2hJkSD+fTwIZNo15kT1XCK8gt26UFac+JQEEjBej60OUtAw7e2TwMLuBAOSdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dB+T7DEi; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742340871; x=1773876871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p7EqmJziqjK9CoE1bau4jFoNDoLB/P9K//h96cMEfAU=;
  b=dB+T7DEi4CazBSs9ou8zG0AAfLtB+ZLyUpPPhP5ZkM/jIkEj2uJsRHQH
   qfG0si/0Sj3KZHOwpqq9tarhJ6qWGetowlorY3LSvwqIhuHmSHWVLXl3f
   scDoT/lZEmG2TEyhLZWkj+TQ7GmRPhabDJtJEJSrhrcLf0jQTeQJD6Usb
   c=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="706166550"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:34:29 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:25467]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.245:2525] with esmtp (Farcaster)
 id aae482d8-60f8-4e0f-8a61-c1a1d91ea4ff; Tue, 18 Mar 2025 23:34:29 +0000 (UTC)
X-Farcaster-Flow-ID: aae482d8-60f8-4e0f-8a61-c1a1d91ea4ff
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:34:28 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.212.115) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:34:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/7] nexthop: Check NLM_F_REPLACE and NHA_ID in rtm_new_nexthop().
Date: Tue, 18 Mar 2025 16:31:47 -0700
Message-ID: <20250318233240.53946-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318233240.53946-1-kuniyu@amazon.com>
References: <20250318233240.53946-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

nexthop_add() checks if NLM_F_REPLACE is specified without
non-zero NHA_ID, which does not require RTNL.

Let's move the check to rtm_new_nexthop().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index f21ea1ddd68f..09f5f31f34a0 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2928,11 +2928,6 @@ static struct nexthop *nexthop_add(struct net *net, struct nh_config *cfg,
 	struct nexthop *nh;
 	int err;
 
-	if (cfg->nlflags & NLM_F_REPLACE && !cfg->nh_id) {
-		NL_SET_ERR_MSG(extack, "Replace requires nexthop id");
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (!cfg->nh_id) {
 		cfg->nh_id = nh_find_unused_id(net);
 		if (!cfg->nh_id) {
@@ -3247,6 +3242,12 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto out;
 
+	if (cfg.nlflags & NLM_F_REPLACE && !cfg.nh_id) {
+		NL_SET_ERR_MSG(extack, "Replace requires nexthop id");
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = rtm_to_nh_config_rtnl(net, tb, &cfg, extack);
 	if (!err)
 		goto out;
-- 
2.48.1


