Return-Path: <netdev+bounces-149422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF51D9E58F8
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAA02828DD
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC89F21C194;
	Thu,  5 Dec 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KNaajuD4"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4EE21C9EC
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410542; cv=fail; b=HU+YvOyFF9LMDWlGe8XYwS4M12kpj2agJWtFeOwaTJFvnklrTMMbq/NqjtcswQUR6jt0ljTyP+eGV3EFq52bN1ODuTT578k/POX4Lk3iwMu70XlYe3XncDJMBYHsgsfgmYUTQjub2jUCdOtiFx4YaigMDCucjdtsSo/IsNMvV+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410542; c=relaxed/simple;
	bh=4cLq1QCFfcVyKuePcQak/35JhZVCkTBOt/mdiHoqICw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VoVUD493Zp9xH493DAysIlH0YfYNcTYqD/ffl/aQtm0lVutosoLhqpFpoQp+g1blL7wMK4zYj50pYRseVWtp0kCe1Y73xjDaf31FEoHPfQ0qjpYxh9N3MVJdVCOqxKuGBm84ce9uj9kUW0Q/Q8fhSctHz4jE2ArHeN7Jr2oPvFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KNaajuD4; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ek48aMQDCpxMJqgp4Oja7Kx7ZxD82uX2WzAfAX1iC0csVjHGuQo0Ih8BvtjMZgnL6472FRGWsVk/UY3D5oBsj+n0qNBSflEWVc9UmebeqXdeomMVhAjc2IzWrjY9bl52ZgE7mK69yk8925WwCDZAk5Pbbg6UA0KFxI/mixXypBVpbUHE7+kT6j3HgyKeL1FxVV0vJpFfl4w1/+sUUiDvVfOm6iHo7tH7z2vU/mDuBGR6pqiVx5pIkk5RNv4vl9kfmwnLiFg4R49Kvfmz7GPxiyIuGd8ba5gb8mQXFLA0bEb2TIMSV/igBn+7tFPhUpvjGHPGHBlUvJU1QGtY/j0TzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJV1pUqn0wvnTcfG/OsZMBI26dRyct11agEVuORXHeE=;
 b=dUcAwoleKqv3VjEt2RFy9IJ2Nnr3dDKbfBnOdC7oDiOtuROxX/DkAxSycNZSGLldYC3FQJaJiVUecw222Z9zrdWh6gSVdXX0UVtqneEZ/nUS487K9FZKYBoMNdrJeSDVzXTnSNZ8LHrSEIYM0yO237RiwE2dyYw5qkfzbDxX++MXv3Tkp3lZEkwwBJE642NbIG0r1/G53IOYlQAps+Y32XrVTfFTaCEyYAxfvTbdOnerkjDjwf8OZJnzWjKwg0cPTTDtujdIvJiNT9vRbqSF8b3jlouuH4sLKARqDUPYgZzeQK6t0wzv6rN1/UrtSmqVaCw2WCdUghXO3iexkjr9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJV1pUqn0wvnTcfG/OsZMBI26dRyct11agEVuORXHeE=;
 b=KNaajuD4ChZk0k/8sgDAvjC91CTBK2WpQsLj9ttLwFYyXySwcvjPQlLNK2FfdBjtPFj8QQ5aEKwLLppHdJi4+uen/L14uO2sVlroWbxh5MStNR9cLsk0KFjnEmd7RLi5B8Swaz1Qo9AtX6ezTiBi+3EcSM2e5mt2/LiGolhSk1OnOvzJI4i8m9HsdeBlEUMEEvQXRcWLnDhL24FuFmVtHbBLySn2rd6PnyRmI5yiDZ0y7/LSzduKsPF4bps3lTZY+YhndYAj8shTY0JEKD0IfDLmfpRyabgN2jQLEOYIcjrKTWsdYmcNodmHeuFC3zhHMaOpm+7JCy3ve1EJ8qHhTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 14:55:32 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 14:55:32 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 net 3/5] net: mscc: ocelot: ocelot->ts_id_lock and ocelot_port->tx_skbs.lock are IRQ-safe
Date: Thu,  5 Dec 2024 16:55:17 +0200
Message-ID: <20241205145519.1236778-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
References: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10443:EE_
X-MS-Office365-Filtering-Correlation-Id: 0905f3d2-fd38-4aef-22d7-08dd153cde04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cEsXU71+UeyhAM2unm91aYzL0E8v5WvzuTVa+Si2O395nH/Oe1OM4gipPrb5?=
 =?us-ascii?Q?8Pvl9r5svNikf8tsPGCvqCuiR18g/AlZUdihpFmB/QaRFg5l4etxz04nH3H1?=
 =?us-ascii?Q?j7GVVRuNFM2FzHqH89vytBUOux4LHQx2JGJ4kGJTzzCHhzZcX9442UukbShe?=
 =?us-ascii?Q?mPIWr5DWeP2gCeHa+8+9BdD4f9tjb5yFHztKmhrF77mhsxgpMLvcm76kjOXl?=
 =?us-ascii?Q?3MYVVmGHlomvkRkD9Po+yMTb7ryXBRZFJAf05wzBp4t0u1OuQQ6OfCYRp0QH?=
 =?us-ascii?Q?HXQ8cF/29zc+hpQMeutfs/1hLL2tDK+zbQOuRBlKyVSGEGuRufYOId5Ptvvq?=
 =?us-ascii?Q?M97ctIfbfBlPuQ68SAXObJVLiJqt8yU6PZDWEiGskcyw0kSf1PyOfoOikNX0?=
 =?us-ascii?Q?dNhakMQjv5x/P9ZEcXhumME6MMQLWU4OCu3W+vxR8uGOwMmJ5wN/dAPgnmUP?=
 =?us-ascii?Q?IQFpVAPTLODMoUxVjr1PhESJhBl/YhUcyXYAtUna4vPbuRqjldwYmBhHcopd?=
 =?us-ascii?Q?meH8Kda7EeMiNYQ1Bd58sEOZbPxxU610x3vDghe0+bKol0yy0OXcyfzXRESL?=
 =?us-ascii?Q?9HHX6s9zNSBb8VntwjgLRmeBFC5W/ZFQbmOrk4J0kwQRIdHxdpgNl1f6dqAI?=
 =?us-ascii?Q?lNpCQXyfoRt2NUHrgO10U1YgIqPkfXxvetw5hI6cGWL2wAC/jHh+wdsf5dVY?=
 =?us-ascii?Q?i2ah9I+O0uXrEZRmI3ogne/GkAeyp+T3Sjn5vzFyjggzp95vq+H542G4hW2k?=
 =?us-ascii?Q?q8hqgYOCqCH6zZbkJHnwa1tFkJcQdUjdCM9tdw8049nbMRfk0R+ylsrktoEV?=
 =?us-ascii?Q?D9v7ojXht+rngiDniATCzX/06WGwdroDCJK82qRDIeYGbe71o/9pBsmoUGfP?=
 =?us-ascii?Q?mj09WU04ZuF7A2JYQ4+DBxA9XZwvKsGe5HrAFQf49x4ofm5KnrEzqnMOAx4+?=
 =?us-ascii?Q?C9PVfA13LJmxmGUNGmXamHOGC56UIpSLAvyMIObMyprSj9L0gVDBClKskRi9?=
 =?us-ascii?Q?pMPfFaVUk8mmQBJVh2rtnkB0yYANCGQFllc+O+0rNu6Gol4QMT1gSW7Zi9NO?=
 =?us-ascii?Q?baV/bOXTXNWfVyj93M2kiYjLZYLC6sCUme4y5rFpzIN4bmKqhe5xccsJC3JZ?=
 =?us-ascii?Q?ykBpM7ccKkf0eVTb3dDQn+QXQzw8FvIPsZ7h8wAKi0TAjezLf/EnJaQeATzA?=
 =?us-ascii?Q?ruUy0g+LRR042+83CEPZu9KhlypELGckx76vdljLjsa5wGO0/xb6f7UT5oiJ?=
 =?us-ascii?Q?1g6jqRcZMSmfFUY09slI/sV2UdN9RvgK2cqyI6qlIa374alGWPK0S3XXPbG5?=
 =?us-ascii?Q?YnNik5YCDAYllUvFPrh++BIBlZnXAjQ+TS/TbecgxIe7i0ba0QQq/S3+HTKT?=
 =?us-ascii?Q?SVQN8OX/E2S+wl+S9/wVDHZEgAeVpybgdeMGFNE8goMcKx6tfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mnP1rrx5dM8LL3V6cCspvgCKTXV2lRMTnPqXV8OSDNSNHJhC7U0VmngzCWiX?=
 =?us-ascii?Q?yI+EkX8E1GjuY/fVETS5rTTvF3eJckDaFwmD8JGU6hPyErG/+cLiBW7yv2U6?=
 =?us-ascii?Q?zEgh62JFTJmx6+OcGTJZ8thIUXzjEyhD22npKDJy00Hjvw2YlpLiFLpdUuxV?=
 =?us-ascii?Q?w3Brr5PoU1PgG5//2XiWtWPzkue08TYda50EulQEjCYyZH+98N6hKf/dnBDP?=
 =?us-ascii?Q?te02CRUO13BiKQlgTA7a/5H0xdRkz4+9oWGYTVJ4cZFUXGllWosjgYAnzfB5?=
 =?us-ascii?Q?Bj4WjbCNaVgjZfGMb3xe92jqSfKiOBSZ7jMHgLgxcqOJre2YJmCQzjmnA3Q+?=
 =?us-ascii?Q?uYI8DmPqFK1Yat6/AXu+KebYbzlb1Fuu1Ou11D2hz+gfnT1HaFZBuSHijW+S?=
 =?us-ascii?Q?BZPS5Zu8tEXiep1eGHDPzvdkz/0MsazQUUrG4PHOJKWqyhvir8XHJm3cOeYv?=
 =?us-ascii?Q?JZIKs+Ya/LWdNDwuYm0pBCkVDWbcO1aVNsX9eMp66ViZhQPWPhRUZ5H74u5O?=
 =?us-ascii?Q?gwTITRrfTvMKR8QirAJyqs4f5exHtKd73RM4cn9Xo3SRCHFPhPUuwi6EKugc?=
 =?us-ascii?Q?cSXqGp+2TDvg4OgNA0K1mWZxCVOj6W0iFmPeO58U4MBq0OAHVCcMbXzD5i2g?=
 =?us-ascii?Q?F0oEtPo6Zn2nJs+Bj5KbUfK4Hy5UiSiXZLxhCHmASg2UcbOUOCghVRiC5J1R?=
 =?us-ascii?Q?yoD/ouXkY2S1B+maOKQpJddY3CGQzoRzpN82VNxyLVtdSYKZwIrq+Zh3wwtH?=
 =?us-ascii?Q?miEDgYl1aItzmXNkYTH1raYop3M5c9cR9mL8hwivSc21NC1vgrPZlhNSinbm?=
 =?us-ascii?Q?NAP3GGi21H5KTUXMkEI7O4sUVHoJfWmgfEkPFZtBMcsGjyq9cLFMWB41oP94?=
 =?us-ascii?Q?WojpSIk19bstwJUjuIQVAEh7pbZpaLiqInr9RT6b/1GUFH1H0J9qRLXhjKas?=
 =?us-ascii?Q?Crj2Xp9eARU5yO1SLblNjI2zYt2F4s/owju5ecomGffBC7EfsNKZyNgzlO/K?=
 =?us-ascii?Q?O7MFSKdft1z4D5sZcJk9I7pkIGHOEDilAVovVTkFP0zZGGODf0RMio3Brm9X?=
 =?us-ascii?Q?Ku+CXcADpThcSTm6ID4CHqzji9OA8kAjeC1Q31p/ajl2uSv22bxX0V6Kmtvp?=
 =?us-ascii?Q?bWJfQ1PaC+B6amtqLe9KsYGVKIKdFN3nKJvgqSBqQSdZTawYMtUuBJ9Ru4Q1?=
 =?us-ascii?Q?W4uwAgX66+FhQ8EjI2pytO4K+tAZPSeGxaxp1ty6g3DldnzfSCQ9oFRCL7DZ?=
 =?us-ascii?Q?9d/HcZ2PVqf8ljsRHzSq/KPEdHH1cKKuaNTlDCoBsBBL5r5OqUpTRFzQY0GP?=
 =?us-ascii?Q?e4sc4pt25NtnlV8rI5IbP+8QL/1Oas58f+x3jDRfIL54yE9LhqeCTm2n09Lr?=
 =?us-ascii?Q?f4LjoYsJy482NiZyZ99tE3Bda+MCH/YZ8C8Z/90VUhwLoHt0tWTuDVvtLsxv?=
 =?us-ascii?Q?cUeP434kKH7j6/seHPrrm0UzFKz3I/FdZCvebsOjxo+Qhbba+uWP9axIPIHD?=
 =?us-ascii?Q?hSrUGPEA/DyE48V0BSdXFP0yL55P8bMFmNVc0pwvRMMSHEfGbx40Zph9u99a?=
 =?us-ascii?Q?oya8juTfEYn+E2kBbOdtl9IZAjf5IfZgXW2UQrDXI4+hWUHl+PokdUyZdRZO?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0905f3d2-fd38-4aef-22d7-08dd153cde04
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:55:32.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PElLBY34KEBAqlBxn6J3mGUinsYmN0bwx9ZoeNM/lmzqe2Hy9YQvjFO5XFd3HqTZ7aQiaER3Mc8S9cagdznuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

ocelot_get_txtstamp() is a threaded IRQ handler, requested explicitly as
such by both ocelot_ptp_rdy_irq_handler() and vsc9959_irq_handler().

As such, it runs with IRQs enabled, and not in hardirq context. Thus,
ocelot_port_add_txtstamp_skb() has no reason to turn off IRQs, it cannot
be preempted by ocelot_get_txtstamp(). For the same reason,
dev_kfree_skb_any_reason() will always evaluate as kfree_skb_reason() in
this calling context, so just simplify the dev_kfree_skb_any() call to
kfree_skb().

Also, ocelot_port_txtstamp_request() runs from NET_TX softirq context,
not with hardirqs enabled. Thus, ocelot_get_txtstamp() which shares the
ocelot_port->tx_skbs.lock lock with it, has no reason to disable hardirqs.

This is part of a larger rework of the TX timestamping procedure.
A logical subportion of the rework has been split into a separate
change.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_ptp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index 95a5267bc9ce..d732f99e6391 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -607,13 +607,12 @@ static int ocelot_port_add_txtstamp_skb(struct ocelot *ocelot, int port,
 					struct sk_buff *clone)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
-	unsigned long flags;
 
-	spin_lock_irqsave(&ocelot->ts_id_lock, flags);
+	spin_lock(&ocelot->ts_id_lock);
 
 	if (ocelot_port->ptp_skbs_in_flight == OCELOT_MAX_PTP_ID ||
 	    ocelot->ptp_skbs_in_flight == OCELOT_PTP_FIFO_SIZE) {
-		spin_unlock_irqrestore(&ocelot->ts_id_lock, flags);
+		spin_unlock(&ocelot->ts_id_lock);
 		return -EBUSY;
 	}
 
@@ -630,7 +629,7 @@ static int ocelot_port_add_txtstamp_skb(struct ocelot *ocelot, int port,
 
 	skb_queue_tail(&ocelot_port->tx_skbs, clone);
 
-	spin_unlock_irqrestore(&ocelot->ts_id_lock, flags);
+	spin_unlock(&ocelot->ts_id_lock);
 
 	return 0;
 }
@@ -749,7 +748,6 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		u32 val, id, seqid, txport;
 		struct ocelot_port *port;
 		struct timespec64 ts;
-		unsigned long flags;
 
 		val = ocelot_read(ocelot, SYS_PTP_STATUS);
 
@@ -773,7 +771,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 
 		/* Retrieve its associated skb */
 try_again:
-		spin_lock_irqsave(&port->tx_skbs.lock, flags);
+		spin_lock(&port->tx_skbs.lock);
 
 		skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
 			if (OCELOT_SKB_CB(skb)->ts_id != id)
@@ -783,7 +781,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 			break;
 		}
 
-		spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
+		spin_unlock(&port->tx_skbs.lock);
 
 		if (WARN_ON(!skb_match))
 			goto next_ts;
@@ -792,7 +790,7 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 			dev_err_ratelimited(ocelot->dev,
 					    "port %d received stale TX timestamp for seqid %d, discarding\n",
 					    txport, seqid);
-			dev_kfree_skb_any(skb);
+			kfree_skb(skb);
 			goto try_again;
 		}
 
-- 
2.43.0


