Return-Path: <netdev+bounces-16905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098F74F60C
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEC51C20DE5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519C1E521;
	Tue, 11 Jul 2023 16:46:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71B1E506
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:46:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADC01BE1
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyPqnqBMA6reU/tG9jNKorfUTZvZoqDiKcjJaR5Eqgk8rMz/LN0MVIQ+l3086atBcPsIl0iCWmfJU2GTBKCCOSsX/FYpWjxyLOpJ/a4Tsbcq9jYoGu4/06tRDXRJLrXoBUIhmWTpxli9CAfiUl+dpmY0eSx8Fpcxmrzd5ltghHux+CC4Sv4nBo/EjN6pnkG7NRXFPAJI4OhsVajirAgh42/DMzqEw9WrrNueCkAhTTz9b+bMY1TCc0PsXwc1jeejYVT0trBwsrQWjCs3oDW2LkCKtFXUSIfaQyL8MYw3p6Ke6y+qbYKgQOjlr+7KMA8BrsDlYG7/8PUU9DLmFK+jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+wa9uNTYz49vJsmJZay97N/iZm5e/V8Aw5JG342aLY=;
 b=JPED7OTcBon3JqTWLV3Vfyg4/HzotT8NtZZvi06y7SoMgIS/LKwcZmcHAZlv+RY7GPFFo4sPSRN398lQVCdRCypzHAJb5OwlfNZGZHSbJ0yAYk5qk2dxK+PYl3TONFrFBr3/ewpSBVAtq6M32fL1PcOSKOYX9NSxlcinuC0AohLCLEkI8QE4YslfZ6RAV4NnEkpqffR2Pr30pOtKks2YGruqdhHqWMXZe1nC+kLQWcvJsf0qTcYeCxhlR7Qjf7XHT8jPT16tsAzrklUhfdsidWy3CVwwrXkQ8jcG28CQ1pzCNPGZQ3D+aVCV8ykqFCo31M7Yxmc3tneFrLN3KkMoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+wa9uNTYz49vJsmJZay97N/iZm5e/V8Aw5JG342aLY=;
 b=Pxd5/m/Tq7GxoJAmvrmS8vkKr9FPcJwRuSPtdrb7HXBE0OxIPGfpe9Dtco1QXAPLKQNj8LDKKRnSdZskEF0FCustXPvyy28p3FjhfPuoK8N2BnoxUpTU5bPDrak0udkn3bv1ay+NGvDv12YS6gapGjRwTVNTFCkk63yWc1gJmsJdCdLpk4jwt6lJIRA3qQaet+XUqNh7HLoktsNJFmkF/WZbBNxrERMZ854G8fr6cTFG3eUiYiKDXOVNgKyVac2Kl9xY2EPvQMcATNw/o/KjcQTIetsVYsBaJJxOGJ44p1WArZhZ+Cqe+6AQWK/BAXDb7qpsYQmxRReZtuRZ+8RngQ==
Received: from MW4PR04CA0364.namprd04.prod.outlook.com (2603:10b6:303:81::9)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Tue, 11 Jul 2023 16:45:00 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::f4) by MW4PR04CA0364.outlook.office365.com
 (2603:10b6:303:81::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:49 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:47 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 10/10] selftests: forwarding: Add test cases for flower port range matching
Date: Tue, 11 Jul 2023 18:44:03 +0200
Message-ID: <9d47c9cd4522b2d335b13ce8f6c9b33199298cee.1689092769.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689092769.git.petrm@nvidia.com>
References: <cover.1689092769.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|DM8PR12MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: 4453393a-80b6-4e10-2aaa-08db822e2a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	89e9b0Q6fIN5q3RzowGtrOdLrQBEanhh4MbHhl6SYtaBwmVWXUPomcIerBudDYjEGZ3fcz3v67QsZV/OGrCUg6Q8cakC2fs2N2gTONXqtTHVY9zeUJNJlnzr+0DEu9eNj0VNc72eBGc5dMNJEkRUcHNUKw05YNbJn1+niA2GyacBRzzfbc9ZR0yCggtbxCiHr7CBq2qxTp0AzBKM5aXcm2C7VdZlKZZ9RnQUxxuHmqNSVyk8RiisrlLoFObF8iOTHE08NMrCgPAY+2ctURUHsFidXaUXdFQpHWYh3h5K+CWog6bhxUWBvSd9McckxySxTqwC1V6rF9zDeWSCNuyUXuRtbiLifB+xVgSz6h6sPlN//m8Z0FSSQqze6Srze9SZopX5I5NpD3FDFN2b/qOJdCCmR4w6ApGqWG4V9eS1paEWsBF1sV8j9A1Es3lLTtRceidJ+tymOWEpeTrRk77F3xoSrMaPqG2YoTNyb/dOttiZpeZpJaWiNsPKMIOakueKb+95Gn67zr4ERGNkK1vv6yjnsneLV+u3V5nmMHAHbsmArDvRxqxLcJAi0q6tDO+XtQDdaLvxicmqLTmtPRMsGK+FxckfETvyRIoWIw6danvqmWv1joifWTdj2QG1UJcm4cwf89QMOQMX8ZhBvZjKChm1B/gOAqjqjJt4mpqOOSdKaEGbY2ZxBK74+VyvdVHrT6EaYCn4FPguYEvJZ8/GLM0LlAlTo1bOo3tmMg3gQSw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(478600001)(83380400001)(47076005)(2616005)(16526019)(186003)(26005)(336012)(426003)(36756003)(107886003)(40480700001)(40460700003)(36860700001)(316002)(82310400005)(2906002)(41300700001)(356005)(7636003)(82740400003)(70586007)(70206006)(4326008)(86362001)(8936002)(8676002)(5660300002)(110136005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:59.7169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4453393a-80b6-4e10-2aaa-08db822e2a9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Add test cases to verify that flower port range matching works
correctly. Test both source and destination port ranges, with different
combinations of IPv4/IPv6 and TCP/UDP, on both ingress and egress.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/tc_flower_port_range.sh    | 228 ++++++++++++++++++
 2 files changed, 229 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/tc_flower_port_range.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 770efbe24f0d..f49c6c3f6520 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -85,6 +85,7 @@ TEST_PROGS = bridge_igmp.sh \
 	tc_flower.sh \
 	tc_flower_l2_miss.sh \
 	tc_flower_cfm.sh \
+	tc_flower_port_range.sh \
 	tc_mpls_l2vpn.sh \
 	tc_police.sh \
 	tc_shblocks.sh \
diff --git a/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh b/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh
new file mode 100755
index 000000000000..3885a2a91f7d
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/tc_flower_port_range.sh
@@ -0,0 +1,228 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +-----------------------+                             +----------------------+
+# | H1 (vrf)              |                             | H2 (vrf)             |
+# |    + $h1              |                             |              $h2 +   |
+# |    | 192.0.2.1/28     |                             |     192.0.2.2/28 |   |
+# |    | 2001:db8:1::1/64 |                             | 2001:db8:1::2/64 |   |
+# +----|------------------+                             +------------------|---+
+#      |                                                                   |
+# +----|-------------------------------------------------------------------|---+
+# | SW |                                                                   |   |
+# |  +-|-------------------------------------------------------------------|-+ |
+# |  | + $swp1                       BR                              $swp2 + | |
+# |  +-----------------------------------------------------------------------+ |
+# +----------------------------------------------------------------------------+
+
+ALL_TESTS="
+	test_port_range_ipv4_udp
+	test_port_range_ipv4_tcp
+	test_port_range_ipv6_udp
+	test_port_range_ipv6_tcp
+"
+
+NUM_NETIFS=4
+source lib.sh
+source tc_common.sh
+
+h1_create()
+{
+	simple_if_init $h1 192.0.2.1/28 2001:db8:1::1/64
+}
+
+h1_destroy()
+{
+	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
+}
+
+h2_create()
+{
+	simple_if_init $h2 192.0.2.2/28 2001:db8:1::2/64
+}
+
+h2_destroy()
+{
+	simple_if_fini $h2 192.0.2.2/28 2001:db8:1::2/64
+}
+
+switch_create()
+{
+	ip link add name br1 type bridge
+	ip link set dev $swp1 master br1
+	ip link set dev $swp1 up
+	ip link set dev $swp2 master br1
+	ip link set dev $swp2 up
+	ip link set dev br1 up
+
+	tc qdisc add dev $swp1 clsact
+	tc qdisc add dev $swp2 clsact
+}
+
+switch_destroy()
+{
+	tc qdisc del dev $swp2 clsact
+	tc qdisc del dev $swp1 clsact
+
+	ip link set dev br1 down
+	ip link set dev $swp2 down
+	ip link set dev $swp2 nomaster
+	ip link set dev $swp1 down
+	ip link set dev $swp1 nomaster
+	ip link del dev br1
+}
+
+__test_port_range()
+{
+	local proto=$1; shift
+	local ip_proto=$1; shift
+	local sip=$1; shift
+	local dip=$1; shift
+	local mode=$1; shift
+	local name=$1; shift
+	local dmac=$(mac_get $h2)
+	local smac=$(mac_get $h1)
+	local sport_min=100
+	local sport_max=200
+	local sport_mid=$((sport_min + (sport_max - sport_min) / 2))
+	local dport_min=300
+	local dport_max=400
+	local dport_mid=$((dport_min + (dport_max - dport_min) / 2))
+
+	RET=0
+
+	tc filter add dev $swp1 ingress protocol $proto handle 101 pref 1 \
+		flower src_ip $sip dst_ip $dip ip_proto $ip_proto \
+		src_port $sport_min-$sport_max \
+		dst_port $dport_min-$dport_max \
+		action pass
+	tc filter add dev $swp2 egress protocol $proto handle 101 pref 1 \
+		flower src_ip $sip dst_ip $dip ip_proto $ip_proto \
+		src_port $sport_min-$sport_max \
+		dst_port $dport_min-$dport_max \
+		action drop
+
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$sport_min,dp=$dport_min"
+	tc_check_packets "dev $swp1 ingress" 101 1
+	check_err $? "Ingress filter not hit with minimum ports"
+	tc_check_packets "dev $swp2 egress" 101 1
+	check_err $? "Egress filter not hit with minimum ports"
+
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$sport_mid,dp=$dport_mid"
+	tc_check_packets "dev $swp1 ingress" 101 2
+	check_err $? "Ingress filter not hit with middle ports"
+	tc_check_packets "dev $swp2 egress" 101 2
+	check_err $? "Egress filter not hit with middle ports"
+
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$sport_max,dp=$dport_max"
+	tc_check_packets "dev $swp1 ingress" 101 3
+	check_err $? "Ingress filter not hit with maximum ports"
+	tc_check_packets "dev $swp2 egress" 101 3
+	check_err $? "Egress filter not hit with maximum ports"
+
+	# Send traffic when both ports are out of range and when only one port
+	# is out of range.
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$((sport_min - 1)),dp=$dport_min"
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$((sport_max + 1)),dp=$dport_min"
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$sport_min,dp=$((dport_min - 1))"
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$sport_min,dp=$((dport_max + 1))"
+	$MZ $mode $h1 -c 1 -q -p 100 -a $smac -b $dmac -A $sip -B $dip \
+		-t $ip_proto "sp=$((sport_max + 1)),dp=$((dport_max + 1))"
+	tc_check_packets "dev $swp1 ingress" 101 3
+	check_err $? "Ingress filter was hit when should not"
+	tc_check_packets "dev $swp2 egress" 101 3
+	check_err $? "Egress filter was hit when should not"
+
+	tc filter del dev $swp2 egress protocol $proto pref 1 handle 101 flower
+	tc filter del dev $swp1 ingress protocol $proto pref 1 handle 101 flower
+
+	log_test "Port range matching - $name"
+}
+
+test_port_range_ipv4_udp()
+{
+	local proto=ipv4
+	local ip_proto=udp
+	local sip=192.0.2.1
+	local dip=192.0.2.2
+	local mode="-4"
+	local name="IPv4 UDP"
+
+	__test_port_range $proto $ip_proto $sip $dip $mode "$name"
+}
+
+test_port_range_ipv4_tcp()
+{
+	local proto=ipv4
+	local ip_proto=tcp
+	local sip=192.0.2.1
+	local dip=192.0.2.2
+	local mode="-4"
+	local name="IPv4 TCP"
+
+	__test_port_range $proto $ip_proto $sip $dip $mode "$name"
+}
+
+test_port_range_ipv6_udp()
+{
+	local proto=ipv6
+	local ip_proto=udp
+	local sip=2001:db8:1::1
+	local dip=2001:db8:1::2
+	local mode="-6"
+	local name="IPv6 UDP"
+
+	__test_port_range $proto $ip_proto $sip $dip $mode "$name"
+}
+
+test_port_range_ipv6_tcp()
+{
+	local proto=ipv6
+	local ip_proto=tcp
+	local sip=2001:db8:1::1
+	local dip=2001:db8:1::2
+	local mode="-6"
+	local name="IPv6 TCP"
+
+	__test_port_range $proto $ip_proto $sip $dip $mode "$name"
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	swp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	vrf_prepare
+	h1_create
+	h2_create
+	switch_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	switch_destroy
+	h2_destroy
+	h1_destroy
+	vrf_cleanup
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.40.1


