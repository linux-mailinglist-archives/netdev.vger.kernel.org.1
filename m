Return-Path: <netdev+bounces-124858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A6096B38D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 617CBB279CF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A73154445;
	Wed,  4 Sep 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SSEkAE4S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836F148314
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436366; cv=fail; b=mnvxreQIGCw+QtuMBHjAThJtMsCDaFL+3MBsNL2vp+c7AwQU/hFb2WUDh0irPKRcQnHH2o+QZSGTjIR+TwwvAutLUDwSsN0oQ5SX0sFt9vVwgt8u+dR8ebq9wQAr1lBRGxg7ZnDL9STFwWxUvHqOBWqi65u5rS4/okbrNgP+vQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436366; c=relaxed/simple;
	bh=dKF8+bMS2Y4KTDncQDJhaq9wrW97n0aQI0UDSw/I8QA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwY1yO8pLYULOzIP4E1eh67IyQpm/u0dC24UxXEohHU7klvFMpNwqrOjwWYXPNxl8/9L+8+YPxE7PwSdi8dMU2J4iaq8OpHpCeYZ/PZBCE+CEkTHSNM3phyU/tt2AsunRz2J4dVHvzPu+mGXe96YJza3gcI9+KibNv9Str72Ydc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SSEkAE4S; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8uVInOQdHIixEnHYd+vNCLYTvm3AvnihQD9njjmZRsoGx6fW7m8M0AiSamov+n7z3Lb3Tqcxn1lYM4RjsWyZGbhVknV9YU3046hnbDGi5DzQ3DFGMrIrIPBXPO00TZlLOzD0Ks67R2gxzIEYUJBv9p0D/Y8Mj5gOTvqGmyv1AZ8Jc2fFy5T9jIWBsY/Mp4U1VjowUlpwPI4spIlCmGSG3r3RPgsXpQKaMh8CRX33GJdQPcsGt12tzaD7SdpVQNHHvFFqp2XFJwbhpx2xW+9uYZbJ8hqUcKCGZQFGNzhcAqB7flj5/w5HMtebTuyEbGPdZE51r9ZoGnphjayCXB2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29piGvi5YicHx0o3p2Mp3L4TK51exkLYjC8m4bkXkhY=;
 b=OLMyRF9W/91boy/Azm5mCzJggV7IM3sfgX+xXLJh6HDX0u7j7EoQ4/S3KWSSP9AVhgZw0dCop5OaHdfOyh68bN+PNuLBycX/lBNNxYraWgWRnoGQtZGZ3HDWO2fd9CwPyVUmmDQGpTXNCajhzvy2SnzUsxBDpletLki2q/Hn51r5KVgnhisDPvZi39a+j9BBFBJSQJclK8L3gmEKrukJT2DAzOnsMCMnCF8L7Bt+TNrEJaoddLf2Rb+y3jnJyZl/FkZULyCPpmO31FtBqcYJ7h03MKyhi174VC7nFdPfUZVKDKPddk0+MJMCNDd/rQFAIYlnLhnWv3irKPaxc8afvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29piGvi5YicHx0o3p2Mp3L4TK51exkLYjC8m4bkXkhY=;
 b=SSEkAE4S5jyX6Y73QyEYcAI7Z2fVghFJ64WsDgpOqPy6wJ1QPzdggevyQMO0B8anYg+brJkBcH+DmkJFKFTo9ocoYxMF9G50VKW+asJWP9uLkLnnH8DwfuAmwfSE57vyeILWhJIgjHNaCkhI/exmJvcNpwwqUf/VSnzN0AZK04XY9oxHlfx7gQfIY2Ptd8aFW2Mlzz1OFBuhCCYNZMF91T8rxxm+tOYGEb8mzZXdm9JCpBWMXy04wvPwy29+BB3cIQHHToVwHC2tkfX/kQCX+UX4U1lU71VFOhFYz04qnFRYyUP9XioP06aIY8PcEV/5pNu3TpylzBXDKNPfWOsURg==
Received: from DM6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:5:1f4::48)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 07:52:41 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::59) by DM6PR02CA0107.outlook.office365.com
 (2603:10b6:5:1f4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Wed, 4 Sep 2024 07:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:52:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 00:52:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 00:52:29 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 00:52:16 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
	<andy@greyhouse.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
	<manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Sunil Goutham
	<sgoutham@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Christian
 Benvenuti" <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, "Claudiu
 Manoil" <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Dimitris Michailidis <dmichail@fungible.com>, "Yisen
 Zhuang" <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	"Jijie Shao" <shaojijie@huawei.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "Geetha sowjanya" <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Ido Schimmel
	<idosch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, Bryan Whitehead
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, "Edward
 Cree" <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>,
	"Imre Kaloz" <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>,
	"Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, Gal Pressman
	<gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
Subject: [PATCH net-next 14/15] cxgb4: Remove setting of RX software timestamp
Date: Wed, 4 Sep 2024 10:49:21 +0300
Message-ID: <20240904074922.256275-15-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240904074922.256275-1-gal@nvidia.com>
References: <20240904074922.256275-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 135a8232-c4ba-43ea-0cd7-08dcccb68d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+y8r4bsRqXPbVtTAp79BGGiB7z6yR9gQYgaZdsaEO/n1RWKNEtZ73w/4kMK2?=
 =?us-ascii?Q?6dprvelL+XPbYRMhAWh4nNObqfwkDTParc/CCkbdxaKzdGnf3iaCk9MVkdyf?=
 =?us-ascii?Q?UCXxc4I2ruKE9Q31iVDSjArOWwO27oyzPHsjYp7JDKjR+MC7uKKEEPOsD0bT?=
 =?us-ascii?Q?kHNOSS+mcDcotAmkX2gwUQMVPsVRRWkWcO+Axjg2CPGTA2BalE8bv6TtTEX3?=
 =?us-ascii?Q?aGDxat2iCumjXPrEWQXX3CGggQWniOJUQppMXO59jpW63eKKKfLSTepRRtPA?=
 =?us-ascii?Q?H7H97DzEEdExNeq49NZTjBLzgTfj99ZMn+0DbcLLiPMBIckHd3TVx8gSBOZX?=
 =?us-ascii?Q?/Yt/o/Ux5r2SU4C8UXBqa7MJK8BxyTVcih/5MAaZ2WpyS5RK9zwkimep5Hje?=
 =?us-ascii?Q?HKA8F/kB2WFPiC6HxqdJYgO4bZMZyS9jedISJ2XTC7zbLfQ9r9X3HjMJ+Tjq?=
 =?us-ascii?Q?x6CRT81+Pv4JY6sWNEynIwllJOTz/LlKc/1zTg6gZcoIUb0q/iuTq+BSLdla?=
 =?us-ascii?Q?+fEaUv3Bsj3z5wdoJBARmojpLQbhlOcSLlu309C4t7H8vcxEIM9rpdR0fW1y?=
 =?us-ascii?Q?ZtkF1ThwsdhwIGzqyu1BAGCz1IkDo0ehHFKCc6qjNLzVCZur9B62gycJ5PW3?=
 =?us-ascii?Q?AEZ1uiAKOoEJQd9Ftj0jDq6BK5+IIwVcnpbvcQTBiz77b3pyFXiUxDeqAVT6?=
 =?us-ascii?Q?7/G5+BnSGsqMPJjzUQS49lISgfhV+lFxp7d189JXDUW1ZG6cc0W4eTwwJ/FB?=
 =?us-ascii?Q?8fDomSbF6pAaF9MG7tlq49XAmvRW+M9p4NcGjOXyt+9sGhrCT/CxmpU7uXPR?=
 =?us-ascii?Q?lp7/lyH8YE1dmrd5lY1HkiLSx5RbvNqMxJ08gvIHiaOV1iratafpTOtNC50G?=
 =?us-ascii?Q?C3Xkk7nO7A8IGK+jKSadyp6hHM5jXwezbrQe+uVZr9LO6VfVKc1OTGoSC/IB?=
 =?us-ascii?Q?Tfp/doye4t+H/xrNn9nx4fNTAp7RMB5UsJGKYumMrCyv/VGvK6elMdp02k6U?=
 =?us-ascii?Q?mYyRgVd/TNWichDw+N3nZT5F+FIzkQyQvXEyhkoLNFAElp8PEbBsq8HYPa12?=
 =?us-ascii?Q?jdo3ahBO0MKzvcrILrtMPxk4qu33B0oRvXUtz0/VtyphskhX6uZr0YyUAr7K?=
 =?us-ascii?Q?zNznk9u4CWnoKVKzKHNDhbMnfXJvVsyJYzeD1/n+jWS2a9/giONOnElPY6DK?=
 =?us-ascii?Q?96+7JAqytpz5xKbdJoU8A5jRlfgmVcXlXYYZEFJdOkItTajlxGIGHq4Jro6F?=
 =?us-ascii?Q?JeY207d+HRg0YvitIhjTPF/8CMaaqCjIICggmPY1uYoZ1ChxFji86YadGC0V?=
 =?us-ascii?Q?oAujARMkn/fY/FueXFEM11Iq/NzGEEALHKPuJf0XsdANZW9zikCq0myOPJzM?=
 =?us-ascii?Q?8/280i4stI9eg91HrQrgVLWe65RV+YIPQliZ3srk66RfCEkqwVhI+Uqd3Mzq?=
 =?us-ascii?Q?nV5+tFhJds+KeNUwE0A9VDjxpmjm48mS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:52:40.1402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135a8232-c4ba-43ea-0cd7-08dcccb68d12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 3d091947ae00..7f3f5afa864f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -1556,12 +1556,9 @@ static int get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *ts
 	struct  adapter *adapter = pi->adapter;
 
 	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				   SOF_TIMESTAMPING_RX_SOFTWARE |
-				   SOF_TIMESTAMPING_SOFTWARE;
-
-	ts_info->so_timestamping |= SOF_TIMESTAMPING_RX_HARDWARE |
-				    SOF_TIMESTAMPING_TX_HARDWARE |
-				    SOF_TIMESTAMPING_RAW_HARDWARE;
+				   SOF_TIMESTAMPING_RX_HARDWARE |
+				   SOF_TIMESTAMPING_TX_HARDWARE |
+				   SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	ts_info->tx_types = (1 << HWTSTAMP_TX_OFF) |
 			    (1 << HWTSTAMP_TX_ON);
@@ -1575,8 +1572,6 @@ static int get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *ts
 
 	if (adapter->ptp_clock)
 		ts_info->phc_index = ptp_clock_index(adapter->ptp_clock);
-	else
-		ts_info->phc_index = -1;
 
 	return 0;
 }
-- 
2.40.1


