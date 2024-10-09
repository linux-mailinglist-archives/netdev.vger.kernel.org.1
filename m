Return-Path: <netdev+bounces-133446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC7995F07
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BA3281C4D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 05:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849F816DEA9;
	Wed,  9 Oct 2024 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mk16JrQn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800416C850;
	Wed,  9 Oct 2024 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452404; cv=fail; b=uZKR836zry59r0khIxj1SgbggIheeW8dsEeXrgcHzppTR1ztx0DGspMVM8MSx848wkNQcxIjjnpT47U2837qdDBeyJoj9Ggf0xd95vrx3uwjOej5a784d685XGKigSXAJ3BgWAE+bLzP0k67lb/mxy+e2g8epJxMTy7noMiiqb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452404; c=relaxed/simple;
	bh=MF3iA855uyucKBE9OhODxk5OovruTEuClkAPMhwVmeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvfrysbFpP699de87sa79dbiPpiZyNpblTeTDDajSqN9vPa5Ix7ZujqH0COfZeftQjpf5oZ/dFHLnNJqQUW6EBC/toXWGhs0ijfj4WK0LtDdSbORV/tST6AjqYa/tTSyNiSg6Qeo6thYJfRGJN5Qtb4FVTho3ZhoGNZdU4d7uRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mk16JrQn; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWi6tqFNKPmYf0YkcKei91Jlzde9QSoKR2lKDe6ml6NiVZRYJhEDYo8kFHuIFu82o1MNWmdqkUjoyGURx9I3+l3P3GFL6Vv/CEIRg5vZ7bIVxZpah5/j/2KYl/qRZ+PQH8i1w9MRl5AfpwvnEUz6gbInc761u4xDCNRyOt0g5HK9Vhi7Qxt22snXsTjqfEL3sOgMrKKiqZnq9clHowRwQyQo7nXDv+2SWiEWgeVh5BaahAGXKYiVFugvqAsgbDLqCgxZwBr0Xv446rN9MfJnLlAIXWeXXxmXjYOJUmSnr03SOYDo9KNwPOD5tC3C9cFS1/kmI5LqqfaPmiT04QmbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s79FGB00XqpOLvvwhQN0RqzxXXWJvDXXwhdo/8SPzKo=;
 b=Ed4FNR97hIukDvK/Zmksohjn2crEofTtU4rrkGKjpA5VQL5Wf5diOdN/HRRqA6JFAo0UahEUhCix55qSb4odh3NumQoSvNmbVG31wUqjy4mfZY2IhRFmq6wNxg2LczxZwi1VQXMZ9XbYZeFjpwSSqmjfpBUdJ7Tw4DxKXAjAZMj+UKcVPoAzA3Bmhwg2J83zHx+G/aIrvX9XbAexpXu4fwCt+FFliY/ZIczLR7Rh1oJx//k5pJ2b7JNycJNvJeJGo0UazUO1aMpILpw1XF/7dnv3p+yUth4B1iUfAeqVPRXjUOtQVJcaqY+6Nt5Pilk3y6IXOGhn8WZR3UrqYxqdWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s79FGB00XqpOLvvwhQN0RqzxXXWJvDXXwhdo/8SPzKo=;
 b=mk16JrQnCR8MgciVsPIvk+W2msetpgmEadrIsQvNyVQAZbYqWSQk7cnSAtrTkZ3pwzD3YuIi6qmQYnfOh1YwBUgOmZB/RqyMEFHRQ8+BcCg7pEVkdKDKse0V7dQw+rTCaDLkMCQL/8WGd+JJFD4XhJo3EpFiMkLskp7D9KzzTrM=
Received: from BYAPR08CA0015.namprd08.prod.outlook.com (2603:10b6:a03:100::28)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 05:39:59 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:100:cafe::40) by BYAPR08CA0015.outlook.office365.com
 (2603:10b6:a03:100::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 05:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 05:39:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:39:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:39:57 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 00:39:52 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [RFC PATCH net-next 1/5] dt-bindings: net: macb: Add support for versal2 10gbe device
Date: Wed, 9 Oct 2024 11:09:42 +0530
Message-ID: <20241009053946.3198805-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: acac4029-a62d-43d2-3c5e-08dce824d039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6geU5FYTLO3bQ+hkt1FqnVjyMBD0bxz/9LbgncaQYF1psdxK4SO9VA50xfP?=
 =?us-ascii?Q?QyG3ZnMLFMxS1VCq/RZPmOJOJ7ms1UYSF4QrfG97qJqnHUJ16eSC29RuA0FQ?=
 =?us-ascii?Q?QH8v3Gb+AUKu0tH2TiyV+7Qvh6K+CLrDaRMvtaC7sD7JplH2pAr0qzaAQdgD?=
 =?us-ascii?Q?eQiskj9NQ68KpqcpFAk/pg0xjr+c2/ZI/FTJbnHFAOLNaNWr6G19Hg54urc8?=
 =?us-ascii?Q?859fTH88wI79xdrrfmmODCBrAOHowSe6YDgywqh21oBHONbVIsVNeCAN8SxN?=
 =?us-ascii?Q?iYeOXsghnMWEMf+XOkJKI4t6adodM98rAdz2KROYn5INXjKV8903S68yq7OL?=
 =?us-ascii?Q?6zZCsa4oFHkIsmLr/HB1DLaC8Bd9CdlHky5yQtrhkHl4h0yLRaflTy/d4nOU?=
 =?us-ascii?Q?H223eUrkalpEKBXVuc6+dN6ZFLondzRzWt/h+COC7GIwQPDqX3G0ensZU0W8?=
 =?us-ascii?Q?rQvZw7l9T9IowlQMhoIpiR+3lJyxiNPrhArEzb88tbhdzQ0rh32AswLFNZMb?=
 =?us-ascii?Q?UIMSogIgwBtjnxUrAyCvzs3LOuEVhn1JFK3PDpzlkWSZWBsxF1qI/ytt2NyN?=
 =?us-ascii?Q?l3b4cBrLk0YpXbrMPcUtTPv7Y5oxUVX6BFivv6jT+aIlqXgswHd8Pl04TmjP?=
 =?us-ascii?Q?mi518xURNHvUljZvvAv2HA37hgTjO4F0o0qYJ2qtQNxHDAGiIBSQthzEZcxJ?=
 =?us-ascii?Q?Z93f2G5zdiw9NlzICyY1KAOa13wNt8IOve/7YjW6Vx9h/jla8GYuKa7udEx7?=
 =?us-ascii?Q?SuhnXtYbCp4tDszGlOJ7Q7bmbhkmd02Bm9bRVq7x5x5Dgi1zi1M1bDbljfMT?=
 =?us-ascii?Q?nZE0z/CFMCA2Oi7ekCiUyETSBGErxIAVX4EyuqMl81xYtoTaISqOQKd9lRTC?=
 =?us-ascii?Q?mQdGj84W2NGRm3ZUP0Xo8VruhhEUQfeTnHqMI8BaCZLBDJWynTyfKe5jeM5U?=
 =?us-ascii?Q?oyME/x2dfVDwskgvkRJl/L0cY+4h2xdPVnxbYmsMtIOR/mGpUYRQYunJ1FwD?=
 =?us-ascii?Q?WzlpZUoPWPvlokFhBylz390phl+Ko232+1UlDnBulonCCiqu3DLISYFEo5Ii?=
 =?us-ascii?Q?irYoghuFSa75mLxDg7OmOsPyQ0c28fV/5pLjSztsQ4eYa/MaWXnFXZIB23ey?=
 =?us-ascii?Q?rzLE3Vp6QObT8Opk4JkCLTPSprPK78OzgcP4f2EfMqkPoufOfa0Q2WCtBbq0?=
 =?us-ascii?Q?JWYetqJPvU4kXkkxxnZRXPu1XBgNij+N5UvYkdRCCnqW9+n2URoVmi0KWTuC?=
 =?us-ascii?Q?iDdwZkGEVR43wXUgmhOeLhDolemYGzian7ECC59Sj5139pgTWKb3Znh4WSct?=
 =?us-ascii?Q?yR8i2zQvANYRXB44bLPdCQz0qnsC1Y8aYrr7dq9unHvHiNY0ubKEwp4K/miF?=
 =?us-ascii?Q?ZvsueRj7YANFQ+eZkKnTuovb577X?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 05:39:58.8240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acac4029-a62d-43d2-3c5e-08dce824d039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922

10GBE IP is a high speed mac supporting 10G, 5G, 2.5G and 1G speeds.
It has USX pcs for higher speed  and SGMII PCS for low transmission.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 3c30dd23cd4e..3870e4846e8a 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -28,6 +28,7 @@ properties:
       - items:
           - enum:
               - xlnx,versal-gem       # Xilinx Versal
+              - amd,versal2-10gbe     # AMD Versal2 10gbe
               - xlnx,zynq-gem         # Xilinx Zynq-7xxx SoC
               - xlnx,zynqmp-gem       # Xilinx Zynq Ultrascale+ MPSoC
           - const: cdns,gem           # Generic
-- 
2.34.1


