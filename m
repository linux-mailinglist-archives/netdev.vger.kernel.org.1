Return-Path: <netdev+bounces-199494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FCEAE082D
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EEB1884938
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB26E235073;
	Thu, 19 Jun 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lCZR9gNS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9BC2459DC
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341749; cv=fail; b=iXnS56LJNQ9Byf7Rj/e5DKEnvJr2l42uHv485jiUpvEN596GKvieIK6Xh1FRzmFEMCoLawJTz3bmXLtIrlTUWpUwP2T+d9WesIL3az4OVhj7eI3Ug/2Bg0PSQurlJgyoxTFHcs6Kfz7PRUSFRBylps6I5aVmZXQ+ih/fxlawc64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341749; c=relaxed/simple;
	bh=DQUjL27y7jh50OAxh+WVvLW/Q79dkmKchQi0tC2dLIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ICUzqgSlj9/l9icEkZ2ld2upzzLy4n0SzasOQGLoAsueNU2YHIWhj36kwDy2v7zLa6RiJwR1C5aDJ1bOhOjWgTpm2I7xs0WEjELCY3vOWNrqUlpgZ36Dp71SSQhQMHW6pmkllJz90piyiE/G/LRIGwmuvtElvH/llG4VsCCf4ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lCZR9gNS; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gULlA2mGjbS9t2y2Zrn0fw+BrYOg3KsifY9IjoRE8AifB1KtiwPFlCrSt1unVJ3Z1S5x36H5LRWLZne1+DPBKEk9NYgcqZeyYpwZbfP3IlXbMsCbzDqS7aJa6qUxBmxurNWgwUc5eX96HJUeudFG5OK4Pdbe8DeTFFheAkp3e+pWIxrSf6bRrfX5WiMXQrJNa9csZwHq+wi5zXuX1ja+CeacXc7GqNE+X04SwL4FJwr9OWO6nBlYqaaruzG6ZxiNBfDUL94GnMqXM4VdjxSqV4sbQZP1O6zDcELWIJ1TNrj0wfGs73Ci+3wgstC8A1B02ogY0CRcUVDm4MqjjHPn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN/CLMf25g8RKNaTbXr233FGF0tRCqXe4GTthSe9goE=;
 b=Y/SouWPBuqPGtiiGKuNCYcQvG86mIAwSXCi5JALj4UFjxTqD62mMmaApn+2pvMeBN8lrwgAzdTJJdLvIeuB5PYBj/MBdy4dinx/xhpp05F3Pbrn5vzVu38xivASIbKDs+5uLSuLTkv2rqed/rrv3ACmg5txoqgBUk09soEkfqMU2WDGMhU2nEM5fWteoY1IZHdhRjtEnvEtT/aaq/aDeD2IDoR4kTXZQmTQPpeuKPDXWQPlryb6EYu8J1kOqEZJqFDlRC9tqh+p/xFNKCdWBxQknQiynEglhOEjICzpcE+XGaRQFtBzEAXLk6OCtPVH4gItvQXSdoxwn0qeN8lL4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN/CLMf25g8RKNaTbXr233FGF0tRCqXe4GTthSe9goE=;
 b=lCZR9gNSuZlpCyG6w5oqAfOQ6kRM3FJkSL7ohXGXkIomqracBiXJAxLfLp7oLnRg1MkWHwvY1jYDxKfXKWR2kdCOIQVmOj4/SIIEMoA07Ty/j3RWgGxp4Ip8lyuTayPIroKQ1LyboKcUp30f229k3f3rdbEbZfnucsdit+/Ojvm2VjCci5GIHQcwgMHxt56GgWe0rFwqBk6wUxe+F5EflTdq14hWHebh2JQ+uIm53OYBUHo7vSUjFnHFSGzEOlpha+Rh0zFAqA+PrWoJ57WCp4Qgwl2QiQkOOypgtLS9TKJJP0X9Fm3FCNZu0vC2rE7Fn8msKur1l5XKQVVOnezrVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 19 Jun
 2025 14:02:24 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 14:02:24 +0000
Date: Thu, 19 Jun 2025 14:02:19 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, ajit.khaparde@broadcom.com, 
	sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com, shenjian15@huawei.com, 
	salil.mehta@huawei.com, shaojijie@huawei.com, cai.huoqing@linux.dev, saeedm@nvidia.com, 
	tariqt@nvidia.com, louis.peens@corigine.com, mbloch@nvidia.com, manishc@marvell.com, 
	ecree.xilinx@gmail.com, joe@dama.to
Subject: Re: [PATCH net-next 06/10] eth: mlx5: migrate to new RXFH callbacks
Message-ID: <fykinwjvrkb334qm6uzy5mvmukm4dw7hge7peitnu4gk2c52nm@g27lrxdhiaqj>
References: <20250618203823.1336156-1-kuba@kernel.org>
 <20250618203823.1336156-7-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618203823.1336156-7-kuba@kernel.org>
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: a70b185c-4d92-4db5-90c6-08ddaf39ea72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FhgI9sMfpngPfOHhiNwaHlKFV7KTWF2b83PLmqHf91qcivNqvQH3R4wz7e7b?=
 =?us-ascii?Q?uhWLcEdaycfyR4bxKw6jlv5cJrTjWLNlhGruMU+QA/YPKu8zDGw5PjWSXVKA?=
 =?us-ascii?Q?GD/lLWUZ4qhdIDcYCxogOBT1g8XM9k4HnMBj/m8RUsGtS2MO/RXuf7TOM8z+?=
 =?us-ascii?Q?GOfQt6xaz7Q7f5LyZruJcbI1dxCYmNUeveoESzmYYKbe2kmpSHgZU1RlDEuA?=
 =?us-ascii?Q?RuUo4telXhdgA00E6bab1Lbemdw2L4oUW7oIQXwTvmI+pvWfaPJ+kinsw/I2?=
 =?us-ascii?Q?7+GNKasnofG5Z+2tMIbPEp3jAApU6SzS+PePNTUXWz9PuUGYPcKLll7PqQRa?=
 =?us-ascii?Q?UnA2GtFR/kmVliAppZat0RKUev8VPoWupL686dcog/MhR+NTqsMep/pHS4Nw?=
 =?us-ascii?Q?Bg3fuBYlBdxGYW/xWw6Q3cBGNA+OZ5xbwo9iBqNmRG1SgUYnRWKh7k6l6u5r?=
 =?us-ascii?Q?uv4yKAKM5lk6/WBP7Pp3BaYCdwsLywfKk1rSFlaS/sVOvFo2zerOtVTiwZS6?=
 =?us-ascii?Q?zoD9JvvUCFC4uTj7OJomBLwm5IyjXNXqNwujCipPgIKm+Pfd9aSKLN3nZamz?=
 =?us-ascii?Q?pa3Ab1sc9h9X/xEJh368xYkdjY3a/AEKyxBWDg2KLy3GigBbvPwSIhV77hjf?=
 =?us-ascii?Q?uM4yfWzdw2DEJi2fqN6ysx/I9lVfhwsLNr4RcKmHl9GAGrUC4/ELSWf1pK+A?=
 =?us-ascii?Q?nWhgBWdMSlelRpS4X4HmmdtkV7OaO27C6bw8eTuGiVqSlolJt1e3nqlYneOW?=
 =?us-ascii?Q?O/yzX3bx68T0wwqSjWaV09Wl5+8m8Cz0m9Wq+XSKx21YShSVWK3Q0V24dgJs?=
 =?us-ascii?Q?PDY7xuWRaU7e4qs+txzgGXwpHgG5+knaBQ3L7/DS7ZTLdo5rv39N9HrneRd2?=
 =?us-ascii?Q?Yh/ZVr2s7L1aWgIyRi3xxwXuWH4TOhae5BiPdBKRm6W0KkUbMyn/8Er29rM0?=
 =?us-ascii?Q?Z9w14lhpQQgLLHhpzV0BczeRIgbXQl6eXooJqIV2bn5Thaa/lEd1gQzWxGWq?=
 =?us-ascii?Q?+jC+eSzR+YuSjKuKy5jlwuAbt1nmxPvrDXInljSVy8qwr60n8ZuvY9cwnln+?=
 =?us-ascii?Q?hw0JQdyrlZidQOO6eY/bMdESYzFhLZBpSy5BnZoxIqYPP/seo53X4/qX05ba?=
 =?us-ascii?Q?XHCkf4QGwBysIEhPAXDHcRz4+vEGzUru1R6c427YA9F2oCwo25FU1alfXIBT?=
 =?us-ascii?Q?Nc69Tj0duqJABiz2M4iBoxEdFI6fpl1Puvx2ZLKUazj//BiM/sa5xOTcm2ho?=
 =?us-ascii?Q?crO/X9ZKet/Qz1D5xQ2eSYOKlWFuqhGwDLpXfnKp+hJ2e8CIGQskB5TGYFL2?=
 =?us-ascii?Q?iJYFrxfJk8ufFEjH4BUAU7cI8Kvh5hqLFMzJdCiX53nhQ8XgU7Q20H+U5FIZ?=
 =?us-ascii?Q?rwT7XIU4SFdhkmp1TOf4NW6IIvyEsz65zcVADcHP8JjLQlMmbPcUOlRUlOBB?=
 =?us-ascii?Q?kro8mUrv1Wk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a77q4U4B0f3Kk6u/UJqdHioEYBvuxvNjdcNeAZ+nV7MX2zPytMM2TPHgHiWq?=
 =?us-ascii?Q?WlYWCtQjtFAr2YqNp0zUkOhczYwXS7IPdhvGhT/r3yRwupA1hqODieZCIE+h?=
 =?us-ascii?Q?CH6suUa8CcSj8Z3CXESeMr+luykAF5kZLX7sIbcGnbQ+gG8Bfgq97DKIGD5m?=
 =?us-ascii?Q?S5IjQ6n3JOGHtf6xuTkGz0rO98lcpx/jPBANyFatCfCwGvUEB5t4FSXPyyZB?=
 =?us-ascii?Q?iSmbQe4iCfiIN3uOFvM2jgBIvAk+4MMhV0PGeWD6V/9mNjvJqnZuefkl0iRC?=
 =?us-ascii?Q?ZAL4uR/M9iif4NrQW+Mua+oJAY3PVPtQNpFhvPyEPFjNdSKhG5nw0wH98j8f?=
 =?us-ascii?Q?n0sl8Jf6YNMwZqQELlrqsL9GlUNpr779e0ZIqh3yv+F61WYtznRSRk2epqgm?=
 =?us-ascii?Q?tlLdH3SjUILa7LPJf770lScqF9mi3ZkafQizysETxfhXYw8gKbKKzZG3eQas?=
 =?us-ascii?Q?6KXm5SP3lxpL2YahF8QUvj2YljREUJqHR4qmt4kyW3DPKx6UENMXbWiwmCXQ?=
 =?us-ascii?Q?/ELXM4U6pOw1VWdxfn15Kik/6WJZQyyc7/ogHonQl6u/7iiKWNem/tU0lO+h?=
 =?us-ascii?Q?g0ofwMANd3IahTxjZpqhnO0ZSWRGTtkygjoGR753Ybteu9wS1sbClbdJFOhs?=
 =?us-ascii?Q?fH+MISpZdkF41Rx1vh6oTDY3G9y0d4gUWNQ8zYDSaDp5+fnOIAK7yS+//5UC?=
 =?us-ascii?Q?BHDcb+RZzvpzT//IMB30h6PdFtp83MDokqE5o8jBXAUXe++9yPsCJliJDi8Q?=
 =?us-ascii?Q?l6+E3Ps0NYLts5RSM0/PEyWLzinEsicn16r+cx4iKp6svUuelTDKaxYTTENq?=
 =?us-ascii?Q?uyWgUsfgzG2nOVraddn72liZT9ybC+jWrT8+kcW38m8ufvk1FO174jLaxT0Y?=
 =?us-ascii?Q?r+YzIZPjTplgPYG3wdHc4dGpDXelFxxHZONaDNXsZ50Mso+b40aLN5hEtLO/?=
 =?us-ascii?Q?hxVI1X88mI8n99mn8iAlRju0PHAYrtyj+s8AdBAvXhfclr71ZpndmLLmWlnw?=
 =?us-ascii?Q?ZXaWdCIaoLDnrJSKiPGsW3wFX+IAhJ8GYhrwl255HqfTGdiFpf49OHDW8OFz?=
 =?us-ascii?Q?D/s1IDGZ58bqe4tJmPtsRiaECDvCMsdGFDTLOlaYBuqAYWkkiwUrEKgcMEIp?=
 =?us-ascii?Q?i8LYnz1gXlDm06WCtsMTIdAxbvHeO3mf0GqheyLmdS9Y4s6NmQkdsKoOUJe2?=
 =?us-ascii?Q?RFgra0wZDTzgIvVp3pH0wWSMpFNo2WiesiFTXVmrsmCtskrVUtcfS2gK7mlw?=
 =?us-ascii?Q?xtSUiV+XaR+0F6aXJiophh+K1Ob6EeY40rBwkJUX+Xi3Wsk8SF8Kuqv6Jzwl?=
 =?us-ascii?Q?of0m++w4GI5cK7Mhzf1UuL1Rm3EedWeUfix2Z4+r4khYWW61Lk33xq62lhay?=
 =?us-ascii?Q?n5RkWhGAlppE89vff4BJJlA+9Y/d/3U8SaaiPoy8s8m6YkCUnOMwNemivhfY?=
 =?us-ascii?Q?sUc/vULeDX2YQsGTkqBeUbE7yLb24ewByk8ua+EdnwyThgft0JsGL2UZBUR8?=
 =?us-ascii?Q?8DszzgTjOxfvQtGVOxOUtNMtx6ds9iql3E/t4mZEye7qIrRfQfy90VWVOufo?=
 =?us-ascii?Q?yAraY7hb9KZyXED88iP92jVNfXJnI6xAz1zBONAa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70b185c-4d92-4db5-90c6-08ddaf39ea72
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:02:24.0410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYCq2J4+0mkaksz5/ysf+gXT92Ahk74ofVSCBSqNM6dJx2suk3K3SGaevELxaVpsoK7HUbY2qyRJwItIZvZ5UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784

On Wed, Jun 18, 2025 at 01:38:19PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../mellanox/mlx5/core/en/fs_ethtool.h        | 14 +++++++++++
>  .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 19 ++++++++++++++
>  .../mellanox/mlx5/core/en_fs_ethtool.c        | 25 +++++++------------
>  .../mellanox/mlx5/core/ipoib/ethtool.c        | 19 ++++++++++++++
>  4 files changed, 61 insertions(+), 16 deletions(-)
> 
> -- 

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos

