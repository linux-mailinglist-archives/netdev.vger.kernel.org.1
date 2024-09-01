Return-Path: <netdev+bounces-124022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B496762F
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1997C1C2082C
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53E15250F;
	Sun,  1 Sep 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVWAgHFt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAB61FEB
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190092; cv=fail; b=IyLTTcKD9jGNR2qNnnddVgXLXM6ThRbLSMHsuzWrrooRIQ9sVoGvgKywALSipVzjsfpk3p3NWyEYPSuL8tpqQkVb/tef1yq9ivE1pHNVkDgdHCVhTtWAtWzUT/Se6C9/m2nddRVz9Zr+4t6BORhQzgsX0YP8N08/W8Lc8PaNtII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190092; c=relaxed/simple;
	bh=Ip8Qjr8YXo3PH2lOZGEVRtRHN73cWXwhsk5Z/I088E8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dbWB4l4efewMHJtlCIEWjZVcta3F4jjR9WP/vHkHAs+NFKC7IJFjSzaYpQIYEuLC1KupLfozLDYqZqtxlsw9VjIMjMFCUQ2DyZRzmnyc0W7U7VR0LEGYeg7ikYGKYSIx6EcGGBh2mLfqVUU7EfZzjqHuNQVsUfrC1S71os9WdQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVWAgHFt; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYZfJdGhiEpib1K2OorJkkYgYThYU/ODtpIXfN1DNeipkBCcvB6GUpCrMWJD38mmDHhC7Er8UyHfTjQjWIlu2eEYKVF+gHVjoRd5utJG80+Y2DiJqh7fnmyi4yQU9GQKtczdveFUEZY1O3Lvqd0AGqNp3ONwkgnLwlsI8HsGqt2UrHJf9EojbAdHv/kazEQWrTMI0vYHywy3+b269CCBJ4lV0A2BA9dFJWsUQj5eaPmvhRK85ZBaRs5uqlRFts2NSLF24E/JiPUKBsjqm9s/4LPXwT6VDvGvayNcIzvmnQ2aD4q980oN2SJr9k4NneVhnFeHNlWEBba5Q++hIOui7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqQ2j4gWvIzDumozPvbZfrsKlV+cdpPncgcgNuHwcOE=;
 b=Pk6t2Ot2lUuspBQwziCl0pbLF7l39JjEvwCQIDQwm7lLbCiAzevIhuBK/jhXXNFpTxXBBaWWxHjPKfoFTNs+su9Q1fwoCg20I+/mdnuSkfmUUDS+h6QyQvYmrC5JC1UFFB4lfEDftqQjn0zxpqeHsj7Msni9M25uYPAwi3RNoV0ujwF/Wq2s7PbYqcXF7WAgKNi6ZJeBrY5ZKcFevbIz8yN1QWX3ITYIFUBpNKuD2Al3XCE4Zl48vJBlzi8iDzO2TflPMQ0P11lQb5VZWHU8DdoSLziBOexoC10wi82UKC8M/kPKrELnTLSoca8BqtMewXr2+5RZ0jOVcSCcVRYJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqQ2j4gWvIzDumozPvbZfrsKlV+cdpPncgcgNuHwcOE=;
 b=XVWAgHFtTNLWIb8iBJ9VsqeS2gQFEhQNQkOCbSaoJ/GRMUTtoYZx8DfZYl2PJS7uvosQw4zZXQ75kxqpXnLgcl+G47WeUStIE5g604EOgGX4pxTQFAOOPxXtVW4MoA+nLjZI2R4yt53SGIx8kuHBiOxBQnLFUr9b1mo1PO7Yd0++GNgxzZpmmE1ynZFOiNApUe6hANXvJnThoDqgQTM9Ch/1Q8QFB05yASfsev9RGgpaiRtDw7y+toypbTj/y1gbGW9+EeWyUmOftHwk7IuXPNPwWlWhxXT6Tqa+6Y/rH/uUAkV/IJmuZmjqx/I0hUVoUVfzVjW1Biz0l6OZxDNRmg==
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:28:04 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::c) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:28:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:27:56 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:27:55 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:27:42 -0700
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
Subject: [PATCH net-next v2 00/15] RX software timestamp for all
Date: Sun, 1 Sep 2024 14:27:48 +0300
Message-ID: <20240901112803.212753-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dcfc41-9533-446f-f770-08dcca7924cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amRMTExtWTRuemhab0FsUVg5WjVWNHJlOVJCUWEzMHNCeFVka1VLOE9sU0ow?=
 =?utf-8?B?Wk5BeGswL2g2T2Q1L1hDMUw2RlRpWnF5NkZheWdQUEJPYS95UThwTEF0Mmht?=
 =?utf-8?B?K1cwQzNQelhlYWhZVXBiU1ErOWROUXhXTG9JVVlJTU5RUnhQS0tjNERLbUUz?=
 =?utf-8?B?cVRRUDg1MkRXL2p4V09hNmhGUURBQUtFSUwzcVdjR3YvVWpocitnUWprbzRp?=
 =?utf-8?B?dTdxU1pEaFdZVDJNZkZIVmpWQy81NUJBRFZTT3VOYlZnU3pjYytmUGVtdGNC?=
 =?utf-8?B?QkFxU2Z1RUhDSTR1TXN4UVIwc2pxdlVyY2pUYTIwQUhscExoaEJxeWxKUDF2?=
 =?utf-8?B?S1ExY2IyMU1xc3A2T3JibU1Cenh3TW84bmxiRUhtclhuMHJHUlRUdy9uYjho?=
 =?utf-8?B?UHgva1ovbHNrUWJXNW5TTEh0ODhCVE54VkRVaWtLeVJrUEtESmxhcDJBWm5j?=
 =?utf-8?B?VDJweEVWVHVhUU9WVTh4cXVZK1dDY0EvV3Z2cHRCK0IzY3QyZGJOaURlMUJ1?=
 =?utf-8?B?cmNwMUtSNFlRUUUrakc4NFQrSEkyRERicG9oa2FtMTNuYjFieHhCZnF4LzdK?=
 =?utf-8?B?NXl3M3Zid1JIQng2WHYvb05mNi96K2lKV2xQenJRS0k1S05HT1dWejNpUXgy?=
 =?utf-8?B?ZWI2SFhTcDgrbWFaZXU2ZG1FY2ExQ0J0aU9mN1JTbW1XSmk2VHQvN3J2M1hm?=
 =?utf-8?B?ZGlMVW1GVWtQK1BFY3ZhUDZwZUg2MWg5dE4zbWcwRzR3NXlIUkZidDlwZFRX?=
 =?utf-8?B?UjZ2cmF0QkZoVklldzVOWDVRMjcrbDVQSGdpZDN5WTB5MmQvWXVxUjFGQmZi?=
 =?utf-8?B?SEpuQ3AwMUxEbGpEUldKN2p4OC8vVGh3RVA2THBNNS93ZDkzSzhLc2N4eWtE?=
 =?utf-8?B?cEY5OXpVQmM4QzlZTHQvYlRueVUySHdyckVoKzNXSmY0bVl0VjdFRUUydFZX?=
 =?utf-8?B?U3ZEeDcybktsR3pJSU04N2RMclNPeFllTk9TT2w5VFYrWUtQWGVXdjMrS2NR?=
 =?utf-8?B?aW9pbURsL09ySU45b3lVY0JEOGtPMUxZaG1LMnBWekpwcVNNSjdFVWpyS29n?=
 =?utf-8?B?bjVaVzExL09tNUxLNktGZHFodlNwblhKNk81YzIybGZia3Jqa0kzekZmVHdN?=
 =?utf-8?B?KzUwZm0yemNrUmx3RmllTVQ1Qkd1emM4WlQyQUZCb3FFZDN3cUQ2OUw0M2ZR?=
 =?utf-8?B?Z3BrdkZrUkxSc0RnOUszT0VuSlJPbVpYSmdoc0ZGdXhoaXd4M0ZrU2ZEQnJz?=
 =?utf-8?B?cHY2M0JXa3BWc1hQOWsxSG80SEpaUTZsRzFBUmlHekpYV0RZZmVodS9HQjZm?=
 =?utf-8?B?THdkdE8zeUFRckNkZUplMDJxVSs1Y1BhcERSbmV6S2FHck9OaWM1ZllibjVS?=
 =?utf-8?B?dElYTGRKMDlWbWd3MC83aktjVk10NGhPWUo3bWZSMy9RTmJmcWRWQXpJbVpV?=
 =?utf-8?B?bHVrZ3hoUGNQK1VsSEtXdWZGYWhwRW53b0VRcWdJR1plVUVoNjl3Q09LRFRS?=
 =?utf-8?B?Ykd5OStuVmtpSXFXVTB4cVc3UVNuNHN3YzcxbGlKSzcycFRheUZtdkJYY056?=
 =?utf-8?B?T1lnc1hGZGRlOEZRZlVFRmZVZ1luWEYxL0h6a1g5cDc1UVlKZ1RpcHV4UDdw?=
 =?utf-8?B?ZGF0QVY4cHoySk9HZFJ2WVdJNVRXR016NG1BWWQ3YzhSQmtCYzZWM2gwUjBy?=
 =?utf-8?B?eUFzcFJGU3VYSFp4VHA2T0IrOUl3OTMwREVCNDRDak0xS2cwbjIvWGkxWEdp?=
 =?utf-8?B?cUNLRmZyR0gyT3Avcks3c1kzZk1DNG1DMU9RQWttTzdFNzVaMlU2aE81SWpE?=
 =?utf-8?B?RXZxZHZ1U2ZFaTZGb2NBMDVtQzJtQ3gzR0JENlJVTmxucFBsUHlocUxkSW5o?=
 =?utf-8?B?eHJMUTNyTTVBVjFueGZqb1VzRGdWV3FxWVErYlY1RTI0R3c2U29UeUIvUnUy?=
 =?utf-8?Q?d6ELFHK2hjaLG1gQkxDKtIe4qVgcNh3V?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:28:03.6449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dcfc41-9533-446f-f770-08dcca7924cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

All devices support SOF_TIMESTAMPING_RX_SOFTWARE by virtue of
net_timestamp_check() being called in the device independent code.
Following Willem's suggestion [1], make it so drivers do not have to
handle SOF_TIMESTAMPING_RX_SOFTWARE and SOF_TIMESTAMPING_SOFTWARE, nor
setting of the PHC index to -1.

All drivers will now report RX software timestamp as supported.
The series is limited to 15 patches, I will submit other drivers in
subsequent submissions.

[1] https://lore.kernel.org/netdev/661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch/

Changelog -
v1->v2: https://lore.kernel.org/netdev/20240829144253.122215-1-gal@nvidia.com/
* Split series to patch per driver

Thanks,
Gal

Gal Pressman (15):
  ethtool: RX software timestamp for all
  can: dev: Remove setting of RX software timestamp
  can: peak_canfd: Remove setting of RX software timestamp
  can: peak_usb: Remove setting of RX software timestamp
  tsnep: Remove setting of RX software timestamp
  ionic: Remove setting of RX software timestamp
  ravb: Remove setting of RX software timestamp
  net: renesas: rswitch: Remove setting of RX software timestamp
  net: ethernet: rtsn: Remove setting of RX software timestamp
  net: hns3: Remove setting of RX software timestamp
  net: fec: Remove setting of RX software timestamp
  net: enetc: Remove setting of RX software timestamp
  gianfar: Remove setting of RX software timestamp
  octeontx2-pf: Remove setting of RX software timestamp
  net: mvpp2: Remove setting of RX software timestamp

 drivers/net/can/dev/dev.c                     |  3 ---
 drivers/net/can/peak_canfd/peak_canfd.c       |  3 ---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  3 ---
 drivers/net/ethernet/engleder/tsnep_ethtool.c |  4 ----
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 10 ++--------
 drivers/net/ethernet/freescale/fec_main.c     |  4 ----
 .../net/ethernet/freescale/gianfar_ethtool.c  | 10 ++--------
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  4 ----
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  2 --
 .../marvell/octeontx2/nic/otx2_ethtool.c      |  2 --
 .../ethernet/pensando/ionic/ionic_ethtool.c   |  2 --
 drivers/net/ethernet/renesas/ravb_main.c      |  4 ++--
 drivers/net/ethernet/renesas/rswitch.c        |  2 --
 drivers/net/ethernet/renesas/rtsn.c           |  2 --
 net/ethtool/common.c                          | 19 ++++++++++---------
 15 files changed, 16 insertions(+), 58 deletions(-)

-- 
2.40.1


