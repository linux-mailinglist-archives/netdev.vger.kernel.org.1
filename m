Return-Path: <netdev+bounces-136375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C736F9A1884
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 04:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F37285F47
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 02:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B5C40858;
	Thu, 17 Oct 2024 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DZY8C+aF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083721E3C2;
	Thu, 17 Oct 2024 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729131356; cv=fail; b=tCcu5K0JPLo38bbDAOtV/twN516E9HbZK/PVdmw5jjQeibvHWfzd5fTDO1tg1/+NOCqvx2L/7s2p2erN4iIBkVWJhYVF4AzrBJrKHEZq5NabN3AJM+gI6l3w3Q9iDCtqzf5+GhEGqchcpLEPBZ6JCp5c7m5NZBj53eH1Xebke7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729131356; c=relaxed/simple;
	bh=JYNZCMDNI7tT5ix+sNTRzkGs86p/DIDKWK8Skv3lfz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nL1i2u+tNoRw2uy1SU4voUwjiyXQSCh1U8XZH6tLNTYJe4S/suYORZPMfpMyyw4kVYRRr0gQzYUReiZw8CctfOA6AjWzCi0LzSaJCrDunBL/zOjMDrqPxRVl2/JwMs129IO5BokNKN6U+yayYNTWml2zYNQZebCD2ogvgJPY+5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DZY8C+aF; arc=fail smtp.client-ip=40.107.105.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSIRKvR08b1TEZ/r93Ol+6QppXMekO9DR4MhjMXMf//YoG4FLCuXVK+Yk7B/dq4VRZ8YkWfSV60os8GI4IkreLsBHSDT8xlaGHHxs7j2yKmhz9eJ6dmp5Ch6RAFbzadZBmRsQC6+6TLNt0coSmguwayWHOzQGmu0xJktyoxRxHHKE49zmtVNRIFifB5Hi44eVnLEdmB+lceagFqw/j7otv6oWG8pS9v+ybXfMawmhxM8Aols/s8ydzn3F8+lsg9gd/UcYrZkhjnZxmY+SynoPFqnoXbJiAlLC0eIUICQfBi4FiyGubXHUaANUWcRCcli6iSodkIt+NT+iFdOY1fJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWE496CvAVfr9CVbvLFf57GRQQQ79kOReFjHvIvbCH8=;
 b=tKwu+yozCybQMDiZFV77wGjg7Wdd4NT33ERPPrj0N25z0k+hpFnGCc9C2miE9lA/PuS9wepL7oxy5x9CropF3/bjubj9QctjA9dhWpTb7ZiFoN+z3OJgpkwONTRXBGvLlzI+MZvqOL4LfxGPk8yJHFWWIuOgRi44MN0oSQx44y/yuEVmt+YPxG6WTwF/VlHxUcH4KHRS6SScxk0KqPYm4ww2ZsqMDddxQG4JkTmvfmh/kB9puTbys7u6UOftBoTgqPI2Gz9ZaxlyLup5A30NIPnrlTp2UsvO8YRprhCKcQIUaHR3kb1JjDnj42sCFsEygG5WUqNe2qA7+aLgKBHTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWE496CvAVfr9CVbvLFf57GRQQQ79kOReFjHvIvbCH8=;
 b=DZY8C+aFpxP3FL+L3TsR0JpSW64DmvrdTnYf5KAw1vMZhRXb9MuaO2LAGCVsimQAychpwWFKh+JvFztKwalth6sHg9t5eg+1L7kOjxEWuyUx1oZTd8wM09gIbdc3BpHuR4pPegJ8T42yagKGdRUn6WL5iKaupc5RSa0bBSNjFQOjBaShiOgB307PcXtIfygHzp3MARIPPryQhj7/cWLGJ9V9Y+cGOakZAEyEwLWYvgVokuy8Q3UKHnS9hnFMFJu9X4kqsIGWSEvpesT8p8X1WoCB+AuKt8VUEgrsPG9Vg10YMK/fWMZDvqcyHKJf1EXJnXMMscvPfQAp8wneipEO7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10627.eurprd04.prod.outlook.com (2603:10a6:102:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 02:15:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 02:15:50 +0000
Date: Wed, 16 Oct 2024 22:15:43 -0400
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
Subject: Re: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk:
 bring IRQs in correct order
Message-ID: <ZxBzT2/SZFhgfPpW@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10627:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a3162a-acd3-4026-3c96-08dcee519f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iYj/XMNNtS5IZKEwnCdDd5TX5/wgxgC4u9x17pTXBjiPvmelsp73NA03zYBV?=
 =?us-ascii?Q?CIBcgf1JvT9MCYRf0DUi6oT8/+ndiNy4PIHFc6vr1l1Hr/ijyeNlbN+dSWQC?=
 =?us-ascii?Q?LU/ofX9ZUkX+H3G3bntAvs5FLWgRpEu8iQJAYj7cyLpLkk2L0gqMlrHuObAF?=
 =?us-ascii?Q?BIIupCYuLjr+ZCl3R7V+09Cxq9yrBOa7EKHRCBZ7hIshi0rWF9vyX/fOYRYh?=
 =?us-ascii?Q?MF3nmaYeKhjkaqXRlV2MoIXWJ3Fu36LrNhVD4OU7HKPxGEkJdSJ8xCpHNG8e?=
 =?us-ascii?Q?v/7jSY/if1zSfjTt981QwD3Xio0cKvDWIzg2Alsjw2fBpGC/YVo0Jvy619hN?=
 =?us-ascii?Q?rkB/yOV7Tmtvwv4SabHK4s16X6b4yPBRJVDBbVgOlk8oX/P298tL3v4M/0yJ?=
 =?us-ascii?Q?2Qo0B2EcAn3LHxFhDiL5vpufnKWVm4CmpIgDz7GK3RhMzMaeO0EMTQMZ1bPU?=
 =?us-ascii?Q?+xIbgR8K1KnBLKI97xhkGwRIleC7i1Rw0JRlpbHdfSg6H37tbBJdkPH68IQg?=
 =?us-ascii?Q?I1Dxgv34cok91pc+HnmB6ktnXqhyI8juoXt2skGtU/zIvI70VB91joaXQZpu?=
 =?us-ascii?Q?TJb3XQC7ICN0uVhAZeXWG0M6FmQuq4FnatL6s/KGoAE3CMqV6y/G/g14B+YR?=
 =?us-ascii?Q?4dRd2aBBNjIITcs4XhxJrk5PfCYFPo/SPP+8gp4u4Jw54/+WFqQPqhAbkbhF?=
 =?us-ascii?Q?Lj1jt1EcaFu60CCb7jCEIi4aAZWVeQPF3PCpAccA3PXy7jtI2HpmbIg0Yst3?=
 =?us-ascii?Q?nTwECmPl0rr8n98keHVRR/VZ8kk1Eu7iP5L66vPmhC1LQ9vlx9CjmcbWOdB3?=
 =?us-ascii?Q?n0AxQIZd6T/8+WKdiGH4i0Ncc9vHK7GHU0N2axZqo5jJ4mSN9AQ8I5z1Ey1o?=
 =?us-ascii?Q?DvfKIsZ9Eb33JruzD2I7wlmLb78QEpo8cCSay1UiQB3V/8OVUNT0OBXIFsCg?=
 =?us-ascii?Q?/4f2Y6c94LPXbXuWc0DfaKraQNXbMIK5fdi+S0KiwR0m6cLitj9cPHYRMncQ?=
 =?us-ascii?Q?bkEKqScVeWCse4ib1mFIat/pKrAurNndyKxPdkJm02Nc+gteXP+Deoxc1ref?=
 =?us-ascii?Q?vONB7KpZKAbvpj4gyvbSf/tCK96YEDJGCzIszt44BPNW4um3jYQPa5mdi/DY?=
 =?us-ascii?Q?lThiOokLnDWvlx3qSh7xZDJyL/npXr8lFEUIrNbvT1Bi0KqcoIEk7Dl8caHH?=
 =?us-ascii?Q?WX6LlaRCIR8wiMvrC068ngTmXqUtdVsaZYmfaBHFB9Lw3jUjhFqHtNmkoMdV?=
 =?us-ascii?Q?BTcKQHJ6hrtIhQdObCQRnBBpf4d1kLXXgyVw/9xT7XJKd/YfOAFC0irVKa99?=
 =?us-ascii?Q?dhXuUE7uNqPP9YOJz3rWEMaWuJEl4stPelRdrYsRNJnkQwYurLznTVUZXsiA?=
 =?us-ascii?Q?OEgpXnE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VJ2yN/dsM1na6tKMrUnpoyVYl3Kb0oVKC/gkPv5eXZY9wivts8BFK3IMleld?=
 =?us-ascii?Q?MOJB3N+4FO3tLD/E7sOIqI1ljz6kWA3p93IwDqXYj17G6hU75PkDg35f7Km3?=
 =?us-ascii?Q?nsNBcXX16Ui4/dH6RV6JYNowSOvXAuA2IE31csfuoKn0XHJvkHV6vwxB71rM?=
 =?us-ascii?Q?W4glkTdxobS7cRgmOx3NPzd0qQoksZzjCceZpfGP4xTQyp4uNvxT6L99xgXO?=
 =?us-ascii?Q?2/DWNK1ark01dArdfOeCSCpBmgnGorvEx2oWkoOuPAn+8vilSGZHQWtps2vU?=
 =?us-ascii?Q?6nDFwWGjRCZ2gJS6nktMYkANOzWOJAr0WZNiCBupoqjgeFeDdY1OA+BAvTaI?=
 =?us-ascii?Q?R9H8t/Kbj3buVGUzFU2kq1bBOfZwLcG5cbcGI6iJnteXw3LivXKaQsZUrHNw?=
 =?us-ascii?Q?VZ0dKcH704Kdm9m+NtWAHZ0bLtqBh+yDnrLOwB5AqpGkp7/okCUX8zKIJEVx?=
 =?us-ascii?Q?RXryrVwv6no5n0/7Ikva9D8iC/dAlcFqhqoz4GzV8AayZemUMM/Rxdp9ZiDi?=
 =?us-ascii?Q?cMgEevcNHFnDQ5feT5zOIba5OSuTd+MvDxP66WRkn2Yn1sV6MDFz5lPm4zwt?=
 =?us-ascii?Q?w+i3Onwz5kRK+5witglL3FmU472g+fxEaOZ0RuTVl3pRjXFyL6s4A72oxsQ4?=
 =?us-ascii?Q?ps9URmraV54muNc0604MnvcqlAjsxLvrXbWDEr9AvY1bxQ35WK2fClDIS+i6?=
 =?us-ascii?Q?F0v6KIFwC7nzCG8T4/pIYCmXlY9DIkd4EOL8VDnR4+2BoalKxFYNqmk0mZ90?=
 =?us-ascii?Q?B956ER6p0LHKJ/SDLT2550F3Dwr422qnoM6EjJ/hN16xGx8gmtlYw9c/N0gR?=
 =?us-ascii?Q?VGnLj9w9O5u+ILR1u/UgiZqktKZl5UMfFk8t4+mWDw8S+P0WhIjydZfc4KE7?=
 =?us-ascii?Q?H/nlcE574ocRrwSpM37POLc/YoU9ExW1tfY+oRBJs/s09LI3s80+IGpfdU5A?=
 =?us-ascii?Q?/DsW/1VgxKjfhr1sUEngipMu8PAidaA+YEQtwQLX9UmK+kUNDnIb/JaOFm8X?=
 =?us-ascii?Q?AUdr2hzUlasAiQiGZma/aW+3DhJw0UsSLE5mUG2+LyKO1hr0hBW4c8bx/l0e?=
 =?us-ascii?Q?i4NuoEJ5mWDlXlSmb5oYSLThjPj+2klRjXIzJG431WZj4Is5tqX0AcNigLB6?=
 =?us-ascii?Q?SAX6MvVcteWYDkP6I7hnFaLyiZYJ/ZzdIUXH3Npu+3ZNQTgwos4JuHosXBGE?=
 =?us-ascii?Q?lGWCxW0cTkeg+rCc76k1y4re48NFlmpvCAy95yoWbFy31h2MMSjSKQBwa7ip?=
 =?us-ascii?Q?HsiXvRnmVjHkfzqTxoU+DtLGN/Nif4GFLfY9Wh0icHBRdzwONI/eeSlQf5pa?=
 =?us-ascii?Q?odaxtMpl71Qyz5Ffh8LDZA4+08qhf1hKonRPN/eUn4hHy4NruGrsbaJHkbsS?=
 =?us-ascii?Q?bMFmWmsu2liwPNiaqHDZNBkw6AvDd84tB+01AIYTbkb2nX85Ig6eQtQsvvZo?=
 =?us-ascii?Q?HbQqm8/BlpdGPeANKx8n6UBXO7oMpZa5nCC4PP5cPHd+7txjWEPKopKUFluv?=
 =?us-ascii?Q?mFAh4RjyUhCwDdBDNmYu4WZNwxuxOth6yOS/FARx4AFnnLg5ib7V77AGdWZB?=
 =?us-ascii?Q?A2P/VpzCP92MBFJyn6dJB3h40q5cSbtGMqCYOCYU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a3162a-acd3-4026-3c96-08dcee519f10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:15:50.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCnM9vm/pjFje705r6ypsJOain18C5HrlGz6OgtOtO2Ngms4Gv/tHiml40eatDICwOf30aDvWXM1JJsNvqt5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10627

On Wed, Oct 16, 2024 at 11:51:55PM +0200, Marc Kleine-Budde wrote:
> With i.MX8MQ and compatible SoCs, the order of the IRQs in the device
> tree is not optimal. The driver expects the first three IRQs to match
> their corresponding queue, while the last (fourth) IRQ is used for the
> PPS:
>
> - 1st IRQ: "int0": queue0 + other IRQs
> - 2nd IRQ: "int1": queue1
> - 3rd IRQ: "int2": queue2
> - 4th IRQ: "pps": pps
>
> However, the i.MX8MQ and compatible SoCs do not use the
> "interrupt-names" property and specify the IRQs in the wrong order:
>
> - 1st IRQ: queue1
> - 2nd IRQ: queue2
> - 3rd IRQ: queue0 + other IRQs
> - 4th IRQ: pps

why not fix dts?

Frank

>
> First rename the quirk from FEC_QUIRK_WAKEUP_FROM_INT2 to
> FEC_QUIRK_INT2_IS_MAIN_IRQ, to better reflect it's functionality.
>
> If the FEC_QUIRK_INT2_IS_MAIN_IRQ quirk is active, put the IRQs back
> in the correct order, this is done in fec_probe().
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec.h      | 24 ++++++++++++++++++++++--
>  drivers/net/ethernet/freescale/fec_main.c | 18 +++++++++++-------
>  2 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 63744a86752540fcede7fc4c29865b2529492526..b0f1a3e28d5c8052be3a8a0fa18303a1df2bb5bd 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -504,8 +504,28 @@ struct bufdesc_ex {
>   */
>  #define FEC_QUIRK_DELAYED_CLKS_SUPPORT	(1 << 21)
>
> -/* i.MX8MQ SoC integration mix wakeup interrupt signal into "int2" interrupt line. */
> -#define FEC_QUIRK_WAKEUP_FROM_INT2	(1 << 22)
> +/* With i.MX8MQ and compatible SoCs, the order of the IRQs in the
> + * device tree is not optimal. The driver expects the first three IRQs
> + * to match their corresponding queue, while the last (fourth) IRQ is
> + * used for the PPS:
> + *
> + * - 1st IRQ: "int0": queue0 + other IRQs
> + * - 2nd IRQ: "int1": queue1
> + * - 3rd IRQ: "int2": queue2
> + * - 4th IRQ: "pps": pps
> + *
> + * However, the i.MX8MQ and compatible SoCs do not use the
> + * "interrupt-names" property and specify the IRQs in the wrong order:
> + *
> + * - 1st IRQ: queue1
> + * - 2nd IRQ: queue2
> + * - 3rd IRQ: queue0 + other IRQs
> + * - 4th IRQ: pps
> + *
> + * If the following quirk is active, put the IRQs back in the correct
> + * order, this is done in fec_probe().
> + */
> +#define FEC_QUIRK_DT_IRQ2_IS_MAIN_IRQ	BIT(22)
>
>  /* i.MX6Q adds pm_qos support */
>  #define FEC_QUIRK_HAS_PMQOS			BIT(23)
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index d948ed9810027d5fabe521dc3af2cf505dacd13e..f124ffe3619d82dc089f8494d33d2398e6f631fb 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -157,7 +157,7 @@ static const struct fec_devinfo fec_imx8mq_info = {
>  		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
>  		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
>  		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
> -		  FEC_QUIRK_HAS_EEE | FEC_QUIRK_WAKEUP_FROM_INT2 |
> +		  FEC_QUIRK_HAS_EEE | FEC_QUIRK_DT_IRQ2_IS_MAIN_IRQ |
>  		  FEC_QUIRK_HAS_MDIO_C45,
>  };
>
> @@ -4260,10 +4260,7 @@ static void fec_enet_get_wakeup_irq(struct platform_device *pdev)
>  	struct net_device *ndev = platform_get_drvdata(pdev);
>  	struct fec_enet_private *fep = netdev_priv(ndev);
>
> -	if (fep->quirks & FEC_QUIRK_WAKEUP_FROM_INT2)
> -		fep->wake_irq = fep->irq[2];
> -	else
> -		fep->wake_irq = fep->irq[0];
> +	fep->wake_irq = fep->irq[0];
>  }
>
>  static int fec_enet_init_stop_mode(struct fec_enet_private *fep,
> @@ -4495,10 +4492,17 @@ fec_probe(struct platform_device *pdev)
>  		goto failed_init;
>
>  	for (i = 0; i < irq_cnt; i++) {
> -		snprintf(irq_name, sizeof(irq_name), "int%d", i);
> +		int irq_num;
> +
> +		if (fep->quirks & FEC_QUIRK_DT_IRQ2_IS_MAIN_IRQ)
> +			irq_num = (i + irq_cnt - 1) % irq_cnt;
> +		else
> +			irq_num = i;
> +
> +		snprintf(irq_name, sizeof(irq_name), "int%d", irq_num);
>  		irq = platform_get_irq_byname_optional(pdev, irq_name);
>  		if (irq < 0)
> -			irq = platform_get_irq(pdev, i);
> +			irq = platform_get_irq(pdev, irq_num);
>  		if (irq < 0) {
>  			ret = irq;
>  			goto failed_irq;
>
> --
> 2.45.2
>
>

