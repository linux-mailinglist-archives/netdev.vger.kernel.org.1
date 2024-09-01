Return-Path: <netdev+bounces-124030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE238967637
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7671F216A4
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59316EB54;
	Sun,  1 Sep 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aNnocdTC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02216C684
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725190203; cv=fail; b=mgEh+J09NK2KFgXB29+/GZelxenQdO1z/EoasKbmOTJ2ZWEv7W/moQr5soPxKPsK61Qy4DHmnKpZ0A8Q2Si3TThBMlSpgV9LF7XFOLtLuBmXS7WW/PprNkTAEUWNtAIBtT59lgDYR0J8kgHES3bEtlvYfnEQmjj3GfJssG6gAD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725190203; c=relaxed/simple;
	bh=Bm5oWtRQKtMQzWBOvse6P6sKM8rxf7X0VNY+AUfgMr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaI6CsnKiBOZqvSmjDTUso3gNEPycSCDSEd+aAX4T5HcWmabdxFUoeyNb6LIQK3E2HyHslceyMuYLI7Vf/MtQ+W8obQJCAFMB06k9hyHqB6NSPpjLpUDpDM6lDr14vuucDVIE4sN46zJJKv6lXzKX3WfFheKx3Lz0nrQb6/whzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aNnocdTC; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JezuDEhp76+2UWo/fXX7McavmKLjyz/d6gGZAtCgiOp+9L/O1nPZzH/lF7zuHGR9lJr7n6JUl4gjqfl1IGTIcezBBEN8IJz5zVvt38OuwwRFiFRU9LZ/6r42RgBiQ+qQnpp3QWaMSuZPP7uUkINTomAu/F77+aKkZz3zcGO9GnSXarj7VicVpV8rT0S48My4mayjgDab3hzBeCotozkNc2evjOzV2uTLjMzrOMZnKO2TNajYyEgYPpckNdasvi6gxp1WQ6wznS2jpA8FdvaYOpHQUP79+rkCJ04LTmHV2RnjO8NmCi81wgldp7XW/gD3lu9R4kVVugKOO94tGjYtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0P1znIM0fH8D3kPejRS+5gkYjHa1MyVgOGtQSk8xR8=;
 b=Dhda4eEKJMRKq5oqQzBrYdI0J1klZza20viyWch5D/i2+XjGSY9lYyb3BsuSAvKMs+5pPPGDbK9J5nYCT+PPxiz6yUBgM/JK8wB4+jKvFuEtLnkK7gJdJnJLV3blU5oQNOJ7/abwpCjBUv+M4uH1fYJYI0mbONruhPy5Ci3SHhO2MTR8CnVno+r3XO9vxwO9PZGU1rWzF7nPaSw3UXAS6TwaNOPYRqecrtfI41bdlsidEESWTtkzBizrR/69uOiBFwa9LzpX3vokTU26c4TkrbIa3apoe7w59K1oWKDuGcd5O/mIhcKXsPO6uvDqOtwF/hGpG83lDsBfN7nc4uibKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0P1znIM0fH8D3kPejRS+5gkYjHa1MyVgOGtQSk8xR8=;
 b=aNnocdTCizmdJTojjW73z/HUE7GLivHXx9bZyG8KF/LGEybCKlPy1isiVNGpJNlNeOu+Jja0LzI5T4EPj7Yqhb4zU+y7SCoCiSWY0LIuhUgReQWxVRoCdWiRnp7hzioVDtXJdpVClCGziHWLu2MZcbfk0vnAN8B4h8oBsMBW/Rf85Jl24fHconx8n5LWJVGZvsSZhYE90cwy1BF8nqqfXGbZjoQ40egUc7VzTDyMIv0yIvkZVazA7LfVzz+vhXGlo09pxgay4TxjmmG6/Nmga8292QdffI1jKRhLGsJc/53zqj3x3M73ORYY7VurvHnovQJh0pdx7VH4bRRvVHL3Nw==
Received: from CY5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:930::14) by
 DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Sun, 1 Sep 2024 11:29:57 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::92) by CY5PR13CA0024.outlook.office365.com
 (2603:10b6:930::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Sun, 1 Sep 2024 11:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 11:29:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:29:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 04:29:50 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 1 Sep
 2024 04:29:36 -0700
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
Subject: [PATCH net-next v2 08/15] net: renesas: rswitch: Remove setting of RX software timestamp
Date: Sun, 1 Sep 2024 14:27:56 +0300
Message-ID: <20240901112803.212753-9-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 063108f3-3760-492c-0e18-08dcca796872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVFxcEtON2U2M2tPRVh5MFNCWmdoZ0hIbmV5Z1FiTWYyZzQvOG5zNjV5MGtQ?=
 =?utf-8?B?U3daT0JWaStrdStWYWxpWXNmOGIvM0w2eTVUU1lPYU1MQUhSKzhNTlVsSDhB?=
 =?utf-8?B?bi91TXlFS1JUZ3hpdDM3QllxTFZMd1ZwS3JrLzY0aXFtRGY4NUsyaGlsbVM1?=
 =?utf-8?B?ZFVIQXQ5SnRicGVIUjVSNTI3Nko0WFZJZUwrRkVJT1R5TWFVaGM0VWVDcjJQ?=
 =?utf-8?B?ejFPVkZDWERlcG9rUXh1aUhGOSt4d2EzL0lhRlZwSTVtNm43b2hOOWRJQXlU?=
 =?utf-8?B?UjI1Y2tzbDlnUk9uOCtuTWlQQXM4aXQ4bVdOQ0xML253ZWdMTThWa1B6d0xE?=
 =?utf-8?B?ZkhYa3lsUU5RQjdVa09IN2NQQ0pCMmhGZW41RG9LR1lBbERVVEpwdEV4dWtT?=
 =?utf-8?B?VmYraE45NmFZdVlzVGdrdEZoZm1KWnZVaVFXSlR2S3FUMkJIWkQyTzNNN1Qy?=
 =?utf-8?B?SDFwWXNjUERqcTdrc2NiZHJOeXk2aUZQeU9Xc1F6WkFQTUJpdlpxeVRBV3Vw?=
 =?utf-8?B?TGtCWGtHODlXVVFhSXlTUEhjSWNFUXYxMCtONFpWcjhGSmY1YytVOEVLbkNI?=
 =?utf-8?B?dHJmTVU4QUxwVTRZeVBGYlB5L1ltdjN1dWk5OFZtZ1hMbjFkTmxZckhYNjVT?=
 =?utf-8?B?c0hVOUdOTjBFWlU3cm1UdGwyT2l6Mk1MdkltcWpBSlBqaStNR3E1Szc5OGNn?=
 =?utf-8?B?T2hwaERod3k5aGoxOWhYRnlpcThVc0ZWbUllaHRjcVIzK3NuOFNENENkK0Fq?=
 =?utf-8?B?VnhqRUZOVlgyakp2ZkVEdGo1dTJaTlRQTUNzM2xLMmRhR25pQUpuWWJ6aEd5?=
 =?utf-8?B?SXYwLzUrM3FHTWl1S2ZYMUlmWWgzc2ZmTXhkZmRabFFqODZSMUpBNVB2c3E0?=
 =?utf-8?B?VUZnY2NZa3lRbW81L1JzL2FTNGwwVzBtbHR3VGdKc0k5MGJVdW0vT25hd01Y?=
 =?utf-8?B?SGVwZDlGcXd5YThlVTNTUFVvT2I0cjhvQ01IVGN2cTNYOFdCUWJZWlFnM21u?=
 =?utf-8?B?dTdYY29CNVlZN21FRHV5czBQWGx2R1g0NVBjTlpYOEtqT2cwTjdmL0R5RmRL?=
 =?utf-8?B?alZEQXRvbFhZeTBJOEUrdzNlNktPZzdwWFFVeHRJQmYrcWxIQVl3V0RRS0hx?=
 =?utf-8?B?ekRKTVZNRFEvSEdYZWI1ZGRTWG1CNHVpSUdEMzYzYm9WTmxVaHMvaDVmNGNa?=
 =?utf-8?B?SjBlR0VYWng0dG9jQ1JkdEV6QnhIaVVYTWltOWNJeENrdGphdWFDMVA4Um5Q?=
 =?utf-8?B?Uk11V0lWdHV6blYzdVFadTR2TGkrbWFMb0Z0Y1hEbVpldjBVV05Ua0dBK1NG?=
 =?utf-8?B?Z0ROUCtsMU81ODZPNjRXWkw3dU9sZFZTcGdyejZtem13RlBxV0FnazhmOG40?=
 =?utf-8?B?dmtadDJtMXh1cWxOV1lUZ2ZyLzhybW9UVVlVZFVmRkdsTERnbjFlb25SMUdh?=
 =?utf-8?B?bU1mUm52OEg2TVZGbXZJaEE0S0VGYkJsQWdpVENlVTVSMjlycitCZDhhUjJB?=
 =?utf-8?B?QzB2c2xYVWxUZXZySTdQMG95Z3ZkUmVvWEtTUlcwN2hqWXl0QXAvMHI3c1pK?=
 =?utf-8?B?RnRwS0dMVDBUclY0ZmlkZXNzVEg4ZUZCZlRnOGxtcmVSZXBEQ2tScVBUQUFC?=
 =?utf-8?B?dkkvQlVhWjBUNGU1azVGbG9QMmlPSW9DR0paSzVRL0N5M0QxZGVhTktkd2Rj?=
 =?utf-8?B?em1FQ0ZSQkNwRFI4QmFpS2lmakVhRXRaanBEL2JnM3ExS0lUZnd4MmtLbE5s?=
 =?utf-8?B?dlZkWU9XSzQxMHkwZ0pzUTVIaVpNZGFheUhtMVJFczBnQkdzc0FwWlU2c3JI?=
 =?utf-8?B?QmxZSVo5U1V0enNoQytwd2xadE1jcmRpZFFmRzRUUUxpMHYzS1RzdVprR2VD?=
 =?utf-8?B?UmVoV2tYSnBYTGNaVHE1QVcxL2ZTNGszVEdMY0szaU1NWEVTaThzT2hxNTQ0?=
 =?utf-8?Q?X6xxqZQXx2vMw0lbRHHGVhAJj69Vz5PM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:29:57.1145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063108f3-3760-492c-0e18-08dcca796872
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088

The responsibility for reporting of RX software timestamp has moved to
the core layer (see __ethtool_get_ts_info()), remove usage from the
device drivers.

Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/rswitch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index ff50e20856ec..b80aa27a7214 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1815,8 +1815,6 @@ static int rswitch_get_ts_info(struct net_device *ndev, struct kernel_ethtool_ts
 
 	info->phc_index = ptp_clock_index(rdev->priv->ptp_priv->clock);
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_RX_SOFTWARE |
-				SOF_TIMESTAMPING_SOFTWARE |
 				SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
-- 
2.40.1


