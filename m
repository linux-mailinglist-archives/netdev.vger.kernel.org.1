Return-Path: <netdev+bounces-17302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2617511DF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDD21C21176
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA98DDCF;
	Wed, 12 Jul 2023 20:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B0DF42
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 20:37:26 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85235C0
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689194245; x=1720730245;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HX+uZBA8OSrtj+hdqvlb3oDF9xSj+R9cbdqHILr4Nu8=;
  b=bB9aaqD1U5a8wcs8a1oTy+F7klo5IMgURRUIlF29GAXqWsVfN/cb34GD
   RszW881aZO8+ikOhUS9iL8Dy2Hc9VKz4g4ROjmjDZBZypJwi5l7cinnXe
   rr1dkZgHKjTOXcVJqfrlKv1WSUV90ZA5Blf51M1Ja3t2A4BAyI6x5q8Dj
   4UyhGwM31IGhPg0us66vVPKa6oJVZONIoDtXoOW3tbSp8famZUMfybREz
   Gllx+SfGYZhGCWiLmP9LwTjZvdWiVrYuQ/O1O18tBw6q6XDk61zqn/Ir1
   tnlzki7/wsRB/CI+4RV/T7kJsv7mU0zdNzSP9+4letb380RFrpffYFVrT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="368535302"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="368535302"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 13:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="787173512"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="787173512"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2023 13:37:24 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 13:37:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 13:37:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 13:37:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY0BgfG4AE6txoNxSuqqyV6RQis4pZxfInEpyvRH79RIDOrWzUh3Zca4cYiJ6FMBL95rwArQeQE/MVCm6XzWSHmF4EAtkigmB9IIgq1t6LHZrPyudKoB+X+7uVzHc5io/laFmMPAHsj4qd+SrsouIAHBEOec8Wz5+T5KMdblE1PSMRH9dOiw/4nOqEHqAIKStTNaxPAW/BRgGmiQD2GMc068dciGAo6G28pRd0crTvsSwYNNR59nZaQE7HJ7kdd3hHuRtDkACTXlRUTJL9mCs2IKkoAVtMvIeQOStxWVWM3usAIHwafp5VhxPtO5RtGA7nB1jPlt0/b9dMerr2Z8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb2fFX45Kcbd8+kRMMAttyoX7ePsKpXYGp2Nfaj3354=;
 b=W5j0wygXmHR0XNfVnwvixliRbqw+qBME4HRL1NQlJMLq8T1RHSKVIKMvDI3kSWZXBxRbyawAKt83ut7s5EfIMKl4f8tuoPuwdMIuk4EKkX97SxVAgI+MPoFkrrEW0cqFzyNfgGJu9W6tOolMQAr2e4Mnf7DXLj7UgfEjgpviXyg0StDj8E01tldchmWe1KN1Ssw2Ki2QgsSLDg6KfP5nIB7J5M+nwThy2xxkRWixe4NSy0WZJjYHIV2LXYNWtQJSXddcB2Uf6zMhJGXviC0TiUDxFRhAQc+6FMYsVgsn32+Plghz+G42l4FJJZqOc3IQEJhz/0Hc3vqI0zQ50/LziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by DS0PR11MB7630.namprd11.prod.outlook.com (2603:10b6:8:149::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 20:37:19 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::bd89:b8fc:2a2f:d617]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::bd89:b8fc:2a2f:d617%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 20:37:18 +0000
Message-ID: <d96f53c3-7f9c-4981-5873-e3c6bdc33705@intel.com>
Date: Wed, 12 Jul 2023 13:37:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net 1/6] igc: Rename qbv_enable to taprio_offload_enable
To: Florian Kauer <florian.kauer@linutronix.de>, Jakub Kicinski
	<kuba@kernel.org>
CC: Leon Romanovsky <leon@kernel.org>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<kurt@linutronix.de>, <vinicius.gomes@intel.com>,
	<muhammad.husaini.zulkifli@intel.com>, <tee.min.tan@linux.intel.com>,
	<aravindhan.gunasekaran@intel.com>, <sasha.neftin@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-2-anthony.l.nguyen@intel.com>
 <20230711070130.GC41919@unreal>
 <51f59838-8972-73c8-e6d2-83ad56bfeab4@linutronix.de>
 <20230711073201.GJ41919@unreal>
 <275f1916-3f23-45e5-ae4d-a5d47e75e452@linutronix.de>
 <20230711175825.0b6dbbcd@kernel.org>
 <7c638163-38dc-ac9e-3d90-54a3491f3396@linutronix.de>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <7c638163-38dc-ac9e-3d90-54a3491f3396@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|DS0PR11MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb0a7b8-04f6-4650-7d37-08db8317c924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HN87iFsQLDBl/fZIzsrDLPWiGnUPTsb7v2WET1Y56mXoUQThnuhgk8RfHq1PhhF4FrdWlpCpWr4NwCDTwtlugjF1lYY9qBVkm5SMOB/7NsneLDRxdYd1Cc0f5Ne7WoztWu6B2Hw+MS+kVUtW329T6v3da2QZ0l+m0wonpfNb1UhZYmrsrajL5EpNeIHk2KOOaxJO8pjm0hUw71D+4bhQxhqCiniGlozWA3LwogQv/i37/37XdNMn31/zMtxWOUj6kOH4TvUMHrJ4GJniMP1zfuWD7ooiDkIRn2gdlV5Z0xl/+5nGT0yGCIPaXpAVV1RLpdz/407NbRctbG11ZXYFDXObWytDOfCx5S0erxoN8BP44gnPl5tHyuH3Dlx6nCp1h4qPubHrxcFKpj9oYfrEkMdY+WjKeqNGqeC1n4VTxKK8RMaxxx7KK+U02nx2Z4X8AzCheHC1fAhthIdyQHjKPwnWRjfoiAyzgPQOoDK8S63Gkw8JhkUNRNlgNRBJfhdNqNku9w2XVrumKZcHP+qqZm0GqLMDw1KpfUGkfhTwrg/j90OJqj7yTnTaKbmXoyuXGOwZuIeXmUpFFGJHg3QwrKeGYhbzqKexnOvn2gjn+uESxfrvHszdgksTcHshyuU6dxgxSuPfSAXORXgiMAQ9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(86362001)(8676002)(8936002)(5660300002)(186003)(36756003)(2906002)(2616005)(83380400001)(7416002)(26005)(53546011)(82960400001)(6666004)(6506007)(54906003)(110136005)(38100700002)(66946007)(66476007)(66556008)(966005)(6486002)(4326008)(478600001)(31686004)(316002)(41300700001)(6512007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K284d3JFa0VyRWVPMHVxVU9NWUwrT0ZzNWZ4ZFRKU1F2eEU3dy8yU0VxN08y?=
 =?utf-8?B?WkpHT0RLYXlUd0l1UVZyRUpjVkJNdjBYYWo3bUkyeWM5VWdvUXUxUkVxb1ln?=
 =?utf-8?B?eTdLOU9SQ1BFcDBWdnNlMnd5TVJGeVFaVE92Qk8xY1FTb1BteStJMk5pWU5B?=
 =?utf-8?B?TmZvUS9GWGZHaTZKS3NFU0M1K0FmZWplUm9zamRQWTdPQWNzSEt4ZlBVTTcz?=
 =?utf-8?B?OVROSDRyckNJR0FnQUtBd0xxK0VwcUpCbnlmRWxtUDFIR0JCUFRyVVMrU3Vi?=
 =?utf-8?B?QWdodjRub0MxUDNmWFpEcFZIOVR0QlJMdEhDall6dCtiOTlvYTMrYlFrQlRN?=
 =?utf-8?B?UzVDK3duL2tpazA1VGx3S1JrVHZ2cjltTUI2eW5yalBmQ3lYdU9MSFZIV3BR?=
 =?utf-8?B?aEZtTEpncmJWVWJ4dVJNMjJqVjBqbkg4ZU80cVRpeUxjRGh4TGNaTVlCdmpz?=
 =?utf-8?B?Q01LZVdFL2ErdmF1elgxR2xkUzJtb0t1NXFqcUJDNG9ySzluMnBkY0dVTUtw?=
 =?utf-8?B?RHI2L0lEZmpwMWRsMElJcWxWZVQxdVl4RVVJZDVTdmtNQzhKTkI3d0dZSWpX?=
 =?utf-8?B?VGpkK2RXWlM4UXBLbHJWNm9xRTFORXhGVHI3aDQ3SEQxTGJvZXl0dXByS0NK?=
 =?utf-8?B?aisxZHhVMUthV2hqSTBLczUzWmR3OFlFcWo3bnBlVTVRd2VsSDJ6WGNrUmcz?=
 =?utf-8?B?aStXenhOYlpsZk82OXBEMGlVT0tuTkU2clIzNmdUeStjYXBlK2YvblAwUnN1?=
 =?utf-8?B?ZEtkYlo2NHdITmsydkcyUlNsb2k0d2hnSUlua3pBR3Q5WjQ0QU9PbFRsNEJ0?=
 =?utf-8?B?enpjSFM0RHl5em1pdE1tZVZRR2MyQ1A3WXNtMFJVSFR0NHlWa04rTFYvLzRj?=
 =?utf-8?B?Vm9GdUhTNWFSc1Y4eDNENmRWSEpkYm5CL0t3dHZPakpicmlTcy9oQ21uKzBt?=
 =?utf-8?B?WmoyRllHNDBuR29PTG1pdGZvZXdGQjVzdnJtcVlZSG5rQU0yRXdMbENjUC82?=
 =?utf-8?B?WEFRRTJRVEM0WWwzSHZmQXNnV3VPTGNvK1VqZXhZN2s5bFcwQlBQWEtlVlRr?=
 =?utf-8?B?V1M2TEYraUJXWWVXZXR6ZGRhSGluTWpCS1l4WnFTdW1RbWRNaWNQbnVTMXBK?=
 =?utf-8?B?aGJCYmIvVXdQdjIyUEtUaVgrV1pERmFxVnl4NGd2VHBkTWtsT2ZTK0FrSitT?=
 =?utf-8?B?M014aEJQVXVBM01NTzhWNXp4YWJXT3pYUzh0aGFJazlDS2Zwb0xBb3k1Q0RB?=
 =?utf-8?B?MDdiRERTZWtyWVJXSjFTeDRsdkRJcU9sTVhiYmsyUmh6UExkazJVRWpCSVo4?=
 =?utf-8?B?WThkZ0t1RWswYTFRUjJvUjNjNThzQ21PSGFRSEpqRlZxYVJnU0gyQXdRQmxL?=
 =?utf-8?B?L2Qyb0dQV3lZa2dpVXl6bHp2dnovQXpHZTBvZW42YkFMWkozMmxqTVlrT0hy?=
 =?utf-8?B?cDljWVBvRUcwMVhZV0srNFNaQU1oZ0VTYWpjZ3pOcXhnMk83Z0tEVWdKQXJU?=
 =?utf-8?B?WG1SK2Y3ZDlqWUVUcDVrL1lkbGZOVGFEbG1qK051YkJ1cWk5WEdaWmdMcERx?=
 =?utf-8?B?MENPTVRwd0VkdHN2c0RCRVpWaTRrQ3AwSk5kcHF1Wi9QTzg0UHZ2MjNkVm1T?=
 =?utf-8?B?MlZOOVh6MUlqWWtzOWtQczl4NFgrRXp0MkJZbUVLT1BqdkJxcjlFU2NiU2hR?=
 =?utf-8?B?K0U2blpDQ1JzMXAvSmdrK21lUlBnNkY0T01oOTVyK2Y1VlRHSDdLd0VRd1hT?=
 =?utf-8?B?MDc5Mm93YXcwZHNjdXJqeHdmTy9QUXhlY2lpZVNldnBacmNDM2J5QWtIZWtL?=
 =?utf-8?B?M1UxbjcrK2NaaUJzdS9jc0FpcHFpSEl5dXBlWi9VSXN5NmtoQVhzQkFPNU4v?=
 =?utf-8?B?b1c3U1V2YnpMVkVBcWYyOU5EdlVQM09MTVFzS2txTldwQS9LVlNYYm00aFUw?=
 =?utf-8?B?RUJ4R3NFYVE0dEpUd3dqT2hCZENRczdsNTh3ZktHZ0FGOG5pK2NYN3Z5enhj?=
 =?utf-8?B?YmZxUDJwaVJmVGcvWG1XclQrLytVSXNOSmFPZ0JxSFNiYXBqMW9QZWxrSlZS?=
 =?utf-8?B?eVgrRVlKSXl6YmdIRmd2U3RGQUV3RHBvbDJFUzAvcWR6ZlhIb1VuejhpWmFz?=
 =?utf-8?B?YWVXeHFmMlA0cFBvMk1FajA1cDRnTWM1VGlERE1MQ21QRHZueGg2SGNnc1k4?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb0a7b8-04f6-4650-7d37-08db8317c924
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 20:37:18.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BR908LJAso/QRHCgCePSCpfqoxtYiii616Wf3DBCgEguFw4mAAVgQvfF4e7ehBREi86z8NMYK3Gzo4nZ2Byk2xc0KABVGGxywe9zoW95qEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7630
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/11/2023 11:53 PM, Florian Kauer wrote:
> Hi Jakub,
> 
> On 12.07.23 02:58, Jakub Kicinski wrote:
>> On Tue, 11 Jul 2023 09:51:34 +0200 Florian Kauer wrote:
>>>> I understand the intention, but your second patch showed that rename was
>>>> premature.
>>
>> I think it's fine. It's a rename, it can't regress anything.
>> And the separate commit message clearly describing reasoning
>> is good to have.
>>
>>> The second patch does not touch the rename in igc.h and igc_tsn.c...
>>> (and the latter is from the context probably the most relevant one)
>>> But I see what you mean. I am fine with both squashing and keeping it separate,
>>> but I have no idea how the preferred process is since this
>>> is already so far through the pipeline...
>>
>> "This is so far through the pipeline" is an argument which may elicit
>> a very negative reaction upstream :)
> 
> Sorry, I didn't mean to use that as an argument to push it through.
> It is just that since this is my first patch series (except a small
> contribution some years ago), I just honestly do not know what the
> usual practice in such a situation would be.
> 
> E.g. if I would just send a new version and if yes, which tags I would
> keep since it would just be a squash. Especially, if it needs to be
> retested. Or if Tony would directly squash it on his tree, or...

Hi Florian,

I would expect it as a new version of your submission [1]. If anything 
needs to be done/changed on the back end for an updated PR to netdev, 
I'd take care of that.

It does look like this was pulled though so any changes will need to be 
follow-on patches.

Thanks,
Tony

> I personally would have no problem with doing extra work if it improves
> the series, I just do not want to provoke unnecessary work or confusion
> for others by doing it in an unusual way.
> 
> Greetings,
> Florian

[1] 
https://lore.kernel.org/netdev/20230619100858.116286-1-florian.kauer@linutronix.de/

