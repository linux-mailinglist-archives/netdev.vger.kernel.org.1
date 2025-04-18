Return-Path: <netdev+bounces-183992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A7A92E9E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A8B4674DD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9884E10E3;
	Fri, 18 Apr 2025 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bpzj4K1+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08680372
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934846; cv=none; b=Kv1EKg1ziXbmkSduCIU5fsg3jg7ytHaxWEZpL5hGHTXCdqLNizhVUUtbsAtoZbtBP/gwuAVCFsbmzJzRhxBKT2AcZtMSDzy+fRvMun1JHcayT+7jnnHUa/GqTmrKyFGVKmf4iaLBlMZAbvwptqMEq6Ww8kr+w+pcdAMs6+pmNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934846; c=relaxed/simple;
	bh=naN3x+y/H5dS/7zD9R/he30OEFrfAPg7DSgsAFR9EuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn6JIhwgdFlkQLYLc+oB3Vuv1JGvk3sg0N1WzyNFbzgTVln6X1KCp5hp+2eHbGJ0SCawRIhELP6rVVibtEGK7cKPdGtg4BLC2Iu6611dfIBMDYfZ7WNLcD23o+IeJAKIzRSAGcUuRqsz07E/rzAxK9+CXlNiWWfMAhk9SX5RpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bpzj4K1+; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744934841; x=1776470841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cZpXa3rh32OWvtEfAr8sx+3l0N4GmAu1NnfMF1Q2nq8=;
  b=Bpzj4K1+qtbihncT1MYi3dmUSd1qYEHuLzysDMZhev02gaPAaM5T9PP7
   fjHIpK/Iw+JYkiub2yvJpUkz1kcpYiREVs4q/X3xylPOh2Bkv8RyeezzE
   0y/09BGoUtNPgk2pzU4gIVljVHhwNmqJcoGi/HZxG35gebAloY4XcYGnC
   A=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="192136032"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:07:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:23530]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.20:2525] with esmtp (Farcaster)
 id 0f7071ea-65f6-44e0-88f9-1571aaabb56e; Fri, 18 Apr 2025 00:07:20 +0000 (UTC)
X-Farcaster-Flow-ID: 0f7071ea-65f6-44e0-88f9-1571aaabb56e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:07:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:07:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 06/15] ipv6: Split ip6_route_info_create().
Date: Thu, 17 Apr 2025 17:03:47 -0700
Message-ID: <20250418000443.43734-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT and rely
on RCU to guarantee dev and nexthop lifetime.

Then, we want to allocate as much as possible before entering
the RCU section.

The RCU section will start in the middle of ip6_route_info_create(),
and this is problematic for ip6_route_multipath_add() that calls
ip6_route_info_create() multiple times.

Let's split ip6_route_info_create() into two parts; one for memory
allocation and another for nexthop setup.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
v3: Update changelog s/everything as possible/as much as possible/
---
 net/ipv6/route.c | 95 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 33 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 06c5414fc14e..7328404c77c1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3728,15 +3728,13 @@ void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
 }
 
 static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
-					      gfp_t gfp_flags,
-					      struct netlink_ext_ack *extack)
+					       gfp_t gfp_flags,
+					       struct netlink_ext_ack *extack)
 {
 	struct net *net = cfg->fc_nlinfo.nl_net;
-	struct fib6_info *rt = NULL;
 	struct fib6_table *table;
-	struct fib6_nh *fib6_nh;
-	int err = -ENOBUFS;
-	int addr_type;
+	struct fib6_info *rt;
+	int err;
 
 	if (cfg->fc_nlinfo.nlh &&
 	    !(cfg->fc_nlinfo.nlh->nlmsg_flags & NLM_F_CREATE)) {
@@ -3748,22 +3746,22 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	} else {
 		table = fib6_new_table(net, cfg->fc_table);
 	}
+	if (!table) {
+		err = -ENOBUFS;
+		goto err;
+	}
 
-	if (!table)
-		goto out;
-
-	err = -ENOMEM;
 	rt = fib6_info_alloc(gfp_flags, !cfg->fc_nh_id);
-	if (!rt)
-		goto out;
+	if (!rt) {
+		err = -ENOMEM;
+		goto err;
+	}
 
 	rt->fib6_metrics = ip_fib_metrics_init(cfg->fc_mx, cfg->fc_mx_len,
 					       extack);
 	if (IS_ERR(rt->fib6_metrics)) {
 		err = PTR_ERR(rt->fib6_metrics);
-		/* Do not leave garbage there. */
-		rt->fib6_metrics = (struct dst_metrics *)&dst_default_metrics;
-		goto out_free;
+		goto free;
 	}
 
 	if (cfg->fc_flags & RTF_ADDRCONF)
@@ -3771,12 +3769,12 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 
 	if (cfg->fc_flags & RTF_EXPIRES)
 		fib6_set_expires(rt, jiffies +
-				clock_t_to_jiffies(cfg->fc_expires));
+				 clock_t_to_jiffies(cfg->fc_expires));
 
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
-	rt->fib6_protocol = cfg->fc_protocol;
 
+	rt->fib6_protocol = cfg->fc_protocol;
 	rt->fib6_table = table;
 	rt->fib6_metric = cfg->fc_metric;
 	rt->fib6_type = cfg->fc_type ? : RTN_UNICAST;
@@ -3789,6 +3787,20 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	ipv6_addr_prefix(&rt->fib6_src.addr, &cfg->fc_src, cfg->fc_src_len);
 	rt->fib6_src.plen = cfg->fc_src_len;
 #endif
+	return rt;
+free:
+	kfree(rt);
+err:
+	return ERR_PTR(err);
+}
+
+static int ip6_route_info_create_nh(struct fib6_info *rt,
+				    struct fib6_config *cfg,
+				    struct netlink_ext_ack *extack)
+{
+	struct net *net = cfg->fc_nlinfo.nl_net;
+	struct fib6_nh *fib6_nh;
+	int err;
 
 	if (cfg->fc_nh_id) {
 		struct nexthop *nh;
@@ -3813,9 +3825,11 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		rt->nh = nh;
 		fib6_nh = nexthop_fib6_nh(rt->nh);
 	} else {
-		err = fib6_nh_init(net, rt->fib6_nh, cfg, gfp_flags, extack);
+		int addr_type;
+
+		err = fib6_nh_init(net, rt->fib6_nh, cfg, GFP_ATOMIC, extack);
 		if (err)
-			goto out;
+			goto out_release;
 
 		fib6_nh = rt->fib6_nh;
 
@@ -3834,21 +3848,20 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		if (!ipv6_chk_addr(net, &cfg->fc_prefsrc, dev, 0)) {
 			NL_SET_ERR_MSG(extack, "Invalid source address");
 			err = -EINVAL;
-			goto out;
+			goto out_release;
 		}
 		rt->fib6_prefsrc.addr = cfg->fc_prefsrc;
 		rt->fib6_prefsrc.plen = 128;
-	} else
-		rt->fib6_prefsrc.plen = 0;
+	}
 
-	return rt;
-out:
+	return 0;
+out_release:
 	fib6_info_release(rt);
-	return ERR_PTR(err);
+	return err;
 out_free:
 	ip_fib_metrics_put(rt->fib6_metrics);
 	kfree(rt);
-	return ERR_PTR(err);
+	return err;
 }
 
 int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
@@ -3861,6 +3874,10 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
+	err = ip6_route_info_create_nh(rt, cfg, extack);
+	if (err)
+		return err;
+
 	err = __ip6_ins_rt(rt, &cfg->fc_nlinfo, extack);
 	fib6_info_release(rt);
 
@@ -4584,6 +4601,7 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
 		.fc_ignore_dev_down = true,
 	};
 	struct fib6_info *f6i;
+	int err;
 
 	if (anycast) {
 		cfg.fc_type = RTN_ANYCAST;
@@ -4594,14 +4612,19 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
 	}
 
 	f6i = ip6_route_info_create(&cfg, gfp_flags, extack);
-	if (!IS_ERR(f6i)) {
-		f6i->dst_nocount = true;
+	if (IS_ERR(f6i))
+		return f6i;
 
-		if (!anycast &&
-		    (READ_ONCE(net->ipv6.devconf_all->disable_policy) ||
-		     READ_ONCE(idev->cnf.disable_policy)))
-			f6i->dst_nopolicy = true;
-	}
+	err = ip6_route_info_create_nh(f6i, &cfg, extack);
+	if (err)
+		return ERR_PTR(err);
+
+	f6i->dst_nocount = true;
+
+	if (!anycast &&
+	    (READ_ONCE(net->ipv6.devconf_all->disable_policy) ||
+	     READ_ONCE(idev->cnf.disable_policy)))
+		f6i->dst_nopolicy = true;
 
 	return f6i;
 }
@@ -5399,6 +5422,12 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 			goto cleanup;
 		}
 
+		err = ip6_route_info_create_nh(rt, &r_cfg, extack);
+		if (err) {
+			rt = NULL;
+			goto cleanup;
+		}
+
 		rt->fib6_nh->fib_nh_weight = rtnh->rtnh_hops + 1;
 
 		err = ip6_route_info_append(info->nl_net, &rt6_nh_list,
-- 
2.49.0


