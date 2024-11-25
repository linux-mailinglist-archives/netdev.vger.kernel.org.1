Return-Path: <netdev+bounces-147249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF29D8B7A
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 18:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91209B2340A
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3E1B6D0E;
	Mon, 25 Nov 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jcWaad65"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013048.outbound.protection.outlook.com [52.101.67.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF8314D43D;
	Mon, 25 Nov 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556565; cv=fail; b=aQwfKDT3Thf4Ct7pVowEQgiTx8qekk8MUqzwlFFs7iebGmo813M25+ksMCK9CC3rq1kB7LgAyXKVAejbPLfVYXnUKQqyG2hksY2+dZzUWMNViInehaIo7Eg5iDltQztrQ6QqLzvIzLfvy+kDpIZGqELIVm1KzSrw/q2oUK8rXDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556565; c=relaxed/simple;
	bh=h6TtAyZASwm8bFJY4YrVDF3wgTMY2fr9GX8l6S5PUgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rKIG90+eB8IWiLp4XjEek5LY8YTybK/c5Qdsdac1J8k4Ab+vZ0JtxUO+lyLwbdFJb3UItaHcs/M+NXq8RIz9mwoPMM14+4ryOn8phRtdZezCxospZm+17g07maKibQyAXGxpz7GJhj9XxjQKuMDa4CvjzrF3IMDXq4kQ+KOkG/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jcWaad65; arc=fail smtp.client-ip=52.101.67.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ta6XGPGOJ/W8tpWC74bv8jZsT4Xz+QkMiy7OBiG5zdMfn/86OHp4NS7IVt0SpraeXmoLfdUQVYPK8IptHxmkjGUhJLZk2QafRUIfI9T0eN2yd3mJ0gZkTeuugzRIAQ2O1kSpSNYgQIkhlOQhG0TGv/0YdDtHPp3FZ69CZJfyszkw3bUaOSX88rcNSg5yL1qc5T+tuApmnrXmcfPlWEuL5AkZnSCKCEe7Eytm1GmWNXxkVVbC/7f2WgVWpPbmPKSwvTRkK2OmrOxGIgWLHBQnpbDrPbJt9mhwxzQIJ0e9ptfx5CWrjIQXTYpVlyk4TneaCSQpS/QmTlA/KzkHplX9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crC7kxB8YxS+hSVaysQIzC9koJ551rpeOEeNT3741Eo=;
 b=gCxFG15aLE4JMBEh4OUzBuQ9mIIhippcDmHuRulMVfoXFN/kvqgenvZVZIc8HyGlyM4jUrfMTUIBxqOifX+vvVfFzZUSdop4MppOYiYsz7bW5Ica3ILgYeO1gjYpFhF3G0pdSoUQuLJqyzhYwr3Z2Z0mW17raiSsisdWYCiZ8ep6Wdo7/+DjUkn5UPzJhBCkgvqT1owAjqOR7MGONGQXwmpNjMkV1Sr+X0BtsoOtos1BV5N52VfGpFBSX7dl8fBiGTtUwESQ/8dNk+lmUUWwpOCZ/eJC/MmuwJZfYHVub0ob4IKY3Zcg5ACohS7S/AgJQd2RFVpC+lYcmCqBiWcjzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crC7kxB8YxS+hSVaysQIzC9koJ551rpeOEeNT3741Eo=;
 b=jcWaad65ST5H3mTsi4lrWBURHpp5JpmWAVDQei71f2viQWDUKOPdAteqY9Gxfh8cOVtHlJ17JBk9a0bdEl/oukxfw+Y9q/KKpnq6f9mtE5CGR2lCOMnxw0chvofuPqMpiY0Kx41foPKiup9c0t9T8W83LHvNv6w/NSmKA5+oNPlzf5DeEJRT2pu+0SzFGIgXFtIzrx40y3ZZ2XJRCkKaJ07yc2ooWkN6g8zn7fRj/AyXIzNVCVjoJ7MwCbrqM9h9hxJV+Rq1lqsC1YyX87kWyalV+8hyZtre0GAvrNaB81LTDKycY/B42bZ8ATPhXE8nhw3D3Dp8vxBC6zEkCUAScQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7362.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 17:42:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 17:42:39 +0000
Date: Mon, 25 Nov 2024 12:42:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 net 2/2] net: enetc: Do not configure preemptible TCs
 if SIs do not support
Message-ID: <Z0S3CEYeGSWLPKVh@lizhi-Precision-Tower-5810>
References: <20241125090719.2159124-1-wei.fang@nxp.com>
 <20241125090719.2159124-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125090719.2159124-3-wei.fang@nxp.com>
X-ClientProxiedBy: PH7PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:510:323::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9df495-941f-451e-0871-08dd0d788e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LzCbjAF5jDgffcTjWjeg7wxF+qhLOExjBLxRy3snCd6Es7S7X6G0G2miJR21?=
 =?us-ascii?Q?GTIDGwnDWSQvkJgmDYouqM5+RZGEaI1CD+DbOjwOh3iYWW7GPsIhPYDebOAR?=
 =?us-ascii?Q?Vxfrc6TcKo1Jce0ThB4BNfSkIxzJV2ERNFnUzysXKrLQ55SiXOpTMGdNNdmT?=
 =?us-ascii?Q?MhUKmGP0rAH1ru/CYOyxtTf/3Q/ef7h7pUO53pVHmUtLp7eENPXJzTRtxTNF?=
 =?us-ascii?Q?lf25GB1ubmIG/9vqNJttX0YIKoxsihaSeurAFGE9InYjMpbiHDyzhTaJXAFh?=
 =?us-ascii?Q?kk4RVGwF6jgUtPhdseThnfmMlQVW/gu1I7SuIMcojZ3CQ2QVbZR7m84ls1GC?=
 =?us-ascii?Q?ox61YwKsVoYuF5VutiIHCWz6GSdmdJSOdD8s6fl9pr1dKI7i9V5lS0h2sS1n?=
 =?us-ascii?Q?Ki4JC+nymJwYacR2yjVHxvuLbYeCgERjJxrfJMOhn9pBXu3zElu/+i2ZzVF6?=
 =?us-ascii?Q?LPxhQTSKI3lzlAy4sJi4NU/sZ2dh8pPKB1ptlgfQoaDFqQSdN/qAgcPT38D/?=
 =?us-ascii?Q?EZKg1uxdUmFm4ynhbbgl1tSCfGAdx5gAWKTNvkq2ZlfYRiivpxLLsy5Ml7GR?=
 =?us-ascii?Q?PPFzDL5BK5ujGp2KNGcPFUfhno4mdBad+EZwgFWjuREalInyIGPbWk3Ned3v?=
 =?us-ascii?Q?IbQKrPrmkCHkKBPUDpj9vUE9k0x79RPfRmr2gOEF0MTe1pQZ2kieTbPXLZwu?=
 =?us-ascii?Q?zdrFls/Irj5ok6N3sCT6h5ceFrcEzAWvdLe3ohXBHud0ZuBI8y7z02Ej+Xed?=
 =?us-ascii?Q?6lC/0OV+ZkaXIHLI2QXtbAIav980gUdbSlxTaDdYB63dzAtmLzEUdWF1YY9j?=
 =?us-ascii?Q?9fYj9LFBpjmzPf+sylOTAbvaEEBtBafJGlymgLE3ATzsrezlZoHrtffFJFb7?=
 =?us-ascii?Q?G4LLn2Bs6deg4DG2zLDu64jSfnxDblzp6EkfmRQ33HOdslzvxEbFf2/hljQL?=
 =?us-ascii?Q?mhzQLhhX1Et8A1X7cEeCQCcBkluW+ZeSVFA0ES82QrmmKN+b4JzLxxNUWETK?=
 =?us-ascii?Q?Wi6fVseLJcfGPDEoY6+eBA0Zb2uJJZ+6A8jLh0IqKOrJyepNO6ELwjeEeoE1?=
 =?us-ascii?Q?ltRk6b7oWGHDg1RwLQV1hjezrql0e6iY1yh/MlIIWoVgmxyyZhE1qPtP9BEe?=
 =?us-ascii?Q?6jvxe62as3KxiOB/IA3XFV1+WyvxjfkGYI01G/18b/6vHawMaH6uRUkIVT53?=
 =?us-ascii?Q?D66WFTJDsc4S0WJ50iL8ICzyC2Vwe5fWcWgBPVj6N5FvZHnlpVBzedaq/5Y+?=
 =?us-ascii?Q?f0DPmPLrYUAwd5DHqV5LVXlScnLmtb/aAjlxdfNETLmZAHdYc7KpcLFz8pXB?=
 =?us-ascii?Q?nfoyTanfOm16RhBsiitnAhVJb4ED8RmKsNXTpFHQP9SKrkO/1uqyUHg7xn9g?=
 =?us-ascii?Q?rSuthd7oW6uhjbEnUw61XY4+cUAoxBBeh3hevETtpzkNPYm/Lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NlDGd4MY+n82XPwW8dO9Z+hQy4UjspXdp7+epYtp4moUL3VPtjgG4yAfeR4N?=
 =?us-ascii?Q?bN4n+J9vWi64/OoReE/CyXYJA8fRiavzBKK/Zj7SL6jUOJDgvx+sVsfG1f2/?=
 =?us-ascii?Q?DXFN2NTz5Uf+puRqZFJ6edeQRVkY6M4LrmXQ6HobT/dpjds67V7JBcBeqGmT?=
 =?us-ascii?Q?QP17AvmDpiz+3j8HxU7NufkDYOrv8yGaTthadHDdSuEMj3GFHNqgKXL/w+C6?=
 =?us-ascii?Q?ZkmQExrwDsjCE37JFWc4cngeEfEFM41fRwCR5eTtx68PzxSFg2Hdw1nw56Ta?=
 =?us-ascii?Q?YRu71VOZnKvZos8MWxp6YBe4UEH/wev0hHIWZEyGB9+eqh+EM59YBvLDpG04?=
 =?us-ascii?Q?wXlwHdtRh3nzZajKfEy51FYVRPOQ3+4Zd5IuYfPM/02NbrVis+zb8iqCb+2U?=
 =?us-ascii?Q?q/mtBJtn4tsiBiL85u77RBXzgKiXriJ72g9JB80OF1Aob3nfAnNagSEeducS?=
 =?us-ascii?Q?0wDxmUTkXlxg3/zezQhesIYo1Fqpa9k0pKE2K3NtYEyCFmXkdvPV2suawDj6?=
 =?us-ascii?Q?Z/oG8sgOveRSDVoVfmzMakgqU1dIqO1E/HEzUP72rixXcnmhN0+y+5j1vb3u?=
 =?us-ascii?Q?OrfGjjf1AAFf1aSXIOa57pVFfxjPwWzoF306mIqjL3aOzqDRStI+N6TsSxdL?=
 =?us-ascii?Q?aeSP3rnM83CDlCT/NSzX6fvGkAbTA15vBz1dGosCB1aozVu71Dz26cigK2he?=
 =?us-ascii?Q?/BWUUoMb0l7dgYqhcPJi1kAeQkrHyCNqhJ4P+Px6s7mWVpP1Dw0UTZ0t2BGe?=
 =?us-ascii?Q?MqL1p5iY9TnaAzGNPjcMLkps2BKptva8xp1hN1vYzXPHTrM6djrJ2Sxb/Q+0?=
 =?us-ascii?Q?xWOnZweBHoUqsadUxt1xirVYmS5nzXhOZCFOqiSJY08dCPFj2Kbvl/kYJXsF?=
 =?us-ascii?Q?XSnzDffCkkiuWLGU6Sce2OZ2yA4oBJyCo1g3GbXzUn+N71QI9sQ42cjYgyxx?=
 =?us-ascii?Q?+fz/x4WZhJ7dnLhPQzQ/pyn/0NEp2PMP/fwUH8dRasxiU9O14gRXWTnUkCOJ?=
 =?us-ascii?Q?a/bDCaeuSVMbZJyrOKD9auCv/KmcYfKWFfvEOoZUklH60fkf00v9+nu3kLyE?=
 =?us-ascii?Q?0RYoQyB0U65E3m6tHwhUZW2BWzUpB/OUJ+c0pOqOaiyk1pewm9w+pCLzTMGD?=
 =?us-ascii?Q?Nv3Uvmtr1zWPXG8V4tT4oS8AJoNDlLqlt+kzJSx41t22+pc0iF3fxrvZpbOX?=
 =?us-ascii?Q?JpUHLTo8Z4IkIzLNBiu3W8jILgJe6HZXXIPGLt5IWA7tbACbWYeyw/I+cOgU?=
 =?us-ascii?Q?GRtrUPrf447gx6bLA9uTQWVVzlR2x5rAmA6h1pZPSMLaLyNH3zJYduoTWgOm?=
 =?us-ascii?Q?jiGm4jwFactHurhLIkUNI9qAtg+fDRDngVIiFIV8QScxVwyz3GnhRmS8ezIZ?=
 =?us-ascii?Q?fHnPAdLaaT8S/g1wVKt6r9v1oIH+j8I8is6fhlmiXjzBGmTK1+MFP+fnbx55?=
 =?us-ascii?Q?SBHo0DbCALB0GDvt41NOCedply0C5ICcQoL7KYXKNjDkid0DHjwN9vPFfIG6?=
 =?us-ascii?Q?ocqBxVjkZh6EquVeUliS2w7/nyYTycE92PwXYFvaOQV9hsX4tTuQx9Xj7zms?=
 =?us-ascii?Q?PAX2HqUjcOvTn6ArVB8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9df495-941f-451e-0871-08dd0d788e74
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:42:39.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/Fs4Oi76ElWCTc+8dYkJGopP2C8pPnJzt9IMVAnmxL9zpP5++fblFwt2eRiNFXnnlZi+1tEBvn7mLtFZQ7Bfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7362

On Mon, Nov 25, 2024 at 05:07:19PM +0800, Wei Fang wrote:
> Both ENETC PF and VF drivers share enetc_setup_tc_mqprio() to configure
> MQPRIO. And enetc_setup_tc_mqprio() calls enetc_change_preemptible_tcs()
> to configure preemptible TCs. However, only PF is able to configure
> preemptible TCs. Because only PF has related registers, while VF does not
> have these registers. So for VF, its hw->port pointer is NULL. Therefore,
> VF will access an invalid pointer when accessing a non-existent register,
> which will cause a crash issue. The simplified log is as follows.
>
> root@ls1028ardb:~# tc qdisc add dev eno0vf0 parent root handle 100: \
> mqprio num_tc 4 map 0 0 1 1 2 2 3 3 queues 1@0 1@1 1@2 1@3 hw 1
> [  187.290775] Unable to handle kernel paging request at virtual address 0000000000001f00
> [  187.424831] pc : enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> [  187.430518] lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
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
> [  187.606759] ---[ end trace 0000000000000000 ]---
>
> In addition, some PFs also do not support configuring preemptible TCs,
> such as eno1 and eno3 on LS1028A. It won't crash like it does for VFs,
> but we should prevent these PFs from accessing these unimplemented
> registers.
>
> Fixes: 827145392a4a ("net: enetc: only commit preemptible TCs to hardware when MM TX is active")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v2 changes:
> 1. Change the title and refine the commit message
> 2. Only set ENETC_SI_F_QBU bit for PFs which support Qbu
> 3. Prevent all SIs which not support Qbu from configuring preemptible
> TCs
> v3 changes:
> 1. remove the changes in enetc_get_si_caps().
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index bece220535a1..535969fa0fdb 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -29,6 +29,9 @@ EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
>  static void enetc_change_preemptible_tcs(struct enetc_ndev_priv *priv,
>  					 u8 preemptible_tcs)
>  {
> +	if (!(priv->si->hw_features & ENETC_SI_F_QBU))
> +		return;
> +
>  	priv->preemptible_tcs = preemptible_tcs;
>  	enetc_mm_commit_preemptible_tcs(priv);
>  }
> --
> 2.34.1
>

