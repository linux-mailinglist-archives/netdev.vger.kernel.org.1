Return-Path: <netdev+bounces-162604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15733A274F5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962CA16488B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9DD214222;
	Tue,  4 Feb 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n5IHCWD4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5259211A16
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681026; cv=fail; b=S1EjKV+rjUXW1qzMhAdlk/Ug+6bLKlbQcC4EcGGL2DrMAXxB7ktprz3f5+tnne7LTqMznMym0mTmwYdpd+UqGJaaGSnG+vT6yP5PDDN+nrIoXXS14cuoYRH9d9o1E3F67jZjXTsvN4iahvElX3CXOeZeMDmXm/ulFSWy13DJPF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681026; c=relaxed/simple;
	bh=0d/XLhbYDSaLe/oPGbRomaXCVF/KuN1myMUZWQ++hpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKefRNTqbmw6B8dQNMANVCMNTjGnn7qoBMHhRr6O0LFmUidge52PzJBwgK+7z7haf7GEgCbaPOXafAWBwGFEzXc3jRWy+0FIr4C06Msk5ue8zEk4LoTs4bMjJUxiSQ2EvLCFEktH+wAbAxR12Esm72nr05dSdc2BDep4dgXVpow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n5IHCWD4; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4A10QGqjL8eCTxi78tp1PMDrWYAA6YTu0u2mmkp1tlKjuebW9tfxmD4Yg0Dj7vx4oudFgFN6rIOM8Yq20Vd/xACmneKGQgw/0hbTrZAsgX1Od4J/QAVUIpTwK1uVn4GZpVS5ZwIGG8t5VmQmPaJx//8mkdhG3tFr/oYHc/kdsAQdA+jPhheDLm/0x4ClrVWPOPM0h1kf+761oH0YEdlmppM1rzjGH9y8fel0jNRo6aiQwIE+67YxQ/TcpzVfziSYvqalUzxQziq5GxkqCLTG7jz397azaBN4hiVB4j583LNpiR/toYaF45C7gJ7M0IjZq3+Ux32fE+foP7ABh/1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01Eon5LHyZp8ZaG1LM+1QBo98PH+JJ75bve/oHIJoss=;
 b=nd+/I0wEKTmUnYofyj4PcX1ATYto0UMnm/D47NJmg5xu3yrfgCT56/If5LSqqEYGmCRbTpTYX8fvmS8COJrL8vR+PoHCFClLm7e43QA8kMd3V5t5sCqf8jiWGRMtmYprIouoWXqtkPMiAB4J+r209njqoCyDfxmTkjUHPadbyVoV8d3agkGQib70klMsnRQGUSpaFJM9ag6AmZGq1sEk0GWIKnu+dxDMHJPI+lY8cZJTRorXf4CvsVjDvnGaxARd+2tDVVQCvvep4zRIjfA7R2tZS11tHH9UMf1lPFzX2Xw3WQt3wzN+95CwxXWlod+dfaaNU2JXG2pHOK3+Lj94xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01Eon5LHyZp8ZaG1LM+1QBo98PH+JJ75bve/oHIJoss=;
 b=n5IHCWD4QDhW+47LywbbKkpGDQKyvyl0XLdchilgMBEXWiH/rOprseHoNomgWkFcGCVVbXX9/FFsNWOLHeKFQIeFK74FVVfRl1bzMCNaSQbGrFfTCD98KbqoiedvLvaKwIfwZLX4lOMbMUOkLKfZXo5Zte4Nb/F2hfF85db0J00yWQxKz4EL6+y3EjyUIYfO6Yh4/nVOS453N5LZeDCL+Eqx4ZTx5ubjCY6tsua3/xkRVPH02sKpzFuFdonHYTAA3syrtpyAsxOuDpesQZjTbavoQfYx6aElY9JVAPnuTHB3DqI4ASnxKjN2HLk7xf4Qux1hl0EVOOHI2igPlz2g3g==
Received: from BN0PR02CA0035.namprd02.prod.outlook.com (2603:10b6:408:e5::10)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 14:57:01 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::38) by BN0PR02CA0035.outlook.office365.com
 (2603:10b6:408:e5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Tue,
 4 Feb 2025 14:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Tue, 4 Feb 2025 14:57:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 06:56:41 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 06:56:38 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 8/8] selftests: forwarding: vxlan_bridge_1d: Check aging while forwarding
Date: Tue, 4 Feb 2025 16:55:49 +0200
Message-ID: <20250204145549.1216254-9-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204145549.1216254-1-idosch@nvidia.com>
References: <20250204145549.1216254-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 6340268a-6680-43e8-4435-08dd452c2da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MMxvAz2XpR8JEeXWEOy+fbzvr1mDze9gtgBEV43QcTnPhJq8teGcbI94f3Gk?=
 =?us-ascii?Q?FAtvrW7zA4rtasoh0NNUjVSafV60ii9XpKmLn9Q7q0MwP0fKP3RUaZlhiO5t?=
 =?us-ascii?Q?SJR6lrY04tMVp9YRcT8q2bSiGfs8KlYAtE8mAU9Y9Arc8aFJgkxH9KTyhq9n?=
 =?us-ascii?Q?dDj0xjvTvMHpSZGOYlC2OO5JdIlrJviZZeNijpl+aKjo9UaunEmGMtqCUoWV?=
 =?us-ascii?Q?avSBEb/T/DNShCO103rXk5hkvhaLspQ+BOs2MC4Sr9Y7pRNQVQcuSB75F4lu?=
 =?us-ascii?Q?q9LQy5jPqpIavwz4n0uRy1mI0C6szo2U8hluGU9QbZD+H//ch0ycioKOxdGh?=
 =?us-ascii?Q?G1yS+rRxp1nozBttNh1Fz+eE2hiIvhuH/UrK2xqwvHsPjjA4JGbQsVF8u2t7?=
 =?us-ascii?Q?4p6WKbWEC0ER8KpIBWLeSASatKGbw7WHNr86Qg+EslaTJ6XmOBlrjsjKjoN0?=
 =?us-ascii?Q?NqgMPs73DD5YIlu/ipAsq37BblfVwwAG7pXVs3d7dGNM7ctyZ2vYt3RomT29?=
 =?us-ascii?Q?DGBR1ZlL+uEhA8EtdVblUD9X8h5LKIpThMWtNYLtopqoTLFnBIAcopvfBVt4?=
 =?us-ascii?Q?wb3142YkEffm5ljnR96yoLAf/jzza3m0PMxGMxBYfwWOP48rzVU53gPIDmw8?=
 =?us-ascii?Q?IBoCu1mEurjEiUvIHWeOq0ma5habgE5xrFSCtUcJD/STP8fq5NezipdlEeXt?=
 =?us-ascii?Q?Jg17xOCFRontlIZfxXvcbyM51s24KRNEE4jYrcmsgY2CSwKE9scg4FGgnQ/t?=
 =?us-ascii?Q?QAkQvMDZceuvdnMTJvDM4t3+pc+k83DpIFaISu7eaDj7LEzD/mwhptSGcUfo?=
 =?us-ascii?Q?XyCk8D2aQDFR18xXSay3a0EaFqiqqUVCQe9CdJGE3m+SPfXfqoZW54rGnbCA?=
 =?us-ascii?Q?wndnve5j38WGTpeDRzCnC9NTClVD9+YxOWBBtIUSOD1aK7RkW9+zqfmqFttM?=
 =?us-ascii?Q?y0Fc/Q9fwdFlMQAkuYKwM492c0+m1s9U7KOp897+X4j+qWy2PyOq0fY7mnog?=
 =?us-ascii?Q?2Z4986mbIXp/8731EzX1KwOs/h2JjYqH7IBkkm0tWOmukXuc926ZSsViCoaI?=
 =?us-ascii?Q?aOMOVWhCcTjXdtlCPb8W6cn5Ncwq6wEKJaPeUHu0YcHieE9vSi5TcuyUoEiC?=
 =?us-ascii?Q?rdSEz6++ZNL2NLBrYdL2ImSflRXbGCKLi6eD+DmdWCMKN2YhqmyOuj5abUu+?=
 =?us-ascii?Q?2d1H+vqlrX4/QxmnJUphuesjq7bR3AEjVo2yD+tv6a0JEf2lE4O4qNkVS++a?=
 =?us-ascii?Q?32gOV8Z9p2mp9dYpb9SvrDo+h40d01k5c5haSuYHIIaerMESmYwWyb78uHAN?=
 =?us-ascii?Q?8Mv25rS1sAkVd/++rZHC88s0ioo1Ss4VzZGrBIIJr6/rclyo3XSC0qOHKeIG?=
 =?us-ascii?Q?0TESskKW50GJHcGtQTY4r3Iw2HKpP00+4/IFeGGwQGBF4gKvhF0HsRQBU9Mz?=
 =?us-ascii?Q?Mk7Yt9jEbauIt/w1OvtfQyyUxchKlYXebF7WYFBlgUgvN+7yq5ssV8uMhx4s?=
 =?us-ascii?Q?9lxLaHeFm3fK2gc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:57:00.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6340268a-6680-43e8-4435-08dd452c2da9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927

Extend the VXLAN FDB aging test case to verify that FDB entries are aged
out when they only forward traffic and not refreshed by received
traffic.

The test fails before "vxlan: Age out FDB entries based on 'updated'
time":

 # ./vxlan_bridge_1d.sh
 [...]
 TEST: VXLAN: Ageing of learned FDB entry                            [FAIL]
 [...]
 # echo $?
 1

And passes after it:

 # ./vxlan_bridge_1d.sh
 [...]
 TEST: VXLAN: Ageing of learned FDB entry                            [ OK ]
 [...]
 # echo $?
 0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
index 3f9d50f1ef9e..180c5eca556f 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
@@ -740,6 +740,8 @@ test_learning()
 
 	vxlan_flood_test $mac $dst 0 10 0
 
+	# The entry should age out when it only forwards traffic
+	$MZ $h1 -c 50 -d 1sec -p 64 -b $mac -B $dst -t icmp -q &
 	sleep 60
 
 	bridge fdb show brport vx1 | grep $mac | grep -q self
-- 
2.48.1


