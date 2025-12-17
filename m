Return-Path: <netdev+bounces-245241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AA0CC9725
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 20:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC2EB30245F1
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB6B2D0600;
	Wed, 17 Dec 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O2KwuoGP"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013038.outbound.protection.outlook.com [52.101.83.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83974283686;
	Wed, 17 Dec 2025 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001249; cv=fail; b=RgDuf8yguihy5nKA7eIMOPlwwvnkXIIIh06VMDGm90KfSqbJ1qRyGNAPBETsoVBbkkxmiUhgAt5lDC9qT0/XAu6+m/8Gawvkk1ah7VTVg48xfnoNF2okmCSC+yJ7IHgXDBpb3U1GK7o8CpNdnyTt7Tbo9Tk+88TdGEK//YgbNz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001249; c=relaxed/simple;
	bh=LSipYa9bbB1pA/ivUT0X2ASAt3btVkTCtHo02ftVti4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X5YWFUkomhK17WiYxWdW/MVbZ3m1SqEIz+oWuSAGy5p1TrNM+0Ff87OxMxDXvsS7qzVIpVfGtz9SzKYo7yUNHHW1LTCW8CB3/ipk8EeqkzTYcY/jQe2ZqKBkWgbK1EwNgNlG8au/rsVh7syu/8Z+A4mmlx358SDYEHaph//Egbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O2KwuoGP; arc=fail smtp.client-ip=52.101.83.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgskuyzA6esYZRzGSsAKU5aMA7SFtH5UDtE97DtFSjw0g7Geo4/voKSIZKP7AiIrMZvMdB4Ynl8L3Szqspc9IIyQ1Gbpd96jqmC6JinPpvj6DI08pHcE722yhlAbPKmUQHV2P6sAp+VNSy9KqYwWIbN2jqhnVDhOLcC2eKU+gC70Y2H9ZeX1Sx2UwP1RBZN5WBBLQWbuZrxv1l6SVcl8q5czeu5VpGjvGyZR7DdWXgZUd1SRNa2tG7aEcSl4LuNBWMGZYKqfK2d9kkD+LKzh4SLayd033S903otQ0Oz/JfhfxWIkBV4wyPSZV5OGZ05pVswexe2wUtp7v+xJ20GW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBD8zTV/fZZabLsCtTOJeEByxi2eZY1xLjHhJuYgSgk=;
 b=AnPArGPn9sHm6xtD+L3nYJuvBeR+5DaMB5oub1EbnU954EyisyDS3xwb6F9J6XdOMJ30fUnxlfw0hHbLik6dmWgLkE5qSYqPXZ4I9BWcrQUT+V0gi60/sWoQW+4gdMfPP6Po/psEwSsrcjOBf469S2MPDAhzzVD6eqM168aYgcLCLnK1hLpbK57UPx+Ecipm+FJiNM3QHtJH4LJ3kpmpsq69/A3ECsqgsHDwEd4fyojINmUX7b6lEG6b/TXhi1NHaZHoYjAGGK1eNhrF9Wm8ipRoSwMTnqcuauUQGw66YZlPTqyWf/2JeX+U9fQx7ZmI8hcCcNeTJA9WgiiXiuTjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBD8zTV/fZZabLsCtTOJeEByxi2eZY1xLjHhJuYgSgk=;
 b=O2KwuoGPJSIw20Kg2DO88iuTYMg/weBrIEQSLUPRN1lqbdvYXcB9LJFXeXEBro2nHKiI572p1o2qbuUyofZZBO5b9/gnHfd+mRS/CC2tj9geGIeotf98NXIWmEmw2MDKY2oSZv4Mrd8LxP4Ztr2VevyZSIcXwiHWB52O9eywmcCfuePJsDe/iTVfyZ4Hsu6IcDFyZ0mMLSG0Dqp1UWZakW94pIzQCgr16x8SPcwVqtGBlRnaosI3tfI6suqZ5fJup3fLF2W4dIsLK+3z/+TKwIsf6/ryxdCucY3lJuvUEYWRuxGkb+VmRjOs6F/UnjE3Tx1SXFHLY+eNB+CDcozVcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV2PR04MB12018.eurprd04.prod.outlook.com (2603:10a6:150:30d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 19:19:35 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 19:19:34 +0000
Date: Wed, 17 Dec 2025 14:19:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: Re: [PATCH v2 0/4] s32g: Use a syscon for GPR
Message-ID: <aUMCPKicgsoICAJ0@lizhi-Precision-Tower-5810>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
 <aUAvwRmIZBC0W6ql@lizhi-Precision-Tower-5810>
 <aUBUkuLf7NHtLSl1@stanley.mountain>
 <aUBha2/xiZsIF/o5@lizhi-Precision-Tower-5810>
 <aUBrV2_Iv4oTPkC4@stanley.mountain>
 <aUB4pFEwmMBzW52T@lizhi-Precision-Tower-5810>
 <aUEQkuzSZXFs5nqr@stanley.mountain>
 <aUFvvmDUai9QrhZ2@lizhi-Precision-Tower-5810>
 <aUGlMP7J19L_AHF2@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUGlMP7J19L_AHF2@stanley.mountain>
X-ClientProxiedBy: PH7P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::29) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV2PR04MB12018:EE_
X-MS-Office365-Filtering-Correlation-Id: 60255e1d-cbec-4359-3b23-08de3da13642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X1VQzM3FMzown0FPUxKF+plHx73yXdUZ2v3k3ikQOqnW9ER2gj4r7vz14ElT?=
 =?us-ascii?Q?7ffpWuR4kaZXRyp2oT+zg5Pj/rqU2Ys3KaQvlO8i8fL2cXZ/NlVLn8ey4vrG?=
 =?us-ascii?Q?TQHGgHBrqnXQGnbYVzF1LpZP/280cM0xD7+QMocb0hUFeJebECPKYA23Qo9z?=
 =?us-ascii?Q?RVZCgD2+pw/+Wkr+GivVH4oIQ1BypLHeU+8dfNlfcqqpT+RzX4sqJc7dvs1I?=
 =?us-ascii?Q?0ljaRwjJFMilwDNLfAZ/2cJWhXgD744bbvq5FzZRYh4fthBvMDEIx6entm55?=
 =?us-ascii?Q?87T/gYwSDxM1HYW02F2HNcDt1SCtiUMUhrGxZYRyeCmXvv/jrOeVZmlVWKkt?=
 =?us-ascii?Q?p85MDaQujd/LWT/TAu8KOdhHT4xtjNnO0830BsVaz30mFKhzL8kA8ARgqMuV?=
 =?us-ascii?Q?HZxNZEiapwlOU1Vb1CrnNZiocHelE+gU5GRviU4H80T1QdK7K9BmQ1WtmLtJ?=
 =?us-ascii?Q?c1k/A8p8pvF/+yK40BnK+i22fS8ZovMisKLvqOh2YiKneSDF7WLraaxA2xWe?=
 =?us-ascii?Q?Pw7FnZ7MceTs1tKRFyYFGnuP4/ZEfWUnu30qtqq9ubFy+CNWbgPAc6y29wMM?=
 =?us-ascii?Q?CMIyeF3oHtepU3lGAPrRi+v6zVfpzLJwHwfSNglPnC6+JRjqwbvs87Hqpslo?=
 =?us-ascii?Q?547kJy9jABvlaHPhsfSWaMhOGH+5TLb6LK7RD/3/Iyp8+sKZN6bK8qFFbNME?=
 =?us-ascii?Q?aFGUawJ4niR4NaLd0U1Eotpga9Z2xJ6xBabdL8Mavpl4h+rEyKXu7WYX0qvd?=
 =?us-ascii?Q?UVeoYlZkDMpn/H8JiEl2eKi8YgF1vpMD1oJhBm2XsazibRSFvt+hKI4GU0Ny?=
 =?us-ascii?Q?eDKb3bryIoOWHfymXDc34fBCUZmESwoLoC42YowSaZl7s+PhBXsKlXdoQVCl?=
 =?us-ascii?Q?I57yqn/q06qc4PkOu1H+/tsjulqwbNhHeb94fp5XwPEn2Z6YVoV5f8r73+nt?=
 =?us-ascii?Q?cMBTX1QtGWiy2Z4Swhj2vJEb5yFkJILxFO2i0F+v7voLMbmzg8KwDtHXAA0W?=
 =?us-ascii?Q?15axpRLGFB6tE7x1LMPQLQ4G453emLMRGCP+jBk0EqTxwpajxc17xrgSxUYe?=
 =?us-ascii?Q?h4GCR8IJVD2cDyA0MBmPK1nEwQoJn6NNATf6GhIyOK/+7JiG+dZRT7DbwMOD?=
 =?us-ascii?Q?8Ixv8on7BPkrAC5V07/YA+XbWqF5xcPju81pLA7txhRGXVDuQ3HHz+k45YFV?=
 =?us-ascii?Q?+4NaCYpqvykioRAhZ7oQdmGEoFGX+TuDZx9L7y0GTvhwdICb5oAn4TqZeJLI?=
 =?us-ascii?Q?JnQSlncTYhAt+1gg/MJMA4suNbtZcJnuRrjPC1DV8YPf1BB854ge8fQyGudr?=
 =?us-ascii?Q?5NSgruyRcfsLtNryW/fqBYqmrG0h404DcHjcgCvtICETqmABIPWdBdMr+Sz0?=
 =?us-ascii?Q?o2liulkW3vgFtTJtuEC0G9wQzV4TYa+r4PNg4jFQFEoTF98PfZP9xQZkrRYy?=
 =?us-ascii?Q?BSWG0Y+rPDOvqGr1Q5PJ1pL22qa+8ijkfuUVoJK3WggvLCiWSlKWpbpk6jo3?=
 =?us-ascii?Q?gcJV7DB8fjjZwzB9SJw9dMKuXl8N4EmM6PZH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RHhU13zj3m8TXpjT/GXXwx9+Kv3NNnVfxdx01gi07AV1hneb+BPj+KwXqaua?=
 =?us-ascii?Q?dyfc5ldgOLw+HTHPEdxZUOBBisdOfsEpuZwSzljqY8tUBoN6cbgA6pCt+5LV?=
 =?us-ascii?Q?lZw3sSAcs7IFVFwCqufHA8IvYfDa4vMuWYmfV0Ums9IzcLhAj045p0KPHhKj?=
 =?us-ascii?Q?qfcYke6p1ZMUDF1Olybh9YHh8+IgX0ase/j+i1thcyqHfljy9srs7/+4cjTn?=
 =?us-ascii?Q?SI7uUMPFhP33k58wj/HuqCHQQ1pVmQaJxTF7j5D9F30zgnXdYKHG2gcJhM3C?=
 =?us-ascii?Q?Cbfxrkhk+Z4ayxFXG+t0JGvnhFeoOc6818F56aSjYIw4LPDCD1Zsg4pQKXeY?=
 =?us-ascii?Q?WivKYeAB/W6BcP2ENT4k2VJU4HNlWZ3GBXNVEnjSgSmwFqStGpgSPTbxDmNd?=
 =?us-ascii?Q?upKe2eL96BpeQPps9U1CqnVNovz+f3nnt3C/cP5nv+8cU7apT4NL5+zekQp8?=
 =?us-ascii?Q?xFdGyM35V18ciZzSwsxOM/3G0T0SNrajxi4zw3DsFG2QQjD+ROrYXIH+2NAk?=
 =?us-ascii?Q?oQOwGLo/sI0RlSqt47p+q4DaMR8eSoEQX4YNe619GCK34kff8G79FeukOn1k?=
 =?us-ascii?Q?eGPl+8NZb5KKQvkNQ2PRg2EgcNITcQb7510clXu6tgtANPQuF8GUNxPeXFKM?=
 =?us-ascii?Q?yxSICmA+SV9uifuNpSNSbA/h6Zy7a26MNU0XXVY+U9WLUsYuHSB7yDRn+++E?=
 =?us-ascii?Q?GeLWDEUjeRO24Wi7Ik3tCoo9W3t4UZHXNP4W70gjAyn/QKecqSy3YfW/xw3Y?=
 =?us-ascii?Q?QkGJqS+lBXc1/+YuScA1hu/shejqOTQgWiRoz//bzYlQdnvSbaaDNahCnEqQ?=
 =?us-ascii?Q?VqdK/y+sXW0lkbYq4PEROPzDwJfsSNQxlOsB6h8w0Zn9C8EzZ6dtbnfYT+FE?=
 =?us-ascii?Q?/uiuDj6PovMTqcABNuXhH2brdC94bIpA9LSGpBa4A9myaiRqoR5x8h8QQ7Km?=
 =?us-ascii?Q?UyHZ1N4oKezLcRFUDaOxij+2mZg1u8iJy8CuFLTmj+juJqTdTEQW5K7cdQlN?=
 =?us-ascii?Q?7Zaa+DFIaWIcJBPPxhZ5s7Mn4qdXuLuQ9D7biTCkxIMAueI9yqw2VoWzxGZe?=
 =?us-ascii?Q?MpwR3wzdN7fEviinuja17Ox1PpR/bXYSbsKGNXy+ZY7SCuVvSPGzgBs4X2T8?=
 =?us-ascii?Q?rHrF369GDuMohCnAfCKjnDcghueCXjFb/GX77mRuNpVDYl4l1ghrJv7yndr3?=
 =?us-ascii?Q?D4wJN36cIkS+EQPzlLM0tOWQwjOXf7bFTVezc9u0l5K5SpkuZWEq0w5YamaI?=
 =?us-ascii?Q?NqgQ2r2zDPnziDEIQPxOF/HLBxOf1P6O4HheLmmw5dAUY5bDclNlWrruqhxn?=
 =?us-ascii?Q?xmk64Y5V3wH5g2/6lnGpV25A4Xe7YFHiuIsHRqptyOKg/OpIIU5XtuG35VSL?=
 =?us-ascii?Q?3f9hytb5lO7g4P3DAqGv528/hc1xt+v5DPYFYXOUjJee7kzXjAtVIrqYNXP+?=
 =?us-ascii?Q?m5qnHDDtivYHbh3JN6aiWjx1+oZbYXkEJAYLXKbtu1ullUL+KAi7qH+g3dKa?=
 =?us-ascii?Q?IcduodVZg19l1RFgndKbs7ZEEZ23tfmiIivO9tcCT61E9teKoanTj2YVXXNH?=
 =?us-ascii?Q?NFlE+TeOce0Yxf59OMc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60255e1d-cbec-4359-3b23-08de3da13642
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 19:19:34.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: az4Jt3w73zZI+thgOwY3qY1NwF9KTsUvvFhvoB48WJBx45vc0FykbO0tZfP4ZtpqJEg+xpSVj3tZfc2BjF17Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12018

On Tue, Dec 16, 2025 at 09:30:08PM +0300, Dan Carpenter wrote:
> On Tue, Dec 16, 2025 at 09:42:06AM -0500, Frank Li wrote:
> > > >
> > > > Why not implement standard phy interface,
> > > > phy_set_mode_ext(PHY_MODE_ETHERNET, RGMII);
> > > >
> > > > For example:  drivers/pci/controller/dwc/pci-imx6.c
> > > >
> > > > In legency platform, it use syscon to set some registers. It becomes mess
> > > > when more platform added.  And it becomes hard to convert because avoid
> > > > break compatibltiy now.
> > > >
> > > > It doesn't become worse since new platforms switched to use standard
> > > > inteface, (phy, reset ...).
> > > >
> > >
> > > This happens below that layer, this is just saying where the registers
> > > are found.  The GMAC_0_CTRL_STS is just one register in the GPR region,
> > > most of the others are unrelated to PHY.
> >
> > The other register should work as other function's providor with mfd.
> >
>
> Syscons are a really standard way to do register accesses.

It is quite like back door. Many clock/reset also use phandle to node to
controller by raw register read/write.

> The
> pci-imx6.c driver you mentioned earlier does it that way...

It is not preferred when we tried to add new one. Give me some time to look
for original threads.

> The only
> thing which my code does differently is I put the offset into the
> phandle, but that's not so unusual and it's arguably a cleaner way
> because now both the base address and offset are in the same file.

It is not big deal about offset. The key is if use phande to direct access
other module's register.

Frank
>
> regards,
> dan carpenter
>

