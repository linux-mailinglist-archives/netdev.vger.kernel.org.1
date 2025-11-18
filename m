Return-Path: <netdev+bounces-239680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E73C6B586
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A9DAA29877
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC892E2F1F;
	Tue, 18 Nov 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aO33NUpe"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF902DF131;
	Tue, 18 Nov 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492755; cv=fail; b=luXU2x7Jl2+NFg6O6V929ItV9bgJqM5M4WBFZivr7/YPS28yjV4CME6E1p0vn/BvVr+CozYke3dM+dXYShAphF8C1hohuLbK4JY/dZ+Cj3tBA0O5aVpK4Fhj11k9nRQd8PUPJNmyVs0uekh9MGmBUzE4OomQBZHmlrvUX2YNcNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492755; c=relaxed/simple;
	bh=QzgfSpeZFH3tg0mI+dfiexIeivc1nItH5xUP31/o0oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B5RuN/YnHw3EiSLkU2++KRnw1LCZgMW0c2EqMOpMK/6xTBKEO3r1+V5HGklg4pVO2+BSWWaYuQYIJDLmh29cMraB89iyD+5efwDEMr6vBdDmoNtLo7I8iwRhcwL77VPyj0rO/sleCubagNGklOi+g2wIYCIKEPBThZVat28LN00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aO33NUpe; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBEDm8GV2KYEZ5tHENkx21jh0d+5ut4rwajAdxeu9XZd4VAbjx9C7Z5Yf8y1qQBAbEyDGAHS/NwuiHADn1fz6efbvirNbcMVjb519CsoQmmy27DZ2fIL/QdcvyGjji0+dQRTcJ2N7l9DEIHUdBwPLHw76Xw5OstvGKCAsSM5bjylfeFB03m9t+XOGFcBhKCDJT6bKJV9Xlfe1zhz8PU89q1bXmcHPE/8QjIN8nNUB7iOr0IRaiOBwe+tB24fQNsaTvryDwQnqnQPSV0D463cQqNpHSzpyKsvscStAndvEB3MW5dbTm3RW8MmnA2QeEXG56vClvnUByZ9BnLCR2uIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYT3iuxfTJ2CXszx+FhBg5TJ8UT2ynvoYhiKQbh4Zcw=;
 b=ecf4MYLdF5kB7T1mz9R2qco8vCjH1xAgj+GkDxvW8cAE819RvlltggNic4k9uYsTit32yZWTAoRZryK2J5l4oeZWWihDWkKQbfG8vfvDg03EL3088WBvqse7+qFvZMsaoqh+4BB5i6kpdU4mOUAvxVLmu1a6FCuW1W8EFZCZI+6SD7kbXkFTQD3ArH1/sm542AZqrT10O9nUDR5fh3hmVhTKcw5aXQbdZyCUHx/WQCptQEfES6fH25JpHKGmVVlqGjZeAvQBf/kAH8nTl4fdy+o1olarm48AB0MT1DeT7t6RzsdXh6cH/OCBLZK5dEebVHT0nRro2VWPffIsQQk/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYT3iuxfTJ2CXszx+FhBg5TJ8UT2ynvoYhiKQbh4Zcw=;
 b=aO33NUpeOhkgrxe0nIYHrfpzZazwjtO0tQIgNi2ette4wUh8hnX3sQMQfLNhjDtEva4ctmQZadFSgWHOTBOAgbROjn/9dJYZFJc+kZikow97EQBxEORcC8rsAJ9Y90sEUq3ewwXm4f5uVWR4x33e5Ez7/8zm1WsOH08qof3S3zuTV6HLLrQFZi/di4MsV1GH9T8YCspKeNpZUkoMBv5MDUGMxRQtpsLJYLWpuV6GSNvjK4u1hnjPDhfMmuSklsI16dG+ccVFDMAIjnp1wsHgvw7UMfkd0oKmpcFwRy1qf3Pbu0vEsz5cSh+7wJqH4pEQ0+3td0vEH/+pKaHBuT93BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:48 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:48 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/15] net: dsa: sja1105: let phylink help with the replay of link callbacks
Date: Tue, 18 Nov 2025 21:05:16 +0200
Message-Id: <20251118190530.580267-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e8f87ac-794b-46c4-f289-08de26d57c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZsX6I1sA1K5w46ixFnPr6c1f4+7O59gi+GkAroLxlTz3yAyTGh3Z5z6BhyGz?=
 =?us-ascii?Q?KT9qGtoi2/7jTbM2X18Dzzu1NDtHiUjTnW08LcL+qj4nihnj6gHbfBq2o4wp?=
 =?us-ascii?Q?5oULQ9bafJLUP3mX+Pboa5WBL7M/2AJvpWZmLKn3sVGG2TKnMWw0bW5pmi6C?=
 =?us-ascii?Q?OqhqEGU4Oz2gN9kr8zMF/8dq9pPj/tYpITGDEc++qHNbsas9UPz+tO7M5Hhz?=
 =?us-ascii?Q?wnncV6jDBhQilBtBLkyIV7iXoCAmF6xZJQLLcsc0OGZdjH9YpIoc7gdQMQIE?=
 =?us-ascii?Q?H/m4owxF1rlFsCLnu93EJq6eP7o57lPDVqd4FcYebd/gYDipfdKe2zE74DJS?=
 =?us-ascii?Q?2ShL499W6HkQRPj+OZWlI3wgtjnWjJkVbiKCcqa3s3/I2xYMeUUXSkxEUSZR?=
 =?us-ascii?Q?cMoE3Xs5c4G/vbUv6cZZyuJLlD3sGWHYeQGhafFYhMYwTSRNaNSDvuXpeaRt?=
 =?us-ascii?Q?S/g9Gn6hxyzntVWE/5IkMVHgLoOsG67kNJ6TMdu0WoCg799udbw/3FF6HaL6?=
 =?us-ascii?Q?oqlOQZaW+uiPQG9+Ovcof7EyX3d4rzJbzRNgW8Gd1uliy+bpdSTEBcL+1r7K?=
 =?us-ascii?Q?1g9WwlkwpUWtVTCQrDAsL2wwmZr1yakdj1+og8JEOJEFgd8oQUTpebS7UT9N?=
 =?us-ascii?Q?DmufQVUbc88tH3WjmMpkfgcfqAQpc7CENJ9QdjrwOnETF2QGRNOX6O8xwGvS?=
 =?us-ascii?Q?6rH70T7FlB9ruFqFLKx3hwx+VmQsRrYry8vmyk+W/Ny3ij41r0zNXVLMVmZM?=
 =?us-ascii?Q?/78vqq+D5ttlqiiUM1i6/DTJHP/4dZRraS67AztgAHps/XjSllD/s2H5JwHx?=
 =?us-ascii?Q?lQL0mhMTvQjo9uycs9VkMa/TMy1o58JAz4eEHOBQkbfgHDOgwKtJm2efYHMX?=
 =?us-ascii?Q?damzTdkXOyMVOk3z7l01T8QQKh9nMtJsUpQvpSKOjZybxbBfT+1O8+wkEdNL?=
 =?us-ascii?Q?UiH69ufZ+1YP45ME0Xo3kgka6vSk3ZFYsgi5NgUPOcdOnEplXrX2fqlIcfus?=
 =?us-ascii?Q?5TT7LMiZZG8t4p/9ZCVk7yG/VOxA93q6thriTLzK0HDG3UeI9neiYU5EZK1y?=
 =?us-ascii?Q?ZdDUreh5y9Cu8S3duG9JRnFsh7AE4Zmh4yd+MOEnBeUaKL66q93BYeiL+cZa?=
 =?us-ascii?Q?fCPyayjFIzUEHt0suWHeETFnoWO/GYqg+XmngVAV1IBaCttItL0HJ03bdpeJ?=
 =?us-ascii?Q?icsLVoBuTTx23lgcr8xj6TohBvkat0LM8c30K84qB5eDuWAiTCYSa1sR81bW?=
 =?us-ascii?Q?X5Z/POT/3JdMguguKAu2sjMMlHOoePAyaQMmNqSHLfVJEUCfHep43cHiFoxl?=
 =?us-ascii?Q?P/PQ/6Hd8pjzKUufssY7XROpB6QV9ipsTbiadPN91nvxZr5YyMiijkUQSxQw?=
 =?us-ascii?Q?o5KnHVFpRvkr7yEKEmjDwGSxVzjeCNh/pHnIxQPbGLdwN+mcXh7jCdxHZbSN?=
 =?us-ascii?Q?EfsChH6aYW0w6RfZW4LZW8fR09muZKxd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FYPBxT7rCZxWU7ByMyjfA9vzKWDt5FUzsW7bT+InB+f/hu4/ExzrkShAejWl?=
 =?us-ascii?Q?pFiLWEgocWiGki+EC+LYIHUe+uSAH0WJ7Mkx4m/ua7XYITYpGMeAeB1vXlsX?=
 =?us-ascii?Q?O28vlpCYkqhpS7BgfW6r1v6UKYhAK6oTAbqAJp5xwjTDbaScqFNNi52sObRA?=
 =?us-ascii?Q?IAsH9QAsnTfX+9ynd0dxXEcJ2AptodmNR2rwlc+ZOWK7KLDluA7JF3UvVeGM?=
 =?us-ascii?Q?mjAW2cYNbS12iKCv7sdcIHQLx8zwjbjuVOZh3zlD/SKLHbxNIfmXnwqbcCOL?=
 =?us-ascii?Q?ZqNLpY1oy2MtXBfRZkCqm0bWt7Q1AsGaMBwWW3sABFEOwDjdq3PTO9WGMRuZ?=
 =?us-ascii?Q?5+uZ84FbncUAYBxG1fOUqdj+7yI2GU8RhsYSUOFX2sKO2qIx7fOhgcLmmNq7?=
 =?us-ascii?Q?a013GmIeHQzWDxEnNtkdGe2RDWSMjtPuGXvJqXbPTjDxi3u98Bk/7gN/OhgE?=
 =?us-ascii?Q?Z4t2rJwNf5J4V0T4cbFHMHnE2bn46CaiFPQrr2cdRr62F0WtCtQ96Uao5AlD?=
 =?us-ascii?Q?xkHPh3k4K5E/IcFsVVgnzdH05+UTqeAryHLB5L+326VDaXa24i9V0nUIF3DI?=
 =?us-ascii?Q?G/gyj2RhlDJPwvpMAlFWpCSy1oznKzjp76H7dhmD8sOsG/u1AOPeuzjpdBnD?=
 =?us-ascii?Q?gFyUGfupmvM6Kb1pNEo1GwxVjZQkLC7MBNglrht6JfuXpfIAfSKptuAckuA9?=
 =?us-ascii?Q?Mn0iVN2bIPgFmUmxKb7zdLT6/NJV5pRidBA+R2kn+ZuAukWvEN6cjjWQQHxu?=
 =?us-ascii?Q?arLvHI4bLfO2V7Cs9q7V3JvnXFV+lsL110CMubU0Xm/a2asFXvjowgaod41G?=
 =?us-ascii?Q?Et1kCt2AeurDCWttmeSMdkc6I7+837tqTd1h1E7uBramoKjM1Jvu4r6L9auw?=
 =?us-ascii?Q?xtRc5EKWatRwzXhvzTQeYAKvbCHXnkWcWJ5dMOSQR89k/LmPyALvZlrnYLIw?=
 =?us-ascii?Q?A1bO2/tx6abvu2j5/27i4Av4ZjZLCQ9KTwLSSVXrhZAqCNtR7hrufylZsYSF?=
 =?us-ascii?Q?mNH7d1S2iXZwj/GGzskn0AhT4ReNW9wvoAP26dhmylArKs/M5cDqWddgHwvn?=
 =?us-ascii?Q?BAaBroQchzhUe4ESzB0ZKawB0LfFQLh72dW/oNXTL77PAv+KwjUH6O7QWFeI?=
 =?us-ascii?Q?MemkrlNFNE/m159kaq649OXTUAJcLS8M/bBXOjM0sSkuv31/vvJ5s3GFmPbl?=
 =?us-ascii?Q?zcLZFBOpoM1XqQGwX814O17JKXI2mtHjxif0DYP7Rf4qhzBs65Iiz11m55wO?=
 =?us-ascii?Q?SLeyeQxyvcIXDjjZZrgT2fARJ9P+UjssZ6RMmbPfghuN4G8m4x5LTF/gVvpL?=
 =?us-ascii?Q?BDfJll62UsKneeXiZBcKbrchZzvF+F6GZu/8nbZXfOEekSEjPiUR6zUqCRxH?=
 =?us-ascii?Q?JpVu6M8lKz2ET5o4LRUAZT901hsslFwuTn0t52sb6o3zfsPPIY8v/k+iaCbo?=
 =?us-ascii?Q?ZuID+ynIYTsXA7OwARXL1Ex+Pnwt9k9w0/YZFNf1hEZfuhrHQuno+byS6so5?=
 =?us-ascii?Q?J/sV/xWVd/Rv5eusFX19KvAvyWJdmar4S7e+ejw6mkloKEs/+QeAMMW9r3Dy?=
 =?us-ascii?Q?vBebajezxNTmj6eNIr0I6GThiQLu2BOCpwrL+WvmcukNSGcidjnjruoarVv3?=
 =?us-ascii?Q?hpqTzY0Q7XoWADqLZzGqVrw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8f87ac-794b-46c4-f289-08de26d57c0c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:48.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xOBEnaoj2MTbRPjln2VKDiZR+2GUCa/8ZnzIzluVyItARsoxTwSl2llX4WStiw/eG+NNd02AlFEMyWysn7l0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

sja1105_static_config_reload() changes major settings in the switch and
it requires a reset. A use case is to change things like Qdiscs (but see
sja1105_reset_reasons[] for full list) while PTP synchronization is
running, and the servo loop must not exit the locked state (s2).
Therefore, stopping and restarting the phylink instances of all ports is
not desirable, because that also stops the phylib state machine, and
retriggers a seconds-long auto-negotiation process that breaks PTP.
Thus, saving and restoring the link management settings is handled
privately by the driver.

The method got progressively more complex as SGMII support got added,
because this is handled through the xpcs phylink_pcs component, to which
we don't have unfettered access. Nonetheless, the switch reset line is
hardwired to also reset the XPCS, creating a situation where it loses
state and needs to be reprogrammed at a moment in time outside phylink's
control.

Although commits 907476c66d73 ("net: dsa: sja1105: call PCS
config/link_up via pcs_ops structure") and 41bf58314b17 ("net: dsa:
sja1105: use phylink_pcs internally") made the sja1105 <-> xpcs
interaction slightly prettier, we still depend heavily on the PCS being
"XPCS-like", because to back up its settings, we read the MII_BMCR
register, through a mdiobus_c45_read() operation, breaking all layering
separation.

But the phylink instance already has all that state, and more. It's just
that it's private. In this proposal, phylink offers 2 helpers for
walking the MAC and PCS drivers again through the callbacks required
during a destructive reset operation: mac_link_down() -> pcs_link_down()
-> mac_config() -> pcs_config() -> mac_link_up() -> pcs_link_up().

This creates the unique opportunity to simplify away even more code than
just the xpcs handling from sja1105_static_config_reload().
The sja1105_set_port_config() method is also invoked from
sja1105_mac_link_up(). And since that is now called directly by
phylink.. we can just remove it from sja1105_static_config_reload().
This makes it possible to re-merge sja1105_set_port_speed() and
sja1105_set_port_config() in a later change.

Note that my only setups with sja1105 where the xpcs is used is with the
xpcs on the CPU-facing port (fixed-link). Thus, I cannot test xpcs + PHY.
But the replay procedure walks through all ports, and I did test a
regular RGMII user port + a PHY.

ptp4l[54.552]: master offset          5 s2 freq    -931 path delay       764
ptp4l[55.551]: master offset         22 s2 freq    -913 path delay       764
ptp4l[56.551]: master offset         13 s2 freq    -915 path delay       765
ptp4l[57.552]: master offset          5 s2 freq    -919 path delay       765
ptp4l[58.553]: master offset         13 s2 freq    -910 path delay       765
ptp4l[59.553]: master offset         13 s2 freq    -906 path delay       765
ptp4l[60.553]: master offset          6 s2 freq    -909 path delay       765
ptp4l[61.553]: master offset          6 s2 freq    -907 path delay       765
ptp4l[62.553]: master offset          6 s2 freq    -906 path delay       765
ptp4l[63.553]: master offset         14 s2 freq    -896 path delay       765
$ ip link set br0 type bridge vlan_filtering 1
[   63.983283] sja1105 spi2.0 sw0p0: Link is Down
[   63.991913] sja1105 spi2.0: Link is Down
[   64.009784] sja1105 spi2.0: Reset switch and programmed static config. Reason: VLAN filtering
[   64.020217] sja1105 spi2.0 sw0p0: Link is Up - 1Gbps/Full - flow control off
[   64.030683] sja1105 spi2.0: Link is Up - 1Gbps/Full - flow control off
ptp4l[64.554]: master offset       7397 s2 freq   +6491 path delay       765
ptp4l[65.554]: master offset         38 s2 freq   +1352 path delay       765
ptp4l[66.554]: master offset      -2225 s2 freq    -900 path delay       764
ptp4l[67.555]: master offset      -2226 s2 freq   -1569 path delay       765
ptp4l[68.555]: master offset      -1553 s2 freq   -1563 path delay       765
ptp4l[69.555]: master offset       -865 s2 freq   -1341 path delay       765
ptp4l[70.555]: master offset       -401 s2 freq   -1137 path delay       765
ptp4l[71.556]: master offset       -145 s2 freq   -1001 path delay       765
ptp4l[72.558]: master offset        -26 s2 freq    -926 path delay       765
ptp4l[73.557]: master offset         30 s2 freq    -877 path delay       765
ptp4l[74.557]: master offset         47 s2 freq    -851 path delay       765
ptp4l[75.557]: master offset         29 s2 freq    -855 path delay       765

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Change previously submitted here:
https://lore.kernel.org/netdev/20241212172026.ivjkhm7s2qt6ejyz@skbuf/

I've implemented Russell's feedback given back then, which he hasn't
confirmed back.

 drivers/net/dsa/sja1105/sja1105_main.c | 58 +++-----------------
 drivers/net/phy/phylink.c              | 75 ++++++++++++++++++++++----
 include/linux/phylink.h                |  5 ++
 3 files changed, 77 insertions(+), 61 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index f674c400f05b..9f62cc7e1bd1 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2287,14 +2287,12 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 {
 	struct ptp_system_timestamp ptp_sts_before;
 	struct ptp_system_timestamp ptp_sts_after;
-	u16 bmcr[SJA1105_MAX_NUM_PORTS] = {0};
-	u64 mac_speed[SJA1105_MAX_NUM_PORTS];
 	struct sja1105_mac_config_entry *mac;
 	struct dsa_switch *ds = priv->ds;
+	struct dsa_port *dp;
 	s64 t1, t2, t3, t4;
-	s64 t12, t34;
-	int rc, i;
-	s64 now;
+	s64 t12, t34, now;
+	int rc;
 
 	mutex_lock(&priv->fdb_lock);
 	mutex_lock(&priv->mgmt_lock);
@@ -2306,13 +2304,9 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 	 * switch wants to see in the static config in order to allow us to
 	 * change it through the dynamic interface later.
 	 */
-	for (i = 0; i < ds->num_ports; i++) {
-		mac_speed[i] = mac[i].speed;
-		mac[i].speed = priv->info->port_speed[SJA1105_SPEED_AUTO];
-
-		if (priv->pcs[i])
-			bmcr[i] = mdiobus_c45_read(priv->mdio_pcs, i,
-						   MDIO_MMD_VEND2, MDIO_CTRL1);
+	dsa_switch_for_each_available_port(dp, ds) {
+		phylink_replay_link_begin(dp->pl);
+		mac[dp->index].speed = priv->info->port_speed[SJA1105_SPEED_AUTO];
 	}
 
 	/* No PTP operations can run right now */
@@ -2366,44 +2360,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 			goto out;
 	}
 
-	for (i = 0; i < ds->num_ports; i++) {
-		struct phylink_pcs *pcs = priv->pcs[i];
-		unsigned int neg_mode;
-
-		mac[i].speed = mac_speed[i];
-		rc = sja1105_set_port_config(priv, i);
-		if (rc < 0)
-			goto out;
-
-		if (!pcs)
-			continue;
-
-		if (bmcr[i] & BMCR_ANENABLE)
-			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
-		else
-			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
-
-		rc = pcs->ops->pcs_config(pcs, neg_mode, priv->phy_mode[i],
-					  NULL, true);
-		if (rc < 0)
-			goto out;
-
-		if (neg_mode == PHYLINK_PCS_NEG_OUTBAND) {
-			int speed = SPEED_UNKNOWN;
-
-			if (priv->phy_mode[i] == PHY_INTERFACE_MODE_2500BASEX)
-				speed = SPEED_2500;
-			else if (bmcr[i] & BMCR_SPEED1000)
-				speed = SPEED_1000;
-			else if (bmcr[i] & BMCR_SPEED100)
-				speed = SPEED_100;
-			else
-				speed = SPEED_10;
-
-			pcs->ops->pcs_link_up(pcs, neg_mode, priv->phy_mode[i],
-					      speed, DUPLEX_FULL);
-		}
-	}
+	dsa_switch_for_each_available_port(dp, ds)
+		 phylink_replay_link_end(dp->pl);
 
 	rc = sja1105_reload_cbs(priv);
 	if (rc < 0)
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6e1243bf68aa..19b8ddabee03 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -28,6 +28,7 @@ enum {
 	PHYLINK_DISABLE_STOPPED,
 	PHYLINK_DISABLE_LINK,
 	PHYLINK_DISABLE_MAC_WOL,
+	PHYLINK_DISABLE_REPLAY,
 
 	PCS_STATE_DOWN = 0,
 	PCS_STATE_STARTING,
@@ -77,6 +78,7 @@ struct phylink {
 
 	bool link_failed;
 	bool suspend_link_up;
+	bool force_major_config;
 	bool major_config_failed;
 	bool mac_supports_eee_ops;
 	bool mac_supports_eee;
@@ -1680,18 +1682,18 @@ static void phylink_resolve(struct work_struct *w)
 	if (pl->act_link_an_mode != MLO_AN_FIXED)
 		phylink_apply_manual_flow(pl, &link_state);
 
-	if (mac_config) {
-		if (link_state.interface != pl->link_config.interface) {
-			/* The interface has changed, force the link down and
-			 * then reconfigure.
-			 */
-			if (cur_link_state) {
-				phylink_link_down(pl);
-				cur_link_state = false;
-			}
-			phylink_major_config(pl, false, &link_state);
-			pl->link_config.interface = link_state.interface;
+	if ((mac_config && link_state.interface != pl->link_config.interface) ||
+	    pl->force_major_config) {
+		/* The interface has changed or a forced major configuration
+		 * was requested, so force the link down and then reconfigure.
+		 */
+		if (cur_link_state) {
+			phylink_link_down(pl);
+			cur_link_state = false;
 		}
+		phylink_major_config(pl, false, &link_state);
+		pl->link_config.interface = link_state.interface;
+		pl->force_major_config = false;
 	}
 
 	/* If configuration of the interface failed, force the link down
@@ -4355,6 +4357,57 @@ void phylink_mii_c45_pcs_get_state(struct mdio_device *pcs,
 }
 EXPORT_SYMBOL_GPL(phylink_mii_c45_pcs_get_state);
 
+/**
+ * phylink_replay_link_begin() - begin replay of link callbacks for driver
+ *				 which loses state
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Helper for MAC drivers which may perform a destructive reset at runtime.
+ * Both the own driver's mac_link_down() method is called, as well as the
+ * pcs_link_down() method of the split PCS (if any).
+ *
+ * This is similar to phylink_stop(), except it does not alter the state of
+ * the phylib PHY (it is assumed that it is not affected by the MAC destructive
+ * reset).
+ */
+void phylink_replay_link_begin(struct phylink *pl)
+{
+	ASSERT_RTNL();
+
+	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_REPLAY);
+}
+EXPORT_SYMBOL_GPL(phylink_replay_link_begin);
+
+/**
+ * phylink_replay_link_end() - end replay of link callbacks for driver
+ *			       which lost state
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Helper for MAC drivers which may perform a destructive reset at runtime.
+ * Both the own driver's mac_config() and mac_link_up() methods, as well as the
+ * pcs_config() and pcs_link_up() method of the split PCS (if any), are called.
+ *
+ * This is similar to phylink_start(), except it does not alter the state of
+ * the phylib PHY.
+ *
+ * One must call this method only within the same rtnl_lock() critical section
+ * as a previous phylink_replay_link_start().
+ */
+void phylink_replay_link_end(struct phylink *pl)
+{
+	ASSERT_RTNL();
+
+	if (WARN(!test_bit(PHYLINK_DISABLE_REPLAY,
+			   &pl->phylink_disable_state),
+		 "phylink_replay_link_end() called without a prior phylink_replay_link_begin()\n"))
+		return;
+
+	pl->force_major_config = true;
+	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_REPLAY);
+	flush_work(&pl->resolve);
+}
+EXPORT_SYMBOL_GPL(phylink_replay_link_end);
+
 static int __init phylink_init(void)
 {
 	for (int i = 0; i < ARRAY_SIZE(phylink_sfp_interface_preference); ++i)
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 38363e566ac3..d6ea817abcda 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -836,4 +836,9 @@ void phylink_mii_c45_pcs_get_state(struct mdio_device *pcs,
 
 void phylink_decode_usxgmii_word(struct phylink_link_state *state,
 				 uint16_t lpa);
+
+void phylink_replay_link_begin(struct phylink *pl);
+
+void phylink_replay_link_end(struct phylink *pl);
+
 #endif
-- 
2.34.1


