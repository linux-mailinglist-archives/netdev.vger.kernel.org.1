Return-Path: <netdev+bounces-283563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM3iKzH79mmlawIAu9opvQ
	(envelope-from <netdev+bounces-283563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:37:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A51A4B4C15
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64875300789C
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 07:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A413A873C;
	Sun,  3 May 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A3Ebdaru"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492820E023;
	Sun,  3 May 2026 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793829; cv=fail; b=qQi6wjKZRmQvj8ygFjfuXTehiLGuLNyOoIG2lWupvd96N7JmqbIa0G2pdMC+SM4yLkrrcxUm1LHcE0vdrPHJNEmHxMX/J168gMNnSHP3PRigTWVDE1Lb/EqL76/xgXeS8/RepBA1ycSw490N+YjJdC7OTj3LwDGXX3b82s7emjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793829; c=relaxed/simple;
	bh=sSHMRoIUY4YQRH+czxdr6E5IQIg0avjYqmoV5eSCWJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssZR/u/HkBHPAhkjhSNw/hJKOHTHwgOpt6nfmrz5dDDUtoVaaTbaQ05PtYJQHgxZZnDv6Xj1meTujeGxyzelq7oFmwEJPbU9vBrGae/7XT/n9tAad434PEpmmm6Cne5dKoB+HkOgPNiLkt5xzF1LsRx59TDcS9DNAIUv/lLtq9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A3Ebdaru; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdvYebEWZQmOCKOItkd724ZCNH0vXBtP0iD2Zj3SZXKmPs4gR9uXZisMwrqObJlaS8TZF4QgasGO9meyEj5uaPdSuRBDRegQscAQDD+JeF9nUXnPK5NsEu+4H71jh5XL41znQxl9cVpvSYA/ZJvB2CtcXApXmMzDoO7dcSlmBW61i4D59OaFFZsDEw08KjVW6R6KPPA6Ou6CYVKEYjFARUrE8luTYjDb48v3375s19TIoP37hmk9gN9NvTajznwcd1nskFmTyjOXkqhKgm553DgRH1NHsiizPXVSn6suilQnQJzJDxMIyakd2GgJCuTrhduB0Oq2eT8sFEGjFa0G+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNVKcAPdnNWevYqpXl6VpO3LXZJmitE1iYi3r/0wXLk=;
 b=i4vi1q76TqcwzEqGHYhW+L2LXYc/tAqaiccWpsFNAMjPD7OAsOaQQKf2Lj0HfcQxkAj1hdubGs99LBY9KoojHqB+nCkNzJgpHYKRkO4B7l86w7QMy9JuQlTWxWSxHVmk1+vrm8zVEsNILSGq2EwFrYkVBs6URvcMq9RXbp7Bj0y5vrKk0d3tCD/rppakY3zfEutspXokMgfUD994xFaIJFhLNcFruDYfpCjfHzpyHSrvK7co+VavKQDMiJY/T4p9b0kYcTGiQ7GEtAWynzcVm+zgJHC+zlxP1GgtFfeREyVRkbOW1ykALCMcauVH0dUoh5RHQwT6MaSjveTQV2+EZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNVKcAPdnNWevYqpXl6VpO3LXZJmitE1iYi3r/0wXLk=;
 b=A3EbdaruFvBh88KrKpaa//xsPi/rsh652Fl0dTvhqoLJFD6NsDm747yipAOfxn4XEC1SaxdqLmo2k5la27TPFmN3EjJ7RKaqklY9aMv2TZ3XyJJ7+spXVCGWWafnCO53xx2itmTSuN0BSax6TuZaz3CAxFbBovXrD/NEl1y8jRCfDWgmEdTwsd4yZzRetLR2oEjQbVCfi8v0hgNm1nhY5VERPVJKJc/MLHiy3KPwViEVaXGUYnTnd+voOwMzczsdGeMEuTVa0ee2iYKBQAo+LjZd40D/WG7ka8p9U0bsMjUOFF5VrCa/bCagKcXohzypFU7n4FtgK3KWejs+TbsyCQ==
Received: from SJ0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:a03:333::17)
 by PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sun, 3 May
 2026 07:36:59 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::2f) by SJ0PR03CA0102.outlook.office365.com
 (2603:10b6:a03:333::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.24 via Frontend Transport; Sun,
 3 May 2026 07:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 07:36:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 00:36:39 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 00:36:33 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <donald.hunter@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<razor@blackwall.org>, <idosch@nvidia.com>, <andrew+netdev@lunn.ch>,
	<shuah@kernel.org>, <ast@fiberby.net>, <liuhangbin@gmail.com>,
	<daniel@iogearbox.net>, <aroulin@nvidia.com>, <fmaurer@redhat.com>,
	<sdf.kernel@gmail.com>, <sd@queasysnail.net>, <kees@kernel.org>,
	<nickgarlis@gmail.com>, <amorenoz@redhat.com>, <alasdair@mcwilliam.dev>,
	<johannes.wiesboeck@aisec.fraunhofer.de>, <petrm@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 6/6] selftests: net: Add tests for neigh_forward_grat option
Date: Sun, 3 May 2026 10:35:32 +0300
Message-ID: <20260503073532.2138165-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503073532.2138165-1-danieller@nvidia.com>
References: <20260503073532.2138165-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|PH7PR12MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1234f5-2a81-4004-3c0d-08dea8e6c280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fZ7iZMMzBXm35GrsJSTznukY1NXRzVNq6PjQzEzOGIVDT7haZ+eo/FV5WAA206lFB3RhiWTMI2+Vn8xTK4zHrST6suZJhuZTX70TDPPyMHLSaZ/Cf0qwccQPbxPesg3GWtXG5kIurlNbrkk4++LGdbIfLvmzl3JfRsMc3ZZW2gNU42oIv/IlNxM7gooJmFsmkAAMekpnEt9qwJ65lhwpztZnIJh1eKnVbSL+xG0Berm9XmJl67aiqpqKvryJLNdrch+8uD3TRhGefuYCYJv0DDqEIft1hfWo/fSJ1fMbAFZZfvGPAMr1f+pWWnMv/y8flUDRBhTulwCaEbwlkVT4QRKWNoRhMTZiX91gcS5R9xmvfjr1zqRw1b9wjjw5UhYHBYzEtEZbO8IKiISomrMNCrxhoonucY6lVMXdk+1N9g1mlQUO2eQa094HZChcgzOFVCG/Qtmw0IRB5+tY3HWIODC2/yBrf/4Mv9Av7rUjD6+ttOxl9e/DSzukR+lh1sbj10Ag5ORTnLixF4L0XKP4KRKcnyK9TPveHj/aDhhbr9bIQZ1/c1RlJXT1jIQ80ZXxZvlvydvRulM8Ukl66yI64HB30CFuEJLvHf1pCpsAyrRDcXXfVDo6Z2deaB/UxWhrXHPBBUEGzfB9xV2Coc7IVGTv367rF6m3sqzsFbDBje2MrxEw707LJtfoeIrmbi47b6eGkvz7XljguLqcU3xWxJQ7sZvfcn8XgWB4Xr/a4i4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EjRUCaXaNkWzGuQ+AObSeGbKLScg8W1FHTrp4vQl3U7SNpd9LnNr0Jzn5mb+7DGmy2MPV1sjtQ4pyLwQDsHT8TJbN+Kh3I0bhp0coh4io1xo5X1Eg3hDRjRz4J8zRHicwCIHY0l9iBddDQWh0SV3dT9ewqJFq1C7bf287+whfnK07n6Voh1ZZdL3SooF/JjIC0ap2DTIRo2qR+G3srItdEu7Pd7SaJO2+rFQaa787vR35cBRVEahJUviy+i5utq51f0jJlgtXvasf9fnH4+GWJM6ZmsMFVZ1rMn2FchHnIhGCILOO+sAbn19JkIxYRR1KfCMlYMvLqSw0CI2qao0Tj7eGnIbobufFz1Ini8ZqYCnchXtyCG1QHmc3/3KtfYUrFrXcq2MN5clxphB3MYOGDCXbcnSRwtFQqAMyr/FKuDwIq/uLuoXSrOZSFa9eH96
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 07:36:59.1220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1234f5-2a81-4004-3c0d-08dea8e6c280
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492
X-Rspamd-Queue-Id: 4A51A4B4C15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283563-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

Add tests to validate the neigh_forward_grat bridge option for selective
forwarding of gratuitous neighbor announcements.

The tests verify per-port and per-VLAN control of gratuitous neighbor
announcement forwarding for both IPv4 (gratuitous ARP) and IPv6
(unsolicited NA):
- When neigh_suppress is enabled with neigh_forward_grat off (default),
  gratuitous announcements are suppressed
- When neigh_forward_grat is enabled, gratuitous announcements are
  forwarded while regular neighbor discovery remains suppressed

For IPv4, use arping to send gratuitous ARP packets. For IPv6, use
mausezahn to craft unsolicited Neighbor Advertisement packets.

For the per-port tests, the IPv4 test exercises the ip link interface,
while the IPv6 test exercises the bridge link interface.
The per-VLAN tests use the bridge interface throughout, as per-VLAN
attributes are only accessible via 'bridge vlan'.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/test_bridge_neigh_suppress.sh         | 298 +++++++++++++++++-
 1 file changed, 296 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
index 4bc92078e173..67d0c773e6a6 100755
--- a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
+++ b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
@@ -58,6 +58,10 @@ TESTS="
 	neigh_vlan_suppress_ns
 	neigh_suppress_arp_probe
 	neigh_suppress_dad_ns
+	neigh_forward_grat_arp
+	neigh_forward_grat_na
+	neigh_vlan_forward_grat_arp
+	neigh_vlan_forward_grat_na
 "
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -76,7 +80,8 @@ log_test()
 		printf "TEST: %-60s  [ OK ]\n" "${msg}"
 		nsuccess=$((nsuccess+1))
 	else
-		ret=1
+		# shellcheck disable=SC2154
+		ret=$(ksft_exit_status_merge "$ret" "$ksft_fail")
 		nfail=$((nfail+1))
 		printf "TEST: %-60s  [FAIL]\n" "${msg}"
 		if [ "$VERBOSE" = "1" ]; then
@@ -99,6 +104,7 @@ log_test()
 	fi
 
 	[ "$VERBOSE" = "1" ] && echo
+	return 0
 }
 
 run_cmd()
@@ -136,6 +142,15 @@ tc_check_packets()
 	[[ $pkts == $count ]]
 }
 
+neigh_forward_grat_check()
+{
+	if ! bridge link help 2>&1 | grep -q "neigh_forward_grat"; then
+		echo "SKIP: iproute2 bridge too old, missing gratuitous ARP/unsolicited NA forwarding control support"
+		# shellcheck disable=SC2154
+		return "$ksft_skip"
+	fi
+}
+
 ################################################################################
 # Setup
 
@@ -563,6 +578,17 @@ icmpv6_header_get()
 	echo $p
 }
 
+icmpv6_na_header_get()
+{
+	local csum=$1; shift
+	local tip=$1; shift
+
+	# Type 136 (Neighbor Advertisement), hex format, Override flag set,
+	# Solicited flag clear (unsolicited NA).
+	# ICMPv6.type : ICMPv6.code : ICMPv6.checksum : Flags : Target Address
+	echo "88:00:$csum:20:00:00:00:$tip:"
+}
+
 neigh_suppress_uc_ns_common()
 {
 	local vid=$1; shift
@@ -1001,6 +1027,271 @@ neigh_suppress_dad_ns()
 	log_test $? 0 "DAD NS suppression"
 }
 
+neigh_forward_grat_arp()
+{
+	local vid=10
+	local sip=192.0.2.1
+	local tip=$sip
+	local h2_mac
+
+	neigh_forward_grat_check || return $?
+
+	echo
+	echo "Gratuitous ARP forwarding"
+	echo "-------------------------"
+
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto 0x0806 flower indev swp1 arp_tip $tip arp_sip $sip arp_op request action pass"
+
+	h2_mac=$(ip -n "$h2" -j -p link show eth0."$vid" | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
+	run_cmd "ip -n $sw1 neigh replace $tip lladdr $h2_mac nud permanent dev br0.$vid"
+
+	# Enable neighbor suppression. Gratuitous ARP should be suppressed by
+	# default (neigh_forward_grat defaults to off).
+	run_cmd "ip -n $sw1 link set dev vx0 type bridge_slave neigh_suppress on"
+	run_cmd "ip -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	log_test $? 0 "\"neigh_suppress\" is on"
+
+	# Send gratuitous ARP (sip == tip) and check it's suppressed.
+	run_cmd "ip netns exec $h1 arping -U -c 1 -w 5 -I eth0.$vid $tip"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 0
+	log_test $? 0 "Gratuitous ARP suppression"
+
+	# Explicitly enable neigh_forward_grat and verify gratuitous ARP is
+	# now forwarded.
+	run_cmd "ip -n $sw1 link set dev vx0 type bridge_slave neigh_forward_grat on"
+	run_cmd "ip -n $sw1 -d link show dev vx0 | grep \"neigh_forward_grat on\""
+	log_test $? 0 "\"neigh_forward_grat\" is on"
+
+	run_cmd "ip netns exec $h1 arping -U -c 1 -w 5 -I eth0.$vid $tip"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 1
+	log_test $? 0 "Gratuitous ARP forwarding"
+
+	# Disable neigh_forward_grat and verify suppression resumes.
+	run_cmd "ip -n $sw1 link set dev vx0 type bridge_slave neigh_forward_grat off"
+	run_cmd "ip -n $sw1 -d link show dev vx0 | grep \"neigh_forward_grat off\""
+	log_test $? 0 "\"neigh_forward_grat\" is off"
+
+	run_cmd "ip netns exec $h1 arping -U -c 1 -w 5 -I eth0.$vid $tip"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 1
+	log_test $? 0 "Gratuitous ARP suppression"
+}
+
+# neigh_forward_grat_arp() uses 'ip link' interface, and neigh_forward_grat_na()
+# uses 'bridge link' interface to exercise both paths.
+neigh_forward_grat_na()
+{
+	local vid=10
+	local saddr=2001:db8:1::1
+	local daddr=ff02::1
+	local full_addr=20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:01
+	local csum="fd:32"
+	local dmac=33:33:00:00:00:01
+	local h2_mac
+	local smac
+
+	neigh_forward_grat_check || return $?
+
+	echo
+	echo "Unsolicited NA forwarding"
+	echo "-------------------------"
+
+	smac=$(ip -n "$h1" -j -p link show eth0."$vid" | jq -r '.[]["address"]')
+
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $daddr src_ip $saddr type 136 code 0 action pass"
+
+	h2_mac=$(ip -n "$h2" -j -p link show eth0."$vid" | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
+	run_cmd "ip -n $sw1 neigh replace $saddr lladdr $h2_mac nud permanent dev br0.$vid"
+
+	# Enable neighbor suppression. Unsolicited NA should be suppressed by
+	# default (neigh_forward_grat defaults to off).
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	log_test $? 0 "\"neigh_suppress\" is on"
+
+	# Send unsolicited NA and check it's suppressed.
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid -c 1 -a $smac -b $dmac -A $saddr -B $daddr -t ip hop=255,next=58,payload=$(icmpv6_na_header_get "$csum" "$full_addr") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 0
+	log_test $? 0 "Unsolicited NA suppression"
+
+	# Explicitly enable neigh_forward_grat and verify unsolicited NA is
+	# now forwarded.
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_forward_grat on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_forward_grat on\""
+	log_test $? 0 "\"neigh_forward_grat\" is on"
+
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid -c 1 -a $smac -b $dmac -A $saddr -B $daddr -t ip hop=255,next=58,payload=$(icmpv6_na_header_get "$csum" "$full_addr") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 1
+	log_test $? 0 "Unsolicited NA forwarding"
+
+	# Disable neigh_forward_grat and verify suppression resumes.
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_forward_grat off"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_forward_grat off\""
+	log_test $? 0 "\"neigh_forward_grat\" is off"
+
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid -c 1 -a $smac -b $dmac -A $saddr -B $daddr -t ip hop=255,next=58,payload=$(icmpv6_na_header_get "$csum" "$full_addr") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 1
+	log_test $? 0 "Unsolicited NA suppression"
+}
+
+neigh_vlan_forward_grat_arp()
+{
+	local vid1=10
+	local vid2=20
+	local sip1=192.0.2.1
+	local sip2=192.0.2.17
+	local h2_mac1
+	local h2_mac2
+
+	neigh_forward_grat_check || return $?
+
+	echo
+	echo "Per-VLAN gratuitous ARP forwarding"
+	echo "----------------------------------"
+
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto 0x0806 flower indev swp1 arp_tip $sip1 arp_sip $sip1 arp_op request action pass"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 102 proto 0x0806 flower indev swp1 arp_tip $sip2 arp_sip $sip2 arp_op request action pass"
+
+	h2_mac1=$(ip -n "$h2" -j -p link show eth0."$vid1" | jq -r '.[]["address"]')
+	h2_mac2=$(ip -n "$h2" -j -p link show eth0."$vid2" | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac1 dev vx0 master static vlan $vid1"
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac2 dev vx0 master static vlan $vid2"
+	run_cmd "ip -n $sw1 neigh replace $sip1 lladdr $h2_mac1 nud permanent dev br0.$vid1"
+	run_cmd "ip -n $sw1 neigh replace $sip2 lladdr $h2_mac2 nud permanent dev br0.$vid2"
+
+	# Enable per-{Port, VLAN} neighbor suppression.
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_vlan_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress on\""
+	log_test $? 0 "\"neigh_vlan_suppress\" is on"
+
+	# Enable neighbor suppression on VLAN 10. Gratuitous ARP should be
+	# suppressed by default on VLAN 10 (neigh_forward_grat defaults to off)
+	# but not on VLAN 20.
+	run_cmd "bridge -n $sw1 vlan set vid $vid1 dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress on\""
+	log_test $? 0 "\"neigh_suppress\" is on (VLAN $vid1)"
+
+	run_cmd "ip netns exec $h1 arping -U -c 1 -w 5 -I eth0.$vid1 $sip1"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 0
+	log_test $? 0 "Gratuitous ARP suppression (VLAN $vid1)"
+
+	run_cmd "ip netns exec $h1 arping -U -c 1 -w 5 -I eth0.$vid2 $sip2"
+	tc_check_packets "$sw1" "dev vx0 egress" 102 1
+	log_test $? 0 "Gratuitous ARP forwarding (VLAN $vid2)"
+
+	# Enable neigh_forward_grat on VLAN 10 and verify gratuitous ARP is
+	# now forwarded.
+	run_cmd "bridge -n $sw1 vlan set vid $vid1 dev vx0 neigh_forward_grat on"
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_forward_grat on\""
+	log_test $? 0 "\"neigh_forward_grat\" is on (VLAN $vid1)"
+
+	run_cmd "ip netns exec $h1 arping -U -c 1 -w 5 -I eth0.$vid1 $sip1"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 1
+	log_test $? 0 "Gratuitous ARP forwarding (VLAN $vid1)"
+
+	# Enable neighbor suppression on VLAN 20 (neigh_forward_grat defaults to
+	# off), and verify gratuitous ARP is suppressed on VLAN 20.
+	run_cmd "bridge -n $sw1 vlan set vid $vid2 dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid2 | grep \"neigh_suppress on\""
+	log_test $? 0 "\"neigh_suppress\" is on (VLAN $vid2)"
+
+	# VLAN 10 should still forward (neigh_forward_grat is on).
+	run_cmd "ip netns exec $h1 arping -U -c 1 -w 5 -I eth0.$vid1 $sip1"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 2
+	log_test $? 0 "Gratuitous ARP forwarding (VLAN $vid1)"
+
+	# VLAN 20 should suppress (neigh_forward_grat defaults to off).
+	run_cmd "ip netns exec $h1 arping -U -c 1 -w 5 -I eth0.$vid2 $sip2"
+	tc_check_packets "$sw1" "dev vx0 egress" 102 1
+	log_test $? 0 "Gratuitous ARP suppression (VLAN $vid2)"
+}
+
+neigh_vlan_forward_grat_na()
+{
+	local vid1=10
+	local vid2=20
+	local saddr1=2001:db8:1::1
+	local daddr=ff02::1
+	local full_addr1=20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:01
+	local csum1="fd:32"
+	local saddr2=2001:db8:2::1
+	local full_addr2=20:01:0d:b8:00:02:00:00:00:00:00:00:00:00:00:01
+	local csum2="fd:30"
+	local dmac=33:33:00:00:00:01
+	local h2_mac1
+	local h2_mac2
+	local smac
+
+	neigh_forward_grat_check || return $?
+
+	echo
+	echo "Per-VLAN unsolicited NA forwarding"
+	echo "----------------------------------"
+
+	smac=$(ip -n "$h1" -j -p link show eth0."$vid1" | jq -r '.[]["address"]')
+
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $daddr src_ip $saddr1 type 136 code 0 action pass"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 102 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $daddr src_ip $saddr2 type 136 code 0 action pass"
+
+	h2_mac1=$(ip -n "$h2" -j -p link show eth0."$vid1" | jq -r '.[]["address"]')
+	h2_mac2=$(ip -n "$h2" -j -p link show eth0."$vid2" | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac1 dev vx0 master static vlan $vid1"
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac2 dev vx0 master static vlan $vid2"
+	run_cmd "ip -n $sw1 neigh replace $saddr1 lladdr $h2_mac1 nud permanent dev br0.$vid1"
+	run_cmd "ip -n $sw1 neigh replace $saddr2 lladdr $h2_mac2 nud permanent dev br0.$vid2"
+
+	# Enable per-{Port, VLAN} neighbor suppression.
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_vlan_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress on\""
+	log_test $? 0 "\"neigh_vlan_suppress\" is on"
+
+	# Enable neighbor suppression on VLAN 10. Unsolicited NA should be
+	# suppressed by default on VLAN 10 (neigh_forward_grat defaults to off)
+	# but not on VLAN 20.
+	run_cmd "bridge -n $sw1 vlan set vid $vid1 dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress on\""
+	log_test $? 0 "\"neigh_suppress\" is on (VLAN $vid1)"
+
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid1 -c 1 -a $smac -b $dmac -A $saddr1 -B $daddr -t ip hop=255,next=58,payload=$(icmpv6_na_header_get "$csum1" "$full_addr1") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 0
+	log_test $? 0 "Unsolicited NA suppression (VLAN $vid1)"
+
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid2 -c 1 -a $smac -b $dmac -A $saddr2 -B $daddr -t ip hop=255,next=58,payload=$(icmpv6_na_header_get "$csum2" "$full_addr2") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 102 1
+	log_test $? 0 "Unsolicited NA forwarding (VLAN $vid2)"
+
+	# Enable neigh_forward_grat on VLAN 10 and verify unsolicited NA is
+	# now forwarded.
+	run_cmd "bridge -n $sw1 vlan set vid $vid1 dev vx0 neigh_forward_grat on"
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_forward_grat on\""
+	log_test $? 0 "\"neigh_forward_grat\" is on (VLAN $vid1)"
+
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid1 -c 1 -a $smac -b $dmac -A $saddr1 -B $daddr -t ip hop=255,next=58,payload=$(icmpv6_na_header_get "$csum1" "$full_addr1") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 1
+	log_test $? 0 "Unsolicited NA forwarding (VLAN $vid1)"
+
+	# Enable neighbor suppression on VLAN 20 (neigh_forward_grat defaults to
+	# off), and verify unsolicited NA is suppressed on VLAN 20.
+	run_cmd "bridge -n $sw1 vlan set vid $vid2 dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid2 | grep \"neigh_suppress on\""
+	log_test $? 0 "\"neigh_suppress\" is on (VLAN $vid2)"
+
+	# VLAN 10 should still forward (neigh_forward_grat is on).
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid1 -c 1 -a $smac -b $dmac -A $saddr1 -B $daddr -t ip hop=255,next=58,payload=$(icmpv6_na_header_get "$csum1" "$full_addr1") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 101 2
+	log_test $? 0 "Unsolicited NA forwarding (VLAN $vid1)"
+
+	# VLAN 20 should suppress (neigh_forward_grat defaults to off).
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid2 -c 1 -a $smac -b $dmac -A $saddr2 -B $daddr -t ip hop=255,next=58,payload=$(icmpv6_na_header_get "$csum2" "$full_addr2") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 102 1
+	log_test $? 0 "Unsolicited NA suppression (VLAN $vid2)"
+}
+
 ################################################################################
 # Usage
 
@@ -1087,7 +1378,10 @@ cleanup
 
 for t in $TESTS
 do
-	setup; $t; cleanup;
+	setup
+	$t
+	ret=$(ksft_exit_status_merge "$ret" $?)
+	cleanup
 done
 
 if [ "$TESTS" != "none" ]; then
-- 
2.51.0


