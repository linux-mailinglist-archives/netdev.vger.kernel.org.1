Return-Path: <netdev+bounces-169572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F3CA44A3D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE264239E8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D301A238A;
	Tue, 25 Feb 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ho6qYWaS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335B19C554
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507828; cv=none; b=Icy6U4PjEjmGl3f18epxt0io6xWI+UkzDlJFlrFfk+bdzvLHH9ArkVmWjuxO8u6akV4fEyCyyq33BebuB/gKG0zp7Khi//XddVX3JBv/F4Ll9Ne9PdlPD4jPQyFKoKqKIsYqh2tX1/ggTHV/FExzhsz/dip7U13MCSiakU8wgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507828; c=relaxed/simple;
	bh=R6T6Gw8zjGxJ5Z8fTuovrTkkbfjZCI+zKbH48Mc2ZyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaCGLykg46DkmIaN91iPIDlLC25abFsk8k+4YPAz9d2WBrmpU4Hl4KB0GRWpoA7/PIuvemqYRB6lu70FHvslOoHoIZSGJmLiZdq97o6kIMCiFj+1ZKLTC8uXZ1YqqOm3ZVM3k7yiavHQtYmKHn1vd7EA+xYAAT7XCjL6BcWqh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ho6qYWaS; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740507826; x=1772043826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CzSDrVZs/2qKHqrjm3/4oE1f70wN/gLWiqKWdATFs5I=;
  b=ho6qYWaSbbG/n8yKZ67S6YSgYLKXE/aD6LcHFPbAfcYF3ZGK42jaObFW
   /J7hhpW6+lcht7T5KYqqXbtFX7SM+KDmWBj8DpzYy3xqG60Itog0qnph2
   NT2fUp94TaWAUG72b6nMEcdWBrciZWtmN/l8Q5apAB365TzJ3+DJdAbHJ
   k=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="497108659"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:23:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:41659]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.24:2525] with esmtp (Farcaster)
 id 4df9829b-899f-462e-928d-ef4b140c6a55; Tue, 25 Feb 2025 18:23:30 +0000 (UTC)
X-Farcaster-Flow-ID: 4df9829b-899f-462e-928d-ef4b140c6a55
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:23:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:23:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/12] ipv4: fib: Use cached net in fib_inetaddr_event().
Date: Tue, 25 Feb 2025 10:22:39 -0800
Message-ID: <20250225182250.74650-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225182250.74650-1-kuniyu@amazon.com>
References: <20250225182250.74650-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net is available in fib_inetaddr_event(), let's use it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


