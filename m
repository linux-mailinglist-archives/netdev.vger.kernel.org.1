Return-Path: <netdev+bounces-120407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224FA9592AD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 04:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4771D1C20E10
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EC95FBB1;
	Wed, 21 Aug 2024 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j93X8NX+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2032.outbound.protection.outlook.com [40.92.59.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92401C683;
	Wed, 21 Aug 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724206746; cv=fail; b=jSIQ1iQqGcVqioUdD3OODaRxMAVZmWitd7C8zR4OgLpCS7Dfs5wk8cU+kq46CsrFvzf0ZEf34CbJM7NJnRGANFXGoF0flqM6ks/yVuIimImBjm5m06HC9DspmvGIpR7TIpcsOozz2eDa6+S+YF5Ha3X20FRGP2w4fhRVW8pk/Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724206746; c=relaxed/simple;
	bh=3TmF6lxb+xkb1StF5ZnIAf0B8EIp67LlodA8xwQfUdc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=acJF9w3ldSEUni+w8MdcxgdMutyXJq40iJbexUMelW3Oh1MxQ2DsOtKkjUB9SIV67d+jYJrH6sVEU5gXjLmeIbodnKwwE6+DoroVkG/o5MCnQB+Sd2Qs0P4IIQeRxWJyLHBNhb7q6YN2Q27iYyAssy2RNDTRczk6CNAsjR7wSPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j93X8NX+; arc=fail smtp.client-ip=40.92.59.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvBG0JmdOuK5FWfwHboj1GZRvYtVn0nNjVvDetn0YhrLkqAeFIn4RywIDqCX08cO8AQrLG3YqeSAUgEe3uwHk2+REFewzcbAA9JFXoq6jrIrI3/Pzoc91Pw5AcB0v8Gd8v5Yee19+KT2uXRqvGFecAPbZLcC1+5Jze/dUoV/JSs8WIisdAfU759b51dJ96tpLgyzjM9bCywBfBMtiBKR9QumlNdhvgWk8qliOkKX1NBJRlRnP2PGoxmBqMnaHLotYEFfC/qmH6l5yv6HTNfavuw/FWK+qdjokwFTU2mOlBSbZrzc3iO+DxX058TbHsi3z2YsSKD3jGXU5DWbY014zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOn7AFbC0Jy8vtgEjLKTJtejBdvkF6UQI1tySM7exX8=;
 b=y1afA4pUxAbNykRcD8nh9tae8W0akZOz0vF2EJw/DPMI7sW9DTNRBnd5y30t/GIQioXWsl9zWFfNk4psrLrrfp1Kv7RbLNxpzWSHqQYEHHa0pAiMa6VRR4NVPOMfzuTKLm4ekqExJJ5HxOhjuu8Le2v+m8MM77SDLH8Va5almMWnQ4zvjPswBuvLpy4OFR17bFur5qShS1ZK1j337GWeKmPeHlNCBn7/b9vAzZjFdWGX4BRJkDEZWrzgOE/rqSKoTiC2oVXVDm6vhMDMjuTQduhN2svWUrLXzzyzvt/bUP60qkFxr/GXGSUXDFOEF4JG/r1mMQ0dilY4kXgX4W3cKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOn7AFbC0Jy8vtgEjLKTJtejBdvkF6UQI1tySM7exX8=;
 b=j93X8NX+fpKeLytawUqdhFSRROAoN255pP0gfY1v2WyouKQObz1nb1JjQJwAkJvl0sht6JC+IE+y3Cwt1KQCrictmsYz/mZwdTXBSaYnrJYLdL8PJZjGfyoHk4cas8AhHen4H31MfrcKMwuKczZhGVYcjoETGxV744VrsA+8ISSbip5IG16mOm4i0FHmEFhhE7unYfGwp75/S4cv1NoY+qe55AJ743nfSJpG2oRk9vNX0kLwhJGgDau6kFzL5dFYZN/klUupodpi16PsA660QMdxs60sTlX2R5mg6Ko9A2t1R1gtzuNtufebbIw6Cksd5nfSSrdSM/SzC3XJVBXXNg==
Received: from PAWP192MB2128.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:33c::16)
 by PAXP192MB1632.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:28c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 02:19:01 +0000
Received: from PAWP192MB2128.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e98:b988:5136:a608]) by PAWP192MB2128.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e98:b988:5136:a608%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 02:19:01 +0000
From: Sava Jakovljev <sjakovljev@outlook.com>
To:
Cc: savaj@meyersound.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: realtek: Fix setting of PHY LEDs Mode B bit on RTL8211F
Date: Wed, 21 Aug 2024 04:16:57 +0200
Message-ID:
 <PAWP192MB21287372F30C4E55B6DF6158C38E2@PAWP192MB2128.EURP192.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BvxXU1qQsRDZinLKgBQAUPrBTA1EK9Eq]
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To PAWP192MB2128.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:33c::16)
X-Microsoft-Original-Message-ID:
 <20240821021704.2536074-1-sjakovljev@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWP192MB2128:EE_|PAXP192MB1632:EE_
X-MS-Office365-Filtering-Correlation-Id: 37941fab-383a-49c8-84b7-08dcc1879ee1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|15080799003|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	3Y7E47Qdjsi5PNmQQ+kA2neoqJolrkWXjLa1qXICZa3k55m3YUC3JXrn5D5KqNdW4wBrog/657p5qUBMfu4IVOtghczfFh7xF/VBITUybTiHRzxH+tl1mvFkTecpZ8YwFIQ6ov0b5IQcpItTtk4Eft2OnMGlbtygUwBdMoFUa4VobzIjltbjjxIFJQrAuyFbJme1PnuoHGAFVOUPyNDlznrWBVC9NKtDShs6o6N6ljHCYON1ij5OTcFep5y7kewmy6Pl/S4ac0mGzPTOdO0dSN33eqSIu2xudvioV7V+Nve7271ADOa8u+rRbYV253Mogwh54EpIdAcuhcyW8WZdHwDBhAnDiRJ0ej/PxGQFAbu3I5Jo3iY8nD30eNpoexcUegU3eCOR7jfRtCtb2iDuEVYwJVIDXaK3pfcdoZG1uCZPXaMUr9+7xJ6tGLRNGpIa5ErBXc5cLXBwm8C2G7MyG5kl8qTJ8QO3LZwNKmbYxJPLJaC8/TXManB4YPNwX5iweLgyQHNzwnXQKNNTua2uOCYBQSlpY4bCuHLD1m7iXphIu0KBDUEsldqsj1siXdqwJzeZ2tNTU06480W0ykYKmIpx/boPk+D7DMlom/oz3P7zmgS4OP83UYtyw40gODiFdZDTC220VrA7s1AgxQAM+EohaDw9KmoBKEFVOE3M/UOjJ6TUZAifClu9wvmNxmVza1IOlc68uV/kgb7pDh31VA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u7n/vQXOmpk02SsEh3XpZuvWBsRW7WTok0DFp/EZ+YEweui21ts9t1l7iYid?=
 =?us-ascii?Q?SqowO6HphnvA15b5NzQQVz4G2F4hGu4QH/Fshaf+5dqUgy6VKVPiMuwafYb9?=
 =?us-ascii?Q?yTbWX+5ZylqeYWm+cj3/Ha2xCdAne9zPpJtoLqjFkSduxJXk8imvqIAUkMqP?=
 =?us-ascii?Q?efaKb4dK8eFmmMRH37yj0KyudyFvqkf6dJhE6xS9OvP6HSP7rYGuKIUiqgF7?=
 =?us-ascii?Q?kf+iDznva/y0cenCXtf4Sauuuc4OvaAyPvvNFwVP6vMZm5d8jocoajpFW28p?=
 =?us-ascii?Q?WNcU6XoPHeaRSk2ccCWjz/Wl0onq6p8e620wfURvTge21S7mFbO1U8ynnzMe?=
 =?us-ascii?Q?6D0lcFldhELs8SQTUH2/cH0nEyUb5Es216/jZYWthT2qpMCOeNZkiq8v3vOr?=
 =?us-ascii?Q?IY+Ic0nOZ/nPDlJ0Mz7pdY41FbaGqDRYASbYLHRv6GQstMKyfW8B3x1Zn9ee?=
 =?us-ascii?Q?zvdw3wLNAkByOiaTujxhmsV7XfxUaEUxcnhLONwx7dYvR5/JYNM+JseKWOUY?=
 =?us-ascii?Q?mS59qg1lugKb6wWJOu7BwJ0FTccbpPUn8Ns6b1AokG+r6+0J23vH98PYH7mX?=
 =?us-ascii?Q?66S5v1755EdtBIO3dFA86TKiuhl62k4NXthNPANoubZWFS4nehvEd19lnbLq?=
 =?us-ascii?Q?geXrOlNQTRFzJNK+ZGG3Gc5CMWSqOpMMzkd/GO35Kp/lMDAImfpKhhYmblRL?=
 =?us-ascii?Q?oXt47YdmiehR01u58p7StiUXSZV4yQinLeG1s/m0pKfJmp4a8VVK52JcguuS?=
 =?us-ascii?Q?9kaQn6y3d+NPD88vvCi6R6O9DGXadJk955JlO0dKnPpvgYhQLvuDnzEStSlX?=
 =?us-ascii?Q?loHReOmPRoFSWBkmCX53sNy/yd4vmTzTJfDcMeITzlTyR7jchwK5NZtqgxe0?=
 =?us-ascii?Q?QNxeBv0lmUe8ybQCiFyavIXpeqryKYLNNjaxjU08RwG+eaY8GeDQLMcIdnG9?=
 =?us-ascii?Q?mDvcGsA6RB/eg4+SCZzSfIxupVGKSzaJukq9+9wsF1gnoIwYUknz8PxE8e8B?=
 =?us-ascii?Q?6Y6Je+OjcBl6lrKlgZPCo1dKZF5Li5OVoVKn/5iZ6yi5VuDNkhazPuldmamm?=
 =?us-ascii?Q?9HyYOYwA2vjebHeFH77+Wu6pa+3zROXyCo7Ou5mIWdu8aFvmyCWToxDckLpq?=
 =?us-ascii?Q?1Tl9i47QSJ4kG0p3mAA1Zj71DwA/xbm4IFG7WPeq1ThFFefA/z0vyy2k6XD7?=
 =?us-ascii?Q?mOaoOe5JKHGoaqjQgFeX3iEsJUb2YmL5p2Uvn5Z2w8d7HeCfESdrrLpEXmI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37941fab-383a-49c8-84b7-08dcc1879ee1
X-MS-Exchange-CrossTenant-AuthSource: PAWP192MB2128.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 02:19:01.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1632

From: Sava Jakovljev <savaj@meyersound.com>

The current implementation incorrectly sets the mode bit of the PHY chip.
Bit 15 (RTL8211F_LEDCR_MODE) should not be shifted together with the
configuration nibble of a LED- it should be set independently of the
index of the LED being configured.
As a consequence, the RTL8211F LED control is actually operating in Mode A.
Fix the error by or-ing final register value to write with a const-value of
RTL8211F_LEDCR_MODE, thus setting Mode bit explicitly.

Fixes: 17784801d888 ("net: phy: realtek: Add support for PHY LEDs on RTL8211F")

Signed-off-by: Sava Jakovljev <savaj@meyersound.com>
---
 drivers/net/phy/realtek.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 87865918dab6..25e5bfbb6f89 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -555,7 +555,7 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 				       unsigned long rules)
 {
 	const u16 mask = RTL8211F_LEDCR_MASK << (RTL8211F_LEDCR_SHIFT * index);
-	u16 reg = RTL8211F_LEDCR_MODE;	/* Mode B */
+	u16 reg = 0;
 
 	if (index >= RTL8211F_LED_COUNT)
 		return -EINVAL;
@@ -575,6 +575,7 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
 	}
 
 	reg <<= RTL8211F_LEDCR_SHIFT * index;
+	reg |= RTL8211F_LEDCR_MODE;	 /* Mode B */
 
 	return phy_modify_paged(phydev, 0xd04, RTL8211F_LEDCR, mask, reg);
 }
-- 
2.46.0


