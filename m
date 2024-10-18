Return-Path: <netdev+bounces-136790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C089A3207
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02F31F226A7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B7C5478E;
	Fri, 18 Oct 2024 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SPWyLM3N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53263A1CD
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214693; cv=none; b=MyCslKO7WdXElzJ2nR55YZ68jhHxzHygZOqNRAvqUrWaKP0w0s4UFJYp+DNJuVFQOxTnNLjkebAy+9XIVvO9hTzU8tnEioJOdVUXPtWRd/cnUw97S21SyyS61cRjW7xJ6TbVYAoiFaMG5GmeSca/t7vun+cNhONtIcXvG/O2gGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214693; c=relaxed/simple;
	bh=eoSuikBMMj4LaBILpuU3JOxWDVEB0Fcw7lCsxY1oVTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqsqMJtKPSz9ooDe0Qt+kShbVzktpvfmts2lsoWA8CWR/jODkBPV0+85y+XtaeOyR6MnMGmtBGofm2ZaHTbc05abx5HtxZw4CyTqeRvDSV+ltqIZbFvuAjb9fkAPVnMtOASwCJ5jFyQQw0CPd4Q5HKzF6Na4PFG3indz64xkNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SPWyLM3N; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214691; x=1760750691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ID8GMW1atRpq3MVvRNpzdyZVxanzffTAx3Jp487Bbo=;
  b=SPWyLM3NvbADKhbshzOpw4+/sBEj1D88s9Bj93YU2Kb9N4fGTZhucMqf
   ykAHWWsaoda/CDXzfMbANiCfokehu8M9e/LUcA/OTaKXJWOMkkhDJedQ6
   y+crS73MilqvM1+4M3jydYpwCH7UASE8nR0W28kzsyXDoj+l5vr5RVdw8
   I=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="139029001"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:24:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:53620]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id 6d8cd578-797c-4c87-85aa-b4e1b71fec3f; Fri, 18 Oct 2024 01:24:49 +0000 (UTC)
X-Farcaster-Flow-ID: 6d8cd578-797c-4c87-85aa-b4e1b71fec3f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:24:49 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:24:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/11] ipv4: Convert check_lifetime() to per-netns RTNL.
Date: Thu, 17 Oct 2024 18:22:21 -0700
Message-ID: <20241018012225.90409-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018012225.90409-1-kuniyu@amazon.com>
References: <20241018012225.90409-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit 1675f385213e ("ipv4: Namespacify IPv4 address GC."),
check_lifetime() works on a per-netns basis.

Let's use rtnl_net_lock() and rtnl_net_dereference().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index cbda22eb8d06..f8e232dbb96a 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -756,7 +756,8 @@ static void check_lifetime(struct work_struct *work)
 		rcu_read_unlock();
 		if (!change_needed)
 			continue;
-		rtnl_lock();
+
+		rtnl_net_lock(net);
 		hlist_for_each_entry_safe(ifa, n, head, addr_lst) {
 			unsigned long age;
 
@@ -773,7 +774,7 @@ static void check_lifetime(struct work_struct *work)
 				struct in_ifaddr *tmp;
 
 				ifap = &ifa->ifa_dev->ifa_list;
-				tmp = rtnl_dereference(*ifap);
+				tmp = rtnl_net_dereference(net, *ifap);
 				while (tmp) {
 					if (tmp == ifa) {
 						inet_del_ifa(ifa->ifa_dev,
@@ -781,7 +782,7 @@ static void check_lifetime(struct work_struct *work)
 						break;
 					}
 					ifap = &tmp->ifa_next;
-					tmp = rtnl_dereference(*ifap);
+					tmp = rtnl_net_dereference(net, *ifap);
 				}
 			} else if (ifa->ifa_preferred_lft !=
 				   INFINITY_LIFE_TIME &&
@@ -791,7 +792,7 @@ static void check_lifetime(struct work_struct *work)
 				rtmsg_ifa(RTM_NEWADDR, ifa, NULL, 0);
 			}
 		}
-		rtnl_unlock();
+		rtnl_net_unlock(net);
 	}
 
 	next_sec = round_jiffies_up(next);
-- 
2.39.5 (Apple Git-154)


