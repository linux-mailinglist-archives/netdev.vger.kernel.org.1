Return-Path: <netdev+bounces-244594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58314CBB0E0
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 16:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5878D3005AAF
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE9A265CBE;
	Sat, 13 Dec 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lj7LO800"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010022.outbound.protection.outlook.com [52.103.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D9266B6B;
	Sat, 13 Dec 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765639351; cv=fail; b=mbqFkl16gP6fT1n5bjjkPxby5iNpb1l+gwsuefXQuuz2XimV3lEgcEX24fI+70NB9KjASwuSOrge79xDORrqNGtYV9U3Y/xsuXoJJ4kA8a2jaFHXBbndsAhhUSFIl51tq3dzctXMjkVpY68brlOAHnmzM6Isqn1PTmbmGMOxKrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765639351; c=relaxed/simple;
	bh=9N/dG5vhi+hc+VdX6Df/IbuRgTslEuO18E8lEzyCJhE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cASxNdwBKr7IJ1hqm6M79/w5w+KOeoHpBrX2LPTpSS4x1vc0DXV2L80abdHVUME8I7koo7u2O9krXtxImvNxHdCb9nZ8EN6NwC9n9Mw4jLnjyoWj64VIO1Sm0vPR1JpS+9vD2MbG7n8wUb8Nvs2IgWOLj+Y4sKubEgfMbHcNihY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lj7LO800; arc=fail smtp.client-ip=52.103.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu00/57P5cT8XUWQ02J5xZIExK0zLPeeatC1lKHBwbIhh1DONeDVfsQMCUCljQieu6+IODHZlUT5NCsUuqRKCGnlngDRVjM8fH52OFJMIJY14JQpwY8pDyD67wnj1evv/VB5HEnboNKo+TEfKCo74NpwFL084JUXp9pQEn3XYGY6ebqFk2r3lTtFdZhY0Ax8mxnkRqEsO5cSvGbOrKAL+uDqQaQmq+qLO4apHuJ+ceM9gHAFmM+20bA+TQB3xm7bY7U0e3dpIbNdXZBCk9geq2B42+QXc1cid0nhQvKJLnh0lzzgH6EoaqCyqntpH6Bj8VesUEEJDHNqHlFxM63CXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2YTbjOE6DIYXSfDTxYhOvsCoboSWhRx6S3w2hdzUHQ=;
 b=rn4UTyIJeLkqSjK34L/+j+NGsm9bgo3mIvLwrzWELCq0WhP8PVH0CTNnKrd/ftOQUI3AVkMh57TXbYEYL1YiPytrusZmNqDlhqKKC2bZTuOSvgvwgwXg0XtnYwcU0QTGP9Zpb3r6ojyG8kEgbVyjnKwlQTjC5DWVEInLNDZxWCjcN1RMv4fYsb1VY21Py/WmYrjGhJEoJr02cSGDvHpVNfeeCHD9tVn/8npOnslhtvkILwrZDTa+HXKL1HZMio+vqXYGzRaWBkJ8LeWI1KZM2qRINMvGepHXpCBA1YU4nLVTG/EppWot2JNIe+jTTkTcQq5Nj6eh6TFqNCdRIGttZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2YTbjOE6DIYXSfDTxYhOvsCoboSWhRx6S3w2hdzUHQ=;
 b=lj7LO8004mmGfbHQKfWOGaWJRjJQSpa63u/OGPLCERh8K9qWHSblk198yPM0fv8nv+o5Xj6W3vC7dZQOpf88aH80KqTaqMrY50Ed4Pw3LO2NRd5CY8peWRn+Q3K285a7eY7QmGWWmFFgmqxZevt/JdWjVgpltDJUCxGRfcUe4OZ649jL9mq/6QBFmscw9WbVq/U4iuJZ0aWzNQ1xvSciSRvvCi8rmYY3lkOP+rmL8WSPO2tqx4ztF3GIS5tPKfUKr7rSaYXt3Gxqb6jjuQ/egqgsDP0dWGBLn3RCH64ImzFxJABlTOcvL1HzehJfdEKs+C0RLpZxQLTXb5CIxP9HwA==
Received: from TYRPR01MB13830.jpnprd01.prod.outlook.com (2603:1096:405:215::8)
 by TYWPR01MB11733.jpnprd01.prod.outlook.com (2603:1096:400:3fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.5; Sat, 13 Dec
 2025 15:22:26 +0000
Received: from TYRPR01MB13830.jpnprd01.prod.outlook.com
 ([fe80::a9e2:6148:6107:37f9]) by TYRPR01MB13830.jpnprd01.prod.outlook.com
 ([fe80::a9e2:6148:6107:37f9%4]) with mapi id 15.20.9434.001; Sat, 13 Dec 2025
 15:22:26 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH net-next] net: phy: realtek: increase rtl822x_c45_soft_reset() poll timeout
Date: Sat, 13 Dec 2025 23:21:30 +0800
Message-ID:
 <TYRPR01MB13830B4914CFB007B74366AEDBCAFA@TYRPR01MB13830.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To TYRPR01MB13830.jpnprd01.prod.outlook.com (2603:1096:405:215::8)
X-Microsoft-Original-Message-ID:
 <20251213152130.12047-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13830:EE_|TYWPR01MB11733:EE_
X-MS-Office365-Filtering-Correlation-Id: b4263cfa-4ec0-4da9-8472-08de3a5b6a71
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|13031999003|5062599005|8022599003|5072599009|461199028|41001999006|23021999003|19110799012|21061999006|8060799015|15080799012|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LaPmEMYvQf7wA4rHOwg1Q6IktXQMpl04tFVLjCRweJ3Wajd7ItjJSpKg1DIH?=
 =?us-ascii?Q?gYQmA6QOziXPuY4pLVOnOiFcxuxfMeMUFKiffXvZEgbPCX/LkS6MF0/8BrTd?=
 =?us-ascii?Q?/CoOpDKpEv6myGFOZ6HpVfb9b4DNEAhrnt0aTe36TVgAdfSVvPPA2mdVqB++?=
 =?us-ascii?Q?oMXZuP0my/yYA/4pjuXeRX6B5nj+Vf2gNgifBOAzsurbkSONDVTitURuciz5?=
 =?us-ascii?Q?5EOe2nFg/Htb1jQ5y3c2zxIxRryS8VvjyAY+F9Q7MM0OJ4e34qoVIaMh3EnN?=
 =?us-ascii?Q?5RO+16627t68JFZZIPyHVypxeczxVSF05MVFbn0aTHsexnxIhkFxi0WfKVpJ?=
 =?us-ascii?Q?Jiz8gE32Avhf8s3L//bjlQ5Z/Hmah2HK7ChVt9a5jAJRPHI5oL+4aMw0XOsF?=
 =?us-ascii?Q?EaW080L9ghA4p0Jjp2A+gicjxrassNZpgS9WZ6gXwnyFmzn1L8UZqmejaOKo?=
 =?us-ascii?Q?kfPUReDCoy9jy8wDIFchEEDmhaJiWY6Nsrdi32iIT36/EJsi1CX9GY6UXHlm?=
 =?us-ascii?Q?a+rJPbzv6ls/Bv7q+CUVZIf3OMrBMloq6i3+scFZEmpifz5tlC3bieSInCmP?=
 =?us-ascii?Q?l3y10nReiwi6KMnxVfelp4HvhHU/pq404Jtipmy6vA+CPu2TYLRjhposS9c6?=
 =?us-ascii?Q?LwfHwzY9Vld8u3FzyXvK8b7TP1f/iZOgbdDU0aX63tvfjEUmMCCGmikC/aoB?=
 =?us-ascii?Q?CvqlJ0VykMtCB8rGX9htjA3dTti6RvfT3oRQTleevWGd2/AnOR0czWAhwneL?=
 =?us-ascii?Q?sK8zsEnuZlwWU80Julkn0q8U4zV68S+O/EpmukMpsEiPDiyqadRC2SQ/6a9J?=
 =?us-ascii?Q?baKJDl1OILw39ZO7XhL1AzL2PysSO7jzSbEbASpg4ZAwzHVDSru/1F0sX2Id?=
 =?us-ascii?Q?mAEGPAh2P9gkI/vAUr4XzA4zOkTco38cTafnUm/yosNGAHl5cgtB+tuZNaHU?=
 =?us-ascii?Q?9Myfsu54QMcRwK/UpSq72SSkBqAp4jhCT/cphpEOeOSBVowbT5Gaj+XbpY30?=
 =?us-ascii?Q?NjzbvahBRnbXoEYVREzySRAT5KVrU2SfzwpG114fP61OKg5b1QxUnjPi7etn?=
 =?us-ascii?Q?/q7H+6vc0FfjSeY3rfcJaJraj3QJHJNLrNdppBJSbpemcBBLZRNZTmeSEHbe?=
 =?us-ascii?Q?cKDAuCOa+eQ39LfWFbyneisa/n9ZB3233HpvLsPVyQYOUfUyDrZmLoLPNPIz?=
 =?us-ascii?Q?HmgFAFVkqYzSwrjskfYIGLE0/t7HjS2UIRei03dcfM7m5/avgSVzIQpt6e0R?=
 =?us-ascii?Q?Xtp4cbH2lE9pOPbeeL4pGeEXAq4AmCLduKpTp3lX0sHj0/iE9B9nNeI0N61S?=
 =?us-ascii?Q?zmg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AfG40UB8BPmCUk0f8qFWK7+whO/ytes4D4xJICBn6P2Vxkzw0MF5SR2KdphM?=
 =?us-ascii?Q?EMNueUNe600XUjMV4DJa5POGT+N/jxbZN3Dem+zJM2qUkg9HvUwmC9vGVuo8?=
 =?us-ascii?Q?zJKvMXDT1QsKxBkyQxngC7UqT9oOhFuNQLSYIYsDiAcmPB72jznRBnWvRv7y?=
 =?us-ascii?Q?L3eXUT0+zyJ5OzjDt3BQZmuTPYeY1gDUL+V7SUgQgUaUfkwMLova+2PSFtbT?=
 =?us-ascii?Q?sApS6hRrTaQ71sdConQzHwqwU68HACpj1RrCAQkiT6m7Ir1zw2o/0xbqMS3z?=
 =?us-ascii?Q?5rzKodJKN9UA+66NJdZpUjJ4WVLwKlmyMsSQoMtbweM5zwhOizcu5i6J34Ms?=
 =?us-ascii?Q?sefLOYMfFOb2VkWqowBvgsR/E0ootdWRVMTh5cpkEtW4osNdBG0KupgqPrYb?=
 =?us-ascii?Q?P2BvLpn5f9p+1P430ShBEmeUmweLXn4AkWGmg5dxHkmtMHU04VajWk7CkbX2?=
 =?us-ascii?Q?UFb2YLL/qdJlwtfm5x/XV50hk1LSPMIye1ccQwnlZF/G3Le5SmfO+cyEtX5v?=
 =?us-ascii?Q?u+LOJmfcGEAwSveAbpquxaQkgNs3jVEV2xvL+nc1SYff0EejbaRPhcko9yyT?=
 =?us-ascii?Q?o4mDB6GjWjo7g0Hp57yu588bNiAmN1fPvRfirEuX30EP9B/B5quI6g1tk/g9?=
 =?us-ascii?Q?zUeQX7zift7rYYU972zCy/To1PeZDwrCwjSlnIfu3Kdfymj9jOxkF4PqQv3f?=
 =?us-ascii?Q?wNc1cQyhYgr56ziDkhJTEq3ehNvesHDLyX4/EAkLGq+5QTerGya1N0BdW8cG?=
 =?us-ascii?Q?Egab7VDdIiz/DOyVK2pt7pVuKnKOQgdVGAot88cbBfhItRH+ITJWA7b52M6a?=
 =?us-ascii?Q?asaRD2MwQlMksk7rzQvzQam3r3HLKmIVRlInvPYY/J6yU7mDbJ9PCbgq6FEq?=
 =?us-ascii?Q?9hrf8xSeaEWO+p3PbTZpSfNCR05fDv1zaAnnJ5Ot7FsitiD/H1auqv+XqvgS?=
 =?us-ascii?Q?Oje9m2baP5r43IGGAlDtL/xvIfZx9T+aiM5Dv8B6730KHnAdURrjZZz+20PX?=
 =?us-ascii?Q?w5PVIj3hzDIIy5+UTUcHoQC3tISFTteMaPfD5BN3IzgQykKhQ1WZTRsZqWhZ?=
 =?us-ascii?Q?IhAINp5ueAlpUaUic6QrsrJNK+BV3m6i3z3fmMICqqsS81yJgxSB9ltWITpr?=
 =?us-ascii?Q?7vvkSTqA5Yua+x+fAWC19KLugKz/3h7KV+wqLKd2DIDZ/Hg6pbk8+JKH4+dX?=
 =?us-ascii?Q?wLEH5/U90Kw+KY8VoMG7ixUOSKgh36mOokI/jlCPQNqwoLs9RARWNOQbT1fR?=
 =?us-ascii?Q?eYJbNqGHSBM5ubnZ2Mfc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4263cfa-4ec0-4da9-8472-08de3a5b6a71
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13830.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 15:22:26.0636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11733

It's noticed that sometimes RTL8221B-VB-CG cannot be reset properly.
Increase the polling timeout value to fix this issue. The generic
phy reset function genphy_soft_reset() also uses 600ms as the timeout
threshold.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/phy/realtek/realtek_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 67ecf3d4a..9228b42c8 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1509,7 +1509,7 @@ static int rtl822x_c45_soft_reset(struct phy_device *phydev)
 	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PMAPMD,
 					 MDIO_CTRL1, val,
 					 !(val & MDIO_CTRL1_RESET),
-					 5000, 100000, true);
+					 5000, 600000, true);
 }
 
 static int rtl822xb_c45_read_status(struct phy_device *phydev)
-- 
2.51.0


