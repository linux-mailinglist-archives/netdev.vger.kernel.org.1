Return-Path: <netdev+bounces-78554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C2875B5F
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 01:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDAB1F21580
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 00:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE42632;
	Fri,  8 Mar 2024 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECuZ4IWm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21736B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856112; cv=fail; b=BoJL81r/tqu8LEoE69hJceg8RH6W2wj/R5sY2jsOYy3YGyo7Zh/oWdRJ5HKW5KA4B3UQHQS9JW/8un4tUGToHhlgVjzbVJiI7m22ZWntyqWtB9P0gMX1XI3Ru78F1MW9sxBjm9DwFDauqoQL+W+fn3fxiaNaLggns3ASOLEzo0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856112; c=relaxed/simple;
	bh=DG/SQdOVfrFDe/2fXRxKQtkQbyyXSWecxg1oJDxT8+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qS2/3+RgfFGrimqscGWKFWYRhdWecRM1j42b4iAqriVaWg0nhUrcA/XKel13JRdfM4s7U/BnxmhGsBqh5nVKpAV6RFH9c62UJwLrbZtuhEts/d4cx9tSRuks6iR49w7dB9PEjke5o2GhxvcBPvxfr3XNLXPNe5yyphtIrRwjCWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECuZ4IWm; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4+H8MyzQyD7N/dGs43CFSiZah8XSHxQ0gAcZ0AAJjO/umoEehDrQKjqY8kMjb7y4R8t8EruzdRz1sRfuHsv5oVBRzB/WPRae3fa3kV4Xc95ImHWA3cyPvJmCcoNDZa8T9n4Fk40qEWhHaDd2kywsnEqdT5i+mmcbG2SNeXi++bBDf3SDGodoudxAa+r5x4RWVz9fEVlmPvmEVV1eVauFDmIQpc1Og/R8Ddyi6N7xDoHjuRAoNvz3Rlx7vW9atrWApZw8Wnfuv3Nz3lx+CU/KslZvN3GVCfMR2Ucomzip0BXt61Ku2W9uQjM5zznZjBJLZTezhNl/ruBuQLsuYyAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdWcApSVoR+PQx2o94LItdMetHcmLwMfER7Yef/9Uew=;
 b=mLj6cZISMblNXBJS95HEu/Xm3RKckUnr/FkpgQ/xZJTpqtYXFfAI2pa1vCkFiGdbLx26CDje17LWPb+uMUmzwKxvo7ZT6RAySCje3qbhJ02UxmezPeW9cfsPIPceH0vkRCeq6oNuMZHDs67LJpUS5Djop5EQbKK5py6B+Ve8k/9a1UVQDYz6+McSY9ymUobtU2dYZ7FEoRnnhE6PoLwdu0MfzDhkx3YU8/YCS1tt0mRPZ6dnfJrtFPFnNz2ce0P37i+d5vfENNkYtLYy2cAf6m71/Dm3afpN+fKcp2HUFLXkoA3SJYzPQ7qBGIPQY3eJtgbTAiU4k4zHUHOA9V7PWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdWcApSVoR+PQx2o94LItdMetHcmLwMfER7Yef/9Uew=;
 b=ECuZ4IWmge943XGXlmOzLoO9Te6xNyKAb2tXH+aEFzd7BQUeNiexZZwSOHaJ774rrHdFRatAdor4IbyLHrvcHGVDarTUcT9A9e3bJ4O+aFigT0ogG1aakEqgLEYzNTXZ0aEVT/51QNhu8IWgi0ym/4dycYSZ3H6XZ+7Wn96rm41w0A5BpqL/0I9wqoaZRH4zs/K5ssNX2S2L9/Utwena6FUETxNPArqr2tfmYEjYtsVUlNdJRx50BbCLEsDsSc7kfEpzQEVDzzv23lhxS7XKBYP3IuIyqlklU9zA6/LrAJaQpRF2FSyjw41LIxaOQi5QN8FA/gNCs4+1PRIuPYAo6Q==
Received: from MW4PR04CA0337.namprd04.prod.outlook.com (2603:10b6:303:8a::12)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 00:01:40 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::7f) by MW4PR04CA0337.outlook.office365.com
 (2603:10b6:303:8a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Fri, 8 Mar 2024 00:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 00:01:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 7 Mar 2024
 16:01:18 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 7 Mar 2024 16:01:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 7 Mar 2024 16:01:17 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <kuba@kernel.org>,
	<witu@nvidia.com>
Subject: [PATCH net-next] Documentation: Add documentation for eswitch attribute
Date: Fri, 8 Mar 2024 02:01:06 +0200
Message-ID: <20240308000106.17605-1-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 0228065b-d2df-4827-9f1a-08dc3f02ee6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fb/oC4NBnDjsLJ1baOCs9P3qxpotzhbc2vArZz1Kg6DW44G1BgtiiTxWHa9uPo1sLoiynwCp/9kx3+k4n1dugwzp3yQgANh+X8aQSoaN8SvGBcQRCTJ4vKA+wolVj4ximaHVT70TXmICiLajvw8eORHUFHzwDsEvuqTpFpZZQvM1NZCIc8/QZSWm2I785LEe0U3L++vCaLPiRzx46LiIFH4sFn94rRFDdjjvowKni5CNG4PYCu6EiiWYe434tYp726tRzL5Kt6s9E7WQ7kHzbfRCv5NaXx0sGGsf3B/wdkQga04fbQ1SL16XTLGJF7QXDbVNmUJMKcp70xW2dsmNXbAGUUdTGSWpcT6+4CsPe8tB+KlbG46r8Y50+JPYZPCrj+SEnokdYxSIHcEohb5Yu5zzKC0stTwenPYW08/KoKpBVuVp2xriyrP/5OmUQ/Gpy1sCUFq5biTbhNOjBkB9yZJP+MEq1hoGyRSFawiHH7UU3A9wEJ9nr5b8lGD1cgkKpIpbwe2P6GAHj9d3RKmrdAWgW+76/IucnwSQRNUorhS282/Mtl+7yzPKCM/Yne1jtY/xrQG8Whqcv8k6O7G3dfon+Jq/t6a20wBgP3LsoRHO3PCxMdzsDDto29ZH6+tmWVQQaWFVoE9Zjz3jakswGSgDUPSdRvlAhhrlCT18K/CRIrytNM5enL5EPxt0xiPCPBvRPESH1cXB1nNJ8HIf1rvYzV0Y63Et4wxyu7XVCwxG4eCyF0earGgbfDIopZQz
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 00:01:40.1123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0228065b-d2df-4827-9f1a-08dc3f02ee6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395

Provide devlink documentation for three eswitch attributes:
mode, inline-mode, and encap-mode.

Signed-off-by: William Tu <witu@nvidia.com>
---
 .../devlink/devlink-eswitch-attr.rst          | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-eswitch-attr.rst

diff --git a/Documentation/networking/devlink/devlink-eswitch-attr.rst b/Documentation/networking/devlink/devlink-eswitch-attr.rst
new file mode 100644
index 000000000000..2405f19e1439
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-eswitch-attr.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+=========================
+Devlink Eswitch Attribute
+=========================
+
+The ``devlink-eswitch-attribute`` allows setting/getting devlink eswitch
+device's attributes.
+
+
+Attributes Description
+======================
+
+The following is a list of eswitch attributes that users may use.
+
+.. list-table:: eswitch attributes
+   :widths: 8 5 45
+
+   * - Name
+     - Type
+     - Description
+   * - ``mode``
+     - enum
+     - The mode of the device. The mode can be one of the following:
+
+       * ``legacy`` Legacy SRIOV.
+       * ``switchdev`` SRIOV switchdev offloads.
+   * - ``inline-mode``
+     - enum
+     - Some HWs need the VF driver to put part of the packet
+       headers on the TX descriptor so the e-switch can do proper
+       matching and steering.
+
+       * ``none`` none.
+       * ``link`` L2 mode.
+       * ``network`` L3 mode.
+       * ``transport`` L4 mode.
+   * - ``encap-mode``
+     - enum
+     - The encapsulation mode of the device. The mode can be one of the following:
+
+       * ``none`` Disable encapsulation support.
+       * ``basic`` Enable encapsulation support.
+
+example usage
+-------------
+
+.. code:: shell
+
+    # enable switchdev mode
+    $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
+
+    # set inline-mode and encap-mode
+    $ devlink dev eswitch set pci/0000:08:00.0 inline-mode none encap-mode basic
+
+    # display devlink device eswitch attributes
+    $ devlink dev eswitch show pci/0000:08:00.0
+      pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic
-- 
2.38.1


