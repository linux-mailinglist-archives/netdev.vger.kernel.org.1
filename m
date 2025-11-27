Return-Path: <netdev+bounces-242262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48007C8E323
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B6EA34CB6E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53B32E758;
	Thu, 27 Nov 2025 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dTEIyGRS"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E932D0EE
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245381; cv=fail; b=TlagwbEEFbfGCRdRwxV6YmNQVJV/GIKkP6CtKVsHIr6FE29sotYwxXpqqmIq8UDSg8GHA5NbyMqvbEtKr35H00w9tc0bzaly7KSEprFpASPxJggwzGVOGjnH60YizwI5idrf6sko6i+xf12mmP2VTxT4hQaAJyFTRIZ0oKZtVLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245381; c=relaxed/simple;
	bh=QZNg7dNeD45rn2ftYCgCTcFA46RTxHoj3q3sdi9imqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffGS7P7GOJFId1/U4f4XOcqAgpeEEEFVVsDFtvu9JTLsoboT9gu/ceZkVPHDjsUxzuYlTbSoV4hG4j/4uyMc0WZLBHc1uR1PsPOwsxPLyHRqAcurO8wZ6slVq1kHwkeuKomEmUDJ/q6vy1GVkt8xtpzTLNcQ0tQ3TDFAcXkHAuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dTEIyGRS; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrnnKitSHbnudlLQV+DLyyRw882ls2hIBa/R2y6hvEW43CtCdfD//dAyHkc5GdwSYIx5X6ojaosXDDc/bxdcEGPa5YiOpvHDHuOdoU0GzrWsi8bmRm1L3rFiSKWNdjkAPti0F3wFC0kAyeHOVl5HnYQCKV1P9Y5ldvehMkCmu0zucSKls4zmG53hwjocqoAwam69FrTim8A6wQCrIDMOScyygeUdolIkSsDR6KWJhMDPM7z6bAdW1QA+EMi1TbHjeVksgTu689UCmS3pEZI7pODWYQCrezARz0R7T1fu8g++hqPxBXC9NBMIyn3mVLZ3JVAPIdUnu9wtlMLHr661eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UieOMKMYJSYpl3mpiXlvSdYizXDAgmf4cnu+eJejvk=;
 b=lXMIC1PRrixNIt+QwlwYSCqm2XRRUnrzUALZ0EONFiVMR7ujSwyNI+A9RGm4N7ih5xccxtfXPLhXPlL+RJZ8A79gySHxQ3Va/slwA7gD6B+NO8+jmcWSOImGhrm9Q2C3vf7ieZj33cTXo6X12L8VSc2xNy/KNVrQ8Rwkca6h+En/4jcVNpenizoSveO0EHqPDAwqb9HXE+ixE7rb8DK0H6EUdNf7U4biTox6AGNGtO6W54cmkkFsJc57O+wjd7CLEAdS0AeqLUKgso+WEdbtV/8lIaBfv779c90qOBbaWYIIPFo/86gf5fY72sCatt4v7JjwzkjaSx03/qyqJxL+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UieOMKMYJSYpl3mpiXlvSdYizXDAgmf4cnu+eJejvk=;
 b=dTEIyGRSQ4YPdIjhKganVUAUzFASzUwbPCrSp+1iwBo0cpFqCPDHoRhUeaf2/bN19Nf4wuVQw79K0GSJoGIgmipMOl1mhlJaxWdlKwqtpg4EEb48ebur/sCWHMKTYsqXIPoLdKnS9eDCEkyNsOWwEcxI73n+Viskr78ux3+0l+rve8prHFP8g41NQzv/BZ2DPQKqWBVTT5k3oP7+NfrJsiFhGhb38yuXTRfSWZXpa3hfsAmHT8tOTVjohZy2cVEyZ/18ltHtXed+zZviUwQVlsIOz0PT4Cv1alQVmWYn3ZiY9axvLr6XZmN2FZ5NZ1evJ/1yo28Rk6Z2nW0QR4bnNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:30 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH net-next 07/15] net: dsa: tag_mxl_gsw1xx: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:08:54 +0200
Message-ID: <20251127120902.292555-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: c92b684a-046a-4e0d-364d-08de2dadcf5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z8QcR54TQ+l41IqwIpGf1E2hYSWRV7NRKcmeAK4ccBspMcjaZBhAPTZEBnOs?=
 =?us-ascii?Q?c3i1V47CG8s78cNiP4GBgBY1qLRLWPhv1j3rEk7PmbJLBtfupnuq74Y27fW3?=
 =?us-ascii?Q?UV7fVPjq1w+0EToQofXnP74+Ibhbb+1FsQdx0ziTA4tTIicb71TnaVLFwpVX?=
 =?us-ascii?Q?Vi2ZutgkGMINe5pbbm5JGwpPKvvlB+QJDlvcvqUm/8qKXtBdlwff97+GI9LX?=
 =?us-ascii?Q?QLMnHh55/0/I/d/rUUKw3w8uSJBErRBUYf0ayfByGZ/fEkELvFYqZtPAX88g?=
 =?us-ascii?Q?+AokYXNYSbFlF7DNF5DnwRDILq+TsVzx5b+Cqi9wPcE+uc6E7K1CrBrrusfV?=
 =?us-ascii?Q?VUDdl0dcpa/Pngm3Hlmrxe7goYTJQCKugeZs9XmjTWc+EOnqTGbHOsBOqovG?=
 =?us-ascii?Q?Lqc8SljEz8DFysYjDkSYtWyNM5oNN5xWCh3EJvLP2efLO82j2o2gkDjciHHA?=
 =?us-ascii?Q?dbA6gjAxfg+0SNG1F6BjPoFxQ/wMlBXYd3ag4b59d3XKpKxlU5fJm4MMFCu3?=
 =?us-ascii?Q?1ewXjbUEw/U49k0cXGASxPFGe5y2kXHGMJ0QIpL+qHGAAImdNfkQ5r9tfMjb?=
 =?us-ascii?Q?y/WDTO+s+HNAn1cwwDmReOxDfp/luDPohAI0l909F3NkdODXwBPbzqJrP0HG?=
 =?us-ascii?Q?5USso8VVFJbLm5HUQAAydduOYXBTe8TPFeVCWsspfsvLXUBtur21sIGTypaW?=
 =?us-ascii?Q?8cswlh23PR5u3lSUCQxPrCOI9VbkKdJSmOdIp5DBazmGdkpKRjfCegJLZUVv?=
 =?us-ascii?Q?2e+F0ncp5p1cONzPVTNI/JzYI0p2Nxnv1aV20JrLJqa7B/caC5XY+7O1mjm7?=
 =?us-ascii?Q?GOpB5eNSr2KbapP9Qufnn4Wy9/8oVwo0iiio6fz3WWmXSD9IhJ2JssfUA/Ma?=
 =?us-ascii?Q?cY07FOd8epldkRCONqq31f1S6eRx4fj4saNwLtYxxLlYP9pcnI6x0AlDISBP?=
 =?us-ascii?Q?H3fIdPKnhaXpcvaljbD7xaAAmiLX9bhCdS21UT5lZLPEr+pSqmdon3TcFL6Y?=
 =?us-ascii?Q?T8htdUVx6govCmnYK+qyD6RRfKM0ELRi+fWY79KMbRZLc+s5KKZ8mUj+I/vQ?=
 =?us-ascii?Q?83a0K1Zjl7pxkgog1fitnaHIuflDtN2vwTr9nuS4EIfAIJ4HVauRlLIjh/Hr?=
 =?us-ascii?Q?HO1lv0ssoRem0G6tAThyqREyo1ZG2mF1apqGeOAovlnMghrqmx5nskk0Pl3c?=
 =?us-ascii?Q?qNFyO6+jVih/v5Yz6kWwp7cuUJOliXC38+mj0ScdzjOl91DSgBdKfZDtG8ay?=
 =?us-ascii?Q?mXQmpXrmRNBdOHHPOhAT5miM0f9+Dq1i34hH9h2xx12xQcs0Gz2q6D/Lf3x8?=
 =?us-ascii?Q?3IiHEt55JzcwtrYPXPsJYeJqydmqr/wT9fxH9FZ5hkVqXL0Fm1M+vy+2AgAw?=
 =?us-ascii?Q?iNr8w+5+njblCLIwwLJwH4VkR+3YbjAalf+pCEIFs18dlI6zHPThfTn9Nzpp?=
 =?us-ascii?Q?lb9dYn1m/LZ2+G9kpLIqt0BLxDRLdMJJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BwUmgIz0zFoY+EdPT5uxce60ym83mLLPkYJTZox/976WSAqFOsN4qF4xgDKm?=
 =?us-ascii?Q?HPsfnziWi9grFgZxZHxaM8elm4Mg7XF/Jeil6bcfz29HALltSQ/NOE6vS831?=
 =?us-ascii?Q?5ZlTjX+a8aUMfnC1LadShn3ykDEMTBriHaqP2cReYQIOw18OrXdhMPRNXJTR?=
 =?us-ascii?Q?g2UEoDhbFxpPVF2+SIPjcMhmm6K5WQ6xHtTgLM0KCazCSOnMuXutolMCzNpm?=
 =?us-ascii?Q?s52x2m4sa2HYkt25a9ExdoWq4Xvp4hD9fNyfGGIrf2ba8gAG81qHSThwIxwT?=
 =?us-ascii?Q?umW27CuoJyD+B2bRP8F3iODnfahAcRe3rddi7HyFJ/6wyTBUjdv0jeIH4Lnm?=
 =?us-ascii?Q?wRIlLnS4XuGG2R0BThJwESZRqmoqBF0ipJSJTTPvEbzB7+X9NfJZb0pP42FD?=
 =?us-ascii?Q?8qTwwuXb4zkPBb8cMUEWPo7ZNG9S0i3nxDYIGr+z7OrNY6/eksJDJejwectG?=
 =?us-ascii?Q?PsmuIMbtA/D+R+vis3v30Gc1p+zEsnBJie+fVzDZmAEMAZ1rP3ydkJUAYMls?=
 =?us-ascii?Q?bj3SreywUBq+eDBbN5eJ3uwMs80gfRPXnRGGF/RwbJF2tkKCsDy77N6DhqJY?=
 =?us-ascii?Q?ViX7T8yQT12q4WqsBqPlS9hyewjMnNS7OujiSF3eVX7pw0WrbKRNVbUGvwpR?=
 =?us-ascii?Q?asvnA2HN9b2RAIzXJoV7fhRmeyep0WT54TnWRNqaTdxlFq4Abl4WiS1NKcmT?=
 =?us-ascii?Q?lkGY7MnM3iTAnk7ZbiqnQFn8Fu9cSC1zN00FXvftEj7v050hLiqGepxQ3dRq?=
 =?us-ascii?Q?EQ+hF/8PuG2tQ7r1JjsSy/z1U9LK9PbR+kNECrPCM8iCNPG2PGQEjPxnWNJi?=
 =?us-ascii?Q?/EGG+gb9RrTN68JEWfjEmQvb5cVGYSCKVkMeaS20IrSqOpCGp9G2yC+c5NJM?=
 =?us-ascii?Q?udY3z7rdh1pXBPQZqzDuQ7InUkuQYcGM91TfaOdnWsZ2C8lRdf5KVi942eZZ?=
 =?us-ascii?Q?orNuUY3O4ZitSCQLch1lkDbEYnSkDK8nG4YmiL9t3+pBmoH5RIcNAnYqLjwO?=
 =?us-ascii?Q?RnywS0xVoymdKLR1HWHxEbb/zUPZB2yzvTTph/Pq8tC+m3LW+EnSF2PqPr15?=
 =?us-ascii?Q?z7klmsUt1beQettJq/e14KrJxB3JOjYEJwS1q2zsS10poX0Wygubxv1BY6jR?=
 =?us-ascii?Q?6xsNi9v0SssIpzHWhoffoYjzJIQWcmtUSq11PV0jyybTFVgR11/yLqQlwqcP?=
 =?us-ascii?Q?9Sht3wYvG5UexTzsORaaI/bydyC8RxUnrtSUyYkFf0CEhHTIJVCzCvQ9Khz/?=
 =?us-ascii?Q?j7j5y7McWquFiiK9cURpzIbROMfZ+2hLD0uNgwhVZzpTcOD90K3O4Bx2gSNe?=
 =?us-ascii?Q?48ASeU9C6mP8aXUDGU2RvCZaANUJhILCX3w72Sx6ojNN7Po2p9HRSob9DOfl?=
 =?us-ascii?Q?Lx6XC9PZZCjYtOcX70P0BVlFYYsemaA1e0TlUTS9feLx+KQ2BFxnF5ussUUl?=
 =?us-ascii?Q?Bd++MmlpavHR+Zso3XbrmVPso531JtEOimFfbYp5OWRgeO7/TXsXGWDld7Va?=
 =?us-ascii?Q?rqfjjcu5H7nfRho6HwGjp/0f/2UmsRTHQG2++CbCJxDyy1uns3tGh7sqQbWW?=
 =?us-ascii?Q?K9eFi/b7pJUhY8Ko411lXwFYvqiOYM9VMAqULIlbbbPdSe7A66FinjK0zeBD?=
 =?us-ascii?Q?YoYoP71z2M7fbsQGTeGqxbWyw4KzajfmbDx4PwAqIAsMj/4XHVUkvjKbDbAQ?=
 =?us-ascii?Q?R8gd5A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92b684a-046a-4e0d-364d-08de2dadcf5e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:26.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2i3EW6zTSmIVlnNFxDey8c8/9n91baEVWz8ccydfwTZsAn1i8P6W1O9QO8SvJL+P/Oqp8aQVHQDSjzZR4NZLHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "gsw1xx" tagging protocol populates a bit mask for the TX ports, so
we can use dsa_xmit_port_mask() to centralize the decision of how to set
that field.

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_mxl-gsw1xx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/dsa/tag_mxl-gsw1xx.c b/net/dsa/tag_mxl-gsw1xx.c
index 701a079955f2..60f7c445e656 100644
--- a/net/dsa/tag_mxl-gsw1xx.c
+++ b/net/dsa/tag_mxl-gsw1xx.c
@@ -43,8 +43,8 @@
 static struct sk_buff *gsw1xx_tag_xmit(struct sk_buff *skb,
 				       struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
 	__be16 *gsw1xx_tag;
+	u16 tag;
 
 	/* provide additional space 'GSW1XX_HEADER_LEN' bytes */
 	skb_push(skb, GSW1XX_HEADER_LEN);
@@ -55,9 +55,10 @@ static struct sk_buff *gsw1xx_tag_xmit(struct sk_buff *skb,
 	/* special tag ingress */
 	gsw1xx_tag = dsa_etype_header_pos_tx(skb);
 	gsw1xx_tag[0] = htons(ETH_P_MXLGSW);
-	gsw1xx_tag[1] = htons(GSW1XX_TX_PORT_MAP_EN | GSW1XX_TX_LRN_DIS |
-			FIELD_PREP(GSW1XX_TX_PORT_MAP, BIT(dp->index)));
 
+	tag = FIELD_PREP(GSW1XX_TX_PORT_MAP, dsa_xmit_port_mask(skb, dev)) |
+	      GSW1XX_TX_PORT_MAP_EN | GSW1XX_TX_LRN_DIS;
+	gsw1xx_tag[1] = htons(tag);
 	gsw1xx_tag[2] = 0;
 	gsw1xx_tag[3] = 0;
 
-- 
2.43.0


