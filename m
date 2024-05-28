Return-Path: <netdev+bounces-98633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD58D1ED6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDB6B22547
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B517106D;
	Tue, 28 May 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fQc5Zobo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C016FF49
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906597; cv=fail; b=XWEWHfNDkJw8J4PdsIm/FSF+wE9mfbWJHNbRVXTMjqbfQGARkUlo+167sUXmlIfiUNio/ebtJknTPHbV22wgGVKaNNZic6gAvvSn72iJWQy7oncETzJaGLNHy2mtsOPImFY+1sc/ho35G13qpm7ENzIVBcX43D9sM7uMEGISumw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906597; c=relaxed/simple;
	bh=hrF/mVUx0dJgBtaexHHloiztYuX6/SNLO4D0tXhHo1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fb2L2sz23dETEjSufuJQ1kyajjHr9NxScv6ewOpF7wCGf5MQ2R1UdgEoIG8F6Wk4jepVG3H1EVwLblKYI9ZCqzSGZIpXUc8bj/gXT4wNbP/0f0FZX8Ffp01W0o8lx3uMT3wDaD5y1eS2dhkVMW9DfXSA9R6I1hCR3qdqLLh1FVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fQc5Zobo; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5BEhS1vQjR5gOKSQ2yCwCr6QVNiBcjTL2oTknRPUzoksE4CW0uuPucNluqrnmvct0MtHgcHZ9Y6b3UiCTflgXWwoazJ284cjeQz+S9pib2RR6Q0l8FWayTjDiYkWx2PP7hHFlEhFKgwC0dEpIozHj0M0ZkG1BMnJNjnGJYWUrtq9ql5nKjy+1kG//L/jL6YylQ5AT4GIV2uB88vMVGiVj1P8JdoiQ8cBhBQGH1gRvbuh868/GAUEr+al5uQ32SF11hZCu70W7RVnNuv3nFvE/Xfq0qH0CsAz9nEOR+INgS5JC7BTOdBi8C3rBHDdmgHKbrCQ2f6uuQzzUBFFpKCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/ZHt7/l7K8lEZ7X5hQj3OPKHMubYz3lZb52HYmDlDk=;
 b=EZvpluTAaIoEX44DeRokrGQPOc5h0amN0nXocEPitzNMsCtJC/UM7bdFTNghNvRlnu5My0XQjqYiXKqroMB325gcjgpfulzJg8icllkdWqAwdZSzRcMdGbTm7LHyrf6cPfTvc3AU8pw24xtG3tuS3DtvQQ9ceEVhcxMwXAs2kZ8k01RKqE41qUS43o5MPHM92ZvBVb+0LSI0+NcMOYKQDg8r71owKH1I+X7LBFMTfnjM1fb6Jt9Isneu9SBGlXEtMykhjrKaw26wkBL0QpvkHFPrA88stxBTKCEM52FMXY5t4IAXERfYzq65PLpxpJQEDOpPuiXfQ9XwDpGH0mDjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/ZHt7/l7K8lEZ7X5hQj3OPKHMubYz3lZb52HYmDlDk=;
 b=fQc5Zobot+7t1kyL7YrrQhN797n7P7wC2YvqzT5+Zv0TyLme79paXpXCe0mtgW8Wa/kljRuCXejCRnSR7EqHIcxxewMXXqLdtFBLZn+IZmSxzythr30iF+JF/klEQ0BtUrdP2RBl9cY7mWJ9urVYqoLyHPjO25wAI+gBySicuAFkpyOQGXDM3v4UbtoJW5dwwryetGfHcldDaafBcWgevAgHQgXuWCN6H/Cq3GELVK1Z1ZXIB58+fRtDereJe+dKg9PcPDSOzh6Hi7Kh14E26ALXFMInRhSIrXIdb4N+K1gLgPB2BclPsQYWY+3ua/LhW97S4Z6FRmjoQsXpNTg76Q==
Received: from BYAPR11CA0070.namprd11.prod.outlook.com (2603:10b6:a03:80::47)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:29:52 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::cf) by BYAPR11CA0070.outlook.office365.com
 (2603:10b6:a03:80::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 14:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 08/15] net/mlx5e: SHAMPO, Skipping on duplicate flush of the same SHAMPO SKB
Date: Tue, 28 May 2024 17:28:00 +0300
Message-ID: <20240528142807.903965-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528142807.903965-1-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 341eb793-8301-49a4-5832-08dc7f22a2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CFJx/OWfxReVReKjKEiMhen+76Ot9Qy34kEs6FV2Rr1refzQov+uZrHDxcHv?=
 =?us-ascii?Q?2yjrQMAJkh3Sxw1NxLy3SWQexskSNC1tNyx9OxPWMzH+Nu9coyESFwrCdm5s?=
 =?us-ascii?Q?A6fETLsLcGlsxt/l37V/OJFdugJdZ/F39WPftCiOHT0uH4FBW2CPOBWboghG?=
 =?us-ascii?Q?RuD7gmYLizIYm6JDaw/ArM6cV7uGu6tBQHOpmGfZ7mB24Vqd9R4co8qrod7c?=
 =?us-ascii?Q?6/gV2IH/0pvJ0uwdD/PgD2x1tVDrWo+/O62r9ZRdo0zBVoyPfPgPZPEwwkzi?=
 =?us-ascii?Q?vA4uUMU9LO3EhIfBQCON22QmVw0nCuipIWrCCB0iCbNAfm0OauKxv70/3ip3?=
 =?us-ascii?Q?+cOc3ym2o0ULnAn17MDcuVU+E0ZTDzuGr0THCuSvwr1XAPJNuvvkTaqPQWQQ?=
 =?us-ascii?Q?+rTnlmA4v/ythQFxN3i1RbfLBTLK0V4yN1RlHg+AM76c/mainXVscQDPbp8y?=
 =?us-ascii?Q?s2ka8I4TkZDEyGY5GCyAI0eBZUAFg3zsFpNX1X0mKeihmnKYhLXCY0kCDx7s?=
 =?us-ascii?Q?0IUSMVKvmLgbudNIWVgf4qmIjCjNx4q876vdPKsiiWecRhBEqle55Ab+KneE?=
 =?us-ascii?Q?iaeZa4Md5tcerSZnu4OthrBsEHujUdKxj+5ajXhw6u1qhOuz1UFc7ucl0XjE?=
 =?us-ascii?Q?2np8wd8aEhNir2KP1ptfKeE4o+L95pUJrkkgqZk4pQviVVoHjjolFLk2CNqm?=
 =?us-ascii?Q?q5fGGvRo274cHdwxl2gPNzi2tlczmXq/BStSDNu9Ab7fIOUdI0xPw4nrRJNX?=
 =?us-ascii?Q?rcqa/+IkD2y0WWTzs0IIZqIYxVHQdum3X8yurj99GeKY/ST7of3vxWgCHNKH?=
 =?us-ascii?Q?lYDw6fty/OBI9CP3yKHNcpGkpaYQuqypv4sODI/zCS4b2N5EuePQ49+7qRbN?=
 =?us-ascii?Q?8mAstJf6DBkPBtj8PYpdrU7gDQctdnYijelUSnm+63lsB+VYKL3WPhuL94d3?=
 =?us-ascii?Q?b0I2tFkszeG0kbhegk0e3ULjD6rG+v5Tq57pJv6Ui3Gf3Vw8DAler8XJHMnt?=
 =?us-ascii?Q?ka6+upA0zeuCnk73sUd6S40AKj0aTwpatuKlIepxBrGPhDIX1PVmbaE/r/Zu?=
 =?us-ascii?Q?N0Ip+kfMC0sO5n9pF9bIcyJVJ0gRyMIAm2Ia8VC5jtfwCv1WUcm580mer8A3?=
 =?us-ascii?Q?fgodiaLynDXuX911FHfjFEyI80n9arJ6b4+xd4ThFYAYIf+/kwtPpKYknTQE?=
 =?us-ascii?Q?Es+qsZRHAeEOZC19ZxMr24i6SHfLogw75oD6uXPYDzb4do4vmFnofG1h67L3?=
 =?us-ascii?Q?C2TNDWXKkFRExtw1YJzgTI3/QWDEgfCT75IWUEq8zeFQoueHmcgLtujhltUG?=
 =?us-ascii?Q?tzF37sUvxTsSOGbhXVKQYJDE5FdDEl8uh6Kpo1EBwUhEtt/708fqU+/wKf9l?=
 =?us-ascii?Q?WWEVtmrA46y6TPWEuV/kUB9SryQ3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:51.4819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 341eb793-8301-49a4-5832-08dc7f22a2c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

From: Yoray Zack <yorayz@nvidia.com>

SHAMPO SKB can be flushed in mlx5e_shampo_complete_rx_cqe().
If the SKB was flushed, rq->hw_gro_data->skb was also set to NULL.

We can skip on flushing the SKB in mlx5e_shampo_flush_skb
if rq->hw_gro_data->skb == NULL.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1e3a5b2afeae..3f76c33aada0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2334,7 +2334,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	}
 
 	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
-	if (flush)
+	if (flush && rq->hw_gro_data->skb)
 		mlx5e_shampo_flush_skb(rq, cqe, match);
 free_hd_entry:
 	if (likely(head_size))
-- 
2.31.1


