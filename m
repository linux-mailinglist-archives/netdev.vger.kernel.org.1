Return-Path: <netdev+bounces-161036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D1FA1CE26
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 20:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5429188664A
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396313E47B;
	Sun, 26 Jan 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hjhxy1UQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E7F189F3F
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737919148; cv=fail; b=CfuxjEge5uHAQVka6uAHdTkpapsVVIaNI3jCyIIObvjnL+TajAG4/EiDJa2+PsKq78EflhgzTSASJn/ZcHx11PVQG6qJDiPLP+mb+kNmwepwCJSJsZyHKuHq0sb3e7gvLjE+TwVe/Tf2z7H9Fq+0iZgbC4B1N+5dMz1/dud+dkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737919148; c=relaxed/simple;
	bh=QvtyJY8V0rGWHRIPjkbOIvH6F/LDtG0UdDbOUr9mmRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dopvIED0/EZ2fy3F73a+B/LO0FDWgRteWz7A5dqJR5C5H0lw9PCjoJ5VXsJhbDcYZyyBBtxlw568JWb5CxjpFAZ7+RFruJ3vJXu9s9s7HLeyLVpUSJSgdtZ2R51UpD9/frMrdVdt/B6nyziaNoa3zG8UNOH9x+eZOcKEh+921Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hjhxy1UQ; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgUHK4zXbObDp6HjcFUb8LxCLS9cDBND4oExFHOGeTvM6R7xdCXBYfs3dNTui4uXK69Pb9hNwZmNCLwIUOJ1jRVSUW2KHNWgG3K/zIKm99a4P7WDVeiRESaaEixseNgWy2cdl/fjicqBTpZMGuA1ZC+vCqDtU1dqPzno2fadCNbiIA8fIs3m4B036b200CimqA5XEQjleYt6yWPNR5gIMf0VBiTtdiKvhKHTS9U+2xJZIQrI78Eqi3Z4anwtTfEbXB8HCJjHl55nXs0jgLlZRmKyqVIXIpTLBGsX/qkNbMh3KVQYWNDhAhZD6CEPzYBhMmP2/vLLnev+JTSIfk8ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZySGQ/DIXPJ+5q/LN4mnlCFEw18fjSmz706diGOSBD4=;
 b=l+pYzdvmAqtfIFoVoES9rLRThJubhyRqGUzRgjd6vBA72E9vmyUieWz7rhTmoUemYI7ZfcMeL/oTdxMGWzQGZDI1ggc/C1/2l4XxAqek/P/+LeU+H57uJFTYUvMAzxMU7qAlbq5LA+a3EtNoWr2YN2tYeeZUtrppvds28eYZlXIffwr8RkNXcsgJPMZ74nL/UkGRyKGfvuL+nxwmw0oMruXCPQRH0H8izR1snxsHGph74UzylRRCYr9GvqkS/Un/X9Ntnigx5h1k2zsUKZ3n2qjZFunxu3rfD0ZbcaHcJNlIuGLIUZB5j15tHYZ6NDzojPr38jQ2UGFLu02kJRGt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZySGQ/DIXPJ+5q/LN4mnlCFEw18fjSmz706diGOSBD4=;
 b=hjhxy1UQRXkaRYo2RRAD7mVKkaZPsY7Ym3S8/M1Q5iWzImCdaaxVg2J9qXvILRYYc2k3z2c1LV4/s0FY49Fp6tXzvVRKpXWp3UO+v42N47kMY8tL+bU23BmXa1d1iBittrxddch4QYAtzBoZY4WRh6HBZofeb7Z0o+TwmEt5eRTs+lh+QVpSW16qsmM15jsGhZlcv8nyCS4LCm/hqpTteVOZeisnacghxnpdmwyFHrcK68104qmxHWdtDPBCNjT0WzAmdGzd06yqrQKwEFrFS/yB8VWGZXtXSzmDsAbyfgoLytXIRailYwz7lKX3UfxmJKMqsDfhymfs3xqBDQty6g==
Received: from DS7PR03CA0228.namprd03.prod.outlook.com (2603:10b6:5:3ba::23)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Sun, 26 Jan
 2025 19:19:01 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:3ba:cafe::76) by DS7PR03CA0228.outlook.office365.com
 (2603:10b6:5:3ba::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 19:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 19:19:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 11:19:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 26 Jan 2025 11:19:00 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 26 Jan 2025 11:18:58 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Simon Horman <horms@kernel.org>, Edward Cree <ecree.xilinx@gmail.com>,
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net] ethtool: Fix set RXNFC command with symmetric RSS hash
Date: Sun, 26 Jan 2025 21:18:45 +0200
Message-ID: <20250126191845.316589-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: cef22189-d081-4e66-3e76-08dd3e3e4a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cgaqY6POhrZfVCKUMD2qkUfD/H2U0x+FJ3WQM9y6ZyPGLqA6NQg2DnUHExRy?=
 =?us-ascii?Q?ErY1CM1x/GVZo9GcixG5BE91tXRh8Cj5kU7Krn/1RVi1BfRa9qCDpOfB5Xl5?=
 =?us-ascii?Q?9WonjTtZxOv21U/s8CVkYq8O7djsjd94YoYghnUbHGDtAOBfKvqHE0kZh3iY?=
 =?us-ascii?Q?R2aGj6J1gzovArufNIqhleNCj40x9RghwZ9fo6miSsuEBAOwWS9QZo2WCIZ0?=
 =?us-ascii?Q?Q/t4wHcOtObdz13ok7DKpMXmA9nCBnTUMajWhUFIP1uFXzAsN4ga5YeUcx23?=
 =?us-ascii?Q?0lpKeVi0rpokckuIH2Y6OMh2Iq/H3QRQp145wJj8O3vrLnWpsqJaWaDNgavw?=
 =?us-ascii?Q?m7nYaUxX0Aod+ld+fIG2Q78uC2yu+idPkuffbJgSvi0/B7dh20L8ZxnYczhI?=
 =?us-ascii?Q?hYKs80tRngjZamm7f1S5Ib9zg8HFUsN+jHkTqOVe+Pk8/jq8HKM1nOAORy/v?=
 =?us-ascii?Q?dvvJZwTVdke7lD1wdY3GmDD3E69ZbyxRlDd5XUikH6EkebQIZN6MylaIR0SM?=
 =?us-ascii?Q?zDFh6TvR05NfOE/ciRnBL6cZhuW2ZY2YtgwS8/5AjehwYKz+MYndjivCg/Ef?=
 =?us-ascii?Q?tq5VdpAoOlCnwKbByD+uw7kAPtg87umm94IVAxgKPXLpxl/E2XeInXEPbbdZ?=
 =?us-ascii?Q?arR72flkch1hAtRVokR+PRWRLbHzelY1zjfAWFyRcPi3Bt5QHkJdU3vbnj5G?=
 =?us-ascii?Q?GdkihkhuvLlET5doOeMHAFY6RCbTDh96osuXN3jRUVb/p7Zc9NPwgjPEXE1Q?=
 =?us-ascii?Q?NhNxHfDDoux+hjgMNYRWucefmuGXnziuMTKox3cFilAv3jKgR0ES3xqQOFnS?=
 =?us-ascii?Q?XrI2WmpCDCio0lDYF9TuJdTsn+85zuSzUe0QIhAoSIEw6ynrnEg7GcJZ52cd?=
 =?us-ascii?Q?1urvtYyTwTbiGHrTn7JaW18O623r6drCG3zUfy7Bl62cgBLHkgf/UVYFG/gE?=
 =?us-ascii?Q?Kc+ejBOnnQJ+Fn99hxkntQ08BiKFlS19US6NaSPHRtf1Cp5yS4myq3+r0GUC?=
 =?us-ascii?Q?AvyM2R73keQYbyFYLpaGLS6uXpPshc5LN9I7+ZoumOap6PT1MW5OzFmUBgd8?=
 =?us-ascii?Q?mRkDN5uP5mDUd3t5n4wkSbdc9z4CSgVSeLgse0qiS+H1WSh+w9EhyHtaDI5d?=
 =?us-ascii?Q?Y6l/3A50v5OvmwT68UDDPRlWXSDYRJh5v1xhFGXpYGtkYsyXE7/9smvccOtu?=
 =?us-ascii?Q?hPX1VrLJ8rhwkPQCyJe2UIjoujOJJhCdnQCjhO/iIKPQVIbj4S3dho8W4mes?=
 =?us-ascii?Q?Hw4DHfBecsEFpKZt63lg6kEuGXmXaK7zFLzvF3e5aZBTVdCgfCsRpx7s6IHM?=
 =?us-ascii?Q?MU2jKYCBcSXdgdziGkuavnLCTmg6PunsGUIt6QKWO1zWmzBxd+4Sx2mQs6TG?=
 =?us-ascii?Q?YGUxjTnBzteatQ+HiK1YjfODyNtsBoYpO2Jjpu4I7dxlrkJfkPQcFx2MjU5H?=
 =?us-ascii?Q?vuYyPmEOlMSiM4Fwl5gBg0gfLkeFDPyuwjIRGelxLzdopo7CDDRVtbcjs6np?=
 =?us-ascii?Q?NpHln+sNVs5pz8M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 19:19:01.4278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef22189-d081-4e66-3e76-08dd3e3e4a86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470

The sanity check that both source and destination are set when symmetric
RSS hash is requested is only relevant for ETHTOOL_SRXFH (rx-flow-hash),
it should not be performed on any other commands (e.g.
ETHTOOL_SRXCLSRLINS/ETHTOOL_SRXCLSRLDEL).

This resolves accessing uninitialized 'info.data' field, and fixes false
errors in rule insertion:
  # ethtool --config-ntuple eth2 flow-type ip4 dst-ip 255.255.255.255 action -1 loc 0
  rmgr: Cannot insert RX class rule: Invalid argument
  Cannot insert classification rule

Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
Cc: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ethtool/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7bb94875a7ec..34bee42e1247 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -998,7 +998,7 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
 		return -EINVAL;
 
-	if (ops->get_rxfh) {
+	if (cmd == ETHTOOL_SRXFH && ops->get_rxfh) {
 		struct ethtool_rxfh_param rxfh = {};
 
 		rc = ops->get_rxfh(dev, &rxfh);
-- 
2.40.1


