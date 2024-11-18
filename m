Return-Path: <netdev+bounces-145918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C09D14F1
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DFDB2EA8F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A441B1B6D0A;
	Mon, 18 Nov 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3Sac94T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF27D1A9B3D
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945729; cv=fail; b=GdHc78CmW0tvK1+UQlrS2MCvSsdN5ZtR7J2NNu+kJN23cRb9Fos/lJECRKtcFlGq2yODWss8AsgrHSBLSLuiKcS2TZU+5Po4jWaQR7FallK0A/QPkr32Qx8sRvp1kl/0Gprdm08OrBP2Txb7qYmfz9mYRmUa0BUU1B3r+A15TMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945729; c=relaxed/simple;
	bh=HDMoNnZ6FhtSsVM0KrqivYsjyvMafx/CKgEy4FGjMzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDIpEWTaNAQWOg1uBnvmM63fEyc23N3Tecw844OtzA9oMh9OqBpudV2ToDQ46/WzTpBjkAHFT6vnCUAsYzH3qV2frXGeR98ev6lMQ/ugdhh3EAvperV73xzEZ3eIHQL1WC/iohn13juW45C7q0U9DExfQU5p8hrzvY3aCTEoNP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3Sac94T; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwS8dEesz0jhu/WHWq/LHT5pz4Lox0OL0dGIw9V1X5NqLP2yCLJ0jAOqBFGPLNr1KJEbIT4mvkKkCj/b5yvug0Ayav2+kZjRSV2QcyHvYSkjmBjL/kExkXZJrV+32FDsYOXrn29vM/A1GV1udfLeUneUNSF/xhhXIsJ6AqE9fYzLTGk3OKnlbTXCqeMAeZCTe8sKfb+EtBXAJia/f+ukVjoiU0e6Yt0U+ku5f+c3iJx+mumR6FB/4W7ua0UKuEk5fE/gEUD3FTcW+Y9DUWCmh74uO+UtgGa8Sh2bVM/mmqVHZUIpHH+W+aSjsn3l38z/+41/m2HJBNuypDjj9POF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoiKy0CQ6uGThGpMRKVTIpVebOI9aXMKGCcT4EYGorw=;
 b=YIMcTCA5WbrZPXiRrxsKXiZgSz3LvHxqDx3czx9OBI+c7OgW+ux13rXar8llHEGCwG6rmP+UEvQZ6vNdJrAgNQewAKvZgNUgFRc1RStF5DyYCLBuRKWqtIN8IOgvXFWjrZv3fzgFlEb+SX7djpKTBjlSKjjSbfsiNhngJm7S2rB4B+P0cWVhaWcPY11i0bPDdGE2bc9dwLrxiKz+k3Z+p1muP05c4ZZybXfw3fYCh9Hoob4ItDmWaFno09pPLpa/PfSM3rl8roni7bQ/k6EIh3e2ItDaBXkghvXLxhxVgjbSQqBIkLsvZsXcHU1Pj1fUY+ClrnJL+6q+9rXmAQFO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoiKy0CQ6uGThGpMRKVTIpVebOI9aXMKGCcT4EYGorw=;
 b=q3Sac94TKm5cQHrda2c/2zvHk/4ARRFIquDQbR+sm4t3EVSGjGnDCjS1TbcOaj68q1ApaSxU8hU2zkfHEYyPwM/UtZLZBMNAdtLtWcNrm+OLMClIZGnkPpH7eyqmZSmGGZ6KwB9oW0j6VDCL2C+Xjm8u27of7TZwbqMN1emphZHvmFvLFfeljTzKv9pZPBefYVOpqPCOSpSdnmSq6EKQ5RlwlpCmEzSsfxGsjJjoINLsCaEXSXvX5mdQEUm2oG9EFu1AT9uWQ0bid6+amOtkT/o3o7UfrmMqNkSbz3saI89FCLpbbOB4w09xo7PR1YqwYpu1VTfjY8RA/CHKlJEOWQ==
Received: from CH2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:610:4c::25)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Mon, 18 Nov
 2024 16:02:03 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::45) by CH2PR10CA0015.outlook.office365.com
 (2603:10b6:610:4c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Mon, 18 Nov 2024 16:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:02:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:40 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:34 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH net-next 06/11] vxlan: Bump error counters for header mismatches
Date: Mon, 18 Nov 2024 17:43:12 +0100
Message-ID: <03306b4ff6cdac1f42c3259a38d610eeb014ab03.1731941465.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731941465.git.petrm@nvidia.com>
References: <cover.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: dad3799c-f493-4000-7154-08dd07ea57f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+vC29i9QYsYg0YlP5AgiqZ6UaZn0+c8EHi/4eaM2eCiMDg+2X9hmZPFceV/z?=
 =?us-ascii?Q?p1EtSjnTAZ43Bzq5dS0ZlfPtcV32z5Hv0hR/lGYt3I3EJnmPcjl1fq7BROfe?=
 =?us-ascii?Q?bvD97ijW0/IVQqSH5Ew/GuKk8vk05IoHT4nkt9cbZk1tQLdMDBfckQ/P8lWH?=
 =?us-ascii?Q?+RHr2wWHKpjk5eTBcRxSNq+pmkwdLYw8XIxRU52nxK+043k9O5NuK8kMj5j0?=
 =?us-ascii?Q?Z1Hu7GG/WVMNQXtnlC5niJImQfzF6Yj/5MtZUo/qJKs3Xgoo9bJQGZFMs4hl?=
 =?us-ascii?Q?pANBpQYlritX0j9XcuP3tPgWGxOdkVOWxZzuZ8Ulby0e1oNArOC2xhP3kMvE?=
 =?us-ascii?Q?fQf3vZ8Mh9E2x6vhkFEDf/SzD5uwewPtPjYs8l9DZGxJgu9W0w4ANGXZn9lK?=
 =?us-ascii?Q?D+TKIU0c+hqU5bVHc2Jg65Z7aiibpfCl8av9lMOD2hdRmXUjJVwEuv/Cqo2z?=
 =?us-ascii?Q?clKfSLhTRLJVEsRbrvnyoLLWQC9J0VwLs6yfXGrhNPmJyDCyfdHXCfMqs3If?=
 =?us-ascii?Q?QICZDc/PM/R3vifTn70cUkmEQZLq64Vn+Pfvqg54Yp0DMtHVLPZW7SDVhC4M?=
 =?us-ascii?Q?a2lL72NzmlcB6nEVvPVIPM8DE+ZrQabyb2Acg23UqJbkkyZ7n6MX6nSRyoQe?=
 =?us-ascii?Q?/dd1aFKfOIrKVq/YfucC6XroSwf3YKoPsw3mKJmcvx0S28YuaQCGh2QsOoJ3?=
 =?us-ascii?Q?JAzi9web+tjzb2tGTOakug6S1S2lBnfB9z47JoL3mhrF/FP8GXL7+xG6v+nf?=
 =?us-ascii?Q?HCm0tssLAKJ25Xjrp4tMsBZ+3aXApwZJc7qrfxzq18tUbWfRfl7gWb+COnn0?=
 =?us-ascii?Q?WRaKYcfIk1VTLIc5Jv2/KwpQLFuZ8txO/l6m5+pySca4BHUDsHe8ALhq5ZHJ?=
 =?us-ascii?Q?1EHdYhCKQy4kCWVDL+eF3BmM3/vCr/EsRzgNMapN8JPDkceLnq+kojS7NLC3?=
 =?us-ascii?Q?Kg22Nl+zjDQ8lHoqqj8/5T1DpiSUMXTiw3418tbiJ1J0OaN0w5gWMNWJ+e73?=
 =?us-ascii?Q?0gLUsuBRE9IxN9cFKVxntWhc6pyFkU0TJ3YI5YvNI69Auh2lrfn1EC5t/by/?=
 =?us-ascii?Q?kEPdEXWDFldyR1+rSnRJuJJFYW5oBe9sb2qxwzTqLqlNsyG9NO1i+diFy9Sr?=
 =?us-ascii?Q?QXUsetrmWdbaCPFgn8PmAYkTIO2Vp06reRmlORELlqt4E45OFHFiPu+IlZaS?=
 =?us-ascii?Q?t3aqv3vBmvM8Yui0EsVq6ZfoIvGB9+aDmOekEI99KgTHpfSjpA9nkEY0M40s?=
 =?us-ascii?Q?5V7y/RfQ91LJHxEFdD0UqFG/q2bX8/l2i1nRGrz0bNf/rghVdFkJRuOqxQsu?=
 =?us-ascii?Q?CvrJgfRrPiK3nP1O6Uf1myIoGkT3sHzEkY9ed5BtlXsrzMrv3pL2OLkKQTfM?=
 =?us-ascii?Q?rQ+/wKPxgHl9M3BGu1moSexmpgyXHZ5wYVaFEFNNio0i8MEjuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:02:03.4229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad3799c-f493-4000-7154-08dd07ea57f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145

The VXLAN driver so far has not increased the error counters for packets
that set reserved bits. Iso t does for other packet errors, so do it for
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
index d3d5dfab5f5b..090cfd048df9 100644
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


