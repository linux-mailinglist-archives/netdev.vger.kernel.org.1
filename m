Return-Path: <netdev+bounces-134506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34457999E82
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542321C22C94
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A942F20B21A;
	Fri, 11 Oct 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="nQ11XvrD"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB220ADCC;
	Fri, 11 Oct 2024 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632953; cv=fail; b=dG+bdNpcjfTXqnuX/1iPuI+8rKt/6oV7e9aIPW8g3Y+ZL6Z17aDusEC/VJ54/3X0caIqMsFaZyBaDeeTJR6L0kGofV4XXLL8+hP5KZ58EZP870mx6vrR+zRLdkcMk/MWTmRy9edH9csgSAjU0ePq9wadr5wCvRD6wAFCKDmPZtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632953; c=relaxed/simple;
	bh=gATSOGAPHy7oSau5YIF10oGetc7l843uRdQqrA5Ykek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oliyqf5UCm65+Lu6B6qs4Ci30nCLxpJ/MRFOIsCrh+US7qIkvet+cV5/fIv9l/G1M15YzZQDAUREXFh1Koko+KpCHAE1234i0iqvM6P6o9LDGNtalDXfnCsdy/rER08iXN4BqxwVV4r1d52+gd/OILSyBNoRuMPkehkP096ipbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=nQ11XvrD; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtLnyfj2xdfT+jWslzVrclOiNSvP3IWnRCmEKCu0XxNVuW3nWFWm3PZIgn0i2ParZ0gq5ZauXueWaUtW0UC/7Dt44El5mI2uiYkzFwLql99CfdOgRMXsv7rx31Ld/UR33buzN5LucJQRI5TAFb2pW4RAh9fd+mFsjZSsQ5EOIcFd9OUpjIkEXI+XBHCQ7ACzoXGQ+opTWJWDzoRjYic35CdzkLq6eENHg91SIN+RgpEBKJCHZkhL0bMO26ogxCJw8ESzec2i+gDFoZndCxAxZfQAXkWLoFUbE5l2+ce/vMfdh3jDJX8HnF9GPqGmKchMjmzDd/MYrJ+SEBzqukeuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B1GpkF4tu72egQVDvAVI+CeZto2C1kTA1vIo04mBuY=;
 b=k9cjzhLypGwlg0ytUGdM8DnxOumiznm3BbGJEHlMcfoRXWY515feAUY95IxvFIr43EmeK/HvOrs8U1v3LTk72pWmDqmgYiOECLEl97ZLjFBOVHhDJz9OjdtZghZrTHpZ6IxK20+4RwSngEZU7laxs+ctnJveKE6QqWyLFs7r8Ng3/VJ8eo7d2drAUD8lfh84gydtiK/PkbBRTW1pZfzfgLguBF6YAUmZO2Isb4QQ3Cez20LXDS4t6MxkjDV9yqP8rAf5uIe7ezAL0nECQ5hKTYGzkS4kgGxhWR/Q3W31jk//C2PLHEBPg96LXd1xBdWp+1UsIZXP/U85uwRHAR2/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B1GpkF4tu72egQVDvAVI+CeZto2C1kTA1vIo04mBuY=;
 b=nQ11XvrDwehAgQtHKtjoIdsfhdU5tEIfrhjLcrbLBn8uymHEksoCT/Nu3kcpHukK4UPs7N/toZtOnn4aQrZEi8V0a+nSXVwv/VU8Dju8w9WPQamFNOn+ayUf0jNz0a10WQ0Irnp/CrW6Kyygyoh2YOuONuX7cmbclbPeCQy0Q4LZMKlJOWz21OQkyh6KaGwUskRj8grorb6CRDQX+K8Fa1KNflMBhJtySRcHHwW6jmFMVsWPbhDCZPeNxuqD/YS5FFrnVr/TfaVcQcsW9HJ/41goUsR3qTu7ECGowaor9fctc+Ihz+mZ4zv3pgPXyK13pCoPtP1OrrQiCt41tNufJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB10028.eurprd07.prod.outlook.com (2603:10a6:10:4cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Fri, 11 Oct
 2024 07:49:07 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 07:49:07 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v4 4/5] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_get_route()
Date: Fri, 11 Oct 2024 09:23:27 +0200
Message-ID: <20241011074811.2308043-8-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
References: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: f16a5b1d-fc39-4c16-a71b-08dce9c92f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4+oHHKnZfGkC8aAXEOWsQvr2549b703Xew6QAbezuBQ4n7y4kwxn6qYKHCn6?=
 =?us-ascii?Q?lApZITquk6ODVa/qc9gHix79bQllbDIEjpG4cGWWYiTCFH8U53/+m8pYOHZn?=
 =?us-ascii?Q?j6gK994ZDdO8dMOHxWaGWytC5w8QoggWaWFkdefVwwkMTsJ5K3my4pB3cCyf?=
 =?us-ascii?Q?MP9vNMuTJCWTJjKTkHb4sUXzY5bCEihy8mgAAfYGkdfzeDNQ67KeIT3lSUix?=
 =?us-ascii?Q?ZG57zR9yY7ET0j/MDWUemgXxnD9sF6iU4WuWLyuuIbRVhR+I2VSnN3AlTQbK?=
 =?us-ascii?Q?U++YbkZV/2tumsvhqLX9JP1j7sPkxksFkj3Sl9KDOnO6yKZRRzc/aIb0P4Ll?=
 =?us-ascii?Q?ti86bBMhYtpAil9zpK2T5UCdmuOHDNYiB81fN19X36dBZugmjEy1p/uXrjJO?=
 =?us-ascii?Q?E/yPTSgbgjBsfDy5WbSbJEVpuWUPZsHO5EM2Ij46mFqSjkbfcY7nVms7vxJ9?=
 =?us-ascii?Q?6IsxDOzmkGyG7Dhb//IOKq1fJjTKNCxUsWgaoAWFPYK+TZYqE4No/jWUGi00?=
 =?us-ascii?Q?wBUlODKIP0+UHxPh6coXNPSqiIiJ+Z4YGg+qy28J1kti6t8kHlO83E/6bOp0?=
 =?us-ascii?Q?2u/I/+2qj9mb/ynWmOOJaR90N60kWaqecn7E0rhzsmMYq4ZUmiYjB/Z4MXzu?=
 =?us-ascii?Q?B0ZbfgEQPsuKFIZEu+bgnSiLvljdnM2pFtn1iFuvfK7bOYfzfb+o/eie5P+A?=
 =?us-ascii?Q?V7jYRsWmp8WYwHdas4gGYaIi7LCwI+tfjBBwrHqsN0PqdhD7QJrmn4PCVEIR?=
 =?us-ascii?Q?9icZbBz30i46dq51JltsqGHRcYGilyHR45dpdmisvUyaayaIFP8E1yqNP9cu?=
 =?us-ascii?Q?WWeilrovCGe4V5mFuSF965cpH19ipmhVVXqBWfK12rNWnQJh5su3LqX/MF1g?=
 =?us-ascii?Q?Ww/UF8Wq7izqqRzbcXqcmFLGLLvk4L2vZSXRUoh6a6aCc++Pw3nx6nSKcRhi?=
 =?us-ascii?Q?bpC6fB2Z1Uu6eR6+Bmbd8LlRwEuU5YQ2biRkgXrUTJD2MTCdAfR6RLceLOI4?=
 =?us-ascii?Q?qJsHBzM++NDuHRANhwxeKdk18t0UvF7mfhQZ68Ji2JXKE/Y388nMsZsROE7a?=
 =?us-ascii?Q?Hu7vSDyJGaUlyTJrN0RaC4KUgbjpcH2Rka0z0Pb20C6nXgeagV4S2mZKIIY8?=
 =?us-ascii?Q?WRApgwgMqLkU4UEvZ423aj/dQxn+yzHmfWxObw2ISEjZe1sL4cVRP9a1+R76?=
 =?us-ascii?Q?RqCsCAep8n77Oi9NM/jcuG6bUkpqyRJ9FcRNz8Tjbekul7zlNsNvzEJnzHlL?=
 =?us-ascii?Q?QRyHGdOlX99NGSZo1cpwxALehUcjh4b40mFw30zsUpAamaUlD5MwIdEPrKnk?=
 =?us-ascii?Q?Dr4UO/TBzXUXCxH7ofP6ZndmPc0C0lf0vRQcVyARmFa6xQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A5S2NUrZdXbDPEumbmXSVHPCZSy7dRv2yG1vTn3Uqzodt8OAfKcPdn8Om7qE?=
 =?us-ascii?Q?EXWsaOYUNAPZtJD3pw6wdc2TwvhExnEWQjbmERE8W372p6AUoeb2rU28UIsS?=
 =?us-ascii?Q?eiJaPtJGLEOLLGwv7cubYK3+ZXRFiP7n3eiw+olymGrJ68ge5p28vUoD7ttt?=
 =?us-ascii?Q?bT5d9r9DPeykFY2srSygwM+bAkrp+sOR26eqoa62BlK2HgNth/ivlXGgWkBU?=
 =?us-ascii?Q?rVKGGAFGdtW5QajigArNbbTorazj7+w9OBfa5ZjTVcpjtysLorefZfN6C00+?=
 =?us-ascii?Q?6dmBSbeCQnkkgdmEvGPUUY5eGdwOvdqJKwP1I3An/dAmOvc5oVx7shrrqrrI?=
 =?us-ascii?Q?c838qfasRWvkuNi57jEX0KG/biP9ykJqEAlAkdPLT8ffcddx1/2P5wzt+8hF?=
 =?us-ascii?Q?LoaZhnmbNjLMzTAQzLjwh/qcc4+yD5STxKRkhWbk+70HIN2rNSoVU/9+8cgf?=
 =?us-ascii?Q?1KdVlCqP1Xnpe5a6MwtbMMe8C9u9gSxSXCvfdlSA7Nmch2I/iCrYj2TVIrRx?=
 =?us-ascii?Q?U/EzWCiWuCwchaaX5T0BSwtQ20WTAuECtGKnsLryHxOSLXiKMUkz0b8gH/+U?=
 =?us-ascii?Q?35VwC0vVo1FqbkMxDmllGGbZjSzrjOb5d52KsQEGfb54PMDKA7TMjjf0e1tI?=
 =?us-ascii?Q?MFho3ZvR7bBp3fag/c2URkXH3M0mfbD2mftHmpTilH4Jyp9+8ZpT5l7jWBUH?=
 =?us-ascii?Q?TzGSSfcHvvxQG7WMVk+OuQuBxw8ca/TdfFnplZrSTFhlPusbmgH2PC31tEHO?=
 =?us-ascii?Q?Ej1N3X09QrJYfD1tf6Csq+r8lqke9EnbiVY/l5oDrbzK2w7i139Xo9I1RWf/?=
 =?us-ascii?Q?NchkkNFlcCYuzaHUk50Qm4OVnqjziuDOIojNC/uPSHefYduN3VplYRpg76xA?=
 =?us-ascii?Q?0PfwVqSBquJqCl4sMkYrTqMylBWpqiIOYW8jDVjFgnr7b5bUTz0leplaWZCq?=
 =?us-ascii?Q?hsyhMAjePSpQ+eYEvBvueULQ7/2LWJCGB9SISxdzh0xNWM9DdIFv83ZVLaUI?=
 =?us-ascii?Q?KPcR+r3zKLXAW89Y7EpEmLizPIops6mtYhtL3rC7sD1BsXuQYLR1+toGmBH7?=
 =?us-ascii?Q?jZcMKTJ8NN6RsZu0339p12oAqvKLgyyvhd105txenjagDiX38NEynVFClnhA?=
 =?us-ascii?Q?JLItgMMoR7bmUJ9j7YrbDzY4MCSAEKFKeCmOMm0KZM0A+z2ICS8DNdC92V84?=
 =?us-ascii?Q?Jdg3b7GubhugtT/6AYJZ516LzX7GIQQdCGo1bkLOAc9Jne3ypCkV/J36Dq6j?=
 =?us-ascii?Q?e4JbqO3z5N0x3GyxxTm1sijvtJzrHDCi6UGPvdf75IlPdAXq6IXdDhIO+qGb?=
 =?us-ascii?Q?2IjPI9yClZUOn67aDLv+EZXylGe9YYRRubS8pFlf8hmQ4lsgbyRK+mfGhWSs?=
 =?us-ascii?Q?gowBrraBDEvkELyr2K6Wjs4wMLxl797qsuEoFLuuHOVGZ+j/vMkj2QAPfiUc?=
 =?us-ascii?Q?tXl87Yimj1kSFj2kT+BVdwkyWr/7L8tvtD0BsYHJfH7dd67ghwCLx057Nxp0?=
 =?us-ascii?Q?uMcHYVmSJvO4PDGmAX+nkG/4VCWe8zodrT0Nh0z302DLoUTlbZqMQuu2/tJn?=
 =?us-ascii?Q?lD6RMlcqs2J6YF8A2tPZn7HjObFHDbLw2ketHkRNAH5JixTQsUdhrKFre5tv?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16a5b1d-fc39-4c16-a71b-08dce9c92f87
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 07:49:07.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYi3UPMMRWvjXGkUmjdLk3o7F1B2Tkz+jKRTBEE4fBXV9txByaQZIQICit04k37HrD9cSrKMa1czpPNPZpNeWid00+L7l9nPB1LTlqre3No=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10028

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
 net/ipv6/ip6mr.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 1e233ee15d43..a817b688473a 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2300,11 +2300,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 	struct mfc6_cache *cache;
 	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	if (!mrt) {
+		err = -ENOENT;
+		goto out;
+	}
 
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &rt->rt6i_src.addr, &rt->rt6i_dst.addr);
 	if (!cache && skb->dev) {
 		int vif = ip6mr_find_vif(mrt, skb->dev);
@@ -2322,15 +2324,15 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 
 		dev = skb->dev;
 		if (!dev || (vif = ip6mr_find_vif(mrt, dev)) < 0) {
-			rcu_read_unlock();
-			return -ENODEV;
+			err = -ENODEV;
+			goto out;
 		}
 
 		/* really correct? */
 		skb2 = alloc_skb(sizeof(struct ipv6hdr), GFP_ATOMIC);
 		if (!skb2) {
-			rcu_read_unlock();
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto out;
 		}
 
 		NETLINK_CB(skb2).portid = portid;
@@ -2352,12 +2354,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 		iph->daddr = rt->rt6i_dst.addr;
 
 		err = ip6mr_cache_unresolved(mrt, vif, skb2, dev);
-		rcu_read_unlock();
 
-		return err;
+		goto out;
 	}
 
 	err = mr_fill_mroute(mrt, skb, &cache->_c, rtm);
+
+out:
 	rcu_read_unlock();
 	return err;
 }
-- 
2.42.0


