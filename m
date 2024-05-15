Return-Path: <netdev+bounces-96503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3538E8C640B
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5226A1C21660
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF0558ADD;
	Wed, 15 May 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bYxz81K1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE73B78D;
	Wed, 15 May 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766417; cv=fail; b=MtDg9+qa3mRfHN3eixrTkS+tzx74nLpnUhHKYDa4cdKJxnvrwEVMyidSfA3cdTHwWy1xREcb2eOBOXaPvwOOwsggJ9lzeyhw7+Qeuuy5o/C3W6PP72M4Rv4zLJejc53Hp1zEKXSzOEdrAiNZlIhwH6/6Czoyl/Vsm8ENNO7SNEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766417; c=relaxed/simple;
	bh=/SMfR4fnkdp/f9i7NR/yrkyMB/sKP2Cb78IzFVmAiwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o1DnMrtHzNWxV3N2B8DGeejEACtipi/vRNiQjdh1Y1XkxmUsrxVGmwfCcUbrgVYvmBCn+VnpGu+bFoqcGF8ZcCWZEsAaf++gSQPtef849RlFaL16V/5ENeR1+PzYorfdGvTAx+i3MgdKZUzLxAu9coS1RcLuPMIOmGsRa/gfaKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bYxz81K1; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXST0wmAfSz+9Fc4Vn+lv+wzlyD9g0NT5SDGvbWYPNOUUNLpmrvxB3Llaemji7GR5ZSX2cNl44viMRh12IV5q4WYuj0/7G6JlX+b6Cs1J6HqmOKx9ZMAGfax9mSHlpM4TJ102+xRBIFXpcvZpih5gzldnyHGIthRpyyBrk90FA17nUHO3Wi5rBQ+Rxz8B6/6SBXVYnID/ZCaCczRYpULqZqvkw/azDaRMXZ3nAlcP3SqFwrDmydM6QYwrxJPNr/2N7On+jTkjCaukjIz9aVN7rMLJAZtVpnzjeNZo10xEK/nCY/S4VoQmUupiSxxYpD3MR6mOgcRDnxQbt008dQ6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJP9NarNRJnvvqeqocTP8LModWICrQTE61M+XYYHRmM=;
 b=HL+EF8jAIdwkUhDeUuvcSybL5Yeunenoru5CVBqZbbt/Azx/ZbUz5mW3mmKt18JRyqqPHsO6bc6wMzp/zfcU6Gl3J/NDUla5DI5utYmWvYHEh7X5urXS1LpdFP+359IrscQC0JF+Qcid0EjvAZffoRUhZDaYXf/rhucwpRPwUNuK1Hvxyk5SDqYjEeNNfPQBj6uUBYxh5K/hl8MIlj7Bs0z/AWr9QY+F1chsLfjsY2U/z0Yi/8GIh/sCC8qy6tuKtYNNrmlEQoNM65dHu70uQPQu1+Cz3nudNlbiWXwf266gOnmtcEqPn3g1IgARGgvweacC4X+G2Klighg168Agug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJP9NarNRJnvvqeqocTP8LModWICrQTE61M+XYYHRmM=;
 b=bYxz81K1DZnPohAik33ogNhhzkCBJQ3rQWIoaUJjKAqKZFOFWSMW0OAeMY3jN/Ze7cMqggFadLmhd5kpc/QjEXIaC0vxaA5ers4WkIQYyYUgJG9sTUns5K88ATrHcBWHkvE1mSJX1V2/CF2EBJzAGv6jnLyWR+C6hWouL5e9Vcc=
Received: from BYAPR02CA0031.namprd02.prod.outlook.com (2603:10b6:a02:ee::44)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Wed, 15 May 2024 09:46:52 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::75) by BYAPR02CA0031.outlook.office365.com
 (2603:10b6:a02:ee::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Wed, 15 May 2024 09:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 09:46:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 04:46:50 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 04:46:46 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <harini.katakam@amd.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<michal.simek@amd.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATH net-next 0/2] net: xilinx_gmii2rgmii: Add clock support.
Date: Wed, 15 May 2024 15:16:43 +0530
Message-ID: <20240515094645.3691877-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 17371fcc-b0e5-4a49-6f2c-08dc74c3f2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|36860700004|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9qfdBG5AN3m06bjCwjuItvUfQBaonveRTlS3pqiFHhZNOGokt0gCoaT7uVNw?=
 =?us-ascii?Q?IURJ5mKBmHqoLKpDi0nAXZnAYBsUKtSGzTDldpwhMLHkATnM1/Wa1w9UaRQb?=
 =?us-ascii?Q?jc12MjBZEQlWws1DNvCgSJiLh+NOPm/Ko/oVpEliqSEuHIxWpiw+3qNLdB76?=
 =?us-ascii?Q?jvItz4VZFf2Vj2C865OxlBmr1notuMuIYx9FqzSxvqw6FMmgbFHGO/vt1Tms?=
 =?us-ascii?Q?wvXC1MLt5UNKtX+HFEfL546E7AGBJy2cmPgla9T/vkdN+pA8TTovSVDap2uf?=
 =?us-ascii?Q?K3kwL8OZToTd+5/W15zu8znTslBCRtNl3srFeX90HH7TbE+d4eYREOvmWP6Z?=
 =?us-ascii?Q?jl26IKjd0lg1VZwCdUl1gCsml+eL7WaurtjFjBYMjlmRkfvmCu4kZrve8/z7?=
 =?us-ascii?Q?GUzYKZ4rxbnhEEtm2j2UrO2pgA4tjo0CaJO3vHiL1aS/QNXIs2gO5YvBF5Lp?=
 =?us-ascii?Q?eVF44qDZzQMeKpwLCB0ONxB5vzub9f0hailLe2DP8DrkXBbVhCY9KfjJO0Wd?=
 =?us-ascii?Q?AqhPSZ53m4pbXYBsaZqEhNMenqviwE6xueuVJC9WiRw5g0o1STTPl/Bq3F92?=
 =?us-ascii?Q?RMpgs52wLHkyeieACn00JKyAHMD2i1V4MWBpHIcBhUNEiBLsiR0lQZDh4N2c?=
 =?us-ascii?Q?26TUBgkzd8PtGXtlqULUQhhMbuJv771mpU8J0ink3RGQ5Hgap1vsc80FFEgm?=
 =?us-ascii?Q?teCkU+j+/CUkAeblAaOCQmiQD80fpO/38mWV4uMENmRIv7t/YQq5EslYVDou?=
 =?us-ascii?Q?flLDsT5ot7weC0v8Scsc1/Eos6DSf22Czo79zR4z2gUqOUN25GKzL3DX92Es?=
 =?us-ascii?Q?MKZV/uV4zwmI9MYOHfnisRvyhJFVhNDoHqtjwNGi7YDdoP4wzHaMh5Fbs74R?=
 =?us-ascii?Q?myjYCgvaEwRywh1mbAOy+V60vIsAt67tgE+cU5ldDymeowxnCh10fFiLOZ1W?=
 =?us-ascii?Q?1/csR68GrbxC0r8hrva43nMfs2PeK0Vwo9Jyxhf0JDW+2l/P3bk7ThOK6CrH?=
 =?us-ascii?Q?EFjwOnNZqHQzfKbVlPR/H7vt8i6MwCqWhDp9qJCWHv8GhHyZDtwpzSHW+LEW?=
 =?us-ascii?Q?YZtH4TLjjpfwnPiMWevzxi3hTtELGopOSV4qS/+bSnqvcMvsl9V4a9jJF8H+?=
 =?us-ascii?Q?sxBuMq559jCsgw1NDd5t671QvxO//pcgbIIJXvRCNI325WqFRL5bPsV2fs0x?=
 =?us-ascii?Q?iWrVUqGrXoigQo1K8CLhx37rsQGxY9jRW4WOXWTF0sxrXqe1a2gb70h26Ic5?=
 =?us-ascii?Q?UnBzjDrmtwjroaFUbfNtgdMBQp4THn6rivZwwyDt5CHsSEbsoHv6+q214XYd?=
 =?us-ascii?Q?05g0MgdQRSBnjVFQ5Ko/lBPBdbSNByr6hW8H9GrrY4Lbe8wB92lAwtp0Wb1a?=
 =?us-ascii?Q?SYE3Got9vC5nkjy7HrYIM/ufeESy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(36860700004)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 09:46:51.6472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17371fcc-b0e5-4a49-6f2c-08dc74c3f2a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

Add input clock support to gmii_to_rgmii IP.
Add "clocks" and "clock_names" bindings, "clkin" is the input clock name.

Vineeth Karumanchi (2):
  dt-bindings: net: xilinx_gmii2rgmii: Add clock support
  net: phy: xilinx-gmii2rgmii: Adopt clock support

 .../devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml      | 9 +++++++++
 drivers/net/phy/xilinx_gmii2rgmii.c                      | 7 +++++++
 2 files changed, 16 insertions(+)

-- 
2.34.1


