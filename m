Return-Path: <netdev+bounces-98404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2608D144A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDE71F22E82
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7B86CDBA;
	Tue, 28 May 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TMBDcr1d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4704F1F2;
	Tue, 28 May 2024 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877226; cv=fail; b=YPBgHdtHQlXz48dYr3XShfyzL9/p/aYhOURx0zfNtsB+PcL68wijWnH/d5pq620OPPyVHS8zSb3O2crGMUJUqeJm8JYSxDTp2aAMO2ywNm7PKkIZtwMPKLSteEIusTyECYvg3DEdPBZdM2MgkjMKILFH685T1tOq+Gz/FrS0DLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877226; c=relaxed/simple;
	bh=Kx1tiSRo+HajE+UOLoWz6jXm6AULV376OJhG41vcEFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYynRuXkAuv3vkGeYupN01T2WI1kcXGuRzZ0xocenlghlQyOFnRD9mgb3Zu4I//dfIhtIizYIN9zmHOvu17sB/E6fbPiIr/wIN42TAw9NaLG9q0JdEjctiPWL8Gg/OZYjOzi1UeoYvRrBkh+QhLcwg1tRggPKXqayLc3JB3TSbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TMBDcr1d; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GG1z2ltZVk03bQUXKF/pJOPnpbdDb9bdTFnpnAi8anHHpEfG4OxggrKhZ/kDH2yeaLdLz1hAngrMZBv1sUzF0wX0fyzC01PKNavnRctxt0i1XIUW2kQlLc7v4Py4I2f001ROfbdyV597u02LynFBr1DxoIw5sAgiaJJXWzLK+yrYZXCND59yzmv4JET0BVjiFc6nTZ7SiJWeGEkz54PlOJUuB8Ap7ML8CqjomwckEXJth97uRH6wmxMWu6z/6WlqX21+XL0RHnZAp85uYr60MP0LadarCsj0MZeK8TZrMal/ivA+xbesovgrCbgWr2NvmBr9UeUmqlMzQl7r+qBseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWZF8wIaYFG+KBT006vunoUNaaLg5ALt3NSxbiyx6Aw=;
 b=jfnjYG7RcaOoRkWHJc6bjfqT2ew5jF1X6x21pRr8YHflOK1tnT5yWvvn9yglJVJf23wnjjnrMTj5placQT9pVuqCs01zlO4UCh7iONDlHA4QZdtUoVVfCgfWGwXjbQEJ9QkmTZjhzRUNDK4ejXsAMuitUMYUTuwLG7wgih+k7LRi+f7CDF6TkyMj0j2GvNhjQoiEzSyc1BsLBfUQ4LW7s+E5BacmOBtWJ203h/lPmiX2Zd2yQVTjApmw+zswio3EyqKEqmu62pe6oUP0IPvlrA6JplwRIvXz1/HYSGsNPLGFelyHPkRb/QgeTF6ZsRzRYeUxLh4+VNVvLiN5IGYunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWZF8wIaYFG+KBT006vunoUNaaLg5ALt3NSxbiyx6Aw=;
 b=TMBDcr1dqvCQUFcytT8Gbg9ujaQfbcHU3iRQ6mvo7lOjjWAkoBNAdRtzpcgpS7Nnk9G9sQuehhT0h6j/Sp21Iwhl12XlIPo0/hL2lyvwzGB4UOgpIhvBB4/EUMDy502Et6DuZZG6z0O4rsSrzOBmh4lmc+TtfIPaI2tPBqqF95o=
Received: from BL1PR13CA0216.namprd13.prod.outlook.com (2603:10b6:208:2bf::11)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 06:20:19 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::b) by BL1PR13CA0216.outlook.office365.com
 (2603:10b6:208:2bf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16 via Frontend
 Transport; Tue, 28 May 2024 06:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 06:20:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 01:20:18 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 28 May 2024 01:20:14 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <harini.katakam@amd.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<michal.simek@amd.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: xilinx_gmii2rgmii: Add clock support
Date: Tue, 28 May 2024 11:50:07 +0530
Message-ID: <20240528062008.1594657-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528062008.1594657-1-vineeth.karumanchi@amd.com>
References: <20240528062008.1594657-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f5b4c8-2514-4128-9e6e-08dc7ede3f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|82310400017|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GdfGxgIjj0HkCgzXNfTWFNk7YfNm69mF95lx8eTcMKwW8h7uvbQVaDHZYjvB?=
 =?us-ascii?Q?gP+fvIitYDTqQ49nqoKZQ3/xh5JTDQD5tIk9gYVOsdUIi4QIyDPKypnRIxhW?=
 =?us-ascii?Q?SC4M9l7yBHPlOcCo45YOhHQbR8hYrbSsrR8GDjnXc8vt+ywNNk9rzi2F5fTH?=
 =?us-ascii?Q?eAdnoFg7TlONEGmiZvo3/CNZMvOR1HHOTn4Nc0R57l0wcNvP/SJWsHhtBlCY?=
 =?us-ascii?Q?vG7098n0trPsHhUtkc42fdj7YRVGNQeAdaikjpifPdeNJS0Kn462A2LapA2B?=
 =?us-ascii?Q?OhNAmHASku5omcmxgGphhUnh0LRxJSbbHCFaG5UuFvLLS3GsY0qjqEyoy7xd?=
 =?us-ascii?Q?rZi12VF6fPWY+hVsSeNZRNIRsj8K6wPgx8IsgWVnL29WHnnlixMOK5Hf6CQ7?=
 =?us-ascii?Q?lewfRySwUGLtoJebBb5cvP3hJ4Ku/EjIVVjZhZjuGxiAOW1erhC6twh1tT4T?=
 =?us-ascii?Q?FfT7hoiICC/45sN+jcYAeHhP0L5A/fzyCdQnb6HDm1GHnxonYiORoGXPYYlg?=
 =?us-ascii?Q?h6mvDfOF9aaWkCB7rUUO2Ntc3X2A7ph82lIdkCmjnJD+rc5CDIsOgdtlxvwP?=
 =?us-ascii?Q?zXWOfuzxTSW38Spv3wF9NWI/3NrlHv+hwniF5CCPMoJl+dDLfFIomsdRXnmc?=
 =?us-ascii?Q?m9AEwCmAxm4B3JjIorq5Q4if0aoYi+GMk/Na0ct//ZM/esziHG4Be8lfafzt?=
 =?us-ascii?Q?UoXanBfQaVDpw0fim1LBUXD10621lLC0D0cuKPrbNTzNK37HQ/j+oGZTBiMH?=
 =?us-ascii?Q?/a5vjSPddI5kzInkh7YelG40rZW06iArDsw9pjK1RQPzmvd/1xOJLb9xmSlT?=
 =?us-ascii?Q?Ms5idGXHpMZOh5GmRiQMO6rDlQEohB+WYNdf8qJYmBSTeljPLrvzRCnXJ6Mp?=
 =?us-ascii?Q?DOm1cwPj5mgRp2N2PC/0RgiLfbLv5JwNWwdhroKsR5Z/2cVyttzu76EfnWlk?=
 =?us-ascii?Q?4JDpYItDiGUdSIY/dJxKJEmKlDrqeH2ajH2WOkokOkj/zKFyhy9H5Xk8NucF?=
 =?us-ascii?Q?kLIhxBDvyKipc2EMsci4SuHtCvmi3t0jZMyM9aGYKUof6yMrce1pjhxyZYO6?=
 =?us-ascii?Q?9aImhje3DV8jBTvLDh9WYo0DMJ1tv18Zjlt6/bR4yGgtO95H85QQ8dcr55Bh?=
 =?us-ascii?Q?n97H9BTJdgkXkP9H4XPtKPJR/BEr101Bi5FUBfF/L4/wmPDkUnQA7qlxrJSq?=
 =?us-ascii?Q?USoJfrDB81Oi8p9o3waUupfNEerQV1wiFNf6na7yfWlBXuryjmO/IDsG8d3d?=
 =?us-ascii?Q?zHnxINxtkWXeePLB9uyRq1XTuJEThXPUAZqKRlT4x3v4uYNPjzKW/AY4D2/b?=
 =?us-ascii?Q?j8oSAS145FE0noUwNkDw0TejLIs4j//yj7uUC5uKRDkAvQGo6/dEMocqfoSb?=
 =?us-ascii?Q?JSzyPSs/japnSBL848TUI1o73wmL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(82310400017)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 06:20:19.0500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f5b4c8-2514-4128-9e6e-08dc7ede3f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218

Add "clocks" bindings for the input clock.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 .../devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
index 0f781dac6717..eb803ddd13e0 100644
--- a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
@@ -31,6 +31,10 @@ properties:
   phy-handle:
     $ref: ethernet-controller.yaml#/properties/phy-handle
 
+  clocks:
+    items:
+      - description: 200/375 MHz free-running clock is used as input clock.
+
 required:
   - compatible
   - reg
@@ -51,5 +55,6 @@ examples:
             compatible = "xlnx,gmii-to-rgmii-1.0";
             reg = <8>;
             phy-handle = <&phy>;
+            clocks = <&dummy>;
         };
     };
-- 
2.34.1


