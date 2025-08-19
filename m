Return-Path: <netdev+bounces-214997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4CFB2C88B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BC81BC7052
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8F24293C;
	Tue, 19 Aug 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FV0EPxrb"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51823E354;
	Tue, 19 Aug 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617671; cv=fail; b=F4hiut4FUWcjShukfknQdom0hXMancD9oQvdbU8ohO4tQVqyi27Hva4MIHZiCVs4DfbOZpXxvYtwhS1XWm52+s5PkAfGmCMJ7Z6yHcndf62bKgNUulX1SmwUJxdglyggYGMe3+KudLRw0+e7rwRAXw58EGcSRJhGRHoo5TM80N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617671; c=relaxed/simple;
	bh=xkStL3eqbiY0IFXeKLqcxpWtWmvjZ5P8MNxvSH3yH58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h7J138+azBhFDrwAi8Zuwo8eODaDDKIur1IQmNifdsQRA2NDKIRTGjKypsND0p8RAj7KJGVskN0lwCs7Zl5DUq7SkBsRE6lgbtoVkryaZpFgjtbkuROE91hadxOKu+2kiqnixv+otf4s4LTPvW1DBm/4yDRNWCHH4587Pu/sSAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FV0EPxrb; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVmLxA1o0jk9Xm1JtyO0NR1gwlJ2rXvpjaZLRMLEIYuQsRWdFGkACL2Pu6K5SSQBh4kxBD/05l8EAwmgGYRBFdRXsuQ/M4fypiVP5PtJ5Cmadj/2isv2eBKaXTpN0p0BYbusw8HoippfFgDzby6lGMT7BmiWZRL6LAWCHXPXPD0xxjECvEsn7y98MCMQxOAUK5gHX44/JqzMQjXo3PD4JdEtNmdsh5qCKNauSZUuJlCp7A43kN8cTZSWGQlGNy4faq4SNHx17xRDGYsQe+azaTTMCIoYghN1nVPiur/I+0JbwkQZenHz2nwpJW+H5VyovjCVKy03gUSdDl0vsRF9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsQIYCtn/cRjaJE6Gm1KUS5YroFD19zA387mugAWQJk=;
 b=q7xK/qHO646Go+5qd8YzxH/Ua79Pdt6vmV+SzEFiPMv0kzr0GMtN195Xw67CY5OgDNF/hBEY1lOalF7j1GATnhkFeDRZTOwd6qp4aZmFtCoJk7PKDjjJLsqGRo/mCvrzehSJ0PS6kYDX2uSAC4BFRybi8fjXtVgQr7ee3VUfANZxIMzp07QzSprSkA3yRpDGnf7ce7Sxdj3ew3Htn0QGE9ng5DFzFqFbuVQa2Bf5Hf1UutSfK/Qhe3n6dtvwxKLhgN95bk/FjvzipQUK0qricOdEZsfENuyAPxdKLfXFV0D5Sd0nxeL+Ja3mHqaZMulyU18OigTlIgCbFewkL56SDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsQIYCtn/cRjaJE6Gm1KUS5YroFD19zA387mugAWQJk=;
 b=FV0EPxrbLxw15Y3qIfqX/qBBZAu0jAqXYcGZgswGDBYX8sqjlHJphBBgwfApKOhLlgetG9geO6wBeuihugNd1BMaepB7OTFI7YUzFRy8jg/3oOHhjlHJqgIxgJbMtthKgqJnWfQcsjZTbmMOwqJm8OzoNUl8mwzTyaggBdHqzH75DCzfMWNKIGj7MMupF72chku2Qmfgd4PfBlehDbyOJ+fuM8hNstWznpndJks1qrqdYDo0OyGhZrODFn102Vx3YMvX6UdofSU19EoKzebkV5x6XaVNWkGb3qEhN/LJWDTdhcII25zLAtT5cdU+g33m+Z/j9vfF/uhUBL8U15Tngw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9715.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 15:34:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 15:34:23 +0000
Date: Tue, 19 Aug 2025 11:34:13 -0400
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
Subject: Re: [PATCH v4 net-next 13/15] net: enetc: add PTP synchronization
 support for ENETC v4
Message-ID: <aKSZdagM0mxKekP4@lizhi-Precision-Tower-5810>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-14-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819123620.916637-14-wei.fang@nxp.com>
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8ae05d-d237-4bd6-12db-08dddf35dfab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HqBKo5BXljncVNnWhOJ7UrOggdhLhsVe8er3M9hSP6tBMEoW7o2uqXJk+Sc/?=
 =?us-ascii?Q?aGPi7hAYlC325M9su7Xp1Iic4PoIHE32AWJrT40yvps40jeXtQasrv2tBXf9?=
 =?us-ascii?Q?WQIkjiAw802nOac8d6m8DSlPiAO/SunvrvrsiO55xv7CiEQD+qMdoXI5V+ke?=
 =?us-ascii?Q?6ofMRsWx6oYwCJK5wUF8eSeJWizxyWRienBZozIudo+yi1e7sXVCVOTk8eFd?=
 =?us-ascii?Q?lnZ23Nwy/WvF9P+jBI5xWDPTnmE9zdk5Rj1sJkl8oR186QEbsqOQ6tKoQ9HZ?=
 =?us-ascii?Q?3xufnggL77jYR7fgEmMa4d/r/ZMJnZK8ZrVHwxi1c30MyFMmdgZoL3wsZqoU?=
 =?us-ascii?Q?EIty4f+c9w2lGkL89xvRJhR02RP6tgbkYfL+t422xjKteyNMW6qhhNbpLCaX?=
 =?us-ascii?Q?3OdkTGCVFrU5ETyVBnIqZEh/bPei1y3hvUZ3JLVGqxaFKDiVO5Bcp/EVbzYY?=
 =?us-ascii?Q?Kh3D6gnxYf3g3gylO2drWVXYddOX7vLYNM6zgKFKQFqAQPo6x1MSDQqNf7sc?=
 =?us-ascii?Q?5dDWvRwKfTHbSHhbegPFAlW7RX7yTYKJjJYyFl0Da5iYvLz4fOhFvjTR2dt3?=
 =?us-ascii?Q?MXzB9Li6N25CQm5ZBjsuhZEd3luokzTg2ryj+oc6QEeVzX9rSgvzdAvLda/q?=
 =?us-ascii?Q?t4yid+rmJS8702sSbKhrxJzojn4Vwm49UvqulxiPMBDiqYM4C1sGCIVQyyDw?=
 =?us-ascii?Q?RF6h4+FbmdyI9ob15PVZcI6wnDYPR81l6I5h9EYd/kv77WOX/VSBRdt22q86?=
 =?us-ascii?Q?5xy77MYBcGYBagUypHw/5Qxw5bQC3AmGZbv5hRn/4qW7idj/q+SnCMqB2An7?=
 =?us-ascii?Q?k1gMBQrQPchQd/7Pd2N7At0PJHeYy4TQcxsgS8LLDtepOFFvvlSY2ai3hmvc?=
 =?us-ascii?Q?2rwXPpBMiVM5Q3Avvtqv1H8CicMxuygmQuwskxMcVGxbwq1FL/kpqcbwinFz?=
 =?us-ascii?Q?7yPNQAcb53z/zTTNnPXzmvX1ObsLRg+7VmX8/RyijqM/zdRNcIfm0UkJkY6f?=
 =?us-ascii?Q?B9Hk0rAPWUZQ+urKWSHxWQKD/upa3PxnoOILODHmYiiK7tJOnoC8uM7/Rfuj?=
 =?us-ascii?Q?7VabJnRgRbYVfEEX//qsA8nGAj7Bu2EZdCfbQEDefLEegcAlWVfxGT/vOtow?=
 =?us-ascii?Q?UmTaCvl8DIks9pr7hjBwoLmpcjTsKOCDIKdFWklV0qvs1uRAPYOHyqaho4SA?=
 =?us-ascii?Q?lztb0jeidoOUpFKy0drffj/sW0j7EVWa5zr4SzPxda9NTDFDBXzf4qVBCtke?=
 =?us-ascii?Q?XALPhraFphAE6Sb8HyEwVryT6SR9y+YockYEJzoWkQqWPBu71yOuk9UX+Vtv?=
 =?us-ascii?Q?ofOY5zzTfpesUv6TCnwdSrZWUA3g1JmKkGF0M5sNQ0eoXTvCOXUVBr1M1M1G?=
 =?us-ascii?Q?XR7gcA3N8oN0krePPjsCcM5f98GelU9HU6rahHywObp7Z4EFFCfYghtVegJA?=
 =?us-ascii?Q?BrUPM8z98tKm7ots47TZjAdVH7zr5mcSKaSoGCO/N2s9hWBkpSn9cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hjjT6kXODhGT7+RvLRIXdu0VVM46hiID2DvQg8K/oSr+8tj+1+XcYdz17ub7?=
 =?us-ascii?Q?yRwuZF44vLmh+WEx1VgD4+LuqqaE9z5QGN/mXljy7hptF6f+Nvica7zqbQcF?=
 =?us-ascii?Q?MSZiesdPZVlPxKW20e5LznzC1Z5rKvs/U3rJ/fZWzvXHvBwLvUI/xwFLp1fR?=
 =?us-ascii?Q?5ZD3ud3XJaZxPbbJgxqsvuxoLA5P1Uz3bdeoPZSLMwss8sSB4rnI3pK7Dig7?=
 =?us-ascii?Q?/KQYcaqSek/RUKmv35ig0pwaC7nKoVVukoGkuUe6aGEsnPEDWnn4Khrm6VZo?=
 =?us-ascii?Q?/Z64CIh+sxlW94mxoOxFsZTz2+YJniuOhWnkj96G4T08LKye3kb2jOTGYcof?=
 =?us-ascii?Q?i0v6Cfih9fmDt/FtjxyT6U321RwRZDbWybUIk2uynYTgddCx4rGmjdpcBRe+?=
 =?us-ascii?Q?WF+Q1qoN337z8ZHRR+n2D9oNd5Tbv5KUunBqxd3+H6NT2uwbxG2EPLAKCOWE?=
 =?us-ascii?Q?S7c/09RmzYfM+Q5oOjAV01nqzZAGdamOTZnrjYg2bvrufa5n38ymwek80yE7?=
 =?us-ascii?Q?Doalf36NMWHKFJucqsNr0ivVOWBINLeMmk/HEvZhs2CaOwWYpTLyxrQAgW0+?=
 =?us-ascii?Q?AXotOb073RcVF++enIgkhE8oWLf4LWI9FLzMln+ourF50/ICMszU0OBmkgdB?=
 =?us-ascii?Q?WhLeAk0P2CYodU+vEQG9NR8RnW8DVkvmqVqw1jt7RbTHmcB928OQf0a4DlqB?=
 =?us-ascii?Q?QDGjLvJgd3mPd8vK4KAC07M3B3GDGDn4AhFD7zrJvw8iXtuz+z7YBBH51cRv?=
 =?us-ascii?Q?FwgKe5dr0lXlIiXG3eOHa49CrcwveC5CcdEsaFiddqc5J8wyLnXB20DvhCD5?=
 =?us-ascii?Q?UIqe3EYuIPWtt4Z6M5aIlKOdvMd4/sBHIP68VM0yYP+kp77X/LhO+DtKm3qn?=
 =?us-ascii?Q?LBtyKmY6tHiJ5BSsnD2hQB7Jdrv6T5s+93Sil2MLDBY/V/xrSWXfbkUqVUBf?=
 =?us-ascii?Q?YVKffoBofpDr0EE9PjmFiVNbcLd4/wCVvkv8XViLUgvNK3v+SIXnSn1COTl6?=
 =?us-ascii?Q?F1sqGzqgmJPOUIEpfX+CsyhSAGG9dWrwXzyjLT3ZU/Ap4VhZRB2bHGy510rx?=
 =?us-ascii?Q?L/w8L6eXKACWfsc/L6+sLAGfpIHdAn45yi+feLMN2NbEC50S5Gs9djnbe67H?=
 =?us-ascii?Q?AR44zlDjpac+Hzb3yDrZhSBLzDCRCUwfh0XO4QWOqK7yhuhxdcA2Ls8jAFK4?=
 =?us-ascii?Q?Kz8D2oO1Z4JgS2HmRs5DraZQt/WQE9dno4tVIvB0VnR0jBIlv4GJyDrWxx4X?=
 =?us-ascii?Q?J7hsjlaLiLs482Gy90NcssCRwqgebaF1OYsJiFY2Oaq+C/45V1mAEFWlln5l?=
 =?us-ascii?Q?8u2SjwiT5RHlO7HnXWMcKDmVntMXpR3ivvKA0SWmYVdPl2XMrWzd+W4mmWrq?=
 =?us-ascii?Q?NOXAwrmzA/mI07w2wBoWDQaRjE5SQ3efqWl1SSjQctrwvyvCZ6EQ8XZwl5JJ?=
 =?us-ascii?Q?NLbXHJ6tqHICWoaXRgr7YFQIrI4mmE4qx3KePNJACYihRyM6BUpEvMv8b/yn?=
 =?us-ascii?Q?+tZWlLNmwZLdstu78mecplCWKHwi3h76mCe6TAxilRspni+I1xvISXgqNgj3?=
 =?us-ascii?Q?nCK1ulraTH2roIAaNpPWLhQOHPPvu2gkqUCcyo7l?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8ae05d-d237-4bd6-12db-08dddf35dfab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:34:23.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2omMs84eyGntrTVLvT/7mGf227sfhGDdpXcyMZqQ7aQmgWZNV7VNVF/FHwSXIhD/JeCcKhQ5G1A2VgDlkb37g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9715

On Tue, Aug 19, 2025 at 08:36:18PM +0800, Wei Fang wrote:
> Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
> mainly as follows.
>
> 1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
> different from LS1028A. Therefore, enetc_get_ts_info() has been modified
> appropriately to be compatible with ENETC v1 and v4.
>
> 2. Move sync packet content modification before dma_map_single() to
> follow correct DMA usage process, even though the previous sequence
> worked due to hardware DMA-coherence support (LS1028A). But For i.MX95
> (ENETC v4), it does not support "dma-coherent", so this step is very
> necessary. Otherwise, the originTimestamp and correction fields of the
> sent packets will still be the values before the modification.
>
> 3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
> register offset, but also some register fields. Therefore, two helper
> functions are added, enetc_set_one_step_ts() for ENETC v1 and
> enetc4_set_one_step_ts() for ENETC v4.
>
> 4. Since the generic helper functions from ptp_clock are used to get
> the PHC index of the PTP clock, so FSL_ENETC_CORE depends on Kconfig
> sysbol "PTP_1588_CLOCK_OPTIONAL". But FSL_ENETC_CORE can only be

symbol?

run checkpatch --code-spell.

Frank
> selected, so add the dependency to FSL_ENETC, FSL_ENETC_VF and
> NXP_ENETC4. Perhaps the best approach would be to change FSL_ENETC_CORE
> to a visible menu entry. Then make FSL_ENETC, FSL_ENETC_VF, and
> NXP_ENETC4 depend on it, but this is not the goal of this patch, so this
> may be changed in the future.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> 1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
> errors.
> 2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
> Timer.
> v3 changes:
> 1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
> 2. Change "nxp,netc-timer" to "ptp-timer"
> v4 changes:
> 1. Remove enetc4_get_timer_pdev() and enetc4_get_default_timer_pdev(),
> and add enetc4_get_phc_index_by_pdev() and enetc4_get_phc_index().
> 2. Add "PTP_1588_CLOCK_OPTIONAL" dependency, and add the description
> of this modification to the commit message.
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig  |  3 +
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 55 +++++++----
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
>  .../ethernet/freescale/enetc/enetc_ethtool.c  | 91 ++++++++++++++++---
>  6 files changed, 137 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index 54b0f0a5a6bb..117038104b69 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -28,6 +28,7 @@ config NXP_NTMP
>
>  config FSL_ENETC
>  	tristate "ENETC PF driver"
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	depends on PCI_MSI
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_IERB
> @@ -45,6 +46,7 @@ config FSL_ENETC
>
>  config NXP_ENETC4
>  	tristate "ENETC4 PF driver"
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	depends on PCI_MSI
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_MDIO
> @@ -62,6 +64,7 @@ config NXP_ENETC4
>
>  config FSL_ENETC_VF
>  	tristate "ENETC VF driver"
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	depends on PCI_MSI
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_MDIO
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 4325eb3d9481..6dbc9cc811a0 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
>  	}
>  }
>
> +static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
> +{
> +	u32 val = ENETC_PM0_SINGLE_STEP_EN;
> +
> +	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
> +	if (udp)
> +		val |= ENETC_PM0_SINGLE_STEP_CH;
> +
> +	/* The "Correction" field of a packet is updated based on the
> +	 * current time and the timestamp provided
> +	 */
> +	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
> +}
> +
> +static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
> +{
> +	u32 val = PM_SINGLE_STEP_EN;
> +
> +	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
> +	if (udp)
> +		val |= PM_SINGLE_STEP_CH;
> +
> +	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
> +}
> +
>  static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
>  				     struct sk_buff *skb)
>  {
> @@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
>  	u32 lo, hi, nsec;
>  	u8 *data;
>  	u64 sec;
> -	u32 val;
>
>  	lo = enetc_rd_hot(hw, ENETC_SICTR0);
>  	hi = enetc_rd_hot(hw, ENETC_SICTR1);
> @@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
>  	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
>
>  	/* Configure single-step register */
> -	val = ENETC_PM0_SINGLE_STEP_EN;
> -	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> -	if (enetc_cb->udp)
> -		val |= ENETC_PM0_SINGLE_STEP_CH;
> -
> -	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> +	if (is_enetc_rev1(si))
> +		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
> +	else
> +		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
>
>  	return lo & ENETC_TXBD_TSTAMP;
>  }
> @@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	unsigned int f;
>  	dma_addr_t dma;
>  	u8 flags = 0;
> +	u32 tstamp;
>
>  	enetc_clear_tx_bd(&temp_bd);
>  	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> @@ -327,6 +350,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>  	}
>
> +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +		do_onestep_tstamp = true;
> +		tstamp = enetc_update_ptp_sync_msg(priv, skb);
> +	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> +		do_twostep_tstamp = true;
> +	}
> +
>  	i = tx_ring->next_to_use;
>  	txbd = ENETC_TXBD(*tx_ring, i);
>  	prefetchw(txbd);
> @@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	count++;
>
>  	do_vlan = skb_vlan_tag_present(skb);
> -	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> -		do_onestep_tstamp = true;
> -	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
> -		do_twostep_tstamp = true;
> -
>  	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
>  	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
>  	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
> @@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>
>  		if (do_onestep_tstamp) {
> -			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
> -
>  			/* Configure extension BD */
>  			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
>  			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
> @@ -3314,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	int err, new_offloads = priv->active_offloads;
>
> -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> +	if (!enetc_ptp_clock_is_enabled(priv->si))
>  		return -EOPNOTSUPP;
>
>  	switch (config->tx_type) {
> @@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>
> -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> +	if (!enetc_ptp_clock_is_enabled(priv->si))
>  		return -EOPNOTSUPP;
>
>  	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index c65aa7b88122..815afdc2ec23 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct enetc_si *si, int size,
>  void enetc_reset_ptcmsdur(struct enetc_hw *hw);
>  void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
>
> +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
> +{
> +	if (is_enetc_rev1(si))
> +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> +
> +	return IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER);
> +}
> +
>  #ifdef CONFIG_FSL_ENETC_QOS
>  int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
>  int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index aa25b445d301..a8113c9057eb 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -171,6 +171,12 @@
>  /* Port MAC 0/1 Pause Quanta Threshold Register */
>  #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
>
> +#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
> +#define  PM_SINGLE_STEP_CH		BIT(6)
> +#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
> +#define   PM_SINGLE_STEP_OFFSET_SET(o)  FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
> +#define  PM_SINGLE_STEP_EN		BIT(31)
> +
>  /* Port MAC 0 Interface Mode Control Register */
>  #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
>  #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 38fb81db48c2..2e07b9b746e1 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {
>  	.ndo_set_features	= enetc4_pf_set_features,
>  	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
>  	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
> +	.ndo_eth_ioctl		= enetc_ioctl,
> +	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
> +	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
>  };
>
>  static struct phylink_pcs *
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> index 961e76cd8489..6215e9c68fc5 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> @@ -4,6 +4,9 @@
>  #include <linux/ethtool_netlink.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/ptp_clock_kernel.h>
> +
>  #include "enetc.h"
>
>  static const u32 enetc_si_regs[] = {
> @@ -877,23 +880,54 @@ static int enetc_set_coalesce(struct net_device *ndev,
>  	return 0;
>  }
>
> -static int enetc_get_ts_info(struct net_device *ndev,
> -			     struct kernel_ethtool_ts_info *info)
> +static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
>  {
> -	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -	int *phc_idx;
> -
> -	phc_idx = symbol_get(enetc_phc_index);
> -	if (phc_idx) {
> -		info->phc_index = *phc_idx;
> -		symbol_put(enetc_phc_index);
> +	struct pci_bus *bus = si->pdev->bus;
> +	struct pci_dev *timer_pdev;
> +	unsigned int devfn;
> +	int phc_index;
> +
> +	switch (si->revision) {
> +	case ENETC_REV_4_1:
> +		devfn = PCI_DEVFN(24, 0);
> +		break;
> +	default:
> +		return -1;
>  	}
>
> -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
> -		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
> +	timer_pdev = pci_get_slot(bus, devfn);
> +	if (!timer_pdev)
> +		return -1;
>
> -		return 0;
> -	}
> +	phc_index = ptp_clock_index_by_dev(&timer_pdev->dev);
> +	pci_dev_put(timer_pdev);
> +
> +	return phc_index;
> +}
> +
> +static int enetc4_get_phc_index(struct enetc_si *si)
> +{
> +	struct device_node *np = si->pdev->dev.of_node;
> +	struct device_node *timer_np;
> +	int phc_index;
> +
> +	if (!np)
> +		return enetc4_get_phc_index_by_pdev(si);
> +
> +	timer_np = of_parse_phandle(np, "ptp-timer", 0);
> +	if (!timer_np)
> +		return enetc4_get_phc_index_by_pdev(si);
> +
> +	phc_index = ptp_clock_index_by_of_node(timer_np);
> +	of_node_put(timer_np);
> +
> +	return phc_index;
> +}
> +
> +static void enetc_get_ts_generic_info(struct net_device *ndev,
> +				      struct kernel_ethtool_ts_info *info)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>
>  	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
>  				SOF_TIMESTAMPING_RX_HARDWARE |
> @@ -908,6 +942,36 @@ static int enetc_get_ts_info(struct net_device *ndev,
>
>  	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
>  			   (1 << HWTSTAMP_FILTER_ALL);
> +}
> +
> +static int enetc_get_ts_info(struct net_device *ndev,
> +			     struct kernel_ethtool_ts_info *info)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_si *si = priv->si;
> +	int *phc_idx;
> +
> +	if (!enetc_ptp_clock_is_enabled(si))
> +		goto timestamp_tx_sw;
> +
> +	if (is_enetc_rev1(si)) {
> +		phc_idx = symbol_get(enetc_phc_index);
> +		if (phc_idx) {
> +			info->phc_index = *phc_idx;
> +			symbol_put(enetc_phc_index);
> +		}
> +	} else {
> +		info->phc_index = enetc4_get_phc_index(si);
> +		if (info->phc_index < 0)
> +			goto timestamp_tx_sw;
> +	}
> +
> +	enetc_get_ts_generic_info(ndev, info);
> +
> +	return 0;
> +
> +timestamp_tx_sw:
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
>
>  	return 0;
>  }
> @@ -1296,6 +1360,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
>  	.get_rxfh = enetc_get_rxfh,
>  	.set_rxfh = enetc_set_rxfh,
>  	.get_rxfh_fields = enetc_get_rxfh_fields,
> +	.get_ts_info = enetc_get_ts_info,
>  };
>
>  void enetc_set_ethtool_ops(struct net_device *ndev)
> --
> 2.34.1
>

