Return-Path: <netdev+bounces-96853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF918C80AD
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273E31F21E48
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 05:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F140510A2C;
	Fri, 17 May 2024 05:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DtAqrIr/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6814280;
	Fri, 17 May 2024 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715924881; cv=fail; b=D6e3OQteH9E8ZPx0ZLeaJo/0idx/uK2TD72QFeKRN/kx5XNqES8TdWhzTqiS0AhuyKrMTrSol6JStLSRmasTF57Rv0uFAUH3FcM+4sCUUctziKANXRjWsJl7S/wcBJHk2a4mfi+l4MlpVP5g0gbRvmChPnZN9nhwxWVaJqLdLPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715924881; c=relaxed/simple;
	bh=80l1m0xY6zua+xCmfPu169Lh6jR8xtr3cVsnJVRvT4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7oZ45crSqiYX6T1dyZHUp9cxXvbLFjUnjEJ1OUxnUQmJzOyqbHsFy5CX/5sACgeZpiNtZuaAMBOVf6qpCwIe/+54vGWrHx1oC1HYScjW8EeyidstXK3C+9t+VdEvNn+sbOOpaJn0cyNq1KQ3fQPY7fWngCQ9cEDoG90mMdeyyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DtAqrIr/; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO5/tYFMQD0DhnQ4gs423db0/uATPsQtrXQAv+EXjC4wTtvYcuIAVKv7w55ZMJXxr7i+xs0nVt09FxqN1KsZxr9bqzWVY3PpjNAi+YgG5HHsKhpd5qGiMomaw3SbvaXVXLe1Bsz3S4H5lNDKchQ6FYo3tfIXqwFlGiWRq4BmbAPjI+3sbBLSaSVn7b5Le8PqOYldwNGZc47NhCledZiBDP1w3V9zw7Z7dApmKQi9YKega6ictCTkqeE1EXJLRm2ZDnb3i9SGR8K7SbF0x2jMXNR55f1mtHFlkli8lpVIfq/n59A3iV6NgbRa+6tbIdGR3e2q8Ph/17elGG3zsN/3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5WpNnUCQSsHOTFqSIMq8KScoqFVz6fq+mGn4WGX1Uw=;
 b=YG8wsKj6gdIyR55stB/uJedH6bz6nrml42bIFvxWXPorflsmJi3l9JfJmp00M0BhwAa8d93qQhJy2dtg5ujgUD+Df4RNaa7D71LVdWgWmxM9ZJs9Uis+7w+mNiRGPZbT/e4TsSeYzrUEPRyYtir2O7a7eFAMnDvyc/PDhlMwdOSjeCbzecHytkByE2v2XPlc3aDgL1J1FDi/A66MjJ4F5SM8baBMkzT8ivPviAoHae2Dz34L386r9vdm6+dxbsrCt0JfkM3cBANtNuYq/ejsIEHKBubokWIdkgsocfjD/OzlkAtyakq/COetoF5sm2oLKZMx+HO+13coCiMn21w+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5WpNnUCQSsHOTFqSIMq8KScoqFVz6fq+mGn4WGX1Uw=;
 b=DtAqrIr/+TL9AFM5aHbs4FMK5hXJ3s3JuN1k/uvmoXsKK4cgGWh3RKcYOg2xrM2klgC7HjA1TsGP3XjikasI8+A/HQ+mkcPio6bxYGSl3Yomsr8X7ysruAIaSMCnC5cEWlyBpRqdSTWXiP59jM6uVPVknxpISvTbJ5VjhrYwEyI=
Received: from SN7PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:f2::8)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 05:47:56 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::29) by SN7PR04CA0003.outlook.office365.com
 (2603:10b6:806:f2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Fri, 17 May 2024 05:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 05:47:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 17 May
 2024 00:47:54 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 17 May 2024 00:47:50 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <harini.katakam@amd.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<michal.simek@amd.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: xilinx_gmii2rgmii: Add clock support
Date: Fri, 17 May 2024 11:17:44 +0530
Message-ID: <20240517054745.4111922-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517054745.4111922-1-vineeth.karumanchi@amd.com>
References: <20240517054745.4111922-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: ac486acc-312e-478a-510c-08dc7634e6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZfmBQcjKdfqUULAiphPNm9KUhGMVhHKa1fHmN6x+o6tmsy4rpndUtsE4S4xT?=
 =?us-ascii?Q?vfE8VM/bQD0kVd6modpwPy7S9gQqmYdz3nl3K3KuohqY/jKIdulhiJI5B0EF?=
 =?us-ascii?Q?inmmus0wx6O0DYw8ooGbPIl+cvmcmi1v7f2NfN/Jah5cpFqpyqnCKQvTKDEh?=
 =?us-ascii?Q?YEQg+ewkl6ofAd4D6YlQkUAzdfnX7zkT2BOa/VXss8Lqi7TvrtogJW2PD6Md?=
 =?us-ascii?Q?ovvjKtqsSFmYOCLcELbt/QR+ytkUN4GklDLDzWg+xtDOFNfnJJOHVIdMpJ+Q?=
 =?us-ascii?Q?SiaKNxDMTejGZvA6pKdPYDJqfP8fjKE6Sr47P70yI7x4c1VT2ZnkEEYF/GIb?=
 =?us-ascii?Q?gxNpup6yUMpt8rucXOHHolTX2+mlyUbDF48ySIA22mTWAefkgdeqrjDrnq9i?=
 =?us-ascii?Q?JIbkE80rZUiR0FiMKaOiqgR6RpWgw3UeAICu/ZdRM84nbkiWmecKPZhq+JvJ?=
 =?us-ascii?Q?I0ZeZosJpSOXtmDR/Hv1JQ60pW/ACYyABmh8VGCw/h480xSOml8gOjeUaRWf?=
 =?us-ascii?Q?brWlPpGZ25xdXR409aVcFGqeUzvCvgTsTt8K9aDKKuQKlu2rK+KkRpunmqwt?=
 =?us-ascii?Q?iowRvuttA73V8n31mk7oJSWGzxMYekRZwGzRee1fhSVIoDM0waqfqJQpyNk4?=
 =?us-ascii?Q?Z1C5AgEMJtclMILuFHWzdV8qm0x8o9u6JXZ3jMZhER8HrNoLqR8sk2S9iWWu?=
 =?us-ascii?Q?33hl1S4Z4cui4M9oqzcHP42QQhB1LOI2bbmlNT+m/y6vPQcL37STpVTXCuM8?=
 =?us-ascii?Q?MLUuSNE65RQKv54Jvpe4UZgmq2zCZzweZoZacLg5RWnbfotemwO6hz2dNCuJ?=
 =?us-ascii?Q?eLi0gVsQyjjLJi/eLCwald86/wONWqyzNcn0ddFhCvnZQTjSMi68ELx/jnuZ?=
 =?us-ascii?Q?FEz9St+7PzLorPm1MEkUlYyyl1e0rYma/m7aYciM7t26ogXbRybSgXYdcbqF?=
 =?us-ascii?Q?xhuVlRWVatDPAggrvCI+kH7bOxBMqsUNSGYbj/e2Z90syvx6BKhSUs2LJiN+?=
 =?us-ascii?Q?gljKgKXZ1YMwcXWZhUdvs8mw8QhGgwFBAa24kRkmqNCNb26fBvp5eLT60qMW?=
 =?us-ascii?Q?VpmtkK49Ju2JyfvYS08u1VQYasN4EhwFfUECFFcZJoYWhaZA473XV6mN4gt+?=
 =?us-ascii?Q?NxDdzV90f6B4PQVSqjh1z2DoUgKZavx6ExmTTRCXDKMXpuxWOdjsziPX3x6N?=
 =?us-ascii?Q?bVrJWyNgmrUBscvR2V2ZqLzGR1KkLHcCRSp9opDTdNAz2ITyPvkn0o9J9NtQ?=
 =?us-ascii?Q?NTFmYLTWu6yBHk1NmN7kWGsDtaS+WUyxRgQ1AFfrEW9otZF+4ndQlB19YcgB?=
 =?us-ascii?Q?g9koWXDyLaBVTmqJNHVhxcfZgFEId/Ba9naAAtf6l5iiZn89Uz4KYVbcseV5?=
 =?us-ascii?Q?3YQi4OKikW+XwrmX6itVppCm8GPn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 05:47:55.9113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac486acc-312e-478a-510c-08dc7634e6a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941

Add input clock support to gmii_to_rgmii IP.
Add "clocks" bindings for the input clock.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
index 0f781dac6717..672bff6dae28 100644
--- a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
@@ -31,6 +31,9 @@ properties:
   phy-handle:
     $ref: ethernet-controller.yaml#/properties/phy-handle
 
+  clocks:
+    description: 200/375 MHz free-running clock is used as input clock.
+
 required:
   - compatible
   - reg
@@ -51,5 +54,6 @@ examples:
             compatible = "xlnx,gmii-to-rgmii-1.0";
             reg = <8>;
             phy-handle = <&phy>;
+            clocks = <&dummy>;
         };
     };
-- 
2.34.1


