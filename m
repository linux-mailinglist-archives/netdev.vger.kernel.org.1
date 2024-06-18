Return-Path: <netdev+bounces-104481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4860190CA7E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83800281711
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87164152DEB;
	Tue, 18 Jun 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="livo7Ab7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809815920B
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710558; cv=fail; b=PihdRgNFPytYo+a4syaCuuFcKXPqQIes1kHWhl7cm53hztUTuKu/QsfyDr0NlHr55UcyzPnxZfL6AH12aaLgasMhxNqCGd9C9QrxUhzsEOfYqpA4zgtIu8XB1N4tpvvLB4kRmH8OLQ6ZgKZuZz8wQPr+wJW27eTt2BADO8jDgOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710558; c=relaxed/simple;
	bh=r/ai26VMWHQluqr3rtiZagVHp5xwMFJGiMyXw7AKw5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdCUhHkHUD3B1upPtzzO8VekA7UxFaANmzNOHZwAOxm5LoW287Iesa1Wrj//QbzGaJ13yS9llUIvxP6e5Eex7q99nY/3g46uNjIjdOIUVN17DvglDHDfCPCiJWtMuEhetEzXvZzE5quJuDmsKbrTBPnI2XeXAP5od4wmPqB0dL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=livo7Ab7; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKthWt2GBWioDRZlF6jErK73tBjJLsbQ0nI1uUOOFOVvBTqTdRAc2pfj5owWYL2qO2ja/+F24gL6tnYy7H4BpBlnLXJRma1XsoKkbpDsrKQn8hA2hguqqfvq/Q43d58BeLNWF3DTNXyc4iy/Sd83pTy6nvLJkUgjrIx/9V3xDIZ5Jkq+kD8QJEvF5GNNIaIooMECikre5WJzmq+Tgm/0fmvLcLpee+AzWajBZ+3+iYQcgcKTTNLnZ3+VgbHVKJyp18+ADe6l8xLViN/Kv2T7jrc1xNg5dhlKeOhY5mwkeLhcqAsx9az1Tspk/vdpwrYd2TyBTLesQptj0AgQxkWvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uItvM5klsLVKdE1OdZHyI1qzbBr6gTsXX5gYwDu784=;
 b=d/7eps7R6qK2P6K4aUUlOS0bz5QCCEj+EIYk0zkI1EmhgjisVns0wRd9xu1jBhz+90ki5QKFhGA359ybFcvGiBJA+xba6rcTO5W39PmGEnSxIVhUptutn4ugOh4ZvFlqxoJPsJuNabZyP7zQ0I/sO8KX6dkfOL9AQttMMHQP/2ppZQdIFnzbyW9PGjoA9yGA1anDcmvEIb/e/k6euN2B1Ovmen56sam/rIN0NZqg3L/mtsjhtrvI4K7ansR9WF7nRBIhJVeE14R5l5NSrLUxccFIgICHpBB2OK/8Q2LhXU3uUW9IvILV+ZoYIL0L09i/1DGhGec17AY0L2ZnstgdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uItvM5klsLVKdE1OdZHyI1qzbBr6gTsXX5gYwDu784=;
 b=livo7Ab72p8uqkANIQlwfjJ2CwyoV/MnOt31wUEAdpKhXbUw5r6xF+jQ/w4L/trCW3e/4IBBmG9f/MTtCmOJ9WdNCDkEVa3x+HcqxKfduII/cDrBUk+9fxGpSajE8FEBQ9IHwrRfjMf57ReJUkG+evYZ48KZpgQIHvMuN9v0nGUlna8QhTwEpMKBgHAsWaP/7kof1PKWGvBDpsDiv+bMvcnl6+Cn3ZOprS3GoOvT7HsqAz/jdVIYUsOnv5o/+HXGGVxJTv8AeQdaVqNtTCtwqS/z+quDaeg0/g4tz3mX1OAb5Al/uut0t0T1A8l9EriLviNacJEPSmNwTvX2R3CjSA==
Received: from CH2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:610:58::22)
 by SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 11:35:53 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::f) by CH2PR20CA0012.outlook.office365.com
 (2603:10b6:610:58::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 11:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 11:35:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:36 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:32 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 5/7] mlxsw: pci: Optimize data buffer access
Date: Tue, 18 Jun 2024 13:34:44 +0200
Message-ID: <1fa07c510890866a6f201163ab7e78890ba28b3b.1718709196.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718709196.git.petrm@nvidia.com>
References: <cover.1718709196.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SN7PR12MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f5ae5c-8ad5-41e1-7f2c-08dc8f8acf65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hhWixaOp6xiQccFKldfhXPq0rNnOoe5BVxioUdMboSrB5K8Us3vtuJkNbUz1?=
 =?us-ascii?Q?QgyIo04L9XG6auLssyQM3B4l3bBXGqKBdt5c5t1aN1KTF6ihMBZbqV83F8Sm?=
 =?us-ascii?Q?p/9NXSViBYA/d/0Q2xb6UES4WTZWb0yMhvvuLPWilt4qxNyDuRA1zno6TQN2?=
 =?us-ascii?Q?CS3WFDQUVgDJsMNAfG8i2j9PeeHMT+cKtKMUCnjze+ZABdQrDZiUW7/m0rnH?=
 =?us-ascii?Q?vz4KpPbCTVAb/sWerpa+7ohCG53sAfaSVNLnodfc3qodjSsiVWiuHdo2BW+k?=
 =?us-ascii?Q?lXDJo3nKEG/G8w227Yr6czXjhQSln0bzY/wy5cSvt0BxCqiSH02CGSpKZDks?=
 =?us-ascii?Q?3o6Weiltbbvd7JFum9+SXAax43+eZoduFLUOYKa7ZPF8R2ik98EK7nx1OuHC?=
 =?us-ascii?Q?wMWRx3zAjsqvTaCRw/rOe8EXhxZKAuEXprdA1pQDeiFukey+vfqvKRNYgLsl?=
 =?us-ascii?Q?JP5lwNM+Vv18mZv7tHi+DLfx4ctwYbYYgW1pFI2Fy+PT6jYpY05dm7YpDsrU?=
 =?us-ascii?Q?HypONynsHEjQK9oVnIPz60g15giqMyFMTUed8hi02rrpaaFtp7RleAoutpgU?=
 =?us-ascii?Q?NMi5npVrMYvibtBNeW/a9AnpCORvAnywjYmVm4Lf3vAmiBdA/sP1RU8OzHF3?=
 =?us-ascii?Q?NhRTiH9j3jNEvFMGwrNnH8Rr84iAspB57jt6kQzZ2Icw3pbxrg6DSdElTY8v?=
 =?us-ascii?Q?xmtdMY7iIlSCYRWhKbr0EdxkWJOhBV8r2M7Qf9srdkryVSd1uW8OBX7sD6sF?=
 =?us-ascii?Q?DLMy6It0zuVomhdO2KfnSL00bs+23mxQCnU09KvRbOUDB0R/0NfvDQyavzWz?=
 =?us-ascii?Q?TWYUevwhUjrwLVyZnHgfssFK+9O1A0Him2+mgpJFjPkwiup83UVC5g8jsjWW?=
 =?us-ascii?Q?swTiGlWKScejtNw2vxUkcSQjfb1Y786n3ISCc4ielVnR7YKF3KA6BiRc+QrU?=
 =?us-ascii?Q?usgdKV/XzWIIGN7k9iqV3IZRJ7OKiyKLakGRB9RABPsIkuaRSv1f9DHjd7vq?=
 =?us-ascii?Q?QMpV1Gq54yrsos2CUnEK9Lmu24wx6v9dyT1iMN/ymNHb3juKPg/wfiJjYY5s?=
 =?us-ascii?Q?FI/2lylhMUXxER0/UErolj35kVJIhZehRPhz12D/kGwzAn4vi7K0Pj9yyche?=
 =?us-ascii?Q?OLKMOe77eUOG12QbFiWB14Q2RJ/S0yxgTnWiK5nrrbTYNiGtrjtrna1ITyVO?=
 =?us-ascii?Q?VClm2dWmokt+bOufRR32Szdsa9Nv2n7twg7IktwUgfYh41/ZUmtKHDRscepo?=
 =?us-ascii?Q?eW0/hNOZrEdGNMiqWgfssp3fGnZwRePG9eTNw3u7I8HTyCP1HspvOKd5sXX6?=
 =?us-ascii?Q?S3u4aYAJqBDHFPhkFVB+X0e69j0zQhKWczlLFnENpKQXjHkjhFk8UdHek/EL?=
 =?us-ascii?Q?X7jg8MWJ9m8D3lE2DOCT3F7vmtll00qcKFm/PNbC/dCLKu/sug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 11:35:52.5999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f5ae5c-8ad5-41e1-7f2c-08dc8f8acf65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886

From: Amit Cohen <amcohen@nvidia.com>

Before accessing data buffer, call net_prefetch() to load it into the
cache. This change improves driver performance, CPU can handle about
7.1% more packets per second.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 711b12aecfb7..c380b355b249 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -396,6 +396,7 @@ static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *page,
 	unsigned int allocated_size;
 	struct sk_buff *skb;
 
+	net_prefetch(data);
 	allocated_size = page_size(page);
 	skb = napi_build_skb(data, allocated_size);
 	if (unlikely(!skb))
-- 
2.45.0


