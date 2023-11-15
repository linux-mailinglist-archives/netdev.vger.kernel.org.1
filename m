Return-Path: <netdev+bounces-48191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937A47ED1D4
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 21:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFCAB20D3A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083E3FB19;
	Wed, 15 Nov 2023 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnZPN0d4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7329498
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700079120; x=1731615120;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k2oNp4E6X5gfPzgfKsqf+KhnTTsszSZVMqVBhGgZ+T8=;
  b=TnZPN0d43QhTrUNYK0dB+RKLNr4dCI+f8awy9yGdNtyARUJANgC3Acg/
   UpBvADH1CSQsndg703JxjHRcJ1SAU9kW3oA556mzqk/FayCyq2WuVL6sd
   7/sU0+89tU55iOmiHTBgZSDKovwhB834OIe+3d1bFOJVW6ccM2XP3ET/P
   HJTJ63KwdQja2foSXrLxfkXHaLo/xJ3TpZlBwguaSqEwV3l9+JsACVyX/
   fVVVCMKKWaIoGvxE1CCsbgz16PWa8r0bEcWSyJDCPT9kebvc6bB2aew9P
   ZmeOfC/2Xi5gcSDRqQxXpnyzuLYikA/q784hksupJmb5HQuVJ5z0hlJIY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="390744827"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="390744827"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="12883655"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 12:11:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:11:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:11:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 12:11:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 12:11:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS4ubjU7JoaYHkN3Jlb75m0SrV++ZOY7BNuW2SRPjHAvFtqNcELuvG8CEvbmTtM1Ks6AP87UbAz3nmics6g95QfYFRN2pYD1BodmdmID1xPCVQw6xJafXKMlHv4IYfpgHyqyAaKP3NaWPWWmGE7QTIy85Bv+6Q8GE5TLPxyLQTZ3x8F2j1slN+9sWnonlZafWPtKLHyh3ovD9vjnslEmeqAV9R6pAwqE2YMU+W20dFbqd4UJAhCYOlAH2jGLii+kePhDn03T/c/4G19MEjDHk0TmLQ4LaAXIoomRN2HqVhnNsnoXbraPrATEYiGkQlhuU+z3/1WGAJLTBEWiQnqlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+sg8BsZ5KfXnYRKtMkDwdM3hx2bevB/WdDJHBY1/KM=;
 b=J82W9Zqs7Ut0JL451rfKQCPP4Tj/++tbhz+EbIqHPcYkAbEtynbPg+bN+nVSCOGdpUVq42KM7h5l0GCgVxunCjXgCJMI93iu7j/wB1ocVTdABEP4X1K33IF/GTuoDtW8GlGUb3Wy7LqpkfgM/cuUY4y1svp/ZFw3+RkXqpCeVd506Zr1+tRg7eJAUtdpE5se97971/IqqlI6eKofx/Np5WpLQFOu+zMnJWHmxhyKhUn3fJGAzn54Khu227ANnLalrLn25RGeNG/QNcokPgMOikHstn0OtULPlX/ihft8u7qEFvxTPdQTDemINu/P5uB2q2ApCEEr+MoBS4pUNke0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7480.namprd11.prod.outlook.com (2603:10b6:510:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 20:11:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 20:11:48 +0000
Message-ID: <48716356-17ce-4a44-9510-a338595605eb@intel.com>
Date: Wed, 15 Nov 2023 12:11:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next 2/8] devlink: introduce __devl_is_registered()
 helper and use it instead of xa_get_mark()
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <jhs@mojatatu.com>, <johannes@sipsolutions.net>,
	<andriy.shevchenko@linux.intel.com>, <amritha.nambiar@intel.com>,
	<sdf@google.com>
References: <20231115141724.411507-1-jiri@resnulli.us>
 <20231115141724.411507-3-jiri@resnulli.us>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231115141724.411507-3-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:303:dd::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 5529a6b1-96e9-4411-d9b0-08dbe617191e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dDSRV18IN9Hc7vbFD8Zhd8RmhLCbjtkjVAF1Fk1/ScIpLoenQf/fFLqCY6QiyLESkwmP4PiFN/rnUiUtm3fpkyhh5Ucx5mh+XrhqjZk/HOXLE03Fsj+OgxGxwRJ8kMTxdfn5iclLWOixpZzw92ZmaciC+bOP8jSJcajERqShAaQDyNd02qu6tSjucSiIqNLzUQwo7pPzdy9wqJwsIMVNu1JrULYDzwolnwO1A7nxQtV1KaEJk0ig3QO+Z9jv2aWuRUE45bjTVImvtJvWC+GXrqoOhL6+tyoGN1B+hu3XAFOQGs/9FVGsUdSABXKNB5TCWGlXXPoSFa8UbYKnA8ApDIFzQr77Fd7pv/08fbWvsPtKgehXCwCIDjiDuJpGD+t8D+ketSb3KIlLEdMBUG96D6j5Gdr/bjiJWGVeRHZhzPQ3mCb/qREGTbiz/IVuXne/9330UrgkiNHGDLjldeerfBYpPrFrVEokEBTxqZ/XRxTXCjzgcT2eyI7Mmdq9lDqRARvx/75KAc7aBIvhWr2RO7DJgAL0OUn2hW5mX1w6t9PeSi3l1VqMTllhCYkxJv8Y82lNvJRpcnmT+5s7PTD0LYeOnza7Z7+ciVnufND8GDlmDE+zzXi8Xipp9p0D0nsUTNW0okMgpt6BsLUdk9Hpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(31696002)(86362001)(6486002)(36756003)(6506007)(8936002)(8676002)(4326008)(316002)(53546011)(6512007)(5660300002)(7416002)(66476007)(2616005)(66556008)(66946007)(31686004)(4744005)(2906002)(26005)(83380400001)(41300700001)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhCN2tJYWhoS1VSTkpLSW9BbFBOVDBYaTNZUVozSlY3MFRJTUsyRVRmdDNO?=
 =?utf-8?B?QWF0L2xwSDF6Tzl2VmZHa2pWU1Izbk82NzQyWEtyQTkvMG1GbnYxSFB2Q3Bq?=
 =?utf-8?B?MElrQzNDa2g0Qjc3REt0OTQrdEZIT21COTFMa1BlNGVwNjZEMlpkbW9SY1VC?=
 =?utf-8?B?Y1IwNkp0NUNoVk90RGtpLzlueU8rS1h1dXNCQTloV0hEZmt1NTE1TC9OY2Qy?=
 =?utf-8?B?eVdFR1czTTU3UHRqdXZhRTJnSzFjTit0aGxXR3JHb0lSbUhYWnkrcFNNdGNZ?=
 =?utf-8?B?bk9IWENrVU5CWno1RnVLUmEyOGdjd3gxMEEyWUQ0RVFJdlVkREpaVU12S2po?=
 =?utf-8?B?aGF1Yi9lZ1ZvTXZ1bEVuQmRMUk5xeExmc3VSdXRoeXhsYUhsOEoxdzRjelZa?=
 =?utf-8?B?WmhBelZZeHppald6RTMrS3ZCUFN6eVh4bU5KbUZad28vWm5kWC9kbU12WkdK?=
 =?utf-8?B?R1JaaFVlZ2x0aDF0VG5EZUFmMHhpeUFiMFYwMHBpVFp2MlBEZWZoSzRITUlv?=
 =?utf-8?B?UkJsTjQxWkhOckk5cFBQWFJZT0lWQ2FHbnVVcllqL2V2M01sSnpxUmVjRmkz?=
 =?utf-8?B?aUMyRFVTZmdyNVRhMmw4WFJOV2NkdEdhK1NTaDhqaGtUd2c3VVFETEdpd3FQ?=
 =?utf-8?B?Q3ovTzlUM05VSW0wVTVMR3E2b29FK2l0cTdKbTNnWGZYclhUeHp3dGEyQmlP?=
 =?utf-8?B?UXpNNGFuNW9DQ25BRGhab211dU1iZk9tMUNLVEdFSlNNZEd0c1FteGRVRi9W?=
 =?utf-8?B?YXRnNk0zeVIwZTYyV3U2VXdOdkRBYmlVU2JyZVc2eXV5dzYzTWRxNEdnZlR3?=
 =?utf-8?B?ODV2dkNLMTAvWFBKQzU0cmFCNzlaUlRlMHlsY0VPUmpsdjhEQ1BIeUwvcDFa?=
 =?utf-8?B?UnVHZjdqbjV4MDF2VE9WM0tWMlh5ZXRDaWdCZnRIUU9kRW5oMVpFVlR1ckFP?=
 =?utf-8?B?NFBqNTliNE44L2kzQjEyZk1WNGI5TVk1ckp2emEzM0FtZVpmelhKaXk4ell3?=
 =?utf-8?B?TjNHT1RBQjU0Z3NSWEI4Q0FkUlRuZStIbjVuNUdVbktmQVIrd2dHNUFTcWZj?=
 =?utf-8?B?NElkRnhQem9lSVdiSXhiTzdzQzZsOXRROTRFWnJ1bWROd2pDNFYxWDA5L2RI?=
 =?utf-8?B?c1BjREsrUnRPdWNYMjNCWjNBR1hCSWZySTJwK3JQK2x0N201RDZ3VWFHeE94?=
 =?utf-8?B?MGVrdW9LMXgrK0xjTDZhYjlUYStLellwSFlHV09yeUdneUQ4aUlDd0JtYlNi?=
 =?utf-8?B?UFRQQ0tBQndEcUNTNjV5MDZlYkVCb3A3SThITkFnWlgxbUk2bXo3QVhTVmhU?=
 =?utf-8?B?T0FhemgrMDAwZnhDN1JZZk9JRVdHWjFLSko5U21BZS8xbkg4VS9pZ3M5UW5p?=
 =?utf-8?B?NWtNOVNnRUF3cjVjTDVDQUNnendVNVFFQm1tUzNHL1NFUXlJb24rVFRsYnFw?=
 =?utf-8?B?MDZRWXRDMEVPUlpUOURBTmhOUzYxK0dnSWE3UEtid25hNkhISGZzQ2p6ckMv?=
 =?utf-8?B?Ry9oaXRxOFZRaXI5L3pXcDEwVXVNNEl1aDJ5UTdRdDFwL0tpMGFNWTduenZZ?=
 =?utf-8?B?MmtRWlUzTG84cE9aSS85eThPT2hNeDlFeUF2ajBiL0Q2b3Vabk5FSHo4bUtU?=
 =?utf-8?B?c21GTkd1ZFhSRmp6bjc3UVJ0dTlObWwzTUdwWGh4YURKZEo0ZkI0WnVuYi9L?=
 =?utf-8?B?cSt5Y2JzaFM5NnRlMUtoNDk0Mk9aVFdIYWpXWjJPdkZSZTJLYm1SVTZ6NlI5?=
 =?utf-8?B?Mm5MWDdWL2h5NnhJNjJRYm1UYWNDMFVsTXI3NkJDQ0JyRHhFZ0lENkx1Sy96?=
 =?utf-8?B?MFBONzFQU0NnYzlNUVpOK0lYeWx0azFldXFMRCtwR0pVd2N0NHlOcEJmYXcz?=
 =?utf-8?B?RzZQNTJHUm5SRlppTFQ4VElBNTdyRDRpeVBhNDNMWjNPOUt2UkVEcFBCWks4?=
 =?utf-8?B?YWVtdkk5NEYrcm03VHQzUUxaK0RiYS9jMmthTUw3UzNYV0lzTGhQbHdNbXRp?=
 =?utf-8?B?K3prN3NlbkcvMGpGZkdHemEranp6NXdKaURJVzVTalBmRGRlOXZabUNKT0w1?=
 =?utf-8?B?c3RDVzRhUmZOTnVPSE9JYWpoNmZ0dHZKSnBBemhhT3ZFS1BnTDl3SUVXaTRs?=
 =?utf-8?B?Vmk4ampHdWNBMnJ3akI5WGR0Tnp4bS8rYWRiWjM3dXdVa0VHVklWVm5HQjRX?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5529a6b1-96e9-4411-d9b0-08dbe617191e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 20:11:48.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8Ci1J4OI/i48/F4iAMY7uyBZdMel+WXYUKkZmGNnDBSNQYS48ue/8xfLflwUkOb5NqHoEogGQOYipSTCkU4xnWTT0AY72WYnhIYqP5Xx7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7480
X-OriginatorOrg: intel.com



On 11/15/2023 6:17 AM, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Introduce __devl_is_registered() which does not assert on devlink
> instance lock and use it in notifications which may be called
> without devlink instance lock held.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

