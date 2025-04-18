Return-Path: <netdev+bounces-183991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C410A92E9D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA123B9AF6
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9546BF;
	Fri, 18 Apr 2025 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="daDwkX3d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5F1C32
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934795; cv=none; b=Tfy9w1MQebV9WJ6gDbqJNCmGacSns61vr14lP6qYz8aCLohfbp/dfzJWuetGJFPiP8OkOFZYKyf51/Jw/1J0chNErf/jkhUL25QPyBSZazPgtyFaCMsRdhg3ypznl4KO+BQ4e3b+H2b5coZQvFMACQf86jGmNRV/+wgDiAoXKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934795; c=relaxed/simple;
	bh=dwI7xtaXTwbiE+y7Ca8Un1ic/RVZGEmvZzd46q1BDAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+lxlvzvmaagK+x7eYY7cZu0E179jRarb2zW3Ln0gBwKXtG+ZL9o5ORZaiTieEVnm/S4qMVw9Eq9hxdBjGd+QpFlPNMD7LM1Ck2VEjCB6gP9lRUUaqEQ7vwzqd113LIYDKDGjkPNJImb4mK2SvOlHqc7jlaqR8H+bLkLxZubPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=daDwkX3d; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744934795; x=1776470795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vLwtUWVIpvkkYedTFKAROR42+ngFJH0Kh9G+u85bfrQ=;
  b=daDwkX3daAfQl1eZ1FblJeUiEZG0SHkj3/FNArRX67O5LGUCVRCDOQqn
   RAQ0P5x37DNVcLVVTKmcJSCaLpzMe0jEcT3AiJYz+SKnasoKU7jFZAJCl
   U8TsebJhsnaxYu5OqAFZOe8+LVLiG33FYugUUA7WEqcD362ScpZHyqIHS
   U=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="490407561"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:06:33 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:36211]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.240:2525] with esmtp (Farcaster)
 id 4ee7b281-462b-4014-9959-cd4e7f4b755d; Fri, 18 Apr 2025 00:06:32 +0000 (UTC)
X-Farcaster-Flow-ID: 4ee7b281-462b-4014-9959-cd4e7f4b755d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:06:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:06:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 04/15] ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().
Date: Thu, 17 Apr 2025 17:03:45 -0700
Message-ID: <20250418000443.43734-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418000443.43734-1-kuniyu@amazon.com>
References: <20250418000443.43734-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
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

These checks do not require RCU and can be done earlier.

Let's perform the equivalent checks in rtm_to_fib6_multipath_config().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v3: Explain the checks do not require RCU.
---
 net/ipv6/route.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 23102f37f220..5f370c269e64 100644
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


