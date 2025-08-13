Return-Path: <netdev+bounces-213400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D53B24DC5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F747ADB37
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DBB276058;
	Wed, 13 Aug 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5uYK6zg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA91EA7DD;
	Wed, 13 Aug 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099585; cv=fail; b=daxCRHW3xEkgM1nsG+9uB2De5zGwdb8fuBReWocoj4oxlPmnMy/Rnm96b+mvofuMbdgvas9oS8TZXuzVZJe/1yPjYQRQyVTfCBfLXHX4kHuGca9Ben1RXeP1HTV8R4e5FIbNqs+qIV+5pJl70E04sqCKwgrl2c3SP7jJYgkyHLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099585; c=relaxed/simple;
	bh=THVxfgVDuFKn6uT6qAxFcdQLdLfam4tkCG0sLCKSKik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CPYYyKX17/ixDBQOQDxe48nBOfHmQHaY/n0ceYswwBbcXqsEa6KPyIS7jqi5PG5rt8XHShy1JvLN4H2m1czTIm0ASlL+0brb3mN4Pssx6y3M0DBO8NMNf1qhodfME7PqS4dkvFXwtdYegDe2ltIlXGx+7SXq+eYpEs5uSMhDr4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N5uYK6zg; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bu4DTCitDz0Ea5WkRgG2HqRkBy/q71vxSMinmkk+z41dLbfsE8Yv+bIPhsRrQtXezIOV6TUAUoA7CC2F71EK0586AQzLkpSqOg9UkGmY1UcQozF0GZSd/NLWcnbu3IfLXxLpP0ifOToqlEeg7pDjb8s56xiZ58dWSWXp44HxVbRzuXq6MwrvLm+MpdAB0N4DK8+StTRzHWUCZPvFeJ8IPtjT2hFbWIuX3fwdT2N1bTZrWZv36sqgxM662e/2nzWBARrhgTIV0OntGUcmMLDyt1/tEFU6DefdSKwgb7Siyfj/CK30HaqaqnL+HBfUNXk3diroRuT7M4yy0//qVEFQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEX2nWEGddl0WozULOl8ic3oOCg5xLPNm2WDMMrdkQQ=;
 b=OtXiYkiEtKbHK5W+kqlA2WIjjTXpUDZq/I52KX5OKAcj2CvuIuddU69/dQFtQ+p4XeWlTLqHW6b1IbFj/Dtxt0FqdDiHYzJjIcylDUUlGluo1mtmngKZZAH88e4lJcvDQLzOAGQWU+Wrcv/ANEhN9FWqFrkBrYEc71ukCUcLkxDk2v2QWRAQTyxCQqxRzxiO6nkIFffEVY8xru7Dl/nJ93lKm6kqaKXsaYHgbQK2oF3TMc6Skz5IPTNF6oeo9guQ2TNhk94NLJu0BYsKjPsJjjE3+bmUt1A4OE+4TFIz4cTRDu/mlXMhPnQwfWGDtWYq9j5iL6I5sPbpPZRMCbhN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEX2nWEGddl0WozULOl8ic3oOCg5xLPNm2WDMMrdkQQ=;
 b=N5uYK6zgp0XOTmWMVfCKXjlsNpgn1OH5CLMExYnxuVEuesJRgeIQTML/1sPG+vmUa/uAvVLKelIIi0rJoY4UVvlp9tRf6Cc1GazkiRhW0TTrHFmaWNffyW52vm+jUYAnqt9D8zxwuZwk/TG29ldKJQ5+HlGrlxwaHNfmQ20dbxaHZzJB7w2/Lxl5404s9mDdAhC2HiFO1xbZFoJmz1tGm9hXSn/JxD9n16r/m8FIMa3OpCareBsSXKSwzwJ6jB3D9yiKPD5nEl6WerHFwqhkYgLxlvqy1SXbYA2ihTIVhStrHo2Wn/qQHbkY95yXZbZP6gSDldm+fFQft0YiCEYqkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) by
 MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.20; Wed, 13 Aug 2025 15:39:28 +0000
Received: from DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438]) by DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 15:39:28 +0000
Date: Wed, 13 Aug 2025 15:39:23 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
	Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, 
	horms@kernel.org, davem@davemloft.net, sdf@fomichev.me, almasrymina@google.com, 
	dw@davidwei.uk, michael.chan@broadcom.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 00/24] Per queue configs and large rx buffer support for
 zcrx
Message-ID: <ul2vfq7upoqwoyop7mhznjmsjau7e4ei2t643gx7t7egoez3vn@lhnf5h2dpeb5>
References: <cover.1754657711.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To DS0PR12MB9038.namprd12.prod.outlook.com
 (2603:10b6:8:f2::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9038:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: c0345923-9a4b-46cd-24fe-08ddda7f96b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kGwAkc5b/ykwe7J5artbWVVG1oNPckM5gx6IBMRl75DVHharlja0fl0NWYNV?=
 =?us-ascii?Q?odeOibSIWD9+8iM2RH9KLPPhiQC/hkt+hFrjdVVgy6B6sNHzr1EdxVsF3t85?=
 =?us-ascii?Q?VSe+sFfUvhNgsOo+NQNWXB6/lvt/vEkfuXOJOaeBquhO71gosHI6bEtYBPzs?=
 =?us-ascii?Q?PHM1AKi/bJM2A3RLjFU7o3jlS41IPlc86UfC/Xfocq5h/7dcxFV0/WBhc4Sn?=
 =?us-ascii?Q?tXgDiRz8HLYLV09AuPC4RLY/ChZMocHL07I7w9Ta6z7a7u/L/QxVCk+0b+FF?=
 =?us-ascii?Q?g92ouZk04p9oVw6IhjNIL/icYzuGIaWI1C4Qne+G79RWF5ciSKiUSx5Ig1Ku?=
 =?us-ascii?Q?E9Iv6JF+MNyOyzFuqz1oWszgdfx/5fLvW5DMl90MvqkmX7UOcPbsjGu4Lo12?=
 =?us-ascii?Q?wINGbt7rs4KGoTAYgbWTUSV5u6bSo+fK1GaFTNgIflwFk6RU6fdUyjLwhyCS?=
 =?us-ascii?Q?3EcEcrvFBMr8JkBwoCWBxilvf8U7NFSIXK90yDW9OR0ZSd60IIznvQ+h5S/R?=
 =?us-ascii?Q?hRTeV+HqywliVFXUicfvMUabMlBwiAQ8ORpbQL52wA0Pr62J5wGXsxyWWqtk?=
 =?us-ascii?Q?HPmZSD42SR8seITB051F49KPGOtsNB+Xo0PFyA2E6q90ea1FRIAbWRFmRi6S?=
 =?us-ascii?Q?YgBRAMgc4JO/ocQcNYxmSzIMdmOFpmpQo3Ir5ctuQTrKcGQp979TyHdD9vCl?=
 =?us-ascii?Q?+VYH54/Q9pSljjOF25kl7wKyD7VjerehjNs4Tj+GdvDHgjgSty5a68vtohWi?=
 =?us-ascii?Q?Mnmuc+zIhAq4dhaBj0tkD89jaDpO+TpgZJCAOAMfwlj66gr6zXfZ6ZwZwX4b?=
 =?us-ascii?Q?7OlLdIsULZnb5Azq0RSX4jY4f1ajDgYrHPHZe6R8U7YG4Md/eNVEM/0sG+ZL?=
 =?us-ascii?Q?589aM2YdK/UL1AS2oFWiJaIIOxYUAFPBVz5jaBlMOgzv5NjxU8C8jLkuisrp?=
 =?us-ascii?Q?IUlgCEcuQMTnpl4hZMGwyrUSAXstpCbbg+XLokEhe2T2MDcbYtl9l+GL5EIR?=
 =?us-ascii?Q?9V7zO2SAa77OKzNVNMgHVvMaiOgPKgxegvUcDBEaAqHQBfStqZEq+QPcPEyz?=
 =?us-ascii?Q?Wzqw55BmU49CMSXDgEGYG02AkAooZ5MiRTGvCXqVVN61eV9o5BmZsA8FJ1+K?=
 =?us-ascii?Q?Q/m/cJURhePF1UY9HRta07YYl6q+A/Sa0lxoftV0Yh2GuTmsyXmfGq508QNB?=
 =?us-ascii?Q?bY1COw49tCjOE00rt9GbTKdCkDATXdKBr5pCSbiSThCH24jmN714bbvfGhJy?=
 =?us-ascii?Q?NSN8t66FirTD+Vj6tjeltc5466Fodmfa8d7vYJb45QTD25LJkocno9atj0QI?=
 =?us-ascii?Q?Vid/X5GOHkwNEF3s6fvgN7tGzGmI+M73Ndr919Gm1d/hnWqTmPywXEt8RcmK?=
 =?us-ascii?Q?ixs4enXdxBkMNLqrqMvcfh/YCkf75C7hiKd6n3oWAud4j0fX1NitgZne4jwW?=
 =?us-ascii?Q?ClPMjtfeZwA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9038.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TY3ViV+jKSGwfZ2dbggxT9zjQh9nX/MfLblXRvt0NuxI7d6P1gwsrj3AXHCn?=
 =?us-ascii?Q?jlYs5+am+HJMH9MzGJWnR+FTBTsZ7TuzdgaZsF6EuaTPoTQWaZH39bw2vN4A?=
 =?us-ascii?Q?znLYgF+fHMkgM2U/fYoklL5yGEQN/mf1w6rO+qAZMBeW5yya0xuc9aydddyD?=
 =?us-ascii?Q?2pe/Ca6rn0pkD9ExCLG77cxcuSB6WBKkA2xrfYxfQv2cebrs/CMJAfO3QjWv?=
 =?us-ascii?Q?8K0A7h/2D4C/Fbmmec0uCTY8MXqmut0yoqMj8oWBQRV4+OLP3Y5rrANbrSZy?=
 =?us-ascii?Q?8ULEblke83Epq5jUt2YNA9xHjcLdeZZvw/umyaZAgf7vQ33VAqBaeXnl7ylb?=
 =?us-ascii?Q?RdgROpC0M50enYqy1MGkfl8GLjMzNWlzw3exkwbZTHrtg8J4ktoskBjpHRO7?=
 =?us-ascii?Q?R8HAVeWUpdw3mtjFRBsdDZrJmta+Yy7r6zM1TXm3Nf7wzCAo50vHjiZmOLZN?=
 =?us-ascii?Q?fhtHXrL8QP4yO/Jyx9XqU/pUiJ7GhqQULb7ZZzUnVnb69s92tHJ6oewQtOX2?=
 =?us-ascii?Q?T1Pb6HmaUBZZkWXs2uQ6JLEs3tDlKuNCvJtbtsZgz0QRoDrdSTV2yJr3fugC?=
 =?us-ascii?Q?vBWf2Gyetif+8jphn1oB7M9t+jQ6Dwi81COXCr1CYy6IgOeGznf76eaPXZuo?=
 =?us-ascii?Q?8GYlejTfIJ7YhK1VKZrop06bqj30YZSNaWg20FlBDPgztBMJLPUDaYaYj4DQ?=
 =?us-ascii?Q?D9kppE6IMnWa1plJcSMD5T6Ax+yIsn2LH2n709t8NDeaYwnqVg0HzVDKLevh?=
 =?us-ascii?Q?mvoWNzSoPx6DI3d1MRJgrl3lNWBUYnw+BkHJDlAa6UzVk4ZnBUAGXzTrY8GT?=
 =?us-ascii?Q?3VLO/G8hy3RUJcFmq4EaxpKGXZkIwyx5iFN4rGkNEEcfX0nbxWJSCDNZzxFd?=
 =?us-ascii?Q?MJDAmfuFy4llGBVJbGtiZbY+avcM3/+J7az82lhner5YIDA8KHHsuMHKyekF?=
 =?us-ascii?Q?ZPHJfE5caSB34TdWHA077tk7TJSDbPm/3e5o0EJ1t/xfiN+dj19iT3A6eKLs?=
 =?us-ascii?Q?GbncGiHG89FWMXy5sOmp1ZCeSKkJw2mQ90CeqSgr2HqSkv5Fj/YUhrLN7uhI?=
 =?us-ascii?Q?bKH7IS9p208Bpo0ptkpe2HpE4NOGyE87llFgXetKtgOwZVKUWLDvbvT2UZfw?=
 =?us-ascii?Q?O50jepfgUy5JBrDs0pPG3H5dXYWBLqFK5QIv9ZUx1yp0WHUQ6g7WssLH55Mr?=
 =?us-ascii?Q?kMtUyAEwY43VZj4gNjft1Sm5Hbky6XN+lroZ4UUbE2OZEyKyUZ4ySso2R4lt?=
 =?us-ascii?Q?9VUl/66+Gnl8ZXQzEYqGDSeE9sWddkBOAngRBm37ogWO215Bim7b00PdNAe4?=
 =?us-ascii?Q?/eO9AFVNuZLuFjdJMR0hDRa1kJJQ4tbEB08HoPJpZODG9guZuU4y23kO97gM?=
 =?us-ascii?Q?PtcohyNw2cgBAKy7MXPtVjxpmMVAOh4EGYAjvF4uW3qBPSNPBDwGgnkbzfKG?=
 =?us-ascii?Q?kGzBx32j5tmOE1AwLuFybdQnLErsmPk6+kwNVjhIMfE94c3PgY1zYrNmee3f?=
 =?us-ascii?Q?YWcoujTlcRNuz3ux5Rc8xz2BMRrft7J1EGNz/eDDlCP7c+uNT48GTiF2ool8?=
 =?us-ascii?Q?eAc+AydxYBVTv/PEBrksCjMbgcr6oQMvWnE93y88?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0345923-9a4b-46cd-24fe-08ddda7f96b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:39:28.2494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tkrqa7cPyk/pQ1hAw8DjwiOpVmRjz58xCaLg7ahJas1De2z4eiQemobmOngt5JFHgkeBrefi36Y1vwWgn7g53A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809

Hi Pavel,

On Fri, Aug 08, 2025 at 03:54:23PM +0100, Pavel Begunkov wrote:
> [...] 
> For example, for 200Gbit broadcom NIC, 4K vs 32K buffers, and napi and
> userspace pinned to the same CPU:
> 
> packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
> CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
>   0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
> packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
> CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
>   0    0.69    0.00    8.26   31.65    1.83   57.00    0.57
> 
> And for napi and userspace on different CPUs:
> 
> packets=10725082 (MB=1227388), rps=198285 (MB/s=22692)
> CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
>   0    0.10    0.00    0.50    0.00    0.50   74.50    24.40
>   1    4.51    0.00   44.33   47.22    2.08    1.85    0.00
> packets=14026235 (MB=1605175), rps=198388 (MB/s=22703)
> CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
>   0    0.10    0.00    0.70    0.00    1.00   43.78   54.42
>   1    1.09    0.00   31.95   62.91    1.42    2.63    0.00
>
What did you use for this benchmark, send-zerocopy? Could you share a
branch and how you ran it please?

I have added some initial support to mlx5 for rx-buf-len and would like
to benchmark it and compare it to what you posted.

Thanks,
Dragos
 

