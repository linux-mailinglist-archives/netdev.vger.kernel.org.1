Return-Path: <netdev+bounces-142946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7013D9C0BD4
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEED282D8B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D136215F5B;
	Thu,  7 Nov 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cbEREGZV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B0215037;
	Thu,  7 Nov 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997527; cv=fail; b=GcAgXGCJf3qgtpUkIuyFgdewA1ApPzuf9LxQsI9RZA98I/Edw/0NU729QilOez3Nm8X/CwmNjimhJET2ZMcl/DoLAQTbnsl1SCmTeixSWRIZm2H1iJdHwoLzLJd1hQpb3N3hOEannS+dnY9ASuDYEePpAHHp3HvcDtoPEDLlpZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997527; c=relaxed/simple;
	bh=yW3/VOEWphvqv3KSPJrAacph5rb88SA/3AvX9KS+DL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RC7UZd9h1MfpFx5quhRpoSwHQO+ZGqM4WU9wdv4MMs5RIdV7nSU9CjNFj9zuJkj4/FZnZFl5f1x/y9CkhUeYY/x0o6116IcEqPx1Nx6LFqAWkzbWB7liKdFruUoQOjMWJ09BYdQyKwTun65BHthNorxtCm3x+Vqkx/QLtPLltJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cbEREGZV; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAbHGLUhhIwj85gmY7EBZNTR1g5UBsz+I8vrgiZTmgQCaTU8U9hkSmzxOuYGYR3n/cmzMLfUlmcCehgq92XbhFMShCIvJwtE6rElROQjKcbpmCgdLPAkUySBF9NJc8uXa54BgblCHwPkryqg3A7vyqH3HlKkIKz3qkRSYdXDfqO3WYPDJdbahNCWX2Wp//lkl2NuXEJjq8vnZ9yDFw5Uew0NfYTxWOW2sn9eDBteQjlYf3dPSFf/a9Aeb4VxCa98sp3A/NVnxYt6JLRCZfE9gFsSkOeBrI1UAcZPNoBCQSAn4GIUhHiwrbTdnwUq9TJU3zwCY5VQMBng9a3GC/Rw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhv22y6L2lURikotIrbe8oVuxAoAWbx4dPLrxJlbfW8=;
 b=QmLZ15Qmi/YpRN7kvYfGjRnfijrt5ToADJbz2oErS3cSkuE9YESWzAyCeZHZfBrzo426VAiEFZW4hesFJ+xzqjgGC/HVEj5VG0pirvq9YTSX9b6phPAF4XpDlYISkk2qzZDpUoXdV/IGUTg+aI2NYBMSHjOuZCMCT+N6CmjW1Ql+0pDaET62L9eXkT27ANkp27JfXq1XErc1w0B3Nq7AhvtaTxJ2/qauN7nsShCur8cHoUbGzYCb1H03L+Heeodmd35H8YLxaaSab9wftKbDtn+HICaBStyTPyHOu1KOyMInvE12abYmWcLZ70nJARZqcRee/9BPO0tJSWBMvD0k7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhv22y6L2lURikotIrbe8oVuxAoAWbx4dPLrxJlbfW8=;
 b=cbEREGZVHiGaSaY7cZ+SxU7bsqly3vhlrTMqWq7g72Z2jhQwolh5UC+P9ZVQDzRcv00L2WVzn//npJt6sJSG3w++vD+4Fw9wZYIE2OBtzOhz56pNWTnfsRQiLPsCO0U2zYn9K+Y9Y3W8XCAo5gXnYyTZFt/nVrgl/sMtv6P2LNsCJq+TPmUk2hgmeXZJ6tlkAo34dyqfuz5VcTgtH7QE3BC8o+fdnUaQSzuotFNYBSfg9wmCBU4GYpmbOt8oRCHO2YkOejHp8KwcNDtrj192AjvQiXwV3TX8QZPJvrvkmVC++6j/dAuNXKG/GwNtIlCFCzZzf9UtvgGB7zXHBAKQGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10694.eurprd04.prod.outlook.com (2603:10a6:10:582::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 16:38:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:38:41 +0000
Date: Thu, 7 Nov 2024 11:38:33 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 4/5] net: enetc: add LSO support for i.MX95
 ENETC PF
Message-ID: <ZyztCTpa08BCXWpE@lizhi-Precision-Tower-5810>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
 <20241107033817.1654163-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107033817.1654163-5-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10694:EE_
X-MS-Office365-Filtering-Correlation-Id: fb31c9e0-f8fc-4dd5-64e5-08dcff4aa332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z5/Y61dMx8U5OvC+wvqxo024Ve0vb4ktI6axxpWqay+Ik4krHxsntU0du+HM?=
 =?us-ascii?Q?GQIcYV3HIsAhQlMMFurgg8DC0VwB+VQOmJntadnaHhdl2svf0iHztGE0kCfv?=
 =?us-ascii?Q?IBiILkE20IDkbl+HBIkv//vYZZJjLKOFM2+MNmzHT/F07tWshEyutXc2S4x3?=
 =?us-ascii?Q?E0kOsxSj58lODrsjS7KsiP8fSJuQ1HVHLTX1JZEs1fqgmEAhqhvDQVC1UZOU?=
 =?us-ascii?Q?5vWeTrG78SI9O0a+W46b4IbDiaz22OiGEgqj5Vw3t/1LWbEbim6Odn0ibjSB?=
 =?us-ascii?Q?afcPMq1KtGPditAqfZ+lEVUFbAWFAbD6npCFwd3e6uQ+11q13tBqPufOAAzb?=
 =?us-ascii?Q?dsaHGN/s1bZSB53heAf4lsVhRbw1kNRxnmJLmfr1As4W/zdQsLcip86GheDg?=
 =?us-ascii?Q?hgOzjcQgN419hVW7toNbjqfnBa8zBGGhmqp2j3mtkBahaVRuSF0wQ6pmfWdV?=
 =?us-ascii?Q?grvq8viJ/4dl1ySpPEQhl6wjSC8hZ+hFd4GSHlCb6Ye/AubPcV873/u7/lVR?=
 =?us-ascii?Q?BLEVufTzVvM9ulql02wflHZvRKSsXqco6KoPIcvTQqrRw92pApmrt8UwNCTF?=
 =?us-ascii?Q?2TUt3D2wR0yZ4LcL/79HWXX5OJN/i1i6Ot+uNopLzE04kN4ygZYhfBx49yyZ?=
 =?us-ascii?Q?ewRLLEDuDUzAP+UNcy6AWroAnFYYYZpRS1c3U83AEqfvLlB38jJrp9wmSDLD?=
 =?us-ascii?Q?QETFj4f1VTDIF+QY0jiVrv1ACG8CLLD2LOR5g59lOGr6qcHZ41VrnaohO2dq?=
 =?us-ascii?Q?skktVI5/XsDQ50H4ofs7a9MCI+P/94T4n+x0bdG5J6EB+0TIThiIT92k73hb?=
 =?us-ascii?Q?2aiQLHL/m5ixYBHMXPWbYUfiJHo1BL5faVF6QO3xn3j0yUldNy+3FIuQS/n3?=
 =?us-ascii?Q?eZVJ3evq64duMdEexx/QDZAOihStd00ii2kdCpzIAeIQrG7Fxvq7G3g+tjaA?=
 =?us-ascii?Q?Z0PeKwDnhevhSdtQIKTROddMkFCXa/ZBGRezAA7W/OrKK4NLRxIDk6qXt8Jm?=
 =?us-ascii?Q?O52/mXgfWcxidhq4CmgAqVtqGhCUbJBiTo62E3mOKdPwG5It/U+R4WPcs8O4?=
 =?us-ascii?Q?xk8mkQMmfr38VETEg049HxkKhD0rP5XFbInGnFkIQSPejPSsSA3xzZBQHCVz?=
 =?us-ascii?Q?KdlBTBR/LTxz8lo6rkBr+SbkDqkbJX7Wus+p1nxaPfRWtpVs+PBJEhRhKd6l?=
 =?us-ascii?Q?T3nxVHUI4dirPqqehvGNWbc0iHvnUiWQkiys+WTp0lzJktHCVRF5WlwGjOaZ?=
 =?us-ascii?Q?cnzvmlX0Ft422LFEMHvXdCGw3XFpAiR869MpL4lAbfAlIyD6yqs3F+v9HcWJ?=
 =?us-ascii?Q?p7+gX7p+gX9dXtMrj/ETXpOOPwog3W03yaqEQW/XNaMw9yZLJctIAgT29L4m?=
 =?us-ascii?Q?/44LSUs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vKDExDPGzb0CQoP0fSU/N2zZFnTM9AOu9DgZsYuAaELwaE/PmMuG5D0kkOep?=
 =?us-ascii?Q?d3TElZuJ+Ea3zgFkJ8JqJcFTtqMBXjf+dPM6zEqYHWEeKCg0JOlGqigmUBbV?=
 =?us-ascii?Q?GMXn2FGuw+GNSv6TAuX4C2WxnSCRic05shSfvKXHdRKCH/km0ga886rQCG+b?=
 =?us-ascii?Q?Nc5m9nbtn7pZWj4Dqb9KHN8NT+/2RQs4/ZHxCDQ2ndEYrnurwH3mPc3o9ARC?=
 =?us-ascii?Q?0wYmYzKBXPR5kYk8pK7x9kFfq+Dd1SaUxUZXJw0UgFUumSsZfQ90VX71B09w?=
 =?us-ascii?Q?3rDgYK6Ey/PFpOPT+FQB8Tf7fVuQM5EDDQlq2PVNeHRM3TdJ9VMaSeytOync?=
 =?us-ascii?Q?5rLBBGF7REJx4pTVJFEGqNtYlhmG+Uhmg+y7m9IaT3auR64F6IN+Zt+u0ri4?=
 =?us-ascii?Q?g4qde/TdQRDz/DiTaFt3by773DxRuLNUFbl3tK9MmryRBmZGGrYR8wbLcsdL?=
 =?us-ascii?Q?lYmjdmb1DiQBGV/xrcDK2mh6A3UKibPu9efb55bkmzQ/NIr0rCtPGxwfnUQE?=
 =?us-ascii?Q?9sGgKtYP/tumpn7EzcjS2CcMT9mMw+AjiovjLyGrC0m9/ILfhsz2Alf5Q1uH?=
 =?us-ascii?Q?htm5SbRjupBPOKCRkffEllJc74x3GXpfPy8EJ7Mk0TuoRf4N4SwzsfQkyoz/?=
 =?us-ascii?Q?ix0AOKuinwW/ThkI8Rk4dKh019XKCw3D6uOnfGXd127A+sbJVZObm7R3rsm/?=
 =?us-ascii?Q?PkHj75+LUVi0aCcEXf+ZSOjaPuc/Ww/hQJ96HUQzdJgsIhwWqRWtivcrvMl8?=
 =?us-ascii?Q?RqTDt4hqawumN+tXL+pDikVjGffi6+dtJ0pd9KaZzusKwdnbrJKuoDH5Zh4T?=
 =?us-ascii?Q?XtgS/q+Sma77KlF6Z1ZWE3F6idShmn53PnaWiSXbi38/DlIwByqpsd/IWXQF?=
 =?us-ascii?Q?F4JbtqpNf7vIXHtXlpWHA9dc5insxncWdSUvZRrjhxoev/ABjMluXl+6Ss/m?=
 =?us-ascii?Q?OmDQ1spRnsfAbGDhQL0xRRCMMwaDHuLPj6xWcKQo0euq/CvWIk/aPLzAUGVP?=
 =?us-ascii?Q?cCgfJ44iaUtxLF45xK8+ZR5C/gxxsB8FbrkKN2l6kJpl/YFrzL3O6Nb6n99R?=
 =?us-ascii?Q?1PYTkFqqT27DGt0PMCoqRjid2FapdRLtNtElQaLS8qlHEVOY6FXHEoD8vTE3?=
 =?us-ascii?Q?fCjNOGPD9gimWWnfmhbPsQULLf8UNiOAnp9XdO2eweRzksIT9cW07OXczUGq?=
 =?us-ascii?Q?C6UxiU3Dq9aI2hJJ90FcqzUqTdMCqNXYuqnrsmrnbip5fC8SOp7J3oXjQl21?=
 =?us-ascii?Q?EtnvM1t9ahNkdkCG6aR3oupIdWSJu8UwAfl0EAr52P5Zy0U4YlLqKBWJEGbK?=
 =?us-ascii?Q?ame/rW7iigH+JO2+Q536qBLKHMB82Fa88NA6xy7qKibIal+lQBQ3E62/4Lrc?=
 =?us-ascii?Q?VOH7ZlN1UZu+h5ANR9gRI4sjAabr+LfCMnCKT8V03LSPrbnLHFhSv7WPc6rr?=
 =?us-ascii?Q?NHq4gWiOiziFB77A0Pi6INGWss/IW8koimSbJGKxft1o5nlClEpIa6An5u9j?=
 =?us-ascii?Q?pdxJfl24wICG+gtoM9bTsawAz7znjDbRzcJzKeMhXwsgOWhzaTWCSNYDpSV7?=
 =?us-ascii?Q?6G6Xr/J/Ld6fYneBJIBiVXH4ctCX5zqPcQYnp60C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb31c9e0-f8fc-4dd5-64e5-08dcff4aa332
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:38:41.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7r2fWgyBt7qzNonb8FOhTwFKM1mSzCvD3RJiw1HszUx4jPg5gDnHoRONBTbddDKu1QInSI+8doherhj4ZBiQPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10694

On Thu, Nov 07, 2024 at 11:38:16AM +0800, Wei Fang wrote:
> ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
> and UDP transmit units into multiple Ethernet frames. To support LSO,
> software needs to fill some auxiliary information in Tx BD, such as LSO
> header length, frame length, LSO maximum segment size, etc.
>
> At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
> CPU performance before and after applying the patch was compared through
> the top command. It can be seen that LSO saves a significant amount of
> CPU cycles compared to software TSO.
>
> Before applying the patch:
> %Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si
>
> After applying the patch:
> %Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 266 +++++++++++++++++-
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
>  .../freescale/enetc/enetc_pf_common.c         |   3 +
>  5 files changed, 311 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index b294ca4c2885..5586bdc7ab59 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -528,6 +528,233 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
>  	}
>  }
>
> +static inline int enetc_lso_count_descs(const struct sk_buff *skb)
> +{
> +	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
> +	 * for linear area data but not include LSO header, namely
> +	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
> +	 */
> +	return skb_shinfo(skb)->nr_frags + 4;
> +}
> +
> +static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
> +{
> +	int hdr_len, tlen;
> +
> +	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
> +	hdr_len = skb_transport_offset(skb) + tlen;
> +
> +	return hdr_len;
> +}
> +
> +static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
> +{
> +	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
> +	lso->ipv6 = vlan_get_protocol(skb) == htons(ETH_P_IPV6);
> +	lso->tcp = skb_is_gso_tcp(skb);
> +	lso->l3_hdr_len = skb_network_header_len(skb);
> +	lso->l3_start = skb_network_offset(skb);
> +	lso->hdr_len = enetc_lso_get_hdr_len(skb);
> +	lso->total_len = skb->len - lso->hdr_len;
> +}
> +
> +static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
> +			      int *i, struct enetc_lso_t *lso)
> +{
> +	union enetc_tx_bd txbd_tmp, *txbd;
> +	struct enetc_tx_swbd *tx_swbd;
> +	u16 frm_len, frm_len_ext;
> +	u8 flags, e_flags = 0;
> +	dma_addr_t addr;
> +	char *hdr;
> +
> +	/* Get the fisrt BD of the LSO BDs chain */
> +	txbd = ENETC_TXBD(*tx_ring, *i);
> +	tx_swbd = &tx_ring->tx_swbd[*i];
> +	prefetchw(txbd);
> +
> +	/* Prepare LSO header: MAC + IP + TCP/UDP */
> +	hdr = tx_ring->tso_headers + *i * TSO_HEADER_SIZE;
> +	memcpy(hdr, skb->data, lso->hdr_len);
> +	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
> +
> +	frm_len = lso->total_len & 0xffff;
> +	frm_len_ext = (lso->total_len >> 16) & 0xf;
> +
> +	/* Set the flags of the first BD */
> +	flags = ENETC_TXBD_FLAGS_EX | ENETC_TXBD_FLAGS_CSUM_LSO |
> +		ENETC_TXBD_FLAGS_LSO | ENETC_TXBD_FLAGS_L4CS;
> +
> +	enetc_clear_tx_bd(&txbd_tmp);
> +	txbd_tmp.addr = cpu_to_le64(addr);
> +	txbd_tmp.hdr_len = cpu_to_le16(lso->hdr_len);
> +
> +	/* first BD needs frm_len and offload flags set */
> +	txbd_tmp.frm_len = cpu_to_le16(frm_len);
> +	txbd_tmp.flags = flags;
> +
> +	if (lso->tcp)
> +		txbd_tmp.l4t = ENETC_TXBD_L4T_TCP;
> +	else
> +		txbd_tmp.l4t = ENETC_TXBD_L4T_UDP;
> +
> +	if (lso->ipv6)
> +		txbd_tmp.l3t = 1;
> +	else
> +		txbd_tmp.ipcs = 1;
> +
> +	/* l3_hdr_size in 32-bits (4 bytes) */
> +	txbd_tmp.l3_hdr_size = lso->l3_hdr_len / 4;
> +	txbd_tmp.l3_start = lso->l3_start;
> +
> +	/* For the LSO header we do not set the dma address since
> +	 * we do not want it unmapped when we do cleanup. We still
> +	 * set len so that we count the bytes sent.
> +	 */
> +	tx_swbd->len = lso->hdr_len;
> +	tx_swbd->do_twostep_tstamp = false;
> +	tx_swbd->check_wb = false;
> +
> +	/* Actually write the header in the BD */
> +	*txbd = txbd_tmp;
> +
> +	/* Get the next BD, and the next BD is extended BD */
> +	enetc_bdr_idx_inc(tx_ring, i);
> +	txbd = ENETC_TXBD(*tx_ring, *i);
> +	tx_swbd = &tx_ring->tx_swbd[*i];
> +	prefetchw(txbd);
> +
> +	enetc_clear_tx_bd(&txbd_tmp);
> +	if (skb_vlan_tag_present(skb)) {
> +		/* Setup the VLAN fields */
> +		txbd_tmp.ext.vid = cpu_to_le16(skb_vlan_tag_get(skb));
> +		txbd_tmp.ext.tpid = 0; /* < C-TAG */
> +		e_flags = ENETC_TXBD_E_FLAGS_VLAN_INS;
> +	}
> +
> +	/* Write the BD */
> +	txbd_tmp.ext.e_flags = e_flags;
> +	txbd_tmp.ext.lso_sg_size = cpu_to_le16(lso->lso_seg_size);
> +	txbd_tmp.ext.frm_len_ext = cpu_to_le16(frm_len_ext);
> +	*txbd = txbd_tmp;
> +}
> +
> +static int enetc_lso_map_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
> +			      int *i, struct enetc_lso_t *lso, int *count)
> +{
> +	union enetc_tx_bd txbd_tmp, *txbd = NULL;
> +	struct enetc_tx_swbd *tx_swbd;
> +	skb_frag_t *frag;
> +	dma_addr_t dma;
> +	u8 flags = 0;
> +	int len, f;
> +
> +	len = skb_headlen(skb) - lso->hdr_len;
> +	if (len > 0) {
> +		dma = dma_map_single(tx_ring->dev, skb->data + lso->hdr_len,
> +				     len, DMA_TO_DEVICE);
> +		if (unlikely(dma_mapping_error(tx_ring->dev, dma))) {
> +			netdev_err(tx_ring->ndev, "DMA map error\n");
> +			goto dma_err;
> +		}
> +
> +		enetc_bdr_idx_inc(tx_ring, i);
> +		txbd = ENETC_TXBD(*tx_ring, *i);
> +		tx_swbd = &tx_ring->tx_swbd[*i];
> +		prefetchw(txbd);
> +		*count += 1;
> +
> +		enetc_clear_tx_bd(&txbd_tmp);
> +		txbd_tmp.addr = cpu_to_le64(dma);
> +		txbd_tmp.buf_len = cpu_to_le16(len);
> +
> +		tx_swbd->dma = dma;
> +		tx_swbd->len = len;
> +		tx_swbd->is_dma_page = 0;
> +		tx_swbd->dir = DMA_TO_DEVICE;
> +	}
> +
> +	frag = &skb_shinfo(skb)->frags[0];
> +	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++, frag++) {
> +		if (txbd)
> +			*txbd = txbd_tmp;
> +
> +		len = skb_frag_size(frag);
> +		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, len,
> +				       DMA_TO_DEVICE);
> +		if (unlikely(dma_mapping_error(tx_ring->dev, dma))) {
> +			netdev_err(tx_ring->ndev, "DMA map error\n");
> +			goto dma_err;
> +		}
> +
> +		/* Get the next BD */
> +		enetc_bdr_idx_inc(tx_ring, i);
> +		txbd = ENETC_TXBD(*tx_ring, *i);
> +		tx_swbd = &tx_ring->tx_swbd[*i];
> +		prefetchw(txbd);
> +		*count += 1;
> +
> +		enetc_clear_tx_bd(&txbd_tmp);
> +		txbd_tmp.addr = cpu_to_le64(dma);
> +		txbd_tmp.buf_len = cpu_to_le16(len);
> +
> +		tx_swbd->dma = dma;
> +		tx_swbd->len = len;
> +		tx_swbd->is_dma_page = 1;
> +		tx_swbd->dir = DMA_TO_DEVICE;
> +	}
> +
> +	/* Last BD needs 'F' bit set */
> +	flags |= ENETC_TXBD_FLAGS_F;
> +	txbd_tmp.flags = flags;
> +	*txbd = txbd_tmp;
> +
> +	tx_swbd->is_eof = 1;
> +	tx_swbd->skb = skb;
> +
> +	return 0;
> +
> +dma_err:
> +	return -ENOMEM;
> +}
> +
> +static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
> +{
> +	struct enetc_tx_swbd *tx_swbd;
> +	struct enetc_lso_t lso = {0};
> +	int err, i, count = 0;
> +
> +	/* Initialize the LSO handler */
> +	enetc_lso_start(skb, &lso);
> +	i = tx_ring->next_to_use;
> +
> +	enetc_lso_map_hdr(tx_ring, skb, &i, &lso);
> +	/* First BD and an extend BD */
> +	count += 2;
> +
> +	err = enetc_lso_map_data(tx_ring, skb, &i, &lso, &count);
> +	if (err)
> +		goto dma_err;
> +
> +	/* Go to the next BD */
> +	enetc_bdr_idx_inc(tx_ring, &i);
> +	tx_ring->next_to_use = i;
> +	enetc_update_tx_ring_tail(tx_ring);
> +
> +	return count;
> +
> +dma_err:
> +	do {
> +		tx_swbd = &tx_ring->tx_swbd[i];
> +		enetc_free_tx_frame(tx_ring, tx_swbd);
> +		if (i == 0)
> +			i = tx_ring->bd_count;
> +		i--;
> +	} while (count--);
> +
> +	return 0;
> +}
> +
>  static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
> @@ -648,14 +875,26 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  	tx_ring = priv->tx_ring[skb->queue_mapping];
>
>  	if (skb_is_gso(skb)) {
> -		if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
> -			netif_stop_subqueue(ndev, tx_ring->index);
> -			return NETDEV_TX_BUSY;
> -		}
> +		/* LSO data unit lengths of up to 256KB are supported */
> +		if (priv->active_offloads & ENETC_F_LSO &&
> +		    (skb->len - enetc_lso_get_hdr_len(skb)) <=
> +		    ENETC_LSO_MAX_DATA_LEN) {
> +			if (enetc_bd_unused(tx_ring) < enetc_lso_count_descs(skb)) {
> +				netif_stop_subqueue(ndev, tx_ring->index);
> +				return NETDEV_TX_BUSY;
> +			}
>
> -		enetc_lock_mdio();
> -		count = enetc_map_tx_tso_buffs(tx_ring, skb);
> -		enetc_unlock_mdio();
> +			count = enetc_lso_hw_offload(tx_ring, skb);
> +		} else {
> +			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
> +				netif_stop_subqueue(ndev, tx_ring->index);
> +				return NETDEV_TX_BUSY;
> +			}
> +
> +			enetc_lock_mdio();
> +			count = enetc_map_tx_tso_buffs(tx_ring, skb);
> +			enetc_unlock_mdio();
> +		}
>  	} else {
>  		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
>  			if (unlikely(skb_linearize(skb)))
> @@ -1801,6 +2040,9 @@ void enetc_get_si_caps(struct enetc_si *si)
>  		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
>  	}
>
> +	if (val & ENETC_SIPCAPR0_LSO)
> +		si->hw_features |= ENETC_SI_F_LSO;
> +
>  	if (val & ENETC_SIPCAPR0_QBV)
>  		si->hw_features |= ENETC_SI_F_QBV;
>
> @@ -2105,6 +2347,13 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
>  	return 0;
>  }
>
> +static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
> +{
> +	enetc_wr(hw, ENETC4_SILSOSFMR0,
> +		 SILSOSFMR0_VAL_SET(TCP_NL_SEG_FLAGS_DMASK, TCP_NL_SEG_FLAGS_DMASK));
> +	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
> +}
> +
>  int enetc_configure_si(struct enetc_ndev_priv *priv)
>  {
>  	struct enetc_si *si = priv->si;
> @@ -2118,6 +2367,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
>  	/* enable SI */
>  	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
>
> +	if (si->hw_features & ENETC_SI_F_LSO)
> +		enetc_set_lso_flags_mask(hw);
> +
>  	/* TODO: RSS support for i.MX95 will be supported later, and the
>  	 * is_enetc_rev1() condition will be removed
>  	 */
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index a78af4f624e0..0a69f72fe8ec 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -41,6 +41,19 @@ struct enetc_tx_swbd {
>  	u8 qbv_en:1;
>  };
>
> +struct enetc_lso_t {
> +	bool	ipv6;
> +	bool	tcp;
> +	u8	l3_hdr_len;
> +	u8	hdr_len; /* LSO header length */
> +	u8	l3_start;
> +	u16	lso_seg_size;
> +	int	total_len; /* total data length, not include LSO header */
> +};
> +
> +#define ENETC_1KB_SIZE			1024
> +#define ENETC_LSO_MAX_DATA_LEN		(256 * ENETC_1KB_SIZE)
> +
>  #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
>  #define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
>  #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
> @@ -238,6 +251,7 @@ enum enetc_errata {
>  #define ENETC_SI_F_PSFP BIT(0)
>  #define ENETC_SI_F_QBV  BIT(1)
>  #define ENETC_SI_F_QBU  BIT(2)
> +#define ENETC_SI_F_LSO	BIT(3)
>
>  struct enetc_drvdata {
>  	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
> @@ -353,6 +367,7 @@ enum enetc_active_offloads {
>  	ENETC_F_QBU			= BIT(11),
>  	ENETC_F_RXCSUM			= BIT(12),
>  	ENETC_F_TXCSUM			= BIT(13),
> +	ENETC_F_LSO			= BIT(14),
>  };
>
>  enum enetc_flags_bit {
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index 26b220677448..cdde8e93a73c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -12,6 +12,28 @@
>  #define NXP_ENETC_VENDOR_ID		0x1131
>  #define NXP_ENETC_PF_DEV_ID		0xe101
>
> +/**********************Station interface registers************************/
> +/* Station interface LSO segmentation flag mask register 0/1 */
> +#define ENETC4_SILSOSFMR0		0x1300
> +#define  SILSOSFMR0_TCP_MID_SEG		GENMASK(27, 16)
> +#define  SILSOSFMR0_TCP_1ST_SEG		GENMASK(11, 0)
> +#define  SILSOSFMR0_VAL_SET(first, mid)	((((mid) << 16) & SILSOSFMR0_TCP_MID_SEG) | \
> +					 ((first) & SILSOSFMR0_TCP_1ST_SEG))
> +
> +#define ENETC4_SILSOSFMR1		0x1304
> +#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
> +#define   TCP_FLAGS_FIN			BIT(0)
> +#define   TCP_FLAGS_SYN			BIT(1)
> +#define   TCP_FLAGS_RST			BIT(2)
> +#define   TCP_FLAGS_PSH			BIT(3)
> +#define   TCP_FLAGS_ACK			BIT(4)
> +#define   TCP_FLAGS_URG			BIT(5)
> +#define   TCP_FLAGS_ECE			BIT(6)
> +#define   TCP_FLAGS_CWR			BIT(7)
> +#define   TCP_FLAGS_NS			BIT(8)
> +/* According to tso_build_hdr(), clear all special flags for not last packet. */
> +#define TCP_NL_SEG_FLAGS_DMASK		(TCP_FLAGS_FIN | TCP_FLAGS_RST | TCP_FLAGS_PSH)
> +
>  /***************************ENETC port registers**************************/
>  #define ENETC4_ECAPR0			0x0
>  #define  ECAPR0_RFS			BIT(2)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 590b1412fadf..34a3e8f1496e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -28,6 +28,8 @@
>  #define ENETC_SIPCAPR0_QBV	BIT(4)
>  #define ENETC_SIPCAPR0_QBU	BIT(3)
>  #define ENETC_SIPCAPR0_RFS	BIT(2)
> +#define ENETC_SIPCAPR0_LSO	BIT(1)
> +#define ENETC_SIPCAPR0_RSC	BIT(0)
>  #define ENETC_SIPCAPR1	0x24
>  #define ENETC_SITGTGR	0x30
>  #define ENETC_SIRBGCR	0x38
> @@ -554,7 +556,10 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
>  union enetc_tx_bd {
>  	struct {
>  		__le64 addr;
> -		__le16 buf_len;
> +		union {
> +			__le16 buf_len;
> +			__le16 hdr_len;	/* For LSO, ENETC 4.1 and later */
> +		};
>  		__le16 frm_len;
>  		union {
>  			struct {
> @@ -574,13 +579,16 @@ union enetc_tx_bd {
>  		__le32 tstamp;
>  		__le16 tpid;
>  		__le16 vid;
> -		u8 reserved[6];
> +		__le16 lso_sg_size; /* For ENETC 4.1 and later */
> +		__le16 frm_len_ext; /* For ENETC 4.1 and later */
> +		u8 reserved[2];
>  		u8 e_flags;
>  		u8 flags;
>  	} ext; /* Tx BD extension */
>  	struct {
>  		__le32 tstamp;
> -		u8 reserved[10];
> +		u8 reserved[8];
> +		__le16 lso_err_count; /* For ENETC 4.1 and later */
>  		u8 status;
>  		u8 flags;
>  	} wb; /* writeback descriptor */
> @@ -589,6 +597,7 @@ union enetc_tx_bd {
>  enum enetc_txbd_flags {
>  	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
>  	ENETC_TXBD_FLAGS_TSE = BIT(1),
> +	ENETC_TXBD_FLAGS_LSO = BIT(1), /* For ENETC 4.1 and later */
>  	ENETC_TXBD_FLAGS_W = BIT(2),
>  	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
>  	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index 2c4c6af672e7..82a67356abe4 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -126,6 +126,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	if (si->drvdata->tx_csum)
>  		priv->active_offloads |= ENETC_F_TXCSUM;
>
> +	if (si->hw_features & ENETC_SI_F_LSO)
> +		priv->active_offloads |= ENETC_F_LSO;
> +
>  	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
>  	if (!is_enetc_rev1(si)) {
>  		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
> --
> 2.34.1
>

