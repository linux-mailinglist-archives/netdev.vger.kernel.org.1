Return-Path: <netdev+bounces-44416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C17D7E8D
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9673B2131C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A5DD290;
	Thu, 26 Oct 2023 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AR6JCzFI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEDC27728
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:34:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B33910E
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC0PuLh8oAXwIhseH2Fx+EGA/fcT2HAbymMq3YMZt4iJG4dn4a+PUyUGq8kgGWvCFT5Ck6j9HhOr8647nifCNtP1z6K3f5mzm5ksCFaHgdx61OecuG7STN3tPZ1Skrc5meWKZ5ebJDRFz/5GjPX6D9h7LR5jGDDzAPDrlJoR9xAkFha2/QtSAAvLeNbWBAbTbwXWxrHFDxPaYiuqWNZnX88LxIaj3106Cl2oMwaWW3pKZWEjgYHWsV5oVsu5Xhk8GCLec5Wpp/wnar73lv3j+Nw9cpmbnpq11ENDHe0VATmaIokwC02xXhiZ5VJ68UbFaKmZgJI5Gyb6GYnJBKGWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXkUz/K2bMEYJiM/TDyQZ56lWw8OiJh8ee2CRubrW6U=;
 b=Nx+rYANjzDMNnTkImC2L49Mh7ektoPyH5kgHuh3Us655j4mxka9ORzapWbXqofWf1WPDEKBygzzptH7RawjVnv/LZst7MK7GvhUhuuzUz+NU4MSPmbtYUxgHZ5i7ut5Jd2l8pW5OFtvljVycIMTdMuAXe57BFEeuTHv6N3NH1MiomJIYL7kiUjP9p2cw9k1xGnhiTSqaOSunwzeRG67CTze/Y8029fWwcK3x8yUPyZR189s45YWuUC5bmwm93iXTM2Ylba2CuD2vlG/f/9OobagnsEaCWY+YfzKztlSR5gn9CUviic8KrDrsC33OC0qKtSevk+UsS72nWQBGqrN+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXkUz/K2bMEYJiM/TDyQZ56lWw8OiJh8ee2CRubrW6U=;
 b=AR6JCzFIjz1FAVwzMurhKbr1xWAGdF75BTd4d6FVk1xh8xiyIgI/C0wuXs9kih3QyLbAFaTBSIim2v+lTVa7LGbqjd8rGvg8fA0EB+mSmjlem1NG/gDQ+IKogE0HWYsoBjEZCOFrkrYOSk+wyg+QBZQN2OM4ml00OxgXyLhY/v8XKz1z/tUjA/Gv041Ww2HDOzQTEnyaG6f8c+YMaOROSHBHaSK0mtkjLJFOFtaHDzv9WmglyJG9Ddfs1Rg5NrBDn8WdsjSgzq6w9km8wWewlWf8ugOmbdEDRz9han3TlGE0YEIaa1ElwSpju11z4x1jteIptJy8Tk5KWV7X8O//Ng==
Received: from MN2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:208:23b::26)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 08:34:24 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::6b) by MN2PR11CA0021.outlook.office365.com
 (2603:10b6:208:23b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Thu, 26 Oct 2023 08:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 08:34:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 26 Oct
 2023 01:34:11 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 26 Oct 2023 01:34:08 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] netdevsim: Block until all devices are released
Date: Thu, 26 Oct 2023 11:33:43 +0300
Message-ID: <20231026083343.890689-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: b2221144-7110-4d10-24fa-08dbd5fe5baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dcr0Vhm7tQHxh59Uhuogcun2tH+FOJuKtoFR5Ro6sNiDhb0YfX+7cNIeJ1/OmjhpM8pjJ6SKYN0yYKlzREP4xKVcpPIujqYC2CFUcqB/eGBd4CHnByeINip5U4Q2cOICGBEn36Jrksfmfsyq5pEtnGGG5af11vgl0QUAbwUTlgjBH8SfNsfxQCreZGuFLE24IcmxcH8ij3f2UUm7LBhjd9TD9A2lSGIr1/RxpVph78Jdnher+tagaLSWoOClhYs5ax3CPFDGi28lGUNnCSneHI8rVHYiKU6Hhp2EL/MLKV5r+StcnJbgwK7cFg0YSF6Qr88Z/wv3DjhDFsK35n31cN6ryeUUksEpEvcR/VsC+zm57lG6J4rxi8xHl7NKrij6VPCX6k7CyuXiiugz9yWI/S7csOSzpSKXmKeZV760XbVwRb6pPbIBRmoFBrKPTNHxusyr/emhMKEdvpcfnkFKTmGNNBABtxDhD07M7UwKXmiHH3IhwofsrD7Z1pePw0CbXwipJjPHMbaEohKOWWuA986umjyloZoxSw8SunOqjYh5OcVusWVIbnztexR96CQiiH+nhStOVlUGA+Gi0CVGGCBHbOtvVnPMFi1nQ1XYyfwMEM+fiueXYTg0GEOYrRI2CuNuJ2hh2ZqlSjZktc/JvOulasmcXsxncf2xeHL8OxZfiHY6cWvArvndUAX6uvLFppoKg5uBC9HywHCHbvsFSslxYSKLGs5b7YsqLRVT8OLx90kuSpdv9/6CkuGYOCHqeZclcLtn9ljLcllRhtjSeQ2sDRO8KSaBhD8PEt1a6QgBwxgsVwHbDHz39NZ/qbTh
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(82740400003)(2616005)(41300700001)(336012)(426003)(40460700003)(40480700001)(356005)(7636003)(5660300002)(107886003)(1076003)(70206006)(16526019)(26005)(966005)(8676002)(4326008)(8936002)(478600001)(6916009)(54906003)(316002)(70586007)(36756003)(6666004)(86362001)(2906002)(36860700001)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:34:23.7171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2221144-7110-4d10-24fa-08dbd5fe5baf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

Like other buses, devices on the netdevsim bus have a release callback
that is invoked when the reference count of the device drops to zero.
However, unlike other buses such as PCI, the release callback is not
necessarily built into the kernel, as netdevsim can be built as a
module.

The above is problematic as nothing prevents the module from being
unloaded before the release callback has been invoked, which can happen
asynchronously. One such example can be found in commit a380687200e0
("devlink: take device reference for devlink object") where devlink
calls put_device() from an RCU callback.

The issue is not theoretical and the reproducer in [1] can reliably
crash the kernel. The conclusion of this discussion was that the issue
should be solved in netdevsim, which is what this patch is trying to do.

Add a reference count that is increased when a device is added to the
bus and decreased when a device is released. Signal a completion when
the reference count drops to zero and wait for the completion when
unloading the module so that the module will not be unloaded before all
the devices were released. The reference count is initialized to one so
that completion is only signaled when unloading the module.

With this patch, the reproducer in [1] no longer crashes the kernel.

[1] https://lore.kernel.org/netdev/20230619125015.1541143-2-idosch@nvidia.com/

Fixes: a380687200e0 ("devlink: take device reference for devlink object")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
Original posting is here:
https://lore.kernel.org/netdev/20231017074257.3389177-2-idosch@nvidia.com/
Had to reword the commit message to reflect the fact that the bug is
already present in net-next, which is why I removed Jakub's tag.
---
 drivers/net/netdevsim/bus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 0787ad252dd9..bcbc1e19edde 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -3,11 +3,13 @@
  * Copyright (C) 2019 Mellanox Technologies. All rights reserved
  */
 
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
@@ -17,6 +19,8 @@ static DEFINE_IDA(nsim_bus_dev_ids);
 static LIST_HEAD(nsim_bus_dev_list);
 static DEFINE_MUTEX(nsim_bus_dev_list_lock);
 static bool nsim_bus_enable;
+static refcount_t nsim_bus_devs; /* Including the bus itself. */
+static DECLARE_COMPLETION(nsim_bus_devs_released);
 
 static struct nsim_bus_dev *to_nsim_bus_dev(struct device *dev)
 {
@@ -121,6 +125,8 @@ static void nsim_bus_dev_release(struct device *dev)
 
 	nsim_bus_dev = container_of(dev, struct nsim_bus_dev, dev);
 	kfree(nsim_bus_dev);
+	if (refcount_dec_and_test(&nsim_bus_devs))
+		complete(&nsim_bus_devs_released);
 }
 
 static struct device_type nsim_bus_dev_type = {
@@ -170,6 +176,7 @@ new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 		goto err;
 	}
 
+	refcount_inc(&nsim_bus_devs);
 	/* Allow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, true);
 
@@ -326,6 +333,7 @@ int nsim_bus_init(void)
 	err = driver_register(&nsim_driver);
 	if (err)
 		goto err_bus_unregister;
+	refcount_set(&nsim_bus_devs, 1);
 	/* Allow using resources */
 	smp_store_release(&nsim_bus_enable, true);
 	return 0;
@@ -341,6 +349,8 @@ void nsim_bus_exit(void)
 
 	/* Disallow using resources */
 	smp_store_release(&nsim_bus_enable, false);
+	if (refcount_dec_and_test(&nsim_bus_devs))
+		complete(&nsim_bus_devs_released);
 
 	mutex_lock(&nsim_bus_dev_list_lock);
 	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list) {
@@ -349,6 +359,8 @@ void nsim_bus_exit(void)
 	}
 	mutex_unlock(&nsim_bus_dev_list_lock);
 
+	wait_for_completion(&nsim_bus_devs_released);
+
 	driver_unregister(&nsim_driver);
 	bus_unregister(&nsim_bus);
 }
-- 
2.40.1


