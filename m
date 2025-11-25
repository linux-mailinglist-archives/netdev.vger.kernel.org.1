Return-Path: <netdev+bounces-241655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4E5C873F0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FBD24E2B38
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E562F7AC5;
	Tue, 25 Nov 2025 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ER/3c8+M"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE7618A93F;
	Tue, 25 Nov 2025 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107100; cv=fail; b=SQPkBnlSm6BKYRm9HXvJX7R20Fw1uwskFwmOieR4zUZNOc3slZ5TdM2NonIHtvovWmmZseyOfgqt3nODmSa6pboik9iV0RGyAzXx5E9JSCsvoLse6usunJJtN3iZAGRyfWEag9Y2ZL0MRcUEOp1YTOzvcb4P7iZlgT47OQOo5Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107100; c=relaxed/simple;
	bh=ev+vVdFsZiYqR+4Bs8IcelkSPXK7LYxop4apt99X7u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tqK2PxmzzplE8s/sPeL+byT9Nj1FZ9vH9cGkCWurbWcFHopjcJMOO68zOFgUTLtcfRYembeOpdSA8MwdKKfL8B7B3OI4R4Je801sR9bNqMqddCNw05zlkz8d/L6K9uLzfZz6eLcu4PxlONbIGGwkayPBbxRyMsYYEGylNrrwLis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ER/3c8+M; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dhx3hZSdr0D6s3zmc61Ez8r6kp8RWcYxywgHTWnnRh/MKC2D3au0I7axMY3ssmQkA4AA3JbnumlNhjwuOJcDPcjkR2/0AcUj9Plecz+ThG7MCW1xZ2IXXd9grk4VPU3gHN2jJPBSASw2GjUPPXC+EfqjUY2kuewKKd4exyF65sSj+D1OoTsxyNTAcIeGCYboWYzSzLRnEJUwoQVR2OVeOAz7/vvPlEwyBNq7s/kmLGqb9dMvYhjnEAxNgMczvE18A88OuLUPugEkfD24ZWApc4nrgh5pl+fN307dk1CnIEK9g3pBdheD1xNYx3jGOOuu15vdFqY6uLMGwW/QN2maoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AG1shA0j3bUHARCntHD8V8KMf1rvVk1+J6RFUmVxzYM=;
 b=i+IsjSF8/DjIw5+J3M8HNE22sDQhmOip7GmPnFRM8mdQ5Vr73RV847fyEfqsox6KH/xRAe50BjCO9Yut+9NZ8fQ4Tbu/waJoG8U7p1kOJjdE1Mzl5KhCvcfiunQk2EFl/j+E1m5gm9nZNJpGcH76spUmC0t4qxg540auwnyf/RnBsPY35EdiViAcUW/YcP5InW1g+KmkYeaEhzF3SRMmTxids8ed6DnieoIJE30CqHpXCAmV0hs/LAffgnASYDXCRSuoid8PvB2VdYf2VR4CixbQwHdW2dR20mCv3bYohgkLoSaWYv3vxvy2m4zbbLqGlwsoqVTRCulWf2VGGs2Ctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG1shA0j3bUHARCntHD8V8KMf1rvVk1+J6RFUmVxzYM=;
 b=ER/3c8+Mh+ARhBVlNqXIKE+Gw/+02uLeZucWmV47sC5PTgBCcux3VrWCMoIJoOFYOtmx+Mur1PDSaCbagT5j6zUNM1nxqZ4P2+x9THE6YB7YUaXVnK5FiPKSoKRCvqmeejABZeebhHt2rHeGJaXB4HPHQ7moca5168bEXuYeMnD5fEoPAKSp4tZZTEBfkZrMDv3uUzD7dA79LHvlYEDwj3Pi5l/AlY+RtR+gqYUo71PUQpDDbnV57X2tBaICOxSE2NXogwgQzcrjufVbeRhbsQZSsOQaxJXH1C0evilcP7oPH8LnmlA734wFmOZkeWjz4ObwSA/Lp2tTK/S9b1JveA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10)
 by VI1PR04MB9932.eurprd04.prod.outlook.com (2603:10a6:800:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 21:44:54 +0000
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18]) by PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18%2]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 21:44:54 +0000
Date: Tue, 25 Nov 2025 23:44:50 +0200
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
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Message-ID: <20251125214450.qeljlyt3d27zclfr@skbuf>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
 <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
X-ClientProxiedBy: BE1P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::7) To PAXPR04MB8590.eurprd04.prod.outlook.com
 (2603:10a6:102:219::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8590:EE_|VI1PR04MB9932:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef08063-dc2e-4e6e-45a8-08de2c6bde8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zxJ0pZQvUZmN2Y/tVjj28eYkViT1OZEoLBXGBQKAPyzqdKTj3IUHJ605P0TQ?=
 =?us-ascii?Q?Qm3IgFcBxgtxpfR8WyGS2/Ipz2XbJuOfcTH6BlB2NyZpa3nsDObfkbMQ7Hop?=
 =?us-ascii?Q?KuFL0ayPPyR5Mo6d9/U6aBbkvGOd+N62iDBZTLLKgxMCQo5J5TlToRB66uy3?=
 =?us-ascii?Q?KP6H/A1QpVDgqH3PdutxFg2GGbcMQLE7eY29fAQyxcM+9UXVts54ocgKrSCa?=
 =?us-ascii?Q?3LwvLkFFf/ztIj95L1xoB0GBhr5SMml/Y9csDmKmF2494cy6wyYkPiHU+qXO?=
 =?us-ascii?Q?x5lpFLocCyF2zGw9zlAkhqIqCO8cYo0c5lr9mPfSAXQ49GYfu78cMfi8piPg?=
 =?us-ascii?Q?LPcxDpkEhamVnAi1YlEWfcaPMUphPeJJXY1MvvZZOHHTlqIqGMrPSpmj629T?=
 =?us-ascii?Q?d97HBqfjQE9UMvezVHckUsspZg4mOC8XgFlfmoXy8nufCuAFt4q8XMo28tAf?=
 =?us-ascii?Q?1o6IllpH/dAEJx/P4WsFnNNAhM2hw3qBt3PCtnuWvwRQ/gErHsjH6L4mnWix?=
 =?us-ascii?Q?h05PD50GtGVP3z5fh2jx0ntAUfThD0y2vfyHfwDh3VI9DmG0K+go568NIdli?=
 =?us-ascii?Q?X6x2b+UEbzHxLO78Exn3vDSbBwDjlNXGbUiBUVLbPWqIDyApU99ed5Yb/0B2?=
 =?us-ascii?Q?aK58+Uxwx3MEbzbmwFqdA5Wk3XAH4GvlPALTxn8eh8Lr8OZbTfQfQh9BECEs?=
 =?us-ascii?Q?DOIkcSKKC4GZhgPkW0ztgiRTr21J6UVoS4XUFidWChq8kD+bLxexepBECPy+?=
 =?us-ascii?Q?OWTN6H/LijLHeTbLmjf5grJs2u7ExI8zJ6M4bfzWLlF8oh2ERjkmqngawxlB?=
 =?us-ascii?Q?wIzw8sjmhi/fgGfEjKTn/rSOfFw2AvYdD9nmwLgv1oVy+rW8ybc0eWcgB2Fg?=
 =?us-ascii?Q?elEsYAz/5uNw5JQnGqPyG6Gks36VqVcn6xpsKYwengTQsufJ6AC5bs0WH26l?=
 =?us-ascii?Q?F9mMWQ9cfvxtl3fytUKAFAZAlrkCcg3zdhYZr7fQWmvrZo3MYHVGwVuFPPnx?=
 =?us-ascii?Q?PJTad55oXs/Ln8c4fG4oKI2MzxpfIN5C21nSDPSgR3SMjm+gJCzylUU1Lzsz?=
 =?us-ascii?Q?uytnFcTLPFRbwW7qlpPtzCd6ihYbhbzwYH7+5CLhUxz882ajxHkV9jE5QxhR?=
 =?us-ascii?Q?d/++6DA0wknWVuRtg3orCo1oYFQJAhD4GzX5EtV0l2GF3/g0Obxey3ZGamY1?=
 =?us-ascii?Q?eWEHZF5NaOXLGDXb8GHltfCyR3ULPDLmlbH5Cjfk/RFMIkQvDfHxp3mMaql6?=
 =?us-ascii?Q?hdMEz4RbYHxH4FjFSQ2a8xxUckDyywiP2Uz5bomKMUdnIr89ewCBASuEWM+N?=
 =?us-ascii?Q?8drIfNZHaFj1/oS6Aonj4PrAyBDWOrJm3Or+UOzGZ8RtuBfZbrIfr52sA1Xt?=
 =?us-ascii?Q?qX6+KHvqSgDV0A8QXmuIzEFiKxlbyOp8uEonUrJzxEe/lC3RFSvuKQqupD3M?=
 =?us-ascii?Q?o5vJNVNlxdk/D8EqxP+fQFMbrrOAAtSgUqofxGxywFQR4smV0k2T6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8590.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QlrCeeJ5/jXw/mE40haKq0IPpD9QxWV7l3jrvE4e+ITi/g5W3FfYKTqV4TTZ?=
 =?us-ascii?Q?0Bt2v1CRppaDknZ3i1y5HXPHCTLLnCSlFBPaCVexlOpwTayOkX5HiuGWVssx?=
 =?us-ascii?Q?7FaTxpFlapMHEC/zHIRgke+l9CdDwbOVS3NkBRqHiBrJXZBDGTbAwEk5uSXi?=
 =?us-ascii?Q?UUgcg9zOIm3wUTNqo2Smtfsh485+lEM4vTwDsmI14+fTOW8h8P1Ki5Zg3n3W?=
 =?us-ascii?Q?ySqTGxSB7rXJIzTd7XqOOnKTHNAFMw4VPOnMVyKdgToJrgCsm4MPth/IOEkY?=
 =?us-ascii?Q?AtW8iv5BiUtAxmsaQrprlbFU4aHB9ikxsEUgwZ8v67CuvDjjbMWbctgiJzHE?=
 =?us-ascii?Q?UcpKUMwckpieKE6IoUlCluv3q4tT/KXNWrfm17yh3SziXuR9TWxJ8zqOAIdk?=
 =?us-ascii?Q?19NVdG20eu6KTuQO9fc60peHnxKuQl5spcaIVCr8pH3fNm9QUs4ceg9dMqQM?=
 =?us-ascii?Q?JcPAjeH4k+uY6ghRzJb4r9EGF+sM+Ey68j8kIZOsTdsJIynQLxdJ1+Ho/N3p?=
 =?us-ascii?Q?n5ZfYkxXK+eu9S6dYrqzqeSK6oUZL+gEC4abzB/nIkj2bH5Pn7irabq3bQ1c?=
 =?us-ascii?Q?zim4wTMlteCRy7Dt4bIDfvRZzvf0ScIYrznQ/YkevrXr9ylw8oEMS1593lpK?=
 =?us-ascii?Q?TykIVOFLGJPueHWFqfuTUBqVpwE6ed5jrecF8Fz+wr53g2g+ptgWchYzNWeY?=
 =?us-ascii?Q?cINmL/xRmUl8ektXTMkrE7cFv3pr03APmaJe+iuuJVpPF8z5Sogoi57UpEIz?=
 =?us-ascii?Q?Y3B5ScExwOnPPlBL02HtLBQhR70SFOO4VszthR/3TclmIAhXq+MuKWxAAveZ?=
 =?us-ascii?Q?CmZVxTcGVPAr23SvIQThhmWL6Zz5n5/F3/4+myduR1BiHiGEXFDzyB5jTMaS?=
 =?us-ascii?Q?OIzFJTaQLuuLck1ivoTYb/IGJ03LwWzB+xBK0jewYbHiEhE+6n3GxWQqmFKo?=
 =?us-ascii?Q?NxPbnAIN26xUVgcib2fWTxEQS00R2dl6GNmij0xKbJgUehr/MTdkS91mrvZY?=
 =?us-ascii?Q?cvDkAwuyAzxZUKrc7vg+xQGMaT6okE91xgpoJW6BOSS+lZFHH1CmmSPKIvgn?=
 =?us-ascii?Q?jEp/52F9Nd9I1YTT1TFsee202qnfM/w2NhZPRapYgZ9xZsZKuvI83MnjRloo?=
 =?us-ascii?Q?J1LDUd9geD+JaVMqK5tipi2h/YGpUEAy69qSVfPKmK58/+ZZUPqZZ1Rexqhz?=
 =?us-ascii?Q?IJuvEvi/v/NWpQ3x3ksGrKecDCGtE4wx0bd0oaYrh2yOHoNxRBWmHa2FBLdk?=
 =?us-ascii?Q?/RobLPGgm7zkO4UcY4geMJhuyQUB3WCBbinLO2NLdXchIvNZnUHGyxarC9EG?=
 =?us-ascii?Q?Yt7fDIz1urJFfBXyfXuEEo6Di9BEpLe0A0+3IqlLFB7AI2G2VM7Y2LVc/Vl3?=
 =?us-ascii?Q?kkVBLGGi5WVXmeG4ayV/yPF4UEEJeCZ0SdnOckUoJqvcNeML17X+/FmDcdGX?=
 =?us-ascii?Q?ACIHfbkSuq3pqK3vkeIKf1AcAYQn7sptntA3K/bfP8eAQhhYtx0Hpcv/nb0A?=
 =?us-ascii?Q?1CuV3TA6wqKTgJ8WaUcEwhNQYwYljR769aPNFF4TalOZRlwB+a3+uChG+u2l?=
 =?us-ascii?Q?Z/EFDVzvWgGBWGMS6TpFzNvvfERnZ046/ZoIYc01ewpG9NByf14feuWNy66f?=
 =?us-ascii?Q?/38jowpjQ3Dix7pananJw6cCGWxvf0Wsy6Ka6TLMCe+EXn6RzME5sanvmWU6?=
 =?us-ascii?Q?zlnKIQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef08063-dc2e-4e6e-45a8-08de2c6bde8f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 21:44:54.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12vF1x70bYUMNy4TPiSMCD4zYIRLcVYqS97s66WL7/mw7q76r2KIC5uCGHTGsSO3FJfdnf9R+D6V2mRlCUaIVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9932

On Tue, Nov 25, 2025 at 10:19:11PM +0100, Andrew Lunn wrote:
> On Sat, Nov 22, 2025 at 09:33:33PM +0200, Vladimir Oltean wrote:
> > I would like to add more properties similar to tx-p2p-microvolt, and I
> > don't think it makes sense to create one schema for each such property
> > (transmit-amplitude.yaml, lane-polarity.yaml, transmit-equalization.yaml
> > etc).
> > 
> > Instead, let's rename to phy-common-props.yaml, which makes it a more
> > adequate host schema for all the above properties.
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> >  .../{transmit-amplitude.yaml => phy-common-props.yaml}    | 8 ++++----
> 
> So there is nothing currently referencing this file?

Yeah, although as things currently stand, I'd say that is the lesser of
problems. The only user (mv88e6xxx) does something strange: it says it
wants to configure the TX amplitude of SerDes ports, but instead follows
the phy-handle and applies the amplitude specified in that node.

I tried to mentally follow how things would work in 2 cases:
1. PHY referenced by phy-handle is internal, then by definition it's not
   a SerDes port.
2. PHY referenced by phy-handle is external, then the mv88e6xxx driver
   looks at what is essentially a device tree description of the PHY's
   TX, and applies that as a mirror image to the local SerDes' TX.

I think the logic is used in mv88e6xxx through case #2, i.e. we
externalize the mv88e6xxx SerDes electrical properties to an unrelated
OF node, the connected Ethernet PHY.

I note that referencing an Ethernet PHY is done using "phy-handle", a
generic PHY using "phys", and that the two are not the same. A SerDes is
a generic PHY but not an Ethernet PHY.

I looked again through the most lengthy discussion on this patch:
https://lore.kernel.org/netdev/20211207190730.3076-2-holger.brunck@hitachienergy.com/
but did not see this aspect being pointed out.

