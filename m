Return-Path: <netdev+bounces-133445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D233B995F05
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55AB31F2577A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 05:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C40215FD01;
	Wed,  9 Oct 2024 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zWbzOzPE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC1156242;
	Wed,  9 Oct 2024 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452399; cv=fail; b=GF0+CdEzjH7TmzN405MzlYie4AHDQ38QkoGB+pYOiBQcxmxnFJ1YTv8tvxWKmbEGiDDeZ+LCyccEagArJ4sLc0CFGixKXk65EYx8CN2CoIPxuV8llxSH+EYLNKC/SS/NotKTvBUEO7fxo3ilN0JpFxb/gmx99U94Z07I7ff5xnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452399; c=relaxed/simple;
	bh=QjymJCAoSY0HiRLhIl3lrphjATOlJxyKO9znTmWZzg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hbsuw4ihqWRg/CH/dv0sYGXMrYbAtG/vLTrAjCRfQgw7Z8ZOvlv4SY/cWl8owiDkBlxjkPLPxfW/kizvN4TWSsVgC6pGOqG/bbhNudRnmu358soR9gf073RxA/n3sUnudbvdHXDDcoOk4ASX8OsWYi8f7N0JYlprFM/tfNP+CMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zWbzOzPE; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2915e5pklzH56rK/+lKtsgcD85zSwkxYJLzEB6aq+8tD7Cy97BMqZ1JoJteRBBz/Ky99RhoTRHlCeurmAtf0NeRjFceR4I7anRG5kv9RjcVQWJH8fFGgY+a6LNUFVYzrSg5YvAABK50xgPYmeUI08edI1ZxKRZQnRTEzK6Ha2Z4FGC/kOV8TB0le3o4XSos7YsilmAm7+RPx+QnU/tSXfZC2o38f69jnEfhBrJuCNnT23Ml6DBWdyv2/fQX1hiu5jTL/mOZ8cgDeWgwWTD29INsyL/8R1V6a1yqKJi1X6w7KR8C04iV/YrbnMnGsl0x71DxXJxmig3VkQgPm2/XMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwPOf8LNuss9/YlEeBFBch5+GpuVfatXcAJysv1v7Vk=;
 b=Q/B5MJGGDBqfN8oKNKEu5PvtvtFfZSI056977cMmdAlPeAIFsbzsYbkgGIbnOXghhvWWPbbxGY0LRrqCdlRyu6ENsnMWJELwZLEKBkUqiLFuvzCjs33qtYAZjs5cZfmC6MxZDBXGdEz9KvG1sOZYAt1FFJqNP+F3KPmt1CEpMC9kti57uPYKBPTpWkREtfxCLQj3VfItWHzY2w62jakIF2dd7LoXnwlOeG8A55oo7l7SHY/DGN6OXMsdf63W9i0mhr3a5s0KZU48z81OOMM8ebRf23ntjOhaPw+Evq7/WayEYY3QS/sAFzM9FCk7LnBrMPjFZGiAnBIWkRXoxEOllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwPOf8LNuss9/YlEeBFBch5+GpuVfatXcAJysv1v7Vk=;
 b=zWbzOzPEr+RDvy2Q1iA7ZfLGDUtcaZOqlwdJ3+CS+AktkUduZnOoAcTxnJ1zV6cW0JpYRh2rMtOGINQbbP4rnr9MJP7pQn9BFZ1hJSVo+2TTXz5P7GY4teFBQBTEsdTueVnEUFSGhRG8P2xBbL38cw3wtjSu+o2JP+dFxUExQv0=
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 05:39:54 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9e) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 05:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 05:39:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:39:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:39:52 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 00:39:47 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [RFC PATCH net-next 0/5] net: macb: Add versal2 10GBE device support
Date: Wed, 9 Oct 2024 11:09:41 +0530
Message-ID: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e51b53-5bcb-4b4b-513f-08dce824cd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qdyIudWFnUcpxD6deFGkUO1pyPFJLHW5KxQ5HYVb9KyTW4IrgsElXWVqWr3d?=
 =?us-ascii?Q?gyEC5Za/zLwzbKCANSPiP/cQbkr8uOD89DWud6DbqtykaquJm5YPOjzl4lWb?=
 =?us-ascii?Q?q6JnM6ENBCy7W3DHFpkh15Jn/yvCiub2GeXCheH4VnhHl++0XaNViVnONgEO?=
 =?us-ascii?Q?eSbaa0v4odNGOT1uDQjY81wr1hnhMwBX/BiUEvPr9CYhdgQ4hId9hpkZlHDA?=
 =?us-ascii?Q?lJWEFqdBQN7jJE8ccFpWp0X/zuQpsNh849jksnBgS3xyIEcUPdvuIOCwvoAP?=
 =?us-ascii?Q?jh5Hu+YSpAvAd7+1njMy5VBmfM1fVy5ojuBwHsIQDL14LnrVEkaEYec7ivJX?=
 =?us-ascii?Q?lNK5kTsm7JmT3gIKTIH37OUl2Ex4/NN65fac5kbdc01Tgm3dpV63U9PMXqLS?=
 =?us-ascii?Q?fmBBodeRV8RVyT7u7VruFBtGzSENrvp4Rsns5O7uTk3PxpK5EEaELQ/Xuj29?=
 =?us-ascii?Q?H/lWCtRJUD4He8EctgVbPMCtyoQLIbDl4wClOhBcFwMEmv3l1u5bswEH/vuB?=
 =?us-ascii?Q?r8hkOUJBtaUQWKqzf0ajF+KByUwtrpFF4shiy7WuhqxKyfd6E0VGs1nKrlHe?=
 =?us-ascii?Q?zuSRKd24uRZiDfHKBcSSyxUEFwJ89lFDH9J4H2NBfysdYvbntxap2jsifq2c?=
 =?us-ascii?Q?H4o+c3EHqVXrF4Dz9Y4NVLcGok2apzV+0uzlWmH9JSkKc6kSI63EhIB02Ktk?=
 =?us-ascii?Q?97/bhUxBO6DvM8exLa2itVrVux2lRCSsWj6LRJolMVYEm6Udrsu4pj2ebuFE?=
 =?us-ascii?Q?htUt/DWuMO7kKOkxh3JpdtWCGlL3eixv4gGpBzzhW/TFAT+u5yo2+rU6bXmH?=
 =?us-ascii?Q?rURvfAfkSmErTqubz9rQ0QhxB5HbLSsFf6+0oPNhQOrB27ZDMMQPTv8nXaLX?=
 =?us-ascii?Q?CSOW954Xycb8IyV2yLbGPjYMyPXKYtFKqwHhMtMOtybi01ftLgBJ9x/fSET3?=
 =?us-ascii?Q?hVNd1l/TKnYWqWZV/7ZXRolGoGs0zNUy0HDbem2h3XI98tIKfaLLO+OjJIVv?=
 =?us-ascii?Q?f46lWjz/KMnzVNKlsRwStLH+UMKH3tIPTve4KnB5hX+3DviC2Nr/F6jTQ+/x?=
 =?us-ascii?Q?01m+laJEvGXGDgaLZIvRhKw7tOjOnyvVW8bIGhO7kmvUG8N45+lzgY3xyNrN?=
 =?us-ascii?Q?JXMLcwBoVeWzNhYg1OHyPDl0BoGkbbjsmgoHP8qkxMVHZwZgN9747I8Ql26C?=
 =?us-ascii?Q?5FHxNprm+WpS0u+V4eJkcj2eqsWVONXOWgINejYsOEaEgjBDjA1hHfuN5MVK?=
 =?us-ascii?Q?GUxfVL2OPfj/UIlli9PiWLEZSk0witOih5KGXRt8QRk/rYvNTFfMvg7FFfGZ?=
 =?us-ascii?Q?XEzIR8fhMV/b3/XGPe6eUG0HVahC9NFPeoRxJ91OZoPu6VfkeqLBFUkR7uew?=
 =?us-ascii?Q?kIbunjRBdEI8u0HtaxH+mVgbXOU6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 05:39:54.2108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e51b53-5bcb-4b4b-513f-08dce824cd79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

10GBE IP is a HighSpeed mac that supports 1G, 2.5G, 5G, and 10G speeds
and has two PCS. It has USX PCS for higher speed and SGMII PCS for
lower speed transmission.

Auto-neg is disabled for this IP in versal2 device, hence "fixed-link"
at the specified speed is used. It is an expansion of the fixed-line speed
at 10G currently being implemented. These modifications are tested using
a HW board configuration without a PHY with QSFP.

The IP contains MDIO lines, and the goal is to use auto-neg in the PHY
and set the agreed-upon speed in the MAC. These adjustments will be made
in the following phase after the extra hardware is available.

Vineeth Karumanchi (5):
  dt-bindings: net: macb: Add support for versal2 10gbe device
  net: macb: Add versal2 10GBE device support
  net: macb: Update USX_CONTROL reg's bitfields and constants.
  net: macb: Configure High Speed Mac for given speed.
  net: macb: Get speed and link status runtime.

 .../devicetree/bindings/net/cdns,macb.yaml    |  1 +
 drivers/net/ethernet/cadence/macb.h           | 13 +++
 drivers/net/ethernet/cadence/macb_main.c      | 84 +++++++++++++++----
 3 files changed, 84 insertions(+), 14 deletions(-)

-- 
2.34.1


