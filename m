Return-Path: <netdev+bounces-241846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EFBC89536
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E9703589D4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4C53090C6;
	Wed, 26 Nov 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IehudGtK"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EECD29994B;
	Wed, 26 Nov 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153241; cv=fail; b=q1Y/6ZL8YBL9FVBxqh6+kiRvt9fkZTiP9rv9D3v/qP+HXvtytZWCWBAbP4xqU9+M0rndmeC+fRdR3J6BVMcIYRYZCTAnkeLerl0adX/vsD8c1hzUxFEwwJVI9A81HKCo3mlICl6ynG8l1X4iaERpvsBaAU2sl6h429ahAoJixF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153241; c=relaxed/simple;
	bh=fIYDJE3Ficslts2iKACAs3SeoS8Bge0DmRWQw9WU2jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cl/Dzz1EfVgzPdW491tn+qkmQfA8mT0CH343b9liO40Uo0M0XSc+TCo7nZ7Wh2SrkT24n1rcafAI+DjFwgdZO+8y4k9cDKIer068XQ6T6XW0nAM8URAoQaDM3dwyuxnYTQjuPlSFL+FEDMo7MFDV5Ld2PYe1Uj9jD2UE75yJUM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IehudGtK; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfHMNMAZHiDuhFxjatl6IhGkksSgB2yMD88UYbRVQ6AWfehzUvBqM9HgT8Ol0QeZKOK95n3UPYjDbEMM4pc4Kap6kZgp3SfBbD+R0Dy8DKHvQ5wSPja+Uma9FhjnIJ4qXuT5ypI5WueDNvWy/zDDZ8vTbPwMLzagWI7uGM2/AatN4UD35F/n4znnKMANHvVcyB/FXiXIQ028418W37icEJokdv6FSaIkQl82HTcZZXykepz1OvH3x2ILz/tzE6QZG93ZZOZcpJSH0pWw3ZwjXHdKVPFrnjsjA1yMu9XgqTAulp2kLdTaSv/dzcnZueZnexSxfI52AZ5yNpOPQQMhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjhKJWIbCge66uLinH9tRqx7+xXROWBjd+EkbNsuId8=;
 b=mIlKzd+K0iv+bPNAkKuAfL4TLPmgEnxwWP+Zy6eVcpf42lYY5TfjqQ1QjvK5kgmYe535Ssjtet/rj0jjCVtbbhVeR16nwYKatp5LTUoTT9jKV//fR9C7F6Bwe7+Ow0Z7OUF2EIFtwREUqiXuejc/Gv2opr7ODsz65L2X3W4Kvd5TEsqpgFnBTMXVM1oNCvcneFQSvIYyY1gUXWlN14QHZxw8qbJMTkC/SNPTW2PeBvcbuxEeoHYusT1DUQDSI1VjbcGb79p63uQ8Rz10rjuMeMIbZ4bOM0OVLZZ4bgJ5QLLC/hN9FwJIqgwLxqvZYKr9TgBrxIq13pW/ZaCMn/NfrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjhKJWIbCge66uLinH9tRqx7+xXROWBjd+EkbNsuId8=;
 b=IehudGtK2dDLvUmZ6Q/9Q+gSep90edvqFA/rQu3a7RbiLs9x4SMfqjuWyp4uV6GU5FewOpGJBTy2g5G7GmgU4sfW9oqQHFmbU4bmQ1iDRwQLCOTlefEisnOwL5c3Ccsmrn0zVyl+5XQWJK5DWTG6j+2hO9R9nPLfXZSYgJ+MdJiyyvwwCBTqp4QI+jo8CqfELrDe4TaJklT2aV8ZCq/nRLgcUA1r5+1Zi8WRkJnsY3OejFUaBxBd3I9AoY9rL4tGjhleGgIEHwD4e6BvpQggZ+azj5nm8k+PPPjxojA3ohf0PB3OBcijCJnZGelJXTBk87iHSGv1832GkhzZxLjACw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU4PR04MB11411.eurprd04.prod.outlook.com (2603:10a6:10:5ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 10:33:54 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 10:33:54 +0000
Date: Wed, 26 Nov 2025 12:33:50 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVo4oia4oirbg==?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Message-ID: <20251126103350.el6mzde47sg5v6od@skbuf>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
 <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
 <20251125214450.qeljlyt3d27zclfr@skbuf>
 <b4597333-e485-426d-975e-3082895e09f6@lunn.ch>
 <20251126072638.wqwbhhab3afxvm7x@skbuf>
 <AM0PR06MB10396D06E6F06F6B8AB3CFCBEF7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR06MB10396D06E6F06F6B8AB3CFCBEF7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
X-ClientProxiedBy: VI1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::36) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU4PR04MB11411:EE_
X-MS-Office365-Filtering-Correlation-Id: 913ca29d-5e04-484d-c29e-08de2cd74c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UDeTW0V/e6tdtfDWp+FpdAHdoTwqV2zQFOYvUtyDVzMkaEnr/DicSG2QyPZ2?=
 =?us-ascii?Q?D5SdEP54n9yIAUnloBNKormtznJfH5ubo//j3oM9xVjck1aDoS5WP79nCh39?=
 =?us-ascii?Q?hjF5yta8tf/D3fdSZKC9IncMiVLr00MmmUVOo4V5ZXf/3IGfeQ2WXOgF5sf3?=
 =?us-ascii?Q?vZtsMXdjFe/hA7PfXRfUEyd/5ltRafsfTRLPlfzCvme9epgfZ7zYUa0spOeQ?=
 =?us-ascii?Q?3jErhoqwYI14KQ+vFcuxwNJFR5sq+UmhfvglvFbtMNpeAeBSRCXQXvrW2cXV?=
 =?us-ascii?Q?kfxJqetOo4LKLV5CumQyv4p/gYd0WaMFKf/wNirdUJrzJUPYXgDzkGg5eusp?=
 =?us-ascii?Q?bQlciHqZyCITGtZgIZRjPCVFJkRP5R7KDboBTuO2Qrjv2W33B7E8NsZNmAlo?=
 =?us-ascii?Q?gp1pgfh7oPn+GfJvskLVc7QyN7PSnPp1XmUovI2jdshpB9a7dRbicQio61iT?=
 =?us-ascii?Q?CIwHU543KBsmi0mB0lmP4uLganyepB916QusUwlsMFPslajchp4esoVowkQ1?=
 =?us-ascii?Q?xh10KIUygUTuHPRwWxsrjv2//kQ3+z+Brzhjv7DJaRpM7zQRhFGsOnKUZQ60?=
 =?us-ascii?Q?ooxONuvMKsE1gwLApoOOIlMVB5Bmde064pjSnzThobSF9wqh4Z5GsjDEGXoH?=
 =?us-ascii?Q?S/7fEWxvC/EiA78iJlaGbGTK15F1Ets6mL/YQ8d5uwahfC6vTwHjelsTanwp?=
 =?us-ascii?Q?eqIF12WpmisaFpzjp2af5KDk2Np6SIDF74iU9yYCeJsepVDn6ecDyoz117fc?=
 =?us-ascii?Q?VVhSQONDqIbFx15J/RH3xiN9KLHDPyTlErCXDcvExJmNYpvrVLeRvLI5htqm?=
 =?us-ascii?Q?0mSguvoow8bQl7Xhbj+emMVHKxlDt0GNZhXkQ1YeRa5hskioUro2wliyTxTG?=
 =?us-ascii?Q?IwpJOa187++OTFM8/Y4fM8j1p/GVbpgEXEQH9/1bPWLNJFYAdoMoMiG9DzTU?=
 =?us-ascii?Q?2sh/Y4PvEjVMSFVyYNhujXKFW6PszcoKsyvZvHlm1CJZ2ndnJOq7d/J+F9bP?=
 =?us-ascii?Q?ZJwZATmqunC3rTMZZ9lmS5JuXaLXhzng0irHnEwXz/0OWytgfkyCjiu8dVdG?=
 =?us-ascii?Q?/8+yX8fLGhub4b87klREA6XhNmkpMbV5KvFvMXoD2FkSKk2Pt8q9fJl1U+2V?=
 =?us-ascii?Q?cXKu5PJKuIMH6uF7P1DOVqkrV7TkCRAVlZPMqZWz289CyJowYI5fwHuuNFaF?=
 =?us-ascii?Q?huuTbHT/FtRi0/yrk6cIXVgI3wf2Pgg5I1/58FY65eq5hu3DTeIFld38LAEA?=
 =?us-ascii?Q?t/QnOqIUu1iph1t4A3GR8s32y5QatY69gXT/7LAVtGD7OkVs2IDTn4Pz8qsb?=
 =?us-ascii?Q?eNXRBteSv1ui+rahwyOVvctaa5D9vOI4Zr32DWdI1wb2a+O24u8FbT8j49Nb?=
 =?us-ascii?Q?Fi4RnGbmlg8R7aSvAzn5VZzhtZRUqAilEc7l6NpXMlZBVlDqG+0egU2HRdsF?=
 =?us-ascii?Q?560Xew7ZyX5Ij/u+UCEjZZ+3zqhUxs3i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ksI1yYoVjTMxcpEe6lhR2ifKOvDykTEssCLI2YIUsf5qU+3lPegJKR1fvR/P?=
 =?us-ascii?Q?A9PfeehwV/4WxPog+MoEML4Y3M9kswvkW7iEEmJ76HB1xSdAEfNhrzTn341g?=
 =?us-ascii?Q?EXUjLBv4Y/eNSFxai7rTQpqG4tTgC1LUNzV/O8GtTLS81kV26B03WnyoPW/7?=
 =?us-ascii?Q?ruGsF5rR5PIpA8hQAwBMBHFF4RSlKuv84u81W8mdCdxr/RwRM2m63+XwkwDF?=
 =?us-ascii?Q?psw27lTXPrehepntkSBWQyuo2oFsjGQnNKufQU4snTTLw5PcL4VSKSmDP1dL?=
 =?us-ascii?Q?B7EtPWGAnlwaJiR2tIcss7MK94HYI6VzJsD3trFxuC+F+gyGsAuQ5EnIP2JK?=
 =?us-ascii?Q?7+i9fs1KvApg/rrHszGdJNaUxjtboCQMcuy8IYxmoSflV1auPIHaNKaL/CBE?=
 =?us-ascii?Q?9hwDB+GAY0q9j73wYYR9X/1434BhN6dXvrw2CPvnlzAWhcaZrORNzoZNTWHl?=
 =?us-ascii?Q?STsNzIP0g3XWFEVo5/no9S4jkfOc73odmvHxTDM/FMu3CemJzUvYHx4Z3kCp?=
 =?us-ascii?Q?vBJYw9UzgM4RRgwNL57Mh3FZsYMtlpWWmoJvByZFEM83uxEEsmw4Cit5yvRN?=
 =?us-ascii?Q?TPAegVY4TUCIRdGJO8V1OjHNEkC0PzmKTq6/5X8ufLau+K1ywZrlPa1bYnO8?=
 =?us-ascii?Q?/EWfxKpkNia6gUXsnn2c/43s37YYmS8IBb6RDg+kc6sXDPtTwveuWnrwegTM?=
 =?us-ascii?Q?fgrzyT//N7BRehpd5B+h/pD/N+x9Bh1h8byRfqS/Io4tGsPA/aXyeiOX/gFF?=
 =?us-ascii?Q?3YS6sTwD/N6WisK91cgmBi0Cb5QMbrNoaetnqHpwyKLVb0hb6dHkIO3Tw4SO?=
 =?us-ascii?Q?kDKDznjeXRv+3qfcpcBV6LQReBcT1JO4TyLcDwrSIxw1lE46BMEI0b9egT5f?=
 =?us-ascii?Q?C6L30tZcBLmUo3ygaNwrrOsyiseMkNFVtvtDCP/zE2CSpns8j4TpcQyTzpmU?=
 =?us-ascii?Q?tIOlMmNWgI5XUQU/8JCBEb4EUmM50U7g7Q1EO+Z2Nscs6egxjikclKZHW+3l?=
 =?us-ascii?Q?WKqExMTSjABjpPiEKgNlHdRvlVbDnNCvudJq0wosO9h2rN7prCmOnpzlJ1pv?=
 =?us-ascii?Q?6XRzdcA2uhZdBAwJghlWbGisj/g2aUsSw6mD2uVaOkuPtbb/svCYp9PHWphO?=
 =?us-ascii?Q?m4BZIvpEWvy1YMpucYfcKdWYhiwS2sja7yEwAkpygMCddO1Yto8fDcSmgw+u?=
 =?us-ascii?Q?b2ZXvdORcuLTLNOQZnbE0ONZleUOytDHPv6eZv21XU/HOpcTyCPMz/AAWhPR?=
 =?us-ascii?Q?kwSf3qp4NDejdE9BiNhSVomc6o/gzZoTsw7RPvuKHhiNQ5Q1Y46A5XbWZY61?=
 =?us-ascii?Q?82cVgp/7lgfzwLpzZgnkZEXgz7P8RAdwO51Q5SZlujYG4ODr7a/uZ3RyKP27?=
 =?us-ascii?Q?geLBWaIKLHaENwaJpWlF8ubEKKJF6uEWipPxUq8rZYz8yJCJ7XFhhUMjs4j9?=
 =?us-ascii?Q?v0IGgLnzzCap7zMtMe7Ordd1JMg3egHpkpyjZRKTfphK3hMfSrmDoP7sMV+x?=
 =?us-ascii?Q?Vwvt+w8j5CMTZpNaVBZY5qcel1lVqcs10EtqqHgZqy4wnTuRBO1cimZz9KrN?=
 =?us-ascii?Q?6slkyU54IBaclNHGbU5gCD2c2fqokP0z3zM0+lPEwdn+ZvZ3T2eIoeCuYEUd?=
 =?us-ascii?Q?SxpDzbzukA1AMNHuzWP1rSFvghrJI1T1NiN4xDH9awpct3SInn9WI/9lnTkC?=
 =?us-ascii?Q?o0ufKQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913ca29d-5e04-484d-c29e-08de2cd74c4a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:33:54.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8Q23+LwBUJb3e5Tlpx6I0Ycy78HPwlOH0J5dVwlymxdPsWn0q846Ku21+FEhAiDmmylcF3XqC9i9GkQWo7/Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11411

Hi Holger,

On Wed, Nov 26, 2025 at 09:32:30AM +0000, Holger Brunck wrote:
> Hi Vladimir,
>  
> > On Tue, Nov 25, 2025 at 11:33:09PM +0100, Andrew Lunn wrote:
> > > > Yeah, although as things currently stand, I'd say that is the lesser
> > > > of problems. The only user (mv88e6xxx) does something strange: it
> > > > says it wants to configure the TX amplitude of SerDes ports, but
> > > > instead follows the phy-handle and applies the amplitude specified in that
> > node.
> > > >
> > > > I tried to mentally follow how things would work in 2 cases:
> > > > 1. PHY referenced by phy-handle is internal, then by definition it's not
> > > >    a SerDes port.
> > > > 2. PHY referenced by phy-handle is external, then the mv88e6xxx driver
> > > >    looks at what is essentially a device tree description of the PHY's
> > > >    TX, and applies that as a mirror image to the local SerDes' TX.
> > > >
> > > > I think the logic is used in mv88e6xxx through case #2, i.e. we
> > > > externalize the mv88e6xxx SerDes electrical properties to an
> > > > unrelated OF node, the connected Ethernet PHY.
> > >
> > > My understanding of the code is the same, #2. Although i would
> > > probably not say it is an unrelated node. I expect the PHY is on the
> > > other end of the SERDES link which is having the TX amplitudes set.
> > > This clearly will not work if there is an SFP cage on the other end,
> > > but it does for an SGMII PHY.
> > 
> > It is unrelated in the sense that the SGMII PHY is a different kernel object, and
> > the mv88e6xxx is polluting its OF node with properties which it then interprets as
> > its own, when the PHY driver may have wanted to configure its SGMII TX
> > amplitude too, via those same generic properties.
> > 
> > > I guess this code is from before the time Russell converted the
> > > mv88e6xxx SERDES code into PCS drivers. The register being set is
> > > within the PCS register set.  The mv88e6xxx also does not make use of
> > > generic phys to represent the SERDES part of the PCS. So there is no
> > > phys phandle to follow since there is no phy.
> > 
> > In my view, the phy-common-props.yaml are supposed to be applicable to
> > either:
> > (1) a network PHY with SerDes host-side connection (I suppose the media
> >     side electrical properties would be covered by Maxime's phy_port
> >     work - Maxime, please confirm).
> > (2) a phylink_pcs with SerDes registers within the same register set
> > (3) a generic PHY
> > 
> > My patch 8/9 (net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and
> > "airoha,pnswap-tx") is an example of case (1) for polarities. Also, for example,
> > at least Aquantia Gen3 PHYs (AQR111, AQR112) have a (not very well
> > documented) "SerDes Lane 0 Amplitude" field in the PHY XS Receive (XAUI TX)
> > Reserved Vendor Provisioning 4 register (address 4.E413).
> > 
> > My patch 7/9 (net: pcs: xpcs: allow lane polarity inversion) is an example of case
> > (2).
> > 
> > I haven't submitted an example of case (3) yet, but the Lynx PCS and Lynx SerDes
> > would fall into that category. The PCS would be free of describing electrical
> > properties, and those would go to the generic PHY (SerDes).
> > 
> > All I'm trying to say is that we're missing an OF node to describe mv88e6xxx PCS
> > electrical properties, because otherwise, it collides with case (1). My note
> > regarding "phys" was just a guess that the "phy-handle"
> > may have been mistaken for the port's SerDes PHY. Although there is a chance
> > Holger knew what he was doing. In any case, I think we need to sort this one
> > way or another, leaving the phy-handle logic a discouraged fallback path.
> > 
> 
> I was checking our use case, and it is a bit special. We have the port in question
> directly connected to a FPGA which has also have a SerDes interface. We are then
> configuring a fixed link to the FPGA without a phy in between so there is also no
> phy handle in our case. But in general, the board in question is now in maintenance
> and there will be no kernel update anymore in the future. Therefore, it is fine with
> me if you remove or rework the code in question completely. Hope that helps.
> 
> Best regards
> Holger

Thanks for the response. So given this clarification, how was commit
926eae604403 ("dsa: mv88e6xxx: make serdes SGMII/Fiber tx amplitude
configurable") useful for you?

