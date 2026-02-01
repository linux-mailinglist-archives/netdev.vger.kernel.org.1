Return-Path: <netdev+bounces-255630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDq+L+53f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:57:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B43C65D1
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1419530071C6
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AE623DEB6;
	Sun,  1 Feb 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IGmawSBy"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDB227BA4;
	Sun,  1 Feb 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961311; cv=fail; b=t2J6cuDh0a4sDQ6fFTJe5ZSAjU/VUydHQ8xlnskpBYR841rrNTHnt4L3Q8ytQHdCbaoKc93CjmlA+kIrD4Hpsed0X6Ts4UVmhRTVYnwkfwlvB9Bq9uhxkzmpq0f9p0jyMkWAQKod6kdC5o8HKbWcQSqnIfLrTUG8+pHlrQFrDt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961311; c=relaxed/simple;
	bh=Ezc2yfyeumJgFixJmreEg+GxAI41Ut+MjzCn3HnDV1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzq6E/fCld3492cjeUzL5lxMjC65XK0IL0ZpLaqltf9hAr6nSajO7zVZHcwSUNO/Yn82JSWN8PbaqAwSRLWB+rXxCBr4CZvJlt8ReTM7XSotdi9XcfXMpj9uJo6ymxzcnlNaUi+Q8UnBjySQUQL8qPchgAI8QReiHTdd6nRlFqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IGmawSBy; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKzKbPV4p6/XBF+QQZ7m6GuKvYbKXUK/1PMy+SblJMXQoAZz+o68eqJvtMM8WCK7Q2fuWg0ab5R3SgA73HFBdecjQAGrVmfbhr5dFMyMekx2URv+D6NokBXYzEB5kAW1Ta4uZZFGPi+k8p42c+2NTQDfGZ1HvHd8bGFx9+YCBFBcuFs4xYssOc1TLaCYFnsl7qFfsCQyhKHtZ4+2iMSVfrv89RSTRSI4TDDCmSTvq0MfDjLAuFQqJUtDvEt076GhxjeArvlLDuODsQu2BF7M4XmciYjjB3KWTFbmCpC4mfZBO6WoWYbEByRJOOoRcHX2/kbSrLOg2HfdzhjVuHavWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/8dxpmnorWPC8oxZy6IiWgJbdbJsXuo/I6ztsCjOFY=;
 b=T68f5uc6nnTjJQsYRf9aiNcOSF6C9XNiAC1NhIVrZ3A5XtnEhEFZnVY4jeMheK7WHzLyhQl69nHcwe9vzGT3cEmxCRV8Q/FTidvatiAhDPoEhp+F9R1OdrkfKLIxsUXHRXlVuzi8eh0HWdOKVkFNcfVqFXentdrvYQG++6QTWE9oNGS+R/vMMNGu0rUHtQdQJ16ZM8BoLPE2fict01Zu7fjxjQgcTL71Gvqfg3lgn4P5y1niHSBqrQ+mdeme4y/6XLLekte+bJtl/2gZERqn2Y8rYBhvAcLEGUAsZTVLtGzzatIjaAq0f0wQDVaOxxNOOyMSKMPCRIK08guxcbX9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/8dxpmnorWPC8oxZy6IiWgJbdbJsXuo/I6ztsCjOFY=;
 b=IGmawSByeaSyYFbYp9qr+p/E66XBUd75iVMZGfA5wDm5yS5oh73A67p4KJok7ETKcmHYAtDYpbbgTPtmNzdd7w+A3tfE3SZLiXxUOkvN0fG9BwDBPMXCeBchdGw7rC0tbFFjOE1OmCVDm9FLgyYv0gZTks/Mx/xTda/bw1wezyo=
Received: from CY8PR10CA0033.namprd10.prod.outlook.com (2603:10b6:930:4b::28)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 1 Feb
 2026 15:55:00 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::c3) by CY8PR10CA0033.outlook.office365.com
 (2603:10b6:930:4b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sun,
 1 Feb 2026 15:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:54:59 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:54:58 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v23 08/22] cxl/hdm: Add support for getting region from committed decoder
Date: Sun, 1 Feb 2026 15:54:24 +0000
Message-ID: <20260201155438.2664640-9-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: babf7e4f-1b06-4746-c16c-08de61aa4188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0mij74iWSc54Jf5BGeDgR5bv677ODoZspBrJYJ9BnRb9kea8hDPkyUE3WjH6?=
 =?us-ascii?Q?Jehy1++83IAC32vSMdhUQQt25yRamKRbjK26thxL0shvJXPaZ5eNPIuYKYsS?=
 =?us-ascii?Q?oxELZ4jnLDyyMiIpuaQFDx4MFX9oElkOicXzzOp25vrQKwB37RnfiogvQdRV?=
 =?us-ascii?Q?2k/fx5VfvHVwcmIxG6OIZoNIPLGU8gJXhuHuxznxhBvWU/MUQImbyNRGjsWV?=
 =?us-ascii?Q?Hu50pWJmxO6bURY3cuCP253tT+DY2drTMZFktBPFHx0dlzKpx0pK5xSBaxVH?=
 =?us-ascii?Q?0Htjg/KXBZCDV1dep2HME+XKP4Rw7FiYDYtUYi2Q1NBniv7EGHQ40EXWhoit?=
 =?us-ascii?Q?Zp/Xm4ySX9l/pZ39mkJL4wN1H+noGeAMGoc84F+B3Yx3Cx4abrxcjfs5SGRb?=
 =?us-ascii?Q?eFxvvN12x8aOlpzwxc5d7f/HHZhLUBPSX/AjM3k/F75QgAdlFpteSNQOP284?=
 =?us-ascii?Q?H9sw6Vto8oelyZD/YGTQebhjIGasH2C/5KSNphhXwktTBEjtDP3Fw2QO1DLW?=
 =?us-ascii?Q?8KwIP5oxuwSnuoxR1vWu8LsstjUfV0/balz5n1yB9wJoN2yFuQo0Nx3P+iXr?=
 =?us-ascii?Q?KtPCsDqCt9YwhLW4+w3wXBBH0LPHggO8si3uN4DgKSLjYKsAtK+FUG5FbzUa?=
 =?us-ascii?Q?TVSAA0DyYE5gpH/PqO2ViSrd6hPoacGqV6UbROFUfGejmjH6dFssEuuX5DFK?=
 =?us-ascii?Q?H0b3ZTSiz0clQPnkARBpZ2/6RAWVdAckBentowUh8iNWvaU3Syir+FHx029e?=
 =?us-ascii?Q?3EQ3yxIGA/Qr+vVKXbAEwzPWGRu6rvJIlNX7Yuy5hNOVAs/ZdRp6f1d/fh2i?=
 =?us-ascii?Q?Y9SNCv+oqWkNN1aBHNBJCvmXhxjyxBobcwSoh1oa0QeeJP9FqPD40a0HirOk?=
 =?us-ascii?Q?jVgL+KWrdVKGjwjrQ9cT6kUT2k7MGmZZZqoz1o9YC+Av0TuDm9fO87o52WLb?=
 =?us-ascii?Q?au+gGwdXRC9y99dx+GDC/a5JTqsxi2uU43FcK0NvWC5VB0Iwk7YFMjdBal3/?=
 =?us-ascii?Q?R84BlcWr5cAFrg/dzMRva3JkKcIATaVpVp1MtTa8YaAVUAJ/l9uGVekYfjLG?=
 =?us-ascii?Q?/7e/xIJDxhqnwFtj2bZ4gr4qgGQJl1Am2Jna88/6fgQ3PEWskGlcpv8BE1Pc?=
 =?us-ascii?Q?qT7a8dkMykUUPxZP1yOoYUKKDdvWkqT18E9oJh5IKMzTGTS/oq7n3rvxDqcA?=
 =?us-ascii?Q?q1Fa0MAfEXhd5yx4KEr0wc2M30ZTxNdAwahT8dCLfcsLQE0OMC1ryseWVI/a?=
 =?us-ascii?Q?sU/QzzMZ5i/ZU3R9VR5KDEfgJV6WGtNsVK/X8LmJPn2XVDKPet43lM+vyzg4?=
 =?us-ascii?Q?AIomaVjQLnBLjYFn4kzqqu4ZdhIsR2NEdx2TK+6RreWir5LSJ+f5ujm1ptGN?=
 =?us-ascii?Q?pNmwGc2YIAjK/1hUnRNm593PU/Bi7LJYKyPrHu4mEqLeueU0xZtXPfF47gkk?=
 =?us-ascii?Q?YOokUUsjiOGhBk/LQn8L/VwUprXTE4tsIkqCRokqa/7XHwUBOCt5xix/ko1J?=
 =?us-ascii?Q?kVNCKfxoIZ28zvqvjPz7L0XDriOIanfPMTx1y98mfu3PuGF6i/a4N2wHqWJv?=
 =?us-ascii?Q?75W3hku4VSlNK4ldMKJzR9/NsV0qOXR5ijAnwzWezDL8UhHPscllSsf4h0ax?=
 =?us-ascii?Q?c5v18IBKf12jdIeUPzKYoifmn6CEMBqOPhYPTatn4FoiEKUbUQ7h1G44D54E?=
 =?us-ascii?Q?9U3S3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1c0Ri+HOXS0thtAZlS0q12IHJd4cIAC9Q1dlIkcDxIVqh1brtYm6exHgqn4hhqUZtdxl4s75auMULDMJ82JLla68cGn3cYN/1h9ebNxVDuFivWYFnCNzmnUKA5L1jVgvG5H+nXNzmqDVsvH6FClK7SmYW+MB1YJj2QwixsuTdNA9z5JBgPcHP8b3UZSrmecEHm98UHRSUJWcuwCkN1qGqAhrF/hoWEm4k7JADTPL63oOPahF94yWkX4A3jwbOxe0e+cCdQgGLy0TUZHTyusfRL+kSIP4p593G+5AN/zJT2Tusyj7pe5uupT7JXz3yiZ1e2yNaoX6b/RAH5eJaFMjdnXeiYhRs8m17pKTivgt7SJgd9Pri8xLKELJSnDeNJYxq81IIzCzljfnpdL3wI4Z21Nu2Wcal2CgiUvO9IEiaRNiR4Fpm7nLT3nuRyPIOseW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:00.4132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: babf7e4f-1b06-4746-c16c-08de61aa4188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
	TAGGED_FROM(0.00)[bounces-255630-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
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
X-Rspamd-Queue-Id: 46B43C65D1
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

A Type2 device configured by the BIOS can already have its HDM
committed. Add a cxl_get_committed_decoder() function for cheking
so after memdev creation. A CXL region should have been created
during memdev initialization, therefore a Type2 driver can ask for
such a region for working with the HPA. If the HDM is not committed,
a Type2 driver will create the region after obtaining proper HPA
and DPA space.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 6e516c69b2d2..a172ce4e9b19 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static int find_committed_endpoint_decoder(struct device *dev, const void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	port = cxled_to_port(cxled);
+
+	return cxled->cxld.id == port->hdm_end;
+}
+
+struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
+						       struct cxl_region **cxlr)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct device *cxled_dev;
+
+	if (!endpoint)
+		return NULL;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	cxled_dev = device_find_child(&endpoint->dev, NULL,
+				      find_committed_endpoint_decoder);
+
+	if (!cxled_dev)
+		return NULL;
+
+	cxled = to_cxl_endpoint_decoder(cxled_dev);
+	*cxlr = cxled->cxld.region;
+
+	put_device(cxled_dev);
+	return cxled;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 6f8d365067af..928276dba952 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -249,4 +249,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 				       const struct cxl_memdev_attach *attach);
+struct cxl_region;
+struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
+						       struct cxl_region **cxlr);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


