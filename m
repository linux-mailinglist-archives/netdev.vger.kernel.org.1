Return-Path: <netdev+bounces-87194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9788A21E1
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 00:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B32E2858C0
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 22:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFEB224FA;
	Thu, 11 Apr 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cX2M7aey"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8B41A91
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875616; cv=fail; b=L0e9CksxlJSphxUX2XEJKmY9DxS84BK32myxDURsiIlDwRqq6FazMmzQE/aJEG7JcEsuf4B9f4jh6pBp42JkTLhSi5C1D75iA8AKYaUvCg2iwChv4ftJR+uI+GGFWeLPGBOAOBQsL8GwjVY5hlZjV94R0UMgpIpBhMWfBF1++/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875616; c=relaxed/simple;
	bh=flWX1IKQcgZoXkI7X2PQCP4MHgXyzuF5HIxLabhYRtc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3J9nwUXeIECvTFXgWky2BeIGNpPT4bSJww88sizeOOEHtZDlgYjMniC/pFv6kN/eWaK+MdT7kxjmKIzXLbZInsesrtleR15neVSaip3PYZ50F2r4DGpu87mqP7EkhPTbUasLU0k9z+q+PA6nWWpu/YpPFnKp0/4kRv7FxuLBSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cX2M7aey; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712875614; x=1744411614;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=flWX1IKQcgZoXkI7X2PQCP4MHgXyzuF5HIxLabhYRtc=;
  b=cX2M7aey/dhXMJKIf4I/iNNq0qt624yd9RAeMLDtSleOacZcXKZM3w8l
   PkvuDsbUzmHxS6ekrXHPdzNYmh4o0uQ9rUwnlB8iZazDa+8Ag6te7Mi71
   GhIG7MXxgMXN7vljBNyx39arK85upu8GdZe11KGzxNZkukNZCsxbMTEFV
   6+Ll11wMxSkBpMubyCNxdqAnLYwsFLtRjka9a178j4hsjHIWsWH9pcnJS
   5o063BGx8h5gDpcZ8eFN1prr9d0z7rRHiSYuqKlnSfhb9IIW9DhiooX82
   Yi7KJE89xH7rh8486VpXMg0b+3oxGqVmO14qe8n2gfRdAugjRisAcH1Vk
   A==;
X-CSE-ConnectionGUID: BSLaPid2Rs6GuDVKA2qbXg==
X-CSE-MsgGUID: BGSxiH0kRzCQaJcRvI3HuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="11282080"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="11282080"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 15:46:53 -0700
X-CSE-ConnectionGUID: Wmlroy3FSbuWkIbux0F3yg==
X-CSE-MsgGUID: oghYorqBQn22ROpniklYrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="21644411"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 15:46:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 15:46:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 15:46:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 15:46:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 15:46:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELSrsnbD8vmuFisDVaKbhDmI7C385TNfnKap+HMgrgyO8zYLt/rXMGb/Uuf6myWl1/SLVyIAKWlsCmy93VPb1mZdJNnKnBD1BgaUJoDwNX0tL1BH+RbXxapyLSMeZyCOZAdKf8WdS1liwDJv2l3x/gZ42FBBPLV3QJwAzDzgH28MLmvkxYybtE2qhSlzMpbi3CpBsl9P3hYwKK4yBx5bD9CmtRF4A+NQq3aXRZC9zMMIvWZ3zLf1LonPN95yPU5GVPHVDMw9T29JNAt2j6frNegTR6yh4VH4Xh1xU5QvZhk/QFbasCwfL1DhpuBzqVvATxfh73ouRENZvyvY99Phwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqBiQ2rYOufqOIEHn+EeM28Q+214X18oYUGE5IP/7ps=;
 b=gVL1g7T7OFaHclf0Qk0Jrpo5QC5AXNkMKYbGtIJTKG97JeCPXy6EA32TnOSYd2fi3N4hQf8o8E8cqIYIS+R22SDzVYgUMp9lioJ3+9+ixah8c0wogPz5/+/favyR6yCfr18xULDG+udy5DdCQrHoi6dWtv3lSJYwwaNahNjEY1AoztrGOQ7NeztSU3UhDure0tqyKPxBxb8XiIKr3EZSfenvVue0MbUh1fZ4bIqNfA3cNYFT0XTNldDx0BYKZ4ElJZ1fwxr0IDf8wwhw7eC+JXDxKcAiICS553BH+qD+dsMbdP6Lj8MdewcilhLLABE5CX9s74rLWFNFWllNN3+29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 11 Apr
 2024 22:46:49 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 22:46:49 +0000
Message-ID: <94956064-9935-4ff3-8924-a99beb5adc07@intel.com>
Date: Thu, 11 Apr 2024 15:46:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,RFC PATCH 0/5] Configuring NAPI instance for a queue
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <ast@kernel.org>, <sdf@google.com>,
	<lorenzo@kernel.org>, <tariqt@nvidia.com>, <daniel@iogearbox.net>,
	<anthony.l.nguyen@intel.com>, <lucien.xin@gmail.com>, <hawk@kernel.org>,
	<sridhar.samudrala@intel.com>
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
 <20240409162153.5ac9845c@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240409162153.5ac9845c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:303:b7::7) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CH3PR11MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d259613-ca24-4a6c-4a6d-08dc5a794651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANPiFIOHHtHZ6P3P/ajVVJK42m08o9DoOJGVWVDJQIGT521Y5FLttQZsH51GjPWfMxJ95pgMrcdFFv6lMQeABqz++g/SmDJ6bTsd6tQ3st6PW5AM9Y4jTdGm3G92m2oIbsCnvdwT+z5JVSX+VdqIiQ9OsOopkiMixCvNbGR8H6CCxvE4LeXhRllus78OEtmDewbSz0sJPSMpNoKJqXoRCGvhnwM1iEfoB4IhO32dMRsEEMHXjyeXwaYP1TIZ7+Tgk+e9GdPUmi83rHvhUWKis8cO2a6lXSR+fKOInf+E3oIMJvIXFzh09Ml0ZYNjKAAD/am9XJ2aNsQ66Yv9xQQe9KXX6RIhb7LS+Rc+yjvGbAOmLKsWvqnzyenGeJ7CnMDvLsEBoXM/nHSp74bOVqwCd9KvY8aeuv2Wyw9OSEx/4pHLmXD+4qu4OpWVdbMScCksjw3dzkOO2Lage0HSZqNZumaxbniNw2x+9z7sG0nCON2KQQiU6Gi/hSuPiCSFF10lad+4WRHSSbtE/FnsGgim+SgFEM55cQCSugW0wV/F3EpfkyC3MFx10/ZSdYEONY53wihmQFOgTtLsSvtPtuWj2PpwTQozWb+WEhM07ZMASaC6aIA/jMv+qoMVHS5V8xzyUgyHrIl1zA7QpO38FFsjRgb2kRf2d/stZx+bANp519o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2pJcFY5a25sSkFRWEhRakJ4Z1ZsaW9lL2l5NEppbld3VURNNHBISnZOcGxo?=
 =?utf-8?B?NUlCcXZhZVhQcGN3UkFlWE5GSURMTWI0dS9EKzZObWVyRTMvYUJzYUgxWDZx?=
 =?utf-8?B?WmIwc1FSM0w0ajNLY2pvbXM4Sks4TnNhV1RETGFRc2N0eGFjYSs2WnA0NXVR?=
 =?utf-8?B?b1pQYUJZMXcvZ2NLY3VDSER3ZkZuZ0ppandIZEwxbjlFdVFJeEtGVDBLSk4w?=
 =?utf-8?B?NWJMYzFkMG5ucC93MmRpMENIVUV6MGM4VUZ2RkVDTVgxbFBHSzU3VklhZVpw?=
 =?utf-8?B?d3gwSGxxQTh3d3FNMnQrVFRTUGhwZ3IzL2dRY051ZDh0R3dqT1FTbkEzc2g2?=
 =?utf-8?B?RmIzTWZMTCtyVlJmSmU2bVl5VkdETHFvWFdkMHBCZE9FcDYwSVoyUm45TExG?=
 =?utf-8?B?RHE4c2ljZmc3amNuZVBCdVFXc1R6OUlRUWV2cUlTSm92TThYY2tpZ0daRTlI?=
 =?utf-8?B?d1EyMzFiR0I4L1JRR2FxREljQzh0QTJlNmZ1bUlxcW1RZkdnSDR6aVIxMUEv?=
 =?utf-8?B?Lzg2dXBQTXcxWjVSZDJyblo1RTBTTlBqL0tmTEFJdm5lSkF2Yjd2dytZUHJC?=
 =?utf-8?B?cVhKMXFFbFFrMEZkOU1HV3BSM2N0cDl1TDJtSGxxU3JaaUxsWUNGbzZHMmt5?=
 =?utf-8?B?UXRZdVIxcDYrNDVJMWNWUDB4M3Q3QkRrT1hsTGdlRTA0amNweW9qV1pnZ2pi?=
 =?utf-8?B?MXlDZTBJam5pMkRmYVdxaVBwS3oyOWRhSUlncGEyZ0N4RVFnZktMaVZXY3BF?=
 =?utf-8?B?L2QzdTdoSTduRlV0NmdjMEN1d2hUTXNtWTBhVE9wbUxzK1JpNmlsWkR5WVBn?=
 =?utf-8?B?ZnFwMStxNURMS2VsUnRTNEYxUWtOUGJpRjg3SHpleExyOWMvM0JmUDhlYjRm?=
 =?utf-8?B?dDNGNWkvY0c2ZkMveDV5OE1pZHhrRVNSQzRtc3luMUpQVk90b2FPN2lxbWhx?=
 =?utf-8?B?UXBLUm10MTBsMThUYzhwSXlnWTRvRFQ4VEVBV3lxWlhhclo3bHZXc3BqK3dm?=
 =?utf-8?B?S3E4OG5wMTV2VHdvcGwzU1dPb01ZMUM4R0VWeGFSd3hBS2E0aVE4Z1BrdFMw?=
 =?utf-8?B?N1RNWThoc1pjTnNkcDdVTG5UMjhBV2g4R3lMZFZhcUFUeHZPTjRwWXU5OGNr?=
 =?utf-8?B?MTJiN1hEZnlScTAwQlRUYUtmb05UU0lRbndnQi94TjN3bmo5elQxcHJHZnVt?=
 =?utf-8?B?R05EbG91QnIxZFZ2NFdlWFdCdFdyUnFHd3E0RllDcmhoUW5MeUc5K0lzV25q?=
 =?utf-8?B?R2t6NzcyZGNyN0xESklBZzB3cDNlc2EyQU5wR1c3TGZtUmtCak0zVmxEVzNM?=
 =?utf-8?B?Qk9oZ0dkQlk0ZElOTGtxOVJGMnRoWTBtVDRFVXd1WFpKUVBvUTNxcVcxc05I?=
 =?utf-8?B?RGNyT29OMnhaUCtEUS8zYjV1RUl6Zi92anFwcEs3OXUzTW81R0FKeHZWWmJz?=
 =?utf-8?B?SGdpeS8wR2VLOXV6YVZjblkzOUpoQndDWW45eVJQNTZvK0dDdGYzNTd6QXdB?=
 =?utf-8?B?aVZST3d5dnBhdk82QW1wd2J1azRnWjgrZnpWYkN6NjVvV0lTQnZuLzVrMGJy?=
 =?utf-8?B?bGhyMXB4Zy9jSnJ3dEJDakkzM3JGS3hRS0doMEZzRlZJckovcDJkc1o0MlFi?=
 =?utf-8?B?c2xCYWIrWTQ1WGE3OE5nZEJ4TlA1MG92N2o5bFVtOEY5STA2QSsxZHgvZ0p6?=
 =?utf-8?B?RXZ0UVY4WTVndXR0aEZhaTAyc3dsNTQzOVVqL25MUDh3S2dzOGV1bUVjZ0tJ?=
 =?utf-8?B?dG10eTZ3anJKSkZCaXVSL1hmN0drOXQrMldmeDRGbWZDV3ZJSjd5amZ5Z3o3?=
 =?utf-8?B?ZDdxUDFMemFyUE93ZEpWYXVpU0pTUHZ4QzJYWStoMUhPcUw3TEx6b3Buc1dk?=
 =?utf-8?B?VFlDR0gzN05UMG5KRUFGcTdzVG1WZnBBYlFNb2lqWnVUUHRqbmlISmVETVdI?=
 =?utf-8?B?bi8vVDV3SDBYaFcyUmNoTTJLZGF3NmpVcVFDV2htUlI4T0U0SVZGcC8zK3dS?=
 =?utf-8?B?NlJCM1djS1FsUDdCOS9TZWt2UnF5bTQ5eW5OZmlZVkNNZ1ZDOXBjN2V6VUp2?=
 =?utf-8?B?VHREZ00vNFVKOGZpSGlWVFRHV3owWUplZUp6WUkxazZZbnhuVElHbXROR2Nr?=
 =?utf-8?B?TTZHR0JYY0dhNXdjSmY2Z0cvVWg4bENTRWJWNUpsY0FFSDZpUjc5WWpkQTM4?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d259613-ca24-4a6c-4a6d-08dc5a794651
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 22:46:49.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6r10wiEozS7cOxyYpYmavfCJWDOhNZ8k8kCMZDGc8F+GFuIN/71oJe374C4ArAYzpLo+UGKkef1ZOewYdF0HmfhhIQPqiWkf86QpUuiEMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866
X-OriginatorOrg: intel.com

On 4/9/2024 4:21 PM, Jakub Kicinski wrote:
> On Fri, 05 Apr 2024 13:09:28 -0700 Amritha Nambiar wrote:
>> $ ./cli.py --spec netdev.yaml --do queue-set  --json='{"ifindex": 12, "id": 0, "type": 0, "napi-id": 595}'
>> {'id': 0, 'ifindex': 12, 'napi-id': 595, 'type': 'rx'}
> 
> NAPI ID is not stable. What happens if you set the ID, bring the
> device down and up again? I think we need to make NAPI IDs stable.
> 

I tried this (device down/up and check NAPIs) on both bnxt and intel/ice.
On bnxt: New NAPI IDs are created sequentially once the device is up 
after turning down.
On ice: The NAPI IDs are stable and remains the same once the device is 
up after turning down.

In case of ice, device down/up executes napi_disable/napi_enable. The 
NAPI IDs are not lost as netif_napi_del is not called at IFF_DOWN. On 
IFF_DOWN, the IRQs associations with the OS are freed, but the resources 
allocated for the vectors and hence the NAPIs for the vectors persists 
(unless unload/reconfig).

> What happens if you change the channel count? Do we lose the config?
> We try never to lose explicit user config. I think for simplicity
> we should store the config in the core / common code.
> 

Yes, we lose the config in case of re-configuring channels. The reconfig 
path involves freeing the vectors and reallocating based on the new 
channel config, so, for the NAPIs associated with the vectors, 
netif_napi_del and netif_napi_add executes creating new NAPI IDs 
sequentially.

Wouldn't losing the explicit user config make sense in this case? By 
changing the channel count, the user has updated the queue layout, the 
queue<>vector mappings etc., so I think, the previous configs from set 
queue<>NAPI should be overwritten with the new config from set-channel.

> How does the user know whether queue <> NAPI association is based
> on driver defaults or explicit configuration?

I am not sure of this. ethtool shows pre-set defaults and current 
settings, but in this case, it is tricky :(

  I think I mentioned
> this in earlier discussions but the configuration may need to be
> detached from the existing objects (for one thing they may not exist
> at all when the device is down).
> 

Yes, we did have that discussion about detaching queues from NAPI. But, 
I am not sure how to accomplish that. Any thoughts on what other 
possible object can be used for the configuration?
WRT ice, when the device is down, the queues are listed and exists as 
inactive queues, NAPI IDs exists, IRQs associations with the OS are freed.

> Last but not least your driver patch implements the start/stop steps
> of the "queue API" I think we should pull that out into the core.
> 

Agree, it would be good to have these steps in the core, but I think the 
challenge is that we would still end up with a lot of code in the driver 
as well, due to all the hardware-centric bits in it.

> Also the tests now exist - take a look at the sample one in
> tools/testing/selftests/drivers/net/stats.py
> Would be great to have all future netdev family extensions accompanied
> by tests which can run both on real HW and netdevsim.

Okay, I will write tests for the new extensions here.

