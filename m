Return-Path: <netdev+bounces-223909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A62B7CF2A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EA81C06F6B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A9330BB83;
	Wed, 17 Sep 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CwFt72G5"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013037.outbound.protection.outlook.com [52.101.83.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33730B53E
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098291; cv=fail; b=cONutOywQq3D3UuGXqH4i2vuMNVLlAuD9UMiS+/cwmztY1q21R+BDv0019PTRqT6DMyPcOjk9ADEVXG/qi6KzsePogt+d2o4vHUw5Fy3fP8jAsq0l4ge/ELEGOYKOOro1vLmBD7epFFq2nWJctJFwX8wg3z7Xm89s+4c5w8/yBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098291; c=relaxed/simple;
	bh=n76TfhY+dgQM5DUdUKGw46Galazrs8CBFljt19yI3+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mKDT99rNqN9puHBdLIbLA2/2Bgv8nXWtC80tr2QanappBPFK/QI0LM0cWSqVG03Vy2aZYD/dRB1TeeN9pjshKeaXxnFCiwImxhcWflfm5zuPTEsYXOSFQHEV0fAJXnHvOseXRe0auYco/nJV/Sn8/aiya8lERvf27Y361GO5oIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CwFt72G5; arc=fail smtp.client-ip=52.101.83.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVwopkFpzdllo74m9xIOdRWSWJFeWNViXVPmu1ouB2N8c3KipYSkZuQ9Gsyir0X0eKCXa9RwuwcMrNNFwrcyyspZwIZEFTuZHpsoG3n8uwO1DdcYT5xW4L5HhnoGkJjmRA4quRMbYC0nQtADas1bGUzD7SEFufWxj4maIFT01TOnVVr6uoz8HMePaTbEDlGbqm/jEkVY56S1ZEMYaoONTYeHUK/tkTapMenPTbOg8gghhHnm+Zwq34VjA97TloHPDR15dYRVqW3qZs2/99ae0MqHOjsuMUZ/tR2E86fXjhKcymZyjoEJ4u932wBed7JwzAzUUrJFKc/wxF/c31ravQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oderv0VDom+9ejQ8BDRrwLrutWykFhkJSA5WbY2YHM0=;
 b=pRxDgpsFPyLr4oGmc35GXHJCZllnu9aoShrELRshsF/k0K+4US2KOM7XEvmbZCZPw4TusgJ/pTNxDYOv4RV1R6IVGNs8D0/j9yJFssqFbf3AHlDv3/QWcBeS25rB1y3NNNc13m5b67WwI7pBiJ/as4npH2fTuEgdYeHiTLyWFPhvK8cDmUUR64N19upg6QNdnY2hNunsfs2ZKaNoE69T2Zn/1T+vv9jtmJt+17PhYf665bdkd0HNB3jYa+RKQhDXab0yrYuXL4tpTd5yWN9UlTnsiOXbTSVnQvIco6hy7IhtKemS++dcwCkvj4IFsJR5MMulQWKvrmfJDTgvkUsNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oderv0VDom+9ejQ8BDRrwLrutWykFhkJSA5WbY2YHM0=;
 b=CwFt72G5n60bxV48NTTNJkyUeUnGLNL6l6RzM3blZ2LiC+2AisHKcKIp4JPcmfniqberFrpG72FUdpp0hWNF3BkDdNOKjZ/98B1FJXyP9NFIS5WScM9xFsoTP7LbFLcH2VDrnAS7pVpbuHuk52IT3+y5M6xY9BU+WgvRq3DjdFWcQEw54ZdpuT/+P40oCU67+mPulf6HakMwC2d18e9HWyDO1TnwKEj7/omoqu/9WxH5Gw3HvQTz3xSrh8DBqDB3WdVQCZJTcKLfrEZ8qow+h2FS/HMNUYYxubnofz1MIyxAIbpZrT3BHpF46hMeYi2g4kJ4qv0ofbTULxzhAVXe2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 08:38:04 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 08:38:04 +0000
Date: Wed, 17 Sep 2025 11:38:01 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Dumazet <edumazet@google.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
	Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Wei Fang <wei.fang@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH net-next v2 2/2] ptp: rework ptp_clock_unregister() to
 disable events
Message-ID: <20250917083801.xbdfkkcotjphulfm@skbuf>
References: <aMnYIu7RbgfXrmGx@shell.armlinux.org.uk>
 <aMnYIu7RbgfXrmGx@shell.armlinux.org.uk>
 <E1uydLH-000000061DM-2gcV@rmk-PC.armlinux.org.uk>
 <E1uydLH-000000061DM-2gcV@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uydLH-000000061DM-2gcV@rmk-PC.armlinux.org.uk>
 <E1uydLH-000000061DM-2gcV@rmk-PC.armlinux.org.uk>
X-ClientProxiedBy: VE1PR03CA0001.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1b6bdf-b098-4563-b1c4-08ddf5c584da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|19092799006|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UZ6UyUraAncB+uv4TBbeCO/ngnp/UNGiPx40DxLdSnpll3xcD6N6ibSDr81M?=
 =?us-ascii?Q?btfWT5HziIeUeIrIO+xd7uAGE3iOIHwjIpkDtR9i14k9QU5jdp3qkqLYDHFL?=
 =?us-ascii?Q?cH8aY2Ya8J4+shKQfuzWW//9RS3zKzoYITVC/ldIBTG+dTNdA3I0H7vOAvHv?=
 =?us-ascii?Q?ONat6kZUmyw3Uu2dMLFctHMlnnciQKSzs42mcTXqJthjb0DDENcp1EdYvsSe?=
 =?us-ascii?Q?UHmHJJNCQGc2TxMFOw8fCxd+C+oC6FFqd2osKqU7h//5I7MUq0ReihNGYqER?=
 =?us-ascii?Q?4q4RvEvtzdLBoTFMGy7hlBMiZyK12OuN9C96DzhBpNbAVloIyV7SkRUePL/b?=
 =?us-ascii?Q?1smVlhc/86kpQYsJZfgYIYCcv1q1j0Z2NkpKdpgPL4Zbp4VWL3uJAsUsJOC0?=
 =?us-ascii?Q?w8gQ73nDa4qEDhm419ohOSOVvJVaDiO3aHNRmE03ifeLbaL3Ao5e6trBjiTz?=
 =?us-ascii?Q?vim+QpC3Vk1Vyyvp7db5QyeQdLt37Hj3gpZo8xfU9S16wus+G6t2fWpE+qT6?=
 =?us-ascii?Q?eBktcLhZFkrUTVzWexH3pRs6VWBqgpDtg79iCavMWT4xiMQ0l+ajSRo+VzkJ?=
 =?us-ascii?Q?8wB2pnlxJyiuov/WOmQ471tsAACyWDZJRPLRLRNcx6TpM00Si8hjLS/8un5o?=
 =?us-ascii?Q?3v50Y9808Ylrk5BKzSQKdgy279ViMGPoqk5YELGNw6n0OQrSUbzl+Sdu+c4R?=
 =?us-ascii?Q?yIOPsWrEWvStVAG7bVYH+eGDxQVgSh48/0M8r5DyW+LgFOOp50gdXVSmpVcI?=
 =?us-ascii?Q?OhljgdzQZ/9iXFhu6XtHLdfgGh5lOyz0RIUblXNSQYxo3cXh4uCytI91pUir?=
 =?us-ascii?Q?ecQm5y4sg3BJ94LNESd3k5uaJZ8seE9WY5+mrD78dNNmxmGSQ8zGV1h3tojv?=
 =?us-ascii?Q?TjFZLwp7Q8HnSTblC0K+ShKq2xR6QpNQDOvFfBKJJ3azml3WugLLaqLdGGT2?=
 =?us-ascii?Q?XiUEhFjfT0Jye8WWSmRMMlQyXwwzdPDEhNzFAGfvSqK+ln5XRFNmJ4z5ZJmE?=
 =?us-ascii?Q?s/wHTY4KpkPsRBqrouxUcg0TWcMESqtLcZJd8WscdbZFcYJxlDQPL/EZ3rCp?=
 =?us-ascii?Q?NjE9bm2YaivqaFyccmz372IkohEfIUW+edDUivXukuFpYbM7mL2fulhSQ4XD?=
 =?us-ascii?Q?kliYrDPEFXZCbXkjF9+iMCiZSMU6tqNSIF93oPkJx89Eo70JUByW4mpW59Bk?=
 =?us-ascii?Q?BZeeafzl6y8h3YdmOb2mhvL8xa00Z0YkaOyYwm/zHZOt9itdEIbK5tnYK4xZ?=
 =?us-ascii?Q?3/2sE+T+/f7A4Eq4u14P9gI5RDn4HSwyUkyO5DweKYTwW6UJI8ZXT7rPo6NO?=
 =?us-ascii?Q?V3gysjdBrhr8c+U6/Y/kNIL8NI8gz013QATYR/RkfxV2d2e9VgGaQxAyctRy?=
 =?us-ascii?Q?50daCKfCcGEr0iQaV7DBgJPo+fA5pJAgAfBv9pnUSjrgFBdA6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(19092799006)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M3zrgy+ze3JAqUt0BQxpqYo1RhxrDJbZilUDG0w3KNwY9bYIttGnjNXQ3GsT?=
 =?us-ascii?Q?ob902yh4vHkV10qcwXfHyE7+ci7fKGcDjuYrN0khRL9BBLdUBzf/Y4Em/AeB?=
 =?us-ascii?Q?KvF2G7D86KjCBy62dNdk75MK8duml7HRaqnT2XQPegXOKtwNNYpysX0AHIvz?=
 =?us-ascii?Q?fVga77NAVGnlO/jbEwiHKHydQMf2V1hnmbRIxw8jjU87Iwizxq8ImkyxlUp9?=
 =?us-ascii?Q?OOf47pCyp4D8QwFHRw3RD/qk1iDyZyo9bC4JUqP88hfV+OXpLvb6nD2z7NLY?=
 =?us-ascii?Q?BQXqa5yStqMri6rpHN3v1dzQ/AeYredOXXRYrZNE6bqlCRRwuFCZM+yfXJxo?=
 =?us-ascii?Q?5hLovnPLhDfSK4tibQI8VHTcYWJDxAwe29uMqgRKjYWKpMtA7OLCw+Hqmrid?=
 =?us-ascii?Q?TrNlznVM5enEXVSZhuwLkNdj0M28mED9JYFe5cjeghLwwMGWTUE6rYVqRFYl?=
 =?us-ascii?Q?EIZJGcDaR9MRfqLrDDrolLJYhv7fXRwI+CACmQbY1GjXoIWMas3vNxpwMOM0?=
 =?us-ascii?Q?AWu4mWInbjMOVrxKOzkf979cvPVzOqM8ovx2OcXP8VvUs9Nzd60t+L9kkUTy?=
 =?us-ascii?Q?vLzuoRHLTfdV0xmX6SgYj2HDdd7q8exQgHZ7sqzg1t7hzL6BcLXHKdXvZ6Oc?=
 =?us-ascii?Q?bBICfmLsmkbaHgb3JW1AOj38FFXJXxwulf4OYlv8PvYHP+z3VBHvd9crtwWb?=
 =?us-ascii?Q?66A8kKw1KS6MClGNvyGA6EiV3cMDG7l2pw2QUirw0JnPTFy4oN1JeI9s7XUk?=
 =?us-ascii?Q?YcorKBXUeXlArAsP0VLgv6Gy1M45GzVwelfmPTYV7Q7ZmBJEOVofRhYOvJBb?=
 =?us-ascii?Q?btf3RKfdXDP7HPJyOjKe7z2mXvk5XibTNOpkfv2K5ALYjToS6dmZROfuIiyr?=
 =?us-ascii?Q?Rq5Dqp5dyH6QRmkkGs6Ui8giqo7jBq4nZvulhShjd5dQVJ3vkWPZ+z4DJjz9?=
 =?us-ascii?Q?Kwsb2TOFjiVrcaHOZ/U5SOSAYirf4Zop1PaA8SLoUPp7QGqBjJdpcpcCzER4?=
 =?us-ascii?Q?W8Ke/38SUELy8SPe6Fb5UArHlzzSOOvTNJj0k/4VjIOxPYuhRBfpP2/bDnpl?=
 =?us-ascii?Q?IXMyY/TG3gZ+KKxUJRqfnTFGvB8ghONS4gN8xoICD0MCETokFcpEqrLEXCII?=
 =?us-ascii?Q?6sTLOLf7NMOO8+RM7hukwkvnEM/THesRmNP13PcAxCpi2mkZ0jZIQdnO/v+F?=
 =?us-ascii?Q?6jCo+zMuwCD2E3NUoXfhvG4Wa0fhtQ7uOxD91R6IAzgIyRFUnXbyAvGGidiT?=
 =?us-ascii?Q?Eb7CvpwON7GGq2cwFET4rRZaodw3LvRbSzKaSGwnj96ZtLibydkOrkcpTNHX?=
 =?us-ascii?Q?mFZ23Vallb9jfaPsDoS19FIkrAdHZuCaBTy5HVBlEggCQFNuhxRSJ3j1wZXm?=
 =?us-ascii?Q?hx5WXk7akzKl2BJSAHiWdexv8nACj/Pr8OsmLCsnhVbCYEmEAr4dfT1AAhAP?=
 =?us-ascii?Q?IHCb9EZ5tFFEwYO8ZQhMtJWRtnAoGDx9xCsyoVYIBCGwyZvg1emqsCPJW+Of?=
 =?us-ascii?Q?yN6B8FUii49JKwEcw++GaZCTHZiM9VgCvEav8pg8x09GPuwYSuG4LHKirhAR?=
 =?us-ascii?Q?MrW3VplP74TPX6/u+K/jpGEEdHMJbjrS6j7uJOf4quZq2WJyi5wVbyfaI3/m?=
 =?us-ascii?Q?ka750CbrUS7HVRjLtOUwO/guqB3ATACV73PQk9KJl7H7xJu9MuzcxAkEqvNi?=
 =?us-ascii?Q?LrtniQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1b6bdf-b098-4563-b1c4-08ddf5c584da
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:38:04.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jI5MHPUliYJ7VshPqgrwuRe0wsHZT+ZzKf6QkXks8jJ9hBZF2CqZtJdK1IWA/YM137FK8JUzPOrrRYgOL+llg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

On Tue, Sep 16, 2025 at 10:36:03PM +0100, Russell King (Oracle) wrote:
> The ordering of ptp_clock_unregister() is not ideal, as the chardev
> remains published while state is being torn down, which means userspace
> can race with the kernel teardown. There is also no cleanup of enabled
> pin settings nor of the internal PPS event, which means enabled events
> can still forward into the core, dereferencing a free'd pointer.
> 
> Rework the ordering of cleanup in ptp_clock_unregister() so that we
> unpublish the posix clock (and user chardev), disable any pins that
> have EXTTS events enabled, disable the PPS event, and then clean up
> the aux work and PPS source.
> 
> This avoids potential use-after-free and races in PTP clock driver
> teardown.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # ocelot, sja1105, netdevsim, vclocks

