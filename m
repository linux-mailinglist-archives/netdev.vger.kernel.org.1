Return-Path: <netdev+bounces-283559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHg1CBf79mmcawIAu9opvQ
	(envelope-from <netdev+bounces-283559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:36:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C62CD4B4BCE
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93D48300828C
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 07:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131839B484;
	Sun,  3 May 2026 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X63WCVov"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E621CC4F;
	Sun,  3 May 2026 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793799; cv=fail; b=UAv4AFsHnm4GuAoTfLY84TnnC4VaNoIIvC0mkqVsK2jZCoB988QJBSAVY0WR6AjwhG0Dnpkd19AR++V8dSO/M5gN9PherDGD+mO1YTD2EaHC3M//Q2LRVxdEndCUbT7wm1Bg6wg501Jbxwo0LxwNXqDvOkH7zRQS04UAgSMcvZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793799; c=relaxed/simple;
	bh=JL6JIMfGscfi8zA2lgrbnp2T4Z99rfDaI/y3bNsqk08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlDcocDt+vi2HsW11bkgwcaORJt0VBT2ZaLj/czdKNjeJ9yYlXY7niNUps9qMAV2TMXkQ8ixe9+EQYjTgBQhYAg/JvmmKdVkwjDc2ZHJyllNLhhm6o8w2v56rLBR8UjQZWJFr7I7rxjiLhhxNsNnQ7vnG2NmUNgOaHJXwaCcNOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X63WCVov; arc=fail smtp.client-ip=52.101.61.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQRYeUXe8gaTE93twy7s9k+u2dDU7yW6n/ROr/JlkOiQdF07rON2xEhrSeTjLPy+lqi+ylg90sDk9XTy4PffZn3tuZBgCd5t15gMm+SmoEAeCUibgs7L+Gwpswun/3WXrfDyZ+ZKOLvfIop07eyctDXzUn1NkjOguWUfuScWvmq7qPMNmNuMLzp15Ndid6Syq5M4vQ3q7135IYfk9uZi4Qvn/ONaLi7vlpxjhcmRJVE7oMylCpal10CQ+QxcgWTxxTcee46yUAhnHMkuix6yblEkk/bN23+4o81/6Isc974s5IsrpgbhQewBPaHM5Eh7Bg6qD0Hcmm5cLAHwjcIsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J12PKuDpQG+BTi9fnVCl3WUbxi47ISJyEYVAG2YSvI8=;
 b=eTb+WW0MC0avlBr3YOSFO+21l2JNDx2OaHqT7H8+3Ybx4F1p2CaVcT2/MrrTxxiqIX1LiXA0IEgaDCcQ8ZtNsTh3vLqZbsCsn8Fx6LJdZLPvY13ULRB4aPq3xVDgyGigkJkVjQCyZRD7mBPI0jCjtt6E6Ht6dtCCV7wIXMS8Y8LaDP98DwiIEOMIEAW0B/YKUwsg1vwMJo9GMMZ+xskv2N0slDPQLC4jb4AT7jVqqny3KrYgbr7PtaQTdh1VUOLNUQgbIj2PJczDhdpSEIaiMzdzVMQm7L1LIsuMGQW86PepRg3ztCi3Olp2in9Zs7N8mbSb5o2F4Hn32UQbwSEutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J12PKuDpQG+BTi9fnVCl3WUbxi47ISJyEYVAG2YSvI8=;
 b=X63WCVovqeedvMCcPMlNRBKw/NuvGNIDWC4g01Mw3JDNHsJBJkI05muEiBNmCMxsWthMKKVXpKbr8f+2nJLZ6BSdSa0BguaJ6wUr1YW1z5dG6A0jgugvboKOaZJvYDbvubiR8UvfkqYnjeBsxHpaJ0w70Vf4LJ2cSymf2XLSHHNp6hlq794wOdbTeCyW5t0ZboKvMcelh1GMuVV9wlYUWKtO0+dUP2yA/NUF6ChkCYm9EnOi8O45R5Q3Ab3SQVUHwV15qAxywvhcvWv4Xm3ZuFg0+T1HD6XYdkCotKNqWkjDxiPQb6uZVgakw1nZXF0GScCIQngaylvbm1QeD4ZB2w==
Received: from MW4PR04CA0178.namprd04.prod.outlook.com (2603:10b6:303:85::33)
 by DS2PR12MB9589.namprd12.prod.outlook.com (2603:10b6:8:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sun, 3 May
 2026 07:36:27 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:303:85:cafe::12) by MW4PR04CA0178.outlook.office365.com
 (2603:10b6:303:85::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.24 via Frontend Transport; Sun,
 3 May 2026 07:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Sun, 3 May 2026 07:36:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 00:36:12 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 00:36:05 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <donald.hunter@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<razor@blackwall.org>, <idosch@nvidia.com>, <andrew+netdev@lunn.ch>,
	<shuah@kernel.org>, <ast@fiberby.net>, <liuhangbin@gmail.com>,
	<daniel@iogearbox.net>, <aroulin@nvidia.com>, <fmaurer@redhat.com>,
	<sdf.kernel@gmail.com>, <sd@queasysnail.net>, <kees@kernel.org>,
	<nickgarlis@gmail.com>, <amorenoz@redhat.com>, <alasdair@mcwilliam.dev>,
	<johannes.wiesboeck@aisec.fraunhofer.de>, <petrm@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 2/6] bridge: Add internal flags for neigh_forward_grat
Date: Sun, 3 May 2026 10:35:28 +0300
Message-ID: <20260503073532.2138165-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503073532.2138165-1-danieller@nvidia.com>
References: <20260503073532.2138165-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|DS2PR12MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 462ddf72-ff4d-4e3c-bbeb-08dea8e6afb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	b6XcLfqiovdinORbz3P3ALMvqwkfejcaX+aqymrgu4dxt2S2mBV/Oo+aWJlQvKV6ZgOVXHevGqPF2glTiTCKKG9IW77SniQFTydAWykW9Bn6yJYnEoyWVsbXs71tMwb/JbdlKp0Ju1apF5Nzw9mUNnXzXjFT+9ZfPN2FbwduvvdExLjNZat+HBMgsYfnLg71wB7VkG9U1nl978K8y7qzPntvGpq85pMdo/k1aulwu+EsRDlF7vgf5UC7IFNqz1xIjkqcr2O/Xkvp0ynXgSvzPAAKl5bwFd9nfxfnP5uNzxpn9Irj80oXWTnFGJyn512eeZD9vdrvZU8juerfIiDB7AoXrPaN2rB1edYC46sA6er2kdJUK0oqf7phdCwMNHyvXkfs98+UOHpU9rUE/ihMoTGoYT1tuSdiBg2TleUcYo5nCpwjBCli6jJ9nHrT8dQD23l61n8zcdNKZghCODbsm6A0QlW8fHAQ8WaWJ6Qz58S25lUcK+2Yxjnb/pixYmCTtRTfTkqYov1m+YR7aBPHomLD0qEl3sG6SAcioLJcyb796WC+E9r/7qOnBlyqkLbq3aczmcKrCWhX7CzXtwpq60Wql39dorCw5VGP0P7/7vqjlQH9UuRwqfb48OTG+L2QuNl/sHo47jVNrq19YAl+b3mNxwKWciF5PUQNZd1ZXtIEvBhFwioQZA5v/iNcgiJBgZ//AzBxzb8vXX0l8aZxvYpWsK7LhD2NHE7nJJGR3uc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8oKhTsLameKE6En2iUbGBAjScLJXLoUNejsI3O5sD4yEcJ/6i2aYS65M39GAjHDXpi4UyInzwnJdQ4g+UV2eOJdCzS3P/0cZgjPGfWsKiWKbXTgoSL6BvlyPnnn5p+7h2zc2umQRsGUlVxx/yuR4dpW8SG+c0+kzlV/ravolBMsz3AUKp2Lr5PD/T78AQddZ7h47l6HGznRov5wEsqtHBDwbBodQgOrDtjKXTaN6OzVENoMA4ecQtn1woeNoxUQ//i8qFQQSDAdCsu+BQBYGLjyACLPlFBUH2EcmTTt+5S0K4ihK+80JdGaXWK7TMco86vYS7xW7Ntz9aWq4BfOK754HraBL8NdwD8o14oT36RTw0GaJdTKxTjYZj1kg27u9go5iX4ddY9jqy0cb6WxDnjmHar5S4n/LPdoAUUan4z5LyTUa0ybyvFyqYvYD3N8F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 07:36:27.6286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462ddf72-ff4d-4e3c-bbeb-08dea8e6afb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9589
X-Rspamd-Queue-Id: C62CD4B4BCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283559-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

Add internal flags for the neigh_forward_grat feature:

- BR_NEIGH_FORWARD_GRAT: Port-level flag
- BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED: Per-VLAN flag

These will be used to control whether gratuitous ARP and unsolicited NA
packets are forwarded when neighbor suppression is enabled.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/linux/if_bridge.h | 1 +
 net/bridge/br_private.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index c5fe3b2a53e8..ec9ffea1e46e 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -61,6 +61,7 @@ struct br_ip_list {
 #define BR_PORT_LOCKED		BIT(21)
 #define BR_PORT_MAB		BIT(22)
 #define BR_NEIGH_VLAN_SUPPRESS	BIT(23)
+#define BR_NEIGH_FORWARD_GRAT	BIT(24)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 31e317a3529c..677cd5d68dc7 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -187,6 +187,7 @@ enum {
 	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
 	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
 	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
+	BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED = BIT(6),
 };
 
 /**
-- 
2.51.0


