Return-Path: <netdev+bounces-17295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C07511A6
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE3C2819E5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FEA2418A;
	Wed, 12 Jul 2023 20:05:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FA24176
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 20:05:35 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5691FFF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689192317; x=1720728317;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KA/Z5DFHtG5WX9xR3bdYxNhToWX2CZUC3rBvYbzIYqc=;
  b=aecxokDKP3/6bz2biL75V0+Y+ZqvytTy0JFYz2TTdsHsqUfwLFaP94Xd
   Prmd5h9iZ35SbilKW+yfWZmfq2134RoivUal3hRtZYHnBNZMT/O7FIDJZ
   MWMcw6RFh1R1Z+J/+pbYreWiVgL/0xLACzRqo8fEBlWvCYDRg01Nsg/xl
   7vMNet0IL/3BcJO5KtXbosWnYMxWbxZ5fQAG2sQzTuGqV/FtT34Co/fh5
   /YIS22kiCqdDyOh+xWHae99Xe8k1esZ+LGcI7uSOH8Tn3h6qh6O5Z+BhO
   4fo/B/hytEMTVyE8t2tTNctzorIuYiOAQN48gBYyZKUHKmvpwugLkCG/8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367617682"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="367617682"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 13:05:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="845762065"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="845762065"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2023 13:05:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 13:05:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 13:05:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 13:05:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY0DesCuSADcU5yhzymFQz8nH69QmQwZnGk1as84pCFH/QX3Z4NeI1QSEknhp1BXXEG0LdfJnLCzjtskY3f/AfUQPfNM783hbiiEvjNeT0iempym0+3cm72ncbThA+oc+hBLOhYk71rvO/muM17pWIIDAIHi2pAGwalXwQnmvVFVwQzTMO8Xk3k1cHHukuTCAx1rRf4Du4X1wne3ODlorE8DLsHYTqotBNXMcO0x2O8ibxnZmMjqjv13oX7MTl+xBZfD3Xe1HgTkPgfcLWdOW9JFJkaRJcvXwsKCl5Tjunt435o3H7aqU/+VCwqrtl+0CdFSoK9fh2JB6bk7fTbxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA0qqiUkb28l9x25mh4l03NZDd1AYoXsE4Ns14lEInY=;
 b=KRwDglpQ/wnJU2f+T8H4wcnLKRfpp3aV9bT4MaGzGNEzAuryc7mBN9RXWnw6zLrZOdRg4jawr8msfi1IfwVfrQfxvzmgHZClGBQPvFNAtq0ay3DRFSVrboGcowaXqSNX5tdQqjtwcILz3dMi8uEnHjlXz9QUVmF6o+NMTcljzdGj9RX7tTiB4buEi4x6dVFu/K3y3ckg+r7MczptaYIxYOibh8nt/WgufjzAj4VlMVvAdbi3U24eMkO4SIef4TFePap5L66boDveDKx9x6l+bC8UkNonX3y5nB/0FN2FNhySPZQ5MzMHmV/5WZyOh7OV4/5Luvd0vyY3eHO2tWuEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by MN2PR11MB4647.namprd11.prod.outlook.com (2603:10b6:208:262::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 20:05:14 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011%5]) with mapi id 15.20.6565.034; Wed, 12 Jul 2023
 20:05:14 +0000
Message-ID: <130e248f-15b8-23c7-c05d-acf08d296c1b@intel.com>
Date: Wed, 12 Jul 2023 13:05:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next/RFC PATCH v1 4/4] netdev-genl: Add support for exposing
 napi info from netdev
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Simon Horman <simon.horman@corigine.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <sridhar.samudrala@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
 <168564136118.7284.18138054610456895287.stgit@anambiarhost.jf.intel.com>
 <ZHoPBYx2lZJ+i1LC@corigine.com> <20230602230839.64530697@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230602230839.64530697@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:303:dd::18) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|MN2PR11MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc7b2da-878c-4aff-dbc9-08db83134e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drhChHbAsaDfgHG1q8RSVHfxcfCQH6zQ85FPMLalS5zGbpyolnBm6OSBIGwbfBlR1lrBHvFFSAxvBetp/v9kaNgZaGVOGPWTHBXHM8YFK0mA9mt6wNFu9W7/a6ki83BAuahcvTMXa69aeaqTwZvIaJrPxBlcGbS+12RXPv7YcGHRq+fgwLolftas6sRCVW7Sz7ZM1ZYJ1EXGEyB2iO2yshAfJO7o65GhI3DykTfpNm41lsQ28nL/xuO6cGNrGN4VCVp5eID7K8GDa3BmOqZc5Kg3nPEvvBeoAbRbJaTYRLo86efnnG23/Of1NMtEfcg/leppwf5RWAtqAMDl99N0/T9YDWzWLWcA+Y0pwHQ07c9JKvAYTHpNq8ruj2gbqEHmfGvhC11D6529Wjn3RZr+hqdTzyGFp9n4Ck3NfSAY4UU3tj2J1caEyxE935NMHFkSGkHbmpL4EEi2qdrwaxaJ7pV6ORfsSW5BtDTEwssh+a4XwD7lPxqAFu2BcDwxE6qwUCJ7MQwrWZhOeiZwrBMZNmYIrH3+w2hwVZAKOMGxLg/mk/DluJtdaopyUWAoQ4zxZSq4lGJfpfH7bHy6fnieAKzbkDxA43UDzg6LrhM9kgXwueLTQNwrJdLm4HBk0hXnUhXPjC5trt++clFj23amNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(4744005)(2906002)(2616005)(36756003)(41300700001)(53546011)(5660300002)(26005)(6506007)(186003)(8936002)(8676002)(107886003)(31696002)(82960400001)(6486002)(66476007)(66946007)(66556008)(6916009)(4326008)(6666004)(86362001)(478600001)(38100700002)(31686004)(316002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm9iWFJLRVlRV0JyOXhvb2VtTDRRT0FvWkMrb1hLRUErUzlUQlFhWHNjbWQw?=
 =?utf-8?B?cDU2em0wcnh3S01qcHZQc1RCNks0STk1M0FiclFCNXN5R2VQcURXOXFpV08z?=
 =?utf-8?B?QjA1VFh2c29wTElBc2k4c29iSDRtOWd0V1oyYmdEQzgrYndleEViTGtnQVNy?=
 =?utf-8?B?eDdMcXhDTVVoVG5DSVBmK3JyQ2dlTUpvVDVrc0EyYVFyRHR4QTZUWmFQNk0x?=
 =?utf-8?B?dWVWWGl4RWZ4UjcyZGlzSW0xSG52clJHeVM2Q3Q2bDB5U2xKUkFRYURBQTl1?=
 =?utf-8?B?ckF3Q0c0VUU3dDU2SHZwRGN1NTV3d2RONGNJcFNGcjNDdFY1OFlWbjc2dDhx?=
 =?utf-8?B?SnBNQ2FSZElTSUJ2T1VwWUlFOWhpSjJzUmtOUjdvVUdFYW8wTXA2Q0wvRTVu?=
 =?utf-8?B?VEhybTFnTkdqS2FGZEpoTDZvUkI1eFJPNnVRV3FVS1dZK0Q3U1BZNmtqMEVD?=
 =?utf-8?B?ZHZIU1pOaEhZTHhpTnY3ODFGanltQ2FPNzltL2RJNlZMa2ZLY1FsQi9KZkhy?=
 =?utf-8?B?czZJTlRKMTI2VmlTQm83eTMrMVNEK0FkNzJmZDFkSUdzc2Z4bGlBTmNhcVVm?=
 =?utf-8?B?TkQrRkpsWWJHVDFUQncrTXlNTFQ4Ukp6T0ZnQ00zdmI2L0QyYmI1cG8xUTFu?=
 =?utf-8?B?UERhU1RLemlXVTE5dTdzd1ZtZVZKK3pxcnNVdnU2L1BqaUFMNnlkRjFJbkt3?=
 =?utf-8?B?VGptS2IvVlhYMHBxQ3JSMkhwYy9ic250NFQ0OWJ0UWFwSGIxcGhrNzNVQlNL?=
 =?utf-8?B?c1kzMjZiZTlBRFNRMmpYOE9oMzEwb1Jta09taitXSmdmYi82Y2ZPaDZ0R3V6?=
 =?utf-8?B?Nnp6bzRlOUo3am0xdFd6dExiMVIyVjYvcWY0SGFJUGp2cEs0clhvN2RkV1Uy?=
 =?utf-8?B?QkFOUGRhNHp6S3JCV3hBa2ttTzYzRnNwbUNzakFrQThab1BpcHk4dVBwRWM0?=
 =?utf-8?B?aVhKTm1EM2huclZ5NXZXR2YzZUlSd3VDTUR3ZTY2Z09yWk1iMXVOcC9ZdkxB?=
 =?utf-8?B?TVdOZUt4elI3K3I5NDlPNGZHZzhIUW5RYUJrdU5wVS93VWdRS2hPWXpiV2d1?=
 =?utf-8?B?c0xhZzFNbWJKc0xUQkQyVUtDME9rak9ZOHlMVE1kMW5uUEMyVi9YR3Q1TStR?=
 =?utf-8?B?MVcyZWpkOHB6eGR0K1FVNUQzWmxxZERCNVdPV3RLMk1OSnZWL1luYVZRWjUy?=
 =?utf-8?B?QmZmLzF4b2srZFBGbDNQZ2pKY0lTMTBZd0krNzAwdkJEVDBMWVc4d3luSStm?=
 =?utf-8?B?TVFUdHRJNnVzUEZYVmhtV1FiU1g0SGovcXRBT3MwZHU5MzlnZ1lxYzlUS1Bj?=
 =?utf-8?B?U0VBR2tENURrQjkrcEpTWWlMdm9iR2VsWUhPU2dMcWNPK0c2S3JHT2UvK2Fr?=
 =?utf-8?B?MXY1QWhGOWhtcmZERStmby9wZGtsNE9rRGZnVkV2em9TM3ZNNTZqaFNIMklz?=
 =?utf-8?B?VUJITUp2K3VPV3ExVTFyLysrenYzdHlLRWRaRHBwV2djL2xZcGpsZnAzdW1Y?=
 =?utf-8?B?dlM3UVJJcFBIN1NpQTluVGJaZmxMVTJDeEJ4bHhoWHQydEkwRUEyVTJ0TkdP?=
 =?utf-8?B?Z1JCYlVyVVdYRFBXRzRXdmVEem41LzFMU1J6R1p3ajQ5KzVsVXdyT0RIVlh5?=
 =?utf-8?B?dUFHRks2UVQveUVFaDEzNnZxdFNUcEhBOCsyZnlFTFNRZHdmTlR4NFhXcndQ?=
 =?utf-8?B?UjN4L2dHYUlrU1MzUmVkNGRXQm1qVXRIRkNWdmo5andxM2pCSzdrZHNzNlps?=
 =?utf-8?B?SFEva2V6MkM0WkIzTVVPc0ZmYzZzejlLc1RLWkgrbTdrQTRJVGJ4eDIxa3FS?=
 =?utf-8?B?Nkw2MmZvY3ZCQTR3UHpBNEpDT1JCOEdrVHNZRDNReWRTVUtEMlMzckMyOEZy?=
 =?utf-8?B?T0pPb1UrWEE3OS9PUHV5OVc1TjZEOVF0c0xyb0lBOVVScG1oQ2NwTGZybitI?=
 =?utf-8?B?YW1qNTJJbjU5UkorSXlqT1oxdDVYT0ZQNHUzVnhCTFl5b1pBTWN5bUlMczha?=
 =?utf-8?B?VSsraUt5VllNT3VQMUZsQVcyVjdJZjA5b3dYaFRuUTNMODBBc0FVSkJUckdz?=
 =?utf-8?B?NFZYdjEwc2VuTStrc3pOeURwUm5jVDYvajVJNWp2VTQrMncvcmJxT3VFMXdt?=
 =?utf-8?B?SFFjU2VFbUxQK3J3cmFKMVdwNFNTbGt4UUFiTy9ZVGdGY2hNNHIzQ0lUcEZk?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc7b2da-878c-4aff-dbc9-08db83134e4b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 20:05:14.6498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymAz8sCNEXSz0c/IBqxbnle7LdkZTrUWTdM9fHD37LIsOBR7pHb3dLJGOrd4+otAWqDWIhijyhEOdkvai2rnQUcDDh3Uwq43KhmMynogLuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4647
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/2/2023 11:08 PM, Jakub Kicinski wrote:
> On Fri, 2 Jun 2023 17:47:17 +0200 Simon Horman wrote:
>> This feels like it should be two patches to me.
>> Though it is not something I feel strongly about.
> 
> +1 I'd put the YAML and what's generated from it in one patch,
> and the hand-written code in another.

Will fix in the next version.


