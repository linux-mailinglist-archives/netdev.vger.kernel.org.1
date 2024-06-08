Return-Path: <netdev+bounces-102005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEA901142
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6FF1C210AC
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7005176FDB;
	Sat,  8 Jun 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bxOcadDS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2100.outbound.protection.outlook.com [40.92.59.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5F6D1B9;
	Sat,  8 Jun 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717842055; cv=fail; b=t4Q8HoBRE2zp4yD1J8Cve0HVQEs7V/l23fqi8760tffAMi/R7hHhhsIvwZ56N/6EnLkSQfdsEh7rBJWyz6vIpAErhsgVqailjjg+QWfYyBpxRv+ZoIELnxcAGAEME1D11i493Q8pkvCL4Wg7yqcHQWubyW8lIKV5L6C2qGPQuVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717842055; c=relaxed/simple;
	bh=8seKpHwQlbYJ+28J0PbbqWmxSvq9q3QjlBIyD5lg4Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tVDfYxDtZMznjiDTHdo+ahQR4dxsET2teRS2wLo/DMcPGI8dUJoSWwhXUnTCdDrOtA9XM9debPi4fd41Fj3uPi+aLwen3HfrJRnPdog0FhNc9wjN/v4g22dUOs6ApH3KRTv3u3F64cKyZ+7ecwTXapyYOxx20n3j7O2HsvZbQ8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bxOcadDS; arc=fail smtp.client-ip=40.92.59.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6SDbRHxsZI59dyhhOzaxmsgst0CnJz7CETdpQ8UDhQOuIWVGuokfGG9J8BJJSmFxzjryBN+S2OACgoxYLc/EOMtm6C0cn5P99Jf9aAPnfyzo0zyTKC7zo7ha+ZmimGno+EcgjPPT2UikPSxq48ebyoN3ShaV0lpbqJlRGqgHlfr94fgVmjmeL9ujGZeZTXSdeN2GR7iTvd4djbvrX3emXzXHmpdcs7hEZzLt1qm6F7koTIuc64GJ6uGiAx3wa7/3eEfI9y78Mn/DrRddAm8vYYSyyyYRzjfezcSJop1/2BNejVqleb5+TerZekuHP92N6IwS6SJIHPiztkBBegigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4MAi3qupd5a/zPJ5EmNQarPAzWOexHBbVMVLwF6T04=;
 b=IPeVpeXi6RPnui3nZjGAMlZWVa9TGX0lCVgkTYTcgxMuuKORKWluoZqbc5BtdKEi0N1c1eIrj+Z+Y+5P2BKcjOcYwfvW8GU/jdOb33/aEd6X9Zawvgsi9WOwCpqspmeCVdqNTGVYeuaqlMU5oggg3OdK+Eb+1TatxBQ11Erki1goKxDQrD4t+fFYpzH8eGnEbTLqYF7RnPHV+iy1J/icZ5fo0EaszqwUY/y7tNX/zrhX+Hr4Yr8eJNt1gaWadu7s8sbznGuNW7KBXJusAIjv2tIcBm2slHdu26jJdsU4UHezMT4gtX7wxXNPz7OH59ur1iWvVrWW/7hrtHS5CqocOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4MAi3qupd5a/zPJ5EmNQarPAzWOexHBbVMVLwF6T04=;
 b=bxOcadDSetVB0zghWdM4jcLKfA6I47nR5Sr/b6JOyBf02FLBETCNdpFvTZoAxT8QWIVttboon0KyDNXaDguBH+jWQ3P6K1PhRMAiybD98w/Ng1OYMakIproILBaRDm/nMAXPTQ4igx+5LOeS+b+9QQVeVvKRrA77Wx9KBcUhgy/XYry7vmsPuiFmZ3wODiJAMGbXbFL22m4XbWRc4xctV/1XM5JoGIj1la+TUtnJ4awUj+PBtdHI+2AwH/7mGPwRzPkvLWo490JXBmiBS4ZmI2YsLcnBtsioAVwM6fcecQg5ENncaAFtIczZ9tm87j4UD+DauyuM8qi8iJVqYw8/xw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DU0PR02MB9612.eurprd02.prod.outlook.com (2603:10a6:10:423::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Sat, 8 Jun
 2024 10:20:50 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 10:20:49 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Daniele Venzano <venza@brownhat.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ethernet: sis900: use sizeof(*pointer) instead of sizeof(type)
Date: Sat,  8 Jun 2024 12:20:33 +0200
Message-ID:
 <AS8PR02MB7237F187447FF71AE515333B8BC42@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [6+gLbE+DO8EHjGxZPd3nMflYuFiZkhIf]
X-ClientProxiedBy: MA2P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::15) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240608102033.4886-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DU0PR02MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8bf23b-92cc-4681-e32c-08dc87a4aab8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	Yxm+GzbSGMfG0mquHWs5F2k/u4uUC51sgjREGDmOJP1Cip07NtFIEkWEksrLpNEmJ/ptPnszVR8t6FgMfYQABxGzdPfgT2phsD3NMTjC5XAXlKupuIqyNM/LFjqU1ylfAEO2AUy4xPelKtCkcVgi2DOqUAI8DfeNg+1+DNWRgI75241j4jTz36as5IODPE+ZlCYZsSUcZOpJ2sAzhEHnlXicXetafT+Ayzj5hhTC1RaP58Foa3WuaY+0DZ14a9aJ8uBvkP7ssIKncJReLJV6z2SBd/UIEoTccDJFU1XFtoD2r+26W+pMReseW/KIXj6gs1VvbvSK9zgRrLj+cfcl98StGvZE7Jcl/cgDlcCCPMK7PHvsqRawe1Ow4ritfGPmSK6bU7sBjb6ameNDwRFLwTsKE4GLzkBwpsQnRd7gwBAgNWnFC+on/AzqNko2DkmGZ4ghLaTtA5R/AHLb32E7RgsvwX2p423FdIMzDS/6gPY/54sUUQGoH0pVGOOTa/xqmouJ9BvE8RcZaQ9sQ3ic6j6euLvIYl5FtF83uAxwmpCQnmn33AX7T4cpuLCT7/76jVWBr/2qAFjrDRaUHHTaweuX+FWMgWsB58kGjF4EdKw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S45kq9AvTdCGTciVXKr7baLfkWO5aX3N7lW+dadllnXrwbxKIOzJOv/+odto?=
 =?us-ascii?Q?ihYiUyuMDe4H8/MAzOy3Xy1TnHqteuWzW55PRULkVeqwa4/+J4Dqk6XBX+8T?=
 =?us-ascii?Q?xifFIKxpw/LOYTNtHIC8OSrSnNFC5ER+yokKuX8QUGvrfcty2ALH4xnRXMQ0?=
 =?us-ascii?Q?52Uf6OMScOXKHNzlWGfjHGov5N7vCe5I2N/wpurDtMq8D7Uzbn9fWBnyYD9E?=
 =?us-ascii?Q?447HF4mueKmu7fIFRwlsKYTqNRNw+jTwo9u3fCFdjghQTGeAf8DsqLxRvnto?=
 =?us-ascii?Q?cue69ceHZnQigR0dSTG0CUSUwgQkldfZN7171NpsnVqNl0+jemXDVsO+zQ3/?=
 =?us-ascii?Q?rVbPwLTAiHPMg4Uq+TPZyRwhMFDSbY60cBb5wXlt88cKQst+8C7w14grC8C8?=
 =?us-ascii?Q?it2j8b7dGdOnguWdOpeIkBozP6bZQ8ZET2fiqkZrz+GmH5ALODFuUB3MicIt?=
 =?us-ascii?Q?EoKyBxMejSRM6x+Lsuxo6FjiUIO4J1Pguu1abuqSn/ABP+gbrEaXiTqjRuRi?=
 =?us-ascii?Q?n0G+xHffSYLl6ctmP/ruSN8XjQm3Q78ShzmRv2Y6AomIyoMPdElcPW1x+nOE?=
 =?us-ascii?Q?RvyzGzFBWabKekmaDRMJ+8MrnxugM+AZjZnMb2ItDmZsokiSNU6Z/spD987a?=
 =?us-ascii?Q?LHgMyVLpX7ma1ZgdUasPLULHEgfKhSwZTrhYTM9p5ji6zTvJRCKAR0+9luMW?=
 =?us-ascii?Q?5/JLRG6f5UAmyuejrTQaTw1wvfoUZhyJ3BeEkmhPQkG16YlfO5P6S1VOawK/?=
 =?us-ascii?Q?Dn2UCLRx9gKZCKGm2+ZJmMcTaZeZmMfxcOhsaDx8p3NinBMuxif3Jhp5/8RX?=
 =?us-ascii?Q?O4IziNvGIOp4K3eMB52xTqzv6z0lEQfILkl41v8tojgzcLxteJnrQhisUisA?=
 =?us-ascii?Q?L411aCHcDYnRFIhpc5EvFh/DxhJSrU+sixuR0mW5mk+kf9OcmII5iFGeF/M5?=
 =?us-ascii?Q?9yHpDpNi9OAuUQ7P1setmH9YF7/2urQuw+1GZ/p6C10itWTy+meGx64XN+PD?=
 =?us-ascii?Q?L/ZRx9sGy5ZTKe6dc4bbwRk8d66euiZO9hc4i8/lbj+2Vzi1fLiNMD88MoWo?=
 =?us-ascii?Q?Fq16Mu3Ts7Cc5+StTNTvAb6wjh2BxcaSMV8q7IWi8cI7DYOtZy2czYB6nNwh?=
 =?us-ascii?Q?JS3GW5MXctvMDGHIVsQOokYOYpvRVbbHEtfxppxuM0uEN/faK/iHStzugu1I?=
 =?us-ascii?Q?2x7SsX9+/Cpue1x5IgblcVE6wyPc17QHotcL0WoewgLcpnn1GDBhmTUDxFJ7?=
 =?us-ascii?Q?yWb24dyudjvBdbsCTcrD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8bf23b-92cc-4681-e32c-08dc87a4aab8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 10:20:49.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9612

It is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not
change the former (unlike the latter).

At the same time remove some unnecessary initializations and
refactor a bit to make the code clearer.

This patch has no effect on runtime behavior.

Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/net/ethernet/sis/sis900.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sis/sis900.c b/drivers/net/ethernet/sis/sis900.c
index 85b850372efe..5b82c4763de9 100644
--- a/drivers/net/ethernet/sis/sis900.c
+++ b/drivers/net/ethernet/sis/sis900.c
@@ -614,11 +614,10 @@ static int sis900_mii_probe(struct net_device *net_dev)
 
 	/* search for total of 32 possible mii phy addresses */
 	for (phy_addr = 0; phy_addr < 32; phy_addr++) {
-		struct mii_phy * mii_phy = NULL;
+		struct mii_phy *mii_phy;
 		u16 mii_status;
 		int i;
 
-		mii_phy = NULL;
 		for(i = 0; i < 2; i++)
 			mii_status = mdio_read(net_dev, phy_addr, MII_STATUS);
 
@@ -630,7 +629,8 @@ static int sis900_mii_probe(struct net_device *net_dev)
 			continue;
 		}
 
-		if ((mii_phy = kmalloc(sizeof(struct mii_phy), GFP_KERNEL)) == NULL) {
+		mii_phy = kmalloc(sizeof(*mii_phy), GFP_KERNEL);
+		if (!mii_phy) {
 			mii_phy = sis_priv->first_mii;
 			while (mii_phy) {
 				struct mii_phy *phy;
-- 
2.25.1


