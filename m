Return-Path: <netdev+bounces-102156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332ED901A47
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF93B281B4B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 05:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0187125DE;
	Mon, 10 Jun 2024 05:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oXzwbyNf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254DF25624;
	Mon, 10 Jun 2024 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998011; cv=fail; b=n/791sC71ZR/QDm4UuKQtp4fquJVB+EayqRc6AjNjM+dVfBvV9q6gdGOy8YOvJoYD/0W73bRyCKqaeYEKs8TS46RAz0h7135p3TxNLw4Xzt9noHbSzHku5nNAe7YiEhMpPAsryPMyKYoFBwkO1kiXrUShh1sJwJvjjDhX0ny46I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998011; c=relaxed/simple;
	bh=rv1HkEVwmSbXx/GKTMDAvGBjaI7QlzYIntakiKfD6Mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVLX289kbDymVXrZT1ggd/7CfFwPPA1JtqBWCpEHQFJH9SA84FXlbLeC49qubywLiZva2Y4CqRPhZOXqWS9xn2yk2LOpdSwcI2PhCcPaLleRmdTAnVuJL48dYNg6tsfD6sa7piqfpeaCCtHFeiCVTQYn641MmZLWcdsCm3Smht4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oXzwbyNf; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro0d/qUHlLYyBSzbjWKXOjazteKAoJ0crwlruQ4NdG/IkNxhM8su1I2NMd4f5e+yEblIZcAee02CQNzEbdA07hkmxh/XmaRhk+Z0FwjoNr29JmXaQP75LytAs6bH2KjCjWyLZb5+N/xzNBuLfNL0UPUhpOk6OSKy/3ku91OrCJGCxVsJl7rNlgdozVvQujB8imNhTPc1/l27lkvrEQtoMkKUB6s4kDhgyxWJiuE8lOI0ooIGssVEnHcMqYDtkU6+80ESzP7ce55V4ANK0Qwm41LWU4/MnNPhTaLywJLb+qDfG8XoYPcVW6AoHF8PUx8tvwp3iHfVGm+3uitKvownyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJLCKp3k6CCREhzfteb/jFBtqzIvVXMti4yIf4496WY=;
 b=FcfCsbZ4KEFT2TmweiKB7aclo9kjVMf+gQekqC2FgLEwpF4EteKWpWqHjc0JHasEgNe9BZwDv9PtGA4NwEr5bXPvfCS9NCBoLQ1m1B/1ZvVdiEU5tL6Hx3qqVIvKuK/qTPgZxatZKhh+wJbOUs5W2NIKFqpNXnJGveU/trlh/XqYG4SE646PM/G9RxW6IxQfaEcrwFlSnnnxFlwH7W8SgtPm4lxO9Zqd4YNlWqOHWDxeR7CWFWi6MOEt/WiORfop/BESNw4obC23X5YoMwlptpxFnbg2nRPNpJYY9TQ0tbN8dX3YDWkVTi10eT373FnkvqPUFfSBD2gLNAbBfM2/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJLCKp3k6CCREhzfteb/jFBtqzIvVXMti4yIf4496WY=;
 b=oXzwbyNfG1FCTc3oHwMHI1HVb6ZNGxJnM3NXYRrKMX0w4yY+q/oSF7Gnx7OIKV69aWQlNw5gRgMuouCqwUdeTe1k547pgE9GgXQeXyyjvUda5H9WQb59XB59QsmYbJeBR8Vb8vqbvfVFdwolEHTeKrCVy0Bgn/c/uvW9lI8NcdQ=
Received: from PH8PR22CA0018.namprd22.prod.outlook.com (2603:10b6:510:2d1::24)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 05:40:06 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::d1) by PH8PR22CA0018.outlook.office365.com
 (2603:10b6:510:2d1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.24 via Frontend
 Transport; Mon, 10 Jun 2024 05:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 05:40:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 00:40:04 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Jun 2024 00:40:00 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v4 4/4] dt-bindings: net: cdns,macb: Deprecate magic-packet property
Date: Mon, 10 Jun 2024 11:09:36 +0530
Message-ID: <20240610053936.622237-5-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
References: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: b707b10e-f00e-4bdf-167b-08dc890fc858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|36860700004|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Q9u1nSpAhhjSQZBNoOuHyOq+tMZEO185SOtzi6a9zlttV8Bf2+PMiLG+zsj?=
 =?us-ascii?Q?klXD+GCHmSK93xeSMIawyzJoHJtn7u7Oajtm1rxIOpqILM2hjIRiOEmQLF/8?=
 =?us-ascii?Q?bbD1S8IPcTKiocPxeqilE7JnrU1su9NZoHscjMHxv6ROy+n+5X4fv8BNAvXf?=
 =?us-ascii?Q?SPJLZbnaI425ARzNz4s4lQBSp13o5PgKHXLWcMVCL2ZdCWsEcvLQ0QM/oiBQ?=
 =?us-ascii?Q?O6SAxoP/dgog1UO9nD64dbPCk8NuxXDf6od4xPsJLp33FkdhNXQHr1sRPT+w?=
 =?us-ascii?Q?kSMJprU4pHeeKDTcMAGdUd2Um+T968m+IULz/DcJxYAyeVFDZhEZ3nKJmwcl?=
 =?us-ascii?Q?c36ES8Kn3A82fv0RESB3GVebV2XIdml60z5hC1l8qtJE8UCXkJv2mh89vlLk?=
 =?us-ascii?Q?5tMY7IJIiaV2nCDT1O3obh1u3Tn3KsX+rFVgoiqVpmFU2SdHbBOy/OWbmUK3?=
 =?us-ascii?Q?dIsXqT/YWf3F6R63gAsQpHnZZioFpsgnuxfMOtDmXRKowHXzq24NFCCo7XCD?=
 =?us-ascii?Q?TDNc5V7k6ttJjUgI2P1ErIcwk82qo5O1l3U6xqYa8gIXuNN8fzmnNB7Guy9S?=
 =?us-ascii?Q?ZbAp98ppLsyd5SV389/PWYgjCVLvKXv1W+QLK+XL9MkNHF23KkYkJ7TOQpme?=
 =?us-ascii?Q?bNpaszdWKJ9caHav7iN/IdZm1B2mTkzGD33Y5tP2DaQ2gAbqcMwMokzhdwYx?=
 =?us-ascii?Q?K5MqvqMPFxRoSQwErrLEFtYDwXk83jt7B7iWKKUItU4o1q1RL5MbP4joiXaT?=
 =?us-ascii?Q?8Zw90/pJJfvuFyn2VRRknHlOanas1fI5MWJ7HXbseYhH68emzwqkbIz4ujLg?=
 =?us-ascii?Q?7DfpO35E8R6zo2ruV7yiMQcnyT0JV9owJ7s465X1dPgtzqbui4QXe7VMcVAQ?=
 =?us-ascii?Q?u9BgSf9wyUPXbWjkWU3C/VhgTM4NmFxGZd9yqU7Hmf0dIRd8tl/WuGRg9he7?=
 =?us-ascii?Q?+dKSEESnPqlcGtysxjnsR0NG/15NvaHbLIqWQhZD0lnGAryRn8OzbYAl+n/u?=
 =?us-ascii?Q?248p0ok0TIstp16GGO5So4S1lheRuKaIkr4WAO/0ymisyv05cxUh+HlKj3FE?=
 =?us-ascii?Q?IYx0XIaFy+x1Pn0oEnruMdw5SCmdp0nqZ4Ji5ZCFmppTKTRLB6iLIz010mDG?=
 =?us-ascii?Q?2+6P5qqXjXW/+AlY9ShIVB9fdIQk4Mwy/jEk+8FqGlNVuT7LvK7nFsjb6qGp?=
 =?us-ascii?Q?18EgzIzbNVvUcqw9b30zvpEN3rvp49QihohOETyuUSlkdD4fvotmTzlXeHpn?=
 =?us-ascii?Q?a9ds4RlUHm1N9SZvKIAKUHHxloU7AH9hXpPVp9nQ7xBb8nVKZnaZK6VMGwi7?=
 =?us-ascii?Q?7ouFTfW5k8XzGpf4jXKpQos9Ms8pslQprpQ4BEI4VaZItCGjvhAoxabb8DmE?=
 =?us-ascii?Q?O0puOaPHcAVvWzxX2Vs7/0pjV9wyU3Cizb37WuGKYmwQuSLTIzAYIf6zziE6?=
 =?us-ascii?Q?xGf9nqsKhsE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 05:40:05.6779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b707b10e-f00e-4bdf-167b-08dc890fc858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825

WOL modes such as magic-packet should be an OS policy.
By default, advertise supported modes and use ethtool to activate
the required mode.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v4:
Changes in v3:
	- Drop previous ACK for further review.
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 2c71e2cf3a2f..3c30dd23cd4e 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -146,6 +146,7 @@ patternProperties:
 
       magic-packet:
         type: boolean
+        deprecated: true
         description:
           Indicates that the hardware supports waking up via magic packet.
 
-- 
2.34.1


