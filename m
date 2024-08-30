Return-Path: <netdev+bounces-123689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541D1966280
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC82E1F2206F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661D1B81C5;
	Fri, 30 Aug 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqjOEWjs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E31B6530
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023003; cv=fail; b=mzVMA8ZNZ+B0xLcVMq/htXXbrnAwBs9v6KqKcCOdEdZrdaHAGTW3XGqYB/wTXMUZVHZOfK1E6vCN52qKgeZmnTchqTaIhq/IwUuAaAXkL6kefN/mu3OMCa4djgQM4fw9m+BM9Gptyct2iaxyQykOJn2xNapMnGEdeBO2hbZi9Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023003; c=relaxed/simple;
	bh=hPC/rnL98DW7sPGE5RIViIPb/UMeFDgUHomKtRpXAZA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b/kfFU9wB6L8Z76YWzAa+yuYJ7LoBSvypaZpAFIRxYV3jB7OfLs20euzOtQlaWDXF3v3QqhRkIxt/8EPZ/ZbCaaywCX+zsDleeJhhhxNoTVhpaOhqo4BZEbjA31ph0X9JkqtpMv3TuSbl3T9icAWZSkg9f3890pXn2rLpRubIRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqjOEWjs; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725023001; x=1756559001;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hPC/rnL98DW7sPGE5RIViIPb/UMeFDgUHomKtRpXAZA=;
  b=GqjOEWjshlzbw9tDr6SJ+KfWZ4tIvFqoyL3i/bA+VKJtRmfX8lAOqya2
   k3Qq6dhkzeUr5AhLjyD9KYrziHyGuDnq9gc5N1nzjACEG6ch1eQcic0wt
   rXzjVic4NBz3+cTqwVVPLBU1FBBSHMd0meo8NZxNwfeHWCGfG1t2psZmp
   tKyjTJvM1HgwnUWwu1/Eg4+ChhLChUx65dqaM8nb8BbTgcFY9UqUyqqtS
   PvYj9D23nq8Yl2yRVfBqtyUanw4X7MJFTXo4uV99Xe2FJ1UzjTImSrKq8
   vGtvQkh40fsRlq96wlTkpr4/Jde6oC47UbQX2lxqSmAvrfnLkYlu7px32
   w==;
X-CSE-ConnectionGUID: uHBOm7E2TmW6efXDAewsKw==
X-CSE-MsgGUID: ZmLffx1KTZWu7zKVz596Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23618898"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23618898"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 06:03:20 -0700
X-CSE-ConnectionGUID: 7LhXwkpBQRuPxDIkuCQoCQ==
X-CSE-MsgGUID: CHOsRKfiTYmb4GsGVqH2kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="94628588"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 06:03:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 06:03:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 06:03:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 06:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn2e1R1MNpHTqLz4UP8XasRHHa9eqobURi1+uTGK9/o2hJgCHEYLqbLJPOlvdFq/HuI/SEzSM6sgIY85y9rT/hjwZHf3Q+sIfX124uQ7m0RioRsbsHVWeW3zKjgwKPCKRnd4G+71VCtLi+7n6Iu1MxGsh1oVVGc9HFl9X5sLgvecDs2RDxuKZEfj2YKNy4L7ibqlfMkaUBb/LAqXQzQQeX4Jv8vsZSXqWhoOAq/7iJTjSwrfv+NGiMKN4Xsu8zNJzWcNYGnp5KGtgwHqwNQ3fuvzPmKEZ914gndXkDw+7y3SkQJnGQ1i9gDB6Y0hXUXwHUBL7OiWfOoNMfxLB6885w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzqrfRcwaF/UfVT3EsKKJs3bRGvYfLqhVCgZRWObBGQ=;
 b=ULPIlMQbcoYfT40C600rMaUG1B0TZPwFm4rvHGvGqzIxc7tPYHaizzJjFb1A3mAWE3byvuM82oz+CS8+xSgYk1/nBJtl7ohdXa+208m4kkcuYavs0hwpCBKIUc9y7g7FIcXKWQsbOTgh0G5z8xiR7RqF252c+s8zOUeZKJY7tmaYBdCzFH+wtocb/9sqq4jkOvLT3RfCbis3cHfXGRsoyQE1u36R6TpWYhU1frkXtCZe12e0TPMmGGoc4Khv8868Gbtit58zm45o81jVwIvE+aJobd2yQRWiVFWZ/3Q1A3RqK+Qw+3bGFK7rn5/a0JgUIzBrpM9mo8WLO4SQ41HGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 13:03:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 13:03:08 +0000
Message-ID: <857dceaa-7ef7-40c6-b519-2781acaa8209@intel.com>
Date: Fri, 30 Aug 2024 15:02:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: sched: use RCU read-side critical section in
 taprio_dump()
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240830101754.1574848-1-dmantipov@yandex.ru>
 <20240830101754.1574848-4-dmantipov@yandex.ru>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240830101754.1574848-4-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0088.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL1PR11MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9c5e09-dc0d-4cca-f93d-08dcc8f4183c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RS9oZTFZZGdvNmxieDJPT3BiTXhwd211RElrTnpndzdQOEtWekJHTk9odi95?=
 =?utf-8?B?STNQakxhQ055bjBtYXN2N1o2SUxaVkRCcUtHN2V1cVkxR0VHa0JkdlZ2Qjh6?=
 =?utf-8?B?ZHRLd0NIalBGbWh0S2w2dzJITWRYczZtc0hZeHRTSnpuVWZZbzEvTDZraUcz?=
 =?utf-8?B?VjJlRnJqYURKZVJXMWFKVVFuL2FqL0xSUSs4S1JBN1lvTmVURlNOcVNoMjVm?=
 =?utf-8?B?a2VOTmp2MVN2Wm51aSt4TUVRQ1hYNmNnVU9meEFoZklaZjVVOC9Tb3o4TUln?=
 =?utf-8?B?ZENDQm9kandZRW92cGFUSzhJK3J0MU4xb0RsckNLWllGQnRZbHdhaHUyWUV6?=
 =?utf-8?B?OVlTM1dwaGxwWU1wRnRlNDFCY1BDNkhBSVRVdWdyK2dSNXNvSlRZN0JwcU1y?=
 =?utf-8?B?MlZsVzZBckl3U0xYWjg5dGwvMnlRZE9md2tGZmFNdXEwRHBxQTdOZkpjbkxH?=
 =?utf-8?B?OUlzY0R5NCtadmpWNEtMK0I1aTN4My81dHB5VVcwUjlDOEpib3JjUjF2WTBT?=
 =?utf-8?B?TS83ck16bldralBrWWNEMllxZ2g0WHFwVU55ankyaTRpZmtzWUphVExUUE9W?=
 =?utf-8?B?T3hBZWtyTTZadUZtdEhrSmVTY2FRWUJFZU15OVlXZkRSdUhtQWxqV2hyV241?=
 =?utf-8?B?YjRRZnZNV0VIR3NiaFdMbGliL0hxUEpMNlVXWG1jQ0ZvT3puTGtpN3lBd0Nz?=
 =?utf-8?B?OEZBUndwMStsYTVVVFZrOFVadUZnL1VuRXU4cFpMNTlvd3E3aEd1elhRQWIr?=
 =?utf-8?B?UHlHNFJTYjdJWnJSS3k2Rk5obFZrN0dLdGRSZHg0K0dQdVlZUXlBSmhBUUpN?=
 =?utf-8?B?Szh4ck44ZkRSTHR0VzZyeUpJQ0dMZC9GWFVUWXRyQzIrVFlMaStEdDFGejRP?=
 =?utf-8?B?UVQ3NHpzMldpVjdvOXdXQXcvZUF3M2w2Ulg5WHQ2eEVOSEYzQzFDUUFtRnlh?=
 =?utf-8?B?L093Um1xWGg4d2ZYSllFektXSCtNZEszY1FqbkhwbURIZWN2Q0FlV2gwb3F2?=
 =?utf-8?B?SHdJdWJNaXdUbTRQVTZCWEYxUSs5dStPZlh4WnMxR0Z1YjJEUUsyNm8yQWM1?=
 =?utf-8?B?OGF1L1AxdVFRcmlRdXR5bWFnSkZKUTVpaGVIV296SGtoY3RCN1EyOFQxWVg4?=
 =?utf-8?B?RWxuamxGK1BhUW1xZzhmOEpIK1lBRjg1UjF3cnZ1RzNsZ2xmQUkwR3RrOWV1?=
 =?utf-8?B?bHJITFF0S0Jab0ZuOEVGUk9HQk9sZ2JZdVhvV2xGcUYxRVh3UStxTWRsUEZP?=
 =?utf-8?B?QzI3L2dwVXZQZkVHY01rWWNnSExCOVFSNTBWY1NvR2ZsVVFjSmxna09aS2J2?=
 =?utf-8?B?SEhSc1FydXdBY0tyeFFod0VFVWtaTGRkVElWZjBqaWhEZ3F6RUpJamNtQlB3?=
 =?utf-8?B?LzgyVlRhRksweExORWNnVEZyTlRiUmNqTHNDUEcwbkhaVHJvbktMQlZiYnM1?=
 =?utf-8?B?NXU0emhqRCtUeU9veXV4ZmJrSWZMekdYQzVuQUJSMmtycnJ4aEI0SEM4S3hu?=
 =?utf-8?B?eU5XaW1Ed2RqRE12TjRLYjl1ZThQdUhnQUliaE9VbUlQZEt1OUY0WWQ2dit5?=
 =?utf-8?B?SGNYWC8zbVludVYzS2liK1N3RmNCMkt2VVNRQk82TlVIU3ZHWDNESFk2ZlVS?=
 =?utf-8?B?cjNTRjdSUWUxZnpXOXBObmEvR25HVDlwUmFCaHU4SUF5UVhpRWNjaU1EOS8v?=
 =?utf-8?B?dm1Vci9ISys5ZHdSNEdmdXJiWTlQdkpKNGt1Uk1KUWc4bmlxN3BBVUJxN2Nl?=
 =?utf-8?Q?DNZGpsjhhUAT+mqvG4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emRmdndFVmxBUE5YeTZwMHk3Ujl0LzU3UWUwbjJUWktTMDJGdWZ6UDVDSGhS?=
 =?utf-8?B?T3ZLeXlqNWJ1cG5iTTJXR2UvTy8yaWRCTU1yUS95b3NXMXY1eUtYQlFvVGsr?=
 =?utf-8?B?RVhHaTQxRUpHamVYTnZWVml4U2FadDh6QVlrY2hRbSs2T0pDb1ZZMUJ6TlVZ?=
 =?utf-8?B?ZlJmL09USHJzMmtHQ2RrY09WV0RmWU1USkFPdXpmRkpwZk05VFpoOC9iUWxT?=
 =?utf-8?B?ejA4VDlxYllZSGl1VFFHcEpGTS9iVmNTR2VmMDAxYmVkdTU4eTB0UlcrNHAz?=
 =?utf-8?B?aEZmekxHL3VzN2J3aHJJQm83elFZWVk3dEF3dlYxeG1wSFhQbVE0Mk83cUZl?=
 =?utf-8?B?a1psbThDZUlYWi8xYW5BSE9ZNDBya0FJcWE1bTU1enU4UHN6MkF5WklTcHlM?=
 =?utf-8?B?bGVLdkdtL1hRblNudzBXUG5PbHRHU2Z5dW5TaTE1S0JrckgyblBxZlpTOHpk?=
 =?utf-8?B?NERKR01SRkphakg0ZW42aTJaMnFqejJTVStPLyttMUpMbWdwQWsyUTk5Q0pF?=
 =?utf-8?B?SXNnT3JLTUM4ZXZCakpTa2pkRFFzVld6aFJZM3JKdVpOaGg1SFRVS0VSWVN4?=
 =?utf-8?B?ZVp0WGdURTV3RXB5S2RGbUlOMmJPV3pQdjgzQ04xODB6dVk3NDFkWE9BUm1D?=
 =?utf-8?B?R2ROWlIyU1c3WU4wS1NFRHArUlJ2eHRnSWM3cEVQSmxjSTdTZllMTisrY21G?=
 =?utf-8?B?MTkzU21XRUpHUnpJSnQwdmVRbi9iNHY2cGZpS3NpT0F1ZnlkS3JKOXdkTElG?=
 =?utf-8?B?NUhId3RMWHNCdDdGdVZEY3NyTGtkbE0xWmgveVR5dUszRHlrbzA1SUdOWGVp?=
 =?utf-8?B?OTNITGZYcG5TWmJya1VPQWQyek15T05GVmdKdUpSQnRDSEQraTJPQ2dCdWJa?=
 =?utf-8?B?c3VQVzRYYmp1SXZSRGtOZnU1ZytuckQ5MW1UMXNsVEdxZFBHeldHVXp2MGtr?=
 =?utf-8?B?SXhuMDEvL2k5L0Q0dzMwWlpiYTBxTEdXU29OcGUwUXFzK2UwMWdDcE9lWms3?=
 =?utf-8?B?N1ZDbE5Vd050T05BRTByS2hCeU1JQWZTN1pEOC9HNng4YUhGdW5mc3Z2b0l0?=
 =?utf-8?B?dGc2L0NXa3ZhY205UkNXRjEzcmpDdDR2WWVxYTQrT0h5ZUV6a1JmUkprb3VJ?=
 =?utf-8?B?ZGppeXg1QngxN1MxWVNwYmNVZ3pMQmF1ZWJPUUdNZVhVTEJoMTZIQmVNVXMz?=
 =?utf-8?B?MnlSaVJsbThzT044R3dNZ3NOVnloNkRSNkJiWUpVL1pyalMvTXZ4OUpnMUQz?=
 =?utf-8?B?RENNV25JT05pQ2owRmZCRk1VanZ4ZHRqNEI1MjJRT2J6Z09nNzlVR1VsWFBJ?=
 =?utf-8?B?SDIwYkFQTmFvTVB5ZWhnaEJCYjQzMUJoeldzTm1YVWtWTko5WnFmeU16R010?=
 =?utf-8?B?RzBta3JCY1pNNDcvRU55UFJEYlo4UTMyaGdnM0JwMVo0SnhwWGtrVVdtR3Uv?=
 =?utf-8?B?YW8rTU9QVldDNndUcEs4eGRsTWVJbDZJQ1FsRE84NWRpTi9MbFduRHU0d0N1?=
 =?utf-8?B?ZUp6NEw4anlUak93d1RZWDhFK2JYODk2VHJZb1FYRGJ0YXJQbmdhZnBlVHhX?=
 =?utf-8?B?aWluSmVvT0Vudk1TTldQNFV5Y0NIa3dNaEJLNmFsVVN4U3lQSjNQMm9CbnNr?=
 =?utf-8?B?NldyQXZPTllQTWhTbE5pRGk2aXRQVlRhM1VmcmowS0dyZGUvT2hsSklaeFN3?=
 =?utf-8?B?UXJaYWY2T0p3T0c4UGVUemJzRnREQ2FrQ0ZSc1ZuZTFlYWUrNVp3Yy9qRzZF?=
 =?utf-8?B?M1dZazV0VllvdzYwL1pPN2U2MnNXOHpaS0krdElVTlQzY1E3MFA3eENNNXVh?=
 =?utf-8?B?eFMxU2NmeVZwOWZhMHlmQUM2TExMMERtUVREc2pYZ3ZwYk5uNER4aWtDQVJD?=
 =?utf-8?B?NnRUZUp5NzJSczNvWEZHbVZ3dUVza0JYNUVxQjJoNW9ybjlEaXNqR2o2YjQ5?=
 =?utf-8?B?cTFvRmhSUC84alU3SFRkRm1CWnJZbmR5bWxjY0Q1alpoS1cwOE9Ibjc2OGI0?=
 =?utf-8?B?UnJWZERUUS9YWEJOQ3ZmR0RlZE1Rb0VYT1Y3Wjk3MEgxZFhhdU5FZU11bDVT?=
 =?utf-8?B?QW13VmwzeTBmOHJHR093eUI0M3FQVGdpYWJRSE4vMks5eE9HU1JxQ0NHOU56?=
 =?utf-8?B?bkZrbFlwUFAvcVVOK0NKeVkrMm02U2FQUkdiaXFXL1hJS1NPdWJGMSsrRHBn?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9c5e09-dc0d-4cca-f93d-08dcc8f4183c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:03:08.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysuaCK+x2I6nqDfjzZ0ICPujEZ91MPuX2BALAYQQJv3cdKawjgjPJ8GLf6VyYv/3OXrWEYvqoDJUn1oCKegL5bXuOZVa4webDEF0nDxY4As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5256
X-OriginatorOrg: intel.com

From: Dmitry Antipov <dmantipov@yandex.ru>
Date: Fri, 30 Aug 2024 13:16:33 +0300

> Fix possible use-after-free in 'taprio_dump()' by adding RCU
> read-side critical section there. Never seen on x86 but reproduced
> on a KASAN-enabled arm64 system (note that original issue was found at

"the original issue"?

> https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa on arm64):

You need put all the links at the end of the commitmsg and leave only a
reference here.

"(note that original issue was found at [1])"

Then, before your SoB:

[1] https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa

I think you could shorten these splats by dropping unrelated parts (see
below):

> 
> [ 1601.079132][T15862] BUG: KASAN: slab-use-after-free in taprio_dump+0xa0c/0xbb0
> [ 1601.082101][T15862] Read of size 4 at addr ffff0000d4bb88f8 by task repro/15862
> [ 1601.085149][T15862]
> [ 1601.093445][T15862] CPU: 0 UID: 0 PID: 15862 Comm: repro Not tainted 6.11.0-rc1-00293-gdefaf1a2113a-dirty #2
> [ 1601.100771][T15862] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-20240524-5.fc40 05/24/2024
> [ 1601.106651][T15862] Call trace:

The below 4 lines can be dropped.

> [ 1601.107395][T15862]  dump_backtrace+0x20c/0x220
> [ 1601.108397][T15862]  show_stack+0x2c/0x40
> [ 1601.109220][T15862]  dump_stack_lvl+0xf8/0x174
> [ 1601.110041][T15862]  print_report+0x170/0x4d8

Up to here.

> [ 1601.110848][T15862]  kasan_report+0xb8/0x1d4
> [ 1601.111991][T15862]  __asan_report_load4_noabort+0x20/0x2c
> [ 1601.112880][T15862]  taprio_dump+0xa0c/0xbb0
> [ 1601.113725][T15862]  tc_fill_qdisc+0x540/0x1020
> [ 1601.114586][T15862]  qdisc_notify.isra.0+0x330/0x3a0
> [ 1601.115506][T15862]  tc_modify_qdisc+0x7b8/0x1838
> [ 1601.116378][T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
> [ 1601.117320][T15862]  netlink_rcv_skb+0x1f8/0x3d4
> [ 1601.118164][T15862]  rtnetlink_rcv+0x28/0x40
> [ 1601.119037][T15862]  netlink_unicast+0x51c/0x790
> [ 1601.119874][T15862]  netlink_sendmsg+0x79c/0xc20
> [ 1601.120706][T15862]  __sock_sendmsg+0xe0/0x1a0
> [ 1601.121802][T15862]  ____sys_sendmsg+0x6c0/0x840
> [ 1601.122722][T15862]  ___sys_sendmsg+0x1ac/0x1f0
> [ 1601.123653][T15862]  __sys_sendmsg+0x110/0x1d0
> [ 1601.124459][T15862]  __arm64_sys_sendmsg+0x74/0xb0

Drop the below lines up to (not including) "Allocated by task".

> [ 1601.125316][T15862]  invoke_syscall+0x88/0x2e0
> [ 1601.126155][T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
> [ 1601.127051][T15862]  do_el0_svc+0x44/0x60
> [ 1601.127837][T15862]  el0_svc+0x50/0x184
> [ 1601.128639][T15862]  el0t_64_sync_handler+0x120/0x12c
> [ 1601.129505][T15862]  el0t_64_sync+0x190/0x194
> [ 1601.130591][T15862]
> [ 1601.131361][T15862] Allocated by task 15857:
> [ 1601.132224][T15862]  kasan_save_stack+0x3c/0x70
> [ 1601.133193][T15862]  kasan_save_track+0x20/0x3c
> [ 1601.134102][T15862]  kasan_save_alloc_info+0x40/0x60
> [ 1601.134955][T15862]  __kasan_kmalloc+0xd4/0xe0
> [ 1601.135965][T15862]  __kmalloc_cache_noprof+0x194/0x334
> [ 1601.136874][T15862]  taprio_change+0x45c/0x2fe0
> [ 1601.137859][T15862]  tc_modify_qdisc+0x6a8/0x1838
> [ 1601.138838][T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
> [ 1601.139799][T15862]  netlink_rcv_skb+0x1f8/0x3d4
> [ 1601.140664][T15862]  rtnetlink_rcv+0x28/0x40
> [ 1601.141725][T15862]  netlink_unicast+0x51c/0x790
> [ 1601.142662][T15862]  netlink_sendmsg+0x79c/0xc20
> [ 1601.143523][T15862]  __sock_sendmsg+0xe0/0x1a0
> [ 1601.144445][T15862]  ____sys_sendmsg+0x6c0/0x840
> [ 1601.145467][T15862]  ___sys_sendmsg+0x1ac/0x1f0
> [ 1601.146410][T15862]  __sys_sendmsg+0x110/0x1d0
> [ 1601.147293][T15862]  __arm64_sys_sendmsg+0x74/0xb0

Same here, the below 6 lines are not needed.

> [ 1601.148116][T15862]  invoke_syscall+0x88/0x2e0
> [ 1601.148912][T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
> [ 1601.149754][T15862]  do_el0_svc+0x44/0x60
> [ 1601.150532][T15862]  el0_svc+0x50/0x184
> [ 1601.151438][T15862]  el0t_64_sync_handler+0x120/0x12c
> [ 1601.152311][T15862]  el0t_64_sync+0x190/0x194
> [ 1601.153208][T15862]
> [ 1601.153751][T15862] Freed by task 6192:
> [ 1601.154491][T15862]  kasan_save_stack+0x3c/0x70
> [ 1601.155491][T15862]  kasan_save_track+0x20/0x3c
> [ 1601.156521][T15862]  kasan_save_free_info+0x4c/0x80
> [ 1601.157357][T15862]  poison_slab_object+0x110/0x160
> [ 1601.158300][T15862]  __kasan_slab_free+0x3c/0x74
> [ 1601.159265][T15862]  kfree+0x134/0x3c0
> [ 1601.160068][T15862]  taprio_free_sched_cb+0x18c/0x220
> [ 1601.161046][T15862]  rcu_core+0x920/0x1b7c
> [ 1601.161906][T15862]  rcu_core_si+0x10/0x1c
> [ 1601.162693][T15862]  handle_softirqs+0x2e8/0xd64
> [ 1601.163518][T15862]  __do_softirq+0x14/0x20

> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v3: tweak commit message as suggested by Vinicius
> v2: added to the series
> ---
>  net/sched/sch_taprio.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 9f4e004cdb8b..f31feca381c4 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -2374,9 +2374,6 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
>  	struct tc_mqprio_qopt opt = { 0 };
>  	struct nlattr *nest, *sched_nest;
>  
> -	oper = rtnl_dereference(q->oper_sched);
> -	admin = rtnl_dereference(q->admin_sched);
> -
>  	mqprio_qopt_reconstruct(dev, &opt);
>  
>  	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
> @@ -2397,29 +2394,37 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
>  	    nla_put_u32(skb, TCA_TAPRIO_ATTR_TXTIME_DELAY, q->txtime_delay))
>  		goto options_error;
>  
> +	rcu_read_lock();
> +
> +	oper = rtnl_dereference(q->oper_sched);
> +	admin = rtnl_dereference(q->admin_sched);
> +
>  	if (oper && taprio_dump_tc_entries(skb, q, oper))
> -		goto options_error;
> +		goto unlock;
>  
>  	if (oper && dump_schedule(skb, oper))
> -		goto options_error;
> +		goto unlock;
>  
> -	if (!admin)
> -		goto done;
> +	if (admin) {

Why did you invert this condition and introduced +1 indent level?

> +		sched_nest =
> +			nla_nest_start_noflag(skb, TCA_TAPRIO_ATTR_ADMIN_SCHED);
> +		if (!sched_nest)
> +			goto unlock;
>  
> -	sched_nest = nla_nest_start_noflag(skb, TCA_TAPRIO_ATTR_ADMIN_SCHED);
> -	if (!sched_nest)
> -		goto options_error;
> +		if (dump_schedule(skb, admin)) {
> +			nla_nest_cancel(skb, sched_nest);

The original code doesn't have nla_nest_cancel(), why was it added?
If it's needed, it would be good to make it a separate patch.

> +			goto unlock;
> +		}
>  
> -	if (dump_schedule(skb, admin))
> -		goto admin_error;
> +		nla_nest_end(skb, sched_nest);
> +	}
>  
> -	nla_nest_end(skb, sched_nest);
> +	rcu_read_unlock();
>  
> -done:
>  	return nla_nest_end(skb, nest);
>  
> -admin_error:
> -	nla_nest_cancel(skb, sched_nest);
> +unlock:
> +	rcu_read_unlock();
>  
>  options_error:
>  	nla_nest_cancel(skb, nest);

Thanks,
Olek

