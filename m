Return-Path: <netdev+bounces-163418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF8A2A378
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C023A3B0D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D16214231;
	Thu,  6 Feb 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kqu1yH/3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D36163
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831637; cv=none; b=GOS0HLRBWSsIYaoW42fpPc5MxOckq4i2fsv+1GABTqPIPB3NpqvhChrFsMNrgfAJZJZK1OFsO4QjbdvXHWVBqhCSqvfbn4r6vsZiTEETkEmnvgdRHcKMt1LHaFFBIH0IZz/wEDL0tMLyGpQFuuKupVg07oJ00GnbdPavp+3two0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831637; c=relaxed/simple;
	bh=8RZzTG8rtcXyr68MzQhT4sPKAo+5B5l4WdGs51d+gUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MI/I/uvMDAhBKv+4dkBfN7ICuGWII1IIlQdFWsk1rQ0sokFsAKXghZRKVhG7F/vv7gzE4WfDqIpmEh0c5fKgQ0KV03fs3VnFYTKaJY8N4R9GiGd+LLbKuy5UyYYXD3WHDxDVoBAdnW23nIAR0aUwOtumAARiLZWoQw4G2H8Gwpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Kqu1yH/3; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738831635; x=1770367635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KreelsqqXuYSTBodDgBhJaKjOuVIDvgqCwjcnSlBpP4=;
  b=Kqu1yH/3/RIJVXsi6XdID7ZCnsF6IcA/cjlOneg0cKdrYILx5toQafL7
   sv4Kg+UQARDRa75dH+cF4tuW5eWItoc+J8l55uTkLXtLq0LyLaXVTx9ZM
   NowP7NFivdzAPS2b5feS0up+Q0t6CRsaG/sMEfRqNmwRwiDcoFCL7FrON
   o=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="464546071"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 08:47:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:7709]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.10:2525] with esmtp (Farcaster)
 id 47bc56bb-968f-47b5-8be9-ddc079c5442e; Thu, 6 Feb 2025 08:47:10 +0000 (UTC)
X-Farcaster-Flow-ID: 47bc56bb-968f-47b5-8be9-ddc079c5442e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:47:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:47:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/6] fib: rules: Don't check net in rule_exists() and rule_find().
Date: Thu, 6 Feb 2025 17:46:24 +0900
Message-ID: <20250206084629.16602-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
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


