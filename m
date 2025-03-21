Return-Path: <netdev+bounces-176656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D4A6B38C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50550188E0AE
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B531E5B66;
	Fri, 21 Mar 2025 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZjRJAWAv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B0F2A1CF
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529860; cv=none; b=nVroKJn3uy+iuqcjqaahTf4UbFzAyWyrwaXMypzwPFQ1qqocTwO4/bQPaD67DcZJRv4CAFwubH7P/wZAcpHYLKTQP/5Vn/YV4Q9qMIZibOr2f56nUddX+t0fw4ZZXwkA6eh9nks+T9RrUj1i5nmC2C9w32OvVXrnnOTWkeMl+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529860; c=relaxed/simple;
	bh=R2JQWFJmV6Jry29T494C8lLEdUiJ/3E6HgkoTsnnFdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fy4KR8tI0WHFhklewXXPDADmo4t1PmrFvCPVqtktnuBuA9mlUlpZn0W/mBOM9GC8OAxksz+LgiAT2ewFdoHqYrZXcMN0vknS9DKdwU+Ht3LPshaiD3VAeiIewcsnJo9Jemkc25eOAK54VFgRTSoMElXWNdRScfHcBqG5TAtXkds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZjRJAWAv; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529859; x=1774065859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7bGTC8FQx814JSfear+LfikTvmHq3luuQDdcA6CG00M=;
  b=ZjRJAWAvFuhXATBHKQIPUjwkAHgHXzTBL67lj69fqsQKRQQx80rGPLiM
   LV8fNBZZOqgPRISuJgNh4shywP/6nHiX6JiAgcIY9+Fz81TB5nQqvgPv1
   is5joRJQ9MXEq16N2Wkhy28ssZJyaYHQtp+LEj7P9jxCNovZX2niI5HBR
   o=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="809303903"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:04:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:63979]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.36:2525] with esmtp (Farcaster)
 id 87847561-766b-4e6c-b801-48845bb865ac; Fri, 21 Mar 2025 04:04:12 +0000 (UTC)
X-Farcaster-Flow-ID: 87847561-766b-4e6c-b801-48845bb865ac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:04:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:04:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 06/13] ipv6: Split ip6_route_info_create().
Date: Thu, 20 Mar 2025 21:00:43 -0700
Message-ID: <20250321040131.21057-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT.

Then, we want to allocate everything as possible before entering
the RCU section.

The RCU section will start in the middle of ip6_route_info_create(),
and this is problematic for ip6_route_multipath_add() that calls
ip6_route_info_create() multiple times.

Let's split ip6_route_info_create() into two parts; one for memory
allocation and another for nexthop setup.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 95 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 33 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 28d38282a19e..6299cfd9f12a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3694,15 +3694,13 @@ void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
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
@@ -3714,22 +3712,22 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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
@@ -3737,12 +3735,12 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 
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
@@ -3755,6 +3753,20 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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
@@ -3779,9 +3791,11 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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
 
@@ -3800,21 +3814,20 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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
@@ -3827,6 +3840,10 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
+	err = ip6_route_info_create_nh(rt, cfg, extack);
+	if (err)
+		return err;
+
 	err = __ip6_ins_rt(rt, &cfg->fc_nlinfo, extack);
 	fib6_info_release(rt);
 
@@ -4550,6 +4567,7 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
 		.fc_ignore_dev_down = true,
 	};
 	struct fib6_info *f6i;
+	int err;
 
 	if (anycast) {
 		cfg.fc_type = RTN_ANYCAST;
@@ -4560,14 +4578,19 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
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
@@ -5365,6 +5388,12 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
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
2.48.1


