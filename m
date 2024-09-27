Return-Path: <netdev+bounces-130096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E5988359
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D4C1C22692
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D327189530;
	Fri, 27 Sep 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UKx0bDH9"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AE189F30;
	Fri, 27 Sep 2024 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436611; cv=fail; b=E4XPaa49Pd0TZfelS/6at1jyWowj7Q4Kt58YrO6lZp/yGZVlOmEvLM1c4G+ZMsxOdPGMRwiVPnUnYbSS9ebSWEIMhdnom/1w6vI6vMLKk1Wne/1ZCiv8I+diASi10ZyfK1tAgmkjO4HsSaY5EbqtRDrzU+i4RO8svbKp+1CuaXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436611; c=relaxed/simple;
	bh=0uqfqcMVRP+roGO0fVRGXfth8ckUSQZbNe/isnADxOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gJaXBFEtwLjTFGZhiTosKihUOJy3oHarWBMJCqZY//EYGpKOzJ4wxYHd1bD74TYpRG78P3tyLE9NISkGYSrUcBHE7fcmT/mTonMfZjg9rau8qnG22oxeIE20LgRngPzWcoK6L3zAcbrVnMzLm3/GMEjKOIjIK3jkm4GcVnFXbiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UKx0bDH9; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLXOm2Bm24MTE/wdQt5bxg5zultkiDDjE039uqwnDq97G15ywymjv7zNDxsYF4XlYIBeYlwxlGr0CCzrb+wsDitEuoAKhmplBBoePXLOg1NYna79XXxm6fakqDvh28WIP2F8xMdn6DzZ4Rf5VkmoGreNdMD9tY4gB7uRzjHpQyW0qlGct3CoCcoFL49UHa4qn7L4XNZo6/4FjNO7D4xqcjNOAIILeOt/Sv5JQq1z6d4wiLqGqo4vK6LShq/9ldvUDE2RUmDQD2ZWJ77A380Qj8RHN24fJlfJnbLjh183Y4oL9/6aZsuvBEc+oa3c1kRx94Y1ELCFh+nFQfsyzQdU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GuFsIOIwi3A/95bo/2s/5ggi/VGV6i0ydRHp376u3U=;
 b=sSCkOQo1CdWG+lA74FlLYeLsCM0U907nVtUULha2+ATrbRQlusKwH42WUulWTDIZ1VpuWBBHK5Ou+IRk8Cer6tYRHEcP4AO05eoDeGRakwxzKzg5H8WWd9F8U9gpVlnhwbEZAsgSkTIprJ7eRZE+YUTCCnFQyniMQ2ZyWW1AAD04vFtKjN/ogz6YZ65nrmu3GAIUZsnie5Ng2zTTE7hpFzOci4SDcNcZsgTY6JGOIotvOf5LjEyt/uyMEVSFfW6s0GRUhSIlU9xkOAVksgR5zpwSM/2cs9lKB5BxPRPSTgPfdbew8BvIgPlyO/91h2sHwQJnyd90NsKI3IdHYmenRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GuFsIOIwi3A/95bo/2s/5ggi/VGV6i0ydRHp376u3U=;
 b=UKx0bDH9DaCgHvNQglryTMqoDGKCgcfFVEPLBURucs7QtHLYR3PqcM36V6VlnNQI/xUbJvYemCxOJQYJoHWSVlvk+vBnoNsnIS/wgpNn2GgIPXVBlBMMchR0rO0JlsNBu8R9iGnxqCHnYunxaK6IfZkwgN9Bm5wm5wsn21MJ4HWry05BHmV5u7T2AfPWByfEgdC5dj7iCs7/Rwwt2bIVVrUqGYC3fCY89OGKOED2k06wfiQ6ME9srH7/zaBGPsg0sCSx0UGqCfGdGHg5oT/fcPRMYd1oG3eJ31qe7wHWwjSyCPWTjEB6Gkp5UDKmvAlxTR/jpeKafxSA+DfZo3LJig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DUZPR04MB9783.eurprd04.prod.outlook.com (2603:10a6:10:4b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 11:30:02 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 11:30:02 +0000
Date: Fri, 27 Sep 2024 14:29:58 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: Dipendra Khadka <kdipendra88@gmail.com>, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Message-ID: <20240927112958.46unqo3adnxin2in@skbuf>
References: <20240926160513.7252-1-kdipendra88@gmail.com>
 <20240927110236.GK4029621@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927110236.GK4029621@kernel.org>
X-ClientProxiedBy: BE1P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DUZPR04MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: d408861a-7d5d-4b1d-f023-08dcdee7b9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43R4y7kwJ826vdREDdVCfWTks/qa+JwqnU6TIF27fs1jtDH+GMLReBFr7NJ1?=
 =?us-ascii?Q?Fktk+y8IjLjp8wLCZXKNO2TDTkcS2g+N8DixbiSLDyyAfReDvFh5ejSIBV3L?=
 =?us-ascii?Q?ZxrJ3CT5AHGn0W/NtYivcQHXVv3Dwz+6DG4DMRkBSEM3MxiUyc14q+aMLa31?=
 =?us-ascii?Q?4OhDxj8O/2HZgWr1mgbio05QQoxAPjU4YoHS6xWtJ6rn8TsCQbnsMIYWRbNW?=
 =?us-ascii?Q?YKMs8mwXpgWStqztYAIbimAy4hu6j7N1nt+Gve8ZfAkswvlG/TtKteGm66Az?=
 =?us-ascii?Q?33R3X5iLhaA/yOnMG9RtRUQpQNqcZEwc5X/9B265/IQAPtGqBPJcqXPmnYIA?=
 =?us-ascii?Q?MUE//9GRRGbHYHloQPit5niunlXkov3FUi4ouZpcWnWiDnZ+3pez1/Li15y3?=
 =?us-ascii?Q?jo/dTY7ZFoF9V6Q13JC6VXCq2+tIigavZnFCkaxiAaTAi49dI8eAbDNYnqhF?=
 =?us-ascii?Q?msAHw8W3oKtZi+DQ25pAMZCN/Cx7NeUvrdc94uAGjoZ2aZ12GUjr97WAy2K/?=
 =?us-ascii?Q?xprErnVSxMJYIbAvp5fjLVvLSNY0Z+Y+hfFu587Fru3cXHBWyH1qQNEqxJ9/?=
 =?us-ascii?Q?c3Kr7rpVd5kOa5QorQTYGqkgokA4K79JB4kXmLjPrvdoUawNaJvgUuJjfwxm?=
 =?us-ascii?Q?YZnIaMYN6M9wvZHo7LdyZBiX8qnDNwBwoW/p5rTPHMr2DQeGPOigpo0PSrCO?=
 =?us-ascii?Q?5qkhBLBDC3+pr0oMJBRVtx7Wu6y6R/17kg3Jzpll5o854Xulqb/KxbiKyfC6?=
 =?us-ascii?Q?KMrv4L0kePK0PptbrPitBwSITPDxVqTTj16jWjRRTJx+IOB63+wtczK/A6wC?=
 =?us-ascii?Q?jkiB311Zl/vRe7/ZEPM2tWAD7n1nkbQ3MmEDTVYn2NuJ8F416EDBbD0D9rNM?=
 =?us-ascii?Q?AOMS6uu3dlBN3GRdtSu+Dp0lAdFcvYPt8voxypP/wAl/6eLDiCi38Rz2/ipE?=
 =?us-ascii?Q?UtqmUtHUsotwEleKX53v40L5ju+Sy8nPydhTctow8AaMFLguVRuVn6FDeP7d?=
 =?us-ascii?Q?M+QyVUfrkluToeP789deWBrU8grjxBkmaQxaEz3e9tTtumwPFpU7GPWBy2wk?=
 =?us-ascii?Q?wzITs3i6HeMr1f8QxW90SA9eNX3HBBxzSOxh8IoiGyIXi0h6JmtxxcLHGK5v?=
 =?us-ascii?Q?8LAzCv2Im7iHODSg9lsJ3VdHgbUwCQypzhvaO0OlTXWFUtcJyjNBKJX/rG/o?=
 =?us-ascii?Q?gwbzF4nbIcTOHIBP4VHODAmmRZ1BPQooVewyCpz1RjyHzwTDY4OmbZIP1Iln?=
 =?us-ascii?Q?H2zxmCo/fHqcvsiP0yCT699Z4IKn64dcPnRN+PlO5IUHJE1Ga/XoJvtL8lfc?=
 =?us-ascii?Q?tEs4ehV9yQO2yqgyOvnBxouh+MHOOZZnLogHNvRI3msj9sBC3HPFYf2DCtfM?=
 =?us-ascii?Q?3yVdPjE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hFKhDWG8no+iXIw8vsih6v6Ihz+0mB1t+42URsNDTewZAmyhz86YUUF5Jz6m?=
 =?us-ascii?Q?qNlc8vLMgea7EEiPh5eNsrE5vuaY6fP3t9vA5NoOyCSeE/OhWO4JcPZm47Hj?=
 =?us-ascii?Q?q/7sotbizJuflqKVuRi1+jvZyy2Ov3o/OWY4Wk5THHSEEdB3p+/93czYUpJn?=
 =?us-ascii?Q?1QKUBf9nb77y2NpDhmYSzjwWlbV3uopUr8hhph8YfPYxdNlq5BF0oldeufdY?=
 =?us-ascii?Q?tbPcf5gWXbyE7oefQzpOyK+8maT9eweJ0QhQGSGyjilRG/wazTftne99L7d2?=
 =?us-ascii?Q?YCfWYxI7ckZTJ1gg/xpxxZUR73H9IpQkgP/Czv/pq+/kQi4aa3ie0UYqGk5m?=
 =?us-ascii?Q?KXkf8E25cxXZS+DuVpayVCimOswYjgowz2gcP+D0aoTQ51mID2hVDLUMsH15?=
 =?us-ascii?Q?DR3x3Xpq4VIsDV9386baKFk3MhoczcSWcs6saqB3f+4jOntkFoFyBXZo3/H9?=
 =?us-ascii?Q?2YWeZBhVo9JspkGJy6ovddVQDy6NKh0Vifth3nH7ss07SlckDnHc3mQ2e5KT?=
 =?us-ascii?Q?/VEZLEGGQz6eGZlyGoSSQVzEi294++6zUo34Clb/0kutwF4wnnWSIHxQN0yC?=
 =?us-ascii?Q?S2OBPP7SvLRDAiG4MGh/TmxLxbKD1w7TsHqlnSjbuEMrRrt3yqen2p+oU6Ny?=
 =?us-ascii?Q?GEbr8C8NJ9r2PUEBHB5xouxebzV4waCPz6UY2piDwU5oQBQgfpkoD7TTdTx0?=
 =?us-ascii?Q?e1/OOXz+3NJwnb6r2gsf5n+CUPYJ8ui58mXn5pV/v/Q/I3Zm6AfDBe5f3rb7?=
 =?us-ascii?Q?1h+rTbWA3T5a3I9bMqmXVQZxbTvckjwAZhh6S8ebg+99PJ2EQ6JesEInoiCH?=
 =?us-ascii?Q?ngn7CmnwbaeW4M4jWBkIxC7dT41+JGxLLGs1V9yoMVw+4OY7aI9+JQZiAx4G?=
 =?us-ascii?Q?AaFQqQLkw3B4IGIxRV8SimDoBc9lFNJsP8Z4tSUOJIW49ZslBQauxgDFoqNB?=
 =?us-ascii?Q?pLuAJwQJkzsY1o9uKYBPG6hYHf+/g5H5x5ONe15lzAgNj/jVxnMAqvTVZgmx?=
 =?us-ascii?Q?6mgzLKS4+YztQZV+qIOWdYDZBHWQCXtC0WwnhdRJZakNEDNUighhvV954yOB?=
 =?us-ascii?Q?/ka7UpXROOM4CX6mM+BFEHLbPGprBgZwjXN2EzYFMWNhMIgAJXfCCBG2V0ip?=
 =?us-ascii?Q?MQeWMZFoVFxplhRyvWRSxbaptTuBhML8WjQTRhDBTKDaf5QuHjV0J8EAV+iO?=
 =?us-ascii?Q?uUVi+qZmAGcRmq9mVq2eOrSBR6jfg2TaO+m5XLtXbC1JASZZJt+FYhESMPzZ?=
 =?us-ascii?Q?rvFzeTbk18XNCLT+QsVCrmGY0ECXUKohPu25hNbOMCGfr6AzbdLabAslHnmo?=
 =?us-ascii?Q?aUJjs/xBuckFVKn5smUezKac/eu0qBcyPRHb4DrYSPyr5fdt/7XmMwUF1X0W?=
 =?us-ascii?Q?mqPBTLscRXYMEHOYvFbIwUX03emdNlNrkz0Qtgyksm0eIvg2TBp5q/REz99p?=
 =?us-ascii?Q?fvminIdPTjLkU7cU8zosPRAsNnL6ndFI5p9j3VE030JFAAW7R2QxwumdfWUF?=
 =?us-ascii?Q?pA/Wvr4wcI/whPTPrvcsqUd8qrL0KQfCUxXjeRXGnUGEhnhcLDzQHaQEATRO?=
 =?us-ascii?Q?Yp66bquDaruZapCBnf70G6lBUbUchLuK5KV8o5QQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d408861a-7d5d-4b1d-f023-08dcdee7b9f4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 11:30:02.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLiHObQqhSoEpxcc1OTUcG6rxaOKsPSbxt5LUgn9rBGluH4Mva9rHsAvuMznQPBuSyvuMqU1mbybX4vpWdShBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9783

On Fri, Sep 27, 2024 at 12:02:36PM +0100, Simon Horman wrote:
> + Vladimir

Thanks for adding me, Simon.

> On Thu, Sep 26, 2024 at 04:05:12PM +0000, Dipendra Khadka wrote:
> > Add error pointer checks in bcm_sysport_map_queues() and
> > bcm_sysport_unmap_queues() after calling dsa_port_from_netdev().
> > 
> > Fixes: 1593cd40d785 ("net: systemport: use standard netdevice notifier to detect DSA presence")
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> > ---
> > v5: 
> >  -Removed extra parentheses
> > v4: https://lore.kernel.org/all/20240925152927.4579-1-kdipendra88@gmail.com/
> >  - Removed wrong and used correct Fixes: tag
> > v3: https://lore.kernel.org/all/20240924185634.2358-1-kdipendra88@gmail.com/
> >  - Updated patch subject
> >  - Updated patch description
> >  - Added Fixes: tags
> >  - Fixed typo from PRT_ERR to PTR_ERR
> >  - Error is checked just after  assignment
> > v2: https://lore.kernel.org/all/20240923053900.1310-1-kdipendra88@gmail.com/
> >  - Change the subject of the patch to net
> > v1: https://lore.kernel.org/all/20240922181739.50056-1-kdipendra88@gmail.com/
> >  drivers/net/ethernet/broadcom/bcmsysport.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> > index c9faa8540859..a7ad829f11d4 100644
> > --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> > +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> > @@ -2331,11 +2331,15 @@ static const struct net_device_ops bcm_sysport_netdev_ops = {
> >  static int bcm_sysport_map_queues(struct net_device *dev,
> >  				  struct net_device *slave_dev)
> >  {
> > -	struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
> >  	struct bcm_sysport_priv *priv = netdev_priv(dev);
> >  	struct bcm_sysport_tx_ring *ring;
> >  	unsigned int num_tx_queues;
> >  	unsigned int q, qp, port;
> > +	struct dsa_port *dp;
> > +
> > +	dp = dsa_port_from_netdev(slave_dev);
> > +	if (IS_ERR(dp))
> > +		return PTR_ERR(dp);
> >  
> >  	/* We can't be setting up queue inspection for non directly attached
> >  	 * switches
> > @@ -2386,11 +2390,15 @@ static int bcm_sysport_map_queues(struct net_device *dev,
> >  static int bcm_sysport_unmap_queues(struct net_device *dev,
> >  				    struct net_device *slave_dev)
> >  {
> > -	struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
> >  	struct bcm_sysport_priv *priv = netdev_priv(dev);
> >  	struct bcm_sysport_tx_ring *ring;
> >  	unsigned int num_tx_queues;
> >  	unsigned int q, qp, port;
> > +	struct dsa_port *dp;
> > +
> > +	dp = dsa_port_from_netdev(slave_dev);
> > +	if (IS_ERR(dp))
> > +		return PTR_ERR(dp);

I don't see an explanation anywhere as for why dsa_port_from_netdev()
could ever return a pointer-encoded error here? hmm? Did you follow the
call path and found a problem?

