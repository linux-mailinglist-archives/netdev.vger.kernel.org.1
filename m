Return-Path: <netdev+bounces-145962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C139D15B5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FC31F23973
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046251C876B;
	Mon, 18 Nov 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fyb+/+6V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E421C8785;
	Mon, 18 Nov 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948328; cv=fail; b=tf5VTm/3Z9FDchccfE5lcma4dbq+mVvGqLLEZRSR/bllqz6S9cJBolU/plWL6elJ71z4exnziQYtFz3Fn+0qT16ItfU4IchEu+eXyEqiAxqcgl91M4fwZMmbJzLsEVgloPKmxHVD6EQYgRYvn5lq3cv0M9yMJbjrixi+Y6lN34k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948328; c=relaxed/simple;
	bh=dc1ni5bXUxXqa1YVgtgQxEPRTbW8Pm6kR5QxMH138mE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmbgCXixMTm9xZnoS5xHxnAIkf4rH09Oa/4xTakVIlI0E6q3b/zomDIptx4OYYNPbQIGEiZGGoY5drvnIlZsvdz3RNtA3E8VWv8BbvE8hg5zR6SVtnGiREDbtMXbhFKhlNkelAAGXs9ZF95PhYnSHsuAvAZf9hD+YO9Mj9po/Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fyb+/+6V; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jv13ZH9T/pCo1/+qbMcGLSCHN15xO8CLp8F8Y2zLZ68GVdJZRSt+4hEkUJzfEQMjQitcoXh5v3ImsiKCqwh7uQ2qJKOvk0LukTOLkMHQiYYBDJYTTmozlRtrXU9cz9S6rcCV2p5JFvGQnhr+6hV2vg1OLV1HIQoK4VQUX3O454BRDOgXkyDfcTaTmC9uc8xai/6nj2v8PKJet7tsweqK4M41Djg0W4QjJzwXTQJNHbg31RGB1lAu0VkBmMyzBtgp04kdJFJJ+ZXA0iKgczvqXYVktvFcsWPNNY2QnCXZ6z/mUFfPRsnmXooGV9nmm6JCeLzDEcQ4OI8VH8ZgBKwKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CprSceh0v3jYYun6qAkXMr4Ql8RLWy/fFXjmrQxC6g=;
 b=uQBjcts31L5OlwoVTJAC80XRupepn2AFZnxXyAt4dvofdjlMKgKYONM9JeZGz3DOqqSaycNAb+0gYRS8C2uV0eDhqcL4Ws7A7h4yjsGy9UmNWW7bONOCsBRdb+o5vD7XKgd+AAVZJBWP7WmUFlqK3AaxGi4TZ0329QfE/WIOECXLi1rAjjz6LC6tcbITUyyOiY6xRKEgmeloGdxVT6X+l8qi32uO5COiTOHubLl+AKA46Kc5sgZExqvpdSAJeoTqhBH8R1Jos/f61gtRe7Uv4tFN/p0KwOlv/AxjMztApa62ExkXyrZSs0HZNl3Hr2H4il31hR9H4asR7aUyT5zwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CprSceh0v3jYYun6qAkXMr4Ql8RLWy/fFXjmrQxC6g=;
 b=Fyb+/+6VzIKktRjll86pInhscDX7KrfZPdUOzRgOvEP84JwOEYyttBZ/ODsmNMl329xRg8uqqoMQkcVajFnegBUMRSpHhyV02kVr6mLCBhH6uTyY/2n+bD06wsPMGB0M6ikhmp3DXERIgU93l9hCGxOnqX/lSK9xZ0w+rEc+D5E=
Received: from BYAPR06CA0043.namprd06.prod.outlook.com (2603:10b6:a03:14b::20)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:45:22 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::f9) by BYAPR06CA0043.outlook.office365.com
 (2603:10b6:a03:14b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:19 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:18 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 25/27] sfc: specify avoid dax when cxl region is created
Date: Mon, 18 Nov 2024 16:44:32 +0000
Message-ID: <20241118164434.7551-26-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0de156-e1b2-4a7a-ec3e-08dd07f06504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eeY3q9lcP2nA11bWtmKgFj+55IYV5jOC1E2Od8RtqcmrQIU16CKe705KdHDU?=
 =?us-ascii?Q?vZBJrrftho7k7vnsvg+7Xyn78R8BWgUHui/EID8YSWVHp9VnGvH1xONdzefP?=
 =?us-ascii?Q?T6dnZ3cT8IEkQh+VOb6Z++Xtd6lIeVg2ArMQ+Yw/RN1Aoxq0jVPgjtwAkmem?=
 =?us-ascii?Q?5DV81mpbZy93itdojkzueEC/BUV8TUrmlRYV38EKpSEc/QVy4KRyL7wme6QP?=
 =?us-ascii?Q?0QQBGydxDKx7XONvRxzkPPFMvjuhBbVEXeTa/47zJ9AskfSjVyHcunyFcNg8?=
 =?us-ascii?Q?zfs5s0lcQQLCIwtGKlfLNUulpR/4O8pnZrNWYBOnuTlAPi/ZLimCvgrtmr4t?=
 =?us-ascii?Q?4u1KK2o8+9wafcsEnB9h2FDz9uU9pn5/ZjaD9D38ghGiDL4E9sZwQeUplDcX?=
 =?us-ascii?Q?H/wCbHo23CRBHeooSqpJHMi7gtqpZkPBjfawfiCOAkQzxnvpb/3uo1vLv+qp?=
 =?us-ascii?Q?/RnST3/z8sjxaIlEd/tubf6eOMHxIg2iskmnBLIAefHE3eSvJNnuVxXABPCE?=
 =?us-ascii?Q?XbGrindqTcBcyRkrZV65azinolXNXPKxBFJ69YMrdhGXzsPvwpnfrs3LuUVg?=
 =?us-ascii?Q?ZIJmdIUkBHHg6Ec4LPK1Qbfbm0gpF9FBUsD899KTPH/Us7rXPFtfV4jaCNVC?=
 =?us-ascii?Q?9X3Xm5wzbtyGDxZzIn1nVpDTPQk+h3j5k+OEU/wC6XiygcI5F6sWRRI/fbMD?=
 =?us-ascii?Q?yoTgzGtU7rszTAaHzNCnqaYblP2k6qRQ/bCygd7/wz9JNd0/7SDdJUdnChcw?=
 =?us-ascii?Q?qbBss+5dEb7iW1NjmrxUwWDzCIO3V9pEVwUMj6oxV4j16yGhOm0bUI2zUE4N?=
 =?us-ascii?Q?N9VbKBe1H/HjdaENnqhlK9NHNGGASble+1+A+dOByrFfHFtOi9Zs6xgv3KmP?=
 =?us-ascii?Q?I4jOcTnM1SptunL4oSJI7XwRvZIPz8b8nDsnt1JNym+GEZyE2plCoFLbMmbj?=
 =?us-ascii?Q?efmtM3UB/Y/BQPzBt27X5nNfC9pASBEVpLOkxPjvcd9fRzxdu3GXSB2oimqd?=
 =?us-ascii?Q?z78jxxlPp0HkUqjXscAORVhy7nZEAX+aTaiD54qol1cIZAztKJAR1zaINKwl?=
 =?us-ascii?Q?AcRDHXzrpBloSPTvdcMK5hHkt7MEEcq5+j4gV1LfTwOgSrG5lNxdYIGLySFY?=
 =?us-ascii?Q?3f3a2x8il/M/N2r9FiD18n7pdcpf4B+PuS8v04hwl29PEQglTC+8cN4mfXx8?=
 =?us-ascii?Q?vUoKpCkNtVwstW1VfafCx3eJKoEEdrGL8Brvsndi16TMsfMx4kVxZl931NkA?=
 =?us-ascii?Q?zHsoR96c0oFzH/iCTAZGERqyX7fVKFTvOBMw+xpmewcM/o+xVoKKT2fMwZUg?=
 =?us-ascii?Q?7Ye8fbkrsyDceIORsLQ1E/U61fnXTEoGB4n91czD+x9gyUrHe2MhoLgGZxZB?=
 =?us-ascii?Q?VdVa6Pb1Sd+k/e9Absr1977EXHXKE5eHTtdNRDbRzpo3NTPqUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:22.1564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0de156-e1b2-4a7a-ec3e-08dd07f06504
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

From: Alejandro Lucero <alucerop@amd.com>

The CXL memory should not be used by the host in any case except for
what the driver allows. Tell the cxl core to not create a DAX device
using the avoid dax at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index f9f3af28690b..de8d6bca9300 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -128,7 +128,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
-	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, true);
 	if (!cxl->efx_region) {
 		pci_err(pci_dev, "CXL accel create region failed");
 		rc = PTR_ERR(cxl->efx_region);
-- 
2.17.1


