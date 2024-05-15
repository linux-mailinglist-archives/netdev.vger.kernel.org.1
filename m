Return-Path: <netdev+bounces-96504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5188C640D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA95C2833E0
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC955A7AE;
	Wed, 15 May 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MzXcqeez"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF95A4D8;
	Wed, 15 May 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766421; cv=fail; b=Gictcy/w3T+HTvmFQASNKGnIHb/6+Vzi2zq88OHR4zNT1CNfgKgwAjoQSdrghT7JuYDIDuovwYvNCIW/92sP4I3IWFl7d6nShbZweBSmxl1VayVAkuqBjNTzOhhV6ss8ysjdOG+PfmexNDwV/gPEFWDPtK5TltWdGX+nqRhG99c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766421; c=relaxed/simple;
	bh=lLOCF2wP6QL4dC6IvX/0E40Jbbr1Pt2hWaMIoCZxG90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjjPPEKUen4ClBYsEwc0WP6XVFSHTCu3v07XHzmeHgWLdZ3Mdb+0+4zGfHKYVdYdre/MTblQb4nbJV75c3lt/TBZCGYvSzjNPDfaz06Z8DYgnveTVziKRavzT27XQ3/cqVPustd3Bg7zTbQNo5jyacWhW7G5eU9Lsb+kTxCHsQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MzXcqeez; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRAOn79B+BhT0gPOorm9AcGkEoa75u1mCffTRpKjse4J/M9GU8obTfiDwev1tre/laSFSdIh7+7rabx0SOkY0i2TODoQiZXyOy7IyJF/3h9IY8/23DiJFvugzGeMbjwx9UQ9pWPcd0pqmaHxsHDRo2Qd9gX+QiM68MzOYSqc9VHKwJqO2gKoiyeusmu8EdHFbhauMrqa+00tCB4eW3hTzpVbANgDM1wM4Ucm6FHfzWg1dTgEYTgy7bNW6YkIdKsAzk56syyRsfl23ao9wzjE4ln7MLmz/ewz4Ud4bRgXbWnnAaumxBLiuQowy72J+zPPXLdOzcWn0eBIKfYUO8rAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj4gRg8TW2DLiJCSAagl6a62oXUpjUDQUmHung32reM=;
 b=UjamyR36pBqhPjuPB20Ajx9Xe7yhyP4klAkd6JVyWB06rHX74n/jvyQLUlYIVthbyUpjrm9GEkYsoWraPPu+cmCyITWsCJD7p5z4QryuioivmStyuHH9VQcnHTVU3A+TjKUQkHwB2tRh+ROpK+JWZlgmkYVTxRkDv+jk1xQinkm6Sr/R9GWLe/P8GOARyjRteptjom9CZmDwTI4Ch2Mb3xuHnZfHSmzp6AHPduab1JDgg/O2RKE0fjtBstVmdLQVe3/YLE6Npr4HDLB/ibL0if0suQllW8ZXdJYBv+5PBka2cQ58iU8kGDUkSns2162dd8rW4yjXvytO0K6oLs38+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj4gRg8TW2DLiJCSAagl6a62oXUpjUDQUmHung32reM=;
 b=MzXcqeez8QrloQU+FTJ0juLDtD05O2hhCYoUggNW4aGTHwNc60uJlg53485gBdsnz6o1tcY9efGEiQZU9YuJcs8udTWsjdE7IrpMgrVvHZ6RWcmD3BmEr0VHKoX0aDyBcSnUp+7r+DECMuJwsr99QnhyMs+IZ9mK0Sv6EdXxShg=
Received: from BY3PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:217::19)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 09:46:57 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::a1) by BY3PR04CA0014.outlook.office365.com
 (2603:10b6:a03:217::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Wed, 15 May 2024 09:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 09:46:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 04:46:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 04:46:55 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 04:46:51 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <harini.katakam@amd.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<michal.simek@amd.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATH net-next 1/2] dt-bindings: net: xilinx_gmii2rgmii: Add clock support
Date: Wed, 15 May 2024 15:16:44 +0530
Message-ID: <20240515094645.3691877-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094645.3691877-1-vineeth.karumanchi@amd.com>
References: <20240515094645.3691877-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 6829da18-358f-4645-8b5a-08dc74c3f5ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|7416005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9HXSXODNwbNFyC3kSOGFfWenV+rHfDHadolPjdstBSchGoCRDmiJoZyapIdp?=
 =?us-ascii?Q?i0yFsKFCmrRzdZ0gpTwJIGQI3o4T46Bfgvmjfs9g+9Jnxj1d8GZbFNNnkcex?=
 =?us-ascii?Q?3lEBYUiRYDn7l44xsqDvI/87v3NSQiFD/ZcrmlKessH+ydLnGnkpFBhIWXoR?=
 =?us-ascii?Q?8NFnLfWms/3O9wsB5wSex3Kjkrx6X1f/j6rhgsPF8pDIW8eMBhBGGMFrpzOu?=
 =?us-ascii?Q?fP2ADdycHDRq9WKMddzXbYSIVD3VMnjErp+4UumiZjJNMT/j5vzksQguAkpf?=
 =?us-ascii?Q?hdmKMbBLLDsaHY7vDdvnDfAmsQwf/2S28pMjREq5ETCAd7ihTmzYGgpMwRYY?=
 =?us-ascii?Q?Ss5uWAtia4sciy9tWiGv25UpT9gOxLDnQ+Knvi6M7bjayxJCqx7FMWab+WE9?=
 =?us-ascii?Q?T9btLvPEgIhafjXO1bWoVBxt7MHCGiAVSXKGOfc7A/n9qfOuo3bx0Z6cWHMG?=
 =?us-ascii?Q?i64+AZ1jJDxI77KqqlY1gzKNU6iAGYIRKQ/p889pzlDam7K/uh+2XrluySdH?=
 =?us-ascii?Q?1whyb42zixGCzTwxce1dxxE516arqoXE7QkSINoZQA6Cm3xGtWCYyXrz9EY5?=
 =?us-ascii?Q?6PE5lBQqnDW1Pnn6K6Hg7d0T1QML920iCLy6+vGTJbWy7z6qo4nDY8Gg6CLo?=
 =?us-ascii?Q?IP1NSDxKq978SHEe66s7SjWeluhihl8I6F6PqLmBuseQN0BuGJdtuDdto3lj?=
 =?us-ascii?Q?g5dnTZxigMBYWM9JADJ+6bz+bNJLrul5hKsV8eDd9eHCxLLaeBRU4MX6dG+m?=
 =?us-ascii?Q?QUzGkGe6R/d/XShG7E9Knhf79N9uphsrO6lbZFvT0wPXJgGf/KScW4y8oVz/?=
 =?us-ascii?Q?M4yG0+XpPX0iyoL6TAjzo6sChlJR8tLgzotvP7i0jxmML/3CMXiKz0ett+hY?=
 =?us-ascii?Q?Q5gAgTEQ9pYIe0qOrpf0MHUJfFjIMtjbwBGEAN6qVHMrs4Jm3DY2IxH0oGtB?=
 =?us-ascii?Q?gxpO+G6E4RRF6vgRmwuDgZlr9BwbyQhT379QMUXVVxLCc0LmfZakfABppMaG?=
 =?us-ascii?Q?3AfyyM12qFQPMAaQYQ6hV0pIPPZIqpfB8Cf6SI6JvuMgMF5iYTjSr2IWPUy/?=
 =?us-ascii?Q?VCzHKXKaQgxZ1QSL5hhExiZ9UVRJcLKqcltVdoo/03Xw3bWFRNuF4qp39a+/?=
 =?us-ascii?Q?TwzmTecNn3IiyRgDlZjwEMw7itTL1nzPCnh84LQ57jKr+E6b1sXbtBUPESI1?=
 =?us-ascii?Q?+304w8UXHAqSEMKOnuG+TBaM5Di6EJCtBE4V5LJUSXnCrvEOSIrA+25wneFh?=
 =?us-ascii?Q?XLFoJr8BS0n+32rAg3lEvWza9epya0vevM1t6tecnQXRkxcWpNObuT/cWFYg?=
 =?us-ascii?Q?M72kiAriioqY4zHIL34DIkerXz07qus4t3vSLJpSHyffiWkoG4Ab2LqdY12G?=
 =?us-ascii?Q?R0uRMit9pinpGS0hIgeXYXAa6QO2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(7416005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 09:46:56.7506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6829da18-358f-4645-8b5a-08dc74c3f5ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793

Add input clock support to gmii_to_rgmii IP.
Add "clocks" and "clock_names" bindings, "clkin" is the input clock name.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 .../devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml      | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
index 0f781dac6717..d84d13fb2c54 100644
--- a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
@@ -31,6 +31,13 @@ properties:
   phy-handle:
     $ref: ethernet-controller.yaml#/properties/phy-handle
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: clkin
+    description: 200/375 MHz free-running clock is used as a input clock.
+
 required:
   - compatible
   - reg
@@ -51,5 +58,7 @@ examples:
             compatible = "xlnx,gmii-to-rgmii-1.0";
             reg = <8>;
             phy-handle = <&phy>;
+            clocks = <&dummy>;
+            clock-names = "clkin";
         };
     };
-- 
2.34.1


