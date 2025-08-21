Return-Path: <netdev+bounces-215696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06077B2FE79
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8982362719E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431E321F53;
	Thu, 21 Aug 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RDsah3DF"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B63054D4;
	Thu, 21 Aug 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789699; cv=fail; b=uh3mK/e0Dy1Wwi5fP7z1fCrU+QJhN2r67cLw6smQuANnDE+0D0WWQM5zmfS7QTJbg/KiWyTtFuu/SbhynmJ7b9u5sfBCkeZDCg0KV0fYdwL+A2JAbnvNMX5DV5lY+upfASHIotTNeSRwzYhksntqsZexstTGBwOa9ix4BgzQEVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789699; c=relaxed/simple;
	bh=co6VsInbnDGYed4iTrH7qXBIta7xf+LfZfAPldVjeaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qLC+Xhi94mA4d5ot5hrycr+7T2qNYoOjw3KA61xXKr8HOeWPuCDkl1QY4Ve5D2lP+Euh50p06CzojrVFjyOh5Yec6vwt5os17u1CLc04RChgJdDNqxX19/oY01CsbVf5rv+ZxwT+2hipM0nglDM1YXzUrNN84C4Mai7kbaAAdLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RDsah3DF; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8bVEogo8sBuck2gBT69+bnri3morzbvtcZ8IA9FZtJQBhvnQU2ecNjO0yE+/OZVqOOHEfnXLd0SSonxBwzxG3fIx7uULANE4ZP8PLywVqMK+/8qCJknu8Lkjm+lWF3YOYPCG7GHJF5bjAVLfvrI9GVyXZHHZV/zxVJUWbAblCz3A4EmumWHyjCx6KiF4LUpGnllTheuXz1D1t3i9ipJCXAwJ61uKaqMSb83BpxCrGfyZTjbMSqVQRajBKBF5G2w0jWU0sWYzK0yISY9hS5N7ZiFcKdS+EAYQwfb0Yh3jkAyuBnF1wjfR5TkQxie7rmFbsm6Z/MI0DY9ajbb7diP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoKxtB6Iry6d1afltzGYemty+ey//SBQmaaRtOzx+9Y=;
 b=lb7jSpJowMigWwP5Kb2keUlF/XEP6vXMHkVcppiInKsYj/vClrSjdxxPAjIChgUOOiEoZzL2oy+Ed6sD9kuIuYZP4GCfKETIZF5pkrnI2B7eR8NsmYpoubemAPMt+q3bWabIBE/eFjBEnrDd8/VORNjsFBl+0KHPHMkLNClkTUJDcB064rx6TiWIVuZw3OnvNb5TO9mwRhZ0fTVbdqun04GYjC2xR2N/s0FV/iZvEacaT03WZhGuAP6gE4QHpAV21oTWDYjYLsdZX3x5uylNDV9u0kwgfFMf5nNZYGjqzKLsZaCglcS02jxRNJTWwpG2FY51VSkqLYKdV7vcwk7BXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoKxtB6Iry6d1afltzGYemty+ey//SBQmaaRtOzx+9Y=;
 b=RDsah3DF3CH9IMhJdm6KyOOTe57HFRv71Tc1tG8cGA/D72O9fAPKPTY5Cvh/2OijbeaEu+McrsnQLMM5oCQsaxhaohgI9CPLd7uaLx9tSPkkLkEzM4FqFnyPOjcxhmuRGsvNrc46wYzOmthDPsAE4KX82StFfTgJYFo+EwdsIvi3BP8dtfMMhbdcXF51KCqe0OWpgew3qfX9gpbtvszCRkiYg8osHEMeS472D2P4RWtd3L0ORaC1rifMyOHDVcEgB9G+gLQsbukLNd7rwpRXCvUMx1mpO+WAviZ7Vh2vtc7sKY0htidBoI1CVt5CW3Pb6CabFjNwY8VV5L1W263GPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:29 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:29 +0000
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
Subject: [PATCH net-next 13/15] net: phy: aquantia: rename aqr113c_config_init() to aqr_gen4_config_init()
Date: Thu, 21 Aug 2025 18:20:20 +0300
Message-Id: <20250821152022.1065237-14-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11ccfca1-2db8-4e09-7d39-08dde0c666de
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?qqOqfCN/GHgGeSVPbuxaa7kPeWsxEyBvBK3ceP9TyNgSeHgk/oEcwVHZ/1h+?=
 =?us-ascii?Q?kJdwDEJW7byMXnl/UfNEAgfOAXBkamGxrXt3DCkzAxYWxoxLqAkYiRsn70kw?=
 =?us-ascii?Q?zsIm4149pq0Efloo1MnT1+xpP1V/zqJZ7ACOhFPzViFtfjr0T3YhqqkOKFP8?=
 =?us-ascii?Q?FB4Cq25x7boJ74zjaNflWyeF3NQ6/Tpp1/ukddZGGqjM+LiBwh4DWO1BYKzi?=
 =?us-ascii?Q?JBvzMns4WAGVaeLtgdkTEJ2tI6D88Lew20eGCBB1XHwZkyl+l/W+BLrZH51X?=
 =?us-ascii?Q?N22kesuMROXs8vlXOogl6fo+YQ+Y1LpA/OhMjMPG6uWfpZlAHyIC48miTI+8?=
 =?us-ascii?Q?s+pxO/QTnc0mkPxSGrKpk0eFfInHjofldtLq2UGcZx+NGGy0ny1/sS9R3mDj?=
 =?us-ascii?Q?lPHZgBVl1aHzuFlaJiy2B2TJ73o9c6AaytSyaxNczPba2M5zD/SFS1k7Nr2/?=
 =?us-ascii?Q?3ZqqsKStFddRrwIMjutyfsQSomUncm2PVluJfQpy1Iu8rirzfjhDhlspohMQ?=
 =?us-ascii?Q?0A28c+/pyZGMMCQLXhJAO64/3OnbN8XGEhg+2T8JVDmOw3x20cFBXO8NhAvw?=
 =?us-ascii?Q?7UkZJx/PBsn8KfzuyCBcmdxAfo0d887MpTxhcsDCgbUXqmuLozjUXxAPKzlK?=
 =?us-ascii?Q?CY5AztyZR5D3O7KLUBS/+2ZffNKCe0DILQ2TfGcuD1C6ZiA1ITF9nU+ces0T?=
 =?us-ascii?Q?+HnIgJZ3zkMGgPHnIul2sl3PHfe4t3yCJodcM8uGoGSDTNVvACxmot4nncf7?=
 =?us-ascii?Q?OSL3abmRwR3us348ED5LEkvVC7mRM+HMXD91NfxBxGpDG+PO9bec/gcwuVO9?=
 =?us-ascii?Q?uPtkqmdFJZZiedsX4OOx6cp5+R7RwLl3VpjQYXUPJ+xaMJIcgJYxchc5a6l7?=
 =?us-ascii?Q?iLnq8RTcgPdWJw8f+MpWyToMOOgWQ/7mq2iVG48CqzvrLAvZMWEp52tGhM0K?=
 =?us-ascii?Q?Ok2Hkl8aEX6ukK6A9xWBrVZU1L/AaZrJDinPIQl/sqZhjsBYGI3IZDu8iyWx?=
 =?us-ascii?Q?FJw7RwRyYvu1fvJ5nd/akW0plsYmBPQQvcTUUL9yeqo2i0mEzcS5NHtXq2a9?=
 =?us-ascii?Q?AA+HtIHVoLWXuyj8ASh9SOXLRqtQ6ls1sKy/QlwFdU0sEqGGeekcGzzPRrRn?=
 =?us-ascii?Q?H1S157TzKRsotUorCGuJSxSEk1MD4FTnw4JxUi0RFmBxiNfazddnDgkzbez4?=
 =?us-ascii?Q?lBiKR6nNY5ltt3QsyoMhU3GkUeDPZ44QJs4STjy2B86oKvreKWV55pS/CgM2?=
 =?us-ascii?Q?HsQUNl0wAHlRwlqQbGay0XRBuDS4lVIqAqf+tHo8RHVgdoJQnC1YxlhLKzsP?=
 =?us-ascii?Q?xZbLZQswOK+StXDVmTtckWsFUh8YiannRUeNhCUowMI3oia8pZEVMA4indZ7?=
 =?us-ascii?Q?Fc0M0crCZyvTIaHcoWK8nsjxvN1jDfCXcHF0iSvomng3oAUwO/vL+SxXkGRq?=
 =?us-ascii?Q?LWoSEe0Fvi0pCew+hIP9KDvc+j3NWzl0LZdKK/aeCjqdKsKvsveNbQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?qWb8lgWe+po91PS2S9ogZmyML2Beleflh7mg5b8pyLuP9fHx0V1vtBwuOId+?=
 =?us-ascii?Q?tACfRev6+mrdD5bFCr2ObEyz8cY72qKl7YTRtOdshPemX9r/fVzyw5+2u55C?=
 =?us-ascii?Q?pzLXp6uKdUheN0nMLW4mq4Zt5zUorF18Xak9NYxBC0X1/qlg2dBBXL52wW6e?=
 =?us-ascii?Q?9t9cCMm216BUTxdc/134B1bDDhaP4KJ2rA562+ePOrrFx3c3nNLBweGPH5Ym?=
 =?us-ascii?Q?KhFDIJ6R42MIZBDEfeSlZIqfqWYsK84PyBB6I/d7aHZl6VpwnIZzEXnj8TSz?=
 =?us-ascii?Q?YlCNj28fCVBbjWxmBYEomqMnliYitrhHJ55YTOwvKRDGtUnaAOzL8xXJ7r3N?=
 =?us-ascii?Q?taC9xlk0wg5O2uHAsQpmu7t5Y/oTFu5SdV8g9heYlvwhgjejPLAKEq00EWYB?=
 =?us-ascii?Q?eGitaj3QklncM5wgADH5rzYg8fVkuxs1VOx2L4KcoTyXLQN1keQp3UcnKpDW?=
 =?us-ascii?Q?hG3ChHQcg0UxaBsdjAVN0tNG1LvyDyzdWzxSFLztwTwqgXa489LYu+hxvgaT?=
 =?us-ascii?Q?uuK50bimE/NlhVwNsugr96eMe4YMEyS2/R2aTt5vajfY1kHEdB/x2Uhg5PES?=
 =?us-ascii?Q?73+zRMnbJdXEVuj79uFf0f1+2YCfXnTK1agg9IOVDvbpm7BSRLJ8mzcLwfno?=
 =?us-ascii?Q?M/UyshFQKjR7QAzHNVnluuD9pF6M0ZXciFJV4gYVGE2ps6xztfWjkbhLqv7v?=
 =?us-ascii?Q?gt/O0gekIcCXvHVWXcRzoQdBS4Oq0/e3ldK38BUWx2lPnaMgU08iL2d+BZz0?=
 =?us-ascii?Q?9npAAPzIwRyWgtGQ7rUyl8q4pEWuBZV1WJ1505Kns2KtAAUbWbhrjzqNMlbB?=
 =?us-ascii?Q?HCWfN4OKE/FlFohmwk3hezysp3WIBJkEkNY3xl1KfMc5K4+LfavrwW7PK6UJ?=
 =?us-ascii?Q?/HABb4D3TYwqvkpZTd28f9DjclCBXbLdriqNBBkCyE1dE8JshWza/ALw81CN?=
 =?us-ascii?Q?FtqubmKTSYRY/sqrkjr6ruUtqUcevqxpVcEZ0ySxplS4UZmbFJZm4IY3Bevz?=
 =?us-ascii?Q?d9wKpFejctZlBnv30nEz0urDzpcyi/w+YkNw+3/nkGWgNE/Yv/KgsHD5t4nh?=
 =?us-ascii?Q?ZtL21yQ/zEffNf2eiLujlvLDwq+YBUIMz8qKkjH7KKwueXjnZ13lPkvaA1t6?=
 =?us-ascii?Q?8VfavGkpJaYpKuHZ4BcLdL//KI99Yvf9obFLP9k+0aZVafSJ65e4BL0Zu+hJ?=
 =?us-ascii?Q?70sk8emcvIhfKTebfaZWbdEIA8IYLoPQQvN7hln78VnsYd8C2bazPCW/52tg?=
 =?us-ascii?Q?3SU9fM4K4ZOd3NwH7QNrRUBNpjoHNikgmaX6+cVFav3xVV8z+E9fBO1DwoBa?=
 =?us-ascii?Q?vG0NM1Z2vChYCfXQg9QWZ2D2lRPyUt4Q8ec5TGhlFFCMM6nzPlDodcJKw441?=
 =?us-ascii?Q?woxIS0UzPVUWzlC46aUfdRKoX5kRe/x8FQaVx/0KWoqesXqSJiOdHRl1u8ar?=
 =?us-ascii?Q?kguYWbPlcyMqJl5xUzPCj+sZaFXVSAZaPwiyeEX0CYHKmM03clnZa654e7nN?=
 =?us-ascii?Q?ynoqrLj7BAxVS7zmY2o5kFWG///gIjOZNitQqSvMXoi72OzzoNC90xssnrrN?=
 =?us-ascii?Q?FNQWtPknOVdhsAhwvGhief0L8Xwt/S3PNT8pVIKx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ccfca1-2db8-4e09-7d39-08dde0c666de
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:29.1999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNHLFln/sBKo8MFqOHukSY3ni2dWbWXA3sXUR5ia9R+tC0FE2TfCfZzOWG/pNdTuHxRpByIP+HgILEaTvv7fDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

aqr113c_config_init() is called by AQR113, AQR113C, AQR115C, all Gen4
PHYs. Thus, rename this to aqr_gen4_config_init().

Currently, aqr113c_config_init() calls aqr_gen2_config_init(). Since
we've established that these are Gen4 PHYs, it makes sense to inherit
the Gen3 feature set as well. Currently, aqr_gen3_config_init() just
calls aqr_gen2_config_init(), so we can safely make this extra
modification and expect no functional change.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 52d434283a32..eb4409fdad34 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1028,14 +1028,14 @@ static int aqr111_get_features(struct phy_device *phydev)
 	return 0;
 }
 
-static int aqr113c_config_init(struct phy_device *phydev)
+static int aqr_gen4_config_init(struct phy_device *phydev)
 {
 	struct aqr107_priv *priv = phydev->priv;
 	int ret;
 
 	priv->wait_on_global_cfg = true;
 
-	ret = aqr_gen2_config_init(phydev);
+	ret = aqr_gen3_config_init(phydev);
 	if (ret < 0)
 		return ret;
 
@@ -1276,7 +1276,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR113",
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr_gen2_get_rate_matching,
-	.config_init    = aqr113c_config_init,
+	.config_init    = aqr_gen4_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt       = aqr_handle_interrupt,
@@ -1300,7 +1300,7 @@ static struct phy_driver aqr_driver[] = {
 	.name           = "Aquantia AQR113C",
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr_gen2_get_rate_matching,
-	.config_init    = aqr113c_config_init,
+	.config_init    = aqr_gen4_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt       = aqr_handle_interrupt,
@@ -1349,7 +1349,7 @@ static struct phy_driver aqr_driver[] = {
 	.name           = "Aquantia AQR115C",
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr_gen2_get_rate_matching,
-	.config_init    = aqr113c_config_init,
+	.config_init    = aqr_gen4_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-- 
2.34.1


