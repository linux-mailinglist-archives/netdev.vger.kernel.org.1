Return-Path: <netdev+bounces-154584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FD9FEB20
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBBD161F68
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68D51B0424;
	Mon, 30 Dec 2024 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bVKVh81H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5041B0404;
	Mon, 30 Dec 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595125; cv=fail; b=O6I9maheKnXEPAnJY+7BkwWj+zohF0VU6EolhW59bEJ8b7TOhzvo+oLKPsnOoNmkt9lzy8exQgHLggVYpkisqcUEhgkx74npfCd3Qh8fQWJ3Rmxr4DIoQy68wFfxB9qad/QQiNN7L3i2FidNlX+IujzoEITPOGSuFMfTOSJQKhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595125; c=relaxed/simple;
	bh=ZG2H+z85slXxWiWcI2TsiapzUuWaf9hnL6+4Kc4ta40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABZFQ9NHukwnDHfNj1BWtODITtS+N3Sb2ny7cipi+sZ7EXd0LgP7YLOFcYP3uRCHX3It9v9TZns1ChueNvMEXHfpIynjtUg8pCzwdfadbFC3yddMvD7TDEbN8qoe8SBnmSfuWAvNpLFFbSOe2r47Qcr68FF+kh9NOeKF8MzbT7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bVKVh81H; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXNdfWWPLS4JabyIyVoqQi2Sc4t5M+skyt3gzqaMdKZknh+UvRsd4N58foirVvYCFOH997UG+V5Z/sCHTXcUDdeYC/GyFQogJXRaAajc6f4SDsio4g420B4rZPmkdKiyPmYjZw9S+E5p9MHsF7tlTHjoL3Xaau9D6pDgnTn+lsZFmNypw5uTd78u22z4bk/Z0CH7VtSsGFkb8oGBmBHQhGpxpHX7P5FPQr1XYX7z47ZHMEqamlOYeFFpeN6OvWm656nQEhJf7hIjdZ16qdfmfXHOJz9XGRAdVaGkyNMDQCXRYp8R35d4dzDoDljCkr3X9t1hv3LM88DVtX741/65WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnnNV3dZRGJH6tGSJoMRQx3oYpYganUMIgqWle/FWTc=;
 b=G3NhLpZ4/p5EK0HtClxEAHIOOiW6CXjtaBv7yZHj02CppPhrCQOAkhcFXBZuHWasw8wlK+3CzJgm58GuoTxxQ+gQJw6+WzI6PzsEVoiXAhCfENVRodH95STTRMrK/gpBzi+oLQ/+qpX7/EFmUxPgj7fWQw1P6QE1TZ76FtEFRoThko1gY344b7433/wU2P/5WjLd66r2PHRiY2GeyGMcDnwSmSEuJmWzrjXhzeysS1sitGXfj69z5VLF01SScihsIOkjm77P/XpT453BIpcXY2rLSgeeZGfxkKE53bGNzDooXZL5FKV0Jt8ND7yP79w5lGpmkEn+zG+jFK+RX2RGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnnNV3dZRGJH6tGSJoMRQx3oYpYganUMIgqWle/FWTc=;
 b=bVKVh81HPFB4ANd5EU4lbehSFCGf/qBObeqt2UPfBSzK7a7V0eQ1kqvjZiIbpqnsIJPOKu6Afkmm9akQCLThDyKVg+qnRs6tKyHPapXtDaLKLBDZuwN5KDG3DIq8XDZ/SA7pC4iunOb7FweuncHEWE8/GQjkxYhzqOex0xD1dqU=
Received: from MN2PR13CA0010.namprd13.prod.outlook.com (2603:10b6:208:160::23)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 21:45:16 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::98) by MN2PR13CA0010.outlook.office365.com
 (2603:10b6:208:160::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.10 via Frontend Transport; Mon,
 30 Dec 2024 21:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:15 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:14 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 15/27] cxl: define a driver interface for HPA free space enumeration
Date: Mon, 30 Dec 2024 21:44:33 +0000
Message-ID: <20241230214445.27602-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 772bde2f-beae-485d-1f37-08dd291b3f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0lqRDRibEdIYU9hMkgrOVZJOXNLdUVnL1V5QlFtTk45TGJ0MkhhbHo1dm5K?=
 =?utf-8?B?Z2ZsdzdDTFQ3RmxjSCtiMjNQd0IvWnhubHRHTGdaa3J2WjhxSFRMT1NVaUdF?=
 =?utf-8?B?b1VScERqak4wNzErVHhEKzByWFp5UFdKMnRQOTA4NWZyOGg5bUpwbzJuYml5?=
 =?utf-8?B?RDgrVGxYaWU0REtoRE5JeXJEZ2JiMEJLZGJUd25EVWJUci8ycEpqSkhVbTFS?=
 =?utf-8?B?emRCeXlEWjF5aC9rQ3ZaempjWkYvdUZOZG5lWVZRV1I3RllQaHg4VDNKakZI?=
 =?utf-8?B?UzNDY25EVmFKTHVDaHprTWExSmVCVTMwRmw1Z25OcnkvSUJLLzhQcytBNDQ1?=
 =?utf-8?B?VE1YTnFVb3Ftd05POVhDS2luSmZnRjFCNWdkQmFYQ1hpZlVtTk1GVWZpQVVk?=
 =?utf-8?B?cXpBZ3M4ZmVtOVJVVUM3NEpBdVlTclBFak9XVHdMb25meWFCenUwaldDZWFl?=
 =?utf-8?B?b3BwaWdZT1pyMUJ2bkRBMGw3OGxsZ1didWNPNnVKeTJpU1NibTVLamx1a2Nm?=
 =?utf-8?B?b1RaRGYvcXMvekVUamwxNnlRZXZ4eGdqWVlZWmEyd2twTTdlM3JISWo2Z1l5?=
 =?utf-8?B?bDRxWVAva25YYXRCZEgva1pka1VrT1BWVjFQa2ZncGsvUkdnelYzcXpKYmJY?=
 =?utf-8?B?bXFOVkw1ZmxiZlRLTDFhZjViNEU0NFlHV09sRWRNd3N2UE5reHZqK01Xdkpm?=
 =?utf-8?B?NlN2SDZ3REMvUE1pLzY3U01nTlhkVDh3M1pUOHJxVjNtTUkwSlpXa0F1Unk4?=
 =?utf-8?B?Y290MG5obGs2SVcyYUIyQVE0ZDVMZFlLRmF1QXJUYWNxWDRlMFJBQ2RnWE5E?=
 =?utf-8?B?dThraHlsUW9RVE1WRHBYM0ttdWJQMnNuZGFkZHVXQ1ZDMUVPRnpYdnV0UURB?=
 =?utf-8?B?dU9Wc1I2Z2RzM1ZhcHVCN3RBN3RuTGNVY1UzSm44bkZvZVpRR1B5TFJ1ek1Z?=
 =?utf-8?B?eGVsUWswaStGV3MweTJBS2U4RWoxZzNrWnBYKzhjZ3N4TFdkKzNpQ3FyaWln?=
 =?utf-8?B?MGQvOEtvdTdvd1ErS21zNmFPcS9aRFgxRVl2QW1kZGJMR2NBSXpPbFVmenpW?=
 =?utf-8?B?R3YyeDQzQVlkWlB2N01NR2p3TWVYbmpUbnViTWUraVZWWnZHQk5ManYxZ1RZ?=
 =?utf-8?B?eS9udU5nR3NRSTFiTGtjNk1UOXJyYklBZWRtZ21QWXZTNFBZV0FuU2FJOCty?=
 =?utf-8?B?VU5IUlZTRFc4UjZROS9QaVFDbUNHTGVPcWZDd28yNzFJOG0xSzRVMTVDNFJl?=
 =?utf-8?B?RDUrWFI0TXJJcFZGOXVIODZkMUlIdlJSNUFYb2tQTmR1ejdPMmVITy8rZytP?=
 =?utf-8?B?ZlBJc0JPTHJodktaODJITmNtSk5pVTlyU1pWR1I1Y2ZxNGk5ZldqWFlpai9p?=
 =?utf-8?B?eFkwUGl3RGV2VXM1OHNDcTlQMWNhdkFQRkF5a3JLZW41MkJkMVFHUVVTREJQ?=
 =?utf-8?B?NDkwVGUyTU5hVFh3dGl1cVc3dUNQMGsxYnNOUGNTUDN6eXY3UnFJVVRwclZ1?=
 =?utf-8?B?L09qcTkwTVVDQmxqWEllSlZZelRyelAzcUQ2L1ZhNnJZUHJyWWpVRHY3VDNL?=
 =?utf-8?B?L3I5b2cxbWVVTHY4Tkx6c2JjQzVpNXczZ1FDVTBDbUdtbnphRG5QeW9Na1pL?=
 =?utf-8?B?NE1uYkYyM2o2Q2oxclhDUTRENzVFeTF0dUQ0S3ArSmFwSGtFNG9FZ0VMWStj?=
 =?utf-8?B?RGVvRE9yRFBtNjY4QjYwNVkzS3JHMk55U2gxaHkzME9TMlpWOGp5WHpnUUJw?=
 =?utf-8?B?Q25jZUMycEJoMWdaY1psRnNzeVJFTTF0STZTdzZWK2tjdW9QbFpDNVBBanor?=
 =?utf-8?B?S3IyN3puSm5IakxKMEZyS0FrUHJKZThFSVJ1Z2NIRkcxVnM4eWkzOVp0L2la?=
 =?utf-8?B?a2hVTDdpYTRjbWRaWGF0VnYvNXdiaXpicnFydzNiVzRoWFpZV2Q5VmpSU3hK?=
 =?utf-8?B?N0lnVmFqV0RpMWwya3czUTM3dmZVUCtZMHVKWXhFVWxyTmZRcitBZ0Uwb1VJ?=
 =?utf-8?Q?tqYH779is8p5QJ4xrBa39uLEJ6E0Ss=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:15.8597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772bde2f-beae-485d-1f37-08dd291b3f4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717

From: Alejandro Lucero <alucerop@amd.com>

CXL region creation involves allocating capacity from device DPA
(device-physical-address space) and assigning it to decode a given HPA
(host-physical-address space). Before determining how much DPA to
allocate the amount of available HPA must be determined. Also, not all
HPA is created equal, some specifically targets RAM, some target PMEM,
some is prepared for device-memory flows like HDM-D and HDM-DB, and some
is host-only (HDM-H).

Wrap all of those concerns into an API that retrieves a root decoder
(platform CXL window) that fits the specified constraints and the
capacity available for a new region.

Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 155 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   3 +
 include/cxl/cxl.h         |   8 ++
 3 files changed, 166 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 967132b49832..239fe49bf6a6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -687,6 +687,161 @@ static int free_hpa(struct cxl_region *cxlr)
 	return 0;
 }
 
+struct cxlrd_max_context {
+	struct device *host_bridge;
+	unsigned long flags;
+	resource_size_t max_hpa;
+	struct cxl_root_decoder *cxlrd;
+};
+
+static int find_max_hpa(struct device *dev, void *data)
+{
+	struct cxlrd_max_context *ctx = data;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
+	struct resource *res, *prev;
+	struct cxl_decoder *cxld;
+	resource_size_t max;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxlsd = &cxlrd->cxlsd;
+	cxld = &cxlsd->cxld;
+	if ((cxld->flags & ctx->flags) != ctx->flags) {
+		dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
+			__func__, cxld->flags, ctx->flags);
+		return 0;
+	}
+
+	/*
+	 * The CXL specs do not forbid an accelerator being part of an
+	 * interleaved HPA range, but it is unlikely and because it simplifies
+	 * the code, don´t allow it.
+	 */
+	if (cxld->interleave_ways != 1) {
+		dev_dbg(dev, "interleave_ways not matching\n");
+		return 0;
+	}
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
+		dev_dbg(dev, "host bridge does not match\n");
+		return 0;
+	}
+
+	/*
+	 * Walk the root decoder resource range relying on cxl_region_rwsem to
+	 * preclude sibling arrival/departure and find the largest free space
+	 * gap.
+	 */
+	lockdep_assert_held_read(&cxl_region_rwsem);
+	max = 0;
+	res = cxlrd->res->child;
+
+	/* With no resource child the whole parent resource is available */
+	if (!res)
+		max = resource_size(cxlrd->res);
+	else
+		max = 0;
+
+	for (prev = NULL; res; prev = res, res = res->sibling) {
+		struct resource *next = res->sibling;
+		resource_size_t free = 0;
+
+		/*
+		 * Sanity check for preventing arithmetic problems below as a
+		 * resource with size 0 could imply using the end field below
+		 * when set to unsigned zero - 1 or all f in hex.
+		 */
+		if (prev && !resource_size(prev))
+			continue;
+
+		if (!prev && res->start > cxlrd->res->start) {
+			free = res->start - cxlrd->res->start;
+			max = max(free, max);
+		}
+		if (prev && res->start > prev->end + 1) {
+			free = res->start - prev->end + 1;
+			max = max(free, max);
+		}
+		if (next && res->end + 1 < next->start) {
+			free = next->start - res->end + 1;
+			max = max(free, max);
+		}
+		if (!next && res->end + 1 < cxlrd->res->end + 1) {
+			free = cxlrd->res->end + 1 - res->end + 1;
+			max = max(free, max);
+		}
+	}
+
+	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
+	if (max > ctx->max_hpa) {
+		if (ctx->cxlrd)
+			put_device(CXLRD_DEV(ctx->cxlrd));
+		get_device(CXLRD_DEV(cxlrd));
+		ctx->cxlrd = cxlrd;
+		ctx->max_hpa = max;
+		dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n",
+			&max);
+	}
+	return 0;
+}
+
+/**
+ * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
+ * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
+ *	    decoder
+ * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
+ * @max_avail_contig: output parameter of max contiguous bytes available in the
+ *		      returned decoder
+ *
+ * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
+ * in (@max_avail_contig))' is a point in time snapshot. If by the time the
+ * caller goes to use this root decoder's capacity the capacity is reduced then
+ * caller needs to loop and retry.
+ *
+ * The returned root decoder has an elevated reference count that needs to be
+ * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
+ * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
+ * does not race.
+ */
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       unsigned long flags,
+					       resource_size_t *max_avail_contig)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxlrd_max_context ctx = {
+		.host_bridge = endpoint->host_bridge,
+		.flags = flags,
+	};
+	struct cxl_port *root_port;
+	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
+
+	if (!is_cxl_endpoint(endpoint)) {
+		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!root) {
+		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	root_port = &root->port;
+	down_read(&cxl_region_rwsem);
+	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
+	up_read(&cxl_region_rwsem);
+
+	if (!ctx.cxlrd)
+		return ERR_PTR(-ENOMEM);
+
+	*max_avail_contig = ctx.max_hpa;
+	return ctx.cxlrd;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
+
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a662b1b88408..efdd4627b774 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -785,6 +785,9 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
+
+#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
+
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index f7ce683465f0..4a8434a2b5da 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -6,6 +6,10 @@
 
 #include <linux/ioport.h>
 
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+
 enum cxl_resource {
 	CXL_RES_DPA,
 	CXL_RES_RAM,
@@ -50,4 +54,8 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 void cxl_set_media_ready(struct cxl_dev_state *cxlds);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds);
+struct cxl_port;
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
+					       unsigned long flags,
+					       resource_size_t *max);
 #endif
-- 
2.17.1


