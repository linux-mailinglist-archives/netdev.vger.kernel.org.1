Return-Path: <netdev+bounces-260995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNZcFv0Jn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:41:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A1198D9C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2E0330086BE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504DE285C9F;
	Wed, 25 Feb 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JLs7g9SC"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA5396D2A;
	Wed, 25 Feb 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030455; cv=fail; b=T5oJxLQ+/xZ3c5XWpLOnBGDzDIB793ePCwmUkubalsGfmyy/gnGFWfrkkMw6AIWpvLVopnfbn3/F0IbzPr7GLCCH7CRo9MPp8dlYUnkU3xVAJWBvkK8/rdsFwGkJRk4pp5OTa0wDoEgmb7oIqJZVL+vE3wj2DT3NumYyMWuJqzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030455; c=relaxed/simple;
	bh=2vdEuW65FxHeyUQ3z0Wgi+Kvm7AX4Zros52VWtF8rm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PB8qLiGIiYamgjQ0d+RWaIgSQRM3KGz9OpEmeY9EkGu9hr8j1pAKoHey28GiJA62jpB5WgiuFI/6JXOW3dvLbjGjWC5g/TUurs4PI3zZftMkm/XpM5Fby0b0KPpBus6MZKQH0WWNShRVVAdYyX0b8yXF6tTBpjzLv6dgOnH1SDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JLs7g9SC; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rnn94A155RHkdN//uA9n5PcMvOcEvN+MXtIjclUB8VeElRKg+1XVtDcrd8sGOvaHRjB0UvYxqiM576SrPtZZNIpGMO+RY/ZngO7QXIMXxvGbpkAK570J0YRTwYxwZ1rGpO0kTTDz4AeUkC6AdJUMTTCF8kv6bn5ek3oe/KyqVyVnr/ZfykbOy7prkInQCFjr81uCbXT0A2yb4/bMsrrLcMJziA0cbLVF1k2z4VbfvuNMyKQkcnGQHKZzNcjv78s+eq4Cp0lw2EjY94ZFtOiT+vJdgwD9DQCeK/K0qxqRriaztkGj3pLSvzFqn0S7PXZY12y6Fp/nlnXpdgQXnPDWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUa+RbNoHp7r8f/nYXTWjygZ+DnBbJvzhpJ07gNVj2c=;
 b=HTeQDYt/Oaq6zoSecxLolvtxx9hD6UYksI/ddJZfqElSd7l1xzdrS8o0yPeu+qBcI5n7EI5kevX97zmvRcqmEvaWPjH0w/ZyCcBT5LEc/Q61rCzoN7u8SSEMIf7hiSzMsk8/FpgmavtPNDvRkM8y7u/oUcweuZwhlkRK2zZd28MYQCL2AzfMLdEtEJKtyyO+61JTElH+mdt+vU8Rruwo6us25Y57122+l9KHGcGs86sQECKKbnluFsMfbyT0auMzwDp42s7K5EjrBIVet3O4WwLnyYEA5IlV5jmBrhfMPTjsXIkGtS8iskzObs52fJuhWbmEA2E4CjKC96LW2njdtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUa+RbNoHp7r8f/nYXTWjygZ+DnBbJvzhpJ07gNVj2c=;
 b=JLs7g9SC+mgkEiWwlgU5bQI+Zu193KjkJgbgfEUzmqvtDkZncv9ppa6DaYhtfaw+DlxxcskMlnClktR2sU9OgPf9kQUMV/1YYTGN790ze8b7a+1hgSs5F7Jb8DzOU+D9F9Gl/tezwgm3rhhrdaEHNFdOBsUqLvh3YHroFqcMVxnl15X2wcpKtqATtNz+vSRluINfi2/7ZWOyfMLAa9IJAStIu4JQDk0vRjp/dDtyI9KcvXnfUbNxOo2Qm/U7Dt/PTer3w+zlVicGUzxyNAWB0l2I9Oluu9jcwH40pOUb7GGm6JohbOiiXYaVCzflGp33IbQzvgtAMFVQSufznkwb6Q==
Received: from SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::11)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 14:40:44 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::e0) by SJ0P220CA0028.outlook.office365.com
 (2603:10b6:a03:41b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 14:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 14:40:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 06:40:20 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 25 Feb 2026 06:40:17 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net v2 2/2] selftests: net: Add bridge VLAN range grouping tests
Date: Wed, 25 Feb 2026 16:39:56 +0200
Message-ID: <20260225143956.3995415-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225143956.3995415-1-danieller@nvidia.com>
References: <20260225143956.3995415-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 71da2e7d-1282-47ef-293c-08de747bdb39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	Aa+hqAkW2oroBRyEbUDCbJGkpnZ5oo2TAWiEkl7Pebm9b25xk5DRTA35pNjzP6IGgNcuPkA6M27Ll/PvOfa95NK3L8GhxtywErTM3sWYCaaSXLvRv5szGRP02jeewqCo8iKQgnPWqMtSirEgukere5JV0jdhPgGyA54eY7BFF+JG/9TctEVa8OTY6VVyy17eZU3HIh2lWKx+oP1ccA697RVGYmhZmMbwvT/SNi4mO4OtHz0XmwFBBGCqDdiybOYpbfTpGoCXxPpculMKNNMxwKhDlLiudobys1h7N3NF3tb4RQqwkGE+7ENej1OWZwbARtPMPWtXnqu91Z6APyV9BLfx4wFtbbpoFH3jdx+Veowtuq9K0yPTJ9vtVIxU+AAh6VU4VtsyZPACAIUs2kwPhpFO/nLEojNLOs67jrKM6LZRtmlyOtQeeBMb9kHklU1eZ+EJe+7rvE28WTJgj1Fl6l6a3NroXmF2WNs5E+A6QTRxzl+Tmryi0taALNMR3vEFv70keuA2Yb052QJyCKRhndzSHjkZzNiMfMWcUuxk4bIcHvDcfOd1/ma/3vtyrTsQpYLRBZCA2TeIuZLCTMCMOsFClbArSUVNPZwMt2kCmUTKDmJUFCCpwE2o3y1F9it9MqkcBej+GTG6csde2wahXGcqbvkadJzAHLj7kUsKNaXDv8Sktww5PqsVogKB3egUFDqhYpOYlXeyCOw3tG6fskVoqNuzUrP4Lkqb2mphkXHb3ND8MpS6k1JaZCXsSaoowly1zmO/Av/XFpP/Ko8n8wJ8HfcOxZYgHIwhb0PE2Pw0SeASTDXGt/l20q5osaOVtnCfWDxE6jb1MnatCp7CeA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q2poM7u7Imk+7ixzmpBaA+kDtuTSEtabJ8yWCxUYcWPAlZ8srpYTXK3U7NN9HsPCpr7T6z9CMfaJ5O18REwTkoAlQpfRCkZylzPl+Gji72nyf+vZzpTsR+lYIjSipQQcaKBWhBU+317x72BmKfX3PJ4iCCOVsvtRYz1pRK9zXRGHU77vGoFBq+jEHV+sGk6VhWE+yVPkcCb/gbidzU7Lu9nbRhnoaCDY95SWkTu91+GLI7355pqzbXBx53rEzUZCTu1Ui9fcQSFmlzX+pfsG1R2/ejaxcK5rm4vYqRZJkWYgCLTHj7Em95u60cGKs1mqm/HcMzk9bfmjUUbidyPNZ/qYViF2RmZ0LFbA3vtfUQvvjpKu+QS2IW6m3UrKi+2Yro89+TepyCi+5VdbWeCbGoIWD2cwlVJBfyeJeBQTqRxIbX7stR4RFDO9Di3lLZKO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:40:43.9908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71da2e7d-1282-47ef-293c-08de747bdb39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridge_vlan_dump.sh:url,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 657A1198D9C
X-Rspamd-Action: no action

Add a new test file bridge_vlan_dump.sh with four test cases that verify
VLANs with different per-VLAN options are not incorrectly grouped into
ranges in the dump output.

The tests verify the kernel's br_vlan_opts_eq_range() function correctly
prevents VLAN range grouping when neigh_suppress, mcast_max_groups,
mcast_n_groups, or mcast_enabled options differ.

Each test verifies that VLANs with different option values appear as
individual entries rather than ranges, and that VLANs with matching
values are properly grouped together.

Example output:

$ ./bridge_vlan_dump.sh
TEST: VLAN range grouping with neigh_suppress                       [ OK ]
TEST: VLAN range grouping with mcast_max_groups                     [ OK ]
TEST: VLAN range grouping with mcast_n_groups                       [ OK ]
TEST: VLAN range grouping with mcast_enabled                        [ OK ]

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    	* Address SC issues by adding double-quoting to relevant places,
    	  and adding ignore tags to irrelevant issues.

 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_vlan_dump.sh | 204 ++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100755 tools/testing/selftests/net/bridge_vlan_dump.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index afdea6d95bde..605c54c0e8a3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS := \
 	big_tcp.sh \
 	bind_bhash.sh \
 	bpf_offload.py \
+	bridge_vlan_dump.sh \
 	broadcast_ether_dst.sh \
 	broadcast_pmtu.sh \
 	busy_poll_test.sh \
diff --git a/tools/testing/selftests/net/bridge_vlan_dump.sh b/tools/testing/selftests/net/bridge_vlan_dump.sh
new file mode 100755
index 000000000000..ad66731d2a6f
--- /dev/null
+++ b/tools/testing/selftests/net/bridge_vlan_dump.sh
@@ -0,0 +1,204 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test bridge VLAN range grouping. VLANs are collapsed into a range entry in
+# the dump if they have the same per-VLAN options. These tests verify that
+# VLANs with different per-VLAN option values are not grouped together.
+
+# shellcheck disable=SC1091,SC2034,SC2154,SC2317
+source lib.sh
+
+ALL_TESTS="
+	vlan_range_neigh_suppress
+	vlan_range_mcast_max_groups
+	vlan_range_mcast_n_groups
+	vlan_range_mcast_enabled
+"
+
+setup_prepare()
+{
+	setup_ns NS
+	defer cleanup_all_ns
+
+	ip -n "$NS" link add name br0 type bridge vlan_filtering 1 \
+		vlan_default_pvid 0 mcast_snooping 1 mcast_vlan_snooping 1
+	ip -n "$NS" link set dev br0 up
+
+	ip -n "$NS" link add name dummy0 type dummy
+	ip -n "$NS" link set dev dummy0 master br0
+	ip -n "$NS" link set dev dummy0 up
+}
+
+vlan_range_neigh_suppress()
+{
+	RET=0
+
+	# Add two new consecutive VLANs for range grouping test
+	bridge -n "$NS" vlan add vid 10 dev dummy0
+	defer bridge -n "$NS" vlan del vid 10 dev dummy0
+
+	bridge -n "$NS" vlan add vid 11 dev dummy0
+	defer bridge -n "$NS" vlan del vid 11 dev dummy0
+
+	# Configure different neigh_suppress values and verify no range grouping
+	bridge -n "$NS" vlan set vid 10 dev dummy0 neigh_suppress on
+	check_err $? "Failed to set neigh_suppress for VLAN 10"
+
+	bridge -n "$NS" vlan set vid 11 dev dummy0 neigh_suppress off
+	check_err $? "Failed to set neigh_suppress for VLAN 11"
+
+	# Verify VLANs are not shown as a range, but individual entries exist
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -q "10-11"
+	check_fail $? "VLANs with different neigh_suppress incorrectly grouped"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -Eq "^\S+\s+10$|^\s+10$"
+	check_err $? "VLAN 10 individual entry not found"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -Eq "^\S+\s+11$|^\s+11$"
+	check_err $? "VLAN 11 individual entry not found"
+
+	# Configure same neigh_suppress value and verify range grouping
+	bridge -n "$NS" vlan set vid 11 dev dummy0 neigh_suppress on
+	check_err $? "Failed to set neigh_suppress for VLAN 11"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -q "10-11"
+	check_err $? "VLANs with same neigh_suppress not grouped"
+
+	log_test "VLAN range grouping with neigh_suppress"
+}
+
+vlan_range_mcast_max_groups()
+{
+	RET=0
+
+	# Add two new consecutive VLANs for range grouping test
+	bridge -n "$NS" vlan add vid 10 dev dummy0
+	defer bridge -n "$NS" vlan del vid 10 dev dummy0
+
+	bridge -n "$NS" vlan add vid 11 dev dummy0
+	defer bridge -n "$NS" vlan del vid 11 dev dummy0
+
+	# Configure different mcast_max_groups values and verify no range grouping
+	bridge -n "$NS" vlan set vid 10 dev dummy0 mcast_max_groups 100
+	check_err $? "Failed to set mcast_max_groups for VLAN 10"
+
+	bridge -n "$NS" vlan set vid 11 dev dummy0 mcast_max_groups 200
+	check_err $? "Failed to set mcast_max_groups for VLAN 11"
+
+	# Verify VLANs are not shown as a range, but individual entries exist
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -q "10-11"
+	check_fail $? "VLANs with different mcast_max_groups incorrectly grouped"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -Eq "^\S+\s+10$|^\s+10$"
+	check_err $? "VLAN 10 individual entry not found"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -Eq "^\S+\s+11$|^\s+11$"
+	check_err $? "VLAN 11 individual entry not found"
+
+	# Configure same mcast_max_groups value and verify range grouping
+	bridge -n "$NS" vlan set vid 11 dev dummy0 mcast_max_groups 100
+	check_err $? "Failed to set mcast_max_groups for VLAN 11"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -q "10-11"
+	check_err $? "VLANs with same mcast_max_groups not grouped"
+
+	log_test "VLAN range grouping with mcast_max_groups"
+}
+
+vlan_range_mcast_n_groups()
+{
+	RET=0
+
+	# Add two new consecutive VLANs for range grouping test
+	bridge -n "$NS" vlan add vid 10 dev dummy0
+	defer bridge -n "$NS" vlan del vid 10 dev dummy0
+
+	bridge -n "$NS" vlan add vid 11 dev dummy0
+	defer bridge -n "$NS" vlan del vid 11 dev dummy0
+
+	# Add different numbers of multicast groups to each VLAN
+	bridge -n "$NS" mdb add dev br0 port dummy0 grp 239.1.1.1 vid 10
+	check_err $? "Failed to add mdb entry to VLAN 10"
+	defer bridge -n "$NS" mdb del dev br0 port dummy0 grp 239.1.1.1 vid 10
+
+	bridge -n "$NS" mdb add dev br0 port dummy0 grp 239.1.1.2 vid 10
+	check_err $? "Failed to add second mdb entry to VLAN 10"
+	defer bridge -n "$NS" mdb del dev br0 port dummy0 grp 239.1.1.2 vid 10
+
+	bridge -n "$NS" mdb add dev br0 port dummy0 grp 239.1.1.1 vid 11
+	check_err $? "Failed to add mdb entry to VLAN 11"
+	defer bridge -n "$NS" mdb del dev br0 port dummy0 grp 239.1.1.1 vid 11
+
+	# Verify VLANs are not shown as a range due to different mcast_n_groups
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -q "10-11"
+	check_fail $? "VLANs with different mcast_n_groups incorrectly grouped"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -Eq "^\S+\s+10$|^\s+10$"
+	check_err $? "VLAN 10 individual entry not found"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -Eq "^\S+\s+11$|^\s+11$"
+	check_err $? "VLAN 11 individual entry not found"
+
+	# Add another group to VLAN 11 to match VLAN 10's count
+	bridge -n "$NS" mdb add dev br0 port dummy0 grp 239.1.1.2 vid 11
+	check_err $? "Failed to add second mdb entry to VLAN 11"
+	defer bridge -n "$NS" mdb del dev br0 port dummy0 grp 239.1.1.2 vid 11
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -q "10-11"
+	check_err $? "VLANs with same mcast_n_groups not grouped"
+
+	log_test "VLAN range grouping with mcast_n_groups"
+}
+
+vlan_range_mcast_enabled()
+{
+	RET=0
+
+	# Add two new consecutive VLANs for range grouping test
+	bridge -n "$NS" vlan add vid 10 dev br0 self
+	defer bridge -n "$NS" vlan del vid 10 dev br0 self
+
+	bridge -n "$NS" vlan add vid 11 dev br0 self
+	defer bridge -n "$NS" vlan del vid 11 dev br0 self
+
+	bridge -n "$NS" vlan add vid 10 dev dummy0
+	defer bridge -n "$NS" vlan del vid 10 dev dummy0
+
+	bridge -n "$NS" vlan add vid 11 dev dummy0
+	defer bridge -n "$NS" vlan del vid 11 dev dummy0
+
+	# Configure different mcast_snooping for bridge VLANs
+	# Port VLANs inherit BR_VLFLAG_MCAST_ENABLED from bridge VLANs
+	bridge -n "$NS" vlan global set dev br0 vid 10 mcast_snooping 1
+	bridge -n "$NS" vlan global set dev br0 vid 11 mcast_snooping 0
+
+	# Verify port VLANs are not grouped due to different mcast_enabled
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -q "10-11"
+	check_fail $? "VLANs with different mcast_enabled incorrectly grouped"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -Eq "^\S+\s+10$|^\s+10$"
+	check_err $? "VLAN 10 individual entry not found"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -Eq "^\S+\s+11$|^\s+11$"
+	check_err $? "VLAN 11 individual entry not found"
+
+	# Configure same mcast_snooping and verify range grouping
+	bridge -n "$NS" vlan global set dev br0 vid 11 mcast_snooping 1
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -q "10-11"
+	check_err $? "VLANs with same mcast_enabled not grouped"
+
+	log_test "VLAN range grouping with mcast_enabled"
+}
+
+# Verify the newest tested option is supported
+if ! bridge vlan help 2>&1 | grep -q "neigh_suppress"; then
+	echo "SKIP: iproute2 too old, missing per-VLAN neighbor suppression support"
+	exit "$ksft_skip"
+fi
+
+trap defer_scopes_cleanup EXIT
+setup_prepare
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.51.0


