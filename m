Return-Path: <netdev+bounces-136656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1199A29B2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E02A282A8B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B97A1E049D;
	Thu, 17 Oct 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/C4meqX"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E71E009F;
	Thu, 17 Oct 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183978; cv=fail; b=CABe+M1jGH2azNg8S1CgePpFaxW9l2Tx4AQvSwS4aSKUMQkMkvLQEz6x8sc/8eBOXml0ZPnGn+RZ+SGj5QXRsSroiCXD3Bxdn3LNKMLqdCuaYnli6/FjhDqjICYiqXnZ40ziLzgu1BgQMS65nmBBAlFHAKSLlV6m9lKnbNHMnI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183978; c=relaxed/simple;
	bh=31tmF4kLJbhHgaJRvm0DZziFfsCarFaJXWweS8OS9fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTwoOFKorXgS7qMh5Vr0l8SPLbJV1y5gi0moT+ugjlpWotQYG71TJtUVI0bbtxKN/0TjwLHKJt70EQueV73ZADf57nCWqqeLR1drWPVdfiQYvFA3PvjJ3pIMCFcQzc4QyY1zTeTxXmu1/drTUowGNOJH4JdGnnH+yjbzyN7HXzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/C4meqX; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH85WQUdtvLwMKCGiX5FJ+5zwhYuihmYY7Vhchc24zq3KhzJNNG4DnQvnelfroAKxr7OmxHCDrFPRxVadr3Sts3UsBIzy7DXItUh3CQ6f8xmsI2pjHCjOOMZTT+PIjwWNyrTyJ1LCyi7fPIiikL7akSqsJsdU3xmIYa2ZhBXfhkwkK01yGt5SbbjFiS+2uARBi/JqzAOUPMdYDJTyo04pHo83NRw5QWvBvgTY6pee5YkO+jGIbeiaWO6wwTbHI/dNhF48ynLHINr/5Oa8FV4enVHYC+89OUp5ldd/VIEBHQubfKCmuME5OLs5Y+mKn7089ISsO+5Od2ve723uA/9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rqz/vP4IrFr2mLRViP7hbPritajETwABJJiZ/78zPrk=;
 b=T/t4CCLqLjpVRX34jB2xDtmsUoo9mbxL858KetIc6YMGsU+T2XmnEotd+puRXDT41/mpyGxNg+CQsc0TffpypWOKe1fRp371DOC3trLp9fS6HqgRs3PWHSHbir1GaZUIcDzyjaknb9vOqYku/qJIogJDIy6BrRk0ogpdhwuZfOuwIBHBTM9jeLoSsuOL8WuBoKmxQIZbXm58b0ebgJxZtXb//BQAoir7UlyHbzQGudvlj6J0+07mjWdCq1ie3lThCK6CkM/83Ck9v/JHdwcrv9p1vXMDOp1ihduUjBEz4omy9FDZsFY4ode38gDP524XLWiaGJeHTlr5bhGd+OAYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rqz/vP4IrFr2mLRViP7hbPritajETwABJJiZ/78zPrk=;
 b=W/C4meqXUWCtpzAkcKZlIIllSACYHBXc7cQJQaLuCp7CuDiGNSTNeIyNfLnXb5BIocviHT5Qn8c+GsyM4YZobmKHIrJUGcytgUHo/rFMXi+gD3gglvXf5IJo0nDz93RiBg1lE0aCCl2z7zA/2ltSIMtNiqQ8ZL7AwVvjTcq6CNrHgwMAMQPrNMZ8O53Cf1TGIdKhix1FdOgm58GqUa8zRQUZxRJE5/d6TzmtoVvt6+pCKHyYxPy7cFkk3WQstpe/4paG8bKtG5FRTNuNWzkuSI6e7UURowKNYNq5+bLm3A1/RsLHEUnZ6VNqiWPsGhieCjKFpbP59tDLuE1scYxYSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 16:52:44 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:52:43 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 2/6] net: dsa: clean up dsa_user_add_cls_matchall()
Date: Thu, 17 Oct 2024 19:52:11 +0300
Message-ID: <20241017165215.3709000-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
References: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0259.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef1db57-3ff4-4d0d-faa4-08dceecc1ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3xDsgLo/Ibsie2Z/3+YS1t+oqw1CTf4Bhj32sF8TlyJI3WBd5UBlhmkImD0o?=
 =?us-ascii?Q?DU6L8SoQsv8s2Z4mGqz1CqomSjQhl/6D/1qTtiYLEgJrq8VNZa7T62I+bUl8?=
 =?us-ascii?Q?2EP3dw3m4zfnke6cBRG360wMMUwu+6KtIq79Yqcpf8MpEbLzKLJlMal1uVBc?=
 =?us-ascii?Q?v5E6np8KO37DlBPZVkfM/VgIeMw5p37KlP+TNMEehJBMDLpSyIo6kN+74VZi?=
 =?us-ascii?Q?I7p3T2nyjCm2bRUTJKno6TvJ5C+BeBZJH2r4FcXCl4yLon1mT3jH+BCzsSk5?=
 =?us-ascii?Q?PgbM1cM2rurZAFGcMHa7c4WqngTcLtQrem3r54YWnpF9SiZL0MkEpRsl+zxX?=
 =?us-ascii?Q?SMbCgjKK82TE8cUh5sj3Qii/UWQAYUaGeMk48ruayElSbEH/thC6T1QuZP1d?=
 =?us-ascii?Q?/Coj0jIqXnUtkPW7EvD+hiFBlv76jK+L8XBw4NCrwUhZZPiNu/8zaoi2eZ2X?=
 =?us-ascii?Q?HqconhY4fqoZbXeBlTXDr87Sbv2UgNhe1FgdAm7GAR2oWdPTx6yBhJuvGz8E?=
 =?us-ascii?Q?W8r/iV+fEOIysAOaRCR8wxKia/8jOlfkiV4h7sjL9g0SRX7qfh+gRRdj2gxr?=
 =?us-ascii?Q?4gRYHjjyHXnHkoa8v89aTyd2sTPk7FkFnUeBAXkAiCF87UgZQcV4F4cMqRyz?=
 =?us-ascii?Q?MeKA2cp0fHfS637uPGOoESpb8LZ4FAQEIbMd4o4RAea9lrqfilLHbsfq/SwP?=
 =?us-ascii?Q?iRKy59qYKFZM/bTqloqAUJQD4NwLzpHx73+tFSpXJYYHNuuCcYI44vFSjwcW?=
 =?us-ascii?Q?tt/vRdnK3suCtp51IRknxNS1SPYzvcvaVN0R8HXR8o37J/STqPCz4WqL7f92?=
 =?us-ascii?Q?6rfH8FSAoNqmv5nurZoFvdKFPIV+snLQPYC4u5g6fmMnr56qivfmNOKLJT0I?=
 =?us-ascii?Q?zwCajrhHUTtIHqm7CpTAPA4JaFtFEaBJvh7BaGoQu2mwXPJlgUzYXUxZW9+r?=
 =?us-ascii?Q?CLXdjfTFxvNH+d9w9pHSSIokBk07ub/82+ieTeIA0Z6DiK02JM3UaSaCB5jG?=
 =?us-ascii?Q?fy3xgl9GameQkgtEdULKBKJ9g29RUagPUPyeKTnlS70Bc2Ugn45gflfNWEfd?=
 =?us-ascii?Q?A203Z2JkI/9UAmU7UGJzQQkO2/9To+hnAJvD44unw6GKqhy1mrP7noXc0myi?=
 =?us-ascii?Q?Or99myhFwedTvVR9MDzAsHQny9JeZ2vQfWAi7CouLzsA2T9eo7Y+G5NgFWBq?=
 =?us-ascii?Q?3du+AFVLaB1UbKxPN4w0shI6KLbM51fr3mhTvTKIHZoHb+LwE9BKrw/R7wpN?=
 =?us-ascii?Q?SglxMGSfCRA6fweylYyNnubpI5T1Am20kprUcx1uK+NYgnWihcHk/L8CPyHj?=
 =?us-ascii?Q?YWhnWtqjAEGIv9VDLXwEvRoWuObYNVsrpnZFBCnQAI7ZraVPaN21prqdRDAB?=
 =?us-ascii?Q?Hn0d0w8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FHIvQWrXYpvTt6xWWzVQ0sS4vA1zZJeFfReHSMu36+CxLGAV745gp89Ubqed?=
 =?us-ascii?Q?cw7EWR/9phrL7SyrFSMxdDruMpyKjUg8OQYZqhQvwBeyq85nWSgB1VFb54AR?=
 =?us-ascii?Q?gMPJbU8wINeIhe3aKNOycpdSLfPwHuqynumgLwXjtuUiUt8yIUIGPd38kbht?=
 =?us-ascii?Q?Hb6hrb5vMn1q49t1ofMh7ZuGjUCr7V3FKJo50JAAtFEpfenN9D8setjCL0yO?=
 =?us-ascii?Q?o7iyIPx32+tA7hpkj5BKNjZiGclkdjBGazXgvGt+RxE+ghJ0zSiMOEBn4DMw?=
 =?us-ascii?Q?tJO7+XYWDY4J1vqOGJ76mGGPvGxfIjLzugXmK8A2PjvyUlu/FpLmINEqCigw?=
 =?us-ascii?Q?ofHtM+630aiktSnaZd670tVPFSB2BT7pxyh7TeS8ClSJEbQDLJ686KhPcHmE?=
 =?us-ascii?Q?5USwr88p/xDP2NzkKF9p6S3fPYgfHTLTuNcoOVJrYtUInU7BGUQ+M+03ceCZ?=
 =?us-ascii?Q?XpFPNDz/tdIOYcrRg4Fw95Jx1KqM0fgMPmhXhQsAGlPtokQYHb3FQi9/NkmD?=
 =?us-ascii?Q?ful8/7dftgsp2G4VEBTfbBQdBK9pJCPMOC9AfuKhkTb30EfYsunjxjYW8NZK?=
 =?us-ascii?Q?bzeHZ+Ptjrwx9KJm7FO8xk6RPTc9CiyeG+UiqOXxIE12i8tfyop4+V4fxIhG?=
 =?us-ascii?Q?YMSx2lZ7CLx7FMwcKUzzLCer1I8YzhBR5qcUNeG7aS/RW7rHMlvblaAeubv7?=
 =?us-ascii?Q?wcY+rYSrJXiWgXzgbi7/MLddEOwIAbUapC287Y69gRavLWUeOSXmLZoH55qx?=
 =?us-ascii?Q?nbWbFnJEozfDpgvPhECQm8/ysj8Mfx4cYWVXSEzx/MQ9Yb3gdPW8IZdwfMZ9?=
 =?us-ascii?Q?h4p6cXdZUaJwqWfR2F1dAjVUBglzAwx3hAwzG/KLBTwfEZoMVUef/N/4V7jg?=
 =?us-ascii?Q?Fo8evobXnHNDiBQWSZgCJA0eiIxcYoE1OZF2KCKqDYiIPPTjE+5v2bCjIL5M?=
 =?us-ascii?Q?r0s7NMgNP07lPjRHgJ71ciE4L4yxM87xtSHD2wSb1xmWPgD52sw1Iz/yDPCm?=
 =?us-ascii?Q?LYocc2L0vuEijTrO//k7hYPFY9hExeesfslZA2nYYn1my+MnTFm7my0T726s?=
 =?us-ascii?Q?oFh7cvZVVmobLbk5awVUM5gXufRHuTcFXHzeUUwnR1Rx9tHgxEXcfNNco5dI?=
 =?us-ascii?Q?YMJ6HYgmRuHgDvAxjoJO42TD3+s7fpmfEJaDN5gPIZTsN1hWqF2bbNRVPy1s?=
 =?us-ascii?Q?aG3kYlnHApe3IR1Du1QdgJpUpeADMetqr7xOQhTMsxqTCpTcrbx9LgyFa7Dq?=
 =?us-ascii?Q?efjtU+gYMkE9PBUifOAaWUqcWI2wAJbYWAVi6S7xMlJNBbp7ak2FfajL7s4Q?=
 =?us-ascii?Q?pfc0FAXz7DIboTdit7PKZSbB9fs+Kn9Nt38P0w+1Bvb5mjzduqHsGytqBBhM?=
 =?us-ascii?Q?586RQm0ywI5kr715a2ad6vus9bKzKnyrXYaxfgaWybvc+OUnniv+QpFcCNqs?=
 =?us-ascii?Q?ay5pYfanPbaAsTBYLxiuBr1zPd1cpot58o3vovebrf2asG5yGS5L8XUSp8PV?=
 =?us-ascii?Q?g5nC9LH5ZNOytyJmZX8KwrUnqvyX39k+6iGzh+u99N79j8S2Ghi0QyhFSrws?=
 =?us-ascii?Q?QXxxYo4aEXgUaMuwlmFOucxZoYR9nMIn34qYz2tGBhGhkpEAIBdnGfQJTeiw?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef1db57-3ff4-4d0d-faa4-08dceecc1ed6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:52:43.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBZiSVWzHQJUQFa/i/xMeY8CiF/WkFsxg2Uyq8idhVdycmH4ZZdnupHHm868nzHPNShd+KTMlIWzFe/PPnb8kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

The body is a bit hard to read, hard to extend, and has duplicated
conditions.

Clean up the "if (many conditions) else if (many conditions, some
of them repeated)" pattern by:

- Moving the repeated conditions out
- Replacing the repeated tests for the same variable with a switch/case
- Moving the protocol check inside the dsa_user_add_cls_matchall_mirred()
  function call.

This is pure refactoring, no logic has been changed, though some tests
were reordered. The order does not matter - they are independent things
to be tested for.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: add some more info in commit message

 net/dsa/user.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 64f660d2334b..5d78a881ddc2 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1377,6 +1377,9 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	struct dsa_port *to_dp;
 	int err;
 
+	if (cls->common.protocol != htons(ETH_P_ALL))
+		return -EOPNOTSUPP;
+
 	if (!ds->ops->port_mirror_add)
 		return -EOPNOTSUPP;
 
@@ -1486,17 +1489,21 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 				     struct tc_cls_matchall_offload *cls,
 				     bool ingress)
 {
-	int err = -EOPNOTSUPP;
+	const struct flow_action *action = &cls->rule->action;
 
-	if (cls->common.protocol == htons(ETH_P_ALL) &&
-	    flow_offload_has_one_action(&cls->rule->action) &&
-	    cls->rule->action.entries[0].id == FLOW_ACTION_MIRRED)
-		err = dsa_user_add_cls_matchall_mirred(dev, cls, ingress);
-	else if (flow_offload_has_one_action(&cls->rule->action) &&
-		 cls->rule->action.entries[0].id == FLOW_ACTION_POLICE)
-		err = dsa_user_add_cls_matchall_police(dev, cls, ingress);
+	if (!flow_offload_has_one_action(action))
+		return -EOPNOTSUPP;
 
-	return err;
+	switch (action->entries[0].id) {
+	case FLOW_ACTION_MIRRED:
+		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress);
+	case FLOW_ACTION_POLICE:
+		return dsa_user_add_cls_matchall_police(dev, cls, ingress);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
 }
 
 static void dsa_user_del_cls_matchall(struct net_device *dev,
-- 
2.43.0


