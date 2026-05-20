Return-Path: <netdev+bounces-289869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO55GLGKDWpKywUAu9opvQ
	(envelope-from <netdev+bounces-289869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:19:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB2158BA0D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44B5430D26E0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810AF3D6461;
	Wed, 20 May 2026 10:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066343D649D;
	Wed, 20 May 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272011; cv=fail; b=AWfnYNAUi06jSOgsE+vNqZ69u4mC1URA/MjnZkZfbV3l+MNKN46Aa/Z5CG/ASrAKZS01kylwKQ0l2o9XMFDhCisdXsUJqV44f69WeRMVELbVj/i3ovUQcQOlNJL9VnotYT7uGzPeCrJPU4iyxGX3GeVd/FX2HMr7whwDhtcgcgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272011; c=relaxed/simple;
	bh=9AiZo7mtWtssM59WQLW+muk90H5UMP5BBE/wuL130gE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O2AYwBOlswgjT+gS5rfLDNiZDkreCX0RxFhLSPyuaf+JiT2/6k9zvU46Ag73uw/kDO9Rbwnpld0csWpvUV6iONEfVO9mwYBFdv5iNdRUQHVaVpeieeR8iM6LVGuA75GjXFG40RlePyEFTRhLdyiBK6WOKl5P5+TU3uZ5K7YqZyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFAnZ2UY+yC8l5BkiUbDto5m8Ryo74OKHy7XL5uk4NBC1GRwq47+NUB8ANEEIjk4wcAOmPvuKr6sjUJNAjysltb5ZH+NAvHWtotxFNs2mCg5r0mc6Y0TTUgvHY22ho8mmkuAzKBA6rotCLOOd4YNkHKxg01MAN4UEZaRTDVyR+NcLnpRfwOH6J0ddnlG/Dy81rzucU++fgrbDfceP8OJgpj6QN5pp7/B3Q8cS1PAdOuWB/lkvppz9kbT9HY0g8b99rmWdXBEKAzmh1dJl20By++1SVBd3KVHMGxVcyqZpCTtZ2GidZR9PlFggDeEAcOilVpUo6jS71Xbv8bD5pppnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBRwgkdjQuW8bviiRux3ipAuNc1MHyAH8ZYx9+v6Lxw=;
 b=jBUad7CuPdUpTnk0o3xVXFAbomcBogCVkd9d44ZujagrmM4V8UltmjovVc/scakcWjUCasKRLx0lgs6uGsH5siCEJYQkETI9ERtGPQZ/UducjllMiuu9vWGiv8IifF2OkxhTYNEB/Sm4Vp3kD88khO/R9r8YYoJ4SmzeWHMV7+cDlBbKvZogL2WK0hl1gYyv3DtU3NrzzKfPlEeayud9v9tdCt6azd3cvNpIo/9XiJVg7DudrJTKRhVvpLx3Q1CYtreExrM7rKmSsdVd5DRJiWEb1jpkli3r+/7mmROn8DByx3nit5OgjljUbsEezl8ne/ipbaRAezAkmJ97UcUw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0637.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 10:13:20 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Wed, 20 May 2026 10:13:20 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v4 1/3] net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
Date: Wed, 20 May 2026 18:13:08 +0800
Message-Id: <20260520101310.128969-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260520101310.128969-1-minda.chen@starfivetech.com>
References: <20260520101310.128969-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::22) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0637:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dc1de1-baee-4356-7cd5-08deb6586b0c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0kucCLE/rBFyL5+QJraW1rj5CMWgBJbUDQ5ogid0SkqilhU35bqq6/EKWlRdWicX3ZRc4G7l0VPMs/UY65qHET8pmO8zn/YrwXi7etyaZwg35iGgf79y2SJxv6TwgIRq8+YkHjdDbkHa+0yO+0TmkTArTjBbV4aw/I5tdRcUIY0uoJX/YURTVLo9lqOqCGQ2DtRzpuMD4idr5iU/XewipuCIEgD2uYwKo/eNV/TWdewDNjrEhZNvsvxOXE7OZSMZVsKJYiuP+3Ed7Q4APq986bYIThu2zptx7a08bZJ4Qg/mh9+pmgH97u3pyL94v193PyRdp1ESAKgbH1JbWY8WFulnyAdvn1ZUz7Pr9fiMGt9MEVA04mKNlxukn7DDQZvqcn1G5cP0amyMUuudAWvsCLlU8w0Z8yR0eI0NkH9nY95BA7BV38gxrIK3ykjo8gX7bAz7vuPJYZE3fHa303j0Jmh7EFrA7SeP3EYp0yjFRNnSeK7WxyaH7YFWWdWtf7waahtfME26PT3w6HR3KjoCv/CZD9JSVwmv+61IEGjZExtCmTvGhb7RDuRz6sbjkVtN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W/cZYrc3skCkB3iEaYlP8JQ9Nd0DgyvffO/VZ/NecH0NKiF8rJwDXTClm4xG?=
 =?us-ascii?Q?6y11s6FgVHxpmSPCcZKlg/HkPpMe4qBZEnr8heSzhSS0HziH0dRtiI6VApkE?=
 =?us-ascii?Q?Kyoc5vn4QhO/rB0Pk814BUL1Ce2dgKOuoZ3PMeN+VIwGLsjy9+PgMu6EW7LO?=
 =?us-ascii?Q?lfkllqqdeCFJTkELXGLYCu/YzAM2Qr81EhhIw+1jgygKXPrdBRw7imUKldGV?=
 =?us-ascii?Q?+K/Af/qBha9vVco7KWCFN0TQlZjzvUw2H/eiZXy1qxpeCvZ1bT3L6CoAi5mb?=
 =?us-ascii?Q?4ptqQ6dam4uZmB5yJdo4fw5r404Jvs0pxSePpstgLZRi2UKZr3SXpeR37iFp?=
 =?us-ascii?Q?RhZ6KI1y7ybqacxfIwuZyuP+NJSVD1szR6aU8nOaqXZqEpZrcwrdckGOIdCi?=
 =?us-ascii?Q?zv1yWqhkSVzJcrwMvfbzbl9vjpr7lkPlomxpgzjK/dkmPDUatSHR3RcAsvxg?=
 =?us-ascii?Q?RcQuq+zCVc3uhdsEuNcGWKI755BD1y2HMm7Lj4cimfcoUt76MoCSEac3hKvu?=
 =?us-ascii?Q?ZgV82DMlDjBQ/5h8fWgLR7kBUdHDSCuYDoQs04pQy3vImMtheqellbBtlZ26?=
 =?us-ascii?Q?9s20voYSQmK9A89n4q0GGjH1tsJOn+kAoYAGfWuvwkQdSBul02N9CVHXjMna?=
 =?us-ascii?Q?7b2d9msrHtPizHdgx3889fLEf7PScs/g4eKGrQqBsrnRo2jpqvFj3Ui6mffs?=
 =?us-ascii?Q?qaKHYRZoNgKYjYfUWVg9EzdAJ1Lac5roafSmqhV0pS3xKruOI95PT77h5dvl?=
 =?us-ascii?Q?6OwcrnEjJ7RRqwLmARoiR+W7TxPtjOLGqGPD9Q1OSjYIYHZP/u1sGtAXva70?=
 =?us-ascii?Q?9sw5/nLG8FCYF3Z+f944a7S5w9iA14WC2QvkhNrDLxx+/5ErRor5El25zMUg?=
 =?us-ascii?Q?c+M/B3cyq8fwN+o/uLF4MDfjSklxO/rJ/twVGthlOCduomTlZY8OAvg1/sTD?=
 =?us-ascii?Q?sYzpWdjUzCKZTmrCHRFRwAk6GE2BRl6nPRWcQUcMv/FVeO4jlIPwPNF+vMYG?=
 =?us-ascii?Q?pZ+KLfii+aqIp36I8RONEkHKVd1Nlsoredm6qTHIWprxTkDQIeP6N93UjgU+?=
 =?us-ascii?Q?hD7oHlxZjxEBUakqgnADOHKpm5qjNojhvkdutqXJmK8FyDWrS2UdrMj/pImL?=
 =?us-ascii?Q?3i8f+mJ0sDECRkPBZ1KHRGOCW1HoAQnJI8uC9fEXo/Uuynnqm33Mjeo9uWI/?=
 =?us-ascii?Q?XTy5T2yI2Xb85ybg41qljqRkXdA/aGcSMxYuEm0ADi55xQND7NvflBd9iQCR?=
 =?us-ascii?Q?bYN7BbWMTgugdmQZMmT6TOD3SuaS0jMIPfE34jnjWymwpODVihsDoCQN+M6w?=
 =?us-ascii?Q?m/tvN7VRsRxXZG6ye3w8xoARLNlqSZG7WXwgWkCcYLgMCfLIJGjy5mNtL+cs?=
 =?us-ascii?Q?FacCYub7uEE1Yr8UO8tFxe1VL4H3N6dL+riGf6JpF97Vg2av/6Ev0Igi7VJ+?=
 =?us-ascii?Q?WRd8lq6KOpAFzCaQxZw+6rBp1hDx8Flu2yZrqTpBGIZL83tQDs4h3VDmItZN?=
 =?us-ascii?Q?KG00XlxlAjeHdgq+ACorv1DGbOJa82dT8l+mxFJ9bEKN+c9DRkenw87RbhJy?=
 =?us-ascii?Q?henKkxRgbXChMztrvk0dJ2mNXjd0qcswDf1CoAVxKmbxiaPqVRpUQk73wkDO?=
 =?us-ascii?Q?FWHH51zvTvexGJv0yn8QDUngDPIy+Z4YBMjzvlNxzWmktAMaq7ez7312Kbvn?=
 =?us-ascii?Q?FRCde/9c6U+z20GrYambOY36LcifpKZVQcFwUu8oj3UJfjtqPRtY6wDsAXlz?=
 =?us-ascii?Q?5vHvSFO9IuTOGY3HY+cwlfhP4xGrY6s=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dc1de1-baee-4356-7cd5-08deb6586b0c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:13:20.3977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAno1gx9InhX4ptQ5zkyxEeGl6uI1C/xPXdsEoqjuBp5BZ2+ma7GSsLa0G81czgfoThhQdws3ogdM9094l+O9ZJjoDjQu8r7OlBi0elITY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0637
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-289869-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,starfivetech.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EBB2158BA0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

yt8531_set_ds() default set register with mdio lock and only called
with YT8531 PHY. But new type YT8531s support RGMII and has the same
pin strength setting with YT8531, YT8531s need to call yt8531_set_ds()
setting pin drive strength. But YT8531s config init function
yt8521_config_init() already get the mdio lock with phy_select_page().
If calling yt8521_config_init() with mdio lock will cause dead lock.

Need to get the lock before calling yt8531_get_ds() and move mdio
lock out from it for YT8531s.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/motorcomm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 708491bc198a..688679457ef9 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -974,7 +974,8 @@ static u32 yt8531_get_ldo_vol(struct phy_device *phydev)
 {
 	u32 val;
 
-	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
+	val = ytphy_read_ext(phydev, YT8521_CHIP_CONFIG_REG);
+
 	val = FIELD_GET(YT8531_RGMII_LDO_VOL_MASK, val);
 
 	return val <= YT8531_LDO_VOL_1V8 ? val : YT8531_LDO_VOL_1V8;
@@ -1010,10 +1011,11 @@ static int yt8531_set_ds(struct phy_device *phydev)
 		ds = YT8531_RGMII_RX_DS_DEFAULT;
 	}
 
-	ret = ytphy_modify_ext_with_lock(phydev,
-					 YTPHY_PAD_DRIVE_STRENGTH_REG,
-					 YT8531_RGMII_RXC_DS_MASK,
-					 FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+	ret = ytphy_modify_ext(phydev,
+			       YTPHY_PAD_DRIVE_STRENGTH_REG,
+			       YT8531_RGMII_RXC_DS_MASK,
+			       FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+
 	if (ret < 0)
 		return ret;
 
@@ -1033,10 +1035,11 @@ static int yt8531_set_ds(struct phy_device *phydev)
 	ds_field_low = FIELD_GET(GENMASK(1, 0), ds);
 	ds_field_low = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW_MASK, ds_field_low);
 
-	ret = ytphy_modify_ext_with_lock(phydev,
-					 YTPHY_PAD_DRIVE_STRENGTH_REG,
-					 YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
-					 ds_field_low | ds_field_hi);
+	ret = ytphy_modify_ext(phydev,
+			       YTPHY_PAD_DRIVE_STRENGTH_REG,
+			       YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
+			       ds_field_low | ds_field_hi);
+
 	if (ret < 0)
 		return ret;
 
@@ -1825,7 +1828,9 @@ static int yt8531_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	phy_lock_mdio_bus(phydev);
 	ret = yt8531_set_ds(phydev);
+	phy_unlock_mdio_bus(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1


