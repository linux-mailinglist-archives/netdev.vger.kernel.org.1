Return-Path: <netdev+bounces-39201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79E27BE4D3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0708B1C2093B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F1A37175;
	Mon,  9 Oct 2023 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6TUgXqq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764936B14
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:33:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9A091
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696865624; x=1728401624;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+cPa2cO0FJCgReyWwocx1dlsGgFqliEI+wNYVHSrdSs=;
  b=f6TUgXqq9Nyp/3jqmF+6JN2Gv2RhunXLb7bCtpUBi96nXv/23NJKTOJN
   P30qmSrEKAqqO7RWZGbqLjOuv1QyWSWkjIrepG/wkAllVkHrDq5h+s1no
   ziXrI9jZmhVeXOH9pDw4oywQPcoiieHVdp9eKobn7AlJLrRjHwVxTlHvk
   KUWUCLp3/SL4+EOJd9BIYFk5G4lV3TOMklRWrjQA+hr1DHHg40cUKwC5B
   yvuqMNmImQvZTYWsLNos0EgYYMNs7w29he0BQarPmB42IhCTTW8ds+X8i
   SIX+Ao1jNkRZcJz5kGlGTtF+U72fcQGn6JrtMftoYdEwBfyaI+8b2A/cZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470434928"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="470434928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="896803867"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="896803867"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 08:31:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 08:33:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 08:33:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 08:33:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 08:33:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsCL1sa6JH/8+BNVXXV/moTN1E+5WNa9Bvyu4gbAW6TEww41Ii5IapouioiWGCSDhzz0/DZRhmeVAksukjdxQ8w56LJdhKYgBFLHrVzQGyi1gu0J2Usu8pjxXDyvCeB7BTgQDwCFSCniyT2b10eIRyAFRzkkwJU9Qmy+ei9WDOciulvQEqDmHeFiW2D4zjPIKWIAKUwbFZJ0y+rbMVYKpDS4AvdNo0W+63HdeMze8dIoe/gd21yZbUmCr7knl1R/PmRkBcVn4C8EHIX0bsylHK2HcMDyQaFF8R5cCYB8m8VrvYgmKff7ZE5v9noksBP2EnlsHmLiCaQqAe9tXQYWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cPa2cO0FJCgReyWwocx1dlsGgFqliEI+wNYVHSrdSs=;
 b=JWKNvSsbjsUbBL4nGh/alwl4F8inYE7CTWRUiJtNE0XUL4wfIcYkqM8YWhgbROQj+phS5EJRd5BFwDbKTu5Kxmt3hbZZRYzKll0sQbdRyJU22MH52CFLL4zB9v274aKCw9RQRAPAKoUue3kdgvNJ3sKVSly2BYimL3+a0Jn1xi7FbWN5+RoMBW5uetHVy/cBmTA8HF9W5xC4chuuJbbtvIS5aCVxPO/2BPDvftMy252T2PWOjv7uDbHC+n4fjhkmKrDnD83cOaLBA+aDJoZDOIveBxcswaOK+JtMTOpFUooOiDJ88IpgXxMZ5iHN/RJoKeEh7INPinOqUITLWC0wyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by PH0PR11MB5641.namprd11.prod.outlook.com (2603:10b6:510:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 15:33:25 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 15:33:24 +0000
Message-ID: <6e48c3ba-8d17-41db-ca8d-0a7881d122c9@intel.com>
Date: Mon, 9 Oct 2023 08:33:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [Intel-wired-lan] The difference between linux kernel driver and
 FreeBSD's with Intel X533
Content-Language: en-US
To: =?UTF-8?Q?Skyler_M=c3=a4ntysaari?= <sm+lists@skym.fi>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <ee7f6320-0742-65d4-7411-400d55daebf8@skym.fi>
 <994cebfe-c97a-4e11-8dad-b3c589e9f094@intel.com>
 <c526d946-2779-434b-b8ec-423a48f71e36@skym.fi>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <c526d946-2779-434b-b8ec-423a48f71e36@skym.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:303:b5::17) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|PH0PR11MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: cec4f283-8ee6-4f72-9a8d-08dbc8dd13c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9+lalHbZ0PoeznnQRQJHbxTB39D+FoK4CpGC8n+tYZRNVXVk3srOOsgt5Dj+E4I3AT9cErlW+hsew1A53zuj1am0X7VUhSMrzociLQdIyDrNvfxcqZzM4wR0enZm+Nmcc8oJ3TfbkwrWf8kGmlv2rdIqNEHK0+Z6xtzCIIcQr1q6CAHvGfYK/G6BvHL0fvKK1d7ZJlNgmHaSGqSUNZWhALuIBdpLXqKDy83e+uGnd3JnU0E7MYkGUoenoNOyVAueul6mmfWL6yAcTKlKPcvD/v4ySc/jES6EdJsyQ+5ZDp1yqSfhlV1Nqxg5dR6kIFrzCcqg7RQ5emsEWrHA406g/A68ingAk6JwhFZ31NwqfpDOPGVf7jxXMb5f1YYcmKdcH7vdeA3SM/hQCQpof5VFKoR5TT5EJepMq3Hr4i/eYLNr9E8aOsdgx3hmMpopG3NcB0czC4pUriiArKE8YzIlMFT5xK2KDLV6lpZOF/McXWTgqyhqrRxHMnQf+XT/SmURugnKUNjiBodFMORn3oA2k1Z1wjmXBKNXU1qoUMl1dx+wn+UzMPiiT6v9BIoJT2+OKCUINsnXOynLcOEnu+HIYtgDPX4wt1tSokRH7S7ZNtawWsuWvBRJNmhuFXoAQGVGaHysXupJWrwZdO4+d8qOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(38100700002)(31696002)(82960400001)(36756003)(31686004)(6512007)(2906002)(478600001)(966005)(6486002)(4744005)(53546011)(4326008)(8936002)(44832011)(8676002)(41300700001)(6506007)(5660300002)(83380400001)(2616005)(66556008)(316002)(66476007)(66946007)(26005)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cERvYjRzYS9ZWHdlOGVkOEIxc3ZUWUliS1BsaWJRYlhEdEhzZC9HTERYVm0y?=
 =?utf-8?B?d2tXVjVOVis4VVR3VVIyYXJUbmJXckFMenFPQ0llUWdtM2ttOXZmMGFEVFFw?=
 =?utf-8?B?eE5oSUlFcy9VNVAyVjArSUMxUlhNVGRHenFGSGtRY3hZNzZPdzNLVXoxMHJT?=
 =?utf-8?B?Wmd1dFhPMXUxWjY0UVZ4N3ZOUURhUHBBUlorVTlrSmpTVlZJWUZZWkU5T3lD?=
 =?utf-8?B?b2pwNmFpQjJLV2pwb2RyUmk2Vk5OM1JCa1o0UFBFT3ZsWWRUK1ZoZ1ZXU29B?=
 =?utf-8?B?bEt3R0hMRTdQR3ovZDRhZXRuR0hoYjlnc1MrQjd6dDVIZEpqZ0Z3Zm94a3gy?=
 =?utf-8?B?WkVFVHJERysxd09lekhId3paZEFHRTVEYXdlL2J5ZGRRM3pFVnB0Ym9KbTRw?=
 =?utf-8?B?U1pMT1grWjcwZHJqQVhkVlgvd21wT2Y2Vm5YZUJhVEFaamd5dHVrT1FBTC9l?=
 =?utf-8?B?Qk1YSTRUTXBMVUNvNWlIVkpTbVhVUFVMS1U1VklVQnp5NnVFOTlTYzNsZ1Fw?=
 =?utf-8?B?ZEFJdjBQWU91akRQK2ltL3RMVnhFampWZERjNWFrcFlkZEtrSEE1ajNyUjEx?=
 =?utf-8?B?elE1M09UY3p5c2dYNzN2cDl2VHJCQWhDVW1jSFFkTU9wZEx6ZE4yOVduWkpS?=
 =?utf-8?B?WHdVd2x3MWhOajVMOTczNzVTRTltL1cwY0xyWVpNbVNYZDdxTStvdDRFK3VP?=
 =?utf-8?B?UHM0NGpJMDJrNlhsWEZXd1ZxU0xmclB1dUorakh2ZVFHQit6alRIWHh5U2ZH?=
 =?utf-8?B?bE9OcGdtc0pGamlMeVh1SWFoWG5EbTV0V0h4OWJUcUp1K3NIUGUwd0w5M0Mz?=
 =?utf-8?B?dDR4ZmYvTCtPZ0kyakNxWFRWQ1N5Qys0SWFxR0VCdEc4RFpOZU1CMURSdkpV?=
 =?utf-8?B?L09VdndLR1Evb29JejJaTm5RMFQvbCtDL3F3bjQvbE9UWStSK0NxUWZuZ3JX?=
 =?utf-8?B?YjNuVldiSWkrODRyUGFXaGJ5ZXlZYmhtdFVVMzhNbFQ0UVZ0T3NGakN5dkpC?=
 =?utf-8?B?aWxOOStVSjJjZS9aM0hFanh1L2VsMjlrYU1kSWs3OWFFSHZWWWdoM3V5VSt4?=
 =?utf-8?B?dWc1TmJlaUdxM2o0T0JJY255aUFGQjN1VW1IbHAvWWN2WTU1TkxIaFF6ZXpj?=
 =?utf-8?B?eHE2VkRqK1RwLzVvRXhySWQ3YUJTUHFKdmdJTGdJQUJYamUweHpyUU9Ocm5u?=
 =?utf-8?B?REdlQ2NiSzVUMDJwSWlRTGNMVjZnK2Qydk9pVDZSTG10QXE4MDRDU1drZUg2?=
 =?utf-8?B?a1BMVXdLcDBsaEZnajFqTWhvYjlHdGRiK2d1MDA2R3hKWnp4MFFBNnJqb0pX?=
 =?utf-8?B?SXNSUjllc2lVUGx1R2RYaVgyUEk3dktib1pTa2d5MlAyNFdpUUhGUVhrUmdO?=
 =?utf-8?B?SzBXSW8zcVdPYnpuVGpNUHZQN1dNSnBQdC8vcFQySWp2Q09lMVpGZGxNWEZD?=
 =?utf-8?B?VnZYRTJRTm9rRlI0TXNIeXlSNDhOc3ZMdlcyNkUvVmhXcDE3d1NYczh1dUI1?=
 =?utf-8?B?WUZGTnBhY1BOOURHT09nYWh0WUUxNHJCUHgybTZOMldsQkNITk16SzZWWFVo?=
 =?utf-8?B?dmZ3cWxYWXVsQXBmMllzZEMvTE0rdlJ6aFBRZW1uSEpKQjRzTVhKcEZBNElK?=
 =?utf-8?B?clJTWXBIaCtwUnZJT2dxeW42K0h0aTFBS2tHRVBPUEJZNkkzbHZkenNtWVJD?=
 =?utf-8?B?UjBqbEVodDVvdHExTmNDMWNoWTBPdGo4ME9SRDQzeXVEYm9VVEVOV2Fnd2E2?=
 =?utf-8?B?YTZ6RlFhZlNPUTljN3EvWWFoR1FrSk4xNkliVHV6UGtrNjZ3TFZEWS96KzR4?=
 =?utf-8?B?ZGpGWEtwcEZzcWpoTEZPYkxNVk0vSm0yOWZJWjgwZ3pxWW1lM25XaWVSdW1s?=
 =?utf-8?B?cVVqdUlLWnRZMWZTZzJHdE1maUo2M25YTFg5c0hTUXZMNWV3dlhaeG4rdjc3?=
 =?utf-8?B?cVBTK0dsM2xFdDd6UUVVTzUrRkd3RWtKL3V6K29Rb0ZxR0d5Q2xjKzk3MmZ4?=
 =?utf-8?B?Y1Y2VEZKOUZIK3NsaXdpRzN3cTdnT2xKY0M5SC9KU0RXYm42TWtWQUt0ZWs0?=
 =?utf-8?B?emhEZjRwZXBTNFE5eGtKNHM1RVM4S1FWQS9EQzFiUVRrSTU3alR0eG02cDl2?=
 =?utf-8?B?VnJTSkxBdXhUdXJkam1vNlNtN3l6M05wZ2E5OVgxOCt0cE1VNzRIMmtOU0ti?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cec4f283-8ee6-4f72-9a8d-08dbc8dd13c1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:33:24.8843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5r8cOaAyCSuGZUy6AzqMUvDhl/m5eTmqmvGWGXI4WfpOsx55cI0bHgsotKsEB3/7P+e+/dmFtwuL5OHfPLrzYonYnx+VNNKhuw0K1XP5QoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5641
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/4/2023 10:08 AM, Skyler Mäntysaari wrote:
>>> Hi there,
>>>
>>> It seems that for reasons unknown to me, my Intel X533 based 10G SFP+
>>> doesn't want to work with kernel 6.1.55 in VyOS 1.4 nor Debian 12 but
>>> it does in OPNsense which is based on FreeBSD 13.2.
>>>
>>> How would I go about debugging this properly? Both sides see light,
>>> but no link unless I'm using FreeBSD.
> https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/12253/11?u=samip537

Hi Skyler,

Response from Intel team:

In the ethtool -m output pasted I see TX and RX optical power is fine.
Could you request fault status on both sides? Just want to check if link
is down because we are at local-fault or link partner is at local-fault.

rmmod ixgbe
modprobe ixgbe
ethtool -S eth0 | grep fault

Since it is 10G, if our side TX is ON (power level says it is) then we
should expect link partner RX to be locked so cannot be at Local Fault.

Skyler, please gather that ethtool -S data for us.

Jesse




