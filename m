Return-Path: <netdev+bounces-136364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BDC9A1820
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FFD1C23F3D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBEA2231C;
	Thu, 17 Oct 2024 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BbyfwDK1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9503BBDE;
	Thu, 17 Oct 2024 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129987; cv=fail; b=UwB7BIUgBnBaqi5HoCmivVnNtNakkic3QW0LukOIcI4GqVbMxIag9Rgt/yaVUPhzu5oFBCSVFYy+4Q70XhzJgWGBwuzSCHPfzg+vTq/aX7iTwLZvO2qEwFXVsyVtHfkafUWj3N044XgPbEIDNFvkWmpdh8DAZVwIPntOusMbPzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129987; c=relaxed/simple;
	bh=fNDKTs4twm2glPQT0fuHogADdWB/5YQoQ63hRBrMyYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CfzA5MKiqQnxvbSM0NWvu7KEbaNflDHXIbM6wUsvkpH0TpnG4l9l1kEaUL/BwFryNtmuNsEpffnxmTZ8DjZXSkRqdvhjfcqJ9fi1r0C/Q+sTCz0wHdGddHz/uP7cR4whh0cj9QZJ5fdpMIyxEufzuFzYikAzKXOHLPAXv77txxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BbyfwDK1; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMkl6DV/+6O8YXlEthnI+Xg1CjO0+0lbiBjJjGxV7X+WD9P244/s5ffYjxN97iwlQFQsJxlHC+vjdX0dRkUca4NSPhTWuU2D9puAqXghIm2dCa9H1dUtBGDCKGI7JSlR5u8wZRSYhkNT/3xv6a4RpvjtjWcz/z5OjkLA5NGyUVpQSYpq6KJzh1iP04Ur5pIEQIfoAGO0nZx7mwjI7xQwrmqgTRVV8UxPdpB2cYgYOrqwBbctCDCYnGCwRs6BbQDB1blBrrm79sX5prfuOQDxCAwgqLFVHofalQhd8TTvzbO+MRMlEXEWOrq4TuXD8bki2Uo9PcAQZ2lqS5FA6pR+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJ5GKNs8iTNl5gBEiQWmWgEv4q57LNtMD8XoYRgUsKo=;
 b=fCk17h0LlgIpvHGUKEzi+zvnvWAhdkzZZCiC7uZeAHbvaJ2a0EMPSLsyAZTLZUvorMkmZuiANiApHYQw8aguL6F9pxx1h2bztP/Cs+9aIBxgWJSVsKVI+ZMdpp7/8iwfP9FFV27oGBR55jSi4+dxvAK1JfsZdjAdtx/hN6G7kZIisdZF3za1pOI+evsC9UAlc582oT5FAxAB6SX4ldBulW2XjtsGwm3vMM0bNlgzIdBsHtXXGGOEjg/BGqBQ6FC1CW3fUTv1yJvVBWb2E4twgLCqMfmucaPGjh/4Rk2kC99Pow6C3AJJ0RVli5nXupPToBDvI5nU04MQCjakuS3zMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ5GKNs8iTNl5gBEiQWmWgEv4q57LNtMD8XoYRgUsKo=;
 b=BbyfwDK168AlvCBHTN+kk5hhglMVKpF5DTG1rawyuAEA0ZKEvHKYNT9BLVBNsCIWChNlDNEZoqAeY625mHHlDISHICtDKtAQb5Y+OcA8VjAxtTANOLq6R+wEcwNpDJnyk5OlYFW/EUY69dX8EK35mapOeORT6+FdAnrdR6bZoTUA+P82OJMqo8FPgJMu5Y9LhHAykMS+S7cRWIjUhgAh+WXNH/5UHgxy1u74mMtyyjAbMVogdlnXMTZ7iTK9rnVU18DhK9xidGk226i9WsKtyPPpdLMTRlyCfmIoeo3Nu2TOudUIwV9HAgkih0baL7TrXM2I/u1UQZpi0yoqb5JyUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 01:53:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 01:53:00 +0000
Date: Wed, 16 Oct 2024 21:52:52 -0400
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
Subject: Re: [PATCH net-next 01/13] net: fec: fix typos found by codespell
Message-ID: <ZxBt9HsdVPyX/LWq@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-1-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-1-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 0afad64a-712a-43c5-d9fa-08dcee4e6e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s1DAU15cJOgAz34xxA6hKRQkjJz8c+Sc5aEOj9lFaYfr+6aNBLt99f09H6PB?=
 =?us-ascii?Q?kk6nBMo28CmN9Sx8sW9OioM8NXLMGr66Yu8+G9ayd/yAQX2VO6P3GhDh2hp8?=
 =?us-ascii?Q?pkrvArPf9lUwHh6Gpdikye1SUHyN0ZQfyKjqIrafu/KSxtlFx3UPEj1xaTt7?=
 =?us-ascii?Q?hlrSiIgHLoFni9e+yrR+fQYMG7aG2/KV5g6ZJ6OJJbHcHcurmteRwrMIttcT?=
 =?us-ascii?Q?7gW3r5bB6r8yRxkUgYp87CUJy3/4QH9ekA6gtb3AcaLcx6wxY9sNgrwOs1dE?=
 =?us-ascii?Q?j9G+YHSGgurljAYr+WQbF76C1CnU/OJVrKi3DHaBsVllN4QIJiqgLegKQ+xs?=
 =?us-ascii?Q?x/kBJbCCR/l2j7Ph40giZlYi/XAryAfmUENg+xFaMPY/5+oY1lO9ZGMBL90c?=
 =?us-ascii?Q?xAPIKs9bXzj985JS9+wTkL5Bxgy/fwgRIdH5oWjlglLTaxYDyTtpaG8tASq/?=
 =?us-ascii?Q?Kl5l+krMFJ/463JbSWhq6QFPN5uUwQX3DAmBc07m8U+6n3a3q9yZbL4jwCN5?=
 =?us-ascii?Q?DioqmD6QGUReEPLhkt7UXinkUnsrAkOAYvXBgplaQ8hNsVZtxenqFP6UcSDt?=
 =?us-ascii?Q?zdvohTi1Q8IdJpW9BZtBhSvCQwNu31/WVw0ZI1XtUwwVIwY6iVp9rAegFSLM?=
 =?us-ascii?Q?Vt/jKtUWrOt/1pIuqd1DvZQfpAyT2TgpWWWsgew+SckJ+/bIjIpdT5jFXhQT?=
 =?us-ascii?Q?fxWQlsub07drCsJKfDuLsCYQv/gHcf7w/8HDWyQMa6REXmE2UM6bR5YRb2Sj?=
 =?us-ascii?Q?14DEFjWgMOOO5WDJhY/v1TT2/YLFh2s3dzm75QEtJwd2MSh6r7F2/iLlT5xL?=
 =?us-ascii?Q?abJ2cII4zSKS2xZMfK1GxAlQgh4i8ClWMr16Hn+d4vLZfixU8Odh98iR6GO1?=
 =?us-ascii?Q?9VPrYxpNnLe298chy6Ho6ziTM0VF3QEAIv2eoCEC7roGZDhPLia0u5hBRrtm?=
 =?us-ascii?Q?66jWi6YD91CHDk25ZJS+DIfirw0DvkmTMbfDw8dyXor6IuC6PuytIIkg/J+r?=
 =?us-ascii?Q?KtgS6oDjW9bdyp9EYTBgBlrrKCsVk+yin58RUt0qd4SLg5XyWEtyzH9xjn19?=
 =?us-ascii?Q?HtFggoICjxqT+Y+0EJUJr3Gn4giZDCacYT6boPUykSZVpIWTXVKH33Y41sni?=
 =?us-ascii?Q?voz4xHW/hgUTZQQhB0vxi+xUpGcK37Fz4AQiF3vtk56tvXNcXuO9/PUHWDOR?=
 =?us-ascii?Q?PjgrDIypDp2J2bWHWCCEg2WXArmHqHWUXb2qtgMfpNuLMFa5tXZ8NpZ47hfe?=
 =?us-ascii?Q?4vFLLhmKEA6P6wU1U27TGBdLq+aAmh69x9ZnTGfakgdrgLWeoAko4fsqyiit?=
 =?us-ascii?Q?hFTWZyR7jGiMRePzoEj/ydL5gaHZMDKQQSbEtz+TCYhX6Y/cz2b/33dLNTYl?=
 =?us-ascii?Q?P3EIX34=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bhYo53zo+uTFfO28UdGWLSI5FoRJC335CpWlUz4SpcNym4cMcAzafNOim+WY?=
 =?us-ascii?Q?6HUioQBw7oZ3V5QX4Qp0ppT8ufqbo6qsmpO6TSLJUHXkjMuiOw2ii0qPPU+i?=
 =?us-ascii?Q?qynT4HLzHXPLRFWXkeB1o4dsd7Sjv664tu6A1ypdilm7iMoOpcrBeEOtK1nm?=
 =?us-ascii?Q?VZZomzXvZ9gEiA8fpDOaWTR7XcEzu7wn7kx0W7zTHp2z7q4ROdp37nnI6Ht1?=
 =?us-ascii?Q?Dazp7mKrLR/8FpDTsYsfupiWzXH1PMEsOIKkij8Y5OclddLGlbxjXUfcR1cq?=
 =?us-ascii?Q?pUoApMFAEUCcVo1LeheO/rxHcFmzP+t1/bnuWABDUps0ptEivCgw/6ukGp2q?=
 =?us-ascii?Q?d1peNmHqEA2+WK565mLYkGwLJck2d6/utkrBKVVhT4Imrs17b/CTpkg74AW7?=
 =?us-ascii?Q?pSUTgAhn95rQWTB2AVf6VeNuqV8e+wl0TI3UxsDQ4CCphm4o+/EDXHYOEC17?=
 =?us-ascii?Q?t8rILAZ4ltldb+C7ZPNbdihd1onZeO5+wQej3TNHJY9Iyq2M1NUJ9y3JpzhQ?=
 =?us-ascii?Q?65Xh+i+Dr1OLc0PXm4Ts8kNCeeABdGb99Dhd05nUnDReSIBw6+vIjmu55yyv?=
 =?us-ascii?Q?HFx8+COUK+9/29CueRRf1yY7gn8lhO9L2DsKvw32PBcGPSRcdsa+OHTWn2Vq?=
 =?us-ascii?Q?0Yovv95f3NkJDJEYukK0aFK5gBFeGJ9XhtAeRvwR7T6IxgZBKfrp6Ee1cwtG?=
 =?us-ascii?Q?oeMtuI8tOte5Q3tjgt4955ulUsznW8DbH4JPA3xMheXWwYw1Qri0sT1CKZBj?=
 =?us-ascii?Q?jIQ98xo6k7q9yje9+MKxlwIs+N7JQ4k0iWyMgOBKXxgTs0mU++teY0t4or8C?=
 =?us-ascii?Q?OLfglr9fSUFfdjiPe6MIhqFKSynp2r+g4pfHoB531BF/TU44/FqlUjfruzHo?=
 =?us-ascii?Q?RqBG46AeCAMOb82MXl7Lflp9/N8WnNkdK/90Z1TVSmx1d00ApadvkXMEnx5j?=
 =?us-ascii?Q?RDP5BBGTodtOOH4ccB8oA8L6afEgfB3D1ChPPSYRFQd1KBR9Qhd3vi+e8A/l?=
 =?us-ascii?Q?zuxJu7cIG2sQQsqzfKuYE+KHJw+P3YLl7bASt2lNABodGE1GR5VX1X6KxKNR?=
 =?us-ascii?Q?yrnPaY7TdWl97o+z57Q6izol+pukSYuso21H5CiKpBc/mQ4bmRsuIh7P4Agm?=
 =?us-ascii?Q?sAtIQKrPkHdnvpdxTauQXyWKKK6AHcrurR/os0ACbZFx0MEztE7ULufWl0OO?=
 =?us-ascii?Q?Dhp84D4LzC8a1Pm/z66/LW9yLgqO0ffoko6JRzDYoYFlIS4btKnGI7fAp55V?=
 =?us-ascii?Q?Gw90WJgVpsAEcL7+HZ137KMz+3wy0le5QjyrECZ0GVyRuZWzMYgwkJuIbbPI?=
 =?us-ascii?Q?gQv1cSKPvSyrOltqZq4zBrlqDEMGwjsAQZKT4/s33EMRk2mbjGdmA4GDWM5e?=
 =?us-ascii?Q?wcIKYcJUnHeD9V9a/mhHWgm7LwBAFnyUJOa1O28WRpcBHJVRfotuW99micY+?=
 =?us-ascii?Q?c/RELbRdwaSvtp+3KZEuJcbRREnCrUXx2naJKxcodVB3UrrnLJwl3kM+bz5l?=
 =?us-ascii?Q?j5quDbv45Y6E2ln7UA+WIlE9JKAax05zPxMQZcxSYE1JrMYc2m9fg05zsAos?=
 =?us-ascii?Q?qqQx37x3eqTjehTajcY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afad64a-712a-43c5-d9fa-08dcee4e6e18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 01:53:00.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etEgVrZAr4NjIoOoCzrI1baIE8vFti/cWcQ7DOd/31+9N9yimSrhLvRxrkfHa7+Q3zShswD0nLfTnG5jJFZeDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

On Wed, Oct 16, 2024 at 11:51:49PM +0200, Marc Kleine-Budde wrote:
> codespell has found some typos in the comments, fix them.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/net/ethernet/freescale/fec.h     | 8 ++++----
>  drivers/net/ethernet/freescale/fec_ptp.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 1cca0425d49397bbdb97f2c058bd759f9e602f17..77c2a08d23542accdb85b37a6f86847d9eb56a7a 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -115,7 +115,7 @@
>  #define IEEE_T_MCOL		0x254 /* Frames tx'd with multiple collision */
>  #define IEEE_T_DEF		0x258 /* Frames tx'd after deferral delay */
>  #define IEEE_T_LCOL		0x25c /* Frames tx'd with late collision */
> -#define IEEE_T_EXCOL		0x260 /* Frames tx'd with excesv collisions */
> +#define IEEE_T_EXCOL		0x260 /* Frames tx'd with excessive collisions */
>  #define IEEE_T_MACERR		0x264 /* Frames tx'd with TX FIFO underrun */
>  #define IEEE_T_CSERR		0x268 /* Frames tx'd with carrier sense err */
>  #define IEEE_T_SQE		0x26c /* Frames tx'd with SQE err */
> @@ -342,7 +342,7 @@ struct bufdesc_ex {
>  #define FEC_TX_BD_FTYPE(X)	(((X) & 0xf) << 20)
>
>  /* The number of Tx and Rx buffers.  These are allocated from the page
> - * pool.  The code may assume these are power of two, so it it best
> + * pool.  The code may assume these are power of two, so it is best
>   * to keep them that size.
>   * We don't need to allocate pages for the transmitter.  We just use
>   * the skbuffer directly.
> @@ -460,7 +460,7 @@ struct bufdesc_ex {
>  #define FEC_QUIRK_SINGLE_MDIO		(1 << 11)
>  /* Controller supports RACC register */
>  #define FEC_QUIRK_HAS_RACC		(1 << 12)
> -/* Controller supports interrupt coalesc */
> +/* Controller supports interrupt coalesce */
>  #define FEC_QUIRK_HAS_COALESCE		(1 << 13)
>  /* Interrupt doesn't wake CPU from deep idle */
>  #define FEC_QUIRK_ERR006687		(1 << 14)
> @@ -495,7 +495,7 @@ struct bufdesc_ex {
>   */
>  #define FEC_QUIRK_HAS_EEE		(1 << 20)
>
> -/* i.MX8QM ENET IP version add new feture to generate delayed TXC/RXC
> +/* i.MX8QM ENET IP version add new feature to generate delayed TXC/RXC
>   * as an alternative option to make sure it works well with various PHYs.
>   * For the implementation of delayed clock, ENET takes synchronized 250MHz
>   * clocks to generate 2ns delay.
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index 7f6b57432071667e8553363f7c8c21198f38f530..8722f623d9e47e385439f1cee8c677e2b95b236d 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -118,7 +118,7 @@ static u64 fec_ptp_read(const struct cyclecounter *cc)
>   * @fep: the fec_enet_private structure handle
>   * @enable: enable the channel pps output
>   *
> - * This function enble the PPS ouput on the timer channel.
> + * This function enable the PPS output on the timer channel.
>   */
>  static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
>  {
> @@ -173,7 +173,7 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
>  		 * very close to the second point, which means NSEC_PER_SEC
>  		 * - ts.tv_nsec is close to be zero(For example 20ns); Since the timer
>  		 * is still running when we calculate the first compare event, it is
> -		 * possible that the remaining nanoseonds run out before the compare
> +		 * possible that the remaining nanoseconds run out before the compare
>  		 * counter is calculated and written into TCCR register. To avoid
>  		 * this possibility, we will set the compare event to be the next
>  		 * of next second. The current setting is 31-bit timer and wrap
>
> --
> 2.45.2
>
>

