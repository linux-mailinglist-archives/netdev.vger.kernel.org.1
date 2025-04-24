Return-Path: <netdev+bounces-185651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A034A9B339
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652AE17DF71
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93391A4F2F;
	Thu, 24 Apr 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8CGMk/M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332731624C5
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510455; cv=fail; b=YNtvsLx3FGCDWAX5CaSoOq8hD7z38NmwMjK+oa5n70K1wy+rGMzTrv+ZV5OnwylotVQwycXTUbBDZPa9R4naRONgmXBh0IFT2s9ZzIvg5SEYihVbdjQBx9fywJSz8um9EPqwOA+ks2HbffUYUwkzgeCvPpZGwEhR3afPG5Qd4eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510455; c=relaxed/simple;
	bh=ziDoqKGGYJmQKthYHnK3tdShwoxuqYCbsdUHsRQIYb8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SewrwYgzh8/7sVuq1RKcGdBvGf9H21K/DpZt3wPZpX0rcF8qy3bg9phcjfr9fjtHJZy2odziCWQi5GHv/wzkLoq1sFWDMVLExER1c6ZOYQNzutG6eAQKgHCj3OWjlT935KV2NojCFlF8n+MQYbg4qiudqJYv+91DFNqqG87uEAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8CGMk/M; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745510454; x=1777046454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ziDoqKGGYJmQKthYHnK3tdShwoxuqYCbsdUHsRQIYb8=;
  b=f8CGMk/MHGsruDyc2hHsrNfRqORiEKw/5GYesNlZXeYk9edGcyhH32uC
   sOfmPv92WzYssY8I6UWnyrCCIl0+i51gdlNMK2lKotYnjp7AHgwtB1BOg
   6jidgshycuIhkfgtUOV1IaHtLhPMwzvpxLNWd39YlCUgfpdpyj/wxUSjR
   fRiwfezaFANe6Gk8nxvwvbEQgytfmsZmbyQoyHUfLK7B63hz5USBXGZZz
   MlJ4di0fDNL1pNtHGgxhkjrVABGixkizPe3GkYymEqCbRKGo2RQlPfxQv
   zy3EiX9vF+uBFFNHawUCNvEi8oVKqpXnNDFRuvMyYwpYgJxBa40+2P+OR
   Q==;
X-CSE-ConnectionGUID: dyn9DQ7zQ3m3oNgB1xqNaw==
X-CSE-MsgGUID: 8c8+GsmFTwe/vrllIYYZPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47028736"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47028736"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 09:00:53 -0700
X-CSE-ConnectionGUID: ifutCMlgQRKmcgqt4MLEZA==
X-CSE-MsgGUID: Mi91Mj/mSOeIbqOkX1s8gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132571202"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 09:00:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 09:00:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 09:00:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 09:00:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr/YkhLJH79/M0mF0rEF0UcxkCPrYq3MqOtOx0JlPZw1VjA9t7mGszVUMc9XPSirwUcsfURvNlOVwz+7BUnQEsRPdFPExAB8qDtVC8zBqrlobItWnnCNA91QzAW0BAIp3z8utSyH66GzjAuNCSzc34aFQxciUjV2IyLnbdu2qGWp3sXb9lBQD3HJAHcEJU6tsiBZiz+GtmTJbBj26DFZGxHjSna0lv+dyeoQS4YF1LX7Q2CF+ONdA7TwSsDOx9SId/Q54fuqauISUg3avK9zOQKQ5aC3DpUzMZ+aDVP/Zfiz4S5kq3uG4N+xTJEA7IE7SDcLpP09lM0hXKI41kTqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoIV0QkR7g+OUEqXQzNYOCgJYV63QOhomdX2wVYSMhg=;
 b=cBAVFKhmlcMhsIyzGAM64FYPUGkPhjDONw/2EHA6k04jp9i/OgR92GRlIbNn9G72imwl42hluBF4dO3r4taY7hpN+6CNrfjq3ibRQ7Py6iFK5je37VFEgLgsgdJ3l9Lp1cIZxk76kRHbmdstyWUciH5TCjp+v20RGjY/VMH26dWx9BlkHyx+vOjTRfS8aOZKhV+gbRxysSvfu6KpIfcuO1wzl79glVxcdpSU2dlKJFPgsZkogELvXk6XZ88pvZT61wialgkB7NbXT2I0QUVEHBbDMcqQOs7vC+LIhpM1S/XYIgEgNq4oddn2BEAbr8CMd9isO1kjfIQUW3kMdEk09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by PH7PR11MB6652.namprd11.prod.outlook.com (2603:10b6:510:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 16:00:29 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 16:00:29 +0000
Message-ID: <219c5575-5e9f-4d4a-8d88-24411d21ada3@intel.com>
Date: Thu, 24 Apr 2025 09:00:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/12] tools: ynl: allow fixed-header to be
 specified per op
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-13-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-13-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:303:16d::29) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|PH7PR11MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 242725d8-5c2f-4411-0d2e-08dd8349223d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmNYTlo4N1dOaENONFF3MklqVStFSUEvZHI2bmNMN2F5OWZSSzlwTFUrU1lS?=
 =?utf-8?B?dldvdzUwYmJzRnZCTTcyT0x2MGZUZTZhWFFOTUpFS0tPWXBOekFpWVpyNU1p?=
 =?utf-8?B?MUJ1ZHpxTGttcmdaUmpjR2E2eWw2aGFmaWcrRHJWSW92TTNKdkQ2SDloL1Bq?=
 =?utf-8?B?TEFxMkVsOWJTbnFqZC85WnkwS0RSUVd2VjFvcDRkekQzS2JhTTJ0UCtHNExa?=
 =?utf-8?B?YmdOUHF5c3Jyb3J3N0MxdzR1bnEzM09HVTF5SmVSZGx6dS90SU9vWWdXRGlp?=
 =?utf-8?B?bUMxNTRHM1ltOCszTlltZ25OYUphVzFEZ0NKZkt5NzE0Q28zZGhrWU9QMDZQ?=
 =?utf-8?B?ZXFFb1ZSOTFZZ21vUENCQktJaWdSeVNOMHA0ZzQ4UGs0bGYxZjdzaHJEc1N6?=
 =?utf-8?B?aWF1MVRwTTU1R2pOUktIbzgvR2hpRmMwTC9TMldzdDBwWnFnYWdkaEF3VGJw?=
 =?utf-8?B?UDVUMDNjYmlUSk1sVVZhSEdGS3FtZ21pQWRjZU5kblJvMTdJc2NEK3czbFBP?=
 =?utf-8?B?OTZUS3pZMFNiMzhlZGhScWhmaFNmVmVPNjZtMWp0aEFXWWp3bDkzNWJuRCsr?=
 =?utf-8?B?cGhrdW5NVDhrSy9GY05yZ0MzRVlOWE94Ums2U1FJK2pmR252dUxMKzNiY0hC?=
 =?utf-8?B?c3FpRzFzdmJHRitiTDR2T2lzcWpKMW5MM2ZPbkhXeE5QY2dpTkdaYjNrQTRi?=
 =?utf-8?B?OHN3Y3FnRTZ4WFdXSnhYaTBwTUVqTjg3ZjZzNFowNGk3K1JEaGs4Mmp0WFVI?=
 =?utf-8?B?R05OZTExWm8rZS8zNkVvRFZqSlhXakkxTVFNdjJLRlJoUEFTazhpeTIzYjhD?=
 =?utf-8?B?RHpJbWswb21XTldkYTh0V0l4Y001aXN2SzdOL0RtNmttRmxXQkx6QStoWW1O?=
 =?utf-8?B?WHJpK2s2ZThCSFFpTnI0NXpwdVlScDZJTkJ0UHU1SURONzJiSFFRcUNINjZm?=
 =?utf-8?B?cGVySjNsVU9XemRTNVVLUGxCWUFTZXdkZkF0bzFUamFudnUxajJ1bUN0aW1v?=
 =?utf-8?B?dkxoSGl2eE40aFFQZmhmeUEyM2xpeVdVekpCV1pQTk5IZnJQcWtTK2dYcmJh?=
 =?utf-8?B?Z2tidXZSWk1PUWJtL1ppaEw4dFB2NTRkdmNYdEg1cCtCYTk1Q3Z2QU1QU0lw?=
 =?utf-8?B?azZvcjVHc2RsUGd0ZDhpWVJ5Q3RSbGVRZXJLVVVneWxBQlF1bEJLQVIxOG10?=
 =?utf-8?B?MnA2cFUyOVJzSEM1ZFovNVBTTUlXRXdJeVJsb1dBSitUc29GSUdXOU5SdU9E?=
 =?utf-8?B?N3Z5dFZ3ZkMyZ0oyWkpLWW5rSkxMREV5ZlhGUmhVQStkMloreWNLdWZ4MWRX?=
 =?utf-8?B?NWJ3UEJHWDdVeW5HWnYxVGlNam4rSDNLb252MGRLYzFxMVpBSHZkcW5VeGds?=
 =?utf-8?B?ZWJuVEFCRVBia2dIUzE5cGpkMitNQlVSTW5LVldWUWM3YjdrMjFYWXdtMlJ2?=
 =?utf-8?B?V3hrUE4wRUJrQW1sRk1jV3BGM0NEVzZ5SDh3OGlzbmg2YzE4UHFPMzUzenVw?=
 =?utf-8?B?MkFFN0ZEdi81SStSQllzM2N3ZTNxeE1ZWUJ3U1NQWkRsN1VmRWh2Wm1aMnJH?=
 =?utf-8?B?MTVjMWd4NDhFZXo3dVd4dUV0Y2d2RUhPVHlYMnRrZURaQmRMbGt0VWxXSCtJ?=
 =?utf-8?B?RXJSQnVDL2J3ZjloRUVvOWtjZWVQZGhiMWNIYUdIRTRROEY2WGhYVzFncXRH?=
 =?utf-8?B?VXJOcjdxMHFTc3YrSFV4a1dZdy9ER0lDa0w5ZDgvMyszZU50dlRVakppdlVv?=
 =?utf-8?B?YWJQVU9rTGNmUk5WLzZCMnlvdFdlQlR4VlBTQnkweVZscWtmb2JrZ29FTXR1?=
 =?utf-8?B?UlVNZWJnWk1ZajdkWDVjY2tLdnF2SHRLRFMvekRMRzZTay8rUlhCYmIxTnY4?=
 =?utf-8?B?d1IzSzVtK3p4UTNNdlVhTUxSSnVWa0dGM0RHQll1emRyNjMvQWtncTVHcnZq?=
 =?utf-8?Q?vxQGSWg3704=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0NkK1pBWTVJNHJ5SDIzV0hjRmFtdmdGSTEvQytITmQvNTdBUWlTYzh0Njhw?=
 =?utf-8?B?VERkWVQ4dW1iNXZnd1EvRnpOSVgzVTZraTdmems0OUtydHl5d0JBZXV4RXhP?=
 =?utf-8?B?dmJMUUpFd1VORmpneGdIUjRaczZDNDIvUFF5YlUxOUlHSWM0VUlScmJJaUVI?=
 =?utf-8?B?dzNNTmdsbFIwOXZPMm5rZzM1TEZzM3hYRHhPUk8rY042YU1SWUxpcXNiSTV3?=
 =?utf-8?B?cHdVaXo5TXJFTTZtSXJlVzl3dmJ5bmpOamZJcDlZYWhWdmRrNHV5VmhpYzhR?=
 =?utf-8?B?eDByVGtBb0x6V3dKVnJNUFl0NytydkdJT1kzQzhWVHBUQzNYNjVKeEtKTDM2?=
 =?utf-8?B?dTk4WFJJN2NrWG5YZGl2Y1p0bVIzTGR0dXJCQ0o2VVp5RGZkQjhBdi9KZDh2?=
 =?utf-8?B?c0RQWC9hSWdKMS9uUzJvSldDOU0vcnQveXZtem9TR1pObHZycE9YaUsyalJa?=
 =?utf-8?B?WW84VkdrdzdFMDlzVHZmYmJNd2kreDRpMWo3VTFBaGxiUVN1WDBERG1IK3Zi?=
 =?utf-8?B?cThxeHRsWTdBb2NvM1BEek52WlNDNW9lbm91RnY3Z05ZOGJ1bWRRZ2tvMTV5?=
 =?utf-8?B?ei9JN2F3VUN6QkJpUVlsM2tGalpHNkp5VTlDYkUxbkhnQU4wRkYyYlMyRWJL?=
 =?utf-8?B?REFIMGFGeC9xS241V25GQUgwWnhaOTErdGFucnZyMGxOSUxNZmF6bDFTYjJ1?=
 =?utf-8?B?YjJxd2FDSEJ2RHR1MDY3RkQyMkQ4TzF2TGs1K2RoVTcydjVoNFpwOEdUUXpP?=
 =?utf-8?B?VUZBU0hSUlJNVWpwQ1NMdUMvSDExM2d5ejdhb1lDN2R5OWlVaU9EaCs5UFNJ?=
 =?utf-8?B?N1o1U1lRY2R0NU90MUZWTVJIYlJBN0VrM3pYcElreElic0hVZVhKYzRmUXAw?=
 =?utf-8?B?QStESTVaOTJHV0tEVG5uY0twdnVibjlsN2ROSDNMa3BVdnBmRXo0T3N6YmpE?=
 =?utf-8?B?NVJSL0NOTFh0aEJMeUlqdlA3NG1vUUlNa1dTQWxmTkFpRlVDM0lmRU40VVZK?=
 =?utf-8?B?QTFlV3pOZ1FzNFhVbWZ2RnJuWW9rbXVtczBaL2NuZ05QV2xRMHNqYms0b3Yy?=
 =?utf-8?B?M3l5VWVGYTNZZG1qSkpzSVYvOTYwRTE1N29EVHpnazE3ZklHMDBUbmNCNmlV?=
 =?utf-8?B?SE42U0ZMdFh2ZXgvZGozRU5BTiswcGpOQzNBMXQyMWpzSHM2YTdVMDBQency?=
 =?utf-8?B?a29OSi9qc3FMSUVyeFhoQXk0U2NtU1dBMGRqMmNnN2NBNXhlWE1jcDk1MHVr?=
 =?utf-8?B?M3YvSWdzMXE3elNkMlNFT2FqdUVueTNJNUMxY2xLTWxtNSt6bW1ldjdwblV3?=
 =?utf-8?B?Yy9pUWVhTUNDNlovbGR1WDFOMkxSSU1UWDF0Zm5KRUh3VnJwR3NjdEltVGVv?=
 =?utf-8?B?RWhuRXVCQk1HbW9xK0xoN3FJVWJUem1hNUJzaXQ4RDU5SFBYaXJjSWRjTGY1?=
 =?utf-8?B?QUV1N3I3Wmh1WmU4eXZReUZxSkN3VHQxaW9sWmJOblRac21wSXI2QjFzSWVr?=
 =?utf-8?B?U2FNUlp6dDF1SzBCd2JUR1NRb3NEaFlxbExOampsSXJGd1dyQm1DVmk3ZkpZ?=
 =?utf-8?B?OFRMKzhUMW1QK3YyOGJWR3JVckxaMlhQVlJTOXk3OWEyMXVlRkVxV0IwK1pO?=
 =?utf-8?B?VkkvTkdVdklTOXJWd29udzdvVWFPeWdvLzNOdFZLY0RnN3hCeG02SzI1L2pk?=
 =?utf-8?B?WnZQV3lDakxGWHFCS29aalVMMHppZVdjZTdCV1JGYjcvaFIrdTlaSXZSTmNQ?=
 =?utf-8?B?Ky82aWhrQVpqNzlta290ZmtMeDZuQ0tCZ053aC92OHcyYU13R05YY29qOW1B?=
 =?utf-8?B?Tm5hSmlCZHhqcEdXYWRFaE05M0o2cDB1SyswYzkyRStZLzcwNVlDQU1hcCty?=
 =?utf-8?B?T1ZRMU1RTWdtVElxYWJmb2pNdEdBUkpMWm5xcjR4S1dsZUFvUFF3TG1adkpE?=
 =?utf-8?B?WVJsZHUyMndobWJBNjZ5OWtnd0FNcTdGMWZKYjNrQWd1ZzkvaXpmcnhXUkZm?=
 =?utf-8?B?WXAvZEdpWmd5TDhiM0lnRzRRTVBxMmNqUzhLQ01tcjlzYXZlN0JYQ3hEb3BZ?=
 =?utf-8?B?K3ZaeTl4SEN2WkxiNm85bytvNVMrM2d5eVRjVGduZjhEVlR1Y2tIbk80MzM4?=
 =?utf-8?B?WE1ING5RNjFhZWpMbEcwdFZrcUp3Vzk0T1VCVXpFeUUrSTdtL3pqRzkwSUN1?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 242725d8-5c2f-4411-0d2e-08dd8349223d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 16:00:28.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnNTSx1eMjNnhQu0J4th+9dVOkRHBCLlqq2wsHEDTiXfqqo/FIWdku0jUx/6FngI/FRlZU/6WZ5ltx0VTOOaxu4T0JT43gUBfNxkmkUFhww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6652
X-OriginatorOrg: intel.com



On 4/23/2025 7:12 PM, Jakub Kicinski wrote:
> rtnetlink has variety of ops with different fixed headers.
> Detect that op fixed header is not the same as family one,
> and use sizeof() directly. For reverse parsing we need to
> pass the fixed header len along the policy (in the socket
> state).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

