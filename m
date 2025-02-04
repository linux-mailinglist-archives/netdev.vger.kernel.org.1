Return-Path: <netdev+bounces-162600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B34A274F1
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152F81885AEE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03125213E69;
	Tue,  4 Feb 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G7s/vBBb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410AD2144BB
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681006; cv=fail; b=MlQCAZh/HvLjJ9N9bUSVOaQ5FCWVp5GZRYijvw9IcqH6dZC7OGqGYSFJJtGykAm7+0FuDZmJYpk9zxPP3You7P+28WzFBCM6+Ch9m6zB2cGbTEBbGxTA+TtAv7GXsKN0+uF8ZczHaNz48SOjTovU/YQG+xnrTslT8KcmCq6nV1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681006; c=relaxed/simple;
	bh=dkt2bXabjOoIHyFC4I6Mq4OaUM0+ug7Qg9G4bNn9GnU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7x7rChMherEZV493Bbfyl4fBRl89VbgQtjjWRbLHN/gDptdEcWCndGWnWPgq0+AZM8gQ+FHJ5CYPaB8fSqLOSj/k3UFCAY6ZeO0S3Ijr1Unez7uYsNZW1qlLhvF5X2WkhbUQYllx2yma/HuCkxF8bqXoF4yzsws/OETaYHWGVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G7s/vBBb; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4l7cv1MjCntDykWw9wxrv9KTmOueXqqf21WYJS00CvpMGSRBcjQlN4uFymw5Fbe9MKgYHzzOBnMQP0WLoo0i8XsmQlTu2pXpE0SFPrwI05dB3BuFjovNkr0olm2hnPnYkod3UJY5PIy8MOzS0wkWFhWT5M73w33qucF8XJGjFyK48KJdG6TW7AZp4+DZ9bmw2ckmYkF6Kjr2VQK18wq6g/G2KtvQnizqrxKM9jalXE5iFnZj308tAg/aY9WzxO1FNqAcRCZKd98t5VhPK4E3xUh+Zl++7qleGZscopVeXLNzbbPOdr5AauXbrkztbHbUyINwUro9NzRijfg828VhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Dwa9Qw3vH0otCII6yUsmC10rcHjbN2LanIn5pP3CZ8=;
 b=K6DWbYaWdT+FXLd05nYnp0JpcZkN1gdf0zK1bFX1hGWc5lcIot3f37W7BIKwqOjE7V2teQs9u/h65YFyYZ0Rh0EWuYCmvpBtKvdUx/KpiUs/USQTbwDMnUqA+dnlkmIpTAj5iboJxhCK8GXgBKkvoWtuQfi9Q99TcqPharAjP9H13dhHG0+4JA9rCsGtVJpVKbFYxUPRAkErDp+C99/wf61VwCgIArDUwS0DZivNZctxJyOYtzfj43YqqcGRzQ7ZeeSDONW/UBsRBN776jI3sHbNFZfX8SABjZESgvwbyFbJxF04VPcjwSG9+gKJUTGGUIicppno9sXwtqXsEJUOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dwa9Qw3vH0otCII6yUsmC10rcHjbN2LanIn5pP3CZ8=;
 b=G7s/vBBb0XZ7TLtLcjzUnIKuf2Ia6yqnCzz2ca+VrmWFi/CCNEXq6fOQF9owz3Yti2ADRaV/z9IcTI8DPYrCK9qqdO+JkgfIDgH4hTwuUqohd509fqbqCLSgsan2NwDfXuwo9kUmfVXJEBZFpM7il+LgTSvn4udWDxg917vSVGLOKx+hERFTbJsYVNYlaZb/mGC8xmdbwUdXrH9JydJpnSPYEgUUSjIXYeKevWjQ5m0VDrhL7tkyLYdWnejAsR8fBiMl4jSYvXnbez1XMi4CTiv8RNwR/mojffNQ9g3jQYPeyccHSNMbnE9KCVCiPg++jDJFeRBtTRGK9aAc92rI2A==
Received: from BN9PR03CA0323.namprd03.prod.outlook.com (2603:10b6:408:112::28)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 14:56:39 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::3b) by BN9PR03CA0323.outlook.office365.com
 (2603:10b6:408:112::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 14:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Tue, 4 Feb 2025 14:56:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 06:56:23 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 06:56:19 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/8] vxlan: Always refresh FDB 'updated' time when learning is enabled
Date: Tue, 4 Feb 2025 16:55:44 +0200
Message-ID: <20250204145549.1216254-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204145549.1216254-1-idosch@nvidia.com>
References: <20250204145549.1216254-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c29778-c085-49fc-75b1-08dd452c2172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GzpHfUl5xDp26mwpqOgutzdLw/Fhn58f3jItdBQGpF4wY4/1nRZahX0RCbbt?=
 =?us-ascii?Q?yDLhXjafL0kcRonkNuUcxSyGQHVvXg5wvAAaIQRZDwayhok7JPvIJhHYCHeZ?=
 =?us-ascii?Q?V9LmjxYhWzhbGRZrCSuhNYiPSLlGtgx2b7ZnApIcaxEWdaGlvpoZ2hMI4VE7?=
 =?us-ascii?Q?Ov93KxER3Ak4KxClnXhtkNG1GPhRp+kMF1ozDTpNBZQGuSWxEr76lzNjVvGb?=
 =?us-ascii?Q?cAQeOA/1OyJUdnooAkxlx+UKZdtdjCx6dLRLtoRgwoDoS1fg5Mv9lCBb8GnQ?=
 =?us-ascii?Q?tnWWf36ZASxN+8PhhcCvn5JQPtM2Mcfpx6qx1aR1HdlDiWqaKmTlYzi+0nz/?=
 =?us-ascii?Q?Gt6rcurwJykJeuBNeoQhrogY3mIPq40c0LCxcV838rOnvPRqoFBtR2U3Epad?=
 =?us-ascii?Q?6mrUpH8pWy49ldm50X708TYFp9rKgEnN5wwFbSz4EGp8lXk+UskKvfLU9rOb?=
 =?us-ascii?Q?c3+T1JtdaW9O3GGkhnmnF1tsJdk+s93lobJVY5ekDi9DdZNB9Fvlmo9VuHWH?=
 =?us-ascii?Q?iqVDgyCiMHwthpKrBnL4D8hQSkUvmqgnT9GHZItYZzO+vnzvQB0qnp6iJVLV?=
 =?us-ascii?Q?CQ/C40o0Lg7UjWFrZcbj16bdYL/eg/HTdQ6WyxnsnJCC/CxLDZblXy2KcCRo?=
 =?us-ascii?Q?vbrkYNGHYcqZeVg/LjMnnChq4NOCrU67unuRsSwhZ6spsrGbYTjUyV7mohtv?=
 =?us-ascii?Q?tmfnK6STIOKj39th+H7UHqqTQyzRy4Q645jL4lUXX6yiFWxyPvdU9yxYJrPL?=
 =?us-ascii?Q?xmdHMjncio4WyifSvgsljfAfBOMx7UdrMHW0EhGm+47GZLPgVfvSq8gY3WZB?=
 =?us-ascii?Q?IIZMSkJhrxZyJWkvgcluUDF7mqCR3GN0N2FVeIj7k/zYoo+MtqoTTOgQJwdD?=
 =?us-ascii?Q?UQqhFEpyaE1o83AqRqydWddus6D/jIz4ydtsrowgxb/VFVJ1PYURU6psMNwP?=
 =?us-ascii?Q?Uth9yrrntPuT2eTR2RXqj3XK51vjsa9FbZHzYa/2VBtvHfxZMM4tAclzDA/K?=
 =?us-ascii?Q?rKl1u4p4XLZPtl4PR/Ty+rO6rae4KpEmZIzY1AYByix/nPead+au9XF8ZSj1?=
 =?us-ascii?Q?VgidVoOLjjgvh73w6OsSEczveN5YSC/g1RiT0yhXPj2VCLGDuq6iBzylAbG5?=
 =?us-ascii?Q?LEXdGr4etCqQ/lhly2lOSBhIMZM/OmbKKQRYzfawL0+FlQpbcEWrZNOuXNLd?=
 =?us-ascii?Q?5L9lZdxi9SA5Htw9dfQNQjwN5YVfwB+d8Tn4e9joY6rOzhNMc4dJF3yae844?=
 =?us-ascii?Q?BU3ALlQWaZviaLaRB6h4sDlrnMjcBE0zuplzwyh/D1e4bHQjINxb/gsLwzQg?=
 =?us-ascii?Q?BYSLP93Xdwgg1evUqleniwOrZZJCNJUFja0bWztYQiS6G44C+AvquHs70Eb5?=
 =?us-ascii?Q?KkPinVm/jgG4rqi5cjx3jtxdJ3R7ntvp+90ChCgiMnfD+vlaD/Y+LPPMfo3w?=
 =?us-ascii?Q?SrTPoECOdxGMAKB1mZvr2kxY7z4pob6rT+HixsbzbfDfoYYz1HdddoW/m1vh?=
 =?us-ascii?Q?+aBaeh9ItGao6yY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:56:39.6474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c29778-c085-49fc-75b1-08dd452c2172
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240

Currently, when learning is enabled and a packet is received from the
expected remote, the 'updated' field of the FDB entry is not refreshed.
This will become a problem when we switch the VXLAN driver to age out
entries based on the 'updated' field.

Solve this by always refreshing an FDB entry when we receive a packet
with a matching source MAC address, regardless if it was received via
the expected remote or not as it indicates the host is alive. This is
consistent with the bridge driver's FDB.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 676a93ce3a19..36cb06a56aca 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1466,6 +1466,10 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 	f = vxlan_find_mac(vxlan, src_mac, vni);
 	if (likely(f)) {
 		struct vxlan_rdst *rdst = first_remote_rcu(f);
+		unsigned long now = jiffies;
+
+		if (READ_ONCE(f->updated) != now)
+			WRITE_ONCE(f->updated, now);
 
 		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
 			   rdst->remote_ifindex == ifindex))
@@ -1485,7 +1489,6 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
 		rdst->remote_ip = *src_ip;
-		WRITE_ONCE(f->updated, jiffies);
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
 		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
-- 
2.48.1


