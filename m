Return-Path: <netdev+bounces-229362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A036BDB278
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB2924F634F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589830594F;
	Tue, 14 Oct 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j5IPLtR0"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189892FFDFB;
	Tue, 14 Oct 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472430; cv=fail; b=Ew7mHIl0boDYG339VvbNBC7WYd4OAgaBIjhDDA+Uou5SZkO+araUlmOOtAHVlDwACYQARF3M5i67sbvIbzsKUVx5Vvj2GBusUxqMp68iPACHkMkbvo6kpR33fYHSW6E+U1Yn0wRFSxwHGB5/4eBSMIVzQLkEw6fxrIKYmL1QITQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472430; c=relaxed/simple;
	bh=67StfkEaChvbT+1HZyqNIHmg77TG4FsSDlfZv4EX0Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=irCV4CFSMZRDZSfCDYPmPs0JDeX/KBvkDl1eMdF6ewB3OqZWdmxi0D+6/JjiX8lF29djZpUDY0x7N2JWUwOsKuF6GDW8KjYzcSig3GCJZAOVb4pYa60BpqhG6MlUzqZbJvybz9nMy77m5A7kdm9ot/FyAGeFSn+PxkCDtLal92s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j5IPLtR0; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZHK8/JtfoeEkvNoyD/4mhUC8goiSJwfOeS55InNPqaElpgIvbDiKnfuAD2ICYFUv5/Nx+uvNA/4grXV1aaqsfFFfVp7mZI/9jiegm1mNRctR2sKY+gQ2SQwovnxOF9uRW5jhM3TS60Q5X4sZyR8PS7IEWvPSZkls1SUdHXH0E8WYM+9zA7EtRSiEh1mwOqkDrjJLADXFWIWKDPeEqZvNQQU1YEtBtGGupVAO1qDE/fy+EP8dtZCW6KxWPcvdcpu86rwlHgm/yDiMlk3HnsAMvDDh0OkG2CzkGQYGDR+e8fVjDBmfzjGyFvzKtZp6Zv+LgM/MIn9MvTa7XzR2WNrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Okah5CHkYpP2d20NhaElfPh528V7YvlXYklw7OC17YU=;
 b=BvqfEwuVzJlzjfxzFOohfIIGiv5pIQ+3a/zQUgkPcU7RYN1YeD+nVKMOg2garqpqQXdF34b35lrR3aHZdXutr13/S5I6i8eg7aOje9mHCQpfSd8vAJ/xb5fpRiTEzbuDexKD8j0BWTTpPAAcs5nTLB2wzx4oTgRBCK31z1MKz+n+wQgiv+w5WRmDvg4TDQT0mJGNUpJM+qrf1bOaZnrw0gEtYHJ4TGIHLQ2TzxC1bgiZRBb8MpBBm8bDiME3gZIp0MomTX66frYYMfs/EVPVwfNgRtIFyF7SGE5P1B//pVV7nF6KDWg5eWVfNYF6H4E6OagtIWJjAkTFKYcDCbSEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Okah5CHkYpP2d20NhaElfPh528V7YvlXYklw7OC17YU=;
 b=j5IPLtR0XMzkl+LrR/2LkyzKJVKciKXJD7LYdIydUhSTTehrUlpIDkX+KyEvj+nEgizUGYq5IVODBdyWiLSw+vltnLKbMLSfmyM5J0GG7fA3WTigVta0dO4KQsRT+FVvOIhqMG+xxgMYUiCvzzqiV8jJy+A9v/mMmGfrAZAf93alKKZ7PE/QT0D/TWJSQaoNF+oQm7FBNnOTZNroqNItK4PdJpiZAYF1qbWpIOpyQpQdBJ9R4NmDknRQwmFvUDMDNnwapSwGx3p6JSsVeED3HugI0UZ7+jdisrvVhH6lKJm3pFeX2KZzmjUgQof3rkF96qhY3rq4RNJTaiFo6sz3cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Tue, 14 Oct
 2025 20:07:05 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 20:07:05 +0000
Date: Tue, 14 Oct 2025 23:07:01 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251014200701.owvbmsfcibwseqfr@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010183418.2179063-1-Frank.Li@nxp.com>
X-ClientProxiedBy: VI1PR04CA0098.eurprd04.prod.outlook.com
 (2603:10a6:803:64::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB8PR04MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a316177-d19c-4a51-4356-08de0b5d3ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bm+qgq8xYPcjeP1R9vsGOQ33Po/JIBoGi3KM6Ry5dJC2kofwvewDgsU23tZ/?=
 =?us-ascii?Q?hmWUBpcul7aDyd3r8Xiy4jABzEoEGyiPNN5hk0h3ai3eyFdqb6HTmcd4AQES?=
 =?us-ascii?Q?MomWuuhgykA9egBkuDeBl31EWP37maW3QYxywdjJe7g4wxUXj/qDjr8xy5oy?=
 =?us-ascii?Q?yg26cErVY4q5jt52IzwTvmcooe3rnHlKJtaSuuesJ2diNoWAVvv9hMRdaiwm?=
 =?us-ascii?Q?dYIoN0N74Bh0XMd0iKV+ncfvztkvdx7GSi8Df6h5s0WjMgWE8n2uWjvhbv0+?=
 =?us-ascii?Q?Ji6N3bGyeWDmmeU6yjyRMOzVTgBsQTdqzGKo0bdzrSa6QMXIUCu7VXoUDgAt?=
 =?us-ascii?Q?xZ88phkjX8KUEVNcRg+akB83PJJ2LUT0b43Xqz/TV295rvFtjn6KMRsHi4SE?=
 =?us-ascii?Q?/cBW/azNpHMiVjvKgJIboo3G8SCK0eShWw09cA24KXMVPcjG+wnk/1rOkRaY?=
 =?us-ascii?Q?9E0Oseb7p9X8ojtHHiLdR/oyn5cHm8CghFXUuslSB8rkRA2nna+7vV+nUq5q?=
 =?us-ascii?Q?Gch9b8rPrh9AxZIW1QWp2Az9XYn3B3DznJKAG31EDFi7skugW3roUFXp3F3V?=
 =?us-ascii?Q?KVuMAimIXiHGAMH+ni3g6gmjdutrF+gKNn7LbFAWjE4mQh9fXSxlFOkjM2HY?=
 =?us-ascii?Q?NLhEpgIPmjcZyVUp4kXyoErYIi2FL2gm8hAyP/ApIBS8NtTxYiDAfg7wJWDE?=
 =?us-ascii?Q?4cZXZf4WLjxDqC+gOFtUMhfn0DyxAKJyhGjOVh5aHalpgDlL7tqG+y1To/iW?=
 =?us-ascii?Q?0+YFN+RJcfydjTOhA+hOZMiTIbxguwh0FkQlnvus1br5fc39F3EHUsFG1Hn4?=
 =?us-ascii?Q?l2HaA0w7h4L5XYPu+Cfd7pXWT21hcdTfq9Ud07jafjyFnJ0iS/ShrIrZ68jW?=
 =?us-ascii?Q?FMbE6HxmSLfb7544WXVZfQACCAXo9uJZpWl0g1U0W63WsC+m4FX6buL6SD9k?=
 =?us-ascii?Q?ozsyLCgTKWWwQKDlh+DZyxgUh0b0yU1Nq5Fya5iDEcn8SkPXlHZMLW3VPiF6?=
 =?us-ascii?Q?sHSJ9g9T646P0RG2EeWIbSJmsJEsoQlDjn4MHBcKVdtvWtDtck+UO0kqzeVk?=
 =?us-ascii?Q?dl5GmW3Zz4Yz+OBOTnok33thx4PQlHRDWo3qzjsd3J6QNCg3kmvFPYLAoE1P?=
 =?us-ascii?Q?6rt2fTMXWf4goBMqNT80DyCZS+iLPIq1hW6aLn5TqShf3rweNo6FlCAC8QhU?=
 =?us-ascii?Q?h1Z52CBCacuUonKY24e6Q8CyqP9NMWtdp0Lc/TYCrkFiYkM71iMUpa6kELDB?=
 =?us-ascii?Q?UKa3/M/z+dx/x6jsUDb6W8v0thSEBkL2Rq2A+SQ1DLKBCM9wLctLLbxhh6Ui?=
 =?us-ascii?Q?O9bUG5J+/EeqEhpOcNdJEZ+SSE/Usc7T7cSB0D/GCJc3Vh0kQb674MZ3/qMh?=
 =?us-ascii?Q?9B52ayCIlamP3uZgzfXEbuqLIzFy/Eqr53oNxl9jnxsZFGmiuL2XtnA8BLvn?=
 =?us-ascii?Q?FdRvt4tks2LwfLrve8zobtg3Nex5PLKy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tp6osAF43MeQmdwW0eDQ8uwz6J8jQOAspUK1lNFWuRh9rNFNSoYW46hJdyN+?=
 =?us-ascii?Q?8yGWHDZc6FinOlrNtLQaG6pY03MAK40npPmUR8lAV7MroTT8M/G/M+Wnk1cG?=
 =?us-ascii?Q?3wRIuDz2Dw3JRyG7fjSBTgiR3Uv20rqO28DSCvZMTR+6FSt95dwioktnAHvj?=
 =?us-ascii?Q?k/kRYA9vrqlANsO1KQ1bIT8TcL3dmPe/caq6lzkYrRy3002ttRgE04Uib8gq?=
 =?us-ascii?Q?6rX0aT4TybujUjQ0zPJ8jZkrWKz9b5TwxSLHhSOWY7GwHYnGMvuaRPE6/RAU?=
 =?us-ascii?Q?wsn4bZHWxb9Yxdo7g5wcQ1bkF1GxqBYCBmSXQjxuWOAaCZuQO/rBaSSbi/oq?=
 =?us-ascii?Q?wNhTW+eAZEyw0ydMr1EPTXyhZZhVLkLKazL82RHeGr6T6dYdiA9ub+ucrJrt?=
 =?us-ascii?Q?wtjV9Tuw4oZ/9NJBmLJCRidycce9HOA4cutaZacaCo+D253IO4PsAYNRHDAA?=
 =?us-ascii?Q?Fx0DX1qySxddAQHy9qdfaGLmQxc8bUv+mXWYtWgmLKw1Rqa2wCsCHApozDS+?=
 =?us-ascii?Q?W6Z3RMs6cvRCTxqk7UPQbQGnqhGEPTVWULwLn2HeOEC5UCpY73rlh14e3x9S?=
 =?us-ascii?Q?YG4wkhpCKjpn+5CdIRua08kyFqPTBVvxBL2WcAFaQ9EPU9Il8/JEkTcqxUg8?=
 =?us-ascii?Q?+OHWKeXVEMlHGxDqEoxttoxJKTbORU+RyAGg+6t3DSfCVKPWlF5qQLcZYXyH?=
 =?us-ascii?Q?RybpVMvFF2cN+hsIWQJoqf3F+5FrZlgxXlxZJoYw+zvLnVwkCHtmNR28pMXc?=
 =?us-ascii?Q?v5KWZdphpU+mpwzxsX7pviWPm1KvrVqB/y1Qh4dYFNubyT0BMwPmKFkf7EH8?=
 =?us-ascii?Q?f7FtRJMbwyHU91fxxDtx97DYTL53mDdokmCwltXsxnC9pSqxPvX+yaHxzXON?=
 =?us-ascii?Q?JeWcEeSKBk8A5+j7wvPJAwCYv/J6KYB62FXcndXXX8Ioh9r2Gy8DGVbXICIV?=
 =?us-ascii?Q?UKQdUm6wIE87uVrIgtELf4FStVOyuiknA/WFOk/11foTtLZIVCoMmlcLlvZY?=
 =?us-ascii?Q?/FGJRMJJeVLadCZNq9nDoiuy3y9avhx2nr202iaHYvCrpbcYsUYE27FQ6o31?=
 =?us-ascii?Q?0dDRAXtYWQDaEa7ejPuVjHlXeSQASfUSDY8pwuc9SUgpH0HZa8USHJ8S8Ybm?=
 =?us-ascii?Q?gCB9Mt/ODSXZ3ZC9LZNJuVZvJEwVROw2GqLlv6Im0hhB8TSYj9bbqrgW3aeV?=
 =?us-ascii?Q?8Tw/mwMVGAmque+t9WCnSaYfImKLeOvPoKiWhWDgNaTPn0/SnrSerzxdtFTE?=
 =?us-ascii?Q?oBDEbwoT+WXj/37E2ATgBniikz2JmLcsmoa+dlZkEzXC1rgGGAf+E0OTPCv1?=
 =?us-ascii?Q?tiCwqRnQl7OFwL/6WZ+EwP7jYs2Hg8rToOgK99E+TmedZNLYWcogtJ8dxjer?=
 =?us-ascii?Q?BVDRvmGIQHbxqiWaK+Lx54Q0kM6a0lcUcS7CpAZ+nBYWcQMQ/BQbm/e21fTQ?=
 =?us-ascii?Q?fjLjOwAAmvk0TVa9dvGPUmP172Aafl/AGFKPvEQvFiLPPcCpp+UQsPirQMQ9?=
 =?us-ascii?Q?3IxlrAp/MVYV51WUNZWSJD9kui5ado4f7P2OGhbgJMpvCl0/4XZgHrdubwhE?=
 =?us-ascii?Q?nty9q3Y3Tj471aK1/QscPo91yKsqOVs2YuTJ9VXkRiIi3Us6E0nLLhUCLLNh?=
 =?us-ascii?Q?kUY13IqTeumZohdUcoO+WCrT31Ca8OcLDRLuxiSWEuPuUQJv2VAZMOs6r4F2?=
 =?us-ascii?Q?dDIyYA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a316177-d19c-4a51-4356-08de0b5d3ec2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 20:07:04.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYQjtwHVRUMY9kZ5GqD8BqjdCBlifiGUIKgyQLNnr4Rn1R9DbQbSuheYdxzlG4JWQh4ZXxTcU4ggJUqifUKG6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7051

On Fri, Oct 10, 2025 at 02:34:17PM -0400, Frank Li wrote:
> Add optional clock for OSC_IN and fix the below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dtb: switch@0 (nxp,sja1105q): Unevaluated properties are not allowed ('clocks' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> index e9dd914b0734c..607b7fe8d28ee 100644
> --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> @@ -41,6 +41,9 @@ properties:
>        therefore discouraged.
>      maxItems: 1
>  
> +  clocks:
> +    maxItems: 1
> +
>    spi-cpha: true
>    spi-cpol: true
>  
> -- 
> 2.34.1
> 

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

with the comment that you might want to add clk_prepare_enable() driver
support for it too. Someone who specifies a clock which isn't fixed
might be taken by surprise by the missing driver logic.

