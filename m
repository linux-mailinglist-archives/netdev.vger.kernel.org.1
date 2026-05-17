Return-Path: <netdev+bounces-288702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGGQErx7CWo4cAQAu9opvQ
	(envelope-from <netdev+bounces-288702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:26:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F7555FF43
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C21233008755
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F147336884;
	Sun, 17 May 2026 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MLxrZohh"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC93358BE
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006347; cv=fail; b=lLFuXESd2xuX+1q09gJEZDtkPM+G0HeRVXLSZKUcSnUrUhNzINk7Pd5ygN6F1/t+CHArhv9wVB+NQHu7trQzEQf06aVSplTZZ8ntDtWACuKEHarrSmhlYINUf5CHe/Q34dJXXjAjRxaj3JIMNU8oyCZpUR96c7ZGZdVSYX5dFAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006347; c=relaxed/simple;
	bh=t6sjZABvJdfXndb09wROeFLVRDAr+hQXg0GOAZ1SH0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1AGAoq8xbMh+F1Rx9mAqyt8+a8I3o0M3eGLa7L35V3w6kxVPPTFSzPUMF5OKL2k5mHwgA2mhNyOne0H3oJlxMzfOIFl8DedbWPYo1u1IqbeQ/8EPhJZYaUXElI8oUak1zpVQFoZwgWp7fHnF75+sH+P4oilWlaA+cOefdwavOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MLxrZohh; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWlcG24M5ESZffq3oOBNAgvV2mulzGGT0EX1TmL9TbRXZjduLJMZ0f5FQXmymeoJIZqBKL8XAYbbcrt3elAVsi/31zSsXqzgNSlYQla+kWazLvUgOeIFi2oWt1/8IxcTlvwsvYwRh1Ju7zrBf0k9OTxDkoj6O1vw02KQXEEVrT1tBHuyyn/hE50p4ctekQacfTz+GaScCx1J38HD2h2raZWhbhse4bfNilPtlGLR0GcXHQ3d6P2MYaxjkmWINJyZyruZ6/ldlKjKcN+u7XMWbpVjsPC8Ipay9WRBYa9F/HyIT706TvIeROfAs1C0JPhRSb3sl3kYxxvLTEeG7YMjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXchb6gkoMcT1ArIr7q8qkjRxHxSRad25FeEldgikvY=;
 b=mBVCAUbVbvrEHoRJSYsDGmwD8nORBFn6U4xRt0tc47cVAajT2ukFzA8JBqEksM+cETkgb7dcxXZigjP8UkeLjIZOzWHmXDPzV7GcZeZR+Pbaw9jCL4eMkO2xq6PO+IsPtLIm0Vz8sXkHbdchP6H6Tjowytg08itun+SYi0Wrv+R9ZJRD5z8T7sEjUNCDffbwWMFVWfRwG643GdEGuyDXx3vLQLxv4HLz7cPTjNDPv+5pyvXH1R7MzGGfuefYQaZArRQ0+JIXo1xQXNrrAWEQNoWe31L9lXZ6Ta+UZlRW7cXpU10FAREYjkXYnsuecp2WdBqxRsIq4bUH1Zz+Fx+sQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXchb6gkoMcT1ArIr7q8qkjRxHxSRad25FeEldgikvY=;
 b=MLxrZohhyPPZKSuwmnNUiUy1hf4c9RESeOW5eVqdCgZWRZAFciQk6R2SWzxAyuEvw9tuUgVslWGxwbwdIUbDBrxSVyZmJrv+kyJhCS9JTFNFNBTy09A0F8I4N0O96Nghg/ob/AQExPlMJGEXCqCUISMHakVV4lcbP83k8lug5AIFVWXPf5Ny8O7IB6zSyUCjy1UgsoyMttJSzNcB4vnS/fbuxVFAnHd63uMcZs4jJEH2WSodB82d6bQzqRTgTXHidDZcrJMQMdPNCws3oK3edg/3lUnIqprgdKRiXRC/BfT9pTmzudAoZ7N1uzMK9DWSZpm9zQ+ktOV9BMX09ZH7dA==
Received: from BL0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:91::13)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 08:25:40 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::a2) by BL0PR05CA0003.outlook.office365.com
 (2603:10b6:208:91::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.10 via Frontend Transport; Sun, 17
 May 2026 08:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Sun, 17 May 2026 08:25:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 01:25:22 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 01:25:19 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <idosch@nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH iproute2-next 2/2] bridge: vlan: Add support for neigh_forward_grat
Date: Sun, 17 May 2026 11:25:01 +0300
Message-ID: <20260517082501.899009-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517082501.899009-1-danieller@nvidia.com>
References: <20260517082501.899009-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3e2e47-e6b5-4c3c-0253-08deb3ede12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	hd3iqZcIfArV2dEaZvf54Crscmprh4ZLULQLTYnGdzcWaIXCQcCqTxSzgqiDW9ZYEG+eE9vFV32RQXeC4ejFfepKQcLIWBpQQwAUTkxJkSAcchHKokobIzmppYASq1BUrHvZl89obK3SVvnU66VKdXxoDhpCYUXBB6gmqQZSTCw2mSwlhErb+/ImsV2fQarPPhjqYnUOQiIss1dZev8VkBWSL9prL1AbgdXtNvpS9SeCDpK8ntrXJeShknNjw9MeAcx54Ave8vkmQydMAoUD0dzB8+rc5nfuIU1G077s9IWji4n32tb86uEU2iigFOmJQv7EyjR1+dsrH3NjTb6oQjqo0kaxZdqYwSE1eN/3HFOkjdbaW5WhWiCGUelm6vnjXsFxyJ1u5M0urVJL/MHAchjHmowKKQat47PcRfqM5a4RCWPpJJfWmfnCRjr72a4sfVqMx51pfpe/6AEPWeUQKFBMwxfkeNgb69+orv5X0eN4rCkrjs32oTqgouO2HCJ45vc0HytqZQ+c7i6J9QaIlST8m3S0/yK16iu5k0spclAZSOjOYrO7yU4VBhY/kZJRPjwbFPtN9UibV+1BCPvdsZffg3MCFmSU8yISM3V+QW/HZ0LVOI95vc0+NbRdjsOm+JinmHnDu77Ui8TnwuKJCXnvOXTTdEljhY6zbuzksK5i8Pvq36EIyFg88TgvSah6UkLk3cySx29JDaq4gIKxW6io+sBBw2sP838V2qvadtU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oFsFYvC4DvBNXI3jyPj5aH+OMx7b9IIg1FeRopiincOq2rcmTS41oTUair8CZ6XioQHKUkghOnWKqsKjFH3OPJbb5HGqZXyVVvXvCsUtSIo01WsZLTzJuuXgHHmwNFxOMxP8A5yHuCdZRMfLCdJ80QLiHwZsndDHvCid8HcL/rZGykjsV8oOot3UIMlG/l1M45QP+YekKVIjA88XJNWAIDARbRdwrtEsFm4uinXzpOdB1UJ6aVEOzDjSfk27MTvQTfNUaV09zMXR4XihJhazP+s5i2UIB1N5RBlx2T1rjtzFvA32ocnLV8B/fpZoTn5k0iNzqJaIqdbDhcmkuN1yipMT0hFRRX1AVXRHDrYzh1A7F1Fo8fTQXrCJbmuhjH3B3s11LeJ7GiMTKreHkFHFCUw4h8csstW5aUQ6YymdHJV4Z+iCyWQ6qmjufrppbgoN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 08:25:39.7506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3e2e47-e6b5-4c3c-0253-08deb3ede12a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
X-Rspamd-Queue-Id: B9F7555FF43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288702-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add support for controlling gratuitous ARP and unsolicited NA
forwarding at the per-VLAN level via the neigh_forward_grat option.

This allows configuring the option via:
$ bridge vlan set dev <port> vid <vlan> neigh_forward_grat {on|off}

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 bridge/vlan.c     | 18 ++++++++++++++++++
 man/man8/bridge.8 | 15 ++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 27d31ba8..ff03ac86 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -39,6 +39,7 @@ static void usage(void)
 		"                                               [ mcast_router MULTICAST_ROUTER ]\n"
 		"                                               [ mcast_max_groups MAX_GROUPS ]\n"
 		"                                               [ neigh_suppress {on | off} ]\n"
+		"                                               [ neigh_forward_grat {on | off} ]\n"
 		"       bridge vlan { show } [ dev DEV ] [ vid VLAN_ID ]\n"
 		"       bridge vlan { tunnelshow } [ dev DEV ] [ vid VLAN_ID ]\n"
 		"       bridge vlan global { set } vid VLAN_ID dev DEV\n"
@@ -368,6 +369,18 @@ static int vlan_option_set(int argc, char **argv)
 			addattr8(&req.n, sizeof(req),
 				 BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS,
 				 neigh_suppress);
+		} else if (strcmp(*argv, "neigh_forward_grat") == 0) {
+			bool neigh_forward_grat;
+			int ret;
+
+			NEXT_ARG();
+			neigh_forward_grat = parse_on_off("neigh_forward_grat",
+							  *argv, &ret);
+			if (ret)
+				return ret;
+			addattr8(&req.n, sizeof(req),
+				 BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT,
+				 neigh_forward_grat);
 		} else {
 			if (matches(*argv, "help") == 0)
 				NEXT_ARG();
@@ -1012,6 +1025,11 @@ static void print_vlan_opts(struct rtattr *a, int ifindex)
 		print_on_off(PRINT_ANY, "neigh_suppress", "neigh_suppress %s ",
 			     rta_getattr_u8(vattr));
 	}
+	if (vtb[BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT]) {
+		vattr = vtb[BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT];
+		print_on_off(PRINT_ANY, "neigh_forward_grat",
+			     "neigh_forward_grat %s ", rta_getattr_u8(vattr));
+	}
 	print_nl();
 	if (show_stats)
 		bridge_print_vlan_stats_only(&vstats);
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index aae6c75a..d2323521 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -241,7 +241,8 @@ bridge \- show / manipulate bridge addresses and devices
 .IR MAX_GROUPS " ] [ "
 .B mcast_router
 .IR MULTICAST_ROUTER " ] [ "
-.BR neigh_suppress " { " on " | " off " } ]"
+.BR neigh_suppress " { " on " | " off " } ] [ "
+.BR neigh_forward_grat " { " on " | " off " } ]"
 
 .ti -8
 .BR "bridge vlan" " [ " show " | " tunnelshow " ] [ "
@@ -1486,6 +1487,18 @@ for a given VLAN on a given port. By default this flag is off.
 Note that this option only takes effect when \fBbridge link\fR option
 \fBneigh_vlan_suppress\fR is enabled for a given port.
 
+.TP
+.BR "neigh_forward_grat on " or " neigh_forward_grat off "
+Controls whether gratuitous ARP packets and unsolicited Neighbor Advertisement
+packets are forwarded when neighbor suppression is enabled for a given VLAN
+on a given port. By default this flag is off, meaning gratuitous ARP and
+unsolicited NA packets will be suppressed when neighbor suppression is enabled.
+Setting this flag to on allows these packets to be forwarded even when
+neighbor suppression is enabled.
+
+Note that this option only takes effect when \fBbridge link\fR option
+\fBneigh_vlan_suppress\fR is enabled for a given port.
+
 .SS bridge vlan show - list vlan configuration.
 
 This command displays the current VLAN filter table.
-- 
2.51.0


