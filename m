Return-Path: <netdev+bounces-212970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3435B22AE7
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B57189A564
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC5B2EBBB1;
	Tue, 12 Aug 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ncQONuJR"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608B29B78F;
	Tue, 12 Aug 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009626; cv=fail; b=JTBcF9i/+eNTKk0h5VDXEKAkWmF6zo13lvY6eHq/6/4mlgePN5KhX8LwZ3s3WeFgAUD/xhqQyixjphrfDZKawvQvCYw24eiCHNjCgpGVtfqjygDO1vrM0TZjxZvVs/ptPuJ3lZAzA3s6dZ7OgYPTNSOywLgA7Zwbiptws70MzNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009626; c=relaxed/simple;
	bh=XSHssnEZx4NgsretFcTKzFIsqz/WnNrYkUDJ79Io3DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6QwXW7yKKyEZ9Gh8Na8iU2itzNlA/k7TrvZp6pQwC8RuGQQaw8OL99WMlL4OGhfSkl5hGp2VmyAxikP55t9ThqA41GmxIVHJy7vNpDVITiDICiIHkgKBCoMUEdEHUFXlRG4bqQBlOJY57Qnp+86l919bG/kVvWPqxRV7fDvXHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ncQONuJR; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0xeaL2FhdRes+ZDvIK8VfeLPf9GhDndVtY9A+QgsnQS9S6DicSSFQVg5eVnRW9Ve+vFn3p0tGCmosC+EJU1MKhF/6Wb2eS5PiisUEdawt0Hnfwdo8VrjaJf/04C+bX/7J89cByV3d9BcZRwZazN35y0iMZ6nPTPyTXwg9SUQc+Uyf4y1wciWLWicAFNVqSuUWFOoLJnFClfi5u7kOfZb8rUwJ9k039voHwdtfMQbM0oARCoSNXJmFnPu/0G33HzBkkUBap9+m2gntkTWQPkww3CGlYEbSSttK4Gcu1E1HP990fNYTh4OZGAgk5sIl1NqpXJLaAFAESjuNhYhhwr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i/n+4jvDGtgN4xtEDh0QjY1kvQoMWBwbuvnAmXz6X8=;
 b=vW5ojpD8ME7gteDZ05MGgdia+5Cn+FYrL3eVwyrWAgJ+AWyT9eeTPlSjmLkhuZ0zWFZ4ubLdQZEjYRtPfoxLpRAujvD32ll7lsfAUy4EYBaJlgf+mWkT6n9OaWs/I2f9hZ1an9DRMC8R4EmnBFS5mcQ9/Sv9+2M5OTDkJ0m/jr2J7OZ7fr6CJBhyjiJUn+ifxzqeRszB25tNcz5yhgwUBCGYIRJQV8N82rSGYcvrLWRiVWb6W5Qu4QiRfXsasn5O1vPWhwTVvL5aYxi3ddWwT4ZvFQu6z4PyOwrsJLKIKxBMTpx71FNzkvkEzdnyMEkzDe3/apJiV08EtfnqFZ28ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i/n+4jvDGtgN4xtEDh0QjY1kvQoMWBwbuvnAmXz6X8=;
 b=ncQONuJRJgf8QeNCnhfzEjlPaZ7QWUle0ijpZ9yBscJcOvgpaRJN1Ft7XXgIkBeHZs1Xga+YJrYsUdGqEobp4/hgXHMSRNo2+b4AFlxTpQV6cNZLLMVHmm96RuMQtzC4o4Z9VbH+4vNsmdw8TtEjt+PbA0JxfH/LzUCBHem3WisJrUU7i5Y5UrDtL88xmXQuuVRXcSjk1w4XACGgIEUAB4403zT87nAsDhKYAP1nQGtQHojH762g9J4MLgzFzMN2ME+TF4oUFzxb6VrFiWjMOeZXVp91ClGHjEzWe951lutingdK4/XQGllCvM1wp6koXJpNk2+oRlG7Ct4JtYNCgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 14:40:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 14:40:21 +0000
Date: Tue, 12 Aug 2025 10:40:12 -0400
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
Subject: Re: [PATCH v3 net-next 02/15] dt-bindings: net: add ptp-timer
 property
Message-ID: <aJtSTKY5SK6phtE2@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-3-wei.fang@nxp.com>
X-ClientProxiedBy: PH0PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:510:5::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 235eb622-c9a1-4f24-35c1-08ddd9ae2a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7aHk5bps3smSXq9D14C4Khv9nB7IibJOP2ElMgAgQvMVbU8s4B7mX1JkS8d5?=
 =?us-ascii?Q?vybnLvj0Rb1ufEXMb3vnsENdJGcU6RvUi+tJXcJVaPe83YMGooJRPBmI/jei?=
 =?us-ascii?Q?whkfYqWmbFILz87VYDaXaah38HIVvWHGJCAqEC9+AwvnWlJrEYIVKlT/aP14?=
 =?us-ascii?Q?JyC36fr+I+wXR4/NSCikmK07BsLCZ6SlmBBY2TUaYddYbWPsGIWBbeBR4r7/?=
 =?us-ascii?Q?M8Z8gKS9WsuDenStPLGpI9g3U58mfyeKeZh7UzcTmz8k6fyD4MyUkgNntTac?=
 =?us-ascii?Q?fdX/HNNjF1vL/GapgYuFVYRqwQPpdA9TaR33p/mWS9OJT3pKjJ9iruHA8G//?=
 =?us-ascii?Q?YPDo1VPG8KLN0VdHD/1HxxHclGDO8Afibu/7GRwCsIlXIKDJAwuuYshSmly7?=
 =?us-ascii?Q?O06qk07T8VJxhmlDt2KNPq/U2GT8v9RVph3nkzlT16tEXVmwhOt9bB9kqRVZ?=
 =?us-ascii?Q?YFa912OvCuDR7/7xOy5YeZZxy9qjpPd+5T9BFprTFikHcU9WcWST+tRz2TVE?=
 =?us-ascii?Q?IX59EjAKoexWDmyfXHCg0f4ZkPQXZsPBy7WaKMFxqc846EVny16pFVPK7aPm?=
 =?us-ascii?Q?fKGV12j52ZUWfE5qnJqzw+ZRDPv5LaeiheLnW6A7pQgc4BeZ3+1b9KebDtVn?=
 =?us-ascii?Q?dnKuvt1ElqpuYgTS44Yf50twZcMjiTUQSYJDkuDslWRwgk7Bwef0wgs1dGEu?=
 =?us-ascii?Q?8ETXaj45gVB+W/qV1rN9Ty0vxPi9y4KwPG5W5JMveJbduDHRvEXxs5hdl1uh?=
 =?us-ascii?Q?EUPSTYAs9/CpQHVf7agtpba9oCVYnJJo0ZVGRxObME6+xbhVbgZTTl2OfvN7?=
 =?us-ascii?Q?1I3J8eU/DR2CndLPbTlr9Y91xXGaWYdHQduBSIKdlNF1aeTxHFWMWReleCkK?=
 =?us-ascii?Q?xQiIZrAMaJZF2rzwbiG1lvvPEKUoMzxt1m2646gAUZUhoxoGU8UJmryszmUZ?=
 =?us-ascii?Q?psWXnIPKRIq++gDnv8zio3m1ZAtYOvaKdTc50xwM9CAO8AHqAofz4G2ujb5R?=
 =?us-ascii?Q?8mqkHScjF8Zq09ImKlUJHq2hWexZRWZcxQWoOnGA5pErqRk4qk68Mfg0iMzJ?=
 =?us-ascii?Q?BvmjgRekPsDrPJZnD6T0c4+X4kVRGJTiLj4qzMG4P3IYFIVAbKZbz4ePbDJd?=
 =?us-ascii?Q?hboQ7QlwMYyfbuCm8/Ws+ZqNQDUHUHqHEkJhEEgs9+d2aGPu2z9vxAwuCZpP?=
 =?us-ascii?Q?fjTFqMEK1UqpYtNRVD1C3HoHh6+VWDVq1ggqjSl6X6Auplw6wp2yqTqpWekl?=
 =?us-ascii?Q?gvXbs9aIOU9iO+aK+NHrIS1TR5sUr+g7B8VVtjd4fmYbR7fRIndz5XLi1OHB?=
 =?us-ascii?Q?UjziU43yiDEUqrVSMHxyVrfw7mKQa6cNjJJc5GWKxdW+WpcQNxCj5XciBz7i?=
 =?us-ascii?Q?7XwGoTN/U7cgcc/1qkxKpkS4P3aSbV43F6+rLnxAi1phWUqid8kvDtNOP5/p?=
 =?us-ascii?Q?UeEV9+19nxAiURLNxCuPnNtMssOW6o1QyINl/ZJGxFK27PtkdkeGiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MOXQnHUYedMMx01NdxPY3NQ9ganmFT4q85I6u5UO3Q0X7busDjewH3NucvnL?=
 =?us-ascii?Q?wreBeHhwEPyUVMgALrY8440H/uSFRix67mSTtqigOXbh1C9SqYWHpjosTVrT?=
 =?us-ascii?Q?JDScRPmtjmcIVvGqMa/bj8U5EqkWXGfMO8uPblShdhhsFcUW9o82ZNDaFYh4?=
 =?us-ascii?Q?ZytYAIFRUByhLw1MjU5NDfE9mkoYlsuBj5vSSpSMzEVScLc07xLrdcxzZ+Gp?=
 =?us-ascii?Q?AXarIibjsyehrjG12y0ozp8xHN8R5DTaAUdB2KC5prg3p/Xe68tS9QkoE4kJ?=
 =?us-ascii?Q?OGsGSzDPdaXZoqEGhXYt9rdfOaFvQsSwtkUSEqz8z3CFj/BVlObBXWLoTJEu?=
 =?us-ascii?Q?cfMhOt0lGpuqRWTVARbqqAXX4ZVfaZN1U6KsPvHiHZyMR4jRvU6QHrodNkj9?=
 =?us-ascii?Q?3D7HKBKJKZXoYWBz09bGq95i9O7xsorkTl8VmEC5T9GrWwG+wao0ZCZdfXYi?=
 =?us-ascii?Q?vb9c4/Onv7I0DfLVJ0f4WthaUGX/Zpo1QfvqODb9abeCDaASH9NNF0ppWI8a?=
 =?us-ascii?Q?PTP947eaN8axLD3RtfKnzL53z3DhaeP34x+Qp1e787RsRaMgEA0q6tY2Tj3B?=
 =?us-ascii?Q?SPEPpXEO1Nw+mEInvl6VDmymVb39cqDcOgFbQlUCngH+DWTXGkHLe953FC7E?=
 =?us-ascii?Q?U4RsLgIZU1Wx9ep4jrbzCKD4Fx+eZjCvqArK+LK2R4GKGX0LaRkDKv+hHahd?=
 =?us-ascii?Q?fGvrhJLceGdpKdsALgClSJ6dwgqwCKORiiA6Vlj8nNV7tANHMoJx5hvXbRiZ?=
 =?us-ascii?Q?yG92q/KOzNvyGCijcuCIEI/DESSOo7Z9VHucuRPNQP03tGjCYKt84T54zmPp?=
 =?us-ascii?Q?ENQGpzmBK19ZL27hiy+MS5IJxHsFMASmLhL+WibLPRRzlzza2dkCrVVnhIAE?=
 =?us-ascii?Q?oujZIAT3kWKz9eSn7XdAZOlXw/ywq4Vc338x+4JFhYrZUvHel3FbAXiuJdzR?=
 =?us-ascii?Q?5oPDlG5de6G0BzVp3qsT4BF6XVQviUdtgrVTKKaPN9sx6kTMEsS72w4cvTnS?=
 =?us-ascii?Q?LS3iOuRYfGnjT1CT7miyJPY9W/aUacbYATwAiUxhCctYcLS4KBWU4WOUeoAg?=
 =?us-ascii?Q?ENv2r7AUQVLTrSu5Lkz5WoMfy6PnFp555/1xDQnCJxc+WGGwJFRlFgO7wBeB?=
 =?us-ascii?Q?PnL0djcENj6FNvVKORtKsMEXlmNoT2zY6gBDjxw9AGldBHFF4h/nR3PApTLK?=
 =?us-ascii?Q?AEti1K10zGh9KzaUb6S1ug6e9MLFVzT+/XrJPnnVTnYKh3ioluZpPdsMP81v?=
 =?us-ascii?Q?QSjParqt1jjV0Q+ao4N7QGAIft7/PbkIt+Z3DCgW8HVsRfj7jERqgHRfYuo/?=
 =?us-ascii?Q?3ZRiCMSUi9LO4iEqOC7B8baXR1aNq4zBPkx+Ados5KKNgziiI7eO9qnvKHFk?=
 =?us-ascii?Q?C8IVuyxC9W7N+b7qeW9bKNFAsBXNN8BDdp+7kpMunzAqcgg6ek4plnzpNEvv?=
 =?us-ascii?Q?fb5faIrETjhkhOBQkkdOaAAZpjKFs5nVaAr/QzBzhvZCPvnfMheEV4KYmINt?=
 =?us-ascii?Q?ujxTknriM5LQ7sEEXJubPULgHzshzhKAURydv0liLQ3u51dtXZjyf15EfYFy?=
 =?us-ascii?Q?OG3rO4EkirZeo1fjNhU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235eb622-c9a1-4f24-35c1-08ddd9ae2a59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:40:21.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01lmFnXNhW/GiiAHLfDutexw9+oMlMZFGjxE0TrTUANK6CE08bjsKyNuEVuoLA2d+BBMWxvYkqbytBkGQC7Ffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

On Tue, Aug 12, 2025 at 05:46:21PM +0800, Wei Fang wrote:
> For some Ethernet controllers, the PTP timer function is not integrated.
> Instead, the PTP timer is a separate device and provides PTP Hardware
> Clock (PHC) to the Ethernet controller to use, such as NXP FMan MAC,
> ENETC, etc. Therefore, a property is needed to indicate this hardware
> relationship between the Ethernet controller and the PTP timer.
>
> Since this use case is also very common, it is better to add a generic
> property to ethernet-controller.yaml. According to the existing binding
> docs, there are two good candidates, one is the "ptp-timer" defined in
> fsl,fman-dtsec.yaml, and the other is the "ptimer-handle" defined in
> fsl,fman.yaml. From the perspective of the name, the former is more
> straightforward, so add the "ptp-timer" property.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> ---
> v3 changes:
> New patch, add a generic property instead of adding a property to
> fsl,enetc.yaml
> ---
>  .../devicetree/bindings/net/ethernet-controller.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 66b1cfbbfe22..2c924d296a8f 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -108,6 +108,11 @@ properties:
>      $ref: "#/properties/phy-handle"
>      deprecated: true
>
> +  ptp-timer:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Specifies a reference to a node representing an IEEE 1588 PTP device.
> +
>    rx-fifo-depth:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> --
> 2.34.1
>

