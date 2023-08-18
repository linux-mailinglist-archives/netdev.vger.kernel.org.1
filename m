Return-Path: <netdev+bounces-28768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB2B780A0F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B651C215A7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6252A1548A;
	Fri, 18 Aug 2023 10:30:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C768182A4
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:30:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7064935B8;
	Fri, 18 Aug 2023 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692354604; x=1723890604;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ar6wPLbGuTMDr1vsPjmWRP9OXyXdJgnKfsnnrvD89bI=;
  b=SFWC2qAnugHBSt2CQM2XSY6rYB9qvpVjUZREk5b4J95KfqrZ7Ikx8u3p
   WcAr1aox7J+ofV1kZORpEWkkKfqpowa9VXD1ZQluhvXIIBRiigqzbERO2
   WphOES7BPBEEH4mv+xpPCow8ounQLhf3dVo0vsVO+4M81swmRAn3GwDkL
   wwT/FemLW5CqTLRb5VHAyn6VZjX5xx1CMayaMt4kUJtwIAqvkK/aJABXj
   dPRQXlV/8h+70RGMYqvfFYcuR7DuMRYVYpu2Nc2QhZ443ofEb8/sMwo1e
   P1bxq8bxUFWi/cceIBqLgcQH0EhL1cOE3ype8Pe1U0ZHC9Cw+vZlRiAzY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371971408"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="371971408"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="764520581"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="764520581"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2023 03:28:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 03:28:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 03:28:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 03:28:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 03:28:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVEAhgDAcm12/aShO0bS9hb9ax9xiervMaIUoUNpgFHXuUV9spMFUGgRVwuQqb+hlH3oP8OXYWlAJY1sgDtSZrBvL1/nVYwZKjiEA56AGWNuffg15fFhkvZPzbUTj50S9kaUJDkgFcL1CT3V3y1lOlVgfvNiMGJf7qHye5gXd9NjK/eD58ckBbjkUX4SzNSDlH2sPh/dfomeu6qJN4LLSwIAWhFbAxYKOP5ipiZZWNyRBR1AnB62YaQ3MZIcd1iMfr71Vp1G83Tq8rw5esK5jF8MdhAQMXgpvTiMTXTa/SLX86IgcAwkZN49Q8t90fXdEUWhSdqbIo5VrWz7nYo0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5g2Lc35Q5apZ3HquNi3hj9cl2Gnyy2bIOjT3rFRr3k=;
 b=H86bG5GC9tpbJqkGZ6LgmqNbzSW2teolaGnEjVEb8jmfkhquFAtYQazAJ6O9WP+Nj/FStYcrm2lPUWc3tZeEEIgKyt27wG4OYM5w3Z1Hyb86W8G/ycpY7OeYhbbfXvtiXgo1UjCpI6PdsrtnYBNZyl/u8VE+s/X/WMV808XWjhja84rSI2enCuHj0K0jLYLig5EdAPtDu0zImkCo8nSVG+JtlPxYKFc8qjcKWdQydlK01PmmyamUevIchsY+Y/1eqW6Z6N9SGMG9DSymAzIFCQOoZcNlXHsnIlhQetWLprAeySVSjC8h+xwd3EvgaRYPDSY0t2UYo1LaKrED1T5FCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SN7PR11MB6677.namprd11.prod.outlook.com (2603:10b6:806:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 10:28:26 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 10:28:25 +0000
Message-ID: <3f61b3bc-61d4-6568-9bcb-6fd50553157c@intel.com>
Date: Fri, 18 Aug 2023 12:28:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, 'Kees Cook'
	<keescook@chromium.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Steven Zou <steven.zou@intel.com>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
 <202308170957.F511E69@keescook>
 <e8e109712a1b42288951c958d2f503a5@AcuMS.aculab.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <e8e109712a1b42288951c958d2f503a5@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SN7PR11MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b46ff78-0b7b-47c5-81d7-08db9fd5daea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGyj27yRhFCKS0T0Am9ZtTiAmZZTJjQ+XDZr9DqDr7DzpoTwGE28y1ny8XLDKI/X1kIenZTThYTBNUyNIyyttPEfkcqZK9GuN+kETnRtL1lo8yU5wE+hvIlOk+9bPvWSthUKmitw/JiYeneYgHF9F3PX0r0qdHzlX6QsKOh6q4dgVFBNWt5iYZszUPCc3kuoQDDnmeDMuceVQd/zgLUH3UzfZ/v2PVTagjlgElFmxDJ2oE6rPdcmh8yYp/4CmRUA5a4aTbJsgabKVG1uVmdosN0qD+m2Z/SCoWaVn8zG0jQ7uFg9i+qInOj+8n0gifQpWhICkTmHJmQHBOQ+4utFJ8eJLPF1qNpu+X1H1WV5BXU+AwxsBxJe/jP5xfo4n8lXysHJQt8PUaI+JS2/SSBo/9rWdipzu7dOKWQaSpObzNngIbNmDLy9CVa4djI0YFn2d3IX8LgaGt9wQf9sAazy56dOtAG5oilXl/UfUTNpJVXa40OLbGphinPDrxWyvewdz4kN3O1DvhCLTGCFkeihuQJc01+1VYVDtT8yflXxWpU/oAwt+db5wSDV0Wfx/klxMOhabavf0UXWyb6cUi4BKDxLNyZ5Yqi3arIVmqsRldFLXXzUjHSNmHpnMG6zGMfqqKnsI6Xq7tYpqmWzy9X6NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(186009)(1800799009)(451199024)(2906002)(478600001)(66556008)(66476007)(66946007)(6506007)(54906003)(6666004)(316002)(53546011)(6486002)(5660300002)(966005)(107886003)(110136005)(2616005)(26005)(6512007)(8676002)(4326008)(8936002)(41300700001)(31696002)(86362001)(36756003)(82960400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGVaandIcDB1QkxKOTNuaTA0eFhVUDVPUDFYOFd0VzNMditjeXFSaEVGdGEx?=
 =?utf-8?B?Y3FUUVdlUlFLSXVvNjZRNU9abUt4ZDg3YlQrTkdiSWMwaElLaVdIOERCNm5m?=
 =?utf-8?B?aWZLNW1xaHFEYTZRRUE3RnhFRW5YNCthRmYyRGZtc0VDTEFUZkNCeUl2aldq?=
 =?utf-8?B?ZUxKc2NZQTFpYXVHT0IwL2lpaE1TSi90QUxzTzFnbUNUbUVobDF3ay93WUlB?=
 =?utf-8?B?Zm5ERXovSTJLTE9rWmk1VUUwNkV6REdVYytXMXJkUFhjcFhsWmd3L3RMZzE2?=
 =?utf-8?B?bHl6ZGNYQ0JwbTAxbFF3Y3ZweHIzK0pwci9pS2lUQVFZOExneHpXaG95NEtk?=
 =?utf-8?B?ZkFpMGJ5RWxxOC9PQ1lkWVZpSmZnbTEwWmdCTXJVdHZWRUpZK294cHBsRkhm?=
 =?utf-8?B?VXFiRm0wTTVhWUJFZmQrYmxWWmIvMGhHSzAwS1FydGxRL0czcXhCNkxEelFz?=
 =?utf-8?B?c2NDRDdYcnFZY1FxNTBJd2ZMa01iTi9BTTlLMDJLQW1tb3pqeWlKczMwODZJ?=
 =?utf-8?B?R3hrbjFZTERhcFk4UjdFZmJiOHlBQjExZVI1Y1NhcTFuVkJWMCtsYVN4N2N1?=
 =?utf-8?B?Q0I2Yk5DcDVpVUhlaldkaXFMWmtoY3dXb2RsMWpZMDV1RVZIdzJNUnpUajFk?=
 =?utf-8?B?bXdDQUgzclJxTlk5N1hpVXF6ekMwRG45bGVWWE1ZaElpb21UTGc2MGYyVUpC?=
 =?utf-8?B?MHhIaFhZVm1YK1pQTWJWRTdnYnUrd1RUdUoxMTZKSkg0UkRWQ1U3UXpsUW1V?=
 =?utf-8?B?NFJMbGlSMjRKYkVHTUFtNWh3aG1oQjZwSTVMaklxaVhUQnQ1Q2dJK1RiSXli?=
 =?utf-8?B?eTloRDloaGtrVVRneDhINmgwOCt1YzEvRURXREJtRUhZbW82ZW9ZUk1uc0ZK?=
 =?utf-8?B?alZDemk0NWM1T3A5Rk9zN25VNlZuR25vZG4wRTNIcm45Nlo3MG5COEZhZDVR?=
 =?utf-8?B?M2xrNFhYOGZqZFhjN1NFaVdsWGFCTHFrRHBkQXZhaWQ2RkRRRjBaTXJTeFA1?=
 =?utf-8?B?eVZqTDA2cllpelBtRDBDU2JWL1RRSTlFcTNDWFp0dkRFZy85Rm5EdFpqOVd2?=
 =?utf-8?B?cSt6Q2NyZFN2OVRCYVc1ZFEzWm9jUU9FNkUvS2tZd0F3RDAyNVpNekhKL2ZY?=
 =?utf-8?B?bmRTeGNVMEVsRXJ6SlRPWHJoaWJwYVdFeXJCSG9hOU1SR21qSEI0czY2VWlj?=
 =?utf-8?B?UFIvMThiOHdiNEprR0twYWF0cXVSNW14dXZtZDdkbjlqQy8vLzlFbDdCZ2ky?=
 =?utf-8?B?VHNOS0JrSXNKUHJJbnF2NFlONno0SGphZDFZMEEyZmk5dExtYjJwTTN3WEN3?=
 =?utf-8?B?bmlaYkp1YUFUaHZuNUsxdHNuWERhZXZBWW9jRmZPK3dzWTRVcVFKaEtJN3BD?=
 =?utf-8?B?dmNZcFdoamZqbm9WL04xdXBNZmR0R2lhNWZJaDRqQW1JREhDOFRkU0NuTDd6?=
 =?utf-8?B?NGsyejM3TTROMmVYL3hPU0JCNExkVGFPMVFzV1d5QXR1amdvTWVqU2JjSTJq?=
 =?utf-8?B?UWtHeXpjajh1YkpuMXVPYjNTcVowQytUZmZ0dDJlQXE4UTVJMGc5MHVWaDRS?=
 =?utf-8?B?NlpDUUVOeEZONXRzeGNtZm9YYk9Qa0ZZZ1l2TCtTRjNZcTR6TTNTRFkwTXJF?=
 =?utf-8?B?TzhIMG5qVzlLVGtOaHBXdkE2R2lQbGVteVJCZHJTc1BoQVlCRWl1bHpjWmJV?=
 =?utf-8?B?dlhhSTJCd2g2Q2x5bThRZlIyd0c2bUo4SUZEcXBQdzc1cTVyY21yb1VSQ1hP?=
 =?utf-8?B?NExwTGhWQ3U2Sk5Qc29Lamw1NXBycVBsT0V2NzBvQXB3ZTVuVU1iZVV6SDRR?=
 =?utf-8?B?c3dORnQ1WWRxemI3Vng0OGVRdDhpaU9zNmlDOTBOSS9jL3pyK3Y4c3pGUSsr?=
 =?utf-8?B?VGdRc1EzNGJ5UDhYYzQxVUR3WHdEZCtKUXN6aVlMUzFCaDhRWEZXZ2FjY2hE?=
 =?utf-8?B?Q3JLaEMrU0RGNVhDbEVyVW5pL0hza0QzKzRFNXd6dXYraVQ4emUxQ0UwMGNJ?=
 =?utf-8?B?ZEZUYlJPbmhmWkZ1am1SS1NnZUt5V0ZaMGRGRVdKbVBNWWlnZFN6Y2V5QXNT?=
 =?utf-8?B?WUc1TUZ4dUdZbldnYXFXSTMwTHBnUm9zNWRTUktmckRWaldWYmRhaEUzdjlQ?=
 =?utf-8?B?RDRoc21lbWcvdmkyZ3RtbFBPc3JVZjczZmVkcmwzNkZENUIxNzVEYlBubmdO?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b46ff78-0b7b-47c5-81d7-08db9fd5daea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 10:28:25.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ny8ypifT7knpMcrdJWddQC9+peEn7UhNAcd/nzGSwD5v54WUFplGqLxd0eKdhudKfA19jGm11CikObwTdk9U87jWKsig9+A+QDWT2kOuf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/18/23 09:14, David Laight wrote:
> From: Kees Cook
>> Sent: Thursday, August 17, 2023 6:00 PM
>>
>> On Thu, Aug 17, 2023 at 02:35:23PM +0000, David Laight wrote:
>>> From: Przemek Kitszel
>>>> Sent: Wednesday, August 16, 2023 3:06 PM
> ...
>>>> +#define DEFINE_FLEX(type, name, member, count)					\
>>>> +	union {									\
>>>> +		u8 bytes[struct_size_t(type, member, count)];			\
>>>> +		type obj;							\
>>>> +	} name##_u __aligned(_Alignof(type)) = {};				\
>>>
>>> You shouldn't need the _Alignof() it is the default.
>>
>> In the sense that since "type" is in the union, it's okay?
> 
> The alignment of the union is the larger of the alignments
> of all its members.
> Which is what you want.
> 
>>> I'm not sure you should be forcing the memset() either.
>>
>> This already got discussed: better to fail safe.
> 
> Perhaps call it DEFINE_FLEX_Z() to make this clear and
> give the option for a non-zeroing version later.
> Not everyone wants the expense of zeroing everything.

per Kees, zeroing should be removed by compiler when not needed:
https://lore.kernel.org/intel-wired-lan/202308101128.C4F0FA235@keescook/

Thanks for education on alignment!

> 
> ..
>>> You might want to add:
>>> 	Static_assert(is_constexpr(count), "DEFINE_FLEX: non-constant count " #count);
>>
>> That would be nice, though can Static_assert()s live in the middle of
>> variable definitions?
> 
> I checked and it is fine.
> (I double-checked by adding a statement and getting an error.)

Static_assert with nice wording definitively would make it better, 
thanks again!

> 
> 	David >
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> 


