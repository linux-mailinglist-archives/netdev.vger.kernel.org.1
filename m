Return-Path: <netdev+bounces-105118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B5990FC47
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE1F1C212BB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F592B9DB;
	Thu, 20 Jun 2024 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lvSECIxS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959F386
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862488; cv=fail; b=QFtYltgTGRuc6w1hBjYF0e5bne3KaqA7VTVPOu2ucRa5w34IkRRlPLnrNtJFYsjVa4+L1BBvsqYSMbqZ76a/o81+c0rtf2IJGkHjnLnTRkHiyKXuiJd/PDlG3b+pErQtJaAcS6y8611kE2oGAXmFV0JgU2vvVON5bC6BCvNQI3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862488; c=relaxed/simple;
	bh=jFfWjask3ge5wsOD6GwokPx/byp01kjTfBCVXZj8oCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CoWHSsDvcP6QNCp/OMQlrp9mPGtM/iMZrA1OiOIgTL9L50zTAnL3iF3bMVMA0UTp7jSmIDbYMu+cCJgKqD2fPcdcNVmGJpCT44ylfLVyWsjaPq9zD7Uf3lrkK2w1Q1Hykmx8uCGbnisKgv3PqgnYIqOeA0R7e+DexyvFuRET3QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lvSECIxS; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNUkuqhabNhQQCiOZA4uitySHhPjRFS2LS+Cex20NGIEcuUQQo0eV02sGK2Aoql4WtvmPVeirNrt6IbvviwjILpTuo0gdV4ndPb05z6akQxApTQINqKMzBZqFaSrurOOb5swe8TnGv+2irK2zD3h2na6p+caqXEfFHsgiDZ/QDrqJC9BHNAYd+B/Tdha1qy5CGGg0Sr13BOLonLGNbrNDwz0EVHWEqmlJf9/EkODMpnp+wEWORUGqU5oqh/xrlEGZjAe88GYl1pljWJvcj/vJ2TH5Z4908hTMiLX3OdmtcgWR/5yev7WaUG97D1aARttJY0ELDeIF++nIcBmn+Lhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2PIwZukEzkZfdgU4xpgpz5azQzMuVtuGb3z+aynSTE=;
 b=XDYVwGdgWsS3qn3RINV235rN9vehERq0m0R9nAbstr9eyuIES2UB94CGuyWJSRe5i/wu8fjSScxaAy4+kLM/4PQVMEDYJc5anFG66B9yXSqWsKNOU4UALcUEzURXUt0T2oydkNetXtjBE+6Gk7aviJ5i09KNn5PR/qwqVf3+WtgzAfFc0yfXDlWVbIMzc9taNicIhNgQJcxcl3AUVXaPHVbFa4QmVR0MsN/3qrlJfVRkpA8DU0u6svL4s1nEUkgnx7DcDnEPZxyw0GgsRvQBBg6fe//qZ9I0bCoB/jE4cbrihwoLpkooxX35UEEzfvCelHNFwP/1s54eg4M1RskQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2PIwZukEzkZfdgU4xpgpz5azQzMuVtuGb3z+aynSTE=;
 b=lvSECIxSAxbhmubA7OMUQA9ztlyuyBPbAIZVFsZMA+JH0DVnL73KN3eEucVmKhld+NNcHLJJGo7wmGp9AnM4wOcACp5TQctJmG0oOJFo00IkVzio8xSrMfMtENSzILHxjLX2cCOZLDDGyFPGoheoM3Z1W5YF9TdLYQi1WfKe/xo=
Received: from SJ0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:a03:333::24)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 05:48:02 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::92) by SJ0PR03CA0109.outlook.office365.com
 (2603:10b6:a03:333::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 05:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 05:48:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:47:59 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 00:47:57 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v6 net-next 0/9] ethtool: track custom RSS contexts in the core
Date: Thu, 20 Jun 2024 06:47:03 +0100
Message-ID: <cover.1718862049.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f1bc89-770d-466f-d280-08dc90ec8b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZYVgmJPO6yYneHENKGmxwqTSSPjRj3zTlG8cdJsE+VS8Wx2lXaedu9dbpbFD?=
 =?us-ascii?Q?qBBodazlDVXWnE5G4rof4or77C1wD18KHkpDGAAISjU9ornLXDxlyhSQLUno?=
 =?us-ascii?Q?Gxx/b/pWvd6H2KhWjPpLbMJR7IiYi3CdsdzYQBuul2XP48J6974TtdlLDjnV?=
 =?us-ascii?Q?0yqtLNz8RdROHNXOaVKSzkZvD4TpmESXEN9AWomJCBu+R/yuBmnePWW1ZXj5?=
 =?us-ascii?Q?fc+mQ2gIMssXjIzhMF+y9neVHyKoWpBpSvbfTUc21DWGpFHDpiaNeKychI0e?=
 =?us-ascii?Q?knj/u0xC6EDewHnGxnFJ3Grh1lYZ4yyQGYBcPtIS9QWtWPGdAO3xp9vEt9IN?=
 =?us-ascii?Q?Y5cvs0GyJJ/uXu5QiOWUEJgaFofrF0TXi7+4UQ07JGHxXWKSf2nkiGB+Atfz?=
 =?us-ascii?Q?AhokDwhnfUATnhPy0X2X3BzYC+E1DQNNgW5ZnS+RI0gaKdQsaLZb7K2Dy9CD?=
 =?us-ascii?Q?hndWW6aARoRM0n2SE4lFaq9b4Yi8SXP+LaiPQ0JwqM+EsM9jrMfkt/4yX318?=
 =?us-ascii?Q?eN9GZ9vPX0xCMokJ9Ihrckc0nU4it/HWo+X1E1lNFmJ/EjrOS3Dlkp80ULzv?=
 =?us-ascii?Q?k47GoLdJiZ5G5pc+1zs04DHnZzVqmUZWd0A1lESVh2fZSf7j4Z4VgcCyCDFa?=
 =?us-ascii?Q?9gnp2gGPFpYJ8j7MfMjA2ZX9P7bfQU6feVWdDOYjVXLl36qq+1DS4CN8S9kO?=
 =?us-ascii?Q?4rFU1hUMQrN8NILwi9f93wnaQJ99zauwlreT5QO8x+YCyJEGziZM2rU39OYh?=
 =?us-ascii?Q?KcGvsi2Yb8jC1XOfVyaFlglIPao2GZAkQ/tpetHueAv/Pjw2fYq1DH6h2/NG?=
 =?us-ascii?Q?2uxGqLWgPS9GX3hLNDZEtABr/3ZpLftJrOieBK5ehKYsJ+TuZVLzrUukfC3q?=
 =?us-ascii?Q?4BVhlmmrKLnM6iZoRCqeLBT5lTex/Jg/R0svwWgrcsioTQe1QgJCzO5OKkIi?=
 =?us-ascii?Q?xajr+q5xq3IdKYXZJY8CYaXWWpzA48vVW+byd0g1K8JEcnfzBTA5ENfE9mbO?=
 =?us-ascii?Q?Ldh4m17lgvIuu1FPAY57tQXdENAANT5WZqZsHrl5P46Z8TbJ7AtjeXReTxHj?=
 =?us-ascii?Q?OKgB80y0kctKFPWzDCvu08JwVGtmJRBYUe33yr1De8IpyBV0OpsyPFDyAtjB?=
 =?us-ascii?Q?UQJMlwU/Nbxd3LqfNnJYAFgvR8XqozoUc99csMVhnCazG0EC2H7JYIPJCZDg?=
 =?us-ascii?Q?hBq8F0qjET10Svc6xEJuLrJx02K4wvuf8yYpFWt+z/+VTRngB90eeh7TGpCK?=
 =?us-ascii?Q?xBx9G5Br1MPM8cGtR1BuQnYIku4TMSa+2jL4T8TxdzgYROh4xYP6p9GhhEOz?=
 =?us-ascii?Q?LGIsNU5kMd2SOuRXzOeGAoxDEISLtF1BTupbYJyzBQ6rGDwgsroddquWub7T?=
 =?us-ascii?Q?3V2cHh9LazVNcVKqulHnkzlhU/XnUvRJ0p/T5wmWrbNOEcnysw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:48:00.3093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f1bc89-770d-466f-d280-08dc90ec8b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415

From: Edward Cree <ecree.xilinx@gmail.com>

Make the core responsible for tracking the set of custom RSS contexts,
 their IDs, indirection tables, hash keys, and hash functions; this
 lets us get rid of duplicative code in drivers, and will allow us to
 support netlink dumps later.

This series only moves the sfc EF10 & EF100 driver over to the new API;
 other drivers (mvpp2, octeontx2, mlx5, sfc/siena) can be converted afterwards
 and the legacy API removed.

Changes in v6:
* fixed kdoc for renamed fields
* always call setter in netdev_rss_contexts_free()
* document that 'create' method should populate ctx for driver-chosen defaults
* on 'ethtool -x', get info from the tracking xarray rather than calling the
  driver's get_rxfh method.  This makes it easier to test that the tracking is
  correct, in the absence of future code like netlink dumps to use it.

Changes in v5:
* Rebased on top of Ahmed Zaki's struct ethtool_rxfh_param API
* Moved rxfh_max_context_id to the ethtool ops struct

Changes in v4:
* replaced IDR with XArray
* grouped initialisations together in patch 6
* dropped RFC tags

Changes in v3:
* Added WangXun ngbe to patch #1, not sure if they've added WoL support since
  v2 or if I just missed it last time around
* Re-ordered struct ethtool_netdev_state to avoid hole (Andrew Lunn)
* Fixed some resource leaks in error handling paths (kuba)
* Added maintainers of other context-using drivers to CC

Edward Cree (9):
  net: move ethtool-related netdev state into its own struct
  net: ethtool: attach an XArray of custom RSS contexts to a netdevice
  net: ethtool: record custom RSS contexts in the XArray
  net: ethtool: let the core choose RSS context IDs
  net: ethtool: add an extack parameter to new rxfh_context APIs
  net: ethtool: add a mutex protecting RSS contexts
  sfc: use new rxfh_context API
  net: ethtool: use the tracking array for get_rxfh on custom RSS
    contexts
  sfc: remove get_rxfh_context dead code

 drivers/net/ethernet/realtek/r8169_main.c     |   4 +-
 drivers/net/ethernet/sfc/ef10.c               |   2 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c      |   4 +
 drivers/net/ethernet/sfc/efx.c                |   2 +-
 drivers/net/ethernet/sfc/efx.h                |   2 +-
 drivers/net/ethernet/sfc/efx_common.c         |  10 +-
 drivers/net/ethernet/sfc/ethtool.c            |   4 +
 drivers/net/ethernet/sfc/ethtool_common.c     | 168 ++++++++----------
 drivers/net/ethernet/sfc/ethtool_common.h     |  12 ++
 drivers/net/ethernet/sfc/mcdi_filters.c       | 135 +++++++-------
 drivers/net/ethernet/sfc/mcdi_filters.h       |   8 +-
 drivers/net/ethernet/sfc/net_driver.h         |  28 +--
 drivers/net/ethernet/sfc/rx_common.c          |  64 ++-----
 drivers/net/ethernet/sfc/rx_common.h          |   8 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   4 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +-
 drivers/net/phy/phy.c                         |   2 +-
 drivers/net/phy/phy_device.c                  |   5 +-
 drivers/net/phy/phylink.c                     |   2 +-
 include/linux/ethtool.h                       | 110 ++++++++++++
 include/linux/netdevice.h                     |   7 +-
 net/core/dev.c                                |  40 +++++
 net/ethtool/ioctl.c                           | 135 +++++++++++++-
 net/ethtool/wol.c                             |   2 +-
 24 files changed, 495 insertions(+), 265 deletions(-)


