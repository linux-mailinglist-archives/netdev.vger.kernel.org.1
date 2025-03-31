Return-Path: <netdev+bounces-178366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08D8A76C1C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD83AC6A2
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3919C215179;
	Mon, 31 Mar 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="ADbUTKEo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646F2147F9
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439172; cv=none; b=Ks0CJk34VXT+ppLN7KK5w1uLgxGQD7bCY/48iboTtO/O0NywVfRD9LeWKKv83nGS6FTBIXy+JFGRJgpnHxLXN0gWdxcZuRko9cQ7NPL0OHLXffJxtG21a8NZWkmhRlcHGq8BS2t9bIe8FS/ETxOHjxyq4JlsaFXr6sO5QMmgOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439172; c=relaxed/simple;
	bh=sumPsHXvxbyGrSmFxyNVUXhHBOvAaWra+jw50rbxxEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3TVO+Fcff8xtWpWBL1J2fmHhgkL0fMlNR6R3lutlGNE6Z2YI4103dd0222JMjAeHzwtOnkmvjPXOvLDRr392hNje+eWgK6gLSi8b2hQDol4NvSFmZwLRdrRNAKrWkMGBjtb/6BLAGrBZatpIgW4gyff01tbWJm3G7pNVWs9avk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=ADbUTKEo; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4ZRH0D464Qz9x4n;
	Mon, 31 Mar 2025 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1743439164; bh=sumPsHXvxbyGrSmFxyNVUXhHBOvAaWra+jw50rbxxEU=;
	h=From:To:Cc:Subject:Date:From;
	b=ADbUTKEotHZXqdDsfOULdRUsl13kP7t2/Ab9NdfSoovnS4k1mLe9I3Ok3BMRWkin8
	 ni+KA7NGJMf4GVadyEei3CBmBBe+wJTeCrcbY7MYaQcV63Kc23d0TJeUKT3qMd1ajM
	 sy6SI2LsQ5yMWoDGYsl2VtoNJ9ErxS8lK2gU0z+o=
X-Riseup-User-ID: 5DDC78B36D3736A1334B04D92A599AF72CD7FC2AC1E4951304FC195398D4F6E8
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4ZRH0031k4zFwv5;
	Mon, 31 Mar 2025 16:39:12 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: netdev@vger.kernel.org
Cc: sowmini.varadhan@oracle.com,
	Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH net] ipv6: fix omitted netlink attributes when using RTEXT_FILTER_SKIP_STATS
Date: Mon, 31 Mar 2025 18:36:51 +0200
Message-ID: <20250331163651.9282-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using RTEXT_FILTER_SKIP_STATS should not skip non-statistics IPv6
netlink attributes. Move the filling of IFLA_INET6_STATS and
IFLA_INET6_ICMP6STATS to a helper function to avoid hitting the same
situation in the future.

Fixes: d5566fd72ec1 ("rtnetlink: RTEXT_FILTER_SKIP_STATS support to avoid dumping inet/inet6 stats")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 net/ipv6/addrconf.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ac8cc1076536..54a8ea004da2 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5784,6 +5784,27 @@ static void snmp6_fill_stats(u64 *stats, struct inet6_dev *idev, int attrtype,
 	}
 }
 
+static int inet6_fill_ifla6_stats_attrs(struct sk_buff *skb,
+					struct inet6_dev *idev)
+{
+	struct nlattr *nla;
+
+	nla = nla_reserve(skb, IFLA_INET6_STATS, IPSTATS_MIB_MAX * sizeof(u64));
+	if (!nla)
+		goto nla_put_failure;
+	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_STATS, nla_len(nla));
+
+	nla = nla_reserve(skb, IFLA_INET6_ICMP6STATS, ICMP6_MIB_MAX * sizeof(u64));
+	if (!nla)
+		goto nla_put_failure;
+	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_ICMP6STATS, nla_len(nla));
+
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
 static int inet6_fill_ifla6_attrs(struct sk_buff *skb, struct inet6_dev *idev,
 				  u32 ext_filter_mask)
 {
@@ -5806,18 +5827,10 @@ static int inet6_fill_ifla6_attrs(struct sk_buff *skb, struct inet6_dev *idev,
 
 	/* XXX - MC not implemented */
 
-	if (ext_filter_mask & RTEXT_FILTER_SKIP_STATS)
-		return 0;
-
-	nla = nla_reserve(skb, IFLA_INET6_STATS, IPSTATS_MIB_MAX * sizeof(u64));
-	if (!nla)
-		goto nla_put_failure;
-	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_STATS, nla_len(nla));
-
-	nla = nla_reserve(skb, IFLA_INET6_ICMP6STATS, ICMP6_MIB_MAX * sizeof(u64));
-	if (!nla)
-		goto nla_put_failure;
-	snmp6_fill_stats(nla_data(nla), idev, IFLA_INET6_ICMP6STATS, nla_len(nla));
+	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS)) {
+		if (inet6_fill_ifla6_stats_attrs(skb, idev) < 0)
+			goto nla_put_failure;
+	}
 
 	nla = nla_reserve(skb, IFLA_INET6_TOKEN, sizeof(struct in6_addr));
 	if (!nla)
-- 
2.49.0


