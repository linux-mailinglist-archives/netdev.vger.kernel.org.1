Return-Path: <netdev+bounces-29801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D807784BE7
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 23:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88ECE1C20AD7
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0083134CC9;
	Tue, 22 Aug 2023 21:16:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12782018C
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 21:16:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9A4CD5
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692739015; x=1724275015;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cy54ixTYNEPOOp5srfDXOX5kccwyut5fQzA5fYBGYQU=;
  b=DoeGkisaH7oYlSjaJPZRPoKVZFqe9VGk0yGvtjFySb/gvn/0qjP+EVYy
   yjNFcpR7TVyN4oGdo0/t/tU5prdDCd4WLJDZa1lTcoJSdwhJkzRFIr1Pk
   qVPCrv5+NESz6EUg/BRBnZJ+Lp44vxBGkkFxYf8cDkTIi6dzwHYOJAY6l
   S09xTEeTC/ogXdBTie4QSQ4TtFodGRhtgwAz0CEn3d8VyKNg6Bh+iQD+I
   JAoXvXbOktxMMFz3t55jfCxR/Zqt1sBVgeMGv19YBiN7JGSxwxHnNdTwR
   WGmA+9eZfHehCXUyLXBbGU5g+JJA9Lodi1C6Ahv0i477YpE2l0f64g/96
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358986514"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="358986514"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 14:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="910229706"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="910229706"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2023 14:16:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 14:16:47 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 14:16:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 14:16:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 14:16:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/cmWZ9nXojb4q3EHPL2vpp7zledABA3Xk85XGsxWfUITWPwBJRm4IZVLSzxMfTHBn8QXaoJ8skaGRh/6iDC0MsK3cTBIPoLIpZghuMGxFlhNrUkXs7R8SdXx/X6q7qlQbb9qbhcG3I1lhYZOoVYbFowW0q4GbAd5+b6YccHnuC/jSv14GXU5vDPGPlyPSZZsQV0Y8U0/1Am34ws9SSkZ21SS355YIuzGRAo74PrTZzeabv6KNqOgLSNb70w+LadCmeSex4bW4XIRrEGbha8LNHYtdgcK+XdTWHn7pWMVKWUkwkRiEoXf81ODATdNQqIXh4pdxoidk4djeL51/X0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOFfP38cREn3WRi3N5iMS+apLmayS2WYgcn71ZgsqSE=;
 b=THMpk8Mi/ZslVU7B60SGKEDqEAiUSM/h+jS39pDs99CrFWw7t/sTp9a9E7bM7mgFXbBz3NidamkzibI67YiOKUH5kM98eU0UdF2OifDdJ3147oHX3c5phTCEDNPOUsrmOtdJOUnqNWyxfRPRZ5VEFAGpR92xpaXOQI0CaIq8i9sdkuYDT4bCe2OeOOOOebqq7nNJl7GF0BgB4S0n2TdIW+gcjIAK91T3m1T8Yrb6oP6jtdxzuKVUDrppcogWDZKisDlzoMvQi1XHBtVgEej0ZDlkXkgVItTj8Hfly/L2wpt9kAJl9MJBdFVGbu0Kpwlno0qTDvxYSMc/OE/Qzhmswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by PH7PR11MB8549.namprd11.prod.outlook.com (2603:10b6:510:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 21:16:43 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f%7]) with mapi id 15.20.6699.025; Tue, 22 Aug 2023
 21:16:42 +0000
Message-ID: <4b1a9613-5f64-948d-8611-5e41758ca0cd@intel.com>
Date: Tue, 22 Aug 2023 14:16:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
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
 <1c2facb4-f48b-f108-7d9e-c9ecf8ecc9d3@intel.com>
Content-Language: en-US
In-Reply-To: <1c2facb4-f48b-f108-7d9e-c9ecf8ecc9d3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::18) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|PH7PR11MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e16bab-aeff-402e-8007-08dba355153c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsgnDmHvPg88rH5be3u+Z5QH1HwlD5oFryK89aN8rfCZe6dUAZpeMpn4q5C9M3UoY9GZYOzIpK+GPNAj2IGBfoDk0Bx/h9EKxL/hJqHFIB0z+6WBoCrREdAIX8rNXmoEkIxJNskrt6lNHWoJHVEuBHOaDUYisFcU7iiILRmnX41uSDwPFohyiEyk4kf1RRI8FuEc4Z3xqpMiqafzgDMPgmIlxNyUYM/R/Xr9HyonOvqNKebHnszS1QCXJo6PhkGyciOFYjwAK0Nu6tKEM2HSvlSqz+bQmfEuMI7cVENLWou4EFadwWzAx5r1Qfh7zKJg5VA3k17v+oXlFL1dBF5c4p8SXuq0RmkQH0wwidDvvje5x8+1Vdk9frJJG7He2nXH5W4FPR2hPeRXIFbZreF4ffK6+NnlfLdxXqLNORA9SCJKgT/wFAEDyen3aKwj0hH6sidtp12vDZS5HSYW2JqYcNYUyghVO2fBmVTB+96meVZYsM48wpZIZv64kTcZjMuWFF9ulcJx1pinpl1JFbrlw8PYPtI9L9Allb8CRibnm/FiLqjrg5MexOUoqcDci+KWrvScpZxYsjvM8dps5C+4KKaV1qt3921TyyByyuHizTNYXuvkRcrjWvZwkbnjVnQhCwkwbxMjvYgWAiHkdznUwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(186009)(1800799009)(451199024)(66556008)(54906003)(66899024)(66946007)(66476007)(6512007)(316002)(110136005)(8936002)(8676002)(2616005)(107886003)(4326008)(82960400001)(41300700001)(478600001)(36756003)(6666004)(6486002)(38100700002)(53546011)(6506007)(2906002)(83380400001)(86362001)(31696002)(31686004)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxHTlIzVytQNkVkc3F6REpLSE9XM2dCeGo1VTA1Y1Q0UEx6b0ZaR1I1aEVH?=
 =?utf-8?B?OGVFZlJyWXovRVhiMzR4dnk2bGZSRkRaU1JFdFBxdkVTYnJkZVQvMGJkVnk3?=
 =?utf-8?B?a3Yrb0NIV05saDVmc0U4TEFMOXp5Yk9VV2toT3FKVzhHRFc1eGVHbSs5NHlW?=
 =?utf-8?B?TEs0bkFSaEtyRW5HWTIvOEpneHlOZU9WMi83QWUvWFlxZVIwajBkTnp5YjJh?=
 =?utf-8?B?OEdiOS9ZNmhITjhiWlpTR3hnd1FYejlrWVJ6eFdOdTM4Z2p3TGMxODh1ZUxC?=
 =?utf-8?B?OEZ0NWlUakZydklXeWFDNU1mYWdlcGljejAvbHRPMDFtakRBYjltT2FTQ1Jm?=
 =?utf-8?B?bnp6TnVTb01ydzArVDJHODZsMFY5NEZrOGFEZHRsV29hK0FPTWRnSW5hb21P?=
 =?utf-8?B?NmNGeXM5b2F4SXF3NXBrb285MUthQ1FyTDhoNmR5WEJwSEVsaGVpaW1rTDMw?=
 =?utf-8?B?Y0phSXJXTW9vQzVyTCtGQkdIUENMMmNISHVXcjZQbGNjZTN0cEtTM1RqUXNH?=
 =?utf-8?B?Wnk4MWgyS09pSXlaMW5yd2l1LzZoKy9kOVpZSERJR0UxYXBobWpvTVhUZVIx?=
 =?utf-8?B?aTZPdGVVY3FYSjhraDdFcC8yMXgrL21TZ3J2dTdrbmpUUTdZNlBlRVQydmVE?=
 =?utf-8?B?cmhzWm53UU12UlcxL2hqVG5KSWxFUUdVd04vclZhb25WMjNhYkZxVUc1UFRo?=
 =?utf-8?B?WkNhT2ZBcWpVdlZ5SWJnRWd4SGhCcGFnUEVaL3RLVmdvTWlIUlliY1E2dVcv?=
 =?utf-8?B?czRpVnkwMFErRTY5Mk9LbUNuWHcrUWZmSHFCS0M2QWZIRVcyUVNwVjc2b2Rs?=
 =?utf-8?B?YmRMc2lRSG9YNkU2Q1A0bzJKQ1JlZ25jRzJsb1pjUW1JRSs3bEh0QUZvZHpE?=
 =?utf-8?B?TjhkUmNZamRTeHRHOG5iWHJacCtBd0ZCRjdJemRTbEtuSW9NNTVpajgxcE45?=
 =?utf-8?B?UENmZldDR1o0WWkxcE5ZSUhWcDhBQTd4RTIxdlNlR2YxOUZycXArckZZSFVt?=
 =?utf-8?B?OERyRWZzSWpMMzlWdmdSNXI5S2RmOXBkSXRiQkxIcWNDVjBuMnRrekJadHkz?=
 =?utf-8?B?TmtxVTYwUmxKai9kd2FNTDVubG14T002QVUxNlJIUStGY3V0N2JEa1lMWHdo?=
 =?utf-8?B?L1V3d3I2RFNoYmQ1UUpNekRCVU96bS9hSGVCM2N5STk1MEVMSTFzdC9IZHNM?=
 =?utf-8?B?cVI5bmRXTmt1VWQzdDFlSmNweWNvc2I3MDk5aXpXdjYvWlQ0dkt3d1FFTTZY?=
 =?utf-8?B?MXBLT0dvNDEyWjEwUzRseTFhVHVCOTE0MExpaDBxVjNZdi95TzY0SVVLU1o1?=
 =?utf-8?B?UCtubjlVbmhib1BQUjduTVp4aDg5b2xCTHBOSU5VN0wzWW9DT2pjNWJXdHUr?=
 =?utf-8?B?ZmFESnJGdHhub3E0ZTZIOTZIU0lBeWFQUHFYU1FLdEtSMkpxMzBqTVV4bmI4?=
 =?utf-8?B?MjZqQlIrd0thOUpQckJJaEpDYlM0VHlPQWVLMDRtR3Ricm12Rk1QQ3VFK2VP?=
 =?utf-8?B?azRSd2lDYTluK0wyQ3VLL0xXRXFySTZqL0lNbjVUN05tZ3JERzVqQjEzUUVV?=
 =?utf-8?B?NnN6NFE4aEpRb3hXUGdPS3FVRS9McUxicHRXdjZBOEoxWEMyNDdhdU5kOURv?=
 =?utf-8?B?Z3paV0o2VE5TSkM2QXZMSnhDRHVuMmJTNWdJaWF1aTZqVHdYbklkYmNidEYy?=
 =?utf-8?B?UjdLMmNpcTBMQ2o1Q1o1WE5aYS9WQ3JRNWpSQkM0RFg1eVp6TGtUZ2NKQWwv?=
 =?utf-8?B?bkJXc0dKTGNjVXUrWVAxT0RtRER1Wnc3NUFFYThXY2NaNWpRWmhzR3o0NW40?=
 =?utf-8?B?RXNXNGh6bUV3ZGM5aWpONEFNS2REZFdSSnRmbjllaytjL3N3RXZMelhyOVFY?=
 =?utf-8?B?VWV6NkpjbXVXcFVLTDlRb1JaYi8wdGFhWnU2SFdWZFYwYmxYdkRDUGJOdU8y?=
 =?utf-8?B?K09vSmhHLzE3MjRmZEF5RkdJcDFpSktiakF2eVZ5RjgwcDBPazlzeXRCNjY4?=
 =?utf-8?B?MkNZREdISGVibmxhNjZUV3p5MFI1TmR4blZkRGhNbW0yOFUranRIQVA2d0Zp?=
 =?utf-8?B?T1BJWnBYUnpnMVhhUmR1TGdyUVBWOUxDU1JaUkxBajErTHhPVC85aXlWMXRV?=
 =?utf-8?B?aFl5alZJNTQrMVBMTmpQUWdEUi9sSXRNd0FERUVkamlEdENxZGt3Z1JDakx4?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e16bab-aeff-402e-8007-08dba355153c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 21:16:42.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjjHhpFki4xS2htePAMULzsUw+UQfkZI5GnvJs/g//2nfGtM5H4ik6Fil4tPxVu7sXX1qJgI5AHECnaNKhgnvtPEfOJKoUdtBsOdOO/J7DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/2023 1:58 PM, Paul M Stillwell Jr wrote:
> On 8/22/2023 1:44 PM, Keller, Jacob E wrote:
>>
>>
>>> -----Original Message-----
>>> From: Stillwell Jr, Paul M <paul.m.stillwell.jr@intel.com>
>>> Sent: Monday, August 21, 2023 4:21 PM
>>> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Leon Romanovsky
>>> <leon@kernel.org>
>>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net;
>>> kuba@kernel.org; pabeni@redhat.com; edumazet@google.com;
>>> netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>;
>>> horms@kernel.org; Pucha, HimasekharX Reddy
>>> <himasekharx.reddy.pucha@intel.com>
>>> Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
>>>
>>> On 8/18/2023 5:31 AM, Przemek Kitszel wrote:
>>>> On 8/18/23 13:10, Leon Romanovsky wrote:
>>>>> On Thu, Aug 17, 2023 at 02:25:34PM -0700, Paul M Stillwell Jr wrote:
>>>>>> On 8/15/2023 11:38 AM, Leon Romanovsky wrote:
>>>>>>> On Tue, Aug 15, 2023 at 09:57:47AM -0700, Tony Nguyen wrote:
>>>>>>>> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>>>>>>
>>>>>>>> Users want the ability to debug FW issues by retrieving the
>>>>>>>> FW logs from the E8xx devices. Use debugfs to allow the user to
>>>>>>>> read/write the FW log configuration by adding a 'fwlog/modules' 
>>>>>>>> file.
>>>>>>>> Reading the file will show either the currently running
>>>>>>>> configuration or
>>>>>>>> the next configuration (if the user has changed the configuration).
>>>>>>>> Writing to the file will update the configuration, but NOT 
>>>>>>>> enable the
>>>>>>>> configuration (that is a separate command).
>>>>>>>>
>>>>>>>> To see the status of FW logging then read the 'fwlog/modules' file
>>>>>>>> like
>>>>>>>> this:
>>>>>>>>
>>>>>>>> cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>>>>>>>
>>>>>>>> To change the configuration of FW logging then write to the
>>>>>>>> 'fwlog/modules'
>>>>>>>> file like this:
>>>>>>>>
>>>>>>>> echo DCB NORMAL >
>>> /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>>>>>>>
>>>>>>>> The format to change the configuration is
>>>>>>>>
>>>>>>>> echo <fwlog_module> <fwlog_level> > /sys/kernel/debug/ice/<pci 
>>>>>>>> device
>>>>>>>
>>>>>>> This line is truncated, it is not clear where you are writing.
>>>>>>
>>>>>> Good catch, I don't know how I missed this... Will fix
>>>>>>
>>>>>>> And more general question, a long time ago, netdev had a policy of
>>>>>>> not-allowing writing to debugfs, was it changed?
>>>>>>>
>>>>>>
>>>>>> I had this same thought and it seems like there were 2 concerns in
>>>>>> the past
>>>>>
>>>>> Maybe, I'm not enough time in netdev world to know the history.
>>>>>
>>>>>>
>>>>>> 1. Having a single file that was read/write with lots of commands 
>>>>>> going
>>>>>> through it
>>>>>> 2. Having code in the driver to parse the text from the commands that
>>>>>> was
>>>>>> error/security prone
>>>>>>
>>>>>> We have addressed this in 2 ways:
>>>>>> 1. Split the commands into multiple files that have a single purpose
>>>>>> 2. Use kernel parsing functions for anything where we *have* to pass
>>>>>> text to
>>>>>> decode
>>>>>>
>>>>>>>>
>>>>>>>> where
>>>>>>>>
>>>>>>>> * fwlog_level is a name as described below. Each level includes the
>>>>>>>>      messages from the previous/lower level
>>>>>>>>
>>>>>>>>          * NONE
>>>>>>>>          *    ERROR
>>>>>>>>          *    WARNING
>>>>>>>>          *    NORMAL
>>>>>>>>          *    VERBOSE
>>>>>>>>
>>>>>>>> * fwlog_event is a name that represents the module to receive
>>>>>>>> events for.
>>>>>>>>      The module names are
>>>>>>>>
>>>>>>>>          *    GENERAL
>>>>>>>>          *    CTRL
>>>>>>>>          *    LINK
>>>>>>>>          *    LINK_TOPO
>>>>>>>>          *    DNL
>>>>>>>>          *    I2C
>>>>>>>>          *    SDP
>>>>>>>>          *    MDIO
>>>>>>>>          *    ADMINQ
>>>>>>>>          *    HDMA
>>>>>>>>          *    LLDP
>>>>>>>>          *    DCBX
>>>>>>>>          *    DCB
>>>>>>>>          *    XLR
>>>>>>>>          *    NVM
>>>>>>>>          *    AUTH
>>>>>>>>          *    VPD
>>>>>>>>          *    IOSF
>>>>>>>>          *    PARSER
>>>>>>>>          *    SW
>>>>>>>>          *    SCHEDULER
>>>>>>>>          *    TXQ
>>>>>>>>          *    RSVD
>>>>>>>>          *    POST
>>>>>>>>          *    WATCHDOG
>>>>>>>>          *    TASK_DISPATCH
>>>>>>>>          *    MNG
>>>>>>>>          *    SYNCE
>>>>>>>>          *    HEALTH
>>>>>>>>          *    TSDRV
>>>>>>>>          *    PFREG
>>>>>>>>          *    MDLVER
>>>>>>>>          *    ALL
>>>>>>>>
>>>>>>>> The name ALL is special and specifies setting all of the modules to
>>>>>>>> the
>>>>>>>> specified fwlog_level.
>>>>>>>>
>>>>>>>> If the NVM supports FW logging then the file 'fwlog' will be 
>>>>>>>> created
>>>>>>>> under the PCI device ID for the ice driver. If the file does not 
>>>>>>>> exist
>>>>>>>> then either the NVM doesn't support FW logging or debugfs is not
>>>>>>>> enabled
>>>>>>>> on the system.
>>>>>>>>
>>>>>>>> In addition to configuring the modules, the user can also configure
>>>>>>>> the
>>>>>>>> number of log messages (resolution) to include in a single Admin
>>>>>>>> Receive
>>>>>>>> Queue (ARQ) event.The range is 1-128 (1 means push every log
>>>>>>>> message, 128
>>>>>>>> means push only when the max AQ command buffer is full). The 
>>>>>>>> suggested
>>>>>>>> value is 10.
>>>>>>>>
>>>>>>>> To see/change the resolution the user can read/write the
>>>>>>>> 'fwlog/resolution' file. An example changing the value to 50 is
>>>>>>>>
>>>>>>>> echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
>>>>>>>>
>>>>>>>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>>>>>> Tested-by: Pucha Himasekhar Reddy
>>>>>>>> <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>>>>>>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>>>>>> ---
>>>>>>>>     drivers/net/ethernet/intel/ice/Makefile       |   4 +-
>>>>>>>>     drivers/net/ethernet/intel/ice/ice.h          |  18 +
>>>>>>>>     .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  80 ++++
>>>>>>>>     drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
>>>>>>>>     drivers/net/ethernet/intel/ice/ice_debugfs.c  | 450
>>>>>>>> ++++++++++++++++++
>>>>>>>>     drivers/net/ethernet/intel/ice/ice_fwlog.c    | 231 +++++++++
>>>>>>>>     drivers/net/ethernet/intel/ice/ice_fwlog.h    |  55 +++
>>>>>>>>     drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
>>>>>>>>     drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>>>>>>>>     9 files changed, 867 insertions(+), 1 deletion(-)
>>>>>>>>     create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
>>>>>>>>     create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
>>>>>>>>     create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/ethernet/intel/ice/Makefile
>>>>>>>> b/drivers/net/ethernet/intel/ice/Makefile
>>>>>>>> index 960277d78e09..d43a59e5f8ee 100644
>>>>>>>> --- a/drivers/net/ethernet/intel/ice/Makefile
>>>>>>>> +++ b/drivers/net/ethernet/intel/ice/Makefile
>>>>>>>> @@ -34,7 +34,8 @@ ice-y := ice_main.o    \
>>>>>>>>          ice_lag.o    \
>>>>>>>>          ice_ethtool.o  \
>>>>>>>>          ice_repr.o    \
>>>>>>>> -     ice_tc_lib.o
>>>>>>>> +     ice_tc_lib.o    \
>>>>>>>> +     ice_fwlog.o
>>>>>>>>     ice-$(CONFIG_PCI_IOV) +=    \
>>>>>>>>         ice_sriov.o        \
>>>>>>>>         ice_virtchnl.o        \
>>>>>>>> @@ -49,3 +50,4 @@ ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
>>>>>>>>     ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
>>>>>>>>     ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o ice_eswitch_br.o
>>>>>>>>     ice-$(CONFIG_GNSS) += ice_gnss.o
>>>>>>>> +ice-$(CONFIG_DEBUG_FS) += ice_debugfs.o
>>>>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice.h
>>>>>>>> b/drivers/net/ethernet/intel/ice/ice.h
>>>>>>>> index 5ac0ad12f9f1..e6dd9f6f9eee 100644
>>>>>>>> --- a/drivers/net/ethernet/intel/ice/ice.h
>>>>>>>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>>>>>>>> @@ -556,6 +556,8 @@ struct ice_pf {
>>>>>>>>         struct ice_vsi_stats **vsi_stats;
>>>>>>>>         struct ice_sw *first_sw;    /* first switch created by
>>>>>>>> firmware */
>>>>>>>>         u16 eswitch_mode;        /* current mode of eswitch */
>>>>>>>> +    struct dentry *ice_debugfs_pf;
>>>>>>>> +    struct dentry *ice_debugfs_pf_fwlog;
>>>>>>>>         struct ice_vfs vfs;
>>>>>>>>         DECLARE_BITMAP(features, ICE_F_MAX);
>>>>>>>>         DECLARE_BITMAP(state, ICE_STATE_NBITS);
>>>>>>>> @@ -861,6 +863,22 @@ static inline bool ice_is_adq_active(struct
>>>>>>>> ice_pf *pf)
>>>>>>>>         return false;
>>>>>>>>     }
>>>>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>>>>
>>>>>>> There is no need in this CONFIG_DEBUG_FS and code should be written
>>>>>>> without debugfs stubs.
>>>>>>>
>>>>>>
>>>>>> I don't understand this comment... If the kernel is configured 
>>>>>> *without*
>>>>>> debugfs, won't the kernel fail to compile due to missing functions 
>>>>>> if we
>>>>>> don't do this?
>>>>>
>>>>> It will work fine, see include/linux/debugfs.h.
>>>>
>>>> Nice, as-is impl of ice_debugfs_fwlog_init() would just fail on first
>>>> debugfs API call.
>>>>
>>>
>>> I've thought about this some more and I am confused what to do. In the
>>> Makefile there is a bit that removes ice_debugfs.o if CONFIG_DEBUG_FS is
>>> not set. This would result in the stubs being needed (since the
>>> functions are called from ice_fwlog.c). In this case the code would not
>>> compile (since the functions would be missing). Should I remove the code
>>> from the Makefile that deals with ice_debugfs.o (which doesn't make
>>> sense since then there will be code in the driver that doesn't get used)
>>> or do I leave the stubs in?
>>>
>>
>> These stubs are for functions we have in ice_debugfs.o?
> 
> All of the subs except for 1 (which could be moved) are in ice_debugfs.o
> 
>> Is there an ice_debugfs.h? We should implement stubs for those 
>> functions there so we don't have to check CONFIG_DEBUG_FS.
> 
> There isn't an ice_debugfs.h, but moving the stubs there would have the 
> same issue correct? You would have to wrap them with CONFIG_DEBUG_FS no 
> matter where they are, right?
> 

Never mind all of this. I looked around some more and as Leon said 
earlier, we don't need the stubs and we should not be using the Makefile 
to remove the code if CONFIG_DEBUG_FS is not set. We should always 
include ice_debugfs.o when building the driver and the calls to 
debugfs_<whatever> will fail if CONFIG_DEBUG_FS is not set.

I'll change the code to reflect what I just said (and what Leon 
originally said). Sorry for the noise.

>> Or, if they don’t' really belong there move them into another file 
>> that isn't stripped out with CONFIG_DEBUG_FS=n.
>>
>>
> 


