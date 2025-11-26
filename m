Return-Path: <netdev+bounces-241805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D92C886A0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E79C4E51C3
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730A9295DBD;
	Wed, 26 Nov 2025 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iHM7HGe5"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D24288520;
	Wed, 26 Nov 2025 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142009; cv=fail; b=QZj3++5p0RgR5V7k6hOxwbhIYSLv6zV8KHSbRr1759m+so/OPTaya43htWb2980kdYWFcCl6+gGV/6/wwnwofvFR5QmzmN6kPq7z8Kn4aLQBh8TttTF3mff6Kkcn8idoUZx9GVzem0YM71+t6oXWrMBufGG5WwbqoeTay67KUuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142009; c=relaxed/simple;
	bh=ZQpAGbz7dvHk8Is+getHp1UVtCB5jNCDxV5Hb13P9Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dT4OpzP7+6UmMpYPWGGzs/enpYGgjGgDa0XYlFG1ZC4pSiR1A6mFC757fYrH9cP1AZtvVgEUOwkOj4W+k43Ax9vsf20hX6W5JE/+7C5wEzb+JQlQcW1A3PVmC7cI3Q37gkFxSfFzFUx3febv8mhD+/ClV6IBlPPR0QNhEmBiF5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iHM7HGe5; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud3cxRvw1TFuFc4nlhs53X+MxzZ3DK++JURr9Tfyb4ZhqmVWruG9PnwomP55PtGXXQ9949ZjQi58fJvGTgLIxVc+qS6D/mbXsUhv/Rd3MG8RchjpMq/qdVVDoDEI3VhyntZA0L0Xz4lIJBI8hwYs6tlKy7hq3sq6fovUt+h39oAE4WBfjDG4XoFDKQfIXw7HzbaoqIJRxDt2jWpIYsUjwM480kJWQV6N+/iM5KEIAsK6Tu0862te3ZS3S2RSAL3ADsARh2D6M7RbBEGeMLks/Qf7nYvqoMVIncR5kqvJAKCo6r1wA+uw7MfmkLGx1NYlT+Qkgkzb+HMwT2FQ7gfm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1a8YRq1WkhCi1TUQNyoig2F7ZtUJ0UZCTpT8mVpydE=;
 b=jNaLFRuHmReuO7+wiMPdYYPACcn+2Z9s3EVvM+JOth6B+1c7PWhcxxhP5ZzuUIxN6v3SiTuhFmFsKupg6xKXh9rDnW7l6KyzFvVIGvnpz7OOG4thEloXnhOnApEVAKBsSF9EQNgwctubNnNsqiU2Gym/TCujtANK+FMPx/K0p9ogUwCCGFqEs5U8bi/56k7Gtgd0cp+DR3eRGFxWIp6/9yX5Ce2rKhz4f8B7O4KnpE6nm+14PRxK9Q4/6DC8gocTfZYi7thL2XHF3bpWNapxG8Cb25GFeCGpncGcZJyRmwLIzrwxp1D+jWEXwo7hAbHS4k5G6hDOnTDkd/vTNGWPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1a8YRq1WkhCi1TUQNyoig2F7ZtUJ0UZCTpT8mVpydE=;
 b=iHM7HGe5qRU3EVOMOqC6ewpWqTZIdqKkCUZKw1E/oLlA9OcINVcB1leIUP+uVRuE7UaJ2wBl3PVEoN6LyREQrmd3kndWbCvHG3+TIodZ6ihofqd6mzAEjlI3W94WOdIwJVz69zRE9lFM0JVntlBqDSUb48OSWk1zvdQCqYeesOGa0jlrz47qC/WbjyHPAYNrWTfG3CGxGSU2p+mmR1s75NzAdlto+2oY7ffvGBt54P45vkESu1JnupvSY++ywgH9GerxDPYprpRnYTCMtjOvyqrznPLpvnCaYpcKWbXKEKtgsQgWO3vUcleIbUOLmHvR8cID+z45aVDfietmxsAKZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8157.eurprd04.prod.outlook.com (2603:10a6:102:1cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 07:26:43 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 07:26:42 +0000
Date: Wed, 26 Nov 2025 09:26:38 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Message-ID: <20251126072638.wqwbhhab3afxvm7x@skbuf>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
 <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
 <20251125214450.qeljlyt3d27zclfr@skbuf>
 <b4597333-e485-426d-975e-3082895e09f6@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4597333-e485-426d-975e-3082895e09f6@lunn.ch>
X-ClientProxiedBy: BE1P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::13) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f79047f-2797-4ca0-dd95-08de2cbd2535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|19092799006|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQu8HNFwD8eEGJZINSdRSTmwU1QgImEqX1+fy7TZhs2rR3+7vbaypArNNvKk?=
 =?us-ascii?Q?oql0jcz6NKaBRSVu/5iqUZyglUq1IaBWkjt74YuYnR+r5OfB8thI5OVr0C1w?=
 =?us-ascii?Q?4jkorcMOZh5ryzX0i3JBGRONYr5jFCuS4jmc9hf/rcFv99Wvc/BPqJXMK8tr?=
 =?us-ascii?Q?d2PDkU0QiMrbP0Tyy/qthJCSf0EIM4Q3oNRsSRfn0VdfeND/ekNCVg4nsYQ2?=
 =?us-ascii?Q?z4W/+Ei8xxvB3fMYfQP38MaacwhyfCdzNCL0Qf/BLVyFYq6bky2V8JI0S7x5?=
 =?us-ascii?Q?O2qh0ljjkUo34DRrJqArhgeLda2oTKXOHt2otLCp8hsqUFjc31wtqoDHcEmd?=
 =?us-ascii?Q?JD9Zmr2cjBfTLWxWIRoK/B03qS/9fu2avJaU0bygho1jbUIhZfPvmjBpg1Q5?=
 =?us-ascii?Q?T+HPCv4YYutc7YsOlNNm7O1nbzkzMBCKNNxveCt39YOmXD+Iez9mj8A/jWKb?=
 =?us-ascii?Q?S3pfsNp2gHS/E/0IJ+T3ndTOZAY+58zcUvFd599x6PEL4CAC91UoCJ3ZGm09?=
 =?us-ascii?Q?s5YqM2vFTbzq/o3d5TujrsDeuj2vWB3ixTDSZxUx2cd2JOucuJmxmvCl7Dc0?=
 =?us-ascii?Q?sLCbIIXI15YkZFMuu0qk4pATv9TvIRZUPY8C6GDECL7B3j8qM7pF9BqI0PVD?=
 =?us-ascii?Q?7LRsY1T+JOR15j/G3CTT1yxr7xvAaCMfUT8a9T8R4iqBHtVFDyrG7V3lIjtL?=
 =?us-ascii?Q?jdb5QtWBmmEnjnImoSy+BKHat6cux04uDa4KPplZeEm0RV/O8qv6GwWXbrvg?=
 =?us-ascii?Q?5AAMjADD7i36tUCxRcwGq4Lz+PJPFbdnA/JMdcMv1upbj8unjHXwR5RGpMo3?=
 =?us-ascii?Q?TGbzwk7+vuFIhRBo/5gz9xUHrCMRYLpJzCbT4v7vFTscGduCeET9i7KM70iB?=
 =?us-ascii?Q?Vc4LqEXQSRdhQkh81xOvcgDGHfLaFBB0q8Y4ftuy7YEg1tDOWMH1k85lVTlM?=
 =?us-ascii?Q?HfhdKuI6KLQWS/2vByzY+I2CkX2t3gOBLrl5RFa0VEW6YlKUaXl7r/gdRbs2?=
 =?us-ascii?Q?30n+Ds+N/asAijoKo3FLtE4hGBSm0G/bv9/6A9A9L7QmBljbYmBMLs8aXRNV?=
 =?us-ascii?Q?k4onxGu/AyWL/SX80AIKm3lO1PkUvECENxnkqQln1/1EvF7B5W3WhN/H7TTc?=
 =?us-ascii?Q?TBYknA5ULkY+C/u/zogPrWDit6IZunot0ohIwExe7/qfx5/FTwaGIQKl2BmJ?=
 =?us-ascii?Q?F+NaC7ICCGZV+ZtXZA8ogRhAxqxZ5F6GWjpavCP+FPGHA5SfcH1SQCHr0k0S?=
 =?us-ascii?Q?zTlpJyP0Qfhg/8SwJ63sjRHuEu7YOdV3rE67o8XkFB14RvydpBVz3BXlY6c2?=
 =?us-ascii?Q?jFvy8AudeCH2SRhuAvAv+bS9zNAej9fS4ieDmJ3MTvWlBwX9PUJaK8FbSZlh?=
 =?us-ascii?Q?fqzEbQ56klorCISOGACCRCo50cpMKNHdsDWLRWboImdCRA1aeyO9As17KxBt?=
 =?us-ascii?Q?5pT+eCW6uznvKLMlqdNuoAjoSCX56ggX9/WEb05pzf/oTR2pf2654A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(19092799006)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8GvAWBCBkHaQRDwzX+LQrVwOHDGBOrnFP3lAaTsydcJRJeeRYeSsQOz1ZhmR?=
 =?us-ascii?Q?axSNXy586OoEZpghzT2m8tkLRnr/ujc3RR30lMaRf7soXj0csOhd3squCYjv?=
 =?us-ascii?Q?+mqKfIxtNCphCCCOeG2EAqUJbk4VHowaEKhSruiuFHRNWb/69whAOHoxgFuB?=
 =?us-ascii?Q?sPBAT+hMVaZ+XLPQrFzx2t2ayn6I4c0gXAoq5LJPOyEvWoYhXgaWr0LByqi6?=
 =?us-ascii?Q?dp++1fPM/Dn7RE6tS+MSz+4EHG//ZXU4x6pTYHjp4mvk+k3TTETrjgYWoZRM?=
 =?us-ascii?Q?VlBY2YWVxt3MDfqk0WGU0S6hmkqjpC4DUhpg8PzqrI/TRzknuAJcjCgLPBAl?=
 =?us-ascii?Q?7P++pDd/bY35Gqpu+I8fgLlqj6kkBa0D0uleNOIG47CwtBd7Q3gqvkgJNI7u?=
 =?us-ascii?Q?we/6hKM7srNLbsLonno5GaduFs4OqulrRlK7eHN94J9/itSxspBq8rqDYKRp?=
 =?us-ascii?Q?Wvj0hD16Ii8OfGor+TLN8zGDy+FAZS39qsw+Q+952OVhyhstNPedcSnn3xRy?=
 =?us-ascii?Q?9T3L7Jg7Vlwk318uJCOtlw554SH39UZXNj9fLPq7yq7GZuQ+MNW3xen16UKk?=
 =?us-ascii?Q?QeT85BX+C9xF2Kn2fXh/2UC8IiZUwErdcOzk0h90JzW7qizhGZYy87He8nNB?=
 =?us-ascii?Q?XAwtNrA7Gl1Lpmsf7jUTRuw1oWVfpGqpKk28YN/2rbWfELHLO7syIQh9AE53?=
 =?us-ascii?Q?+Vgz8z8D45PDIWPfH8ebo5zpHbrDCtcd5asIr89V6FAsgZPmQexmsLKQLepf?=
 =?us-ascii?Q?4Tj1NZrVb8ln9ogzDbWVMi10bT4KKUiIBaO6nSLg7HFZm2iJp8B0HotOzZfk?=
 =?us-ascii?Q?GbQkVHV35Qdok/wgrrdjsPjkfXq/i+jiZdSAfb8wWLXwzIA+Fx1YGc29jwUq?=
 =?us-ascii?Q?HZl/keiGFqDXT0RMchSBLtC1RbEOnibwVvnMvdEbS5ajyRi+bkyB6+rsIraO?=
 =?us-ascii?Q?CzRYoVDIjyBGvObUr+woohVL+0KKOHDP9Ji8tcAxa8Q7ETCvWQ+mjVlM9bVA?=
 =?us-ascii?Q?WVt2gcbS2sIO1W9UjQLbBlMRr6rpSTz+cORqXeJaBTl14rVGV+DBBxCY69aa?=
 =?us-ascii?Q?vD/JDjc6A+u8RlyzwYIlA+i9opjvORBsXlmevKwuXyX5xeo9mRxDDJ35A6lG?=
 =?us-ascii?Q?KZMLpY1Q2hmIF0KjLOiBdg8nzS3/u6R9xu19Cd4AHS5gEjp5P4123uy5xNjU?=
 =?us-ascii?Q?1iW/jiTy3MaaX1a1bqdgwLZ4h0Lij819eLQTVOMA31oh/w+tSXHLVzGpVO3w?=
 =?us-ascii?Q?abSD9iJS9LWULWa7vK7Tj21sMsiJd5cCmgHm9QpzM7fbZ/uYmNQp+P2PAmdE?=
 =?us-ascii?Q?fadl/si0IItfzDdIE6fgxMhjN0tyfrIeq7fmNADUWLbTUTmSAMHJsf5KpTJX?=
 =?us-ascii?Q?f4LroCdE1lyIuIkRv2ZTicXEDBmtOtZodFUnXJBsT/nrcL+v0hbw6zP7C3YX?=
 =?us-ascii?Q?YvNvW4YpBscZ5Qev8EPw503JgTBQos420utSwWHpWC0+N+iYnlblsAExRxN0?=
 =?us-ascii?Q?yvIK358jYuh0DkOcAT41MqepP6WXZ4rJQs1uIdirAOPuttwArEYsp6+MHGc9?=
 =?us-ascii?Q?Kln/UC7sz2bZCer4e+1ma0lSPvIf34HuzBMJOs98yHcgGNNhp8LV4RPkmc9A?=
 =?us-ascii?Q?IEioHyGr+QWgLMuxCBzLn2oH/6ls+K6vxzh7y70szltHywWR693Is/DN2Brs?=
 =?us-ascii?Q?ASe/xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f79047f-2797-4ca0-dd95-08de2cbd2535
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 07:26:42.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpomPosy46JJ4kfQVcc44X3bgH6GdnySlNZ9oRlA4m87oEr8HfLNO9/ZRZ2p+TbZaREXVcvT3zIiTHxq4Pn5vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8157

+Maxime, Holger
thread at https://lore.kernel.org/netdev/20251122193341.332324-2-vladimir.oltean@nxp.com/

On Tue, Nov 25, 2025 at 11:33:09PM +0100, Andrew Lunn wrote:
> > Yeah, although as things currently stand, I'd say that is the lesser of
> > problems. The only user (mv88e6xxx) does something strange: it says it
> > wants to configure the TX amplitude of SerDes ports, but instead follows
> > the phy-handle and applies the amplitude specified in that node.
> > 
> > I tried to mentally follow how things would work in 2 cases:
> > 1. PHY referenced by phy-handle is internal, then by definition it's not
> >    a SerDes port.
> > 2. PHY referenced by phy-handle is external, then the mv88e6xxx driver
> >    looks at what is essentially a device tree description of the PHY's
> >    TX, and applies that as a mirror image to the local SerDes' TX.
> > 
> > I think the logic is used in mv88e6xxx through case #2, i.e. we
> > externalize the mv88e6xxx SerDes electrical properties to an unrelated
> > OF node, the connected Ethernet PHY.
> 
> My understanding of the code is the same, #2. Although i would
> probably not say it is an unrelated node. I expect the PHY is on the
> other end of the SERDES link which is having the TX amplitudes
> set. This clearly will not work if there is an SFP cage on the other
> end, but it does for an SGMII PHY.

It is unrelated in the sense that the SGMII PHY is a different kernel
object, and the mv88e6xxx is polluting its OF node with properties which
it then interprets as its own, when the PHY driver may have wanted to
configure its SGMII TX amplitude too, via those same generic properties.

> I guess this code is from before the time Russell converted the
> mv88e6xxx SERDES code into PCS drivers. The register being set is
> within the PCS register set.  The mv88e6xxx also does not make use of
> generic phys to represent the SERDES part of the PCS. So there is no
> phys phandle to follow since there is no phy.

In my view, the phy-common-props.yaml are supposed to be applicable to either:
(1) a network PHY with SerDes host-side connection (I suppose the media
    side electrical properties would be covered by Maxime's phy_port
    work - Maxime, please confirm).
(2) a phylink_pcs with SerDes registers within the same register set
(3) a generic PHY

My patch 8/9 (net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and
"airoha,pnswap-tx") is an example of case (1) for polarities. Also, for
example, at least Aquantia Gen3 PHYs (AQR111, AQR112) have a (not very
well documented) "SerDes Lane 0 Amplitude" field in the PHY XS Receive
(XAUI TX) Reserved Vendor Provisioning 4 register (address 4.E413).

My patch 7/9 (net: pcs: xpcs: allow lane polarity inversion) is an
example of case (2).

I haven't submitted an example of case (3) yet, but the Lynx PCS and
Lynx SerDes would fall into that category. The PCS would be free of
describing electrical properties, and those would go to the generic PHY
(SerDes).

All I'm trying to say is that we're missing an OF node to describe
mv88e6xxx PCS electrical properties, because otherwise, it collides with
case (1). My note regarding "phys" was just a guess that the "phy-handle"
may have been mistaken for the port's SerDes PHY. Although there is a
chance Holger knew what he was doing. In any case, I think we need to
sort this one way or another, leaving the phy-handle logic a discouraged
fallback path.

That being said, I'm not exactly an expert in determining _how_ we could
best retrofit SerDes/PCS OF nodes on top of the mv88e6xxx bindings.
It depends on how many SerDes ports there are in these switches
architecturally, and what is their register access method, so it would
need to be handled on a case-by-case basis rather than one-size-fits-all.
PCS node in port node could be a starting point, I guess, but I don't
know if it would work.

For SJA1105 and the XPCS, I thought the best course of action would be
to create a "regs" container node in the switch, under which we'd have
"ethernet-pcs" children, but that seems to be problematic in its own
ways, due to how MFD is seemingly abused to make that work:
https://lore.kernel.org/netdev/20251118190530.580267-15-vladimir.oltean@nxp.com/

