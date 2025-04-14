Return-Path: <netdev+bounces-182415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F5A88AE8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683023AE818
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDF6288C92;
	Mon, 14 Apr 2025 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y/92IbBE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8717539A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654752; cv=none; b=dpmkRemDp39NtZR7b5KYP3RtVz43f1Zs5jrzKqAlDMt+d2V1RXI5EnCCt390d/Hj7PxQ19VRq6OSiRRdLO92j4c448kfwzv4Knh2bc99J9oj/DOLH9DmNO0zDLhpmLuFbiDZGZUXei7e6kfWSe3i1AOtO+MdZ5J3BF5s2TSvcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654752; c=relaxed/simple;
	bh=Y7OoyWhTQWzCqcGvQIbWCQcR4t0rwyxoyjDTOqb6/Zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XN4uwEc1QAHoZBB4kyvEJ6JYouOQHuNR9gk/gq2tLQll49yCUr7bSwR7sMj906XiSsQ+cmdWhaGua2+4YtZCx8U7fB1p/GGT8U+MY6f2FQlqDhpqyk0JYb70hL6NGw2BjkmfCExQAfwRWj7f4JEPPtEuW2EjlyylSUvtg3b/xa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Y/92IbBE; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654751; x=1776190751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wsmblRphDjAg0D82b3OiUMg9sgjjqJEqT60rmcOMW7U=;
  b=Y/92IbBETnc+K84JEu2vYKxxpeVoBl4ikvEUpv4bpGVq1ono64To/WNc
   J40aU/U3msas6wexeGv7+Xd4UFNqFk+tItFkrl+7DRrdi/16Au/HDTkhe
   vNT3HNMUZdde1hdOvElO11nsCCiYEdDaAov/VnZdhA7g/RXvfeD8AavFD
   w=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="735516487"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:19:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:38000]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 634aa218-6fb2-4c55-ab71-928da4358bf5; Mon, 14 Apr 2025 18:19:07 +0000 (UTC)
X-Farcaster-Flow-ID: 634aa218-6fb2-4c55-ab71-928da4358bf5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:19:06 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:19:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 09/14] ipv6: Don't pass net to ip6_route_info_append().
Date: Mon, 14 Apr 2025 11:14:57 -0700
Message-ID: <20250414181516.28391-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414181516.28391-1-kuniyu@amazon.com>
References: <20250414181516.28391-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net is not used in ip6_route_info_append() after commit 36f19d5b4f99
("net/ipv6: Remove extra call to ip6_convert_metrics for multipath case").

Let's remove the argument.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 7b33f46fdae4..49eea7e1e2da 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5317,8 +5317,7 @@ struct rt6_nh {
 	struct list_head next;
 };
 
-static int ip6_route_info_append(struct net *net,
-				 struct list_head *rt6_nh_list,
+static int ip6_route_info_append(struct list_head *rt6_nh_list,
 				 struct fib6_info *rt,
 				 struct fib6_config *r_cfg)
 {
@@ -5458,8 +5457,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
 		rt->fib6_nh->fib_nh_weight = rtnh->rtnh_hops + 1;
 
-		err = ip6_route_info_append(info->nl_net, &rt6_nh_list,
-					    rt, &r_cfg);
+		err = ip6_route_info_append(&rt6_nh_list, rt, &r_cfg);
 		if (err) {
 			fib6_info_release(rt);
 			goto cleanup;
-- 
2.49.0


