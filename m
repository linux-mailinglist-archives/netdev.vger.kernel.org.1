Return-Path: <netdev+bounces-126215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E699700CF
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C391F22C1C
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553351537CB;
	Sat,  7 Sep 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="js3R0YUD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FB156227;
	Sat,  7 Sep 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697179; cv=fail; b=R+1+AcR30Qwp1heYE251otZxqKovxquMcr9jAQBLIiFWJC6CEXGpvVTJK6Uo+zSIpHsat2KyliPpCAA4dV4dY3x8Z5mP5SnBoZj2RIGMWkw9m9yGaulTGgHHaK8VWbx/9uvxb2+BSGkOuvQpKlzgr2klqQQIQDp0sCSAQWfEsJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697179; c=relaxed/simple;
	bh=VtZYfQHONQby2EX07NAzcmrS8f8L2l7cBIJf+d1f9F8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcxIh0gz/JyvQLE/5PO9m4LHxb55r8Y1liandG0PlDqbXx15vRne5F+PkmKC4o9k/9k9by4TTC7A15xZN/iV10x2pGqWambYonSoUcSqktecu5xby6wQNWgsk69VYwWO08v6bQ4pj7jIIt8XqobvqQRtt5evf2/eRJuJ8GHand8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=js3R0YUD; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1YsBMaIgCjhO8TVJPCP5R8YhjB8g7+8v29uvNaMZt57LKCyEBGDOe+UX3EdjrxcoNBTV+ZKF2XcObRYVMSskWDYEyEbXrIMso1LtJljt0pTOHdNFtnvSrWQoiCG4lHbC//pnaiOfbmfg+gMtzuhVDKlYKNZm1icjPh14+cl171kUu1gRdI0U25IXm3WjL1bpYTGV8tIjvYtxb8Sj/IUZna8XmJAFduG+JWuqp3sN0c6Jw0KAATKexJK5RQm2zug53B1+pI+qchGrjmMnb0B7aowfnzOvRFLQ1aPKhSVb3o1akgf/pqN5Cre7QG4mr8PDY3bg98DxLahQwMyLnNlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt2g3tCIlrtoekwE4xpZtAtLk0JXgrvZINw8+ZTgNXM=;
 b=vA4NnSFWmT7IXfdp3PDkylLERXh/KAcJo9RenKdsKhMl7TeopuDSOUXXln3tIemEfVoR+Gz3J1349CjCkImGEStN9nyfMQW+CFhHdblD2ZAWRgpt22XEyiSRKweZ7KxgR9sWFu89qhDD5TYnyLxoOhN53dZ1KjxTM2wJOKxsHodpn6zEkgOmMrcVzOPjWEM8duQbkeLu1+BXJm7c3QXA1HcQy3duVyDQyoowAvo4xxN4rVS0fPqFB04P9Jn2TA/U5Bqwskbv25FTJd5Uw1gDh8NDREU5hLbFcOkH5kxADnKApXpAfA/bTxoHj7qb+zKRDd1aUr0Tm5NPUmsvUSQr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt2g3tCIlrtoekwE4xpZtAtLk0JXgrvZINw8+ZTgNXM=;
 b=js3R0YUDQdit0lL+OQm8sVmaN5mpy5AwucCpKlQPTaq2jDQLbj0IBFuAOqIRfQKCgwslb/wSs2Zfg3v+bVl3QRVNW/Zw0V60/OFIGr1hqXvL1KduW2+1kqbD9nJrBuS03p4IuRTn9Ijp0zicUJHh1e1Wz8i5mh0nsLXRPbrH6zU=
Received: from YQBP288CA0035.CANP288.PROD.OUTLOOK.COM (2603:10b6:c01:9d::12)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Sat, 7 Sep
 2024 08:19:32 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:c01:9d:cafe::23) by YQBP288CA0035.outlook.office365.com
 (2603:10b6:c01:9d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.18 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:31 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:30 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 07/20] cxl: harden resource_contains checks to handle zero size resources
Date: Sat, 7 Sep 2024 09:18:23 +0100
Message-ID: <20240907081836.5801-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b746882-f007-43ef-93f0-08dccf15ccf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hOrotJL/fBLEDr3FNrt8cWmVKwvrowp+N24URbl3NJkn9v8TkW2g0jLfG4Cy?=
 =?us-ascii?Q?uuFFeUdQ1lR8wTcMiM9RkYCBA6kBje5+E6uMDNWqEaGC7Zms5Y9j3OmWqF55?=
 =?us-ascii?Q?pdgWaTmdl1Re9t6N+plvUcRHLjCDUoDmJx0LylVkHMQBclM31KVp6zS8WotX?=
 =?us-ascii?Q?8oEClfwTuVqdLGL1/rCCnENPssXYmP58XqtqPqRG80YFpZHCqIeQWYcf0w3v?=
 =?us-ascii?Q?SyF5kAKh3esA6+/T0UOFu//ISRcysRpy9uyswXPVowH9Oj31aDUg3ZFomjNc?=
 =?us-ascii?Q?QoN48qo5XDMePXm3ODn7JLkQjFAU2oDsgHNbu10HvPgw6hDWNLChHwj/yZsi?=
 =?us-ascii?Q?yBfU0n18StAHrAjZ3CKkSk1LoMW5MKJ/xZ2kw04ScXHeU225i1eack0qo2qe?=
 =?us-ascii?Q?IRHeTM9mx1qQivPVFVwm2Le4P4p/0NpuPTH9WvxORYgnqdNR0ik3fg7O1lyt?=
 =?us-ascii?Q?I41NTnES1soa6PZfVVp0Ck4tu07F5pVEE6zH587WLDjel/G1nHkOxERlML4V?=
 =?us-ascii?Q?m4cqf9c53ECMk0Uzuaq4tJUyx171Zf0zLbgNEUOTWPDloRQyiWzHIfg4zs3W?=
 =?us-ascii?Q?Mcy0riCmWACDDid4ncY55mNalmE8R/oQJXNsPjtVOdv8IwN5AGVUjMCYMric?=
 =?us-ascii?Q?FkK9wiDUFAg/kcaFTjNjs99RAmT3Iud42nVgsP473h0yzgi1oJWTyfyuqAMK?=
 =?us-ascii?Q?c+b/bMtlLooOzGmrWEf1B2lCNS/KtFAmuHNhDPpgqhBHCN9kagceJGThxgw0?=
 =?us-ascii?Q?f1NEOvteVdL1B5wS84gnU60DtPcDDziLc4lRX3qYkEQmJae5EEV7vkPcFiP/?=
 =?us-ascii?Q?MoEz596A3AqEgBdltp9cYGNLUCYFOWs7E1XZLtMNZHTNuMPVPAPI9bhCvsQ9?=
 =?us-ascii?Q?VJ0g0hudgVCA2sNUagKEw43OLZBT1UzeElrlLjig9dA1yXnjzXhHD8AC7l+R?=
 =?us-ascii?Q?UjCpLP40dPjWQjeUIk/fCtLNuz93mZ9s8zsh7m4UqrX3AzbBVjCxNC5n+z44?=
 =?us-ascii?Q?34SmHToOjUYptMMbNPgZUH8cwOfSuChWu8al8fjGbLNoZsfSDPUC0cSkN0eS?=
 =?us-ascii?Q?zevqSwpSjHpSyJiCc3WyXnAeuMDOrkojNRMwRXSPwsQnSQlP+lJI49hka3vy?=
 =?us-ascii?Q?MsrC6VpM8fjZCrpy42ia8MdTCPvKpL6ZCmQ5nz/s8zDxktfaDhDWYCjp/fUX?=
 =?us-ascii?Q?g3wxLz00hxcoa5g9HEEb7cyWHiXLjXIXUuP7wD1jUjM13Y4L5LvF5l9oq2aL?=
 =?us-ascii?Q?9NZoDU260Amtw6T0cqoNFOYwYBqzhQ3BoMsy0rtjVs4FL5Bnf5g58GBh1ixq?=
 =?us-ascii?Q?RwayOislX805AN0bZiMAsNnpfg4ZomSzjJJqZnzDPKxTupQLAXjPW7RsKgrK?=
 =?us-ascii?Q?NGnLWzEQ1X8jROF/Xfi+Xbaf9C2GiiNU8sgdh04sgQObWPtzrAMJS5FpJ33T?=
 =?us-ascii?Q?oqMfUMOYoZ5TMrtXxdWd45oPXsUoFTPe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:31.8517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b746882-f007-43ef-93f0-08dccf15ccf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990

From: Alejandro Lucero <alucerop@amd.com>

For a resource defined with size zero, resource_contains returns
always true.

Add resource size check before using it.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3df10517a327..953a5f86a43f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -327,10 +327,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	cxled->dpa_res = res;
 	cxled->skip = skipped;
 
-	if (resource_contains(&cxlds->pmem_res, res))
+	if ((resource_size(&cxlds->pmem_res)) && (resource_contains(&cxlds->pmem_res, res))) {
 		cxled->mode = CXL_DECODER_PMEM;
-	else if (resource_contains(&cxlds->ram_res, res))
+	} else if ((resource_size(&cxlds->ram_res)) && (resource_contains(&cxlds->ram_res, res))) {
 		cxled->mode = CXL_DECODER_RAM;
+	}
 	else {
 		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
 			 port->id, cxled->cxld.id, cxled->dpa_res);
-- 
2.17.1


