Return-Path: <netdev+bounces-82420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93788DB0B
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEAC1C25ACF
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB7481BE;
	Wed, 27 Mar 2024 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkZIGiOT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A59381BE
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534525; cv=fail; b=nOdRNvlZ2kj6Ne4p7Ed5Scn1Ua6Vs375/389VbeJvTajzQa6iwlYmKdDbIu+0nt3z/LRH2MWj8Ubux0MEGYBULS9pKLQuEpm2PLyGKdGILBwGP26G0XPqU/N8IRYYP6mucRUfGvbCVed49MPzvEkgKMnf/XzC87oNAT2GSE3lS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534525; c=relaxed/simple;
	bh=CE1GahsfRV1JQTvnpzmG5YTI+FvmHr+L4z8GpvAhmu0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=botYUNgJrWNbY07gHXZklPYw+ZVOAWPuL15XvetlKXX66Gxoy50UkmtycfKdN4QilUyutX7oKBbajfJc3bo5TTVdEeMwmfki0/+DtpoCJ849nnD4INqU/k2sCLcy7BDJirHLI+j9+GBljhUfdHxT7xdcB3B+IYRNZzUGVJpPOOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkZIGiOT; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711534524; x=1743070524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CE1GahsfRV1JQTvnpzmG5YTI+FvmHr+L4z8GpvAhmu0=;
  b=GkZIGiOTGGYodKoaqV1nD06MgmqSamalehuEihiyhbngFOeHmmJS3Rrz
   /z1KB/SimkGm3nU6mTgGrf1Io6NRGEDL/t63G5v1aWXESB9LKBcV0+ZiI
   3lJbNFvbDmf+frnIbbsdT6visfbCUqZqWrKL4r4PvlGS3mHdSwh+UAhy5
   wvGM45JcF/qDDwm4dtzP26bwDIPQR8PuyVdF2FBFy6AScUhVU0WAxLhRO
   b7UGVixcybzbGXtgKIzhB3TepjRd19ffcTT8veTDqdvn630ZyIdlVgMD2
   NJeuG7e6w4pEwknWNQ7vzcLfxjb/M5aLfZndBB1PpC/9K59GNzi/ZQ5df
   w==;
X-CSE-ConnectionGUID: oIqwHXMHQ6CvfZzlDD4FxA==
X-CSE-MsgGUID: 3FoTc9gBTtifYfpqKTsuYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10405911"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="10405911"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 03:15:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16091431"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 03:15:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:15:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:15:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 03:15:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 03:15:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsaXnDPP+PWQnlvN2BcII3hQQUpwtsqe+Dzdc7/2C0+Oc9DnufEtWrkTQBkNMTDgSdyMwPbGv/re7YG36RhHd6b4P4V+SVSz6BeuxFfvmV6qtuIFdBrs88pSnX3wxy/pYlPAE+nzkXqtXStopWCdq+loRuOHrKNIZLtBNVYObNSzpR/f3BwICzo1IzIRPSlkuWjlgvhiCAZnLndKmq+qUgDfhi1Pqlc6qbRjZiYpIHIDv5nDWaGdDqeOXuAC31OtsqATYbm3HVakXdsyC1kOInAZZ2UBG1h0a+IK3UmSLHYj52PcdxoiPriFJaggQR1mZgkqz+jnjwWDFtWMvZaIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Owq3LHiCgq7vYq6ZSNQ0xoP4FZbTxiPjGiEIJ0H5lU=;
 b=fAMFcPgDGDPkesiuzcm8Gc8m4Xv1osCX0Hgs0e17lQ8CpeL7tg12y4klAhL/hHGyTzjNr6B1+QR9lGnDYl2XDFxjoqpmwrFtIDd9C7fUyUfBpl+yt8Ti8Bi3MVudHnAantKVWc4TWWGEFbNl8fMNUZc9KNcv2Y84boMdE8UNEBal7BAKM1NKPO4qiic+NLrQNc1E6C3g2Q0VsMT+LDh2DK7OIDQ7ku1GXKZMF2czA3SFdn7ltZ9ICScgqQieCOzLlVnUCs6gYXTHfVFUmNXfZvAAVu3c7zRMAmEKRBu3Fe4rJzGDXsWAG7tF+GfDESZ/2xK0JJzkBrHs8sYCeKlM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB5264.namprd11.prod.outlook.com (2603:10b6:5:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 10:15:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 10:15:20 +0000
Message-ID: <40b3371a-5966-4140-922e-7c62a1c73e6c@intel.com>
Date: Wed, 27 Mar 2024 11:15:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] devlink: use kvzalloc() to allocate devlink
 instance resources
To: Jian Wen <wenjianhn@gmail.com>
CC: <jiri@mellanox.com>, <edumazet@google.com>, <davem@davemloft.net>, "Jian
 Wen" <wenjian1@xiaomi.com>, <netdev@vger.kernel.org>
References: <20240327082128.942818-1-wenjian1@xiaomi.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240327082128.942818-1-wenjian1@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0264.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d075b3-f6e9-4012-8326-08dc4e46cea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lv1brujMiUWEvafEmmUbxYBpe+DCPPVf9EKeiXBztMIH7IoJ480eS0N2N6Ffa11zSuB1YzJEjJnIAjuBYGMgEILbawC9UnYBiWi2505LP3awWgaelM0ShMhy0lbQQu7Uy09Nmh7O/7mUgZlHdhEC15mPPm32UGGBJopZfNtFJmAhho5Tw7DKBabQufz70kSf854LhwPbtc1/QHmLCzDTpA7rtTRwcBb4/I9rqsj3zfJmhcVE8psp/94jTIgchEH+H11jDKG3ljxpwSY8qKKChs/HLA/zQLYbuwaA+w9SHgNRMOgS3m/jlwTxoshO1T3rlLK3kbMBiMO50fiTnGOyX/rgdH0BhLKRPecIxNkIn+BeMZRINv+rColitzJh43l3q+T2k7eTm3Td+EZVChadqKxeHwxgk/IZ5t+7KK7lyBTXb+P2OYE9w0XEqMTBYd6Vyz047uALt+uDMbzEn1je2fv3egx0uhTV0rj4/sy9++JsFUCE7jMWO/He/YWmTrJvjAlrcrN33Tkmk//7XvkFLPBvkh39x9Ag47RQFO+4vf0Wnoir9+OTG9duxfoVOjOZqNy/UTT8S1PMQkSwtn66IGgsHjzoxrZp/auH5fSOx/ilcmPDa2ThdD0y5Le0MdpUHJG+cLqoOw+R4Y6wko4VVKwY0NsttVPBXHd7WZ07KGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnEvZHRPbm1qNGloRGNLaVJwVmFDdHZTaDJuMEpzbXMzRlBDNC9vUVBjT2la?=
 =?utf-8?B?c015WXNYVnBYNUc4Tjl6S3lkTHBRZ0w1bTFlYWZRb2N4MFN6YTlERWdFdnp0?=
 =?utf-8?B?TzhYTVR1ckd5TEZEQlAyaFFSVHBBVU9JQWp4NzhJWGJCK2MxVHBSSjNJTDB0?=
 =?utf-8?B?Qys0Z0NGYVhjWFBSV0ZmeVEvUU42dUd5Zm5wdVdtcXJNc3VsWktwTGJNeGp3?=
 =?utf-8?B?N01VSnllWUJmbXh0bG5vYkh3SlJub25OQ3ZoM0NBdll3VnRWQXZlNFRnNVdU?=
 =?utf-8?B?bFc4RjFacFFOcFVTRDZUTHJyN01Xemo3bmNYMjkzZDJ3OVJvTlRwaHNBSU92?=
 =?utf-8?B?aU9qdEVQQTdjUkE4b2RqUWMvOTJ4ZlhuRkNFelc4OXNYQlk1NVRBZXFjR0RY?=
 =?utf-8?B?cytrMlJISkEzTWg1aUs0R0VVM2MwWkt1QzNCaytzUlFEbHdUUnN4QWhzVTIw?=
 =?utf-8?B?NWZmcU5xSFhwMGt5UmVYV25mL1JpMFNOa2R5R3JtSXpGKzhWWWpTY0xtTkgw?=
 =?utf-8?B?eWNNRDFrVVYwOXV3ZzB5MTVZdlZHVnZqekthdytPZU90UVY2OU42bW5ad1FR?=
 =?utf-8?B?aEFJcFppRHlNY3FyNXJ3TmxDdEZhNGluSUhtT2hUcFRHSW1Zc3FHdHJUSmtZ?=
 =?utf-8?B?NVQvMS9xNTc0aGR0bUVWbjQzcTMySGtraXR3a1pFOW5WN05DYXJxUUJSTHJn?=
 =?utf-8?B?MmxsUDhhK3FML1NIL0xhYkZZZXI5UHVYWkNzWk1hZDBNSGttR1o5WkFoS1lW?=
 =?utf-8?B?OXNLOXgxdHNtZFZrQjdrWDhaVTM4YS92dVFEL2NwVlNZTUt4N29uR0NQcmJz?=
 =?utf-8?B?ZFhRcFc4bXZqY3hRc2ozR3JiVjVSSVFtb0ZxeVd6YjZJMlVXV2lUd3AvcWx4?=
 =?utf-8?B?YXcydlpQaDRGRGhLZGhvZUpOYmpiT2l0Y3J1UHlZWjI5b2gzb0VQTkUxMWl2?=
 =?utf-8?B?WExtR04zQ3c3di83WnZiYnVZN3dUNUNVcmVlTDZwUEhoRnczVjgxSDMvM3ZL?=
 =?utf-8?B?OTMyMG53T3UxaTBQQWJPRHkvLzZiMTFoQlQ3TjlyYVNnTDNBSHR4ZHhxcExP?=
 =?utf-8?B?MHZWb1Z3UkZPWC9NcWdETG5aVm9LVkl4ZlFIRXYwNlRVMEhzRERjTzdDSXAr?=
 =?utf-8?B?M0NvTzBLS0VVR0NqMnlJak54K0paSVNNbEN5WkpDejREMFpWQkxuRWdOMlJ4?=
 =?utf-8?B?d1JOQ1A0ZGIvc2lVY2ZSbnFBZEliZzRZUDQwK0wwbGVhTmx6MVZCUVM2WW9G?=
 =?utf-8?B?aHRJNG5YcGlhT3I5WVAzUWtlUkxGdFl4dEhiK0ZBQWFEVXpLYUFjeWlOa2RR?=
 =?utf-8?B?Z3IzalM1ZHU1SEhTTTBaSkt5OUdEQWF2aVhrM2RkRTFYYjFlTkpwSFNRRHE1?=
 =?utf-8?B?S29CTlZBOG9qbXhqWG1PZGptVnU1L0JqUDN1TFBlUDFma2JTb1ZOck5XZG5u?=
 =?utf-8?B?a0NXOE9oYzk0KzIyckxFVTdXdCtqQzZ0TklvUGVzM1dSNklweDBXblh6Rnlu?=
 =?utf-8?B?azNWNmxkUWlha0FiTVp5RnVvTVhSblY4WnViekoxbkhYcVEzZE85MnZCQnNr?=
 =?utf-8?B?bkZQUE1RcHZtVE82aWg0RlpNM3JTZlYwN01samVMTnRaM2FzWDNZY1l2NjYr?=
 =?utf-8?B?VUVFMDhlM1phdHhtSGZycHdpNkV3RWoyRzU0OUtuNGpmMU55cDNYTDRUSEUw?=
 =?utf-8?B?Z2RBQlRMcGRFVk54UlBSaklrZm1ZelUwZk14dnlEcGhMRUoveVZraEJzWkly?=
 =?utf-8?B?RGFtc2VFZWJrRzJaUWZFREZqenRnbllKT1FacTFtdXBxRlhWWm8zTEdJQnhB?=
 =?utf-8?B?TEg4dytISnJFV2x0VWVxQ0Nsa3JyUzd4M0l5ZnVWdmJoUE1RQjZOZncxckxB?=
 =?utf-8?B?OGdQZkpQU2Y5cFlEaVRSYW5HS1VNVDh1a044bnZwQ2lMY0d6Z2ZDTW5iYjlu?=
 =?utf-8?B?ckZwMUdyM2JVZG55YnBpSk1aWm5maHJiRjQrLzdXelFUNk5WVDBFekxVaHY3?=
 =?utf-8?B?LzdIY1V2bGNaeStCSGtqb3J3K0EzRzh4OGtrQk5SOFd3SlVBWHAwdkVkdzZC?=
 =?utf-8?B?K283S2FVYnNUa050Ui81b3dMeHlPWXdVRUxZN2MzRE51NUVMS2l3eVY4Q0Fa?=
 =?utf-8?B?SUR2Z292Wi9hY245bDNnK0h0dkk4bytSNkZCVVpva3c4WGRxZ0oyYWt4bFAv?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d075b3-f6e9-4012-8326-08dc4e46cea4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 10:15:20.2259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFTz6TMpMdLOcdHDeyjMGiszOKEt1GO5jD//yFc9N2k6HDbtX/ywsTQjHnp5N+9HOoJXFcj0Mupzx0qmkOdJ+NyWsP2i0LiWZd2grPNWS2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5264
X-OriginatorOrg: intel.com

From: Jian Wen <wenjianhn@gmail.com>
Date: Wed, 27 Mar 2024 16:21:28 +0800

> During live migration of a virtual machine, the SR-IOV VF need to be
> re-registered. It may fail when the memory is badly fragmented.
> 
> The related log is as follows.
> 
> Mar  1 18:54:12  kernel: hv_netvsc 6045bdaa-c0d1-6045-bdaa-c0d16045bdaa eth0: VF slot 1 added
> ...
> Mar  1 18:54:13  kernel: kworker/0:0: page allocation failure: order:7, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
> Mar  1 18:54:13  kernel: CPU: 0 PID: 24006 Comm: kworker/0:0 Tainted: G            E     5.4...x86_64 #1
> Mar  1 18:54:13  kernel: Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> Mar  1 18:54:13  kernel: Workqueue: events work_for_cpu_fn
> Mar  1 18:54:13  kernel: Call Trace:
> Mar  1 18:54:13  kernel: dump_stack+0x8b/0xc8
> Mar  1 18:54:13  kernel: warn_alloc+0xff/0x170
> Mar  1 18:54:13  kernel: __alloc_pages_slowpath+0x92c/0xb2b
> Mar  1 18:54:13  kernel: ? get_page_from_freelist+0x1d4/0x1140
> Mar  1 18:54:13  kernel: __alloc_pages_nodemask+0x2f9/0x320
> Mar  1 18:54:13  kernel: alloc_pages_current+0x6a/0xb0
> Mar  1 18:54:13  kernel: kmalloc_order+0x1e/0x70
> Mar  1 18:54:13  kernel: kmalloc_order_trace+0x26/0xb0
> Mar  1 18:54:13  kernel: ? __switch_to_asm+0x34/0x70
> Mar  1 18:54:13  kernel: __kmalloc+0x276/0x280
> Mar  1 18:54:13  kernel: ? _raw_spin_unlock_irqrestore+0x1e/0x40
> Mar  1 18:54:13  kernel: devlink_alloc+0x29/0x110
> Mar  1 18:54:13  kernel: mlx5_devlink_alloc+0x1a/0x20 [mlx5_core]
> Mar  1 18:54:13  kernel: init_one+0x1d/0x650 [mlx5_core]
> Mar  1 18:54:13  kernel: local_pci_probe+0x46/0x90
> Mar  1 18:54:13  kernel: work_for_cpu_fn+0x1a/0x30
> Mar  1 18:54:13  kernel: process_one_work+0x16d/0x390
> Mar  1 18:54:13  kernel: worker_thread+0x1d3/0x3f0
> Mar  1 18:54:13  kernel: kthread+0x105/0x140
> Mar  1 18:54:13  kernel: ? max_active_store+0x80/0x80
> Mar  1 18:54:13  kernel: ? kthread_bind+0x20/0x20
> Mar  1 18:54:13  kernel: ret_from_fork+0x3a/0x50
> 
> Changes since v1:
> - Use struct_size(devlink, priv, priv_size) as suggested by Alexander Lobakin
> 
> Signed-off-by: Jian Wen <wenjian1@xiaomi.com>

Since it actually fixes a bug splat, you may want to send it with prefix
"net" instead of "net-next" and add a "Fixes:" tag here blaming the
first commit which added Devlink instance allocation. Let's see what
others think.

> ---
>  net/devlink/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/devlink/core.c b/net/devlink/core.c
> index 7f0b093208d7..f49cd83f1955 100644
> --- a/net/devlink/core.c
> +++ b/net/devlink/core.c
> @@ -314,7 +314,7 @@ static void devlink_release(struct work_struct *work)
>  	mutex_destroy(&devlink->lock);
>  	lockdep_unregister_key(&devlink->lock_key);
>  	put_device(devlink->dev);
> -	kfree(devlink);
> +	kvfree(devlink);
>  }
>  
>  void devlink_put(struct devlink *devlink)
> @@ -420,7 +420,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
>  	if (!devlink_reload_actions_valid(ops))
>  		return NULL;
>  
> -	devlink = kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
> +	devlink = kvzalloc(struct_size(devlink, priv, priv_size), GFP_KERNEL);
>  	if (!devlink)
>  		return NULL;
>  
> @@ -455,7 +455,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
>  	return devlink;
>  
>  err_xa_alloc:
> -	kfree(devlink);
> +	kvfree(devlink);
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(devlink_alloc_ns);

Thanks,
Olek

