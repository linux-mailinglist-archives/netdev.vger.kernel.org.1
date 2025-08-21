Return-Path: <netdev+bounces-215691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE8B2FE68
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1DD604C1A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CE52D063B;
	Thu, 21 Aug 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O9+NY5FK"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254629BD8C;
	Thu, 21 Aug 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789692; cv=fail; b=FeuQP20HIRAFFHbfimBT57xAjztEAh99M4m+2TjCdPaQfZ9JOSaIam52LfXbROUxR4WNkuhyrAJ5pnHOWxNlCzospKaydbC6BWOO9R3+ps9BssIk1u2sj8rEpIHzoDWHdzbLvqxKW4o8BSpY9FEiawTiEGs8Aoz5eAkj+NN0V5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789692; c=relaxed/simple;
	bh=5B+DK4r9PxQ4ekRRSdKjhG5NKdmqq9reGa4H96Bgkro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s9wRxpQLvrEQhTSasZtQ4LJPnvQrDXO2eHOtjkuHXtoONDB3dBiJFMgQ1cr1qBgiqLAkCmqcpxtaRz9zRICUaYUxgNG8OkC/HvZOYWVWO2XpCuJMMXPraz94w9r4ggeOnpx/z9+BtPjbLkvU0SqJtBjzekwE5RhdknwqebRrwpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O9+NY5FK; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPhZLC3Up0MyWUGxQZ/oLIjv20CqLjZ9HB31ZMa0gc6dhtabeZ4Qaa9LzHJ1LPEPo3ie3uJ2aD9Te6bNClIIT4rJ0Ck9JWsY3CXyEW0WkVoAMSMXchBRIFDZHrru33y8yUC2X4EiDhsiVVQOJdGHlYg1ghuc/2rb6TKR1hcypw6i/WODgVVY5rY9TaJ++xQ+Xi8c7tRKQwZBmp7+JwEgVGY/QvCzEQ67fkQdBW3zZBVW482JbRilaxoOJ7l04hZJhHBpOJg4b3l9Qiizepqf1HwvjOUIwLsd4cCLH/fcxHegYDafWAvqKtybHNTfuINGLewuByDpqJZuWbhuW0tiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OqWV9HelAUK78yGjQ/mFuEkXVHE4YqX22bC6RJgKg4=;
 b=RFbkk+PwrctCELOsqQMO6nXcMEIamCCywS9yaNCnX02iC2EH1CM3f8KCNkGWkzzP0IcKM+XmWIznbrb38PpEZkla39pZjsQsIp59hZm21nsw1HvgRI6rLHyA283L6ZOunM5+XVFzrBuQVprfQYmXQX+ErlujkxtJCZmq51L62mVr+ClICJQbgif7RpfaP1y859lb4ksK/2/aOghKbsSg9ZJ/AeL4gtacdenJYwlXJhBx3daCMUTYrn59cKun8tVLb5cgzvCJBjm1EwR+l/Agta8EsRyEK03lSiNrfoXA0DD/zWatnpAjbLrzQQCO9NPM+zDxSbw6eGur0kPhlzUFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OqWV9HelAUK78yGjQ/mFuEkXVHE4YqX22bC6RJgKg4=;
 b=O9+NY5FKzBYwbLozUsDHnAsYtd/COFDPhcorNUz/1gY7b3W4sUAv3iAe74QGJnJ2cd47FiPVmX/wR4uGS6fK2fmlUwp3gccbN81FCmhuAe0GgvczTe794SRoqFrW5CC/wj+7MAIKYcAEnp0W1nsqd+ptG/qFAQv6dsZ+gGUAxJalYA6+zqIyEzjc7aHZwhnA/qG0fhwaBRcQ/uOBQO5MdhBpRDe/02sTlzv7p+JJ98ZvqQN+mkNsG9zG1Pne1L7VGNq+LtZnnhodRTngJ5k3jtlnSXKqDrCshPMVFEMpfN51zfBgOgKpkkapWfdpYWR9b5KX5fVOYfA3MLcaYjp+4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:22 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:22 +0000
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
Subject: [PATCH net-next 07/15] net: phy: aquantia: remove handling for get_rate_matching(PHY_INTERFACE_MODE_NA)
Date: Thu, 21 Aug 2025 18:20:14 +0300
Message-Id: <20250821152022.1065237-8-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2642dfc0-19b7-4cab-d006-08dde0c662a5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?p4RjRJKRsUqri0KcwuD/2xn2iWbOGS4vCGwCGb4C11AsEAFyjbH5rC6CDnuW?=
 =?us-ascii?Q?N6Q8mpZxBBpnJs1YX0uX56ZKzmFYvzsb+kDUh+YmSEF4NhIjFUeRnc/G49I0?=
 =?us-ascii?Q?jarrLk+rXzbAv/hZfWSEqKWvm8EBiF4EM4b6ErxrpogcuQbM/EzmuOVZ8wVQ?=
 =?us-ascii?Q?X0ZiOoxFgcnR9Li3gYFiYve9tT2iAcu6TBAeITJt/xn7053moEiFc8NjGU4R?=
 =?us-ascii?Q?IoQ/VenRLopWMD7TJFY3+DPbppVF/ZhcNcAIBB83nJx/nDxoBWaapFAmAGXI?=
 =?us-ascii?Q?SgrGSpLmBQMFVLitkaBQYZ94On91ULdvQCL5h6zv3KNnpt0FnD7gmqqJWEmE?=
 =?us-ascii?Q?um4kEX+mLf1ogzmbzz4ypTXSt6p/n7MDk66f62oPZHYL8dPAw5On2XoJ0eBl?=
 =?us-ascii?Q?ZnuHXpiKSU1Sj9poFP7uo3+cacGCcP67WjmpVnANRsZdUkknXsb84dfZqD/u?=
 =?us-ascii?Q?dbh6tR8FtvENqXU1DJyqb4CdGVe8lDXDio08CBaRm025kcMuCwBXti0bzlpg?=
 =?us-ascii?Q?Oq+/KGzwtvHtms3PGjTcLxKnlJ0ZkuAfCWK5pYWW1PJ1V3h1uUtmZ9p63pFL?=
 =?us-ascii?Q?nehdJXhoAMuiq19IGahaHP1+XvluluFoFmNrS5za+Cl8LdAJrp2HY+m6n2/J?=
 =?us-ascii?Q?iqgXsvztVKV6Kmpnr2KbVF8hgKQq400WFXS34cLsIn+00ZBl89pyD1a8Tvsn?=
 =?us-ascii?Q?4IMOKvla/RDaT1w83oA3gG5AzP2kHD62n4y4vxar9Vk+WqAfPmtEUA6Mf3D9?=
 =?us-ascii?Q?jBGzDz6EB6fqfHvOCB4eN55a279yavaYTv9YSxoDLPE6NGGicfimzaRFz7+l?=
 =?us-ascii?Q?MwclL/MV4hHZafusnlciCGMMrmhcNpC/qvO9XMpgGJfaIrmVI6UkMEJ61U+K?=
 =?us-ascii?Q?OdC3pGhFhe3xc5DwMIl5E/z1wre2YHoL+E0d8DXY3pKdb+Bijh6v3Ed/x2oM?=
 =?us-ascii?Q?8fJeQB1J6/SLEq4UpTVZkHCTFiOP8+3qnvqueLC0QNgZshOQRXmQqk13fcLm?=
 =?us-ascii?Q?MndxPstDAKPFkmE5Uz7dLE0YdoWu4KaX0qc4NQEkhYAxdad5IN9LZP9TW2lo?=
 =?us-ascii?Q?nndZ7JrcUOBwUGwPBWin0ef95OK5CieNi/dxQK6TtX/dNtvrQCIQHly53U4b?=
 =?us-ascii?Q?jR3+ysp3i5hLMXpXrBsz8o9Nmn9i3EowRHYw5/RXvmrMotojsu6zMHEFVx9s?=
 =?us-ascii?Q?DL8SyvmUw3iaWAJQZDybxR1lWC23o+DbKyBiKzq9mzhiJC4UOg1fjE7CbSU6?=
 =?us-ascii?Q?e6ZGrKQ23pj2e6bXR57M5VGkGo8hz29qYm3/0goiLfxJRU/+5JRgtfaMC7Qk?=
 =?us-ascii?Q?/bpJ3/BpNqlonWoz9AC0S3CnO5SFf37AZ088xBAVZoleFZOe4tg+kmIgF88D?=
 =?us-ascii?Q?6cd6DLZYMp87ZeOeYEb+q++0eFgGLFncd/PpnJ1RlT+nXQmQkAR0ZZXHeGqU?=
 =?us-ascii?Q?yUGhUglclfVnMn1pEQp+k14LgW0VcxyQ/lZrBO6tf/M3oVJACDmAgQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?8SjYjcsaxZJO1i9GWLHf66W3CuAqg82gc/ddGe6/2vEuDo7CKp8CrSHB0wmp?=
 =?us-ascii?Q?HFcS9U+At51Mv/7PPB2vnFznXuFlv36Fm8gcvXyy1adWUvjfFj/GSI8wfIt9?=
 =?us-ascii?Q?p6VGXIOXCpguYss/UVNt57F9DRlGP6mI5GOWGJQECmCfVK084rbaBMNhPN3W?=
 =?us-ascii?Q?R+9zNN/IgV5s4kVM4sNZhzLGZD2p8ZAtm4b209Iz0d6kZqah0qfZUFbma+OI?=
 =?us-ascii?Q?gJMS44H5345jxxWLgZk3137TS4HiCvW+3gjm3Sm2hBBu2zhOAWf1TRGuaCKx?=
 =?us-ascii?Q?Pzo5FWHXmqgQG2DiF4TCidi53qMSY/SnWRHa/5b+JURzh/6JyRaAgzXVacKi?=
 =?us-ascii?Q?+NiRUNTKEhhc2ouGQm8/zCCXDb2OPM1+qpiJ/sFufy3CEA5HZ2FVnifZQqmx?=
 =?us-ascii?Q?0YQ09YEIKDW0z8DwAaRjiEbFswbac2wNfISwmFnd+BnoSbOMcSluGdgfWxxr?=
 =?us-ascii?Q?qQmXjbbSIgTdIfqQWbVIqqABpLRyUlrfYseIVZhizGzru/7KZrQvuiCZZydf?=
 =?us-ascii?Q?+NsMbexQkj+0So9JGQz7o1ixAS/jJonfNl7IHtvEC6hCzxrQqL4FI7NAKlIO?=
 =?us-ascii?Q?XdlQ3du30YH9kdmOkaWORLJh4hVGKiMorEMWYicCYl86NtxRjNrtd8PCdHfd?=
 =?us-ascii?Q?FO5vGU5Ywp88fklqyxjvNNkNRuSNO5/qTycP6y90cuSjaDcGFJGp5SOqTAZ2?=
 =?us-ascii?Q?EV0XhcfRNezPI132DapMaCcw4HQxI8QqRvCb6BvkQauSzWv4xnPoPVbDRBID?=
 =?us-ascii?Q?aVdRQxGpkvJRiAAhdy/oYzFPGgDqXoE5dl8uGW3yTEv8MFu9lsVeOeto2cil?=
 =?us-ascii?Q?5GAVJ3dZL1OTiYfr+4iJLYFBTLmv0io7fiiqfuRTVkUwEzfmJ9CdKlPvhWk1?=
 =?us-ascii?Q?uVaKmmtnQ1IILRfeDCWhTqfUZR5zA9p+qE1Z2eEHjqDp5hP/ywa6Gsa886UP?=
 =?us-ascii?Q?43cwPOg4smU0J9Uoy96ev5sIGTvovnTBSyhEZqQCbtOxSaFZEJquErsNvF57?=
 =?us-ascii?Q?VWLGF91p3Z7CtyqtBK+M9IvXZyll1c29JzkBtmr/OFkqyrzmALcmjy8/hynw?=
 =?us-ascii?Q?B9vnYPFDlMn7aEHznti0Qi6meHy/nyWuRAP9RVUJnKwmLgqkB7KpSM1M7IBR?=
 =?us-ascii?Q?AdiN1DMK2u1fkVXvkyAfRzuX0JFprIq5BhqrPsYQ7z0YY6jgxL8YRKikegjY?=
 =?us-ascii?Q?um9j4tABFk7SDDczH9N0hVojX8/w2IMvUorqLrARr8FBaVZlTKPZgERalKLW?=
 =?us-ascii?Q?jxo2pqUNNX9Zic9Ty9DBJyquaSvi5lZzdFHFx+5DKDvHn91EpzqbxRrd+yrM?=
 =?us-ascii?Q?hQjdWz5BSnNk5eU4cmzI3EkCJXM5WSOWov59wYgd2hyR6S7NFoPGs86atkTP?=
 =?us-ascii?Q?UViFOYnFKHqhwKgg1txVtxRGL2+v8JVd1njRLMF7vNu5FwDIZD+2uCd5tfRL?=
 =?us-ascii?Q?Us8HAOXKFnLbE4kD9RYMBssRe2YdTrbbwBDyhmiINxbl0X7jZISjbGIfAVf9?=
 =?us-ascii?Q?W9/Itfip5NFQRFU6ARa/QKrlmUHYt001VBfbBlOsJ3z3TeoBTg1p8S/IH2tx?=
 =?us-ascii?Q?LzbIHCIkJ5waBbdMarCqh6cfgc+9YHHFA0h/TRCp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2642dfc0-19b7-4cab-d006-08dde0c662a5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:22.1623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGAwDlsUzUvbmFdG9PXo5yat5LQf1euy82HFdaaJ+3sUA2j/x0EWTwSHl0uAoz8mnuaTF4jG2GfyftzzZ3TTZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

After commit 7642cc28fd37 ("net: phylink: fix PHY validation with rate
adaption"), the API contract changed and PHY drivers are no longer
required to respond to the .get_rate_matching() method for
PHY_INTERFACE_MODE_NA. This was later followed up by documentation
commit 6d4cfcf97986 ("net: phy: Update documentation for
get_rate_matching").

As such, handling PHY_INTERFACE_MODE_NA in the Aquantia PHY driver
implementation of this method is unnecessary and confusing. Remove it.

Cc: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 9d704b7e3dc8..0f20ed6f96d8 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1067,8 +1067,7 @@ static int aqr_gen2_get_rate_matching(struct phy_device *phydev,
 				      phy_interface_t iface)
 {
 	if (iface == PHY_INTERFACE_MODE_10GBASER ||
-	    iface == PHY_INTERFACE_MODE_2500BASEX ||
-	    iface == PHY_INTERFACE_MODE_NA)
+	    iface == PHY_INTERFACE_MODE_2500BASEX)
 		return RATE_MATCH_PAUSE;
 	return RATE_MATCH_NONE;
 }
-- 
2.34.1


