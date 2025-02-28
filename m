Return-Path: <netdev+bounces-170549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672CA49040
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E0F16E878
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE507191F6C;
	Fri, 28 Feb 2025 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KXHBgFPp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7D819
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716655; cv=none; b=rIgwrZe3wFt3EdSrZVnzgYhOBAazY0ZFs83B79k7C/0a+JBQProCPZ0jgnz/rWTwbyFTIFl7vGvl30y1lJLp/Ziutd1SWOwmn6AEU2ZHL/6fzIoBoH0LNldcWD0pPmEmDj+m003PC3B63VcHAIqNouVRRA+i5tRUZjAPQNtchsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716655; c=relaxed/simple;
	bh=iAVUBpQ+jbWf97omJNdLKxwAIoDuxoYswIG0LDNW/DE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrLGVg9bQ3TxgUU7vFeS/iDeMUR62gapea4qawJMxNE3N1t6hH/JmxYGWKufPgwwnclGdAwKiN54RMbdxwKOU/+0oecvcJquXvzNBq8AAEx5jWwrmRucsixBG72bHVDL/pqiqD1QHZlnADRjq22HDhQYd3sfZ9DT5PicsMK6qrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KXHBgFPp; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716655; x=1772252655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OFS52OUXP616a1y29divC0YGpdp2orGv+IkMx8RVeS0=;
  b=KXHBgFPpKSnlrhocitf3G9OePXG2WCjWuGnL9G3z7yYVhF57dXqhZ9Q0
   eiCE/6gGyOG6eKbv7RXlxpLDAoHb/zBH9f0TJ5t9Bj8sCXYo4hfvx5vtG
   kBQjX1JDGTWCLCfFhnPrYyr5E2YyUurAhGXuoyBOj1XaXSbJ0Qb4YRTHw
   4=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="802802666"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:24:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:23690]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.58:2525] with esmtp (Farcaster)
 id ff8717d5-1971-4da3-8e8e-60e31bf7c6e4; Fri, 28 Feb 2025 04:24:08 +0000 (UTC)
X-Farcaster-Flow-ID: ff8717d5-1971-4da3-8e8e-60e31bf7c6e4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:24:06 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:24:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 01/12] ipv4: fib: Use cached net in fib_inetaddr_event().
Date: Thu, 27 Feb 2025 20:23:17 -0800
Message-ID: <20250228042328.96624-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250228042328.96624-1-kuniyu@amazon.com>
References: <20250228042328.96624-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net is available in fib_inetaddr_event(), let's use it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/fib_frontend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 272e42d81323..6730e2034cf8 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1450,7 +1450,7 @@ static int fib_inetaddr_event(struct notifier_block *this, unsigned long event,
 		fib_sync_up(dev, RTNH_F_DEAD);
 #endif
 		atomic_inc(&net->ipv4.dev_addr_genid);
-		rt_cache_flush(dev_net(dev));
+		rt_cache_flush(net);
 		break;
 	case NETDEV_DOWN:
 		fib_del_ifaddr(ifa, NULL);
@@ -1461,7 +1461,7 @@ static int fib_inetaddr_event(struct notifier_block *this, unsigned long event,
 			 */
 			fib_disable_ip(dev, event, true);
 		} else {
-			rt_cache_flush(dev_net(dev));
+			rt_cache_flush(net);
 		}
 		break;
 	}
-- 
2.39.5 (Apple Git-154)


