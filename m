Return-Path: <netdev+bounces-212888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48211B22695
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C51B65F8B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E92EFD8C;
	Tue, 12 Aug 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ElG2aRWm"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5B2EF675;
	Tue, 12 Aug 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000846; cv=fail; b=knHBwVY9isruzmml4n20DjuiG5PqHwU2Vd1bb3i9XllClQl42tEg2q4kcnG+beKyIowIhIJFMM+P/cameQwfFHrc5i0g+aqmCHLfqJ4ISVnyl+VUa1xHF+6wc77nG/25mWpSffsC1Z1sTvOlCxX3kvqB5nf3nbopx9TWb0ZC6xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000846; c=relaxed/simple;
	bh=rwyxdZnBNThELnhBCYD2Mez6zrxdB8pVJjjc7UTpVGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eY7CVtJcA04hELd8PbmSVq8oMXirHwYkIEFztJSSF3AvU5dOZC6wmc0/YEn/OFVXz2K+ZeIUJZFrtP9TG/Y+4vqzAcbTjbim68coU5YtlAma958bta2eCsqXSVkuRqKmJSf6lPo6yzJ8OySCHi3iqNXuwdEzOXxfvUbVm8I5ok8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ElG2aRWm; arc=fail smtp.client-ip=40.107.130.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0B9UnD1vOrTj/A0umdkiU1z0JiWzSQlks78qDKU8maK33a+G11Jwzgh5amYAXKKPelawcnd19kHy/GVogDVQMFNPKTULSl4G6ju5Q/SibiH1Ns1AQgSUyBpE2xzwczfTlwB4fM2vDbbjVd3HGLnq1RqQ52tboUKSyV6YsXiMHnOg9Dv3FbbGL1/RhpQnN38xB9KxnkHRy/3wTPXyO960p+2P1AfYZZJ5q9e7WIYqA3GZe7EJeHb0IuLyBthtXBdLpDk+2O+fXlOKwWZuG7BPhjkBLe4cs1rT0u5ON+uGJdSblewYsKtkljJqAifo2wi7YnNoarYXcBeeHRgTpCmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3noDpYBHWQRuOPtqI9Ni5m1WQ49HIJ39bw6kOFRUEA=;
 b=yiRfUNkvSdecw36cJjZTiQiX7TFncXacGYM9zhXNAvsTrxtw/BHuCfKxl5i4SW2PLVFJBYs7mbhToFvzF56CaeHMiRObvBGle+Q3J7FEU+9Yhy8kE4FYaZA38lMWNNj6p1okzBmv45IbqJc7jWUa/l0xw3GmBOk9hiEfZD9/biWyWEQwuG1qo+vvpVQPUs/QpiNfx/frhM9nAELT/XTgE3i5OJX2pmruwXl+wxgxtczYim8b5djzydARmouLuFLzqlpg3eT9VTA7rLIluhZEKFXziEH7l5rChR65pN4Z5sPpfI+1/xaizEgJiggx79Im2N3SbvrgRESTKcH/sla3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3noDpYBHWQRuOPtqI9Ni5m1WQ49HIJ39bw6kOFRUEA=;
 b=ElG2aRWmQNyOYtTWAHB7iedQha7iIufaOuVvTzt3i+i82inVaKgMH2NbZ4+5cGv/yGFLVwXo9Z9yktVORLFIYS0O6oqIxk1eJVLRdq+2Xva9HO2nthy+yjksmODMlHxQP52Rtbn4Il1SERKF8WsqjzttijojUM/Fy5jdkDLidUs=
Received: from AS9PR06CA0654.eurprd06.prod.outlook.com (2603:10a6:20b:46f::30)
 by GV1PR02MB10718.eurprd02.prod.outlook.com (2603:10a6:150:16a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 12:14:00 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:20b:46f:cafe::67) by AS9PR06CA0654.outlook.office365.com
 (2603:10a6:20b:46f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 12:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 12:13:59 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 12 Aug
 2025 14:13:58 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <kernel@axis.com>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND net-next v2] net: enetc: Remove error print for
 devm_add_action_or_reset()
User-Agent: a.out
Date: Tue, 12 Aug 2025 14:13:58 +0200
Message-ID: <pnd1ppghh4p.a.out@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|GV1PR02MB10718:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e0d6e9-6c3f-4fbf-5842-08ddd999b813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nyxrkiP6GVYP7nzB7hP2hRBw0IzcZqBkpH1i2IslYvLhkb/v+ViIgbfe/BnJ?=
 =?us-ascii?Q?v9uogVX5Ymj6vnbNPQwywz6Vj/MeX5SmTV17Ipy5g6xV3oD4DikPZpVqlSYO?=
 =?us-ascii?Q?AjQeqeszecL0M9SWoi6eps9iGbyJCGZ4vHsBU9jEzY/YvcsJtR0LDKy9UfUm?=
 =?us-ascii?Q?/hrWvD7hSKpkRXAm9hbGtH/u/2YHv/Kmovep4cGminum7Pai1a7K6IdYZ4Nx?=
 =?us-ascii?Q?2bEBX9cZh+jNlkgqX7O7rjfL25BDtjlbvcrNIKWJ4JkZK43x15+v/ICLYW0P?=
 =?us-ascii?Q?nnCaV0lMG6VGzlZ3lb/ec29Uir/veYihH/oMDkqz+i/y0aO/EnZtTDdD3rc7?=
 =?us-ascii?Q?x+xqXou3uexnXBptwYBIK5abBZZfasypYDFpfrmR8RQHELko01psBR0aWgtT?=
 =?us-ascii?Q?lrCUz4/v+7xlKLoPcG88S5s6Lornno4uCclul8d3X29xoY9R3mqqkWEGT5a0?=
 =?us-ascii?Q?oJNYIHE8dvUrKjGuGSGZEp7DBThSi8XYM1GRX3gS9TRKZQykofIPa85UEF5C?=
 =?us-ascii?Q?/Rh947D71ZtKNItBK5EWRAiZmaDAvdV6ImhCXROCeN0t141926Iyw/Z/wOqf?=
 =?us-ascii?Q?4ZnyCIYwDV02L+MuaYcc3rGcAKNrQcZtybnAOSQat4klFnpcJ9wiYSkNAO+a?=
 =?us-ascii?Q?Ij9kCql/QcsEjd56dcjoo0GXnsswB82jHXF7idPZjSCBm0R2LgyE/VrT8dFf?=
 =?us-ascii?Q?dI8O1nNDlkZsqFZjNkJHGCmGx7WxmFW+KDHv381Q/CpaPqRkmr0QwGuc4ogr?=
 =?us-ascii?Q?kMgO7TpqX3fJv5fuTYC/c+J2Qs7UKrMI5ul9nnPqeiwXrHJ6OQu7k/RZl2px?=
 =?us-ascii?Q?KQF9TZPYrXOhso7rmEbxR3PgeUXug+pQ86VCBtMCq6aEJ4jk4HyDHVK/4INf?=
 =?us-ascii?Q?5ux9E2Grjk9yCZkR9MXoEsXCLvo3V9ckdU7DUdc0Jh3Fw5HjPHTKR59jHmXj?=
 =?us-ascii?Q?TRKbFWR0De20YM3w9J1vkOqOoWWDtDI8UHnBKmoDya6QKpzcGLlueF/Flv2g?=
 =?us-ascii?Q?sunu5OWK8RvFOaRDSsPknraHWqwL1X+H9OKSdqmCZpPuhA9B8+QF/ce4BSJn?=
 =?us-ascii?Q?QhCJ3elZ9tyzWbvugbGYVnK7RDghcFpsSowVLd410s29O+WVqxyF9Q9vXpne?=
 =?us-ascii?Q?cubjlBXR5V1dLQ1NfnTFAecwvyQtqnQP57whDFpChjBLFiWmR76GE5xtrFM/?=
 =?us-ascii?Q?E9aRIbC7eXa6KoknV/XsZ+cKFJroc6N/LpxNAHJPVx1k+CBioKf6ITHFl71o?=
 =?us-ascii?Q?MV3rnXNPald9VLSo8hiUZw9/BbYtBU8f+CR6Kj0axXsOP+HLjusPixJSdy6J?=
 =?us-ascii?Q?QzeblErmrcmJMNkw143LRdHCZm8LlMA0dFHAAos9z8ZvRBmuOhvqZpt7ystz?=
 =?us-ascii?Q?8s48CDaSb0vMGr10VNdGCz1DCUPFQ0RkNZXfs2GQpLypUVbZnsrG/AbzZAuZ?=
 =?us-ascii?Q?0D0KCZJgwD8u/tBzrdSzYC7Vsz/AxtCtgh/guvU1fA4HfM1z7qzonZebX+Dl?=
 =?us-ascii?Q?41amdlDtPhk7ZL3QrQfPFzi7ZN0DcEF2Llvp?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 12:13:59.7556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e0d6e9-6c3f-4fbf-5842-08ddd999b813
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10718

When `devm_add_action_or_reset()` fails, it is due to a failed memory
allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
anything when error is `-ENOMEM`. Therefore, remove the useless call to
`dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
return the value instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:

* Split the patch to one seperate patch for each sub-system.

Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/

 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b3dc1afeefd1..38fb81db48c2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -1016,8 +1016,7 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
 
 	err = devm_add_action_or_reset(dev, enetc4_pci_remove, pdev);
 	if (err)
-		return dev_err_probe(dev, err,
-				     "Add enetc4_pci_remove() action failed\n");
+		return err;
 
 	/* si is the private data. */
 	si = pci_get_drvdata(pdev);

base-commit: 53e760d8949895390e256e723e7ee46618310361
-- 
2.39.5


