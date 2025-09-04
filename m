Return-Path: <netdev+bounces-220126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356CB44846
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BCA17D105
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E508B29CB56;
	Thu,  4 Sep 2025 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P5XtHR+e"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E1277C98;
	Thu,  4 Sep 2025 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020421; cv=fail; b=CwnXVv5ZN8LVrNr3VrmoWXKMB2gLvyL7AJEdJDKXOJQhU4z4vUtO8Q95XCS3DDxEpM9iIWLGK6Tvu4JUDWXKMSxOxadohr4/zyF9BN4mzsv7d4Rg/pNzR5GIR/EDJORAR8Jwh2cdYcfbwt/1CxPoTSOqV1c9qeNhfoSuC9djczU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020421; c=relaxed/simple;
	bh=n8HaXUvq4dOXujnEWiQnDd3xk+tw+LA3Wr853ciwzD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oDXUcbjTqM8TItHbf2OPv3Gj33BQH8c2fzv/MV2ZbiVu+ozVEhXjVFLfjtnwXRqVYs8y+0k7t49yFhWaZqqKCYSEfTELGcH7h6sqUvKHP00qV3Iy0d06tLfNzCSqRPxEEIlB7EcVs/M37Fx3FGwp0R0CzouXvAtXiVlVdBAEFXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P5XtHR+e; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCYLL7khUaD2v7+cjoRSi4bLrR3jMeb/8zZdvGP1hIm/uMEZ71we63nHnjKLS8p3tk6pvZrE+wjH7HpQaXOWdAeFoFEzrf2/oT1/zgeXxASP4+naKkYAzY2xvhf/3nn669QcGgzoCUs+aN4TtPTOCAYe8DJP/T8wfImUHfF8frGZJsctPRG1OKd7Fpai6Y5Y1y6fv4h3x6VsvNoxTtneW4wUn0p2BZgy4lpcszd+X57y/soErJxCm6mGQjaVEtnsKy4INlDxwrUeNtlamcqGpjyZGasISohPpFpQNLLBsm2wha+id9bJVZR/vXoJFxmobJV662mPCIYMhGPTC6AHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqRlE9SZq9qZEjb7arWLJ0NvIKrfiZd33cYIH0Mkx/M=;
 b=WVuDG+eOC6Q/TqnBu2S5UFTxictiRrcO2zzn8QQaJ7H8Xc3Axo/IZUbnPchEgkNu76cBXnJZDSLx8E1DYNQFbcDnOGdAFU2LfS1CBaLBTf5ppmr4DkCsTZDqZGJlifPmobhLMLco8r1dzwLfp7pmL20iPVOgOMAsEDp2A4PPTmoW6YzngnX2w1OfhRHGWF9Y6a0arIDkOweHjB2y9fflMcM5xR06PR6heo2yDb0sAK+J4NJRwqzofheMPQb3mwGFmeD64GCUMTzakBHQkOca60SaVhEFyCz+G4V2rIrI1UwgfTSl/sKC5f09WrgcouIA+HlZwvo8Pyp1zvuBWYeybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqRlE9SZq9qZEjb7arWLJ0NvIKrfiZd33cYIH0Mkx/M=;
 b=P5XtHR+evfANp0kikH+uPfWN4MYFokv8EKrBfE3VeHRic8mGRa0choezvnNd5eJgREYbR0WAgz9Qd9kSWf1+459jJdMoE45S5hueD6TI3VMmG1tiFDkUFcxqidNSsbWQpEghmbCsVsWfgNGCQBrU9YAJbgbBhKSu1GVsKL93mMSGJd7W/BZ78NUgl66wR++Cd7xSVxX/ZRt3d6Ng9E0MytQNhIuSDauRJmOeRLDnzt7aApcZ9DsmeagvzGzhx0fq9IZChfLkP2fih2iZO2PUJlchXic0S+QqurdR6WuwUfsdthaP4ZcOqK3LyDuvcmxtDeIrOAS0yWnLNUYJNT8s8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7765.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 21:13:35 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 21:13:35 +0000
Date: Thu, 4 Sep 2025 17:13:26 -0400
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
Subject: Re: [PATCH v5 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Message-ID: <aLoA9mVfYoGOfIUg@lizhi-Precision-Tower-5810>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
 <20250904203502.403058-4-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904203502.403058-4-shenwei.wang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 44227a49-debd-4d55-beb1-08ddebf7e8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vG/Jhzpvs8s5kNOiTG/aorP6muZDAH5xtMb4YHCSccfAKzP9F5h8lWGflTOE?=
 =?us-ascii?Q?gcELYc6b+ZPQVWSjz4L+pcYnytZpYzJN9ydeXACVRh+BK2jDovh1IEvzSiUP?=
 =?us-ascii?Q?exiaz5ujUdGC6YnX1rRjON2lajKu8FfROWTo0ykfwO4h9YoL/9CZT1dnGWN/?=
 =?us-ascii?Q?Xenn47JZJp84qzrS6T2B7gYacP01FXCxO4xnBBo0BErzWKyEzLpKdlrxsJuD?=
 =?us-ascii?Q?QravmVYUQgcmKymysEa+CezMuRbzwmrIvGdMA9fRrTiGalL72jg7iOZRKNFp?=
 =?us-ascii?Q?+yohrk9IjMcBCnllV4lemmIXFr6dOs6o1Z81v4Rm/W5GjbPOBFTOBgQP5/Rx?=
 =?us-ascii?Q?604gO4w3swvXyEescKkpOIxy5kHCaCFokaCPgwJTxfSONPBX5ND21pAY4sRr?=
 =?us-ascii?Q?i30ackHgn+znL1AZq4f6A3ejO04sbZugPwhp6SCWpQcoXG2dr3EWnupEZKqM?=
 =?us-ascii?Q?1aEZ49W2s4+mAC4ji11ben8NTiVqq4XT9wK/mUhdGDBzYk8mkj0VSzgKbnK5?=
 =?us-ascii?Q?tVY79u1KYefF3yJuvDVnA9DZrQXYvTUZbYpNHqplgtO98aRA1zGFwWjxC8Is?=
 =?us-ascii?Q?3vIThGrJv4xPitG2kldsZqLWubeMtwzd6+D+LpoiumZv1dnPl9BXMbB6tMCC?=
 =?us-ascii?Q?Pb/NbNRc0jR3qUCWnmRXYWe9BsdN8aPTNBaW/PUDAjiTjOENmZKey98V5oC+?=
 =?us-ascii?Q?57gGe/yKeAt0sPpGCNIsdfuqrWHzfzOHrBh/3LEih4VYWbeyoo7lEmGsYjKp?=
 =?us-ascii?Q?8S+aGISR5m+OFgrqUO3uy9mREmeN1TfpPyDbxoA9VFRSfp0S5hBe0xeoazz0?=
 =?us-ascii?Q?jJHBd/OnGo4IPoIgTkb+8sXTIIWiy8IkFpLkghqsP2aLp144IczRakV9VVUg?=
 =?us-ascii?Q?SI5WnPh6wDFdK6rETX8ds4d/LW0Py6KnyWSeTsl2eErM2AjF6Y+BP1CUdOIE?=
 =?us-ascii?Q?HiKvxKpdzxnmZYH3IvtDWiRApXQsrztSoqLDqKcpFcpwdViCpqj2RYajV4sM?=
 =?us-ascii?Q?X7UZSDc8fqt2w8rAgyVyZ/Mzk1MlNRbuRitovaDexuaD66vXNtf20NBtJqgP?=
 =?us-ascii?Q?ApOhEppylrghE8UDUH5dW/M9FF7NO6nQ7Bu0fi8+RDtgp7cHx4tcNEOrNZiH?=
 =?us-ascii?Q?jYfZQi+0INNI4ww8TOoLgLJbi8ahPZVD+Tdj9vdxc8Z8AWsn0NbtKfaxwl9f?=
 =?us-ascii?Q?a7pP5reNV1uPHCqmz+Ix23ar8zr63rvrMlOHJnEv9CA9c6lmatVFqy8rGV4Y?=
 =?us-ascii?Q?p4yqUIHdWE3d6nSEosZ4s3335kDY/Km2a4nMTdFXl0uAzEObRFBH/OTxzbFP?=
 =?us-ascii?Q?hI6iKo+KD7Gzkv0ViICROCesm0i1NWAMFhHCRx2LUwjENsPgu3jx4ToH1A62?=
 =?us-ascii?Q?XgSdPNRpe26NqjUvEj0OlN3+nLTZfYH7RuJgppPTuM5GJACNAeMElxmlSOc8?=
 =?us-ascii?Q?V5Int/AAr3+uhe8xM9BV9XncBTyDwkeC1JNp6lAlPoc1+SLizfwkVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?02fp2C90jD7fFHbTFueWT+gNL+MwLANzZ/Fy059k+LZZ+bmyMx/gV4Rn8fIH?=
 =?us-ascii?Q?kegMMEQqX0rw4jI2Rbpd+yKnupDuTa2yL1FJacemul85JPBW8RbC6kv0mG+0?=
 =?us-ascii?Q?/FO7dcI6LJmCYTQEPh9f8QGMdp3PR9G4lcqXnqwRyQRWUa2nhbZcZJoOMIf6?=
 =?us-ascii?Q?3Jo3D4O+NKzKnSlh6sYrZnJ2zqGhNLxqTzFBcbYUbQ/ghU89Nj30CogpWA27?=
 =?us-ascii?Q?tgDoKjU/M+A1FTCyKcm1A0hBYeQSvieoYM9ElOQZF8jEyMNAbdHHs1aJBd55?=
 =?us-ascii?Q?lbtKMlvAXQO+vrmuHHKbU6Pex2ZgsUZkybr8DBGqOZLGXQy4cB72jSke22lh?=
 =?us-ascii?Q?35DFYNBAviuvO4AvcX+xc/gMbKLaQWDnDw7uv4FSk5EsyCNCpIwGYDkkZm2q?=
 =?us-ascii?Q?GIqhKU/W0LVRj25/YtB4aB2Q5Mp9szwIVly/dVUDfj8XKvN10sdklX0vjbIe?=
 =?us-ascii?Q?4WHvM4AN60yYxdvnJ5yThDGz2ZQXNZAX4V7UBhGR9iFhy53pNeasHX3uSxH4?=
 =?us-ascii?Q?WX+2vUDiwbnqT0OVbRj4q+JvhDOdrlkNDwRQWxp2xLYBIgaPp+evIAEAtKij?=
 =?us-ascii?Q?jsj54YzGFwfwJi8NvY8sts2Z57e1qld3z8vKMWLfrJxEb7lSFXNYW15owx6z?=
 =?us-ascii?Q?CjOaGumUFRqqgSK6NcIi7G+f2FN7jMXYYSK/z4oc5w6aUY8nWHbzNdzfAdWX?=
 =?us-ascii?Q?nwcbfeTYDoI5k6CUSrdgx4uliNxYTED83evsoftLP4ch2cxDZ8EZqdOkfG6F?=
 =?us-ascii?Q?oNMvz8S2Cm7jzAOROHJBbfziWJtcJI4CNieESqN67SRfvt6uzdLMGEeR+rdn?=
 =?us-ascii?Q?CKCo8cD69TOyweUrJYuMSz62FcIlDw3cZHXzL9otgC5SH5hhR+40Pe1VWR1q?=
 =?us-ascii?Q?8sl4g40j/w9fW9h7tTaaAjIVWAH3EVDh21pnjChQa3nlP3ZPfrcLdBaon4fY?=
 =?us-ascii?Q?aegoZtGOfM4BGticbPgTObwHRXyVyPEAEWWghglZgG7j3UCnDiz0TAq0Qlj/?=
 =?us-ascii?Q?klqm2JCbRUUlSKt14uleElcnoPjMqbfAQ2RgqVGlYeB6Ul0GtOSz2fwrgnGp?=
 =?us-ascii?Q?yxz5m/NclH8KZZ9vKhcHfKxQ7/f/hFiUHnL7t+F5IrqZX520KtKXR+cP92GO?=
 =?us-ascii?Q?JjN05zCMQyr3tajOvbkmh9ynB7Rj1BZ3UePR+oocSBkKXT3Eq7h1dXpvitmK?=
 =?us-ascii?Q?FpL4fYEjAU1sCMJePTuskqn1vwOVHGJmkCoDhSJM6/NzyfG0K6pQGBabfNNx?=
 =?us-ascii?Q?GbxkpRe1x2h3ktOeyL/QssFSloLOYUH4SQo2mM4bY66zMF0Lbyyd/mDVrN2x?=
 =?us-ascii?Q?y99a4fUlhLLSCuUPlm5iN+t0IeXa/jrkWZaeVQcW1B9xwQBAZoPTUDF7kSrR?=
 =?us-ascii?Q?jy9aT49RutClDbWdi0GZ9VVGyChhX4GF9q4n9QLgJeJQqehLbKT+52I+4YXW?=
 =?us-ascii?Q?bUaSuf7/BBdw/lZx8pf3G++S6GyMMq4LFyF5gWtqHD4sZAybTjXvqQxuq+WJ?=
 =?us-ascii?Q?IkQv9y+vgrPjPhS4qvnVn//+YMeEPr8vP1DzSlpbcHEYHHyZjXvfyEssnJxU?=
 =?us-ascii?Q?GC0CiiAxffd2jS14oKVm/Kp/UeG8WwcIl+2s8N1P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44227a49-debd-4d55-beb1-08ddebf7e8ec
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 21:13:35.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pgfh+JgGtn5O5EIJMTdkKqH5XVl0MhTbIz2686y9/fow3rHe08n282ldZjJWJ/HgzZ+3UbZIYGVcoqhb5Rd/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7765

On Thu, Sep 04, 2025 at 03:35:00PM -0500, Shenwei Wang wrote:
> Add a new rx_frame_size member in the fec_enet_private structure to
> track the RX buffer size. On the Jumbo frame enabled system, the value
> will be recalculated whenever the MTU is updated, allowing the driver
> to allocate RX buffer efficiently.
>
> Configure the MAX_FL (Maximum Frame Length) based on the current MTU,
> by changing the OPT_FRAME_SIZE macro.
>
> Configure the TRUNC_FL (Frame Truncation Length) based on the smaller
> value between max_buf_size and the rx_frame_size to maintain consistent
> RX error behavior, regardless of whether Jumbo frames are enabled.
>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/net/ethernet/freescale/fec.h      | 1 +
>  drivers/net/ethernet/freescale/fec_main.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 47317346b2f3..f1032a11aa76 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -621,6 +621,7 @@ struct fec_enet_private {
>  	unsigned int total_rx_ring_size;
>  	unsigned int max_buf_size;
>  	unsigned int pagepool_order;
> +	unsigned int rx_frame_size;
>
>  	struct	platform_device *pdev;
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index f046d32a62fb..cf5118838f9c 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -253,7 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
>      defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
>      defined(CONFIG_ARM64)
> -#define	OPT_FRAME_SIZE	(fep->max_buf_size << 16)
> +#define	OPT_FRAME_SIZE	((fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN) << 16)
>  #else
>  #define	OPT_FRAME_SIZE	0
>  #endif
> @@ -1191,7 +1191,7 @@ fec_restart(struct net_device *ndev)
>  		else
>  			val &= ~FEC_RACC_OPTIONS;
>  		writel(val, fep->hwp + FEC_RACC);
> -		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
> +		writel(min(fep->rx_frame_size, fep->max_buf_size), fep->hwp + FEC_FTRL);
>  	}
>  #endif
>
> @@ -4560,6 +4560,7 @@ fec_probe(struct platform_device *pdev)
>  	pinctrl_pm_select_sleep_state(&pdev->dev);
>
>  	fep->pagepool_order = 0;
> +	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
>  	fep->max_buf_size = PKT_MAXBUF_SIZE;
>  	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
>
> --
> 2.43.0
>

