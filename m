Return-Path: <netdev+bounces-220116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7BB447F5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14079A4724E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A987728DB52;
	Thu,  4 Sep 2025 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jlIN/Bw7"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40528CF7C;
	Thu,  4 Sep 2025 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019738; cv=fail; b=YGl+HeAqeUHdvGBW5QO8dSzdDKDVPkubebcsMa+aD7Spng/DyTywF/2Rqtjx7RaRYwBwZZez86I8V0X79LJjue+Gi+MCUR1ZlA57SxdrjjEv40GTwVkGZAYsdWVc5epTgoXN7NUD9NB1fSFLSAPBljgs4igtHuba6Up7dqxFoHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019738; c=relaxed/simple;
	bh=dMaKZFJeu59JktPI7qb839kNncDvaCLOY+3Ud+ZNOGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=brWzmBOvNJhrNGl0caAxJ44nXsCjsVec6SOzj1lh+Z98k4P5Dha/iZ5CQAdZbwTycLTqrhymbvALSRr7rm7tjJNjUfKpaa3I4HV9ww4wXEigDNZCgnYw3SiTKs9FiONy7VMGyYM+5o8irq97IA3J4LXFnrWOkwRvrbO2zwNzyVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jlIN/Bw7; arc=fail smtp.client-ip=52.101.83.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSLOsb9Gv+81gM76Si8zkAnM7ThT3L0v3M2K5xjKhPFFifyqzyAPmcVmi0RWMeVr27fM2TDuZpqwsodiaiqO5Ro3FMM2eMrCbfy8beZqm3oa75aXPWQDpGmWugLNfGQX6llAFLek/aQsdym/DIcOeOoKL/Lv09NRXRkFJsPQ2xi+um7ildzt9o15TQLh/d6ELRxn5WnM0sHi7M3PEfx9wb31HmBE+6sAInTdvwcj5SmibeDWP7NbnJG4xERTOp4QMh2ZwinH+LB0q7dNOidnHNATrYkYo23UoHRsfppgqs8aEfbOMTni1DJlwtIuVdfDG2jo8xZS194MdspOLXj7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nV2c0aqLi3+zkciHo0n2mwTnn35OJADIzxwlifSWzs=;
 b=QmFzmRnI5JoI6hzEo9TlH8Q4lxcrbPZvvImfceWs1P0nLosKO2sX9Y16E96QjWqR8I0iv6N9poDnGlReblde6QER7O8d+ghpLevyWiXdvGOecJowkpRCDUH7hK9M/tdKST9wpKXKam1Y5C2SzGw/gia9HaTlHiUn4pnHfTM91D/Ovpg2GJK/FJ5fSKniRa1kvlkIMKZIjMJS3J5hzo16VnF5b46dralbLFYpwTL9MS4+ace5nENbLieH0LVYnzTJj4H0zyv5fzfvl+lEXGFNac7nXp6puTi7QaEpF0ILBBt9ChcyZVFhBpUtwIWUesUIBrs6+cgkbRn2SUjIezAa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nV2c0aqLi3+zkciHo0n2mwTnn35OJADIzxwlifSWzs=;
 b=jlIN/Bw7QTJz01/FVRFT+X/uhnldrV0eQWwjTaNUz43SofNDtpEG8Wf44YjTffArlQmfGy8N0/ENrVX8eWgrrQTGo8WgxtjVsz04WXf5L+FSYAAE48Axwcl+yAE382rz0WqGmavQetJARhmfYoLMMYx+o9j3Szv/2BJc6aAl+HT46WpuRqQcSBuGxJJAC79KU+Dm8dD67PQGr630crKRiRB2B3AEMqgmhjUxTMaQF4jpNj+14Mu4ET6JRh2vziLeQ2Jg4MWYXofOVSPTPf5+2e8ygsPg9OhkUE7Y/scmceYbrh9fG8SW/JSnVgxmZqZy75Vur9mJwFgZyPYMtsy0pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10123.eurprd04.prod.outlook.com (2603:10a6:102:403::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 21:02:10 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 21:02:10 +0000
Date: Thu, 4 Sep 2025 17:02:00 -0400
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
	linux-imx@nxp.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Message-ID: <aLn+SOB21Y1sLUzm@lizhi-Precision-Tower-5810>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
 <20250904203502.403058-2-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904203502.403058-2-shenwei.wang@nxp.com>
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10123:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ead7496-d6e3-414f-9971-08ddebf65057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7qu22R2eFLCoJzniOOmkqhR43AJbYWL137Tkum5aM7sDR5Z2RnghjcKv9Tf/?=
 =?us-ascii?Q?sFTViBldwndgwYR7oOqktUx/XVCw0zyXKxoumMbi8f4MFODTzpSctHwh40zT?=
 =?us-ascii?Q?2CiT1qKHLrHv2weyh5+F9izQW+NRmn34mNbu/XsNKxHGtfU4qXu1sWUcVUPB?=
 =?us-ascii?Q?+Jn605LWjBvlg8y4H7wPcnV3btoOFGOf2BjOpyLmlHXrAp9Gp7PFD5+HMJlP?=
 =?us-ascii?Q?qymhEEwozCM8PH741Lm0uxfLYzFSC2GrArcjFfvMaNjKCyRQaOOQ4obi58Dh?=
 =?us-ascii?Q?kuEP5j/eBDES/0Y+q4KHyhHkfhB2EhmSge+tiy2WHj/AMXbw7i1u36oIMtwK?=
 =?us-ascii?Q?ckeDElfkcNXmzi9tnGAYtll8mrT/cw82URwLYBCCczK8golNOJfpV4AUh7qd?=
 =?us-ascii?Q?wSaG5R1ceFlh23L4oGRrBo8Uf++9o4msBSfx1+tWn63GI6diwCGPBA3d5A/B?=
 =?us-ascii?Q?eMQdhYiExCxXhnjZtIgXegsf0AXxlcYGpjFYEGiFLqLl0RgYC5axHZuU4ySB?=
 =?us-ascii?Q?uPLjLdEGhZ9x8m/f+1Zu9qdQN5CKyr1mdui3ilhM7ezFcwr7cgdK1M/3Ybq+?=
 =?us-ascii?Q?N14hXlmLECuhc6+FMvW/g+LcnWoxWAy4HCM6ZMOlt3Pib3CHN+xDAZxjLW2N?=
 =?us-ascii?Q?A8xCcI9g2Hn+ZL8bM/OLXTn3P1uVVBOLszIoBAvzDnCu7thHmL4YIljNJSWO?=
 =?us-ascii?Q?Ayiw7Nno2e8rIVsJwUGqGN0rthDCqHfE6MGewoU3hTilLMhaXmZrmF277cxa?=
 =?us-ascii?Q?mgeaBd2xfAW9icBtLtJSHUw9mIWLJBP+6M5DStnmmq8rCIkXMPaoffp8bmYd?=
 =?us-ascii?Q?c3iLjRotFlfwzmgCys/lL38Ji13vqR4gDsZty3ILtgHBpWAcHlCQIH8SFy+t?=
 =?us-ascii?Q?8Qlh+1JaOLTcA8TamtGyj6G9+GZwL2vTRukvjPRcx6RHJ9lveoATwqBsbkKw?=
 =?us-ascii?Q?hqh4pphoeBuQeRnYYfTjvIq5UxuVBVGt4EbnezP/ln+Cam47l2lrosvlCgl0?=
 =?us-ascii?Q?EZK8SF+BUOKQ/UZkOEpU/wadTSQrWwJvmkyLwEkiJzaPBHEbMunG/tSiCXuY?=
 =?us-ascii?Q?6VG1uV8Lj7O8+NvwUaQnjzs2yxUs9naKAsOcAYGedYtNICzy3lh+v8f8hXlL?=
 =?us-ascii?Q?hOV61wWBx28e7mwcf9uOmnya1EQD/jiXINy/B5vXYMhRCsOPImK1Beb7X7a7?=
 =?us-ascii?Q?/Ohyo2cZVj5aX+orIZomexDK7oE+z3zmmtvEVcl3QhpqJS32jtwi5os68gtW?=
 =?us-ascii?Q?RdGfdG+bIsdsh9w5QkbmIBNUFp0x8o45vRj2cineK168RsieWsgfdW6CxFzC?=
 =?us-ascii?Q?siIDB62jgK8upOwsmYh+6yMe0bzk1Njn4AEosZPZhFb19KQvMNMKf0C7jr3J?=
 =?us-ascii?Q?fCiRIXmHGaWMQ2bVTEZZMmO5en1hdyqPSNDZk8vLpesQ2FwnxcUL0vpUOklm?=
 =?us-ascii?Q?rKb8Gd14wn0UcBzlBYgwZ3CQt07PE3Ur+GPr8wGda0N0e/aZQpBNog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OEjZat3M32DeBqd48W4pAoefCcOoZw+gLhfsWuDRhhWzDKx0c8ClMKxEbtz4?=
 =?us-ascii?Q?1rM74dON3/Q8TL4iDp0QhVlI1FWh5BZNqsxbhsWJgO0bZHOleK8THOU5bVVn?=
 =?us-ascii?Q?bbgYCw/mHj+vyXk74NMv6NMtnxHXBT9YnHHR8oPljtEkjvtaqn10blHucY0L?=
 =?us-ascii?Q?EHtLEdnQ80M1d80hkQ2LsGMv6az0wgsAVM4HCiHjE2vXhkHA/Yz1BSSmvskC?=
 =?us-ascii?Q?DFfcC9+BbrKRvv2RimUZ55YQaYrgWkNzpJEICaPpOJvJ2j+weQ07+u8yXabY?=
 =?us-ascii?Q?5VuUz/4mak9AJHOjNAd9/0HRY4LnaGkh6BKRdvukQJcQhlOcXDv4wOHzDWOm?=
 =?us-ascii?Q?b3Z1E7TpsTgNdR18BHlO/jbtBOEJM8DseF29QvxpO7adU/jLMt7PwTfJgr/x?=
 =?us-ascii?Q?UWUXbJzwOa/74bd2xCdDNlO9A8XZpiCg0mkJtWlHKX8YSR69vEE0I1oJJm+g?=
 =?us-ascii?Q?iQtXQkiPVzzDl5qmpm6RnJjfuRHIa+SC398vgnJOi5Ugdd/LfJ1YFoAQMGKo?=
 =?us-ascii?Q?5CxPuPkzWzwVyNoalTlZzteFggiClS7jljiLiZmXOSFNtw3sBKfq4+Ys20Xi?=
 =?us-ascii?Q?490dNq/whBEJoiV7mYmPt6D7ee2QIi190SwTrM2RWahECkLdcGKdm+s4Hxy5?=
 =?us-ascii?Q?+u5Y5OlrXYEv+CQ0lkxixo34hm4IhY4ShPg3XZ15uJDiM85Xz1c2ckWqe9wo?=
 =?us-ascii?Q?S26tqmsRJNAUG9drrplIcldrAwD7UAfX8lM6Dybk2EmEUqrlnRiY6mvyVFRp?=
 =?us-ascii?Q?/tTLbx3AUEvzCNHFiRTkzPBWv5XljbdQwyAVakMB2MvXrVCPPZezssuoKJl5?=
 =?us-ascii?Q?5vnEBlqfc+sORmhFVX5b7xLPoiZJqM2T5O/Zeybjtvv+OoFvOQ0GHbQ3Hp+T?=
 =?us-ascii?Q?gUZJulxNb7Dx4AIAT6EsSBA13ZjUAxwXJFfyJ+am/uNYtE0WswEBfACvFFRN?=
 =?us-ascii?Q?6Dm2YWtkIeu4ZPfbe1KqlgmrpLiUi4XZpx3muhOOHWV7Jf4W3KypsufRiS+q?=
 =?us-ascii?Q?J9Q1iEgvUQBXndm7UZV00gXvbOpxP2Pcx1gO6Pft4Bn2Wkd1Lpfuq+J50B3k?=
 =?us-ascii?Q?iz2sVJGW3Qgj9X54hrysMZ0gzqzOuuajji6OVNaXBczwraUKPmCtTv3uIDvC?=
 =?us-ascii?Q?RLlqrZKRNn5UtcqKJeNBcBtsz6HaUu8IbG2S72QZhRnRCgeivD2yaZdYUnp+?=
 =?us-ascii?Q?bLgtkf2XUIPXlXWEl65E7Kj6AapaBgEcUpkkXgkwzJ4gBCiV73rzyMsGBe2z?=
 =?us-ascii?Q?N7+LC7Oz/FrW+uyPF8MbODkbyRg/Y7GsYhbmv/deVAMP/GK1uQMaM0I1kKCt?=
 =?us-ascii?Q?jhJ3wVSFJdpFXWxs8yL9siRp/57D48Zl87d0W94Ko85NzFLsJFbIDuHTBzsf?=
 =?us-ascii?Q?QGbH+9LCCUhEUZJk8BKu/a3Gy/dP1/uyh3HVKeBVDf4Hz3Ab/OeqyRiO5bot?=
 =?us-ascii?Q?h8uPvkOCqlyv7eQACznxFRpv31JysIbf9Qea5gA9oh11HwPV6qob4K1WPABD?=
 =?us-ascii?Q?7P84U+EhbFvW4FK8LnXmBkNoAmtjWo5JuU4nfygaxdmORxv7HQdaUMASjKht?=
 =?us-ascii?Q?cdmbf1yuO0tlygj70HHflNX9YuZ9RGQ206Mz8xhd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ead7496-d6e3-414f-9971-08ddebf65057
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 21:02:10.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXfEj1/JzpBFt0t6uh5zp4EAax24FX5HqP5mZkeg4fRKdaUriABGLlqqH7q1xd/l1k6UY0ixxUGU6wk3u1BRFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10123

On Thu, Sep 04, 2025 at 03:34:58PM -0500, Shenwei Wang wrote:
> Refactor code to support Jumbo frame functionality by adding a member
> variable in the fec_enet_private structure to store PKT_MAXBUF_SIZE.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/ethernet/freescale/fec.h      | 1 +
>  drivers/net/ethernet/freescale/fec_main.c | 9 +++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 5c8fdcef759b..2969088dda09 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -619,6 +619,7 @@ struct fec_enet_private {
>
>  	unsigned int total_tx_ring_size;
>  	unsigned int total_rx_ring_size;
> +	unsigned int max_buf_size;
>
>  	struct	platform_device *pdev;
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 1383918f8a3f..5a21000aca59 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -253,7 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
>      defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
>      defined(CONFIG_ARM64)
> -#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
> +#define	OPT_FRAME_SIZE	(fep->max_buf_size << 16)
>  #else
>  #define	OPT_FRAME_SIZE	0
>  #endif
> @@ -1083,7 +1083,7 @@ static void fec_enet_enable_ring(struct net_device *ndev)
>  	for (i = 0; i < fep->num_rx_queues; i++) {
>  		rxq = fep->rx_queue[i];
>  		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
> -		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_R_BUFF_SIZE(i));
> +		writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));
>
>  		/* enable DMA1/2 */
>  		if (i)
> @@ -1191,7 +1191,7 @@ fec_restart(struct net_device *ndev)
>  		else
>  			val &= ~FEC_RACC_OPTIONS;
>  		writel(val, fep->hwp + FEC_RACC);
> -		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
> +		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
>  	}
>  #endif
>
> @@ -4559,7 +4559,8 @@ fec_probe(struct platform_device *pdev)
>  	fec_enet_clk_enable(ndev, false);
>  	pinctrl_pm_select_sleep_state(&pdev->dev);
>
> -	ndev->max_mtu = PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN;
> +	fep->max_buf_size = PKT_MAXBUF_SIZE;
> +	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
>
>  	ret = register_netdev(ndev);
>  	if (ret)
> --
> 2.43.0
>

