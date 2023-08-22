Return-Path: <netdev+bounces-29800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D0784BB5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 22:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67141C20B12
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D92E2B559;
	Tue, 22 Aug 2023 20:59:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E932018C
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 20:59:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E75C1BE
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 13:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692737966; x=1724273966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=22+wW4slXcIskqUE/lTyc9K6oJLrJiRYXzDdfbgIEfg=;
  b=CzLO6xDRZaNf5Ugl5iQkAAv7sFuEhLf2UjcL/nBxgFavmRY/hvE+CA00
   F2+N8u59TPpG63+TRtkt0XDeGaTykJZcyfp7Ei+MEnWzNWRUNiiV7V2aZ
   +M0NwngaIGLcDO5ek2xfXrxuETuoUOJvwdtIyoiYn4DttvCmDHoStD4w9
   1mshM+H0bh6YwlIdPMjmW5HwcJsEkynzju4DVVj+oszBD1vmXYiLgVo3N
   Tun5KqcFRom52tVy2z8MVZ9M3FdyQLVJoMJbImjqfT8mnyuz/ETgU80R/
   HbLnZzgMYzHRqWCbrDZkJB6cXnJlKMLqpYUmvKSFSiHmoIVhSoFdta/YB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="440359372"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="440359372"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 13:59:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739474315"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="739474315"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2023 13:59:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 13:59:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 13:59:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 13:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMR14YHpVUDhvAZJpIW6jNL6mBDkHh16SU4zLlAWv/ueEDYShFnfm6XmlpGZQhimq9wSTyP+uFsQR4Ve5h8m/dIpZ7CuGLeaHiWY1bl9NB0INLaILXEz5NTQwcejuPPHvAcLoV8+dMB10BTggHZRF2r3q4e/OyYWzzGREk72eWTSH8zp8wkt9RmvcjkLGBzmVYcgmaVq/wJunigTui+nfz+S9P539gtZxn6TQ9bnStWl9tYPKYecWsNOKgAT9d7NDMalVQ4Z9uuXwlBXdik+mtxXgqX9AcFA0yidIqUmBkquTHGul+Rqk6rtXVsl+TU/cR5u9JC9Jd+2fIaGUy1Rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKD1X/euN/i6Lpl8hg1RkxX/m1ei/nqJLTIhd6QeWOQ=;
 b=S+LaI3wVyKmEnFUPHAMVjKbeEeZAtrzsPdKMI/jhMaJvMe3viBmewX5WxQFZKgUVbfcTDLjIPFVuqt51O64v1UVpBXtpS2pzW49KmJS+9pVjADCar3zhZf91MyfgKGWxQ2XM3mlKvdYf2fXaOdmKqDFCdwQRaDrHqkrrak4kG/PJSAmaep0b9QvcdezlD2KrYspg4NqlIeqXEWSqscAfn4X15WMqq+qUKGhTkEJLKxSSeC9tHOfSGXHq4ed/ukBqBplz5FmHWyqs+yeYjijHiy8cGc/nSDs53zUHiRwkpf/HNf9+zkuIUjE0nZYM+/Tjknt75VThR4LNyNZ6a9AVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by SA1PR11MB7062.namprd11.prod.outlook.com (2603:10b6:806:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 20:59:08 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f%7]) with mapi id 15.20.6699.025; Tue, 22 Aug 2023
 20:59:08 +0000
Message-ID: <dd472741-00b4-2407-76c7-aea35af68747@intel.com>
Date: Tue, 22 Aug 2023 13:59:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
Content-Language: en-US
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Leon Romanovsky <leon@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "Pucha, HimasekharX Reddy"
	<himasekharx.reddy.pucha@intel.com>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-3-anthony.l.nguyen@intel.com>
 <20230815183854.GU22185@unreal>
 <c865cde7-fe13-c158-673a-a0acd200b667@intel.com>
 <20230818111049.GY22185@unreal>
 <87b9788b-bcad-509a-50ef-bf86de2f5c03@intel.com>
 <16fbb0fe-0578-4058-5106-76dbf2a6458e@intel.com>
 <CO1PR11MB5089B58E79D824F37248C843D61FA@CO1PR11MB5089.namprd11.prod.outlook.com>
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <CO1PR11MB5089B58E79D824F37248C843D61FA@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::23) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|SA1PR11MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: d911a8db-7445-4a7a-dcc7-08dba352a0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SrAGqEtXixqmri4UFzd0xflZCUhKS+V7wW8Gq7C1prP1ph9ndXlX2iJp1utxk+SzXoRC995z7SqBo3mOhjbsEkQr1oMCV0E8Ni/b8PsCazWNgEbBMmtPnqw6p/+vF1bOpquErcmD+QFqzB4unf+i+sA1ltS0ScNC4TYiJAxbFrv3mq+EAzWICeMWUrNyCOAIe7+pS5FpzvAV89Ey+mJ381+rwdI5ADqNcGKkxxK7tMnLIx8KsQcDDG+eEL/JDa8Jw4Nis5GO7TUASUKSKKrB6ALiis8RYvI7UEEe8UOmjbI8v0C9HH/4/mHZChSIxKxAnXr+myxBv3z4KW0T1XD3D0cez4TRhZbI4UqIUap/eJxLGihLbGPka4gWHEGkIkiPnGRq5oGPkB475YxCkZ4KNbdHz4pyCq/fp/wgPgNlqUwA6b3SQDGplByiSiURt3w9fAjMCcJ/ocPLk3tHvNgmyGiFk6J1+/KpV9PLcVqC3i1evUfBXHwPlYsd5UZV9NTBuspXchPA694K75Ma2J7ELyG1WEB6wYJN9ZQ+9ZqtcZlvZ7Fn10zKg2YqCfM1ImdMPoUPsfHPDVueI28O9/q/T1T43hUCZTAfXZmwAAbF6Kh1RrSzWZOINFEueXTGUBB0cZ7O/TdXgeCjAOBnSUWibA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(53546011)(6486002)(83380400001)(5660300002)(26005)(31686004)(86362001)(31696002)(8676002)(2616005)(107886003)(8936002)(4326008)(316002)(66946007)(6512007)(54906003)(66556008)(66476007)(110136005)(66899024)(82960400001)(478600001)(6666004)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3prSXpzQm1obkQzMkhVYk1pZTdkT3JLVUtBZ3ZBWUd3WkVEMU4zYXdHMmRk?=
 =?utf-8?B?UEdNSitwaXJZYTJWMEpUZWt0TFV3MGc3OEtlTE5GenI3R0JNcFplWDBPL2VB?=
 =?utf-8?B?Ujd2RXpzeTZRV2Jldytyb0tzeDU2U1ovbkcxbnViZUxReUt3c3IzN1hLd2Rt?=
 =?utf-8?B?MDB3K3pwNGNuaEM1VjhlUU50OVp6cGxEWFBOTE85U2RmazZvaFdnUlZDYlhP?=
 =?utf-8?B?bjlHbDM5VXBJcjFoK2lKNDFUNnhUV1puWDFRRUpPekRxKzNpMHJkSnMwRytK?=
 =?utf-8?B?S1dnZFZvZjYrdDJGaVI0MHFPdXdGZVAxbU9Jb3M2YWZCZjZJZGwvUytlYm1C?=
 =?utf-8?B?SnYwTEgwdy9IeXRxbXJqeFV4cnc0Q2ZyWXVreWhEU2J6WnBkS0owakdBbzdx?=
 =?utf-8?B?NzM2WnpnNVpMTzFLL0xEaU40MUEvYVllNzJueGtaQnRERjRGVkhOaGFhMnpk?=
 =?utf-8?B?ZHhuRHVLY0VMRVVEVTdZd2ZqRDZVYjlva2RXdVZOVmxRUWwyeVRJTjZyM0Q4?=
 =?utf-8?B?VlBYQlhodHgvMkpGei90Ymo5Q2lGUFA0amQvSXpzd2ZSY1hYdEpVZDRlbm95?=
 =?utf-8?B?NExqVVY0cU9IREs4dno0OXdjcWtuOUEvRFRMdDdjOWJ5ME85Q3BUcXUrTjBj?=
 =?utf-8?B?TllNdWRNZlpIN2pkRXlZdzcxd0UzMXNBZ3ljSis4bFlHTzhUdk9vcnNKa05V?=
 =?utf-8?B?ZTlsYWJhdi9wdE5LdzQyeklmOGZXVkdwWHpkRE55MEF6L29iVUF3TGtoMVhY?=
 =?utf-8?B?R1dCZ09aTytVWUFHM1hhcjZGRUsxaXdYUXdrNXhlandmSTM0R1lZSTBXR1pn?=
 =?utf-8?B?K2VTeHZTdzAwOFBFd3NwR3VqcTQ4Yit3VlhZSmZsOVk3R3lJajlkY0RVcnR1?=
 =?utf-8?B?TGhEdWw4RENxQ0F3OHBBbWs5QzZldjZGdmViKzYvOGxpYk1seHUvUzdRWWsy?=
 =?utf-8?B?TzlMU28vbHJiZ2tKNlQrVW9hUnBJdktDYk10ZWlYWk45YTRxN3YrUWtOMzln?=
 =?utf-8?B?MnY5K2N5d25MaURramtlRjEwT0RVVDhJV3lmd3ZkNzhRNkhnUzl4SnRsb2U1?=
 =?utf-8?B?bXY0VVRyNk9QMUczbGRMSE80YVJYcm14Z1RsZjFKOGw0YVJTMVBzbjNuaFVa?=
 =?utf-8?B?R3B1QWkzdSs0anNvamw4U1EraFF0K1l0Vy96dmJTbHNaTnNXVExPSXpzc3NZ?=
 =?utf-8?B?R2p0cEZ0dmRrUG1tRXo3aHhBWmgwTjNFSzdUSDI5TXhzWjdkcDJyazJRemFE?=
 =?utf-8?B?MTF0bmdoWVhCaytUWE42MWFOTGpaOTRPQ1pyWHliQ0MxSGtSbkZpUUoycVo0?=
 =?utf-8?B?L1RFQ1pIN0FQUmZLeVVOd1U4OEpZb3pNUzFKOXhSODMvVU43dldDWEVBc0lS?=
 =?utf-8?B?alJobVE5TTZ3S2ZNbE1UaFFZU2RwaC9MajhtTWdqRE9zQzBYd3R0OTFPUzMz?=
 =?utf-8?B?emtkcEU3REs5OGJkYWVWT2haUHFqTkl1YzBmazJvMHdGdU4wZFRFbjJtRm81?=
 =?utf-8?B?bnNnVlk5NVZUQ1BLMnJKQmxuZFdmQ25DTU5KSnJ6cDR4cXFISkphbHhqQllr?=
 =?utf-8?B?RGpEU2dJZFBaWmdIbjc5anJmMG9mSlRnZ2x3azY5Q0hUQ0t1MnR1bC9qL0dK?=
 =?utf-8?B?djJXYXUrSlgyUTcvUzdET1RWWkRVbmticVJvaFFDSzdNV2d2TWpld25wN2di?=
 =?utf-8?B?TTlwc3IwbnNESEU1Wm5aRFRZWHVjaTZRRFlQbWxpbkJUZHJGclNEWVNUZmp5?=
 =?utf-8?B?Tk1UdHlITmlNN2VyK1d3Snh1YnQ2WEdNWTRCNHBuVjZFeE8xcFhwajlFUEY5?=
 =?utf-8?B?T0poeE5wa2NHa0dGaVRBdUxweWF4eDFWU09mVTJWNXV3YldCN2hsYVZZVHFh?=
 =?utf-8?B?T3l4V3RzMWlxbU05cnBZRWhWYXJtS05vRDNpQXYwem44Yk5acUpXb2ZpZEJO?=
 =?utf-8?B?MlVBaGsxaHkycWVRWWV5L2FIYTR4TWtnMFB6RzYwYkhLcUdPcFA0LzZMMXN3?=
 =?utf-8?B?aTNHM0grZzdHeWl0UlZ4Qjdja1NkQWZYREhZNzJGeDNEeEYzOGVtL2p5WjhX?=
 =?utf-8?B?KzJnZkE5T01Obm9VdUVkU2lPbEtDZmtQNVcybDVOb0hwLzIwemY1cnFZeHY5?=
 =?utf-8?B?VVBjZENETlZCMlpFalh3VU16bGdVZ3FxWmVVNXV1V3ovMjhKaEFCTE1nZ2N0?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d911a8db-7445-4a7a-dcc7-08dba352a0ca
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 20:59:08.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zc4KLoBbKYbTlFebpIwL93D5DFbTJ17Fh7nfxEe4YLe0d4wEVa8joyQ8l1wc+tGMIEd2AhbJeT/ZkFDsfu4QU/MomQu443fPMBKS2ilQYBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/2023 1:45 PM, Keller, Jacob E wrote:
> 
> 
>> -----Original Message-----
>> From: Stillwell Jr, Paul M <paul.m.stillwell.jr@intel.com>
>> Sent: Monday, August 21, 2023 4:21 PM
>> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Leon Romanovsky
>> <leon@kernel.org>
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net;
>> kuba@kernel.org; pabeni@redhat.com; edumazet@google.com;
>> netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>;
>> horms@kernel.org; Pucha, HimasekharX Reddy
>> <himasekharx.reddy.pucha@intel.com>
>> Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
>>
>> On 8/18/2023 5:31 AM, Przemek Kitszel wrote:
>>> On 8/18/23 13:10, Leon Romanovsky wrote:
>>>> On Thu, Aug 17, 2023 at 02:25:34PM -0700, Paul M Stillwell Jr wrote:
>>>>> On 8/15/2023 11:38 AM, Leon Romanovsky wrote:
>>>>>> On Tue, Aug 15, 2023 at 09:57:47AM -0700, Tony Nguyen wrote:
>>>>>>> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>>>>>
>>>>>>> Users want the ability to debug FW issues by retrieving the
>>>>>>> FW logs from the E8xx devices. Use debugfs to allow the user to
>>>>>>> read/write the FW log configuration by adding a 'fwlog/modules' file.
>>>>>>> Reading the file will show either the currently running
>>>>>>> configuration or
>>>>>>> the next configuration (if the user has changed the configuration).
>>>>>>> Writing to the file will update the configuration, but NOT enable the
>>>>>>> configuration (that is a separate command).
>>>>>>>
>>>>>>> To see the status of FW logging then read the 'fwlog/modules' file
>>>>>>> like
>>>>>>> this:
>>>>>>>
>>>>>>> cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>>>>>>
>>>>>>> To change the configuration of FW logging then write to the
>>>>>>> 'fwlog/modules'
>>>>>>> file like this:
>>>>>>>
>>>>>>> echo DCB NORMAL >
>> /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>>>>>>
>>>>>>> The format to change the configuration is
>>>>>>>
>>>>>>> echo <fwlog_module> <fwlog_level> > /sys/kernel/debug/ice/<pci device
>>>>>>
>>>>>> This line is truncated, it is not clear where you are writing.
>>>>>
>>>>> Good catch, I don't know how I missed this... Will fix
>>>>>
>>>>>> And more general question, a long time ago, netdev had a policy of
>>>>>> not-allowing writing to debugfs, was it changed?
>>>>>>
>>>>>
>>>>> I had this same thought and it seems like there were 2 concerns in
>>>>> the past
>>>>
>>>> Maybe, I'm not enough time in netdev world to know the history.
>>>>
>>>>>
>>>>> 1. Having a single file that was read/write with lots of commands going
>>>>> through it
>>>>> 2. Having code in the driver to parse the text from the commands that
>>>>> was
>>>>> error/security prone
>>>>>
>>>>> We have addressed this in 2 ways:
>>>>> 1. Split the commands into multiple files that have a single purpose
>>>>> 2. Use kernel parsing functions for anything where we *have* to pass
>>>>> text to
>>>>> decode
>>>>>
>>>>>>>
>>>>>>> where
>>>>>>>
>>>>>>> * fwlog_level is a name as described below. Each level includes the
>>>>>>>      messages from the previous/lower level
>>>>>>>
>>>>>>>          * NONE
>>>>>>>          *    ERROR
>>>>>>>          *    WARNING
>>>>>>>          *    NORMAL
>>>>>>>          *    VERBOSE
>>>>>>>
>>>>>>> * fwlog_event is a name that represents the module to receive
>>>>>>> events for.
>>>>>>>      The module names are
>>>>>>>
>>>>>>>          *    GENERAL
>>>>>>>          *    CTRL
>>>>>>>          *    LINK
>>>>>>>          *    LINK_TOPO
>>>>>>>          *    DNL
>>>>>>>          *    I2C
>>>>>>>          *    SDP
>>>>>>>          *    MDIO
>>>>>>>          *    ADMINQ
>>>>>>>          *    HDMA
>>>>>>>          *    LLDP
>>>>>>>          *    DCBX
>>>>>>>          *    DCB
>>>>>>>          *    XLR
>>>>>>>          *    NVM
>>>>>>>          *    AUTH
>>>>>>>          *    VPD
>>>>>>>          *    IOSF
>>>>>>>          *    PARSER
>>>>>>>          *    SW
>>>>>>>          *    SCHEDULER
>>>>>>>          *    TXQ
>>>>>>>          *    RSVD
>>>>>>>          *    POST
>>>>>>>          *    WATCHDOG
>>>>>>>          *    TASK_DISPATCH
>>>>>>>          *    MNG
>>>>>>>          *    SYNCE
>>>>>>>          *    HEALTH
>>>>>>>          *    TSDRV
>>>>>>>          *    PFREG
>>>>>>>          *    MDLVER
>>>>>>>          *    ALL
>>>>>>>
>>>>>>> The name ALL is special and specifies setting all of the modules to
>>>>>>> the
>>>>>>> specified fwlog_level.
>>>>>>>
>>>>>>> If the NVM supports FW logging then the file 'fwlog' will be created
>>>>>>> under the PCI device ID for the ice driver. If the file does not exist
>>>>>>> then either the NVM doesn't support FW logging or debugfs is not
>>>>>>> enabled
>>>>>>> on the system.
>>>>>>>
>>>>>>> In addition to configuring the modules, the user can also configure
>>>>>>> the
>>>>>>> number of log messages (resolution) to include in a single Admin
>>>>>>> Receive
>>>>>>> Queue (ARQ) event.The range is 1-128 (1 means push every log
>>>>>>> message, 128
>>>>>>> means push only when the max AQ command buffer is full). The suggested
>>>>>>> value is 10.
>>>>>>>
>>>>>>> To see/change the resolution the user can read/write the
>>>>>>> 'fwlog/resolution' file. An example changing the value to 50 is
>>>>>>>
>>>>>>> echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
>>>>>>>
>>>>>>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>>>>> Tested-by: Pucha Himasekhar Reddy
>>>>>>> <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>>>>>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>>>>> ---
>>>>>>>     drivers/net/ethernet/intel/ice/Makefile       |   4 +-
>>>>>>>     drivers/net/ethernet/intel/ice/ice.h          |  18 +
>>>>>>>     .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  80 ++++
>>>>>>>     drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
>>>>>>>     drivers/net/ethernet/intel/ice/ice_debugfs.c  | 450
>>>>>>> ++++++++++++++++++
>>>>>>>     drivers/net/ethernet/intel/ice/ice_fwlog.c    | 231 +++++++++
>>>>>>>     drivers/net/ethernet/intel/ice/ice_fwlog.h    |  55 +++
>>>>>>>     drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
>>>>>>>     drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>>>>>>>     9 files changed, 867 insertions(+), 1 deletion(-)
>>>>>>>     create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
>>>>>>>     create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
>>>>>>>     create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
>>>>>>>
>>>>>>> diff --git a/drivers/net/ethernet/intel/ice/Makefile
>>>>>>> b/drivers/net/ethernet/intel/ice/Makefile
>>>>>>> index 960277d78e09..d43a59e5f8ee 100644
>>>>>>> --- a/drivers/net/ethernet/intel/ice/Makefile
>>>>>>> +++ b/drivers/net/ethernet/intel/ice/Makefile
>>>>>>> @@ -34,7 +34,8 @@ ice-y := ice_main.o    \
>>>>>>>          ice_lag.o    \
>>>>>>>          ice_ethtool.o  \
>>>>>>>          ice_repr.o    \
>>>>>>> -     ice_tc_lib.o
>>>>>>> +     ice_tc_lib.o    \
>>>>>>> +     ice_fwlog.o
>>>>>>>     ice-$(CONFIG_PCI_IOV) +=    \
>>>>>>>         ice_sriov.o        \
>>>>>>>         ice_virtchnl.o        \
>>>>>>> @@ -49,3 +50,4 @@ ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
>>>>>>>     ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
>>>>>>>     ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o ice_eswitch_br.o
>>>>>>>     ice-$(CONFIG_GNSS) += ice_gnss.o
>>>>>>> +ice-$(CONFIG_DEBUG_FS) += ice_debugfs.o
>>>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice.h
>>>>>>> b/drivers/net/ethernet/intel/ice/ice.h
>>>>>>> index 5ac0ad12f9f1..e6dd9f6f9eee 100644
>>>>>>> --- a/drivers/net/ethernet/intel/ice/ice.h
>>>>>>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>>>>>>> @@ -556,6 +556,8 @@ struct ice_pf {
>>>>>>>         struct ice_vsi_stats **vsi_stats;
>>>>>>>         struct ice_sw *first_sw;    /* first switch created by
>>>>>>> firmware */
>>>>>>>         u16 eswitch_mode;        /* current mode of eswitch */
>>>>>>> +    struct dentry *ice_debugfs_pf;
>>>>>>> +    struct dentry *ice_debugfs_pf_fwlog;
>>>>>>>         struct ice_vfs vfs;
>>>>>>>         DECLARE_BITMAP(features, ICE_F_MAX);
>>>>>>>         DECLARE_BITMAP(state, ICE_STATE_NBITS);
>>>>>>> @@ -861,6 +863,22 @@ static inline bool ice_is_adq_active(struct
>>>>>>> ice_pf *pf)
>>>>>>>         return false;
>>>>>>>     }
>>>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>>>
>>>>>> There is no need in this CONFIG_DEBUG_FS and code should be written
>>>>>> without debugfs stubs.
>>>>>>
>>>>>
>>>>> I don't understand this comment... If the kernel is configured *without*
>>>>> debugfs, won't the kernel fail to compile due to missing functions if we
>>>>> don't do this?
>>>>
>>>> It will work fine, see include/linux/debugfs.h.
>>>
>>> Nice, as-is impl of ice_debugfs_fwlog_init() would just fail on first
>>> debugfs API call.
>>>
>>
>> I've thought about this some more and I am confused what to do. In the
>> Makefile there is a bit that removes ice_debugfs.o if CONFIG_DEBUG_FS is
>> not set. This would result in the stubs being needed (since the
>> functions are called from ice_fwlog.c). In this case the code would not
>> compile (since the functions would be missing). Should I remove the code
>> from the Makefile that deals with ice_debugfs.o (which doesn't make
>> sense since then there will be code in the driver that doesn't get used)
>> or do I leave the stubs in?
>>
> 
> Or, since ice_fwlog depends on debugfs support, also strip the fwlog.o object when CONFIG_DEBUGFS=n.
> 

We should do this as well I think. That makes sense to me, but doesn't 
solve all the issues since the code in question gets called from ice_main.c

> Thanks.
> Jake
> 


