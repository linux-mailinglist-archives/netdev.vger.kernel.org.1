Return-Path: <netdev+bounces-83802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07048944F4
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 20:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310CE1F218B8
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE6029CFA;
	Mon,  1 Apr 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RHDRoiY1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BF8495
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997067; cv=fail; b=osIks8birOzJcmxjUMOgRqlGIeWAlTwhmNMfdPIgEyRlwGjDPDW5q6S6PlYjjmExznau+8w2BUUubLNyyvBplEY6ueVUI16LjaIoQkDVgUeuc7FieXNCqGy0Hg8kpWb/stUiLhMIT2OuR9t8LLwwzrgSuTAjkLCcbdXa4OSUfFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997067; c=relaxed/simple;
	bh=3VQCVoSQ8K+/QpVZSntB70hBzZKro367OOCdkhFK7EA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t46CzQUl6EfCxeLr1jKj/B7dAPcCmySSIa5NOIONSG9KRfgMGAuGMEV93ytk9jnTub35co/52Nw/khRpw+IA94GwB1agRodZOEgBTJYi+nQXNqSa2lffhMNwuVH9gc8+9nbZeqOkDf1tclzrnu99P0FXxSxfhoQDymOVwygGvCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RHDRoiY1; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH9eheGeLxENh1dn5EnV6jytFUpdoLMEfpBwfd9hf+/VwsreQ1PIFDPgXNkeFqUUZJW8duuOqs8vK1oqslt+8nl2tCdJUr3Y8Str+BULDtU+ztzdHIq2Q5HasQUX/8HnrjfaXHM/i1OHie8NHw48pyJuixUwt8g9UTZ8GZleP2wC9Lme8IyD8rkNOcys4ScUA29dcoxcUcMsgL6BF3zXwnPrmH4UUEKP8tV1nBPUGz0TmDhIUHj3bmCznO1gck3Wa24LTFvdtIkNlQevPFMxF01MkE8EmhZDMoVhIv/cgTne8iAtseDe7qzINfv4dRAlqHdKvzggRCOYO+hqXTlYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOSZBwny9hHMJK6gd7Su0UcpGsh8Ed46lhVcsMPz/p4=;
 b=W1llhj1pKCRoD5+yWGO855/+DxNAb+a85bacak6TguF0Uslrx0zoCLgihpDko0jC01/o9gR62eH5+TcJCQIyXzYi47yt5Jgx/0cxnhbXTpC1gWsxVcpUptloAeJQVBNnhhMSlu3WrJHAwubq8ysKrEmdMXxWnbkDetBBJG3L4Xj1aXzpEWHZiWsfYYRD/Xo7C08EYsot3gZYxZNHeGXQkT8f54Rv51ecmpgv50Ka+3j6uqgib2H/nl3kQ0R0mkIA6lgdBP9yPa6s1rX1kRdfhf97fkSykiZmK6jYM7C2V0+A7wKy5IA2HHZbrUVJBNAvhduoUeNx9jH29DTYve/uvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOSZBwny9hHMJK6gd7Su0UcpGsh8Ed46lhVcsMPz/p4=;
 b=RHDRoiY1AoFmZQpcZwKzjJLbo/aD3v8VUmXAi7J0AkBOWobX5PDXsU+19jRo6Jde7JK21AUuOS2EqMxG4ce9tBFcXKy0YPl6LG2TByLz7c9c1K3jzpMPOjKWJZ2tyNW1iv1uZB7kHQ9pghyPzEva980YtG9Q14IcN+BPmCfuHkO1ZjbKfvG8aZ+H0q3IjSgt5D+Q8CChIIHIQKZ3zSWv0rTkqhy7/jIitYUni4LYmR2xKwMvSGcTPEZE27d7f9UhrgJDM/aVxWhEYmBkPnR2bSz5f6/rJ5BD5aWHmCsK24P7quj2j7Bzi2Xn9BXBrOgyLWhirZd3utSiu2AoS9BI0A==
Received: from PH8P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::21)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Mon, 1 Apr
 2024 18:44:22 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::70) by PH8P222CA0019.outlook.office365.com
 (2603:10b6:510:2d7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 18:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 18:44:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 1 Apr 2024
 11:44:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 1 Apr 2024 11:44:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 1 Apr 2024 11:44:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next] MAINTAINERS: mlx5: Add Tariq Toukan
Date: Mon, 1 Apr 2024 21:43:47 +0300
Message-ID: <20240401184347.53884-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 04419a37-f4a7-4e58-9cc3-08dc527bbe87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NAq0bzbc50X0uWI2oHjoJpZveb4FHIq46+/VWYsunyOChFf55AI2hfYayJZOGVRxG73T+MhpZMI2GWWWi5i8HJWeKCBxrxiWTBTCHL1ooG6sxw/F+ZgK7Zzm4xh/Q+FMLN7OaU0YrBSVhjMxxMmJw4DD9P+uNemd0krNw1mEMM/ccNU0gXNHkR4T6eG3i3ZDH558gVRoRB2l9ZDvi0jf3b932w2dd1igomnvl1L9AFITl5q80UmU/jPbGDkB9SJwzl2y/vB2AhWpcqgZXt7YrXjR4ggFUK7+b3xWbF/QQ7yOLtkTHVk670Tf2yf/AmZIVZBdi2Hv8pCXRTN/xutJmtrj3INy6eO8PNU3b2hzlHqpqAoP+jCHtduiIHMYiJHYxlpQMNVydXowmXX9tcHvLNiONrnICR1QdSpHC2k3+v/uu9SCefajyA2ovz2jijkLd6WgTTemN2j9V78lR90zHVOSybyuOnRsNBZiBCs8Sng7QfsFlWKEc8+he3KeKEuotgsDqhV9vAi08Lrz3HV31lwmbrm7xOU0hSN1E1EO5Gb+J2N7zdsliBEEBPUQE1Yk8GN97pGawRkEKN6bYBFz9vc37aMk8k8ecK7whHL+uJ1+U3Q66IHyS23y/x1E5rFkj88YylK6b9gfaXgEzFBS3jCRiIQb6C0MM6L7hHoH4Mm0YRqyQTYs4NQDGuZZO9u1OvcgC5zm3HjNFmIel9CMqCfs1JFtCgWc0S3cB3ZXBHWkw8f3VmfytCTJ4CoRKp6+
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 18:44:20.9531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04419a37-f4a7-4e58-9cc3-08dc527bbe87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

Add myself as mlx5 core and EN maintainer.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f736af98d7b5..e84217a3f901 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14013,6 +14013,7 @@ F:	drivers/net/ethernet/mellanox/mlx4/en_*
 
 MELLANOX ETHERNET DRIVER (mlx5e)
 M:	Saeed Mahameed <saeedm@nvidia.com>
+M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.mellanox.com
@@ -14080,6 +14081,7 @@ F:	include/uapi/rdma/mlx4-abi.h
 MELLANOX MLX5 core VPI driver
 M:	Saeed Mahameed <saeedm@nvidia.com>
 M:	Leon Romanovsky <leonro@nvidia.com>
+M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-- 
2.31.1


