Return-Path: <netdev+bounces-259865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG6/Ik7FmmlHiQMAu9opvQ
	(envelope-from <netdev+bounces-259865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:58:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC4C16EC03
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDA8D3066802
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E762066F7;
	Sun, 22 Feb 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfApMbCZ"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFD204F8B;
	Sun, 22 Feb 2026 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750478; cv=fail; b=px9fVeX8kLR/kromMuBomCSLxXN8nxIyiwNOXkDFNZd36o/36jBHGyFgpHJyLYcdDDDUQpcC55nwxWrrn3Bs4Lre0wDV1zgpmJhRnDHWPcG86JjI6Es59EPdI+x5lr8IxJ3RRCnrAP0CNzhz1nM5r7mjrUDfeM30a1bGi1Ui3tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750478; c=relaxed/simple;
	bh=0pkNlM9NQIHe1BScPjuFz9u7mPXwXdB8L/S90wPHt0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBtsO2m1VcmMou46e9mbJ5jIOJBt3A41coNAXmK/XRxxjj/Ib1nR/4Q/BX8B7p9J1wZYko9MSxS4iETEiHBM42iYVJ5yf45bZmHeCSht0CBNJjblRz7FoqQY26dwkNmNxMpSL2YmtNrHGVZq/ZowaJN4sHILXcIEj9qsdD2WtX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfApMbCZ; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktrSxO64WffCGdFi1842+2E+ARfBct89oF7dN4qgIdU09LOCgKgt9f6Ndi2WmnYLzQANWRy1ndERuIe88GNWRaUIe4vAjGIU3S7uqMTNnVA2zj9wMvABAXSvTShKsdBP74zs0OptQgiPItLnBwiNDAb9EycXeT4pwN+0kLWMaBULTNBojOAWIYV8a9g3+cMa98YpxrFAYDDh3BDYowy5a8GdbmRHjrkUGl8agGmGivkOMd4B6YQ8HStCArBOgGyguSz+6/QPt+P2NG/w7hYt1gBS8bm0thUXcKNMbe5K4wf4jNpLaz7nTALCv46Im9GzMMidrOvpeiqsG8Tk7BMPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM5CIBMgGI+dtgj5ee63il0fBKwu1oLDbnP63CsqeQg=;
 b=tYga8ffslRfrgdcV/JCUwWr38ZBzi4FPuDs7QRU+PyOC6MeUTKv1Hk2gbtoenHos+gfAobRTh0mOqkPU/VLnwVPCOC+jGpCHslP5eVd+AlHIfj++vq0OMe70nys63f0zVhfT+uwg5E/p5aKxTaLQxnKiuifntUL3X/0nSIjjldJvLnhuIVgre2aSAKaq+CkQsqmWDlHrw/OhWU1hvogmfJ1/mgFJwYxR/XatQ28G2nHtSTo1jXFpznZn4ARJoyPN/dtaQsB6l8oSC38O5AIu66rfJX75UYZZN9Zf+ubVqP5/oAueLGG/WptSQ9uTnoOHxFqo1ZUwApdQP6rxxpDJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM5CIBMgGI+dtgj5ee63il0fBKwu1oLDbnP63CsqeQg=;
 b=mfApMbCZEB3hJjUKUs0UP409Egccf5RMVDz91uQPr4yGgGEMXq9rD8EbAx0bSyI6HFiGOtU8L+FVAckOF//JLgJlgwL1khBm28qjsxd+mac+efvAUd6mCM+cKYsOPF6tc1/FYc2NMiWaXMqfvFK7W1n6xiJ5y2tSAP0Ch6yXDtBq3dWAEbUuOvTBuCSea6ycrYvnbFgdGuaqrdtMIviMw6FxzM/v1TATTXFCkp6p7O47qvsLpZd+N8fM0wE1NdgYJCFh903oibRRF9cPuu8BKBiqI8j2CLXzsj2zOAe9oiiI04aowZq8tiQWzZFEkDZLC+Vhz98mx75ENzUOaWdVrQ==
Received: from BY5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:180::36)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Sun, 22 Feb
 2026 08:54:31 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::61) by BY5PR13CA0023.outlook.office365.com
 (2603:10b6:a03:180::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.17 via Frontend Transport; Sun,
 22 Feb 2026 08:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 22 Feb 2026 08:54:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 00:54:17 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 22 Feb 2026 00:54:13 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net 2/2] selftests: net: Add bridge VLAN range grouping tests
Date: Sun, 22 Feb 2026 10:53:38 +0200
Message-ID: <20260222085338.3143823-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222085338.3143823-1-danieller@nvidia.com>
References: <20260222085338.3143823-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8e593e-54bd-42bf-0807-08de71effe4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xxhQEh1zHhwpE51IaQYdh7QLd0x5jDjWpP8IbxmwqdQ8quXOXy1qdN7U7cJK?=
 =?us-ascii?Q?XVkDZPmlWmg06CVjeS7alJ7AcbOSo8Gn/QV0099JuNfCOpcNgm2Ck7LDS+kE?=
 =?us-ascii?Q?XooEWGXhm65iFA4KZ12p2uRRzttau9PHT+QLFinl1Z+A6QWBSMBqJdRRd22l?=
 =?us-ascii?Q?FAcVWyHpDGiePQ7gZVChbMPxV/mvm5pkz0UUn41K87WccdDm27Ar7W40MBkg?=
 =?us-ascii?Q?3AX5y/B5FhI2LOfO0CsXKjVTATe8fAQ/rjyxstQ9Tm6gfILwYRkSgrqBagbU?=
 =?us-ascii?Q?EBwdIYRkIKIJpGznMMi2Giu3ds5XG0gugsUxKE6XhqZlEte2O5X/WLiyXupS?=
 =?us-ascii?Q?Vdacb7Gs8ZPlub8inGde6cGUuLkG8P1b2yCW628ec7JJWveF2bV+JeKsMLjg?=
 =?us-ascii?Q?Sd0HbncZfvg/c5nD/dqLG+K9vAaxug7MDgYkTR22aKvAhojtOeaareVFDeD2?=
 =?us-ascii?Q?gb5irS3SHevpRYp6akfxKUHnTBEtVtBMv7S9sRFZDs47lDWcP92+JGTNXaU5?=
 =?us-ascii?Q?iNsQiL87+D6bW2vvklCx/Ld4HMrU9saBRnaTvSqfI+q8j9I5LZZaq1J7hAWy?=
 =?us-ascii?Q?iJsYt6ZPmnnPtvKt3dQQ79JAF5ExVQqb0mf/k5Ekp9kzbshhKUudFJMgU9tk?=
 =?us-ascii?Q?sqlKT/fwy4usY/NhrV0XkTtFlQHuU+GG/YrFrMfnPQyGFTPtC4VT8o4VLCdi?=
 =?us-ascii?Q?ZeLvuQTBeM5/8rKFe2y4ryI0SOFyLa2jnn5DDlELF1ZBIGn6JZ7vZA6N1PCs?=
 =?us-ascii?Q?IobQmlRoCd+7ZSON1nd34BEuj2QmpIim0UuK4rzRD9cqHIT1Tw57mMfZTEor?=
 =?us-ascii?Q?y1U4KP1gDiQZ5BYN2xjb9L3EPrhaggwh8V16ZGB1eudfaACEB/TBENWS6p82?=
 =?us-ascii?Q?U4dr/eJm0ig3BIwQ8+K6MsWcoJ3f2i+qfStIEloZoZ1eKqU9bu+N84uvhKvA?=
 =?us-ascii?Q?7eIOAs2/dMJgKRSx1Ao2ZiQ4eTTMmHIATnAkQSUunqHWbL2hGkgzTLbgoqfm?=
 =?us-ascii?Q?L38Zv07XRcrDPiQS33e0ylCe322f4NDiQYr5LdGCFzL2/oHafdTNFlKqFdft?=
 =?us-ascii?Q?1VcfIm6m6A6U5XCM0NSYbUWse4U8vlo5jxNb0mKFtUXogCHeikL1Ix49zimY?=
 =?us-ascii?Q?DpBjdnHIcXDuBxECKg+u05Ay8YaEEjD5XtyqeR32eZdxsr/HySlw66/nGKBo?=
 =?us-ascii?Q?sNNNJsp4V6BPbc/LoKocp4LjaKny/u8mz5OFckb6SaJRwCcxoLPVaq0EhgZq?=
 =?us-ascii?Q?05BvyKE2hmjUdFNPlc1JwUhn/JFu/cttN+K77JWhOtSK8/QBsqPU742Iijq3?=
 =?us-ascii?Q?hSKwaNtxicgZ5gqFcUU2yBVZGhJSwJVi+Gdx9ynAuZSfBtn1ZEHwoEoP9bWZ?=
 =?us-ascii?Q?e+FlE8jCsOOedpm4AkAbf25gzQ4AfLZ6zau/XKpLj1DcC5byUIRPx9hHzdGw?=
 =?us-ascii?Q?ibi9MsRXAIvjwZEqmeAyE+AqPH/O1pK3u5wJ4FNWemEPVWecJSanCvoKKF7V?=
 =?us-ascii?Q?go3Etbi08ZGLq76WyOo+lzpp0dIXfqU7s75g4fbO78L6JtGIVQtf80pQh9+z?=
 =?us-ascii?Q?HpLRPOchy471O/ZKcvhHcQi+FC5p5Hsr58CFCjfyWlYFgXxgYI+qNVPSvVzM?=
 =?us-ascii?Q?32YfFbynew9VRhN6LFa22wA05YmK1GG9B6Zmbi4i2y8+PhJypKzHGGGd0Yus?=
 =?us-ascii?Q?bUMCAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/3vWlUafygyxzLQ6sr6yMSl3K01I0BXjIzp1h3l+drQzD+N3lPJ2egW3SN3QFTDs8+DUacLuuN24csEZGwMJUgDryWhvtRVn15SjatBdKNIVDoPzfNVrpF/X8ZL2MsK+4qCeBx5vLkCT71uILceJ0hJaoeQBKX/BfCwow9WXANSNsaMA/CNaG90MUJrUUKLEeWCYmHWaquS+atfbeXsGGwdLIhynNRTRCbY6BpEywtwM6KwbNIAff400WqHESjDuq/g4Z31h7UC5TAbHb2eVBn+V8gM/irYllLjGSAz/pJ+5gocuAVqlEZf1vRTZB3t1F2A5ALYvmN9ZYOs0RozorHsdNv6p+fQJ5wbywfkBUzFR8B50LKPEenY+oICNY/hYJFmkJUdzdjDH7aw/6VZYyxuLECM1ipjol4Kd6fzEJUqJVRksYjCUSZSCR3jPDFXU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 08:54:31.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8e593e-54bd-42bf-0807-08de71effe4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DDC4C16EC03
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
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_vlan_dump.sh | 203 ++++++++++++++++++
 2 files changed, 204 insertions(+)
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
index 000000000000..00464f02b6cc
--- /dev/null
+++ b/tools/testing/selftests/net/bridge_vlan_dump.sh
@@ -0,0 +1,203 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test bridge VLAN range grouping. VLANs are collapsed into a range entry in
+# the dump if they have the same per-VLAN options. These tests verify that
+# VLANs with different per-VLAN option values are not grouped together.
+
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
+	ip -n $NS link add name br0 type bridge vlan_filtering 1 \
+		vlan_default_pvid 0 mcast_snooping 1 mcast_vlan_snooping 1
+	ip -n $NS link set dev br0 up
+
+	ip -n $NS link add name dummy0 type dummy
+	ip -n $NS link set dev dummy0 master br0
+	ip -n $NS link set dev dummy0 up
+}
+
+vlan_range_neigh_suppress()
+{
+	RET=0
+
+	# Add two new consecutive VLANs for range grouping test
+	bridge -n $NS vlan add vid 10 dev dummy0
+	defer bridge -n $NS vlan del vid 10 dev dummy0
+
+	bridge -n $NS vlan add vid 11 dev dummy0
+	defer bridge -n $NS vlan del vid 11 dev dummy0
+
+	# Configure different neigh_suppress values and verify no range grouping
+	bridge -n $NS vlan set vid 10 dev dummy0 neigh_suppress on
+	check_err $? "Failed to set neigh_suppress for VLAN 10"
+
+	bridge -n $NS vlan set vid 11 dev dummy0 neigh_suppress off
+	check_err $? "Failed to set neigh_suppress for VLAN 11"
+
+	# Verify VLANs are not shown as a range, but individual entries exist
+	bridge -n $NS -d vlan show dev dummy0 | grep -q "10-11"
+	check_fail $? "VLANs with different neigh_suppress incorrectly grouped"
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -Eq "^\S+\s+10$|^\s+10$"
+	check_err $? "VLAN 10 individual entry not found"
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -Eq "^\S+\s+11$|^\s+11$"
+	check_err $? "VLAN 11 individual entry not found"
+
+	# Configure same neigh_suppress value and verify range grouping
+	bridge -n $NS vlan set vid 11 dev dummy0 neigh_suppress on
+	check_err $? "Failed to set neigh_suppress for VLAN 11"
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -q "10-11"
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
+	bridge -n $NS vlan add vid 10 dev dummy0
+	defer bridge -n $NS vlan del vid 10 dev dummy0
+
+	bridge -n $NS vlan add vid 11 dev dummy0
+	defer bridge -n $NS vlan del vid 11 dev dummy0
+
+	# Configure different mcast_max_groups values and verify no range grouping
+	bridge -n $NS vlan set vid 10 dev dummy0 mcast_max_groups 100
+	check_err $? "Failed to set mcast_max_groups for VLAN 10"
+
+	bridge -n $NS vlan set vid 11 dev dummy0 mcast_max_groups 200
+	check_err $? "Failed to set mcast_max_groups for VLAN 11"
+
+	# Verify VLANs are not shown as a range, but individual entries exist
+	bridge -n $NS -d vlan show dev dummy0 | grep -q "10-11"
+	check_fail $? "VLANs with different mcast_max_groups incorrectly grouped"
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -Eq "^\S+\s+10$|^\s+10$"
+	check_err $? "VLAN 10 individual entry not found"
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -Eq "^\S+\s+11$|^\s+11$"
+	check_err $? "VLAN 11 individual entry not found"
+
+	# Configure same mcast_max_groups value and verify range grouping
+	bridge -n $NS vlan set vid 11 dev dummy0 mcast_max_groups 100
+	check_err $? "Failed to set mcast_max_groups for VLAN 11"
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -q "10-11"
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
+	bridge -n $NS vlan add vid 10 dev dummy0
+	defer bridge -n $NS vlan del vid 10 dev dummy0
+
+	bridge -n $NS vlan add vid 11 dev dummy0
+	defer bridge -n $NS vlan del vid 11 dev dummy0
+
+	# Add different numbers of multicast groups to each VLAN
+	bridge -n $NS mdb add dev br0 port dummy0 grp 239.1.1.1 vid 10
+	check_err $? "Failed to add mdb entry to VLAN 10"
+	defer bridge -n $NS mdb del dev br0 port dummy0 grp 239.1.1.1 vid 10
+
+	bridge -n $NS mdb add dev br0 port dummy0 grp 239.1.1.2 vid 10
+	check_err $? "Failed to add second mdb entry to VLAN 10"
+	defer bridge -n $NS mdb del dev br0 port dummy0 grp 239.1.1.2 vid 10
+
+	bridge -n $NS mdb add dev br0 port dummy0 grp 239.1.1.1 vid 11
+	check_err $? "Failed to add mdb entry to VLAN 11"
+	defer bridge -n $NS mdb del dev br0 port dummy0 grp 239.1.1.1 vid 11
+
+	# Verify VLANs are not shown as a range due to different mcast_n_groups
+	bridge -n $NS -d vlan show dev dummy0 | grep -q "10-11"
+	check_fail $? "VLANs with different mcast_n_groups incorrectly grouped"
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -Eq "^\S+\s+10$|^\s+10$"
+	check_err $? "VLAN 10 individual entry not found"
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -Eq "^\S+\s+11$|^\s+11$"
+	check_err $? "VLAN 11 individual entry not found"
+
+	# Add another group to VLAN 11 to match VLAN 10's count
+	bridge -n $NS mdb add dev br0 port dummy0 grp 239.1.1.2 vid 11
+	check_err $? "Failed to add second mdb entry to VLAN 11"
+	defer bridge -n $NS mdb del dev br0 port dummy0 grp 239.1.1.2 vid 11
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -q "10-11"
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
+	bridge -n $NS vlan add vid 10 dev br0 self
+	defer bridge -n $NS vlan del vid 10 dev br0 self
+
+	bridge -n $NS vlan add vid 11 dev br0 self
+	defer bridge -n $NS vlan del vid 11 dev br0 self
+
+	bridge -n $NS vlan add vid 10 dev dummy0
+	defer bridge -n $NS vlan del vid 10 dev dummy0
+
+	bridge -n $NS vlan add vid 11 dev dummy0
+	defer bridge -n $NS vlan del vid 11 dev dummy0
+
+	# Configure different mcast_snooping for bridge VLANs
+	# Port VLANs inherit BR_VLFLAG_MCAST_ENABLED from bridge VLANs
+	bridge -n $NS vlan global set dev br0 vid 10 mcast_snooping 1
+	bridge -n $NS vlan global set dev br0 vid 11 mcast_snooping 0
+
+	# Verify port VLANs are not grouped due to different mcast_enabled
+	bridge -n $NS -d vlan show dev dummy0 | grep -q "10-11"
+	check_fail $? "VLANs with different mcast_enabled incorrectly grouped"
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -Eq "^\S+\s+10$|^\s+10$"
+	check_err $? "VLAN 10 individual entry not found"
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -Eq "^\S+\s+11$|^\s+11$"
+	check_err $? "VLAN 11 individual entry not found"
+
+	# Configure same mcast_snooping and verify range grouping
+	bridge -n $NS vlan global set dev br0 vid 11 mcast_snooping 1
+
+	bridge -n $NS -d vlan show dev dummy0 | grep -q "10-11"
+	check_err $? "VLANs with same mcast_enabled not grouped"
+
+	log_test "VLAN range grouping with mcast_enabled"
+}
+
+# Verify the newest tested option is supported
+if ! bridge vlan help 2>&1 | grep -q "neigh_suppress"; then
+	echo "SKIP: iproute2 too old, missing per-VLAN neighbor suppression support"
+	exit $ksft_skip
+fi
+
+trap defer_scopes_cleanup EXIT
+setup_prepare
+tests_run
+
+exit $EXIT_STATUS
-- 
2.51.0


