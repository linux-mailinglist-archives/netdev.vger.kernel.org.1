Return-Path: <netdev+bounces-181455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C6A85090
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F458A4F79
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C328F17084F;
	Fri, 11 Apr 2025 00:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2bwJhMrS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D981487D1;
	Fri, 11 Apr 2025 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331559; cv=fail; b=jM1WEUsobxCyA7EUQ2Jhbah+WJu7Ut6VWrMf1JROsW1Z5OlcKCp8YJ3v9drdRmEEducrI/UuE1jhFkYZDfIzuuGvKBoa0Yxo8NyoVrjcWNGJQwLVfdgAyL2C8EGPG8pvFex/YrCb3Z2z/3dNeeduPiL54iASPfiFeskEGTuG/5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331559; c=relaxed/simple;
	bh=eGzmJB4g5nECEEF6KArKV5x/OFxuEw9FG0qhVtqYK8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zy64SNhPL4SC+pQ6V84z2jeZ9HfcSBK/hHaOvJz5knVl7OYQY+x9UcD5PI3fCTm5siBc4OwVMLddEQ2N/DuJa+so3ZNjeQAMKEYkFTcvHnT5OqMcoADeUIhmZB2gZxyBSunY4bWDmZsSAjOe3CKswcxXG7MCx0QZy9TL0isIYHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2bwJhMrS; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1l8tDk0jOnbYnqzpLQP2wz8lvweuz61VbtuvDabOHHtpNei14z/nIFC5KRCURWv3019gdZ8+/boZdkOo5nzacikS1OwdpMgch9tKpclZnXjWQdXR67ZgttIl2XsvczZx69TXifELvfhirQ0c1wBtDfWr2Dk4Y/FvusVUgdpG4RFEKhLD7Sti0qv5bTPiyNcxVt7Nl3WcIpGRhlDKLBujyYAKTV5NT84XuZON1GDCTDlTgp9tohj6FIb/8lnA+HogkxoHlQG2J4tUBMqvmsLFQiAKFXK9FASk30mJKiSGfWyAbtgD7bnBAsoN8f3E6T66Q99OfzF6neS3dMf2Iqecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGxwFUZ634Dmp2Dk5tj3RZGSC+63BKGDM954huSvkRs=;
 b=aZvo4LZPFAHsJIzqqTYa+s1iUc5Vvap0CdDfUlTAmUWXTJIZs53kw7Qf88tNJv6JnuAnoGyXTiB5mPXJWdBIPwaxY40dqRi0sgKjxOywxTTvaf/GlqzvUYqRMyvdLlhrUViccTGKYxgS6JzqCvH4FA5nikGVmpbqFiU6hazSA6QONohj/8Mg+yM7CQfoPIKG5QQbbv4tb5hJkpGznw1EMwYAz1a8+WX/MAGlkCcZR0hr/+5MpMfoJxuIOHQbBmec8aSjTERn7b3oppdlpvi+dN5qkyoHXlFodw6fNUw5yyFWzvar8E5flZqiWu2azrkUOo5LgocC2R1enbTqhmLJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGxwFUZ634Dmp2Dk5tj3RZGSC+63BKGDM954huSvkRs=;
 b=2bwJhMrSm9aoeaaa+seeL1diCoJYNNzsKQs4sPqksJROsOFM/jQH8qlFT0NCax6tOkBsw5acGLwJPUlD4kFZRli/yiUvH+5uPv4NIrnLTLuXYmvGH5glUBhNTVK1TmxY6n+4v2966VCYiZrO9w+a4NcP8FZJ6tg0UHTwK0rzimg=
Received: from CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::14)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Fri, 11 Apr
 2025 00:32:33 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::43) by CH5P222CA0013.outlook.office365.com
 (2603:10b6:610:1ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 00:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 00:32:32 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 19:32:31 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 4/5] pds_core: Remove unnecessary check in pds_client_adminq_cmd()
Date: Thu, 10 Apr 2025 17:32:08 -0700
Message-ID: <20250411003209.44053-5-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 36adc623-f334-4378-f648-08dd78905924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dz9Tf7uV3QkKlzf73w45N4iy8zQ4CE46QI+9EEM96B4pPU4h8qRNz98ZBhhW?=
 =?us-ascii?Q?PF052W+nZSqY2PbSZ5eMbwjB6U2Q5S3SjoLUffSJKHdzokwOkqKmKkMYz4LQ?=
 =?us-ascii?Q?8HWiWCMFMgDA2XUzILctWjw8X/h++niScVNeK4nqZDSIYSx2oxjThqFhCem6?=
 =?us-ascii?Q?2PFQqK/Ppc3afDvmwuZ3QDnLgWuuk/aKOr1YGyZhd3uArHGht1jaU+bGLQHE?=
 =?us-ascii?Q?M6u7FssIP8l3P1lJq/FW1/1hKmcjMaRs9xskzjFngXkIMBpEZZ5tA9nOcuGu?=
 =?us-ascii?Q?GctGMASubfSf/eCfN5UCfyCZ6BhXyrnZKMf7Xs7I1c1fpldnSK99/WwCrJLs?=
 =?us-ascii?Q?mChcFwcFwmKZd/PAfXM0MI4i7bkK7ETuFya9+ZAcYeQYiLYZibMZrxzJuGtd?=
 =?us-ascii?Q?WmMj4KZn9hCyvlMVjv6XJ1OVN5KeUyEWDwyyo/IctfuF99yPdlgycPMt4x9I?=
 =?us-ascii?Q?jjOjRz1HXezmYx8Wjg1oCEViiUpOs97YOmEPELAybFbfPm+JYJScOgbd8g1B?=
 =?us-ascii?Q?6lwThMVuEgmlXxOtykqthB4t4V4mynSu6KU9E3snKtoObxZ3n/kmROtapqxg?=
 =?us-ascii?Q?np0lTLph6xNWgUnGORLtLFuASuU7AvdlxSVWEWwt/42WDuyBCikLEvKDHuVZ?=
 =?us-ascii?Q?cGz3ihRcAO4YFd5/ny8vAYbR8teYp+V3kd9KMNllwUmRtciDjCVDdpxP6m47?=
 =?us-ascii?Q?QtrfnY75IEF1BZSTyxggpXnvs7jnmCMVCBCLmhRpnDbOW1emiVBscLz4JgNe?=
 =?us-ascii?Q?YgfiSM39FkvVcNd7/NNReg8OIzCnOK95f99gQF9VTBipMZkaiY/98073sSGO?=
 =?us-ascii?Q?GpUvkCdANLPZYwI1s/ZO0RTfEreELpMJfHza9YIj5bEvWJSot0W7iA0ZdVMn?=
 =?us-ascii?Q?5j/0pCAKCJRUzalWW/wXB7N0uyrg6/H+oCCuQVE3DZ7HKXJUxgUbYag3Pte0?=
 =?us-ascii?Q?f4K6wUZyTVtl+AuNqn9vAmJJ152BXAoIPjehHkoCFHxTCrs7fYP/kREpPvU6?=
 =?us-ascii?Q?rodCjNrBWoxgoJnISS9nRjXwdc53Byxr956aYfx4Csy/wYyERN4BPZSumGr9?=
 =?us-ascii?Q?uDktWsmd/IwvG/aPLSmMOGWfONvIudw5re0C4ClK37Oal0CXa/4TiIQ1PdlJ?=
 =?us-ascii?Q?omBrFNDjpMm4CwK9o0bjUpfCrDL5Qrnx1lrcaeB2FNib/YJdefke48LtLiXj?=
 =?us-ascii?Q?Yiqm6X1omh4CYJqIybhu/4xC2eEf+4I3qr478NxUAInz0j/s/jT7vuzb14A0?=
 =?us-ascii?Q?LGZ5goEhL1j8O/9YZRVjIxv6yx/AbUEQJYpLb1rxK9WDcdSySxxm7+4RPCQe?=
 =?us-ascii?Q?SpLmSOTHEwbZcn29NhPDd3B6NkaOi4Kr+wUzcphfZZo0ckIqp/Epa6+mEw67?=
 =?us-ascii?Q?DEMxHbiRTOqDzcmW9bCYqjAC0YCGaWy28W135KTBDNO48CtDfZmXlONvrhBM?=
 =?us-ascii?Q?IrxflDZ4p8qDZ5do3Gc4NYNivcLP9rwSwgaT0zAYUoKyWZ4MCE1jWdwQ507t?=
 =?us-ascii?Q?K2w3vjYxcAm8Z6EZQWbZLfYqxiA0Dk0mwWU83b+XUspPyA9/DSNQ+N0H7Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 00:32:32.1915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36adc623-f334-4378-f648-08dd78905924
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671

From: Brett Creeley <brett.creeley@amd.com>

When the pds_core driver was first created there were some race
conditions around using the adminq, especially for client drivers.
To reduce the possibility of a race condition there's a check
against pf->state in pds_client_adminq_cmd(). This is problematic
for a couple of reasons:

1. The PDSC_S_INITING_DRIVER bit is set during probe, but not
   cleared until after everything in probe is complete, which
   includes creating the auxiliary devices. For pds_fwctl this
   means it can't make any adminq commands until after pds_core's
   probe is complete even though the adminq is fully up by the
   time pds_fwctl's auxiliary device is created.

2. The race conditions around using the adminq have been fixed
   and this path is already protected against client drivers
   calling pds_client_adminq_cmd() if the adminq isn't ready,
   i.e. see pdsc_adminq_post() -> pdsc_adminq_inc_if_up().

Fix this by removing the pf->state check in pds_client_adminq_cmd()
because invalid accesses to pds_core's adminq is already handled by
pdsc_adminq_post()->pdsc_adminq_inc_if_up().

Fixes: 10659034c622 ("pds_core: add the aux client API")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index eeb72b1809ea..c9aac27883a3 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -107,9 +107,6 @@ int pds_client_adminq_cmd(struct pds_auxiliary_dev *padev,
 	dev_dbg(pf->dev, "%s: %s opcode %d\n",
 		__func__, dev_name(&padev->aux_dev.dev), req->opcode);
 
-	if (pf->state)
-		return -ENXIO;
-
 	/* Wrap the client's request */
 	cmd.client_request.opcode = PDS_AQ_CMD_CLIENT_CMD;
 	cmd.client_request.client_id = cpu_to_le16(padev->client_id);
-- 
2.17.1


