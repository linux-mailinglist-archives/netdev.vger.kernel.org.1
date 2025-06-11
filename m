Return-Path: <netdev+bounces-196595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A5AD585B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0217A40EF
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D23615B102;
	Wed, 11 Jun 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N2+T96sh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46D2E6108
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651433; cv=fail; b=guIay0uYP7RCHY6tF58jJkCk9O4z5YDIpaHP9X7yYsBzm1/kT0V7cXtca4UzO01ynsoilIiujF3NN1id9oLUNsqlIu2/leUvRqIfrS9kj48l1F9Mbrwtfm6RQr8BcrHTrvbq8LaKvNHbatRYgv+9tQcOzwmc4FmHUgSYNSWRJis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651433; c=relaxed/simple;
	bh=oREqrYVM7Kf/1m77NBkQslaH3cVffixsliPfK4X6j60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qzy58iJcdOJr9xHtduYCVgFdgYI0uI/SieIOTx4o8ml48+pwhTV1wsObEDffLT3WKJCp0CENKtk6AuqMATe5OaSiiarhs1sNPDKinIAsr2aEWeJhVhbmuGDN7VXhVhg01YMdN7awQYPwwgVMHIc8UPdRCuUMQdD3jDo3xQTezHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N2+T96sh; arc=fail smtp.client-ip=40.107.101.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4mtGtD6LdW6ZwhAjtfv+MP6bpw7EnnaLFgTuRJSpYl7xyteUPlp+FNwkTeV5IRlaKdjMYof9zIPiL/Y1haSXFG4CDQ1j6PbrAefm74yRUPqlEWrxUydxz9VW7cNiPfhYcxec0CUcal5CT34KHDuq6Q0dVF3sqAQEcc6FwJDHdVQnysvEvoGVQrka/6+9mFrPUdcbJnY0OMDy1oEyZOJGlpKU4p06YknLN8SCJJx33hPkyfQphkG0IblqQcy4HnLK/sn/zBy7E2yZ83TmeEFJpKml3wMiEtLXSpqEM2tT8JgnJNWiAzvk5znFgB6y7hOK+DZfrIV9zMY7L2iJMMVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zWApiQ2dQrjVwlLsuJun3uLjU+Nndq7um74XSdC4ZI=;
 b=dFYTSV/ymjmo1SSAgDweGxnElIIc9W1NMSFFDDw3GsqrE8L/Gm4eNK+LFIKHaEDzzsvzLjGHSjMTye1346Pb7iz8fl3lx37YI1kADdiMU9RI+eGlT9KvGh3C6rpUTJ5gK6jL5FcTS1CznxE9nqMSYrN28YfRMYSPQmHmMwsFvE3xzMlDkvV3nDdrFhEnu5xCVUwyKgLTSw9U8+wmosSar8DLXydWxWsyvQnTZi4gaZZrYuCHr57nEPlzOOxj+uBNfJtPEn2QOrSQVSpe6enk2Kmy5ZsmbBtWHGIJwfA6My1m1gCZ1JufSd7cSH6CvTtDZKE103pdq4hQ19soBkvwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zWApiQ2dQrjVwlLsuJun3uLjU+Nndq7um74XSdC4ZI=;
 b=N2+T96shWAGtN8eoFkYshq/SrnhQT3Cz9H9Zz5D4AB4a9ItGyF1wVcwT9mhRYi1w9jTDRwaT5QlHhtiDGdUOvxmoTcYqtu0egjKuxyjVl2lpDae6rHhtBfN93nRLISSDtg2AjAqrXE9N33FJvyb1t6WgfpElGJneVo1FWoUJbrD4qB/NV9LFDrVttd5ZzopydKLkXxbVX5pJZTQ5P6snMofvOyjGYPPfgdRAA+BMf67dCfBF/nnT3GXHBW/A9y5M0pTxx3vu7jSuxd78cfKxyzr8KyG5jUi6KwPA4XE/Ot1hLDfG1ecqvo0UQaF2sy2lGCDdbfM3GXpkF7QTzrinug==
Received: from BN9PR03CA0717.namprd03.prod.outlook.com (2603:10b6:408:ef::32)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Wed, 11 Jun
 2025 14:17:06 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::b4) by BN9PR03CA0717.outlook.office365.com
 (2603:10b6:408:ef::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 14:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.2 via Frontend Transport; Wed, 11 Jun 2025 14:17:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Jun
 2025 07:16:47 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 11 Jun
 2025 07:16:44 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <daniel@iogearbox.net>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next 1/2] neighbor: Add NTF_EXT_VALIDATED flag for externally validated entries
Date: Wed, 11 Jun 2025 17:15:50 +0300
Message-ID: <20250611141551.462569-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611141551.462569-1-idosch@nvidia.com>
References: <20250611141551.462569-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c11eb6-ef36-478f-7c38-08dda8f2a54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fdmkZ4BhIrN9u/UoPgfsFZj8npoQRgbSa29F+AfHnwMa6VG1Cm6hcZS0p/yJ?=
 =?us-ascii?Q?vMiBIHd0lfm15+f6yoKSQwVr2DkOXgDWYQOv1fCQBdbP+3olGjOTJLvPK4Kt?=
 =?us-ascii?Q?yHcUMIoB+87KUIjRSSYMzWXC1B2Ru6CzHwO00jJzlXGBTTb1tm8N1kShlM/b?=
 =?us-ascii?Q?t+7C7w2uJ2mCTJMgaV/fZyRYXq55xjMSDexNWTl/nAm6J/92WQ73D9hDgG7Y?=
 =?us-ascii?Q?CZw22gNnlXglDZ496W6lTQwwO+fAKPMZ0VpH+aHtTNzZ5QGIUXGdvX73joxF?=
 =?us-ascii?Q?wZZpb0hVlYTo7zK0UcIdfTvHTLtPvck6N2BOm5YRwCXtnnklXB6NlctlenGZ?=
 =?us-ascii?Q?7TE1MP1O8fXMR8JfAgkoNo3wkoN7PB0NriGs8vYN+muGJNBOG95D4xPOhLjW?=
 =?us-ascii?Q?0XWsplMJAv33oKPJ0NH2o9io57CW1uh0nXxW+QPpP3AhrbZlTOl/xuxlGJqb?=
 =?us-ascii?Q?Mgyt3U8tz99UdIIQN1UIR7TBRiV1dNFB9nyP/n2DP5dCvmMy7zv5FLB1z8kg?=
 =?us-ascii?Q?CXUkgDk81RRzohn0hxeG8Td7NC2zQVuCNIultCDAOmfcVVjhQtw/zNAubCDR?=
 =?us-ascii?Q?tvciDC7m4ETPbLxoGjUD6UL4lizc8cOfBbPiWwFSr4gDBdQzlTKBvIFfHi9l?=
 =?us-ascii?Q?6zlUIQqVDmFf1CtiVkLvVv8RF0/GNIRvsq6ybV8JAfeEWgsZJDNDXDRmeTas?=
 =?us-ascii?Q?tNZ/jJbn3SsNhnnXx5Ywpvmv9tI4JBMPEcfDaUk8koTy7Gaytu27cFWEEVYt?=
 =?us-ascii?Q?DrV+lGcKdUYGr/TqYCV7qnbZXxkhBE0OstIXnIpg1Dlnwg1pDxNnV1WGnfKc?=
 =?us-ascii?Q?mqrLcDLKPf4Q+2g8XuyCi3zmBOyiLgEQjD05S+pXLB73v8C3scq2/E+v/50N?=
 =?us-ascii?Q?mK5SL930c3Eh4mEWZOnAKf95xQxbngnqCiUChupkuYjxTcGKxjYLdFilMIly?=
 =?us-ascii?Q?qhyKmy72ojeZBoj75VCRhJ09fSgX+rbg60NeEMMmM7Fx3xsVNmM0/6qmhzmh?=
 =?us-ascii?Q?gqy2r5aOTuMc6rwQu7wRSxuHB72KDfq8SkMvFqeljOIZzOr131KER5/JlXvf?=
 =?us-ascii?Q?JzYeuW2DT6AzGtCvWzd+FlfEMgNBdg/dW70+U6DJNKnrmtNeUu/LkN/9cIi1?=
 =?us-ascii?Q?rDR09XXX01Vg1C3TmkqIBMeBmzpdwi/mZo4MXwTGZYSuhlSFIFcZbar2Kk6r?=
 =?us-ascii?Q?Omlnflim7AbrBFozlKxj+eSU240l+6yxobdSDAv5Ch4GuH6pibGjUZ+qjgpP?=
 =?us-ascii?Q?lYDiDP+XdzLWmzGvuni1/2rVCw1SqLb45reiqrUHyHHtYbb/BFnRwkEM8mqI?=
 =?us-ascii?Q?Ijp3Zz+BtJNvvcOyk7oK4e46NJCnMPABMnjiZT7463tecrmARCrmzpOw0Gnu?=
 =?us-ascii?Q?bwofc33tkdWJOkkJeLcy7ShdGMo4RNbHCXJ9ssSpCRHOTcPxpiAfHSDMam2z?=
 =?us-ascii?Q?zJbrQeGN4UiYyqcuPCb6gLSEFv4b3jkEL32LjU6zHWf6coz9DZKWaogLjXzb?=
 =?us-ascii?Q?kwI/fU9XoeYg5kvf5wOcCcl/k+xVVzs9olFI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:17:06.3282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c11eb6-ef36-478f-7c38-08dda8f2a54c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

tl;dr
=====

Add a new neighbor flag ("extern_valid") that can be used to indicate to
the kernel that a neighbor entry was learned and determined to be valid
externally. The kernel will not try to remove or invalidate such an
entry, leaving these decisions to the user space control plane. This is
needed for EVPN multi-homing where a neighbor entry for a multi-homed
host needs to be synced across all the VTEPs among which the host is
multi-homed.

Background
==========

In a typical EVPN multi-homing setup each host is multi-homed using a
set of links called ES (Ethernet Segment, i.e., LAG) to multiple leaf
switches (VTEPs). VTEPs that are connected to the same ES are called ES
peers.

When a neighbor entry is learned on a VTEP, it is distributed to both ES
peers and remote VTEPs using EVPN MAC/IP advertisement routes. ES peers
use the neighbor entry when routing traffic towards the multi-homed host
and remote VTEPs use it for ARP/NS suppression.

Motivation
==========

If the ES link between a host and the VTEP on which the neighbor entry
was locally learned goes down, the EVPN MAC/IP advertisement route will
be withdrawn and the neighbor entries will be removed from both ES peers
and remote VTEPs. Routing towards the multi-homed host and ARP/NS
suppression can fail until another ES peer locally learns the neighbor
entry and distributes it via an EVPN MAC/IP advertisement route.

"draft-rbickhart-evpn-ip-mac-proxy-adv-03" [1] suggests avoiding these
intermittent failures by having the ES peers install the neighbor
entries as before, but also injecting EVPN MAC/IP advertisement routes
with a proxy indication. When the previously mentioned ES link goes down
and the original EVPN MAC/IP advertisement route is withdrawn, the ES
peers will not withdraw their neighbor entries, but instead start aging
timers for the proxy indication.

If an ES peer locally learns the neighbor entry (i.e., it becomes
"reachable"), it will restart its aging timer for the entry and emit an
EVPN MAC/IP advertisement route without a proxy indication. An ES peer
will stop its aging timer for the proxy indication if it observes the
removal of the proxy indication from at least one of the ES peers
advertising the entry.

In the event that the aging timer for the proxy indication expired, an
ES peer will withdraw its EVPN MAC/IP advertisement route. If the timer
expired on all ES peers and they all withdrew their proxy
advertisements, the neighbor entry will be completely removed from the
EVPN fabric.

Implementation
==============

In the above scheme, when the control plane (e.g., FRR) advertises a
neighbor entry with a proxy indication, it expects the corresponding
entry in the data plane (i.e., the kernel) to remain valid and not be
removed due to garbage collection. The control plane also expects the
kernel to notify it if the entry was learned locally (i.e., became
"reachable") so that it will remove the proxy indication from the EVPN
MAC/IP advertisement route. That is why these entries cannot be
programmed with dummy states such as "permanent" or "noarp".

Instead, add a new neighbor flag ("extern_valid") which indicates that
the entry was learned and determined to be valid externally and should
not be removed or invalidated by the kernel. The kernel can probe the
entry and notify user space when it becomes "reachable". However, if the
kernel does not receive a confirmation, have it return the entry to the
"stale" state instead of the "failed" state.

In other words, an entry marked with the "extern_valid" flag behaves
like any other dynamically learned entry other than the fact that the
kernel cannot remove or invalidate it.

One can argue that the "extern_valid" flag should not prevent garbage
collection and that instead a neighbor entry should be programmed with
both the "extern_valid" and "extern_learn" flags. There are two reasons
for not doing that:

1. Unclear why a control plane would like to program an entry that the
   kernel cannot invalidate but can completely remove.

2. The "extern_learn" flag is used by FRR for neighbor entries learned
   on remote VTEPs (for ARP/NS suppression) whereas here we are
   concerned with local entries. This distinction is currently irrelevant
   for the kernel, but might be relevant in the future.

Given that the flag only makes sense when the neighbor has a valid
state, reject attempts to add a neighbor with an invalid state and with
this flag set. For example:

 # ip neigh add 192.0.2.1 nud none dev br0.10 extern_valid
 Error: Cannot create externally validated neighbor with an invalid state.
 # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid
 # ip neigh replace 192.0.2.1 nud failed dev br0.10 extern_valid
 Error: Cannot mark neighbor as externally validated with an invalid state.

The above means that a neighbor cannot be created with the
"extern_valid" flag and flags such as "use" or "managed" as they result
in a neighbor being created with an invalid state ("none") and
immediately getting probed:

 # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
 Error: Cannot create externally validated neighbor with an invalid state.

However, these flags can be used together with "extern_valid" after the
neighbor was created with a valid state:

 # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid
 # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use

One consequence of preventing the kernel from invalidating a neighbor
entry is that by default it will only try to determine reachability
using unicast probes. This can be changed using the "mcast_resolicit"
sysctl:

 # sysctl net.ipv4.neigh.br0/10.mcast_resolicit
 0
 # tcpdump -nn -e -i br0.10 -Q out arp &
 # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 # sysctl -wq net.ipv4.neigh.br0/10.mcast_resolicit=3
 # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28

iproute2 patches can be found here [2].

[1] https://datatracker.ietf.org/doc/html/draft-rbickhart-evpn-ip-mac-proxy-adv-03
[2] https://github.com/idosch/iproute2/tree/submit/extern_valid_v1

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 Documentation/netlink/specs/rt-neigh.yaml |  1 +
 include/net/neighbour.h                   |  4 +-
 include/uapi/linux/neighbour.h            |  5 ++
 net/core/neighbour.c                      | 75 ++++++++++++++++++++---
 4 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index e9cba164e3d1..e263b8d60467 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -79,6 +79,7 @@ definitions:
     entries:
       - managed
       - locked
+      - ext-validated
   -
     name: rtm-type
     type: enum
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 9a832cab5b1d..8d69d0f104d9 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -260,13 +260,15 @@ static inline void *neighbour_priv(const struct neighbour *n)
 #define NEIGH_UPDATE_F_EXT_LEARNED		BIT(5)
 #define NEIGH_UPDATE_F_ISROUTER			BIT(6)
 #define NEIGH_UPDATE_F_ADMIN			BIT(7)
+#define NEIGH_UPDATE_F_EXT_VALIDATED		BIT(8)
 
 /* In-kernel representation for NDA_FLAGS_EXT flags: */
 #define NTF_OLD_MASK		0xff
 #define NTF_EXT_SHIFT		8
-#define NTF_EXT_MASK		(NTF_EXT_MANAGED)
+#define NTF_EXT_MASK		(NTF_EXT_MANAGED | NTF_EXT_EXT_VALIDATED)
 
 #define NTF_MANAGED		(NTF_EXT_MANAGED << NTF_EXT_SHIFT)
+#define NTF_EXT_VALIDATED	(NTF_EXT_EXT_VALIDATED << NTF_EXT_SHIFT)
 
 extern const struct nla_policy nda_policy[];
 
diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index b851c36ad25d..27bedfcce537 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -54,6 +54,7 @@ enum {
 /* Extended flags under NDA_FLAGS_EXT: */
 #define NTF_EXT_MANAGED		(1 << 0)
 #define NTF_EXT_LOCKED		(1 << 1)
+#define NTF_EXT_EXT_VALIDATED	(1 << 2)
 
 /*
  *	Neighbor Cache Entry States.
@@ -92,6 +93,10 @@ enum {
  * bridge in response to a host trying to communicate via a locked bridge port
  * with MAB enabled. Their purpose is to notify user space that a host requires
  * authentication.
+ *
+ * NTF_EXT_EXT_VALIDATED flagged neigbor entries were externally validated by a
+ * user space control plane. The kernel will not remove or invalidate them, but
+ * it can probe them and notify user space when they become reachable.
  */
 
 struct nda_cacheinfo {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index a6e2c91ec3e7..be229f3f5a85 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -153,11 +153,12 @@ static void neigh_update_gc_list(struct neighbour *n)
 	if (n->dead)
 		goto out;
 
-	/* remove from the gc list if new state is permanent or if neighbor
-	 * is externally learned; otherwise entry should be on the gc list
+	/* remove from the gc list if new state is permanent or if neighbor is
+	 * externally learned / validated; otherwise entry should be on the gc
+	 * list
 	 */
 	exempt_from_gc = n->nud_state & NUD_PERMANENT ||
-			 n->flags & NTF_EXT_LEARNED;
+			 n->flags & (NTF_EXT_LEARNED | NTF_EXT_VALIDATED);
 	on_gc_list = !list_empty(&n->gc_list);
 
 	if (exempt_from_gc && on_gc_list) {
@@ -204,6 +205,7 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 
 	ndm_flags  = (flags & NEIGH_UPDATE_F_EXT_LEARNED) ? NTF_EXT_LEARNED : 0;
 	ndm_flags |= (flags & NEIGH_UPDATE_F_MANAGED) ? NTF_MANAGED : 0;
+	ndm_flags |= (flags & NEIGH_UPDATE_F_EXT_VALIDATED) ? NTF_EXT_VALIDATED : 0;
 
 	if ((old_flags ^ ndm_flags) & NTF_EXT_LEARNED) {
 		if (ndm_flags & NTF_EXT_LEARNED)
@@ -221,6 +223,14 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 		*notify = 1;
 		*managed_update = true;
 	}
+	if ((old_flags ^ ndm_flags) & NTF_EXT_VALIDATED) {
+		if (ndm_flags & NTF_EXT_VALIDATED)
+			neigh->flags |= NTF_EXT_VALIDATED;
+		else
+			neigh->flags &= ~NTF_EXT_VALIDATED;
+		*notify = 1;
+		*gc_update = true;
+	}
 }
 
 bool neigh_remove_one(struct neighbour *n)
@@ -937,7 +947,8 @@ static void neigh_periodic_work(struct work_struct *work)
 
 			state = n->nud_state;
 			if ((state & (NUD_PERMANENT | NUD_IN_TIMER)) ||
-			    (n->flags & NTF_EXT_LEARNED)) {
+			    (n->flags &
+			     (NTF_EXT_LEARNED | NTF_EXT_VALIDATED))) {
 				write_unlock(&n->lock);
 				continue;
 			}
@@ -1090,9 +1101,15 @@ static void neigh_timer_handler(struct timer_list *t)
 
 	if ((neigh->nud_state & (NUD_INCOMPLETE | NUD_PROBE)) &&
 	    atomic_read(&neigh->probes) >= neigh_max_probes(neigh)) {
-		WRITE_ONCE(neigh->nud_state, NUD_FAILED);
+		if (neigh->nud_state == NUD_PROBE &&
+		    neigh->flags & NTF_EXT_VALIDATED) {
+			WRITE_ONCE(neigh->nud_state, NUD_STALE);
+			neigh->updated = jiffies;
+		} else {
+			WRITE_ONCE(neigh->nud_state, NUD_FAILED);
+			neigh_invalidate(neigh);
+		}
 		notify = 1;
-		neigh_invalidate(neigh);
 		goto out;
 	}
 
@@ -1240,6 +1257,8 @@ static void neigh_update_hhs(struct neighbour *neigh)
 				NTF_ROUTER flag.
 	NEIGH_UPDATE_F_ISROUTER	indicates if the neighbour is known as
 				a router.
+	NEIGH_UPDATE_F_EXT_VALIDATED means that the entry will not be removed
+				or invalidated.
 
    Caller MUST hold reference count on the entry.
  */
@@ -1974,7 +1993,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
-		if (ndm_flags & NTF_MANAGED) {
+		if (ndm_flags & (NTF_MANAGED | NTF_EXT_VALIDATED)) {
 			NL_SET_ERR_MSG(extack, "Invalid NTF_* flag combination");
 			goto out;
 		}
@@ -2004,7 +2023,8 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (neigh == NULL) {
 		bool ndm_permanent  = ndm->ndm_state & NUD_PERMANENT;
 		bool exempt_from_gc = ndm_permanent ||
-				      ndm_flags & NTF_EXT_LEARNED;
+				      ndm_flags & (NTF_EXT_LEARNED |
+						   NTF_EXT_VALIDATED);
 
 		if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
 			err = -ENOENT;
@@ -2015,10 +2035,27 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			err = -EINVAL;
 			goto out;
 		}
+		if (ndm_flags & NTF_EXT_VALIDATED) {
+			u8 state = ndm->ndm_state;
+
+			/* NTF_USE and NTF_MANAGED will result in the neighbor
+			 * being created with an invalid state (NUD_NONE).
+			 */
+			if (ndm_flags & (NTF_USE | NTF_MANAGED))
+				state = NUD_NONE;
+
+			if (!(state & NUD_VALID)) {
+				NL_SET_ERR_MSG(extack,
+					       "Cannot create externally validated neighbor with an invalid state");
+				err = -EINVAL;
+				goto out;
+			}
+		}
 
 		neigh = ___neigh_create(tbl, dst, dev,
 					ndm_flags &
-					(NTF_EXT_LEARNED | NTF_MANAGED),
+					(NTF_EXT_LEARNED | NTF_MANAGED |
+					 NTF_EXT_VALIDATED),
 					exempt_from_gc, true);
 		if (IS_ERR(neigh)) {
 			err = PTR_ERR(neigh);
@@ -2030,6 +2067,24 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			neigh_release(neigh);
 			goto out;
 		}
+		if (ndm_flags & NTF_EXT_VALIDATED) {
+			u8 state = ndm->ndm_state;
+
+			/* NTF_USE and NTF_MANAGED do not update the existing
+			 * state other than clearing it if it was
+			 * NUD_PERMANENT.
+			 */
+			if (ndm_flags & (NTF_USE | NTF_MANAGED))
+				state = READ_ONCE(neigh->nud_state) & ~NUD_PERMANENT;
+
+			if (!(state & NUD_VALID)) {
+				NL_SET_ERR_MSG(extack,
+					       "Cannot mark neighbor as externally validated with an invalid state");
+				err = -EINVAL;
+				neigh_release(neigh);
+				goto out;
+			}
+		}
 
 		if (!(nlh->nlmsg_flags & NLM_F_REPLACE))
 			flags &= ~(NEIGH_UPDATE_F_OVERRIDE |
@@ -2046,6 +2101,8 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		flags |= NEIGH_UPDATE_F_MANAGED;
 	if (ndm_flags & NTF_USE)
 		flags |= NEIGH_UPDATE_F_USE;
+	if (ndm_flags & NTF_EXT_VALIDATED)
+		flags |= NEIGH_UPDATE_F_EXT_VALIDATED;
 
 	err = __neigh_update(neigh, lladdr, ndm->ndm_state, flags,
 			     NETLINK_CB(skb).portid, extack);
-- 
2.49.0


