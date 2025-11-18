Return-Path: <netdev+bounces-239687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D2C6B5D5
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4058B348CA7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99343612EC;
	Tue, 18 Nov 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UFnxKFIr"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E6324B3D;
	Tue, 18 Nov 2025 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492766; cv=fail; b=p1y8+JdzolbU0V852G347+e+r4ykKCH86YOtj1w4/toCcO6GXqb/n8Uj74OP6A7gX7VdbLc/ppxXK+k5Ngl9A20afuEj1YviiZx2jgS1/BvJTRaMHmoHZNW0j0LJJ1mc6yvy4+xJCT1Ibmo1MiA5fZmo4LdpgoWiSZoz98Ys1q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492766; c=relaxed/simple;
	bh=4LDGRMSZkAgPN0ztwBUJaBL/JiGMuoEPPPwCWOQnrCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6laQ8OAy7QMoeeOFJPKK/uY608hwZr/Omd7WZqw+7k4S1HZewd52xq3AK2Sa9894GYFAiyNZD96xvzAgBbHabfglXcOkYy9WAUId8fTv3cJGUDIn0Wsdhc41Y6fXmceVZ/2yvJPP3K1a4/glJ+4zHGeii1kGK6P0ANUTT+UJKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UFnxKFIr; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F93nJATPsptHDLtqIIC2DiC7zbqKMPtVp/6w8/ToT0bzOaVZIZEPnrJNQAsHjpDFiOB2oOhRPHJsCCyLQAlK1TTsSDuUaD5v7H+lGTRbf0Ki4qCWRGhfrfvBfnAlLXw9HnbK0RR4n3GvkM2Mkp6TJRJkhUfQsfQQSbAR4GczFahwK0/jeeuw1NcQLUb1BHUQ1NqIQrbB05Ccvdd1kl96eP4L4oQTQoCUJtHl73TG7ZeYilHjBno/BBXEU58hZ1JWoavBDX9d3lQlD6HpfYkcNKxb05+W6Vgxn8SE8EHmbedmgfTx0GzuE7JlE7VE4uk9xSNBvhwZrSaWbpP9q6XTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPRbP9SnyXA3j30lR4MCQtU/U2gZgUD1O74jrw3ChAU=;
 b=S6/xWbxRC/AXnns8+gK7oGUzHypIQ55U7tsrrUVVKwfdFqAdLGRWc0AVkb19H8cd2HSRYugW8W0ByI6DhbhS+dv17ZD7M3QCFTPu+M7JGWlM8A0HdnZ+ApSg9MTHr/LI88FtHTGqR4KjSynq9fvUGgLENAauBJ7DUdVYkreK+T5usN530u3u4HJYA0pv2sCODc+cvLWQcboPqibpGQd/bBX2qcsHysiRqkOXa5rqTtqWdhk0x2n53TJ0IIra+/XxH7jfq5WyvziH886zmd3nR3STQLdpCQE51baEgVxNa9Q8dne99Q/VAh2XyKe/LR9+xVxCJqn9+2jnExlZsSTtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPRbP9SnyXA3j30lR4MCQtU/U2gZgUD1O74jrw3ChAU=;
 b=UFnxKFIrZPKfnebdkIDzjpB4miTzzF/BRS9NLln+PvWrA4/cLgMN5aGHBGxLBqWWSzznVhYq4V08Un3G/Nqpi9VO1tFBDGfSIjkSxiN0y0lazausoM7SwlYKsdtGSipXuS8crYy+Ar/MdfJJM3XcNJHOrnKo2ipQt/FcfNYE9RuX5eTtdfgNCp1oTAnFsFLx22MUnbono5mtrkNelo/ZH0Qg4aRnBlklc02DPekEuvn3wrmSgt3M5od+xW6wHqgYlrcrogbUq4HitW1a6XPaUisnILO0fBInNeyOPX39gfMVaeYHJsc6mb6QaPWppS25iy/DLSrapiBoEDoBZ0TtdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:55 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:55 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: [PATCH net-next 07/15] mfd: core: add ability for cells to probe on a custom parent OF node
Date: Tue, 18 Nov 2025 21:05:22 +0200
Message-Id: <20251118190530.580267-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7a4bb3-eb77-4824-58be-08de26d58026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MaWOqz8u0JnXzcdDQHadouWdTXLburLatwjxkFFQ3AmQrUIfkUj7AIwMpPuG?=
 =?us-ascii?Q?Dn770fgN2JpJoiUDacbxRmhjiFQpAoZtdpH5EK9arnu5tBc7QszeMghXlxFE?=
 =?us-ascii?Q?9wHX1Ivwmhnn2E8Tp+E0c7QyI26QENupwD7a6yssEdvQecEgLG6Nbyo7gNeX?=
 =?us-ascii?Q?dEtJlnkjGhUQ4tQHh5fIlSj0atnebFVBVbsu8d2iYhGkcO/Fqy3OG059g/2k?=
 =?us-ascii?Q?Vg4cwS0/FlIbmYL0BvhSGwjPqyDHMvXal6KYwbByZ+vuVEkmDzuDCCTRso6A?=
 =?us-ascii?Q?TgJrT5sUlq22FhBRLYkTQhYJuW7I3YC5cjrT6hkh2U8j57mQ9ivCX8TAKOoM?=
 =?us-ascii?Q?HxjJZ/rdXmEoxfO6S9vLHJFIVkM1QKnGitD3B5XidAyG9WGXnMOgj50q369M?=
 =?us-ascii?Q?FJBr+9A81tXrpApmmoVCtzGW10xmQ2oGUgOG8zji6hFHfARdZJzGqRZbZwYX?=
 =?us-ascii?Q?Gt8X0bBMWthJMq2yn6xqs5hzb2gwxq/vtPEXnoHqATRRY4xb8yZyd0pZaJsD?=
 =?us-ascii?Q?WMrUzUGbySUeQvP/dxAMsoOTuVYXfCYdVzYrks4hH1gRKDwGhUrTtZ/r24QN?=
 =?us-ascii?Q?Jb/ItbzVr3t3M7oNw3biThzwuSQi8ibOCxQnuLM6Hf59VY8U3PVNkdA+E36v?=
 =?us-ascii?Q?W5mcuuJdMYI164Qr4u6tQvMs1cztjzEAs9hONYimaWwk5ElnMNuMEw0maRvp?=
 =?us-ascii?Q?3DqZFkIh/LzM5aQdewfqppb9pPC9yldDfz8bAkqRVKHNUuRaNcOG3qIQpHz7?=
 =?us-ascii?Q?15KgAMFIoKaLUPOkJM4rUihgHcgbvoR8V6QTRgP892N4ewB2mS0VkWLB+17v?=
 =?us-ascii?Q?14E8taiAwn9K28WcXkcGkNc2RqHrOze5YXlaloAWyPp2otkCPd3wfKeP9bUH?=
 =?us-ascii?Q?J6FPKp3ja9Mgt9/e8asxsbqMUgSWiY8QhbwjQmFfeXJu9s6vd7C9MwCFWrFX?=
 =?us-ascii?Q?0HfYA21GWZ8XHPBgBtFxWD8KPaS2cYcQddrjhpFXNyWy7cEmcbzaF8/bfj+u?=
 =?us-ascii?Q?tm22QPmhk0aEXUuQlLlSlI4YxWwPDXGH2QoLCzYWd5hT49W/DFQ0vU9Yjp0F?=
 =?us-ascii?Q?zjeVugL+9MeTHiVpIQK/c4hjUgCPxNFvKjsd3WmXhnbgnUxiiLU3FCe9QTo9?=
 =?us-ascii?Q?+7DH7y630JR18tfmHCYjLIsoQcBj5EnmOXigajByhSaFKBiaa4idfrlT2avl?=
 =?us-ascii?Q?t3LvefREjHE3r4wFUrxZD2e++bd7MJV6qFpVtQXbCT0r24jqvq04Y3sGIaxc?=
 =?us-ascii?Q?+SVsNV6+Cu7XhFsI9N/0ceUE6rH6Wi+++o8ktePM20qYTBDIRKeoT8KOObYX?=
 =?us-ascii?Q?CCSdYdv+SQ+ilDKb8mXCC7E+0mnoZ5B3EsrpacHTf5KlEoaUg3UEGfTgb2xh?=
 =?us-ascii?Q?P2lAcU3rTduyZzYGzbWQ4allxDVugyQzDyxud1v14a5nIIPhHVPZfcsiJ2XB?=
 =?us-ascii?Q?db4BouBqLy8qmRWg1zDB7e/ga/DhtKKS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qexyPurppVs82OuNeDGLV9vi6J5piYOYHqx7l1uHS/AXJIpscHMMiP4YL2eV?=
 =?us-ascii?Q?eF66n4s9ib4inTyM6BrLjUfZ83d8bILlpy0Cu1AvJnoinI+F6tN/73R9Vyy0?=
 =?us-ascii?Q?fiu3pPOqfkhg/RdrPB+zGHYUswlTDvfEkYnBDCY9lP2UQvUtoktqEjMMFx7i?=
 =?us-ascii?Q?si0VqkFULMWWZQ8dl5hOSZVv3BSL6ZOH+x5sv5ddNteI//nSTiku+Bm5Zo4k?=
 =?us-ascii?Q?xHBCHLAFjzhf8hlP1iBqMtDgQaO2Rg/K/x21dP38kjwAxaEhznc4IqTXJdMv?=
 =?us-ascii?Q?ZOHETwrtGexbEfJxzjg3vNc6AecvXCcNJybOWwuqdVAZwuBjo5WZl1Pf1jFp?=
 =?us-ascii?Q?Ag28Dr+q8HXHDLgqO1EvBUXykiwJLNJo4b6IF55K54AAv/EtGdhONaL2zz84?=
 =?us-ascii?Q?BGiSpz2090M3PvRO5lt3plXxzrzjlD2hqojhuxmOYE5jPk1RfPHBtYlq+Syf?=
 =?us-ascii?Q?GKgoyXD2wIl7tRiQpsFmF0j9P7GR2JLvaArG8IQRhWoxSE88NitALYmxGzv3?=
 =?us-ascii?Q?9XYeKUqdCFMs0rtjEjC+wMaKPPn3a1cJnGg4ekduwZGfzTv5IrzUKhtOpnFr?=
 =?us-ascii?Q?Gfm+XUs/lF+nVCY2VlP4bVaUCZnhodur5MRKp51tgE/InqRgHTsn+rXL/9zi?=
 =?us-ascii?Q?eE4w9vwdz06sJtT+XVJginolXYUTWrmkpdZhoRV2ohjSjSfAZ7G7tkJTttio?=
 =?us-ascii?Q?ms3HAsmKlFoXxeHm8S0d5szDsET9uE7udLxktfd5pCXJixo1vJZoMFR/Rbwj?=
 =?us-ascii?Q?JqxbbWUif1CM4UwtYhDFtUsPeeMLARSysDJbAAF76uPNS3WKn/YwjV5NBinP?=
 =?us-ascii?Q?h3IQnqugnmHIKNeszImtMvvKWcrhqGtWz1ttAFhDEaRp7wiatRVppzJ9MCW1?=
 =?us-ascii?Q?tb4XJ6relI0+FOKPl0yVRL+Oi9mWe4ExLo6OXUkQz1Fe63vIbGPgyvQv8dyG?=
 =?us-ascii?Q?McfLTHUBfaEMknfPkcmbb8hK3OHv5Ukg0H18O/BSuWvTmDsyfC17W9jyGF3o?=
 =?us-ascii?Q?OU8Z4AHz0mMKnbf1Kv3fDpmNkbZ/nCFSDuw1PFK1e7XKxdkWDKIr4abLI1HX?=
 =?us-ascii?Q?XKV67IA2rUQEML5ZhT9Gxsxn3QHB+hX8Sm1D5Q4XtQgjcvyZ8nUTOIPXCiUw?=
 =?us-ascii?Q?7+rZY5Hmag3zt1VGL7Nt+upx+zAJWvU1RTQhR/iNF4kMPe/XA2KRXh2tg/mk?=
 =?us-ascii?Q?GEa+zQpWRlWImQZqS9C8yOb7UJ1faPJgrZ7lJ25mujnZLk0cawJp1KaAHn+z?=
 =?us-ascii?Q?ES2HDeoFEmCkJrZ3EKZQPmP9QxzMD+tgr7GUjwEzGoiO1HP0Yd7qLzLz4Ag7?=
 =?us-ascii?Q?cmEzBFAkRUZMzDHvfLedEWPmTurfD395NIQQViHzV/hQ9Bmqi/qtaQGqEMao?=
 =?us-ascii?Q?WfxDJ8Wii1uGw913uxCCeyhF14lMR31T9kDx8MJ1mddhUjwxN8nRICdXEBSv?=
 =?us-ascii?Q?3R/cX7L6Dbw4yhJRoXmI1p0wcg3MZL5gsPKrtltacYfaZR4SX+J28/98EcjZ?=
 =?us-ascii?Q?D37z+/XOMD5EUzT3U0aOf3I4K/hgPk5n/UZ4RTXhGsGsR6nV9HtXWszbO192?=
 =?us-ascii?Q?0ZQ1dEBunz4QNqn05w+3NGTCbrfczTtg8YXhUo8vB8Fq5ai0uefS+LzRLQFu?=
 =?us-ascii?Q?sRMgmR9S3/FNOeGSnp0fH3s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7a4bb3-eb77-4824-58be-08de26d58026
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:55.4299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uJ2V8Bg1pMWJ+O8qRK/LJhcy5AkxaxwW/n+2vkaHh4airtYgL79BgC3O4PNeg71k8GFhZ7Q3zaor+DJq7U24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

I would like the "nxp,sja1110a" driver, in the configuration below, to
be able to probe the drivers for "nxp,sja1110-base-t1-mdio" and for
"nxp,sja1110-base-tx-mdio" via mfd_add_devices():

	ethernet-switch@0 {
		compatible = "nxp,sja1110a";

		mdios {
			mdio@0 {
				compatible = "nxp,sja1110-base-t1-mdio";
			};

			mdio@1 {
				compatible = "nxp,sja1110-base-tx-mdio";
			};
		};
	};

This isn't currently possible, because mfd assumes that the parent
OF node ("mdios") == OF node of the parent ("ethernet-switch@0"), which
in this case isn't true, and as it searches through the children of
"ethernet-switch@0", it finds no MDIO bus to probe.

Cc: Lee Jones <lee@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/mfd/mfd-core.c   | 11 +++++++++--
 include/linux/mfd/core.h |  7 +++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 7d14a1e7631e..e0b7f93a2654 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -181,8 +181,14 @@ static int mfd_add_device(struct device *parent, int id,
 	if (ret < 0)
 		goto fail_res;
 
-	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
-		for_each_child_of_node(parent->of_node, np) {
+	if (IS_ENABLED(CONFIG_OF)) {
+		const struct device_node *parent_of_node;
+
+		parent_of_node = cell->parent_of_node ?: parent->of_node;
+		if (!parent_of_node || !cell->of_compatible)
+			goto skip_of;
+
+		for_each_child_of_node(parent_of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
 				/* Skip 'disabled' devices */
 				if (!of_device_is_available(np)) {
@@ -213,6 +219,7 @@ static int mfd_add_device(struct device *parent, int id,
 				cell->name, platform_id);
 	}
 
+skip_of:
 	mfd_acpi_add_device(cell, pdev);
 
 	if (cell->pdata_size) {
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index faeea7abd688..2e94ea376125 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -81,6 +81,13 @@ struct mfd_cell {
 	/* Software node for the device. */
 	const struct software_node *swnode;
 
+	/*
+	 * Parent OF node of the device, if different from the OF node
+	 * of the MFD parent (e.g. there is at least one more hierarchical
+	 * level between them)
+	 */
+	const struct device_node *parent_of_node;
+
 	/*
 	 * Device Tree compatible string
 	 * See: Documentation/devicetree/usage-model.rst Chapter 2.2 for details
-- 
2.34.1


