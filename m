Return-Path: <netdev+bounces-215692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D596B2FE3D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045577BCD1F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B22D3A69;
	Thu, 21 Aug 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lziCOO69"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40672D0602;
	Thu, 21 Aug 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789694; cv=fail; b=bUSSIagnn1SF3LoL7OnU3cN2NI5aGf473fODfZfkOXdr6HpRkZbBDhXqjpKRdvqo5+qODuXqvbSYk5bBxcOY2OiIWbgIdyVuzj/XKI1zThJyv321ryrT4GS9XliLAYwyCWHXGNy+Om39ojTFZVXY76zXJBRwD4tz+hfP12PViDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789694; c=relaxed/simple;
	bh=nC1KYLB14tojumSwhtsj4BvI+WlBNrM08SHuh3vkvas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ln0tOJrPj8EJHSFkzuzMmBkhynssmkyMd7kuGVTsuGQ47yXOc/JnzuDfUPQQxAQQbN+6t2YU6v1izQlzXoIUFWkNTWIY3qgFDV3ZYkdWxUar3+V7YJRtgCBeGYzG/g0aEGT/aDOK7LmKzZPfCdW+TuCLVXA4C1LqPVWy14qHI+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lziCOO69; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U25RhsOHrbCQOqv30CFhCAfDVTUF3Nn7M/WqwEAR7jCzkc2SIXINStcQwjXrJMC2G01yJH2LAB72773R9LGmklMJ7CTkfNm4L+DJw6lRaYTrNX+YWsi91Qb5SLyM7rjWkqKZa8uAcl5hwmmKi97ob8qqxVrjYgaXeAiXSrX6WShCJ/rokY8oZeuoWfvkiqzUk9hGmukojoo63p4o/DxgYZtNqaIGyAu03pZBHanC+GRwxPfb1tp7ptWo8lYU6ZXNIjtA0QAYiOMoV2F+fgKK98WtXQVdtbZkjhoeX7s/l0n97rsYYkuGV7XV7geHv1eGJ/0klmWy865chONo6EfEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/oECTvhjWpHeKsZTLU2pvFnP+KfJsmRffkpmeiIhnQ=;
 b=niAlh4iAFiMIHXepT3mRWdj1KdGVLsSVwyEziXpJQIjXIfsyt8nCV9bsRJkd+0pyzYknhpsgLV1/bJdEIMvDsoVLEHvJqAoupquBrExpKaA/0vALgnf2DMfkoa+jNI9DjSmgCJptnSTfjK1ShM4eQNQtklRupMaSFsh1PGIES3XcDR23YzXOfdQofpyvnyq5+Rkksmi1uSNpB7FafMyHDANpBmIo5goRrHxa1kraU1hMMKeNsDFj0Yz8xGJYWngP0N/U8cmSS8UklqT4PT9H+WSMxoD8i5+B5CRi9WZGnc0YwsC/nIrXd3qwFacQklpbNhzXoCwTduemC0SD5i2/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/oECTvhjWpHeKsZTLU2pvFnP+KfJsmRffkpmeiIhnQ=;
 b=lziCOO69CFJz0SQkUzR+WlRophOOq6Xyzlj6pLoRa7Tr18/mp5Hdgv3ualWUwQYnyMa8chrxaMA4jZbijcJLdrOSnV/vH0n+U+YlC96e1GKH438kaMHA/dudAwxXX43KWdKG7cLlRgNBMFRoTsadf9JjUmeznoD364IqyTjmZhcMzTWp67thhIVqZHQGt7Ern9DMMc8w/YohbY1tM4quP9EQupbBCTONvcvXz7mEXvqpjoorubehUBA0+qamTpB+8HhQlIa6EkgQTQ5Bm6QLI1ovrm9bn4bmN1BDXMi/dbKfdeJc+ab4I4al66pqwxZyjlwW2s+4pOk+i/o48c4oWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:23 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:23 +0000
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
Subject: [PATCH net-next 08/15] net: phy: aquantia: use cached GLOBAL_CFG registers in aqr107_read_rate()
Date: Thu, 21 Aug 2025 18:20:15 +0300
Message-Id: <20250821152022.1065237-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66de398e-0432-4a78-3a7b-08dde0c66366
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?X7DvevI/9yZ2eaFjFtcSCBMLDNE01R9eNLtLAPCxnYWfKo6X6YbcvhCUCwu0?=
 =?us-ascii?Q?8vRuMd8fGai66P6/pwtwEFdFI2TnUaeoUzpWTsF/A2QPL6kA6GF0pXss/1vW?=
 =?us-ascii?Q?qSqnZCmYa0TgF2HCd+MtY4wlMaBZakvVzl0YRf08hRwZqWNrf10BbCdGHqdG?=
 =?us-ascii?Q?GBT3epfmlD6nFM+JyekE2Q2/gMF6Ije8TneKAVo6iMLd20kthCxgjoJ+VOzo?=
 =?us-ascii?Q?U55KO9QPN8qkw8Kr9efhY5DLVZIp1sD+HeathDAJNZSNytlmvXO472N7vO6k?=
 =?us-ascii?Q?MS7nocw8EU4aYupo4G3QGIKMU0E8Azy/Gr5LILCZGD5W83VVLvui1Srrehi/?=
 =?us-ascii?Q?8jgoCokSq+d9nFiLxPWzlBwWPhv+cqEqQZA3+JaoVBgv3e7vfAdOK9etvA0H?=
 =?us-ascii?Q?WdeV9lZaDxz3f6tWCpEfZTVI7sTWMtdtWCJrSlepz3pljfVp4WoAb0qYADc+?=
 =?us-ascii?Q?uMJGnYLi5XnD8P/lER5MixRyYrfNoYyft/ktH21vFQK1EdJZxiKxkzHxo31V?=
 =?us-ascii?Q?s2Ffq2M/oAsv/2PB4gWhKL4OonajEfwU4nKbipGNGg8/z9cPF2v6l6nBD1om?=
 =?us-ascii?Q?tcobcxAaSSRP4oE6Xov7sawv+rWTHiTSR/T8M/MEQtZ7+4CQLz4hEgxEGNWv?=
 =?us-ascii?Q?41sQCe9f5diZxl+1mo6qSGaGlojX3Xa/CbVgO/smUdTqQg50EoYKmjxa6KtQ?=
 =?us-ascii?Q?pm+p9If3gb3Rg2cZVv3vEnYXZdFBmVv/f5JVVEQoaIDIintnjPvm7uj5CzvS?=
 =?us-ascii?Q?sLz9ZEKnqo1Gz+wntoc0L60rK67ezA8fWrhuoJ9sxahciGbIDZldjSzQWtYV?=
 =?us-ascii?Q?KC9GQxsL411aFXRq6+zi8KKoTn1xI7XJgX0wUISQSz70dPlYxZ2mndjMoKKW?=
 =?us-ascii?Q?YIMA4LoXqOke0i1zteeBfVUgVHe0PGmSheMj/OQonEWKseEuMy0kvaJ3Lfnn?=
 =?us-ascii?Q?7Rw4uXJ0kia9AsWiPlblZZBcYTiLczDn19v1oEsRpbhcErP5FEH7I2cftwO6?=
 =?us-ascii?Q?w+gD/femdqiaYvIdVmAqmPQLYt5mraV+P/fWCdNVAn1SRwk3vhrQ2+ZQTrUP?=
 =?us-ascii?Q?tFgKYXlDekv1k1m0WRl0PZWOY6TCP8blasAmHDTzZR6Bi6znfH4tPVX+aA0f?=
 =?us-ascii?Q?g98YnCIYYmfWOiZvbZzxfontlM4C8BwZ25vkOG7h/7A5K43PUOyzNDmJQEKN?=
 =?us-ascii?Q?oIftxXNSR3PV9eZ3EI+Ux5MeMho9oTFibcgC/ci1+iKMC+QAZsrvg0cM/Oo1?=
 =?us-ascii?Q?AspUaBrnI5PZCuEbHdD5/fMimBQ73rYupPCCZCMZjjEkyxTfTvLHlNgrMYxe?=
 =?us-ascii?Q?Vv4NMxJRAA+PeG09RSYC0DTFKIwtnzvJYkyHzQhLzyMS8JYGdg2buPgVlOTi?=
 =?us-ascii?Q?g3hUX28p9ZUIsGgl+HpC+YRPA1pkI3D/tvmaJkxfLbko0TUKMNV9IH4jtnpm?=
 =?us-ascii?Q?IELcSUqUyKPNUR6173qSymtQ/VF6MJC6keaf2IzMalbm1sps8I5h3w=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?jnE0BfY1mH2UEi20eH0T3vUhfLwqTKy/D4a27uYeVS4DnopRr99S+ckFNNdu?=
 =?us-ascii?Q?/0g/p5Qa4FajDdwaHaMzAlFRfN+aHMS67yxNU+mxkfV4VqIAd+ltBkFNTCVi?=
 =?us-ascii?Q?rg8fkhEQZavfHgsdFoPUAaRlT4LWEm3Ho+Ru1pU5rAIsvqn3r7qe5JlD5ZQ2?=
 =?us-ascii?Q?1/XreLb7PAaT0e6QD5qu2uvuRhW5/tflsn6kKfDwCjYA/ugM5UgSg+qCPefX?=
 =?us-ascii?Q?LgK3dT/EYvJhCKKSzGRld2HlsZGF/J+vQ75AdXwEq/W7Cquu4d9nNQwF9wBt?=
 =?us-ascii?Q?qcALA5e17AtzA/e8qal+cqP1N9JYQt6AStkMP2M+cm239AImABJTsfysVlWE?=
 =?us-ascii?Q?n/Z9WYyLlsS4rcUbftc+5gj7qFBJt41gCYdNtbmgb5VwpXqYzy4ghVGoh+KT?=
 =?us-ascii?Q?Gd1e8Gt699+PvrQ4gkSJ53Z8gVbiu0AJ1U8XPtfUzfSCKDyiTOsoYj84MoQc?=
 =?us-ascii?Q?x5HoWoX7ZuuDGZ3HRlS6AtWPPR84BYYNla/bBN0g8wd7j1WwImDA77dVo/Vk?=
 =?us-ascii?Q?HaT65io2HOxCtmsZXSg0EaenshxKovDuiaq5Wlb7QRm5YO3TLl1Xf8EdM4Sm?=
 =?us-ascii?Q?lnRJPIvhhNrzD9d2p9OIsHAJEeybOhmH/f22ussUwC3AXDM1b8nf2eJ2Sc2G?=
 =?us-ascii?Q?KIZ28VFLeLpXlfSoX/45BTIARZb35RC4EjVg12lEuWjQauJ8fm8WfhAhS5Dx?=
 =?us-ascii?Q?OnCEI7OtwQMPfwMxVE6WD3gm7GrL2y1KbJGXpOSmXv4CajyD7YhBtMEpO/hF?=
 =?us-ascii?Q?ixeaq1LlTtUxFTxcg+N53WRBqGCXCfcRwwYzsymFAv+rbJw1vVoYkbwNxGsK?=
 =?us-ascii?Q?2YQdUvg7lyvHaZjbdBiBCtPw09ErfUM2bBgDGbr2aa90tQKp9LN22D20DbhW?=
 =?us-ascii?Q?69wqxVRaqAi+3LTHLv3x063IZaGLyYFLZxJyD8ZtBj3cyxLmxlHSS/LZGvzU?=
 =?us-ascii?Q?LQAxKRuAttOoLyJ+DowrKA9QIksxH+G78oFM0v8g8Y/71mlmrZ+9wVmR2zfZ?=
 =?us-ascii?Q?BYe9QBdG13f5tHS4LDuqpKUsnYdd35agz9NxdKmgrW8EfVBxIhDUWrztiQbN?=
 =?us-ascii?Q?P0KaUWKHpDEnSeChLyBtFr6Y66vvk1TQnNvJNSTHbFODZW/TQ2ZwxouLWkex?=
 =?us-ascii?Q?CyKfXvTsOwuL85xEK7g2FMHnYyY/v6W5CUxcXNRIXXygT63cqkMKbm8llwPJ?=
 =?us-ascii?Q?uoKTHJkaTZO1llwEzLlts9H8q7aTIwHcsFy8PjREkCfpzwlGbHRXijHoZvK8?=
 =?us-ascii?Q?4VZ5LikQL9CWcVtzlzQV7vvH98KCkJQnHf32E38VLj+2i7bdtg5rT4n3kFTj?=
 =?us-ascii?Q?E2UAOzFkHIFiAl6peZ25bZKqEgBhThJEwf2gP32HQ14D7KG78eow3ZxsIAnj?=
 =?us-ascii?Q?9nWF76oet8ZbN3D+Fia6R+1y4O/cu4Wr+qZGFbiq68l2Z9fCxld61Kw6ci7A?=
 =?us-ascii?Q?mmq3EU3Ri8ypEW7d816yGb/zs9QX0yJ068Bko9nC33UvIiMUaaTY4BOQHzSf?=
 =?us-ascii?Q?ddVbJXGBHVDNv3rDZqnrLsDB6UnqVH+6Wqag06rnqq9pVr6FoIhC7v4E9AoG?=
 =?us-ascii?Q?MRR79lesE0LrfVwXbYbmdMJ98r8tpgTT5FPQALaA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66de398e-0432-4a78-3a7b-08dde0c66366
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:23.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfFHYOPDHGLyTly66uQwTwcSdP2bvDuIzMDgxNplc7rNt9f6wW88rsasjU0srOJ8iN3YKEOq5TtKvpBOLjb7+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

aqr107_read_rate() - called from aqr107_read_status() even periodically
if there is no PHY IRQ - currently reads GLOBAL_CFG registers to
determine what kind of rate adaptation is in use for the current
phydev->speed. However, GLOBAL_CFG registers are runtime invariants, so
accessing the slow MDIO bus is unnecessary.

Reimplement aqr107_read_rate() by reading from the
priv->global_cfg[i].rade_adapt variables (where i is the entry
corresponding to the current phydev->speed).

Making this change also helps disentangle the code delta between
aqr105_read_rate() and aqr107_read_rate(). They are now identical up to
the code snippet which iterates over priv->global_cfg[]. This will help
eliminate the duplicate code in the upcoming patch.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 29 +++++++++++-------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 0f20ed6f96d8..4795987ef61b 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -568,8 +568,8 @@ static int aqr105_read_status(struct phy_device *phydev)
 
 static int aqr107_read_rate(struct phy_device *phydev)
 {
-	u32 config_reg;
-	int val;
+	struct aqr107_priv *priv = phydev->priv;
+	int i, val;
 
 	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_TX_VEND_STATUS1);
 	if (val < 0)
@@ -583,42 +583,39 @@ static int aqr107_read_rate(struct phy_device *phydev)
 	switch (FIELD_GET(MDIO_AN_TX_VEND_STATUS1_RATE_MASK, val)) {
 	case MDIO_AN_TX_VEND_STATUS1_10BASET:
 		phydev->speed = SPEED_10;
-		config_reg = VEND1_GLOBAL_CFG_10M;
 		break;
 	case MDIO_AN_TX_VEND_STATUS1_100BASETX:
 		phydev->speed = SPEED_100;
-		config_reg = VEND1_GLOBAL_CFG_100M;
 		break;
 	case MDIO_AN_TX_VEND_STATUS1_1000BASET:
 		phydev->speed = SPEED_1000;
-		config_reg = VEND1_GLOBAL_CFG_1G;
 		break;
 	case MDIO_AN_TX_VEND_STATUS1_2500BASET:
 		phydev->speed = SPEED_2500;
-		config_reg = VEND1_GLOBAL_CFG_2_5G;
 		break;
 	case MDIO_AN_TX_VEND_STATUS1_5000BASET:
 		phydev->speed = SPEED_5000;
-		config_reg = VEND1_GLOBAL_CFG_5G;
 		break;
 	case MDIO_AN_TX_VEND_STATUS1_10GBASET:
 		phydev->speed = SPEED_10000;
-		config_reg = VEND1_GLOBAL_CFG_10G;
 		break;
 	default:
 		phydev->speed = SPEED_UNKNOWN;
 		return 0;
 	}
 
-	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, config_reg);
-	if (val < 0)
-		return val;
+	for (i = 0; i < AQR_NUM_GLOBAL_CFG; i++) {
+		struct aqr_global_syscfg *syscfg = &priv->global_cfg[i];
 
-	if (FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val) ==
-	    VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE)
-		phydev->rate_matching = RATE_MATCH_PAUSE;
-	else
-		phydev->rate_matching = RATE_MATCH_NONE;
+		if (syscfg->speed != phydev->speed)
+			continue;
+
+		if (syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE)
+			phydev->rate_matching = RATE_MATCH_PAUSE;
+		else
+			phydev->rate_matching = RATE_MATCH_NONE;
+		break;
+	}
 
 	return 0;
 }
-- 
2.34.1


