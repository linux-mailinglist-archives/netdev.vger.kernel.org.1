Return-Path: <netdev+bounces-158917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23471A13C83
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7F1162E96
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B30D22B590;
	Thu, 16 Jan 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iZRHrI0g"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82435968
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038462; cv=fail; b=Km/OJ9434SykSP+yyChE1SJZdvnSr6ju3t3M18ZKL6pKSq+btPqzdbqRgbduZ3/heeIscSknb9t48sn8Js4UrVF8eTiVyuMOormlUKaLG/IFVgrZsjfKVU7ZJkMhIcGVz7Ejk+oxBrsAoRxFglDT9nW8bTipbe+yhoVNKOyK25s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038462; c=relaxed/simple;
	bh=P/YxGzuBZ0SOVmgTPX/BjwTaGQNuFYwG/PU9X9VKurU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tDHJ2n0WmbEQd4bWVHER6E4eb4T+OF/ZdJalVHuER+ty6sbv7j6+uksItc/5zv5SvGstO2OmSRg+LamwrxK4tDraT2PEz8nD90kYpryOGXPPKzQrMMRgnjsmqQr17H2secvuNF1bNkRl0GttLq5E394SjDEO9rdoMSZ1n9BR+uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iZRHrI0g; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIWDztfB/b1YHfHX6OGta6XtY3GWfOh4MZxwzluTlqmOHqrgEOENEf3+hht6jLKKbztz3Q2Zf45dnFRCIgyAn2tG4MxPStAquukL/hEwSuvje4YphsDEvKiXOilK2MaUq0irKX4Gfbmb67tbBZOqJgMqvZIDrCT5L1iuaBboC2I8m5AXDWP9rGdOwbRB1spkU+jOfiiicgRDj0sQQt+WNfB8O/j8UCoaPckcwT0zhE2EEhmQ5P8W+sTlpxOENuJoruIP5Pb0PimaZxhpyj1l5R7Nid9IBTgUIb0e4QEHQVwidJRny0CW/1i26hZ9vkB/r1j57Mt1xmD0PGyzga7mlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndpf+VTaHkx/wmwHubxzpep2Jn0Z33SzuHBaezp6xxs=;
 b=tnxwQM0Qv+BefZU7i78xC9pQSyI5luydLoF1dxBSL+s9FA9DmxTr4gHD2cP9nFoWTgvEJKfaQzz2cq1FuLSxBAXzli/vEYyQBAVc8WlbzvX38lfKJVcrEYcPSBOqnfjh+4S8N0Lg1ijt689bmVxaVtTiKz3bSkfui66XFcTfOaS6jWzFnqsluHx18zcxB0HSpYuTyxTLRQbTZM2D02ebI9idFfhW+yjxtS3X5yAQS/m5Z3I46iy6xcZd/s0TG+oyHKqmBDpKBBElMxvxmsaXW2DMO1seKS3BnkaryNjoP5Qvz5bH2GgTpsIsYvp8QknC1hz4kxMDm3kM2N4rAVjZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndpf+VTaHkx/wmwHubxzpep2Jn0Z33SzuHBaezp6xxs=;
 b=iZRHrI0g9HcV6hTxb3Y4uObycC7z+/dCweGCwmfFdHdDeyEKmWuThHdHvWd1rElJ/1DqxGd8ReVja6y3vu7XV4jFYkCqRvK0pVDO+zDNGQ958mtcABcFyg887RNhNxdFnn5KSSQC344QYXNttjxar8+u03KxHPurf6ZMdL7MGgTeiCKpYnectJQgElR/9w8unPHTCo1lyl3Mepol90L+yls/OBfYnVfkf88t0S3TXDOCx7QHnGA3mcmRpLrt50D4NwaVI2aEhL7agTjM9zXUbSbWItAi2lsZitwx0gsJ+gAKklJ4V3IdED8lzmEdA1PPdeVjWPikYJ4vx2JGZ0ZFyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 14:40:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:40:57 +0000
Date: Thu, 16 Jan 2025 16:40:48 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH net] net/mlxfw: Drop hard coded max FW flash image size
Message-ID: <Z4kacOUPI9TshNJQ@shredder>
References: <1737030796-1441634-1-git-send-email-moshe@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1737030796-1441634-1-git-send-email-moshe@nvidia.com>
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bb413b-a540-4341-b150-08dd363bca0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QXKo0dWQXYDkaNNfU+2F8pAG9OPdXsfLMu2O+0Iht7xrOSOcRwkUCkli+FeA?=
 =?us-ascii?Q?I71AVdym+CHrzIFyKNNvm2C5OS9mmihO5jx6DBLcbHtXwylkIUxOgemp0RxX?=
 =?us-ascii?Q?K69pDNjweS7DUUsq0qhdvIn2BV78oGZlh63OV5TI9S8ftO1MR0U07dr717kA?=
 =?us-ascii?Q?ibHiDAfVFlIYSmj7rOfTM59PwF1XYKY5Uzjr/CSMPt3PL+0KstQGREDirH1B?=
 =?us-ascii?Q?8N4TRRoKrSaKzrhC1f7gHXRLOYH2tjv+pviMkjyYoP9OEziVHSUozj9TMA/A?=
 =?us-ascii?Q?icrFcGWF723w7Kzt5mEe4E1cMNb9mnmYzaM7jaOpPQrUI+HLkx5gF5ssM6jZ?=
 =?us-ascii?Q?sLkn2hQ9yGCL6U0kfhhN8CHe8VWICUes711TXWiJ9BykAj4jN1lI11xQquGf?=
 =?us-ascii?Q?LJvgQB6xuP/C5glvXZhkyi/RvSdLi80uWC73bVLIK+ezCf2Vjl2S/tIqWxPo?=
 =?us-ascii?Q?E6GjUp1E1lgF+FbbSvZymnq1X+tKLKarxu9BICK9egw4KdZnbjBKCUhJ1Xur?=
 =?us-ascii?Q?ZVNNFavEP8r0imMVQMYz9beN503WjG5GqC/UewxeSG5HUefO34kDf3qhQqhW?=
 =?us-ascii?Q?7eTwELbe1NeWJLcbnLTD/P2xeZpDHo3GWVwL6q1cXePvFqgNd4utVMOQCG1j?=
 =?us-ascii?Q?+Zy3InEQVCWqKRvI+girGPaNHRV79EgWpR9G1WqtLjVA7NdpJPvhs1hzCirm?=
 =?us-ascii?Q?yhair1HlZeW6ByLfP5RCPr7IvPH+OvdarLMnsFQ63Ugj2YfvdqC5EXvah/Zw?=
 =?us-ascii?Q?eQh3ITCFzlFGyY6xcsn9zn+htUH7OSRQB/XJYw8qRuq5eCpvbXONsGLcu0lc?=
 =?us-ascii?Q?sy/BxG8qBw5rXZlDKwzKPk4+ZTPeW6nXloBDCiH9S2JQM4joJzGXWfgaodIA?=
 =?us-ascii?Q?JNv76a3eWiRvLxgTILdawAS2JPIwYxGjRTAMYQtnDnkeeDr4GOlWjBTtRvZi?=
 =?us-ascii?Q?uYC7j7l1R4Duzhp3cYMf9KTTrT/arICNu9wVGiJzs4DPOYa0eAESIVVzUAuZ?=
 =?us-ascii?Q?PVPTrXLPV+/RwFobTbc0VbgTG0xg6zs7CG/TF1EtDxZgpH1k1GpN2R5XzxG3?=
 =?us-ascii?Q?e/o5io4fm7i9ePoV+Y7YFyxnqUJLiTn7r4Pe+jOIfnt9rcvnK6wkHeIMiLV8?=
 =?us-ascii?Q?SD0MRdWnunB+FGEEGFf0POFEVOfZLNPNJmNJqxaMCmWDadengy8/k4VCEqrX?=
 =?us-ascii?Q?UJLD5rCzvurKOR0ZiPmzjaIDncvEgTcGTGvHYUotQGizWJBbYUPsvgSwEFBX?=
 =?us-ascii?Q?ZczAqH2udHkuNS5j5tA6vPqT1eTFQ+md8ByJEEBfua/5fttiMJ2/ZQVo78G0?=
 =?us-ascii?Q?zoee0q4fD8tCEatcCX9fKJkvvxk4c8aA0H3YB3XZsSQIBBKZU22qCiCfHfDD?=
 =?us-ascii?Q?/b+tBjPh+uzcjwFopFv5CAHHOF/W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dkpsdYdSPnHhR0/nd4b1dXy2P+DAxsct8Mp5OkS04lwzxPsmGupnOixLi37f?=
 =?us-ascii?Q?G8bY9X+20Yd6+dS0g+SfPh5RtjUm1O1VhaId2aEdkttSw3W0KWC7cb+DXqLk?=
 =?us-ascii?Q?04p3vn7pUsiV/v3TiBWMUEWk3tC66j2pXvpPJoWuDNeHdvSw92bka+zdoEAm?=
 =?us-ascii?Q?Rpf3b3xei8wOzxiJC+jsKkhg4+cVFVIl+e9PooGRLcngvaodSq2bXImIkF/1?=
 =?us-ascii?Q?7mzr5e+Y1PplC3x6rfcpy+sUKr6CvaJCcOtrY8OCil6+Nv5UZhWYlnHTx6UZ?=
 =?us-ascii?Q?FF4PU2s6rr/VgVNYcmxMGUMm8kfmILBn4cnausFhFzpthbaxvgRV1CzKqvt4?=
 =?us-ascii?Q?xk7zD3Ce8S6mBAQ+HUVMpAGof9HXbh7qcxJFLk1sivw4r9n/Mk5r6/djMNtd?=
 =?us-ascii?Q?HF3WyJAS0yJvzHWcBsSQoRxQxj+6NsHX6BBtXZwr7pn0IWuLLW17ocgzlh2N?=
 =?us-ascii?Q?MM18yIWj4POm5uEREuRyt5M4LbWVBfplGykb7ukuENR+6+e/RnxnWqxYHXYM?=
 =?us-ascii?Q?8QZJixI0JSs5r6zpvpWVYojXGEYfSd3FsD3C+vEVh0+feCeCYugzFT2ZaHEK?=
 =?us-ascii?Q?jacygP9LbgEY4vuFAvbuLX7C7oAGSeDakO5zfECFXjKyCnktzq5U4Sk18gWu?=
 =?us-ascii?Q?HtMVafh5l5xp8mt4YYdpKjBTk79lj3YdxYAaq4+o2+kYDpmCQ9lFODxiMDBu?=
 =?us-ascii?Q?1o0yYAzsX/5PLrF7tBrqXbU2cgztvrMU34myI/uVoMYz9D8Fd8Onap7j5heH?=
 =?us-ascii?Q?qMc8tVPm1xWupQ1WPsoS9DWFEfAk7vcHQ95fbRDwXj9D5U+FlnPdTIJ+gjiZ?=
 =?us-ascii?Q?TqDzUsOOppQG/KtLA+ske8Xzu91A+kBvN63j/PRW/Ph6iv+OXJ8btOVqy9l1?=
 =?us-ascii?Q?2cI0nKZlUy6N50n6UDgTHfOi2dOQnc1BJC/kbO1/Q4v1cPZ3ff20zBubmQGj?=
 =?us-ascii?Q?Xy07SbfgcEXYAM6qVB6DUYyLNnZYJ6la8E7utCa/8lgLl4xgin9JH303j632?=
 =?us-ascii?Q?7X7Y0OQqAAyeAVNXHvIfrz8prJyFtNDARUKUziP/PKXToXasjjvOuT+3X6kL?=
 =?us-ascii?Q?kyw66sR3QjpNCxLu7h06C0ALXQUtfmnYg+tEr70Q36XbYVRitMAzXhsRJAr/?=
 =?us-ascii?Q?aJKYC2pYqmj4gQc9NZIsQlGnMWLJ0+MoSNPGgoPW+3Ee6cDYw9ppZeSWEoQ2?=
 =?us-ascii?Q?b+C+iav/ZdttdhrJvSZKrpZyd0Q/l8PFkiTR4WJgqDOi/3176+B77qQmE6dN?=
 =?us-ascii?Q?bCfWV8raKpgyCl7xI/nnOzxeJmpxE5cJkYwFVJ5jQuO3GnJi+EetvoYoi8aA?=
 =?us-ascii?Q?KTzD9FWIqEfdfGMJ/ypzWBIBDknFdQHajBOuXcJmkNs0NGcOg9CJh+seo+C/?=
 =?us-ascii?Q?YZ0RsMaFL07HN0RYIbhyktTUj93WI4TseMygqw3efbQ4qmZiy/1B3+iNuZHL?=
 =?us-ascii?Q?Tgy/2tIFNzoC9rxbdTkYjbVAr7BY/02qo5u03Yi8CpC3Tg0zS74mvSVCoTKk?=
 =?us-ascii?Q?1N/j51mdvfRQ8UP2qruD74mJPnTUipcoHp+6Kbpv9rcYbfGSMRj3m+CebiZr?=
 =?us-ascii?Q?5C0oTPCe36byoIHscg9lMvGxE50Z7+0A9g1XmYIX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bb413b-a540-4341-b150-08dd363bca0a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:40:57.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHxb6vGP8vgX/NujNj6BD2ZwhOtFvj2sgcOY97LDTyG1dUzk4Iz1Bz2tSZPE+SGy9Y9JIjcRfFUQzPWbwl08Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397

On Thu, Jan 16, 2025 at 02:33:16PM +0200, Moshe Shemesh wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> Currently, mlxfw kernel module limits FW flash image size to be
> 10MB at most, preventing the ability to burn recent BlueField-3
> FW that exceeds the said size limit.
> 
> Thus, drop the hard coded limit. Instead, rely on FW's
> max_component_size threshold that is reported in MCQI register
> as the size limit for FW image.
> 
> Fixes: 410ed13cae39 ("Add the mlxfw module for Mellanox firmware flash process")
> Cc: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Tested on Spectrum-{1,2,3,4}.

