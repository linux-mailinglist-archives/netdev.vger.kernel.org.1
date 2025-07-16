Return-Path: <netdev+bounces-207574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4504FB07E70
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650261C41A61
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C9A2BD598;
	Wed, 16 Jul 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OOaDMydc"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128B2BCF5C;
	Wed, 16 Jul 2025 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695921; cv=fail; b=JRBKgpPEaTw9RXeyrYF1Ladx4EO7y6XdU6ga1ZPyKFowP8nFb228sVqXSUcT4BD5tWUyGKhtCBqfKS9R+nnKP8JsW7vC9Mr2VHPn8bjXlr2a+WyleZK54s8W1wdPwiYKwj3a40nkPNHqT94QPBRZ1xoVr6rBWjkxrqbgh7oC87g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695921; c=relaxed/simple;
	bh=PgsOXuZki7kUnfb4z7wYD0iB4JcjWl0FHyP/+8F3SHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BY+sQIszM1irSHKWEbxzlX1+GjAIWCQbQPNJg9J7VqUX2shR1gLXdRTCjaJGnxF56ZDfaLtTTCITBtKR9/oiaMntVUNEjhjTwcSBwVgK5pVi3a8JVmgoCQLUGeblzSjmiB8l/eFRCVJEnpNPrOq+8iQdefLEj0W0wuwFNsXjZsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OOaDMydc; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiAyPv5wTG/0rwjmd9Vf40o8esfcz/Q8ojPnpS6sUqBvRoeAKJsOYGSlHnEirq8SpQnttQDl0fzqknpFR2BUlV4H8/va9UPshfmKDTAFGIJFtqN0mrDhvh5IfmMvhlabNLTJwL7VBy3e1uKVd9QxkDgM8X5kIFeZZIyHvDESWfcBL5UFWdBzH8A7Vmfrt4506dSASH2+KDGARo/qlOUwDyq7bL/OaZBCupfgmhT4IgyDGBA9SuZ4Yo7/1G+JK5pRit5/U3JwyaWxFv3GxyEbzyoK0fTv0haT0SzTnkVDcaMjq++sNuS0jkzNgPp9fTXT4gRKGaIGY4Hx/nGivDqc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AeVAxuL1k9E49FC1DKrtjPmqhl4sFjaropXpfQKCrs=;
 b=wuGEiTaeBWIJFZjnQ6UzYy+taCgMwj/IMyUfMg0f3aZeMKpUuV1bfYFpWa5wDK8SOhWTwBs2z2O6qu5L8KWQivsHDzfFZ1IJdRutDXXzPwLzKXXyl5eBS2yIezxHUA5Nse7SPC3hMy+LLrKyFM/BhaltHkifz5+4JBU8e9YMJKCw20B6zXoAeIOYF4STTMBtEdyYxEggaNrB5kWUxVPqAIMp1yIJ4uMY4VRRIAlOpC7vKhtG/VuMgR2Sx9Na7fkYFFiWcuVNwimuz0K0VTo2U9rQHrFE2akpsCPVVoPEBKPPk+FZcEJPedeFW19FsL9xh82/DvlCDOJD/WRGqyVWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AeVAxuL1k9E49FC1DKrtjPmqhl4sFjaropXpfQKCrs=;
 b=OOaDMydcy0lOgeSK4UntCjQLgVD+LZbMnm/7WE3FqzWAadoBOfiteFMEWEt8fbEWhJPgPbBBbTNj3r2l6MYYnR+twgORDAd81X19c6PXPCTv4SmSKBoisA5tbVxwWXHS+PGk0HhxXpjdOIb0Li7vdYxDXPYaH43oFkMrVtlmZBuCm9fWUWgY6PFjblCNdCHJj3PJGOadrZ5b+Mg3SpXiMECds17l+xeBTJWgGcD6SBV1jft5ke2c+FNd/yyME1dA8Jy4GNkkrtL1VFSRDfUJh1lnfV/WHZV5MSdwC8Te38xpLPatUHBwDOdlJOgCW02P4R05dG0u6QnO1CCKU6TqxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10876.eurprd04.prod.outlook.com (2603:10a6:150:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 19:58:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 19:58:31 +0000
Date: Wed, 16 Jul 2025 15:58:25 -0400
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
Subject: Re: [PATCH v2 net-next 03/14] ptp: netc: add NETC Timer PTP driver
 support
Message-ID: <aHgEYZmv+sMYu6/I@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-4-wei.fang@nxp.com>
X-ClientProxiedBy: AS4PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10876:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dcd979-98ba-45ac-e64a-08ddc4a323ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RJZu0p3bAv9jwkkwIBEySNPorq26+coDSOPYNWxctmqielxS8rBOd7k80Z0H?=
 =?us-ascii?Q?JJxeHlPNDYJpXIgOYA0yK9VY4FGuWdzkDFqNi9ERPyEg0/1lKPFWBzRkn0ZS?=
 =?us-ascii?Q?JV8SZ1+k5RMwO9YgT7IJ8WjtWI8MeCcTV9HUkzDNOyYFjAxPcPSBsqDIcOeN?=
 =?us-ascii?Q?tphlSw9/jZYgxSgT8ygQ0f1sRRD+l8JVOkMlOxqVyJnGao8HFM53XUKg9sPi?=
 =?us-ascii?Q?gn9Sv2Ob608ILGPnzibKSgaC+f7bDol6mJ7NbJxJARyF5GVJspI285ZBX+Bi?=
 =?us-ascii?Q?O20WwOoykDtjhj2bBIvJrTJ4RAKWqgmkoYLvbyVQUcXreUd38LXEosO10QMi?=
 =?us-ascii?Q?PjtK9PL6iF+WaAC+9BMA6pdLPYYJxJ3gWzXFmirfQRswc5oM0ysdlrpGaNSx?=
 =?us-ascii?Q?luiPIjG3iK5fofZqHCTQ4z2TmcXnYKGfdKMlTI6Cte43IcHWbU2QIscg5PRM?=
 =?us-ascii?Q?VcrW/93SGR6t0w4p23Oik45hh9jFDIdX/Ra8Ocq4Zj0IFo9TYGDMeiSfgmY0?=
 =?us-ascii?Q?wZYgCMFab9oiveEfyVLmHPBilI1K0Qa5GmwSK7gl7eMtUA2Mhd+blHlpWNDf?=
 =?us-ascii?Q?6lAmFaleFny/Maom9CT9JMc5+aqgoyKhp5xF+mwfg+9FkQJw4K5dfSuUjnQV?=
 =?us-ascii?Q?fP8igVtuhm6+x4iRiKjnzQrtXDyIS/iR/dBmwmRR0V0TXCt0b8cMpk3E22Tb?=
 =?us-ascii?Q?RcsbZgdv5MfesDjnnX9FwgVLykAMel4RQW/z2uBkk7ihP4J3sKfJYSyyNxow?=
 =?us-ascii?Q?PpG2QmfQv9HPHW8gntIIrWZKoVrVzAumc4jxsqLYnedmCVn4NphL4FuCCWaD?=
 =?us-ascii?Q?eGI+sx9FYDijim0i/s5sQfeqDZ4ewQ4IxVnKRu2GgDHyYphcBKy2QlecZ6Q4?=
 =?us-ascii?Q?sjxEysO32Vwx2Vt0tWwGx/JbY5BNjtAeufYJO3KMrDyjjeATIYvLzvy6JxZo?=
 =?us-ascii?Q?5LvdMKdT4S7xkLeg+0J05laEPCC6IWUcMBRKDedrsFRXWpYNcQyxHkN39KrZ?=
 =?us-ascii?Q?vq6VY9ShEDk0eKiOpU6go0tILGfYqjpI9WviH0tX1SI83JUjRJbpgtYLaKTk?=
 =?us-ascii?Q?k9LTam39w72XF0eoMcGC+20WTS8rkVfgKsiuU4G9JBgre+d9KL7T59E5ZTgf?=
 =?us-ascii?Q?6CFwK3HDB7PhwtnL6kb+SkmwOtjP9SvFcDaaJYppQ4msT6vdzSjc6sXG+1Bk?=
 =?us-ascii?Q?326zc0JjHlbylmF3dcY8jIv63M7fV6Fmb8puk6mzk6D6dsNXNubEuAH9RBg9?=
 =?us-ascii?Q?o1osf+4RpGtiSrBDoGTnpilKbTXQW8ccoq8oZpNw1b7l+O61zQBYinCCXy1n?=
 =?us-ascii?Q?hehIIcBlZ6h/cwHHRp22r2kPsHu3aqiJSIEd5ReBj474yjumEA0ImDNL7P4G?=
 =?us-ascii?Q?D+k58GROhtq2jZBDcGGFXvkYPaTI4B1J8vJp8PhZm6Q8ufR/Eh489QZCO46m?=
 =?us-ascii?Q?TOwAEPtfGgconzQ5kCsZbxH1Mie/F9iBVqPWTFLK9BUdqeDKkhHYjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V1ZRTyaUNv4NOYhGCf5S8TJY3N2awwYR/easqOlF1dui+WO80rpA+AM7DnKI?=
 =?us-ascii?Q?FZxPGXMkFZ7peEhZm1Qoj6t9z58GXyriqzwVYmPuE9HiEFAJhzhFOjfVzX8v?=
 =?us-ascii?Q?C5ZrCw3KZHzK15aM3ictd5vwdSxH5KaYwNPsJkubHG9vhMB28YGDhcXEb9Ad?=
 =?us-ascii?Q?US6yVIl1d4VAIvz8y3rUjmbYbbFLbcKZzTIH1L8GpWziLk2CQS0tTWWl8+bj?=
 =?us-ascii?Q?9S9kcrMe4lfRd435WPPX1XK+Dj7pcm8savYB9lFehPFCKHVq2TJpytzrD3aa?=
 =?us-ascii?Q?jOcX3cBfmXvukEImbxoBXlJO6c/emXDRfdxT5oVFqNpt9kxUu2p6gXp4Pv4m?=
 =?us-ascii?Q?LQmFRCzQSbmv+O4n5m1S1WZcfhx2xnvRhhl45IWJZwFe6L66DMzy13Q+ba70?=
 =?us-ascii?Q?SSdsk1zvEioqipQYDPVRJH1aut81F0T43+9ss1dx70lbR6vgNDbXn4iiq5kX?=
 =?us-ascii?Q?gWMZINGNzm7eZp4MrgLD5VWPOyx8LqHFRfdh8AmODaDkcMZxE2BFIqTv36ar?=
 =?us-ascii?Q?angq0u+2eTNxqG0Z33/ibqAN7a91yOe+xz5fYEKXvDJNW6y7dATfIEZsybdc?=
 =?us-ascii?Q?t6gp5a7DyYWiA47O2dLtEV4H94264yNcRfpkXDr6K6crItdOG9t3eWUTQ6cL?=
 =?us-ascii?Q?EFpsTojhGpPt5MrDUxSqC2iKUtx5Qzxf5WJ8sfAYq3p/upOozJy7IquPgEJ9?=
 =?us-ascii?Q?TfN5v3n/DOQo/Uw7gOsWaLmwku/qe+yIUa9FZAaxWgRPBFNMXtyvUqoxhrnq?=
 =?us-ascii?Q?p3n7s392qGS0Wg3oi9QoiyEbSpGXcT/KXvEpPdNt5yyCrfIoGvWgsPFPWCcZ?=
 =?us-ascii?Q?KJTYijZXLXFFOJ1ZFPRlj8lFTuwddc40kTtb4h1w6Li6fbhJmcPTTYYt7BuB?=
 =?us-ascii?Q?+7403ORqrygXp3c36Oqn2itTy0lifYRSS/9CCJ7CAqzWlyVkCxRj+LLQHBQ1?=
 =?us-ascii?Q?2DhlOSAp80OFBTzVE550HhyJy8XH/SBKIVxeIf5EMj7WIw+7oZgpNFpb2qsb?=
 =?us-ascii?Q?FQOpf6REkZx09TSj+29T9JRUrSYmsiztrfE5q44+wbs7On+hPTgmCwkZdlhI?=
 =?us-ascii?Q?pr+J1vBHtEHn4/Z5U34EccTZnglSyav7argGiSukzRWwC20PyXOZGgZS/6iR?=
 =?us-ascii?Q?eajSpuc/4T6h/UCpbnKqWkb2XzZlJ2V85YAk8K40DLNAyHiyJIKVKuTOpVuR?=
 =?us-ascii?Q?SF1K/JhCbdV/F2zI3qfEt1XUsFRSEYCgT2Cx/7jZjEz15BEyDuGOzIb6lDZN?=
 =?us-ascii?Q?Q2/Tt9cuvNwy1VIu99pM+rB8tGjlfVAvc+IUVGVUo197nHUcRvgyl2ZAo6rY?=
 =?us-ascii?Q?abSdanvSAhnGT/IST7juECYUsOKj6rXAwgJ4UGmLBlrul1uqfZsFDPuCl04X?=
 =?us-ascii?Q?FYg3RFq/QVqAVv1YszNGJ4We1koQ1quwTLx2e39nWdboME8NDqoK3Nl/3B4C?=
 =?us-ascii?Q?2nP59U+ThKugsCXa3V4211x9B+o7Q/6vFx7ONNpAd36kkesdqCIXJUce4OJQ?=
 =?us-ascii?Q?UNbbvbWko6J6e7u2EUnxZbNnEmbxbj/YUQ9CitT1YlTwq5CTrQngqs5/+3Gl?=
 =?us-ascii?Q?DmUZGxbZwMIJaNcZpKZrdB+EbSjCivJjN8nAxkf4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dcd979-98ba-45ac-e64a-08ddc4a323ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:58:31.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jjh1oNJdO2N7OyT3EhvPHNPgBGjdJz/8aG4wTBgJ1bK0EjILGK2g5WDovDUMiPRXvGx4G+s6saGZiykCkVY9CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10876

On Wed, Jul 16, 2025 at 03:31:00PM +0800, Wei Fang wrote:
> NETC Timer provides current time with nanosecond resolution, precise
> periodic pulse, pulse on timeout (alarm), and time capture on external
> pulse support. And it supports time synchronization as required for
> IEEE 1588 and IEEE 802.1AS-2020. The enetc v4 driver can implement PTP

New paragraph

Implement PTP ....

Missing feature ... will be added in subsequent patches.

> synchronization through the relevant interfaces provided by the driver.
> Note that the current driver does not support PEROUT, PPS and EXTTS yet,
> and support will be added one by one in subsequent patches.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> 1. Rename netc_timer_get_source_clk() to
>    netc_timer_get_reference_clk_source() and refactor it
> 2. Remove the scaled_ppm check in netc_timer_adjfine()
> 3. Add a comment in netc_timer_cur_time_read()
> 4. Add linux/bitfield.h to fix the build errors
> ---
>  drivers/ptp/Kconfig             |  11 +
>  drivers/ptp/Makefile            |   1 +
>  drivers/ptp/ptp_netc.c          | 568 ++++++++++++++++++++++++++++++++
>  include/linux/fsl/netc_global.h |  12 +-
>  4 files changed, 591 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/ptp/ptp_netc.c
>
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 204278eb215e..3e005b992aef 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -252,4 +252,15 @@ config PTP_S390
>  	  driver provides the raw clock value without the delta to
>  	  userspace. That way userspace programs like chrony could steer
>  	  the kernel clock.
> +
> +config PTP_1588_CLOCK_NETC
> +	bool "NXP NETC Timer PTP Driver"
> +	depends on PTP_1588_CLOCK=y
> +	depends on PCI_MSI
> +	help
> +	  This driver adds support for using the NXP NETC Timer as a PTP
> +	  clock. This clock is used by ENETC MAC or NETC Switch for PTP
> +	  synchronization. It also supports periodic output signal (e.g.
> +	  PPS) and external trigger timestamping.
> +
>  endmenu
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> index 25f846fe48c9..d48fe4009fa4 100644
> --- a/drivers/ptp/Makefile
> +++ b/drivers/ptp/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
>  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
>  obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
>  obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
> +obj-$(CONFIG_PTP_1588_CLOCK_NETC)	+= ptp_netc.o
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> new file mode 100644
> index 000000000000..82cb1e6a0fe9
> --- /dev/null
> +++ b/drivers/ptp/ptp_netc.c
> @@ -0,0 +1,568 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * NXP NETC Timer driver
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/fsl/netc_global.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/ptp_clock_kernel.h>
> +
> +#define NETC_TMR_PCI_VENDOR		0x1131
> +#define NETC_TMR_PCI_DEVID		0xee02
> +
> +#define NETC_TMR_CTRL			0x0080
> +#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
> +#define  TMR_CTRL_TE			BIT(2)
> +#define  TMR_COMP_MODE			BIT(15)
> +#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> +#define  TMR_CTRL_FS			BIT(28)
> +#define  TMR_ALARM1P			BIT(31)
> +
> +#define NETC_TMR_TEVENT			0x0084
> +#define  TMR_TEVENT_ALM1EN		BIT(16)
> +#define  TMR_TEVENT_ALM2EN		BIT(17)
> +
> +#define NETC_TMR_TEMASK			0x0088
> +#define NETC_TMR_CNT_L			0x0098
> +#define NETC_TMR_CNT_H			0x009c
> +#define NETC_TMR_ADD			0x00a0
> +#define NETC_TMR_PRSC			0x00a8
> +#define NETC_TMR_OFF_L			0x00b0
> +#define NETC_TMR_OFF_H			0x00b4
> +
> +/* i = 0, 1, i indicates the index of TMR_ALARM */
> +#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
> +#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
> +
> +#define NETC_TMR_FIPER_CTRL		0x00dc
> +#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
> +#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> +
> +#define NETC_TMR_CUR_TIME_L		0x00f0
> +#define NETC_TMR_CUR_TIME_H		0x00f4
> +
> +#define NETC_TMR_REGS_BAR		0
> +
> +#define NETC_TMR_FIPER_NUM		3
> +#define NETC_TMR_DEFAULT_PRSC		2
> +#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
> +
> +/* 1588 timer reference clock source select */
> +#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> +#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
> +#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
> +
> +#define NETC_TMR_SYSCLK_333M		333333333U
> +
> +struct netc_timer {
> +	void __iomem *base;
> +	struct pci_dev *pdev;
> +	spinlock_t lock; /* Prevent concurrent access to registers */
> +
> +	struct clk *src_clk;
> +	struct ptp_clock *clock;
> +	struct ptp_clock_info caps;
> +	int phc_index;
> +	u32 clk_select;
> +	u32 clk_freq;
> +	u32 oclk_prsc;
> +	/* High 32-bit is integer part, low 32-bit is fractional part */
> +	u64 period;
> +
> +	int irq;
> +};
> +
> +#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> +#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
> +#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
> +
> +static u64 netc_timer_cnt_read(struct netc_timer *priv)
> +{
> +	u32 tmr_cnt_l, tmr_cnt_h;
> +	u64 ns;
> +
> +	/* The user must read the TMR_CNC_L register first to get
> +	 * correct 64-bit TMR_CNT_H/L counter values.
> +	 */

Need comment about there are snapshot in side chip. So it is safe to
read NETC_TMR_CNT_L then read NETC_TMR_CNT_H, otherwise
NETC_TMR_CNT_L may change, during read NETC_TMR_CNT_H.


> +	tmr_cnt_l = netc_timer_rd(priv, NETC_TMR_CNT_L);
> +	tmr_cnt_h = netc_timer_rd(priv, NETC_TMR_CNT_H);
> +	ns = (((u64)tmr_cnt_h) << 32) | tmr_cnt_l;
> +
> +	return ns;
> +}
> +
> +static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
> +{
> +	u32 tmr_cnt_h = upper_32_bits(ns);
> +	u32 tmr_cnt_l = lower_32_bits(ns);
> +
> +	/* The user must write to TMR_CNT_L register first. */
> +	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
> +	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
> +}
> +
> +static u64 netc_timer_offset_read(struct netc_timer *priv)
> +{
> +	u32 tmr_off_l, tmr_off_h;
> +	u64 offset;
> +
> +	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
> +	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
> +	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
> +
> +	return offset;
> +}
> +
> +static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
> +{
> +	u32 tmr_off_h = upper_32_bits(offset);
> +	u32 tmr_off_l = lower_32_bits(offset);
> +
> +	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
> +	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
> +}
> +
> +static u64 netc_timer_cur_time_read(struct netc_timer *priv)
> +{
> +	u32 time_h, time_l;
> +	u64 ns;
> +
> +	/* The user should read NETC_TMR_CUR_TIME_L first to
> +	 * get correct current time.
> +	 */
> +	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
> +	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
> +	ns = (u64)time_h << 32 | time_l;
> +
> +	return ns;
> +}
> +
> +static void netc_timer_alarm_write(struct netc_timer *priv,
> +				   u64 alarm, int index)
> +{
> +	u32 alarm_h = upper_32_bits(alarm);
> +	u32 alarm_l = lower_32_bits(alarm);
> +
> +	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
> +	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
> +}
> +
> +static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
> +{
> +	u32 fractional_period = lower_32_bits(period);
> +	u32 integral_period = upper_32_bits(period);
> +	u32 tmr_ctrl, old_tmr_ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
> +				    TMR_CTRL_TCLK_PERIOD);
> +	if (tmr_ctrl != old_tmr_ctrl)
> +		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +
> +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	u64 new_period;
> +
> +	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
> +	netc_timer_adjust_period(priv, new_period);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	u64 tmr_cnt, tmr_off;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	tmr_off = netc_timer_offset_read(priv);
> +	if (delta < 0 && tmr_off < abs(delta)) {
> +		delta += tmr_off;
> +		if (!tmr_off)
> +			netc_timer_offset_write(priv, 0);
> +
> +		tmr_cnt = netc_timer_cnt_read(priv);
> +		tmr_cnt += delta;
> +		netc_timer_cnt_write(priv, tmr_cnt);
> +	} else {
> +		tmr_off += delta;
> +		netc_timer_offset_write(priv, tmr_off);
> +	}
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
> +				 struct timespec64 *ts,
> +				 struct ptp_system_timestamp *sts)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	unsigned long flags;
> +	u64 ns;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	ptp_read_system_prets(sts);
> +	ns = netc_timer_cur_time_read(priv);
> +	ptp_read_system_postts(sts);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	*ts = ns_to_timespec64(ns);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_settime64(struct ptp_clock_info *ptp,
> +				const struct timespec64 *ts)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	u64 ns = timespec64_to_ns(ts);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	netc_timer_offset_write(priv, 0);
> +	netc_timer_cnt_write(priv, ns);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
> +{
> +	struct netc_timer *priv;
> +
> +	if (!timer_pdev)
> +		return -ENODEV;
> +
> +	priv = pci_get_drvdata(timer_pdev);
> +	if (!priv)
> +		return -EINVAL;
> +
> +	return priv->phc_index;
> +}
> +EXPORT_SYMBOL_GPL(netc_timer_get_phc_index);
> +
> +static const struct ptp_clock_info netc_timer_ptp_caps = {
> +	.owner		= THIS_MODULE,
> +	.name		= "NETC Timer PTP clock",
> +	.max_adj	= 500000000,
> +	.n_alarm	= 2,
> +	.n_pins		= 0,
> +	.adjfine	= netc_timer_adjfine,
> +	.adjtime	= netc_timer_adjtime,
> +	.gettimex64	= netc_timer_gettimex64,
> +	.settime64	= netc_timer_settime64,
> +};
> +
> +static void netc_timer_init(struct netc_timer *priv)
> +{
> +	u32 tmr_emask = TMR_TEVENT_ALM1EN | TMR_TEVENT_ALM2EN;
> +	u32 fractional_period = lower_32_bits(priv->period);
> +	u32 integral_period = upper_32_bits(priv->period);
> +	u32 tmr_ctrl, fiper_ctrl;
> +	struct timespec64 now;
> +	u64 ns;
> +	int i;
> +
> +	/* Software must enable timer first and the clock selected must be
> +	 * active, otherwise, the registers which are in the timer clock
> +	 * domain are not accessible.
> +	 */
> +	tmr_ctrl = (priv->clk_select & TMR_CTRL_CK_SEL) | TMR_CTRL_TE;
> +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
> +
> +	/* Disable FIPER by default */
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		fiper_ctrl |= FIPER_CTRL_DIS(i);
> +		fiper_ctrl &= ~FIPER_CTRL_PG(i);
> +	}
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +
> +	ktime_get_real_ts64(&now);
> +	ns = timespec64_to_ns(&now);
> +	netc_timer_cnt_write(priv, ns);
> +
> +	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
> +	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
> +	 */
> +	tmr_ctrl |= ((integral_period << 16) & TMR_CTRL_TCLK_PERIOD) |
> +		     TMR_COMP_MODE | TMR_CTRL_FS;
> +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
> +}
> +
> +static int netc_timer_pci_probe(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_timer *priv;
> +	int err, len;
> +
> +	pcie_flr(pdev);
> +	err = pci_enable_device_mem(pdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable device\n");
> +
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_err(dev, "dma_set_mask_and_coherent() failed, err:%pe\n",
> +			ERR_PTR(err));
> +		goto disable_dev;
> +	}

Needn't check return value for dma_set_mask_and_coherent() when mask >= 32
It is never return fail.

use devm_add_action_or_reset() to avoid all goto here. then dev_err =>
dev_err_probe().

> +
> +	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +	if (err) {
> +		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
> +			ERR_PTR(err));
> +		goto disable_dev;
> +	}
> +
> +	pci_set_master(pdev);
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);

devm_kzalloc()

> +	if (!priv) {
> +		err = -ENOMEM;
> +		goto release_mem_regions;
> +	}
> +
> +	priv->pdev = pdev;
> +	len = pci_resource_len(pdev, NETC_TMR_REGS_BAR);
> +	priv->base = ioremap(pci_resource_start(pdev, NETC_TMR_REGS_BAR), len);
> +	if (!priv->base) {
> +		err = -ENXIO;
> +		dev_err(dev, "ioremap() failed\n");
> +		goto free_priv;
> +	}

pci_ioremap_bar()?

> +
> +	pci_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +free_priv:
> +	kfree(priv);
> +release_mem_regions:
> +	pci_release_mem_regions(pdev);
> +disable_dev:
> +	pci_disable_device(pdev);
> +
> +	return err;
> +}
> +
> +static void netc_timer_pci_remove(struct pci_dev *pdev)
> +{
> +	struct netc_timer *priv = pci_get_drvdata(pdev);
> +
> +	iounmap(priv->base);
> +	kfree(priv);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const char *clk_name = NULL;
> +	u64 ns = NSEC_PER_SEC;
> +
> +	/* Select NETC system clock as the reference clock by default */
> +	priv->clk_select = NETC_TMR_SYSTEM_CLK;
> +	priv->clk_freq = NETC_TMR_SYSCLK_333M;
> +	priv->period = div_u64(ns << 32, priv->clk_freq);
> +
> +	if (!np)
> +		return 0;
> +
> +	of_property_read_string(np, "clock-names", &clk_name);
> +	if (!clk_name)
> +		return 0;

Don't perfer parser this property by youself.

you can use devm_clk_bulk_get_all() clk_bulk_data have clock name, you
can use it.

or use loop to try 3 time devm_clk_get(), first one return success is what
you want.

> +
> +	/* Update the clock source of the reference clock if the clock
> +	 * name is specified in DTS node.
> +	 */
> +	if (!strcmp(clk_name, "system"))

strncmp();

"..." maybe longer than len of clc_name.

> +		priv->clk_select = NETC_TMR_SYSTEM_CLK;
> +	else if (!strcmp(clk_name, "ccm_timer"))
> +		priv->clk_select = NETC_TMR_CCM_TIMER1;
> +	else if (!strcmp(clk_name, "ext_1588"))
> +		priv->clk_select = NETC_TMR_EXT_OSC;
> +	else
> +		return -EINVAL;
> +
> +	priv->src_clk = devm_clk_get(dev, clk_name);
> +	if (IS_ERR(priv->src_clk)) {
> +		dev_err(dev, "Failed to get reference clock source\n");
> +		return PTR_ERR(priv->src_clk);
> +	}
> +
> +	priv->clk_freq = clk_get_rate(priv->src_clk);
> +	priv->period = div_u64(ns << 32, priv->clk_freq);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_parse_dt(struct netc_timer *priv)
> +{
> +	return netc_timer_get_reference_clk_source(priv);
> +}
> +
> +static irqreturn_t netc_timer_isr(int irq, void *data)
> +{
> +	struct netc_timer *priv = data;
> +	u32 tmr_event, tmr_emask;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
> +	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
> +
> +	tmr_event &= tmr_emask;
> +	if (tmr_event & TMR_TEVENT_ALM1EN)
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> +
> +	if (tmr_event & TMR_TEVENT_ALM2EN)
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
> +
> +	/* Clear interrupts status */
> +	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);

clean irq status should be just after read it (before "tmr_event &= tmr_emask;)

otherwise the new irq maybe missed by netc_timer_alarm_write()

> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int netc_timer_init_msix_irq(struct netc_timer *priv)
> +{
> +	struct pci_dev *pdev = priv->pdev;
> +	char irq_name[64];
> +	int err, n;
> +
> +	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +	if (n != 1) {
> +		err = (n < 0) ? n : -EPERM;
> +		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
> +		return err;
> +	}
> +
> +	priv->irq = pci_irq_vector(pdev, 0);
> +	snprintf(irq_name, sizeof(irq_name), "ptp-netc %s", pci_name(pdev));
> +	err = request_irq(priv->irq, netc_timer_isr, 0, irq_name, priv);
> +	if (err) {
> +		dev_err(&pdev->dev, "request_irq() failed\n");
> +		pci_free_irq_vectors(pdev);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void netc_timer_free_msix_irq(struct netc_timer *priv)
> +{
> +	struct pci_dev *pdev = priv->pdev;
> +
> +	disable_irq(priv->irq);
> +	free_irq(priv->irq, priv);
> +	pci_free_irq_vectors(pdev);
> +}
> +
> +static int netc_timer_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_timer *priv;
> +	int err;
> +
> +	err = netc_timer_pci_probe(pdev);
> +	if (err)
> +		return err;
> +
> +	priv = pci_get_drvdata(pdev);
> +	err = netc_timer_parse_dt(priv);
> +	if (err) {
> +		dev_err(dev, "Failed to parse DT node\n");
> +		goto timer_pci_remove;
> +	}
> +
> +	priv->caps = netc_timer_ptp_caps;
> +	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
> +	priv->phc_index = -1; /* initialize it as an invalid index */
> +	spin_lock_init(&priv->lock);
> +
> +	err = clk_prepare_enable(priv->src_clk);

use devm_ function

> +	if (err) {
> +		dev_err(dev, "Failed to enable timer source clock\n");
> +		goto timer_pci_remove;
> +	}
> +
> +	err = netc_timer_init_msix_irq(priv);
> +	if (err)
> +		goto disable_clk;
> +
> +	netc_timer_init(priv);
> +	priv->clock = ptp_clock_register(&priv->caps, dev);
> +	if (IS_ERR(priv->clock)) {
> +		err = PTR_ERR(priv->clock);
> +		goto free_msix_irq;
> +	}
> +
> +	priv->phc_index = ptp_clock_index(priv->clock);
> +
> +	return 0;
> +
> +free_msix_irq:
> +	netc_timer_free_msix_irq(priv);
> +disable_clk:
> +	clk_disable_unprepare(priv->src_clk);
> +timer_pci_remove:
> +	netc_timer_pci_remove(pdev);

devm_add_action_or_reset() to simpify goto and netc_timer_remove().

> +
> +	return err;
> +}
> +
> +static void netc_timer_remove(struct pci_dev *pdev)
> +{
> +	struct netc_timer *priv = pci_get_drvdata(pdev);
> +
> +	ptp_clock_unregister(priv->clock);
> +	netc_timer_free_msix_irq(priv);
> +	clk_disable_unprepare(priv->src_clk);
> +	netc_timer_pci_remove(pdev);
> +}
> +
> +static const struct pci_device_id netc_timer_id_table[] = {
> +	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR, NETC_TMR_PCI_DEVID) },
> +	{ 0, } /* End of table. */

just { }

needn't /* End of table. */

Frank
> +};
> +MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
> +
> +static struct pci_driver netc_timer_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = netc_timer_id_table,
> +	.probe = netc_timer_probe,
> +	.remove = netc_timer_remove,
> +};
> +module_pci_driver(netc_timer_driver);
> +
> +MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
> index fdecca8c90f0..59c835e67ada 100644
> --- a/include/linux/fsl/netc_global.h
> +++ b/include/linux/fsl/netc_global.h
> @@ -1,10 +1,11 @@
>  /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> -/* Copyright 2024 NXP
> +/* Copyright 2024-2025 NXP
>   */
>  #ifndef __NETC_GLOBAL_H
>  #define __NETC_GLOBAL_H
>
>  #include <linux/io.h>
> +#include <linux/pci.h>
>
>  static inline u32 netc_read(void __iomem *reg)
>  {
> @@ -16,4 +17,13 @@ static inline void netc_write(void __iomem *reg, u32 val)
>  	iowrite32(val, reg);
>  }
>
> +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC)
> +int netc_timer_get_phc_index(struct pci_dev *timer_pdev);
> +#else
> +static inline int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  #endif
> --
> 2.34.1
>

