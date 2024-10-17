Return-Path: <netdev+bounces-136368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FE49A184E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 04:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3001C20A24
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 02:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA4C28E0F;
	Thu, 17 Oct 2024 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QPVxsMVF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4731CD0C;
	Thu, 17 Oct 2024 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130414; cv=fail; b=OI24XU03qngdG8A4iDsgXnhszaE8x0rVrF4bZNL2qUcABX5ATW1eT/uLY4i8cFbeHTL0uH8VKhaPZm17K02Cwvs0xxqD3Nau1QCBNe28YpP5a3M9iaEHc9XSPb3rH4I7vFM275N8Sk3P157DzkiiXtO+8sJCW0yG+glZo4f0r+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130414; c=relaxed/simple;
	bh=FJUkqq017qGqcoo72ofF1pyh/sWc4hGCPZ1MHMLLVG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WR+Mf6+CcKo0E3FQpf3Cy7QB0q5KTTZ+r8e7KMXx6O6mzWNwwQu50dQcVIZd2Tu/hafvReWEKP8v6NYFChXsq6w+DBGzCa0n9FNpWmCoC24xJGMfcxG8hEISAunvVkxq13FBGpH6scbAqkdosSdi48HB5pVXJCgzuRsv6638T0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QPVxsMVF; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuOXQ0rkVnLfZRVJ5Ru6ZyQ3zPSkp4E1BbdIaAvLLh7Pf780zwxu9D2F+RwKJaVcpqjQImbiWTsoMUgwJ/xr18s7rVHXUMWt1EBKn6cRkLx5bsp1mOH81Sutg+DWVDv224+eDEMSwkRWTfy2A86woxU4W+X1+qUQnWTW7U1iXm7ffFGv2hQaJo39Ok/ZrnaBBrLwH611xo+Bo613JnR1t+CxcD5eemfJlzPlTKurA2XDuMw4WG33Fqy76zWCdAdxtqxizNDztmwrNo+++Z82N4KKVXVA88B6kGNcQ/jZ9Wq3SSxAsYfaCVFDUchSN5a8XhzP2BJ22GC8MV/X4QhK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/41o8wWK/V8IYUX15pfKVLZCdm/88+n526zcaBSwGQ=;
 b=mX/OVTPGDjmiUHePPu4qiTanXls5V8F3fApqpKe6wEvbx5PksHdAnGrZ/fqaaqeiFDLIoQAMAvr+AzsUCNAyacMYFSQtV/s44bKzp9AbSmSad4aDT12cDEqCluLfjYDTpAYLh+MzsRrc2rn9QlgAGMmsMK2YWuaue7xQvG5W2MeoCftP4xSWPErgzblzo20EOFlbADACL8EASwI5Sc30L4inx6qyUwsVWeb+oWLQ3M43cnmOWAfjbCWSwWxChl8hqTWCibB5UBa3eRspv30QpPU4eE5+lwu8YnlpKKfA0zbeBEiVmgu9Yp0TDKLlZ2cYKRZnbYDU7rPAQQf35ECg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/41o8wWK/V8IYUX15pfKVLZCdm/88+n526zcaBSwGQ=;
 b=QPVxsMVFgonjwJ/oIfIbSNjAyUPF5sDvvIzMTycao0xHtH58emTM3Ro4yehpZ41NrD9dS1+uLJeuGy2pYbDJhMnTZhqNoVRKzEcmgiVV2R+rwuszlQ4BcRAY7hhTlRBta998RjATDFhguKU0LE9/Tccssv1BbT0faPpenrWjq/JNmefnOLL/xiYazb7/qFAWWy4XDWIDrL6eXYdI4hT8SMFrKF/+m47uNTW1HM2idK7SUoXF66wPJQmMFFT1vSCCR301t3kaBj71hfPF3S2jPWBXRGnKuJJ7kN5iP1oBu1JdqdP7vWRvGGMjptSEhR5pBdlzrPcOLipPL5+TuGQHug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 02:00:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 02:00:07 +0000
Date: Wed, 16 Oct 2024 21:59:59 -0400
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
Subject: Re: [PATCH net-next 04/13] net: fec: rename struct fec_devinfo
 fec_imx6x_info -> fec_imx6sx_info
Message-ID: <ZxBvn/r8YNqSVRcC@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-4-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-4-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: dc29ad78-7813-4c00-baaf-08dcee4f6caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vp6tR1VZq0TgHmpBmFBMh8djAEUofKSBzFplR/SiTjGqzEWQs+3ucN5PvFIp?=
 =?us-ascii?Q?68J7bHheATlyZVw6PO6wgt0F9pn7n0lMYY210q1CqpGzKuBq42azUxZF4Z+8?=
 =?us-ascii?Q?X7F8eay3ZlpwUsiACaeQyfQpxhK9faZO2v8EoLpm9nTl9OK37OKMjCJtAfy/?=
 =?us-ascii?Q?UPCtP+flbzdMhB8mRCLZLx+GkyMfWdVIBFRdB9VCm6Gi0S95XbEiuETNr2uQ?=
 =?us-ascii?Q?FwV+rnmaGKws9/8pd8Dj2tz3ov/VsAePlK3xJCrBNMRCKaiPe/CvPSECPQl+?=
 =?us-ascii?Q?hgesoCi2hgLwHE/RQ0pGMpvG22GLKwbKuUHzD+reK4WEaVGRZ4Q7GYfqGEqP?=
 =?us-ascii?Q?Ux7Db8LMyCRL8o0l+Timj7DrvRS8QZb7qNEPcFWl15vd0VIk8R3WxgS5sYu+?=
 =?us-ascii?Q?DeKXhqvjZE1p2EGSQz7lLR70RsZ0H62MBoeAisxsZyXgx5TuAltLvKcwLO8r?=
 =?us-ascii?Q?GODg95oJNDQYc5HSojE0wFiutbtvPQOCp84C9J4m+5RhPffGiL3qzh3kYP7b?=
 =?us-ascii?Q?Wsely8uvZWj+LL7y+mWZp5D04g/HJGmD+N8SCD0IBn5vGCbruq5YKZ4olj95?=
 =?us-ascii?Q?muXb0UQhddqgEit5ppYQpSqPUOVGTYkBLYantL1a9gOKsJqDXBdGng/lAlqh?=
 =?us-ascii?Q?vKYd5b9p7mk8sQKHNLpUzXabp+cZqtTU6eSQAlvW/N87PfVcumQrinMsYh22?=
 =?us-ascii?Q?jP3ffp0sy0eNL1osgrjNsh6xjMUDOVKUH0HUkKH7MXGAFz4LwHtS6dlT9lWJ?=
 =?us-ascii?Q?Cwpg1Y6cSQ5bBVH2qN4tBZvFxWdZHYrUqH53GG2Q+IFy5Bbujspm4zSiACtC?=
 =?us-ascii?Q?S7irgreQhosE0OV+RXA3lXZBzJvONVrbqDf0ZFcXhG85ofBpyvmSX4gFjV5a?=
 =?us-ascii?Q?fBtkdJHstGHZyglFD4l90FNfUwyAplLtcQIFexDjOA4UMD6NwCb14PftV9N6?=
 =?us-ascii?Q?ikjPbPzTVogZ9PFrOi6LoVKHTv0Hsxn1MznxWB8kR2XNUoKCxBJGz8alkLI7?=
 =?us-ascii?Q?L7zQPtzfNea8uLy8U8QjLtw4HSqBy2x6SODQUZvu8K/4kjuZtvBtLxveUYGQ?=
 =?us-ascii?Q?Vaq6qfj9isK22+86oPMCdvLwUrk/MJNtosx5dg3OiOdBkugjlD3I5DMfO9gs?=
 =?us-ascii?Q?eIS4kNj2IqsE3t3gxWQ//BJkbHc4pM3nEwQXU0oq4EbzoYQdsBWY+XT+N/ZO?=
 =?us-ascii?Q?m4zdODy3heHQLGQHhKQKi/aa+gIH1s6W5TbOpN6WQtMDigJHCC5aPTrqna91?=
 =?us-ascii?Q?EThzjDJYL6VAaR1+pAz6W7CRakvu3nychSrgGG1H7V6t7YKExm4d560+AhHJ?=
 =?us-ascii?Q?i0t64HXK0KzN6dbSm8tlmJm1a72CfDKLIx8jySkHW0dQcpVSvw+ZmV4DeC2F?=
 =?us-ascii?Q?AbvxMho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mm2+LB8Qb14lM/xkEWmjoYY6wP52/xvpp3YWiT9qbwnzzFZTWAIYA1iuDhZ6?=
 =?us-ascii?Q?NyxQV2jdhl3L/pHTWYKgZxzklbaFnYjIG4VW56qevOY6zujUBrfTO+zVIuGt?=
 =?us-ascii?Q?Yddtz+sJXQ6pX5ksdyEGNXpjqOtztpd05hKSXjOtuXQBuFs0neh6TbjCdQPm?=
 =?us-ascii?Q?57GrJH/EeCooj/1J4rfvVOVq+ZfRbcg7ojfv/nEPoGKVvgsg/Xiibn5lm2ye?=
 =?us-ascii?Q?kTsT3xfABFgL0ElmhUlWd7fNNddlxy0/DBNnNW5eMA7j02Kx9aqEFzDzcQka?=
 =?us-ascii?Q?QJomqpQ886lWKY5uCeTkH+wbcoWZwvIZPT+dMDgl0fZOYqAOUf4+oYBnYTY5?=
 =?us-ascii?Q?/8goFCfEcYjXd2ZvGUQzFZo5y6iaj7vF7fNUacWiP0vK3Ip7BwszLYCV2SuM?=
 =?us-ascii?Q?CuXWZiL5vgv17NR6X/YM61C65GyVpPwdHubexpBmwGVF02rdgvZLXVYckxrQ?=
 =?us-ascii?Q?ateidilct2atZ7OxJN6FvTVy1UPWhVuiVoOMDYdso4UyPdsLFoSkwDo/YMff?=
 =?us-ascii?Q?54UxE+y7CTKVPK6SsZncsDIAx8ehIroD/MxDlv4psxiFazKXcox/JW39SZXI?=
 =?us-ascii?Q?WBTMCigwo477CazvBlAROTryW7FTDjHEp/6YG2Wsu4nFsGypBS83Yi8UQxDX?=
 =?us-ascii?Q?IZKGJxsdsFmRCZinAmtU1ujOouk1/WTwhSLHACbDeC1lRUiCI00Gh7HOpwPE?=
 =?us-ascii?Q?tuaMbWtisydv6CaUpyqhwmBl0cpcna6XqG91URE9k502uLnkBk4TM1UVmW1u?=
 =?us-ascii?Q?oD8MFLVKQStK5m9Eaw79hbm8ebVSvzbyZBXOn2Qc3YnjqDuhfTA4n11zx3Ay?=
 =?us-ascii?Q?5BuT5m2WQBPMrVCx9jiRp7akqRbLfP763UG4ALYyBkwuw/aecX7z4pCp5Thl?=
 =?us-ascii?Q?+MBQOAKGr/jJtoHwYUeLhx7VOOSo6rJ90oOcyv1DneHgsWi1AnX9sOdq3Npb?=
 =?us-ascii?Q?h0H80J5gXMS8EJ60dIEIjxOuohcvfePROAOmV2M8bh6E8QeSahqe5pxwWAaF?=
 =?us-ascii?Q?laPrtLbiOwNjrwMl6xsq/2+f4p7Kz1kGxzU4EX3pxQgPA5P/iatYjiSMKNuF?=
 =?us-ascii?Q?TQ3s6AGZyIaeGRtNJS5l+9/4sInq/65dMzwmTBDyB2qMuf5YgKzYMPRrFvWP?=
 =?us-ascii?Q?UzECcctY3amZnEDcS8vqOqPGjApJiz4heHHDCfobLD6kXWwAnLJzWEBsOHEC?=
 =?us-ascii?Q?6XNb2VB5oPtuutQLQNJuiQyPwndyPiHPJlMvWlQejxHUUI1TL62DKcGEKdY0?=
 =?us-ascii?Q?IwlVmZxRPX9qTnph4y/n+j6l36kqqMQLclhe6Ey7mic0ClLXggRMtCcB+tUV?=
 =?us-ascii?Q?UslkFFDzEK5uWKwdhEEUYOBsxNT4c+wBuz0we6hDESsXq/5/BAbgH3W9UXSh?=
 =?us-ascii?Q?6D6YsXV8/ZIWZVWkzDJ1cuPdufibRPfdHoE8ObRUVHZ9ZGunk/rYiHwECRdi?=
 =?us-ascii?Q?X77ygXOEmr5ASDnvtlwa2z9lvItBfO+QzpMrZw6nPBs21+tQ0r/YfLQ5FAUG?=
 =?us-ascii?Q?PIpWLHi+R1HlSRaXaVQA17pyK1y4ub5s4JCQPtqvEcPpWJ5cvtFWpPrYu8e1?=
 =?us-ascii?Q?nqQgokmo41Wd0BB6PJYKceLMmzTS1cticz4gZolj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc29ad78-7813-4c00-baaf-08dcee4f6caa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:00:07.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1brLElYM2cdy9NakbwLrZRw8z7PBBGQGpZ8xv3ZGFMuvSP8t5OvK7fF0s723sRC/W+J6oF64NiAwHG5jO6o5Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

On Wed, Oct 16, 2024 at 11:51:52PM +0200, Marc Kleine-Budde wrote:
> In da722186f654 ("net: fec: set GPR bit on suspend by DT
> configuration.") the platform_device_id fec_devtype::driver_data was
> converted from holding the quirks to a pointing to struct fec_devinfo.
>
> The struct fec_devinfo holding the information for the i.MX6SX was
> named fec_imx6x_info.
>
> To align the name of the struct with the SoC's name, rename struct
> fec_devinfo fec_imx6x_info to struct fec_devinfo fec_imx6sx_info.

Is it better
"Rename fec_imx6x_info to fec_imx6sx_info to align SoC's name."

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 1b55047c0237cbea4e44a5a8335af5c11e2325f8..c57039cc83228dcd980a8fdbc18cd3eab2dfe1a5 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -131,7 +131,7 @@ static const struct fec_devinfo fec_mvf600_info = {
>  		  FEC_QUIRK_HAS_MDIO_C45,
>  };
>
> -static const struct fec_devinfo fec_imx6x_info = {
> +static const struct fec_devinfo fec_imx6sx_info = {
>  	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
>  		  FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
>  		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
> @@ -196,7 +196,7 @@ static const struct of_device_id fec_dt_ids[] = {
>  	{ .compatible = "fsl,imx28-fec", .data = &fec_imx28_info, },
>  	{ .compatible = "fsl,imx6q-fec", .data = &fec_imx6q_info, },
>  	{ .compatible = "fsl,mvf600-fec", .data = &fec_mvf600_info, },
> -	{ .compatible = "fsl,imx6sx-fec", .data = &fec_imx6x_info, },
> +	{ .compatible = "fsl,imx6sx-fec", .data = &fec_imx6sx_info, },
>  	{ .compatible = "fsl,imx6ul-fec", .data = &fec_imx6ul_info, },
>  	{ .compatible = "fsl,imx8mq-fec", .data = &fec_imx8mq_info, },
>  	{ .compatible = "fsl,imx8qm-fec", .data = &fec_imx8qm_info, },
>
> --
> 2.45.2
>
>

