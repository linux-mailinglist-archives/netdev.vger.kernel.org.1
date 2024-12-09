Return-Path: <netdev+bounces-150338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEDA9E9E8A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5104281E53
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCB0199244;
	Mon,  9 Dec 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hmFCgVEj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8519AA63;
	Mon,  9 Dec 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770494; cv=fail; b=OWfvtdB4iNKC4lxflWm+jvfQwkNqwTZcmearts57aAg7GkSUJjZi1YzmJLY1HJymMEVz/wQXuuQEGphm7DzWwIR1BnP5HZeQFaTyh8K28nnPbCsbtRNXs1V+8vPg38V9sgN9eUIfWQmQNtKTq/BJAih9xu18SWhkIfMadhU8apE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770494; c=relaxed/simple;
	bh=JCup7PHOAx1Xw+rlb8dH4prkmnNUmXKQncUVBK9btcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGeUVg29d2EbT4tTzDv+tO1vUu0OCiAJetYlfDqCdLg0EnB9obWRBNN/NTwhk+QZyEsHYjm1b5cxPEL1zNdUBu0QX1mpZCPVXMNeRUZQOd6jmBQdJ+tu7OQP2rDYgKxfdqScIiE/FPL1WYGKI8TOpjDYTbjpvVWNUjsg8QHN62M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hmFCgVEj; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASg4C6g2wI24yxCMWk4STUHIKF0+OS86c8E8p9U+ySJt5mR0QFicFkmW/4AAvOfNv9s2GwD47zRUxjH81kbjASri2VszHBUTUfWnx0P//CeCczycw7Q1GHEDEEDvZKaYschgQim7rn4YleTDFvQmSM0iNlhfWQ1boQUEwmnYn4fB8079zJm59GRZ2E5qL+lHXXpcin43WAbzk+KJtOhJngQw1BeQmIbT7hh3dnHhCbRW3PS5LuEWyLjiSvZh4dD6BKhY3XSkmAqpDR/c81nSbcM7R5FgcyBUPJOh7JVw/3SvKFzywusPUCSOq/atdFdej6M+iq7WnK/ZNQvPw+OcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDAM9H7efLEUMiHNabigx8VgzwoFyLI5laLkDY2U9VE=;
 b=c11EDXOyNOVKoBLo33X6n5A2UBoI9Zxjh0QMzSFZXtOmZu7PRqUVfkg3Lg1p5/hT6XgTpMxeiipJ+Wyt9CRfYwbkQCYE6ydNX+OzHcexjDX0syIo3aMQ6hY/LhStMff0KS0dWSyd+3u3bs/Qu9nCrr9MdT82kuzrinS1ruxZNgm3rQFGy5WKQdcHQUBB+hZMbE9p91WzwsldgaR5RPxM/Mnb7wcPOCsZ5GtA3oURKFM3l5ekKZQwt9lzH8RWcKKBehnuM+UU+oBhNaiYsBcf8fb/2fmBKpkgxqKK2jv2DYfwFM3GQmra16KUBxel0DMMZGfTBBnVI7c6xBenD5/mSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDAM9H7efLEUMiHNabigx8VgzwoFyLI5laLkDY2U9VE=;
 b=hmFCgVEjD0Jl0F8xSyFNihhdyXu7omOnCg3YCIj/PsoCwEmgmpQ1aDHq67CytmGwUXLsuvcJh1LhZpcMChgaOINP4OzOYN5G2A8v8h+vYRrtHuR+3F2pO4TH+KKeL25XCI45EuZk5Vfs0n6HGPYMR6tmL9HIgxSJRf7LFcmflBo=
Received: from BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::12)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:54:47 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::b4) by BLAP220CA0007.outlook.office365.com
 (2603:10b6:208:32c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 18:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:47 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:45 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 06/28] cxl: add function for type2 cxl regs setup
Date: Mon, 9 Dec 2024 18:54:07 +0000
Message-ID: <20241209185429.54054-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: db522ee8-b3f2-45d0-8945-08dd1882f404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jDDjHn9gixDst2RaPbyT2/UxUldSmS4tUIDicDP0gbg7bkrcsVfWkZDeLU2u?=
 =?us-ascii?Q?/kIqsdZ8tGYKWSKSWFTT665+X1HbSsEom2lzAm1BTQLG6uPz/AaTMaHKuM2i?=
 =?us-ascii?Q?oVP5f5YEl6N+1d5k1TWbvxuO4swV+IrM/+5b6TaqXZHtd1V61HDeq9GIdtH/?=
 =?us-ascii?Q?dR3SiE8/i0dNWOKq2fnDc0HmJ/0+bSNi/sU5w45Hz467SHlU58ojLCTs/jV9?=
 =?us-ascii?Q?Oi6jqY6Dmzrk7NeHDe3S9Wj4PGTBQWPeQAqlUc9JLueN9it2S7nnPzF764zz?=
 =?us-ascii?Q?fAvUXtdpgAtNr/xawPhfAeulW0QabfMPmLvNykgxvLyvNHhKx/T9GQLKdTzE?=
 =?us-ascii?Q?0CmacAGUKvoGsZZwIVqS5Nkk5dUxSL0jsPi1olcMFKRGg+Yr323BDEIKhbb4?=
 =?us-ascii?Q?jJLzAKec+rmoE7ZP2BJH0ivLd2EuVTMJI6piL6i7OKbnyysk9UK4LRKJBCkT?=
 =?us-ascii?Q?vziT1b/xMVZcILgZjwypvKPvXgNaGY7LGhHriJTslcBqAXv44cgVjA3Db+2H?=
 =?us-ascii?Q?1JdPLDpatjwzJg8wwyDfddZm1oJYduhLR3vHLuduieLxBC2Wuwf5xofN8UJ2?=
 =?us-ascii?Q?4yPIKtb7HOIOij1M3E7NgsSd5gtUReNZiElwGE+rxK+gwq7025t55hkyRo5Z?=
 =?us-ascii?Q?CR8xH34FqEMnHQYMogyOBp6V0zY15S7fTNceQhPWxc3IeV/bAffOQTZdckdK?=
 =?us-ascii?Q?kGlJVCV2TkaVqpcAFHbPTR8Mf0qW5a026veVhpWqME4WvSP/lbnryWVGIIrs?=
 =?us-ascii?Q?xWVgrev9DddUhkD22fRr8qe+ZL5XfSkUrcdSBuMiuY//gxKxPCMn9ED5C70u?=
 =?us-ascii?Q?gDgjw40Y2c/29+Z5BHdteibexarynyTZj0le5bR08U+usMMBQIwkJWpYB0Sp?=
 =?us-ascii?Q?AeHH388GDmrZtsT7E2zvXSr5z3nhkakJ1L4R4vMpZJt/lN6WTQDlVpbkLi3S?=
 =?us-ascii?Q?It+t6XPgC6TjYB/qZG4H+JN3zr0mj3MJ/PMBZynHCG4Y4F6ZtVktra2RPFYD?=
 =?us-ascii?Q?O4Hg1VF8jWdlEoZpBBF2fTkH/lNcbO9m0/+khBng6bto/kqjO7jjZPL+y1W1?=
 =?us-ascii?Q?WXhl8EG6sIL4YyZjgZfjrJxtkmGXDti1NaG0xK7DzbKtff+SnDVpjYzsQ0Qw?=
 =?us-ascii?Q?TW20h0/qE6lzC9shyIq3g8KXdU3vwTwWD5cmhmThAmxHw1/aI/Afd0jb4WDC?=
 =?us-ascii?Q?QN9/GE/iOAr9vxppZJsFs1aaYZlfIjiCXHiPb/h4bfKDxSenpmQ8SIK/sH8W?=
 =?us-ascii?Q?Yt9QLEIIR/gwQaCfivAqOethDfXdgTA0AbV6v+9MU2rKtkN6IAr92UBxaLGl?=
 =?us-ascii?Q?tjeudFHjGeJonJIZUU+SwjoyW55i3OSeJgC0yIl7cxabvIb+HUefDYTczfeg?=
 =?us-ascii?Q?0ZnbCEJ+NIujmwNM2LBA/PKobm29HJyaAGzodWM67hNhgFZWHeGrZEGq6zpM?=
 =?us-ascii?Q?tx1L24aPwgYDVjZJjBvaZekr54nIaAu+IJYYRJqMTgnjQTM3c5s4QA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:47.4606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db522ee8-b3f2-45d0-8945-08dd1882f404
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3cca3ae438cd..0b578ff14cc3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1096,6 +1096,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
+static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
+				     struct cxl_dev_state *cxlds)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				cxlds->capabilities);
+	/*
+	 * This call returning a non-zero value is not considered an error since
+	 * these regs are not mandatory for Type2. If they do exist then mapping
+	 * them should not fail.
+	 */
+	if (rc)
+		return 0;
+
+	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+}
+
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
+{
+	int rc;
+
+	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, cxlds->capabilities);
+	if (rc) {
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+		return rc;
+	}
+
+	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
+		return rc;
+
+	rc = cxl_map_component_regs(&cxlds->reg_map,
+				    &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 05f06bfd2c29..18fb01adcf19 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -5,6 +5,7 @@
 #define __CXL_H
 
 #include <linux/ioport.h>
+#include <linux/pci.h>
 
 enum cxl_resource {
 	CXL_RES_DPA,
@@ -40,4 +41,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 			unsigned long *expected_caps,
 			unsigned long *current_caps);
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


