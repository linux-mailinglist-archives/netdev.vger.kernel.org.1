Return-Path: <netdev+bounces-154573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861369FEB16
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFB3161B38
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04619D070;
	Mon, 30 Dec 2024 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PajW4rph"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A819D89D;
	Mon, 30 Dec 2024 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595111; cv=fail; b=ecjsbsiJp/BWg/9HTwEk3lE8u45G02zMhalEWv6ML5hnlKeTsDKdezzwNZ8Ki4W3s26l/7mbBTCFYvlIKw+kDA5o+LFkOtEvtmMAsR0JkJz9U4h0ydnnN+hrzB5IMr0ngzyC7siOiflNyKyS7KdKl4N5i8uYOjLD22+E68bM1Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595111; c=relaxed/simple;
	bh=itLEEhhKmqKC8826R3WxsLitvjBX0fnohqygb1HbvJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjsIDL3+kZEfd6yS53jvp6kbujPHQSW1CaWSdT2O7reGpynwDJIGB7h02hmc8mZ1I4MCMaSo5D08ePqjYiJ4NOZF1qZSQcIKMftWMHAdlBGp3O+/rJY+k0PnOjVeyBqKII7aSoYzdhaPado2onzrZj8jcWjOE9lWhkfK5X7zh5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PajW4rph; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqZ04gAnU4MGRI5QglDxzAvlYlyggLF4sLv2VU4AfvUQTbrAaHWU5IFb3uuiTFPpbpdbrjqADjY/PhaVt/es5ePYvtdVRTZ/UTcKtL/DYndBKAUYVwFRrkdUAAeTxhPCT0jll9uNehSR89BnlCGzOTiq6uKTVwg0LUc/YTkZU0BDq7D2Faku0g5vOHzSgfBYwqzRj2omzyGKAnyZOV3TQ+sCRPitJKh/s+0KmfrrU3sQRUMxSUTPV3I3zSGl1g+ubhJDcSwuUYl6Isc60lXwS9PLCE/7lHTw3VQ6UFZt3o0jeBV0kVeuL5kGNMBC2HEA+D5mSDftZ6p0JItmpDJ67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W62CtFTT6kShknCXXKeEPIeMDO2n/nKZAqZ/XAWPtg=;
 b=lJ2+a8by0Eb7Bn1JolLBU5PyjY/Ur90BJbYTWu36qyQwEpUo3ynx6t4S3KcM8Ekb3aJmy9hnz5OT6+J29IwxVR0mXgFIJt7qxvDu2nqjH6YOgteTsnuLBfpOqbVcaQsC8pW4NrDVRLMgg/VMuMe0khI5kvBEnjn3V9bqmQqHr/wPxWOgwSdfobLZsnBRi9AmsfeoRJ5fAEIFxoz4AmGuC+t7tAj14elnm3X4jRXixzsZElHQ6YMG2AHv7yZ58NqtoCVXjS6CxCEB2qZQyjN4HkWno7BBZzxa9IgZhvxNOm7fx4lejHwlKu6zIjUxfPA6n2orcLyKpoPppoWe03q3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W62CtFTT6kShknCXXKeEPIeMDO2n/nKZAqZ/XAWPtg=;
 b=PajW4rphDzbZUVysNrsC+POiPsl/jbYRf0n929sTsBHs5Pz3b4syAOForYUZ27hb67/0LUZRJDHFssjoUydVMfQaiZslrLcDbBHAjyZ9iltJ9ZtcpyR5413QFDm2svbgnsXCXHB8vVNyeRjB5JcR3OXaVuFrkT8ktgXiWjBpves=
Received: from SJ0PR05CA0094.namprd05.prod.outlook.com (2603:10b6:a03:334::9)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:02 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::a8) by SJ0PR05CA0094.outlook.office365.com
 (2603:10b6:a03:334::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.10 via Frontend Transport; Mon,
 30 Dec 2024 21:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:44:59 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:44:58 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 04/27] cxl/pci: add check for validating capabilities
Date: Mon, 30 Dec 2024 21:44:22 +0000
Message-ID: <20241230214445.27602-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cce2c72-d4bd-4467-ee38-08dd291b3675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uUe0+WoCtkL5VDMNVKGcHhddU6wdVs1QXIttUmwhB6d/mfr86ldEvsDMKEH2?=
 =?us-ascii?Q?xYVBK7tvd2hwDJVlo464Sr8EmQSXp18/jxP55vve4uCKsvrMv592nuYxsgnU?=
 =?us-ascii?Q?KrtVJK3uvafo0/GkVtV8l+hLTyXErlaGnKiJAyQaKmt10hoMJjXeTsrVi343?=
 =?us-ascii?Q?T0ypmjJkRJNHksKLAYSfehhHdNEU4iPHTO+bGHCEjMCmcTpYECKfYOROylTh?=
 =?us-ascii?Q?fBVkqUOHZ99Oj1/+BvmmKwyesL2LgSDO0sw6XhpahMtq86u2mNgZkf+qJ6Hv?=
 =?us-ascii?Q?rGUpQiwpctxekPVtcHiIFqPkhWF0F+bgVHAP8QcC9bX5XWJI+QTmhLO3oA0a?=
 =?us-ascii?Q?yXXvG3RmuJzDQg+Li5hC41NoIFWksnbl627QIfideDOURno3bNj/lDU8QqV+?=
 =?us-ascii?Q?tzvgEED5z8dxHOt8fwlsf4HoRUgw161tIFoLVzu4N4/gKx16IvsnTe57rEji?=
 =?us-ascii?Q?u65POsKTh1RwwxQTb3xHYbYRdJBChfyjJ4SqNpKUTTJd1Z5KvjnWHARNoCWy?=
 =?us-ascii?Q?rbwSH1NSz2G9SsprMD3hHMqu6FMXmwSVvcShvqvnZ9CIwQJ1FaTnAYxBGuKY?=
 =?us-ascii?Q?w1qcurNSAGeZ5GgLAg5dJCa4Q0ZJAWtfw0g3mGgPFNIiGkArrMZy+i9Ao51s?=
 =?us-ascii?Q?2onlZR2twTTJttHoWuQcjfOR+FNoYhVburJ9FUtxKOBWZ41Z/C72Q+tszcTp?=
 =?us-ascii?Q?ZMScFfBjZh+T7s/YQAGdi2mBhGx9chRkTbKOL5sx1K0LIUP6EptCeQ9pRe08?=
 =?us-ascii?Q?2crGtjsWLhEA8t+z1zbtKNIku0wsUJpdpkbyHJvRpn6R70V5/ebzS4XQdQVi?=
 =?us-ascii?Q?DrZ1hXdzLF+cYmdlRwKlIT8OKdL5QELsEkYlkVq1pgNZsaolyPga6QPdJ1Mf?=
 =?us-ascii?Q?1FWuv9eqmuStnELK9cPRlo6lsrwMJ1+dsjYjCMDSMkhNg/3V9xkA0IhTcLFl?=
 =?us-ascii?Q?/jA4EZMuOqYEcv/BGuc6OgwZEbAxSijYIo0WC8nB0gerEvgz64mCsL3ZZzer?=
 =?us-ascii?Q?pb2Fg6JB5b8wGcUOJznBe5ftVJQJ1DGRWuLauJcUjVVtgenvIs3NREvOqTet?=
 =?us-ascii?Q?zNUj2usGhNsJOZkQSBF051Ki0FihvqlQN5kS2C7HUIxHnVNm6DZZNb9tm+ku?=
 =?us-ascii?Q?TsVGtO5k7dFvLgj79lAggUVX5pE2OpdeIx33TLXPjskkkIQFbJ3Quf3omZmW?=
 =?us-ascii?Q?5Uq1GdmmG9mAGBKLfQoPsQDaBFqZyeuvNneAPicNFhhHiuPjy4C1Bm7zOrE8?=
 =?us-ascii?Q?sbdzkZnKaupgCFkEf3Jtzi36phghFWyMNaxcqlRcgUUSAFlzcHy79AQTsLrk?=
 =?us-ascii?Q?Zw2n8zP0Px5/KJcRAzwNtT2KGL5hm76TOnMDUG808hz3D0g8RoFnynIwCDwt?=
 =?us-ascii?Q?WZZy9OKqfbW5bR8TZsaghrU8f8oSpLltMo++hJKiWLx8TdS0d72ai1ZRX8tu?=
 =?us-ascii?Q?gvPAyV7XqHKCD3jnnRCaNPzfRXZ3WJ9grE2JmlnoCRjyyHViN9XwKPGQwGLO?=
 =?us-ascii?Q?47jvxCFSraI/H60=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:00.9470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cce2c72-d4bd-4467-ee38-08dd291b3675
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

From: Alejandro Lucero <alucerop@amd.com>

During CXL device initialization supported capabilities by the device
are discovered. Type3 and Type2 devices have different mandatory
capabilities and a Type2 expects a specific set including optional
capabilities.

Add a function for checking expected capabilities against those found
during initialization and allow those mandatory/expected capabilities to
be a subset of the capabilities found.

Rely on this function for validating capabilities instead of when CXL
regs are probed.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/cxl/core/pci.c  | 16 ++++++++++++++++
 drivers/cxl/core/regs.c |  9 ---------
 drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
 include/cxl/cxl.h       |  3 +++
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index ec57caf5b2d7..57318cdc368a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <cxl/cxl.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 
 	return 0;
 }
+
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
+			unsigned long *current_caps)
+{
+
+	if (current_caps)
+		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
+
+	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%pb vs expected caps 0x%pb\n",
+		cxlds->capabilities, expected_caps);
+
+	/* Checking a minimum of mandatory/expected capabilities */
+	return bitmap_subset(expected_caps, cxlds->capabilities, CXL_MAX_CAPS);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, "CXL");
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 144ae9eb6253..6432a784f08b 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -446,15 +446,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
 		cxl_probe_device_regs(host, base, dev_map, caps);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
-		    !dev_map->memdev.valid) {
-			dev_err(host, "registers not found: %s%s%s\n",
-				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
-				!dev_map->memdev.valid ? "memdev " : "");
-			return -ENXIO;
-		}
-
 		dev_dbg(host, "Probing device registers...\n");
 		break;
 	default:
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index dbc1cd9bec09..9e790382496a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -903,6 +903,8 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
@@ -964,6 +966,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	bitmap_clear(expected, 0, CXL_MAX_CAPS);
+
+	/*
+	 * These are the mandatory capabilities for a Type3 device.
+	 * Only checking capabilities used by current Linux drivers.
+	 */
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_DEV_STATUS, expected);
+	set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, expected);
+	set_bit(CXL_DEV_CAP_MEMDEV, expected);
+
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (!cxl_pci_check_caps(cxlds, expected, found)) {
+		dev_err(&pdev->dev,
+			"Expected mandatory capabilities not found: (%pb - %pb)\n",
+			expected, found);
+		return -ENXIO;
+	}
+
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index c5e4b6233baa..464e5fb006ba 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -40,4 +40,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
 void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
 int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 		     enum cxl_resource);
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
+			unsigned long *expected_caps,
+			unsigned long *current_caps);
 #endif
-- 
2.17.1


