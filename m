Return-Path: <netdev+bounces-236403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C87C3BE1D
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0B31B247AD
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD63043D2;
	Thu,  6 Nov 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IuAgDfKX"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E2345CC9
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440431; cv=fail; b=SF0nI9hII1tZWI/EfT5idsA2wPH9ekYRBi2ZoslJ5Er5G+k37Il4VlqrDXXp4NzvWXzjm0gRW5ff9t4MF1w6ZZYbSuc/o2fb9uqmehfcmi+Hr2s0DeLudFhiUDOAY9SG038fty1lL9RYtiTfQE2wD3hy9Q9d6+9XMOfocXp2BZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440431; c=relaxed/simple;
	bh=mP8zhRJbbrX4ZKSAg5rvmGe5fhi/PvFWNur3wu20TLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P5fnTWQTtXX+tO0BamBn8kq/e/xfeRw3RoePGEKRAAa5wOd0485QFZzo2kPX8i/2tCNVHtyOqAIY1VqpnjuhuGKqgzi7NnBG4m1zOn0LykMko1gMgRPqMEC6VwAKyh71fzuDp+P6kTfI27EEnis6B+9M1YLSEQaBI2y1D5R1zIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IuAgDfKX; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUrE6DXrKVwXEHnZcqMoyyHe+j6mFv1NWefuTZvDgs2f3Tth+c+hCWc99t6ks+a+W7qSrf4BFg3vmky8GRSr3ZLhfeS41xDrNZMur/8DFNOskQCMaaDbByeSNSp7b9WqYrBdJpL7fO9yGLMni5fxeCZ5o9z8+AkstAuO/bqfAzxqpkJFsLHy4uxDUHCG1W4K4Jx55Wl3xqvPiEmnam1XUo5iPye//tSnmpBmKeVZ8Wukh9jWuhaUP18mRuosCqSGYXTgOuakgIADN1H2jCyO4sjQnpOqoBpykzzf+s5rj3r2R2+6GAX/zIgLMjvynIBMx5G90wuJRkaYQyBJFbE8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwMSkBS4RB7TJkvHiXSnpGXFl4qNwIc/IgP8aQFBv6U=;
 b=tGu18XZMG0G46K4EO0AL2y1m8tOavtYAos9hwtiCMM6sU+JVqUk6FsBK/Z79URdAEi9jy+zxnlFptYIdxy1HAWUlPIm43hsavvm/m3zmIniVhPpt/KcKFf/g8vXmanHY0XszcZwxoWUeSQJeakETkhaXzNd0zADjAh3vZlMRyU/gCzG7HwDpeov9tBlRn0EHaS6zFl06DJBT6EQjP6lboweJpJyp/ixCijITtTOBhrmLvnNaEZu3qeI9LpcR8rhlSJc8Kgd6TEq8thG/mAmWR8jKUwkMVa8ZRUPtvEEnr5PsV7u8qcYf/f+qtBSzSmV8IfdUx2WDFvbeq8p3QSWg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwMSkBS4RB7TJkvHiXSnpGXFl4qNwIc/IgP8aQFBv6U=;
 b=IuAgDfKX+eBEmnV25BzIIInrno7mXUf3unzYFWKo5SU8xCiqhHs0X7k4tfYATGMfb9ehdFBt2MDT5WmeNbUoS4jX34KTq6qdLHoG+/NhmhwYUHNUpjLYumVB1tM48FTywk0o0k6RH3aZCpTvhof45L+PNyoxjNJVVxdgX2Xu4615GHcpHPP2WT+EaTCA0RAs/z1BVlRuMDFRzrZoTd0aduvzLI3y0QTo57g9mH5X6o+1I9y9wHo420k0TLQzXEXTG5WLZ2m0wtnOWlrmLu0dRgqccXnvDF8W3XYzlMQUpXh4J/7R4gAOTeEU8wF6Ko9bQZ5rSnRUsmYHze29AFQfow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AS8PR04MB8611.eurprd04.prod.outlook.com (2603:10a6:20b:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 14:47:07 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 14:47:07 +0000
Date: Thu, 6 Nov 2025 16:47:03 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH net-next 1/3] net: phy: realtek: eliminate priv->phycr2
 variable
Message-ID: <20251106144703.wroevzsoyvr7urzf@skbuf>
References: <20251106111003.37023-1-vladimir.oltean@nxp.com>
 <20251106111003.37023-2-vladimir.oltean@nxp.com>
 <07183d23-c766-4ab5-962a-76ed4f5b99f0@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07183d23-c766-4ab5-962a-76ed4f5b99f0@lunn.ch>
X-ClientProxiedBy: VI1PR08CA0246.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::19) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AS8PR04MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 2815f173-b723-40e0-62ef-08de1d435b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BxVqim3yfBTOfCb+PU4DEvt5uYBxo3PPn8QVeNEVTFgGqTfrxFIMU0npJXqM?=
 =?us-ascii?Q?7Ay0bxb8I2P6ahFqeN0VEnkEd/cUU1urhZ8TGoyMDHCD0nti865q98vf9W3M?=
 =?us-ascii?Q?FC8cfwZn/93ZjE9QjalZNuZqdLYFR8fU+ugnvl80VOVv38x31fpM1k30x0Ae?=
 =?us-ascii?Q?8jtd0Ss/oY6kU6Uvn/GJUKWoR0GzKBHQO+L7M4aTgDHdi+67Pzy+RZXCEyv2?=
 =?us-ascii?Q?8NFJnSpdwxE8gM64c4DDN4BlMOTGArxNXLmS5Mhm4MK7ydHSI3YPP67x2ipw?=
 =?us-ascii?Q?bT/Hj3LyUuChthCtbNsTZDZpaGgBWFEWVBwN8EokfC9kzzJc/ywIfCpgPC8K?=
 =?us-ascii?Q?AI4nsDDMQ8eEgJWU8DY6u+CpLELsFnxRItNxVwtDT6CIiMuOzjIpHxBMYIkf?=
 =?us-ascii?Q?C/7dDYdM8UnfcyGY8dDJj17ZhWQkzzF4fNs+I0QCxYhFOKCv+AH6ze+RnGGn?=
 =?us-ascii?Q?WcfUSqwXQMjMgBcoMXN4hwYMtynTqkX7ZSFYBPl8IH6vFnVG0PF2NSn30PKF?=
 =?us-ascii?Q?Zxj8oBGAtxCm0i7nDruO6wVI/cQ1elCLbgpwA0CWIeVe+FLDG5o7j2IsHYq4?=
 =?us-ascii?Q?tt0lzX5/vCpvqX0PchKwRNpG6ks2D5zCxdzUkOJTiOcsRIkHPbkPym8RpiHj?=
 =?us-ascii?Q?kh0eD8XtgHRXX9uCzEfCKPcqIxRFEytLCQQTEjeZuF7e6LkJKcgq1rNGEyeO?=
 =?us-ascii?Q?AfXoLiUIUBHuBe2XH1UB8+dM3eSIC7NaRAhSKqeBRwurF589uoHpel3ss1tm?=
 =?us-ascii?Q?H+37cvNr1kldL1dZky/PQplx1TThJQzrB9KjGFKRlhF8EQ7l7hCCXPedvaBe?=
 =?us-ascii?Q?eUQVAbHe2ETzGyxKZmuK6k9WUemeMdf9UZul+0+c6WY9zHN4WOo6ieehpUbO?=
 =?us-ascii?Q?HK3i+uqVMf1FUJt9IzlEWMHHJIZGn8OXeZ6l7F9VY8ZMs7DoXfo/tYdSUmgC?=
 =?us-ascii?Q?AVic6mV25RWaptObJygfYMFhuVA4HSV8wyryzMlbc0fDWwfXHmiMswplG/KH?=
 =?us-ascii?Q?d3wQhWO0eppYV+han8q3H7e5iZkvhpKV0KyIJxR7ep+yuyBzZgrKMa5oSlpb?=
 =?us-ascii?Q?GHqrtJJ5LoZgOMOzO1RuFcMMRn4b5YZwWdIqduie2JMr4NEwD5PC1HGVcKph?=
 =?us-ascii?Q?LoUf47skZVTFHQAPwQnyz0KJoY4FeOV0/E1wY9De2Uw6lJf2Wlvst9rlAtvO?=
 =?us-ascii?Q?5ODZikekIqbzYgpy1QuBd+uFjZNhEFv8A9iOJggFM6PJwS8G+FgyH2JursKJ?=
 =?us-ascii?Q?rhXb3eDVBll6VbNIf12j4Xu2kDEMvLGJg3fhNgf5QEwarDDK3dQdWzJ2ryXz?=
 =?us-ascii?Q?zBzucJQ/Z88oBTjJhzF6Oy2s0nokgnVsWwG5EAAuRrCYVYsYzLPtuhrrbQpa?=
 =?us-ascii?Q?oP8Ru3cuJiFmBGFMr/Rq6hBuQ4d+qrCVmosp0pAvdkzJicfI/xo2o6HR1KWh?=
 =?us-ascii?Q?1PlhPIlJeG52DswxfQ9x6L77AX44WGI/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gz3N6m8ibhh4oCuUrPsF3CLlaUVYk3gsRoZEBOyEIeS1gQ87PwNpRUljcNm3?=
 =?us-ascii?Q?udZLA2/K510R+Sb+cmd7uxXbw3Hkxl/HJM1sFKNlCUpZ7+s7xRZNDBpTO/5u?=
 =?us-ascii?Q?SO0Ek3/ZURWexkGXWxVrRfhM/ElON+IsuRBS5BSIlWfCamgr4c1DmP+qTL/w?=
 =?us-ascii?Q?KNamMAt8bPSNQKnh3X/Gm04ab04rso+VL65xiuTMivTM7Pjd9TGc3K2AqcHx?=
 =?us-ascii?Q?t4rOxAdi6bUZo6EI7x/V1sBuH6CUTovPoIi7f5UrwaC7yrzHrIK4ORxRiN54?=
 =?us-ascii?Q?ewPvWipGRlgz9N//8B0SUBhQ7CWljCd3sGyo3D+aMBkZlw4aCal/B+j6Q7/b?=
 =?us-ascii?Q?YNK0J3qLOkRYEwrfeubjij6iLYgCtWEVQb4tuFgdLQXyL81fEsZHKniQbVpV?=
 =?us-ascii?Q?SESNBDK4jKlsgWU9rwwWFgqTs/a71lZ4JZXKZf6kpejjYF793WYGyt22zQNs?=
 =?us-ascii?Q?6dnysrRVDz1gvii3poZ7K3a7Dq1dIDcvVg9u0nEMZB/YHk9nTi1bTWINfYh8?=
 =?us-ascii?Q?/RJWleQ+7zoIl4wZ5x0i+XzGyO1TkdtVCeS59B+n0nFmAZJW2Ihqmz6bX/u7?=
 =?us-ascii?Q?3ktjjoxN0MTDnu1Ql+BaiPrSZiI0olhEmDaj7p7YGv3UkTvQ9HWA2bD9pMiZ?=
 =?us-ascii?Q?dyoXzCKGw3DaWjExGQHyf4QKQPHimAzbFpo/BreU9Yxb0CV9a3qA8AlsL4OD?=
 =?us-ascii?Q?NT8t3oS1Hw6/xWMYTpHY8OQeyx2ULjR+6gbC8qewcCDlXgtOvbTQzmeU652k?=
 =?us-ascii?Q?wH3cMoSduByLGPcroOP71qL9Y1LuDU1is8CHh83jNXc2Sjx5dKjUddO++sE0?=
 =?us-ascii?Q?6np4PDwrc12aS6utXxX0XFSf16d9L+mv+rmCaRxyg1YYHcYytCTEmyM4BWSj?=
 =?us-ascii?Q?Rs9YWA3XEnPlvkrHbOx/sBbgTQ/PwezJ8kCdFB7DNlzBCmmKZOLA1UFh60Rm?=
 =?us-ascii?Q?3U2C/ZrdOM5DQ+dd79FDrWlCbrInY3E+kZNo6Xjqe9U2hZZfl9sD1rivGNEX?=
 =?us-ascii?Q?N55qfV2I+s50S74FzZsnjjYtf09lVlbkT3giUg3KB20/Ri9aHgWqwrUWp70q?=
 =?us-ascii?Q?/FlTrN/XM3OwnQCcsxkb59DwdrzHqqhPdt5PvJNszJftx5P2llFGbOO1OWBx?=
 =?us-ascii?Q?iINNXwNV2/SOT9N9NxPJLERG4e1UO14APuFoBZDJRNWxIfnMJOp0V8S5WqI9?=
 =?us-ascii?Q?CEJog0+ZBgmZ0+vAanF1yj+H7voOool3aVA6O6tsmF4uFE4+ltz3StZq0Zbb?=
 =?us-ascii?Q?ggOeKoCKtlRFT1Ap9AFnrhqvV2TVKVZQ2crd7b15oMvNTTYLCL3goWqIWfjP?=
 =?us-ascii?Q?jQZYi8hUM7cuG/TfUFjdELUMb6/3NwlXz//xVVfzTdG13fUZXsaLh5gyiQW0?=
 =?us-ascii?Q?SHZQ4fNB3oh12wc6aKIJUQ9JBIpXyKEEKseKhb5mnwbuTTauHeUBVVgRCU0y?=
 =?us-ascii?Q?54SvJcyw2Jy1fFJ1Gtya/xCO9yF6fac34eyJZ4TgNCYQMMaryxAKk+HyNSmy?=
 =?us-ascii?Q?ZbZ9+w0JJDWexLCGI9aCy/A4ZbgGgzKGJpBgpZ+n0QYSSn2/o+Jp7YrxgECJ?=
 =?us-ascii?Q?WXdT+FCVLVKJlo3nnlwmH+eQl9p8Zftuf2sb2tJbY9+SqBJtUxZeLgxk0Nnm?=
 =?us-ascii?Q?4/1lmz3sKxP+nsXu6Z8s56lv+atx339Q6BNhspvFbsCouLEVd9jcmd2j05km?=
 =?us-ascii?Q?lgXCbw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2815f173-b723-40e0-62ef-08de1d435b6e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:47:06.9716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbLlB8Y45LOKilUfRGmwzFzupN2pV5M1NHeVGWC6siBewslERVgVtOiy06VA1AXaDjaMNiWuCj5TNYFW038T9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8611

On Thu, Nov 06, 2025 at 02:51:12PM +0100, Andrew Lunn wrote:
> > +static int rtl8211f_disable_clk_out(struct phy_device *phydev)
> > +{
> > +	struct rtl821x_priv *priv = phydev->priv;
> > +
> > +	/* The value is preserved if the device tree property is absent */
> > +	if (!priv->disable_clk_out)
> > +		return 0;
> 
> The name rtl8211f_disable_clk_out() suggests that it is going to
> disable the clock output. In fact it is conditional, and might not
> actually do anything. Maybe move the condition outside? Or maybe
> rename it to rtl8211f_config_clk_out()?
> 
> 	Andrew

It was born out of a desire to keep the main control flow simpler.
Among the two alternatives, I would prefer to rename this function to
rtl8211f_config_clk_out().

Thanks for the review.

pw-bot: cr

