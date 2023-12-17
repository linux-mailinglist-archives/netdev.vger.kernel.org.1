Return-Path: <netdev+bounces-58332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128C3815E39
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDE6283E21
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0BD2119;
	Sun, 17 Dec 2023 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTbZe7bW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE72C5678
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE/Qx0EGirbeO6Dufo6pFvodZM6CKEQBmxIH4oDGf+2R3yubMiAbTxDjJKCYIpBGugaP9ayHkC+uh+Gl33CUMKZvzyrueI7vI1N+FgBcmr4w5VWJuZLFM2j2iMHaHK/ci66WRjLVQz75XP8FU4xpwoI3vCGqe3Sk5jNr5zPD6VHVNd+chkSzIZCBfBzxlHR+XMVQc5RwWeNuZwp4E7VY5/HBJXmvBqwnHcrTO3FnWcHOAtjuvTWWzSVS27PpxNH6ezYYRpLQeiJ15LcB/spTs/tyuvV7ODNhTVFDza+lvhRGW1TyGDDZTx/AtK66WttFfC4y1q6H2YY7f44HB4oG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RHEFupak+/qCGi7lXq7RFSz3R/EfnnGvXfbxFY0q2Y=;
 b=YOIoiOkKAyJjub1wHFskp/HlWKw0ycVrsCF1KUvGwd6JSkRqtQvNnTcX9lfnFsJVmBwJduWtsBOv3HJsXoN55AN2S7ZhwIWHoAH11gsl4oRBtNsau7NAIe54dF1W8vGCU8jDDbdIPxhvy92Vta6xPktWgHKzV/ILtg7MIZSJYBg2qj/EUJdfnyBbIaKYi0SEGPz3KvFCmpjQNu1jeQB+MAjweOyHnmy297ipnFFJB6o2BwTRhW4YWDT2TM4Qyi1/LvZQaLNrftLmUj+c4TPrWfmAqyuSY9zSBQ+Po0CqHEaIGor0ZYOknfs2vq6CQSBoadep593Rvt1jU9H6/CsC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RHEFupak+/qCGi7lXq7RFSz3R/EfnnGvXfbxFY0q2Y=;
 b=fTbZe7bWX63P/b7jqfC75F8pqO3SG9xYDg67Iy7Mr7Vey5h7CVMbjlDwHRpGHEqgoNV9s2bUMso9bndljoIMtDuKdYOimLnzhkrkiTLgm/nl3AYtNGlRBuVn6oTmFrojYrUkVqPeVvdmLqF2L0qtbdqHjqsc3b+WPaa0JVui3c+mO9cXr1tuQsad82W6tQaSH+8jVCVwT7oj1xOuZTa6+Dh1DIhmvj2cyirCw30p5DN5mWYlv9dVYOkfvlwuIB3e/Q/U+aI+eQPGi/PK8YW5tYBosDXjJHwz9buubVlM8TgbUXh9P15lw8hrf7ifLsVG6kcAOOlP/pjBVZ3eNrtBiw==
Received: from BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 08:33:51 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::f0) by BLAPR03CA0105.outlook.office365.com
 (2603:10b6:208:32a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36 via Frontend
 Transport; Sun, 17 Dec 2023 08:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 08:33:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Dec
 2023 00:33:42 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 17 Dec 2023 00:33:39 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 8/9] selftests: bridge_mdb: Add MDB bulk deletion test
Date: Sun, 17 Dec 2023 10:32:43 +0200
Message-ID: <20231217083244.4076193-9-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217083244.4076193-1-idosch@nvidia.com>
References: <20231217083244.4076193-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 027243af-4cc6-46e7-15a7-08dbfedae5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tGAtdL99Rp6xHyh4WwQOQoUFkMBZmrCk7HWYROkPwtbyK1FivN4UYG+bQwwnMmqrVnm8yId1f/NbVDiWDynls4/0rNsJK+S9uSIBPYFG0F+PDVfzpU+ipOgl3sXwn/CtmWgRAZZ5JZLcqNsSKiMdnBpHqfEMt98/jIws0oqPMUna/ymkiDnJkAtq6FBlsO0zrVW4h/253ZlH8tOUlTIb50gLGL/HIwS5dqk6JgpWdCRQ4a8DbEUT39UMrjPE7jEiMOQMubymlyOlgnHQJINous4/ZgCQxURhqR7PO9qStWzP1oZvhb8C4huKANMMYBio2hUSxrWhi9feY+b6uTWKgvHhSmulXbHOB7PemXe2g541YsBHuPlR48cRXjuN0UzA6spOM5j2ORWTllmeDsqRRpDxlMKgJvjGAB7GqVaYb51rpvZm++Q8cfbxdu/TA5vLSw+p3RJYs8yfiQ5JIl35Z4gr8od6n35BesTyHa3yJb422KzpGJsli7P4m9tRPC3WqS0gjifqB+jP4dP5ZyTiz9PehVhQPXNW6RNGoSPMeM+rKjF2VzWERzzopnshhPrCrnHs5GI2/TaCQjSeRi1gKZljHKEA+sdDATWw4kiGu7R67Y47WEkL96xu6Y/eoI+ttLvSIZVuycHWF3iJYQw9xTB89R9NMbR6/lrNPx44WVqmkMVb1u/zDWKMqTz93zIV+VuofeyarPKcz/9/4wZRPUf36oOvoTUpIPKMREdZ9L22pvmHZXwCwJgwSDuswXK0
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(5660300002)(36860700001)(83380400001)(47076005)(86362001)(478600001)(356005)(7636003)(41300700001)(8936002)(8676002)(4326008)(70206006)(2616005)(70586007)(110136005)(82740400003)(54906003)(316002)(36756003)(107886003)(1076003)(336012)(426003)(2906002)(26005)(16526019)(6666004)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:33:51.2537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027243af-4cc6-46e7-15a7-08dbfedae5c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511

Add test cases to verify the behavior of the MDB bulk deletion
functionality in the bridge driver.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 191 +++++++++++++++++-
 1 file changed, 189 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index e4e3e9405056..61348f71728c 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -803,11 +803,198 @@ cfg_test_dump()
 	cfg_test_dump_common "L2" l2_grps_get
 }
 
+# Check flush functionality with different parameters.
+cfg_test_flush()
+{
+	local num_entries
+
+	# Add entries with different attributes and check that they are all
+	# flushed when the flush command is given with no parameters.
+
+	# Different port.
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10
+	bridge mdb add dev br0 port $swp2 grp 239.1.1.2 vid 10
+
+	# Different VLAN ID.
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.3 vid 10
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.4 vid 20
+
+	# Different routing protocol.
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.5 vid 10 proto bgp
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.6 vid 10 proto zebra
+
+	# Different state.
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.7 vid 10 permanent
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.8 vid 10 temp
+
+	bridge mdb flush dev br0
+	num_entries=$(bridge mdb show dev br0 | wc -l)
+	[[ $num_entries -eq 0 ]]
+	check_err $? 0 "Not all entries flushed after flush all"
+
+	# Check that when flushing by port only entries programmed with the
+	# specified port are flushed and the rest are not.
+
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10
+	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 10
+	bridge mdb add dev br0 port br0 grp 239.1.1.1 vid 10
+
+	bridge mdb flush dev br0 port $swp1
+
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
+	check_fail $? "Entry not flushed by specified port"
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
+	check_err $? "Entry flushed by wrong port"
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port br0"
+	check_err $? "Host entry flushed by wrong port"
+
+	bridge mdb flush dev br0 port br0
+
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port br0"
+	check_fail $? "Host entry not flushed by specified port"
+
+	bridge mdb flush dev br0
+
+	# Check that when flushing by VLAN ID only entries programmed with the
+	# specified VLAN ID are flushed and the rest are not.
+
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10
+	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 10
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 20
+	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 20
+
+	bridge mdb flush dev br0 vid 10
+
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
+	check_fail $? "Entry not flushed by specified VLAN ID"
+	bridge mdb get dev br0 grp 239.1.1.1 vid 20 &> /dev/null
+	check_err $? "Entry flushed by wrong VLAN ID"
+
+	bridge mdb flush dev br0
+
+	# Check that all permanent entries are flushed when "permanent" is
+	# specified and that temporary entries are not.
+
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 permanent vid 10
+	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 temp vid 10
+
+	bridge mdb flush dev br0 permanent
+
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
+	check_fail $? "Entry not flushed by \"permanent\" state"
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
+	check_err $? "Entry flushed by wrong state (\"permanent\")"
+
+	bridge mdb flush dev br0
+
+	# Check that all temporary entries are flushed when "nopermanent" is
+	# specified and that permanent entries are not.
+
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 permanent vid 10
+	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 temp vid 10
+
+	bridge mdb flush dev br0 nopermanent
+
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
+	check_err $? "Entry flushed by wrong state (\"nopermanent\")"
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
+	check_fail $? "Entry not flushed by \"nopermanent\" state"
+
+	bridge mdb flush dev br0
+
+	# Check that L2 host entries are not flushed when "nopermanent" is
+	# specified, but flushed when "permanent" is specified.
+
+	bridge mdb add dev br0 port br0 grp 01:02:03:04:05:06 permanent vid 10
+
+	bridge mdb flush dev br0 nopermanent
+
+	bridge mdb get dev br0 grp 01:02:03:04:05:06 vid 10 &> /dev/null
+	check_err $? "L2 host entry flushed by wrong state (\"nopermanent\")"
+
+	bridge mdb flush dev br0 permanent
+
+	bridge mdb get dev br0 grp 01:02:03:04:05:06 vid 10 &> /dev/null
+	check_fail $? "L2 host entry not flushed by \"permanent\" state"
+
+	bridge mdb flush dev br0
+
+	# Check that IPv4 host entries are not flushed when "permanent" is
+	# specified, but flushed when "nopermanent" is specified.
+
+	bridge mdb add dev br0 port br0 grp 239.1.1.1 temp vid 10
+
+	bridge mdb flush dev br0 permanent
+
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
+	check_err $? "IPv4 host entry flushed by wrong state (\"permanent\")"
+
+	bridge mdb flush dev br0 nopermanent
+
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
+	check_fail $? "IPv4 host entry not flushed by \"nopermanent\" state"
+
+	bridge mdb flush dev br0
+
+	# Check that IPv6 host entries are not flushed when "permanent" is
+	# specified, but flushed when "nopermanent" is specified.
+
+	bridge mdb add dev br0 port br0 grp ff0e::1 temp vid 10
+
+	bridge mdb flush dev br0 permanent
+
+	bridge mdb get dev br0 grp ff0e::1 vid 10 &> /dev/null
+	check_err $? "IPv6 host entry flushed by wrong state (\"permanent\")"
+
+	bridge mdb flush dev br0 nopermanent
+
+	bridge mdb get dev br0 grp ff0e::1 vid 10 &> /dev/null
+	check_fail $? "IPv6 host entry not flushed by \"nopermanent\" state"
+
+	bridge mdb flush dev br0
+
+	# Check that when flushing by routing protocol only entries programmed
+	# with the specified routing protocol are flushed and the rest are not.
+
+	bridge mdb add dev br0 port $swp1 grp 239.1.1.1 vid 10 proto bgp
+	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 10 proto zebra
+	bridge mdb add dev br0 port br0 grp 239.1.1.1 vid 10
+
+	bridge mdb flush dev br0 proto bgp
+
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
+	check_fail $? "Entry not flushed by specified routing protocol"
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp2"
+	check_err $? "Entry flushed by wrong routing protocol"
+	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port br0"
+	check_err $? "Host entry flushed by wrong routing protocol"
+
+	bridge mdb flush dev br0
+
+	# Test that an error is returned when trying to flush using unsupported
+	# parameters.
+
+	bridge mdb flush dev br0 src_vni 10 &> /dev/null
+	check_fail $? "Managed to flush by source VNI"
+
+	bridge mdb flush dev br0 dst 198.51.100.1 &> /dev/null
+	check_fail $? "Managed to flush by destination IP"
+
+	bridge mdb flush dev br0 dst_port 4789 &> /dev/null
+	check_fail $? "Managed to flush by UDP destination port"
+
+	bridge mdb flush dev br0 vni 10 &> /dev/null
+	check_fail $? "Managed to flush by destination VNI"
+
+	log_test "Flush tests"
+}
+
 cfg_test()
 {
 	cfg_test_host
 	cfg_test_port
 	cfg_test_dump
+	cfg_test_flush
 }
 
 __fwd_test_host_ip()
@@ -1166,8 +1353,8 @@ ctrl_test()
 	ctrl_mldv2_is_in_test
 }
 
-if ! bridge mdb help 2>&1 | grep -q "get"; then
-	echo "SKIP: iproute2 too old, missing bridge mdb get support"
+if ! bridge mdb help 2>&1 | grep -q "flush"; then
+	echo "SKIP: iproute2 too old, missing bridge mdb flush support"
 	exit $ksft_skip
 fi
 
-- 
2.40.1


