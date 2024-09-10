Return-Path: <netdev+bounces-127051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 950CE973D9C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E189B25A37
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19881922E3;
	Tue, 10 Sep 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFRziydF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A021755C
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986830; cv=fail; b=C5QQpYCjuymYF4LxQIVJRjlvoVDWKyopuIA5MkSeOl1l9MUXzKToQM7W+4jGRxEpNsT/fxvQfjblnKjTB+MfTh+SKUz1NFUXzjgjQAKpEND6/QaV+qcVQQEwM6xB/pGnaJHsHcpx2TQtdgrc5/zKUAhqQ4O+LoKeABeAXHx8JfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986830; c=relaxed/simple;
	bh=FCexoN1+U1AH39SoujiPgHI86/pM7lRDITfvzCF8j8o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=stuQuoiZKwosn8cIzSHgcNyvfugVdeMVo9Fgr93VX64UK+DMdQ4PuyF6soTMQIylle6+SEJ3yDoc598YU9fiq0abFExW9NN18jYB9pGlqiILkhWnBylDMbVB7MilYAoYESkXwbXkrYb6oO1kwmMM/bIZyh8EVSbthD76xSW458c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFRziydF; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725986830; x=1757522830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FCexoN1+U1AH39SoujiPgHI86/pM7lRDITfvzCF8j8o=;
  b=RFRziydFrSCQCyr12HcrexiTvHxIsDsd4Qr3sY+HaJDJwR7WBz3omd6d
   O+7+hxKuBVymrKjtSTkh6SHBszzlnyHz6nBsdKHFcWkpln/+j+BgATjaf
   x6f1MTF0G3nQ3tX/aC44MjBcq3vPhQMjwi2Ryi+xy6ZfAZEvVxrUKzsTg
   WgDLI+Vd1wem/4HAS+Z0US6BvmZitEC8KozSnWhBIujoPafZDRoMPcjEC
   wQqzj0GnJf3uxw6QpDstQDDTNTq1zX2ZhFGEi77aVANg4RfLTqwFVdmol
   uVw3Ip01oALkMhqx3GidlWCA+WsG0azVRhCcJL50NNS9sQrbWcPGxoNPG
   w==;
X-CSE-ConnectionGUID: WR+mLnuNRfGLEmeWIYvK4Q==
X-CSE-MsgGUID: 6E9WPbdbSNm7TOl5ZyaJ5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="27668104"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="27668104"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 09:47:06 -0700
X-CSE-ConnectionGUID: 6vwJGFo1QeCoeFSfFi3oWw==
X-CSE-MsgGUID: 3xDgAo+VQbux2vSVwSa0Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="71233800"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 09:47:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 09:47:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 09:47:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 09:47:05 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 09:47:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k48UZ9Uwuhw4QVH7sJ4nTvvB09jXc6OY6NitzizMEDuUwzKnyCpz8fJ1ms/3OIZdiOAckgMKMucuQhcQ25zCSiZGhsJXwFuNr86c+5E38FJ5owbdbwfpwXTKXmqO6g57eKFenFRHb9kZwBjeFtO45VLRuxlVv4+ng7FXtO07ey7BaPHO8I7Fgzfdj87VMa9Om2allH2oMf19hAJfIyAAGjjiUlm87z3yEFPynAYCvKcgQ6DNkk0Go1lzkSr7hxKfz8CuWfEbphkp7QfyqWSGWVHeXmwe9IESyyKaahAp82SOApJ/206UC2gXINL9thZKtD+y80m0+G94sEwIP6cLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDBOM5Gu4qMKgdIxS1uOQH/fsI/sgae8O4fIqfYYj70=;
 b=N/cC5pi0JH9UxN5Ipwj50sXHbPHDUsjV3RGxgw49FopMg8INSiTLPnqWUFWeaIAcEed4bjheuuMA5gdDute5CdixIehqHY+81BlgdYxw/I1CiC0/o+Zju28EDznTWlJAadT8skca/T08BI/CRVLO+omE+FDDAkmdBGwO1DnOi//8N9LP895bnwS7+GBrujqBWX/M09qAw/KXcyqcplQSSMFiODSp/aGfxfK873MlGFsUnbqOgNSyQBl8AUdQReP1nqxpfqAAQT4otu7+muspvXAaCVHPDLkddE93lcEGCoHD8E7jFIt/LaodIYOP/rbIytYVhfds5J3E4VtkG+1VrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by LV8PR11MB8697.namprd11.prod.outlook.com (2603:10b6:408:1fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 10 Sep
 2024 16:47:01 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 16:47:01 +0000
Message-ID: <c3ba53a1-0de6-7c15-8a74-415e91e55edc@intel.com>
Date: Tue, 10 Sep 2024 09:46:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v3 0/6][pull request] idpf: XDP chapter II:
 convert Tx completion to libeth
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <aleksander.lobakin@intel.com>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<willemb@google.com>
References: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
 <20240910071649.4fba988f@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240910071649.4fba988f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::12) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|LV8PR11MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: a3167b5b-72f0-4374-f5c1-08dcd1b83189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFZTS0VZNENpKzlFMjMyNVlHdFNKQkhmSngrY0RSNEVydTlIRWQwV3FIL2xk?=
 =?utf-8?B?NlhCdTM0eEdzQnErL3lGR082Mm41QUVsR2dzcUdFSUc3MmpXbUJkMDM1c0Jq?=
 =?utf-8?B?eEFqSEFQdmQyL2RqZW9COFVYazBOZFgvZTFUZDRncGloRTBPTWIvMDlhbWtj?=
 =?utf-8?B?L0NEajhXS3FETm81V2hpSVFYUDBkMTkxN0g1SEhLM3A0TFZMMUlFbTVOWlEr?=
 =?utf-8?B?cWRYaE5KNDlTazdpVDA1NEswTXZJcUFJaTF4WjFhd1NJYXBmbGsvdE0rcllu?=
 =?utf-8?B?aGl3SkFiS0NlT2VUMWU2N2Jia0F5R3hpN1d1TWs1M09sWHZOWlA2cHVzQ205?=
 =?utf-8?B?UldoeHpReUp6dXF0Yld0ZU9rOFJkcVczZnNCbHFTQkxwTG00SzBRRytET2hs?=
 =?utf-8?B?TDJET3lwVjl4ZHFxalZ5NDJFMGZ1RjNkZ204N0o5UUZxcDIwd0ZUcGQ2cnBa?=
 =?utf-8?B?NnVYeXgrQnAwaE1qL01tQXZMSzhLNHJQU0s0RXhsczdONTlUdytJN1hvdTdE?=
 =?utf-8?B?MHdpWmRRcWs0UmhlcTJkRXdTRUczdFFMTGZOa1o5UHl4R2hodzBaUk5RbGxl?=
 =?utf-8?B?SnQ4dVlrcmVXK0s2SitXNmkrVm9vSy9xeURYVks2TTNjalZFbk93VWZMQm92?=
 =?utf-8?B?Z0ZZczVXY3l3c1dBU1FKK0JnRis2UTJhay9CejBybVFraTNBenducitUWmVU?=
 =?utf-8?B?WUp3NS9BK3FMMVgxTGUwTXVxdGhFNU53VDNGZ21MNW9VeGJabmUxZ2M2c2Y3?=
 =?utf-8?B?bFV4VmxnR0VWM2psZ1BTc0JSOWRIY3Y2SXhGWVBWSXZsSmk1NDhXaUVtSHpy?=
 =?utf-8?B?UC9HTGwreGNmcjdqRWtKTU51ZjJTd1N1UzNpV3B1Z21SS0d0U0UrUHVTaVVW?=
 =?utf-8?B?VDJUSE81STB3L2N0eTVacHF2ZjRVUUcrRzN4STZXbGFyR0xOMkJ5RVVGeGxT?=
 =?utf-8?B?WXBlSmFTc0VNYUJVaGFkTjBDUW1WQjlyVXUwYUhCSys0aXFFcC9mazF5YjhO?=
 =?utf-8?B?NEN0bkZ5d2tRS1c5SncvOWo0Rjg2T1I2T3JvSUg3SEdPR3podlFpMmdvWUpO?=
 =?utf-8?B?RXRaTndOSyt3U09GbUNnSzdVYkVQWERVUzJWZ0JicUtVMVprWitFOUZ4L25q?=
 =?utf-8?B?aXpqbGNWRDFVNzFxY3lqWU5aRXZrYWZRZ2wwMWxsa0s2VVU3ZUp0TW5GVXRt?=
 =?utf-8?B?ZFhKWGsrVXF3QU5VK2JTNy9WUCszSm01K3EzMm55N0FYekN0dkNwcm9JZnV1?=
 =?utf-8?B?QU8yOWhiQytaNm0wcU1HUU01QTl6MWxweEN2QXEwYXRSVjhPemthR0NwZnZ3?=
 =?utf-8?B?emVUd1h1blRZZVIvNEE0Tm9WdGMzWEEwL1BZUkt0d1d6bE9RRUxJVmttMEVB?=
 =?utf-8?B?citmci9mVGozcENaL2ZiSXQ3Z1NrMkE1YnNnMGRpeHBEWWc2TUtvSU52MW4r?=
 =?utf-8?B?UFJxbDlQMC94aE5lZU5pcENiV09CRDc1dkpSbE9xVnRkTWhVZ2xPTXBiSnZY?=
 =?utf-8?B?TVNlV2RZTnpSNC9nNzA3NHBCSzRxVTdIam1uRHdsaW5pWFlPQVB6Tll6MjdL?=
 =?utf-8?B?Mm94Z2FBN1paQkZaT2VDK3NsckNocmtkS1NOdHZJZUwzTC9uOXRDbzBrc1NQ?=
 =?utf-8?B?VjV5MUdyaWYvTWREL01SZ1hXck9iM2ZWVUc1ZHhWWXliblhQM0pVdDJnV25l?=
 =?utf-8?B?WmNLSkhURHBSeTdSbGt3U01ESkV1T1FvREcrdWQwMGc2WUp5TmZoa3RWR1A1?=
 =?utf-8?B?MlFUN0hwclIwaEsxSTZ4N28xcGY5elYxMnJuU2FnVDMxNDlyRlZDb3J1VXBM?=
 =?utf-8?Q?LaQbxlY0+pSiSWBPxw4YJAcCpqnRUQZz1beCM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhkN1ZvSHAyZXFnV0NKMEV5cStVajdVcmFNZ3djRzFONjF4ekhtRnFyd0h2?=
 =?utf-8?B?K29RdTJDa2JoNDJuNlY0Qk5vQnhtQ2hsSlQremFDbE5pZVNYMjc1aHV4WkJQ?=
 =?utf-8?B?MWNSMi9LRjk4RmFZblVKd01VWHBJMW5YMHRUUXlhVkJ5cmxWTVl5bmREZ0gz?=
 =?utf-8?B?VUNvZU94dzMyblBDK2xoTElSMWhSR2Q0VWFmbTRwWDR0dlZWbG15a3RyYjVw?=
 =?utf-8?B?WnpqOC9Xd2RTcjM0eEdoZThnT1cxblphSWlOTlczdkFmeU01dlRWUkRKWFBh?=
 =?utf-8?B?VUdycmVIU0wrcHpOR1lsWGRvY3p6VHEyVWsvb1g1STRDZlljWDRnWjNpYUFN?=
 =?utf-8?B?bGV6dWFBK1dkZXI3YVNIRjFMN1RYYi9vbUk2c2JjbHpjTUQzMW9BMSsxbVdX?=
 =?utf-8?B?TmpZWWpMTUg4aFBiU0dDN0tjUWlpVU1nbzQ5UENLaG4vOU1XYWR0cUs5UGxN?=
 =?utf-8?B?eDljY1J0d3RFTm1FazFwenR3Z1JPbzZIZ1RVY2J0c3RUTG5PZVUwMkd6SE02?=
 =?utf-8?B?aUNGNnZQeThEM1Fmd1g5RnhnMFFJWG1ZbGZLOC9mbXdsOEdoaUk1U3lvQ2FB?=
 =?utf-8?B?WStheWNYenRsRlIzalFYOXJPbE9SKzlWVGIxUzJoRXEzaldoc2hWdXc1Wm5a?=
 =?utf-8?B?VDBZOEd5TTlUeFBjZmt6VTA3M0lMeHVUVVpLNVl3Vyt0bTdsUFVmaHgrSkl3?=
 =?utf-8?B?aGM2WDF0VVhmQVFvNEZmMGllYmtub2hieUo0NFJkSlVrNE5td2NiWnFib083?=
 =?utf-8?B?QnQrOTZlTzZyb3VmM3UzaVVNY2FzWUZoV2srOHp5TTUyYXBhcjNneXBQaGlB?=
 =?utf-8?B?SlJZd09EOTZVb29vVXphTVd4Y3ZYQWJMdk1TdmRnVGxjVnU1aXI4TnU4OEw1?=
 =?utf-8?B?aFJhYjJ1UWtqSXViekJhbEYweFZIZk9QZHpWZ2xDek5hQXNSaHAwTlRXcDV2?=
 =?utf-8?B?MVlkZ000bUZFejM3bWI3eFJjUlNkOVpPMGVTSWp1a3RrMnNDaHNlVVludW5H?=
 =?utf-8?B?WkFLbHh5VUhvbGhKWjlhdW15WDYzV2ZKN0x3cnZtNkRnWXRub1k2WWdnbFM2?=
 =?utf-8?B?dlJFRVJ6b0w4WmIxQWs3ZzJDNDRWVDFKMVFpdmI1d21MWWhBVnlUMEhCeVRJ?=
 =?utf-8?B?b2oyNzZKeDlkLzN0TUVmZ2pOV1NlREhDWXNjeU5xVS9EL2V1UXlyWnY5MXR5?=
 =?utf-8?B?akdQSWJ1d29DWDFpOVBYL3ZDMlEzQ2VOT2lhTC9mMkd6OTd5ZXJNK0d3M1E3?=
 =?utf-8?B?RnN6cnpPdlFpTG9QSXJoSFNmQVUraHQ5Z0VTRmJLREFPL0o0REY1YzN0ZGUr?=
 =?utf-8?B?UlYzRmlZeEx2ZXFaZFBNbDRCTEZUd1hVWU15Z0dDQ3Q5dHFLb2tIODkzZkNH?=
 =?utf-8?B?eENkZ2lGMkpzOENjRVZCcnJ2Qys4OUJHWDRiSWRQU215U3pNZzF1d21ZUVFN?=
 =?utf-8?B?M3NrVnR4c2diYUNPd0lWbjdVNUdRRlk3MXRJNTNNa0ExV2JGMWptR1BVS09R?=
 =?utf-8?B?TDREWFNzbnN4VktJYkZXV1FHbjQ0bW80STFzQWMzWXJwVFdLSkpUUVpSa1Ew?=
 =?utf-8?B?SjRkbVFRU2o1R0UxS09kelBoWjJLcGRqWTlIVnM1aHlXTkFiSnhFL0NVODgx?=
 =?utf-8?B?RUpabm8veDA4eVhtMG9GTjc5S2ltSlh4R0VwVVYrR3NVeFdna3NYWUtKcVVE?=
 =?utf-8?B?NlNiWXltZGl3SUs3eXl1cHR1SXJHN2FiTklBWHZUMmU4c3Q3ZTNwTHNhTG9K?=
 =?utf-8?B?d3J4RGh5emVFeFRhWVUzWHI3MHZnTHZCNUgvUmNNRHJ1elJ1K0hJcE5pWXRn?=
 =?utf-8?B?N05TNXdqaHdMUUk1Z1Fody93RkpoV1VFRk51UXZRZGN5aWhTaGhYUkpzbm5J?=
 =?utf-8?B?cWpxbXJFQUhnZHAyNVJDaXNlSjFkUHBiRTZwQ2lMVktqZmVVVi82d216VzBt?=
 =?utf-8?B?TEk3dW9Sb2Q2S0tQVGtXdUQybEJQYXp0Z1BuK0hibk5TdjExdkx4Mk5VNTJw?=
 =?utf-8?B?MVhBdDJBSGxOYTBLSTFKS3ZZUW5VamVja2NWV1JZVlpFYXdLUnZ6N3B1MXFL?=
 =?utf-8?B?SjBrV01DdURETXJGbWFXTU50cU9WVDI2MEZRbk12U3hiTmtwSzZab05mWE01?=
 =?utf-8?B?UnFMcXgxZU5xMEhienZCNGkxcE40OWpRODRqTVV5OUtOd24rS0ZsMjdwMGRV?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3167b5b-72f0-4374-f5c1-08dcd1b83189
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 16:47:01.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSewubd7DccR2AnoSV8XSTQIXb/TdI2vcG9IrpUvPaB/bYMbI2N8HBFu1gnzeLcPdZQ8pXKMvOJvV0bzMDyk1Q4mpDMRDc3tPaGS2Ff6V84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8697
X-OriginatorOrg: intel.com



On 9/10/2024 7:16 AM, Jakub Kicinski wrote:
> On Mon,  9 Sep 2024 13:53:15 -0700 Tony Nguyen wrote:
>> Alexander Lobakin says:
>>
>> XDP for idpf is currently 5 chapters:
>> * convert Rx to libeth;
>> * convert Tx completion to libeth (this);
>> * generic XDP and XSk code changes;
>> * actual XDP for idpf via libeth_xdp;
>> * XSk for idpf (^).
>>
>> Part II does the following:
>> * adds generic libeth Tx completion routines;
>> * converts idpf to use generic libeth Tx comp routines;
>> * fixes Tx queue timeouts and robustifies Tx completion in general;
>> * fixes Tx event/descriptor flushes (writebacks).
> 
> You're posting two series at once, again. I was going to merge the
> subfunction series yesterday, but since you don't wait why would
> I bother trying to merge your code quickly.

I thought last month's vacations were over as I had seen Eric and Paolo 
on the list and that things were returning to normal.

> And this morning I got
> chased by Thorsten about Intel regressions, again:
>   https://bugzilla.kernel.org/show_bug.cgi?id=219143

Our client team, who works on that driver, was working on that issue. I 
will check in with them.

> Do you have anything else queued up?
> I'm really tempted to ask you to not post anything else for net-next
> this week.

I do have more patches that need to be sent, but it's more than can fit 
in the time that's left. There are 1 or 2 more that I was hoping to get 
in before net-next closed or Plumbers starts.

Thanks,
Tony

