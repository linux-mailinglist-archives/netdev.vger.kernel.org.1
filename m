Return-Path: <netdev+bounces-182410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB517A88AE3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66F216DDDC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32DD27FD79;
	Mon, 14 Apr 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZVEm2Y/4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94217C21C
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654635; cv=none; b=dk0KgLtTDB1W/lm4vpRTQ1wtT956bzgB9ixyg3dNeAwu5Z/iF3eq4Y85WOtRW7s4BKjwB7FN4xMd95ZXvkkLma9m5hhRYDqlvzrQQpPta7+mQR6qkzGqqpJZUCawn7WrtF9xdQqLeFnCUhopJOeEb0sMXvCK8GoBPQpJT0Ybz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654635; c=relaxed/simple;
	bh=UlaAkeVM7PM2oDBJoAG551xexBJpLIvzDLzvyvIEMks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ey+9YpE60UqiubSpIwGZZrgmjd5qI0GLzdZ10vsIsAIG6PupBC0M6BrPt9bnBK7AZiCOk1FX2ab/GmpfUy1V0DvU52ISxqG9Hzgc4c6rIm3vZU8Uu77myuZys2BZ2unK007mr/sB7be5pYGnBHa0IVbYtbSRdUGNqRUFMYAOpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZVEm2Y/4; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654634; x=1776190634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A09hqCulpheuxd42vTOFk71vjyfPHFNNidi/zHwlpJI=;
  b=ZVEm2Y/4LoRVRRIJ5SEj5phjwDfjfuSfWe06TvWbAmg7ftxDxTskF3Dc
   Qzfm5R8IBUMTIncOVQKhluAh/zbUyZo/VjiDazJmbUIeoWG16on69uMvo
   U7VvJuIn+8Xz9bDFGknq2Rpj0n5N+vAsfW7SQDYHm7RTfCY9glJXAsXM3
   g=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="480298721"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:17:12 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:55787]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 5c910e75-8593-438c-8ba5-9cda2f44419f; Mon, 14 Apr 2025 18:17:11 +0000 (UTC)
X-Farcaster-Flow-ID: 5c910e75-8593-438c-8ba5-9cda2f44419f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:17:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:17:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 04/14] ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().
Date: Mon, 14 Apr 2025 11:14:52 -0700
Message-ID: <20250414181516.28391-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
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
index cb29b1f5fb1d..7e35187594e6 100644
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


