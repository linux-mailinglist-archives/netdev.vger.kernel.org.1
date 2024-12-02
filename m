Return-Path: <netdev+bounces-148055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D49E02C0
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411E62847EC
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558C6AAD;
	Mon,  2 Dec 2024 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xUX6rFSH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246F8F45;
	Mon,  2 Dec 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144432; cv=fail; b=LW/5IQ3VByVHyKomFEpy6bAassbxk85S9abhK9iLGn3vGP/SLXyBRibovh6ek9c4jJ1WfH0MYbeHnToXkeb3abFlob7PY1eIK5VNS///rT3pyDtAIUiapK/R0TiUiQIPhx7QRr81mgtBkpQQzNBnw5/dqFoRtrEqf629D98rpJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144432; c=relaxed/simple;
	bh=pJZrMc3KVJ4vkJNHWa15I/vsaGb5uBVyzLp/VKu1z0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVyy0THGpnpszplJjYQd6KDKL2uL8xkEq9s3qxtTBBYuXdkSWd3zwC30vk5mjtrFz6xAbW3+mvptn9+c3CS1X2bgvdkAr2g+V/nHfLBcRsk2czV/gbelHG6oNyXumPduH6VAWR9hDmjKJZ9Zc7x8vVmHMbFps0c2P3v+Fs+npyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xUX6rFSH; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rc9MYdPt5UMBX1GaMw777uP+tuaSO8ecyzj8c63jpJF9EoKiqqZrpuSsrUWmaRKic0sT0H90vLP8pdyQKrm9RzmyQ9d2ebdYzSUvS5fYpeMKSw/ltU5g64seVwzckxDwrLMvcuUbUZgm4JooytgqJ5Hy0QBjVTU35B57IV09e+WYPOuTDv9vv4z+qSiY3YN2UcHn+lrdty2BJqki3mI9k7FrQ/mpZUpLxB4GWUYaGCIhXdlyx0BL0jWb9W4Hqjd0bsykJoLHtOdR2N4vZV9U6FvjWz2CkSGECMmpzsy/TvRwyt/z91tDTr9DXoiewDJdskeRMKcMaBUsLLA773OJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P55SE0Ec9vk9B/5ZawzYqhMU1nLCof0hnkKYf8mFAR4=;
 b=Oxlz53ZDtsqUfp/38Y0QPOGIcuKB81X88khlKcrfLmtO8/dbdIjBCp8GA/7CIrQNiaq8OQrWgkn6eV7E5kQ1wFsnXD4oSLi++HvRFOErfk/8JBU/0UVBFUICb9p2RJW2mXSIa3nrWYF5VPj+fvXU1j8L5gD3xObT4UU5gKmmjGMLHAxe2GpeVDQaYoCcyd3BhsNg0Y85+PYvpUncxicVTSYzFtxbY549fWmjTGB+FXFazUCE0EzQfVuo9HGbPADBxhNJivMG4jo/wI3qJe6TdJ/7y7H5SOU3dEXX8GOeTv+jBfTUA2wuDVSahLZUJ+6eyTvMl8aYxC8ltrriKl3bbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P55SE0Ec9vk9B/5ZawzYqhMU1nLCof0hnkKYf8mFAR4=;
 b=xUX6rFSHsmU/VOr0LMIw0UTBt38tY/8ObOOG3rhj/z66HS7PX2zC7hZMuPRhTN6PW4VCgwwLqGOs8NawJQEGL7djmO3N46EnlghMjvbYz9zd6XTeZqUNV6FRJYP02SZJmtETq9FVvyLuybnWjLzbCLVt/AVdi2MkHAjJ2OPPUXw=
Received: from MN0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:208:52d::11)
 by PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 13:00:25 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::36) by MN0PR04CA0018.outlook.office365.com
 (2603:10b6:208:52d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 13:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 13:00:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 07:00:21 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 07:00:21 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
	<nifan.cxl@gmail.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCHv3] cxl: avoid driver data for obtaining cxl_dev_state reference
Date: Mon, 2 Dec 2024 13:00:09 +0000
Message-ID: <20241202130009.49021-1-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|PH7PR12MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: a8276480-c204-43fd-ba65-08dd12d149d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RsvLlKoTVEGgDmQdy8GWXYIUMGm1a/7Zt+gR4YN3aOXnoP8BnRHKdUdOwPK6?=
 =?us-ascii?Q?3qF/krbBQocS/G+dcnXj0KZzfCM66ZIaKiRCtN06MqKwOuz7xOLOak2iscUU?=
 =?us-ascii?Q?ef1RFxSxBUd/k1Umvy9g0DusmRyBugLr2Hcul9rJupeZPJbkYfhddZAy1mAu?=
 =?us-ascii?Q?/b4WigHcFuirdltc0hBxg+rZ/fapzZRRSNLj1dKAnNZkbmEBzke0QqMCcV2G?=
 =?us-ascii?Q?DHwox/X8aZT1RSJiowqo3uNH60qu06Paydtu24soZ68NIDJq4U16Ax1iQ6wI?=
 =?us-ascii?Q?c27YH2ati5IT0TZiyyTjA5kfB8a/QMw7CxZtmNgL8lX/Tn9HzdWaYGBUTxtM?=
 =?us-ascii?Q?/ukS8e/UNTM0TUV5s/tnbDx7cyb7Co++EP/4iV1MYDoeStSGoy8gecSIcTXJ?=
 =?us-ascii?Q?H31r91Dbbm3u0jyLxwfDbXocfLv7TpKoMNN6lIsTGPpjNdAh7bpXGOb6tkfU?=
 =?us-ascii?Q?SEFn6SwDAcLZAeHHWxa1Wiba8Lkvsmr8OtxOtNMCWJhmoxuHTl18FdOiNDse?=
 =?us-ascii?Q?/LbhMcoFSDpTzuIDsysD6cm7KPLF3nZZGMQb39QNyrTpu87NswDXUBfrLinx?=
 =?us-ascii?Q?leJUp3dwwo7JPVEhrfskZnf9UtbWru6QUXTIEoxzENtCA4q/BD5DF9Rp34lW?=
 =?us-ascii?Q?zpPWSvei/nc5/X3lslp5z028glxsd2rGktBI5kIlIbEyBsa1NJBApzn3fiyv?=
 =?us-ascii?Q?+JhKYoTIH6PXsrUqf7Is3UeCA6DouFuGM9q/jcHuz2X4ZlADr+k5iaorsf46?=
 =?us-ascii?Q?c6kjnzADTbSAEjirMNmrW7c2V7ucZFd8Eb3tuhZusvzBSNwCpx9lQLuUaEwR?=
 =?us-ascii?Q?VVG2epPkwe1TSC5+y2bTZr8TWWEKbM2+LTQI5D7OBtkvk6exCKDRSD4A2YvF?=
 =?us-ascii?Q?uKFKjmL9kzda8WjudXz2K7bggjtzDSqgFADQMfz/gZBbyOvQylwoBpbu3PnM?=
 =?us-ascii?Q?L5Q9vyR3UjL5gCyrKhngU154sE3tyK/sFSqRK60cPMDrMB86eT9JHAQJjCTs?=
 =?us-ascii?Q?7sT5ZqrBzug4mPoD2j+USA64hgkf7JdsdURzUMS6482Hd0gHTiKGHFGIwumn?=
 =?us-ascii?Q?jKwsetunBukGsaUUrKAyo7XYuNo7HVxKQ/Nh9WNdVyWwtozbRu+a+2UlwO45?=
 =?us-ascii?Q?XAr8TVdI36H/m/WOvf18WgnzzE1ZFgWDuTHtAPjZpyBpI15D+ihFeOA2GUD+?=
 =?us-ascii?Q?+1nEoL99X1/go/kbo7EGswL8sWtFMTXnt16832LGrsiMeHOoZT5w4tEJHntp?=
 =?us-ascii?Q?1c57fdbPyrhqNB3o035iZpOyhXWh14mrXqZgdagBfn8v3TXJeQ0gF5hCZGJ1?=
 =?us-ascii?Q?Lv15QYIFS20OsniNQY73pMbXr8F4VdB9WgnPwm8eSFaoioC3zPiU8DAsPBqp?=
 =?us-ascii?Q?kSTq9P2XTDZlVlbldRmKgH0ociNw00WaaeXRFrzIVtjnj5ySWuTCtq80mmmz?=
 =?us-ascii?Q?ooKPGVQ/MoaeA3c94Og6/BEKaHLZrjiy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 13:00:25.2127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8276480-c204-43fd-ba65-08dd12d149d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719

From: Alejandro Lucero <alucerop@amd.com>

CXL Type3 pci driver uses struct device driver_data for keeping
cxl_dev_state reference. Type1/2 drivers are not only about CXL so this
field should not be used when code requires cxl_dev_state to work with
and such a code used for Type2 support.

Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.

Seize the change for removing the unused cxl_port param.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c        | 6 +++---
 drivers/cxl/cxl.h             | 2 +-
 drivers/cxl/port.c            | 2 +-
 tools/testing/cxl/test/mock.c | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 95191dff4dc9..3cfe48cec425 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -293,11 +293,11 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
 
-int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct device *dev = cxlds->dev;
 	int hdm_count, rc, i, ranges = 0;
 	int d = cxlds->cxl_dvsec;
 	u16 cap, ctrl;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 32d2bd0520d4..b6cc00015ad1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -830,7 +830,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
-int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info);
 
 bool is_cxl_region(struct device *dev);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 2b2cde5890bb..7e5c1a4f54b0 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -101,7 +101,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_port *root;
 	int rc;
 
-	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
+	rc = cxl_dvsec_rr_decode(cxlds, &info);
 	if (rc < 0)
 		return rc;
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index f4ce96cc11d4..4f82716cfc16 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -228,16 +228,16 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
 
-int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+int __wrap_cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			       struct cxl_endpoint_dvsec_info *info)
 {
 	int rc = 0, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (ops && ops->is_mock_dev(dev))
+	if (ops && ops->is_mock_dev(cxlds->dev))
 		rc = 0;
 	else
-		rc = cxl_dvsec_rr_decode(dev, port, info);
+		rc = cxl_dvsec_rr_decode(cxlds, info);
 	put_cxl_mock_ops(index);
 
 	return rc;
-- 
2.17.1


