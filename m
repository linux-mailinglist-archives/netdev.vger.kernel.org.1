Return-Path: <netdev+bounces-145958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3E49D15AE
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5228B28F57
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EE91C7274;
	Mon, 18 Nov 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z4I4ueKr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF661C4A1B;
	Mon, 18 Nov 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948323; cv=fail; b=KK7IjCJ3DDSfnAw3Jqy/DxXefZCsUw6LoIq+mA8oW4E2IyIfJ+qyVhlfslmQRLtw2ju1eDlEyLoEy+9CQJvRWHTQlpWtvUWgkadhBOvpYXv66oGWMyDPcSVonY8nXHy/g5bwCCK0bMzfhn5dbxKg04ManqwEbrN0WorK1X+LRwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948323; c=relaxed/simple;
	bh=DKL8+YL0lnjZzV+/zM7DlbVYq/Omu/Yd6SY8k0Cx+TI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0GIqUc2sKp5WiUY5I8A9jWnlncGWvqpWtgk02XlFtu7tsSczzfAjSQUykxr9pB1W72ifIAiaVhkXnCXjYqC4y7wgiUgnUwDFUBCWrbNwOyHc1RLswZj2IXuYSvw6j/f3H1ndfpNqM/FOBjFUiTTVuhSwYcjHIBMT9COsMUByOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z4I4ueKr; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GU+gOqmv9n88grsI60YmepSeAosLfmP2opLnBGSfMnXKOvd9XkbJRGM/IzkvSEx+EfwcJ/Uv9TCpQQhYW2MQsIw0gmSAwxi18gvXfRvJEXxZe96NCgvlWdeO7NlNevnTlDhdJHpH11Tzeqh5WodH4Twqkulo0J8TS+ORIulHBVVFq0CCt7E2uSNleZMd3wdXR3K7QqD3/CVg/8UKhWn2wIr7bcrVEzKIp+6OeuPMU5xpbyf+rpd0VnBAW/zrIYzG7wDYlLWRO+ITxrDhCgn3zc0VSwqmWC63PJSeP4BsoT+ra15Vkt0FbNIE6uGO6DyGEP4GgGCjO8s0rD8+ANXtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPHKfEcxkm5tEvQ0CG+U/gqb2HSBdQzhKft+LHQvvLk=;
 b=vmVyqECi8e9YIgel+it/jGNwRaFt5CnwU+NAciExu4/J5B5lMCjaVUbDGH7/ABSSCFN9hMj6rSiUoNQd30Vpevp6Xy6ErcYaN+gnfglZnZS90e0Jfb4J9mj3Fe9OqYrF2p7n6Pu7jhMZWj1ZnlHF+2N/0NYV6MtXMjybSIWGweTCvrRgHO7+yaFIIPw1acGNM88PnEnUYBCNfOAtqXO5bJNj6AIjDl/Qc+en61r2gm4A5nVxOCswVJRUCAdqohmDqaiS4sEfuzQs8IdJYTQo3aM3ad6uvVDFZLDZ9gFIKOCmJbduDTH5G5PRZVsAICL+5ekaNwa31RLdws2izHtXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPHKfEcxkm5tEvQ0CG+U/gqb2HSBdQzhKft+LHQvvLk=;
 b=Z4I4ueKreT9ncDU+nfXB/Cej6idP3BRNQHmheuj5dtwUST59+Fn8SKVEXuH16/Ua4pWS23z+vIBLEkH468N9bMIfSFZUe6RP/zd+x48ZZIFeC2zKFqncweM3A+UREyhBLZt2sf6Uscx6EaZ6grCTIkw7iZhO8WrWOwAQG2v+xKg=
Received: from BYAPR06CA0057.namprd06.prod.outlook.com (2603:10b6:a03:14b::34)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:45:17 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::1c) by BYAPR06CA0057.outlook.office365.com
 (2603:10b6:a03:14b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:13 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:12 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 21/27] cxl/region: factor out interleave granularity setup
Date: Mon, 18 Nov 2024 16:44:28 +0000
Message-ID: <20241118164434.7551-22-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: a27f14a9-8150-4a12-48a5-08dd07f06218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7n2fK0MhWtFoqtrOtkt6nTVbtntbb5K3WFuI09+B38YbPOHIfHd1YUTCBYH?=
 =?us-ascii?Q?ozkbwmRMCo3H0l5a/Zmp7Ij9aDaHob1mtxxa8q/5hpYxrRtDr2AaQHHvCLzu?=
 =?us-ascii?Q?cjQRSwYAKiS+cd/oiNCSINZQHpe1V8pWY2mw9GcU2SEj+9PMrEdTJqSfAdcW?=
 =?us-ascii?Q?d5GVfQai6UY6hVhABG/a2DX23bg0cm9/b9jAZXWHqvU7vzVVB3h0rRdCcjCD?=
 =?us-ascii?Q?7DVuw6NlLGNaPqCGGJwH76bmpma5dlaUfT9j4nMZjjdwjt0H+jCSbC1NuBuC?=
 =?us-ascii?Q?S0cTP+6BLJvb8XCDVeDpF9wc+HlzKy5n2Fj9WfqCE8/zNrwqWs0Ns2u9PTn/?=
 =?us-ascii?Q?p5WsmBDVCyOA32NvL1MobAEtdlC/KMVcmP9tOAEaycxAV8xDGpDucmty6EvS?=
 =?us-ascii?Q?jBtsnGM4QiceRDWAprZ9sbPQX2mtbf0yV5/LnHL6lhFsgIUZfu0n48vtpP2z?=
 =?us-ascii?Q?kRVBCajzka8xzlZLDfgl6S1NYeJUk2KvEEuF3tQNQzt/Fbvlm7wQxG1ZGH+x?=
 =?us-ascii?Q?CvfemJSiVtI96jai1GFmorwxbFSeGPk7qmGthPbn7BlAVCDk37sIF78LyaQQ?=
 =?us-ascii?Q?1bu1dlO6Cl3TbEQc9ecA0iKsU/V0xopt+VHY3hVzA/+bSwADYD1/XIck7dyD?=
 =?us-ascii?Q?YLEShBInu+aN8A74alC93klM7PQR5e9oXIIww8S7ZLB6SK/K/qwpyhGRFw7W?=
 =?us-ascii?Q?C0bUmcddVvdnsodZqHsFegim5Ca/Cklz4pU39ixv4PCBlXTi/3WsZKxS6Sck?=
 =?us-ascii?Q?XLvA9bm4ydpFhLlQhCo6AOu6S3wd15mVfNRR/A9PozvFkuhoaI8HmgTT7o17?=
 =?us-ascii?Q?/A5vaZK7ONdrS0diZrQfWVBVRByEolm2v41Padenf/EAGEvdk2sEO5nUQncf?=
 =?us-ascii?Q?OaAjP5o0gEHtcapiHWHcgfkrF+3wAbj5OcZQWELWbMpVvS7enRXX7qmDdOTt?=
 =?us-ascii?Q?Jry2yTGMgSrVLIkOmzpIvOxZUahTZpiV2I/Xadr0qcWFNufb1kkHP1Tn0srr?=
 =?us-ascii?Q?W1bgZS5EgFe1j0KRnvo+hVeHzHVDrIyctjm/Tjc7m7+BNjrMHAIhnJqghp0J?=
 =?us-ascii?Q?MBG40OR3X0IdTmDUnP4m3mP/28KiGXLYFs3dfwQ4XsL0m1D56WBObFN/fJXV?=
 =?us-ascii?Q?EP5OUHcYpOTxRqcEUsV1Ps8Ye1YN1sE8f16nvfTdyZmdM1ZbmIGdDla8sjcz?=
 =?us-ascii?Q?TGWq7axeDo++nvex9TPhkUeGFTS4lg/VANPNeATCbO8KtMHcqy5h6U/cuQll?=
 =?us-ascii?Q?hDnnar/viO/jolPbsqsdvH8kZJctcEXdhkPH2mp+gdxg37+zgOD2FZh0eqUy?=
 =?us-ascii?Q?qoVSvcpWq6Apcd5VIQ8CsDKd3aMH8GnxYuXxdRS4BRvGvr/OExSmnitaUbU9?=
 =?us-ascii?Q?0p9KupNIPt32mNEPqHEBtEirG8f/zYnjTR8Lb+7jGPeKYYdhGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:17.3907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27f14a9-8150-4a12-48a5-08dd07f06218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 04f82adb763f..6652887ea396 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -540,21 +540,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return rc;
 }
 
-static ssize_t interleave_granularity_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc;
 	u16 ig;
 
-	rc = kstrtoint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
@@ -570,16 +563,30 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
+
+	p->interleave_granularity = val;
+	return 0;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc, val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
 	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
 
-	p->interleave_granularity = val;
-out:
+	rc = set_interleave_granularity(cxlr, val);
 	up_write(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-- 
2.17.1


