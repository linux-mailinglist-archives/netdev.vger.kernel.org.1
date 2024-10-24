Return-Path: <netdev+bounces-138752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA59AEC27
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E83282E84
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366D31F80C0;
	Thu, 24 Oct 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WXreoYPa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9D5FEED
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787533; cv=fail; b=czPwM3yV+lwp+IKUt5vh6uDpGcBhjWjPK4nkINYELOz/wl3vN/pS2ujV4S0WAAy+Qo5xlnVEbigCd/+RDq91DzVp7XLVUf4HtEQMnwniS2Bs/0qWttCW6Wx21xvuKHb1EbehUq29N9fBMZB8IPht8Gs0zcp1O3ce3fWbnsV8ngc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787533; c=relaxed/simple;
	bh=cmn0EZ+urgpMJdbiZ4p9/hDzKzuk5fz0jWRBw88EioE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ujBz/fJMj9mKCQ5dAY0eX50wST2EI+TzK8Z6y6+/virhHcX4/OmsDZ2f4GTmL7GJildUGJt7iK5EzhgaYwb7+PP61GBiux5WybZ8hVVt8dDHb/hH9tdOtDtzvC9ToDM6HT7azZ/+8JfjSOp056nj2a+achDC8i4pbYxaoa4NfUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WXreoYPa; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAQMq8oByZPg/2uHxo+mRCGHlBJFMGDx9E8aBK6IYu08+xf26KSe6qZzsxaiF4mS04rVsZ8i2ma0aVE2YkxvupRrpc49VJptmnyt1IwLK6MpnASss++kTN5YFisgdvrPhrN09UvGfbVVgzZa1izzTE5g6uSyqN/ZwLl3c9vkGj4LJ3yphs6mInM54koo9QYPe7TpcA9D6IaRjPj9pTGA7mzzukIfiUQ+fEgCPHrtAHsLyFEWyv9ux5kfsGLzv6mQq2NGbVkWtSUZmET0eK6j5IPRyQeHdviXYRxCHtxURBLLHfhFmZIevjlytViFOHPvsyprT+AnFQg8B6OPO82gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9SFoHUeEPECJTNXuuANMIHtq4Lta0fTMSUuztI0vng=;
 b=sr2tY/TgfFpdrQ1sNiEDOi9PFPyQyyvll2djL1oeYwwCE5ngzDxn7X0hKfGeVrkHSB9zVJkRGyOEFmyPj2q0lMAqzZ8JsC1ZdyH39pRuJXAtim9EgH57MiHNN3v/mCHSZHbKdh3JloZpkUPJqTCjU36OztU1SrlMPRaGTwJl6/yLUMLtWse1/t+vwsg4k6RTZxP6JM3rynpNCglk3Qum7e5m7M9t/kf06RJf5ZqJKrAafjIweGg+4iP9Ktz1jcBUnHAyfF8N4g5rWm4APpR3lMCtXhjbd14/4e5tAQ0i4a13zjNftoQkbE4CQJlDVWAcECjJvfEbI5MZT0auz0pniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9SFoHUeEPECJTNXuuANMIHtq4Lta0fTMSUuztI0vng=;
 b=WXreoYPaFpCgEsaJusQjCZZj8w/jNAdzWAkSAeXCnoWph9XR/vuSYrP3BHIoI2ygP7UCc0RTGQkk5Hgzc1pgfcHu4SKlYTCcgzeWRNY4TYZxBHaxCGzA7DMGNVdA/nO5cmz9m0K7Rdh/MYHacEXSHTkWobE24x16B1jGrgzl0l+jwf384gk6GMoGCYxsTMVuAqx45KX7t4vyQdI2CjItOaWZp3Obupeh9GYIpAWpXD7HpTMRi5Z5LGOtvr6CjBmBv5SQI0GhnGQfzkRweApcPqdX3dbt8W6mnOQitNH1R1OYa7Ip/kQlE3/5lOw7850eW1DnD27Xtz3g5NbRx6KVWA==
Received: from DM6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:5:1f4::48)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 16:32:04 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::13) by DM6PR02CA0107.outlook.office365.com
 (2603:10b6:5:1f4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 16:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:32:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:31:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:31:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 24 Oct
 2024 09:31:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jay Vosburgh <jv@jvosburgh.net>, "Andy
 Gospodarek" <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next] bonding: add ESP offload features when slaves support
Date: Thu, 24 Oct 2024 19:31:12 +0300
Message-ID: <20241024163112.298865-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: ac927122-5b42-4437-c954-08dcf4496481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NUlPq0L6Vj7R2CPlrioqrUZkZuB8NYJHv8DUJvy4D0trwjxWkT1fKTd/fFBQ?=
 =?us-ascii?Q?vJwmtoxhfzvaZDxKqe/uUh2fuQ+PfmU+/mVFPWDg79J55D10yjPny7wr5DT7?=
 =?us-ascii?Q?zWhdakvuPOlXQEUm3O89lLak9LkFpBV3DaOooy9EaozfDqYUHaAp1Z7gp/nx?=
 =?us-ascii?Q?zM3TRa7dkXN1gasdGwX+TyfVDaxdzf2V3WdfbetKxTLI4Pim3B+Z7rLXzRSY?=
 =?us-ascii?Q?9NIZ3QZ0uyW3lWDhZn0xdH288ZLyx6PURar0v/6Y6CuAc9u8vOYY5Vi/H1Uw?=
 =?us-ascii?Q?kEaq5NZe5Zu5cQiTwIPftQR2B12gklaEqdMvA37mi9qDCL25h2p45OxG4YfZ?=
 =?us-ascii?Q?A5Nfoq7uknXR5a+W/TfpQ6Wpe0rG3+3tkob1Ympm+WETM13ukHf0Ev9E51yG?=
 =?us-ascii?Q?lDWZA9UdBNrqOJ6sLB8bdYy3CaTIPDIz34jmu+Qb0W2BdlUP0gkzmxZEBx9A?=
 =?us-ascii?Q?Foh0NAokw055vmp2mcmZng4y1cAStHjea42uTSp2FhfvGR+29Jxjee43eSpo?=
 =?us-ascii?Q?5MO9hDBUQAfPxMZpjW/WdDN5dwekdlAlRuLv3ermUSigJloUIBKDrJxhgDs1?=
 =?us-ascii?Q?+MyVFBGezWSimj7ztCZ7oxZFAC9ZA72ap1N7tRyg09CGIYtGT7NH4DNUr5bz?=
 =?us-ascii?Q?3laHRksli4q1z/erWp0UpKTQ6cfW8P8QYnZIJkKFZhHKh+VfK3ITrZx/7U1D?=
 =?us-ascii?Q?Y+L0eaekwc5kQuD+5ShAq1NKFSH4NBgAb5DDN38z4Ym1zAYefdtiqWKypkZt?=
 =?us-ascii?Q?79xDdKsbE2qDVga6NNHVh6iMCwqVr6tXatzlXdvaq1DN3XirnxQqa6LVDNIM?=
 =?us-ascii?Q?2sLIw2jQW56qLTo1j71SC8eFpMICoHgh5AU2KTpkMCDnvlHqdNskFOUT7Ph0?=
 =?us-ascii?Q?lmyFTWwBgDo4aZ54w7bJd+3Lh6A3qSZzi3wo4sQnaLWrDR37bGoJ6c4rDdyH?=
 =?us-ascii?Q?kyzxgdRLEZ6ApRGiD923w7clZyhHv7s69NNngSgSNB6dYJ8ZMRDeUqLMjzUA?=
 =?us-ascii?Q?InGsn21rMNbo0vIuPkUkqcshkWC+5Isqiun3o7owsX9UsMFcTDHaONRK9CLQ?=
 =?us-ascii?Q?KV4OkbNhFfPWNgfzKVOu+5afYio6ccAUBWPD8bPB0Q4aZIwmMCSweq6//kHv?=
 =?us-ascii?Q?o/UeADJTN6a7LkODPsdwFDg6lpg64flIy6NLYmnQTp0hzjtXpzg13MmAVWJI?=
 =?us-ascii?Q?9ORHNvG/M60pqCJAyPWlovFbBpwlrDHrqAPguUy56rlq6HH4J4lw3uWyvGsC?=
 =?us-ascii?Q?2lKnQ9Y6GegFLa7QQLcK5yE0GHru00Si6wZBeO44X3SPyBr8VYywlu1RL8qk?=
 =?us-ascii?Q?0SE7Zn6IEQ2/elZ7V5w9XDNyTHJvEzeMZRDYskx2KbWxzFZJPloR9Ag+ypPj?=
 =?us-ascii?Q?xZGQyNM3huUgxLAtNBzvMSzswx+6AAb5iSt4lhhrnuB62oZrJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:32:03.4222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac927122-5b42-4437-c954-08dcf4496481
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710

From: Jianbo Liu <jianbol@nvidia.com>

Add NETIF_F_GSO_ESP bit to bond's gso_partial_features if all slaves
support it, such that ESP segmentation is handled by hardware if possible.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3928287f5865..f7c734cfb917 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1548,6 +1548,7 @@ static void bond_compute_features(struct bonding *bond)
 	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
 	netdev_features_t enc_features  = BOND_ENC_FEATURES;
 #ifdef CONFIG_XFRM_OFFLOAD
+	netdev_features_t gso_partial_features = NETIF_F_GSO_ESP;
 	netdev_features_t xfrm_features  = BOND_XFRM_FEATURES;
 #endif /* CONFIG_XFRM_OFFLOAD */
 	netdev_features_t mpls_features  = BOND_MPLS_FEATURES;
@@ -1575,6 +1576,9 @@ static void bond_compute_features(struct bonding *bond)
 		xfrm_features = netdev_increment_features(xfrm_features,
 							  slave->dev->hw_enc_features,
 							  BOND_XFRM_FEATURES);
+
+		if (slave->dev->hw_enc_features & NETIF_F_GSO_PARTIAL)
+			gso_partial_features &= slave->dev->gso_partial_features;
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 		mpls_features = netdev_increment_features(mpls_features,
@@ -1590,6 +1594,13 @@ static void bond_compute_features(struct bonding *bond)
 	}
 	bond_dev->hard_header_len = max_hard_header_len;
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	if (gso_partial_features & NETIF_F_GSO_ESP)
+		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
+	else
+		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
+#endif /* CONFIG_XFRM_OFFLOAD */
+
 done:
 	bond_dev->vlan_features = vlan_features;
 	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
-- 
2.44.0


