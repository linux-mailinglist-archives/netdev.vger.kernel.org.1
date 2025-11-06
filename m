Return-Path: <netdev+bounces-236270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD4C3A792
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4660350FCF
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D48E30C61C;
	Thu,  6 Nov 2025 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g5AfC4O6"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626830DD2C
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427486; cv=fail; b=n7l6YJGk1heUyCBoTyvzHJInxToyxa5oHAY1VLag+76Q7xv6/MB0An7fD21OmCgVs9KzAwNdus6/AJZ4QFdDlviJvsDWXgwJwIu0jI0Xg+bc6yINULFqbt2UGmEYwUh9la7s/qiJ7OpyO/prwrp9YvP+eFcYrYWFCTnI1mEGA8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427486; c=relaxed/simple;
	bh=UnNhQZIL9/HG5p9GEum22mnxAy6/eKVoieXj8Vc9cs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JF8O5JO8PZ17U9zp7DKjvwBY/4QN7kI2X8iIMKRlwTzsp6Lc1Y5JavxYqTZryFb/5vLDf2HpEGF/OqOz5yhxzTVHfEbwK0l6wDN2rQX9fOGnXEFijjf7ErmdOJZE1cSZcRysGHmiiPou/jKOoFv048v5pYehMc1D/71MdRnVoeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g5AfC4O6; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n55/YVl9PUuLXHte3SDRZsP4qtR6HLgeG112DNUNS1AFu9vmJajtU37ZkVNNwYB1t+CjowI3J4Dn0MTeoUmSQzaa5IqTRt36RwE9lX/sX3cWB0HZ3VD4LY51vF5soFthSMqxTDtKZ2L5iAiqVtcUhq+McXpPAG66kCkpfF4xlvagxTMZT5/VUhWwY1byjpVdmG0PVV7d892SmYTTRYCh9KZ/JSYOdhmCrpXMKuPoMvjcGXXN6ZKE1C6pFyZHVefI4GYUw2QWEaKMw3YodoknKuw8Mm7E7M6jpp23jmXQVMZHulQmNi40Cfu41I83DRr28w04arXmYroqwtIiuHF44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8epQJIn2hjcfeJE1C+bfgofpwo+/gO7f5XEHkfN2M8=;
 b=dmhlKHRhhwWTuScM9y05DTnQKJ8yjHpmordQh44AGHtj0v3cCRdNzUCjGpe7ONM8oWMk8CdZfLYrtqTcpYrisD1rimCL3lfxv/S8MCK9zZ1yxz9p1jaV7V69bVfPw6ug7wlU7s/kLuOph5+6fLT2Km6dIOCmgvcCysfXyXUP7MsqrTQXTeStKEbYgdBeGSE6t4INwA8ybCqUdY9eJUO5K0TSaxOlQ5KrHlbBFEmdeLOUaahXofdnem0eShKyvK4MYvP5sjIo+bfs0DHrWaewksV05/2hr+KEZgnsQmlsNd+ls9eU/pv0pDq6RdIlChbX70b7tdFyV6U1cuHSByCq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8epQJIn2hjcfeJE1C+bfgofpwo+/gO7f5XEHkfN2M8=;
 b=g5AfC4O6phDAWW7XjbH289xEVns7MSz5QVgDLxEjlJQqw1jqhrb4eoNaW+VrG+SGJ00ZM2lBR1eM2+nwKjO3BP0OmXeIcexAmWiH8/DW6MduqskBgzPhvl98WT/2DpIE0xGX5nU/pkHHapTBRgaGBbKCg7JEE6oVMzYd31dWKgHAHvAqwfwuqdDsrxJFPCW5k9uo0s4bx0iW73BHOht2PKGgnlE9Pqgr9xL5dq92ijiT/eLEF81UewhNfsS29MAYAxWSVg8jo8Qxip2cn3ml7zWSKxzVylLu9J+cq66UeaAFcatMqOYusmbgupInnVH5FO/pWZEKGziDe6xZuxpWLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:11:17 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 11:11:17 +0000
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
Subject: [PATCH net-next 3/3] net: phy: realtek: allow CLKOUT to be disabled on RTL8211F(D)(I)-VD-CG
Date: Thu,  6 Nov 2025 13:10:03 +0200
Message-Id: <20251106111003.37023-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106111003.37023-1-vladimir.oltean@nxp.com>
References: <20251106111003.37023-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::11) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: e79fea85-1c2e-470e-5f5f-08de1d2534e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Owc+PHsQWBmo+/qXt8+A3E4Mt9Jdw3p8anhLyMEKcMMJL1J3/A0n4T1A9c4h?=
 =?us-ascii?Q?/+HX4VzqAWiKwFEJ0uhHbtpxqa308PAWmrKODEEmxBKkoMAuOSz9B7N8ciWm?=
 =?us-ascii?Q?hCUqVwvXZ/lFvSz5BRGIjS3GpX3+XrcgQdcSTHCxtB7MuvHWhmjizLc6sFt3?=
 =?us-ascii?Q?gH598Pq65BYLy2bV2GijxdskXxgoDIaH+E7MjZ1SnEhUxjhuBbQ3lZMwNN+0?=
 =?us-ascii?Q?SEzZQjJ3kxfSBaA+C93IuzEV/kPWGq/cTQeMg3eIDgLhkKAf83P7vBA3BYex?=
 =?us-ascii?Q?WyehcmM9W83v5gMv+vXyXh8NNw1hpOraSkwU3Cq5ijqPO3DsIVDFT08NuEwZ?=
 =?us-ascii?Q?jwJUYzMFYE50Isy1ksuvQ2kfMDNOCMGiUyl9tr2G9MpzIwRZcCiXOnhibX4L?=
 =?us-ascii?Q?4BnF21xUAbENBn5u0Zdtg9opo/mG0GyF3xDtHa8W7RWnt8CeeIa6V5/ihgTB?=
 =?us-ascii?Q?fITd8Bc+hWBP7cngx4FpE6bmak5oEfVeAXIzlDmxJ1Fr7ZvGGZMpDfeu53PF?=
 =?us-ascii?Q?oWIlVIvEqu8HaCbV8SIRuf9m45OiHE0DUuOQb74iB4zA4epFpFFBILIolDcs?=
 =?us-ascii?Q?KdE9fnW3YhrVd5PluEkuXAr0in46T7KN6GrMCoICmq5Al5cTx6oLapnLmRUd?=
 =?us-ascii?Q?J0xOrJuYLSbKbPm9gu8Tb3qq4dAn+rlTJf01PhVDU+iN67oK5U3vQZ558iz1?=
 =?us-ascii?Q?5bG66s2MTd4q8yIQIqeKJinwc4yIWidjuWIxSiy4KiwfjOdEk9lLYNbeiGco?=
 =?us-ascii?Q?PTUOjeM54CIYxCvDTslkjs649mk4cTnZzvxBo8pQlCcAoJzqTz4t3S4XaUSa?=
 =?us-ascii?Q?3P3gvqyol8EB6LCstwHzRsmCsKFcZN/SgkbG0mXPg6aRcyYy/I5qQ+oZ3vpj?=
 =?us-ascii?Q?VhfTXSh4XIRvBGoLVaqYSl0u3S8Or8B4+s3d361Fqp06gm0+ZngyqgadufEN?=
 =?us-ascii?Q?NibGgOo/p/yMOYDcGxUm6j5AdPM7DKNpNn/ayUluZ2125gswAwZPGEfdjaIy?=
 =?us-ascii?Q?I0TIeMboBAY4n1xkPEiOqRkWk9wantG1e4L1zr59u4ZLNKYLCOqJAqRT/d2z?=
 =?us-ascii?Q?X3IHvrM96P9CpLDsJ8ABCFZ+BeHsUUGxAvuqfMMKiwTuXioqdsHXP18c6JDP?=
 =?us-ascii?Q?7XgV1mNVm71G9v1pDgptevCjiONaUBgvruWZGd+PMX889+WPBbx7fGs3DBoB?=
 =?us-ascii?Q?/+Zpenia3EBmySsOWGZgJZhxKhlonrYPNfBHI/asKt6o8V3gJ3nDHT0k0mz1?=
 =?us-ascii?Q?oASzf3LoMP/8C/ailt5Dw8S+ozP0hgTTnHEs0e2rIhe0+4nK3ePs3eu3rl2h?=
 =?us-ascii?Q?iAGBB0GCZD2cfflDKRljXG6kG6UbDQol+2OcRG/FQv5Ae78CrRui4TnBeQtR?=
 =?us-ascii?Q?cQdsKDtz9yY4K6JAsYnPu0E16nk4XUBQ5lVpFS8ZU2qOEzsLakr/jtp37S16?=
 =?us-ascii?Q?ACnpQ8kKVWo/2H7mlinU2VTKxNxD/GqJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Llsa8KQNXnllEBTzmPdFk3dYW56gMYo4eA1qF5bv2U42lTCNCvl1XAJGjmdA?=
 =?us-ascii?Q?FRQ1Z/ZlEAeXyBlyoAlVj7DvZCiXPIsF1nZMPyqk9Os6KXo1eaZqwYIi6VRi?=
 =?us-ascii?Q?v4rS4nNQteByGwds/ZaC1tf8gG+pZWPznotouOPygY3lXwpulwvQQIAJEvlz?=
 =?us-ascii?Q?0UqxPpME7sUERgu/s9weaijgnTpDmP49eEiKJYnUqipJoukjy1lCMZ+lIHOv?=
 =?us-ascii?Q?V/UOd/pNHkTuC6OtWpi8lYgAvyfofwItQjlw3ulFsvZmrEdxlCYsaLDfO5mp?=
 =?us-ascii?Q?byIK55flE0enggOPQfmsGLG7NIAipJoXUCyntKia3jV144sreFK3koyYqpd/?=
 =?us-ascii?Q?+Wrl3hIxy9O1W5kHcMYvxyw3hAvp3nhTxpN0cKBy52+mRU5OmXMfvh3DjZWR?=
 =?us-ascii?Q?M8pSFVKF8VBrp/2sh7feS+aIM8CulrzqFZumiRpxgej/h32aTq4aLkkjLWwA?=
 =?us-ascii?Q?6+ng9LOTaz/OY3ND8G/6fb4fxrwOtVl0VQ+PFNb9NL9xmI6Ahxq10wA7ONge?=
 =?us-ascii?Q?JUQPbTnZemvjaL71x54MedCESUtXe/GbrsUywT3dCa86UAMz/6mqim2l8HMT?=
 =?us-ascii?Q?jgj4pMTU45xfZvZ7dImbU5J2QADNYXRD235LthBxkWlXXDaAdK6djgz7Og2p?=
 =?us-ascii?Q?D+GNwZTC3/Rt9ymovqEKbYA5TTB+i0vLjZnciDW3mwEY0XGhDCRlQiL+wz0u?=
 =?us-ascii?Q?cvvz6971buyzplMNP4MdqfBAAyPDCay+8b7gK8POi1hHzbd7bQ9O3Q0BYCvj?=
 =?us-ascii?Q?Wr1FL27kSt2SPRutZDxu1ue7d4cDmCaZRoS2ZxCxJ6OmsPD1lAUwgzslOUcg?=
 =?us-ascii?Q?QUMnUGW3qtho+TP6GslRiN/SwFORlP6PEK1v0/D0J4LuyKHII+rqPJWuzKgv?=
 =?us-ascii?Q?NGWPUuuAsxOC+L0zvfxqaO81MOVZpaqlRSZkyi1o46BaJIC132F1hJhLBif3?=
 =?us-ascii?Q?IlxhlqYv8hpWtSLluqH27V+17LaJrsllQ99QuxEK42VLWWCb3SuMuJdd18sM?=
 =?us-ascii?Q?KE4DS0gl9FrM+QcM327jYjg8c88VFjwzSXZDfofCqVWLilr1G32CnwA+ogQ6?=
 =?us-ascii?Q?9rC4Ux+2toGSF70ffoi5McDu0PngqtgGk7/D6pAAoKQvAS55uJ+vTY5tsjy5?=
 =?us-ascii?Q?80484YeO0TaABGC6lHh7Fb2w/tOLyh17yeuQoBy4ybxibOlgyROmR/YsfNbw?=
 =?us-ascii?Q?vmBlSHHEuS9vXN3uq0tOZS8Rv1MjLuBfVVfzEmvjfqdwjPAOhdfmLeSnlRg+?=
 =?us-ascii?Q?Qe0zYp+9/UdDR9YlwqwUfpsZIWvXUN9NjEAHPle3WqemyAYNJw85X8xEpz/j?=
 =?us-ascii?Q?w6xZ9Z7tH/QQ4PV4zlyI3XrjINy2wESKkgbPEH6UsebVSjupTgqUPx6CVhlc?=
 =?us-ascii?Q?WidKRIZTELasa4o9KJogxtIO/BmEu27cEGBeuGA8j++mSruuVwBIWbQp/2Mz?=
 =?us-ascii?Q?BO4aZ/esaS+8cBoXJRgZEHT2wlPr8Yg3eOlaPYUTwDozZn7/BvKa4P4bLHdf?=
 =?us-ascii?Q?ojN3ItsgnwKzAVYHTPuS4P6D+jmdlCcDTQcL4IptGW0wf0d/SiKojBGycY7i?=
 =?us-ascii?Q?buLkBpWy/KFvuMmilf5YeN/jssMFCGzihn4zPYgIMleWg0nWXBlApN4GwPlb?=
 =?us-ascii?Q?X1tzmPQuHH/I982MDqDDdBM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79fea85-1c2e-470e-5f5f-08de1d2534e3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:11:17.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ox3rjtUwfkoaW2bsojIlbT2dIcGRWI9OHb3BeRAfV19XwvBVFgIwHvfSgVjsmj0srosZS2aK1jl2Mh43JaRyiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

Add CLKOUT disable support for RTL8211F(D)(I)-VD-CG. Like with other PHY
variants, this feature might be requested by customers when the clock
output is not used, in order to reduce electromagnetic interference (EMI).

In the common driver, the CLKOUT configuration is done through PHYCR2.
The RTL_8211FVD_PHYID is singled out as not having that register, and
execution in rtl8211f_config_init() returns early after commit
2c67301584f2 ("net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not
present").

But actually CLKOUT is configured through a different register for this
PHY. Instead of pretending this is PHYCR2 (which it is not), just add
some code for modifying this register inside the rtl8211f_disable_clk_out()
function, and move that outside the code portion that runs only if
PHYCR2 exists.

In practice this reorders the PHYCR2 writes to disable PHY-mode EEE and
to disable the CLKOUT for the normal RTL8211F variants, but this should
be perfectly fine.

It was not noted that RTL8211F(D)(I)-VD-CG would need a genphy_soft_reset()
call after disabling the CLKOUT.

Co-developed-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/realtek/realtek_main.c | 27 +++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 89cc54a7f270..c7e54460b58d 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -90,6 +90,14 @@
 #define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
 #define RTL8211F_LEDCR_SHIFT			5
 
+/* RTL8211F(D)(I)-VD-CG CLKOUT configuration is specified via magic values
+ * to undocumented register pages. The names here do not reflect the datasheet.
+ * Unlike other PHY models, CLKOUT configuration does not go through PHYCR2.
+ */
+#define RTL8211FVD_CLKOUT_PAGE			0xd05
+#define RTL8211FVD_CLKOUT_REG			0x11
+#define RTL8211FVD_CLKOUT_EN			BIT(8)
+
 /* RTL8211F RGMII configuration */
 #define RTL8211F_RGMII_PAGE			0xd08
 
@@ -585,6 +593,11 @@ static int rtl8211f_disable_clk_out(struct phy_device *phydev)
 	if (!priv->disable_clk_out)
 		return 0;
 
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return phy_modify_paged(phydev, RTL8211FVD_CLKOUT_PAGE,
+					RTL8211FVD_CLKOUT_REG,
+					RTL8211FVD_CLKOUT_EN, 0);
+
 	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
 				RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN, 0);
 }
@@ -662,6 +675,13 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 			str_enabled_disabled(val_rxdly));
 	}
 
+	ret = rtl8211f_disable_clk_out(phydev);
+	if (ret) {
+		dev_err(dev, "clkout configuration failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
 	/* RTL8211FVD has no PHYCR2 register */
 	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
 		return 0;
@@ -672,13 +692,6 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = rtl8211f_disable_clk_out(phydev);
-	if (ret) {
-		dev_err(dev, "clkout configuration failed: %pe\n",
-			ERR_PTR(ret));
-		return ret;
-	}
-
 	return genphy_soft_reset(phydev);
 }
 
-- 
2.34.1


