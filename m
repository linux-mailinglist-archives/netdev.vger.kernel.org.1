Return-Path: <netdev+bounces-207575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C9B07E87
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DE0566BD6
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE3D29AAE9;
	Wed, 16 Jul 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aZ6gzRAV"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31D264618;
	Wed, 16 Jul 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696372; cv=fail; b=PetiAtSoNalSgI2ROnxNS/fdJnIseQKAuPQSTkQrSpdMOkTMq7JMB2+n+gqFaswjhKBkqzR2A2tzYlfSdoQ7lFdmtEGH4twnTH7gVswsaBGEimiq53pga7+qxnsT9HmkozgvWLNSe3OiVWSqZWfIjIlek926E6jp+w/w4niiI48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696372; c=relaxed/simple;
	bh=L59RzpsqdHpWD0XUmLlO5DY44M3L8+A2hUWfS3OVs1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N7Z2ZyvSIbKZOLN0vIS6fo6HbDZxR8OUN8RJm+l6wFm7cs6nPamE9PzvLPPhWKUzejsWlKptHngT04PeAM1cO/bhcawuDKb2AUeKeK+sg3I605cbIUk/ge+uo/3IrSXiZR2YQMZyXtsUHPPK0PS9mO92t58ZR33e2Rof8vGiFKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aZ6gzRAV; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZL2U3Bt2GrTgckdcprMMLuWkTXDoz9+NeMrs4O/2Xc+hiJrxxgxfHLKuayGX+SifBLU/o5DcfJn3wHaFCE3t9/VCjlLtERt84CGTfvjCmwQz+iOVYIgFl8NtJZQWmREHZTHVf/B8SBUhYYSPyu0l8HqqoEsyJELy+LuroyMYO9RyCUkg3QMZjXBkYfqkgeguQkf03LkfqVerwy7/yDtTIqqxQ532BRKpKcdEKLLYneJ1Ym3cj5qk+nuXwB6ANWKtq/3/ooMHfKa3Ns9CmzBSPuXocmMgn7ll4+ewkoBE3U0Hliw8qUJouJCN7UpxWGYQpaLTprZTyO9WhFgIXWTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqN0OZLG/Tz7vVa0s6KYB4rjXXh4zRMH6EZPcn42hBM=;
 b=lA61lm4JKWgoaCyopkoBGdqaHKAedlk7sTCMzNVIebl/7H+Upi/XHxKnpGiFjtZkJrh5CqyVrftNmHICW8EqtPIgg3Nv8NiP/Qf5IraJkrB+ZeSggcpkjxPfuaS3ka9QW+BH0NcAxwP3+wBFk7vjOnJ8mrDe2GP0m5b5rxu46ghs8WNtPaWd/3Sr6cAE2Ja+zp1F5/t+VB6AdZtJJkV77osTwCePg9UxJm9+91k6fwUs6DFBXhHHri6F277Lu9OQIgpzClgyVDBPMncm+JqsX4aqoSB45Eejx5vxp4woB4xTDSGSvI1GY3Vh9J/kGnbGRHhNnlWpSuIvw7g+gh42uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqN0OZLG/Tz7vVa0s6KYB4rjXXh4zRMH6EZPcn42hBM=;
 b=aZ6gzRAVCPVVTdwfy4oQjSjjbtlPwOE+bQEronuKlvdizjlvK717lxh4+VvT3u3w5xkJfsIQ1HFltFL6obKtO28vXlXm4G+ps98mVZk/AWKmMdKhjGsopI3Y4l6OfLFDxsgqTjWab1n64UcGF6vEvPSRJSE3dEY4zOzg+fBmtSaBhawK0KhefYOXSOhRCc3adXdg0SXBgrGr6dtKYh8AM0ZXsxE/RwUcXdC9yPnda2AqZ3rRnrIA8rWGx26fFxgVNQbQjyYnRRKlDvu7PpFfKMV+8xk31WrEyG4nDfACkNAE0yyeki0lCipsWPihxwu+fiCH9TBcHPFyZI9OBu0+Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7265.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 16 Jul
 2025 20:06:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 20:06:06 +0000
Date: Wed, 16 Jul 2025 16:05:59 -0400
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
Subject: Re: [PATCH v2 net-next 04/14] ptp: netc: add PTP_CLK_REQ_PPS support
Message-ID: <aHgGJ6sia5Xe7AA9@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-5-wei.fang@nxp.com>
X-ClientProxiedBy: AS4P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9debea85-cfc7-4973-809c-08ddc4a4327c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xeX0YFWxU/4bl2l19EZipZX8+ekPbzi4EzIZJEWGW88JfaKL4gfiLyXAQZCq?=
 =?us-ascii?Q?EEmueQ+WNSWpqOKkeftZywvx3qwwnFYkSyTeaV9WhXIjC/Okr4q0wGQV61Ki?=
 =?us-ascii?Q?rvwuPaITF1sP3+wnUmF9Ibht78b/KvPPXeiOV+iHVwb8nfzu2oUeyjXEDqeX?=
 =?us-ascii?Q?3xviJOkwNECxJWXDUbwlTrGbKq6I8H2f3UCbZ4HwV+2WceNuP83F+dyEKWXK?=
 =?us-ascii?Q?Tr9ifF1Xl9TMNp6Eg4No3xGrhOm9noDCqafHqZY1cRFvV81TnHSZ9yHPs8SJ?=
 =?us-ascii?Q?Ia1BqvuuxzyYs4WqsILFYQjTB8tya98BEIB2PjnhCPpC2qBnLggXeebt55z6?=
 =?us-ascii?Q?sdn1C67zjQyyfB6frA/SARuI6ehXPzewQt+NGzCqlP/wmdZgjTGI+2pSj6yS?=
 =?us-ascii?Q?hM/EXdadClorCCpvF2K/k45WtGZSnLMVhHLJlCgIKAFiCvmZcFbgVU07wUd2?=
 =?us-ascii?Q?YbTawyWzaoUiCU8ukiM1F1JAEsfLcT3mGKbHYp1SkI2VGdv2TxL/mvHmyFlh?=
 =?us-ascii?Q?P/NKujWdAiXobZISUH+upV/r0a+g4sabKcVwSRVyfUmh1qP/v4at9txkSqfa?=
 =?us-ascii?Q?m1lez+/KmXdpnNaTh49Ri42PnZWTL2IX5S9y1/lKgX2TbdXz+Ifmg9JUMDiw?=
 =?us-ascii?Q?mvhDQJp/dCio0j9F9vZh4BLYqARx4BDSKpbRBrNjbPSXIBFoM5mTNoPx5jmF?=
 =?us-ascii?Q?Lhop2jCEdUbzISyF0TqKAQgwYzrwhf4FdTvnDIYdhYB1tkkbsg7dbAqkh0Jo?=
 =?us-ascii?Q?V2uAXW277Atrp/QYgw98dKIljVuRD2j+FxLMDx+TzZGUk2yivzNjd0kY7YF9?=
 =?us-ascii?Q?Bakpiv0q+5NgvxzYdHnHMkzivZN2BZmgzuVx4bQVnYmEUfIbA1xbnwnPbQbp?=
 =?us-ascii?Q?SeVdjl4iLTrHQcBK0UlecPscSZOkzOnijxhHZWyiBFs3Kt6pZCqksmmXSDvL?=
 =?us-ascii?Q?LLysEWTQGRjmpYixVa0ObRabTtMaxV4/+q2HYw++ThTTfcfqVf9GasiSX56s?=
 =?us-ascii?Q?8Unlq++8Q0A2U+7WUhGOfmsZWwDQRtvjrj4bWxCsTZyFshVD0VcjoMYsumLC?=
 =?us-ascii?Q?548UpSzUzFsmWI3x2Ec0Dk9fXZsX0kGY8JsiAhF7WBn7LuGru/7v46KrPUp9?=
 =?us-ascii?Q?zun6AHC3r0x8IKWMjdqNNRLB4pQpXrBUBVsahXfyVzqfgZCw5v/MXco2nj81?=
 =?us-ascii?Q?qSFfVY0u6P5OPlssEGf4xCCKjgNkPtIP14VS32Ke2iA4KBg5BoeghT7hLnMc?=
 =?us-ascii?Q?NrNCiYejh0Pgx5i7w8UPF4xU91aZaw79yvvAJtyDjmzrAuU7m1sUq8YiI40U?=
 =?us-ascii?Q?9NeKnULIIWhYiME9lt3XcKNQkG3OprKFuAekbsXe5sbvzf7HWDIpgWUavA0T?=
 =?us-ascii?Q?ra8zXKu6O8ou2BcoMGCwrFFi4Pxh3OgHyESLgfmuIyAhP41wHOhrdPxVzShy?=
 =?us-ascii?Q?zdhujsUI2YJihyFS7ZqibnbTc8uwxAFAOuTHb3r6n4vMtcRi+IdsHkNZBolc?=
 =?us-ascii?Q?kVVWF61MgHPr2cw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ll9v6zH5F0+9hZVF1AxeYSAFi9L5FwvcFlFI2ISwCi3ri5izX87SZ/uNNWuK?=
 =?us-ascii?Q?8n67a75rYM7jSCPMTLJ5ZvdlAQRUUWXcRflp3sH9fS5lqFSuaeGY8wE39HaM?=
 =?us-ascii?Q?J13LFKhCF+OtK/xDg7GLHeYpde1P5+C4hPfmwSribbrBpELb4dQxyaV1QKoT?=
 =?us-ascii?Q?pW3dMZw1cYmQ5zY8lwlxx+Cdek442yk/Ao/FU/ftJ5Ycl37UmdsoDyVtXxHA?=
 =?us-ascii?Q?YBvQxURiKGkRQqXkJWSlesTIhfLQviu61xQGEM9TPoIbpuVClVQv5GLQoV43?=
 =?us-ascii?Q?9hvhKzopdwU0ueUzIokfT38e4HIaKD5FQIVsE7rueNGY64gWRzDuZ/yPlBd/?=
 =?us-ascii?Q?IaR7Ho+I/C6XAODRjsNrZ8wjnO58qBD7ectgNZ6XNOWj83tOYsVjQWwd08zy?=
 =?us-ascii?Q?j9iIp8aGuUBWvquogpLM2NwQu2nD3yr973HRd+Md8RN8G6EaL+G5RFoauPW3?=
 =?us-ascii?Q?/Rec4JmK6gcLcViStoczqGQP3QpYfGaVOrcveysMOt8OjGZhLq6dJgBvFKd9?=
 =?us-ascii?Q?TmNxoKn30PlB3P5jIl38g4naXLkd+e4OTStqVe6cEhkFx7pYFUUIJtdWOMCT?=
 =?us-ascii?Q?SMvPy8NbBpUxtD87QonCdVPBZMLhtXfk26lXK8Wcb2dbdTYkw11nLq2PLT9A?=
 =?us-ascii?Q?CdB3grt4y82oN9x2tBaRo0xE7SWn9ckRG4tBtDcIO5/BQEjzqRN1fSt+3Tuq?=
 =?us-ascii?Q?ol09ptIdkMS/CFdbLhWyJ1jBfiB4vYNMBNqjRPooKWn4GqjOS3AGFCj9aBVn?=
 =?us-ascii?Q?U8OibX6xLdqcv638EJgHDUwqhShuXG/+w0eym/jA6vhscajtKiISY6XOk2SS?=
 =?us-ascii?Q?lw2q4wfxbhWNGXKvonTqHZwGWLPV5rMaoR9/E2Qffh9fyxoC053k4z04X0QB?=
 =?us-ascii?Q?vcJv9A4Jdnq9OxEFKuCDNCR6t4n1FKCwenFmdCPJP0XEWNz5OpYo+i0QKkSK?=
 =?us-ascii?Q?GvsLTbeAQ+aoK1CZcvMkFdzHTruPdhFceNZ968NuB9wvkmNvvhrUHTgFly6/?=
 =?us-ascii?Q?0COgLUPG/K4ajKShINt/AmivaghTmkvoHt1FAUDWTnmPoHlc/CgtrL0I8rOv?=
 =?us-ascii?Q?N9/nB/wgmnl4xUkbg2c7z1MOH5+soeZfQlwdEMf6Hg2e17qTiSbddty4uSpO?=
 =?us-ascii?Q?bvuOeJoj96UFU2WHb2aoWcCvVBsaGeWfdITqOFEWoJQYyqFOqUFMlK9RU1Wg?=
 =?us-ascii?Q?C48NOZfsJrCFWjbqk3XLeWuTBohsK+VdXIaGlSPsTspwcfn73RsgkeaTwiKy?=
 =?us-ascii?Q?DySPA6u0+8LA5cDdcJDhhF2jG4OFjOQAtr1909yjJtfK+hthEHPJej4bzq4C?=
 =?us-ascii?Q?xtu6fXCvd2z9a+f2wXl4ypILTj2rCHYJR4v8+7qHF74n7VCd42HQMXlUOGGC?=
 =?us-ascii?Q?tROyWVm4YudOZeGO+bruXS/gyewUUiubRVgAIaViyIUU7agu2I9ZiWUpieod?=
 =?us-ascii?Q?g2cWYrCCrM+R78GA2efw6tCAecUpm4ZpDGzH5yrxGRE2DNChvdue1/mFF+ZP?=
 =?us-ascii?Q?meiI51WosRj0IYXDdyz7VDWA03k7WlRH5o2mZ90b+IIQJUXL4Mbtm4G1SO6y?=
 =?us-ascii?Q?kP2H0DD1R1X1qICJlQkkFtX+e3JPNe8Pn+TH5n1M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9debea85-cfc7-4973-809c-08ddc4a4327c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:06:05.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRQy7gNQOmhQtrk7JKWD1oTLwqHlPFnz5vmJY40rXzmwK6RX8Par/XwsKeW/8VkdPzQ/8YM/YzrfSpryapptjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7265

On Wed, Jul 16, 2025 at 03:31:01PM +0800, Wei Fang wrote:
> The NETC Times is able to generate the PPS event, so add PTP_CLK_REQ_PPS
> support. In addition, if there is a time drift when PPS is enabled, the
> PPS event will not be generated at an integral second of PHC. Based on
> the suggestion from IP team, FIPER should be disabled before adjusting
> the hardware time and then rearm ALARM after the time adjustment to make
> the next PPS event be generated at an integral second of PHC. Finally,
> re-enable FIPER.

Add PTP_CLK_REQ_PPS supports.

The suggested steps by IP team if time drift happen:
  1: Disable FIPER before adjusting the hardware time
  2: rearm ALARM after the time adjustment to make ...
  3: re-enable FIPER.

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> 1. Refine the subject and the commit message
> 2. Add a comment to netc_timer_enable_pps()
> 3. Remove the "nxp,pps-channel" logic from the driver
> ---
>  drivers/ptp/ptp_netc.c | 176 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 175 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index 82cb1e6a0fe9..e39605c5b73b 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -24,6 +24,8 @@
>  #define  TMR_ALARM1P			BIT(31)
>
>  #define NETC_TMR_TEVENT			0x0084
> +#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
> +#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
>  #define  TMR_TEVENT_ALM1EN		BIT(16)
>  #define  TMR_TEVENT_ALM2EN		BIT(17)
>
> @@ -39,9 +41,15 @@
>  #define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
>  #define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
>
> +/* i = 0, 1, 2. i indicates the index of TMR_FIPER. */
> +#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
> +
>  #define NETC_TMR_FIPER_CTRL		0x00dc
>  #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
>  #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> +#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
> +#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
> +#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
>
>  #define NETC_TMR_CUR_TIME_L		0x00f0
>  #define NETC_TMR_CUR_TIME_H		0x00f4
> @@ -51,6 +59,9 @@
>  #define NETC_TMR_FIPER_NUM		3
>  #define NETC_TMR_DEFAULT_PRSC		2
>  #define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
> +#define NETC_TMR_DEFAULT_PPS_CHANNEL	0
> +#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
> +#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
>
>  /* 1588 timer reference clock source select */
>  #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> @@ -75,6 +86,8 @@ struct netc_timer {
>  	u64 period;
>
>  	int irq;
> +	u8 pps_channel;
> +	bool pps_enabled;
>  };
>
>  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> @@ -152,6 +165,147 @@ static void netc_timer_alarm_write(struct netc_timer *priv,
>  	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
>  }
>
> +static u32 netc_timer_get_integral_period(struct netc_timer *priv)
> +{
> +	u32 tmr_ctrl, integral_period;
> +
> +	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	integral_period = FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
> +
> +	return integral_period;
> +}
> +
> +static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
> +					 u32 fiper)
> +{
> +	u64 divisor, pulse_width;
> +
> +	/* Set the FIPER pulse width to half FIPER interval by default.
> +	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
> +	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
> +	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
> +	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
> +	 */
> +	divisor = mul_u32_u32(2000000000U, priv->oclk_prsc);

is it 2*PSEC_PER_SEC ?

Frank
> +	pulse_width = div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor);
> +
> +	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
> +	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
> +		pulse_width = NETC_TMR_FIPER_MAX_PW;
> +
> +	return pulse_width;
> +}
> +
> +static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
> +				     u32 integral_period)
> +{
> +	u64 alarm;
> +
> +	/* Get the alarm value */
> +	alarm = netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
> +	alarm = roundup_u64(alarm, NSEC_PER_SEC);
> +	alarm = roundup_u64(alarm, integral_period);
> +
> +	netc_timer_alarm_write(priv, alarm, 0);
> +}
> +
> +/* Note that users should not use this API to output PPS signal on
> + * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
> + * for input into kernel PPS subsystem. See:
> + * https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
> + */
> +static int netc_timer_enable_pps(struct netc_timer *priv,
> +				 struct ptp_clock_request *rq, int on)
> +{
> +	u32 tmr_emask, fiper, fiper_ctrl;
> +	u8 channel = priv->pps_channel;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +
> +	if (on) {
> +		u32 integral_period, fiper_pw;
> +
> +		if (priv->pps_enabled)
> +			goto unlock_spinlock;
> +
> +		integral_period = netc_timer_get_integral_period(priv);
> +		fiper = NSEC_PER_SEC - integral_period;
> +		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
> +		fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
> +				FIPER_CTRL_FS_ALARM(channel));
> +		fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
> +		tmr_emask |= TMR_TEVNET_PPEN(channel);
> +		priv->pps_enabled = true;
> +		netc_timer_set_pps_alarm(priv, channel, integral_period);
> +	} else {
> +		if (!priv->pps_enabled)
> +			goto unlock_spinlock;
> +
> +		fiper = NETC_TMR_DEFAULT_FIPER;
> +		tmr_emask &= ~TMR_TEVNET_PPEN(channel);
> +		fiper_ctrl |= FIPER_CTRL_DIS(channel);
> +		priv->pps_enabled = false;
> +	}
> +
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +
> +unlock_spinlock:
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
> +{
> +	u32 fiper = NETC_TMR_DEFAULT_FIPER;
> +	u8 channel = priv->pps_channel;
> +	u32 fiper_ctrl;
> +
> +	if (!priv->pps_enabled)
> +		return;
> +
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	fiper_ctrl |= FIPER_CTRL_DIS(channel);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
> +{
> +	u32 fiper_ctrl, integral_period, fiper;
> +	u8 channel = priv->pps_channel;
> +
> +	if (!priv->pps_enabled)
> +		return;
> +
> +	integral_period = netc_timer_get_integral_period(priv);
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	fiper_ctrl &= ~FIPER_CTRL_DIS(channel);
> +	fiper = NSEC_PER_SEC - integral_period;
> +	netc_timer_set_pps_alarm(priv, channel, integral_period);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static int netc_timer_enable(struct ptp_clock_info *ptp,
> +			     struct ptp_clock_request *rq, int on)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +
> +	switch (rq->type) {
> +	case PTP_CLK_REQ_PPS:
> +		return netc_timer_enable_pps(priv, rq, on);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
>  {
>  	u32 fractional_period = lower_32_bits(period);
> @@ -164,8 +318,11 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
>  	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
>  	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
>  				    TMR_CTRL_TCLK_PERIOD);
> -	if (tmr_ctrl != old_tmr_ctrl)
> +	if (tmr_ctrl != old_tmr_ctrl) {
> +		netc_timer_disable_pps_fiper(priv);
>  		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +		netc_timer_enable_pps_fiper(priv);
> +	}
>
>  	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
>
> @@ -191,6 +348,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> +	netc_timer_disable_pps_fiper(priv);
> +
>  	tmr_off = netc_timer_offset_read(priv);
>  	if (delta < 0 && tmr_off < abs(delta)) {
>  		delta += tmr_off;
> @@ -205,6 +364,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  		netc_timer_offset_write(priv, tmr_off);
>  	}
>
> +	netc_timer_enable_pps_fiper(priv);
> +
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
>  	return 0;
> @@ -239,8 +400,12 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
>  	unsigned long flags;
>
>  	spin_lock_irqsave(&priv->lock, flags);
> +
> +	netc_timer_disable_pps_fiper(priv);
>  	netc_timer_offset_write(priv, 0);
>  	netc_timer_cnt_write(priv, ns);
> +	netc_timer_enable_pps_fiper(priv);
> +
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
>  	return 0;
> @@ -267,10 +432,12 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
>  	.max_adj	= 500000000,
>  	.n_alarm	= 2,
>  	.n_pins		= 0,
> +	.pps		= 1,
>  	.adjfine	= netc_timer_adjfine,
>  	.adjtime	= netc_timer_adjtime,
>  	.gettimex64	= netc_timer_gettimex64,
>  	.settime64	= netc_timer_settime64,
> +	.enable		= netc_timer_enable,
>  };
>
>  static void netc_timer_init(struct netc_timer *priv)
> @@ -429,6 +596,7 @@ static int netc_timer_parse_dt(struct netc_timer *priv)
>  static irqreturn_t netc_timer_isr(int irq, void *data)
>  {
>  	struct netc_timer *priv = data;
> +	struct ptp_clock_event event;
>  	u32 tmr_event, tmr_emask;
>  	unsigned long flags;
>
> @@ -444,6 +612,11 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
>  	if (tmr_event & TMR_TEVENT_ALM2EN)
>  		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
>
> +	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
> +		event.type = PTP_CLOCK_PPS;
> +		ptp_clock_event(priv->clock, &event);
> +	}
> +
>  	/* Clear interrupts status */
>  	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
>
> @@ -506,6 +679,7 @@ static int netc_timer_probe(struct pci_dev *pdev,
>
>  	priv->caps = netc_timer_ptp_caps;
>  	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
> +	priv->pps_channel = NETC_TMR_DEFAULT_PPS_CHANNEL;
>  	priv->phc_index = -1; /* initialize it as an invalid index */
>  	spin_lock_init(&priv->lock);
>
> --
> 2.34.1
>

