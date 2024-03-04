Return-Path: <netdev+bounces-77034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FCA86FE2A
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804381F20C20
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7F7225CF;
	Mon,  4 Mar 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gORiLPAm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD08241E3
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546236; cv=fail; b=Fs+PjBNuqSa4SjvYtSw2QT+uuvNK4dt+3vqvFUlusSI5cJkli57/Vd05zJ4zyaeJeNQ0Pq8SoS5UElFniHHOlyG2tNZwPI/Pgw00j7qlcRB1LeGabUd2A2ghqGbwwSCb9Q+bbnO0/XTwxaGeZQ0y3kuUbbYhgfGvxdA/BLXBkkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546236; c=relaxed/simple;
	bh=tVm/2ZNtftrRvGvCOgsu0fhaD3aNYW+JrnH7gLCLna0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmtAtCQAgGn62R+eEwOWYqOAnrosGz7fm/dMphPC8ZoysbP0k6+9SmQlv9Aa6yHaiRD+yNHdGjxIcnYth+2aFiMWi1umPPBhug+NK8vXngUUlk6I0gJ5f3ZdxePf6L536UI/NyQ8V7fTlaSHFjmllXfp3KvBnC5foyEuIXjSaIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gORiLPAm; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6X56cuh8wQ87gJxuknFaGdIxVLEqa9dv/xzDW2YNL3RXG0KNiDsVyrzUOgTYQBhHh80BdQ/qCvjUrZFLLi2ABZeukcAgO9v4cNeyzX7jxRlrK7To89Y9HHr1AaZN2Ri6Qw08yl2gsdpucUFMhzNNtPULTWTkoQwRDl/ToX28VSencO7dQtFJCoMLSEwcqGWL72NLEQ70P6WLG2uQkZiLdVooBFJnDnVzzgBLqM/c3hAG6l8OijmkMamcGx3zzcpuQNDcSZKKbC2n4b6JgsYGvomzVn5V+eJJuVBdpno9VArEzqjMoHznf3r24zNH4yxs/F+wg5L7KTzgj1tFfuszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrOto6UWLkvqUYmGweY3EAzUe1HWWEfIi+/Ntd9ynDc=;
 b=hdKZg4b/Q314rfQjfume7VszlvoPX+ylBLIK8QkRL3f32aU0m5h/Oo7mKjExPHn1ODB1CGxAV1q7D9dm9PY8YlmgqcYlNYSw/2LX7Co4lZKE/ULveyawx8LfqG9QfRpBd8Bcgno5Ye6H4GHEjtyaM/ZfkLyiyhB/WJ+1EPiHEupvOdEOfDebr66jJN3xINulvOlQ0I67GxFnOXeWB6HY4P/w0x0831nRoEps1t8RjEDLcJPf0hHJu6PcaspDUZ3AGNhr86j9CzkcmBygdiAqqRJvzIJqyG7HVllTLSj5tFcxTfBNfs1CxHvtlelKT7dn93e/pTnonPafhCKBeAHr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrOto6UWLkvqUYmGweY3EAzUe1HWWEfIi+/Ntd9ynDc=;
 b=gORiLPAmRu/lHIsD3YTFwLNn1vR8/lVZnIGuyoAEupAgchGLVTyraMJTHOzpytZ0mqU4nwUQFhmpQzN54iSCM9B6MHy9WGVltJYF0wwcZtH0iw/SUT2QcYl27OrffhbBLuBxEaAXaJ9G++Uf7YHw4b6q6yc+5KRF/VuIEOF8jR4m7qW9Pw9XoY8ESuPgeXBguJLy0qx9EwpRumCHiZMrR20ZsdPJnJjD+CnRhUPuzXGHvsy6p05uM8mOXVXHcT7FSlLvRla+JCIJ0cfosiwqxVicZBkA6302lGsbW/btCXkAt2v00H0/Tcbm7AWzHxWkxn1cj8kpxvIL/122XiQzfg==
Received: from CH0P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::13)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 09:57:09 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::3a) by CH0P221CA0031.outlook.office365.com
 (2603:10b6:610:11d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 09:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 09:57:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 01:56:55 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 4 Mar 2024 01:56:52 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <bpoirier@nvidia.com>,
	<shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/6] selftests: forwarding: Make vxlan-bridge-1q pass on debug kernels
Date: Mon, 4 Mar 2024 11:56:10 +0200
Message-ID: <20240304095612.462900-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304095612.462900-1-idosch@nvidia.com>
References: <20240304095612.462900-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: c1104468-db8d-42c7-d6f3-08dc3c317529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SCivlI8bg4xsZ2jtpzGRxHKo9HJkr0c+KTkGixgvl+pXvxb0zy2FB9hNn2D7A5+6IMQQ99gNjAv6MDdJbb/092YtTAXtdqF8su/1aShNsBSD/VLXWwYjoVH8TNpvnCfmjtVpCIfzsRWwM/S8wFVyaxpp6r0RIFYzStE6ynJCG264I46y3QINK3CTb726BI+LjDjMJ/s77k6sPQmNVrxZJgyGrzxcdnBmHxtD9i49MMCtr+On1ExMPnreSh+r6neb0XO2zOEc8SFf832/XXqJzUJtuYZFn3try83GEFZsSqzedzH5oKu9uVK7zlvI0daav5K6Qq0BsVKB3Bs2uWV96mPI6qlgpLhN/eAkf2lW6l75B0aIwC13Vc30fx3symrB9tuaSGSW8L3fj0N+ttgvyADf38tnfXLAC9aHQ20wGjb6e39Oq1cn9BkHqrkJqmpTPmQuTCW0hcEhcr+rlOoFh7IAH05u3CS9UTncTIJnnsdO8iLpxmsxnbpDSui64T2kyRlKyQ+SESi5nfVJwz4SALVRFx5HwBKOX5ueGTvPR2wFB3FU27R1lPEi5USaEAqnjdQkg3G7zbw/UIJbeRPhxzQlsXmP5ANXMfNkJA73rm9NSgG0PJi7jUbL7usOpBLWE1Df4/vlEXxOCSiFxsKM65wkCEKyo6L59dTkTDoDvhVH2KouA1i3nNDrWzoD5v+waGy2z+ySEx0hn/HnUrGD1vXbsifF4LLULNltP6I78914oRinFvOVjSstGMyiz3/Q
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:57:09.4945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1104468-db8d-42c7-d6f3-08dc3c317529
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281

The ageing time used by the test is too short for debug kernels and
results in entries being aged out prematurely [1].

Fix by increasing the ageing time.

[1]
 # ./vxlan_bridge_1q.sh
 [...]
 INFO: learning vlan 10
 TEST: VXLAN: flood before learning                                  [ OK ]
 TEST: VXLAN: show learned FDB entry                                 [ OK ]
 TEST: VXLAN: learned FDB entry                                      [FAIL]
         swp4: Expected to capture 0 packets, got 10.
 RTNETLINK answers: No such file or directory
 TEST: VXLAN: deletion of learned FDB entry                          [ OK ]
 TEST: VXLAN: Ageing of learned FDB entry                            [FAIL]
         swp4: Expected to capture 0 packets, got 10.
 TEST: VXLAN: learning toggling on bridge port                       [ OK ]
 [...]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/net/forwarding/vxlan_bridge_1q.sh        | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
index a596bbf3ed6a..fb9a34cb50c6 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q.sh
@@ -750,7 +750,7 @@ __test_learning()
 	expects[0]=0; expects[$idx1]=10; expects[$idx2]=0
 	vxlan_flood_test $mac $dst $vid "${expects[@]}"
 
-	sleep 20
+	sleep 60
 
 	bridge fdb show brport $vx | grep $mac | grep -q self
 	check_fail $?
@@ -796,11 +796,11 @@ test_learning()
 	local dst=192.0.2.100
 	local vid=10
 
-	# Enable learning on the VxLAN devices and set ageing time to 10 seconds
-	ip link set dev br1 type bridge ageing_time 1000
-	ip link set dev vx10 type vxlan ageing 10
+	# Enable learning on the VxLAN devices and set ageing time to 30 seconds
+	ip link set dev br1 type bridge ageing_time 3000
+	ip link set dev vx10 type vxlan ageing 30
 	ip link set dev vx10 type vxlan learning
-	ip link set dev vx20 type vxlan ageing 10
+	ip link set dev vx20 type vxlan ageing 30
 	ip link set dev vx20 type vxlan learning
 	reapply_config
 
-- 
2.43.0


