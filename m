Return-Path: <netdev+bounces-78741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF588764AB
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F5B1C213D6
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380FD1CD06;
	Fri,  8 Mar 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q9ShGxVF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B181376F5
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902999; cv=fail; b=Anixxef8OqjFoaslpcZvlJjuPeMDHK+yqBm64c5yrMpsoIgx15QG3IZYEcuKB69pr9lX8ElQm7FkqtfoZUBAyN/7yRrJDHmPJX+xZ9PMRq0w8ysMjiTa7FlQOTmLzLOrfrXuX0uC70knZh75zEhtdnh9t/jxob3UAGzCeBBeAYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902999; c=relaxed/simple;
	bh=WEQRL4Qu8tUrLn12bh8NJauRJGQK9lzC0uXB/JnKozU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+aAFns9QU4L279/YziEwZGPjmRGJcnE/S+6fmsbrtl6TP+rOvNPPT8udHaubSIHecCEhKqZyhaqXvTdoulo/oDT6yX08MTuKo8Hh7TS3k5QGfAuET+CORoNe123Sa+iFPpl5rW3dFLov6ViRvDp8aLyHr1Re7wUGIDdCXVZue0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q9ShGxVF; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXChU5bXQUGnjtogUqRClFtsfo6LJl12PdYUMoVJInDiqJ06rbBeM3R83f3TCqt+ziUJ8XKRDP9gjtloJOAp+QRgVc9BOgLQSV01oW3GT1krGdVw+6wlzm5fBVPl3GI8bBaiRQDZ1fTqcUViXzNvxhSva8ZSmAwUBj2Iomu61t5fgh53WuPPlpjATUUWMgj01ipmFQ27BOZnQrig7aR5lAreQZ5Ar/d+HSe2fIOPv/0xmk8DjjF2QuhMmfJfz83+xAvcK4NzqcPA1fsXIuxLIgsTG4jGbR+m3teixoR92IeV9vPMSWuullyGIi/LU34YdHumQoa68AI4txSe8Am3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSBRiphpevI7+iHILAIOXSt14wWcUUEQ1ezc+Bnd2BM=;
 b=oXvwVsVvE0ruQKsTRmZ0iZqByUn6MPWv/XAkG9yvc8wXVmp7kmIfYCyBTkKsvQVTzbNvz6kdmgpuAnuVekZSm0fzaZ+4CJ8hHZT16V6fr8GGWzqwW8FE+emQQwyNVbEDKhR5907gtJA7mN1OLYimeRO4RJpIvnMszp1/Qx5wW19mNE2pcRYut/kMydHMi1lSJy/XnZpO+ImUCuNIP61W+QXfNbbb/rn1+U1+Ohpmsb6XDlGX6LD5B81w2OqABHdmvrfPvqZPrkEFsPxgQK5o1UtMPxm53suNG436TNebsdTsJ99CPPcFKDzxx490rkjKHbA8PzFbniLhyPmOLdDfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSBRiphpevI7+iHILAIOXSt14wWcUUEQ1ezc+Bnd2BM=;
 b=q9ShGxVF06kQP9ZMeWwXMqrjw1KPLH9bfhUC6/FPWW9l/h5ajxhimSZnLSan0XFzP+K/prFVM3NkchPtu06jzzcaVd9T/nOV5xiwvFRkjhb3VhrR6AfbSpS8AGUqe9YjwT0mJg3ZmnrtmYM58u4/57xBkZu4wARRNHsHRtyxtSHL+KsIQr2jAqUzJdnx4MnBOt3Dgk/vU5G0vHWsKWGXLoMFCf/AtmgJCpYaN0tt/bQZ4OD6alPcKTZJSatv3i3PEblsVLGO4l6T1LWCeoe6+eXmd1rDCjK0mpIM5lhv9O7buwF9CveyW9jAf+adVxp4NKkb78V1Cz4AnBUr/oS+BQ==
Received: from BN0PR04CA0156.namprd04.prod.outlook.com (2603:10b6:408:eb::11)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 13:03:12 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::e6) by BN0PR04CA0156.outlook.office365.com
 (2603:10b6:408:eb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31 via Frontend
 Transport; Fri, 8 Mar 2024 13:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 13:03:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:02:46 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:02:41 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 06/11] mlxsw: spectrum_router: Avoid allocating NH counters twice
Date: Fri, 8 Mar 2024 13:59:50 +0100
Message-ID: <0cc9050e196366c1387ab5ee47f1cee8ecde9c86.1709901020.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709901020.git.petrm@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ad33ff-c688-423d-c112-08dc3f701c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VRG6wFLQ4zUCt/rp4ak0CzJR17GmMjq9eyk51xG1jWFnNjcNEDR1bvqmF84+tiMVaG6IRpnm1h6xmmbvGpYep1nP1nLMGwE9He8ozIr/kq5sQOjhTTTN2VjM6KYu5VMEh8ZGsc2AAGW2a9Kxx8AApN7ncBMxjUJtesnlM9SWx26RbrAovRHxjH8frClZG44Cafw4I9YXC5diph1PGm0BuFQPfOovBgEV0zOwVyyBxa0rCIiaciIMQf4ghnutjmW5vDDsoh96FlvKE1422mJ0s+nCVe72FnU0QDedqkP/qVfwemHU3h+5Zl1K5EJTOY7Fy3mFcOghjgJ1PtdHWW+YZBe080MTN5nFeS6LivVt1OyPcrgsuunqsA5doP/MIJ9nYferuMFi4f2pAXn7f1J8bcnFlY3oMynZCLX6CsR1DMTDFDypgj5F5cEp8yvwec+2JhPDZpdNUdJjz8w7PJO5CamuGnn2HLNl431jF9S9Bt8jwhpNJ1DEgKaON37RhwYpp/eN9SAeRV+jmPE9b9/K6+TyuBlrOoMWaos1i2g8UE6gYH/HZyh5u2o16IGvyCcgEMEGo2Yx1UVT/npmZhXbYX4m7kDbu5AnVL0Td4nPkEY1Qllpyw5B56Y/NeNeY4x3PQGzPn89xaNPdn3ARkA0tPDLMLRRX2OMF01F6ORzqg2A+WfFRCCTD1q3hVeI7dAf31ZobEhpwe3rtTntFc+GJLP8wU0T4kRUFBhlyVFOZk5mnYPLDSVYQF7AKkOCT6lG
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:03:11.9515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ad33ff-c688-423d-c112-08dc3f701c2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

mlxsw_sp_nexthop_counter_disable() decays to a nop when called on a
disabled counter, but mlxsw_sp_nexthop_counter_enable() can't similarly
be called on an enabled counter. This would be useful in the following
patches. Add the missing condition.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 2df95b5a444f..a724484614ab 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3157,6 +3157,9 @@ int mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
 	struct devlink *devlink;
 	int err;
 
+	if (nh->counter_valid)
+		return 0;
+
 	devlink = priv_to_devlink(mlxsw_sp->core);
 	if (!devlink_dpipe_table_counter_enabled(devlink,
 						 MLXSW_SP_DPIPE_TABLE_NAME_ADJ))
-- 
2.43.0


