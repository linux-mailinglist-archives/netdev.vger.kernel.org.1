Return-Path: <netdev+bounces-240964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F93C7CE1F
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662B03A9891
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317A42FCBF7;
	Sat, 22 Nov 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jeg7VNUy"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296502F60CB
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763810615; cv=fail; b=ayj8iNo8BjXFizVWxlddimwxkoZucUzDcfLD3BekfgoPZ8yAu3tlU6GFJxdtYejaXep4fHiRtDf4lIWECh42QGJOyRuDKp/woRsz3wY6HpA6zOzMRCBERiHWYygBYgF6eh927uB08d/h34Apz33x9JFuCFGECV77abUE+pxJEzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763810615; c=relaxed/simple;
	bh=s+eCvX/k5qweWekwso/A0aZaAAqYRAsT1GZFxiz9XU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e1da9TNkaNZ9XUHVpCYvIgOFD3+c/0N9Mv4rJwQSEshB5dKnCpjCyT3Q6RKUpyJzygVQrnAUmilfb4zXv2Vw/DmGfr6mazrhazBhtRclHF55qqwgJHcxnpBhJWiT/lmALF3KZ1/CgfGhhMV9jW3+8O/ny6VCZaKDKmgS8DNw9Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jeg7VNUy; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A05yrst76hxLU/q/VDrKQdQ+t9lKPd4HBwuNxnBPBcDCZs5HB98Sm91Jyp8/BKjW2d3u2nXVN6ERaOKBvv1A3T6SovUPrzNOUFA+x0zAfjA7zlHQp17SaHkfuKtpjlPq+VhErivaS1hrkiHBQoV2kbGuoCyrka2CVfXo3xLs+uJYwuXd03MJiF3EwPQ7bwbE1vqTVN2sx9UP7EWWAsdFy5RV1XL9XsFE/Ut8GAWX59XLaR1jlxLX/3yHMVQbX0qascLSUWunDqg7Q12LuV285xYIeZ3MBxJZHlbK8BvJu/IjkMyZlrs6JvzAVL8y1mqAFXp+XFdZniR/IPLx7O8M9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG0RCe4XClyi/etKqLH+hWRipufAmu//6aEYgsK4uZA=;
 b=VacP3e/FxHNM7ymDH9+XVj4Y5WTBLzisw78xKE/bdFo0ONVw6OTfp6a91HBMk6UpRyPStzA/J3gAZsi85ywEmLUfcQQ4hJQtGCJRBW/RXYjYpAn/9Bx4JLzUwZwSLl3cUKI8aHtGKEQeVtvH8rTB3FpvpOEsTyKPKCG3Bb/a39xBJ+i7JyMWqdTNWY4lIqXPBWvhhCw22os/f0uOxXj+C6cTQCXwkFphh/x9dVN6UHIcw2VtG6UXcnvtsIPIya4DTD8+Ld1Qd8iWdMAemp6ZEkuHhcK3YTUOiTf2TP5/3mw1FXt6iJxDrwPGvNzApJxd+yXR9/miONtGibdT0GGOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG0RCe4XClyi/etKqLH+hWRipufAmu//6aEYgsK4uZA=;
 b=Jeg7VNUyykfG+OZFE2FL0aqvm4T882ceM/p9ynkD3Vl7St9QUtBC7B7OaLkPkub7nQBLUc0mfXx0gZQkY1CMy83QpUW3m0VnSLIcFkKekDyH52gXNP7TjbfiQsB3Tc41KL9J3DiPMYugRw1trZGlizNg2WF/zP7wI2jrXMFVajNDsxMEn1g8SOZ7dinSY8cciP/gzCVO/uCG5nxE6qO566WPtRlcdRGhftAfIBRe3C0q2EkjDrTE5ODeT0cgirOwBL/2Jpe8B4PgFRwHIwxZBLyDZcNiTsd0CCwmGAUpUW/NsDNCRRdUpsJhVtORqdU0IKNYF6qePXor50PjbBL04Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8354.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 11:23:26 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 11:23:26 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] net: dsa: use kernel data types for ethtool ops on conduit
Date: Sat, 22 Nov 2025 13:23:10 +0200
Message-Id: <20251122112311.138784-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122112311.138784-1-vladimir.oltean@nxp.com>
References: <20251122112311.138784-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0031.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 6159504b-b8a8-488f-3fc8-08de29b98e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|1800799024|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vImpsAtt7GbNBegf3um6giPIfOUS8P+aJ+PkcJ9pEFx3XhC71bmLTvYmxGXa?=
 =?us-ascii?Q?qZon0MHL7fcdWyHjCUHe/MHeZACeIY1m4rCqLPfjHTrUrv9Z22fw2/rJnU3e?=
 =?us-ascii?Q?obLf9xYh3S7p109yz8PnAJ8cfnRitxRCfJt8rcwciguwMpdr5+DJ+l9r+qYD?=
 =?us-ascii?Q?zJpY2BpEpJvtsMHDoN79pcEZO8kPmK3YOVqNevWEdxeiSvL8+SCeYgza4Jdb?=
 =?us-ascii?Q?VY5I5Ggzdct7AUgz4+ZRpfS8KC2YHQcKIoyt/PdifsUFutH8NEYT7XCRuKmh?=
 =?us-ascii?Q?YQjx2/3wtT9myNCZxxiAz9u4B+iunU5pgGt/4drsBvR8hzxV37gN/Ah80pXp?=
 =?us-ascii?Q?LUIcC9f9AycBBak0liv7ByJqpoTBhj2dC5sv7Vv2sD3+gzFxEV4SzZZPFK2H?=
 =?us-ascii?Q?zFftkHp1oSAOzeK9u21iZ7UmHQIV2MKmGebJSnW2qySXjrDSBGNqy6iiqKyA?=
 =?us-ascii?Q?F9qX+7Zm8B7XvTpCM1jzgI0t0tOQcgXwWTsZkHgj4wdNYcjhhZqS4BqIu6Na?=
 =?us-ascii?Q?2drZUPFo0QEHG8tVRph4B4FtxsJoD4bYnsOa7fyMoQnnke47oLo7U6DliAax?=
 =?us-ascii?Q?Jnmrd4xaAeUYFqzWa4zAp4m4AoGKw1sfPV9fmDhwQ9YebTCgVsQgJymQdtbq?=
 =?us-ascii?Q?9Un0wtT+d7hu6k3tUpIfmJswVChzUdWbX8nb/+LB/ERBSovXiNfn02QsJc2p?=
 =?us-ascii?Q?rMjy2OG1VhlVo8jbO/LWbjrN8FZF3KKl0FEjRwpJWEEGdigyTpJruoB1vayp?=
 =?us-ascii?Q?nkx9EyacBRxBHLZbma48ntImYAc406fbePsYdUW2RZU8ULBwk6L1m04z/yE2?=
 =?us-ascii?Q?hXxi3hnQ8w9X+QpKYbEH+OMukP2kh2hs8gv6y14zjXiVs0rsicX603Y+dObe?=
 =?us-ascii?Q?UjwYJLDSHbwBejFRqhHhbrIRNbfEgLFc754N1aT3Mw03Ub+th9kLQ5XiVos+?=
 =?us-ascii?Q?x3LfHi4+JXBJpCLoisAtoegF8d2bybTAfcav/l5oyMXtaY2Kzd8zJW8GFpRG?=
 =?us-ascii?Q?iKIaNTfGZ5RrX99VbxejvkHe5keVfa8DMMW97EYuT8bYpzkZfQGrhTZG0MYs?=
 =?us-ascii?Q?aHL+Uo9PV4hn4JffQB2NGg72UzqECMudwlpyXdyheQcNhX8I/C68kc2Bqe3U?=
 =?us-ascii?Q?2hZpTNL5E/QG5848qnjqth0a96JxjlqrSCcxzvDGLJX8eP3/aXo6UCsOXGa7?=
 =?us-ascii?Q?INVIeP0sWbvZw8fkt8Cm2vhBjgGcyS3KVGkIELTvtNN2d+cLVGbU2wLRJX3Z?=
 =?us-ascii?Q?SWv4a7ZZojlUl/6D1v2kXYwYAdR7EjLz6OPwdlRWiwObmqmr6DKr4HAxBgVg?=
 =?us-ascii?Q?mzhs88qONVow5v4pikE5MQoD+0rkGExkmghJvlSxoRM2h3oKXeX2ZHXmophB?=
 =?us-ascii?Q?6SBWcGx71S+50u7yAWGRlPuQxKSlwoD1lRFzO8gC/oTHW/9Ub2V6lRyaRaAU?=
 =?us-ascii?Q?mUgAMP4hckkDNFI0Jb2c3nVU5+ttuMV9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(1800799024)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e88tKZ7ONob+VZI1zFX9JL25jCNpk+h/O1t+ztbF02gWlVo/zai0dtWlVrTl?=
 =?us-ascii?Q?jsZFZGCq/izmX8nf/iN/HQjQknKS5TtxcO3al6kDhMqFx2KvJ/FrhiE2VJF8?=
 =?us-ascii?Q?qCau3GyFGXkvVtnB2jB5JFTDvYIt4OJOhdWepAlJkOFN7F8R3YZjZAd5S+xa?=
 =?us-ascii?Q?uk7LfLCx+ZJUkT/lfdjA9JefO1gb1beDWX2oeFZHVOiQZsj6IUV48BTXn5MS?=
 =?us-ascii?Q?+xYg3jrf0+pvnFvQpiBsrhQFAaQGfR2Aioah9G7uskL0kpM45a/Ojp/XLw+1?=
 =?us-ascii?Q?iQ2oVDnUSoiw4YcILgITnOS9DP0HWjWtiBIByCTutvsFY4xmh9o2BxczmdAj?=
 =?us-ascii?Q?UIRrJv8FbW3Bnbs66jc+sDOKSeYM2r5rcKXa30I4uSuQ71U7xLxTWb/EVjD7?=
 =?us-ascii?Q?jr/6YLJ7SOH5k1hpoYEqoFg4s/M8MS6oDyVN7Glc3iC5AHXDBZDrEb8mUeLK?=
 =?us-ascii?Q?nE+B2wqDk94uC1rARz+y6r4lANtX705tzhRGhQqPRsA/TgBx+WZUZHIMMOsC?=
 =?us-ascii?Q?ATZ9aojm1uU1hqedKEIhBbgw6IwjBmNLfxHnV/QoIAkCMx2IG540bzjao2g3?=
 =?us-ascii?Q?brg6+MDcnnTa5qIdZd3XvdxLJxdmw4g3+wT5cSjJIbcFCdjGuLgtMoZuCJR0?=
 =?us-ascii?Q?zZG5gA7x1AoBJ4Rj6bDdRlXwcbA+ztVm3YR9JJx1IMu3uIWwaxxRo9W55Hjb?=
 =?us-ascii?Q?+efJlPTg9IZYUaQLrULqJ2lCnKybQao2neVNru+2MfyuVJfUp7cVr8i36htM?=
 =?us-ascii?Q?RtikibIeBrwDZ++Y51kk2E7n9Z/CPvd1bLNY+4ZekN2AF7EOS5/x/GKFOM84?=
 =?us-ascii?Q?M8od/whkLdPJLEILJFj00GbGi4GJzThJVbCNO4dowc2oOOVUOzV8I0+PRSts?=
 =?us-ascii?Q?OVmL0wUVdKKlM0E+pwWpCXLx2VZVc5HGxqVU4Czcaro2vSfRzlrzYrZgvWaz?=
 =?us-ascii?Q?xTlg9SOyGXzA4Q3Se7LPOwkcRqXY9zVQis0S4nflHRwTVeVe/gmuDYN/kE0D?=
 =?us-ascii?Q?8fMkv3dpW6Bg6rZzW9PaUIr7wCFGISugEFo61/i35FEAMtOJK/iE/gJhiKgs?=
 =?us-ascii?Q?s9f3xmtzkg0Bpx+duHyOWpshUpTir8A1zm5CI+xBc6RlM6Jfi6NldbkiBrdJ?=
 =?us-ascii?Q?62Si5fXJ+ZOvdiDmSw2FlYFyAa6A0zsB0Y9p0eLeQZAkbRmRIBQdebJ4u02I?=
 =?us-ascii?Q?uTrBKPHQdaYPL87ezqdLcYo5JnstomfITJJaY5h/9EoPQWCLnEe+aIpIA/qg?=
 =?us-ascii?Q?9GWtTW4NR1T+yT0htJufJzox7wkMWe/ReMykN4ZW0AE/w/ytu0U7Cxe06h5q?=
 =?us-ascii?Q?UHBgS3mDtx2GpyCOgppMCYfgfNj/EPhvCcOxpuwuxMGnktFMK4ZeqiG3CJuJ?=
 =?us-ascii?Q?BZqxmpXgLiihH/eSDO+ot0DC6Aw9oDuYIoiv9UZ8YhrXBwl0e63HIzdmPSU2?=
 =?us-ascii?Q?XZaJVKFbSyrE2NXizmmxkIYkbfkYRrs7O/lg+G0vvmk0auV3KCJSmp3N2kpg?=
 =?us-ascii?Q?eMchrKvS8GaxYKQutLsoWVM+4Ty0rKLAeJmpoixoq/DUM4hsvlaBFm7ExSpW?=
 =?us-ascii?Q?IzvQAalW/ycmXnpL4Bot59xg0wSTCodfEsRbpQFWJrWNsKuqkZPonrRhJ68W?=
 =?us-ascii?Q?rmmJpYHuHei0MnJ4ZjuKgjQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6159504b-b8a8-488f-3fc8-08de29b98e3d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 11:23:26.7114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 161inZYtjci/9g687fy5gdQsJE/ot6wbmvdD8Q6Tcgf0zK8e2SeOyeZzwY7LMVKu9IgbYLNbuFzQS3X1Tz0dEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8354

Suppress some checkpatch 'CHECK' messages about u8 being preferable over
uint8_t, etc. No functional change.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/conduit.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/dsa/conduit.c b/net/dsa/conduit.c
index f80795b3d046..c210e3129655 100644
--- a/net/dsa/conduit.c
+++ b/net/dsa/conduit.c
@@ -89,7 +89,7 @@ static void dsa_conduit_get_regs(struct net_device *dev,
 
 static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
 					  struct ethtool_stats *stats,
-					  uint64_t *data)
+					  u64 *data)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -110,7 +110,7 @@ static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
 
 static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
 					      struct ethtool_stats *stats,
-					      uint64_t *data)
+					      u64 *data)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -160,8 +160,8 @@ static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 	return count;
 }
 
-static void dsa_conduit_get_strings(struct net_device *dev, uint32_t stringset,
-				    uint8_t *data)
+static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
+				    u8 *data)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -169,8 +169,7 @@ static void dsa_conduit_get_strings(struct net_device *dev, uint32_t stringset,
 	int port = cpu_dp->index;
 	int len = ETH_GSTRING_LEN;
 	int mcount = 0, count, i;
-	uint8_t pfx[4];
-	uint8_t *ndata;
+	u8 pfx[4], *ndata;
 
 	snprintf(pfx, sizeof(pfx), "p%.2d", port);
 	/* We do not want to be NULL-terminated, since this is a prefix */
-- 
2.34.1


