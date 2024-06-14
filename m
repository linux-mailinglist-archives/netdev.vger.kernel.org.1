Return-Path: <netdev+bounces-103444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC259080F1
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 03:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8862824DC
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1DC1EEE0;
	Fri, 14 Jun 2024 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0tfp6p3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D274626AEC
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329557; cv=fail; b=lPPpoeV6sIDfb3JoDxRbRRAO0stvtpUN5Pgm3FUK1hyFmhrtE6JDYHxs/I2uA5x2x9RUkhs58xmX/4rOF3erqX0/vAMsTW92yo7SbSp6g0KSrb6caOXPivAPWkU/T5G1qBG7TJ8ytBmRodf43Akl5n9l9W4HRbHydgQPOdtxvA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329557; c=relaxed/simple;
	bh=n65ntc9HFU2A/RUxr8J5arBSRdcaoT0ew3Ma1LazNUk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=humfyKlc2D6YSrLnjpF+7h3H5wK+2JbNJK5kwlIhfHo98MTccAYfJsvR7ZwUW9WsoUHSY+r5vSwJAw+XBLLwBqv1KnWf1OwopT9LUu9frJQmCx0nmJkZ2cOhWLb5HB6tQ/r6KffOOCO/Nxeh+Wr8X+i+Ezv88WX2TQFJWsWqI/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0tfp6p3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718329556; x=1749865556;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n65ntc9HFU2A/RUxr8J5arBSRdcaoT0ew3Ma1LazNUk=;
  b=P0tfp6p37bt9jErNIhP+m4CiUnsgnabyeT77KEhhc19LpnSJ96EcZ5ka
   g+g9vDmHM/6GcYjFSbwahpmoVickhVkEtQdTIDs9Z0MApYL+fB0uoQizh
   LinM2pTyubPw7jBB+pxT1H8ULLjhqsRp58qzoYHv+mr6JKMblU/CsDXIZ
   gtEn/hmx7qJm7+V4u3xfXozXLprNE61vCoFFhysLtayUAvf6yQRo7otJU
   GH4t8j0PgmrvZLBBKirzla1lUJwRVj15RIW96IB3gY05TBUchfz4qREAf
   KUgayydy6r811UBOrRH2Q/1L6kw+6L0/t4yMALP44rMgHIQREV9VCTsjI
   Q==;
X-CSE-ConnectionGUID: /jblb6ESRW2fUJWGDpVWtw==
X-CSE-MsgGUID: jL5dAODHTgy7CrOVgUuPpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15428293"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15428293"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:45:55 -0700
X-CSE-ConnectionGUID: d0OcgT8STSKdCMvOpGTr1g==
X-CSE-MsgGUID: PrgMQONbRBq1usBPikSX1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40481479"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 18:45:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 18:45:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 18:45:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 18:45:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6K8KXMj/3a+6UFCQPcVYq5/3xefIpUK2U8AjVkhpGzWsU3QUbZWrUibT7nl3ezgC3+at/sXN/+NgEzf2G1e5IH5/l9qYCx5eEMKwfQEuq/BvOeGphSKugvBOQN64SLAPO5c/dzchYmwRGc3vUOzMQOAsBMStjIEAxRgEBgZkz73JbCMYkLbAMVEZrtbrKJ6AqvACSUO21qybqq4LAHdDK3q9O/mA8OFeU4Y4Njn3TBW4aiWPgQNYkuy12upNhkXKmUTqVmrfr50VKL9jqrWy4D2JNFrY1HqKWNgxZS5DWswVM3ALozN2PNIJGzVdBzc/gw8DCRD1SzojTmU2eHKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7X2PjGdzP80ANXz2Z27PD3xLNvtknEN6gRXWoFCbfPY=;
 b=dy6XiyDpnmSw4Pl0kcTAqND13J4VP2MFx5IHwz3FMrrlZN8KdSdkO33txossaSU8sl3JL2m7n77r1waE/oTgh8mMbNLCB0RflezwAtZOFm7toLEIWlczAc6cSFZgbYXdiSPCCJrUjIdRgSLQ+Ghr1oCVSSV73jkVjp5XYP5R/XiybDj3uaUWaMGDL7MdN8jz8HwCfHyhXK9Am60tiBHzX5HlleKX+4yTXvCdfQewfVYU60zcvNEeb7YgDkzMPIAelNvYTWe9tZ9E03+pMA3cFdYPD81xEGFJpJHWQ63rxYOYrkDhmnY0JtPrtChFH8qj5MHDFn+KFPCErHsSDmYdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6093.namprd11.prod.outlook.com (2603:10b6:8:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 01:45:52 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 01:45:52 +0000
Message-ID: <d6e29acc-c759-48ce-bea2-3088b4d3ea86@intel.com>
Date: Fri, 14 Jun 2024 03:45:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: make for_each_netdev_dump() a little more
 bug-proof
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
References: <20240613213316.3677129-1-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240613213316.3677129-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 075fefa9-d3c6-4788-c222-08dc8c13b935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkF5dmc5V0llb3BXb1ZMUll1OGFJSmtkWFZqMzJ0dExQRWd4bXVwdU1JUjFt?=
 =?utf-8?B?VWY0ZW1yREFHYTlzeEVobk5JTEk1THhseFZrRktPNlhyRkFEYmhHRFZ2bVRa?=
 =?utf-8?B?akVySE5qS29IckNaMlNyMURnWlZrSFBiZkRYUzJ3V0NJQWhnQnhnSnJSZTU3?=
 =?utf-8?B?RzJmcFFKUEJUYTRZVHAyeFZrQ0lEb3VtNFhZZ2U0ZGNSdjBNT3JNZlNTa3Nr?=
 =?utf-8?B?Q09VTUlZVldZL0R3cXMwc3JkUXdMSXh4MDRMREVVejVWTWJwbDJkRm9TYW5V?=
 =?utf-8?B?SjNtMVBZcENJaWRESStNdExkdW90TG1rYTdFL1RMbU1hRmlHYWc4UHA5Q3Bj?=
 =?utf-8?B?YWZtSk0rb2pkdld1cmlpSDhDVzNGZXlNT3JaRTdGbUFwWGllb2orTXpqK1RO?=
 =?utf-8?B?UWM1a3JDSmxUV09HeEh0SmFUN2ZEdWYrRXBWY0JrVnF0RTFZMk1ObS91b3F5?=
 =?utf-8?B?YkU4TEgyQitTVm1pV2NpQVZGMzNJbTAybTQ4bTFPck1Oa3JHRW16b0lmcEVL?=
 =?utf-8?B?dUZEU05FaFRhVjliQTVhMWlwUU9sRnlReGpWQTllUk8vV3lBOW1nUjhpTGdj?=
 =?utf-8?B?R0Z6N0xUQnNpeVBNMlJ3WExjcjdnbCswS2w1dWFOaTRwTGs5TXFTNVY2OHhK?=
 =?utf-8?B?K1BhT3J3cjNCUHY0bGFPQ2lDM281RlNMaVlpSi9uWDVOb0xoQW81STFFZFgy?=
 =?utf-8?B?S2E5UFV5U0lWT3NHSXJuWXpPSUdOT0w3TzF3bGpCWFdZSDRTRHN5VmI0WUV1?=
 =?utf-8?B?S3pyZnpBdjlzQWVjcjRzVUJOajhjMkcwQWJUWmZNdDJ1K3BoT2tmZnZ0ajdD?=
 =?utf-8?B?Ym9ZWS9hTXVOTitQSFVRVWg0VHA0RG5HZWhhS2NGUUowQzdObGhweUxFWGFV?=
 =?utf-8?B?Q0FLSFlLMCtReXpiTURGQUNxcXJud0RSOGtIdG40THZNQUxvRGVmaUJUb3NV?=
 =?utf-8?B?YW1LWnk3eUtVZTVsVWphMEIySEdreVBOY2dqL2U1Y0RzMU5YZkw2YzBBaUtD?=
 =?utf-8?B?bU8yVzBRMW1rdkJwYnJQaW4rQ1I1NlhySHdYTFozVS9uMURZL2R5K1NmSEFi?=
 =?utf-8?B?SzNQYVArWlNyMUNiWm9sVTFTMEp0eXdGR0VXWGxHY0JzY3NSU1NjL0ZadVFp?=
 =?utf-8?B?bmM3RWtQK0pnd1hBZHhpRWpJVVBLM2I2ZlZaUUtsWW1TSWx6Nm1zcU5VSWZW?=
 =?utf-8?B?dDJJWkRkNUpVa09rNnV4aDhFS2Vta3VBdE9uQnk2YzEyQ0Z4UlV3RkhIT2pv?=
 =?utf-8?B?c0VNMkZoRDhjZ1cvYkcvUC84WjVkajF4V2tRUzBtbWQ4d21LTGlzSkhIc21T?=
 =?utf-8?B?NU9vU0xteFJOWC9pRTNEQWowYytJYUJYYTBrdWlUaWZKdzVMUnY3RjA3ZTJF?=
 =?utf-8?B?eHFSMkQ1ZGduQy9EVm1tZ1g1NmQyWlExYTNqSVRHSjI4em1KV0VjRGxDMHB3?=
 =?utf-8?B?Z1o4a3BqQkM1bm82dkVQbjk0c0dUS3YzWGdDRnBYbEdBcnVsZDR2SHZUZTBK?=
 =?utf-8?B?Y2tOTjlzK3BQbDVZTlNDSXZkenkySzVVajM1bFRHQW5OckU0Z0hvaTVSV0hL?=
 =?utf-8?B?SEdkSDVTZTZDd3pORERIV2dwUTJYZzloWWd2Y2pFUERjbmZTcXl4ektsYS9L?=
 =?utf-8?B?Z3JKQWtVREE0YnFuZ29UeDY2YUFpa1d3cGtiSS85R2Q5SXQyZnBTUzFpLys4?=
 =?utf-8?B?cit5YTlzbHYrL3ZxZWhaNHNneXlxT2VnMlBvWVBKOHdXbVhXZ1pKWWJZaVVY?=
 =?utf-8?Q?XUDgfORBZdXJjy6weRWC4L+bgwFIHxlH7SA/bkf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFI4UjN1SDhLUkVmT0RZZS9qeDNVbmVRSi9TcERCMHFiRzdKeXArQmdGY1lk?=
 =?utf-8?B?M2F5cGdSMUJENWZjQkdDTzZXSmZGSTIzNW1IdGtIajJDNUdoaWg3cnJpMlYw?=
 =?utf-8?B?K1JIbDJqQXIxaS9CZmVPOEE0VkJsemRtbHpBQkNUVitXUXVzZUtRN2hsRnVy?=
 =?utf-8?B?Yjd4d1c1bk0zUytlSDRYRUZZYzlTTVBkME1ZUGhSUmpONFZ3aHBXN1BuaWNn?=
 =?utf-8?B?dEVla21ONEdiVmtHcjNrRDF1eUExQSttYUwzejhmbTBGdk93M3JZcjJnMEJl?=
 =?utf-8?B?MThmd2FKTmFxNVZoZlBadjlGWjdyKzVIMlF4ZkpPenRUNDk3RWlSSVc5NDkr?=
 =?utf-8?B?Zm41dnhtalp1QmE5SkF3YnFtTUVYRWl4cDhndWZiaXZKS0dxN2wvUnY1elFE?=
 =?utf-8?B?TU5vTk9EMUZJbTE2UEMxOU4vTTlYbmgwc3dwbDdhMGV6MHVJWmtkWTBtckY5?=
 =?utf-8?B?SEp5azV2T2N0SHFiU0hFV2xLaTljOXc4VERROG4vS0pZWEI5NDBYS3BCVVNs?=
 =?utf-8?B?SnBIWlFCYTloSzkvcE1Ud2Q1dHZZdHVjM2hCVjlsanh3VWZ1YlJ2V2pha25P?=
 =?utf-8?B?Zk5JRURoMjdnZTUvWmJtSDBzZ2xiMThYMWJhaEp5Z3l1TEVaeHVsMUdlZFdt?=
 =?utf-8?B?dEE5bUJObDcrLzRncFJlRzIrNnZ5enZwMXhNZG1tVEF4dnBYUlZuNjJQaVA1?=
 =?utf-8?B?ajIwQmh5QTQzT0tiRldMcEpXZ3dJM1J6aTY3YnJOcGdzQkM5NEtxMHlPVi9a?=
 =?utf-8?B?cFpsUXpzRzFiQU1TNlZuY3UrRGRLTEErT09RczhjU2hrdVgxdzZqWDdOL0V3?=
 =?utf-8?B?QlR3RGVrbHdxcTZubkhVZWJiVUhkVTNSSGtTYTJmZ1VkdDhHMjFMNWE3YTBi?=
 =?utf-8?B?Z1J4dmxUWFI0bmJTWXh3aHZJOXJGeVVzMzFLY3Q2VStjM0NCMVVEVE1qVEUy?=
 =?utf-8?B?NnpzbTM0RWtTeTN0QUFPMjJHREpyMHlVQjJ3MFpMNEx3TUpjZ2srVnVwbVNj?=
 =?utf-8?B?ejFGVlpONnBwWHF4OXFrUDZXdnlPNzQ0NnAwRjBXQTZhbjlUaGxWNVVuZGlI?=
 =?utf-8?B?VVVtV0cwRzFxSjJ0N0g1dUZYbmkzbkxIUUpOZmVFVzhCaEdPdVIyUE1HYzNO?=
 =?utf-8?B?QWQvUm1SYmd4eGM5WlBnQ2t1bktXT2VLcmFBYkZSSzJENUFYSm90Qk1oV2o1?=
 =?utf-8?B?Vmo2RGhKM2tpOW4yYU9tZFpwbzhYbytxelh0TzZhRkdiYU8vQzRlMUlSZEtU?=
 =?utf-8?B?cURNYXpWZHcrdVJud0t0c2xXNGk3eFFFVUYwd3ZOUTFoMjJ6cGhnRWs1Y3Bq?=
 =?utf-8?B?OHRwbjllcWQ2ZXhrYUVPeDVCVVpxZmNUV1h1ZzBSVXFZN1JBMlFVNVV6RkMy?=
 =?utf-8?B?VjgvY0p1ZlU1bUtZZ0lBbjRRZndPTTRzS3hDRlhYLzYvdTJVRlNMUnM2ZTA5?=
 =?utf-8?B?Y1I5dVhieEM1blhTSFNNK2h3RVhCOHBJcHJ6bnJwNTRsSlgySlBkY01vZWlP?=
 =?utf-8?B?enZ4TEJ0bTVJWHkwSUMxM1Z1bnk3TVNQZjlpZXZFenJ2dVU4NXJweENyRXRR?=
 =?utf-8?B?YTJKODI5NUNDUUhEbGRaV0lEV01ndjBuVEs0Q1hmTEdFKzU2VXZFWm5CRjdC?=
 =?utf-8?B?NXRvL1NnV3dBK1NjM2NPeXhXd2RyMlg1S2Z1NXFnb1ZaTGdURmRyNVhGeSty?=
 =?utf-8?B?VlZDTlBRMTltTGE1ZFhEWnFJUHVJSkZyL1FSdkk1OFdJQTRrM2EvdzVDS1Jj?=
 =?utf-8?B?akN1bmlkekk0MVplOGxjMU9wVE4xa3hMM2ZqREIyT2k2R1o0Wk5BV3k2K1Ji?=
 =?utf-8?B?MTFjTWZHTnNkQmlXdXdnMEdRVWpuODFtNE9mMXJlSTNRSldEZlBFdDhxQUpZ?=
 =?utf-8?B?b0hpQmN3NDVPS3VMTmxmZXBJb2hCWTNrd09hVG5iTy92T21xQXpKdFhIaUJD?=
 =?utf-8?B?aGdiWDUram51RHZRL1pxYW05a282NXEzeWVVMGFHL3dwKzVvMms0bnpsaFBN?=
 =?utf-8?B?UmlPWE9Bc1YvbkpMSnFydFZaWlJBMGRYKzhFODNFOVg2VGtEMitwcS9MTklF?=
 =?utf-8?B?TCtwS2xLR1ZON2tRZVRiUlRpRnQwajBQMEJBSzRMRkErV2YrYUZLWndENFVI?=
 =?utf-8?B?VHdWSllHYTFvK0pZWmhuMlBKc0ROMDMxMG01RFcwUndBT2NzZ1d6eGNtTU1i?=
 =?utf-8?Q?njS72p0wSiV2yfgPKGdORCA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 075fefa9-d3c6-4788-c222-08dc8c13b935
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:45:51.9931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUp66ghS/HaLjotKDg0uUvwvdRy5UOe3EG+DGABwG+T7h3pP+ADunIjqhmTh+IzH53XP43ko62NJuRtCfLauGEHgn4YQjIKuarwyEsY9SmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6093
X-OriginatorOrg: intel.com

On 6/13/24 23:33, Jakub Kicinski wrote:
> I find the behavior of xa_for_each_start() slightly counter-intuitive.
> It doesn't end the iteration by making the index point after the last
> element. IOW calling xa_for_each_start() again after it "finished"
> will run the body of the loop for the last valid element, instead
> of doing nothing.
> 
> This works fine for netlink dumps if they terminate correctly
> (i.e. coalesce or carefully handle NLM_DONE), but as we keep getting
> reminded legacy dumps are unlikely to go away.
> 
> Fixing this generically at the xa_for_each_start() level seems hard -
> there is no index reserved for "end of iteration".
> ifindexes are 31b wide, 

you are right, it would be easier to go one step [of macros] up, we have
  453│ #define xa_for_each_range(xa, index, entry, start, last)         \
  454│         for (index = start,                                      \
  455│              entry = xa_find(xa, &index, last, XA_PRESENT);      \
  456│              entry;                                              \
  457│              entry = xa_find_after(xa, &index, last, XA_PRESENT))

You could simply change L456 to:
entry || (index = 0);
to achieve what you want; but that would slow down a little lot's of
places, only to change value of the index that should not be used :P

For me a proper solution would be to fast forward into C11 era, and move
@index allocation into the loop, so value could not be abused.

but that is a lot of usage code, so I'm not against your current patch

> tho, and iterator is ulong so for
> for_each_netdev_dump() it's safe to go to the next element.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   include/linux/netdevice.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f148a01dd1d1..85111502cf8f 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3021,7 +3021,8 @@ int call_netdevice_notifiers_info(unsigned long val,
>   #define net_device_entry(lh)	list_entry(lh, struct net_device, dev_list)
>   
>   #define for_each_netdev_dump(net, d, ifindex)				\
> -	xa_for_each_start(&(net)->dev_by_index, (ifindex), (d), (ifindex))
> +	for (; (d = xa_find(&(net)->dev_by_index, &ifindex,		\
> +			    ULONG_MAX, XA_PRESENT)); ifindex++)
>   
>   static inline struct net_device *next_net_device(struct net_device *dev)
>   {


