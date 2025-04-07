Return-Path: <netdev+bounces-179980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B72A7F074
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D663ACF7C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716922A4E6;
	Mon,  7 Apr 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4yxUNjIN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320C228C99;
	Mon,  7 Apr 2025 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066312; cv=fail; b=lAqJSquVdqcCVmpVGDR/ihf+VCIxFsWEg+1MNSt+uo7l5WJt2PnQyb6npTHTw97m9XKfifpVx83vHhb9q2nKMw1XIT7+GTeY84O245/0USzBcywbHua9JXS8ZBfF1HrD2H6eYBTK0b4w33h07BUiW1bx/Q3+C49whtrYO5MjOQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066312; c=relaxed/simple;
	bh=nmYY7pWw9v6eP9O+ANP6DaRH8/KMD4splLRtvNn/kio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VM+bJrrbMYspxHgs48nPDIARCCMmLeh5xGe/9sj5yCTiaNSqD3qlEet8LkKPxYIaYiwm/CYx31vxEK7oGzjPLD+h4N2YFGyhrzzo+88NvPQJuZ+czXtyx32hhX8TGnIsgaG4otep4uMzncQYM//qzym+9ub1Ux0ZXLc6L5d1DNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4yxUNjIN; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0bp+PNjCJTIcSEUmOQ3QdMci30sohq9NdKCW4vxR6BWiu7c3t4GafoGN3n3V/oQXt62ekwo823Vr9cE1ihYemS7vRyevWHHk7NZ0mA/pE2M9/S1O1wTPVlx1XTGU5h8Y2yX7xjJ9ZOh4QHeCs/BpdpYv47/26YqLYs3FucT+fSkNyQ2AkQy75DYxmaJOnkshcp7EAwTA4iE8Uh4HpxB5pn8Vuez0s/PiOKJ1RzSfDfmNSEM/vjVfkpDq9ls8VlABJxYs5UqDxutycaxfba26F/6k/FHkF2QuJaLcnyOYZMg3UxGjHZ7Tfk5dzkg5mB5b3Wtk+gQ87qMJwCHZdiQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ/o4oj5UCXqzjCPtq/JIOGs7rsNLkJFTKQqL++VXWU=;
 b=Geh0PbsI0qhaTBVqAvFFAUUFFGxN0AuCphAbVKRiC2Gmz+ITyhcIQSwti4OYB9OKyS78tI3l33kTTkEqmho2zbNdWqpTz1W7PI0OgfDDxid8o8TUECxg0Ls4P0oxqQrIZn6CBtfDK+jkTzVAZoGolRZSQ2AZVg/k+yeoMJ4QxsTZoGdQrZQNihT20rogL+GY43Mm9kVwfb8Gt0rN2JsAsKs++7DApT7IaRDbfLS8Qg67ytRvVfMcaIMg2WLmhJtyqE/tGGUgouABv6QD/YiXKlqEWdpfVpCtTSlH5Ja1ROb+KWSam6sV1SDbiev4xrmQBuUffwCnmYsxYdzTEgdwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ/o4oj5UCXqzjCPtq/JIOGs7rsNLkJFTKQqL++VXWU=;
 b=4yxUNjINSwG/TpuocnuYifU2Bc/SxOFbOmK4MD+c73LBMSmRZg975Tl9c7CHxZJ2ncHvI7PSu8AR65TiV8LxfQaTHcBvFzxqMmY0fiw5r3KHbodBiXdlqnjJd11dYU33eXxGdOJB63xRSvXFOeWHnfGhGK5XMYZPKUc7iRYK3dw=
Received: from BN9PR03CA0083.namprd03.prod.outlook.com (2603:10b6:408:fc::28)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 22:51:48 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::2c) by BN9PR03CA0083.outlook.office365.com
 (2603:10b6:408:fc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.32 via Frontend Transport; Mon,
 7 Apr 2025 22:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 22:51:47 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 17:51:44 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 3/6] pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
Date: Mon, 7 Apr 2025 15:51:10 -0700
Message-ID: <20250407225113.51850-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250407225113.51850-1-shannon.nelson@amd.com>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 620b2a69-8256-40ce-425d-08dd7626c718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NB0P8scCMjiheBHQepq2AnkidhmbX2Z70Fzc3rGBAgB2d+lvkqGHoAQGoK4Z?=
 =?us-ascii?Q?XccboIrMZ2U2kmwBgTFgFtRfyM1+tzaexut8Et47xLQZ7/mIednV7nmp+6v6?=
 =?us-ascii?Q?0POtGOME5yQAcVnQCMHqYI2732Da+SVVrB9k5k47eIx/v4SrvdR+0NNk/q7A?=
 =?us-ascii?Q?FhD9XZdSwtzhd+dfuKEN+5DGCLWe9sxs43Bx5N1bVs7Mz3vE5MSkGfEhwIg7?=
 =?us-ascii?Q?v/B90klTcnetQAX8wqD8njUYHVX4lCS6gAXnm+stXtAntxxMpQUl4Vr5aO8J?=
 =?us-ascii?Q?0Txwyf4psEgi0nG/iRxw7zr4LUsvtnaMhk7GIMCSBOVBVqaTdd5vAPTT8k2y?=
 =?us-ascii?Q?zRvbs+LjXFYGnfAz88v0zxiOrSnU2Q6ad/91g8xekddEC4yhln7nPmPULs34?=
 =?us-ascii?Q?2i6II/5LNcIWQ/PQt6IPE1qOlZvfZloIZMy9PC3o/FREhoE89TQzwR6Ghqav?=
 =?us-ascii?Q?kQkfYpwUkVwsXvNwXcCUIXdp/GwaKFtkIu1Y53VoJ7i0sYzJcTYSk+PoFnih?=
 =?us-ascii?Q?XG93FSE+f2NjPihJijOpSws4UhOGubbD9pYk0ePChzIRUbwtNSfiYylxj2az?=
 =?us-ascii?Q?g4XuIvSh7QTrqdsBIunXwoCZP/nDcLDOdPPbWB1E0FT7+YmhuSBXCRY3BEKu?=
 =?us-ascii?Q?0+Zi+u48Zu5mfHRfS68lIRwZZM1OkKiBTUwq6IpUn3GFcjaaYlxXVEI+CjrF?=
 =?us-ascii?Q?ugHDxlu6usHKb2yhKBfXjaF7a29IvU5AY+fBuCjzVufgT2TKMGo1t92N8cp4?=
 =?us-ascii?Q?bTroiNo6/2OHr8Dj12h7cK7awU8+epXQTRlXTgTeoBbCvTaQWuxn2sEi949k?=
 =?us-ascii?Q?Pd8EFm1y73KxEzm/EisZXfnhaCV5wDOJFHpOzFHVDvMwLpu0oTt3q6dji3Y+?=
 =?us-ascii?Q?w9gMpcEO4b2cmPYpMuefShSCkbX39TJIoEd2iK8bmQaOk0e27LLNdBLf3Lvs?=
 =?us-ascii?Q?Qjik+S0KMMdCbwXogM+0ebV0XROZHnT8P1tyjT2lD8kelkqUB1Jgj8qeWNan?=
 =?us-ascii?Q?Tw3QFERQAPhYM1znJMB2dP/tixdoRRVQ/isfk/U1dEUmHFKYbt3lIJeSjJHS?=
 =?us-ascii?Q?mFotjlpL/Ye9ZCjP8u/s12FAkqsWK5Z7PG095LZpWNzX127JnJHQkeB1KBlh?=
 =?us-ascii?Q?WrTyNmJhn068Pv/zdZvwYw1cI1Tl+JfPktmG1NQefRFVrUypYnIEp0Mc96y7?=
 =?us-ascii?Q?LDBq2BOA+3omdqYQF1NGKkS4CqrczV6p7LyBAyP2jTNxjrenQ8YgWsBfGUVq?=
 =?us-ascii?Q?tX45qb82J/2NHDqElU5mul1WUgq1p1gssNMDxcbH4mP7gh8dpOdWkazG7vZ4?=
 =?us-ascii?Q?FcQFzb4KFWXAlyB8zjD/RsPYgGy730SuiZtNZRY7faTAT6+PPd6BTswAAxCe?=
 =?us-ascii?Q?28rM1jIc1ukm3xjWLbXfSX9t4LuImMq8YrkIGFPYk/5FSsJCMHt1Iz4rnNZM?=
 =?us-ascii?Q?QnJnTaNAHZ5HAgBB6P8cnjiMwx+zqns6isc+mpLquxARtC6SluzBQMX0qgU9?=
 =?us-ascii?Q?z6/la7lvqk3Ttcc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 22:51:47.7100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620b2a69-8256-40ce-425d-08dd7626c718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

From: Brett Creeley <brett.creeley@amd.com>

If the FW doesn't support the PDS_CORE_CMD_FW_CONTROL command
the driver might at the least print garbage and at the worst
crash when the user runs the "devlink dev info" devlink command.

This happens because the stack variable fw_list is not 0
initialized which results in fw_list.num_fw_slots being a
garbage value from the stack.  Then the driver tries to access
fw_list.fw_names[i] with i >= ARRAY_SIZE and runs off the end
of the array.

Fix this by initializing the fw_list and adding an ARRAY_SIZE
limiter to the loop, and by not failing completely if the
devcmd fails because other useful information is printed via
devlink dev info even if the devcmd fails.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index c5c787df61a4..d8dc39da4161 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -105,7 +105,7 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 		.fw_control.opcode = PDS_CORE_CMD_FW_CONTROL,
 		.fw_control.oper = PDS_CORE_FW_GET_LIST,
 	};
-	struct pds_core_fw_list_info fw_list;
+	struct pds_core_fw_list_info fw_list = {};
 	struct pdsc *pdsc = devlink_priv(dl);
 	union pds_core_dev_comp comp;
 	char buf[32];
@@ -118,8 +118,6 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 	if (!err)
 		memcpy_fromio(&fw_list, pdsc->cmd_regs->data, sizeof(fw_list));
 	mutex_unlock(&pdsc->devcmd_lock);
-	if (err && err != -EIO)
-		return err;
 
 	listlen = min(fw_list.num_fw_slots, ARRAY_SIZE(fw_list.fw_names));
 	for (i = 0; i < listlen; i++) {
-- 
2.17.1


