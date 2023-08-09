Return-Path: <netdev+bounces-25644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB7774FDF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 02:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B44D1C2108B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BCF36E;
	Wed,  9 Aug 2023 00:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361D182
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:35:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FEB1995
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691541335; x=1723077335;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VLVJ4G6xht5miMWJKz9ZhH+NfWa+qctRZu1MAfwpZCU=;
  b=O9ND75lHTy1p/IFeTV4KPB+fObl1PpTah3zqBr1kU06gSlc/S2Zn1Wi5
   R5JK4vdvrQhSSbGjv1+MaHGQP0lpEbCGZF7UsvURV96Wb0ykuXHE3mvto
   kCe0eUwQXMvoUN5jNLo28GY934htgzgCLI8/whQ5sp+2idmshKCl4LDT3
   OyV/Tz112L3aIxYLlPfvWXEr4iSRZREkDb4We134pWICBauC4ur4jccLe
   4jCTeZCc1j1TSkDOI3OHoJp5dcsa2bRnBZ4AcqxdONj/jIlcKBTBB6XmF
   F1mUMZ+s/Y9hleGYLy+0dSyNQuuZY90C77AfKVCNBVOAQovVddswsdwse
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369890300"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="369890300"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="725157665"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="725157665"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 08 Aug 2023 17:35:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 17:35:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 17:35:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 17:35:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 17:35:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCQYMVNLm9YTbAZmG2WLHUSaSnI8rW+o4DlB+Lvnu50nUEZiVDrC7zVBrS7K1lGsSwA6IFN9YDHiIsG8378uNVImJ1nJnWKVqXp1sRjO6p6AA2swHIGbu9r7Ig9UY2Yz7jp1RQANkx9fTD7dCj1KzwGEda2oKk/zD4bh2Qbc7xsKwP3JPd8My/UfIO2v/IiTSZAAjW8j56924mm5Dqx/tmtEL6W97lpcWrJzVhn5HP0puC/pA5HOxaV32ly3WroCerMQpJOUDNStj06vNnQGaE6ze1o32EpJ7nLEi+r7QfJF+UPA8uqjqZ9yR+oFOiH8XibwJgPTpheFNBslmoLzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W853tbQlsypzX32M+QRk/Lx/R7AAoB7PozJtT59Lyc=;
 b=ATCXiDymSwUuTM8tEdDO5GNb7wqTyt84MeqxY+tNu2iYekEXp1scoaWka9FinxOpNsr9qosR/prlpKsYLbjhDcjJoAp32wQnDjh2v7kggnbV37qXmJyWtW0eXlaGNc7aatWttBep+WZDsmHNaV6oeBD+RaYy4sraPMBq/HB3lSgXwYIk3/74mrPTljJDcvP1/4OfuVDBeETmB9CfYnF/PySIDE9YPtl/PpJK2ETqN+YmNuYo4QqvW2YN7tFZSWqLDfDlKYWHveL9YxtDfZbDqQ4QqkBiVNlOqnrxg/5Ch3LVXOV8HmPWKbNZwTpC9XfhvHwzvlmRktp7UkCpD5aFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB2608.namprd11.prod.outlook.com (2603:10b6:805:57::29)
 by PH7PR11MB6607.namprd11.prod.outlook.com (2603:10b6:510:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 00:35:32 +0000
Received: from SN6PR11MB2608.namprd11.prod.outlook.com
 ([fe80::6596:b2b8:940c:3b85]) by SN6PR11MB2608.namprd11.prod.outlook.com
 ([fe80::6596:b2b8:940c:3b85%7]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 00:35:32 +0000
Message-ID: <e1beeb14-fbb5-216c-f661-2bb9a84ba724@intel.com>
Date: Tue, 8 Aug 2023 17:35:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 00/15][pull request] Introduce Intel IDPF
 driver
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <emil.s.tantilov@intel.com>,
	<jesse.brandeburg@intel.com>, <sridhar.samudrala@intel.com>,
	<shiraz.saleem@intel.com>, <sindhu.devale@intel.com>, <willemb@google.com>,
	<decot@google.com>, <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>
References: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
 <20230808133234.78504bca@kernel.org>
Content-Language: en-US
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <20230808133234.78504bca@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:303:b9::22) To SN6PR11MB2608.namprd11.prod.outlook.com
 (2603:10b6:805:57::29)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2608:EE_|PH7PR11MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: f37422d6-3d98-41d8-393b-08db987089d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6piHw503EXnMMT179NWPnV6n+S9eOqM2ml9yqWR2PHA1Xr7vjc0qZUJWE+gA3uW8bpK0bs6Dvoby7ud7EHMhBo6PJDNKXuWt08sldIYxPHon0BMvMqOgeS0qtX8vJKDp1T1H5WTpVE/eX2YhzaJFg4rFyDX9/rmY7bg/eGwGp1B5C60YvpDdW/n6V2JfIpqDoMnSolQoCJdV9Io0gOeaJN6v8CW0dFzNcpv6buDgxD+8Agtq4qkMBXxzIIUZbnriSJVBstveghopO3X0onhxUBgFoqLe1zEFtBwY15kzMXDqouUWoOAxQKGoE/SmVnSlZpPo4bhFWihaROIbOgKDkyDUXmSktteyFqs7ri33Hjo05AyouEyqrXJeK9NRpSmEHRmeSgLD8vwMOQp0pni/ZblCItocJF7I01Wdhr6w8JckzwHssDohkDPYGy6TZ4KBFX1qmvwfLLlmE81OQOmN5pm5cPgrY5r3aJsE6l6HuMH+57vvVoV/rqgO1lLcPxPTfdaq1Ku6Mxf4DxQQJvUDgcYS6ACZSdft1wry1Nwm4/hTOzvS1yebxrHp10D9eosr/dCkbQQCBr9J3hYqRbkR9yOKsED06CjjXJHKg48ANKv7b99/IPP0kla5L39bgIDURgWVMx4tTWanSs2LASqfPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(346002)(376002)(136003)(186006)(1800799006)(451199021)(6666004)(83380400001)(31686004)(2616005)(110136005)(4326008)(5660300002)(7416002)(316002)(8676002)(8936002)(38100700002)(66476007)(66556008)(2906002)(66946007)(6636002)(82960400001)(6512007)(31696002)(6486002)(478600001)(86362001)(41300700001)(36756003)(53546011)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1crTFFjUDJ0VUtSdDdlVjVyU0c4ZlFSSEE2M0JCTVI4TFg2aUc1REd3am8w?=
 =?utf-8?B?N2xUUURzYzJxalNFRGYxUWM2MHdnSkFhZlBMY1NJM2RWcVFmUHJKZmRFTklW?=
 =?utf-8?B?QXBnN1lNNEZiWnBWekxoNXZkWW10RzRvS0JLNHJkRFRFMjExUWZaaVZGdkY0?=
 =?utf-8?B?K2R2NmZmWXVkSzVOWEV3MjNhblgwdlp6cU9YV3I1TVQ2SzBmQnBnWnowMzAx?=
 =?utf-8?B?ckUrVmcvak5NcG1XNzRPNnJQeDhRQUd4SVNHNWR6VkU2ekVyMGZUY0lMTDdS?=
 =?utf-8?B?KzZXcWUvOXVLNzNwSGpKckVCcXUrd3FmdU1TcGxMc2pLM2NnN1R2TGdaVkE0?=
 =?utf-8?B?Z0o1ak1TNDFkYVhYbzBMd3FpYWpaMHMzUUlieTBKZFpGcEptaGZqZE9xZ2VS?=
 =?utf-8?B?R09HRCtyQ2dTOVJac1Bzdk52aW1XbDQvd0J3bDBjK2tCeFZibndDMDlkci82?=
 =?utf-8?B?dEI0UmVOd2krM2QzWXlPRjh2THlSbGpzMlVKVW9naHp0UFNlSzZIU2RvMVhY?=
 =?utf-8?B?V0tmd1g2d1lGOUxuTnArS243Z3Vkd1pEbDd2Q0traTFGWGRPd2lLTms2MHVm?=
 =?utf-8?B?SzF3R3lZRnIwMlROdXNKd1M1dUJkN005T2JsTzk5a0d1cUJFdHdFS0dHV0Vi?=
 =?utf-8?B?Z0ZoREVWUkVBNThVZmhrazVBd08yZTB3NG9XQUNzOFE2allURkpMVHgrckxX?=
 =?utf-8?B?QVVEUExTSm9vTXV4RFpvOERwK3BjK0R4ZFd2Y2E0a2xra1B3MWllVW1Ibktp?=
 =?utf-8?B?b053S0RMRjYyU0Y4UUgxN3JoZ0IzclJOSVdsM3dVV1ZWVU9xT0VpWkFZMGZn?=
 =?utf-8?B?T1l1ZGFOSlN4ZkMvZVdUZEhMY1kycUdwaFhHYm0xSjlyUXZNM0NRTGhHNVhV?=
 =?utf-8?B?NHgyQis5Zk5ISDZSTjNpdEY1bmwzcnVNdXNOeFUyb1pQODd3SS9tQ2hpMVht?=
 =?utf-8?B?bFlJQ3k1YmJId3BnbU0yaGN6a2h5czhJL1RMRDdUOHA1MGxnYnlBU2R2cmZp?=
 =?utf-8?B?enptaVJSTDZPaGNjSmdxRFJ6YXVaUFJOSXA2a3V3YnBtanVZZXR1aFVjQTlT?=
 =?utf-8?B?YjZsWDU5bTdnK21hakc0QmpSVzNwa2lBRmZzV0hSdi9BS1pLUDRmdHQwSU96?=
 =?utf-8?B?eHJzdjJSWncycGpuK21iZFlUdHJvRUpwQVNXazVvbVFTU0t4TlY5SFhPUGtC?=
 =?utf-8?B?andSYno0ZmFGejNoaDBtQ1JiK3ViMTl2YmQ3NzBNNnh4RnByT1dyOGFxc3Mv?=
 =?utf-8?B?RFU0cG5Mb0dRY0Z1bExOUW5CWSttSWo2MDM5VnRsTDc0V2VCNzdHalFUbGlx?=
 =?utf-8?B?YW93V0tvUnBveWpmSlloRVF6NXNkS1BpdnBSU083TkRFQkdySlFycGNNQmVm?=
 =?utf-8?B?VzFtbk9sS21LSWY0aHphbWdqS0tIQTJkUmlnTnk0LzJIVnNlR3N4MThJVjUr?=
 =?utf-8?B?Y21UTTl1U1BLeXJ2SEhGZ1hsNGhjdXRRMjZMWS9YTHhCZDV2VTNtTUx2MHZZ?=
 =?utf-8?B?TWRoUS9IYjl3dklMNFl2WHpDYzBrdktMNHhyL3lScDF4WXFKZm9yb2hnTjc3?=
 =?utf-8?B?MU1NMWVILzhOM09PRjNYdFQ1d0VCMFVmUlVuZUZ2aU5CVDZDbGlqOEM2WEVt?=
 =?utf-8?B?QlVuSXRuTWtveWcvRU1GbE03bDZ2Q0Y4aHcvc0dObVEvM1FSdG5CVHc2Z3hx?=
 =?utf-8?B?c0I2OW5lQUw5OVVCaENKdXFxa2pvQVlFTkkzWFZqR1N6clAwaVRqN0ZqUUlp?=
 =?utf-8?B?NXF5L1dqbnFrYkxQTUZTL1cvSnpnaEd3UDl2RSswS3BqNUNoUThZSHh6NHVR?=
 =?utf-8?B?UlladjBmQTc4ZzZvWjFQNENMSXR1bjloWC9XM3U0MS9FRkJ1Tm5LZlB2ZUxv?=
 =?utf-8?B?bk50WTV2V29KRzZXYWt1Zk9DT09DSS9OTkc0NUtCSUJOeDJSQ204OEdVbTdZ?=
 =?utf-8?B?N0NjUVI1dDJVeFlTRFJrV3M1ZVp2NU95Z1NqcFpQQWZ4OTJBcTVYOE9pYmV3?=
 =?utf-8?B?VDJjK1JXRk1ZRUh3TTZ5bFY5a0V6NmZjbHE3bklPYTNwa05zYTBnaG9YSkk1?=
 =?utf-8?B?eXR3TitkZzlXRzI2dTJ5T1A4cmQ0OHU4NFNEcVFvTjdHRHRBNDhUZUg5elhR?=
 =?utf-8?B?OWs4OENKREZXbTlmdjA5R3RVb2RwbnA2SjFocEFHaEpZcHF3QWJ6WFhNdG1m?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f37422d6-3d98-41d8-393b-08db987089d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 00:35:32.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6b52WzmtTKBa1gWhymUqIwQoChzXfPEyTDsY9UBvtUXuur03Qoy81Xg8FDH5rtJHfA52Iw48s6Ncn/oXSpJgLDfWHR/OwY+2FvneibiLh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6607
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/8/2023 1:32 PM, Jakub Kicinski wrote:
> On Mon,  7 Aug 2023 17:34:01 -0700 Tony Nguyen wrote:
>> This patch series introduces the Intel Infrastructure Data Path Function
>> (IDPF) driver. It is used for both physical and virtual functions. Except
>> for some of the device operations the rest of the functionality is the
>> same for both PF and VF. IDPF uses virtchnl version2 opcodes and
>> structures defined in the virtchnl2 header file which helps the driver
>> to learn the capabilities and register offsets from the device
>> Control Plane (CP) instead of assuming the default values.
> 
> Patches 4 and 10 add kdoc warnings, please fix those.
> And double check all the checkpatch warning about lines > 80 chars.

Thanks for the feedback.

Will review the warnings regarding 80char limit. Are you wanting them 
all removed or is it okay to leave the ones that help readability?

 > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value 
'csum_caps' not described in enum 'idpf_cap_field'
 > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value 
'seg_caps' not described in enum 'idpf_cap_field'
 > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value 
'rss_caps' not described in enum 'idpf_cap_field'
 > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value 
'hsplit_caps' not described in enum 'idpf_cap_field'
 > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value 
'rsc_caps' not described in enum 'idpf_cap_field'
 > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value 
'other_caps' not described in enum 'idpf_cap_field'
 > drivers/net/ethernet/intel/idpf/idpf_txrx.h:153: warning: Function 
parameter or member 'DEFINE_DMA_UNMAP_ADDR(dma' not described in 
'idpf_tx_buf'
 > drivers/net/ethernet/intel/idpf/idpf_txrx.h:153: warning: Function 
parameter or member 'DEFINE_DMA_UNMAP_LEN(len' not described in 
'idpf_tx_buf'

/**
  * enum idpf_cap_field - Offsets into capabilities struct for specific caps
  * @IDPF_BASE_CAPS: generic base capabilities
  * @IDPF_CSUM_CAPS: checksum offload capabilities
...
  */
enum idpf_cap_field {
          IDPF_BASE_CAPS          = -1,
          IDPF_CSUM_CAPS          = offsetof(struct 
virtchnl2_get_capabilities,
                                             csum_caps),
          IDPF_SEG_CAPS           = offsetof(struct
...
}


/**
  * struct idpf_tx_buf
  * @next_to_watch: Next descriptor to clean
  * @skb: Pointer to the skb
  * @dma: DMA address
  * @len: DMA length
...
  */
struct idpf_tx_buf {
         void *next_to_watch;
         struct sk_buff *skb;
         DEFINE_DMA_UNMAP_ADDR(dma);
         DEFINE_DMA_UNMAP_LEN(len);
...
}

The script is parsing the offsetof() argument as part of the enum, which 
is not true. I believe it to be a false positive. Same for the second 
one where it parses 'DEFINE_DMA_UNMAP_ADDR(dma'. Is it okay to use 'dma' 
and 'len' in the kdoc header as-is or please suggest if you prefer 
something?

Best Regards,
Pavan

