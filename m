Return-Path: <netdev+bounces-207568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE15CB07D9C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2897173DA2
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957029E0E1;
	Wed, 16 Jul 2025 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="buJTPI9T"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF6293C78;
	Wed, 16 Jul 2025 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694111; cv=fail; b=BZmIwRe577OcO7IUshpRqQfCNQkvtXfjUvO/ZwH/Bi2HrP0bG9buKvmS7G/6sEnvcSQFdF+njMa9m7FsOrgH2C6KIje1V0dGlDmC+R8aAfcMkQOEyVJ47+X2YYKiItJb2V7RvEEth8Muo5rWR3UY/O7lybhKhfLlbUuK9vf+/sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694111; c=relaxed/simple;
	bh=7Z9AM10fAOA/5764v/NUqJiwpL/xYXwYgUIHjYhQppU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c3ik7F8bVlBA3H3RdRdDsfnrRNB7hSHy92Ju+73q2VpFZmqHkJaG0cOuRWzVTt11PkXe8AMql+8DO8D6KZMl8dh7oGAFWr40ywcC0vvzix2AW5YUGlXz2ZNF86bHoRNQ6wvn137UsNxoPW4DJZVL9eZWVNEUKCU9Ka8w7qalXHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=buJTPI9T; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Db+MiDqudUsoxAerVsjV48UN20VDrRDHybL5CKt6J4csDqsUz1f8fWyRcvFH+k8tfuZWB5RgsDuYy/rCJi+i5SpImiOZ7iumUrgpI/k8Fui0AhuSMp+nUTzINjKgmmeP8hBlXmO97p9xuev9t4HIkzX2eILW/AE9XOcsya0vmjDhicQBOrCJfbDC2S729w4Q5DteIOwGFHzV8WANfjef62L+c1LMterIhn6mKyHLgA8VBOowB9m6lJVw+HEsjPvncB5meZAX0m57Pu3a7knbuW81u3ByYpTMwAa5svAhtJVclaj5brAjS1QR6hUZdi1AOvgZVZqusymdMoQ2phjJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDxKg1c4cwCtfQb1Ki5h6PYtrIdWfZLJNsRVOBE2c0E=;
 b=I1uLxK1CihgvoS1Ee50we7ffzeFXg7csr9hsj/TwC+clUeZ7Zn+kr6Gsr9NNgkZA6ybXpXZdwCXb61PngSSjeTehTjtmQ7RVk2peYAc4Df5NwL7XYvxNxZRIC8Zwx6p0QeBEUn2PWz+XraWl8AksA2KJT5mZ9c3Lx0YaF9R6PmsHRjMj48y1jjRdzg2GZLj9g9vEpFfzHQTM4Ya0X4W38CylTduorTQ2tX92Bt6r2+rDf8K0/+i+gm+kgZJRH1T/ps8qViUDs5Jak4AHWK34KzHQVN3OvqJZ0h4Elygo3Qpt0reNF33KfCkOzPd/pQA9DrPO6KUCVabDTApHlnVG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDxKg1c4cwCtfQb1Ki5h6PYtrIdWfZLJNsRVOBE2c0E=;
 b=buJTPI9Th/3bpqhIwA6zAlFiOI1tEmH3yWtJJqtWAz2IYpN5wf3ylq0Z0PeViu2pkzdxr0dlTMo3ns4SjNC5Uu078goP3tWoCWXyn8sxTie1QdBuzZoxIzDRVcGcmrUEDmEWmmNDh++XJefqJmye8M5Mr7m5z2PFnvrJbin7/VsSpNv5bEob1bT8zt+okhIMFDsE0c1cOgDAwJ/4xMahgRuI2G18MqSE+a/XVnPk6q2F/yAjjsWZbdVpAhSXjcg+xNpGbsN7ylCGCmwBMHctyhIl6gC4nr3FkI/JDH+UQ/EE60we0TVxwvG83+W/dS8GKxUIaIs3U+wi/GPB97bNoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10022.eurprd04.prod.outlook.com (2603:10a6:150:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 19:28:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 19:28:24 +0000
Date: Wed, 16 Jul 2025 15:28:17 -0400
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
Subject: Re: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Message-ID: <aHf9UfUQggd/Oxh/@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-3-wei.fang@nxp.com>
X-ClientProxiedBy: AM0PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10022:EE_
X-MS-Office365-Filtering-Correlation-Id: 6956d8b7-fb66-4e6a-fd66-08ddc49eee44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hEXXrfOgKrgQqSQps4x7RaOOK29zReKAeXjrq0Bc7WrfqVJaVTOin+lAVytP?=
 =?us-ascii?Q?sgJTJ7dt6FNgXyEohg5dQujpBEI2UD4AALcb+aXv5d1nRSZGwldmsGTp45Is?=
 =?us-ascii?Q?I6TjSMTc39Wma4IbN4dy9JPH19Mjd7mwGf1Zb1qndNAkzG10wqLyF+zFRzUq?=
 =?us-ascii?Q?CRVRgy+B3jW7Cq3Ja7mdALGE3o4/p7p2RRCwgMsu/m01fALhoroGfKJJnL1s?=
 =?us-ascii?Q?mR6sU4tGFMkfWwxb0bPj7a7iLPyC5mzjYYPy0jSW3wlrPJVjmNowkeyWZbiZ?=
 =?us-ascii?Q?rAeA04RtAkLBy5hCVM0spa90alhr//BiNRTgLElnXGbxIM4h+C2VRkqHN4/y?=
 =?us-ascii?Q?6dkobRPVtp0njP4JZjVSlcIPu8mDtGSChj4v96sf0Ma86l7XiXK73zm98/V1?=
 =?us-ascii?Q?/Cm3X5bQxGgm103/Kwy+NVV4if8RWm1zyJiebKvGGCeRWXSURTsLLiqGlvjB?=
 =?us-ascii?Q?kPrPGUiQowuc7p/hdzYqSdIzZW0TIYP93efE6Jtqn2GsXQBbjrch+R4yK42t?=
 =?us-ascii?Q?KYi8bccyaPmtCXN37HySK7fi9so8sEbiU0vj+IsgNMVBVALFMOaE3ZwF9dEe?=
 =?us-ascii?Q?7vfVRZRdAtUztijHgYz0Mudsv/OalCT57pBCtTWWHTSnAWSBJUgm8WuCO/y0?=
 =?us-ascii?Q?a9NfX95e3Rg1xQ2hw4bmGCWIA8gpQMeMO+lFmHVvDbu2D4MrW1oDuHyAVDx5?=
 =?us-ascii?Q?dc5QwY4VnhGVDwa1iv4xXPSa66wYXwBSRN5eL6NooWu3aZcyOewXLIeQSlnf?=
 =?us-ascii?Q?57u8uE+zr/dS/lUYqotndTcwGwHW69gtJLIgom7uCI3qbJ4ni0ZBgp9HDwcP?=
 =?us-ascii?Q?Yc67VPqcvo5VcgnJZhaxU+gfG63BEHJ6HXUUzkIwiHh9zr/viyYvEGnKn62J?=
 =?us-ascii?Q?bWW+qYN+bgSXpvDLlR9HIfirZz/4gJ1zjACCvPyh883dub1Wh/5RSoNTpF+a?=
 =?us-ascii?Q?Lk1teuNxicwxMjAZ9mpWreyb552Jja0ymDdc1BGbEQdFMlNouzfwSYn8TEz8?=
 =?us-ascii?Q?OZ2EWNp39KpFBlisMCHsDFFegpCdT1s35q0jn0uUDsVvoLLqYnxQ2RVR6vdt?=
 =?us-ascii?Q?2mM4I7peFFi9eEZZe2YJ/Z2v3cvyguIJz72cvjNJmt9UDqBL2sBrX0TQ0ucb?=
 =?us-ascii?Q?8miN8y8VCvN/0NJAEJb2+yp3g0UOXvDxTb0Pa5CBP1H9x0IrHL7CYTnK6Z74?=
 =?us-ascii?Q?idxNHDBtw4In4TOOVkTxWr+dD3BezU1ZhTLFth0EFMlmQyUug9RUiupPBxWp?=
 =?us-ascii?Q?AIE/1DpS2ugAhET75rTBdfdrkn33OPkmnYdooh+ytWDbnjloib8Y3XG/7HTD?=
 =?us-ascii?Q?s5L5rzMcGRJF6ikyZioWD0PuLuVoWycB0VitD7po+VB4yH1WIV02vfCGi36t?=
 =?us-ascii?Q?cWeSGUu7u+IkSmG/Z4xUwKo/yHs5ph7ms3fHvFuuJyJfo+Cy5mcLic8pF0DI?=
 =?us-ascii?Q?X7MQTgOcNJ2b2Yd/thkJOr05ZSzlbDzHYpQmJUS/5mByqHAhOUHbtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kVXlebX2iFpm5MPAvsD9Wmg5rnPvuaLisZAbx80GRrRkiK7fpnRJxYzN6HdA?=
 =?us-ascii?Q?T92dZjAYAOPYqLzGAteqkneDZ+xANYcyiLUUKaOI/GIUXN7zEvopK4Qp6MmT?=
 =?us-ascii?Q?2hT3B3Iv1mgpy5SzMGFYELTWKjESWC7NqvBiwwbh/iC/XwPHU3LQUcsGpKv0?=
 =?us-ascii?Q?DJHzV722I3yB3evPIf9Jrj8nFL4mGwSiHccEnQKpQs8bME6T9sLWUBzCYQSC?=
 =?us-ascii?Q?mQx1NL72TP/AKtE21+FnUBIlHTgiANWddCDQQlXEU7Mc522tiNVawOg7/jmM?=
 =?us-ascii?Q?ixYd8tiJIlkp1blPQsMyX6r4A07WA+9LOfLxTpCfvX8cA3Oftet63Djsiv7B?=
 =?us-ascii?Q?G7rCC4AEpMj7qOPyVo9i8uEU8s2oiqYlXvXIpdrZxVzJEOCpKI+Edo+TCrcr?=
 =?us-ascii?Q?sLgSRqmY/jscnK3bKx0v2OeD9knMpK7DPNN+74Qv7lOASvtj3UJB0K/Xs1tl?=
 =?us-ascii?Q?ztWo7f8GWgUgrTm2xWChIeIiWHQvEV9PzgBdsDSNmnmKln5QNjDNPK56JyNS?=
 =?us-ascii?Q?yy7dqkq3PmlprbRHj1RAUegcWdlgehYv9Si8eREgK8UrLsImh2OTe3AoW5j+?=
 =?us-ascii?Q?BkIYFKZ3f+ADmhAH0xqzRS6+wQLCA9cLU7GYBy/qxJ0lHWI/OozSYa+Samu+?=
 =?us-ascii?Q?N7jAMdivqL6xiHgWPxEp4cuXF7NOPH+JAQtE55pOPSQ51YfHyjKBGjBkbTx0?=
 =?us-ascii?Q?8PRp86HyfuSGWSwUoVMnAGzELy2d41Z3ov6AqxR9c78JFytoEbLFHzYICSUj?=
 =?us-ascii?Q?dDKUC1JYYI0AyZl+f4PS2tjDEU9v+cs2ENQ3JIGoCs/ESGv90SZ4mQoup/ew?=
 =?us-ascii?Q?lbyFPI0dqCsoJySpJLBPXNfwEo48RoFpa04OXk4gtNo1698+EN0DHIrpKfL+?=
 =?us-ascii?Q?CpgcyFhtlDmcrV2lwgExsAtmFQhvFTFdpQ98xxPPHREU9WlBs66cCXlctMvR?=
 =?us-ascii?Q?tMBAQCVIKNpzt/Xexz+zxwqQ6LK/XM73G0eng/W29KpI7XVrFjFlre0Umu29?=
 =?us-ascii?Q?x1pcvdY0T5Ow+R8bFg+VeHSzgqQ0eqSt8y3GRl76kNhCFVm46ZdOvJl+fxyM?=
 =?us-ascii?Q?PY0ja2jst9Gq0rRRnP5YkS8jETTJF7FSnZhhl8QBDz3iU2exVEuyg374ZjSS?=
 =?us-ascii?Q?Q/4YfCkLoGhJeBfbsGyBOy0WaakTn3SGQbBVdMsbxs9dEzT2yKddmnxqpYDL?=
 =?us-ascii?Q?sYW7IJvK8bwKYk2vrPKsvD+Owv8oAsE3BDUBol0mF14E4clA66AcqrwnbUZc?=
 =?us-ascii?Q?/Cd57l6HmnnI4cOAKpq1LNzVrAQAWgHlOmL1huBqAGAo/k8BiiYIzH7sGnhz?=
 =?us-ascii?Q?WqwMOn+Kp3PJkyZ2kYvtRbOij5GBanmxd5JDLn3nnLqEln6irCpKd47GALzn?=
 =?us-ascii?Q?+qZyzZgtnxI6GyURJG6Q/ImrG23eVKFMuH8CsdZgSS1q853nFQ+6WLXor+56?=
 =?us-ascii?Q?xjuNRkdAEAlzj7IZQl9l51lduJTkJ9KRTlqwwrsaSFmZN9avS+MqvwkB0/6H?=
 =?us-ascii?Q?p7IWRU4YGzBfjNRRr5P2yAo2RH3Utx9ftFLjf9sku4OHp2VNGHPeosgnuoUP?=
 =?us-ascii?Q?d0wQFgSOc1wp07sb0F2132WXYwC6vmcMZmehcvXC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6956d8b7-fb66-4e6a-fd66-08ddc49eee44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:28:23.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x00aB8nda0pfUVPfn1Vd3Qr3BqvW3hmiZfSqX0zNVPUZuNTbwNR7DYknEW2EVunzN8lNtozQ0IJwBAvvEpaZEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10022

On Wed, Jul 16, 2025 at 03:30:59PM +0800, Wei Fang wrote:
> NETC is a multi-function PCIe Root Complex Integrated Endpoint (RCiEP)
> that contains multiple PCIe functions, such as ENETC and Timer. Timer
> provides PTP time synchronization functionality and ENETC provides the
> NIC functionality.
>
> For some platforms, such as i.MX95, it has only one timer instance, so
> the binding relationship between Timer and ENETC is fixed. But for some
> platforms, such as i.MX943, it has 3 Timer instances, by setting the
> EaTBCR registers of the IERB module, we can specify any Timer instance
> to be bound to the ENETC instance.
>
> Therefore, add "nxp,netc-timer" property to bind ENETC instance to a
> specified Timer instance so that ENETC can support PTP synchronization
> through Timer.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> new patch
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml    | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> index ca70f0050171..ae05f2982653 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -44,6 +44,13 @@ properties:
>      unevaluatedProperties: false
>      description: Optional child node for ENETC instance, otherwise use NETC EMDIO.
>
> +  nxp,netc-timer:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Specifies a reference to a node representing a NETC Timer device,
> +      which provides time synchronization as required for IEEE 1588 and
> +      IEEE 802.1AS-2020.
> +

I think it is quite common. add ptp-timer ethernet-controller.yaml?

Frank

>  required:
>    - compatible
>    - reg
> @@ -62,6 +69,7 @@ allOf:
>        properties:
>          clocks: false
>          clock-names: false
> +        nxp,netc-timer: false
>
>  unevaluatedProperties: false
>
> @@ -86,3 +94,18 @@ examples:
>              };
>          };
>      };
> +  - |
> +    pcie {
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +
> +      ethernet@0,0 {
> +          compatible = "pci1131,e101";
> +          reg = <0x000000 0 0 0 0>;
> +          clocks = <&scmi_clk 102>;
> +          clock-names = "ref";
> +          nxp,netc-timer = <&netc_timer>;
> +          phy-handle = <&ethphy0>;
> +          phy-mode = "rgmii-id";
> +      };
> +    };
> --
> 2.34.1
>

