Return-Path: <netdev+bounces-52309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2107FE42B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE592820B4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A019647A49;
	Wed, 29 Nov 2023 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6NxW+8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC8D67
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 15:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701300605; x=1732836605;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d4E5ZKGJ4Bnd14LBojw7OfDbOeWsHCAK+xJO6ALXlwA=;
  b=F6NxW+8QuFaYg/4NJhEB5ooDbqX+JdaAMXiZVn9lqpEKGwxw1b7YB2VT
   UuZb9w0HtN78auIHs6bMxvAeTFlqpKp6o3TWLmoDEMC6r+rMLLwDc31Nz
   Z9iEAA0FWbQ/TOZw9JJyCcxNGX4SVMIIXFRiDFxtsqMWHhUZIYT7lVctA
   CQwf6XbHHTA575+iYnmqCNj0/wD2uIhSHWLmuMIyjLRB7VnWNA7NUylv1
   WtnoDxt59W27RH4AqPNx7UKY2wmLPekpX5U6avwUepFEuiYTnuPO/W3+J
   VGSlQZ/xCM/5phOWD8vPumOVeKzv7iZ1FiQ/vTsf8eA5sv7KwzvFSiVSv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="424391139"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="424391139"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:30:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="839605031"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="839605031"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 15:30:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 15:30:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 15:30:03 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 15:30:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBN6Hmi6csDxMMW7jdKhxbFrqLgC2THpKgsCFkQfZ5ItuJ7sT1hzV8ycA6etkN6mjts3IShuD+N9j0AhgGvuFmIKNNQj/5u8Y+iS6pcY5UcmGRmK2w9nLPl1pAzO79YCgYlHsn/6Mohbo6LRIRyEGUmMpI2ejNiTzzDRTRiCclNZOolNsNAXVL69QmNleqUyDP2iNKD4m4knOGqOfo5d4xMdzc+2ZfwoYVN1cXDynVhO1P4REKJqzhs74Jc9Vy5LSmhMFiFIYhCcTa3llbSNCX6e19b61RFuXoA+mw8O+D0OqLmOZ8KhQHzU8dQZW1aCpFuuWPlya3v4l7PWff5jRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b2F22hw6wNyYNb4bSTjMjoz5ibP2F+pyKMXgi4KnA0=;
 b=C66mIap8Y6X7dCbsALKLgkb8ypwrVFHLXGGGOBlE62TQIBcYkFHmhG/ja1wMF0mvkgOKy0ImWfc3LaNHHqOtl2xYvzLeAs4137k6/C+Gr30YqWpvvtF9f7XQogIcKX1xe2o15ZKThX+0bjCBkdOwTMZcAVDOOmlBaEzogQl/k6FF8VrfGTfisz4lLEBJxpjQ1uAWlXNH4qw/6+vCvuUhAeS6h9f+z70sEW2Omfu4EPg1Y7JpZN2AD7hBPqtlv1SaIZp5BaYGF4WHFD+zQAR4QdNr9ovkGzybSYqBb5BbNxS30QYXw9LGlrqfcJlJKrJB2dw/iOfBYpS80yq1rU1+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 23:29:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 23:29:59 +0000
Message-ID: <efa6e3fa-16ff-4a28-8bf8-92708cd99b39@intel.com>
Date: Wed, 29 Nov 2023 15:29:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko
	<jiri@resnulli.us>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <jhs@mojatatu.com>,
	<johannes@sipsolutions.net>, <amritha.nambiar@intel.com>, <sdf@google.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
 <3b586f05-a136-fae2-fd8d-410e61fc8211@intel.com>
 <ZWYSz87OfY_J8RYq@smile.fi.intel.com>
 <37a14eca-8127-4897-a6bf-c6260d9d33b9@intel.com>
 <ZWZIOY7Mzx5oFdAu@smile.fi.intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZWZIOY7Mzx5oFdAu@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 594ec44c-c8be-4e7e-f537-08dbf1331a9f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RB8fu65DQ5+UXFLhpEdedFDftgJUtOHdkQ6MYwjp7ePOSOJewIvQfDgXQynIM+srW4fqYt53S6W1LjLfeyP41FMF8JZB7V1szRiE4F22MWjKuuUGPWN7Ena3lR20FCfGAjYli+ZAvh7Y+VFLpVDVTwy9ValPBujxfbcGrHoP+uTFL3vYImgguW/kVNeAvoRgeZN1/GtImzq7RtQTPwnvatFtY187JkMLXGwBUccFQWdSmZGKU+jakd7S+Hjtj4AD+O9/9Girzluiwj3xu0j01hxpjYuUqQ9/cj5h2yDjGGw/hD+XPaMWlEMcvB2ZgqrpEJNEjBQ0Azbw2dhl5FpKxKFBQqtRNi8RYqV0r4CWm349OMK/k7K9xsuFBpzYhYWLnWXmasMZMghT3jd1CAGnGvnHJyDUbuwgdAxwZpmTiP4C5bHjxQYlKlmsjG7OVHb+Y8msZaW1QSXT32vtj9weu6qh552Pb00lMu8ES/cwzVpYtR539c3uwD6fjJNGA4NXB23hCKu/4A2l+QKJvreXfwD6DZwsjDkENdZrjwiID0W2JjOFW/F5npiM4rxX9JyI8qkWIYvpv71NBXdDPj9VnH5b2ZK89hL4/t4UljcalYzVGKM+NbMbISBsYXI6yjtbtffmGTacIDOoOkmHSkwWqNrpcb2gdQ5S0bCcf5JZeraVXAiZiYPPyRzik4V4UbNP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6512007)(66946007)(316002)(6916009)(66476007)(66556008)(54906003)(26005)(6506007)(36756003)(2616005)(478600001)(82960400001)(31696002)(38100700002)(83380400001)(86362001)(53546011)(966005)(6486002)(2906002)(31686004)(7416002)(5660300002)(202311291699003)(8936002)(4326008)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlFSbDJsNGN3UHE2L1JIb1psTTNhSHNUY3ovV1RIdWFOeThEaHlvZlhEdzRJ?=
 =?utf-8?B?QUlnTTkyRnQyUmNONVV6YjhYT20vTnJ3cFRTZ0hobDQwcmVLeTlCdzM1b3kz?=
 =?utf-8?B?Qnh5TmhpSVBVa2pnZERXK0FJTFY2NlMwWkZZMCtWdkpXa25jS3AzbWIxWGp6?=
 =?utf-8?B?M3FDYS9EcDdZSnBjd21lc3c3VWFxRW82M3RZeFJhSUhjL0JJVVFZdWdmMmZl?=
 =?utf-8?B?MEYrWXJPRlRTdHVxdzh0bEszcDR2cHFPMk5VVlB6SmhzbEtLbWdNb3RpZVhO?=
 =?utf-8?B?bU5qcmh3dzVRZHlPaTk5QUVHV1VMQkRvdDBtWTJDVllLUTVYMnN0OFdMOHc5?=
 =?utf-8?B?eElhVU5CajUzWWJ6KzZDelNQd2ZxUzh3Z2FPZlRzS1lHNHB3WURSRTd1ZmVi?=
 =?utf-8?B?VG4zZnZvdVdCWVU2aGo0d0xsbnVyZVZDaDNYQjVUd2NNNElVK0Rvc3BjZ090?=
 =?utf-8?B?aVJMVlRoZDl3ajhDSlB4RVVwR2pqQ3M5eStETkRhVUYrbXpMTkwrNW43WDRK?=
 =?utf-8?B?VlZOWHdEQkpwbWRSdk05NjF3UUJmakVnbGN4WGloRWMwY3NueGVqZFBXLzJr?=
 =?utf-8?B?ZDl4UEx4UDgwNnJvWE1UZjdLY2MrY0xZN2ovZkgwTVE4YVRacDc5U242Nkk2?=
 =?utf-8?B?blN0RWhJZzFPTGhuOHdCdVlUTGtIT0R4QW5icXZ1cmYxR2pDNGdtOHlQOER3?=
 =?utf-8?B?L0VDWmQwSGcxa3lwZVMzUlZ5ZFZzRzZHR3U5SlVlUlNXRGxPR0I0TU4xaTFw?=
 =?utf-8?B?R3paZDNLWGY0cXd2R2pQWm9kRGRKL0QrT2pSalVSRUY2ZlZTbXJkcGhnSVlR?=
 =?utf-8?B?Mk8yYmpoOCtxZERDM2IrcnVNRmI2TTduL2NXM3cvaXZrZHpxRzcyY1dyZUpp?=
 =?utf-8?B?bXc5aHYxNlE3U2lwRThlWnRlL2t4dDFwczgyY29vMlhVZGtaRnd4QlpIZE5q?=
 =?utf-8?B?aVhhZmtQM2tXQ3B2N2puSWJXSHNHenVmNmY0S3ZMdVltRVZHOU54ZVIzNDE0?=
 =?utf-8?B?cjBnZGxuNHF1VWRRajFGWDVickVYdFU1S2xLN0llalIzVC9oRm9jaTN2b01z?=
 =?utf-8?B?cjFHa00veUc4L0MvNkNDbXBxS1RPemF2dE5sTThDY2FINEdSUnE5Z0JlWkx6?=
 =?utf-8?B?bmcwZTJ3K1FEOUJQUk9GMnRidE5JblREdkdLQnByYm8ySC9CcVNBVjQwemNB?=
 =?utf-8?B?Z1pSREhUV2JTdEtZUTB0Rmo5c2M0QWowQmp4MVg1M0ZPSHMwdnJ0azU3SlIw?=
 =?utf-8?B?REZ0YXhmWVNrdXR1ejdkaHpNRStqbkE1UnBzRHoraTgwV2VGSHBUUnZYdHd3?=
 =?utf-8?B?c1Eyck5aQjZ2NWFjN0R2RXlQOStYSnRCMXVFWVRSZU5SUjRBZk0yVUFnNWFr?=
 =?utf-8?B?ZzBmMk9oNEd1ZG1QRisxbDVlQWFOaFNUQUJTVEJZRGpCOHYzMldaMVZnNXVm?=
 =?utf-8?B?cFdORURlRzNUUmhNdlFFVlpldEJ3NkxOTGFvWTN5aXpiV0pZczl3cE5QTXhT?=
 =?utf-8?B?TStpUlhnakVROVhqTFhodDRVeVh3emY5WmliVFljWVRYR3hJVXRsaUhGSEl4?=
 =?utf-8?B?aWpDT284M1A5YlJWRjlsNzNMaFplck11dnhicm5WU3FkYjNZb1poOVg0NkRX?=
 =?utf-8?B?Vm1QVVFBM2YzT3EvNG5nSHZZenFtY0dJdXFBNXF0cURrNktIdWlpM3RtaDZV?=
 =?utf-8?B?YUJTU1VpNHpSTDFXaTlCVGRTWWZ5Y0p3VThBQ28vZVNtU1hzQ2hoSDlaS1RM?=
 =?utf-8?B?THdPczBTOGlJVDdwR1QzVE13ekh2bllkbDBXdUlzSW5ZVHJrVjhMKzI2MWFo?=
 =?utf-8?B?SDhZdllLYkxKMFpZZVZJbW93M3pYWHBIZVdGMWs5RmRBREJYc2NoNFM1YkFO?=
 =?utf-8?B?OTF3RWtLdmpxNnM1bWg2cFBHUUtrQVplYWVtMWowTmk4aHVQLzZMMkdXNnlJ?=
 =?utf-8?B?OGk2ckY3UXBQam5CelRwSEJFRU91WGY0RlJiN3krOG1FcDAya1IyQ1ArK0ZG?=
 =?utf-8?B?MkhyVlNTdzZ5MTBya2hhajFEK0IzZUoxSU1mbTY3R0hRVVdDRENZbitHR1ha?=
 =?utf-8?B?L1pWZ29lY1l6b1FUMXBFejFiWHN0a3BzUlZJYlJmaENNd1U2aWh4QloxdjA5?=
 =?utf-8?B?d09nWXBNMkp5N09oZG1YaE5SM0R6clZMbm9udXRNdkZLQU02dUw1RGMxdkMv?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 594ec44c-c8be-4e7e-f537-08dbf1331a9f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 23:29:59.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDuSLow51Z4V2/3td84jHypJKfwS7b4sjacEgyJ48fsz6Xf1QKYMqRpeR0nq+c62Tudx4dtqKjzzFkghHPoRn6sdoJWfzQgDE0cOkJWNwvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com



On 11/28/2023 12:06 PM, Andy Shevchenko wrote:
> On Tue, Nov 28, 2023 at 11:59:05AM -0800, Jacob Keller wrote:
>> On 11/28/2023 8:18 AM, Andy Shevchenko wrote:
>>> On Tue, Nov 28, 2023 at 01:30:51PM +0100, Przemek Kitszel wrote:
>>>> On 11/23/23 19:15, Jiri Pirko wrote:
> 
> ...
> 
>>>>> + * Returns: valid pointer on success, otherwise NULL.
>>>>
>>>> since you are going to post next revision,
>>>>
>>>> kernel-doc requires "Return:" section (singular form)
>>>> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
>>>>
>>>> for new code we should strive to fulfil the requirement
>>>> (or piss-off someone powerful enough to change the requirement ;))
>>>
>>> Interestingly that the script accepts plural for a few keywords.
>>> Is it documented somewhere as deprecated?
>>
>> I also checked the source:
>>
>> $git grep --count -h 'Returns:' |  awk '{ sum += $1 } END { print sum }'
>> 3646
>> $git grep --count -h 'Return:' |  awk '{ sum += $1 } END { print sum }'
>> 10907
>>
>> So there is a big favor towards using 'Return:', but there are still
>> about 1/3 as many uses of 'Returns:'.
>>
>> I dug into kernel-doc and it looks like it has accepted both "Return"
>> and "Returns" since the first time that section headers were limited:
>> f624adef3d0b ("kernel-doc: limit the "section header:" detection to a
>> select few")
>>
>> I don't see any documentation on 'Returns;' being deprecated, but the
>> documentation does only call out 'Return:'.
> 
> Then I would amend documentation followed by amending scripts, etc.
> Before that it's unclear to me that contributor must use Return:. It
> sounds like similar collision to 80 vs. 100 (former in documentation,
> latter in the checkpatch).
> 
> Of course, there might be sunsystem rules, but again, has to be documented.
> Right?
> 

Documenting it seems reasonable to me.

Thanks,
Jake

