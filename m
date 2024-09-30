Return-Path: <netdev+bounces-130554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEB398AC92
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AC91C21330
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057119925A;
	Mon, 30 Sep 2024 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RQcp2ovD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11F43AB0;
	Mon, 30 Sep 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723628; cv=fail; b=IUeGaKkor9cwebPYLK1wM3qDfHcuUQaC447VOAzKzQlU5L+GO2rpnnnOIDutfGmNfNlAVCY+xB5gkWftmfKTCeUwH7cW64WjsMwDgfOTWQz2ILjyvrfu7HSRBtjX8yq5C+J/LiavsLWI0Xds7+dhPzrJyN0tC2FdofdBb0t1a6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723628; c=relaxed/simple;
	bh=GFGW6I4yioVu62C1cplLbRKpSt4SpqM7YNhHaMet6gA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HnIJc0qvy1XWKQM77o/h/Je/dDHlkeKQQUk/nAay1pjY+Q2bYvCJ7446hYF96qbXFJtBkZSUweGDqk0F49qJgJeuwkbIu3b3YLi4oqFoXUYJu+SNeLwsMkjZfaCG8lHoW/Jpq19q0k02YfRdBzk1fiX07qBR1CWkLtX/xPh7mJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RQcp2ovD; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgV77Ap4nEUAPr9rUMYrzvUJ1n3aWJGw+Hk+JhKBse2oSv1nvwaQr79jq+KgHpz2UQeoZ3Oq9K/8Eljx08mFpWEA2IYh925yw8Np5M5d0O6alzNaW6EhfYIgZ8Bkf2aD/Kh+M3n5wmEoTW/gdRDo1byISl+gEjYUeadtgfFxVYe7xDsC+Bpm9mwAwd/bemn3GdasVBgGjaMV5ghtNBY9zU/Fwucwcn1FaOSiKnU3HousjtFRThk3eerl5JL2Dk8uonPc1EwdkVwNY8zWaMvyaTb0gjO7aSN3r6SyU8+pD3i9srmxA047JW8icnx1V7skvMwOrJA2crwZ11C+kUVGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpsiBrBzDEMnN0KBph4SfMMClbSpPnwO9mSLpoI1YKA=;
 b=FLRhSmdQPnPIMy1g7eQZWjUTrFCT2A098wF/EqzWmsE6yLUwcbbeZVIg3uG35yQD3WQa2wbhZi6ZmJLgJW7kxCWLgIm7dunXE+ezneHwPYq2oxPZYDCogWXCvUp2+H5J6dQQ7vscYtxivSr3mq1Qo+NPq471yLqlU9bhrALcQ989CRD4yM/ephvEVZWrILqms6C2I5/GYso3cdQAHgPefGkTXWvOPj/mjI7zjBpYEiOvt6TGNJjIis2LaN7/7PPjcMlgCWQS/V0ThDMnqLwU//smfjZsj9guYyORtI7PAFkMHzLXzKtKScxPwNAW+F04axiEBtTu7M/WdGygrRlKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpsiBrBzDEMnN0KBph4SfMMClbSpPnwO9mSLpoI1YKA=;
 b=RQcp2ovDDNdX9mihoJo9kcAZRvXGTyrPBpjLnDFA58eo/OdqI8/MCNxTK+m3cF/E6qTd3AjmaiSJnidGpNTR2u3penI3g4yW75Xo2Xu/jt+igzp7fWy3tzXPr6tA06h3W08NOBHVeU5kIeuXay8lRhfI262NTTSYGOVVdqzVvrU=
Received: from BN0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:e7::34)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 19:13:44 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::df) by BN0PR03CA0059.outlook.office365.com
 (2603:10b6:408:e7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 19:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 19:13:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 14:13:42 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 14:13:39 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Ravikanth Tuniki
	<ravikanth.tuniki@amd.com>
Subject: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Add missing reg minItems
Date: Tue, 1 Oct 2024 00:43:35 +0530
Message-ID: <1727723615-2109795-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: b3502169-bc54-4f93-557e-08dce184008e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EjL8w3qSBZ5p8Tp3N7lFHRod1dU475RFrvmgAqujy2jNrwFuTsFpnocZB8qT?=
 =?us-ascii?Q?7GbTuq3xwrqdiT+oO+Qb+ZC4nns7z+nD1JODbVlpAcSPDbQsqK7Ax/CKWagb?=
 =?us-ascii?Q?mHqHIX75hdrdJOisBNUk6KcXxYEipO4sdPGm/1VedfdrmJuKlrHy0WOfeWaH?=
 =?us-ascii?Q?ltS3OUaEGYxZ2Jl3U2W9jGgIBJRUv6E+N4oFUByJA7c4fdYUWw8KdTWTlBBQ?=
 =?us-ascii?Q?2OSNN+yvN1ksaTR/DJFtzQsbMT38Dl2HhDbMGKBv09ZjgwqXwEBtRlFli3tk?=
 =?us-ascii?Q?CsXS4qFGjluhN52ax9vB1GHNF3iVBVRzDvqRS+z696JEIbjivmw5thRs3DfO?=
 =?us-ascii?Q?5I6NRf90Ln1+y5izbeOG1tlov5sW+YXaVivfuYuKzOYcMc3bV9encrUP9fiN?=
 =?us-ascii?Q?dapQbEN5QyzKB5XtpZxmYxw5nWaShMjHGh6R+Ii6wMkYsUSTERI0zkfH99yb?=
 =?us-ascii?Q?Tx0fL3QmmXB38O233Oc71++1VoiNA9iSZIG7aIuQjOXnyacFTn8Y3cAqV+fK?=
 =?us-ascii?Q?MUDQW6zF/FSisQYuZrWFoSimbEJloV99hM6LAGj3MK2RgSRamCq4+kP+aK+d?=
 =?us-ascii?Q?/Dp9zMLaEX8+diPCqyDX3j5tvdyVcpS0CqQzyP6QnC8f399crHsr3MoxoBAH?=
 =?us-ascii?Q?DhuYly7JZFjOLtJ0gwTIWq5TltxDmSmJ06CClKtVvrIDaywpqAB495eLhm2l?=
 =?us-ascii?Q?ydn004SJPGlplwSMG6T6SMvlwCotDI8x3sfCVofTQeuabgqennxf5vE6PmCY?=
 =?us-ascii?Q?rCMmJ+UBEGkswXILJQkp0M5FzvkFwFVa3RztSbnJ8wukcqYRImSTpd0BCweb?=
 =?us-ascii?Q?JZa3XOb4CemgJte0uZiesZ59Dsm4nO9v8tubOtl7WRErZlj52ornpIwhCkBA?=
 =?us-ascii?Q?l+d32IYoUE3HW9UhDbIET2/907ehoBCr0Nqo/1kfYC3siNiOoi0b6tGyrVs5?=
 =?us-ascii?Q?u749oHlcBuNEtGEKLueKR/NZk8T6pbV17Eo+JHm52HIbqd0JTaFNmiTz+rwu?=
 =?us-ascii?Q?PAvIqmPi4NZYSwmC25XPbMiaAFd1jytYJZ3PX3hycg+r/nwQkRilh9lqGgT6?=
 =?us-ascii?Q?D1dEEAmwvWK/f8lNF3INBqs7LfHFByXuSlvEQFOdCWEr96vLH3WBKE88Sujy?=
 =?us-ascii?Q?x8kloJyoI+JaVcZLoXTjgheR/mSGds6zXJP+Xe2X0YzkIlV4yYZoSyGZ6cOW?=
 =?us-ascii?Q?6XYZK7h0N5vAAx0vkONX6Aj5t5IPlS4ojdy0J24hSrLFXSgCRve3VWLIsT7D?=
 =?us-ascii?Q?s8QbtvCLP4K6h12CUhf5zXWSjIJf5o7HdgxuQ9NBs3EbGsnkmy+cyNrzeWKq?=
 =?us-ascii?Q?PgJ+JyWcbM5Vmw3jVDBrSiLbWgsVK74WxJdoo3GiLJ0WupG+fRRe9tTTAgvF?=
 =?us-ascii?Q?oePi2rn0RSqHZ8wnprUcY1BOU9Yzs8o3oB3cCbYYGU8s1tKQWTk7nUT1CEkz?=
 =?us-ascii?Q?Yl8799uiQ6OCx1665Et4oFKfNwrmvFoF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:13:44.0403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3502169-bc54-4f93-557e-08dce184008e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307

From: Ravikanth Tuniki <ravikanth.tuniki@amd.com>

Add missing reg minItems as based on current binding document
only ethernet MAC IO space is a supported configuration.

There is a bug in schema, current examples contain 64-bit
addressing as well as 32-bit addressing. The schema validation
does pass incidentally considering one 64-bit reg address as
two 32-bit reg address entries. If we change axi_ethernet_eth1
example node reg addressing to 32-bit schema validation reports:

Documentation/devicetree/bindings/net/xlnx,axi-ethernet.example.dtb:
ethernet@40000000: reg: [[1073741824, 262144]] is too short

To fix it add missing reg minItems constraints and to make things clearer
stick to 32-bit addressing in examples.

Fixes: cbb1ca6d5f9a ("dt-bindings: net: xlnx,axi-ethernet: convert bindings document to yaml")
Signed-off-by: Ravikanth Tuniki <ravikanth.tuniki@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
index bbe89ea9590c..e95c21628281 100644
--- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
@@ -34,6 +34,7 @@ properties:
       and length of the AXI DMA controller IO space, unless
       axistream-connected is specified, in which case the reg
       attribute of the node referenced by it is used.
+    minItems: 1
     maxItems: 2
 
   interrupts:
@@ -181,7 +182,7 @@ examples:
         clock-names = "s_axi_lite_clk", "axis_clk", "ref_clk", "mgt_clk";
         clocks = <&axi_clk>, <&axi_clk>, <&pl_enet_ref_clk>, <&mgt_clk>;
         phy-mode = "mii";
-        reg = <0x00 0x40000000 0x00 0x40000>;
+        reg = <0x40000000 0x40000>;
         xlnx,rxcsum = <0x2>;
         xlnx,rxmem = <0x800>;
         xlnx,txcsum = <0x2>;

base-commit: d505d3593b52b6c43507f119572409087416ba28
-- 
2.34.1


