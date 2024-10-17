Return-Path: <netdev+bounces-136369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103729A1859
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 04:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3205B1C202C9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 02:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BBA339A1;
	Thu, 17 Oct 2024 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fChK8m0S"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0C2C1A2;
	Thu, 17 Oct 2024 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130750; cv=fail; b=eWfoVSuoJ2q11odGpRBPu5vLGWf37WiU6WeLL2N4A4F4ORWhs1ZWqdKLHYx5jGedQ5epFled5d8KaX/8CUJc+9rnwZRcdLlyz4RmmGiVrUoARquZdioz/0I/ttZ9MK92q819GXXkDBgswFcXUvdaHMJ64+nFFZUeQSbxVwdmZVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130750; c=relaxed/simple;
	bh=8l6zMZrxrNkW9B1E8nkNWMg9+HvPATyQe7QOjMhi4DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VHjRxYbbZOB4jOjJnGQ/VdhKL8vqtwulSIMGiIfJJKIdFhxPeCp6WARtmJnI/UyWvzKPE06Tz6p6yz9FOveRhkTrjuvVyp3fgv2p5oAx9+8LTuJ1Ka5zn8Xdr5xc4AHpLluA6bA7JG7XZPCje0JDd9ktA+OemvQ7rT6gM6SwjjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fChK8m0S; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0/IoQiM20jsOuslgssch1oHobCXJU6j0NyVTIJsA28TLna7zJXHgjT/6nk8NHX5q8pgv6GFfkQrMePJbewgTLiiMaRib+W5JbzRFRuI/BKDcpMKI2ZkEL8gp3kTFUxkjYrMbAOddg6nUU75gPxV/R/MUCAJ3kCpnaEs3W4+OgfJaBuBJM2l+QDqdXQ4WHymD7iOiyvoWNd8ErMxMJ4vQvBBuuaTbqDE9KzWTXaSNAA+Pd/rnL2nX7qAbjgiYoIEfsJnCcgqR0I3jdUvz1gBvOO4YYES8x4VHGG4lbm0UnrLOEtasrYlyBJm4YHSLtmkBzQkCuHVUvzWjF+pHl9P3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwCcQnlNBeBLTslP6gEBTVkvi7EutC2KnsdodT5vrsY=;
 b=qwtjRTcYj8X7pUmALqTPAF4CRomzENzJlV2mXy9KokVuadtJ6Sa0VG7IRcoDd4KE65UC+qinCLbTEnKoIRH0SAtcuvSEldyMRLTv1mGYtidtSAixAauicjwFku39b10v4GQePEBLd5YyGSY3V87AyrztnEMP0tL6YsAgKwG6lBHK5778MyhznBrQtTx2hsvKGLcK6kBQJ40430HNd+IqaYwLm792A5iZh8HsegqsYVyxB1xped5V/IBxAAMOtaGiA/LQQQ2lXOS3dTS/1yCZKO+w57C/GfOz/Z05fSRKlml6kVQ0KviZWxbJNSI6O6I1JlEAKOmN0M5TMTfkgtsc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwCcQnlNBeBLTslP6gEBTVkvi7EutC2KnsdodT5vrsY=;
 b=fChK8m0SeNv+GSsQb2Q3hN61BgzFyJ8anRhTplRHkZYY/ei/LdSAn9kGxBgnU5jlKoWucejNodZUrueM4bx9bgrL2YKbROOdTJ8nvyDX4LAMRMqgjgqSTLTOBvNEWEVRhCgBBnB4loIRfugF+BIle316dosto2SixYmTqlj+wcfcMflkRSd9CnMze2EreBDEYF7qqHPpkJDzvzdoV8jNhUcJHmWHHbvA9LBHj20jt5ZjdmWd0IsWXclcSnRBTmZp9NBFrHWXy3qtc+qRsNRVOIA4aGtb5x0XfeKG2Q3JgKpaGv5+xCATuTEXXrH+CfpNgdR14zDHk/2NUhTNTBtESQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10873.eurprd04.prod.outlook.com (2603:10a6:150:224::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 02:05:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 02:05:44 +0000
Date: Wed, 16 Oct 2024 22:05:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 05/13] net: fec: fec_restart(): introduce a
 define for FEC_ECR_SPEED
Message-ID: <ZxBw8Jph6mPW8ExQ@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-5-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-5-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10873:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c62edf2-e4a7-4f8d-c084-08dcee50354d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zPCJaoVlUuYq8A4FJLtW+eNHveBkmQgHOmeFUqSZSOv7/4HU0WypMUebf3Lr?=
 =?us-ascii?Q?hgrwHI5oP+xl+iij4IW6GhTvW7Qyz9NG8EZS3XxjGJnSpY1WAGd+A880ZUzR?=
 =?us-ascii?Q?poHYjfoxmhUcs1ZULhwI6iOP18d0NN/43jTdnCzgw06Kcis17mYQAscrm3n1?=
 =?us-ascii?Q?QrEbVQPRDmeIjNV+UpGMvj2vLou/SRTgpIgea6/u1WC7Niux9Gwr4B9ISI8m?=
 =?us-ascii?Q?71H8LpIhi+p11P/k5kCx5raJpCBL5h+mI6VTuEQ/uRdwGQy0pHeei84v/g0I?=
 =?us-ascii?Q?z7QGL5awcpvyONAGaMq3EYUzeMK6xUBhF0fTDkX3icC8yZ9vzQHek1Ffj4hw?=
 =?us-ascii?Q?E/kGNTRFq7Ocuh5FM1h2gUsWFcIdJ+HvvE8Vdt83AeoG5/oTcBKaI3N9iyyx?=
 =?us-ascii?Q?iNWyo8UDHtLSuTTgoY32OIvc9KT1vuFtqbZf7MSYNo/tBkBAkLJggC+3ZcTn?=
 =?us-ascii?Q?DdVc9Pk6/DFwPXytMfDOTZ2E4cjd/VAM6B4l/5S/tKfktPE+DjPS8m+NfHCn?=
 =?us-ascii?Q?VpsN0HQDB7vaYUK42ug8E46fgbC3dqJo7nOCf/P/Sk6HKdB45Tx7BUHIBrjw?=
 =?us-ascii?Q?fyh60npFAYI6IsQCvx85+XJsRWroCACZZD/R20jVTdJQ7m/lOu+1EPVejaUk?=
 =?us-ascii?Q?0UIlZb9Rp7HzDhqHi60467gb5Yg7MFts7FsYtq+usg/BiMv3oDFphIaJUmT8?=
 =?us-ascii?Q?FJDfHxIyaW+xcjlK7cJ0sFkNa5YfKLvYrpKyhh9iQxKJ98NhJ6gpQfHeOfay?=
 =?us-ascii?Q?pjTY67LxV0L0GVlp956OzMsPASs7gekTD9erHk9mMta28A+WDcSXE4qNRHbS?=
 =?us-ascii?Q?SEePi3u0JJWNotCtk+u6cYEGnlTv8NXtANWuahr0IS6PvD6xAdkqjt/nGJrw?=
 =?us-ascii?Q?Vk96hAdozbhUFAnCTfv1xFU6/NFQ3XkhPvXJihmVwHIJ72A+liVheR5FrR1P?=
 =?us-ascii?Q?GA+Pvg6AEx+7Gw+Zz/d3K/8P0CN/+zUaBv5HdXcHpFypChOLtBeo+mqNY7Co?=
 =?us-ascii?Q?Gg3JRCcw4ge1Sk855fFuiEFn7guFXEt4WE1Ru13c3YaiT95aiIddO3Ll03qU?=
 =?us-ascii?Q?aBPiQaRPzeVC39tMW6fWqo0tJIG7MrUCtecDZX+8IKSNWPnrhCLE18qCA96k?=
 =?us-ascii?Q?st/AVhrtepH2GqHUOk19D/FaGJivbzXF8RjWy6UwIhDfDfguCgNO0b3ajYso?=
 =?us-ascii?Q?iswF/phYS2R8hfnxsz9UBbIlwtQ454wfQmblVfDbCsugDGplni8JjmQLsiW5?=
 =?us-ascii?Q?HaYMT4nZ8gOPBlBEAZv4xpFQgp/f0bK4KduRyzNB5V5q7pmRk04NaNGWX3rl?=
 =?us-ascii?Q?GxK5cH9jAo0FnhW/ZxJt9HEvICFE2JtanTyM+yqOgWyB8aV0IgNlUvuTZ1MB?=
 =?us-ascii?Q?qUTyiFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ms6yuedlAEUE+qsYybF3z7OD5dCsIfiVhrOj4PHTGr1AJbMDQ1b8a4IYsjE6?=
 =?us-ascii?Q?lJEIm9Pd2vRVjx0nt2hGfZ9jC6P+4NwO024sHCqO2YwsSl+DFl1PTWxnY1r9?=
 =?us-ascii?Q?eVrMwPcl0tzyncboa3CUT7Y8JUvNBCUfz1t7vtu34pLPXUWIzaErMT90Yaaw?=
 =?us-ascii?Q?71cBxsxCUcZwz+sugdz4GH24H/qS3JHV0jS+O63lcqzUrlIO2F9O+79ESDa2?=
 =?us-ascii?Q?UKz/zF6YSrLLsGTcqa3tL/pHMEfp4p+qwHy3onV0v7huMKWTpU+2eVyXsHYy?=
 =?us-ascii?Q?2I5Vtuz9zfa5JLEfYKElm5Y/vLg5BfdpRt8SXzpQvZ03PGBJ3Tg/FhGgaWlH?=
 =?us-ascii?Q?TkaFURnQsZof8Bcg6f4SCxKcRth0i+d+7YvXuWtms6cgxvpHS1MiAUgiESsj?=
 =?us-ascii?Q?6bG5FOYcwOnH/9u/mEUIE1A9ZGegFtljgWlk4imC6O9XMhYb5JFKg5/71CsU?=
 =?us-ascii?Q?hkkWcHaHOgqZzunUZLASL7ZxvKRVck4buzY6CRXZ8C43a3tTGIqCo1JfKtCF?=
 =?us-ascii?Q?89Dvifk0CJfLP0L89rNe28Z65S5RZStZTdfYW3b3B3U4iJpGOUm2mV+B+lV5?=
 =?us-ascii?Q?kcnpFenl1Se+OXzm5+mLA0Nfo7cYSluKGHf52RgpKaGpapci12Stm5C8N7vC?=
 =?us-ascii?Q?bf41ONW6Ekqs3ZRSEdlhSmEDoryIKWR3UkwN5YX2v2QOd1JQQlq4Kevlg4Hv?=
 =?us-ascii?Q?qLkJeWpfQwrFw8Qs2vKZfYG1Cqw4xQzecoHYY1/57MtWcVtoBMFPf3zQRngI?=
 =?us-ascii?Q?Ujr9qALMBxobLUEpS3Ak6YSV3kG9e3qV1ePfMtgniaMJDkeMOvXWuKJhkY4f?=
 =?us-ascii?Q?3aw+bmLZCopbVaKfcFhUIkhFMM33SXnTtR4xYV8vTd0t6VkKXA0C29qO1Fyf?=
 =?us-ascii?Q?DB8Px1b1Js3u+jubToGEeprGpnJT8stVek2+cQ66YBNK91NjJQ3V9Mf8jYOx?=
 =?us-ascii?Q?eGTjcesj3bmqF6svbhGmTQOIBfWz3sAewSrveXnMGsPIdQ0L0F+4FrupBmDz?=
 =?us-ascii?Q?zX+3mW7SkT7dpo4ziIYDwvSuXlF3lQdjw3zMckYv9wDhiSkVAvYqBj6Teyiv?=
 =?us-ascii?Q?30lK1XViN2j8vDQ1mkD9Sab30n1P/xv/lDIWH7sebMA/r5GA3VlVuFb661ta?=
 =?us-ascii?Q?wKcUpf2Th0Vk3OFc6YkGuADhQk0S0+iCZg+yrCY304/HNO9Z53jU5DZuUETM?=
 =?us-ascii?Q?5esnFl11D+XlQ1UgYS/rTanvOylipInZkUWKlLRSVyw+ASSXGuSi+vFKbn6c?=
 =?us-ascii?Q?jTpdxOEBWOdJPpp/XzjyXle6kzTdiVpfV23vk2AtULKF8f269om4jUN7wqu5?=
 =?us-ascii?Q?74DOKHDNBLfTJp16YUqE8HxEdAwXjN8lWNYVYvyor8tKMeC1VV5ICYozUjFo?=
 =?us-ascii?Q?XVMB/OReF6j8YUkxtK0uiJajX3XiwNV/5aqDRFdgVWO2Sw/ogS9D3aUxgAB6?=
 =?us-ascii?Q?F9VMSxXLmUFHNlJ6t5nDPN8OzzeiJZ6cJXTjd1Jd4xbxMC88dO49ZC3LIJ5o?=
 =?us-ascii?Q?JOK0/tholIBegLYQ6UV1HGtH4Myx0IPhwH8Fc5gb32POBhgg5ib1EJaj+jrm?=
 =?us-ascii?Q?JB8eWPH24v8E5T/cDD106+CpINW3Wyu8IRAe/8x2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c62edf2-e4a7-4f8d-c084-08dcee50354d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:05:44.0352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZFgVNjPKwQCEJ4R8CBFbP+QZrkrdw/gWCIHYYG1iCOj4ZcEPS/+xcySU1ZRan07mMKbNgrPMREXOB3OlOUojg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10873

On Wed, Oct 16, 2024 at 11:51:53PM +0200, Marc Kleine-Budde wrote:
> Instead of open coding the bit mask to configure for 1000 MBit/s add a
> define for it.

Replace "1 << 5" for configuring 1000 MBit/s with a defined constant to
improve code readability and maintainability.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index c57039cc83228dcd980a8fdbc18cd3eab2dfe1a5..2ee7e4765ba3163fb0d158e60b534b171da26c22 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -276,6 +276,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>  #define FEC_ECR_MAGICEN         BIT(2)
>  #define FEC_ECR_SLEEP           BIT(3)
>  #define FEC_ECR_EN1588          BIT(4)
> +#define FEC_ECR_SPEED           BIT(5)
>  #define FEC_ECR_BYTESWP         BIT(8)
>  /* FEC RCR bits definition */
>  #define FEC_RCR_LOOP            BIT(0)
> @@ -1160,7 +1161,7 @@ fec_restart(struct net_device *ndev)
>  		/* 1G, 100M or 10M */
>  		if (ndev->phydev) {
>  			if (ndev->phydev->speed == SPEED_1000)
> -				ecntl |= (1 << 5);
> +				ecntl |= FEC_ECR_SPEED;
>  			else if (ndev->phydev->speed == SPEED_100)
>  				rcntl &= ~FEC_RCR_10BASET;
>  			else
>
> --
> 2.45.2
>
>

