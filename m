Return-Path: <netdev+bounces-212880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF544B225B3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70ED77A0F9F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B8284B4E;
	Tue, 12 Aug 2025 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hsbjPkxt"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19732B640;
	Tue, 12 Aug 2025 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997501; cv=fail; b=uM9rN2iNwMvKHZl1HfjUNlm2uhJeuTFOJTwmntW1+8tfXYTiypKCkF+o/ykN62nJ/NWuCpyGZ7Hw35S5b7DiX10DpRnnkQTEt65HYRx6bMopqzDN3EpuU1Z5LYfXqNWql1GUjoA5cKGi4SsaPBdCnvXAYXApNGR9/j4AJ53Ef8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997501; c=relaxed/simple;
	bh=uTqE9hmUaQd8uP8U0+7wfT5ABQSb8UptgryyLZgoxF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iMS9n5LLfePP7j0oKKDBkz3naOmzUpCcsxwLu5RcCPYWPDwv/Qlzg0LYtbYDH2JMRUJVmBJ7nC62vHANG8s9BHagSmD7VThuyL1WMgE1/dsTG0eXz4qqatJC5bji3FpVGvXf2fy0bCI6BdYXUyvdeDMX1IcF23YXg5u3wH3tXHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hsbjPkxt; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxYwiZPKseSIyQDFg1aU/mam/139JPcpiZW4m8Ew/hMLgEux0Z/K9/n5eJ9/EhZTa9l5+kef981ZGRWRiab6o0Wy+bMc45X4UGyysa1yynkB7NvXvoV9Ayyv6y9i5yGVMYlK4N/elWUb9MhiLiD4AVwAdPd2jwVh/J9C/icq/GcUvze/2qsRpyWg50R+d4DmXWlggcmvdAd86W4WSfTXioVKITo4ORYCFz3UMAJHjURyXZczfOlQaD7Ci9brfBiy9Gdx/WU3KkCUToiUZcdpRp+VvZMN43KBNaRwVQXodVKAERqN0BZxmAfGMeEXoXw+72N/Y8gsNRaFHA5TD0JIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9l6jhAfu/gnekkOOd+Tyg1yG4VqYFaydLS4/XrTzA4=;
 b=CvJKaJbDvBkmPfhota0twAXJMfUHweIJmddd0FlzOVKI10NqxG0exYdXgimunXufRkCmOQ/PirZsDd55YNVvUaWMl7zskj8nEqWO69teOH5ZUs8QltwTEImT0ZmIUORejHBki4QrIpF5tOg8nN8/6zC0X0P/0ikrm95uYn8B56EKZnEcvxTpPGqxKye7oMQMMBdRszzSTE6wi/yI3cVCQTjDEhocM3NvZsCuQKA92SIG9URC3sbQoRc+UVJ/5VrEuRVc+bNgB9Zp7o5EUtCQtresS7mKAw3nzOPVfbnoxMz6COvH0V6HOXam4RrX36drygpNtu5L/NJJhO2Wex2otw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9l6jhAfu/gnekkOOd+Tyg1yG4VqYFaydLS4/XrTzA4=;
 b=hsbjPkxtgowEWbGv3TsgSMrX0znpMXHsN5/0kxT8ILhScBNLiCDeXBLP9Tavy721yCdyU5kyVdgFEWsRwkLf3irbuEs4Q4xkq+uQIhcIePOvCP8ml9Zleq+B+80jqWy4kdUR2NvwtZYoFssEN5H2+ALbg5WoYxAjsO9IxdBiV7iRdExpyw3XSkr3w7x1XG/s5ar56+gUoDHxPPF1AQsCiO7D+9FS79hVGVvzJ+kN9vtkADpepsZXMzvBIUQOjStvTCsinlKjTY07afssSa7l5qcAZSOug7HEMHrR3mA9m751JTHtlRTPod4w+H9MrBdHuEjuBK+D34UxQILuCS8Prw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 11:18:16 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 11:18:16 +0000
Date: Tue, 12 Aug 2025 14:18:12 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, Frank.Li@nxp.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 02/15] dt-bindings: net: add ptp-timer
 property
Message-ID: <20250812111812.rxazhrdg6dgjd644@skbuf>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-3-wei.fang@nxp.com>
X-ClientProxiedBy: VE1PR03CA0039.eurprd03.prod.outlook.com
 (2603:10a6:803:118::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 3844b575-c461-41cc-33dc-08ddd991ef20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P7KSHNjd+mWLhO7W7OlKaTm4I02568pzaOcJpVIq0G5bZmTYtrzb0nu5JEbJ?=
 =?us-ascii?Q?f4ZoeyklbPofp2Uv/GOJbr1OwpQcKkZwgaB1LPmYS3jOPtMXLT7Y1/rNOWbL?=
 =?us-ascii?Q?bMA8IeRdb+SYcICa8KnBAG5n37th9RzSVc4RRRNuUNPjWV2Vp3WX1PWOKhYA?=
 =?us-ascii?Q?90LkDfKSnZCQd+KDVNBemF1FkYx6rz/IXdzZBlGvTNP8BQTO1f0RaSplfEjN?=
 =?us-ascii?Q?RKmT+YY6yrGrUBknKR4n6oRh/1G3VS1/sqFpI0oDnixqiVKgy901yCZzwRc3?=
 =?us-ascii?Q?QNydHqm2NFHbaYpUSdM8wE3IummeOWtiJkQ9ZMyVw7IaDA6AsoMqK/hGhu6T?=
 =?us-ascii?Q?AjdmkvGijKXGGoMmo4tNVIz7RJgWaqVZNocRZy3kg/4LDG+kOEftV8cQLztE?=
 =?us-ascii?Q?cLZfGXrDBxdmAEN0TKMAL9FRE9VleKQfLKHF9Hp7WPjgGQZVhkwztaPwKcbl?=
 =?us-ascii?Q?YFeruU9t3Ek1uQOpM0FIev3aa45uCfbQOI1PF/1lWoko7eGP4gbYR+04eNl6?=
 =?us-ascii?Q?67ZhCAgI+077qEpXnO+6h2HMVbTJ0iuvUtPIB8ElQDZQZAJ+L/W1F8hFIsPc?=
 =?us-ascii?Q?O01OK/ONFinal9mLNhHU6LtPVIQEmwIuPl9z79w/+CpE4OJZkgv0WhK0Fp+s?=
 =?us-ascii?Q?b6ZXm581lfz58kjlnG6wgV+1u2DUJXP+k1quvVgIIkZY/U+FzvkVz2Z3gxQD?=
 =?us-ascii?Q?RVP18Ml1VP1+pnt6pcKuQFZeJmUW9pxLb8UvQZe1S9590G814jsYxfhb58XA?=
 =?us-ascii?Q?31XX6YuucKV8xNDOd6GgwDiGo1A6Ep3RTxaetokWMP1wHBsIHriMpyA10ZmN?=
 =?us-ascii?Q?gw5qQN10GRNyrJsBtqH9iQrat9ttf9CEtAcSGG/CC7d6HSumkQ3KlC3QRQVR?=
 =?us-ascii?Q?5l5D+xL3gBTNbi+681JKTVtF1rI7HcdxPmpmADZVOLOJYQLDHdosKX0vEG6k?=
 =?us-ascii?Q?SZ60q/JpicaoXwhX8p9WuHIt1ZMByCddJNuaZwl9H1RGuh14xAD26iuPj4Hq?=
 =?us-ascii?Q?nVaplrhftCYvFHrcVPVDMIsih7n9PdKSCNiKqViWzpXz9Vh279lIbNwbZ4Vx?=
 =?us-ascii?Q?nlVQzuVpiRIAymr6jzjeXiL0YL2dLlFXREofbq6L4O3O0Hxbg/7C5cjv+7f2?=
 =?us-ascii?Q?kMv5V2tl2jmeijQlT8zd2Xb2xONMfPaFLpMK/YcQaI7kIEdfYVOH5BRerboE?=
 =?us-ascii?Q?JarvS8J1hznTV23rfXDf+qxZ250yRrequsE0/KS7kKepqllmvJ+/ClEaqebU?=
 =?us-ascii?Q?nbVb48Psb4jBz5h1NOtJuPQXdCtG7LUFdqcAqMy7nLg8mrO+IoCgxMOi9Ztt?=
 =?us-ascii?Q?DUDPdMWWg7V73LF2J0VWsQJ7a4+CbeHwgjvWO6jhKVW2utCAzbHdonjbho6u?=
 =?us-ascii?Q?Sbhj3ssm2n0twFW76rsKHPOGmtRnDi2uVDX8jJmq9/+CuIKsvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1MR4fmMAMZyqDiMmD9xyCiWurpc69erMJVUepoimD6QtMBdYA4omAeh79F6N?=
 =?us-ascii?Q?55YUrxhOKLP9kl2/+ATIOHy/tofBBcrH+SjKX77JTveYC9V2CnKculq/IMeL?=
 =?us-ascii?Q?djzHSl67QWiwyoApfTTET9ms7+R4NGiGMsGmllgWCUWsxoQtakP03S2SDzDo?=
 =?us-ascii?Q?bsIkMo3ZDdRwIzLB/uOBhmvhroFq66UBlXsi+1RFSUkVrvK7rOR/xtVQfvNm?=
 =?us-ascii?Q?6gF2eS2wxmbT7oPyZtuHv85a7EIZyw/7HrYI5ngS57jAKIVvKEHzjLALtngn?=
 =?us-ascii?Q?G6B6/P1GBV7RhnWgJ/+Dq66j8xfwehKLONVDCPUi5tHSdpZy7MSHocsaXF9c?=
 =?us-ascii?Q?LtCC7+G7A6lxfkDpkIMfeO/s8dXwd1QqMateOtTLS01MbfCXxmrVglOcEkYi?=
 =?us-ascii?Q?zGVe+XOAxz13DzcE0JNbeOpyxRScBqmQGKG4KCOx/OtV8G5Xq4eCq8ajv+Ch?=
 =?us-ascii?Q?R5j3tLp1J/D3Dyw0jRGHixeiBIE6Wfuy4iIf5ttR84kSnnJjhFdnsdrKbaaa?=
 =?us-ascii?Q?UKbHfgzmRznT4pdVbsyUKEfSnA2jkinzToyGH5swcgF3oC/21/d+1+ryoIRh?=
 =?us-ascii?Q?M3TKScBHH9rmGOl67AZljCHpR8By534PKuQlmyjyzBHK551FGkiASc8wDr0V?=
 =?us-ascii?Q?0lBP1PnjHWbBRTiry7Spwt4NPgyXVQsQS+z1cZoHxbAHITYeyYqMZcO7Difs?=
 =?us-ascii?Q?qotiayrxN90XM4YHHxtuNLkCfwxfh0fTwqSZlzweI3qMU6pyxV0t3EMVfik0?=
 =?us-ascii?Q?KTbPiiooqtVAsYocBFPge/RiChIy4lT8FRc/UUj0xfuUp0820UH0vyQcCQeW?=
 =?us-ascii?Q?uG1UxQjAVR1oBAaDnw8O5EgTGCbX5ykOmg2MTpspnnCVltswn8Xr6M1DVShQ?=
 =?us-ascii?Q?us0cQOqW54oe0JT6hIMzmEMY383i9xJKJu3wJ+BioEhK0mt443wrUrn976J5?=
 =?us-ascii?Q?PH1uDl+lZ+r5ZPtpHxZHy3H3FiNCKO1SPCITrwDYAdQGiSd9nz4ZKQ/J5pDS?=
 =?us-ascii?Q?FSFVz5q7jq1YDA3ygsb3J/vtgiSpwhGZ7vAWazNfDOebbR0uif2H0p6DoepU?=
 =?us-ascii?Q?iri08gofo7BlSPjCxUBFY6nE/ByPmjVh2fxB4gvu6N6lP+/cnJs3Hj1wokPF?=
 =?us-ascii?Q?vd6EzRdbtIKhdrsTZeBcp+CCtxa2x/PFgL8jabyvO3I3cL2wAIHkSj7BYjYA?=
 =?us-ascii?Q?r+kcIIkG3nF4pM8DIOhNo1vFFXwdJYocje6uCM3Go4fRsIRau/Brq1yTXYgP?=
 =?us-ascii?Q?bVWqlkQkb6yzeNZFJQ6pr9QOqM3pE6Sxo14xSpzKacDjNnbBvdoWvzQC6FeV?=
 =?us-ascii?Q?a6ENE1lehRLFoXZSrMxcjFcL6R1qi3lsmIyD/VtKiuLbMwRs0mvCpfn1pWTB?=
 =?us-ascii?Q?LR82is/DtZ9sQgXYKlTNiZB7MA4ZNtJ+EiVXdQg6xw3/ouC12xRlfUmSV5FI?=
 =?us-ascii?Q?a9mJ3f23yRN4r34mhWE3tpkJzVLbJlKGDEb8pN9xYDWXfKfbBvknfTkxxNkL?=
 =?us-ascii?Q?0VzAGWrylGIuUT/cUqjffoWBUA7IYzem4DeAVVDLTU9X2My1aWpy1N5n62be?=
 =?us-ascii?Q?+d7KAgyljOl7EAFJCZVY3igQ7og3leG7cbmanYlPwkv2Z7De+dfzNTA3DWpC?=
 =?us-ascii?Q?OcD7M0C6alpVG/s8waT8X3dXX8THTFU8C0oL1lvRlCsReUej6Ti7XOqMtjo/?=
 =?us-ascii?Q?ccKjfw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3844b575-c461-41cc-33dc-08ddd991ef20
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 11:18:16.3089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3KoHtQ+FAX3QIhoqzQyWeh+AUSxyQQ9KHqN9KmQLnQfP55TCoOT9zgVPMlVxVqc+TOgRNOHetaNHU+LpO0XGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

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
> 
> ---
> v3 changes:
> New patch, add a generic property instead of adding a property to
> fsl,enetc.yaml
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

