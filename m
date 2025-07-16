Return-Path: <netdev+bounces-207576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11556B07ED7
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DBF584698
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C532BEFE7;
	Wed, 16 Jul 2025 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HkRR8fLw"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6F288C23;
	Wed, 16 Jul 2025 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697596; cv=fail; b=EAALA5GjSsX7oCytR7OepOdFpF1qmwrr3ASLxzKksQAG/twM7R+CtlCC5six5TZ1IWqTamCLaCmL2lyYxeNJ0p6XWDaGZUDDwpOhvsuVXclIeD4pdOFnCBwxpY3QcgyoMsBoo9y0Zcw0OEMt7vCjJ/MSIPX4hC+WGRtWAh+ea4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697596; c=relaxed/simple;
	bh=P//kX7SgF74lMGmfAMJrOdUxukrdWZYzBIROoY3nBOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=afe9/fGUUoEUSRBlYTMKLteJZVjcErT7y+WimtW7MprHih/6Ofs/hQF4DlbQGUVc/cyGaxKPhoj3WusFA7frYn1en3jPpX+mpqyXQdhpBZlT0oJXHgfOciqX95Dypv154vNKOhKyKEQlqKwpG+KIoG+9IKRsuLkRalwBqYPSYNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HkRR8fLw; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7868RIz/44UkOPLyZ3ArfXGHQXWwfk2/KoWpzTQslOcG/GdWRk2b+wsmv2qbH4xSE9gCgQuU69JcepxQmIbMjf9qiYnYTrpnLLeVsLa4hJ8prt/b47V+EIr57U8l/pfg/3rq+5WwRXoZCMBPUIpet6J7amNZh3IWj4I1+WLJeVgp6w96u3Wmp5Dkt7iSUPgxFNaLO6SmwbCV2a/KVw89NwrBLxUI9S7val/AoLRm8DDw+dARw7DAHu4FJuMncOQJOJfYHpHB2hxe40lIfFs9yFyfDK2mEbOuvGVo7iS09LqJJS9szTKQrQ+l7tvFRZkPT0sGn9S8illXhOS+1Ez4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02BpGVnmYKj0LbRu3YX/6ADVcbhqv9ZVHZasrDqt838=;
 b=vLKSELTazWaDNv/n1sGVoOQ80L1JCiiKz/vvoh/cYxVKTQT/cSeLaPxHzWCJVA6NZSIpkniBt2MI/D6+/KCwekS2N/1Wluh9wlf0UoxUarcsbOBxCvvijbl4DZLBIzifcJ5vE+aIKgzl03cRoTE1z6Mnpyh9fA8QFy3czjVlQ8OUMzjkli0EMaZqoO4ILMMl53KXkKT+ujTEV5iX2GaJzknXublrC0eAlJUv5ePDRpmjC4+Emxe6XTJ2cw1KSbdbHQaiJ7WubweFr9i8NOOzejxokMluCLAx8rsE7JwW3gnEwTrCqKaHm6RhvDNIASaVy5jZxt50a4B4JIt6CmRk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02BpGVnmYKj0LbRu3YX/6ADVcbhqv9ZVHZasrDqt838=;
 b=HkRR8fLwVdLb3qKEDtSKitua3tlOmgv+TBaGjyvksVP3CzltaWH1aFrRY//54RER02eqcEpA4pKBZ7jvpatBY5FNw4GNU8qzEJ2lOfXkvREP5+vBuzabFawG5TrAQHR075b2ImdeV/4DhHmCTtScoSwDTd5v0S0PNjA3tLJqfwKjsigcLVMjDeO3d3dWFRYOQbBacS3l26rqZ/bgCQg3lWJctjCGOzAe6oyK7/vuhRTZT0Z/HOzayWEL86T6qWKhK7rkZFWzfPLKUphwr0miZ3eAffwgE9rT82dokFN2XV+7xz4tW5f2BXOuQXG4AgChRxB3OoMsn53HXtAglp2gSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7873.eurprd04.prod.outlook.com (2603:10a6:20b:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 20:26:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 20:26:31 +0000
Date: Wed, 16 Jul 2025 16:26:24 -0400
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
Subject: Re: [PATCH v2 net-next 05/14] ptp: netc: add periodic pulse output
 support
Message-ID: <aHgK8KL0Gxa3mmmE@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-6-wei.fang@nxp.com>
X-ClientProxiedBy: AS4P189CA0051.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b73b51-ab91-4ef1-df17-08ddc4a70cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k/1P/74ud39CHXMrgQ1N+G3S5iUN9gkUzyjHZtLGeWLYfw4nDkgoCyyZ3Od2?=
 =?us-ascii?Q?a7IO4jDQSsf5kyKQ8r9CzQRZiaATqSnf9ACUrCaiH4ARF2ZXtNf2IznEZR2q?=
 =?us-ascii?Q?Hi9fDK3YWJgzCAqF/vKQ/1VPyCNXpvSDVZmyJ1xg3l7djXV38O5ek9PE3PUl?=
 =?us-ascii?Q?J3I2gJYRmvuGZMY0sB8qYmfMy7PM+hio+4rEYefI+HB7h7p6zPNGpsCWIghn?=
 =?us-ascii?Q?bnQsSbKl8nsCuRTGSFLQQgIcj5fwR4dPNGjBQPjepGWRohgdILEx4IGY+TQv?=
 =?us-ascii?Q?DSCu2znERWe9eW5ZgaesUiH/NB46cCL+qR3+hayMsU8YYndhHC8I5js78Ugr?=
 =?us-ascii?Q?IXIpSea4FIWetx2Elygwlm9p4LDCVmlDUEdE9fnWaPo+XgRlk/pvsNmtVgtU?=
 =?us-ascii?Q?89HiTfAfv2Cs+yMTRTjXl2U9Hk+S4MJhIuyHoiu5BFQVOOanT3pjy7BXqCcV?=
 =?us-ascii?Q?hT2GFN0yfFomtxoVOcprcZLN3GrmfWHKc1q+ti3n8cGxex9xkuJQJPACuH5Y?=
 =?us-ascii?Q?pgnQ7VtmHzuVPgxrRT0SKe9xcvFNf6RGuWyEN/M5Cg4h74P8QdYCbm6Y1OrJ?=
 =?us-ascii?Q?62VEunH3BqZqRe92Fs+43Ausl16jVjIxOlSz4hHdMSkzRMEgGjJMcUyURX2N?=
 =?us-ascii?Q?BsD0o7q6JdHvuGPGyFPBultGVq8XwNpLpfzYh0gGqV+dqLYsliuqyqsTR+s5?=
 =?us-ascii?Q?RJEd1gYvc71Kahs9xTAAt1r12B2kIQOeNZAy4pHfU2O6R0rRTTw14NoUrH2P?=
 =?us-ascii?Q?oVReWdWeTfNnIFk7BmXmeucz+7SMWdafCZ63k1iir70Faoa6V480c1q1wYgA?=
 =?us-ascii?Q?Spj8iU45SR3cau06zp14emXyMXNLAu5MOsGTDQ1NVMnRoasHg4mI5OKRkibt?=
 =?us-ascii?Q?DqEEy4l3s95Bu1LNrQGQS/p7EOc4VLzxSkhccj6fp9zk+B6R2vUObyXODdyG?=
 =?us-ascii?Q?qWdd8gW1RHufiRmHw1HRhGDww7elxnOLRGeM9zjSES81+30rFQke5vufpGcn?=
 =?us-ascii?Q?0hD4rlvBG1IQPMW0iecH/+SzBfUkV/QCZFLsYKKd8PyYxgrRhr2u2LEJXrrP?=
 =?us-ascii?Q?rOR/IJWnvew6XQaAYNAmNw+vNk+YCL/xHvXMx4CAuH9vSWsPpLdrF6s1T5/7?=
 =?us-ascii?Q?GV6cUNQVBzXga6t5zPw4Feqy0mzVGMKgSXdGAqN1JOdJlgJpUGewcDAx6fHL?=
 =?us-ascii?Q?8Zz47+pZgqyxLm1fNstRUypYg+g/t7X11ryMDwmUDOYnGrbPutfIYTwJt5Kb?=
 =?us-ascii?Q?PLEk8/AO+DSGHDRfYvaee+Geeh2CF+TTLsPI7JjguMa5gGJ9dcgA6yNODcN4?=
 =?us-ascii?Q?ecpdjoBbgfLep1ZnRtZKmc3umf2kttAoBNGkOGE17PivH2qrIQSsXNawA599?=
 =?us-ascii?Q?varoxd73LNPrZxo9dc3KUxqB0grpw1Ag9rzxDJclxmpbzWXNvnpcZRqOyYYT?=
 =?us-ascii?Q?n+9hIy2hrtieQ3nK6lxvYByvhGYBInRgfSXZEm2yAK42S3VciShzgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vXFnYfwP/8CBC1A92ZdzTM1oXMHbiYzZs84Mm41/nXzyAh+3/hDvdN1jVR0/?=
 =?us-ascii?Q?S2ne2Ipkl3gzkNWottaJYztaIWZFD43wnrGPFJ19/qNH/oh94U9gKZx298bM?=
 =?us-ascii?Q?ALXDW9nJNCXrDj9AYa1Fbs3+ox2h1ZXJA2KxZhomUaf3+XiiDRkiIO9RL5aa?=
 =?us-ascii?Q?vRAvbIT1uaSAhJdPKym5cQFgd3cUOVasD0/085dYS+nj/9D4Xe4qqCJD8EdO?=
 =?us-ascii?Q?3ad97Sl8hUmoQ3WI4iArTOAtzhyfj49gVZvVkbeH7sPjVn4BjTIqEm26/XtR?=
 =?us-ascii?Q?FOhIk6+S1Nw7jBxPRnRQsXLdEuAhdR9FJWUKVyb64TKRsPhjh01hyguyTw3s?=
 =?us-ascii?Q?Mnw9wCnyZwQk7YYUmGFLiI0qrsSixBjUchu8f5uXgpisoC120Qz0Pz2n06NF?=
 =?us-ascii?Q?sOosegahm557i9g6UE5BC7tvcqVNJhyszxyZ4k91UklS/1PpBRb6x0jK0vZB?=
 =?us-ascii?Q?FAHueFz+wYmNGmJHwMdXvSauv/SxzH4vEGDdLUR2gxeece/xbLO31qT3gbkQ?=
 =?us-ascii?Q?TCOrGFAa4z+J5ISepqK8QI3GToHgW5CPok9ZM60AeS4CiHJz9z4HWKkZoOOr?=
 =?us-ascii?Q?X2/43UYq0r7r7ICBU9Zn86e64cQocA95S36U0C4dm1IraqprO4xzp8sxZcMr?=
 =?us-ascii?Q?2E8rFYTsinZ6LGjw2AfKPOVywLxbcNlWa/FrKfbcHhZ4F9gPd/mSL2FvRTET?=
 =?us-ascii?Q?vIL3ooyQ8/D/Lcu8nbhXmvyhfDH8A6pJ+Ko3tlSTSsiR0YAOmrlmiCFp34me?=
 =?us-ascii?Q?TqCcDbGl8VUFbR1KYxQNS1GW5qFeeHSs3+WyBf/4eRmM3TiW0KkAc2cmZZi3?=
 =?us-ascii?Q?qpcdWcFTKXzeqbej8g+h2aczBLDy+P+d9Uvja0yRPNRcMrC9alZYLnpmffjQ?=
 =?us-ascii?Q?n8oAgOUIdFeDuklCjreTy1D5GXfcHpFHMY61LhbSrifh2MLtnPChkPpMH71T?=
 =?us-ascii?Q?hElfS7vnBHOhN1WxpTzTAUHjy+osamrxXgwEytPnVJEkX7PbEA9F7CNIi7ET?=
 =?us-ascii?Q?6SxgsX8bAZliJG1e0N50z1a0fxUfVXfSxDu+uBDd9DWYgRRQjwsXCIG2YbzH?=
 =?us-ascii?Q?XzLxxg7t0uprHJ+3w8b9072uG1TmfU59OX/zrfZrSZYsGK5RXLtUKhqRFNPR?=
 =?us-ascii?Q?eDbHjIUNqslyM5NLpvgEBrx9GLwpD8nnfsNhHmrU19dJeLAWmW+X9g7qaLM9?=
 =?us-ascii?Q?0+aTRz/5Yri0eVwOkBy4Udjh1C6Rv12/POtuJGgh6tPTsMcSPe0h0hb9hKLR?=
 =?us-ascii?Q?iH5HjqKqI38Id2UGcH9fk+NrMXSG9ntpQFinaz9gRuP6qblDh60nN6Dz+UzI?=
 =?us-ascii?Q?QqUXBD8jtWyU7vkIOkfsoXp8jt1YlItDh0guPm7haBqSY10Az837JCp/YaCe?=
 =?us-ascii?Q?YsjzZ7moO7ciFBILggWNQFZpX6nXUDUrlxO/5HQefHlaWyVYrId0f0iVbDDx?=
 =?us-ascii?Q?pxQqgtlHs/67tcUMraL8DpMcgXSRIb3ZLvf/6ohfc3hWYMbMQw3qNNrhlHM0?=
 =?us-ascii?Q?mUpMCzvfd6hlhLbEZNHgA0Lo3PIIqdgegcXfmsqgbI2JwYrPs4WwWRXWg/Y4?=
 =?us-ascii?Q?9++PNF63SutaJo5Qikv4ZFPzi37TJxmkgcJYnRmh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b73b51-ab91-4ef1-df17-08ddc4a70cc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:26:31.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDS4gPK5vgih10QCBYxfFCogeXSbZ/8hufSgjDgkH7TmuRFKouPC+YwIQR8oamytxhky/kb4TrBxcAQDWHfxMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7873

On Wed, Jul 16, 2025 at 03:31:02PM +0800, Wei Fang wrote:
> NETC Timer has three pulse channels, all of which support periodic pulse
> output. Bind the channel to a ALARM register and then sets a future time
> into the ALARM register. When the current time is greater than the ALARM
> value, the FIPER register will be triggered to count down, and when the
> count reaches 0, the pulse will be triggered. The PPS signal is also
> implemented in this way. However, for i.MX95, only ALARM1 can be used for
> periodic pulse output, and for i.MX943, ALARM1 and ALARM2 can be used for
> periodic pulse output, but NETC Timer has three channels, so for i.MX95,
> only one channel can work at the same time, and for i.MX943, at most two
> channel can work at the same time. Otherwise, if multiple channels share
> the same ALARM register, some channel pulses will not meet expectations.
> Therefore, the current implementation does not allow multiple channels to
> share the same ALARM register at the same time.

Can you simple said

NETC Timer has three pulse channels. i.MX95 have one ALARM1. i.MX943 have
ALARM1 and ALARM2. So only one channel can work for i.MX95. Two channels
for imx943 at most.

Current (driver or IP) implementation don't allow multiple channels to
share the same alarm register at the same time.

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/ptp/ptp_netc.c | 281 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 250 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index e39605c5b73b..289cdd50ae3d 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -55,6 +55,10 @@
>  #define NETC_TMR_CUR_TIME_H		0x00f4
>
>  #define NETC_TMR_REGS_BAR		0
> +#define NETC_GLOBAL_OFFSET		0x10000
> +#define NETC_GLOBAL_IPBRR0		0xbf8
> +#define  IPBRR0_IP_REV			GENMASK(15, 0)
> +#define NETC_REV_4_1			0x0401
>
>  #define NETC_TMR_FIPER_NUM		3
>  #define NETC_TMR_DEFAULT_PRSC		2
> @@ -62,6 +66,7 @@
>  #define NETC_TMR_DEFAULT_PPS_CHANNEL	0
>  #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
>  #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
> +#define NETC_TMR_ALARM_NUM		2
>
>  /* 1588 timer reference clock source select */
>  #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> @@ -70,6 +75,19 @@
>
>  #define NETC_TMR_SYSCLK_333M		333333333U
>
> +enum netc_pp_type {
> +	NETC_PP_PPS = 1,
> +	NETC_PP_PEROUT,
> +};
> +
> +struct netc_pp {
> +	enum netc_pp_type type;
> +	bool enabled;
> +	int alarm_id;
> +	u32 period; /* pulse period, ns */
> +	u64 stime; /* start time, ns */
> +};
> +
>  struct netc_timer {
>  	void __iomem *base;
>  	struct pci_dev *pdev;
> @@ -87,7 +105,9 @@ struct netc_timer {
>
>  	int irq;
>  	u8 pps_channel;
> -	bool pps_enabled;
> +	u8 fs_alarm_num;
> +	u8 fs_alarm_bitmap;
> +	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
>  };
>
>  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> @@ -199,6 +219,7 @@ static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
>  static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
>  				     u32 integral_period)
>  {
> +	struct netc_pp *pp = &priv->pp[channel];
>  	u64 alarm;
>
>  	/* Get the alarm value */
> @@ -206,7 +227,51 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
>  	alarm = roundup_u64(alarm, NSEC_PER_SEC);
>  	alarm = roundup_u64(alarm, integral_period);
>
> -	netc_timer_alarm_write(priv, alarm, 0);
> +	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
> +}
> +
> +static void netc_timer_set_perout_alarm(struct netc_timer *priv, int channel,
> +					u32 integral_period)
> +{
> +	u64 cur_time = netc_timer_cur_time_read(priv);
> +	struct netc_pp *pp = &priv->pp[channel];
> +	u64 alarm, delta, min_time;
> +	u32 period = pp->period;
> +	u64 stime = pp->stime;
> +
> +	min_time = cur_time + NSEC_PER_MSEC + period;
> +	if (stime < min_time) {
> +		delta = min_time - stime;
> +		stime += roundup_u64(delta, period);
> +	}
> +
> +	alarm = roundup_u64(stime - period, integral_period);
> +	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
> +}
> +
> +static int netc_timer_get_alarm_id(struct netc_timer *priv)
> +{
> +	int i;
> +
> +	for (i = 0; i < priv->fs_alarm_num; i++) {
> +		if (!(priv->fs_alarm_bitmap & BIT(i))) {

fnd_next_zero_bit()?

or use ffz();

Frank
> +			priv->fs_alarm_bitmap |= BIT(i);
> +			break;
> +		}
> +	}
> +
> +	return i;
> +}
> +
> +static u64 netc_timer_get_gclk_period(struct netc_timer *priv)
> +{
> +	/* TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz.
> +	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq.
> +	 * TMR_GCLK_period = (NSEC_PER_SEC * oclk_prsc) / clk_freq
> +	 */
> +
> +	return div_u64(mul_u32_u32(NSEC_PER_SEC, priv->oclk_prsc),
> +		       priv->clk_freq);
>  }
>
>  /* Note that users should not use this API to output PPS signal on
> @@ -217,20 +282,43 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
>  static int netc_timer_enable_pps(struct netc_timer *priv,
>  				 struct ptp_clock_request *rq, int on)
>  {
> +	struct device *dev = &priv->pdev->dev;
>  	u32 tmr_emask, fiper, fiper_ctrl;
>  	u8 channel = priv->pps_channel;
>  	unsigned long flags;
> +	struct netc_pp *pp;
> +	int alarm_id;
> +	int err = 0;
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> +	pp = &priv->pp[channel];
> +	if (pp->type == NETC_PP_PEROUT) {
> +		dev_err(dev, "FIPER%u is being used for PEROUT\n", channel);
> +		err = -EBUSY;
> +		goto unlock_spinlock;
> +	}
> +
>  	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
>  	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
>
>  	if (on) {
>  		u32 integral_period, fiper_pw;
>
> -		if (priv->pps_enabled)
> +		if (pp->enabled)
> +			goto unlock_spinlock;
> +
> +		alarm_id = netc_timer_get_alarm_id(priv);
> +		if (alarm_id == priv->fs_alarm_num) {
> +			dev_err(dev, "No available ALARMs\n");
> +			err = -EBUSY;
>  			goto unlock_spinlock;
> +		}
> +
> +		pp->enabled = true;
> +		pp->type = NETC_PP_PPS;
> +		pp->alarm_id = alarm_id;
> +		pp->period = NSEC_PER_SEC;
>
>  		integral_period = netc_timer_get_integral_period(priv);
>  		fiper = NSEC_PER_SEC - integral_period;
> @@ -238,17 +326,19 @@ static int netc_timer_enable_pps(struct netc_timer *priv,
>  		fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
>  				FIPER_CTRL_FS_ALARM(channel));
>  		fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
> +		fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
>  		tmr_emask |= TMR_TEVNET_PPEN(channel);
> -		priv->pps_enabled = true;
>  		netc_timer_set_pps_alarm(priv, channel, integral_period);
>  	} else {
> -		if (!priv->pps_enabled)
> +		if (!pp->enabled)
>  			goto unlock_spinlock;
>
> +		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
> +		memset(pp, 0, sizeof(*pp));
> +
>  		fiper = NETC_TMR_DEFAULT_FIPER;
>  		tmr_emask &= ~TMR_TEVNET_PPEN(channel);
>  		fiper_ctrl |= FIPER_CTRL_DIS(channel);
> -		priv->pps_enabled = false;
>  	}
>
>  	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
> @@ -258,38 +348,150 @@ static int netc_timer_enable_pps(struct netc_timer *priv,
>  unlock_spinlock:
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
> -	return 0;
> +	return err;
>  }
>
> -static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
> +static int net_timer_enable_perout(struct netc_timer *priv,
> +				   struct ptp_clock_request *rq, int on)
>  {
> -	u32 fiper = NETC_TMR_DEFAULT_FIPER;
> -	u8 channel = priv->pps_channel;
> -	u32 fiper_ctrl;
> +	struct device *dev = &priv->pdev->dev;
> +	u32 tmr_emask, fiper, fiper_ctrl;
> +	u32 channel = rq->perout.index;
> +	unsigned long flags;
> +	struct netc_pp *pp;
> +	int alarm_id;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
>
> -	if (!priv->pps_enabled)
> -		return;
> +	pp = &priv->pp[channel];
> +	if (pp->type == NETC_PP_PPS) {
> +		dev_err(dev, "FIPER%u is being used for PPS\n", channel);
> +		err = -EBUSY;
> +		goto unlock_spinlock;
> +	}
>
> +	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
>  	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> -	fiper_ctrl |= FIPER_CTRL_DIS(channel);
> +	if (on) {
> +		u64 period_ns, gclk_period, max_period, min_period;
> +		struct timespec64 period, stime;
> +		u32 integral_period, fiper_pw;
> +
> +		period.tv_sec = rq->perout.period.sec;
> +		period.tv_nsec = rq->perout.period.nsec;
> +		period_ns = timespec64_to_ns(&period);
> +
> +		integral_period = netc_timer_get_integral_period(priv);
> +		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
> +		gclk_period = netc_timer_get_gclk_period(priv);
> +		min_period = gclk_period * 4 + integral_period;
> +		if (period_ns > max_period || period_ns < min_period) {
> +			dev_err(dev, "The period range is %llu ~ %llu\n",
> +				min_period, max_period);
> +			err = -EINVAL;
> +			goto unlock_spinlock;
> +		}
> +
> +		stime.tv_sec = rq->perout.start.sec;
> +		stime.tv_nsec = rq->perout.start.nsec;
> +
> +		tmr_emask |= TMR_TEVNET_PPEN(channel);
> +
> +		/* Set to desired FIPER interval in ns - TCLK_PERIOD */
> +		fiper = period_ns - integral_period;
> +		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
> +
> +		if (pp->enabled) {
> +			alarm_id = pp->alarm_id;
> +		} else {
> +			alarm_id = netc_timer_get_alarm_id(priv);
> +			if (alarm_id == priv->fs_alarm_num) {
> +				dev_err(dev, "No available ALARMs\n");
> +				err = -EBUSY;
> +				goto unlock_spinlock;
> +			}
> +
> +			pp->type = NETC_PP_PEROUT;
> +			pp->enabled = true;
> +			pp->alarm_id = alarm_id;
> +		}
> +
> +		pp->stime = timespec64_to_ns(&stime);
> +		pp->period = period_ns;
> +
> +		fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
> +				FIPER_CTRL_FS_ALARM(channel));
> +		fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
> +		fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
> +
> +		netc_timer_set_perout_alarm(priv, channel, integral_period);
> +	} else {
> +		if (!pp->enabled)
> +			goto unlock_spinlock;
> +
> +		tmr_emask &= ~TMR_TEVNET_PPEN(channel);
> +		fiper = NETC_TMR_DEFAULT_FIPER;
> +		fiper_ctrl |= FIPER_CTRL_DIS(channel);
> +
> +		alarm_id = pp->alarm_id;
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, alarm_id);
> +		priv->fs_alarm_bitmap &= ~BIT(alarm_id);
> +		memset(pp, 0, sizeof(*pp));
> +	}
> +
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
>  	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
>  	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +
> +unlock_spinlock:
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return err;
>  }
>
> -static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
> +static void netc_timer_disable_fiper(struct netc_timer *priv)
>  {
> -	u32 fiper_ctrl, integral_period, fiper;
> -	u8 channel = priv->pps_channel;
> +	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	int i;
>
> -	if (!priv->pps_enabled)
> -		return;
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		struct netc_pp *pp = &priv->pp[i];
> +
> +		if (!pp->enabled)
> +			continue;
> +
> +		fiper_ctrl |= FIPER_CTRL_DIS(i);
> +		netc_timer_wr(priv, NETC_TMR_FIPER(i), NETC_TMR_DEFAULT_FIPER);
> +	}
> +
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static void netc_timer_enable_fiper(struct netc_timer *priv)
> +{
> +	u32 integral_period = netc_timer_get_integral_period(priv);
> +	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	int i;
> +
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		struct netc_pp *pp = &priv->pp[i];
> +		u32 fiper;
> +
> +		if (!pp->enabled)
> +			continue;
> +
> +		fiper_ctrl &= ~FIPER_CTRL_DIS(i);
> +
> +		if (pp->type == NETC_PP_PPS)
> +			netc_timer_set_pps_alarm(priv, i, integral_period);
> +		else if (pp->type == NETC_PP_PEROUT)
> +			netc_timer_set_perout_alarm(priv, i, integral_period);
> +
> +		fiper = pp->period - integral_period;
> +		netc_timer_wr(priv, NETC_TMR_FIPER(i), fiper);
> +	}
>
> -	integral_period = netc_timer_get_integral_period(priv);
> -	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> -	fiper_ctrl &= ~FIPER_CTRL_DIS(channel);
> -	fiper = NSEC_PER_SEC - integral_period;
> -	netc_timer_set_pps_alarm(priv, channel, integral_period);
> -	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
>  	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
>  }
>
> @@ -301,6 +503,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_PPS:
>  		return netc_timer_enable_pps(priv, rq, on);
> +	case PTP_CLK_REQ_PEROUT:
> +		return net_timer_enable_perout(priv, rq, on);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -319,9 +523,9 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
>  	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
>  				    TMR_CTRL_TCLK_PERIOD);
>  	if (tmr_ctrl != old_tmr_ctrl) {
> -		netc_timer_disable_pps_fiper(priv);
> +		netc_timer_disable_fiper(priv);
>  		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> -		netc_timer_enable_pps_fiper(priv);
> +		netc_timer_enable_fiper(priv);
>  	}
>
>  	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> @@ -348,7 +552,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> -	netc_timer_disable_pps_fiper(priv);
> +	netc_timer_disable_fiper(priv);
>
>  	tmr_off = netc_timer_offset_read(priv);
>  	if (delta < 0 && tmr_off < abs(delta)) {
> @@ -364,7 +568,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  		netc_timer_offset_write(priv, tmr_off);
>  	}
>
> -	netc_timer_enable_pps_fiper(priv);
> +	netc_timer_enable_fiper(priv);
>
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
> @@ -401,10 +605,10 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> -	netc_timer_disable_pps_fiper(priv);
> +	netc_timer_disable_fiper(priv);
>  	netc_timer_offset_write(priv, 0);
>  	netc_timer_cnt_write(priv, ns);
> -	netc_timer_enable_pps_fiper(priv);
> +	netc_timer_enable_fiper(priv);
>
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
> @@ -433,6 +637,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
>  	.n_alarm	= 2,
>  	.n_pins		= 0,
>  	.pps		= 1,
> +	.n_per_out	= 3,
>  	.adjfine	= netc_timer_adjfine,
>  	.adjtime	= netc_timer_adjtime,
>  	.gettimex64	= netc_timer_gettimex64,
> @@ -659,6 +864,15 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
>  	pci_free_irq_vectors(pdev);
>  }
>
> +static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
> +{
> +	u32 val;
> +
> +	val = netc_timer_rd(priv, NETC_GLOBAL_OFFSET + NETC_GLOBAL_IPBRR0);
> +
> +	return val & IPBRR0_IP_REV;
> +}
> +
>  static int netc_timer_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *id)
>  {
> @@ -689,6 +903,11 @@ static int netc_timer_probe(struct pci_dev *pdev,
>  		goto timer_pci_remove;
>  	}
>
> +	if (netc_timer_get_global_ip_rev(priv) == NETC_REV_4_1)
> +		priv->fs_alarm_num = 1;
> +	else
> +		priv->fs_alarm_num = NETC_TMR_ALARM_NUM;
> +
>  	err = netc_timer_init_msix_irq(priv);
>  	if (err)
>  		goto disable_clk;
> --
> 2.34.1
>

