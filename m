Return-Path: <netdev+bounces-255636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMxQH1d4f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:59:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF067C6604
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 957863009176
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C923FC41;
	Sun,  1 Feb 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZD/pBRn0"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D03923D2B1;
	Sun,  1 Feb 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961326; cv=fail; b=tu3fR9ja3vLbKHwiA4VunXCJfhK88Lci2Ka9ad1SLUq/XfsVzpcJkHGlkZyx2pGnHeIYL3gYX4Dr9JSfW5jYtC3M9sB1wMx3aBScV4cOwcvkNrHobHVYtrhw/DhjOEFo/CXahSdDn9Vu/HkfziLyOl44x3OSnReyRNqPXnZBa9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961326; c=relaxed/simple;
	bh=jgcR+eq+JIPSg3s2K4lzGARbVkWk6G/DaRgW2PIEfKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOlFniVPT0dZo+wyoVKSREN5Qy9xKsFTFbfQakG8Mf64nD5xeTdU1gqbzyzAU/UVeIfwLY/0PmBts9WHlRGrjGSB/B5PcYF4QmNeE7q+v+A6IuxGkX5ykYZP7q7f2vRjiTQ4Lg93fZnvY4OcphdmEhdRbLqHKYcibj0I/IneVIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZD/pBRn0; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK+dk69qKExyTg1opxPWKmbNhmKpp5ClJVsCG/uVJR5lFEI3uenCNz0kBILlcSBpMIsi0OA2LItDE4OM7zilPgOMZALpH7VDL4fquPcBk2rUHQmSEGbtnRF6/avZJfL0PgDpVmG8Zoh63okjgx3DU8cRifZPl0ysxfu2+GqVfNxax2Ufw7hDs8bnKGO0IObrE/YSp762QRVAz4ZFdWNhmj5rcfBHgaPPCHl9kkkQO9GOKthbo3Co1hfuvmFueoMEDVl/BUtlJXEDbewenZeM2FvhAF2Dua4e9KN3PW+BjuO5kCS2Zfq9v714Y4SaKEvUZCX2Bc2LBAlpLJB1WVNIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zNRlWKsVqZeDCkrS8HolcNAdknXiQwymiggNKB+bvw=;
 b=DGtQGs7Cv5XGfJ8bfO9t8lCnVqDZ9npuA4HAZp97DWulU3UiXc2+yJYlIxgLzEA38jRcqP1IMDnYQo5kp4Pird/SfplwOm1NK+L2plkGmFfFzRgoA+5oSWyaDWqQzBFXyvPf7aoRMMNxWIzHQTpclhfeL5ySopJNIapmL9FMAi1INj2i5Lqwbexqr+HzMhNAnyRt3g1Y0BAN9tIEjwKYhLF0kfjZcolCP414lU3ssLpMhrtqRNkgUk4fiqhBoIa43ZjKrCkY3w2fXMe8vKAYmSJ1sF0LGEcTUj6B2BEEShPS9XsoisgW/TmeAjm3PRrjw+7wer3c0vsoBje4BAdq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zNRlWKsVqZeDCkrS8HolcNAdknXiQwymiggNKB+bvw=;
 b=ZD/pBRn0aRy8VHf0KxqhGvltEMog5v/uwO+8wcknWrIw5PAop+k+cRisfs8gHmkI5SIV3C0qXnboi6sMhQTiw7pT/q1pkGPOhflJPpxNo/MB6pVP4rc0VVlmxCJT7Y72Y/HrBTeFksTdb0xAn6+4d/f7y1Sl1ohNPG5QaC6QOuE=
Received: from BL1PR13CA0301.namprd13.prod.outlook.com (2603:10b6:208:2c1::6)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 1 Feb
 2026 15:55:20 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::80) by BL1PR13CA0301.outlook.office365.com
 (2603:10b6:208:2c1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.9 via Frontend Transport; Sun, 1
 Feb 2026 15:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:04 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:02 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v23 11/22] sfc: obtain decoder and region if committed by firmware
Date: Sun, 1 Feb 2026 15:54:27 +0000
Message-ID: <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: baf0da76-7194-4354-c71c-08de61aa492d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qWleijIfIYgL/r1s9c28toZ7YMoqVRPYPMwaMdTC25n+YMeR2FhuFVdV5BtM?=
 =?us-ascii?Q?zNNr7Be9w7JAZeQ+xaIfuWHVhF1rJ0vsAKSd991dAgJBiUPtnSRrkZQ3tBvB?=
 =?us-ascii?Q?/npUqRfrCYCboih5oR2+8f4PJ3F0utK+1bPYzkfYYkr9nH1L36QNOZp1W/Hn?=
 =?us-ascii?Q?n+IjT+Y86uy20tR4mHUXDJReozmDHNiAKVjj/TYrDtYVO+GxftndlfCk/rQU?=
 =?us-ascii?Q?KUMOco3c+Jb4jjy+O9tp1tVt2BYFtgh7flLADzmRnpLphvN66cdqFxnlugL4?=
 =?us-ascii?Q?TGAMKH99d3yNmFskLManpPnwydTDL7UbqEg4Mx7Rha2rSjtA4WYYJzsgO3dl?=
 =?us-ascii?Q?uVGRHitWSjvZ5Zx1rSiDbOElef0SBJPqNttYo52KnneDKN244KmGc4EjTXGi?=
 =?us-ascii?Q?Ne1W80Wo/IsDS1I2eFN6tSx44s/NfSWE7EG85VCy9oUTYzIq10T/z1FW6iNw?=
 =?us-ascii?Q?XlcOxci7FJFJSWdCwTN8lL2Dfez/4Iw0jY4XnInHs958uYztCyUkJf1rHm2h?=
 =?us-ascii?Q?U11yzz6esUt3vaVffZCRNGnd8ThnQCQ4B5NsuWWhieC/+eCvw/stx4QkdBB9?=
 =?us-ascii?Q?5RNnpj98XwaddlOZNhj8xuDs4Xqk65wb5DkHQzidgzEdA8T+cxh7CF9Uav+w?=
 =?us-ascii?Q?ZD+3nmmuLpr+3qcrjg8yga9bQ2AObJzc4RYrRAYWARkALy1IQE6mInNiLMFa?=
 =?us-ascii?Q?RJWYJ9T76MYI67JsQ78utXm1zJQQ5OCUMApTb0Dy3otOVQl/LrvsOjoPMUxm?=
 =?us-ascii?Q?qWFLAfGnJsJU/xRVtN6k7olVZt0JYFPjqeWIBisegOxFWiKlQunA//wlbsaF?=
 =?us-ascii?Q?EQNWUsv3E9IlWOWImth2AYF7rbCWvyPnNrFlBBmfwklQ1POXKDp5+G2tzzWo?=
 =?us-ascii?Q?GtF/WlpHWBDlCookBuCdaSm1Y6iu95O+PAZ+eADPgMAtJU16FqhoFqtJ15jH?=
 =?us-ascii?Q?wdBXoEKg/LtSyQARMkMyzgAsZVsWDj9V8hfqNjwQbKDnsZhDft8ln4KHhDkZ?=
 =?us-ascii?Q?87sA9QWNHzsidHCKDyoYBMSemTBVjZDCxF9StBZOmm7bYCbhrDXZ9pNx0dfr?=
 =?us-ascii?Q?TIW9q7UcUTiG+YkCmHwbLLoyrLtTU5liDpQ02jyu0LdqL5gEsJ6G3DtyuYDP?=
 =?us-ascii?Q?L6ASpYhfNnaiuQ9sqOyUhiL/mKXB9lGZQNxiA8tHHMxvvPPvVbzaONlzH5LK?=
 =?us-ascii?Q?f9KpMZR8k6quJpTrvldvr4NvB8K7IvDxQ4X1mwSaQSOidtBuGC/vuaqXQ1fs?=
 =?us-ascii?Q?sZKMeLEpzw3cV7FFSf4osY/opqBPUIbuASxkHUznlZZsFH6puRLKXdP+r9V9?=
 =?us-ascii?Q?lmr3Ehekha61Ee8jxJrauC9YSuM4wD7S5MenAkPniVR84ifJYanWGOkLUlxn?=
 =?us-ascii?Q?95UyovHiCMLLxThOn3eWWznM6iHjz8ztxHcuwxfQi/AWIn9RcHwOVYKUt0Qi?=
 =?us-ascii?Q?/89NuPT77GlxDTQuVU8yHJsy6g/1FsNsnMusWInjBAgV8ckB8oWhMGsIY0tv?=
 =?us-ascii?Q?y8vtUXmZtUohLD0LxmtC5WTnmZSpxKjV9OwQVR7VxWkwOeIRjeLoyVGUHwAN?=
 =?us-ascii?Q?HGxEErbomZCqpaFP4BHgWIoGRbJRb0NYUh+71YC2b7XZyWkr/vqpBIE6twxF?=
 =?us-ascii?Q?CmF983Tk42Fhwpt6jGChmctYNheBhHiueJcfp4SAt7hgdy9PLRzNfVdoESle?=
 =?us-ascii?Q?uxzlcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZcMwX0B4ktbmhzvjtv4lKIP2fg1hXGyUyt6UdCK7ylEPXiUhK99mKAXLJ4nM5t3KBFFb49QkYRvafLbY0AG0A1MFQ/5H5xhnf0C9xgdfGvuIYot/uQHJiSgrc4hbGxSj7VP+fgf6Ht2tK899m7DS8qrdciuSoedsxHzDdeaer5rJENzDd3UZhsC6a4MBkEhbMd7arXBNhU3fhAU7K5K+IOWsizjd74UDFyD624R6+UxMaC8jgXK4L5505Oftbj/CZTs/7lUhtoJtpfzufxm4TAup+bSE18JPaQK8Lv9MXTFSAFpY6OY+tsmmTuV8uEZ7OJwAKN2Q7jCRlug7u3UUSAEbGIXj7YhNO0KGF6CmMiP/AfCv2CFs+dXq8H65znB9ErxIegKqT64ZoCG0TqgJ9+sShgE1IgTLoMfKtJNFsvH2GcceFijz0M5a2HCMErD0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:13.2899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf0da76-7194-4354-c71c-08de61aa492d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255636-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: EF067C6604
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Check if device HDM is already committed during firmware/BIOS
initialization.

A CXL region should exist if so after memdev allocation/initialization.
Get HPA from region and map it.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index a77ef4783fcb..3536eccf1b2a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
+	struct range range;
 	u16 dvsec;
 	int rc;
 
@@ -90,13 +91,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
-	probe_data->cxl = cxl;
+	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
+	if (cxl->cxled) {
+		if (!cxl->efx_region) {
+			pci_err(pci_dev, "CXL found committed decoder without a region");
+			return -ENODEV;
+		}
+		rc = cxl_get_region_range(cxl->efx_region, &range);
+		if (rc) {
+			pci_err(pci_dev,
+				"CXL getting regions params from a committed decoder failed");
+			return rc;
+		}
+
+		cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
+		if (!cxl->ctpio_cxl) {
+			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
+			return -ENOMEM;
+		}
+
+		probe_data->cxl = cxl;
+	}
 
 	return 0;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (!probe_data->cxl)
+		return;
+
+	iounmap(probe_data->cxl->ctpio_cxl);
+	cxl_unregister_region(probe_data->cxl->efx_region);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


