Return-Path: <netdev+bounces-215685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC94B2FE55
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87168188BA18
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92B5277CBC;
	Thu, 21 Aug 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fe++aLjx"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D76272811;
	Thu, 21 Aug 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789681; cv=fail; b=gbT3bnpqjs8IS6zK51HRIa9nMgOHopUAYWoBBS/LPAOIhzrgjag/n6O2WIpkaATW5/mofc96lvxpzNWsc02HlHHcODohLcl6eFdowVrX0GWEq7AKInEDzZ7vQt+STcZenXaJ2miW2p7LegiVjspl6zusfVwLyZ3C1ibi3YbmgZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789681; c=relaxed/simple;
	bh=xYfGhvJYJ4Z7gCXUxcnPg8LhjFISfGbHSxyNNTJQYug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LjNPbTWOj4cpm+F4kvHrkl3q1xHoCgCaIqXZThMGxULTAd/1xHMLVPy69yAyQLtvDi1GoJUg/sOfMl78dDKxTouqzxw5Mb8S8bhX8lfGtvqjtTIgZngm0CUKR1lu5xDvogjFNv0uoMTqs+ALUD++O0dHGRkSh5NvWQ+qXt28/1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fe++aLjx; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUY95auiBIPNFGgzGwM54PSd8+sr/1JGcKbFX9FyYqxB3p490rEd17ZP94KgikHcoP2HiAbV4X5YhmjUmmygPzVg1yOx21fMOOp5Foq2HoXXOj5AEJQsRWuFhyLE2DUvqb322cDnO3+S1lSQXozXZ3ZGdWeRcm3xVvQKaY30jXE47/04CqXTWrkZSr8xZsrkT7p8envIPPdRJ65Suz6uL0cG4qDWtPpO5ZrT7IUTrhSckGrdCUyD0/zjt3unjcCCKVMugVWsDKKITQhCGJl3lqmiRYuJ0XRH8cHxMlGpjrMi3akixFrsujvDqFdDh2PFV5XC3bp43jAXoROSXWaHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNsRFbzp5Uqorho+SNtebAPUVLrVTAm/c8Hb4xgomrE=;
 b=ASvezzvK3omgycGjnQ6e9hIKp4Q8TU7QA40K4BmMlzbfFT2BuQzjP4U6iEv5apDndxIci7TJNZQLRjEZqeJt3HfDWGWQsjVDc2IbA8g6JZRXmwWV77jWa5LuDqQxWbfGBTkf356xqQ+nW6v0zJyL9dIFDtHoRuiuybp6HDc+eNijBYVAZJ8xcrD5f7mD4y8DbdSjGERZMKKcAaE+45ZunTpSGyij3J+dmq1LmDU7ausynGQPEILWU6JhlCNgwmIbJWHcrFCS9BW3F3oVAKLhTd/uBrl3qdjcHiXjXlwXv1hI0RaJvcQglxRmf+WEWVywYTGGp2OzD+aJ4K/Kow2MMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNsRFbzp5Uqorho+SNtebAPUVLrVTAm/c8Hb4xgomrE=;
 b=fe++aLjxUjqy76FCu7nlNOJnf8EE+ALbJbM61Utgp3xb1dJi7Cj4X9bZHi7sl9u607adwExcyJNSV27oERHncuh78UgYeiTgJ+bXhBJiJtnnzggeBzI0pHKvKmfOvYgJU2TmABnkb2PfDIEFuAt/FjrBLgLnj8C+UuV3Zqu/EG9o6IeE8bI5+MeMBTmyK2pZAWIhn6sd92w8f28T30o/4yzAJfdYQHdptaTXU4P7CMa7b+ncNnPL1zIMKOYQh/DGeMm+5ymcRMAXPvoHRCYIR+78ShDE2tFjgzQsAFFAKyXIOKe7Ki/v3ARWZXiaRqmYx2LlWanTllDAR+lXHypupQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:15 +0000
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
Subject: [PATCH net-next 01/15] net: phy: aquantia: rename AQR412 to AQR412C and add real AQR412
Date: Thu, 21 Aug 2025 18:20:08 +0300
Message-Id: <20250821152022.1065237-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0412c292-a418-4132-962e-08dde0c65e88
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?HlSfpj8zBJ316SeMMjmYENedNIgjFhDkQNI/vJH2zgpstZUQrjmpYZ6Fvgvc?=
 =?us-ascii?Q?IgOeOhxI29IGZOi/ed/sQ1h3wNKTDGMcSVskxs+PL3kSGV49nctH3coWX45+?=
 =?us-ascii?Q?oX89R9zzBoDLGx6JaR7olTQ3gRZdWyn6XqO7t1VAxHY1pPHm7FVy0OH8P1vm?=
 =?us-ascii?Q?8izyfOTE43pIPwW0KVc5DD/WMkJUO4J10gqiJDo3MdFf2aBOUeOo/xWCS+6z?=
 =?us-ascii?Q?vk4DYAzvp7dgqWbvuRulx23yK6AU71lI8ty1/qtBiS4jQyW4bR9AXMfOfIOv?=
 =?us-ascii?Q?aEH2hcIkFYLEtUqNP7Tx2z+K1akFhw0PT3DY0MmYH+BQ9NNwa+NiSLfDuXc4?=
 =?us-ascii?Q?dPxX05PpQTo8jYk7NHyDLVjcEeWODSmywF87nRHbE3qtHLe2zPO9qyHQC/re?=
 =?us-ascii?Q?9/Kne+Uh49YihE8UkR6dOXVXehFaYvfnlmzE+hHVWubMqSYl07fviGO/C5eF?=
 =?us-ascii?Q?P68DKiSS2Zn15bDQ+8WnCHwTo7RhvmpCx9fSzT20d74ZwbJ0ovfffumdVU/z?=
 =?us-ascii?Q?S0m7wSD2e7DPZjkDUrnHYudk5jiRoGeZnIV7QfAa1JJR+3vR5w8pyXIBEtTv?=
 =?us-ascii?Q?4GqpDkkTW80csOmrsPqy7VI+uRhkVu2ZjmFAXbxEjujnfhH2FojT/vmT6Hof?=
 =?us-ascii?Q?xonr+FFZwG72sD2f6Q7C1yWdM9Nu1uKzx3O7zVlNndwEE3EugRd/rU6BybhY?=
 =?us-ascii?Q?TAGxd8RdxcjqfqEowPpt9lEdNDiJNp7p2NAFKAKvNlTBk18q/Vjo27fE771m?=
 =?us-ascii?Q?cq4PiK8ziSu7Z/Hg4lwGfGbuaQLAQ7Yze72LXQRGakCYI/n5/z4gp7FFXKPV?=
 =?us-ascii?Q?08a/xHWhnnmYXlltUqOCkJPKxqaYgVTN78xEu913tBSidaIQ81NpFLNJUO3p?=
 =?us-ascii?Q?pb1/oGDOsWb71roRhZ+ZJvN0KTQcRX6nDE6eDxwzs/5xQLpFuA0Zoi1Hm/L/?=
 =?us-ascii?Q?brM6bq8wp9A5Vs4qMK2sK4GaEg55hQpmGtLdttY+jh0x7LVBnwVKAkMQ+ppg?=
 =?us-ascii?Q?5sO0pU+5zv3PZblGHkKno3miivTYhVgBenErBHDxGnI3PN5PSd6BVLNNEpaT?=
 =?us-ascii?Q?5/oEYmq2jgVjdvuYe2M4iRVj3+8Ky+UUEw5zNAy4Z540MwUUVXODb46LS8ny?=
 =?us-ascii?Q?HXf3VVQJS6neMcC0FVXtxZnnYTjOBjEoaKLbIjWcPY06UYXqlTHOIhQ+tjbO?=
 =?us-ascii?Q?qjQhUdE89l40eNkZNhA05nIV6fcgRZ5IDkYVrhj7S3uoiSEkz8LLF7202UZz?=
 =?us-ascii?Q?BAQO0FJUetey2T5T1WJNv16eMHESGUYxHagUeCjO9MdB1OBBKuOToHiNTSmf?=
 =?us-ascii?Q?wdQeGcfWWNTvHuEqofdwNX/QdhORLRz9sttl27/VUkdI0DDkZyOGAJZbVnpE?=
 =?us-ascii?Q?GYk7hpG1HZcUTgckUmQkLOgAWzfOuPO1aeL82Y8P3euSaQad/3h+oIdzQU5n?=
 =?us-ascii?Q?s0n1tA3EZUMeoa9GPFKJmsYUZBIw6dDHuEEQcOVas1Gd5wYhYbZmJg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?bGb96i8j+BiDQycjboRdAbdcIB6DDqAwg2XnQbhWHmHBMaXLF3Y70DNroBFx?=
 =?us-ascii?Q?EoHvzU2fIQJrGyP9RwjaWfwjfp3RXwg3qAUd11kIIiuXtwa40Qkm3lFewTrn?=
 =?us-ascii?Q?hpPsFBjh4jBu+UcY0CTSItE5EJ4aANQX2o4DVbdbdXXDA/uGkbx2twcD50pG?=
 =?us-ascii?Q?uvvalw/ZZAPGENIAinkWdNwE5/1/S0GZk+bUa2YPKOqR/V2AuRTYlaXGtF5q?=
 =?us-ascii?Q?GTUBYqRHnjDJCJMzU63ELng15puBn3Etv9thrIwxa+MfdhvimDH0DIxk6ekP?=
 =?us-ascii?Q?Cptd+F455vKruwVAi4DATVf9E7JaXTnSFFGkWplI0RS2LvqthnwNijq54y23?=
 =?us-ascii?Q?DyUDOsVKtuISFlPTGFkNRWMBKb4uqyEMcqaQ6A5PmMDgXtJU0h26k5SBDFMr?=
 =?us-ascii?Q?7BhhjjGOlabb04pH40rqEEO+SXY0kcLjQfXryWkAbjmjVDOv1dh7jIcxKWMS?=
 =?us-ascii?Q?/U1/eNE4mDoONOtLR75B2eexRBRaRrmPH5Ax7TwRpxCfQt4zmxWLCa6C0Cg5?=
 =?us-ascii?Q?HQTnTqZ5iZ3g9QS8pPmFhuz2+wjP+Jlz8qzJB2ypdzy7vzw1XBIqxeFMMRIc?=
 =?us-ascii?Q?L/n5d7g34FBubKkH5JihisDMCShu9fgUI1E67EiZFfgrN0jmMWQWvzqGyG4Y?=
 =?us-ascii?Q?7BA9LUBMFX0dlB5HnT3Hu35FNqPfM5IjjCrkWGTpq5l2KjuvOzp/tCDVCFWD?=
 =?us-ascii?Q?mKf2ucBp8w3n9/q7xz3IIqmYNzJze5Yb6wcRQcKeGLqd4OGUbb+J/Zk9fGBL?=
 =?us-ascii?Q?m3nnfgoveVwJ5QcwI4+FUJTtainCnAFgu5h9HAYJYuTnUIcbwfrvZZClk/jk?=
 =?us-ascii?Q?MhAnvJAf0/GqSj7ioz5vIdVUJwGJgzP8YE0Xrdm5BBmplXrmBe8GyDSVCMaZ?=
 =?us-ascii?Q?kQxj08k2zez5BGKSrmejZW7ca246v5oCvvsbsnOYz6PzoLnT4WZbvy/cnEXk?=
 =?us-ascii?Q?hVbJC91f0S80IL7x81t8iM7Bp477dN3KkDih56/kUFh7/zSQdpQ8Fs+6nrm+?=
 =?us-ascii?Q?Emi3uR+1jjOcbbUd9OTysB/ho4UdGVJsQOA8xTYSnI6OIk+2XnqMmSLQBFJX?=
 =?us-ascii?Q?Ebac2CVBN4yq0YrwZP76xaYVsB3GGpiQHracKYr1O1znGHen1lQ211GF21KT?=
 =?us-ascii?Q?vPdeIsGhW4tMia+Ncdv9BHAwAR0RfUJ5rhuZhm0WV0Zx1TrRxCKOBzio9qOG?=
 =?us-ascii?Q?sSxr8vhCd2IAGCyg1oWDmR0kVt+m5Dxj7v0H2ht/KOvycfPWVExNg6ZD5b/8?=
 =?us-ascii?Q?bIehwld05RRbw+pPqYygAp/SnSFcoVt/JjMXgo+1Ya4CM+6MSfJrtPgbsmPe?=
 =?us-ascii?Q?MayM0YY4wBsHHzZy5cCyqJG5vt9QBFz7BBI5RS5YSi3gsiHX72t53pihxnQF?=
 =?us-ascii?Q?PVaS4ywpbcPY18c9VIoMuy9plRrA5Npn0vZVFzjgn0CKlsLggJZDdzL0W8x+?=
 =?us-ascii?Q?R9v/mr53kPmcQBgTK4Vr6UUyCkxNeT0NOPO/m/+zap7/LZcjwNnMQ33xozMZ?=
 =?us-ascii?Q?4MY3fFTafeJNdxqH7rpOQT0kSV0SvFsF9+j9VpFsliq8o5EAP9kREzhHyae8?=
 =?us-ascii?Q?9MFooJhb004i5kxwG7UYftzj/CWhzYWCTyotR7ui?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0412c292-a418-4132-962e-08dde0c65e88
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:15.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVnCJICbXhZGb1Ma7tK+D9G4IGFMc+1CLC2FGsPia3ABuCpx4cpAXLTWN1lqnW3LaGkMqpN52zznectu6CCmKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

I have noticed from schematics and firmware images that the PHY for
which I've previously added support in commit 973fbe68df39 ("net: phy:
aquantia: add AQR112 and AQR412 PHY IDs") is actually an AQR412C, not
AQR412.

These are actually PHYs from the same generation, and Marvell documents
them as differing only in the size of the FCCSP package: 19x19 mm for
the AQR412, vs 14x12mm for the Compact AQR412C.

I don't think there is any point in backporting this to stable kernels,
since the PHYs are identical in capabilities, and no functional
difference is expected regardless of how the PHY is identified.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 77a48635d7bf..52facd318c83 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -26,7 +26,8 @@
 #define PHY_ID_AQR111	0x03a1b610
 #define PHY_ID_AQR111B0	0x03a1b612
 #define PHY_ID_AQR112	0x03a1b662
-#define PHY_ID_AQR412	0x03a1b712
+#define PHY_ID_AQR412	0x03a1b6f2
+#define PHY_ID_AQR412C	0x03a1b712
 #define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
 #define PHY_ID_AQR114C	0x31c31c22
@@ -1308,6 +1309,24 @@ static struct phy_driver aqr_driver[] = {
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR412C),
+	.name		= "Aquantia AQR412C",
+	.probe		= aqr107_probe,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr	= aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend	= aqr107_suspend,
+	.resume		= aqr107_resume,
+	.read_status	= aqr107_read_status,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.get_sset_count = aqr107_get_sset_count,
+	.get_strings	= aqr107_get_strings,
+	.get_stats	= aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113),
 	.name		= "Aquantia AQR113",
@@ -1446,6 +1465,7 @@ static const struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR112) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR412) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR412C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR114C) },
-- 
2.34.1


