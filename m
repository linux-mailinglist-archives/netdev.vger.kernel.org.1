Return-Path: <netdev+bounces-151386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC54F9EE8A1
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E950C164B24
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB2213E92;
	Thu, 12 Dec 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MN9Dhvh8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554A56F307;
	Thu, 12 Dec 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013274; cv=fail; b=FMlPXOjDphHArP3MAvtvsSCJN2i1sMqVUn3ytEMIyA3jaCIyQ9pnzDu4tKWoCFgWGLbV0xMZJMmZEpN9SS2BvPp8or7ezyXteoY92w6+FaRQ2fs3jPavNLJdk43aj5w/6W6BD32YlqMSW8hgOHFnp6LHQL5UTf+89vrk43wCxHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013274; c=relaxed/simple;
	bh=TIbaepgernv5YmUh6N/9lpUyKmKuJ3eItzy8PaXh2RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LzRjtscyMI12CQqtKzzCSX42vYM9zhjMLrYQb1HUqObpQSUFPOT9YEn7tLxIrudyYOZW/S3eqL4JLHhO2hcpexCvQ8JA08EMILhiYpGrQ8jBrXAFEUQgJYmQkg3iJVV2bvGhkpcdOueUiAIHNiwsXOolPIf7jH/tO3tauNmMokc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MN9Dhvh8; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Va/L8Alxcz64/UURMA+U0/rrplzg2hdInspzmzVuilnKxqsLmE8ejVfwZ73qR69ThTkohqYyikbd8DeBRDZX3/DlWg5j3gPOPnkzDOOa7Q7CMVfbDcMRVBSgz7qmSGahGTamz1lybLd4FjuUEU1lAkogiGpvj7Xunz8fFD6pdszn/1I85NaWDqDqEPUKeYedgDWwJT8WoevzmyU8Hd9wBNO89yn/Ehi1XY2gvDViJUmUbDjzpy79s8BuRIVXv7WgXVGCfxOQ2QT06IHxmdm8QLOxf4uvpE0jNc7xAR67kCE/CUsLSvkmvf9BvFSdHJT5E0OfQ/Kc+RsoZpi5g5YGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4qUBlU9Wmz++7loMHijJqpErcoMQwm9rr8xBc71JyE=;
 b=w3iPSQyEY2d0H/52Fq6+RsB0z6rw8PhGGXhSlZ3myEEGparyRrgMLPV7+eS0Y2KcsqqxTxfnOkobHmlEKMErKtIXvC7aw4TFDX8TiXBDJzSkiBghZhQqrj1262cyjP8pqhqVjOqOTNVnY+3W+vXC2UWERhltUWwopHnTeawwqbTYJgPA07Kz1LX/RtenF8nYF+sM4wxeYjkKTurAO4wXdXDBQvmF/s0NXTcBr0Gr8VJ1csim5A4Dn9Z6TiINipK44/UxEVCjKIss2Dob1j8TyEO76iGEDa5+IwWPv9eI98UcqX+5xuKcUUXH0BhxqCIC4eAurjPvKdOQxgHiQwVpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4qUBlU9Wmz++7loMHijJqpErcoMQwm9rr8xBc71JyE=;
 b=MN9Dhvh80WWtqK77ovhl9kKiQ0/I/YLmfcOvKbKY5mjS0zkkFmzJGKgL92XkNE4keXOqC+VXl0Aez+dP+VNgQMsEPjZfJi1/uFgv3B7R1x/inf5G58vjdRezsoqOUsVQxRzoZP9B07A5zjJGAKe4RCkghHRocrOA+7gC82J2Ini+B4mmk6sVY/kRdDq1YiY/gmnQR+JfjHzrACdGTnJJdGOmZ574wl0wH7RSSLUJk2oQdxErsHgUp2O9ff6TzJzZrBt217PGNqg8E+3N6n/xOpMMEDNE0V1Xv4rT8ULJ5qO6POCRzHGr56gehqtuuaIRfe0D/pIeYvg7kxSQPRtelA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10091.eurprd04.prod.outlook.com (2603:10a6:800:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 14:21:09 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 14:21:09 +0000
Date: Thu, 12 Dec 2024 16:21:06 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: dsa: sja1105: let phylink help with
 the replay of link callbacks
Message-ID: <20241212142106.jrrjg7xr6ud4akpd@skbuf>
References: <20241003140754.1229076-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003140754.1229076-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: BE1P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::12) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10091:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c5a5d2-5ee6-46a9-b31f-08dd1ab83939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HBpFHcWznMTNfApvibVMCqXc33KZPsSbJ/tGf/mtRdBiUx6UhjgS5TyMMook?=
 =?us-ascii?Q?kEpfzgrsBwwhKtH5C1ZZgggv8B8h6Lm0kvD5UP6iFRp9qQBNOIVxTgJNsahr?=
 =?us-ascii?Q?A2ijDJOBvf8v8u5ccdSUpgQ18wM54j8hv2ZWv8N+lfeiNfIPvtQp7o3STYTo?=
 =?us-ascii?Q?RC85MGj2+5r4h1TDsN6wdKRjEi2e9qTa9DucIHkj0Vd3hgigKOuW/xHMqoP1?=
 =?us-ascii?Q?qVC8VWHBZQcHUN99T7J9aA6PZ1Ewo1HZ8lqN99OMVPtCyKObCX64q+lDOjRT?=
 =?us-ascii?Q?wHKTvA0A1+YE67eYHENpnwVBYnWoo7kfATF1McDo4SWq5BNvuP3R0FO2h3m9?=
 =?us-ascii?Q?ul/512QQgyzqUJCCh4WupXM9sneV2n38bd7PzU8GUO/uPm2LO+v/CCZgaROH?=
 =?us-ascii?Q?Knm0l6opcNL74xnkFnzEAV1FHtlj9OMciivBEvaZ6d57rga9wM8NnXOet+l/?=
 =?us-ascii?Q?bvTDb8amJjfOnGtxvs2gui6ByOM14WFviqZol79jqWeViKiFxN1UyiiCtDeX?=
 =?us-ascii?Q?X2uqJPMQx0B4fYR6KdJ40c4T1f+K7OJ0JrvBVFNfbFxbm+X1vKhkGisBVh08?=
 =?us-ascii?Q?3aNFoP8D19kyxpmmF5LPP/aOFxl2NAKMHWTJEtPKaj7SpjZ+IRWzygaw7ckj?=
 =?us-ascii?Q?vUqR33vmPiAoyZqsMhFpzdxqf925W6fMO7mdWwUikNAv5Ay1zTW5kImjNmN+?=
 =?us-ascii?Q?L6m/REy7VtmclMk7VdosCMZoAS20OBnTrnttTNnEsafmOBtDJiRQzZlWE1Wo?=
 =?us-ascii?Q?JZk6vlrpuCpwGcxMAyKf0RxNC+mdlZqI+zCn0VzwY/DbluccUgnVcTldNUcP?=
 =?us-ascii?Q?JoGE8/stWqJ+tdG6/kQ8GGM3lJQN2ASglZiMriSqUO2ixQMqxjchxpvvLF+A?=
 =?us-ascii?Q?mreE5WeCbpj8KviNRNpIYIgI8wW48199W8YmLZQtJwd2l66eWJuCR3FCAS7S?=
 =?us-ascii?Q?2hWfvvV9DmmIUzkY3tlk1G2g08Z9CWfBxG9CzosvEdFZTjpiQbZULAEHZreX?=
 =?us-ascii?Q?j1H+Gf7PbFO0TnojtgLkPDSu8TP7XY5SHeDTtqmMXa9TyimhM0RD6g8KjhlI?=
 =?us-ascii?Q?F7VmSU8rZmyugl1gaKIteJ2uc3IdMUwNHzq9qxNhuQRdqKcENFx4KlwQWJAK?=
 =?us-ascii?Q?FMlrM4lSlmw1vQkCv/CLVwZUW9knof9MUIG+OLYf7lO5xsXQ5Uaua1SwgxcQ?=
 =?us-ascii?Q?N3gK96kNAdubWJPyon7pVZVgm5DSnFOrBINBCyUwj/W0EFhyJCvRFtvsFaVW?=
 =?us-ascii?Q?kbnTqkJUtT8NvwhAgIXfTDZ9nM8ODhMdL2Dr6Me6jv75EU3fIDi+R7+g0VpO?=
 =?us-ascii?Q?vYicYpWW0CZiW26/tWl9IqmSvFSZpULwkFRYNM8IxgKLSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjP8Nj2sNhNXII9N3MStyYNzi62+VX5YLKw02V7Rjnh22ZPzRhlaOx6GMsv4?=
 =?us-ascii?Q?it8Pm6oM8jhTWHJxo6fd66U9qcQlOi85YF+kY99L6Olruav8gEOEYCmisTtk?=
 =?us-ascii?Q?UO4WR5HB0QfKi3nTfPR5XfCH53mON1f2Zxjt2QOF+wARSepCnbuA4BGf7EFP?=
 =?us-ascii?Q?gxgQmVjIB08w9UuNAnyaJ4aaYb3VrxEvosM+XLM4jPgUOLGPbRYUr16zu/RN?=
 =?us-ascii?Q?40wt9YvRzfAVhHBwC39r8OXl5mO1vpN9klsJeOZK5fkNTwFJdnqHf3j0r+Y6?=
 =?us-ascii?Q?Lw78wgF8HKD0TfTjbslPc1i2q24/sCKOqugD3CoU7BZzkMuG/96cHutRIAcJ?=
 =?us-ascii?Q?Gi4ejxrI2kgTzMoEMQOsXZMkIc03xX4r75ouSaLFqEU7zaFWouCyFE10r8Lq?=
 =?us-ascii?Q?21WPGKunZTujlXaW7bGP01F4CPCZhJf/2W/FpaszkwqhQeBItgKexuFgL24S?=
 =?us-ascii?Q?Qn0r8VWV+ZER5K8jotoYLLLK4aOQwY1SE5hYmWHR3whvDTtGbtBpKTmi2+TF?=
 =?us-ascii?Q?YjnXBGL5EA7rEhMmWLW6Q8WZTmC/j1K8pTKoDi2okitd6CDDdNge0FqZYdCf?=
 =?us-ascii?Q?UntRPwjJDVyomYn+86dN6PiQMamC0kKeQYTmT0Z4U70G4VbNd2+7Cz6Jzssh?=
 =?us-ascii?Q?J5ona4/W7kcfmikcl+H+Pl/I6rnF9wOQFxlBukzqlEh9IFqttVlOYhy7ZZEe?=
 =?us-ascii?Q?gZ6OQJoj8HzbehOkb37x04DdzTStFVThLdVPBb36aNC7cn+XaTFVExpCXzb8?=
 =?us-ascii?Q?RRtipDMJMeIfBJrJmgM7ywA/tWUasTB0ndGC9vQe2ZW87JGkoDT8bba2cKcC?=
 =?us-ascii?Q?owe+fyMRlIFUsttyOUbwUF0hkX4xJ6flqKkuU284t4Ede1AcW8CsV4DfQ0eG?=
 =?us-ascii?Q?SDesp1NiUCxk6TuJ7xcbGyckHUE+Z2dRU5SqYvtc0hLknSXTTik1fbTVGG2t?=
 =?us-ascii?Q?ihfFhG7uH7gimaUvp+1LZTc2tEluZow2+OIcL+CsLxGbrKe9fUaKOdHfxpuM?=
 =?us-ascii?Q?Z5R3nz3TEXRbuXewmyNnPTqrJQjfohU4aaAZSJ83FXqDwNEw3ypG1pm90eUL?=
 =?us-ascii?Q?eN1FJA3wLyo3LlJzQpeLF01vIOW8pOWMj04Y8jM57sx7x4b4BZf3ZbWXOg2Z?=
 =?us-ascii?Q?/MRX1LwdiKpPNhK4t5c2N6qsxhhtJjJfU+7VpmstkBShwonQcnUeyuK/IZ4Q?=
 =?us-ascii?Q?Vz53IVNnUgaIbZZpdqGg8tihK+QeOmTMTYbR+D9Jtp1feAQSVV0/faIAdc3q?=
 =?us-ascii?Q?0TzCrzcmMvsDMTYdOLCEoAjZIwCiPP7aEp/+iQzsg1Z4CW9vRiTndm/zGhV3?=
 =?us-ascii?Q?cRtrfPV28fN3UzKJWvO03DB2i/8/IUalNBZETGY2TOvl8fTbo2H9STdWANn2?=
 =?us-ascii?Q?UOcjYCwHrg7qUQZsr1LloAlN10p3xUNwjVv/vFwnvQW0XZuPGWVhtkj5R4J6?=
 =?us-ascii?Q?Wwnncm3ek/HMjATdYIqNSgBkboq/zw277sojFAdxpzYaYJpvPYI60skzDm59?=
 =?us-ascii?Q?oxLVMBzi9epVbsz8RV3CebdH1k0K4VXNAoznuGFElaxXJqRXC4954yPaNSAC?=
 =?us-ascii?Q?6+yRoph4iu3A/wmDI28k+sldGvm5GGhCLdkyHKLuiQEjZxXw9K5RmtpIX8WH?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c5a5d2-5ee6-46a9-b31f-08dd1ab83939
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:21:09.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAoHxyZ7QAi4h8oUsEV3SLiBEGxbaBRSxKB1D7w52JCIPRKW0VLBhp9UpfyiCmqU4i5+2uzQ8jIkhH/kRKngiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10091

On Thu, Oct 03, 2024 at 05:07:53PM +0300, Vladimir Oltean wrote:
> sja1105_static_config_reload() changes major settings in the switch and
> it requires a reset. A use case is to change things like Qdiscs (but see
> sja1105_reset_reasons[] for full list) while PTP synchronization is
> running, and the servo loop must not exit the locked state (s2).
> Therefore, stopping and restarting the phylink instances of all ports is
> not desirable, because that also stops the phylib state machine, and
> retriggers a seconds-long auto-negotiation process that breaks PTP.
> Thus, saving and restoring the link management settings is handled
> privately by the driver.
> 
> The method got progressively more complex as SGMII support got added,
> because this is handled through the xpcs phylink_pcs component, to which
> we don't have unfettered access. Nonetheless, the switch reset line is
> hardwired to also reset the XPCS, creating a situation where it loses
> state and needs to be reprogrammed at a moment in time outside phylink's
> control.
> 
> Although commits 907476c66d73 ("net: dsa: sja1105: call PCS
> config/link_up via pcs_ops structure") and 41bf58314b17 ("net: dsa:
> sja1105: use phylink_pcs internally") made the sja1105 <-> xpcs
> interaction slightly prettier, we still depend heavily on the PCS being
> "XPCS-like", because to back up its settings, we read the MII_BMCR
> register, through a mdiobus_c45_read() operation, breaking all layering
> separation.
> 
> But the phylink instance already has all that state, and more. It's just
> that it's private. In this proposal, phylink offers 2 helpers for
> walking the MAC and PCS drivers again through the callbacks required
> during a destructive reset operation: mac_link_down() -> pcs_link_down()
> -> mac_config() -> pcs_config() -> mac_link_up() -> pcs_link_up().
> 
> This creates the unique opportunity to simplify away even more code than
> just the xpcs handling from sja1105_static_config_reload().
> The sja1105_set_port_config() method is also invoked from
> sja1105_mac_link_up(). And since that is now called directly by
> phylink.. we can just remove it from sja1105_static_config_reload().
> This makes it possible to re-merge sja1105_set_port_speed() and
> sja1105_set_port_config() in a later change.
> 
> Note that my only setups with sja1105 where the xpcs is used is with the
> xpcs on the CPU-facing port (fixed-link). Thus, I cannot test xpcs + PHY.
> But the replay procedure walks through all ports, and I did test a
> regular RGMII user port + a PHY.
> 
> ptp4l[54.552]: master offset          5 s2 freq    -931 path delay       764
> ptp4l[55.551]: master offset         22 s2 freq    -913 path delay       764
> ptp4l[56.551]: master offset         13 s2 freq    -915 path delay       765
> ptp4l[57.552]: master offset          5 s2 freq    -919 path delay       765
> ptp4l[58.553]: master offset         13 s2 freq    -910 path delay       765
> ptp4l[59.553]: master offset         13 s2 freq    -906 path delay       765
> ptp4l[60.553]: master offset          6 s2 freq    -909 path delay       765
> ptp4l[61.553]: master offset          6 s2 freq    -907 path delay       765
> ptp4l[62.553]: master offset          6 s2 freq    -906 path delay       765
> ptp4l[63.553]: master offset         14 s2 freq    -896 path delay       765
> $ ip link set br0 type bridge vlan_filtering 1
> [   63.983283] sja1105 spi2.0 sw0p0: Link is Down
> [   63.991913] sja1105 spi2.0: Link is Down
> [   64.009784] sja1105 spi2.0: Reset switch and programmed static config. Reason: VLAN filtering
> [   64.020217] sja1105 spi2.0 sw0p0: Link is Up - 1Gbps/Full - flow control off
> [   64.030683] sja1105 spi2.0: Link is Up - 1Gbps/Full - flow control off
> ptp4l[64.554]: master offset       7397 s2 freq   +6491 path delay       765
> ptp4l[65.554]: master offset         38 s2 freq   +1352 path delay       765
> ptp4l[66.554]: master offset      -2225 s2 freq    -900 path delay       764
> ptp4l[67.555]: master offset      -2226 s2 freq   -1569 path delay       765
> ptp4l[68.555]: master offset      -1553 s2 freq   -1563 path delay       765
> ptp4l[69.555]: master offset       -865 s2 freq   -1341 path delay       765
> ptp4l[70.555]: master offset       -401 s2 freq   -1137 path delay       765
> ptp4l[71.556]: master offset       -145 s2 freq   -1001 path delay       765
> ptp4l[72.558]: master offset        -26 s2 freq    -926 path delay       765
> ptp4l[73.557]: master offset         30 s2 freq    -877 path delay       765
> ptp4l[74.557]: master offset         47 s2 freq    -851 path delay       765
> ptp4l[75.557]: master offset         29 s2 freq    -855 path delay       765
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> This was not what was discussed in
> https://lore.kernel.org/netdev/E1ssjcz-005Ns9-D5@rmk-PC.armlinux.org.uk/,
> but I will approach that perhaps differently, depending on the feedback here.

I don't want to repost this because I have no updates to it, but could I
get some feedback please?

