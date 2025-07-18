Return-Path: <netdev+bounces-208233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76FB0AA73
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4985F188B77E
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40451DE2C9;
	Fri, 18 Jul 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="im8FseQf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391A17A305
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865018; cv=fail; b=MFacFYg1F2jGeaSiDfqjCKsSdzDQ3wuMONeTvYLJYnw5YGiPOkTUFj58fMONiB+wLz2tvsJPchdzO9NApPbQVBHfoM7sjxvZ5fzye3sRtR/TAi2O9wM4Jv584cCFnW2a+XDyt1811guQSkzxlip8xclnpZeFOQBmlUGPVQiU/5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865018; c=relaxed/simple;
	bh=5keDwMCrszmtXPSTw3ElcnEkxQhZP6x+UY4fTU5lnEk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Em/whNgifr99JaxMUq2h77O6P15bzD36bGdUbv6nbFl1A72JZJ8lDyA1uw2UVMQPeeFtMwcOu7126eRM2j13kxVwoty3C6zSH6FY56DWxnVC10ecUciitHYpr/goSydmFkk/tRm1xArbkc6yqh8hvudKypt8dJQ3VtTRJpEKdLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=im8FseQf; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFUttAq5FHCYHgVE4Snd17cQJfMZiqEDeDlQWdPiIJfnc464aaqKc590gikSlGEBFM5DNSsANHETzp06FRZwyY+ZU5PdlGGRE/53Vvb1Ytjl3QKk8Sqsihespj089OcNjK70d1Xz3nKGcYxxUX+wPQGbFpdFmpo0A4X+1G/ARmeZmK8YUEcbu/uIXnq364DqSxmljTzZxLSKCSXpyBkguRTqCxDI9DKpnbKFLH5YTzRmvbuSG++3QXvBnaDJ85c3YpB7/EE0bqJ0z2VmRzrAOGqQc43WIJwHG5YFRAX64Muyy1tGWq+QR6kgSeWyq3n80M4QsG+7rniRYF4H3ZyKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9QDjgmYSCnPcteLGV35V1Ary/oeekvhhmOZzR2F0z4=;
 b=pF55aS8McbWyr4aYA7Tmq1/j7dei124oJBRWzDGJq5XZFamNthFCQ6bA4ur0V3KO7ukTbiEZHGeAg9gz2EEumw5r9YjEnPYknYQaNI72sEDvudpf9ARJ0tfdm+j6Eqk57WWW+E82tuTAzweYm5r5wd4IH7J98uL8065hEWXIRh6Ljv0xhF/XXheA/QHx49lYMlgZ7jPK0Pi9I11C4Ixc6WpCaxwWVWq6kwwCjGCNC/mqiBNJ5KjvwkDe/iF0/j6fPOONKgaTyhbIeE4gISFc9n32hgI1ZnWdLDKqkub+KtJLCoE03TBhFsnCKLigMb4Z9LEgor1+I/BXWTHWsufWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9QDjgmYSCnPcteLGV35V1Ary/oeekvhhmOZzR2F0z4=;
 b=im8FseQfnHY+WGeHCYKVz6S8uRRjBBgdcEAo/lwwse2LHBkbWhYNaqgsynlxxrI5XtF5jxGiEX9By3wfH7/+2fq/c4gconWs18LlMw+/Gqgc6HW+WzTTQylssuLiyoKbdC2V5Eh+Udf66CXbsQ3HsujUwM0yeC6KQbe3GtlMApw=
Received: from SJ0PR05CA0165.namprd05.prod.outlook.com (2603:10b6:a03:339::20)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Fri, 18 Jul
 2025 18:56:54 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::7a) by SJ0PR05CA0165.outlook.office365.com
 (2603:10b6:a03:339::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Fri,
 18 Jul 2025 18:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 18:56:54 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 13:56:51 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 0/2] amd-xgbe: add hardware PTP timestamping
Date: Sat, 19 Jul 2025 00:26:26 +0530
Message-ID: <20250718185628.4038779-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: df4d94c5-3ec8-4698-e659-08ddc62cdd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vsSdavF1CTOhKr8+9J4OgeqD4yJyroqV/sJP0Fig7csEz45kCSBkl2x+UxZI?=
 =?us-ascii?Q?9W6NGNBq1iMCjn0KbxxCBOYkN3A0jppIuLS2eNkJPvsUYopPKoo2RzOYVhEL?=
 =?us-ascii?Q?dfzPXiNSRR/RUfVxIY2U9PJZAZUzgF9P9s2tSyoF9+dyy9nSWp3AmVaiTVg/?=
 =?us-ascii?Q?D2SFZgxl754Drp+suq0fwfH8HztZwLnFxbJJpbOYLdyf+7VrjkZGheqyFHs7?=
 =?us-ascii?Q?GiWKVg57yphbKjsPnyEyGsWwfuLN4vQ6HkJdBN5z95jyAsHLEAnGysRBQrBy?=
 =?us-ascii?Q?jd8MtCKyPbRsLy9T3LbVYWBGqJBlItWYiVHb3d5HqRpD9RTedq7FbjiDTZ+G?=
 =?us-ascii?Q?5eQFCb5NndchdoXa0pNmGiGR6hW3LFj6smAR5tKtuddi/kDtEndhKEdWll7K?=
 =?us-ascii?Q?sa/Blc/MrjXE0N3bcSdTPq26RiCxyJA5d2Y7kFM3jYbbZqVVTi4Np+yxLfib?=
 =?us-ascii?Q?rTxN/wsPO3zm5D/83Bkik4Z1N3ju5I8RCv/Z5QyI9ykKwGGb6S6FkPuAXc0I?=
 =?us-ascii?Q?Vq91RIILiFDEEvL5824ZC7H0OydINq3CWzmFd9L5170Ic+XeolFqAGh7XAQA?=
 =?us-ascii?Q?womPeQqU5MUPuIl9avCC4vLGrtq4Z4mwHp1izCOLc+eRIZWVgtOtVkhZYbii?=
 =?us-ascii?Q?ejt4o0nlZSUoXJLbl+pg5a4sGsDZo9XYNmBOM8NvJKAUosP3nrGLzhTKIkOY?=
 =?us-ascii?Q?XH2ZfCV8QHf6AbxCKXd81vjUVmJ8XlPjjFaUa3/RZ6AyIXaEQYccpUwOJE+d?=
 =?us-ascii?Q?uAx6QhYvvTqY97DOzrEzzqDUB+z4c1orWt7kPGpwuQXD41nP/xUch8goDMis?=
 =?us-ascii?Q?lPZsizUJFXzauztMv+ky+SCRTJstw6yEzRKe4ocbEc4dlq8Fq4ypWrSw7DQ+?=
 =?us-ascii?Q?+imF36ICum8YmXMvRYm+VVqMh/maHr9MuAyMoWKPY7oVezUPb2UQmZ/PKLY1?=
 =?us-ascii?Q?bmI5NcYBfqI1QbKi7ywgSsuZFlk/86G+V0S5ur9BtVHz10dADsG98AgO7HyT?=
 =?us-ascii?Q?bAiQDgJVg4MEIKP5AEknkMzJTU0lYiOFJpo5rtP7ei018xXYX5zp6Cqmme6X?=
 =?us-ascii?Q?2N1kxSxs9msdneBqszTXodnMgthHl6axyLu5EqbcM6Xui2a2UeACthtubTPj?=
 =?us-ascii?Q?UV5VEMOFxyF95ZFAcnCW0eHJkP4/CajANie36WoUjG1ORYYg+fKP6oq/CWpC?=
 =?us-ascii?Q?/57BjcPFvZJ1tNkEtvajNMkxUgYepDnwDXrEc2z2v5aiB7bW7itDY/8qB2oP?=
 =?us-ascii?Q?x74SDfNO4JQ2FDt3wlzGsHAnTVu79b1NBOuUYY5XHCc8NAE+VXcJyneC+bFL?=
 =?us-ascii?Q?wmP3vvYa4gduPWQRiZy0EgQZghKfwwu8ejvuhPUuG24ERq4Ny4YiKXz+0tt+?=
 =?us-ascii?Q?E2LqXWF8m7kwmw4BsG06t7JHAqdOg7cDcEilI6Jkouol9Xi/PvFo/e/g1JIH?=
 =?us-ascii?Q?wsw+CSMjq9plrVW0gmUXuDqSOSe8mBG2oNpyYmZv6IuAaVw5OoEcbXF3SCYR?=
 =?us-ascii?Q?3onAn4SXt0wx764BayQNaWM3evi280AsnW50?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:56:54.5780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4d94c5-3ec8-4698-e659-08ddc62cdd1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

Remove the hwptp abstraction and associated callbacks from the
struct xgbe_hw_if {} and move them to separate file after cleanup.

Adds complete support for hardware-based PTP (IEEE 1588)
timestamping to the AMD XGBE driver.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
- add a new patch to clean up the existing abstraction and move to seperate file
- clean up the support patch as per review comments

---

Raju Rangoju (2):
  and-xgbe: remove the abstraction for hwptp
  amd-xgbe: add hardware PTP timestamping support

 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h   |  10 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      | 126 ------
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 204 +--------
 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c | 401 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |   2 +
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c      |  75 ++--
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  47 +-
 8 files changed, 487 insertions(+), 380 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c

-- 
2.34.1


