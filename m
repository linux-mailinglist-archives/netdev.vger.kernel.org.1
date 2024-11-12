Return-Path: <netdev+bounces-144178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2918A9C5EC5
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0D11F234A7
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588F12076AB;
	Tue, 12 Nov 2024 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YVjWj7jS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F402003D6;
	Tue, 12 Nov 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432135; cv=fail; b=K28m68zytEQLER7pYoVJ/3W+OZq2PVCYmJFKLSKOfP/kfnLNJZ9tvSwjRnCsSWQC6URNSga+t/3cf+kJaxIw90SzJqRhvH2P8c8x5tuK75UlHxrNk60izxspHsdU2WWmYO8Rr+OsWkZEJ2EvivRJVGFZgvfAVe2q3m/+ZcBcfZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432135; c=relaxed/simple;
	bh=i7CDdVSwCvHmqPlqfdx4nwHe5cqR9GSRDuQQI162L8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PgUO7rD54TCqP/PXUuP5RMJDGxY98TyewmlVIImBslrhhLEigCxNdv8A2PvQ0cCTDy+jk7/1/RueCrnX5oK3qyVG5MV5r5NT2NQTFaOEHvia20TWJ/I18PvLIlOdywwp2AuL/z77rDEQx1wdADT6b1ql4BTi0idp7vCIKb2rKSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YVjWj7jS; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9hyWVdND5FMEhThnGT1IC9Ks+TQhfuO3tS8kJM4RMHaB0v3hFJhCXqVM0EHmAinEyEduXY+K79XFXv9Dv36/u2Jx7mScdb51eSPGbP8PJ+vAWAkEIiYUJ0pBsIQV0zs9YMMRFIXTIUzdkS8uxXChfHMzWP12qFFvrD5xhRjTRU/xfKrCJ4FcC/YvdwKyg8btjIdD5EFmMadGzzbkBNmTNdhbiuMQ9gbcFd1PWKClaLZHwhwraEibD/dfVBW/6rSji2KcpWStbLAiUZ0KL+/qGXRXE2fAslIXo0DhUbou3j+Vl7hSMIqdmxx6O8eKgT7+y8PF6rsHsLuq0qFTzBsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0aReJECim1b5NnNB8Wsu3ukDNS1ibARlCeOrNGtQJ8=;
 b=OrzgXOIiGlFsk7BQzQwVX/r2KiDUgkA7wXgTWexv6SsgfkAR7cGGiUTCt6u8rbdSubMRgwOb3zB1PMmnZY/Q4CiyyMHw3F9gnnxskOMsnDY5FdcLgeDb87tbw7ETZ6ymUfTubwf6TmK7TDP/XCKKKna8w5R5fNeVNoPHfQsZ2hcdfuk3wsrrHhhJXrDMk6uiQJh6+QPyjnL5aSlCq7KuollmQY7UPowNa5Z+rCT6Fy7bELG3Am/rCg0ySm0KC7OafUwZwvAdOlKGxXznGYkjv5Ehdh/DSTH3Fqp1/qKNeumVDbI8dfIfCoGABxm3SO1RdI37Dj47EbIgMaMB0HeY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0aReJECim1b5NnNB8Wsu3ukDNS1ibARlCeOrNGtQJ8=;
 b=YVjWj7jSWooreTeIFUGBPU0u/yn1+sxyWnID8YnMQIXZz4G5ihB65IhgkBeQyYnu62tk0bd4Vh6M+KUaCPdOokd05a6ssuCAkeHA2NvAtSQj2ErYqges9VOBPoo8BDcXz7Ea79e2E9zvFBhPfC0Zag83otG2o9ZQhL4SzM43M2fipkD4hUf8dIS/MIXBQrb4nfn1uzlJ0oA4O4ppBnm9ztJM8LWs9MM5ppbdSEgTcEu3VB/iDtRewQ8dFbEVXxLzqJabM/Ik4iTmNTQ/wZaWzwHVA3QF04R0bPQhFdnG8iVkg6a6XcqyCoRB5a1fxTElf8CtCi1apLN8h8u6ykWjEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 17:22:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:22:10 +0000
Date: Tue, 12 Nov 2024 12:22:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Message-ID: <ZzOOulVvfGiqYc7s@lizhi-Precision-Tower-5810>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
 <20241112091447.1850899-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112091447.1850899-3-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 139754dc-06ee-4dab-f844-08dd033e8a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NhOH56oU4t0IjSDTs8JVQi6F5AdYDQ2QnE6rOuQpDfj5bHBelIal231AIiiu?=
 =?us-ascii?Q?kKBCjGNmeGXARWDDenkqfyemYWWtVQ4ZqPBgPgZ+/gMOzXnL33YRFwezNx04?=
 =?us-ascii?Q?RanaYikXyb0n+tDe26mSg9ooR7wFLuSLMKkxEnjacRt2Tp/LiCKBMXv2pHtw?=
 =?us-ascii?Q?8dGg8PUG50UB7Eo0hooj2+NOKtyTPXTR9Kja6n4FJ57WrGliNqXaeYPfOR92?=
 =?us-ascii?Q?I2vdvtgI/e0rEgWk6blM01E4DOrdzxifjGJFs87Gu4q5H3R5UPYTIfHawdnG?=
 =?us-ascii?Q?HJx6XfxK3EsGKV5t+QCorZprrljgFy/0bxuChCkpCf2WZR1tK1zXwf44H7/u?=
 =?us-ascii?Q?Olt2WA/abZVbM0I04cl6jpb82zVGMJumekLRXeuPNiNL0oJpbJSMBa9XYgCP?=
 =?us-ascii?Q?DEjbg9VzMNtPbJQzqElbY7o6ZzRoeLtXhBeGrz2t5IWFgyMCCua1FMp3s4p9?=
 =?us-ascii?Q?5K0f9Q3QSvdebq5W8sxdeb5riRRkACCo9vGQmkJ7Vm1JxeDpOTdx6exBdtik?=
 =?us-ascii?Q?k80UHtAyeMkHV8ymibPdmQEshltsjwA+CWbNFqJaaUnsUfnP2+VtE9+M8sJY?=
 =?us-ascii?Q?AAmCPS/nKQZSzDKZE5FQslForBwjVlOFsYzhax5YAskkPUQmF9GomqvpowPR?=
 =?us-ascii?Q?zoW6Ga99F6DdJ2tzr6/u2RPfCTgyHCapIi1/YMK+v9oPC4W97S8wmDylEdBE?=
 =?us-ascii?Q?IcujS7d+8YLqSep+Oq/qJJ8McrwlQmUJ98kpH5dIJK/TCTQonVl3UUSRnwJ0?=
 =?us-ascii?Q?yHsE2AP9yzJV1WQuUMO27tVw3y09GobdT+qMXgfUwes4QarNxGpGel058YZf?=
 =?us-ascii?Q?gqcTCLNMcLOIbhFyqDCm8zNjS+U6iq9NpiHhQ5zZH2ZWf2BaeTdVFpCZa/6q?=
 =?us-ascii?Q?umWkeiVElVEwbwfGC7GHgzfXHXcsyfe6EYKgWeq/L+4JNVRAHcSFXPd6NVYS?=
 =?us-ascii?Q?d585qnNKvO2xL40hYIOrL4syhIuqtZ+bMKCBJkcbE+uI4cnw6koLMm3vMNpX?=
 =?us-ascii?Q?yHUPhZ+mwZeOavKZ8hwhOmCQ9v7chQIF7/idWAZ9fEHOlduMzsaYxC2FSEbe?=
 =?us-ascii?Q?7hYNrpvw1aPKFTiZglhpOAKIYZ+8wfOHbn5Q5pYZW8m14EAmWztCkIy54WrJ?=
 =?us-ascii?Q?7EwLP/WlrwW7cXd7d++Q+Mu5ckHBk4YvbBTyXCky7l2b53Empl1Q1Vz5Abw9?=
 =?us-ascii?Q?4PX4WLyvEu1PVggHdP9c3AgUSHWJxQd2/pHJx9VqMv4gn6WQbO1m8JRWcK5K?=
 =?us-ascii?Q?7g1ml2tj3kPhh0gvU5UE0VuzNwIwQ7MZTCSoL3+opovrmZ94sJplN4rf6lZZ?=
 =?us-ascii?Q?9Me/RoBlZCJIWaIdSKrqbGZnyDT8ho1JjnhZeUTBCA25M2gJ2u3PTxYDF7m+?=
 =?us-ascii?Q?sekpmRU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qr4a2sABaqKIflygux+LvGxJ6uMAYqmYLjsgX+cwKyI1B6NwMHu3GnCsr6Xa?=
 =?us-ascii?Q?67Em7jFgZQ5oaqWQadqjW4ukiZ9msCGmwxJfgJEgPLfMY8A81fg5wbDOBsbq?=
 =?us-ascii?Q?DDQcQA1YQ2AOUzujH4dkN4ILffTD/UPd6gWVD65bPOH9pipoQo5H9ANEC1HW?=
 =?us-ascii?Q?gJsLKcRa1OJgkmk42ZHu/ZlQnRKatj8fEiqzUuuvmusHn/X66/FDCcum+t1c?=
 =?us-ascii?Q?K7z1xs7hrnsGGmLaAuMaxX6i16XWo6KaHhnMu6zTFlrZr2ijuJg8KfekvG6+?=
 =?us-ascii?Q?LsousTT2KXZsralkVUR7B13Dzx6mVJ/PRbMDEqjVyCh4DHm5St5e8mO+g1V3?=
 =?us-ascii?Q?ggr5mMdnJGGgRxRdjekl1EUKdHypa+pLEK3aqCK95Me6mMXPJTgUAfI6wg9R?=
 =?us-ascii?Q?KcNRpbty34gXEV4I/tE+ePArzBdS+B7Hz/bnjjoj+0X7dVWYdkKrUfApF6Xj?=
 =?us-ascii?Q?7NtMgIZVPq5lm8iPbBo8zLtgi4LeV3nfqZNJRRCtxlBU0mmdcNbhlnu5umUX?=
 =?us-ascii?Q?/rDZjt5FBaCJ7oVW0zdBfcMnYFV3F72VdgUuzvyznKufV25oTxBlCOnYKTj0?=
 =?us-ascii?Q?fxkWYEclWL3f5xwrX5r0xn9eqmQFwIqCACrac3QsDPp2wk/vjoV86BKrjFtW?=
 =?us-ascii?Q?8MmN29i3zr/EVazCFpZa6FYxKdgi2DYExKRIYAREHfE1If3+BMngQyWX3d1H?=
 =?us-ascii?Q?cAA3sbt7A45x/1AHhEOBU3VK89mev3cOKFTHnwoQe77V0JEbUHuQYjEBPpab?=
 =?us-ascii?Q?8sGbIMQPDGkVW+FV7tuke/fN6pbsyNpXzMY5ZvwlRbOl8Q+doSXmTeCpeb+G?=
 =?us-ascii?Q?KWz2PI9S08jvHpssq4NN1NXXYIKrowuesj0ohzk9e1L6z7TsjHdPyt9IY/Ly?=
 =?us-ascii?Q?tx7g+nuArs0Cu/meq5EiMu2wXSJFXv9xbpdfCxZ6Y6kzY3I/16Mei6LMNCNG?=
 =?us-ascii?Q?Gr2i6f/ti8/HtRX0rq3BgoFCVV/XZiqalXwlQ8dGehZV9k5RIRGsOBrg/H8a?=
 =?us-ascii?Q?ntc3vQOwmKrKXnILaUl8Max5qbL/YRJs2e/LbUPOFpX8Uj6q5U+7W6+OPtlf?=
 =?us-ascii?Q?e7dDF3G9L6Lb6fnn7peLrFU+7WySxStr8Swq2sJfjjir/3XqKCkXBX25p+AB?=
 =?us-ascii?Q?Np86N+jmJh/8jYGlnFCiHAk0whAOsCaGlorKnkK7CJQWecErYorqjE0NbR9n?=
 =?us-ascii?Q?kAHVE3TkBwKlrzwnEY4DSpzvxQTzsPsTTUCDfrXv/eRihzBuKoqCqdywJrhu?=
 =?us-ascii?Q?caXx5uNPUSNSA4Z50XbAVko92qZxJekPwqAyg/jHV18xaKzZS7mw83lBlCpM?=
 =?us-ascii?Q?fw1UBMtRGL8oZkDecq2ZcOyXyn9olDLw2eifWHmOjw6LYQFBb3SEXlhnTBMI?=
 =?us-ascii?Q?F7s8rw5QPo+wrRKqworfCAWPu0fFunM2m0bBOl/hnQZOWAYgIUS1NGs5pMCE?=
 =?us-ascii?Q?okalpT+1Ajj0ve9AckCFqFe9lf+AGGvz/Jbb+lkYR4uRqnPfat1fxoHw0Dr7?=
 =?us-ascii?Q?n0xRyE0l4FPkB8+x5wPvOW3rOQ8LzYbeXnmIoiRDPhejT+9CyCQsihPYHJiZ?=
 =?us-ascii?Q?X2x0071Xy1fPeXOWpL0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139754dc-06ee-4dab-f844-08dd033e8a73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:22:10.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuX1CXhiwGYu4MldtMWtteNRRgMp35iAEeOX4hW2eMOlcfVW38eLDssrSGDCvjG9ORRduIfX6U/3JJWPc+We1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551

On Tue, Nov 12, 2024 at 05:14:44PM +0800, Wei Fang wrote:
> In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
> Tx checksum offload. The transmit checksum offload is implemented through
> the Tx BD. To support Tx checksum offload, software needs to fill some
> auxiliary information in Tx BD, such as IP version, IP header offset and
> size, whether L4 is UDP or TCP, etc.
>
> Same as Rx checksum offload, Tx checksum offload capability isn't defined
> in register, so tx_csum bit is added to struct enetc_drvdata to indicate
> whether the device supports Tx checksum offload.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v2: refine enetc_tx_csum_offload_check().
> v3:
> 1. refine enetc_tx_csum_offload_check() and enetc_skb_is_tcp() through
> skb->csum_offset instead of touching skb->data.
> 2. add enetc_skb_is_ipv6() helper function
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 51 ++++++++++++++++---
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
>  .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 +++--
>  .../freescale/enetc/enetc_pf_common.c         |  3 ++
>  4 files changed, 60 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 3137b6ee62d3..eeefd536d051 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
>  	return 0;
>  }
>
> +static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
> +{
> +	switch (skb->csum_offset) {
> +	case offsetof(struct tcphdr, check):
> +	case offsetof(struct udphdr, check):
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static inline bool enetc_skb_is_ipv6(struct sk_buff *skb)
> +{
> +	return vlan_get_protocol(skb) == htons(ETH_P_IPV6);
> +}
> +
> +static inline bool enetc_skb_is_tcp(struct sk_buff *skb)
> +{
> +	return skb->csum_offset == offsetof(struct tcphdr, check);
> +}
> +
>  static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
>  	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
> @@ -160,6 +181,27 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	dma_addr_t dma;
>  	u8 flags = 0;
>
> +	enetc_clear_tx_bd(&temp_bd);
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		/* Can not support TSD and checksum offload at the same time */
> +		if (priv->active_offloads & ENETC_F_TXCSUM &&
> +		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
> +			temp_bd.l3_start = skb_network_offset(skb);
> +			temp_bd.ipcs = enetc_skb_is_ipv6(skb) ? 0 : 1;
> +			temp_bd.l3_hdr_size = skb_network_header_len(skb) / 4;
> +			temp_bd.l3t = enetc_skb_is_ipv6(skb) ? 1 : 0;
> +			temp_bd.l4t = enetc_skb_is_tcp(skb) ? ENETC_TXBD_L4T_TCP :
> +							      ENETC_TXBD_L4T_UDP;
> +			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
> +		} else {
> +			if (skb_checksum_help(skb)) {
> +				dev_err(tx_ring->dev, "skb_checksum_help() error\n");
> +
> +				return 0;
> +			}
> +		}
> +	}
> +
>  	i = tx_ring->next_to_use;
>  	txbd = ENETC_TXBD(*tx_ring, i);
>  	prefetchw(txbd);
> @@ -170,7 +212,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>
>  	temp_bd.addr = cpu_to_le64(dma);
>  	temp_bd.buf_len = cpu_to_le16(len);
> -	temp_bd.lstatus = 0;
>
>  	tx_swbd = &tx_ring->tx_swbd[i];
>  	tx_swbd->dma = dma;
> @@ -591,7 +632,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	struct enetc_bdr *tx_ring;
> -	int count, err;
> +	int count;
>
>  	/* Queue one-step Sync packet if already locked */
>  	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> @@ -624,11 +665,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  			return NETDEV_TX_BUSY;
>  		}
>
> -		if (skb->ip_summed == CHECKSUM_PARTIAL) {
> -			err = skb_checksum_help(skb);
> -			if (err)
> -				goto drop_packet_err;
> -		}
>  		enetc_lock_mdio();
>  		count = enetc_map_tx_buffs(tx_ring, skb);
>  		enetc_unlock_mdio();
> @@ -3287,6 +3323,7 @@ static const struct enetc_drvdata enetc4_pf_data = {
>  	.sysclk_freq = ENETC_CLK_333M,
>  	.pmac_offset = ENETC4_PMAC_OFFSET,
>  	.rx_csum = 1,
> +	.tx_csum = 1,
>  	.eth_ops = &enetc4_pf_ethtool_ops,
>  };
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 5b65f79e05be..ee11ff97e9ed 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -235,6 +235,7 @@ enum enetc_errata {
>  struct enetc_drvdata {
>  	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
>  	u8 rx_csum:1;
> +	u8 tx_csum:1;
>  	u64 sysclk_freq;
>  	const struct ethtool_ops *eth_ops;
>  };
> @@ -343,6 +344,7 @@ enum enetc_active_offloads {
>  	ENETC_F_QCI			= BIT(10),
>  	ENETC_F_QBU			= BIT(11),
>  	ENETC_F_RXCSUM			= BIT(12),
> +	ENETC_F_TXCSUM			= BIT(13),
>  };
>
>  enum enetc_flags_bit {
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 4b8fd1879005..590b1412fadf 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -558,7 +558,12 @@ union enetc_tx_bd {
>  		__le16 frm_len;
>  		union {
>  			struct {
> -				u8 reserved[3];
> +				u8 l3_start:7;
> +				u8 ipcs:1;
> +				u8 l3_hdr_size:7;
> +				u8 l3t:1;
> +				u8 resv:5;
> +				u8 l4t:3;
>  				u8 flags;
>  			}; /* default layout */
>  			__le32 txstart;
> @@ -582,10 +587,10 @@ union enetc_tx_bd {
>  };
>
>  enum enetc_txbd_flags {
> -	ENETC_TXBD_FLAGS_RES0 = BIT(0), /* reserved */
> +	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
>  	ENETC_TXBD_FLAGS_TSE = BIT(1),
>  	ENETC_TXBD_FLAGS_W = BIT(2),
> -	ENETC_TXBD_FLAGS_RES3 = BIT(3), /* reserved */
> +	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
>  	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
>  	ENETC_TXBD_FLAGS_EX = BIT(6),
>  	ENETC_TXBD_FLAGS_F = BIT(7)
> @@ -594,6 +599,9 @@ enum enetc_txbd_flags {
>  #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
>  #define ENETC_TXBD_FLAGS_OFFSET 24
>
> +#define ENETC_TXBD_L4T_UDP	BIT(0)
> +#define ENETC_TXBD_L4T_TCP	BIT(1)
> +
>  static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
>  {
>  	u32 temp;
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index 91e79582a541..3a8a5b6d8c26 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -122,6 +122,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	if (si->drvdata->rx_csum)
>  		priv->active_offloads |= ENETC_F_RXCSUM;
>
> +	if (si->drvdata->tx_csum)
> +		priv->active_offloads |= ENETC_F_TXCSUM;
> +
>  	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
>  	if (!is_enetc_rev1(si)) {
>  		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
> --
> 2.34.1
>

