Return-Path: <netdev+bounces-248482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEA9D09810
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F16930AF546
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7B359F8C;
	Fri,  9 Jan 2026 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kyu9cgw/"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A7328B58;
	Fri,  9 Jan 2026 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960881; cv=fail; b=KgqxbPF9bx5WV8GOIEWHBN35NNSejoXi2D4K1sKA5lbFznOHHoDmzOio91DcIm/Sgi1HMzx1oVgDEv2xyXgcc4cHZZaLfOhyCE0TSy0/uTJBPV9g3xzcO7SzgLLFMwte6UfvDKaJGfPXIetNEOzB2wgrZPRt9P/5qLAYU7X7V/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960881; c=relaxed/simple;
	bh=G6U+CE/tYjwn1JgC594dDqdjLWN95pDwQj7ih1VOrOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bz80CLV7AjGJ1ihWwIsyLTXQE7JtE69URJ/laGOL8QoDQRR5xKnH8pRXzC5qhC1BPd7r3X9srqbe0wAJazqRwxf0hdffx4wc4Z/Qbe1ofnVfnNQUzJ+GqV4sFTAwoKeGY/UQc+IJ3oPdFasABiIKlXk3Sg2S/QdY442w0Fqp6Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kyu9cgw/; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwP+5HaYJc5mbLtwUPUSVwSkEtdDQH5oLywwpKtGDEhnw3d8k++1OloKDYfbLeTMIY4rDc3g/Wdnax5R8s6Zn1TufghwocRh2RCld/xUZa/UIlmPPXGYYxXGnjsj0UjEJSbQnUpCYHM4TX7QdD4Wtrt2wj0zRy3wgKTX28FjgveV1yJXeb/vt+tkjFrsRyQ8RP1OcHclJ/PjBHhetvJBZDXPGxBoQNpL3ogBRorZ7OJ2RMQptCMBMy9s3P1CLx5asBKWXG2X409Kx45BJdhPiQh6e8tu64gX8EwjKrV2SLeR6UTDOOPe759qJ9lkORC5PMujmo1/NM2/haX9f8HONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7z/9ivSsREfSwQHmhTQA/Hd2r3/9eige59IGM/LLV0=;
 b=ZhgSvzR8+w7ZjtIdAWuUhA16ACTa7+qeLnKV6Zm9XpgYzZ+U3LM18fE+A3YEwtXOCE7S2jCEEIDO0lV+LVVFOK3yyjyp2IBSbpRjb0bARZnapYc1XhWvGKHgLwoLa+cC9IqInDbstKeQq2foCtdoSdjUJzQj8HyQKBcQU814oS1XyaPT1Ofq2hL8mV1OnIjGzY9cv6eDvcVeG37+eZYr8V9hFwNKp8eBp616rW/xWt6v4WYyTMVETOReACWvHftUoMKCU6ifmp9k1TCC55Iow3JQCllYhFnaABpDQuVudQAyurq5j2x6Mt1w0ZZl0ZvYHN2iL4ew4i17GBXQkytwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7z/9ivSsREfSwQHmhTQA/Hd2r3/9eige59IGM/LLV0=;
 b=Kyu9cgw/IWtfOcAerZX/ilxvWmJECsRnHSrZ3xQAkBgE0NGmC3sSbat2GbBxKiYa0ltJD77NPd9ng7rpyKVR+51DjodReNEMfIj7VNtcSdjONOUtiwmGsAlZn5rP7cAb4suT0/UcUN+SZvU1N9WEpLmRInN0rdJe/AIbnx/Zocsmj+O7I+77v9OTZy5ERycpRiUQijuvV1ypKOKkoJRQs6LvUmUo+Q+/khZEcQvDegUNoPpwMm6bh41KdAqb0qwazFvTSli/NCxzntTSGvYrNzDckpyk1dmJCaPK+LTYZpNpDP8zBR+OhX9qpxFsS6wluQe2T58XQVFkN2+WKBP3pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB8594.eurprd04.prod.outlook.com (2603:10a6:20b:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 12:14:36 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.002; Fri, 9 Jan 2026
 12:14:36 +0000
Date: Fri, 9 Jan 2026 14:14:32 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20260109121432.lu2o22iijd4i57qq@skbuf>
References: <20251118190530.580267-8-vladimir.oltean@nxp.com>
 <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
 <20251216162447.erl5cuxlj7yd3ktv@skbuf>
 <20260109103105.GE1118061@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109103105.GE1118061@google.com>
X-ClientProxiedBy: VI1PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 16cc23ee-907d-4546-7cfe-08de4f78a771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+hMUNpJWL+uZD4KScDSJUwUripRPH3hmYfjvNKUtGElU639KXAGTFQaR/okk?=
 =?us-ascii?Q?/YLAz7N8mIEP5DdVavsnpHz32qtDMXNF1OFypNTY4BxkXLeSeH4DHftTf5p2?=
 =?us-ascii?Q?T6TcB9MWzIruRe66sSkacvobzM7yYrNlIlRH9RgixI4oznnAPurCAePjh80+?=
 =?us-ascii?Q?Ubrt7B4fsE4QlNWUduLlLD+C5QUCliH4BuW/zigSCqDncPni6CbkxmVg81ZA?=
 =?us-ascii?Q?48EpNNOKop/G8UqUdAuY6VBjfev8abp+UmgqKV8bqq4VtAlpp9tO1K18uhRL?=
 =?us-ascii?Q?ut8YelOip7pmDDg6BoWckEeZ4HcjLsLltA8lIaRWijVUXKW4FtCBr5O1Uxay?=
 =?us-ascii?Q?4Ipc3THa6+BTsmM63uZc0muihCfyBc0TwubSVg1cBRIQ0MsgK9Vcah/oy6jM?=
 =?us-ascii?Q?uAomMdNxSPjOh0Q3e9DrJwPdRYBbq7Af8COkml8dA7GF6JABO1jbuh1wBNQs?=
 =?us-ascii?Q?jxV93ZYeGARivjwYAlFjZyrCnnH0mnK2F5/wdlztumkrOKC9l9qLtvU6ikP3?=
 =?us-ascii?Q?+mBwnyQfVmztaHGhQ+Fiy7LCb3v3EKfJgJeh7XJoVIiUiNPqlGHRtgeo88vM?=
 =?us-ascii?Q?m+H8PlonDrj0eVDNvY/vnCWIu9TCig54dIf3zNzhTWjlFHWHbUBnRmgJY75r?=
 =?us-ascii?Q?PCeumcceByy1CGXdzO4vB9u3bfaApznqNwUCkStYYVMqqn0seXYhd+AOAvxF?=
 =?us-ascii?Q?PMeE446ASiz5EKahcgzUh7+phTdx/djHPxJcNv5htiSWmCVfAMF0A6xg+64z?=
 =?us-ascii?Q?gLJ+hESmhB33Gz0Zl19LiKH3h69ztHVB53ntyrL3hx5VvDI0FVOsD040Z5xc?=
 =?us-ascii?Q?FVHPtKzGB9YLnb6R8ZNegN3yKFLh9YMxvb814sBn7CdIZhDgudcTgw83no8L?=
 =?us-ascii?Q?1d+RGTLxlv+O5b3Y9p4/UhfM64QznndziqIwY4WX4xGRdc3BJmQpVOfgYhtt?=
 =?us-ascii?Q?z+ycjbEitBH72AB/WusqS+hVDUR8K64U6yyDK91/ZEdIK2+kLJgPFCw9sszj?=
 =?us-ascii?Q?tHFD1H7PD+DRQdO3sRck/Wugx+S/Um0n8nG1/wpGFqgE196dgNHmQShLwdrp?=
 =?us-ascii?Q?qbxwYIWEed3KXGVwIjeolIidhTTOVzKkd17JP1Dyx0ajab7rqH2c000IwIVp?=
 =?us-ascii?Q?7GNmlkc47Y6KP0r+TcHib7edkurhY+WO1mUSafONVvbafrLSX/zkDi3mQZQi?=
 =?us-ascii?Q?gGLroMptoHJyidX0/lgMItP8IEwzHPcPz6fBpWGDLKRD6R7RsWiimpl7yV/J?=
 =?us-ascii?Q?GZnY2dJmUegGDxrtnQh8p1oVb/kdWY83wCNFx2sTA4YkEr7I/AtXuUrj/faT?=
 =?us-ascii?Q?lxNFRYtshIx6TVx91EbMP9sPHhGEyAWSUQz17CpOsAl4ibEq/BjIbK+3RZV7?=
 =?us-ascii?Q?vgesXXKwdsG/rWatccW5cTSbk3biGgu3ssC2rIHqrTKTyULqOPSESDAHP3N0?=
 =?us-ascii?Q?NqzPyqWDP6eZO1vRsncwbIUy/Jx0dK+o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nCbQX2+S+CeYV6Pdx08FOEuNpfy3E6WB0qKCejtpxkDCG3oRz4DZ3Gg48bA6?=
 =?us-ascii?Q?5lJtPqOWXj9Dt77jYMcKu7/u2gn/uNmU5PApIBAlPSE/EfN0h86IOb/0dkn0?=
 =?us-ascii?Q?XohWBPnv6/ROLmzDXessVaW9sZ/ELwhycV9w3l+OjcKtHM038N4c7Wjg3Vuw?=
 =?us-ascii?Q?Kpw0NTU3OjHVlNlOj20XQEnGGur3hC5zWZzQTVv9haI24p/47iHemkSp7xYb?=
 =?us-ascii?Q?4VSDzoT5pnvBccXCl3uc/vLlvEHPPZ/XtcmzwyR2noKTzqnZ62mgKlI90fVQ?=
 =?us-ascii?Q?axWXkHZn/pfAItYws49uKvlyp4MJIfMJv0NHm4oUQevz31rxMGgArGl5Bv2j?=
 =?us-ascii?Q?jrMOZdBQyn014TbsOvZF4OHpIQiXLVHht2V6EBMQkeGn/Ho7C9uugUZFslLD?=
 =?us-ascii?Q?Vsyntr8kcKAdtedDvkoFEef44x9sP2PVDIlvuqgjyPVXg0j7j9sNvBfNiBUA?=
 =?us-ascii?Q?82TaPhaeH+cKyIhuUfFOLd2WSJBYS2fFXof4gOfZuKkZ6auRLFgeN22QqAGT?=
 =?us-ascii?Q?OLZ7QoqMXXMlz5Y85XD8N2HuSQiysASOj+6zoYAzc0GR4yyyUSqc8DJP515u?=
 =?us-ascii?Q?4VAk3ltEskzFLmXOwF3R4FaSCNg+YE7e73UZFJk1zViag/F2QYtOi2QuASXv?=
 =?us-ascii?Q?Z9YGbQOZqGf/Pp+NvOnUFIrdPzhHT67EP0tU65tiG4IBX1kJzRi23uCJgS6h?=
 =?us-ascii?Q?BbmtMo7GxNj9M9mNDCqEkDRzn/BOCB9BAxlEGvshk3RcxV5txSDmzab3Ghcd?=
 =?us-ascii?Q?jcqZQ1r9QzZ00+sAklwCThuJ4oNX3I1P/GPxAwqJtKnTwRchzdnWeDh6fePi?=
 =?us-ascii?Q?7H+6SwnjzghB0g84jk7h0LcNZBx20fvqQTklQUecEtCId5BiTRSXw+XHPYpS?=
 =?us-ascii?Q?yyEBof7qJgOxZ09Zhas9YYIRxWcrU2+53OsBjhVSiMxEVSJVK8VKt04YIC3d?=
 =?us-ascii?Q?//E+LS1/wLS/g/QW/uOuSAymTYWi0Elff1sH6CimGQdarmT51pU894gn3+wh?=
 =?us-ascii?Q?5B6PZIEOrnkgeEkKKDUnEVDEqUX83bWR/gTaE++n5FVT5X7i7C84h1kBGYQF?=
 =?us-ascii?Q?9Xot09KQsYogcl2l/nQg1kV/jktYgur4N+YCOgt9MK2asvyBpinGhC29gmCG?=
 =?us-ascii?Q?Z591+ZyWNjihnRvqDB0v1BRfopvexBy95Zagx8C01ddbtCBAO1cOJwIdjv1p?=
 =?us-ascii?Q?iUX089Vsa+YwVF0ZSpIZEBDGHgn73H7dBg0Fbmjw1GJ81/4p5xPdU++UoZyv?=
 =?us-ascii?Q?BbWQ+q1ZH19yDqXp1Ok2or7VwgOvC6bxQMOVfe6i0TI4qaDC586CJlIYS7dz?=
 =?us-ascii?Q?Hb9SGOiQavWHR3vg+b6ELH4sur6P2tt735eDtjFnQoEx3SjZiW53gIghRuIP?=
 =?us-ascii?Q?HopBQmegFMaq8RW5Bgdu8LwkzbQmJOHddOF6pnfjWclHU1DDT5a/4Tccp42j?=
 =?us-ascii?Q?v2iCpFtpiacKq/owHBXDS1fGyCNNZR2uUb0+LV9K7idsi0dCHsL3TguhooFw?=
 =?us-ascii?Q?YQJr9pAMg/9FRc9OwBu1VNGyunCPA0rgCrxr5UF7Z3OUZgycKqFmJoeVSYGF?=
 =?us-ascii?Q?OxJBwBI5epWJkZL/Tl+sGhrX1jnrCuS++cQmfuD4qIlwTvTN/jhJTlrwRLz2?=
 =?us-ascii?Q?EQxFSduwEJfdIDx66k4/Qmmu47ElK28hIH/n1CNC9jH1GYoZd4YJ19f0ou3l?=
 =?us-ascii?Q?Lv3dvvBBxtDMDWDwI/a/gXFg2KO8XfwtcI9ATfZzQ2IPcP0MVQVk5j4wscku?=
 =?us-ascii?Q?oJReNGmzcr4qfynuO9uM7xC0JroviiKjCle7EslUMAdYaYoSng7dj/KzjJeZ?=
X-MS-Exchange-AntiSpam-MessageData-1: fmw6GhtFMqSSPA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cc23ee-907d-4546-7cfe-08de4f78a771
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 12:14:35.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITs65o6UaRgGOwL/Azpd2U/qm4F0/XuYLEpnURHpXktuIKLSEA/hdtZTKrE4b9rM2gUS/yQlmpyUtEvQGNO/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8594

Hi Lee,

Thanks for returning to this conversation.

On Fri, Jan 09, 2026 at 10:31:05AM +0000, Lee Jones wrote:
> On Tue, 16 Dec 2025, Vladimir Oltean wrote:
> 
> > On Tue, Dec 16, 2025 at 09:18:31AM +0000, Lee Jones wrote:
> > > Unless you add/convert more child devices that are outside of net/ and
> > > drivers/net AND move the core MFD usage to drivers/mfd/, then we can't
> > > conclude that [ this device is suitable for MFD ].
> > 
> > To me, the argument that child devices can't all be under drivers/net/
> > is superficial. An mii_bus is very different in purpose from a phylink_pcs
> > and from a net_device, yet all 3 live in drivers/net/.
> 
> Understood.
> 
> > Furthermore, I am looking at schemas such as /devicetree/bindings/mfd/adi,max77541.yaml:
> > "MAX77540 is a Power Management IC with 2 buck regulators."
> > and I don't understand how it possibly passed this criterion. It is one
> > chip with two devices of the same kind, and nothing else.
> 
> The MAX77541 has Regulators and an Analog to Digital Converter.
> 
> 2 makes it Multi and passes criterion.
> 
> The ADC is 'hidden' from DT by MFD.

Yes, but MAX77540 doesn't have the ADC. Anyway.

> > If moving the core MFD usage to drivers/mfd/ is another hard requirement,
> > this is also attacking form rather than substance. You as the MFD
> > maintainer can make an appeal to authority and NACK aesthetics you don't
> > like, but I just want everyone to be on the same page about this.
> 
> My plan, when and if I manage to find a few spare cycles, is to remove
> MFD use from outside drivers/mfd.  That's been my rule since forever.
> Having this in place ensures that the other rules are kept and (mild)
> chaos doesn't ensue.  The MFD API is trivial to abuse.  You wouldn't
> believe some of things I've seen over the years.  Each value I have is
> there for a historical reason.

If you're also of the opinion that MFD is a Linux-specific
implementation detail and a figment of our imagination as developers,
then I certainly don't understand why Documentation/devicetree/bindings/mfd/
exists for this separate device class that is MFD, and why you don't
liberalize access to mfd_add_devices() instead.

> > > > > There does appear to be at least some level of misunderstanding
> > > > > between us.  I'm not for one moment suggesting that a switch
> > > > > can't be an MFD. If it contains probe-able components that need
> > > > > to be split-up across multiple different subsystems, then by all
> > > > > means, move the core driver into drivers/mfd/ and register child
> > > > > devices 'till your heart's content.
> > > > 
> > > > Are you still speaking generically here, or have you actually
> > > > looked at any "nxp,sja1105q" or "nxp,sja1110a" device trees to see
> > > > what it would mean for these compatible strings to be probed by a
> > > > driver in drivers/mfd?
> > > 
> > > It's not my role to go digging into existing implementations and
> > > previous submissions to prove whether a particular submission is
> > > suitable for inclusion into MFD.
> > > 
> > > Please put in front of me, in a concise way (please), why you think
> > > this is fit for inclusion.
> > 
> > No new information, I think the devices are fit for MFD because of
> > their memory map which was shown in the previous reply.
> 
> And Andrew's opinion reflects that, so I'm inclined to agree in general
> terms.
> 
> > > I've explained what is usually required, but I'll (over-)simplify
> > > again for clarity:
> > > 
> > >  - The mfd_* API call-sites must only exist in drivers/mfd/ -
> > >  Consumers usually spit out non-system specific logic into a 'core'
> > >  - MFDs need to have more than one child - This is where the 'Multi'
> > >  comes in - Children should straddle different sub-systems -
> > >  drivers/net is not enough [0] - If all of your sub-devices are in
> > >  'net' use the platform_* API - <other stipulations less relevant to
> > >  this stipulation> ...
> > > 
> > > There will always be exceptions, but previous mistakes are not good
> > > justifications for future ones.
> > > 
> > > [0]
> > > 
> > >   .../bindings/net/dsa/nxp,sja1105.yaml         |  28 +
> > >   .../bindings/net/pcs/snps,dw-xpcs.yaml        |   8 + MAINTAINERS
> > >   |   2 + drivers/mfd/mfd-core.c                        |  11 +-
> > >   drivers/net/dsa/sja1105/Kconfig               |   2 +
> > >   drivers/net/dsa/sja1105/Makefile              |   2 +-
> > >   drivers/net/dsa/sja1105/sja1105.h             |  42 +-
> > >   drivers/net/dsa/sja1105/sja1105_main.c        | 169 +++---
> > >   drivers/net/dsa/sja1105/sja1105_mdio.c        | 507
> > >   ------------------ drivers/net/dsa/sja1105/sja1105_mfd.c         |
> > >   293 ++++++++++ drivers/net/dsa/sja1105/sja1105_mfd.h         |  11
> > >   + drivers/net/dsa/sja1105/sja1105_spi.c         | 113 +++-
> > >   drivers/net/mdio/Kconfig                      |  21 +-
> > >   drivers/net/mdio/Makefile                     |   2 +
> > >   drivers/net/mdio/mdio-regmap-simple.c         |  77 +++
> > >   drivers/net/mdio/mdio-regmap.c                |   7 +-
> > >   drivers/net/mdio/mdio-sja1110-cbt1.c          | 173 ++++++
> > >   drivers/net/pcs/pcs-xpcs-plat.c               | 146 +++--
> > >   drivers/net/pcs/pcs-xpcs.c                    |  12 +
> > >   drivers/net/phy/phylink.c                     |  75 ++-
> > >   include/linux/mdio/mdio-regmap.h              |   2 +
> > >   include/linux/mfd/core.h                      |   7 +
> > >   include/linux/pcs/pcs-xpcs.h                  |   1 +
> > >   include/linux/phylink.h                       |   5 + 24 files
> > >   changed, 1033 insertions(+), 683 deletions(-) delete mode 100644
> > >   drivers/net/dsa/sja1105/sja1105_mdio.c create mode 100644
> > >   drivers/net/dsa/sja1105/sja1105_mfd.c create mode 100644
> > >   drivers/net/dsa/sja1105/sja1105_mfd.h create mode 100644
> > >   drivers/net/mdio/mdio-regmap-simple.c create mode 100644
> > >   drivers/net/mdio/mdio-sja1110-cbt1.c
> > > 
> > > > What OF node would remain for the DSA switch (child) device
> > > > driver? The same? Or are you suggesting that the entire
> > > > drivers/net/dsa/sja1105/ would move to drivers/mfd/? Or?
> > > 
> > > See bullet 1.1 above.
> > > 
> > > [...]
> > > 
> > > > > I don't recall those discussions from 3 years ago, but the
> > > > > Ocelot platform, whatever it may be, seems to have quite a lot
> > > > > more cross-subsystem device support requirements going on than I
> > > > > see here:
> > > > > 
> > > > > drivers/i2c/busses/i2c-designware-platdrv.c
> > > > > drivers/irqchip/irq-mscc-ocelot.c drivers/mfd/ocelot-*
> > > > > drivers/net/dsa/ocelot/* drivers/net/ethernet/mscc/ocelot*
> > > > > drivers/net/mdio/mdio-mscc-miim.c
> > > > > drivers/phy/mscc/phy-ocelot-serdes.c
> > > > > drivers/pinctrl/pinctrl-microchip-sgpio.c
> > > > > drivers/pinctrl/pinctrl-ocelot.c
> > > > > drivers/power/reset/ocelot-reset.c drivers/spi/spi-dw-mmio.c
> > > > > net/dsa/tag_ocelot_8021q.c
> > > > 
> > > > This is a natural effect of Ocelot being "whatever it may be". It
> > > > is a family of networking SoCs, of which VSC7514 has a MIPS CPU
> > > > and Linux port, where the above drivers are used. The VSC7512 is
> > > > then a simplified variant with the MIPS CPU removed, and the
> > > > internal components controlled externally over SPI. Hence MFD to
> > > > reuse the same drivers as Linux on MIPS (using MMIO) did. This is
> > > > all that matters, not the quantity.
> > > 
> > > From what I can see, Ocelot ticks all of the boxes for MFD API
> > > usage, whereas this submission does not.  The fact that the
> > > overarching device provides a similar function is neither here nor
> > > there.
> > > 
> > > These are the results from my searches of your device:
> > > 
> > >   git grep -i SJA1110 | grep -v 'net\|arch\|include' <no results>
> > > 
> > > [...]
> > > 
> > > > > My point is, you don't seem to have have any of that here.
> > > > 
> > > > What do you want to see exactly which is not here?
> > > > 
> > > > I have converted three classes of sub-devices on the NXP SJA1110
> > > > to MFD children in this patch set. Two MDIO buses and an Ethernet
> > > > PCS for SGMII.
> > > > 
> > > > In the SJA1110 memory map, the important resources look something
> > > > like this:
> > > > 
> > > > Name         Description
> > > > Start      End SWITCH       Ethernet Switch Subsystem
> > > > 0x000000   0x3ffffc 100BASE-T1   Internal MDIO bus for 100BASE-T1
> > > > PHY (port 5 - 10)  0x704000   0x704ffc SGMII1       SGMII Port 1
> > > > 0x705000   0x705ffc SGMII2       SGMII Port 2
> > > > 0x706000   0x706ffc SGMII3       SGMII Port 3
> > > > 0x707000   0x707ffc SGMII4       SGMII Port 4
> > > > 0x708000   0x708ffc 100BASE-TX   Internal MDIO bus for 100BASE-TX
> > > > PHY                0x709000   0x709ffc
> > > 
> > > All in drivers/net.
> > > 
> > > > ACU          Auxiliary Control Unit
> > > > 0x711000   0x711ffc GPIO         General Purpose Input/Output
> > > > 0x712000   0x712ffc
> > > 
> > > Where are these drivers?
> > 
> > For the GPIO I have no driver yet.
> > 
> > For the ACU, there is a reusable group of 4 registers for which I
> > wrote a cascaded interrupt controller driver in 2022. This register
> > group is instantiated multiple times in the SJA1110, which justified a
> > reusable driver.
> > 
> > Upstreaming it was blocked by the inability to instantiate it from the
> > main DSA driver using backwards-compatible DT bindings.
> > 
> > In any case, on the older generation SJA1105 (common driver with
> > SJA1110), the GPIO and interrupt controller blocks are missing. There
> > is an ACU block, but it handles just pinmux and pad configuration, and
> > the DSA driver programs it directly rather than going through the
> > pinmux subsystem.
> > 
> > This highlights a key requirement I have from the API for
> > instantiating sub-devices: that it is sufficiently flexible to split
> > them out of the main device when that starts making sense (we identify
> > a reusable block, or we need to configure it in the device tree, etc).
> > Otherwise, chopping up the switch address space upfront is a huge
> > overhead that may have no practical gains.
> 
> I certainly understand the challenges.
> 
> However, from my PoV, if you are instantiating one driver, even if it
> does a bunch of different things which _could_ be split-up into all
> sorts of far reaching subsystems, it's still one driver and therefore
> does not meet the criteria for inclusion into MFD.
> 
> I had to go and remind myself of your DT:
> 
>         ethernet-switch@0 {
>                 compatible = "nxp,sja1110a";
> 
>                 mdios {
>                         mdio@0 {
>                                 compatible = "nxp,sja1110-base-t1-mdio";
>                         };
> 
>                         mdio@1 {
>                                 compatible = "nxp,sja1110-base-tx-mdio";
>                         };
>                 };
>         };
> 
> To my untrained eye, this looks like two instances of a MDIO device.
> 
> Are they truly different enough to be classified for "Multi"?

Careful about terms, these are MDIO "buses" and not MDIO "devices"
(children of those buses).

Let me reframe what I think you are saying.

If the aesthetics of the dt-bindings of my SPI device were like this (1):

		spi {
			mfd@0 {
		^		reg = <0>;	// SPI chip select
		|		#address-cells = <1>;
		|		#size-cells = <1>;
		|
		|		ethernet-switch@0 { // SWITCH region (0x000000   0x3ffffc)	^
		|			reg = <0x000000 0x400000>;				| DSA probes only here
		|		};								v
		|
		|		mdio@704000 { // 100BASE-T1 region (0x704000   0x704ffc)
		|			reg = <0x704000 0x1000>;
		|		}
		|
Entire SPI	|		ethernet-pcs@705000 { // SGMII1 region (0x705000   0x705ffc)
device address	|			reg = <0x705000 0x1000>;
space		|		}
(0x0-0x71FFFC),	|
up for grabs	|		ethernet-pcs@706000 { // SGMII2 region (0x706000   0x706ffc)
by sub-devices	|			reg = <0x706000 0x1000>;
		|		};
		|
		|		ethernet-pcs@707000 { // SGMII3 region (0x707000   0x707ffc)
		|			reg = <0x707000 0x1000>;
		|		};
		|
		|		ethernet-pcs@708000 { // SGMII4 region (0x708000   0x708ffc)
		|			reg = <0x708000 0x1000>;
		|		};
		|
		|		mdio@709000 { // 100BASE-TX region (0x709000   0x709ffc)
		|			reg = <0x709000 0x1000>;
		|		};
		v	};
		};

then you wouldn't have had any issue about this not being MFD, correct?
I think this is an important base fact to establish.
It looks fairly similar to Colin Foster's bindings for VSC7512, save for
the fact that the sub-devices are slightly more varied (which is inconsequential,
as Andrew seems to agree).

However, the same physical reality is being described in these _actual_
dt-bindings (2):

		spi {
			ethernet-switch@0 { // DSA probes here
		^		reg = <0>;	// SPI chip select
		|
		|		// Legacy sub-devices (presently registered by DSA driver),
		|		// already established dt-binding, proposal is to keep bindings unchanged,
		|		// but to register using MFD
		|		mdios {
		|			mdio@0 { // 100BASE-T1 region (0x704000   0x704ffc)
		|				compatible = "nxp,sja1110-base-t1-mdio";
		|			};
		|
		|			mdio@1 { // 100BASE-TX region (0x709000   0x709ffc)
		|				compatible = "nxp,sja1110-base-tx-mdio";
		|			};
		|		};
		|
		|		regs { // Proposed binding addition, anything here is MFD child		^
		|			#address-cells = <1>;						|
Entire SPI	|			#size-cells = <1>;						|
device address	|											|
space		|			ethernet-pcs@705000 { // SGMII1 region (0x705000   0x705ffc)	|
(0x0-0x71FFFC)	|				reg = <0x705000 0x1000>;				|
owned by DSA	|			}								|
driver		|											|
		|			ethernet-pcs@706000 { // SGMII2 region (0x706000   0x706ffc)	| Entire SPI
		|				reg = <0x706000 0x1000>;				| device address
		|			};								| space again
		|											| (0x0-0x71FFFC)
		|			ethernet-pcs@707000 { // SGMII3 region (0x707000   0x707ffc)	| up for grabs
		|				reg = <0x707000 0x1000>;				| by sub-devices
		|			};								|
		|											|
		|			ethernet-pcs@708000 { // SGMII4 region (0x708000   0x708ffc)	|
		|				reg = <0x708000 0x1000>;				|
		|			};								|
		|		};									v
		v	};
		};

Your issue is that, when looking at these real dt-bindings,
superficially the MDIO buses don't "look" like MFD.

To which, yes, I have no objection, they don't look like MFD because
they were written as additions on top of the DSA schema structure, not
according to the MFD schema.

In reality it doesn't matter much where the MDIO bus nodes are (they
could have been under "regs" as well, or under "mfd@0"), because DSA
ports get references to their children using phandles. It's just that
they are _already_ where they are, and moving them would be an avoidable
breaking change.

> > > > I need to remind you that my purpose here is not to add drivers in
> > > > breadth for all SJA1110 sub-devices now.
> > > 
> > > You'll see from my discussions with Colin, sub-drivers (if they are
> > > to be used for MFD justification (point 3 above), then they must be
> > > added as part of the first submission.  Perhaps this isn't an MFD,
> > > "yet"?
> > > 
> > > [...]
> > 
> > IMHO, the concept of being or not being MFD "yet" is silly. Based on
> > the register map, you are, or are not.
> 
> Perhaps I didn't explain this very well.  What I'm alluding to here is
> that perhaps this a collection of different devices that may well fit
> comfortably with the remit of MFD.  However, I haven't seen any
> compelling evidence of that in this current submission.
> 
> As an example, when contributors submit an MFD core driver with only one
> device, let's say a few Regulators but promise that the device is
> actually capable of operating as a Watchdog, a Real-Time Clock and a
> Power-on Key, only they haven't authored the drivers for those yet.  The
> driver get NACKed until at least one other piece of functionality is
> available.  Else the "Multi" box isn't ticked and therefore does not
> qualify for inclusion.

Exactly. DSA drivers get more developed with new each new hardware
generation, and you wouldn't want to see an MFD driver + its bindings
"just in case" new sub-devices will appear, when currently the DSA
switch is the only component supported by Linux (and maybe its internal
MDIO bus).

You provided exactly the reason why the dt-bindings of SJA1110 look like (2),
yet you dislike they don't look like (1) in order to fit the narrow
understanding of how the MFD API should be used.

> The "yet" part was alluding to the fact that this may be the case here.

Yes, so in my understanding it's MFD if it uses mfd_add_devices() and
it's not MFD if it doesn't.

> > > > The SGMII blocks are highly reusable IPs licensed from Synopsys,
> > > > and Linux already has DT bindings and a corresponding platform
> > > > driver for the case where their registers are viewed using MMIO.
> > > 
> > > This is a good reason for dividing them up into subordinate platform
> > > devices.  However, it is not a good use-case of MFD.  In it's
> > > current guise, your best bet is to use the platform_* API directly.
> > > 
> > > This is a well trodden path and it not challenging:
> > > 
> > >   % git grep platform_device_add -- arch drivers sound | wc -l 398
> > > 
> > > [...]
> > > 
> > > > In my opinion I do not need to add handling for any other
> > > > sub-device, for the support to be more "cross-system" like for
> > > > Ocelot. What is here is enough for you to decide if this is
> > > > adequate for MFD or not.
> > > 
> > > Currently ... it's not.
> > > 
> > > [...]
> > > 
> > > Hopefully that helps to clarify my expectations a little.
> > > 
> > > TL;DR, this looks like a good candidate for direct platform_* usage.
> > 
> > I do have a local branch with platform devices created manually, and
> > yet, I considered the mfd_add_devices() form looked cleaner when
> > submitting.
> > 
> > I expect the desire to split up reusable register regions into
> > platform sub-devices to pop up again, so the logic should be available
> > as library code at some level (possibly DSA).
> > 
> > Unless you have something against the idea, I'm thinking a good name
> > for this library code would be "nmfd", for "Not MFD". It is like MFD,
> > except: - the parent can simultaneously handle the main function of
> > the device while delegating other regions to sub-devices - the
> > sub-devices can all have drivers in the same subsystem (debatable
> > whether MFD follows this - just to avoid discussions) - their OF nodes
> > don't have to be direct children of the parent.
> 
> Well, we already have Simple MFD which works for some basic use-cases.
> 
> When I've thought about replacing the existing occurrences of the MFD
> API being used outside of drivers/mfd, I have often thought of a
> platform_add_device_simple() call which I believe would do what most
> people of these use-cases actually want.

Would this platform_add_device_simple() share or duplicate code with
mfd_add_devices()? Why not just liberalize mfd_add_devices() (the
simplest solution)?

