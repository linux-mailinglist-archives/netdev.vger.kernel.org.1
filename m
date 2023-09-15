Return-Path: <netdev+bounces-34081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C47A1FFD
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB617282F15
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E9B10A06;
	Fri, 15 Sep 2023 13:42:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E418485
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:42:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1B10D
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694785362; x=1726321362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dYU9cYCP0yiN3c0Ou+O1qpLafyf96nmea3lTJnKGTbA=;
  b=bIyHdCpmP/V4JCGz3tbjjcXCuwRs552iYHnRpP1NVIDHauSFeuLYe27f
   X2EpvGC7Tnii62hopt/HuPhqSORLtJ/eVs8JRZP9/Ul9dir/MBUZwZv4/
   lS7Fws90yisaGjwIC6ZaO+zP/Hhxos+IvZI39o55PFFCmGVXEZ9/L55ZQ
   6ggTTLQoChfIgAOIhT/eceHaCtnR4brliiHscRfLLQcYegsUDueR38Xyc
   Rh7E4HbFqfSVMzP4wpcK1HksCZjeAqqmap1EPC161KzbK5lklRGVCUDoe
   bviIBmG8hmd3cYeUFYx0vS56Fid6kzz8+AHtIgonmEALtQ16AIRdYmM7Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="381978284"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="381978284"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 06:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="744989066"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="744989066"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 06:42:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 06:42:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 06:42:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 06:42:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 06:42:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBR3mw+trDrzPT19zdzXy32LAsMWcGifS5K50zwZB1+gt1cSKW26B4NJm6PCZJDx5PAtskccnONc4lyMPRjHwKDSpYKMavsda7rucz12RaBCVWLCsbi52ZqpPjg8S6ciVRmAfix38vUXAm7R52/f7DaplpYCXtRAxl6gCCj4WCWcQqMyBD/5sW0S14DusmLCyFdYxt0nUiipTvX8QwAlwPMn6lvYF+TcBdxUbYV/3hsRHGawX25aRWnIR+86hcM7Ij2U9zYUD6sVvoBCVMtQtWCVVi22X2HrcAZQhFQNA49NWXTP6TpJLc68STS4XA5YiDW3kGE88EP4p7WZHqwypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pefAVKQSEYjP7CicI5OTQz4OloV1ehLK3CpWAfCODH0=;
 b=IcPM/o00eHVcuTEm8DHpyZ/Er2WIBIYhIE0K4Px4b+iWcWxBgAMRFfU4xgsL1qWe4c7CWhRZM2K7Td9xSb3vkjRr9QN6PWAjqasYCSJX2qT1DadPWY42XWpmPmz+2H5KJkCL31Q+gHlvye6HsGC7FvNSX6zJzi64VDhwaEQgN1GnWTDEh83i5hnNqmtqb+aoYH175Lw7PVHfAsvylbqwUYNHbabVmfLVpnE1ac4R6BAV91UsDKM9+TZvMEqjwji4NKAxN4KvTkQ2e89OiGGQB5ONz0qsTPrE8bv5XgXWMfAdHAYNFnFEyydgrxa+KrmG/mRAt5oIr2kqzattWcz4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB6746.namprd11.prod.outlook.com (2603:10b6:510:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 13:42:34 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 13:42:34 +0000
Message-ID: <3713a4ff-c977-c62e-aa56-9293cf2cfd1f@intel.com>
Date: Fri, 15 Sep 2023 15:41:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/9] ethtool: Add forced
 speed to supported link modes maps
Content-Language: en-US
To: Pawel Chmielewski <pawel.chmielewski@intel.com>, Andrew Lunn
	<andrew@lunn.ch>
CC: "Greenwalt, Paul" <paul.greenwalt@intel.com>, <aelior@marvell.com>,
	<intel-wired-lan@lists.osuosl.org>, <manishc@marvell.com>,
	<netdev@vger.kernel.org>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
 <e6e508a7-3cbc-4568-a1f5-c13b5377f77e@lunn.ch>
 <e676df0e-b736-069c-77c4-ae58ad1e24f8@intel.com> <ZOZISCYNWEKqBotb@baltimore>
 <a9fee3a7-8c31-e048-32eb-ed82b8233aee@intel.com>
 <51ee86d8-5baa-4419-9419-bcf737229868@lunn.ch> <ZPCQ5DNU8k8mfAct@baltimore>
 <87ea2635-c0b3-4de4-bc65-cbc33a0d5814@lunn.ch> <ZQMYUM3F/9v9cTQM@baltimore>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZQMYUM3F/9v9cTQM@baltimore>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: c83fd22d-512a-4d13-4e57-08dbb5f19d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTl6XpBshm8PQjEI2KfTLidNQdk9O1TrirorRpP0dbB9NoMqY1p2G/s+SC33sfeOtOsDnRvZtmsGxe5K6/l5mrtcCPIsouEwBWIVqrHUdT6FHRh3YpaNTy1XvYN9wjkRwNavdBADgY0R0tSHtAlswiaZqiL9bSlKSkTRbWXCUW0GYlAB2ix6F+4Ib8sbKltoBdYtmeQmwWxS3cCMd9Yrmgn0FWtiZSwjaZfmpCY9rZGaY5N+7wiZt8v7FOw2iGXGSjyaAkIpI3+7OxRa4ax5Z+wn0gcLw/GjYPYcvNvBgbROy23lkQlKxvjiwwrgDH7BxKILpd+Lu7AEEhbG8Qx8NdVuVsSvDChABiRuOCneIc9DSLH2+VgWAC24MylgZxQATr/3i9eW3fTFh06za9vJ/1+kkDMJu4xAviorwCG2HZM5FgIsdIF+4fbzptc9xptCfbpsnfdbeo5RLEEMp4Cxc9Rb7Jh5cbxJuH+GH7+Y1PM6KTvRWj6gNlpIWKqi32qEk/P6R83KYmVWQ9+aTdqOiy1hE9le+gjQrtIdFIWgtjWVnxDYjAXkc+jGUczXDrVViiJ9DHtS2wU0rq4xHKSMh6YcfJ2WHkYbgrkccmgWyIB6L5b2K4otnQCdbtrQo+cIQ3MFILtzyou4E8Kp+Mztfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(41300700001)(31686004)(6486002)(6506007)(66946007)(86362001)(36756003)(31696002)(38100700002)(82960400001)(316002)(966005)(478600001)(2616005)(6512007)(2906002)(83380400001)(5660300002)(110136005)(8936002)(66476007)(4326008)(8676002)(26005)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmVJRHJZclZZWWptL3JQcUlYMkM2UEJsU2RGNlFYYW4zLzNZc3czdTdIVC9K?=
 =?utf-8?B?S2dzeXlBaDJ5UzM5anJSanRHeTcyN092OThOSHFkV1JaazliSjVXU3FLY3BI?=
 =?utf-8?B?TDcrNldHNzdkOE1XTmVLQXZpTWc1bXh5N2J3c01hbXh0TWhVVjBVTlQ3bWhv?=
 =?utf-8?B?ekZhS3ZReU5WWHFNTC83WVpuK1BwUjZMZlY0WFpKNVl6T0pkZjVPUzNQVHRn?=
 =?utf-8?B?d1ExOEF0dDJhSHMyd1kvRTY0QWN3SUVZb2I2SG9mVURIZjJ2VzBzd3p3UHV6?=
 =?utf-8?B?UEM5YTN5QlJHaC9Va05vNWlmbFRucDI2TE56bkF4aXlTMm9tM0ZZdzlRZ0Za?=
 =?utf-8?B?eGc0c0t2ZkZiVzUzN2tTMmZsSll4ckRXMWYxdmtpMEc4YzZQZjdTcHF1OGxU?=
 =?utf-8?B?UDdwd2oxUEFRanJFK09MejJ5cWt4eUFScVJiYzdGQlhVOUtjNmVuaHlFa3pQ?=
 =?utf-8?B?Z1FSTU14OGVIOFBobDRwVjZ0WTJBQVZ6UitXWklId0Y4MHNmRmhHMUFpdGYv?=
 =?utf-8?B?YTR5NnRYOEFMYklickwxTFNjaXZWVTNhM0daVGlqWnorYmdteHMwZC9uQWVy?=
 =?utf-8?B?bHBaUTVkbG93N3gzdnlmMzdpeDFubDk5L0VUTkR0UTJEeldmZUFyQWNNc1JR?=
 =?utf-8?B?bG51enNBQ1JiZ05JZ0twWWwzUlpUZ1hFcjhzUGdFeDhjOS9UckhtQVZGZGV0?=
 =?utf-8?B?WGRyL2sxYXUzQWsvZGRUM0lLWWhEYVgzcld5MHg0UUVDZUVuNmoxY0N3aGNt?=
 =?utf-8?B?UHBSUmMxMHc2bHZYUjZJQ2g2cHZJWDhMMXJaTXREQzNQcVA0dW4vOFF5L0ZV?=
 =?utf-8?B?Rm5zTy9xRWRZcXFQZU45ejhkRE40T3F3SWVGb3JiaHo0UVZ3RkhUSHRBM25E?=
 =?utf-8?B?UEJqd05xcUdEWllJQzZxVVhpaWUzOHIrRnhDMGE3N3YwbUpMUlRwYy96Zmxj?=
 =?utf-8?B?R0JhTlcxKy9sWXdkZVFneGczTTMzMFYvK2FPTytZMVZ2OHJuMU16alFSMmV4?=
 =?utf-8?B?czdNcWFSM2dMS3NXUmhOL2FwcDZsSlZqWUY4enZFaU5LaGM4anI5Zi94U1Qr?=
 =?utf-8?B?YThRQXBhWjlFTlR1emUyTnU2ZWJMTTRUVUFzUk55NFEyaTRjUDhzVXJBQVFH?=
 =?utf-8?B?Vks2Y29oTExZS0Z1NzFXbE5mYVQrRHA2RUZtVkZaMlFvS2hqYUYrTmxZbUJK?=
 =?utf-8?B?QUtYWTR0QS9PVXBCbnQyVDJqbXVGZFBPa1c3RTN5aU1DYjdPNldDZ0VUaktN?=
 =?utf-8?B?SkJ4d0VGbGdKbzUvMmFrSTJhNzhaTFVRdDF5aUNZTnl4TGxPWmZya3FqelRV?=
 =?utf-8?B?THJ2QUl5YzNGa3dGdzNUNVBMTmg5NzNCQkpGMGNYdTR0bmpQMUNINlRTVTR6?=
 =?utf-8?B?N2JpMkkwcmtWeHE3cVJibEd3VFB1alZ6TmVFVjJwdXRpVDhCV2REWWo4REF0?=
 =?utf-8?B?M3RoTTF4T01obU9kMHUxdU51T0VHUm11K3Ardkg4NGZ0S2FURXNnWERtNUJI?=
 =?utf-8?B?Z2p0QkNZUmIzT0NYMCtlSk40MWkyVnBuR0xBTUR6MWMweXpXTlYvcUx4Y0dh?=
 =?utf-8?B?eGZMU3ZDd05sN3hvUDVIUFAwMmNTbzhDU04wQ3BObDBKcFh3Qko0dEF3dDVC?=
 =?utf-8?B?dGdVbTlPckpQZXgyWThYbkVac2xtVnh5MTAwRnE3cWhaQ1dpTXlOQzZzai9v?=
 =?utf-8?B?b3BzbmE2L1A5OXR2ODJxSHBrNDhWWDRpWndFa3VxZzlHNmhnV1lnYStQT1Z6?=
 =?utf-8?B?SGRua3NrQ3RpZFpUdWtKTDE5NytlOWE5LzQ2WWszSVFObmdmY2kxb3dheFZq?=
 =?utf-8?B?bThEQXZRckN6TEFobjdIbnVEbWVqS3AwZElWK2N5Y1ZvM3ZoSUEwWHBiNU9x?=
 =?utf-8?B?M2JBa0VGREdVQzByaTFUa1pKKzBvN0kyZHc0bjhwVU1DbGRxNXduT0dqR1lp?=
 =?utf-8?B?cEpoa0t4bTdWVkRDWDAxTDFZMk9WZE9weVZTRTk4WUx5Z1FuYUNVS21icldx?=
 =?utf-8?B?N0t3VlBxS1dzZWRwYWc3bkpJbFZTQzc4ZmczZU11SEwwSnFUZU56V0NKWVBD?=
 =?utf-8?B?ZUtCRmdHbWhlc3FrZTRNNVpMd0gvOG9Gd1QyTzVlU3B4cW5yR2E5ZHZUUjlq?=
 =?utf-8?B?aDI3YXExcmRJNzZvR0xOQU5FK3JwOWJSTzRLRkkxWGY4V0ZhYXdvU1hySzZH?=
 =?utf-8?Q?jSX6lyAFvRJrPAmdZ03ZuFE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c83fd22d-512a-4d13-4e57-08dbb5f19d67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:42:33.8271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOINbx0ZlVc+BXkyNKYjGB8AMv/fXUwbF3Or2PyJbfLCUt34hGyG+4Z5h4WDn/RtpYims349vfhfnA9PbzNrHmNZKurnwD6ZXlGgWXx/1yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6746
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pawel Chmielewski <pawel.chmielewski@intel.com>
Date: Thu, 14 Sep 2023 16:27:28 +0200

> On Sun, Sep 03, 2023 at 04:00:57PM +0200, Andrew Lunn wrote:
>>> Let me check if I understand correctly- is that what was sent with the
>>> v3 [1] , with the initialization helper (ethtool_forced_speed_maps_init)
>>> and the structure map in the ethtool code? Or do you have another helper
>>> in mind?
>>
>> Sorry for the late reply, been on vacation.
>>
>> The main thing is you try to reuse the table:
>>
>> static const struct phy_setting settings[] = {}
>>
>> If you can build your helper on top of phy_lookup_setting() even
>> better. You don't need a phy_device to use those.
>>
>> 	Andrew
> 
> Thank for the hint Andrew! I took a look into the phy-core code,
> and a little into phylink. However, I still have the same concern

Here I'd like to add that we're planning to try to use Phylink in ice
soon. It may take a while and will most likely require core code
expansion, since Phylink was originally developed for embedded HW and
DeviceTree and doesn't fully support PCI devices.
Let's see how it goes.

> regarding modes that are supported/unsupported by hardware (managed
> by the firmware in our case). Let's say I'm only looking for duplex
> modes and iterate over speeds with advertised modes map as an argument
> for phy_lookup_setting. In this case, I still need another table/map of
> hardware compatible link modes to check against. Theese are actually
> the maps we'd like to keep in the driver (and proposed in [1]), so
> maybe the simple intersect check between them and the advertised modes
> is sufficient?
> 
> [1] https://lore.kernel.org/netdev/20230823180633.2450617-4-pawel.chmielewski@intel.com/

Thanks,
Olek

