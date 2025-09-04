Return-Path: <netdev+bounces-220135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD04FB448B6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899784808EB
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA92C1589;
	Thu,  4 Sep 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V5dhZP7X"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE0288C2A;
	Thu,  4 Sep 2025 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022025; cv=fail; b=r9bsRWIW2rjSdHdF3e42M0eFx+iUS9jql6lgdGADfbnGzc2N8vHxiYX8tUxzhlTedBBqv2rAdKK4Qlj2WzjkMJzVqcMU2Qc1EWEY5SMcweC2zVOWdFGs9R040XLwR5Z3QC5tIT5WzBdPqMBcSCVbDdy0k6I090TO6CZbPjVE8JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022025; c=relaxed/simple;
	bh=Oo4AnOI3g1FRDEGaAFZ88/EShvVGBOP1mdKNRDDLRXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ncYCG93VDCT/NE/q12uWJW1C2kBvMaBqf/V4Q1Vid9tBbx135CTUu2rivZ2Mf4GzYx4kCPnMWRR8WOErMOxNE0swbl0Jga2YQmskgS4AJjNxolAdLPQdTFd60K7AljCCoZztfovgBdL/Zci63mi+GeANOZfEs60zHnId1m/hSgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V5dhZP7X; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jxk32F9lyRjuZ790bCeGeReNQUpHZKMz6l8YgZm2OutbGQbabno2gi4p3Qbn9nZ2riPRAI6hvKplxrmWwceMv3tBysWHOXt0Hlr7e1Qo751OA0GtjXdkJrwd4J3yFniGm4u3EUsRe8N0UrxhkkxOHt0n1pVh0NqTQ0vrIVe/5pzodMBR4XUxjuL1qzct69TlHyIFzAgxJNRa+21P85b0dLwhqdpWhMn5JZMf5DFUJuKA4e+3WZ9zJd0Mrq7vDVxC34XaXX+V4rF6l5ze9uAnyhJNL4yb2S7yv3ibZElH/GmJ/7uAIXRZ/t+pnutRyfzyXNhm04XQd2t+UWmPJV6+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r58zkAsDjqCCmeL1WkPzT0j3lNy9ApwiiFZU+YHTjDc=;
 b=oblUPxA7AOTLSXze4HoTEpld3dy0K5YDICx/DIZipw9/JOsKHF41tPPw7TWwyOa4140mYL/kN/kPAv1UDwJFHAsOnSHugwSB2Gt1FfgSwk/rcwDQPzAh/EyY2XIL53r8Vqho059YjoCAq2+Y/CxmwjutSIFaCHSUWLXikSgCQKk1TMYZlzmOCW2LRJDx1Og3Bgp3B+r8ypXvpFpj3/JgRCJYbxVG/0oCu8MvbUwhI3OTCcwDU9shV/JxyaHY2nKwQ27yNe8ynRnyWG5vfU0U66RqJ4SLhnSOxqc99ZzdmUqMW7R7LxuPL3DQzLF6r0dDPKdmnfeLMeg7fPCLSVuJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r58zkAsDjqCCmeL1WkPzT0j3lNy9ApwiiFZU+YHTjDc=;
 b=V5dhZP7XCGaUdr0vVz9SsSSdqoQsBMLIUQWdGUP8w/guZ3zuESxfy9wjOL0Sv9qLW/kT+/zptRSdN5vlt3ac2IWcsu6d7HiVrBIZe+2RktcwDULAs3YV/t1BJ4lkfsAA4Vh1iGWuT47+m1X5dEnJ6rm3tXY3J8OWj7jRr2N5UJ2lxuqBfFKRBTJz8EkFeWY2eH6U2qBtyVvYctKMEHBFdNTY9IdvzSWcZSC6L8aVFeq/0quMOnFsdI8DqMikc+J3kGonJ0b6fKxyiuyKqRlrpJzJU+qspFgbz92ZJIbpZ6joNsWPpVDVVLTJ+riQCXOsyCV2MyTe9YqiSNSURNMNBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 21:40:18 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 21:40:18 +0000
Date: Thu, 4 Sep 2025 17:40:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH v5 net-next 5/5] net: fec: enable the Jumbo frame support
 for i.MX8QM
Message-ID: <aLoHOfNTCtVEFj6q@lizhi-Precision-Tower-5810>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
 <20250904203502.403058-6-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904203502.403058-6-shenwei.wang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: b83995dd-647b-4206-ec6d-08ddebfba47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HECk6t4mTrzAukq4O09GT04c53Bn+ZI7JpZl6FUxwZsbbU9CGuBbN2Z9RbzJ?=
 =?us-ascii?Q?ZM6Ww2dO8Tc5EFWGU56aoravQMxrXhE0lb4M3l/SiL7/0N8h3nSdswimx7kJ?=
 =?us-ascii?Q?9y2ybnUkYrOZeffeVFANrhn6U0ojiVkBAKfYoZwKUzspwbOzqKcaZ0pgo1vB?=
 =?us-ascii?Q?LCoevde1JVeMN+z7OeDL3oenEuifbz2aWINLnJ3WEgtJRi8rxEeZZpUnBuq9?=
 =?us-ascii?Q?n/uEegFszDvPjzMdaw+Ryogj4ZRYXmLyj2NFzK0jd6My/ZPhcYay7oL+Fx+R?=
 =?us-ascii?Q?swu6PBMnO4Bvd9FmqOThUJeyFI4R5MA6PLM+Z57AnI31n5D4g7gRJTnF3F6o?=
 =?us-ascii?Q?qw5WLeY65z+U11fkGUEbJhhio7oefh4zSW1LFTfGg3lQgbj7v1/rsO6KHGRp?=
 =?us-ascii?Q?HmAmX8ShkAzHv1Pn1ckVifrIU8DGKUTeksnFkNQVaQZXD6LLQUb9kHl56ag2?=
 =?us-ascii?Q?ov/INfk0mrMmW9j3PtKv0oc+gkIHt1vC3qfq8y90KZJIeiJ5E9dNHXCieNXh?=
 =?us-ascii?Q?YZ3as96xLBs1Iofec9SN0pcnA/dcp+i0fT7a6R7z8TR3PWJcImD9+lOokoKt?=
 =?us-ascii?Q?8TC49RnN7mMGHlnTTT99WsAfL8gCKbjBR6j+svBt48mP74/3qONJjKJkaJFq?=
 =?us-ascii?Q?MQxIUefxZhWweZiFbOfqbbDBQo6r16xL7ePZ4+vLbJ79mV//lzz7LnDKN32r?=
 =?us-ascii?Q?Txhp3hmEx6Q9kqyLJpyIrL5HHYDg1xS7s5OXb6cWWqsbY63fDptsY8LAtAmP?=
 =?us-ascii?Q?tGTBCx9HFinwOLvAxc632gN0j+uc4OQubeBw4xaRfm+l1JcpEl8TKE5N9NHI?=
 =?us-ascii?Q?oTdGhNVpuO/U9/gyLxpYMqEtamPiQQaYyL+WXvawu40lRWPsqBxvCoSaNoNP?=
 =?us-ascii?Q?3df6qqZ9Xvwxzh4dwaYl2Y3OdAc+aTX+fm4hHUDQ7bihlx3NvNX4OfC3idPB?=
 =?us-ascii?Q?86xwCMi7mo/gMJrmi3p0wUuKC2GO9bWnWwA4OBRrVDMO5/xvxux3XCzOEz80?=
 =?us-ascii?Q?QPcN+PErZKhzwE0LaPFzhRn/nIecED4nKrzsZKfcf71NfHmtSJouLhWw4fpP?=
 =?us-ascii?Q?37YgcH0d68kQ0tL5DiI9DDp42z0jObP7xOm9nc8ztdocOFcCeMbEy9saNrKV?=
 =?us-ascii?Q?Yji1FIuqlDFBgm401Tg1COQ+TZvaMt8NHCOJV1gh1dWCU+Jj1IVMY1ilp8+L?=
 =?us-ascii?Q?4E0CkvRFnfO6s1bNrfujIbSJWsfIrhgcFRkv+eF5Cyzjo4T0m9T69zr8si/t?=
 =?us-ascii?Q?BUHqETBcnKr3VLtbvXtSRpPXHVyTQ421htENEDYnYvuoSYffn23RDJuQzawL?=
 =?us-ascii?Q?0SaJAxcXPhPLNmKrFgK3iBsHq2144BYwWR/xCfYaR6c/nxFG26/sd+n5RNng?=
 =?us-ascii?Q?d71EmGyJphUAk7Qu9+cE5UD/pjp5YUiqBwRAorN/YBrKCSzw0sGQ1IUboYbq?=
 =?us-ascii?Q?8EVYXvtKRS35pJjf8+yhNbWqwchQc1mYCNYMH2k8oSZVNXpXU7ANqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ly81+uG9SYeyict3BhTbt59UWXJ/BdNWarVKLYPuYE8BwznIbnK880KSo8gV?=
 =?us-ascii?Q?sc9bgnkFySvtEjvr/zh/JjG/ghBfIk79RvXk9tuRfmpy3VqDaUeyIbkKwYrX?=
 =?us-ascii?Q?vlGuLUg9OE0z1cNdbJLlGT/03MIuM2W8Ggh+cQAGjv+4AlIA7S8orlCdQlar?=
 =?us-ascii?Q?wkMWZw45hVdlbrBJulP1Xc27RVg18AqOFUqEWHnF8fj5sbBaBSxBiLwkAvyl?=
 =?us-ascii?Q?8Wf+hvSYnHeYbysreQSDW/KQF5buWzly2sjcOwtZTUTfhiHiex8lwWxuz4Ju?=
 =?us-ascii?Q?XPXwzjYfYx5JfH8i6xLBgYq0hkLjCTT35a6JZNtFf4y2q0MYSrzUBF+TSg8j?=
 =?us-ascii?Q?GAlrXORirt6487oOfgriojlDU4oM8vxuWpnEWryQcQSAPvgE1CSTD5Rg+lo5?=
 =?us-ascii?Q?Pvl/mFPasvoIWYVzIo6OkCt9bZF8Cmo404T4m1hI8691DooAo2SdLz5Ywg7E?=
 =?us-ascii?Q?v4ls8nKtXIT5j8W7TyU1DTxIa1sCSFAE0O2YRTWYux7iqIeVIvjNE36IiRC8?=
 =?us-ascii?Q?jPiARauDD1g6rl6pxrz7MkyJfCn+X7zb+tyY470EBHEm/4pSwytFXWt/na8E?=
 =?us-ascii?Q?trfch+t1IC+7FxSl7ltXRLmKw+IwEYxfjHyh8U7FmYmfOPoH9KR2LrOHwTdm?=
 =?us-ascii?Q?Z61EA8ZDH88Hiwr4RwlhLkwqAHWJyN07e99WEsa8zZLtfpp83hygaz0CTMG6?=
 =?us-ascii?Q?cl/OqyTR2B1UEyvSEFdoJdtXz2cUES1cLbgat0vpm6z3C8b/SeaUGThRQ8IK?=
 =?us-ascii?Q?+s23jXjzR4iti4rnQWsNe4SVzkfITX4jpoD1fUUCLmqGeJQo9ZV8ueC5FdlN?=
 =?us-ascii?Q?PGQa+NSQpzNv72WWUwpeZsIVj2q/wx1e3KCX05r9aIXS0+iaGK+IPlUftOe/?=
 =?us-ascii?Q?49Px5uuBXciiIRa2lUOSQ1MOn/yoxgaDQfmCIOLsTW5ByXtE1uVekV+8F3w5?=
 =?us-ascii?Q?fRrqhKDZlyzo2lf9ZDxBBZ6Kkej9Xm8ieydmS7b9zRY/mnhe9p/IDLDaRKa0?=
 =?us-ascii?Q?/hkzckUAZTZJdSyVEB1AYykxkl7ZNDeBHb10rgnpDwXx4hK1AiSr1UGRCQEO?=
 =?us-ascii?Q?M9RsFDFMMbQ1k5Aic9IxH00dDjOdF6zB3lkrwMyB5QQahiAacroPDaIQEW5H?=
 =?us-ascii?Q?DcdpBVHRxbo1bSLuwmdTXkiPNVRGvBlWV7wt1gRSVLU+dRV1R85CY0Lj7FeZ?=
 =?us-ascii?Q?cvQdAbYpVMQAfY5VlrWTbCPTqHL/d/LyqIWwl8kBGZbE0PHiJJlP7EdrhaFs?=
 =?us-ascii?Q?S1qKCtNKKIsd0LLexPocZU8Etc90oGandt1iZjjUuYMLQgGO4anaBE2bqXHh?=
 =?us-ascii?Q?MxxjKwnXkMPb5jR7LSHjCUU+rV7Y0lluN2p9Zosc3vSx0ljAffiu/DwVL153?=
 =?us-ascii?Q?1um0TjIZcBLlp0uX3AkfQ7CSsTLGmWDyEjjmlzR0q462Q1ERvuUksgAOBeRP?=
 =?us-ascii?Q?E0T/nEk/ZsZ//f7jIsZSRdkU3k6ovA7JFiSR/C7QEvhbYWnpHuZgIbGu+ymW?=
 =?us-ascii?Q?Q3vBd3cG+XHgqB538pYXvixyioc+Psol0dPz32tpD9oVKWw+0t5k6Cmb056B?=
 =?us-ascii?Q?84TrAlofhQtm/dQB41kknsJTNz+bwvb6sW6KE36Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83995dd-647b-4206-ec6d-08ddebfba47d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 21:40:18.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gplkAc0XcpWjlNtAdy57CatIDVjAI+QHzSGy5WZIcRwGq3FeJ4NAm1HZQ4SOuP21T7HnlzXfvswbvdDZRJygQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049

On Thu, Sep 04, 2025 at 03:35:02PM -0500, Shenwei Wang wrote:
> Certain i.MX SoCs, such as i.MX8QM and i.MX8QXP, feature enhanced
> FEC hardware that supports Ethernet Jumbo frames with packet sizes
> up to 16K bytes.
>
> When Jumbo frames are supported, the TX FIFO may not be large enough
> to hold an entire frame. To handle this, the FIFO is configured to
> operate in cut-through mode when the frame size exceeds
> (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), which allows transmission
> to begin once the FIFO reaches a certain threshold.
>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      |  3 +++
>  drivers/net/ethernet/freescale/fec_main.c | 25 +++++++++++++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
...
>
>  	if (fep->bufdesc_ex)
> @@ -4614,7 +4626,12 @@ fec_probe(struct platform_device *pdev)
>
>  	fep->pagepool_order = 0;
>  	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
> -	fep->max_buf_size = PKT_MAXBUF_SIZE;
> +
> +	if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
> +		fep->max_buf_size = MAX_JUMBO_BUF_SIZE;

If only use once, needn't define macro.

Frank
> +	else
> +		fep->max_buf_size = PKT_MAXBUF_SIZE;
> +
>  	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
>
>  	ret = register_netdev(ndev);
> --
> 2.43.0
>

