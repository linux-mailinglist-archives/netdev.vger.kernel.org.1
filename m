Return-Path: <netdev+bounces-159003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE1A140D0
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 18:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDAA163335
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303561DE893;
	Thu, 16 Jan 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcDRK/PX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F52148850
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048211; cv=fail; b=YM3miYSV9cAfMSLJRWB6fQ8klnKP8DUUJ6gbcAKa3lwOElzjMRSnVLvYBr0cxYFCtCI9FaljvyCu1mVyeCUewMH1bOq7G3isv9lTq4GfwvXH+K5Y96TNdkl6XaB6egOEaPSSx3fkGD5DQEHubyWw/Ft0BDDDtcJ3WfjG7kooX6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048211; c=relaxed/simple;
	bh=ffVM9t+eHfOnguq6827+6Cjk+n5tT+lOdGMkLwJKuko=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ucNuWEjym9xUetYRfk69HlxDy32/BpDdM4Jr+1Y6+kRQx+mPxOGYYxupath/f4rRM3oGdwHVpxwIvOITR73tbjINpwlO43wh0HvJHblLwoX2FuhOsfEuNhSgdCVlXIXdhAQOQ7K0yjWDAW4zb45pG4TS4wFaHMiXCT46HYhXLak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcDRK/PX; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737048209; x=1768584209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ffVM9t+eHfOnguq6827+6Cjk+n5tT+lOdGMkLwJKuko=;
  b=NcDRK/PXMrz3brPa9pCixm80QuwGJE5oEQcTPzfsmjDQ/ext9y6LaQyV
   SUzjdznPjrWBsppYzXxVFUD90/zU/MuPbHMYvttidtcdzCQuB46ZlfSVl
   dpantb1+v/xzPHzYev5XaXB7EnXOQVTodRCcTwZD9FS7Ym0cN6Vs4QUt0
   plIMFAgCfJ9k8QBSdDlqPqGTmcDv+gD9oArY36zVQIUqMhKCDlowPGLkT
   UF8/51n84zfM56KW6Dyok5vH2lcdMJ7rS/KR0zL6+A9w/2vMELuVHPfi7
   vvJnQUZslxY6GgJV8AVGA+ArahgXtVp9lCPCF9twoap7jwzY08bm6j5gN
   Q==;
X-CSE-ConnectionGUID: IDpQ4OScQ/qI1IHSoQzNvw==
X-CSE-MsgGUID: 2OP4jcSrT8CEV56xFvOVWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="40260873"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="40260873"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 09:23:22 -0800
X-CSE-ConnectionGUID: ADyiRAFfSmiKgO8LxDfwLg==
X-CSE-MsgGUID: PSwmiTJUSR+v+llOgRVFLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="105383597"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 09:23:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 09:23:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 09:23:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 09:23:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uf9LH6XAGsv/HHvxyn+Swq4lHTBrOMosics+lyzLG5DBNKv1I1Z44kkhDoOHGJVPYY3H2zTl3pMWKp3hwtE08PmKpGsaeUCrFI9kVWNY7sNT/TC81s5Aak34MvkXLZLCKhPVGuW/yHvyBqke6FRESWmm+pRg4DJ5BhBYuWwUQIv5C0zlppUoDdVmgqNJD/NYG6Jm0J/5Mz8P5NK1emXVAzHbzVp5+kg8Y1BtmiEO4FTkJAUWag6+tuQvVvDr2kNwMQ2LQy3GeietV0YWpuBXw8RzUVqrmlfR/Dvac1RGQc/2tdpYFmVEvWRRdbryAnw9K5rQ6T9xD9DqCyvOZrgJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdL8akz01W09dNMYZozTb1wELlMbgnSMNb5uDkTiVqQ=;
 b=CCqDqOt+ogxe1EyCY2DlThAeFl1QMj04C0jVlIdhn9GPNueRMxC7jt+u/ck0fkmBFt8JWvJlhcvzFms5crxR6vJN7IJYG8tPKg9qRBwuVHv/+bZRGVia03FBauMwil2FSCc+mBjkpXAF6QqC1jx2hJlvgsrhPkbe165+1Bpe2FwVOLGXMkl60ejHLpTYtrd9cVphGJbmK90PMfIR/XlBSdL0qOCIVtwlntIHUz/C4JsH+700HWM7BuI8eA2tsrHhOce6ZrDq6hxWGghXuFPvsnz0iRNMXAMWa/JeICFnZDBd1PNzb/He4dixGomK8qtI1Axm7IntUuNyo0X4rEf/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 17:23:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 17:23:11 +0000
Message-ID: <f387de62-6a61-4c21-97a0-ac0da9e99c58@intel.com>
Date: Thu, 16 Jan 2025 09:23:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/4] net: ngbe: Add support for 1PPS and TOD
To: Jiawen Wu <jiawenwu@trustnetic.com>, 'Richard Cochran'
	<richardcochran@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux@armlinux.org.uk>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <vadim.fedorenko@linux.dev>,
	<mengyuanlou@net-swift.com>
References: <20250114084425.2203428-1-jiawenwu@trustnetic.com>
 <20250114084425.2203428-5-jiawenwu@trustnetic.com>
 <Z4aPzfa_ngf98t3F@hoboy.vegasvil.org>
 <067101db67df$422cecd0$c686c670$@trustnetic.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <067101db67df$422cecd0$c686c670$@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0326.namprd04.prod.outlook.com
 (2603:10b6:303:82::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: d5eb32ce-8821-4932-1e75-08dd365273b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3RCcThOTGkvVzBrSnhZWE5QVjZzMHFFeHlFVVZuZzBHZ2NQWWNRa0xyd1ZN?=
 =?utf-8?B?aGRpNmFNbUdFTDFpUDh1ZlJEcG93NUlIQmo1SDBDcW1NTWh1MWRnN3pMV29q?=
 =?utf-8?B?ZUFsMFVYWnBKb295bExubmlxMmhsTHZpc1Z6QlNxZlIveXZRZFJUT0c5Njhx?=
 =?utf-8?B?ckVmTVAra0dpYmEwVlZ3ZFFRSkh5N0RMYlhCRkFkWDNoR1QweVNhZHpGN2dK?=
 =?utf-8?B?blE2QVJ0OXRpckJXVUJRWjZrT0VJZzRDTDFhRGhUSXpkbTE5bVFPNjFpT3p6?=
 =?utf-8?B?aFNFUkpKQzN5cUY1by9tWjFmc1AzT0Jlci9UUGdPMlJQQW9iUUlhdEk4S2Mx?=
 =?utf-8?B?bmZpMHFYZVdpOEp4ZzFucnJMaVgxN01IaXZQcW9vd1I4aUYxN2RKZW9Jb3Yr?=
 =?utf-8?B?NnU4STRnejlqaXhGL2ZFRklOc0VQditsb1pHSVlub1dGRUc4alZFKzF4dUlN?=
 =?utf-8?B?bU5OWUwvVUVSa25YWk9JeXY4dExlb1R0ZW5oZFFqSTNHemo0bnV0ZktIRFlU?=
 =?utf-8?B?ZXMzd2ZmTWlQRzNLVkF4aXNaR3ZmOHRPUU85U3J4UCt3ZlU2SlphU04wUFpX?=
 =?utf-8?B?SjVNQmRsR1ZFaGNiR1lHWEJ5Y1lZeUlycXlJSVhySkpUcHptQnZON25iSWZx?=
 =?utf-8?B?ZTBhdy9WV2h4YkxXOVJKUm9jdm10bkY4b0pGa2d3S3lYSWFhM2RUTVEvYWJT?=
 =?utf-8?B?K2lLeXBNU1ovNFFSa2p2aEpIb2k2K2N3UFlsUVNLdWt2ZkwzZG10eEltN3Ru?=
 =?utf-8?B?bUtiaDdacHlDRVNDWGF1Z01MNjBoUDh5MGNjR2IzVkJhQmZRbERIVDVXZ2dw?=
 =?utf-8?B?NWNDOTRSYWNpTFV5dGZjRE0zRW10Q1Jlb1kwbzg4YktoMlNjMDFmUm9xYWgv?=
 =?utf-8?B?RnJOL296d05QeGZiY2EyNk1aZmZWdjNBSWE3MWROc2l6S3BiQlZUVExnMlcv?=
 =?utf-8?B?NWJIR0dSbVg4eWVacFVKdy9QbWE0cmNFRHJzRU9Od2liK000VkNNQ0NKN3lR?=
 =?utf-8?B?bCtZN0dlbjBIWXozWEpoZXQ3QzBIYTI2YTJKMFplZTZmZHdJaHFac1cxaHFa?=
 =?utf-8?B?ZjgvdmhpMTV1ME5UMXZGZFY0dUFINEtjd3AyZ1VsT2xhNW1zZG1RUTZTci95?=
 =?utf-8?B?K0ozbnk2MU5tOGhITUZqS2c0N1hRTEZCS3o3Y3RSTDF6QmowMHdpL2dVS0k2?=
 =?utf-8?B?cTMrWUxGT0Zya1ZOOFVIZ3k5UjRVaDFhTU1jeXo5bnNrQ1p4N3VqZ1RmNUtS?=
 =?utf-8?B?MkxNYnI2VDkzRWlTZktlcjczaGt6MVdDQzNac3ZKUTVKWno0bzJIcEVCN0pj?=
 =?utf-8?B?SEFpckF2bFdTZlZWVVdoN3owdzVvUldHN2FtaG1xYWJaTTRBdTV1NmJUMzhD?=
 =?utf-8?B?M0RtbW80RDlBNFd1VVR2ZUUrY1pXRTIyZ3YzTUhJeVhhZXNzZ09McElWTC9m?=
 =?utf-8?B?RGZVUFdLQ3p5T0kyNHV2c1V5SHNtZTNlTk5uWDNwMk1wMnVtL1lWazY2Rmpk?=
 =?utf-8?B?YU9wOVIyM3UyYS9FMTByL3JuOFJLMmxYczg5aUs2ZGN6amMzc2RCVWp1WWtN?=
 =?utf-8?B?WkFiQnNReXB2M2pGazlwS2hSVUxWVVRSeUJ5ZnQrV1BQVUlsRmRqRUs3aS9F?=
 =?utf-8?B?c2lwNnZUYVBpSHJlY3NiUGR4aVduUC9TRlZtNFdrVTRITHZrRVlSS01uQnVa?=
 =?utf-8?B?RCtTQ1pyNTBuZGxwNDl3QVhjLzBLRHpCeHkvWlhjdmY1SGprSU5aTDVSTlox?=
 =?utf-8?B?emh5TW5iWXlGVDVXMUVtSmxmdWw2c1ZoSzZvU25aaDl4OFZ4b2lVd2c5a0ts?=
 =?utf-8?B?SHlxOXNwTGpVY3I2OGcwTW9pcXAvSWxBZTdscXd4ZUc2QS9wbVk4ZDBTWTla?=
 =?utf-8?Q?87oC5yYgR7b+y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktqMTRLNUplMEdGNFFkcm9NdCtyS0dsYURPbXAzWm0vSyszMzU0WDdxdXkz?=
 =?utf-8?B?QUxNL1JCdDQ2UzFUUzJRb0NHNUdlSnpYNmdobU4vd29KUDgrWmVpdTlZYnF5?=
 =?utf-8?B?U09aTlBVeE5oNCtaeXhsWTZrOTR2WkxWS2xYQjBFTmllSDVLbUZ0VjBTSWNX?=
 =?utf-8?B?VEE2Qmt4c21CZElQYVJRTzZaK3dHZ05ickYzNkk4ODRxK2dqRldlMEVPbCta?=
 =?utf-8?B?eDdNVGxSMXBjWnJ5aURNMytJWDBYRzZpdUdZTWo3TGFOUW92ZEw2M0U1czA0?=
 =?utf-8?B?ek1nL3JDY2xWL3dRNFJpbTgzdkwxdFFVc1IwMWVSV3JGYjJ1bjlxNXJMODFV?=
 =?utf-8?B?MDJFcVBDNTY1M29WRmlVcWdJU3lFbmp1TlZ2ckIwVVQ0TVhDWTg2WjJva1h6?=
 =?utf-8?B?VThhdEVrU3l3VkZNNSsrQU5HRHhEbkRFSDFXZUtJS1h6QnJNbVNPOGVPd1Ev?=
 =?utf-8?B?STcrWjFvclQxNHFYeFBQSjJJQTY0ei9wWlFOUnRKWjhJeUFHRDFTSlZoaE9w?=
 =?utf-8?B?R0RqNm50ZU4razFNV2JaTnVHb0JSU2hUMDVtUDdram8ySzMxT2RUR1hIVW10?=
 =?utf-8?B?MFFaY090NlovdlQzNUxyaTZ4Z1lmRXY2d2tMd04zUUtTeTJNMUtnaG5XVFJp?=
 =?utf-8?B?SXhDQ3pGaGhzY2o5amNxSHdqSzNoeGZqY3JBYnhOQXZ2dExFNUVaVXJONlNS?=
 =?utf-8?B?emhjaTQvTkJYdVo0dThPVGhPMkFOSXkzdmh4YlJDWCtwbE5FSXByVUF0NEEr?=
 =?utf-8?B?R0d3WEZ3amZMK0VTQ3hJcHFFRWwrVGhsUW12SGwrZUZGY3lCclg3Y09PaFJr?=
 =?utf-8?B?NStXQm51VHdxYmFIQS9pMFBhWmMwM2I1KzBuQ21xWDFUZWdsVWRnTWNqWHdr?=
 =?utf-8?B?b2V1em9wYnpIZUNGVTFXTWkyS3oxcmNVRThOZDQzdnFWZHpzMFY4RnJZd2hB?=
 =?utf-8?B?RkU5d084bjVqdUdnQ3BydUFySUhTMC9PcTQrNVZnY1V1ZDliWG94ZXRmYXZs?=
 =?utf-8?B?NzIveHdMbkU2d2MvS2JxWjE1eTdPTkZIeHFIYURvSkQxcDRKOXBJYUdWcUcy?=
 =?utf-8?B?ejk2ZndudWk5YnFBVXpEYTBCbTZUZUZLdm41TitRZDZSWG9oM1c4ek5FeTNZ?=
 =?utf-8?B?ckhuVmdVOFBMN2owbzF3SnE3VmRKdnFkc01MT1FQVFJyeHd0NFgxeHFLeEZZ?=
 =?utf-8?B?THJjMHZrRzNNMVhPczJ0RE5mVDVBT0x3OThzRHBHN3RXRU5QVkxySXljeGl3?=
 =?utf-8?B?RjFzemptSlY1ekYydHQrR1R2bjF5SjFWbEl1dTdWbTF1UDA1dWhNa2pveWQ0?=
 =?utf-8?B?emx3aGFDaUZ6aEtLTEwxemVyUTdFQkl0aEtldGl5Rmh0ZDl5QVJnUEZBNFZp?=
 =?utf-8?B?NUlHbVNuSG4wTmRMQmNMQWc4cUdHeVlvcWhkNURFUGhqR1YvQWxXS2hJSGta?=
 =?utf-8?B?THF6cnBCYWdNcXJ2UUNoNUdiMGtHVjAxY2N2UjZyMEwxVEdhVVRTZlZjdDky?=
 =?utf-8?B?YWtYbFcycVZOS01LZWFlMU5kVEJPNkdCdGQ0MkhVYzZMUTBjdGs1VkxyekU2?=
 =?utf-8?B?U05hSnpLWUF3cFV0emxYWDZ5a0xmdEp0NmRhVDRpQldSeERNbE96NUJrRnlV?=
 =?utf-8?B?NENiN0ZYZyt1a2haQjlValdiYnd0TzVkOGxlc0x2SXFhM2RhZTFkazh5YVZz?=
 =?utf-8?B?bVVKZURXa3oxc2dVdEdYOFIzZHc1ZzhmNUNheEtXUTZBbGpmVmJFR1ZwTEdF?=
 =?utf-8?B?VkMyWDczRVFKY3Z6NXZDUnZBenZsZEhVZVFCV2tXK0lTckZiOFB6YXJJeWcz?=
 =?utf-8?B?YzdVckxsd29QT0JDNis1VGxsc1dZNTdlcU5FQlJGenNOeGtXSXd5TmVHRlhK?=
 =?utf-8?B?ei93VHVybTVkK0FKNlJCZ2piTVZUdUFlbER1NFVaMncrYUQ3SzhFS0ErRmtp?=
 =?utf-8?B?ZjRjZTVoV09sYVlCOUYrdEE2bnJ3SDRScllHNFN3MFphSW1pQkZGdWhxNVVr?=
 =?utf-8?B?MkRhNlp3NDV6Ukg5S3l4UXRkMlh4UjRveEh2QXIxZHM4VkphM2w0RGZ6clR3?=
 =?utf-8?B?N0N3VXp4ZDNvU0FhOC8wcitNQmRZVElZOFBVRXorcmhXWGlCc29PUDFpTHAz?=
 =?utf-8?B?Z0J4Q20rV2xhbGhGSDdHNjhRUVdTdldXM3ZuUDROR21EVmhoWDlVYXJnclY2?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5eb32ce-8821-4932-1e75-08dd365273b5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 17:23:11.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+oOPO44QsWKwoXUqGCXXChZy1QnoiMhZEWwdxSlKS8k6NYdWvjfVfRl5ptbqCymKzcxxgYqN+Fa294tBPglyuaKVqDfyTLbb9tQXr1lT+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com



On 1/15/2025 10:24 PM, Jiawen Wu wrote:
> On Wed, Jan 15, 2025 12:25 AM, Richard Cochran wrote:
>> perout.period specifies the *period* not the pulse width.
> 
> Thanks for the guidance. But what I'm really confused about is how
> do I get the duty cycle ("on" in struct ptp_perout_request).
> I try this:
> 	echo "0 0 0 1 0" > /sys/class/ptp/ptp0/period
> to pass the period 1s for 1pps. Then where should the duty cycle
> values put? Seems "rq->perout.flags & PTP_PEROUT_DUTY_CYCLE"
> always be false.
> 

The sysfs interface doesn't expose the full support for the
PTP_PEROUT_REQUEST ioctl.

It only supports setting the period and the start time. The other
features were added later, and the sysfs interface was never extended.

To use the full support, you need to issue the PTP_PEROUT_REQUEST2
ioctl, for example from a C program. Something like the following might
help you on the right path:

> #include <linux/ptp_clock.h>
> #include <sys/ioctl.h>
> #include <time.h>
> 
> int main(void)
> {
> 	struct ptp_perout_request perout_request = {};
> 	int fd, err;
> 	
> 	/* use the appropriate device for your clock */
> 	fd = open("/dev/ptp0", O_RDWR);
> 	
> 	/* fill in perout_request as desired */
> 	
> 	err = ioctl(fd, PTP_PEROUT_REQUEST2, &perout_request);
> 	if (err) {
> 		...
> 	}
> }

Thanks,
Jake

