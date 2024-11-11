Return-Path: <netdev+bounces-143658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3379C37D6
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 06:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DC61C20AA8
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAC254738;
	Mon, 11 Nov 2024 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="u7mEuVwm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2136.outbound.protection.outlook.com [40.107.243.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F0A933
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731303211; cv=fail; b=oKWxXNK4M0PKYsFf/H9nh43Mixbg2BrVTxgdC+I38fOTDIqpFVoy10biTXfu/PIc8mvpL/k6J/B64Zet4apqYAEXPkms+sgeYz80w4pWhhpbsP/ewaT8+MIAzZjBIhL45Zx0Elb6JRIRGR5mupZ+SVzPYYVvB+0d6Peh1cmRyEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731303211; c=relaxed/simple;
	bh=sQUD7JY5xIZEUf8ieuxXUFjzwFlZDn0f43cQZHJ6gKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nl5P59/CotRD9FGZBzoJYY3VUfA2+ICoH+WyVrVVl6Odi+P9QYF6IVq1Fzxj/LmYOyc09Ra5+MledyE5XwYGTDsc27l8pwMjmlKr9GObya/1spb7Glg0u1Z3H9nIoYklOYyE32A0e8rGtxGxLThwP1O0e7yJqI2hIRB31EeLIsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=u7mEuVwm; arc=fail smtp.client-ip=40.107.243.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQlIrHP2Mlbp0lfB85cd0y7lyWJutxRNYjnYby+rhpq37rhV09710H0YwFuKwDH4P1f+pUl5UAzY1zaJF1Q9eBHYE2BQPwB26Inx+ZX6wEoI909HwTSSGXBLvBQY3bUqrzYEr0OZzW+PGg7dg7mYBsPYvTHx3N1t+0zfuKt+LdiabK6EIrafHRPpriYtCXwki6grSZuZi++tcBjqB9uixyrK2fJJT8SqfeKItrlDuVbZAPBhjnSXhQuShiVmVH9g/kHd+BI9POIirdZUZ9IZeaBl1xZ43ntr4mphrLccNwpSKZsdjGHHyCnmpJYhumYas2g2kyIBiSfphuxu9vFOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doubTW/A6FO02PQY9DEYEz2CqaFXEPAik4917/mqcbc=;
 b=eh7WmvN1mHRSSmMT+ueSbNksNA1P6LvNZHBh/43/KAWpKYFCxzwrISS1S6g06o4sHKrUhEFWYMT0ZRvRX9TCzdWY6AUANYgd+3OBFjFQM6kamw7ZKtAhI3tfhwCy67qynzz/nY7fGdB0i1qRjpzxFF7GwYviNCEbrUcZF55mRoDW09JVrR3g/oT57jdH33EPq+qmS1niKB4S1+6xEsSF7m2klZi6btW6lJDyJoGCpeR2yTcFLZDz85AxD8hln/VISifLS6++xewjtxaCBwYS9nrQzMdXKo35t8ZIX70xLB/BN+8+FArf68xKeu7i30JAA5Nn6oqDNDoA/f/YnFJF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doubTW/A6FO02PQY9DEYEz2CqaFXEPAik4917/mqcbc=;
 b=u7mEuVwmz0qM3OEMJuMFNNxyF8IeB42Ov/bRCsOkehjG3/FDgwYT+g9JELEekP/H+AL1zZGk+vK+jhujOANruDfmgWQYuo5KWy7+y+d5tazaDa2WlbTkapH93aLSNNPaVKv6xQzxFrmsvdcXtwZGC89VBIKwB5/oC2ZUU5YLny4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by PH7PR13MB6413.namprd13.prod.outlook.com (2603:10b6:510:2ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Mon, 11 Nov
 2024 05:33:24 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 05:33:24 +0000
Date: Mon, 11 Nov 2024 07:33:12 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net] nfp: use irq_update_affinity_hint()
Message-ID: <ZzGXGEHCPUet3Jqw@LouisNoVo>
References: <20241107115002.413358-1-mheib@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107115002.413358-1-mheib@redhat.com>
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|PH7PR13MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: f318289d-3791-48c8-9e09-08dd02125c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EWccOKOxt5n8nE/PsKbBIzZx43Sc871DQuaPqtnFRfDdk9uGh2h9vt2BcD4t?=
 =?us-ascii?Q?2Ia9llBdd/BlOlaNywapBnPUeRPpxtUjP36a83qPZvQvSUyqaTFMGmCR7LvM?=
 =?us-ascii?Q?DjRpwAXWHMHg+INThLJUeg4PnLfVXY5ZN+BwYWrNl2D3xBqfNqP05ooSum6E?=
 =?us-ascii?Q?Xuhpa8Wg+1zidgh9/N2x2Tl8A2KNogDm6K1hcJ0LqE2gKWGouc/VQLu8Nhkp?=
 =?us-ascii?Q?tBm6MQ4g32z4K59w2er9SsSz5Zizwdl8xbNAkKQsxIwGglH2v9mhR1CkB2e4?=
 =?us-ascii?Q?b72kkvQQBUHwRlcsY+VK+6gWkJXBweRNcI+F7lu/4hEqb1LUTV7tVNqPZ9OE?=
 =?us-ascii?Q?SK7FfQvE5y1zebyw0MnJ9lmc1MMxKBpELLDy6Umy+fu+mT5TSQLT8nLR8Xs7?=
 =?us-ascii?Q?93+j6J0XI1wbhyjzARpdieobhyYVDjK0069XfHRSKNmuSxPl8UDYQpSJDn1L?=
 =?us-ascii?Q?FUPy3vsbThYmS6HvSfkpLvAoqIw3d3xnxIlSMNRD/J31n62s2R8cfiFZ9nWX?=
 =?us-ascii?Q?yhc5OzuKDI9H2aMpEtFEqZkP4pc61h/OlCR0reN0/pH++Yv0bLIcLsASOdau?=
 =?us-ascii?Q?xJFGrUiiCsWmbmzyiKgn8aq/2DeCAbgOQywzIhXfvianf7+DI6pzHF/DNqeN?=
 =?us-ascii?Q?7+1PXqAQM8Hi3DrOKhqYm6/Xhx6Jik+Ie40dcbI7cKXLrKV34ZlQYQJoj9+1?=
 =?us-ascii?Q?uHE8O4CxwDDKsARflg611vXLumwCZWu9bpQB+XTUQJWo7vuEpGbNlD+nPbad?=
 =?us-ascii?Q?DjB9L8QR5FOaujs+qeexF/lJ0M51TvWv5MhalPai5uV2WSeHp+HUfA1IcmK/?=
 =?us-ascii?Q?tY41AiJ1/FxnGFqnGD7owTAHm91caFXqg4qPvHST+IUdZgoOGBUcGhwXgZhy?=
 =?us-ascii?Q?r2YNtk6Kj3sazwrupC2GpDqLF9or+ln7Zb3ysaSr9M8cyBFDhosSvA/0LeJG?=
 =?us-ascii?Q?mQ3Y5OIR+hvZf7RIdN/Klm8ckGi980IxwgJHDO+hBGGO3EY6VjgsagUuqFpw?=
 =?us-ascii?Q?huAePbg7c7AD6Y+DuST286R4giNPtU52LbwdlwsK8/Mq+YB/czWIp+8QOeCl?=
 =?us-ascii?Q?u1BpEWmYj+rgXFMAqVx09bdmignJPXvX6YZcUmfDBkxmw1SgPFyrhwUuyjeE?=
 =?us-ascii?Q?c6wqVOmzK3SpqoBhU5+z4MU3wBDuJCDHvLPQe4fvGyRvq4+FhZh5RgI3r3+C?=
 =?us-ascii?Q?7rtql5eB/G+qNXnbZcOMLcL8wnRl4mu/uoSvHToubpeELEK/YzXEgdsKVUbR?=
 =?us-ascii?Q?movnb8nE1Yge5AsfMJKSVBH3TosCctGrTUShlF3hQ+uoUlwFJPeNX41yf945?=
 =?us-ascii?Q?hf4/sxHWxckTuskApKs/Rw26?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C+TAOgjL3+m2YSXU+MkshW9OvEWKFYOFMpj3kBNk3NByfXkU4ijlUJlV9qwf?=
 =?us-ascii?Q?L2PrykRFZX1C8GY+nljcJ0QIwFJAYUQScznzWpuX28iRsGsFuxJdbamD2DRT?=
 =?us-ascii?Q?zHyNFddQ/i92/uYNnZBJsdAeqijZlsHvhKEiLwJcbj3IotfHFHlnAE+z33mZ?=
 =?us-ascii?Q?0b9ikN0uEodR0ZYl9cs6l/Vn4diANp8TN28zUsKWKux4FrTjL7oCVu9+52Sw?=
 =?us-ascii?Q?bUoC3oDtTTR7d6Jtqa5QMjylqkd3JRReqsvGmGtnLEsJe5A2sy8+T1dk+KHL?=
 =?us-ascii?Q?XmdPCAM0KHmhcCeVH7j/wMtA60PEdiUkjO48/S3nshnOtcVloC7mvFKUyvyr?=
 =?us-ascii?Q?dYROGnMOlQ2k/IrwhskfrjoXNy/M84kd8tmfYQuv+N7klteuvwwBh/5iuSX1?=
 =?us-ascii?Q?m29Dr7N7RNrHnWC/mTwN3TnkIbxPtHi6gMNDH2DSbaqCYJKjVGYdhTWOIIOP?=
 =?us-ascii?Q?xfm6UX3WiueW19/bAR0dBw129a+8CRRiuwpgnUlWnW/LxS10aJTKW5+wFR7f?=
 =?us-ascii?Q?DypHNNE/5EGYTQLYbJRB2VIAw3EeGdr8NnBQi5YSI6K2s5IwhB0S7Iic3/hR?=
 =?us-ascii?Q?4nckH5EUvZfoiMQMVy6CDOp91YfUFgeZWSfADiu5k/n+kbBKhWegnCg1k/SE?=
 =?us-ascii?Q?TJEu/EZ5asotIqic4DgdZ8UWyx0umPAa0dC1ZpLeREqAtj0nONngvRW9k1Ac?=
 =?us-ascii?Q?Ji3ozwx7+AISn1mioYeAWrVqF9jLtm0FmehNmHGppJyKYUySAx9zuTSn68PF?=
 =?us-ascii?Q?eQsLS/+TxsatF5qmpKx3ZNMFdHbDBVate/4XQbHu+5ZnViq8p1GkO53R39ru?=
 =?us-ascii?Q?eqVKbZ3OqHBX2KoFBE506soI0htW452LjlDGj+GHpQTyUgYMTOFT0EDCAybq?=
 =?us-ascii?Q?JVvZ8F7FRF2SIE/qCYzThsOjzEnKscOmFuncH+RlbslcRSAdg3eySEzYUwG4?=
 =?us-ascii?Q?VZfxeH6bjEhZVhSdWzgp9KGvLObllJEOibat3NSrWP2Hn0WAjd+4wOaP+ECo?=
 =?us-ascii?Q?H2loiVWIpOR/C2VAy6ImP+iKtzQ+ZO90E5rDSJKzA47/uEUmD+1gVK/3ZGVP?=
 =?us-ascii?Q?LaqDWFsAH9fuoeGhvE0zkENLU9DhS8LMNSKGL54qw/aAab4CYsxTQDGyRYF5?=
 =?us-ascii?Q?oklyEdyV3LFAnxQTWnQifoOtMYyPr6e/HKgtUfmKD7LGXCWJbzaL2hjYVbd7?=
 =?us-ascii?Q?wfQSd+YioZuPOf/41Z162VAAnzfvzWJMq08md4q8zMXsdOBqP0gETi7GfYkC?=
 =?us-ascii?Q?wQSVbp3DkfsT8a94NB/ZvQ6uePLYANIkMAjjRMVmdZU0zUVJFx6TVbDFdtHS?=
 =?us-ascii?Q?zipnfOUsGtvbDc1LcEz5cHNaKvV/GBqlTztried1dwYI8TFV7fJURBjsW5ew?=
 =?us-ascii?Q?vzsoi5TAiIA5YjKHRlm1GTzMTi606+BxAfPVtQDIZ0W83hyWj6drfUqqV+8S?=
 =?us-ascii?Q?GF155GI901ARDK8mzc1QXJtMuEMBfd5HQXQSDGzLv9pvxTpqpg4gyTNUYm9u?=
 =?us-ascii?Q?4q0sNwjBrr7CJPtLsemiQKB0OuMU8HpZq0cbysFb0bK0ongTK+zEQ4XAOBib?=
 =?us-ascii?Q?FbPKCiB4cTEOAHvnMQwnbmgNoiXXuMgWZZnMMyX8Ih/7uywh3Q6TJbBn2JR4?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f318289d-3791-48c8-9e09-08dd02125c44
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 05:33:24.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5J6gutNnMQsQYavX4JXju0nMYJ32+7zSClz+/wY3u0PhIF0r8rq8KlJojhMV+CdQ/TckzTRtypSMuxbGkLYFYRbUTkTSELS3eKhAtV55k24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6413

On Thu, Nov 07, 2024 at 01:50:02PM +0200, Mohammad Heib wrote:
> irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
> instead. This removes the side-effect of actually applying the affinity.
> 
> The driver does not really need to worry about spreading its IRQs across
> CPUs. The core code already takes care of that. when the driver applies the
> affinities by itself, it breaks the users' expectations:
> 
> 1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
>    order to prevent IRQs from being moved to certain CPUs that run a
>    real-time workload.
> 
> 2. nfp device reopening will resets the affinity
>    in nfp_net_netdev_open().
> 
> 3. nfp has no idea about irqbalance's config, so it may move an IRQ to
>    a banned CPU. The real-time workload suffers unacceptable latency.
> 
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 6e0929af0f72..98e098c09c03 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -829,7 +829,7 @@ nfp_net_prepare_vector(struct nfp_net *nn, struct nfp_net_r_vector *r_vec,
>  		return err;
>  	}
>  
> -	irq_set_affinity_hint(r_vec->irq_vector, &r_vec->affinity_mask);
> +	irq_update_affinity_hint(r_vec->irq_vector, &r_vec->affinity_mask);
>  
>  	nn_dbg(nn, "RV%02d: irq=%03d/%03d\n", idx, r_vec->irq_vector,
>  	       r_vec->irq_entry);
> @@ -840,7 +840,7 @@ nfp_net_prepare_vector(struct nfp_net *nn, struct nfp_net_r_vector *r_vec,
>  static void
>  nfp_net_cleanup_vector(struct nfp_net *nn, struct nfp_net_r_vector *r_vec)
>  {
> -	irq_set_affinity_hint(r_vec->irq_vector, NULL);
> +	irq_update_affinity_hint(r_vec->irq_vector, NULL);
>  	nfp_net_napi_del(&nn->dp, r_vec);
>  	free_irq(r_vec->irq_vector, r_vec);
>  }
Looks good to me, thank you!

Reviewed-by: Louis Peens <louis.peens@corigine.com>
> -- 
> 2.34.3
> 

