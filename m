Return-Path: <netdev+bounces-190536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE99AB76FA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0155917089D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C64295503;
	Wed, 14 May 2025 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JhHiR5PZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E129616F
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254119; cv=none; b=Tt19DRePuE5Kjl4O7tMn+QyNPVTXmVw2lyPCG2msPaPh1oHDbShlWiwvJ9yRxg+qvRZE5ch8uXEToEZDo0YscWDl9BsoO2gFApWOhQGALLkz9wQ9YfqCHa+WZa0sJEYeZrEh6rEbOodVdz0VkMdBpx5i1ugDMjtMgx38HM3Rljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254119; c=relaxed/simple;
	bh=n3q/Mz36pdAltUBW9Ik5WqW9UZpxLwqMELOLCdlFMM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHAnEqBoQhTYb3Wnr0kYhP0qz01C5WevrCYuHwlcv1Unli6z8N9dZoVzt6W3SLE+G3UpeEw7Qil62WCfXg2o2pjGyjSi1dCOnDc4tf8/8enVDY9WHPJV1zVnoNH3uA4lgtLll949ybTwIrhWMe5ZAG1VLYiDC/D94B6N6j3BWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JhHiR5PZ; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747254117; x=1778790117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N3CSc3QEB1cayqofY94ix/LBX/ZhshJtWxTNENWtmL0=;
  b=JhHiR5PZiJYVVtm2kpUBjgUOIMEqBA+9WtSmi3SxS0jiX8yQi1ntoDX7
   PDmMCLBg8PvqYvNf5m4LWeSLUSNqBIgKGdMZ/t6+dlp8jozDmQ+KbR+p9
   FkpC/rIgGAwOpj+vnaTsM3trKPIJMaCuzWRHC6oEJppkfHGM1JhoUKhpW
   xCxmWWnbmkikKt9zS8T8J3hnF8luj1MQ78cjrRgW0eOFS7IEVf07YpfrJ
   10M/NmUk1ub8RIMAPfFpmS01L0vkyGnhlnRKAkifat1pAGyoUM2MLRBdW
   G0M4+252j7CJKOTGfT7lSt+raoQnvx+vq7Lq7xeRF1Lz98PFEazsdM2TB
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="50028130"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:21:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:9688]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.244:2525] with esmtp (Farcaster)
 id 869053f1-5701-407a-8761-00986cdcf586; Wed, 14 May 2025 20:21:56 +0000 (UTC)
X-Farcaster-Flow-ID: 869053f1-5701-407a-8761-00986cdcf586
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:21:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:21:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/7] Revert "ipv6: Factorise ip6_route_multipath_add()."
Date: Wed, 14 May 2025 13:18:58 -0700
Message-ID: <20250514201943.74456-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514201943.74456-1-kuniyu@amazon.com>
References: <20250514201943.74456-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 71c0efb6d12f ("ipv6: Factorise ip6_route_multipath_add().") split
a loop in ip6_route_multipath_add() so that we can put rcu_read_lock()
between ip6_route_info_create() and ip6_route_info_create_nh().

We no longer need to do so as ip6_route_info_create_nh() does not require
RCU now.

Let's revert the commit to simplify the code.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 193 +++++++++++++++++------------------------------
 1 file changed, 70 insertions(+), 123 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a87091dd06b1..96ae21da9961 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5335,131 +5335,29 @@ struct rt6_nh {
 	struct fib6_info *fib6_info;
 	struct fib6_config r_cfg;
 	struct list_head list;
-	int weight;
 };
 
-static void ip6_route_mpath_info_cleanup(struct list_head *rt6_nh_list)
+static int ip6_route_info_append(struct list_head *rt6_nh_list,
+				 struct fib6_info *rt,
+				 struct fib6_config *r_cfg)
 {
-	struct rt6_nh *nh, *nh_next;
+	struct rt6_nh *nh;
 
-	list_for_each_entry_safe(nh, nh_next, rt6_nh_list, list) {
-		struct fib6_info *rt = nh->fib6_info;
-
-		if (rt) {
-			free_percpu(rt->fib6_nh->nh_common.nhc_pcpu_rth_output);
-			free_percpu(rt->fib6_nh->rt6i_pcpu);
-			ip_fib_metrics_put(rt->fib6_metrics);
-			kfree(rt);
-		}
-
-		list_del(&nh->list);
-		kfree(nh);
+	list_for_each_entry(nh, rt6_nh_list, list) {
+		/* check if fib6_info already exists */
+		if (rt6_duplicate_nexthop(nh->fib6_info, rt))
+			return -EEXIST;
 	}
-}
-
-static int ip6_route_mpath_info_create(struct list_head *rt6_nh_list,
-				       struct fib6_config *cfg,
-				       struct netlink_ext_ack *extack)
-{
-	struct rtnexthop *rtnh;
-	int remaining;
-	int err;
-
-	remaining = cfg->fc_mp_len;
-	rtnh = (struct rtnexthop *)cfg->fc_mp;
-
-	/* Parse a Multipath Entry and build a list (rt6_nh_list) of
-	 * fib6_info structs per nexthop
-	 */
-	while (rtnh_ok(rtnh, remaining)) {
-		struct fib6_config r_cfg;
-		struct fib6_info *rt;
-		struct rt6_nh *nh;
-		int attrlen;
-
-		nh = kzalloc(sizeof(*nh), GFP_KERNEL);
-		if (!nh) {
-			err = -ENOMEM;
-			goto err;
-		}
 
-		list_add_tail(&nh->list, rt6_nh_list);
-
-		memcpy(&r_cfg, cfg, sizeof(*cfg));
-		if (rtnh->rtnh_ifindex)
-			r_cfg.fc_ifindex = rtnh->rtnh_ifindex;
-
-		attrlen = rtnh_attrlen(rtnh);
-		if (attrlen > 0) {
-			struct nlattr *nla, *attrs = rtnh_attrs(rtnh);
-
-			nla = nla_find(attrs, attrlen, RTA_GATEWAY);
-			if (nla) {
-				r_cfg.fc_gateway = nla_get_in6_addr(nla);
-				r_cfg.fc_flags |= RTF_GATEWAY;
-			}
-
-			r_cfg.fc_encap = nla_find(attrs, attrlen, RTA_ENCAP);
-			nla = nla_find(attrs, attrlen, RTA_ENCAP_TYPE);
-			if (nla)
-				r_cfg.fc_encap_type = nla_get_u16(nla);
-		}
-
-		r_cfg.fc_flags |= (rtnh->rtnh_flags & RTNH_F_ONLINK);
-
-		rt = ip6_route_info_create(&r_cfg, GFP_KERNEL, extack);
-		if (IS_ERR(rt)) {
-			err = PTR_ERR(rt);
-			goto err;
-		}
-
-		nh->fib6_info = rt;
-		nh->weight = rtnh->rtnh_hops + 1;
-		memcpy(&nh->r_cfg, &r_cfg, sizeof(r_cfg));
+	nh = kzalloc(sizeof(*nh), GFP_KERNEL);
+	if (!nh)
+		return -ENOMEM;
 
-		rtnh = rtnh_next(rtnh, &remaining);
-	}
+	nh->fib6_info = rt;
+	memcpy(&nh->r_cfg, r_cfg, sizeof(*r_cfg));
+	list_add_tail(&nh->list, rt6_nh_list);
 
 	return 0;
-err:
-	ip6_route_mpath_info_cleanup(rt6_nh_list);
-	return err;
-}
-
-static int ip6_route_mpath_info_create_nh(struct list_head *rt6_nh_list,
-					  struct netlink_ext_ack *extack)
-{
-	struct rt6_nh *nh, *nh_next, *nh_tmp;
-	LIST_HEAD(tmp);
-	int err;
-
-	list_for_each_entry_safe(nh, nh_next, rt6_nh_list, list) {
-		struct fib6_info *rt = nh->fib6_info;
-
-		err = ip6_route_info_create_nh(rt, &nh->r_cfg, extack);
-		if (err) {
-			nh->fib6_info = NULL;
-			goto err;
-		}
-
-		rt->fib6_nh->fib_nh_weight = nh->weight;
-
-		list_move_tail(&nh->list, &tmp);
-
-		list_for_each_entry(nh_tmp, rt6_nh_list, list) {
-			/* check if fib6_info already exists */
-			if (rt6_duplicate_nexthop(nh_tmp->fib6_info, rt)) {
-				err = -EEXIST;
-				goto err;
-			}
-		}
-	}
-out:
-	list_splice(&tmp, rt6_nh_list);
-	return err;
-err:
-	ip6_route_mpath_info_cleanup(rt6_nh_list);
-	goto out;
 }
 
 static void ip6_route_mpath_notify(struct fib6_info *rt,
@@ -5519,11 +5417,16 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	struct fib6_info *rt_notif = NULL, *rt_last = NULL;
 	struct nl_info *info = &cfg->fc_nlinfo;
 	struct rt6_nh *nh, *nh_safe;
+	struct fib6_config r_cfg;
+	struct rtnexthop *rtnh;
 	LIST_HEAD(rt6_nh_list);
 	struct rt6_nh *err_nh;
+	struct fib6_info *rt;
 	__u16 nlflags;
-	int nhn = 0;
+	int remaining;
+	int attrlen;
 	int replace;
+	int nhn = 0;
 	int err;
 
 	replace = (cfg->fc_nlinfo.nlh &&
@@ -5533,13 +5436,57 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	if (info->nlh && info->nlh->nlmsg_flags & NLM_F_APPEND)
 		nlflags |= NLM_F_APPEND;
 
-	err = ip6_route_mpath_info_create(&rt6_nh_list, cfg, extack);
-	if (err)
-		return err;
+	remaining = cfg->fc_mp_len;
+	rtnh = (struct rtnexthop *)cfg->fc_mp;
 
-	err = ip6_route_mpath_info_create_nh(&rt6_nh_list, extack);
-	if (err)
-		goto cleanup;
+	/* Parse a Multipath Entry and build a list (rt6_nh_list) of
+	 * fib6_info structs per nexthop
+	 */
+	while (rtnh_ok(rtnh, remaining)) {
+		memcpy(&r_cfg, cfg, sizeof(*cfg));
+		if (rtnh->rtnh_ifindex)
+			r_cfg.fc_ifindex = rtnh->rtnh_ifindex;
+
+		attrlen = rtnh_attrlen(rtnh);
+		if (attrlen > 0) {
+			struct nlattr *nla, *attrs = rtnh_attrs(rtnh);
+
+			nla = nla_find(attrs, attrlen, RTA_GATEWAY);
+			if (nla) {
+				r_cfg.fc_gateway = nla_get_in6_addr(nla);
+				r_cfg.fc_flags |= RTF_GATEWAY;
+			}
+
+			r_cfg.fc_encap = nla_find(attrs, attrlen, RTA_ENCAP);
+			nla = nla_find(attrs, attrlen, RTA_ENCAP_TYPE);
+			if (nla)
+				r_cfg.fc_encap_type = nla_get_u16(nla);
+		}
+
+		r_cfg.fc_flags |= (rtnh->rtnh_flags & RTNH_F_ONLINK);
+		rt = ip6_route_info_create(&r_cfg, GFP_KERNEL, extack);
+		if (IS_ERR(rt)) {
+			err = PTR_ERR(rt);
+			rt = NULL;
+			goto cleanup;
+		}
+
+		err = ip6_route_info_create_nh(rt, &r_cfg, extack);
+		if (err) {
+			rt = NULL;
+			goto cleanup;
+		}
+
+		rt->fib6_nh->fib_nh_weight = rtnh->rtnh_hops + 1;
+
+		err = ip6_route_info_append(&rt6_nh_list, rt, &r_cfg);
+		if (err) {
+			fib6_info_release(rt);
+			goto cleanup;
+		}
+
+		rtnh = rtnh_next(rtnh, &remaining);
+	}
 
 	/* for add and replace send one notification with all nexthops.
 	 * Skip the notification in fib6_add_rt2node and send one with
-- 
2.49.0


