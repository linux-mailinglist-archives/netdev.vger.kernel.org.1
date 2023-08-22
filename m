Return-Path: <netdev+bounces-29799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A9784BB2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 22:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F491C20B67
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B342B541;
	Tue, 22 Aug 2023 20:58:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53362018C
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 20:58:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F501BE
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692737894; x=1724273894;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K7KfYoXOy1K8HgVxBgaGmHRUEPjIPEsQjBl+iLIXWj0=;
  b=IFHorpK6aQ1/wr5MbrYLGSd9Ai4MSdPcItsAIZ10aOjQmF2ZuO+rjtOy
   zY6/vI4uCDSDLfQsBhKss3bZy0ivEZ3lFPxZQ2WcMXcPzmhTtYgmKYZXJ
   pQgdPXJzwBYzMb1naZrMVLLhHAz2z+DUc6QxGK9GyFHA8agq+8x0+onHm
   1hgWOjsXsS21UoptO1duMHDeS7UWGgBWRXWWj+yeADzj1PdccPGn1IYMI
   A52sWGlhBjbEz7l2KT1o22VI0/4xtvE+kHHVlMEbFUVxRYp/18qiDVMHg
   wkDIZZK32aQVrps73yYRLkBIkThKeTuJh3QdhCNJBv8YK2gNnX9kaWXfQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="440359184"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="440359184"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 13:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739474030"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="739474030"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2023 13:58:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 13:58:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 13:58:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 13:58:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 13:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEXKZCRM318CykT6NbT2jCsU+RZg2tE5mqROSaXLdlHO7dXGZeoJNApdhaifasHTBUFl/NiJZGkXXusoQqBBCgumPeCnumvcS8MEZhqvucIYDvmAXZdM+/9m3qHnHufxIUa5GrM98Ipl8CAfq5wp7WnVpa6fK9VjaHsywHiyY4fgvW7UAHU/2Wu2UyeuUJDPGgNjGm4oEdWZWcqHcvPThPANlkAQbT6HpMGt/Z/cwOYbm0vESrBZrgjxUkSu05ER69QU3ESKk8VmrWuB3vrewSl45ocfZWTouNBE+vz9mfKOEr+JiIuQ82CKBctVw4zarIW1R8v4icQSW24Dq2b0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZLgygshRtS4jfyKTyJQv+w6mUDk+AAIBpGF+voBejQ=;
 b=dGwTmK/KTPtmKER9lJidzTsE25CfLU3j4lDfRhoNGOHIHNpIC+dpL+EMHndvqGyClvqWyNDqc50CBC+kjLXnrJljMKN5rKp3WJnIrcOgzUOTAxnp8bm2mKC6Vy6Az07i0qIIScOVh41qXSWz4mKMTOW9eLUgsWXzAlO8Tftsa0QD9nETEsfuVPhw5o5y0s7eCaDwfTjYIQyE3w1Vwtq1DWcCBq14uHvzXfqn+Dx97AiS5xnqd1XJ4ApKS3ZSpk1BZoUWMhKzu5/LFfbJY+zH+S/JtLQ+82j6rpt+5y6/TGtY1muv4VZCR4EuyMqrXdiRpLUNKaHj26viiwq3wzNjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 20:58:10 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f%7]) with mapi id 15.20.6699.025; Tue, 22 Aug 2023
 20:58:10 +0000
Message-ID: <1c2facb4-f48b-f108-7d9e-c9ecf8ecc9d3@intel.com>
Date: Tue, 22 Aug 2023 13:58:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
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
 <CO1PR11MB5089C1ECBE60224BD7C0517FD61FA@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <CO1PR11MB5089C1ECBE60224BD7C0517FD61FA@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|PH0PR11MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: e98a48f8-ba50-41c1-0f28-08dba3527e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65WMYdOcxKIzOni6RUHPhrMFRs2dx8Dqen9M5Dp0QbHn8sulxW7nWu1v9ZmuzGvM6tx6HcCwciqYb3d3bQdf5foTGDTISAfn1XHKva78DBKXuH4hogoA+YriEJaNyQAKILtbBhobq/QSj02ZCtY5Km0guYmdYlMzu7059V+spF2XZLknSIQNO3AOM7Hu9ziESj4NBI8KwQdt+8wszGVuDapT0XOubOdmaSRf7ktaOG6YakrvK7FH+TK5Vfgcsci8XgSHIPPnb2baCCXjegQ/wamCCzaFQkQcqg+jotHHap5bdos8krHB+7HiSuqkEV/fxa+kw/S3skN8K+hvuGAncSqmmepjqqOM+HfH1xCm/6FhwjsdjZJAaybHg7LwJ5K4NsemyuS43+AI56i7twO/hMxb6F5l61Wv19NA2UIxN2nHOyzxteHG5dLPXw0YieMkXrn6nWuV1+DNb40gxzVQi0UXX14DPDW74bAgyNiplIhXcZGMoRvFCuDAYbxmTUBxu2I0aXcc1pbQ8Tf2FzxfDPdw/eg+Lxw6g3no5uI2fwmGopLjFCinf02D1tHvucTVEXCpVJZ0mUwLBtVHVahIkogDUfUJDnuGriW6upMwAKXe+zHQl8nagsGjlMEzmgHE7CHv74OFa8p6xsjGmWziAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(53546011)(6486002)(83380400001)(5660300002)(26005)(31686004)(86362001)(31696002)(8676002)(2616005)(107886003)(8936002)(4326008)(316002)(66946007)(6512007)(54906003)(66556008)(66476007)(110136005)(66899024)(82960400001)(478600001)(6666004)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm5iQnVIM0w3ODJ4RTRLQTFmOUFla2E3K1NZVFlaK2FqandSL1hsOUhXdkhx?=
 =?utf-8?B?aXpjcFJTMm1UWDljNzF3czlVbnFGOTZNNWVVSUEvdmpRd3dJZ1oxN01QRUxN?=
 =?utf-8?B?YUREZTBVU2cyQ0pGVEdRRzFVMzRXUG1xVVZwWU5OREY0d2tqTkdUcXN5UTFx?=
 =?utf-8?B?bHJFRWp1VkZNMWpETmVwSnpESW40enVlQmNWWUJGM3ZjYkl3MlFzVW1HSnk4?=
 =?utf-8?B?Skx1Szc2MVpGNjRvb2d2Y25QZ2NLbldQTURKQld5Z1pRdGFqU1B0a281VUtH?=
 =?utf-8?B?aHZmbExJa3FCOTlSN1lNVGJ5T1F0UnFLK3AxR0dKZlV5WURzNXVWNUlsNktP?=
 =?utf-8?B?OEtqZTArNG9PTG53MXp3OHBrd05hMUl1VzBudFg4djVKMzE2R1BBeGpwOFpr?=
 =?utf-8?B?SVFhQlg3QUF6L0pIUkc1cGJNN0RVcmtMcVBzUTZxZXhrRXRxWjFlcWdlVzBi?=
 =?utf-8?B?NE0ydVNnVWFYQ2xIWFJScjZ3SWpwM1piK1ZncEZneG45Z3lLZGhaN2dJVFkv?=
 =?utf-8?B?ZFF0OEdMNm5lRmYyejRqNXhQNG4rbDhFbGZYSVlDOXVIdHViM3Ivd1NlcElj?=
 =?utf-8?B?RFlYdVN1cFE2SFkxcEQ0NzN2cHRzNnV6WGNaOUtpME55Z3pYVGx2YXVlZk1y?=
 =?utf-8?B?YkxLeXRCTFZjMmhqenFHb3RzOXZIdHdPWHdVQkJoN0hGNk9nRVNIZVhJSUdn?=
 =?utf-8?B?aGpSQnlYZmZ4b1BGSm5MZi9RYjFSUUlwVWhmTHQ5V3RuVmVNQXAzeVc0OUNk?=
 =?utf-8?B?NGM3MCtoKzNkOS9IL0RqT3g4ZFFydWcyc2xwa1RjRUtlbGhOTjhuQVhPMDRw?=
 =?utf-8?B?T0YyT1Iwc243L2swaGVaandTUHlPWVZwYm5PQVYvanB1eGU0ZElRZjJiY1VQ?=
 =?utf-8?B?bWM2UGo0bVpGQWZzZ2U4b3NpR1dDK3VteDZCWlh4dHpHRW9SQldHOHRiY2NJ?=
 =?utf-8?B?cGY2THBpMFRsUk1OMWt6TkdNMWlNaFIwT0FYV0NGOGNuTk54RXNUZkVyQVZn?=
 =?utf-8?B?MDhCcm5waU9IMmQxYmdtMHJ0d01uSlg0QjR3VWRVZjlOVmJoVE1TcDJLSk4w?=
 =?utf-8?B?djNZU3NiOGJzcUE2bU9RUGluWktzdFArVHI0UEw1YzZ2dTVpbzhjVytlbzl2?=
 =?utf-8?B?SG1pN0loaUVoRWUzNDlHRFM2dForRUZSb0xLN0lxc3l4Q1M3eUo0WDN6T200?=
 =?utf-8?B?aW5SRE81eG5FSzJLZjFHRWNMaDJ6bEJxMFpWUi9JZTRtbDAwMndHOEt0QUFB?=
 =?utf-8?B?eUI5ZTBmSEJReDZnV0ozWmN5UjM3NVpkSFBydEx4YVFtSzhaTEJyOFl6Wkg0?=
 =?utf-8?B?SjdZbnhvcTRWK2htcjY0RmtvYW4rWlpaTkJ5RXpnaUd6ejh2RFhLUFdRQ0tC?=
 =?utf-8?B?K0hKK0xPank1RHFpMXdaRm1XR3MzMWR4ellSODU1YTZqWGowVmNuT2orYWRK?=
 =?utf-8?B?NmV3NHNuRHhhUnZtaUQzbXZjQ21aUkFjalRvWmpHd3NxN3RsbElOaHgzUytz?=
 =?utf-8?B?TjRkV3dvNFZybEMwMU5sQzJ3NUhYNjNPUkpXY0J5VUhXY09XSDArMEdicUVm?=
 =?utf-8?B?MExETHQ5VCt6YUJrNlhGRjczTlNtWHVneDVCekJ4ZEk2RldZVmphVWp5R3dw?=
 =?utf-8?B?cndvY0RaTEttUWpGeDUvdzRTVVJHa0pKZnZqSk1Gb3ZuVnp4NkpzQ3UySFIv?=
 =?utf-8?B?bVhHTVZ4Wi94T3piSTF2SENWdUZjTjlNeUxpZDQxK1llUE9hNUNFWmpjbytG?=
 =?utf-8?B?NkhxVkwxZTZxMHkrWHE2SGVMcFhqR0NTY2lGc0s3QTlkMGY0V1RmTEVMejhF?=
 =?utf-8?B?NDhXRThVUWxjaERETjl2MGQ0SG1LaWEzVUpmQS8zb21KUUlveXJoNTYrSjE0?=
 =?utf-8?B?d2doVmtGUDBWdmRDV0Vob3h0b1FJblZIZUU4VXRNN2M0T21Hd1dGNjFEcXVV?=
 =?utf-8?B?R2N6OEpYUGpaUzc1YWVyWmhCM24wWGZDZUg4OXpEWThXOHh2RlQrdWpaK3NN?=
 =?utf-8?B?Y1pVWjJRNzBjV3pNcTcrTEk0Q0pCa2F3VUxKVnVrL3pnaE5UQ2QzUks2dVJL?=
 =?utf-8?B?enRBb0RTV1BYb2VCS1J1TklsMWxMVFdHUmhYbjVNMGxJMEluSWRKMzRsOWNT?=
 =?utf-8?B?RmNOUks3MGFYZVIvTHZ2ZXpHL0kyNFVsR201WnQwNFNhSGs3aTRIUENoL0lz?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e98a48f8-ba50-41c1-0f28-08dba3527e6a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 20:58:10.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06wWbyB/NTfrmkq7JcAXlsLM8/zDDjOT34KcATQoekC+6/dMlgcpbHiKYDUnU13w9nq5nTmKlayJsYcw5nA781umW1V4TjeIV0Y8zo8Fgow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/2023 1:44 PM, Keller, Jacob E wrote:
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
> These stubs are for functions we have in ice_debugfs.o?

All of the subs except for 1 (which could be moved) are in ice_debugfs.o

> Is there an ice_debugfs.h? We should implement stubs for those functions there so we don't have to check CONFIG_DEBUG_FS.

There isn't an ice_debugfs.h, but moving the stubs there would have the 
same issue correct? You would have to wrap them with CONFIG_DEBUG_FS no 
matter where they are, right?

> Or, if they don’t' really belong there move them into another file that isn't stripped out with CONFIG_DEBUG_FS=n.
> 
> 
>   


