Return-Path: <netdev+bounces-221662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DB7B5175E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E97E17C084
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31A31C57E;
	Wed, 10 Sep 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UAxN9qM9"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FE268C40;
	Wed, 10 Sep 2025 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508988; cv=fail; b=JqX44tR0MszmZcz1P1v+vxG1qtfhvAIO1+4Ush/UnQpxKQyf6UzxwONX5afFFkhYm6EkvwECLZIaBfY9JQHNkLHXIwqPbyW/uc9Dz5VOGqcLSB2RjIoNqnMKYA7FQO7DdtB5j1LsMObYV8qX7m+7OOnYFWxadKWE/d4t3Jke0/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508988; c=relaxed/simple;
	bh=UvjhirYmNspxTirIH8Pas3MjU/OszhOx3EVPA9FCptg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TemZT68dLkdy52RmoCIOsBJHsga9j7WnUZoiibXYVCQH7PQs/U/M9Mo+sfg1r6SYg0iQiV5SEwLZ+HBct4JcKJ2onz3udOMKJtJc8aC8UvF3Us3JDPps7O06swFcJ1pT/FPGeZqFvy7DgwIRfywKi3mWwmQQJGe9OouTavNgQzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UAxN9qM9; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPS/+GABMqz6KIvke4Th4ZGyGeW4f3dbYXvCpsFB2ZUj/5ADEYgdpfE3G50WzmHXoEVO4yBOHa7PZEMKoY08VAnOi9WMu2vQLXcxEmZc28b+0zAUJH4jIO8LM7w6uwzfgFjSwcflnQzHS1kUzKbxPUk8lZjLuJm2a+VT6fo4366PAtEO6dOz1xNFe2WYGeg6Kg5nIF3Dl/ULWoYepqEVElIG81/yaFaSutE+berVaz4YBfEXrcvXyN+nUV/fgLb99GAamw7Ea6RzBp5rz2mLOvAsqOOAQEHwAkAoyRSQl2vSWNtfPpCXyWF/CUYPxxPuF/3rGc8Ay1NXGPlpdDGKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFXOZutX1Vi0xMe/kOL/KErN6/8U4s8zZBGtz2sACPg=;
 b=fxDTgEfSooakmv8BB8jSpshzRPzOED7uTxJaseBJX0i+KoXkkEGppYPAFTKXSE/dM30lPBzXVqAcxO/KVEZbTMOvvnYv6x2t8QUhQOeLlGdHJszGgHW+bk1M6JVEAjPXLcx6xNinCotOCAh3nStkrDFXiQLh6iDLbrI/jiHuJwta22/Q3k0tRDAwcppzYPXIBRmWcs15WucSgoX5H2cHBfHAbPAWkxcDDBeubv/MaPR7d/HWMA5clCX/hRmtTiQDDH2aZzYdZOwIwx43UvJpis2LMfmXbkAZlQXByoKW3TxC8Uufw1w1cxi0C2bzWSS1emsKIwKxZQi9i30FsCGn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFXOZutX1Vi0xMe/kOL/KErN6/8U4s8zZBGtz2sACPg=;
 b=UAxN9qM9tlLDSb2qo3QajfUmCtii647suq0bb7eBRhp7iQyGIV1B2NlH0xwGZKvEIcS9x13GlfkYY0Q+ZjxnpzaMyLUzggbXSK1FNNzeWA0MGjQG+PxJBeqBMVpQTKIzMJUHbWck64XiRvznXLFkpDsGU9re9jB1bdk4wRiyHLbnldYF/oz/kzdgW6Jqc1Qo6TEp5Uq1DytPnUnrPzPuZYciDcxYLIBAl21w0eMMIj+P3lctcm+7Xw2DB2QFw32l7piCko67Pm2bCFtJtIwagIJuJRZsLEsAA/lvkhSPTmd9wgC9fek3vuD1sWlX0Q9oq5NZ120xUXIwjcGclYDo9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB9178.eurprd04.prod.outlook.com (2603:10a6:10:2f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 12:56:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 12:56:17 +0000
Date: Wed, 10 Sep 2025 15:56:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
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
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
 property
Message-ID: <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
X-ClientProxiedBy: VI1PR07CA0299.eurprd07.prod.outlook.com
 (2603:10a6:800:130::27) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 435f652f-a850-4960-9d4b-08ddf0696e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3V9ZkXMFXdtPZuZ42X84m3eheQVJdEStyJIRjKdi6D4Z/H2QFK2W1y8GW63D?=
 =?us-ascii?Q?6IyR2eFIFoW6fl03/tz4p1QhAH971b3VYp5pYOcwmUEg7U3t6P4MQYp6dL59?=
 =?us-ascii?Q?DU06jqUxUZJRimgdrVvlEkO667HO+xZRgmiCf7pZDW/LRFhnOAnayX/blRrN?=
 =?us-ascii?Q?EyItIT9kQZciB2xeNJXDotCeFVp8vU73uoe4HOq2ECNbgWjtDLaJsUv3sEbD?=
 =?us-ascii?Q?NcM01TEXD6iW4fDDvQw7WU1sYg0iOHqSuySygy1nbuNPLrSydkf3MhTA1Nfc?=
 =?us-ascii?Q?w983SEUSoY9dDcNOmnAHNdU27dfVpKxLCF2YpwelyaR1FokuIuPzhjahhefn?=
 =?us-ascii?Q?xe0o5bjLS+QzbaOi7nDQMBrkbbhpbeiqE/9dXR85148oR/kn4syXDuz4zU1Z?=
 =?us-ascii?Q?AtmIunMIbf7Zxbkij6C0ARot/Co8ra+eE4UUJzzaVNxy1TTKlpIvh9v4q6rd?=
 =?us-ascii?Q?vEkIKS59RigdR/v9E2FZOQeQOUxTyH0vQ0oO7B+7HGG0hm9xTTnzdo1Sg9JT?=
 =?us-ascii?Q?rvP9YJ6KWEgvMfUzGrlG0DcacvsULZtbCYtxPq6xLocxHRInFyxuH/VynLxo?=
 =?us-ascii?Q?58Yw7wVOL7pLHuYqU+Q9g5dMh8ik0wptxbYeS1nTBJPK2lXVPg7a+t0to3ko?=
 =?us-ascii?Q?I5Tfq2r+r1XOznvLnW1mbvrP3netXWQpeiB0O9Y3ElpgK1zdgrI/V4eCSz2C?=
 =?us-ascii?Q?s6t4F3LvSrw0jDFQGyCon2TdYIc1g9oPelAHFtiM5/y8z3Qykx8V8k/KDmwZ?=
 =?us-ascii?Q?rGZoy/QTz+CaxpvA9Qzx4r6dy8OOBlNN3m4kGZRJPsIpZTk2h/SZEd9p+a3U?=
 =?us-ascii?Q?sCAYIQd100vmxbOnc241esLRvpfpxq0svG+eJwyBqaVWohu4idM6wbw3YJmL?=
 =?us-ascii?Q?gAgn4fJRUyr/SJd1GM1nL9C70IjPwax3Sdv0soSsay+9nJNyt0Iz4Bxqb3ps?=
 =?us-ascii?Q?pAJsqPZXM3NP6Wifr5oPo0YgdDvIKA/WpOzgB3RrS5+EpQGv3wsH889iz36B?=
 =?us-ascii?Q?/LQUu4Bo5vYbVuI6IMftRJiglnCN0maSE69cmBqJq/w2aNOyUA7lIhsVSDUp?=
 =?us-ascii?Q?w24ouqFsuQ7Jcxq5Odgj4PP8aim4ft4Sj6XPuTkz6vl8gqQL1Z/q/BLBaiPZ?=
 =?us-ascii?Q?EI7qaGCuIbSicpnnbkjDiuNNohgvjQlvklK1Z/Lj26joq/zE3ccdGFGeaZmI?=
 =?us-ascii?Q?k6Pu3Y44jxAfHl0OQKQePnfFneGc35Nzk1xRockmvMsPInhn+nPz68sY5LRl?=
 =?us-ascii?Q?x6elTdZXDN2y3k5kGNqZ4ckDAwxz3eSaKre/WcDEwxFO2dVs2hDyyDGtd+47?=
 =?us-ascii?Q?PSgzw6QfHX9JfiX36WwI6BH6V48FYT8kTJ8cHDLmEiTgoWZMZFrdE2GwkTzp?=
 =?us-ascii?Q?jZYULxkrT+oooPQryRhXQXqaI5T4YmgODCKfcLBheBSVlTVAdEmgAx6iJdeO?=
 =?us-ascii?Q?RswCAPuzC/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+tMvpV0Egjwv5O6seTTB6Up/YHHbDH2TbODRw6keWkm6Nrij6Rlm9UwTFhmp?=
 =?us-ascii?Q?csGwQHK6tyVcF7rGt/46x79eGPbh0j7uKOxdKKZm5uMZgtBD8mJ0nHWvFzib?=
 =?us-ascii?Q?1OTptMh70wgOiZ5nbaliKc5SF9idI7ZgH+MKbwxYoKDzDzQta4IX4koGagYv?=
 =?us-ascii?Q?4MTtSwo7AjTKinIEEBcLe7eJzrywHjxRaUjmS6TYXrWBdG0J1RzOuD41US8K?=
 =?us-ascii?Q?7jh71RsizGI6cqT+1JgQHf+4r/y84Ds0Z4gpSgNQaejO0N9ss/4HNAG9sQn9?=
 =?us-ascii?Q?OLFVc/G8lLgtsxuAWdeg6PKK6mdP4nSHTI55s8+BkfzHCpO+vxCAUObWXgXY?=
 =?us-ascii?Q?UEuJSZfgdk26ZysQqdWlOic1JntE1v/KTWGlv0xG3tPICryIZMPkxg6FNbnj?=
 =?us-ascii?Q?FfOp1b+50mPDgINYR/c67ienkkTTHr98T9ytxYHzrYCls8+1F6kiC9OEEYHj?=
 =?us-ascii?Q?wSASkvOloKFn+9gj0O4uNbg8lh9JMBJ6NriZGqviWbwC9sFZZRPZl7wfroFs?=
 =?us-ascii?Q?W840ExNpDUaF3k2OadjllqkX18xorYcR/eA8Y6vcMpKM3SwBNbXVeibaZYDV?=
 =?us-ascii?Q?aTCGigAXx7pdctwTK0ys/3d0v/jzNo7Jh8HeO/okGlm0/i71rXy7KlHbW5Fv?=
 =?us-ascii?Q?NTkV+2790sY6pkmosgm6YzbxISCsRyiGS1qe2Vz+EIPPCLH4WMKmi/yLsziK?=
 =?us-ascii?Q?DBwU4aFzRQIdCzN01hUp0udUzQgYwyPtNVS5ZXWnyV/KkP2uZdbOoplDBx4E?=
 =?us-ascii?Q?zaVPfPrWrf6iXbmHzi9gSkIXl8OfpKDHvN6aaBQj9FDguOgmzBHSV44J1Oyc?=
 =?us-ascii?Q?rcoRoF1M6CKDwonNqPSExg3MnQhVctP4jcfNXYFY6pZn6vBd+HFm3du3qzsw?=
 =?us-ascii?Q?UhhRM1hMiT2KMlIkLMN7b6Vp3cqa1xZbZdr11v2CVJNbv9QLkYT7sl5SQKYu?=
 =?us-ascii?Q?l1fwrrOODa4xU6Fof1jKe/cVkyTdo3umUHokR+yWDXD5SUNmS6hxpUHM6uNS?=
 =?us-ascii?Q?JtdkUkr2MedJcphEHdlppdNGyqSNaydPMhXzzdi6Fz55ETbFA8fp5sFXc2JQ?=
 =?us-ascii?Q?2DOihHC/cfAky+dCHMomrXCKhPCHc66Z4NpFYpiVWRWVf76uwNNWXGMT/mcV?=
 =?us-ascii?Q?CWIHgbXCcbfhx73u6W2snH+53A8uqRYlPwJu9GLh2s9Z098wSd+cg7eY8sHa?=
 =?us-ascii?Q?XTmQKN2Lhyi6czww1glRhGt5Kbj3zRtjyCwlLxvMRSzYCFt7PImfUjGWNt4q?=
 =?us-ascii?Q?8M5FBFbJuMZQvfhgPtDqgf0kliLFK78cRhtNZrQpqPu/vzBkY/DfFP0eOxCA?=
 =?us-ascii?Q?bwFbbafGa+kokfmACIksYGaeDba08FYrgUqBwlOSaw8elyFoI0iDmKiHZLq8?=
 =?us-ascii?Q?R/4GgWd2uEBryYEKLK/+1qjoucNRfywCTOrK1TjEaOoUtsm/Y2WzHzgXUzGF?=
 =?us-ascii?Q?b1P3gr931GkXtqPIKVj1gBz9L7EqxFMw1rZzzen8Cz9Ow9wgAecDg7ytTtsX?=
 =?us-ascii?Q?79TotRYBdRcPuBLvjY1V7TSxnR9Ur7vrjCab+Umk1wP8/42IMMNlZz5c3GSJ?=
 =?us-ascii?Q?LDz1reBUL68zRGSm12qisJsylciR0WBuXVW8lPNG52pTNDL39sQxYMS7nGCG?=
 =?us-ascii?Q?gWdvxj2Oq1bXKFsGBOM5e6oB6l8xUcIOeNWKX+dSjEZ24kVIdIpXszX5ollb?=
 =?us-ascii?Q?9id9cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435f652f-a850-4960-9d4b-08ddf0696e21
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 12:56:17.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4BhTgw2W/X72PCHY6h6U6JZ1do82acbN/AG5xrRB7uk5JrD+F547GtkIRqetGmi4b5KlkYImHPI6fNoPO4IrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9178

On Wed, Sep 10, 2025 at 02:35:21PM +0200, Jonas Rebmann wrote:
> Both the nxp,sja1105 and the nxp,sja1110 series feature an active-low
> reset pin, rendering reset-gpios a valid property for all of the
> nxp,sja1105 family.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> index 9432565f4f5d..8f4ef9d64556 100644
> --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> @@ -32,6 +32,11 @@ properties:
>    reg:
>      maxItems: 1
> 
> +  reset-gpios:
> +    description:
> +      GPIO to be used to reset the whole device
> +    maxItems: 1
> +
>    spi-cpha: true
>    spi-cpol: true
> 
> 
> --
> 2.51.0.178.g2462961280
>

There are multiple issues with the reset line and I was considering
dropping driver support for it.

The most important issue is the fact that, according to NXP document
AH1704, the RST_N signal has to be kept asserted for 5 us after power-on
reset. That is hard to achieve if this pin is routed to an SoC GPIO.
Additionally, routing the reset signal to a host SoC GPIO does not bring
any particular benefit, since the switch can be (and is) also reset by
the driver over SPI.

So, at least for this particular switch, having a "reset-gpios" actively
points towards a potential violation of its POR timing requirements.
That is, unless the power rails are also software-controlled. But they
aren't.

