Return-Path: <netdev+bounces-75398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD1869BDB
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488C41C21C34
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FF61474AB;
	Tue, 27 Feb 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/I58g/S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37104137C20
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050679; cv=fail; b=cirGq13T5G3JejmzqSlk1UDI7KyFdjm4n+VsVZ/cpKLv0rpYHxMNjBA8PKGQXyjUOv76XOwHb6+fdbfz+2C6hMHQO88Utne2lkh8zO/WwnFJTJiSh5TdRNB0oHln/hFs65lRBzYIarqvTdbBAfsQdHYy34rfFzl7QPGYqceEGZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050679; c=relaxed/simple;
	bh=F9UOe7ezy9UnaYw6CW2XACFdfP58pGMsFDzfiCt+0II=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ek9AORJ0fCWnPRXhDtL2dQ3/zOl/MFUvJn6wh/ozStv3OfF7AQi7e/pyUGndPIg7s5vcQMxozltiMgkdzIGeStrDWsg4cC5g5fnRFUVjM9ks41W1sKUN9ehnTL6KKR2O5J7xcK8/7ceMF3yGTncO5BnFxxx3MKXsPNN9B1qgMhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/I58g/S; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709050677; x=1740586677;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F9UOe7ezy9UnaYw6CW2XACFdfP58pGMsFDzfiCt+0II=;
  b=Q/I58g/Sc9BwqthaZBSSypwbkKKTgyD2KTx5Zny0XPU6t1ZflnTaeAUZ
   kETtOt5jRpqiI4g2jSI2HiBzP42Ty+Pt9c66s+PMMcbL76Rc4CEyRFGl5
   RdPpgOOlGwFRnmCTytP3w6KmIxYhKX+wh4YOe/yX395JluW7Kmy5/RPBZ
   tLQiGBo0DFnkfS1CXZZoPGLQhzU62Vif/1rSqS+G3KX3euYdh3Ur+hfJw
   3QCe5j4GLwcKRHjTsP8Bt63ubmGMp8y2SYhRkAZBzmjEaGuCKl2cAnCjT
   520kByyNKHv8XRJeTADQBg7OdoG8hZvFagtnqlvT03l+gulTHprqSpJs4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3527782"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3527782"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="30273097"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 08:17:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 08:17:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 08:17:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 08:17:46 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 08:17:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmlOkeTEKwxCDuN1PZZ4k7WsTWVn88/4iFGvxn1j3O9qZ37zKgNX5TpVNSmnY+SMh7fo2lNJ3sVPKJjbYbvvPaCPJPZ69UmURgkC/O6mixjMv6vPPw/A23cEinbA7LbokoQD3y8dBLFBfzx5We3NdEEeGsrdo9bbI56UVhi98kgfXg6uYRmSdhbhUVY06IqxXMTALgBxQ9P1uKZPjBZEkOQVNtkGilnBUAJhZSBmQ0lqtGgIH3/AOaxR5exrPA/ghMjvnAZWsXF1CHBkqdEo4Oq/4attiqcEzQAy/4PkrZs5nVuGLdkLkKaTAMunAOTVpiT3B9nm4qwDGxy6lihgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdnVoNOMDsQ1RawmjYWVPvLexRq4INZEug5UHopwNWg=;
 b=XHhY/ty3I6V2J4EAEvtcOD8noZeTmay7sKq5+pzYDM/Txl82TTniFTTkXTIHyn7d8R28UpBlHa559SfZ9hA8MPgreR1NYeQJKDkyRXEvhxPx72mdoeTXb090YVfD5JBVku4KVXEj8hqRzpg6Mp42t114DFZ87bQDQLFApBOIaRUU3ixObRSNlg01bHRleaqqEiyipnSmrRgWOg1edyslgSSK+Oakc21CYH0b0Me6br2GEyc2w8coWJRXpRHDgaPL9tFeIpcR+GOc0r9ulUboR7Op9lsOrzIKS+zmFBS1CzflbBEoDgCPV4QJyyzexWTpGmkEovb8WY7Sj6/8OBsJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB8525.namprd11.prod.outlook.com (2603:10b6:510:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Tue, 27 Feb
 2024 16:17:44 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 16:17:44 +0000
Message-ID: <6dcf163a-c089-4047-a3d7-ee492778db48@intel.com>
Date: Tue, 27 Feb 2024 17:17:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] netdev: add per-queue statistics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <amritha.nambiar@intel.com>, <danielj@nvidia.com>,
	<mst@redhat.com>, <michael.chan@broadcom.com>, <sdf@google.com>,
	<vadim.fedorenko@linux.dev>
References: <20240226211015.1244807-1-kuba@kernel.org>
 <20240226211015.1244807-2-kuba@kernel.org>
 <e05bed50-ef3f-466c-92e9-913b08bbc86c@intel.com>
 <20240227070041.3472952b@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240227070041.3472952b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c45fba6-bbc5-4d22-82e7-08dc37afa164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V52Kv0Q2BGJy2DDyPWbTcoZ1b8KW5G77mRjcGKeXFyw/B/HMaErVF6QCeE033rIWptfsarOY5e//+aGT7W2jrgbi59OGh5nt9n5JDpqr4T9KjcIQzPRM8p8JxRZ27grC7hToJzF8JtfXgq/uMM/gvcnwk60GHc3iibS6OtOvtYOlRtUY46Ez/38SVhp4Vx1gwFpSpXASd0d1liT7+X4nXtfVn5eT85mOAUs0zVB/RZqgwjZfJl0h7k1LSyZQcsXAaltFoXIniRexRB9wIPZ84oZiNQbPJZJ49ZEk0W4vCr+ZmXWgR9kQvEMmLWWCvAGNLt2pQUKTLQFQ3iqIQbUSTBAYvacXgQGuR2TAMMwEHLSgNM9IPqXQGMQouTvVBQNi+KBbT6/kjauzhSCr5SnoqLXpK4qV5t/KMQ8+v5dBq1ODe3Qf4z0usQS3JsgCbwklH6Lfp3QtRaK5Pxx2N9cFEp4gCWDE4mIYbQe1AdxVidF4BsEW94A54jlO2hovhknWx6SF05KFO4devgmgtTdvQnsDDYhaNyImEpeC34ODzU8eZ+H1ZHtnXRSQenPgnwVrPqGltmcKY+GdhlZ7+JAltaYkZz1NikffAavvvq7YLmJqahx83q5rb0nkDFEfLkdg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djZZeStTU21KV1J2SGttbm4ySkJib040dU0wYlZyeDN3UmVsWXNNTnc5aUhS?=
 =?utf-8?B?Q0hBVDFkQ1lEb1ZwZFgyM244WktuZmtRN21kTlpXK0xxZlhvZ1lQYmNid2V6?=
 =?utf-8?B?aGZMVWx0TTloS3VtUHhjSlZtVVRTTFN4N0c3Z2owTW10Uk1wV0taR0Nmblo2?=
 =?utf-8?B?bUh0SlEwaWx2THUyc1NjSVJHSXFDUVBUakZDMC9Ka3JabHd4cnFadkFXanVm?=
 =?utf-8?B?TXRxTmhnazFrUFZnZWtlcGtFd2V3RG9vaW5zci9jYlNRMk9uaWVBbHNOZHF3?=
 =?utf-8?B?WDJDR1JFMEdicmRGVUl2RDlIMmpHMnpyUFBJS0tSZDN5MVlmbEhSUHAva3Ft?=
 =?utf-8?B?R2ZhOVZYczJaa0h1bmE3SDAwZkJsMW0vZVplZGN1TGltU0NJdk1kYnZEZ1V5?=
 =?utf-8?B?RDB3VXpiQkY0Vk04bHllR3YzNXByckhsQjFQNjhHb3RRZzcwVDFBMGxMOXV6?=
 =?utf-8?B?ekRZQ0dwem8xbFMzNjh5N0Q5WGplRzFTSHVoNGdrSGFCUFdOOXI1d0t4c1Nt?=
 =?utf-8?B?RGtGanpFM1hwTThTQTVoK2dmYjVwa29PZ1lGQlNodVAzcENQMjBsUEREa0JD?=
 =?utf-8?B?TFNhMlFFNlVQM0dlMUFEdkdQZGYvM0FlOUhTSUpiYmJ4ekRMZFJwcXQvZTEr?=
 =?utf-8?B?OGNaZCtCcG9oUE40bmUzQWcxWjNTMHZTR0Zib0c5cFVHRWY1Q2VIdmxEakc1?=
 =?utf-8?B?dFhLYjNVU2RCVzBrcTRvckNjUklZZSsvZ0xqRDkrZjZ0VzNkM2NLVytvcEl2?=
 =?utf-8?B?RzRzcy9YZDlRYU5WbUp6MnhxRWlaa1BQZFBwTENQWjFYWVpsMmRpd2dGdnpo?=
 =?utf-8?B?ZjhkWGhmSDZ3WkNrV1BRbWdiZnBmL0dJSTBQY0F6bWFXNmg0ZVAzQXVab0Jx?=
 =?utf-8?B?M2l6NjV5Y1R1Y3FVSlo3elAxd0xZdW04bm1qR2YyQ2VWRkx2WU9rWm52a05w?=
 =?utf-8?B?dFZkNFlrV0puTFFUVHMzNjhFQzVHK0FzQlYwdkJwZ3BMejlsUmV0UFpsSnZ5?=
 =?utf-8?B?YTM3MG1KSkpmYkI2RWZieFM1QWRNbUh1QWRkeTd5UytNNFJHOHVqcU9UTHB4?=
 =?utf-8?B?ZEhDZEpKbEh2NHNRdzdPK1ZoU3NqSE9hSitGTFRQc3BYUlNJaWMwQkVXNzFM?=
 =?utf-8?B?cUFuVGVaczNKNktBcm16ZUoxMDFYcStBVlZGZk9BbVFaTWhXU0ZGQjBjU2l5?=
 =?utf-8?B?QkhmZUxUa1IwRnUrNFovUjlMc2NWcGg4V3hBZEdXM1BtRXhyWCtJM3FPTXlo?=
 =?utf-8?B?Vmo2MmlFNy85NWFrbUtaZ1RIRWlGNm9PbzdxbVM0aVVzd3BBVGw4WGw2U05M?=
 =?utf-8?B?RkVuMllKR1pQVzc3cllob0N1MkEvS2YzdGtydm1oZ3I2VjcwcDUxNytZQ2JZ?=
 =?utf-8?B?WExhdmVmU1RseG9zQlcybStMM0Z5U3ZRelk1TWNLdHhmVDA4S0F2UFhHd1R0?=
 =?utf-8?B?aUNsd3JIcGZRVkZ3OElEaHZBejhhdTZuMHFCMFdKZ3R2MDV3bU9FaW9hQmtN?=
 =?utf-8?B?VVVGS21PbSsreUZzNU9PaXRBTWMzL2RnK0V2UnE4NnVmWWxMbWdnaUVRN1hK?=
 =?utf-8?B?akVUZ2ZMZEVKMkxUeEJGVERZQU40THRLdjV0M0Y3Q2JSSXhnM3A4SnZUTU02?=
 =?utf-8?B?MUVjdjlIMWFkeG9hSkplK2I2SDJIVnRldXFuM21wS20xamI3L09ySFlRNWZM?=
 =?utf-8?B?aExBLzM3cms3QTBMcDdIeVh3R011VHdZZ2h1R1hwMHlMZVMzWmhtVFN6cGhq?=
 =?utf-8?B?MnpFaHc2VDRtZEFFZHVQVVhwMjVIY1NPUWdJcTcrZ3QyTXZURlV3K1NzUXdO?=
 =?utf-8?B?S0l6bHM1Zk50MWtlaGpvOE84Q1JlZVA5WHpGRW90Q2FTQjhibE1IZ1QxWVVW?=
 =?utf-8?B?b0k0SElZQUt2bHdHL2I4SkNIMlp5OUxMM2lqOWIxd3IxbEs4U3NFbFJxU0pE?=
 =?utf-8?B?RVZWNVJTTkQ3Nkc4Yy9JdW9xYjNJU1J0MTVOQnVIdWtzOHluck9RdFdkYnQz?=
 =?utf-8?B?cVhPZnE2RUQxWXQvSEs1SHFpQXAwYm12L1grT3RZY0J1ZGJqakwrd0FFeHdQ?=
 =?utf-8?B?bVlNSkU0MHBSclZydTlGWi9MdVpRekRia0R4OWMxSXhjMHFCbkdZSTVNTG5E?=
 =?utf-8?B?cnNWRmFFKzA4b3FzYXBhNERMUEhiRmJjTXJEN25EUjhXbDVDVlAvbWk4WWlT?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c45fba6-bbc5-4d22-82e7-08dc37afa164
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:17:44.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IJSm+3u4cam5vpFqvClhmOJEg1KJCKIjRdq/D9suykDJwbq2mAH0pIkzMt4kMxN5Xfh8M+0sfYaiSHwZtBL3bM+s3d02f+2YoUBMu4pJQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8525
X-OriginatorOrg: intel.com

On 2/27/24 16:00, Jakub Kicinski wrote:
> On Tue, 27 Feb 2024 11:29:02 +0100 Przemek Kitszel wrote:
>>> + * Device drivers are encouraged to reset the per-queue statistics when
>>> + * number of queues change. This is because the primary use case for
>>> + * per-queue statistics is currently to detect traffic imbalance.
>>
>> I get it, but encouraging users to reset those on queue-count-change
>> seems to cover that case too. I'm fine though :P
> 
> What do you mean? Did I encourage the users somewhere?

I mean that instead of 'driver should reset on q num change' we could
have 'user should reset stats if wants them zeroed' :)

but this is not a strong opinion

