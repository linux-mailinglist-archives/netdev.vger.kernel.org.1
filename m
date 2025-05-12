Return-Path: <netdev+bounces-189815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E759BAB3D2A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DC33AB9AC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B82E253F25;
	Mon, 12 May 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="28P2Is+P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F36253F07;
	Mon, 12 May 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066276; cv=fail; b=MZAYDW/39i0njIUQifP8swNNmrJOtkUodmHfLu6o222LMdOCEtxHgIoRPH1y8gJr7qPokLgAv9EyzXrqG2JJBadglz2pGX237OSmbYHuKU7G2a+5vS6stWBnbp1Y8XsRFdsvCgjjLPx/bG6zyrG+cjsEv0RIuGZ+gPbmXx858z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066276; c=relaxed/simple;
	bh=zT/8JR0Y60MaP+AHMg7bCybt+TG8w9WrIFH/193AZkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxbtLd1xt96+pVn8taW+NbPQZWli484gF/lArxUgOf/2yNpkmIbMKAryyIOFAb3xwVVgW8kJmcxdPX41BCUVre+6fTS/ANxZ2wXhEGh80t9/rskI1DhLOyacW8aWcAB45SWFf3xvuH7xymJld5oFV/K9weCoVxN0N+FR8DvnQpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=28P2Is+P; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtLngjUFspXcOnQf/9Ny/WGXTZbYysKV0DDSvqSYUm7qHkzlZGVW2aXVqZAt77Ti80fGsfaM0b4jBdsYRUJZ2q9fdsY89sKkXJDgmE/Xl6qTd8vZaPoQbnSOhNhmVSKJ0h2LbfoqAm1H9DFhI4r/J1bZhxKrDCmrXVQAxNIA5c3OithsEcfXRgKJllcADExKzBNRHcPkLa8g1g6Wtci6F5ne+YWFFWcEepJ+hOuZPY16wXlNbWNzO07T3gvX7Eg5VK4eGB+sujGcHlU0O2USUhV32lN9lmWrSB6AcVpEggMITGOZeaWqXh2EFwSAL+hd7NAcWm846WTVZ5F4H5kDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2QK/ZGxQ5TJPv8q9GkpXQ+0Zjmge6z8mxWgvjvPu5c=;
 b=Wz7OnLMoBspGWB6BNLL3KBKxIUytDTfqKBtqLsHa0JumstY0eG7pXy6JXRpul7kBYe0xkPHIwwMrBvTb7zaD7oy9KfISldbk6He5dWNCJctf6nVwFIEp7pfdu5pJQyK7ulleqerK/OybspmqC4rVDiuxoWJdL9e/vY0LYnHQq6VtM0VeIX6//K5r0pa8zk0wYd6gAE5fUpuS8MN1RR07rCjl51yO6hOPnuGE3UUd0kN+XQnDfKAoL6ZSPtt9yt23HIvQCcFgSy0XyFz0UHNqLCBFqlMBkC8CJO6UISoZkvdMTXV2KDxMOGDEJJobaoIKYWPNBFPhN/npdItP5Jkxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2QK/ZGxQ5TJPv8q9GkpXQ+0Zjmge6z8mxWgvjvPu5c=;
 b=28P2Is+P/iL9UhTa7WMUUzBoudLMe4NTuBZmr7+F3CVug9l6wWYFFPoUuuWjJ2F6gwgXaOr6gcQsVjvNcXP9RPgy9RWnea1dmbTPtzEC7c3t+NqnuNntAFmsA/zNUGs+pPIWciU597zaFpxJ13PCB7ATcMdzh6w08pO9YFgttJs=
Received: from DS7PR05CA0018.namprd05.prod.outlook.com (2603:10b6:5:3b9::23)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Mon, 12 May
 2025 16:11:12 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::39) by DS7PR05CA0018.outlook.office365.com
 (2603:10b6:5:3b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Mon,
 12 May 2025 16:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:11 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:10 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 05/22] cxl: Add function for type2 cxl regs setup
Date: Mon, 12 May 2025 17:10:38 +0100
Message-ID: <20250512161055.4100442-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1ec052-d2bc-4e28-153e-08dd916f9d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5I83eQ4tXbcQjMfLZL5Xgg+VISyGpC0iA9Xbt0mUYD2Wtr9PS+1/KzE1uAp6?=
 =?us-ascii?Q?ON8L/3V14qmerZLdgSPDQjpr9+ZwBUjbT2wBBAIIoiozWytT+5cQEgwa0DYu?=
 =?us-ascii?Q?/23F5NCwp1yEL4BiVEyp19O+X758J0Buw0hoIEMiPILtGalprycT2M4mIjU5?=
 =?us-ascii?Q?loq3Uv/5vuQmod2A68guwqlyFJ0/+AR7j8EfMOVsF9kB+HAHqOgYuGM3PJr6?=
 =?us-ascii?Q?VzbOZZIbpe9m7XteZVFvS6Xp85Z6Sbc6Ov8L4HRPLj7Cc319t20qAxWhlNE7?=
 =?us-ascii?Q?4Ip5MHH5YBVqRCg+sFyJZmZBaMVRy1GjpPw1GQxeMzsL7VYUsTmzmhl17fOo?=
 =?us-ascii?Q?kcFuJHXvQufM1dKmiM6ZgFNQgl9fmgAjAB3U7BVZbKf3fONgAmvzG3H69AKm?=
 =?us-ascii?Q?2L6hMtSGkoDsIgpMN9tK5BXepGjwonmdVMZIOZnVpD+DJfcMa7Pt4DPYbiJd?=
 =?us-ascii?Q?LSVTmHWVVYP0nTfkaEIh1VmPgeFZVQv+q+ypRMDg4Xq4pH8BF80KqXUgUJMz?=
 =?us-ascii?Q?vF2p399Nc/Tismlo3GHK3NclN+yzrxXrsg0zJmF+P2I7/Nmr/AG+o8xC8se6?=
 =?us-ascii?Q?s/Twvt3RNlzTT0Vha7u+hTrI/xhRC8TyGAEpmRYjvDPLC35DNoDWU/Mmv3l3?=
 =?us-ascii?Q?Y5YUfoShbgZYo0ptFINJa5jDyLvRMWqQ90nUTyifGffDWvUYMxgasuMG9rz1?=
 =?us-ascii?Q?2H4Wu4RfDkLxSEoLI978avdCuNc7jUUr2x+7sH2h0T4NWrAPpBuXk5M0Mvfb?=
 =?us-ascii?Q?119ONkd/QH2/MSt5cBZvsrEDnrfujQmbolDneIt6yo2Hj9Hzk2betDDa5vi7?=
 =?us-ascii?Q?gcr6Xr1AEhcNz9gyO0Iv4Ljuz+IOrp9aDlNEuv/QAp79AHe8xd6A6BW5RIFl?=
 =?us-ascii?Q?0wFfy0uwqcrv6/RLf3F1A79iBaKs8z/Nugf2xuhyRIoG8hWNrDPSIY6Hgx5f?=
 =?us-ascii?Q?uJKhzblXtRUeL87fTfokyJiIn47KQkZd+ExZPkAqYso4tyWEWw7OQ2DKLZqj?=
 =?us-ascii?Q?ioo5yiscqeJ+gip2+lRlF6oyGLZ6BREIsldjuGu6uxeOegm53XGy5NQCOmiL?=
 =?us-ascii?Q?BDb0iQ1aUFZeODsWwyJnbadaMo/9Klwtj27hCb3B5IJSr+Ei4jzzZ720cWJq?=
 =?us-ascii?Q?/ewxZLj4YBGohTUofZOIpg1Y35TZKVNFsBbEiP2uyVXFjDXn264JtZf8v+Wu?=
 =?us-ascii?Q?xiWZJZ/DqOp2WCEiXVIUEH89BKf/M1EhEYzkrK34ZcX8tARdZnTNreOCBoAP?=
 =?us-ascii?Q?A5BzbtfGjIPQSryjBgLB0qek4Wm1dW48kbfULwx9sO+cSufynf6a8fVbph+d?=
 =?us-ascii?Q?9OXS9EVKjS9pk+pa+/L5FLWQtBOYwWBGLaU7PNsodDy+NurdaMY/xcEk0xc1?=
 =?us-ascii?Q?395yz4WffsPGt2pZCBQ1ijgAuicc6YYk4IqPgjprs7s5qI3MndCqz1s49R6+?=
 =?us-ascii?Q?EAhMOu9hfYHzZ6KQRAnqg2xtnW7ZcFQhi4dTPe0E+OHPQcJcXoC6lJ/XPZim?=
 =?us-ascii?Q?umylHQ6Vyd4e3mlMkswQK+UCoENPAHjmYGaK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:12.4570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1ec052-d2bc-4e28-153e-08dd916f9d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Export the capabilities found for checking them against the
expected ones by the driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  3 ++
 2 files changed, 65 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 703d35d4b4b9..34f3915f898e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1109,6 +1109,68 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
+static int cxl_pci_accel_setup_memdev_regs(struct pci_dev *pdev,
+					   struct cxl_dev_state *cxlds,
+					   unsigned long *caps)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
+	/*
+	 * This call can return -ENODEV if regs not found. This is not an error
+	 * for Type2 since these regs are not mandatory. If they do exist then
+	 * mapping them should not fail. If they should exist, it is with driver
+	 * calling cxl_pci_check_caps() where the problem should be found.
+	 */
+	if (rc == -ENODEV)
+		return 0;
+
+	if (rc)
+		return rc;
+
+	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+}
+
+/**
+ * cxl_pci_accel_setup_regs - initialize found cxl device regs and export
+ * capabilities found.
+ *
+ * @pdev: device checking the caps.
+ * @cxlds: pointer to driver cxl_dev_state struct.
+ * @caps: pointer to caller capabilities struct to set.
+ *
+ * Returns 0 or error.
+ */
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds,
+			     unsigned long *caps)
+{
+	int rc;
+
+	rc = cxl_pci_accel_setup_memdev_regs(pdev, cxlds, caps);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, caps);
+	if (rc) {
+		dev_warn(&pdev->dev, "No component registers (err=%d)\n", rc);
+		return rc;
+	}
+
+	if (!caps || !test_bit(CXL_CM_CAP_CAP_ID_RAS, caps))
+		return 0;
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
index d22a80e75cb9..5de090135d32 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -247,4 +247,7 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 struct pci_dev;
 int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
 		   unsigned long *found);
+
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
+			     unsigned long *caps);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


