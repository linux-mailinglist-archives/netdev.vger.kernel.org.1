Return-Path: <netdev+bounces-137611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B369A7270
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493891F257B7
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C8E1FAC54;
	Mon, 21 Oct 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FO1ytvGC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DEB1FAC36
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535724; cv=none; b=mE9clXqHN8dvDKG8DXoaj2KL/TxIQVd6E/W5n4XNaptFOZUs5L234RhG0fL79SPS6eEt352ij7eKSKGClJ4ZU2ur2uvyrK2MqN5POeognUwR/Ea5u8PnTlyzAciFoJ3ntq5TkUQKkeimQRH6SLmuZyZYnxWLiyfGXdfq5gbHYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535724; c=relaxed/simple;
	bh=cK0uBC2/gbYY5JLe+8JuoLthqkEnWvIl249JbiXsiBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqZc46jn0bcjntaMJEA2Iw0C2cb4zMj4yEfiohd2DhPQAYFLb4rOOkVKDBCXps8YyfzYpNsbGBKdu2AvRvVHuDSPSQ+1Xq+/bH3pHzPSqocDx1i4zpQP6ALlAe6pNf1+0gaYGttsVyj5uXFQOg+5Zno9awUygiNyxlB4moD1Ds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FO1ytvGC; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535723; x=1761071723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrOCErJXm8t9ZOxOcPy/3Nc4oJw8K773wcIm50nQ1NU=;
  b=FO1ytvGC5oLKnESTvCbxil9NBN2wQ8LPexX1PleSYbcRfD+C6w623hXM
   1eBxqAsF7dbZt/ODIBMVCYaMrwGFW9sC21nXDUMa6WLpNbp3i3JUStILY
   4QuL3wik9Qwc6WJkKKL7BCxuOx1KmwZGBnA6OwwNZkByfNbf5hMrTnWa0
   E=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="35180841"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:35:20 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:1413]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.11:2525] with esmtp (Farcaster)
 id 09d8d25f-7d22-49ab-97d0-eaa392a388bf; Mon, 21 Oct 2024 18:35:19 +0000 (UTC)
X-Farcaster-Flow-ID: 09d8d25f-7d22-49ab-97d0-eaa392a388bf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:35:18 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:35:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/12] ipv4: Convert check_lifetime() to per-netns RTNL.
Date: Mon, 21 Oct 2024 11:32:35 -0700
Message-ID: <20241021183239.79741-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
References: <20241021183239.79741-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit 1675f385213e ("ipv4: Namespacify IPv4 address GC."),
check_lifetime() works on a per-netns basis.

Let's use rtnl_net_lock() and rtnl_net_dereference().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index db56c1e16f65..260df53ff342 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -771,7 +771,8 @@ static void check_lifetime(struct work_struct *work)
 		rcu_read_unlock();
 		if (!change_needed)
 			continue;
-		rtnl_lock();
+
+		rtnl_net_lock(net);
 		hlist_for_each_entry_safe(ifa, n, head, addr_lst) {
 			unsigned long age;
 
@@ -788,7 +789,7 @@ static void check_lifetime(struct work_struct *work)
 				struct in_ifaddr *tmp;
 
 				ifap = &ifa->ifa_dev->ifa_list;
-				tmp = rtnl_dereference(*ifap);
+				tmp = rtnl_net_dereference(net, *ifap);
 				while (tmp) {
 					if (tmp == ifa) {
 						inet_del_ifa(ifa->ifa_dev,
@@ -796,7 +797,7 @@ static void check_lifetime(struct work_struct *work)
 						break;
 					}
 					ifap = &tmp->ifa_next;
-					tmp = rtnl_dereference(*ifap);
+					tmp = rtnl_net_dereference(net, *ifap);
 				}
 			} else if (ifa->ifa_preferred_lft !=
 				   INFINITY_LIFE_TIME &&
@@ -806,7 +807,7 @@ static void check_lifetime(struct work_struct *work)
 				rtmsg_ifa(RTM_NEWADDR, ifa, NULL, 0);
 			}
 		}
-		rtnl_unlock();
+		rtnl_net_unlock(net);
 	}
 
 	next_sec = round_jiffies_up(next);
-- 
2.39.5 (Apple Git-154)


