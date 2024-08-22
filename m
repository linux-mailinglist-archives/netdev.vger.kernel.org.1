Return-Path: <netdev+bounces-121083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9CB95B9C6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56912864DA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2971CC155;
	Thu, 22 Aug 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLbh44Ob"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423B1CC880
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339653; cv=fail; b=W59GGmgTDfOR2TejLYlZihUiDDAsScSAl1oxq/gbUBE9eKyf5kiWA1L6+z5qOhfbHs8hwVMv1nIBFRVY7RXHarx1HHmTddXENPHhd0FGlXxRhHizpm76cCm6xtXw7kShp6RpXAP+x/RzDMfIrUzoX0mb/CKLVn/Lhn5+9OuPZMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339653; c=relaxed/simple;
	bh=/tXbl3vyTNAJSSeXlm3mB9HgFZjPdHJyvt86HGn9UM0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L1qBUED3xO/AKZYz15nwq1VmTVofQG53X2xf5B7iV2Zg7eRA10Pbc+1tr9UDi8qD0Ynf9m8783bNRHGnste5LG2gEOq+tsLTMp4Q+P5aZYe2+fmTPAtsDWeLIBxb6SI202nwb2H2X+miqUzyQ3jq3H7vZt2gWXfvsB0od8WB7jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLbh44Ob; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724339651; x=1755875651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/tXbl3vyTNAJSSeXlm3mB9HgFZjPdHJyvt86HGn9UM0=;
  b=HLbh44Obaw7zi6bTA2rfprIjl1mEk1DBpiRbCxoHq4kTw15eKoiHDA15
   vm2nVtwqSql4DmPLkxI1mbYR9vI2Qd6/ob1nkYAYcF+IlFezHCPvK/PG5
   HWjorBjwrbARO8MgwClvDz8grcPlf6cm06I3Q4PoyXUpedOsll0q841Sq
   Qi1C9/akWxVc7NDP5eJe45tNWKVKRB/RkaUGzv/qNkfNBe/JIlLQ0vgkN
   FvKrHB4Zs1PFlSL4f89+M2W0bmInxoFG3Mx9iFn/YvaZphrAb9EDv6MwF
   y0+JBXSCR4rm/XdrQOAL4MtdbaybQnyGSI1IAmmc82xOgghRJ9CcayusW
   w==;
X-CSE-ConnectionGUID: fczZVWqhSMK7YaTlZA4EHA==
X-CSE-MsgGUID: uyuJRkEOQ/2wBu90Wswcxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33920802"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="33920802"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:14:11 -0700
X-CSE-ConnectionGUID: MqYLwt0YSXWjAFPrZoNGiQ==
X-CSE-MsgGUID: UP7j7DT4TOS55QqwGK8oRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66371286"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 08:14:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 08:14:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 08:14:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 08:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYlTQsiI3MU/bwERvzxH7Lv9h8/QaDYYuhJ0WwJRHsx8sHfKRYlXZqX/3TlJ623PqNvHy+1v4A/9SALux1BjTrgCC68iA4IvzKa1qdXdk4ykpOEf0O+pe7fJWQJBw+CHO+Ejz81JfAAasUu8XRm7GIfEJui0+iSffBioGoYLTlHhkJr86ZgwNI0T8pdsgLGUoB/yXiQ/jf39fBp7KgjE1ejTBqCISmEYzfOPblTOvacihIS9s/HatRYFcF1P0VO8/DQw6HPj9naYs2GTug7KJhuo9HF9Qdd6KjuKMVY+X2jCz7lFQ6lbJ08rMp0M0vLmHanA9EpPdzk3QcwsGiobxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejs0PWJRcKxK0t/jEPVMjNmvNKHin97uaxOxPUE2KlM=;
 b=AXUaCVNT5A1K5Sp+AOUeh4jlT7sjafC+nBgaiJGY/uF9YpN/Zo8qvAZLrIHD/7QxGNbLOkayNruIhYekuXM1N2YIpvMdDLhNOYoGHsqbuBfP3ISUW7W/oUJRJA7rvoYFlBZ1mJanMnCwit8BHW6FK8prQ21dqHqKrwsgElDbNIwJPmz9/H82hJmMl6FuTX1J2nWKTNd/AvWq+mgcX63JXcbskqbDDaHQX9mtMsdJ8nc0DPreq0n/zvcZYyivMbQhbWZ44Dqeq8xaWSy5k50gNmv2lFCWXyHxAKSmUV4TJMerSRnEgpTEe/yDvZR3CSJnvzayVb/M2mxBQxVBUvrLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 15:14:03 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 15:14:03 +0000
Message-ID: <613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
Date: Thu, 22 Aug 2024 17:13:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
 <20240819223442.48013-3-anthony.l.nguyen@intel.com>
 <20240820181757.02d83f15@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240820181757.02d83f15@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f435fb-71ee-4037-eaa2-08dcc2bd0ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkV1SjBsT3FQQ0owMFN4K1NTc05CWTl5dmcvdVBBRWJFb3lHZXRrMjY0NURT?=
 =?utf-8?B?QUNBM2RBTlN5TDVCVmVpd2NPN2ZHVHBxSGFnY1Z1N2V3REtka09qY3diK05h?=
 =?utf-8?B?cnlIdVNiRjhqV2k0WVVia3dDUVZmUFJodytSK3V1QkYrWTlNblFRZE5majRq?=
 =?utf-8?B?Q0h1SGN5Y2szSm56Ujg4cWQxdEttRm11VFhUbjlNYU5GM1lNdEpxSEJoYkt5?=
 =?utf-8?B?U3A5S0N3YTRhOTNadzE5NHNjcnc1QUJGT2pzbkF4WitCUERMWnhtMno3NXpI?=
 =?utf-8?B?YlF5c2pCYmFpRWFBRFVXSXVrU1Q2S2VJcWg4NTB3Yy9aTlh4c2xXVUdUeGha?=
 =?utf-8?B?Z290ek9MaEhDMXIyUU5RK3ZCOW5IcTlQekVyKy9rS3ViMlptTk5za09tbTZa?=
 =?utf-8?B?TGZZRFNzUmQ1ZS9sNitrVk1jY2IzbHNQQTN4Unk5bS9RdUhkWDVkZ0c4RSto?=
 =?utf-8?B?NngvcW1Hd2NWUE5xYzdaWHRndmgwREt0YytnbFN5dzJzaWh1QTZUQkFsZU5a?=
 =?utf-8?B?WklMc21WQTFab1EwQ0VEM3lhY2RnYjhoa1BIa1dsd2ZtN2VhMnI0VGJCWkJF?=
 =?utf-8?B?OTNZYmFDRnFxRzVBMmwrM2Z2MDFuQlUydlhUaVA3NTNvSS85cUwrR1Nld0Ru?=
 =?utf-8?B?dHQ5MnpsK05xMUtSazNYQ2NEV0xKYzJLSUY0dDRmZ3lIQ1BCaUNENFVjaWRj?=
 =?utf-8?B?djA1MHhKeG42dFRpczVIWFVyL3N6aStabEM1b2oxcXNodG1OU2t1T1JKcWFS?=
 =?utf-8?B?LzRNRTBWV3NnSUdHUlI3bWRiNXphUEhmWFZnVWU4RHZEdnFSWVZxM0RRbWhP?=
 =?utf-8?B?YjErQVJWTHlKY09PRmxLMnVNb0NIY2lUVHdBQlhEdzhIekN6Nk5va283R2hZ?=
 =?utf-8?B?VmY4NngxTlpqV0pXeUQ2dUNvZmNnWmJqYndDdm0wOWh3dVNTSEJmcHU4aFpD?=
 =?utf-8?B?aURTN1crdUJrZjV0eWtrS21LdElydmlWRC9FaXZrRTd5RS9jTEptMlRSeDk4?=
 =?utf-8?B?MWc3NG1mMGVPVGtGMlVDZ1F5ZG9CYTRMZlhRbnBKR1hpNU1qOWZVKzkyTDBJ?=
 =?utf-8?B?OVp5dnV1MlBwQmNhRFhEK3lLQm5XcnNMTmhObVZST3hwMVhlS1FwK3p2VTAx?=
 =?utf-8?B?bnErcmtsaVkrMlVVcjljeVNuU29ueThsYXVuRlZZZnQzNEJBMitkTUlGanJS?=
 =?utf-8?B?SjZ5TmN4RCt5MFpzZUpsaU5sb0xLWXVKQ2hDL0dJeU1lMVd3bU8xMEo4ci9v?=
 =?utf-8?B?bEVIRXVqMjBHZnA5OXlqT3RpMitTbXl3WXBMRE9KZWRSakpHSVRhdlVmcmhV?=
 =?utf-8?B?ZFlUeFEyQlh3OVlVL05NYUJwY3c3dEcvYjZtTS9iYk8zSCsyN2ZZRWJOVGhm?=
 =?utf-8?B?aEV2WFRkQWZZdFMzYVE2TGJOM3gyRk5MelZhNHVNdW5KcU5LU3V3MTU1NVE3?=
 =?utf-8?B?d2hDZWMyc0VEQnRiMkYvRkNSNDZ4a1V6RE1CY1BQT2Y1TW1WNSs5VS9ReEV6?=
 =?utf-8?B?SElpTFFSQVBVejJ3eENWVEpOVk1mR3EvVjVSTVZERVVPZUs4OHhBVmJVY1NT?=
 =?utf-8?B?TWQzcTJZM1VSTVU2YUluRUdDM1ZUa1ZUWlFXQTVpRDFrYkdZMDR0RjdXNmdw?=
 =?utf-8?B?TmRTSE90RzRGZXJ3WjQxMUNvZVRMWFl0YUpDMHUwWEgwbVJjRXlqKzBqY0Nz?=
 =?utf-8?B?cGs5ajRKTUFWZTdVQis1UzJvVmFiWHJaSmZFZXZKZnNzVVFvejBJK0x6VDgx?=
 =?utf-8?B?dG9OV2cyY0xwYzlhSGJOVGkrTzFhR09BeFFHOUlScFVuVzVzY3UwYmNPaklH?=
 =?utf-8?B?UFh4UGd2b2NScUdsWmljZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L05tQ2h0RC9kbE9vMlpMT05TNitIeHdhOXNGZ0UyMmxKODFqMmlWdFd0VmJE?=
 =?utf-8?B?azIxM2k0L0FORjV4c0JRa3BPcFdEM3gxNVdFaUcxZFJnT3prZHFWSEpuVHNk?=
 =?utf-8?B?ODhQZktRempEU0RXRnJNc3ZwZGlMT1RSSHJYVGxFQW5VQ3R6ZWtrcGdSLy9k?=
 =?utf-8?B?U3dkZFdodys0TThZbVlhc3cwSjMxMjJNb3pnemhNN1hKMGxyZEhCU3ovUFZS?=
 =?utf-8?B?NFlGVXNBQTVGQk5XZDdlNzZIemZsVzhoSHVnR2NybEdKVE14OEhlcEJhWkVQ?=
 =?utf-8?B?U0FhRWE5eXlJNEc3b0pWblY2M3ZvSjVjWHVhbzdNTTIyNFFYN09JZDFLR2Mz?=
 =?utf-8?B?cG9XdVhBdWpTdlEzYXZ6SHpPSVM5N21kSDhZNmxmcUtxYldNd2plSjcvd0hm?=
 =?utf-8?B?cWRlY3FmVFBkbXo3U3F0ZEVwYks0K2kxUmIvZG4zbXhhcmlyNm10UW1lWTdS?=
 =?utf-8?B?UXpmMUpTbThSWDJwVlJQc2VjcDNhNFNuK0VnckhqOHY3bVZySGl0eDZZRkU3?=
 =?utf-8?B?OTZQMW8wckZWWDVuUG5vRFVpaWN1WnovVU5nVVF6UjJDNS9rSlpYUHUzVGFU?=
 =?utf-8?B?WFVYM3RtODZiUjZVL20xQmgrNTV3cnVYZ0NmbElvSUNWNXhLVHczQ1dFdlMv?=
 =?utf-8?B?ZzhidE5RREV0L3pyY0Y3ZWZuWjdrdXVOcml2N2RwUklValNWRTlYbzFRU0px?=
 =?utf-8?B?b0c1NFBNdTZlNzhUVzlpbTI0MTVrWFpQNmtXTjFPOWhjYWNqNE8vdGxlVUZS?=
 =?utf-8?B?a0xISUlLaFJxUWFlYUNTY2Z5eUlyYnNJUVQrMmV1UlpMbm4vN1luaGI5ZGg5?=
 =?utf-8?B?Q1YycGxuanlsNzJ3RnRPZ1Q1MlBxeFNJWkdKRjcxSExzd1VieXFjWGJzU3Vt?=
 =?utf-8?B?ZHBjSTdQYmpQUTB1UkpOWHp2cXZ1UWNFbWVPRGJXMnV0N3B3OEdSckZHUkMz?=
 =?utf-8?B?aWxobUh5dXRHZ1d1TlVERUdKKzhNOUtQb2pXMXRCT3JoZmhqaGRjZzFsa0Fu?=
 =?utf-8?B?VnlpVW81OGgwQnYwbGFJZDY2M1c3ak9VMlhrN2V3anZNVit2djJwaVJQd0dB?=
 =?utf-8?B?ZDhJZzdNTE5KU3hTckNFbFo1UjRPRnVrWGd0bHh1aUFORGdkMzZXQ1ovMitK?=
 =?utf-8?B?Wis5MVdyRnU0TUgvS3JRM2oxWWxSK3JwSitxR0ZEL0pvTlFtM2t1OHdCbDB0?=
 =?utf-8?B?OHg2NGpxVGRSTzZYcUI0N2NoRVdTUVVSaEE2dDU4UWg4dGhScGZwVFZ3czhY?=
 =?utf-8?B?bDIvUnBQVzNVQWNYRitBT1IwNmNzTzhNR1pxRG94RXk2QU03WVpyOENWOUc0?=
 =?utf-8?B?Z1FFQUpLLzZ3K3Raajl6N2lPUVZsTHk2Um42K295ZGxRNFpsWWV1OEk2eHRR?=
 =?utf-8?B?OG9nV3RQa2hWQUZoQmd1RHhpb3JVY0ovV1ZHR1gvOFM4eHV0dEprQVJzOXAx?=
 =?utf-8?B?WVNmaEtYQ1JBL0E2eVZ2VUdqZCt2OUd2NTBxTzltWWc1bmhINjYyQ3hHMjEz?=
 =?utf-8?B?RGxPOVpEdGIzdUxHNGJSczIxdGs4MEtmN1JRWkVocW8yZm5tNkltUldQc3dB?=
 =?utf-8?B?cFVaRytyQk9Bbk9ZbEs4WFRSMjlQSFVHbHMvQXo0K0NjWUlwT3lxVjZUTmlm?=
 =?utf-8?B?dHVLeDdXdWNGZ21Fc0pqSDYwUm1DMUd4TTF1V0luT0NUVkdmbTlDZjZHQmxF?=
 =?utf-8?B?bTNiblNCSDdFc0IrVUJzZjMxMTljT1U2emowSGd6cTc4dld4RThrcWpBaU1T?=
 =?utf-8?B?M29XeHFxK2ZrZlZFb05PWkZwWEdSdXQ1M0Y5YSt3c1RKa1BhQUYzS1p0MkFG?=
 =?utf-8?B?TWpBMWl5SFZhMVBsSzd0bjZsTUEyL0FDd3BJS1krUk8rVjNwdEhTdmdtQ1JR?=
 =?utf-8?B?S2RiUlQySWJqVFNKSjRyOEN5VTF5OEM5dnFXSm5xNzBLa0hHalBkd2lJMjZk?=
 =?utf-8?B?c3QwcitSc25aaHROakphMXJycUJTMlp1ZXMxcnZpdzNoRjBPcWh4aE1sR1dp?=
 =?utf-8?B?VEM2UHc2Tlc0MU4vamdEbFpWaFM4S25EMmlLQTVIaXdOdGw4cG5uYmN2QzUv?=
 =?utf-8?B?K1RTV1ZRWWM0N2dVeWFjaDd0WXJocWZkVERWamI3bXVLSUYvNi85Qml1WHdq?=
 =?utf-8?B?WWduTHdKTWpvNlNxT2dScmJDSWNNZzNWQUNlYU9NYTFEbm84SkdrOHhRUnd6?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f435fb-71ee-4037-eaa2-08dcc2bd0ec3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 15:14:03.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnfpLWj3YXL4dMLUcGrxMHxsonVk6ifrH0eJtPuIg8p8GTa5Aw+YCeT0nZCxcvpo+1GBsPsu29635eCmNA3XTaXAbpkJIFJGHsJHksJW08Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7408
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 20 Aug 2024 18:17:57 -0700

> On Mon, 19 Aug 2024 15:34:34 -0700 Tony Nguyen wrote:
>> + * Return: new &net_device on success, %NULL on error.
>> + */
>> +struct net_device *__libeth_netdev_alloc(u32 priv, u32 rqs, u32 sqs,
>> +					 u32 xdpsqs)
> 
> The netdev alloc / free / set num queues can be a separate patch

Ok sure.

> 
>> +MODULE_DESCRIPTION("Common Ethernet library");

I just moved this line from libeth/rx.c :D

> 
> BTW for Intel? Or you want this to be part of the core?
> I thought Intel, but you should tell us if you have broader plans.

For now it's done as a lib inside Intel folder, BUT if any other vendor
would like to use this, that would be great and then we could move it
level up or some of these APIs can go into the core.
IOW depends on users.

libie in contrary contains HW-specific code and will always be
Intel-specific.


> 
>> +	const struct libeth_netdev_priv *priv = netdev_priv(dev);	      \
>> +									      \
>> +	memset(stats, 0, sizeof(*stats));				      \
>> +	u64_stats_init(&stats->syncp);					      \
>> +									      \
>> +	mutex_init(&priv->base_##pfx##s[qid].lock);			      \
> 
> the mutex is only for writes or for reads of base too?
> mutex is a bad idea for rtnl stats

Base stats are written only on ifdown, read anytime, mutex is used
everywhere.
Hmm maybe a bad idea, what would be better, spinlock or just use
u64_sync as well?

> 
>> +/* Netlink stats. Exported fields have the same names as in the NL structs */
>> +
>> +struct libeth_stats_export {
>> +	u16	li;
>> +	u16	gi;
>> +};
>> +
>> +#define LIBETH_STATS_EXPORT(lpfx, gpfx, field) {			      \
>> +	.li = (offsetof(struct libeth_##lpfx##_stats, field) -		      \
>> +	       offsetof(struct libeth_##lpfx##_stats, raw)) /		      \
>> +	      sizeof_field(struct libeth_##lpfx##_stats, field),	      \
>> +	.gi = offsetof(struct netdev_queue_stats_##gpfx, field) /	      \
>> +	      sizeof_field(struct netdev_queue_stats_##gpfx, field)	      \
>> +}
> 
> humpf

Compression :D

> 
>> +#define LIBETH_STATS_DEFINE_EXPORT(pfx, gpfx)				      \
>> +static void								      \
>> +libeth_get_queue_stats_##gpfx(struct net_device *dev, int idx,		      \
>> +			      struct netdev_queue_stats_##gpfx *stats)	      \
>> +{									      \
>> +	const struct libeth_netdev_priv *priv = netdev_priv(dev);	      \
>> +	const struct libeth_##pfx##_stats *qs;				      \
>> +	u64 *raw = (u64 *)stats;					      \
>> +	u32 start;							      \
>> +									      \
>> +	qs = READ_ONCE(priv->live_##pfx##s[idx]);			      \
>> +	if (!qs)							      \
>> +		return;							      \
>> +									      \
>> +	do {								      \
>> +		start = u64_stats_fetch_begin(&qs->syncp);		      \
>> +									      \
>> +		libeth_stats_foreach_export(pfx, exp)			      \
>> +			raw[exp->gi] = u64_stats_read(&qs->raw[exp->li]);     \
>> +	} while (u64_stats_fetch_retry(&qs->syncp, start));		      \
>> +}									      \
> 
> ugh. Please no

So you mean just open-code reads/writes per each field than to compress
it that way? Sure, that would be no problem. Object code doesn't even
change (my first approach was per-field).

> 
>> +									      \
>> +static void								      \
>> +libeth_get_##pfx##_base_stats(const struct net_device *dev,		      \
>> +			      struct netdev_queue_stats_##gpfx *stats)	      \
>> +{									      \
>> +	const struct libeth_netdev_priv *priv = netdev_priv(dev);	      \
>> +	u64 *raw = (u64 *)stats;					      \
>> +									      \
>> +	memset(stats, 0, sizeof(*(stats)));				      \
> 
> Have you read the docs for any of the recent stats APIs?

You mean to leave 0xffs for unsupported fields?

> 
> Nack. Just implement the APIs in the driver, this does not seem like 
> a sane starting point _at all_. You're going to waste more time coming
> up with such abstraction than you'd save implementing it for 10 drivers.

I believe this nack is for generic Netlink stats, not the whole, right?
In general, I wasn't sure about whether it would be better to leave
Netlink stats per driver or write it in libeth, so I wanted to see
opinions of others. I'm fine with either way.

Thanks,
Olek

