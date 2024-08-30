Return-Path: <netdev+bounces-123631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013CC965DCC
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7669E1F27948
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8F17C9F1;
	Fri, 30 Aug 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XvW3YTc1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63917C9E4
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012094; cv=fail; b=nWwVU17Q/OcKkiUCMvNtUG/vEeZ4j3oc3XpXcRTyccMquasQXXq7DBjO4mQK9ShGNG+YfccChMU0axJZyy1rghqOxCAgp3Oej1biuEIFNMwlWV/dqixrAjvvU81ifw9kzyC/6M+svjnRd2I1uTM3n1FRjWXGNo33LZ+7deRm3YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012094; c=relaxed/simple;
	bh=wttkyw+07v2IukPK3gVx1s6SbTFdi6NfphC9nok4rN8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=K3QrRYbriMX7xj4EeBsrUdUA05NQgycQocZvSTIjYaW9ZBacaEh/4QSaowO1ST9IQCexJlHe5ENurSipfvD9ImCscwXRRSe1UenMacyWqqluZ/0CL02OGuioDST1i/j4qvbNw9bzAMet3k9s4LyHoa9TCqxjnOin7RuNOCsUQn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XvW3YTc1; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a41/AKxZ77OJSp8bwaCMzJraN7zd54g7Dw0Lp8b+1U2M4s5F59PHGPuJnAP4VZLmtiK3GVsoZfRQ/xiDTEbRhBsUOWZazsnymrRDwMBzBTYYqDPfY3/68hTBg/7MGLUjrHGH0b+4YIg/jkLxF7pEirpprTYbvO6Ej66aVNyBFFAxdMPpsdXo/GoB55QYuJ6u+DF64Yayq3LqHwSlovp1M4GFU95W+8RIQOORyhBf85ZTsikwAgO41xo3ByI/W+a1V6SUCYVP+324wNae1+BoQRzwfHkqudJgr6F+CHONAFvmzV5ifG2QAF1Oe2E83qqpL4iDh5lVvybTEcKjd7ZIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wttkyw+07v2IukPK3gVx1s6SbTFdi6NfphC9nok4rN8=;
 b=R73beL42nu/oOjn0051mlNPnLHtERkU5xbkecxmCNCRbykUQUveTV0kg6ologhV0Rapuit+Hk1CZjkE/cqRy+cFmlZY5I+ymTL6qp/k4JkR63XPDiJRf2amzvnQ4FNEpe/rPynE2oLcA8WawHCTAnIfhLFdzW+cGl6UcCKwJkJb3pVQQaDfHuxFlKXfANXvlS+/3p6gsFOoX8Vmscbk0J+2s/Sc/T/C2xnHBwT/F8FlWoMqu7c144fpje9oDlFFD/Ct1soHm0FM81uTPnJVqlMdMx8SlXBMyJLocmIodAZrXnWVcMYc7k8sCPznk2y3Zig/kbEUz3ymY6yCnJMEcKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wttkyw+07v2IukPK3gVx1s6SbTFdi6NfphC9nok4rN8=;
 b=XvW3YTc1Sy660YK1hWaweF4CJ80XYCiQngjrf4t4tlnPaijDwNFDnt611ZSGD/LzK4dLJ+t6eQCHQgov+4FtMP45q0gTcJGXQch3M+0FeosY3QSE7wnB/gNfG/969h9x9t0oorIEqD+BXdRg56hM3D1TmNpZmwnXl6v8xaawZnL+FXawqcLm71OH/03KgECAGcy2iW9v6g97pnJz2Lb1HAY7Ue6AYXSqMkEsGoMuX4lN6ViVQSYG4Rp1df/G0qLgy/89i6x5KK19A1pNtrVWVa3XVJJkmikFoUA9Pp1hjn7+NtLbychEigM6g00AaLmcF71dWTfSuLcZ1IdTQzsLjg==
Received: from BN0PR08CA0026.namprd08.prod.outlook.com (2603:10b6:408:142::28)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 10:01:24 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::b8) by BN0PR08CA0026.outlook.office365.com
 (2603:10b6:408:142::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Fri, 30 Aug 2024 10:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.2 via Frontend Transport; Fri, 30 Aug 2024 10:01:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 03:01:07 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 03:00:43 -0700
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
	<andy@greyhouse.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol.vincent@wanadoo.fr>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, Sudarsana Kalluru <skalluru@marvell.com>, "Manish
 Chopra" <manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sunil Goutham <sgoutham@marvell.com>, Potnuri Bharat Teja
	<bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>, "Satish Kharat"
	<satishkh@cisco.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Dimitris
 Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
	<przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "Geetha sowjanya" <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Ido
 Schimmel <idosch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, Bryan
 Whitehead <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Niklas
 =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Edward Cree
	<ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
	"Alexandre Torgue" <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>, Imre
 Kaloz <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>,
	"Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, Carolina Jubran
	<cjubran@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software
 timestamp from drivers
Date: Fri, 30 Aug 2024 11:58:55 +0200
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
Message-ID: <8734mm8h4o.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|CH0PR12MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f77ce3e-fbab-47ca-f3f9-08dcc8dab504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P1Q5z/Ty/8X1htldDbzWIu2ZRT6zQb4Zl3zCer3l+wz7VM3vZQiLp9ctjBXl?=
 =?us-ascii?Q?P62wPy5Q+RG1NQXNVYdEVS59RLTG5Bqvw7x2LEvudCGJ8faZwQ5DrKTkQiVv?=
 =?us-ascii?Q?nlmXum9Jc1Vf08+soiR7dMuYd9A0CzX06zx7JJ5UTMstoyhgeGb1iqc1OFcc?=
 =?us-ascii?Q?weWYTucCNoobzfMVmoyGWaACdiCO/kfYqwA7nybNuei3awlf0tEOhtcL4beF?=
 =?us-ascii?Q?5sIPsf9DT020d26MpeLK86oHR3H/A3Lj0e9VyExjnj9wozdYoO1tzMJ2Fh4v?=
 =?us-ascii?Q?mrPXCxK2EdXvNbY7t/vhNKuY6vc+LL8P4nkB2jimnBMUXkO+naB5Q+lcuT6a?=
 =?us-ascii?Q?7DQIChstg2ly+8Hf4JSIyiR1iA2BjaYwFUY0YKcYtfODDSAdnBdPBQ5fnT9u?=
 =?us-ascii?Q?prA7BsCTFdvmmOxMm+sXWH7zCgLowz9xU4KH8M+X8TUPlqEmdZ7gYtNvbeIO?=
 =?us-ascii?Q?Sj1nW/R/NntVGdO+nlMH7J/d/KVuXbaNtxSI5vHbPsIboPuVXbK/IBkt9FIc?=
 =?us-ascii?Q?2g82Ikyo/BS5qj9NBlp7kq96cWNozbLGLXnuvNPGOWWdj419Cyowo26lBUSo?=
 =?us-ascii?Q?D/Uy13e82gIXHWoDj+SB5qoULn9yuWBCEDE2nJdvLrGQZj+U7lURI47UeGhh?=
 =?us-ascii?Q?mlIFKfYe1nEYU+PKD/IVAoqb985cQukYB9x+iZ3ALLeFY6UDd6CX/IowPVWT?=
 =?us-ascii?Q?Kt7t0SaJqKJibAoCQeRYA8laadYbbuQHhOjbzd4RyiTEDM7CAn7s94JfjnrW?=
 =?us-ascii?Q?ruBEdclag6sLsj7t9512Cst5/G9ACfRdEL8/hcFkF1H9680ecYpG00IoY4WQ?=
 =?us-ascii?Q?rFH4AtH8Zgj2rMPYeTGZKoSJ3ylch0RKR1QzpuCfw08xewIoX9RRZp9MZfu8?=
 =?us-ascii?Q?btoNUirN/dVvl8EHksE96M3ihpoOxpItFxIhsx4tmEVhuLcBt5QT6qvcHGud?=
 =?us-ascii?Q?/e0hndSvldz2k+kDNxBxbsN4WGdMQ3R4EkY6kYF391ltQcgVmBPf5XjiGKr0?=
 =?us-ascii?Q?SRVgtHwuiWkhZdCX48YNuRn+5H178Wu5Ze0y0kiKri1athIJaLyCtNO5oHD/?=
 =?us-ascii?Q?Hv5LrYme9w2frUVOM4MkJoJUAeCXfS5KrAvGi40hRS+4VKL5g+/zlQrGiGi+?=
 =?us-ascii?Q?jIBq8QOu62ljboyUn0GtxS6BrbOCHZX9/nWK3yRFFuf+TE/vPPWeUAbDhuiN?=
 =?us-ascii?Q?TDpHssFSw4s7svuvrQbgg5RDDhcoZfMMEfH6Froj0aOgF13j9OsMxPWceeeR?=
 =?us-ascii?Q?YgwwLONfuAhblbtiCtj6W/dts5mVmzZpw6o7RFpc7MjT36lUjYCEyGpbJnO6?=
 =?us-ascii?Q?3J1cxcZvgqJeeJ9TGyHlAsYHlkUi44KPSLUD8vkyqxMSFt7nMAIJGFGDB6k1?=
 =?us-ascii?Q?IOfD/yWyNhgPjozIiMAsLp8ipfC5u9aFHQ6NnKWoQs5gQsOYm5MD+9TnLjbU?=
 =?us-ascii?Q?L9xiNOWG2VcHXkaU5x5KY6Sc/NYL2Wcm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 10:01:24.3319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f77ce3e-fbab-47ca-f3f9-08dcc8dab504
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530


Gal Pressman <gal@nvidia.com> writes:

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> index f064789f3240..b749879b3daa 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
> index 769095d4932d..c8aa1452fbb9 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h

Reviewed-by: Petr Machata <petrm@nvidia.com> # for mlxsw

