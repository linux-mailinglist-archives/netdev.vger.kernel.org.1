Return-Path: <netdev+bounces-148515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C249E1F3E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6AC1639E0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CE71F12FC;
	Tue,  3 Dec 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E5HSvSKu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D71F4283
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236402; cv=fail; b=S4j7EemdDLlvknGz6INivCfpCTsNRuwamDVSVG+oQjzM+UOm1zRMDW+bkhUW+l+omP9+CER+k3u94PebQRePUt+M53qdqrSj2O7ztsIvi1mfxx+vq/qRw8+BEDlkeWbTXpBCBbY0M63pjSDAY8kaPMEE2svjSSenb2x+bsAhgYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236402; c=relaxed/simple;
	bh=gpg07kQ+XeMAuvfRma1Nn2KDn9+9j4jOwF7aqxERuP4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lfDljb5G5VZAjAq1sTX+Jh/GCa03LJsrs/eqKgsRxVq86oXCi6LWjFP8rwD7lEzckDfqMVqQ20kgg6SYBriMD+JrqPxRJnHXnMFXipJjpxK/qJHr4Ls3x72WMSckrN3t3MwmocXkUQKcsdW8y/cahmagHAqE3qbB8SZnSpgFx+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E5HSvSKu; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r12jE63NKUqZknYHiYVew7/UCH1LGcXxDxJkCwnUcOyhuva4+niKi+hF22llRGwXfpEUS9HeAQKqNPP1pWb1NTXjRmrRtE9E4skk3Js3MpczDgSJpRpokBemVyQ1NWgCpHXDgeaA8XtifSczmqy/3+SEXbutLsgyakYIhjEXDrqQCH1gYYin1ayVGbzsdXWXHkjPTE071x/E4IUgZ8H/NebdSh7VrMIBTBiTwLFTGPZPRInFJKC1E2Z7lUgEhcmydxFqSNKZ5dKWvsZbyWqETvkkxTS2QLRFWAC976mahrKdeofq1pY9NbpvmL4Jp5sAVRBruXfMbjMe8NdDUW1YwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLgVUeAZLc3Qhb4WNvgiIM39YU9ggxgm/q9K8O68g/g=;
 b=r7Y2M+LfszTUZ8j0REvDuruM99/le88LsOk7iltZXjvdUwfkTAZk2yYMsu8ZT65Yf7XzWaD/oIWimwLETn1BsgHs/Qpo0QlWZ92wUQ3JJ3WAlxRZAaJJVuwRpgOlFN9Z6mGhBOKmnSz5YhWDB/WWn+gH6CgIpNsTMemy0heErj9qpoolEGx8wikhw/wWIRSB+jSHjwqkB4c/M2I0Uh2FM/GygIA/g/eHOafhQht8tVMM7dTbX7exsOfRiON9jDa91OZF2zhtBxGG4CJltVfsTXJ7h9Yjp5DkSzY2Gy0pa4UUj84y7FN5eQIDeG7lpRkPXmoxFGmRm6evbZFoaMSpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLgVUeAZLc3Qhb4WNvgiIM39YU9ggxgm/q9K8O68g/g=;
 b=E5HSvSKuPDm/WRSK2QbnFxDMYkAd7VBQEZsRaGae/m2SoA34VjtQUioxHkAViPyadmmNAb6eQ/6yUc+kXpm/j44mOOJQE03HRCVNoUzwqmMcMdjeDzXnH+hkUztDooaMv1YnKsErRJDtFo9HyZHcvdIAGQnl0LL2vPwl8g4bwwSj3w1tj+hz9PbgLYquzLa9EY27eDCjBWVbq0gvXcyho5mXIVD+okJwqgZdWedSYp5/U7OBQVUFHKie06MNdM9INJdH8G5wFqUW8y8+nU5nNOw8vcBJmTh3h/28vHJYPD7adVrEBobRhUpP2cPLwFDV7oxSa3FVa5vW63kcYyMsiw==
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:33:14 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::40) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 14:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:33:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:32:59 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:32:54 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v1 00/11] vxlan: Support user-defined reserved bits
Date: Tue, 3 Dec 2024 15:30:26 +0100
Message-ID: <cover.1733235367.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 1daa087f-b718-42e1-f646-08dd13a76b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TYX8enBUnOc+1/O0HpPH8JUNrwG73cOhof5gL9mx5wuKpUYgdOyYqrXZGdt/?=
 =?us-ascii?Q?BXyvMzmWgTLXQQCeTY2T6AXWzluqHe6Xi8T+lUWm6CyWwNldimteb6+dUtu/?=
 =?us-ascii?Q?aeJxyE+XukNLXOVHlg322Qv8kK/H28lsfttjuuAOJh04I7XETEYIllj/w3Vv?=
 =?us-ascii?Q?eHLBcjFGpkR31q0UURPWp5lFcND1s4qkzChnrmMEhicQOKOUYn2iyySNdfFC?=
 =?us-ascii?Q?pDeCSVvOBdjIPam9nJkvIpn6UtVGs/iuYhVbSYQLjxpznvb7LQTDEu8Epwes?=
 =?us-ascii?Q?aCVCicUpnUGj/CtVTfIB9F3l2aoKfgcVw/yxUauQn916EIUUtDQIHqEno0aY?=
 =?us-ascii?Q?J7dfhkRAb6LBx7OOdVch4/HTra3Dk/5Eu1s2kgqb9vyxohl4r6QQ2uBxu9TZ?=
 =?us-ascii?Q?MvG4inDei9LjMUMKgDqR638YgOtPYaaOxBR+YPNzH5t5dlrvG7CFkmCJrfTw?=
 =?us-ascii?Q?uWiYxh4eUykg3lnC9NSzalYztC4j5SyP8t/UfPlAHqYXrlb351gIRMDVgvuI?=
 =?us-ascii?Q?0Adv+Sy0E9xcMCQ4ndnHxq9bPunBK1wJe6rE+jGfl+/HZXZ48cWxGjZkQLNs?=
 =?us-ascii?Q?k4CHBLSh5+q8EQIO28nEpAfZrDIh3efxh+46WisTZgtBlRSGRLh9q+8fhBVW?=
 =?us-ascii?Q?FrE9P84xZF44K2FsqF/zl4ey4ZZaxGg4U1mEbrJFd8u5HkvJ1j8L11PDR7po?=
 =?us-ascii?Q?Ut0400rH1FJ/7ascs16KONyN23B6EX3qPnljyItC/sZY30rmSnvsws0Bi4mG?=
 =?us-ascii?Q?dVUNA7jSKZBR8PN6K0qQHq67X5ViHCdzd2Quy9Hn3UnsFKNWRNtfEhtg3VF5?=
 =?us-ascii?Q?OtVyb7sYDTK5iacdfz8WFN2xXl+8GI8QekWdqJ53Bj0wfBvM8P77o6a7W0MX?=
 =?us-ascii?Q?+iAYVvTlVtPrLwKwBAH3cKTlAHbUH4lwLcjs2MAVJGIfKd6Er6kib4rcQlfC?=
 =?us-ascii?Q?L0tAw7kF3gZdy7RiSPQDXPjFXR0B0Ja/HM0VryjMNt0HhiTjm4cv2zpm+9Ze?=
 =?us-ascii?Q?Gvci5Y3CVvchF6ZCGh5NbS5mzHVpk1ndjNgQeJdJNSlObV9NP8Si1SeMnCWC?=
 =?us-ascii?Q?hachHqppDX5JR03lg6IoTM2PdHoFaJtAtxUfs9KqxhrCIwLez+1ORYkPzGmA?=
 =?us-ascii?Q?bCwTxq9DcXNH+xY3U+8xbE4pJRV27sH5xO38pNBiRz8zd40FoFLYVhyYcuHH?=
 =?us-ascii?Q?9r72oYoWrFSOONHvHM7iAfdJjSrYjMpBgrrfrHICGU3SX7sbvEdbPMSfEPgL?=
 =?us-ascii?Q?OB2kkXST/sBJXkLm4Rky5QTAC9jaiPzkrmvfNLFw3DbkHCInx0GDkzfk+d4o?=
 =?us-ascii?Q?Ntr6gJLfxQwpFMYDCswOfvhQXs5BJHUN2sYlvN7KWkvqpkW9O5U+59GiPhio?=
 =?us-ascii?Q?parw/yXiC+RT1Qjzyt2clh+jwzLauAjULDiEHhxgWlhA4lriW5zXJtgYZfDP?=
 =?us-ascii?Q?FGk+CvOXoEuOLRs5QzCunUSUJj0NrYX0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:33:13.7851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daa087f-b718-42e1-f646-08dd13a76b65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710

Currently the VXLAN header validation works by vxlan_rcv() going feature
by feature, each feature clearing the bits that it consumes. If anything
is left unparsed at the end, the packet is rejected.

Unfortunately there are machines out there that send VXLAN packets with
reserved bits set, even if they are configured to not use the
corresponding features. One such report is here[1], and we have heard
similar complaints from our customers as well.

This patchset adds an attribute that makes it configurable which bits
the user wishes to tolerate and which they consider reserved. This was
recommended in [1] as well.

A knob like that inevitably allows users to set as reserved bits that
are in fact required for the features enabled by the netdevice, such as
GPE. This is detected, and such configurations are rejected.

In patches #1..#7, the reserved bits validation code is gradually moved
away from the unparsed approach described above, to one where a given
set of valid bits is precomputed and then the packet is validated
against that.

In patch #8, this precomputed set is made configurable through a new
attribute IFLA_VXLAN_RESERVED_BITS.

Patches #9 and #10 massage the testsuite a bit, so that patch #11 can
introduce a selftest for the resreved bits feature.

The corresponding iproute2 support is available in [2].

[1] https://lore.kernel.org/netdev/db8b9e19-ad75-44d3-bfb2-46590d426ff5@proxmox.com/
[2] https://github.com/pmachata/iproute2/commits/vxlan_reserved_bits/

v1 (vs. RFC):
- No changes.

Petr Machata (11):
  vxlan: In vxlan_rcv(), access flags through the vxlan netdevice
  vxlan: vxlan_rcv() callees: Move clearing of unparsed flags out
  vxlan: vxlan_rcv() callees: Drop the unparsed argument
  vxlan: vxlan_rcv(): Extract vxlan_hdr(skb) to a named variable
  vxlan: Track reserved bits explicitly as part of the configuration
  vxlan: Bump error counters for header mismatches
  vxlan: vxlan_rcv(): Drop unparsed
  vxlan: Add an attribute to make VXLAN header validation configurable
  selftests: net: lib: Rename ip_link_master() to ip_link_set_master()
  selftests: net: lib: Add several autodefer helpers
  selftests: forwarding: Add a selftest for the new reserved_bits UAPI

 drivers/net/vxlan/vxlan_core.c                | 150 +++++---
 include/net/vxlan.h                           |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 tools/testing/selftests/net/fdb_notify.sh     |   6 +-
 tools/testing/selftests/net/forwarding/lib.sh |   7 -
 .../net/forwarding/vxlan_reserved.sh          | 352 ++++++++++++++++++
 tools/testing/selftests/net/lib.sh            |  41 +-
 7 files changed, 496 insertions(+), 62 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_reserved.sh

-- 
2.47.0


