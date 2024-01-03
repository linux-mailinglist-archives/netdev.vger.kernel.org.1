Return-Path: <netdev+bounces-61275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C06648230B2
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FC11F2482C
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D031A735;
	Wed,  3 Jan 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vdt8vkTU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B621B26E
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704296460; x=1735832460;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EpxShj50D8tzYF9v0q+gw/pvTBWbcMv9dgwnDhJztmw=;
  b=Vdt8vkTUpByPF2SXpn+wvILRDXD9YbSTGXuAqjCkD/TCTP86RaK6/JPp
   qmFGWjw/dv89EQ3ttC7F+/zo/iAiMBikp/8gCzOM2arpR3zuZODwK4m6q
   sdSnR3IFm3bvS3qGuBwiVrr1AODymBCEldBKxSyY2DyHFW+K70FTPBMFT
   I7xHAW2/r8SDQbRzG5+0ium9Zf3PhEgTsAV6sNqnUVXz29MjGGrIS7TCa
   PwMKT/HB+EgHpAaetDGuzek1uzmsswzN/SPG+UE5MBath6luCgQnvYpUF
   SY+LGQR0dTuoloxjpYWEVO8a+ms3fsO0qJCxEot8AVmE4lGHWfu6dhvRI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10419394"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="10419394"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 07:40:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="845906010"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="845906010"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 07:40:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 07:40:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 07:40:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 07:40:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgYeOTOWJVmuQ+d8p3u0cHqerxYOznGoVaFmy5vAACV4N1c9dScgNnm25MDBm0k+vZ80oFfLGTSGSECRsbfwqug17t4BRmuws9LcttR7qvINC8pPWd7pY34KUK3/mH6VfvU7fKr+6c6MnVaRg9KqOwQhO3qGtsWILZbC3nxAwFcml2/33S5BEQpb53/7fJZeKewPh5IYPFvUkp2aYgdbnB1GwVnh6SFVoKCO6VVhojrpun6yNtV2t3nssS9uQuT1mwOQa0diwCSzviruCqfs5x9f4b+t7riECc7RimK18Cx6ncDxlmV23acX2AqqYehLhjR9bmLwVS+4eaAtWZ0YUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVgY8wZuzm9EFQRRIDMv+LTzwvMm8HALzEfrl1OBqQw=;
 b=PfooVj6fdStAB6/s5ZSJHMyO5Nym7cbI4lso/D/5ZFAGkO3++T3ayPxlG9MTy4Cs1StW9kp+dojwDcB5O29+/ZqO3b08fjXJT5DQsoJ5vorzL4aCqAWTtl66jc2TLgRVhUkcjA69ih/bqjztGQfc+2K3eRR+xPbdeldCkzJKCmDrSuHagmxSzn8oBvP55f1QIV99irwQ2HIz+gahtlEJMw/TYI5sFj6WHXzC3IRmADn/VkBp9QK4nW8EfLfCuO1zLDmU0pzWokN1Kyj07Ndu23mAQHcDRoLhqTERokOiIOTKsyx9LdgdVsi/EzaVh4zzLQw5A13u98UZDWfqLZlbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SN7PR11MB8110.namprd11.prod.outlook.com (2603:10b6:806:2e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Wed, 3 Jan
 2024 15:40:56 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b73b:45a5:d8d8:65d8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b73b:45a5:d8d8:65d8%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 15:40:56 +0000
Message-ID: <34b00cfb-d1d7-4468-948b-a44591dc5923@intel.com>
Date: Wed, 3 Jan 2024 08:40:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ethtool: add a NO_CHANGE uAPI for new
 RXFH's input_xfrm
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <corbet@lwn.net>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
	<horms@kernel.org>, <mkubecek@suse.cz>, <willemdebruijn.kernel@gmail.com>,
	<gal@nvidia.com>, <alexander.duyck@gmail.com>, <ecree.xilinx@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
References: <20231221184235.9192-1-ahmed.zaki@intel.com>
 <20231221184235.9192-3-ahmed.zaki@intel.com>
 <20240102160526.6178fd04@kernel.org>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20240102160526.6178fd04@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::15) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SN7PR11MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: ba831464-5ba1-42c9-2b13-08dc0c726055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qkCCYL0OL9W1YOVHDlpuAK4ci1wXA1HU6ao6TzOzVreR4Egwmm4TyDvnZyWDZTkaEylcfMGMftm/nMHwzEqycRAw6UabsSZlTKz9Hj3FB7Z9vvCdhjCjltHXQDNbzF+mU9SIAp0G2vmXCqvNzDAAw4plzGFI/e9KBiL4SAqgW1tk8xMq4FS721kbEumnm4U6MUTTUt2Y83CsphrmWpJSn5aHeRvahd5r7F9DoN+/Li5WM2dhr6JevQQ1VjmyygxLN1zmO4En53KjEa+l8iW5Fu9iqdrsST5ghtEnFYQr7OJ4tvGLELRB5MsXV59IH9b83BNcBwuLhuZtRkTChfWL5Iifx5xjJE1czxH4+NsoNcy0GV/WChv71/p3xEWvcWVOu8NXHOGAqQa0Lco5C6TWhY5CdUD+JbOhqnrZD+PLV55vHd5fkHi/MlAytpE1OTatmAz08GEDCfsSgWj952uUZJf+iJt9g8sJ805+eyyyhkzO0Ghq9T78qlkiFqZXNcvYdpi7fBPY5H3d73skSlzzMzC2lQYJl1todxkjR+l0AZQFRbcFQN+NIIz4CIaWoUN67jnJgZsRJ25iXKk4qgHHTdrbSbvFXC4esR9Pny71PBa4CBskJ5zgkuVhsFpFjW/uHG16D2L1SZS3tCBdSMwhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31696002)(83380400001)(2616005)(26005)(107886003)(6512007)(6666004)(66556008)(53546011)(4744005)(7416002)(4326008)(44832011)(66476007)(5660300002)(41300700001)(478600001)(2906002)(316002)(6486002)(8936002)(8676002)(6916009)(86362001)(6506007)(36756003)(66946007)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkN3TUtPZmxMV3NmRHFTMUF3ZTFHdnpMUXcrMzcxSytiVyt3TWs1aXBBZlVx?=
 =?utf-8?B?ZVR1akkrWkZNQWVZQjFtcEVDanROd2RoZjhrTkpOeFJuaGJyTndpcHJtSGc5?=
 =?utf-8?B?eEw3RUNaZndRdHRJUWl2YzlCZS9xR1F4emEvaUlVdzYyMFRYNXdyczZiaEJx?=
 =?utf-8?B?WWZHZ0JIYUlNSlFiazI2QVFDWG9zSFVCaGNWOWc4OGhGUWl1c2tCMFBoZjA4?=
 =?utf-8?B?K0oxRjB0Y1JoU1NCY0Z0WWxxZU1JWDFoaVByZitZM2ZzRXE2UnMvUW9uTU8z?=
 =?utf-8?B?R2pVZ1lHQ2tuZWdFeUgwdGtQUFd6aUtzTDNJY3JRdk5pakJsMnB4VUwyaDVt?=
 =?utf-8?B?R3ZNWUtqYkJseTZMTy9KZTYxUlZrZ0w2WXprOTBZU0pvWmo5MWRVNDlIV3hv?=
 =?utf-8?B?M25USFR2VEZjL0wrVHdOZWYzN3RMSWNsck4vVFl3YUpqejQ5TzNnekkzcWlZ?=
 =?utf-8?B?WHNxTGdVckgzSGN5ZnBWeDRTSkpkTlVRaVg4ajQ4em5VaEMrMm5lbDM3aWJp?=
 =?utf-8?B?ZER2dFIrSHpob3ZJR0kwUTMyYjRXb0FwQUE2bnBKZUZhREI2dTYzNzNmempO?=
 =?utf-8?B?L05BUEk5TG9JT0VmVXQ2TVhrT1pTWnM5WHNIeWJ4NVBzNWEreWFVYW5HYnFC?=
 =?utf-8?B?dlZNNE1TRS91c1Nncm56Q24yelhZMFdicVRzbXd2dXNvOTRFcWNoVjN2STQy?=
 =?utf-8?B?bFFwcWpJUEkrT0tVSlk4UHJMV3AreThpUWp3a2taM2ZZclRLRkpQLzlySkps?=
 =?utf-8?B?cmY5Q3RqME9peDNUYXcxOExxUmNZSU94ZGJHYi9LaTBoNG9aR1F2R29HZUM3?=
 =?utf-8?B?bXJzRGhwSi9lTGpkNlhhdU1ydG1aL09lS2hUeXQzdk03ak9jNkw5eE1jalpO?=
 =?utf-8?B?N2lERmNhVG1wYmlLUVFZYjBpdGE0WEFYNWRIZW1ZeUdXTlRpeHBPa1IxazZw?=
 =?utf-8?B?d1R6dHhVd3NwRlhFNEE2eHE2TlpvdlBaNWxFdXlhMlp4ZDhOVjdmQkxTVzdK?=
 =?utf-8?B?STVxczZBajVwSmx2V0ZxRTR5VTBBdXJiTDY5T2NtdTU2VmhFL0JzenpiT1do?=
 =?utf-8?B?QmFzNUpBS2pHRndFWFUwSCt6bnpDVWRLUEY3MVhPZy95NDRoV241OHJ3Q3ZJ?=
 =?utf-8?B?RHJydXdwN0JzR1NzZ1Uxb0dNN2d1aXZDdW1Td0RnTjVZTURmcFdjVDVKNEpn?=
 =?utf-8?B?aWJvbWVoNXJIU2hYUVlRL1d4bWswNStiaFNWaG83dmNMdFdKRFhuU01hQVVG?=
 =?utf-8?B?enRvTFNZbE8wbDRRVnV1aGtyTlRiQThUV0VKTUlhLzhqd1M3NWhzVXpDNlI2?=
 =?utf-8?B?UHIrQ2hwZ0ZrQ3dTU3RXZjlyODJJZ251a0llYi90QnBGRDM3WDJIT2V5Y1Bk?=
 =?utf-8?B?aHhySlhHQkY5ZUlNUU03OTFCTHdTY1JiWDkxcXdzQStLaDg5TTZNZTB1T0lw?=
 =?utf-8?B?ZmVWMEZsYW9QaHAwd1Z4V0xCVE1Kb055eDZQU1ZwN2JQa3M5MGI4SGgrN2JW?=
 =?utf-8?B?TlpPYkZqNzJtOTVVaTh4MGpIemJQQURMRGxDT0p4aHlCdnFXQWhqVGJ4ckdG?=
 =?utf-8?B?U01rNlNDSzBWM3RaZ3MrUEx1SXFucVVIOFZUN0tYUVlsa2xVRjV3NHRXelJz?=
 =?utf-8?B?VVpQbTVGcy9vaThsSWZ1Mm12REtvaHZFdTFEMlVtc3V3dENEdmZwNitoa3M1?=
 =?utf-8?B?SGMrY1E0aExJR0ZnTHJoR09YVC9mQ0lDdGNFNXdQbXdYa0V0Mm1kOU5UVzVC?=
 =?utf-8?B?QmhDNFZ0Qlo2ZTFuSGNIRWkwNVV3L1VOQlpMQzMwLzFMWE5EUXdMdTQxejFO?=
 =?utf-8?B?ZnBrdVhsM2xSeTRHUXltY2FSek05aGl0bGpxRVZhMkRQTEtYMi84K0RLQ1ZT?=
 =?utf-8?B?bWVyRFpWMVRaOUgzM1c0ZW1FR2tDNGVPUGNJVkdjWE1sb2ZQb0J1WkpzZmta?=
 =?utf-8?B?dG43RzI3OE5ubzBsMHh5L3VrWFd4djJ1V1VzMWVLdTNMdUVPalU4Y0hLd0hQ?=
 =?utf-8?B?aG8xWk9EbFJ1WlhsN0VMcFN0NXVKZjVOZGk2Y0RXU0JiQzdvZkp1ZlBVUWo0?=
 =?utf-8?B?MmUrQ1p0QkJlb09YMjJldVplZG9QaTFocFRDenRjU01xUDdHZk9FNEw3WVVv?=
 =?utf-8?Q?dESBuf5wmLhrwMBS4m7eGMVfA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba831464-5ba1-42c9-2b13-08dc0c726055
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 15:40:56.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9db5JV+dkTLjdSbDQ60rkBFfRqktd4ZSMGLdGOO72RpvEtaBptwdvJVoWirEuK8njF8yC8OLcZL2CpQa+JOb2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8110
X-OriginatorOrg: intel.com



On 2024-01-02 17:05, Jakub Kicinski wrote:
> On Thu, 21 Dec 2023 11:42:35 -0700 Ahmed Zaki wrote:
>> +	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
>> +	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
> 
> This looks fine, but we also need a check to make sure input_xfrm
> doesn't have bits other than RXH_XFRM_SYM_XOR set, right?

I wrote the xfrm as a  bitmap/flags assuming we can have multiple 
transformations set. Not sure what future transformations will look like 
(other than RSS-sort,... and discussed before).

Else, we can do the check you mentioned or may be better to have it as 
enum (which would give us 256, not 8, allowable transformations).

