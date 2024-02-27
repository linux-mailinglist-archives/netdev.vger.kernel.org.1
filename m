Return-Path: <netdev+bounces-75307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F11869159
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CA11F28956
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8397A13B285;
	Tue, 27 Feb 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cee9L1LL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FAA13A895
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039209; cv=fail; b=aq3FUupJSQCOIT4jqJi4U126XC/nqUC1rbp7dzuMB4Nvav2XWdcmuWyzic6YHfIzE5W+gTyAJfvbBC3XcQO+vwXmBBGU6fWWjsMzs1OfDo7UeEgCtLBnl5dnB/b1k6fZ8AhVdt9EryfN+0J6oPPoizcMfRMLO8L4d7AolPRqQ3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039209; c=relaxed/simple;
	bh=LB45HmSle/UOVQmHTCTPfrRiHOzY402r4tuthV2Eak4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s/iDkDRKngr8XTVJsUYkD9GBYPYqsoZZYIkd3Z3wGLSeIF0AwX8ortV9FJ4ompf0KqTrEMwUgRBOr1gpOmE4dZHzrcqIkzZ78Cg+KuRJoNTyqo7S03EKYsaCXsvAom3gDjgfcxN+4THrDvxwtrRAhx7MQEla3Ph0M+Hw0of0YLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cee9L1LL; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709039207; x=1740575207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LB45HmSle/UOVQmHTCTPfrRiHOzY402r4tuthV2Eak4=;
  b=Cee9L1LLyGlbk9lLYU/BUzrfsuLZf0XCxhnEP57Q74XPtraHUvNDQrUv
   KVjksSTISKw8dPJjVzoalonqLsRdqiwGMtcniLOgypDgoU4svGSfA4wQU
   BQuo/qYcku8iETfNJbqzAQxz+eO5fxvR6AQsswOX+jIpMTwk0ofq5b4Vd
   2hrBm0TJKaXinW8OrO1hsWUjYHvaxT0/VV90L67X0gSFMjDDfDTol2kLx
   EEFT1UliK6OvzEXfZHfNzW5HH7eGFBQKhluspgqgU3JcS0QpV3rsUIcx/
   3PZhrQnhXP3MnqEg2WvF7zHT9IrdPMYsJVG2i9zZOOhqmVuviIr1OQf+B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3220864"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3220864"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="30208767"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 05:06:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 05:06:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 05:06:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 05:06:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 05:06:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMGxwP2PecKSnihr08v9qddWlKNP+zome/nzHSa8cIE/Di7Iff15n3S7kP96qRTU3bqE4WvsV/qd5a7MxPOxawtn5Am3/n2/22trsnm5CgpJeTomFp2x6N2bF4Hxdpua92/uYBm8nipKboBMHPDotV9fLejgrz+PE/yL7888Fo4WqyGnYm1DB1qdVrxsaptfQlAftshYrAKL5jxs4pBctAMhM6r75KUnnSFKN6/MwVs3IDEC8LwnHXum7ExLwPhM06aPo2E6lExdljTbirEi4C/qHzRmI6xFfrbYU8rhEegZ4o1hb6yUDAVuXr6svj/kbYUeBHUKwtcc+uT77Q3msQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9F0ivBopztobkqW6jMHQFTCijjrHBdlV+DR1kD3h/w=;
 b=OaKq+fR6yx4XxpEA54jzmCl8+n1tm4cqVEPC1fxvNys2a01CBwGCJ0nAC4SGhRGEeeLMRo2w20f9591FzPly0SVi2jTMiW1mLNQyBooJGU5l1fFp5P1Qg1P6csqbEXdqFUATQv6ppd0m3Uqt94wSHYwUxoPCJcg7K6MqkireCK78L4Joh10MFsLzkcvQKG1BHVIja6vnl4y8jkaeA5246UozFR5sNzszgwyv4LKUij0dbltKkMLcPCwUzZU/tfel+Du1AbQLyer2RFbZiyDpSQvrrqKO2153l1WT2DLZBwbBTYiwasYug/mm6pQYHiLGDxyA3ks6PqHOC/cxSjwZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Tue, 27 Feb
 2024 13:06:43 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 13:06:43 +0000
Message-ID: <10fbc4c8-7901-470b-8d72-678f000b260b@intel.com>
Date: Tue, 27 Feb 2024 14:05:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
CC: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<horms@kernel.org>, Lukasz Czapnik <lukasz.czapnik@intel.com>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
 <20240219100555.7220-5-mateusz.polchlopek@intel.com>
 <ZdNLkJm2qr1kZCis@nanopsycho> <20240221153805.20fbaf47@kernel.org>
 <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
 <20240222150717.627209a9@kernel.org> <ZdhpHSWIbcTE-LQh@nanopsycho>
 <20240223062757.788e686d@kernel.org> <ZdrpqCF3GWrMpt-t@nanopsycho>
 <20240226183700.226f887d@kernel.org> <Zd3S6EXCiiwOCTs8@nanopsycho>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <Zd3S6EXCiiwOCTs8@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|LV8PR11MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c4569b-244b-4686-52ed-08dc3794f204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGipU9yVHqAwV7/xRsB6LxKSFO7Ys2tpMAAaH6Mp7ROHShbBUwXzausDoBEyMO7TfFIwMQdKoADyEjXXnGAmC479Uxuv8py+uUZ+9J2gkPOiJ3+90IgbgyucrMnxK82NEz8d5EZJs8iESMS1lQsbELfh2lPzQJF+T4t0VXn+Pfw8IcCCFVKnFhDiOYKEVFDyegMZcBZLED+67STcRihjhW9vQBlkeEBGZCx1qQD67oLnn3qE7zUtvdA3aUT2uks1+P0IoYJvyjWq/TDbiEI3WwQ3XwdF9V3cjCCBqrjN+Hu2r51JpUR0Z2laFAeApvzFLOIXmhGfC90vN39GLi0w+KRNG1PudUVoWbatarCHncuBrZWOf7gpX++V2oVtDnTpDmMoueNvAYlFMxz+GSvH3qyH8d4hLYfYnPJ+vOnEuNRt9oebNKpk6OzkJ4WXRz3YaHaQ65+Ms1DLsxLLZAbaHk98jxwqeeguhH0/6EmQ2DpuuV5IOukDacVFNe619ngHd3K3LKrTjTdDdA5FiC3wNRcVPhXcI78kuFnbfiGPuQ35RlTbotAcpZ9Y7dgR/VVZxFZ+wCZbI6Ib3dmQLgcb71DXrTLFrtnRQWpX8HFpxrdcZT+gwZagHz2r3eTxu3ECcml09frY+hwNpASWT7TXhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3o1R0liUkx6OFF2RW54ZnNyRng4OExHNnlnbmd0K3NzOFc1Yk9oY05NSEdS?=
 =?utf-8?B?N2dHUnAxS0dUYXkrdkZJdm9yVjRWQ3hvU3FMbmpOamFWcnlaMGp6MERVMUhS?=
 =?utf-8?B?U1dxanRiYU5lZjdWK0R6NDQ1Q0s5Z2FBWThGR3BoSGlFMi9qdDh5Z2J3M1pT?=
 =?utf-8?B?S1FiaWI3V002OGdUYTY2N01vWkJnL2xyTDZmdGhLbnZrOUtRRlpKNUVmUFhU?=
 =?utf-8?B?VkpVemlkQmlmUmc5bkxRTXF6dkFXc1VwUzFNdkluT0U0WmNuM2N2NVU1UUh6?=
 =?utf-8?B?U3d0Y253dFozY0lWMGpNT2hGOFFjVXZKTG5tN1Q2ZUYxU0p1VXlvZ1dqTTRV?=
 =?utf-8?B?SFlERXordHBJTzBKNnlTZWF1eFNjVkxGUDVxakkwMGxBT0Fld0hQZnd1VnlW?=
 =?utf-8?B?L0NoZW9kTVhHTGhadjkram1uUHVzTGtrVDZUeXNhY0oxZDNHS3ZoNFByL3hU?=
 =?utf-8?B?bHk0MlZ5TW9JU1BkYU91MFBUTGtDaFNhRzlFRWVmL3dwQWFBL1N5Ym5ldzJV?=
 =?utf-8?B?amRFeDdnTlIxRUNJWXcrWElYbmh0ZThDaGNmQ01rNG5iWCtQQUZYKzVSbHIz?=
 =?utf-8?B?bytrVnR2K1ZrNFl5U1VkZmlhVlV5a2V0WWpGV0NrZ2hEYU91RThCNDMzU2Jx?=
 =?utf-8?B?Q0pocmtIOWJ4ci9KNDZGaERvQjVkVVJQajZjRGk3K3RnN3pLbGpsWU94QlVC?=
 =?utf-8?B?Y1N5WmJzVFE3N0JtVHk0Zml0eWl4SGdlV2g4bVNlYnJURUpiV3daQjVzNWZT?=
 =?utf-8?B?LzBuTVAzendHMC9weDZCNWZVU2YvTUVSOUsxc2ExS096dHljK3JudFBUSUpB?=
 =?utf-8?B?aWJIZ0hSMEJ1ZTdCNjQxK3cza0xUblZ3OHJTd1R1YTMxbTRWdVdzRWh3TGJv?=
 =?utf-8?B?TmJrQXd5bkxGanRxQjNNV200NkkyU0t5dFRSMndaUEVUUS9HditscC9VUmVJ?=
 =?utf-8?B?UE9uZHA5VmhlWHdmQnVRYkVpOW1jd2NpYUVZT04wZytrVk5GZUVpdEFsc2tC?=
 =?utf-8?B?UDdVdzFldUQzdFJCaTdwQ2hXcXNYbmd3VEk0azQ0MW9nb1RjemE2eUdlYW5m?=
 =?utf-8?B?cjlBcHVySEhGV1NSR2RjbUcyRklleVorZkxsSm1ieGhhYVpLOFNvY1o1UzhG?=
 =?utf-8?B?d3ExcDJmY0hrM3Bjbll4UEtmVERBM1VoQUNnTHh0V1NGNE9lYnFhQ2NJamF0?=
 =?utf-8?B?VXBlTWZTMjVDVm5ScDQ5VUkrUUs4dWRSM0wyWUJGNWg5NldKZXJUSk9iSTky?=
 =?utf-8?B?Z1BrSFIrMnloMHBUMEVVczgwVmsxcTZvV0l6K0Z0VkpvaTcyRnFBcnlaK0U1?=
 =?utf-8?B?SG9zd0huRHJSNFJyekFHTGMvdE1WeG1KamRZakQwYlcrWWlhRXBXOEpWN2VO?=
 =?utf-8?B?ZFVuV3NweUsrdERlWWw2eW10MnlsVWJqUmR2VTRXTXdLYm8wU3BNNWZtSWlz?=
 =?utf-8?B?R2hwZjF4blk5ejBCTDljWDhWdWQyKzFUS3VXR0lXdE9mdEpxbDduTmpRL0Vn?=
 =?utf-8?B?RUJnVlpiUkNsaHhkSUZDeFdjaHFLWCtvaUdadzRtdXRNdUtyeFZvdEd0T09u?=
 =?utf-8?B?aUIyaGJ4eE1yaWJLOGVVMXcySEJoaktGSE1OL3R6WlBxZDI4R3VYSnVMd29o?=
 =?utf-8?B?Si9uU09aNTVEYTBOVWpJTS9NUndMcS9uaVVpK2RmOVc2T0VnYkplZEJLYlVO?=
 =?utf-8?B?dVUzaUpXbTZsWWpTZFJJMW1uT3lGUnlRaXFyWldJbDY1aUZycGlBYXBhc3pr?=
 =?utf-8?B?bU5QYkhadm45TmUraDRzRG1EbWVhbFNMc0IrNEpwN1A4OVBUQ0RVZ015WCtE?=
 =?utf-8?B?dmMvSkNkYktBUXhxcEQzZ2JiTmM4WFFUQmVyeVg2c0JqWFJaQUFjd0YvZ1Z1?=
 =?utf-8?B?UTkyeXFYa21vdnVkVHNRc3lTN3FHOHBPOHNjL3lyR3F1Wnl1czBWQjFWaXpy?=
 =?utf-8?B?Vnk3U2tIM00zUWRmVnlUWElSajEzUVArbXdFbVlSWE53R3FkdTc3Q0NLQXNW?=
 =?utf-8?B?cm1iUyt3Z1VmNHNWaUUyRzZTN0JObWQreVVLakZZQjhraG9pek52aGxjbmJ5?=
 =?utf-8?B?OEtvaDlHWGt0SUtHVVNHMitFSjExazErZGJrUFNNZGFLc29KRjJVTHZkVi8r?=
 =?utf-8?B?b05nNWRYSnZWZ0gwS1F6SDdtS1JhWGc3YlJPT1Y2WWFpR0JLOTRnOGxhTENm?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c4569b-244b-4686-52ed-08dc3794f204
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 13:06:43.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+irMM2nz9EsYOV4RFJPCcjhUdJF/O3qwnkXFIK7d/sQ14w+ii7hpHSlTjcuss4AQsWImFfXeMzKby5i+x9QkM/tUoWyIKRXghFf5rZbgLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
X-OriginatorOrg: intel.com

On 2/27/24 13:17, Jiri Pirko wrote:
> Tue, Feb 27, 2024 at 03:37:00AM CET, kuba@kernel.org wrote:
>> On Sun, 25 Feb 2024 08:18:00 +0100 Jiri Pirko wrote:
>>>> Do you recall any specific param that got rejected from mlx5?
>>>> Y'all were allowed to add the eq sizing params, which I think
>>>> is not going to be mlx5-only for long. Otherwise I only remember
>>>> cases where I'd try to push people to use the resource API, which
>>>> IMO is better for setting limits and delegating resources.
>>>
>>> I don't have anything solid in mind, I would have to look it up. But
>>> there is certainly quite big amount of uncertainties among my
>>> colleagues to jundge is some param would or would not be acceptable to
>>> you. That's why I believe it would save a lot of people time to write
>>> the policy down in details, with examples, etc. Could you please?
>>
>> How about this? (BTW took me half an hour to write, just in case
>> you're wondering)

Thank you!

>>
>> diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
>> index 4e01dc32bc08..f1eef6d065be 100644
>> --- a/Documentation/networking/devlink/devlink-params.rst
>> +++ b/Documentation/networking/devlink/devlink-params.rst
>> @@ -9,10 +9,12 @@ level device functionality. Since devlink can operate at the device-wide
>> level, it can be used to provide configuration that may affect multiple
>> ports on a single device.
>>
>> -This document describes a number of generic parameters that are supported
>> -across multiple drivers. Each driver is also free to add their own
>> -parameters. Each driver must document the specific parameters they support,
>> -whether generic or not.
>> +There are two categories of devlink parameters - generic parameters
>> +and device-specific quirks. Generic devlink parameters are configuration
>> +knobs which don't fit into any larger API, but are supported across multiple

re Jiri: Generic ones are described here.

>> +drivers. This document describes a number of generic parameters.
>> +Each driver can also add its own parameters, which are documented in driver
>> +specific files.
>>
>> Configuration modes
>> ===================
>> @@ -137,3 +139,32 @@ own name.
>>     * - ``event_eq_size``
>>       - u32
>>       - Control the size of asynchronous control events EQ.
>> +
>> +Adding new params
>> +=================
>> +
>> +Addition of new devlink params is carefully scrutinized upstream.
>> +More complete APIs (in devlink, ethtool, netdev etc.) are always preferred,
>> +devlink params should never be used in their place e.g. to allow easier
>> +delivery via out-of-tree modules, or to save development time.
>> +
>> +devlink parameters must always be thoroughly documented, both from technical
>> +perspective (to allow meaningful upstream review), and from user perspective
>> +(to allow users to make informed decisions).
>> +
>> +The requirements above should make it obvious that any "automatic" /
>> +"pass-through" registration of devlink parameters, based on strings
>> +read from the device, will not be accepted.
>> +
>> +There are two broad categories of devlink params which had been accepted
>> +in the past:
>> +
>> + - device-specific configuration knobs, which cannot be inferred from
>> +   other device configuration. Note that the author is expected to study
>> +   other drivers to make sure that the configuration is in fact unique
>> +   to the implementation.

What if it would not be unique, should they then proceed to add generic
(other word would be "common") param, and make the other driver/s use
it? Without deprecating the old method ofc.

What about knob being vendor specific, but given vendor has multiple,
very similar drivers? (ugh)

>> +
>> + - configuration which must be set at device initialization time.
>> +   Allowing user to enable features at runtime is always preferable
>> +   but in reality most devices allow certain features to be enabled/disabled
>> +   only by changing configuration stored in NVM.
> 
> Looks like most of the generic params does not fit either of these 2
> categories. Did you mean these 2 categories for driver specific?

If you mean the two paragraphs above (both started by "-"), this is for
vendor specific knobs, and reads fine.

