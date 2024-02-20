Return-Path: <netdev+bounces-73433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D634D85C61C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B79F1F2365F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C61914F9CE;
	Tue, 20 Feb 2024 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXjLHstd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012C14AD12
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462384; cv=fail; b=SwMWC9A8GeES0hReq7oguTjh241sxygSq1h7/onL7mig8CHZkMPHjqZ2pWBlarEoSqR84gG8NhosxmX0TYJPwUSGd6t1PGj7ChCXqrUJFCOaFk/JGg2JPndTdlA/vX0ewmlA92hHy4THoxMlD2LvAbrSH2qFooGR/nUyg7jQFNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462384; c=relaxed/simple;
	bh=IGNXfm9zOAbXFJZsvk6TBgA5Ef0QV42GeNfzfQFJqYw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OUqg8ZIkMQ5Fe+NIaz3Iv7uVWf/wUEkldNTGTmvhCxlaJ/P3XY/I9RYCHQa8tNZChcJ1CDFYH/o6g4PfXz1yA94sxd0Kg2pw+X2eu7xnidzF6SqhPXNuIRivmY/2Dcy2CW+2z5hf/X77yVRxNX74rRAaABi8w0xhAasLpePxYtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXjLHstd; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708462383; x=1739998383;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IGNXfm9zOAbXFJZsvk6TBgA5Ef0QV42GeNfzfQFJqYw=;
  b=WXjLHstd08/qcJzSoTFE6SwECPzeFh+YiGrZB7k+QM8qlYHbK1uJD84e
   P2RN8c+k/ZXgzsdwkbCY/BVJg0omTA6xl4WQ19e+56EnhglHWGTfgRMNi
   p3oqcau2YM9i7OAIIkm1pfIFRMKr0zsVSRmVWavken1TiwabR3kL4kCd7
   aW+RYGAWVMsz2LH2DeClAban/HfpgYdriqx0gPy/ku7EjoEHkjnxb5ipH
   sI3XVzcHdCajj/uPsF6ezz0+az0rRkGmDa5LAgwDgB5n/yD/FfDjqDWv7
   +EsHxJuRMahGip6SZc6lCVk59lA104r7d7gI0uQ6/xBzEX1ueTvwqc2gv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2452820"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2452820"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9506611"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 12:53:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:53:01 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 12:53:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 12:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq6Bw9Eq4lFNWh6L96/JgqBk3SdFzb2WsaOeisqai9V4MBgvqcGpFr7PMBXIPPZRB462VPGYtqYJkCPEUdGwEbe9pSOBRBhGzARgrhwTogB/gbt2q9T4XXhRy1sApBMPapMfDs/umNkCjaDRSa9Xds/yRJYDoCuCIroWctYuhhBfq4ljJB4VB8DEMdrzJvGGrx6Y7Pud3pHBYeYK4kSYW0Hp3X6LUQ34G6jgcSL7qkYcD0YV4LVugjjnPPwZU5xsQkE1RiEU/78qacNIBxMfKOA7oF6g7AVYMcqFR5dckIN9v8ZruE7H+mjhK6yHQhHgNh6kLy0CDM+7r9tSqMnpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96mn8CD5t322KNPNgKA9x56fAuXzi3eNarBw6vYc2vo=;
 b=GyscoXcmGOcQJsELN/+O27KWHq41V6Sua9h1FNw5YCruP0qq9w9v1HTBGv/YsIdOSrnA+5Tl0i2U8RpTX623RfKipYF6TRWDg2wxfg3+3uemo65y3YDrX2J5AmeRKIJTViTuqH/GlunxuLW7tSr9q/C585qlgftRWvhFZC3nzQIfSFLtCFBoOuIgb572W0BIUtsIwRtPqULyqfuCJTHtzxZghtDG41XHGKD5Q8+nAZq6UP1uT4GoEZdPr1fa59W1S2cHivHQvSpo/3FNMbqlycw5KWbQ16cpTSD1m0KKTT8tlaQpvRyPexQNJp1iRX2J3emeFb29Anz4QM80NQ7ifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by PH7PR11MB7100.namprd11.prod.outlook.com (2603:10b6:510:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 20:52:59 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 20:52:59 +0000
Message-ID: <03a5e708-518f-4635-b42d-3d25974675d9@intel.com>
Date: Tue, 20 Feb 2024 13:52:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 0/2] Fixes for iavf reset path
Content-Language: en-US
To: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: <netdev@vger.kernel.org>
References: <20240123233140.309522-1-ahmed.zaki@intel.com>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20240123233140.309522-1-ahmed.zaki@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:10:110::36) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|PH7PR11MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec6d2ea-7f7b-4801-6c34-08dc3255ebc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+WEQr0lEEk20wXPP2HxLI6AgWasJlXAnJAeBTKF6MaEzXQZ48kDcyzjbkdAY6JjEpQIWESuykgc1rs4AyRYKkLBMmba+JJE6x/R5o9ggWTAykUbXD4n9duPgfpD7b6/POOxySP+MyLibTBxOFD7hPyi8rMVtt/zhNaux/yN9h6xHzMWDTO7wq4TGcRsxUntRtH6GA1I2LsE7YJHlXggSEldq8Eqn1MK9ignBJ9OdB7cfrIuZuKKXT3hDwvPxe1ORBADNvBump+9HOTHBdPriBn/vzF4lV+E0eQ7NSPAXHPiAocDkPXYI09CYZg14r/qvQuUGVK1cZdpcL2QswF4CZCe8zwCpWxyHxifAnU/z9PLEFBjKxsVy1T61QiP4RI1PwSMTArZ5/w4CoUmJ+iPyb/BY95d0/1A3PWE59U64kcZHMdbRk+eeMYj9cHcOFsVfS0qylQUSlEQqu1Q28KbAPLy4gOa3FU4N+iQuomD/KoJXX4E+9bswHZlNt0b5NxVJdIxqisGtWcZRdbSy5lAKiGqlK405E9+qGQrdFG1pNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkU4M0pDQmNwYUVyZ1hkNTVDdkJaVUF1OHBZSzJEYWp3UUZTN09jRFZzS1F0?=
 =?utf-8?B?d3JXMENWdi9vZ0o3b3RkblRaT3FzYWpSZHF6dWNkZ21pOTg1N28vMXhja29V?=
 =?utf-8?B?UTdqRFRyZVpoUUpjMW0wbnJwcXBZNXNpbzA1cWlQSUtXS1ltbTcwa0NxSmYz?=
 =?utf-8?B?czVJeTVUa2NIMmhkSkF1UFR2WDNTZVY0OWtYcFNDT0k4WnZ3Vi9tN28vMWNw?=
 =?utf-8?B?VE9iZnNNcmlibmwyMnliaXBBTUM5eTB2NDlZdjJ6cFo3d3RSWUgxeVNhbEdL?=
 =?utf-8?B?czNoY3FTbGgzT1kzdTlpQU04ZGdZam5DYVN5aWQzVjJCTFZyVmZpZmZQMEJv?=
 =?utf-8?B?ZTVSL284blY0aXJuTUF1QnBiTXViOFhITkY5aGdqeEdIMWc1aXo2L21BNlps?=
 =?utf-8?B?L0s3eTZ5NGhyWGNnZWVFRHV2YWtXRFhic0w0QlM1SWF4ZWQ2aHk3Uktnd0ZM?=
 =?utf-8?B?ek9RRlpWazEyeHpyK0hVTng1SlQ0SEVDM3FtWXVkZjFRVCtaQ0JZQXI0dXJS?=
 =?utf-8?B?RndPS2UwNW9XNDJTM1RJOGtsRmNsUXpNK0dadTlvVGZ4MTIzYkhRQ0IvY3pE?=
 =?utf-8?B?Vk5OVU14Nk9BL0Exd2pvZ1JSN3NDSW9LbGkxUmdOc2xzNkJNK3I0RnFZZVNt?=
 =?utf-8?B?eUsxR3NvVW1Tdno3bnZxakxPWUx6Qk9kZGtMbHNEakR6NGgrYzFxUTUwOWVs?=
 =?utf-8?B?NTRhUFJySXRSQndNUHNHMmR4Z29ra0w0dy9rMURnWW5QcnJWZ2IwditFTGd5?=
 =?utf-8?B?YXZvQ2pPdW1zOHY0Tkt3MytjeVdZRUwrWi8zM1ZFTElhckdselZOL2NFYnY3?=
 =?utf-8?B?RGtDZ3dyTWRqcUJvUXJ6azdGRnR6UndYSWkwK3JTbUxKTUN0UUNHZ3JyMnNT?=
 =?utf-8?B?OWNFUThrbWlud1M4aTRHYTlzbzlZcnJhRDloVVhnR0pKZGE2WHFZcEdTb2tp?=
 =?utf-8?B?anJCemN2Qy91VGZrU0VYak1aaXRzamFQbHkrYU13K1Q4bHdsU2Z5R1ZqTDk4?=
 =?utf-8?B?eFlXdjhDK2hsYkIrNC9IZDRWam1lZm1pTlBYWlFMazNZYVJGWVc4ZWNTV3NQ?=
 =?utf-8?B?ZXlZSit3bWhFVlRxOTc1UGJvMFNDOFdnOUtvekx0d2hRMVhjYkNITTdHcVZ3?=
 =?utf-8?B?aVpvWmdpSGZranlha3RURU96Y1MzbWxlSzVTcHFxQ0did2VhQUlHM1lpMWdJ?=
 =?utf-8?B?eHdtR3BNaXhya201blFUYWlsRS8ySzlxb0FSbTB5ZDdSUVBtMjFjdVlRWnBi?=
 =?utf-8?B?SDlNSnFVano3SHc3V2ttTThvS05JVzFkc0phdFBydnZuS3BTTTlXTitlQTRk?=
 =?utf-8?B?YmxqRXV0TGRCTE1mWHgySWc2VFp0UzlyclJrZXhCUXNSRFU4MXp6U05jcER5?=
 =?utf-8?B?WVJ1UkdFSWtkL2tjbCswd2pLSS9Ycm5jS1p0MHJxMXlLelo3VVo3MWM3cTdM?=
 =?utf-8?B?RXVsU2hCVlkwNVZiZEhEZzZFSmh0bGdzRzFLQUZIdjA0Q3VLOCtyM3htSEo0?=
 =?utf-8?B?NEsrRDVuQlVOdzAwVE0zSnEzdDNNSjU1S0FIWTZyWUhXQ09sTkg2SFg4cFBr?=
 =?utf-8?B?ZUNueVl1THg5aENGTG1UejExWUE4Z3dpNVZJNGxmSjFBdEpkWEhUMUdyUCt3?=
 =?utf-8?B?OGZzYXZBOElNelVoUkU2RzAydDgzYXpCUHNxaHUxUU5UNmFqaTlwWFVHME9J?=
 =?utf-8?B?Zk5uNmF2eEg4NndsRVhTODk4dXExbTg4OGE5cXpNM0s5MVArTENqS2RHZWps?=
 =?utf-8?B?ZWpuOHdod3ZLakJEMlNwS1NjK2FjaXJUWGJGRVoxRnNkRlpRUW9BODFPSmdo?=
 =?utf-8?B?UGRlTXNpQmJXeTJUSU9zRWVHbGZZN0w0Y1BQWi91cVZ6QjhjY3ZlbUdpcmto?=
 =?utf-8?B?YzUzakFRcng1aElEWWlwK01VRmY4cHMwbVQrR2x0a0FJbC83ODRITjJmUXow?=
 =?utf-8?B?UTBlUHJjaHYwRjNhQURPNzdBMXNTdWtrMnVNdk1OVkh3QXZtSVA3TmpBZzFq?=
 =?utf-8?B?clZQcGhmTmlmRHZrTVVjSldEQ05OMWQwK0J0dWhXOFR3Qk10UldvMUpHNWJK?=
 =?utf-8?B?azh5bmFoSERMUUZqcUsraDI3R0V3L3JiNDBUWFMrTis2NHdOdEcwb2UrelNx?=
 =?utf-8?B?d3FPZjZmUS9JckZKQXBTSEFlOUdLZnBkd3FXN29HSlpMV2ROazdJWlpzbUdY?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec6d2ea-7f7b-4801-6c34-08dc3255ebc7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 20:52:59.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtrF96eq1LtP/SNnSpjAcmNcks5K9JOTp4JVsS7Iwc61t0mGNEoCLUpFpYWMclESKygpFePeHQIhehzxRmG+yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7100
X-OriginatorOrg: intel.com



On 2024-01-23 4:31 p.m., Ahmed Zaki wrote:
> A couple of fixes for iavf's reset issues that can happen in the early
> states (before configuring IRQs, queues, ..etc).
> 
> Ahmed Zaki (2):
>    iavf: fix reset in early states
>    iavf: allow an early reset event to be processed
> 
>   drivers/net/ethernet/intel/iavf/iavf_main.c    | 11 +++++++++++
>   .../net/ethernet/intel/iavf/iavf_virtchnl.c    | 18 ++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 

Stress testing is showing errors like:

[ 3193.412996] iavf 0000:b1:01.0: Unable to get VF config (-5)
[ 3197.115178] iavf 0000:b1:01.0: Admin queue command never completed

and

[ 3274.183144] iavf 0000:b1:01.0: Failed to init Admin Queue (-53)


more than we usually see. I will send a new version that better handles 
these errors paths.

@tony, please drop from iwl next-queue for now.

Ahmed

