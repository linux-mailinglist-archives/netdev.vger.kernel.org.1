Return-Path: <netdev+bounces-97263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B498CA5DF
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 03:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0CA281219
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 01:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A566BC2E9;
	Tue, 21 May 2024 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gi8Z3a1H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06768947E
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255460; cv=fail; b=IeaCC1VFZvBHQHCkYg9Yfkg5bcL16bhv+Ydj9sDOsqnOx2Kd3E6tytIEh3iuPef2Hz/sxTh+Rf2MgAnS4KM6/NUed2v1gkzRn1wGO0BRCIgBaGYDp2lirOc5DKnizTOZDnhv+sFnSb92+FdqBy7DXtqgoVbXdDoSrhGiNT+cfv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255460; c=relaxed/simple;
	bh=Ut8/gJD+AqhyJBL1RRQcYRsKUn0Y4KhTmrt2xQjuZt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbB23HVrWYKfnFxAKTdj9kWM8agFik6njidpmz6/pbL+t6qUQyEHh18+eNeeZGpKy8DF3cxO3DBjyP1TUFt6lmXvxdSmJjSixIarDHvQ87OOPLsaAdHL7aEM34avCKn2vFZM56QwDi8/icSWAt5oDHjgE7m3YuH0xKQ6d0d4vrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gi8Z3a1H; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmRmHsc3qdlLgBeqTRNW78rjVB5SO0oHHCkd7MIMLFS8yiORUKvYjwVAx0AQs22sIwJfuKZeciBLMmzjXv4Mu15pPqMTgbq4RrkXOOmA8n3orIk5ZNnA8fKJe+BtzmWFglxxDD/cZ+gYIOYM6JoGqDw2NDsgneActTO6Z01D8oLo+/VprNyoJPQJaxvH5OKeqtS5WsVOEp4DlEnobJafj2QkeHYlqLcVf+mxzhksjiM4s5yNpMrP/KMGD+SxNbuKZuN+QM5ZBP1eAG7OR1Rvro+B90pZ1fL+bKyx/KeuQgwo0UeDNA7ylaG3Z1/ls0fv5MVWl/ogsFv8oYnZgGQKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXnvcJH6KWl9R26pRiffKrQdcQQ8fgJdVvbDLXl4dOE=;
 b=ZEwB4v5u9tfx2TNof1WMG5012x4stsCkWD1OupVSTGOe3enMFHfmJSYK7Hreqmp7ziJwuc4HRWWQL14T/qnkPpTA+DnxjjIPjOSxtRfY85TIvOZ9Pry+yErS+EGcRGVJKXE4AGvyIAdY58EO6nmjwU6i8CknOVaFShutr6iTVSGrEENLdWI4d2JV/YUzNsWmPnMz8W10tbb13vih+OIy87kBa+PIurW0i+gjaecmjB378kkbD8wIvaATsCUdzfeaWJztXgDw8FMTHOUW90R2wrz/V158tgO4CAmhGc52ieUAPeAEJdDxMciPkD1nBreNCFIUuWpV6yQuCPRmUDlPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXnvcJH6KWl9R26pRiffKrQdcQQ8fgJdVvbDLXl4dOE=;
 b=gi8Z3a1HrP9CnXVXwksn0UJ+sILPmKWdtRgfNzLZ4zZ96ABXVCkPjlXuifB4S5s3O+C9wfMaE8s6FbPoT1tdNCn5FSnGNEgKjfs8lr0XYn7ye/lFeXKTZs3fBwKzsmkEYL0QF2g3c6ypaUNOMbgGurb4LF7xfZnutt2V0xbmPbs=
Received: from SA0PR11CA0027.namprd11.prod.outlook.com (2603:10b6:806:d3::32)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 01:37:34 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::67) by SA0PR11CA0027.outlook.office365.com
 (2603:10b6:806:d3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Tue, 21 May 2024 01:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 01:37:34 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 20:37:30 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 1/7] ionic: fix potential irq name truncation
Date: Mon, 20 May 2024 18:37:09 -0700
Message-ID: <20240521013715.12098-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240521013715.12098-1-shannon.nelson@amd.com>
References: <20240521013715.12098-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 6502f848-874b-42b6-543a-08dc7936968e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pX9Rv57h6FG7X3TYlRMfDbifSu/pOOs3+HNMeu8IzxvtsIPpQRkEuIrihgBF?=
 =?us-ascii?Q?W34xa9etjo4AkxEx14Da+at1TLEJilXwd1qwxrIn5BKBBXWpCQvDcAf7TAvE?=
 =?us-ascii?Q?QlxeabcMbsIT10eDi91fTi7vplr2WX5hVQf6y6e6fDJHC7NfGrrFdualdWeM?=
 =?us-ascii?Q?T294nlK6SofJQ8gUHHIBO5+yePNFZz48YKSTUZhKNi2aciXjGB0n6lsxNnX1?=
 =?us-ascii?Q?zpLShLuxeXZceNpb6bUKBY/fHw3WJzDfcVs4EyGOfUA1KWXJE7xVLIj52UUQ?=
 =?us-ascii?Q?msC/mfFMTrjXB7PQsx13ojBGksPMELu0UeXBmpBI1du/R+DLZdsElO3aREUk?=
 =?us-ascii?Q?9gIFKqH2VPGqNI2EIEQayJQKGkYjKKN1wGaJK9GxjgGkWTITiG772OCbNo55?=
 =?us-ascii?Q?OIqVBjODLhlrgaO+VkGr8pwtmDAbrRuomArRo6m5rYADFzEerah2JSR8B8Ag?=
 =?us-ascii?Q?qb2BQDpayj063+030wC1IIKtH0DS4hmMo0tdpjVpyjyhoZ807ygN+xZTY9VE?=
 =?us-ascii?Q?oHeJ+x6TUp60msd7ennmm0WQl7IKgBTfrvX3tWCD32oC6040KIgXIHteFf9w?=
 =?us-ascii?Q?9uA1mBVb7aDS0ZSzrejdSel5TAw1ISOVitXwDUyyqeWkTHqNPP6aaSjexPyN?=
 =?us-ascii?Q?XoDjnaydjp/QPjXhIa4jA6RZKfInBwrYeBLDAx8WRi0qkMEw5H2IbKTUI9Bf?=
 =?us-ascii?Q?4zsK0Yb7AtDXZOWj/l21v6y5CEXHEsvrAy0avNyiqpnogfduq3KfFAwHj5QH?=
 =?us-ascii?Q?/cd38uo0iH+eiHu9dQGP/MDr/3qcxIXP1h7x4i7DMgFvd6VNDWWiT4wGxe1U?=
 =?us-ascii?Q?0xSfF7ZE+x6teYzQKh1Y0fqc2NTHXP22XdCijzUt6PSF7s6Em/NmNshcSo1r?=
 =?us-ascii?Q?GCt4E9FgDY/iXDwV/0c3aN/T0HyW1zZDtYgbkG8ahpR87vSlFqrWCCjiqb2o?=
 =?us-ascii?Q?BnXkni/dpmMneQBIkJivps2JQ/jK/cVCP7QBsYBZh4qgCWc+zJ2k7JrAO3vQ?=
 =?us-ascii?Q?u3PiAPIL8Cs4HwXGdVNXponFGfGnTe+A5QzyOfrn1qDYGep9IA0u4TOq7TlN?=
 =?us-ascii?Q?y7BooYsQJkol5BGciXLK9wCxlywxldLue/wpCutA/aohgT4vEQwUkSZMkTZg?=
 =?us-ascii?Q?tpFs82/zhx0g0GleVIJX/1/RmtvdM1hNKkBVjlVtknchfBcNiTevYYjZdQ0U?=
 =?us-ascii?Q?J7JrF3yoxBX9dAWklBZeZPy1fjlM6TUFRsfg2h/5xGpXfaHfqL1OOCVQnT9D?=
 =?us-ascii?Q?poA59/pffW+n9YuGAdGHz+LsbOlUn4RZVtwcMoKZxz/7EWSAmRgRLhT+NReU?=
 =?us-ascii?Q?KWuNzdaoPv34bm+CQ7SLwXVLA8dcTNlQ+/qk2UPTdwCYZkCVVLUBnOFs6CCq?=
 =?us-ascii?Q?ik6uh+YHJgozA9Wj2l9cDRDeng0S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:37:34.0247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6502f848-874b-42b6-543a-08dc7936968e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

Fix a warning about potential string truncation based on the
string buffer sizes.  We can add some hints to the string format
specifier to set limits on the resulting possible string to
squelch the complaints.

Fixes: 1d062b7b6f64 ("ionic: Add basic adminq support")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 24870da3f484..12fda3b860b9 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -242,7 +242,7 @@ static int ionic_request_irq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 		name = dev_name(dev);
 
 	snprintf(intr->name, sizeof(intr->name),
-		 "%s-%s-%s", IONIC_DRV_NAME, name, q->name);
+		 "%.5s-%.16s-%.8s", IONIC_DRV_NAME, name, q->name);
 
 	return devm_request_irq(dev, intr->vector, ionic_isr,
 				0, intr->name, &qcq->napi);
-- 
2.17.1


