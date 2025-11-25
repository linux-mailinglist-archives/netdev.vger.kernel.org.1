Return-Path: <netdev+bounces-241583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17235C8624D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9853B9144
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5157E32FA17;
	Tue, 25 Nov 2025 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qyb7iBNg"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013068.outbound.protection.outlook.com [52.101.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094A32AAD1;
	Tue, 25 Nov 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090188; cv=fail; b=c3Q/MFkL+jAWSMWl64sBXOUnwsqVU/AHE6Tmty2yys0M8JsrXluqES2r/anZNocfje4dCDwcZjPbq12r3k0Zkls/LuZlZB/GbNfHIIg1vkqHHjaOEMu1IBDv+xSP7UW2IDzLFmLE721AYxVBf+rxfs4zKcOidgsprpT4v6Hzf+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090188; c=relaxed/simple;
	bh=DForb3i68Qn3GwqA9/1r6/8r/GTPjmC3AaOsJ3ozhIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HFXoRBkxHgMT2s4mrVFaf6gAKITuGnQuIwW+e9hDkdMooE8a3ISFiDQrHLpu6v//QnduS03vNx67gcmawjnZKy9J29pbqNHIj0OSzgFg7RW62eQM6DqhURykbfma8uGBOLOy+1z/AHuU2ehjAXfedEeLssCsL/DzvqnUkzKjNgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qyb7iBNg; arc=fail smtp.client-ip=52.101.72.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyysDHgCrJs1Nkp95uOibo1v6wgOjFgw6cePwFIFDGeXc21GOUzSu8RsmeWOKJlVMhgsgb1hNjhiz+cQdPX3SGnDjPhZVekKDhyU08+yLyTIrwqA78hrrU9d3x3R4fnUDdd9Ms1cco1ZbFVG0E99XKpkaWVTKvuSecuH/MKpaijmCOkzHOqTbWF8Z9BbXlIt47RaFN6t8wVKqxpK16fZR912rb3DL5GSImLEH6/DPcBIObMigx1oyGcYLJmhHiZOzC9z0taxWXHpoS/Jqg/7vkthBXAvXg0iNc9UJNCnXAXuwypI1ENdz3GSqusam3IKCR4xyaHC78CHvU7d7uE1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWY7MFugZ9CmdVxleLBxwXlELP55Zd08rQW98ZPdUto=;
 b=cdg69Z0v5wG2/Pw0CM0emjhqmqyhGR/QgV7y8EzZXEBgF3MzOvz5X+SccggqrWK/3ViETt4R5b4+pj/AwRDQN+9eIEOLJoXZjZphoqIpkrigMVx5izxl1983/k/DT4kISaXRQbNVrPRxNnQ6nvmmxO7O+ahh87imtOw4fsKzh569+RQXmsgyPoQI9LtcrF26aNHbXmH9nGbpKUp3YwtQSwiRQVCzFpVLYisu0gcpJZp1MlZjEM8HxeqiA4km+1hb46t1Tyo26OAwHXYnrqRfXChkLXW4MIoW8C5Wzg/GXM3hYVmCwRfZhnbH+gvVRnO8w7BwFTFUZuaO/billEFfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWY7MFugZ9CmdVxleLBxwXlELP55Zd08rQW98ZPdUto=;
 b=Qyb7iBNgvz8Alw5HAF2z9hiItohZKEIjWfJ622vGI2TDXuZO5FRSPwJvd3cwsGITM02+UwMGxf0HftoZkiem1KH+YiDUxcs4VhFPLuwHraPXVMvy0YWmiD7BH/MMjHpftOg8rJlhJzS0921f3eidwU/+YNUBMNxUjYMCvzWjnEpHbUZAC6uT1AO9w32deHgQqZ4sCpH/qjzV72/UAUuHKepIRdpdhKm0BOXyAggXGqW807aXpAoYXiKpSGq+SCDGhhm/AxubN2p4bK3rkrOEsu1Yw+jTXqWyCXaRcNFr77SsSvvFjPgCi3Fq2kFnAAp7ylNe/FA85lPKdLdPmgpkrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11450.eurprd04.prod.outlook.com (2603:10a6:150:296::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 17:03:01 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 17:03:01 +0000
Date: Tue, 25 Nov 2025 19:02:57 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVo4oia4oirbg==?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 5/9] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <20251125170257.pk4cish65mcoeqhn@skbuf>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-6-vladimir.oltean@nxp.com>
 <20251124200121.5b82f09e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124200121.5b82f09e@kernel.org>
X-ClientProxiedBy: BE1P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11450:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b34c9ec-75b7-4e55-ae02-08de2c447d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IwTVDKRaImw0k3GS5ZlUjyHuqrqPOcro9YFXVFPewx2Tv8SafN/NLXSZxtqE?=
 =?us-ascii?Q?qUzcY/2dsyx+oQEoB1r4+/dTjlewRaifEeEDICxgmpT1Q/lRYDEe9Cfkumv2?=
 =?us-ascii?Q?2wPIedNMqAcYjYhrexC+ydef+LHocJAeIVS4+/9q8t/l1CWweWHViQhlc11E?=
 =?us-ascii?Q?oBO7KNYFqzrOy8EUClSdP+wRlYR4h+tv/DOJxw8SGyWrcnx1+fZ5Wgd8mamy?=
 =?us-ascii?Q?CeB/wehWVarAtf61myExMOGqcLk7XW/XCX+j5AP3518N/O6HcDtVdZ+GPv2T?=
 =?us-ascii?Q?jWST0WCGgvL6Fbr6j5ReynNX7rFrD3jxzomLlPUBoCYesV3Cifls7remd0mY?=
 =?us-ascii?Q?fP4fvTXxI8MKsgx1am5+xeLugkmOqTyL7MqdhujZYHhJBKUceklBZCHizcdE?=
 =?us-ascii?Q?Yq09nqwyCQaTTpW4o2NjXgENrR9cHfhsyyu9nPmvhA6GAt10g2IX0SAP185K?=
 =?us-ascii?Q?Mz9ocSx2ZXEV8U+Rsjn6oyHsQLQyyejFWbl0XEJb+jpRbZ9G06BiYIADofza?=
 =?us-ascii?Q?hEkQJ+61OmCcfSZtXpre+LuzlATRS94ZZ3xkbJqYdB65JVXdKbJuVopen7I4?=
 =?us-ascii?Q?bit1oh3oy/8Efq0k3wjdiyZsnCl8sYnagYla88cqAxkkVTtCGUaEN434ujAl?=
 =?us-ascii?Q?lIg31tM66XerwqMp231GqG1ITm4c7RaKJoCaHbhWBSKnYTrfkvI6OpBFPAtE?=
 =?us-ascii?Q?4LqDcWMqfSznYw4k+GF3oh1/4+5wFRKu2Rk8GWrqeuTiEle55mYXNaFYt4np?=
 =?us-ascii?Q?cE/bBS5rB+l+6IX3yhCVBHPNDQaEmQqQX+y4ZAwTHdJz6lA1MSvrzisY+MQ1?=
 =?us-ascii?Q?X4RPbbXyT0iLWs4x/e/4Tc7xjmnzaC2hOp864LvFsPs/4I7ppK+g2lJshWWp?=
 =?us-ascii?Q?sL6Tk5j+o+0p9QIqzxuJUWn+2jQVLerohgccnd2us5rvj+sRUE4+3XIN68zg?=
 =?us-ascii?Q?0NtURYIXxctMtYhSNoeTN1yh9HgJS9I4QYPvgNBY2/0SdIJekp4WHcAeV9v0?=
 =?us-ascii?Q?8KnLfrcSpT6yu34wwHr3NwWF5T4KL+ucqb3NjVBJM+J8lFMDZbGSfIwq2FKu?=
 =?us-ascii?Q?JVgtf53d+x0kGTJIe87NiCvMuTBniYB+iNLGBVBOx17sygXoqVUAgjxGSONH?=
 =?us-ascii?Q?Z0lnFvvsR73bCuNHR+Ew89x70nUddJ8qh7KIgFcgWUfg9j7kr54JkcmPQnfv?=
 =?us-ascii?Q?g2CZMiyOg6Bp5youIwz8vX3T9uST6SlXlzjjlVpiU1CGSKCJNCvV+1rJIM0b?=
 =?us-ascii?Q?EwL12QXzQrci2XkNir+qF5InxnrFQ2nmHkd1tDpgEr+A+hZo+TjLBo91z/DV?=
 =?us-ascii?Q?Aw1jIcRRLylSTjJg1WDUqQFOPg3PkarffMoOfTbwYs2R0myGmokglH6XS1sT?=
 =?us-ascii?Q?hV4uSzA6lK5SYzKN3ZcIQHSKo1dSEjaOqZi3ZLyWYuUzQWGyHLu+SVJdglqG?=
 =?us-ascii?Q?9zAbGi9yXtJzZVDK69f1bj76oTSpkpJl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?daH5k/lvwMnLkYcGIDV0xO/dmTyIz61yprFBGyJaGB4IXTq8yDLTQIZXwOtc?=
 =?us-ascii?Q?pBznsTKlFtXH2gdut5YTySI3thXbLKuXnXR/EAM/i0FRsvd1lO/9AEQ+4OWz?=
 =?us-ascii?Q?S27I9t9C4MJ5enIzf8HYQUMPQFVU9v1wwshXVSgg+2f4qkEDoZtn9MKiKRjA?=
 =?us-ascii?Q?VLFV8/WDlyK9KoSinnctUyaCGYh5cMqpkaUexTQJ2yzZMkG14kptYzn4T3Ot?=
 =?us-ascii?Q?ft/rVkOp+SF1PTTYMB/sILot1G6+N5SLr1937w57Q1+CBwFNOgcTEJl5f9RJ?=
 =?us-ascii?Q?R5h/Bsu0+sEGLH2ZhINRJlyxA8rZop4+fI7py/XdmvoMpHqsWVGxtHehBJAw?=
 =?us-ascii?Q?l3MBBfz/vCmL5qDcXoDe2r2iKqoavhogyuVCVriECNv0L4Wtcv6Tj9krHrlc?=
 =?us-ascii?Q?JD6PuYruuH+SK0a7C9DE3Qw99XeXKl2q4405CQSfRYyhV79nu+Ot/yaezgd3?=
 =?us-ascii?Q?dnKt/SKDviaiB+kn8HeYNIsEEe3ZxAVNVUdUl6YXbvOvLQnCWelzCEpMzblv?=
 =?us-ascii?Q?OdvgGPjlIDstplQpWKxrv0++dwkbEYXXRWCh8ddNWR1H8nm8WXvvQJctYrDA?=
 =?us-ascii?Q?SA02oRDzkQuDoKghJTgDQ9X5tl67+WYGQxxx+H77HZgfN1qbQhfbBK2tLjyJ?=
 =?us-ascii?Q?Pjg5aoKdpsqhMlk4JuIxTP/BaVr+RUEI1YqyZLEgVL3Waz0yRLXJKegikDby?=
 =?us-ascii?Q?Q/fnC9ZM9sXFC11zhRhzv9lF9RfwcDpcycFBaztZ9K7cl7ytMVbBVVrKPOZA?=
 =?us-ascii?Q?2+QMwNoTzHfRH8fwFw+nDrV3uRS7uwhv+l2pyq9BwUQui7O74QYgXtwqQvvH?=
 =?us-ascii?Q?bkRPIO7B3+Hx8WDdcZ+RKxBZyfJKddcPiz+UF++0W2skHDEhU6tyvBgET3GA?=
 =?us-ascii?Q?yIws8H1G4BrZwrgfsfKhd9lzkuUuF7P09owTiRgvh+U1PgfAb+3mzdziNGAM?=
 =?us-ascii?Q?tpDdygWvGAi9HMz7i7ZBXMNWFWHoAgRMA+/ZfDl2KfnfNH5d5C9zWMPKz1Ql?=
 =?us-ascii?Q?rn2xFfuRYOBEFXkBNnb5v/NIrcC8b1IbeQ1mbOPxuNYo2hTNmr+qLYXrslsg?=
 =?us-ascii?Q?Q7jDOdm4Mce7qx5qu5ZJG0RRTO7x5TI0JwCBheFeYx5A8A0bZB/2cjsjvtiR?=
 =?us-ascii?Q?egDJK+j0WjUy5+KJZKEc/DmroR+61XoTX47XD0eMFjvaEkEpzXM+1MrozMap?=
 =?us-ascii?Q?olBQIusr7xZwTyHbGHFuHlgPjnlx4b8RhnaMO/egG+qXpGsDG1AdSTGgFsgS?=
 =?us-ascii?Q?tzaZIzYVwUs6H+ECuyXoljfv5U47XcYnp+KrgicaL7moCr9sH44cudbo3ybi?=
 =?us-ascii?Q?CQIO/tvRPIxhOKiQ+IcqTL05ktaXKYoO4WAm8BDNQ5B3+1CCL8OLzorcEJ61?=
 =?us-ascii?Q?rH4uan2QEINDrHOWzbo9Ow3mJ/lCiM/7lJNIhT9ZwT+8EYT0EWSPtTyQAa0z?=
 =?us-ascii?Q?Zj2d97NFjjjAASeJzu6khoLIp4hr5KrUWDIF5GYFd/F7iYXVn1RUEd+MUhhM?=
 =?us-ascii?Q?z6ou0AzFNieRPPDSCdOfojmAgz0S4ZpPzmXO5NzTZLZITHwW2F/1mmMRnOpe?=
 =?us-ascii?Q?7GYoRd74DC1lXUJ9UhveJNOacj07MpK3443Ly5Fjuuwd6IlzjYk9VS4CJbQv?=
 =?us-ascii?Q?7k/b6wS/OGJcEeKgONt/koka0x1pRrWn9QMKHFLRsXPTiogDgggggh0e3oVV?=
 =?us-ascii?Q?XSVsHQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b34c9ec-75b7-4e55-ae02-08de2c447d76
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:03:01.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4RB/as5JojhWnUC0kUnmdD3sGAJtoXnSqGTfqgmR7ULoKxlOCZzYCGQ604x0Tro6asKsIUR2K4fPw82C8pnwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11450

On Mon, Nov 24, 2025 at 08:01:21PM -0800, Jakub Kicinski wrote:
> > The proposed maintainership model is joint custody between netdev and
> > linux-phy, because of the fact that these properties can be applied to
> > Ethernet PCS blocks just as well as Generic PHY devices. I've added as
> > maintainers those from "ETHERNET PHY LIBRARY", "NETWORKING DRIVERS" and
> > "GENERIC PHY FRAMEWORK".
> 
> I dunno.. ain't no such thing as "joint custody" maintainership.
> We have to pick one tree. Given the set of Ms here, I suspect 
> the best course of action may be to bubble this up to its own tree.
> Ask Konstantin for a tree in k.org, then you can "co-post" the patches
> for review + PR link in the cover letter (e.g. how Tony from Intel
> submits their patches). This way not networking and PHY can pull
> the shared changes with stable commit IDs.

I can see how this makes some sense. If nobody has any objection, I'll
follow up to this by emailing Konstantin about a git tree for shared
infrastructure between generic PHY and networking.

> We can do out-of-sequence netdev call tomorrow if folks want to talk
> this thru (8:30am Pacific)

Not sure it's that big of a discussion topic.

> > +GENERIC PHY COMMON PROPERTIES
> > +M:	Andrew Lunn <andrew@lunn.ch>
> > +M:	"David S. Miller" <davem@davemloft.net>
> > +M:	Eric Dumazet <edumazet@google.com>
> > +M:	Heiner Kallweit <hkallweit1@gmail.com>
> > +M:	Jakub Kicinski <kuba@kernel.org>
> > +M:	Kishon Vijay Abraham I <kishon@kernel.org>
> > +M:	Paolo Abeni <pabeni@redhat.com>
> > +R:	Russell King <linux@armlinux.org.uk>
> > +M:	Vinod Koul <vkoul@kernel.org>
> 
> checkpatch nit: apparently it wants all Ms first, then all Rs.

Thanks for pointing this out.

This will probably have to be changed quite a bit in v2 if the "separate
git tree" idea is going to be implemented. I'll probably start with an
empty list and request volunteers to step up.

