Return-Path: <netdev+bounces-180548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EFBA81A5B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DFD77B36C6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBD4156237;
	Wed,  9 Apr 2025 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cUIS7yrm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540021494C3
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161308; cv=none; b=MxZzdYY68y6IFVi23TqSE4BvM5RjhmY5NXxKN0ELUBryjtFcFyI9cOHGzsJuvjNRj8KnBwrmZNr9TXcuc6w8nsEf4N/QxD3dWCjVwTx9ivF9bQAVh23XTkx3v5bzSjCpKrUPg9Ve97xyYZ6/+0EDVRJSg56yjND9Jd6+xbZK8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161308; c=relaxed/simple;
	bh=iDlCGOyAn3wD17uqK2RuLIVclQR7VZIA1Dd9esExhfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRNPgbSbS4ilURZR+Jcahtfz8CKR7AfuqZiEDX1zdRij245bpZp2GXbsMvNGBTFtKWZlughwjEL0sRXlP4dVBEsXP+iNVpcKmJkrC+anQZ5zTX0qlnNkaDMlWWD09LUyt//KbdT7FMtusB5ize8zODxJcoDPbUQ31FU7q5O0HJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cUIS7yrm; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161307; x=1775697307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=peYX9k8WodJF0iUjFSpYPpkuqjpltWWTqX1g86TXg9Q=;
  b=cUIS7yrmUweNXDHqPqIY2dZj/ukwYBelNkPMJZYQGMNmUWaAa4kAatXi
   TAPgCXKyk6lhBtrcbTYpwqR/NrQLX8dNB55Xb//Xv7dP/ulMTTlKqd86s
   s7bOdkJVxyKdDOMmj+fp7TcigKHh6UuN4twiZTUSlda6N6koBH6UEipMA
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="8764621"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:15:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:39147]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 11809145-6da1-4cff-9c7e-4f711bf2b120; Wed, 9 Apr 2025 01:15:01 +0000 (UTC)
X-Farcaster-Flow-ID: 11809145-6da1-4cff-9c7e-4f711bf2b120
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:15:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:14:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 05/14] ipv6: Move nexthop_find_by_id() after fib6_info_alloc().
Date: Tue, 8 Apr 2025 18:12:13 -0700
Message-ID: <20250409011243.26195-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT.

Then, we must perform two lookups for nexthop and dev under RCU
to guarantee their lifetime.

ip6_route_info_create() calls nexthop_find_by_id() first if
RTA_NH_ID is specified, and then allocates struct fib6_info.

nexthop_find_by_id() must be called under RCU, but we do not want
to use GFP_ATOMIC for memory allocation here, which will be likely
to fail in ip6_route_multipath_add().

Let's move nexthop_find_by_id() after the memory allocation so
that we can later split ip6_route_info_create() into two parts:
the sleepable part and the RCU part.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 2cc8d650ce44..3e7e416794df 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3733,24 +3733,11 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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
@@ -3766,7 +3753,7 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		goto out;
 
 	err = -ENOMEM;
-	rt = fib6_info_alloc(gfp_flags, !nh);
+	rt = fib6_info_alloc(gfp_flags, !cfg->fc_nh_id);
 	if (!rt)
 		goto out;
 
@@ -3802,12 +3789,27 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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
2.49.0


