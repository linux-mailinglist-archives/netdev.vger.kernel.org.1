Return-Path: <netdev+bounces-160044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0FCA17EBF
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994FE18820A8
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EE21F0E4B;
	Tue, 21 Jan 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tmAMehSo"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2094.outbound.protection.outlook.com [40.92.50.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780DB101EE;
	Tue, 21 Jan 2025 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465632; cv=fail; b=ZxIjIdgUn/WG0H1Z4V3HMPyy2df0s/X67wpy0LtIhw5NMdNW/TMIjS0q55d4CHewU9Lg/XLsskHCbBKshyaxhLjGs04AT29A6XPWyA73+fHTjCLqgqAXf1B6fg3r+XnuvwvPsWXrKBJJ20P6la1fsT5IVvSGPAQXMaQIGtzaYGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465632; c=relaxed/simple;
	bh=iJ/dhNR3HmI7I3jooyezjvci6lxayWOuzy3H2QMcBoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rGHVyi7ULzXnSH03v2/rypDwo5GpPqwRKWNoK8nfajncja6blcDyEpdFeeLMGBudFHprjUtqDuf5wvTVXCSb6OJUVyH4qQsqDdnXeEM+n443zJVrbbdh5pUQY14g50/yqsm74d4ijWHaDbKW4NKd5aAes5lOfRelQJqyZnxz22E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tmAMehSo; arc=fail smtp.client-ip=40.92.50.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqHL+vlH/lsmRkWO0kDPdWC/QQKQWDlXpRDOxBmYnmwyLTZ21x2qaeSiLChNryOKGTQHOPLp9ZLnp9M6sxjh4SCPUYuA92JsknZJ33xhoXF5WlO/iat4/WrC6RxZBsD7dIzqnUckZ83J/k7qOoI9gRegJMrLoATB3v/PrLQCUJvPxdU6De0+YJg3LwtYdNN40wUr2K9FVKV7JfGCIT9+iKh+yMnGkF/al5w4xa7FVLd1a36ulVUdo4Q++2n3vFOx46tdf3C1T2Z32RJC7osuw22RBMOiyuBYwAZF7jK0+bUDC+RVMt2B8DZK5tErEsJwtitWqH1plSkZyw5eFNQmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MjqVvtkXOohTWpEXwyWXT4xRgwrU+YJHT14YfVvYYY=;
 b=lfr2QdFVgTHV7FbM/N01wKpS2IjCUaOjnAvE4ZKghFmo9ZlQygYL3vJ0oWpACXgfMS/6niVSob3lTBXSAJ9PFSc/iIdxoYLyxW7ZAu4aAHOvrwEUONYRDGLfOipELr+M6tC0AkOuIcemIPGUpFGGLfv3hQAOzxSulrn1wEl/MWTCFQABwWG4eOrHeGw9EjCRAArF3YL6MC69KBpApNHz4rQamfAGw/3OZG9WPD/bDID7A+dy32+1FN58/LVBFLEoAURQAfAM7MjiWIuhpdvX77PsuNiHvkiVrOQIPexvreV8Qc9cvRGaj18wcAXJ3uFi1ZMTbqNZgrbTp2sARmj5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MjqVvtkXOohTWpEXwyWXT4xRgwrU+YJHT14YfVvYYY=;
 b=tmAMehSoYGnSD9LtQ6lFluyoCObCHhKV+FoVj3n7492OPzTzWKcWIrX3n/wtZvBlIkMM/zPUGkeyENnNFi9fXtyIzp2+Xef1GGEyFCbbAR8uIPRfVcBvUOIAJiwQpQbuGqpOVJwxCrbP/BJRUa1WELLd0Dz3AcaOjweNHUQ7Y3Mxha8LAZX/SEJaQ3NqmVr9A+5BSBAegaoile5lkWb1LdmjgmVOaMLniP7Y0bSVupH4gE5b+YG7iPY8nFJaT/eKWM3yLc5DrVAWqA6y0oPeGQGsZ27EPazxBV50TZ2/FfVSR2bkfdtQM1+EKnndMvbspbPAgplyvHdDl4n1jZ5V6g==
Received: from AM8P250MB0124.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:36f::20)
 by DB4P250MB0757.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:37a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 13:20:28 +0000
Received: from AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 ([fe80::7f66:337:66ca:6046]) by AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 ([fe80::7f66:337:66ca:6046%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:20:28 +0000
Date: Tue, 21 Jan 2025 13:20:20 +0000
From: Milos Reljin <milos_reljin@outlook.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrei.botila@oss.nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, milos.reljin@rt-rk.com
Subject: Re: [PATCH] net: phy: c45-tjaxx: add delay between MDIO write and
 read in soft_reset
Message-ID:
 <AM8P250MB01249EC410547230AB267A78E1E62@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
References: <AM8P250MB0124A0783965B48A29EFAE6AE11A2@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
 <20250120144756.60f0879f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120144756.60f0879f@kernel.org>
X-ClientProxiedBy: VI1PR02CA0063.eurprd02.prod.outlook.com
 (2603:10a6:802:14::34) To AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:36f::20)
X-Microsoft-Original-Message-ID: <Z4+fFPZ0P/4ezytu@e9415978754d>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P250MB0124:EE_|DB4P250MB0757:EE_
X-MS-Office365-Filtering-Correlation-Id: 190c79c1-d338-423e-5d11-08dd3a1e5f29
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|5072599009|19110799003|8060799006|37102599003|15080799006|3430499032|3412199025|440099028|21061999003|12071999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A2ypa1uX/eXXVZ77LUHc0xlaz2iUHX/cfe/CNKBpAMdwlnabANv4AvsPE+wN?=
 =?us-ascii?Q?Xk8vKVGeWlOyqPgroo3sUhWdGvGdl3ePDNpn1T/FCFUX6g8S1VTog4zRJkpp?=
 =?us-ascii?Q?FqfCTwgEB1E/vFMxGYfMMfB67z7zS/vBnT7YFQVpLa2wy7EsZz5iSF9KwJPX?=
 =?us-ascii?Q?T83fWzUMox7dtZB83d3Kr4UflPlTk2iSc/ObzcbF5pgwm1xeqXuGum2p9xF+?=
 =?us-ascii?Q?XVL/lG0hshUm+DkFiXDFNj9Vrv3cQFNYWJLrO6AD8IHa2rJJ0HG+L+DvwzYS?=
 =?us-ascii?Q?/1bvrqkC1Sq4l5l74qYLNjWwtXzN8F7Toxlms3Vk3V4dKOo9QWqD273cFKl7?=
 =?us-ascii?Q?LeetomXLAeNlz45ij3m6GUZl4w6mkNj45uhwcPJM8koNPnamwmNpBh3upMdh?=
 =?us-ascii?Q?MG8f7uDz52c2F/m4ANegq7veIe5mTBYNeMgLKCX/WvDM7KtsZirmzqawfxFR?=
 =?us-ascii?Q?ya4oBjcKBIUkpW0wiIQ0dzXBRLfxOoBcD0KQmbAMqZelwhYBor6f3Y7pxz7q?=
 =?us-ascii?Q?kyroX8E3cI6nUmf6zgZ6X+9X8aZpCheCc9AuC2s97qESRnuHDSXtnBG7kZL3?=
 =?us-ascii?Q?MMDk81PlJOJnL/iOjSXkxBXN8+4IEQK0oYFFo14cLq1Qll66UMGGf0Gls6vB?=
 =?us-ascii?Q?ymHuMYaFv6MTQWPLGBkpXcHAQgmggMxkwFwMnxJ3bR5uzMIyVaw5GzHObF0b?=
 =?us-ascii?Q?04T7tLLuGknuhjFDtVDwv5tBMrXidjvECD9g09C6N4MSVkJo2KpzgB1pIcTF?=
 =?us-ascii?Q?7IMgt+zWvci6ztFY/EVp4FZHxnKzPaJyY5MnD3EdZDRiza2EkDB4zfb/iEPt?=
 =?us-ascii?Q?I4Y5nw1NoMD/5cLdoLDsy+mikQZeKOI3qoBPi3ocdhm2YpXSP8ULHYk77t4X?=
 =?us-ascii?Q?ep9hxxDcg3Tcn7mkqxybuhd5Vy0XyifjD5ooEpD6LEjwros7hU1bBgV9mTKZ?=
 =?us-ascii?Q?ioTGn+EaTjbtJUW8bXYjWQAaFYLUbvTZqBSrIluDh2Kqzqaa7zzsTWGWUZLi?=
 =?us-ascii?Q?mX9b4hBZmFQF+ed85jHoo9efV/oRSKwYUuibWxcLlEwOC4hQjtdPsjO+0Kfp?=
 =?us-ascii?Q?HRcDJWtgGis518BnNFBUGkGhH+N4EmpwW4LJ+XvZzZPLzHJ+XNS4oXrxsnSQ?=
 =?us-ascii?Q?yqegCem8zySgb043xNoZVl+hkqWKlKQUPWr0//4cm/bCK+tHyf4dhVQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xzLpKqXXHPIFL4gF2TD455EW9nGPkw0GyIEhcSJDlcuSnUosPCFeDDKBXH8j?=
 =?us-ascii?Q?Ssm+XNFEiYNTzGby6Jmlbo/b6AMC+fueOzRDssZIoRnqVnPmWKlibWNk5ldR?=
 =?us-ascii?Q?+oZyDE1BIJrBOvb2UWsVDbtnsL/Q6q56nz9JcFZI5B0eg220iZkF6jMUjay/?=
 =?us-ascii?Q?19qcbTieAivfAMMq0PCI13bCCIlfMh6qiYIC8dBR8zpSHHPJxfcXSrZ9CBEP?=
 =?us-ascii?Q?OUkuYjLhYZ7gLYZcOPZWuzIVIMBH9JMc3mjigyt2iM1wERGPhUV5JKuKGc/V?=
 =?us-ascii?Q?+ZT7/KpaDUwrx7FoT10/YGsawhYMNgpYSk42kZVFYPEQLT+VJLBqSiO+HnY1?=
 =?us-ascii?Q?e+Ysu20jF5ZBA1WdfdrUpf54w69ZCAErFESBHlUhzG0WTC2yf+gqt9ngEY6y?=
 =?us-ascii?Q?beD3So8w8TfPz4OK0Y7bc++315kFEJ76OEb2MfrMUkXZX5QoC7BHG4AJ2Q6x?=
 =?us-ascii?Q?lxVKRHaAdvDPm3EYWE65V+KogkJFK9xdoW4UnllLjuHFAEGnle49sYSP4t2q?=
 =?us-ascii?Q?DJQ/f7a1BHeJ1qxA8VLltFEwF6MaxZPT+5gVsYFElnqDclYP1hmlSFbhdVVH?=
 =?us-ascii?Q?9Veq/0bkVkLiPteKY2myrRn6Fm/WJ/I8Ao9D77V3giXjEe7tyvJ4/NIBVtob?=
 =?us-ascii?Q?NbMgeDof7+WLpG5GEo5yj5MsK+vxjIwFkReIHf3yzKHlIF6EHQkP6/uvRzQB?=
 =?us-ascii?Q?6Db9kF/lBX6dTY2rDxbo2ZoHTV0PqU2idcWTHlu6WOc/++T4rHQhhk/AFVkv?=
 =?us-ascii?Q?l2hppJ86IBuyitD/4cTRvKV9nBMzEvfos62+hnC2S6758sDlnTjintyQ1yoR?=
 =?us-ascii?Q?tLLWa/swxmWc23I4WlG9DhNX7kfSkynqgYTEF7XzZlhTdkUDyuNmgzS4HgUi?=
 =?us-ascii?Q?1v27PyvZ+7eH5KO+lsZ7vFTm5eQlW20hicKCbPL125KpAKEbpuh6tdqm2H+m?=
 =?us-ascii?Q?Y7LL7gOiN4sw5vYjD8e2u6oxHLD+D/moM1ZHqUuEMf0ipAnG2pLSD3f43BLO?=
 =?us-ascii?Q?Hx8OPubV/ggHhqfaXBUYMdiPFxCoLrnpC0CrvFPtYTtvVLCLHg2W3l++42gI?=
 =?us-ascii?Q?OcgO5V2Ym8vqXwz1KzJG7iDmbTNjBFXG7BIEjiJQP4h5jqCcd5Icq+OPJo9V?=
 =?us-ascii?Q?RIO2zjnOnxzT/2sICS25bC5RgCaomSIe9zdRISoN4Jcbv5RgosOlk8JfrTXq?=
 =?us-ascii?Q?aFdRdfMjRlZ1FInUWVE0qTEgARrthlogxFLq2alKsVLl0Z1atu3Wt6O9C1jn?=
 =?us-ascii?Q?udsakjlLKnlDWejhZsjo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190c79c1-d338-423e-5d11-08dd3a1e5f29
X-MS-Exchange-CrossTenant-AuthSource: AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:20:27.9519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P250MB0757

On Mon, Jan 20, 2025 at 02:47:56PM -0800, Jakub Kicinski wrote:
> On Thu, 16 Jan 2025 14:55:39 +0000 Milos Reljin wrote:
> > Add delay before first MDIO read following MDIO write in soft_reset
> > function. Without this, soft_reset fails and PHY init cannot complete.
> 
> A bit more info about the problem would be good.
> 
> Does the problem happen every time for you, if not how often?

Yes, soft_reset in original driver always returns error.

> What PHY chip do you see this with exactly? The driver supports
> at least two. If you can repro with a evaluation / development /
> reference board of some sort please also mention which.
> -- 
> pw-bot: cr

The PHY is TJA1120A and its PHY_ID_2 register reports value of 0xB031.
Unfortunately I don't have evaluation board - I'm working on custom
board bringup. Linux is running on TI J784S4 SoC.

If you have access to TJA1120's application note (AN13663), page 30
contains info on startup timing.

