Return-Path: <netdev+bounces-63971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A6183091A
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894371F2660C
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174F20DD9;
	Wed, 17 Jan 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CrohZNxs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA1200D8
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503928; cv=fail; b=VQDWN+qpS++1U1umcKXeaQNAruJEg4raNBK8wR8Pe4K+VmbeAuYSFEhYorUIX+8hA8aU5ZY0jMIfYs0G5id6dJvUhiTNQh9qyhjpzYeVlzeFXiAqc0j45vLGQT4OjXAtRqZw7qxcTdQBodME/K4vYtUNC0fiv4DLnVFH6ykWMgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503928; c=relaxed/simple;
	bh=fWAzbOYNP/ePVGd9P+4tw7/VsaAHnb87ZKuAIB1YuU0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=dVFcM1hYDJmuZN/4WD4lKdVi2s+QMHvzfYxyXedZlebnZ6+MnkTqwWagEXioWLNjD23PN/ZSA3eITSO6lVn6K10/lFwBz/Zv4cwm5qep+joKwRuSeHJjZdyggZkghuq7JBAFzMsG2cQJPUWBPImAm31+Er75WOs8dw3rQzyN4VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CrohZNxs; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/1OgdBUWm//3wzlQN0RfGmU9tpdOOVQvVRf9e3SCf2Yj8n46HZfcnLv4UGr1/ky45Y66DWnsqIF7TLEXUUrOd/5saX79os4HDh3JUkWjRiE2U14hnkEL2LuODf45cy+BrW7GHsTN7sxRRYsetnguHKhD8OiwsJ/MM2KFrTcPg9TbllXY4x9W/7XBDL2zAqgqTc9UdeOkHlLFL0WELfwuLVDdI+u0jIqZnzC+Yy1u6WYmd4UDMdxWVDEU2IYqHxKtIxc+e5scV0tilYeYFk9HLYxp4bXXRMQdMM5TIy1r6RQwNo5fopOW0suMqIeuGViLtRGOfimyoh6tjcFyNxTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/Gmm/Te6GfTLmfEqfHD9GC68uqHWmTqyK6LYoVJzdY=;
 b=DbHr7rxEGJZ/BMJa60vxsX2hFoiWz/e7GZCRwctBogRnfeqhMv79/Yx5Il7aMn6vc7hO0N3wwQ3D87IFtTro0mDzWl92zjAvNJiGZ2FT1u2jCZcmOF5OSnfCCmaW5USO5NZy8CsLdxza6JjWDEZiCwUs3bTw5fE0dQw9XqsrZI4lsjAf8etZqdgqOUQOxxkJ1mL+yBSX6TcZ8MS0QXpBY/FqlR9qR7G93remUVF/2zIYss7Dt653gNuuoHK28Su5cyJKNZJJQQhdcZt60spSgAsnK3ZXDHOAO/1dWUqs59mIVr90bWrUwmVP2OyRaTCXj9NFyF8Y0Zq4qAj6bOO3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/Gmm/Te6GfTLmfEqfHD9GC68uqHWmTqyK6LYoVJzdY=;
 b=CrohZNxsw2sFmYGMaVviwv7CGUybI9l5c96+gb81CMmefohpJVTKy/9E2dcIQJPH2SEUjisTBGTaQ3P+g+DzGMNz14Xr5lnKX9DogdR5/+p2/EXCJbObwFl8HW+BsLa06ngOJO3pmuc3IBaR/eLF+O4QBvQMDYTyT1eBpAjMlN64u3DZPF/VtHOZ2vgxNPwRlX/sEDFZLYGYXKiGLQ+hW4wl+o4HcA3L0IGVBrUZqTm62YyRYspf+FYXsJDLylUv4AE9EdAjasaRqXR0vmseht4A7cVZysWpEpAMs9XaX9VWgSxChLkTi3T1t1XGDz4n1OAI9wk/Zj6H8928J+Wk4w==
Received: from DM6PR07CA0115.namprd07.prod.outlook.com (2603:10b6:5:330::6) by
 SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 15:05:23 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::23) by DM6PR07CA0115.outlook.office365.com
 (2603:10b6:5:330::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Wed, 17 Jan 2024 15:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 15:05:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 07:05:04 -0800
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 07:05:00 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	"Jiri Pirko" <jiri@resnulli.us>, <mlxsw@nvidia.com>, Orel Hagag
	<orelh@nvidia.com>
Subject: [PATCH net 3/6] mlxsw: spectrum_acl_tcam: Fix stack corruption
Date: Wed, 17 Jan 2024 16:04:18 +0100
Message-ID: <2d91c89afba59c22587b444994ae419dbea8d876.1705502064.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705502064.git.petrm@nvidia.com>
References: <cover.1705502064.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: a27e7d69-49cb-409b-b2c9-08dc176dbae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EFLjU/UHyNybGge+2hHE1CuVH3UbhoPEw1dxxtraH0LKAR0lzt8EYh2W3798t9MB2BNxXzW0kv8v3Uez6evHjLAnAiJ0/Rbs6gjELr8lPNQBGerN4iQxLLzfm0fUG7zkbv9tamMQO9nstsBPB4jeCmA2RAiPqfEZY9NAJiHMFz4rDuaZyTzCqwzK5y45DQBqZ5NpyRhlhd7wiDJCMCtaeutByFBsnMui1s+Sr8w51Yem7XIAHstvhSqRjtmfeULVojjOhdb4DNJC8swGZthfhn/2aYEUmxQ+GDjNfW0Ws2++Ak6yZtJ/TLQlZwdG1dsaro4sJ43bRQvFH88zv0GzL96n+p9IKCQWHwdaO/aQbiXqu7oKWU6TJTD+gZCw/QlvRbDANoT1WwhXqs/yFK31GfbNXbyiGKtw7oihcz1VJ+Cj31uErus97zu5kDJbhxLVrofw2ki1qtYENYQw8kMGKPePKR0nyIyEOfaEUK7+11NFd9ol093kcbzyr3+WgjPv1nTnl7i6a2KzFzK+bqAbcZo1GC0L04UGktopdOoatYflg+VD/M9B9RftPIhxNbt9f8C0UG5l9yHXPQk+G0YRO5MmNc848CBMNr7rJer5nl+BSCWdK/OYGoWszZs2prRmRZtpfJvC2dCC80vo2ievqc/Z/j/vCzwI2EmYa4CDwcnlG3/sr1FxM5Chtt+RnowAbKBkLDXSSe7LQ3b12NLs6RKIohfDpTnr9tWQm27Lc2sCKpVtKw3+OOcApoh+BKZk
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(26005)(6666004)(7696005)(107886003)(336012)(36860700001)(426003)(16526019)(2616005)(36756003)(86362001)(356005)(82740400003)(7636003)(8936002)(2906002)(41300700001)(4326008)(83380400001)(47076005)(5660300002)(316002)(478600001)(70586007)(8676002)(110136005)(70206006)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:05:23.3163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27e7d69-49cb-409b-b2c9-08dc176dbae5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

From: Ido Schimmel <idosch@nvidia.com>

When tc filters are first added to a net device, the corresponding local
port gets bound to an ACL group in the device. The group contains a list
of ACLs. In turn, each ACL points to a different TCAM region where the
filters are stored. During forwarding, the ACLs are sequentially
evaluated until a match is found.

One reason to place filters in different regions is when they are added
with decreasing priorities and in an alternating order so that two
consecutive filters can never fit in the same region because of their
key usage.

In Spectrum-2 and newer ASICs the firmware started to report that the
maximum number of ACLs in a group is more than 16, but the layout of the
register that configures ACL groups (PAGT) was not updated to account
for that. It is therefore possible to hit stack corruption [1] in the
rare case where more than 16 ACLs in a group are required.

Fix by limiting the maximum ACL group size to the minimum between what
the firmware reports and the maximum ACLs that fit in the PAGT register.

Add a test case to make sure the machine does not crash when this
condition is hit.

[1]
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: mlxsw_sp_acl_tcam_group_update+0x116/0x120
[...]
 dump_stack_lvl+0x36/0x50
 panic+0x305/0x330
 __stack_chk_fail+0x15/0x20
 mlxsw_sp_acl_tcam_group_update+0x116/0x120
 mlxsw_sp_acl_tcam_group_region_attach+0x69/0x110
 mlxsw_sp_acl_tcam_vchunk_get+0x492/0xa20
 mlxsw_sp_acl_tcam_ventry_add+0x25/0xe0
 mlxsw_sp_acl_rule_add+0x47/0x240
 mlxsw_sp_flower_replace+0x1a9/0x1d0
 tc_setup_cb_add+0xdc/0x1c0
 fl_hw_replace_filter+0x146/0x1f0
 fl_change+0xc17/0x1360
 tc_new_tfilter+0x472/0xb90
 rtnetlink_rcv_msg+0x313/0x3b0
 netlink_rcv_skb+0x58/0x100
 netlink_unicast+0x244/0x390
 netlink_sendmsg+0x1e4/0x440
 ____sys_sendmsg+0x164/0x260
 ___sys_sendmsg+0x9a/0xe0
 __sys_sendmsg+0x7a/0xc0
 do_syscall_64+0x40/0xe0
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fixes: c3ab435466d5 ("mlxsw: spectrum: Extend to support Spectrum-2 ASIC")
Reported-by: Orel Hagag <orelh@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/spectrum_acl_tcam.c        |  2 +
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh | 56 ++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 7d1e91196e94..50ea1eff02b2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1564,6 +1564,8 @@ int mlxsw_sp_acl_tcam_init(struct mlxsw_sp *mlxsw_sp,
 	tcam->max_groups = max_groups;
 	tcam->max_group_size = MLXSW_CORE_RES_GET(mlxsw_sp->core,
 						  ACL_MAX_GROUP_SIZE);
+	tcam->max_group_size = min_t(unsigned int, tcam->max_group_size,
+				     MLXSW_REG_PAGT_ACL_MAX_NUM);
 
 	err = ops->init(mlxsw_sp, tcam->priv, tcam);
 	if (err)
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
index 7bf56ea161e3..616d3581419c 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
@@ -11,7 +11,7 @@ ALL_TESTS="single_mask_test identical_filters_test two_masks_test \
 	multiple_masks_test ctcam_edge_cases_test delta_simple_test \
 	delta_two_masks_one_key_test delta_simple_rehash_test \
 	bloom_simple_test bloom_complex_test bloom_delta_test \
-	max_erp_entries_test"
+	max_erp_entries_test max_group_size_test"
 NUM_NETIFS=2
 source $lib_dir/lib.sh
 source $lib_dir/tc_common.sh
@@ -1033,6 +1033,60 @@ max_erp_entries_test()
 		"max chain $chain_failed, mask $mask_failed"
 }
 
+max_group_size_test()
+{
+	# The number of ACLs in an ACL group is limited. Once the maximum
+	# number of ACLs has been reached, filters cannot be added. This test
+	# verifies that when this limit is reached, insertion fails without
+	# crashing.
+
+	RET=0
+
+	local num_acls=32
+	local max_size
+	local ret
+
+	if [[ "$tcflags" != "skip_sw" ]]; then
+		return 0;
+	fi
+
+	for ((i=1; i < $num_acls; i++)); do
+		if [[ $(( i % 2 )) == 1 ]]; then
+			tc filter add dev $h2 ingress pref $i proto ipv4 \
+				flower $tcflags dst_ip 198.51.100.1/32 \
+				ip_proto tcp tcp_flags 0x01/0x01 \
+				action drop &> /dev/null
+		else
+			tc filter add dev $h2 ingress pref $i proto ipv6 \
+				flower $tcflags dst_ip 2001:db8:1::1/128 \
+				action drop &> /dev/null
+		fi
+
+		ret=$?
+		[[ $ret -ne 0 ]] && max_size=$((i - 1)) && break
+	done
+
+	# We expect to exceed the maximum number of ACLs in a group, so that
+	# insertion eventually fails. Otherwise, the test should be adjusted to
+	# add more filters.
+	check_fail $ret "expected to exceed number of ACLs in a group"
+
+	for ((; i >= 1; i--)); do
+		if [[ $(( i % 2 )) == 1 ]]; then
+			tc filter del dev $h2 ingress pref $i proto ipv4 \
+				flower $tcflags dst_ip 198.51.100.1/32 \
+				ip_proto tcp tcp_flags 0x01/0x01 \
+				action drop &> /dev/null
+		else
+			tc filter del dev $h2 ingress pref $i proto ipv6 \
+				flower $tcflags dst_ip 2001:db8:1::1/128 \
+				action drop &> /dev/null
+		fi
+	done
+
+	log_test "max ACL group size test ($tcflags). max size $max_size"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.42.0


