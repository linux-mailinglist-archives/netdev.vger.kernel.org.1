Return-Path: <netdev+bounces-108205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46991E5B0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8861C2088F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB2A16DEB4;
	Mon,  1 Jul 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="suLxgK+X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139DC16DC23
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852301; cv=fail; b=QE+X0mdK8ufPjJ8hIwBYDCVjYi7Y5xx6fqrLOQw3vWlT6K/RxR+HMiduCkclokOZFlIkP8Xy5bUpC59Olqk0UCjLsuoQPClZcI6TxqxIEuPvxMjoFsfZwmBhBeEkWEgCGeWJC7ENvOLFtOAmJC8iz88JBZaH5RaM02xtUjRhlWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852301; c=relaxed/simple;
	bh=6HUtmlEIwcNlwmoT570nLcN8Na9lahimzHjo/3I087s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfzzAVaaBP7WKnY7ApxW1bhx4bLkoDZfD9UKNbPdQOSZ4XFTxwctmXr3w9frviIPuNJnmM5W5mejuP3JeFNCIlcpyR7hitlvWx7tTfjj/NMXM7igbiZ6xJq17FkD6bgO13m7YHduiLqC7fBidmoDn1w69eQvg22/vbQxXHY9LYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=suLxgK+X; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjHuRLXJdOzLeY2H5l6X5IKowVZx+lKVgw5BDXgXxqOAyxwiQom2WMR9vHlzAPqODvSLWs+6rwVcDoBoNoZGWzVHcILY8u4s/y3UXtEc0pP5K39Nkv5azUvwaLi3DoGniUE2p+2XFvyXIQnaYwsieTlcGLBAVhNpsaPO1UlWvWkLybNFxtzbWE03TLEy/kvSvtP5Y5R9DH1Qg23PkYzr5mYdtC3xqyen+CGGdxRq56+ZRK5hgzTZi6HbgdQ+oZsuxxzCvn73H6U7FhTlX5iZb33wEORVDRCJRZeeTeuaF55LY7P4WITQ0NsPpn8bBoxiuuvoOTpItPokfYl4VBUQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekzQMeeAMKIV/35aPBW+kpvDaV4BKieYqJTR6ItagCw=;
 b=Qnjoqbq980WI5y0Dz5TIBSdLVf+MyQ0jchhj2mhgM80yItjbZvz2NI6f9sT8hZNQEc8v/LxTi2UC2IStKGARM2oMFHRpwp6zFD7jXTc2pff5ZeX0vjpLIr0kQjLMLwKyT65Y9cLYlGpNouGBAC29p/VcFSyHL/CP5zAa0wsmb12tvwaf0ajAj6fxOv8KP+CXekH5VCKfovxvpN5/mXfVaNK9eqodxrA2g+BVyaRzu2ZY+KcwKURbhERWk9+Ih/gMuDQEfc3f4zn3xiQLqcmS7LrzASn85vV60sh9He2T+zq6raCzvVusM3VukqynvDslGUcpDnjNwhv97ZLNGlmPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekzQMeeAMKIV/35aPBW+kpvDaV4BKieYqJTR6ItagCw=;
 b=suLxgK+XXowOa5eZvdw6ytkA2paNpOJSW2b1byg/DrgL+lhf/y4pak+CxwrksKD8/7znSNijSL0FQfF2s14btsTWUSIP4/OVGPQemXNQZ9W7iRN0ghUsovdvTdr3WSA902a4MO4371kJ27sVir89tSs6DzpVpJVbtAFin5qZYZihsl+l8113MNI2Oi2i3hB2KL2s8yHzC1ZLc6NH83NisRjbeLWxWjhNsYtEQpWCceci0NgVHG42oE7qdxlqQnlKpkokB/5vUOt9VoTy/Lg06qD15dfwc/SROpRHO1LTiBf7uraapFDx0eQm85+cWKnzSdCqHf03dfPpC0nLxSoH2Q==
Received: from SN6PR04CA0086.namprd04.prod.outlook.com (2603:10b6:805:f2::27)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 16:44:56 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::90) by SN6PR04CA0086.outlook.office365.com
 (2603:10b6:805:f2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 16:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:44:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 09:44:39 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 09:44:35 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 1/3] mlxsw: Warn about invalid accesses to array fields
Date: Mon, 1 Jul 2024 18:41:53 +0200
Message-ID: <eeccc1f38f905a39687e8b4afd8655faa18fffba.1719849427.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719849427.git.petrm@nvidia.com>
References: <cover.1719849427.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 48150d31-add2-4af0-2afc-08dc99ed237d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/UlF9OJ/aDBu1okAVrXOTKqPYHKpYGuk6XW9Y+wAiEyd3uLqnVK53P8fwD67?=
 =?us-ascii?Q?qmCV4xOlmdFEPdiJCBF22znC6N8aHb0z1tXaFusSo/HCh3DXvasH/veyRK2p?=
 =?us-ascii?Q?YWapPoQmNKojx1b0Y+4nXh8G0BzFamvMG5rqPrdBZb1A1mrXwVxdor+1Qmxs?=
 =?us-ascii?Q?PMdSgKgxXn0npGBlKciJAqdqGQO2pJOV5YS2MoGydIdxWb60qCW+NYBG9BwQ?=
 =?us-ascii?Q?DQK1TJIB60YxbMQLV8XbPmt29hOJxXD6AS9hFaTG/KYyngXxmiqjWUqH7e7a?=
 =?us-ascii?Q?UZtEtoEaqgyUE3hjmcvZ9yLS66qyN3e3jJEO0cpB96DAwgUX0Y44wcuGhjjU?=
 =?us-ascii?Q?Aw1jEfy3qFh1NhidiQn/07df7os1+ex/vW8OVCn9FotVzvqXg4b7qrrVYA+g?=
 =?us-ascii?Q?6JnYKs9hp7uXdNwBW+Wo83qMnAHT30ByIBdK+nuJxK9sWimYbIH/4gbA5t8a?=
 =?us-ascii?Q?ZBM3y2jwuVnuOnjSZLlOU883dPajLrJlfyHDrBt51aqrPSJAR/4xAvEjmWnU?=
 =?us-ascii?Q?aow7797EzyQToWQvPNffedVuLFsWpMLi3a9abYl/M4Et7J9nUWobv14lfbAm?=
 =?us-ascii?Q?KaWS4ju6DXcZoUffZg/vq1ZHcryStrBzOhTQjiCmXuqgcNI19XooIvWOguJw?=
 =?us-ascii?Q?TGNjx2K0uSWRS3J4gXgteOhoppS4Uh126up0HtUFX3qFn2gjgrbSX/6FU2h0?=
 =?us-ascii?Q?jOI53rig2lAGYBG9GDrassjtugfp4WetKAArOx6XeldJJlKG75b0uHvvZkX7?=
 =?us-ascii?Q?KYljSVaQpmcOlb85CWBQD7ZzMJ3vlKZCrFnTWdKGVa1MjuzTq7R2EE8Trpo0?=
 =?us-ascii?Q?hZJdrFiZ1zMLmFFFs+uAbPZc0+shoFZWd7OuIHmWBXln5bjTulzmGYshEFeo?=
 =?us-ascii?Q?GtqvU6wUXTkQhl+KCoXTSfQ1QTG+rUAcovtUYk2M/XHoHZacGPZmFBaojOEK?=
 =?us-ascii?Q?DtTIBHjAz1+Q4z9+/KMw/T79zZjRDSm31HCUCbxvzwXXe/RgSHdgtwfOOC5s?=
 =?us-ascii?Q?p0h7Vgo7Vldw1J+EVFud85httXujdoDV1kNEwGZ4OiGjNIHoMkBFPjY+sE/Q?=
 =?us-ascii?Q?n1ZE4drYDga8p7we3IHkYS3tKK4y6Vy9s0cDaRjKkBj4ZcBRArRKxcbXaKeV?=
 =?us-ascii?Q?Dbd33GP9v6zcmoRyZJX4uu906lljWcoKrF9lp86rjDNMb9J1cenDfykSnmSS?=
 =?us-ascii?Q?i7ZqkZp3EOpey3uqJUGc7XSaYa1VR/tln4fSM1i1FwCwTLXQQF0yzOV9BPVN?=
 =?us-ascii?Q?goLpEIG6rwod5EWKTCmjVpCVlQ/QxysaV8Q4j91qzwwn714ygdDDptlKG4m7?=
 =?us-ascii?Q?87varojnYEHy6HoF3Y+sFVOtqYk11L6q2JqDS1wzZfIrqng4krOPDIy9ox98?=
 =?us-ascii?Q?81ooGiPtYM7s2ZnvzepBphvPuuWvrCZIGTd37I/03Wq0hJs2TstVjmxGDaT2?=
 =?us-ascii?Q?HHYBL5QfhFV+JAMXk4NoSNfILYzjJMDU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:44:55.9909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48150d31-add2-4af0-2afc-08dc99ed237d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309

A forgotten or buggy variable initialization can cause out-of-bounds access
to a register or other item array field. For an overflow, such access would
mangle adjacent parts of the register payload. For an underflow, due to all
variables being unsigned, the access would likely trample unrelated memory.
Since neither is correct, replace these accesses with accesses at the index
of 0, and warn about the issue.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/item.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/item.h b/drivers/net/ethernet/mellanox/mlxsw/item.h
index cfafbeb42586..9f7133735760 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/item.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/item.h
@@ -218,6 +218,8 @@ __mlxsw_item_bit_array_offset(const struct mlxsw_item *item,
 	}
 
 	max_index = (item->size.bytes << 3) / item->element_size - 1;
+	if (WARN_ON(index > max_index))
+		index = 0;
 	be_index = max_index - index;
 	offset = be_index * item->element_size >> 3;
 	in_byte_index  = index % (BITS_PER_BYTE / item->element_size);
-- 
2.45.0


