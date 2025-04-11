Return-Path: <netdev+bounces-181451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D94AA85088
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630C27AD7ED
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242116419;
	Fri, 11 Apr 2025 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zWq5bxui"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93910A1E;
	Fri, 11 Apr 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331554; cv=fail; b=A0SNLjmXni+wBMkOda8Dgm6vp1kytg4u60wj1DeUFuyz5VzUwvkqqxEnKzoBF9dXxR6DSwj1mwhJ5CsCKnYBsjPRSdw02uXxlDmuXKcy6yYotk/aNL6lTW57SSTyiCfjjX+tOubSAQZi/KBBk0UufYM1adF3rbdSu4nT5II+bT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331554; c=relaxed/simple;
	bh=5PAbZMc9GQdH9f6zQteDbHTD6p7Zv+ISQ2wYcoAVREE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfF2vcSw0U9HMgSD3LiH37Tf/9o89TJuAEqDaPT2vBtU8ObQtAOhnNONq6Dl0MBejU4p5iSBqqvPfvjndQftu9y2IGc9Gkol5BabtXIi+xhbDX/6pgzZZtOnIDtu56i79Bzf2gQvPiZ6hRRwCULmx0uY9fe09mGGHJs760VdlRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zWq5bxui; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJQOsnfDmkP7jV5bgPaePrbKg8HSP/e+JBwKs7YhW5t061I2589XXjkUwt4Yz93mq8lHYTEcfI5XhjhEUwFCVPwfyjc2pA1Rijrgesp8NW5ZLIm3DtoPa+AwIyaDSW8bbyLN5IU7QWCsejckeAP5iakZkdI5Jp/1aW1rhzwHGAJy83p/ac5bt03wbJ3cba2/ZwN+4JkQDKu899tg2z89V2VsEx9YbZsZ+0sfK7xc6IvmUyXQszDqfTDel4uz3+KOf69eI2CT/rRs/CIoUIM7JTWRh0CDw0e2s1cUxi+mFuvcdKkkHefMXZ6aAtHBFNidgbt16A3O3+Bi/PwOg8MU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0opJKX/Imnt509eYuwDUjD3KXm8QPUG1tcXc4VMh82g=;
 b=jlws6fcAzSbxliMY2ilx/28y3z+V3wW1QDbzN1jUhRzmJCHl76taIF2qTEqf40hRlZnEdpmCW6L8tlsaJrBfevNQH1QTvZfGI/gYvVrfNQSmAjihmLQALFwRcYjw2Vl04A6XKdmYfRG9VHIAaTPbGkCveJGmMQR9BEhrEkZFDTNjWpFtzhGHL5ebfYlHfFh8eXHqkSXJoc/ccEQ/hPPQbIhzvD60I4xAPlpeHq1X3rZw07kJXh9PUcEbcHEPImKyl3LlpinUF1ZwdVTVGGSrEfuysdSH3BkgJiC/E+XfmbZoseo8EfH+jqhzKZfAHAeDWFowTNykH6nSX1HwNFvKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0opJKX/Imnt509eYuwDUjD3KXm8QPUG1tcXc4VMh82g=;
 b=zWq5bxuixLo/IXZQYYekpQF6MLH96cJrG8WgBISJl8ewtLFFgRaadzD53n0lxCwMkjOTtf2Co4i+yvYw+tC4oRu3bwhz4JUhrE6j5vnQxFJB8ZXu2mt+pvoq94NCiDqPrFZYDLAGi8SLNlrXzMAJtM9e5rjsgWGbMnA6hcoOok4=
Received: from DM6PR17CA0022.namprd17.prod.outlook.com (2603:10b6:5:1b3::35)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 00:32:29 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::6b) by DM6PR17CA0022.outlook.office365.com
 (2603:10b6:5:1b3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Fri,
 11 Apr 2025 00:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 00:32:29 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 19:32:28 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 1/5] pds_core: Prevent possible adminq overflow/stuck condition
Date: Thu, 10 Apr 2025 17:32:05 -0700
Message-ID: <20250411003209.44053-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250411003209.44053-1-shannon.nelson@amd.com>
References: <20250411003209.44053-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4a797d-6911-4649-4d37-08dd78905792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SIHk44bcLQJvdHZcB9SDfgX1Ph23v7ae/IfBI4bNIRsU5FAZjP73lndxlDVT?=
 =?us-ascii?Q?zQgjxbaI2qi3aiA7PtZxf0daByh0J+zeE5glQcwilyjy4IKFhD/fCrL4FuAn?=
 =?us-ascii?Q?XQAJX7ysT/VGywmMPPcsFZH58DdzzJEKk6Czei3Mlgj7d7SH3spA9z7I89+F?=
 =?us-ascii?Q?Sq3SrSuIq3wm6tI7cnRGwGy1oj6d5jFkfcpx9OSsVUbYJMwK1UmzsGiSmG9E?=
 =?us-ascii?Q?U7fLK/wbr3N4UQ9XQKqAPtXkM3cLdgMKQ85IvtNBETXpa9NB+VYml6lOhAcZ?=
 =?us-ascii?Q?hgqtUc5aB32QLF9dOXANgtfFnE6ZA/VJaqVMA/ph7OnyR8txCDg77l0CsGlR?=
 =?us-ascii?Q?6AjElptVsLIolSOcv5YpcLyO8SbxzWqbf3E8W2ov14+22JHobzuA/fFYAio/?=
 =?us-ascii?Q?vJ+04rbV1Xk2/g0PCWmozKNJSK/n72Pwbsfos1fKGarcA9/90EIPUwW9pRHE?=
 =?us-ascii?Q?C3eLIsEFnk56Kjb0Vzn3d4feZtS8DSttI1MHfbAXL8BeqrY1CMtacP1oxYEy?=
 =?us-ascii?Q?PqzLDuuiB37y727GT3XDYnYJAykOJDfUBFMI+FNOPdEG4MPhuf2c5D1chhsi?=
 =?us-ascii?Q?Xlx/ObzY1ORyhY+BdmdXGZ9m01o84cZ3AZK+fC/ML1BXf93lFqp69uaz3G7i?=
 =?us-ascii?Q?6TN2f6OxHPRgkT7BNG+8ESiV3nytsqPwjZiFHR0cxBOzBPx4BcCKKNm1vN0H?=
 =?us-ascii?Q?T8vtXj1/G4oSOiSBYrbf+7RDh/LYmsOLEfQwYp8B+nQVhl9axhEnXhrxqZ7Q?=
 =?us-ascii?Q?ErPG3ynfw1BRferV2P88lDWC4YrEuGYs9WXLohXxx0jWRxThW3KUYjB81Jr1?=
 =?us-ascii?Q?0E1PZ/21utJ2I39P4eEYpXuegUBGlBL1rKVn5O+ZDVz9lppEegvhtt5OKtEG?=
 =?us-ascii?Q?ZD2CkznfgTnuX8QrzjppMvhIHe0sjYuuPY+0oYrkMa2f6OmIjZPJFn2lU98V?=
 =?us-ascii?Q?r/lLGTgd1BuXiX9ZadChNBtCBD1TnVzYuC+AjUI2/sFNJWuw48RIVTGUcrjx?=
 =?us-ascii?Q?9Ry221WXkqQD2DEDcr5euRrhU9Fb9KrtUjMIfviQ5N7pvYdKDDpXAiFXn/17?=
 =?us-ascii?Q?Fpilc7iJgOC5dLLv6Hnr6O/CVkAzSrVQ+ftwi++eqTKGc1+LtC7M6P6OOd8n?=
 =?us-ascii?Q?zsKw+oNdKca8mstMKt3KkfJX1uHl/fcPEDBh0Tp3OEV6SE6RL5HHqMuciEZm?=
 =?us-ascii?Q?OidxqrWruWTAVgOy/rXki3FurMUS55lgE/Qx84UN/zZGnazKYny6meTWkfwC?=
 =?us-ascii?Q?ExBGeOcWFDl9rqEpqXMybqiZTCVDj0RPQcitEu8//QH164ceGzubKSoiMgwL?=
 =?us-ascii?Q?qr6z0Wh705ULk7osQFq7EnM7yVAyfOJ5h/uyzmrhLxD+AzDMCVua3vhZUdz3?=
 =?us-ascii?Q?r5eETxeejf/mCox1ptKzozqiL4zTCicVanA5UCWEhYx+PQ0wF3RJr2OujBEG?=
 =?us-ascii?Q?mdfVau8E0Zw4YGm38VToOCRGEWD5oC0YH41Ao21pR7alsymw5OVmCSVTXwBV?=
 =?us-ascii?Q?llaUN+9U9TBrsAAyPQ9WRCb1rAjQ2RlwSmv13uhDAaAwqvgUjmooZRjY4A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 00:32:29.5370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4a797d-6911-4649-4d37-08dd78905792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

From: Brett Creeley <brett.creeley@amd.com>

The pds_core's adminq is protected by the adminq_lock, which prevents
more than 1 command to be posted onto it at any one time. This makes it
so the client drivers cannot simultaneously post adminq commands.
However, the completions happen in a different context, which means
multiple adminq commands can be posted sequentially and all waiting
on completion.

On the FW side, the backing adminq request queue is only 16 entries
long and the retry mechanism and/or overflow/stuck prevention is
lacking. This can cause the adminq to get stuck, so commands are no
longer processed and completions are no longer sent by the FW.

As an initial fix, prevent more than 16 outstanding adminq commands so
there's no way to cause the adminq from getting stuck. This works
because the backing adminq request queue will never have more than 16
pending adminq commands, so it will never overflow. This is done by
reducing the adminq depth to 16.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 5 +----
 drivers/net/ethernet/amd/pds_core/core.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 1eb0d92786f7..55163457f12b 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -325,10 +325,7 @@ static int pdsc_core_init(struct pdsc *pdsc)
 	size_t sz;
 	int err;
 
-	/* Scale the descriptor ring length based on number of CPUs and VFs */
-	numdescs = max_t(int, PDSC_ADMINQ_MIN_LENGTH, num_online_cpus());
-	numdescs += 2 * pci_sriov_get_totalvfs(pdsc->pdev);
-	numdescs = roundup_pow_of_two(numdescs);
+	numdescs = PDSC_ADMINQ_MAX_LENGTH;
 	err = pdsc_qcq_alloc(pdsc, PDS_CORE_QTYPE_ADMINQ, 0, "adminq",
 			     PDS_CORE_QCQ_F_CORE | PDS_CORE_QCQ_F_INTR,
 			     numdescs,
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 0bf320c43083..199473112c29 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -16,7 +16,7 @@
 
 #define PDSC_WATCHDOG_SECS	5
 #define PDSC_QUEUE_NAME_MAX_SZ  16
-#define PDSC_ADMINQ_MIN_LENGTH	16	/* must be a power of two */
+#define PDSC_ADMINQ_MAX_LENGTH	16	/* must be a power of two */
 #define PDSC_NOTIFYQ_LENGTH	64	/* must be a power of two */
 #define PDSC_TEARDOWN_RECOVERY	false
 #define PDSC_TEARDOWN_REMOVING	true
-- 
2.17.1


