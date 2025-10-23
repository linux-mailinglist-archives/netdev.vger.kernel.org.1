Return-Path: <netdev+bounces-232185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28A9C022F6
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA593A9776
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784B33C520;
	Thu, 23 Oct 2025 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="moSeIEEj"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013017.outbound.protection.outlook.com [52.101.83.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEAF33C50F;
	Thu, 23 Oct 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233965; cv=fail; b=Wg7EeuJGpnhHcO9YSP4u5//HVs+ZZsWNMDiCO0oLSg00oVr2iRThDnmSC9mAaNYTZ5muOcfJD8e+JJ8/ij9adCrFlNWNRuhS4pDpWvvpSmQxUFZ5zTYzHeNeoJvDYMrANdaJEV8pHFJULRTnoy2RF8dxMXPg9EPoDkhH6rBy8NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233965; c=relaxed/simple;
	bh=ZM5qh60coOvAZ8ueCc/LD1dNGD+AXUez/JlWYtqHCxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C8aYNMBS7zcOkNvzxKTbgafBa6QCdynlNYNctks5LvSlM6WurO31fHtriZ1SInsjhdVMD/VN5Rvw6vVjLkrTGL67rjPA1wJeTKE1l5bbQlzZFOSKolSOpQsURnBVEOw2ng2FjYZOOnNKZEGvHWPHpPKhsBhm2rFRAItSDawv2Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=moSeIEEj; arc=fail smtp.client-ip=52.101.83.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bae9Se5PNSGDiUUtmAm76Q0HUVutUYtwLPkq+tSiekKyeu5vlZI8I94iHPOMnVB8/amhPjq41uEb2C3EWNkl8/1blmBJOe7B9ETOk0UjBbzeL3PW/lDpc7lCQC+R+Y03nBz3JU5dwzMEGeAvBRhWIq538fclygISdHBWqroCfYuE1jC5uFgeIDR6VSXsvBWfDPnT4TiIm08rRDar5e66eNY4W46Y/piWspbqrrOGT7of24i7Oq++tBDV9Cwec1Dv+vkChcpZXaDYqVvi1AKxnk2bxs1TV/EU6MOpTNizREC46CTfb+ZjvLo2g29kJkwQGu9MzfmpN0IIaV86THCUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDxoNUMdODn6Iba1EyyPMkVzH/YQNuLd2d4lMXV+lvY=;
 b=yh7aqAfMXMyDJ1coDFJnPavjJ4jN5l+hTuHUSTtoDh2amCE/DRaq0abn+j/Yb+j3G1YMdVcg16LPpa+hisdr/LWUZeXgn3KIsztatsDwDCcx9GLE8YELZn6A1RnqE0W0MN9wfSGFnsjpwwScwbAZrp0JgLPbnH4fd8yqRccIS13qVqIQh5qXOxvPDahA6g0iOCMR4Oi6oedl4+0GUEu2IdYnZCM4QacZcYR8wrtHO0oCN0rranXbgRa5nHrImV+oSr09Um+lQXLk9gkeM8tHRNyTUXkbC0R5kORs3uHsPoWn6mHV6JfoTbW1uj0BcEQ2i8fxQHIXHKj2wzfJpo9bQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDxoNUMdODn6Iba1EyyPMkVzH/YQNuLd2d4lMXV+lvY=;
 b=moSeIEEj77lonOYdF5ZXWsRV87UGmLGRwCFL+Xf/Glv4gk0j1YjLSkUWXI+NJRj/S8pc0M6whV8FEgXOt8jLyy1zEQRgU9R05AfmgM+WdKoOw8lkQ/cMU5/1cA8FJgI+Ez1eWPzXLwVDJEgSrtwySLTz+/LhRj2IDON2HveePmUcdf9McELKX/5naD6L2Hs4D+BUoQIhs9Uc+g2V1LxkHMZOWHUm6k4s8nfkuxON9u1GbuYZB45uBZVec5NqZypDFRixbV1Ty/03rDY3DQfhmllJDxZhx9QrdAgpjNNopSIoSAqgYzTmLEQ9Op3TLojJ+bi6TkY15s+Zqdwp5USM9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10909.eurprd04.prod.outlook.com (2603:10a6:10:587::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:39:20 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:39:19 +0000
Date: Thu, 23 Oct 2025 11:39:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 6/6] net: enetc: add standalone ENETC support
 for i.MX94
Message-ID: <aPpMICNkJUW8mVOP@lizhi-Precision-Tower-5810>
References: <20251023065416.30404-1-wei.fang@nxp.com>
 <20251023065416.30404-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023065416.30404-7-wei.fang@nxp.com>
X-ClientProxiedBy: PH3PEPF0000409B.namprd05.prod.outlook.com
 (2603:10b6:518:1::47) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU4PR04MB10909:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c90d248-a099-4786-2826-08de124a5508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CfiKaPgH8zfug8YT8eWjJ7Ciwvpyd/iPahBU6kOyAIsYVwIsj0rnLfyoJw0b?=
 =?us-ascii?Q?wUpXCgZcKOWdAaKi1ddKfQvbIioijI5scG6Wsah0iNwesXLhx/p1XhPuencI?=
 =?us-ascii?Q?QpR6WYrPtnbN1ahRHyo/jiYE7+uQEMUwLuGqZabnkF2mW9G5APBkeTk1q1be?=
 =?us-ascii?Q?W/IkRCbHCkQ/vyYA22xD401OBf/qhslqQRjERq3KhuxIvLr+k4cNcmRIcxw5?=
 =?us-ascii?Q?c2uJ4h3Ui1rc9cyvj2Es0ohnUn9JWMq+kU7sarmT+YXT8LkD9pJrVpryW4HM?=
 =?us-ascii?Q?pu1xtGRMzOO/Rfxh6kOMAlK8cFE3ROuy8V6Ho2BWAhM+X0h8dzNmMD37s82A?=
 =?us-ascii?Q?SWBayjiTJ8pl0Zz/1+nTlZrlcoH67BOfbUw4Sg0r/QHKi5oNtYDmhoWnLcf2?=
 =?us-ascii?Q?zrSfxYVAF69/3dHArQ5blJfndOZO99wqokpoeHceESVt/OO7Iy2lgVwQr4+7?=
 =?us-ascii?Q?cz3FkRypCHQRYQYl7IyIaBloi7cBV/q0Kh8mVpaAglEaiY6YujcdibscoRIF?=
 =?us-ascii?Q?2YZDWMsybYerFnEt/WGg2Kga3uGgxww3IyY6oY6pCec0EjxfWvrxEYp8W9qv?=
 =?us-ascii?Q?DW/oGkKghdIkWBqGBiN6Bf0cAWAR27wv+Ueta3GIPhzoL3pl+OOBZUWJs9Nr?=
 =?us-ascii?Q?FfcI7whPPRo7TP9mP/dWaSA4aLuti+zTK3z91oA7HBR9l4rtXR2lKsYiA56z?=
 =?us-ascii?Q?dDbMOsFP6zmudGjlbn8UrrhBoUy8b/pQSbvT0dY9GO0/rPXd28FR5ysc3+cg?=
 =?us-ascii?Q?Enbr5JrINdGMyMNmmXWnCau7BXIy16xSGf3uWVBxJRmmR9hKeNkpYfE+TUqG?=
 =?us-ascii?Q?HCqfonZ9vckFyvNw8kVTsNPmivs2PpKH5b0IrKQVY58OB/O4HT3VoTcmSOtW?=
 =?us-ascii?Q?VK1OErwfsIkKCU047LfcKrAmgSjMgxheAucgHYn6StVb9mCEd3rTPrei/StK?=
 =?us-ascii?Q?eZiYbRaY5+VXerscj0QDmMnPUpaYN11kICq5ebZru007EckpuvV0FzUZ69l4?=
 =?us-ascii?Q?c7ZTQXCUYqn9fv4wWdPVzzUzVAa1neMkznZTbjJzdiB5W2TVJ91zO8sbCn7b?=
 =?us-ascii?Q?oFtTpUp1Bl9Yg9QzJvqCu2SH852Z729/oLOsH6p+Hu/4RnoVggN+xSP5paYz?=
 =?us-ascii?Q?bqPulxOoYHI8Hip+Dr3cDC/6spJ/2uyLBdhvVb0q2WPAzVwwZe0eZjCj/eqa?=
 =?us-ascii?Q?MtkAJbxi+Pts57iuSSmKBRngNCMP+d2ZYUhe+gKOXoewMy2+SA1hi5K0WjGZ?=
 =?us-ascii?Q?8Cl0/qRzYcxuOx4RIHYGlOFiq6LwIeJHDCCRuN1mDUfh/iKkVoTUIm9dcPqP?=
 =?us-ascii?Q?0Eg/jXAoCxXTa8bLoHGnlDzFhq4djtQNVmbP5qEzLqUxLQTKlJKBHkshfyi7?=
 =?us-ascii?Q?TPP8WJqav/98PnDXMy5S+mv9EC7rTiUvhlIOVlQ/S2pTCCqEA3g6MZpj2QhY?=
 =?us-ascii?Q?RDYgBtfqMqq5qpCOkc4qIspFi5Iq2V13qngXCYtPLlZzJbGeFJyfUM5N45dv?=
 =?us-ascii?Q?JUx3f5zZdDU+BmHpqb28KGnIMk6WrfRdyK+i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gFZF56KobLWxJczF9cjwPNbg5TaZgnhN6/6rOG9VDh6POi+JOAaD+l1GTJBO?=
 =?us-ascii?Q?zUY3QO62pbqMOsKZqBeZHBr6hpJhxiUaYpnsnpaVQxETP6U90IgXaYQTtQCu?=
 =?us-ascii?Q?wgCF9EGYWYiwRp3df9/nF2u8RHL1mku2MdrFk/f7r6tMe4uW52O5vZzdz6OH?=
 =?us-ascii?Q?ADjUZK8kKwCrPL+KCXF+SAeCe9xznckHcqloQNAPnbJ2XORwsrwA7SAg6nBm?=
 =?us-ascii?Q?lkePMMtPhKBOKneF1dHl/y99ypOguI6QGDgkCSyA/em8JfM+WFco45i4tMMB?=
 =?us-ascii?Q?UkADSlvvwXagAxUrk0bX+kEFqGSfVnqgIWI34YFo351n2rrELSyUqxRR3ZHe?=
 =?us-ascii?Q?bm2Vu18XBPVvR3eNGDL9TM/wlaYC4hufvRxQ/h+s4YUmIHKFX2+VTfx+qsMC?=
 =?us-ascii?Q?cdZxXWgu6BOLx2iWZrDQwEqnXEZLloW8y0kmH59tcHJov87ekvSUqdKA3iRs?=
 =?us-ascii?Q?paLTGEU2AlmiSGHEucmVBfY9cHEuhgh2AbfzJP+Jejsv13FlecDBxenaBnrV?=
 =?us-ascii?Q?67zghd3Ox2Rm7OVaFyaGrKAi1A3pIFX3U2oIIxN+1OFENGjQa7KI2KYdLhZB?=
 =?us-ascii?Q?1AWCWZYmpBEvvNt6IOhowDo8p4T7YP/k+WnwQBjD0LCt770vQMegbeNti6/0?=
 =?us-ascii?Q?ufknuy53I45a1DPk+R2MdIva0OPPq+P32J5/PA5y2WQq6om8oR8mq8m8euKC?=
 =?us-ascii?Q?n/Lbl0Spg51LEG3NvDYJvDFcoVtMfTqyPz/9pwlkjfjGt4BLu6q/MJ7jkBxw?=
 =?us-ascii?Q?AwFxNN7CsM/hOUnbo5rQjRdq6Xy9H2Ug5BtbDiIpseqiwHcONdycvA4NguK0?=
 =?us-ascii?Q?Tp3eov3gpiHv0MbVaHN00O4sWY7YOQxk80kv5u7XnipCsehqMLUTXk6ixt60?=
 =?us-ascii?Q?OlF+PpTgc6f24UA5UFxwuuxZLJriCojuQL0ukjfjXaSaC+b5Dh09DKqC1rsB?=
 =?us-ascii?Q?qwzTo8lKaflSHqASyJ4AKa3Y0o82tBV5XYUzKY7WJwIg+qwif6ZfcwPHLUI3?=
 =?us-ascii?Q?TN3/KXVYgYQhJGosHrlNZcX0fA8NiMnbTGVOg0Af6iVaMp/wg96fKAmVCAMP?=
 =?us-ascii?Q?tSGiMdYNUpv0c212XuWpBxyXKNbDkAeroStIqiKBlJHBB5QH4uurpnFcjz6i?=
 =?us-ascii?Q?X+nKyTyid8ewFVB3nswpL1AskQn5PG5nd2rcHIvo9KHWhBbbUCj9hceFg1DI?=
 =?us-ascii?Q?qRlI7Jfw8JQIddCR2lxv84W5scJk4qONqCQmUMTUkxkHxPW8AABEOFYQYmGn?=
 =?us-ascii?Q?Y6YhXuHCSYATCLm/I45eQUwZ/Y1d3OBZSkh1CifNVxXjcb7K9ShfRoC9l/mP?=
 =?us-ascii?Q?ta2njwQHid3oBNQk42jvvH68bnXHPjOF96RH0IYnRprAP9HLfSqfY+4wRzHL?=
 =?us-ascii?Q?Ts/1d31aao421y2iYlb94ljlasZuVLXaoht3UrHrKkfeYFeYgC6H5yklFymP?=
 =?us-ascii?Q?JofskCRuzde3oTI/UJw55zDdDkd9pjeyBtQ/Q2Q4lDrGx1neBYhjpLITbPSl?=
 =?us-ascii?Q?/wnTTS7I9QW3cdaGAvCpJM5LAxho1U0sXF8cg/cuRFYsWams4bjcJXN4pA6+?=
 =?us-ascii?Q?VQtiDdYwkVm8HaRpjLk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c90d248-a099-4786-2826-08de124a5508
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:39:19.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrJL/1AaCG6Zl/1nKQ7fGaZMXN/Ig2V6wzr5qeeLeZR1DJTv0Cka6wrYSkBt+P0NvzAsQTwQYx0lCHrFMyvS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10909

On Thu, Oct 23, 2025 at 02:54:16PM +0800, Wei Fang wrote:
> The revision of i.MX94 ENETC is changed to v4.3, so add this revision to
> enetc_info to support i.MX94 ENETC. And add PTP suspport for i.MX94.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/net/ethernet/freescale/enetc/enetc.c         | 4 ++++
>  drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 3 +++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 88eeb0f51d41..15783f56dd39 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -3732,6 +3732,10 @@ static const struct enetc_platform_info enetc_info[] = {
>  	  .dev_id = NXP_ENETC_PPM_DEV_ID,
>  	  .data = &enetc4_ppm_data,
>  	},
> +	{ .revision = ENETC_REV_4_3,
> +	  .dev_id = NXP_ENETC_PF_DEV_ID,
> +	  .data = &enetc4_pf_data,
> +	},
>  };
>
>  int enetc_get_driver_data(struct enetc_si *si)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> index 5ef2c5f3ff8f..3e222321b937 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> @@ -936,6 +936,9 @@ static int enetc_get_phc_index_by_pdev(struct enetc_si *si)
>  	case ENETC_REV_4_1:
>  		devfn = PCI_DEVFN(24, 0);
>  		break;
> +	case ENETC_REV_4_3:
> +		devfn = PCI_DEVFN(0, 1);
> +		break;
>  	default:
>  		return -1;
>  	}
> --
> 2.34.1
>

