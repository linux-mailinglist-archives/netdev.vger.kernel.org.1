Return-Path: <netdev+bounces-146873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1BE9D65F8
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B9728724C
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97821C9B97;
	Fri, 22 Nov 2024 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ttDhO/l3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26B1C5799;
	Fri, 22 Nov 2024 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315728; cv=fail; b=raGoAVPRtJf/fYgVkV3RqMwoh/C8rDQmjwvJOfXQiZtYea8EPEEOitleP7Hoe5GvnW2nu1fghMUxEPP6taozaKonXMoREjc9dSYUNkAYS3XKT/X0YQtlNW/auBpB1Oyz9cX2WRA3He5tlBK+09XX014MP9WE+5GJjsaGRIektOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315728; c=relaxed/simple;
	bh=HoIXbpe7e4nO0TcvtXW2IJwsZQK+68hrLtLxiuTWbXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l0f+v7Q/29bdUgtel5j6+WcSQAYy/4j66TcpAewlDWAwIimzAJByLgdqmKka/dpwHH8ERpIo+wQXLYyh2Jvyig9vmOX5k5d5A0++7iG9MlvsJEayc+Ys3DU5FGun7mqaDavEPi7bmDq/zCVyMquHKUhpN5wZefoDeoOmMmxeM7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ttDhO/l3; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oweETcfgS/xCQIQzqma3GLc2TMe1O5S5q+wDzJ6O+xYffcLuo43REL7A1/jlUwy9jzcwWN5Pt0z0PGxUEPiMlTAUd61lRTUbw9UcKGH601xpRB6rERZ6yjRaGh/TJ/Qpuv5jpq7rxUZxHVygaOwhBH2vkJXyir1T9cMAX0L/LrBy1hY7MNF6ZfG9QEJln75UwXzaD7g6YzCAeZbTPBkkvPtF68/bR1p3Qzy+ty4icT3yIG24mCiB8ZoU8m9I3RYG8kEkK1y4iydLVKsB1wuo++YrXwf533Kd34MF6h6GRnm32u0i/TevBjX+YqJOY01K2iXVr2w6FQ81VvCTwxJ27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtASgMeRQUdCifxgl0zOeGMZ/GNMN5RUEROpIuYC1SI=;
 b=h1/AdxiSpGYQZUKAMhsjS8UUHTN3sHAxTwDEZdOwrkTwgrP50uNEAR4uUJhAq4f3V/7zKJXhXitHOnm7rWxhBO4reBR3YEbJyviZPJkdQZoX42z/+SEem/CzXcGOveEt2uHqaG1MNT1s5wlnhEl+bQ2WXKHvWrfdfMAdF3bDd5Dbx3karcKxF3dxajAHQeu/eG/QHf8LYPMyu0izmnuCLHs2uhL6cdjIWAD1vDEQkwoBTSOl9lGHfiU3Al6olqaySgnWW8EQHq8H2JxTswiBYLWZc/9nbDKbmiu/CBUV0uRaaLqe6M7HSAIMaQ8xDobUOTWvW27/lEHoDOl5NbWrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtASgMeRQUdCifxgl0zOeGMZ/GNMN5RUEROpIuYC1SI=;
 b=ttDhO/l3ChbTzsYcPGqCLjpP1Stj7cfeRWDw7NT8ITMjOONJmK6JCcXNKSmnYZJQg63cJ4vT4Losnx09qkXBuiZBlO9crYCTOGEaViRChMmvASQM9HWzWkp41RrLy0oKHoBklr/pMUEmvkeVvqGZ5Zibu4oOjjl88z71q6NIqG37PnYjiUM6Hasi6VhxCqPHmx5hjhaF/7YGuzwERDs6/MpxIPNy3P8p5wUlK00pAFZr3+yQyOZxzdORYCVVYDJ/5Wg86tQNSGEQ4dgsp6Df8EvWgULZduQrkZ/N6Hv+VFrnBr/mYK3GqHQM5BU2hn/Kn6SSKuoxse/k9t9/jpOfNQ==
Received: from CH0PR03CA0423.namprd03.prod.outlook.com (2603:10b6:610:10e::6)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 22:48:42 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::a4) by CH0PR03CA0423.outlook.office365.com
 (2603:10b6:610:10e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Fri, 22 Nov 2024 22:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 22:48:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 22 Nov
 2024 14:48:31 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 22 Nov
 2024 14:48:30 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 22 Nov
 2024 14:48:30 -0800
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO degradation bug
Date: Fri, 22 Nov 2024 22:48:27 +0000
Message-ID: <20241122224829.457786-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 27253810-e986-4df3-b85b-08dd0b47d06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TlVczYtPijN6PqENmtCmA6pTRLYdEzV2azuPe0iQvHJLnsFdZt3ZFnAgwLE7?=
 =?us-ascii?Q?eX8giqr759WsjCWJKL3spM16ALMkcA/ghEy1WSumdsC+P9vmIFS/l+b2u/Wf?=
 =?us-ascii?Q?4oSpQAL5a0BI5WFw11TrNa1wOrQVwhgZpdY0ZGcYgJ+vAtMBVNjs4w4qP3e/?=
 =?us-ascii?Q?K02Zk9Iw4T7byhOFO9s76Bz8U3czotcsbyHsuaQ8U4u2s5R3+U9yUke16RxM?=
 =?us-ascii?Q?ykiNEbnnvEZQ/7LQrGPs2Wm5arKPncSXn/1KYKJj1uort9xWc7I7lpEWgcaH?=
 =?us-ascii?Q?APLEL6HE7xJYpL0FxHKS+jyUI/WGpBV6Ki8RblJ/ghUoD/8P1c7rMdsELn3F?=
 =?us-ascii?Q?ca8HGiQnVPRwcmyjLVlusv9MG9t2XCjK87i/adtukDMiUmFM9KTCHeGvZjOE?=
 =?us-ascii?Q?9l4hiTxMiy/o2r8mmwTxKXRPSGOCKp1dRfQnJrM5UEuXArgu9cCfig7MEfX/?=
 =?us-ascii?Q?d86yb48IeQ5UBoCKFrk4mpLZrUeZXckU9mFyXAL5A20OqBw+WHZy297KtOmI?=
 =?us-ascii?Q?Yg5fIPxJOa2uOv6p5HmhiTphv5zRU5vkqMWFeTwKOoZRsEAkGfIyLeZCqpIv?=
 =?us-ascii?Q?VwWSSSfiFHJVauxJGJ2+9qqvdVTqHD4bUBER70pIxoX/fm/ltY1Z2+KICrxH?=
 =?us-ascii?Q?lvukksfXnDm+CsPlGaoNq0CEu4m2FOVwHdPOpsqC8vqYtJrbYHKtaYOFn8TP?=
 =?us-ascii?Q?h6hTJQNIYBuL0vfIHCLQCJiyTfOTdka6rtauRfZGHo+IMfCaSfp8nk3qd10U?=
 =?us-ascii?Q?hpoII7XQQ08j8lF3XMhMtmiSr5Vuan3NQNLFuRtDoLPHymXQueSTa0KGUxaR?=
 =?us-ascii?Q?A8GJaOWshuEYVoMuHtblqqIs8x8qWR8oSJW4G1egArwTZfY1YOeOFZPLsoA9?=
 =?us-ascii?Q?Zq1BSc2vfQnA8OTSCcfXdGxqlDvoa7DBjeYtGW8C7QRM8dhI//7Scul85dfM?=
 =?us-ascii?Q?/52Ak+Sx6vdnI/StOndrF/EKKeH8svh10Tw58xj7KsdbPYq5JJSgqP6dRtBb?=
 =?us-ascii?Q?lHTMMc8zs07x0R40jNqaKcZpkkW+BR4ZHL8lAaqw/T4ckP7eO58yE//sJAAj?=
 =?us-ascii?Q?GXAshTUE925GzD3tDqqV1kTN8ewefdFSTa/R4MsctJRs1SJ1mFNGS7k8ziK5?=
 =?us-ascii?Q?cbyj7jZT30TiVXm8FvEsi2yERNR4CLrqfgIqFbkvVNwsiREbyeAdMupH1HY8?=
 =?us-ascii?Q?DD/InnvF1Q0MnZC53VS4H7cUF+Jvw8NWGiskWXurSxn0kwG/S3+ioNeTlYOJ?=
 =?us-ascii?Q?Ok4EN+wN3DP2vQbbm+wFlF269oOOnWup4m6c8ZgpuFpuIcztgv8VVtgRrmbt?=
 =?us-ascii?Q?NpXzhuW4d4hECOf6Q7UzFeGNa7Q7eh/FvXa6UTJZEcxhZe11F+UcS4KN36rh?=
 =?us-ascii?Q?3x7ROjhtnq/DtDBTOg3Kw3g7hOukSLqD2MF8fWyjLk0b8n6p3/hb6qcsqDY8?=
 =?us-ascii?Q?9n2Qu2ofCj7aQ6P2bVkjp8LM+GcQd8VQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 22:48:42.2194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27253810-e986-4df3-b85b-08dd0b47d06d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263

From: asmaa <asmaa@nvidia.com>

Once the BlueField-3 MDIO clock is enabled by software, it is expected
and intended for it to keep toggling. BlueField-3 has a hardware GPIO bug
where constant toggling at "high frequencies" will lead to GPIO
degradation.

The workaround suggested by the hardware team is to lower down the clock
frequency. That will increase the "life expectation" of the GPIO.
The lowest possible frequency we can achieve is 1.09Mhz by setting
mdio_period = 0xFF.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_mdio.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_mdio.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_mdio.c
index 654190263535..d6dd36ab599e 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_mdio.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_mdio.c
@@ -96,6 +96,7 @@ static struct mlxbf_gige_mdio_gw mlxbf_gige_mdio_gw_t[] = {
 #define MLXBF_GIGE_MDIO_FREQ_REFERENCE 156250000ULL
 #define MLXBF_GIGE_MDIO_COREPLL_CONST  16384ULL
 #define MLXBF_GIGE_MDC_CLK_NS          400
+#define MLXBF_GIGE_BF3_MDIO_PERIOD     0xFF
 #define MLXBF_GIGE_MDIO_PLL_I1CLK_REG1 0x4
 #define MLXBF_GIGE_MDIO_PLL_I1CLK_REG2 0x8
 #define MLXBF_GIGE_MDIO_CORE_F_SHIFT   0
@@ -178,9 +179,16 @@ static u8 mdio_period_map(struct mlxbf_gige *priv)
 	u8 mdio_period;
 	u64 i1clk;
 
-	i1clk = calculate_i1clk(priv);
-
-	mdio_period = div_u64((MLXBF_GIGE_MDC_CLK_NS >> 1) * i1clk, 1000000000) - 1;
+	/* The MDIO clock frequency need to be set as low as possible to avoid
+	 * a BF3 hardware GPIO degradation. The lowest frequency can be achieved
+	 * by setting MdioPeriod = 0xFF.
+	 */
+	if (priv->hw_version == MLXBF_GIGE_VERSION_BF3) {
+		mdio_period = MLXBF_GIGE_BF3_MDIO_PERIOD;
+	} else {
+		i1clk = calculate_i1clk(priv);
+		mdio_period = div_u64((MLXBF_GIGE_MDC_CLK_NS >> 1) * i1clk, 1000000000) - 1;
+	}
 
 	return mdio_period;
 }
-- 
2.47.0


