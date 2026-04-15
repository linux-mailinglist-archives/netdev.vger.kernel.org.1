Return-Path: <netdev+bounces-278735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCRUGvJk32mKSQAAu9opvQ
	(envelope-from <netdev+bounces-278735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:14:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C25BF4032FB
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B20300C935
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64B33B6DC;
	Wed, 15 Apr 2026 10:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2134.outbound.protection.partner.outlook.cn [139.219.17.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69FB3264FB;
	Wed, 15 Apr 2026 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247201; cv=fail; b=SGGZSdOMyOhYy+7kYg77bFzLtzLemEQ29i2n3/OnKfi2HMkMS/49LJ06pIydUZBFKPk+LDaXa+QXkS4KnjxCD2dQOYtO2PanvudPi4Yug4pB0wVns2ZHgNBuaNi8lKbsXIvMqQ1XwuglZDnZsprSARcnMXGDPujjb2X6csO6Dfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247201; c=relaxed/simple;
	bh=hjvpZx14lmrmdb4egOeL4Gb3pbpO5h/5vdaQelMWoY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ds+X1Znw3XP55FPxb+IQjyb7mj3M54rMF1oCwP187T9m9y1b8aimhXd+bSKFpSRNvlb9v140mHCB07pOUzwcLIZpO8unvJ2Yf6HnrzgVzFQfQFJ5KygTpwziD0j60W3xQm4SiMpzViT9i8XcZ5lkX/9LDdTCY3uf5FvzrnjVK+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfXcJyKz/x9UtjVrB3+QWfHkOe1L8NczFeqOhKaDmh3u/bN5ubMIEtjEUH8s9iDsqn/zjUwlVwyi2kh0XhjheypN/JMdG2bb1m67ImmwoOV9ovwy/hHlUIEm1VBKQ11VTVsh3LNWS8slKkokgCq8BupCfBjeqs2OIG1h635G5ZR8oO4CZeGuagrYKGlZGO4Jjb3TKId4LGQigl5dmpagKnephEuGHFu1E1HHJqW8c1ikxwUtNwbakkBGF5+DsNv6kM3r6DnEhLd7sZAWfaCM4sQvuuNCqP2hdjmvfdPfmnWEq4K6XXq3BR1TXovVrIf0PoXlW0Pb8PamvVTn/FDkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0rXpvBsVqQ+SZ7NHimeR2PT2bOi23yN2GKLZ5bCzHA=;
 b=cdSfG7y2/Psfp6iTowboqIaFwb9YupbCKOrmbLQxxVXZcHzHfBNGm9VSWWe1Sh17MEjrsn8oYsYzkPxeMoBXxWh3/MPBugOc+dcBquHvdD10fqVN1dsNVtUxwjiDoKjLatlPgSb/X75Mr2D7JtyLnFVlV30XMn/+/H95uXVi8KwibbC676CJUoltMlK/otDNXxVCUuqyMstfYgrTVwyyg7pFZXMT3Et9jnzz71q4wMQvQPrcdLBJPs35qnDi3aVGskaVZg4nfgTagdoUHlBe30UAEqg/W2jvL3NHz7oY75lpkSwc1LR6TIClwbLLgMwqehnGNRTwbuXKSL+mtwF4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0712.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Wed, 15 Apr
 2026 09:27:04 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Wed, 15 Apr 2026 09:27:03 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 1/3] net: phy: motorcomm: Add yt8531_set_ds() mdio_locked bool parameter
Date: Wed, 15 Apr 2026 17:26:52 +0800
Message-Id: <20260415092654.64907-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260415092654.64907-1-minda.chen@starfivetech.com>
References: <20260415092654.64907-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::19) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0712:EE_
X-MS-Office365-Filtering-Correlation-Id: b0869619-3fcc-4c78-a676-08de9ad127a7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 TvdO2+Z4V2DH1lP4FAQY3OqGh5fGXEiE3mCTuN8fP2wV/dRN7UG38u0SRRoG9alsy5r56nI9cakgHnUG2zCFzBhkRGkm9vBxx9qH5xmVFO9+TEiqotFm6hoCdV/IdBRsxhNvG3DAgk7mncRRIRpfivNe9Cp+96BEBAcnNNtM0G6HBK3/DOfwIyslenGIY9rIxk1KfjAWGODbR4K5mI0Sd290DGlHfi7YxdVzkggJxCBvLA+yd5Btr8UsGOyDBchzzJY0g3Qdo4EZlLHcTXV4R2l/aGuI+2e5eBaFknrqRfZ6VO3ggPpayQsk+BLMN59kKdQulfLfzzw/OKuVMmdLTemqUYe8BWm9PfoqiHc+zyoKoYfOlTzuafL1McrEqUejeJpRK9jaq1WWHSnri8a5L9Fmbinzv+o+uJDZ/I21tq2M7iaNnnt+px1bM9wh5whPgRfYJJiF3nyj8ocUOj3onCLDTzh4vkcTzR4uL4BWodO1UfSiJ94x46seUfK7jWhjX2gTFgWlvg4YrQoICxMAberKbv2PW8YFhIeg+1jfE8ipopKCK7f+ZQIMW6HZ8FkerO5xJa7E2AAdy/w/Tj1NC/1KbhAyGHZqsZRKaGIiyzQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?2Xhy2tOTr6jVEnYLCUfAGO3KId1XAAmkAeStE55Z8haVI630XTp+7o3lQD+H?=
 =?us-ascii?Q?51cFMRJJ45gKH8d43ooR0S5S/00nv7CjsWDOZylO2iqZSNzHnsFAk2mtY462?=
 =?us-ascii?Q?X2OCDDC+mKP2hzffg87q0fD0vdFD4URKuaJ1O6edmwvQzg/u6s7WVeGQs3wu?=
 =?us-ascii?Q?ZwKqXjf34MD9KNwx//WsCmTlBiwXeCLBMzj4UYoev3rPIpdpAt1dIhJzJBFf?=
 =?us-ascii?Q?P6vMO+B6Bg91f2YPp9DgovKZHJ6jy6OhGcbQC3bxKDqcQxnt38BSmncUFVAU?=
 =?us-ascii?Q?b+WAsmIyfos4y0V8KmBNVMD5gK9bMgR7STMi1Rz7AzQ9DTHP6D3d/zp239S8?=
 =?us-ascii?Q?rC6GtXb/UhR1tTuJhoOIA3+kr9iqHI+0sVZATDsWuGSsuNOHjNeck7Htse9h?=
 =?us-ascii?Q?5B8C6EqYwUpbWLIgEvYPpOb1O8vMTGls8rzIZJDYmFJ2E0jlzy74dmzFufsK?=
 =?us-ascii?Q?UyQ3HsKB6XrdY12RVh1x1utlFeUcqPN9Z6WHPWLghyTZKNmAOGqQdAkyxSqt?=
 =?us-ascii?Q?gIDhO8xZWPbQiy9G3TByC+pYK0VtS+CU4P6f5wig0A1q/gMilk2qdKrims9A?=
 =?us-ascii?Q?Pkss6QibQOeQGTZOQfm87MxknhgHoWMnm6f9Tvguf8EPW6fPRCsVZMowda8i?=
 =?us-ascii?Q?G2W0s9XMQD/w0fhfgNoLSEOK1/zgtXxRl23ZL9AkEqeza+6w3MnYd99mf+Mb?=
 =?us-ascii?Q?XwthbkN0Pcf30EDint2NQCdiwXrY8O3fyagWQ7oWenlTmGxjoKsWS8STRPCw?=
 =?us-ascii?Q?8xPz3XiB1Ywqb0+skKNey1CTNL6F22JyFRu5MFLLZTkNxf7FfPPCzAnAPQOf?=
 =?us-ascii?Q?u1RxbN4ecJqg8oLkuMMFeJigGhiQMBR5g+2Aro0DYQxr8WlCawNBSMcG9Kv7?=
 =?us-ascii?Q?7RtVj9ef7wbrbEfzEEwPstXghvXuVl6PIysQY9r04aGg0n9IUbpYlrJ2Uugb?=
 =?us-ascii?Q?7DP9HIa0s76LZLSLknVk6XhrlIvCTA3IafubeHCUKfrAJT+QAxmAJdFMT+kl?=
 =?us-ascii?Q?n580GovgREQuNlfinT5l42Jd+FBBBxHmeCoGRX6wTk+2kd58RWRFxjKfuNeu?=
 =?us-ascii?Q?LUs4aeI87cJIOuFqFajdpkrF8qKdnUbX4Rd7ogc/u2O9JVSl7AuXFDcG2hBQ?=
 =?us-ascii?Q?K+1jkpKAhbbx4KZwvH5G72kUlqyZdkZSyPqFpMvVUUvompJcupVGwV6gQxwg?=
 =?us-ascii?Q?9M/zrqRRUdeMBYyOrxDKYcp5UojJdXBYdo5FLZbBe8RTQw+wnNV50x8KEd5+?=
 =?us-ascii?Q?UMhD7xhDxRLLTzpT/p3s+IBo85LItMe01rwCySAVqz9lwJXPeDIwD/Gjg84h?=
 =?us-ascii?Q?wsND4qhMZ+MZ8Bc4NgGeHTPcSUQ57cATaEt+zx4ka84WtAxwj5CgCStWMhQ+?=
 =?us-ascii?Q?KNhGy+SZXVeJOLYL2f5pgEoCgsb3vt+YXu9F9pZzjH7MSt+PaXBP27wQygct?=
 =?us-ascii?Q?0qIbVViLH9/p7+7pr2EEnCAJmT0hhrTv9CHc6gk4TZ7TQfTQJpfSlGUg0Uai?=
 =?us-ascii?Q?kgTT0sioQ5txZFAJP+u4P/yAYLWplUaz7F+O4MfXPumQCoVlWAaJE1tYgfuw?=
 =?us-ascii?Q?880gjprNZfVL1KyU5DjmtZ7t0sMue+3kBnsUtCct6nUhBUq7J6J+XnfBYmrJ?=
 =?us-ascii?Q?+8vXlFK5h8mWuWChKiMG30nVP7p9iVhsqFx5ZgAO8b7AUV/Y9FLn4QV8SYp6?=
 =?us-ascii?Q?vmDQWUXk95EzciJ8pwXn3JgNl3+x+AeWewoe+yi1DUmtVkm0bBuVys/r9h4q?=
 =?us-ascii?Q?5+buytcD8hTqtRcObhal/jzdVA5wHDQ=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0869619-3fcc-4c78-a676-08de9ad127a7
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:27:03.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6P2YXAg95qM5Ki/gN0MNXPwGhJYlJzUJVnePe4zaaZFf7vzrwizzOxwQ6t5QRTeOdCuG4wjNacEmDDtAJsdSv/3kUpTc8lcKKggVp1OiH/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0712
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-278735-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.892];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,starfivetech.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C25BF4032FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

yt8531_set_ds() default set register with mdio lock and only called
with YT8531 PHY. But new type YT8531s support RGMII and has the same
pin strength setting with YT8531, YT8531s need to call yt8531_set_ds()
setting pin drive strength. But Its config init function
yt8521_config_init() already get the mdio lock with phy_select_page().

Need to add ytphy API without lock in yt8531_set_ds() and a new
bool parameter for YT8531s RGMII case.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 51 +++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 4d62f7b36212..35aff1519b4b 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -970,22 +970,26 @@ static const struct ytphy_ldo_vol_map yt8531_ldo_vol[] = {
 	{.vol = YT8531_LDO_VOL_3V3, .ds = 7, .cur = 6140},
 };
 
-static u32 yt8531_get_ldo_vol(struct phy_device *phydev)
+static u32 yt8531_get_ldo_vol(struct phy_device *phydev, bool mdio_locked)
 {
 	u32 val;
 
-	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
+	if (mdio_locked)
+		val = ytphy_read_ext(phydev, YT8521_CHIP_CONFIG_REG);
+	else
+		val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
+
 	val = FIELD_GET(YT8531_RGMII_LDO_VOL_MASK, val);
 
 	return val <= YT8531_LDO_VOL_1V8 ? val : YT8531_LDO_VOL_1V8;
 }
 
-static int yt8531_get_ds_map(struct phy_device *phydev, u32 cur)
+static int yt8531_get_ds_map(struct phy_device *phydev, u32 cur, bool mdio_locked)
 {
 	u32 vol;
 	int i;
 
-	vol = yt8531_get_ldo_vol(phydev);
+	vol = yt8531_get_ldo_vol(phydev, mdio_locked);
 	for (i = 0; i < ARRAY_SIZE(yt8531_ldo_vol); i++) {
 		if (yt8531_ldo_vol[i].vol == vol && yt8531_ldo_vol[i].cur == cur)
 			return yt8531_ldo_vol[i].ds;
@@ -994,7 +998,7 @@ static int yt8531_get_ds_map(struct phy_device *phydev, u32 cur)
 	return -EINVAL;
 }
 
-static int yt8531_set_ds(struct phy_device *phydev)
+static int yt8531_set_ds(struct phy_device *phydev, bool mdio_locked)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
 	u32 ds_field_low, ds_field_hi, val;
@@ -1002,7 +1006,7 @@ static int yt8531_set_ds(struct phy_device *phydev)
 
 	/* set rgmii rx clk driver strength */
 	if (!of_property_read_u32(node, "motorcomm,rx-clk-drv-microamp", &val)) {
-		ds = yt8531_get_ds_map(phydev, val);
+		ds = yt8531_get_ds_map(phydev, val, mdio_locked);
 		if (ds < 0)
 			return dev_err_probe(&phydev->mdio.dev, ds,
 					     "No matching current value was found.\n");
@@ -1010,16 +1014,23 @@ static int yt8531_set_ds(struct phy_device *phydev)
 		ds = YT8531_RGMII_RX_DS_DEFAULT;
 	}
 
-	ret = ytphy_modify_ext_with_lock(phydev,
-					 YTPHY_PAD_DRIVE_STRENGTH_REG,
-					 YT8531_RGMII_RXC_DS_MASK,
-					 FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+	if (mdio_locked)
+		ret = ytphy_modify_ext(phydev,
+				       YTPHY_PAD_DRIVE_STRENGTH_REG,
+				       YT8531_RGMII_RXC_DS_MASK,
+				       FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+	else
+		ret = ytphy_modify_ext_with_lock(phydev,
+						 YTPHY_PAD_DRIVE_STRENGTH_REG,
+						 YT8531_RGMII_RXC_DS_MASK,
+						 FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+
 	if (ret < 0)
 		return ret;
 
 	/* set rgmii rx data driver strength */
 	if (!of_property_read_u32(node, "motorcomm,rx-data-drv-microamp", &val)) {
-		ds = yt8531_get_ds_map(phydev, val);
+		ds = yt8531_get_ds_map(phydev, val, mdio_locked);
 		if (ds < 0)
 			return dev_err_probe(&phydev->mdio.dev, ds,
 					     "No matching current value was found.\n");
@@ -1033,10 +1044,18 @@ static int yt8531_set_ds(struct phy_device *phydev)
 	ds_field_low = FIELD_GET(GENMASK(1, 0), ds);
 	ds_field_low = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW_MASK, ds_field_low);
 
-	ret = ytphy_modify_ext_with_lock(phydev,
-					 YTPHY_PAD_DRIVE_STRENGTH_REG,
-					 YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
-					 ds_field_low | ds_field_hi);
+	if (mdio_locked)
+		ret = ytphy_modify_ext(phydev,
+				       YTPHY_PAD_DRIVE_STRENGTH_REG,
+				       YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
+				       ds_field_low | ds_field_hi);
+	else
+		ret = ytphy_modify_ext_with_lock(phydev,
+						 YTPHY_PAD_DRIVE_STRENGTH_REG,
+						 YT8531_RGMII_RXD_DS_LOW_MASK |
+						 YT8531_RGMII_RXD_DS_HI_MASK,
+						 ds_field_low | ds_field_hi);
+
 	if (ret < 0)
 		return ret;
 
@@ -1826,7 +1845,7 @@ static int yt8531_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	ret = yt8531_set_ds(phydev);
+	ret = yt8531_set_ds(phydev, false);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1


