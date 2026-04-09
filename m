Return-Path: <netdev+bounces-276902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGwyMHtu12k5OAgAu9opvQ
	(envelope-from <netdev+bounces-276902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:16:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C96013C8563
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A50EC300BC84
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A843AA1BF;
	Thu,  9 Apr 2026 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V3DmeNw4"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E33A5E65
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725808; cv=fail; b=cmmcRlXOi/Vn9XQG9etJFrkSudsHD5KeZmtlpf8DTNWaQNx8bMrXqg5ACZcEYfDk/PGD5k7WWWaY92tr9c93HqQVnE55UR+yhzbYMi3TCjTO7HVeC2RAG8YAWaoHuwa+tDHsnKEMOzGhRBK6FvCE6EK1/6c2PbCkx6s/nhvmYrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725808; c=relaxed/simple;
	bh=Jzx1od1DyInl6OxF+pQBDPyrnGwqgs0+TtGz7ys37AU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cGc1Jv7ZquUUaRfR17b7WVjKviDko62UUgAMR5z6x9dm/MptcZizJm4lkcXR4cUdufj9IhvY2RzwWsLAKWnUP40qxMxQG3FffKaE/NW0wi/hxgG31c4Svzj+N7HFc3Mo6Gdv2GN/cuPdfNTwHBy+UzcCvWecq/2rgwGEj3Qsc+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V3DmeNw4; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLL+TPP9po4bU0/c3QIXU94ErCtnWQsOHsSaJEBRRA1pswvrp11b8RnXxsJfaQQR4lxFm26bKfD/KaC+l9FScjEArTJA/l+tFTw8igaFhJSb3t8DvmrnLkx2SYi3/eqNDxjSuMZE79iKDn67P8K6gnbLLy+VzYScTxK1nt4NK55i90J0BQp06mxhm5xTJZaHZ9NUNHuGNACEJ9mlEG4CctC0sapNAJWH2RxyNGh/02SKZ3+80jbj4A74D2RdCEfFgAMpzEOjWaPoAPx7sU24ll7LFatYEQY33R7ztAYhL2cB4rz9HQ5pzPYJfWbivIFDwcN4kWgCGHd2eGKmsFjuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMkFz9dsFZ1b/P9nxqfNppzzfzNFPHKJc+zEDRiDOnc=;
 b=uNphMgEtf0af4A8t7s2VRuBhFJDIRZ1ZrKLn1OdQin+h/Dq+2raDwCDBQ80LJ423n1jwljj6NpyIRineNLWw/HRthZzfnbLJmVgr8uz2pf8r8/yvN09JkBiw8WIxXuF8/jomry83fjQIG+pSA7NRZJrybEc9Q1zY/bXezC/L+elaIk+f2g/mH157HZQjbyyIJWBiwHQOCbLibUqgljCHVcNC5SPsSHtqiwXr4RbrsNFjFG8h2gHrJNVNqJAJ30NF78ZounlMKNOXA14FoL6SVq9Gu24uAztbaXvbNOEoTomZ7IU85lXInSbu014Ni/SpU4338Yb4tb1M2yReVg1SBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMkFz9dsFZ1b/P9nxqfNppzzfzNFPHKJc+zEDRiDOnc=;
 b=V3DmeNw4VVbZqyYP3iSDsXo4hndZjpoyFGedCCyVbuPJSlTAeP0whU4EkeoihrbdFdlY6fTM5xDN2mX64s9PXxuP4Hg7dTx9bUYdse7kd9WME155HJUjIbbqt37f60LNxyOsCwabOdS1Qq06SFaRT9DairlEqG1tWd8QK0SarTKPnqs51+3IBLun6FDPEPleXqARmhoQolID9TtgsY4kFjJ16Io+PBvbitulZiGVwr99HvlJSXgA60CukYow2r9N5z0cPH6TfGcjTVLmrEhhq8LTHVvC/Y2PMYlqVJuLzEYHWJXhtBCaUQCsm1sWN+qC1+E3V2Pgm9w8XBVwGpQVGw==
Received: from CH0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:610:e7::13)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 09:10:02 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::ad) by CH0PR03CA0218.outlook.office365.com
 (2603:10b6:610:e7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 09:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:10:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 02:09:49 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 02:09:48 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 02:09:46 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net-next] gre: Count GRE packet drops
Date: Thu, 9 Apr 2026 12:09:45 +0300
Message-ID: <20260409090945.1542440-1-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: cde5188c-e552-4f05-3f7f-08de9617c75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mmeZqZmyyLcK4IGgWHP57bKT/jycDqhjiZJurt555sk/5InXt03xWe+cIr4WK3CTtdlPoME+gpdFCyXUw+8mRUJFLCfogYGFCyX4c4w/fIAXX+FKMiCWu+0lHLHlK5XAWgwSSLeYQPDf2A9fLjUq2xbw3Uiqab5qjpZlaCuv6gX11yvpaUBPcLh4FicR/pYYPY1Bm2jun6VqYNGCc3Wlz0UPjEwDeCzKunOO6e/oGKc95Aw8xrkzciIfNiCls+O+yzCKsmluwZ6ZqbleLw9SfeCA7GBIGPhKDjDXY4NKYb95vEQHufFeG0Crbb4bRg3sTyMs5tMYBk2VGIhKgAadiZ5QsUl4Xbq2/o3D22RjSLufSiVTY7fPFegwR9LIMSFALtmdUmAUa3EXlU1BHZxLaKp61Ca0o/VQx9+AbZENawheIRPFTz75v/embFR1jWv5s1XpwXX4erYbTuj71FowFMkcsPKX7JlCMVWB/0hhywPCk47WVbk+uKowAenr/rNMCUx4RH55wKsOllrFhnnqnACv0htNHtvdlbd+Gc+ztdud6ueuWodSZJ8cT2M7qn9mUs7PyaA4dvfbt9J3juXnLKYN3I1QBHP9lyrhc/8uZzr1W5cnp1JVwXLPuFnHCDB+zhrjZC2Oo11RUnqjAusCqVqvCUF3JmWLj8MToJJnD+xtF83GidHcM0VOrXpk1ppM2xIQuCkP61J0h/9SbMK5IIh35QkSERgbyPgYWiLXtv904z2Rdb8nr1paUMlSEwk8qoMCYqKvzz9g1/V0OnmVkg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YTCTzllVkxi9PX/5Ubm+8TfdyxcuBoTkiRQgzJoT2eUM5liUhr1IGQZP/tmhbIEGumZMal08YSCxhlaep6ipC8qqGlSoCx3R4/ZS0ys5Uu+MTEYVQWHU0dK0DgOPwFj/9FQFow1FoXE3z9i0x6KdZXUtj5WcOsauUJLeG0GaRmFAhqym/doQNEcMjpCwR3eC7p2HJti1wdEUomQQIbvnC6M4dT6XZGCrs2RYR6hgx7fseCtCt4a3tEN0qVy8Ef+4dGJcSSdo5WMoBZQVxKoTzsFylEeAsppcSzlYn+IqUJtnX7nBszSafTY4yNMU88iTqd+gDsasIe0u1+qeAmKhuLRhvoFNgqr1ZlRyJRSSD0QJQcyIQM7z8V4XRoNQ2Q3pfoOUnzSx+bUBI9w+ZylmpvP8fHtpV3UasW+qbeddtpavAsXH9Or2vfhZedgaRrYZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:10:00.4997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde5188c-e552-4f05-3f7f-08de9617c75f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276902-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C96013C8563
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

GRE is silently dropping packets without updating statistics.

In case of drop, increment rx_dropped counter to provide visibility into
packet loss. For the case where no GRE protocol handler is registered,
use rx_nohandler.

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ipv4/gre_demux.c | 8 ++++++--
 net/ipv4/ip_gre.c    | 1 +
 net/ipv6/ip6_gre.c   | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/gre_demux.c b/net/ipv4/gre_demux.c
index dafd68f3436a..96fd7dc6d82d 100644
--- a/net/ipv4/gre_demux.c
+++ b/net/ipv4/gre_demux.c
@@ -159,14 +159,18 @@ static int gre_rcv(struct sk_buff *skb)
 	rcu_read_lock();
 	proto = rcu_dereference(gre_proto[ver]);
 	if (!proto || !proto->handler)
-		goto drop_unlock;
+		goto drop_nohandler;
 	ret = proto->handler(skb);
 	rcu_read_unlock();
 	return ret;
 
-drop_unlock:
+drop_nohandler:
 	rcu_read_unlock();
+	dev_core_stats_rx_nohandler_inc(skb->dev);
+	kfree_skb(skb);
+	return NET_RX_DROP;
 drop:
+	dev_core_stats_rx_dropped_inc(skb->dev);
 	kfree_skb(skb);
 	return NET_RX_DROP;
 }
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 35f0baa99d40..169e2921a851 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -468,6 +468,7 @@ static int gre_rcv(struct sk_buff *skb)
 out:
 	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
 drop:
+	dev_core_stats_rx_dropped_inc(skb->dev);
 	kfree_skb(skb);
 	return 0;
 }
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index dafcc0dcd77a..63fc8556b475 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -593,6 +593,7 @@ static int gre_rcv(struct sk_buff *skb)
 out:
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH, 0);
 drop:
+	dev_core_stats_rx_dropped_inc(skb->dev);
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.52.0


