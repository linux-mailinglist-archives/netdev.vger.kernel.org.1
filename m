Return-Path: <netdev+bounces-215694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03850B2FE61
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62C6189652A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2F2FF173;
	Thu, 21 Aug 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BlkLz9n2"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4EF2D838F;
	Thu, 21 Aug 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789697; cv=fail; b=AMx+M4wVlxvwoMJVIU0R35QZcU9HEWId7qCO2nycGwll2g2mtLO9KPV0bfGJQrnx4bS1PT/jJ4YQm9FJ50ie1FZjja94AN0XFjZeSwjnUOkj76hULahkcC3+8JXT5dMDHBDV0GNdLMudL3WpEzhzUxgyklMzlEYWNj+lhIlkFF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789697; c=relaxed/simple;
	bh=URhBXeEZPcaJCtFJcLjNBAAwjocY+Lzucjx2EpnGtfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TQaTLDnu0wS7zRZxNjetXNxk6gK4CgxaIoL9Ui/GbZlMu0w1HT83vcV1nC1tDfZ9ED85s1m9WAose85zYbqKm7GSiymcooB8W5RIl9X8omasV0hAiLSlN5oaPXIMJsuhPgEvVsGab//iw1S61KzuDW2eDEO6tOzzsf1k94CEnas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BlkLz9n2; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exaAnevl7I4+2C5vZVfWg4BSoTK6iDyiTDgwLBOcH6F/FRDLd7O5GRn87pEjcLeQmSl6/zbuGLoT1QNeWqL66NgezyIwpEBA7/uqLOfbawiK2EUhyTmYVQm8mFb94DlFRHWkdvLFN4WIUs5fQoXswHWESUQiSTUkTw1ISJ7tEH7tMTipiYjOZqfFpsyQ+AplsK6U2bpRETOddVWA9IBui6d6ImYuR4dI4i+eCxWtO3CCTLM5ynulvWqJM/0+teSrVq83ZTr6GAFxyoG1M7kBH/tCD2KlIiD/PjP5JoHJp1+aGHmnW4rSJBAUTDphQGSEpH/1nT2ZaTEUSs46JyXfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqU3KzRvvvj/A3kUcgay9ejkMOhBRysDiGy4mM1RZxw=;
 b=O+5fRCbVxqQEmdSZQn3akwLkUE18U/wNERL7qcAOmX9MSMHRgfCH9Segxab5wto56GcLSFaCujtyY21cqeqM5jEI51bQwChrMkayZEDJ/PnXGYQrbYLsKGa6XxYpD547Vc84CuEl/GmIvfHwLRjKoA9mUS84qlCT7N75cfuNiAh3/ZAZLmbqQU45bHF8S4MZCVofozPLH1d+noUtBRJFPa5rEBDfOOO9ZP0Agphw+jS1Mtl1Aepcf3ZMaPlm+K+c3wLFZT/0mSiPzGMDrnf6bLu9lKzqRFH/Pl4bjM4CuRV9sGahmwhgKqsTxEQMyHvKUYadwUNrzPM8YUvrtpuVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqU3KzRvvvj/A3kUcgay9ejkMOhBRysDiGy4mM1RZxw=;
 b=BlkLz9n2bhnSfNoFXzUDunc0+vINksLAloKMtAKVJDSxKmg28FQYgBvY66OihMErBK3FtaeHKQvlVOPAQLnobpiqac+45o427kEMYGpLcVTfJnm2ivDPFYoLNKc9em6C8OQs637mbfgF9UNKyaSxRaIQJnlj3t181kvRdxwhHMd4UzsUQQl0DuP82FAIiI2+p2F8sBy7rA1kZ2Adp5ZGuCQhv6bM/WdMkBWzNsqD76Z+axcQeEfsxqNhRx6xyqv2KCaKffcaKFyvBTb5+PK9xkOi1rzbK75O9etm9HAWHRI8nX7F0YUU5sdmuoflBn2r/TksZrQHt1xAjOHS1FjfTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:25 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:25 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH net-next 10/15] net: phy: aquantia: call aqr_gen2_fill_interface_modes() for AQCS109
Date: Thu, 21 Aug 2025 18:20:17 +0300
Message-Id: <20250821152022.1065237-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::8) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10809:EE_
X-MS-Office365-Filtering-Correlation-Id: e90975d8-433a-48ec-f095-08dde0c664cf
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?sO+li7kURc2njU3ywCbt2U9J+yMO/yxutCRFL4S/hK2ehV2R0ZrudRgKhbqR?=
 =?us-ascii?Q?sTVtSz57HhzcQTPAxccD5H2tj9T3pjgfWBJatc2mnZEMQVnqpKJ+qh0AvcWE?=
 =?us-ascii?Q?vjj5zWOUuEoyFzJZR7C+Cv+6cMcOpFDH/iOXF7KdxdXl09Jw6wcpxj3h5U8G?=
 =?us-ascii?Q?zfeJfrk4/lxWxglKR64DBQ5v3iaGpzZ0su3qkhHtDrMsArGVdT+Gyupull6j?=
 =?us-ascii?Q?VzJhNayzx4vjx41vubjkUHxoqo02AguWrRYNh5KlFIGXYLYwWPo4iXrkrYQB?=
 =?us-ascii?Q?vakWiBxgHHwnhSHlFpqAo8L5MTF3J6tDAGjkXYie5F+LUfnwgNN/TzT90yLJ?=
 =?us-ascii?Q?DevhLB4r8wggkbURcPEfAQJYJKjp4Rr7WS4I93ZSaScdB4nStCXxfV91bnto?=
 =?us-ascii?Q?H/ru5VW0BwtQwtVY+sHzcygKvfLLQ0pV3RtEdR4TI8XVcuicYnqOHLM8KQ1B?=
 =?us-ascii?Q?ugDRHuEqtcKb5eL163vZcKA6/slJ2kfz/m9qCEBoaATvo5lVdeOb2TKrYJFJ?=
 =?us-ascii?Q?W/fa1Pf4wSIAHn5Iv4TxtosfBzTKYUMJZ4daqyK3EztojSdHUnSX82AxQ1Jg?=
 =?us-ascii?Q?bmGN10oZ5Ml5kiaZy+kvkzO50QILCqNdAhdc+paMTueeWBrhhwfZY9kqxkTF?=
 =?us-ascii?Q?vLDa7aa2NMJVmOsgvJ9Je/Lkr8VFHkpT/5Md4FA/5pc/ll0QMPd7tGcSzqZG?=
 =?us-ascii?Q?cWdOhGuD2UjgtPJyy/PISKhjs3rRUr4c7pA+ovA1l7GPlzJPuszBRXf9i7mY?=
 =?us-ascii?Q?R0lfRar13BFymg3/imTt2Pgu8pbdWTE5m0by9XIKPb3beBHulRd1cU2/VqkX?=
 =?us-ascii?Q?BC25Ynh8BZwej4VmUoWCGL0mnL7/oyEUbWUIFq1qqSaiUQoAcZ0uz9TqY877?=
 =?us-ascii?Q?VjsHk0qYPDU18MuVuEA2frMkVJg3dE37CIeaZnGOCfTBhOTGQ00uyNjn5+1w?=
 =?us-ascii?Q?/79n5zqxc8VXKut52wmabKbwznbm7NGCjvXx/vSkeVGIzSE4sPI5Cui4Ybib?=
 =?us-ascii?Q?v0NEbbdv70cOj8tg3XKx/xyjlcJGAc2hafzUeIQ5K0lPumzZt/2czo6lbgDf?=
 =?us-ascii?Q?GfGCnhJJT3kO6saYztzKtdC/HPm7D2EkSvBK0UwnH0A7u/JvoO0CDp6PcoZ1?=
 =?us-ascii?Q?XNprFnR3btz5UuE5wNOfeygNUuHDqXAxusBY4KcTXFEmI4htYxTnjqhXcCwP?=
 =?us-ascii?Q?PgOygArYqaA2VtxVOHR0KbrQhGriRdC9xIMPiNllwHmZi63pKgyvpXCDDSKp?=
 =?us-ascii?Q?tNwF0iFZ22qcXYB6WiZQIzlnByWMrAubK34fTnMuWgoPjPX8SemraTpp1Dd/?=
 =?us-ascii?Q?HvfiAw8KDcTu2RmHW/spBSWN27N2b/XRxYicWTiEoiR106s2JAClmorCAnH6?=
 =?us-ascii?Q?Utlt5vtG1uonGEO5uAsVlhyqJgTH5df3aCRGdwuuBW3Vc9EsKmI/7SUg0hge?=
 =?us-ascii?Q?+JInvu9L5zm+8nMoQPYwG8jyGzV+OwTC2Ryg2DgT7x/t2Tz6XPvr0w=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?9YDLDyoHsVrxqdKNi1mqELsiLQJpe01+u3g7cLQvARCBTO0IDPlqdkzdgu9+?=
 =?us-ascii?Q?QSgeQZun1qhOyvC+k+lxNzVO9mvztRZHE+C4DkFxFvrJSuzVMMOUItxNhiTq?=
 =?us-ascii?Q?WxFlthEUoeLPCCyDGHKbQF3tZJlPm4m4kIIbvAUsTkCnnjaYwB61tmsPbzDe?=
 =?us-ascii?Q?neTYfYqJljfU25jn8IycUdWb/b1anfEcQmeplu4DlDBkg3YPwB2y8q//VvQk?=
 =?us-ascii?Q?FUrH4jhIjvUFmqUEHrUXQUDEp4oNGNGXqic2IYNtyCJsduJAYc9Us5q00Ytq?=
 =?us-ascii?Q?dfBXBl6IluTE4DZ2OTQhA7aX9xjdYVtIo/y5ZHymG57Eb2v60V4f/UXJDNy6?=
 =?us-ascii?Q?bKEmO3NhMfPAn6X7g0/r1mbJmlMqNycCOxdBiP29ucSC44821vMXjXaSG7sm?=
 =?us-ascii?Q?ne8IqFdQq5+iCOCPVr5QJPQUCVKAB5j+Ldqm5NUkj9nYRLrOc4qNf9NmONti?=
 =?us-ascii?Q?RkV6AZ5DfNLJ0KDRGJ/ysT8zg4o9Jy7RnHen+qMNTlsHDLfC32Qhjhwclpp3?=
 =?us-ascii?Q?GNKlpNhsFK5GFavcw9a0FPnfJp3uuqFliDQDZWy4wm7d+11Z3OadXijVzwhN?=
 =?us-ascii?Q?mF+03jcFrSJ0N6DBbsQLuy8/+BVi97arXefvtyxTZITnH8zFpId5G/GLGuw3?=
 =?us-ascii?Q?VLVAfnQyBHS9IPRZRJnZQ8nbEze39n5bYG54zMeiHLJ0a80qxvolPUSrBVQq?=
 =?us-ascii?Q?zvaoGZSS79hVhk41QPWq1ctYn32Crep5GG/U28GhdAJNWvt/5VdVp5bX0kfr?=
 =?us-ascii?Q?JFZFw8bJD9k4+7LqCRELnet5pY4W7klMSb/sOnk4g48Rw6ZXpwN4ai3ZI6PN?=
 =?us-ascii?Q?sHGK044hStjkVP0twuanz74HrvwViQHVsFy3KCRZcylejcDcb8h+tesCZ24F?=
 =?us-ascii?Q?tZCCmmezYAq0Xlc2Sesk3+0kjPGVXxeO9a3phhnt5PvDnlAs6ozQYCiXxehd?=
 =?us-ascii?Q?uRqrhxvOBzobtkvH+7pC0ftQkbdx7f9469gTXyz/dn7HxpItfFNJerOaM75a?=
 =?us-ascii?Q?BsJwFHycheHZsJYJmcPRAUdBWPd1sJ0aOQOAldGhzwpLWzlmsTf5MUL5LJrJ?=
 =?us-ascii?Q?VVjmT+AA86kDEUAKapEXHb7VE/oxq0hC0Fi1eMEW13te9OJQsVEJj5mr6Bvr?=
 =?us-ascii?Q?p10C4wYifQ2KgIqXvR3HSjgSWfF3m2Mpoo/W66QUJ16/C5xjjNtcc9brnUDd?=
 =?us-ascii?Q?Z6OH7h1ECrQOY2I9TeV4K7tKgyrZkSgn+pQwdonLgAz3kIHXN0okuOFIt80/?=
 =?us-ascii?Q?eQ8kfCWTMS4LYQ+OwjbNCFzaIuCoRSOjN5Dpmzlle8IJulcCJ4kIvzzNwA6p?=
 =?us-ascii?Q?eASogw6QSLQTvnQ+oEuyUl+gGTISdxFdwZsgn0LxiSDQdTjO063C4czgT8e+?=
 =?us-ascii?Q?Xcp5/IGlsUeEf8/LSN10McIT9yuZWhCOkswtHQfP3JvrHxQnX8D2PZrRuzhm?=
 =?us-ascii?Q?Nx4dRD+SSB4PVJcV+x3EZtMg5A0mJcxAOPCNs6Eq0l6HeeaFTUxdcGJT3WYk?=
 =?us-ascii?Q?9Bn4vSK+p9mXzYAUH5yAMLcmYZnJW5iQLOr3I9nLDJuDXdj0GWFOs0gBdYgl?=
 =?us-ascii?Q?+0cKBHC75tftRc3QfSxOtgmNBnOpDivPbACgKkRg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90975d8-433a-48ec-f095-08dde0c664cf
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:25.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNbPUv8N1dNldPX2KwS65vQuHSLIIQYGSPFJuFOahkAVl2J3GDW4USuZBuSojeSUD8PTh3FhQzNGcyfJrGTWbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

I don't have documentation or hardware to test, but according to commit
99c864667c9f ("net: phy: aquantia: add support for AQCS109"), "From
software point of view, it should be almost equivalent to AQR107."

I am relatively confident that the GLOBAL_CFG registers read by
aqr_gen2_fill_interface_modes() are supported, because
aqr_gen2_read_status(), currently used by AQCS109, also reads them, and
I'm unaware of any reported problem.

The change is necessary because a future patch will introduce a
requirement for all aqr_gen2_read_status() callers to have previously
called aqr_gen2_read_global_syscfg(). This is done through
aqr_gen2_fill_interface_modes().

Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e3a18fc1b52a..a7b1862e8a26 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -899,7 +899,11 @@ static int aqcs109_config_init(struct phy_device *phydev)
 	if (!ret)
 		aqr107_chip_info(phydev);
 
-	return aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
+	ret = aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
+	if (ret)
+		return ret;
+
+	return aqr_gen2_fill_interface_modes(phydev);
 }
 
 static void aqr107_link_change_notify(struct phy_device *phydev)
-- 
2.34.1


