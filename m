Return-Path: <netdev+bounces-124069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49B2967D80
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 03:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B1C281798
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 01:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48218C3E;
	Mon,  2 Sep 2024 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCeQxjAG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8BD14F6C
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725241783; cv=fail; b=nVfEbW6r9Umyh6BIvgHzQHpAh2PEJcNSTOqdsG1jA1KkDdSqzxpoA2bsufNbMxdZKaoSNBXX/bBu3QvcJW2MHWXaGN4hUWhRF/FwexSIPS23YXGPIb8tuYd4DOeFgECg4M0/puRSMdQwySnhQh9shEDfgU+tsA1xlfS6SMwKCes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725241783; c=relaxed/simple;
	bh=hoD9Ki50eVGN+tdCqIIcoe82etdoXs5DDKVXecYlqgg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=atg/A+/I05ur8w0dgulSoB4zKpV6QXiE2QeKhK14ryyd2LEogUOksTeRm72BONSGre5My7FRwGIOss6c09BjCX9blhvRTpmFV7Po4wZGSlWGMLCqNSjcsPiD4ZKkmnNtBwGeNT+a+9sSxHezWKVvK/N6eG4X60xJM3P++m+wRgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCeQxjAG; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725241781; x=1756777781;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=hoD9Ki50eVGN+tdCqIIcoe82etdoXs5DDKVXecYlqgg=;
  b=mCeQxjAGGDZ0XH3iibJSE0GDiT+co6wxzp3d23ntD4JGR0PB5jODleVZ
   0kDNS5qoyTHyz8wKGQQtT8/jVeWPy4zJbYaLB59ctex4QiApBUrLuI09W
   jGxSNO4p+rO84X7+XelhPTHJLt636pKhAtmi8pYsh6BhYzWxDiKDkLPFF
   QXOYN1lPmdtp4SNxhRNQ/q8TXb+Jr9BTtpo0tWr+08N41FJZp/51PW/1e
   NtB0CC9cox7mzG3Hsb8ngBXsWzfmrwlglwOzjj2mvUVWRII1mYQCdsU4n
   9dpif7RnYuPYvn4XankMwD7UZDdlFuSVoi6vcJTL4SM099yTLfs9NqDE3
   w==;
X-CSE-ConnectionGUID: 59WEZbiWSTmvgykoaOoKeA==
X-CSE-MsgGUID: sPEoVgJ4RNilGgDGHP/SXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="49204248"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="49204248"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 18:49:40 -0700
X-CSE-ConnectionGUID: VPWEfAV3Ram7SlbND5CbOQ==
X-CSE-MsgGUID: 3giKN1IWQcOabWeALHy8TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="64273792"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2024 18:49:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 18:49:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 1 Sep 2024 18:49:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 1 Sep 2024 18:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC4BOtYOKShAyo656Mj4D5VOPy4IuRys+V6E6cnMSGX3xlsEBq9RM44iUEbYVaY3Hv2hu4s+/Dk94LuN4Dt/O+p2Lxxn2eF1it22jvr6Uh+ipiX9NvFPQl0LR/J27YumRfFfH6Vq/c4lPOq8/usfhjT6F6uAuifIE4NscvgZxTK34AsgxmDLG6ckZ4+XDwChUYvLt3qpurY9BtZ02YuHQMgTjMr7oVh0yPgkoOJcRsaaU9KOi8y4uElWg6qs59rhnTC5cDIPc2+k0ye7usTpIoRKJ3niOPRAEsnw8WRknMn9dV1i2LZKAhWLd863EhNNsvIkGQtC+/R1903OF/X+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RidLhAV37EMompXUXLPK69JADWbw0cfL35qCmgsh624=;
 b=Wt8t/UwmhDUItLxiyhX1yNNLsJijRJrMyLGO3cwlyao8bv3y12uSktUl1Cnk+x0edNR1lcEdUAjQs6xIkMswrDqPzveChW4OpaHrgLkIFg9kleKnfrn66pfBQXtXXOqqDeLvY7iiTIa7sENR7xs+Hu3JhxDqW+uEHtM1rYvNyod/MNZNyWXVXFAKdbmjI1bDbPcpnoeGQTFW3DwaCIuT9JOAL/26/UIotBY13ME2fF4pT1VD4ZBms52rzlLYZRvS2TRR8ddMaeY2y+Ed+bp88+HzgSyuDowNldU/QjxhHC8c0u/UqAF3GRwINmnvENXFlo8bijNfytvN5EiejEgQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 01:49:34 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 01:49:34 +0000
Date: Mon, 2 Sep 2024 09:49:24 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<dsahern@kernel.org>, <willemb@google.com>
CC: <oe-kbuild-all@lists.linux.dev>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 2/2] rxtimestamp.c: add the test for
 SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
Message-ID: <ZtUZpPISIpChbcRq@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830153751.86895-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|PH7PR11MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: a7994caa-8c78-4fae-33cd-08dccaf17e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DX+7lu523elIxqB+rJ5IaDx6vxrhWc8LoTKoT6lSaY2yusgZWLSRKNlk8QbY?=
 =?us-ascii?Q?0911RmbBxTO3SU8Srt4gf4RrgWfF5ot+2TtqkIK8dz5jt9GMsXMSy1ostXlO?=
 =?us-ascii?Q?TJpgDcuXSWJAV7+iZbZkJrDgao46oHQU4ftvJ4V8pwRFHp4GKsFcietcje0G?=
 =?us-ascii?Q?/dURTTWlXTqZ7mE4oltGb/AWHn+tlI146R3sVQ2IeKGwrV8brFsE0UUWBkzJ?=
 =?us-ascii?Q?XV6qZ5yb60qCReHyu065NZ1/I3s3A4CIt9y6DaHGCMY1yF8F5bFVMfaQJT7Q?=
 =?us-ascii?Q?5HWSQPqYqrQXsXfDc4FZIWbPX198EvzQfM70sdn8ch9MO1O3/ghjvAVKdV8L?=
 =?us-ascii?Q?3LRLPvcL4O0Xa9AZ4yc3NPF2RzMY1XAW/njWYsvmVJpLotrueeIrvpqjMKr2?=
 =?us-ascii?Q?tvqq1xBpOYFM18QBpslPsHoFoXAILMXLg6I9ll14hzuuI+CgMFgSzi6KAl+y?=
 =?us-ascii?Q?UCQLR5frCC+8hieeaDRkQreEztWcvKbA96sYwR8CHwzNNMVBLMxBuP4E6som?=
 =?us-ascii?Q?wvmUE6Xl3k61wMBaXxWueAsiCcPlGszkH37P3Xt6IER/8N6RXZ7dR/DjLPWG?=
 =?us-ascii?Q?CMgWyBVIndiEvG8d0KPsDQu4fx2GLfzIomFEu4rEglHlbSesz2nyJuJwkvMr?=
 =?us-ascii?Q?NgzvncDgldudSohS5U3U+rBuez4TUEukXtsjUpw8zjmp5LsaD31YXqe3zzBA?=
 =?us-ascii?Q?rCiPCpPqXOwxYwbdwT+m78+qiSecs8XtD9jRIaBxF57VQ1M1gXzRpUrTLaXF?=
 =?us-ascii?Q?2eEdCO1aquO9bitQZ++l6LduKgu+9qiRGWuOBwyHWsonGm/mMPC6JZ+xVCSY?=
 =?us-ascii?Q?1XsdqSBqKDnrJg5dn4txh7Ng8B5rYZoV6Ab9LMUpzPKGs0C1fUrn3ZPqz/f5?=
 =?us-ascii?Q?T9WMubYxRnp3CzhbLMlOTDSCQrC6U8Mm4NqTMisJOAzNwLqEMA7fafxLOY2W?=
 =?us-ascii?Q?MtxLtZ3D1pqJPX2Omq4dzHm3gTe3k2VagNwJt3kF9LhfvMrFI2VCKuS9PiH+?=
 =?us-ascii?Q?fnHTGHimwUpA2k9XJiesuoYCA7HuUe8owZJC8/WJ/73uStJdPKg9CPHujdVY?=
 =?us-ascii?Q?JJeztQniZ107NmS2VJ7sTbTnOLqXyOfwyJ65IHKIF62GNiwx9ZMUykRPXCCc?=
 =?us-ascii?Q?ohkbbWG+hcO2Omy4L9zn6ww19e8CfV1gl+tgbVlVOMH2FZEAtrbhXaThYB03?=
 =?us-ascii?Q?s7ykH4PTwOij5UYsNrYIgKPAuJuhEiGo03GJY2q6GApDTczNCKOMTKkb7/eX?=
 =?us-ascii?Q?ewA2N+7IdiRwM8oSlufjcM32IRHPbVD+wYALvn/LTh8pFsW1ZAAK83L8mHwt?=
 =?us-ascii?Q?u9ORu/3ew8dXtDsgQSBbJaPP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MrqLHITK/JATywrM70Lk8DuargJb18GTiXAHU4QZOdUzZAA9dlCmfnS1Adca?=
 =?us-ascii?Q?RwC3d78up+QvIWh7QddpijDBh8YG84QKky+JdYmIegJPNf4mFaJVXTLLaZEW?=
 =?us-ascii?Q?aQbOyMD3rr0R1EzktcyrCk0wnhBu8APiHWH+mnZbfqvcuDsCseSPKyqIxuJg?=
 =?us-ascii?Q?JqxpNh7YtdPYL2XWcgAKeM9iDGBXYP9f+f1HmNWAmNwBjGDQA5QQkU5mtpaK?=
 =?us-ascii?Q?PGqNTG1t3ylb6hqASP2q8IzFAVIEtklqvWF3c5TlqH+Qz75h/SDEW0TSL4lV?=
 =?us-ascii?Q?6kP4HWNKLguM2e30YQte2CZy4mqXvL7RodINj1d30RU9/j/BOpiwIcoacDUK?=
 =?us-ascii?Q?+IgTn3MsDaL/CPRpdKiy+CMsFCwMuaX3Dblmg6SpyX7MZGLDCh13q7GBrrQY?=
 =?us-ascii?Q?ILCHsghkpjsT9cGe1cu+BvLIila+UnL6H8YGOZXCPuW6TLlSMBogrXW0VUkW?=
 =?us-ascii?Q?FEfzd8vyYbgx71IpBNVlYnvnK8AksYiZxWrD24vXBl1ttOqFnQbXa+O+MJ31?=
 =?us-ascii?Q?iBvkyIlTF1p8wWLFwfziOX6Iu6GqRVX94IXuwA9qRXPZg8P9LUksvvgbx4O/?=
 =?us-ascii?Q?g/oVL9e1lIzRWu49j05xWOjADyHBc/EwStj97clm6j7rRx+gqD4zj4cMF4N3?=
 =?us-ascii?Q?XZ5YW4KnsNBElW5+BUnhOCVsY6wOmL+QYLJkNRthDa7n3dMP+9rGKlCrnAfm?=
 =?us-ascii?Q?4MJkOdjCoWqdfP2Vrfh6YhNOSm8vdl7D+eSkAbUMn5p7BnxCSZhRb6ZQDa8i?=
 =?us-ascii?Q?JXxMZKboh/wKiAVDfCRWASCc3H6y9bpUevINaRRyYMLET1wNsdx/zh5HWoNE?=
 =?us-ascii?Q?bWI7r7el829GMjT+Eucepv1ScpmAYWttDW75vGDXOg18QArgepB5QB4d+uLP?=
 =?us-ascii?Q?SV1+VKwQ0jKbjPSt3JH4B8T6//iTqfurzCENPPcnQ1ZtD5MI58SPEUPpDqMc?=
 =?us-ascii?Q?xh08kQSdrnhRmxKyNqWECZJlYVEqetojVpjU1hNqTWpni1ZIH/wVRwOoyoV6?=
 =?us-ascii?Q?L+kyugnICx1tUhxNmOoOge6ZdSmJPTlAexmi61wuMuDjOF8NuT9jnsmmsei6?=
 =?us-ascii?Q?9rwvelIGUYaSERrxXeub3qey8/1xY6N8cWtcdxDUdQH/g95mWciSIlUTk1ZD?=
 =?us-ascii?Q?JNcyjY1h198FJwtLjUD8eqKnVlpJWc0UR6H/UM2bTLmo3mfNjc/EsnlsNqpP?=
 =?us-ascii?Q?SMFqezcLvBe3xNAWuqRisCMipH7uoPK7ssczgQPEIrbYfmidTHBj30mZvjzx?=
 =?us-ascii?Q?FEhtwNa4CcFXMrIbIyVmmweKzte5pRPr3pqkCp9AtV3wC5GWKM+QYYpVHSRQ?=
 =?us-ascii?Q?s1Q3wfc1YmgwL/e0jZxub93hmhZp9md2bM1NoMJ6fIq4IeQ/33Xd3aV5NC7/?=
 =?us-ascii?Q?PZZZh/RPxpXQ1WZt6COY4FibjDxwTaQatmhe1+5h8een8mCE883ajJYoDRB5?=
 =?us-ascii?Q?wax6hP2Jhw6KIOWrRX5jVl+hrXGHxdOFR1IhA96bsjkIcaR4XkOpftFdVbDu?=
 =?us-ascii?Q?Ryg10Q0zoRZTY2yTJ4QLNYO2PM30ax9hv/wHdKOUY2kMSQK2zf/4qBhkwEVl?=
 =?us-ascii?Q?1K3lOInmQnOWg1hMT34ZnKvL12ZYXQwa3FEgTTOr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7994caa-8c78-4fae-33cd-08dccaf17e96
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 01:49:34.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2plCPujGdcZumnkiUWlWlPN+onRETFJEnN3UzjNV6XhUw2nhfZazlEIUi3xydTlHtL3SvlQC80qf0gJ5xzSGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-timestamp-filter-out-report-when-setting-SOF_TIMESTAMPING_SOFTWARE/20240830-234014
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240830153751.86895-3-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next v3 2/2] rxtimestamp.c: add the test for SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240902/202409020124.YybQQDrP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202409020124.YybQQDrP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> rxtimestamp.c:102:6: error: use of undeclared identifier 'SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER'
     102 |                         | SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER },
         |                           ^
>> rxtimestamp.c:373:20: error: invalid application of 'sizeof' to an incomplete type 'struct test_case[]'
     373 |                         for (t = 0; t < ARRAY_SIZE(test_cases); t++) {
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
      61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
         |                                ^~~~~
   rxtimestamp.c:380:13: error: invalid application of 'sizeof' to an incomplete type 'struct test_case[]'
     380 |                         if (t >= ARRAY_SIZE(test_cases))
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
      61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
         |                                ^~~~~
   rxtimestamp.c:419:19: error: invalid application of 'sizeof' to an incomplete type 'struct test_case[]'
     419 |                 for (t = 0; t < ARRAY_SIZE(test_cases); t++) {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
      61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
         |                                ^~~~~
   4 errors generated.


vim +/SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER +102 tools/testing/selftests/net/rxtimestamp.c

16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   67  
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   68  static struct test_case test_cases[] = {
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   69  	{ {}, {} },
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   70  	{
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   71  		{ .so_timestamp = 1 },
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   72  		{ .tstamp = true }
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   73  	},
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   74  	{
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   75  		{ .so_timestampns = 1 },
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   76  		{ .tstampns = true }
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   77  	},
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   78  	{
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   79  		{ .so_timestamp = 1, .so_timestampns = 1 },
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   80  		{ .tstampns = true }
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   81  	},
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   82  	{
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   83  		{ .so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE },
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   84  		{}
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   85  	},
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   86  	{
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   87  		/* Loopback device does not support hw timestamps. */
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   88  		{ .so_timestamping = SOF_TIMESTAMPING_RX_HARDWARE },
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   89  		{}
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   90  	},
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   91  	{
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   92  		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE },
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   93  		.warn_on_fail = true
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   94  	},
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   95  	{
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04   96  		{ .so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   97  			| SOF_TIMESTAMPING_RX_HARDWARE },
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   98  		{}
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22   99  	},
93e82194e6a4ec9 tools/testing/selftests/net/rxtimestamp.c                     Jason Xing   2024-08-30  100  	{
93e82194e6a4ec9 tools/testing/selftests/net/rxtimestamp.c                     Jason Xing   2024-08-30  101  		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
93e82194e6a4ec9 tools/testing/selftests/net/rxtimestamp.c                     Jason Xing   2024-08-30 @102  			| SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER },
93e82194e6a4ec9 tools/testing/selftests/net/rxtimestamp.c                     Jason Xing   2024-08-30  103  		{}
93e82194e6a4ec9 tools/testing/selftests/net/rxtimestamp.c                     Jason Xing   2024-08-30  104  	},
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22  105  	{
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04  106  		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22  107  			| SOF_TIMESTAMPING_RX_SOFTWARE },
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04  108  		{ .swtstamp = true }
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22  109  	},
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22  110  	{
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04  111  		{ .so_timestamp = 1, .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22  112  			| SOF_TIMESTAMPING_RX_SOFTWARE },
f551e2fdaf81b7b tools/testing/selftests/net/rxtimestamp.c                     Tanner Love  2020-07-04  113  		{ .tstamp = true, .swtstamp = true }
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22  114  	},
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22  115  };
16e781224198be0 tools/testing/selftests/networking/timestamping/rxtimestamp.c Mike Maloney 2017-08-22  116  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


