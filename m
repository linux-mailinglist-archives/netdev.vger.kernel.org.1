Return-Path: <netdev+bounces-207586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFEAB07F3B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B5B16B38D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CBD28B3EF;
	Wed, 16 Jul 2025 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A46K2ECU"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82F4A11;
	Wed, 16 Jul 2025 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752699792; cv=fail; b=AiddittUvtcIDJg50hZChxDGXmsriwEMql3OqdSoaTonTJM4J+sjfa9+RqsKcCWWsW7wL7VIMx1FOy53ZErgIhmpB77L7h34n29yBuFSlVveEv0di1w2TUXD3p6iAJ4XlBdwGv5XyHm5gh36dPWw7ANKI18+8UD8q/pA86eLko4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752699792; c=relaxed/simple;
	bh=/vRxT07Eiix1yF1+gyr36S+vurHyDoSZhzITahYKkq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G8DBjeDVCCFlMq3dnH+lpxBLJTvrtFPVaD5wlIemYo1RyihEfDtcVoDHeY3u5Fl1SqJwaWNqFccvlV4BwcC3+SzfwM5MgjO7eTcj3+hxuCuApFBeBoTY8c3gI6cszMn+ACy6dV1YYdqXa2GUx8stH1NPmWV2QzUfP62ms6BxLzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A46K2ECU; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHVntTrEyE1FzgYehvZokm5Af5tNJwjKGHCEp1+cvyOLD+4llHZckaBbnL0VDutppT7hGyRKT1NEJs29Tl9aK6HGSmGxWk4UJOnq1YtOi/2IqpzogQZFyXTsQSrwNb3fHPFL3aje99w1J0wfLNfpB0AxKLO3W20BoFH/5ltuXEMa+RY+UGvUTaBewQgkKEYi3tnQBXmCPvJmCgKi6sam+wjtin9ZePI+3L+YgGp1p2fpQd3Pafn3wdSX3QAzn59WUy7CTs0EVG1ucbFv/gUL/OgQjtqDH1AnNIDkMfH8Zlu6nSIUu7wsvyHuKXrmvled3J+LTMiTyDz/iU6MF+9S/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxuySVkodQs3uG4kS2PYw6NeszgbxDFwJngIqkuXwoI=;
 b=o9NDOnJWAdB38lp3qauTD2vUInFQN4PpEb21sAuvBIRc9/RPvatgpMcrIREIHo9463y3ERLwkBY9h9jLI8LbYHe0Yo1j2A5kNwNawrHshQtJ1k3aSWk+nnJTt2z+eoPOTpS40oYZxJyXjzaSaSBrgs9TqdM4ClX9u4tkFAKIgLLB/7dyURtZu+AXBOSuG4VsEwxvjyMSOKPUU/1HirtYHVxrv4sW3qyZ+5EofnItdsLJI0Ih9tyHpc9/c1/NB2hqw3ycO/Rx4hPe6/aB93U/3shwYvDd5t2jMgsfmC6ETAaYz5tni0bF0DZKLANkqW7hDhzX/yLvQU+FVgmPKwNyng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxuySVkodQs3uG4kS2PYw6NeszgbxDFwJngIqkuXwoI=;
 b=A46K2ECUzqXiCllibbMCGU9WWGhlHWtn3vdJmmmvPWx1kx24qsnSARSZqjf/LRzdiuns7W1x9GKbWGQcXYJH3eJkDCMosgzWeZ0HYzMni+WXRrv8B/7xCliTD8xfLnLgYgde+5Kgdt8dL+D/3IcflNwnOj2MZjtuwezpYr1uWIlHbxf1iqMl1/Pi9IdKkFWMjPIbkdLvFfTE4mXBPlPm+Ji2zhxGBcwcOe1OgQVh34b/dV1vaDQHy82lAnSmsdhfcLC1xCUE8hTDz16AIj/TsPwtdEnHIZL7lvRxwDPCvQFRbYX7kWzNcomfDMTHvdv8psQMi1PWQcrS83AWztIvSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7040.eurprd04.prod.outlook.com (2603:10a6:800:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 21:03:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 21:03:06 +0000
Date: Wed, 16 Jul 2025 17:03:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v2 net-next 13/14] net: enetc: don't update sync packet
 checksum if checksum offload is used
Message-ID: <aHgThBhKSqlLnX0D@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-14-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-14-wei.fang@nxp.com>
X-ClientProxiedBy: AM0PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbacf3b-efc3-4648-6eb7-08ddc4ac2993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9c4kmmURXbjFRRYXHUT1fMVBpyHhWFHtxUExeVgFXGI/LxV2XM0f3szZjmiM?=
 =?us-ascii?Q?YkhLoRt6FFUP9E2TnXC/d/RdGXSZVX/AiHNmxsPnmV7zhdm0L85k9RssIt5A?=
 =?us-ascii?Q?E2HnxjjrbIf9Kw5RLYId86600M2ChKX08MR3qGr8EzRr0kEVE1CxYBqtE/gG?=
 =?us-ascii?Q?5ShdoclgcqVlw4mHlFPxSfZtCOsrU8LcDGwvZ+8WjUv8r4MLnHAJYVq1kSAR?=
 =?us-ascii?Q?v+a67k/7lqKwNAvoy3Ofd70IgQSW679VypLaH2ZPF22wf1aViYtEfF1pt34B?=
 =?us-ascii?Q?A9vun8Tn1yOyAIt8qhEICI2NKqn723XWWMajWAH9h0OI47T5/IoIAGKsTE3R?=
 =?us-ascii?Q?hqaPsT1enXW/blSKu2GOFrcV7h4qH/i5bhMDbsCTN5FOAlaojW5GNFkH78wU?=
 =?us-ascii?Q?RZdstrBjITa5cGGb8IIu+y8yU/dWF8zK2pQBEPmS4w9eUtxj5z/R721diX93?=
 =?us-ascii?Q?N0U2GLrd/QrJlkdLtVunC6W9uaNtddQ+CyHa05CSjyWvVCD2x9q4dTXbDThD?=
 =?us-ascii?Q?z+Y41k6PfVe8uw0QkmQyapbgl0ZtAXCABAVjs9Qt0UFyNeowY3vZxMfC0a+Q?=
 =?us-ascii?Q?YNxLJ3ORawZ+i8EOy2vBU+3yVqjgMuRyUU1Xm7yKgp2BEXzJ2EgIAwiZE9b8?=
 =?us-ascii?Q?qvC03ZxkFVpZoIjhjsFNWFccL+LnyXhDpS7P1pJdoRB046a7tgKepzg0/4rM?=
 =?us-ascii?Q?T0hN/v4rWq+i1a3s9OAvX5JoO2LU+zlCSxx/gkTi2KMVPH0sd6vlLSvAfGVm?=
 =?us-ascii?Q?NobyrexOH6LDHqKP4C82LRMJnsiux6upzrVdFPKA4Mk+oXX4TyQ7bilb7aco?=
 =?us-ascii?Q?TfBXn1MHpkj1PLCL0gFNArt6xjypYE4RsohnzZhNVCL/RWs52niVDtfcrSaF?=
 =?us-ascii?Q?Fc7KeSwkTJmWt+oeJtyEMBx1GCiLC4TmeKSkGnLomN7LX4+G+7DBQW35WiER?=
 =?us-ascii?Q?2a6rPZ+D7gUjT+UB9C2fkp/brO4ryYvwlSutglj0QpqvHFeTieeqRaJp76FG?=
 =?us-ascii?Q?jOzezNin5iPHhIUQKwFZ3O2wFMTKWPrAbKNcgXGveGyHLISt5MpIeNfnCd34?=
 =?us-ascii?Q?Vt8yzeJBFgMiSBhdduoaxrNnBdTZycbxNIazcDDWL7aY6/qIRQOwWqG+x3BD?=
 =?us-ascii?Q?DqOMmCfolvCgoZE0sbYVyYNMIagbVhSTwQ/nMMHcgh3ebuZeXqC99wRXJgvP?=
 =?us-ascii?Q?qmtgqHNCc/9JLQVpvkgytty9rntuA0d8en2+Vk6uub4Bj9rbsSZTBvm2V2Hd?=
 =?us-ascii?Q?AsgrfiMgC+QrZYPrWwwj/G3M4yHKiKAwDapXWsrFgnZ60vcwaRYP946GvK1q?=
 =?us-ascii?Q?hucbgCc1iWQAKnDJojCDYd051DZYK+VQNHhEx9eXbCpUFiHKJkohRXPHZdKa?=
 =?us-ascii?Q?m9Eya1W7X3LNsM2u1cR80yrDSPIE8X1DZDmwjsdMAXfY5QV203GzHt5fr84J?=
 =?us-ascii?Q?srq/13Fiyz6Y/cckyPi8KRbnnQtXXyextFlKcFD1Vxp+7w3F8jZRqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qdEyNxnRBE0t1AIO5Lwd+4ipDqk/8QNy/lmSOHJGFZcC2EsptuSe/EUJcNaW?=
 =?us-ascii?Q?Uv/WEwskwxB11xEU4Jv0210CBnjOEcZBCEHp7QEQW6IM5uWdqF7PNsDGVBiM?=
 =?us-ascii?Q?7yHmn4XRmrtV+6FiEfxIl7GUxZWI5Z9ObMcPMO3KcX+Uio9bnR0k4LXTqGx+?=
 =?us-ascii?Q?og7tmC0Jx/Bc2Qevg9Ti0LRVL62eea/Cph9mJM9ou7HLzT4chJdJqc56Nv7K?=
 =?us-ascii?Q?y+A+BSONGbApZtg7Np4yquXuQyROBvQblPT0XXpujr4LMUsU7+xjy7y//f1p?=
 =?us-ascii?Q?SV2eBJEICxlgk+TlEB8tpIwGJg0Z0oaI850+fyrLJ6C53d31ijkp5TedA0U4?=
 =?us-ascii?Q?8+MZHFgRUE0tMQZ+uAAfqYhIGp2dUtvQCVvoXeNmpnroAN9EbhadcrWnfBhq?=
 =?us-ascii?Q?xwqgS0nvYjkv1sVNabjSosa/KxK3OBSMnfrSiTRHEelp59dy/oCqeIDmwJk+?=
 =?us-ascii?Q?eTcpTu2uL9t+bqNRwGuVlDAVvG5ML58c9x/dQQjEZcNYChRkvCB3IN0itP3O?=
 =?us-ascii?Q?Nxo3Ths/rXI+pX5BmgSNCgegqf0ATYdNk4B8aTENyOdPBRLHimKiv8edfKGz?=
 =?us-ascii?Q?D2lmN/EHTOFjDWNd0aqsXTJYchvHJ19hUM5Jx4Gf7+Q+ggapBWlYNLEvHMpp?=
 =?us-ascii?Q?y0nb9W63br3w7SDBs6/qkum0s9RSlsZgIE+OF04Y8DxPrg+j69DHY903G4r6?=
 =?us-ascii?Q?UbY2h9wtC4BCN6xIzp1cnCAzJ38hi88emZgpphAZDoKKN2n8jI7x2NH7dCKg?=
 =?us-ascii?Q?440otWoe7dISCO9By4KmG3BDbPt5aU3RrN7VKV3hWyIu1RvizJnangZuCpMQ?=
 =?us-ascii?Q?Ua+W/BJ069+rTpD3ej/4+aSpyrKTewCoQo7ZdOiF4ZHFvfE4bH1qQ8tIHpEi?=
 =?us-ascii?Q?Fl2oAKCs+dZ4k1c/1yYSvWywIHODFov60SJCjXhHxUR63b6JReZnndu9wCpn?=
 =?us-ascii?Q?gpYsNXMQI9hAGgXvy6lg/NPIjS9FWiDoMp1hg5UE8zH7NiL5vyasNt+454D8?=
 =?us-ascii?Q?u5W+fHAadFMsuJbY32rzHR6p8krnjWzNAZDeweni+7dRppPVeg1L0MciEV+U?=
 =?us-ascii?Q?v43LD0wDGRKWBdXpGyM79ZBFBrbK3/MYECpnh0SDXtznZv0cFatnhYTCw1J6?=
 =?us-ascii?Q?jcKV9QESTJi+YpfAnGnqA/NWMz8EpeQe4C9SWJef+lKH80NLz6D3n2WCJXoT?=
 =?us-ascii?Q?/gw73tHkE529/jHKxxV7NcR5EWyDeFSVE5KdwDOLRaw3rJ52Ovs5bj03QqK6?=
 =?us-ascii?Q?9Ftlc68ERJLvnB9G44mH/3Y6mHGH8WITedpW5pyGAqQacrhAjI+kvEGY0y/g?=
 =?us-ascii?Q?sAbX2E/9fKyARfOj9d/pQa1ZF5MVXOosD0SlUmbPwCGAzK/H6ILyT0gl05Jx?=
 =?us-ascii?Q?nr40X4mvzqpvjMw8AdO1NlyT9gjwD7yGMyM0Tgbd9UPYte/4vZUPLcMZ/Drl?=
 =?us-ascii?Q?gaLFs1C7B9apWXfoPp9P6JaK9xMWTKC3LeuFtsd1K3TF0iM1cJKNLKT+1kdv?=
 =?us-ascii?Q?c3gX1cCRmtaHZ0csim4fmj4DUfHVayuM9B1lor8Qytr1+xCW7DjAvIwuI8Ua?=
 =?us-ascii?Q?J+TqoPS7vmym3JEVEn/nSUjhCcYJOkarYwThtZ5X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbacf3b-efc3-4648-6eb7-08ddc4ac2993
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 21:03:06.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPA5985meailMFVG9Evii9oUrYn/Ci3f6PDoWG/2eipVM/xmRsh+CdLhpkpppUhKC91OlEjaprc6FmDlB/tvlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7040

On Wed, Jul 16, 2025 at 03:31:10PM +0800, Wei Fang wrote:
> For ENETC v4, the hardware has the capability to support Tx checksum
> offload. so the enetc driver does not need to update the UDP checksum
> of PTP sync packets if Tx checksum offload is enabled.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 6e04dd825a95..cf72d50246a9 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -247,7 +247,7 @@ static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
>  }
>
>  static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> -				     struct sk_buff *skb)
> +				     struct sk_buff *skb, bool csum_offload)
>  {
>  	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
>  	u16 tstamp_off = enetc_cb->origin_tstamp_off;
> @@ -269,18 +269,17 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
>  	 * - 48 bits seconds field
>  	 * - 32 bits nanseconds field
>  	 *
> -	 * In addition, the UDP checksum needs to be updated
> -	 * by software after updating originTimestamp field,
> -	 * otherwise the hardware will calculate the wrong
> -	 * checksum when updating the correction field and
> -	 * update it to the packet.
> +	 * In addition, if csum_offload is false, the UDP checksum needs
> +	 * to be updated by software after updating originTimestamp field,
> +	 * otherwise the hardware will calculate the wrong checksum when
> +	 * updating the correction field and update it to the packet.
>  	 */
>
>  	data = skb_mac_header(skb);
>  	new_sec_h = htons((sec >> 32) & 0xffff);
>  	new_sec_l = htonl(sec & 0xffffffff);
>  	new_nsec = htonl(nsec);
> -	if (enetc_cb->udp) {
> +	if (enetc_cb->udp && !csum_offload) {
>  		struct udphdr *uh = udp_hdr(skb);
>  		__be32 old_sec_l, old_nsec;
>  		__be16 old_sec_h;
> @@ -319,6 +318,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	struct enetc_tx_swbd *tx_swbd;
>  	int len = skb_headlen(skb);
>  	union enetc_tx_bd temp_bd;
> +	bool csum_offload = false;
>  	union enetc_tx_bd *txbd;
>  	int i, count = 0;
>  	skb_frag_t *frag;
> @@ -345,6 +345,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
>  							    ENETC_TXBD_L4T_UDP);
>  			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
> +			csum_offload = true;
>  		} else if (skb_checksum_help(skb)) {
>  			return 0;
>  		}
> @@ -352,7 +353,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>
>  	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
>  		do_onestep_tstamp = true;
> -		tstamp = enetc_update_ptp_sync_msg(priv, skb);
> +		tstamp = enetc_update_ptp_sync_msg(priv, skb, csum_offload);
>  	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
>  		do_twostep_tstamp = true;
>  	}
> --
> 2.34.1
>

