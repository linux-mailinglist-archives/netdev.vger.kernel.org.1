Return-Path: <netdev+bounces-86333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FB489E689
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AE8282D2B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473E82A8D0;
	Wed, 10 Apr 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fC667ytd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10EA4087B
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707246; cv=fail; b=l4lLrqpKYf/bU4KoduWL6YyyVt4M/TobN8KDijC9cWhUwLin7Bv+UsePgx8KVOuRo32v+kHWvX1DYvDbq2lXPAYSdJ7jJGcO3QyuqiIupDYGcFy6z+IwN00qWyN6FYDf2RESY8PlNeqPFILN30i3EQveRojZ7MY2eQ8FqPQgabo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707246; c=relaxed/simple;
	bh=2+6Ti55kxXkwi9nY7U4ljFYZHBo0kyBaq9DPlsKtyOk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rUC5vF+6RHYlRZzCPvNFKOykJQx5tZa880z59wlvKpA1hzeSvUHWsoSUQA71G7kPrvEVqxx0+ZwhGXSoJMwRwu921+TVzJa4i6z5XhOVYFvpDhoAA09UFxfOf6iPOybxalWUmF8yQSOQaQ1CeLMF9rhDf0IzyipwVxmkype0L0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fC667ytd; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712707244; x=1744243244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2+6Ti55kxXkwi9nY7U4ljFYZHBo0kyBaq9DPlsKtyOk=;
  b=fC667ytdntIngVLpAjZNpxM203DzEEakzwF02pYIeXQwWyrqSMRGfl9i
   YUpGwu/KYh5Kga4izf4qCj+tk5ZaY6nLnt8gXhF1TtkwKOG0da1YBzF0l
   Udlihy/wm9gsVapc4X1GmTyuHHL2kraxG/7kbWFm5qTOTSDcVGtIhBiEk
   V8G3Tvfg6qHFZQ2bch9qwCMQ3TfWWEruPIkbhdyeSKzWzG5aSScoR3S/W
   2XberxYsZTFuZ6k8UIht8WhqMa2N/Gcpj1s/KKXVJD84g2Q5hol99kdZP
   WGC7H0WvnikCQrtsMPdCz0iiEKwSxmqzeGoVUswrl5HZb9tODpjjgwxdI
   Q==;
X-CSE-ConnectionGUID: SwMBrTYdRpOfiv9VeCmRZA==
X-CSE-MsgGUID: A3GaMzQqTYGydXODYfECzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8276734"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8276734"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:00:44 -0700
X-CSE-ConnectionGUID: xvr08mnNTEeeL8Mo/TDhbg==
X-CSE-MsgGUID: Mzru0TnETwCapc/KGb8uvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24992260"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 17:00:44 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:00:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 17:00:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 17:00:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/WO5r+TQzUQiiZRHuJtoEruQmx/B7szZeGmd/JiQizDWYNue7CbRkkRF2/E7SmsKCCLVobds9+LVRE+ydLLvgiH3F2mDTF3CUO6l6UxOqqdgyrMkLU8wSjJ8u40l0du6WHPDQ7mfW173Hvp3LsYJvW6Fs3gTIMJl8qMNPIWkqcEsWN7jbmrIZGz70KS+wp1VSyBGzySAFKdOq9jnaT5wDz5aupb80/m7+oZPld8yX+Du0Jc9XDUuO0wTa3IVQAu95tRDE1B0+ZRtVW12yKUqxi65pgatw7wCPr/Sqq7gcYV6s6djEggd79meBxlhwa2/wM6e7IbsBb0EA14+pPtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSFmCflt4XQR0BAj6wKrVXNICpw/aBwV5C8ibp2K+ZA=;
 b=gNqvpXpbNYAU7sMBbW97JBsNEthiQMxM2sdNQdvi6hrflGTPv+Fnmd0MhTZZq5yKU7suGfjhhcLipLaTBXWKVzhCUyj0l+EGcWsjc0uqWSrdXZWnt2lKhld9jgBOuXeXCB0C1/lI4n74zrOTilXrzgKQD3mW34dvnIi4iSYrQ5nIM59ilIjkiiFiQ8zeHVNSRMHlbWTRHEZX53M1v2PKnma15eXs+Stge/NeKY2hl/15O+0twh+/7Dce3CJsNztCa0DDPkXoEZvcFYLCJgJ5+zaWWZGUmk/PhL2VQh09TDzo/aFqsqb6RDvhCBH/q6Xn9koJLoIam9Byw3RkJl+yJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 00:00:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 00:00:41 +0000
Message-ID: <1331ed7d-150a-498f-b8c8-50c9daeb306a@intel.com>
Date: Tue, 9 Apr 2024 17:00:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] pds_core: Fix pdsc_check_pci_health function to
 use work thread
To: Brett Creeley <brett.creeley@amd.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <shannon.nelson@amd.com>
References: <20240408163540.15664-1-brett.creeley@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240408163540.15664-1-brett.creeley@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6860:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8dsdVSljp9wfIl+RP50TAC5Xbl/jWHtcOFAbJ6GSnd1+ELCteGqB88nXFCET/6kACU3TJneKjWuIK4Kj8ZdsEDtCicPxBoOd40rw4yzxJP9VGKvPHbQPFG8bxFDoF9hWn85Yaa0IQ640wi79KjsWEviPpoX+pxQ1K8ZOwzq6gyVlTsdfo3TVEe7eDNuwzH6m+qc5Mj0o/74sJ3HopNFO8c/2UM95t5ke2HEL9cfo59wgiMxAQqAoQfbjeesx1aQy1VxQAc0zRE/eEBU2A3ocmJHk4b8ZZqZTnfI8tLhZKgQac9ygSqe7UtuJr7dddSAPUBpH1Ax963UyUQL9VgrExptnv07OLBJoQo8CQiGJt9jdlmYCiuamX9UCgeUXuyVR77aI4DmAR7UgNy4HFW9NNrtd+SYvh5MAGhOY4QKvGsg9quaAFMSIR5gRCelA3lz4itbzR0/VwCNtquwNzHrTHN0SkoJVTIoQfJTtq50fdT6KKFr3oWQKGRnRx6+S8b59fbaMsHmXSUg+r9xPJG6HwuqxgkX+ztYAJ9OoEDYM1KgOHt2lPCISuiZLqKKNFdEVoj5RWMgET6HThpX1lXPIcjHUtjhZz7AyYbXB8VT4jBk4sM0qRAk6GbBuJVGZt3HK9IqW2qbvx7m9189P+uYZDI9+kl+q26LfOQl+pMscKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZvOGx5a2tFU2d1b0w3TmptelYwNGl4OW9Denhod0RVMGpPek8xeUhvSkdz?=
 =?utf-8?B?U0kxRHBNRElnaHBJbkRCM1diWTVLamMwdVprSnUvNW5JZE1LNFFNYjR1UFJ6?=
 =?utf-8?B?WFlqUjdiaGxLeExIMDNjR2t6WUxmZ0I5OFVDUVZlb2Y0ZFlIanZDL3drc2p1?=
 =?utf-8?B?cjFvRTRFT1RXS0hJak1acnQ0T0xITk8rZjBQNFV5dy9OS3Z0ZWx3cGRZWFpv?=
 =?utf-8?B?bGdkWjhDYXhMKytjMUQrWi93ZUY4WTlwSUVoQUMyQ1VoM3pocnZyb3EyRlZQ?=
 =?utf-8?B?NmlGajdIRGNoL0M0eUlnMUxRd1VZK0p3WlFnOWZzY2NXaHU0ZEJBaGdQT1dy?=
 =?utf-8?B?VXBTOW9zU2Mwa0VKcjV4MjI4UUs3Qzh2OW13bDNOb2VpODRCVGtsWUVjTzZp?=
 =?utf-8?B?L0lnT2JrRmVBdFc3RzZUcDBiNlRFcXJhYllwcDQvdWVmSUI5R3A2dWtja292?=
 =?utf-8?B?RzA2RzRjT0RnQ2RoQjhMclJIR01jOFBqWk5IbmRScFRYeHZ6L3l3VGNVM0Ey?=
 =?utf-8?B?d3ZLcWo5NHh1aUNuaUoyYURCSWF0eFhoZUdVLzZJbDNtandaVSthQWJOVTNx?=
 =?utf-8?B?VUtSWWhnbXJkdFBtck51b2R2M284UG1IclRiRTJKK1RHVm5LamdaNzlLTDNN?=
 =?utf-8?B?ZjBGZ2taMFhUVTBLK0FIUWRzbVJsNGpmbWIwMlN4WEdGWVUvaTJEM1JkUDM2?=
 =?utf-8?B?YVNrcTRYbnFtdXVrUlFoL2ZKZXpIVUFSSEFPZkI3aC9rM3RTQXplWFdjMXRE?=
 =?utf-8?B?dlIzSDhUT0FzT3YrSGNlZTJZQjYxOU5qVHdTc1RhdjJqU09GY1JkVGt1bldD?=
 =?utf-8?B?aUR1cVRqVVMyRnp5OGVLM25uRSs1bjhjWmNpN2VPUkNRa0dGZndDS0hCTmNt?=
 =?utf-8?B?ZkR2cUswTTVaMFk3VEdsalpjK0F5VzhZaTJyNFZVKzFlMU8xL2pVT3psbjY0?=
 =?utf-8?B?dDBJZi9aZXlncVdENVpieFJTdmhsc01pWUtieUhtZHdrL0hpazNabGJmeXFW?=
 =?utf-8?B?VXpqd1JYZ3krTTdETXljRk5DcnhqOG13c1B6TGowK3VoZVVJenVybGtZMklJ?=
 =?utf-8?B?ZXVlL0xJbmNZa2pJSXl3L2tuS0RSVEViS2xyTktmNW5tM0pHNml3NHBVQUda?=
 =?utf-8?B?eHE2MWNrQnNGNm9kenhnSS82dW5KdTczZFZjSVkzWitVYnozREp1Ny83aEFU?=
 =?utf-8?B?REx2Wks0eU8wZms2Z2pPMGttVC81cDBxOGJaWGtvemkzSHZIVHV3dFRBelBL?=
 =?utf-8?B?VXU1V2J6cU9aUTRONmFhTTRpQ0k0S05pbWE1UmZRTlMrd1Zja3BqYThiVGpa?=
 =?utf-8?B?S0lPeDlYeWNSN1czUTh5SVcrb0lMT3F3SlY2V0RiOFN5U2t1VVV0bUFVSStC?=
 =?utf-8?B?YXpRa1NsNkx3N3VZZnQ1bkxLUlBJNzB3TzBveWJnNFJGNExuTGlmNHZScEpw?=
 =?utf-8?B?VXNZS3hhUlFLeXNIYUJ6cHBWSm9qZm5rOXQ2NHFvRUFZWlh3eC93dkdPSHQy?=
 =?utf-8?B?NkxHQ3c2SGhWYU5PUlJqT2JQZ1VNVGR3U242UUhUK1V3SVNZTEYzTkVsQWJV?=
 =?utf-8?B?Tk5weEhJQjczK3NFVG9vTXZ0ZzdnaVNLSVRubXVTM0dYeitPeG0ycXNBY1R5?=
 =?utf-8?B?SVluZ2s5djJ2cFhpS2hkOEdwUVptSUpyazkzYVhvN2ZSWit0VGhKNmYzSHdP?=
 =?utf-8?B?a29IVVBZQ3dxTk9JZUViMEs5eWdBeVpTSHZ6VlNhY2VqTlU1MTRtdlVHM1FF?=
 =?utf-8?B?M2dTYUdRdlF2Q3BWdUhnSVBEVWRXazJhS3ptTU5DVFFheC9kVTdGU0R4Qzd0?=
 =?utf-8?B?Yk9Nd1c4NWRQWFBhNm9tQ0JrbnFHcFZOd0hzODZqYTF3emJoMmVoa1dvMG1R?=
 =?utf-8?B?Y3ZkWlNiOVk0VDJBR1VkcStvSisyY3hhZ1NVTTJkSkYrRnNZUFBVZllpR0wx?=
 =?utf-8?B?Qkd3YisrYmFqSzlPRU1ZTWp2OUNQL3U1a3Z5YlNnU3pTVXlqSkVoajZVaUxa?=
 =?utf-8?B?d1ZlbENUd2U5R2IyVnlTNUxhcWYzUDE3aDRqK1pFbElrOVQ3ZHdjbXZRVGZj?=
 =?utf-8?B?UnlTTkttd2xvSE1nTmszMG9ZdnhEM1E3SE5pV2R4VTNoeUYxTHFpbm5XcHBk?=
 =?utf-8?B?QWpFQmMrRHI3ZXJIYXZxKzFqQlNrWWxCNE1TemttOUZqQkdzeVAySExRV21L?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb48079-4292-438a-8d5d-08dc58f142c6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:00:41.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2foIj1Adb3FXspteI4q6FdhTpAPq6muyWbzfKXk/0XQ+4grJ2oz9Z62vNvZ5MVUdpzZ23EVKEpGA2SPwZBX0Yz6bWNcv2vwnicKlTb3KjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860
X-OriginatorOrg: intel.com



On 4/8/2024 9:35 AM, Brett Creeley wrote:
> When the driver notices fw_status == 0xff it tries to perform a PCI
> reset on itself via pci_reset_function() in the context of the driver's
> health thread. However, pdsc_reset_prepare calls
> pdsc_stop_health_thread(), which attempts to stop/flush the health
> thread. This results in a deadlock because the stop/flush will never
> complete since the driver called pci_reset_function() from the health
> thread context. Fix by changing the pdsc_check_pci_health_function()
> to queue a newly introduced pdsc_pci_reset_thread() on the pdsc's
> work queue.
> 
> Unloading the driver in the fw_down/dead state uncovered another issue,
> which can be seen in the following trace:
> 
> WARNING: CPU: 51 PID: 6914 at kernel/workqueue.c:1450 __queue_work+0x358/0x440
> [...]
> RIP: 0010:__queue_work+0x358/0x440
> [...]
> Call Trace:
>  <TASK>
>  ? __warn+0x85/0x140
>  ? __queue_work+0x358/0x440
>  ? report_bug+0xfc/0x1e0
>  ? handle_bug+0x3f/0x70
>  ? exc_invalid_op+0x17/0x70
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? __queue_work+0x358/0x440
>  queue_work_on+0x28/0x30
>  pdsc_devcmd_locked+0x96/0xe0 [pds_core]
>  pdsc_devcmd_reset+0x71/0xb0 [pds_core]
>  pdsc_teardown+0x51/0xe0 [pds_core]
>  pdsc_remove+0x106/0x200 [pds_core]
>  pci_device_remove+0x37/0xc0
>  device_release_driver_internal+0xae/0x140
>  driver_detach+0x48/0x90
>  bus_remove_driver+0x6d/0xf0
>  pci_unregister_driver+0x2e/0xa0
>  pdsc_cleanup_module+0x10/0x780 [pds_core]
>  __x64_sys_delete_module+0x142/0x2b0
>  ? syscall_trace_enter.isra.18+0x126/0x1a0
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fbd9d03a14b
> [...]
> 
> Fix this by preventing the devcmd reset if the FW is not running.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


> Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> ---

