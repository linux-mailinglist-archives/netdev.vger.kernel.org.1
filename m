Return-Path: <netdev+bounces-140441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 806279B6796
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054601F22472
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C9E21441B;
	Wed, 30 Oct 2024 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZHpopI1y"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0566A2139B0;
	Wed, 30 Oct 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301355; cv=fail; b=GPsWyPkhnMkWnQSLeLzi1Sute2gii9/ig4oE8lnUnnBgVmIaZ4Hh0l8K9bidSwJ4BA5ATrmRWGIiaSgvTn92KcLzjqa+zEYuU8qNixs38fki5PPDYToM/JNA+YlVsdN/dx5Eyksyfziwvs4gdTxeNtay6BWTj5Ynwo7KIq6RGS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301355; c=relaxed/simple;
	bh=/uswMhmNBTU/QfSp3HFiSlYiRk8lTySYnk2STvRP+Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g5iAf8lddMCTGU/6rqumW47R89Byunwbe+Ocd46tXl4ff4m3pcVc1SjC6dmwpOMMoxL0C5FXjVdeg5hzxHy9vqie0spu4aRc05/tHLq7C9uAfxA5l9ksURA68IqBsKb977+IRBaP6vWUYo0GHCOgWFkp5Et/Q9P9+fHif5cOgYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZHpopI1y; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COImeH1Io3As4TiktE5uYNghgoobDplabEF3691hy6+znsPOp4Qk050lE7fnkPTM0DHYf0y9aUEMo5x0o/ba77NcAI676CyPf56VIe3tWU4Dh0VzVkyR+yMIojM/xlWAAtsPJEYBBEKxrCV+PTAxfTzJkiw1/MfsNNOc7O3l7EDBhn9v0z4JJSpyIGl9eg7c5L4bQNI6/ejJewF/xT6/B16NCkPU7qciDjqXUxxSvLWQpJxAHsk+y1hX8fxpB1Nc0hxltp8KmZI6cqEqHVfc6NJnFAhwtS8dYGrmFxg0v+zEaZGR98rIsNH6D2qXai8gmylEdWHVHlI16lpJUjOj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR/ya4ZxKoiUB91T7Qyelv/0khZlnpQvKCZnX4073QU=;
 b=l3+tiZEJPbG1TXs6DVfKffqT0xZpP10EtOMRZX9+exIgnxuZML/lkfT/Xb1MTSVbVEByKDO9J/xNPG8zlsqoRG3qMDBzXPCfhmFc/FASBcgPuOjFNA8qNHRYyAw9P1j4IeYroHaj4Hi1WRDEcNPBEtd2wvu3I5aA7VrL/5wltoC69HKCMiEYcZq9juocJPFwoid66pjGOHzDLgsxJcS6OEbs3hj0h1ivtg3dQ3HkWXIhBK3Tf7FzG4EpmS807WBDrOP1lepHokEfCWMSPly6hGvWl7/1pFpJnzg7zcvTSkfM7NIDosrvqtQ6voQpJcq+1TiG5J5DKGO/X1yCSsnYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR/ya4ZxKoiUB91T7Qyelv/0khZlnpQvKCZnX4073QU=;
 b=ZHpopI1yPXhBwnVkVq4CxYoifC0oyZQ4sTglmhJSWNWJTeiFJXmuozlKGhiDfF/1HI7UCdgMZCO+C4sLCUSajlDhMphXrs7hZ/4rL4hbHaAAUV2EVmXKvMQ56R5zjhjhbjy71oZ2GEAZXilmDWKQnGO9DyCRtvJ4etS87/mMv6Mc86ZUZ3KpKvXQiy+9dZIk6BBjvNgL1I4GNARsaSRYx0mXtb5LYTYhhkcVYB9wj9Vn0gRWl0yzPtul2e8g4x4UfQ4YLIe8adYMH/ANx+564WQKR6IMzQfd6VmgF6cchozMGPHfQAUriVZTTIbYgDbZqryKCcd0KGtUC0pe5nHX/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10316.eurprd04.prod.outlook.com (2603:10a6:10:567::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 15:15:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 15:15:50 +0000
Date: Wed, 30 Oct 2024 17:15:47 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, claudiu.manoil@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net] net: enetc: prevent VF from configuring preemptiable
 TCs
Message-ID: <20241030151547.5t5f55hxwd33qysw@skbuf>
References: <20241030082117.1172634-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030082117.1172634-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR03CA0050.eurprd03.prod.outlook.com
 (2603:10a6:803:50::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10316:EE_
X-MS-Office365-Filtering-Correlation-Id: b6973609-59d8-4b92-1065-08dcf8f5bcc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bZpyglXidDogOu9S0EIsiIBesmeshvtFp/Wpcgm/OXW9pP+PRuj8h9nYuHAq?=
 =?us-ascii?Q?Cq77xBgImZaNl8EAnw/96cUH6Pw2K9odYoyraIhwDrrGtxQHlAW/BYIv1BOw?=
 =?us-ascii?Q?alk05LujnGfea9+l8bvFWhibmuDBuAXNYc9JnfXdGiC2I8KQbWepF15O37ca?=
 =?us-ascii?Q?D/8qleafIJ/Mlw5y8tA6WGOPdq53EJcopNQnVpkdHzfNv7YPUg4fGggTDEDb?=
 =?us-ascii?Q?Y0VTWt3oEtq990P9ymUXgEXsoJzYAESQggFStrdT/d6kB5d6aanD5GlvI3r7?=
 =?us-ascii?Q?+X0xmosH8odIEmfaDrFO+5i0G5CISYePxkNWfjsqhW1gUO54yg/SKz2Y2VWm?=
 =?us-ascii?Q?Fp+K+6wGUxZq5FeU8p75KdfV//MkDJqn3JzRuFhg7w9VD9edtKsf41C0q/Bw?=
 =?us-ascii?Q?gGoBJc2oNF54LWME3dH1NBs/kBgzoqjP6MIpEACSJsJz1O55RAOive9VVJFo?=
 =?us-ascii?Q?q3KBI2xa9dhPMNM1Gzi9el5Iwg9B9uphiCOj2DsZhXmZ9Gz581mxhBDD5UOa?=
 =?us-ascii?Q?h9dHRRgUeWPsPKIhKkVHLFatXBqRwEBCpoC1z3ccJvXtLIQT4CiKCI1N+wvx?=
 =?us-ascii?Q?bNin7v2pFAkGODIpqBmf6Y8yT8O7YDPiCpWAUaU8yrEbGPuFZW3YoSeOhNj/?=
 =?us-ascii?Q?XqdS348HixSY8Y1eCWBXrLBzFHZu6xn0zn9unUj7Z7FCOM3dcEPyDEKhYKqp?=
 =?us-ascii?Q?zvqidM1o1VPXSgRiklvTJfPSyRwjkdiHNzYC1obXrjEx5IS+5eR33WgeH/OO?=
 =?us-ascii?Q?CgSU2cIx7dO8Q8ho37CqRZe3z7XUttLjEe3Pcy8dHCU4idO8U3raPY+VY856?=
 =?us-ascii?Q?a3XJCEUUksCipS9mp3gfM3LuWlt7f2AziJp+zm5Q5I0JbPmGzPU7I3EaSix8?=
 =?us-ascii?Q?/Uep8xunxPH0Sgur7bzrbaxDUMu2R8IY/RIGQ8wySptU4Hd5+4P6dqtQGqIb?=
 =?us-ascii?Q?zYpaXVAFVH2G1pmUAdZYgF/kgJv5YZFn5AGFdnLYmhIuoVJ7tN7ja6gbehLW?=
 =?us-ascii?Q?dQqrrQj9rgi1AC/rscNJxdXJT39DCcaRgwYnIETc60be+ya2NhRrLuVIjybJ?=
 =?us-ascii?Q?3R2kvaoouCd8Kn5v7MHVxqaObR2MKys8/lmElNTzr7cCb+RCDqCiECdTH3ID?=
 =?us-ascii?Q?IGkVXoD08WYeuWi6yY9v3QSFmNo4QyV+sR+iyhKYlrwnT2cl9w8neeCMkzv0?=
 =?us-ascii?Q?HTxXf4XmyFUtrwYSAMK+K4wO3XEEe0A3nvGz3KigBHgG9i6Fpcbu+q8axdBx?=
 =?us-ascii?Q?iO898PpztXVKUSJqEzQdzWQ+c30CBiQ4xiC5OYYxMp0nVh9DaaOiIx/0r2gD?=
 =?us-ascii?Q?q5bnKXYQgJmWGrT/fcR/xiOb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pG3RTpoultueX/wM9z3U31LeFUlSL2yUQKnfTb0T8cIU9eTqN7ZYz2zCbLyy?=
 =?us-ascii?Q?kipeOT8v39KSe/50wJQ+jG0F7CbxTAjHjWQEUSnZoIheWJLLCEFIRmdjgqxr?=
 =?us-ascii?Q?8Wepa97YgxGRdkVye0AtkUqzHvKZzEMYTDBy2yrqB1sOE3kJ3XwdAv7CHN0Z?=
 =?us-ascii?Q?xLRDZmt88sJQliKJizrXkvslyDHRldVhT+ebegpUHGKWbsEX7PmZ+nnpC1eJ?=
 =?us-ascii?Q?YWEFz1AWY0kb4bm1rZcjkS9vboKN22dBEiTCD3aOOBnKZFxyEBvtFCwaLX8L?=
 =?us-ascii?Q?iqVULm2r/UAdYRVhR63ZYSFbPgA2wNtdqacsG+Zv+B+/XQ5iDLv5cQ9HoH57?=
 =?us-ascii?Q?u1GBrxxq5uktjQZt5Onrlu09BN6mosPrKr7YQ/nI0WzB7GHoSIys1e9uSryc?=
 =?us-ascii?Q?7ONwTsvxvvxEy3QTileO1YNBOpojABC5YINf98rqooSS00Eorxei3bPAe0gn?=
 =?us-ascii?Q?mMD9KT5wkz3hXyM6+ZdSzroRjuQ4H4qEmOBU85OZp9fSQm6FGcEXpIL38HKk?=
 =?us-ascii?Q?cw8M6vOiPRL/s1m/YS00UmzzY/ETIPbln7RbN6gKdHl6et52USA6s9odFVJm?=
 =?us-ascii?Q?Fc9vsIXVD9lYLsfQQ2SONWi/ihsl0V4BTo5OA//cU74Cu7VL87Fci46j/RVX?=
 =?us-ascii?Q?nJP6y25tdI1/3Q9Tx7dlrnMFpqvrknrVJV34i2LKkqJmfzYINcHBdy8bq6Nl?=
 =?us-ascii?Q?oAgSS2RKJBGPzyHGv7VbqQhDK8nHBRcCby4kF7DMrKWGIYvB7NETgHXx9hLD?=
 =?us-ascii?Q?HhiHDHsAtAv8xQMGRtqlNUiAKjRUAl8XbgYKukr5KtFZMbFRpMArh5sktqEi?=
 =?us-ascii?Q?OVkyGwuG4tMDdARCAY7s3FSwmWEByqPjeAsNh7JyldcnDcQv9oEsFT6bMPzh?=
 =?us-ascii?Q?/ssj6VNLxozy35MG10V4Hbn1pXDGmSM9LANdKToblbS5PLpRKaRIOvtA7bVl?=
 =?us-ascii?Q?fQxqtN6jSv7K2rxZdl0rdJ/lWfcsG5zSJGuOnQlKUMjEWIgjlIWXQZyS7awB?=
 =?us-ascii?Q?aprDV0+beu1olsEb/59dM5guhNJeytO7/5z+FcOVL/PvKLfAxiyvYo5yDIvZ?=
 =?us-ascii?Q?ge1MTCpAJuP/Q2sCkalFz0lO2Bd+kAtsig0BvtGYWJ9lxIcRNk8jFNOjKNOg?=
 =?us-ascii?Q?DAyvLVOu/tMzcrv1UJMUkPoXL2Q4v2axosRHuVHFIiNNLTWaRwCmaXZZEgj8?=
 =?us-ascii?Q?tVwlB9eSNp+42cp0lSTkGqgHxBOKD1tLSdHBRqEtOsmCU1Le2zZWclOZMVuG?=
 =?us-ascii?Q?avr8LPSlAB49hvcEFkPgiGbkL4ma5eqO/1xXjnvE5xVW7/4tM6q2M4xWWc5G?=
 =?us-ascii?Q?Q1FJ+0Q8Ekua2IrTTD65xiCOWW70VxQi/QDG0ueogd0ASnRvYhiYfbvzvm/1?=
 =?us-ascii?Q?zpxSvAJ6yV9ZBsKL+A92TZyRDp6Zus53MhkPNF8Qkh7qpI4+jLkb/sS27tnt?=
 =?us-ascii?Q?APRem5J+N5CKTBcTxJknUDJZ605NHNFYl5SzhOWw9bj/4nJcBGB+1E2LhDt2?=
 =?us-ascii?Q?aKGaF4eL//pXwZucMMzJ+5tIJFFHY4Tmws2kvYnvk+btf5IdLCB4Ttfa/6pl?=
 =?us-ascii?Q?m7B2ukU+xp1UyAP9DWqPTZ85hMagRrkT7B2LoGZiw5NoveuJajZ09Q7axObC?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6973609-59d8-4b92-1065-08dcf8f5bcc9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 15:15:49.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83LcUx0mzQu8zxRKNuD+CJZH23dfI3+qIL+WckB6daJXvIwF/j3epGigtMOnh3X1m3SmXolcYGk/t7UWLeemZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10316

802.1Q spells 'preemptible' using 'i', 802.3 spells it using 'a', you
decided to spell it using both :)

FWIW, the kernel uses 'preemptible' because 802.1Q is the authoritative
standard for this feature, 802.3 just references it.

On Wed, Oct 30, 2024 at 04:21:17PM +0800, Wei Fang wrote:
> Both ENETC PF and VF drivers share enetc_setup_tc_mqprio() to configure
> MQPRIO. And enetc_setup_tc_mqprio() calls enetc_change_preemptible_tcs()
> to configure preemptible TCs. However, only PF is able to configure
> preemptible TCs. Because only PF has related registers, while VF does not
> have these registers. So for VF, its hw->port pointer is NULL. Therefore,
> VF will access an invalid pointer when accessing a non-existent register,
> which will cause a call trace issue. The call trace log is shown below.
> 
> root@ls1028ardb:~# tc qdisc add dev eno0vf0 parent root handle 100: \
> mqprio num_tc 4 map 0 0 1 1 2 2 3 3 queues 1@0 1@1 1@2 1@3 hw 1
> [  187.290775] Unable to handle kernel paging request at virtual address 0000000000001f00
> [  187.298760] Mem abort info:
> [  187.301607]   ESR = 0x0000000096000004
> [  187.305373]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  187.310714]   SET = 0, FnV = 0
> [  187.313778]   EA = 0, S1PTW = 0
> [  187.316923]   FSC = 0x04: level 0 translation fault
> [  187.321818] Data abort info:
> [  187.324701]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  187.330207]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  187.335278]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  187.340610] user pgtable: 4k pages, 48-bit VAs, pgdp=0000002084b71000
> [  187.347076] [0000000000001f00] pgd=0000000000000000, p4d=0000000000000000
> [  187.353900] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [  187.360188] Modules linked in: xt_conntrack xt_addrtype cfg80211 rfkill snd_soc_hdmi_codec fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_descp
> [  187.406320] CPU: 0 PID: 1117 Comm: tc Not tainted 6.6.52-gfbb48d8e2ddb #1
> [  187.413131] Hardware name: LS1028A RDB Board (DT)
> [  187.417846] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  187.424831] pc : enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> [  187.430518] lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
> [  187.436195] sp : ffff800084a4b400
> [  187.439515] x29: ffff800084a4b400 x28: 0000000000000004 x27: ffff6a58c5229808
> [  187.446679] x26: 0000000080000203 x25: ffff800085218600 x24: 0000000000000004
> [  187.453842] x23: ffff6a58c42e4a00 x22: ffff6a58c5229808 x21: ffff6a58c42e4980
> [  187.461004] x20: ffff6a58c5229800 x19: 0000000000001f00 x18: 0000000000000001
> [  187.468167] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [  187.475328] x14: 00000000000003f8 x13: 0000000000000400 x12: 0000000000065feb
> [  187.482491] x11: 0000000000000000 x10: ffff6a593f6f9918 x9 : 0000000000000000
> [  187.489653] x8 : ffff800084a4b668 x7 : 0000000000000003 x6 : 0000000000000001
> [  187.496815] x5 : 0000000000001f00 x4 : 0000000000000000 x3 : 0000000000000000
> [  187.503977] x2 : 0000000000000000 x1 : 0000000000000200 x0 : ffffd2fbd8497460
> [  187.511140] Call trace:
> [  187.513588]  enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> [  187.518918]  enetc_setup_tc_mqprio+0x180/0x214
> [  187.523374]  enetc_vf_setup_tc+0x1c/0x30
> [  187.527306]  mqprio_enable_offload+0x144/0x178
> [  187.531766]  mqprio_init+0x3ec/0x668
> [  187.535351]  qdisc_create+0x15c/0x488
> [  187.539023]  tc_modify_qdisc+0x398/0x73c
> [  187.542958]  rtnetlink_rcv_msg+0x128/0x378
> [  187.547064]  netlink_rcv_skb+0x60/0x130
> [  187.550910]  rtnetlink_rcv+0x18/0x24
> [  187.554492]  netlink_unicast+0x300/0x36c
> [  187.558425]  netlink_sendmsg+0x1a8/0x420
> [  187.562358]  ____sys_sendmsg+0x214/0x26c
> [  187.566292]  ___sys_sendmsg+0xb0/0x108
> [  187.570050]  __sys_sendmsg+0x88/0xe8
> [  187.573634]  __arm64_sys_sendmsg+0x24/0x30
> [  187.577742]  invoke_syscall+0x48/0x114
> [  187.581503]  el0_svc_common.constprop.0+0x40/0xe0
> [  187.586222]  do_el0_svc+0x1c/0x28
> [  187.589544]  el0_svc+0x40/0xe4
> [  187.592607]  el0t_64_sync_handler+0x120/0x12c
> [  187.596976]  el0t_64_sync+0x190/0x194
> [  187.600648] Code: d65f03c0 d283e005 8b050273 14000050 (b9400273)
> [  187.606759] ---[ end trace 0000000000000000 ]---

Please be more succint with the stack trace. Nobody cares about more
than this:

Unable to handle kernel paging request at virtual address 0000000000001f00
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Hardware name: LS1028A RDB Board (DT)
pc : enetc_mm_commit_preemptible_tcs+0x1c4/0x400
lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
Call trace:
 enetc_mm_commit_preemptible_tcs+0x1c4/0x400
 enetc_setup_tc_mqprio+0x180/0x214
 enetc_vf_setup_tc+0x1c/0x30
 mqprio_enable_offload+0x144/0x178
 mqprio_init+0x3ec/0x668
 qdisc_create+0x15c/0x488
 tc_modify_qdisc+0x398/0x73c
 rtnetlink_rcv_msg+0x128/0x378
 netlink_rcv_skb+0x60/0x130

> 
> Fixes: 827145392a4a ("net: enetc: only commit preemptible TCs to hardware when MM TX is active")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index c09370eab319..c9f7b7b4445f 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -28,6 +28,9 @@ EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
>  static void enetc_change_preemptible_tcs(struct enetc_ndev_priv *priv,
>  					 u8 preemptible_tcs)
>  {
> +	if (!enetc_si_is_pf(priv->si))
> +		return;
> +

Actually please do this instead:

	if (!(si->hw_features & ENETC_SI_F_QBU))

We also shouldn't do anything here for those PFs which do not support frame
preemption (eno1, eno3 on LS1028A). It won't crash like it does for VFs,
but we should still avoid accessing registers which aren't implemented.
The ethtool mm ops are protected using this test, but I didn't realize
that tc has its own separate entry point which needs it too.

>  	priv->preemptible_tcs = preemptible_tcs;
>  	enetc_mm_commit_preemptible_tcs(priv);
>  }
> -- 
> 2.34.1
>

