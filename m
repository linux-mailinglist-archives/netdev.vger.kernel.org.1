Return-Path: <netdev+bounces-131652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8806498F255
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D546BB218BA
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E280B8286A;
	Thu,  3 Oct 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YlZZybsn"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013013.outbound.protection.outlook.com [52.101.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10345DDA8
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968714; cv=fail; b=JOQyBOXRV68gQS5DCGR5Ml4gnWoQU+WJkjX59SCkHR60sXClkmgeA1/xgNEXUBkA7bOgDaf1yZgyZ2scDHyVfonMDz8DhmT3p6f9h0mWM/1jz/k7AbC6xdSxTtxfE/IZDTsOCm5sOifFbtd+dB0dlnHkBQ7A9jPXijYocdw2K6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968714; c=relaxed/simple;
	bh=eumnyI+zWFEmiFarEJBf6pd5eQiQeVb/MPc9NfdNkBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BS3ngpSSyfik7B7UtgPJaGvwA22NtZYcXKdIVELJN7wpzXwXRSSa/9m3S3seUqfyI3N7pPrfZxtVN/0KaOA1jhMU5kNSOdpeOqoGmLqorRb4Prc6f+9av+rNySNJTm53u01Tiw0/w58aqxut+taXyRCqfb9ttplgN1PagmwO0/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YlZZybsn; arc=fail smtp.client-ip=52.101.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4KC8nVycv/DihhnG4Lz2JBK83j6921+cpB8EYDvCXCw1SDnr1ZOu2huUpR6++u1uYjpouJXkhmwR0wqi1JtDyuVF8F5mYqYWwMpTQ4gkwNXdDSpj0Ym71S9V0NgYN8F1bN/CrSqEHRCD3YROg+OSqBGfRL9LjEQZJxucnt/tk0GqiOGROZdThNwWpDoDTRVPbOWXtui8hMbv5RSJ1vHbLkmqNJAWxNcaRxvrWbJksQKIJGbYJ1877n5eSY7Ea83SGgV6DF4vCWXw03bC94rsXD8TsAV4M9sGckxSXXiVp0rxHt39xKevuWqd0X6Yy18UCPo4OA1+VOPzemJY8fYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iooxT5Z2c84wMkN+9lr/iK+Rn1VzT0Mu21Yv9wBhOBQ=;
 b=RqEpznBRa//RRvqrthubNsbaXhn1u9qGi6zIjbbZ9n5e/MJidKj9GCelhsscLaFcLsO85BBWntNODA8vHYDusNlwp5d5IkPUgDHvenzeAJH7vbYGyZXl8n6KPQDHvNhIk3Jpb74uJ+8fFFEMncAjn3DbU3gkbNWysxR2VFAvb5gQsZyylUjmu7eVB2xJHJLXg9pg8lnq7IefilC3ADjn0pLPlvMli6e8SCYXieSku4iJx0l1XJT7efzqFGAo3WABWu+1PfUrfdA6/lY+QeKvWRdLl8pykZvIXsXSDWJxAGj7aQqOhdaVegCgof1s1qDydR7eoF2I6n9ttoe/SK0BGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iooxT5Z2c84wMkN+9lr/iK+Rn1VzT0Mu21Yv9wBhOBQ=;
 b=YlZZybsnVvXny9aubkcyPCLWoNYzts1ND2A03at4/tcXY0CUqP4yQfZRr99x2w9VVHJDFwr5zZMMaRa0rJFrvhorWq7ME9O30cZ9PUpcCLSfQ0XivD94QywhoZHaYY4+RzOzgwNl9SIESctApGFsj2JNSIz+cBIBIqVVKGj/sRca1jfWcb7rs4xU+y//hjH7NFRS3lv70hpE+BJnjO/Sip7hPo1+cGEPSSR8pAijTT3neYbpF3WisWVsiW4MQS6Vj1+oTooJiThipMXhqA9d4DMicXYVjRSd5QwtwKM/1sBYqIyXHCi6R1XF9hrOZMFLuj56Z5bF/5kgQrV4S81psw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10611.eurprd04.prod.outlook.com (2603:10a6:150:21c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:18:29 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 15:18:29 +0000
Date: Thu, 3 Oct 2024 18:18:23 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 06/10] lib: packing: add KUnit tests adapted
 from selftests
Message-ID: <20241003151823.rk3juxv4udnqay6j@skbuf>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-6-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-6-8373e551eae3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-6-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-6-8373e551eae3@intel.com>
X-ClientProxiedBy: VE1PR08CA0027.eurprd08.prod.outlook.com
 (2603:10a6:803:104::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10611:EE_
X-MS-Office365-Filtering-Correlation-Id: 2526d716-c99c-4c49-ced7-08dce3bea083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7xTzlu4bjhy1MytYXh5NeeHxF7n7aRkQhhiyjRUFYshQEMZdzXfM4Jtzgc6V?=
 =?us-ascii?Q?a1JU5wAwVdWqiIlB+zcG/s4g6RV6Ofb5LsxRV+biiYEF0D0NSDZNYRf3hGFH?=
 =?us-ascii?Q?f7vqvaV3jpn/Q9PFtF/nf5Vwbt7UD/vqfxxN2qTVU2uxGDBMiipiBhgRZHg1?=
 =?us-ascii?Q?GeYBHidVlaei98makKs3RxHPGjUb57oo6GS6vO3WK42ADjmhQYtN19c00Vux?=
 =?us-ascii?Q?sIGKegZZhPZVK+89vql3ASC6+BcREt1X22SD4a9nst3rKsQ8bLR6VfANAcFz?=
 =?us-ascii?Q?TJhKM8s5wgbO5T+LbcibCpveQAz0ncgSyhqPC/YIRI3B4ROa7Lf5i178DeQW?=
 =?us-ascii?Q?1RhoBzhs8CWeVtq2cGuIka2pFbU8rjwM9mQz/Td/BXfRHG490dvTIiVWwvg6?=
 =?us-ascii?Q?0ZvKar77ra8byhMGP+WmagFmHNSZGEH1kuSRno3YZtNGoCIaYOxbquUN9U4j?=
 =?us-ascii?Q?m6FAW9XrvfwBT0qrue5XUkIKWst01Y0Frre7vQP5oi6e8OmqPvWk6YAqMLjf?=
 =?us-ascii?Q?41+veYGpB8s0/2zHvXLN0OeOAK6iXh6qryLdiPgl1nr6vxcC8EtpPbydERdV?=
 =?us-ascii?Q?+CFNykn3Ofps7Uy7zQrArgfs+RfBYlnQ5Qz3xH+D5d9w3UFThn2qAWK8UpMa?=
 =?us-ascii?Q?1DPAwF9wO+fDNGpaPwrZFmiuQs2WCWvvcc7jIeVgMoDknpgm+tly0Kvny7+8?=
 =?us-ascii?Q?pQLfwlewSe17Lns3MgMTSWqplT+XLc0x0AORul+hgoLl7KL3Bs4zJbuMVX3l?=
 =?us-ascii?Q?VyL8EfZ8coMcyrVRiAWctXEig1+m5Qe/AdtWivPyp8YI/eJsL8yVdYrCNRU/?=
 =?us-ascii?Q?PeNn6FFoAcQqvC5O9uXMs8s8xo8+WzBXgnxRiC2I7fPvjrC8l/yCR6PHMJoi?=
 =?us-ascii?Q?YkIX2B+JCpY5mzAvEg1Rj39QqmJ6HVtlgqA13ttXL8jVnQF6ftmkvb/nqezm?=
 =?us-ascii?Q?U8WseRthpGeMHERh9lGV9NCZbWtYZfpiMxvG9nu8v2gi8oRXnOFhbzuKT60y?=
 =?us-ascii?Q?+pqaq0CqOUSTlcRRvwIYGIJrds/rCdy2ChYQbbfSH4HAq5GC+eKgU7CB+7dO?=
 =?us-ascii?Q?0VC6vr+8lTrI8C+35XqSc9fQG/Y3ZYiHZBecHzoZmM9blqqQd60sADoYfj/5?=
 =?us-ascii?Q?0kuYeklMipMcSUZ2stNfvIiGaj+YAn7d/J3KWTfHqr+iCH9UkBcccZ92nths?=
 =?us-ascii?Q?p+joR82ehHM6bqfBJ4t5Wsf8MIrJetZP0j6Lkxqt98atZ+3EnPB/8TyXuzwY?=
 =?us-ascii?Q?GpxMSqdaJQaKj7Weri3b8q8vIpCI79v6xSfxNJY9jw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NNlI1fG7Y9IhCIxAYu2Je3rph0p7CdiYeaOk/Ebgs140oVDxMzVgtkHx7Xae?=
 =?us-ascii?Q?dPHN/LYaauMmSsAFKLbG4EUZ3l5Lj+K4cEUQqYq7+JkIXsrzYqdQD/fuBJPd?=
 =?us-ascii?Q?KWl9yBkbbgQbRlegeTxMhGBBQmyTEFRoiBOtLQLeJfg1HyoEJG3bpnfkDsAh?=
 =?us-ascii?Q?b2szqdaxCJnkNyl7nleCQOw+8NEXeG7NsMAp30xc0Cla2PBx0pMI0CXMBeGO?=
 =?us-ascii?Q?PkrLqArxkXJNbsmQ7Yl69h/cEA4CXF9DVahz+5Gh9rNU0puquRogpGMmyD+b?=
 =?us-ascii?Q?pRiOGPaApbCqOu6j2R7dlcWzNqUZttSouJF+hrMlId/eM5l740ahhrMxyVjD?=
 =?us-ascii?Q?dCWAV8/S6xg7NEykAl6uBhKtJiZWdILjL7oq2iOljwkx07Sk21QWYNM+hQV3?=
 =?us-ascii?Q?aWcICPJFIqVpzBzSZZnAhtnz+luugj0BLUsX2tX6c8pJ7g+0qU2qCUwZsCmM?=
 =?us-ascii?Q?OVkMfMWLUsshssy/1iRksMJ5hbljU6aYCX0VJYIrOtdmDOi96AktuieW10CK?=
 =?us-ascii?Q?S5HhZrP7GCG6AlDh4sliyf//wgkmpWfAlhWL1EWheSQp+YHsFBWoXIEpbW18?=
 =?us-ascii?Q?La9uCPlD75eeKFHhVHZ8Ad6eKhBS6Ifl4vSfGWwqM3E+udsfrOwqblC97M//?=
 =?us-ascii?Q?5uhQ0G2LBGSSpQBA8hv/3W53zwTVQm0qyyB4SNzOvMqDziXEjHe4m8YHRElL?=
 =?us-ascii?Q?XL2UAQNwq1WXxmLEYFhRrYwJO9A0OFs221L9T+oi6i/fzlnUuyGTt4nbRhhC?=
 =?us-ascii?Q?QSIUAejMUlhCXxwslOSKGLvo3H3ET2xJFElIix2QbYPI5b2sj8hEc6eg6IHI?=
 =?us-ascii?Q?XdKFRuMRIkeW3s3MrCzmLYLuP71VpysBQJLiPAyo0/EN66kXRQ2Dwwp6Qt4X?=
 =?us-ascii?Q?D+9isWqgctW7gh2fehIBWpwfSlaiiRjToSWX3mfvt9qn/+GdqApJL5sNkLPy?=
 =?us-ascii?Q?LGBiq/MsuCndCQE7AUw/MV4QziYiM2LvTil0WUFpHMNIYHotG77hpdePSNTl?=
 =?us-ascii?Q?RO6r+a+qiWpB+csoDyslZuZLeEA0vIbbN55VgMKrkvQA8WDLM6b21eV+c6PN?=
 =?us-ascii?Q?T/q7/2sgacMQ0ssAzqQZ0m4z2fHh+CpzIowNcbnDZwQk3bWmjLwc2C4UT5Qg?=
 =?us-ascii?Q?R03Lm7tjLkiHIWHS6Mv/QM4+uKGL2j8PKZrzQNkQ36SITM8k3kxlr6SGCnW5?=
 =?us-ascii?Q?7IzieH8ctyP9Rl5i3zKee06xYqxnl8Ily+D2ooYhkAU61FaMg6fajzpxhP/0?=
 =?us-ascii?Q?AKasjoShxQnzXov4Nhm7TNlKZCLAesVcALqyyhpRRxHVeJRENnwaTPysC9Vb?=
 =?us-ascii?Q?iH/aeKBMyHIOZk6P0PP4KdiRpq5RWOjXujCQSoR6Rw8RHk8xFols87bNPjw3?=
 =?us-ascii?Q?d4zXn33ChoMQm+feCoYKpl1bN8Bz3qwa3WJtoLBDr23SzC181oBEHFlgmYnx?=
 =?us-ascii?Q?X3WTIq2KazYLyMudG0J+CXfJbcyBVHHX4RcIBubcoQ2OQBv5wOiksJq73d/A?=
 =?us-ascii?Q?6ancqBWNppwY8cNsZYajT1v4TNtK3FCyW3HOE8ht8t2PyRsbsz1g6p4/MEEF?=
 =?us-ascii?Q?+XzZ6QOaMotF+VXiMeCK4H4URudWpc5t3/UhuGoxeI077+W4HN0Qk69/t8uK?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2526d716-c99c-4c49-ced7-08dce3bea083
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:18:29.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9D93iY851WzkwaAVH2NKUaSWLOQxFWTAXBsYQefgOffM+TEIHbtXbi31DrXpPA/fYKWpreS6fbZRS9vA446WKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10611

On Wed, Oct 02, 2024 at 02:51:55PM -0700, Jacob Keller wrote:
> Add 24 simple KUnit tests for the lib/packing.c pack() and unpack() APIs.
> 
> The first 16 tests exercise all combinations of quirks with a simple magic
> number value on a 16-byte buffer. The remaining 8 tests cover
> non-multiple-of-4 buffer sizes.
> 
> These tests were originally written by Vladimir as simple selftest
> functions. I adapted them to KUnit, refactoring them into a table driven
> approach. This will aid in adding additional tests in the future.
> 
> Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

