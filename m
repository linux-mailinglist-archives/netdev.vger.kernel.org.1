Return-Path: <netdev+bounces-54653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58822807C32
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 00:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA128213C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 23:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BBC2E634;
	Wed,  6 Dec 2023 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCOFCvJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2376D10F4
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701904610; x=1733440610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z27yQ1tVq/ZdwRgwJ7cNsqYZw02wJ13Nqnrgr2aELc4=;
  b=DCOFCvJ6Dm2aXlHnCbEipCPQjmkofzxABYAQqN1mIGwOOaJJ8yKoMQEp
   06DnlsVCPLh+fpdntxZFKhs2kqTQm0oWuyKToQiPx8wsdsdx2kx/FSah8
   m9px+4p6AJypNliryNod1Sn3TA4gr2e0BAibaRXERNkAy3FC895RA+e3A
   BJhcR2JtEFNxwknIBtIyROd0YlptqjtyxFmAfK8u5P3rhT0k7CIvCrMfv
   ek8lpShL/v0zWH554KoyJnV5sSbvcyst3L8ZgfeYaWFSY5Dw+dxfBunr7
   YNWsEk+yPqeArYe50TF9C3r2kcP/qlrDTTaZzh9I1y11xYn0CG2akvnga
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="12856832"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="12856832"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 15:16:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="771480228"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="771480228"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 15:16:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 15:16:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 15:16:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 15:16:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOOxKSpI+HRlcEn/5scruuubyTMnF2+q2yZWoCZlnQ3rhoyD0nXoHyI3XAkwN/0mXdn5Y/mjTVQlyeStZatRZIJZzHM9rx3OIYdHGs0rft+KXWPCiPLa30S+rIbzVKGPHBcMApzCXROIgbZiczPMMJ2OhTHYoNjFKi1C1HKk5iGfARUzDpl56oSRqyZKVyCyj2qYB1aiI3/hKe+LoVLPllSInhykx3LFZivF6UW+t7OhXlQloV9jz+ait36RV1777GTRDialC8jyhkgg2rss8wAfzbJrTPYSIbcri5TvK+2AUoIjYvapzI9vVX2dTTMAsBwLPWfYf7EgBsIJFkJV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD4t/8dVCNsxiWZg/uMS2cYpdq66OrWXE2zs8bSzS2U=;
 b=ScSUTfpm4pJLSq71f8mPE64SFA7Huc/+C350SSQhV6GKD/spUcR/7okqT72nCxLXPLzzxt87QNJhk5vnWGXngCquDWLouERCd8mDNXUxAAr18tLzLSxDjjEwdi3veKwk6xGE4hFJ1E8dFkNTrKkV9Xgqfpcn4jdK/RjgDSJjyFTb4b9qfkAkrhhd2XQCss5lwwoHbB6OaYpQwFEkpXzAq8npMFK++x/4Ymms8BY/FDeJs+VSRSdiYW5q8mzqUD0oP/beiPjhfkyZnsX8+drRm91Sv9UDKvn+P7zeOdOP6FwsaQGcFj3nKF4ueTpB/ThOC5ZarJUB3QuubMx8NVBo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 23:16:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 23:16:45 +0000
Message-ID: <c186f625-c16a-4424-a9f8-f25360d5e1d7@intel.com>
Date: Wed, 6 Dec 2023 15:16:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] psample: Require 'CAP_NET_ADMIN' when joining
 "packets" group
To: Ido Schimmel <idosch@nvidia.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<jiri@resnulli.us>, <johannes@sipsolutions.net>, <horms@kernel.org>,
	<andriy.shevchenko@linux.intel.com>, <jhs@mojatatu.com>
References: <20231206213102.1824398-1-idosch@nvidia.com>
 <20231206213102.1824398-2-idosch@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231206213102.1824398-2-idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0299.namprd04.prod.outlook.com
 (2603:10b6:303:89::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb00ac6-8108-4719-b15e-08dbf6b169f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbwbFT5dvvbwNOlaiOIYDyk5V3E3cmRh7znh/sTjoRyYKI4z+Lk77GeHGbKEKtd5TW8ZmmmKKzMjJt+LXIirMgMY0B/4ya4YvlrFvvISy5XjDUMNvynLPn32jqpBMUww31neuKHTyhjxYGx3B3554a2M8zHGMMtFWl9L2MqDylb8VDUJyvv8cBnfx31XhYuHbpLL8bvlWEdl8ixxwe3beoKpnQ6D9PC3k4Fjjiug5bwE07L89x0BI1AdniQoCbr+4QyXAH66WzXGbzZEeid2LYM41smybKk1WalBV8zH6M9GvwKCkQo0csJE5L/I45VPdMdgBtihoAV5t31xZo5wk2u0z6tpQn3U3ymkb7tOoMJmGV3cmlTB3U/3BgIJwQ+U/gnk2OSF/L1eFqmnR8RrtBDVjA3LWZaOavzOCev2ZmrlhWxGtOZAIS7RXt+EZ1usJ49HZuO9GNwq1HKwqNGFCrEeKv9ZKK/myW0yNo/sRxl5HC8XdEhQU/jDLeEwcF153PP9j3R+lnC3qJOsMqH8iOE42e1cNBEq9uI6rvLG64uLkkK+t2IBnfK9cjJYsQSo/jsSs43MdXYyi6LvNnrf+Cu00l7oGSfvoaB/Cpx9fbEPdRTb0a5iQLAfQPY/fXjzOD0IczzoZcOG70CuL3/9X+i5AWi3mYKQBQlL9FN74P499tuYiIiq47UunyfOYhsGh2qdWkmm4DTSPTS02CZvVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(7416002)(66476007)(478600001)(4326008)(316002)(8676002)(86362001)(8936002)(66556008)(6486002)(31696002)(66946007)(36756003)(41300700001)(5660300002)(2906002)(82960400001)(38100700002)(2616005)(26005)(6506007)(6512007)(53546011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RThxSEhxUTVKSXJFa3BMQnNXOU9DQkh0TkFYbnhIaWVjRGEyc3g2S0hCblVD?=
 =?utf-8?B?WUdMaXZ6RWtURmNCNi9hWjkveUlkMVN6TERzK1dEUFByNHBEUzdCcWxtS1Ey?=
 =?utf-8?B?TWV6QWNUcGJ2NG8vTTRWUXhGZUVaR0Rhd1QvMS9iL0dLcDg0VTdGd2lMMzZw?=
 =?utf-8?B?Z1dRbkZsL2xVOFljQ3ByT3NWdVdmUXNnMFBIV2EwUDIvMUtpMXc4SWovd3NE?=
 =?utf-8?B?UHZrQXo3WTdYQ2VFSGNHM2dJa0E5bG1mdUNmRDFIS3k2NnNxbTZWNVVqcnJI?=
 =?utf-8?B?bkF2RDU1enVKSkpFcjhOUFZQMnloeUR6eHFnRVNnQ0ZUU0VUY01oNXNFek40?=
 =?utf-8?B?ZURzc3ZnYy84Z2JFSU5PUUVmUWdxdXVBYTJqUnp6Q1NtbGhObWk2NVZET0to?=
 =?utf-8?B?UG16UFJNa1dvVk1xZzgyS2FZb0FySHBneUlUd2wxMlVhcDc0MldraGlWQms2?=
 =?utf-8?B?eDRRUUlHZ1lxLzE5bEVpdzdHVFlISXFEeU85TmkreG15S25nczVKTVZEMTNL?=
 =?utf-8?B?Q2hhVkRLcGM4ZXl3ZHN5c3Zzc3Q3VGQzZGg4YlFYa1krOUFjVVNOelJYUWNp?=
 =?utf-8?B?dGVidFpNc0FoS0lYVXVHR0RmVzJsaENhL2pPeEJHSG96QkZVTWdzcXVYMXFV?=
 =?utf-8?B?eDQ5c29hVWNaTmdxZkE3dmhvR2NYK3dFZ0Q0WHkwUG5zVEJRY0hnQ3d1RkxR?=
 =?utf-8?B?OXBNVEpNblljQ2lEZjNJaXJPaEdTc0tONnQyRDdVVHFtVjFkOXVkZGxTM2FN?=
 =?utf-8?B?d2ozRUkrQlNyQXBFSTRnV2lVTmh5Q2JIS2ZjM3hTM0ZEV2N1M1BVRE5sR1Uz?=
 =?utf-8?B?cGU4NHMwTTFPR01TWTh5QzV2c0d6b05leVNhdlNnWElRV2lScm5Vb25CWHhv?=
 =?utf-8?B?U0RpbW1lNWN0QThDUE1yeFVLM0RFNmhhMXEwVk13VVBLb1FJWWZGaEd1UUlL?=
 =?utf-8?B?WnhGOEE1dlBUVjlmQU5LWG9ZcDhUSklvM1RVSkpIckpwYVZKSE5uZVlBMUNS?=
 =?utf-8?B?VnZ0MmYvZ2dwTjBYNllzS082cFc3anM0TVlYSUF2aHFhR0VVKzdoMEtFZ2Ux?=
 =?utf-8?B?VW9HQ2tVd0NPd1d2L1IveE9KeDhEYmYzc0sySzhSVnU3SXhaUWc2RWJpZHUw?=
 =?utf-8?B?T0NIRHhFRWRKRkFkakNlWC84NERxcmhHeDA5cVBLVTc1d1FMU3ZTVnU5bVpz?=
 =?utf-8?B?cnZvNDgrZnR0Zk44c0ZEdCswSStibGhsTEJiM0kyd2tmUjBYY2JCKzg4U3ZV?=
 =?utf-8?B?TG1kdUsyS2lQd29ramg1SUZ6YjVJV0xHdE1CZlgvQXowRWlhbkY2UnN1bUd2?=
 =?utf-8?B?Y2h2ZklVSXBUckZNQW1KV042QmNPQ1NLMGluWHNKMlpScmJPS3V0cTVOK3ZX?=
 =?utf-8?B?NnphdmVGV05XbW95Rjl5NWdEa2ZFcnhQcUYvc3NnTTE4NkJNRkVlWUlrK1hO?=
 =?utf-8?B?SVpkOVN3NmpXMmFncGlDcWpZVTZpMU9xK0NNOUhnbTg5bm9QM0w5M0xTU1Jo?=
 =?utf-8?B?TDljdVVORTV2UDRKMEthdUc0MytSNmlzd0tCTUVzOWl1SC8xU0hlY2xXVmc2?=
 =?utf-8?B?bUE4WDk3dlc1VzJOb0tiemk1VlNHMlV4Ly9EUDFER3FjaXlNZzZmYXhGb0Nu?=
 =?utf-8?B?NUo5cVVWT0YrYi9Mb29MeVEwOXNLYWl1Ymkxemh3WVNrNk9FNGlKdUtFY1Vu?=
 =?utf-8?B?Z2Zydm9OV2hoTzFORTBadHJ3OHJpWVcxYW41WUxQMm9hSExGZ0E2cVgyaGRt?=
 =?utf-8?B?c1ZoUFp5MUlhWUMvVU9zMlV2T2YyQ0ozSUhnYUVzYWdCRklwakpiclA0dGlr?=
 =?utf-8?B?MDh3VTJ3UUNNRGN2djNvUXBnYnZmSTl3ejRoT1JES1kzejBWT1orQ2VxTDlP?=
 =?utf-8?B?dlBHSGdmakh3eEdJd3ZQVkxOQmFwQ1pUUjArS3ExUjBVN2pjckF4TXh1eGts?=
 =?utf-8?B?OElieXBGa1hxeEFxODZ4UW9BZ0NMNnVzd3VuTDJNb29qY2NxSWU1dEV1Z29S?=
 =?utf-8?B?MnNJWmtGem05enhrQ0MwdG4zM3U0UHRjY3U1MTg4MG9VbDByMXJrcHdOWGE4?=
 =?utf-8?B?ckhTV3BTNHlWM3VrdmY5Rzd2alRRMmhBYWsyMGlJS1NYeGp5TkR5UG1nQy84?=
 =?utf-8?B?U0tjS0M0OXBaazZHSmJzc2hZeU9HM2J0UkRNNkM2eElUSDh4RVkwdzR2bTA1?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb00ac6-8108-4719-b15e-08dbf6b169f0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 23:16:45.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qYrkmRCSXj1ar8jFLfoGqK5FTKz3Wavxm6VMd9EwixhxkjqN08RbvotmUI/4q7iq+IFbmd6EFHwXdxcCF1KHiSj1FCKh5k0PMoBAp4odYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7181
X-OriginatorOrg: intel.com



On 12/6/2023 1:31 PM, Ido Schimmel wrote:
> The "psample" generic netlink family notifies sampled packets over the
> "packets" multicast group. This is problematic since by default generic
> netlink allows non-root users to listen to these notifications.
> 
> Fix by marking the group with the 'GENL_UNS_ADMIN_PERM' flag. This will
> prevent non-root users or root without the 'CAP_NET_ADMIN' capability
> (in the user namespace owning the network namespace) from joining the
> group.
> 

Ooh that could be a pretty significant leak. Glad to see it closed.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

> Tested using [1].
> 
> Before:
> 
>  # capsh -- -c ./psample_repo
>  # capsh --drop=cap_net_admin -- -c ./psample_repo
> 
> After:
> 
>  # capsh -- -c ./psample_repo
>  # capsh --drop=cap_net_admin -- -c ./psample_repo
>  Failed to join "packets" multicast group
> 
> [1]
>  $ cat psample.c
>  #include <stdio.h>
>  #include <netlink/genl/ctrl.h>
>  #include <netlink/genl/genl.h>
>  #include <netlink/socket.h>
> 
>  int join_grp(struct nl_sock *sk, const char *grp_name)
>  {
>  	int grp, err;
> 
>  	grp = genl_ctrl_resolve_grp(sk, "psample", grp_name);
>  	if (grp < 0) {
>  		fprintf(stderr, "Failed to resolve \"%s\" multicast group\n",
>  			grp_name);
>  		return grp;
>  	}
> 
>  	err = nl_socket_add_memberships(sk, grp, NFNLGRP_NONE);
>  	if (err) {
>  		fprintf(stderr, "Failed to join \"%s\" multicast group\n",
>  			grp_name);
>  		return err;
>  	}
> 
>  	return 0;
>  }
> 
>  int main(int argc, char **argv)
>  {
>  	struct nl_sock *sk;
>  	int err;
> 
>  	sk = nl_socket_alloc();
>  	if (!sk) {
>  		fprintf(stderr, "Failed to allocate socket\n");
>  		return -1;
>  	}
> 
>  	err = genl_connect(sk);
>  	if (err) {
>  		fprintf(stderr, "Failed to connect socket\n");
>  		return err;
>  	}
> 
>  	err = join_grp(sk, "config");
>  	if (err)
>  		return err;
> 
>  	err = join_grp(sk, "packets");
>  	if (err)
>  		return err;
> 
>  	return 0;
>  }
>  $ gcc -I/usr/include/libnl3 -lnl-3 -lnl-genl-3 -o psample_repo psample.c
> 
> Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
> Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/psample/psample.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 81a794e36f53..c34e902855db 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -31,7 +31,8 @@ enum psample_nl_multicast_groups {
>  
>  static const struct genl_multicast_group psample_nl_mcgrps[] = {
>  	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
> -	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME },
> +	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
> +				      .flags = GENL_UNS_ADMIN_PERM },
>  };
>  
>  static struct genl_family psample_nl_family __ro_after_init;

