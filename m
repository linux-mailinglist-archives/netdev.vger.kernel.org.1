Return-Path: <netdev+bounces-158171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5677CA10C57
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A36F188118F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36A6191F94;
	Tue, 14 Jan 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llf56h9K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29B1885BF
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872423; cv=fail; b=GEFSphOmJIXbZzj512Fambl3jbmpVHLzbElhDelSTfEF1JH7zxyk30GLjRQFOKPzQ7J3Kk+sWRvqt8OKfJFCGNSMd9vyxc5MuuQuZmwZugOP4c/5yworrs0tlihOYpUiJ+9ilbEvdGBKwAtc+4aXUMsRYnHe/Jj7b8TPFvnUjBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872423; c=relaxed/simple;
	bh=AZi6yIa5Yxz4KweCbdygq/Yp9lGKUI5cQBIRQxfaQxU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GOIPe6Q8dST3yL12bzBvh9Oj3s42OYH1SDsDegQpKJd7BSeLSPPIUC590Cbahy5NWSsbAOY4DubaIQQE/kpnfwUFSHq/xSks9lhrDIvSSEfellYfl7QB0xIVD8cXsUOZmwJDt4obsCoo7bdZCy35eMpW50joIXS0hCYPrp0GOnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llf56h9K; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736872422; x=1768408422;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AZi6yIa5Yxz4KweCbdygq/Yp9lGKUI5cQBIRQxfaQxU=;
  b=llf56h9KWEzW3FlTxSP/HhrYZ87w2DjFDmds67diDjohnbl2043H/V2i
   izHg/u3o7mJLfidtGskeQNEctHe7Y6MAWPNbqtjxdNWP957Gnpu8C/ivU
   UmS9hBo3lRxizO6FsgjVuIlj2kHjRaYO1lj6SFujtDelKOEfQjdTv0Phc
   Mnk4mA0HB0pe8JAqgvUqm/ZbPe0aZpaaoaszSH1pKpo4Jq88xr2V/K9Ze
   0W8KcA5x0ckE43n/J/pzTZOCxVt+YZWQ8BkTCeK7szJ5Ug4h9LqF9qbIi
   aLq+rc2FGAeK6HOJCjAZbAqEuVY/YaQIYhmuOHNkEbrjZBsPxuCxwio3c
   Q==;
X-CSE-ConnectionGUID: O4YOJLbaT1mRaRtkcsAZHg==
X-CSE-MsgGUID: kwZOucr2TQiKKWi6u8Ih5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54719143"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="54719143"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:33:41 -0800
X-CSE-ConnectionGUID: B0Yv3gflQ56h4dRSorK/0w==
X-CSE-MsgGUID: IG9HK8C1Tnii/v9XblaIzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="105368288"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 08:33:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 08:33:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 08:33:39 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 08:33:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZcCvOoRIsbAV0Q5ighWeE05E7iu334M0Hp8hu6E2weTpRvgzNVUK35CqOZWzK3tlUeL0QQrotDwwOj53ZQW7WuEa+Cui0MxwjIDP8ORYmK73YjWk0TEUFaKJZnyPZKpWJcTLQeSjFZvM7SQphmAqri8Kzi+/o3rEZC8tns03HSCH9D9H5YDnqNNwtFvgqXDuq07jxxoJSR+Em018tkNeMmj0zl3l6Xo79qmakxJ5gfYCXUjhTLiT31piMMj4Ndmvz6S2axtb9UNBH4xH+jptw9Z/k9o3VQRpRqIqeKrvm7IG/c+ws2atawhheFihUnXIvj5DApCxd47RhG8SkIjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1x76ft37yEHKGQvmJIW0Cfmn0yKoL4WyUSHoXOSA1Q=;
 b=Hy8gWfRUq5fUJw5yxaEFSmpnpZmF3CpiuMOBqIDWruZKe/02Ibqyv6zhf24zYTGNHSGSBoGa0xGkrLoQezUjnUn15Nnc1DB+Dda3iCop7o+a8H0q4AIPIxM0GdXIuFiVs6Ru+Gzs/iwA+I9FQ0gKjzynXUdcvlLRKCCeHyNdL4HiO6R2NWOI6oLmBhNllwhf+hA39PHLj3OfZo5EVHzZeHq6g37PijWUOqeVR7w75BKudEmZDMiHSZ3qRLhA+Ce3yzlQby+ZXdzxrz/T3oolxxNNYB1m//F8NQS20dq18R88Y7zitSFdzCxmrLa+7JXYILBfP0x4VQI1dlHAM8UCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 16:33:08 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 16:33:08 +0000
Date: Tue, 14 Jan 2025 17:33:01 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: Re: [PATCH net 2/8] net/mlx5: Fix a lockdep warning as part of the
 write combining test
Message-ID: <Z4aRvfqeIGAIerDX@lzaremba-mobl.ger.corp.intel.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
 <20250113154055.1927008-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113154055.1927008-3-tariqt@nvidia.com>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MN2PR11MB4711:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cca318-0539-45f0-5694-08dd34b920b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jx9AqckUty50y6GMlCcLuiMM7Bo2SFCarCttg0IYvlHxJbnsej+COA7R8oUa?=
 =?us-ascii?Q?qdweAC2XmECd3nvzV5FiF6/TWZL374Y0/deL6tE507iwhMjdLJoz3OQjRMi8?=
 =?us-ascii?Q?CEn4gMHHZR+tzcLjun74ci44hz+qSPWeA+WaBNx5nHso2cLmUdeO8ihbXegL?=
 =?us-ascii?Q?2eaoFeVLWo3OJmB/TtQB8VK0Y4J/Y+OkcfoE2hoZKaF8JonrvZJOxHc3EXSW?=
 =?us-ascii?Q?6J6COGMWZQlbiKgdVjTl1Q7XUsSH3RnqDAQzZWw2xGZGZkx+6E17iclQnHlG?=
 =?us-ascii?Q?ZfvygPRL15mf55toP1K5hvvhhulfZA2TLPhIxhdWueMqfuaTRL/duBs6sVJ7?=
 =?us-ascii?Q?k6NqXn/o+uVX5kl8lPv9pgl17Y/z+wumP8rA4j/cxM/SRfBeNhFs4phlKHpG?=
 =?us-ascii?Q?5nfnqO68gDODfUknWdmNB9KpG3sqC561//h/hR4Co5TQQlBEIfG96xm9+35I?=
 =?us-ascii?Q?RUHTfbCdnJpnfKF9gLMOgjbs0RQsZelVhCKx3PyiPrD3/yX/shO2KyBskjB3?=
 =?us-ascii?Q?QobXB45qORjUyup/QF7YkRAa0KrN9kbHXkTHNYOhk0f74Q1iTc1itXpSxFIP?=
 =?us-ascii?Q?oiV4IDc4dvfBveI5Q5q/JquToJA1uinH33z+2zpcgM0Ja021g6l0m+cuttrJ?=
 =?us-ascii?Q?1LmolWa11huWp5XN7jv5MR31WRWvYyx22A/EbiyLrE/IhcFVKRWwkd7HNchV?=
 =?us-ascii?Q?6G9M27qzBTUN4mbfx1AdSRp4P9Tq2JYKTpaHccqBybLaEJZtyks3ZkFpTaFY?=
 =?us-ascii?Q?8/zKhAzQdLuxqPk0ZecNIr29Cgf09yBYaDGebAPFuLyAUq8MotslEYSXB1cp?=
 =?us-ascii?Q?zpQRcmxCQdnND3rWsVmajbEvS5y2TEoa8y2t/KR3fu5iZjZoIeH4IshyyuNm?=
 =?us-ascii?Q?E6CX+GWuZyfH71Imf9fNa0XOpUmMKqu6jECUVjPITs4GEZ/v0cMxlvQhpimt?=
 =?us-ascii?Q?SkWeJOTJ+EUWiCNYUEQUaao7rdud1oLb4KMrbqjurJvTGrM3s2BxA0Ke+q9J?=
 =?us-ascii?Q?XA5tiFWIOJBm+54otp6xL/RhIPUxyAeV9NYXxMCLP/w2b9Sk1vrAn1XSg5YC?=
 =?us-ascii?Q?2nzKiCsmMgsapCHdus3BKs23XMqHfg841VgRRh19DyAtuWVOlHXBEbZVIrw4?=
 =?us-ascii?Q?vg1A4SLwTSnP7t92AA+yu3t7cBkbegCuqxeln1wKjmvyv6NaVqx2jEZcSiWR?=
 =?us-ascii?Q?6upI/PyfROlgUQ/G6yHCtRPaT2JSjGeIiSfWnzGYFr9Hf6ELRSlAqoeRRXVW?=
 =?us-ascii?Q?yW/Cf5a2q3KtWqDnDuJGfNb6I4FBQA7NXZig02qbQd39HYYLfIchu6ZwgF6D?=
 =?us-ascii?Q?v4IlE5G6HuK4NeM3vijXgazqxZ6fCYybJymEgCxqlacMGmyLFcTuk33nBeM5?=
 =?us-ascii?Q?ZYUvCfKHl6KNGHus16Iu7Qa692IU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UgAc8BQ7EwZadWPN5NCw4sn/hjdFJ3JE+MKAAYqwfuLsqUGcOBzz9mRJHO35?=
 =?us-ascii?Q?D8tK8iZr0MBBVybVmPgsufDGU4zVM1AeHz9xEZ7tWkwSiKkgRXnh3D/XG5BT?=
 =?us-ascii?Q?4BJ7fbz4qrU3faJR1ueqej6Yd7NuVj4LCPZocTINnZvji0l5ze8X0y5QxAd1?=
 =?us-ascii?Q?KayUTRvMR1NqP+y/a0KZHoaijRlnZOz3vMjpOhHOs4TmoDRs1e4FHaInNdKx?=
 =?us-ascii?Q?mhTE3JWsRKzFjT9CNlpkZugPYTx0nDTeIWfoolxt2Zc4OYcgTDAvn7dZByKp?=
 =?us-ascii?Q?yAG9G9OoTpFiunUzV0ZdCEhdGr5AcdLSCw69xegejTuj2Em15tK7hQjbgcO4?=
 =?us-ascii?Q?BPFHLe0CIzBZ6AbH8sRs1xQmArOdJdrrxBYir3V+8P+bbZm7Qbi9vIcnqOGv?=
 =?us-ascii?Q?f4dzG93DLwyg2bw1fNXErjectp2UHOexboy1b1/KBsFWizz+d7WzdJKT2Slh?=
 =?us-ascii?Q?kq12c2b9YWsqnQHP35atW7X8JxZRWOkZZB+xF0MZTxzh7gpNaEioD043A9/b?=
 =?us-ascii?Q?pz2PnsmVphaZM9WxTTnkAlQItv7dT49xoRB5lqPUz5jBds85ubrxvUTob+nW?=
 =?us-ascii?Q?VAIYZvuuqyxdRhqmR5lKRm4Gg4m8Ud01+Gpn40kHiP6gzRV2FTSHDQf1Au6g?=
 =?us-ascii?Q?ePQ6g8lPgc5Xv4Jjp7/aHYgDhUr+Zg0xC26IsIofU3uEIljIquzW8YafTuDa?=
 =?us-ascii?Q?KrVzS1hfErtmZgYRuMtE6KJXj3wiFoubhDLraso84QwMzn/fuhTWIqJ+l61I?=
 =?us-ascii?Q?k8wAsoHzWc3j0TneQjlvmdxDhn8CR04/StA6GbeIE1fjtcIomAjhaEAw2amM?=
 =?us-ascii?Q?wxqg+rEMrMHxPcH45IAdmZaxMrkWvSHxtNE526mK6lvj4Z/E5E3W2+ihKzjp?=
 =?us-ascii?Q?ZvWcFmZevxc7oUlQqGl5rJbFDNoddhG8cFzEr6DxyEsv1+OcpuRBvr8Q8nNL?=
 =?us-ascii?Q?yb+/IU8F7snEb6CMY5sl3U7Y3ycopnvERInI4Gtk/Mexi4Zk6ekw5u/KoJQB?=
 =?us-ascii?Q?gIy0oGI2ADNp9tqk2j+5Ibs+LKj0SQO9Ovj2p368UjhB8rDa2A7+rjKuabnl?=
 =?us-ascii?Q?JoWVagjwUPqUQegPBLUgPTF24gZuYZw/8EMhjRWJLtxqpjVlEc6Qy5DK+6ym?=
 =?us-ascii?Q?Vq0CiSA+dQAcQqB3q1MA8STYq+isFLEu3PHiR05e45b781piffZVkm/H7QR9?=
 =?us-ascii?Q?LGNZagQM/1a3N9DFMgj0f70oI3mb7zSt4IP2qvryuGQtyscrQQ1FZr50KJaH?=
 =?us-ascii?Q?HX75XvmmQ+ycz4RQ2gCh+EboHxf7+XAtwMaLEwZ9uqo+UguzszW/wq+kq8r/?=
 =?us-ascii?Q?vpkI/qyNvYB6kAjqXod4XzdptDwfgXsr5XBcKroc74QQZcnPfwg2dYiPOuO+?=
 =?us-ascii?Q?n8TfVBhdeeAdVDPutmqKOYqQDwbucJGUkSv7LC2IFWLr3FpkmPKX3D7u6jah?=
 =?us-ascii?Q?KA9RYXDjEevAyIRUbdAw/y1JvddGI5PhUGP1ifSRzrZIgW+g980HTLZNM0H/?=
 =?us-ascii?Q?sxBeEA31rXyOguFbbSOAUSd7gtYpEx6HuhkAsUoGE9nK1p7Rolus5BGPFQQA?=
 =?us-ascii?Q?5u5xQZ1kCAnaUOQR7BGEyAlNugG81lKM9cj8p9yfwwOywbUWMtg82+Sbo28q?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cca318-0539-45f0-5694-08dd34b920b8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:33:08.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F14DnfPFcNaYFoARwztB9emPJF2B59kI/zwKaJLz7r3xlvqFImd9z57BGJbT8U1eyNUfPKpAPKNA7Riwvb/vpsobezpuhWXIaj7pq/AKuWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4711
X-OriginatorOrg: intel.com

On Mon, Jan 13, 2025 at 05:40:48PM +0200, Tariq Toukan wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Fix a lockdep warning [1] observed during the write combining test.
> 
> The warning indicates a potential nested lock scenario that could lead
> to a deadlock.
> 
> However, this is a false positive alarm because the SF lock and its
> parent lock are distinct ones.
> 
> The lockdep confusion arises because the locks belong to the same object
> class (i.e., struct mlx5_core_dev).
> 
> To resolve this, the code has been refactored to avoid taking both
> locks. Instead, only the parent lock is acquired.
> 

[...]

> 
> Fixes: d98995b4bf98 ("net/mlx5: Reimplement write combining test")
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/wc.c | 24 ++++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> index 1bed75eca97d..740b719e7072 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> @@ -382,6 +382,7 @@ static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
>  
>  bool mlx5_wc_support_get(struct mlx5_core_dev *mdev)
>  {
> +	struct mutex *wc_state_lock = &mdev->wc_state_lock;
>  	struct mlx5_core_dev *parent = NULL;
>  
>  	if (!MLX5_CAP_GEN(mdev, bf)) {
> @@ -400,32 +401,31 @@ bool mlx5_wc_support_get(struct mlx5_core_dev *mdev)
>  		 */
>  		goto out;
>  
> -	mutex_lock(&mdev->wc_state_lock);
> -
> -	if (mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED)
> -		goto unlock;
> -
>  #ifdef CONFIG_MLX5_SF
> -	if (mlx5_core_is_sf(mdev))
> +	if (mlx5_core_is_sf(mdev)) {
>  		parent = mdev->priv.parent_mdev;
> +		wc_state_lock = &parent->wc_state_lock;
> +	}
>  #endif
>  
> -	if (parent) {
> -		mutex_lock(&parent->wc_state_lock);
> +	mutex_lock(wc_state_lock);
>  
> +	if (mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED)
> +		goto unlock;
> +
> +	if (parent) {
>  		mlx5_core_test_wc(parent);
>  
>  		mlx5_core_dbg(mdev, "parent set wc_state=%d\n",
>  			      parent->wc_state);
>  		mdev->wc_state = parent->wc_state;
>  
> -		mutex_unlock(&parent->wc_state_lock);
> +	} else {
> +		mlx5_core_test_wc(mdev);
>  	}
>  
> -	mlx5_core_test_wc(mdev);
> -
>  unlock:
> -	mutex_unlock(&mdev->wc_state_lock);
> +	mutex_unlock(wc_state_lock);
>  out:
>  	mlx5_core_dbg(mdev, "wc_state=%d\n", mdev->wc_state);
>  
> -- 
> 2.45.0
> 
> 

