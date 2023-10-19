Return-Path: <netdev+bounces-42804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F55D7D0332
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 22:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85732821DE
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 20:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803356126;
	Thu, 19 Oct 2023 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaSzYQyq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8B3DFFC
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 20:37:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D73A3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697747852; x=1729283852;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iH7dXlNjLfmn/jcB2fvDBE5UJoBAKi04fD++1baRjs4=;
  b=PaSzYQyq8ZSGbMgpC2ll7eMfW9g5N2+Asd1lWcUt+8nf0A3LQpp4RF/M
   CdnZmI6dCm1EZ7dZY6R2yZrMT215NU3kpqxWX8L/19DdP44Rpv8VRcphC
   UOOqBtCjyhXbt8XO89iGhbA8LlYUe576M28ry4cWE3W5JeDgSOozO9VoC
   OYifO0ld6SGFehPX9NZoirEDxDu82HFqTiqlwFYWfg6V5zij/cWJw0NAx
   LcM6acgKOnXVTYJ71sTLHIO/F7WkmrE0bkU4gzAmJQmfvrrb0k7dn+kl4
   Cp8Ya0FUM0hQn3wvxu3lJP2DTtdITwWYllP/b0zb9T7Ey/VBNv5N1rg0S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="7925546"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="7925546"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 13:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="900889456"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="900889456"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 13:35:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 13:37:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 13:37:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 13:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU+6ihKvGzcFpsruuS8S/ZAXnFcUN2L8eVGfLmU9S++OWCIE1U7EH5XASk31Jsmxrt01l/xh8N+Yr+WRwmUOyotgldMfQmosqWXQGnk15uvgCDFA+D8XGuL3FffNcVgYgN05PHn7Na/1sikYr0ksydpB/VaTYZV1ERdlh4cu6+MrNBGzgXlvYItvKtmiK9NffUh6GJmmcZN68vWwh2eRAiTzVGWrtLmtvWTJnAp9KtJvDpz+OMb4ic8Vg3K6m4OodG8YvqI7qRO9tCitKfqXWyF+LPVcG5oMwqjmH4F73MKIo7c77cWoGIxE+g6ODploBJsbCti51EIFkqw3WpWHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc4u6Ts8oaeRLVgp5akqh9QQ1uVk8XVjHhxACI832ig=;
 b=QOLLa6Kumbgv8aCbEglhIqw0O5ozUbJsNl3X8BdJn07ryoqSWLM1G1bzr+/2UNmP4zzLnzhJ4Do2EBt6nCB+h7wdL16g2soVhczD0j1xTqgOrv5GTacPI9S79fB/Q5z1arWCH5w1HQA2kzjjAYuxMoTGPOBoFjSM4Hskt5Fq8z6aOd9xRWTQMlg8VKk8/W00IwePpgHFxvvMvEdKs+Soj6ini53lxFNcixrq4z7ldEvo/M3iM5bI8X2mr/lFjhB37WL2mjCmY11PGOUpvvUK3HhaAS3Gxmp5KFyMeSbbvYxjISmcf7/R+0sWMC4ks+iPQIAreAqIMUrd34glROA77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH0PR11MB5643.namprd11.prod.outlook.com (2603:10b6:510:d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 20:37:26 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 20:37:26 +0000
Message-ID: <512f27ac-0502-3edd-c5a5-b64e61712305@intel.com>
Date: Thu, 19 Oct 2023 22:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next 09/11] ice: cleanup ice_find_netlist_node
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>, <netdev@vger.kernel.org>, "David
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
References: <20231019173227.3175575-1-jacob.e.keller@intel.com>
 <20231019173227.3175575-10-jacob.e.keller@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231019173227.3175575-10-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH0PR11MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 487f40c2-4346-41ea-6224-08dbd0e33454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XF5b22CkvUhwlKZ6V+HrvRoZGTDeNTUZiyZcH3sgPo7bO+Y6BvSHz7023VOk3oHyNfsdIxL6VJJ5Mx2gQrVh3Kw0+KhfTCXMTbUuU1uQlqbcM2NiQMF80q/VhBLIzYwEuPGqdE1Edti9S0jAUaV4v7cLX2yEzQUzWHmfEcIODVkcXoCpjafbiTVArAOFQJq4h+GTj5K7jPdm3a2pxS0/C1Iwc/kuDpknSfHHZ4gIQzmE1I1LmODZLTPpOFS/gn8IEWYkDYeoAf5FBF77VEndQsEQ9E1htxbQq/S2GRIdFj0D6wm2DfJVKCmd3mLqWecuwVvxpim4eI8HP2p750cxwn/NclRLRX8iMyjTGjqRx5hRAqOZHwwuWZKmYMcZ+ECcRYqnN4Kqf9lbtVHw9dguTcUKGHL6VuDFJg3R/XUr9US76iScz7YyA0Q1tIoP6RVEVVGLognU5DXSpBg7jVCluWVzssMSCs1X6CRzT59FOBGjgBUQrVo7lVVWO78enmOaMz892njlfriHX3aGXAIlQqfU+0acXKQgxxh9nMWd9M7q7nNsYPW0yNDm+dNy5hb5Qj+Xnq1lROzCsSSPimVGr7kEHUyiLbyTJQC8Q9ig3LgtD1JmeCfVEp16Q8iETd1qI+hzTXOEKf2yAMlwnuPvgAU+CMho8wWkI5eGQp7st6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38100700002)(2616005)(26005)(53546011)(83380400001)(316002)(966005)(6486002)(8676002)(4326008)(66476007)(82960400001)(66946007)(54906003)(66556008)(86362001)(8936002)(478600001)(36756003)(31696002)(41300700001)(31686004)(110136005)(6512007)(6506007)(6666004)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tzd0d2NsSGVIMERNZ2lzL3EwSForR1NPbEsvaS9XdzRxN2xEOW92aGlacDlj?=
 =?utf-8?B?MmwzL09uUE02ajhEVncwdGFqajdad2FKeExvbEl3bHptWlVNN1VuWlphaGdk?=
 =?utf-8?B?bE5jeU9NaXlPTmRKSC9la3BrRnNOY3hEZlBmcHNLYS9MZFFOdFFUWVpyZ3Ry?=
 =?utf-8?B?dk15T3J0cFBDODJ6K3A5VVJTR0FCWlJCSDd1aDJwY3EyQzduZ0FSSnFPT21D?=
 =?utf-8?B?bUVpQi8xQlg1Nm5wNkRoMmZSdHhCM1gwMFJZQ1BpT3JBQVM4aW9xejZoOU8x?=
 =?utf-8?B?S2RlaEpqaHIxRG5FdVVhQ1R0RUFYbERWR0diVkd3TmVXeHdjRE92K3RSbjJB?=
 =?utf-8?B?NWthaW9GTnZmNnMweXZ3ZWN1SGVveG4raDhzdWY3WEZvSmZOa210NXRsVVVY?=
 =?utf-8?B?OGNiR0QwZjNlcXpFQzZYbEVYREw0SmdzNUcxcitGUGpySWQ1Qkxid3NDaDdO?=
 =?utf-8?B?NTlLb1V0QkZOVGFFMExORmZXbGtuaG95bExPTUZoSVh1cTJkZ0pVajYzcWRo?=
 =?utf-8?B?bEJuQWw2aHMrVm5wVlN1eDdQWmFtRVdzK1lZS2FLL1hNaHRnSHJlcU5QTlVs?=
 =?utf-8?B?bjBLNjFxelM1dk5jbndwK1FhNHVubzNOTml3VndTMlg0ZTNIMVl3bnVqQkd5?=
 =?utf-8?B?bnZvaXFOeVpEejhWdXhPZkFpK1B4VDZlUUhXdzM0SjhvUEI5dEtNSGR6cGgr?=
 =?utf-8?B?SFlHZERQU0NlcEM2S3RvYlhGZUUvd25sb1ZqR0Jib0syN0JVWjU0VDdqOW9Q?=
 =?utf-8?B?K0l0WmhkbEZHTWZsbGtYTk02YWhLczUyQzY4NStlN1ZvTTZkYTlIWFE2eldB?=
 =?utf-8?B?TmVWNFFmbFI0a1cvZlBHUnpJazMrOGh2RzM3YzAvODUreDc5dFQwNVd5WXhH?=
 =?utf-8?B?clFlRENqRkcrVm4zd0w1R2hHcGhGc1FZeCtTTWV0aGZkYmkrc1pWUHQ0RGp2?=
 =?utf-8?B?emJLRUl4dVZPaXAveDYvdi9FRG5GZDNUanY2c2ROamNnVG1ia3VwRzdBL1l4?=
 =?utf-8?B?aU1qYkxxYW50QlBMSGh1MW01RDhYVldEV2g1Nk9DNVd4VVBGay9GSU5CZUhy?=
 =?utf-8?B?bGcyaTR3aUs0ZDYxRUFzRUQwdVptMi9yZmtsMCtMSUwwalNDOHF6WHdGZDFu?=
 =?utf-8?B?b0JuZUozYWFaN2JuNUQ3Q3N4SU1Va2N2aUp5YVFRckEySTJIelJjWEFXSE5L?=
 =?utf-8?B?UlE1dWJTNmhNbzVMWkpJd3NBNDJtN2t0MzdQckppL040akdYK3FISXk2bGx4?=
 =?utf-8?B?QTVFWi9IakhrblJhMndMWTJSNkJUU2xIV3ZNZ2xHRE1COHpMa1lOTFpidTRX?=
 =?utf-8?B?OCszcFFCUG5VMlFtREFYY2J5cWdBam9oSDY0bTdlOHBnTGh6Qk9KWHZNMlMx?=
 =?utf-8?B?bU9pNWRmWDBrcTY2eXVjL3orWXVmaFVWRnYwYnVhYWhSdWdYcFNvMEVTTDRG?=
 =?utf-8?B?ZnhhbFpzVWFHd0tLVDg4NWZiTm9qbndkT0FBMEFjd25lMGVKTVR6L0kwWmxR?=
 =?utf-8?B?WnNSU2JRZXZHekE5MGFUZXZoa3d3Qm5lVVZXak9sN01IOXBsODVFVWk0UmFr?=
 =?utf-8?B?OUJTOTRib0RLZUI0eVprOWd2bVZwVDlCcjBlVGZsOTRyZWZwd0pMaS85RWhM?=
 =?utf-8?B?c1FNSFBRYWNzVlVubEVSVnl0N1pZS09YTTMvNklyNkJLbGJwTHlvN0N0U25M?=
 =?utf-8?B?eTNUU20zY1VlNlpIWjdOaVJVYmFockZKeGkxTlk3MmhkVmJiYVlSdjVCRFBj?=
 =?utf-8?B?bDgzS3JmVDB3Wld1UWNEN0t1dlhHUEpwSldVQUJod0JYaHE0ZnpxM0JiYnVu?=
 =?utf-8?B?ZHhwaEJydldQSUxFQWhHQVJlSlUvbm9IbjhiK0M4TDRZWk9sQm5NZGJFcjY4?=
 =?utf-8?B?aE1wSG9YNFk1OHp2c0o0d0NYak5QMnN5ZmJMZlpZRGRQRlcyaCtwYTg2QThy?=
 =?utf-8?B?SHpkV2F6RW1QVWdVd2VBNno2dWtNaDl1WThZM0ZmRjZta2RhbjdQak91SG9y?=
 =?utf-8?B?SXMzYzFueHZ4RDJYSVp1YWZualNIOVdSUGhubGl3TVVSakpUajd0ZUZWWEE0?=
 =?utf-8?B?UjJCb0t2ZmVWNURDeXBCSzhtOTJQMGdVRFFwbVh6d3BJTDhBTzBxTWZVdzdE?=
 =?utf-8?B?cEVMaHRpYTBVbWptRlYrWE5kOHJXNnc5TXh1Y0x6blBPMG9rUE5NejRRQ00v?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 487f40c2-4346-41ea-6224-08dbd0e33454
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 20:37:25.9757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wj7rKvjfbm7tY0oz4pH+Xd7CT1fugRp9Vr7L5vYcb8pleTRP8IVJBUIYLnh4D4XbJWqbu+Nb0Af6Age1eV/75y1g1I1e5CX6aAVwGiU+yJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5643
X-OriginatorOrg: intel.com

On 10/19/23 19:32, Jacob Keller wrote:
> The ice_find_netlist_node function was introduced in commit 8a3a565ff210
> ("ice: add admin commands to access cgu configuration"). Variations of this
> function were reviewed concurrently on both intel-wired-lan[1][2], and
> netdev [3][4]
> 
> [1]: https://lore.kernel.org/intel-wired-lan/20230913204943.1051233-7-vadim.fedorenko@linux.dev/
> [2]: https://lore.kernel.org/intel-wired-lan/20230817000058.2433236-5-jacob.e.keller@intel.com/
> [3]: https://lore.kernel.org/netdev/20230918212814.435688-1-anthony.l.nguyen@intel.com/
> [4]: https://lore.kernel.org/netdev/20230913204943.1051233-7-vadim.fedorenko@linux.dev/
> 
> The variant I posted had a few changes due to review feedback which were
> never incorporated into the DPLL series:
> 
> * Replace the references to ancient and long removed ICE_SUCCESS and
>    ICE_ERR_DOES_NOT_EXIST status codes in the function comment.
> 
> * Return -ENOENT instead of -ENOTBLK, as a more common way to indicate that
>    an entry doesn't exist.
> 
> * Avoid the use of memset() and use simple static initialization for the
>    cmd variable.
> 
> * Use FIELD_PREP to assign the node_type_ctx.
> 
> * Remove an unnecessary local variable to keep track of rec_node_handle,
>    just pass the node_handle pointer directly into ice_aq_get_netlist_node.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c | 30 ++++++++++-----------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


