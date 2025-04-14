Return-Path: <netdev+bounces-182416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7615A88AE9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BAA174B60
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B20F27FD79;
	Mon, 14 Apr 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hNon1vII"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BF17E4
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654774; cv=none; b=YfO6r9ouDzEfUEKlzn/NuU9Z0xbKj4vWr4QG/vD9IVYelTBNNR3M4UTbMCJGCbuPpqwjxy5Lsv23D7p5HJ3Yd1E80HrsmttNlpR5G6rqe8hjlp2g5LF/ECTQ7TDih6jLAaCu6C4PCZJPcgCqsqvQBMO1p6Lv9TrQrF7XBrivBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654774; c=relaxed/simple;
	bh=7h3Lu7959p06MK7UBMyGVlTUylZj9TFEgdpbirPcZGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQ638e0yhp4Y/hV1DHKofNqGkPLt96nZ1wrQkgOEH2lHsqeB8+PSFIe3iFMdkzbtGLjvQVLqNFR6Jgwc8TXFJqnhX2g7AMXhnRbOsnksXgh4awhXFH1kcRRNAmUMWSef05p0a7UqSL3wW7EBlTCMUJe2ALZq7QYznYg0oHyB/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hNon1vII; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654773; x=1776190773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gcDaJXP8LGE/eKxqC1BXbyAt7GtxPpYS3Iy/RrEmPxw=;
  b=hNon1vIIFacct0pH6O5MziS7XbAYIBYzp9Dd/egxKLD4McPtT+1uptNI
   RfFOEYsZxEATbel5/l/g7byogS4GmNoO5O3T38foHgZAkLC2c8LTvGzRi
   JD+cHh9lTQ+X+bJzbdW3GsKdFUNfJ/58Mfiu6Z8dYGRDOBQNSg2Zwa7Gi
   E=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="187300998"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:19:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:57367]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id d45b0915-4dac-46ea-af94-2ecfe314592f; Mon, 14 Apr 2025 18:19:32 +0000 (UTC)
X-Farcaster-Flow-ID: d45b0915-4dac-46ea-af94-2ecfe314592f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:19:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:19:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 10/14] ipv6: Factorise ip6_route_multipath_add().
Date: Mon, 14 Apr 2025 11:14:58 -0700
Message-ID: <20250414181516.28391-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT and rely
on RCU to guarantee dev and nexthop lifetime.

Then, the RCU section will start before ip6_route_info_create_nh()
in ip6_route_multipath_add(), but ip6_route_info_create() is called
in the same loop and will sleep.

Let's split the loop into ip6_route_mpath_info_create() and
ip6_route_mpath_info_create_nh().

Note that ip6_route_info_append() is now integrated into
ip6_route_mpath_info_create_nh() because we need to call different
free functions for nexthops that passed ip6_route_info_create_nh().

In case of failure, the remaining nexthops that ip6_route_info_create_nh()
has not been called for will be freed by ip6_route_mpath_info_cleanup().

OTOH, if a nexthop passes ip6_route_info_create_nh(), it will be linked
to a local temporary list, which will be spliced back to rt6_nh_list.
In case of failure, these nexthops will be released by fib6_info_release()
in ip6_route_multipath_add().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 205 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 130 insertions(+), 75 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 49eea7e1e2da..c026f8fe5f78 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5315,29 +5315,131 @@ struct rt6_nh {
 	struct fib6_info *fib6_info;
 	struct fib6_config r_cfg;
 	struct list_head next;
+	int weight;
 };
 
-static int ip6_route_info_append(struct list_head *rt6_nh_list,
-				 struct fib6_info *rt,
-				 struct fib6_config *r_cfg)
+static void ip6_route_mpath_info_cleanup(struct list_head *rt6_nh_list)
 {
-	struct rt6_nh *nh;
-	int err = -EEXIST;
+	struct rt6_nh *nh, *nh_next;
 
-	list_for_each_entry(nh, rt6_nh_list, next) {
-		/* check if fib6_info already exists */
-		if (rt6_duplicate_nexthop(nh->fib6_info, rt))
-			return err;
+	list_for_each_entry_safe(nh, nh_next, rt6_nh_list, next) {
+		struct fib6_info *rt = nh->fib6_info;
+
+		if (rt) {
+			free_percpu(rt->fib6_nh->nh_common.nhc_pcpu_rth_output);
+			free_percpu(rt->fib6_nh->rt6i_pcpu);
+			ip_fib_metrics_put(rt->fib6_metrics);
+			kfree(rt);
+		}
+
+		list_del(&nh->next);
+		kfree(nh);
 	}
+}
 
-	nh = kzalloc(sizeof(*nh), GFP_KERNEL);
-	if (!nh)
-		return -ENOMEM;
-	nh->fib6_info = rt;
-	memcpy(&nh->r_cfg, r_cfg, sizeof(*r_cfg));
-	list_add_tail(&nh->next, rt6_nh_list);
+static int ip6_route_mpath_info_create(struct list_head *rt6_nh_list,
+				       struct fib6_config *cfg,
+				       struct netlink_ext_ack *extack)
+{
+	struct rtnexthop *rtnh;
+	int remaining;
+	int err;
+
+	remaining = cfg->fc_mp_len;
+	rtnh = (struct rtnexthop *)cfg->fc_mp;
+
+	/* Parse a Multipath Entry and build a list (rt6_nh_list) of
+	 * fib6_info structs per nexthop
+	 */
+	while (rtnh_ok(rtnh, remaining)) {
+		struct fib6_config r_cfg;
+		struct fib6_info *rt;
+		struct rt6_nh *nh;
+		int attrlen;
+
+		nh = kzalloc(sizeof(*nh), GFP_KERNEL);
+		if (!nh) {
+			err = -ENOMEM;
+			goto err;
+		}
+
+		list_add_tail(&nh->next, rt6_nh_list);
+
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
+
+		rt = ip6_route_info_create(&r_cfg, GFP_KERNEL, extack);
+		if (IS_ERR(rt)) {
+			err = PTR_ERR(rt);
+			goto err;
+		}
+
+		nh->fib6_info = rt;
+		nh->weight = rtnh->rtnh_hops + 1;
+		memcpy(&nh->r_cfg, &r_cfg, sizeof(r_cfg));
+
+		rtnh = rtnh_next(rtnh, &remaining);
+	}
 
 	return 0;
+err:
+	ip6_route_mpath_info_cleanup(rt6_nh_list);
+	return err;
+}
+
+static int ip6_route_mpath_info_create_nh(struct list_head *rt6_nh_list,
+					  struct netlink_ext_ack *extack)
+{
+	struct rt6_nh *nh, *nh_next, *nh_tmp;
+	LIST_HEAD(tmp);
+	int err;
+
+	list_for_each_entry_safe(nh, nh_next, rt6_nh_list, next) {
+		struct fib6_info *rt = nh->fib6_info;
+
+		err = ip6_route_info_create_nh(rt, &nh->r_cfg, extack);
+		if (err) {
+			nh->fib6_info = NULL;
+			goto err;
+		}
+
+		rt->fib6_nh->fib_nh_weight = nh->weight;
+
+		list_move_tail(&nh->next, &tmp);
+
+		list_for_each_entry(nh_tmp, rt6_nh_list, next) {
+			/* check if fib6_info already exists */
+			if (rt6_duplicate_nexthop(nh_tmp->fib6_info, rt)) {
+				err = -EEXIST;
+				goto err;
+			}
+		}
+	}
+out:
+	list_splice(&tmp, rt6_nh_list);
+	return err;
+err:
+	ip6_route_mpath_info_cleanup(rt6_nh_list);
+	goto out;
 }
 
 static void ip6_route_mpath_notify(struct fib6_info *rt,
@@ -5396,75 +5498,28 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 {
 	struct fib6_info *rt_notif = NULL, *rt_last = NULL;
 	struct nl_info *info = &cfg->fc_nlinfo;
-	struct fib6_config r_cfg;
-	struct rtnexthop *rtnh;
-	struct fib6_info *rt;
-	struct rt6_nh *err_nh;
 	struct rt6_nh *nh, *nh_safe;
+	LIST_HEAD(rt6_nh_list);
+	struct rt6_nh *err_nh;
 	__u16 nlflags;
-	int remaining;
-	int attrlen;
-	int err = 1;
 	int nhn = 0;
-	int replace = (cfg->fc_nlinfo.nlh &&
-		       (cfg->fc_nlinfo.nlh->nlmsg_flags & NLM_F_REPLACE));
-	LIST_HEAD(rt6_nh_list);
+	int replace;
+	int err;
+
+	replace = (cfg->fc_nlinfo.nlh &&
+		   (cfg->fc_nlinfo.nlh->nlmsg_flags & NLM_F_REPLACE));
 
 	nlflags = replace ? NLM_F_REPLACE : NLM_F_CREATE;
 	if (info->nlh && info->nlh->nlmsg_flags & NLM_F_APPEND)
 		nlflags |= NLM_F_APPEND;
 
-	remaining = cfg->fc_mp_len;
-	rtnh = (struct rtnexthop *)cfg->fc_mp;
-
-	/* Parse a Multipath Entry and build a list (rt6_nh_list) of
-	 * fib6_info structs per nexthop
-	 */
-	while (rtnh_ok(rtnh, remaining)) {
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
-		rt = ip6_route_info_create(&r_cfg, GFP_KERNEL, extack);
-		if (IS_ERR(rt)) {
-			err = PTR_ERR(rt);
-			rt = NULL;
-			goto cleanup;
-		}
-
-		err = ip6_route_info_create_nh(rt, &r_cfg, extack);
-		if (err) {
-			rt = NULL;
-			goto cleanup;
-		}
-
-		rt->fib6_nh->fib_nh_weight = rtnh->rtnh_hops + 1;
-
-		err = ip6_route_info_append(&rt6_nh_list, rt, &r_cfg);
-		if (err) {
-			fib6_info_release(rt);
-			goto cleanup;
-		}
+	err = ip6_route_mpath_info_create(&rt6_nh_list, cfg, extack);
+	if (err)
+		return err;
 
-		rtnh = rtnh_next(rtnh, &remaining);
-	}
+	err = ip6_route_mpath_info_create_nh(&rt6_nh_list, extack);
+	if (err)
+		goto cleanup;
 
 	/* for add and replace send one notification with all nexthops.
 	 * Skip the notification in fib6_add_rt2node and send one with
-- 
2.49.0


