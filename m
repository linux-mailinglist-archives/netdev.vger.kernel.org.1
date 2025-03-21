Return-Path: <netdev+bounces-176655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F21A6B38B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACC91888B41
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9A1E51E3;
	Fri, 21 Mar 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PhnpGHDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06F24120B
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529832; cv=none; b=fSRbbDl8OD3TnghE80ZIssj6d+ZHEIzJHf5mLNKoixYRWQrwSMbN5lfI7JW2Neu3OAessHBZv2fMKecKjV0AFbyBp3pwmSEh3rnX1sOhA36xoyzkBsPCYmU8M0s0ezeyH53NBThvPax15k2G5y9gSweDMhYitXiqfuxBWCgUQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529832; c=relaxed/simple;
	bh=8WL2nNFggGT5UZjeMkRz7khz3bjWH5+JppVSgmsFIQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQ6e+f4fwFlMSQUtYbyxpRi6XCnckhppAChzW6FXEMyYFEmVucFApACKk7rZ0qQwN53rcTDiK/LiMj8NnaQnDwHT+kKW9x0ksldDGXnp+GXXY8PkAc5uOGvtI0GCiiTBXi8nSN2h4om7bj1MPgPsZQltzrRKSpUgChO4/4uzRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PhnpGHDu; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529831; x=1774065831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=frwI6ICwtOt071miKLjDgUuf1L9osFhvOZc6jsQwvik=;
  b=PhnpGHDuyKAlGgjtJqmMA88ETv4P17oibTdQsdZtZm2gEZmma9hsBmfq
   B9gnMRKUsub3fj/IboC8VUzoa59DsxELl/iQSssVGZwkVxaAjYXmbGQ5t
   EJWwiyd9HFShGxywWfiKXL7667dsAesIoeYZmjNwRlYGqWDyL3PHn+Tj5
   A=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="482285625"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:03:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:9256]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.118:2525] with esmtp (Farcaster)
 id e3733c30-cda6-4b1f-b490-b7659526514d; Fri, 21 Mar 2025 04:03:45 +0000 (UTC)
X-Farcaster-Flow-ID: e3733c30-cda6-4b1f-b490-b7659526514d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:03:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:03:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 05/13] ipv6: Move nexthop_find_by_id() after fib6_info_alloc().
Date: Thu, 20 Mar 2025 21:00:42 -0700
Message-ID: <20250321040131.21057-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT.

Then, we must perform two lookups for nexthop and dev under RCU
to guarantee their lifetime.

ip6_route_info_create() calls nexthop_find_by_id() first if
RTA_NH_ID is specified, and then allocates struct fib6_info.

nexthop_find_by_id() must be called under RCU, but we do not want
to use GFP_ATOMIC for memory allocation here, which will be likely
to fail in ip6_route_multipath_add().

Let's move nexthop_find_by_id() after the memory allocation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b51793ee7a18..28d38282a19e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3699,24 +3699,11 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 {
 	struct net *net = cfg->fc_nlinfo.nl_net;
 	struct fib6_info *rt = NULL;
-	struct nexthop *nh = NULL;
 	struct fib6_table *table;
 	struct fib6_nh *fib6_nh;
-	int err = -EINVAL;
+	int err = -ENOBUFS;
 	int addr_type;
 
-	if (cfg->fc_nh_id) {
-		nh = nexthop_find_by_id(net, cfg->fc_nh_id);
-		if (!nh) {
-			NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
-			goto out;
-		}
-		err = fib6_check_nexthop(nh, cfg, extack);
-		if (err)
-			goto out;
-	}
-
-	err = -ENOBUFS;
 	if (cfg->fc_nlinfo.nlh &&
 	    !(cfg->fc_nlinfo.nlh->nlmsg_flags & NLM_F_CREATE)) {
 		table = fib6_get_table(net, cfg->fc_table);
@@ -3732,7 +3719,7 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		goto out;
 
 	err = -ENOMEM;
-	rt = fib6_info_alloc(gfp_flags, !nh);
+	rt = fib6_info_alloc(gfp_flags, !cfg->fc_nh_id);
 	if (!rt)
 		goto out;
 
@@ -3768,12 +3755,27 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	ipv6_addr_prefix(&rt->fib6_src.addr, &cfg->fc_src, cfg->fc_src_len);
 	rt->fib6_src.plen = cfg->fc_src_len;
 #endif
-	if (nh) {
+
+	if (cfg->fc_nh_id) {
+		struct nexthop *nh;
+
+		nh = nexthop_find_by_id(net, cfg->fc_nh_id);
+		if (!nh) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
+			goto out_free;
+		}
+
+		err = fib6_check_nexthop(nh, cfg, extack);
+		if (err)
+			goto out_free;
+
 		if (!nexthop_get(nh)) {
 			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
 			err = -ENOENT;
 			goto out_free;
 		}
+
 		rt->nh = nh;
 		fib6_nh = nexthop_fib6_nh(rt->nh);
 	} else {
-- 
2.48.1


