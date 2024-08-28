Return-Path: <netdev+bounces-122945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE14E9633DD
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF75B2252F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E58E1ACDE6;
	Wed, 28 Aug 2024 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/wa+4JA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBCA15A858;
	Wed, 28 Aug 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880594; cv=fail; b=uEmwsAj4a2eHHudoLCssSqmBTutF7Ss07yR+Nnx8XrAal81xSECPogOi7qDIku8ckme5hh9b5o+Ay3b5upewsl/f7SR8n0xhZr7JDZENHB1NBFpRRElBLRh+Sek45QwzrbC5WJYHSFlBZV+wOsWYJgK8zx13SSzq2puCowlKIkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880594; c=relaxed/simple;
	bh=hInBx4prHFKimx6uBwsjAg6OpDUXPmnp6/k4QWJ2sPw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=am96Wt6y7I6OPQhHrxF85uHRTw6viFTWGbpuVSZVD3iRfMJCtU2Wo/brwJ/wG35TCGH+OzaA8gXOvvyJN5LolZi4G1gNbsojaoRAZeOI9MD1afsUKfDsrng4tZy6lheqJSuNxjRj5z4SzyhkHcOnAzBXfMxDlaQo8y1dGQ8KT30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/wa+4JA; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724880593; x=1756416593;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hInBx4prHFKimx6uBwsjAg6OpDUXPmnp6/k4QWJ2sPw=;
  b=C/wa+4JAOJ5x2IHE8Lwn9v+foyAAEjavQQ42ns1YSiL4VqelD6A5XxXa
   MR2Lmeu9iYN6J6CangkkjnUmXEpA1zLLyNMX6j/R4sro619P/P/GKnTMV
   jKIh12P7Kjk/oTMlRaKDV5IjIhx8rZNxSBHKjC4AkkSmIBhoEl0SKDmzH
   0R1B18BR7seo3rxQA3RV6YrsvvHf4/9VDbS8B+mLKGqbvpJAVhhBWb3ax
   0VEpwplRDEudv4G1RufBKBtocArdOKgQeTUYUso15Q5BObImMlx3r2HaQ
   zFpWvwS2C6EAGkviQ3R8BXpiWdMWOs9cuHpCp+YhRGpP0Pi8vxDnRVgdO
   g==;
X-CSE-ConnectionGUID: BqXoYKoTTrWjizJcWGFEtQ==
X-CSE-MsgGUID: TK4GepwcRA63P+Tmjg2WHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="40918160"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="40918160"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 14:29:52 -0700
X-CSE-ConnectionGUID: GVKoLHPMQDq615dprR6DZQ==
X-CSE-MsgGUID: 9/yhEqkcR+2kQjPUOFGkTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="94088207"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 14:29:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 14:29:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 14:29:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 14:29:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 14:29:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfoeZGpv6nRDx6Yw0uAHQd/CI/xZ2Wl+cpbgAQwsjYVwhs9eY5qomvkipJwApyHbxSl2uR9/+CQCoryFOz9fZzoGORLZVyVhQ0ZHAMBXl9EQFWt+aswK1Gev6jiUaIENFm4CkkDx8LpRAY65LNS6lxOHTQJ2VvFvF3q1vrLhaP4Fl9kVTFSOfTH2TDhSpzIQuS8vgU0p0Gu/f6rI8RTYWHdxjq357x7RGFNgELEmeuwN4xojzVopaidg6Bfc4ihYPw/3+J7dbF5AzMGx9Dwz0lp20cbzmxq8nXRgbFKdhqE5Rk10AfMb5UMA3JH8m2ecPq8gxi3APP9827sjdVld6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59g384//y+99IDQjIFEXoaL7+lV0CXjqHTLEHmW0Nx0=;
 b=P/4nh/kkIP74pj9bZWCkFCbyCv4h6NujaiOfX+r4Fs2gT1k3UVe4o8VGz0i/jcLHBO2OF/KIxAOk/liOrg8147eywHaCACnccEEVAAp7QCWagB3G1sqGwKtXh09gpF1Y0y/Wmf3dhbQKotl0vRkTPI+bQj5iySDAHiFfx6N/XGZiZiil+bdemWbyYDP79rnStvZ9QvmgFGq8sxeBzrtGoNz7LxhK3kKDM6DiGa8dkgn8ONvAi3K3ND/81O/h6nb0xJgHvRLLtivMfjXZlWg/saZWBaW7AT+oesLLZJW779jwBujHKdlF34Nsvi9fPjTcUfmeZadb7s7SWcY/V+gFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 21:29:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 21:29:48 +0000
Message-ID: <e2fce229-34b3-4877-8019-63dd3cad001d@intel.com>
Date: Wed, 28 Aug 2024 14:29:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [[PATCH v2 iwl-next] v2 2/4] idpf: Acquire the
 lock before accessing the xn->salt
To: Manoj Vishwanathan <manojvishy@google.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<google-lan-reviews@googlegroups.com>
References: <20240826181032.3042222-1-manojvishy@google.com>
 <20240826181032.3042222-3-manojvishy@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240826181032.3042222-3-manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:303:dc::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: a6727b0a-3b8b-43a9-5edf-08dcc7a88ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnNoeXFmYkFRTkp1L1YwVkwvV0M5WXFacW1uRHlyQjZLQmlaSVM2c3B0aUxa?=
 =?utf-8?B?SHdoUldXSkROODAzais1eVNzWXFzbXRkbDV0ZUtnaUtmRjVzTGt3VTV5MFp0?=
 =?utf-8?B?bmhiN1crVGpkRXg4aWw4dnhoS0dLYi96Y2JaNmlMaEhiUlEzNmRubndFWTVr?=
 =?utf-8?B?OWVYcHNCRzgxQi9KSmF1RTZOUWJtcitwQlMxSlFVdkVVR0QyVWZPakxIRm9h?=
 =?utf-8?B?U0lkbVg2UENoVjZqcytKYy9MZTJONmFJUThMdmI2bHp1bGk0SUQ0L1R2ZTR6?=
 =?utf-8?B?TmQxNWRJcUE0NUx0UkdFUE0zSVNjMUtleGZGV2NQM3lsOFZVZWRqWGNacEIv?=
 =?utf-8?B?TE5lWWJtNmpHd25JYzRpYU9taVNxc3hLZmo4WU9UbFZ1b2xVSlNzWTdmMjUv?=
 =?utf-8?B?ckUwUlJzOXJ5UlVNUkVDS1hJVytubHpOY2FqV25UeUoyRjE0N1Y4VTVvckd1?=
 =?utf-8?B?eTBxYi96U2tucFduZk5pbjhyNUJqTUYzdTJhWXErUndmNjlWQjRxb25ZTksv?=
 =?utf-8?B?OGpnK3JpVmVlME8wVlAxU0hjN2tmeEtKSHNVdWJYelY1WWZYVk5peUdhWktl?=
 =?utf-8?B?MGFidm4waE0wL2wrS0JYTnhLemk4Nno2MHUyMUdMZmNWUEZQd2VwbjZQcGlQ?=
 =?utf-8?B?STZjS1RuQ3VoWWFYZzViaE1teEwrLzVmdXZ1U04wYWliQmRXbXdqOFV6d0M1?=
 =?utf-8?B?S3RGVE5Zd0ZBKzYvdG1hbUVMYkxud0gxOTlGVzh3TGFGMGxJejBIRSt3NWJr?=
 =?utf-8?B?OHQyUG1uTEFSQnVlZ01TeG8wcjI2bzA4akZHQWRpTnd6NGFIeDFNdEl5aS8v?=
 =?utf-8?B?WGhNSHlPQlBnRHJib2VKaWFVcnpiNXFud2lkSEhkNjB2SFB4VTRoWWg0VXdF?=
 =?utf-8?B?VHVpdzZncnpKRkN3QTlyTm9LVTBrdzd1WXNRMEhjWUFMZWF5Mzc1RUtHU252?=
 =?utf-8?B?bHhFNmlWREdRTGVPd3JJYjloVlFHVnFWZUFzTm1ueWVzYitod3FzVTNEZldu?=
 =?utf-8?B?ZWg1TjJhU2VreGpYN243ZlhtRUxxTkNscXVUeURnS1lnTlVNL3oxM2EvVGZk?=
 =?utf-8?B?ZmxmS3RPUDdGaVV1bnhPdzFIWFVQUXFsZWxMMUk2VUduWGx2bWRZT0NUeDJR?=
 =?utf-8?B?bDlEdHVLRlI2c204Tm9OakFiK3VJVE9FL0xoZmgxeFdKUzRWS3ZNTWw3RDd1?=
 =?utf-8?B?dmNOdG8vRVhvUmRyKytVNnZxV0hQMHRiRlZMQnJ3bmpZeG05b2NPNDBBc0lh?=
 =?utf-8?B?V2xJbS95d3RjSFdkVGpscTdNR2xodytHZEM0TFFya2JvR3lrN3Bua2tyRUFH?=
 =?utf-8?B?U1F4amQzRXlSTDE0Z3JBenc2eEFYZ3ZLVHk2UUNRYTI3N1l1UTdubDJyd01M?=
 =?utf-8?B?K2d6UGVoRVNjZlZCMElaWDNoSm9KdEhjWGVFa0R1VmFTckNQbDRiVnhhZGdF?=
 =?utf-8?B?VE4wM1BZdm53UDBvNjhNOHlNMFJoVC81U0lSc1VPU3NWdm0ycTRCbWp6dXpu?=
 =?utf-8?B?c21BYVZNZ00yVU45Ymx5K1hBVHZYLzZ0U2xCQWVBTTdYNGEwQ0ZzcTFFZWFX?=
 =?utf-8?B?UCticFNZbjZkbnY2bjgzRmh3MXU5bVNsaE4vREVyVFRwcGRldXdSL0Rtb2FH?=
 =?utf-8?B?TmhpWkJuMXNsb3FURDdKcFd3K3VYVERIWFNhRWQyQm9lMWpMYUh1M2NZMDdW?=
 =?utf-8?B?T0U0dTBSVmpyQjNSaGs0WCtYRVdGM3pEbmlLTTBsTFhTMkJOWDVET2Iza083?=
 =?utf-8?B?WCsycVh6dkVncmYxTk9jSUZsQndCVld5R0pxdFFUd2I1TnlaUXJtVVlJaWNF?=
 =?utf-8?B?U0hEOEJ0UWhOVTBETzFHQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWJNcW05ZSt5ZnZaY3ZOOXEzMXprTXdEUk51cXpsQVJyN092aXh6alFYOGN4?=
 =?utf-8?B?NmpkSys0eCtwMTJ2dzRGWFZRbzRPYzZheUJOSnduNXZoSE1DZG5iT1JNRmJj?=
 =?utf-8?B?SVU5NHNBaTAwY0w0ejk0a0k2Y0hGblVIN1V2eXJQWThPZEh4OWNZRkdLcVhU?=
 =?utf-8?B?SDVGc0IybDJyQk5TS0h2a2YrYXppLzVEUEJPclN4Qi8zNytMOTc1ZEhJNEtL?=
 =?utf-8?B?NEJPRWs0cW5XMHZ3YlROT29obzBUNHN2U2lkQmpiaUNKTXBjRUxadTJVNFpG?=
 =?utf-8?B?NW5BbjdYUTZwTlh3by9xSUpYR2FjSEVRN1FGR2doVnF3Z0JOV1V2U25sZmMw?=
 =?utf-8?B?eXhpUmFTNkUrWTJBOThvQ1RWZTREVTRtYlJwZjJJYVQrWmFWVWRWanFFaVFE?=
 =?utf-8?B?WDJ4NStraUI5MlUyLzJMazROZlhINENoR3ZXWTJPL1RldFZZazZIQnREclFV?=
 =?utf-8?B?QVlIYmZsemNIOFNBek5pNlhxZ3dmZmNDQUtqV0ZadUxmUytWZFZ1c0tHSWN0?=
 =?utf-8?B?UnZNeUlmbzZ3OFhqYmYvbWF3VXRqVHNhSkl4a29SbEtFbUNQa25ONmlyMnpQ?=
 =?utf-8?B?QkxTTzNNdWErNXFnUFNPZHl5NnJ3bmVXbW15TlgrWUxveTBybTVORU1vUnc4?=
 =?utf-8?B?MXdDTEFWRWkrSWZtSlp2cHNRaWlMa0M5d1BrWDFTb3lIRUlLY1NxeFJlRUNm?=
 =?utf-8?B?ZHZtM0oySkNSK3Q4RGdNL2VTeExUbnY1N1dKNDdQNS8vUmd1REVTZWs2d2Y5?=
 =?utf-8?B?Qk9QM29kOWRSSkdkano5T1JiL3BzOHRkbTU0MCtFbW5sRGZ2SWp5WTNzM1Nx?=
 =?utf-8?B?YTg2WmtZMGZZRGtKUU9mNmFTVmtBOWJlMC91bjRiVk9udThwWWdZMTlJMi9V?=
 =?utf-8?B?V0FYWHF6UU9FU0U2VTlaRTNuSHRLN1kzQVl5bmdYVEpNSWhvekhVdjZmOXdX?=
 =?utf-8?B?T0puZ0lPb01FUEZldjNrS0tqenNmd2FGRDRFbmVhK0VNZ1RJKzE1RURvOTJ3?=
 =?utf-8?B?ZHRlbjJhaksvdFBQMnRER3FqTEZVanNGTFp5alZUV01EQ21aTDRXalY5ZnVG?=
 =?utf-8?B?MytwSzlPbFozNTFOWWVjV0Z1ZnVBSUhQSy8rYUplKzVVTzE0K0V6V1pJTjV5?=
 =?utf-8?B?cUdrRnlkNjVXb2t1akNmcm1iYnVkMHFodWxwSUVIUDQyczNiTEFqKzhBZkhH?=
 =?utf-8?B?SzgvanBoUjR5Q2d4Vkc2TVR1VkNaMkY3ZGYrbUdkTWxDeDVVT04vTjhkaVQ2?=
 =?utf-8?B?cFpvOTF4Z0RLa0JneFQ3b3RtMThyR1lDOWVPRG90VXlBaWxRUDVaT3hBKzQ2?=
 =?utf-8?B?dW5NMjcvV1lZend0MjNhUFk5RUdwT0p6SVZRNnZrNFFlU0c2Z0srcjFtNU83?=
 =?utf-8?B?aWdYYnErUXFLdytEeVN5QlBRVThIemNuWUwrSTl6dS9SYkZXWGx4dmtINy9I?=
 =?utf-8?B?bjBPQWYrZXhYUjBjbFV1Q1dVRnhreHdnbjNUUmhrckZKWWtvbTB1QjI1clZt?=
 =?utf-8?B?cjZzZmI3KzVFQVpxWElWS25mQXBORm5TQjJBK0c4amQrQjdLd0wzemc1bHdv?=
 =?utf-8?B?V3Y0cHVTNFVrNERMQXhyMVlta1NOby9VRENpa2ZsOElGTitZSWNqZ1Q4c0VK?=
 =?utf-8?B?dTFJMUFJOFNFZFJlUzkxUWx5M1JmdGQ3SThhU01adzc2SW55UlZGUDRWU3VT?=
 =?utf-8?B?NGcxN0hseWhuM2dLaSsyTjZ2QXV3Nk8wSlhaUVB3aGNyRUNqdnVDbE80VENE?=
 =?utf-8?B?TkpVbk1ZOG1VaTFUby9FMjJrcTBBcGR3dGkxU2Z3dXZ2SWNaOG5aQWpaTW5i?=
 =?utf-8?B?clpRcndQN01FK2F2OWdVbjVQVVJpUExxeCtKbHhLaEh4bjRlYmE1eVVYY2hP?=
 =?utf-8?B?elkwTmpVZ2JJWDlKRDVoOFN6LzRQck04YkxETTJGN2ViRXhiOUtlSlA5T2lv?=
 =?utf-8?B?LzNSTGxqRFpQU1d4L3J4ZE54RWQ0TjBwUEZLdzJoQkFTVFRlRy95Sm14M0JE?=
 =?utf-8?B?cUhFUjV0ZVBKYTBDdGFRZG4vZ0FHRkZrK3RGNVVRb0RnVnRERTVvOHpYZDZM?=
 =?utf-8?B?VnFGZC8yZHlCTXl6a2wyeUpZbmtjSGV2OGg0QVQ1U0pqaVNtUjVMT1QyYVlG?=
 =?utf-8?B?UklPeEJIbU9Gb0JwVkZNMGNaK1l6cUVHaGtJMGcyWXlQbnVPMWY0UkJqSGJI?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6727b0a-3b8b-43a9-5edf-08dcc7a88ae2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:29:48.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mn6NvDI4LggiCTB0X92KWErG3ZTKVTZrWPjcmBDOgddJaiQul04XEjHtdjn7mDo/2s+X8CO4FxDZQDpUiSdze1bXLRlB7ua1+OZFK+3VsTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7177
X-OriginatorOrg: intel.com



On 8/26/2024 11:10 AM, Manoj Vishwanathan wrote:
> The transaction salt was being accessed before acquiring the
> idpf_vc_xn_lock when idpf has to forward the virtchnl reply.
> 
> Fixes: 34c21fa894a1a (“idpf: implement virtchnl transaction manager”)
> Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 70986e12da28..30eec674d594 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
>  		return -EINVAL;
>  	}
>  	xn = &adapter->vcxn_mngr->ring[xn_idx];
> +	idpf_vc_xn_lock(xn);

Could look at implementing cleanup.h based locking here so that we could
use guard or scope_guard and not have to litter the exit paths with unlocks.

I don't think that needs to be done in this patch, though.

>  	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
>  	if (xn->salt != salt) {
>  		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
>  				    xn->salt, salt);
> +		idpf_vc_xn_unlock(xn);
>  		return -EINVAL;
>  	}
>  
> -	idpf_vc_xn_lock(xn);
>  	switch (xn->state) {
>  	case IDPF_VC_XN_WAITING:
>  		/* success */

