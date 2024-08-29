Return-Path: <netdev+bounces-123049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B079638BB
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94A71F23773
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BAE38DD6;
	Thu, 29 Aug 2024 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="J6Q8aqN0"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2053.outbound.protection.outlook.com [40.107.117.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9031B7F4;
	Thu, 29 Aug 2024 03:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724901570; cv=fail; b=B56Kq+KfSrLaHoWERtHLbXMH23QBQrto2gZ4EQGD8FS0OXp4RkBY9UlA1RpN02sZt9xxm3EaRud2C18BvGjSTz2krtJOa1j+GcqSQ+aiHAfGp6yPYs2+nm4KIAzO5pfHkFhL9d6I0vL1ca4v6+CeaiLjhadPEkQxV0+CeA7m1ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724901570; c=relaxed/simple;
	bh=3sOKQfPu21xu4da2YFpOYnA4x3H8LFgxV2fr/Fe0LF8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kYf4b1V/vwRCwLLEDtDnxXTvEsEmSOfpdnhsYkfg5Na8mWzbUIhq+LDHL3NQFYcLapCWyGPU0zW3GzZZt8yGVBP1ZxSHQ3URnxvYd8NXLWsv4PBWQ9S3t3ljkebrqWPt/W3721Cu9/yprlmB/c0ayZg52+5rQkIzcHXdvtZqFmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=J6Q8aqN0; arc=fail smtp.client-ip=40.107.117.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVsGbm+FJVyIZ7MpgHulqPmjHv1SIGMhapW9LN92aRiB/aarNrMUXJyIGone7gENZcIScIL7KBOGOc8ztkxYtRgR6YyJ/1Zck79ul+1XHwqP31VDoymi/Er79HxwPPBx5SGtMvA5P+OGnr5XWfKWfdWRIBVTPLpXNpZS1gSaJso1g11WeDQQOwucwLpgw4Q4x862HMyKctamU5amoAa+978o/zcLnbI0Xj4lswY3LO8BriW52Oy/m7JFNkxIq29ythkpn+o8qUgdIkzOG1w21FeCAYMTy5S1F+GPaPhQ6DCzNRdokrt9x8mOK77TJhRdP1XhsDF2I+hOuCcq4YxoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkiBpToYSULnQ1jcEw7OLvflE5caJXbxsND2UxGQ3gg=;
 b=mtN8HPDMSB/KzOHbkYOztb3oyKO2iyHSJWRdZq0Ao7eLiSfpic1NSlOOAmPeql3Y1OLA18lOrbT3HCti9Y9SU77y/vfrxnJFv/hN5ee9qP9juvtOgAOMMCbwJiz1qZER74GRersp4cPi4AX5JCb9Qxb1cKFs/bZmYjAKDSb7mt4srLPGsjK+Augl8sw9PUn4V9PH1i41zuPG7Og6vkd2Y28YD2MpVXmXULhWh603J7Ps5FNo2LYmEtKtlhTQcZ3jnORhyjYgX4sknHtlq5oBVHUQaYz09N/bW45/ukARR9v0E1ijTkhv5acb1kuozOAzUTyKWBdk2YHbUiYtJH1YgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkiBpToYSULnQ1jcEw7OLvflE5caJXbxsND2UxGQ3gg=;
 b=J6Q8aqN0wVJu/FtcnSrYr+RuIrpmsnMa4pZAiygmWr21ZNrB1iLovYuA/30EdkGFaTBMZwYr8LzVzi+OysoRH9+QRRxsdBbUgJp4lkaQVx7qESBK2S30Vam6mu/p9hoBmxHs+kpIwLLT7Yu4jsqWP2R3/8MNxkxNP94xZ/odyGQPcfRNjQ4nkKtWx6Wz2U9GZ9JPyXFclIsPZC6OxK3VvL1tjCiuHPIHAp0JVRxutl3/Ki0GCbL+1/bFsllR1sM9GZwKEOxq9sScBTqCkZkw8W/snkUUF1sGb/hBJi94nR0TAxaG+zPYDEzk4NYt2I3lN870bihMNxVZ1Te4MAFM1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB5184.apcprd06.prod.outlook.com (2603:1096:101:89::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 03:19:22 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 03:19:21 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: kuba@kernel.org,
	marcin.s.wojtas@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v2 net-next] ethernet: marvell: Use min macro
Date: Thu, 29 Aug 2024 11:19:06 +0800
Message-Id: <20240829031906.1907025-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2a7875-5bba-41d2-e60f-08dcc7d95ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?atNDWa87ibAxa/b2yngtlg7YArNV5aHYHp/xgEE7QgYSaToZSwAfEgRijUZv?=
 =?us-ascii?Q?ckoKPwqhCXDrpYfHmNtklyzQwrAUKQw3QoQPtDIChKi+cL5Gf5JhkFFQyH06?=
 =?us-ascii?Q?JhFPDs7LApQQmmXMQ5FLjf8E9LQHEe/BO1J7lUPnIk5ROfa24MYxhxfiaEbn?=
 =?us-ascii?Q?2a5WeKkPDw49H3YQKO5rsXbwm1OWLvxJLUUZHKw2PPVpwjq9Vt+z1b8vpiWy?=
 =?us-ascii?Q?lVGqwRJoVheZfB/5+Y0mt+XZecMJPcsyARNuJE/5h4k75P+nnVMgetH6M08G?=
 =?us-ascii?Q?zzezSV3UZG2TGOKaBbvHy9z42It0Zx4z3Juo141o11o8o2+wC54/uG1oPWQA?=
 =?us-ascii?Q?KNI1WHpZBnjPvG/wyKG+QaVefM4LOX651N+71F8kFuskhSSDTPNMqj9zaS7f?=
 =?us-ascii?Q?TmPPp1QzFZ3GBGExjP0xiCVUJRkdho/DmLzxU3843KX2QBoxQ6LbKfmjV/Tq?=
 =?us-ascii?Q?vtDtON85ubm/LtcH44NzsJEyn3QM6TYprZ0qtxiu6c12kJfPQ3EfmVJsIp47?=
 =?us-ascii?Q?XgKuJRCmac2j4yvh+H61IF3zkFOM89uN3OrZ2HnrOdKV6h8ehUipE6Qr7c6B?=
 =?us-ascii?Q?zfIY3kgXib6d0JUUIdTGCaiEA+ZrSY/9scI8ynmR0iLt4OYDIbCDO7vbkjlo?=
 =?us-ascii?Q?8SiRdXFrRptqFuwBoWaHH8L8muz6Aqc6ePtpJNjUR4aUvtijnWh//jdgu2DO?=
 =?us-ascii?Q?/TdGMmkvaHHLA/DHZH3gvQ25j7fG+EIy7EKojQOtkdB4wCf3Q8LeS/6hn4Ny?=
 =?us-ascii?Q?ST0zvqMgJdq0Xsf+3WJLiyCUULaNwy0+k0jANhrK7DFyr0K3jDrCDer3d685?=
 =?us-ascii?Q?DpVMyn85WAzc2RozfjQkN5iuAMTRP2Cwnyi92ljRnGEKjWcqnAcTmaV/hBrn?=
 =?us-ascii?Q?yW0rKcPY4+sAH3cJmum0CiXxJPLX3QL/hQhowvj2ftl6JqCRTktvtN5rWVSr?=
 =?us-ascii?Q?blZETQaRMryngajNgN8x1KbxgXWTfH4iXEyIquMKiInzIru2NRFpMtt1eceh?=
 =?us-ascii?Q?2mU6S7YfRvQgJjb/lq7oNVXDUfh/+Q0NmLboFGicHNgTeVmZiEDIIyTpOpke?=
 =?us-ascii?Q?0WqGq8V3qS5Xh5UjGXihx1s/cJemrUF2+UDx9yCKd6MsoWoP1fFQIqbIty0g?=
 =?us-ascii?Q?IOwSbDGBylp4HSuyPLHkIy4+SRb2I1Nm0gIlPlqb+P5OU5CsFaY0gXrYpOkk?=
 =?us-ascii?Q?t27+8RFZ9dIaGYQQ4FfnYJIasMnfy/UJJ2KXS7WPuk11R+qcFzx60wDdQ0fj?=
 =?us-ascii?Q?c1Thq1Oj5h6h4YTxMoFwQaAul+mt3Ce9MrZkrW2+simuKmEIQMxEC/XeAy6T?=
 =?us-ascii?Q?a6xSQT0iy+zCdddsvd7Qt9pGeGOlGacXpXU8wkktdwuq7MbQxY7NQifxAtmJ?=
 =?us-ascii?Q?aloezdwP7IDSPS3Ep4O0Nc+y0QUjxusz5yfTSseEJvTxTw7syA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nRY2OPc++PPkVMR51NnhmBmzP+0CGibhZB3UmYvFO8IA0kM+BRWu95vH8hzd?=
 =?us-ascii?Q?t8DBAzcTWkZzw3hxs31oq9gMlXRk9Rfr0T0dVAiHVIW4CdK8wcL/SJLlVQTV?=
 =?us-ascii?Q?Zf+7rBLu5yI4My0MOPStxWTzxA9aYigvPYV7ymN4rDD8BKhgKOm+aSiXpWhn?=
 =?us-ascii?Q?aWk2YLY9kOTXpEBzeFwjZlh0uO2fVHSWx868TYPxNifMsOZRcXn/Bfcr2Ass?=
 =?us-ascii?Q?2NRhDh6SOiz+pYA+uo4dmMjUoVe6dQdp4F9BM8yRq7kz4FeqQ3BPpiqWV0OP?=
 =?us-ascii?Q?68FpFH2ernVcDzngzneUXtlrYay8cym8IY1o6hk+XSeROHmHO4ryyrZKm5zd?=
 =?us-ascii?Q?3lB4y+NhmeRdttNiE/oqW3sZx3U09QroKmUSuI9zbdAo9+/5hTyAOhgKh44N?=
 =?us-ascii?Q?xuwxiR2EI/RI3aRZfSqCqnIheWjPMwcU+7Y1RKmnR5TgrJiD4OmpBoK7+3RN?=
 =?us-ascii?Q?7dGfLQ6NVX33gs7EKYSw1o2uvelJvWzoKg0VKp/VokZLTztYnUzBopymLYuE?=
 =?us-ascii?Q?Pahkr62pNtBDgkwlWMO1ff0+G2zdDMDxYQBDmrZ2sEsciT5AfBM7Leet7Zr7?=
 =?us-ascii?Q?EsuEyLuOZCgTjFdCsp+BHiJrjEgw0ks8gQkLUWYM/vSVHXSRPQzKkIrmtyE+?=
 =?us-ascii?Q?HHVC48unLWQYLgfBDkqu53do0X/DCbSI4Uctnc4j49y8ZXUNzs9Q9FMYxtdW?=
 =?us-ascii?Q?EIIyeQvhnlQ5nIghtDk8BafG8B2PfTDPOWDP7uVaAqK0bYi4LIv4dce5vbES?=
 =?us-ascii?Q?QY4Fypn9W0NOKV+JyK72sWXCCpX6v4e/SMOLZEXiylv7+vMN1vrvpQQ2bbtF?=
 =?us-ascii?Q?TSHaHLJlbOWGz59a9yLlhT4aC8Gdt2v0aPrMLskGaPp/N1uD15wwn3JdUYyv?=
 =?us-ascii?Q?Ib0CrscPIqumXQjbH5ZgiPXoydqHQXNoaoEOilPS4YQbyWbYQLHx3ztC2S1H?=
 =?us-ascii?Q?XmE69cCbn8efmTxpYHFpKnQTFviFPqBAalr5ZIBCe5B89FzWAMiI4wa8bu1u?=
 =?us-ascii?Q?5CWR6eh0Cp5sPmXDpDnYnCqy1V9XPJQShKkFeY9HNlSDerI0ZYuXzAtu/6kG?=
 =?us-ascii?Q?DQEZ03sCgVK/RPbuX8+q720L67+Fbe20u2Op614VA59H4RkncC16zHM75c3t?=
 =?us-ascii?Q?54cHHT3vN9886JS+odMgomCN5qyylchASVFTL5PTuwzhN+VPlCq1Nv4f7jHd?=
 =?us-ascii?Q?8GbnFYxBz1iUfoQ6GK1D3GNUA2syjyNGbf6/oeiBPEXG+rM3fOHpmH38NM0O?=
 =?us-ascii?Q?asspj9gLDv/WLjcSLB9RLRILAE3VV1FRzyDT9XZLMm41VHL6pi6jPGqHXIuD?=
 =?us-ascii?Q?63mXbxMCDQ8ALdkU4dUjkgkhIX5Faxoi38PAMUxjrPCorYfHJd6VJ56BQSJt?=
 =?us-ascii?Q?7xz609sPBJYjMKZpqKUQ7U9mnRrkCnxoOZo9pj6Z+7fqsO27/qbvXsy65l59?=
 =?us-ascii?Q?TVx3NTR0WvZXrPQ3gA0cMPXBq7zt4IGIL2X1cFe9josJYj5VA5W1VpGDBl9y?=
 =?us-ascii?Q?LqM10Rci6hnlZ9684zgbnjU5vL59vP/R0b4071t3suPjKdtckCt/tgISN5W9?=
 =?us-ascii?Q?Rts/pXT2y/MiGl3xyVF0NoabhajcRo5Sjfz7G8Zy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2a7875-5bba-41d2-e60f-08dcc7d95ff3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 03:19:21.2996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33op3C4QQ4XygQ2TNPVbqoo3iXFx8I0Dd8gBEMBuJu1RZ3wnsdcec3yfvt1bCsVlsQNAsm+f0wJ6n2STL1I9Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5184

Using the real macro is usually more intuitive and readable,
When the original file is guaranteed to contain the minmax.h header file
and compile correctly.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v2:
- Rewrite the subject.
- Using umin() instead of min().

 drivers/net/ethernet/marvell/mvneta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d72b2d5f96db..08d277165f40 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4750,8 +4750,7 @@ mvneta_ethtool_set_ringparam(struct net_device *dev,
 
 	if ((ring->rx_pending == 0) || (ring->tx_pending == 0))
 		return -EINVAL;
-	pp->rx_ring_size = ring->rx_pending < MVNETA_MAX_RXD ?
-		ring->rx_pending : MVNETA_MAX_RXD;
+	pp->rx_ring_size = umin(ring->rx_pending, MVNETA_MAX_RXD);
 
 	pp->tx_ring_size = clamp_t(u16, ring->tx_pending,
 				   MVNETA_MAX_SKB_DESCS * 2, MVNETA_MAX_TXD);
-- 
2.34.1


