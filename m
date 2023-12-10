Return-Path: <netdev+bounces-55580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A940D80B833
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 01:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFDB280E6E
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 00:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD18179;
	Sun, 10 Dec 2023 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvmhnRnZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1150A92
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 16:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702166994; x=1733702994;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WZFAQOO5+u8i/J/Zx2pmtaPCS4woKH/ZxGnPi4HynWw=;
  b=HvmhnRnZpDoWNdXfX9l2qzgg5m7e3un/HSpTVoFnrXagezBdKu6AosJZ
   7mCfmy0oHcONapJ7gJ6JqQqdR42QsmUeofKYiQTUKsRuhMKjhspbSc9vZ
   4rodMPeEhqcMcWHCexYGPKMK+bYIPMQ5bUjUdregwwLonmE8s2bTLZBYm
   Mp9UXsnvzEetxa4nhw2aRkrmN44H3H/T1Zq85MKdbpwHOgYssFvQJw1eP
   xxsvSaZ7FQP/qN8VO4ENoZd1xNn5o7itCQKI1RQsXGA4IELmJkRyaTk5+
   OjDWlaeqNyKcd+hQwDqAnncmTGl5nrv7cKKj3/oR8UHkU8vUcsUkdwhA7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="13224432"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="13224432"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 16:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="765884195"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="765884195"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2023 16:09:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Dec 2023 16:09:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 9 Dec 2023 16:09:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 9 Dec 2023 16:09:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqM2HJsg3WtyKdCi7dfrWTtlmz7aKO6cHx2M7DANESGAkN/tqqmCIl30NI2LfBx+eI5WmecP/w07MliPtcxUZ8MFliBlVkLigNX2whgDAh0fwTApC4s0E4SlpqOw3V5jqHX1ta9nVxsJRi24ppAoqtAh01BYXNop5FZ3+TvIhjy33FdQmL1IUw9Qx6QotR7CsGTh9C2N6cIck+oVV0zDgh2wDhj5JJ1LuB5e2RjONcOTmk3REmztxvks7Yh5HQc4EmWn8+O0GXY3bgykGGQ9Z4Z9T1ikNetjtEdc7MfbNNRBkTjhCpIl/aaY/OGrQG51ZVdloKB+l/SlFdVe1pkTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsGvMWow1gxjcsJxs34/FCwO9/fhL8xSqfNOOFOUeTQ=;
 b=O+o61de54nWJQpR8Qqzr5KRtnd5fdZ2ku9//GFBH0TSs4hRCpWhHHQyPSc91+De+7x5tBi2SmaVQKTApObxZ14BWRZSbCIoPAUWXxDaKvg4tuRYAUGWjf4yAlHK11qo7AaH0qI9ENG5A/Gd2z5j8L+JicVB1lcy9efPOu1UyC3eUT+3r2LZwtQp46kedis9EUxj3wWFRbf3q4R5J4II0mfvNIWIg9xkCpuVHoDDW4JpOvCWxfgRDfrOCITaQxZeWm3MEcJp2PjGoUT24NW+3Vc8+JdA/brxCIiUhNZeYQnsFT3oH6gcAU0fpSTDlRytFqTghJaNAkuWCJnCGWsCAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by MW6PR11MB8439.namprd11.prod.outlook.com (2603:10b6:303:23e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sun, 10 Dec
 2023 00:09:42 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7e96:f1c3:2df8:f29f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7e96:f1c3:2df8:f29f%3]) with mapi id 15.20.7068.031; Sun, 10 Dec 2023
 00:09:42 +0000
Message-ID: <df263bfa-9610-419b-8b17-623f5fb54d26@intel.com>
Date: Sat, 9 Dec 2023 16:09:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] ice: configure FW logging
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<jacob.e.keller@intel.com>, <vaishnavi.tipireddy@intel.com>,
	<horms@kernel.org>, <leon@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20231205211251.2122874-1-anthony.l.nguyen@intel.com>
 <20231205211251.2122874-3-anthony.l.nguyen@intel.com>
 <20231206195304.6226771d@kernel.org>
 <75bc978a-8184-ffa3-911e-cceacf8adcd0@intel.com>
 <20231207181941.2b16a380@kernel.org>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20231207181941.2b16a380@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|MW6PR11MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d4a59e-c7fe-4f76-1fd5-08dbf9144ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHTEyNtD7c4CrJOJWDeZ7eKZISND16NmSQ2tuyEZXU2o471DFrfg6gW8V9IwbXxd+2iHzLCvtXHb3xvfBHpv7jkI/prwMqwoq7d5nrSY6esBA5rhqMiloihX/pHHqXRPz1VBKLend/khswSFKyUoLYEqZR3F7YSRGEcPAt2ErjkQN2bZhHSkZd7tZGMTmUTig9mZK2KYOwYiNofoQU4Jr1IylpFhpbdPwz3AmCL7XT1fkUNa0hdegGXWjOiXVUerr4Q/0lp1LYVP4sdMoYJFkcBrVgGyk2c0oNeS88ZjZ1Cuv/aCUusS9DcdrDemeJp1uHneEC9YDHSOg9bSm+xMxTpS8X06alMB0H5PjqD17LhoPvZicdwQAzDOrN14pz5Q1F2/IgUXyxhhVJtIzxtYbfmrAYAT3gNQ6NjCtfqI/isjyLrSwWSkKLJA/+nGwJTxkieIRtXQ9Wl9JasJ5Sm9ozaTAFtVBgz/AHNV7CQSzP2C4ZmoHbFOpW9cffYNUmKvjLcrrG27A1J2/9NB6r8ezFk4I+cHsuziYvAF0BEpGjgRYcE/B84sTpjHru8dDz8Vmuta1AIr4SMf0h/+t7IbrNgKSb9dfBf+xwRbQsMQT1nk6mwquk83/GVBgBh6KeO+SpsPMCPfxJnfodCsk/lV5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31696002)(86362001)(36756003)(82960400001)(66899024)(2906002)(6506007)(53546011)(5660300002)(6486002)(478600001)(6512007)(26005)(107886003)(2616005)(316002)(66556008)(66946007)(66476007)(6916009)(54906003)(8936002)(8676002)(4326008)(31686004)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0cyd2lZTnQ5SlRBVGFLZDhhWEhHdWExR1VFZHp6YmliS1Q3aVA2bFFXVEdi?=
 =?utf-8?B?aEhhUFlrSk9TNWQvK2RUQ2J2dDgzL245akppODBiMk5vT0l6d3I1Q3kyWWJW?=
 =?utf-8?B?QmtaVUcyQkRQTzBzcHNRdllKVENlOGFLMTdNbS9RRVprMlZCelRuMVJUNm1N?=
 =?utf-8?B?Nk0ybSsvYnZ0Nk9yUGo2UDd5WWY4R21YellYYmljd3NkZ3RlYTNqNjZiRDAy?=
 =?utf-8?B?bjFUWXJ4bjRQYWZKMXdXUUR5dEJVWjNOUEthWEhlckJ3eDdJK0VLc0xPdWZD?=
 =?utf-8?B?eWVpVjdGT0ZZMWlnRlQ3aUhBQkNBOVdWbHdsZnd6OHBiMDN4L2xLc21OaXdZ?=
 =?utf-8?B?WGhTb1pJN0UrYThPZFhXbzVyVFR4K0dRQ3JOejR4YlRGSkJ4RlR3QjY0bWky?=
 =?utf-8?B?ZmFVZytmZm40cmpkWHJKaGdpQk1zeEdPaFljeS9MSjMvSThMQTZRaWNyZTNs?=
 =?utf-8?B?YldQbmMzSDdCM3FuaUpIUEFzRW15QVJ3cFdlZnp6WGVGdXRrMHFsZWtkTEpB?=
 =?utf-8?B?R3FmVGkzZnpmUmhDOUs5Z1hwQzNCSjRaQmIveTdoQ3RFNkZDcEZoVDZrR25r?=
 =?utf-8?B?NlJnZ0RscnFxNkxsK1lZZ0EwRVFGSVNlQmlUbWIwZTFvUWMzdlhuVjZYMUpU?=
 =?utf-8?B?SmdUQ1N6dWozbnhSenRhejNwRXQ3VTFGVjlLc2t4YWdUenQ0ZWZMTTRNeldU?=
 =?utf-8?B?S3VQcDhKeHpkRzRaMDl2VmF0dkFhaVpURmFsNUpPdC9MWEpNK041aGxUeEpK?=
 =?utf-8?B?VmY4Wnpnb3Vvb1g5d3VEM0l1VlY4MnlERkRmQ2NvcHl6eHBVZ1FuaTVnN292?=
 =?utf-8?B?RGtBY0lsWDk2L3pLd1NDb0NUQXR4d3hZeUM2QWFpKytRdkdLUmdsZUVZVG13?=
 =?utf-8?B?UUxhZG8rSWNVVUtuL2ZrMndlSUJUL2QwNlFWQWY5a3VMcWFBMlYrTnd0MDIr?=
 =?utf-8?B?a3NSWGtBeGNPQkZ5VStCMXFQYTQycmVyNE5JcWtSM3FCY0szd0s2YnFQaS8y?=
 =?utf-8?B?bWNNLzI3ZWpaVFhkeVl6eGtySFgrMFlZb25PWXBKbGV1azd0TytEWVlucWY0?=
 =?utf-8?B?VUlvZ09VMFhFRVo1SGJEa0tMN0RGSFU2WE5kN0JqTWNaNEw4QkdZTklqSzlv?=
 =?utf-8?B?SG1maUw2VEo4ZXJqeUVHdm8zWTYvQWhMQStNWVVxYWFnKy9XdFcvN3pibXRV?=
 =?utf-8?B?Z1VkRk16UUdVK2x1UWpxOVczZ3BnRUM4MEI1bXM2NzlKTlZtRGMrUUluQ2Ja?=
 =?utf-8?B?aWh0SFdYOHdFTWVjNlRvZ2tqRmlwSm5FV05kRHZCMWN5UXVkNWpqQ0lIWGpy?=
 =?utf-8?B?Q2ZmbnpKVTRZOVkycEkwS1o1NTNRQW94TU5ZVEJvWWJKeTF4MUNiTnA5b25R?=
 =?utf-8?B?MGYrSjE0dno2azBsSTcvSjlkY293MVUyaWZWZHFnai9qNG82bmJ5YVh3dDFx?=
 =?utf-8?B?SXJxcUVydlhCT29tOGEwSCs3cS9yRExIUVNqRzJsVG5hdC9rRmhhS2JZY2Jw?=
 =?utf-8?B?b3FZTEovU29mVEhweVY5YzhEZGgydGEycm12NDNwdGFqSDF0SXkwMFZHRE9o?=
 =?utf-8?B?QzZjZWdRK2dKK05VOW8ra1Bqd1o0NlNSQ3JlaUpaK2pjTklDZzFGeFViQ0RF?=
 =?utf-8?B?eGhBNlZiUWJNa2JiQkN2Z2NBczQ3b2VIQnhoa3pXeVBTNzdkTFJGMHA0VVJS?=
 =?utf-8?B?MlpWbXlLSEJyZWgxU2xQTU9qdTJ3ZGxXdmhsU3YwZUV1djhFZDJWVDdjSkZJ?=
 =?utf-8?B?SEZheVJMN3pFTXFpU2FDOGV1d1BtS0hKOFgyUVlhenRRdUNMMXZCNk9iRW1m?=
 =?utf-8?B?c3Y3MllEMlR6T2lwdTZkOTJDN3dNaC8xd1JDM3lBQU1zd2I1cDRmN0NDeWNN?=
 =?utf-8?B?ZkQ2WU55MWtrT3VCS2RUb0NROWl0ZXlUK21LcjlXdVM3Ni9ldW9oZTZNR3ZM?=
 =?utf-8?B?TGtmV09hRDMyZUd0VFoyQ3UxWFF6L2pId3NKaDVHUmgzc1Ird2FVcTFnNXI2?=
 =?utf-8?B?Y2d3eDkwRmtKY3psdGV1WUM0YnZKWjFmbjVnVkNQcDZjVGtUV1FITXhVdzJt?=
 =?utf-8?B?eXNta2pDTzVzdGlUQmhqNHdVZWNEdWFaTUdoT21MWUFMOXhKTkJxT2Q3dHZk?=
 =?utf-8?B?M3BtenRDcE1UYlZRMGVVY0pmMUgxbkdHT1d4LzZpOXNoVFdLS092MnZSY2Fp?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d4a59e-c7fe-4f76-1fd5-08dbf9144ef4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 00:09:42.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3b1IfJNr5OcpZBeek7Du4Kx4g+YRQxpWq7gZyKi8C27ksgw0teRz4FFt8nevPga8SXlcPPPc9oxPx6CA5KjL/FMNvqVkIsJZ+msyv99cMT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8439
X-OriginatorOrg: intel.com

On 12/7/2023 6:19 PM, Jakub Kicinski wrote:
> On Thu, 7 Dec 2023 16:28:27 -0800 Paul M Stillwell Jr wrote:
>> On 12/6/2023 7:53 PM, Jakub Kicinski wrote:
>>> On Tue,  5 Dec 2023 13:12:45 -0800 Tony Nguyen wrote:
>>>> +/**
>>>> + * ice_debugfs_parse_cmd_line - Parse the command line that was passed in
>>>> + * @src: pointer to a buffer holding the command line
>>>> + * @len: size of the buffer in bytes
>>>> + * @argv: pointer to store the command line items
>>>> + * @argc: pointer to store the number of command line items
>>>> + */
>>>> +static ssize_t ice_debugfs_parse_cmd_line(const char __user *src, size_t len,
>>>> +					  char ***argv, int *argc)
>>>> +{
>>>> +	char *cmd_buf, *cmd_buf_tmp;
>>>> +
>>>> +	cmd_buf = memdup_user(src, len);
>>>> +	if (IS_ERR(cmd_buf))
>>>> +		return PTR_ERR(cmd_buf);
>>>> +	cmd_buf[len] = '\0';
>>>> +
>>>> +	/* the cmd_buf has a newline at the end of the command so
>>>> +	 * remove it
>>>> +	 */
>>>> +	cmd_buf_tmp = strchr(cmd_buf, '\n');
>>>> +	if (cmd_buf_tmp) {
>>>> +		*cmd_buf_tmp = '\0';
>>>> +		len = (size_t)cmd_buf_tmp - (size_t)cmd_buf;
>>>> +	}
>>>> +
>>>> +	*argv = argv_split(GFP_KERNEL, cmd_buf, argc);
>>>> +	kfree(cmd_buf);
>>>> +	if (!*argv)
>>>> +		return -ENOMEM;
>>>
>>> I haven't spotted a single caller wanting this full argc/argv parsing.
>>> Can we please not add this complexity until its really needed?
>>>    
>>
>> I can remove it, but I use it in all the _write functions. I use the
>> argc to make sure I'm only getting one value to a write and I use
>> argv[0] to deal with the value.
>>
>> Honestly I'm not sure how valuable it is to check for a single argument,
>> but I'm fairly certain our validation team will file a bug if they pass
>> more than one argument and something happens :)
> 
> Just eyeballing the code - you'd still accept
> 
>    echo -e 'val1\0val2' > file
> 
> right? :) Perhaps less like that validation would come up with that
> but even the standard debugfs implementations don't seem to care too
> much (example of bool file in netdevsim):
> 
> # cat bpf_bind_accept
> Y
> # echo 'nbla' > bpf_bind_accept
> # echo $?
> 0
> # cat bpf_bind_accept
> N
> 

Good point, changed

>> Examples of using argv are on lines 358 and 466 of ice_debugfs.c
>>
>> I'm open to changing it, just not sure to what
>>
>>>> +/**
>>>> + * ice_debugfs_module_read - read from 'module' file
>>>> + * @filp: the opened file
>>>> + * @buffer: where to write the data for the user to read
>>>> + * @count: the size of the user's buffer
>>>> + * @ppos: file position offset
>>>> + */
>>>> +static ssize_t ice_debugfs_module_read(struct file *filp, char __user *buffer,
>>>> +				       size_t count, loff_t *ppos)
>>>> +{
>>>> +	struct dentry *dentry = filp->f_path.dentry;
>>>> +	struct ice_pf *pf = filp->private_data;
>>>> +	int status, module;
>>>> +	char *data = NULL;
>>>> +
>>>> +	/* don't allow commands if the FW doesn't support it */
>>>> +	if (!ice_fwlog_supported(&pf->hw))
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	module = ice_find_module_by_dentry(pf, dentry);
>>>> +	if (module < 0) {
>>>> +		dev_info(ice_pf_to_dev(pf), "unknown module\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	data = vzalloc(ICE_AQ_MAX_BUF_LEN);
>>>> +	if (!data) {
>>>> +		dev_warn(ice_pf_to_dev(pf), "Unable to allocate memory for FW configuration!\n");
>>>> +		return -ENOMEM;
>>>
>>> Can we use seq_print() here? It should simplify the reading quite a bit,
>>> not sure how well it works with files that can also be written, tho.
>>>    
>>
>> I'm probably missing something here, but how do we get more simple than
>> snprintf? I have a function (ice_fwlog_print_module_cfg) that handles
>> whether the user has passed a single module ID or they want data on all
>> the modules, but it all boils down to snprintf.
> 
> You need to vzalloc() and worry about it overflowing.
> 
>> I could get rid of ice_fwlog_print_module_cfg() and replace it inline
>> with the if/else code if that would be clearer, but I'm not sure
>> seq_printf() is helpful because each file is a single quantum of
>> information (with the exception of the file that represents all the
>> modules). I created a special file to represent all the modules, but
>> maybe it's more confusing and I should get rid of it and just make the
>> users specify all of the modules in a script.
>>
>> Would that be easier? Then there is no if/else it's just a single snprintf.
> 
> The value of seq_print() here is the fact it will handle the memory
> allocation and copying to user space for you. Ignore the "seq"
> in the name.

Ah, I see your point now, thanks for the clarification. I've made this 
change to seq_printf() for printing the module info.

This brings up the question of whether I should use seq_printf() for all 
the other _read fucntions. It feels like a lot of extra code to do it 
for the other _read functions because they output so little info and we 
control the output so it seems to be overkill to use seq_printf() for 
those. What do you think?



