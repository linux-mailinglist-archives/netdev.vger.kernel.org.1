Return-Path: <netdev+bounces-176654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E57EFA6B38A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A30C17F3AD
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64BE1E51E3;
	Fri, 21 Mar 2025 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EeSwUkjG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA61E1A05
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529811; cv=none; b=JhgnyBC6BL35pDcSUAod0V78ZHNU/fOS0RFKFZZwMR481R/m29y8p/q6j9kQJPsdsM5+8X99Ng9mrWAL90KsFtXiUsQv1KSnYxIHv48vndnIAEUvdlvcAbic5Lvq9pNrLyA67ovEcNlm8TRb9ko0fxX35tOif6GdOfk5xYIfAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529811; c=relaxed/simple;
	bh=UXA9CBqplU/HS69ocFV4a6LK2SdwZ7y67vzUFSenG2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbKwJW8wbccYPJh2FWRg3On4A85L9wcnaUp4CrsZvOytquBmGD5bj7ZEKFM1K1W1/nuSEDW5g8+yjHPo8ml3PSetTZ28uDQ1emgqX+fFsNHWSTrwN7bHJN+dfkyljN6ZbWJE3bvvxCKFEAaWK/+mj8cwrFlG8o7Hqv6czV2LLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EeSwUkjG; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529808; x=1774065808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eLXQJQt1E/OlxCNmwZPh7n5wnCnzwnCe4AJgvdGlAFs=;
  b=EeSwUkjGaCb63Lbu/LdvkNopMAoEkGEql/gZG520xfvLKognxTSdtFvJ
   C8hY4bH+Bapo0cMSliSx6TSrV+ckdlGrlGppngJDxVo4CBZIqCCNhoOdU
   Pi2dV+pWGpFfTdUTPtH7/jDM4x+eMbXv0R/qfEFjTfcNBcOxYjVaK8hTY
   Y=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="76327025"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:03:23 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:63606]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.45:2525] with esmtp (Farcaster)
 id 4859e9dc-8db7-437f-8baf-646906bf8eac; Fri, 21 Mar 2025 04:03:21 +0000 (UTC)
X-Farcaster-Flow-ID: 4859e9dc-8db7-437f-8baf-646906bf8eac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:03:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:03:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/13] ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().
Date: Thu, 20 Mar 2025 21:00:41 -0700
Message-ID: <20250321040131.21057-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
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
index baad02c099ff..b51793ee7a18 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4996,6 +4996,7 @@ static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
 	}
 
 	do {
+		bool has_gateway = cfg->fc_flags & RTF_GATEWAY;
 		int attrlen = rtnh_attrlen(rtnh);
 
 		if (attrlen > 0) {
@@ -5009,9 +5010,17 @@ static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
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
 
@@ -5353,13 +5362,6 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
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
2.48.1


