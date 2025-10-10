Return-Path: <netdev+bounces-228501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DCABCC9A5
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787AD189E226
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB3D285CB3;
	Fri, 10 Oct 2025 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TqSF1kdT"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B0BBA3F;
	Fri, 10 Oct 2025 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093506; cv=fail; b=gGQPnn6HTwzcELcP8+idrzXfn9MCscbxT19juMIbgouEGzZLKMZjOcMqMCSGshLSJeHuDg6ZGGFPgYp9MbyTkjsIhlpSYTNs445RGd7QmhcRdWl5BaFD1JypP/reTH3bSrQXlAekvxvHD39oH+I+9PSRqvqacUB3poot8u38iYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093506; c=relaxed/simple;
	bh=ZEo+wh9KOWO7c92nGcLICQEHt0dLcbDtA14qN+zUxbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ch5sNQuSZb23xq9R/FPwZi/Y7gEmPrliIEWHao0RVEk2w4Kx5hwc5W8NL0OD3c8K8YR+yssKLVsuATsGhsyRFh/OghGOzFK6t9ezAD41W9i6CUjku5sO8ww9bqOazFEI/ouy/jBgTFfDxqev5DXCSy8+kanqRjsLCUodwc45hOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TqSF1kdT; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Avc/r6JQZ1FxrZEY+74NW5qGxUVq+cDTJ3Jo5eUZcLGwJjaiglj1AscjRwo7Kd6zpwTFHKL5mFCsJjqmwSq/WVVXFkXWTW/+tDxbbhpaohHi+DbbRHDpmAgIu+Rv+HT85KVZPru8C99lQ0hVKzBEtw1jMd5PSnz+Sjh8d88pT8AFjPC/cdgeihRn+/h6FshnURINFt9WaC0RLRvAfp0nLP/eUItPCFAyoKiMLEK2mKk47Mmma+nz9MT38Vb9GCT9aj0eCLs7dmZoao2/NZgPt38mLFM6medwYKvE+k3uYDhHxUhFr3fsqTbcZq1ibEapxwc7gnj3WQe8IuGxXI0Dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJfladxEqdjkrHrYwRY+AgcutW8Jihgxr+ZD+Q5lBEk=;
 b=TRj+UywJ1cTuyjTuYP9Zqm6QLQR4yNGr5A0x0MlLerIYqR5yTkNRQ6+y+2qsTXid3ztXYESp402Ocri3ZhB9H802MfAijfhlh3ZwtXPM+/Cen5MUJvaVkRT3gN+M08F4CaYTEkrEOkUa66A7UBBA7koDfQhsxZ4nZI3v6MOw72hajom98s9ZxnNax6z62ZHdbjMj05BLHxhRFEZfDkj+u94RdPqYkEZGIxOLZ4Tvee7lOtn+0IqmBuTj/oGsXeXbLILJokBLa5C+oTmh+vJPcl6i/AS/4PmLrEjZCac8/qdfSmZACt4xc8PzEZKC3bXrT/xD1kIwQ7pmL5qKCiN/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJfladxEqdjkrHrYwRY+AgcutW8Jihgxr+ZD+Q5lBEk=;
 b=TqSF1kdTdzuXNpUfgUrJibf9ckC8iCIeEzfXjEjwhqNs9Umev0NJ4FhPBQUwBJouCcT3tiOznOa1viILZfqmHEsECnK+LoGw2XgZ3Yfk6A8/c1NonesQ+hTqBb5sHx9nMVo2oLbqv+H4D1eHua8iObyC4TQGvpA6OZT91gjHdyHJELE9O98araevYFg0xML43U2M55qsEmODxKiyXa6Y0CqRd9456Qmk7KVJoALdOd//6s8okWkyP6WQasrTn3Vh3dmp3UJJRzr0YmMTqaClW8e8P+BH1lXnx3JsBPp3YYlwAZoT/GAlaT6anDopKHD4zll0DwR/8eEPiLiivjzAXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 10:51:41 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 10:51:41 +0000
Date: Fri, 10 Oct 2025 13:51:38 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Jianpeng Chang <jianpeng.chang.cn@windriver.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Alexandru Marginean <alexandru.marginean@nxp.com>
Subject: Re: [v3 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
Message-ID: <20251010105138.j2mqxy6ejiroszsy@skbuf>
References: <20251009013215.3137916-1-jianpeng.chang.cn@windriver.com>
 <PAXPR04MB85109BDA9DCBE103B0EE1F8F88EFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85109BDA9DCBE103B0EE1F8F88EFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BE1P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: a3907aef-44f2-4dc6-13fc-08de07eafed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0bnccRwDFODS/g/eIQr4NCvDEHzrsPlot3kJEht7OPmUqqAvkQ+SMj4U0nTS?=
 =?us-ascii?Q?V3lruxPTWs1bPkPIRnqCLAxO3821ZI9Nx0r+qRaYOxsipsz1f3POx89MftUS?=
 =?us-ascii?Q?dg6CtmgQDDQ9fETqyJXrPYPzEoaS8AALJwmfAQTyKG5607/aYmBEnOHNs3e9?=
 =?us-ascii?Q?fHB8zQiQfZ0AlpsYyoJLH08N/+bJNIDpOisdnKag5rZg1g61gB+bSOCzCcDp?=
 =?us-ascii?Q?afCxpnHqgUgsEgOr4+RSD5L0X046P7uxWU/ajSD2qYpuJ0erZQSIArQnB4dZ?=
 =?us-ascii?Q?uRH0d6rP/IelcHx80bPJyb7kekEjLtHwbKXl1n3g/Adb5rm60EXDqdBa9tSY?=
 =?us-ascii?Q?ey6CFfASC7oROmzl24p2ox43yjvs2gdeIae5bzTjBJgQTOGnp23qcIhfAD2M?=
 =?us-ascii?Q?9yJz7IY05Ud666IQ3Nm4UdPCNE3qMPTvbVUeKL/LbEYv3e/nnCPp9xSplxZe?=
 =?us-ascii?Q?n9Px1G7H8osC5KQ5KZTS6ohf4EVLt1uDSUEsW9ourvEjNwFV+kPEqh4EvIHd?=
 =?us-ascii?Q?2yKCf3BUgMpfyyi60bN/h8KJ6nJZijNOHNkI6SEF80GfbMiMJuyjuc4V8/so?=
 =?us-ascii?Q?tdocZhvzFGt1jFB3waFRWhpxhuxb0j7kiZr+MjSKNInr0HxbQ0gg8U8vNfpK?=
 =?us-ascii?Q?tuMUTY7OoprBT74NYhAoDMqaB05cK+zuQ8jjnf/PZf0DXa6OTBOpV/B0r/VN?=
 =?us-ascii?Q?Ds8aRcGbR2pN7ofaKaAWJwty47+evJkH5+wUPUoYvB0dplz2DdbJRFUOhp95?=
 =?us-ascii?Q?7Rlkl3VhtHHZ/ULgtY4QqGdhObDmNBa2kgn5bXKKYxjPTGPiSVNv5FRib9dh?=
 =?us-ascii?Q?iTMqOrJoSh/t99r6VEey4oTb2UoNgJD3ZvHzqC5m4axIB1Veq1QgGmf2eAOL?=
 =?us-ascii?Q?k08I/VKIV9JIH9h8liKwzZFs4mJcCNZi51oDFmM6Dl/xMMAAN5RSVvyc+OBz?=
 =?us-ascii?Q?z6ijvw5rYKRQWT272R2e1rlrD5zoI6mhMfsbCAd0ylixd4Og2yayRQ0L78gF?=
 =?us-ascii?Q?Q5jFL3cbXOJOrnvPCBcdqbHMzygu4fkvcUPVpV1kYdtKmmMt1XC3c06joPGs?=
 =?us-ascii?Q?6da7zJ2+GJSP1xnrVHuwfP31bxefF5FlkCttS76y9wWsJmJjtHDzYwkrBhUD?=
 =?us-ascii?Q?GiJ9V3aOB64uRAJC/EMncpWc1ddvp6x4e57V6IiMX6BcptBm2ql2SryYU+n+?=
 =?us-ascii?Q?fGogh5q0NTdIeG8X/hURLEXR/6kYeXQ62Gej7sDounCpWpDwW4PzX8dVykEq?=
 =?us-ascii?Q?3WqXPgRBeJ188nfPHmEsaVOEjEpVNsZtejYzDyB0iq3gW5rhn14Oj7xjvVLt?=
 =?us-ascii?Q?xHn6LjIxnUPRJE/62VEayX3zxkQeaQKe8WGnYXC9LrYtinCOiJABQkgGCEuG?=
 =?us-ascii?Q?3HneOX/0J15C5daRstpAIjQo901gC78V71NEjf55m0bEcx4Fi06MR5SaskIw?=
 =?us-ascii?Q?TMjYQzlcpJg4CVCIA+xyHBBGhAiLK1Fj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJAhPuUGR0Urkh0I6NJXIuWo4lGb4khDKN3nqdmUr4p13vOmDhssFgilAv7x?=
 =?us-ascii?Q?k1094GypVB/AHc2eJu0Ke0czUJNOQbTuZ36/X7LlQvh92lEk9kOlsfoVF/uj?=
 =?us-ascii?Q?ZB87SAtt0LJpOjGh5VoU6uophwJ5EEm02M16tmB57meczPrNb/m4m60fGBJP?=
 =?us-ascii?Q?tSFRu/+iZAn0OKgWW6hmTgQEWSm1A+xVg67nYsJX4ovzzFNRtk4f+yuMg59L?=
 =?us-ascii?Q?J0k9vFhVGakZisaLIE2TiivaH6C46Ms5n0rOTSQ5mxWpz82jJrfaKrM6AaIQ?=
 =?us-ascii?Q?PMjSjaScaEtU6HRmWMLsaSFpZ6AnDHgXE4y9AANtTw0cgxmNyUZgBODB1ija?=
 =?us-ascii?Q?s+2ZtSQLbI80X+Uk62ht0zhRJjP5j/FKoWIwNOK5TVm4RrZh+vrt9pV21oYV?=
 =?us-ascii?Q?pbw94K3il4Tv7PFLuBwG22SICiCeWmaFODzu6icMxvJPnvzCR0XfEdBamYQK?=
 =?us-ascii?Q?YejUhh7ktYUe+QgRo3WoM9ggYrdMydT0PyayhUzhTGXAiBij9OvkLGRHIs9/?=
 =?us-ascii?Q?XqxewA05+qpnGqMnbynIBJu59kwwsnCrNW0CTVwUfZiuJ6KReEnsKPv6qSRR?=
 =?us-ascii?Q?UYKQdBzfuoMsaVhvDWrUN4h8C9DRVJDj2jF8gHtJS+d81mERRtnKw0zQgdhl?=
 =?us-ascii?Q?c0DufHV+mSsg2ELcsDqDwdOuwsq0YxK52QSMPRJOjGHprFGdByMcIbaB1UTV?=
 =?us-ascii?Q?/YYxTXojiBqrGfaeIRHPTH8VQe3BWrE+zqvFrJu7ccSm1UvOCDfQvsoyFatZ?=
 =?us-ascii?Q?dfcXRkgahyZYzPKv6u1/qGD6wALxzp5DaMy/4fHJWyzUkTaZW1A7iL6xJWYW?=
 =?us-ascii?Q?R6TbJaC4hhpflH/jM7+pnkQtPlx0MTdqczGipqD6pQg2FzCTWVugbuFMeRch?=
 =?us-ascii?Q?zXxm3sZt7vQmCc1oyXs/YQrWpo2qL8QqgNYtnVBxJ3AUYCgo8URYWJeDH6ap?=
 =?us-ascii?Q?oW8Ggu745t4SfyawWJSXn4bdnFqORkufPBwpb+OpYN99c3Zn8HHGn8G7YvAe?=
 =?us-ascii?Q?UgxRc16vbrz4LNHCPfwjxPNhjJflHjhVtaSyUabh7KmrItSrcNdZwK9uCkuB?=
 =?us-ascii?Q?wVDnC1PTxudiexPOPlTf5knOKbIaP3vALgV8jCfwMqAxpMBD+nt+EliB/nE0?=
 =?us-ascii?Q?ocErAC0G6QISY1sZkMMj1HOU6TwjJ8JHKc9B7pfOZmWf/kDVB23UC+7K3ddU?=
 =?us-ascii?Q?7VTZxCeqdtaArfN2GgUrY91Uhpa6HgQC0il7AScwd9Ld8cKM8RXW2FGOxgNC?=
 =?us-ascii?Q?i0UO1cHfrVyo4XovQX/HJvtUKBJ4EZkg6TYfWT9ZI1CD5a320VwpFTir1s/T?=
 =?us-ascii?Q?SFCPvS+O9Q39qHSoCiYqg0P8yv87B7xi6YqsSYGfxwo7bdgeadqb/Tn7hKQ7?=
 =?us-ascii?Q?EGGla9xN6Y+zQK9FxOAmZ7OIhUJOeYJ2afH9hTurpEnhMQUqYdX3hCjBVUZD?=
 =?us-ascii?Q?t2Dt5SrTbFEChgP/hl+o0zhjCUq2M3iwTuExY8DYEEMpd2i5ZKWLYdXgpQI/?=
 =?us-ascii?Q?NA+yc40S5cbocQ9x0adNtc4zvyYxboo3lUevOI0IykT096ZRINPehNdpRcLu?=
 =?us-ascii?Q?gtVa7aycXl+koXUl1wYD7wzKf/RTXQr0C3efcv2bt/BL7i+ptbioc41Qg0Fp?=
 =?us-ascii?Q?GBwaDft1894xjYdlBq7hprptWJfDV+cjD4Lvffgz6wzD9fF1a0KcPewxdM39?=
 =?us-ascii?Q?+bM5oA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3907aef-44f2-4dc6-13fc-08de07eafed3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 10:51:41.4516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jsg+HOLLlBoDBoJkrKeg6LmJbcD5b2PN46XmwAKBgw6hgePz1GlvHyjrf5LRZYfi94xm4H+CffuUvfLz3VRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708

On Fri, Oct 10, 2025 at 12:31:37PM +0300, Wei Fang wrote:
> > After applying the workaround for err050089, the LS1028A platform
> > experiences RCU stalls on RT kernel. This issue is caused by the
> > recursive acquisition of the read lock enetc_mdio_lock. Here list some
> > of the call stacks identified under the enetc_poll path that may lead to
> > a deadlock:
> > 
> > enetc_poll
> >   -> enetc_lock_mdio
> >   -> enetc_clean_rx_ring OR napi_complete_done
> >      -> napi_gro_receive
> >         -> enetc_start_xmit
> >            -> enetc_lock_mdio
> >            -> enetc_map_tx_buffs
> >            -> enetc_unlock_mdio
> >   -> enetc_unlock_mdio
> > 
> > After enetc_poll acquires the read lock, a higher-priority writer attempts
> > to acquire the lock, causing preemption. The writer detects that a
> > read lock is already held and is scheduled out. However, readers under
> > enetc_poll cannot acquire the read lock again because a writer is already
> > waiting, leading to a thread hang.
> > 
> > Currently, the deadlock is avoided by adjusting enetc_lock_mdio to prevent
> > recursive lock acquisition.
> > 
> > Fixes: 6d36ecdbc441 ("net: enetc: take the MDIO lock only once per NAPI poll
> > cycle")
> > Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
> 
> Acked-by: Wei Fang <wei.fang@nxp.com>
> 
> Hi Vladimir,
> 
> Do you have any comments? This patch will cause the regression of performance
> degradation, but the RCU stalls are more severe.
>

I'm fine with the change in principle. It's my fault because I didn't
understand how rwlock writer starvation prevention is implemented, I
thought there would be no problem with reentrant readers.

But I wonder if xdp_do_flush() shouldn't also be outside the enetc_lock_mdio()
section. Flushing XDP buffs with XDP_REDIRECT action might lead to
enetc_xdp_xmit() being called, which also takes the lock...

