Return-Path: <netdev+bounces-233102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E1C0C49F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03B4A4EEE4E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FF42E7BC0;
	Mon, 27 Oct 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L3qs0UUz"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866002E7F39
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553496; cv=fail; b=nfUGY/uBLQDJrglD/pD5DDxCxAuj3n+vsGDYfUJp0HHbSdZUxyKhjq9FRjlotzB3hMQKIXIzHSahG+Nofn2hBTWukjKYJNlSTmmIPMHhSsX3l83P534Fe+1HpI2mFpZZyUT5Y8sYPLeRfZ0V9wzFqHzwgW22gCXg1wGQj9Q4EyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553496; c=relaxed/simple;
	bh=pexA7bJzVMgsP+w7WcXxfMgPHXic6w7vc+E7k37nhc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dugD0MZuVgWT40Bp/dInOGY5Cr48AHVF9KZoLtRj7VbpWgrA409ci5eieOiX09OkLFz3492SwbTq69TxmlZ/nny4MFaqNRKgpLKAH2kxcAf/h8KEMqq/M2ELzK3Ai0hnGXRFwkKypHM8YfSomYOR/FsYnwdHgQoc8YU+wJVZwIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L3qs0UUz; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGkEL5Sy+Fhxyyyo1+4XlJ3VSN5+OABG4HVRRL5eeGBCPQzf34jaxyyhWGrBH9D/NB02qb4/fcQRkAT60K3AeHesYQrBKSJzFj2yBu921xXPesw8StEFlQjeLVNyXmANdy/rnH5q/pLJmrlumqjl+YYakxxsZkad3RH27uRX116/mCECb1wrE9o/KKeNCkWTe9gFEBmYRMT+eztaGDLT1HKrIelrk6eytKbXIYLpUYx2zFL5uRn73AfQsFZBjfPQ4k4/w4ojR4cgNTLY0ulAGOngw7mMMID/a08XW/Qm8e84/9keoQnmiyHL7oMoWBBEErTu02AS+X8mw5TZ1p7LQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU/Ye6fQrddbErd6m/FuDxJrpq3MXu7I4TxLm3QrCxg=;
 b=v2RqnYngbuNW9vq1NzdaFBzZu5i9Nz151NZtorHpinyKYpzDqgtzqVtEXs2LntUvlhGcuSxrxGQYMX4Xpl/lfpdjk9WPSERbuOuA4levMg8cLU4j6T0sFsSxlAWLH5iilzDVmlos/yANq/oB1a/NHrRCtr/lq/jkclTlyeWqB+CpyWPXoWrFr/gvO3LHD7y76VXNNjRyyZsepi9rsDXzYZTSfXFlIJjinN6qc0rmVCDWSizfb6RtDuMPymOcaIvwaUKSrAzU49gIzMH/TC/JWghOBRBlnSHCB9Vci6Jyij6WuX8FP8uSHYsHZsji+l8Sd+dCNHe5nglPTj8BXnlwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU/Ye6fQrddbErd6m/FuDxJrpq3MXu7I4TxLm3QrCxg=;
 b=L3qs0UUzqKn6P0jpVHJoqiisatmWTpjTjQ1Ne9owg4cujWehkXPgAna+DH64l3YgSKlciSajUjYIpoYbstdHd/LG/Td2031eGVwFmIzBEgjTjGBJCLvIIcmlO88XAUlVAVByXZv1NJ7R+lxwj8kENTniGKOgCv2cM6Kkkz2Dr2v+MkjZbrd0NJZlZtXbMPDR+u9xo658KRzlCY31Pk9ttMopmEoqIVApJM5jbq/zzcoqBTdEzCzGpGfW2dVHkmLOlqtFtBvHZtlfILdUEB5BSbYHWZRtc8TNTgaAhXMWlPEmAWZbUpDGtqafT7ae393shILPbg35smPYrFPBmQ0dzw==
Received: from DS7PR05CA0071.namprd05.prod.outlook.com (2603:10b6:8:57::14) by
 CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.19; Mon, 27 Oct 2025 08:24:45 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::1e) by DS7PR05CA0071.outlook.office365.com
 (2603:10b6:8:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Mon,
 27 Oct 2025 08:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 08:24:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 01:24:31 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 01:24:27 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <dsahern@kernel.org>,
	<petrm@nvidia.com>, <willemb@google.com>, <daniel@iogearbox.net>,
	<fw@strlen.de>, <ishaangandhi@gmail.com>, <rbonica@juniper.net>,
	<tom@herbertland.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 3/3] selftests: traceroute: Add ICMP extensions tests
Date: Mon, 27 Oct 2025 10:22:32 +0200
Message-ID: <20251027082232.232571-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027082232.232571-1-idosch@nvidia.com>
References: <20251027082232.232571-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2be8ec-7534-45e6-4e1c-08de153248e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/0fXcK59TbjRpIoyCiXwoc/8CL38cR7xlkGKRLYOpOyPmidztz0cvPfX0owU?=
 =?us-ascii?Q?6luELN/5Yh4rG5cMLji4WdZWd6sS/gaCeYlbU/ppi430ZdqiNm9dN87a555p?=
 =?us-ascii?Q?LAf21483bxxxUyW7vzemvpeQHCI8EVWQFtezXvNE0zqoPYCWGF1LcHkwZbPA?=
 =?us-ascii?Q?SyJdsNt1Y5hPfzNShaLEny5KI4M/fhAN7ZlPK+PJnFdJDVy7kAdtKVslvk8X?=
 =?us-ascii?Q?dD9cfSSPnpoiVGUaVbg4HfQXx7sfa4eevvQ0e3w4j0BWIwR/Uf8j0NTNjAmt?=
 =?us-ascii?Q?Npp7AF/bdLdM+oNbfnFZEsmJu1CECaqhI/SmSQuxHHLCECDni8HKFL7WmfgC?=
 =?us-ascii?Q?JxjBcRKpXGnXOXBnOpWLwfZ4vc2KzG1st5piL5blIjiltfa611QrBHYcm7nM?=
 =?us-ascii?Q?ckl9JKRDvrCijD7Cc7nRW9trFK5TZp3havpL820Y7sjk7RH1ddN7INgReK4w?=
 =?us-ascii?Q?CcubiO9QmWZ8t1LsO/yXnATvixuNpcUPzY7oWdvlL8RgDvZ6Ge1RY315+MtS?=
 =?us-ascii?Q?+KvPSxX/KXGtlt6DaLmAovqN3Je4XR7nZGcjGh2GvCUXTyQiK/qApFywKtQN?=
 =?us-ascii?Q?onZy5ipEuo921MtqU14k74paAjdKXfmz/jjDxyrL3SkWVQQ2T0iK5KQebnwx?=
 =?us-ascii?Q?fhtwcKXq+F50+o1BzTVHeEblXeESd5bkxCcnSfebJ3CG5maiNvQj6ngvJm1J?=
 =?us-ascii?Q?M24ADoeFHV6Pd7Ipl2OLx0GY5rW64bBnzF8nXipV0+GwRShNTgmiDmB8kO36?=
 =?us-ascii?Q?5GZ1pVWHP2Dfd/lD/lQ2aXCBbqgBJlTrqsKgBthr3UM13UzglkQQsKMU3kp1?=
 =?us-ascii?Q?b5jAUr2wtSLh++vYdNZ4PPC18PU/S5D6keJdoOasWfCC9q7nImhC/wJHHovM?=
 =?us-ascii?Q?Vx+IHBvRa/o7CDHCF/yU7dK8IWAEgX/fVi9ze6N07C0Plav4spXIb1rYr3aG?=
 =?us-ascii?Q?oJ9e2U5bwrhxXC8BzKxQeMDXLeYTTvvIqslRriT9bSCvdDL92tOwyUfGobko?=
 =?us-ascii?Q?JqEzOXm/30JkcOsOa4bQmsxkRbNsQS0pzrLAER8cBwf3Ii8s5sNkGpMYfeGq?=
 =?us-ascii?Q?FKU5WVTTXfcfD3GA2dvluKZen6oX4MyH0xRru9HiO2erkBuXbLj34KyVDaMe?=
 =?us-ascii?Q?lWp3Zqz3eIhFT9TH7LnLigQ70M2OOe/477UtpVT96mAq83UZKa49Omvkn6ro?=
 =?us-ascii?Q?Wcn6ZvoK80ZcHQzj1+tOfCFN1jgrklxZ0OF4yma5ijGRrcM/vmAMUhKBsHs7?=
 =?us-ascii?Q?dlWp4kXPRJoHlbqfg4xjPu4znQpqpMQWOvJbpNVP6HEZqaP+QQCGk0ioz2Y4?=
 =?us-ascii?Q?AsRSigrXbC0qFovjpkaCfI4D6/wb8L8rP7EFLV2xbcuySREPmlsv7lNjGTKl?=
 =?us-ascii?Q?qFG+klLTd59eFAx+dbCw+FRm0p6SceKbS3RmEA7/hG+G4T/gkHftWzgIaT6r?=
 =?us-ascii?Q?woIff8L8zqJKeCzgnNlQ6xzUu9zdocMM+O4EHjBuOJ4gg3FxdqsVi3LwZU/D?=
 =?us-ascii?Q?fWIjuZxvguWiwBpxVQ4QMTQ+drHbnSmJOh6GpIZMU0v2GTm4wMYlYXXb9mC0?=
 =?us-ascii?Q?RHsNGq+kvTt9UFw6j9s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:24:44.7308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2be8ec-7534-45e6-4e1c-08de153248e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181

Test that ICMP extensions are reported correctly when enabled and not
reported when disabled. Test both IPv4 and IPv6 and using different
packet sizes, to make sure trimming / padding works correctly.

Disable ICMP rate limiting (defaults to 1 per-second per-target) so that
the kernel will always generate ICMP errors when needed.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Use "echo" instead of "sysctl" when we are testing the return value.
    * Skip if traceroute version is older than 2.1.5.

 tools/testing/selftests/net/traceroute.sh | 313 ++++++++++++++++++++++
 1 file changed, 313 insertions(+)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index dbb34c7e09ce..a7c6ab8a0347 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -36,6 +36,35 @@ run_cmd()
 	return $rc
 }
 
+__check_traceroute_version()
+{
+	local cmd=$1; shift
+	local req_ver=$1; shift
+	local ver
+
+	req_ver=$(echo "$req_ver" | sed 's/\.//g')
+	ver=$($cmd -V 2>&1 | grep -Eo '[0-9]+.[0-9]+.[0-9]+' | sed 's/\.//g')
+	if [[ $ver -lt $req_ver ]]; then
+		return 1
+	else
+		return 0
+	fi
+}
+
+check_traceroute6_version()
+{
+	local req_ver=$1; shift
+
+	__check_traceroute_version traceroute6 "$req_ver"
+}
+
+check_traceroute_version()
+{
+	local req_ver=$1; shift
+
+	__check_traceroute_version traceroute "$req_ver"
+}
+
 ################################################################################
 # create namespaces and interconnects
 
@@ -59,6 +88,8 @@ create_ns()
 	ip netns exec ${ns} ip -6 ro add unreachable default metric 8192
 
 	ip netns exec ${ns} sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec ${ns} sysctl -qw net.ipv4.icmp_ratelimit=0
+	ip netns exec ${ns} sysctl -qw net.ipv6.icmp.ratelimit=0
 	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
 	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.forwarding=1
 	ip netns exec ${ns} sysctl -qw net.ipv6.conf.default.forwarding=1
@@ -297,6 +328,144 @@ run_traceroute6_vrf()
 	cleanup_traceroute6_vrf
 }
 
+################################################################################
+# traceroute6 with ICMP extensions test
+#
+# Verify that in this scenario
+#
+# ----                          ----                          ----
+# |H1|--------------------------|R1|--------------------------|H2|
+# ----            N1            ----            N2            ----
+#
+# ICMP extensions are correctly reported. The loopback interfaces on all the
+# nodes are assigned global addresses and the interfaces connecting the nodes
+# are assigned IPv6 link-local addresses.
+
+cleanup_traceroute6_ext()
+{
+	cleanup_all_ns
+}
+
+setup_traceroute6_ext()
+{
+	# Start clean
+	cleanup_traceroute6_ext
+
+	setup_ns h1 r1 h2
+	create_ns "$h1"
+	create_ns "$r1"
+	create_ns "$h2"
+
+	# Setup N1
+	connect_ns "$h1" eth1 - fe80::1/64 "$r1" eth1 - fe80::2/64
+	# Setup N2
+	connect_ns "$r1" eth2 - fe80::3/64 "$h2" eth2 - fe80::4/64
+
+	# Setup H1
+	ip -n "$h1" address add 2001:db8:1::1/128 dev lo
+	ip -n "$h1" route add ::/0 nexthop via fe80::2 dev eth1
+
+	# Setup R1
+	ip -n "$r1" address add 2001:db8:1::2/128 dev lo
+	ip -n "$r1" route add 2001:db8:1::1/128 nexthop via fe80::1 dev eth1
+	ip -n "$r1" route add 2001:db8:1::3/128 nexthop via fe80::4 dev eth2
+
+	# Setup H2
+	ip -n "$h2" address add 2001:db8:1::3/128 dev lo
+	ip -n "$h2" route add ::/0 nexthop via fe80::3 dev eth2
+
+	# Prime the network
+	ip netns exec "$h1" ping6 -c5 2001:db8:1::3 >/dev/null 2>&1
+}
+
+traceroute6_ext_iio_iif_test()
+{
+	local r1_ifindex h2_ifindex
+	local pkt_len=$1; shift
+
+	# Test that incoming interface info is not appended by default.
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep INC"
+	check_fail $? "Incoming interface info appended by default when should not"
+
+	# Test that the extension is appended when enabled.
+	run_cmd "$r1" "bash -c \"echo 0x01 > /proc/sys/net/ipv6/icmp/errors_extension_mask\""
+	check_err $? "Failed to enable incoming interface info extension on R1"
+
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep INC"
+	check_err $? "Incoming interface info not appended after enable"
+
+	# Test that the extension is not appended when disabled.
+	run_cmd "$r1" "bash -c \"echo 0x00 > /proc/sys/net/ipv6/icmp/errors_extension_mask\""
+	check_err $? "Failed to disable incoming interface info extension on R1"
+
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep INC"
+	check_fail $? "Incoming interface info appended after disable"
+
+	# Test that the extension is sent correctly from both R1 and H2.
+	run_cmd "$r1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x01"
+	r1_ifindex=$(ip -n "$r1" -j link show dev eth1 | jq '.[]["ifindex"]')
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from R1"
+
+	run_cmd "$h2" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x01"
+	h2_ifindex=$(ip -n "$h2" -j link show dev eth2 | jq '.[]["ifindex"]')
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$h2_ifindex,\"eth2\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from H2"
+
+	# Add a global address on the incoming interface of R1 and check that
+	# it is reported.
+	run_cmd "$r1" "ip address add 2001:db8:100::1/64 dev eth1 nodad"
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$r1_ifindex,2001:db8:100::1,\"eth1\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from R1 after address addition"
+	run_cmd "$r1" "ip address del 2001:db8:100::1/64 dev eth1"
+
+	# Change name and MTU and make sure the result is still correct.
+	run_cmd "$r1" "ip link set dev eth1 name eth1tag mtu 1501"
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1tag\",mtu=1501>'"
+	check_err $? "Wrong incoming interface info reported from R1 after name and MTU change"
+	run_cmd "$r1" "ip link set dev eth1tag name eth1 mtu 1500"
+
+	run_cmd "$r1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x00"
+	run_cmd "$h2" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x00"
+}
+
+run_traceroute6_ext()
+{
+	# Need at least version 2.1.5 for RFC 5837 support.
+	if ! check_traceroute6_version 2.1.5; then
+		log_test_skip "traceroute6 too old, missing ICMP extensions support"
+		return
+	fi
+
+	setup_traceroute6_ext
+
+	RET=0
+
+	## General ICMP extensions tests
+
+	# Test that ICMP extensions are disabled by default.
+	run_cmd "$h1" "sysctl net.ipv6.icmp.errors_extension_mask | grep \"= 0$\""
+	check_err $? "ICMP extensions are not disabled by default"
+
+	# Test that unsupported values are rejected. Do not use "sysctl" as
+	# older versions do not return an error code upon failure.
+	run_cmd "$h1" "bash -c \"echo 0x80 > /proc/sys/net/ipv6/icmp/errors_extension_mask\""
+	check_fail $? "Unsupported sysctl value was not rejected"
+
+	## Extension-specific tests
+
+	# Incoming interface info test. Test with various packet sizes,
+	# including the default one.
+	traceroute6_ext_iio_iif_test
+	traceroute6_ext_iio_iif_test 127
+	traceroute6_ext_iio_iif_test 128
+	traceroute6_ext_iio_iif_test 129
+
+	log_test "IPv6 traceroute with ICMP extensions"
+
+	cleanup_traceroute6_ext
+}
+
 ################################################################################
 # traceroute test
 #
@@ -437,6 +606,147 @@ run_traceroute_vrf()
 	cleanup_traceroute_vrf
 }
 
+################################################################################
+# traceroute with ICMP extensions test
+#
+# Verify that in this scenario
+#
+# ----                          ----                          ----
+# |H1|--------------------------|R1|--------------------------|H2|
+# ----            N1            ----            N2            ----
+#
+# ICMP extensions are correctly reported. The loopback interfaces on all the
+# nodes are assigned global addresses and the interfaces connecting the nodes
+# are assigned IPv6 link-local addresses.
+
+cleanup_traceroute_ext()
+{
+	cleanup_all_ns
+}
+
+setup_traceroute_ext()
+{
+	# Start clean
+	cleanup_traceroute_ext
+
+	setup_ns h1 r1 h2
+	create_ns "$h1"
+	create_ns "$r1"
+	create_ns "$h2"
+
+	# Setup N1
+	connect_ns "$h1" eth1 - fe80::1/64 "$r1" eth1 - fe80::2/64
+	# Setup N2
+	connect_ns "$r1" eth2 - fe80::3/64 "$h2" eth2 - fe80::4/64
+
+	# Setup H1
+	ip -n "$h1" address add 192.0.2.1/32 dev lo
+	ip -n "$h1" route add 0.0.0.0/0 nexthop via inet6 fe80::2 dev eth1
+
+	# Setup R1
+	ip -n "$r1" address add 192.0.2.2/32 dev lo
+	ip -n "$r1" route add 192.0.2.1/32 nexthop via inet6 fe80::1 dev eth1
+	ip -n "$r1" route add 192.0.2.3/32 nexthop via inet6 fe80::4 dev eth2
+
+	# Setup H2
+	ip -n "$h2" address add 192.0.2.3/32 dev lo
+	ip -n "$h2" route add 0.0.0.0/0 nexthop via inet6 fe80::3 dev eth2
+
+	# Prime the network
+	ip netns exec "$h1" ping -c5 192.0.2.3 >/dev/null 2>&1
+}
+
+traceroute_ext_iio_iif_test()
+{
+	local r1_ifindex h2_ifindex
+	local pkt_len=$1; shift
+
+	# Test that incoming interface info is not appended by default.
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep INC"
+	check_fail $? "Incoming interface info appended by default when should not"
+
+	# Test that the extension is appended when enabled.
+	run_cmd "$r1" "bash -c \"echo 0x01 > /proc/sys/net/ipv4/icmp_errors_extension_mask\""
+	check_err $? "Failed to enable incoming interface info extension on R1"
+
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep INC"
+	check_err $? "Incoming interface info not appended after enable"
+
+	# Test that the extension is not appended when disabled.
+	run_cmd "$r1" "bash -c \"echo 0x00 > /proc/sys/net/ipv4/icmp_errors_extension_mask\""
+	check_err $? "Failed to disable incoming interface info extension on R1"
+
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep INC"
+	check_fail $? "Incoming interface info appended after disable"
+
+	# Test that the extension is sent correctly from both R1 and H2.
+	run_cmd "$r1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x01"
+	r1_ifindex=$(ip -n "$r1" -j link show dev eth1 | jq '.[]["ifindex"]')
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from R1"
+
+	run_cmd "$h2" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x01"
+	h2_ifindex=$(ip -n "$h2" -j link show dev eth2 | jq '.[]["ifindex"]')
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$h2_ifindex,\"eth2\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from H2"
+
+	# Add a global address on the incoming interface of R1 and check that
+	# it is reported.
+	run_cmd "$r1" "ip address add 198.51.100.1/24 dev eth1"
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$r1_ifindex,198.51.100.1,\"eth1\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from R1 after address addition"
+	run_cmd "$r1" "ip address del 198.51.100.1/24 dev eth1"
+
+	# Change name and MTU and make sure the result is still correct.
+	# Re-add the route towards H1 since it was deleted when we removed the
+	# last IPv4 address from eth1 on R1.
+	run_cmd "$r1" "ip route add 192.0.2.1/32 nexthop via inet6 fe80::1 dev eth1"
+	run_cmd "$r1" "ip link set dev eth1 name eth1tag mtu 1501"
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1tag\",mtu=1501>'"
+	check_err $? "Wrong incoming interface info reported from R1 after name and MTU change"
+	run_cmd "$r1" "ip link set dev eth1tag name eth1 mtu 1500"
+
+	run_cmd "$r1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x00"
+	run_cmd "$h2" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x00"
+}
+
+run_traceroute_ext()
+{
+	# Need at least version 2.1.5 for RFC 5837 support.
+	if ! check_traceroute_version 2.1.5; then
+		log_test_skip "traceroute too old, missing ICMP extensions support"
+		return
+	fi
+
+	setup_traceroute_ext
+
+	RET=0
+
+	## General ICMP extensions tests
+
+	# Test that ICMP extensions are disabled by default.
+	run_cmd "$h1" "sysctl net.ipv4.icmp_errors_extension_mask | grep \"= 0$\""
+	check_err $? "ICMP extensions are not disabled by default"
+
+	# Test that unsupported values are rejected. Do not use "sysctl" as
+	# older versions do not return an error code upon failure.
+	run_cmd "$h1" "bash -c \"echo 0x80 > /proc/sys/net/ipv4/icmp_errors_extension_mask\""
+	check_fail $? "Unsupported sysctl value was not rejected"
+
+	## Extension-specific tests
+
+	# Incoming interface info test. Test with various packet sizes,
+	# including the default one.
+	traceroute_ext_iio_iif_test
+	traceroute_ext_iio_iif_test 127
+	traceroute_ext_iio_iif_test 128
+	traceroute_ext_iio_iif_test 129
+
+	log_test "IPv4 traceroute with ICMP extensions"
+
+	cleanup_traceroute_ext
+}
+
 ################################################################################
 # Run tests
 
@@ -444,8 +754,10 @@ run_tests()
 {
 	run_traceroute6
 	run_traceroute6_vrf
+	run_traceroute6_ext
 	run_traceroute
 	run_traceroute_vrf
+	run_traceroute_ext
 }
 
 ################################################################################
@@ -462,6 +774,7 @@ done
 
 require_command traceroute6
 require_command traceroute
+require_command jq
 
 run_tests
 
-- 
2.51.0


