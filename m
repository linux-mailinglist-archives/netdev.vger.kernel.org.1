Return-Path: <netdev+bounces-163841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CB7A2BC3D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF041888CD1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F621A2567;
	Fri,  7 Feb 2025 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XgVYES7v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F61898F8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913304; cv=none; b=E4RO+lge+lT7vzlw4tKGrNWsi3yZRuoEkHlqTrwttVgeXW/HK3lgEh/AuQ0/W1fYR9aKsyWw0x1rSY7kY39Ti+Yg0gIG5tTvjw+N9W5XSz8xaU0phvxLsOdjZB2Mz9f6XLtecgZ4kP1l9CT/VQ1SW5d3M0lKtsi8Wjj5b5gMrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913304; c=relaxed/simple;
	bh=6LgolliFO4lp3+epHda0vN6CE8jTXR8hgEcEBj6QZZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8Tku8AdQ5/NuBQyA/rh5A82UJSZ7fLHkZ9VuKelMMJwvnTolKvs+669JZ39CSo1peKtxrTScl4cLyUf66hXi/HwUkfTaKhot6k7NEKvrTozbE4v+qTGfgv1cam2+vLN0hwB5yVs2iJ7JhjuxyfvmWw/ivBKQIfSXZGj4PKRoE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XgVYES7v; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738913303; x=1770449303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uP+FqilN5jt0/E5Hck2T9yjlRvtmHOwYvDXHsRkUpOA=;
  b=XgVYES7voRIoqSnKSlRX1ctku5c6g9J3tM91HWTAYtct1MBsMpGQLzwg
   ZK8Ax9CFbzUtZ1vPkNv7W/vxbCRAGLqq7+rB4hthcrRxqco769x+114dz
   iCmIlLPYYHfzHcDALCxGrY9ptNFxvfW8n2/o4u2q+XujJuNHq9Qh0tdYo
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="464840771"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:28:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:15989]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.27:2525] with esmtp (Farcaster)
 id ab3a91d1-fc9a-4565-a8eb-f1c66893bfbb; Fri, 7 Feb 2025 07:28:20 +0000 (UTC)
X-Farcaster-Flow-ID: ab3a91d1-fc9a-4565-a8eb-f1c66893bfbb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 07:28:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 07:28:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 7/8] net: fib_rules: Add error_free label in fib_delrule().
Date: Fri, 7 Feb 2025 16:25:01 +0900
Message-ID: <20250207072502.87775-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will hold RTNL just before calling fib_nl2rule_rtnl() in
fib_delrule() and release it before kfree(nlrule).

Let's add a new rule to make the following change cleaner.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index d0995ea9d852..10a7336b8d44 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -946,23 +946,23 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 
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
@@ -1008,8 +1008,9 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
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


