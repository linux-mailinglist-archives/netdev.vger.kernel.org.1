Return-Path: <netdev+bounces-161137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E2A1D906
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE782165AFE
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB52213541B;
	Mon, 27 Jan 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Un2iCnav"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5D17D2
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990571; cv=fail; b=q6BWe/ijbzV0nz/8LVqFuHRV9hllL2UixwE0AwpNLtnk4GjX4Cey0h7Y8N/x8pBCF470RL/gGgnEYgbfQI41FhI2FL9FmYeKZM/NvrMMrk0hEa7XRcA9pMwkyt5dhAs9CvvQ8z4DGAfhexlI5a4SGF+OOMvjwM96AtusaNHrNUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990571; c=relaxed/simple;
	bh=8CqNzsenvA668VAk86mTI4hPkiVqPuNIE8Iopb9Go/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YqhmjuNKn9OHf5/mUwtLolkhOYuHFx5Ylkz9cx28yZWMISW1aCLR0eNi6eabEIftyAKCCMHh9fySFvHPPR9/j0FusEiKThijd+VxObckbnhPkktRpEr1gzW5S9g/FfYspl0WWInciy0rRKjbJDWZZIyuPDjZEAPigJyklBcQOEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Un2iCnav; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737990571; x=1769526571;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8CqNzsenvA668VAk86mTI4hPkiVqPuNIE8Iopb9Go/A=;
  b=Un2iCnav2XPU4gTtLpVBjJEpnp0xLpsjaPu0NnjlYp1X0ubo16XwlBKB
   0Av0rWe2+bdSrBpb44hmwtlIvT2vZC4exe9jTj4Tu6+HJlsOybYdLAtqi
   I0JgmrkqPI3uGAQZsOrzdErag9MzDZ9nnJ5Midvaz+sFpeDSihwQ6clhG
   2Bzv8yWu5KuQOy9vpKzHmt7YKwnzc9SCIldV1NjiSD0BclGK0K5/qOoOI
   FQjN/qWOnyyY4MssYJMiTbqfNMKzi6lZ4KuPcXCJRd9UhRBjlrnydiq44
   NFWu4y1PZoSsVptLhdm7xwkxtVF61VLlDAY/Nrk2J98OKZWRNcfiu/X8Q
   A==;
X-CSE-ConnectionGUID: Rk4HRsrXQ4+PkvN8je+muQ==
X-CSE-MsgGUID: olaOoHyURvCp8rqYJXPMHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38484842"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="38484842"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:09:24 -0800
X-CSE-ConnectionGUID: kLSSNl7CT8yKetzhIjeUSA==
X-CSE-MsgGUID: xxxDxs1qTEOwajJb/hRrNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113601437"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 07:09:23 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 07:09:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 07:09:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 07:09:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3lAKKXFzbDsp7uqnfPKM2OIdLM/LV5iEG4sfFvMCj/wGCLIBtKywFOQX0OfZr4DCzBl4LfVUnDyuD0nM1FhZYTIAJ+QYd4K3UyWIkXhLyXdImJF/fIHnlq0wZYpTzzKEP4K2/lNzVMcDGxUjH3U3lLcXngo3QUGUT4kYwNDxr5jcbYSnIkQ6uBhrkYhr27TCO0axft0jfmqXqx3q7BKr5Bxg0yp+3BhxYB88uJ7y5cndSFRnD/5h0RzfKMmbVdZXlA75UKln4NGYmQ001GlTLQQWqRsTlC5UCLtodwqFy8a43HlrEtVhHqOXdJlollYf4mn2O2CYIFM7nTRWC+hsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VgObsZnsyE3ulXMg+D1CDZX5ch3PAcvCeHZavgE5gU=;
 b=p0uyDFaM/l6R7lPw+lGqPLZ8ZNf3Lje7+Ucc1VLx8T+P0PX4GdVCxJCnS9r1xCjcirjD9zZBW/l2wwd9QCOuKyeDGNqxe5i0E8Gr7xbyWM5vVpdL2xhQIXKllqPNJpjhmZ3fDBNNEbaTSX/3MGAPByaaYqzsLe6NMH4uwZ78CaJhP8h5yraXhuMhA5sHJoXBTf8XbC04W8Lq8mxyHKBjbK1YuINzBcKyCOl2BT5kIhPt3vQ04vBkZMmjU/TUSO8dEBymRdx4XeB36+W9bPDFxiAvnAO2h1Upqp9rHC4NGOUhFf24BoM2ldYIKnWHP6EA8EthEvFC8dm3MoK6W/l0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 15:09:18 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 15:09:18 +0000
Date: Mon, 27 Jan 2025 16:09:08 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<dan.carpenter@linaro.org>, <yuehaibing@huawei.com>,
	<przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v3] ixgbe: Fix possible skb NULL pointer
 dereference
Message-ID: <Z5ehlNnVrb/PdGq8@boxer>
References: <20250127103836.4742-1-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250127103836.4742-1-piotr.kwapulinski@intel.com>
X-ClientProxiedBy: DUZPR01CA0349.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 461cf801-b60a-40da-934c-08dd3ee49226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XBH6wxI0RBH18M+gB1ZR9jWfQa1XgNg5B4kNt1VV6RU18e9WDO/pkJPLe+NG?=
 =?us-ascii?Q?xuzZr38vTkWHZ9U8e9dti2P/5x7ElnE5AJHjK+5ZnLt/xJxt0ERiBirNfiNI?=
 =?us-ascii?Q?/DRX4Yi/Xgv67LCkx/+VeRDXeYtZmmaBC3+BVInVwsGPBjBhBshYubRm4JE5?=
 =?us-ascii?Q?c2DL5wrz2s0+SAGILn7SeHnL91CQDqmZPgcLYWGVFDn5qUa3vvCjvR16ahL7?=
 =?us-ascii?Q?o5yapy5aaPfKkTGy5SK4648TB3xxwdVeRZsfEbu1pHJylehZ3+028SB3SqBm?=
 =?us-ascii?Q?5+qEg5xnmxIzhOMMFBs4EDk5oqjgkxte1t1z5WzRjyK7W1oAQ0XK8qJmHBh+?=
 =?us-ascii?Q?73r0PASpo7ggXITa8ueeiZEloudAHbBzvcFipbWAQ+JGCpV1VSVnLFsUfMy0?=
 =?us-ascii?Q?lM6jpJW3owZyXhNcER9hrgZW2KxFFKJxJUXn39njCwnUQuRI6wVKa/0rACxE?=
 =?us-ascii?Q?rMSKuMFQnJJ+oS5Rxjug6yQ5CqJem2bSHlMNu5HzAnA984tEBqx6SN0U4+vB?=
 =?us-ascii?Q?fsyHccaUer50rwyAdsmK8ctJUry41FYW8rARPR43caVH8ols7OU+aKcFadIc?=
 =?us-ascii?Q?WmPuzC4qFCbzAe59pL3f5r6BDhQ8pxxA/wEtZ8hGE2rUcebpF5kT5sj6rHQR?=
 =?us-ascii?Q?0ycWsEoDgaf/Ye1SqkWmXxRdTYTj04QgLm/LIjXQtlNlusm961W1K1GMtCA1?=
 =?us-ascii?Q?Pxxb6m5LmpXhpO5CK6v97/vlmHnnFhmYmSzEvVh7QCV3SIz3DgQ+UIYvO9ub?=
 =?us-ascii?Q?5RIP9KWTqEO0d0VY1IXbhFD9ne8s8KV7Xqr8vdJGLjpgsWz3uiWINSCgYDrb?=
 =?us-ascii?Q?eDXiWoK3CIruFiOabSoGJKg3nbSuQYk0U4zYHIgiT02ryVZ2jnGpTL8xnEZH?=
 =?us-ascii?Q?73Cc5ucsmjsCd2sI+h0YinxM3yaEgaVxVR5IvtQDCxBHO5N8ZlCDE3VgqHUh?=
 =?us-ascii?Q?EwHyt+Wp43OrgRgFh8B6G/cpOLPkpLMio5X3wMIr1JSnNhDgk3U3+zLwGn6Z?=
 =?us-ascii?Q?TT0OeWyM/nHaol3IGJgE7hao779/TV2xg5NXnbayAk/StamimM3SA63P4Cmb?=
 =?us-ascii?Q?axjj5cJXBjhgZXm6hvr67bKK78fsW+FHV124ILZrbd4gw/uuHKm13YPRtARB?=
 =?us-ascii?Q?ueNlkFAw9Q+pUGQ4Vr1DwYag0m1T4FVq3o7PD4/9nLIETr27SElTuwWkR8WW?=
 =?us-ascii?Q?tbieutgm9FwcX0MYP2IXA22TxqcDwSFoLfUUS/TfJ66yjk52s6FuOt558QVD?=
 =?us-ascii?Q?sMu1DknsGxclMts5XKxIrWOITT/tQ3Di7cLrZrZ77dfJueYRyUu1inHYppGc?=
 =?us-ascii?Q?0V5ZyaWT+YW6Rll6315PO3+ja9y8EuImKc9J3OhvKXYEMmFcNmo10Qzgx4Q9?=
 =?us-ascii?Q?ad7+p7PxmlrGKSqzgp8DmLEV71x7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c2ZaZHrhrNV7kusNFgdHs1wh0i7cdmK2/bjbBQ2B1oCnaxe8G+5dngGOZznp?=
 =?us-ascii?Q?SnozjKM8dQbSqpY5DEsd7Dp/m9/NPmgFYJrfNCd2lSM2uD5fO3nCu0IMvL2G?=
 =?us-ascii?Q?KKnz/Xs7f0ALR6lFTRAfbDp5dlfP6OMU4S+mBIYUHrIVRsstJ80ulkZB5jJY?=
 =?us-ascii?Q?t9dM3gOQGTObPaiLSfbZ1/v2aXj2g7v5LpU37fcig9gABLnwPG+rkpMfbvJa?=
 =?us-ascii?Q?aCEtmB7T/HLE9XeZucvIQ6+ECFsaO0H/Bgyictm7d6g+Ct3HGvGP7vU/24Y7?=
 =?us-ascii?Q?Dr19DpauTsiliT9geQ3haNTaIQ0icGyWH2eU9+xblLyZkRyLyWh5SGwDISgn?=
 =?us-ascii?Q?lP9lKtJybh4p7DG9gC9ldNLgxy7KD/2cAU5p/HVwI2JhM2EQna7RvR8XKprr?=
 =?us-ascii?Q?heBvmsEYLaCTxc/yT/JDoTep4Bdd1d7WBmesyDDVgeY1H1icW0pKxoUiAG1n?=
 =?us-ascii?Q?p9wYWwwbWERWrgY7WQhMUCun5phc+ki5BXnjkHnsy6rilUAc35Ba48W7KA8D?=
 =?us-ascii?Q?/J+YFyr0IB4V9WJNV5qWjr9hgbudG8wYN8SW9FkZ9IreLz3J9F5GTxMo5Pie?=
 =?us-ascii?Q?7Wt2djgvGymJxkQDd/+DnYSEiJxAyluOIPgYErcpE9MToA6cmg0KILJCQp4J?=
 =?us-ascii?Q?MSAeUnobgZGjIeb1/tYU8UpMKp6LNTm7zNRLGDsadQgE6AUGe1XAw68bqmoC?=
 =?us-ascii?Q?fTSlNb78X66t9kOpjVQjIM5g8nsMdB08e+RSiISSd9ouQVU+q+vMMfVLov7b?=
 =?us-ascii?Q?hzjuIyJXIpkztOE6y103kEWtceB/n4irvSeZzbsCN8jXUKag4EI036I2sH3g?=
 =?us-ascii?Q?5x8TkGh9g7Z53dRr3qlWAyWomwHNuV4TBf038DDSX8igRdkCuH9oYSrcNKwa?=
 =?us-ascii?Q?7qKixtO9HDk7ccYHRiKHTIaKlP7bOr/s0LUEWs9aAQNG+SEA5NHkcA4c8EI2?=
 =?us-ascii?Q?lvEaCBR9Lk+l6n+hAZFTb5kfJdmH5J9FJ+9e+rtzubnO9HVIv7eDX5n6ha9p?=
 =?us-ascii?Q?jIpVzSSQW8GbRQklDGMGmOpFzB9wDy8lAyz56QFHkhnI9OltatohOAm9oe0s?=
 =?us-ascii?Q?MErPIlnmyNrDiYvMvPdOcPEOFoCz31YdPUkznr30UUTFpdcMzsYvNWghUZuB?=
 =?us-ascii?Q?qtrkhZrTo9M1SvO2A+q/vssbNA43P3I/DbpWHkqVQHkAlMsiGnOUdZCCCKDG?=
 =?us-ascii?Q?ObeCQcIXMvI+t/HIQ4GG1lcX4zXi8Nh/oQ/XHoDYJBeE72J4ddVdB9wWLsTZ?=
 =?us-ascii?Q?k3FxJgb2B1RQn0FuJXcwXVfUywkHNoN9Wk3NF9DxHV4DmpVfHINqb4JOufy+?=
 =?us-ascii?Q?yCCyAmksjswhHn4e8dVW4MDDtsNLizf8cB38MTp6kmf03VBv5Rsm6m4E6nAs?=
 =?us-ascii?Q?fFxV6s+KQsX45aIxp+XFZpnrucSc2t94d6/TXj88M/HUptiMD1pMCQJzVGd3?=
 =?us-ascii?Q?ud6Jzg4UkYdORmTDTf0bRNiWYj+ZSNcOH482P7flpHMWVNWp+tfvURvEKdsI?=
 =?us-ascii?Q?XIb3qntQFpgPDsL7x7J1esUM0Z+2+TBgvwd+HO4LG2q6s2NGwPi+dATyXeXI?=
 =?us-ascii?Q?L++K5bCPn+vJkyDhUHG6lPws4axKi/L8mK8L/BlNdlhfxj7P5c397BTsXqn3?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 461cf801-b60a-40da-934c-08dd3ee49226
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 15:09:18.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjIHOvojjcZZsQOzLd8v1CTp/Dp/PQoeV+c1IwjuVToy0HTeOjgKWyR84/1i4vJUjBQJhets6DQsgGe6luAvAzdJbAahHYzYFgJKr9zRYjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
X-OriginatorOrg: intel.com

On Mon, Jan 27, 2025 at 11:38:36AM +0100, Piotr Kwapulinski wrote:
> The commit c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in
> ixgbe_run_xdp()") stopped utilizing the ERR-like macros for xdp status
> encoding. Propagate this logic to the ixgbe_put_rx_buffer().
> 
> The commit also relaxed the skb NULL pointer check - caught by Smatch.
> Restore this check.
> 
> Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 7236f20..467f812 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2105,7 +2105,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
>  		/* hand second half of page back to the ring */
>  		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
>  	} else {
> -		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
> +		if (skb && IXGBE_CB(skb)->dma == rx_buffer->dma) {
>  			/* the page has been released from the ring */
>  			IXGBE_CB(skb)->page_released = true;
>  		} else {
> -- 
> v1 -> v2
>   Provide extra details in commit message for motivation of this patch.
> v2 -> v3
>   Simplify the check condition

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks!

> 
> 2.43.0
> 

