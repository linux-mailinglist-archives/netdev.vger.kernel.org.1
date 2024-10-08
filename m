Return-Path: <netdev+bounces-132984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE5A994098
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA161F2623C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7820493C;
	Tue,  8 Oct 2024 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LM5t1H0o"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011006.outbound.protection.outlook.com [52.101.65.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C46C2040A4;
	Tue,  8 Oct 2024 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372232; cv=fail; b=gxFhlpFrTXnihsHKNjpGHP41/gkfr7hSI1IgmKyD4Yg2qIoAYTh7tKt34i41pPwn3b0GE41Py2ZvvUEJ/BxLyF0AtYFy5JGTVf7mrV8rs2hFJunERUI2C/uahwtPELMGzflI3CZo+i2EHH+MiU2tFgafcGFOQmWft2RqKPAJylc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372232; c=relaxed/simple;
	bh=iHXq2EXMqHDOtVFj9RomghryepF/dkX1fp6kKaL0+Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2ORxqQlEEtvXgNv9K1pO8UqnyvmdR6IttUDPoiIDLOwvUSFGZFCZsE5PTgAGHkmBuK9sWwRvx55OhvIbYOiUUL98Er/gmPHwRCwZESSCE/DUn9ZlcytmULUuQ5IYyIJrSgyFtM8iHDwxcI9rZtzwkq8wkH2aOHi6e6kG3dU83w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LM5t1H0o; arc=fail smtp.client-ip=52.101.65.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNn0Fgu/HiDdDfO98jJRNm1TQBtJKypWVDo/IrMPfRzTF6o1vGNaxuBWt5sHmyYY63DD1vaIHl05Lzo6JmUXJmGCtl/H6GuyyEHWeAS/FrpGgZRbCipbsEihd5WrqVo5FbtnTHPOkjjhTuqkK3zSiKt36tCMfWwof15PPY57WxuAZFdz3dIZ6ddySsvdM8xvN51sWgpZtvEDFaAIwP38PSbCWSYVg711tM/WLHnrKM23MEOcL1Ew98dGeArFPXyj3zyGm8u3cip0MLC6BKlC8Jtm0wcUNUFNHzJcNatqEX+nyqt/GBXQt4jws1NOF63xgoVD0TYvQgo8gLZFhtdKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5ubiVxsqJp0DsXK+Bmy4zK7XVU+XTOKX1rmkYO2ZIk=;
 b=oA/oRXlcR4mrX9MooUb98Qq9sJVaZBhqWGsYWlK6XMVUib31SMp/1yEqW+ZIe2d11P7Ndlbp3YLTZu+4U6jy1cUsBbm8P7T1bGnu0yYFPlxU7qu34q/GahoOjmKpEVg1xb6/FLQCWniQbnaaE+K0vE/gvO/alXLQBNvnka6sCSDWEq42bUL+bdaCcevCszt9+tkYMt2T6J4n/nGZnQPY2Ug9WiDzai6mFa7q+bmc/pKPpgGPDfmOfOTiKnboqcMiPiG8EjAtFl1SHLCUom7KllucE6a/+Hk25oe11MLlWiJssbrOB/pSawGkuNvoKYwtulRqh1KIVUisfI+FUxxJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5ubiVxsqJp0DsXK+Bmy4zK7XVU+XTOKX1rmkYO2ZIk=;
 b=LM5t1H0oDvWOmWumH9Mbk6WR6uRLHq7a1+68e8b5cKWi3t2KhH4QGEfgk0plSJxNKC6HfmRHYALlekoBscgrXUJ3dgtuyu8Qb4pnjketfK8oQyRMOAzHrwkEKtWxGceIcqqMIONcOoGLpJtqsfna8f+gBTgoNFxpdItL9vTR+9vQgwWOqy04ZpM4QoJ9NyVhJUs1SxL+Wb5PH3hP28zw/axeuizLzMpEE+1uprzZGEc0xYR0ZvJpY/rhP6hXRffc2dinoffUWYX+/iDaORkPXUrib9xCDbQ5SfElBsh++PnCh9/mYCO1wzMKH6F23+4qW7RHaMJvGSKT/8/s7SRGkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9564.eurprd04.prod.outlook.com (2603:10a6:10:316::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 07:23:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 07:23:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	andrei.botila@oss.nxp.com,
	linux@armlinux.org.uk
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 2/2] net: phy: c45-tja11xx: add support for outputing RMII reference clock
Date: Tue,  8 Oct 2024 15:07:08 +0800
Message-Id: <20241008070708.1985805-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008070708.1985805-1-wei.fang@nxp.com>
References: <20241008070708.1985805-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU0PR04MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: f4616c1c-ca27-47ee-a2fb-08dce76a2292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uA/QeIN3LcxctS5gQAugroAX81eEVm9Lw0U5oPMIPaaf08BKmCcgvdahmL1c?=
 =?us-ascii?Q?xjlqvAbeBQethWFdLqZ+YTiVJqsw4W0x8+MT+BFXD5SmPT5Cpxn9bFUGMuyO?=
 =?us-ascii?Q?1cY4utEK1lMJIl0qMZfTBjDhi9Kf9hoPim5y2T3MfGifEgwdyb69dcGq3Mwf?=
 =?us-ascii?Q?e9Tb3l2xD7dfwAKgFGqwKisr7mqhHPKklNNsQz64vYrGtrGxevux54ZHbDNl?=
 =?us-ascii?Q?4anfRkT/QAEeFGD7NjEhmsQNGzhSueZwx8Nze7N5fDojDi3qtl96/MI1QP1a?=
 =?us-ascii?Q?4AKxFvz7gYCW/Y+nsqbq/RUimItEkdtg8yJnstleACuS8A8h++hgcHHc2LYU?=
 =?us-ascii?Q?u6r/F8KodWRw17IDZWn0Agnt0w5FDr6SWlrBaWfJOydC+hfORQ5KIrvP+qBZ?=
 =?us-ascii?Q?VUCvghICGGD7KbPQIi8CG6AbVEk8Gft35bB8E72gigSS+O1V2ixulB2r7IXj?=
 =?us-ascii?Q?BW3xY5oCzrJlwiUY4rx3m7aD9Xw56WWpEvZjHrUK+1jR9FdxZvaIHWz8dcAq?=
 =?us-ascii?Q?b9lDaKmCxZrQIeu7z+xhNTjBgvtyycVpbbauSMWkGxlls+qGx6S+eQrLorXV?=
 =?us-ascii?Q?Avfne9JeCGvdv1rx24Ci/vDwASrJEWfdw7pVljblJPSSoK367vvz9qbISju7?=
 =?us-ascii?Q?PlJk1NuKPFd15LHI8+5XyeFciyJMbxV++KDh+XRFpmqLPGzKVayjUzwXzvFr?=
 =?us-ascii?Q?R1lTrv+siereEDFlOn1Vtda2mWue0kEz+qW3dJIaQbTBGHgNLdtG0vmLSrsa?=
 =?us-ascii?Q?+avsZ1RpSG271T/UT4t8S0iW5Q+b7GQfSpUCnXwVL9Tc7MTg2pk1Jg6Q6/X5?=
 =?us-ascii?Q?AGChBFF6PysGPqJIXcBEVdvkX1jED2XVMjlalSzblLkXXHzQa4JcsBIgRYLd?=
 =?us-ascii?Q?5joZGSdain8i0z0+iYyjbO1KqyJ1xUVbDcXkjWUwIZGzSzT0iZRkGRekqrLJ?=
 =?us-ascii?Q?0G9+N4AMR+87FGCOQ2d+MnxcelGkaUxfzwO2+hh/ACBwP98pokbl7swu6TiO?=
 =?us-ascii?Q?XbmwHZDUVxmYwplFoBqDhq6BgOPZsFjuddzRo3uSim8HjRpx8ClGjBjXWSRn?=
 =?us-ascii?Q?e4M3rKDZcJAzEzxJeA064HV30mvcvCJiREcADTK6Wz++MPZwFedT5KPUgZbN?=
 =?us-ascii?Q?2JJE8W2glTU9+ufQBNktigPijoz2CVkwWzwPULRY5qjdf+nqNFJV5mEBfldv?=
 =?us-ascii?Q?vVUrvM70DTH8jRl76hH2GF/0JPku5Ax8ua9l9oQka4kZsvjqkFAyRMvlfmth?=
 =?us-ascii?Q?vLxHz002TEhIgj9WjCwqnYK+HjDGUn1x3ibw3111BYKeeVEHFlIZfF9m567a?=
 =?us-ascii?Q?YaB0SbdwvZH1F9z482CyoxwElL2VNU1FCC53wsLN0pBasmbKa/n4OvVjtORn?=
 =?us-ascii?Q?3QRoSiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JvXIpfs07B96Tg7XJqGxXpVWY5TTjsN5I2Zh2D5GAjwWlQyswmCpDH01uYSt?=
 =?us-ascii?Q?W8/7inKVPMy6lC1PkU+iXj4HjaJI72Mt3qIYXgRm0MaEFj/Db47uXfpJuYtV?=
 =?us-ascii?Q?Bz5bERm4W8Cmo5kCARxahFqqerJ2qlhs9IgxJmNysFPaHSdRMlAT13iQLExJ?=
 =?us-ascii?Q?yYQvexDjca6dW73GviWCavm/bLDu17YFOv+jygjLGIEUXCbxhYp5O+42rquA?=
 =?us-ascii?Q?iDCoUml6bv9mBRtjHhXurg8lAWdsLI2riNJmOXUYj/+SW2XlznW912qRGMxB?=
 =?us-ascii?Q?0+qrIKz2enOY3JYwekWwbsnhC47IoHwd0tHDOuNg+S3U0+tS3FQVwGHnQZIJ?=
 =?us-ascii?Q?O317HoFNy0pYiW+inAKSK1ZXqZtCyqOhhnPMdn+TR1EJtdmKBEmDaUwVEbve?=
 =?us-ascii?Q?ODrFzyq7aMLTQykoYtl+BUZI7F3zq+UORtnFqQrPkKpyVMgUWdouJ/Dy3QY3?=
 =?us-ascii?Q?k2xbU0ZOgk/31xBNM/2p5V2p6GVJzSJXXPZEYYwnOkfV4aNti0u9Yc0yOTNo?=
 =?us-ascii?Q?vh8UF9Damy9/Ohghd7R2hTusZ96V0CjvZagKsmX/yfBgVq4yNb9yfQr3AQ8D?=
 =?us-ascii?Q?U/Lq033hA5sORtXrVSLsUK5H7x3+4VIpTmLxOGEO8ziedIb69AL30mD1mpOp?=
 =?us-ascii?Q?wuKsh6MdOtEHY3D0+61WpmGSNctG11nBk7OIknTWFf7SNy/UjdJ2y1evnHiI?=
 =?us-ascii?Q?NfGhOP9oANIz/XLN/ASFeSgCC1XuE+Tg/VWH5NZni5KOu/k9yitd+651u570?=
 =?us-ascii?Q?oZbyG8q1btPJKLjnVHTe87GYqv2fpZVqofU2zV91xRHU1FL8a4HxKeru85nu?=
 =?us-ascii?Q?6nQ2s/UbTboCF1VTFGv60SNPktra5H6cVjCjq4IkBQnhHmyL0g6dTpbPa/Eu?=
 =?us-ascii?Q?k/ovCgKDMc8wcS3LSf9EQzugyArLem5XCL8s7+dLea1XF2n9uyHozo+kTK3Z?=
 =?us-ascii?Q?sXgsNM7wJWvBNqAEiNy97NfHqM9YHh1Yu9yagPLJxfeZFfoHx7XnGGxyXw+B?=
 =?us-ascii?Q?6rs2sJl7sUZWWwZLYa7N7UzXMFyxhHnBguD0cbaweKhLD1gWU916SQiP0u7l?=
 =?us-ascii?Q?WAE590hyNbeZCWRsFv9CUyQpFPmehsXehtDtLT0YsDCGJ7CiX5T21223MkRb?=
 =?us-ascii?Q?8S8MRefpWzl16JRr5awMhsUEZGTVdosUzInEaM+ClA9xZfaMCubKB27xvq0c?=
 =?us-ascii?Q?rY6B6SNzJy/rkmcmdKSF9fyojUAwRo2z25DQGgjXnsXTRk5Sf8ejB6v+kzVA?=
 =?us-ascii?Q?Krdwy0DwGuR0oPoc9owp4onOZnl5jXczKMAxF/B4OSVR1/S0iO/Xpt9RwaHE?=
 =?us-ascii?Q?n+2MMtPO6iGw+EtRqNAJx1Ie8YzpkY26/KeXMgq+K9pTZ1NzgTqdbXlm06uP?=
 =?us-ascii?Q?FbxvEXWGuCuC/yM3CYHFEIYID5pRqkUEE2ythR+B1sfslYHmbd+yIO+HkCnO?=
 =?us-ascii?Q?GzJAsUvdVAR35NBGkcx143TKWKR0zvZ3kx3Q6vwaeQ4joe28gG9xDUwIc86C?=
 =?us-ascii?Q?cM3/IRv2ocPLKOthVs+7+JdNBevViQOQWsLmB9yUgd6F+4eLDw2u3i9ukQjs?=
 =?us-ascii?Q?F9WKlhw26+hn55gBn2ahJZCAi0so/PovsDFP3+bu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4616c1c-ca27-47ee-a2fb-08dce76a2292
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:23:41.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XLo7OfThhl8yHGzBkaGY6xmFo2Ul0dbe+Mzzxk3rr4dQhKx+9cS5pMyylqSWsuB4xO35JDTOolnwDR9rCfozA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9564

For TJA11xx PHYs, they have the capability to output 50MHz reference
clock on REF_CLK pin in RMII mode, which is called "revRMII" mode in
the PHY data sheet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Change the property name.
2. Modify the subject and commit message.
V3 changes:
No changes.
V4 changes:
1. Change the property name based on patch 1.
---
 drivers/net/phy/nxp-c45-tja11xx.c | 29 +++++++++++++++++++++++++++--
 drivers/net/phy/nxp-c45-tja11xx.h |  1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 5af5ade4fc64..3fe630a72ff1 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/processor.h>
 #include <linux/property.h>
@@ -185,6 +186,8 @@
 
 #define NXP_C45_SKB_CB(skb)	((struct nxp_c45_skb_cb *)(skb)->cb)
 
+#define TJA11XX_REVERSE_MODE		BIT(0)
+
 struct nxp_c45_phy;
 
 struct nxp_c45_skb_cb {
@@ -1510,6 +1513,7 @@ static int nxp_c45_get_delays(struct phy_device *phydev)
 
 static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 {
+	struct nxp_c45_phy *priv = phydev->priv;
 	int ret;
 
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_ABILITIES);
@@ -1561,8 +1565,13 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 			phydev_err(phydev, "rmii mode not supported\n");
 			return -EINVAL;
 		}
-		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
-			      MII_BASIC_CONFIG_RMII);
+
+		if (priv->flags & TJA11XX_REVERSE_MODE)
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
+				      MII_BASIC_CONFIG_RMII | MII_BASIC_CONFIG_REV);
+		else
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
+				      MII_BASIC_CONFIG_RMII);
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 		if (!(ret & SGMII_ABILITY)) {
@@ -1623,6 +1632,20 @@ static int nxp_c45_get_features(struct phy_device *phydev)
 	return genphy_c45_pma_read_abilities(phydev);
 }
 
+static int nxp_c45_parse_dt(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct nxp_c45_phy *priv = phydev->priv;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return 0;
+
+	if (of_property_read_bool(node, "nxp,rmii-refclk-out"))
+		priv->flags |= TJA11XX_REVERSE_MODE;
+
+	return 0;
+}
+
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
@@ -1642,6 +1665,8 @@ static int nxp_c45_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	nxp_c45_parse_dt(phydev);
+
 	mutex_init(&priv->ptp_lock);
 
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
diff --git a/drivers/net/phy/nxp-c45-tja11xx.h b/drivers/net/phy/nxp-c45-tja11xx.h
index f364fca68f0b..8b5fc383752b 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.h
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -28,6 +28,7 @@ struct nxp_c45_phy {
 	int extts_index;
 	bool extts;
 	struct nxp_c45_macsec *macsec;
+	u32 flags;
 };
 
 #if IS_ENABLED(CONFIG_MACSEC)
-- 
2.34.1


