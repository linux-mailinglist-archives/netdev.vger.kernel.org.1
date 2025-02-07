Return-Path: <netdev+bounces-163836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 753C3A2BC36
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A167A2AFD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2B1A23BC;
	Fri,  7 Feb 2025 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v+5w14Pa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBB1898F8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913172; cv=none; b=Wl03nzhmHBTaqMahE7K3F2lDLODgwB+s+wz4fZbWpFXM6QqtDFclXKLeKcgW+JmFrniVQ2aIwoje/ZYX4QSUoczykjABiwx7CIpoDZRXIW/lnmQ1K+0pt2pZApAguBzklNbX+VTL6jiF7kJS6GOTc59adiTsuf3P3HF+xFEvBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913172; c=relaxed/simple;
	bh=IfatC+cnYm6O6Kx0euS5DVGjzslo5tN+7J0d7efWUpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2h6Y0Yc94cPRWmyuskeFtoTzBTl4a4Nfh6azl6c0ffCOphh6YWu2SuJ1ajItyoL96XdZRb3irgvGDQFoChB9k34DBZGuVjvJtqZ2ESOju0FfFh9XLKyIaqxNy+Y06xDlc+KryZpHJRLNRNSVGCNMWiNmvY8owrvf6f8cYaidv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v+5w14Pa; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738913171; x=1770449171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0BB+X7h9rYAk+3iBvdoMrEckwnwfjYQpuIrt7H9Wjj0=;
  b=v+5w14Paq5ITMDCwxyH9WqZ8NtqB3IPsZkuERJnPujxLtYbPIueVqN6S
   a0Bo6noqjB04LPPvWVlIyGAWbGEOP9N7BhqoAf0p6GQyVhRpBZEdPBaGc
   QlbTxuZBO9iTNGnJtJ9ZH1wrMUuxKD9sKpfeJNKBc7TCmPtS44yJmhybr
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="20517624"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:26:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:45735]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.120:2525] with esmtp (Farcaster)
 id b5c7557e-7377-473a-b98b-2535eacf9f68; Fri, 7 Feb 2025 07:26:08 +0000 (UTC)
X-Farcaster-Flow-ID: b5c7557e-7377-473a-b98b-2535eacf9f68
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 07:26:07 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 07:26:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/8] net: fib_rules: Pass net to fib_nl2rule() instead of skb.
Date: Fri, 7 Feb 2025 16:24:56 +0900
Message-ID: <20250207072502.87775-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207072502.87775-1-kuniyu@amazon.com>
References: <20250207072502.87775-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
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


