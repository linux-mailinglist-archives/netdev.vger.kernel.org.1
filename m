Return-Path: <netdev+bounces-151052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB19EC950
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDF1281220
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549A1DFD89;
	Wed, 11 Dec 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="qFe8kOe+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2095.outbound.protection.outlook.com [40.107.92.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE391C5CD3;
	Wed, 11 Dec 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909959; cv=fail; b=Ce2ch/OySBRVOcQAFlei5AbDRPuy6o6ks7MNBWAuI+U1bmH3s6oBiycjcawLUW577M3jUQFssTFGtzpzXR7W5lj3kn28r1GTkDDlQdgk3YBDfu0ye53e80CuOxz7uPAHcxduH7zAFQXWUCvY8bVlh8Xy8vKMNUQP9U7JkEDvuSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909959; c=relaxed/simple;
	bh=c3+P3Q4Yg9Wb68Au6pvKO//3E4MzF37lKOM64VXeV0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P8esiQq7cNDYxpW6i2r4MtSE7tRXoUN599+h/PHmYVrSPE6AGTLlX/e/Cy8qrcDNvRMBrRIEuXkOzR/3itWqTejfbN2xNoX1gJHfFel/Q0k0shsGp7+aNeW3B2R0CrMv9UXcW/d1e8zMlvqWxyUXb96WtuLOMBy6umxb6XNmcyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=qFe8kOe+; arc=fail smtp.client-ip=40.107.92.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5lhWr7OSvzz332UcvGGLWKuIMz9q02Q3BPE/auHKZ90J1EvKG0G1YsyqdWAytBlMHTSEMd7o5hcGsPthtreVr4y38Rd1n5GBnIBpN2P6K/QgsO1We60SBNLeI1ZvRVrRg1JBKFRmOmKVoE+Y1KPwAEpAJm4VJHBiJHRqHcLET4dKuvabnB4fbkfzgsYN5IW7+oBSjdF6U8KNxSHhs+5DJ9BCAwi83J+PCPkZJk+i14LdhQri49PJEHHp3152d6TxYhUZSjZq9eB4eo+SxsxG5eSgHTQG8a2NM9Pv7xU7+UOj/PRKg0lXwV7tAXuJpbY2aKSmdlrZGlVm4aSkVKZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5iJmYsyQqxrw6dzt8uZoEzhtrjHSj+Vrl392CBq+Gs=;
 b=PTnpoCbSIApm4PROjGxY8aygmhardft0DfMgBvbulYfQpNuFtMsPXB5wIGJClxk3Or5gXb7TRyCfnaq4qldxaZx+4eARF1FzFA/dOzlQqKF72YmssiCS/JSYXTYhDayfwSpP1nAi4NCLPWQgn6POcBua7BQh8BCMYBwEf2Gm4mU14INCYMXHll1rW1WpC0/eAooPm4WS6jpEVTvwLIU4ThcbbgrhOxNy2to/h5KN38+yOxQL8/uIYKKXl2HnqG8hEKZpUJCg8SLEBrkFEj5DGE5vuJgbmwp2yqaHLoRrsfLl4H3tkphzaQTbC/jE9ZvAHX/8NVt0eC7M7OutY4K5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5iJmYsyQqxrw6dzt8uZoEzhtrjHSj+Vrl392CBq+Gs=;
 b=qFe8kOe+v1XfkD22i9/e7TCvxnm+E3gReiVC5BQjD9o0QCmNB/xr1pSCdF9SWSOdUZzZ9Xyylf/rz6dL/m+vI91VXuLNtDHebSSpgVXYxvf6B4wxSYi7Rlom4OdRz1jqBN116sJl1vJw6nNrKxQDGw1WDx7gahVU7ae3pBdYZIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by BL3PR13MB5225.namprd13.prod.outlook.com (2603:10b6:208:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 09:39:14 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 09:39:14 +0000
Date: Wed, 11 Dec 2024 11:39:02 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	James Hershaw <james.hershaw@corigine.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Mohammad Heib <mheib@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	"open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] nfp: Convert timeouts to secs_to_jiffies()
Message-ID: <Z1ldtgYpXCIIN5uQ@LouisNoVo>
References: <20241210-converge-secs-to-jiffies-v3-20-59479891e658@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-converge-secs-to-jiffies-v3-20-59479891e658@linux.microsoft.com>
X-ClientProxiedBy: JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|BL3PR13MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f23d8b-724a-4a83-4369-08dd19c7ac82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QIe7hdGFTYw0MjEwLPiNCS8DLBX1MofVoLZi1uFNV86U8sbpvuXrL5e/PANh?=
 =?us-ascii?Q?N2FmmoC5to2ZfnkiwOQLNlOrhTbLW8FrefwiWwj/8IKuVTVK6msTuzMJuQlJ?=
 =?us-ascii?Q?oKB4+UgV23qGiHu1glRCML4S2gngnlO8HSeiDUkxO7TIQmm1UIU5x9DdTozO?=
 =?us-ascii?Q?AbBnx9GQKpMZG+CiEEV1s8bX8qIMLz/ZiBXErVuIRxNBVq4wXZxwe084d1Rw?=
 =?us-ascii?Q?wZYjS1HgaASkVutck0wXsniYslnIhj/7T4/Em03Gwu+Rw7YS4KVGyGfzR8BT?=
 =?us-ascii?Q?C6bIoBp8gBEjsi/KsrBUpe8NzyliiHLftqSRg3An4EpK7r/ZTE3fiR7gWzoS?=
 =?us-ascii?Q?Ipqby9k3DZ2YDZHOGsyULsSK7PKTibXRov0lfeD/bVamRWdwP26FdFGMB3aM?=
 =?us-ascii?Q?NZ0xuDIuxS+q3aeC5GlkmY+QQUsCjO8H9I2opBpr9s+uJLDRPK9twpk0rls4?=
 =?us-ascii?Q?NvCmnPZDtatGdYJyx0y+rZluSGhLD80cMC3d2/b7WUprEjfJaPF15JQWVq68?=
 =?us-ascii?Q?MchQrzUJaB0KAMUNRzxBHd/1uD94QoTVB9xPFdcWkkXfGwxtYo7mCu0VJWJl?=
 =?us-ascii?Q?fE7DX/9hFbjPh2Z2DzkNX5uFbUCyn7jzvwUQ4wCNIrINca8HcjGTTU0gezey?=
 =?us-ascii?Q?2c0Ja31Cgd6ssV5OIrwh8AZSSSXWWJ46UjjTza+6T/HZ48JtSsVIrZPm/Nqq?=
 =?us-ascii?Q?nGIQ94dtBF8fcDNz4KW6r6vZiRkcvDzi4faTlyOA8Y2WxSamqHYFoIt9lYRf?=
 =?us-ascii?Q?4FGdIdExCvMqApKSzmGXEcGk4Sj6HH074dOp+YwiQ/Y1nM6G17dYGGu0/4VS?=
 =?us-ascii?Q?vDXfEsjd1VZkRlUJo3tCeEnSOlEI7bXBzNVNp240/PYwe5dyjwtAEGpuyQLS?=
 =?us-ascii?Q?HypdWrLQrRZZVIFn/7F0WeIxudaEPbHneuEBQk2QrpbkcizZcTgxHNFsM9tj?=
 =?us-ascii?Q?vcCucNj/uTYFUNP9/dF/0uKO2vlQ+3XnX2wMFBfJv/NKs6l1t6xHo5qJK/TR?=
 =?us-ascii?Q?a2BwJnE/PtKxuraHlVQELJL5P5Pc81VezcgAiLhOt7ymfqA2erunCVG5CwIn?=
 =?us-ascii?Q?Nwi6ITUN2o3FU+qrcNR4xNiJWsPiApzuxlLr8PMD6L9T0Kv0dshV60PAfFlY?=
 =?us-ascii?Q?R2uRMdaV8+ZlHzZ1DSx5rpcLFGW4zy45THLTsOMXiXJI2yikXBeOy7lq8AFT?=
 =?us-ascii?Q?E/X6mh28nQeiGK5lXXZmJj5IpP/6Qb503eiQOW7pxc7GXQtClmxrfkw8DnTN?=
 =?us-ascii?Q?m2QzyviUVhJ+G+bnRZaIGV+Vj+lZ3tMqWYGzsMyhlZSgkX3CNOK/PFMuTTNw?=
 =?us-ascii?Q?CpDe2GvByiK4N1QPl+jIDXg92ljtc1KboxS6CiHQJtGhQv6Aoy42FuqVv54x?=
 =?us-ascii?Q?YhXLhFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ECE0n+Y+irn0AuYD5RFHvMmLvQmyQ00rwBE9fmkHWWgwEFM4j7fRhxU8n8XU?=
 =?us-ascii?Q?ZuMyG6PJ1P1YIgSjRzfsNNa3EJXDXEMi0xpOCk46ynhytUT2T8bbh2cEFutu?=
 =?us-ascii?Q?qA4RpgAi74Mz68NzqhsQ8+b0JKdmNXoVvCFiF8ILw6gMW7dML0F5asjOMov6?=
 =?us-ascii?Q?gk/F8ljzIH0x2BcbudwK+ZnzmW8q2FoOiNR6pQ00GvbNQn/nes9MEQ+fZQMd?=
 =?us-ascii?Q?ODcKO9vIZFabmStg13T+YrDKKRd5vlsutwNKHpvDwWBXTlKk3xT8oQgYGXWP?=
 =?us-ascii?Q?rJJcKufoID9PoKimm9/cCg+ZWBZ1Q5ZmwcMvC3kR/ulxowtFQjtwqbY9CV3+?=
 =?us-ascii?Q?yooj/BjN/ktcY5RSzkRL+/2B6QGBf5KOmajeh8gH+5Xn0InPMCrDxQ1RnCpV?=
 =?us-ascii?Q?LTKLI9VvHU1pGhuz3xYT0v3eNu/AL5kbdnGQSSnQUn/S0b8xmzhO6FNGPXCf?=
 =?us-ascii?Q?4dbBkjegV72nSQcdJLleSA6UY1AFhHuu6F7jSYhU516F52zWj9yYD8hHDnHG?=
 =?us-ascii?Q?iDlOjfUTdM0l7fSn7Ns8jf/GkkE/2BaTFblN2B90UC+FGWQyFBIiMi7sLqtv?=
 =?us-ascii?Q?9pge8kY/jSswCNBjpO6UCk6QHFxsQmkjYMWK0fmJFBZ8JJQjRG/+7c27YnT5?=
 =?us-ascii?Q?noXG7SyBBIPRWj6qJyXF8vBJOKOmPZ1f9ClkduJAzfQmrwmbBoJvfBTJ0vMY?=
 =?us-ascii?Q?mUME5MLMMPN/4QaaSgRNw8o/YhzrwpQVzEz50MGl1hk00wv+ObSOjUx1PB1h?=
 =?us-ascii?Q?G8vYnJ9mJ3+6xFmWVevFuly/I8wWErlyTkKxWHTWqvY/K3yDsaBSdne2i6yX?=
 =?us-ascii?Q?aM9jvy4i51Bdu1lt3usQkN0KPLLVUVAK+w3JcMFyVQkxeheE/ZAWXSIjd7Zx?=
 =?us-ascii?Q?YzDriI6AHq1PrIG/xrIFn5NXGssK+MUm5l2lkFwIkc/Sm2rbNfoE4t2ON/dT?=
 =?us-ascii?Q?EJJg2fv4i7m5yuUiU89WPUU7fYeMXMneHNqp9XX4YiWln5Yc7MSPrbRgxEuQ?=
 =?us-ascii?Q?QodA5oYiXHtz3zqDH+hcpnmnhWaqsNlBWHPXBH2s7Nz1A8NQKWmAs5eEEVnb?=
 =?us-ascii?Q?plJUZdt2JGT6Ip9WN0+Ej7nszFKk+5AL/clI0Afw2YirjxLu5HxlTcs5vDPa?=
 =?us-ascii?Q?c8VpCHe1OsJSZbcNyy+kijzqCLmcWYDRPbKybrNyHGoCo9oxL4uaiDjCdmV7?=
 =?us-ascii?Q?bWJongoXclrnyX0+Twy4fgGYzl8s0/XNLeepiERQ7mj4MSKytduZGnMQ59Nz?=
 =?us-ascii?Q?pQx4VLxorzbkVZezc497KM8Vh6QAqakoxkeS+C12NZ6i+TnCbctSK8jl3nwL?=
 =?us-ascii?Q?L+i7zg11RUVQmomK4RPtyriVJf52qSYbKmEb2GOEMbDetij3sO68YVKW8+vl?=
 =?us-ascii?Q?kGxUjp/xlEePi9lPiFvq1MUcwiWQccc+uvkKcIsAWfdfDzbwzvbVQ3gGaR7u?=
 =?us-ascii?Q?h7tpJqN0oETI0yg2VdZvGsrZVP6EdWYpRoHm680q+DvI5PUWhYEVjd+HE7Rf?=
 =?us-ascii?Q?GCrWwIqbz6wXVTswimGKYbQspeYBvUeGP8qMpZiHN76tvzMFpuunpuImHaJd?=
 =?us-ascii?Q?6wapChI9dDTjt1f1VMP3uoCupeaG8AvfzT3vXdFXXX/va9WHDqyS7WnqTAEu?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f23d8b-724a-4a83-4369-08dd19c7ac82
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:39:14.3768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZFRb7yIZGnao0VWQ+hGTAN51BmwoHKagLUEhX+NrwY6bPXBjgk8giBbUOV9lxoUzFpSC661eQBGFJ/dUnTTUs4vSEHSaREH1gsZB3q04zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5225

On Tue, Dec 10, 2024 at 10:56:53PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies(). As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @@ constant C; @@
> 
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
> 
> @@ constant C; @@
> 
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
> This patch is pulled out from v2 [1] of my series to convert users of
> msecs_to_jiffies() that need seconds-denominated timeouts to the new
> secs_to_jiffies() API in include/linux/jiffies.h to send with the
> net-next prefix as suggested by Christophe Leroy.
> 
> It may be possible to use prefixes for some patches but not others with b4
> (that I'm using to manage the series as a whole) but I didn't find such
> in the help. v3 of the series addressing other review comments is here:
> https://lore.kernel.org/r/20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com
> 
> [1]: https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 98e098c09c03..abba165738a3 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -2779,7 +2779,7 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
>  		break;
>  	}
>  
> -	netdev->watchdog_timeo = msecs_to_jiffies(5 * 1000);
> +	netdev->watchdog_timeo = secs_to_jiffies(5);
>  
>  	/* MTU range: 68 - hw-specific max */
>  	netdev->min_mtu = ETH_MIN_MTU;
> -- 
> 2.43.0
> 
It's not super clear to me which patch is handled where and through which tree
at the moment, but looks like this is a network driver change scoped to the
netdev tree, so makes sense to me to add sign-off here. Thanks for applying
this to the nfp driver.

Reviewed-by: Louis Peens <louis.peens@corigine.com>

