Return-Path: <netdev+bounces-163835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A387DA2BC34
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78FA1888D6E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FE51A2544;
	Fri,  7 Feb 2025 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T+vwtQby"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98A188733
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913148; cv=none; b=hXKa6R4UBsIxfaBx5c/88pdqSkibOmMHGJZaVFZsmTPDdzTwtyf39kD+Ah09SZDZE62tKaa3yFMmeqMg9V8L2AcHPf+S2ouo3u7XXJRb28HanFdc2uYLTghC8w5tbo+MHOJrLY/rV71tV3euOTMWhUpVhLgcwlt4BeeDprQGJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913148; c=relaxed/simple;
	bh=8RZzTG8rtcXyr68MzQhT4sPKAo+5B5l4WdGs51d+gUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNNKM4GWAVXMM2tMhlk+0sJWZDSoNDFqim6PKKP6nI5AvjWKttMROR6E0jvbvd7k2cZ2j940VqYo4bAwUE5Rbg1Q71+o+W6xwEohuZEZ/PJQ4jNPdnQvqZXakDBlsm7PeM564A2moL3Zo5fr0pObobvOZbjPx9FtxTPQ+MKI8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=T+vwtQby; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738913147; x=1770449147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KreelsqqXuYSTBodDgBhJaKjOuVIDvgqCwjcnSlBpP4=;
  b=T+vwtQby7RBvi6HukvHPWM2K1/N+TQi9MaO7hZLK5F/guwiXJZr4Dkrx
   iVGpWpzi59s4cWP1vmBpUGz/jUrdtljhSTwJC/PcGYbXDZqv2HL9oRbdD
   JxfiBEHYikpDC7DwXdU7jcKhwG3ZzE+GmTuuB4I+0NQobwq2bnFQEYpck
   I=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="460448687"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:25:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:30164]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.183:2525] with esmtp (Farcaster)
 id 579e5f49-3462-4ec3-9604-4859b0aa4106; Fri, 7 Feb 2025 07:25:42 +0000 (UTC)
X-Farcaster-Flow-ID: 579e5f49-3462-4ec3-9604-4859b0aa4106
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 07:25:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 07:25:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/8] net: fib_rules: Don't check net in rule_exists() and rule_find().
Date: Fri, 7 Feb 2025 16:24:55 +0900
Message-ID: <20250207072502.87775-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

fib_nl_newrule() / fib_nl_delrule() looks up struct fib_rules_ops
in sock_net(skb->sk) and calls rule_exists() / rule_find() respectively.

fib_nl_newrule() creates a new rule and links it to the found ops, so
struct fib_rule never belongs to a different netns's ops->rules_list.

Let's remove redundant netns check in rule_exists() and rule_find().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index e684ba3ebb38..02dfb841ab29 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -459,9 +459,6 @@ static struct fib_rule *rule_find(struct fib_rules_ops *ops,
 		if (rule->tun_id && r->tun_id != rule->tun_id)
 			continue;
 
-		if (r->fr_net != rule->fr_net)
-			continue;
-
 		if (rule->l3mdev && r->l3mdev != rule->l3mdev)
 			continue;
 
@@ -719,9 +716,6 @@ static int rule_exists(struct fib_rules_ops *ops, struct fib_rule_hdr *frh,
 		if (r->tun_id != rule->tun_id)
 			continue;
 
-		if (r->fr_net != rule->fr_net)
-			continue;
-
 		if (r->l3mdev != rule->l3mdev)
 			continue;
 
-- 
2.39.5 (Apple Git-154)


