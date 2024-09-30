Return-Path: <netdev+bounces-130562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9AF98AD89
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13AAB23ED3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E219E7D3;
	Mon, 30 Sep 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1uGn3Ofs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7F19DFAE;
	Mon, 30 Sep 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726159; cv=fail; b=F7EZNQghRDzXAaiWznSliLBPDfLAvXWQyoYUMmZPGLHFj8suU6pcf9PB2fZ4zp6bNzE4mtzs7RZEdLyb77ixHzlY0mN1bW87Jw3OCWXK9kUIvmv5Djxywn7WMaaUhvNq+n7TTwZ2X9zLv1Iqb2mKg6kyUlZTEUNzeNBD+0Eom8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726159; c=relaxed/simple;
	bh=eLP8J0ewC9xsf1wH7zG8SpffB1Mggd1We7eGAQtS4tY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmTK00FR9CgBdoZN/E3Ycx+VMBPXv/lwFxXXDi56mdR+ozGdjWe2+kaFzMXjMsvO2HYxoF9AlEqlHbUId9No/zUFWICIBSpknsyfYJ2HK0i8c8kIpqkZ2IKkrxDicDHfwT394dGWqo+tQDV6T6NExeByuYX24wu3klBwzpFhlsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1uGn3Ofs; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsX/ZvCcXYIbjXb8AnK9baWlpH0jBpvEQVXerpwENYeezPSEY9iz14gkL5RsXMmgn3hXag7w5B0L68pfM+yB2QWQFyM8n9/e7deAgQHBMow/iHQx9JD6V4YcbgeOVzGehFDqT/T91ncicwncvPWXwdDFqDJiLipMVgsfAO/j6KIg8Bmx18F616Kc6OKQVm81mvZ92Yld1s1E+tBnf6NvryxJ9FNu5khYnWPRu983DMr2Q342uw3k4sirVm3HeXURA13iMVN8Jfev7+/obhdtrQuCM4E7sz6A6quP2SOmNTJVUkFX4gsf+mQgMPEkf++a+0uUyTAm/3yYchLZcsBinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU2wk+mkc/kDUupvdV6TcLyjBN/TJ4UJXraBEv74gRE=;
 b=wywD4/6lT3F2mp+J/f9/NF20RLuXfSN2fBS75iW9CvIGaVjsSTmMc5a0Tryp8pSx0DZAfqHaI2znkOUEFVbWZitEeQoU4rYSDtoLWglb4WQAdSZyCwz/rHDtBpQc8IaxvrUclsaNcM9gPT8xEFdpNwtYLffiSbv9ZvAA1Kx7ASaZvOLIYFY3JmhXgg0r7kkZWQ0oXWD8475c8HhlCao7lP6yd3B/IMlFSMQFdHZbcE8V5KFBxqH9ZrbkC8f942Lp6IvVLZRmd6WdfnGcHFw3sSm7z1Zyq9DAcd/a55Osa9ln/JYNXCED0Z+POOBe4egIZNEjf7VDd6/vzjLoW0WzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU2wk+mkc/kDUupvdV6TcLyjBN/TJ4UJXraBEv74gRE=;
 b=1uGn3Ofsc0XWwmuJG7SlpLfA7EdVHXBSLDVXCSqj6gJ5rPafVdHzTjtPQTKfq5YsjCaa7/cQB/KyFBtnme+dE7US3u85iLcxncmNeqksclAHoFAbVNHrNm9JEV5h/WStYy1FL1YdGyW2aAdoZaGhxZOxT7YmdpmwtnXAHIPXYq8=
Received: from BN9PR03CA0414.namprd03.prod.outlook.com (2603:10b6:408:111::29)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Mon, 30 Sep
 2024 19:55:55 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::b) by BN9PR03CA0414.outlook.office365.com
 (2603:10b6:408:111::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 19:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 19:55:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 14:55:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 14:55:52 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 14:55:47 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>,
	<abin.joseph@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<elfring@users.sourceforge.net>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>
Subject: [PATCH net-next 1/3] dt-bindings: net: emaclite: Add clock support
Date: Tue, 1 Oct 2024 01:25:36 +0530
Message-ID: <1727726138-2203615-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1727726138-2203615-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1727726138-2203615-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b298e1a-f70b-49a6-7174-08dce189e4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrQo3rkTBl0rZldF+b1AfJSijpclTqRK+wpeASvCFMZwpiQbZnpY3gQqEIQG?=
 =?us-ascii?Q?IZBbkL3hFmV7ook5rVvIG0sFY8g+YtJ6tbOODkPgTRGDyUkJ/oe+bJZ1OdYr?=
 =?us-ascii?Q?FUGbJN9ZZOuO+DyBZBDYS3jrHYMTEXT13ZYrL1kIbkOdrCi59JVCNBdALpiQ?=
 =?us-ascii?Q?XCK+a7DIckBU3xtzjfEFiJiCA1yNVS5uy8CsETLjL945slBI5xEZx60DOg0P?=
 =?us-ascii?Q?/N5TQ2Aiixmo9w01Q2FW9ixWpusDkQWhfzsXLem44Cfm1U7TOShFxDQWxIqn?=
 =?us-ascii?Q?y0Y4U5xQZHEYVOZBUwYdkWd/fkhueqrDX7phdcrdNIAPmo7cBmqmgeCxP9lH?=
 =?us-ascii?Q?J//GDW0mf0D5vb7nGZFNyEsdhPvO024g+XPFcTzq0JX6LoPJ0Mpy//QXCRer?=
 =?us-ascii?Q?oS1Rg/DNgunMOM1zMIPTj65riTztZoBKPsa28+Fn+syTtxU6p6fq55lKvIVK?=
 =?us-ascii?Q?1PBL3qmrIYaBxJFmm3MbdHLbkw1BZgWr43X8sCucKPWjsUuTxjdj9pt2D2hA?=
 =?us-ascii?Q?czWxO+qj+D5WslA8ZKQEPXeT884N6rUqzqQ3vg/B5L//uEAnmZfvhNJBQiSY?=
 =?us-ascii?Q?6Jw4gJfUeXCavCT96P75PTdeu8rp0ud04ZnFliPJ/Maxr3inUKSrztsQb0rd?=
 =?us-ascii?Q?dd2/JWaKScPH4UUONUsR187cYVBf2w3jpIc0bkQRll8tmYAF/nKZHUnhW+WR?=
 =?us-ascii?Q?142Dqo9p7+/ubcpThM+cUxJhh9SzbQ0LN1rfP3M647IgndaWZfAmzP2jVSlL?=
 =?us-ascii?Q?Tw0CnwPPkxcwShAAKiufAK+xCaN1dba4FAhtOxtBZdkJkTJ4IsxSnspxC9i/?=
 =?us-ascii?Q?//nrKWxfY6rh56aEXDLnVqueeSrQzDOLrYN2wEolMgw01bwtf63tOExNq5NT?=
 =?us-ascii?Q?lrvTGU6tOdA6WswQZsB2HlI1lR0RoycJMq81Nb4OXJQBmIM9bs6oLBWYX1kQ?=
 =?us-ascii?Q?RGxysvVGa1KK1rMkQirv8JhWYzRi0G9wCbiDIn6t06l0ISfBIZ5xRMI0opIP?=
 =?us-ascii?Q?yz6albwApFfYwR3RoS/zcWPth8a93sLCbCTT1OPjrOQpVr9/xzGZjjkRbQcj?=
 =?us-ascii?Q?3L7pv9WhlfYNSkXjWexqa1bVQT9sBb7HtE8/OBFKMwduoXLPuRC+NKmk0ngU?=
 =?us-ascii?Q?Quf/6xsLW/jvea/sZMnpSwhiuigdR2d/zz4Ui0MppENXA1d4VF2/LFLV4Cq7?=
 =?us-ascii?Q?w3F9np5HukgRFnT+vP5mP5otkqpvP5sepasibEsMfVnZwoCY/YxdfESJwOGx?=
 =?us-ascii?Q?BC/xb0f3eJSxpv7/RX1NwXA9I0bEqaHjYciPkVWTWhFPu4PbUse35V9VVCcB?=
 =?us-ascii?Q?N4yLht8Zf8P5uRyjZ/mVKtF24C4hTV6FUUEQYmu77ginBAGAm7fE2OnIbZnp?=
 =?us-ascii?Q?7Y/h3g+K9gqxuFinScimrcLJ6gviJHK9xm+WGibL+FD6zwvQ+NcbrMq1sQII?=
 =?us-ascii?Q?oJkxR7vutUpTbjlMke1rlQQvZrMGQswmI4Wxdo4d0w9w0MuFMBolMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:55:54.4490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b298e1a-f70b-49a6-7174-08dce189e4ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352

From: Abin Joseph <abin.joseph@amd.com>

Add s_axi_aclk AXI4 clock support and make clk optional to keep DTB
backward compatibility. Define max supported clock constraints.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 Documentation/devicetree/bindings/net/xlnx,emaclite.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
index 92d8ade988f6..8fcf0732d713 100644
--- a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
@@ -29,6 +29,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   phy-handle: true
 
   local-mac-address: true
-- 
2.34.1


