Return-Path: <netdev+bounces-239693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2027FC6B5B9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 8E19829093
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A336CDE3;
	Tue, 18 Nov 2025 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e8O5bSxM"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282EA369235;
	Tue, 18 Nov 2025 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492775; cv=fail; b=p2EahH+8ThFQrm4as0m/+Wgr0OkynlW95WTK+vzd+IU2h94MK1ukkXS8tKuJDV2kJierGPjGx3QS5ELdpTliYThCEr2F90s8OQ2br66nQyuC47+f9RJmGMmLAMqrMHdi5Fle88725Ksyr4W8bJKbKcDqDlX2shgkJqrkfEyP9a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492775; c=relaxed/simple;
	bh=34P3hedAYosMFnqvldOzgv2TDC87O3zyT4+73CE4h5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WzlQIw4G9lXTkewV01vqbuUfmt/9sG13WLL4GE63QNiK4n8twby4PBDMpec0dkSUnjZO6E0KZCZMDmYATkHF0pccmNQCYhhyG8ODPuJFA1key3qWQ9MGNMD2O1weUeADhNTzcHRaeao4IUQiusb025sdGwuyogS6tlIyoP45BhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e8O5bSxM; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9C8+j+7cHWO8k/Nbi22cWnvbkHA7r4dKbt3QGX/f+wG/OP+pF/n8vIwsJTf/fD2MRhKnhfjxjDx1goQBUWevrGcQEtl5S5jkDwlEArN8EBgebeVIVIIQjM3SC/kXeJplx5JiWNzHp/CJ3E1ZzjrMtUFIwycmLYTC30TG5ec39w7eqll6O9OpdVlfM+6Pe1338Oy49Yhm70De/pKFyscP1x9ZHMIFi62w1nNQVwFfXmHk3t2+XVR90lpJzJBTjPvFb7BnCjEHlJI5w1Kaanc/aR3rRCRtlu7Wfe8tBjuP8SJH6o+2BuzGZiemSxbONJldx5mPcOJugRZxreXjacHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3B+XMChJg/noIM22BQ+u2d9GNypK8oOWiBiovPHd9g=;
 b=MSBAInzVL5Oub5rlgBFHiTfTLdMLYJ4m3AE8+EDR0GdCpdGNTo9W1rKjr7foU0XFU4FGHFuVD+/+Z2KTUS9ruECXoBFIYqAXQB6W73gNM5iPSWFPGa6ZYT4hrc34/lpsymqeTkMTmc0HE9ucHG3MSE3Dw/A0Xi8MKr+UCbKVjgD1I58OvG6kVgtIsuDL7rLgwG88xV1jgAoFODT5t0yG78XJ6wo6OcpbwJgzulaKGBrTY/eOM/x6OG/Lc+CJoAR2JmPrguoq0GSNQfYmWnAcfcYLii0teT9zx0vzzmYYtWglk1iKiFHmxkztRO+cFF6wU3Z33jn9RnulSXeJvRCNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3B+XMChJg/noIM22BQ+u2d9GNypK8oOWiBiovPHd9g=;
 b=e8O5bSxMLrHFH+mTtMKJjqAbhIqXjZGd3JnxH/DXPPvFTXKk/M2q6pTILghDJdp4tkdUcBRAiY0npvblLzCq4sguC/ZKV3iaW4G9knSe/hUFDmIA2NxwNy2hT78BPaYbWsbqtu7g472yXFxMpB0X9xzje++TX1a7lR9QhmcVOJO16pcKRFXGpgaQ8b2QEHrfh5KCQuftdsup5EryUxVk7s3N5pka0FVakJX5Y4x3opJA3Cah7sMN1VMCUbajmvihhtGGWuqgSCU/ztCNBsWDdlpmv1ChIvLlaYEQejYD6e7eyL52f1KHxg3ty767UQtuYwFnvT9CPHtRPxK1QflC4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:06:02 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:06:02 +0000
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
	Serge Semin <fancer.lancer@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 13/15] net: pcs: xpcs-plat: add NXP SJA1105/SJA1110 support
Date: Tue, 18 Nov 2025 21:05:28 +0200
Message-Id: <20251118190530.580267-14-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e36069f1-2893-4b54-235c-08de26d5846c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?89FoYVfcdxZpiIaTHzRwtj/e7OL8fc5hqU+RF3k5dxCmSPaS4iCAk/gu2VKY?=
 =?us-ascii?Q?NNZGV+7uH7T0PdL80lorFk8McjsIK6gGotnPMCLzT0sYzg6F6IM1xiqzJZpk?=
 =?us-ascii?Q?qRbYix+dcELDdoBqtNCClc+UNd70oRLPQbCFNAu/nIUFLpIL2xRB5nbUaPU9?=
 =?us-ascii?Q?xmg8Jax7xSber2a3D3bmizrBCEcANd5Yri3Xb4cVtjiNLTYPwaivDRkdEI5L?=
 =?us-ascii?Q?fEHPM/Ni4zxKpLfPzXlXNfTDnS4KszwaYG0gNd+Vz2bK5ADu1qr9x6wcVAgU?=
 =?us-ascii?Q?Gzn8ODS9vtpOgwmOuUFhmcJTvEO28PmL17hSn/j0AMr6RzI1FxdT7fcm94gf?=
 =?us-ascii?Q?KY7peOeVpg26JWxtM7VbVnAjxBlvk+xYTZdA073QhovRpVMSwlY6qt5a/ABg?=
 =?us-ascii?Q?grUz6/JnwwDGnzvsRQ2fz34EYHLh4TWGCSZNuu2pVjzfxKr/lD0jx8oxlb1/?=
 =?us-ascii?Q?1aVDxnLwL+qm5wofjqs+OHasxuWZKKA8gif4DqPOAH+74jkIlNMG+N5wOtcc?=
 =?us-ascii?Q?P7+iwQylPXgt1KGv/YIuCg9HnCZOk7KRLQfU3KwX7Bfk0+kREpqi6HY4aJpl?=
 =?us-ascii?Q?/7+3HZGFfH/VObpZRAqXhiFGtf3m76lQdP0UrBStzh5XIR2zEJds8rJ2EuoE?=
 =?us-ascii?Q?IcPR22Cc8QsuQH4dXN7zFyuG6DL7H3WpxzLNa0XpqOSo+jCvfiJcYgR/MQJo?=
 =?us-ascii?Q?mIHlhmdmxvqr9LjzdwdkBLF5YpKnMGvnosh415oqliWcUTrCn5ruBakTUSDP?=
 =?us-ascii?Q?0gbosPHhwKI5WQMuSBW6oD/VYMWxEPH/OU+ibSCJViSU0Glxsvt6cokiJZAv?=
 =?us-ascii?Q?2RmydPyV+c1yiwOND2BxZjsYPakLIDxS6Rllbk10viw1LErgBz/mZZXnOxXV?=
 =?us-ascii?Q?SIBJDLeTUTArax+ISOW9eDqLEINozqVnC24G9M9QLE0yZaHFzEvgjaC2T5UT?=
 =?us-ascii?Q?u5cR8PGhglbVDJBozMzXLqtZrWM2t8k8a41udqcOdVmT223T39Xsh+7EHh8u?=
 =?us-ascii?Q?dJft41MP/eaNgZHTHQYyZLzw0JR9cuI4NtAeYRFxe12jukQj+lZmJ+0X+7rM?=
 =?us-ascii?Q?oXsxhRZefmT842ImrExGjmERPmZ5AAcPJM6GtAyX8XalXzh8O3Q7iQykH01+?=
 =?us-ascii?Q?ItKDpUcROb7CCrAesdyFGqwzBIiSn893gfOC/TZoMNxqorTZMYHiqfX1dSPA?=
 =?us-ascii?Q?x4gelOBKkhA5sIGdXhWr/CUlD7bNQXirSWhTgVzqKIQGBhcL5G9h0UmSGaWN?=
 =?us-ascii?Q?JU6FYBEO4tZoz6+nvCAkrQQHP6G9BY+LhI7dR27xxtNRhZLxM4lGTM+2uFYZ?=
 =?us-ascii?Q?unE4Q7WKbybBTadjKkA3YwGyvs0yR/5ABawa04PvnJq0cCCza+YaYxb+hS39?=
 =?us-ascii?Q?o2HHdaT9WZl4YwmxaiBqaDYD2ibrPN3W/39CneX6CdRvtzR3Gt9LfDju2/Dq?=
 =?us-ascii?Q?7hnxZCFYgVyRN+eQiakEI/3OeG42Trf7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kzhcgn9LHIozxW8WatLbxohJHolrLrmJ/fjWrpjYggwvnGjiz94B50mLHNnM?=
 =?us-ascii?Q?wZMM2yUr0cGR8pU6l0/vDu54e56Q7H/yVO4Huj32wCJNN4oDN2GPmA6KObhO?=
 =?us-ascii?Q?Mec2hXhX0feb1uBMAT+CGtzNHef5Pcp5sqapLI1t8OnlaYOUDkdOa6cigB9D?=
 =?us-ascii?Q?Zfswo6t6Hk5KJTEN3ReYNuKHp2+Vx2inPK3YNSt7spympKI30HnJ+uBsO0+D?=
 =?us-ascii?Q?YpbazeMudmsPvMtazzfG0jhDZ51MCeSwrDvBv6pH194gxadd4vX1mbbmnQOR?=
 =?us-ascii?Q?1woNNTmNJOsZeTroW/84mnmy9hUjBisqdWM0n9i/itsyWOv2nEK89smoxusi?=
 =?us-ascii?Q?K6Gk5kEwwIMGv+0FY7wYNcXT+8zUu+Z6l5zRXBC1t8vDAGCbCObPhsWhicyb?=
 =?us-ascii?Q?ZxogVXCBkgDxZGNvqfSElxK2tJIuvqkSY/2/pecPRJeyb+HsZKnfT88g5Tgv?=
 =?us-ascii?Q?Y+q7+oW99D03G0hrSodJHnXcUkcW+Kb7uivkbplkKCJARnoi9Ix9I9lIkBtH?=
 =?us-ascii?Q?oxx80Wx8K/+wENfPPQZ3Ur7wjcwLulzc1QpDXWl0xp9wgrmZljI+W52x7oAd?=
 =?us-ascii?Q?1gfQF2EBJIueI6CC+Sc/+nYO67zc5cj98AoCIMBELB2etztmhrxTL03b0/y7?=
 =?us-ascii?Q?pwgj9XqCpxikIg9cGO2EIcREmIvJesAlp9m8Hl/h0y6AceXesmJBz8Iy1pxR?=
 =?us-ascii?Q?di18aLAgykYZRJtlO7sNkBVU525JYTlWhiSiU6FyB1ToW50lqn7l/h8RgksK?=
 =?us-ascii?Q?0FWIDhPpJTspr15ccsDUck696G3/ppWjweV7O9OEfFRnx5q8fYKDkFWB0dLK?=
 =?us-ascii?Q?z+8BEmxjHmxgWPzenZ6tAD1cqCSXzYHPrCuRTwJdowIpSS5+WkGgAidOANjw?=
 =?us-ascii?Q?WCa7EeENfckTualuQSXTLXYI1p96hHGIovrkhrHUBjgF1LJ7SfgkHuyqYL61?=
 =?us-ascii?Q?vCgJEbwq3tTTLwkQ2mKCCKY93dgSSBcBekXVeY1F/3kwoRw3MDh61HlITy+i?=
 =?us-ascii?Q?5tqejfbKR6vchTvkP7cWtMolyr4PV5WC55/lKgH5oH/fASrLZernCZ1C06kk?=
 =?us-ascii?Q?4o0MCOxkCW6FiY3SfUbKisybtdInhRTBpUANGZqD8L/HwM4Nh3CIIAbVqrA0?=
 =?us-ascii?Q?hkf/KJiyAeJvMKaMNpE9Mi10ce5btMZKr1bJG8GQUYZU9n5KG2WFZxGZpzDn?=
 =?us-ascii?Q?Fp++ZCMW1IkuMqi5o/U+mBRt4DgBzcTCrcn1wXGYqnpaMdLWVJOQCKeblaYx?=
 =?us-ascii?Q?pNd8Y4jD67ioAXzRGsI5Q/jZlGQrxotlOKN45ubAZ5cCL6mJv/diXsnHnhgN?=
 =?us-ascii?Q?PvuT7AgKUf2mWKVweObY0yZu1Kb4JwTdLhjRlbHleFzcQUeFCK02iLHnEPRm?=
 =?us-ascii?Q?v52lrSWR+qVWpd6mlnn3bH9rrhNvkawuiEvWhok0Apwi5YgUQyZaUasJIcdc?=
 =?us-ascii?Q?pxqN2yoXr4pBjx0N9XnjVSYiQBzI5WVWv28Z4zpe9X/TKALKfN1DP2dynpXc?=
 =?us-ascii?Q?CSWyhkzKcM08zTiMGC9dLfTC8cGdAOD6uVnwvdoYlRDEpQbVjd1B49fV6DDP?=
 =?us-ascii?Q?zD5YixIA5JfxG79iG2VA7NKffwy/Mnv9QOg+bE93Lw3FtNvS7ftXfbZrJMoA?=
 =?us-ascii?Q?0hhJz9Nt9MT/7un4uNf1Wgs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36069f1-2893-4b54-235c-08de26d5846c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:06:02.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3CVo/yx/G9orGUFPsbC50mBUNr6j+EvwbcTDKAifjWcdVun76qI3MJGMTpR4+xWunRbe5lhpcSemUVbD1pZ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

The XPCS in these NXP switches returns 0 when reading the ID registers,
and is integrated with a custom PMA.

The current way to support it is with hijacked PHYID register reads
in sja1105_pcs_mdio_read_c45(), to fake that it returns
NXP_SJA1105_XPCS_ID.

The new way to support it is with a specific compatible string. This
makes the platform XPCS driver use a specific struct dw_xpcs_info which
it assigns to mdiodev->dev.platform_data, and from there, xpcs_init_id()
picks it up and uses it. Later, xpcs_identify() doesn't overwrite the
xpcs->info.pcs and xpcs->info.pma unless they are set to
DW_XPCS_ID_NATIVE and DW_XPCS_PMA_ID_NATIVE, aka zeroes.

Since what is custom is the PMA and not the PCS, a later patch will
probably have to move the NXP constants around. But that should be done
only after this becomes strictly XPCS internal business.

Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-xpcs-plat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index ea6482aa8431..f96eaafb6376 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -479,6 +479,8 @@ DW_XPCS_INFO_DECLARE(xpcs_pma_gen4_3g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN4_3G_ID
 DW_XPCS_INFO_DECLARE(xpcs_pma_gen4_6g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN4_6G_ID);
 DW_XPCS_INFO_DECLARE(xpcs_pma_gen5_10g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN5_10G_ID);
 DW_XPCS_INFO_DECLARE(xpcs_pma_gen5_12g, DW_XPCS_ID_NATIVE, DW_XPCS_PMA_GEN5_12G_ID);
+DW_XPCS_INFO_DECLARE(xpcs_sja1105, NXP_SJA1105_XPCS_ID, DW_XPCS_PMA_ID_NATIVE);
+DW_XPCS_INFO_DECLARE(xpcs_sja1110, NXP_SJA1110_XPCS_ID, DW_XPCS_PMA_ID_NATIVE);
 
 static const struct of_device_id xpcs_of_ids[] = {
 	{ .compatible = "snps,dw-xpcs", .data = &xpcs_generic },
@@ -489,6 +491,8 @@ static const struct of_device_id xpcs_of_ids[] = {
 	{ .compatible = "snps,dw-xpcs-gen4-6g", .data = &xpcs_pma_gen4_6g },
 	{ .compatible = "snps,dw-xpcs-gen5-10g", .data = &xpcs_pma_gen5_10g },
 	{ .compatible = "snps,dw-xpcs-gen5-12g", .data = &xpcs_pma_gen5_12g },
+	{ .compatible = "nxp,sja1105-pcs", .data = &xpcs_sja1105 },
+	{ .compatible = "nxp,sja1110-pcs", .data = &xpcs_sja1110 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, xpcs_of_ids);
-- 
2.34.1


