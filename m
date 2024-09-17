Return-Path: <netdev+bounces-128710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B505D97B21E
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 17:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A6F1C23E63
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588DB1D12F1;
	Tue, 17 Sep 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bIDobvIj"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881417C990;
	Tue, 17 Sep 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586633; cv=fail; b=Ph6mg28i3nzavm+BSBYnGxsBJIx5OAK5xdrwt0gIAIcLXgMjb5SmLSEXi7DKIcSqpUqgOlwZCvxwCBhbobNpy7km6lRmtFuftH+Sz+vwCM3lud4kGKzY/9aAVGZAyF723ZQ9iiHqwOnmY5DSbd3D5lDUV81++dPVxjBK740XSIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586633; c=relaxed/simple;
	bh=ShGxSxeU3VM3/D5yaj7j+I1J7+79fIfhHPdmf7tbnN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dj2V3soFPOSwEtKEWCwI+bTlnMCppbyfdIHq+gVVactacSQHHA/TmwOzbqhAVz/0PcIR37ScZmCg6rEmT76fYA1BX8Dp87lnS2oHzeth6WX3B89iPjuKDag8R4MdoOllbU+zO3nMayslY36guAZ71F2DIY2tXk8iok68VXiiors=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bIDobvIj reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYHYeHngtivvhIZeXJabSWMGMZIvf+SLgwFPLVO2FZcEmGtKalVCq5fAIggOMBdblqSk5kVOC4gdV/aN5I7TTcXaZZeHNix0hlFlucWYYWqEmoztmoPPJ0u9IvqZ/yl+fZC5PRVGMuSiFgNvCZ4gEyqs6X3yGogaJdyqwE3lt3tOfaCoZFZYQ2Kg3tZ7JXEPamI6GVT2+1kX5mj5dafyDExM2qXu08UdHs7EGnNkX7p9YmnPwik6VOsE9r9ZM7DRcTrP8fi6d51ZdTIs1C8FlDrn9D2QoNVr3UUNHSUNIW8guREVkmGP3Y4Glecn80CModuD8cD8snZ++ya4Lteqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NtgXqFVpTJkym3HOllWO+DVYec15CwRQduraFanqqY=;
 b=NYjHf1Vv0dIC3V1J2Dskjx9ZFrnt0KEoy+jGdzUyBcc7it5G8xan19TX9Mf6+VM9/425vl4/n7vuV3OTdShESLiKb8hMLKBmjPXuABMdYzjSVGoAlkuPWSCVqpK/AgxKcMAQqTOAUhkPBw/Phgvhy506eYLCyslHqqKy2QSBiyUc7R/b67a5uUsES2oY+TWqqLvpcWNOAE1qE9ZpdES2FPs2FgkwNSI511SJIC78Ue/Ti7aC+rSfEW0iRkgi+f9GgRGPCBDBjw3CmpKMvuTswmv0lMJModK15tR+BCv73DthULQdzRvOJ+9kktviBpy8mH28dGLnUrYvbU867gLlsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NtgXqFVpTJkym3HOllWO+DVYec15CwRQduraFanqqY=;
 b=bIDobvIjgbCkaoALW48b96UWY6X7ub5RgfnBch37H+8ZUPFqb4XDrQT14PukT0k/pvf0eCYTIOIrVvsutT3rwsVFcTbuVQZpRSl7t0nLcfRG+23kSF28zzNrHCFcy4TSip8FXDBK/jCbUeSPPtKjM75ZMhQWvbYyeRWEtklbqvWbwKJLddJPkIOrvq0nGFNudVioOyfo0XihdTBm+8hIl9FkNCC6YzVF0+m33F5cMJ2NFWT893cE2y5nPto1Xkn/i0dYn9XzlTr9qe04Mo68lvOw3NmX4acNHlBXWcMSvMqv+Q8BvNUZpP0MDK9O4ohTiaPl7i330/JHTGGhqbPeSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10584.eurprd04.prod.outlook.com (2603:10a6:150:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 15:23:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 15:23:46 +0000
Date: Tue, 17 Sep 2024 11:23:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 2/2] net: fec: Reload PTP registers after link-state
 change
Message-ID: <Zume+IBpZsXTf6+X@lizhi-Precision-Tower-5810>
References: <20240916141931.742734-1-csokas.bence@prolan.hu>
 <20240916141931.742734-2-csokas.bence@prolan.hu>
 <ZuhJJ5BEgu9q6vaj@lizhi-Precision-Tower-5810>
 <c70a049b-cef8-4b9d-8fd6-e9d8ec0270cc@prolan.hu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c70a049b-cef8-4b9d-8fd6-e9d8ec0270cc@prolan.hu>
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10584:EE_
X-MS-Office365-Filtering-Correlation-Id: 8165ce9a-f0e7-4532-e71f-08dcd72cb909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?hIVGAF3Io8nlQuUWrUCP3/iTYPvmLbsGgWvzzRVjJZ1T0frDClNkhmFK47?=
 =?iso-8859-1?Q?LftoUaqS3KMPAdbAryJtfxRQTNDglkm8tOShg5cAjtrGLpC82MP7IS9QeT?=
 =?iso-8859-1?Q?a59FvYPQ2bS6mO8PXP91wnlmKkQkb0j1FUzbtNkOeg8aXCtMWTfxBFljKL?=
 =?iso-8859-1?Q?0lruhPpCEHbJ3b/ZMk4TZWuqs6+F5tBOpfGYTJYfrPxIqKfXFmFdvlHaSh?=
 =?iso-8859-1?Q?x3BsxYrCPO+3YNx6AlZ+B9k50iOUHM1gkY7jp+WvsiiqtGIwlzd37fOXpO?=
 =?iso-8859-1?Q?YTGSHYvK0OJPaS8KrHeV25N5BKeAr6zW2mXiwXFc+A5RfIWVfp6KXHxIUh?=
 =?iso-8859-1?Q?9S2JcnixvvSQjUext6z3b+f63IkYT7YYhXqPhTTWP+gVpaOMVusRh9+jcc?=
 =?iso-8859-1?Q?oXnD35A9CcPNcmnuNnH352tRSJOkTlW0NCvLvDaGK66l0qYNvqkjA8SQvy?=
 =?iso-8859-1?Q?vK0CB3AahI0KwCdTk9yc6p9pTFLgStuWUUa/BhkmENGSxCCsqhDy3KLP/e?=
 =?iso-8859-1?Q?q1KcgWc1U3beRugOCKysHH0LmQsBllD3SwMW0xDa11hrl1BboxfOjGFKHl?=
 =?iso-8859-1?Q?pTx8WzWAxYlHm5eRx+Hcr4/nUr4sT6o3z3t/VDXRNNQFZWS8U3xhTGcUgf?=
 =?iso-8859-1?Q?xTqmJbTtercruKwM//3oHN6Pdp4S58ACTCz89KatOGuk1+YtlKIPHYnw9O?=
 =?iso-8859-1?Q?wBzqEXED3nsUMKsiRBjAFjQkiM3hJI4W5VIOIz/d0QnwSZf7vpZAJzUxmM?=
 =?iso-8859-1?Q?1pr9FmN52zHb/dsyzogeMWNGvNv1FxKWo7cdZQtDL2lZNYntcCnlN6g+Nh?=
 =?iso-8859-1?Q?ET9FmskiFOXTSmzqloM65SjWRc2YyeK1dVdogiSkBpWjRvhZJM8xDjJetU?=
 =?iso-8859-1?Q?gFcuiiD1AsFY4/xb1z9YrPK+skJZBf6fjr/gPQfKwuwEsayX4cbN2i5rFE?=
 =?iso-8859-1?Q?/BrxTDIt2dUPPrZOWWUxAKmD+64ib/qIrNQWA7c408JzsFDbotPQrbRO0q?=
 =?iso-8859-1?Q?lK8Uy4LAC820CnPRO056PpK1GKOJLMxP297evLs0GcR+cr/yPlG9OAeMlZ?=
 =?iso-8859-1?Q?zsRnFE6HVHeAp8bdqokSiUbnxjRAXQTxpJeIPDhz01MfY5qPC3k8qfQTT9?=
 =?iso-8859-1?Q?HZ+jvNkz2jofvW4mX3YgVVgT/bVWqwIYDFb/bMEBrqS58zpj56EREkirsr?=
 =?iso-8859-1?Q?FzRlFPQN9DxORCFaWXyyF+Q31iJQL1xW5sRKaXujyAjlMYUKcP5jsKqJj9?=
 =?iso-8859-1?Q?eDsu6R7cOkTNIzGS3KgDLaUf7xoBNiRiWb0pNh1F3y6kQwQzhzW5K5Mp5p?=
 =?iso-8859-1?Q?bi+Qhum4Jv6/SpK/Y+SGjTI+Xgry34pCtydPktxZtytv8rc0m/ezvOIQtZ?=
 =?iso-8859-1?Q?Vu58KrJ6dqxqq4ENiWpoVpRrWkfTuM0awNVezovmPa8SxV44EoIX4wYLXy?=
 =?iso-8859-1?Q?fb6WYp3M77STbLA1Ij6Lx3fasFxYE20BNwsSjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?RqiFuZmQjuMSUtjVO3fLIDkikIHTkLPI1NicEhWUch67fSJrPmDVSfo69K?=
 =?iso-8859-1?Q?sqTGyCE3toX7UHa+0i9kNQQenpmAUAGuAe3lj3paKTKJyLh0vITUdZvTeB?=
 =?iso-8859-1?Q?9jk85S9QANi3sOb0HV+xIhpRrIlJ088QWBEZSaGhmO/BNYwpjq//iU2mmB?=
 =?iso-8859-1?Q?ar8abyySkAvfdXQ0FMPiWz7F6lVWzo9pgi/iUT+P6aOVOO78EhwCCVkOZA?=
 =?iso-8859-1?Q?G12CPqbEF9DD8Y1iY4aX3vC/yTEYXJN0x/u6uSZA8SInhI4bAMQPjHIPpV?=
 =?iso-8859-1?Q?7vtc13WK6ouCE7jecAcSKZqs1Ojn5DXPiEDChsBL5TUAXGd0HvPwCGM39w?=
 =?iso-8859-1?Q?8RbXdouFlkf0nsQ9J8Hn1osgwWkVE4mwPvmZ2MCaZiwpyxWx7U82fWadkM?=
 =?iso-8859-1?Q?43CJYcRGyOTx3TC9djhsvO1Ar/rbCw/+Rw3VHU7frkLYWDKSBbNIrQ2j2S?=
 =?iso-8859-1?Q?+PVeRNQnbCsVaxsLAQ27FaJwNdGjbZ0L16F3aPo/7xvjQcIop18HKicsVO?=
 =?iso-8859-1?Q?rd6a20q5fU0sGhWQ4bLCm2y4mtXNrQVYfl4N3SRaKYQ88dtBmuTTCRwOZ8?=
 =?iso-8859-1?Q?EWsDy81Ql9/XU2TKAtrZ0iiWeSJJAm9FuE/RaRUWefGvsTMGfxboTGm+xn?=
 =?iso-8859-1?Q?Z7v0enstfpoBkZ8SiDL4Wgm0Xy9bNV3HjWSbR7+5nBQlwCZTOcdVFWE+qy?=
 =?iso-8859-1?Q?5a/Yy1bVG2vZKgKDZgEl4gW85VqelwiEWJHT/6i+5y8lTRCiumX/8uKANc?=
 =?iso-8859-1?Q?NYrseJGbhGNi5z0obn6i9Zd7vsCwD7w4LfFTW3N3wV0HSAuyOd0o5kGoKZ?=
 =?iso-8859-1?Q?yF68jxn+ZEgplXqlxNitNebjKaGnuxTuXR6ujBpmdLwHlIRDAti3Y0+vmx?=
 =?iso-8859-1?Q?dwCaEEjQYprQ0ZUTe0R2Qn0Uhe0UDj/RcJoekz/grb/TCYXOudX8p1cR1t?=
 =?iso-8859-1?Q?gLflCK3bix2AMO8KSB7HvIx1MxnUAHWO0aNaXcMdZpnlWJtQMTTfIHJsyf?=
 =?iso-8859-1?Q?JQSDZ9qWC7+VavLZ/WHap86hkueim0pL8gfPgX/GGpQo0qbwlhHUFhgcIL?=
 =?iso-8859-1?Q?XEyDJg04oFe6LAqS9KS6wA1DV1M0ducyJ5QPPNLA4gOBx12sgIdRSc66T8?=
 =?iso-8859-1?Q?MQvMy4ida62igRwME34ie2iG3J0RXL1RPmZONygCBi7IFFO7ngUV0BUopP?=
 =?iso-8859-1?Q?8HZVNexcrT7lxxRUsnUTYWHkVIlJl6QqSFj2KBrslqKhzRZuD5yI7pzEzY?=
 =?iso-8859-1?Q?M+IMbwdHj5sv+FtfUwCMMwzWuNgh9y45BisIQThPRibd9GNtwmqRgxFy71?=
 =?iso-8859-1?Q?aJtPJ75C/wFMm87ZKxEBCypHbsOo5nFTSrrfBXPwBAAzAcf3rvKWtjY6Q2?=
 =?iso-8859-1?Q?JSyjq6WbysagLr8CbHXhkAX4kKrYOuVf3QXGW8O0f1RdXz/jP5Cw/vzVoA?=
 =?iso-8859-1?Q?Mt5nWKvdFjvUSfSwgJDITaATEjRqgVpV1DGLTIVB6u8ob3BaXP9CPOv+E/?=
 =?iso-8859-1?Q?r0hu64xsxzDZLcJG1E3zbVWAG7XdTBHHne6PwnW/T+AeOV2cMZ6ON7+vDT?=
 =?iso-8859-1?Q?vHqE+aX2yqBsaf88BDpmnmqmBoizmznamB7bz57sGbWtGCVnlxApQxYPCf?=
 =?iso-8859-1?Q?cOi63LP4KcXa0/q9nI/LXrpCQI2CdxF3Vq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8165ce9a-f0e7-4532-e71f-08dcd72cb909
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 15:23:46.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGqspYZlLu2coQUUWht99Dqpy24HIPn+531QYMU1ss4DF6KVWBwz15ObIQ/wOkOE5xeVRcLEKeva+cD1hele+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10584

On Tue, Sep 17, 2024 at 09:53:07AM +0200, Csókás Bence wrote:
> Hi!
>
> On 9/16/24 17:05, Frank Li wrote:
> > On Mon, Sep 16, 2024 at 04:19:31PM +0200, Csókás, Bence wrote:
> > > On link-state change, the controller gets reset,
> > > which clears all PTP registers, including PHC time,
> > > calibrated clock correction values etc. For correct
> > > IEEE 1588 operation we need to restore these after
> > > the reset.
> >
> > I am not sure if it necessary. timer will be big offset after reset. ptpd
> > should set_time then do clock frequency adjust, supposed just few ms, ptp
> > time will get resync.
> >
> > of course, restore these value may reduce the resync time.
> >
> > Frank
>
> There's 3 problems with that:
> 1. ATCORR, ATINC and ATPER will not be restored, therefore precision will be
> immediately lost.

Yes, It will be good if you have compare time back to sync with/without
save and restore.

I think ptpd always to make it sync again, just take little bit longer.

> 2. ptpd does NOT set the time, only once, on startup. Currently, on
> link-down, ptpd tries to correct for the missing 54 years by making the PHC
> tick 3% faster (therefore the PPS signal will have a frequency error as
> well), which will never get it there. One work-around is to periodically
> re-start ptpd, but this is obviously sub-optimal.

Supposed it should be ptpd bug. I remember time draft is bigger enough, it
should be set the time again. Maybe ptp change the policy.

For example, if system suspend 1min and resume back, absolute offset will
be 1min offset. ptpd should set the time to catch up offset firstly, then
resync frequency.

> 3. If the PTP server goes away, there's no way to restore the time. Whereas
> if you save and reload it, you can continue, although with degraded
> precision.

This one make sense, you can add to commit message.

>
> Bence
>

