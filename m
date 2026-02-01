Return-Path: <netdev+bounces-255627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HFTMKV3f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:56:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C7C65B9
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A29093018BF3
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8F42441A6;
	Sun,  1 Feb 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R3+FDnAB"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD823DEB6;
	Sun,  1 Feb 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961303; cv=fail; b=azXgNA6enG28rotTuIIakmc4ePR0FcA2u9HdeoVKDsCtnJdes7TN9pYfXVItSMsNGxBjNeoDp+Qpv3f71Cw2bQxnQTypWzOpukB3I8KODYxZLyJRveHG3duAfl+zElyVGqgLPk5DLaheXtN/CAg2CDgWzuRUWEDBCu1bOBBrFa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961303; c=relaxed/simple;
	bh=0EqugAf21fMQTGFBad4Ki17dOJLFpvr60vzj5ghfYsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLgWNlokAkLAh3A24PiXBFnXKClwDjApptsbLYvdG2ovIXVEyXcY06gkzM44eijVCnvlZ1QxD2eJCOtcG/tPFojOWiluir0VptPl/T7A5S7E367Vtov/N9rREjYo7AJaFiUutH/+6pSTtKbpAF2biKBu/VCOUWsDzMHQC8FqwRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R3+FDnAB; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqValnqzUaYl11VZN7c8W4QeGHhJzi4VbX70MLBF9FDyC6Elq1WGRn23QkK1dK/m+jBjCA0ZwjGpzloGdNlZCOEzLRxz9R4gIopyr5lyOkcG3+64HvNY02OnubOjigGEB4GGt09ZSPyI480Uc5oZoNRPNgnuxEkJ1yIbu4gmSlqFm0RVhmdNYu9Edj2P0xQKiWYMNQzgoqMxIObmIEVzM1nfAWingz1swlFvMaKnDlft5oxJPksY68qLZmH0yuWDofGNrDrpF53zw1TetnKxfI9BiYa3Y6NhygSnY4AWDe9rZjLgXxvH1DkMXNkdDB3OkXBvSf78I1PLdxTV1mHdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXwT4C7f0MoOkQKlSMQTETsKGX0RY4Of2mBST1AlWNY=;
 b=dANKNZUpBUE5wLR1RQ2uXNwlq/1u2DOtEeYISCxUs80KBF9ZLX+DbhIZrCuvCVC4wBsNgzsy6gW1O03WQaSrwZVYebOYpBuCQUvLZGHwUcUUO4UM35H3RPUqLSl2RLZINQQMFRCXSWB/z3MnBu3TPJKYpYjtsG6HIPKFpKu6lctGHW+qQxjC8B9gbW/kfFI1jviJhqPZr7MZGp7AfVzaCyiOm4uuGGMoNo26Io16pq2zS7AjIz4gSLdJ7DHv+/Q8holAqarMf7rh5/2kVMvBdP0yCL6lpiGJqZGsU2mjTPP0fnmVpggyj9gHRYHTpTeNMD0NSMcQR79NknYjW6gK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXwT4C7f0MoOkQKlSMQTETsKGX0RY4Of2mBST1AlWNY=;
 b=R3+FDnABW52mKw2V1dtM8Bv5hOBCDHxqbMbF00wyC0jTRvqrjd1wO+8qqRdsuSdWtaBFS4wJTIL60G6RNE7xrdzJo00q5F3nXGBY78P+pTMeXQxxko3iq7Q/lTlRDIa1mKtfqVjaXCfeMIlbaFeorq5YYuRKAeIllvzKvrfYtsE=
Received: from SJ0PR03CA0116.namprd03.prod.outlook.com (2603:10b6:a03:333::31)
 by CH8PR12MB9816.namprd12.prod.outlook.com (2603:10b6:610:262::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 1 Feb
 2026 15:54:56 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::24) by SJ0PR03CA0116.outlook.office365.com
 (2603:10b6:a03:333::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Sun,
 1 Feb 2026 15:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:54:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:54:55 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:54:53 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v23 05/22] cxl/sfc: Initialize dpa without a mailbox
Date: Sun, 1 Feb 2026 15:54:21 +0000
Message-ID: <20260201155438.2664640-6-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CH8PR12MB9816:EE_
X-MS-Office365-Filtering-Correlation-Id: f1feb85b-7060-4ddf-b51f-08de61aa3eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r+/Q70cB17Bo1ZHcnUvvTKKJkztF1SD9oac8mgxMqk18Q8UuTzNfDA/8ezTT?=
 =?us-ascii?Q?+Vd2y8HLPJMUbSkhAaalv3w80N9Rpc1Kw3GS6DGIttdt4sZJ9L4oCMOqU3vQ?=
 =?us-ascii?Q?OCFKIcbgHCgjtcmqDTUUxi1x7jx8R795KTUpKLScKy8paehBdvYnVgeXmyBv?=
 =?us-ascii?Q?2ELYlFsEJ41QlSwRJyvUzO0ilb33V8fvrUcBHO9ZAfCkciqsKhAgmTv9SrB3?=
 =?us-ascii?Q?iLZlARs3e5f6MC3krODOesbv3xwsAbTXLTf2Y8AvrQ0JDWcj2uxHUCpG6o24?=
 =?us-ascii?Q?nWMZiQj1kUzP/pdJZPo7L2PAW/XRgFKUMUXuHB1546YQc27qeRtaURS8PUBZ?=
 =?us-ascii?Q?chfrT2Oxy28/aNr9jjVqB68JWuzEqXNydNYXlPFqX+XAL9VzlEJ1o8xZNieD?=
 =?us-ascii?Q?RfMflM1Jhh4zcxpxHQPHacRZyh848eLtQI0NW2KUoIHAxqcRHoiFBGzPWXR/?=
 =?us-ascii?Q?ZovZCuhN3rZgO2WG7pLEOopF9oSyAQpkN8T7jLIpifaSlKH3Ml/st4sjDJbQ?=
 =?us-ascii?Q?Jeqlh4icYnMLavNbP5EBCA7dr2wCRnuXI3CDBy2E610r3iskYJuG95oSyu+M?=
 =?us-ascii?Q?iYGBq2U6fph6UsL5ZeDqYvWllb2ZThEOPD3/szicz/xw0MUNxMPVbzm/ACRK?=
 =?us-ascii?Q?vvma2XHNGqXyekSW8+IrBQ2HSizFUGXI2BY0fwc+InLs3xO81N5keFs9d7Ld?=
 =?us-ascii?Q?dyOWYL/ndufuQgAY7c4WfVyf5aZZdEDAVW7DTH8MtBZXi1vK0qrKZTlrB7GE?=
 =?us-ascii?Q?of+eT20/JXeco1+nubBTJG6DN+R/6RUmDPzhqS4dMg4rW/vsQTjse8HqzhKJ?=
 =?us-ascii?Q?7NWAss9o8utUhjf9n+YO5oilZeXJtCQjUWGq4ODEmV1u8bOcPvUouVRwz2Df?=
 =?us-ascii?Q?8WRnfak3WImO6ISpdDIjU8RpOHgUNKk+scRa9QKhteH7+A03gUbhyUhulJja?=
 =?us-ascii?Q?JKwE+O6236UTQ/7jOMgi9vptBIdTnIKm8A43u/A6lYZjldCffizfM5dFX2q3?=
 =?us-ascii?Q?IS0rg4CTJ2/NfkNOtb/mj9kOIxys7qFm4/mc77sO3F6QNVaFqskrTPdJjZYt?=
 =?us-ascii?Q?rAJ2MsnB7sjgsV0RSL6RjI3sDBMZV42ix3+SWEl4oK0OuQHA17IHLeKelaHA?=
 =?us-ascii?Q?T1PrcxFVOd8ZX9h9ekjVv2I7G3eW01wD/31/w8I5LlLbIgY5uHrZTlmu43Mr?=
 =?us-ascii?Q?I5MVaH9jTSWO2yPoBxrDmqkTEiKGIUZBQAqi6EHGcTHVNP0YT8Wg9UuvcTSg?=
 =?us-ascii?Q?1rZpYEemdSANYlGvZXlXMMBAZXV2nH6Ys7amwS0rqisU//xg3KOih95GQ3OL?=
 =?us-ascii?Q?hzD6Fw+p1NEM/sexntLA5DHEKhkPO6BkXMRa6l7aAxgNfmtVf/HzgKs2RxMD?=
 =?us-ascii?Q?JmKtyiqMQRorsOqbNQclf6tLhXKAvTNTc6q1y6tX47/WtI3zlDuEPELUsMG+?=
 =?us-ascii?Q?oYS6rfCWpsYD/68n9jaz6tHQodm7GvyCuS6wMxrMpIcga+b4+j2sgM5XckVe?=
 =?us-ascii?Q?5K8g+c7COyfdl4iy6KpsYofhmq9QvTAGj34858FrtllhlqCQcJK5Gc2+BSqD?=
 =?us-ascii?Q?EPQ+QyIBFCqgVX9UXjx7OlFOMejrtvcHzCC3Y5Jcp+mnUPNV6xAv/wpHzYU5?=
 =?us-ascii?Q?Hw9iUHiS1meIUVhxOtEa9PryQffBR30fJaU6P32ghsfrN0Dqf69ZX23Zlr2T?=
 =?us-ascii?Q?53NiKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	voshrX14SDDME0sPReNEgBxEj5MI2D9ZxRehu/w4/Kzbo0QrRFFLVYbZPCtBtLVcQ3KfvFLZTgnjo6K0V3nY7LQpMmDlXzMRtAeBSqRTAsxJ94/H552MyvC60E8KICa3OBfBfWpjlUYhzBBfv7mIad8xA7A4fNqKOqKyppomoY7P20lfDn3FAKRLYxUe6aB6i/Df278WIPG16oaoSRIJ0pjQb4BUJ7dmd07VZn3U4jRA4Dx20b0+iHVH7U8gVQGtgICZce1wWFyOTlK0BKa9nL7GNU3eiTZSbkoHPAL0VKpBMJnXq5lOARZ/WZ3QATCnwGXtN9ttdAVgOZoEOkyd2D7OENY8HcksR8mQMZvl+VmoUZ/yrJEku0WzubIY6w41lsjzY0CM1R1xV+3dn7cxJb/+30PgKGDQ62Ayuhe2FQg2vBbM5roWCKuOnNely1If
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:54:56.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1feb85b-7060-4ddf-b51f-08de61aa3eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9816
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-255627-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,intel.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 549C7C65B9
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DPA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile hardware partition.

Move related functions to memdev.

Add sfc driver as the client.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h            |  2 +
 drivers/cxl/core/mbox.c            | 51 +----------------------
 drivers/cxl/core/memdev.c          | 66 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.c |  5 +++
 include/cxl/cxl.h                  |  1 +
 5 files changed, 75 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 256799d39361..e3c85ceda248 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -89,6 +89,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode);
+struct cxl_memdev_state;
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index bee84d0101d1..d57a0c2d39fb 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1144,7 +1144,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
  *
  * See CXL @8.2.9.5.2.1 Get Partition Info
  */
-static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_partition_info pi;
@@ -1300,55 +1300,6 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return -EBUSY;
 }
 
-static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
-{
-	int i = info->nr_partitions;
-
-	if (size == 0)
-		return;
-
-	info->part[i].range = (struct range) {
-		.start = start,
-		.end = start + size - 1,
-	};
-	info->part[i].mode = mode;
-	info->nr_partitions++;
-}
-
-int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
-{
-	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct device *dev = cxlds->dev;
-	int rc;
-
-	if (!cxlds->media_ready) {
-		info->size = 0;
-		return 0;
-	}
-
-	info->size = mds->total_bytes;
-
-	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
-		return 0;
-	}
-
-	rc = cxl_mem_get_partition_info(mds);
-	if (rc) {
-		dev_err(dev, "Failed to query partition information\n");
-		return rc;
-	}
-
-	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
-	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
-		 CXL_PARTMODE_PMEM);
-
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
-
 int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 22d156f25305..2c5dd72f43ca 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -582,6 +582,72 @@ bool is_cxl_memdev(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
+static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
+{
+	int i = info->nr_partitions;
+
+	if (size == 0)
+		return;
+
+	info->part[i].range = (struct range) {
+		.start = start,
+		.end = start + size - 1,
+	};
+	info->part[i].mode = mode;
+	info->nr_partitions++;
+}
+
+int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = cxlds->dev;
+	int rc;
+
+	if (!cxlds->media_ready) {
+		info->size = 0;
+		return 0;
+	}
+
+	info->size = mds->total_bytes;
+
+	if (mds->partition_align_bytes == 0) {
+		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
+		add_part(info, mds->volatile_only_bytes,
+			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+		return 0;
+	}
+
+	rc = cxl_mem_get_partition_info(mds);
+	if (rc) {
+		dev_err(dev, "Failed to query partition information\n");
+		return rc;
+	}
+
+	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
+	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
+		 CXL_PARTMODE_PMEM);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
+
+/**
+ * cxl_set_capacity: initialize dpa by a driver without a mailbox.
+ *
+ * @cxlds: pointer to cxl_dev_state
+ * @capacity: device volatile memory size
+ */
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
+{
+	struct cxl_dpa_info range_info = {
+		.size = capacity,
+	};
+
+	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
+	return cxl_dpa_setup(cxlds, &range_info);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
+
 /**
  * set_exclusive_cxl_commands() - atomically disable user cxl commands
  * @mds: The device state to operate on
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 34126bc4826c..0b10a2e6aceb 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -79,6 +79,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE)) {
+		pci_err(pci_dev, "dpa capacity setup failed\n");
+		return -ENODEV;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 7f2e23bce1f7..fb2f8f2395d5 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -242,4 +242,5 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


