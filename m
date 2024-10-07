Return-Path: <netdev+bounces-132758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 711929930A1
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEDF1C22D44
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EF01D8E09;
	Mon,  7 Oct 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U05b0bqV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6A1D8A06;
	Mon,  7 Oct 2024 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313591; cv=fail; b=X5TXesxnzAhWKfXMDP47KvwDYUXxYb5V224Vx+aMg/C7YlD6hC84xlrIK1N/vbhDRK1Te+Egvt1fzjqNAJPAZidWb8DOEsBqA/kAT3doDSDd+rU8R923ANrQMM4JoHp8e+5Sk9OLbxVMWDL6LAaMe7CFV3w/lHD0hwhLpN7kOQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313591; c=relaxed/simple;
	bh=0wedgcbvDNzSv6/UguL1supzKNnz/okCj6qpElhr2oM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cSgVvO2BdNCz0C6MNrQeOT/vP7MS/0RzXDY9fi+QSXm2U7IfIatttYXZcUHm3ZRyysIjIEXE6/A21QRhcz66762s1zVmKPAsqPM2ed9+QQG1SIqU/8dgl7MCVNKrdrl0wvPZR5rXfzJ3r2vxtBBdgnGN1k5LhER2onjdbrqFkNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U05b0bqV; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IET5aVBijV9qB2NRmA4h+kPjXnh8ykta087p2FnooabM9bZinj/snSSDHlZMI22shj1nkwflOm9BelajsasuKPLtqldCup/FERrEQVeYxy/0FE0i+YACPR6UOnKDdyzkpU+66S9k4YxJGFx8lXkGLLOzqRwG8y5KeVl3SP5+uzNJh2pOe04AeYATS7PFcundkr53Tqf2Nl368ejz8FhO99Jfvq427A+xZWopSI7pXD7GlAErBvXtUWq1kVse8DKSIkFq36Jui4CBPqvF2gRShKcyNNa5QjZU4jMH24fFRIvYuikzzKXQJzaQVQFGMum2Nip9hf1sgG9h9vLovmzgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQdORdduLhnZfjT1P0pddrNbfBct02jEvbe5kkfFYg4=;
 b=hVPIyUrcmz+x0tL/Ry80DAyCzejlvyODT8QUxukwGV4HACdu3C5T9JQyyzOfMWexFYhtef95Ra7jrpd6UHzm4p+8RJCEcYkf7dYEvi3dpFp2+Bn5AUAZG56dzDLKz5H2T43hxTBlGZa06P3EGENakUwcTpIK5kiyVejx/N4ywhZ3Vn47EPq5Y5IT4k1a2gh31h7W7bXsdrJg+qZ/u6ZF8I8MDaCXT72DLDAt+2+1Hc3c2LgGTHBKA0inAvHpO9xX1pINUgrDhhKUxiBvFyVu7IOzQ21UBoslxbmo26QsBUoElZvhv3Pscd0gmz7RPIL7CgxwZctdYJqL2U4IXaSs1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQdORdduLhnZfjT1P0pddrNbfBct02jEvbe5kkfFYg4=;
 b=U05b0bqVNDCcO1u7pYET/1NobyDfBi+PGalvezZqzWs9YW6HXwIwJquSLSD4h/QwYg0bMojJWsD4EKpKpFaMaprvVE8r4OqC7bvKoEG+gRW46I61qwOlWOSX+JZOVm1L1zB7B0vuVH6Wq5MDOWIRvHnjH4irdhrzKoyMzO0qUfs=
Received: from SN7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::26)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 15:06:23 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::2a) by SN7P220CA0021.outlook.office365.com
 (2603:10b6:806:123::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 15:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 15:06:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 10:06:19 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 10:06:15 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v2 0/3] net: xilinx: emaclite: Adopt clock support
Date: Mon, 7 Oct 2024 20:36:00 +0530
Message-ID: <1728313563-722267-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9168e0-8056-4f07-5610-08dce6e19b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rShp2/54Oh+gwbSI0sVtWfS0dCgeG83l1U4WyhDHDtVC70TAR2bEs0aceiNR?=
 =?us-ascii?Q?ItuPwisODzHu1zichkpQZpMF9QhL+3wU22dv5UCIUaix7ontfMBqupnywTFw?=
 =?us-ascii?Q?l/YaVrwg4aKxFTr2KhodrKzTLtkdsnKDShqNNHEElR4vXmEmCzH3wGAllQzF?=
 =?us-ascii?Q?zS1sI9YpaazzMg+1YG+SnXkwoDQTbCAsUCjNiAHV6wKDSfI6m3CHnRK8r66+?=
 =?us-ascii?Q?jig5DfdON01J0sReV8lgjEv+03hALoCayYspqxZVGhLIh6nNeo83oOoD/8AT?=
 =?us-ascii?Q?TBk26DZgDG8wm+PtM/B3spuegZdIVBGhy3oHwfm6CcmZBnqp7s5Fnbao7C6h?=
 =?us-ascii?Q?093FUZ/NwMmjzxCKC7OtAKZjoElix1ftsFJIZVSnA6eMMAhwu9Fgjhes516Z?=
 =?us-ascii?Q?BgLta3TK0LLfu+veBDIzLnkXJzV+YVdGxsY7SZTih7LcoApcLTCyStLFItVm?=
 =?us-ascii?Q?freY3E8WgfIjCZtaiTOCe0cZZASB9AyFiT+2wcXW6r8hb1feI6iTw5txuTY1?=
 =?us-ascii?Q?XUoxIE4b0V3UHrR6Ul6XaEVTpYWl5ggGOtSyPuCimE/4yVQ/z+lrvORPCHNs?=
 =?us-ascii?Q?7ZW1Vh89HGxsBVSxfg4BMsaT2w4Ik4P2qaJXvo9SqNUg7HxBR+TohXqSKhOE?=
 =?us-ascii?Q?ZDiHHu9OoNWo30E93ndGA6TjmA+zcKhVEOhpDlk9ur9gSWy/aexY06lBuveu?=
 =?us-ascii?Q?zkZ8/OoWKEic5vd+DWcG+8L+A7okMBaciNtfyv1HVXfWAB/yAtH3ScWkJKTe?=
 =?us-ascii?Q?TmyFa6rzUMMOkQuIhQFFxBm/3IzTLPmImG9HAZxAcj2pBzXH8+vl3YIBRFSU?=
 =?us-ascii?Q?NwOEQYLCbxPNkBqqD6MufbcsaJt5xMZV7kb+9MXHR3XwmwgCkPqAPZy9Qdzv?=
 =?us-ascii?Q?ShBvvmWmfEVE2lTW6Nk8TdWloSREIkffS2inmdjnQq78F7jrfVXnTVrB0+xX?=
 =?us-ascii?Q?45+MwpbawXjwnskuTpoWaxvJIaF2kI/5aVpDDqhXtsnQMuDpYjs9+u6Hxsu7?=
 =?us-ascii?Q?n4Fy7FVDmL3jZWslTBb2ay0A5mbSdkBeUKkKqxv7tr47Hs6ZkunWf2o7hlpO?=
 =?us-ascii?Q?PGQ1je93UZ34I/I7Q/++vJSkET/JYvZOlqH3GlJACy2Mac5SPM+hyMZXufpU?=
 =?us-ascii?Q?NsFV9wkluWBGgqSoSnFdKfSWbfjQEEMEaqaQp1q+Jwk0UJznvbOPYZTsGbt6?=
 =?us-ascii?Q?tmtSnAaF9O32WIizIzMNozUEqLflup823+uXLUaZZt//aWku6l6tGaonqa/c?=
 =?us-ascii?Q?9RScBs+tCY7qa5tD4r+rbnOIVEUAC1Ar2AgOztUatgb1DoRCY9nXhQRsU7Dw?=
 =?us-ascii?Q?Sk4dmP6zCUVE812zKcj3UeNcJvM9eyAFLM5+7aiinmqV/hXLES2xpcG9XYCI?=
 =?us-ascii?Q?77Jni5+qPmaYarMgfu9r1djIGcp9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:06:22.5283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9168e0-8056-4f07-5610-08dce6e19b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750

This patchset adds emaclite clock support. AXI Ethernet Lite IP can also
be used on SoC platforms like Zynq UltraScale+ MPSoC which combines
powerful processing system (PS) and user-programmable logic (PL) into
the same device. On these platforms it is mandatory to explicitly enable
IP clocks for proper functionality.

Changes for v2:
- Make clocks as required property.


Abin Joseph (3):
  dt-bindings: net: emaclite: Add clock support
  net: emaclite: Replace alloc_etherdev() with devm_alloc_etherdev()
  net: emaclite: Adopt clock support

 .../bindings/net/xlnx,emaclite.yaml           |  5 +++++
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 22 ++++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.34.1


