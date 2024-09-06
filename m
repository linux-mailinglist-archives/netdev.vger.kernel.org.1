Return-Path: <netdev+bounces-125969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346596F745
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A421F21382
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD81D1F5B;
	Fri,  6 Sep 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="maXg5kEb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0F1D1741
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634001; cv=fail; b=KvDQEoIHz7RuEZgrOCkPa9LGVbB9xRsKakv+gXOhLbMCNICjFzGM8T1Squwfk5jnWuGzSSgpWc1pKjzfE6DYB9zwb4dz98OpmjFZXqDsYvb98rNYPdIMClRqatQsqeGa4EJ+aOa2bT+tWpINKWWnudBFw0kIoXcODqai8k9Lv5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634001; c=relaxed/simple;
	bh=73OEbkS7JzlA3hLidVaGEUk6TrHdnIdfbhSc1X3BDQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BZnafCfX8VEN/sF+kemRovsgY2g+Sog12NTuqJbd1zOoaQfWcPOAyqcMv3lzuP3rcYk2qtCIUAVvSC8PAKIpx9Upv0gBnOJH0jlyuyLuZ0cm9G0t0yLk3cFQqybhcY655D0hwrq29qpYqjo0wPhrytY4RI/sC9sb17uTxJocRfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=maXg5kEb; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6BYl95Qfe5HQt91TnK/CYx+1CCxNa6Vlyk9/04hg1JUPHL9hWQXYUTiccOvDCvau60XIZ7Q7I80aSfgVhquT8W5ofTxKfng5NgkUGRgE5RvOrGy8vIaUDSkv3Ypb5GnPzH3UrWguUBDVht8JETY3b0acN/BRr5l7/0sIzeazFnsm4pNZHjnpLb4WY359TYAMdHLg0ZU84CvvPB/KMRHBwZozq/or9zgttaYhQ6P0q7zbTF3JyaxyBFbnIt7ENer4CQFImNK5vnhbvg9fExWsh6264PidjDcG4SCkgOkS+dwWqUXFiINLLChhWe1rBkFBjVqAvLsHgNDo3VC5et3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZiqnLzVOrTP3VLdyhRb8G+CQsRSKwx3/VPOSvWHzGg=;
 b=sX8kjQZ70Fm3N9lgsfNf+Ceaff161gExaBs1+wxR+brNKXyrHDwRbpLOI8ubUkOtYIb7hPI44hacRf0Vh3Dfqsz2gKa6zbU09CBkK1AfIjCrb+rGbiQc6Vmpvf8cjy4YTGDhawQUNcIGjrjCuFJvHfMz1q+aZ/4XaDdrgn7IGRwNMT2CzL6euVw7K/GnY3mX5HxQgU0GgaZmNHZc3ElN9ouiYToCRUQiqCQIHHAt+ASNxODmWQcacWsz6GuALXZx6dd0FwXxwJm2CdtsVDFTgFeGAyJq9eMcQ4JAh0zWwKxV9BiuJ29O/tDWdDifYS10eBziKN9l+6qPw9p15DUYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZiqnLzVOrTP3VLdyhRb8G+CQsRSKwx3/VPOSvWHzGg=;
 b=maXg5kEbzQKwU/hfZrB0/PctNWG+5XQu5LjykRw1OvGX9WOGDu6AsQ5mb3SNtYH9L6lZKzMLcsVolpOhcSK0I2p4cH8KZZ+X0f4FA6RyWlLrn4ZrQJEMAszk0w6LBMVghhYZa7C1ppJaAFKMqsuqfSmaboQE3dMlXj5p8jEDAbH7n12/Xi02aJ5EDAhxLPBFIYUnVbSRC4yYeHyy4Otwh33ZySF4XgJiQo5OrkJI0E+s5NNrMHl9pfQxncu6tHnqOmlPMTvZthyRX/T9lqXF1lIwq7Dtv8JPI3dgmEoV45Z5Faiu60YLLsQCgLSXO7AP2xWBdsmgQnSOHFg4+7EqxA==
Received: from SJ0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:a03:3a1::11)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 14:46:36 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::78) by SJ0PR03CA0366.outlook.office365.com
 (2603:10b6:a03:3a1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 14:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:46:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:46:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:46:22 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:46:08 -0700
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
	<gal@nvidia.com>
Subject: [PATCH net-next 00/16] RX software timestamp for all - round 3
Date: Fri, 6 Sep 2024 17:46:16 +0300
Message-ID: <20240906144632.404651-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: f853b981-599d-4910-28c5-08dcce82b4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q8Lq4GcMVnc52fyrL/dcHAVHFGDxxqlk5bKy/8caT3oRwO310nXM/D02fjQ2?=
 =?us-ascii?Q?jWicjZ/BD5ElCUeG5AyC+AnWoAGLr7jM1Aese0Epp2s18UyiE4jj1PDPIDi8?=
 =?us-ascii?Q?YXS59VOhc6EBoORPOG37XPZpIIt4017K73r6D4qSHW9TMjUmscHnkiXebjBg?=
 =?us-ascii?Q?r6Jqvk60O5WXz9DqcDkTsMXBOOlch+thuiakHyJ862qmeuU0nbXCd1xn/PTk?=
 =?us-ascii?Q?tFOn8+RW+BTW/ctTAHCF4EdL8Uz06azQ3yWOIGBvwwqt+toLUSburs2VC5tq?=
 =?us-ascii?Q?g8ef95uIscRsa+hf1unUuJetE/QOeAK5mfbni/WHycZ+WzpRmj5XuA3NjA/P?=
 =?us-ascii?Q?2aBWNJ1svf4NcmHgFOu9AxdyPLhrTMBEoTVHNAWL7u4C6k0zdbQPc5Ewk+QQ?=
 =?us-ascii?Q?v5tGpD5hmZvSBS5rVWrJpbsncAydZJXQ1De1lTrHtdulRyIQsvV6NP1WujaK?=
 =?us-ascii?Q?EF24QR7qqYCq+QAb+jrPM7AbdryNrL9+DonE9zm47nzbBvFtQcQQGbM23k2H?=
 =?us-ascii?Q?BirEsHBdHwEnrASqoom/JV/kMiz6wWdyWhhmke/ytNXAq11FwtiC6yb4YMvB?=
 =?us-ascii?Q?Z1w8v5T6k3ShbmHXV9Ykki0Ym8teolxdqSBTqbCbMsHMHAI2OkDdH8eVde5y?=
 =?us-ascii?Q?qjmMVXeGNmzqM19hA4Lef5MEVdC7AkzR5SDy6+0wndLxQ5GxwFva8CEgTzfF?=
 =?us-ascii?Q?1nH4CBhQiUQHnbhwBASgOKnJaeL7b57vE5XlvfWLoxjU/caD8dXpzzmxrun/?=
 =?us-ascii?Q?+vZQB64kYjHTlIx97wyaWOCixCf27uLpi55F51MY00CyxdXZoN94oMq1quGI?=
 =?us-ascii?Q?cNeYz1fz0SCxtSkuSX1ydFGa5DuT+lSuo2SabXSd7bZGwwSsM/FUXK4BTKkU?=
 =?us-ascii?Q?gMi1OLxmgooqumJeyXry7yuhbj8NKdZ20SbgkNQRmaX6xuf3tujIQraRuDJX?=
 =?us-ascii?Q?myKAI9Gk0PMvgp3Py/QFB9/dLyHwdTi1HEpj3nqW6qHUWF/84v1W9MiojvAK?=
 =?us-ascii?Q?8Md7Sk593cub+mfQB/DHiXaOAms/afbCuMiGiToDzkZ6Ty1pwOEgtOuJrJxG?=
 =?us-ascii?Q?XvUHIvtvpRe+v/JRNNjU02VeQ4GnPGVMrAsDLQmqoriuUJ3iU+VGuPTky3hA?=
 =?us-ascii?Q?aAxGhotme0RbFooPRiZ0ix0XbmK5hFnK66xouxGdba6oPlWkyChl+1TWVHWM?=
 =?us-ascii?Q?MgyJMTTxrWopHtFSjdtqO4Nqna18IKgAY9ercaGNXaWqZGmEttKZ49YW4D/M?=
 =?us-ascii?Q?XWcOa6ev/VteL+5Odf0QX4RcN0mLl0cveLjIIIkXV5bP5jfA2SwqGCjz7j8z?=
 =?us-ascii?Q?jxGg2hhvhQAmMAv67SvY0QzgC7JOxl6XebJ/2TL73FyF7+8HMqVC6jP+0t32?=
 =?us-ascii?Q?U78LWV5C2mMaJGTC2cMIxWR6jrwpFzYIO/hPSeViYlw9yDqfv0nohgpAHGis?=
 =?us-ascii?Q?CDxbW2BI7WmSNWu7wYVjFgqG1d1GKdJg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:46:35.2261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f853b981-599d-4910-28c5-08dcce82b4be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856

Rounds 1 & 2 of drivers conversion were merged [1][2], this round will
complete the work.
I know the series is more than 15 patches, but I didn't want to have a
4th round for a single patch.

[1] https://lore.kernel.org/netdev/20240901112803.212753-1-gal@nvidia.com/
[2] https://lore.kernel.org/netdev/20240904074922.256275-1-gal@nvidia.com/

Thanks,
Gal

Gal Pressman (16):
  bnxt_en: Remove setting of RX software timestamp
  tg3: Remove setting of RX software timestamp
  bonding: Remove setting of RX software timestamp
  amd-xgbe: Remove setting of RX software timestamp
  net: macb: Remove setting of RX software timestamp
  liquidio: Remove setting of RX software timestamp
  net: thunderx: Remove setting of RX software timestamp
  enic: Remove setting of RX software timestamp
  net/funeth: Remove setting of RX software timestamp
  net: mscc: ocelot: Remove setting of RX software timestamp
  qede: Remove setting of RX software timestamp
  sfc: Remove setting of RX software timestamp
  sfc/siena: Remove setting of RX software timestamp
  net: stmmac: Remove setting of RX software timestamp
  ixp4xx_eth: Remove setting of RX software timestamp
  ptp: ptp_ines: Remove setting of RX software timestamp

 drivers/net/bonding/bond_main.c                  |  3 ---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c     |  4 ----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c    |  5 +----
 drivers/net/ethernet/broadcom/tg3.c              |  6 +-----
 drivers/net/ethernet/cadence/macb_main.c         |  5 ++---
 .../net/ethernet/cavium/liquidio/lio_ethtool.c   | 16 +++++++---------
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c  |  2 --
 drivers/net/ethernet/cisco/enic/enic_ethtool.c   |  4 +---
 .../ethernet/fungible/funeth/funeth_ethtool.c    |  5 +----
 drivers/net/ethernet/mscc/ocelot_ptp.c           | 12 ++++--------
 drivers/net/ethernet/qlogic/qede/qede_ptp.c      |  9 +--------
 drivers/net/ethernet/sfc/ethtool.c               |  5 -----
 drivers/net/ethernet/sfc/siena/ethtool.c         |  5 -----
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c |  4 ++--
 drivers/net/ethernet/xscale/ixp4xx_eth.c         |  4 +---
 drivers/ptp/ptp_ines.c                           |  4 ----
 16 files changed, 21 insertions(+), 72 deletions(-)

-- 
2.40.1


