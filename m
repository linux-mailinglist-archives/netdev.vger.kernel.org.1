Return-Path: <netdev+bounces-45323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007857DC19F
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8991C20A81
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B857F1C292;
	Mon, 30 Oct 2023 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+Ee7Yx7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D85199D9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 21:11:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0559F9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698700263; x=1730236263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OxOZJB+0hUxmRg6hh9koLgfTPfYKjsmb+YRhw8Wdbwc=;
  b=K+Ee7Yx72ca/h0jol2Ljnx0S8idKulQHjovUB01pGlfH7C0byPm92fbS
   +ciIhI18vlTwbDC/1jfMZ8WMe9WzBnuMS0KBgyDii0mLEzA/7QBQSPGAR
   6Gh2rck7cd5CNdwP6CBmXrQeB22iZ1hiMN9ajQhp3k13Xni6rR1dYsjwr
   LzesZhGhfLHV1NkKv4DfeKz1yRPTkVwZRCfsTLy9zZbvUOketwjj5G2fx
   ZgvKSH/yd7aYERklMdIDiQWo3uQeNxcwkzakMtaBmxThGk+JaF2s7lIKC
   bdHVAys5HyIxCxFLTovZOzfJpOOlvuWCARqHX6s55cbbBRSW6IsD+InOq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367510023"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="367510023"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="760412784"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="760412784"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:11:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:11:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:11:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXD1/a6pdt81PHnafquyU18G6kdWX39fIkaNZps2XXz9+EJasZ086v1cdXoJ0qXmf+lbhHr2ftv1JxVg99N0EWb7wtkpd2EO3Xlc72+DxrenwfCda9szHT2Xapactq5tDI1KN1ye0vz8srAhwBxbBnXse53MCoHSUQ286jTCqAdtnXa51siSmoO+QUMk5FzR9YaV2lhW7UYWZLInpce2e/Q3jNoxnOBuohdiq5QtbnAOjqjn393UBFDbHjbb1qr1Q5+vYvcanOED9ABIVvY53QkvJsvcdvDwmg5U8+yVO1QEPPbLo2SZGmKWDJORqQ7F5tbDknbvt8QqUFMImZQSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+MKZlVJ+dEabYum9YyuPSqvKbKWDmOdz1Igeq5QeaU=;
 b=jmMI8lVjj0qQjQOx7yXYeW4QVbaLCIm+gk7lqsmW3+/viocHdHPttP4gFIlgxQhB9Z0qCpyQ2sx0pMpTv/YUeWABnnG/dGXLyTFgHSSHydG1REqefYgPuPL/l+N07JHV5pWJKZf3vaBGITbFAGMh9HOc4mC1JNebuIJcZVDVGlXjwjew7d97y8IkV9w++6I2mxV445uvBJ+6QN3l0jqZO7YXg8e/kfw8fX6RNd4P2G14OKjRtKwZxU2BM1Mgzuhz0aOmGeyuKKu3v/um8Z9BGLtavPRStGzJiUHwFn74yZ01sQpdS3pPZ1ggoBmaBP6Lc6mJmP2n9ERibIWal6VYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SN7PR11MB7437.namprd11.prod.outlook.com (2603:10b6:806:348::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 21:10:59 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce%6]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:10:59 +0000
Message-ID: <342dee74-a131-400a-ba2b-32b45ab556e8@intel.com>
Date: Mon, 30 Oct 2023 14:10:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: netdev: recommend against --in-reply-to
To: Jakub Kicinski <kuba@kernel.org>, Martin Habets <habetsm.xilinx@gmail.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
References: <20230823154922.1162644-1-kuba@kernel.org>
 <20230824090854.GA464302@gmail.com> <20230824082930.3f42cf8b@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230824082930.3f42cf8b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0070.namprd16.prod.outlook.com
 (2603:10b6:907:1::47) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SN7PR11MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b5f937-f0e8-4756-22c0-08dbd98cb70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uCqZurGNpabogy9pgs6BG1tfbY+3YaO7Bya2kwlL4bOjkD+fMP11qnY66cdmMp3A/A3xnZL2EV9xG6sjqt2MPraApxt3g4fvoFUR8HXrtNNGUQ/KSvvVpfwYZ+82CNDTHdm031Kn+1JcexHEKvCDY/MziHtnvLWn6nsltQvmOYIfg2IGRCP3gsDegC+CtPmL+LtLkFlv8vEm77gklZecZMDYLNCSdVRYCeLX33jQVcqP76N7BREwGGv4UEHSuyD5kuMiOMggeTL0u6q2r679Cl4Q9C9/eOdV6G6MkU7XrlayXOB/n4SLR4X56vmOehyBHkri6unPTsDBO+bz9GcImIX6fgN2qfseE9uTrKixStCEHntbnwhpLkQZ0GPI6ezsZtnHpMjk4lux3+aSAMcSbSgU7zQ8jL7ZtxEPurOW7L9SZgoOEU7VyAzuIPCx669HygXWytAeRjGsLoSkX8fUEA9nsSk4p1DeSLqOSP2HL/QdMovtmVky8BrfY5l9tdtj147JPZMf8UilZQPdM03AZ3WyVojGjQ9E35eMPAQEUAc8JqkfZV89pZh6KGx1Is5Kg53s6/WZDpzhLT5r9aWBmKj63I3vDZ1O+h6p5ezDD82BmI18IincNSlD+i3g483B92xmhg5U35fuq1h5OB1BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(6506007)(6666004)(82960400001)(53546011)(26005)(2616005)(31686004)(86362001)(36756003)(31696002)(38100700002)(478600001)(4326008)(8676002)(6486002)(316002)(8936002)(41300700001)(5660300002)(2906002)(4744005)(110136005)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjJVeDY0N1BFUzZWV1l1dVZUQnNNQkFkb0FYQTBUODh3SExnVmZhR3lBTUFL?=
 =?utf-8?B?bi9UTEpheHJ2NDcrVU40S1dMamdlTFc0OVhXcE9YL2dVUEprbzhKTFRsZGNk?=
 =?utf-8?B?Mkd4ODV3L3pudHJSMGxCZkUvRUNIL3ZVQlpQN1BjMDMrNWxmLy90LzQ2S1d3?=
 =?utf-8?B?cHdVelBIWUpreXVEd1A3eWVkcVBYRXlsZWdQcVN1bFMwNWIzYVlJYnVCVWRK?=
 =?utf-8?B?ai9oL2FtbjNEVEtRakg2RzhyNFZhd3k3Z01FdmxUMTNLdTI2a3hGVStieDNr?=
 =?utf-8?B?a1pZRlgvdGJYM3d0bnU2OFRsQkFDN2psRyt1bkM2dlVwWUpSYkE5WGRpc0Ni?=
 =?utf-8?B?bUtqRS9yM0ttQis5dnVPcS9VTGdqRDFCeGJ6bW5zUnRWL0FuQkJBb0JTVnNt?=
 =?utf-8?B?RzNEUUJBdFR1SENVR2p5cEFBM3NzS3dVbE4rZ09hWkZVZWdpdGViWUNFUkdU?=
 =?utf-8?B?L1ZUSEsvQWd0enYxWEdUUVU2WEZDdXVKMXl5bEtGL3pqek5BUXZ3dW1WR3FV?=
 =?utf-8?B?NUVwL0crRThIYUtFSmhUQmdVZzBpMEJnR1JBZmkwaWd6VTNlTmNUZytGQnJQ?=
 =?utf-8?B?RGljS09XM0hmNUhodXY1dmlhd05jbXhQdTNjU2tFalNqVlRTbTUvSUxUMmRP?=
 =?utf-8?B?czR0b0o0RWx3UFFmdWhEM3ZqZmVyTGJyMlZTTkF6RVpzeU44Nzd1SUJlWVR5?=
 =?utf-8?B?MThpNFE4SkhpaHllSnNBWGdHbCtCN3Q1MUlUbkxiN0RUZEZxeDRMalJCZHll?=
 =?utf-8?B?K0tPSnBJRVJWUnBuR0ZUSXBvaGxpbkU1ak9mekpBVEU1U2hNdW1MVzhIVXdE?=
 =?utf-8?B?YjdKK0xaZmpCT3NVSWZHS0dhUmwyWEJ3MWtvdzZFWFhTeWptTGt5WnpEK3ZL?=
 =?utf-8?B?b0NHYUZRZmNPSW1RTk16dzZ6ZDEzdW42ZW1LSWFOWmhxVEFjMnlEcDVVNGNr?=
 =?utf-8?B?TmR2K2YrNUFLZkdMamtRVmxlbnhvRzhYeXpnWXhxMmJvQkgwVVUzbVZFNlJB?=
 =?utf-8?B?N1dnd0s4V250KzRyZ3FhcWMzN3B5V1lIaldIMGYvMm1VVWVOZUlOYlpGWTFS?=
 =?utf-8?B?aE5ScW1GZmR5T3F6Zzc3MHJZMHM1cSt0NGhmR1l0NnV2Rm40QnhteEtLUUps?=
 =?utf-8?B?Zlh3bFlNZWhCY1Q4TlN2VUk5N1Q5RUlaaUdhVjFERHpaK2JGZnRKa2NQTlMz?=
 =?utf-8?B?Qmpkcm1ZWUxVdzNaZlBQck9JWU50TVhtLzR1aDhYcEFaMVFPeURIMnZyQkhW?=
 =?utf-8?B?ckFrK3NzYTQyUGpST3RtcUJYd3YrbXRUZE9lQjQwOXQvdkUydjJ0WUc4MC9r?=
 =?utf-8?B?cjY1NFRqS01Ed0l5dGkycmN5SVhzOUoydFZlcG52WVpyUVAvakNINTZmWUph?=
 =?utf-8?B?dk9VU3F2ZDNUdEVERExQK0Z4VEhscko4bXBrUEZaSXlBMmhsRHpTY3Fwazlz?=
 =?utf-8?B?QUl5SzNCMjN3Z1BmT294UWVyaU5tZHRMR0NjOGdnSVBKb2t6V1J2RC9IQUVt?=
 =?utf-8?B?eXRjOWlkM2hmVkdDMEEyTXhCejh3YjNIZElEZ0ZmRFFIaUZRdTBoaVhMSEdQ?=
 =?utf-8?B?cnpkb1hIQ0kwU0ZKV3pYUjJTaTN4SHRHU2pYMWhmZS9wVWtic0d5SGFrSHpQ?=
 =?utf-8?B?MjF3dldFMXRMdHFmY0xVMjVTSEg4WG03WjFvRUVFbyt2emRnVUNRN0JFZCtG?=
 =?utf-8?B?d3BqK2RWTTFYYlJJa1dyK1pEazNDUTlYWnRjOStWWDl0dHJRZzJoK01vcFFJ?=
 =?utf-8?B?WXdSU016VDd3aFkvMlZZMzQ1ZVE2YlNuNm5RMFkwWHViaUZXS3pzbjdJTEF1?=
 =?utf-8?B?M3NvVnRGaTVTOUxINVppakhLeHVkbmVvcm4xQXJscjdzUXZkQ2ZxUUZlYk5v?=
 =?utf-8?B?dGxuNzJHM0hDSStYTnZlcG01NEJlVkdjbzZLVm10SWJNbFE0VVdIUmVoNUF6?=
 =?utf-8?B?TllzTUJITlV1alhZMjlFWlVOWG5LbjJjRzQ4RTFyT2dTTWFCeVJDQ1d1MzBL?=
 =?utf-8?B?VENVOHlITUJ6U3Q2R0FrTmFhWklRWmw4cmZRbU5DTmNsOUxjcW9oSzBnWStH?=
 =?utf-8?B?MWdnWWZLMksxait3c2tUQ2QvSFdtb0VQdy8zb2pvT1I0bHNvZEQ2eFYzVlp4?=
 =?utf-8?B?eU5mcTlYS1pDZ2dMVUs4Tzd1VWliUDdYSms1ci84SW9kQkgwVlYxR0hWK2dy?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b5f937-f0e8-4756-22c0-08dbd98cb70a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:10:59.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5nUqfq9In8YQmipnB/vweRfEuajCWMBtK25LTZep0DAoGUqw5DcoVKACJ99crqTtDPb2xdoEzUhMmrbAUqepzvXCFzrZsLhWqI+1woKpJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7437
X-OriginatorOrg: intel.com



On 8/24/2023 8:29 AM, Jakub Kicinski wrote:
> On Thu, 24 Aug 2023 10:08:54 +0100 Martin Habets wrote:
>> On Wed, Aug 23, 2023 at 08:49:22AM -0700, Jakub Kicinski wrote:
>>> It's somewhat unfortunate but with (my?) the current tooling
>>> if people post new versions of a set in reply to an old version
>>> managing the review queue gets difficult. So recommend against it.  
>>
>> Is this something NIPA could catch?
> 
> I think so, but the whole thing makes me feel bad. I mean, if I was 
> to sit down to write some code I should probably try to hack up 
> my email client to allow force-breaking threads?
> 

Yea if I were to do anything else here it would be figure out how to
make the tooling handle this better somehow rather than trying to
enforce not doing it.

However, I agree recommending avoiding this is good.

Thanks,
Jake

