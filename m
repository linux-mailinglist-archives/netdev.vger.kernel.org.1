Return-Path: <netdev+bounces-18649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4765D758337
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BDA2811C3
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F74111B8;
	Tue, 18 Jul 2023 17:05:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76840C8CD
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:05:56 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922631BDD
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689699931; x=1721235931;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7/ebXjsXDTkMDT9igRrci3dlWriTDT6fkT6MiaegUUk=;
  b=iYZjOSyiHfok+n96sDPFTxkZrVzRlxX9gXJqZMCpu2mW43e/yjPTSucq
   l541SKwsJeEUwjUr6xeutHgDG/vYUFczKz3I0KWhqheoDULtU/1YgxqAX
   ZIj4FdP/oooPhQBmfXfmt+QzIKPMZqROjVLvn7H37pznlvtVNqd8cRDBB
   9yez4sqYg0VqmqCROIyUotdD0RnNv6eTpkYCiff89QWobe3gf7aIg4Jqc
   zPQBGjLZeE7srMSvOYevD0VPpV6FbTQ5WmjQ/6q0167VoUpa3gfdXdIJD
   4V3AtsYZsr1H86LtkNxQWaSF+NnH9wDWYYlOYwAz8A6tCOvyLtpbDftF8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="430024174"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="430024174"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="717674174"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="717674174"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 18 Jul 2023 10:04:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:04:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:04:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 10:04:15 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 10:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bsk5xNvaPGCz04GyMOjipGNXzwEYZj55aZ9p2s66fbkPydE8GAsEv5ex51WCTAFhZrL2CFNUOXNHf12/z8fr/CKTu9h3Npq178IkPfCgs+R3sZg8LT0b9D+xWgbFTi5iQy3lN2Xwj0SIF3nnC3gK2P5VQmMuG2hcLO2BCFYVavoWN4m2sqSswxTkpmSaxSkDakKfRExv3p9KVezwtVhg+7+lMOMXDPMiU54SAQmbGM2Y4OMqkMrkZE5F9hvfl/K5sZLHMcdMkhuMYurDyuY6vKf8nYJ3c2D3hfMdQsosjt3I9K8w/7lkv4aPcxdkA/sxpK9lPLBZPB0eqaNk9Lj1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy3GVz0StWkHdrZfHYOYjl8ax7NgFphDxFv1++3h4QE=;
 b=CDjtCCXbwDgYvrBNxtdaA3GUFYNzxaZopQlQA5tgWSELSbUMS8+6ss3DNeO4mB8CZ5bbDdrBLsztnSuDZ1bS2FoHDKVW9QZstq5VV4xj8n8yEnDl65W9e/ZUNJvf/59hRjxaRG2KBzf9T0tSzhbeFIfGRQhyYWI7qh3ICEpgRvOu0hsR5RENm4pVUKKNgLpOLW2PonDQ1RN5ASz0BUEtyQVzHf7Z6TM0lokn1Jg4nBSo59jZg4Mq3X0BI/+Doir4maULTBOQnniA7BPomMZuETXyayWEkWiyoDwuHevlAChz5v3KP3t5qyU0dliAWZzVr0M7OCMlEMEoAi/Qdma7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 17:04:13 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 17:04:13 +0000
Message-ID: <7d6ab3a7-4039-a1bf-9d63-f94d1f886bc8@intel.com>
Date: Tue, 18 Jul 2023 10:04:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v2 0/2][pull request] Intel Wired LAN Driver
 Updates 2023-07-14 (i40e)
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, ivecera <ivecera@redhat.com>
References: <20230714201253.1717957-1-anthony.l.nguyen@intel.com>
 <8261532fc0923d3cd9a8937e66c2e8c7e2e1d3b2.camel@redhat.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <8261532fc0923d3cd9a8937e66c2e8c7e2e1d3b2.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|CH0PR11MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7df378-7370-493a-49bb-08db87b102cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wtw7bFvEO53bOnMO7xAdeXuNv60BY2zru+DG8oDgYvie8V2USs26I0dexmZCWhajA1OjLVMeNcSU3eFcea/c4vOJFcWb8M6vWCJbXwadPsF79W9HNQHctweUegLYIlw3JXmEFBQ18SLGCFhiA3riCdKA0KvmroqyZ/VWglQ57YJAG2Tlwy//VDNgQVvu4YR/IjXaAmBt7LUZmbzigMwULMQDWftENR7KmcQKjCZHX5pixFSVlWI/7eD5yXRVmC9aAuyfu4Ys6LOpc7NAcnZgpnuNSMM7XSsC2bqt1WII/nGN4zquuQENLij64lEHoPb0e+9w7/FEVFIKzhfpY2nd/W1JdXlo+X68T0qF8BE8fa8UbPl0JWzehXml9zqESYuwPIeSiiko3q6HhK4FpXYppRLGgDLIzgkKpofwBTUVY5OWjYzloyhEdTfYR2RLB04TVUQQWceZDJbD0sbCF3fGGLtYsdupKTI+Z5gIq7hNpZDXYRhCMsDxEiikh+rj8TkXX78c2nJJZBLEjs1UrvKnmZPqZnTdANtRrPsAtapIRCjDwNAao8YR/oJOx6/qSMqBJeeVSoAYBIJAsOusJNVSREioWMwg+iUgX6LIyeZkQnXZSFJu/8TpyI+6SLUXL9UYaojXA7/qyNbZVstUkIi/Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(41300700001)(15650500001)(110136005)(478600001)(2906002)(8936002)(8676002)(31686004)(5660300002)(66476007)(66946007)(66556008)(6666004)(316002)(966005)(6512007)(26005)(6506007)(6486002)(53546011)(186003)(38100700002)(82960400001)(83380400001)(2616005)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVaZ2Njakd0OGxia2lvNFJkdDNpNXZreEhKZDRKWGRkL0hFRU9UMGh1NHdT?=
 =?utf-8?B?Zms4N28rbFdtVTF4NHJrMzloVWhUYTJjWmgrekovdElZbytZQ28vMjIwbFkr?=
 =?utf-8?B?M0sxcUUyblF5aGlKc3MxdVBLeC9KWWszQVRhaEl3VzRIMzZQKzVtU0kzcXhl?=
 =?utf-8?B?bHF6WEVhV3U3MUdaYmhuWTVuY1FoRmVuL043NlZYZ2ZqNyt4R1dkTEVxb2wv?=
 =?utf-8?B?MUg5OVFLdXZ0RTUzckZ0a3hEZUJaUTc3OVFaMnhHTWl1WStzWUIzK2VWRmdy?=
 =?utf-8?B?S0xwTTJUNGxHUktkQ081Rml6V0RpTWg4UkhsUGVEMWt6QlVVb3kvZnlaLzJN?=
 =?utf-8?B?OTUxRlZ2Nm9TaEh6M3NxZ2xrcXg2eDRvL1BKTjZldkhKQkRmVnZ6VXJaUEZh?=
 =?utf-8?B?c2U5VW0vQStMWW5Zd0pIbTRQZVk4OUxOelJiRGMvT29YVkVLU1FNaEVqL3FB?=
 =?utf-8?B?SXQydVJGeStHZ1pqVlFUc3NCczc1S3ZXSGVrMFJKN05LZHhDQjZNdjY0N0NW?=
 =?utf-8?B?cDJjU1doMDk3VGdRajNqUTAybnNSUjcwa1ZBREFqQmFFZFdTTmZNQUZEWFVa?=
 =?utf-8?B?K0t4WTRac3FTSjlJMGFkR0F4T29ic0dEY3FOOVlPbzJ1a0Z6T1RNWmZpQ3Rr?=
 =?utf-8?B?SGlSSVpvKzQ4dEVvK1lKcG5qUk1TZk5PdkxsejBVUHNoU3czZG1MbmVQV01j?=
 =?utf-8?B?dlVtWTlQWjF6V0IzWVdJMWIvWVJseDgzOVMvSkpMZVNrVGYzNnErd3J4S3BY?=
 =?utf-8?B?SnNJT0ViaXgxSFVGZk9xVHpqdTd4RVUxRDFvb2FJM1J5RFdETHJSdEtaM2tp?=
 =?utf-8?B?SVFhaHFOSkkxaVZ2SWQyQ0tQY2hEWTBzUml2MXRFcHptTkhJOGxXSllTTUpa?=
 =?utf-8?B?MmgzcjJrbmYyeUhjd2FEVU9QS2h5T3lEZnF1RWtDd1Zad2NIWG9pZjRyQy9G?=
 =?utf-8?B?U043SmNGL2hpMlg1elBVaXdHdzVOYTlnOXVPWmx3TXNIN3JVVFY0SWU0NkVo?=
 =?utf-8?B?WEMxd29GazFFR1cvdjYyZWl0Nk1Jb0JSSjNqdjBmY0djb0NpWHpNRnZPWnhv?=
 =?utf-8?B?RjdWQnVOWXY3czRkb2RPbkJJaUJ0cktTWVNKOWRWNHJIZTNSSlFDSWkvS2pT?=
 =?utf-8?B?MTI2M0xRbzdwN29jNExESUtnZE0rTDRvSm4wM3VwVTZLUnF1RGs4TFBCTFg3?=
 =?utf-8?B?TW5qTlF6U05Xd0dqL0NVeVhtRFNsRHhMbktKWkJBdHRjYjVLVW51dzBYY3Bn?=
 =?utf-8?B?QVExN2JZM3c0R3BGa3RiUjR6ODNZUUZqMjF4SjNaR2s1N3QrOHVrYzRBQlgw?=
 =?utf-8?B?ZndFdFpSV0d6aHFGQUNpbHRhejlGVHpsUkl1ZndPLzAwUmVwWlo2aGlVMmVv?=
 =?utf-8?B?UG9tNElJaTV6TWpKeHV0bFlEemVEWG1xK3hPSDdYRy9aMG9jUUZDKzR3RjI4?=
 =?utf-8?B?aFlLalR6UFk0Wk9JVGF6Ky84V051QWxZTTlhblA5dkl3K0ZqWnJmbE5OVjFj?=
 =?utf-8?B?Z0FUNllXSDQzcjVPSG15Z1FZdUprVXFDTlQ0Zms5S3UxdCswOXhHVXBCeUtl?=
 =?utf-8?B?OG1TeldWWWc2ZkNPTktXZEVyV3RDQ1EwOHFsNlhGcXkvM0hDMm0wOGY1OWI1?=
 =?utf-8?B?czlqTVVSZFR1bndxaFpzV2V0UjNPeTF4bGM1YkVyOXVnSzVXSzNvNVJxUnpN?=
 =?utf-8?B?VG0rYk8zTm9iSkhGSmJxeThwdWdvMC9wZ2pmZUZQbkhjRmlWR3RMdDFCMzRi?=
 =?utf-8?B?UVZ3TlM4Z3F3R2gzVEVORThhak1VV2FGSnphQndYVi9DSVNZNXZnc0JHOEhE?=
 =?utf-8?B?NHFJb0dkcVNFVk9NLzNCL2dRYVlmQTcwazgrSWVrbk5waDVENTZnaWRqaDZ5?=
 =?utf-8?B?VnZGeWFlcE42Nmt1cnhkRzBrZVJsU0hwdW1nYWVmZ1NDWE9rT0lTb3VlQVBM?=
 =?utf-8?B?QUxicTJqN0p3a2JlZG1ObzRTWG83WXJ5NVJ3d01RTTVIMlNaYXY1bFgreUFw?=
 =?utf-8?B?a3VVdzh3Qk9GbG56V3FGU1g4eTh1SmkrQS91NVVyZ1Nsb01QTGc4SjhUTU9R?=
 =?utf-8?B?TlpuOS9wNjZwYUZGTklqS1VSSzI0dVVVcXYzK0NiSTlaTjhVYzIyNEtaVjdz?=
 =?utf-8?B?TnpxQ0F1V01Db0tPOWJiOVRYKzBNZW50MERNdGx4bmJTcGY2cEh3MDREeXRE?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7df378-7370-493a-49bb-08db87b102cd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 17:04:13.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYRB17QL545FgU3nbWGe22DWv8xHffXBHSmJ87zpGfUVsVBsWd3FTzVYFBorT9st7besoGDFvJpNaytFnCx8KfU/2+V7dFPpX14nyvtmJaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/18/2023 3:14 AM, Paolo Abeni wrote:
> Hi,
> 
> On Fri, 2023-07-14 at 13:12 -0700, Tony Nguyen wrote:
>> This series contains updates to i40e driver only.
>>
>> Ivan Vecera adds waiting for VF to complete initialization on VF related
>> configuration callbacks.
>>
>> The following are changes since commit 68af900072c157c0cdce0256968edd15067e1e5a:
>>    gve: trivial spell fix Recive to Receive
>> and are available in the git repository at:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE
>>
>> Ivan Vecera (2):
>>    i40e: Add helper for VF inited state check with timeout
>>    i40e: Wait for pending VF reset in VF set callbacks
>>
>>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 65 +++++++++++--------
>>   1 file changed, 38 insertions(+), 27 deletions(-)
>>
> The series LGTM, but is targeting net-next while it looks like -net
> material to me (except for the missing Fixes tag ;). Am I missing
> something? Could you please clarify?

This was sent to me with -next as the target [1] so I was following that 
intention. Ivan is there a reason you wanted next over net?

Thanks,
Tony

[1] 
https://lore.kernel.org/intel-wired-lan/20230613121610.137654-1-ivecera@redhat.com/#t

> Thanks!
> 
> Paolo
> 

