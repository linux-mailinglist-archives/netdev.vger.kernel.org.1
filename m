Return-Path: <netdev+bounces-145956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC849D15AB
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE0C1F20FD4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14D156236;
	Mon, 18 Nov 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s3KeEBC5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE31C4A04;
	Mon, 18 Nov 2024 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948321; cv=fail; b=TVE7v5bh9IrnYU83eglS1HeCnVj1y8eBcfvYHqLMA2K3r0ElWOrSnAg9Ppim0t40s799d8UYdkJscNRw5OoriDeRP8CLvQtRfTVRV6qImXwL5IwImpl1O50UN9h9uf+nHeoyjQvHfZkvWJ17/NrXSXDp5FJBdc+RUXSgyeeP6xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948321; c=relaxed/simple;
	bh=B0QUXCU6IbXWHz5DpjxOZQkzu5QAjfWd6lqDjhzSSJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nR7yqH6/EIL9FKPH4kyaDRLYhmx3wzs4sRYbxqNKk9Z8OecVrXRDxC6V+l/3+faXqOvJmAFhWm2605klDXF6DCYrMI34dHj2yTHOsfwIAfEwKQY9dDoJr1ma4KqvO+992kxS8EJbhFFs9FuooKTYw7CgEkl9jGjjE0Yxd4n+zkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s3KeEBC5; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvdzVWsujE5Ry2JbGKBNi9027n0rNro2CUqXOQT2kcRoL/OUdJC+lfYj9irqRBT6yTngeNzPvMtd5rjQ7pVAPOWrVZfFtVRGZy8CcHwRayKuRENzesTGdwqV8V3kA+OEIn/JLzQmmHADYtc3zAMUkZLTbQCdI2U8RlWA73ghJW/NsAbjhhGPRbIAuCeJdeMvrOc5hDcKsKecaxMTGazNXgBGJO6sm2AoxYnOKruw3mQnZZEEQkrqrik1gR5hWpR8A+siZiHy4RXu62l6gJhDSfLhsaUQoEwTQDp4I0oAOFxdX7h+ri6Gh2BKs2IN7NCWkXqG/f07zDCd//ykbWe1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQEdRkuVV37XnlTg/2DcUX88ZW7VVdWdMJ+ESHujp+I=;
 b=F4bBGygBVejecv1yOhjT7Ean2i8YXqWyxUBZVe0b5IoTXUNvkHdqRO0mwai4rEp7urjCEXobZlaN6ifmkKMDfKzdLOnTg4HcCbW46FjfLai29LBncdnYe65DMIqeYELxzUAqxY4H/nH9s1OBfsYhoRGOdWXHSoHuw7fSID6zOh0czsvmcgQMUffJBlz7r7Q3W7tdp4qAaJcbTltdytGXC7DHNdYTPdV3abGH+Ttb9UoR/TNF51mV5qiZY6H7YGa36ZyNvv4gp68Wn66VMM0v7cqjtZLoKNXisYowCI2JS1/viikfyVumMmOAa4eYihh2q1eG+NCzPxOUQREDvNxZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQEdRkuVV37XnlTg/2DcUX88ZW7VVdWdMJ+ESHujp+I=;
 b=s3KeEBC5AeRL00/yqDBbQCCeyMFApmj1wdf6xLx9rUImqCflL68hMDlvGVGydTRiS07D9ud5ePzi3Cz4u+Phhapmtu3D1pI2Quv+FMDOFaI6UQhzMdjmNlMZRemEr6NNDFw8kPv1s8peud8/IcQGrllNWJ0U5rflnmLiLvsSgz0=
Received: from BYAPR06CA0042.namprd06.prod.outlook.com (2603:10b6:a03:14b::19)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:45:13 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::c1) by BYAPR06CA0042.outlook.office365.com
 (2603:10b6:a03:14b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:10 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:09 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 19/27] cxl: make region type based on endpoint type
Date: Mon, 18 Nov 2024 16:44:26 +0000
Message-ID: <20241118164434.7551-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: b2175669-fdbe-4490-5313-08dd07f05f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A381OjkLbUGqV9nuNOKMclqBmXRuneOFT4kIkPEESS+AHrsR+Pzz0KjfHoG+?=
 =?us-ascii?Q?nnK0RB/sdFSjvupGUsFte2hvCZ8uqJVDVK2THzvQPiOmJYEWmFdXDVbznq0s?=
 =?us-ascii?Q?AFgKONkC2ZQBxqzl1eljvbezzxZuYyRsOfjSYIM/6HUJuVd0zGLkEzwmbDO5?=
 =?us-ascii?Q?euGfdPSQWOSxGFSrFOcK3Y2CBGBRKH684d9+4aJUVm9fYqVo5KeLMK3SDgAJ?=
 =?us-ascii?Q?yof3RzJEr+3N6oKR7+YUWXOth99Coq5dU5BlKlQF+vpDx6XhtyHBIvojEsBk?=
 =?us-ascii?Q?ekn6LAlyqeOaLEVZC7cf+L8wDaGqwV1yGhKpWfkn+33IKWrTT4ymhBfITmI4?=
 =?us-ascii?Q?Qa327M8ULA11EqqfKsYSvKbRT5wUYNxX8kTjN5dA3DXnM5mBk5l6uJE08tGZ?=
 =?us-ascii?Q?NExQOTKutlW/3TK6J3E2OlBzftK4NhH2KmPJwLQ6CQwACKKERIvwvlBBDTnK?=
 =?us-ascii?Q?rurGcd0M5r4htHCORAa0bPeuGxKo9K/UBWfLgLsdUm33NbBDPeLoKv3yI0mT?=
 =?us-ascii?Q?BUbO5092KR7MugEcWxb7wuwYUvG1jzML6HXc2A/jeclU7ELDitIdI5Sy5C1M?=
 =?us-ascii?Q?bzcwvy4IvnjxSE1Ju4juQygvHC4zeDJ8Mel8857XXon6dDOt2YKvbWCHS2Y1?=
 =?us-ascii?Q?ksdWDUrR3Q1pHcwTu7T76L1PdrHMCZCbGEajH5PqnKJ/0vEgogVX5r1ZRAWR?=
 =?us-ascii?Q?At96dftKVqPHBU2P29RI+Bnhp4GQThHmFqHTnCPYitMveTbLV2RXb+b/fX+r?=
 =?us-ascii?Q?UQcw6DKLgwmYQb1asblNS1Cs1Klg4ccgmsSfiEeK9SAbhK7P6WUNpnKH8+pq?=
 =?us-ascii?Q?9siaNZHiEDnyT09FkV5yICjL1EZ8mpQGt2M/UBOP5xqlS+/SMBUg0008uR2M?=
 =?us-ascii?Q?HMO5iuRn+fw8WZlFUWSS+1UX00IXJMd35X3e06efxGo+iZ3BWmfrZKFBEaRD?=
 =?us-ascii?Q?8HZyr0alms9aEHffzpanCTLopJry8GmxXxSaX9Zo5YHEMdqLg3k6WaHIh2n/?=
 =?us-ascii?Q?U+7wBDavAVy+ISGsb4mSGvhxoVcpc6S3ZuwvuG9dEKxkBSIlGfTipXkzqIvP?=
 =?us-ascii?Q?LZ/ywvG6c7ZSXgXhTfsd3+M2giUpk09zulG5Mc5JJrnemgGGh6XPAI4aatZ6?=
 =?us-ascii?Q?776BvMcXcqeRzmXOUYXTiimgA1J8UcpZ/qHCzJEfMyE0raeBgb5YUyxUs0tM?=
 =?us-ascii?Q?TYTfSVev9DS/Jmbp0bNSnr5VS8TjgeWtLu26QuR/mlqCh3P0wctORe//38Kx?=
 =?us-ascii?Q?Go2q0bwT5icu7lXa2WGlshgsGetOquQcO4XHearVyxtWZrvnCDMmOOJiUmzV?=
 =?us-ascii?Q?yi2MJQnAWQ9SXxGiU48RsiwMLsKZIaPqt5CB/ypbNDuCuAPHcA3rN5LvT4Q/?=
 =?us-ascii?Q?4Lnz0SKl14v9cOnZPqbDg2eX3u8kF37jkZMLeWDuGs3AR0auFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:12.9532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2175669-fdbe-4490-5313-08dd07f05f7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d107cc1b4350..8e2dbd15cfc0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2654,7 +2654,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  enum cxl_decoder_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2676,7 +2677,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
@@ -2691,7 +2692,8 @@ static ssize_t create_pmem_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
+	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id,
+			       CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2711,7 +2713,8 @@ static ssize_t create_ram_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
+	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id,
+			       CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3372,7 +3375,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.17.1


