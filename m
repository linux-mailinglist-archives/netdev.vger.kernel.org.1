Return-Path: <netdev+bounces-180547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA6AA81A5A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9F61B6494A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2564153BD9;
	Wed,  9 Apr 2025 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tUYc638u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF72AE89
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161281; cv=none; b=WZ5y9ShJ9IgY3EAZB410N4WPHMKWF/NQfpEkEidXbmNEA8IsCT8hJ03gqyur/mswXjEEHkka8pIpEYF0xLa0wMduRhiYQ4R2TAJHBA07N6qna8nmZjg9TxEyF0WnyGTqhb6PhXoAVFssOHBBuXbjp8XkdRtcOa9+e1LH4zofJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161281; c=relaxed/simple;
	bh=naHrZBkX43Wn8LCM8XokGDkFuqXRgcfjFXnn0ZUG1K4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAR4cXzeC13TwgZs9XfwHOVhkGm4F+TQhpCjqSeqrq9pNGO3wzqnvh5+CzBuQjYiKTRKhy55XqXQlJHFqqRQKdvLI8Ec6swh0caxMMu5FcPhiTkExNxBcaii9Nb1HQZ/GpnTvBjY5/CBKTT40f9hUl/mO6xadLIYmFPv5WdS+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tUYc638u; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161280; x=1775697280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sfAC2Cv5lynjeagoiqybAoy69KCjc8xVdlaegFvR0P0=;
  b=tUYc638ue2Ly/aZ7CU3r/ovdi6+XET0Rj/j2KflVVfMR0Lqi+DdPQWXr
   0Pdyt/JKqVz/u6Et18o6EPqfuvFcSpxB9ZCV6Nq1j5dHl+xsm1Y7JglkL
   FtOZjK1TNK9WtYMt3jQUZvencwBPLzHKw4HdxgVxa7NkHF4f+zItNtlnT
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="286831186"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:14:37 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:26745]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 4da516de-f401-47a1-bc71-46d89282b6d5; Wed, 9 Apr 2025 01:14:36 +0000 (UTC)
X-Farcaster-Flow-ID: 4da516de-f401-47a1-bc71-46d89282b6d5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:14:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:14:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 04/14] ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().
Date: Tue, 8 Apr 2025 18:12:12 -0700
Message-ID: <20250409011243.26195-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In ip6_route_multipath_add(), we call rt6_qualify_for_ecmp() for each
entry.  If it returns false, the request fails.

rt6_qualify_for_ecmp() returns false if either of the conditions below
is true:

  1. f6i->fib6_flags has RTF_ADDRCONF
  2. f6i->nh is not NULL
  3. f6i->fib6_nh->fib_nh_gw_family is AF_UNSPEC

1 is unnecessary because rtm_to_fib6_config() never sets RTF_ADDRCONF
to cfg->fc_flags.

2. is equivalent with cfg->fc_nh_id.

3. can be replaced by checking RTF_GATEWAY in the base and each multipath
entry because AF_INET6 is set to f6i->fib6_nh->fib_nh_gw_family only when
cfg.fc_is_fdb is true or RTF_GATEWAY is set, but the former is always
false.

Let's perform the equivalent checks in rtm_to_fib6_multipath_config().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 356d9284f4db..2cc8d650ce44 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5030,6 +5030,7 @@ static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
 	}
 
 	do {
+		bool has_gateway = cfg->fc_flags & RTF_GATEWAY;
 		int attrlen = rtnh_attrlen(rtnh);
 
 		if (attrlen > 0) {
@@ -5043,9 +5044,17 @@ static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
 						       "Invalid IPv6 address in RTA_GATEWAY");
 					return -EINVAL;
 				}
+
+				has_gateway = true;
 			}
 		}
 
+		if (newroute && (cfg->fc_nh_id || !has_gateway)) {
+			NL_SET_ERR_MSG(extack,
+				       "Device only routes can not be added for IPv6 using the multipath API.");
+			return -EINVAL;
+		}
+
 		rtnh = rtnh_next(rtnh, &remaining);
 	} while (rtnh_ok(rtnh, remaining));
 
@@ -5387,13 +5396,6 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 			rt = NULL;
 			goto cleanup;
 		}
-		if (!rt6_qualify_for_ecmp(rt)) {
-			err = -EINVAL;
-			NL_SET_ERR_MSG(extack,
-				       "Device only routes can not be added for IPv6 using the multipath API.");
-			fib6_info_release(rt);
-			goto cleanup;
-		}
 
 		rt->fib6_nh->fib_nh_weight = rtnh->rtnh_hops + 1;
 
-- 
2.49.0


