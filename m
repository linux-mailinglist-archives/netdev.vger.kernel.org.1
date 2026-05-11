Return-Path: <netdev+bounces-286470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKqeA3d/AWqkbQEAu9opvQ
	(envelope-from <netdev+bounces-286470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:04:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EDE508D57
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE9D0303E239
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97643331218;
	Mon, 11 May 2026 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W7es/cLs"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE733101B2;
	Mon, 11 May 2026 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482878; cv=fail; b=HPcPbD1P5/iY4hh51QpvU2AWel5HiQW5fAJ2azC3y1NsXjbZJuQoVYXjSvFW7/jzqJtQMEFsejq2QclXKzRD+Qu3X1qHphkQ0K/e4KLHUQYEBmz3X0MQdvVGFK8dgo+GlD72Nd1JRXIfLFiatYaRSUx9P924L639hD4iUXTOaDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482878; c=relaxed/simple;
	bh=rAJczwMJJa/wfVaVwKqCNJ3A+Zpja+EWVkL/jrE2+4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbSnEasXAVdHR85dquWGp5Zv1eZBTD/QxRoIOTUOrqODLwo7QPQaPQblTraKbo/ZOwXI1z9THuaWiG9CLVi5/zd3zwvNXCOZ6YGU9dj48NFB8iWf+FjuQUXVlG7bSGsOgOWUSmO1ZOf24evDZpgHgyno0QqnEVD9JNl2u5M+hro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W7es/cLs; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B01JH9+NyfGeGc3RPtcMDiW90LpzHNZiM4L5vmwMMycoctWV4WpmkzRQddxJIvetXyYKA1LQiHpGskbfM3+K8eMm+U0BG0f7pwlgBrz16Y0UXlzVN9DEUgYfCAVZUlX4TJ4EjdMnYPig/b5MRZgIzSQhCreNzGzRBORpaW2L2ReiBLFQI9EPnGgbS4OjD5RaoVGWu6wNDCfisnWxkF6RomZGBu/75jo0gHFDzfmoOvH7w/fhpkpf6qiW6vaybxDD7M4bvOACgd5ReCVLZ5qlgIXJOrf42IwVdDLLt2+5x9yXKii0wLPM4LktPphqysEk/wD+0JdwkAhf+35grWYPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BhCFznPdt2WpnmOJqXzkqB6U0ETT+WgnWhKBZ4Wyv4=;
 b=U1PdR9sGy4Q8JT/1+W0SDPzT6HNKP42iMo4YU7wLjcqBE0o5dbuA03ie5RYa2/lbDd1enGWrgcs4RH82aO4j9/eo88QiOzVjActmLRluS2snKKWflkRMTtexDBMpdsiyJVM01i7rAKseC8drC/UqrJItxXgi4N+XWDmXn9iovCckozpwo9xueNuSYHIsa9dWsts2Q/8mIZyZ8FmLB0hk0r4laOEixMsvCJ85Ld9CKgKYo9ZG7VWLUNf/pBpZDsL2Y0Jcb0RbFuR1Wj36gyC2Pn/4os64dqVRecNCXnZc2DDtUBGZDi3qXjvwW752uIyDDG5YxWWcGbSCYvfY+mUF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BhCFznPdt2WpnmOJqXzkqB6U0ETT+WgnWhKBZ4Wyv4=;
 b=W7es/cLsnjRI5p7SdWGw3ymiBJUqX1kdB9Ktyd/QHyfuxr7B1yvOkufVh1S92xnNy43+qsgiITRHmtyGe8DtWmw7Of8/Ou5dclbM+kBIunAJXYuFtsp4Ox3XjBaTBc2vy2T5dx9S/mgROjWmY5i54b5wxlkEBkEZpKHhj6V0QHc714evE3y0o4h0JCHIFJAMD411FWUDrBF2gTHqHUTnK3CxMKgNqs54Al6dnnlqm9Zhomv2um4IxR/g+3D7gelpN0Utg+iJx4FDDou6XtRZa7nmyDYjhhp6S2FEhJenAkgjt88DVKPWhMcSgsJb3nakroaRPhTATA9AzHusUghMoQ==
Received: from CH0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:610:cd::33)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 07:01:05 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::9d) by CH0PR03CA0118.outlook.office365.com
 (2603:10b6:610:cd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 07:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 07:01:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 00:00:46 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 11 May 2026 00:00:39 -0700
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
Subject: [PATCH net-next v2 6/6] selftests: net: Add tests for neigh_forward_grat option
Date: Mon, 11 May 2026 09:59:36 +0300
Message-ID: <20260511065936.4173106-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511065936.4173106-1-danieller@nvidia.com>
References: <20260511065936.4173106-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 2276534b-2f98-4484-fe28-08deaf2b11da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	9R6iprzYAolNminth9Ko68ZmQYAI+FTYxSfTqUQ8wQFVnLBcWNJjgay+dNfYIYbc07ghMg+I/KdnVTHDUap7jlz6weTwp8SufY76NLLwJu69ZvsfP4S8kCAaRX6LRiG2LeJDIMlxP8TDLKEFt3y06PWoD615tVD8ZEPHwayby9aH8Uc9Lu9c3wxu9FvwwLRVJCtZLYsfqaoLR1haO75gsbW5ZLYHXoBhtyjVRKLF97Mynyg7DP7fNjpb3rnhx6aa4kEXAG/cyVUOWUDktdPTsDykz3cp5FlQfKhDLXQAQsiHV4tHhCq/uxMhBUbU54Vi/XST7LDm8Y21fH9bw7xgNkJp7zlg75MN0El5s2/hkR8S3Y4ZMPUZL7R6qQ/CKg1ybuMagSf15n6pg8jQTB4g8ADgb2ybAAwu61cB7OWeSfYNe45A5C4Ou5Z+OKcrX4Tj1mcZEAZGOuUENcmsYdBdANtmT2/UbmWOkRaSlbYDsueWt+xto4+AYDRnLtJ2KL7XlblmcsJLGjGs4RiWhjEfuSkYW2ALFmuFCLK4P/4UX93A/ebpxedaoub7OLyrw/ZeaJ7o2dAeMPe8lHwMsFVhLfXVDID0bdu9rQpesMkGf7TUjHtZehqmqa5tBES9B1QMMe5VlYjzl+FNj0FIFQuQRVZ8lOYIvnCLinv15yHVw0jy/EStFX1QxytvHWuhVEUcciEhG42tN1csx+WiG34/4UBAzq1c7fzqCkIuAXegxdQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3/Hu7HJ+bEbKYCKNzMMzu5t+S88/i7YY/8Ox4O+T/fB8WUrhm1Ug8VleRwPUexVbT3kDsr4Ji+6vEONxCLS33rZ9dvp1zico/JVycUYHwtcDS3bIzoxB5xd5Niw4pXz/Yg44EU2ePoRoOf/pGcJes3hoBHDNwxR+NRfCjD16UJIaJnIX6C5GI8UvAx+Eya8fY48TEuZvQedOgBRWyd3HPTJt3cvfcGVhYmOjtcrl8zvJpcCdXvwQWnLLSI+TuDrbUBDQfhMs2eG5O7bcvm5LIiPJdmkaq4sOoQNXhr7GOIq97OSYetPu0EAMqdUBmMCUyy19ROLBQETNELnoFVw1oOju33pRndoN0Dd+r0omEZEzsHEoh0GKa16pNRlkFsMWjs6xk5CcvTjsvNBtCQh4XVgpM36c55po7SmbzCOqeNfEHDedO5F9K+TAgnKk8Wxl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:01:04.9634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2276534b-2f98-4484-fe28-08deaf2b11da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
X-Rspamd-Queue-Id: 85EDE508D57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286470-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

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

Notes:
    v2:
    	* Add test cases for validating that regular (non-gratuitous) ARP
    	  neigh_forward_grat is enabled.

 .../net/test_bridge_neigh_suppress.sh         | 342 +++++++++++++++++-
 1 file changed, 340 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
index 4bc92078e173..e9ed0d750996 100755
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
@@ -1001,6 +1027,315 @@ neigh_suppress_dad_ns()
 	log_test $? 0 "DAD NS suppression"
 }
 
+neigh_forward_grat_arp()
+{
+	local vid=10
+	local sip=192.0.2.1
+	local tip=$sip
+	local h2_ip=192.0.2.2
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
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 102 proto 0x0806 flower indev swp1 arp_tip $h2_ip arp_sip $sip arp_op request action pass"
+
+	h2_mac=$(ip -n "$h2" -j -p link show eth0."$vid" | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
+	run_cmd "ip -n $sw1 neigh replace $tip lladdr $h2_mac nud permanent dev br0.$vid"
+	run_cmd "ip -n $sw1 neigh replace $h2_ip lladdr $h2_mac nud permanent dev br0.$vid"
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
+	# Verify that regular (non-gratuitous) ARP requests are still
+	# suppressed when neigh_forward_grat is enabled.
+	run_cmd "ip netns exec $h1 arping -c 1 -w 5 -I eth0.$vid $h2_ip"
+	tc_check_packets "$sw1" "dev vx0 egress" 102 0
+	log_test $? 0 "Regular ARP suppression with \"neigh_forward_grat\" on"
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
+	local h2_addr=2001:db8:1::2
+	local h2_maddr=ff02::1:ff00:2
+	local full_addr=20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:01
+	local h2_full_addr=20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:02
+	local csum="fd:32"
+	local csum_ns="1f:2f"
+	local dmac=33:33:00:00:00:01
+	local h2_dmac=33:33:ff:00:00:02
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
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 102 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $h2_maddr src_ip $saddr type 135 code 0 action pass"
+
+	h2_mac=$(ip -n "$h2" -j -p link show eth0."$vid" | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
+	run_cmd "ip -n $sw1 neigh replace $saddr lladdr $h2_mac nud permanent dev br0.$vid"
+	run_cmd "ip -n $sw1 neigh replace $h2_addr lladdr $h2_mac nud permanent dev br0.$vid"
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
+	# Verify that solicited NS messages are still suppressed when
+	# neigh_forward_grat is enabled.
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid -c 1 -a $smac -b $h2_dmac -A $saddr -B $h2_maddr -t ip hop=255,next=58,payload=$(icmpv6_header_get "$csum_ns" "$h2_full_addr") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 102 0
+	log_test $? 0 "Solicited NS suppression with \"neigh_forward_grat\" on"
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
+	local h2_ip1=192.0.2.2
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
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 103 proto 0x0806 flower indev swp1 arp_tip $h2_ip1 arp_sip $sip1 arp_op request action pass"
+
+	h2_mac1=$(ip -n "$h2" -j -p link show eth0."$vid1" | jq -r '.[]["address"]')
+	h2_mac2=$(ip -n "$h2" -j -p link show eth0."$vid2" | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac1 dev vx0 master static vlan $vid1"
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac2 dev vx0 master static vlan $vid2"
+	run_cmd "ip -n $sw1 neigh replace $sip1 lladdr $h2_mac1 nud permanent dev br0.$vid1"
+	run_cmd "ip -n $sw1 neigh replace $sip2 lladdr $h2_mac2 nud permanent dev br0.$vid2"
+	run_cmd "ip -n $sw1 neigh replace $h2_ip1 lladdr $h2_mac1 nud permanent dev br0.$vid1"
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
+	# Verify that regular (non-gratuitous) ARP requests on VLAN $vid1 are
+	# still suppressed when neigh_forward_grat is enabled.
+	run_cmd "ip netns exec $h1 arping -c 1 -w 5 -I eth0.$vid1 $h2_ip1"
+	tc_check_packets "$sw1" "dev vx0 egress" 103 0
+	log_test $? 0 "Regular ARP suppression with \"neigh_forward_grat\" on (VLAN $vid1)"
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
+	local h2_addr1=2001:db8:1::2
+	local h2_maddr1=ff02::1:ff00:2
+	local full_addr1=20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:01
+	local h2_full_addr1=20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:02
+	local csum1="fd:32"
+	local csum_ns1="1f:2f"
+	local saddr2=2001:db8:2::1
+	local full_addr2=20:01:0d:b8:00:02:00:00:00:00:00:00:00:00:00:01
+	local csum2="fd:30"
+	local dmac=33:33:00:00:00:01
+	local h2_dmac1=33:33:ff:00:00:02
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
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 103 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $h2_maddr1 src_ip $saddr1 type 135 code 0 action pass"
+
+	h2_mac1=$(ip -n "$h2" -j -p link show eth0."$vid1" | jq -r '.[]["address"]')
+	h2_mac2=$(ip -n "$h2" -j -p link show eth0."$vid2" | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac1 dev vx0 master static vlan $vid1"
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac2 dev vx0 master static vlan $vid2"
+	run_cmd "ip -n $sw1 neigh replace $saddr1 lladdr $h2_mac1 nud permanent dev br0.$vid1"
+	run_cmd "ip -n $sw1 neigh replace $saddr2 lladdr $h2_mac2 nud permanent dev br0.$vid2"
+	run_cmd "ip -n $sw1 neigh replace $h2_addr1 lladdr $h2_mac1 nud permanent dev br0.$vid1"
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
+	# Verify that solicited NS messages on VLAN $vid1 are still suppressed
+	# when neigh_forward_grat is enabled.
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid1 -c 1 -a $smac -b $h2_dmac1 -A $saddr1 -B $h2_maddr1 -t ip hop=255,next=58,payload=$(icmpv6_header_get "$csum_ns1" "$h2_full_addr1") -q"
+	tc_check_packets "$sw1" "dev vx0 egress" 103 0
+	log_test $? 0 "Solicited NS suppression with \"neigh_forward_grat\" on (VLAN $vid1)"
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
 
@@ -1087,7 +1422,10 @@ cleanup
 
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


