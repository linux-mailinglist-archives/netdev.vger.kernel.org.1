Return-Path: <netdev+bounces-24125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C8376EDD6
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71C72821CB
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D8223BEE;
	Thu,  3 Aug 2023 15:17:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6B18B0D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:17:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B5CE75
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691075829; x=1722611829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9/yvHEFbVx1QeLFl5/979+/nu9SgtEzDIz3804Y/zOc=;
  b=M2r5NHJUnOfKjPA1RYPwh0rC46zIPIH5JXb0fEJsxgd9YXkJmUgbX2zG
   A4cgvjTXHVa3bUuLvoaDJL7xYVDmcazny0eZoqKDjGvcT//Iyj7kV+lK/
   SEhuLwcNN9edCyN5TRQ56ZuFMviZC5Ezwe1QWsliB1XV9GpQZBpaBgHfz
   DjPlUOPT4/D6hW3v3ElCn5NMvvQCGdTFgusubxdeyHrN6ElSbnI6wQ66B
   ue3ZIy5tNMLR/pCJKQQD/ViTdN7es/ZIHJ64761Il9DO8GzCKcvspZHGo
   nhrX0x/tU9EXVdt3BmfVrI+st3OvsRs4iCXcv8Ogxs5sVIC6QRgLSf3zE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="436226506"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="436226506"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 08:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976104901"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="976104901"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 08:16:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 08:16:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 08:16:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 08:16:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsVR0hdg3e8h0Iv6F2Beyzt0Jzj/JTIyyLOg+6B6hxuDNgPg/I65kODYTLynZ/PhJRGO2za8sqmnrlslAAl55ooukPand04N1eo2ILs917rilwKLBuDEM4NJotFWXXDsL00SKteAzhbzlyDHjNPwnejrMKgslQuoy1BlK6Xs0K6iLZAG/k3gOPQ63YUVUNIVeaTWCi0oFGRqpnAM9Me1HE0woGggahJF9Kfhsf4kh//p8EdFVVXhBajqC877kvrs1apBRVQAlKqfL4eYtboHj9ksNuaXzRee5PlvE3EIOS0dGjYIhgM6X5KVOIrApVGqj80XTS8Sa6paCM+JFiuPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tffwaaE9Ow3PkUpQ0y8hJhyp/fiQJ/kHuJYMH8F0EAM=;
 b=ArYYpynZbvfK+oi8OrHkGEwZ8c0AFRXwgKASa2C/AKO4dxHEUhZ4evTtu4mSQJv68L7sUN68h//8ts2/DAEGuKN/5/gNUA1aevRpU8clVbMwXd8ZRHRA/vo69t8Db68H6BNAzdgg2W/R7vrq6sAbGs/UvKURssk/6/bknzbLOUjFBvEPhoLjkHX8PGJDZDBm9UE10OKRJCfj/J44lr7BzCjUImSyU9PXWF4wSovDD3ZBQpkC6FekN8uPdeF3hgSYEH6gl4lJnYUSVyT61ijjYta2aLzDoqcQR9UQ7HTqlHJt9oxhUvPIBmG4yo8T/yzPJdDuKlRH373dYCTlyMq7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB5455.namprd11.prod.outlook.com (2603:10b6:5:39b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 15:16:39 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:16:39 +0000
Message-ID: <5f9f6107-3617-dca7-0551-51fc54861298@intel.com>
Date: Thu, 3 Aug 2023 17:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] xdp: Fixing skb->pp_recycle flag in generic XDP
 handling
Content-Language: en-US
To: Liang Chen <liangchen.linux@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ilias.apalodimas@linaro.org>,
	<netdev@vger.kernel.org>
References: <20230802070454.22534-1-liangchen.linux@gmail.com>
 <222b7508-ee46-1e7d-d024-436b0373aaea@intel.com>
 <CAKhg4tJen5JQp-cpvdmdzy1RYJL_=a0bk6TYs0ud0G1rn1ebsg@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKhg4tJen5JQp-cpvdmdzy1RYJL_=a0bk6TYs0ud0G1rn1ebsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB5455:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d58445-b549-46ee-e301-08db9434a2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJUyBLjjKnggpQrjf1g9NeO65J7UI8jwAWGnFUqtk6nYSD3DqT8yss6HVXwMRZVBiQy1NeYAwFn70KPUFlpjDhZbmZCCu0ts6kpIbqF9Mt4dhcWp91tjF1Q3yS1IogVXVLQX57xOuUa7iWdxa5d1HJKduRhjnZYBRn++BTJDax0ItAUhCL/Rl7iTlcBjVi5HLEqH8UVz2t0AnmeZI00AmBz0CNsCGbsOAw+P8y7EhorSG6HJoM5AnyLyR83/08mG5N/QjF6I+HiINOqpdBC9xrnGPtvA/+M9ygy4nfxjD+sCFYxjXWKo/HkocPmAosTKDEoXaVd39FSDx01xE6qk3rGPvtck54u73cxyM1uNqcHWp4w0QmsvW1iqV7A0/Cmy+03d6pYxr9w7Se2PkWIAo/ah9iY8xHboY/Tih5HnMuso+Ttp2DzaTQCYoSjJZXo6d9+Vp51RhG5E+DKLJKOID2mroVHIJ8p578mjhuhNY8mF1wwtHGY8WKBRmLGw/u+LtfG1XzNKC79h2PdHWXr+dz6TxszwwFoFGN+7Y3fI3jj951og4QcnvWdDXvF7ewywVx93EWAHpuEaYKaPGx5mOQMTEs1tzRgFA7AFFap2YLii/mwY3L5LBy8OSGMnLUOyTFlqo6XCs1tfc3JcUsy9UyG1IkobLMrdpwAxeQCXjPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(26005)(186003)(6506007)(2616005)(7416002)(53546011)(31686004)(2906002)(36756003)(8936002)(8676002)(41300700001)(86362001)(31696002)(5660300002)(38100700002)(82960400001)(4326008)(316002)(66946007)(6916009)(66556008)(66476007)(478600001)(6486002)(6666004)(6512007)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxjOXRCOFRmR3l0eEs5SkpCczI0UkxKcGh4MlJKNXJvbDg3aFBWMnczNEtN?=
 =?utf-8?B?TFhic0E3RlFBWHVZT0J1U3hHVlFpTUxyVnlVeldoYjVlMGVRQjJScFhQK1hw?=
 =?utf-8?B?WU9udTBqTXNici91eHY2elFJK096bTJvQWtQbnl5dXZzcW83a0RIbG5tQ0g1?=
 =?utf-8?B?WkQ4ZTJoQk1LcTNycjR1a2FsWEJCNDlMV0hxNHkxY3RTRGRZeFp0cFJ6RGZ0?=
 =?utf-8?B?aTJtSTVJSlRITzVhU01XWUwzRDAzQlpaZTQ5a0NtV0kxTjJuQnRhTlBmSFZD?=
 =?utf-8?B?QTkwMVF4aDQrQk5DUW9jVE5LaWw2MWVwa3VMajNsaGlCNEt1d0xqMituVTZK?=
 =?utf-8?B?RUtKMWJmaDQvek1BRUhQeEFsVUFaWVY1R1BSbGhUd0dDUGRRWVN3ZzZkamxx?=
 =?utf-8?B?Z2c0Wmd0RVRkTWl2WW5DR092WFVoMFFSZ2IrcW1FYklzNS8zWGpyLzZOa0pH?=
 =?utf-8?B?aWVZc2ZHVUc3dHFSbG9ydDFIY3IzNkJkbVByUkJXdE00c0xVSVFwbkV1WEJ6?=
 =?utf-8?B?SWU5UFA3Y2xoQWVERWVTRFdvRlYyb050N24rVXBaL3RYVFlZbDZndTRmY2Y3?=
 =?utf-8?B?WndzN1FGWEFEMUxVK0VYSHNsTjFQcFdQaUtiVjdvWFdTa3VUbEFKSXVZRHRF?=
 =?utf-8?B?NjhER20yc1lQeFc5R1NPSDUvQzdMZjRIaFE2bU92K003bTdFbzU2TkVKeEU1?=
 =?utf-8?B?NWN4RWJoSFZ2ZHBUdWROLzJEUFMzSDI3NFVtb1FEV1AwTlVQc2liQkZmZHZp?=
 =?utf-8?B?SWRGcS94dTZveVdCWkovS3luNllENjJiUEpVRExKTVlXNkM0K01LM3NSSlI4?=
 =?utf-8?B?RkdIa1Bxd0paUEJYZ214dmRsVHVDYmpVdWhwcmN6WFZCMXEvTkd2V2cxZmwx?=
 =?utf-8?B?Y3ZjMWdmS25TS25aRFduNUY4VlFEeTRHbTNpbkZ1aVpjamlYb2prbllOU2ZC?=
 =?utf-8?B?S1k2ckhpdm5wcWl5QTB3VUl3YVNPVFVDb3Jkd0x5UWQvZjlSbmdrcDVzcVZK?=
 =?utf-8?B?QXA5TWFKMmlGbzJ3T0xEbXlkQlp4alRLT3IxL1hTblpGWVJqMDRySysrdzdj?=
 =?utf-8?B?N3dLek04MmFDWmw4b2F6OFhpRG41c3FjRFprOEJlb2phazNnN3pMVWhkYm0x?=
 =?utf-8?B?cE5wNmE4WFl5Q0tYWkttVVdvcGI3Z3h2U2NjRXJwQ2tqa0JOSXJsbTkzeFN3?=
 =?utf-8?B?QTVlenBQcGFFckoxZk1BaTlCQWw3dDdIU3dwSTVZNWRwbW5Lb1hBcTR3V2VL?=
 =?utf-8?B?Y0VzSzQ1VzRwNmZvbnYyN2ZqOXhqL1VyVjJOOU50dXpzRFdHRU9pZlVmeFRh?=
 =?utf-8?B?YTViREUwY2ZxbG9YamZkNlVES0hFdDdHZmlLNVFxWkFUL3JSNlViTHc2aFFk?=
 =?utf-8?B?dlpEdkl5SWs0alBzd3BKeldCUWpiUHVPeTFRUm5hYUVzTXVBQS9XVUtDcm9h?=
 =?utf-8?B?SGc5cWxXSlNtQ2lEMlhVN1RVbUF5SmZ5aEc4c1VCRTNYRkEwampMSGc2elZ6?=
 =?utf-8?B?K0lpQUliS2MzajM0WkdnUEFWakQ0RFdLNjN3ZUNVeU9lWTNhVi9RSzFhdkxr?=
 =?utf-8?B?VXZLeWcxOFVwc09KckNvcjJHQURYa1B5M044ZWJ6SUZRWU9BaStJK2xoREhK?=
 =?utf-8?B?QXBxdjRCNmNCRlJBcVJHT25KZVlYc1htcmFJZGo1ZGQ2VHRWeXFJTURIandT?=
 =?utf-8?B?SnI5Z3FsSzlSc2NjdjQySUtmeHdiK0gzMVErNzBTSXRMSHBsMjNHRDlaend2?=
 =?utf-8?B?WDJSdGREVlJaNytKVUpGa3Rvb1Qrei80UDdoVFNxMGFZelM3VXJ6aUx4RHZD?=
 =?utf-8?B?YmRTN3V4TmZ5bVVqVndpdHpxb1c3cUNheUk4M2ZPU01Sc095d2JjMEZ4MlVI?=
 =?utf-8?B?VFMvQ0k3M0RNdzdHWm5Rd0YwZ3RmNEFXc0RPd09hTytSV1NPa1hNTFA3WU0z?=
 =?utf-8?B?cTlqaURVdWtIQTYzdGdBMjRsOXZMdTk5QVY0YWwxUUpCU3BlYnQydjMyQmov?=
 =?utf-8?B?Wi9JRWhRb2VxMnkxZUFYMGI5cTF1aU81N0xsSHgzblRkTTRiNDZIcGdxNStP?=
 =?utf-8?B?VFVkdzlHKy9lVkxwaFBoeXR6TGQ2UDQxRVRiR29QcEhVditBTjN5VW16dTJp?=
 =?utf-8?B?SDZhZHU1T0l5Ymk2eXZCelhiWS9jb0c4NDBoTjVOMGV3T3BteVNNUXJWTW1W?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d58445-b549-46ee-e301-08db9434a2dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:16:39.7063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/rWRyt22EnTriYy2sYderEK9mPHaCmTOI/KUsAqkx4wr4OAx3duHz+hQOxJwFUrKI1VRRibwyQY1akSzqkWwGegUnuI4OR63qMelwFV2is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5455
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 3 Aug 2023 16:25:49 +0800

> On Thu, Aug 3, 2023 at 1:11 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Liang Chen <liangchen.linux@gmail.com>
>> Date: Wed,  2 Aug 2023 15:04:54 +0800
>>
>>> In the generic XDP processing flow, if an skb with a page pool page
>>> (skb->pp_recycle == 1) fails to meet XDP packet requirements, it will
>>> undergo head expansion and linearization of fragment data. As a result,
>>> skb->head points to a reallocated buffer without any fragments. At this
>>> point, the skb will not contain any page pool pages. However, the
>>> skb->pp_recycle flag is still set to 1, which is inconsistent with the
>>> actual situation. Although it doesn't seem to cause much real harm at the
>>
>> This means it must be handled in the function which replaces the head,
>> i.e. pskb_expand_head(). Your change only suppresses one symptom of the
>> issue.
>>
> 
> I attempted to do so. But after pskb_expand_head, there may still be
> skb frags with pp pages left. It is after skb_linearize those frags
> are removed.

Ah, right.
Then you need to handle that in __pskb_pull_tail(). Check at the end of
the function whether the skb still has any frags, and if not, clear
skb->pp_recycle.

The most correct fix would be to do that in both pskb_expand_head() and
__pskb_pull_tail(): iterate over the frags and check if any page still
belongs to a page_pool. Then page_pool_return_skb_page() wouldn't hit
false-branch after the skb was re-layout.

[...]

Thanks,
Olek

