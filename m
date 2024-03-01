Return-Path: <netdev+bounces-76556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81AD86E377
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 15:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697F82856BD
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCD13A8EF;
	Fri,  1 Mar 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6VawqxS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439A39AFF
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303933; cv=fail; b=Xgtn/851L+OIOPOvsSFW8tdRTTvi5O7ttfOqNDZwHTQqrLE1tFxDR9SMkm+9qgs0CybH+hozrmGU4vXamr4gWp+d+Ptg5Y+A2h1xBSO86rc6EcYGiOe7V8AW017DuK0kqrxdvyWwq2Ku1wI8sITxCP1mflnAO5V6R/YXB4MKg9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303933; c=relaxed/simple;
	bh=hKiLbsKatJBtye1zQ9CLVOkzTM2IkpooqamZd4n4C60=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mBAxeQJ+FbghLg898IZmAT5oCgRYptENncsXsjW31XVMdLIm2Wg37g92f0Z4ESJpTamgO2u8fFv1Sd0piDBJgBgRg/X9PMiFPpuiNERYDfPz5uamlr9RnhaxwKN0yAjMJqdsrlSBskE7D+cBEhcFCVjFYx83EzGj08bet+HJqSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6VawqxS; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709303932; x=1740839932;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hKiLbsKatJBtye1zQ9CLVOkzTM2IkpooqamZd4n4C60=;
  b=E6VawqxSLIWqX8EXalfLAN4M/hx5xgwSehIfh5zcEM1KMfBm6JbvV4Sj
   x+3Ep2DCtcLG3KSRap118sV98QkQFVUjSNg7yzxKJqojWKT9km42fmt+u
   ryvOmvIFiD3p7naE9f9JnYTwIG7Ijn8idk9DjWHsoU0j0eoLLn6Jyfnwn
   ZhdlT6pht/EhdFIN3vTVfAX0k6JyGBbszcXsfmUeg8W4iyUr8IRQkbT67
   +/kkFyfioALis/iKF/X+pJQhe03wx5qF+QUXY/vSTtU36Vl6GEyTjY5gn
   WSCWkcEreZPjOvFbzuzu7whISa5Y/zo444Dkt2zWLUkZZuGirWpoDtz3S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="21298515"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="21298515"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 06:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="45753723"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 06:38:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 06:38:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 06:38:50 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 06:38:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAeY0DzAgINsU1UX4YFXLiw73zODGZlEL7Mz3/VzvfkDKLzI7pHjIToTFxgHSdksSdLWurwnnYvNyx+ft424yvlqtlkw2Meu0utmnOL0uq3tIGqOSobny7cmz3+xqfjTRIPGrtWVzpVbh8aYZi11W5jmeUI9vfklgSKLoiFNP4WRvJbmWPQDjO0L33fx6eey+7M7YWJ758s0FpcB8h7TnF9yBgjRuzsyD4NV5/kWWlziIf/R60xoxAmg+Gk/1mQ72LCESJ9w8g2799LONLjOJ2pWcvta4ujketOnxkdIOywRMggERuy6/lmgvMlQe2CiEDSoWnLmBPM4SZbMsPb/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkJU6k9iwm2ZQXb9V1v39a5Gds9pwbywfZhuIaBu9jw=;
 b=hnwcfZvV1MwAFdZlqdzT+cl0qa5Kso3uyiZbii6CloWK9G5Bn/OW7X0pgDf1rC92Im45dsUcEBUy5Y4zuFJyeqayTXqUSQ3WR/AqsJDf8EWEoj0GDr6O0lA5Y4YZRNzXdftiHVk++jrIvPaBY0EqlFRFgGg+fxnyn456tbbaxivjwqcEM2ZZ2vLQ9+jHn6Fzk/D+BL1sceXoZY3vpy+kxIr/LVxAJHSmWlWA4hCF6wl7RVkZZEpvNU8Xq85mkqkYmFn/xUYUKbaGWHzK9TZuqktlNu+8K+3xyXs7CKstJ915t51uKElmdMnfAFcvQ6kzd1U46doZ4oMORPSbNW+KkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.25; Fri, 1 Mar 2024 14:38:44 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 14:38:43 +0000
Date: Fri, 1 Mar 2024 15:38:39 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Michal Schmidt <mschmidt@redhat.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Milena Olech <milena.olech@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net] ice: fix uninitialized dplls mutex usage
Message-ID: <ZeHobzkU6PkRo68N@boxer>
References: <20240301133708.214622-1-mschmidt@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240301133708.214622-1-mschmidt@redhat.com>
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS7PR11MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b42ea7-2948-48d4-0bb8-08dc39fd4b91
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLRAsbN9Vjn7VEA7vP1s0DLIgDmizgwmT5v7Ml9ZX1T0E9n39bFVKUsfSeLXEAwe83fX4Bk/+gzJdnBuK8BQwtWdiZcmE9wHOzmop/mTt2/sNTUZ7wT8UIiFqFIgeFxH3UJLQZ0ZK9OlYdtTsQ8XiaTVLhQEsmD3p1P8X4nyynstNdBJGpZnKOS+U80K1wIDKujpIG/bcD0oufWNI6yb1pvtYycLyk0tzXLhp1ZzpHr011T7Dtz/27G189bpitw+vBd1emqi8BNc1B8ZECHq3kdfGY4csJD+BILME7czo0FzL631v2Q/QTAF14UtpTzmT1J8GnLYw+y33qjm1OlWTXTQVOsDpg83q/+/ISChPxprwDmNtmeGIZK0bWEYEpoiFu/vXSA2gKBIaVOTtmELN0Bc/YyFIgdZ406iLdC96akNbRewh2A6ne/jRm7IMHHmNfJy3qh2HfAWgTREFuYiit4XGniUF//KImOFKLm+j1rbM9TsG424NqLh05U3OUKMlDVXCEBlzTCZyEQgtVq9WveUWMU3UO8TER0gYpzXhGzfgLA8Pe3jciOoVUnOxtQsNoDM6cXBEAbM+cAwKU3gbbXhx4YQUVDTOBgROYmdqpqrHjZxkGpaQBco1+CTJjSf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Xi76e3bU4wP3rv5tKoT+0fSHZyGBw4KHMiD4KOqW9YWBuvfBGkeFL+gFPho?=
 =?us-ascii?Q?DESgp6ASu1GObT6zk+ZLkJfoeKppEe1+t+x9PHuPyOhMWL4J97QgXeJlRw9V?=
 =?us-ascii?Q?4JgGqRL8c7Xf6vgaJNIOqfi0gZVuFub2lkHSQafm+zupw2CW1THLBK4IvDNT?=
 =?us-ascii?Q?pQcpGSudpx3iWNOeveOndwKOfMTNvgfk5ghjtjTVxTShuDeaJMQEoaKsAh94?=
 =?us-ascii?Q?+IsXtJQEoptnJtz5dM07CJTGg3m63XK9PAlIS39N9WaEOUtlyD0xx2ym3XUA?=
 =?us-ascii?Q?LKGCmmjTsjAzkdvc4/8ds3ruGvJ8TuBwvHsv4CMfzc/gUxkh2tytaoktDdzN?=
 =?us-ascii?Q?gnk0/Bokn7FcnAc8l/1f6PAGXkySWSh/e+XXe7iDR11LdeOK8UFTeqAdL0MP?=
 =?us-ascii?Q?Z6ilDraq+0bAdPy5TyQTGfbADvS2/vjvcArFwKmqIPNY+bXi6AaVh11j7klS?=
 =?us-ascii?Q?yVGgzdYGAADhjJKbHo6h0Ivaov4eKBcjYmItgqXW01n74VqMAcm2Qub44sjc?=
 =?us-ascii?Q?OCNTN+aB9keqipqlpJXqoPAWEnFSeZsUQZsXPxx0Zupof+ibLXdfpcCQNb2m?=
 =?us-ascii?Q?MP4sRtR+R2HBVy97xVDPg/GEnNL0nM8lAns5+3f8DHiwgY201TzR1GxGVql8?=
 =?us-ascii?Q?HnElgmmA0ulZky3/TA9qOLl8dTMDtZPFA3cpzMnK4nG497wkV7MnGMWQYAFV?=
 =?us-ascii?Q?J3LkY/7hpgRjLoclSNz9d9SeBE2nd+ek2EYKUHNxsAYTeGA7ibdhSgODbOcZ?=
 =?us-ascii?Q?0T5txCE/4QpQipai504YtG3CrH9Dn8JHTs2pTYsD/pgPK504ZnuE0L9uEMxK?=
 =?us-ascii?Q?DoBSBTDbBg1UyWjNHFxUbnoSeBHTXJc4Zf3RhVM7dgDdv6DbbRtsimyh71z6?=
 =?us-ascii?Q?n7X46VeYWfkH6eTxe3Ici0zWd8AJP91G4cxcwPoj3R41bg9k24+sEq8qvWX/?=
 =?us-ascii?Q?tQTXAWLtXm5v8BNYUL0AfajWJsS+3D6hRas8bD5z7BEv7zzqaJoVPaLgVoVl?=
 =?us-ascii?Q?W2YioU0bE6axB+owT1+r9dXtQPN89ECjvLkYsA/IK2NvQKW5mnnNloCHiJMX?=
 =?us-ascii?Q?Q+EPLq9XxdHQMt3fZ47X+SKEelDE0Nh1Ic1rQYcHX2kzhhz5vkxFL9HpoHA7?=
 =?us-ascii?Q?B57ig9qJrLAC0tIjcWtna5+JpzqSFvdFWKSFkWSMCrz0cdKjVjOQ/zMS9q0P?=
 =?us-ascii?Q?2A8EvjSvC1kkj18F2GUgMkBE+vo82MQA2KWT4aPtkegFTWV32Blw+4vWHz8s?=
 =?us-ascii?Q?ml7PGJ6PyURlTCh16eNqkpQRIt8rj6uSwwtxw9DhSgNNneetYLhEmXLNrfNJ?=
 =?us-ascii?Q?0qyl8+H5DxO1OFMC4DtARGAWRznO9G0N3C7PSOz3cugTpFJ4sHW1DrsoLCUx?=
 =?us-ascii?Q?gCi753Bz4Rx8v8B7snVII6+PP2NK2DNqU4JXYIN2AiUCyxsAKB5ow7u63uBS?=
 =?us-ascii?Q?P0C+lvHznWcg+a9aWrvClqjB11IjkRAsRl31F7ny6wglQ1m6QkjrqlztP4x6?=
 =?us-ascii?Q?r7habA5wXZ93xVy+pjpuVMbHh+x0RFJMMKT8uHtj9nAz21BjyhWhtG2pRsok?=
 =?us-ascii?Q?32bjqYEWPzhyt5+nCofu+Lhm0sFXNHZ3+b9WuyFOAfqdxh9gF0fiJHg5eg2I?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b42ea7-2948-48d4-0bb8-08dc39fd4b91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:38:43.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FbI6mQ5MowWbzn1i84OzcPMLzHTFRd5OfYs+fCzH/wpEJqerNJvX4NVH31iuGli98ltSw3ydLhZGUaTcdSnl3/UvMOQZ2hpsOXVL1p0zDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6269
X-OriginatorOrg: intel.com

On Fri, Mar 01, 2024 at 02:37:08PM +0100, Michal Schmidt wrote:
> The pf->dplls.lock mutex is initialized too late, after its first use.
> Move it to the top of ice_dpll_init.
> Note that the "err_exit" error path destroys the mutex. And the mutex is
> the last thing destroyed in ice_dpll_deinit.
> This fixes the following warning with CONFIG_DEBUG_MUTEXES:

Looks like ice_dpll_init_dpll() does dpll_device_register() and ops from
ice_dpll_ops can already acquire uninited mutex.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
>  ice 0000:10:00.0: The DDP package was successfully loaded: ICE OS Default Package version 1.3.36.0
>  ice 0000:10:00.0: 252.048 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x16 link)
>  ice 0000:10:00.0: PTP init successful
>  ------------[ cut here ]------------
>  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>  WARNING: CPU: 0 PID: 410 at kernel/locking/mutex.c:587 __mutex_lock+0x773/0xd40
>  Modules linked in: crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ice(+) nvme nvme_c>
>  CPU: 0 PID: 410 Comm: kworker/0:4 Not tainted 6.8.0-rc5+ #3
>  Hardware name: HPE ProLiant DL110 Gen10 Plus/ProLiant DL110 Gen10 Plus, BIOS U56 10/19/2023
>  Workqueue: events work_for_cpu_fn
>  RIP: 0010:__mutex_lock+0x773/0xd40
>  Code: c0 0f 84 1d f9 ff ff 44 8b 35 0d 9c 69 01 45 85 f6 0f 85 0d f9 ff ff 48 c7 c6 12 a2 a9 85 48 c7 c7 12 f1 a>
>  RSP: 0018:ff7eb1a3417a7ae0 EFLAGS: 00010286
>  RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
>  RDX: 0000000000000002 RSI: ffffffff85ac2bff RDI: 00000000ffffffff
>  RBP: ff7eb1a3417a7b80 R08: 0000000000000000 R09: 00000000ffffbfff
>  R10: ff7eb1a3417a7978 R11: ff32b80f7fd2e568 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ff32b7f02c50e0d8
>  FS:  0000000000000000(0000) GS:ff32b80efe800000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055b5852cc000 CR3: 000000003c43a004 CR4: 0000000000771ef0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __warn+0x84/0x170
>   ? __mutex_lock+0x773/0xd40
>   ? report_bug+0x1c7/0x1d0
>   ? prb_read_valid+0x1b/0x30
>   ? handle_bug+0x42/0x70
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? __mutex_lock+0x773/0xd40
>   ? rcu_is_watching+0x11/0x50
>   ? __kmalloc_node_track_caller+0x346/0x490
>   ? ice_dpll_lock_status_get+0x28/0x50 [ice]
>   ? __pfx_ice_dpll_lock_status_get+0x10/0x10 [ice]
>   ? ice_dpll_lock_status_get+0x28/0x50 [ice]
>   ice_dpll_lock_status_get+0x28/0x50 [ice]
>   dpll_device_get_one+0x14f/0x2e0
>   dpll_device_event_send+0x7d/0x150
>   dpll_device_register+0x124/0x180
>   ice_dpll_init_dpll+0x7b/0xd0 [ice]
>   ice_dpll_init+0x224/0xa40 [ice]
>   ? _dev_info+0x70/0x90
>   ice_load+0x468/0x690 [ice]
>   ice_probe+0x75b/0xa10 [ice]
>   ? _raw_spin_unlock_irqrestore+0x4f/0x80
>   ? process_one_work+0x1a3/0x500
>   local_pci_probe+0x47/0xa0
>   work_for_cpu_fn+0x17/0x30
>   process_one_work+0x20d/0x500
>   worker_thread+0x1df/0x3e0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0x103/0x140
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x31/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1b/0x30
>   </TASK>
>  irq event stamp: 125197
>  hardirqs last  enabled at (125197): [<ffffffff8416409d>] finish_task_switch.isra.0+0x12d/0x3d0
>  hardirqs last disabled at (125196): [<ffffffff85134044>] __schedule+0xea4/0x19f0
>  softirqs last  enabled at (105334): [<ffffffff84e1e65a>] napi_get_frags_check+0x1a/0x60
>  softirqs last disabled at (105332): [<ffffffff84e1e65a>] napi_get_frags_check+0x1a/0x60
>  ---[ end trace 0000000000000000 ]---
> 
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index adfa1f2a80a6..fda9140c0da4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2120,6 +2120,7 @@ void ice_dpll_init(struct ice_pf *pf)
>  	struct ice_dplls *d = &pf->dplls;
>  	int err = 0;
>  
> +	mutex_init(&d->lock);
>  	err = ice_dpll_init_info(pf, cgu);
>  	if (err)
>  		goto err_exit;
> @@ -2132,7 +2133,6 @@ void ice_dpll_init(struct ice_pf *pf)
>  	err = ice_dpll_init_pins(pf, cgu);
>  	if (err)
>  		goto deinit_pps;
> -	mutex_init(&d->lock);
>  	if (cgu) {
>  		err = ice_dpll_init_worker(pf);
>  		if (err)
> -- 
> 2.43.2
> 
> 

