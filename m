Return-Path: <netdev+bounces-12796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89EF738F9E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546222815FE
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215A19E45;
	Wed, 21 Jun 2023 19:06:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26661846D
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:06:29 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5CB1BCB
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687374377; x=1718910377;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tHMtiFb+WJiKpbe9ynbmMT/k/ZM9Tm8ervZ5eInJCQE=;
  b=eorGimx+vrIer9y4VqA7DL7A2mUb6UYNOm0unvPSGs8m+TFsGauNJ8XI
   z85KxONhmm8zTxxY8Ub2vQ/tzQ49Rv2i3fD7Pb/GyJhHXBVo8Ik278DYa
   22l4RJPZRP6uRhmyGOB9Vm4hv6fmFcr4cljzPf12AXhaBKdJv+zcagv/3
   o8PlFiXtACwzcrt0efIEwdeorqdqZf4W2JZ/dzc8+v7OamaUp7NYFtok3
   Px7WYLzckXaUCA3AbmZ69l8VopzG5Lup+C2nUQFx0iLUX8SS61VrDblYf
   JyUtT1+B88LChPDzg1uvoco+HFut7X9eMt8Yp6KktlQJe3j/q2JgrpRWk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357772393"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="357772393"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 12:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="1044847534"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="1044847534"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2023 12:06:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 12:06:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 12:06:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 12:06:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE/FoGQL89dsrrTzx6SrCeT5tSt+ZUzuJVbxpZLvY88QICApJlYPpbsuCFY6zq3p21wer6mpWiMqYS1SSIBO2UZ2w4TA8cdbmcUwtiOuRuGvCjgI1et/0HuIyWRtfqnrNWLml+XGiHoD71BX3MX0o0PifrJKoWGQsAhTQxq/hYeEteZeSp0tqYIREHUn9PLc1ej1Y5fpH1NVL1KIv8IZJFqwe8s30EEy1PoYhQ/sKucDTPsB9LHIvqjTMS+jEX3AQE6l+TwOLKoLi8PobYfFqS8Y6mdM91JO+x+MkbYnrmpfjm+KMgJTYQuzmJ3LFgoUghv6cFZhl2G4WP8Tjnd6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohvBk0jZRnEBnT9NVV+AADjeLhwMKGqHk1NkAH7HZi8=;
 b=BRFrRvjt+uHOPaNqZKylEz2c++xg9WwI9dAo/1iyTk+oas1hhyETXeT8BFuKzTEyEXNflI+lTDq2QH495fZ8f9TG1CQqkNXLmRhGxLxkoaZYhgb1T++jpuVIYIODD2shzPb6hsf/hkZe9m1lGozT3jmcjUTFPujRKFw4VvBpzfVBkHkU3LA4GpE+m9Lds3qylMVEfiE4jSOviGFux8VfAxqAnbTj2z/QUEHWFc43A2b404Sai3JFwETIlegGDB/MOJFvFlb/0R2UZ5zgmYq0EIpLlqQQCBCQCVpP83Zu5wswhfxYYeW2SZwkI2nnMMEL9Joa6W4DxnKax0IbezaIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20)
 by DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 19:05:58 +0000
Received: from BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::ab9d:1251:6349:37ce]) by BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::ab9d:1251:6349:37ce%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 19:05:58 +0000
Message-ID: <0b6fa05f-d357-2942-d17b-d24d8a5a3321@intel.com>
Date: Wed, 21 Jun 2023 12:05:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Subject: Re: [PATCH net-next v2 03/15] idpf: add controlq init and reset
 checks
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Joshua Hay <joshua.a.hay@intel.com>,
	<emil.s.tantilov@intel.com>, <jesse.brandeburg@intel.com>,
	<sridhar.samudrala@intel.com>, <shiraz.saleem@intel.com>,
	<sindhu.devale@intel.com>, <willemb@google.com>, <decot@google.com>,
	<andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>, Alan Brady <alan.brady@intel.com>, "Madhu
 Chittim" <madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>,
	Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>
References: <20230614171428.1504179-1-anthony.l.nguyen@intel.com>
 <20230614171428.1504179-4-anthony.l.nguyen@intel.com>
 <20230616234218.58760587@kernel.org>
Content-Language: en-US
In-Reply-To: <20230616234218.58760587@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:303:8e::31) To BYAPR11MB2599.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_|DS0PR11MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c19de9-37ab-4bf0-8e98-08db728a8bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9gCSB3IF+uqusOGd5+YmYCUMtVCP4YvA2AnX8G/pnVzj/RAY59TWE6UF5l75sUd7tRdgNH5dfdAZKe2+GH6iLu4J8kad1n2aMYeK/gCbWRi/mX7BqVh5wjooypBCfwmcJMPlBlHo9CfPhWzWZSyg8GUjaRNFanykYszDOpzueXLCPJsFPZ5zv5JPszFIGqQkfaGhQ1sYQMmMhL5at/Y2Mr4xPZug3XpvtXjD/Ns2ktGSITI9bbLaNeiZmvX4/5yhc3u7RLwGna6IKmLJMPj0i7+PvW+q4/lluRbdk3OhApWIT1Mxi8AP256ZWhR2l9zuIyPIimO+3nyJLp8KgIQ1jc2b/VXa7o85zRIOe/siwc6Jil6u41/N4v+2vM06og1I8Rsh1Dt2FxwGHUcMS5cdST8tLxwOJteIjDGikr5C+e/kJUNNPyHLciwEAYknT/8nT925oskAP/DEwiLJz3zcE3gyat0xPZ5vM+shnoOQpmlbC8RWEXUu0LToq9UoM2qcoqxLeeA2Uqvyt6aH3LLnQqbr39vHEGy+7ePhu+r+V9VyNzBF8h52OjDIAT0VVKmpX5kHtFRnx68zgpz+OYqIJ5CZRNp0+L9uHw9FowTtkIO9zdWSpuQAszvqZyL6dni1LdGVx7DNxZSafsQAEiDvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(31686004)(36756003)(66476007)(5660300002)(7416002)(41300700001)(38100700002)(8936002)(66556008)(86362001)(8676002)(4326008)(6636002)(316002)(82960400001)(31696002)(66946007)(6486002)(107886003)(26005)(6512007)(2616005)(6506007)(53546011)(186003)(2906002)(6666004)(478600001)(110136005)(83380400001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny8rdEhMVW1CZUlVZkJTMWZJVSsycGgxQnBqSldHS29QZXFEQ1hBMk44eVFF?=
 =?utf-8?B?anNraDFqaG5XK0tCcFZyV1U3K0xVYVNvbmQ4aXd4bUxMeWdEOVdFYVNlMUE0?=
 =?utf-8?B?WmkzOEt3VFArdEJsUG9JTlh1TTk4ZEttd0lmUklIeGs3MThvZXBMMzc1NjRF?=
 =?utf-8?B?SzlXKzlncWsyTlZzdGt6VS9YRDBuN0F6NDZrb2JEcHQwN3JuR01kN1JxTnNn?=
 =?utf-8?B?U3dwU1htdEJiVVN3VVRFeU84eGpsam9zSWtzWmpZOTFVMkVXMmZWZXI0NWl0?=
 =?utf-8?B?NWlmMzlaZVFuSHZpWS9hMytub2xNUjV2dElTaVYyS1JCcTU0MFIza252WTNu?=
 =?utf-8?B?ZzZHL0tZQkdrd1Q0NDkrNVM5djJacVRsWlJFRjZPT3dqQlhBd0JtU1pxb2lZ?=
 =?utf-8?B?a1dQY3ZTcmZXNk5ObjIvbVNVOHlKWlNiWFhaTk0xWnJubVFNdXJVWWI1enRi?=
 =?utf-8?B?Qms1dzNkVG16OUZ1OUFNakxvU053QldRRUlTemlIeURKclE1YWhZT2FwK0Rr?=
 =?utf-8?B?azljOXdSa21lWFY2UjNicE9mY005aThxNVlBV2ZucHBFc0JxdXdNYW5sa3Nr?=
 =?utf-8?B?QVQwOG9VOW9NMEsyTmIrWkhvZGZJckxLQ3doeE1hbzgyaVdxcmRtY0g4K3ZV?=
 =?utf-8?B?TU1pcWdNT1Z6RWN3WXpiTkI2aVZydXJSZlVPL1Y2UFJqOGMvNDFsdHNYR21j?=
 =?utf-8?B?ZEdoVUhpL3BwT1VncmIvTi8rVzBNcDBUOXBuTTdVbVZ0Z3NtRTJYbUZoTVpj?=
 =?utf-8?B?S3VHemJKcXc4a012NmlsM3BvSDBGRms0MWdlRXBTdUQycUJmenRCNGRVR0Vt?=
 =?utf-8?B?Q05RODREV2V2WU5nRFJ2dDFDbCtOQ1hneVQ2YWcwU3pGc0kwaWFjWCs5YnRG?=
 =?utf-8?B?OEVMRHNRWUFHQVhWM1NjQVR5L3hQTk8xV3BwMkwvOUloT2xBMmd4R3ZTak1w?=
 =?utf-8?B?dzBrenRzTE5WSys5by9mVWFEeUMzaWRuNGFPRmNhT3NDSm4xRlFzUGt5R3la?=
 =?utf-8?B?bGhPMktlbG40VnVYcWRTRG9FWVRsQnRsenJVNkdpa1IveW1KbWI4Sy9vRGpt?=
 =?utf-8?B?RkE3MGE2RzB2OXIzVTBlTnYvWXRTQ2RIWCsyZFFzQkpYb2pRdjQ1OTNITG04?=
 =?utf-8?B?TmhwQ25iUjB2N3A5a2U3ZlVPbWp2MTB1Yk1mdkNBcWFTNXlnNi85WGlwRC96?=
 =?utf-8?B?Sk1yK0FHOVpXb0FGdE5DdUQ1SWFsMkpqeG1yZkdXVzVONHJ1dUhGMkFpTUQ5?=
 =?utf-8?B?TDdwVjNwTm4vRVc3Q2VlL0pQZW42VDdkZGpqZ0NlWmFrcDNRS3ZrNzRzZzZj?=
 =?utf-8?B?b0FvWEx3S2VJRWpjcklFdkhRd2pTSFpwWE40dGhHdDlwV3ZtbXhBdGFpa0c3?=
 =?utf-8?B?UTBpemNBNEV6L2ZzM0V4SGlFQXRXUDgwOGNxZFNodVFzV1dEQlYvbDVkSnVR?=
 =?utf-8?B?S0pqbktUNTFaOERDOUFjNWJySGZVMVhkcGtNUFRhSTdYd1pwMWk5bHBvbEJI?=
 =?utf-8?B?Rmo5bkhaNnhjZ1ZrcGNtOFF3bE9nWmR2QXZOd1NCR0oyaW5VUXE2NFRqUEg5?=
 =?utf-8?B?L0RFTHo5WTNaek95WUFPd2xwZVkzUm5vbGU5VHg1eE9yQkg0SlkwZUM1cDFw?=
 =?utf-8?B?UG9HaGZBNmtrTmJadk5tdVdSNERZOWNyckNhWWM2ODZqbVd3R2J6NW9xNEpN?=
 =?utf-8?B?VTRLYWkzWW50dXVRa0pFWlhEeSs2UG5qMisrZCtpUDdzUXJUanBEdEFKWWlx?=
 =?utf-8?B?TElLYnlJWTV0UG4vemNOQTNLMlFMRUtPNmhETlA0d1o0QnVQaVV2STB4OXE2?=
 =?utf-8?B?d0wvdFpkTWE0VGU0L0p2aVNIVEVnd0NYT3NTQ0Q1cEZ2S2Z2Z3dFZUsxYlIx?=
 =?utf-8?B?YWk4V2YyaFp0S29IMXd5eGxEdmhlbnNvQ2hsMTRzYXgwM3ordDNhNG85SU80?=
 =?utf-8?B?Ky9hUUczaGdzdXNTMHpld3ZUdjM3TWVEZ3lNSnU0Mll0cUFKSklNUVFWRXJT?=
 =?utf-8?B?SUtqaGFzODh0blRMckZIc1BjZjJuMWhwdVlCVitVNjdIbVVTQkcwSUhNRm5a?=
 =?utf-8?B?QlZQT01jbG5ZYkZ3TlFDY3lIQlFabkErVTJMejVUN2ZOaXJQTUUraDdRQVdU?=
 =?utf-8?B?UUV6bElZZ1VzeVVMSU1hMFBNWmhPczNoYm02S1dGTWhTbDdXd0JESjZwQVdu?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c19de9-37ab-4bf0-8e98-08db728a8bdc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:05:58.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuHo/IUogDXtpT0Npw4e8ebLQHL+H7M25/nB81gMmdvWAOMVc8gxTAqbyKaNzGI2Sd0mQTp5C14E2lN/Xv9WQWlp9xZqm05wQJmKXYAKjuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8205
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/16/2023 11:42 PM, Jakub Kicinski wrote:
> On Wed, 14 Jun 2023 10:14:16 -0700 Tony Nguyen wrote:
>> +static void idpf_ctlq_init_rxq_bufs(struct idpf_ctlq_info *cq)
>> +{
>> +	int i = 0;
>> +
>> +	for (i = 0; i < cq->ring_size; i++) {
> 
> no need to init i twice
> 

Will fix it.

>> +	if (!qinfo->len || !qinfo->buf_size ||
>> +	    qinfo->len > IDPF_CTLQ_MAX_RING_SIZE ||
>> +	    qinfo->buf_size > IDPF_CTLQ_MAX_BUF_LEN)
>> +		return -EINVAL;
> 
> Looks like defensive programming, it's generally discouraged in
> the kernel.
> 

Thanks for the suggestion, will fix it.

>> +init_free_q:
>> +	kfree(cq);
>> +	cq = NULL;
> 
> no need to clear local variables
> 

Will fix it.

>> +	return err;
>> +}
> 
>> +	int i = 0;
>> +
>> +	INIT_LIST_HEAD(&hw->cq_list_head);
>> +
>> +	for (i = 0; i < num_q; i++) {
> 
> init, again, please fix throughout
> 

Sure, will go through all the instances.

>> +		struct idpf_ctlq_create_info *qinfo = q_info + i;
>> +
>> +		err = idpf_ctlq_add(hw, qinfo, &cq);
>> +		if (err)
>> +			goto init_destroy_qs;
>> +	}
>> +
>> +	return err;
> 
> return 0 is more idiomatic, you can't reach it with an errno
> 
> 

Will fix it.

>> +void idpf_ctlq_deinit(struct idpf_hw *hw)
>> +{
>> +	struct idpf_ctlq_info *cq = NULL, *tmp = NULL;
> 
> You really like to init the stack :S
> 

Will fix it.

>> +	list_for_each_entry_safe(cq, tmp, &hw->cq_list_head, cq_list)
>> +		idpf_ctlq_remove(hw, cq);
>> +}
> 
>> +	if (!cq || !cq->ring_size)
>> +		return -ENOBUFS;
> 
> even worse defensive programming
> 

Will fix it.

>> +	mutex_lock(&cq->cq_lock);
>> +
>> +	/* Ensure there are enough descriptors to send all messages */
>> +	num_desc_avail = IDPF_CTLQ_DESC_UNUSED(cq);
>> +	if (num_desc_avail == 0 || num_desc_avail < num_q_msg) {
>> +		err = -ENOSPC;
>> +		goto sq_send_command_out;
> 
> name labels after what they jump to, err_unlock
> 

Will fix it.

>> +void *idpf_alloc_dma_mem(struct idpf_hw *hw, struct idpf_dma_mem *mem, u64 size)
>> +{
>> +	struct idpf_adapter *adapter = hw->back;
>> +	size_t sz = ALIGN(size, 4096);
>> +
>> +	mem->va = dma_alloc_coherent(&adapter->pdev->dev, sz,
>> +				     &mem->pa, GFP_KERNEL | __GFP_ZERO);
> 
> DMA API always zeros memory, I thought cocci warns about this
> Did you run cocci checks?
> 

I ran cocci check using the command "make -j8 
M=drivers/net/ethernet/intel/idpf/ C=1 CHECK="scripts/coccicheck" 
CONFIG_IDPF=m &>>err.log" but didn't see any hits and not sure if this 
is the right command to see the warning. Will fix it anyways.

Thanks,
Pavan

