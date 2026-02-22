Return-Path: <netdev+bounces-259863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOMNMi7FmmlHiQMAu9opvQ
	(envelope-from <netdev+bounces-259863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:58:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6089D16EBED
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54875300E61E
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD59201113;
	Sun, 22 Feb 2026 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kIPCxwwZ"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE791D47B4;
	Sun, 22 Feb 2026 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750466; cv=fail; b=Fm1qUg5a+ut1kvFDy9Dj277BywwujP/qpvf0yMu+HCQS05HenmF3crOIQO0+uh+vPAMU+wixqj2cdcdekl2c56h8Nu3kgeFXpvNFGdcNzyNahq58Yjs3Vfj5MTQ8pbkV0UycY4nxxX6PU4OUQGu/Yt1t/5nOLcWe0GiOrii9Yws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750466; c=relaxed/simple;
	bh=cK4GEciBCZUS6d6UZSWwthhyp349XW9rZsBHJYz5xq8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sc6nKVHnBIJBwgQITMfaU5yMlEhEH3ITZQS6IaQvIU8wb5O+2WCo5KAQEtPUov27aD2A5h2hgntREXhUCD6ISJFv5hMsOLuSlsGf1ewWdsIbsBiWNyzOxqQydwZV/xCA3DASneZ2u/44G2sfI/WnXLWgfwzbTZYDgi5Eo604Nyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kIPCxwwZ; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrP7EoZbnU1S+gcXlR7fOdhUJouvgm1EQ2Eb3oJiAAuqxeNo7ZFGn/PxCq7KYThWg+3IHteSopIl4BIuHHwHM8UtwXRbcLir0OvEL0VVyq99matGdqCs0sg7xTVSMOPZXemK7cC7qS8ZjwiqYGcZjtWB13VSKJ04tNmAUUokB5YA1zjBmTTap6CakXx+EnknLfpAEe7Vq9siUQXpIK/xwUZvB65JspNq24WxDgHUenaIn3uDVQKzKc+2yWmg0ccc99svw1m/VNjvuBTATIPcdYcfTTGFkawo8g+lnMj/PBksqufd7+NtQd0X9zJJh7iyjJ4zgye3SiZIsQgUGD1vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuhh1rcfB7jYeB4M5lKj19ebBUQtHyTzumtIMpivkbI=;
 b=Qg9NfTxisdjHvqM3C4km9XwNg6FOwnc/ONeJZ1glEcBKhgNpCqgeP2bSL84HkCEkNg6cHLwXY6wFvjV10PyJe1iEKdCD9vqtGD1kf9h2zPhmP3OrorOcrZj3cdnm2HkCKgchtMAjTit4ly7CcaVBS7P0FLJ4QsC2xGxkNbLqWWlblVRGGvsV7Ki0deUm3S/GNZRgG09pfimDMl/TArs+2eHpSz13Fo4W+rx6f2X/hmXenvA0sBIrRVqJicukY1PTOmJ3NJp4yGlHAqy/JRKhrwNr5PK+o0+VEwYv2OgTg6UE+7NHa06JioP9uaV8gHSjkSdJi6cI58ESoK/YajBSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuhh1rcfB7jYeB4M5lKj19ebBUQtHyTzumtIMpivkbI=;
 b=kIPCxwwZUaRWR0TRTI0MCs5U+Z7aknTy+FYPXpAZtGtQZ7eKk3q02yAg/RJUh5AvcoHmQyTdkZBvC7bqIOi1tQPnd38ledLCh80Vu3Bv3uHeGDdTdJlIyxEJbymRTNG+THx1+wHEiRrsIERoWO6b0RB5Zz8yreB34ky25fJVOmKnqFhIH15DK19wqj7wLHvLcJd+xWhjXVZH50II5ghGFiK+4pHYqCHVzPeMK6bkxb4sYhYhHdWM6uH6Rd1AOuBrERmS/qkki/MzaFeI4ev7LREseJUw0cs+aSMPcQFCraVCRdNQmnS+SusQAQoQpmE2t+C1kGeNVJIJEeFy/wh+8w==
Received: from BYAPR06CA0049.namprd06.prod.outlook.com (2603:10b6:a03:14b::26)
 by DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Sun, 22 Feb
 2026 08:54:20 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::f1) by BYAPR06CA0049.outlook.office365.com
 (2603:10b6:a03:14b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.17 via Frontend Transport; Sun,
 22 Feb 2026 08:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 22 Feb 2026 08:54:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 00:54:09 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 22 Feb 2026 00:54:05 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net 0/2] bridge: Check relevant options in VLAN range grouping
Date: Sun, 22 Feb 2026 10:53:36 +0200
Message-ID: <20260222085338.3143823-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS5PPF1ADAD2878:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db30aeb-c86d-4a4c-895a-08de71eff6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4HyMJifun8CVHUYqUJDEPYQxtjqQYtz1IO4q6hr0YM0SzWMKTN3Belm+ZbWA?=
 =?us-ascii?Q?TiUy++S6bhNZzeWiFch/yDuWSWz2ComtqhFPHBLx/CMeLqVnY9T3xynWCA/D?=
 =?us-ascii?Q?MIC7XrIB9ND/7Uxwvz1zlh66V7u6DU2Cgp17Q6gcjIK0qzwws7RUTkL+LfRS?=
 =?us-ascii?Q?teniYN3N0AkNhWJ+4kklihkm6SIs0G98m35vgegzCRMAT6xvrNZqGivQrkTs?=
 =?us-ascii?Q?6Eo7b/Xb1y4+O21fFmNwJhUUeO4w7KXjahcaePtu0Qs/Fjr0HDNJcV9s/+5i?=
 =?us-ascii?Q?oWgWxNJQbE8UrieflEo5URBKzQYNlu6rB5pf2ROkAMSzVK8zYYEr5pp/vRWc?=
 =?us-ascii?Q?vyoB7cBkfHIa/Leyl22vc+3UO2e7buVie8JXS4uT2v7nN5+XSJONWrNU6GhG?=
 =?us-ascii?Q?GZ0piIVuocSB45Khl0AI3wl8OF9tQiA++6Aqu9bpoEru3Yq9sg0a6yzkoTke?=
 =?us-ascii?Q?YRybVcca1/HeMEa2Jkg5zUn1y1Zd1ETjNHPCgDf77U9dcA2Z2tnc3X+jpf63?=
 =?us-ascii?Q?A9EwszJh7bhTI8/xYWqQke7mGv9BBDWGTAU9PO3dsp60P64Lq0ZThjvkbww/?=
 =?us-ascii?Q?QLBTQH7joVEaGxtMt4VDKzhNf3QS7iNVfo+I/ZP2PyLypkjsBinI5fER2+r2?=
 =?us-ascii?Q?w76na0J/YZBXGV8/7qB01rsz0gNvgaRIsLIeRvYfLYEUDYxlc2l0M1JH6Lev?=
 =?us-ascii?Q?/yrCUPLLIG/sVkwLQTROLo3FVBE4EYBX2NBfNsTN0N9rhVcmYEfUazsh7QyG?=
 =?us-ascii?Q?4vK4m7/KhOlFP87jrHFPNOnvP/yBRC9KvsKuxWEcNX7JqzZ7r8nL1ETxPFJa?=
 =?us-ascii?Q?6V9tMcq1BSzsDgZcOlWUrwztCxAzdPg9i9GhL8Gz2TBWioTVpF9uDIkTxJpU?=
 =?us-ascii?Q?V0B0/GW+xMKs3k/uMRKMtB5spcmpcXRDsFwGXlLXe9aZNzvhKn0/pdYmR4MB?=
 =?us-ascii?Q?ZwF0E+B78HyPhzfmY5NDa7YwF6+fjfkvbVoIJvsV1+bRYm3qNZty/FdnRxvK?=
 =?us-ascii?Q?iuyVH05lA2F6RBb0hrqSRGiXW6Bn0OLvxAFs3qkK9u2slmVJKVr4zaxN6uFV?=
 =?us-ascii?Q?7eZvtV+9gHUidGPHV2qPAk6mrZjyMwfGnSQ+UQK/hCn4o/9xkpq7UEAb7aOp?=
 =?us-ascii?Q?nTNQRU5SVtMvutPfduGKP2C6q5bgIM1aR3xGZT3c9wfrNNx/GNWpe0TPXt+7?=
 =?us-ascii?Q?kz3nWePm1oCTdBZhebBvUC925jkFW9MB4Zcg8wRYvus8XKCD7a5+/JOQUGMD?=
 =?us-ascii?Q?TfpjEB3NdxbkeDJP8Hi3dWvrLUG82GF00G+v9caPTMUG12fGVx2GBSlvoFFp?=
 =?us-ascii?Q?2Q+zvzxLSOjB65JxWjbftgESH4IqUmTHyeGDqqxznxhdLUNrUs8CWqWUbixN?=
 =?us-ascii?Q?eKSyRZAkyHfxhooIeeMqSl5jK/NtcCk0Xbzib1ZMjH0dyt3OPYvspcMMj4jk?=
 =?us-ascii?Q?akCaN+T81orwg5H6aDpDNJ1dTh+lo0WWncOjzSKMCLvPfOE2QMxcGvBzLB9b?=
 =?us-ascii?Q?eA5SWGF7pfJo2rsoEDW5PBkp0AwVyYM91EO0RZFXlpSNOSU7li4AuLqlfWaR?=
 =?us-ascii?Q?FbGOJpAWTkMIc+P+qkezdTazKd3qrxbtDQxcsla/tG3XPLDAlV2pDy6UdSDR?=
 =?us-ascii?Q?asBpTenIIOkvFEvERs5xpgNaDUnOqvotQycewigGLgWWC24cbmIaPt2AvOhQ?=
 =?us-ascii?Q?yI4gdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D2ZBP2qawOgQvPVf0FA38dWZuKPqOS99MmVGa/+pcyCRDSrdx/ZHMpJGxYt1ndXQ0qkKIGbeAnPVzcm47LApJvJIsZ7Yv0sZA4GCOTFjprSsF4WopRKTxw2kAnA1r/i50/JNdPpVgFbevYtDFuzQwrukvt3z3ImbSGaQ8N7BU4aAy+rkfpr5f/n+H4vMgbdVSeJtzfNe7hq7afpCE5wJIDVYSYFmxojDSsBqCqjoSfAfe55NgknXaEMsXBOEtjNOrurCPsE2kGsjiiOxwuIxxK3HV7or/PJ74oTSqTe9fshew1QJw8fkDeX/zDlMy+uw2y7m/PiucLkX26Ao6ggsi92Uxos43k3kjLu4XCqNtV7hA1eJyZhob5E1+KQ9259k1D5e2au2FTkSWvLSH7MDCiNxQfESoUqag3JmKA/HgS8myaMpIun2jS1k9v0E8Rf7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 08:54:18.4783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db30aeb-c86d-4a4c-895a-08de71eff6ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259863-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6089D16EBED
X-Rspamd-Action: no action

The br_vlan_opts_eq_range() function determines if consecutive VLANs can
be grouped together in a range for compact netlink notifications. It
currently checks state, tunnel info, and multicast router configuration,
but misses two categories of per-VLAN options that affect the output:
1. User-visible priv_flags (neigh_suppress, mcast_enabled)
2. Port multicast context options (mcast_max_groups, mcast_n_groups)

When VLANs have different settings for these options, they are incorrectly
grouped into ranges, causing netlink notifications to report only one
VLAN's settings for the entire range.

Fix by checking priv_flags equality, but only for flags that affect netlink
output (BR_VLFLAG_NEIGH_SUPPRESS_ENABLED and BR_VLFLAG_MCAST_ENABLED),
and comparing multicast context options (mcast_max_groups, mcast_n_groups).

Add a test with four test cases for each option, to ensure that VLANs with
different values are not grouped into ranges and VLANs with matching
values are properly grouped together.

Patchset overview:
Patch #1: fix
Patch #2: test

Danielle Ratson (2):
  bridge: Check relevant per-VLAN options in VLAN range grouping
  selftests: net: Add bridge VLAN range grouping tests

 net/bridge/br_private.h                       |  10 +
 net/bridge/br_vlan_options.c                  |  26 ++-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_vlan_dump.sh | 203 ++++++++++++++++++
 4 files changed, 237 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/bridge_vlan_dump.sh

-- 
2.51.0


