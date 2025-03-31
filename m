Return-Path: <netdev+bounces-178312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB3A768EA
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4E5188C9DF
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307B215764;
	Mon, 31 Mar 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u8boTUQQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3522153F1;
	Mon, 31 Mar 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432382; cv=fail; b=A/fVk0ffNUSN5C531U6mN4S0eMdXgvfULxB6nc4TYyee5PoY3l5hZVowIjBEfZhHIEQqhBdj29UHFWTEknhTIMoNj2jRtiPYgYt70mzBQNhyhdXa8Ie5JNglkl35LYtf4zkunceB+pCCZlkRMioJvhP7eCc0QSLpRq6tHKAmAQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432382; c=relaxed/simple;
	bh=BDxzNPBY3GyYkX3SOvXQHT3y6ojRRodEqC7K/SJJop0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQnmodTJVZSRRia9xuPozAnfGicUMt0H1e4589e2ErxnDMkOIRiuJBzYMj9xhNABrXMEVXtkEVEvOiZ6pVpI+2MADfceqUiBs3cqjUQMmoewtp5/wRphC7wOadArAaM0lWNaUOJ+b138ZsD2SbchEcvBbDKb3Z3pjUaCR8DUrG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u8boTUQQ; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOu6F6GZ3n//7/kQPZ0Xopls+fgAQ809OAARJSNTCmaw+/NDlKkvQx+wDJFwa44JVHf3YzPirT9poTjmSW8QBH03gcOfC9DjDZhIcKwgZHU+o7f2vAoFoJopl9LObFxuWyjiNVojL0puGVeFRCSFHLztdLFziHQan1xVnOR4MSHQVcLl8EcV3TeGlesbYCB8I+kF5RoKfIbcPGitzuEWizfH57FCqScc93bgmLHrJZ3Zr1GtnSFjtIgBZcW8T5++/b1/MyAXlDfEKAjlBK89RNvNTJ4ExyYdLNZJa1PC/4yzRUfnkGT/Xh/llQKcipMZXP8EObKmKWp6E6Bgds78rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLWwTQ2gnAK5GpbX5MJ3tlpvu05HQiEJkSRYrH1qHDo=;
 b=lEtW5ebAD99sV1shIuqtna9IUrodshNgDsfHCshPNUo4tNoZm1KCprJn4uuzmMr+QnremItAMIhSCwcCU5aGEprzDUiaQEQzGaQq6LPXM3PhFiqIMXr6f7k0NsWIXAuiY0PS0ng/hBUjuWFI2sBmuK4eJfxO+Cct0tC1wJzui7ki0CetrpDCwe/E8iBa8saC1o3TjShKeNN2j+5Cm/ImkvJ8PPe3YuMv/Jkmvl+pln/IJgR0yJgXCaoomIf6l+BRFU+K+kHJN6/R5Ud/OYZe/S5spxk4zVzWILZQxD2OmLhxIzasmWXC0PbgqIqC4Xdue+HlBS6sd3fb9ag80MQiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLWwTQ2gnAK5GpbX5MJ3tlpvu05HQiEJkSRYrH1qHDo=;
 b=u8boTUQQy7gKmC8t1ayaU81e6KZLFG65u0R1wYdluuY0MFQR0dr5yE8CnWINOm4R9Ui6A/vvqPfRnDw/lIuI1/P0UsWLrPfTc9fSUk9qPHfMhgf82lRF1oSZZvqV/PAgoT49WfCDji8h0iKxiLnhC1hZAf1KrREjjY2RuDf+8y8=
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:15 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::ca) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Mon,
 31 Mar 2025 14:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:14 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:13 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 03/23] cxl: move pci generic code
Date: Mon, 31 Mar 2025 15:45:35 +0100
Message-ID: <20250331144555.1947819-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: a56f611c-2936-4d6c-86d9-08dd7062c9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|34020700016|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ct9XagveEGKvdKCJ8/7rDm9fZ5u1edsqk3h/5xQ6cOWukGSTyTEPwTGL+MoF?=
 =?us-ascii?Q?WEhYcWanBy5jR0WqmXMqvZAN2ZeU6yg4D2DK9w8++hmIZ0sSAOviXD2rgvnT?=
 =?us-ascii?Q?1s2z1Qji0bhFIZS2Rppq4uQBmYsAFkaHmEZaRggGKkb4Asq3sroTh56CaO5j?=
 =?us-ascii?Q?k7KHvDlP/tLYSHrQNQ5Ff/Ci9ufNXC08Zm11xbLrKYdWoOUEtkypMh4NolO/?=
 =?us-ascii?Q?ff4+XSGi97U88qMOjQl3KNetOAGAUPvc8D7Rwncou58+8BjZADALBTpuhDYI?=
 =?us-ascii?Q?KJAJGhxsA2izE43ikFWT2LFdjPH2Yhzf0mxoycI+azHF03RIXiiPmkTwqrJW?=
 =?us-ascii?Q?yOnhFduVRQUyD3UqmUByxezfi1TkfC9m+t8KAGL7YJzl3Z/3SaDukgQZjLUi?=
 =?us-ascii?Q?w3roztq7s36ySY9l6Xt7CRTTFjjUTH+L24BT8P4omW4RPmRWyDCbU3S4s6d1?=
 =?us-ascii?Q?P/8PyCNWNgleEHZoYHmsYUvWj8OjG31CU5Wge6qodrqjGcXr57rDXePTfwWn?=
 =?us-ascii?Q?e3fA5dkAnqyjRSY/V/XRLWK34FvMgTa5LXjbUfxhOuEq5jmSSgf/rqEiuNPi?=
 =?us-ascii?Q?AesH1ernbrphVrk4OXRyKLJnx5vsk1Z/+gI1KT1nCjDGVFs51DxrnUsBcrcG?=
 =?us-ascii?Q?u3tGmXoI/LycPagbjaTWWZXtkSjDC2E6pmjof8UCs6PbEwKwflCE498QMc/s?=
 =?us-ascii?Q?Se/WYGHCr1un+cMWji6kWxF2AP2nXFMjrOpGJNhsuz0WCwyafBwHkTbkxu4N?=
 =?us-ascii?Q?1KNWn/V9pPoUzip8e2jSOtbKj4Ix/AdIFQU+iqrO3ufJ2HHC0bCga+C/Bvo+?=
 =?us-ascii?Q?nbOg2MhVtSRhYw+4yYcih14Lt0BvX5T0wMlxU6cW9EVb/SVrq4XRBYnrT6RU?=
 =?us-ascii?Q?m96KCJmq0bqr8m7YcNijMQdqrElfqAIUHgyQtzEAy14aiwY9YtjlLaWqwHb0?=
 =?us-ascii?Q?t42QCqhcmRDrXtuumXZZl2BFV0Wpt1cbwwvCSSBqBXJ367TQicQAxQpiq1jA?=
 =?us-ascii?Q?japW/Nk+Xvqan5ba1caFtPeF8bYBdsjyQ0iaS1TuKnJmWqSi5R6w8hbKgP0+?=
 =?us-ascii?Q?sRwWyVIaDw/69XKJ9n0RNuS7pX4tSGbzpwBTxmxswNNwkSG66biB9TDqaCwz?=
 =?us-ascii?Q?o0sPUdpSITqHUBZYziWPUIg91Te1hDy+VJxbCwFU5tGe6nG3hYPx0fqLh9a5?=
 =?us-ascii?Q?Lo+L3BDBHY499FtkCIrPZGMqvyrRmrU28pNRwtMEBUZOlGqvMWeLgg5pAmC4?=
 =?us-ascii?Q?IUppn0CzmHxVJsJIVLFeyS55wvNK2YEvSUvYXQtwNH1FwtHUc8x0fDJRGh3i?=
 =?us-ascii?Q?xpe9+2rI62EmOGzzb2FMOQdfDvoXlovZvg1kECbGAWe59nEDcfUFr6C9I8oM?=
 =?us-ascii?Q?sBQ+t4GkZ3c/FbNhkxGNCz7bxcSMqbW9eBljVQ5JrVmBtySFgyaXjzgFuFSr?=
 =?us-ascii?Q?IWPRTrZuHdVwmOf2OGQlRMGpaqMgXUfdNlIZ5b3a94YykPrW6qHybqY6I2T6?=
 =?us-ascii?Q?CbCsUsGYu2ULD+g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(34020700016)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:14.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a56f611c-2936-4d6c-86d9-08dd7062c9bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci.c implements the functionality for a Type3 device
initialization.

Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
exported and shared with CXL Type2 device initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h       |  2 +
 drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c       |  1 -
 drivers/cxl/cxl.h             |  2 -
 drivers/cxl/cxlpci.h          |  2 +
 drivers/cxl/pci.c             | 70 -----------------------------------
 include/cxl/pci.h             | 13 +++++++
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/mock.c | 17 ---------
 9 files changed, 79 insertions(+), 91 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 15699299dc11..f3ca8325a60d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -109,6 +109,8 @@ enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_CLEAR,
 };
 
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2e9af4898914..0b8dc34b8300 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1033,6 +1033,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
 
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  struct cxl_register_map *map,
+				  struct cxl_dport *dport)
+{
+	resource_size_t component_reg_phys;
+
+	*map = (struct cxl_register_map) {
+		.host = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	map->resource = component_reg_phys;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map)
+{
+	int rc;
+
+	rc = cxl_find_regblock(pdev, type, map);
+
+	/*
+	 * If the Register Locator DVSEC does not exist, check if it
+	 * is an RCH and try to extract the Component Registers from
+	 * an RCRB.
+	 */
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) =
+			cxl_pci_find_port(pdev, &dport);
+		if (!port)
+			return -EPROBE_DEFER;
+
+		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
+		if (rc)
+			return rc;
+
+		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
+		if (rc)
+			return rc;
+
+	} else if (rc) {
+		return rc;
+	}
+
+	return cxl_setup_regs(map);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 58a942a4946c..be0ae9aca84a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -646,4 +646,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fd7e2f3811a2..5d608975ca38 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -221,8 +221,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
-resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
-					   struct cxl_dport *dport);
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index f7f6c2222cc0..aff0e58638f7 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -114,4 +114,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 769db8edf608..e8c0efb3a12f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -467,76 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	return 0;
 }
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-static bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-
-static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
-				  struct cxl_register_map *map,
-				  struct cxl_dport *dport)
-{
-	resource_size_t component_reg_phys;
-
-	*map = (struct cxl_register_map) {
-		.host = &pdev->dev,
-		.resource = CXL_RESOURCE_NONE,
-	};
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
-	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return -ENXIO;
-
-	map->resource = component_reg_phys;
-	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
-	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
-
-	return 0;
-}
-
-static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
-{
-	int rc;
-
-	rc = cxl_find_regblock(pdev, type, map);
-
-	/*
-	 * If the Register Locator DVSEC does not exist, check if it
-	 * is an RCH and try to extract the Component Registers from
-	 * an RCRB.
-	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
-		struct cxl_dport *dport;
-		struct cxl_port *port __free(put_cxl_port) =
-			cxl_pci_find_port(pdev, &dport);
-		if (!port)
-			return -EPROBE_DEFER;
-
-		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
-		if (rc)
-			return rc;
-
-		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
-		if (rc)
-			return rc;
-
-	} else if (rc) {
-		return rc;
-	}
-
-	return cxl_setup_regs(map);
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index c5a3ecad7ebf..f996977fe4ef 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,6 +4,19 @@
 #ifndef __CXL_PCI_H
 #define __CXL_PCI_H
 
+#include <linux/pci.h>
+
+/*
+ * Assume that the caller has already validated that @pdev has CXL
+ * capabilities, any RCIEp with CXL capabilities is treated as a
+ * Restricted CXL Device (RCD) and finds upstream port and endpoint
+ * registers in a Root Complex Register Block (RCRB).
+ */
+static inline bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 #define   CXL_DVSEC_CAP_OFFSET		0xA
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 387f3df8b988..2455fabc317d 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -12,7 +12,6 @@ ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
 ldflags-y += --wrap=devm_cxl_add_rch_dport
-ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index af2594e4f35d..3c6a071fbbe3 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
 
-resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
-						  struct cxl_dport *dport)
-{
-	int index;
-	resource_size_t component_reg_phys;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_port(dev))
-		component_reg_phys = CXL_RESOURCE_NONE;
-	else
-		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
-	put_cxl_mock_ops(index);
-
-	return component_reg_phys;
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
-
 void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
 	int index;
-- 
2.34.1


