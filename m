Return-Path: <netdev+bounces-63111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5673782B38D
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 18:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F318228D873
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84805103D;
	Thu, 11 Jan 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRF1XX3f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200C537F2
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704992446; x=1736528446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2WmXE3Zh8W6vKG2F3wpLzbD0/6idkjw+pq3Ejmaynwc=;
  b=DRF1XX3fa+EmNJXCGnEt9djH+KzPPMHLenrrRjYvZxgz8OjQ2xbl1i1j
   MV31L8usMn5vhZyBq7KXJVvCmuK29NLeaXlh6xNQfP7Ks+lSkM6uoQTja
   5B2ZfinfFGZD1JhMKaQ7Cg7iuRfLONPxDHlCNk3AFk726fvn/HoT2oHAs
   /ETTdiDReFTpABtwBEopfuRfmuldlKOpxNg9JAKbyFQn3aBLYkeHtPYrl
   5YPM63pwXKbNMw/1DFwDZOqYc/YbOg6Mux7QY+k/gyR3VyvSTQjq8q/c8
   GNEYxn1KHCNOICQ6yqzoiLtVbBELWIshEm8fk0kof9GXv8IW/e57FR7SB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="20386824"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="20386824"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 09:00:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029622685"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029622685"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 09:00:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 09:00:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 09:00:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 09:00:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGigS0y/h3UgZN6QVb2xzgrJbXQVyvgK/EAFMGZjdAoQ/2aFXc5c+1uXN6LPmprVqtrwNBTe2mqCpsHwJOgQSxlKLc2t+0d5YDTiX7co65v0tO+0J9c3eoO4qwcIviW6q3UTB0Wpz07mu5pzxy8QDal7C44xL2eaBHiTE/bLErsXOBLhACo89dEQWwSb2NJ8Opn/V0+tbNBgtwk5rYcyhAS0B7taC/whAKsk2PKpiB94nTUXsNvWIka/tU7IHZFu4ucktvqdMj4eGq1nvXqngkaF9M0sfu64V9AlHsXKL4dAjy7K/URRN20eEk0vfdSg18LSYi/2ot1I2dW7Lczz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7PRMHUKGR2L+fjNCGwayGUOWjTcqkeQtjTzmU8zk0g=;
 b=c3BOuxHCN1ehEtd5bPU542YLNvLlN70OTs7Q0ndGvSNwimssnaaEy9Qi+qe1SdxqFDQRtLR5BRV+pVYlJoGZyGocPjJqpWWM/8fe6IEFwh0w3XKf4vF6jrX8RMc9L3YueYYspe3APi1eUfn8MjPETZX8r7PCLgN14BHzSWRLqTGLqP9X0IjwB5xxWzTmBxNnkfJ/32O7alujlZAPJeo4pXLOSzDf3pQMPS54qu7YkfWuIjQty65t9su7beNmpOg0e1fW3OhE8UUB7z1rBgMRpmGUUcldO7/xttSh2QoyIjIqNrhWzH9ZPkDDptFohSQfGK+w6feJ3pCv5NUTb1Hbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by LV3PR11MB8554.namprd11.prod.outlook.com (2603:10b6:408:1bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 17:00:33 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83%6]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 17:00:33 +0000
Message-ID: <81e01a6b-2dd4-731a-570c-58944c5fc9b0@intel.com>
Date: Thu, 11 Jan 2024 09:00:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-net] i40e: Include types.h to some headers
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <ivecera@redhat.com>,
	<netdev@vger.kernel.org>, Martin Zaharinov <micron10@gmail.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>
References: <20240111003927.2362752-1-anthony.l.nguyen@intel.com>
 <20240111131142.GA45291@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240111131142.GA45291@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::18) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|LV3PR11MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9ce7c4-425f-4cab-3468-08dc12c6d2a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hjaFaT63m10K66gpKFD3IDiBgTjghxluEGQj2/BZrhSACawUZ5EIgCSTWqsvlRhr6lWfkc62JDXid+52Rxm7dv+c0lWEY4rRxSR3vbP/61FLIZ8d1/wW27z3JCKsjJQqBBN9iwAmx+0xSCGFOlD3/f+Bty0EVzMWVcgv6qrShAR4A9LwPbyRFT1x7Qbw61Q81UsYeYv1s9sHDoUf0ksTg0S1qYk+Qnni9TB7mtQBRlJgZxA5lWde2rA2OOaCrBLJ47aA4GYW6xLDBFfBaQ/jmcOtUb4qTwTgSzqVC6+HL4L44O1BaaW32826e4/x/2Bzatcl5VUkUcmNzSzFAyK52suNqJUDeR3nvWwrmtlhflFAdTrvv6EEpyzLtQBw5aT8mQU/kUprx7/kZHIaYMlfbU0Xn5QvqdAVW6lB7yYs6MGeUiqz3011/WfLRNTZ2sLg7LeW1+mHld8deJoHci8kXG5criUIw2l+1tg7oolkaxYshhHcOq6qksn2NlCMVSaMJRsimoF10pB0FLkTNQdyJepMPWFtpOr13fdGpseo1oZfZIhWKoLpi7LQ74gPYw112pZIK0unOMUdHANmnAb6jRdtE8aBd1vEpt4Woz6sTCpbkDIlgqNrogW8wGipQWu7jit4USPqFXkUJVqC+6gVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(966005)(5660300002)(6486002)(31696002)(82960400001)(107886003)(86362001)(6506007)(8676002)(2616005)(53546011)(66556008)(66946007)(316002)(66476007)(41300700001)(8936002)(6916009)(54906003)(36756003)(38100700002)(26005)(83380400001)(6512007)(4326008)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJmNVpyNjNpSGkrWEhQZ1ZEdktNN1dJbDVWK3JtZmJHNHNKa005VGo1di9s?=
 =?utf-8?B?K3Z3MVAvV3V3UEVTNzVOdTF2TEt4U3FmV1NDcGkrS3hCN3JleTl5TmErRVdv?=
 =?utf-8?B?cDdLc2cwc0t5eTlkR1BSSzh1MTA2a0NNaXVlRTF4TEtIQ04wTWJQMGZHL0U2?=
 =?utf-8?B?bXRVYkZIbG41R2NYY2tPd2VzS2RWV3U5VXNmVG0zckllajRNL2RkYmtpZ0Fo?=
 =?utf-8?B?UFJ3YkU0YlNzdjNJWkZvcm1pSWtOQW15UHpoeStBak5NNzIvZ3dNZW15UWJy?=
 =?utf-8?B?Z2IvSnppcE5oYWRWYktROFhZQ3RQU29neGNoTFlaNnNRT3gzdXYySFZVeEZ5?=
 =?utf-8?B?eWxzT2l6a0w4elArbHcySWppdHg3emVOdVNKTUxVeStkclBxWVIxNDZaSjZz?=
 =?utf-8?B?dHFUbHRKWmk1Q1dZOVBjOXk1TWdueXBxRDRuOGh4NUhscUlaemVKOGJPNXN6?=
 =?utf-8?B?eUVBWnRtaUxzUzZ2TmdnZ1ZEbnZ3d1FIdExzUnFNNityTWRaSzFZYitLY0p4?=
 =?utf-8?B?VE5IY1hhYlhrb0dXQWtJb0dSUnJ5UHRNSVRNR0ZUK0d3amhpam45SjNFcTNj?=
 =?utf-8?B?SDNwL1Q0Z2xUUm9HejQ2c3FFMnh4UFd5WFJkQy94MEhvYldNZ1pOTTdEOTlZ?=
 =?utf-8?B?dnBGQmRkVGJ4dGFVWVpPWFY4cVZYb0RuME9wOVI0WUxLblcrOFNKV3ZScXI0?=
 =?utf-8?B?RmgrQkIvNlNmVkJyempWc1dxZml4eGtsb0IyTXF0UmpUYlZuQkNtZ1VzUHJW?=
 =?utf-8?B?azZUWGVSRTVyaXBlOHA2Y0llaHFQQ3k3K3ljK1hiMHhRYWUvV0R0RUs4MTEx?=
 =?utf-8?B?V3lXZ1BvUHZ0WmhxTVFzN1pZc3ZXbzJ4M0VlbjZwM3ZUNHRYTURLWjFZdk0y?=
 =?utf-8?B?WWZVWjdhall1ZVdsd2JGdldtcG5za3dNWGdxVFBuMXJqYWpkUXFWTktwOTMr?=
 =?utf-8?B?WDZuYlcyd0R2MHhJM0xXOWxxczNHZCtvTUlUR3VQaFM1dGNJellVOFdBTE5E?=
 =?utf-8?B?cjlTSzU3Zmt1aU1McTArOGhPc3V4aEF1QVVxR1ZCTC9YWWhzRUJoRHVjL01z?=
 =?utf-8?B?UnpmTUxBK3I3WWI5RGF6N21CWGU1TzYzc0hOaUtCc25Jdzc2WkgvVEFIbjJi?=
 =?utf-8?B?V1gzekFqTmZPTE93M0RlOU5WMzg0NkJSMXJRSFF4V3laZ1dWU0REMTlrR0xw?=
 =?utf-8?B?QzNYRmpvUXFDay9CMTdualF6N244d2Z6bTFEZXhmTmV6cTdVQ3hzZUg3c05i?=
 =?utf-8?B?ODdDY0F1b3FtZWZBSWRlS3lhMmlVa3NtcFFRbVNlYUZGeGw2MTdKSWZ2bjhr?=
 =?utf-8?B?RjhWa0RTQU50NDBIRWRpWWZyVHhDeURUT2NIcUJJSm9rWjVzbTlTeVpMRkhl?=
 =?utf-8?B?d1JUVnhzNTBRNHUzUUJGbG9rRENtQm1VeUl4NCtVMFEwaEJIdCtmQmtabGww?=
 =?utf-8?B?UWZCSWNETExQMmQzZzk0c0xXR2pMUDc2bU1jQlQ1YWpzTndSUEhHbGVUVFFQ?=
 =?utf-8?B?QzUwY0Yydkk5YSsyb1hkV0VKWFBid0ZXQkNFdjlGSExzbFJFWDNXL3h1N3Bi?=
 =?utf-8?B?UElUR2poUkF5enV2QnhLUFNxY0lRb1dwYXFLaGNvZW9hcG83VTRBQjF0bmpQ?=
 =?utf-8?B?dk42ay9vY1RnamVBRTNGVy9rUGpVWENJckxKc2xhdmRDdlYwVHU4OWlLN3d0?=
 =?utf-8?B?c2lsTGJaR3gzbjRHdGE5SVkyMFFiK3VnOGdJN2o0RTZKdUd5M044UnRGeEhR?=
 =?utf-8?B?a3pHMTcxYjRwRStwTURwNG0vUzM0emNMYkVacCtiNytjSnJQVzBTSkNTRDQy?=
 =?utf-8?B?K09EVXJoLzhNVVBsWitwNm54YnZCOGtCZ0pFVjZvVWc5U1ZaTk5scjhWSDdt?=
 =?utf-8?B?d1JQRXI3bUpuQ1JtdExsZXlaT1V4ek0wS3FTN1YrMEs1YitMZ2xTWlRkVGtr?=
 =?utf-8?B?OFYvR0hkaHZVU1J0NHB5RjVhQnNkTzVUYjJZVmQ4TEdubDVyeVVFNGF6TDRa?=
 =?utf-8?B?YXgxYmJhbFNpSDg2bnJmOWdnY3I4TnlVUnIvUlNXYjJLc3U0ayt6S0p6bGRt?=
 =?utf-8?B?WkFwTHVwSEdZUVB3MzNsYVpyNGsxb09lbHU2cE40LzFhZUFsK1ltS3RMRkVq?=
 =?utf-8?B?SFYxV1Bub0FsSHQ4bUNrNTBVeERTL0w4OEZ0MFc5UVRWZWQ4RXhrOEVtUFFX?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9ce7c4-425f-4cab-3468-08dc12c6d2a1
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:00:32.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFBlCz3ftlkXBGAVITvlULeAJZkL+tdxzRAkNxNITKmqm1X69xUs1zb1Z6Ty8Ab4onIuy3y7jZfHnWBa87dzKUfk3gy9VndkGAJCVK2mIDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8554
X-OriginatorOrg: intel.com



On 1/11/2024 5:11 AM, Simon Horman wrote:
> On Wed, Jan 10, 2024 at 04:39:25PM -0800, Tony Nguyen wrote:
>> Commit 56df345917c0 ("i40e: Remove circular header dependencies and fix
>> headers") redistributed a number of includes from one large header file
>> to the locations they were needed. In some environments, types.h is not
>> included and causing compile issues. The driver should not rely on
>> implicit inclusion from other locations; explicitly include it to these
>> files.
>>
>> Snippet of issue. Entire log can be seen through the Closes: link.
>>
>> In file included from drivers/net/ethernet/intel/i40e/i40e_diag.h:7,
>>                   from drivers/net/ethernet/intel/i40e/i40e_diag.c:4:
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:33:9: error: unknown type name '__le16'
>>     33 |         __le16 flags;
>>        |         ^~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:34:9: error: unknown type name '__le16'
>>     34 |         __le16 opcode;
>>        |         ^~~~~~
>> ...
>> drivers/net/ethernet/intel/i40e/i40e_diag.h:22:9: error: unknown type name 'u32'
>>     22 |         u32 elements;   /* number of elements if array */
>>        |         ^~~
>> drivers/net/ethernet/intel/i40e/i40e_diag.h:23:9: error: unknown type name 'u32'
>>     23 |         u32 stride;     /* bytes between each element */
>>
>> Reported-by: Martin Zaharinov <micron10@gmail.com>
>> Closes: https://lore.kernel.org/netdev/21BBD62A-F874-4E42-B347-93087EEA8126@gmail.com/
>> Fixes: 56df345917c0 ("i40e: Remove circular header dependencies and fix headers")
>> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Hi Tony,
> 
> I agree this is a good change to make.
> But I am curious to know if you were able to reproduce
> the problem reported at the link above.
> Or perhaps more to the point, do you have a config that breaks
> without this patch?

Hi Simon,

Unfortunately, I was not able to reproduce the problem. Since it was 
fairly straightforward on what was happening, I made the patch and 
Martin confirmed it resolved his issue.

Thanks,
Tony

