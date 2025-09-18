Return-Path: <netdev+bounces-224501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86295B85A00
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E3C7B6E71
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F2330E0D0;
	Thu, 18 Sep 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XgUz+Wg/"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247E51D88B4;
	Thu, 18 Sep 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209584; cv=fail; b=ZEEc81N5woLPoJVvDUN3Nty7N+EG+Bv5UCA84W7e/SMuAbZl3AWG6K7CdxzKHBGvPmfr3RtonbezPuozzEinByu11QV39eFPJlZ65LweaLx3sENnfSrkwRgWetnIGUDI5cDiGNb7cwhbP9/4lbM9xzIbonZ6k/RcedvQVaXEHyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209584; c=relaxed/simple;
	bh=zBBomKZtMJtOccpXxSgsYfO25pnvsyq3GgXXpcSO4Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uk7jqhGnTzsjUMsLO3ro2tN0zckTmrMz5SIxz909bpxRavpz3x/37H5qsnMmCIbcryWnCp5T+JGXk2mpeswSjX08wqzd6ERN+f8I8eRg5T4wgiLFEDZZ8g8KFHLOyuhtUnv+8kN2JDLWyIZ/6M3KBQ42QNCGMRpWhi/sGkNPMVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XgUz+Wg/; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSZphNaJTQZ67xIEzBholTGgGckd6YnWV/QANTlHjkEtg/cW+qk/ptJVTjtDRz98QKwzkBjXu+6hfUecpgVGYS4VfoRkWD9SIvGi/nvo8/fyZ0Rhr8M3+pqPloS5YF3p0Zv8djpftgyB+lb8mbARtn0yaG+S8dnyvvKb18YGPT3hAkr/NngNSftpjtgSl+wDSh3UDG5Y0/Y9ZDSKBhZXjGUwCJhdvbQp7yK15RCOHUJ2mJutnqC1lLMkKTgNQR2qqj8nc4zcEuGt2LTAk5hwNkwrxYUQ08RhB2PhfSwynpU9m1ISsJ1H1ZcNShlranP1AGhQXP7mJ/0qZHcf0Mn/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMOykuDi4HbQRFrpLEPeubxN8rRsbNAAstRJvCbLgDk=;
 b=QUilntjQ+/PsVGDhUjH1Is3EacSY82B9e2UiEe82LNQ+Ze2LLVrpYBjIHi8I8NCYgqNSJcrQzwtlHHvMk/t6Nm+4xDsBXySR7hEv06JGsoCYPGeFAX79dq9tz8MZSKJooAHs31Yd97hiDN5b474umUq2hQAz0+GYbsghFbJ0ACxLm/peeRuef1g8nGrrb/Cc+e6iHEzkSDrh+BAxp5+nY6xd57JpgRigyMPnTw8gpEAA4Haekuv8NXe2X2uAP2+4HM7yIZUw8RgMMnGc+3uAQ3jF3jlt4q7zSUT6NO+bOD7YnWhZqoN5X43dfuCW3AMM11SQ39aOcK011PC1XfRFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMOykuDi4HbQRFrpLEPeubxN8rRsbNAAstRJvCbLgDk=;
 b=XgUz+Wg/lIeh/AatsHKLmXMGpqh209WaJJrKXAnOCsgUJwg+IlcfT7cauLJGWEgvxeFKY6W4TDSMz/3B9vLAGdlpzplDlvQ0jdOcCr4u1Qy6TDtRFmsCz7593xp0u0wPhRJnFyAnjQ1BHoNTWE31jeqRM6X39DO6gJpoXilW+yt3WuobePuxROu1ke3OVG3CXZ3SpBStU2C3b+S+EDWN3KJ2LEPZLvCtkKmCu5MGwt6jeKHZxUvOz++HUtp8DqhztmF6/zNflqhZxI82mIJNs/DnizWqPZdYZuEEUPr2X7eZL4JeWOWyx62ebCqsA0LzF5Yc/2/V/Jl77ja0f9N5Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DU6PR04MB11088.eurprd04.prod.outlook.com (2603:10a6:10:5c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 15:32:54 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 15:32:54 +0000
Date: Thu, 18 Sep 2025 11:32:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: dsa: nxp,sja1105: Add
 reset-gpios property
Message-ID: <aMwmGFkZS1sSQDMD@lizhi-Precision-Tower-5810>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
 <20250918-imx8mp-prt8ml-v2-1-3d84b4fe53de@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-imx8mp-prt8ml-v2-1-3d84b4fe53de@pengutronix.de>
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DU6PR04MB11088:EE_
X-MS-Office365-Filtering-Correlation-Id: 776b6ac2-f6f6-48fe-e02b-08ddf6c8a2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ypsaKet77XXyW1gTXutX3trZX73418IQVo2lPhYzEShSIDfJT2K+GDcsEALP?=
 =?us-ascii?Q?SrgkHM8Fr6mF6bttax2BTrE2bIWBOG4tQsB8K1fUtazNjMc6DXwWosEMBG51?=
 =?us-ascii?Q?ZYJdjuF8x0qzc1H1/c2ptAiDEiLZz6FM+boC1mSQ2qLOLx8/JahiXU9zMp4R?=
 =?us-ascii?Q?b+u5s0BixIfXrdFk5QstNZmTC9bXNHYYaw+ZnImlbr+HnBTvAWtkvbT0Lswz?=
 =?us-ascii?Q?d6KkLAZL8wYM5H/6dsdJMp09z6Pal+fOOWIJj0piC4mt56WhwzhUngStZeEL?=
 =?us-ascii?Q?JCQAby2uZ27cG8n4Qr4XuckHWUcWnTE410AvetK5w/87fnfsVhUTtohKs/GF?=
 =?us-ascii?Q?0wEfkKA6VeiiEPsoB7/b+tnmGF9EcUe148ZFHf2uAQcYR+YZRV/yv+gqQPlE?=
 =?us-ascii?Q?Vb+yNa6OSbSMZcXGCJCnlnSQvduz5W5B7VttjT50WC4WEDNzbxqxkhCny+Yx?=
 =?us-ascii?Q?oNnGDLPKeuQQq9ggc/Tb3LZBtT0X+6bO/pEHZwiL0ffeVDrWKoIXymXBHmrY?=
 =?us-ascii?Q?X0wDmZXhCa8qFETUYoI3Lsb2ApyWjvL2QO/Uia6KvuLeCBm7wEnRugA1xw15?=
 =?us-ascii?Q?YwvQHEJX1hcbdedsFstSy1WAxTVlTtzqi5cT1isFqHTRCPONqi1f6iNHt7aX?=
 =?us-ascii?Q?IUL1+aFT+EzNJ10sitU/Ms0Jr3LEPbWF6TMhQsLrTh4eexjBVX3Xx3Yj/YfL?=
 =?us-ascii?Q?pK3bbD+RNYoPbFuHpDHnWCkowa0DejtTOyL0hLA+NCM5qTLoHmcutn9UISJ0?=
 =?us-ascii?Q?tU98S1bPNvOKAf97bA6jmrodd7m8hD0KCTmv7vBxK8Y0Lmj+x2CKuHWN1QX6?=
 =?us-ascii?Q?fhu2O/2iuO2nPMXaNkLrzWEaZLgwJQ22j76V3mK3XMo3JnuW45TFqQt0p+Ar?=
 =?us-ascii?Q?s+zBzp8M1hqOyxk8FhXft0CHKHxhdzOFl6f3xR5LqBrCIWlI2Yf901lSZXHf?=
 =?us-ascii?Q?dE5/oEbWl3KOX4WR4ixSN/A4JrWX85inWZP64lPRZE5YFgq1v8B++1dgy9QS?=
 =?us-ascii?Q?nwyE16x9kOGZZC4gcrjcjFXts2lqPKEonoL5cA8ok44Ndinrz/KiSi5GcQ1J?=
 =?us-ascii?Q?r0uaKvrcUcAa08e9wZ1WS37zXhd0mTeZ0M9/MkkIRI7xzG+98CHfLnywV390?=
 =?us-ascii?Q?7B4j7iGznUSHlIo4/mIWsEhn/DJorkkbX2krXHzSsgn2Y7LvoENuJvm80ulc?=
 =?us-ascii?Q?xYqz2efjIWpGwBnW2yq4Salqu+0Sszt0DXX4knMbuYlpNE7H7x5T81dY33vB?=
 =?us-ascii?Q?GI05E0mm5CFGYyaWWzZ+dNFzNnxXyfLscjJz+RBI8wrk61MFDbcUX1SdJONx?=
 =?us-ascii?Q?K/z7xBkwpPUc8lkYN+ftgkDPDVNhnd6onBtKKsr6JYU4cQrFqzUlbOiNDcla?=
 =?us-ascii?Q?mmMDYEhX6gvaxnAOv0u1GOWRGUk6oz/uk5UXcUr5cYvycFgR5Ek/jeGNJ7uU?=
 =?us-ascii?Q?8nh7CxBcerSfIwF5tdr3rmTwKftbVDc/uBC7I55bUAg5f4VUS02xGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OqDbd7pL84eptzMUqedKThSDnKuvzkMn1zwGDrurGr8xdlj+ry+/An89MTny?=
 =?us-ascii?Q?CiWBGo+mYUuPO3oVdNFU1DlkeYmsBwXf1WCYzaaZaZaGiyT88vzkltyGHH+5?=
 =?us-ascii?Q?GOYmvRwREdFftPvqAW2Tw4661qr8EEgiw02JxVSNnxYP09h3ZCdLw2OYvqpK?=
 =?us-ascii?Q?JMASF4sqFRpzcXPHcUAqAfVIRX6VZj09x5woPPYDgl13gFk9pZFpvgrqG/0Q?=
 =?us-ascii?Q?IFP+hSxCqJQS/PQhCO5lrwswIX3vUitNUyEroQFEss26XS8sbUGEblsrnqg5?=
 =?us-ascii?Q?n464JX2XwV1C1lE5UhmAEKsXB+OU6l5vkeUvU93OEHAIkhxunnIqXLzNztTu?=
 =?us-ascii?Q?wYvJ1aBo00nwAbmH2AjXMVG0bSqjj1TReHOEyXFBz3CgIo8X8z18/RZdKiu8?=
 =?us-ascii?Q?kTReNeP5oEFKZM1SC+EDOsPG1TSgQxdPiMUFVpwXr24FbtabDl9+PncIoLPu?=
 =?us-ascii?Q?7NWumg4p/3/pEzHMsYDi4Rr5s1dbsgBudXHnqiAXFnl4LhZaSHI3ZZuHtfqM?=
 =?us-ascii?Q?jAOtg9u9Rf1y9Hgppc4iCIry7meLHCDl+wQarC+CH1KZMBHDgY6vyZDkBcrN?=
 =?us-ascii?Q?oEDQpxvxu5ZIVHRl26t4DaZ7Czd+Anx9QQk7naOQcXItO2oA99kGws5jmAcg?=
 =?us-ascii?Q?8ysw5j4ESyc/CmARuydl6xKRM6somYiHAh+EAPfvop4PcsRLeExh8IZ1eIkO?=
 =?us-ascii?Q?1w17S3jOModqsjydC6+lgod+eDxYIQa8ElOddCl4fyz22Y8DtlcT9o01Qhnc?=
 =?us-ascii?Q?b8WVUubwFDhDJLhDvy2wEwCrUddTA5Wo0V9Fv5RSU1fcQ2wwaxidy9wpg9up?=
 =?us-ascii?Q?a6xZam3XSgz640XF5hsXFWsdTdgPkU79MJPzHlqQxjTliQ9sFCPLIUr/19pO?=
 =?us-ascii?Q?kp71UkZt9uNHU6r9M7daMKou+4ZkSDqPWWQbkege90paeO9IGZmcuU6Pew02?=
 =?us-ascii?Q?gB/VBGjhJM41EJE1PSwp9Yy7DfEg3Mzsvz3g94EIuBAS3jARFAqMhbS1Hx09?=
 =?us-ascii?Q?RMtcW3A2pZOnY6GmbIivcK18xohMrwKrTtMQHGLDpRoyZyPa5Rh94ozpvPal?=
 =?us-ascii?Q?qbAuCY06vHRFxzlCGXKJR3B8H4uaQfL7qr2mcAoCogbkK5kN9YQf3zxUg72Q?=
 =?us-ascii?Q?jTLorziKApc/rh37xWJlJ9y3Kp2XX1LPYTABuPPTeckEUVYg31ZtiMRRNk+j?=
 =?us-ascii?Q?l+iF8h2igxGlADfkEQLrBhyhezDHLP5ndFjLVwLl8XivpiCUVvBt3zBpnr4s?=
 =?us-ascii?Q?APnX0P8PVK4IqBeHJBn9tZs6eYbOgmTmbcQZaAoxSxZdlS8G+PDHapUCEKAh?=
 =?us-ascii?Q?FS9EKv6ZZCMBcmhWvzyRkYriatFRJKyuoHk4PRxcLVUAOOGl8Dq8mDOiGTS+?=
 =?us-ascii?Q?6DlGMmKsLLEZrM4gVFjZpIrEVaSo8Tm519DChYEJlYGegcKrGfEfrt2GvbRz?=
 =?us-ascii?Q?vDMNxE0aAuR7igFH+Yx9I4w+dENiLHANNM0z5Bo+MGSFuqMa6KkHf6XV5iG0?=
 =?us-ascii?Q?LTe2JZveyJRLZfZQEmpD93aaqJM7Pr8xCLcyrfgdlmbBHFp55MaisotfDKxx?=
 =?us-ascii?Q?VyQSf3kYpML5MY3FrLH5c398sM5GXl/j4CeFcDTv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776b6ac2-f6f6-48fe-e02b-08ddf6c8a2dd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:32:54.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCw+tLCfiyMUCKmr0G1H8f/VMdcAjZPWJD/bDO8vryLH9fQCN+qkLO8/FBOrLZLjXRavYeervg29eyTxRmaCTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11088

On Thu, Sep 18, 2025 at 02:19:44PM +0200, Jonas Rebmann wrote:
> Both the nxp,sja1105 and the nxp,sja1110 series feature an active-low
> reset pin, rendering reset-gpios a valid property for all of the
> nxp,sja1105 family.
>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> index 9432565f4f5d..e9dd914b0734 100644
> --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> @@ -32,6 +32,15 @@ properties:
>    reg:
>      maxItems: 1
>
> +  reset-gpios:
> +    description:
> +      A GPIO connected to the active-low RST_N pin of the SJA1105. Note that
> +      reset of this chip is performed via SPI and the RST_N pin must be wired
> +      to satisfy the power-up sequence documented in "SJA1105PQRS Application
> +      Hints" (AH1704) sec. 2.4.4. Connecting the SJA1105 RST_N pin to a GPIO is
> +      therefore discouraged.
> +    maxItems: 1
> +
>    spi-cpha: true
>    spi-cpol: true
>
>
> --
> 2.51.0.178.g2462961280
>

