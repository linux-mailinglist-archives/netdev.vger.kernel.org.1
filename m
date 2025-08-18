Return-Path: <netdev+bounces-214576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7800AB2A5EA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8E81B634DF
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7BF320CCF;
	Mon, 18 Aug 2025 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nb7TLaMH"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87266258EDE;
	Mon, 18 Aug 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523310; cv=fail; b=hk0gmWr73DwHmd2kb1zT/msLt1+IMRAsURgl5uOrYKsFASdPRJoYP8mItKuNE3D8mBTwUb0YnJtfTdBztyr/FjAzDz8u4UPrfeO5erdIku01Na7YGJwReSJgB0ns4lXiI4HY6V9w0VwayqmSzJAS+Du3FEQSvMcx3EcDrduEWiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523310; c=relaxed/simple;
	bh=p0kZ6E8N74R3Qntt27XzxmNvCcS43gX2f7zgrldFnBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YkY5DWzn9JO4RvGI8YZWEX5ZCKH9GvZ5pLhgqMe3ke67rnWGUsu4+cbqGAg1Zg/yDy4EgFr3xkoO2TdwRi2Ohzzq5GLC/1lNjBHPMAr7gR/EpMuYPQAjhhXrMDTaVgRbmZtn1nhN4yoJwXKPu4a4Mt+gLLx/u77ExiZ9B+kQiHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nb7TLaMH; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxbOrK3Z8V7Hc7mUVylp++VaaCRkfuU8aduHwWPd2gQZo+O/DQVqf4cGno74wmzMM5Dcn+2fe2cQmSTMN28KooCkT3pCCaDl4+C+gGZ2cbH5pNhjwUGa3/xdiC+8EEWEDDSZjT9ktFlRixvTispwMHZpQ80nIzg3B8lsIMaOr2GX0Edrc+IeskN3fABohzP5ELBndbsWUQyhGSf9Zk1QMOIMQqBb+tJmhjMDQM34/jYmVwQ2v11CdiiSYOpfd+pPXhiyTNSCl+TQ/nMYwkXcSJpKkgT2s8G0KpuVFz0qPcsbiPBAXBDJ4ULkYDLWGsGkCs9T5JFk7cl7yqmINFtJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7gSyCV3PB4xPD7PUlft7xMeoPH6iHl6x6X06Wx1xpM=;
 b=Vc4aLM/GOCt9uE4mb5kl+SorWohTxcgXACvQvMh2nRInnXRfch34TgvevMwa/vex9+4ibc/YeXU/ZPDWATpb1vkEi2nnObIcrtlU0BVEt28wsVR17HrlhZb59IhAT/QPAmGQBXDaqBPi53EkQiT0DQpHcUbccAyx7SMJHcnkRQAs1R+2NrT200nopwrBUDYxymYSdn1wT01Lnqtm2uVogv1uhpwPc7+CjWl8+KIwWhkgvCn54Vw2pBDWgWvFecJrL2+LY9kgZbqi0xvrhjdpQtzbdhSiPb34PsnwINP8G/qDVFSvJP3nCghtSlODqKq6qyYSd44IxUMP+4k+ZF4QOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7gSyCV3PB4xPD7PUlft7xMeoPH6iHl6x6X06Wx1xpM=;
 b=nb7TLaMH2FJ1wUmR0Ogxhbl1J4iL/NKo0o4Fn7PQoiDFU3PFfpwmv7G3wiztreMJNANI82JVCJHV+RpiMMY2mEmyzatCLnJ34N48Ya8SLitHwpL7yijHTMD0TKOcPHTLEP7xeFajdNDQqSuiefRkEPR0D2fSlk6YN3MVyUwjerPdZnMz4aTmkotfSAD8aS8JXc5MvrirDSBsdTCvIIjfv1gPNOpwPF4nXG1QGd0tZ71f1gl2fmFozpTk9an1pCRo8aRqeW0ZIr2K/aUf8DLTXEP0WvgozClGMWqplv5yLCePQNEZg/MqAQlbC+dkdxRKjrX9oLYh0mMGe/Frg9KOAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10189.eurprd04.prod.outlook.com (2603:10a6:800:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 13:21:44 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 13:21:44 +0000
Date: Mon, 18 Aug 2025 16:21:41 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	rmk+kernel@armlinux.org.uk, rosenp@gmail.com,
	christophe.jaillet@wanadoo.fr, viro@zeniv.linux.org.uk,
	quentin.schulz@bootlin.com, atenart@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250818132141.ezxmflzzg6kj5t7k@skbuf>
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
X-ClientProxiedBy: BE1P281CA0413.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10189:EE_
X-MS-Office365-Filtering-Correlation-Id: 451f490c-8796-4e2e-1081-08ddde5a2d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|19092799006|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?48HAQJEIRXt2+ZjbgVVIw4w/mIxFxWnP4NjkfwleS+wkHCK7Glhco33ve4Bv?=
 =?us-ascii?Q?xGiwFdOC+mi8XD+nWMCHdvQewmVZAu6fgthSMwFnTicsii5dwleiGjAMQT3s?=
 =?us-ascii?Q?LKMAa0CdE7OaZNruOIjUs0izLD9V/FOAuyXSmix+4MqF9fmkV9KNcdAJspIE?=
 =?us-ascii?Q?Ee8g041WYOOUX+acAi1+7v1EWvIJDfEryme+Y6kasjtq6dpZCu6mzmxKJR9C?=
 =?us-ascii?Q?ygwFbDnmrEVFNKQ0aNaCaYsdivfb3fmhwie3X4a9H8zmeEenFyb5ZAYDStW+?=
 =?us-ascii?Q?Hlkh4RMQ2q1/IthTQRmRwd59xHj4q9ILThMDbPCSl7+Iz4Q8X+VKSpbhg0gt?=
 =?us-ascii?Q?LCrKJOZNL6oF43bSQBGVwcPv8FKPr7/PJ16U5+EWz8MKw9hy9Wug2GLqMK2H?=
 =?us-ascii?Q?In+7ZVSZjYdKYm/cdB6gkgQDcuNIqueLmm/HK+b9Tkx6TC5mABKxTp0mP6OY?=
 =?us-ascii?Q?KBlN+tHlmoQ8qvBwDhx2L8hQDYYS2+ccL5zbPNBcIQoANepU+rzxDYaLcirg?=
 =?us-ascii?Q?TaADZH9P8WlAlYn+8NmerupKJ9Ww9P5YiuD5gvS8EW+WLykXgU05vbJOMUyn?=
 =?us-ascii?Q?LvQHaygbkeFIQ599soxmjbc4/LSAELVqBu2B3RNk+9d3Nl/u+aT3WgJfX48a?=
 =?us-ascii?Q?aRZLYlTyreK8hu/nLqHgmMS6ay+wwjWt8/xVTgi9P4wtKU5UXWGC8vIbSHMa?=
 =?us-ascii?Q?TuR36iRyjIEU1I4cK/o4nwN0WVO8K/Bwpj+mcuf34HdhW/MftbFLbMjBo/LH?=
 =?us-ascii?Q?Yjub3j3Mwrq5KKD670h92lAr+1C11g4MQq38KxYkDjnCW5LKEAmTB85aQOYX?=
 =?us-ascii?Q?0IOgU4s5xaB73fM+Wfn6ECae1xGJsWTiNOZD7TEYeuVldpcLS0C7EzESizSo?=
 =?us-ascii?Q?Z8NRa8QU3lJ779OuwmqUrzbW/tJiZ/CDeB1CFJVASGmy12ZzTiEQ3YkVhOhT?=
 =?us-ascii?Q?juwonte1zB7ng/D9zmsnnk4M7mndXzfhWRk8rt7OfmpW4U7jscNWC6N5pHFQ?=
 =?us-ascii?Q?h68iwtZwendhPVrfdlHMDaxsD3jMuS6kBNdz/GkJOJkRz/Rd6nLeqNNik/mq?=
 =?us-ascii?Q?OpbLK/VzX6WKu0ydelCDBn2kcX46Chwc+9tgRJ9ptEXHv06kgd5fsBp8d8Mz?=
 =?us-ascii?Q?p75/817N665DuOaTK+lRKTvQ9qUZJnbsJPhNAT/e3uIdZLva5Y3d0HhLvcCA?=
 =?us-ascii?Q?0vmsk9JxS2GjHC1ynga0i+QZ/ShhknA+zI6seaVpP6xEe/UP5VNSQJLvEeYN?=
 =?us-ascii?Q?r7qvCUcIdo+ZWKTvZL3mlNVvukuz2YNKuSqfjJyoGjA/a8AtCqkQ5iNZTKV4?=
 =?us-ascii?Q?lGSlPj6s8l/kI/acT3Xc60UlPhq21YX5QPcu34otAWQWm+rVk22fhmZPnprw?=
 =?us-ascii?Q?aDbsZTODFYNnMO3acAz7ti1RJM8mQdBccaYi6UzC4TBSZUsXGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(19092799006)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PMxquwb9nE4H7I9eEEGfmWlDLXZRzd3M1BMXVJYgHLljEumWoQFPDaD6M22N?=
 =?us-ascii?Q?NESYwcojxxa73y+jjJIPRabkex5V4IdGBBvVoSTWh/IbPY4N2ijc/bYOcHaF?=
 =?us-ascii?Q?Ndi0lL4YgoryB0c1zmuPTA96kccPZiy4VzdgtEmFLiIXfFs+ji/5hUMzoSHG?=
 =?us-ascii?Q?MFDOCxyEWxMSYBOcyXU6klNYbtn9i6/JCfbixVw2Dprxddl6FHtfvd3gvOLy?=
 =?us-ascii?Q?KNzhEeA41PCGO9yNtB7i2HoKo5DL+YJDVDfmSfe0qN6eSVZmUGYEiPUdBmim?=
 =?us-ascii?Q?mHtFAiJWE34K95q1Bz8KjjFbMTXfNtmwaPId8bHrJd3PSlR1MJDf415LB7Zz?=
 =?us-ascii?Q?or0xlpKMJiFYImAXKHbXZnYcC35c6neKSj9X3llyVl7YprpmnL+S9tTa7Uc/?=
 =?us-ascii?Q?aC5FI5dOK3Jl8Uvt6sGHtcIIDnSbaS15tCxKslKEyXFuRgN/j5eRTXWqsapc?=
 =?us-ascii?Q?2Y+WrkRyOqgmhCyYo3MEv045d3vHIwjQZHBQAM28gXtPnlksueU+g9gekU28?=
 =?us-ascii?Q?4A+gaRejz2S9B+j/1XU4bjt4tXAuoO9q2x74eS0d2yHVL3cFLfW7ur4XXZN1?=
 =?us-ascii?Q?Jy7fUMWcy5DvPud5wcO9TH5EKcea2HDv/kDku9EgZYFDwW3EuJkoAlNSJDzY?=
 =?us-ascii?Q?2KXlE6eJFL6jIbTdCGzo9SLEYj+eKFx2EH7cZmNqkgosKz8Ij5Z/yD8MeesR?=
 =?us-ascii?Q?01tk+u/nAIuUUZ5wE73muqpwGINaNUxrRT6waiNDVIoxeY15vPUTV0dXBkuD?=
 =?us-ascii?Q?u1rLwaoPiW1jZJVpQqOjq4SkDyq1fu5wC2ApohymWvHXotRKBTbb3EfjVROD?=
 =?us-ascii?Q?JmtclkVkJKfVQNPJ6s3pdJWWakM++gmmGc0WvXu9B360J/2NzhhLQ6lN777k?=
 =?us-ascii?Q?54sSwt4960FNnDPBIPevm2/9cVV0Z2+9TjHgQytqyBCDkk59a+3yVyha13ba?=
 =?us-ascii?Q?/UbaFoRxcTYVY4DhcfSuntsFp9LLxNFwewCRH6QqIcxJe48Le67nz3b2uLvQ?=
 =?us-ascii?Q?Uh6BOau2Oy4SQ/Fjt02mvI6R3masMXauDWiwVoI7LZ+5cosYJzvKHCNDNG0j?=
 =?us-ascii?Q?tPktdSLdTvKn8UyZRNh8X3ZPygVEizE0W1BrmVxl0Bc4Ua+XB0jWSF4ZINli?=
 =?us-ascii?Q?hFfogrMoRi3NChnDmAPxW3I1S/x7h9+JVBKlu9Q++J7umpcBmcZKr0Eyctdg?=
 =?us-ascii?Q?Gpr2o4+1XMIrUen3ytnEFujVh8nqjAptJ6wG4lhvbxKqFf8TZg/WGm7NNa4o?=
 =?us-ascii?Q?ntIDRjHfaepNS9bslHStWOAIQcQDpfd3wkqp+5kXbB41TpvNFhQ5gcR++GMh?=
 =?us-ascii?Q?kg/dJAeycIzadpinpon36GNWACNSF3zsT93WNRpkOF6JOPh+eqlrlWk1bfrJ?=
 =?us-ascii?Q?8D+7LWxrCm8OwEd6jY4OzjpksW+vIEURvEiMWrM57NG8pl2Ts4IgEBgD3ieb?=
 =?us-ascii?Q?sg06l1yNaINPxSZVYKDuUdh9/yiEwd+opkTsCWJpr+DvqtAlzYr3nfo2eoX7?=
 =?us-ascii?Q?9U58YOkV3wrksGXXZyCF53vOkc0gOvGc7AABJL3eDP1AVkpYXMAVcgHe0Ycg?=
 =?us-ascii?Q?UTkNCP66yYOMRV1aCPcBTUKvWTUDnhS/Hp6kBLdLsP+ARN66x4DPO+Kg4mta?=
 =?us-ascii?Q?D4+gNrC4CaEwmjBzhFRoBtFwpOo9otr+QZXtl4PqUSOgplTxawZ4j61WzmR8?=
 =?us-ascii?Q?wYNQgQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451f490c-8796-4e2e-1081-08ddde5a2d2f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 13:21:44.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ubf7/Tn2t2H9JfLUcSdP3GQ+cLa+ctBmTFh8GkOzHzZzIT6R6zu23qHjBzPxRRRgdnpcU6ir6AAYp47+YGhQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10189

On Mon, Aug 18, 2025 at 10:10:29AM +0200, Horatiu Vultur wrote:
> diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
> index 37e3e931a8e53..800da302ae632 100644
> --- a/drivers/net/phy/mscc/mscc_main.c
> +++ b/drivers/net/phy/mscc/mscc_main.c
> @@ -2368,6 +2368,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
>  	return vsc85xx_dt_led_modes_get(phydev, default_mode);
>  }
>  
> +static void vsc85xx_remove(struct phy_device *phydev)
> +{
> +	struct vsc8531_private *priv = phydev->priv;
> +
> +	skb_queue_purge(&priv->rx_skbs_list);
> +}

Have you tested this patch with an unbind/bind cycle? Haven't you found
that a call to ptp_clock_unregister() is also missing?

