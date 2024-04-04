Return-Path: <netdev+bounces-84794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA99F898574
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DB71C21415
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B2811FF;
	Thu,  4 Apr 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdlJc4Vu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9B80049
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228027; cv=fail; b=RZem2x99yXIzxbAczejVYKwFv4ZKjlM848CBQQZCj4uc1qaTSFP5YIykYX9jxphQU77ZLoQp1n0DMC8X/8OFRsv1q0X75An0lerNxAkuNT7fIHRJfUSsbJCiESEILDE7Y9Mjp9QAk7X8UIN9r/TJMM4ArvfYx+a+yOV5JEt1Keo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228027; c=relaxed/simple;
	bh=d9Cv+Ra4CL+ZvaehSSKPFApHQoRU/5R7W+Q27Bos5j0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YDTQ40hewoohEjDDiG3lWpYh594ib7vCwIlb8yYY5Uxrtt4wScfwBRF6oiHejsFiHkPYl3NsQBEcApcPIpme8Rpu85ZLS3rRVDVArS7Wi5+hL/jKL59UjDYJyovT7xFhNtwNUSXCEzIUXWr/KoKy7U18qmZkFHSGxW2ELt0rax0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdlJc4Vu; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712228023; x=1743764023;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d9Cv+Ra4CL+ZvaehSSKPFApHQoRU/5R7W+Q27Bos5j0=;
  b=PdlJc4VuH+bNN7b8Lays6GPoQsfMwjl2oIhYUBayz4Du5VyNiAUwHZsi
   tVTL8KUe2yNd/sDhQYY80DLHerAWcuxr30a8rhaqJn+FlbUVjoLt9cJJ6
   1pBej8a0pU/uVWCIYVKtXcchlphbyI2IqzFMUev44yoGc4P/t+RJstGIn
   Hc2QPwZnU/Ve5iraZ+293dtBm9C/0THVmrYur4sN7tQ3scyf3MlVGW/fb
   zUYIv9ylp3ldkG6opUXnH/Jcm3xAKbG0wo1ebwZ810Vo00pwtrQyE4G8U
   x8mjBRil6u9xcybwWKGUDEhg6MNYjJrpsGLgtNEA7R/CrWw7+qzi50b50
   A==;
X-CSE-ConnectionGUID: ReRl2xP2QueRP2jgaGBfDw==
X-CSE-MsgGUID: YnpLTUDwRXqyaLyWPRklvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7610880"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7610880"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 03:53:43 -0700
X-CSE-ConnectionGUID: bT2JNdajS6C2pWUmOPUcWw==
X-CSE-MsgGUID: dkwXAZoSRLeKm+4+MkVWeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="49963791"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 03:53:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 03:53:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 03:53:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 03:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI5eIF0UsrmX1Kq2K5UeOqCZGpcodQbYYBbiWxfDQ67gL6TB+ylY1cn34Wq/5sUoYbLEWnZyW0WnLzwemmC4oW6G3VyppUCFzAot+DDkgyGdqnV6fXLCWwWjDgaB/QtOXlsUt7nvmL7d2SzjYh4z/o1ogstbpiC1RHcl2lCV3+voRNEr6QSt0g7kBVsnWHgx//qC28bP4HdAcueI1Yxx7dRMeWoT0VyW573TJtyKDCxLxvsTQxnBwK5CiMXKg1WnN7C/AyihpmO3HBy06d5GVBqNqQKRt0NurX4YV2InVWFFlq6Fw/WLo92bxoIUZ7oC1LwGeWF0fG6ethE5yOMgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYMu9pOJYAo7YF14TsKWjpchR+MSUKJfJnSilJ2Zj+I=;
 b=e7N9nnLkHyTxZWLmm0RFaIPVxJn0iwWObqQonHOLd7eG/5QnhlPk3gtMWhG5eV9gdeCZJ867nEc7jTluOi+hxqwEu6ytWOV0GbBF1HwTWjjLc353Wm/Icy+4LbW0Z3WsQxyYLtYC7tRBw6V8Fp+h79SnchFydD5OC04d4IREijmqMsBwdaR9DChxeQ5UdG7FVROmfDWWq6ArVJerm4JLoypFjFaLmeTy2UxT+POTmoTybtMO2dkh8sgEcRNtx8DEucdPC4Qi7YIvoT7WBm8NgCkuOs/ANgM2ot/li5XqX0EvmCWbBKzM3JdIbMtfxgZA+NKHkel4bFQgxxcTPmH+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6898.namprd11.prod.outlook.com (2603:10b6:806:2a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 4 Apr
 2024 10:53:40 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 10:53:34 +0000
Message-ID: <2f368e21-bfcd-4f36-b0ab-1498f2663552@intel.com>
Date: Thu, 4 Apr 2024 12:52:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v5 iwl-next 03/12] ice: Implement Tx
 interrupt enablement functions
To: Karol Kolacinski <karol.kolacinski@intel.com>
CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	<netdev@vger.kernel.org>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>
References: <20240404092238.26975-14-karol.kolacinski@intel.com>
 <20240404092238.26975-17-karol.kolacinski@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240404092238.26975-17-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6898:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxfiNDEX1+RuMVFdYKwUqgK7OqEuY8wygN7O9mJfDU/1s424nxSdm6OnVT+zN4u+aNfM7WYWAgMFuQdqmkhZhDQ5oVSJJRcga92nlOfYyYvR1qwLiHQftqVIJ6jZmUwu2cv3tagA8Z0WX2fSI6wZBcOxgzs+zzDlkT1HuX+MBH2K1OzCOluwkmOqx2AVB/Wv/sJ16wzekQb1VdXLYu4mz4DXIxBps9A7yQBFJHE0o8N7Tmdq6LrtEBg0GCUQRVWUR+Jq3NnArdaPJV9KIwrldnrNkjqXk+8PY3UpNN1XLkgUVTPquGZgvrPCotoWDPQVQj5Iv2rxTTJByiNCZSbO5rNQGyfw/n63juctRPmb7YsnWdc6qdzA7oh5h04+R0UjWgqnyRmz2wliPfL5s7yuKLZdWeca2yWSEd90IPAE3zTp5MOKhgWmZdLF/ogDnllWAwPK1Nd9oftLaVaxWxJstjXSCGXHXvK/Mo+f/7m0Z/tNMfLXcrOWPMOIfeKqrsr8K0KcgemCi0GL/BVLG8WCjPRU5eTgj/KS9g9kGO3NFpU0xM9M0djUdI/kU36CptctWMPIIYn8DR4xx3FT/L72WdSN04txmuSOlCZ9eRYIc77PgHeL8ztp7bcKerAPm/2xw+dLAHQUjY2ka2a6dQDYYzrUPstejWhpOdgioBfO1iI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amtkMUZtQ3NWdytFMFl2U3AwZEVrbDU3WGxEYzBtMExrNCs2M2cwaUZhQWRv?=
 =?utf-8?B?S0RNczlseis1SWZqTmg5NURWZzNuV25lckFqNEgzOTlsZjA5cEY5S09PUjhr?=
 =?utf-8?B?N1ZxaUliTU5mc3c3Z1BFcm1uYUVadDNJeVhrTHdKNFFYRmlGc2xKamhXckk5?=
 =?utf-8?B?bjhDMFpUZTlzZjFHTytERi9oU1JHaW50S0FYc2VWNTNmVCsxMFRmVjdpYXJ3?=
 =?utf-8?B?SHJ4VDc4Tno0eXl2NkozTnRsQU9lMkNGcnpkUWhpbWVlQlJjcDRCRTF5ZWRh?=
 =?utf-8?B?bFhHZVgxWlBhVmVoSmw1WDN0M3c1Y2xuS3JaeWlBZGo2ZnNiRko4YUtvVUlL?=
 =?utf-8?B?TkFHRm9Vam9OU3Z1eDlUWjhEQzdycTlaaVM2cUJOb21IU08xNUp1eHMvMTM5?=
 =?utf-8?B?SzczNUFRaVpsN2g0UFdvdmNCbG1BMlB6ZmpiMlU1VHRObkFQeS8vYVZ0Q1o2?=
 =?utf-8?B?WS9yVXFJRUt4ckNuZjZ1OCtaSkVuMCt0L1BFeHRIdDV1SjR3T3lWbnNJYkYy?=
 =?utf-8?B?NldWUERkR2k4VVE1SFcvLzRkeHBKQUg3VTMzbE1xYzFvUFpVcmhuUU1pS1ll?=
 =?utf-8?B?NFhkeVAvcm5SQ2UvRG41c3IxSUprVCtyZjdnRU9kSndJdUozeHNUNE82ZGtR?=
 =?utf-8?B?U0ZsWkx2c0RVN0twdGFpbHZmRkpta013bGY4WkMxc3IrWXJMT3RyQngxOTVF?=
 =?utf-8?B?MGhqMmErbXIvZk4wMER2bk9McUpWRG1VMUNtWkRQcHNXY3daWUV5cU15QjF2?=
 =?utf-8?B?NjMwem5QbWpYVjF1UzdwcE1sTmhmSHhJT0xpMGIwMmo4WmJ5STlnNlI0dFR2?=
 =?utf-8?B?SjlqZCtxeGRpYm1oSm1YYTg4NXhYam9hUkQrdlRPcWJTTTlyWlJaanJsanRN?=
 =?utf-8?B?M2gwYTM0alZVaTNNd1dlOXF5QVZmdDBXdlJ5MlRhQ1E4dmFyOHBUcThIY2J2?=
 =?utf-8?B?ZGdjNjkwNk5uTkpsbWVlVjd5V2diU3BsQk1LTldQZ2lYT1FFZE1WQW9Ca1Nx?=
 =?utf-8?B?NWErU0xuR2c2bVJ6NTh4ekd1K3pIQmJHci9GRVl2UmFxZTlzN3FBYWxxSXBN?=
 =?utf-8?B?L21TejhJVVc2bFMyZ0JLakJHQ29oYUdDelNVbDBCRUFDY0lwY0tUUmFVMFda?=
 =?utf-8?B?VktlZDgxNVM4OGNCbjNHU0hNYXhjR0ZiSE5TSC9mWTFHK09QblRPeGt5VDFz?=
 =?utf-8?B?U0IxVEZ6ZVYvWXBBQmNhYWMwTHNHVGhNZGkxMTVJQTJmK2RKQ3NtQUl0YkJx?=
 =?utf-8?B?a0xnZGxLYTEzOGVwMk0zVXpya2VtdzVXUVdKZlZJQkVNZlkxUlppc0NtaEww?=
 =?utf-8?B?dHpONlJmbDNhTFVubTh0NnpQaENxeHpLT0tWMzBKNGtpT0F3N1Q4TnNFcGx1?=
 =?utf-8?B?Q3pXV1A0c2JaakpZc1VEWXIrMVUrWGJyNTZHK2dwTmptYmgzU3B1UVlqVFpK?=
 =?utf-8?B?RlhpQjJIdjJZYUFKek94QW5nRmx6OWFNUFdYZGFWeWtscFZ5blUrajB2U0Qv?=
 =?utf-8?B?djNGdmg1Y3pydlM3Wm05Z3l1MlNFdHIxeExWeGZ0b0d4ME9tRVhseDFCam9O?=
 =?utf-8?B?Nko2YW4rS3YwWE1VNGlTOXZ3MDRlOWRONzNmaWhnT2J1bDdZd2hSZVlFY0tt?=
 =?utf-8?B?bEpDT3NNVTlkSHNsd3lwNEFHNUkrSCtWWlg4RDBKUmZEQytmVFZDcWl2UG5L?=
 =?utf-8?B?Wk1vQkNkS2tHN1hnUEhlcy9vaGExVlV3MStyb24vTWtPVXA5eWszRFhmUWlG?=
 =?utf-8?B?SzBHOWM5eUEwT2Uyc1hydThheW1DQldkRENNckJUVm15RmlTbGpaM2tJYzFx?=
 =?utf-8?B?VDdoMVpOOC8vTzFJVlVLMXhBeGlMeTZ6a0tzZ1M4NENLTGF1MW9MMGxmaVlQ?=
 =?utf-8?B?SmR0SytXTmMyYUtWVDZKQmprM2l1ZVdqNHV0NTJQNDAvMUFITm9QcnlCb2po?=
 =?utf-8?B?dk9odC9mMmdQTjJMMVNYSHRRWFFvQW84WWtPUklLR0lXYVpQM3BOd2ZsTEFt?=
 =?utf-8?B?RW5JOHdoNVBaK00weGh2bDlVZVlBSVdRZ1RuV3JOSkZVazcrTDlJd0pZRHJM?=
 =?utf-8?B?MzlEdktMSVRNbGZ6Q3hsWWJoV0d2dHoxcHdFYytwUVZjZmlXb1lGMi9hZlVu?=
 =?utf-8?B?VGQzaVNQSnNSeGlDOGd1OGtoRnVjcE8wRStmL0lQM1R4OExxNUFnK2dtSjU2?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 071f38bd-2ccf-415f-93fd-08dc54957968
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 10:53:34.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9QcTt5lEyy4djOSbHxZTIWKbnV607D0zd9s2vNJ8Zq01tLgKYxXP2oFCuqZbL7Zvnn1+Wyqhk4Sqpd0gMj+XAvltISLLlV4s8UzULhftlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6898
X-OriginatorOrg: intel.com

From: Karol Kolacinski <karol.kolacinski@intel.com>
Date: Thu,  4 Apr 2024 11:09:51 +0200

> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> 
> Introduce functions enabling/disabling Tx TS interrupts
> for the E822 and ETH56G PHYs
> 
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

[...]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 0d8e051ff93b..6d92b5d6b4d9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -2715,6 +2715,37 @@ ice_get_phy_tx_tstamp_ready_e82x(struct ice_hw *hw, u8 quad, u64 *tstamp_ready)
>  	return 0;
>  }
>  
> +/**
> + * ice_phy_cfg_intr_e82x - Configure TX timestamp interrupt
> + * @hw: pointer to the HW struct
> + * @quad: the timestamp quad
> + * @ena: enable or disable interrupt
> + * @threshold: interrupt threshold
> + *
> + * Configure TX timestamp interrupt for the specified quad
> + */
> +
> +int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 threshold)
> +{
> +	int err;
> +	u32 val;
> +
> +	err = ice_read_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG, &val);
> +	if (err)
> +		return err;
> +
> +	val &= ~Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M;
> +	if (ena) {
> +		val |= Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M;
> +		val &= ~Q_REG_TX_MEM_GBL_CFG_INTR_THR_M;
> +		val |= FIELD_PREP(Q_REG_TX_MEM_GBL_CFG_INTR_THR_M, threshold);
> +	}
> +
> +	err = ice_write_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG, val);
> +
> +	return err;

	return ice_write_quad_reg_e82x(...

> +}
> +
>  /**
>   * ice_ptp_init_phy_e82x - initialize PHY parameters
>   * @ptp: pointer to the PTP HW struct
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 6246de3bacf3..5645b20a9f87 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -265,6 +265,7 @@ int ice_stop_phy_timer_e82x(struct ice_hw *hw, u8 port, bool soft_reset);
>  int ice_start_phy_timer_e82x(struct ice_hw *hw, u8 port);
>  int ice_phy_cfg_tx_offset_e82x(struct ice_hw *hw, u8 port);
>  int ice_phy_cfg_rx_offset_e82x(struct ice_hw *hw, u8 port);
> +int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 threshold);
>  
>  /* E810 family functions */
>  int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
> @@ -342,11 +343,8 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
>  #define Q_REG_TX_MEM_GBL_CFG		0xC08
>  #define Q_REG_TX_MEM_GBL_CFG_LANE_TYPE_S	0
>  #define Q_REG_TX_MEM_GBL_CFG_LANE_TYPE_M	BIT(0)
> -#define Q_REG_TX_MEM_GBL_CFG_TX_TYPE_S	1
>  #define Q_REG_TX_MEM_GBL_CFG_TX_TYPE_M	ICE_M(0xFF, 1)
> -#define Q_REG_TX_MEM_GBL_CFG_INTR_THR_S	9
>  #define Q_REG_TX_MEM_GBL_CFG_INTR_THR_M ICE_M(0x3F, 9)
> -#define Q_REG_TX_MEM_GBL_CFG_INTR_ENA_S	15
>  #define Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M	BIT(15)
>  
>  /* Tx Timestamp data registers */

Thanks,
Olek

