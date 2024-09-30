Return-Path: <netdev+bounces-130561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A0D98AD86
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A552831B8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA08B19DF4F;
	Mon, 30 Sep 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YsKjSGxW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE914F9D9;
	Mon, 30 Sep 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726154; cv=fail; b=fKRZaMDQFQO+ExpGwhJF24SZc8l42ig8mdjvws3sFwLM5XlrKwY1MEjaVcbkbMdHU2uDdVsLHPmhYffu10fecYf47xPTnEe83E7HbyjH6IMRbiRl0y5qst7C2P3bb3wpidNaW3di1nhis6osoQtwoFKxFIXkoBr4EpG0I87az0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726154; c=relaxed/simple;
	bh=R6Uq7+CFzbhLolBqWPvnKXpEQqiX2oQHfdUsXNFWxxQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UOdstjqCbQP7uuDbrhZSeYlDZef7yI34YJD4o0cikCxRiC7LQeZtFhZGhq7iuAKvDOd02BpBmn9HBZhI0dajtkhw/MgyhCl11JsujbmYgg8ZVA/VckGiigqhrAYrRbellndUh19rC/i6M3Z7VkLjZJbdYaKhWpEB6cLcIIcx8Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YsKjSGxW; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1DINH1+cv+v7vJmO4mTFC3OHt3koi0Cs5UoDH0BXMB73PhKmDkq+8CwpA1i50O6b4CDgxS43VTWtzb7Zcm7gbGyUljpeZKBb/VUO9ABRM5lS7w3cZGd4ybAo78KUmVmRySXHUE02GszjUxpZCudOgUvpZ4UqfY1xmz2vxoEdm/1R03MJKcFkycrATSwofwWq4n+zCak+zkNi3SpX/EtMslxdj8RXOUlI2UqzXsOM2+enlLPgvx/F7E/QhsQ70rP9Wa/RMpRYvuHJ48jsHzQNu3PM+KaE2Pz9JcMU5GMW7AH9ACUth7mMVkhZHYfdxb+SsIFvGZdoNO+iUQQR4qbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xspMVEAEBOvRPsdpc9c6z7yIX9cNvcd2ONPDD8xT+H8=;
 b=bBXq1CGy7YnHRxB+qdhs0LJ4lPvNXbzAxz9aRLvM7ddDfTfLPuxIVHv2+k6qqfHeFiGAekaEBaE0zqUkfjVSrlKw9DY8sCw2eEvV0EqXitTIUR5OlZhsDs0fIkiK+UjSfmNTE9HiPbDdPbLfbPEilSeXhH5ajFFcnC0anSAb8nNPEAdkZhZIx0cJVZlT7q+m3whqrIDHxRPhwfTTHHihdKdelb07mpdhzs9BsWMttZYTDguSfD0MOwonggStjjok6PLKoLyDTwkbIrlnTC4b6+dQ5oC7kceGVwK1d7HeS4qY5KKuJjpuRUpLxV0KmDdzHQgTiYE01iUDycscay8QUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xspMVEAEBOvRPsdpc9c6z7yIX9cNvcd2ONPDD8xT+H8=;
 b=YsKjSGxW/D8bSqQ5F1/20alLmF7BUUQB5YkepR/jjdlj/oCBSz/Fsy3lZRaB6OAjFd0hz6MPMvmtdn1PXB5DaEdBTbccnRwjPpssTSZQsDEHDXl4Vs9ByqkSeR7v1ZEU9Z3OjQ1ZukBKQBYZQbhvaQ9xvmFyYAS4zR+393llkc4=
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 19:55:50 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::8) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 19:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 19:55:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 14:55:47 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 14:55:42 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>,
	<abin.joseph@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<elfring@users.sourceforge.net>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>
Subject: [PATCH net-next 0/3] net: xilinx: emaclite: Adopt clock support
Date: Tue, 1 Oct 2024 01:25:35 +0530
Message-ID: <1727726138-2203615-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 920b9578-35c8-4db2-486b-08dce189e17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cwlbwm3r3+MsPONA+cQbj1SvbJXbsazkhXwnsidSOtUMgQjb7X9sSBbhphqs?=
 =?us-ascii?Q?rLzkmkV/FnJH6TcnZ2z/R5VY04kUglupbuwXEYsMdO7b7iugXzLYuPlhLgmB?=
 =?us-ascii?Q?+eCcH5pdaDzpoHGMvl4CWvOLxf2NRWldEWaE9L/U2gF5eGDJPHMlBD0M/8DF?=
 =?us-ascii?Q?H+lzbnQB8w7AsA7hcgCQD6u9642RuAsNOfR6at7cwGGsLXoIBpREnOtPSd4v?=
 =?us-ascii?Q?R4zn2BBR1cfQhaU3YnBDvJIGyJ9XQLIffGou7VXpHjjFbS3p/8jQRdJ9HIXl?=
 =?us-ascii?Q?WhdiAFxXT11O7gTorJ/KXGOdn+3i5ko+fiznqmz6AXarGSS0LWDqpuBY4t7i?=
 =?us-ascii?Q?poD75vbkVHfxQFwzpvv6qhvOKoGHZc5w+NZ+lXZucIfd3ZsuwkmTgUN56UmQ?=
 =?us-ascii?Q?O35izLfhLKhYHN3EGQuIiwLbviLR4Br6m+Itlr1OhmzkfagoRSqw3ObxlW/2?=
 =?us-ascii?Q?VlhnaGs7HTVLkU5aKEIkg3EJ66fz25mKOOaHn0U58v9c/drV04yn2hqvBh39?=
 =?us-ascii?Q?8BtHOaMeryl6We4UGNtF5lCa760DTJ4RUZEESF5eguzKYLwtDgjnR8nsdXtT?=
 =?us-ascii?Q?RDzzwC956nEvmgkQ+aqcUc4Ii5ySoDO9kCXRgGU4Ya5ybBzjJfDNB1Z/3Cl3?=
 =?us-ascii?Q?i37CEFwfcpjzzr7jbN66WfxkfMiOWgxI1T9K/GqUMS+W3T24iGkN7iwULgZ8?=
 =?us-ascii?Q?8fTmumgijltP1BlfEKGgO07BTLVNLuB7nZ+YobsdKZ1ireKYQzHGivWvp4fS?=
 =?us-ascii?Q?KMjco5yqQTSc3kJXvBcqMJU1iIHdLhBDW5TjsdrS1uuqTHQPmPTv048ht2SD?=
 =?us-ascii?Q?kaxntijg9gCv8lYM2hDx/tsjjqxuxmRzB/3oGVqz/WkH7mZSjjllu6vCCPAV?=
 =?us-ascii?Q?CVFFgk0fKIdfbNRSzILraSZf+1xbV104djP9Js9qPp9wCwY+FSAM41c2vgwL?=
 =?us-ascii?Q?CNqfeulToVv+1D0RBif7tjAaRaFbzk7Go9g8NZ5GHcfd5R3kScAJqO1DezWd?=
 =?us-ascii?Q?pvYLRL1EWYACXan7krUS9FveYQx1SzYp5uQeSyDFv/dLDLXjIjHx+bwdIo1h?=
 =?us-ascii?Q?vwvgGRFWw2GTO/qCqrpwtRFNHsZ0wc0NQ3lPVPe+iUlsdgsYUaMykjpltNp3?=
 =?us-ascii?Q?PoyDk7gFwqDZYSku0CXIi7WX2NRqZYjeyOmPCR3NEL5JDdYZ8uLV2MX6jbAT?=
 =?us-ascii?Q?44TRfQrmiFXgTP/kQwAo2AMH6VBj3MmT12H4NSP8VrVYJnZ98lewh4WsN5QV?=
 =?us-ascii?Q?suj/tqGtoUfDfS7b4ep8ECBHgb40VDJkbfmdoDxt4LeZ0akC3R3s9zPj2p+a?=
 =?us-ascii?Q?bXm38zDUafh1LCx1/qdf6UKw8vzjQ5whM8hH4pvFNjltuG8Pbc+sgiNMVVJa?=
 =?us-ascii?Q?d3bjo7OuaUIpW6qbHFEZVNAvRxdL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:55:48.8905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 920b9578-35c8-4db2-486b-08dce189e17e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600

This patchset adds emaclite clock support. AXI Ethernet Lite IP can also
be used on SoC platforms like Zynq UltraScale+ MPSoC which combines
powerful processing system (PS) and user-programmable logic (PL) into
the same device. On these platforms it is mandatory to explicitly enable
IP clocks for proper functionality.

Abin Joseph (3):
  dt-bindings: net: emaclite: Add clock support
  net: emaclite: Replace alloc_etherdev() with devm_alloc_etherdev()
  net: emaclite: Adopt clock support

 .../bindings/net/xlnx,emaclite.yaml           |  3 +++
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 22 ++++++++++---------
 2 files changed, 15 insertions(+), 10 deletions(-)


base-commit: c824deb1a89755f70156b5cdaf569fca80698719
-- 
2.34.1


