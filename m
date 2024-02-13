Return-Path: <netdev+bounces-71522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F4853CDE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 22:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32F61F21AD0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 21:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F0C8061E;
	Tue, 13 Feb 2024 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8lRQ4dd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25317F478
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858354; cv=fail; b=gdv9LQPOXPnc7bbmeR9KRLaW5kdwy5FTfveqkE5gBqV5JolGPF0mlJl6sjBwCqPdnZii6XjUuiRmvQHZUtaUee5HuK3xSbNr5sfwljxtm9oky9ZPS5h2A4nm1n86wQ7mMTBrFgjMfzO4d8dSdFojHz9GHGWPheOnUm3msUJC6z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858354; c=relaxed/simple;
	bh=j/ySM1Wy5IraykSitjEI5mrjyft5V3VZKCk6EU372CU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H0jjfz6FqK9KN2j+wZhs+yKGyD9dvYxqjReiclGSo/5U7PenJE/PtLtKSbJ9RLVq4FOmkhUY0zuoqlNVASpOZFcLcqt2Atjg0B2+5xTaZq5uW1YsAK5UO2ScaVoKGwZwgMo3Ipa5VDjFj9FxGIK0iUfFRqHvvEMpCG3GasUdYz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8lRQ4dd; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707858353; x=1739394353;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j/ySM1Wy5IraykSitjEI5mrjyft5V3VZKCk6EU372CU=;
  b=O8lRQ4ddJn2zkkjF2aTESDn3bm8cBeQlWWvLHtTBAzbaRtIY2TswjRdf
   80eA8xTa7RCb4F+baZTwEGxObnuQJnLC6xDsVaykTsyRx3gLjxkpYEoIT
   IAvgQ2y5ER/XNMefVaG7Q0iWujhpmXIyXl1RqmoRlvi2t3ojNLEArp8H2
   cnl32wUzBWHtfkAlt3R1CkUAwFEWrNNwJNSyNCLaPqm9G6TE4iFNDpEC8
   1KUREPIz1ZLc9GeVMWefbZoZ9AAy9D/XH8tfGxjkEdGw5SnWz0x0IN3ro
   /1caXaa3xDyf4i63zleRu+Ai08ysFwDJ+ozfndScetkHqw2KXZlS19Tea
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1767585"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="1767585"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 13:05:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="3170796"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 13:05:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 13:05:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 13:05:51 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 13:05:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWOtBogXc6J44W0JM/dhbtQx+ZujSnjxMM7NFmFA6QquqZWIjdiy5VQBy8PCJSqQNU5TVLKFyXPKk7qvUUk5GjkVovj7sXEoiBroysuuc7cpnphvWhHFJ52feKCY+e69KgLkHhMQTXPQLc93hmJuTXfKz85svUWaZPfRcA3FJUJlJuEQGgrEvgr3EdE+/4f2bOUh25YY+2RYaoTu+7fRlcZUhCnVo+SF+c/xmgvC06L3T9ird2KwcrOrYOngohlD7N5JiAiaakO2KSQ+rDO25OLiqX6+Jl3NNTMpjUgM6dx/ubvBJQ24i+c7EEegnZPQI76hwK0AnvMCHFoqS1RBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdPtmizWMjg8M9FUl4QP2NEy+Oa6ZKVs1B3hbFxlbCc=;
 b=JYUg7tKV+4H77dXwnZFl1HH00RGkwGWtwHrYEYIZ0qKZUjGKA73aF/9uNm82gWtehAAMdDsSEuDJzxkW6vIHWmTj6Ym5HnnW1Q18AVj/fDroGNtEUvxHhb69Zhu9viXVGNLKY45HbDh8F5fMOb2HfWvxqMAJDQjgFuJ0Peb6LbBPFkms/kg1AfTSdVwp9vwBkMT/Cg3i9kwmXjnf4SnQhULKV6g+SjfeFyn8TDZybVMPjn24smUclOnXmIZ86YjSK9WfyGmRCy1s/u5Z9tN/6PhN1BpIfTJOAmfdw8GTU9WQCGovGACcgASFr1lwsCaTvoWRDoE4CeRNVWdIsiwdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 21:05:47 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83%7]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 21:05:47 +0000
Message-ID: <11004b9c-97df-fb6f-efb8-9550ea2b6c03@intel.com>
Date: Tue, 13 Feb 2024 13:05:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next] igc: Add support for LEDs on i225/i226
To: Andrew Lunn <andrew@lunn.ch>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Kurt Kanzenbach
	<kurt@linutronix.de>, <sasha.neftin@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>
References: <20240213184138.1483968-1-anthony.l.nguyen@intel.com>
 <7a6ae4c1-2436-4909-bb20-32b91210803c@lunn.ch>
 <24b89ed0-2c2c-2aff-fa59-8ee8f9f22e9a@intel.com>
 <c4f66726-1726-4dd5-98a8-4f8562421168@lunn.ch>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <c4f66726-1726-4dd5-98a8-4f8562421168@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0230.namprd04.prod.outlook.com
 (2603:10b6:303:87::25) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH8PR11MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 719880de-25d1-4d88-529a-08dc2cd78cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JB01agM+xjpfo44IuGGXl+BdsxrUrqfPk8oQ2De3BOKbi3bkWRnTPAoaamdHglaJeUqDFOkLN9Le0Fw5Pds1x420VpkQF4K4z91nL66Lzw3eEnSSMpb7MHpaHAPpxof74Lu/+y4gx589A3juUz8h/JyvJpEOa6Wrzd27cnnSXwSTKdNO2AWETRAcuxI9xHFJs0sTRGs11EWN0sroV0Fu338QdR1GLPwpF5Uw0tFwkMnDXk+G9o9208YRqbnl0DkMmnIbB19Hir5QTPuvFJ+YG+Mbfc8mxxx6pOdgOailWYK0jxmB3Vx8f/wGv+nD4/ZHyTb7SZsgXDPc2d+m9mmI6AxWjcrPJBjJAKNWmzFIJixsvxWhc52tdpwbl468QSkPxCLHiASJz/BWtK0a2046xzZXn84LNXW2GYP9p+w8z40oNo1R10/8WYxyhBzGUrQ2ryuTIR5GHUOZ9M22EibfP1l8oNWDdPCALf23uuZEO7SI9IWERsaQKT3UM+4Zna/QJlOY28eCy38I4+kqmjW5jhfXquZ//1pumGI4iTF+Os=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(66556008)(5660300002)(53546011)(41300700001)(478600001)(2616005)(83380400001)(26005)(66946007)(8936002)(4326008)(8676002)(6916009)(66476007)(6486002)(316002)(6512007)(54906003)(6666004)(31696002)(6506007)(86362001)(38100700002)(82960400001)(966005)(2906002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlRRGVCcGhEU3lJckZBNllkeWFaNEUyRzQwaVBZOGY5UENhZ0FreFdESzdV?=
 =?utf-8?B?ZFNLdHduaUVHb2ZlSC9RbU5rUUk0NFhvODVETGhiUkNsekVlcklkcE83QXcx?=
 =?utf-8?B?eUFqamw0WGd3VGZUL3VZUDNBYWlnZmdJNGd3TWNCZzB4WGpYNGdkWTU5MVBr?=
 =?utf-8?B?TlFuS2RqaGdaR2cvMzZMT3FONVRHbm1rd0t6TTZPVTZVc1c4VFp4aE9VTCtV?=
 =?utf-8?B?dmQwWWpnR1FnVklrNCtkSVA5TmllMXFFSlhwbDE4bkhIYSs1V0p2Y1RONkh5?=
 =?utf-8?B?WUFKL2RaSmFuSFN4dXdxZm45SXNYeGRTNHpPTUg4SlkzeXFlL1pla1I2cDFh?=
 =?utf-8?B?NGlnajgyM09hMldMT09OcjQ0QWZEemFKTmVYemZybGczR3cvQTR5SSszWFh6?=
 =?utf-8?B?Sm5IdlpNT0p3N2hmMGRpUDdqMXpjZ0RwU1o0REtUUmZEY2hSVlc5akpZSyti?=
 =?utf-8?B?RkJyLzdaZFF0aHJURERXT3NYZGdYK0s1UnpPVDA3bkJIb1lCVzdvTFFiYTNa?=
 =?utf-8?B?UlNTeXBzZnFReHJsVEpiN3R6cm0yUkdBemFUOTFKN0dGQW9SVE9OZzl3blA5?=
 =?utf-8?B?STJBbjZhYzRIb3VNTDdUdjZXR3Zyaml3MEhCR3BmV3FwZWsya2lVdkJKUWZH?=
 =?utf-8?B?Ry9RMmZka0RJSGQ2TTF6Mlg2dUhibmhlQnlaTll3RWVMSXZDdERBTkFaS3d5?=
 =?utf-8?B?Z3JJdEZxRXgvNjRrR1FTbjQ1MXRKaEV3Z1h5YVZBSGpxUHdiMExFWTlJUUpC?=
 =?utf-8?B?UTBxUHFjNzZSVFBVUVJ6dGZ0RmxGd1lsVzY2Z1AwcVpodENvcEE5Z0xNN0Uw?=
 =?utf-8?B?OG9IMmV3NTB1eTNpaEk4VitCcnd5c3RZMFZWRUt1RFhsemcvK0hpTFQvSGV1?=
 =?utf-8?B?QlFndlhxMklQZGNpbUtzdVc5QTA5ZkQ5eEJQSWpHS1VsWm1wOFl1amo2U0Vp?=
 =?utf-8?B?azh6OFZDUTlhN05qU1lwU0VETWE1SFlRWGtpSzBycUFqcExiR1pRaFFHQWor?=
 =?utf-8?B?T3premsvSnFsRlpiNEVrUlVJb0thYzlUczdsLzdyV29GTWVpSllSenRlajZh?=
 =?utf-8?B?TExUYUx1VUUvNklsYXovQXlqZjZ1ciswdUhyZVNFYWtmYmg2eExtaUZ6MDdh?=
 =?utf-8?B?L3kxcmZFTHd1cUxUd0h1eVh4QmxYVEZMMVhOQmQ3QmZUL0tPZk1vYUloN2lJ?=
 =?utf-8?B?VUptUFlSbTM2WThGTXdSMWlYOWo0NVcxL2RRV3IvOHRKV003YTVoSVZiWkx4?=
 =?utf-8?B?dnhvVkIrOUhkOVZZK2loUEJtVWNvVEp2RWxsUGd0MG9lQU5UTHlPUm1SMGV1?=
 =?utf-8?B?Vnk1bUgzTzRCZEkrZWZsd2R0eWhRalRocVRPQXFYT09MV0NqR25ZM1I3U0Vo?=
 =?utf-8?B?b3RFRmtUcVd1NUoxV2xCcGtQWFNEME9LSjg5QUVIVURyUUVTOWpXZCt0RFNm?=
 =?utf-8?B?SHFUZU5uVkE2eW1LZkdocnljZTVmNS9JNVpOVXVZWGtiRGVWanc2WDVpbGp4?=
 =?utf-8?B?V3N4SXRnWTdXbmxFYjRMMTE3WGcyUkZjbC9xVEp3c09DYW82NE1qdXhJUGlM?=
 =?utf-8?B?TnBwRmZyZ1RhZU9rem1PdnU4V25SUFRPYVVpUFQ4QkZZVW0raWVITHNIUnZU?=
 =?utf-8?B?bEMwcTRBRUVGTllDVE0rN1IzSkd1Y3AyVkxJM1orenkxTU0xNXJlb0R5QnlE?=
 =?utf-8?B?VzlSdGNRMDhvMGhKek9BK0ZJYXdMSjlqNWVjYnhueUFkcHp2Vkt3NU1OOTVH?=
 =?utf-8?B?K1hJOXllay92dnNzZkUwMjBodjFjakVxclpMTUJkUy8rdEdZbElXSnpBU0o2?=
 =?utf-8?B?b1oyd3YveDNzNERLSWZnZ2NicWNqV0hDVE92OWJCaHZBOW1xd3JnRjRvM2ts?=
 =?utf-8?B?ZHpxUjJSMHNUMGh1bWxGTGx6RjViQW0yQnY3Wi8xTFJObWhzb1F6MkhEQVpi?=
 =?utf-8?B?STVKcTBpV0dlZ1JwYWhIVUxWTTZPTFV2ekpvUm43Z083RWcxWTlPQlR1aWp5?=
 =?utf-8?B?VHAvSVVhUTFpS1cwTFl4SG1lb09MRzhkeVFhNEZ2eVJiZWg5bkE0dEhMaUJo?=
 =?utf-8?B?OUY1KzJsaWRPUCtjMlJqUTFMbXVHTXViekZtd1RpWWRFSlJja2wrUmM5RXBq?=
 =?utf-8?B?QWhDM3Naa1Vsc0Q3RmppbkQwenJjYUxTQnIyOUwvNlVZVldGaWJTL205YUdQ?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 719880de-25d1-4d88-529a-08dc2cd78cf5
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:05:47.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQxczgJQP0O0ju1ulEebKiu30gK1McODE5H3QXRlNa6jtIAuALXB8EOpFZ0T9KUBOphIQu7PSlYIbrVIuYkNfZAkkbY8Zn82UsfrYAHVlK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105
X-OriginatorOrg: intel.com



On 2/13/2024 12:28 PM, Andrew Lunn wrote:
> 
> v3 is still in patchworks:
> 
> https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=393838

I think you crossed the URLs. This one is for IWL which is marked as 
Under Review. I would change this to Accepted upon netdev acceptance.

netdev:
https://patchwork.kernel.org/project/netdevbpf/list/?series=823612&state=*

> State: Awaiting Upstream

For Awaiting Upstream:

"
patch should be reviewed and handled by appropriate sub-maintainer, who 
will send it on to the networking trees; patches set to Awaiting 
upstream in netdev's patchwork will usually remain in this state, 
whether the sub-maintainer requested changes, accepted or rejected the patch
"
https://docs.kernel.org/process/maintainer-netdev.html#patch-status

Thanks,
Tony

> Does that mean you? Would not just giving an Acked-by be enough? Now
> we have it twice in patchworks, and you did not mark your version as
> v4, so is there a danger we get the different versions mixed up?
> 
>      Andrew
> 

