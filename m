Return-Path: <netdev+bounces-136374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E4E9A1871
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 04:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E079E1F278E4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 02:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83513C918;
	Thu, 17 Oct 2024 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gSaDWRFa"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BCD38F82;
	Thu, 17 Oct 2024 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130837; cv=fail; b=Nt/gJidiYM0s8b3sJuURLch+e4lAiNKHf5GUgVYMmZuI9fs5wxqX50BjAoMQbyJdG9CRkpdV4tuxv/g5N8//dppZ/h84oWCacjPgrCoS/Vc7il24YCcCn9jwDACNVS4czs5z2y3Pjm2uR98C9WTYWUP67rtVCwLdLjOC/WSuW5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130837; c=relaxed/simple;
	bh=L5ab2YWXP5/O5Zpbi7f7d+P+GoV/kA5RV67GEuyyYrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p90LhM4Y4pdv6hFjNYzxPGDl1agO0AcIlPHs9WajWUOwrmRaCY/l3WQjfpBAD9BVa9Mb2789QfLLWmjXqe7dskPUzLPkZs8OP5BYaGQ6a7Cq9ul+GE7b1a94LUUCTa4BI1ArMmlX45CXyA9duAGW98kl4pAfb/t99YoxfZlukg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gSaDWRFa; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjrTpINmuBX44CIgv/5Doa5BRzX2FQrbLhVGZPfEazMobWiRipbEz2XXI2qz+3lC2wC1Wx9L/Zz81qlsXH5yTtXPL9jBMGA2Ct8Ty/sLPgXIJVYaCjAzBvssFppqW85EJjNmqY5mOHtokeirCA8JHwC3rYZIZ0IOHM91giiPDmqPh98qMtQgVPdJ1absYec/ToIumpSeOL6uRJKB/3GoftJJa9uhF3slJRjr+miMcxzWgsY5c80Q2cYlXYM9RExKyvRD5De7Nti/k794dfGiNtsUG7I+qLoy8IumqgS082Z1SUZNaiRk7Tz+ENJTd6vEyTx/mJSYhJuGgjNYcpjrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSzyfJLBOj34AidDamdImiOiHRo9mJdqDMdRpo71QwU=;
 b=fxqvUNEz3A5DW5oq1tYgxu0YIhTrOEgiI6def23FiSVgnt9qaVYgZfXVb8PFOPwzr5YYdsgj8WWemR65zp7NTRxlT4NkyLucgZiVfeqW7WBURc1p/fcf/KzyZqmHMbzJ/cIQ5F+R09Yn7FwoD6zXoIxinrbNqMU/iNb/bWCqeZHYZkFXkCmAYv+zBEfZwDMPfQeywy2/YndBq9MyddqpjRzLQwvVi22yBlrL/1MGNPvXsAzDz1pRPPSUtzzu7vB32iBfKQGELW0FYKOCRFNT7ethaRcl+mj+zZ3T08+c1uxG3qdZ4Pvy04ImNWeBqoCDjiZaNnZgztR+ZAKincy7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSzyfJLBOj34AidDamdImiOiHRo9mJdqDMdRpo71QwU=;
 b=gSaDWRFa9LUT7VXyAK/ivppsVl48QMw16Dic1h/B11KMwhtVqCHIvZWdwc4lYOpgyEKGoGKsi6nIUSvO6lYt1nH7OmRrZH6OUtQDfjO2WVCqSec+xMX1XTX93sVTv2Tqsav0XfczIcMSl3zz88y+PY1E3M+AzUEgLyb8UfQIvh9IafO2JCYh2qvvHpHDhp9VOWDQzQ9MHI8WYa2V5sSj1FIACVXFizeoIzmc92k0kKUkIxulmrkV/D1fusurBLYXpcWasvQq3yUp8pAU4BGHjkQRVImz6P/zMkP1rs5QMw1Da9/lSq7263g8PYBmHLQJ20YdYuLyd6+pqFfKfWgwtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10873.eurprd04.prod.outlook.com (2603:10a6:150:224::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 02:07:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 02:07:12 +0000
Date: Wed, 16 Oct 2024 22:07:04 -0400
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
Subject: Re: [PATCH net-next 06/13] net: fec: fec_restart(): make use of
 FEC_ECR_RESET
Message-ID: <ZxBxSNZk2Ls7p4wL@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-6-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-6-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10873:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b8d1d4-f6f5-4a8f-5bd4-08dcee506a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EN9PehQhKVx/mza9dnX0FbRJzEs2SYhMFzMZvGsMgqlHISy+ONWJibXjRtHx?=
 =?us-ascii?Q?CFwcgE1cxqIID0obcYJ3lH7mI4SoS2MRvwsFyNbGq/ne+dsXodtPT9fiRWWI?=
 =?us-ascii?Q?P6m5GN6/cJ6sZN0uTYfIsQAIIyXDhreLRQUPalYtOKFL0Tuyfktzvo4q70RX?=
 =?us-ascii?Q?p8XAbMR0uzJye79vd9LLoaooYTaN/78EieCRi0QZiGoSCAM3yDPamsKO00Hd?=
 =?us-ascii?Q?GXbiGBpk2A4Y0fugVBN+nfG0qJnGtC+ekDyvwsAK2ZDP4JbRr3/JC6Qw9uLQ?=
 =?us-ascii?Q?r+k5gLNu11QwDpbHWQ4OhoL1NamrpbQn17Gh8q15yrYyraqn8PLHBmfH1Rln?=
 =?us-ascii?Q?vGwmX4L8Cp18gh4ZB3JUuUr2Egu2aHYrZ0IuEWPr7uvex8e+C/h/MKiL9A2I?=
 =?us-ascii?Q?6Z2KiPnwv6O5wlZGXfCHu+zDdxSExFOJg8JRibHHXabvtgASCv6thFEbw0QS?=
 =?us-ascii?Q?iH1wfLKyBsS9dkQ3rKhlWm87W2+hMbzueCuiFrES70W4+2tmIEMv38mve584?=
 =?us-ascii?Q?tLsS+mwp5mRY4Eo1EjO9r0I1qPrG4U3PbVsYQR6A3vsU9WkfiQTV7NVsCTfM?=
 =?us-ascii?Q?gQ/E7BjRiubg80ui/DvwJBBQ4KcGEwfSRhEWkBc/NxnZxDUYxXdDZ0Vtebf3?=
 =?us-ascii?Q?tf4Ji3TCX361BM0wkAkN3YS3Q/NQFDx7E7r02XNC1nGpHtHEs+Uq1CjcG6/I?=
 =?us-ascii?Q?4IIrbUBf79S13bceohaBiyVKsMrE3R0Us5uW2iQADM9EyF7kd9/oUeoewl0O?=
 =?us-ascii?Q?Lb+8oStb1CXhpzvOocecPmkhdYHkmToNqFusQkazCF1/5HU6BspoQbB2lm33?=
 =?us-ascii?Q?QT/gLpy86g4tt11Mf/EXKXklCVpti5+4hGO7bHgOenGu44He9pU/trAKyF/6?=
 =?us-ascii?Q?rsAPMzcIf1l4+uXPxjNY8K0FvCZPN6DbSBTPIKRT1LUV5/6wEO/Q2KgBNGfm?=
 =?us-ascii?Q?MC7iSjQYP3HCUzACk9IdiCC9Uvsa/5LiNp22Z6V7yIZ6SoglXqX3Cbf8/S0W?=
 =?us-ascii?Q?89siVBwq91RFCbAC0A7jwSAh65G0GI2uvgtxgXa1p8evtBbLxixkpe5AueI6?=
 =?us-ascii?Q?lbMQntWwJrXjYgVMao5t+QRT5klc0A0p4tRW6eMauGMgiJwITNcS6zYN+RR1?=
 =?us-ascii?Q?TxkV3TfkaJvGtLqDbdFBI1Nq3W4wS4oo0IveVKt6iITVgndXiTjjbV0vhDPU?=
 =?us-ascii?Q?s/EsJE3AsSgd0HOBswJZiAJQMazl8yJRo0z6lqjFMXNgu+Nd0sVBSUMMIllo?=
 =?us-ascii?Q?Mx9WyfT6DAIBt1YuUNOi4zda4rc2arfNQg4DM3hbfj41YNqLlDQoAAdUDoqb?=
 =?us-ascii?Q?eu0bIpSGdRcp9LaLm6Hq7X5VpVsyICgJsEzBinMSQ76BTrnqROD20zdSrPSe?=
 =?us-ascii?Q?Pi2dT6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?935CRNm+qh3FZn4/pVE16OX95TOn5Kf/rPnOMi4BSIuP8qpeaWsSjptAvBcv?=
 =?us-ascii?Q?KsoaNcpcwf458QJxpe9SViuSlI4j1mh42BPh3l040lRExmw76hHIsZfy2qBt?=
 =?us-ascii?Q?Yx44yoGOdM5YxbmSYg3Ed85yXllkCVHjXw4ddu7waqnVs8+S7C23BBJsPOIb?=
 =?us-ascii?Q?BCqmK1GMTF1eUroWd0W0J5XaFTnNW+jqfHLL/8b9NxmtaYDa+xV+GFxJDHhv?=
 =?us-ascii?Q?xp5LTqIGR3ypyaYk9Y/RL3wj+FMfFzErh4JH2kFJeZxZMt/q23+8g4Wwwa15?=
 =?us-ascii?Q?GmqhqNErlo7xjvijeyjKklSiThSSyAf//+ckuGTavYcKDvfsqFGomu/9SdX1?=
 =?us-ascii?Q?55u1bNQ+UnXZ3/8T1OPyn+vXRrRHDAtqsz4OXVzCfFKQPA/UP291w7FJNZNh?=
 =?us-ascii?Q?itxV0dlNH5ceIoeKLyhlBGlpTTXid4w433geOUA+Yc2XJJ1C5zQ/YK0RO+sP?=
 =?us-ascii?Q?WzMMxfkxvBxMqXebr29ukRCYhyIAbJfvROf/RvH2j5tvjDAcOy/K+YcwvQ74?=
 =?us-ascii?Q?hOrmnblFySXEZy2RwMNnDesVjfs5ZPFHXieotrTaVpmIYLjZDb1ofEEzu46a?=
 =?us-ascii?Q?Cb8UT0QlxOK3pcpjVc/rCyMRexAx4i8wml6feQBOtWvN2TRsRXpNgsvb/O06?=
 =?us-ascii?Q?Wh2INri6cnPahcC/3JVYjWWFpOlWRRVMaqfCAvUWDgzotiRi8ytY2LbNHPoW?=
 =?us-ascii?Q?tS3eLN8Hm0yBsK/2qfW5v2eKueRm5E7btyNHzFuFdMWzFc7zmMs0p4/NFlSo?=
 =?us-ascii?Q?etEKxtUp2nwE2rXiy35xtsVeAEwdWdFKT1WtEzDXt15cGrzSbUkXHpQj1EaQ?=
 =?us-ascii?Q?/SIAQd50Hw84IG1VD0uGBBCx0SARgfbBg8flM082vzCYPqkVK232GTpQl8SH?=
 =?us-ascii?Q?ZzcUZE+lh2CR9cXtJXgloiVtNaUQQU4hjUme9kA76hcJmCNdBV6Ods6RYV9A?=
 =?us-ascii?Q?YCYmT9LB7lX5vxgK3QoOuDTEqe9Kyy9wy2ROXULDQMbFW2KbI1Mc06k+E9mO?=
 =?us-ascii?Q?EO7UPEZ14Zs8vhC+TqT4ZdmlxUlgFkPkHYlHtcc6cvgo5WYwjseeNwVl+lKM?=
 =?us-ascii?Q?saExiz5wx37J0/5lLP/A5rPZOgGo1Dj1jtUeIahtrjTb3vJuCejXpX+FBDPt?=
 =?us-ascii?Q?seq6xiRuG/hHOoVN0uC1zxwZ01JADIgv3S0T7kG8nae7XO7k6vB5U/pyx/of?=
 =?us-ascii?Q?/3SFSD9fYW+OxTEpO+WTDeYzbKLc62K+UoxORETx3eEiQgbW32o3ORZoJEe0?=
 =?us-ascii?Q?jeF/9u02BVXtiWtmygG4qKo5RWtz+XfFlFiSYH3WfC+wul97/V/T0OEFZrDZ?=
 =?us-ascii?Q?vn31mCiSLJOmJ+TaDZEqVTOm0CfQ8qR6qA1GTu9iV1PuCz2kNXxm5fes+46o?=
 =?us-ascii?Q?pvhV18VJ2lOMMmWy8HSepFESCkInazP0z6YZsypLsygXQX8/TnjfdV7Z/bqI?=
 =?us-ascii?Q?P+XpfAOVcGU1/dcNRcBqFifrI5lLJI3xSJWlW04rrDKLIc5LD3005+6f4+Yr?=
 =?us-ascii?Q?Rv4jbIqwe5w8vAFmx7LvkMS3dqgeTlfOnvNzma69ZhVK2NQaVbY2fszCkd34?=
 =?us-ascii?Q?32O+WNtRcd7t1YV3n0Epv+AgmzL1XEooRjNZE/Ck?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b8d1d4-f6f5-4a8f-5bd4-08dcee506a18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:07:12.6060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdj3cPsjyCuPWsgbqMXjcZ6lLsca0ftDqmpkdUigyIsYPvRWxfa/SjVO5SgSURbQk20bmUxUS/9bOfSs/WgHFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10873

On Wed, Oct 16, 2024 at 11:51:54PM +0200, Marc Kleine-Budde wrote:
> Replace the magic number "1" by the already existing define
> FEC_ECR_RESET.

nit: wrap at 75 char.
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 2ee7e4765ba3163fb0d158e60b534b171da26c22..d948ed9810027d5fabe521dc3af2cf505dacd13e 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1089,7 +1089,7 @@ fec_restart(struct net_device *ndev)
>  	    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
>  		writel(0, fep->hwp + FEC_ECNTRL);
>  	} else {
> -		writel(1, fep->hwp + FEC_ECNTRL);
> +		writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
>  		udelay(10);
>  	}
>
>
> --
> 2.45.2
>
>

