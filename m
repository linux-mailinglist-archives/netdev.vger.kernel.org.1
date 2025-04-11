Return-Path: <netdev+bounces-181746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247CFA86564
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A66B4E2469
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EC625A2C9;
	Fri, 11 Apr 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mhS7dw0+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D1259C90;
	Fri, 11 Apr 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395727; cv=fail; b=d1AxdbjLnQO+P4esNKETdeFAMARuF1H7d0z/UD4xTRsDhh14SJxpkCjTafkdQh+952AEy+7CDMoU1gwSYb3dvDplrOyjeHUXsMC9pvrGfJ/hdEUdyBLiUbv3nzNGtRQTMP2jojgklMn2hVe76jGoOwW6g9dalfEks9PQIetG3Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395727; c=relaxed/simple;
	bh=QLFUuUcxZuCvsEVPi6t89jEdrOUJLW0vjvAk5/3yWRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WEICT4upaCICxVH/SipnhHZtPbgh8VT2e7hND1AcZ1Py+WvDnY4a2CZO6S0zLWZk7NticyWkWGU4QBHCA4pA2oS/NjO+Z6PhExjaPfp1+KO0iEPbER/Fr6LGreXyOYgrKqvHQIkxz2wq2HHlq1XwK2T3yTSViwVvrJpqrJJAYDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mhS7dw0+; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCUYpWkN/jvigTBPZtMdGao6n5oBFuQrEZ+nLVWmSHoofSnq9xSPongS+/fnueZK1ZQggaRVVSKOV86rR/SWJrVCeNO68C2ozUr/9rEWcErG6JJ3V5i02JtuUi7iXPL1BVw6a7rhCGB92RmCowirJk29BwsNQr5uO9PHrEBFNWK+thLqzUp/xmv08dFhlpoit/pHwt84VLKIvioprRJN6SNQRTOMn5ZFSdNDl7QA3GcvOdg3oP5GEuKjdKe8/nZKw1Z1AbDZ7ObWxDgMEzH/SLpshxYeXTdS50PnXmQ5Nt690CiX2fCgnB27OFBIR/rftVtYVuAK5FviYdGMZRG2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSU7uv8KJaftHyZKapnFKE/TJWSDM1dQC9JXZEkcQSQ=;
 b=grth3i0QTOxf3NycE2/zE1ppogIDtUFOsyzFMb/yivdqWG4suEchTYvRUvUR3vsK6ChhUZDtjIT7JHkYvjgLKlxp9zQu08oJhqV/8qskORPEbnGmpNxXGNK0HkGD1D1HDNntwCmvpVoAro+2BUWBHb6533UKmrN3AYKZtErpJeqxCjSky0urVzhz8RXRS+vp5L51MjcLP/lW76VQUlWUxn2uk4e2RZ/Qe3g6p/ndKBeKM2IjtQ5pa5Y1V7HlTOHctXmRn+IVkgGWY+aMcDfKRQXnrr3cva5PEcc7iS+LBBemVf1udAsX7W8FUocGgiDAbmoq0uVzaWNOOkyo191b9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSU7uv8KJaftHyZKapnFKE/TJWSDM1dQC9JXZEkcQSQ=;
 b=mhS7dw0+X6zARZxUBfcqhBQdxv30UlnVnU7MLndLveWiCh1DGMGeMExKO0KLMz5AXu1AIrgDrOTz9gL+MfrGv7UiNwR/1XhLhREgKfo1JXZUEO3YaljjpVDqj91gYkbrDSLpnMdaNoZSPqjs7rFrQG3LjesnhL1EHXNTg8D6++4=
Received: from DS7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::27) by
 SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Fri, 11 Apr
 2025 18:21:59 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::ac) by DS7P222CA0015.outlook.office365.com
 (2603:10b6:8:2e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 18:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 18:21:58 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:21:57 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 0/3] ionic: support QSFP CMIS
Date: Fri, 11 Apr 2025 11:21:37 -0700
Message-ID: <20250411182140.63158-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f407bc-4b6e-49b0-fc66-08dd7925bf59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3cMYbb4R/8fZH4XjgTtoXvW0NuEvkGE9/rtNp6ql2eEGq6tA+TohYv75UE/L?=
 =?us-ascii?Q?LbediJMKpjJstPDP6m9V/l2alRHgftEZMN3kIvuPDj+ulzyeFBTR5Ie2Yy6J?=
 =?us-ascii?Q?z3lauqADYJR5FP4Z3QJP5F2y1+VyUk5AzCST+ZKh8NNkA1fl0bQ+zJxY4c2D?=
 =?us-ascii?Q?JLueBtPTdLu6q5guwxhMMk/ryL5NKgQ3bssDK29bM36naMLxvSqPYLST7pH1?=
 =?us-ascii?Q?ptTKzRT3wOG6QvKP3MR/9mXUD6dfeqGf9WEoUgKlknh/g6KX/bnD3hUPlxWU?=
 =?us-ascii?Q?Y2o3hAWbvIupuXWd2Yk/JS1DA8FACKMvLnxMombN6VOk5a7f1leZAivI6sf/?=
 =?us-ascii?Q?0nKmdhGcI/FlpHLu7CtBB+TmAuYVTWkMlVTxANnTKuULO9cqDXplLYHDlCSK?=
 =?us-ascii?Q?+uQp7N5xOYNZ1PnWJ5rIgk5wISV+qPvziPooGcE8plE70ZhO0rTasTCyIjKP?=
 =?us-ascii?Q?bMo3REqdhU7ujamY4zwh4p/8VnelGHadom6nM/RQWxezgM8L9UXIiDGUL9m+?=
 =?us-ascii?Q?v3tYlqUryTspArxtCn1AaEmDoHSmQygYMSyQa9ux0WTSvRnH/IKHe1ibZthL?=
 =?us-ascii?Q?lzGoCLV93fSI47RViCLCamH5ih38LmuQw6A7qBdZkyODI1V7og/gZgd5djuT?=
 =?us-ascii?Q?fjigdS3IgdpZ4Idnc6OuhSvZzy+mV2Rq7AdZ/fB4fPAtrhKo5iRc+cZVcL1B?=
 =?us-ascii?Q?JmEnFy7OWbpNJbvAHELF9d6NXNngT7VyFnOx4flfkwQ3ZE8swdKCTKHED5UY?=
 =?us-ascii?Q?nC3VLFX4bCjte1C9iorM4xMBLgSzvU8yfb+e6m8HAITC7mVFAzNur5ao3tx3?=
 =?us-ascii?Q?UP6nuD6NuQwV+b2YVNH0ue5a5GK4nlegPxtYKd8S4d0R/6Kq14zimULt6TEQ?=
 =?us-ascii?Q?H/XP0CtNvyoqtl1yJb4+w+K/WtBLaEpEmbNuP3nL8eUeO3CG7WrHDObc/Xmq?=
 =?us-ascii?Q?iBVoxWVlz0NuXCCVGMDNRbk6y99iUuWfHscI+tukVxWZmUcHcdav+3vk/0pI?=
 =?us-ascii?Q?wDTXtdiyMLrmWUahG1TGeKAiIJBS/+vLLb7aGbLv3fLndvcwCVK22yjiNWQC?=
 =?us-ascii?Q?nZl0ODHrjTi8jAjVipjoCyQA90LsQPOQhobxW2gmtb0RmPyqzVTJ/eYgFPi9?=
 =?us-ascii?Q?7PEyZENUnipEPZD1IvPk1taQBdGr6WmDoBK55PFITaFn9z0CDIrgcL3PPK88?=
 =?us-ascii?Q?I7UDhx1hUG2mzyh7vnQj5trxS1G0hzkG6HVAQE+fnYFXvakOTOYwm2E2GQmj?=
 =?us-ascii?Q?46uaYB4uGBMli7HX4gPWj2cBG4k97hJJzKtghVg8Sxf0yh+YxFfMA3qCPLxn?=
 =?us-ascii?Q?iRyNQ5B8qH7In47MnaGIr2rUTurCXRQIQonlo+IuORZw4WXvCmOHLRlIe4kt?=
 =?us-ascii?Q?kFym9AgUu0TWQ5To2Rz13b6Y7g6nXs+/H0ipDEjB2Y/AHt3cLDUOKUQ8RiyE?=
 =?us-ascii?Q?4Jw4dyJVAxqN/uS3wC/MhstSi8TJRatKynCdtjdVC53f/F2IksDvBaDop8k5?=
 =?us-ascii?Q?f67wTIPFgfjlB40jtA0UQwSy+LuPS9wNxeDA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:21:58.6793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f407bc-4b6e-49b0-fc66-08dd7925bf59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955

This patchset sets up support for additional pages and better
handling of the QSFP CMIS data.

Shannon Nelson (3):
  ionic: extend the QSFP module sprom for more pages
  ionic: support ethtool get_module_eeprom_by_page
  ionic: add module eeprom channel data to ionic_if and ethtool

 .../ethernet/pensando/ionic/ionic_ethtool.c   | 119 +++++++++++++++---
 .../net/ethernet/pensando/ionic/ionic_if.h    |  17 ++-
 2 files changed, 119 insertions(+), 17 deletions(-)

-- 
2.17.1


