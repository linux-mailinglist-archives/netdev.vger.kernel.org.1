Return-Path: <netdev+bounces-47971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9807EC211
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1661C20B46
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE94518038;
	Wed, 15 Nov 2023 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzCy1QeL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCD18B09
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:19:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B96110F
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:19:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUh1zjJjUXTOZkTFQG7v05J5hvK7OsFadhbjIw0AkHRb96IEoS/kNt/I2tB5c2r73IoeBPRP2RWDEzJ7RCSTD936s4OZtJbJftr7IqOwi5nEcSP9CzkqMxyxqSj5/dW5dNRG1edQX+WpoB3vYJH1oB5a716A0ak9q4ZnkbTX8w1X041aWxdQuJDJl6sQF4LT1El+8rrX3vRqB5p/aL6AMcDwhBXIwLqXOdNQHxbnNQ2EselEzEsmiqsYm24E27YPW7j2jY8DlXIwtPRVBCcJeaNLA6N7MMK5wIDd69ZN4OFVmgJy0eQTNubVSelRJm71/UgS0nA4fWUYfbBQCIddhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1We81OuQMJeh0KSquaN5a8v+yWcpTWlx/BNOeBKAp9s=;
 b=Dh93h8keefY3yZfwJefimJK5A55ZJrbKg/hKn0kiOMPp2d0CCsE9K5CyGAD5n6blTODVfTm15sPsg7qsIGTfI3XzUdQk0IvRV04oSTrVazH1Pb7CJuNC+Zuk0l2e5G6rhXq5F8O6DFr7j2Blye3tF5JkL88kGeJn88Z0rnXFE/AcOnvnDw0B1o87y2wbo5kdTq3K9rRfOXYqQ3TTIsuNc1IQUQzkxfbspKQAghdb9fCYakULCn4obimwzZF+/fskMGWWPHoUyiWBVl3TlexwCwLczQjyPaKmSGsbe+RjKclVqzGIt5hYwFYI3F5ckHzEq65YAtua6FGC1HbTW8p3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1We81OuQMJeh0KSquaN5a8v+yWcpTWlx/BNOeBKAp9s=;
 b=nzCy1QeLKcj3YbLOSeIam5mQZTs6JOEGZZ89PfZN9G1TJCNfFPc7n4qXNFnXHO+rZcU1+J0kSltwFuzi59w06aCjhwHq4DLPi+uwfPWbAmhJA+c468YcnVhzt69VFalsOffwf8oTP70U/SXW+Xq+v770fgZLCUr8vI8oKqq8D0JTQEvOhSc7HycEP4naSxun0ODjHSGoQSR1tw++LwV7X8CR+7H9FQTMT0v97mziA+9bf6MHNaEjD8u5RRFnuVSqxHfqjmVDlKO5aZm8voXPSBiug+dVQ+PmP2OOjHuDgWfgWkpAypOevBOMCz6XCuCCLmHzmrk6ZZrtMf5wEwIxJA==
Received: from CYZPR10CA0017.namprd10.prod.outlook.com (2603:10b6:930:8a::17)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 12:19:40 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:8a:cafe::42) by CYZPR10CA0017.outlook.office365.com
 (2603:10b6:930:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 12:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:19:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:31 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:28 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 02/14] devlink: Acquire device lock during netns dismantle
Date: Wed, 15 Nov 2023 13:17:11 +0100
Message-ID: <e22be2464d90ae9c7b80e17570e95aea9615dea3.1700047319.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: c624aabc-d2fa-498f-a497-08dbe5d523f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PvP1tuOOnxk0ME7EWuhPX3FZIV5sN+sFh+A2wp2i4XSYniPI4Bqlzseh1jlm7flVcdTiDUX0s7QezMYG3GihBGRo9iRdkZk1jykG0be3GnVFx62reoYx18P9xgV3MOhLcBXq4VBKof+ZQB9reBFjVuo2V2Gt6csJSzurEl9N+veJz70d25EVavbeVYqhrGoCoH0/aejUqOyd6svXgVmiBBiRHg0vdW5mOAeGNPiU8lD0Zr6Ss5DbqutaIhr56TPcRZlu5J4ygDU2emp8aOy5k3V3ldj8sd3iKnT8jZTBmWstKxoY8U3M/Zl3ZHV0C6rn2rVklKSvaYYOmYGqctQDBxya9s9oQYmTinLCkbDdSLqd8EYPcMPVAFFhhTb8+Ux43ohzZ+6Gh0bjUS71XximNVyA8XKPxSXodXCNHoIi6bLzs4Y6M9B5/gLNcglVe4WG/ebMcKXpi3xTd8d9fIgUzh7GbwMr3auZM5qkcDQzoPCJqP+JB5imBru4qEKk76nQDpgdimDTYyoFZ45b8RD0uLdcGAnixW47NC1+Z9Z+HXWeV6xqOOTXEVPEl4x0xyiycWXpMu/ZVPvo4gEctB5Ya/45caajQ+HDcHxsYUZypTQMkLlyO9fhar9fuGPnWRb37bpxhwLy27+n0DRPzRMg9AAeBObgf5JoUG1UyVS9aDBPXZ9uQMxZnZZ12ExY+5mOhoMkyCE9HdbMnOmBPfWTpk9wmZDsn5AsNIxot+4oNFltgpyack1ixwZBzkfwAX6G
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(40470700004)(36840700001)(46966006)(356005)(40480700001)(7636003)(83380400001)(36860700001)(54906003)(110136005)(8936002)(4326008)(8676002)(70206006)(70586007)(336012)(426003)(107886003)(36756003)(41300700001)(47076005)(82740400003)(16526019)(26005)(2616005)(6666004)(478600001)(2906002)(40460700003)(316002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:19:39.5731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c624aabc-d2fa-498f-a497-08dbe5d523f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

From: Ido Schimmel <idosch@nvidia.com>

Device drivers register with devlink from their probe routines (under
the device lock) by acquiring the devlink instance lock and calling
devl_register().

Drivers that support a devlink reload usually implement the
reload_{down, up}() operations in a similar fashion to their remove and
probe routines, respectively.

However, while the remove and probe routines are invoked with the device
lock held, the reload operations are only invoked with the devlink
instance lock held. It is therefore impossible for drivers to acquire
the device lock from their reload operations, as this would result in
lock inversion.

The motivating use case for invoking the reload operations with the
device lock held is in mlxsw which needs to trigger a PCI reset as part
of the reload. The driver cannot call pci_reset_function() as this
function acquires the device lock. Instead, it needs to call
__pci_reset_function_locked which expects the device lock to be held.

To that end, adjust devlink to always acquire the device lock before the
devlink instance lock when performing a reload.

For now, only do that when reload is triggered as part of netns
dismantle. Subsequent patches will handle the case where reload is
explicitly triggered by user space.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/devlink/core.c          |  4 ++--
 net/devlink/devl_internal.h | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 6984877e9f10..4275a2bc6d8e 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -503,14 +503,14 @@ static void __net_exit devlink_pernet_pre_exit(struct net *net)
 	 * all devlink instances from this namespace into init_net.
 	 */
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		devl_lock(devlink);
+		devl_dev_lock(devlink, true);
 		err = 0;
 		if (devl_is_registered(devlink))
 			err = devlink_reload(devlink, &init_net,
 					     DEVLINK_RELOAD_ACTION_DRIVER_REINIT,
 					     DEVLINK_RELOAD_LIMIT_UNSPEC,
 					     &actions_performed, NULL);
-		devl_unlock(devlink);
+		devl_dev_unlock(devlink, true);
 		devlink_put(devlink);
 		if (err && err != -EOPNOTSUPP)
 			pr_warn("Failed to reload devlink instance into init_net\n");
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 2a9b263300a4..178abaf74a10 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -3,6 +3,7 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/device.h>
 #include <linux/etherdevice.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
@@ -96,6 +97,20 @@ static inline bool devl_is_registered(struct devlink *devlink)
 	return xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
 }
 
+static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
+{
+	if (dev_lock)
+		device_lock(devlink->dev);
+	devl_lock(devlink);
+}
+
+static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
+{
+	devl_unlock(devlink);
+	if (dev_lock)
+		device_unlock(devlink->dev);
+}
+
 typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
 				      u32 rel_index);
-- 
2.41.0


