Return-Path: <netdev+bounces-16084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820DD74B5A3
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82681C20DB7
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09811119E;
	Fri,  7 Jul 2023 17:16:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51F11196
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 17:16:30 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD5C2123
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688750189; x=1720286189;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iMXBAkSrlZa22S1fH8M6TY+P/6AkXonT+Lih5gq6Fvs=;
  b=fZq0xJoKnK0MoFwJKuVKC8dqCLYb302+7ct5pE/4zpnZm3yg9Hm6+pRv
   mqxEDKKe7PgRSLixJ5dWT1xHrffOqLLVW3soqx6C/gxFwAqEzcS0JRdc0
   1kFNtp4cJE8/36kBwRfLbJVO6uiyfN6eNvR/1lspPCMHg84Z+EaeqyAKq
   NDYj+rTtZnxp1MhFqkM444YndTzTrKh4PlWAgXHwqYYEFWdrfV1O6Dwdf
   kEI3zbrR9xQCnJuCwRNQ+apggkNuUtV9c2bLVnRyU2Z9rvPAuwGpf24xw
   pTwzy2bTPm5d4q8jy/SPUGd7IiSSXc2yMpy9U6bdGCRKbFKH1tn7+lfmT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="394707597"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="394707597"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 10:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="790052088"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="790052088"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2023 10:15:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 10:15:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 10:15:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 10:15:40 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 10:15:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DImbxAYX/ZfLd3QHcp34ZYWfXkpDGV54a9rQ0N1FguCBJZwlLyYFWlw5pwuBt2AWApaKp5+oP4DLtzSwOtR5UvfSa3fnMli6ZlQwKAXhc26Ianp09VCbL4C43BDDuqdjJBxM8hNUqFWxzVW9zuZqTqLYptWj2DrZvYhASEIox+09xZfic9OXoZExieLtiy88SVeubSBM+Nb2a11Zq1LdIGOHHa9+dMkz0l4WhusVJT9A8lZJ5POH94X71xnEQ2Cc3XNcVBd6lcxN2QzXyyDbOYIokPqHFF0Dg5eKFNimcKHvH1OP45extbEXeyj6MzDTzCJ47CKIOT2vv2Sa2t7YIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDZQ4Rk5oc/vaVLcih4Sn4GnAFEhvaW7qE3qNNmnE6U=;
 b=dq02mvUT4bJAxx00B9VAuFnx8bOxIPPqZicQJynwKdTj99SesJbv6ceecvVGPVrORRjYKdKVlH4opTCWug6CT0UedFm5y2viA0DRE855OmAq+x7twy7v4o7vqNs56bdfllbSAfDT75GIgcLDPE+rTA8twCpmYqCn9MGcI1HUFEr/2eoOYqxqacf8Jsf5sWjzJ3u7p6+x9mp0TdwRzjojkgI9QWKvyanWtSjD0Dk0/gbF6OTsw+2J26eN4TeNAFv6k3/XiMzhIMojSYZqHMMjgutIJjW8KcWzAKci1VxLeTBnNBMnpy579UvdtoYrJT/nlF8uexxlT1G/fe5+bycEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 17:15:36 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::bdec:3ca4:b5e1:2b84]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::bdec:3ca4:b5e1:2b84%7]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 17:15:35 +0000
Message-ID: <4359387f-297a-7057-d7ed-770dc021086f@intel.com>
Date: Fri, 7 Jul 2023 10:15:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-net v3] ice: Fix memory management in
 ice_ethtool_fdir.c
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Michal Schmidt <mschmidt@redhat.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>
References: <20230706091910.124498-1-jedrzej.jagielski@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230706091910.124498-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0254.namprd04.prod.outlook.com
 (2603:10b6:303:88::19) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|IA1PR11MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4c744e-3bb9-4c24-ba49-08db7f0dc65b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9p55AK8mXg20G9La/2BQ0BqwBGB3G1Kr46NEWlrFahIB8JSkCE2HoL3YPSczbuoajGJATwiTDnwNMwjEZ+Pl/f1a40Du93mPwCcTuBihfsmyCKMIXFwXk4pQmvAMVhtiLOm52NU8rerP/4lzeArPoQDtVnzfBWNo/pLk3c7GTqMyeOm8fKXez8EM/l/uIWUN0zZYmwGu9Id78/S4uTvMXmtdNEbTEeNXbfzwOoe5zkJhWBE7W2/JUmFnCHCuzZcDSTmcV1S3Zo2V+YDY9j8ATMSOyJa4G5GRjWdS7EnVSvMFsQXbnT0c/jpdKJBVF1HqOZWBZeF0rtC6gFy1F0HCzA8qvXv7WcVfEvAEk4cdoMrkmY2a20aIu6s4WGT1R67lUWV7QPS0Cg4hD0J0RS9TPmLEG/QXxcPq4Bs6vRvwUFABrvW4lGvVuJZw/qbrN9rs+o5c3xKz/TlkU4TCfB2j/MJ9SjTDtD1f06fc5DwDV0jI4dpED9qNzcvp0CJ8pbacqNgyYSStv6jj/bhzuA0jCrHXZ2Y6IAM3spvT6Dgc5JP0ur9p79Euhy+DIVycW36j6LWTTvxrNnxYVF3zHTTq5zh3U8PytOhejMNHWc2MkrpyX4Q0Hjp3pPXL88srXimR9gagbCM4LFwFt6hemLBvuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(66556008)(8936002)(8676002)(2906002)(2616005)(5660300002)(6506007)(26005)(31686004)(186003)(53546011)(41300700001)(107886003)(36756003)(6666004)(82960400001)(6486002)(83380400001)(4326008)(66946007)(316002)(66476007)(478600001)(54906003)(966005)(6512007)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1N2aHphSDZiL1lpYkxWVXp2N0tRRXVncDY2T2h2bk1nZ3FOUDZhK05WckpY?=
 =?utf-8?B?MzJCOE5Qd2czMWhFdE8xbzhyNDFiaXRyVEJKUnJZN0pPbWJ0T2k5UitCTGdx?=
 =?utf-8?B?K0RBQ1YwODNnZUhwdi8yc0p2anNncWVpcGJzd1BpcVZoWm53aFg2bEtzZVR1?=
 =?utf-8?B?ME5ZN0tSOGNHRXplaWwybzgwcDdlRThUeHJvWUVRQ3g3V3VFL2ZqcEZVVlBi?=
 =?utf-8?B?Q2hLbE9Xbk5uVXpjUmNqcFdwQWhRYW0vSktTbnhsTU5CRjlvNkgxdmNuUDh3?=
 =?utf-8?B?MXR6NlpsSFdNRzkvVGlMZnBuNVJmcWxxdEkycmEzemg5Zi9jbVJIZGcyZGtv?=
 =?utf-8?B?MmtiNGR6WVRySGliRnQvN244QkdqY0dRdVpnczJ0QW9nRjVabHZLbHU0b1FV?=
 =?utf-8?B?ZUd2dzRDOThwK1pvVEQ0cHpWZnM0WDJyT2Y1OFpCZUxPOWs1YzM2UXY1T3Zk?=
 =?utf-8?B?YTgzQ3BHMVlwOXFtR3JEVjIzQlNidUZuS055YVFXYTZRc24yUXFtQkxvSVFr?=
 =?utf-8?B?eXVKOENseWg0b04yb014MHRXbDdZVEdSYTd3aU5SRUlYK0RpNk1aS3VBSCtW?=
 =?utf-8?B?cVN6eGZ4RVJ4eFQ4a3VISGZjSWJUMlFYTHBzOFZWUy9EUlgzT3NTWVJ5ZnhZ?=
 =?utf-8?B?VERiK3BhNHozQVJCRGJoNUY2c1hrWFNSRkk0Mk1aaWNNMjhZNFZOZ2hjdXdD?=
 =?utf-8?B?ZnY5NTcyNHl4RGpQNGZZZHZFei9NL1NQVHZHY2FodVJka1F6MGhzcFlGZ20w?=
 =?utf-8?B?Y1FkaEtvcTN0VVo4UE9jMUQ0RGhsNEl3WFVMeVh3TzZUd0FmVGtPSGJYVHVa?=
 =?utf-8?B?RUc2RElqVlQ0cmNtZUxzZHRDeFpCRjJ0MVYxVFo2UjZnTzVvK2t2U04yVGdL?=
 =?utf-8?B?T2RWdzFKdEhCNFNGdnBFMTAwMUVUeFI2TnViY0VsSmZGMDI5V2NFbFhPZGtr?=
 =?utf-8?B?KzdiOUo3MXE4dnhwWExWZkhQODczT05KWHBkYXRwU0V0Nkg2Vy9ua1NuSkdF?=
 =?utf-8?B?b0psRmdPeUZEMDhUb1NQTEpoY3BYRmNQQ0ZvempTL283d1RRd2VpTFFORC9J?=
 =?utf-8?B?anc5ZU1ZekkrcG5sRXhKeWJCOW0xT0poNzdIc0lWcTkrdVhXUTR2WHBtV3pa?=
 =?utf-8?B?bEZkc0VmMzNjM25DQ3FLdVJUQVBLcFpMandUT1daZzF2d0F0Q1U0NmZjNGV4?=
 =?utf-8?B?bWlSNC9nUW1EQlFNT3JUQmtHVEZ0YWhYUkR6V2RZL2RDM2RYMEovbytIdjUz?=
 =?utf-8?B?QmxyVmcxQytVamFYZG11YmZVUStjOXpMeXphUzlQUmZ0RmZidkxiMWF4TGRq?=
 =?utf-8?B?QmVDTCs2UHNVMm1QQUR0RDVrcUJHZW9aaHBFNUthOUVuM1dxVkpzVm9lUDhD?=
 =?utf-8?B?NzRJZERRQUpUUG84bkZPK2JDMGtYOEdnRFFzMTk5ZDRzYk40NVJuL1A4ZVhI?=
 =?utf-8?B?QWVJU1dFQmJZZ1lOR3JhMmlCcXhFWmdUVW9XUmJxNEZNcXJhOEd0MnpEQkRY?=
 =?utf-8?B?RzFSQ3pTWVE5aGNjd2dyczVtK2pjQ09aQXcrcjFMT0FIaSsvZXRsUmtSU3Jo?=
 =?utf-8?B?d1d6VkJKZVhpVFE1T01NNHlKS0FUNkV0Z2loZkNyV016WnFQSVJyTHp2MlNk?=
 =?utf-8?B?MUVBRXlWc2h3cmpKUzBFcnBCOGRGYXJQbVBJbit1VVNtaHdmeGNQNm1uU0VM?=
 =?utf-8?B?THdCQ2Y3WlBBR0RNRlBwTk5DZENBNjhORTM4dVM5NnNjeTVVVWRwVk95eG9R?=
 =?utf-8?B?Q2NBOU5JVWliYmt2SmtWb21samtrdEp1bjRxOWd2QlFKbi9YMTRpeWR2RUtk?=
 =?utf-8?B?Wk5NM0xxZHZvRzBMSDA5VGg2amZCSU8zN09SSHVuaVBXVG42d3VINVNLL0Jy?=
 =?utf-8?B?OWlvd2ltci9FcXE5Wm1WQ0l1UnVkSVV0aVVDcVRyTVptejY1bHl6czRNMlAy?=
 =?utf-8?B?R3NrejJkREw4cWMrcjBoUjQ5bzF4VFBmKzk3Q1YraEcrMVd0N3d2WWp5NDhP?=
 =?utf-8?B?cXB4QU1Nb0htT1l6MGl6T2ltVGFPVjNkTkt6cFhTRkREZHBJaDBFUW9QSGVw?=
 =?utf-8?B?OCtvYkhJQ2Z5Z0tOZ1U2ZEwzQjV4SmJVRGFZNWZZUEFmT2RNS3ladWIrY0JJ?=
 =?utf-8?B?ZGZ1MnZodzVnLzcxSGNnWDR0dy81V0J4eTZTaFdhZ0xZZGMwVktyNStmMW9h?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4c744e-3bb9-4c24-ba49-08db7f0dc65b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:15:34.6677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnsS9l2szAXPYjDqM93NyyWj8HIieYgzyXro0GXHxIANIr8oJoBFnIOEa12CDlqe3eiyoWHZ8rqF+RxQKln2H52MQGrO0qe7QKxrwLgCrZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6217
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/6/2023 2:19 AM, Jedrzej Jagielski wrote:
> Fix ethtool FDIR logic to not use memory after its release.
> In the ice_ethtool_fdir.c file there are 2 spots where code can
> refer to pointers which may be missing.
> 
> In the ice_cfg_fdir_xtrct_seq() function seg may be freed but
> even then may be still used by memcpy(&tun_seg[1], seg, sizeof(*seg)).
> 
> In the ice_add_fdir_ethtool() function struct ice_fdir_fltr *input
> may first fail to be added via ice_fdir_update_list_entry() but then
> may be deleted by ice_fdir_update_list_entry.
> 
> Terminate in both cases when the returned value of the previous
> operation is other than 0, free memory and don't use it anymore.
> 
> Replace managed memory alloc with kzalloc/kfree in
> ice_cfg_fdir_xtrct_seq() since seg/tun_seg are used only by
> ice_fdir_set_hw_fltr_rule().
> 
> Reported-by: Michal Schmidt <mschmidt@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2208423
> Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: extend CC list, fix freeing memory before return
> v3: correct typos in the commit msg
> ---
>   .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 62 +++++++++----------
>   1 file changed, 28 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index ead6d50fc0ad..619b32f4bc53 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -1204,21 +1204,16 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>   		       struct ice_rx_flow_userdef *user)
>   {
>   	struct ice_flow_seg_info *seg, *tun_seg;
> -	struct device *dev = ice_pf_to_dev(pf);
>   	enum ice_fltr_ptype fltr_idx;
>   	struct ice_hw *hw = &pf->hw;
>   	bool perfect_filter;
>   	int ret;
>   
> -	seg = devm_kzalloc(dev, sizeof(*seg), GFP_KERNEL);
> -	if (!seg)
> -		return -ENOMEM;
> -
> -	tun_seg = devm_kcalloc(dev, ICE_FD_HW_SEG_MAX, sizeof(*tun_seg),
> -			       GFP_KERNEL);
> -	if (!tun_seg) {
> -		devm_kfree(dev, seg);
> -		return -ENOMEM;
> +	seg = kzalloc(sizeof(*seg), GFP_KERNEL);
> +	tun_seg = kcalloc(ICE_FD_HW_SEG_MAX, sizeof(*tun_seg), GFP_KERNEL);
> +	if (!tun_seg || !seg) {
> +		ret = -ENOMEM;
> +		goto exit;

IIRC individual checks and goto's are preferred over combining them.

>   	}
>   
>   	switch (fsp->flow_type & ~FLOW_EXT) {
> @@ -1264,7 +1259,7 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>   		ret = -EINVAL;
>   	}
>   	if (ret)
> -		goto err_exit;
> +		goto exit;
>   
>   	/* tunnel segments are shifted up one. */
>   	memcpy(&tun_seg[1], seg, sizeof(*seg));
> @@ -1281,42 +1276,39 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>   				     ICE_FLOW_FLD_OFF_INVAL);
>   	}
>   
> -	/* add filter for outer headers */
>   	fltr_idx = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
> +
> +	if (perfect_filter)
> +		set_bit(fltr_idx, hw->fdir_perfect_fltr);
> +	else
> +		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
> +
> +	/* add filter for outer headers */
>   	ret = ice_fdir_set_hw_fltr_rule(pf, seg, fltr_idx,
>   					ICE_FD_HW_SEG_NON_TUN);
> -	if (ret == -EEXIST)
> -		/* Rule already exists, free memory and continue */
> -		devm_kfree(dev, seg);
> -	else if (ret)
> +	if (ret == -EEXIST) {
> +		/* Rule already exists, free memory and count as success */
> +		ret = 0;
> +		goto exit;
> +	} else if (ret) {
>   		/* could not write filter, free memory */
> -		goto err_exit;
> +		ret = -EOPNOTSUPP;
> +		goto exit;
> +	}
>   
>   	/* make tunneled filter HW entries if possible */
>   	memcpy(&tun_seg[1], seg, sizeof(*seg));
>   	ret = ice_fdir_set_hw_fltr_rule(pf, tun_seg, fltr_idx,
>   					ICE_FD_HW_SEG_TUN);
> -	if (ret == -EEXIST) {
> +	if (ret == -EEXIST)
>   		/* Rule already exists, free memory and count as success */
> -		devm_kfree(dev, tun_seg);
>   		ret = 0;
> -	} else if (ret) {
> -		/* could not write tunnel filter, but outer filter exists */
> -		devm_kfree(dev, tun_seg);
> -	}
>   
> -	if (perfect_filter)
> -		set_bit(fltr_idx, hw->fdir_perfect_fltr);
> -	else
> -		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
> +exit:
> +	kfree(tun_seg);
> +	kfree(seg);

Previously, success would not free these. They look to be set into 
hw_prof via ice_fdir_set_hw_fltr_rule(). Is it safe to be freeing them now?

>   	return ret;
> -
> -err_exit:
> -	devm_kfree(dev, tun_seg);
> -	devm_kfree(dev, seg);
> -
> -	return -EOPNOTSUPP;
>   }
>   
>   /**
> @@ -1914,7 +1906,9 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
>   	input->comp_report = ICE_FXD_FLTR_QW0_COMP_REPORT_SW_FAIL;
>   
>   	/* input struct is added to the HW filter list */
> -	ice_fdir_update_list_entry(pf, input, fsp->location);
> +	ret = ice_fdir_update_list_entry(pf, input, fsp->location);
> +	if (ret)
> +		goto release_lock;
>   
>   	ret = ice_fdir_write_all_fltr(pf, input, true);
>   	if (ret)

