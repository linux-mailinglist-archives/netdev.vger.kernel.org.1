Return-Path: <netdev+bounces-114103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7309A940EF9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA718B218C5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66486195997;
	Tue, 30 Jul 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4MnIAff"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E923C28
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335100; cv=fail; b=AZkYUnYrLOo52KVNmenCELsZylB+KQdXaP4bQtTXtWqPadd6Sy4V46ZkKI0ilVg8hMzJB4WiVHMP+EdCT5ZrticJH5DrkDSFH4TmBlH9UKN524tAHJpvHoyuvDyS7z2UoM5HtNfEjrN1Lt1BrhYwKIOkTDvVvyV5/lEmdxvxmwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335100; c=relaxed/simple;
	bh=CWZK+kFfYkBfj9jVhp83HqtASu52YN6SBCqskd3Bd9A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rXMz4/VyqznrTb7UEVqNwlg9L86mV+DmsMuPNgBxBGAm+sj2CSace/+3DK85qCZJqG7e1H74ELsehD1P7Wv5zWXXmBttiUfptVfhXcZ13QkllFgmENA2dEOrmIGSRgkv3h3tRgm3e7nxClsN1GgjrlHmZmaEJSqUiMLC9uZ6vbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4MnIAff; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722335098; x=1753871098;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CWZK+kFfYkBfj9jVhp83HqtASu52YN6SBCqskd3Bd9A=;
  b=n4MnIAffg9sTVTrKIM9abaEfp05UwRcKa7iCAMbMsfwibQI10TheKSHg
   bvyVoJ5J9nbvXn/caE3jaX3n8rwfCQn8b7RKR9rih5kbxblqJxMG05Z0g
   JIXbKZHWsEDKF6SkXL5asuWAwtgjke1wNlR4UKV1w4HZwV3z5CLj2JCBK
   ax13Na13LtVeB4zmwXUMFrrouZpKhZCty4z5Z53+DlqziDq0cAtbjiVJX
   6byipo64Ca/KmCUv948LQtbJYTUyqwyU5RWTdLpn26DVQtvaoEb+wKDqR
   jsxNHw+DvO0zIm8iZjxKpG2Z5XaUNNpMH/fo8APo7oL3TaR7LgxR6qfbS
   g==;
X-CSE-ConnectionGUID: FDnX9bL/TnariwEcUXD+Ow==
X-CSE-MsgGUID: v1AOi8dZRgWlXwitbhviLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19982756"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="19982756"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 03:24:57 -0700
X-CSE-ConnectionGUID: PTV7v1hQSKG2vMD1X5mxrQ==
X-CSE-MsgGUID: PkqVR87HTsad8crwcQ6XdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="59082614"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 03:24:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 03:24:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 03:24:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 03:24:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=be+E/L2lPSxlbEVIUHiJOQz2o5L4Q6ZC5mTUsFQdfDlfosNqRcGQlMmLEPlxv3VVR5YBlEYytMJA3dIHhVWPtikrKDPnyn2Kbr8TGScq0jjyrv+GtPCcvY5DRqjwwifLjbRr+K1XXRD2AMPtuEspzyqy4UKKgb+9GTlrtMr3rRmtVCoGPdVBXpbA0Gb9uWadpf6Z1KcLsk9yyAcFxZS9rIzlTgxrUk6RvmzNJw5gUnwUcPc0rLZtmfdorrwffPVTDV54796bI51Et9ue5XH5JlMDrfVsi1ycC3QCfoUfpmP8DqPf72YNdKghLfIgf0qQDMmoWjTtYxKA2Rqt6zkgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVAzUSEzJSu1LQtAHNhbX8JcirUS/n/vjpgHcOItxmM=;
 b=oYlP76gLI+71INbFTh26r+kOPlTlYNohSVx6FiHv/g+PUHnovso+T9pJZxibOQPdcl/RjNZl13wU2yaicSM0hVOvS/I8T/Fj4VO4EYef28e99RLSwr5PyN9MKiyKVxEXyPBufUZxoi8MiVF+T5MPByfBUHWL0C+6Zvv/WzfjET3mAt5JBQ1cOtLtzj7lk1xBrdxB1xzdf15f0e73kgx97QlRonZUoFDctNeRDc4gZZUXbLWLrneA9WAJQxfjrHrp2AFff9tc7mfLF1J85UCUcEfYec5iaTbbqbvmcJD8byr/54rgSfsD8uWn04BQBojgL0+x37+eDmzJPJXqlw7WDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Tue, 30 Jul
 2024 10:24:54 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:24:53 +0000
Message-ID: <dc1a31a2-a414-43ff-a5dc-1c75a5a80e2d@intel.com>
Date: Tue, 30 Jul 2024 12:24:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/3] bnxt_en: Add support to call FW to update
 a VNIC
To: David Wei <dw@davidwei.uk>, <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael
 Chan" <michael.chan@broadcom.com>
References: <20240729205459.2583533-1-dw@davidwei.uk>
 <20240729205459.2583533-2-dw@davidwei.uk>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240729205459.2583533-2-dw@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|BL3PR11MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab044f2-e62f-4340-fda4-08dcb081da0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekk4Mkp0ZTdNQytFbmR4RWhwMnVjUmZQYy9ydldOMVN0R2hQOU5uLzQxZTN1?=
 =?utf-8?B?Ymw1NElTT2JNblpaNEM5eW90MXEzYVFqOTBQQUNORWdWbERLWFhiaHorSVFI?=
 =?utf-8?B?dVVsWllzZXZMSlh5SHpDTGJidlc4WXBjYlB2Nk9wVDRSMWxPSGZsVGJXbmRS?=
 =?utf-8?B?OTJRWkRJT3FPTHF1djRoc1hEY0RUTDZBQnBpTmw5UkNXeUtsNlZjazYyTXNv?=
 =?utf-8?B?VGhKYkwzZTZLY29zMkJrMEN3eklqcmNWQnNPOE9LU0ZkTnpUdGlJd3QyT2x3?=
 =?utf-8?B?bGt0R1J4MWZabHVRd2QyR200VU1iNmNaS1VrdnZFZ0plU1U1NHUzU0hQUHo2?=
 =?utf-8?B?NFVITy8yb25sV241NVVPMkZ3VnRoREdYdklJSnhQeVcyQXF6Vmx0bmtmS0Vu?=
 =?utf-8?B?NWhuSyt3ZVYrajc1OUp2alFnKzdDeG1BS2F5dUhocVdQcHZsQVlaYjhwNmoy?=
 =?utf-8?B?Y2VKTlhCUzdqQmwzMEcvamhudGQ5OU1wVWFLTkZLbllTbGJqV0lGMW1VREtx?=
 =?utf-8?B?VENscktTMmMxWmNVdGJRTWVocHg1R0JMb1RLdkNJWXpMYUFiczZxdjh3Q2VP?=
 =?utf-8?B?S3JKRjR6SWhxK0RLWFRsVk5GQzJmaXJjd0ZGTVVxUDY3UlJUUGVGazd2Znlu?=
 =?utf-8?B?N0lDSnFxemhEcERZUUVEZmpPQTVXOEs0N3RSMWJ6R0tna3k4clRqTitDblJr?=
 =?utf-8?B?Unkwdlh2Mkh4S0xTcTZBME1HVXhUQTMzdmx5UENiN1BNUVFBWkxqVGgzZzM5?=
 =?utf-8?B?bHB0S3RZY3hPNXM0eXJJVk9lRGhKRXJ3YXhoRTFIZS85aUpMSXhDcWZXVzc4?=
 =?utf-8?B?cy8xenVJTEdoMnNncGV6L01ISXEzWERnTkVYQ3dyMnZNUjgya3RKZVlqS1Vv?=
 =?utf-8?B?dlZCTkJmQWZZOHJ2UUo5OFlqbU95NnF3c2haM1o5UG00azdSODNWWkR2dktj?=
 =?utf-8?B?Rlg5citjT0NXZWQ2eHRvczF6bkZlblp1dmFIcEp3SkJ2MFhhclRiN3J2ODYy?=
 =?utf-8?B?V0d4bUc3Mm1FSDZLZ1ByWnV1YVNOaTI3NlFFWTFqcVZ5YVZSVzhvRzJwdnFF?=
 =?utf-8?B?OUROWjNtV0R5R05hNTVEd1pXd3FMVU9hMWVmWU9ISFhhS3dyd1kzSnNYM1dz?=
 =?utf-8?B?dFlmdHBmOHB2T1V0QTlrRGdDWS9OQTRMMFpSb29vektDR3ZpU3pBY2JrY0xr?=
 =?utf-8?B?QU9yR0xaMnlDRXZVb1NRNzk1aHBJZmZ1b2dXT2NOcEo1ZkdNV29QYzZFQTdp?=
 =?utf-8?B?VnhPTENYYms5K201by9MWTNTVjNEOVRhdzIvdkhqbWFpbHVFeWszVGtJS3h6?=
 =?utf-8?B?RzM1N1U0UncyNnVqa05kOHVUOXFKN3gzV2FmVDJXN1ZsMlhTOFhVbTJ4N3p5?=
 =?utf-8?B?NDFPcG5RSzVpbUxLNHVISjdaTWhlaFYwSU4zck5yWnA0NmI5Q0tkOVI0cjdq?=
 =?utf-8?B?OFJIM0MzY2V6MU9uWVYwQWJLaTV2SGMyU0pkbGxjNmxCc2pkOStqZDlUWldz?=
 =?utf-8?B?bTAyYndFMi9Xb0M2WUFKdzNmUHVMRTlYeVBrMHM5dCszOHJ3N25vSEEydUlF?=
 =?utf-8?B?MjNmZ0NCNlFGS3JlWi9VZ251azNZV042a2RHTStvUUR0M1BPV2twZm40Rmxn?=
 =?utf-8?B?MG9IdU0xdS93ekp2WGdPYzZtNjBHSXI1VWJoWVFST3p0aGFXUTFtRWtVaGUx?=
 =?utf-8?B?WEZJKzJxSW9PVEpzWTBGcmJjcFdvSmlLa3B1dmd2TmEwaVFoeTFIQW1xbWdH?=
 =?utf-8?B?c0FNUUc3L3NFcjZRSWVvNDhaSWxwdlQ1S0cvV3VuNG16eEpIVDlQZ0RVYTNh?=
 =?utf-8?B?UENxTDJldTRoazJEU1luQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVYVWIyYzlrbEp1V1BCNFc1NlFLNzE4NDJ3REJTV2RJSmJ6eXFmSEVzVnFq?=
 =?utf-8?B?RFV2Z0wxUVN6bktNK3E1K2hUeTZzNmp5N3R5M1ovVFlOTzVEYTFxd3BuZkht?=
 =?utf-8?B?U1pnNjNrQkNnRlZCbWM3SmsvNWpZUlRUclZjOUR5eUUzRVdwV01FUnlMcTZM?=
 =?utf-8?B?SEg2RnNBNVd4bDV1MlExTUVsNkZXN2xxQ0NRcDlmLzFoZlhQcWQ0Q0dLd3hL?=
 =?utf-8?B?MFlUWVhicVgxVXJEUWFTVkNuZmlqVENMRDF3YmdpaHFvM3UzQXJvems5ZWJO?=
 =?utf-8?B?QjFrVnVJdkw4bkxuTlUxc1NyUWlYSHFXT3c3eGhYT3BYZXpEbHUwNEpxRGpV?=
 =?utf-8?B?YkJzUG5RRUtHa3BaNHExaGwyV2hxSTU4KzhGaDdhM3c2Q09NV1hLWExPRHBQ?=
 =?utf-8?B?aXJFWVJaVnlvUk9YZ3piem51ZEFFT0F3Yy9kWW1wUm1VRm9sTzR0Z2R0ZFJr?=
 =?utf-8?B?MGpJcTJHU0NWMDJzczVGZ1M3K1Ara2toVnFQT05mclpLbThLM2xpcUlROHJu?=
 =?utf-8?B?RDBkN3FIWGg1MHJCcnJkUkt6K1VraGtJZStTb2JkS3AyL0hEVkRrcGpoSVhM?=
 =?utf-8?B?SUExd3pubkQ2dFBhcmJhWFd1UXpLUUhKTnFwU083aFNpOGFCcFpsQTVWVU0x?=
 =?utf-8?B?bUZHNkxnZmlRR21kb3Vma3NvYXJPRHl0SGFkd1JTTjJJVGVwWWpmVmdsQ0dl?=
 =?utf-8?B?ZGkyVENsUkhsWklRKzMvd2V1czlhVUlaczQrU216ZmJmMTY5dWVVbWtGdUVR?=
 =?utf-8?B?UlJsWkJBOGpVVlVkdCs3NFJDYTBwRHM0NndmR3AxWGpYckNIcWp1UEZWOVY1?=
 =?utf-8?B?dE5SR2ptY0ZsYWxDWUwvMVlLSmJrNDRtV0swY1ByRlpOQ0MyRjNGNDJGRER6?=
 =?utf-8?B?TS8yMDMycEFyOG1PNjBIdVRlSFNuU2lrNEE4RG12RWk2YkQvU3ptUTFHTVY4?=
 =?utf-8?B?NWttZ0YvSC95aTh4enpJMW5rMmp6N3VOc0lxSWt2VXpiR2hHTXZUaEZUSGFB?=
 =?utf-8?B?WFRiZm5xQ1dDaUY2bStuRS8zU0hTTDRZN2w3amVhQjJlNWg1NzFheW9xVjBT?=
 =?utf-8?B?UjhxNHhRcHZETklFckdwTWZUa0dMMCt2aHdIRU9zZGlXTXVOZFN4ZmpmTGRa?=
 =?utf-8?B?SlBCdDNwbVVCamJ3VTZQMW1aY3FYRUV3NDZwVHBldVRMT05mZVMzbDk0a2Rh?=
 =?utf-8?B?cjhRRjY2ejZRRTgwS0ZuNUt1Y2d0WElhbW40WWdoL2VMMTE4UzY1TktpYVcz?=
 =?utf-8?B?dU1TbTZOeVE1WVpOMXlvbVoxQkhjWUhXQjVDeW8vUVZHTFJMbnhlZHNpM1Zi?=
 =?utf-8?B?VUFjRU1YdUxWbGhVcWhZc2ZLWmxQOXZkTnJNbWNvYkFIV2p4SXdIZFRWcnV3?=
 =?utf-8?B?ZTQ1VTY3eGZ4b3IxanRzTFpqZmprazcyZGRWMXlISGZtRGJDb0FDSHBCdFg4?=
 =?utf-8?B?T2xQcWJ0TEVBa2lGNU03WUVyWmxHb3EzWW05OHh5SlpUcTdnMlJDK29Bd1JL?=
 =?utf-8?B?WGxjOVhubVdMSHkxRFBIMVlqdStsbWE2M0FwV3JWZGlWeDZldTR0OWhHUUZu?=
 =?utf-8?B?UGN2dk9ZLyt6REk1WG9Qd01vcEdHbUgzcnlzWlg3a3FnQnZuclZXek83ZEVE?=
 =?utf-8?B?Vy9yTlZ1ZkcrZlI1ZG5hK1pkbW12bndwSFRBaUFvTTVyRDBYVDhKdUdvYlVD?=
 =?utf-8?B?NndTM3NhMzE1MXFlbGhFblpoZUNsd3ROYjdHMEEwMjQzYmtQdWtVU0NyRTRr?=
 =?utf-8?B?SC80YisxbmsxdS9YZHoxS1hZSlc2T2Y2S2piM1F2aytaZHlWdlpwNUhTVGM0?=
 =?utf-8?B?VmFrdDRnQ2d2dGRXYk9FY3l6Qjhnd1dZbm1ua3VDV2dHTnNYZk1KTGVReVRI?=
 =?utf-8?B?cUNLVjBOZWtralJVTy8zaWlVUXluMFdxQTJyUHdMMnZ1YmIxaFFPdHltc1Jt?=
 =?utf-8?B?aFV4dnN0cnJGRUdmRHRTU1d1WFg4RWE1YXRxL2VyOXpjYWVSR1RRQ0kzUXM2?=
 =?utf-8?B?RzRKZlFmYzhjZEl3ZmtIdkxoOUVxSUtBS2Y0eG1XYjd1dkc0dkRtbW1ySllt?=
 =?utf-8?B?WUJ4RFNHdGJibjBBTitHTFUxNFVJYmppNEE1Q0FkTU9NK05wSC93Q056UCsx?=
 =?utf-8?B?YStmYnBaTVc4TU5uYit6b2lyVDV2Vk9kajNCODRmZVlhS2V0RHVJaFlTUld4?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab044f2-e62f-4340-fda4-08dcb081da0b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:24:53.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDSdVeCeoiXj05C9CMWYocvqR65TAV6QZXIq514GMuWfR3tVMmDzFxMrlVbk6dlpWILACsR21nAHVrD0hf15jE9s/g10IuUSRAmVKVFtg50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6436
X-OriginatorOrg: intel.com



On 29.07.2024 22:54, David Wei wrote:
> From: Michael Chan <michael.chan@broadcom.com>
> 
> Add the HWRM_VNIC_UPDATE message structures and the function to
> send the message to firmware.  This message can be used when
> disabling and enabling a receive ring within a VNIC.  The mru
> which is the maximum receive size of packets received by the
> VNIC can be updated.
> 
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 23 +++++++++++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 37 +++++++++++++++++++
>  3 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ffa74c26ee53..8822d7a17fbf 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -6579,7 +6579,8 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>  	req->dflt_ring_grp = cpu_to_le16(bp->grp_info[grp_idx].fw_grp_id);
>  	req->lb_rule = cpu_to_le16(0xffff);
>  vnic_mru:
> -	req->mru = cpu_to_le16(bp->dev->mtu + ETH_HLEN + VLAN_HLEN);
> +	vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
> +	req->mru = cpu_to_le16(vnic->mru);

These changes seems unrelated to the topic of the patch IMO.
This goal of this patch is to introduce the new firmware command that
will be used later, if I understand correctly. Maybe those lines should be
introduced in one of the later patches.

>  
>  	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
>  #ifdef CONFIG_BNXT_SRIOV
> @@ -10086,6 +10087,26 @@ static int __bnxt_setup_vnic(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>  	return rc;
>  }
>  
> +int bnxt_hwrm_vnic_update(struct bnxt *bp, struct bnxt_vnic_info *vnic,
> +			  u8 valid)
> +{
> +	struct hwrm_vnic_update_input *req;
> +	int rc;
> +
> +	rc = hwrm_req_init(bp, req, HWRM_VNIC_UPDATE);
> +	if (rc)
> +		return rc;
> +
> +	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
> +
> +	if (valid & VNIC_UPDATE_REQ_ENABLES_MRU_VALID)
> +		req->mru = cpu_to_le16(vnic->mru);
> +
> +	req->enables = cpu_to_le32(valid);
> +
> +	return hwrm_req_send(bp, req);
> +}
> +
>  int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>  {
>  	int rc;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 6bbdc718c3a7..5de67f718993 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1250,6 +1250,7 @@ struct bnxt_vnic_info {
>  #define BNXT_MAX_CTX_PER_VNIC	8
>  	u16		fw_rss_cos_lb_ctx[BNXT_MAX_CTX_PER_VNIC];
>  	u16		fw_l2_ctx_id;
> +	u16		mru;
>  #define BNXT_MAX_UC_ADDRS	4
>  	struct bnxt_l2_filter *l2_filters[BNXT_MAX_UC_ADDRS];
>  				/* index 0 always dev_addr */
> @@ -2838,6 +2839,8 @@ int bnxt_hwrm_free_wol_fltr(struct bnxt *bp);
>  int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all);
>  int bnxt_hwrm_func_qcaps(struct bnxt *bp);
>  int bnxt_hwrm_fw_set_time(struct bnxt *);
> +int bnxt_hwrm_vnic_update(struct bnxt *bp, struct bnxt_vnic_info *vnic,
> +			  u8 valid);
>  int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
>  int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
>  void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
> index f219709f9563..933f48a62586 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
> @@ -6510,6 +6510,43 @@ struct hwrm_vnic_alloc_output {
>  	u8	valid;
>  };
>  
> +/* hwrm_vnic_update_input (size:256b/32B) */
> +struct hwrm_vnic_update_input {
> +	__le16	req_type;
> +	__le16	cmpl_ring;
> +	__le16	seq_id;
> +	__le16	target_id;
> +	__le64	resp_addr;
> +	__le32	vnic_id;
> +	__le32	enables;
> +	#define VNIC_UPDATE_REQ_ENABLES_VNIC_STATE_VALID               0x1UL
> +	#define VNIC_UPDATE_REQ_ENABLES_MRU_VALID                      0x2UL
> +	#define VNIC_UPDATE_REQ_ENABLES_METADATA_FORMAT_TYPE_VALID     0x4UL
> +	u8	vnic_state;
> +	#define VNIC_UPDATE_REQ_VNIC_STATE_NORMAL 0x0UL
> +	#define VNIC_UPDATE_REQ_VNIC_STATE_DROP   0x1UL
> +	#define VNIC_UPDATE_REQ_VNIC_STATE_LAST  VNIC_UPDATE_REQ_VNIC_STATE_DROP
> +	u8	metadata_format_type;
> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_0 0x0UL
> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_1 0x1UL
> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_2 0x2UL
> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_3 0x3UL
> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_4 0x4UL
> +	#define VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_LAST VNIC_UPDATE_REQ_METADATA_FORMAT_TYPE_4
> +	__le16	mru;
> +	u8	unused_1[4];
> +};
> +
> +/* hwrm_vnic_update_output (size:128b/16B) */
> +struct hwrm_vnic_update_output {
> +	__le16	error_code;
> +	__le16	req_type;
> +	__le16	seq_id;
> +	__le16	resp_len;
> +	u8	unused_0[7];
> +	u8	valid;
> +};
> +
>  /* hwrm_vnic_free_input (size:192b/24B) */
>  struct hwrm_vnic_free_input {
>  	__le16	req_type;

