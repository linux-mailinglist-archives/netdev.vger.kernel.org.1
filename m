Return-Path: <netdev+bounces-124029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D14967636
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F5AB212C5
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F08716B391;
	Sun,  1 Sep 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8/UmaIG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5C76048
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190190; cv=fail; b=EKCbZ5pse8KUxvwZu6/VMhmN83cEUGFuu+Br4OOd9kPOV4TPd00TD0r2kgiF1OJvQ+oet+r34JUO/0qzSSgzhaWWxvG96/T99/F+xvk1ilkw0a+kd+IQCXLOwagmOF6/RSoDaYx4okLq42rNsJPT9Lh1Zn/xnqcqy4Xn2cdV67Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190190; c=relaxed/simple;
	bh=onSM1wiAnmeb37QTG7VnzFz5yFlaBRAfG4o+iqqxXAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XidtUMvnf3jYNqqUHjmSh4SzAn+HxnlSlDcNw/Ut4OmCiBBW0mv/l5z7GLMaIsAjR+5a+2pjMKRU4B94tX4jU15xUs8CWNn3tOrA/ZUCdI0QUaX6+FnYHksTkPk4ov8d3jLl5VlKY+jPQsOtYb6hORp7uffGETzl8crq2FH/9jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8/UmaIG; arc=fail smtp.client-ip=40.107.95.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIknfR/EI7EmaJIqL6mOXLjLFcORSVexN3Xev55jys9zvhGxj3aU5dFND5FpX0/2bINk7kAerXYxN0l2uqrQ6iDDxO3r9cHC0NSG3nSxqgUD20PKEVZ88FN5x6StkeWx6QmeyIh70Lhd3nFAVX2tvftMG4BrjHbe/+Nnlopsqp8vv9csX8xFMfO4AG7LwfkVgMuW1kcRYkowaAdtOpZt7Boou+C0/WuejO74MWuRs8ilRMghZVSHDbT3AuvPyMkZXvt1xJ9W9TFeKwN2VH2eUklSE9sO1pxeTp19V9umMKuVoGz2ra9+utcuknqextmA3de1vUyH726IWg1GzpPESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNfVUjNyhT7V/VCS0BydOJQscPUylUArvmPuPAoK2+g=;
 b=nutgt+WLu1ap12g1mHU1VjV8eRlmvcbQbgFX/0nA9aS4G3LNHV5Fh0iiJtbHG2eCYjK96WHDmWkGskEHuEVCMYsmXfs1cj28ngRRVMPKC6GhOmaz1fM2VSH0tK8DQysqzcEHNJ3pTMNpGVgQA7UtiGnBzSKpkh4Ir205cDOaojsfW3rbCQkU9kQQ9XSMAdj3bIF0l97jJaKJIp/UkqXAbyohVAmJn0hqhYaV6M/7gcxjNU4DjXMLxsLZZDuwsKQbwiSBlgtHYRhKqT9inVOi2VDWUZQcLLX+RTmaF352QS7DpqlE4l9kXXi6ZZP9rnxlhY07kSWkBQsLE11CsklMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNfVUjNyhT7V/VCS0BydOJQscPUylUArvmPuPAoK2+g=;
 b=T8/UmaIG082XNMXK68uoxSAAvsoOtTnBxRGm8YHgDHMjTUTbhJz2qk2VHd1FwxsALTBZ6AdB7BqO9LnrtcwhGMzdvvDDmIas17mPjRRAWaBfFQEZfROgWG+CNhNGpBCrUfhOZuM03UopKhfFN9yHCEha8Hx7gW/PRHUYms2JprQcXOtdJ/RVfeQtfHBMPzGr2sUBoAEGy7QNwihi9k8nLBTxe021mbejsnVN/R1W8bJ6v3TSdtSyYOqe7l9i86q2ArGDzSsZzwicyRUishMavOoNF2MhiARw+762Imo26465WdHoDPCY2VgkDJDCDIiEFwiSd0cV0gkYM7wlGQ3GiQ==
Received: from CY5PR13CA0012.namprd13.prod.outlook.com (2603:10b6:930::23) by
 DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Sun, 1 Sep 2024 11:29:45 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::55) by CY5PR13CA0012.outlook.office365.com
 (2603:10b6:930::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 11:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:29:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:29:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:29:35 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:29:22 -0700
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
	<rrameshbabu@nvidia.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v2 07/15] ravb: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:27:55 +0300
Message-ID: <20240901112803.212753-8-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240901112803.212753-1-gal@nvidia.com>
References: <20240901112803.212753-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7c4233-5b87-4a55-1077-08dcca79615e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzcrUDdKK0tldUJFVUtDRzJWbHpPNGpQVm0xNGdYdEJDUFpqcEVjQUxWQWli?=
 =?utf-8?B?alE5Uk9LQWR2bU0yU3dzdkV5MWNseVczTWFyZ1g1Y0JBSUs0M216bWdQRktM?=
 =?utf-8?B?K1pIeWlqM0hlMDc1L0Nyd1p0N280VGpFSWtiRDN3ZVV2UmxCNnZoQjhzd1Vq?=
 =?utf-8?B?L2ZQNERwWVNXQkNDdDVYUDdLTk5GSkd5a1A3dWN2emVkaFpvcms5bUd1M05E?=
 =?utf-8?B?VVYyeEorM2hzaElUVTUvZkNES1RQb2RSWnRvYWRGbzhOTG1WZ3BBb3VCZkQw?=
 =?utf-8?B?UDhJcFJMR2QvaHZxVXYyOFVkRzd3L0lCbkNOZVgzVDhIWTN1dFFtUDBlNncr?=
 =?utf-8?B?UVZiVFRNYjd1MFFlNElIYkU1SDJtcWI3c2ZjTUpmQVdrUlBGTS9DMFM2RzZB?=
 =?utf-8?B?ek5KaUlxVFBXZndmanUyYnZIQTQyVnFndmdCVkc1MWtHeDJOOU03SG5Qa1RQ?=
 =?utf-8?B?TlloL01YbzEyUjhITXA2dmRiMkhyZFI3REdnT2diVThPN0lvSHE3NjR2QWw4?=
 =?utf-8?B?aFpuV01uWFEwWk5CcWZ1TnFGU2w3N3lkeU1lNURIdzljNklsREliOUp0VWxE?=
 =?utf-8?B?SjVjdUpyQktHeDBtTW5mTEFHUVNSVkN0SnF5NFpicCtENmJDSGNyVkNUQUo5?=
 =?utf-8?B?YzRxaUxGZzBsdEVKeS9kVVFoZExWQkxhdGpkekZmYWFNa0hrUkRpY1pVRElw?=
 =?utf-8?B?bEd3TXd6Q0RJL1MyVi9BdUNzMVJHNVlxVUVZS0hjMXBvTUlrSTBSVmcxbzF0?=
 =?utf-8?B?SkJwbGdvd2ZmalByTWxJc1crVHRJZzEzbDNoVU1lVGkrOWFNQnM4endPUVVx?=
 =?utf-8?B?cWJ6RHlGS0E4RTdGL1Q0Tkthc0UvUmtCaFZRNklNS2YxQTMrNTV5Tk9XMWJt?=
 =?utf-8?B?T0lJMWszU2o2MEZ4NkREZkplZllrMCtVaWh3RVpoQndJNzE0ekpleEMrNmVh?=
 =?utf-8?B?Z2M0aWI4bFc0N1lyRFZlaDlHRVFGVGt5c3RWL2F4dzlFbUs0dWdNOE52NlMw?=
 =?utf-8?B?bm9vbyt3U0kybG1xUVc1TGUvTEFLQVQwbkNPbzlNSVhBdkZiNzlMYXVkY2Vq?=
 =?utf-8?B?MXR4bjlXbW9GZEV2djFtYy80Rk4rc0ZkTHJ0M2J3YTNhckh4OFo3SCt6Y2xv?=
 =?utf-8?B?czJJT0RXTUdvcmNnK2Qxd1FrWDZGRG1nRDE3anZjbWx6Ym1pbzVFQnRZMlNW?=
 =?utf-8?B?Ti9ydW4yaWpsWlZIQjlONi9BekpXL0syZkk1SEJycVhMYTc3NUIrYzRpTDRi?=
 =?utf-8?B?cGN5MVo1UGtPSHNXSmxhb0JjeVlBYnJXYUV6VXhjZ2Q1ZWNvMjVvcjhGbEM4?=
 =?utf-8?B?NVVQUHc3eGg5M3NyN2JqK2FRYlFsbnVkTVQ1RklSWDRRUlE5cjJ0Ujl2SmpE?=
 =?utf-8?B?ZGQrd1F5UFdQLzg2RDExbktYWmxWL09pd091RnlUUGU5S1dZK3B5d2lGY0R2?=
 =?utf-8?B?bHBXSjd5T1NsTlhkL2dGR1FLUWp1MVFBSkpHcDVhcVUvc3Yzcks4RzFHcFhm?=
 =?utf-8?B?VGUxQy9pd0EvMy9zUHl4UFd1eG9rUWc1TGhYekI4NUcxVCtRd25mR2h4MDM1?=
 =?utf-8?B?M1NwTVRVbUVMdElPSUNkcXdiT3FUd0FHczZGRWFsbnJENGNCT3M5MmdudTU1?=
 =?utf-8?B?MWxDRGZ0bEVRNWNITGo4WTQ2ZE1JTFRMSENQWUlRcGZpK3J0U28rbEZoNWNi?=
 =?utf-8?B?cFNsWHdhaTV6RDEzZDRKd2ZmcU1JQW9Fb3FuNFRkWVBtUWNLa0dncEpUVGt1?=
 =?utf-8?B?Q0cvZGpQREtvSEpEK0xlaEo5czJrdlRNYTg5MzJrVExBNE9reFdXbEUxZXNO?=
 =?utf-8?B?S1drTk94MDU4YSs0TWIzTGJPRzhjUEVoZFVvcC8rNTE1RDRKbXd6WFBvOWl6?=
 =?utf-8?B?T0c5SUVyS2RLaVpvUGZ0MWRPekdsYXYyZk1LZms3UUV1NWJrQVcySGlLNWpI?=
 =?utf-8?Q?MOk+PcCJGKClhRkjfTjs2x8zsokv7QIp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:29:45.2238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7c4233-5b87-4a55-1077-08dcca79615e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c02fb296bf7d..c7ec23688d56 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1744,8 +1744,6 @@ static int ravb_get_ts_info(struct net_device *ndev,
 
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
-		SOF_TIMESTAMPING_RX_SOFTWARE |
-		SOF_TIMESTAMPING_SOFTWARE |
 		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
@@ -1756,6 +1754,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
 		(1 << HWTSTAMP_FILTER_ALL);
 	if (hw_info->gptp || hw_info->ccc_gac)
 		info->phc_index = ptp_clock_index(priv->ptp.clock);
+	else
+		info->phc_index = 0;
 
 	return 0;
 }
-- 
2.40.1


