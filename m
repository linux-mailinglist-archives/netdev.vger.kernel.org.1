Return-Path: <netdev+bounces-47975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E378A7EC217
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F62AB20BDA
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9831862D;
	Wed, 15 Nov 2023 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l0o3GQ2l"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A818041
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:20:01 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F3122
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:19:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+FJCf08FpytMtnD328x6RHZJ6bjDLZSDC035cxBEfUg03UFNQimoSzdhHizn7VKKTuSUoHBlYgV8AM2xNB4x798WL8lD8s5FETnlzYo1JTIlIfmBdVIWYtFY0mmNBLT0HgUDLbdhTsqs9iAQ5E1/WRrN5QHdoB0fsCZp2vMSM96NQbkykG5m8bL7y5Bp08bp2JVVUGsQcph/jxo5kILFoWSNlcyVu4mehbcoUhuNeZZgcnZCw4zQU7bgPGj2nRyh1OSPGra9PeECifkMalVhhjknT+UKDtYHW+2EBMZRlW6pXpubC1ACM52NZ8IbgVm1phb0TCp7uXYhsy2Zm2KPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi1ll5bUQC+fZHmms9xCCCKxCR9rsYViyF7NirgDVFU=;
 b=mGiFnV8hbR1XZWINrxCUip5CQeIskmzhQN+IEEqFhUIHfOcidEgGqs2AWJ2Axcj2SaGdGX1sCzWnnlee0i9Lxab+afAr5nAHwdsreICMkZlu1Rpv7Zlj1VhFKQokQpHfhrjy6oEzdFj03z7GgculEkbOfk7PuvQLJuSraVcMgZGvrIJRTrFnjkHNIKZ9/lwj/VtQBOe7Zi3dpdGKVKTRGbg7/g6+gCHb4DCtS4dbZF21t52k/ZMM36zT5fm7Ytz04rRtcIuT6TZhCxpN/65jF9gfhmCv9XODW6wsXv5CVqU92uifoKPslaf9q3Gp7YKfzVN0o9ADN8RjMCoy6Gv8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi1ll5bUQC+fZHmms9xCCCKxCR9rsYViyF7NirgDVFU=;
 b=l0o3GQ2lhRylYR6qSWEVosOP4V055nlK9DynTW5AdbCZXulMwuTUzDDml+oqCbD2AlcHwydpIXYRxPZHb0zagH4D/82KGDnm+32zTh3gjIlIBl5BlVUUPb7t1B4ysnUoqXb238RS7lBJTxl1vOwLxRld0HO46OyBG9H7VZSgLA/CQmNgDLddECgBCI8qyNha3HDPqMESgEvi3yICppera37V6UrCOCq9xjeesyq1u3vRHVJHRJCC8EvSscWQpxVxY8iyd5PE2L3s8jWj0QvCAmAIDdcfF+S69qnKFFicOQ4+Eu1csrxD8oVSj4I3mDxWX6CAdMFJIzCM6IOvAHtl9Q==
Received: from BL1PR13CA0316.namprd13.prod.outlook.com (2603:10b6:208:2c1::21)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 12:19:57 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::4b) by BL1PR13CA0316.outlook.office365.com
 (2603:10b6:208:2c1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 12:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:19:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:42 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:39 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 06/14] devlink: Add device lock assert in reload operation
Date: Wed, 15 Nov 2023 13:17:15 +0100
Message-ID: <bdf5f76deec0e72e25591a4a253648caffb2d6ec.1700047319.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d4a76d-8164-4fee-b594-08dbe5d52e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2JDY142s4Zk+uE2xHzNPpXGtEo0Zf0UBUZNOh/aWtPYwSx1MOHys4yriN9B5jvKuSUBVAaAhGsMP/68cax6BlqV/b4pdBEnAiuPI7bC3yUYa2r52XFJ8mAMLW0NMPqR/uDarxuM6Etb9LcyxjeGO578kY6x1xS9xEbAq5Ut1pvq0Zg0kg1iLsIukUamzRMpE0EL35QvFFMaEGFjMr6Zo80j2jdXy0qSl03MZRs2cnVY/NR0Bp4xNIwApPN6PJbg3JotaSTVgSJtRt2Xo6a3mfnq/ArgtVii76RNqA81jDN8P/Bq96dsMCZEQNvvSAyNvQj/PQLBgOs5uoTzo/rKSjq3p/TjV8nA4awyW02nkX0aNpbIlHCQDcfGG+kN+GVMMWeP0+kVRqtwQ8iZEra9XL07LEx7ntouMEsgEXWz48pPIBIYWi8zide78xDfVfLXljILAa4uLFi09E+fJVlbn00WDeJjXZvj8fTgpkdUjSqSvauoHaasr1ijzQMHdQepOHSF743QJqn4LKlJaCSzGLl76LwYQVeZEbwaC/2XgijoAWKuZ9YoYAE9zAJ5oy+1cYgcd9zkfN0yz2Rb5CVNpQhSbKd2r+NL2dlsf4eApMlgg8NdS8qCApP0NbS8MEIa9pwz4VRNL3Z9IMk3vTCv/+EbGpjz8vW9HvgrKmkVcSbvF9gW0p1FpPRdrpa0tnOx9hKi5kkrQFJZ+jYNvMPb5qcZQHKtuzPeGNtr4KYm7OGc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(4326008)(83380400001)(8676002)(8936002)(70206006)(70586007)(110136005)(316002)(26005)(54906003)(426003)(336012)(16526019)(2906002)(47076005)(5660300002)(36860700001)(478600001)(6666004)(2616005)(107886003)(40480700001)(82740400003)(86362001)(41300700001)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:19:56.9950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d4a76d-8164-4fee-b594-08dbe5d52e63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945

From: Ido Schimmel <idosch@nvidia.com>

Add an assert to verify that the device lock is always held throughout
reload operations.

Tested the following flows with netdevsim and mlxsw while lockdep is
enabled:

netdevsim:

 # echo "10 1" > /sys/bus/netdevsim/new_device
 # devlink dev reload netdevsim/netdevsim10
 # ip netns add bla
 # devlink dev reload netdevsim/netdevsim10 netns bla
 # ip netns del bla
 # echo 10 > /sys/bus/netdevsim/del_device

mlxsw:

 # devlink dev reload pci/0000:01:00.0
 # ip netns add bla
 # devlink dev reload pci/0000:01:00.0 netns bla
 # ip netns del bla
 # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
 # echo 1 > /sys/bus/pci/rescan

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/devlink/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 4fc7adb32663..ea6a92f2e6a2 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/device.h>
 #include <net/genetlink.h>
 #include <net/sock.h>
 #include "devl_internal.h"
@@ -433,6 +434,13 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
 	struct net *curr_net;
 	int err;
 
+	/* Make sure the reload operations are invoked with the device lock
+	 * held to allow drivers to trigger functionality that expects it
+	 * (e.g., PCI reset) and to close possible races between these
+	 * operations and probe/remove.
+	 */
+	device_lock_assert(devlink->dev);
+
 	memcpy(remote_reload_stats, devlink->stats.remote_reload_stats,
 	       sizeof(remote_reload_stats));
 
-- 
2.41.0


