Return-Path: <netdev+bounces-193856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36659AC6102
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 06:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0564A1133
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 04:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B73A1F37D3;
	Wed, 28 May 2025 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgdWbc4w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA31F17EB
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 04:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748408320; cv=fail; b=dbjGuDiPoqtxxAJ5bkQS3amFCerzr5z4naTPanxSW7+k4ChOENu8WU0ck9/U68p7mb6vZLpZXRANs5O8GWcgMOsq6m81b6z+DlNcwTjN0i1jPL/aE0wiqOI1HNfMMVlq9bkRfeLHbFnUuW9UZsL3bf+v7xiZtl0Ujg4X4NvJiQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748408320; c=relaxed/simple;
	bh=Xx4CnBdcw8iCT7R1hMg3on+wpOC84poI4fqdirT38wY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MoK3/0t0Bo61BhfHbfy4furc5seZaqmLTgj8PoAI69rr66TjsObsVSX+pCakuzQZ7/NTHX6nZFGeTFSZssuxgFmPvr2JeWCJJmKvoWY9eVWQDh8B6jYgdFfbrrFTos4hxlTMVzU4dSCQZAjogDntsB+gZBq0rkqAvlJUnk76uNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgdWbc4w; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748408319; x=1779944319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xx4CnBdcw8iCT7R1hMg3on+wpOC84poI4fqdirT38wY=;
  b=AgdWbc4wkUdAUcbOpQ8LxQbp3jlSBS/2qag7Y0fh/0tZHtQQJ3H3nPEI
   Q0nZnf5kQxqbXAwS46zTZxm+tKQkF2VAIzNdDIPjDgsC+CeOcNH7nczLM
   L3fX4G7ASlbAgry/pf5CvuE90LoV4oRSKxIdfxBiEq1WnXYSXOoQT/E72
   4OB8k1lvydmJpD4URwvzzhCA3idGsq6Eva0dpaN5u/JkpR879Ww8yXabG
   VVG8k/N9wF2DEqWRAbvSEePKu9rsPzyosFDfgm2wQ0s3FiQrRQRKn00QW
   c1w84kBS6U8REqJ7C+1KPDhflk961ZT2x2gnh1pMfBxEispG0orAnoCRG
   g==;
X-CSE-ConnectionGUID: lzwZ1gGxQUacQWALq/+tqg==
X-CSE-MsgGUID: yY7ziaA/SJmxdkWfsFeyYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67832012"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="67832012"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 21:58:38 -0700
X-CSE-ConnectionGUID: g4VekcKeQDik3atPebEGcQ==
X-CSE-MsgGUID: apzph6R1QiSD9ZoOtAPYjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="143146004"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 21:58:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 21:58:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 21:58:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.88) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 21:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9UYQYEi3t/VEqrykG35csmIWK5DWCPeX8OHPnGQ7slbcUnpY0X9X4ZQ4OEJZp2hzyCyblqdthNb0abMRSPDqGONu454NjFeOtafFm0CtOWpVNrMb1frg/CZuIpqqIsrlqX1ynIL90+6kuk7VdD4ddf+x5HpLYJXeKY+qUa4s9wwJGzwjr4941TbF+5Aw+14KTrAyB5VJiYoTCxuEK28rZjCPYCyvMEK9I2fIE3RLmmLJY6ff8oLl1FtWBBHQIU3LP+CDoNsUl7w2cNJUl9lMn71OR16wKFzvZKPeawByQFunqMEE1S/eyEQMFd7tIc6tQuHXL06sjpdYn4zZN/rfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8+kW+/Bt0/soxXXuAPku9RgjVDvewuuk+4ZWl/0oho=;
 b=B6QeY817Ew/UkZCQDzLEQ5AYm8Gwrg/ol8OygFsL+mYLQO2ECpobVrZ11i0ctH6MFYnUq2O1kRZdZYwyzAxqUgHIHacRxNvO4zSkOc1057ZZBMLKKg9lhScUivqoLJcN0wBkbXbbnZtcJfwuDzhFmH0M/aQmGGLw7HRTaC3XU4NN+ox2FMsanepPLyEeVbzuBcGt6dKCK5EsTDAqKKskgVbfBTfLnJuyftkVJ9OdbvIlbn/XVRb5Wql+c577gEJmTIF6tUyV0xC6BWAcn8yVnXP8BX6VwjzSWTaeMhM5cblY33NovtIUFtHqH330fXmbnh8L9G/jpVfTXoHkeFrI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7186.namprd11.prod.outlook.com (2603:10b6:208:442::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 04:57:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 04:57:46 +0000
Date: Wed, 28 May 2025 12:57:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [selftests]  59dd07db92:
 kernel-selftests.drivers/net.queues.py.fail
Message-ID: <202505281004.6c3d0188-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: b5af1fb7-8e1f-4cd4-3f07-08dd9da43001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MV29JiL/LkTgt1wOyK9BW8ALq5CymSB01OLIpMz7induu3tYLnEO6OVB4c2W?=
 =?us-ascii?Q?LG30c+yFw1HLPoR9eyPxt1TSgg0+vtrWJbFSzBLtuHtoJ+nRewMWih65QCN1?=
 =?us-ascii?Q?BdCbXzuIkprn2K8kr5gNvsQ0lHlZw5tcSFagDJtQEm9bWaxSAJ1SEV18s1s+?=
 =?us-ascii?Q?kc1SLCgFV8trlPn+pXa+ncDFIOvIgP07mwDYLpozpd5Wc1ceF9LBZQ0abnif?=
 =?us-ascii?Q?Kmhqrd9WkKa6px+72g/gePa2KwmDZGG5EKExJPTACubZKTPpgMDsf8xtrwru?=
 =?us-ascii?Q?xRuQJe84Z8l0Y4SKEbeJgst/LElWbf0g8gZWM1XFJurzLZUwvBmgpQhb95AA?=
 =?us-ascii?Q?HWk/75WJCCxefBcMEa05E2veI2jIszlCBjUSJeXaSfmvpOKhO7Y3KU5EoefQ?=
 =?us-ascii?Q?7u0pGfpNarENsQ2k5D+zrC/EMyNC4IMZttWRKBIRMmAdY/fGaKX3BB5TTd7E?=
 =?us-ascii?Q?zDqGYvX6833KRVeXllWeEZjveNZoD9ErcqXLv5TyY8bXIIUmNIXcGegIbzhx?=
 =?us-ascii?Q?KcJJSik0nHAgMK0/HiI5M+DG7HNdrSnvj/q/TRZ78aADoPjhDOcn/kHORFeV?=
 =?us-ascii?Q?Y6hF5flJ15463tt1EOoK8+J/ouFkiKpxDxdUzNHNzDFU1JNSgeKg7Uz7myXP?=
 =?us-ascii?Q?CEBxxqplP/N5665gve91S7G//nWeNGOzamFKxf4Pr1sfyt8+o5N6h033F8YS?=
 =?us-ascii?Q?Yz9KJ8GyRsfdB8lrHlnJSBKH5wVYN0iY8V/ypyMHjJKf+2hQGfiInxUAge/1?=
 =?us-ascii?Q?YH0ljKUW4SjtoH+DADAjesdMh9xoEf2++hU1DNF29yzu+Ykf7SaNPSXfNAhW?=
 =?us-ascii?Q?iijxKeRgw3srC7mogbX2JiBvoq0XLIPlS2Bx9N/pKXIegCg9IPFkVaNDl4vB?=
 =?us-ascii?Q?XnVVkywUgs8MHXvgwgQDYYanXBJIVITBVuwuaE3tE1z/f00OEhDN2NWY0SqP?=
 =?us-ascii?Q?zAR+P8/DPYOKo9lLHPl8wem+xRL5n0daunz7uYan0bnPQa+rF/dURr7GR2mR?=
 =?us-ascii?Q?YVuXFTmJXpxS9e1gMSFZOjesDUPBHe3oYPvHH4sQtIN/9WfDWjjJCKbdxvRt?=
 =?us-ascii?Q?xsGRBHyiGughRHaH9c9o0yNnePb4NB0WwF1VUDYTz8NVgfdVpv0GSnKxZ9YY?=
 =?us-ascii?Q?qDMCK+wU8Qtu+u1GwCeQG7idyuwZZdhndWAxeq6DJdhR6Z5SM+1M02EToHvz?=
 =?us-ascii?Q?U+dkrh5QkLD4e372DOFW1jWixWYdGunUV9yguVhn0YDVhBitEmVceABuK550?=
 =?us-ascii?Q?pd32wU9VARNVbUXQjG5p0zz44sFj5EVoHvyqxEu0ooaWayeObS8LvS2nng5V?=
 =?us-ascii?Q?H2Q1YuEiULTUxgn2u7OAYoxbaeCKfLUU4KrYLevhNZIvAusj10vbUI0o/6o+?=
 =?us-ascii?Q?c2Go86yzawBhVUMZNFsYYZp/LI4q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUeltGIqiuMEASRZj4zc8Ep+7nYzXLr6JhXCWPwNr+HSFftDNdmsNr3kl2tj?=
 =?us-ascii?Q?nPLBXVr8yaHK6X/rwmcPdkqI3DxOjNzViqyIgEQDawI/bF53ZzGsLyAeZB5t?=
 =?us-ascii?Q?Eb2wqhkRfQ/9qQf/oz6NOuPRmv50O+V1HKXOVWDJ8O2AyNZ/rp6nNC1L7ER5?=
 =?us-ascii?Q?BsmHYjbCCxfP1bYt1klttkXdmvMSqpLZUycWscGDxbXqSTxHwyG250z6+0vO?=
 =?us-ascii?Q?VQOx41uEZedbS/Td2iELTG7CI/nifqo3kd7NF4gYb5FDZnK2MiewrzbdjKCW?=
 =?us-ascii?Q?EYpPmzP86WembW0p3asY0DsSXFR0di3DADuN8lNq0P75SjxzmSgI1zcZtbGB?=
 =?us-ascii?Q?s8qYR4gdchP4YYMAwJIytyYI/HTAwsVUsBQxupF690EslrpQ2WWVzKO9gljU?=
 =?us-ascii?Q?VTEcQr4wWC/s0MAGfpdZ1o3cX7rxDNgCHgpmhF8nzzKMUKTWeCzXHpIv9pFQ?=
 =?us-ascii?Q?ZMgdBOPXGm226rxTdUO8jrDKFiIedOR/LmzeJeFviwMrPuRod5Yorv4MlhKb?=
 =?us-ascii?Q?BjRQj1J02wzrvDvJek/KFqPwpTakHzGC7RGv2TdkKiEmVVe577JSVW6ugj/U?=
 =?us-ascii?Q?/hA4zWPA3HbFPvGMZAvs/UFjqV6PN9N/dkAPgCLxE+E08pTf1PHz/CH3UVkz?=
 =?us-ascii?Q?t0xH40VIfJ679gb5WvWdXTklnZ3VM5xWu0XB0qjwppSrGFXxChmgK1kEJj6B?=
 =?us-ascii?Q?kRmok+2+6qyNmk89dnTN/HH4XNPCD7yV/27POM8MqXHKB8IwpTuV1D9dYjoo?=
 =?us-ascii?Q?4nJeO37MbLm1stAsfphI/MUIC/g+7covupx0q+kc2NWulnSmoiPt13sE6HLQ?=
 =?us-ascii?Q?MCQF6dcyHirPjZDjRu+dmUJ8I/HqWPuVNPejfjAFhTqluQa4+1RUuJjouNJ+?=
 =?us-ascii?Q?wD1pq+h4NfjcGwEjfmvBB9QzdKOks49ZpG6+m7kHAmWhGiNUO9ehw6I+TbBU?=
 =?us-ascii?Q?oNTYb1rPKJ8WxaT2e9CrWFf1wEtJ7+lL5eB1oZt35/yo7JQXSoojNcjOhoI+?=
 =?us-ascii?Q?Q90D3b/GXRP1njlqndBTosG8Kreske5LW9aBqfV2zhFbddU58nY7qvkXj6U1?=
 =?us-ascii?Q?JbQCwpfsfKChriNdlWCZk+xiZtVjGviu4GQ7RPLjw8D3/JyF8kh4VO3G9/qT?=
 =?us-ascii?Q?37BXj9/Oa2QSssSadHs9eFnnYhHxr+UnxuSWJo//pSpJlBgf24ZSG14+SPS8?=
 =?us-ascii?Q?z+UL9fYL03XglZfw3flv23H8iHS+83ojBKqmkJZuqr04yf6sOgO702ESbznN?=
 =?us-ascii?Q?MGz1tBY6Bu2vVxzGlsE29DnJupVyrssdrb29U+WM0znZEvJxeLuSkpz4Z52A?=
 =?us-ascii?Q?pT3FmRmjcJoLg6aHRy2Uftu7hwq0ovmNGyePZx7g1MKwap+cdw5cf4eKnRvk?=
 =?us-ascii?Q?nY8lbJ68pRmRaBO4ODW2aGJAY4vioOGyd+qIUsUDOk6WaPnYZieDa9jOyCzb?=
 =?us-ascii?Q?Yq213KMgxOdVrnUoOt4LTKo4GcLsCs8bZxs4ZcXwvum6ZyPu1jotxuYqHMzX?=
 =?us-ascii?Q?GsDXUQol9JeqBKYDYCO0AZPuSddPgK3MStO3M4ru9ECysD2Gf9OLD8nEisj8?=
 =?us-ascii?Q?e04d60TTJjR8QjJadtqdAVSedTB9BnUPM75ZDiHyKHLZpxXaNGeOq1VsP4Mo?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5af1fb7-8e1f-4cd4-3f07-08dd9da43001
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:57:46.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qT+REgcvuI/uHeuXBzbBv0S2RFRl0UmyAY6Tw7vI33A4ECur1AECYiV28pe9SxXbpIwV9+8P/rSkOzq5cKs2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7186
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.drivers/net.queues.py.fail" on:

commit: 59dd07db92c166ca3947d2a1bf548d57b7f03316 ("selftests: net: move xdp_helper to net/lib")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 176e917e010cb7dcc605f11d2bc33f304292482b]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
with following parameters:

	group: drivers



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505281004.6c3d0188-lkp@intel.com



# timeout set to 300
# selftests: drivers/net: queues.py
# TAP version 13
# 1..4
# ok 1 queues.get_queues
# ok 2 queues.addremove_queues
# ok 3 queues.check_down
# # Exception| Traceback (most recent call last):
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
# # Exception|     case(*args)
# # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/drivers/net/./queues.py", line 33, in check_xsk
# # Exception|     raise KsftFailEx('unable to create AF_XDP socket')
# # Exception| net.lib.py.ksft.KsftFailEx: unable to create AF_XDP socket
# not ok 4 queues.check_xsk
# # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 7 selftests: drivers/net: queues.py # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250528/202505281004.6c3d0188-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


