Return-Path: <netdev+bounces-99475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B758D4FF8
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA11B1C212FE
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24790200C7;
	Thu, 30 May 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGCAIjfV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E9818755F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087093; cv=fail; b=q0HILM4/O8nOsKRMi5RDqh0fPTT4XKjznoHvUm7kd7O62e4ZvfvCwyO7gnxS8reE+U2o3cLJEUM3bZYPaskcbsxVfP5rQUAoLcme4SgfVeEtCYPzrNoLlADSDYenPfYR9hRMmlGIctyzRTzTF3Ae3RFaLmfiIjG6qjToQwel4zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087093; c=relaxed/simple;
	bh=Zh+Yjx+mLiayrRZcA1BdY1Oz46Y5AhXS626Yc+UMzlg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EhRKBefmge+92cTGukcLFi8GfdjARjCgOxGfmLE5WPQX1gNq/l8wklGCxfDHXJcfzs/qCWVbCuYyCwpB5xFTWFuTaTh0goXgpWfVS3XP/SoZHAj7lNuwnGpfE+LxZAu0RvWRk/mR2/3Vvr25G7wO07y1jzjBr/ZVDY7Omvb8KTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGCAIjfV; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717087091; x=1748623091;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zh+Yjx+mLiayrRZcA1BdY1Oz46Y5AhXS626Yc+UMzlg=;
  b=nGCAIjfVqaxSXWkty9KEchueceYgKV/OacXI4qZGM8RM11l1HyG9Cg+5
   hRL98B/9qyTZsgT3aK4zKfW2/UXwJhIPeft3qXkxyX0hYcefAaA0F3aof
   bjcErjwxXqGFRJtHpKCJaaD1eAeIszz/vISn3AjtYgA5OiHPoumqTA0ql
   HleepusdwkR3YxcxHJ88+DahH1J01Ft7ox07Zib9GTINgrhRWRhWA50M7
   MNLQnwAdmD6PVo4BBuhlVnIED2a8s2QZ8uTxURtyjGhyHudCEUowVLARQ
   ngZigfFKrfw6CL4Q1y5xn+iZKIEq+Zo2G9H7pt0IgMtFloiBuzyyVArxr
   A==;
X-CSE-ConnectionGUID: GqwRPl/4TkCqqA7qSfW2AQ==
X-CSE-MsgGUID: TshpKBFKR7i+HCQZStLW6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13347520"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13347520"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 09:38:10 -0700
X-CSE-ConnectionGUID: Zt9OC9UoRTCbY+/eEhxrSw==
X-CSE-MsgGUID: H0DlEJN+T0OT719+zms8Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40343529"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 09:38:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 09:38:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 09:38:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 09:38:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 09:38:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9XkfLsLZ1i4/ooLHt/rXOxyZ8BoHAoII/UpsD4O2pt2vjoKimhesgFTcMNKIZEB3nO1ME896Txaa//EPOjii7f/Vx18MsYgZMtWOD8uRSYzwaUwlfCxQ6fL5rG84yY4p9M+Ikkfaz1awDzVoD4ypDGUQDcSzA7NF0GUSaeAiYO/2Cm/drasBVhkxyKYsI+KDx5/3Bkqcq2fhr2NNZhIjMWj9CcoK1sJmdXvk86fklq/jkENm5X+fRRxWzckvPxd5pwtOT57sQ85o8sqmai00FzHB8rwYyB0qfgdoNmCA5f/BiNWJrbTL2fKZo4Lc2duCoVJqy3pkf7ii2d32YWK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F5sOwGDTnYsMXSd6i8xyMZM/1BUWWWi9mdYu6N6yQE=;
 b=E2OxrWH9AME0oiHHfTWTzD2zsdBwtjQpgQK/lmlquNYEMGeJbhcZVWHaQAAZ70BMz5eKPaEOH4vyY1XfOeqYs9rslf/MIESdntpCJH6U8EhyXgYoEGGcFlxaGyEWKt/vVxd2tyVo7ZhCh4VDSc24qo8hhszOKHpKTAcmSmnfuMAdm5ZZ5+Dh27T4bZIfLLqNzDzNa8w/mzVBOFtsgIHZPob2bc6QLkBH7/F2dDt2UFrmKOr2c/OusdAwoaVeqlJqzs6JJvZJ1I3PsTGlNoLlteahjnKMJa12px6QslcbKW7q1z6Bu2qh3TGU3inYMvHGm7pDkOiDOw9CjsRm7ScdEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4575.namprd11.prod.outlook.com (2603:10b6:806:9b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 16:38:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 16:38:05 +0000
Message-ID: <778c9deb-1dc9-4eb6-88d6-eb28a3d0ebbd@intel.com>
Date: Thu, 30 May 2024 09:38:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/8] i40e: Fix XDP program unloading while removing
 the driver
To: Jakub Kicinski <kuba@kernel.org>, Michal Kubiak <michal.kubiak@intel.com>
CC: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, George Kuruvinakunnel
	<george.kuruvinakunnel@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
 <20240528-net-2024-05-28-intel-net-fixes-v1-4-dc8593d2bbc6@intel.com>
 <20240529185428.2fd13cd7@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240529185428.2fd13cd7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c06e859-9daf-4632-42e1-08dc80c6e17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjE0eWVQSXZ3Mkw5alpuOFZXRTN6SitoREI4My9YcEx6QnJPQ3dsS0o0VWIx?=
 =?utf-8?B?ditBdlRyNG5qaTNydmpVM3BqVWVIbThTVkRDQm4wbjEvZXFVcEd1Rk1UVjh6?=
 =?utf-8?B?cnoyV0Z2K2N4RVVId3NuNHgvS2k5enlPL0VhWjhEN2NONmtPOXNhRnVyVWpN?=
 =?utf-8?B?c094bS94RzdjUjlyNThNWmNzVW9YZWR5TmNFOGw4aldnZE5UaXFQdlplSHNr?=
 =?utf-8?B?b1dQa1U0ejkvN3NpUEk5clA3WEN5Sm9mcSs2aGtNV09ONDM0R1ZiOEVCbDRp?=
 =?utf-8?B?S2FCNlRpcytoM2ZQZGF6ZkFybHFhb3hKS1MyR01JWURYQVpLM1EzbSt3aU1r?=
 =?utf-8?B?Mkxna2c1TzJiZ1hKaEZVdGNrd3pIVjZJZGl5QkZKb2xvVkNKTUNBRGIxYXJS?=
 =?utf-8?B?bXZZQ3M5MVRTc3NSTVV5Y1lDZ0Zmd3ZCWU5nRzY3WG91MzZJTit6c0xzQ2s4?=
 =?utf-8?B?TVIxKzYwV1djMDNDcHEzSEp0cXBGcEtwVW4yOWdIempIb3E5T3hkNWt2QWNU?=
 =?utf-8?B?Nm5UbEFMZHdFRnJHYXphdGxyQ09DQ2lLNE1BL3c1UmlLd1lYQVM4RzBuYVFQ?=
 =?utf-8?B?c2k1b3pPaFFtenE1UFk1ei9nUk8ybk1XaDd4RkZyekRzTjBhYkxaUUxPWC9w?=
 =?utf-8?B?RjdwcnVFV2VTZDRvWnhKOXg1aUNxMmhDZFV1UE00VkttYlFkWXRLbmhrRUN2?=
 =?utf-8?B?bncvZEM0a21SVHp1R2xLTE1kQmJDbWNjR2srTTd3SmJrVnJFNzJkekdVMDNT?=
 =?utf-8?B?RnRtY2R2OGY5c1UxZlAydU4raWRORDVHeDR1QkdqUnh5TmpxR0ZZVWdEcDhm?=
 =?utf-8?B?QnFodlBFUlNJeiswcDh3WjRIWkF6YzNYaGxYa1YrRWo0Mi9ieGxpb2NuV3R5?=
 =?utf-8?B?SlUvQ3IrQkJ0aHZBZ3ZCSFZ5cTdiMU1kV0d1amNxZHd5YWlFS1pwQ3dObEJU?=
 =?utf-8?B?YUNwdWNPck50SE14MkRQcER3ZEJUYzJjMUZGR2hvelU4RWszc3BPYk5Bc2VY?=
 =?utf-8?B?elZqbVIrWEhzR2lMaTFnWUNFT0g3QmFnNFQzdFdCbStIOTdhTUFiRnpxRnF4?=
 =?utf-8?B?bVEvbEJralBYYmlPMExHT0RDODVvT1phdUdEVjBiOVZJMytUZENKbG5SZjhl?=
 =?utf-8?B?TVJhL0crUTVYRG8zS0w4ZGt0NlJ0eE96VXlLOUN0OXpwaEpYSER5ejF1Wldn?=
 =?utf-8?B?UWtwU0F4QlhBeGdQK1FvN1BISFpQelRGTm1GdFZYWlZxU1JWVm5YYlBiYWxS?=
 =?utf-8?B?NTE5UHkySWFEUzZ3b25NamhNeU0wN09yaXl1YnpPcGg4RldielBKRURPd09y?=
 =?utf-8?B?ZnBpdFUwQVFyeE83QmNnblBZQ1RDL2VtNDEvR24rYkRQWGZpbEl2RHlXY1Z0?=
 =?utf-8?B?T3lBSDRUUGRremdmV1MwdnJQcHFMS3NHYThmMVdIVGM4UXZNNERUdWtPOHZL?=
 =?utf-8?B?UnhIV3VhU0ozYUw5M1JOK3RUd0RiL0I5b2VwRG01RlZDWmUrMll1SHpWMUU4?=
 =?utf-8?B?Qlk2QWsyMktLNGE1NjBtdTc5WnNuc1Q4UkdHR3BGRis3dVloZjhwQ3dVZlVw?=
 =?utf-8?B?ZGFPRFBENFdkQWthdGpxaEZKcjIxQ215ZEdHYmFFVmhRMUtBS0RnL0dKeXVM?=
 =?utf-8?B?YVp1aEdYY3pueUFCWnBEUVBHYlgrcE1HS1h6ZnBBcFNJUHg3aE5QazI4WWJr?=
 =?utf-8?B?NjNKY1Z3dWxISHdvd0NkdjI4T1F4K3lFNm5yNmRvdGx0QW1BVjBWNWlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFg0cGZNMXF2ck9Ec29TTkk2RUp0bmVTVEd5K1NGKy9MT1pYMDU1MWRDOTVX?=
 =?utf-8?B?Y2tSYk9XVjU3cm1aSUpEWDF6NllLVnZraUh1VXpIcnc0ZVU5Rm5FdmRTR250?=
 =?utf-8?B?ZkJqSWhQNWZBZzM3aFBvMFBsRDZ3TjA5NjNxQnkydW0vNDREa2VjM0RrMUhi?=
 =?utf-8?B?Uk9WVUxXZVlKbnBhREZtR05CK3JjaFJjR1lXZnV2cHhiRTJiaG1UL3RyWTNv?=
 =?utf-8?B?QTcvZjJiVExveHBuWVUyU3ZIU2IxazFTc2k1d2xwMzNIZ3lzVWE3dWdWbnds?=
 =?utf-8?B?YlBxNTZ3RU1OYUcrK2NzNStNNkRURnZOVDVjeC9XRTZwSVZPOTFxYWFMNzlq?=
 =?utf-8?B?N0VBM2V2Ry9Dd2puaWRsVGdaUTNuSmQ5bzl3dkNSVkM5RmxZOHhjcGJyaWp2?=
 =?utf-8?B?ME5Ma1ozQmdvRHhmSldNdDlVb2R0Tm9nSHU0Rkd4ZThsT2tDeERYc3ROTFd0?=
 =?utf-8?B?NlkvNWhtMEM2NVhBUTN2OWh6MmpEZlhxU1FmRnVYM2RRZGpnQ2pBaXZwOC9Q?=
 =?utf-8?B?eDcxc1hSNFlXMlZjUW9OU1VDZlEvR0xWSFdVY1A0QWlFS2hMdGtBcDBQY3Zk?=
 =?utf-8?B?ZU8wMG51Q3IvQmhSZEZKVnErV0hWNjAwTng0c29sSG9ob0xhekxxMDFIbFFU?=
 =?utf-8?B?RkthbzFnWEJHUndPYkU0N2ZDQXR4Qk5IWDJRTEJjdzVSQThSNU9PTXhTa21y?=
 =?utf-8?B?dktPbkJXS0QvZUF1OSs0VHNaY1Y2MzVSUWIwRGRVNDlRWktXY3FUQ1J5MkFq?=
 =?utf-8?B?WGU4TVhVS3h1N3E1UzJmVFZmM2lnZTNxc0VieXRWdS8rZzRQVkkzWko0VTM5?=
 =?utf-8?B?MndYa1FUd2tXanp3Y3B5Z2lWZjBQSk1qN1VuL1dMMjA1RkdETitDQXQzZktw?=
 =?utf-8?B?MEZoM29XcHNBbUJteGJZYWJxdVhvcUlqanJxYkt6MXFsMVFEZHlBWk1LN0ht?=
 =?utf-8?B?WGRUaGVhUTZzV0pLZ0daS0d3YzhxZW04MSt1cGRlcm1kKy84TmJ6ZjFIWUpB?=
 =?utf-8?B?eXcwYkpXc2RodGU4cnlUVTFreWpFN2hNZlVYSzAyZlpSUFhOKzhWTVdHMFZn?=
 =?utf-8?B?c0t0cWdxOUVyVkZoekUrd2cvSVZjU2hlMytQSXRnNzRvWEFBZ1daaXBOcnk4?=
 =?utf-8?B?SThvQUxDOGJKYTJ0UGxwbGd4SEhuWXRHa05sMkFUQ1VGYlIxbElWOGh6bE1X?=
 =?utf-8?B?MmhUUmJ1S09nb0djZFlmQ2wxSndaZFFueHlUdFRpeGJYeXFPcjVraGVDUGxJ?=
 =?utf-8?B?d1JTVFA1bE15eUF4d09lM0hjZFdvSGs5Z1I2ckhzTjZXOTNiYW0yQ2NZb3Iv?=
 =?utf-8?B?RFBRL0NsV01kTmhkUk1XbXRmQjBFbWVPRVAvMnBUSEFKcjhLNS9kWit1WnhE?=
 =?utf-8?B?ME9WdEtRTERLODBJRjBqek9ydDNYYTZKSXNEeEJVcTAyTmUyN000d0NZUncz?=
 =?utf-8?B?MjVsaU15SVExTEVmc1p0Q0pmRnpMUGcyOUQyTG1qQ2NVMTdncWphRmJGNDlz?=
 =?utf-8?B?bWRvdHVlWnFxQmFpZHY0K0Q2ckpXZGhCUk04bE1zRGl3eEJGbUtVN0xuR0dJ?=
 =?utf-8?B?SWRwQkVobnBtbFU3QWxtYzB6RDV6dGdDUExtL1ZYUVRXWVVJN0ZRcm9wRzUv?=
 =?utf-8?B?cW4yTUJsMXJoMlo2MnBnOUlVdkJUeVRSaVJKaGxUL2d2RGJXQjdLMGV5d294?=
 =?utf-8?B?UUh3TERmUkRLZGNTZ1BhU2Z4amZHRDBkb0NQb3F4WGpjeE5BSG9sSlZ6N0lF?=
 =?utf-8?B?MHJJcS9ZUVZHL1M1NGtzVWlIeUFybWU2MFljTlJvZzA2ZytxSG8ySlNOM1Bo?=
 =?utf-8?B?aTd1VDIyTjB4bjF1R1VOWS9FRmF4ejFCVkRLaDNRaEl6WTNNTk5lTzREUzVR?=
 =?utf-8?B?NDI1NjFPWGdNS0FWdzRoQzY2RElLYXRPQVBlWVhnVlJYc1VVR29VNzc2RFl3?=
 =?utf-8?B?YnIzczBpS3FnNEFtNDFKRVRndWVOcnMvYXlQZFpJemtKZ296SFNCeUpKR1ZS?=
 =?utf-8?B?cXRsdVI3a1h0cUpzWE1LcEFjTElKdkxSdTdPaGticFlTVlBzT04xelUxSytR?=
 =?utf-8?B?RjhtQUdyT3BZNjZqU2g4RXFZU2l5WVB0OXhiaHBtWisxVXZCYUJDenhoc1hs?=
 =?utf-8?B?Q3AyaVQvNjQzL3lGTTRKdXlLN1oyMDlyR3lJaEE5Z2Q2ODRGdUlZVGgyMUNV?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c06e859-9daf-4632-42e1-08dc80c6e17e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:38:05.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0XHHEj3NhilDol37VpRCOYlc0g/tfdJi3ehHGApc0DgsQJcgv42FraWgIqLHGIAOl2XPBawUtrEZHOH9bN2nbgbj487RDtPWCulvYJe/1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4575
X-OriginatorOrg: intel.com



On 5/29/2024 6:54 PM, Jakub Kicinski wrote:
> On Tue, 28 May 2024 15:06:07 -0700 Jacob Keller wrote:
>> +	/* Called from netdev unregister context. Unload the XDP program. */
>> +	if (vsi->netdev->reg_state == NETREG_UNREGISTERING) {
>> +		xdp_features_clear_redirect_target(vsi->netdev);
>> +		old_prog = xchg(&vsi->xdp_prog, NULL);
>> +		if (old_prog)
>> +			bpf_prog_put(old_prog);
>> +
>> +		return 0;
>> +	}
> 
> This is not great. The netdevice is closed at this stage, why is the xdp
> setup try to do work if the device is closed even when not
> unregistering?

The comment makes this seem like its happening during unregistration. It
looks like i40e_xdp_setup() is only called from i40e_xdp(), which is if
xdp->command is XDP_SETUP_PROG

From the looks of things, ndo_bpf is called both for setup and teardown?

>    7 >-------/* Set or clear a bpf program used in the earliest stages of packet
>    6 >------- * rx. The prog will have been loaded as BPF_PROG_TYPE_XDP. The callee
>    5 >------- * is responsible for calling bpf_prog_put on any old progs that are
>    4 >------- * stored. In case of error, the callee need not release the new prog
>    3 >------- * reference, but on success it takes ownership and must bpf_prog_put
>    2 >------- * when it is no longer used.
>    1 >------- */

Indeed, dev_xdp_uninstall calls dev_xdp_install in a loop to remove
programs.

As far as I can tell, it looks like the .ndo_bpf call is made with a
program set to NULL during uninstall:

>    30 static void dev_xdp_uninstall(struct net_device *dev)
>    29 {
>    28 >-------struct bpf_xdp_link *link;
>    27 >-------struct bpf_prog *prog;
>    26 >-------enum bpf_xdp_mode mode;
>    25 >-------bpf_op_t bpf_op;
>    24
>    23 >-------ASSERT_RTNL();
>    22
>    21 >-------for (mode = XDP_MODE_SKB; mode < __MAX_XDP_MODE; mode++) {
>    20 >------->-------prog = dev_xdp_prog(dev, mode);
>    19 >------->-------if (!prog)
>    18 >------->------->-------continue;
>    17
>    16 >------->-------bpf_op = dev_xdp_bpf_op(dev, mode);
>    15 >------->-------if (!bpf_op)
>    14 >------->------->-------continue;
>    13
>    12 >------->-------WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
>    11

Here, dev_xdp_install is called with a prog of NULL

>    10 >------->-------/* auto-detach link from net device */
>     9 >------->-------link = dev_xdp_link(dev, mode);
>     8 >------->-------if (link)
>     7 >------->------->-------link->dev = NULL;
>     6 >------->-------else
>     5 >------->------->-------bpf_prog_put(prog);
>     4
>     3 >------->-------dev_xdp_set_link(dev, mode, NULL);
>     2 >-------}
>     1 }

I think the semantics are confusing here.

Basically, the issue is this function needs to remove the XDP properly
when called by the netdev unregister flow but has a check against adding
a new program if its called during remove...

I think this is confusing and could be improved by refactoring how the
i40e flow works. If the passed-in prog is NULL, its a request to remove.
If its otherwise, its a request to add a new program (possibly replacing
an existing one?).

I think we ought to just be checking NULL and not needing to bother with
the netdev_unregister state at all here?

Hopefully Michal can chime in with a better understanding.

