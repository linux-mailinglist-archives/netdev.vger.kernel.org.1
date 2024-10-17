Return-Path: <netdev+bounces-136381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2E9A18B9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 04:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9D11C226EF
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 02:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EBB42ABE;
	Thu, 17 Oct 2024 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dNDdelGM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733C762EF;
	Thu, 17 Oct 2024 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133073; cv=fail; b=LNtH7G1Fz6QBPBJs9ZElkDRn6rlZvRbrWFbff8J6knpEqemfpifZzi0iM3MtkMGXS+6o6otxmyRs9Xu64CX7AI2I6mnkjFB7Hn9tDWuLzGYSAykXS62yLNy5OBwx+rEYX6RSl2LGQDK07v4Gya8Q9mT/GJWqS/83fF1rr2SbQ3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133073; c=relaxed/simple;
	bh=zyXtDby7Zu0XpNw7lOujL5Fwi3dpECndQNVjSWnI2i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RTisGBnPwGsSJv6GT6DqFppL9FqJQvGEgnlDbhx7kwT0u1wXyjEleC3Q9t2dpJ0zTK9d9o+0dVvhm7aolGXEWzYk6OG8+3FYcHofDpER9CXd9dJyV+1ltEaC4imkxXSo15wEhitQ/3GK5CmrVe+m4PSIO60+NRZTXuEcK92Czw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dNDdelGM; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHXeYbPzYlKmC1bHqMMZfGkvYzfgqQ6RuSPL4sdMhYkPuDrlQAHkoJdRXF5nB+NLIjMjbfpz4eepyK6YwrXDuI93k0XuwpoOtwtjViBmUjwwdSjX2O/qBh9YnpWFpvOanmxo9tpHWOIU5bP+fozW7EIG8iXkNkH1xAUSF1AkbZENTFYGt9TzzFmI/PhYP8Dd46dsQRJpWHxjqcVHyLkKKAsYaN3ZP4SyH7n83nOGD8ZDgPThd42tfO2wz66hAiK10939Nj5Gv9AR4B/zJteQC41E04mUxUc564GXuQzD+ZV9d0ObFJsdt29x9SLhuC2QklphUl/0v+sstxQ+4RFI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FCdRvGw8kPr5h5hesfyamZbC7Ogx7P15+pvTl9s9sQ=;
 b=s1tb2uoe6APLoQJaSoRE2OIshoUWY5MgnLbg0JuAFjS7zDjqLVCKjthf48OCJGr4aiuGWZ5Bq0yS6nMdPrE0IBNMJQQL1yRDeNYqu3ZBe0kbYMXFCjDUUL4Gxd/sVI6TJ7dEh2SsGcXciCWB/cftJEBg7vHWNDOjCmY3BaohhSSAJEvTBKmexQIcjokA65pkfz1UstjZSVyP2JM8xGgjy9Xd6AVmKqqDFFZj532cJnIElGXasIbDQFGUdAPoRY20OpoI/Ax/5yyTC5JB00aYM6/U+Cjl12eWv8A4lYjNWzdGDXYToiRAA3Q+cnnJprOy3AN7DRWhfUME9Ckf0zgiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FCdRvGw8kPr5h5hesfyamZbC7Ogx7P15+pvTl9s9sQ=;
 b=dNDdelGMVtbnTLlVpUkLYPKIpGc4C4IiOaaHXmoz7HrYMn98/x7bc9+TPtphlbDGL3n/faywFkKWTLa4RY1e0hIqzz3irgPKgbaRH2EEin2802GAwImc/EoPyk0rpPSgM50DCHE5d3y6KY2aFzJOdr8Tob6bXCetzngQy1ALKKqpO2jFXiPvrOhle7o14d5t1zStWIa1QdhGJodHq136JkYoR1rKBRfwbgc2nQK5KGnIMchTDkijJe5+pfJdb6iT64qXkSWmTKgN3PaP3YaJFD4B+f+St1Dk+LpYlg2P5gDtcVim6J3OvvI8e2dDhMP0lfZfYBzfEE2clzorKhw1EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 02:44:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 02:44:26 +0000
Date: Wed, 16 Oct 2024 22:44:18 -0400
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
Subject: Re: [PATCH net-next 10/13] net: fec: fec_enet_rx_queue(): replace
 open coded cast by skb_vlan_eth_hdr()
Message-ID: <ZxB6AuGnoXekCEtp@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-10-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-10-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cd05d2-ea2f-4aa7-5870-08dcee559d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?48ZWfYk/HHNuGOOWqeQMIlDsrIMtQ8oPE3m+XstMuiLdoItCD1e0o0kgrnLD?=
 =?us-ascii?Q?0To/Wg0BqW8cLtjIE8/9EjaNOy+AclgQUaPmofXvhXi433H4V8FU//uCHdmK?=
 =?us-ascii?Q?2IJm2xzqMlC9xTpLheCkgP8HZUNXX6vWqUHUkijMrfqbYuedsEb5E0f3yucv?=
 =?us-ascii?Q?x1m6pJazCavuVGGV5YiCVhfyEgReArXKeJqC9qJipVMLrGA03g+GsPD+Hmu8?=
 =?us-ascii?Q?Di83xgQ5iURWCfGZ6BSEF6rEy3E8BDBz9yAi6+DSl28Hxxril51TrNFqj7ah?=
 =?us-ascii?Q?g0zYUtDGUkovTx+Y9QR6IUKQ8cWaTV9WQ/sRilwc7S/jxfbz3zRUdjaGtRlW?=
 =?us-ascii?Q?TmolwSm3BlCWmBY8z0HiFYsmcNoex960jBY91buOG9IysjzJtjaDWK0qVKPK?=
 =?us-ascii?Q?gqXsgsGdHiEU06oJsxD/OEJrr+XN1ngZZ3AreTiAeo/nWxveZEolWpyjWzXX?=
 =?us-ascii?Q?QyX866bmJ5hTH3wqkyk+fpXiZgiOO5rJFy/iTGzALTgzmzTag/61mvSHtN2O?=
 =?us-ascii?Q?P50kzMFgnpXKGmQakTJGYbjVo919YPdaG39AtjrupzfqNvAUHvNlJQ8hy4hO?=
 =?us-ascii?Q?0xHe2TxRnA3onZQuwSSvwaF4qf4ciBsrrDVNJVPofN1MpVSaBrjJUboWDtBu?=
 =?us-ascii?Q?EmZt5O0bBSz4B4Yx6FYXpsr7cTv2VTlqlOkMdczQSSkjxzqSb2KdTinBG/la?=
 =?us-ascii?Q?r+0OmnaO/EoDddAYe+A+PnZIip4cfsjRRYu88wqBxvxijxi9A67H6bPOjiEz?=
 =?us-ascii?Q?HP1kydxaHy7y+g8pwCyiJPsPzA4QasknRvkZB5+JDfw/s24YukyNJOiFXXpH?=
 =?us-ascii?Q?ZH8dBrlSEYGvsdMFuehq632Zdp71LZ/I3Bq6NWG4t0tcgctTOg8Phu1ny3+W?=
 =?us-ascii?Q?OSjQANE8Id2GV+OfMSBzdlhIJwRSfNtIS/KaUdwdK7d/I7y7tFpus+93K0oq?=
 =?us-ascii?Q?p79/+wMA272/FhoM+SiXr4P8I4C6uHG3L1lipJyfU0OjQaiW8KXyOzsHSkQB?=
 =?us-ascii?Q?JEylGFUd2NoCojR3Dm8mLEG+o3LJ7QvUagvRLoGhlifhU7CGOk7ZLsVQ00Qj?=
 =?us-ascii?Q?8PqVE12rjLZqsaR7MYTnrkRP/9UJnDPDPV8MKDbDpdTEFG1kr8ZsNdpDJzye?=
 =?us-ascii?Q?263egQkP6EEPycH5viS8T72vtm9uKqXIx15E7PDZoJQBCyMfWW+NhFGtdVrP?=
 =?us-ascii?Q?nZZxvJ90xDJqKP09vFObmITBvtgl85HhJzzfOVXdzamJkrT8kKmOe5f3sjCb?=
 =?us-ascii?Q?kM8xdHhIYKTs51Mmg3nOBznCt5JYUO6IMD5GZuwb9yJHUB5txHkTjEtxXrL9?=
 =?us-ascii?Q?EAtNDBAdg7Gorwxmm3zau52ANjzfCfxqX3hE7/RY5x3PxVlR5x51hnMZR/2P?=
 =?us-ascii?Q?MIsxjKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?djTCD+BKeEhwYr9WDjQ/Cr1rqje4zJAipKoe4CW+XnplWqgJJpgNKt01wWaz?=
 =?us-ascii?Q?ldygkK+1V7+Esw7Cy94c+uPY38QkzYngeyRRLJR18My/MjzDVa5G0PlwFjsL?=
 =?us-ascii?Q?Qjj4wNk9KRLNbvkYaVOX1xkyCH3344gbsybK+gePHOs/Kg42B65HDE6fMLCa?=
 =?us-ascii?Q?oIO+33KFKvXx5SOKUaRp5BpTbnSBfBpvlh9M2FlyXX5H2Evfpu0/x/RLfIfT?=
 =?us-ascii?Q?xZ7/6Pgu1IGORvxAoUuSMDDc9BByC+CVxrfJfzxr4RevMnaO7x8aGQH52gXu?=
 =?us-ascii?Q?qkFZPBL/rI8hGyTzHi5sEegEE7WwLetx6mtB8Hov+bB6xOqNSfIGQ1fOp17Q?=
 =?us-ascii?Q?TwsJIwmdRxnaXRLpDxHw5U0tkY59ovS6zEMIIhtO+SXtyKEjBZ1gU5I7n+7F?=
 =?us-ascii?Q?TC4pGFXNpK+xEeu9vcsID6dtqb8up30vrMXB3sIIQCjPSoMrVLUotI2SLi1S?=
 =?us-ascii?Q?6/ONJSjYpFIC3xr8JNX++nkaaGJffeV3xbtXpwAWCv7BBrN43yROfES0VXoB?=
 =?us-ascii?Q?VrNyp/HqZVecAFK9yFIrRpd3DJJ6PrLU7C1NjCenC/tBfvqL47C2JixgMnqO?=
 =?us-ascii?Q?eT9UaN6/rBkGxvlwwWKmX+rSpOIzU2Fd+KMMlA3Zfz44t5UL/4Yqdp7LU84C?=
 =?us-ascii?Q?6iYysMIIxUxvqIXv8EdYoFHEtiytWvfyLMIswc3Vgnbbae02SIe4mbJf3Cdv?=
 =?us-ascii?Q?Kgb3WeD8t4fPgxVfoPIb3H5/wQvX5WRnEMGCMMPHq3AGAKvJGTkSyofP3m89?=
 =?us-ascii?Q?7uj+ZtCiuGlw6bgLy3YIuOVjT9CgoGvmq3nMKWyMyEMoy4kiv++350fQ5Dbz?=
 =?us-ascii?Q?p+9z3rjWw1eVp7AEM8DeWixqDy5St4r6KQW7KqsvQcoA8t9Cp6TGqkbv/Dt6?=
 =?us-ascii?Q?feS/s7LiqPbHPMgN0Y6FCct1iO3JXDHR2ve6+a+G3WEGKKeFcylFfdGN2DGm?=
 =?us-ascii?Q?YM3A4HJtrcssdxAr3fR2A4cF15pKj92gEXshr+jAdPaI5IeZLrByDE9OQ7Ys?=
 =?us-ascii?Q?S7PvXg5w2tZA2UWYqDun7B4WTRd7QhCZ1BcA/jHsrt1ANrTZ5jNa9G5mKHMR?=
 =?us-ascii?Q?BIgSD+K5+1SCLMupiqODeQ9cwU2K4Z6KY4lR8+ebl/amkcRh+AE/Z4Q/snGL?=
 =?us-ascii?Q?PKJpINXEXq+cgnOHAZpy+tj7La/awMDFgSYGgWlBzXTw9396eIwaBcSWKgx6?=
 =?us-ascii?Q?kgcDP+foCIuxDqeO0tRTIWNW2qeNUacwHuEk5kb2uIijxvaAWpK9R8+hWOCk?=
 =?us-ascii?Q?69ijTx3ruSdiGCc7Wz9V9a7thrQF3P2cOBiHp7CtWgaHs+sMMbBA46GKmjbG?=
 =?us-ascii?Q?HS0MPOvdvSA56Nego94No7O4HQ6643PqwFdMb+iMDUeotvDYSq84MCQ0vI4Q?=
 =?us-ascii?Q?k50lgXAU5J5jSL9RF04GO59VH+H6RLG/IcpGHT+pxjaVm4uCqiTykPniUfx6?=
 =?us-ascii?Q?ZvyGuajKBojVt1ztmyxBZQ0OP7kjB4gpzFSc609RxhDy03kkopPUEOb6ABMf?=
 =?us-ascii?Q?qzR5A9k8WoPiXOOPgcp4HCns3uPlw3ga1DGpzPfj6qmtQbhaOiwjta4pLMGG?=
 =?us-ascii?Q?gS3U2RwZKe0vSVsP5iM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cd05d2-ea2f-4aa7-5870-08dcee559d85
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:44:26.3334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LADaGxqjwIWYEi2+Vx/t43RFykA0mAuuIXaZwc8nJuVE0j0u279hV3SkVRh2f0trBeKeAt7mVjPDb0yhuKym9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

On Wed, Oct 16, 2024 at 11:51:58PM +0200, Marc Kleine-Budde wrote:
> In order to clean up the VLAN handling, replace an open coded cast
> from skb->data to the vlan header with skb_vlan_eth_hdr().

Replace manual VLAN header calculation with skb_vlan_eth_hdr()

Use the provided helper function skb_vlan_eth_hdr() to replace manual VLAN
header calculation for better readability and maintainability.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index eb26e869c026225194f4df66db145494408bfe8a..fd7a78ec5fa8ac0f7d141779938a4690594dbef1 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1819,8 +1819,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		    fep->bufdesc_ex &&
>  		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
>  			/* Push and remove the vlan tag */
> -			struct vlan_hdr *vlan_header =
> -					(struct vlan_hdr *) (data + ETH_HLEN);
> +			struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
>  			vlan_tag = ntohs(vlan_header->h_vlan_TCI);
>
>  			vlan_packet_rcvd = true;
>
> --
> 2.45.2
>
>

