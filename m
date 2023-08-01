Return-Path: <netdev+bounces-23349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B176BAF3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78313281B00
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0BF21D4E;
	Tue,  1 Aug 2023 17:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375312CA5
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:17:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F491716
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690910268; x=1722446268;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ux9st9WOFYfxc5xnDnfTlfZU8k5psJY2ekgFoRWh0J8=;
  b=F04YdIDRbyk9oIAcjfL+fMCRYxb0uZuo5RR0p2HpazCKzrvj/2p9j+qO
   zOc+UCirMjhMcVURSC22Bu+Kn8bkc3L6TCxPIfn8IVcJxJMbqs9LR2srC
   VJEh98OMSPicvhqHXm6+KOc4Uu560x3geoGKVBW4f2Bc2KYx9nr2Eur7u
   xA5oo5rbzSppD9CvuqU0C0NL3ffDnAKV3UjAynpAvMg/Of7EDTSiNquNi
   B6yn7ZQtj/wxsqF2VT+9oUAwy9gorS15qI5XDEG62M4E2xCzkZnwIqrXq
   RP+G+po+ijqowYW6AKMyLvCz4gv8+SxBbpOzZxLeZwzmpIwhz1iu/gmcE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359407041"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="359407041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="842808072"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="842808072"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2023 10:17:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 10:17:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 10:17:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 10:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsIG6AmEsVMjZMxfASbnelcQquRXcUp+RbOQltA+XwAvwPCmAXwpVZ0ZScVBnUw9dOO9Qex8MoCFCpG755t6ITCOiKQd/axGMX0Yu9LluQv25IKZPsNlaqOmat42hIENtORP+UwsOOVgOZr21oB4ksSqY2bUOmoVMnD80bVYVgvxY1vKOagzE++vkOr/ggWI1Ziy6ANxQa0tyLBT/ptos088gBbvFsKVs52LMKpSu7mqsZEj4arbJL3VygR3F9syp7CL1/Ah0CnoCyyuH+3jOOUxTtqhhCN9Te7n/l0YDP+qd3DXUSm9YROHr/vb67s7IHe/JmHtcuTbF1MD2N5FuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbAMr1KlVBcY3xejFqEp1ZQIPuo/S9EggkGif5hsi94=;
 b=U5oYHWoIEK6bPyxYpDd0ieX0ci3G8xEcBSM5hhxRK5KRz2ulBCRdgWoI4lecVLi7btW3t7/EunoMMRln1uKp+PO2Iq8jsopi03DBrnQirAGGj8YZd+w14HuH4PGtOsK/SwZLvWPRZIwYJzu5nr6fNnk6JIVhS1TKIa9IYVydmJYJKtWvxzUZaUfFenU/gIvD8+xDHHaw4tfnMYmy79b33UX9Gn0jLJHeaMTiwqw3zgUIWiJ1tQIVVyV4bOZBeY3U/6zcstgFDJG0hmqRXX9EsIzuk/3UHDTeETHk4kB8rnFudTH5Molk4Y9Xt9ThNTcSjbrLicrNukbpIOoy6oiBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MW5PR11MB5906.namprd11.prod.outlook.com (2603:10b6:303:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 17:17:03 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:17:03 +0000
Message-ID: <7a83e627-6e03-c447-77f8-1020973fa4a9@intel.com>
Date: Tue, 1 Aug 2023 19:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next 1/2] overflow: add DECLARE_FLEX() for on-stack
 allocs
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Kees Cook <keescook@chromium.org>, Jacob Keller
	<jacob.e.keller@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
 <20230801111923.118268-2-przemyslaw.kitszel@intel.com>
 <d4d5324c-8d4b-b2e1-78c8-5c3015b5c03d@intel.com>
 <47815c47-b8dc-6d37-b869-0fba22e3a71b@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <47815c47-b8dc-6d37-b869-0fba22e3a71b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MW5PR11MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 22940389-d22e-4bb1-58f1-08db92b31fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GuuB+UUKCG6pNMK7xyaC2lQtV8Bpbd1+orM1zRI8qWiHuVZSyUoQ/45rUMV/t6Fa+7ISMLTkUApWZzS9EoDSKBsEhBVWXYFSuISwYzWwE2Xn9PybEDecCtDQc2ehbpqbXshrJXeZQmDiwQRnVze9dQru1qtmetaVBVDJMGQ4bsxCnk77Snz+wnjCnr8Cx0Jt8xLyb2TAe3g0XtSeaXtOz+9wCM+0eYZknxCbAHz0vzOJNDewHndNaH6+kLT0UAzy6VYKSOycwBPU0EgqKGYzJFTmSFNL5O19/IStQhTu7+IUvrlKT3Hj/9yI/Csaor/d+v4LvTBcYilVXHkQuw0aNtMWUn6Uu2IO6RLN4X9NAxQvju7Rs6NSC9iewPCgdgixAKFD4D8lr5Ksd/QjrAnWBiKN8i+1W/0oEyjtJRyXB0dMyGEMkO2oSCFEUBN0n+Yf6LMuxU9QaxIgW4cu9inffxEWrY8Rx7rIqNl0FS0jkw4XiAtoiC1A+4Sg77CWlyOmPFmBFrDLaHo1VBBaqSWGm+B0ZzyJ7ZKE5n9jEs+zl8zxfDgLneQCi5+61SPvXTpl968ytdSTqyUFdLG2ItXFywyf3RbR7X9UHD04yiFN9fS+7Q6s9pX/dR/R8Rnanr8m2pUchkKGcfJkC+Y4bLOV9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(26005)(6506007)(83380400001)(186003)(66946007)(66556008)(54906003)(37006003)(82960400001)(41300700001)(86362001)(38100700002)(31696002)(66476007)(6636002)(4326008)(5660300002)(8676002)(8936002)(6862004)(316002)(31686004)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhCRWlWeFphQ3Bvem5DS0RuSVpWNjNEekVZT0duU00rUkNTQWlacFl6ODBD?=
 =?utf-8?B?UzNMTnBXM25YYXM0blFlTDJ1RXFxdHVlc2E4L2pGS21MU3pFdEpDRGlTK1Vt?=
 =?utf-8?B?UklzSkhON3VrbUFtbWNXc2ZpVnVlNDhKblVDekR5RG4wOEFKZ1FPcjRLKzNV?=
 =?utf-8?B?dXpScmZTK3hmQ1pveiszdENOQVArakpnZHFWRDNPNlprMWpoaWIxcU8xemxt?=
 =?utf-8?B?KzFDSVZaL2hGSG1EaDYxaFpNVEtyRkFmckxqejhtV2FqRFFGeW96Vlh2NnVI?=
 =?utf-8?B?UmY1TEZGYklCZCs0K0FFNlZDVWFxQ2NHMVhHcC9hOTVoNExqa3hhTVFVZjJ6?=
 =?utf-8?B?d3MzWERINUdEWlkyTWE2b3B6MGFiUjJHcW1JZVZrZ0RiVE9GZTFtVHJWQnRp?=
 =?utf-8?B?NkhQV092M0FvWHVOTlh1SzFPSVFaN3lWM2paUGZRaHVBa1RhcjlrUm1ORlFn?=
 =?utf-8?B?VHk4REM4eFJ5NEx4MFdzOU9MMkJHaklHUXh1aE5FNTRlTFJBTFltekpXQy9P?=
 =?utf-8?B?L0d1aWYzcVZ6cEdSWEUxTFBvZFZmL2xKMk02M0N0VTNLNTF6UE1EVkQzOG9r?=
 =?utf-8?B?TjJPTFVzZURYdGhLSkc2enBNb3BwdnBxZjMvbWUvSlREa1JXSFFIVEZncE9i?=
 =?utf-8?B?YzdPV0dZQ1hCZGFRUFpHQXRIY3hsNjQza2NFTmZyQVZVNGNUUS9IVE1EWUNJ?=
 =?utf-8?B?emFJZCtTOGNWMXBVaWF5RlpFN01Qc244S3I4c2RwMTZBOGNBV2grci85RWlN?=
 =?utf-8?B?WlNlZGJWL0MxV3hqUXMzRURoZklSVW5ENVhuWm9qRlR4cFJzZjVra3I2Tkwv?=
 =?utf-8?B?LzlvbzZIRG54c09HODllM3RqUEMrUkdTdHJWTjRXaXVZTXdWaGgxc0IzbW5v?=
 =?utf-8?B?TnRvVTJxZTFRNkVReXlxY2dzTkwwM1VybWJmWEpESEdybU1WaGVQTnNVcXJN?=
 =?utf-8?B?bVBoaFlHTFBhUkVIdDltODNjeUZlTGZYOU1ONE1yMEMxZi91a2NHS3duRW4r?=
 =?utf-8?B?QlBDVjVSb3RJSWJUS3hHb29KL204WndjdVAvMVVUTUZxaFBsd21LSFZrKysx?=
 =?utf-8?B?d3hSblhtdS9uV2g5UzVZVHB2cTVhQkN5LzZhWTl6Y3IrUUNQNUg0Q0cvTUdp?=
 =?utf-8?B?WktQVEpjN2pWdzdhcXRMS3VhM0s3TmxPNWFJMXh5c0hIQ3o3ekJCTnZvTURC?=
 =?utf-8?B?aXNwcjZoYlZFYmtKcFBkMXhiTCtJYzI1R2tVRTlYRHJ5ZGxHdGVHYWF4cVl5?=
 =?utf-8?B?TlF5aHQxQWFzNjgwM1FWWVYvTDdiTWJHQ1dKTHA0Z2huRmV3NW5mTnNtUDN6?=
 =?utf-8?B?aHEzZE5QQ2RkNENyV1pmZ3o3RmJtRmR1SDFrcGYzTENUUEwxTWFQbUVpSDNC?=
 =?utf-8?B?anFtaDRzMkxGdkZvYllYUzE1Wk5Ea3hzWEErOUhiV2t4QlFiZkwzVjZkZklU?=
 =?utf-8?B?Q1BVSnprQjN0bDJ0T0pvOWZHRGdEUHdYNDUrU1NpQ2ZlSk9KUEJUcHlQNDQz?=
 =?utf-8?B?WWQzb3BmdlhMT0MwY2VzLzk3Kzl6NVY2NEc1M1VaSWsrbjdrcGp1NjI5dGdz?=
 =?utf-8?B?dGtHYVh0Y1l0UW0vN0FudURJZUhrUGdOdjhnZjhBOXNPT0VVaFBkWkJhbmdG?=
 =?utf-8?B?b0s5ankwUVE5ZDlmUm5XcDViZm1qUDg1eEZZam5lYng3b2NSWHB5WS9CUy91?=
 =?utf-8?B?SUg0UEkra04yVTAwM1FlTlVaSnNwSlArcUpoRHgvVXBZOUF1R28zK1IzcWRv?=
 =?utf-8?B?czJqNU8rVFZWRTh4WXQwenZJVHNWRnZLL3VKU2t0ckxaVms2SVNmNmZNQ3pI?=
 =?utf-8?B?NG5yUlhLSmFaOENHNlcxTUZENFF4L2U4djBFZ2FDaVdMTzdhZlU5UEJVS3VK?=
 =?utf-8?B?aFNhV0p3NXhxZ1BKRmNlQ3gwRXVsanA0V1EvUllqOVpXcnBuNkpqQzlZN3ZG?=
 =?utf-8?B?cno2dGs4akJBQXhsSlJiTmE1ODEzcXBYRDZUZ0NONUo4T0xVdlpoQUVtZEgy?=
 =?utf-8?B?NWlDbXBtNDlFYjBNUmZtWk9MWlh0cUNYMzJOcjM0WlBPSHIxbElOVG1sOXlJ?=
 =?utf-8?B?bFpyV3k4U3BCMHgyUkNWampHUnF2cHRZU3dBU1BmaHNzK1RRR3o4ZlVsVjE3?=
 =?utf-8?B?MFZCSmFiY0t5aDlHZEVuc0ZneWZjam0yQWpaYzF6djZ3bm9sSElnbTMydmh5?=
 =?utf-8?Q?IXCkRlXJSNROWr8Udx2ylNU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22940389-d22e-4bb1-58f1-08db92b31fb2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 17:17:03.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLG/Gkqtfbc5/7iHs8KJDy7Smy9PNZEMjj3HXaG9tUOL8581e6RxrKqHuTuF2p083UQDTIqgdZx/9GD04zDDebxIQOEn9YvQ/SMZULWfuDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5906
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Tue, 1 Aug 2023 16:18:44 +0200

> On 8/1/23 15:54, Alexander Lobakin wrote:
>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Date: Tue, 1 Aug 2023 13:19:22 +0200
>>
>>> Add DECLARE_FLEX() macro for on-stack allocations of structs with
>>> flexible array member.
>>>
>>> Using underlying array for on-stack storage lets us to declare known
>>> on compile-time structures without kzalloc().
>>>
>>> Actual usage for ice driver is in next patch of the series.
>>>
>>> Note that "struct" kw and "*" char is moved to the caller, to both:
>>> have shorter macro name, and have more natural type specification
>>> in the driver code (IOW not hiding an actual type of var).
>>>
>>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> ---
>>>   include/linux/overflow.h | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>>> index f9b60313eaea..403b7ec120a2 100644
>>> --- a/include/linux/overflow.h
>>> +++ b/include/linux/overflow.h
>>> @@ -309,4 +309,18 @@ static inline size_t __must_check
>>> size_sub(size_t minuend, size_t subtrahend)
>>>   #define struct_size_t(type, member, count)                    \
>>>       struct_size((type *)NULL, member, count)
>>>   +/**
>>> + * DECLARE_FLEX() - Declare an on-stack instance of structure with
>>> trailing
>>> + * flexible array.
>>> + * @type: Pointer to structure type, including "struct" keyword and
>>> "*" char.
>>> + * @name: Name for a (pointer) variable to create.
>>> + * @member: Name of the array member.
>>> + * @count: Number of elements in the array; must be compile-time const.
>>> + *
>>> + * Declare an instance of structure *@type with trailing flexible
>>> array.
>>> + */
>>> +#define DECLARE_FLEX(type, name, member, count)                    \
>>> +    u8 name##_buf[struct_size((type)NULL, member, count)]
>>> __aligned(8) = {};\
>>
>> 1. You can use struct_size_t() instead of open-coding it.
> 
> with ptr param, not feasible, but otherwise, of course will do it (see

struct_size_t(typeof(*(type)NULL), member, count)

Jokin :D

> below)
> 
>> 2. Maybe use alignof(type) instead of 8? Some structures have larger
>>     alignment requirements.
> 
> Sure, thanks!
> 
>>
>>> +    type name = (type)&name##_buf
>>
>> In general, I still think DECLARE_FLEX(struct foo) is better than
>> DECLARE_FLEX(struct foo *).
> 
> I have started with that version, and that would prevent your question
> no. 1 :) So there is additional advantage to that.
> 
>> Looking at container_of(), struct_size_t()
>> etc., they all take `type`, not `type *`, so even from the consistency
>> perspective your solution is not optimal to me.
> 
> The two you have mentioned are "getter" macros. Random two from me, that
> actually declare something are:
> 
> #define DEVICE_ATTR_RW(_name) \
>     struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
> 
> #define DECLARE_BITMAP(name, bits) \
>     unsigned long name[BITS_TO_LONGS(bits)]
> 
> Even if they don't take @type param, they declare variable of some
> non-pointer type.
> 
> Both variants have some logic that supports them, and some disadvantages:
> ptr-arg: user declares sth as ptr, but it takes "a lot" of space
> just-type-arg: user declares foo, but it's "*foo" actually, so "foo.bar"
> does not work.

Same as DECLARE_BITMAP() actually: it always declares an array, so that
it's then __set_bit(FOO, bitmap), not __set_bit(FOO, &bitmap).

One more argument for "just-type": yes, the name you pass to the macro
is exported as a pointer, but you occupy the size of the type (plus tail
elements), not a pointer, on the stack.

> 
> I have no strong opinion here, so will just switch to pure-type param.
> 
>> Thanks,
>> Olek
> 

Thanks,
Olek

