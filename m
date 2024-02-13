Return-Path: <netdev+bounces-71509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2736A853A95
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 20:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAFB286E50
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F75E5FB8F;
	Tue, 13 Feb 2024 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVbkxJiT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AD57883
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851404; cv=fail; b=Yd5Zt6xRQ2SPx2Fm0vaa8HR3EYXrGYV0qUq9cK1Ka1n+vK1VinjcEHlNWFdHxvx1evBHrMBgdpCA7d8kqQla89F/42BZ6E1ZhHHLoc3G+h4d4XSpHyfBoS9URMVwlwsiBw0nbExjhfhcJc2R0Sti2xz7MHavmeQS9pv9X3zEu80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851404; c=relaxed/simple;
	bh=RiEBU3L6ocx9N1D5RAjXLeQ134CJTVnvuZh7688smxA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ikoSKNXPturG+4NuiQaxdAWn0z27enk1ydQn5s1VE8WnQXZdiHpLvQ3YRszsZEGH6fcOICwnOzHP0avkfx6bu8R2Dokk13CYZ6tgt4FlSrpbu7IRSRhvMob19gcWXK/cXkmh+Mh+oFObQkcU0rx5CayMJzkzR7/fodp4dtTirjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVbkxJiT; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707851400; x=1739387400;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RiEBU3L6ocx9N1D5RAjXLeQ134CJTVnvuZh7688smxA=;
  b=YVbkxJiT7bpv2iWfRH3xI7CHGRyTdcl6SqzZYviiOB17xrWLjgTCOAoQ
   Y44Q+s+cgf3OJD7rxcT3rt8by2/ReCBREpBgz9tgTT+5hayIdZpnj4AbB
   dSIYvtuKaldsvaxGRjt3jrOaYGuxprc2z8QeCH3pLeJDqB2iwsZTuG9R6
   F7AmAsN0ssAVmvlqcMrpp4RJ6w5+wd1mwm4wZN8IjoJyFNJYAHZfT56mw
   B4IF+KfWSocmlqs7breEhn7x3ms5DS5ym75dIseZEOsa02lEGeozEQ7SZ
   +l33VjOKOUGJocMISLBZqXdbf9BmN4cWoafrIjxrNjE5V04Ryu7cVQUvN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2233335"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="2233335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 11:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="826195829"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="826195829"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 11:09:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 11:09:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 11:09:58 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 11:09:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOmyXnJ36OAIeE/sxV87UX+nt/KGbqRphNGG4xROTkhSwyCv0BEm3+NFu1EAJXvb4k6oqy5+cJds53hWOoX/XelmexpdrefFaCY9d609siuk7b0nx2bpm6lfvSjhvTTycv7Bex4r7abRl3CUkFQzRLt908/Dql81eqBNZCgzgkjpHeBR4csBUNzFrlSiWkzgU2kQ1Vkpqd3J9j+wjconxQ4j0jm8VE9GPYWKZo1htCNtdtCxwnVq9BsiVW7Z+xhPJg4zht1Xr/kTBkGbNUdlQJ8JzENYxLS9rUXReQNFeOPAZOrP3P4HpcGSpj99GQe905Oa8AiI1IEk8lc3epcA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eACHTmqTq4KK5U7A1CkSQyvyQie9SeoqXfGO0VTJGSI=;
 b=fTb57x1lX3yUNbMeB8+SQQbHyoRPBvKmlBSMwlVc6gT9s5/nM7Upv+jFE89ldCrzt//kJLR+bAoT0abl7+oihMX6Rx9ti7Fyy2nfYDUJGfCNmZXMsdiePifZeWTJGny8ozNlgaNytXNuQp/6JuqBznBztAp/7L5UMYGDzbvjbMKglWp3CBO9Vu0G26VXAfJ4wJRPWdp07ohihZeTc/H7qy20+D+kkyY+ok1kBUHVI72kqQa6CRCh5g9vZItTlr/IScpx+sqlPYy9TONMvAXhuE127CuZnonVbieyL6AXTbENtelAGUllizKaLUFAUoD1UGtDTKPxwxbTiaLFddxlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.32; Tue, 13 Feb
 2024 19:09:51 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83%7]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 19:09:50 +0000
Message-ID: <24b89ed0-2c2c-2aff-fa59-8ee8f9f22e9a@intel.com>
Date: Tue, 13 Feb 2024 11:09:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next] igc: Add support for LEDs on i225/i226
To: Andrew Lunn <andrew@lunn.ch>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Kurt Kanzenbach
	<kurt@linutronix.de>, <sasha.neftin@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>
References: <20240213184138.1483968-1-anthony.l.nguyen@intel.com>
 <7a6ae4c1-2436-4909-bb20-32b91210803c@lunn.ch>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <7a6ae4c1-2436-4909-bb20-32b91210803c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: b57eaa86-3476-46ba-56b5-08dc2cc75a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VsEbASL08KrPTerTEMDSdZHbwr718tCBZlvfb3FGPqb5GnioFKOgVgRa4QSDhDUNs6XE6bBFlU/Jj3omA7rpod+KdeHCzOC99Tp/ALkkXvcouJJcOC//z6qU1d2SBLqzU+rFLBOVt0hBhJMYxYgL2mp9lwnu4HNarU9RyJTBw/PtECu6sT7AnjwEEChyqCwr9JzZAwLwsBVU4N8KLuNB/1kQ/SEa32ftejQLOc6AC3yiNUp2zaNt9P6y3mm+l82JMtmTNpyV0Akuln84egW47wASek2agcTJKpFs7kaefGUPuk0TBhIDlhxE1kryTVCy/BX1WDwgKH42sDnmmQ/WkZh79tkX+X2Io4CPpbvpzk9OYMS4orFQO5rrTWW3IIbRB8hN3dAOpyEOPGg0YG7Wmw4xOIRvWTejPfHS6jS43DpN8Ad4+PgDuGmCx12FdD78GsDkvQppKGjoJnjZIdb63sT3GmmH6JdQ3xzRgEzmne7chaHC61aSMv1TwY0f3bnYNHPhDqoFSO3/saxbJmtUylkGCfHWIBiijaGOJHAU2vRTviKiYCQwiCk22DHc6eIT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8936002)(2906002)(66476007)(66556008)(4326008)(5660300002)(8676002)(66946007)(82960400001)(86362001)(38100700002)(36756003)(478600001)(6666004)(53546011)(6486002)(6506007)(83380400001)(316002)(54906003)(6512007)(41300700001)(2616005)(26005)(6916009)(31686004)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU5rMXR5U0VKWU1xOFdZN3pEN2VmTmRTUEhiVm5uNU94aVZDTk9DaThzSjhu?=
 =?utf-8?B?RHJxSVFtbnliUDk0aEZSV0JFWFRsNHFCazJ1em81QmdqYkxVT3JsMFo1cWxD?=
 =?utf-8?B?RTl0b3VYUTBmcTEwdEU1WEF1TVN6RjhaWndtQnBmbjkxTDR6Sm4xODBYOTRj?=
 =?utf-8?B?NXY0OTV6QkhyUjBDNkhvNERUMTZFMTZCVko3b1pHZEowaHRzZkNOOHpvTGQ3?=
 =?utf-8?B?YVY3V1VBbTNhcTVCd3ZHWE5hYkhGNVBoVVh1T0wzU3VidGtRWGpSVVZ2azZj?=
 =?utf-8?B?SWdaQkZrUmFyWmdaMVcxbHRwMklUTEJiL3NlWlNEc1NLcTVNNFZqOVJwZU1y?=
 =?utf-8?B?WTFpSDZRb1ZDNkk0V0twNVhnME5qRTN4UWR1ZUtST3RhUUZubW41OHZQSXJN?=
 =?utf-8?B?aTlneGVYZ2ZlZzFEejZXTEJaUTNKV3pPVE5EdTNPUStlOTJWUGQwSHZ4NEgx?=
 =?utf-8?B?d0ozQmQvT05RZGZlLzFJanRvNGdxZTQ0QnFOSHd4SGJKOEhhRExKRlR3R2Zn?=
 =?utf-8?B?b05EbDdONDZZbkhUL21OUmFVUVZmaFd4Q0ZjbnBpZ0VTR1ZKRXlqVlp1ZDdk?=
 =?utf-8?B?Z3BzdnhsQ0xFaEc2eElieVVoQTNUWG1TODY2aSt2Yk1uNElXTXJKMmo4REFt?=
 =?utf-8?B?Snl2RVg0Q2oxODhIc0NBaDhNcjFhSDd5VVdWZnhoTjdQVXRJdUJTWmRRaHFJ?=
 =?utf-8?B?dTN3TmFlZnVwcXViUFZvdEpoZUkyOE92U0tWZU92cGYvamRkUkNEd1ZMSFNu?=
 =?utf-8?B?RGlaTThwU3JqTHk5VzRGZjZ1Lys0Z3VaazU0cTQ2NEdGc2RwTEUwTm5tcGt1?=
 =?utf-8?B?SXFHR3ZwUmMvYVc1VmNHZTUrakY1QWtGMlFITDRMbU9LS3JqdzZMc0wvOHNu?=
 =?utf-8?B?VHd2YWdobGgyS2xhbldDNENtdHRTNFN4b3c5ajlkblpFV3A2TGtYU1o2OEtu?=
 =?utf-8?B?cks0N283VFFrMUdmSVY4L1BOVjlXbTUvQnl1THNkRDBDOWJhd1FlbWIyL21B?=
 =?utf-8?B?TDRRRDBJRTVtcThNYnJnUGs1b09QdjhWWkFIajJoYmQzSks3L0NYK1IzY1Nx?=
 =?utf-8?B?V3IxVTFqNVZ5bzF3OU0rSk9QK1ozU2NoUEg4d1RjeHltL2EwV3BNYmxKWFVk?=
 =?utf-8?B?UTUyOUd6Nk5WeUt1cFJxN01zLzc5K0M4cmxYbk9zSW41aTVTVTMwUFJtNU1q?=
 =?utf-8?B?ZCttUUZoMHRhaFNScDg3Z0NrUU01ZmRJd2l4WGlJUzhtTHVDVGZudlBETjBE?=
 =?utf-8?B?SHN3Z3VpcTVxTGY2Zjlsbm1DUkg5N1QxWnFuQmpxN0xSUWZqQXdUbHpUZmI3?=
 =?utf-8?B?amNMc0tkSGxBVnJ2eHZLT1A5amlyWWt0NkhZdHhwb1VxOWkxbWRlbEl3ak5u?=
 =?utf-8?B?RVpzODdvVkJLQ2hEVWYwaTZ2Y3J4MmN1RnJ4ZVc4WksrZlNrSVR0dC82MjNP?=
 =?utf-8?B?dmdrMHRSY0FWKzk5eS9Nd2NOZFg3WHV5V2N3OHdDTUwvM1RLeGFTSW16dEVT?=
 =?utf-8?B?S284aGtDanZzR09XOVJhc0pIWUNFODNiUnpvWmhRaGlrVy9idXpOaERxeGd6?=
 =?utf-8?B?VzVnQnhMenN4RnlLWVVPVEZQZVJtbjBERC9UTGx5N25WcVJHMTE3Y0hqTFRz?=
 =?utf-8?B?bERraU1xWmM4ZkpVNFUreFN0d2xUTEZmczVQT2xYTmlpSXZNaW5kUVVaUW9X?=
 =?utf-8?B?ajJrb1JrcHFPNDBTeWEvMjQ0TWFockRWS2I2VVZyYlZoQUFwbHpqa1JrbktL?=
 =?utf-8?B?aWo1TzEvR0lxWCtQVk1RSGZoK0NMbk10QVhWMHk1RDhVeGxkR2FvSjVVdEg3?=
 =?utf-8?B?TkNrUW5RTUtFTkUzVEVhdmZZckQySzBKakdidDFpcVNUQVIrQzhtbEsyanBV?=
 =?utf-8?B?L21MWERjRmQrVTYvdGdGMDBTdDA0YVN2ZlRCN2k2eTVub1I0dFRpRG4wWXR0?=
 =?utf-8?B?dWpDYXNnNUh4SFJ6a2hORCtwM0FkNDRIS0h6VmJZVzJlcjN2TDVRcVY3U3h1?=
 =?utf-8?B?Sm55L3VWbkNJV29ZQVBROWxMaFZCVDBwSEtYMHZZdksrcGI1UTRxSktGaVhG?=
 =?utf-8?B?Q1psTjZOS29zcUZkSTdDR29CcjZCWnpETEwrVGp2V1NqTVdiL3dIaFJ4ektO?=
 =?utf-8?B?Ujk2S2NmSzJ0Q0VHZVljMU1LM3J6RnRoQ3piUnVMWHFWV2tjZXBMREhkdFFG?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b57eaa86-3476-46ba-56b5-08dc2cc75a67
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 19:09:50.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GM2ZD1pxDBpkDmQlv2Zbsnw/yguvJqc4axNxFGc4ddnZzO+9f8p3mC/2yspf+XzoDEbhjI5DZ7iG+CSE3k4Z8FcB28+pW8JVha39l6PdVsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com



On 2/13/2024 10:49 AM, Andrew Lunn wrote:
> On Tue, Feb 13, 2024 at 10:41:37AM -0800, Tony Nguyen wrote:
>> From: Kurt Kanzenbach <kurt@linutronix.de>
>>
>> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
>> from user space using the netdev trigger. The LEDs are named as
>> igc-<bus><device>-<led> to be easily identified.
>>
>> Offloading link speed and activity are supported. Other modes are simulated
>> in software by using on/off. Tested on Intel i225.
>>
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Hi Tony
> 
> Did you change anything? I'm just wondering why you posted this,
> rather than just giving an Acked-by:

Hi Andrew,

No changes from me. I normally coalesce the IWL patches after our 
validation and send them on to netdev as a pull request. However, 
there's no other 1GbE patches in the pipeline so I'm sending the single 
patch. I believe this is the preference vs adding an Acked-by and having 
the netdev maintainers go back in history to pull this patch out.

Thanks,
Tony


>         Andrew

