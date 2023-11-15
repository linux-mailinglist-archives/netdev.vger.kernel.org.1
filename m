Return-Path: <netdev+bounces-47976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD09B7EC218
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D7FB20BB2
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001881864D;
	Wed, 15 Nov 2023 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cPbV2ICE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B418646
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:20:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E31C123
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:20:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfWGlwGwTnMNt3jdArjCUgyULLe4GY/o2aZjml1reHnJ8qosM3th+An1SOiNhWRrN4mReXjEnjydoxSwHhJ13USTXClG7Hwy0tMtWayi8hC3bt+kj209Ursf64ObERX9+gcraJmiYXo2ikeO0eDW1pSerYyXW/vCJmbkjzxxUHjK2fcWNL9QEJ4zXi3C0FUlECLRnmLhHRj5GJa8NEFuVRMBd4th5+TPhwDRwHot5udPU4K4ixI1AQDUUTEgLXI8fAjvpaewvqKzPP4VfUnlasfmIPtQYFa23bG/jvTMoLbDOL4XGOSFFyhjJDPwztFbPtd90myKgbRGUsAV8SkQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2vd+gUAqn07Jsg1MvHXDX10RaQvznIOjexN8rUoBMU=;
 b=fNWevKrrT5cLSOE7qkoS5twr5hPk0uQ8o87PBljvp3p5erB2fKWnuhIGmmp1CI71l46BqXy3+drobw5uiTY1dhGYbjmPRb7XmJ3ck4po0ByQHjySLk/aFMvMM+FkQB88qaFdFMmYE1a1PhZcX8b9IkV6jMz8TzwIb+blgnLQj3xw8wze5dx8Z9uwAI2WIFYhZJbgahi1FDVRqPtAbsHgnQ42SzT1Lj5F1x9k7h/rc7jCciJ2+XvPSZyyv+4gnUitzN57PU2o7eO0LVebeWkMTvPwofzUA4ezP/wjDgDJ+fsFRi+HuN/rR5W/MYzLYKjGln1NoGRjtZEfVq+WSMZrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2vd+gUAqn07Jsg1MvHXDX10RaQvznIOjexN8rUoBMU=;
 b=cPbV2ICEktvNTsgMdUi21Po0uQQ8HXsFniaIpX2k/BflZYQ329MJDjCvXqYDwHmAHyafiiOeeyEHvv+XeWEbyYYRX3bi5u1WJFWRs/4IGylQuTAJpKFUvqVSeMoA0VIBMuLIxBzHUav18QbG4D0crywHsEldW+0Glt/c9qgJCXHHDyNPv0/e2Hz4a+HPzH7FgcgjjX9rQ8pSlmgVKarykbFJfPXPyuiQZm+O3QCBGupqmgWuCmeFgUQh3/9XTrCXASOA4k79gacssFiUUtFB57Nzz07WpHKfZl1mIUOee8mgzeSTgauSE+ztRWsir0ICF6ucz5Xj24tu1wBM1wVbWg==
Received: from BY3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:254::9)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.34; Wed, 15 Nov
 2023 12:19:59 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::bb) by BY3PR05CA0004.outlook.office365.com
 (2603:10b6:a03:254::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14 via Frontend
 Transport; Wed, 15 Nov 2023 12:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.14 via Frontend Transport; Wed, 15 Nov 2023 12:19:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:45 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:42 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: [PATCH net-next 07/14] PCI: Add no PM reset quirk for NVIDIA Spectrum devices
Date: Wed, 15 Nov 2023 13:17:16 +0100
Message-ID: <fe4156c6b9d0f7e8478ae93137586ec88051013d.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
References: <cover.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: da0be9bf-f4c2-43d3-8ee8-08dbe5d52f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CZmqus1Rbm0o8VQ5FBwHD5+7NZ/cHNjeDVYMq4deL/84tw0CZ0gFiQCwAW9YlswxX41fpjvURlvZlk3L8DoowEaZm6q1x28JswKPlBpSbcrY+htBWfu8S/fj3+qCeXn5bZckaNObv5u3Jno6gqrpqAy2F4CEtwavzOLeIPXq7jjRtF5zmBuMemWnMegP1RRZh0Up7kCMyA6GpAW7lL8B7bjs3saIdnKYYfUE0dkGTiaXq/vrhKxSzftdjFz/i9uuCmXc+BTTHZOUd3yEJ9aQifniIBkJ5hEJVO6DCHuyt7bezdrIbvacWcwNBloSGFAj0UfJJGc967tdE9Z/5FF6aZucqf5n3NLSZ33kJcGCUDhgsx9nU/aDkuAc4x0oVB4YO27DSa7Ow2hG/TJB+8KlbeZgPGZzersqtR6ARSw5EAChuqAFznYShq/mbYagUUbrRgwaxKyn9QwEgOqY2vHZ5zLLntNWc9lGckdubR6er06/rGwehYmiWVuxMVdCioHNbOcfWq6/M1oapvku/vYJbtvGrPd5zcRCWAtBrVtrg1SyKSdcb+vs8tY07CGQMQE2ysvgBR3/GJmZ46L8ICcOL5/idmbA6KxJClxcUme6FRo2a3lDcwwzw1egzOsqgfw0O/pUhPSrdn3c50Bvx5yWz1b38TE8j2PBJ9/AVCVZxhU+fxo+xq1TcYZ5vdwytHrpRRZkRQfUUBdagP8tjclpH+s89L08RO/KuspEOcLMOWP0e2PbUY3pmguCydn4FjAN
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(47076005)(7636003)(356005)(40480700001)(6666004)(36860700001)(40460700003)(426003)(336012)(5660300002)(26005)(82740400003)(2616005)(86362001)(2906002)(70206006)(54906003)(8676002)(8936002)(4326008)(316002)(36756003)(70586007)(110136005)(41300700001)(16526019)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:19:59.0292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0be9bf-f4c2-43d3-8ee8-08dbe5d52f90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553

From: Ido Schimmel <idosch@nvidia.com>

Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a
reset (i.e., they advertise NoSoftRst-). However, this transition does
not have any effect on the device: It continues to be operational and
network ports remain up. Advertising this support makes it seem as if a
PM reset is viable for these devices. Mark it as unavailable to skip it
when testing reset methods.

Before:

 # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
 pm bus

After:

 # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
 bus

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..d208047d1b8f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3786,6 +3786,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
 			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
 
+/*
+ * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
+ * (i.e., they advertise NoSoftRst-). However, this transition does not have
+ * any effect on the device: It continues to be operational and network ports
+ * remain up. Advertising this support makes it seem as if a PM reset is viable
+ * for these devices. Mark it as unavailable to skip it when testing reset
+ * methods.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcb84, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf6c, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf70, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf80, quirk_no_pm_reset);
+
 /*
  * Thunderbolt controllers with broken MSI hotplug signaling:
  * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
-- 
2.41.0


