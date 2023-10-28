Return-Path: <netdev+bounces-44949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B739B7DA45E
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 02:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BC41C2114F
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D52F38C;
	Sat, 28 Oct 2023 00:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkURfaS1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51C28FD
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 00:30:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC29129
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698453035; x=1729989035;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zI4kLguYkA2oG8WXsYT2gPNFf2C1h3bBP3iRNUGbeD4=;
  b=EkURfaS1VoXBRY0BHoLzO6Mte00KNc9pkuoa0+sz8Z9FGirNfq8X3sZr
   Tru/ikQ0BR3iMo7sEjIHSQpX0716jzUXREhtAN3XAodreZCXdrxe0xxrO
   11qXDO7lDTsTSRy8seQSkq8Rc3ASS5vbXxZ5+6m8jY2kipvPfNxI46fAH
   a7D3FQuUq2K5CBrVOha48R6ANRl8SJ/IqzTGPZeENsUl+7ZaXKupUWACO
   gvmvq+Vl+va/V9C0VklK9/ntnbRIWSZLNqXGnsuWpO7UXGCGtB5BHmlwp
   ulUjQPC7F7ftXig0HQFeMr+pVh6ggY+H6vtbuY3+Y8953gJyhho+z4u8e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="9408118"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="9408118"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 17:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="736242866"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="736242866"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 17:30:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 17:30:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 17:30:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 17:30:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5XVesWpnT7kde79vRLfVFa5TBEpC36Is/2eYkKZi6anrmLI32jKQ/rqyzjqJcEeMajhjQDG9YXi/1sMo2c2kXgInfw8YnYXXLUko9myhKhr6+VoNL/pB4RfgUzEomK4stJipTzwme2/cZ+t+8sICP8U0TkrL5Zd1X9ybbTnTFuzi1NTHGuKBZqqAVxHPkAjnoyH8146nKRgCtZ3QBZa94jTfp9XURSkC2kwn750HaTmLhK0Z4Sk3vUwKkyZ6EJ0D+cTRyjmzv7aebFvyBg5rGYrh3Z7sRKYUMgmaJLvIez5/u6GqGe5ke1guzZ3TdPmE/SdK2X+yxsx8CoGUwbYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtDNOe41bFU7pRWavZsmV/FNECu97UV3G+3IkQEjRKU=;
 b=ZH4dmo5LIjfamLOCke5+/shNrq0zSPitZrEZY7QswOD6BmHI3iEH1HsZ4IWxLjh+foiwQHYXCFpBP2wjM0g0OWJ40Xa7evCZTyW4ZQ8aJrIpqqg9eQY0agm5LKYVBXlMVuylC2SOG9X5gEGMuvtvzHlhEgBaj5E0ycYva1+24U4yUeWoJh8vFkGe8V8HwCU2hJk6rGTnV2Fp6ihMLWQdoH1IwDgbb/oVNA/ufiHvV3+x72HgmSx+y0xMxYGZxm7XAH2/3kV6OqWKlts1Emwd6vlOnn7WijY6Fozs8ocEvJc0EbkVafovIP07aa1NrG8lCRLami9CIvNi8tNq34QxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Sat, 28 Oct
 2023 00:30:29 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::3728:58a4:3a8b:3ebb]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::3728:58a4:3a8b:3ebb%5]) with mapi id 15.20.6933.019; Sat, 28 Oct 2023
 00:30:29 +0000
Message-ID: <1ad75009-7e4e-af8b-e986-46d46c86c71d@intel.com>
Date: Fri, 27 Oct 2023 17:30:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 0/3] ice: restore timestamp config after reset
To: Jacob Keller <jacob.e.keller@intel.com>, <netdev@vger.kernel.org>, "David
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Karol Kolacinski <karol.kolacinski@intel.com>
References: <20231028002322.2224777-1-jacob.e.keller@intel.com>
Content-Language: en-US
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20231028002322.2224777-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|IA1PR11MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8cd842-49c4-435d-c83e-08dbd74d1679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5krap2wzhiw/SJllEmIPyAO56kC3BdLr9aYXGD1F7XLV0VR/3puHoZ+xt/8Q7Wpu2K2gLFLj+1GYGNXz3V3ZUjhI0FVKbhb/u8mFypsfaqnPR36w1CluwvE2CC+B7KRus7CEaWTg+AIfQStjisHVW92T2tQ9EPhaarAMhqMghn+AR/u2HpIqY80S9uvhKxD9V21S9FEa2ejvdPGU4pw/+rEOe24K3i22VAhkEDVWYQFWdDhS8pjziRybGgynIV0hlsshhTh77AkuKzfBUlkXJEl59qehsQL29BLGtUnwx2NBp6A+qO2Aeh1Eh7+zcXVHFSHdZoSSgu0sfdeD+E2rev3rMTU9lTonp2rOSJuY7OcymbrnYAGdXMMZVBM5d93bFp0VCbfhQnCZc0J6BnqGRy1UQsRsdRffYbXojUi9QtwscTM5JeW3whUCpxjgeWlYLuwkpsKkxvwv/UM9Ad8Y+fEx1CBYlaKe8aMR+dyeDWU7rT9W4v75Ttx+csZCqeTJjnzLEch1lb+0TfZw7fMPwFbPusJDtMBDNHpp0Iw2QQG+YQxMOWw6pDrOrS2uZDspm2FpJRrUzKFEF+ujomad2xq+iHr9CxOXekVF8/RDKtdMIrgV3juhrFUsGBDiw9+qF4Qdv7+tecl+KuKVzqQ9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(31686004)(86362001)(44832011)(2906002)(8936002)(38100700002)(4326008)(41300700001)(36756003)(8676002)(53546011)(107886003)(26005)(2616005)(31696002)(82960400001)(6506007)(5660300002)(316002)(6486002)(478600001)(6512007)(66946007)(66476007)(110136005)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZVVy9pUGE0TjBLK3laOExxMVVielRSMFBGNUh3SG5rL1EyZ0t3MWZKazlv?=
 =?utf-8?B?VlBibzlMU2U4citKVjEyUjQzYjNSd09zL3JqQUZqQ0pOVFJPcEQ0TUVTZERO?=
 =?utf-8?B?dFRTZXZ1RmhMeGJmWmthdEZNR3ZTWWdjT0NkbnA0MWNYV2xoaGtYR3hSazla?=
 =?utf-8?B?d0JCMEdXdWZQYWorQ3NqT2p3UUdGbUk0d1VkMTdxU1N4T092bUl6VnFNdlRy?=
 =?utf-8?B?ZGY2Wk1wR052cHV0Y0lYU2luMFl5cS9rd3kvMDJOSG4xeDFqWldYTGNhTElK?=
 =?utf-8?B?MmYzbnF5Umw0L0RJYzZOelVIb2dwLzhYM0QvYUlNa2JiZlVRcnBwejl4M3Nv?=
 =?utf-8?B?YUROdFQ0ZFk2SHBvcWdIa1NoaHNsWXB4V2tYeGN5d2xnVCtnT1lsaWVpbkl1?=
 =?utf-8?B?NHZOS2FqbjZ0RW1RS01keklBUDFEMTlXenBvdG1lY29YYmxzbHdtYVFxS0ZO?=
 =?utf-8?B?T3ZXaWR3eDkwOHlMWWdHOGVWbXBFbS9tbEJlMTF2WUdzWjErUFhBVlhWejYv?=
 =?utf-8?B?RUF1dGxlaTNXWlFrb2JtcFVNaXdyTFd5UGhLSmpZQW1KM1o4TTMrWmx0dWlH?=
 =?utf-8?B?bzRwU2V3Q3Y3bThOR3EzN21DR1BmcmdqOURXRTNVdXhqR1NtdUxIQXFUTHdz?=
 =?utf-8?B?MmNmeDdUbFVBT01acm5ncCtaZS9BL1dpTzlHUVhBa2I5d1B0T2pWY3pjTjVS?=
 =?utf-8?B?WkJkSUxrcGwrY3M5allaV2hMUE8wTlpDZHV1LzdkbGdTbkxzeEUvYzd0Q2Mr?=
 =?utf-8?B?YWJSU3Q3TjlHSldURXM3WDNtckdRV0dueXVOdmkrZldwUnJrWnFPV2hXNkJ2?=
 =?utf-8?B?SmhVUzVkNVo5RUZmN21QdTJEK1FNUHFxUFl5djE2UUZmTGUzRHhFNTllVmlG?=
 =?utf-8?B?dnJWTW5FSE1nQmxSNVloNGZPK1BlOFREZXNvNkFZckwrNDI2cDdVMGM0UDZN?=
 =?utf-8?B?bmJiME0rdThBR0UvakxYa3Q2Vmt3ZzFSbTlEQ3d6dDlXeVFJMnl4Q2xSWkJB?=
 =?utf-8?B?T0s3cE1CSUZaQ05jMGRWZVFMOU9rQXEvdzJDeXA0akRPeENIMDZ5ay9IZkVB?=
 =?utf-8?B?WW5IOGxFYUxVY3RUdllCNmdJYkYyRUsxWmJHYUJkZUhlL08zV0FDTFRoNWxQ?=
 =?utf-8?B?NldXeWFGN1dSMXhLYk42eVdGNHBUSG5iM000Y3A0SXVoNzdUK2dxQ21TV0hT?=
 =?utf-8?B?MmMrTmJFd1J1S2ZKbjJ5cEx6cm9JOVdOOGY4anJLYm5nR2xNT01aL3pNMm5p?=
 =?utf-8?B?bWh3aFhHL1FNb3paN1pYQWZERVllMzMwem5ETEhTOG84NkYvamRkbTVRYVJS?=
 =?utf-8?B?RVlNU3BqQUN2NWxzVmpDYXZqK3BxUHBLNHIvQ2x3Y3psRXk4R0Z2MVRUTG5r?=
 =?utf-8?B?aWtRWU1IVmlhR0xrL2xXTFJJNmZKREZLYkRLWGhZMWJNcHF2QjR2YzlDdXhY?=
 =?utf-8?B?K016eHhXQ0lVVG01ek12V3FNdzUyRUJ0UjU5eWpQUkVPRVhDUHlyRnY0VnhD?=
 =?utf-8?B?KzZsVm1YVkk4QmhnODdXeU0zNlFzOFdHdk82SFltcDBkcURGZnFRZnZVN3lt?=
 =?utf-8?B?aUR2aHQxWHpMLzdKZElZQTZqUm81SS9NWlBGR2JrNDR2UE9oRTlZbDhZeTYz?=
 =?utf-8?B?ZmFjWXlYQlNVQWlEWmpCbjJJM2ZlMmlJQ05CYmV5VXJHeDNMRVc1TjNTNy9D?=
 =?utf-8?B?Sjl0VHBWdVJ5RHRTb3FLTUV1VENPU3paendMaTd2R3NxN3p2SDRRbk5OT2Za?=
 =?utf-8?B?VXpUb2UyYjJCT0Z4c3lkL3hSWXA1NkpobWcyaGU5SzEvMWhhcUw1SW9zUmVV?=
 =?utf-8?B?cTB2dmFXUWpURG9HVEZOdEg5Y0VHZFlzVVE5YTBSK1JsMHlNWU9sY1A5MzJi?=
 =?utf-8?B?b29kTkJwcGY4ejJJRy9BNEVkWHRDTUxxaXRicUUxUnlGK0ZMU3ROdlN2enlx?=
 =?utf-8?B?Z3Facjh6YlpuNFRSV1JhanExZ01QcEdhdTh4SFNQTlBNSGZidW4xaTlEaFV1?=
 =?utf-8?B?c0JuUGlXN1Zad3JXdTBKSVlicnJGZnduUGpnNTZvVnJkOEpRR2NJamJ4b3cw?=
 =?utf-8?B?Y1JFN0dsZlg2QmkyTGR5VTFldFJvK1pxZEw1V2IrRmliWmVHWThNd1lNU0lW?=
 =?utf-8?B?MkJSVGhjQzIwWXMrM3pZRVo4akNRWDQzYm5SYTRkREIxUmNiYzZlV0gxQnNV?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8cd842-49c4-435d-c83e-08dbd74d1679
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 00:30:29.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYYthaPdtbV1RNVu+J+iJGrv1BbDiwj/tHX8YQdP9Dr0qaDUl9YCaikAIvfMUn32o68HolA/XkIVehyghjaWBb1v7o/oT8asWmEioWMgtrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
X-OriginatorOrg: intel.com

On 10/27/2023 5:23 PM, Jacob Keller wrote:
> We recently discovered during internal validation that the ice driver has
> not been properly restoring Tx timestamp configuration after a device reset,
> which resulted in application failures after a device reset.
> 
> It turned out this problem is two-fold. Since the introduction of the PTP
> support, the driver has been clobbering the user space configuration
> settings during reset. Thus after a reset, the driver will not restore
> timestamps, and will report timestamps as disabled if SIOCGHWTSTAMP ioctl is
> issued.
> 
> In addition, the recently merged auxiliary bus support code missed that
> PFINT_TSYN_MSK must be reprogrammed on the clock owner for E822 devices.
> Failure to restore this register configuration results in the driver no
> longer responding to interrupts from other ports. Depending on the traffic
> pattern, this can either result in increased latency responding to
> timestamps on the non-owner ports, or it can result in the driver never
> reporting any timestamps.
> 
> This series fixes both issues, as well as removes a redundant Tx ring field
> since we can rely on the skb flag as the primary detector for a Tx timestamp
> request.
> 
> I opted to send this to net-next, because my primary focus was on fixing the
> E822 issue which was not introduced until the auxiliary bus which isn't in
> the net tree. I do not know if the fix for the overall timestamp
> configuration issue is applicable to net, since we have had a lot of
> refactor going into the driver to support auxiliary bus as well as in
> preparation for new hardware support.
> 
> I'd like to see this merged so that the timestamping issues are fixed in
> 6.6.
> 
> Jacob Keller (3):
>   ice: remove ptp_tx ring parameter flag
>   ice: unify logic for programming PFINT_TSYN_MSK
>   ice: restore timestamp configuration after device reset

For the series:

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>



