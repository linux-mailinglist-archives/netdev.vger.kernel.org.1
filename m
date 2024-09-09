Return-Path: <netdev+bounces-126545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4735E971C40
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE18B20E26
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F8C1BA262;
	Mon,  9 Sep 2024 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CApRbsfz"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298791B582D
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891400; cv=fail; b=ZRnf335QQ2VydPoDdTRi25mAmoAp401AwFpnxnuZ6G+UoVhJIJT5xlFtuaomPgNsVbQues0LuFuA4OP16p/hlk3JQwU1WEfnMdEz2iAO5ZvOU/O/kFNAYVDPqj3OqiGADlHjbRPIfcRh8eAUQ/Ahjseul01K2IUWw6i3ggdaoY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891400; c=relaxed/simple;
	bh=ufQ10w3UzKUlN36bjjKYLnwbf2paCGvKhKH868lEstg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H197Mt0dzaN2xGIBPKt+HzcHtBBn9sdFZSdyCOQTRNMU5OSiLZIEq8GfEV+QeKBXianHlEfCh28e8Al3BHu7pb6+8Q1zHbBvn320HeHdzY79bIU8xrulqSOCwbobHWZQKueWf5ew25V7Jbv/QEiDPyOAhYkdMk6NZ7s2KEMTyJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CApRbsfz reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD0xBUsNSYye76laUeX8uVwgJ+OkUfXWsfANWk2pmdxiuuF1ay99o7s3ckLkw+oVWl8do0sLeCFLWFchJPOGCi0jLlF8nbHGJjiRrXDqoL0hOOMWfS7TPxA3dFmuFDXbD/XiUpXkAI1H32XVf9T0BzQWgGDekzKkkea1dJMp+VaZk8i9VzWd2AjXrpPBusGN1w9cXAlftT8CKWvhdj9xTeVJyLhBA5feYCLjaYUv30WT7ydnxo9bot4ykeC5nskRrbXhvINq8Np1oVdJwcORyKo8oVdFp6Yadj/UNW0vvpB+D13qice2ZGT25ey9geTn4GVVF+UJWDyhbAZJEWAoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnDwcpEnFC9FRGP+yDJA6IytdHGsS1oRYeQ62SMwsGw=;
 b=IUpZ9yM+gS/5olaTFjeLwrxfW5ef61pI+GaO+bHWDw7AeXhHkhYl1CcVq/NT9O6Q66zOLfrE6fsSBY7WpXkpOXo2w9+YZq3ccdKuxWg+bOTu2SDWtQI9rhBGnTknQeiXC5ibNc4mibgl/dzjTOI17zU3UOLihfhGA6sU00wd+2BMvg4EsdfQXS9dio1RAFjCkYYdiysPhysnMslfqFCAf5022lPXn2wEpzoK+stcgCCpIRf9eaV3B00zpmPWl2vQOSgGblZftmPSDL9grvV4sAEm3HHEY23FqFs+5voxkn/xMafI9ljFqSB8yY/mGcRQQQgNRbMF3/iuiHz0c1dgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnDwcpEnFC9FRGP+yDJA6IytdHGsS1oRYeQ62SMwsGw=;
 b=CApRbsfzEDIxfq4Mb9w5fEG7QRhEF0ij20tlo+ucZovtkXRmDJ4hLIWbyd0q/MnpBQ1gJDW+/R6vT0FGqNr6E+aSCtZiElig9zHWu3YXdynMlZvNK1y34iNl39TiDk3PkVHZZkV3hTouAafAtO9eyHdhO1VPIkgSIS8vCO9IjD2CS5Pi0m5k6vrOMDRdSXoCj+X+FKm61JU4qKQ0M5FEwmMbu2rV46niikDx4stFtkamNcDvBJqd6JQ5cwdljGcSS73hmCKnMgK+eLDC52/BAWVLBHrv4YeR/APhYrCTTQJ0iZkk4Q2f0JbEQBhxWjrpDIR5td278S7KV8UfcI544g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 14:16:30 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 14:16:28 +0000
Date: Mon, 9 Sep 2024 17:16:25 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"daniel.klauer@gin.de" <daniel.klauer@gin.de>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
	"LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"rafael.richter@gin.de" <rafael.richter@gin.de>
Subject: Re: [PATCH net] net: dsa: fix panic when DSA master device unbinds
 on shutdown
Message-ID: <20240909120507.vuavas2oqr2237rp@skbuf>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
 <c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com>
 <7db5996ef488f8ca1b9fdc0d39b9e4dd1189b34b.camel@siemens.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7db5996ef488f8ca1b9fdc0d39b9e4dd1189b34b.camel@siemens.com>
X-ClientProxiedBy: VI1P190CA0046.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::11) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e961cd3-1315-47e3-0a56-08dcd0d9ff10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?t3V7j98VJ2adCjPSiXbCEUDjSKbaSETSjoSBETqspZMa1CbB7+eNy+jsI3?=
 =?iso-8859-1?Q?AneHuYsDkI944M2ow75WEfl4enDwXUjg7A1r6pXD3YjdUGFenqyg+x0Pd+?=
 =?iso-8859-1?Q?wD2ERxHEOTI+iMfXs7P1922RgAjPe66JKBjvMBh1lB9vbh69w/g8F0DuH2?=
 =?iso-8859-1?Q?nC5WIsPXG6ZqE3oI6shJpk3MSidvd8pbYuycRrBFOMZ9kWcdZXEBbTvz8m?=
 =?iso-8859-1?Q?cz+uZol5T4IIcG0aIL1gPH5goSac7ZNQlKdg6WWjZ6zq7WLKi6P1UMDcdd?=
 =?iso-8859-1?Q?+GeGMu2sUXvDfNiGg7rdob7qnhvDOOohQmBihRE/CdS/rvHL4yGZz5qK7z?=
 =?iso-8859-1?Q?YQBwepcNb72nPyPh7Rjwge+UStrhC5L9wgkqGUduF4x1s5ni28CTkl/NHT?=
 =?iso-8859-1?Q?tAbS8zWnXB9AUW2xrkQQnUz4tNK2sxcgmSXZRpjRZyOAy83THUFRBR0x4e?=
 =?iso-8859-1?Q?SRc58XqTql9CapgDpP00wFQkN73Gz1dKClfQuSWiu+CVxGacmaSNKJiRVP?=
 =?iso-8859-1?Q?ECbS5OhzW+rcg+FMEfzBorQYS0qBkvMEI0sn21nVU3YUD+3F3f2sbEVqSS?=
 =?iso-8859-1?Q?lv83YWM1/bJefA3RYOTif06dyyWiOiPWfqb7Rvb9uVZMmew++i8frM4hem?=
 =?iso-8859-1?Q?uALQyBocL+U9Lb8berjcc6xL3n3s7D2veALyZiNrXnwdu/7Z6AvJcZ4sZA?=
 =?iso-8859-1?Q?nVcymDy1oS05qJyD5zHjIJOiETMaJ1WSHPfSNHzJsLGcqjw1itQ+mpaYvv?=
 =?iso-8859-1?Q?nQ7bNmdfOz7gNuxbg2jdagCeNx6SKfUmE9XkXtyzBB3aOTwSBVd+gxytj2?=
 =?iso-8859-1?Q?njP146slAET9pHBcYGfSXve7As6qP0QLfNPlSyRuSRrHUV2nnE98Ww7CUY?=
 =?iso-8859-1?Q?djb9S3bjtnIrW7FzXqjsY0ZZ/+Jwy7zm7dk5cvt5Ghc5WDF+glgLPcpIKt?=
 =?iso-8859-1?Q?qdfGMS56Tu/cU/c5GPVzSU6gYp6gpgtCPKq0U9Lu1LmJUs7zGnhHBWIYRZ?=
 =?iso-8859-1?Q?e+1462cNgwTSAByUT5bI5l4eLFEZnx14Jh94VF+sO7JvvmDG7wW3f1ums/?=
 =?iso-8859-1?Q?wMX49aVy7skXnjQASF6umB0ICVwtltVCCwtXCaiQ/Ccfj8YgiVxtP0zrPV?=
 =?iso-8859-1?Q?XUKmrd54c0cOSQnpwlw+91ykNGfH0JXse1QvPaj0FW5kb5k0G06FihHiVi?=
 =?iso-8859-1?Q?xoBYw/2cmr0UBIKMcLrWM0g8xnYypbz3y2B+rdv/ipDspL/mqvdpRjncM4?=
 =?iso-8859-1?Q?Ug2D1jpEfmOyd8BvrRqkbTSd/N5fZlGazRCEbCY7Gsh2M97lC+4AXxalh9?=
 =?iso-8859-1?Q?wKIwqMUv/BbRl3IQtl9zO+3WrYeZcpEos9qyK1n1iiqQrSRf01mxHL8mt8?=
 =?iso-8859-1?Q?AYMe8CsX0T3l+6zLOoVZR9N/01QYJrvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?9zYTnI0dq/PXs33/sq0SgabH3MVXu/DW5nZgZwa2MXsG+uyqyyGh20n4EX?=
 =?iso-8859-1?Q?j9xXnArj0f+mePeuIv/Sd4nrLhalZCMYGIv7FtW0IOVTWEoCAsAnRrzmCn?=
 =?iso-8859-1?Q?cE4EFeyVxJ+sV8Lr0ytFYYtlJCxdOu1HzWtOUP7/kEb2JLwFdyrDbl9qVG?=
 =?iso-8859-1?Q?RtRwFouf5uvQYfhra7ELZX5U9xZihl1C0+yshi/+CEpNr5x1WVKeLf1Hyo?=
 =?iso-8859-1?Q?Zv0TSRBXuiH0sl6Ro4S6bauop56a+g67NCwMjDHYZ4YDPNVf+fJDT5XVOI?=
 =?iso-8859-1?Q?0ZOx2vBxVX7s7lUFTaD7yGtvNmjry22Juwo0OL88fgKJ4GPUzqbMs02CTs?=
 =?iso-8859-1?Q?Ef2SLm5jamfgr+96wDHPh2DXPj+Nm+CXNP41b4yYbhOZd2by+TkDhxZ0IW?=
 =?iso-8859-1?Q?UCd7a/TlRKVsnM0MigZqS1tuHY9x3cq4xptanF8ULCrSOVQskrCOvYDO9l?=
 =?iso-8859-1?Q?yj0DGmDizKh/tZWXMBt3kCxgcs72jmFXMhR0NIUm8HBZGF9mQSH5oUmgag?=
 =?iso-8859-1?Q?IWXkJ8Xes/OfCxJ3v+5mNe7kgNUrF3O8ysI5LYNx66V3JCcZCmI8PIRo3z?=
 =?iso-8859-1?Q?6xlJJzRwY8pBJREngflIMsLdsoT1HnY4keiGPgefU6i+mA6jmok/MHb94h?=
 =?iso-8859-1?Q?DDJGBKD5k6KRtx610oLNxEnE5cvYONvRZyBtPOQfnp8Vyi7eHXt15c9StA?=
 =?iso-8859-1?Q?nvzV69zWyQZF8UAf1MvHYoq37YjPpGVqbvXmVyeqfiG44GDZPiI3wfrYsD?=
 =?iso-8859-1?Q?0SM55CRLHCwNS8K84gyFc/L2nWxalyfU9j//m5H0439Kqs1jfIr4vSQ1va?=
 =?iso-8859-1?Q?GPj/lYgVOZf7H5U1nze4VDeM11FOcm9peYNTAdDa9dYp1j3y1Pjsvvwatc?=
 =?iso-8859-1?Q?88FDfVDJTwOP61iJei11OwrVhH9XJ71T99C3ndpat/a1/c68xgFSa5a/mM?=
 =?iso-8859-1?Q?HLPzJbnzC8UAujwGdt4EasBRTt5G+XarQ0pUmz+6+0QcbotQLmc0ZpnlJm?=
 =?iso-8859-1?Q?vpEsrD0YobmjzCX/xNS698E0afnd8wvoQfrNHJg0hzDZixPjUVgp+L940s?=
 =?iso-8859-1?Q?pthZhytkmxof91wAsLbbWXDMChi4eYxaQ0fgH+X+DjehYMt0DBLTnwqi6U?=
 =?iso-8859-1?Q?fA1jI0U11tu51nCHabJEFSjMBY8ipmsvADeM4UXtsAko2neQqbhpxOJN8s?=
 =?iso-8859-1?Q?cT0jYotYfQDKoaElj6TbFvydEnWzMts6Flt95jJgc77ZTYpmzILP8ZjxAP?=
 =?iso-8859-1?Q?JM9dXCQEkg8XxxRk/xYc3abgJiSLNJOA2jJdo+QH1GYkJiPa4FfJHuRPko?=
 =?iso-8859-1?Q?jmbT0dESiXlnpV4xAKxhrCyc8wXOctPTV6oiYgzsiGtbVbG1pF+MfV5/Gd?=
 =?iso-8859-1?Q?zhUPzCa3t6bSmHR3P2XNqn44Mlt0hs0sofJEImdXNWzgiGX0ZG/8tw8LYc?=
 =?iso-8859-1?Q?mv1AQEw3cBlBlA8vfmPTobt3y9c6053msiptwGFbLIJw0OhM2orjVa5HbG?=
 =?iso-8859-1?Q?WdQL4QCrGx8S1X+LRm5S0huRAKAnpxk1hkQgTEku5obYncZ5oI0lWdkMY+?=
 =?iso-8859-1?Q?/Xk85DvD6sL2VEXbbMib3vm2JEzEOY/KlS8CfsbIaywElGIUGJk8Hd7st3?=
 =?iso-8859-1?Q?lLXfAicoiDWvdZaV8/5LLISNLqqZpmN5lgE3eH9Ix3pc+NYgKXob7czg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e961cd3-1315-47e3-0a56-08dcd0d9ff10
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:16:28.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAm1M0rCfI2PQkBRKd5XzfdW3GGsI4pPvEK0Mlw1vvpeJjwkH9hGmnUj376fXhd8uDDoTrg3x4/tbpMKz+XHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917

On Thu, Sep 05, 2024 at 07:11:44AM +0000, Sverdlin, Alexander wrote:
> Hello Vladimir,
> 
> On Wed, 2024-09-04 at 10:03 +0200, Alexander Sverdlin wrote:
> > > +	/* Disconnect from further netdevice notifiers on the master,
> > > +	 * since netdev_uses_dsa() will now return false.
> > > +	 */
> > > +	dsa_switch_for_each_cpu_port(dp, ds)
> > > +		dp->master->dsa_ptr = NULL;
> > 
> > This is unfortunately racy and leads to other panics:
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> > CPU: 0 PID: 12 Comm: ksoftirqd/0 Tainted: G           O       6.1.99+gitb7793b7d9b35 #1
> > pc : lan9303_rcv+0x64/0x210
> > lr : lan9303_rcv+0x148/0x210
> > Call trace:
> >  lan9303_rcv+0x64/0x210
> >  dsa_switch_rcv+0x1d8/0x350
> >  __netif_receive_skb_list_core+0x1f8/0x220
> >  netif_receive_skb_list_internal+0x18c/0x2a4
> >  napi_gro_receive+0x238/0x254
> >  fec_enet_rx_napi+0x830/0xe60
> >  __napi_poll+0x40/0x210
> >  net_rx_action+0x138/0x2d0
> > 
> > Even though dsa_switch_rcv() checks 
> > 
> >         if (unlikely(!cpu_dp)) {
> >                 kfree_skb(skb);
> >                 return 0;
> >         }
> > 
> > if dsa_switch_shutdown() happens to zero dsa_ptr before
> > dsa_conduit_find_user(dev, 0, port) call, the latter will dereference dsa_ptr==NULL:
> > 
> > static inline struct net_device *dsa_conduit_find_user(struct net_device *dev,
> >                                                        int device, int port)
> > {
> >         struct dsa_port *cpu_dp = dev->dsa_ptr;
> >         struct dsa_switch_tree *dst = cpu_dp->dst;
> > 
> > I believe there are other race patterns as well if we consider all possible
> > 
> > static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
> >                           struct packet_type *pt, struct net_device *unused)
> > {
> >         struct metadata_dst *md_dst = skb_metadata_dst(skb);
> >         struct dsa_port *cpu_dp = dev->dsa_ptr;
> > 
> > ...
> > 
> >                 nskb = cpu_dp->rcv(skb, dev);
> > 
> > >  
> > >  	rtnl_unlock();
> > >  	mutex_unlock(&dsa2_mutex);
> > 
> > I'm not sure there is a safe way to zero dsa_ptr without ensuring the port
> > is down and there is no ongoing receive in parallel.
> 
> after my first attempts to put a band aid on this failed, I concluded
> that both assignments "dsa_ptr = NULL;" in kernel are broken. Or, being more
> precise, they break widely spread pattern
> 
> CPU0					CPU1
> if (netdev_uses_dsa())
> 					dev->dsa_ptr = NULL;
>         dev->dsa_ptr->...
> 
> because there is no synchronization whatsoever, so tearing down DSA is actually
> broken in many places...
> 
> Seems that something lock-free is required for dsa_ptr, maybe RCU or refcounting,
> I'll try to come up with some rework, but any hints are welcome!

I'm trying to understand if this rework still leads to NULL dereferences
of conduit->dsa_ptr in the receive path? Could you please test?

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..f1ce6d8dc499 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1576,32 +1576,7 @@ EXPORT_SYMBOL_GPL(dsa_unregister_switch);
  */
 void dsa_switch_shutdown(struct dsa_switch *ds)
 {
-	struct net_device *conduit, *user_dev;
-	struct dsa_port *dp;
-
-	mutex_lock(&dsa2_mutex);
-
-	if (!ds->setup)
-		goto out;
-
-	rtnl_lock();
-
-	dsa_switch_for_each_user_port(dp, ds) {
-		conduit = dsa_port_to_conduit(dp);
-		user_dev = dp->user;
-
-		netdev_upper_dev_unlink(conduit, user_dev);
-	}
-
-	/* Disconnect from further netdevice notifiers on the conduit,
-	 * since netdev_uses_dsa() will now return false.
-	 */
-	dsa_switch_for_each_cpu_port(dp, ds)
-		dp->conduit->dsa_ptr = NULL;
-
-	rtnl_unlock();
-out:
-	mutex_unlock(&dsa2_mutex);
+	dsa_unregister_switch(ds);
 }
 EXPORT_SYMBOL_GPL(dsa_switch_shutdown);

