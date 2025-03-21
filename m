Return-Path: <netdev+bounces-176659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC90A6B39B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B5A19C43D7
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A113F1E5B9B;
	Fri, 21 Mar 2025 04:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vm6249bz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5451E5B7A
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529926; cv=none; b=R7ZkVLz/dFCY1qGKc8iq5MOmO0rJjzec8/LDiv7lqFSfXCvS0CY01Mx2tolf+lANbcjvc08vdd/wTOrKnosURx1sHLG+XCyCxtVm3j8Vn8kRTgP37jqSyHuWqFecZARnGpFCG3t51vH5bXIJ2bgyxRHKQyLm7EuDGNRJC9iPB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529926; c=relaxed/simple;
	bh=x0p/epXVRJZD1U3hLQvxMzhT0z4+y15167tMKkYGCiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=infHIefX82tzt5ZduBKhHBxzrgvyJ0zA/2OGjZ0P7SwEMg0imwT2dK1xSVKiUHyrkABceF1CAa6aNtIJBkoccDYNuQd24eQqMdrdrzHrp7NPVHtUDlPdfKWbnguvktvIZqIVXh4Ab5FYRP8VapIAxmPl1jjJ+k7v0uTlRvQbf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vm6249bz; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529925; x=1774065925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CpXAOKaMDcZP0iVUtPq97g7AX/600hT0o7wS3lnOizQ=;
  b=Vm6249bzm7Ms9xFnueP71XbdwJZnETY7EbmdqdrlyClPJgj6qnlq/ghk
   +Eek+4CGe0MXlvyVlY1QXuNbmZHDDL9PbXpJb4ZeddYojucYXluTbZBjv
   UYKdAF31LrZK/6i0UOUOGGJw3exe3Huk9K/fg0ku/VUastsoINpvEG5UU
   o=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="281276861"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:05:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:12465]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.69:2525] with esmtp (Farcaster)
 id 1500f905-3b35-476b-b726-9bcbaa004f31; Fri, 21 Mar 2025 04:05:21 +0000 (UTC)
X-Farcaster-Flow-ID: 1500f905-3b35-476b-b726-9bcbaa004f31
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:05:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:05:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/13] ipv6: Don't pass net to ip6_route_info_append().
Date: Thu, 20 Mar 2025 21:00:46 -0700
Message-ID: <20250321040131.21057-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321040131.21057-1-kuniyu@amazon.com>
References: <20250321040131.21057-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net is not used in ip6_route_info_append() after commit 36f19d5b4f99
("net/ipv6: Remove extra call to ip6_convert_metrics for multipath case").

Let's remove the argument.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index e65e2c8b7125..26e5a372a9cd 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5283,8 +5283,7 @@ struct rt6_nh {
 	struct list_head next;
 };
 
-static int ip6_route_info_append(struct net *net,
-				 struct list_head *rt6_nh_list,
+static int ip6_route_info_append(struct list_head *rt6_nh_list,
 				 struct fib6_info *rt,
 				 struct fib6_config *r_cfg)
 {
@@ -5424,8 +5423,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
 		rt->fib6_nh->fib_nh_weight = rtnh->rtnh_hops + 1;
 
-		err = ip6_route_info_append(info->nl_net, &rt6_nh_list,
-					    rt, &r_cfg);
+		err = ip6_route_info_append(&rt6_nh_list, rt, &r_cfg);
 		if (err) {
 			fib6_info_release(rt);
 			goto cleanup;
-- 
2.48.1


