Return-Path: <netdev+bounces-195883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990BFAD28EF
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195A116F9DC
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF5224B1C;
	Mon,  9 Jun 2025 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kdm8HkPf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA60224257;
	Mon,  9 Jun 2025 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505639; cv=fail; b=eQF3+cJuK6JrM7ajlzPp7dFwJCam3E4qHlatn6E98AINtZwpFQ10/+5z2vlTcwZFNMIjBFyvh7KMEVf5TkBUprja703uUJfm2guFxNTvf4KpUU2AK556Z7kinsj6YwRjMfEnkNn01V8kFWAB1oQyJwk2OMAcEiEce/YsrNT5n1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505639; c=relaxed/simple;
	bh=7GQ4++gIjAlts9XNKEci5H7kTYza53A2tC3Q1F32bfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzWcFKEpJlLeNPi6hDSCC5JjnL5p6gO67mJFHjhbLEsWak88ot1Mymrtwc3pe7CobDSKAfArh2tjbDpdCJwZseThGRLFwnGavAMYFuvC5Jl6noSZZLzSUI2qzxa0ur1mfELMpC8umCAQndcFSPI6Z70zRgDNWXwZmKboHmOi1VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kdm8HkPf; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNf0I+s6uNPLnghjm01IYgIlLZ+Txiay3XFpkKCwxFSMQ+Y3FcimaTk9662BmSMQX+QGH0tUk6P/hRvflyEduLACuFWHjPuuCvzq/K7NsSzYhwXA1Mu1azwzmHn+YfzYQK2+U0/xH/MVk8Pn35WybQ4qV3aGcEcwgewl/5lxV/jj29mNI3tSbMHiAqJ/XyCwoJ7HgSop/YUsLr4U9cTIjBY5uPV3rUmr3lFmpQzdcWZM7605JbHKbrpeOg4IVW13w7D/arNUnGT3PkTLsVkYJElQpu7povVIptIQduyALowy/Z95vKBk3sRoTM5n2A6i9fQ6LZFrpiJN9p3u//3oRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya3kgvaF0yZcn0rBjQ1YxZBNLo4wTXOq2g3jRd9Mt3M=;
 b=WQDn5WYgUBwFqkqmt4mGaXiZm+hg0blbGoH0SWaZhZYtRveyiRYb3S7EDK0cAwm34Ou3vfXGyZBG0hI+PVUKyAkNCN86ICTCwlzqp5jZrbfdYm3AujkmjZfdTZHd4TGpJMJDHSMi9kKvuYnIGH7Iv5VXEVkpVZIVIEFCuefg9p3HX57ZEVbu/bLdTOcrcV/mJZcyLRabcgGFPqaqAbKWQmIJiWw2e4vtw742uHBo60jMgskqTAPPAxiOmfsxYKN6wQS294qsTr8C4oKLSR1QPR3DqT4WL8F5ENg9ZCQLmkufKtjTRQCZxRbIrdrMu2QzRc8PEWl/JUwH5ovfjGab4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya3kgvaF0yZcn0rBjQ1YxZBNLo4wTXOq2g3jRd9Mt3M=;
 b=Kdm8HkPfJVPbh5PPthzU4XaQD2dMg/Ymt4FYVRmPEWgsLPoid5Q4YUirEbgyeXi1qp5II2keVk3Ojjs/AgwBsFDGS9ITI8KY4EyTn+MVRHYnlvN8Yg/UmYWFZNCqqlG/WFTOkaqQWmTFxT7IijvojsmkRB7tdsvZOww4aPG10hk=
Received: from BL0PR02CA0133.namprd02.prod.outlook.com (2603:10b6:208:35::38)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Mon, 9 Jun
 2025 21:47:12 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:35:cafe::d8) by BL0PR02CA0133.outlook.office365.com
 (2603:10b6:208:35::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Mon,
 9 Jun 2025 21:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.2 via Frontend Transport; Mon, 9 Jun 2025 21:47:11 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 16:47:10 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 1/3] ionic: print firmware heartbeat as unsigned
Date: Mon, 9 Jun 2025 14:46:42 -0700
Message-ID: <20250609214644.64851-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609214644.64851-1-shannon.nelson@amd.com>
References: <20250609214644.64851-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7293de-d2b8-4efb-8e55-08dda79f309e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OjW0AeyHJ4t5D/VFVSHho8bsNf33mGOF8jE6qV87TyDvNwNLSpGGVdfs5Vtc?=
 =?us-ascii?Q?fc6ZvcQ0WVfFRuzw/s+H6lCDhs/Jfvi/cuJ3GOBeP1LTTMYLPKCENXSIcQ30?=
 =?us-ascii?Q?zAWMzLe8d/2S9GgARPK1FNC0akDjsqT+T2zcEp/nemzSiUer2q+a/opN2RGL?=
 =?us-ascii?Q?ip1V1yi6wV3bZlCzltdcDWKl0TxQHkMOpvxnjjyCtNXoyAiOXcLqLctftDiA?=
 =?us-ascii?Q?YxqgEnAelS6h//xq6EkU6Js0MuH4P1plMa/hXx9eNYHX6rM8Xkx3lfLm58Y/?=
 =?us-ascii?Q?PTEq3dg7Sw8zG0/GLuzDNITkj7hcMGPUIaFGhCvMi5GFneRkKIulk5ya7Flk?=
 =?us-ascii?Q?qIq4vVcVetWqzqETwUerd2i14UGUiyEuNy9nrF0xkLfWP1OL7JKF6Q2IWJ/O?=
 =?us-ascii?Q?W1hQ4hVD8PgG4Xm0iffli1eYmqNsWuOmdWBpQPMdf4dDiYWqbtTiSKOvWPlO?=
 =?us-ascii?Q?s6ale/nlQJHWEffyDUsG6EkUw/XmK/lQNnUu9IOjcJSpsq0QItdsqC8/KVUB?=
 =?us-ascii?Q?+vbTUM6pnJh5ZuFmKge+9SxqtTVcOpIJK2jXxBp9Y6q21RIVOZpQFh5p6s61?=
 =?us-ascii?Q?G1C7qAhEpOHVGwNt11FXvrtd3a6lg55abSl8mRV9xF/MLYwucwyL2ORYgJvG?=
 =?us-ascii?Q?65gbRzyl2WLX3susldlRXItk9OnoLsmtJVedj6bDWfcL5LIVFYhsqt7mcENo?=
 =?us-ascii?Q?f5o1YieIo0En4XsJs46Wc8GLIRnTwsEceEN3O82MhIZIfVAIr6HN5HXEmtRv?=
 =?us-ascii?Q?+XHUa9l9XmQvJJ2sZ4NNJ/4D7MFx3li+lYdFoCEXjaAAmsTKkh1nc8YRzZ1R?=
 =?us-ascii?Q?vO0S+U8vENKi0r0GlLZv5hmNgcTfViI+AmcVnx64nqaqtkPCs0kGhttWUfwd?=
 =?us-ascii?Q?WeiWTuHFx++S0dMt7dKRDrglEdazKyCW77OJgEekeOx34iTVb+AdZiIYjzbd?=
 =?us-ascii?Q?WKj0F/2L7jByfMmidMXxgNRnx22PSgkPni4QwMI76p+V/AnE3KPywcDs2yUh?=
 =?us-ascii?Q?BZiXoJ7fX5GD8hg5SrWh7lvoVsHAq/JxeVZ72DfCeESp6FFBMBRNPoGW2zJj?=
 =?us-ascii?Q?aGOxfS9Ad/oe/1tLkRpQdWc5HvMdQu8hToVUoxhiME9loSqAmhs3LYxtHRa0?=
 =?us-ascii?Q?VnuRx6Tq3cuhG8GwLBuUvaudI8G6f1Ax3STAktpQk0YUoEeL7pu4sWGYK2B8?=
 =?us-ascii?Q?QzQe5+C36RCsh1CrtXErTkMMTLBJS9P86FEseXEqM7Z6y1fycLURgbawoftw?=
 =?us-ascii?Q?ifFDryu8HM7iIBaLW5HCHA+3XJK9BV2VkOtuWyZJoA+stV9sslOJde3CVYrf?=
 =?us-ascii?Q?AlY1JAoqFQ55D6zKboDeRQ7Cm/jSz/+GLkoZN/I2hU9wb9LukZMgDks4QKwT?=
 =?us-ascii?Q?mA8+XQhxocamGLuoX7fIREVj5gtYIeO6zJbhvl+dFkKXHsQpLoenMblS5fo9?=
 =?us-ascii?Q?HiWgwgDDvhApSTwL8pKJxQtzADNdKSGfOT4FkzZ8xICXWbdJ4Trbjki+xPJy?=
 =?us-ascii?Q?Jr8+37MVHjEcbys7XAejDJDQaCsRVFKlpyNm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 21:47:11.3223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7293de-d2b8-4efb-8e55-08dda79f309e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798

The firmware heartbeat value is an unsigned number, and seeing
a negative number when it gets big is a little disconcerting.
Example:
    ionic 0000:24:00.0: FW heartbeat stalled at -1342169688

Print using the unsigned flag.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 57edcde9e6f8..532faf6d15ee 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -424,9 +424,9 @@ int ionic_heartbeat_check(struct ionic *ionic)
 	if (fw_hb_ready != idev->fw_hb_ready) {
 		idev->fw_hb_ready = fw_hb_ready;
 		if (!fw_hb_ready)
-			dev_info(ionic->dev, "FW heartbeat stalled at %d\n", fw_hb);
+			dev_info(ionic->dev, "FW heartbeat stalled at %u\n", fw_hb);
 		else
-			dev_info(ionic->dev, "FW heartbeat restored at %d\n", fw_hb);
+			dev_info(ionic->dev, "FW heartbeat restored at %u\n", fw_hb);
 	}
 
 	if (!fw_hb_ready)
-- 
2.17.1


