Return-Path: <netdev+bounces-249133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75063D14B2E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3797A3000182
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C8F3806C1;
	Mon, 12 Jan 2026 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LN/RJUzJ"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1AF24397A;
	Mon, 12 Jan 2026 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241686; cv=fail; b=iI8e8BOnRmtWMP2jkDGvW4lvV5SLxPsro7tjLSnwCgw4oO+jUOQC7t0EBfMm7Ohs1e1e36Fo56TOUSenZ+4plWIm07K4dQPNsLLAJf7XlKrhenmAfAuSBOtXr4qtdOSXn4Qhv8jtM7GQN9xZSOUry9fQyR2KlFOvve0EpDfd4fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241686; c=relaxed/simple;
	bh=p8Ws/VrIKCk+pJ49tZA0edw0KTSor3qTKCu3mmgWInI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nWUAH8WMOIwt2bp2Hlr7b2y2yhWwg4fYAhx/chAR+Z9cDt/uN+KtqVed1cxuMjk/HisixfK916pBRd9VSwUBvTLCUCkiaFKS7RDmuMy8SgvAfZmvoichnsYmTQOFvSLkxLl3ea0/JdpDl0DIau+s8RQyDt1zKG9MWdmx8u0hirs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LN/RJUzJ; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4RkpHaMUXw+Gpmj1Y5FMcsk2UC1Sc0Cqxg6Mz5tEWhKq2fzVemFrOriO93zeOz+KGMMVH2ogpWVABdUCu0Q+eby0EB02jioM+JzJxLTUInKRp7N7WSKp5tdrtI2r3N5dvfaUkxt116xnCNNgvB++bYQYjtDJJY96QGMabwqtkUOyAVpDt4jKv+0xMaW/Zn1oV4oCkKaivZdikuKIX5EshhGhe5baghMT4PCQgcVHAYmWMWiNEuudkc1yVJGv6q4W/x9u56yan3bClqHLjvx+4jj7IgXH3Mym1hV6IcZ5I1lMYvCzgx6wAxgSbbMUVR5yDmaQU735/QzQzPj+P2CgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqVIoEA9mtyjuqHuNQ+lREKXlfAau8n7T7J0GPNcBj0=;
 b=SpG3RipD83n7CE39DOg/U31fUwooIWdpD8CFo8rNf6H1Valg85HSHNQLY+O30DQdLjdS1Th0uER8iYjHVeSI/3HHTIv34ayducEvKACml85UOk1VIKFAIYwt1QN7N2UGlkbxEgGc6z7drEvipWbw9M8JuWNgPSwBNOy2f+Jis1hdimoXj1xSMB2poL9DPmmFBsAkJnBo33QYfd3TsbzPQzvDMp//AppOt28kMhQLsbsoqFRGeAQg1Z/jXz8blFsW98oKhPz/4RIOFfoEH1vzzxjjh/tjh3BZpeZ6U2btxDmR7kN3xyXvqpPbPcbrH/+hJDsFccV5rUo5/MpiYCRjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqVIoEA9mtyjuqHuNQ+lREKXlfAau8n7T7J0GPNcBj0=;
 b=LN/RJUzJaphv55Bu/0NQjAlElEAoYpTWIg0lmqQKKJMxMSgfBZ/jebIzoFgyApBCJ1zWtztabpeFNdpxOlXA+dHJvvNt5Nky7ga7XG4ZJ4w7lW4YYf1Ax1bpAwTDAA1YF1iUuRYXbFkmH8lXSXHo+Dw4G7RdOzYN2Vq6er3FKGCFrbvo482F370qp1FNq5QsE4YlrrGb5MrurB+jboq41aJIGJ9QQ0fBtTP/9BLAWjDXCGRUiN25AA60iHLzfstpmKFWZwvMwMqK5jUT9L/yBRsSkEwEtQZt9JqlZhtN+O7Bv8Ll7c6QTPQkH2m2dSqiTur1763gfVTFAD9tJzThJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:14:41 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 18:14:41 +0000
Date: Mon, 12 Jan 2026 20:14:36 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vadim.fedorenko@linux.dev, horms@kernel.org, jacob.e.keller@intel.com,
	afd@ti.com, pmohan@couthit.com, basharath@couthit.com,
	rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool ops for
 Frame Preemption MAC Merge
Message-ID: <20260112181436.4s5ceywwembn674r@skbuf>
References: <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-3-m-malladi@ti.com>
 <20260107125111.2372254-3-m-malladi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107125111.2372254-3-m-malladi@ti.com>
 <20260107125111.2372254-3-m-malladi@ti.com>
X-ClientProxiedBy: VI1PR09CA0132.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBAPR04MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: a15b3ede-bbe5-4356-49f4-08de520673ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?00jTWkm51DXdHcsfA9uoHkx9V1ZZ3nvoDk/MlVPaurPLkjxL8z+P9SJW5maJ?=
 =?us-ascii?Q?wdevqc2BjRRwb7nB/knai2Fal1wzjgf+Mze8HgsE0LQhNQCAYFTj5wf1Qk4v?=
 =?us-ascii?Q?aDWvN+Pl0QSVaj0xmCIZpd90Hfpf7oKiPqd7H2HTJ11y+JKHG8ISN8Wjv8+d?=
 =?us-ascii?Q?PkqnX7ah58XNy5bLql3hplV2E9FJPGHtMcZ7AvF6zrxb7ktSweyVAPTccXqR?=
 =?us-ascii?Q?PCAG+p0hZL6pU5V7NJKeFA1/E81bqQz43TN0dUF0P8Hum7Tmj+tjsaTVaWyb?=
 =?us-ascii?Q?bjhSzXP6YfZgiI3ZiQDhKEqe7E7pAd94906AbHg9iIe4rkQuwBNvKAtYY0CX?=
 =?us-ascii?Q?HBPafYXVNqZVXY1TNFUMKsj1CEmY89DAKcnkLwko8V/aJSf3hjaz05xYf3gW?=
 =?us-ascii?Q?D98Hc8wUGngrdVoof8iAjmeYzny7Y1rqKLChYGJACqF3kdW7FZwttjtYvjoM?=
 =?us-ascii?Q?+k5uXuJllMsVGmV7No7sgjaUPp3x5puW1avbQjea2lIUXH/kQEGVSEpEYPAO?=
 =?us-ascii?Q?9GYYntxZ8KbmWiaJHGGcxmt/DgkHxKwR3clOO3OwlEYCOciNYwNeaS3nx479?=
 =?us-ascii?Q?O2wwCjr9Lyzc/lyoHf3HTn6LN+D5qxFXc9qusTHI57iT4Vn5WXh5tCfggMK3?=
 =?us-ascii?Q?F2aFmySgozY9eOuqFOtKm+gylpD457/BuXiFRWGqSfohTTKNu04PLJUz//yo?=
 =?us-ascii?Q?7EKwy74+/64gonrtoebLt6j6C+9Myb8N3Qe+MKGH2i2CTi85JEmpMS4//NG5?=
 =?us-ascii?Q?1aGXcn6NM0kosrB+68r8RDYkxRhKSveesGuGJNEaExhZZjCXO216XWXfc7Q2?=
 =?us-ascii?Q?vmiTr7Cd6LNcH+/dfSt06Z0B9J1Aiwn0FZg1vtFsuIIqYYjcPb2/qJJOYjNt?=
 =?us-ascii?Q?Cv23Th/KWN76GH53JM6cc51gQ4gQGCNgWqHNuOtxU66OtJxX/r/j56VnKvpZ?=
 =?us-ascii?Q?7acXYXGt9omBhNNQNJjbuTFIfAyctWyWtHhYlh8ZQab8YTQVBdGwe89z/Or1?=
 =?us-ascii?Q?NH//ktC5tONQxyi2fNJ9glMQ52ydxeT0hg7dygsH3DEnBDrOobG3Ibrmq1Ow?=
 =?us-ascii?Q?JbyjSURKT7H5qMaTj5/XWUJ2ukpVFtTm3ou8QJtCL8oOT/uWEjjQ0sCo3Q/b?=
 =?us-ascii?Q?FQ1UKf14Lm57WDHBKBO6Ro97yCX+0c51h6NlzR6aj6mMv3d7belBn8RNlSrI?=
 =?us-ascii?Q?gsXXm7qV/zgWrKUhpFopROFruSsORM9uMojUN4G60B45r4MSvfyNnI8NVtZB?=
 =?us-ascii?Q?PTb/sWmGw65lO/j/dY40TK5E217JHvcz28ecqARRw+1h4xefNJcZp+vB++FX?=
 =?us-ascii?Q?v7PtGMLtToLI+6R1HZ1hTSiGrJyIBofj66mqRrVZdkCumd2oBOSSlErAdVOa?=
 =?us-ascii?Q?NLZRDCnLARAvv22XfXCzJCq7tJmfBZU2zvRLWFU9iDLwWL5JqHxouA8c+dJC?=
 =?us-ascii?Q?MBWSChtqaUGj8nK8ukTvWex8PVSxKrdP1hFn0oGW6h+GDWXOOI1J/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?reNWggYD9WA567AJ54vOHjcghjRPILPqOKIXYGxHmiHAKU7oH/n4Ywoyp100?=
 =?us-ascii?Q?AJheRvrz6+YZKmkrI/9HWUBHFYbkFEtOmxtDkgFa/cOistnShhUu8xFdfbM6?=
 =?us-ascii?Q?agBhug9WFD8jeeepQlkrf8TAlcnSnwkQ0uBVlXewpWKD2uyajjexmXNJUXX1?=
 =?us-ascii?Q?LxO5tnl5Zcd2kc4AX6jAnU3XSVAUA6cpBEg0VdD8iEzsarCSElHM+hN/9R+P?=
 =?us-ascii?Q?Q7j/689faen2vTK59Dwr8ZpOsg3954CHkjGr7IDc4ZjK3yxAwYPjZTPHwri6?=
 =?us-ascii?Q?UTaiRCDlh0I+2J//IwsWjykCnTlPQ4b/gmUOlur+5cKHXK8bHKREmqmpiYVB?=
 =?us-ascii?Q?e7EQLaxojwRwbk7e8fsfVrYxdiAijrjihHxyqMSBpNQOM9EXaqNus2yz+3q2?=
 =?us-ascii?Q?aioAYACGd4WPxhdxKncf+OamTgdq6rOBfB1R34hZhgfW8StCQvnglReKV/Kt?=
 =?us-ascii?Q?Mc9NGRk1ZNnAIFYMSmrMBSOwxwiKXDDN/1VxbaBZ/fQKUXHm5jWuM3TEVPjX?=
 =?us-ascii?Q?JzIg6B20xTrLFr5lXLxLRw2G4m2iOqqgc1T13ChIWKfE5W6ZHrLTZxERXphf?=
 =?us-ascii?Q?oBiv6+ZDSPM8nmQixNaK9tsBTvMVTvlFjQb6ZW6BtB17hNIzGUCKGgKmC4Vf?=
 =?us-ascii?Q?FUq/XkuOnh9o8224Y9bccFqQR8V4WHCUCDJhb7VSImOQSpPMabFFczAcuCzJ?=
 =?us-ascii?Q?YflzrzD2FY9S7P+fInVpWV6gmPNFozPZdoVPZw4spnUNfBMijPt9BZCsO05/?=
 =?us-ascii?Q?ieYi5Zt6sCRWdODBBSep4akCz2vYJBcLXwuOz1aRYMt47dSL2xvqYeIrUxpm?=
 =?us-ascii?Q?iirTtW1GKdj+aJzh+19vuYmIKNNAO73qraukh7czS902W+43+DxrmezLE6qC?=
 =?us-ascii?Q?ZT10W0VWpbJGVkEEAKJa9Smcz930U0QHp5pINJfhwM/E4U4hWnfzKvBPtUVL?=
 =?us-ascii?Q?hTBbfB+QMN825nqJdXjT8Yb8IMd/CknnORCrn7qSt38XyOCgGwwMzCNSj2kD?=
 =?us-ascii?Q?ADCIgXwfplAQdtEhpao9NybMeYvylsyrnWKpD0TrB9EQcP/RYtwCNknCOcY1?=
 =?us-ascii?Q?WbZS0BTqIlxSnNKGOP6jr0F3PP59tfVsdh9HuLL/bwwrrC2fyq0x9p7l+aSd?=
 =?us-ascii?Q?S4oQn/PEgNr/PQGPd/2kpSEOUgRf6snFRMkLo8IT1byyELhTlJMOrhVBeov+?=
 =?us-ascii?Q?/n1iXP9Yia6XhrA4JvI+k/+wAnBUIqIb8H4moEF7QZieevNbZ2p7L0gO9wNZ?=
 =?us-ascii?Q?K8UxNx4Pwx21zRTIo1+9eTkryotuL1GA93ZRTJK3GIOb5QHqDiFk6+v2nhyj?=
 =?us-ascii?Q?XGL/usAdd8BwD0icHz45QcVFDryzgGyQPTq7D4wuj15+rUi5YD7TI3qSM4GK?=
 =?us-ascii?Q?H02mWd1rP9Zh5x8FvTq8fKvftfmspcyMqFh4jEhHLJKbJtxC3GOGSlu2Mw5s?=
 =?us-ascii?Q?kYTi2ekTmvz+YU/weoqURwlgHjVTeIIRKCNQqf1mo7z/fxOxe7/+G9RCga8z?=
 =?us-ascii?Q?1YbDSL/G8qGP4pNeeFj745icNbVIn2/jEDdIt3QWr9lpIFJ3jmiz+HrHJFH7?=
 =?us-ascii?Q?YfJmtSWZzAnkuJoEQzlHCi5JpSJWgmzsm3o/d+JL7RsNev7XPT5WPuT8kobI?=
 =?us-ascii?Q?qp/t+k7BnuxnPXNlsu007O1+BEizQUFNXPg/fY22uwI2gl1kt+TfA0rkR/Qv?=
 =?us-ascii?Q?IGGKy0Wce1gTW9Nr/5vaa3rSHvAO/xQojMK2AhxkkX4MHUIWEBSHC/v/NxWZ?=
 =?us-ascii?Q?BHhoaUytoN5tdS36v+pwtsWtsmJFl61HyA5kP+nMsIsk3njEKJDaL8djX+HS?=
X-MS-Exchange-AntiSpam-MessageData-1: rH4EUJt9UeMPyg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15b3ede-bbe5-4356-49f4-08de520673ee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:14:41.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q3OKxWYB03pJkCe7qibIWCBrfENWFGeU5yayfdut1npMF5FQRO7KerFgO8hFy4Qn3zxyCdUb4sY4tG8Ql2vRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

Hi Meghana,

On Wed, Jan 07, 2026 at 06:21:11PM +0530, Meghana Malladi wrote:
> Add ethtool ops .get_mm, .set_mm and .get_mm_stats to enable / disable
> Mac merge frame preemption and dump Preemption related statistics for
> ICSSG driver. Add pa stats registers for mac merge related statistics,
> which can be dumped using the ethtool ops.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 58 +++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  2 +-
>  drivers/net/ethernet/ti/icssg/icssg_stats.h   |  5 ++
>  .../net/ethernet/ti/icssg/icssg_switch_map.h  |  5 ++
>  4 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index b715af21d23a..ceca6d6ec0f4 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -294,6 +294,61 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
>  	return 0;
>  }
>  
> +static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	void __iomem *config;
> +
> +	config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +
> +	state->tx_enabled = iet->fpe_enabled;

I would expect state->tx_enabled to be returned from
iet->fpe_configured, aka from the same variable in which tx_enabled was
saved in emac_set_mm(). In case it's not clear, ethtool saves state in
the device driver and expects that state to be later returned in the
get() callback.

> +	state->pmac_enabled = true;
> +	state->verify_status = readb(config + PRE_EMPTION_VERIFY_STATUS);
> +	state->tx_min_frag_size = iet->tx_min_frag_size;

What is the range of acceptable values for PRE_EMPTION_ADD_FRAG_SIZE_LOCAL?
Is it safe to accept this value with no sanitization, just the ethtool
netlink policy which limits it between 60 and 252? Even if that is the
case, please add a comment specifying what the valid range is.

> +	state->rx_min_frag_size = 124;

Please add a comment justifying this non-standard value.

> +	state->tx_active = readb(config + PRE_EMPTION_ACTIVE_TX) ? true : false;
> +	state->verify_enabled = readb(config + PRE_EMPTION_ENABLE_VERIFY) ? true : false;
> +	state->verify_time = iet->verify_time_ms;

Why are some values returned from firmware and others from driver memory?

> +
> +	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
> +	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
> +	 */
> +	state->max_verify_time = 128;

ETHTOOL_MM_MAX_VERIFY_TIME_MS

> +
> +	return 0;
> +}
> +
> +static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
> +		       struct netlink_ext_ack *extack)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +
> +	if (!cfg->pmac_enabled)
> +		netdev_err(ndev, "preemptible MAC is always enabled");

missing \n, OR use NL_SET_ERR_MSG_MOD(extack) which doesn't need \n.
Doing the latter is preferable, because the driver still accepts the
command while not modifying its internal state, and ethtool prints the
extack as warning if the return code was 0.
The catch is that openlldp sets pmac_enabled=false on exit, and that
would otherwise generate a noisy netdev_err() in your proposal (but
would be silent with the extack):
https://github.com/intel/openlldp/blob/master/lldp_8023.c#L443-L444

> +
> +	iet->verify_time_ms = cfg->verify_time;
> +	iet->tx_min_frag_size = cfg->tx_min_frag_size;
> +
> +	iet->fpe_configured = cfg->tx_enabled;
> +	iet->mac_verify_configured = cfg->verify_enabled;

Changes to the verification parameters should retrigger the verification
state machine, even if the link did not flap. Also, changes to the
ENABLED state should similarly be applied right away.

> +
> +	return 0;
> +}
> +
> +static void emac_get_mm_stats(struct net_device *ndev,
> +			      struct ethtool_mm_stats *s)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +
> +	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
> +	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
> +	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
> +	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
> +	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
> +}
> +
>  const struct ethtool_ops icssg_ethtool_ops = {
>  	.get_drvinfo = emac_get_drvinfo,
>  	.get_msglevel = emac_get_msglevel,
> @@ -317,5 +372,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
>  	.set_eee = emac_set_eee,
>  	.nway_reset = emac_nway_reset,
>  	.get_rmon_stats = emac_get_rmon_stats,
> +	.get_mm = emac_get_mm,
> +	.set_mm = emac_set_mm,
> +	.get_mm_stats = emac_get_mm_stats,
>  };
>  EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 7a586038adf8..9c31574cc7f6 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -58,7 +58,7 @@
>  
>  #define ICSSG_MAX_RFLOWS	8	/* per slice */
>  
> -#define ICSSG_NUM_PA_STATS	32
> +#define ICSSG_NUM_PA_STATS	37

Can't this be expressed as ARRAY_SIZE(icssg_all_pa_stats)? It is very
fragile to have to count and update this manually.

>  #define ICSSG_NUM_MIIG_STATS	60
>  /* Number of ICSSG related stats */
>  #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> index 5ec0b38e0c67..f35ae1b4f846 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> @@ -189,6 +189,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
>  	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
>  	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
>  	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
> +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
>  	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
>  	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
>  	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
> index 7e053b8af3ec..855fd4ed0b3f 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
> @@ -256,6 +256,11 @@
>  #define FW_INF_DROP_PRIOTAGGED		0x0148
>  #define FW_INF_DROP_NOTAG		0x0150
>  #define FW_INF_DROP_NOTMEMBER		0x0158
> +#define FW_PREEMPT_BAD_FRAG		0x0160
> +#define FW_PREEMPT_ASSEMBLY_ERR		0x0168
> +#define FW_PREEMPT_FRAG_CNT_TX		0x0170
> +#define FW_PREEMPT_ASSEMBLY_OK		0x0178
> +#define FW_PREEMPT_FRAG_CNT_RX		0x0180
>  #define FW_RX_EOF_SHORT_FRMERR		0x0188
>  #define FW_RX_B0_DROP_EARLY_EOF		0x0190
>  #define FW_TX_JUMBO_FRM_CUTOFF		0x0198
> -- 
> 2.43.0
>

