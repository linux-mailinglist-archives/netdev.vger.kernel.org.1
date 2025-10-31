Return-Path: <netdev+bounces-234704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47254C26237
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 285CD4E1529
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA2D232395;
	Fri, 31 Oct 2025 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nU8ANocg"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D9216E32;
	Fri, 31 Oct 2025 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928525; cv=fail; b=g3IIBY2645kufOczy6Cy15BuxjIIe8umYEXSy3+kswB/1IoGjq1YrLRUzQdYJRm8CGFB3VXUN42AwIRgZtaniQk3KGksANCTdv5cK0VnQc+8jqWqPWcxpx3ZCfP1ZZZLfdA5/KcI+PddFBk4zHNZ0UG7cxHOHLQzBge0BMq/KZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928525; c=relaxed/simple;
	bh=Nx47BPuSqp8+Eh6MDbaeF1AL5pRyzoqlDKSxKFYUtbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iGdvvMyV5ip9tpgXM9Ap39+82ba2QAEysgq2eS7HhPMFnkDmSSxfcHA9NC0lGX54Su+YLtHhCj7nya6A8CyZt990Cud39p3FiB54k2gS/z6zbP74jgMIdeORjf0KhDnFgf8qQquyDlbRYnbcz2LwV9V86ptcg9zjnAKHFNKoWqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nU8ANocg; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWTdNgUzbPgehnbUuPcuSmtEtKqKnkv0VPJKtMZaPy5ZlSBwLV4HWNyehFzoXiVd8gI1x+LIOO4y5dgF0QiyOLciQBCYg4UXC57fP4jux24HmiAMQGES60JKimMobNJ+hFeOH/6GJWg6hIloMHjkFzqa6ER3H9wtL6nRDvLTvyy1CKOSlZKj7fm9LRT9dQk+7/GfwM1CMohEnHKtJgZqnnmhHwSMqg0PcZRT/YB3VfxQho7GLHVLSB+zt9FyE/cOrEhoLVoW7IysZ17USTKO2PSOadzPPe80aJzaiE2jIJ8INBuOWIwVPg+cQBvW4lLrMpWhiMudYMfvsxmOw1gD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taIPcN7Yu27XeFjq5HCNywGXMEYihVAZDOrIKiDHYiM=;
 b=KedpARM+rYrTbZX7DV4X1SqRFsdELu9tituF+scy6+jnGHRLdYqRwGfYHTQB3AkttuuytxVpCrDE4ZoJOt00qkGapAMNlnuHRfUNjnapc9t0QedyCaob2EnUeuMzf8SeAOhKM3KyBsH02kM2O5IJ+Z2HOvwLqhgVAltXS2RZm0eOXXqb0X5WxmCZXm4ABrScNX0FJ+VLteZiGAI0Uu2HYT5wTInHMHArpSLbeluqOY4onsMqJ55yB0icYVnu9moGiBiKhcdIT/92gRzIMKPg+huVtAhx0zJglZkAmSvkL2An6f/rcQuDJ659S+ygVX9Zea8EuEzvkGOLpPRFinl/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taIPcN7Yu27XeFjq5HCNywGXMEYihVAZDOrIKiDHYiM=;
 b=nU8ANocgHnl2SaMqyLf9SiqPu5LNqSuJJWlPatmV+xfsJQXVBAUVn7xWwzP/iqigP3hIuDUykRcRVpBjJnQPHSYSI0FHkyok7FUkkutviqoWHwnhXT9WapuN332iQnlXZQ60TZX/I4bh1WXFbixEjR/LSgHU9j4UifQbtmElqevDYpB0T/Cb9iRuZHOX5ELJSzNLXtUASMd0jCFS0OVoPs6BANwNnjXND8KQXxEefZ9WYj+97fd3wrkCq5nZupuLPbccLTTwyB4Prks5kqUwt+VApHKdXfqHHFZlhYoj+m2C7BC/ghMzYUMVWBglqnHVS6fm6rxPTqihEW1nTlP6NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 16:35:20 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 16:35:19 +0000
Date: Fri, 31 Oct 2025 12:35:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: jan.petrous@oss.nxp.com
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Enric Balletbo i Serra <eballetb@redhat.com>
Subject: Re: [PATCH v2] arm64: dts: freescale: Add GMAC Ethernet for S32G2
 EVB and RDB2 and S32G3 RDB3
Message-ID: <aQTlPgDLRwOhzD/V@lizhi-Precision-Tower-5810>
References: <20251031-nxp-s32g-boards-v2-1-6e214f247f4e@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-nxp-s32g-boards-v2-1-6e214f247f4e@oss.nxp.com>
X-ClientProxiedBy: PH7P220CA0040.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 36388238-613e-4263-aca0-08de189b7a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|366016|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t+hIyh+tbqtoHNSeeclXp4G6X5jc8kkPrMK2um3CebFRGlHZo7kfjwRTva9/?=
 =?us-ascii?Q?XGmgaf8JBwAbpFmBRZRqUzM3imrxQiAsIAkANvpsZsqFxAgt2bgiZr1T+2dP?=
 =?us-ascii?Q?GKe8Ww9Gigu8ZyPwn80fDAs8eDNCfK4vuTZVbgb1pCGoyY5jqjjDcHlMf1lr?=
 =?us-ascii?Q?Yigw2E6GscFzvFVbrHnYIA5u9SJ1FPOkNyyQrm/BFuygn4S61eZRiriwMB67?=
 =?us-ascii?Q?etPznzo1gBV1MAZy4LpWKkZTtHK3XTSd4rjy618mI4JOV/FiuIq+p1hPqvop?=
 =?us-ascii?Q?FKNOL7Mw9oflJyJUKJfV8DW0ScjDiwrh2706mwW/aUiRX0W8rsNS8SV2b4gQ?=
 =?us-ascii?Q?dClCk6ugpuZzgW6h3sAeWc+rWtkraE7w86+kEVLlAaRXXIT5VvOa4RzSpAJy?=
 =?us-ascii?Q?Ew6kBDpgPMYArF5svY7spxpfZb7oNO9OPJL/XucV1+CwLTXT7uREoB6zcFv3?=
 =?us-ascii?Q?6dTqSdGi3IiO3BCmBS0Cdz1WOGZTVOZk3ZtjdQho6MsD0tOZHsj1uL/hCuvS?=
 =?us-ascii?Q?ECa2P3EHmGGVvQelnH6b6jg2gHOKu/rtiiSR3YvMaoQ5+PMnPUkzVE2d2GF1?=
 =?us-ascii?Q?zQ+Px8NT69WkYJGAe1jpu6eJIsmg9CjtT1yOYvI5xo4iM22WTVGrbfPmEOJI?=
 =?us-ascii?Q?S7i6PwxZ3sjx5EkmWumYmxL+9K7T/FT9ysVPqrawrqogtp8A0OUF4nwiAtPI?=
 =?us-ascii?Q?jqeut/UNKoIuIRhqBReOs9r68XX1v7u9/o/KlMO9qBj8eeSBt+X6mywjaoau?=
 =?us-ascii?Q?mz2NDOZP1vS3okUCj+EEySJ5MGUPAQBJrztSmhYGGHBVfSSnBZFSiN0SlomZ?=
 =?us-ascii?Q?Tf1HY7lOUsc4GxKx6/rLXeioX31CARZ0J5l2bA05T4eeRLrJXJqUC/igoqTu?=
 =?us-ascii?Q?69jFVeAgdozRljINmuw4TwdqITmTNv7G4qGm3wiHaZWbDzvIVP6LR5LiRw08?=
 =?us-ascii?Q?WeexeymVyKsOuV2JeQa/lcAcxjawOoHNIMmOutOgdzhFFaWyqEDFvN3W2fwP?=
 =?us-ascii?Q?eca1BC5PLr6jR0qtbkgdo07TJ722l4P9Ee1juRAroKLdcpxPdaeO53JzvCFK?=
 =?us-ascii?Q?GTbwnvDTZ/r4k7tgf8B1f+I5epqcMjKw2aeizq1gTjEMQv8P/zMUUHGx79dk?=
 =?us-ascii?Q?q3vRTKyyDuJecpvVRY+7kQK49ciIPRYKJrGfdQSyozs8vSHwUbOLWMoABH1t?=
 =?us-ascii?Q?qCvcUe/79jCtsC4UTdkQLWoOEBG80gd2w6Sr2AihPpMdCZi4ezro2A9y13nU?=
 =?us-ascii?Q?YMTaNGleboxBOe4n3QoH1nNUOruAy82WrgW5oWyeo3kKRxdBEB1+g7xgfxVK?=
 =?us-ascii?Q?ZJ+5g8Dw/ZdmK+1favWq1Ycrijp6Nu63JDzcPuAp2bJM3edwR59tb324MuTr?=
 =?us-ascii?Q?1hOLf2morLK3C2ymRbUO7yEhWTDJtB9rkOjXveMEl2MGUuFzE01QGRhrenM8?=
 =?us-ascii?Q?reSf6G59ivn+lGu217Poeej93PwrUYzcQBWvQBOeDG/XmBsKhPmWqlCbd6Ld?=
 =?us-ascii?Q?bMpF0ho0zOrdkcKSRdK7BPjFFWwGhMtJvSch?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i56o+SDhZoZHVRWzYho6m/Ldryb/zXEUDp2TrY5DhGJgsoBQyRy7/PEhvidK?=
 =?us-ascii?Q?bNaIbJ4F70yuAzp1lTptNHDLUn+pZX2MfvVoUoYnn8I2rIKVtNYhR8KYSbEs?=
 =?us-ascii?Q?8wuJYcloLtIQmTvlX02rvecaGqgyVOffNHuDG6U5xDi7HZauSl6iHsGIo283?=
 =?us-ascii?Q?jm77v3ena86iLfXEyrOHOPTWWPoL34gcM5NvLxZEd/bjsBiUFiG8L57R3oQG?=
 =?us-ascii?Q?91h2+3fhhi3eZHBGVEepCKWhJLGg/zVzYjtRJnpBFbDTBCFrSgOiYZt3jWT2?=
 =?us-ascii?Q?xn0+FoTUVy8KLq4dyBDn6CL75sdIr+FYOumfDPWj+1cZhlUhC8cx8+E058mN?=
 =?us-ascii?Q?wbmjR4u4IvbhSBSUmqlNFbOY2UQcTJEnPLkXbno1cIq0P7LoiH8GvBuUHoa7?=
 =?us-ascii?Q?h5Ju8dXrmcEPsd+7Fg/fOliN/FnMkUgZnbGCFkqpS8Fn2adGb4i1DnhiNMfR?=
 =?us-ascii?Q?dEqxsdsJjs3PmAIPULQ7k8LPIHijE8aNZqTIqsZxTZ/9vEl5apl1jGOx11fD?=
 =?us-ascii?Q?/+KTUzEoeytI3WFicvPeGPO0p5s6+fbwN/1bLLhIjyDTUbV8BjEUKbe/CW5o?=
 =?us-ascii?Q?8HVwR7e1tJd79Ib3ly31WvDssTKrm1faD1PAbR87/NZYv6p3DhWnP3JVc+g3?=
 =?us-ascii?Q?9JNtfFe5xLUDANDkOYrEd9e/hix8U/wUF5odm/1pG0d/Z8zgy6bfNSuco7ri?=
 =?us-ascii?Q?NaeHsxPYOIHpxHr/44cbp7adk1TS6cUfUqa71hDts83T6dYJ9Wv6a5+DlKL8?=
 =?us-ascii?Q?zqCSJ78zq7x52pfk5evNLc9n+GFtF7ER/zQS6mGuUTWHdFqSi5qzec1WmnM4?=
 =?us-ascii?Q?IJSMDIw4ex2Mtp1amxDYwppmle7d5ONup/eDuHZ4aY/LCPXCt2/WezQ9ZkYk?=
 =?us-ascii?Q?j4A2tIuzkwZFy4FB4oOMItWd+zvqV7ldP9ynGwl5RDS7AjQL4u3ly0q7+YVI?=
 =?us-ascii?Q?XsptE4Vs+q8SfpLVMl0/KDoYguI/9LBkcl9XdFtN9dNs19eF4HLOJRpUEy1O?=
 =?us-ascii?Q?iWrilElXuqKhIz1pAht/PxFRik36t7SjxLVQwwHT7y+mYzI3Gad95NdDUK2i?=
 =?us-ascii?Q?EO5+eajrwsEdrW1Meu0Xrc5SnOd74jZMgc9A8uichCLWb6r9xlQjXBtPBda4?=
 =?us-ascii?Q?a1rxq7V2KUGWNEG6mAXPenCnx++Ns2qgRQZ3cbUdDDZIEkBm7uxqGUOtNKsL?=
 =?us-ascii?Q?19d3aj0jQP29P6s02HdYht+Tw1iEZ6kJKKkLRzIiueXVS+xh/FegfvUR5mg/?=
 =?us-ascii?Q?n66Dy9ufsnsOkk9SpdKzCsCmuLD6rVHWWeWAEm0/rXQpEFi4ZQZ6PQ77ulJi?=
 =?us-ascii?Q?wdgvNyi1H9lF6KJwQBIhCr1g4+v3KV9aIWD9fLYKMrPn25gcym10uodwvbAM?=
 =?us-ascii?Q?6PeN8XVmp/5iwVvyWgQZ8HnoQ0gTxbU+o1wBgPseT3ZHBhOVm1jPy3AtjXtW?=
 =?us-ascii?Q?wQsNG2H3WwEZdwW9Rc3r1x+ypqmz4dZTPYrdUcqIthgd8msfWqIx31+HVnjL?=
 =?us-ascii?Q?sC4psu6fRgXVl211Dnc0zmKD63INLKxph7jJoByXlPLa5ketqLM3xUhLvdZ2?=
 =?us-ascii?Q?sC2i5JoW4Db3obWUfuw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36388238-613e-4263-aca0-08de189b7a95
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:35:19.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7hxJ/wJ7GdgXD4x65Wj9hsHcZxzzYDUbSulk0scKULY8b89dYqEW219bMW9PhRQ7jmTmgeNaztQDctE76YsNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8198

On Fri, Oct 31, 2025 at 03:06:17PM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>
> Add support for the Ethernet connection over GMAC controller connected to
> the Micrel KSZ9031 Ethernet RGMII PHY located on the boards.
>
> The mentioned GMAC controller is one of two network controllers
> embedded on the NXP Automotive SoCs S32G2 and S32G3.
>
> The supported boards:
>  * EVB:  S32G-VNP-EVB with S32G2 SoC
>  * RDB2: S32G-VNP-RDB2
>  * RDB3: S32G-VNP-RDB3
>
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
> Changes in v2:
>  - fixed correct instance orders, include blank lines
>  - Link to v1: https://lore.kernel.org/r/20251006-nxp-s32g-boards-v1-1-f70a57b8087f@oss.nxp.com
> ---
...
> +
> +			gmac0mdio: mdio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "snps,dwmac-mdio";

compatible should be first property,  Move address(size)-cells after it.


> +			};
> +		};
> +
>  		gic: interrupt-controller@50800000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x50800000 0x10000>,
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> index c4a195dd67bf..fb4002a2aa67 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
...
> +
> +&gmac0mdio {
> +	#address-cells = <1>;
> +	#size-cells = <0>;

needn't it here because your dtsi already set it.

Frank
> +
> +	/* KSZ 9031 on RGMII */
> +	rgmiiaphy1: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
>
> ---
> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
> change-id: 20251006-nxp-s32g-boards-2d156255b592
>
> Best regards,
> --
> Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
>
>

