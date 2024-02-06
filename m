Return-Path: <netdev+bounces-69443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B384B36E
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B471C242F7
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A214F12EBC8;
	Tue,  6 Feb 2024 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bm4mi9bf"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2051.outbound.protection.outlook.com [40.107.13.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266CC12EBE6
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218756; cv=fail; b=ArJORlZn6lIUScYoWXf581wxb2+4PCIJ7ic/trU0iDO0Ol2cWukahdNMTaAWbNdvj0Wn5w/IbSHeFEDZo0Uq0kzMzIJpNRFRIerzVmvUFMH3/Jt0hIgVKmpj7D23wqZKwX/XZpOMmaelyBvvDrftyjYADKEgE3LLYMbn83Qguak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218756; c=relaxed/simple;
	bh=6KRVjHPnNEzP6Fvx/PDOfMLJV3lJDUmdUuhTUUN4Lbw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b8MbjxQ60vpI7pjc8KxnnVfslbe/G75JCfJkp0BaCoTF3mdjqW5IcaHd59yU+FfWhfb+g1mR616Yq4JMfqktLOnq0jz4dlPr7VEye0SKYqENgtsFgXWNjdnLr0TjC86HdUuIOivWYGFjKoK6zY7yWAPVIj8XflShP4u7yagjX1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bm4mi9bf; arc=fail smtp.client-ip=40.107.13.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rma2fVpRAX7sJNqI931Q7fDLZ599TOOUcq2Vmq7HVral9slbjQ+EbMz0G61yUgnJIX3pD5kakGxE+ov5wiqiDTpRmIRy8IlPjL1DUDe6/3+19kzoU0KGXSd1UHoyVsWinH2t8CGQpGt+yUShVdoxc88C7utuCS0wSyYMX/GD1j5G7AmrEyaiaKdn83y5wRGAQksAVeB0nRuuGobg8sTSvb/0f/g2aFdfeFhW1vz8l6erwVqexIryV57mbB8gUbqYojU2ZfoRAyiCeR51sVE+kVZOLE1dEAJZplYLdaQOmy1yHwFm0zMsLvd15gibzXwTE8/oWqczXDEGGQy2yG6O9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlcfF4losTH9HnVAlD7qxnEY84Uj00X7qfYCaYwJtDU=;
 b=D3lBVAZH/tZ9dAFbKOfkFWocpa5SetdujHXVT09+yN9Bu48IvV4BD5dYbuJFoK3JcnpIrb4MJedqBd/69SV5STyphvhVPR4tCHQlQASBKSYw7bwXy44QYxBYoMTswLMgUBKEc0dKLMJXnTDKcdTfcxXjOAd1rcV5WmHK8j0ZG8FTCmQetbZMPphaWWTgimq9VmKQncskO5+9EZNJJpdMCiiEa+w03BQgZiEvGZdgFdXm7C6GB3FocSQ3O0/xqYUA0756uotabZfUfzbThvxe6GOeXj1xX+vKk4ZWus1S9GWxyNMbc+U8B2ezMKWEyhCRp7d4sEu6MuiO9uefZud7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlcfF4losTH9HnVAlD7qxnEY84Uj00X7qfYCaYwJtDU=;
 b=bm4mi9bfjT1RVIfGEJCPDVbrV9n8pNtf3tlb49LqKRsgZggWpgxmYr+Q473qod9i+q5nnyhM4wwfPUqDdTTK4HjP4Dk5WnA68/KdoD9oGtoFWe+krq7h1cTyn9QaLW0ydiWJyUiwcbg4j9dmuIbk/To0+x3SdJFvdnCcA2wUT9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 11:25:50 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7249.027; Tue, 6 Feb 2024
 11:25:50 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next] net: dsa: b53: unexport and move b53_eee_enable_set()
Date: Tue,  6 Feb 2024 13:25:27 +0200
Message-Id: <20240206112527.4132299-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::15) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|DBAPR04MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd8d288-4908-4b19-8363-08dc27065f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PVyhmmauA6tLikVyzZeOfaKfiXlEBxTzpBp0iRbAg0/tnBOkn93Ga/czA0rHhdnrnf373MlY7jmBJAmbMlAxxZhk06+XwV1Pm8E2YSwNr8ytnUKLJBdbx+t4h6l2ve4fgtxep79sj0anmW4x8t6DxGmLvjDSAQ3WZxzEbMdEeC9MMNVUbg+Y4Ad3j/Yl0AgvUi2KiHw0AQZ1LEwmprFHLkI0cHu0958gHM9chs2jvbijYoR2qyL4UFQDyAs6CCdKEETZ4G0qRRpMtTdlKtS5WN09DitTLBEGwXC1cQj2/opWyQHeWJEzFGdKdSrRXBsVFwPZhEM8a+7g7GGUISedexFDFLcsbYAM3wXZPwU9C32VN3wnTswZQqDTDNVmcL65uWLCH5nD0VCD5dsQXDz5Zrj3/RzQZ5w4hAVChaycSbTqwIJliNtv4YgC3136E54HnV5KZ489FgPG97clZnuUUhThDtk2RpyNAOusAndwlOAA6vCEaLzpAk7UvRZO+e7yAVvangcFhPJ7Bo2Y0eAplZgw6cN+hYL1Q2Gruc07pfM4QKeAGfVD00BYcCs6FeZEpGzl8+V5oowB330q7eTlMqoMrt8tlObaAAkY5EGig9h3TMydnyZ5yUpj71sYM0HL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(1076003)(2616005)(26005)(86362001)(6512007)(41300700001)(6486002)(5660300002)(478600001)(2906002)(38350700005)(66556008)(66946007)(54906003)(316002)(6916009)(66476007)(44832011)(8936002)(8676002)(36756003)(4326008)(52116002)(6666004)(38100700002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?loMxTKOqZ5CTxZ/NbmgEWxnJTCZWHLli35N6V8Lu7mbtCVN4v5gP5Ys/vK2S?=
 =?us-ascii?Q?P0DQv7aPQWOpxW+DuLOMJv7ODrbneaxdOD+IY8thlibbkHcznQMQ99o8EXWO?=
 =?us-ascii?Q?pD2FbgdDXqq4bJxKbdyNzfdW7r+wdSgWDPOhk2HxtwN42vr85SgI8FmngVIm?=
 =?us-ascii?Q?QFoYPbOKd7sxw5hXJGY/IVNPsFGm3UJVmVoSHmTicSOVK452Uv7pkfsFj3on?=
 =?us-ascii?Q?gQmDz7wZNQn9WPBgLvjDp+K9YKa5LYzgcyB3BBZeisl33mpMCpY67ICkvm6R?=
 =?us-ascii?Q?yEOoZ6BZHkObQyF/vQDmZZaQkHj5UX0gmhCAe3SClFMNQgK8Y5osdxTucATw?=
 =?us-ascii?Q?/RJ4K3bG6ne5Rej1l+ZbLdZc7SSWr5y3mDsIv8vluLAW97SKNDCWOeXnYSZN?=
 =?us-ascii?Q?BVq2VoJqYmIt8xYg6CfgcstvpbaCNKH3QFEy5s1+sjf4QQFoMM/38D0vLSOn?=
 =?us-ascii?Q?o9xHwrhSvI+rZg+Sm7tyfjv5ksm3QvJHDrPyp42RU28/bkd4YfEcSS/BljXQ?=
 =?us-ascii?Q?kOXjBDoeixOYgxgNvlysYS0zIzvB5KcQUg9J6ZduaEfdyAFcHD2G82qPb9ze?=
 =?us-ascii?Q?cPyiy1e+HTi8TqgcJJg1oeIL9zyLmKNANK157O9Wrh+P1OpVcXqbIFi6YvTH?=
 =?us-ascii?Q?r0LE2Yemo60VIYJ7iTypm30nVSr7/U6InVnb/GYlblpGDUaWXRUEnp8/XJA8?=
 =?us-ascii?Q?2f8IqAx0LPEvwD+OFrG9kt/vXwScwe/0jYJR0VxqDqXQAc5r1SHX/M+O5RvG?=
 =?us-ascii?Q?NQIi31y+jO5VpV091EWzPaFclO43h09sHaNMdbfAkqeEbXVtcUtsBvOYQtTB?=
 =?us-ascii?Q?2OddExXM76h/b2WM+GW2A+Te5C4HTa3plV0VvWLk8tYLj4hlLktoz8AaOuT8?=
 =?us-ascii?Q?3gm0kO3wanYQAdvpBGdETEaCvR+8P2NzE3q6nZ7B5RpwinhVGYu07njorK0X?=
 =?us-ascii?Q?4Vx8530GQ9gPpX6vO9EfW+k5VZ0vH1GeTT/BzetYMhQgbp0yleQAGrnIfUYX?=
 =?us-ascii?Q?R6d1iZ3FnQaezgVQBS/hQjbYoL/OkP6r9RbLSvYM/jb39FmT+9ODUfDfdeIk?=
 =?us-ascii?Q?18uNL1s8lVR+787nivOjesBQsChAXn4ZRhEhqAde6E9IeCDE/C92QBjxj77u?=
 =?us-ascii?Q?F0Cn+C5LA3vbAJvrqfsvpgACmg9xawdZk82qGbcvDP5gHFqHqYDibNMthcxi?=
 =?us-ascii?Q?M5Eq0x7J6MVBf0zGrbOvWqMeYcyAP5Zdl48ROvbnyJxqAZATR1m5EbgE5tWK?=
 =?us-ascii?Q?3f5/09+SBqgDHs1ssnno9dAz8T5V6WjBDVXa9nMvCwIPEnX6EQ2yE2OTALLt?=
 =?us-ascii?Q?fCkpLyNJ3bqmq/MvwLM31cUMAfnuzcmdMs6HK8xefZVfB1I51I2qsOAkOltp?=
 =?us-ascii?Q?FnCu+nQsTq/UX5t3WskG8MDs/tih6bskpouAjwzeGhh3jxa2L67oogtoPa1U?=
 =?us-ascii?Q?RBLc+FlLS98qu6i+3l94EJUVKdLXiqRH8YyrPYV5wwJf1v4MV4bohE0nnyNV?=
 =?us-ascii?Q?gcEHiKGC8SiwI6FSzxMN8NTpMxfuf5mpZq3vIdKpxfSRkp4g9Sqtl/Dms5Ij?=
 =?us-ascii?Q?kHnZjmlPHxRxMEKU/cXyxhOsinwf5c41qyBrBo7J0NGs3beZZtp4lwxyJDIw?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd8d288-4908-4b19-8363-08dc27065f7a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:25:50.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HM+ETFHkiC3AHbbZoFzLHjG0DZpL7kG2vPObd3KLH+46M2KihipIOS45Ugqr4rE3wbfZIKZ9CModDnMEYOWng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7335

After commit f86ad77faf24 ("net: dsa: bcm_sf2: Utilize b53_{enable,
disable}_port"), bcm_sf2.c no longer calls b53_eee_enable_set(), and all
its callers are in b53_common.c.

We also need to move it, because it is called within b53_common.c before
its definition, and we want to avoid forward declarations.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/b53/b53_common.c | 28 +++++++++++++---------------
 drivers/net/dsa/b53/b53_priv.h   |  1 -
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9e4c9bd6abcc..b2eeff04f4c8 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -559,6 +559,19 @@ static void b53_port_set_learning(struct b53_device *dev, int port,
 	b53_write16(dev, B53_CTRL_PAGE, B53_DIS_LEARNING, reg);
 }
 
+static void b53_eee_enable_set(struct dsa_switch *ds, int port, bool enable)
+{
+	struct b53_device *dev = ds->priv;
+	u16 reg;
+
+	b53_read16(dev, B53_EEE_PAGE, B53_EEE_EN_CTRL, &reg);
+	if (enable)
+		reg |= BIT(port);
+	else
+		reg &= ~BIT(port);
+	b53_write16(dev, B53_EEE_PAGE, B53_EEE_EN_CTRL, reg);
+}
+
 int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy)
 {
 	struct b53_device *dev = ds->priv;
@@ -2193,21 +2206,6 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL(b53_mirror_del);
 
-void b53_eee_enable_set(struct dsa_switch *ds, int port, bool enable)
-{
-	struct b53_device *dev = ds->priv;
-	u16 reg;
-
-	b53_read16(dev, B53_EEE_PAGE, B53_EEE_EN_CTRL, &reg);
-	if (enable)
-		reg |= BIT(port);
-	else
-		reg &= ~BIT(port);
-	b53_write16(dev, B53_EEE_PAGE, B53_EEE_EN_CTRL, reg);
-}
-EXPORT_SYMBOL(b53_eee_enable_set);
-
-
 /* Returns 0 if EEE was not enabled, or 1 otherwise
  */
 int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index c26a03755e83..c13a907947f1 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -395,7 +395,6 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy);
 void b53_disable_port(struct dsa_switch *ds, int port);
 void b53_brcm_hdr_setup(struct dsa_switch *ds, int port);
-void b53_eee_enable_set(struct dsa_switch *ds, int port, bool enable);
 int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy);
 int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
 int b53_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
-- 
2.34.1


