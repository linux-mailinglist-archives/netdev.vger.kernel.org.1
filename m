Return-Path: <netdev+bounces-125972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC196F74B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8FE2872D8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0261CEE9F;
	Fri,  6 Sep 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4nQopw+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C4172BA9
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634049; cv=fail; b=BqBETa/OBL9evLvJ5CPhIGn300v+mujGfBq7OqgwnhXW5u2mwhEQ1ZO5x6mgqvmUBPo3nCZv13YhadLNL7ta/ugOn0sPl7A49s9J2YnA+8KmFV5JRBuCn1eSyNjPIqkdZQ7EIMBV1+pa1nQlmwbsWfIc84TqAid9b79zWt85fOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634049; c=relaxed/simple;
	bh=1AilcA32EkWHyXVJK/n5CEdFK+0VHyTqjYOtQeZ56R8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuLrSulrs5GHnCZVpK8Bjjey5M2VvoyUnBZrTEv2tUJRzmGn0GYIaXKGIplyvhTfMua62BgzdmmtDzSDNsL4c3k6tKcNFz2c5isNcc39GFuYFR3vp/fJ9PnQdzeONWoEVFLm19zr8PxF6GhKZgfaprsTFGnjAP/iF0uGkmqAZX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f4nQopw+; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKdy9H6JzYgftyhbWqwozsVMRhp5rYJWA+YOP50FT9QSqZ6JNfpE2BdpvdbEwNvDPmmGezwf9ZCxt3masqt+yNjRJbS7+O2/TzMskIHKby0SSaXLakOetcitiL/w7eL4vo/8MUjgAIjVpPGx+orgAA0TXiO0jnZVGnZC+jNLiTXWboH8L64PbapbDUMqtVBXxp9duGXLMRE3FMKnpvR/vITQizNmm9HLeaOSYgMZb31XPi8NAQW4Km03eVS0tMy0CsOm+YSv6cpz7Z9OdETLCZgtnzIJ7wIcz1Ra6z4cpXrlXDwKmJCvNmGIcN1LB/Av6bwHZLN6FmF+kOyoXdIwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BenywJM+kIz9D1BonyEEmgrzCTcRxYakXRXL3gbKwjI=;
 b=eL9WnA7FHaJWq0Uim3cQadKYNXvkhmBNhFb8hDOO4zfH0sls2B47k5bYgM0K0C5QVRfBadQV7O2WWmiAWYB9++rGn44xhxBCzKDzDhy6I7ZiWefi1QzdT2VMpCPIjAYqNHcxAl76YPQFBkvfl7SBp9CbtguFuONdIvlwSYOH9+u3rwXd58YqINs21g+VP5yGdiohnGaHFBB1elYprNWkwoPsJuwKemNJ8X3Fo3kosx+BuUFcug31w6HkPm5rOUlji4dann5OT7DGpkndkKbW1QWuhe6nQPqcmA48LRdPpqcCM5eT7KCz/+VosUZahUIVYD7FSxiQ044DmmP5fhUs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BenywJM+kIz9D1BonyEEmgrzCTcRxYakXRXL3gbKwjI=;
 b=f4nQopw+dMI2dUEsokxDwFN2f+xQqLlaDV7RS6EL8fAeFJqjHsldT/NsH2S+cqWvs66q8nuYiF+zrGxmemZLmK+szdiZrhVNrhYjwc84s+7xcOspkUK+Fti5WkGNC5L1xH9TiB0+q1kfvljCZ5LMQRWbL9kYO466C81Nz2qjSvc5mZgBRZKuYMiPV0rDpBJyYv339O1IZoa6nUFGEgQuRk8sCcqN4IRosyL/tAFeTzqDMDFdAe8CrDlPjrlcG4gC7/ffkkcDE7hxmVGtubHPRavyZgxQ4yy57j1TBs5bzzO1AndALaEpslnxxn6G57MVWE4zjQ3oCnofHn1Q6Sln2A==
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 14:47:22 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::d2) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Fri, 6 Sep 2024 14:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 14:47:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:47:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Sep 2024
 07:47:06 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 6 Sep
 2024 07:46:52 -0700
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
Subject: [PATCH net-next 03/16] bonding: Remove setting of RX software timestamp
Date: Fri, 6 Sep 2024 17:46:19 +0300
Message-ID: <20240906144632.404651-4-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240906144632.404651-1-gal@nvidia.com>
References: <20240906144632.404651-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbc24e8-c696-4b2b-bef9-08dcce82d069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hwo9ML//CpV18fQQxthVx01aT/r0hQj1GBG3UkInxmDXqVV01VPA8zqyw5yk?=
 =?us-ascii?Q?4kYMCN395zJNZWx1ZShLwyVM4BmF2Ov7GvR1X9EK4dgv7AB6BUX388WIsnr7?=
 =?us-ascii?Q?mhhDXdqAuGdliKcfd+qRdTF0RupnLsH9g3f3645vEAAI8PwxBQ1aCgKnuuW8?=
 =?us-ascii?Q?E7A/NfbfgOFCr1TmcI/OSrhDbM4lTlaRdLQb66fNB0aALDaaMI7MayMxM97H?=
 =?us-ascii?Q?0LJfYnEYPF5VsZb6h61PVyuHO2Fk8FNmsT6ToVNoTcQ4Q4q8K16V0D+rKhZs?=
 =?us-ascii?Q?oJeP8ukesqgA2vDPBrdDo2Tbv7s5y9Fj3NRCPYXL34rmh2sGuxlg4GDZgYlA?=
 =?us-ascii?Q?s2R3UiMYr0ocfqdQALYAM1Hi8F5tTgGgdrs1D+Xf1u5vrJ+Ep9U2wELSyIHo?=
 =?us-ascii?Q?Am8lvv/HKCY7MbgjDReFsNDrGd7MOlMmjOcN+v0GoUZk1BD4Z47cELWhB2G6?=
 =?us-ascii?Q?EXPHNewNDFIbkiHugYUDsm/WzlnebsxI7fsxmQmvhxujZANYhHfO6RBHpoTT?=
 =?us-ascii?Q?bFPBIA031BE+9E//bXwo16hdTuQNGaSVKE+3StgxhCycnbK1ozzI0z/RF8xG?=
 =?us-ascii?Q?YzaQqXNRPZoHx4WFcr9hH50yNPyGQ/McutUHFxf7fgJSir6e9VWmQa/Dx0o0?=
 =?us-ascii?Q?y2H3tOjqomtDYUKZvS5fkq8v8VBqjXdLj7reazOI8OMNvxODhJwdZnwptp1c?=
 =?us-ascii?Q?m0bL4tCqSTayzphV+44+/TApDVD5Ju44qNaSa8e89O4ozjHbcxXPh1cSyNcR?=
 =?us-ascii?Q?g1K1ifvZKiaAK/SKf/decnUufYuW+U5rwCKxXBRvpkRlvEdLyVyt+ByedOtx?=
 =?us-ascii?Q?TExIwwbtQ2uozn2qq0oDYeQ8qNZMeV9qU/ivLvYniD++5+FowmgX0QI65ZKM?=
 =?us-ascii?Q?P7cY5dP9hoBqWrWAlaKPVQmfJJp7L2EcA8pkahhUzpn9BToT3wB+G0EoiF5n?=
 =?us-ascii?Q?3TULaWUW/TCunvXCTEUnFgGbEnsn0AMYASR9baWzbFNuOVapJ1AOMVtg2LJB?=
 =?us-ascii?Q?3sHCiOXFALMlv6B4u4AbPaiIkvST8qcw+jvyJfhMF6A/Pk+MACMhflVSnPjM?=
 =?us-ascii?Q?opHWEupdDW3bxa957+cC9LqAAgEvzDofxNLQhqB2pZEmpigLidn0zFaUE1O0?=
 =?us-ascii?Q?O8uuzCjRC+PN0vm0FoM0MMeSmg8UVRrNb1FGWu5gHOO/wOr0WB9WTQPC4DRl?=
 =?us-ascii?Q?lSaK1TrdtnXYX/HjVFmdypOP++l+14aGH6Pu0amEJPPHkJCZzq915EmEfWvn?=
 =?us-ascii?Q?Mz9J0hpOugEzNrC7Auauo8BjjuMtZ6wLrgADUHs7W1rdYlE8w7lXDG59fNye?=
 =?us-ascii?Q?+R8EZiDHFx4Q0bn+GLC/J/2LFl9Ap0Oc6erenV+SikK7dfbzfxswGQm665on?=
 =?us-ascii?Q?adVjPlJhL3N5LU+vt74OzlBOFldEHBJx8eslLS+acTbiskDPNUqMy3X8Yc6m?=
 =?us-ascii?Q?Xf0zVMPp1vWUD5ItAbeVlmNpAlWPEiCp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:47:21.6491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbc24e8-c696-4b2b-bef9-08dcce82d069
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f9633a6f8571..83c406b8b12c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5770,9 +5770,6 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
 	if (real_dev) {
 		ret = ethtool_get_ts_info_by_layer(real_dev, info);
 	} else {
-		info->phc_index = -1;
-		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
-					SOF_TIMESTAMPING_SOFTWARE;
 		/* Check if all slaves support software tx timestamping */
 		rcu_read_lock();
 		bond_for_each_slave_rcu(bond, slave, iter) {
-- 
2.40.1


