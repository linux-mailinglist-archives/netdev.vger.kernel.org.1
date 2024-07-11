Return-Path: <netdev+bounces-110879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4531A92EBA7
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 17:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886B4B2128A
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE316B392;
	Thu, 11 Jul 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NCxi96Sb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCED7AD39
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711675; cv=fail; b=TXdnFDmGM/hST24wwjDaF9+rJE8IXKaV9xku2+g4kMsRo3larA0tmmcFMCUprC2lrez0xov6dMtfXNFDPTucH7ZVE6nFVPzTofh/plzqg7/aNSJJNPre8xVmDDwHjHhC3+WlEdke5Qrt6EzLQUw4wJrnzmnpJNHuOKY0360/Nr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711675; c=relaxed/simple;
	bh=fiasV7SJDDPTZsKB7B0b/eBqYkVQPrmL8NhRpyk4gJQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lwaBvDi1DzmLm+Nay/8+jEh2HrlM4BcqgbLKh/wLIYF8Lqx6jM3sENjGHYOFflQrorOlXY509siye28g2gm+4Xkmla+WgMlBhaJTW8gF28ZAUoz0dfjrjmP5+QC8zWvt/Wi2p6njHlC1MpqEIAZF6DSVr9h4lJiSfCUk2t1kY0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NCxi96Sb; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPbJoloIq+RmzTSHDu/K0pvvzhZN+ls2UaYQFbnM48Xo3uowNNWg60IpJI8CypZ8WF0Zu/pvNbHeTQ47deGdmnvybA0FYVhjvb/+6+opqNfGzbHHyU2tjDRB0genE2T9T1EpwW/CWcLtIm+B8z6PARSSckb3nWpb5LuVnSjmHUn49idJ/NBKgMyxN9n6CLwfIG5AeQ82Lrd9wDmTjwuXuNyYGRp/FTmr2Pn1sP0Oz5lscv6g5yxVv84axs/QDpeho8jF/6PKal5nZpRhngJrXz4D4i6HhIaWxbpGrcsSH9dlc0rDC+hLDDjc0vYAq1dxwqhjQ0h7IT5n3xlp5E0lEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB+3nsoiQYRuS4e8xSDxOaCkDWuPAcUS4BfyiQNEshw=;
 b=Uh8derEPtcOWsQswogFuvFwLUIABY9A4Z79kBwAL4KsWyNICsyilonPEtcPidsFt7FOoiL+/slNMtagfVJFOqCT0Cgtzb6HN17fir3L3Ax91IiL5FHUUJYPGcdo35Gx2AA8Eygkb0/49enZ9Pvag1QzE7IcAo+vhBSDROVIrhW5PcY4Yw2wCIC9AMgjfcdBOn7EoddBw7f1hv/FhKbguzCMzqAqLeebGLvoX8sDCZK+jTKRHiGg+BgiXeNKrIp8hbxFSFjdACRnBJhV+wLaAjULa0RktsIPil/K5tpUkhxIYKZPF3iBHqUJk/AFTJ1AxOb9jWUM7tgf0SaN+VzJpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB+3nsoiQYRuS4e8xSDxOaCkDWuPAcUS4BfyiQNEshw=;
 b=NCxi96SbwYV0kQgEd3eVpOaLEowlMEebhTkXaeIMzG/8WHVEgSaFEImCa+SrBL5tKIpJC4HOKRPMcu1JroBZJRKkF00poVfXKfYUXbwYEH/XyYjCs/Bha9l9XFXlT1p2DWFEvLaFcutyAz6NZNTiJgl0gk65wH59V/qkA9PNUUB6N8XcAyfT2xDFIjZ+fD5dCqCC6SpKfKcSNpUvji/PrBfCju1hWsNPyV3I+9bBPW3zFkweZ3vMV9JLxAzW9ezdN9hGPSg2BJUHcDHO2FANuzMVx65Y+X71ZbhdC7H7EhmwQ9AfGNfxNDdNq7POzhTvTpb09/9as6U9UI43g0Jenw==
Received: from CH3P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::13)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 15:27:46 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::3e) by CH3P221CA0028.outlook.office365.com
 (2603:10b6:610:1e7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22 via Frontend
 Transport; Thu, 11 Jul 2024 15:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 15:27:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Jul
 2024 08:27:32 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Jul
 2024 08:27:27 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net] selftests: forwarding: devlink_lib: Wait for udev events after reloading
Date: Thu, 11 Jul 2024 17:27:02 +0200
Message-ID: <89367666e04b38a8993027f1526801ca327ab96a.1720709333.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: a209afe5-1862-4b4d-dc24-08dca1be0363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zXtf2Up2xSXa3URlrXVxYu2mD9KH37SY8hVZnqZycLadTuw25Hn8mBxJVCYu?=
 =?us-ascii?Q?4KCxfKtY4LbQXKH3lbKerlN9XWerVELdnMTO138G4dfLnH25yczbgJD9kIMw?=
 =?us-ascii?Q?JiGNearmbSpar+VvT69nOFmcLG66+qWIlk4BOWxtCdNdDxmnhXyDBjojfqvi?=
 =?us-ascii?Q?OV+DEUYhOSH1VmyX9IK/vGCa7v7tCKjO0/Xi1r4n+BJYqM0iuVBjmaVY9QrZ?=
 =?us-ascii?Q?maTK/yg4mIusBxIXa7w4JZGPyWRUevxI0jBrYUPMobd7KBM24SwVDvqkTUvt?=
 =?us-ascii?Q?1r3aSrgwz52dfmt0wtN7P7X6SXI2AV2TufhJcSSnAak0auFgE4rWBNEm4BD1?=
 =?us-ascii?Q?IhCH1fnXpc5yUXI5/j5rKINQPT7DkV3WgTgsN2NJX4Q1MmvRncBONVP5dXcE?=
 =?us-ascii?Q?72uU+D+z+yle7pcf30jbXt1ySQG/UEIpc4Aef+KpZutTnaghh7nyByvUKfVs?=
 =?us-ascii?Q?OZbyxKZ4IdGsaw7jAwr4NdXElikCyRhehjVCKE2/Tyqp07DIWZUv1OnCH4H2?=
 =?us-ascii?Q?colh1SH4y1vazGQFUsmv0pniV6C4yHw0f0Sy6wWRVST+1D8ADSemjN3w45kv?=
 =?us-ascii?Q?BxQLoHzX4+0WgUb2pBUTm9iq1/WUsHQ+EWN03bzk/sDRKQu1OzJax5oO5+BE?=
 =?us-ascii?Q?l8LkR9MnfEIMg47HuLPM5DAPd2swggmG87stgGYGe0kbVSwKSMEpy4X+4Vhg?=
 =?us-ascii?Q?+plpP1AxqfWP5sFi28j2oFJa7kJodgocxI+6qG9TL3Qz9diabwMkmiw/1l/2?=
 =?us-ascii?Q?VyZSXeXvdhYNCwVP3BQtXsvjmJZizDbNDOV/g7Rc6DiKEU/VCBRFgm4a8NNd?=
 =?us-ascii?Q?s5n//pmo1IXPs+4LRbAVU3fS151iOSc2VKFImtqe62pyv4a4j88807F4z21a?=
 =?us-ascii?Q?a+sdBRcovDTMt0keGO6OXlfoGkkYdiHDer1GGnT19zE1BD2F/epdHPzzE6Ia?=
 =?us-ascii?Q?/cbdQrKbsZ6I4gs/bAtKGhKEiFdVwGl0YiHtjFrN9ag+XDzxxca5epIuY3OW?=
 =?us-ascii?Q?pNJLb30FCiw+XlXEph7Vsy7H5o8GBo1tmUUeZmLmAQVmpi0bjNnx9u6iZOmY?=
 =?us-ascii?Q?IFeCBlFpRCMQE5uaFiR2FTQ779Sf8nhiCXgr7Wq8xD4EWtvMwueaaAJiRQPl?=
 =?us-ascii?Q?V3XVDtfVFTO/75efddvUr3Xl2MYmFbWoyGxt4J5LCx20rU62dOhmMY8Lj7h4?=
 =?us-ascii?Q?5szON3e9YVtAQZNgM17hxBJRJiaR3DIwyJf8dElBKLZtJKaR6muWGCkgnuMG?=
 =?us-ascii?Q?/Bu5bZiMKxl4XIkkdTxxY37NMfsExnGKjZZ17cPWodrovCaMMlodTm0wv0iY?=
 =?us-ascii?Q?y1iKnvJaR+X6P7gcMaFUuB51wJRkgs84jLCnHylatsG7MC9Wy1RFmQZHqnWK?=
 =?us-ascii?Q?kbRPisqU9W/cI+x3pvzIQTpNsvp5ltxoM6RELfssyn8I8mj18O1oSHEjTZo0?=
 =?us-ascii?Q?jrSN21BnSj0oiZv0nANsJs5v7OFUOHoI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 15:27:45.0939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a209afe5-1862-4b4d-dc24-08dca1be0363
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137

From: Amit Cohen <amcohen@nvidia.com>

Lately, an additional locking was added by commit c0a40097f0bc
("drivers: core: synchronize really_probe() and dev_uevent()"). The
locking protects dev_uevent() calling. This function is used to send
messages from the kernel to user space. Uevent messages notify user space
about changes in device states, such as when a device is added, removed,
or changed. These messages are used by udev (or other similar user-space
tools) to apply device-specific rules.

After reloading devlink instance, udev events should be processed. This
locking causes a short delay of udev events handling.

One example for useful udev rule is renaming ports. 'forwading.config'
can be configured to use names after udev rules are applied. Some tests run
devlink_reload() and immediately use the updated names. This worked before
the above mentioned commit was pushed, but now the delay of uevent messages
causes that devlink_reload() returns before udev events are handled and
tests fail.

Adjust devlink_reload() to not assume that udev events are already
processed when devlink reload is done, instead, wait for udev events to
ensure they are processed before returning from the function.

Without this patch:
TESTS='rif_mac_profile' ./resource_scale.sh
TEST: 'rif_mac_profile' 4                                           [ OK ]
sysctl: cannot stat /proc/sys/net/ipv6/conf/swp1/disable_ipv6: No such file or directory
sysctl: cannot stat /proc/sys/net/ipv6/conf/swp1/disable_ipv6: No such file or directory
sysctl: cannot stat /proc/sys/net/ipv6/conf/swp2/disable_ipv6: No such file or directory
sysctl: cannot stat /proc/sys/net/ipv6/conf/swp2/disable_ipv6: No such file or directory
Cannot find device "swp1"
Cannot find device "swp2"
TEST: setup_wait_dev (: Interface swp1 does not come up.) [FAIL]

With this patch:
$ TESTS='rif_mac_profile' ./resource_scale.sh
TEST: 'rif_mac_profile' 4                                           [ OK ]
TEST: 'rif_mac_profile' overflow 5                                  [ OK ]

This is relevant not only for this test.

Fixes: bc7cbb1e9f4c ("selftests: forwarding: Add devlink_lib.sh")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/devlink_lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/devlink_lib.sh b/tools/testing/selftests/net/forwarding/devlink_lib.sh
index f1de525cfa55..62a05bca1e82 100644
--- a/tools/testing/selftests/net/forwarding/devlink_lib.sh
+++ b/tools/testing/selftests/net/forwarding/devlink_lib.sh
@@ -122,6 +122,8 @@ devlink_reload()
 	still_pending=$(devlink resource show "$DEVLINK_DEV" | \
 			grep -c "size_new")
 	check_err $still_pending "Failed reload - There are still unset sizes"
+
+	udevadm settle
 }
 
 declare -A DEVLINK_ORIG
-- 
2.45.0


