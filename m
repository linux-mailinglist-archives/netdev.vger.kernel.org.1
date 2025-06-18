Return-Path: <netdev+bounces-199095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 426E5ADEEA8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AABC1BC0ED1
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A6E2EA73E;
	Wed, 18 Jun 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F/V3IhM6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A22EA736;
	Wed, 18 Jun 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255162; cv=fail; b=l5j25FbRWT2t6mlKxqarwm5jU73kwJ47xmvFlGU4MYoVCNmSVKfqmVT6Ifmsv3aCcxXkwbOMkcI2KMq3RCzYd3XSG/Ct2jpemYVQz798FOyZ5f3mdC+sGlnFg3sBrCiGE9q5Bydy+4e8UIXCARKslT3wjYZdp6REXg7x2kmBjcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255162; c=relaxed/simple;
	bh=sPZdElbPLRaeG5Y7lBtfzkG5ej9JULBEUOpsHuRYVWI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJOgOYF/uxO/bl3uUoZehKTv8Lrp3VLdfH/uOVxsVAmyqzt9runZkxNwIur2Z3Y1Kia0YdxHD7mGjlNvkTm8SQyiFyQNPtn2rR4MESmBwNia3qAWIGRi1q5II5j5nfZTaK7wnhBSsKTEOk15DcXxzn6SM+wsEbF9aWxas3MX3gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F/V3IhM6; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I23mFweakTyafJF/5afJekFYEXSvdznQhQrPl4qi5zrCf9inJsswtFAM8mTPdMwKHWAcke5umpn9/SdRpvaFhOewbu4wkH5QPJ0FrY32Gowpig0fh+uto6XZERuYAhKke9zN5CkgMDO9TnCg38dFNhq8yUq78sdjFqBTG+JWD6yqRN+xGjIbDxkmjrrwIn0udEmnLlSLJEz9ehbSpb+DzTLAXfeoM/kCB5sFvXVxgu/c4dYN/reU/2MYBqx/bG89Z1uWnyCpPr4xrvyfG88HsarCJozWHgawmKr56U7wFy8j+yEYQQxFbPfwLTgmXhzgQq9L5UUJMkfg4+3E/KmYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhAMiHol28i9/q8OrrvPBeROYbGB1XfVHb4LC2ZXYJ4=;
 b=RUumxwnKN1BbBhg1knAXKohTyjJTyMHZ5bG3iBu+DCmY6MvTLZ3a09/9pezfnAd/PMTsP6H0BeeXbknA7/tncxb/m3cugyYjuyjLgpz2n9CLaTzrFa6JtqJwYNutPJaPhjAx7+0F+N4nb5n+gFXcc42qrsDjsfoR0wAFgl5kfc2esK4DkeU/1mgoo+mFoQAquacxCaywcHWpgEk/Pjq1Ep2eVrYgJ/ecSlAX2aJ2rBEPoSH+mqume9Ka3XJ5+ULTwVFnWAb48Zda52pYzsduvGb0WPq4qTlGdI3sPU+EmKFxzMcA92IBWM6BhnazMWloRRy9pNDzdS0mA0vGZ0e6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhAMiHol28i9/q8OrrvPBeROYbGB1XfVHb4LC2ZXYJ4=;
 b=F/V3IhM6H3+qMcqfIdLRGgdn2AUjF6twiNky87rGoyYtpjxk5/20vLtkw2e2+USx6PGq6rvtzJpNKnaCtSc3p8WKipqdwOqlqeAkAVQ0jpRV4IhAbwcvtMmJSWMsenV3kptp+HeouhXTFVCSf6n1euhMPytBuYLZJeHVVAvXJ9G52XBQVMrNAaD/QvNJjmvpd8Y5bTW5ePDk/MsftQX3YRGEOKyYiLbNKttmvdQC1R6MvnMhLjidMOS43egv239BJsVp4497xkh9NT7mTzNPBOZ6+DdFLkv9wjIAk0cH8RK5JNv52419Ei0ygpMiKJ4qjFALk5OJBR0Aq7CQ1iVuaw==
Received: from CH0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::18)
 by CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 13:59:16 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::f3) by CH0P221CA0016.outlook.office365.com
 (2603:10b6:610:11c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Wed,
 18 Jun 2025 13:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 13:59:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Jun
 2025 06:59:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 18 Jun 2025 06:59:08 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 18
 Jun 2025 06:59:08 -0700
From: David Thompson <davthompson@nvidia.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<u.kleine-koenig@baylibre.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>, Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH net v2] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not available
Date: Wed, 18 Jun 2025 13:59:02 +0000
Message-ID: <20250618135902.346-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH2PR12MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 939f9c1c-d24d-4bc3-f024-08ddae705068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ICbLdyXBmUxfn+waWS8N4rnt/U4KJc7cQuLFvkkieedWSBFBypCQqCM+Hq1W?=
 =?us-ascii?Q?NrTsmc+eenKX0+PXg3Md1WrmTUE3JLhYTij5tB2O5kZD+/my+XoDWbQzN4qo?=
 =?us-ascii?Q?G2EZyAC0K+rXTIEhvKxa/O4PBner1wUmnxiLYyohos44xN7nGtlHPMZ0hVaK?=
 =?us-ascii?Q?TgZ/htq9RmgW3PpSSpfcslNV4v0HoZ8vH+uKCjAOzgyU290bS4NgpoDspe01?=
 =?us-ascii?Q?glrSzw+8pJQt0fPPdycS3CEOXPy2PntvdaJmKpHOVchLXBE0t37NeZr813Xy?=
 =?us-ascii?Q?uxPYFIzu8fV+oWu3Onr/8sWDcZW6XqxO+F0xYld+Ebn5rx9FNtO9KpNU6o2J?=
 =?us-ascii?Q?eV5LjH0B3jHdDAIULSpQfb2TujuUMD9U86dyZsIvR39BkFtrQyiy1U/iVDuj?=
 =?us-ascii?Q?H4dYevj2JRlFKPiG0pN8xms2wftnc2pvy+AGB2/cVWlozk9eExD368jr1Ysd?=
 =?us-ascii?Q?l3AvtPfeAzeeV1dw9IPCcsc9TjYJmHvpc+UUf/W7mABk6N2StIq1KasgRyzC?=
 =?us-ascii?Q?uk0PMcmODU4jCfSdz1Pp3d5uji+p6iVdMsdurpGpZuFV+hmYHfi+Sb1j6smM?=
 =?us-ascii?Q?6F2OSRo71yNQv9qWMvX7JMzRi4saP2JMgZNaq66h5NG6ihMaSo70AF5zeh64?=
 =?us-ascii?Q?vJ2hggnMvJAIMjLroq0KvhKdzNQgBOrSxyOsTnxCwyb0M/tZtYOvoyLvlmk9?=
 =?us-ascii?Q?dS9HP4GpSmD0GbGZvigR8AMFoOVkubN/XYnG+IAIllINuLAEyNIAdv9ws04c?=
 =?us-ascii?Q?qYjMHquj6BwrW0BFe08bVev1sp7MjlXD/ErXuu3FO01aSv2VOvpdIXXIICxc?=
 =?us-ascii?Q?ChVaMO68egrMtCFAyTNE+j1jdy0ZgYfbp+KK3bI682gnaulGNxdbLjOtrNC2?=
 =?us-ascii?Q?xMPNb5/COrD69bf6YB+TWA0dXD4G/1KXtdzBfiquwRiRQoJeAU2k6S85FWGl?=
 =?us-ascii?Q?xWRpDH3v2DqgdrHtFdus0yq6Dg6ldUbfLj9mSM80xVx6vmplXJXtDQOYUJCK?=
 =?us-ascii?Q?ocSc2rhw4mkGf08d7bmT3qbTyLcGxwzRkLlnUsfJwmn0QmMRjYYJqXgaxLqn?=
 =?us-ascii?Q?o6QeX3D3d67x/4PHy/us01PZbKbI/Qnz8EcoPwyJrazz2ySuYrUfBP0Kylgm?=
 =?us-ascii?Q?JX73VVNgwqX8jRwQz0z1jlmkTgEsT3CEDgWoNrfGmzAxDQ85+r1gct5NnqS1?=
 =?us-ascii?Q?iIYP95HquhJ6vYjP6GgQo+Oe7adIQLes8/7sbjRbTvEC+CdCZvU4upqmv5cQ?=
 =?us-ascii?Q?Rx7GI10bRsLN1xBidP/IC+RXtIyuGjkRVRRaZNO1Mi1FoszVrctOz9aXDeq4?=
 =?us-ascii?Q?649tB4n0iUJtJDmtfM89MeZ8+HNSLLyF4CrSHRget8MbjKi/7z0n4vXiPp3m?=
 =?us-ascii?Q?CZC0dQaxJxR+Z50mUah4j6fnR0S77Seu3TzVM2WzkBzBp0seO4flX0orhJDe?=
 =?us-ascii?Q?Ze4eg+JFcR4ovIVQmBAifokX0cXy4i9SI5CuOMi8iNh4K7Gr6QubRepJBZZ2?=
 =?us-ascii?Q?jtGqvg1UxYMdWAzZXCuaClCvqlouAUs6j2KK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 13:59:16.3746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939f9c1c-d24d-4bc3-f024-08ddae705068
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460

The message "Error getting PHY irq. Use polling instead"
is emitted when the mlxbf_gige driver is loaded by the
kernel before the associated gpio-mlxbf driver, and thus
the call to get the PHY IRQ fails since it is not yet
available. The driver probe() must return -EPROBE_DEFER
if acpi_dev_gpio_irq_get_by() returns the same.

Fixes: 6c2a6ddca763 ("net: mellanox: mlxbf_gige: Replace non-standard interrupt handling")
Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index fb2e5b844c15..d76d7a945899 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -447,8 +447,10 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	priv->llu_plu_irq = platform_get_irq(pdev, MLXBF_GIGE_LLU_PLU_INTR_IDX);
 
 	phy_irq = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(&pdev->dev), "phy", 0);
-	if (phy_irq < 0) {
-		dev_err(&pdev->dev, "Error getting PHY irq. Use polling instead");
+	if (phy_irq == -EPROBE_DEFER) {
+		err = -EPROBE_DEFER;
+		goto out;
+	} else if (phy_irq < 0) {
 		phy_irq = PHY_POLL;
 	}
 
-- 
2.43.2


