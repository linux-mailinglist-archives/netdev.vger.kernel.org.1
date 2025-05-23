Return-Path: <netdev+bounces-192979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C203EAC1F05
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724FC4A188E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9E1E379B;
	Fri, 23 May 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FfmWRDU8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00DF130A73;
	Fri, 23 May 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990669; cv=fail; b=EO8g7a5ZYEhrjOcwP84gqc2gHnxO5vytWPbucINJE8RBGhr4wt1qu1e10wQirMEdpV4RBHDq/y8CUjZHnbGM7FVDT9Wrs9GUcASJpCDwejNYEoJGQpBhNCV7PBW+/2TFgSVyi6ULWM24hVSAbSVVpztsJfFXuWldOregg/sohdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990669; c=relaxed/simple;
	bh=yuqBqBCgmWq7zcUWeAIoHuYs6cjElm+UK5k51jyVdqA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qFLwNEIZm/ZfVx4KEZdAuY3hEkEyjC4zguhIE5ggVvBjHu25TYovKMA6izeUuAZEhxT9TW6TyIDSXK8Ws/MVvD1TUvzm10Rjq7Sa7Fa1026p6vkKd52aeFjrll8GZmXo5GGEOEASTFSWQk58tV/4diUbFq8Z+/W9q2yhLkWZ6BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FfmWRDU8; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3pXLnI7StKEKd2Wh+/svIX1nCoKa69ay0nruvqBVJFYyVs+LBF10zGjh2VD98dG0YJg6RVyXhm5Vtv057DCpER4NbrIwdssaj/9ZiJp/46xJA8DUZ5eMz4eB3pODFuRn1xqXmB+XSHPxocupwyyUjkCfK5m/Xqhm1EcjXwOsV0dB4gNXEy1KmET4tbPg7ynxiK392ciyFXVdpmPL/8CK2jBIzt66lCdNA6D7SKJA4vc5HCFfY+drkeCy8AwQjROH1VrNV+7PC5VTqh73Ei2nVyN44a2vOCT3dnmtp311WrjKijS0d9mJST2j8OaUqia6NO61ZQ2LCO4cCAkfB24bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ijKgcwqE+mwxbSnhP/MsTyOMcOVUyy0JooIE65zp7E=;
 b=RpoUJN2w0ja4j20WchvPeYsGKxSoElX6o4KNiRIwNEob2bySAqRZEjXCYCFu7VZR1uRG4ZEgpfOdSK16C/E8UR6ZJHIXwgfqv5i97/DbQhRutDvky4g6IWrU6yYkVwlGTD0eO/tHv6OMb5+fBw8+/ZXjNiPFDL8tTxMZzFLMKbzpEGXLcBmGGZT7vVOLnwvkv/WXOYAfb3IPEQkYDJh6R5SezTsfYM2C/tO6ArLoKY6KRF4smjzZnvrhcKoHiHgQDdfuZSwiqAkUZtLgnq5lqpTkn0kpItd3NPgkfJeHmSudRnUSpuVNv3DegNPaP+GKgrMJqAypUQZCmFo+UGWBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ijKgcwqE+mwxbSnhP/MsTyOMcOVUyy0JooIE65zp7E=;
 b=FfmWRDU89K4iNFjauO2UngIZ2KtWTVeQnZtA/MkZ9wFpLafU2l3Tp9D+ZjJ0BANb/x/7xa5pSk1PCSOu2mnn40bsMMr5MZG7rG/6fUgyGeal3MlbQcljbPHayXGkm2NHNe9glhAtwHmHqlLTXfvS15Jr1WzuEklQgzNNB8jcnIZJqNOT2KBdYDLcosh7Hgvl2VuKge1ge/42PpLYWWX4bd5naOfMoNkm2x3rePVIGidDdkg6j77pJUYYGqT/wakwa3/nNR7T7oHtU/j5FyU2LCKDhJ5DCNzs3AlRLXbGICCgUrdC5zRyFzmE0vL2RZ5qHJLcZT5NFzg/bbZen16OUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 08:57:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 08:57:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	f.fainelli@gmail.com,
	xiaolei.wang@windriver.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net] net: phy: clear phydev->devlink when the link is deleted
Date: Fri, 23 May 2025 16:37:59 +0800
Message-Id: <20250523083759.3741168-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f3536a-4bca-4f3d-b8dc-08dd99d7e166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dCK8VKSbT7TzAhZlksJyG+0CSV5oXBYakmbugqbhKcO+ehhW3YLMSISF08eY?=
 =?us-ascii?Q?HN1yg1ibWGq3ZTVg9domWyJJhIVSWRy0PEbNyce1YSaVGJC29/FCrwIO3BAP?=
 =?us-ascii?Q?VRyRZL8oHJxnYuABj0HNJo7YpY0jclXVSxagQo50AXvuJYQlpIutMoCCbrUP?=
 =?us-ascii?Q?rAG4wk7x4pBTw6i2s2+ch/TbtYIr0TKwDkUtRBmYrApco4Bt2GYuVoz/C5M3?=
 =?us-ascii?Q?RN6BULR9pL8HNPhNbgO1XSLbKJ+VR8W6jgG4JJ0yXKeoPCN89Co9xT/89gvx?=
 =?us-ascii?Q?4Pn1+LLofsxeerRKezXayheGRzoNbONTvXbprSLiWc5fKxEfKcgk2tRLD1g5?=
 =?us-ascii?Q?NmWtjgyQ2t+NkyD7q2pguX0fKq8DKqKTDlkvmHJbPwiHYAf1jRVS5bdHffWA?=
 =?us-ascii?Q?I2GqJK+AdTZu91pqHAx2L8Gmq5Ks/Bfs6YITAi/jRBke24gHrtKWuLhBzcbM?=
 =?us-ascii?Q?RCLaff3ADLXiXyQU9O/yxk0mZqNFuvTSVUCiBs96CQxF32tcmvIejwUUCJrR?=
 =?us-ascii?Q?F5cLqnPHpr8WZq6ZdAh+0aJS4ozmF/dgumYtUnczluZq9Dko1byarxqBbgGc?=
 =?us-ascii?Q?K9bFDtFc7AIX/QjPNxqYdAZf979jqMdjNscPKgWyAsT1+Z/0h4yN/+SDp/a4?=
 =?us-ascii?Q?3mGF4tnGjTz8jCZHAZRlJ9QbuXIryhCDiIBAa0JT5iYy9M//AzPTyAjCB6Jb?=
 =?us-ascii?Q?z3F9ZEdbCq0XPmcdmlg7FnZA6cb2ePali9DT1EaQbxAu0fGzwcnLv479nL0Y?=
 =?us-ascii?Q?9H/Ul1vOoevHwXWpsDJtHWyD6jGIPjfy4E5lsHCZ8lcuhKa3jPoUskCRwSxT?=
 =?us-ascii?Q?tx0amjfwxu1WVhsYC0BT8RzdbXzuNP1bOzSdi8/DNkqnUSZxZrCba+NiDKTn?=
 =?us-ascii?Q?GRnY42+BkDJNoPcMdzpeyGxX+07t1NGMNHEuLE1u2eMIEAiqGck1Mv80SR5a?=
 =?us-ascii?Q?LMq1Asp4/R4+HSo77eJdkDz1+5N3xhPB5M9t6AxxD6deu3ea02+rnhRq/JA9?=
 =?us-ascii?Q?CmQ8Huyh9wtL5FScISsMfI5Xs38F31F+wqMQKDJN1rFRmm4CqiRHv86BOIDk?=
 =?us-ascii?Q?SWBkGwQsqM91kGtJSDECu3iks1m0eERelEVBy/2Kt7yyeyV+mkUexEDSOMjW?=
 =?us-ascii?Q?/g+s/DL0qm5UA6SYbYxMUzZbzO1Qcfu7qVPs5ejkkj61/iWAFXbLgaYUvsZM?=
 =?us-ascii?Q?xcNgYWwJDMga6ht645UE6hd92SdtOQZjp7MjGENM8T8HguI0Dwc93pSbDaLe?=
 =?us-ascii?Q?pfwFCkXSJNa2Sny1Hk89uPVg1E/MhTHGx8ihWJjQ6G14ygFIrM9WywsQygNw?=
 =?us-ascii?Q?VQI/qyHR/ue9ub7nCGq9ifQFf51KYECPMW9ZfnbCdtz0J2WhhnhKW8ZG4M2y?=
 =?us-ascii?Q?gq4HpnQd15I+nQDTObloB3l4ruC6sNJ7WEexTdunt4owlTK33KjzMXjJSlzl?=
 =?us-ascii?Q?B0i5z40BV+ra28Uaqvu/zu6snWDTmAiMizj+gwaY7wkIl7SpK4Abqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryuw/wuyUbSgbNIU6tKURu9x1dcQsmNTLCaH5N91ddWIyvi6zJT0GTtsOWyc?=
 =?us-ascii?Q?LN726mxpredtbyc+BUhWO7YVZXj8Dx6H7Pi9wx4wSTxxgH+4q0MdMyuP/Pd2?=
 =?us-ascii?Q?6PmY4C2r9LMapGZMQIHeOQoIqWrv/NgfeBdVhI8zM4FUb0QidBhz9VQE0XrZ?=
 =?us-ascii?Q?Vf5fzKaPDNVi1evj2OyI2KgLq1ifEp4BtJ63autAxuqn5CJIR+4twKbDWSjp?=
 =?us-ascii?Q?CxTYljO87BEb4yuxIsALpw8PI8uFXcJl/2Xlb7KdWFdM81WrNXcHSdEmEK92?=
 =?us-ascii?Q?WzzIG0m8jlW2qoFcnFC0t2m+TwO6rwXuaNEO2lqHovNQPVJJ6QS1W4bnEiSu?=
 =?us-ascii?Q?yCyKpSekc2kmfabLq4RAeLEatMUIpkO66HyTWS5Ai3EvQKLnxj4JD0JBZyss?=
 =?us-ascii?Q?8ukbWRjLBoEyfucO0um0BL30+sbNs51Y27IPv3Yv7aBV7cjL3ki+0TG9vYYz?=
 =?us-ascii?Q?jYPhYAA/NnCcnibTlxbio/F0G8Gp9HXhzRPBYxbUfDIr6MxKFfwudfpib2fl?=
 =?us-ascii?Q?MvA/vp8m0UnT8L/anWuT99OuSUQDEUJYKY/u0qAYs3Pnplf+Lu20tPfNPLzq?=
 =?us-ascii?Q?c8hsBXVjxb+7ysRKYqrDHZA7DiTUyVjKnb3FpvwdmAOkMJT6Oe/9QiaYcVNM?=
 =?us-ascii?Q?F5LlE4/p+FfW8dv+IKZGzv5sXv9kTwcgeXIhp7PZvkL14y3WYCAnJ2vfFm2r?=
 =?us-ascii?Q?wKSixxhy/lvn6eph2bsPYUDxChomtZQIyxRSi2qGDzbWKWnuONgK5L1S8fqo?=
 =?us-ascii?Q?bgSx4eJxqCg5guaov7tnuXGhfJwSyKwFV/G7liiikFnqVohOQBcSRwnGNosQ?=
 =?us-ascii?Q?uP7gPRi/AB8fl1cBZPRRrDwUj9iM527kWIlsu1BaIWc6EzaBM6iK2VuRgMm0?=
 =?us-ascii?Q?U7QFTjgFd1udayxDwbR73t8yicDP17cQNfwPIerJj4aEn4f9ViOBSzGvXkCI?=
 =?us-ascii?Q?61akkelaeA6/onX77VomXQ9mEBp+cXkouj/8jEP1fytxhv64gF5Fx7rovR0q?=
 =?us-ascii?Q?rqiEhP4UcAgPhSHl9fMXqbTKgVYNBX90LFQNviTK5Wy8ehd7HuXv/UroBnWV?=
 =?us-ascii?Q?NlbwSyiWNXvl/jsBcFrh47UwhSWRb2zipLNlKH7/6A+CPCEI9hb1GFWFBRz2?=
 =?us-ascii?Q?VApCoZGjKvPtflglujaTf2101NtSjF5qnfefPvaXt9OiAB4l/LresCB/vtCQ?=
 =?us-ascii?Q?0hkUAosqRy3Gnzn31VlM4YTl/o7GZ/6yVFMroe5MdpnxMLvBW7xr8JbxmjkE?=
 =?us-ascii?Q?Ob2B+ie+UL0XV2ac1SY8/mnPvCPfDJxaHCeBKe0z7Xkhp9RfYHDgCq84O/5N?=
 =?us-ascii?Q?ar9h4rEMrAb48FdLeLTnF35rsfx2bBiC5Bo0Fpk9x942cpvjixz0fLUQ8stN?=
 =?us-ascii?Q?NFRGaZxlXs4SRd2Ydx7FdIMcwMLOSikc2WXcrAIeJt9Wp7vvC0EqX2YNUNJw?=
 =?us-ascii?Q?B9X5i0m91mlbhW3aX5uAtiekpgh4FK4XiEGfZxbCUNuuCnFTffGHySTcyKGv?=
 =?us-ascii?Q?i66m3YbjlqjElIyfcca+39obz27sqGvwb6AoR9tw86jiLHrlJ6WGuz192o4Z?=
 =?us-ascii?Q?SwJwPZOySjHi87Eur7ijzSQSjfdWMaPrKq6LOBk9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f3536a-4bca-4f3d-b8dc-08dd99d7e166
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 08:57:43.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQjQKsZdnXPIhzi5nV9X+OyGNvO9UMyorZX+cfnw9x0ok44PLBogeV3JCs1qZcEdCXIT4IfXSBrR5stqfBNGCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9231

There is a potential crash issue when disabling and re-enabling the
network port. When disabling the network port, phy_detach() calls
device_link_del() to remove the device link, but it does not clear
phydev->devlink, so phydev->devlink is not a NULL pointer. Then the
network port is re-enabled, but if phy_attach_direct() fails before
calling device_link_add(), the code jumps to the "error" label and
calls phy_detach(). Since phydev->devlink retains the old value from
the previous attach/detach cycle, device_link_del() uses the old value,
which accesses a NULL pointer and causes a crash. The simplified crash
log is as follows.

[   24.702421] Call trace:
[   24.704856]  device_link_put_kref+0x20/0x120
[   24.709124]  device_link_del+0x30/0x48
[   24.712864]  phy_detach+0x24/0x168
[   24.716261]  phy_attach_direct+0x168/0x3a4
[   24.720352]  phylink_fwnode_phy_connect+0xc8/0x14c
[   24.725140]  phylink_of_phy_connect+0x1c/0x34

Therefore, phydev->devlink needs to be cleared when the device link is
deleted.

Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2: Improve the commit message.
---
 drivers/net/phy/phy_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index cc1bfd22fb81..7d5e76a3db0e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1727,8 +1727,10 @@ void phy_detach(struct phy_device *phydev)
 	struct module *ndev_owner = NULL;
 	struct mii_bus *bus;
 
-	if (phydev->devlink)
+	if (phydev->devlink) {
 		device_link_del(phydev->devlink);
+		phydev->devlink = NULL;
+	}
 
 	if (phydev->sysfs_links) {
 		if (dev)
-- 
2.34.1


