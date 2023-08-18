Return-Path: <netdev+bounces-28769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE2B780A48
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49625282365
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D9C171B2;
	Fri, 18 Aug 2023 10:38:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0231548A;
	Fri, 18 Aug 2023 10:38:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707EE1AE;
	Fri, 18 Aug 2023 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692355084; x=1723891084;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yHAC6pvwMj4NCUqEfE8gT6nKZ2jTKB4XVmMBaxeIiGc=;
  b=ExfMar/Q/6z7XHH6uVBh2L3olwyGm7yQC1LPed8jY/kFCvaUx0cWqdAI
   91kGIvxFmcg32DNuWlQH3t3BZj335Qp7Me2+eZ1WExh6gXWrGXR17sGCz
   fZDmqBacW6TXLqe2/oP+5+GlxHvQRKKOm0e6zFwTYCe197Pb1OKI089N+
   YKEl0aSyNSIj2Pb6L896A6Ga7nAo7AXM9DIBFnr57NVPgchhzVmim84VS
   geEBb2ApQdyP2Ezf3jJvRol34lRYFvpmOps62jeCH6WJ5lCfvOFLUNqVl
   Bfxy/swiwzdM7qkgh/XWMY6acCAqBU3YQmvF0Ntf/pJGqVvm/1xVpvYsU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="353374630"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="353374630"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858633656"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="858633656"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 18 Aug 2023 03:38:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 03:38:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 03:38:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 03:38:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQtaZ28rRuBGwoMbxCfQEl9uo9Z76w49RsnF6YRG7z+vk149Ur3PfFUz5FcZB9DW1vAW1wUJaJmILILCySgfJ13ZFX5OST1jpgDkVR8Cor3sCpKyHPEQH+c5ehJn3Rh8inui+8Dzj557mBv89oiYUaNGyFet0yk4gjH+JUnmP8r4cwIsSYiBw7jIDIsi0bv37lFn3JDflVfNygO+OMmMqAJQCWTNvFm8dMV+4X9QJRm7o//p1CLWlgHct6L95Xv9axITBLjV78MH8Ae1Qbdtt/TCoITHEnx2x3HQwmFM0KCpQypeQd/7DmwGYnoCk6S6Ub2ZKRXYjwbb0uuilGzL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=465Tokb5BP6KgVWWpzwQxhxOlv4uMS7IrpHmh9qj9As=;
 b=mxGRJ+4G27Z7amxiMktbUKoElCblMosbsL+f/Ly/Elgzg2L1H6OT1jd7fS/N7AIMRtkNhVx386G93QbrwlfsBywVvlh1UizsbrHXrV7U86BsdSiGkm6lpiwXigM9AQspbT2CWnaA/7RXEXxDQ156DbAZM9EYm87LDUxsfjb2FdMVdlFrSC3TgKmhM62CTobA1dTRQDomwP7gz5f5977n8b/S99IY13SAsS2N5gbMaeZ1LbBeYAM6OARWTQ8n7vjE+SWx0u+bFd8uLeXCZgxbPMRr980yEFmW+vznOxt9SkY84kIPaN5rT1Ilcv/ZaYNuNYIYxmv+x98va79WXNMs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SJ2PR11MB7619.namprd11.prod.outlook.com (2603:10b6:a03:4d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 10:38:01 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 10:38:00 +0000
Message-ID: <cfc29063-9e20-5101-d70b-62b5423d2d10@intel.com>
Date: Fri, 18 Aug 2023 12:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, <rust-for-linux@vger.kernel.org>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>, Jacob Keller
	<jacob.e.keller@intel.com>, <intel-wired-lan@lists.osuosl.org>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, <linux-hardening@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, <netdev@vger.kernel.org>
References: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <202308170000.YqabIR9D-lkp@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <202308170000.YqabIR9D-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::7) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SJ2PR11MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e1886d-ecbc-413e-4ccd-08db9fd731c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKC7Y3giFsSw/POkBK4zqQqcxs3R04Dgwe7e63TQhrgdSgoRQ8dOTyEZPqUnydg9CUdOO3H86MjxAuvKFWdOyyrBKwQO30qe/vw5YvpXkoosIqbMc7/zdh3BOD5qTRD/vbFbiyKP1ofuf2GW9qK+Qnuo58hI6WKpIXp3loaT/5WqEI8jE8LymmObvGSO2A2aVgchPgnIg6OwSot6cqpTLjkBi0e2KcQxExDxArafckpp+mYUHrNI+jf2OR4Masp2sn4GFbzwYJL5jQ5fydJlROgsOLbX0fDwyJDxiM2kfzhfJqjLGy1lm5F67R6C2kuFOHB3Gn7BlN9sdOgWZHJhezUzM8ZgVPc+1LT8ARtKhe46QdZl6UXhyFmwGUKGxD3jiNbG85hZueIiesfPNHuqg6efuYlngEnl92RfC/dkxIhqfqBpiB1atmEwyoi0cqs8oWhkWitKrL7h4seKZPMSB4UGHXlzRfLUH3tFzrGwa6TlfcIL5mMm/lG5vgq1LmbblsuixcGSAPWY9Fq/FeAvEEudwRoInLVeafyS5hK61xx+hBaq9CrEOP9UjvP2XNId8Q6Qt6ksl6+sjHi/AGLf/QGGB13ztQ9NmwpZX1FO5U2v4HF3KwlMWmLotL9GB7/3Y0QgqiuVIwd83eNeU2yDA6bKxjTLw+tiMASPG8C526o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(6486002)(2616005)(6512007)(53546011)(36756003)(966005)(5660300002)(41300700001)(54906003)(66476007)(66946007)(66556008)(316002)(31686004)(4326008)(8936002)(8676002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WElxYzJ1RXRWZWhNNkM4U1AvU0NjV0FTbld1YUxMMWRLR1BzZ1JPY3pQamhi?=
 =?utf-8?B?ekQyWTA2a2xmRmR5enkrZEpMaHkzM1FWL3FWOXArOEp2WkdYTjF0UXA1UjJi?=
 =?utf-8?B?emJkWGdSenRFWXlDUXFvY3ZaQ0h0L3FITitWbUd3T1JDUytqckxraDVUZi9l?=
 =?utf-8?B?R2w5V0NuZTBJQ0FFYWlNWEJlNlhHL3FMaTJMNURQK0paakxpSWJZYXBRemVl?=
 =?utf-8?B?S1BZcU1oWndrR1lrU005dFRTL2VqZDk3ZEFYVC91eDQwdXBwL3VGcGtPVitk?=
 =?utf-8?B?S0VBZmdRUmZjd1g1SXZXRHRtWkpCQ3VzZXJadzh6YWY2ZkxWY0hjSnlhSWE2?=
 =?utf-8?B?L1dQMjRoZmovVnNlNmx3TU04MEZONUdmTTdERVpYZnRCcDBYeDQyZG11WDN5?=
 =?utf-8?B?NEEzK2FicHZVRXdVRFc4L1E2WHZyUXVoTjAwOHpna0w2aTloY0gzL1NpMkRp?=
 =?utf-8?B?eW1jUWR5MmpmdHZuK3hzM25icUM2cEFlcTN6ZVZPMHJ4QVNwbmNFY01lMGdp?=
 =?utf-8?B?UlBiUGhDR1hUR0x2T3FzcjBUaDNTS2M2cTZvVFlrc0dlTWxRazZLQVU1eW05?=
 =?utf-8?B?L0trNTcwWmxDK09KMGZlaU9OQ1VkMjhwOXR1dVArZ3Q2alNJUUxVSlp0bC95?=
 =?utf-8?B?OXRBTHlpYXMwR3dnajhnNzJZdk9lTkNEUWsxRVUzUk8yeEl1ZzN0dmRqRzZw?=
 =?utf-8?B?SDNtSndpRWtYNzVqL1dReHpQOTRNd0ppeHZLN0QrK3Fmdit3QVRBMXQzaFdL?=
 =?utf-8?B?S2ZWeHR6bmZjeVgzTk5STlFacTFaYklNYlByVkE3OFExRE84TnhGQ29tWWpE?=
 =?utf-8?B?WjlPY2JrdzVQeUMzZnNKRVBjaVkvcm15MzFWOUJXSCthZzRXenB5ZkN5YUtS?=
 =?utf-8?B?cy9xMGFHd2dYTEFKaG5ZZ1NTSzlJYW9SamxpSVYwdzJPVnhwNGtDMDVSVmVM?=
 =?utf-8?B?VnNHN1ZnbEFLVVVBRGU4NVQ3MnFNS1o4TVE4ZEpsWjh5VERMR3RaZEtZTWE1?=
 =?utf-8?B?ZSt6NkIvYWtOZENwcUxPRzlieWIyNXpCdFVWQ0h1V0FiLzdZakNaWWJaa0pa?=
 =?utf-8?B?RnUxSklOUmdjSHNXQzBUUmJzTmNGdDd5Q0k2QklEcGp5OVNSMnBBTFVQb1Y1?=
 =?utf-8?B?a1ovakJCOVU1NFpRZE4zZmRLT3J5aXZhM0RLd29xb0g5eHk1SVNaaStuVXBr?=
 =?utf-8?B?cmhEVlVPd1RuS3hFakpKK2x5VDJNUjdFYkFBVzJ0ekt0ZVZETGtNL2xtTVlG?=
 =?utf-8?B?N0VyT1RCYStuNmpvNUc2MFNJd09vR2FPVzlQbWE2eGlQMnoxVmU3MVl1S25l?=
 =?utf-8?B?N3o0cHZSWmR2b0VBbmhBWEJlUXJjbjZ1N2JDYkd3OCtuWGxTTDB5YTBPUWNZ?=
 =?utf-8?B?SDk1UWl1VWU4b01PeGxndVZ0WVpwanQvd3h4c05JOU14Q1dBU0hHaHZQVUdi?=
 =?utf-8?B?d2pNU0FrdE9GR05XVjJKY3pWRy9OY2NEeFo3aExHbFcwUUNJSmQydnRlcUNB?=
 =?utf-8?B?Q2hocjVweEowYStJTk1UdzF4WFJhaHNscSsrY1oyaHh3alV1RHZkeDNpeG9i?=
 =?utf-8?B?NXNuMDIrd1FuRTFRVXBEWkZaL3RxUTlFUGcyUWE3R2VlbUt6VGFZeE9WZzNr?=
 =?utf-8?B?VmhKdkVreGE1cGVYYVZZY3E5NExka1VRZUdQeVdQVk8rVE5lWTM2c3FaVjB2?=
 =?utf-8?B?cmZhM3p0OVYweXJpOWR0Y2lYZkc2ZU5RQjdadUMzcnJXS25XU2x1MWY2czBC?=
 =?utf-8?B?Si9WWEVQaGRZMlViZkZXL0hFQTdVRmh1TzgyVVpxR1loejhJTEZvbVVkcmhk?=
 =?utf-8?B?WThncVJDOGRmeXcrSEd1MzRNTytEdFJ4STJ4dFZpUkF2NDdYeVJyZjBTa3NL?=
 =?utf-8?B?MVFWTG4rYnZ1b29pQ0RxbGlCcWR6ZTB2QWU0UUQ4TzNvVTJSWTJNV1VSd29a?=
 =?utf-8?B?bWVZRGFTMk1XeDBJekVoa1NzdnJrREI4Qk0zNmtxQ0VvbGR2VVhGZlpqMlRV?=
 =?utf-8?B?bWpsUjZrS2loajBxR2dzYzNPMzdhc1hvd3lXWWxkemtjMGFqNUQxS2Z5VWtm?=
 =?utf-8?B?Vlc2WGFCR2F6Y2ZqZ0RnZXUwMHo4dXBjKzRKbG5hbTNrek5DMWo2QkF4RzBW?=
 =?utf-8?B?S2pLbldWMmZVaUtMNFUrQmg2QW9xaXhzZk01cDJvWDZ3S3E5UVlqZnpFMFYv?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e1886d-ecbc-413e-4ccd-08db9fd731c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 10:38:00.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKX7ABV1fPhwEZa2SXlIuKCiNAPHTkyFWe/IZY8qcS55JLdqic0/RFm6NqgNM3gxJubV01XTNOwq5HMPIHV7sHANdNRN2rAlbaxbld9wU4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7619
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/23 18:35, kernel test robot wrote:
> Hi Przemek,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 479b322ee6feaff612285a0e7f22c022e8cd84eb]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/overflow-add-DEFINE_FLEX-for-on-stack-allocs/20230816-221402
> base:   479b322ee6feaff612285a0e7f22c022e8cd84eb
> patch link:    https://lore.kernel.org/r/20230816140623.452869-2-przemyslaw.kitszel%40intel.com
> patch subject: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack allocs
> config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230817/202308170000.YqabIR9D-lkp@intel.com/config)

Rust folks, could you please tell me if this is something I should fix, 
or I just uncovered some existing bug in "unstable" thing?

Perhaps it is worth to mention, diff of v3 vs v2 is:
move dummy implementation of __has_builtin() macro to the top of 
compiler_types.h, just before `#ifndef ASSEMBLY`

Przemek

> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170000.YqabIR9D-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308170000.YqabIR9D-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at_include/linux/compiler_types_h_144_2)" is not a valid Ident', /opt/cross/rustc-1.68.2-bindgen-0.56.0/cargo/registry/src/github.com-1ecc6299db9ec823/proc-macro2-1.0.24/src/fallback.rs:693:9
>     stack backtrace:
>        0: rust_begin_unwind
>                  at /rustc/9eb3afe9ebe9c7d2b84b71002d44f4a0edac95e0/library/std/src/panicking.rs:575:5
>        1: core::panicking::panic_fmt
>                  at /rustc/9eb3afe9ebe9c7d2b84b71002d44f4a0edac95e0/library/core/src/panicking.rs:64:14
>        2: proc_macro2::fallback::Ident::_new
>        3: proc_macro2::Ident::new
>        4: bindgen::ir::context::BindgenContext::rust_ident
>        5: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
>        6: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
>        7: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
>        8: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
>        9: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
>       10: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
>       11: <bindgen::ir::module::Module as bindgen::codegen::CodeGenerator>::codegen
>       12: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
>       13: bindgen::ir::context::BindgenContext::gen
>       14: bindgen::Builder::generate
>       15: bindgen::main
>     note: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.
>     make[3]: *** [rust/Makefile:316: rust/uapi/uapi_generated.rs] Error 1
>     make[3]: *** Deleting file 'rust/uapi/uapi_generated.rs'
>>> thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at_include/linux/compiler_types_h_144_2)" is not a valid Ident', /opt/cross/rustc-1.68.2-bindgen-0.56.0/cargo/registry/src/github.com-1ecc6299db9ec823/proc-macro2-1.0.24/src/fallback.rs:693:9
>     stack backtrace:
>        0: rust_begin_unwind
>                  at /rustc/9eb3afe9ebe9c7d2b84b71002d44f4a0edac95e0/library/std/src/panicking.rs:575:5
>        1: core::panicking::panic_fmt
>                  at /rustc/9eb3afe9ebe9c7d2b84b71002d44f4a0edac95e0/library/core/src/panicking.rs:64:14
>        2: proc_macro2::fallback::Ident::_new
>        3: proc_macro2::Ident::new
>        4: bindgen::ir::context::BindgenContext::rust_ident
>        5: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
>        6: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
>        7: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
>        8: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
>        9: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
>       10: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
>       11: <bindgen::ir::module::Module as bindgen::codegen::CodeGenerator>::codegen
>       12: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
>       13: bindgen::ir::context::BindgenContext::gen
>       14: bindgen::Builder::generate
>       15: bindgen::main
>     note: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.
>     make[3]: *** [rust/Makefile:310: rust/bindings/bindings_generated.rs] Error 1
>     make[3]: *** Deleting file 'rust/bindings/bindings_generated.rs'
>     make[3]: Target 'rust/' not remade because of errors.
>     make[2]: *** [Makefile:1293: prepare] Error 2
>     make[1]: *** [Makefile:234: __sub-make] Error 2
>     make[1]: Target 'prepare' not remade because of errors.
>     make: *** [Makefile:234: __sub-make] Error 2
>     make: Target 'prepare' not remade because of errors.
> 


