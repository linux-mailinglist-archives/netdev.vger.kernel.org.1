Return-Path: <netdev+bounces-148521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE99E1F55
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2221669E4
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE751F6673;
	Tue,  3 Dec 2024 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SXMrSASQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DE1F7060
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236450; cv=fail; b=d1xIQugYYCirt199gXDZOIuRt+l9yrAZjVJJKFN/TeaqND/W43uNKCwHgm7PTcPZjgp30nJMjGzNHH3Qg9tA5UFvybjPitmyptEfH7VIgn0qcNMYtPbzaldcIZTYh2NQuQnBucw56ILLqZSDcDiw/bi9wsoUcOJfuKHy6dCCdIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236450; c=relaxed/simple;
	bh=Q3aJjk/vGT+Zq338I6ED/u91MH0bn6fz6fT2ugyytHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFVDlM0/QvjSS1d0hsadcPYAgOLUgnkUnIwGQP/Bv6UJOeW8OPQgFNFuqePozBTgjzzpmFCn8OcrcBI1qTwZEgjsUGdBA7ucZtwhrvIoQn5mBT9gdNXtBP1fQL1YUWQSMh6fvdv7LJG1B13O3Pm5oJfLBzP9WvgZezdAJKZ1spk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SXMrSASQ; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gevZXsbnfLh5XBKHrUiN/IeKhU/uFWu0fAF43q88w8owm8omHIEfWSxp1Dzj/8Y9v7JEzCwZN5u51uBjJE0oU5KvHcmyjH7FAoFf23oY2mMVdMCG8huRpU9VZhYVXxTupdWcpG+i8ZwBaHRT1bkKbNEh6CKeR73KuLMe4NIl4jhderFjCssmWjUctDmVn4pLWu5YEWO8azdLe2+nz17bP8usCmQtRNmSaUy35mLv6Z+K91wvvG9X+tO1qarAoIMbsrLRe/lOptasRQFn3a98QQ7bfHq8XRrZmAM1zbs1pFa+lYU0DsFzaOCneQb4nxmAUwSlMl+w+CgO1nw6AUoJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g++9x6/WWOpx21Ct0wyRZir0Icn04lrIgiInhlZHoqQ=;
 b=cp/9eWaV2ccnGpqP20+37fEW0PKQjZugWiZayWYAc/gZSXiohLBO9KJeFfRYQENGU7TH8I1vmjHCjZsN8KG41kIf2RkVNarmtiliwhug4pLatp3jQ1YO+sJGRiIoj2tOGLh98il9/ev7qK8gXqdqEOjI/Tra/jpeNaZiEYEfoPU5n6Ctxx2Zhdjd2NiqfIcaQE8DsAsxERWcIernSbDHqdMjaD60l4bZAuW7cvqhd4wiQCA2/ZQdnm8eIzzYQLu48d+1ozIDc6HnE0/3PlTWxM83x/x3NK/0QHdnN24cQNBWcZ2RyqMA5Tv9iGc4uAH3Gbtb3riWQeMOEFj860iv1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g++9x6/WWOpx21Ct0wyRZir0Icn04lrIgiInhlZHoqQ=;
 b=SXMrSASQwbfr0gRi+YhFgOCPiPtFsewkT2qTv5lHAeyYDTUMizvzGkGoMZMdXREatgAqyUcPqVlhjDjX3BkZJtStAZdB4S/0mDFZ7gT0Gn3FXu9sdrmqIqCku5lZ0tM8C/TAhUz9+z4l8tqK5VdRugMMZnWqxVPNu33nI9U5l42amYySt7qw35eSFqRXTNpOUN7ypvnC3qCXIMptqowgKIrKS+zOiQWP184q4YuqN5e1u2urpKgKcHky2FPtrLlXTcvHFnowxDBAe2KcA4cGUeEi8ZyjD/Uon9zpPd3vXGygHbS1rzLN+qRxVqSDEE2zRd14+vZEEw2M2Sn/GKdBPA==
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 14:34:03 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b3) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:34:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:43 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:35 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v1 06/11] vxlan: Bump error counters for header mismatches
Date: Tue, 3 Dec 2024 15:30:32 +0100
Message-ID: <a89e8baeb2ba4d267cd0d9d73491427b876cd53f.1733235367.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733235367.git.petrm@nvidia.com>
References: <cover.1733235367.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 713310fd-34b9-4a68-d702-08dd13a7887e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zcLz07fPQRMZ7mca5XFIe+CET96VG0abZ6YV656c6XJuJandtf/ZX5zyHwQ5?=
 =?us-ascii?Q?K5fSNIi4hRF/qtjDn3Dx6MT5oLFjU4NgHy89/rKRmnbvcytFO5IMUMv2z3+O?=
 =?us-ascii?Q?jc6qPcgN7eeHg2PdPYpvBrFAPO0+VAAM3o/B/FKTn+pWyEFauV7eJIFgdVv5?=
 =?us-ascii?Q?0TYuJ5acutWxzOS59vasdcAFt51lTlfqLz7P8SDJ/nCFGl1P8Smmn47cXF47?=
 =?us-ascii?Q?iuA7WWEzrkr5Qm4weZ7bvaR5B2owigyB9zFNpscDHn7UjAqJk9bjf+8Mg14n?=
 =?us-ascii?Q?qzww3wCLDlOzvrxWpMpbhpH7We3YZlT6htrtcfZjroKIqGYJFKHyCHiCDOZv?=
 =?us-ascii?Q?W0ISDSDyoW8QPSnZz9LchxqLjEIMsMVd243DOZf3XjbVh1VjXPX+dst67pQs?=
 =?us-ascii?Q?WQZKlPZ4XasptxU9UNnL7pyPb37XUYqKzyMOSBame2sezMPZBfBw7ZT9qrxA?=
 =?us-ascii?Q?kH0Z1olGjvrNyav8QL3XBMcsimKyLhQ0IviZTaZoiOqWiE/t0FIiUw7OzccB?=
 =?us-ascii?Q?Ut8pat8Ye5AE//s1EQUTI7tfAWIw+pFTIYgm0+21lzbEdXkJl9997KoQ79E+?=
 =?us-ascii?Q?R+tLfZsMvNLoawT6fgmnVLjaL5MVENZXBLeaUtOIYoLtronDt8pv/+JwN2XG?=
 =?us-ascii?Q?bJw3Z/ZabrdZMrI8cK/LX4Le+B5h/bPRHo2prX8lbFr2wBp1krCqRQ6FOmdJ?=
 =?us-ascii?Q?d+5FpTAwXYYGqUi8uSxGPs4CPs0oEH4MDytxk55BmOCNPjtFGu93Qh8SFIDp?=
 =?us-ascii?Q?HXT5ZT6z7A+XHLiK9Wbec9TmIheOupCC8bhg7HnWwKfcXqjVi4ti03EhRUZq?=
 =?us-ascii?Q?q6aLsCMNGEEwFF8tpCeesiGvQYMZJWbOEVjkD83JpjDs6dhn6ZFsYqsgHX7O?=
 =?us-ascii?Q?GxIft41yukd+zj3wUlrPKZXRlX7xDsjwZb7UDaXjWcOf8i5Yu1JjnkpdqUs2?=
 =?us-ascii?Q?gQVR1bI9YahEkvOG/xysHl9NKfCuNUQ2Jrgmj9iA9zM3Shs06fmu/S8Vir3R?=
 =?us-ascii?Q?JQDLpJbsMYhRWnROy3qD0iA20w93BdHlP9O7lTqdugnMOKHU9hUjLofRtjSR?=
 =?us-ascii?Q?Zut3eVhPu29MztH4eEPSV53QlIKD6qv7EJB+5D/7jo21ncVg66Eu6sKQOkw+?=
 =?us-ascii?Q?FJUKMqLegaiwS58iTL5UD8Jz7cnFu3PE8ggUdlcY/ixJiSxUERdCcridikjc?=
 =?us-ascii?Q?Dmm72S7stLAFLRmlXIYgEABNmb0PrXZ79DE+i+uztZ1n3KyZic+lFfjolCvT?=
 =?us-ascii?Q?9oKhf2F5rjC57ocHhf7E30mgKQX9jNQe5I32EjrIBfkKgf1kykkZf8VdYdSb?=
 =?us-ascii?Q?zeNBY++Fi+QJbp5hCRzru+n8VmXU2kgE4dW8RfV53YlqzDiwz6MYCkSQJluD?=
 =?us-ascii?Q?Rs4C38g0OJd5jBzkmceUEeRUknItaYbQ1dil5SByCiJNjHxtqPqANwTYkiA0?=
 =?us-ascii?Q?5rrzjjDTpIBH/7u8SVvuH91NsxKo+KHj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:34:02.5396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713310fd-34b9-4a68-d702-08dd13a7887e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

The VXLAN driver so far has not increased the error counters for packets
that set reserved bits. It does so for other packet errors, so do it for
this case as well.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f6118de81b8a..b8afdcbdf235 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1721,6 +1721,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		 * little more security in adding extensions to VXLAN.
 		 */
 		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
+		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
+		DEV_STATS_INC(vxlan->dev, rx_errors);
+		vxlan_vnifilter_count(vxlan, vni, vninode,
+				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
 
-- 
2.47.0


