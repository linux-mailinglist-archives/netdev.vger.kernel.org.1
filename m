Return-Path: <netdev+bounces-28856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF86781058
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708C92823F3
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FBB19BCA;
	Fri, 18 Aug 2023 16:29:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CCA198BD
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:29:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F623C0A
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692376154; x=1723912154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AMcTtBVCCpmL62GbbR0/AP5gsC3ecM91G1D+iEVb52k=;
  b=AKEd1VoAqZkRvo1L921HU4VTLvMYdsAQzjyD+ARugILsbj4MFSv8r4/d
   TnBlNUh6UEpP4JqqGblRysKmbC0HaOBWnFBZuCdQn3Xyl4u8J209QmLew
   3EfHyDu+pRckS/TyFSoss1INhmQEdZp68Ew0x4wE9ylPLH/0XMtNfSU4s
   Uap8gPuUZhUSVC4c1Qkq7YxK6qKZexo/XXfTVomf5hi3N7BTtmXbVB2sU
   6Z+PUqYfxGFKEc9JR79qztmaXD6ubwpAhURXDfK1R716Q5IY9nqFlQ3cA
   jLHXQHFK5y2f5DAdjWBltYS1cpojQ15zOJ9bBe5XP0DJyBYQR596/yzNc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="375915598"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="375915598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 09:29:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="908936925"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="908936925"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 18 Aug 2023 09:29:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 09:29:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 09:29:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 09:29:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU2Bxtzr9dTTDUIRG5zUlS8TOzuBVliVDgDCAtANGLShtmZoZRlwrTNnkVGIGuXyEYYtokpiYnwiyziDh2Adk/zxEPgEwBl8/AcJP4ZFUiH1q2j77zx0RV/CEtvRHdo8xigBE8SPBgm74vI2Wqku4K8y2GqQAocOqSULBJPspsmGQ6H8ssL+xid8EQL2duf74qPJrfFLvXJctxjDDA0a/nq4BpTL3+NfBwlguhQjFWuUZYBmSxxparLmZkoz3nXHOR17UIgVo43523Cl7dE1GUxk2coaq3imBN87W7pQw00zCpfDDDMkBxaU+xu080hGf8z+Fazi7lKjCnq9vU3zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR4Np2pj7JJCDXIDSGbPc3x2QO5hSjidBccxT+UPRaA=;
 b=d13CAOmqLaSmy3TnfR5jYpDIB2jADZJJe3+i98D7/2IEc/mPzQQjh0rv2LXwb2mLlyM/WlTjJpDIT49QGExPya2tqTGesV+Ep/sL+zZFN89nbgX9SI/aPPUrzJZA3H9e0zTNgqphHlcSNg5NkH8EySVkaICENZ1nqh0PLTXdjwvDdTQNgfumJh36H7Qs83fdcy/f68o1GxqcKsHEAreLJ3it2yWH5upFrN2NT/TMUhE8zYod3ISu3U2gMVR1ZrZJzvGVEgKXz6/CdLsGrmoLr1JtKy1S7+f7xNrZKt1dOPSdhPk7rZYygWf2oY6z4DKtJjQVZKycxaMtTRx0RQUlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by IA0PR11MB8302.namprd11.prod.outlook.com (2603:10b6:208:482::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 16:29:10 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::7349:947:dc4c:fc8d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::7349:947:dc4c:fc8d%4]) with mapi id 15.20.6678.029; Fri, 18 Aug 2023
 16:29:10 +0000
Message-ID: <22cd24d2-6f15-560f-1a5f-f78054d05f40@intel.com>
Date: Fri, 18 Aug 2023 09:29:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-next 2/7] ice: Refactor finding advertised link speed
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Pawel
 Chmielewski" <pawel.chmielewski@intel.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>
References: <20230816235719.1120726-1-paul.greenwalt@intel.com>
 <20230816235719.1120726-3-paul.greenwalt@intel.com>
 <240678ed-221f-4893-a410-140c9f4f4674@lunn.ch>
From: "Greenwalt, Paul" <paul.greenwalt@intel.com>
In-Reply-To: <240678ed-221f-4893-a410-140c9f4f4674@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:303:2a::8) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5140:EE_|IA0PR11MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 09611c12-2f2d-48d7-86c0-08dba0084085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FwQxB0s5bbqVrVC1tDATx/TQsTIdkju5Yl5RBWjfd93+QKsMfKB7Mt/93saSfa2K13+heXfRArjqzBLoPWQP4xI9M/gkcxyxEi8/SBrAhDchwF8S6oCb1/koJD+6Of8wAwHmL8tp6pENnnqp97Hd0sNZ1blDZ8GKw0ArC5Wln9Qau9WXloxDmjngmMoJf9hST+LpDcRl3is55F4nOs2LHbdfvpZCGk0YqCFjVVkahFibS+f6GaikcuFXpmslJLNoa1z3eus3hm4rFLZREvU120saeX89uZZGnRPv75KWRGxJzug9NbyINzhISc8SYX8rd/+3wQ6xOQGWkuRkNLCazPdf/loEkB14nIk+MKoqU7AoZu/Bj8xBMD75dgrZrWKy/UEKfi5DiDtjiT9Tk94Y487Zpim5KWOCJL5xzO23myoCc0koeXtSEb7RBWsk0sOh0Tj6v+nRcEX0hM4IXnLLVFgRaaxR04kZr9UUPIdjtl+yuMb9Igs89XGm6guGzgkImnAXfMRBie7/90PsBs3eQd1aPZUhg8qEwVfOX3JJJ8Xw+saDf3UcERsLZwZRtS6iQGiDX1l4NPIWoYdf2spgPubq8sWXKdtII0vcwhmRv54Xyi/6iy5UmmhH2P3YsmCvB6Jz9I/QPw4o72Z0g3OIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(1800799009)(451199024)(186009)(6512007)(6506007)(53546011)(6486002)(38100700002)(31696002)(26005)(86362001)(36756003)(82960400001)(107886003)(2616005)(6916009)(41300700001)(2906002)(316002)(4744005)(66556008)(66946007)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1haenpiUFAzOElNWlZ2a04vU0c0T3VVRllOREdNRjFIYXFKRUVodEZPYzFv?=
 =?utf-8?B?NUkzd3c0M0YweXpsVUplSW1uQ1hrMkdUejFPWW5XalE0a0gxL2paL3lEdjYw?=
 =?utf-8?B?WnpDK1pTWEpUcGhXZlpzVFF1NytUeGZUOUkwZllZdlZNNHAxdDYvRjFiNmZv?=
 =?utf-8?B?bUJwSDdjTElNNFg0SzhZNUJkVllFcEhPcHk4aHJpd3E3SmxiZjEySHBNZEt4?=
 =?utf-8?B?UU5vblo4ck5TMGVlY1BZdWE5b1FBekp5Ukp6MFp6RWxhb2JsS250emE4aWhl?=
 =?utf-8?B?K3JTYXBaY296UnlXcWxXd1FhU09XMkNMZWQreFZFOVdrK1c5YVhGamswUnBD?=
 =?utf-8?B?VnN4WGRWQnNXcjJhQXJQV1RlQ3dYWXJqVWlrTnVkMC91d3poZG85dlZPWTFD?=
 =?utf-8?B?V3NvK01QWEIzSmFXcDhlOFRKTnU0NEFTQy9zT3AvbTB2cEN5b2cxUmo3Sm5s?=
 =?utf-8?B?T1B0Q2k2QnBtWThlVzN0K0taQ0xNQzh1ejhCTUxmTUIzY0QrUTBLUjR5c255?=
 =?utf-8?B?Skp0RWN4Q1NadkVvU0NlMEdra2pELzBGMUozNW1vejBwbFBCaU9lTTZHTVRv?=
 =?utf-8?B?aTM2ZXZiYWpPK3R3S05CRmpnNnpIUEZSVk1QLzRiNFN6SzQ2YzdESDNTUU5k?=
 =?utf-8?B?cnFsRUhSenhtVHZoSlhIRmFwZUZUcGY1b3RUNlJGb2QvTXFEQ09CV0RVeHRD?=
 =?utf-8?B?cy9RRmRqcUJLWm4xZnJXM0l5TTlMZzJ4cCtBdEVYcGgrTklPKzdiN1QvaVhR?=
 =?utf-8?B?cDZsaHF1ZkN3VWs4eTJsUE9zeFlzQlRrSXFYR05zQjRYRkRJR01SY2d4UWgv?=
 =?utf-8?B?TGJld1Y5Y1dvN0NRQ0VRMWcwMGkyTW9WNWFXSlBtZUdYR0J1Y0QrSnQ2VER5?=
 =?utf-8?B?TVMwNG1ldmhZWmh5aC9acVBaRHN3cG9pSEtxa3JRVkhnR2lqYmk5b0lzUXBz?=
 =?utf-8?B?MzdvdENJZWdYb2VaZmoxMjlFN05Da1FjRGNNaUVtUVVtNGhuTDVPc1hyUFpY?=
 =?utf-8?B?dDNiYlZ1Z05mSHZtSEU1a3Y0c1pDSHd6N05JaTdMbXhQOHYxZWdNc3VDUity?=
 =?utf-8?B?NmI4bUo2NDdFS3Z3U0ZWaXpXdWNsSG9wTzZJeUxiTWFTME5sZ3Y5NUlLRlVI?=
 =?utf-8?B?UmF2Kzk0OHZjbk1IaDBYRTNuWC8rdHFVYzlUYTA3bnR2dUttdVBQMzRka3N2?=
 =?utf-8?B?dFpFbTFuWDJxZ1loVzlnR2dEUlF5ejVDQWZCU3BmZVpmUFNXbU5weDNKaFky?=
 =?utf-8?B?QkpUU1piSUxFUGEvRHNkaGk3enZxNGp5ODVMejRlNXFLRkszU1lEWkI1c2I4?=
 =?utf-8?B?WlNpdGlDeDU3dkNOSkVDNGpBN1I4MXlqYmpJWUh0MENoS2ZDVHp5VVNNRnVz?=
 =?utf-8?B?bVk3MFlNV0d2bkN2Yms3QnJpdGgxRHVnN1hCb1lmUTJHcnlnUkdieWQxbjd6?=
 =?utf-8?B?UXJvRXFwdzdXQ2VRNFhwOVY0T0NxNnZmOFlKaUEyL0FLNjdZYkJTUUNtbjM1?=
 =?utf-8?B?OXRzVUxyUExvNFJzdXM3ZUUyaUpreWNIWTRJZEdpMjdLd1dhWG5HdVpubVlN?=
 =?utf-8?B?NDJBK2IvQXpDRXk2NGRWTm9BMDl6YzJ2Nk5kdjZ6eElYS04yamZkaFFOalZY?=
 =?utf-8?B?SklLdlBGbURzWTJHbmRpNWZmWlpTS0ozQ3FMRGFreUZENVhzWDhJRy90WWJT?=
 =?utf-8?B?cHJKNmJycWZqTGs5TjhhWWRQMUtyVTVsVlhQTkhWbjVwVGc1c1ZpZHl0Sml2?=
 =?utf-8?B?cHdRek1XT3RWMWdudHdLditMWmNyS0FON0Vra3BGZkJ2L3FmbW5XYTN1Um5l?=
 =?utf-8?B?ck9iNDFzMWxVYjJzVmNkNVdQUHdQcHJSVW9FV2V3TTZXOFRVWG5XZTVBWUJK?=
 =?utf-8?B?STNxWXk1eDg3M0s3ZE9lYXRsVDNHVFlPb2lwSXN2cEtOczYwai9CV1o2NlRq?=
 =?utf-8?B?SVJQL0FVTFhLcm1kc2JoRTNkWERFQndubEZLRG91Qkk3dko3ZG12QWppOGR6?=
 =?utf-8?B?SDQrV2g5OEV3WnNpdjhIN1NTSFh1K1dKdC9ETUZQL1ZPaFdLVml6dk5CeGJO?=
 =?utf-8?B?ZEtRSldaRHZVaXJkaEZaS0pCMnUycy9Ed24wd0YwZnpSZDhzRWN4Y0F0TTJx?=
 =?utf-8?B?RzZtZnZCcWVoRERXMDJ0U2twbmhWekU1aE1BN0hhd3dMNUJxTjd5VGNOcjBD?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09611c12-2f2d-48d7-86c0-08dba0084085
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:29:10.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofIRErC8SujOCaay1MVU3rm+eGShdC+qfLIHRg7yQA19IEknzIU+78EOIOEUXRR9X0mFq3C8+nbhauhVmBtNxTGqzEwXL72P7A433Rj8dfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8302
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for the good idea Andrew, and I'm working on a solution.

On 8/16/2023 6:00 PM, Andrew Lunn wrote:
> On Wed, Aug 16, 2023 at 04:57:14PM -0700, Paul Greenwalt wrote:
>> From: Pawel Chmielewski <pawel.chmielewski@intel.com>
>>
>> Refactor ice_get_link_ksettings by using lightweight static link mode
>> maps, populated at module init. This is an efficient solution introduced
>> in commit 1d4e4ecccb11 ("qede: populate supported link modes maps on
>> module init") for qede driver
> 
> Could this actually be partially shared with that driver? Some are
> identical. Maybe a generic implementation in net/ethtool/ ?
> 
> 	   Andrew

