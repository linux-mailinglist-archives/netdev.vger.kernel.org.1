Return-Path: <netdev+bounces-194403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293BFAC9404
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5F017405A
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FAD230997;
	Fri, 30 May 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LkWegKQA"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6BC22FDEC;
	Fri, 30 May 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624085; cv=fail; b=CsV+hloTALytdHgdwokHG2ZlRXyw/lRdVgaXwoYeTcIqQMB+WrnISTHM2F1i1laqg/yzNqnPRFePuAQM5vraUhBFKdZh1SKfrDcuNmP3x9YAY7v9DB0Cho2BtK0v4EogJVVYaIiM7a0M0b9UvHHSnocE6MwH8rUK7WXANdQGTXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624085; c=relaxed/simple;
	bh=S9UC/xmJCFbhWVc0L4rJTiowRZrTyx6I8O/8dG9YX4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LCtOdtVwPHPswS7AjyieTLosgs64fu8l5BNlH0RwfusvuI8pL492K8QUUKVzAlHLVq7YowfrBOGmZMbpxed+ZSBipTDBQbEjAoFcvACH9tBUNUs0UMASLIszhonn74bNngoghXrLleBnob+cxsXjl4xLhiCpFcpFi3mYOfzMZek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LkWegKQA; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQrgbMNBLNXp/7QEc4R5edZROkQjDfJ9F7gJz6Hgq2DOI5cV5vcbR3+fEJ3xqBr2ka78ArRgez0I6cx/Rgypgk5wakQ8v2HZ+MaLs6fJozt1/O0eIPtETMICSTj42t/y2N5jeD/dzQMc4BINyrJ6BIIxNO1dWa06n56JAGuXYGFictc2T+GZ80D/JBvijgG9/ro8lWOY+UzeNT1OrjEHnokir/iCZWdWPVbPQmoxDDfla2Ulm0+6StBk/L5tTzy7E1u8Vji9Dq/VUpeHbjQsvqO5cF50veX4b9uyM1roK4GhfHIUn/J4N/1fyUXIsF4Kzw30LylP0wK4XMxm8yqkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuJoIA1Z4zBIxvvfaL8aailQlTQPBQSblEOpN9lsrKY=;
 b=Ulun5vuZaISvkQXJVCYnWYzUxKroy2ikhl20/nXmRJH+wIWF2QtaU4eNCzcgvXarw+1RVcTNLe4VwFIzn7StqI6u3g7PE61PMqpCWAb/zV4lFVITs9EbBR/2hFqcCZHYFxtQlOvi31r+uciR/fJ7f7/OjzUJ+c/CAI35HJNr5zBzxpywP6zSX9ox/hwbX2IaCsMMpuJUBbEl791IWioRHnkQuLDlTGUhJClGOadnwELRySJJtofZDXvah3cgaiA0+p8kKHsyzagBDMqfvwpypRIKozpjjMGkiub/i4JST//pHUNBFPnyLDmHAVrO4MDqGfkULe71Y6ZcvKngiAgTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuJoIA1Z4zBIxvvfaL8aailQlTQPBQSblEOpN9lsrKY=;
 b=LkWegKQAQcT5tu0VVpJJ3wId3sMH97bbt9mHpZqxRthMzYqXMK5T998PZr2NSfF6mSIhTLr8DVIv7RJtHDDEw2sdiOepELyV2YXhRQD8JUpfgY7O7MTJSS05v9G1Cs9SemjPng+LIgNmF/e0iZ9FS3SbPfDSv4c8InXva8q0mTpqZ2tNOR5WOOs6rah33CkTpB2F77XJb5WyZXCqUAf6pBHW1057zIazdsc0O2VryncNf2ImrOEBS2lddOU49oyVnOmW212uRMmHvoRGggkgafRYbapLCn3FppbPnsMkhX5VOqKf+rcrhcFTb4tfUOc8Zg5du/GT6oUSw4b1AYA8Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by VI1PR04MB10051.eurprd04.prod.outlook.com (2603:10a6:800:1db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 16:54:37 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 16:54:37 +0000
Date: Fri, 30 May 2025 19:54:34 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net] net: enetc: fix wrong TPID registers and remove dead
 branch
Message-ID: <20250530165434.xzdroce3i2mmwxcf@skbuf>
References: <20250530090012.3989060-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530090012.3989060-1-wei.fang@nxp.com>
X-ClientProxiedBy: VE1PR03CA0036.eurprd03.prod.outlook.com
 (2603:10a6:803:118::25) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|VI1PR04MB10051:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b727b25-b416-46aa-ba0c-08dd9f9aa965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Te2qOCGMi0u2SBoR91h8Sq2GDu24y6tp+qB5Q6FPQbc0vipVRnfagFVmiRp?=
 =?us-ascii?Q?k6L/Ruu043rysnd9gks+kfIpQzc/XVnjzZ024lExjdzp+FvOaniGYMAdxxnB?=
 =?us-ascii?Q?Gz4GkF5njZ5SMn31P1avBCXkLNO0xfczjrZ6myaTrZ5IaXPN59zNoSMFvFPM?=
 =?us-ascii?Q?a9fU9uRWCX0SlJo0e5KiaihXWfcfRAYqxTst9J3ENwW5A5IuYVZtZVy4Bapg?=
 =?us-ascii?Q?MA9OPqxXHUtMHIZDwBCGcbHGV+U2iJIn1UyuxHppQRAMD8E6F8qVldQY+3vr?=
 =?us-ascii?Q?vJca4jRCi94xo6bG6xp+SCdmte624/4GVbcC0CfSaWY1NQv7nlcYaOpULx7W?=
 =?us-ascii?Q?iUUciUoz311hTAg5z/VPSbBMBXqSx5hjIwfobaymhvU0WIWKa+ElBMcfa6FR?=
 =?us-ascii?Q?/fpgntwCO/N7je2AgIUZKMEQCG69jQpemltjBRU7f5D3Dkn9HlvEohLmkSQK?=
 =?us-ascii?Q?orryHeZTkFA58GtQXBkFrttWtSGe8+bmkj5H8bU82uabxWyoFMM5CUn6QfvP?=
 =?us-ascii?Q?9kQnDhspBSuwhhzNvxa1/nAB1rdgS/a2Sw5DDTCZm9K1HJR6ObHCS8ENoJJs?=
 =?us-ascii?Q?6g8u1xLM0uNS2/Eu1TscedGTcqvhsfbGRkYwnzTWVYMBy9FjR6UZoGwI9GAh?=
 =?us-ascii?Q?bPZhIjLKVTwqDSwbBvONtTw8ZFwnojYVbxA33UvAwaVjZRYu3SuOFH7WqpDs?=
 =?us-ascii?Q?KRPrkdvWHbL/okrkmkOiB2O+Iu0LwUXXdLqYr3YHQev9Apr7erUZzc+9Z4+G?=
 =?us-ascii?Q?i54PjoMkZghbgAFGEc/eoY2fsph2uUvD9eCXEgBQ3/o/CL5s8q9ctWD+NMd9?=
 =?us-ascii?Q?j3T37Xvc38yVJTUjdLcJnxDU2v8r3IJm/JcZyDT0sf1QVTB1RJ2nqNK2XdVs?=
 =?us-ascii?Q?jggGQb1aD84HLxMplBUfDkKtzciDuWfgjzoumrV/imNb6/pY33oSuTzvlaRm?=
 =?us-ascii?Q?QyHLxE9Vzk07BqCoc9BXgKqhfbPe06A5LD8sZiSQYutTL5wN3rEWzjR9vVEa?=
 =?us-ascii?Q?YuWpK+21LXlZ/+AduHynS0hmZ+z9KTClzFS07DM0y4nmF+bC7GH50174FJBQ?=
 =?us-ascii?Q?zB377367v4z7y9xvelzMUr1ID3YZ+/3aH3Ii9ySIHBVIGPWJrgj8MYcaE53u?=
 =?us-ascii?Q?xtOyHNRYRlRrPm4+IkMeJwwLGAErlmRtmXCEXY0TQ+x1GJIeY+V0mUFeCtuU?=
 =?us-ascii?Q?9CGPvTW0PWsEsqcrPaGvcck3KLmFQXxoWQbh+1VvRohHi1YydrXKb8fnG8rd?=
 =?us-ascii?Q?eX2pMdAOos8XjbMbud6ExrzlOwaGjU4SL6ksUcbLDDwToiI60DE6pcYcfVdy?=
 =?us-ascii?Q?BmWhjBlrOIkBZP6Wh8MwCd3EcXg+k439UQ6WVvx1yWXCIl2crlKwLKYA/xUv?=
 =?us-ascii?Q?9yyunbAFBm7a+cF9NuTYRigzkcBBV5NRRvDfPHjkRVU/35L5q+XI9Q7DYVdm?=
 =?us-ascii?Q?7MpsJYZ6E5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LRsUX3yF6DfaLK1u+DdGgq4MfxlSragIgc6AGBm8qb22JCvv3rOmW5aLgAxb?=
 =?us-ascii?Q?jAUuu3DN+BBoED7hXn125lfFrPoFi1wKQwkisD8ceFhIFJWrbKddtp7Xg+Lb?=
 =?us-ascii?Q?EzK9Bb9C8Wy0wRTBXewDfuIJanMsJZvOHQRFeJfji8aqt6MK+16bBMz6G/xO?=
 =?us-ascii?Q?JiVl2XpEZQb4NSBDzFe3RwRHSITRf/yvPWfIqOHELGxC/wfka3OPyJOlmYyX?=
 =?us-ascii?Q?PDpeerM/jlCCe/bwkslVMAsV9l1gtzC2X3wGt627J+VzXKkwQvLSu5mo71LJ?=
 =?us-ascii?Q?pbcQkBEnFKq/lzbKJIxUhFqPwX3DlFnmLFT6Ih45XEe1g+r3WUmFoFpPEZCU?=
 =?us-ascii?Q?nbMh9Zn3EFJEpoAPQk4xq0gB5+eNOXZVICE6y/tfJzNs+HWlGtQ42SZKyuEq?=
 =?us-ascii?Q?pG8ZAXxRrA6y86KtyRwiBB6FbItaPQXYc+1w5GV2aqKreVcXcBUBys5iMgyZ?=
 =?us-ascii?Q?YYD7CKwdtYuhH7+TOyutHGY4uzMeFi9MNwD7SLu42XeFczt63w+uzqCcGPyE?=
 =?us-ascii?Q?OtZDfx73F6Q/KoEDdvoHC6cTSkVVQC1KgRnquCZ1F7ChCwuTQUY2XQncG0z+?=
 =?us-ascii?Q?rLbxoGe/nB2mE9QcyIcwM/f/wqO4c8FuxAOPdx4Z6zGiwynsZed9cCPu0ahC?=
 =?us-ascii?Q?YGAVKND3tBTj+SBH7I8T3hOWGL73Ai86fyNDyJsd5abhcSy+a7N1RLIsDKLs?=
 =?us-ascii?Q?j7oTBPc+VXaShNUFkkeibOjE0eySEfaa59QHfl5wkn8iMDNQV3DHM8HnIB/Y?=
 =?us-ascii?Q?UYfU8Gl1yqkNMN2BWbKI9MHYt3Tyw2vEJ2Pv6fFQ6ZY09K6EIJeoYDOytjUt?=
 =?us-ascii?Q?cTO3OKZzBsiukx3KGTtpF19J8AamoX7Yd/gGO2vJ2t2NvoaggxsLNUtfmWDX?=
 =?us-ascii?Q?kUCQhvuIsZADaTFT+2dF+yl1+Q1TBs0tpePzk4gQ6l6q7L/lT6jmAWzJqV3x?=
 =?us-ascii?Q?Li1JIadJG5/CHLw/4nrbWus9e/o8Cf66YmUVVTUUrJd9tv9E1a0ILxg7cueb?=
 =?us-ascii?Q?wQdWQ6oMT6IyGUWjuWvKQRybFsqWvBt2tM4C3SHuMqWpImLNrheVsQ1Rp8Sp?=
 =?us-ascii?Q?YITiYEj5dtoEkuqwWGCPEQu++6ECpC9Owi1RYUyWp+1FDsj0VO/2Dh/SEqyj?=
 =?us-ascii?Q?PJ/izX6C9xBU2ox63W6T7nihYSegUvN5B9tQ4eWVUzYV+r0BF5sMINpLIc3T?=
 =?us-ascii?Q?0jmtOpLPvu/Tv/hC3nhK8ELj8TODqVAq+pVSU7QoC4rI5s1UoWjI6PzG01Ng?=
 =?us-ascii?Q?DcGFvVGrwTR3cmtjy7L/O0mdmN9k1vmCcK+XNwgc5kDIABIvxOCkA+EbVue3?=
 =?us-ascii?Q?iQcFZtKUnFWEo/mg+WwcYRdaxd7/vjJ3TKyzU/VfxehMqFnxVkjpYm5gMWqd?=
 =?us-ascii?Q?9mvttH3jYhol44KdmqB47tRHBU7KIHfkuobXMTU2fhjSXDMsdoka/dw3iuWg?=
 =?us-ascii?Q?QuS3k24+2oIa5qWGRcf5CXI2CmTAU3w8uyzTOCwpnQnxVPysQxAJDf6rYoSu?=
 =?us-ascii?Q?CT5Ibpl9KFpB89Gq3/+gMyYcfybxpadknG4dSs1LUor1oG8mN+S0Wz86wngN?=
 =?us-ascii?Q?mySmNgV6Im8CLIIHwo/tbsCWF7qoTyTFmmzK3ZqESUIzGx6fF5/RWgp9HDAb?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b727b25-b416-46aa-ba0c-08dd9f9aa965
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 16:54:37.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoJEgo5MaHMnR+WmCHXpUJvwvRppuFRH8lo2XwrZZzRTsbJLpMKTmWuoQxGV37w8hu+sEHDXd53BJwEOS66ELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10051

Hi Wei,

On Fri, May 30, 2025 at 05:00:12PM +0800, Wei Fang wrote:
> Both PF and VF have rx-vlan-offload enabled, however, the PCVLANR1/2
> registers are resources controlled by PF, so VF cannot access these
> two registers. Fortunately, the hardware provides SICVLANR1/2 registers
> for each SI to reflect the value of PCVLANR1/2 registers. Therefore,
> use SICVLANR1/2 instead of PCVLANR1/2.
> 
> In addition, since ENETC_RXBD_FLAG_TPID is defined as GENMASK(1, 0),
> the possible values are only 0, 1, 2, 3, so the default branch will
> never be true, so remove the default branch.
> 
> Fixes: 827b6fd04651 ("net: enetc: fix incorrect TPID when receiving 802.1ad tagged packets")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

I see what the patch is trying to do, but how did you test/reproduce this?
The CVLANR1/CVLANR2 registers are by default zero, and the driver
doesn't write them, so I guess custom TPID values are never recognized
in net-next. In such situations, I believe fixing a bug that has no
consequences should also be considered net-next material (and net-next
is currently closed until June 8th).

> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c    | 12 +++++-------
>  drivers/net/ethernet/freescale/enetc/enetc_hw.h |  5 +++--
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index dcc3fbac3481..e4287725832e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1375,6 +1375,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
>  	}
>  
>  	if (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_VLAN) {
> +		struct enetc_hw *hw = &priv->si->hw;
>  		__be16 tpid = 0;
>  
>  		switch (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_TPID) {
> @@ -1385,15 +1386,12 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
>  			tpid = htons(ETH_P_8021AD);
>  			break;
>  		case 2:
> -			tpid = htons(enetc_port_rd(&priv->si->hw,
> -						   ENETC_PCVLANR1));
> +			tpid = htons(enetc_rd_hot(hw, ENETC_SICVLANR1) &
> +				     SICVLANR_ETYPE);
>  			break;
>  		case 3:
> -			tpid = htons(enetc_port_rd(&priv->si->hw,
> -						   ENETC_PCVLANR2));
> -			break;
> -		default:
> -			break;
> +			tpid = htons(enetc_rd_hot(hw, ENETC_SICVLANR2) &
> +				     SICVLANR_ETYPE);
>  		}
>  
>  		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 4098f01479bc..0385aa66a391 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -43,6 +43,9 @@
>  
>  #define ENETC_SIPMAR0	0x80
>  #define ENETC_SIPMAR1	0x84
> +#define ENETC_SICVLANR1	0x90
> +#define ENETC_SICVLANR2	0x94
> +#define  SICVLANR_ETYPE	GENMASK(15, 0)
>  
>  /* VF-PF Message passing */
>  #define ENETC_DEFAULT_MSG_SIZE	1024	/* and max size */
> @@ -178,8 +181,6 @@ enum enetc_bdr_type {TX, RX};
>  #define ENETC_PSIPMAR0(n)	(0x0100 + (n) * 0x8) /* n = SI index */
>  #define ENETC_PSIPMAR1(n)	(0x0104 + (n) * 0x8)
>  #define ENETC_PVCLCTR		0x0208
> -#define ENETC_PCVLANR1		0x0210
> -#define ENETC_PCVLANR2		0x0214

I think you can leave these definitions in place. They will be useful if
we ever add support for custom TPIDs. Having the definitions doesn't
increase the compiled driver footprint in any way.

>  #define ENETC_VLAN_TYPE_C	BIT(0)
>  #define ENETC_VLAN_TYPE_S	BIT(1)
>  #define ENETC_PVCLCTR_OVTPIDL(bmp)	((bmp) & 0xff) /* VLAN_TYPE */
> -- 
> 2.34.1
>

