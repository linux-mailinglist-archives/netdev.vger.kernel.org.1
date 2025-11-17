Return-Path: <netdev+bounces-239269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49806C66918
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CE0E5298A4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065F3271EF;
	Mon, 17 Nov 2025 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CrEX4U9f"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A8325493
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422908; cv=fail; b=J1Mkx3b3uSevdO+Ud6cmJg7uaDCzWNKxuHZnNiZ07dO1KlXYqiU4leQcDSfHYH7ZLEdrGFUJf/G49LU06wnyoLsitWrUj7O4GVmSJ1S6umwTv0eQXkXs1c3M0ubc+vBjOzgA0AJT+T9D8TJiEGrMqZzOz0mJTvGQbRP3zuH/qf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422908; c=relaxed/simple;
	bh=rtjNK6rnQGC6C60o3foYJHCIWuKFjcKny8G9q0d/k8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LxDp+UPmVR1vta/+D4I3b5ak/VyzDoLh+9JraIlYxu31gLEOvELE9DADYnXX5rl8bM7lDqNSLeMxlOkGdRoVCceG25zDLJOi+i83Vmgfm9kJZ6oLR8r4J91GIlOfOZUvdizauqD6DPh6shGAyBf3j3KykoCsX2unpy9tvz5TheY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CrEX4U9f; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuxYLVMe2rnszex4kV1xGj7G/Vt5DZNBJeDeSIwAeo6ltx28wtf22q8Q3210quUrPC1MxcxHSD30R3b6kdtslTu3KRTDFwR5i3ZSkoXHGnOFbou5sb8vrHHLGvocgrcvgkvZ2l0fQyeU8D1nidkgxneAas3KVISaG11bpRAHYwzkexcn7qIzx+XCIUTb1zY5GvLN01C5y6g2YLJ92LWV6M8EtSMc3KIMaWcCTkENFonQWpBdXhZmJGOwzwbfHP2bJ/SLCQD7pIbDNHHfyoPdcMf+i+dcLQCgRh5Ekf85u5fNuUP53TBas4EXjbg+ctA7Mjq+BPJ8df7Wq3x/utm1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZuGwOy7eYemWgRWR3/VuLWdhO/Zs6xD/r89xo4r0M4=;
 b=OaYqsMuOP8fXK/ieF0MvOkdbgCL7q4I6oscbEzl3XRtn2pKluE3uNbN7MpLxQaqgcc42qpN7MlM2IakXtCD338qdJ0x8axanIiXwlXZWOcc3RFdBkUr3ZMYCmWHaqjNYLZbfse3NmBFidPOJY5JYBqMz4mf2T1d0aUeFHLkOv5ZWd6Wcm7LARZZxXnLBU3u136PxHm9QrgqlTdQFcz0q51PQ7FnUh0UZu63pl+UIAZzHa7jowvJaCMjwgeRmWfOQXA5Q3o8beVpxdGHDQUDxz2QK8FAgxT9CulADMBpliaBqFTX/3d/b96XgjcDu7wWHbtbcPUD4hGjZFzVEnDueaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZuGwOy7eYemWgRWR3/VuLWdhO/Zs6xD/r89xo4r0M4=;
 b=CrEX4U9fE3xtyaQQNlhYC2Gut6vx+DNyBIlujoPalTUjNmW3vS4WeKlWqZTro6zhrXRDa39S9exa6p/tyEUV2LDUpgfIHTnNHiglk4Bh7lW5HcwnIGxrhBE5+YAGXZ1TeuR0BJliAocGnRLhMc8bkTdmZvfPGH9vlce6/Qm1A7xhFOFWYmwcqR68DN8quM5mObkA84c34MstNZL202L2EJOnkgf9IAl/Z6hpFCTK2x1/YD5+8C3EoUP332HugCR8VwTZmKWietwVJ7z9kLxOwaR+Get3MLtiM9eCPZTnuxPpviTRkHFGtnIJ/A31tdNHSXXmoue4D5Ee8eaBTlZyWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Mon, 17 Nov
 2025 23:41:36 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 23:41:36 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH v3 net-next 3/6] net: phy: realtek: eliminate has_phycr2 variable
Date: Tue, 18 Nov 2025 01:40:30 +0200
Message-Id: <20251117234033.345679-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117234033.345679-1-vladimir.oltean@nxp.com>
References: <20251117234033.345679-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: c51a8d84-7f78-4a99-14f2-08de2632d927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XPgiXg/LHMClWh3siUl9BeOIdnsiLrmlh6BSmMGHBuLLpRk9tXgPJ1L6Vv+D?=
 =?us-ascii?Q?HU8A7Vj3m2DIv/fy0UYmXL95GOZ8iZzRp1eWbVY7FeCc+DY6kX5sLpRTz8B1?=
 =?us-ascii?Q?5djWdxRcDdCFIqAVIR3zRqZlQAhMolv3YJbRso64ALqyydF2dHbKJB6RvBS5?=
 =?us-ascii?Q?M7MO6E8fdxJqhFVYyXfm2tcuNVx4tqzsMYTdYoy+nfmj2bugRqymSjjMTx7z?=
 =?us-ascii?Q?h0Tb81aZwWmXys/hWSJRNBmS4vw7Cxwn5ajznKdb96Uzr1yxEELufVdSfm+b?=
 =?us-ascii?Q?J0+sc8Ppg6PHVZ88HxipX17gIynrht9PDX3JEzr1/fcTT5auKsGU9fbVB1gf?=
 =?us-ascii?Q?XjKPXteZBQfIKhErlwE6x2FC7UXjXt6wAu8eQgmEpxzZ4gwVvZDpCwMwIXNH?=
 =?us-ascii?Q?59/yEOm4Vgi3GDA7Xt5SUVlA9QfomNSwG+vbZpQyvBSNynalYk4CWrnCuXk0?=
 =?us-ascii?Q?2KdfkDv43CA0lhomHdbP/f2pvx7dKuuf6SG4r+sQeiWU4AO/B8bvGYa2wEk9?=
 =?us-ascii?Q?eXObVR+Md9ZE9xeI8RYU5DwKlNWPwl/NWQB135/zAeHAlUYYliE5XwaQZiHP?=
 =?us-ascii?Q?E+n3999Ev9qZrl6x9qnctDqpCuv+kQx90MkqoIRDKvh9egQRe3oeW681wq9U?=
 =?us-ascii?Q?3Pgerr+b02o95t+mIXDyvMECK0C3wEex7N0+2AS+s+hqC9rhdvzfAXQV5IMM?=
 =?us-ascii?Q?g9QyksI27cubbGU+z3YbYhA0Zp2vFrVi+uuxbgevaJq66g0bcTdl07q0dJ5Y?=
 =?us-ascii?Q?aeRtYl3pHGQi9IM2sudyrIu6DY34jM9G5eQunlNploSsdTFIUFiVk6UNKDHp?=
 =?us-ascii?Q?w8h+8miEl+9Tcn2qiilc5vnI7WaubWIA6VhhFLEINpBEtEmxKvCYvLHSOKcR?=
 =?us-ascii?Q?OG9VZ1Z1vHNviAGykhH2J/YePizObHIkCiNNQxq+4wBIiOvNll6gkYVD4lVo?=
 =?us-ascii?Q?BtEdEblcWPSmB4qD/LiIWB/BbMxAJZXNWbwoNIGuOFMXMGUiozx0yBkS2VVO?=
 =?us-ascii?Q?zKfeNZhhI11Tdl9Q388a3btzclODtq2xxtlizFgIHta53IeCmcSFQotZnEbG?=
 =?us-ascii?Q?RUnd4NY8EC1pbZ98y9BZLqFWf4PFY8FYnt5PCU5V4jUYHhVvgN1lCahzizon?=
 =?us-ascii?Q?p9NQry8+owgrc3oY5efLoumxcglHi6lyqPnKOHNq8j7W8SAZvmtDfom/9eCm?=
 =?us-ascii?Q?gp66utpoyjEr0tAAqTqKYcekAKpD/wMMEkaGYrbdHs9Ua1mo/UC/QNyC6M9h?=
 =?us-ascii?Q?7gQz+xQOhEC8Hi8EHN9qJJHIF0xZQtQuz6aRja7Yf7h8cqLioS1+vfw2RMcY?=
 =?us-ascii?Q?LFyZ7jnWp8zMo1OJL9y/8wdVufN9TuVCqjOReM1xI3HrOH+eFNLxSZs1ywO0?=
 =?us-ascii?Q?RfNr6uIHqz1LmxGsapomvE1z9V4za7xyHL5nYnHlU45krwVm6KnBWByIm5aV?=
 =?us-ascii?Q?6R9/aA4HyKdCSVhmvzqKPrcNbo74olOY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FQkLHyWic26dcTel87UPqxgayKu0OV2gYEk13VZ6vCmliluxkXrEy8ZVYTAP?=
 =?us-ascii?Q?3xfx4Rqx+UhcnYP6HihbEvkBf9OZm7QI2wcRHy0rukki97zD73Z2rKOdl39o?=
 =?us-ascii?Q?j0gYuhtC1lxQrtDPmo0J1Ox6NPrLQf+zsfVsND0LH6QcVuYmNfiz0z6T3B+l?=
 =?us-ascii?Q?Z3EJ8vfhzMGi0WnETSkC2G5ul2NGwKYQ2oNgxaxTtxNy/Gg7f9C9B+4hbGZ+?=
 =?us-ascii?Q?qvZmqCv4H5r7I0JLl+HQXU3amtE5cutvGJWIeC4AiiRqL5G4xk58gv+Ab1Tn?=
 =?us-ascii?Q?cTHXscC9S0l0Po5fLMzsDorXujxlZRAKx15enMEOBIDgGFxLQBRn5w2dB2xD?=
 =?us-ascii?Q?U5GlCMtKnYpk5FfsPfrrVHClPEbhVEW6GRfKeAkfs5DACB/6H9fPTH754TdT?=
 =?us-ascii?Q?rH1K+9a2MwFjVGSdoyuLJ3eHPHg0WgkWWE6yfd9zbm0UldPbKboHutlNvFZw?=
 =?us-ascii?Q?W3IUDkgeU8oHEI2BzBJ82gffQJ7cotxSnofs0iXi9Qad58PysA4sN8TWzc3n?=
 =?us-ascii?Q?dnMbyfU9k/ZJU1J9ie5SQ3LAeXfN2MExwutkj1PdEh+TqfML5La+8JLm9cyd?=
 =?us-ascii?Q?fDwX4H/Pos9XZiFZYdisETNRnbSQeNR79ncSfII2xGwQjZw8kmbdfYne3hzS?=
 =?us-ascii?Q?YOheJHtayiSWuv6sQPigkFNzuqFoa3tpyK4knVVgANr4RJ9SimYp9Z8LoXJA?=
 =?us-ascii?Q?3qXKYhJHlpT6YmClDtVJGVIkSBmasl716f5r6rEFgxv0j7yPCDl95KwUOpWT?=
 =?us-ascii?Q?mT5JEseNel1sCxMreZbovArCvsvZdpLalT4yC1BJksXGYrSLmeJPsmhZMj+N?=
 =?us-ascii?Q?NqSwtMGlmkmaagSvGno0Ojz+7B+bToT+JyVxHCw42SlqYr0dgkG/sMDfk50h?=
 =?us-ascii?Q?dxV0rItv9obN5A+Fbbfvi87fhgRU0qgEfT+QdR0NmSA/gz6yxmhdAHu0o8Nd?=
 =?us-ascii?Q?GjFOj51hf6zSMSixt8jUJnGYo7YX2ho3mA511I73LDLK2YZcMzh4Dkza2QHl?=
 =?us-ascii?Q?nZuxS797BOulgRd63OAshm0JNJ301nayEDS4IK2K9TtR4UjCNOQvhyxufu3C?=
 =?us-ascii?Q?bEvF0JTkEWYPvEbpNXYHJlh4W2aaPzmgS5ZPhZnh2RhmQh5kJPVSQ9NqTwTj?=
 =?us-ascii?Q?BR5J2dxIMR908yULwuWGbSOFEC/pe61TyRr/9wmqu+CQFBiRJjps3flPf3Yx?=
 =?us-ascii?Q?jWkbWq4HUL3EOx0ZHY7eLb+BFDp3P56uT+qtgsnkoOg5s1NeF06ZQCsHnysJ?=
 =?us-ascii?Q?JjvMm5Pijz6LcrWsrEXrB3THyY4tCsJ998mfN/snWra4Ecrx2JXq+JfscGId?=
 =?us-ascii?Q?s0FprapOeDOmC5scS+2kcHBs8Y/1OmmM8C5DJ7c5yOYaa2ocbLtApzhDb7Im?=
 =?us-ascii?Q?wCfPdRT3DW9L7I3XSNxeQqqHEani/80CLH7bXfVYrbfX//Nz4ZlJU0mZOoYf?=
 =?us-ascii?Q?dWnmwpf3wV14HMRboyMum/EGrBEY1hZk5eHOCQFLn2PJEGOw8CYD+1fNIi8q?=
 =?us-ascii?Q?P5jqejK6q8vh+G5+P1mGJeE9K8mteUjL2weiOcfRu2DXdDwf1myZmICpxiXW?=
 =?us-ascii?Q?/F/Xu5eu7j4aAewLNVcc+CR8waDy5nQnTbYkQfcCJm9PAzdPhZrIv+iVcRcd?=
 =?us-ascii?Q?rCbn4fMyQVUIj7/VPpm9xQk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51a8d84-7f78-4a99-14f2-08de2632d927
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 23:41:36.8065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LL21UuG928+AJG3Sj3o+gubFhjx7O8bhtNMZf2am32zVreElMO5R/eHr9FWd/anoOheB/GI7Rsir+yegOhM1Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999

This variable is assigned in rtl821x_probe() and used in
rtl8211f_config_init(), which is more complex than it needs to be.
Simply testing the same condition from rtl821x_probe() in
rtl8211f_config_init() yields the same result (the PHY driver ID is a
runtime invariant), but with one temporary variable less.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v1->v3: just context changes

 drivers/net/phy/realtek/realtek_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index eed939ef4e18..da1db6499c38 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -194,7 +194,6 @@ MODULE_LICENSE("GPL");
 
 struct rtl821x_priv {
 	u16 phycr1;
-	bool has_phycr2;
 	bool disable_clk_out;
 	struct clk *clk;
 	/* rtl8211f */
@@ -245,7 +244,6 @@ static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct rtl821x_priv *priv;
-	u32 phy_id = phydev->drv->phy_id;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -265,7 +263,6 @@ static int rtl821x_probe(struct phy_device *phydev)
 	if (of_property_read_bool(dev->of_node, "realtek,aldps-enable"))
 		priv->phycr1 |= RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF;
 
-	priv->has_phycr2 = !(phy_id == RTL_8211FVD_PHYID);
 	priv->disable_clk_out = of_property_read_bool(dev->of_node,
 						      "realtek,clkout-disable");
 
@@ -683,7 +680,8 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (!priv->has_phycr2)
+	/* RTL8211FVD has no PHYCR2 register */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
 		return 0;
 
 	/* Disable PHY-mode EEE so LPI is passed to the MAC */
-- 
2.34.1


