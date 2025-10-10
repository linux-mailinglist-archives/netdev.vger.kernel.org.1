Return-Path: <netdev+bounces-228507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F84BCCFE7
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7A694E6E20
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FE02EF66A;
	Fri, 10 Oct 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dgqkdx1v"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F62EF651;
	Fri, 10 Oct 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100609; cv=fail; b=sZGx9FBxTdBhkvpKHL26Z2Bc5FIncg0U420IOGKzvY3K8aIxFNIK/4X68qvhyuICabnpO6oB/REOcb9uy679H8Sx9gRyi+omYT7kBeoggW6je+dQ4xzWGqee5b1qG8IMWxTujzVTyFqK9CvkfMEr6zoHGBOUgy5Ih29zExm50qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100609; c=relaxed/simple;
	bh=+IQF948Ag9FUdeSfQpa6onzZQwuk4yqWgIunu6gxWPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zl0DWxBRTgpkkgPUUgIzBvuBHxsC53ug/LJEg7E6WScc8mxtFRorLREr+6qRZuZfUHcJVKUZG+IxOMM3PLalcK2OfZdsoxw8vh3/n+65CN5QGnpdhqJ3KgYbptPUR4Qrfv7ZfTw68hMyt/8K8KO4pPMj4ZlM1hIOXB8dt+wSd3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dgqkdx1v; arc=fail smtp.client-ip=52.101.83.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGvKaXkqwUk236TNS/G2rx1otCnxb3gDwi/wF9hM0MYabCyPwIxKiDFh+KxJ/6rHbjWcg4+bX7QIarYYT0uCWJ1J/fsOBfH+NKEK3/x3HOtTcYyvoZ2YATN/4gOLtmF3MAtv/FMyDtIWm5MUFGAph5X0vO3Mij5D0WsBiy1oMzyaGNtE98u8t1/NGwI7B93JCzfUfHX0zdKQNZrX+TIqtootwDVVEhHdVa/JVKRxQVdzAfK7DzhCugYNc0VpADircRO3EPWt8k5Nm3tC/nyflJuxFvu/i+4FWYfOXtgo4xMhgsfuDmR+IXGzTqHQr1EoluE8my6HX9JfMC9uN87RoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMD03kOfbdXR6Kw9ED9rjLKUQY3OoUshUqZn10bG7gM=;
 b=iNyQpilWL7Gyi9GwRT8Ya0SCVrylE1xE4k6loVBlJKOuIdEKUwqnC9noQxYuiUZs6O765gZm7apZZ+/k4B76Xwqh06EVyX71xXa/SjFFC3ZmdHyy113o5fiBkAluCocwoe41F7iowE4ztF5YXcgGoJYqvNKJdWVep6nzww0ZW6oErjH0C2nK/EYqXl6X6rTR/vjUj6jbN3py4KAHWymagj2iXgaCsTevvXr5ktp+jbi+o7Mf0eHaTwbp/auyPs+Chp7ONOpZfjEAaoaQZRN/KdkD0IxljyPaWcTMd4naWlQD/BUvBV+ARjmTR5f3Jr2IP5jf2T/kQZACHIjvv+wwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMD03kOfbdXR6Kw9ED9rjLKUQY3OoUshUqZn10bG7gM=;
 b=Dgqkdx1vfqteVLUYM1wpbF02miKRMRaX1/vz3V3cCMe2pl40kkqkdDY2d2OQr0IkuQKioKD6Y3g1Kfw8x6x5YKTXZoM/W0bY4oACO5hOdhtlgzZqudHMeJtRMd+aSqFZm3n6nQLP72oHqKLhBEbTREUdby2RQLolx6Fo7jH4fNhIDQmJKy8oe9vJp6xhj3krDqQinP8A1lypxd3p1ky6Rt+MjIvWTEeJiKgNvrsMJ1Scb0GLhqSs3ECvVK6uaU4sIqA10T/OethYjCXp/iUzP1MOp4IpLafF5G/zUD74MY/drS5Ksn7d7AcinHxI93q9x7XzzGxDVzw3QiagbkaNPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9624.eurprd04.prod.outlook.com (2603:10a6:20b:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 12:50:02 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:50:02 +0000
Date: Fri, 10 Oct 2025 15:49:58 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Frank.Li@nxp.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Message-ID: <20251010124958.5fk33tb6o2m2qct7@skbuf>
References: <20251010092608.2520561-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010092608.2520561-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: 656dfc5f-b8ae-488b-7b64-08de07fb8729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Ps9PVhLWffcVUzB/IQW6WboBR3e6oHH6qnle7BKx+xoKXB58w88EIdruAkN?=
 =?us-ascii?Q?a/rioyyM/gARVqX2A9Tf24HHO0FVKwjJYCJw6f3u4NBpMzyXyqLrdQHZOm8s?=
 =?us-ascii?Q?OqTmNSLKYEYuwpi5kgFK5QzxvsDVW3fqaMUjs85nU18azqNhFjiwhmBTw8D2?=
 =?us-ascii?Q?2rt8JoKh911Oxn2Jzmqj1c6yi6X6G9+qqURSTfrYBPfs3iZAQoY9rtNdUbt8?=
 =?us-ascii?Q?RhxaQpQHMIqQJU+DWBtz0XD3Q0V21ssEwnW9HvMGMBZJnSzzcXg4i5FOrTO8?=
 =?us-ascii?Q?jR4G0hqtNnSes0Di7eRoYio1J5XKDaO1CEuQBd3y0/n0c/1pCEl/5TEsgiLZ?=
 =?us-ascii?Q?OS9PO4DmyubwcXKGGGaqfs2/vadUe4LOrJwivvpw7z8D0H6/9DRRg3W1WFR0?=
 =?us-ascii?Q?DPIUCd0G0llBVv9MeorjJnQzNhrzzmo7nYboxhHK8IkK1zg6pZLkZAsrBYNY?=
 =?us-ascii?Q?SjWCKNu5B2V2So1lJCHt53G2HOLSSTBwDFR8047JlWnW2rtl/aU9BPSd138O?=
 =?us-ascii?Q?0HTBntAje27ClUA7NFnh0WZfAXk0Ldk2faKexletsS2HaAGo0ELM0tDZMsm9?=
 =?us-ascii?Q?FFCy7NZqdWOogklQawkqgfrmbMtLKdGlTMGvWwgwozFctdEqxJURlRlWP0gp?=
 =?us-ascii?Q?Y+G9+DYwUDRazXqPGaQrV0L2LwGsqHJIVT0O283ylWFHD9ZMoTjZv0PDIrmX?=
 =?us-ascii?Q?h2+p9yCXvTvYrrdRw2LM5Tv1Hv0dzTpjhu5brlwa703PY4e3EA3N0FN/gT3p?=
 =?us-ascii?Q?TOTxPbPYaH6Xb6cnhcr4W1RSRfff3KhPgfcXsPNYE+CnQuVe1QHpYe7P9d2c?=
 =?us-ascii?Q?Br0/URHfRf/+as2Ylti+LliIhgNsiuTzgQLmmwvcZg2m5ifRuaqjM8mqyb+t?=
 =?us-ascii?Q?uQPpj/VkT7yThzIzb2UjcIcD4jax41TMMQL88AT58TaRYe5yyhm5X+alXRox?=
 =?us-ascii?Q?1KmJsrY8YlDxsC5brLplOjWZaxZjL/OcDaKS04ATkqpaZnh1VcM8gcKQTO8t?=
 =?us-ascii?Q?EZwuKzw94z/5Ah0n6oSsjZbuupo0yfY7t1r5O8BD4EoAgW9pQLwdUfAIa4P1?=
 =?us-ascii?Q?PPMGHNsfT0Iej1ojZDxzgbY0dOURwNglG4y6A5G45tpP3Rr7Ul8ipfwfQOTL?=
 =?us-ascii?Q?+XSMAoMa9GLl9vcCuwwK+TLaSD+cndm59AGq2dVulZt3sicJYO+HlI7dmy6L?=
 =?us-ascii?Q?K3Y9yi1TwtRjB8JbigO2jvl6Dc9hqAnrojsLh63M8b0IYYcV1jgru9f0V5jG?=
 =?us-ascii?Q?h+e0NHYPTMfBWn8nubKdB/rbHZksxfJn1VchOP/YG3B9f6KLknYtenKIB7p/?=
 =?us-ascii?Q?eedDeiAbmRo//4V0qTksGz1Pk0VddcFSbVrrdT+7XpI1VjD83JWn9jpaa/8m?=
 =?us-ascii?Q?DtDvYH8U7YjLAI+xXY47ukoYePHeU6rGw+GDYEy5gJNP/ks0RhtyWjf0LGzB?=
 =?us-ascii?Q?ueGpWzQVa+ejEohTjBUebtBYLNZnnAER?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VbkD35658EkWOptUOpCbY+KBB9aU71ASUlMIkZyYhTMTMZn1g6BSvQWTTbxA?=
 =?us-ascii?Q?5WIoKOA/TgFavcCkw4dT6ZW44rLkpdQjL6oX3ykvwsrGvxHUdHkvcU0Z7Ns2?=
 =?us-ascii?Q?AM/ZbuEMSBKwfrnmSu4jWjoddKtCkDgz1QHPvTI1yyfVqUThw4nfVqLexYOF?=
 =?us-ascii?Q?8TldXB4yoSJeFkjUPBC4WKydrvT1wCdEs3JihwvKVQlj+/KQNbbfJkfdevbO?=
 =?us-ascii?Q?hF4k5WJSeS3dTKyF0urL6EW0LPgPFxBAQBpfxBm0+uIXBZO/uctW7SPBXCaz?=
 =?us-ascii?Q?+0yb2Rj2SYh67eE+QeZCnpxl5o6xkFZfpO/ob6pZQcZ92cxCs+MfqcmiGzHD?=
 =?us-ascii?Q?8PkjUNdJ6JbOBaJKnV3tdHoGgCZOT8OA/YK7InWUAHCGBmaowOeMin5zYUR/?=
 =?us-ascii?Q?mkoUDWauJIHHgj72agKvGzjg9YygfApBdCRituIdzP3qJwDOuTzjGVl4zqdI?=
 =?us-ascii?Q?GSL0aTbty4rIgQT4xJaXvKInNBn1fRkFf5KVHUhLC0y0aqErisua6gENK90n?=
 =?us-ascii?Q?Yd5dYdF0mixi8b1nQbj4QwnQskLVRE47xUZEIaqiB+MXmhyxT3lYQo/ngFRi?=
 =?us-ascii?Q?cL4jYufM/+NMeiu+p1XTkbZi7QY9ZRrmOZZoO5juG/W355pf8Ww7ckpGD3u7?=
 =?us-ascii?Q?OlP7mqUnPHObe5tSFY2VjyAxhPIvSwmAH8yQd2Q7dxgjua4GlHoMNo0WyaXw?=
 =?us-ascii?Q?BVkpZ9NAlg8UKTu3S1uFjHsybTVhnCdGoNErlQPTzlv7dDGqgEWDiZXlF37V?=
 =?us-ascii?Q?fVf0bWRbwUXr1RW44iFLVmY+BOqHLu4NnjRmzGuM+O6/zqKphmbmjyiBy+T4?=
 =?us-ascii?Q?MG84wV0pUd06EP40N+JQBu8Rh8tZnLBqdh5bxVrERhp5TWV0GyuwrOkGwJ5s?=
 =?us-ascii?Q?5DTluMyQXp/fTMT/BoqYq78OcickWIztQH5DC+So4SLJ/7gkN4JAhJFE2PrS?=
 =?us-ascii?Q?3dTcnyFH5GYCzIP+3Y3rvh6FlZ4tXiARkS/6BsQ3IRmp55ZuzudBunz4R42n?=
 =?us-ascii?Q?aeGuijBvPEruGVnEvTVS04xJ0U8SNYlSmP8aHWf1KweWeRVnpuSB7yrAiUvP?=
 =?us-ascii?Q?cC8n24GYUHyFotKqxpopAAA5ZhWFu+sUM+Lhu4F/ABZjVC6nEtAcXo6JPXeT?=
 =?us-ascii?Q?o5rRM0Jojay0ZM7H0fnEo+e2ZNXFWOaDr8j51M52JilJeVb0Y+MDUgpLWYPG?=
 =?us-ascii?Q?K57pYwzJcELjzH1tfOChHfhW3jMlQma0vRIPWS8h96NI1rBAFzFbXHhf76zN?=
 =?us-ascii?Q?k4DnuidqyHh59Ard0SdFI/j2W2VP45nrorXZuYLnjzAYKBvKY9H3T2n4xdMM?=
 =?us-ascii?Q?n3TPZ9UjZXPhE00FeuQN+ULxWDftNdrwnP93smT3O2Us1RMvPwrS+r72S0Ih?=
 =?us-ascii?Q?oEwZ252wxZ9yXmciS7/Aoy7n6UPDcseokSkrpzgayPqM1biXK16tQT/al5pm?=
 =?us-ascii?Q?bsdF0V2H21PZ2cgytKLqIFTWCee4DhUC+gAz/KATxFVmI9kveHd5YECbLU98?=
 =?us-ascii?Q?c51wAk1SZcqRLSc1cWpR6fhuEqtcU1C1b2vcvMF4w52foz1D2qp1/JSUtrmo?=
 =?us-ascii?Q?4FJa7FxEKI0pPELfId2W/SGV/OqHR0CQLwHVaFseSfTrlvbN1c4W9IaxlmSg?=
 =?us-ascii?Q?WQ3UT0aWhejnjaY3w1aoDpBab7jBnudrN2aNHQtckVhfyQg+1yi+u60TjYrq?=
 =?us-ascii?Q?9JmIlA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656dfc5f-b8ae-488b-7b64-08de07fb8729
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:50:02.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pNrleU8LF3pLhlKhb9R6A/CYYO49iSUhxFWWvdNQx7svQzqFiNNDkGzqsDh3iqYL7GksNmyjD2oE97EM5dMHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9624

On Fri, Oct 10, 2025 at 05:26:08PM +0800, Wei Fang wrote:
> ENETC_RXB_TRUESIZE indicates the size of half a page, but the page size
> is adjustable, for ARM64 platform, the PAGE_SIZE can be 4K, 16K and 64K,
> so a fixed value '2048' is not correct when the PAGE_SIZE is 16K or 64K.
> 
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 0ec010a7d640..f279fa597991 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -76,7 +76,7 @@ struct enetc_lso_t {
>  #define ENETC_LSO_MAX_DATA_LEN		SZ_256K
>  
>  #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
> -#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
> +#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
>  #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
>  #define ENETC_RXB_DMA_SIZE	\
>  	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
> -- 
> 2.34.1
>

Is this a problem that needs to be fixed on stable kernels? What
behaviour is observed by the end user?

