Return-Path: <netdev+bounces-213007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4F2B22CD7
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E04167CEB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C32C2FA0D8;
	Tue, 12 Aug 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="APYI7BGc"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790E2FA0D3;
	Tue, 12 Aug 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014371; cv=fail; b=uwnweo/XBEoi5cwAiRSQ/vzamxbrCJBq/dF8RPMWE2gzEJSQdM/HYzDXOr+6f7mdzbm+BmGYF67LfBRgKw4I7wjDe/wCkoP7KoFkQF+gKm8yt4+weGkKZ2OExLLL4t08mpi3O75V9dqEaiTzuf0wQNnpZbFCN8T6XRKAQkiBRuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014371; c=relaxed/simple;
	bh=BQRxcIf5Y08mAEQkvM5xSWsUAbwdK67jJ9HkPx6pCXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lC6Ue1icDxcroBnmdn992EIWGDWR1cu/jCVzAQtuuBQYxrZMOKWgR+bUtdOhi4MzY08zZEtk5joMqElIX3CTDB4guDca8FRlE/WRRviyXUYlMOd4n43S/ClDdudH1NvwbLXgW0ygYyk0VSRlovHHtUnA8EamS4xqz5CVhPbFUtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=APYI7BGc; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrUL72u6VEMaaladAPWcqdUrxK1p9moF0ECXTfcBOdVbyG4K/0M5MYRGzeYKJbSFIgb8Fvnp3NX/zD5KWuGtL+K7J2VbkuttASKN+6I+EUwYoc3mLL29pHWveUjIsCnPAnXGXwT6Pan3SJegMjYElJe49/k5/l9akPncmYhBx0qiijeboaLdFmGR4GIO2asipHjaAlM7rzWzZOij4pvsJksEjCT1HgIYV9hncwGrqkhy00Aqe72TA9JbI04D7jRIFyhs9S/g54T4hz31oILyeH/mySYzfqBiizep6ntcAWTlZwPV6NHD4cxNBy6JIEm1wE6EljCPKWDjor/2C5z/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc/fzo5BJmUQZd6jfPDqfwQ5eYn5xLds6X/fKzlQYEA=;
 b=kGgvG9FRIXeclBq3nKq3IXTUSBRQmxg7PWdo9prlbh3a9bsmEk5bBOse3C77xjh50xuLVUUNN/loDzG+tS0UfZPygCPhqG8dGcwbZu1e0lpWTboObQvmr3B1bk3hBxd6/py+wBoVViHFtRfWU4A8P/LH/hhMrEtKnHvESFddryiXXvFNP42OCYftbi8vwDs0WLe2knG3snS/KD0UbpxycVKXgsFNtDwwTZ1d5tJbcbO9yjASLEWl7hFwm6CCdfrWGN99jyLLHi69POGEzN/8uWQ3vHScNWekcJMoFssV5qtQAXXW51+4JDyjBwzjttSVmS3NS6Q9V0hFZ4DNeYiaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc/fzo5BJmUQZd6jfPDqfwQ5eYn5xLds6X/fKzlQYEA=;
 b=APYI7BGcsReDaILtVJ+uPSutdY/E+rmqzK3QXWS31AvlAqt+/X2jiO52vtTBHhFRO8Qi3d6QIr2iGHzX6OajnGDJTF/iDzcFITq1sQq9vBbIZw62KyQTmARTlrg8ZavBAH5qqc6HMDNHjpXNCoy+152oReDGylzmd/AKiupKcg5n7BZarV2333B7j2TkS4K2/2cVai/3e+OUqYfSjz7jZcLG7u56oCPXlkYTtnoMEbliI+6Lg11Y/NvqHWTVfHCILkphFGI0Xu83SomkACkkRheB7ncfRO025bMrnyklx/hc/cZAbpJY3ifi0vLylK5CidfULuzmEzkFMneLja0sVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.11; Tue, 12 Aug
 2025 15:59:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 15:59:27 +0000
Date: Tue, 12 Aug 2025 11:59:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 15/15] arm64: dts: imx95: add standard PCI device
 compatible string to NETC Timer
Message-ID: <aJtk1SQTfV5adWW3@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-16-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-16-wei.fang@nxp.com>
X-ClientProxiedBy: BY5PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:180::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c943c7b-fee1-462a-6dd5-08ddd9b93748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dH7Q2H1Kcx4wVK3NWeTnucXLZ0K5i/C3nZrvqaKZIur4sJmHv9S3yT0saZYk?=
 =?us-ascii?Q?qmX1Ii08CQjUWhZl7E6wqkcvi8CCjJLelNhZqq11FRY6UQ9YLQfw2jczjRpd?=
 =?us-ascii?Q?MK8oLFy11C4lvLFzua+Wf4igvfIUvmvcUSUPFl/s4zdQBUZ8ae+RQS23RPk1?=
 =?us-ascii?Q?MkchWUdUadw3vMHj7kI3St3HTQYKdv4UOoScCHF9S8GRU/Y5X/q9X2OjrdZw?=
 =?us-ascii?Q?5M6z9YAToaWsXRXbMsbJBLxkDDMhLh2+Svi5wjHau0i2yw9dJqOCIE0YES9U?=
 =?us-ascii?Q?owiLzTlrCFIlirf2DqWySFB3iUS6lhIgMhS6PXX/ROSJZmAHQ9VeIvhC6U+B?=
 =?us-ascii?Q?tR1YeFCn41zL0nEfOiFthUte7mP0Xa84YcK3yQftKbHA8PDe9xMolhjX5+xO?=
 =?us-ascii?Q?il5lHgUIJbkQDUqzwATn0yqPYSllIk4PeJKMq5aI335bbJkOEG3AgNiPdjwv?=
 =?us-ascii?Q?g/P4pMVT+34Uek55fDk8fFAgfV4ButXYPoYS8ZIotfxk5W0CSrAgXC5trsGl?=
 =?us-ascii?Q?DFs4t/tXalIv8MZ+wttJcAr6ZV8LS5gpj6OjR8Zdyh8uD7OeU5EG62wOeLlC?=
 =?us-ascii?Q?MgGpos5zdIIBDUaNe6P4GjrrktLhqa+W7Y+jd4P1+2I/W0B8dlX+0kY48wHc?=
 =?us-ascii?Q?t4z/ssQcbLi5NDmkaOi05/H0vEJHoqhB72n6s7Pd2rIaZ1OBEM58yiqGxauU?=
 =?us-ascii?Q?ehP4IL89R8TB/deGAZkc3rNowNivFU/RSJY0J4iUAUkO9eXIz9zM0N3vXVJ1?=
 =?us-ascii?Q?aLGjQM1vyNfBCi+ej1dufQD4WAi5AVW6ohGup9o5Lk2m89N14pCfqvMA7dnv?=
 =?us-ascii?Q?suwdwq7YR0rzzREgkLjzu70O0w3ecpVhQ9vFvy0FiTg5LKq9f/vOcQCgCP7G?=
 =?us-ascii?Q?r1rQ8b3fQAxbfs0L/bQJn+FGrWWsuPRH+rxRObplmaHM9vxDLvQAPav/1Hd+?=
 =?us-ascii?Q?9jMhRmHJEqafat7YpTTn2w+N9WxN3Cl+S00IfXPx0+xzSm9oBnkPFfQK0GbK?=
 =?us-ascii?Q?AaFhvorsaNOm/eNW32EvtXEPqW9CbxarBylUMbOCjK0DqaubV8CHYfEMSKNf?=
 =?us-ascii?Q?yon85/qIAoDqtcHsAREKdRntdZwtH++dw+xjQ7gL9/96e+ODKn8RgK+OxUiq?=
 =?us-ascii?Q?JITKT74e22BMF+LgwKnOwUo9PqNCrQbPFeQg7FSSwjJQRPInA62X8QLhoud+?=
 =?us-ascii?Q?uEA2g7ybbTRpfrVBe3eODdpgT3Ku7OUCUtrF2ZhKeBw1nlSS2R4mgkE5wwfM?=
 =?us-ascii?Q?PrPbauIJXb6+26xeSWP5P/BF9n8O/COxz5wnvGbc4jJeGMZEXc3mgpu+Xtax?=
 =?us-ascii?Q?R0W5BzSn+HOUGKURP+RMab7CP7/A1iy1CAw6DjIEan2h0yHJbRtA4eAG7G0h?=
 =?us-ascii?Q?nM1YndI1++kQlLRRZeG7CcveOvJUZAiDg0Y7UvyC09/fZFp5c0/JCxaZujz+?=
 =?us-ascii?Q?tA9dOY8cl6Jlo4axkU9uxN2b8CmFQoZNjnQrMxghuvFjRwQmKS72BQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UMvuBkAwEurFqcVQ7RhSrkGr0OiKq61xE01I6V0wOSn2Fal3R/POn0XJ8YRS?=
 =?us-ascii?Q?oGBjMHvMDpWKqFQObF/hEgavGM55aQu2j5iWDmDRMVxXmvewJHThk2JJy9S/?=
 =?us-ascii?Q?1ltOWlIObpCg1+Lze7buZbqkQoqMqxO2uEudOhBo/wQuxJCIn4pUiSZLs9TP?=
 =?us-ascii?Q?EPfwcB+7sUcgqFs3ey/Og+KvGg32FxrF1on49DJvjvbuc2AxptPkohscnBoB?=
 =?us-ascii?Q?4eYcMtX/JJ8boAyIXsApQFiDT5eNVMS5k7LQ913CX6FPnRD8kEq92b/UM65p?=
 =?us-ascii?Q?y+b7DvVj3fH/CgswIVX2h4mRj1AYsE42nOpI/0fXM+KNhb9XTke16cRJFRW9?=
 =?us-ascii?Q?5hRpk60Bbk+ZCKXpdaG6xvlZBtiyF6IXlfJjV01AYh/ZilIXhOj3/ee1296r?=
 =?us-ascii?Q?vlKKBo0fLzfoWF5XrrJX47tIbClbb+qcdvRYvFXM4qyE3K24E59RzqZJdDa5?=
 =?us-ascii?Q?Qx8PE0EzVq2bRTMg9VXBJ7DnWQnEBOSZ4NfIh6XFKREc2eTa1JEm/I2UdaTN?=
 =?us-ascii?Q?9lW3pnfgB7MG+87vPAmt7n1vDhzavp1KvYzGc9FjmTbRSWGaH3bWh1AUbfFC?=
 =?us-ascii?Q?g8hQVTNYbGnfRbVBL7zu3PG+Qa6Ay2STZO6yVp5MQTFk399GdPk8rhgAKLgl?=
 =?us-ascii?Q?XxZRYe9JM8b10fOt+IYm4d0cUBAieBeYb5ydyx5nEVMGNdhMwUpFojocAYSD?=
 =?us-ascii?Q?gOV+I+QqX27jKweeJABgTAxNp9E5ubZxgAlV4n2UrKPTHx+bFQMCM0nJy8pN?=
 =?us-ascii?Q?0LEsTPfGp4jcI1D1S9umDcQq0d49MiRmaF+OtazazRE5Qk/0dS3gy7jbVvHv?=
 =?us-ascii?Q?+Al1ozXnqq89XOYQit5Svuzl5fkg9938fH8ksYP80fq7WrNvuMv4LKP+ZEhT?=
 =?us-ascii?Q?jKlqetdK4+oQ6wPPf4giU89zLHBZZW8Nr0i+D0PJTx1wfKCBwxkk5MY87pWO?=
 =?us-ascii?Q?/FMU5SMDsbHL5hxMazSkSEEzQboQWLif8FBgwqjkSnzNbZInKcl44pXGi74E?=
 =?us-ascii?Q?FfK2vi+4bBFq6F3CuNb2VHKVALwWfskGrn3dwNlsQ3fsFh/VmwHitNxeyCWO?=
 =?us-ascii?Q?gxKzKcB2bDzM8vb3TCLr6mF9q3ld8oCKEsxrWkFU506C1CRR5ZYCwxgMJTTz?=
 =?us-ascii?Q?VweCbjdMJqmz5tQOZ3x0H7R9WzM99vZEZVTYyGhXqsBUGvRTe+EHl9hJdTvl?=
 =?us-ascii?Q?jFWL+XWq/abiITgzKSn2jWA3ekV0WX7qpOWvqyroHrbMJFlOoKo331SssRJa?=
 =?us-ascii?Q?BwIuuzAQhsbOA8mWjpsS7vxVbPLrQxchA+o46Rt0SaoNBmaK8nln08AUdBdL?=
 =?us-ascii?Q?cG64m04F2nDjZB9atIh22dw38W8n1TCvrMcze9WJ7QGex8FSkCQFdMkkUf5P?=
 =?us-ascii?Q?N/r4xe6X0s8I5T0G+5GMHvf3kVfO1uloQc7943P+aWt3+yJxXb9sXl8ok8zg?=
 =?us-ascii?Q?Iz4ymtW8Q9hwLc9ZjWlzctzl29C6aTtAII35M25WBomSBMKIPxIPETihg/pZ?=
 =?us-ascii?Q?WfjN/P2W3djQt5RPOBukJGAkdTX3OreVEhObPM3w0cr70zO7ERueMREEdGfc?=
 =?us-ascii?Q?xdXI2Yqza1xIBQnPs/6zupY5KeXeNm6MEwOVXd5A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c943c7b-fee1-462a-6dd5-08ddd9b93748
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:59:27.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9baQXz2CBbSkiga02c0052Ds/OT75ui5F1zbf021eUtNYYcKmNQ8bZTiEhWcA33YaoFZegRHXOc6SW7uknkHBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113

On Tue, Aug 12, 2025 at 05:46:34PM +0800, Wei Fang wrote:
> PCI devices should have a compatible string based on the vendor and
> device IDs. So add this compatible string to NETC Timer.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> v2 changes:
> new patch
> v3 changes:
> Since the commit 02b7adb791e1 ("arm64: dts: imx95-19x19-evk: add adc0
> flexcan[1,2] i2c[2,3] uart5 spi3 and tpm3") has enabled NETC Timer, so
> rebase this patch and change the title and commit message.
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 4ca6a7ea586e..605f14d8fa25 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1948,6 +1948,7 @@ enetc_port2: ethernet@10,0 {
>  				};
>
>  				netc_timer: ethernet@18,0 {
> +					compatible = "pci1131,ee02";
>  					reg = <0x00c000 0 0 0 0>;
>  					status = "disabled";
>  				};
> --
> 2.34.1
>

