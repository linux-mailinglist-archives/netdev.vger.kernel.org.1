Return-Path: <netdev+bounces-212940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F2B2297F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEAB6274D9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299602874E7;
	Tue, 12 Aug 2025 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GUk+FDCt"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4428750F;
	Tue, 12 Aug 2025 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006582; cv=fail; b=S8V9Xgshn5Ow6GB62mw001Wbx6TmWfeXnaugUc9Gerky+DaFYCZJUKG6Ybtlo4oLNoMO0TewYHTFUsuKAfD5Yghiy7DLDrwAFE58YbtfloFzdWt74S3b0bh2omoot/SFsF8yjolzGviQ6Kwh6nFqVydIjHlHtE3o500UQwTxFUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006582; c=relaxed/simple;
	bh=nJKRqkaGyM+3FGtJdFA4srcEWNOwk3xSpa/NpHjcS64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y86j7gKDyg1lvU5C1cK9wLBG6uFejILurVqTzet9BQhM3poJDYTlxcLpZ7tqo1z6hoOsyIp5RpGSJBncfZvaEvKrRdBVrYiBS/LevUrbMpp2tWuJjfvO6BS9PDTNg7Rl2TGqf6uL/nbdUT0sCC47oTJET4i1qo03lIQrDtY+iDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GUk+FDCt; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEj33Ycs/BlT5PzyzZAwo5qdzhhJRTVpBG7XzZZXo/qXLTwaYJqlPB3XievuKG1Ds7cvSPfCzAmDzLVUeSGBhcZ7DeAi3GH6yPnF3HUnhg6Ko/gja7dRY7s5VIWiD7fEG4xT/EwDJ7uLqpuW4wQdVS93osBUTOjEBT1LSNcitm92DX2R+p0CNQ3zot+KVptkfkCMlJOtgtapE715IRPsnFQYGw/VQMY4v9Whawl/jIcs5zScS110LGcoCZ8MvcVPbFO4hgsVdk3pZ/RAEifkdpv3Sof0oh8Sim2JxeUDTts6anslPrc5fm3Z2WBfa9gSs3mU0+1+rwK4ayPDpUyf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z4GoJJc6kW8mOWKcUUw1JrhuzmjlC7SeYTIXEXQVis=;
 b=SEiJVxiIlE7Jklw/oHqlOM6iUEjE2rYQ0Dwlkj29jWAL3d8CAjCeleRz22cajqPMxGSRVpivgnH7Y2sDdnV1/kjfuViVZkftkcNktaTjPZFL8Km1WcQHDx51QlyxIfADhk5FbNnfq7oqVi3D13wQ0F8PeCxIfk4x8nWDDQ1IrWXF5VqmA6U8m7Hs5M15TCGFkdjT9JCQQw/yO/XjH8++v5K8l4j6bYPtRwQZSpMqKR9170Hfihcia9c0JTOmu2NpC8Pd1dWL59Vb2p2k/9T6huVxF2neH+5t8L6Ofbu8UzqZgOVuOkvdifN6o7tJz537/jIcp9C/9wtaKZbz+/Kujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z4GoJJc6kW8mOWKcUUw1JrhuzmjlC7SeYTIXEXQVis=;
 b=GUk+FDCtKXIvIGuUGujBM7iOTLu2ywOSg6+THiToBf/D5EHWxLFlyjYRmuaDuidHqZ8cAyJZ6LQyA22eldv/5LZhScjgWxuptiMvzP3UHlAXROhppiSY9sQH4YV4M6nP/iaBCrgQOHxzNzlUuTvc61Zn+8rdijqL6IPah5PfQZota0FFDO8xaVFTocpYH8MPkeaowa7WH038CzOR6YL3pZGHEdk9NNri/Ucn3Adml5tlDUoPWnhDAZ7MfeVSuqI+CShmFcXAkgsh7B09fGU4IJt/3c0RNctn99P7W2DWx723RNzgXk8bHtULabtE9yQAyBZGWJCIO/LTHblwtiOfGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV2PR04MB11328.eurprd04.prod.outlook.com (2603:10a6:150:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 13:49:36 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 13:49:35 +0000
Date: Tue, 12 Aug 2025 16:49:31 +0300
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
Subject: Re: [PATCH v3 net-next 04/15] ptp: netc: add NETC V4 Timer PTP
 driver support
Message-ID: <20250812134931.fjtrmv6fmdgcagre@skbuf>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-5-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR0902CA0046.eurprd09.prod.outlook.com
 (2603:10a6:802:1::35) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV2PR04MB11328:EE_
X-MS-Office365-Filtering-Correlation-Id: a41306da-b907-4e61-9844-08ddd9a712b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ipEKnoZJf+3zFHTyewk9Lk2OhbTYe4gu/0aWZg+Sa5aYCR0b7Ln/4jTh86/?=
 =?us-ascii?Q?8nA6dAtK6Zz5uDekDILhMcR22kLz1SXxUzQnKribncd7TRo0mfmjWoVD9+Jr?=
 =?us-ascii?Q?H4kRwbdCpU+brA2dvt4+HVfyjXgHUgM8ECiYVc1johLcogwvbm6ud3Xk918q?=
 =?us-ascii?Q?89bEBKWviBhgSJVFCaIUVqZnTB61UO6oJTBn93LNzmN4jaq//6717OCPB1NK?=
 =?us-ascii?Q?E2emA2/odT1RAepTzFixt3bRdErToK0Q6nRGtZ/E14Yr8PBzROGzmlCQoMB7?=
 =?us-ascii?Q?JwDOi18Srriee1t4Z1qyebsVRSPpdeibRVRJ3IULWYBqauRBI1c2jCQv0c9Z?=
 =?us-ascii?Q?GhSeVc2NmCzD05tv354JmsjCSfkVKgux9+aT8NRlsAaKOBAphxM3teQGCVUL?=
 =?us-ascii?Q?eS4VZFvGGfmi32Siq3pztw9MJrtWU2i8l4YnjYFLgEAmbhFmKFIeSaPKhaYc?=
 =?us-ascii?Q?JSQZnlxUQl6yxGqqNMep0XQBFFz6Q7kSzu2fv1pAs+aOf1IXyqQrnEmnzlYm?=
 =?us-ascii?Q?oA/vCwHaO3z9FwveU2LSG5scOXnCTjdqTMbiueo7XLJMAh//xOKQ6PNzsRW6?=
 =?us-ascii?Q?bCThuFM9zn5CY6f1AXY1/HTAuCpiMbpsRKZgTV8n6vUS6Phh2baOOxNKKjgf?=
 =?us-ascii?Q?hQsXvwxVKcY4Fgzs95bs7Y6oyr8c0vMOOTR1lHMqbJxgyabReEogbh4FThWq?=
 =?us-ascii?Q?yXqkg0Nj7S+HASaaLYodnVnQmH+XRU4Zv3BTVQ6YxvZ6RxW171AHEbiiFm8j?=
 =?us-ascii?Q?XVEPZSwHkeXo17pZjpSLdxBCbahsyD1Uu/dAGjmAedo6ggRbIQ5jfV69txIW?=
 =?us-ascii?Q?iNXneftVF8pQUK1yQwuZgY74XkgSnD8USqsHGWsVghFMVMgTlLM2j31/9fYF?=
 =?us-ascii?Q?u2qsNu3TGGrsC3x59ehCR6F0xU+UCJTsrw+iZPim64HVsdyzD6Z9UlxP38Dc?=
 =?us-ascii?Q?/Fy7vhW4Cc51Uk2azzBxBBqUpKOX4lnQbxfkiNdvfPeLrsCH3TOgVWoijUlA?=
 =?us-ascii?Q?P1+rUgjc4WyPxw1uDhufUlbZugD27N6KfyPjWmJwY/VUwMi8t3GSnQocNDca?=
 =?us-ascii?Q?7h88jxNJpC3K22rv5RNb89IheEQAOMwJwc9Kkby9Jz6K/i1+hz58IPeQjLfw?=
 =?us-ascii?Q?5ZQDElOqm6YwpRTyimp14R9xYVDEiS+dWf8DGm31lbZ6UqQoyt40t4UtWU8N?=
 =?us-ascii?Q?3546v8JyJ+55QiP46M7bSjGQkvo877adc+o2U1IiCssRUibkBHVGtL/yn4v5?=
 =?us-ascii?Q?f4knPAPnKU9u7R2XhMkqix0na9uoF+Nm0dlslNlb913Nua5UTnUKsCeNEbo4?=
 =?us-ascii?Q?nSSZbsQX81pUv9GimX48XAeVKF1dlu4keGBZY5CouX8ADh/bIHNonugIc2gd?=
 =?us-ascii?Q?N94mj7ciRncYeEXm7VaXwM3v4O8Nvau1AiFmUbCvrAOaq6dUsGM3xQ8hTsPn?=
 =?us-ascii?Q?Lw8PuOh9Dms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5kYVYp2YKkh8Dd2oQ6l2U8qjyt7NaBdGxPWU+mrlobukLDjO2lqr4wjabFPk?=
 =?us-ascii?Q?LI1UaKoGcVnap+o9q0HN94Vei3y5nPULXyb9Rr+Mk5q0761VTqtyIikLs1At?=
 =?us-ascii?Q?HmdMJ/goQYlXquC2KgjC+CFjuQxxboOYAWfIay0yqfqPP9ljXP10N7vliz0z?=
 =?us-ascii?Q?oYyU26yMExvLQcHLbAJEspBkyVGNUNGcOYNHeCabIzJ0hxSIAUVeO/ad+s9w?=
 =?us-ascii?Q?3zF1N1lnf6ePYzcy5fyBvM823VGFuuoqkn9Ye1hGlFAosw9xCHptTtA0yyRq?=
 =?us-ascii?Q?IURP/+sOlcxqBLgvI8rHX0H9mUyXq4ZLg1l105IXm/r+8i3jm3XiN+iabWmf?=
 =?us-ascii?Q?OO/0qhgn9hPmmxKFsmRQ4d6Y4+spVg8gJh3H+yOvqr/FLjzvtEFJnYaWcdBk?=
 =?us-ascii?Q?oly51ZnDqh+ftefLd+PWkhDaGBdcXMgcN6+fLSsPlnq/jOHi0T1zi2bD6Q64?=
 =?us-ascii?Q?S+jyPkTlUt/xBLAraetvPkTe8GCVpx6pT+ROrgZkW1ZVx4uExM/LWqV5YRi0?=
 =?us-ascii?Q?bzZeZyfOV1ioif6K2Y+YRIId+RRSA3j/plxSeB61j2wOYtZAF5zWh6qr5Spn?=
 =?us-ascii?Q?BDgg4UxyE+IFDv6Mu9KlPhJpJAEXcFjVi7jMeiyIBwOwb0Z5WhGSffMAjkQH?=
 =?us-ascii?Q?nRv+AFD6xqAaSn+xb3PB4YA3XBqKdTllj5HRPKOGAOFkrWFoODHPNffcmXZi?=
 =?us-ascii?Q?7iehzOGsSteU79jelsGWpMpZrwGcPUCdn+bG1TkSb85r7jSlx+LyUyFUo8aG?=
 =?us-ascii?Q?mS5fKGJzciBans0PlaANqbuAbWu8x251jqMqctBG5tMfCFAlQaOiEAoEutrK?=
 =?us-ascii?Q?n+B6/kxohax1R+lIl9SJ9TkRAbZU2tRgrCPXajcSYg5R0dyRdGoRXVQzKacb?=
 =?us-ascii?Q?2PCL8uSRo5TcbvngABSDD79p3opikwafYGb741VihB1/JrbryhdwY1CHq21t?=
 =?us-ascii?Q?AFotrmJL0KueqVXVBsqOi2IZDCPsKs3CKc1waISPlVLFr/XuZm1YeCBbtF2i?=
 =?us-ascii?Q?QAFZkdLWHNZn2VEz/gifnhyE2rUup+60oCxJiJl1/W7YlADvjWD+4LgLvLGo?=
 =?us-ascii?Q?xyJKAU+MGjfKvHtE2MdULTVw5z+xsUfBECqvRKw5gXcEmP2KI9paaZAPeHux?=
 =?us-ascii?Q?YwcWcrW9tneT6YI393vQtnD2rwuEZ8jH4Ji0uvng8QUrW9C3uqJKDiiDTaVx?=
 =?us-ascii?Q?o3jbh9tRjqS/XiNqv9SSYGy8VEs4MG0uuqezI9i7vB1dLiwjYyRqb/jVcOeq?=
 =?us-ascii?Q?ZAVALFRjTX4nffev3NRC5h3OwaDhO3bFSnPfosGOubeI8TdGDBdXEkrAfLu7?=
 =?us-ascii?Q?CQE/6QkO57UOXKf0tEvxbObAZTJoOZ0BU6MQh5iChSPmby0/J4RcKx00Muzy?=
 =?us-ascii?Q?pcRR8GDMaBkK5WH5cnPZ3VBMwn4q+/qzcVr6MbrQYd4lkNqugLX2YZeoqNsh?=
 =?us-ascii?Q?6WDjibk8Rv7KLtm9A2fmq5qs9ZvYTvvR2ETUZoiJdI0JhwsAoNcHxCocoJYX?=
 =?us-ascii?Q?XMmOANfKU7/sxRdu2d3SClH7NXldq3zzAnpYT2GG6zwXqDSRCpFtKbiifv36?=
 =?us-ascii?Q?TSRidwYrlh5EPhyOXaybCAr3R1GUPHX7Boc84NXnUiRfz2h+ZqpDGPrM63A9?=
 =?us-ascii?Q?9ZLEXSh4E+3GJoAureEdjDVWofz9xz8UvaxjLo5v23gSYDpLzRMsJfKKEQrD?=
 =?us-ascii?Q?hO7wcw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41306da-b907-4e61-9844-08ddd9a712b3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:49:35.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NF8AaX3P/qfP7I//nsh3jwAuVyQ6XyzHrEx4R3+pkZk6ggStlv+rnfZK6ayjM5KBIVu2QZoUGNEO7R/w8zttDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11328

On Tue, Aug 12, 2025 at 05:46:23PM +0800, Wei Fang wrote:
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
...
> @@ -16,4 +17,13 @@ static inline void netc_write(void __iomem *reg, u32 val)
>  	iowrite32(val, reg);
>  }
>  
> +#if IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER)
> +int netc_timer_get_phc_index(struct pci_dev *timer_pdev);
> +#else
> +static inline int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +

I was expecting that with the generic ptp-timer phandle you'd also offer
a generic mechanism of retrieving the PHC index, instead of cooking up a
custom API convention between the NETC MAC and the NETC timer.

Something like below, completely untested:

struct ptp_clock_fwnode_match {
	struct fwnode_handle *fwnode;
	struct ptp_clock *clock;
};

static int ptp_clock_fwnode_match(struct device *dev, void *data)
{
	struct ptp_clock_fwnode_match *match = data;

	if (!dev->parent || dev_fwnode(dev->parent) != match->fwnode)
		return 0;

	match->clock = dev_get_drvdata(dev);
	return 1;
}

static struct ptp_clock *ptp_clock_find_by_fwnode(struct fwnode_handle *fwnode)
{
	struct ptp_clock_fwnode_match match = { .fwnode = fwnode };

	class_for_each_device(&ptp_class, NULL, &match, ptp_clock_fwnode_match);

	return match.clock;
}

int ptp_clock_index_by_fwnode_handle(struct fwnode_handle *fwnode)
{
	struct fwnode_handle *ptp_fwnode;
	struct ptp_clock *clock;
	int phc_index;

	ptp_fwnode = fwnode_find_reference(fwnode, "ptp-timer", 0);
	if (!ptp_fwnode)
		return -1;

	clock = ptp_clock_find_by_fwnode(ptp_fwnode);
	fwnode_handle_put(ptp_fwnode);
	if (!clock)
		return -1;

	phc_index = ptp_clock_index(clock);
	put_device(&clock->dev);

	return phc_index;
}
EXPORT_SYMBOL_GPL(ptp_clock_index_by_fwnode_handle);

