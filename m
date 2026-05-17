Return-Path: <netdev+bounces-288701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHO1B6V7CWo4cAQAu9opvQ
	(envelope-from <netdev+bounces-288701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:26:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B63055FF3C
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 590CC301BCFC
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD67337B99;
	Sun, 17 May 2026 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C9ngGgAi"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4204D3382E5
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006343; cv=fail; b=eCmv90BZYOn6JcB6O/ofK1nBNgXeED/KeykgtftukcpErbFVAtHaMdkeuEUoiZVYjlG3POT+KVLmFOV9gZ76etoVfCNC2bjPZoc4vqx4jmYwrcuHwz4OyD8ip8I5REBPqRcmQIXegwymrDY7RSPBf9WoDIHO7lxTKG1lGYo24E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006343; c=relaxed/simple;
	bh=Cpx0VfVHacikr72MafaVmyypJcCemN0M0Fud8D0Xrxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYgMbZHnwJnp7XkPVV+F+7VE8wo++nsPLMyrn3b7Bv7K/nMjA2XbacA7KWQVVSEGN/hnB92Cuk59ppfDASkk2tIK9C2VNo9QkjygdqYpUTc5NF2EN1BnYtMuoGY8tW7gewgZMNv4HpA0TwL1Ga3pPBydHsf4WXWsgNPoTuOhtj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C9ngGgAi; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=choafvUWmrslp3XWpEdMTmpBpPaySklbd8Gb5R6NcYM4Ek9iQtWptT5tH1gQvfg9inORiIdMcbZZG5N3n9w/3DYH03ioVNOwDVYev9CcDHes4gQMt4ztfuSPUqBDiYhw3jGLb4HEtamTmQX6i0vv048yoZlvi1CE99drKyZdZbLoOEmugFUX3RjAwhTQpAJpeJtFZzhLIpgH2KC54KEj2fpdoCfyd/rVItkjF/NRnO0DwprAiz/cqwXwT/S7Ldxyf1Wm9C8PoqWWQnS/2u1bv1kxWNS1jOEayqg9p/WOWmab+M+IBh6i4qXw1vtKsknld0bDiK+nFzrfYiEyMPJGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUj8pKVHe/GASCQwhjiTB3dbYS48VpnkPu7FJSywiao=;
 b=TihEVwUV3AuHNjLWq03LBP6z0CHGqAGtIDgv8IKpreyau5PVRkDJ8xRFf7jIpfINIhiPDraq0BW4xFwGbhNdg2jBW+ATZB/y/UHHIUSwkvpX4VJVtqs5as8N8q5roXjAEYT2TvQZh4Ht6sCJfa01cdS6gQiRcaE3xTXQhqDaYwHBk5BvpluEsCq9hy81aed6OIB7w8aGUifwZog00ztpp3tQc1U9vpF2snR5EW+7fWBuMF1B/hzwGQNfOVVHKgAt+638tQSs2LOrKpN+j5PBgtjCG4pHjqSPagvbbrBM8RtA8sfLlvUr/QjAZrqs2dgauzxXLavkKixUoYFK16cBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUj8pKVHe/GASCQwhjiTB3dbYS48VpnkPu7FJSywiao=;
 b=C9ngGgAiAB9Wh19oMVJM623uRDr9OOP2Vu5F5QaHPxLbNgERfz+9C6aoLbRR8F/x3opZTCR+5DUtP/bcjoEm5+dXlA6jkg7Irpv48yJqCwGXOXQ+lu0+5llatv5W0TXrfXW8KXeoKj8VmoFNxfz7DL3LqoYXdADHiodnhH77CUfMEZ+i1t54sx/1BbnANkMgwlW3moWHr2tSyZkFbF8lFDoopzlC14GeGMpXfqUpQwLbSrOG216yxovRoO8ETCC2awf0a9t+7ChM/1dLvFlB4JwmgiValjl1LA6QXj/NTeMJj9d/YgqAjWYWQtTGBjV4XsJceV1vshriPqjcQwFrbg==
Received: from DS7PR05CA0031.namprd05.prod.outlook.com (2603:10b6:8:2f::6) by
 DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Sun, 17 May 2026 08:25:33 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::35) by DS7PR05CA0031.outlook.office365.com
 (2603:10b6:8:2f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11 via Frontend Transport; Sun, 17
 May 2026 08:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Sun, 17 May 2026 08:25:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 01:25:19 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 01:25:17 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <idosch@nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH iproute2-next 1/2] iplink: bridge_slave: Add support for neigh_forward_grat
Date: Sun, 17 May 2026 11:25:00 +0300
Message-ID: <20260517082501.899009-2-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff45897-841d-4e34-f1ec-08deb3eddd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kZn/JEGxv8cWbk0als8wxQ76bL0UchYECA/HHWtaN7oHjyS5gkVvu7Or/3r1/e0OhoaxYLAETdKe3j7Q+Rr6hom6bxqN44jWBC/R07jICKS17Kcjws0jiO3Ku7c3UCwPfw2YxEE2/jdnE8P5FsOuuvxaap5zV43jdBTLWU0M6/1Cb59YKuFFPtoBVOxMCfXxHzqp23JO/iD6rRDiNzUheCgI0VTfekHVxMDzbQsysRcQLCnSR90wFfemZClPloPEoTh44slSCdW3KsZi66nHUjhOmEqR23qSJ9GfcuXQ+9Tlpj2MMPgnvmn1REdu/VhjKcPDiF4UVt8ez33Yx50xAfaVWS9c/+rt0+pT9THSgda/hY/sBEMKoffcPZ8AXY54WhA1xbWsaNqKrpV1tn4J+FTRtD4z7qTTS0Za3VhRgMx8D4hkmXl5JqJk5hxxvBe+iRc3RZ43E/dweK9gtQp4h8WqWS7607c3uLtQ/k7XasZdXdBLoQupOEXgz4qQSWvqeWCKAbyhsw7xUrY5G4STT7EqzdUkmszfHqhqSelxsNmrOFmxHeW55XHOnrfN7O7RlUSJh4Px1StdUP8aVTse0s3YBslC2hr6JurU1estwPoYdUR9CMmnkUZNtuE21rxLDY/f7/5Oe59Dxx3/KLfY5O83BdbsqyP4CIdgUOq0uUzkbk3g69p93V7lGO59J/sCRbYYmdrLeznSnzzRRJTKCAY+b/XNj/HK0WyB+74r6MQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MFNUyBIsO/EzVkQgMAGV+UP/awMSBl0DM9V7vqfTL5P+TNsBgewTwSigEDDyCedWeT7odyaJO1+5sq88VRjAm5YeGB22FmNOMYJC1kgEK3ixIhKXcQ+FefPZnmGz4PSmT938ZLXqq6WpgHAONzhiTdvHGDcjjMbU942Kj7z5unADLx9Mc3545HPu4LIZKZrQOdtJ37xDnl2ZB/XoyTqRnKIbJY5Rd38zYVgo49XyTqVbnzEQ5xT6f7umqqs3NCCclEFh4m18JSiPEEZ7Sk1o4R2PKblzFQVP/kjfiwN1I42JcCweUjL6Ks6eZ/9J0sN3UOiqT05I4r8fIg7q/VjPa5auznkNy2tloYj0r1r45WDH3s4TfuldV3ck2tCuOEu/S/cLZkG7z9QajR8avHQvkC182R+Up2rS1dY3uzPR3qfa+B5BU3S9eL/hcaoiSmOm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 08:25:32.9079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff45897-841d-4e34-f1ec-08deb3eddd0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
X-Rspamd-Queue-Id: 7B63055FF3C
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
	TAGGED_FROM(0.00)[bounces-288701-lists,netdev=lfdr.de];
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
forwarding at the port level via the neigh_forward_grat option.

This allows configuring the option via:
$ ip link set dev <port> type bridge_slave neigh_forward_grat {on|off}

Or via the bridge command:
$ bridge link set dev <port> neigh_forward_grat {on|off}

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 bridge/link.c            | 14 ++++++++++++++
 ip/iplink_bridge_slave.c | 10 ++++++++++
 man/man8/bridge.8        | 10 ++++++++++
 man/man8/ip-link.8.in    | 10 ++++++++++
 4 files changed, 44 insertions(+)

diff --git a/bridge/link.c b/bridge/link.c
index 7638797d..370d7de4 100644
--- a/bridge/link.c
+++ b/bridge/link.c
@@ -174,6 +174,9 @@ static void print_protinfo(FILE *fp, struct rtattr *attr)
 				     "neigh_vlan_suppress %s ",
 				     rta_getattr_u8(at));
 		}
+		if (prtb[IFLA_BRPORT_NEIGH_FORWARD_GRAT])
+			print_on_off(PRINT_ANY, "neigh_forward_grat", "neigh_forward_grat %s ",
+				     rta_getattr_u8(prtb[IFLA_BRPORT_NEIGH_FORWARD_GRAT]));
 		if (prtb[IFLA_BRPORT_VLAN_TUNNEL])
 			print_on_off(PRINT_ANY, "vlan_tunnel", "vlan_tunnel %s ",
 				     rta_getattr_u8(prtb[IFLA_BRPORT_VLAN_TUNNEL]));
@@ -313,6 +316,7 @@ static void usage(void)
 		"                               [ mcast_max_groups MAX_GROUPS ]\n"
 		"                               [ neigh_suppress {on | off} ]\n"
 		"                               [ neigh_vlan_suppress {on | off} ]\n"
+		"                               [ neigh_forward_grat {on | off} ]\n"
 		"                               [ vlan_tunnel {on | off} ]\n"
 		"                               [ isolated {on | off} ]\n"
 		"                               [ locked {on | off} ]\n"
@@ -343,6 +347,7 @@ static int brlink_modify(int argc, char **argv)
 	int backup_port_idx = -1;
 	__s8 neigh_suppress = -1;
 	__s8 neigh_vlan_suppress = -1;
+	__s8 neigh_forward_grat = -1;
 	__s8 learning = -1;
 	__s8 learning_sync = -1;
 	__s8 flood = -1;
@@ -474,6 +479,12 @@ static int brlink_modify(int argc, char **argv)
 							   *argv, &ret);
 			if (ret)
 				return ret;
+		} else if (strcmp(*argv, "neigh_forward_grat") == 0) {
+			NEXT_ARG();
+			neigh_forward_grat = parse_on_off("neigh_forward_grat",
+							  *argv, &ret);
+			if (ret)
+				return ret;
 		} else if (strcmp(*argv, "vlan_tunnel") == 0) {
 			NEXT_ARG();
 			vlan_tunnel = parse_on_off("vlan_tunnel", *argv, &ret);
@@ -579,6 +590,9 @@ static int brlink_modify(int argc, char **argv)
 	if (neigh_vlan_suppress != -1)
 		addattr8(&req.n, sizeof(req), IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
 			 neigh_vlan_suppress);
+	if (neigh_forward_grat != -1)
+		addattr8(&req.n, sizeof(req), IFLA_BRPORT_NEIGH_FORWARD_GRAT,
+			 neigh_forward_grat);
 	if (vlan_tunnel != -1)
 		addattr8(&req.n, sizeof(req), IFLA_BRPORT_VLAN_TUNNEL,
 			 vlan_tunnel);
diff --git a/ip/iplink_bridge_slave.c b/ip/iplink_bridge_slave.c
index 3821923b..1be02041 100644
--- a/ip/iplink_bridge_slave.c
+++ b/ip/iplink_bridge_slave.c
@@ -38,6 +38,7 @@ static void print_explain(FILE *f)
 		"			[ group_fwd_mask MASK ]\n"
 		"			[ neigh_suppress {on | off} ]\n"
 		"			[ neigh_vlan_suppress {on | off} ]\n"
+		"			[ neigh_forward_grat {on | off} ]\n"
 		"			[ vlan_tunnel {on | off} ]\n"
 		"			[ isolated {on | off} ]\n"
 		"			[ locked {on | off} ]\n"
@@ -275,6 +276,11 @@ static void bridge_slave_print_opt(struct link_util *lu, FILE *f,
 			     "neigh_vlan_suppress %s ",
 			     rta_getattr_u8(tb[IFLA_BRPORT_NEIGH_VLAN_SUPPRESS]));
 
+	if (tb[IFLA_BRPORT_NEIGH_FORWARD_GRAT])
+		print_on_off(PRINT_ANY, "neigh_forward_grat",
+			     "neigh_forward_grat %s ",
+			     rta_getattr_u8(tb[IFLA_BRPORT_NEIGH_FORWARD_GRAT]));
+
 	if (tb[IFLA_BRPORT_GROUP_FWD_MASK]) {
 		char convbuf[256];
 		__u16 fwd_mask;
@@ -415,6 +421,10 @@ static int bridge_slave_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			bridge_slave_parse_on_off("neigh_vlan_suppress", *argv,
 						  n, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS);
+		} else if (strcmp(*argv, "neigh_forward_grat") == 0) {
+			NEXT_ARG();
+			bridge_slave_parse_on_off("neigh_forward_grat", *argv,
+						  n, IFLA_BRPORT_NEIGH_FORWARD_GRAT);
 		} else if (matches(*argv, "group_fwd_mask") == 0) {
 			__u16 mask;
 
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index fe800d3f..aae6c75a 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -55,6 +55,7 @@ bridge \- show / manipulate bridge addresses and devices
 .BR mcast_to_unicast " { " on " | " off " } ] [ "
 .BR neigh_suppress " { " on " | " off " } ] [ "
 .BR neigh_vlan_suppress " { " on " | " off " } ] [ "
+.BR neigh_forward_grat " { " on " | " off " } ] [ "
 .BR vlan_tunnel " { " on " | " off " } ] [ "
 .BR isolated " { " on " | " off " } ] [ "
 .BR locked " { " on " | " off " } ] [ "
@@ -659,6 +660,15 @@ enabled on the port. When on, the \fBbridge link\fR option \fBneigh_suppress\fR
 has no effect and the per-VLAN state is set using the \fBbridge vlan\fR option
 \fBneigh_suppress\fR. By default this flag is off.
 
+.TP
+.BR "neigh_forward_grat on " or " neigh_forward_grat off "
+Controls whether gratuitous ARP packets and unsolicited Neighbor Advertisement
+packets are forwarded when neighbor suppression is enabled on the port.
+By default this flag is off, meaning gratuitous ARP and unsolicited NA packets
+will be suppressed when neighbor suppression is enabled. Setting this flag to
+on allows these packets to be forwarded even when neighbor suppression is
+enabled.
+
 .TP
 .BR "vlan_tunnel on " or " vlan_tunnel off "
 Controls whether vlan to tunnel mapping is enabled on the port. By
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index ef45fe08..e89b2db3 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2677,6 +2677,8 @@ the following additional arguments are supported:
 ] [
 .BR neigh_vlan_suppress " { " on " | " off " }"
 ] [
+.BR neigh_forward_grat " { " on " | " off " }"
+] [
 .BR vlan_tunnel " { " on " | " off " }"
 ] [
 .BR isolated " { " on " | " off " }"
@@ -2791,6 +2793,14 @@ is enabled on the port. When on, the \fBbridge link\fR option
 \fBneigh_suppress\fR has no effect and the per-VLAN state is set using the
 \fBbridge vlan\fR option \fBneigh_suppress\fR. By default this flag is off.
 
+.BR neigh_forward_grat " { " on " | " off " }"
+- controls whether gratuitous ARP packets and unsolicited Neighbor
+Advertisement packets are forwarded when neighbor suppression is enabled
+on the port. By default this flag is off, meaning gratuitous ARP and
+unsolicited NA packets will be suppressed when neighbor suppression is
+enabled. Setting this flag to on allows these packets to be forwarded even
+when neighbor suppression is enabled.
+
 .BR vlan_tunnel " { " on " | " off " }"
 - controls whether vlan to tunnel mapping is enabled on the port. By
 default this flag is off.
-- 
2.51.0


