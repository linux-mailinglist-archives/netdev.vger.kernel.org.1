Return-Path: <netdev+bounces-136366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A2E9A1827
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA64288BE4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A546F224FA;
	Thu, 17 Oct 2024 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D/BvsXd9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD9182B4;
	Thu, 17 Oct 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130123; cv=fail; b=tWzR2wj3YdU5Oqwmkt23sgtOUyXlXFPkeJofa6fJvePma3znMd2xVsLkvRIALlfrpXDeHGuwBeX3/b/jutQmATja+aWZXX4gXU3GMFd6Q4r7s28xuAvVCx/eGWC0fxHs4Ol/2NYBMCeNybXP1QlJCHHL8GRb06T7FKVPf0riedg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130123; c=relaxed/simple;
	bh=U+8svOHCHi8YWf4oaFLqGp0+HpM/tKohijE1UsT2U2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W+c9Fssp86rmlxbxN8xwdQDgNl0ZtyJ4jqvcwbMDpXT1Af1YV9qVL+e5PjmwnV7ZhZt6dwifm0B5LOQElTKv5L/uIqUQ1nSnFCLaEm8tGnajvouH4viBiNETyIxlhEB315SVVSXm45HNpwXS9Bf3TbyWrNV/UVKHZr6eT7/qltY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D/BvsXd9; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws8teHSD947GJUsJaCMgKCgHNAVU4BvdOLLagyzHO30yQwYWPHfLBA0UA8cVXQ7DIl5oC67mwiII5hN/leXUOUa6CYIBQ69gAGjxR9no11izKbU1SaojsbBCLySeXwH/zY0kSwMZhRr01oQh4gIamMlzszONvIYs14MLhgCDZHbWpR+tHqfarl1fondH8DDqkzqHX4OFGeQxaJpT2fbPNi3heZxkUPpufDFjWvAHgna0j29JFkXyioFTjRQvxMn1R7f9grgXgifAhyQDZmWC66rHdzcIa5vze3hbdYoNc0wKAG3N01WXRl51xF+6k33o5MZj3e/vzrqB8FA8AqT+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdN1T9bHHNecaMltxIpIi2geaV9vGeGpsC6Mver3jHM=;
 b=vkW+IKtSUDhJgKZ7X6oVPw3xgg5rWhi4/hWG0IxmaA1pKAxjq+85791jWU7/4MRKSLLiks2QqpjbK79dw8MU4zNVgo79OvY11RRXTTsAIS1d0lLdrSUYRvyP2ZrZ2wDQTln3HfYCccv5ToPbFbp/IdHsB8f7OgnhYjpRWc1U4lFwjCbNrVh09eq3QSvVZAjNV7MXxgKeRncR38MFfbf1YCMJUPoyfiBRWTM34EDB6q3L9eJSzuh27Nd2Tg0IZp3hC138nLSgKBVriE+Lyv7HHc0l8miy4p98MHFQXxSEWJeQVAV7e/mBUlkWfw7inkaIPGIr7jLXLj870V8DakLgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdN1T9bHHNecaMltxIpIi2geaV9vGeGpsC6Mver3jHM=;
 b=D/BvsXd95w8lc0d6zklH7LVGuwWeyzBL6yDVIGXEUTokbglQd7/m5OHfc4cvv3UUIw+09eeTuOA0RznDPb5vJt/zf9kDQdfWFlvm4k3RKqNT626K9FUPtUdxeLw7ykZ5FDHD+mfTQLElo/EVKFl1h6rmW7qrNxv/hCkSmzsiFaVaLcVnDN+VS5Bw6liInp4CPc5BdoFLPOsNF6jbgLIDl6ppFyiihlUYhe7JB0asBe5nZlFLtaL5iQqK89HvOYkzs1Mess17r6ZsbsOagFzUOTqWeixpqRiHWV9Yed79wN5wRoprz/cEewjguaxTmS6tHqzzMIveyQpttwbGszbVwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 01:55:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 01:55:17 +0000
Date: Wed, 16 Oct 2024 21:55:09 -0400
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
Subject: Re: [PATCH net-next 02/13] net: fec: struct fec_enet_private: remove
 obsolete comment
Message-ID: <ZxBufV7xkX9gK0+m@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-2-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-2-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0168f0-c01a-4871-7162-08dcee4ebfca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RybGwLBJAL23qCkReB422fe+cWCnwG0UTHQOnLhkEeyRErSilnDae+VxySGX?=
 =?us-ascii?Q?O7aKuVo9j0D/EOIxrhNB7Ryk7JajpUUlHvLAxGnZKBzQe6M4AeX9nfrlegxI?=
 =?us-ascii?Q?SjJwr0DQUEx385eOkqW+/UQEtUevJMOyYSIfpAtwnKODw3xd1Z+KXtuvzd6c?=
 =?us-ascii?Q?lWir0I2XuZaNLQ1sFecc8KVxXIBGtO+u2BsQzlP982Bp/95n0QbCuV3J7Q3p?=
 =?us-ascii?Q?6JIr3U9Bef119XTELvCp1pKKrkOReUg0HY9Y9PN90VhjiHcMqeVBRDLBvKPG?=
 =?us-ascii?Q?nZY6XX+3A/lY6Bf9q6sqlYZ8HkbVIlsWhvj9ugc11+/Qd+ZLcAC6KyZp0GnW?=
 =?us-ascii?Q?7S9WwG7c+1wHzpFM1ML7/nkDSaurC4Y8Rea2lVjogqmIDtEzZum12TFLwb5p?=
 =?us-ascii?Q?onNv/jA0hWkIxl7zu17hlEsnzaDm7Xs8S+TOSTGr5vcbHjH5dC5lYxSO6dU2?=
 =?us-ascii?Q?EbyGeRylXEVAugq0v64eEgup6L+MHW6SoT5RE4zrtbZkmYWd0S7H23OoH5xK?=
 =?us-ascii?Q?nfJtRYznuvxjOJCE0HyTpSrSBymAeatsCKi7S+9nBja5tA8vdQTD/PQ98Ndt?=
 =?us-ascii?Q?GOAVyAPQKjLXNj8Z3BNeYloHKUbcd6HPK7Knka8YKghY88ZOHVW81D1zhOmh?=
 =?us-ascii?Q?ZDgZ65+jst59ufJruIyGBvl4BvySgHbSrmF/z1LyTVnrbBY0EmzKEmMEqgCl?=
 =?us-ascii?Q?J65XFjQF3GXWYnvGDe8RGIwpLyNDXAW+axxTWf31vr81j1nb1RKUfblyCXLl?=
 =?us-ascii?Q?+ADLbcb04psqpraVCJzAr8MjaRqJgwqOgDPcDbTW/T0Rd2W8QjCVPCMQuFa0?=
 =?us-ascii?Q?l8E1i12MXx0w1RjwX9ABKtjMOWusdH6i/UaXuHNBXWhit6xRGQXeK5wL9Iks?=
 =?us-ascii?Q?Xu54VUU7biMJfy26UDKcVOOv0qfLG1hKVX0fzlGgo8ru98VwhJvI1V3RpM0/?=
 =?us-ascii?Q?jc6bQf+X4LXg1CK3OM2bzqKI1ibyS28ct1a+w97p8wRLleTh+4HVuwtQddUO?=
 =?us-ascii?Q?8eRuMc3kKxoglewU0VJIRjrjsrr/j2Pb/8Fijr8hiZEZfHW2dqPV4lowymMD?=
 =?us-ascii?Q?hsWJgl5ADu8CTOB2xvpFREuViaa06PGEDoluMSM29rXWNWqmwqAJzevyhtxm?=
 =?us-ascii?Q?lfl2XD2jB4/0kuCEkJ3wxzJl7V5HUALTNPfWWC7SekPUDHz5VbJMENloNmuK?=
 =?us-ascii?Q?T6GrZZafwfgdvukJ/aaqmOg/I+vQh5LMD7gT96d0Z8llBsljQqAjQGqWj1Yt?=
 =?us-ascii?Q?oNu1fAcnTWBkPhV46IY8d/EzOrbfM/VMjX2skto15IadaI5kCBiHaTjwifwo?=
 =?us-ascii?Q?cCurM6W9HcuxN3gyAzyp71+tCU8Iau9lfMxAV992W9SUuvi+Y0jpDU/ax63G?=
 =?us-ascii?Q?I/52nXE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3FEhWrUKHDECKG9eRZ9KdYwVkMiTAOCWOX6n3J1CqPvunjx1mzJ7j9nrtUkO?=
 =?us-ascii?Q?UIW612N5bTDypiRhQbWjLu7NlcTSamWhzqUYaPGqOqCv6XqsLIpcs/Q0CfWY?=
 =?us-ascii?Q?+u1LF5cuDvRpKrYSgP00zqiYbm1uymW89n7wIovkiKtC9NV/c/gNZqr+Qsd1?=
 =?us-ascii?Q?KWK7BORHl4G16s3HA/UARwO+NPD1zEw/wKrvYrvx/2D5NGiiCHHOxc/LtZHq?=
 =?us-ascii?Q?E4e+S7ggTDHAAAOsIpPfjiQQpagm9YzuNLsgJvexhS10Z4YIPGmlSZLVdddD?=
 =?us-ascii?Q?kxn3trGEXW5A0PTkObe5MkityG8OmXCWPO/85vLLNwG5m4uozrq/SCHMyCI7?=
 =?us-ascii?Q?eFQWxBaalLPwiLvYzLzZXbphQqwUObS2pM9sk1C/wu9QOCS6BrNeiAVsGXrE?=
 =?us-ascii?Q?9/LNgra4YfFYcCZZVEqngxeFmmqxpUSP3fETy+a1XAa5/4CgxkS0qjnl/vrL?=
 =?us-ascii?Q?w0DriWdCMA+90EjIzywpeCak4isCW4OBLge6rlkUW5GO9JyBtwITXmFZ+yyV?=
 =?us-ascii?Q?E4WMwyZYS7ux9L5HXYm6EoXZzHGTBimffrpZ1c6uvXyXlbk0fmRp9ObixNSX?=
 =?us-ascii?Q?0Ei3Ck/nJ/SlBFxUrYwrWH/03I9NPl7qFUWCe7KguM8Hf/DxLcqaSLMKwHfi?=
 =?us-ascii?Q?dXdEE5EadjC2T4T4UdjjlROSu48OCnfxvTS+rdjyYMSy7rQGVsoMKfh4C0x8?=
 =?us-ascii?Q?Pm2iZShoHNJrIgL5WK5QzKkXc0S40CdOkvnbCVB5qrrvUX3pFeKr7kassGee?=
 =?us-ascii?Q?4WiGtM2xbjzRwxDj5GcKbIfeFqd6lbTrPK/yelsifSbhyOmD6TCfxiaDwzmF?=
 =?us-ascii?Q?P1ky5Wm6ytktmpDf01/HJHZLWdYgMNMoKgLXzodQVb9Ooo+SYQU8/YQhiay+?=
 =?us-ascii?Q?7YRvIGeyn9rC+ubvBto6lSCewn0LY3FZO8clbQ75zWso+MdSTEvoTWHKfFuR?=
 =?us-ascii?Q?Y3sAbLxxsvfZX/ClwqV78TKQHnuhH+60tKhVIS/J0/HDm1i7o2Bl502SE1o/?=
 =?us-ascii?Q?Oo2rpNKFNV1dCL5Eq7SpFSA5aCEeUdiS+rBA+TzWWphQD338QyhGneHW3dqT?=
 =?us-ascii?Q?cvSMMH70KRCy/kg5BNshDyZPQV2VJhT1QTlcDPwKRusBTsaVQ8spItCbStFS?=
 =?us-ascii?Q?8sFVQdPZ4h0QLg8Q7jJWDKLsp+8Caa2xlYXb82obJ88D3jhV72dnddWjQnkp?=
 =?us-ascii?Q?G/YcxQzKm77GGbeCHtiGE3Bh0PcN2YacjlPsMr0hGT3KZNVSgz40M+yRoNEH?=
 =?us-ascii?Q?BTsMVBDddrpyDQ8udZkP0mwfg25i1vNc/BpQw3U5CBKAlYkQVxLKhJhtnaHS?=
 =?us-ascii?Q?2zmHeDEO2jkoUE328UD4RyXodqpFS3EV0/EbLBivdcAhz4vdiyFJ63PF7ZT9?=
 =?us-ascii?Q?fntWQ1zkC7Amj6pRuLA97HJjwtE3HDphfnvSdsOql0U/K5A2dr2aZl557S7J?=
 =?us-ascii?Q?ur83VHDmL8xHRl8d8KByCKxNS7zUnKAGS/h6f1ZSVBHSf6vwYAAwqb+yEr3h?=
 =?us-ascii?Q?1OFXH+fVfOhsQBtT5UT/5EonB36yaZ8PlCUuosil/vKgBlzzui8HvMKCVKPN?=
 =?us-ascii?Q?B3vQC9fvHGNpP3rSzJc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0168f0-c01a-4871-7162-08dcee4ebfca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 01:55:17.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLx0c5ESWc+mm0s0DBpFR1bJ+wNVcfwFDLNTLewr0DNBNSCcHCbXAqouCX+2uFO0ILujVM1rCW8jMvUXgh9s1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

On Wed, Oct 16, 2024 at 11:51:50PM +0200, Marc Kleine-Budde wrote:
> In commit 4d494cdc92b3 ("net: fec: change data structure to support
> multiqueue") the data structures were changed, so that the comment
> about the sent-in-place skb doesn't apply any more. Remove it.

nit: wrap at 75 char

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 77c2a08d23542accdb85b37a6f86847d9eb56a7a..e55c7ccad2ec39a9f3492135675d480a22f7032d 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -614,7 +614,6 @@ struct fec_enet_private {
>  	unsigned int num_tx_queues;
>  	unsigned int num_rx_queues;
>
> -	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
>  	struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
>  	struct fec_enet_priv_rx_q *rx_queue[FEC_ENET_MAX_RX_QS];
>
>
> --
> 2.45.2
>
>

