Return-Path: <netdev+bounces-134638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3E599AA7E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAC01C21393
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2511C175B;
	Fri, 11 Oct 2024 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ANKQUaZA"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010007.outbound.protection.outlook.com [52.103.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF811BFDFE;
	Fri, 11 Oct 2024 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668366; cv=fail; b=elh1DDk0zQNwJOboWeY12XooNeaJF88OP2866/Lqwt81NFuw2Tq9Aa27/4cQmYmzBJInrpHzGxEg+g2+XGrirHynKQpZc3Q16RGazBD27wwsXq1b3NheiPMUjeyzOLRJ2Fo4HGh/5M8+OPUv0k4nfxuUSsoCLvsEB3aL4WqA36M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668366; c=relaxed/simple;
	bh=wPb+KWoBarAIMzdirdczqUE3z5Tpx+YzTijpJegcZC0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HWEZSF4keQ3CEgt8OoPUBzmNDODbSaAAicuQezwHREPfKuHTQvrOMZ4yA21isdwcR2TzXqz9JQa/baBAR2IaA1wtUQte9AV3BnO8GrJ6Akl1cgm7LZcNlO750Z0DJPHcn82gU1BUyQRlNHkYCW274LSBSnyblZiyNuywx1fhWHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ANKQUaZA; arc=fail smtp.client-ip=52.103.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGNkLRxWV20V4n3xQODOF/MjLW24YJNBcwEpu4cxqi8UtPDy87vTd2yEUGMiKK1Qp3nEQw85Mgc9wfYNqTWnJWtnGbp0Yx69UeROePKWPMLqE7l2tveE084nBqPMc5E8m7EReNxl0MNkxmIMagZWYUkrgnM7LPRb21TgEHBdjdLZd8QwqmVLXXQ6Hb6B9s22rGfPT+ee4JgePUYEBTcBzZUd5/QT9JoosEf4h3DcMon9fIzxs0b6XqsUtx6vEjSfsEF3oAWdHXdoPsy1X0kIE8g3H17xNdE3GC0LzfppsSTvqb6tnUA29eGUbLlea3ivdjnYSjkY3g2mPAcVZYjI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+SKONWVs+0sT5mvtgU2Hd09g82JVemNzUsulh4V6K4=;
 b=rxBqugBk+08MhB9+IOS/2nUsMC+YCdO1CD/fvEUiwXMK8+0gsM3nRWmZkx4xTb5yTBnNVvteS2lBgwQ4DDGcfovoFxGJLAOkezoNYpvclz+RKxHpNPF+yhqAcO24gvOT05pWRmA9J70aKrfP+Gri7Sns2cXWGlVFktMHThJHmOSc2e/HFuXRFFC4xkaF+FyKXEF4aZlIW9zE1+wvasW4sN1AIK4Py99m4mq5qV7w0wn/rkGTmUy30GDYg2BeH+EEW/RSs3M1abTF8b8JTUUzDCJIvS/SqrNk4iDCUObrgWmNT3ya5IcTNqTRGgJI1aRYioGXUdZwcL0JVszyMnEj7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+SKONWVs+0sT5mvtgU2Hd09g82JVemNzUsulh4V6K4=;
 b=ANKQUaZA0D/tfvMQ40rBuLsP3luO82I1CZiVaE7USueHGcGzlCO8hhkgi/lt/dj1/UiOW1nRg+3luH7X//Yp/NNS4j+0Wuu7zdOKYSDL5pEI6c3fF9B0zn90DxLSpyZWEyxOTDu/Q7+B1gF4ECjwKhW9Zk0V8Coj1EKTFMd0bHg/lC4/VqQ0NcKTNDiIPkVxYXN5jPxsy1/sYsH9V8NXqh3Z5cDADcyhjZGxCaX+CYAtCddX3H0ytmc11CuJTlkTX/uomOsWaS8mI0yOKpLXc6rM9A3UYwUYb+B5vzcVO3aTdTik67D8GHMLD7ppcTR3Me/KqUSHhVHYQcVe7e11zA==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYWPR01MB8299.jpnprd01.prod.outlook.com (2603:1096:400:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 17:39:21 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 17:39:21 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 RESEND] net: sfp: change quirks for Alcatel Lucent G-010S-P
Date: Sat, 12 Oct 2024 01:39:17 +0800
Message-ID:
 <TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID: <20241011173917.3845-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYWPR01MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 6faa9082-ba8c-4c4e-a507-08dcea1ba3a5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|5062599005|461199028|15080799006|7092599003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	4EtWkfrUbggDxLmKWF46FBHHeiJWXdRk/PZIKORhthJMJM+LwPbG1f3lIGD+qMyCzDn+MiEe2rxrcZcD9BEblTUUsVRQRHwvX6xj514raOuJCq7g4CtoBa1TEh5fpDSgHHtaq7GA6hMH8p6vp0yRwpXjc8WYVG/thNMR3ITP46U+e1CE1c/oytufOA4G8zf2M5nD95rcnZvbNFWIiY3jEmRUQnnzn7OPnOs8KIOUfR34QrVHpZFHET3tT00xNLWvue+C8Cmdx7k9w8KLFjbtKjNUAUa4ndtFjjk6c5/rOxTOq5uyEKo5Yoo8ijtqK1OotLGfkJSGtrRZ7gaesnIdjXjawh5q6N4mebxdwuLW/NmrVFwIin1/ZqtMvvTVvq6MG4Hqcbk53WW7GI3EX9rKnj/ZKoXD4WaCBYHKncwVf8pyO6tTNpEl8kXWYI8TeD9L4Glt9zjjexXU1WIFUCyDmxRwL8yUZFNlT+sxjqeCBbZbkXpMJnU9zljsUvG+ivlsQt54oXj+SjNfy34u3V5d6unonfj9qHf9Y8+yYhfaNW0Pb59xtCzkknJKVhR/G/A6cFuJDji3UFGMB0YacKnvzSrYTwmxI6Z/FUcmqvNHiVQ86bnbBJfZd2C0gYnC79Om76rWrxBGs/A/3i0/FGHb6Fax1xrLa6OxJes30X/rkLhm24GDY8UHhcBQ6dJLkg34TLEoxGbj8rXvUXGs+/GpU2wQ0dXCRi+7E4DqLgD0Ms7+r+yTZGpIEshAp9yFT+NkjZ+ssIOfLocYi4E+oAms5EDAnvzz2/LTF7eEUZYQX3w=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wRIsAm/fJHMrbUqaZs2qNzh0cMngJtx2L5AgmfCOC7t8/8uctYFEXir18d5/?=
 =?us-ascii?Q?HqbTTjtuQ4LMCp/2Zn8nwPnocUvz4gIJWZ+lLOYvEZVOqL55m1kevOuw5+Zk?=
 =?us-ascii?Q?mf98lKBncIDWFf+y5tv0CDSudxBBeOyg+j4hleS0gwA+0czkaVl7AYaZCBDw?=
 =?us-ascii?Q?Ra4a2lnxBK9wdwosyYy7JsIl26CT3UomkOr41hU0y+V6nhoXR1LjavqucnV5?=
 =?us-ascii?Q?fikZ4xh91KEzcu2bm1TRTLvf+R97Z2uq+42U2Iagmjq/Ef5CFM78+e4YGQq0?=
 =?us-ascii?Q?0ZhAPkKOzlHZvrOpWKCtU5Kaf6BvkN1RIzILEXXBcOAkJTnGtaYlZhI6UYV0?=
 =?us-ascii?Q?ecMWrpAkUOMnVHGKS9R7ofOJO0g7qCjWrXuaThpkrGWpMSuDY31ogZX5fcin?=
 =?us-ascii?Q?9slSFQqHglkqkHZW2ThrvsqPqKcLFgzcobfzGj5dUiWd5cEMy/Hhb4Aag3mT?=
 =?us-ascii?Q?JGaG3LpeEH5GF6rqxHwqmKir5Cy3YYSynO3XxjSawhVSLBDLSzfwXd7bSKOR?=
 =?us-ascii?Q?yaL5dfVzLnNh41FC9quiiBq9lSwrI++BT9b9UrgmuEjKy7spLM31HYaVvO8t?=
 =?us-ascii?Q?M0zYK2LvKVE/itxKVqVaK41S07JHnvm4AlcOoGSSAJgqVHydfr4KOGUn9y/P?=
 =?us-ascii?Q?8SgOoC9ftob9Dxf+ui4Fc0qFFfjSrGQr7NwbwsluqEfZmA/xcq2Ap9yWFmfg?=
 =?us-ascii?Q?V3mJV3RN36ywIrDo/YGcP63eJG8drO0H+KH5ZzVqxiAeMvovYWr54m6W4fkO?=
 =?us-ascii?Q?uPl1iXK2jgy9pE/hi6kExZxJnhZpLW+VRPheLt5/TShB5pg3V3zv2j3fHmZG?=
 =?us-ascii?Q?+YY8lL8suPyIBaSHvstdSU8nsh2OQ+TBGUyBzGYbwjhmLDS1mjUCvv5G6pS5?=
 =?us-ascii?Q?JoRKB/81gKsaUYwfQsCElGrasojByMcwnguJfihj1boLpxhxDBIQPa5kvhj9?=
 =?us-ascii?Q?Ycy9VhQoDrbBWxvOUZ74Og1NxhS/UKJVgp1dcS1LWxRL1zAz2KnbRF++y/iE?=
 =?us-ascii?Q?FHRMBiZ63Rir15rR4rYFgAJHw74QjwAZs0Ptk39eRSzy6invAMw6Mv16LH4t?=
 =?us-ascii?Q?4u0KlmPd8SR9tGBrxS75uFR75rxWve1L+hvmJVU+un0CyVpv0lEQ3TQ6BQfK?=
 =?us-ascii?Q?HJccyEN0CSHhoSX6e6ILNu15c8mkQ6b2dWx0vuncxynD21R0fe9DqCPEd1JT?=
 =?us-ascii?Q?8X9AcqAnpkeOv3LgDTw0GHrd41dTT3rbR+h+Zg/cur2evRVycGtTAuS9wDM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faa9082-ba8c-4c4e-a507-08dcea1ba3a5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:39:21.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8299

Seems Alcatel Lucent G-010S-P also have the same problem that it uses
TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
The previous patch email was corrupted by my email client, so I did a
resend.
---
 drivers/net/phy/sfp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index a5684ef5884bd..dcec92625cf65 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -466,7 +466,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 static const struct sfp_quirk sfp_quirks[] = {
 	// Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly
 	// report 2500MBd NRZ in their EEPROM
-	SFP_QUIRK_M("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex),
+	SFP_QUIRK("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
 
 	// Alcatel Lucent G-010S-A can operate at 2500base-X, but report 3.2GBd
 	// NRZ in their EEPROM
-- 
2.34.1


