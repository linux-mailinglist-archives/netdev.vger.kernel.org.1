Return-Path: <netdev+bounces-240972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED7C7CF72
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 13:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015803AA090
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2913AD1C;
	Sat, 22 Nov 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PebZkX1q"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E3822FE0E
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763813808; cv=fail; b=knt0/JoyjxSmuchwTWiJH0BygeCWUwf8uPMW8lHSRh0WGjMx2xlMtlkFiP7l5XeNz0VihWxKUZLgA2h7bU1qRpFf2YTO6Ax/1J4HGSF/3+QNKpoOakefqkD3fAQsi/Lad9SeDgnAsyQZx+0jOGUdPyiSBCsOSNAwi1GmP4XJZKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763813808; c=relaxed/simple;
	bh=ur7NhMvjY9+FrvSyOWLxPL3Y8QK4PS22G1kekzCHTok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ddL6wO172U4h+z7wT8LnkjYewcYresqSY9+pUASilmI4gAPn5eS2+20Nbvx4jJPLVKRZgA6YUSxX64bZ/mk0fqKekTstJQYRq2P9jPD2ZiWw3QQt+UutYHePaHXcSzFugAdZz5lt5gGVzFGSLHtvctgAJq1CsG/xF/MkDlu4Vuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PebZkX1q; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMftvM88RTAeS3DoNZ9FEN9E5HVGdWNoi71nUg7u4zCVffPksBHq6X/0XpigSLV5rCmA/JwOfSXqgJ0g+QU/QDIAO6a8Zug7mpkKRn45bHZrKqa4RGqciRnjm4QltgZMCqxbONRHNyAb3cvNudND6FsN5HCClwoODrzmTyUV4OSrOGHyMGQ2QWq4kkdjUNC9I6gTj27xl+hX0iwD6VLmRoci8p2GI5Oaayo1grsAKcBGwjtn4zc/R6EPqevQtdJ6tv7HNcdOBPlTgmcjtHco0DfzJICI3yNPgV6/JshaUCiTIzysqGx9OJN/J5MhcUcnEY1sm6XUciM1VBwg71Y+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5J0OYnczJALsV9CjyJNuoDUJg5ECyMPe1zqbEwkggGw=;
 b=f6wnf7L0+vLt8X7lYCRS+DpEojfyqNiKanG274tA84dfZ2GX0EpJstHO+1aEPmoE3k+6lwEp16/Egw9tXmm3Hd/OMCu6eKwFq0r/kaaf4fbX4Hc4cA2MXwNDIV+zgOYyOkn3JFaRXojS4a76dn9h94BGMfF4v3v5at2RdLFgb0y9nSCFH3hd4ksP5SIbzvtXXCDgWK7tEKfVJQ6VR8a8/JzIZhGU36zEU/Gxx7sxvfkla946bNZEn3mgLwxpIeyXkq1Cmd8oE+GM89JIN4q0FvdgFrjSPTTgelU27ByAX77e7ta2EKiJHotWpqaAAd9F8n+rAx2rx7yXTYy4NXBi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J0OYnczJALsV9CjyJNuoDUJg5ECyMPe1zqbEwkggGw=;
 b=PebZkX1qErAt75cprIjt5CLMJpqayrFtfrvnTkcKT6y4L286Pg/aNdNglBEeehMyxb4YcB9sbhkRAT7+lyCtA8p1RNWl5nF+U/feQHjdkNgPwOJvYEVc5V3gEyO+KsT4T23615pri5bSRQl8HYBnlV3BYHQqlqvlsyUvqU1moGeNW5Ro8421GqWDJZMekUcsC4yTUh804UjDK/Ks7EqkCSV7rUuTu4NkgFJPfKNexS2EqjaDYL2l3PmbdIY61K36CNg1sbrb+a2tovxbQrEaMYNhqRxiE2Utf5GPSWQj0LePnngITxCP16S3vIxP8QaYKNtBc55xIxKcV6/iGNKwVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 12:16:41 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 12:16:41 +0000
Date: Sat, 22 Nov 2025 14:16:38 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>
Subject: Re: [PATCH net-next] net: pcs: lynx: accept in-band autoneg for
 2500base-x
Message-ID: <20251122121638.74ecrx5i7c7h2jda@skbuf>
References: <20251122113433.141930-1-vladimir.oltean@nxp.com>
 <aSGlSJ1Z_Sjj_Ima@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSGlSJ1Z_Sjj_Ima@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR09CA0105.eurprd09.prod.outlook.com
 (2603:10a6:803:78::28) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBAPR04MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 21669b0b-0a93-4c56-423b-08de29c0fe93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vKL1B8Zcdj+nObPL/hB5fg1tPqbeYMb4PWdYhw1FJsL3A17e+kFsYVpYUc/h?=
 =?us-ascii?Q?ZZluik8wSwzfNqjIne077MT8ThmyUz/QqT/KG+tzb32KsHcHesvyPpPN+0Ml?=
 =?us-ascii?Q?x6PIapGSUtobkmKJUGDIBoBRz+C2VIBMUToaBIjeOHEVnFcmOEgIkuhPxmRq?=
 =?us-ascii?Q?JM5R7RDckVS0kiOL7RJRR0b/r4AnwjGmXclQJZ2ulmdwfI46+2EJDTagajuQ?=
 =?us-ascii?Q?X0cR/aVtop49YaoiR0inGvvVjxJjw+CnMjz/BVcrtByrwfFO8D8xln7eV2kT?=
 =?us-ascii?Q?k/6ztc26VJVf+WbBeDF/BYCEzgTZ5t/p9vgF27n9KuGCovR24iIjVicvedAe?=
 =?us-ascii?Q?Z3nSLf37cmPv8mk2oNSJjNRhFk0S+OCRxwQE0k0yvKugSWZLTtAHNbyuJzH8?=
 =?us-ascii?Q?8EjZJoL8YSa6QhfHgRpxBogj8kNUe539PVIXLBcYinkNEbc+QRtIuv8XL09G?=
 =?us-ascii?Q?ZeYPQTbKSPECXU4KW6oJ9HIaIFRZ+gWxfd7zxJKPEQOM2+uU7CBfuaCDa+d7?=
 =?us-ascii?Q?JJRhObVibREz+rw0TH0OSUcDFTes/dh+oFtZkWs/5u13PG9ZtpQ/RZ+EV7cK?=
 =?us-ascii?Q?FivgAU0D8Ig/n1Dn7JYwYSXQcvwIuXqMb71UOH0miH6xq1bzUFBdA4Dl2RKU?=
 =?us-ascii?Q?V2cdGX4dPmBSjy0n5pM/PK2fw3lsL1E48ypbzkwjHYsBdcD1TJfZMY5qmwUw?=
 =?us-ascii?Q?XEbo2LAdlTWZoOoT/tK5/nVtlWIEPLq60P84q8svUUcDXFDsEgE96MNEf1uX?=
 =?us-ascii?Q?En4LEqUAcY2G/+6aH7xG0LK1QJZkx44+TKH/YSBVlIWkuFU5guRtJKKgG4nM?=
 =?us-ascii?Q?Nqt3VCC9K9+o3CvSrLRhZeGgthz3MSwu8Zy40bMCofFmD7pWsND6mKyWHw63?=
 =?us-ascii?Q?mzUHnPWOC3d+TREbyY2x4pnU/SeROjydjFmC0nwhkvubdqvh9y+pyt5vnENs?=
 =?us-ascii?Q?mKU3LfPH6mflKqH5WKHKSVgl3WWrzkL/imy9BGwf3oiXW8jgjREbrBrdi1/9?=
 =?us-ascii?Q?OwrsqzwJMHTGrNFYZlxtbOKIYR9rmPM5/phnHRs+0b0h3ySgXkY/FuTQSAKB?=
 =?us-ascii?Q?KR4bMGRrS6yM43QQDGhoH/VHIyDvxPE+j48Hul/gSRH2aN33ZNswnXZkX8QX?=
 =?us-ascii?Q?kPS/20WuqFhd1W5RkYqnW/6NlMPf/a8QuAdsYF96T+EBBIBmoj1JchDqVGsS?=
 =?us-ascii?Q?GLrHk3dkbr5XaW8eDdZWZ3UYw1hNXJZJYQ8kxggz8wCQUFlERIRtyloSYygN?=
 =?us-ascii?Q?ZQXug/JG58bouLyf4cmTm0rVwsQRmhpwCKQbtAQNqMpjs/mCzwPcW/g2ZpM0?=
 =?us-ascii?Q?0kBHXGj0OA6+8HfGh0awUe7ZIoQ2v3ExAgVBlWD2LQEyhPWV7Yq8atlq/8y9?=
 =?us-ascii?Q?OLMVccWzzDJxSTuYPP31aeCoxBgPWOIWB9Im+hGUVnzqAevyKq1O8C2grRqQ?=
 =?us-ascii?Q?RCj+Q1V294H3XwQzN+rqMHvGeQQEYKN6ysbj0snFExkbvZoPteeITA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6nHzIzWSh8NC9yfl9DAmCQ519iv7oJ4xNYVCxTnMqxJWUM2fgAhZwPwv3iQq?=
 =?us-ascii?Q?udk9wcqHWxKJFF7m+3bRz3Ch3XUK7getjqmeNTHIsQ7nVOzHYHZQ79Lddlmt?=
 =?us-ascii?Q?lternPCpjCituEwz/OFmKZ1rwDq9ykFnsyY9fyx5s8jWIsf79EO72u4Wamg/?=
 =?us-ascii?Q?hgNqjDGYPGEVF6COu1rkSn7qyiE5aVMQQAzhkZwFu0ZR6Rt6XQsyTs2ATDJe?=
 =?us-ascii?Q?/cjMRF/OJw+/0pYqgghmw67Sn3tmFDtUnPIslsF82Vv5tHevXAY/HNS8lNzj?=
 =?us-ascii?Q?QZnZLAaeTDd8l8xC/QKg5nGKduiVAGeoo8M4E7TTmYsu7tOcnG8z0kW6WnGO?=
 =?us-ascii?Q?pK0coRCh5/v0O+UYyfB8PYk2gWoFGYRPCZ7vjeoFmf37U+Uwyifw+XbQ+KBe?=
 =?us-ascii?Q?Lfb/vlr9OLHeGj3pm+em5/BqHA+E4odGAsG3mwRh6dt54rQ+UKwzsQJa9fIC?=
 =?us-ascii?Q?Lnl7lrmPPkIJxub/kkPMav5wh3b0eC+RCmaplO7PghsiN3lxBXGXORYPnmvq?=
 =?us-ascii?Q?VxSp2GRHnKEuAWmHypaRYE8x9t63bzxPlcz5SMwPrb9NJYHqRl2ssvig3J8O?=
 =?us-ascii?Q?jEwiNN+Au4X+yaHj/A+FLEowj1lWBd3z5tY2ltZ9VYuh3MlvHiNq1ngb1r+p?=
 =?us-ascii?Q?x+qZ0hRVKsO74NXoKoRySBy10X88wZskknnjHejlhwWIJCH+fArAFSQ4OuB2?=
 =?us-ascii?Q?DcjJjR1j8X2NTYQ++7Dgnz1P/03FmyV23kMjseiBqpjrKvW3uR9OiTsanIjI?=
 =?us-ascii?Q?ca1zB3XpC4A2MhZn3NF1XEAMfiVTT3KdB3iUKzyyWeFJWhVV7QYmthrSYfwG?=
 =?us-ascii?Q?OtSK2NmXkDNChxJV6EmmsvKVPUVhxQqhjJ8B5zX9xSTYLqg8x+JzkmTDLFx4?=
 =?us-ascii?Q?AhhKIsz6RXpa/o5koBHQjcILNKvE1NEF7sSjVVwWsVNq4uS/vFZHIvDc5jaS?=
 =?us-ascii?Q?9COKjnMqwa44bs47FBKihdnK9ATnRoKsUk4liMWHCYasPnXeeqWHCFEXUilp?=
 =?us-ascii?Q?xPlZV86JS/Z+7SjEpfAAKEmjjY/U4D/bYZQbHQUu8Ai7HdP75cBmW+FQQW0K?=
 =?us-ascii?Q?O60dmZ/KWiiGp5f0trzNNqoQjE3UPsBu9yqpl5kc0WHlb6WT0IQjV5mgJOnL?=
 =?us-ascii?Q?QkW+f5HWL0At8WndrBNMVFWzKXtEgsazr2K/2ruhcZdTAIkufwcdiP516pyS?=
 =?us-ascii?Q?SKCFld+XDlTC7blZmoLJYWZpjVutDrbiWjBrEupzFrjAtfambnIOWc16mUn5?=
 =?us-ascii?Q?X/eO1oS8FuRyFTaH5TXUVTVph7BzWGWnoXeJo4A33XwO8Q2AAxTVL3UjzXPm?=
 =?us-ascii?Q?K+y9hO4xvEpndDJ6fJIeN5heX9iEkAle+zWCfF56+DZ7SdEZCe8z2Hyk2QRx?=
 =?us-ascii?Q?zXw2XzzwwbIBEB4rtFPgMR/IDRtK19t8XHPnRJmHnSensrkFv9Vwpdww9K0G?=
 =?us-ascii?Q?aooN90rmA9mJjILEdx19cRh1c87iPbM5k+XTnqzEHzXdf0khXMZGAlqd/ZtR?=
 =?us-ascii?Q?cR4jhKVMcBInZ9ZkP1XFc1eqY5bscH7ZzinQQDoF949mSbNl5IfC2r2HE8t5?=
 =?us-ascii?Q?mSXnOYfu6RBY8M2LBrGZxV3KuCAcrgI4uCD+kJO/qtcqRakUjwU+ML36EZkt?=
 =?us-ascii?Q?y979eZ5kvcCgobv0Fzpe4CP8qgU28PS+O53UU1QXrQyicPouCwyysUF0Rmdr?=
 =?us-ascii?Q?EpsXlQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21669b0b-0a93-4c56-423b-08de29c0fe93
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 12:16:41.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CMNF9Lwf6o+UDADoa1OBdtyhiMQKniNnlgjjcazgue430+elSUTGj/3M9MJjTCCqhT4y+0OdDP5ObQC5gJKuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7207

On Sat, Nov 22, 2025 at 11:58:00AM +0000, Russell King (Oracle) wrote:
> On Sat, Nov 22, 2025 at 01:34:33PM +0200, Vladimir Oltean wrote:
> > Testing in two circumstances:
> > 
> > 1. back to back optical SFP+ connection between two LS1028A-QDS ports
> >    with the SCH-26908 riser card
> > 2. T1042 with on-board AQR115 PHY using "OCSGMII", as per
> >    https://lore.kernel.org/lkml/aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX/
> > 
> > strongly suggests that enabling in-band auto-negotiation is actually
> > possible when the lane baud rate is 3.125 Gbps.
> > 
> > It was previously thought that this would not be the case, because it
> > was only tested on 2500base-x links with on-board Aquantia PHYs, where
> > it was noticed that MII_LPA is always reported as zero, and it was
> > thought that this is because of the PCS.
> 
> Yay. 

Yay indeed...

> > Test case #1 above shows it is not, and the configured MII_ADVERTISE on
> > system A ends up in the MII_LPA on system B, when in 2500base-x mode
> > (IF_MODE=0).
> > 
> > Test case #2, which uses "SGMII" auto-negotiation (IF_MODE=3) for the
> > 3.125 Gbps lane, is actually a misconfiguration, but it is what led to
> > the discovery.
> > 
> > There is actually an old bug in the Lynx PCS driver - it expects all
> > register values to contain their default out-of-reset values, as if the
> > PCS were initialized by the Reset Configuration Word (RCW) settings.
> > There are 2 cases in which this is problematic:
> > - if the bootloader (or previous kexec-enabled Linux) wrote a different
> >   IF_MODE value
> > - if dynamically changing the SerDes protocol from 1000base-x to
> >   2500base-x, e.g. by replacing the optical SFP module.
> > 
> > Specifically in test case #2, an accidental alignment between the
> > bootloader configuring the PCS to expect SGMII in-band code words, and
> > the AQR115 PHY actually transmitting SGMII in-band code words when
> > operating in the "OCSGMII" system interface protocol, led to the PCS
> > transmitting replicated symbols at 3.125 Gbps baud rate. This could only
> > have happened if the PCS saw and reacted to the SGMII code words in the
> > first place.
> > 
> > Since test #2 is invalid from a protocol perspective (there seems to be
> > no standard way of negotiating the data rate of 2500 Mbps with SGMII,
> > and the lower data rates should remain 10/100/1000), in-band auto-negotiation
> > for 2500base-x effectively means Clause 37 (i.e. IF_MODE=0).
> > 
> > Make 2500base-x be treated like 1000base-x in this regard, by removing
> > all prior limitations and calling lynx_pcs_config_giga().
> > 
> > This adds a new feature: LINK_INBAND_ENABLE and at the same time fixes
> > the Lynx PCS's long standing problem that the registers (specifically
> > IF_MODE, but others could be misconfigured as well) are not written by
> > the driver to the known valid values for 2500base-x.
> > 
> > Co-developed-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> > Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This looks to be incomplete - if AN is now supported at 2500base-X,
> lynx_pcs_get_state_2500basex() is obsolete. As with 1000base-X,
> phylink_mii_c22_pcs_get_state() can be called to retrieve the state
> and it will do the right thing wrt 2.5G speeds.
> 
> Next, please look at whether lynx_pcs_link_up_2500basex() is necessary,
> and whether the speed and duplex modes need to also be programmed for
> 1000base-X when inband is not enabled.
> 
> Essentially, by saying that inband is supported at 2.5G speeds as well
> as 1G, both 1000base-X and 2500base-X should be treated the same way
> by the PCS driver, so the code paths should be the same.

Thanks for the feedback. I can't easily tell if these fixups were later
made in the thread with Alexander or not, because it's hard to fish
useful things for submission from an old debugging thread. I'll make
these changes and retest on my LS1028A-QDS rig from the lab.

> I note that SGMII_SPEED_2500 == SGMII_SPEED_1000, which means the
> IF_MODE programming as far as HD+speed should end up being the same
> for both these interface modes.

Yeah, it would make sense for the configuration as well as code paths to
be fully identical for these 2 BASE-X modes.

