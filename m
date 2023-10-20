Return-Path: <netdev+bounces-43073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC6D7D14BD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A36B21401
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20260200D7;
	Fri, 20 Oct 2023 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7Vayq+Y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83550200B8
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:19:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9BAD6A
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697822386; x=1729358386;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ERsHH1wgdUPiEgW20ocwm9hDxTyCeaB1L5SxAptA3xY=;
  b=B7Vayq+YIp/T8MB/reeDvuddjOcIx0wknR1NnQq1qqNFoXkl5hf+S4n5
   qTbYtDS33OysGb/pleeQ3riWhDEgM3i85HWchp8zCvLT5THjCqFYeoXRe
   xfy1hDZ16lbnBhCFCroJ/JpzPhVXYxthiff3jTWNlW9lw4Q95G2tfKMbv
   vy+1VeI+ESENIAEZXiD0e/+X73MtXgeHNfnSApjISzl2H8PiLnBEE2MEY
   R1GViZhoT3ysX/96//fIy5YfGeoCit0D0GbfXNEFtyd/GtUHfUQRNrfwD
   5/2b1l0aZlDK94bO9n0Uw8A/Zy8iYJulK9TY7U8SkuHxva7E1O/wjctHZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="8101587"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="8101587"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="757524523"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="757524523"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 10:19:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 10:19:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 10:19:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 10:19:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 10:19:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHD0om1l9GP+nhPwGQq04ENdMhwk6u69JQwSujYiazFWA8zGLPES5OwK6+3QFrc7Y01Na+D3EwXl+5K8s6DjUXPau9OwNvn+J031wlEUxA8g2YtVVsvEi7Y71PaXHn/tQc7BQzvFNCRPtZ3SUKQpVF3cEmjZZcX5RA7C6iBV5zh9HBowE0NjNgBPQuIY5n5OhvpZ0P5MYUUPyTKC7dE4gqykiZ+y0i0YdaZ5zitu9HPw+M3vYOTlhe6ptJFNiSvcYR5l5It5BQwAyrcwtGUQk4W1lopiUXrqG0cHRknLtEHnhrMQ3gP/qGteols6QLmlkS8Pvihu3Sqtnp3cirL1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMCMs/N0VspZXe9AVQqK0LgLsn0pO5nF3aiRZ1ZSfe8=;
 b=P0BjefC8HN29UEQpNXebZKF4KwTGo/7jeGyn+7TZhvMHO4bMr8iOYH40zF9fugMgHgD4KIaXwotBgBTxZY2U5/yvNg4THaOvfSoLwmtghPfXt2jddqQ8k7fVqV8FqcmLxb+2j1LZ2yKuTL3SOuM55juvfjZF4XpCnJQcDIrTppMLmZykArtUFsMKQmHTDZlKfbCI53qpnG6Zx5sgXFYovBtZh7xRWknfUxvcVUktgzQVK7cROI8Em89BDYDE983KN+iAlYTzWHugQKztrJ19uEluLXksiPAPAviCCIDWHtt/edGHeDEM3orXpc7CcluS8qEn7GNJ5BamNoYFjUZqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Fri, 20 Oct
 2023 17:19:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 17:19:39 +0000
Message-ID: <878f40e6-645e-4166-b60c-ba488638cc42@intel.com>
Date: Fri, 20 Oct 2023 10:19:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: sync next_to_clean and next_to_process for
 programming status desc
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	<hq.dev+kernel@msdfc.xyz>, Arpana Arland <arpanax.arland@intel.com>
References: <20231019203852.3663665-1-jacob.e.keller@intel.com>
 <ZTJcyes2Zaug6dlD@boxer>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZTJcyes2Zaug6dlD@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:303:8c::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ded0aee-9bb7-4c06-8a79-08dbd190bdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGes/1MDFTgpzh5nmJdk+L/qtqbSDq7LdAX9wGSKI2L6A8JB/crXRCV8fUruwP6QZoymKjff2IvvQJ16aSH94QTcZtnJEJwXeHT16BsxC6rsIWcayV2IxUe3gcJITwgVSSMl/qB8G7HR/i1+QXONqH7sP2Ux5c4QDRzGy9SQACklYkcjbzOYSkqu2tAjqu5Xpm23kHCz71YLKkSXoHM0BtkZlPC8XzhkL/Sr4Df3eOuAnZfJdWwgggkH8iW9NoeCjeeruUq/hqcs3rKBX6h3j19UUZRvaB6ZaookyRM5nP3o8JOksSnirBHqvyX5i6Rk2vyhF1g6iS9WV1pnCOlxinfhvlNt0OabAjzKh5FBOfb6su+i7xVXGzxT5Y+yUMM6jAxkwor25K8TG/NdaLk92BRQa3aNqvXAiVsJuXFZNFwSTT2Xw05D94Sc++ZnmtXacBSdr0kUegIAjf70vWj51mGchxj7mhTz1POS/2Pt+J/ZYjJFsU7lUDXzkw6hQeQS6shlTq1tJQWAqLnghAAvFOeqN/nQzqvC9V3ArkZ7ncFLCtJ7pj6pj6ThwW2tnR1Nc6Lzz5HoDv/XNVwDTgkWG5DRu3E1kvx1ddG0Eu/aGiGu5Sj2yIkMm0PahYhHNbbCBr48zJeimSnth5SNqLdwng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(31696002)(53546011)(38100700002)(86362001)(82960400001)(66574015)(4326008)(41300700001)(5660300002)(2906002)(6862004)(26005)(6512007)(8676002)(6506007)(107886003)(83380400001)(2616005)(36756003)(8936002)(478600001)(316002)(966005)(6486002)(66946007)(66476007)(6636002)(54906003)(37006003)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVjRjNYR0hjNnBqSnpGZkdvL0ViTDF2VjJXS2UrTjY5Z2E3WFFMaEpJVFF3?=
 =?utf-8?B?YUNkWDZUV09EMXh1a1cyMlZEOUpReTRwUjJLOGxwai9SbU1CRFRxYWdEdFhQ?=
 =?utf-8?B?M3lDa2EvbFpPT1dTRTRja0dNMXIxZWZRdlhnUldLS1NHTVRYcGp3dS82Y3k1?=
 =?utf-8?B?aHM1V014UWtISjlMQmphd0had3BrOFRzU3JXdVl2VFZ6RnRaS2xBeVZJVWs4?=
 =?utf-8?B?UGJHWnFYdmRhcXVPZStxb2lDM1VrUmtnOVFMb2g0TU1GbDF3Q280anZlTUUw?=
 =?utf-8?B?anN0YVVyM0U5bjFTSERRaGM5amFhQVI3WDB2VndzQVVFbVVCNU1jUUV2Mi9t?=
 =?utf-8?B?NUpCTmxrRHQ0OE5CSDdRUlVoTXNVaEN0Tnp0WnhlVmh3dkExWHNiVE9sd1hl?=
 =?utf-8?B?Uy9sREkzbG8wUHhPOExwWUZQRXBjbklLc1FJZkRGeWowTW1uMDE5TDJuM0Mx?=
 =?utf-8?B?aVpYNDZ0OWJkekF6SEtUd1RrQWVPQzRsOUllcmxUUWFEcXRRQ21zZDI0VTdY?=
 =?utf-8?B?ZnBiK1c3REdpOXlVQXNyYXFOSS9qeERIa2FUK3hRdVRHWmZmTlhQRS9Bb0t6?=
 =?utf-8?B?MzJnd01jZXVPTkFzdTIrdGdXRnV5TmNHYmRPQy9EanFpTHp1Z1p3OGM0a1BN?=
 =?utf-8?B?R3htMWZ4N3pWVG0vZ2xycmN4dk5rcW5PVlF2akUzbEZzZDB1bkZOY1F3WDRn?=
 =?utf-8?B?L1IyZXp3Y3dybFR6Tmp5bDRPZ0FqU1gzZmhWM1VtRGdXdWVmVXl6c0U3Z1E2?=
 =?utf-8?B?THpFZDU0VEJMdHorQjA3ZXdEaWF6VDVOcmhVanV6SkhXeWswVmZzbTN4MnV2?=
 =?utf-8?B?V3pka3FoTXNVRDNhQlY4aUs3STIya1p0Z2VmcTBseGZNTWxJbUlHZXdXa2hM?=
 =?utf-8?B?aWY4L3A3eWZFTm5kN2h2RnlrZG1wWm10TVFmaE45Kzd5bTN3LzJmS3lYR09r?=
 =?utf-8?B?dVpVUVNXUmVIUndYMzh3VWgwMkNFNHBvczdnSDFMeW5SWVdIWm5uL1dZb2VY?=
 =?utf-8?B?ZDdxVU1nMFJvZTFEL0NCS0pEajgrRnJOdk5HQmJJbG41L2l3THJZbGlzOE1v?=
 =?utf-8?B?ZFpFaTRyT255Z3ROOUREbzI5eUdjUSttbGdIL1U1TFBYYUtVa3paSVd1RkFD?=
 =?utf-8?B?YTJsakJLenBqNTdRdUtkUUorTWVPYmdaTWIyeSt2TlFVeTMwUW0xaHVCTlRE?=
 =?utf-8?B?RVhJZ1FUUWFUQThoT2VTV1hxMDNrNmJrR2J4L3JLZVQycmYwaXphRVJleFNE?=
 =?utf-8?B?WXFKWDJhT2p3RVhIT3JXUmpoYlhPVllZVFBENXkwdG9KOEtMcW5tSDlDMmpM?=
 =?utf-8?B?SlBlNEM4VWZVdWZveFdDNVBrZERsbVJSbkNEQll1aDNVMG5KTnk3UXdDdHlI?=
 =?utf-8?B?UlRCYjRnSitpcE9BaUxhZVBSMXJUaVVXSVJ5RDRXbTRnTERaZTNqdzNzbFIx?=
 =?utf-8?B?Yi9Fem5VNnRkWXZGdEZPeVdYUm5nK1cyMm52WldjaHVzRGd5am55MU85M2NI?=
 =?utf-8?B?K3MyWDlVWDg1dGYyUzBhN2pBZXg0U2dscndPUGd2TVd6bWlkMzRIYUdMRnNz?=
 =?utf-8?B?Mlp4OEs1aUdqUU1ibjRPb3o3RXMvZFFnMDFWT0xUWXcvMm1aYVhFNHRmRWtD?=
 =?utf-8?B?OWFaU1kreDBLYk5KMGJ0bFpqQnYvSENWb0tsNTBSSzlOaGo1ME9IUXp4cVAw?=
 =?utf-8?B?Yms0Qm5QaEhTaFl4U1VmV3hDSW1iMFZQK242UzhWTUQ5Yy94b0MxMVpneCsx?=
 =?utf-8?B?NWUveVB4Mjl0Wk9ROHNBOGRjcDRZSDJZS3lLVjMyMkZUSTZvdmpiV05VTUpV?=
 =?utf-8?B?OWp5ZWt5Ky9wTUhkbldvbmJTV1puWFVmV1Y3MlV2c1VGOUh0eHZqN0hqNEFw?=
 =?utf-8?B?UGhxbDhPUHJla3VFdFNKRE1tWERpOHpyWVBpdUhTMGJ5L1dPRjBwUXZwNVdS?=
 =?utf-8?B?TlhicmFNYlNHWi9Vc0hNaEFPWDVib3JRN1lZRkxEMFZPYWpHb0h1N1VyS0NW?=
 =?utf-8?B?Wnp1SEFSMlNpMUhiekpPSmphaGxXTGMxVklDUDF2TWlOQXM2cERzd2RFaDJt?=
 =?utf-8?B?Q0VYT2UzM2ZuQ1kxQmwxcEtsVEp1eU4vZllXeW14T1FDN2pDZDdyUGhOUjZH?=
 =?utf-8?B?V3ZJWExqam4wRVEzbC9hYU5XdldPMCs1Tk5sZFBKaWpIRWJDV2JJRFNTeUJE?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ded0aee-9bb7-4c06-8a79-08dbd190bdef
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 17:19:39.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jopQ37gkY7c4vsHSsHWtmP2Mx+AIOleZmdNH7G5zjGJXHZdifXzXdCHN/nOpF4rgYH5dcoAupvK4BYoh2fLMMYlQSq5CNnkKFynffGYy0zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7677
X-OriginatorOrg: intel.com



On 10/20/2023 3:56 AM, Maciej Fijalkowski wrote:
> On Thu, Oct 19, 2023 at 01:38:52PM -0700, Jacob Keller wrote:
>> From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
>>
>> When a programming status desc is encountered on the rx_ring,
>> next_to_process is bumped along with cleaned_count but next_to_clean is
>> not. This causes I40E_DESC_UNUSED() macro to misbehave resulting in
>> overwriting whole ring with new buffers.
>>
>> Update next_to_clean to point to next_to_process on seeing a programming
>> status desc if not in the middle of handling a multi-frag packet. Also,
>> bump cleaned_count only for such case as otherwise next_to_clean buffer
>> may be returned to hardware on reaching clean_threshold.
>>
>> Fixes: e9031f2da1ae ("i40e: introduce next_to_process to i40e_ring")
>> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Reported-by: hq.dev+kernel@msdfc.xyz
>> Reported by: Solomon Peachy <pizza@shaftnet.org>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217678
>> Tested-by: hq.dev+kernel@msdfc.xyz
>> Tested by: Indrek Järve <incx@dustbite.net>
>> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
>> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> You missed my ack, so:
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 

not sure why patchwork didn't pick this one up. Sorry about missing it.
Thanks!

-Jake

