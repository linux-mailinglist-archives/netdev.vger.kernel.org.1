Return-Path: <netdev+bounces-142080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C39BD5D5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A38B1C2094B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3391FF7AE;
	Tue,  5 Nov 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GXGiHflg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C81FC7F3
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834916; cv=fail; b=cffLYem7OlaW0H2uunQJ+FOP4sTyuoByGNrdM9qaJwx3U1JZIlSFE/9mGX5H5iGmQZJrn6RW1tznYqnODwz78DUCulaNeepYS9pojYopj3p/d/fRs7mSuKNb/p64OWM0YaSW6yoiIfw54e7/qP0NLAg0R7StkmqgRgbOsJMyulw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834916; c=relaxed/simple;
	bh=4bgTxPEMOEhsM1TW2oSNGlSgOmTMZuuuq6p/kyAcSzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E6rHiOKaHEVz9q43+5b9Wr7q4Rw5H00WvwPS9ZND/Qygwx4OJiJl0ZrxTu8I5k45qsO40LZUMGlS5R8ovLjoTbbPxczdIHjudLf/np7ul5G2qWPoq5r1hp5R7cdDWKFWGj9POzdJA7TcU6Jpz7ay4LBZqEtVcyTOM6+n+BNE4/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GXGiHflg; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tatvAPb6vLuteI7Z8NlYo0C05RtUu4G58oMlkS/X8+FNuzMT2dKWzjlmbal8ZkmNYQOxLfd6IeNKNA9cXRJqnN9G9VcYmxMJsBDhUH9a6sVdS1y7xJJtUBkC0vlGaVRLLSj4y9MO9c6HTpQ/RbOC4pxWpDiMjHUueLKsMehH98E9R/sFhGUHTrMWPDGYCxoPfLp2VOobi/RmLW/flXwQ8WjezxnLzmr1/kvTtgPmmXkUmURzlSjIMTyubfeDSwkWt3R+QSV2gy8CAOjLKnZCevffFIPSPqzvnCtV1B6085KYVg/sXa/xhRbbaAPm9RrDZu5HzO/YOhhMabqNTf4qAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IN5+j93XdOqD5NDCJptx150xkQnwIE2IJwynpgruQc=;
 b=ssi/CWA6c6c+hD6oVLzs4skoecIqLZo6BL8WcUfq3UBfsbjs1K+cjETsYzjnH4SReLrkpY60SLTNBaKHYZ51LnEQUMJwT6X7FG54/S70a6awxcxXT+rPeLiX8NiHpbKnRqTf2WCXwlik+YYP7zW0+MCjWryqHH6JavNArNojgytfKvdXNKQ/9FF547Tfl3OFCnR1idd0ve/yd7Umj1S2JwV2jUb8v47Wtnuk+0P0zFLjOhcXYHx54kacM8GdSKQdst70mU7ddNbCzFI0PlrWkAvNHyezztmxrxx+/rEG6TE4oNfof6BmxCBspexpqM51ZVdYxG5p4JqAXIoMcRVMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IN5+j93XdOqD5NDCJptx150xkQnwIE2IJwynpgruQc=;
 b=GXGiHflgleP3houZcvsfDgHxY0+HZ9DPQImyr5nHfywut7pDbX6o+Y5t2NJGi/7Cm88FZeAubwS4gU1066IeXePJNL96ofFk9tqpzFvUOP4XrqMsY5xIy2Lt/4VuVU8Bl3ZOCScWpSfBKTpmaTHSvBNmoILZB1scFzcn+yh+EAw4eGk5jrP3inCvt276UwehluVGM2C2V9rRF2d+/jWSNFFNqZnRbiMPzU9Gi09LoneLqTErX0inX++t8VhZR3wJJBy8Q69POCsonc76XxJpJQEIs62sUWsT1sv+wxFBcIQui+ELlQCbQygEHziyLl7HGXnbZe76PRuPh3rKlwGoLw==
Received: from SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::30)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 19:28:31 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::d8) by SJ0P220CA0026.outlook.office365.com
 (2603:10b6:a03:41b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 19:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 19:28:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 11:28:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 11:28:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 5 Nov
 2024 11:28:03 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jay Vosburgh <jv@jvosburgh.net>, "Andy
 Gospodarek" <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2] bonding: add ESP offload features when slaves support
Date: Tue, 5 Nov 2024 21:27:21 +0200
Message-ID: <20241105192721.584822-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: c04b77d7-4cdf-4d2e-8997-08dcfdd007d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XFAlKYRoF9bvK/RgmqJIH88khjLBvSAtTFyXdfSkR0wF7u6Bnd8N+rBxCxmQ?=
 =?us-ascii?Q?knXAqZBJqeuXTtBcBqsS8uc17tUSzMw+RtTWRzpGJxvVlRJqNcZLsSyWmXqz?=
 =?us-ascii?Q?12z33K2Wvc132NLDBBnKMOimrlnRxFJN0DL59PgH8qEIFjlAOn2FxJOpvK4O?=
 =?us-ascii?Q?pMvvgKxrCIQSc90ajRXvqJ29yJlAQw6J2iVZQ9mPBDxS0b0QxMehiH5tzNAH?=
 =?us-ascii?Q?6rwwQYClbGFbBMY9dbgohI79NS1IKRrRZFCkJKxfvvuz5i8qX5VVP1A3yVi4?=
 =?us-ascii?Q?pjxSqf92h6jTRCs4pZuFDdPTNgf5FgBgSncBKL6tzEmEbpCciXvzPRwKWcPn?=
 =?us-ascii?Q?6t+iKaWWyp+b1aNQhOn4ZQ564qKo0gt/i7GN5I6ncw+q6MDsqYhFwm3I7s2J?=
 =?us-ascii?Q?C/eTVi0TGwSHUcm8Y+HvkTKvlI3EHIw2GdZ634rTjTV1DRhnThHZw3KpnufI?=
 =?us-ascii?Q?tqCgn7KJNwaX8v2Wnu0DJ2JtFQhYKt+/4BpiuJtz0eCcEpwep9iT1VJNF4b0?=
 =?us-ascii?Q?g1GubQaMAeIVxCLIS2Hl85ZbZV9tlmM853tXilQb7oakt/g4lnGoF8Mco3bI?=
 =?us-ascii?Q?/ni0vr4M2It93bE+7VgBAhJO2CowRDcZfHhtG4jnCOrjRMTdVtCw8C2lhOC1?=
 =?us-ascii?Q?aDZ2LxTVQbHB2GGGawrcWHNjnZrQOHpwk/xImRA9ag5bzdMGbSlRjQlBiceW?=
 =?us-ascii?Q?+wwOZ7Y2+ulyHzGNOGrcHBsLMolA29jVWfnb5x2neWk8xz5rwj4HruckTCDV?=
 =?us-ascii?Q?lEr5ENkaDKhDeWydMy5IEMWBBv2knUn4X0+oeNpa2WOzWnrpfSMRsHWzmMfG?=
 =?us-ascii?Q?+biKXFsPXyP1sJ5bZKDN9wb3RedGdk7ElLKJ15AYf3KBEaYBgaTKtEOOC2fY?=
 =?us-ascii?Q?Mn4mSlzZWRpw14hyg53vsgmfbxPhfgud13EAt0MWymiPRYvn8enE+hKSf7Kp?=
 =?us-ascii?Q?q0wpG7nIlumavgPqZOOw30ngtWtEyl6FUe98xFyFB1rLr4MTrPn/b1Yrf1ub?=
 =?us-ascii?Q?Kdk4/2HNChpJ++pM+YUA7SIztbA7KWj0FiPNLim8/GwccgkS9C0X5p0IuX4V?=
 =?us-ascii?Q?YNuN0n8ofGG2KVgI9E85rEDA0rVPpCaheGOSBABrvrLDI/eUyPHNETDNrYEz?=
 =?us-ascii?Q?uQRqrp/dXZyfWFAsM9pS2uf99O8vZRC0IgoKsvgS8EHtjWEJLd70ZpTwsWbs?=
 =?us-ascii?Q?5BoxEf1Txte7s0ospkb/NDGWbzidk7kC2lMl8eFgbExn52wHfDcgzmHvTqia?=
 =?us-ascii?Q?9PQIy43aVkkKJ7ct013S6PB36YHt10SlJcWhwoxvNp5BLb20sgcDOs0IceHG?=
 =?us-ascii?Q?V9ZA1zEP1aU5WthtLzzSfCjlzfzo46sbsK3O3Q8NXz7eWu4SJobg2mV9jWEU?=
 =?us-ascii?Q?IAXoPrGP32IRlYUra+E4N4gZNBUHX+DxnwHE43Rj6SNkCvvkmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:28:30.4493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04b77d7-4cdf-4d2e-8997-08dcfdd007d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

From: Jianbo Liu <jianbol@nvidia.com>

Add NETIF_F_GSO_ESP bit to bond's gso_partial_features if all slaves
support it, such that ESP segmentation is handled by hardware if possible.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

V2:
Addressed feedback about unnecessary ifdefs.

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5812e8eaccf1..9e8bdd0d0922 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1545,6 +1545,7 @@ static void bond_compute_features(struct bonding *bond)
 {
 	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
 					IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = NETIF_F_GSO_ESP;
 	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
 	netdev_features_t enc_features  = BOND_ENC_FEATURES;
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -1577,6 +1578,9 @@ static void bond_compute_features(struct bonding *bond)
 							  BOND_XFRM_FEATURES);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
+		if (slave->dev->hw_enc_features & NETIF_F_GSO_PARTIAL)
+			gso_partial_features &= slave->dev->gso_partial_features;
+
 		mpls_features = netdev_increment_features(mpls_features,
 							  slave->dev->mpls_features,
 							  BOND_MPLS_FEATURES);
@@ -1590,6 +1594,11 @@ static void bond_compute_features(struct bonding *bond)
 	}
 	bond_dev->hard_header_len = max_hard_header_len;
 
+	if (gso_partial_features & NETIF_F_GSO_ESP)
+		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
+	else
+		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
+
 done:
 	bond_dev->vlan_features = vlan_features;
 	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
-- 
2.44.0


