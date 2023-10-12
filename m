Return-Path: <netdev+bounces-40430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B157C762D
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 20:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FD51C209F3
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437DC3399B;
	Thu, 12 Oct 2023 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3iOyVRI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87D2AB39
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 18:56:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23A83
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136968; x=1728672968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IMz9z3mHttrLYr2SONtxnIi7WIecaESaVbqU/siTYps=;
  b=g3iOyVRIShaOTf06Sm5VyQhQjtIce6LnCwJ8wlrDROHdcsqZ4XxxN3sc
   01yV2wxXhinV2DJvK1Ezr4C3pFBQGjhwJp6BnrENr7YVEQVCybJGbEkQk
   fpmymXVmAXPOqwA4LIE28Zxc3DoBS081EyLx0lx1AKqoY06Vw/RgmpYDd
   ELPd9doE1wh2hkEQh7tGDmArbCxquSzWnOgsEGI9jSIg+BT8HHxpvYnN7
   eQk8VZ+hK/zIlkgliu0Vi+3jRQq1xhnshDfMYc+g8cdM7RIdz661hYDrh
   Blk4f7mJ1xG2qZfolWI4bhm9yiHAyyJ8V8nhEb8Rk291e85vphxVsc7nn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388880595"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388880595"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870711916"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870711916"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 11:56:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 11:56:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 11:56:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 11:56:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIJFzssKd6og5fr0CQAIt1v6kIuvnKTBpM6wHSo5C3yfItsOvCGQ0T1jLEYSHmwJhHppnubORwY/Cb3nsv1hlwtbRkBQxlkl6LCxwX6m9+zpy5ZPkC30/o/Q6o/pFgKZw1e760bGK4zorP5V9S/M/qpqHQHjVtBWZ8r6VSDFFi+0WTJm3xdsweN9juUlx9hMU0ndinyix2tLHVT7qDuX5evIePx2xK+5LEEZYXYgIQ/uNhzG+er3ibhkOBgSJWvfbBgs0g7s7mFuB4y3KsruBAMzdc2rgIIOb7K8kZT9lfKB452PC0aK26vcQfbON9yrC/CHwXCuEns2/r8BN70cbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb60E0/rA7ofT94fxGlO8//RAH3xBtk3NPkmHq4updc=;
 b=KTJIfKJRXUQ9ARXmQw2sOgh8YgvV5wO9E5SswV9eBNUOGJYGJxkWajz2hgS8eTnqsT/Y9EJng0iTJbOX0lHGfV0hrsccBL3v0W3hM8ApGTOeFIGm7/6jIAVwhvijuEi7CIO9UsUWqq4CnKH/39IIrfnIOWnGSHrI0UoY4B/uUgPcL6tcH220BxhF0TeTGb/EXNPXVZLyySKMOEJPgfnMRWqD9mKQ2lnzSxY9nCW0B48a/9Y0HChKgehnU4OWLKvCCduVMjkFI6LSZzvhx5SGmnG5n+QcRBjVO6l++6FW6kwIMYWxnbVpg09ml9r058ds6s2Rz7vU3XYHzTssfefDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO6PR11MB5620.namprd11.prod.outlook.com (2603:10b6:303:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 18:56:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 18:56:04 +0000
Message-ID: <9080a6ca-0fbe-44b4-bbd0-43c572378532@intel.com>
Date: Thu, 12 Oct 2023 11:56:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3] ice: read internal temperature sensor
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Konrad Knitter
	<konrad.knitter@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<jdelvare@suse.com>, Marcin Domagala <marcinx.domagala@intel.com>, "Eric
 Joyner" <eric.joyner@intel.com>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
References: <20231012071358.1101438-1-konrad.knitter@intel.com>
 <df0e5774-3db7-4f0f-a9e8-c4369c2e6083@roeck-us.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <df0e5774-3db7-4f0f-a9e8-c4369c2e6083@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO6PR11MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: ab02107a-4ec7-4006-957f-08dbcb54e262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ret1NidL0dZtJbCaHjK6geyTP7KUfkTbvGyC800f1Fx2CmyOV7yHkZhGM3PHr6b80so9orpUEH78ydLDEuM5NAF+QzC1gNdhIYGgZxnlkeLNxImheIj9YFXHKHz73zwmxS4fxNIRPatHXKnH0k581lxnCh0WvsasGYYhYZGKxc57+DwBKcEVnaHLuyi6iHAVS8cFavUGnsAAgY4aUL6xCg9zAisWDR5SXvooRPPqllPiccf8hZLUaX13XkjDkMjG3zH5/ViZ74qLQKF0c4+2+tmzhX4eJ0GHaDLI/C1UsoryKH1X8+sjUjkbykON6X0LUQQZf8k5Kmv+jFjz+jv/CjOMbF3Php54jwyIPourX2jpuqs1/bT6VqCkftmrFTJOVNK7VDzMFyvN5uwMLcqMV7b0ILL9l9qNCwMmAWLr+lX/z8LalYVQCFHiHYuiqeCSrC0+MHGKyOSjWbCQM4oVcpynISVQADCVn8vwzJgUCwe1LCHJdBDT8pLOKkXhLwRz19zIp07GEIG0DorIn47fyq67UaTGXzgNTlju08YsiWnjK8GiyfDSreFx3/HhtdkuTb6Rx1jWV6hrxrQFFD6x89Q/NFGegw5uywi8trsJX8H3ENWgcWtOQIB+proRafn3GL7SvX9rzTIm5COCDzWSAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(31686004)(110136005)(66556008)(66946007)(66476007)(54906003)(316002)(6636002)(4326008)(8936002)(8676002)(41300700001)(82960400001)(38100700002)(5660300002)(30864003)(2906002)(6512007)(2616005)(6486002)(26005)(478600001)(6666004)(36756003)(53546011)(86362001)(31696002)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmZDeXFEL3R3QXdxbUtDaFhxZEo0eFBXdHRGcG1WZ1h6cU1BbXJuRlBOUXhQ?=
 =?utf-8?B?NEZ1VkU0c21UVHpVYXR5ck1aem9KRDhTMGtEd29tbndDV1EwMHJOd1RVMzdy?=
 =?utf-8?B?SDhzRXBNa21Sa3YydlRvc2dRc1FIaFkzQllWbHQxU3ZDWmVhVE9vb2ptMUt6?=
 =?utf-8?B?VTc4ZVVuQ3pzY0svdlVFUDViN1pMOXY5N21XdUN6aSsrNllXaVdlZ25RM2pH?=
 =?utf-8?B?NVhQdmN3NWtJcVpHZTZVdmV3UzVWdmJma3JIa3U5NnVvQWxlUVdTZnREcjVD?=
 =?utf-8?B?VitaZ3ZOY3pTa2JZZlVicU16STJRTHBlekdqRVJyaG4rMG0zVDA1Y3FZaEt2?=
 =?utf-8?B?RGlZMENZd2FnbGRyekhVc1UyMUVoM1RXemh4S0tVRzlkeEwyVWt4MnhaWDhX?=
 =?utf-8?B?bThLQllCWXVxd0sxK2VoR2JHYnpxN0p3MEgrK0dNeW96a3dKQ1ZwekpTWnJY?=
 =?utf-8?B?cU40dFdOTlRuOW1TQ0cvMlJFaElkcExhZzlKK2l5NjM5Q0YremJ5N0Q5VVRR?=
 =?utf-8?B?ZjNYVEdzY2U4dFBVTGx4YnlRZXpUUytjVU5NeXpqWHFXOFBwWjRCWTJ1emlp?=
 =?utf-8?B?cGx0YkFCTTZjRDNsWGl6WVEyVmVJNTVNNllwUnlyQUVYNG9Pa1M3N2FwcHpV?=
 =?utf-8?B?OXhhNC9CTGpkdEo5ZG1vbXU1M21YNi93bzJSY3pnTzVjb1F0Ym9TVlJLYXFD?=
 =?utf-8?B?ZG9mbEkySkN5QzlMVytwMmxzaWtXQm9SVjRrKzM2UkdZZUZ6ZUNrWG11aHNL?=
 =?utf-8?B?aXRpZkNBMWZGcnNlSDhET0RzdTZOanhiZzRGM2gwQ0F3ZjJRakxvV3FvR0cr?=
 =?utf-8?B?enc0WnN5a08rT2FPTzRHaUcweHpBcng2WE9QRElOY011VFhJS25SWUg2TTg0?=
 =?utf-8?B?alF0UCt3dXJ6SDRhenlqZGVpVEVMdTBjNkNEWkZPZittODVMT0RxZDdVSFNV?=
 =?utf-8?B?elM3YmhlUGxma2liOXJ1cWc1S1cvYThpSkhKL0VFNW5VUjlmTmlualdWWWxo?=
 =?utf-8?B?OGpIVmp3anBxOG1HU0J0QXdaTEdid2x1UjlBSUlLeXUybTdTSElwNkswbk1R?=
 =?utf-8?B?VHdIOWRoalQ5UkFzZ0dYbTU5Sk1RU1BWT3hta0ZMRThCeGNUVEE4MEk0VmpC?=
 =?utf-8?B?MXZpNXZOeDZnYnBCRXlOVWhUVGFSNElkSmlvYmc3dXp3TTRVUERxTmpHZC91?=
 =?utf-8?B?YjdDOU9zdGZYYnY4Q2hFcEhWVGVnTndxaGJCRXRRSzFOQ2NiOTQvWUZ0UXo1?=
 =?utf-8?B?YlF2VG9CMmNrQkFPOUxsM2xBMy9FS3QzMmtQOUpCZzM1Y2ErbzdEb0wwTWow?=
 =?utf-8?B?UVVvSXlHMUppSnZjb002K1FQdy9xQlgyRlltamoxcUk4SWVLbk9OSmIwK3Zy?=
 =?utf-8?B?eWtlelRoRmRqdkdrcC9lNVBoaG41bEFOZjVkQzNIN0w5alVwMXUyZDBNMjUw?=
 =?utf-8?B?aWVzUUhBdXluQXR1aHJtRzFPU2IzK3NCZkc4bmlHYmZhbHVobkxDUXJkYnZa?=
 =?utf-8?B?aGxwVU1hLy8xVjRIazBKcXVDeVNmUTBKYUtzZWNydS90SFFVbzdSWHdpTEU5?=
 =?utf-8?B?LzNVdjM4VHhsSDFVMS96VDBiNlNCQVNFVEVPVFdjUE5raDdGckxCV3QrZm43?=
 =?utf-8?B?NXVaY2loSFlrbU1OVGRmOHhtMG1pV2RtQnhxQ0hjMXNrcUZCTGloa21LWnBi?=
 =?utf-8?B?SlRURWZGSDZCYmVrRkdzSnVJcjVTWkJVZy83WjYzaGpOVURwTGhSWFVUdVlR?=
 =?utf-8?B?eEt2dG1JUWJIZWR6T0FuVHh2V1I1dkVRRDFXVGlON1RBWmRiVTFTQWU2dUgy?=
 =?utf-8?B?NUI3VWhOVmorRlVsVnNsYll2d2RCZ01VblM5OGVWTiszOURKd29BUUF3WWlW?=
 =?utf-8?B?clBsdFpMTU1UVVg0Q2pLMzJXY3FXcUlJZ09CN3VCV3NEampPR0FMY0hSWVFD?=
 =?utf-8?B?TVlIOHNLOHhlODZrbjJNQm81SVdUKy9UdHY1bC9HWDBWejRtNVpDSXhobTM5?=
 =?utf-8?B?cndrR0dZTDVlcUM5d2ZTQW5VWHNqKzRtTDFQVmQwVUp4dWxBUllLOTZqQkxF?=
 =?utf-8?B?RGVhVmhvWktOK2lYdml5QVYxZnd5OFVlWFBYNGs2QUhVWlFLSk1kVnRkUzB4?=
 =?utf-8?B?d2htUEFqZjhIUVExMXRUYUxkNURMM3RwYW1iYnZJR05QL3JqL25KUi9sNElM?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab02107a-4ec7-4006-957f-08dbcb54e262
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 18:56:03.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y5JOmsl7jOp+yw7ViZd3JdxH6pYfgV3rkc6jDSXa8R499rud6FXYRH21aZBM1gpM4/pDSa1TRSTxHb+Do84fYu95Smh3b9S1OffLJErwKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5620
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 10:29 AM, Guenter Roeck wrote:
> On Thu, Oct 12, 2023 at 09:13:59AM +0200, Konrad Knitter wrote:
>> Since 4.30 firmware exposes internal thermal sensor reading via admin
>> queue commands. Expose those readouts via hwmon API when supported.
>>
>> Driver provides current reading from HW as well as device specific
>> thresholds for thermal alarm (Warning, Critical, Fatal) events.
>>
>> $ sensors
>>
>> Output
>> =========================================================
>> ice-pci-b100
>> Adapter: PCI adapter
>> temp1:        +62.0°C  (high = +95.0°C, crit = +105.0°C)
>>                        (emerg = +115.0°C)
>>
>> Co-developed-by: Marcin Domagala <marcinx.domagala@intel.com>
>> Signed-off-by: Marcin Domagala <marcinx.domagala@intel.com>
>> Co-developed-by: Eric Joyner <eric.joyner@intel.com>
>> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
>> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
>> ---
>> v3: add SPDX identification to ice_hwmon files
>> v2: fix formmating issues, added hwmon maintainers to Cc
>> ---
>>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
> 
> The code seems to be unconditional, but I see no added
> dependency on CONFIG_HWMON. Does this compile if
> HWMON=m and this code is built into the kernel, or if HWMON=n ?
> 

ice_hwmon.h file needs to check CONFIG_HWMON and provide no-op stubs, and...

>>  drivers/net/ethernet/intel/ice/ice.h          |   1 +
>>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  28 ++++
>>  drivers/net/ethernet/intel/ice/ice_common.c   |  57 +++++++-
>>  drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
>>  drivers/net/ethernet/intel/ice/ice_hwmon.c    | 130 ++++++++++++++++++
>>  drivers/net/ethernet/intel/ice/ice_hwmon.h    |  10 ++
>>  drivers/net/ethernet/intel/ice/ice_main.c     |   5 +
>>  drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>>  9 files changed, 237 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.c
>>  create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.h
>>
>> diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
>> index 8757bec23fb3..b4c8f5303e57 100644
>> --- a/drivers/net/ethernet/intel/ice/Makefile
>> +++ b/drivers/net/ethernet/intel/ice/Makefile
>> @@ -36,6 +36,7 @@ ice-y := ice_main.o	\
>>  	 ice_repr.o	\
>>  	 ice_tc_lib.o	\
>>  	 ice_fwlog.o	\
>> +	 ice_hwmon.o	\

This should be ice-$(CONFIG_HWMON) += ice_hwmon.o

>>  	 ice_debugfs.o
>>  ice-$(CONFIG_PCI_IOV) +=	\
>>  	ice_sriov.o		\
>> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>> index ad5614d4449c..61d26be502b2 100644
>> --- a/drivers/net/ethernet/intel/ice/ice.h
>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>> @@ -650,6 +650,7 @@ struct ice_pf {
>>  #define ICE_MAX_VF_AGG_NODES		32
>>  	struct ice_agg_node vf_agg_node[ICE_MAX_VF_AGG_NODES];
>>  	struct ice_dplls dplls;
>> +	struct device *hwmon_dev;
>>  };
>>  
>>  extern struct workqueue_struct *ice_lag_wq;
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>> index 1202abfb9eb3..3c4295f8e4ba 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>> @@ -117,6 +117,7 @@ struct ice_aqc_list_caps_elem {
>>  #define ICE_AQC_CAPS_NET_VER				0x004C
>>  #define ICE_AQC_CAPS_PENDING_NET_VER			0x004D
>>  #define ICE_AQC_CAPS_RDMA				0x0051
>> +#define ICE_AQC_CAPS_SENSOR_READING			0x0067
>>  #define ICE_AQC_CAPS_PCIE_RESET_AVOIDANCE		0x0076
>>  #define ICE_AQC_CAPS_POST_UPDATE_RESET_RESTRICT		0x0077
>>  #define ICE_AQC_CAPS_NVM_MGMT				0x0080
>> @@ -1393,6 +1394,30 @@ struct ice_aqc_get_phy_rec_clk_out {
>>  	__le16 node_handle;
>>  };
>>  
>> +/* Get sensor reading (direct 0x0632) */
>> +struct ice_aqc_get_sensor_reading {
>> +	u8 sensor;
>> +	u8 format;
>> +	u8 reserved[6];
>> +	__le32 addr_high;
>> +	__le32 addr_low;
>> +};
>> +
>> +/* Get sensor reading response (direct 0x0632) */
>> +struct ice_aqc_get_sensor_reading_resp {
>> +	union {
>> +		u8 raw[8];
>> +		/* Output data for sensor 0x00, format 0x00 */
>> +		struct {
>> +			s8 temp;
>> +			u8 temp_warning_threshold;
>> +			u8 temp_critical_threshold;
>> +			u8 temp_fatal_threshold;
>> +			u8 reserved[4];
>> +		} s0f0;
>> +	} data;
>> +};
> 
> Kind of surprising that this doesn't need packed attributes.
> 

The layout is all u8s which pack correctly without using needing pack. I
think in principle it probably could use __packed to clarify the intent,
but I think the layout is the same regardless in this case.

>> +
>>  struct ice_aqc_link_topo_params {
>>  	u8 lport_num;
>>  	u8 lport_num_valid;
>> @@ -2438,6 +2463,8 @@ struct ice_aq_desc {
>>  		struct ice_aqc_restart_an restart_an;
>>  		struct ice_aqc_set_phy_rec_clk_out set_phy_rec_clk_out;
>>  		struct ice_aqc_get_phy_rec_clk_out get_phy_rec_clk_out;
>> +		struct ice_aqc_get_sensor_reading get_sensor_reading;
>> +		struct ice_aqc_get_sensor_reading_resp get_sensor_reading_resp;
>>  		struct ice_aqc_gpio read_write_gpio;
>>  		struct ice_aqc_sff_eeprom read_write_sff_param;
>>  		struct ice_aqc_set_port_id_led set_port_id_led;
>> @@ -2617,6 +2644,7 @@ enum ice_adminq_opc {
>>  	ice_aqc_opc_set_mac_lb				= 0x0620,
>>  	ice_aqc_opc_set_phy_rec_clk_out			= 0x0630,
>>  	ice_aqc_opc_get_phy_rec_clk_out			= 0x0631,
>> +	ice_aqc_opc_get_sensor_reading			= 0x0632,
>>  	ice_aqc_opc_get_link_topo			= 0x06E0,
>>  	ice_aqc_opc_read_i2c				= 0x06E2,
>>  	ice_aqc_opc_write_i2c				= 0x06E3,
>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>> index 283492314215..e566485a01b2 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_common.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
>> @@ -2462,6 +2462,26 @@ ice_parse_fdir_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
>>  		  dev_p->num_flow_director_fltr);
>>  }
>>  
>> +/**
>> + * ice_parse_sensor_reading_cap - Parse ICE_AQC_CAPS_SENSOR_READING cap
>> + * @hw: pointer to the HW struct
>> + * @dev_p: pointer to device capabilities structure
>> + * @cap: capability element to parse
>> + *
>> + * Parse ICE_AQC_CAPS_SENSOR_READING for device capability for reading
>> + * enabled sensors.
>> + */
>> +static void
>> +ice_parse_sensor_reading_cap(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
>> +			     struct ice_aqc_list_caps_elem *cap)
>> +{
>> +	dev_p->supported_sensors = le32_to_cpu(cap->number);
>> +
>> +	ice_debug(hw, ICE_DBG_INIT,
>> +		  "dev caps: supported sensors (bitmap) = 0x%x\n",
>> +		  dev_p->supported_sensors);
>> +}
>> +
>>  /**
>>   * ice_parse_dev_caps - Parse device capabilities
>>   * @hw: pointer to the HW struct
>> @@ -2507,9 +2527,12 @@ ice_parse_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
>>  		case ICE_AQC_CAPS_1588:
>>  			ice_parse_1588_dev_caps(hw, dev_p, &cap_resp[i]);
>>  			break;
>> -		case  ICE_AQC_CAPS_FD:
>> +		case ICE_AQC_CAPS_FD:
>>  			ice_parse_fdir_dev_caps(hw, dev_p, &cap_resp[i]);
>>  			break;
>> +		case ICE_AQC_CAPS_SENSOR_READING:
>> +			ice_parse_sensor_reading_cap(hw, dev_p, &cap_resp[i]);
>> +			break;
>>  		default:
>>  			/* Don't list common capabilities as unknown */
>>  			if (!found)
>> @@ -5292,6 +5315,38 @@ ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 *phy_output, u8 *port_num,
>>  	return status;
>>  }
>>  
>> +/**
>> + * ice_aq_get_sensor_reading
>> + * @hw: pointer to the HW struct
>> + * @sensor: sensor type
>> + * @format: requested response format
>> + * @data: pointer to data to be read from the sensor
>> + *
>> + * Get sensor reading (0x0632)
>> + */
>> +int ice_aq_get_sensor_reading(struct ice_hw *hw, u8 sensor, u8 format,
>> +			      struct ice_aqc_get_sensor_reading_resp *data)
> 
> Are "sensor" and "format" ever going to be != 0 ? If not,
> those parameters are just noise.
> 
>> +{
>> +	struct ice_aqc_get_sensor_reading *cmd;
>> +	struct ice_aq_desc desc;
>> +	int status;
>> +
>> +	if (!data)
>> +		return -EINVAL;
> 
> This is never called with a NULL pointer. The check is pointless.
> 
>> +
>> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_sensor_reading);
>> +	cmd = &desc.params.get_sensor_reading;
>> +	cmd->sensor = sensor;
>> +	cmd->format = format;
>> +
>> +	status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
>> +	if (!status)
>> +		memcpy(data, &desc.params.get_sensor_reading_resp,
>> +		       sizeof(*data));
>> +
>> +	return status;
>> +}
>> +
>>  /**
>>   * ice_replay_pre_init - replay pre initialization
>>   * @hw: pointer to the HW struct
>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
>> index 4a75c0c89301..e23787c17505 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_common.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_common.h
>> @@ -240,6 +240,8 @@ ice_aq_set_phy_rec_clk_out(struct ice_hw *hw, u8 phy_output, bool enable,
>>  int
>>  ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 *phy_output, u8 *port_num,
>>  			   u8 *flags, u16 *node_handle);
>> +int ice_aq_get_sensor_reading(struct ice_hw *hw, u8 sensor, u8 format,
>> +			      struct ice_aqc_get_sensor_reading_resp *data);
>>  void
>>  ice_stat_update40(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
>>  		  u64 *prev_stat, u64 *cur_stat);
>> diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.c b/drivers/net/ethernet/intel/ice/ice_hwmon.c
>> new file mode 100644
>> index 000000000000..6b23ae27169c
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/ice/ice_hwmon.c
>> @@ -0,0 +1,130 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2022, Intel Corporation. */
>> +
>> +#include "ice.h"
>> +#include "ice_hwmon.h"
>> +#include "ice_adminq_cmd.h"
>> +
>> +#include <linux/hwmon.h>
>> +
>> +#define ICE_INTERNAL_TEMP_SENSOR 0
>> +#define ICE_INTERNAL_TEMP_SENSOR_FORMAT 0
>> +
> 
> Personally I very much prefer
> 
> #define<space>NAME<tab>value
> 
> but obviously that is a maintainer decision to make.

I think we typically do align with either spaces or tabs when using
multiple definitions.

> 
>> +#define TEMP_FROM_REG(reg) ((reg) * 1000)
>> +
>> +static const struct hwmon_channel_info *ice_hwmon_info[] = {
>> +	HWMON_CHANNEL_INFO(temp,
>> +			   HWMON_T_INPUT | HWMON_T_MAX |
>> +			   HWMON_T_CRIT | HWMON_T_EMERGENCY),
>> +	NULL
>> +};
>> +
>> +static int ice_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>> +			  u32 attr, int channel, long *val)
>> +{
>> +	struct ice_aqc_get_sensor_reading_resp resp;
>> +	struct ice_pf *pf = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	if (type != hwmon_temp)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = ice_aq_get_sensor_reading(&pf->hw,
>> +					ICE_INTERNAL_TEMP_SENSOR,
>> +					ICE_INTERNAL_TEMP_SENSOR_FORMAT,
>> +					&resp);
>> +	if (ret) {
>> +		dev_warn(dev, "%s HW read failure (%d)\n", __func__, ret);
> 
> Up to maintainers to decide, but I do not support error messages
> as result of normal operation because it may end up clogging
> the log if the underlying HW has a problem.

Depending on how unexpected this is and how common its printed, I would
make it either dev_warn_ratelimited or dev_dbg.

