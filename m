Return-Path: <netdev+bounces-163419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DED6A2A37A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1973F167665
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF28211A0B;
	Thu,  6 Feb 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LFDuH0BQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BD163
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831665; cv=none; b=t2zjeeiGREHOZMu8+6jKPb+jKZw9+MAFYyuvmOYl5AIiriVrpYI7eR7OqopjcA6kGRFuQbACkkyRIQ38pIOsvgqosmxXQleEuwzhJT61msWhTxiUXLJWnbqfScARq2Kx94wODmyNu/YgUHnPNulljIAzMwa3F7KtrG12qMGNow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831665; c=relaxed/simple;
	bh=IfatC+cnYm6O6Kx0euS5DVGjzslo5tN+7J0d7efWUpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBxEBFSoTcovRv5F6j0vOJWY/XXKlIBzlK6hw0nLYZgcoQdWeDkzFvCSyGEk1sDTHRPiLBovDlONaS9SjzY1T2E58OYRd5I4lFmgb/HcR/tYOeoou7u6NTAeu55uyv7hW0J3JCU+RkYTBc3QFG7VovSOuIwId7UtomKam198K8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LFDuH0BQ; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738831664; x=1770367664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0BB+X7h9rYAk+3iBvdoMrEckwnwfjYQpuIrt7H9Wjj0=;
  b=LFDuH0BQSk8cr2IXOSARGZZE1o1ndcC+TuhWk2HP27hBNFVu8YJmTyRM
   6eW+WUMMlsFg3lXDcLPgKJdpGsLQpRmwkpmMd7JeH9Z/zT89IkX0+A3Hv
   PW5RFw+ebWTcWVY/lEOMZfO1hgFOUqfls8X8VoO+SHfcbmS4EloKhY5Iz
   M=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="796563169"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 08:47:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:27876]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.183:2525] with esmtp (Farcaster)
 id 99094cd6-599e-4eb5-9784-a5efc5e848cd; Thu, 6 Feb 2025 08:47:37 +0000 (UTC)
X-Farcaster-Flow-ID: 99094cd6-599e-4eb5-9784-a5efc5e848cd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:47:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:47:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/6] fib: rules: Pass net to fib_nl2rule() instead of skb.
Date: Thu, 6 Feb 2025 17:46:25 +0900
Message-ID: <20250206084629.16602-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250206084629.16602-1-kuniyu@amazon.com>
References: <20250206084629.16602-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

skb is not used in fib_nl2rule() other than sock_net(skb->sk),
which is already available in callers, fib_nl_newrule() and
fib_nl_delrule().

Let's pass net directly to fib_nl2rule().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 02dfb841ab29..87f731199538 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -512,14 +512,13 @@ static int fib_nl2rule_l3mdev(struct nlattr *nla, struct fib_rule *nlrule,
 }
 #endif
 
-static int fib_nl2rule(struct sk_buff *skb, struct nlmsghdr *nlh,
+static int fib_nl2rule(struct net *net, struct nlmsghdr *nlh,
 		       struct netlink_ext_ack *extack,
 		       struct fib_rules_ops *ops,
 		       struct nlattr *tb[],
 		       struct fib_rule **rule,
 		       bool *user_priority)
 {
-	struct net *net = sock_net(skb->sk);
 	struct fib_rule_hdr *frh = nlmsg_data(nlh);
 	struct fib_rule *nlrule = NULL;
 	int err = -EINVAL;
@@ -798,7 +797,7 @@ int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout;
 	}
 
-	err = fib_nl2rule(skb, nlh, extack, ops, tb, &rule, &user_priority);
+	err = fib_nl2rule(net, nlh, extack, ops, tb, &rule, &user_priority);
 	if (err)
 		goto errout;
 
@@ -906,7 +905,7 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout;
 	}
 
-	err = fib_nl2rule(skb, nlh, extack, ops, tb, &nlrule, &user_priority);
+	err = fib_nl2rule(net, nlh, extack, ops, tb, &nlrule, &user_priority);
 	if (err)
 		goto errout;
 
-- 
2.39.5 (Apple Git-154)


