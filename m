Return-Path: <netdev+bounces-282241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBQ9AI6k8WnxjAEAu9opvQ
	(envelope-from <netdev+bounces-282241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:26:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C54748FBDE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07E67303101F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC3138BF96;
	Wed, 29 Apr 2026 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="atO/V2r4"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85C37999D;
	Wed, 29 Apr 2026 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443905; cv=fail; b=BrQScYcOWN5dj2b3yQMA8xlrC9KPQs0DTmR82NT4VudNy2oFFTlYNsivwdzDF+iP/PzTdL0UgUUx2jNizaHQvuGmDNYkjNJphghM5gzea8lfnq2bqc3xUp/Swwa48YjwL3FWs2DrNP3Er9ffJYtKkkcwvw1pZmuTxnR3Ecg9IWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443905; c=relaxed/simple;
	bh=trkMJtlvFx/Na/tZUSCceot+wR8HIBcVZ/V6mC4rz8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsGlZAVev+XJnskPg3rvdX2Jq67kjVLHsIdEsBJZiSqln9zdQ/hkao61I6hmdaQ2vxvKpZm1Qn5Xzw8EdS/8HHO263b1tzgWcag5SZi5BtP/cZYBa5ZZRHeYpCSmUKBW7mnKJQsBXzYgm9B51zlvVmjOPOa2oxvtH3nOKAO7oDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=atO/V2r4; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzvojfJM/StfDs4vrcCTELrr2wZ4mnhlYWwOp17wEtiCDO0czwT/g0wgv1vWGrLYBM0jFOU70RrY0G/GUwjlzi9xpWH2X12p+c5Wf4f6o0B5nRXSgButQo6/fSHo23Bq/JXpb6CKCtDX5vD53rKKQJ7FOYNut4lBJhsuOYtryIszO94JKtNv+f52T725EagueUgE+nWvYrCFr6JgOlDrA+f739BUavf/H2VYa3QXGfrZ58Fof6yQ+OG87yo9SnPrSNOrBGQ2du6OOHEH7EHl+D58RrZwfxnlpE+AQS/IVWCelbx4KleIcpLCACHUi+A36W5qI2s79UUn41rlFEhE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvIgL0kCtcPlgXfQClPHlYdaacIvlKPgTGUVTAxePio=;
 b=l4npPiLnSorf5cTiVTCNl3zsvYuAk5zIKtVQSoVnj2Z/ZXswyqHMfyyf8z0xR12mfbiGdYC3pslgUkfi5yByqjUmj6VaQLu/RFJEiBpjhYFnYylxMq24tArPoSx+wKeU0q/+vvTFUnzcCNfdGbMm5X/w20sJwRRZJAyLPJ04h9MgjSk2DIaTyUSvc4x7c0dZt5Gwp8CwUMePBccVVEWL6eMSlirmvLxZ4meflJYu6oXMHnquepoTSjgZ8uA6UuhMPPEPV3x3fw96wNjM2gjYu18XlLShwF1r6cAks4Vtx4WChRQYZO8psNWBSBMBkO/xFSYW1YQTK6N7B7K3FhmDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvIgL0kCtcPlgXfQClPHlYdaacIvlKPgTGUVTAxePio=;
 b=atO/V2r4LAyTZ378xO1PdTkLZjDHeJNby8Ni43jaHboqXg+w0NvBzwvNyYo0wEehQEQGjR9C+35XmMed9dPI3crJ+zUXEf/qGVNw77azGyQHoKwq3SS6+YSEiAqRUT5N0IJVDKY5Vx8sfcsOEqm+rbY9kKSCHU8OoLuwPk91G+HYFqEH8Rj5EP6ermg6wVgAijC01m4+xCS437FubVkFMYSDPuovXveL5Y0rUK+Wx6W7iTxoiRLF3QXdutEj3Xh0bv8w+pgGLw9CdgMDacq4IYERoc4HAvdK0cb2tucYifHKPzWmg2PmjV+9QG4GojXJb9avG2MrbBlko1eqhIEPIA==
Received: from DM6PR11CA0056.namprd11.prod.outlook.com (2603:10b6:5:14c::33)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Wed, 29 Apr
 2026 06:24:55 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::47) by DM6PR11CA0056.outlook.office365.com
 (2603:10b6:5:14c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 06:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 06:24:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 23:24:33 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Apr 2026 23:24:29 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <razor@blackwall.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <shuah@kernel.org>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH net-next 2/2] selftests: net: Add tests for ARP probe and DAD NS handling
Date: Wed, 29 Apr 2026 09:24:05 +0300
Message-ID: <20260429062405.1386417-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429062405.1386417-1-danieller@nvidia.com>
References: <20260429062405.1386417-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3b9dd3-cf08-4164-2fba-08dea5b807ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dso11fgnQVl8ufeZUFmSqeM3Hi6TnYyYBpV+aOTU4aEfOT4WZ7/5hN+8AubsU88oJLjD+gVkts0tboxAM/tc7LtA6DByYAKrhgPrdZunV1r6KUlxjQ7aE0S8CMY7Wnf9aX3RiriEkaka94QE2OtcXoaYZIAss48dP3PUjKAcfIZrgmaSMEMHJVzvYbdATSQSu0GIrmKiHivNfL6iiMRLMQaoagA4Tub0//keDyXMbc39wqRKxdTbtnuGSsMGvNnLwt7UcFMjaCt+DAMBXJhmZnI+yHBt1zjF6w5NwPcdGh4GNLfsJ5ZsUQar2z+hbhdNsQsOMuZU8yMjjI353HPAUBWefmwrWyvwnhfKwp8cXlsoKQlUdqwz2xstoeXzLBFMBkqH6Ud+Hi6HCy8Y7SuSSrBkENc4BRnF+9L9W2vj18PbB5o+sNAN4tCiYn+xq6iwgaVn3qHBH/1s/mMMLyjpEosVGB9nrevGFfGHXTixMl/4xIynzYRYbpFaXil1iR3W8jUEA0Jt7nQS5cuwweNR0VzQLKripv3fxpNCXwfy+mb7oXU2grbQpZT6/jX6KShYaGqW5VDE+5Bm5enSDAMZA1i22Kct7EWYOh98Vyc5gkd78gdB5O43BVdUoUT01KrlA9kMCKNEu5ar8eqpdZbKyd9pO0FVsXiYA8KHWcIhHr6M1CKso0wdajoxGxzdCdxWnZyvU5gC3aIz4gMRSVVPbliF3Lh3cY2+cxRlfk/bPvPVoheeLtafG1ShyCUYnKmanX/795oTjuRoY4ys4ifOTg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J62fT8jfe5CNLzdfh2bTccdluVwh986oEveDl9kh7DQR78Bw0F1PwMZb7JwZtOKBw8aPu/wiXB7TdQIj3AGcyCMrk/eONERo5gPsHNCsAelU9GKwiWTNO/JrCOim/m03DEX4cYbaAXjD7dppu4qBvgz1F2GmiZR3DB9A7N/xBxDlMw3ulzuB8ReU1DX86wL/BxynaW8+w0rVp6XVTzVumNo7bda04/KEWYTOStNMzTAN4lw8qAbOsYeAP+QN1gULmx7QR1b+62GOFrdb1yCHHyksFP4HNSv1Y/RE2++ONiTUjSXMGYpksHeURs1EH9niA8DLi83w8gL4Z/CS6ncB9etT/nBtdtz1D7wuY/geOO7Ui3CZ99wqBHjswMr1/js7jtaBUEBs7VOJ14wFQDpio7AJi5aisoLxy0s0AWtKs49KcbD36A8koxdp05oSGTht
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 06:24:55.5116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3b9dd3-cf08-4164-2fba-08dea5b807ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
X-Rspamd-Queue-Id: 4C54748FBDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282241-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

Add test cases to verify that ARP probes and DAD Neighbor Solicitations
are handled correctly by the bridge neighbor suppression feature.

When neighbor suppression is enabled on a bridge VXLAN port, the bridge
should reply to ARP/NS messages on behalf of remote hosts when both FDB
and neighbor entries exist, and the answer is known. However, when
either the FDB or the neighbor exists, ARP probes / DAD NS should be
treated like regular ARP requests / NS and flood to VXLAN.

Add two new test functions:

neigh_suppress_arp_probe(): Tests ARP probe handling by triggering
duplicate address detection using arping -D. Verifies that probes are
flooded when the bridge doesn't know the answer, and suppressed when FDB
and neighbor entries exist.

neigh_suppress_dad_ns(): Tests DAD NS handling by constructing DAD NS
packets using mausezahn and verifies correct flooding/suppression
behavior.

Before the previous patch:

$ ./test_bridge_neigh_suppress.sh -t "neigh_suppress_arp_probe neigh_suppress_dad_ns"

Per-port ARP probe suppression
------------------------------
TEST: ARP probe suppression                                         [ OK ]
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: ARP probe suppression                                         [FAIL]
TEST: FDB and neighbor entry installation                           [ OK ]
TEST: arping                                                        [FAIL]
TEST: ARP probe suppression                                         [FAIL]
TEST: neighbor removal                                              [ OK ]
TEST: ARP probe suppression                                         [FAIL]
TEST: "neigh_suppress" is off                                       [ OK ]
TEST: ARP probe suppression                                         [FAIL]

Per-port DAD NS suppression
---------------------------
TEST: DAD NS suppression                                            [ OK ]
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: DAD NS suppression                                            [FAIL]
TEST: FDB and neighbor entry installation                           [ OK ]
TEST: DAD NS suppression                                            [FAIL]
TEST: neighbor removal                                              [ OK ]
TEST: DAD NS suppression                                            [FAIL]
TEST: DAD NS proxy NA reply                                         [FAIL]
TEST: "neigh_suppress" is off                                       [ OK ]
TEST: DAD NS suppression                                            [FAIL]

Tests passed:   10
Tests failed:   10

After the previous patch:

$ ./test_bridge_neigh_suppress.sh -t "neigh_suppress_arp_probe neigh_suppress_dad_ns"

Per-port ARP probe suppression
------------------------------
TEST: ARP probe suppression                                         [ OK ]
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: ARP probe suppression                                         [ OK ]
TEST: FDB and neighbor entry installation                           [ OK ]
TEST: arping                                                        [ OK ]
TEST: ARP probe suppression                                         [ OK ]
TEST: neighbor removal                                              [ OK ]
TEST: ARP probe suppression                                         [ OK ]
TEST: "neigh_suppress" is off                                       [ OK ]
TEST: ARP probe suppression                                         [ OK ]

Per-port DAD NS suppression
---------------------------
TEST: DAD NS suppression                                            [ OK ]
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: DAD NS suppression                                            [ OK ]
TEST: FDB and neighbor entry installation                           [ OK ]
TEST: DAD NS suppression                                            [ OK ]
TEST: neighbor removal                                              [ OK ]
TEST: DAD NS suppression                                            [ OK ]
TEST: DAD NS proxy NA reply                                         [ OK ]
TEST: "neigh_suppress" is off                                       [ OK ]
TEST: DAD NS suppression                                            [ OK ]

Tests passed:  20
Tests failed:   0

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/test_bridge_neigh_suppress.sh         | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
index 9067197c9055..4bc92078e173 100755
--- a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
+++ b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
@@ -56,6 +56,8 @@ TESTS="
 	neigh_suppress_uc_ns
 	neigh_vlan_suppress_arp
 	neigh_vlan_suppress_ns
+	neigh_suppress_arp_probe
+	neigh_suppress_dad_ns
 "
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -875,6 +877,130 @@ neigh_vlan_suppress_ns()
 	log_test $? 0 "NS suppression (VLAN $vid2)"
 }
 
+neigh_suppress_arp_probe()
+{
+	local vid=10
+	local tip=192.0.2.2
+	local h2_mac
+
+	echo
+	echo "Per-port ARP probe suppression"
+	echo "------------------------------"
+
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto 0x0806 flower indev swp1 arp_tip $tip arp_sip 0.0.0.0 arp_op request action pass"
+
+	# Initial state - check that ARP probes are not suppressed.
+	run_cmd "ip netns exec $h1 arping -D -q -c 1 -w 5 -I eth0.$vid $tip"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 1
+	log_test $? 0 "ARP probe suppression"
+
+	# Enable neighbor suppression and check that nothing changes.
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	log_test $? 0 "\"neigh_suppress\" is on"
+
+	run_cmd "ip netns exec $h1 arping -D -q -c 1 -w 5 -I eth0.$vid $tip"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 2
+	log_test $? 0 "ARP probe suppression"
+
+	# Install FDB and a neighbor and check that ARP probes are suppressed.
+	h2_mac=$(ip -n "$h2" -j -p link show eth0."$vid" | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
+	run_cmd "ip -n $sw1 neigh replace $tip lladdr $h2_mac nud permanent dev br0.$vid"
+	log_test $? 0 "FDB and neighbor entry installation"
+
+	run_cmd "ip netns exec $h1 arping -D -q -c 1 -w 5 -I eth0.$vid $tip"
+	log_test $? 1 "arping"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 2
+	log_test $? 0 "ARP probe suppression"
+
+	# Remove the neighbor entry and check that ARP probes are not suppressed.
+	run_cmd "ip -n $sw1 neigh del $tip dev br0.$vid"
+	log_test $? 0 "neighbor removal"
+
+	run_cmd "ip netns exec $h1 arping -D -q -c 1 -w 5 -I eth0.$vid $tip"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 3
+	log_test $? 0 "ARP probe suppression"
+
+	# Disable neighbor suppression.
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress off"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
+	log_test $? 0 "\"neigh_suppress\" is off"
+
+	run_cmd "ip netns exec $h1 arping -D -q -c 1 -w 5 -I eth0.$vid $tip"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 4
+	log_test $? 0 "ARP probe suppression"
+}
+
+neigh_suppress_dad_ns()
+{
+	local vid=10
+	local tip=2001:db8:1::99
+	local mcast=ff02::1:ff00:99
+	local dmac=33:33:ff:00:00:99
+	local full_tip=20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:99
+	local csum="4b:bc"
+	local smac
+	local tmac
+
+	echo
+	echo "Per-port DAD NS suppression"
+	echo "---------------------------"
+
+	smac=$(ip -n "$h1" -j -p link show eth0."$vid" | jq -r '.[]["address"]')
+
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $mcast src_ip :: type 135 code 0 action pass"
+
+	# Initial state - check that DAD NS are not suppressed.
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid -c 1 -a $smac -b $dmac -A :: -B $mcast -t ip hop=255,next=58,payload=$(icmpv6_header_get "$csum" "$full_tip") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 1
+	log_test $? 0 "DAD NS suppression"
+
+	# Enable neighbor suppression and check that nothing changes.
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	log_test $? 0 "\"neigh_suppress\" is on"
+
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid -c 1 -a $smac -b $dmac -A :: -B $mcast -t ip hop=255,next=58,payload=$(icmpv6_header_get "$csum" "$full_tip") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 2
+	log_test $? 0 "DAD NS suppression"
+
+	# Install FDB and a neighbor and check that DAD NS are suppressed
+	# and that a proxy NA is sent back to h1.
+	tmac=$(ip -n "$h2" -j -p link show eth0."$vid" | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $tmac dev vx0 master static vlan $vid"
+	run_cmd "ip -n $sw1 -6 neigh replace $tip lladdr $tmac nud permanent dev br0.$vid"
+	log_test $? 0 "FDB and neighbor entry installation"
+
+	run_cmd "tc -n $h1 qdisc replace dev eth0.$vid clsact"
+	run_cmd "tc -n $h1 filter replace dev eth0.$vid ingress pref 1 handle 101 proto ipv6 flower ip_proto icmpv6 dst_ip ff02::1 src_ip $tip type 136 code 0 action pass"
+
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid -c 1 -a $smac -b $dmac -A :: -B $mcast -t ip hop=255,next=58,payload=$(icmpv6_header_get "$csum" "$full_tip") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 2
+	log_test $? 0 "DAD NS suppression"
+	tc_check_packets "$h1" "dev eth0.$vid ingress" 101 1
+	log_test $? 0 "DAD NS proxy NA reply"
+
+	# Remove the neighbor entry and check that DAD NS are not suppressed.
+	run_cmd "ip -n $sw1 -6 neigh del $tip dev br0.$vid"
+	log_test $? 0 "neighbor removal"
+
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid -c 1 -a $smac -b $dmac -A :: -B $mcast -t ip hop=255,next=58,payload=$(icmpv6_header_get "$csum" "$full_tip") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 3
+	log_test $? 0 "DAD NS suppression"
+
+	# Disable neighbor suppression.
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress off"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
+	log_test $? 0 "\"neigh_suppress\" is off"
+
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid -c 1 -a $smac -b $dmac -A :: -B $mcast -t ip hop=255,next=58,payload=$(icmpv6_header_get "$csum" "$full_tip") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 4
+	log_test $? 0 "DAD NS suppression"
+}
+
 ################################################################################
 # Usage
 
-- 
2.51.0


