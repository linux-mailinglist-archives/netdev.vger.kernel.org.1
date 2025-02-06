Return-Path: <netdev+bounces-163422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B033FA2A382
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1E33A3A76
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D28224AF0;
	Thu,  6 Feb 2025 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="koUFtY7c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A431163
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831739; cv=none; b=HKnSRwiZmDv6nbTo6v9bhGhM802FE5WEqqW/qTDJjSGSSwrq7sEDakKE2IsXlbSvHK6/hShJjsr7hWNwztZTKUjRX8bl/l4+xys3gKbxcG7ywbVl8lv2tFU/I3J87hVfcE7uSIGw/C0ay44tDBKakxPR02quyOFzz1eF2kmR1IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831739; c=relaxed/simple;
	bh=c4X/OAtQbVtCnB7ILPAhIQyJL6mT5rOCEUnu25IhDJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaaJChkBIsyejwwoCxLHUw8/v/uhKoOxF2Ye/ZIcwjxz4RRyI9mE1sM6z90wKLUyxv92zMZ2Eij1RiDh/astHR3L/IPeO4RK4D3y3R+DED9QKYQEpC2BqQ/zBTJnTqSzZAE+EcQxbxm7VABkwJAFMX3X0Nr/FDsXUhN86MLwFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=koUFtY7c; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738831737; x=1770367737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hSK1JqFhGXGdPQpD8O4Kk52ddjn8SBe09sRP0F8mEXg=;
  b=koUFtY7cV5E9exJDU2zdO/QeZaXTlJJdsFqPH9GMB6N+ZNQd1OU/Clqx
   jxPGEOckTmMuLrXsFzqFUhfgH1mlO9jEwxrY4FAoMUSI7zfdHEuHsAr3B
   PJ/5w+tbn+oK1iDoLf+4xv+U9oyRQaFrtvlK0KdZM3MSOLngdAao8B6UE
   0=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="796563631"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 08:48:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:1112]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.10:2525] with esmtp (Farcaster)
 id 5b175d36-9845-4029-9b46-e1180f14001f; Thu, 6 Feb 2025 08:48:56 +0000 (UTC)
X-Farcaster-Flow-ID: 5b175d36-9845-4029-9b46-e1180f14001f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:48:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:48:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/6] fib: rules: Add error_free label in fib_nl_delrule().
Date: Thu, 6 Feb 2025 17:46:28 +0900
Message-ID: <20250206084629.16602-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will hold RTNL just before calling fib_nl2rule_rtnl() in
fib_nl_delrule() and release it before kfree(nlrule).

Let's add a new rule to make the following change cleaner.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 3cdfa3ac8c7c..cc26c762fa9e 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -942,23 +942,23 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	err = fib_nl2rule_rtnl(nlrule, ops, tb, extack);
 	if (err)
-		goto errout;
+		goto errout_free;
 
 	rule = rule_find(ops, frh, tb, nlrule, user_priority);
 	if (!rule) {
 		err = -ENOENT;
-		goto errout;
+		goto errout_free;
 	}
 
 	if (rule->flags & FIB_RULE_PERMANENT) {
 		err = -EPERM;
-		goto errout;
+		goto errout_free;
 	}
 
 	if (ops->delete) {
 		err = ops->delete(rule);
 		if (err)
-			goto errout;
+			goto errout_free;
 	}
 
 	if (rule->tun_id)
@@ -1004,8 +1004,9 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	kfree(nlrule);
 	return 0;
 
-errout:
+errout_free:
 	kfree(nlrule);
+errout:
 	rules_ops_put(ops);
 	return err;
 }
-- 
2.39.5 (Apple Git-154)


