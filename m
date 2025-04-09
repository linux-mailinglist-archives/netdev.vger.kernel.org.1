Return-Path: <netdev+bounces-180552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA3A81A64
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB003BF83B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF94E7D07D;
	Wed,  9 Apr 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fbrc84XX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DF29D0B
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161407; cv=none; b=A5eXWGaxGoGGx2e3nEBbrDHBp2ZLdpMu2Fr4ZXIlk19FwYw9cQ3kNHB4iVkqdB6xq/eWb+8dnZXR8bhSmFvn+o8B6vujYPXRS6xMr8ksH7NNQ953WXgovHj4c3rdUXbkC9oXjGO4cU/Zyoo73wxtO4uU4JfndPNTCSCdt4Tnp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161407; c=relaxed/simple;
	bh=wssqFq+R7RV7dQuG7XTWf9pwiEQH2Ns5KSyn1aZaOz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ui0Bm3i1Q6WJMSVU00A2C3OD7zg62d3ap7Xqfilkoi5IKnyx0XRytH1RF/q67XkS9JeQjl8+Fuc7RefYrcmbzgR8FKhcCtcFflHGgduunenSNDVtF0OA86b54p2qbkiP5Ztb8j3Ic/fikzWr4oxgpqsfgHNhsI//qmO51TULtRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fbrc84XX; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161406; x=1775697406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PffgB9K4iW4zJuAfDKDiK9mMqIAvsSMltMJ9e4Cx3w0=;
  b=Fbrc84XX4ZPWn82ifAyRPXjoNIgepycnjFXevq1I2JIoHJx720ChvBAE
   fXw+TZJwJUtkR/qMjuwqDJAyg8yHqoFwpPkN+lgw4VYkI+1bTBD6UuH3A
   lqQYkDUh8KQAIOiNFh5c5RnR3/bjwIwZwpLEgj3nVp99JI/8b2AbHHCv0
   k=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="734036816"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:16:43 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:42209]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 7a238fe7-491d-494b-bcba-9603b55403bd; Wed, 9 Apr 2025 01:16:41 +0000 (UTC)
X-Farcaster-Flow-ID: 7a238fe7-491d-494b-bcba-9603b55403bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:16:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:16:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 09/14] ipv6: Don't pass net to ip6_route_info_append().
Date: Tue, 8 Apr 2025 18:12:17 -0700
Message-ID: <20250409011243.26195-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409011243.26195-1-kuniyu@amazon.com>
References: <20250409011243.26195-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net is not used in ip6_route_info_append() after commit 36f19d5b4f99
("net/ipv6: Remove extra call to ip6_convert_metrics for multipath case").

Let's remove the argument.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index f5a405c09268..adefabce985f 100644
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


