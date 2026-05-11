Return-Path: <netdev+bounces-286464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI4+MKF+AWoMbQEAu9opvQ
	(envelope-from <netdev+bounces-286464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:00:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42405508C32
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3653E3010EE8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0126130BF68;
	Mon, 11 May 2026 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tlU80z0t"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2612F6931;
	Mon, 11 May 2026 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482829; cv=fail; b=qmoycdMIHeWyPitb2fZDCeYaQlof6cLCkGSauH6WhC8VhI6/Yzj5O7D/9OiIupDxuxMji4NnTUMFCRZXx3GXkwzpb+N3PYB/VYyofB03xNB7wGXy5QPWssBmfSqy69OFqsKcaqY3hqJOJPIruw8HsaGKuvFWKENlAHJe5O4ertA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482829; c=relaxed/simple;
	bh=PpiJ2OnTqFAtqtJOgYOEnPLPlHE0AsRsms722/qhUr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r1AGNkf/tSnD8T7rRXp9udZsBcAybuh2NP83kMTPL9SlljlpTyawE6SacSRPq1bKyLkhbmmCbfAvVlV3/WJGiX1Ri/dz6nmU5SMUhGV7EpMXkO0Fo1ee3yyhuXuYLGe9NYD2PbcCHbU7LcINiv1xJcG1oOdmwa6g9z1uSyHoNcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tlU80z0t; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxnTLLkIq9LME+IU37QeY09Busq5u/KOfa9XXRvK1X6Q+5kBwTsPeBbG+TsjsI1Jo/RFj3NC31Lu/9e2xabS6AcbpVTsjpFCkPoY2EsoKuXT/UjBDLrLK6P8E0oYcKlKnmiOHlcIR0ARCwDkvKKRLGakwRvZAfLCkhXPMpn25deEY5xabjEWZnOCx7vg/OdeZb5oAu911hfiyXUFEaCyHfrlKkdCxO0rpDsj1zLglwLfD1bGhdtgxRbWQ/BDGo0vFSA3MqPEMthT6DOv+pDEUtM+vx8+0uaiM8An/8LJiGtbVhCGRuNL4jjsyQvnPqJUp5jjl5JzSFMwwvo0wpqK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6B8SCX0ojVUJ83cDJ83GezMetUHUqFb26n90uSY3ec=;
 b=hRgh5NbAZrS/hQxLUy+BLcXBe9TAh5JRTUfUe4eF5KFfBG4PdqOYBcAbL5LK8CPogcACCg3AnNrkG4c2nTBnStuZrHqASUSZE7UGhZfh352DoqZTXxdqe82RrPACdTrkQj3vs7U7o2TIxro/8WD+EvDX33vXi+oCYFsIiqfJMgE+rVbjRDziQkLIC9+iKBjK8L4v4NRr9Sg9eDTXuIuKmvw5EXFxWz3EO/Jg1sVu1rGyT14xJNo4H0dQMOLPjjGMVRFFeBsAgLzZFo8o/nWDU643FrKzT3vExitTHm3Lu66hTOowfqv0PNvSyicDBwGzi5oy46xDBBZmc6k3Bmdcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6B8SCX0ojVUJ83cDJ83GezMetUHUqFb26n90uSY3ec=;
 b=tlU80z0tBJA9eVO2pSmdohDjeItjiGp2lZCmwYFtpvPOUe4/tk/mvajo2U1+Z7cWtaBQvNtN+Xdq6Bmz2aq9n7NoQnmFoQsBLfCc/yt/NYRjE1SXMkWzqxJunMJNUemVDdk4Krh15ihqi1iPA4vDl99nry0h4Gmfbe7hQLQsI8qYhYJsaWZ9s1ImI6gZ2HJvDdsRWtWgVs2UU75HelGHpSl8wMvNBf0SXccUIvIFpd4T/eFA816e78LiDv8DY3mx+BZw3kzrtZ/iLTPMMlnkTLVjic+YRYo85A7ZesxSqI+2cA0DqJfD4ydZwyxFCFJtdSI+pttSNKa7jHDtsmUkZA==
Received: from PH7PR17CA0027.namprd17.prod.outlook.com (2603:10b6:510:323::13)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 07:00:18 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::47) by PH7PR17CA0027.outlook.office365.com
 (2603:10b6:510:323::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 07:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Mon, 11 May 2026 07:00:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 00:00:03 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 10 May 2026 23:59:54 -0700
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
Subject: [PATCH net-next v2 0/6] bridge: Add selective forwarding of gratuitous neighbor announcements
Date: Mon, 11 May 2026 09:59:30 +0300
Message-ID: <20260511065936.4173106-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca13233-222d-4ddd-d0f0-08deaf2af5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|18002099003|13003099007|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	+4lMZ8rjrxJwjhy7oPfIdMHy7bQ6YvfOX+CcJ1pwrQ068eB1WNqwxsmTtgpy4oVmZvhiXjiiOXn+lYz7o91ZAxuWy7UTpiTV4zQ0EEQsglYmjZD6EU/ahIx3EpRl48R0xC1GicoHnCUamwuSS3Jkn7FgUbOpVFTWUQc5/jma0aN4bUm7cM3q8izlNNnLo02C0K/P0eFMjyHOFXHiS/6qLHIELJ74cB0nQGJwpiclIm8wTxpmXGf1VRtu8LEgIfvYr9GAEBNjuHv2iX9AyqPHSlBhqP1/wwvrGwCpEQF1eZiwVGxZ7P91ZhJhXP0uRSsMBHuMZVOnLO0n/dzCMmzlVrR6lJkWokLu/Uc+6IEydEeE5tOxNqGo0UOl5dOYTHeKeVvTxp/wWzaDIapAvKyZAqs0jJTqeqnFD5QZ/wwUQ+UX6Xt7P8AasTC+8gurmH0VcnqeacMJfZhqI8j74YEQ0FZCA3p3Cyt9WQoZlbjtSsRydeVUFqf5fmbL8vT3WJElLDleInPcE61XBZkagRC9pzkdmpOpHcmcz9AbSva2IuDUMKO1zy9hM2tmwaD6eFRtKnXfAO0vEdadvyzvpPk0B3DNvMQBUx7g33DylXuIRLH2NYur572SVneBzrL9niph0ZSnwHDXlgHOGRk6VT5zHbDC7dqyndOEkdRGEOHa2hwzaeBGlE5/HkxIlhTB83QXBfO+qp/dHNScmn2t9eblqpuwledcTnQ0Zbgf/vnvo/0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(13003099007)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Uf7GN9uizVoHzJMJ8YUaYmpTNevLGhPzIEnpU/NO218MiqbDRzy31NY+n+FWd1ok3/u5ncng3YBR2ICqyse7vDOiHuNPnfGFNNlLSCx2W4mmGaaWoe8E4rmQUNMCn4vrwft1ikxfg6awFLnFxiNM05dPTq7HfqxMIETEc++eBnJro4urBeg2uh9l+4/c0PBSF9FBa9DqZL/vTQ/ixh3VIpTSkUXuE6G0sE3sFgnveOSCSf2Md99Lu5GQLtQRH9bYIXPqNtr96WiJCKKh0tg7evdTLBKq/dNq9Q1Dty6HpH9tU+pLPX0jRutlxNhysxlzhoLCTrz2EWPfI3akaM0kdd+FRgOmnSolGNUsGF5U6d0bTah6Awo4IqqLNt0Zpoewx5W10vwMzWCefJpFLHp3H4KsTl0AqsCFkBQBkq+v9Cp7UDWHEMxt6FCv1w7Ewhnm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:00:18.2102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca13233-222d-4ddd-d0f0-08deaf2af5fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
X-Rspamd-Queue-Id: 42405508C32
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
	TAGGED_FROM(0.00)[bounces-286464-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

The existing neighbor suppression unconditionally suppresses gratuitous
ARPs and unsolicited Neighbor Advertisements, which prevents fast
mobility of hosts between VTEPs.

This series adds a new neigh_forward_grat option that provides
independent control of gratuitous ARP and unsolicited NA forwarding.
When neigh_suppress is enabled but neigh_forward_grat is enabled,
regular neighbor discovery is suppressed while gratuitous announcements
are forwarded.

The implementation marks gratuitous ARPs and unsolicited NAs in
BR_INPUT_SKB_CB during input processing, then checks the per-output-port
neigh_forward_grat setting during flooding. This allows gratuitous
announcements from any input port to be selectively forwarded based on
each output port's individual configuration.

Both port-level control (via IFLA_BRPORT_NEIGH_FORWARD_GRAT) and
per-VLAN control (via BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT) are
provided. The default value of OFF preserves existing behavior.

This behavior is in accordance with RFC 9161 (Section 3.6), which
recommends that VTEPs forward gratuitous ARP and unsolicited NA messages
to avoid traffic disruption during host mobility events.

The new attributes use NLA_U8, although the kernel netlink guideline
recommends NLA_U32 as the minimum integer type on the grounds that
alignment makes smaller types equivalent on the wire. For a simple
on/off attribute there is no technical advantage to u32 over u8, and
keeping u8 preserves consistency with all surrounding bridge port
attributes and avoids introducing new helpers alongside the existing
infrastructure.

Patchset overview:
Patch #1: adds uapi headers.
Patches #2-#3: support selective forwarding of gratuitous ARP.
Patches #4-#5: add netlink handling.
Patch #6: adds tests.

Please see iproute related patches in the last 3 commits of:
https://github.com/daniellerts/iproute2

v2:
	* Convert neigh_forward_grat from flag to u8 in .yaml file.
	* Add test cases for validating that regular (non-gratuitous)
	  ARP requests are still suppressed when neigh_forward_grat is
	  enabled.

Danielle Ratson (6):
  bridge: uapi: Add neigh_forward_grat netlink attributes
  bridge: Add internal flags for neigh_forward_grat
  bridge: Add selective forwarding of gratuitous neighbor announcements
  bridge: Add port-level netlink handling for neigh_forward_grat
  bridge: Add per-VLAN netlink handling for neigh_forward_grat
  selftests: net: Add tests for neigh_forward_grat option

 Documentation/netlink/specs/rt-link.yaml      |   3 +
 include/linux/if_bridge.h                     |   1 +
 include/uapi/linux/if_bridge.h                |   1 +
 include/uapi/linux/if_link.h                  |  17 +
 net/bridge/br_arp_nd_proxy.c                  |  22 ++
 net/bridge/br_forward.c                       |  15 +-
 net/bridge/br_netlink.c                       |   8 +-
 net/bridge/br_private.h                       |   3 +
 net/bridge/br_vlan.c                          |   1 +
 net/bridge/br_vlan_options.c                  |  24 +-
 net/core/rtnetlink.c                          |   2 +-
 .../net/test_bridge_neigh_suppress.sh         | 342 +++++++++++++++++-
 12 files changed, 429 insertions(+), 10 deletions(-)

-- 
2.51.0


