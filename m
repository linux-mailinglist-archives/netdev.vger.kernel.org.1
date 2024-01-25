Return-Path: <netdev+bounces-65943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8686783C97B
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CE11C218F3
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FDA13D50A;
	Thu, 25 Jan 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bxtf6kT4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4E813BEBD
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202194; cv=fail; b=O5ZGVadyt8oMZfs6NFLpr1enTUeUnF704nxLeRp238gA5SgY4Xy83nqrX/VkTaEGm6ySIbLlj9zG4L7hjioreYsmdl8Im1zN5uv3iCCS+4W7tFPDfzhgeZ94lhTJ5C/DyAtfRkBPQVPz6V/BnnFOr+6bK+9m/figSmQtbrJwzNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202194; c=relaxed/simple;
	bh=oD+32XsgPsNTbEaUU9OqWpI0nVSyc7nweaDMCRpOkcQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VSRKtmtKNUUQ8I+Ed43F3F2vZ2yDNTHMHW1O6WRX8o3Vay6gqS6RuBk8qDetxfzAtxfk6Lb4DlBmDK0YfZ4P+dp0P23s9WT8EGgcwnLYhYqhD6Mt20axQKazav+Kgc1Xhq3qpDLeXFoeBNaYAxD6AnTrOLdpxDzbFnkHI83kGbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bxtf6kT4; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706202192; x=1737738192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oD+32XsgPsNTbEaUU9OqWpI0nVSyc7nweaDMCRpOkcQ=;
  b=Bxtf6kT48wLTYX3zML1oPjd4PQNtaSEKfRwotxkDbq128Js/GMmQN+La
   p5V2dfoNL+dxiy9XX78B2bc+aXrwOpHzq/5oV09mDX3vH/U5ofCdpkLHh
   vghrStFOsfscsyLIbSKPeUIyYyJ5FZtqRwTnWenP6uDdTMKCRHOetdQ3g
   uV96oezhf1Y8FlIbpoq26bVVNyfHDPQBUPoXojeSk5t/3oL1t3yxSxTau
   AyWO6CHiWOEpfd5I4fy0TfboN4GIoKxxARZzmiM4FQt2/b0d+wv6ku3Tn
   FRurOdyoXDCPh7Zp9VB+9vAj1Tn5xeEPTal59/pnHC0X5e3fCNbkoBN5+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1143334"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1143334"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 09:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="910063659"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="910063659"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 09:01:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 09:01:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 09:01:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 09:01:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlfNrS07Go/c+kpBRI32ZwFI6QWW+Xy3xUDoP22zf6mFd/ZgIW2zbh5Q4KvOsviEfr6G7d8zRIlCpag+CYBIEQCD5n/873xCwbv4ozEK/cRtkbxWDc2Dvjs0wVSiWNJjFRiBdxPgYcLI2YrZvD9V4GfYqaXzlwP4dNqRUdll7TBzjGNGDrrdfZYEw5AY/kYPzkzJXPAThSt5XS4h34juQyAe/DhGV5EQZhLFfBWziDxpUHhN6WPtIEiJcv58jwAQIXNy1+sTrQ98Hnel7PU+287S2qD1Xf0QWink8pV7EzBqpelHtVfS76cTqbC+4gmT+p6zXsyVQx/vvBw8787mIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xww9Zk4VtZaEzO3VVdMAUi6odq++2xkUQS5sRCZDs6o=;
 b=YimJBe6M05vnOdbV+sJIiMOlziAG/D5msAe4t2kH2RFawkcYbfUbj9FsR/yQAIQm4sgUvjJjp3teMpQdyz17dmqk6my7g+JzR9tMY6soVbcgw7ozsNTqPEVpZckiuJuyLiODBKHugkbtM5ERV7y5bd4N5r1JWBtOCxB5jIMHu1agvzheIufDmklujGHE0LQjlyOpCOjrDklnwhWBe0ivzzwWek/WbQjZZ/FYTYnMpgIBLj82a4tGOoM9yjIYtRr26PHDaRAZmbzNgBj+6acpCyc4JQRlI9H/AiPckoV6XVcowmlMGrL6lqpzCoy+YmY6p23g/WZ+C3tUL5s8uLtZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24)
 by SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 17:01:19 +0000
Received: from CO1PR11MB5186.namprd11.prod.outlook.com
 ([fe80::bf2:91ee:5ddd:6f77]) by CO1PR11MB5186.namprd11.prod.outlook.com
 ([fe80::bf2:91ee:5ddd:6f77%3]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 17:01:19 +0000
Message-ID: <0773912d-28bd-479f-ae1d-8aa5c636ee52@intel.com>
Date: Thu, 25 Jan 2024 09:01:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6 iwl-next] idpf: refactor remaining virtchnl messages
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>
References: <20240122211125.840833-1-alan.brady@intel.com>
 <20240122211125.840833-5-alan.brady@intel.com>
 <65b1d2b755e27_250560294e8@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: "Brady, Alan" <alan.brady@intel.com>
In-Reply-To: <65b1d2b755e27_250560294e8@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:303:b8::14) To CO1PR11MB5186.namprd11.prod.outlook.com
 (2603:10b6:303:9b::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5186:EE_|SJ0PR11MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 022471b3-8b8f-481e-e3e1-08dc1dc74079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZaSAOY3EaWTla7ppXPd6I3n2JwNCvMXcqAvkPmjefTxqtrg3ez/lgku7DLTx0cEk1LSu0InLA9RNckUWMMtjcTobZjDhHPpTHGyq73rjka2kcXwnKO1v6hCv/xEm02o1SwiZl+IZfU+qLxZDrY3pfyUGbCOVnybDJ10xP4+BMd3cspVSvJESlCYytqlk6IId6qrxI4b3bFeXNw+zi+sZqUDAC30M12GuNZw3NG3kfZB7jHqoM7nHdcUDOybjJQ7yIDRftAxKtN64qANz3p6sDoVLh7bcysNcAWtdI1P10/mGWeofhH+6QsYSXr4pezBZi7+urlzIfTDeSGNYhXGt6J64g0ANJMsNpRd3CtFenvy0NZi6KdpBY9l5G2lPznCsgOtiIo8faKRRxH3cjzKvBvEacBUTFOGT1YbGDLI7jbo+n1mXTbfaUaaJrDa8zo9Qpkri2v3hShKpX60AhAB9ghU8ob9JgiPAbEN6Zb/82ox53ExzVSsFQ0l05V92XESYQaProbTuPADhw65Dc359+dz3hH4GZp4fOesz3ZPxJIaa5HE85SSM6nB5F4JcNCJFNHcfkqdDIa4SM0+LhsxsnkaJsq2if/E3Muat++/e/qbeGl9R8hyBMUpYkT9lKGXkV/TJpWfpuFAhIGi12rnBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5186.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(8676002)(4326008)(8936002)(83380400001)(38100700002)(15650500001)(2906002)(66476007)(316002)(54906003)(66556008)(66946007)(26005)(2616005)(107886003)(5660300002)(31686004)(36756003)(86362001)(31696002)(6486002)(41300700001)(82960400001)(53546011)(6506007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG0yZk1WRkNLc0hTSnJ3UmhTWGNuZkJFMmFBbUxuTFo1bTA2TFZsbEdTWG96?=
 =?utf-8?B?ckpOMUJRam9LN0RWUnAwbERjR1UrWHl6OXgxZVFhcjVpaVRCMXVnRG5IeTBq?=
 =?utf-8?B?UzBmbjNSaHNONjJLYUUyUDUvckdURksrUVVvL0t1NlhzeVRiTWk1SlpkTlZq?=
 =?utf-8?B?OTVsVmlja0Fza2hGSVlLR2pJeHBoMXhHa2E3NE1vZUJxaVlaaGl4ZUFWd1RC?=
 =?utf-8?B?eGo2LzVLRlQxUHJseG5IVWlYRWNmcTdlVkpkcmJiaW1GRFA2REhvVDZReWg0?=
 =?utf-8?B?QjdMMzZtakV4T2tienNqckZvTVNDMWlSbGdPRGwzQTN3NEY4NjBNQmphMkJj?=
 =?utf-8?B?M085NmxGOXNrdmNPMEtRZm5EWG80bjN4OFNjWWtGeDZ6ZjhxcXVQZENPQWdQ?=
 =?utf-8?B?M0duSkdNNzlOMENtSVNSRlJpbGw3ZjVzeVNKTzdZenRBZlBIb3ZDblNrMkJx?=
 =?utf-8?B?Z0ZKTlY0SUdQUUU4K2tSdmtrRTQ3MEcweVBMeEZBekpOZnFWNTlOTU4wc1p0?=
 =?utf-8?B?bk9WOUdBQUQ1ZHRmenE5N0RDWFdvb0xnQnI1MDY4VSsrVW1vakpHQXgwdkFz?=
 =?utf-8?B?cUlxUk9OTUwyRUgxRU1iUkZTUlFNeWNyVVJ2a0pYdm9aNHU3a2Mzb0FiWHdD?=
 =?utf-8?B?RnNtUWl5aXVhQTdCdEppaWFnMDBvaVFLZUZ6RlMzY0ptUDQxcitpT1pwQ2Zq?=
 =?utf-8?B?ZkhSNDlxaU52WkNKS1VsVjk0SmVxaXVqbTNFOThBMzFqenFtZTBTekJReTNs?=
 =?utf-8?B?aENMRzZFNVdZOXlrZ3NPWXEvUGFHSGNZSmNqTVNkMXd5eUk4RXI2bzNQUE80?=
 =?utf-8?B?aGJiV3krNlh4WmJLb3JGd2Nqd284QXBSc1Y0QXUwWUhDNVFtWU5xWVFJaDdo?=
 =?utf-8?B?ZmZ6bzR1Sjh5WDhFQ3o3K0Qrd2JhWm1vRjUwcm5uOHJYQXdrdXdVYTNNQkJv?=
 =?utf-8?B?VGpiU2xPdHNXTjNuajZoallHVU5QMzhDUTVmeVEzSXZNcXFNc2lqUVY4TE94?=
 =?utf-8?B?UlRPOWtJMjc4T3Y0NE96ZXNUamNja1VZeGsxeEdSUys0K3ZLQ1hjbUE3TU5R?=
 =?utf-8?B?dUk0RStaWEpSbytyTHpabTVLeDBuTVFXWUpnOThhaXVsRVhmTGR4aDQ1Wk1N?=
 =?utf-8?B?ZWluUzh3Q01ZaTVqZE4wWHNsbW1sd1V3RG4yK3VrdDQ3Q2dWaXYzMytEZVc2?=
 =?utf-8?B?VmpqUVdiVzR4dDljVWpLR05acWlzYVZZMFpuN2VlVEZxZEcrQ0xGY0RqRmc1?=
 =?utf-8?B?OXBoVU1hYUhBcjVpSzY0Q3R1K0xndEJmdyszMEIyYVdWL1djNkJzWGRvWXl4?=
 =?utf-8?B?a3NMQmVkd3Vvbkw5QmNzT2U3SnlLb0c1Um1PVEU0RndjK1grRnUxUENnR1Fx?=
 =?utf-8?B?OHNUeUt2YzFYYWdFclFlUjJCbGNtanlqOUN1L0tiZGE2MzVvOHNPRy9rN0hC?=
 =?utf-8?B?YmdvMmd2WWFWUU9DU3Z3bVVMRjBrbHFPelIxSlp4bkdvcldRU3VqM1BMUk1F?=
 =?utf-8?B?N3B5N2k3NjJpdm52SDdhRER2QjlyQzQraUhsVEhBbUJienhubnMvNlIzUWY0?=
 =?utf-8?B?ZFIvTGVHVkNKUW5DWXRxMnJVNDR5bTIzdWhOa09JSVZMMFdLZEZOVGxmSkpo?=
 =?utf-8?B?MVRSWTc3RStwUDlkc2tWcVdISDJHWFh3cVZZR0Njay9LZlhKekhxdDlkNmw1?=
 =?utf-8?B?ekZydFdGRE1XR0hLUy82cXdXTkU1WUNvZmtYTjdIS2NOaG5UeFNXbm00WUpE?=
 =?utf-8?B?VFNGcFk5WjYzZUZFKzcvWnRISWhyc3RVVXBtWHA5SUVDTXpZN2JRTXVXbEVF?=
 =?utf-8?B?dXhwL0R1VzdUak5ZbmFpMmtNNUU0M0RDNlozNStVMTF4TCtXei9rWE54OGJZ?=
 =?utf-8?B?MWx4ajhsOUs3M0NOTW5VVE5sVkdJTzBTVjNncmQyOWFSTzd5Mjl5VWNZTTJO?=
 =?utf-8?B?RUZpcVhtZnREcklEZ2psQ2JHWkpVSkZPMGhmVGNpVTRqMEkrMXN2VHNyM1lM?=
 =?utf-8?B?Q0dua2g4Z3RXTGU1OGtwVzZwQnhLTXNvOE8wL0ZsRGV4dXNjY3JLbDFXV3dX?=
 =?utf-8?B?NENHQy9rYXlWOEwrdGt0Y3YxU2VPSng3ckpMYnlPWkJhMkxZcEJ6cS9QUlh3?=
 =?utf-8?Q?6JJlmNZSPhBjEqjsoB59wE3e2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 022471b3-8b8f-481e-e3e1-08dc1dc74079
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5186.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 17:01:19.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAvaL4hOIGBApi7VcebcFb99VYk95fexDrbHYTOa/1pIWDziaJqPOtIcu3UbFRsGGWJsQpGz0jVSBHtelg0XKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com

On 1/24/2024 7:17 PM, Willem de Bruijn wrote:
> Alan Brady wrote:
>> This takes care of RSS/SRIOV/MAC and other misc virtchnl messages. This
>> again is mostly mechanical. There's some added functionality with MAC
>> filters which makes sure we remove bad filters now that we can better
>> handle asynchronous messages.
> Can you split the part that is pure refactor and the part that is new
> functionality?
>
> That will make reviewing both easier. The first should be a NOOP.


Sure thing. Added functionality is fairly well isolated to 
idpf_mac_filter_async_handler so should be straightforward to split it.

-Alan


>> There's still a bit more cleanup we can do here to remove stuff that's
>> not being used anymore now; follow-up patch will take care of loose
>> ends.
>>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
>> Signed-off-by: Alan Brady <alan.brady@intel.com>
>> ---
>>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 933 +++++++-----------
>>   1 file changed, 375 insertions(+), 558 deletions(-)

