Return-Path: <netdev+bounces-100359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412078DAF20
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D05282444
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573AE13C809;
	Mon,  3 Jun 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SyqRst0y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC611311A1
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449829; cv=fail; b=dzYELSiF9vuJOaQNiTCnMJ1eCz0XyPTW0VXFeET2blsaO4NBVlSpIXfly+GoTZm/F3Xso11yZ+4ws2ZPqO6xafi5elNb40rT4qoBtpCM20aGmCFsw1KdRiL47pn+0KUNO+wcF7ckgKAgrGhl9FXKmUdtjVCOOnlDEgJq6aN/OdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449829; c=relaxed/simple;
	bh=Xc/1KygRMhfy3dfPvcCvjQ8oUblvE+xzY2tKItIh9Dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zo4Ae4DC+5wL3J1AbVwJL4dEX87NJjUMUDiCQBupO4kjQm0ciTzTUt+mPYHjbwRe3YoUJoYZRqr5TeaV4RmuzJy+vh9/eXozi+9mkWykshIpNiyNdrQVPOZLb3d4imFebHH0eROnYJhPzYpKwn9ndQM+6pTJThojPqWNF5AfRCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SyqRst0y; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4ufLEK5pHbLvruVcA3fTdMdfN+f4BVbDPS/9thN2l5EwgtMqpxXW0jXq1VpdBjA531QODsPqKm4svfLKAaKN1K7mubaX18jCD8NHMfvXFv4lJ+51yjmT9NxHesKfqMeZWTvBw6U1sR8u4MmqT73PlI5qm/DcgfhNMVUqkcgrs0KqxUBPSllj+DLGDC25ZQPkdyCa9zUZ1rnZjV0kcFSyhJNyqIP93UW6x5dyRDOJNuPRYCeHliXReojuuxeEwEQsNrKzRV2We423Ap8MmrvTsH9TKa/gHSeyWVuKZFoHK6FkWcFtSSpKIW/ZUDyCN3yOc+0Fyjdo73u0+ePWMg1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fy3IGgLjZxxQ3S0SF6S0vErhZUNJmun5lnhCVsXFVz0=;
 b=Gp7f1u0T/mOSK01RfdSB3QURUEmAXbK38rcjtjQqkzXcuKtm5CKkFh15TnSljb1GBvySuoPojbdhJKVONDSdTDdq6M9GEejx+WbOKQpFwc0ZOYGNbU2BTjpHRQSachQPzTaPnejb7taS48MqkDykKsb3YLTkThbzMU1BC6fMMaEQjCbf2rTCFqZZIYJP6xlrz0YskR/NeBgrkahZcehl5XGOD5gI+D5H9D0KTY2lyfwEfL0ihdJMHgAl1ilwkxulo03swPnoC2usI5zy13l5MseXnFhR+9jrV6zjRzWTZ+A02NS9z+ZkPjiy+YhxBvDVrSZwSCPX0AmVQNYUQJxkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy3IGgLjZxxQ3S0SF6S0vErhZUNJmun5lnhCVsXFVz0=;
 b=SyqRst0yAzSWHlQCiDZcp6j2+JcncZ7jqVsCFIuD+LxkslsD1bJJuyrE4jepDmLHxZtM0o/Ldzu3vCaNquLj0bnxJPDZpkkLTBf8Dh3LG5309WKir7B9PPMOgHRUVvCI1jaCR4FxXZqIO650HHJgSMHfW6CSMbY1eILBk0X/QaZEV8lStkXeaSsQSEQqUFj/XqvFVQTsTZZrAs/4cQTcNG93ztAKCUxxobhjqJifEAMXGIXO6swDpskSElx2nsiPEopUHXF7E+kkIXIAAAzaatSN1Ts3luZkaWfBbk543IjIwlEVmmV0LMUJkwA9yj419ut4Dh0fTq0o+wf8P7+bog==
Received: from SA9PR10CA0014.namprd10.prod.outlook.com (2603:10b6:806:a7::19)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 21:23:43 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::47) by SA9PR10CA0014.outlook.office365.com
 (2603:10b6:806:a7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 05/14] net/mlx5e: SHAMPO, Disable gso_size for non GRO packets
Date: Tue, 4 Jun 2024 00:22:10 +0300
Message-ID: <20240603212219.1037656-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240603212219.1037656-1-tariqt@nvidia.com>
References: <20240603212219.1037656-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f8c0af-31d7-49a3-7d86-08dc841371e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GDgbjWVIcoXFmQsFbMF1S6Uouje6mVudNLpe3vAib6ODIjQezuI5GqUfxyMF?=
 =?us-ascii?Q?GUB84difsLApjBd+XKyEqtrB7g+/U4GZafDFpkD/Wq150/YLpTckg7bNlBaq?=
 =?us-ascii?Q?VvyBJRDcCq6dTj5pqltFnHsvOYTW1esxEKMTDFLqKE4GG9BbyreL5ZZH7LWF?=
 =?us-ascii?Q?FXmGuSX5C9xjqzdF/iS8J/SGMZzxrBeGnUpof7tT8FChK4whMiXia6heNJVS?=
 =?us-ascii?Q?qgEqUJdYMM4axq5BuXSxFC7plaNjZAZtmGBu3s/C72MI6mwAr5HSyeKJDr4g?=
 =?us-ascii?Q?l+LyGhjX04qOLMM6eK+3o295KFoOxDIAyd1fy9iXM9Xwm31ezTS8yT+amXOm?=
 =?us-ascii?Q?cXekWe3HDLcF5UZtf8xFvx/cI+6LBbF0o36dUPjcBOt+Q8NauMRbiCocELUa?=
 =?us-ascii?Q?SbD2LYV0z9d3AM8rr/DCjzGMqyB7CaP5nYJ0402sCkJKIE8l2W172p9mRJQt?=
 =?us-ascii?Q?Ey1r0lVsIMEHcUhLnDcR5xPzTlQ0nl5Y4kleFUSvX+8uhy63WuUoHtqY56wN?=
 =?us-ascii?Q?i6jFAQ7lJUlS76zXWXMh+vDSJxp2TvGDxavjcLgmTXiexq3pJnHyVsT8c2bg?=
 =?us-ascii?Q?OY/V2YWg8P9GtvIG6Wv8md5XuvpJpIZoF/UBcOKKJKzHDEGVwZv9b16qJDSy?=
 =?us-ascii?Q?wE3EZjxOK33v+Y75Mt/tJtwU9NYfSo53Se+mQWT/tlc+L/9JDqXAPLVZB+II?=
 =?us-ascii?Q?eG/PMppvpEF2wVAIc+kIPEg2SKQ61vzFqPJ9Zy+oU+6DggPBoDxfLAvy5G7e?=
 =?us-ascii?Q?76XZQQrxt2y9qkHp+41xhDL7GkaifZ4BjNzMFDlQIwZJ3z3uyJcCQlGbMRRI?=
 =?us-ascii?Q?U1zNOTKGgHoMy7ruPbbfXc4QxR9Km+wgK2jxiEP5V4THkmYc8HGoRXysJ5xS?=
 =?us-ascii?Q?DSw8poUwDKMiAV8L/n8nov0Vi76giDtoW3LyDyOiPpTMuFz+fL0A3V7nqxuS?=
 =?us-ascii?Q?zr6AUVEPbmkXUeNujqlPfjJcWsSF4whkJYoqtbKRGd5xS6BE8d5asQ+fXbOm?=
 =?us-ascii?Q?RtsrFQKoFDmcSzeSfgLAMosJPXJpC8L4j6JMk4l37dm0qaIicN3RlKqAi0YP?=
 =?us-ascii?Q?6SxW/2jE3pGqB94hzkCwdcbVCMMvErcMEL5txZ0MswNtUFeCjmfnhAFwXlJn?=
 =?us-ascii?Q?4mOJZEPrBpOiYbApU0a36WS18Qy3sChfQO54SJd//CxUQPiDX/YbJClkrLyl?=
 =?us-ascii?Q?Qnl6nlxsE1aa+nnACt4p3b6MyEDxG5iGY7krU1GPGHnzMbG+bU/IGuSYVIjl?=
 =?us-ascii?Q?sbgiSIEZpD2RDp0Fvstn5b/Uko07SFlhXp+UPkMeETlWd8Mhz7RMtD57GHyz?=
 =?us-ascii?Q?+3tnxY1nhvAnbIwAn061HRSymCWVqf+fATlb3OC1sq6gNubUpFNuf0KV5Bqe?=
 =?us-ascii?Q?2T3yoDo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:42.8693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f8c0af-31d7-49a3-7d86-08dc841371e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992

From: Dragos Tatulea <dtatulea@nvidia.com>

When HW GRO is enabled, forwarding of packets is broken due to gso_size
being set incorrectly on non GRO packets.

Non GRO packets have a skb GRO count of 1. mlx5 always sets gso_size on
the skb, even for non GRO packets. It leans on the fact that gso_size is
normally reset in napi_gro_complete(). But this happens only for packets
from GRO'able protocols (TCP/UDP) that have a gro_receive() handler.

The problematic scenarios are:

1) Non GRO protocol packets are received, validate_xmit_skb() will drop
   them (see EPROTONOSUPPORT in skb_mac_gso_segment()). The fix for
   this case would be to not set gso_size at all for SHAMPO packets with
   header size 0.

2) Packets from a GRO'ed protocol (TCP) are received but immediately
   flushed because they are not GRO'able (TCP SYN for example).
   mlx5e_shampo_update_hdr(), which updates the remaining GRO state on
   the skb, is not called because skb GRO count is 1. The fix here would
   be to always call mlx5e_shampo_update_hdr(), regardless of skb GRO
   count. But this call is expensive

The unified fix for both cases is to reset gso_size before calling
napi_gro_receive(). It is a change that is more effective (no call to
mlx5e_shampo_update_hdr() necessary) and simple (smallest code
footprint).

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b3ef0dd23729..a13fa760f948 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2267,6 +2267,8 @@ mlx5e_shampo_flush_skb(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
 		mlx5e_shampo_align_fragment(skb, rq->mpwqe.log_stride_sz);
 	if (NAPI_GRO_CB(skb)->count > 1)
 		mlx5e_shampo_update_hdr(rq, cqe, match);
+	else
+		skb_shinfo(skb)->gso_size = 0;
 	napi_gro_receive(rq->cq.napi, skb);
 	rq->hw_gro_data->skb = NULL;
 }
-- 
2.44.0


