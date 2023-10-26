Return-Path: <netdev+bounces-44498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 716E17D84EC
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A10328203C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB8C2E3EB;
	Thu, 26 Oct 2023 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FP6OjOtn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E58829
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:37:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D286D1B3
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698331074; x=1729867074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1qwTCnW+IEpUEtrBNwvHimf5YA021r0UQsCQOIK7d58=;
  b=FP6OjOtn7aJ66gRyGye4aTfy48EUGIg81BPr1f1+dhPZujWw6sKlFrGj
   pXRM6z/kEsractcNPJxtbLqRbhoOmnVLTbcJswrez6E8U1nfyd9doPcKD
   x+fDLlhKs8GruGvW2pjriph42kDiUcQzZx4IikKg93iSWMNiIME8e2EWP
   OhzJPuP3dgnUoEgJwp5QhHY26xmZoHyMsnG2I6I2QhEeP5kFffGr+S7+B
   +F1QM8TMyCtFIXckZQ7ENKdTmazrIYq5PSogO7SlkniLa43B5OVW3JNOA
   nicqSvnGFz0E0O3U5+qrszRZFuTZxwwjXPtG91jS7cW8Hr7h+8rwbrx/K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="366911899"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="366911899"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 07:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="7305386"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 07:35:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 07:36:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 07:36:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 07:36:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 07:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIBofBduP4hzg6I3oHnXTmpuOsp0EI7yf0AqvnBO4+dl54Dvg6nLXjBn29ZH2dQbg0Q8EF1x2l3UmbudufXnAmtZrmaZyvtckqoKAMweH/vErbJHtezP1JovXFvHXN5EUoaSDfb+pHC6nozqmG1xz4uhDdLfsMVqa6b0MU6SIesWMXojc23gOPt7dbKRgQ3MGfwgn712hjga5v7JkoKZuk778LmgimTk9rSu8k6HbA4Z4Ef2GWBx6Ikq96HYXIXrXjgkZmOWGL4z8LiGf6D7cA6hpAnuBM7ATZ61pnbXWOTxIe2zA/iQNeLUxV3VTe8XcOrDFlzVgq+9gqZWrWvHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+av9bE6CXUTq4S6wzXRETFa/lpCh8oZoaSeh8dcjQM8=;
 b=KzN8qEKvBrq2913hhVcgRNYCtmsbSgwaAmCM5wd2qHFBp7taELCfdI85ZQYrRyWwXh0ifLdUs5KJLVKn767pcqUaJ+DTZukV3Z90KzfQQanuYLhWoRPZiqfVWNSmBdMyhXPipzvjFAlMfP4yvG4uRUDu5dMrhWAP9M/Mb/H3d1py8UADr/Zp6P2fnC7t02mQE+RGm82L9r/dUJKc3pSYkTMqKUIWyqKQLdUwa9J2w9Q3XFAnNfQJCvFlBs7T50NEYGFSvS/f+GUuEC1IxchcoKB/GiaDU5+hRrYU4OPDnT9g7/GxyT5CEfsiHJaaFLHHIfTSNp92J2ZxCsivrWqi+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH8PR11MB6928.namprd11.prod.outlook.com (2603:10b6:510:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:35:59 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 14:35:59 +0000
Message-ID: <082150a7-f2f1-40bf-aa4d-81d4b6f5ce40@intel.com>
Date: Thu, 26 Oct 2023 16:35:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnxt_en: Fix 2 stray ethtool -S counters
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<gospo@broadcom.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>
References: <20231026013231.53271-1-michael.chan@broadcom.com>
 <1014e04b-5e74-4f7e-b2a5-ed0f8d01629d@intel.com>
 <20231026072830.1202cccc@kernel.org>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231026072830.1202cccc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::17) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH8PR11MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a6b75a-3bfe-4ad4-1b99-08dbd630df10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGzEBL/rH874qwlEOv8CDAfiGhWzCenL3pTuDDJ8D5k8fJtyukNRf/kaQVe0ITE2yvpHnSFndUOPor3XKb7ourtSA4hsnsoZ8/BlScuYVdu2faZ53hEPhrA/ku/srw4T5ncTXjfLiHtrj+A0zsljjZvx0BJpVHcULPp3O5escpwKFb/AvK6I8Z5UDKgywg3GH0lAMjfmVhpiaB9EM7TVr4qPv3jtEHZCzYcLtTLfCa8gXhIc324IeLmgfSade6Z1Os3tWy3xhvfd0a4F2Q7CLeIJS8cJlNkBiEpPcR0QuAP1PjA1LXMJdCDn/jaQ63mlTm1ONPa6H1l5yXpyzO9t144VyMJYHyA8ECJiCil9A2NJC1pSNhRGH7V7zr6PkwOX9qqWg0540xyHOcvPrLqAh7QZgnWUaM3GnzJG9BibSHtVt5IytEKLa5lYcTfl5zCseoSaZNzopU8DeQlkTRRod3aLTjkl3QP2mut1xYBoG6Fs1/G+gRls89Wm27pQexL+vRqYu07dtT0IkBx1iv84OXrRav2ARWjvbvAPoF2+LA4hxvzm2pY2Rhx6hdpP1TGWCVrvIAfoIwE1K4tWyN+wLMakMZ9X+TFvNis+1SraIrXQwRa9vuDcS3pkr1pihpuK5RdxzDhKusAnf86Fx2WLxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(478600001)(26005)(6512007)(86362001)(6506007)(6666004)(316002)(6916009)(66476007)(66556008)(54906003)(66946007)(38100700002)(36756003)(2616005)(966005)(6486002)(2906002)(4744005)(83380400001)(8676002)(8936002)(4326008)(44832011)(5660300002)(31686004)(82960400001)(41300700001)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0lyeVc0NUZKMG5wenllVjl0eVZBd2IvM1pvNXNxaGgyNHRIbjVaQlNEMmVU?=
 =?utf-8?B?VGZZYVIxQ3pZaFVDRXNncGZURjFpUVJyeE90UHF2MUFyNnVuY0VodG5MNUE1?=
 =?utf-8?B?RnAzWjU0TUFuTXV0SXFwM3U5emQvN1ZKbFRuMEY3K29OdzcwRjZIM1R4RXJr?=
 =?utf-8?B?YitPWDR6YVVlWU16T0pSa01KOGpyWXZFdXVack9IQkJscjhUTzVvbzFvdkYz?=
 =?utf-8?B?UlZXa0FueFUzRWYwUUNWb2tSbGg1S3MzbHkwcUJMQ2kweEQ0bVh1aW51QXNN?=
 =?utf-8?B?bmg2Vno5d2JOQUhJRU1oQ01odHY4RVFNK1JZR0tUZUxLcTFVeCt3aG0xNVI4?=
 =?utf-8?B?Yk1taldGNFhrYXU1WE9MRjRtdThUcG82aHN3Vml0N1A5UmJWWTZMQllPeWg2?=
 =?utf-8?B?VklSTTZnWHZKOWVTRlZjQTJKTUJDNXVFNGlVUHV4QTFldkM0QlkyTFF1TmZo?=
 =?utf-8?B?MEVYWTl6SGgyVVFMUDN4MEZkQ01Fd1hYTUliNTlabEJvSkZsNXlKR1Ezc2dr?=
 =?utf-8?B?aHh4VnBwU0pRc05ZbXJyS2ZOSTNzSXVFdldjekViRTFyVVBKUzk1ZG03T2hm?=
 =?utf-8?B?MnlLaTc3YmVnSzQ3U0tsOE9ZZzJrMi9qS1p5MGdMZk9wOFIxZVZITWlnZ2Ix?=
 =?utf-8?B?dzRscXhER0ZZSHF5blplaG9NSnEvQ2hDWjNwYmFXd3N4UVR5VHRWYkpYYlJi?=
 =?utf-8?B?MkZuL045SXNBQUtOZWtLNjRXRmN2VDgwUGI5ZGtJeW91V1oyQzZadlB4Q05F?=
 =?utf-8?B?dEtqWkxXU1JrM2ZhMmRQaHgzYUxzRk1vNWVQREZ0MFI2aU52SFVmcnpkL1pF?=
 =?utf-8?B?NnpTTDVWWlpUUmN2VGFIZFJRNE5YK1pjUlRhVVA1czZtQ1YvZnZXL1dBZHdz?=
 =?utf-8?B?eCtJb1FUaVJvK3V0Z0xHWXE4RW1sQVhIQVRBYUhKdXozbWlRbVFwZVpOWkxn?=
 =?utf-8?B?cDRwTUtjRlZVTGYvR2NKVVJWS3haNFhiZGVDUGNQM29iMnRGTHBZc3pJMkUv?=
 =?utf-8?B?T25mZU1YeTQ2SUZPQ2pCWklyVTE3ZlE3Qk0vRUZiRUE3SUZoUTJoMHo4MUhn?=
 =?utf-8?B?dDR3MThzdG9LZVgrWXNDUEMyNFBsZWtGYkJlYnRuYi96VFIrR01YZjhOdGwz?=
 =?utf-8?B?YXNxUlRnSDM4V0NidWdVUWhUNTQ3azdGNXlESzRmbXZpUHYzc3BLdFpKNVpp?=
 =?utf-8?B?NWExVjRmYmZuMlAxWnA1THh2eFFibGtpNDhoQ3BYYjU4ZndGWGRXQUF5aGZD?=
 =?utf-8?B?NEtDVHZHRllJUy93NWNVOU1jUDBsMGMvRFZJVEpSV0xVZmFrWnlZd053TE11?=
 =?utf-8?B?MVRNYkVlQUhMUFcvUmVWMVZrTXZJdnBMWUNwM3lGQVdHVkZHYTZoNkhRS1gr?=
 =?utf-8?B?alM0RnNvVCs0RjZTSzk5TzdWQlhnL21haFN2cDlpM0lDaGZVaWRwRExFL2Vt?=
 =?utf-8?B?RSs5UUFocDJ4TGR6ajZkV3YxbEE1ZllkUGJ3K1lhbnhEREFRVmdaNEI2bnFF?=
 =?utf-8?B?Lzh3bnpFTHkyQ1lDcjMyRDNaamdEL1NlMk1iN0Q5a0dmSW1LQlpIMERURUMz?=
 =?utf-8?B?RFRsb05VU3N0ZndQMWhRdjlWdTBMYjRmZHJuQmluQ3RsQ0ZxZFlUUDdUQWk4?=
 =?utf-8?B?SU1sbytHbkFjY0o2U05udDAxNHdlUTJaUnkySVVsTkhSZFVFSkxmY3V5dXE1?=
 =?utf-8?B?b3k0WkUrM254elJJbWxzTHowelNoaEdLcG04ODRaY1YyU2ZEMFV0ZG5pb3Jz?=
 =?utf-8?B?WHZtYVUvc2l5NU93aFNXSE9aVTE4OEp0cVJqZzcwSTlacTQ2NmZoZ0tNdE43?=
 =?utf-8?B?MTBoQy9iMUZmcjVXeTlqQmhSb2Y1a05QQnFpaXJMcVdSK09zL2c1cVAyb3Ax?=
 =?utf-8?B?VmVzT0hnY1NrWkdxQzNhamF6ZURCS1gxa0xlS1ZuRFlJUTVtVk5pVS9uYmFh?=
 =?utf-8?B?SDBjanB2Q0R4YUxtWWNLL1BNcFYva2UxUjZvZndWbXRkU2IxK1MxbmdCbjdy?=
 =?utf-8?B?TFNxVGVIc3lsWVFPeWYvOUJxYzZsRTF3bXB1dXFHNzNoWVVldjB3QU1UcnQv?=
 =?utf-8?B?YUFQQ0lYRUNzTnZ3Tk1Wb1FGbTNKWWlDZUFpZ29vSkpMT0RsY2JIa2xZcy9V?=
 =?utf-8?B?SXd5MjdBRk1WUkkzYnNpQlZsRU1qUjE5RWJtbjhobVgxdyt5YVRnRlM5bC9n?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a6b75a-3bfe-4ad4-1b99-08dbd630df10
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:35:59.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYuSSBH2tqXUP9f1ufRgeoip4ITXKlKDGMLUvigVk8ccMGTbv3ktom0hb4PIZCRVENHyQLjP71i4iziKj6YZB8vQkPhHpptDDz5NcbtcA58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6928
X-OriginatorOrg: intel.com



On 26.10.2023 16:28, Jakub Kicinski wrote:
> On Thu, 26 Oct 2023 12:36:37 +0200 Wojciech Drewek wrote:
>>> Fixes: 754fbf604ff6 ("bnxt_en: Update firmware interface to 1.10.2.171")  
>>
>> If this is a fix than the target should be "net" not "net-next".
> 
> The commit in question hasn't reached net yet, this is the second time
> you're going this incorrect feedback:
> 
> https://lore.kernel.org/all/20231023093256.0dd8f145@kernel.org/

Sorry, I somehow missed your comment.

> 
>> You don't need "len" var.
>> Why not just:
>> 	num_stats += min_t(int, bp->fw_rx_stats_ext_size,
>> 			   ARRAY_SIZE(bnxt_port_stats_ext_arr));
> 
> I think it's needed to make sure lines don't go over 80 chars.

Makes sense

