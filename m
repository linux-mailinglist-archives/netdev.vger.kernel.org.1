Return-Path: <netdev+bounces-105126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7A890FC4F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D27C1C23025
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBB33BBC9;
	Thu, 20 Jun 2024 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k4BfiLiW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973138DC8
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862507; cv=fail; b=QiDG5uxnTw/f1ZLoYSyQijpd4fQ86x/ET4gyrQucZmaMFVr6tZmfUyvFZw0Kz0lOk+M5BA9dTUwVoyKCmZ8rcTedGaAyziyNIw0CWhkJIOAE36Mr9EYVub3qFrbx4Mtl+o0zCx+0jXlV9oqE3Gy6yKAs/l5fKONkcNErj367B+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862507; c=relaxed/simple;
	bh=S58Z2DTtHqc/MWVZC/Flg4+hJICVreKJDq8ffgdVjHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxMdM7cmInWSg+p0sDvFyfHKCywUk9D9ck84b5B0zwMvjkSeMv+z5FLSl3PAX1uCk/de8Mfz8Fr5K5fZjx2LohiDQ0nQoh0tqcCo58ZjMbhzFEe0EowhCFSRPuL4cy/IrMCMTL5/lG7yYPSVas8dd0kVJBXAZnUCcOqLsl5Wfo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k4BfiLiW; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzP4t3SZlvzxqLvMsug4KMl9+DlShFV/IPLFTEDPNCk59qeK8ugSFabPuMuOy5qgpB4NHhJVWoEI/dmrbpsy9i7edCgwakHCy6D6ufhf4S9W67M8JIiaK6GFYCkNsDded7CvtXfsANeVf8VzUSMesOjKZghJqrdjdphSGlkgDfeJlL6an3yp705nqrgLFOxarhlKvULzprh+tC3qISudBSh5jNaI8djUXQ9rayOIgKhGxMhsu5baPNG8do8thgXEGWhULYGEYYSVCYRX8aJZoWVsvDAWDYY7goPZRFgq+P7ZbqY+qoJrzrXrngOsaOB/o4sKfoVR64pBh2skKezKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqnrldJ2BlsKBOUSZzoSu/NhWcRyR9zFWqDLZ6YraNs=;
 b=ncuOvBxLrokUImK4uKsorKpOMg3bMocjbjJAStJxSVhoUohvi0i2XsVHdNkCCbhx/I1OZXUc8m9l/2tl2E2fRFAEB+CYTlhaSQ5PpxwmdSL5GlI/5j7Iul8Fpi7w8gUbwyq1o7waWC394JI+lqom04TUSfblSehlWbJXSfDApJ8IRCSHiQXvBjdDduWzsm+3Zj7NXDATJOMsuRg2n6eHyE5Q95EkAaALQnBUf6TwGcgBwFCz0hV4Q6M4uLUZWCD6l6qgrBEJl+Vj8wSZDkoQimdhYtqkvW7mGltjjFtEtpzijZYnEIQA18PfA4e9Ane/2OXo8ZilYZn8KP+TKWROkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqnrldJ2BlsKBOUSZzoSu/NhWcRyR9zFWqDLZ6YraNs=;
 b=k4BfiLiWJjVX0WLezJBEVzHO2fvMS+dYM9YYYE+lhz4vVuwmYNZ6MpL76eZVPdMDVc92ad07goUb67GRrpxmYlX9IgAFBbSqxTBq+M/ueUjsdPI0C0kGICa4F8CwdC1l5W5eZOljwux3/VWSmZnh26lL8P9D9/TFIi4PB88oX2I=
Received: from SJ0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:a03:333::24)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 05:48:21 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::6d) by SJ0PR03CA0109.outlook.office365.com
 (2603:10b6:a03:333::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 05:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 05:48:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:48:20 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 00:48:17 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v6 net-next 8/9] net: ethtool: use the tracking array for get_rxfh on custom RSS contexts
Date: Thu, 20 Jun 2024 06:47:11 +0100
Message-ID: <2f024e0b6d32880ff443c4e880af16ec2b5e456a.1718862050.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1718862049.git.ecree.xilinx@gmail.com>
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5aa72a-a41d-422f-d71d-08dc90ec97d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o0uJAhR2U0bZDQDIpTJXTYSBYhbR4td9hzUEZww/5pTnYCg1/60m03VLd6Vr?=
 =?us-ascii?Q?BqzBlvBrdYdWZpCHzDF0E7jFItWUu1df0P54ajSwZ/E3T2fMeJUjM+fQgIRM?=
 =?us-ascii?Q?2L4fNIsNETkvyNpqPCM/hA8TJESOwSL71cSEF7Nspz286aoZ2chtU9TqXfGA?=
 =?us-ascii?Q?2ZyONfB5QFaqNJ2SHMRLCMTD4Votmqk2GTLdt16ikZeRuqxdM+6W1orHAazL?=
 =?us-ascii?Q?FUvCYuwsSHNv2iFRT15thm9oI2lwC3q/xiqlhP9ojQz1qk/Ep8ipg/6hnEW3?=
 =?us-ascii?Q?fIUCDN/p1ZUwNhp+ZfrtQDNHo+vl8A7whoUDYl5FZZb+jJG2IF/iSMfSEuEk?=
 =?us-ascii?Q?LvDXSHmQ0DZDs1h8yE1WNivziL62SO6g6g/6KT6LkmHmTcULiyazaY4rC5/K?=
 =?us-ascii?Q?I3S72SRkXh953yVy3rqo/V17aEjg8+HMS8oIaNfrL8BpJyC0HEvd0PXXaIPZ?=
 =?us-ascii?Q?o+QSSc/d5e6cnhogwttyt36pwPsUn0o3arrgZOJT7O6Fqfz9t1j5DJBnB3vP?=
 =?us-ascii?Q?099TqPoCRJ5kVxofUqXsSqzPTsiomA/54uMJKAZb4HMGyV8qP3df0HYw3VY6?=
 =?us-ascii?Q?Q7NCFNiOEn5MTiKVAdZdLFPJEX1cQSYheR50Hue9Yv/jt1Y4AYFn3HSF/hYt?=
 =?us-ascii?Q?xJTWKhtENbe8F0sjVOuUqzcGcxnXQTvKlf6AHkQZGEVGBX/cFudTOixH68mS?=
 =?us-ascii?Q?kNcqFFmPm4bsQ5tOwlxfRJlSzCPVUpnMqyVxdOARrSfZd9wGHUO6QPAo6/is?=
 =?us-ascii?Q?BKJhqo2AUD0ueKsyleolsG/x+WR/4bRh68Txlr+ey4jhB6+hUcqwnKPbu8Uv?=
 =?us-ascii?Q?QUxRk84wg6y6qAqn70cCcuArIxwJN5CgTTxyuP4GtQwIpMJAuSTR0C9sfVyG?=
 =?us-ascii?Q?4yf8EGVh+5+wMrsF/cN5ywrNM3X14pHJjHGJURGoLqPpP25jtJX7WdAmQ0MZ?=
 =?us-ascii?Q?+dTHo5AzQ6QLMZKy9Dtw0zH9RMZ0+lT5xzCpk+8oLYfg6z+MviOBVguYW8qg?=
 =?us-ascii?Q?XwZoSa0+tPZ+Gm5o71GpfCzM/oFOsaeYWcRp2VfFDjSfceJA3SIPp2onC/ib?=
 =?us-ascii?Q?d/tsXffIvRDedNTfflPdna+r5Wk5zV1/3ervoCp0LHEKaSi8em+UMXFO63g+?=
 =?us-ascii?Q?LSm2DICYuaWExAZ4AjQ+fpgq5i7H7pKPNHcP9akHyK6+Iz817bfbB6qmO28I?=
 =?us-ascii?Q?lRcnVGvp+e5yT2kLLmgMI4TNHxiMu3jl7LUkodBFBU+xKIAbRbCCotHGYhsj?=
 =?us-ascii?Q?zPbISwvT8P3y9/mbCBPZDEVWt10YQg0KvbAxoDrN0m+sCqtcd3XEeHwvCl+r?=
 =?us-ascii?Q?RJ4x0ZxHcB6/34WDVsIoqlECmwYT55eEnMGt1xziQWrb16V8fOoaYl9FJjAF?=
 =?us-ascii?Q?67sKmIgPE4/XejHuM95Zrv8RzJoAmJnzMAzhbpbzfD81OGDcIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:48:21.2154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5aa72a-a41d-422f-d71d-08dc90ec97d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064

From: Edward Cree <ecree.xilinx@gmail.com>

On 'ethtool -x' with rss_context != 0, instead of calling the driver to
 read the RSS settings for the context, just get the settings from the
 rss_ctx xarray, and return them to the user with no driver involvement.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 net/ethtool/ioctl.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 9d2d677770db..ac562ee3662e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1199,6 +1199,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	u32 user_indir_size, user_key_size;
+	struct ethtool_rxfh_context *ctx;
 	struct ethtool_rxfh rxfh;
 	u32 indir_bytes;
 	u8 *rss_config;
@@ -1246,11 +1247,25 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	if (user_key_size)
 		rxfh_dev.key = rss_config + indir_bytes;
 
-	rxfh_dev.rss_context = rxfh.rss_context;
-
-	ret = dev->ethtool_ops->get_rxfh(dev, &rxfh_dev);
-	if (ret)
-		goto out;
+	if (rxfh.rss_context) {
+		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
+		if (!ctx) {
+			ret = -ENOENT;
+			goto out;
+		}
+		if (rxfh_dev.indir)
+			memcpy(rxfh_dev.indir, ethtool_rxfh_context_indir(ctx),
+			       indir_bytes);
+		if (rxfh_dev.key)
+			memcpy(rxfh_dev.key, ethtool_rxfh_context_key(ctx),
+			       user_key_size);
+		rxfh_dev.hfunc = ctx->hfunc;
+		rxfh_dev.input_xfrm = ctx->input_xfrm;
+	} else {
+		ret = dev->ethtool_ops->get_rxfh(dev, &rxfh_dev);
+		if (ret)
+			goto out;
+	}
 
 	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, hfunc),
 			 &rxfh_dev.hfunc, sizeof(rxfh.hfunc))) {

