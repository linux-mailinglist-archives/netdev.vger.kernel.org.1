Return-Path: <netdev+bounces-169972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468D0A46AF7
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991703AE0F9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BB2238D5A;
	Wed, 26 Feb 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UDQvKoF3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3347623906A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598038; cv=none; b=bEzj1SBzvrg5bYPY9QDQ0ZuTeyDAAUuEX81CMheG9y3SNqUIvnuSY8FMdXW+TdjPtnu6H78HQ461QNgbSKR2b215hbePtKIQ9naOQRTHI1fCJn43A16Pye/Y7Fek6DI18a3c/SwPlUaQOaugMem6X6l1nuefj3xbg/ha8BgMf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598038; c=relaxed/simple;
	bh=Mh4yX1AeJRGXFO8labW/8wNKYxfPPvvpiVMNOWdFQbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EC2Z4Q1jR0Xax+KD9AVDIk5BfbGa5oKAtIS7PI9Hh6FcpSqQJWLcrhrx2+EfLu/XA2GT1YwO9bOAbVzv+y1CmV7C3EiaPyizBVS2K+R+bxN4f3GQaI+IbCxA9qlT7BRUwRKLzrtteNYgxRO4/0nepLIMckZUWJ/FoNz0o9LWfx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UDQvKoF3; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740598034; x=1772134034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LaF7zTDJJc+Ngr1OO7w76VZM5DKJu+dtBChFc+/axy0=;
  b=UDQvKoF3W+FsU9d3Xbb3t9568KJ/B3SJFzAmGXPR5K9BBUKMFytndEIh
   T2oThQIfmo6bhyiIgWaiybTO9b2BKNu9iekZ3j32W7t0rRXfZlDoSP1Ae
   Jhz/CzXYklEXkGjNPsaBhDJkNqq3gXOsL8PQ9ikK9Vxko12SkVWPIC+ah
   U=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="381126428"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:26:33 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:38450]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.58:2525] with esmtp (Farcaster)
 id 634e7c24-431f-4165-b3c9-73be919ba7c7; Wed, 26 Feb 2025 19:26:33 +0000 (UTC)
X-Farcaster-Flow-ID: 634e7c24-431f-4165-b3c9-73be919ba7c7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:26:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:26:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/12] ipv4: fib: Use cached net in fib_inetaddr_event().
Date: Wed, 26 Feb 2025 11:25:45 -0800
Message-ID: <20250226192556.21633-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250226192556.21633-1-kuniyu@amazon.com>
References: <20250226192556.21633-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net is available in fib_inetaddr_event(), let's use it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


