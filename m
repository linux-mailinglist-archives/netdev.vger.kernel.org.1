Return-Path: <netdev+bounces-186744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47583AA0DFA
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA6840015
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6C2C3773;
	Tue, 29 Apr 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaF6a7zP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E52C3756
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934947; cv=fail; b=G5fzLeWnAL1gSvdgalbyPCRJBBIRQHfTMGBtO/l5P4J0qzxUnIM2YBOPPsWZ9tFXsq/yeGNwfn3IrcDvjBa0IyNLtkyGkrSJwpyLB+e6I3VXq1JHmeZPsOraUvOGoc/HwtdjAVBievIhfzLVhTHUd70niKCG0R7nsk+tVFitYKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934947; c=relaxed/simple;
	bh=4/EFZYMglpmLALLWY096QOVs3McnhmYQ/2gaMxW5DJ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JWh8NvFwAcdPv6NjN8AW4GJZ8yYfhNX2ocIyQJtvmBtvPjOOK/zYch5l+abM1CfUBrcw/O0KPx9CPo/ZW7KNwFmlIVGcYflcEIuMTBG4tNQLU9U64PoxDZ6GudIbRdeeInpZEHdJEWW6kuX66MeyiQ8AS4xRYB6GtPpsK8GJk30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaF6a7zP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745934946; x=1777470946;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4/EFZYMglpmLALLWY096QOVs3McnhmYQ/2gaMxW5DJ0=;
  b=kaF6a7zPGjc2zSMkoZAz2UpUA2io/RDagX4rGWJUDg6din9QRCRuhVk6
   34DTsSrXbTZPIF5IwfMpFKE8OlSwrbPILUAIN8VrvOCGY520s0bObw8JC
   WAoPlc5UKZOx8emXMAKP1JKj70cWKMShXSN7+I/AVU5cB3gamBkRcJJ3h
   bq5pp/TDCcXAOnrL9CI0vKPBX10Ug5pToqm1QiK6Ocej+bB0wOeN32AUJ
   4hhlaDBsHTzlhIro1HwzJ1tQpgmLTY9cXCv2kBq2kShBvIAV/3UbkODwN
   gcGBBuvCG1PndF2JnDMCmKwFWbGgZXXp4HPkp2W9OBntG+fr8CXjT2GhK
   A==;
X-CSE-ConnectionGUID: YvXuj2p8S6+se36RqJElwQ==
X-CSE-MsgGUID: lAGSaU/OSTuUdnV4jnguxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58547427"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="58547427"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 06:55:45 -0700
X-CSE-ConnectionGUID: w+buBDdLTNGE5Bd3t9zweQ==
X-CSE-MsgGUID: POFA4F19Ql+7tMEcLARS4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="164916361"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 06:55:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 06:55:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 06:55:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 06:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmCxPppuKeUbtFTPLOL3W7zTGinXHdrOVzLgr3jn8jzeopn0z/hsVnOGS02SHZMVrBwcDvCwIhIdUiTdoeOD0L5RUu+6OQ2aSQmm0iMXF4YM27ZB0sSBzcPSQPcbq15GdEHTMq0uDZk4zunq8I9aeG2b5jH8jCXSm0WCmwb/ivpktF2Vjhafwbg+Mb2CIN71bs/DGuokMz+Ssm0RM+i8ZcKFAzZioqJDPczdVIbkscd0P+r6ZfczqsUn9H8/P6BEm8Ycu3SdktyYYsVeadqPgxrqdY0Xi5cxdg1PJK096kO/adKkJVoczgY5xxHHoSXtiHfnmeulgdYMQCqj9lPmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0qxTrhsuTCFsf2Fyb+bkaB/y20TNN3F0MmwBI3Z25g=;
 b=pUNGM3sI8oGxQCaN36XfKWXGtiatrPAug0RuzG4+p7c530SyiwzhmmnjGi5AFrs9J4r9Q2xhxwXiL+1IVKdSgFQ6U0mOFVw1ct4kXUPdP4mP0FuRnBx31rSIDJuARyTf91a3TugnZqWy32j/xxeNHme/hb4RR0HpLa3YMJhbyfR/fKcP8Dyju0wvUt6oV3UxaS29ww+DXi7tTWt1ErQkeFpHNNk6990TY/HzMvNWIdX0yatxJQiBOx9c782Dt5ybgKgPxg/RUz3qUHvaksrMBJMBV28pp+ACdREvNOGNjQE9ByCTGwwn3vQzz5dx2V4aAfAP9ik+S5blxsyuPDUYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Tue, 29 Apr 2025 13:54:58 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 13:54:58 +0000
Message-ID: <b7a4d9cf-2606-4d0f-8164-ae3e05069388@intel.com>
Date: Tue, 29 Apr 2025 15:54:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 14/15] devlink: Implement devlink param multi
 attribute nested data values
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
CC: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
References: <20250425214808.507732-1-saeed@kernel.org>
 <20250425214808.507732-15-saeed@kernel.org>
 <20250428161732.43472b2a@kernel.org>
 <bdk3jo2w7mg5meofpj7c5v6h5ngo46x4zev7buh7iqw3uil3yx@3rljgtc3l464>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <bdk3jo2w7mg5meofpj7c5v6h5ngo46x4zev7buh7iqw3uil3yx@3rljgtc3l464>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS7PR11MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa36a48-a1ef-41c6-428f-08dd87256e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekFFanNCakpwZTVvV1l0TWg1TlpUcUdjU2JHZWV4NlJ0TG9IT0pDcVVsN21i?=
 =?utf-8?B?NVJ6SFo1ZHkybmtPbUFyL0V1aEpzd0hQL0ttanBpZ1pCaE1KZlpyZVNIemR1?=
 =?utf-8?B?VHA0OVAwNkJTVkdvT0VwR0ZsSk9MZERmdnRYcG1sQXNzVmJEZGVsMnQweHBW?=
 =?utf-8?B?ZmN5bXJ2TjEzRUt1aXl1YVA3anpKeHk4NTFxZStUREE3a2VKL09JUGE4VnBj?=
 =?utf-8?B?Z1VaU3BJSjlOZGJWUVVTWE1tWk9qaWxMT1ZvQjZQb2lOcTkzMEFxNUFSa1pQ?=
 =?utf-8?B?cEhqd0toL1FkblNRQ0tWMStjTzhLMVBPSzYzUEdyc2x2L1pkYU50dlBCV1Ew?=
 =?utf-8?B?RWhWVkFYSjQ1ZDJ4a3NsdlhUL0hQdEpMMUtzRTBhQ2E4SmUwT0w4Q2prOXYv?=
 =?utf-8?B?cUdkUGRDWWg2cHByK2d6RFZXeE4xeHovbWx1SXZHTTduZmdnSmIvaWd3MCtq?=
 =?utf-8?B?NTNlKzFJckZLbGlDS3BSNlAxOVBMNEdJcVI3RUJIUjZiQ1NSSnFRREZKc3RN?=
 =?utf-8?B?RmhZTXM2NHhxQ2c2QnJXZm1JNzJOMDh4Ymt0dmlQUThIZnJQSWgzL0xEV0pi?=
 =?utf-8?B?WDMvclhDU201bjNTcjd6TytqaFNYek1wRys3cFA1elI4cFY0c2kyN2k4Y0VJ?=
 =?utf-8?B?Y1FVUUtEZDR2V05Oc1R6VWdCc1VBNE94SnN2QTArSDNZeS9RRWRHY25JREJP?=
 =?utf-8?B?aks2U3lERXJGZTdTOE1RNkdoaTg3d1hnV2ZhdW1ERDVZTHZKdGhTS0FqZzAw?=
 =?utf-8?B?cTJYZFcyK0VFSWRGTTBXZlRLRlBRbnIyTm9YbTh6elFRNk5qWjlLZVdXZGNx?=
 =?utf-8?B?dU5LZHluaDQxaE9WbTJlYU1ENmZQSERPQ3hrTUJOR1lZbXhCaFl0YmZsdzVh?=
 =?utf-8?B?ZE9ER21CajV5Q3VOYmhWbzBtSWxrbFZXOEVvZVE4RCs5aUozbnpqMHlRUGxF?=
 =?utf-8?B?ZndqaWdBVGNXK1hkeWdKMWREQUR0STVmVTU5bW9CcnFVbGRnYWFSUjV6UkFP?=
 =?utf-8?B?RjRMaWNIdHhMUXd2b0gyZmpHc01GbnlvaEgxRUFTN3U4N0t3TDFYQ3B1S2Va?=
 =?utf-8?B?YnFKSjdDbEhySlhGdkYybFBmem9ncDFBVkZPNXoxRjdFVFpBMWNyVlBDRDdl?=
 =?utf-8?B?UkhiTUJMdmc2NUYxN2JGdEkvWGtNRGhFc3lNOUg3QXo1b0RDblV6cWZGYVc5?=
 =?utf-8?B?dzE4VEtKdDZNTW8vcjlIWCtjRktIWjR0K2R1QUNETGE3akY1TlFLY3pkZU1E?=
 =?utf-8?B?djJvZFAyZnY4ZjFGdnQwZTQ4c0xJZHI0UGhUUlBEQ3l3cUlSODRPWm03R2RG?=
 =?utf-8?B?d2xITmlRUUc5UmIybmlOclJvaEJqcmdpTWZlMDVodUp3bmN4OFRkbWdJRjEr?=
 =?utf-8?B?dW1ObEFGbmN6TmxjZkZVbXFtN1BmcU55Z1lTT3ZCRjJoK0Q5Ryt5NTIzVFZU?=
 =?utf-8?B?WmVRazRaOURHbHhqZVNRb0pGNkdsZXRwSVkyTHpwZDlpQkxsbXU1Q0VpcGNn?=
 =?utf-8?B?TEUwM0dHY0RyZFVtYnIrLzFMcHVvUjZkQmhHZnhmTDdCcDRCUXRON002eGRo?=
 =?utf-8?B?Z05BTldRSlhBdCtucTR5ZVgvUit1R2Q5RmVPZE03dUpRL0NyR0tSN1doaVN1?=
 =?utf-8?B?S3M4aGhTeXB2NHZBK25DRitxUmk4ZzZNeDNvQjhqVzBpdTFSTGdqNGo0ZDlL?=
 =?utf-8?B?UW1DaUdWMzRLZmZHUFZ5RnFuMHlVOFM2WGRxMTlrSjMrWU9JVHVMSUcxS2Ir?=
 =?utf-8?B?N1daV1RqY3h5NHpYd1ZGclJPYzhyUWZRUFpNaTlSQUEvZzN0MmR0enVMTUJP?=
 =?utf-8?B?T3NiN1ZSWEVjdGNWYXJXM3MvUitOSzBTTFZnUzJ4a2kwaUdhTGpVNG95UVhN?=
 =?utf-8?B?UDlXVUZkWWZvWmxscEtRSHBYZlVNUnEzZkVhRThvVTg5ZGF0QUYxamZNZFQy?=
 =?utf-8?Q?8nTHBPByzZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHpQZUpkWE5ZdlhabVYzNk8xcmNCRm1KTzdxTHlwNllJMlRmQ0dsdUVWUllv?=
 =?utf-8?B?TjBSUElrNVE3WE8zV1krNDh5dUYyQksvMXZYNmNPbVUyWFV4ZWY3WGtyc3p4?=
 =?utf-8?B?R21VMU9JbDRMRjl0UnVjRTYwVE5KbjlyZlg1T01JSFppVFAxMlhOd1d3KzlZ?=
 =?utf-8?B?NU9TL2cwMFpOWmpVQjBGQXI5NUhPdWpPdXRCeGpMbkNEM3RTL1BUS2ZpOUlZ?=
 =?utf-8?B?QjRvMUd1THFyaVcrRWxXQXNOMEFXVExoS1RIKzJWZEQ1YW9rMmFRVXVZWHht?=
 =?utf-8?B?ekNIU1cvYm5YMHJsSTI3cXVBNU1hL1IydGYzQkhvQktSbUJoZHpsLytUTGRR?=
 =?utf-8?B?S3BGMUhaVWp3em1KOGs5YUpOckVYdjRoVWxBUlpDdUNnM2ozUGdaNmw0TGVy?=
 =?utf-8?B?d1VwNnF5WUN6VDB0bVR0YWFUcll2L2FGYUo0R2prdkZZV2dDUklncm84UWVP?=
 =?utf-8?B?ejdOOFhIL2FmTm9jM0RFdFJoZW9WR2hIWWdMR29kYkpEZTVJZjc3UFVTSUlY?=
 =?utf-8?B?T0ZLdDJ4c21xTHIvMmhVTE45TzRCc0lQVDlMRkh4KzUzeHExazEvS3BkZHdC?=
 =?utf-8?B?UE9zYTRSTVpNZGh4QXhLT3VGY1dCSVNuNkEzUENwRlNJUW9QY043Wm9NN1FE?=
 =?utf-8?B?aGgwTkx0R0h5dXRvbkRsaFpyaUQrdEYrdGY5a2VQUEhIVXEyZVRtSFo4WURI?=
 =?utf-8?B?SmlzQm45bGE2NkVESmdaWEx6OHhiMkZWYUZlT1VvL1hzSFA2VXRDLzNydTh1?=
 =?utf-8?B?VGFrRS9uTkkvVmVxd2JUcEtsb1dVL1A5YjYvRnpoZG9qdkxlVkZMWWM0UCsv?=
 =?utf-8?B?bFVTcGZjcUlFTUlhNzk0Tk9HeTh5a3ZzTlduQ0dldEpCdWl5VTR4dVFyK0pX?=
 =?utf-8?B?bDN0VVdZYjVZL0dhZ1dXOGdCb0NhYkRkSmdyU29yM0QvdDY5bDkraUN2cmhk?=
 =?utf-8?B?dnlRYlYrcW1ucHNCTUpOY3BsQ1ltU0swMW9UUk8veSt3b2E5SjlrZjZUTHZk?=
 =?utf-8?B?aXNMSjVlbTAvZ2ZtcTVMaHM5K2VlS0NvVldWYXRDc0dZNUZRVFJlTXVxeG1x?=
 =?utf-8?B?NEt3dkZmbnJrTm5OVUNhU0VTdmlxeklnMGY0THNwRGY4SWsybVhocFhzREN1?=
 =?utf-8?B?V0NPbHdLeVRKLy9IWHB5enUrVlB2S0EzRGExNmpMZkxuTFZabXhWKzN4Sk5j?=
 =?utf-8?B?cDJQTjIxS29keHNnb0lGdUF6NmF1NnMwM0g4WUlBWG1aa0lkRFMybG9VSU1k?=
 =?utf-8?B?dy9WeDZ4U2hQYlpuZ01xZUcyQ3JLcEVmSkRqbG42WnJPd01ybHVvUXJHMFM2?=
 =?utf-8?B?bEtXZExncDBCS21oeVArM1dnbG0xcTNabFBZTmh3eGFIS2lTWUFudmFBd0E4?=
 =?utf-8?B?dmtKdG5nbnRiVHBYUjNVRWt2ME02UWlzRWhaZ203VHBFKzJseDhOYzlQdTJT?=
 =?utf-8?B?UllscTh1N3lLa05sdE9BWVZtSEx1S2hYTDFCWDZzYmwzT2l1bUxVQWZROTlr?=
 =?utf-8?B?bUxsYkdKNEtMSGM4SVkveDdTZlh4blZ3dTRjdXhzcTBjcGJjRlcvMzRtaXU3?=
 =?utf-8?B?Y3dWOXgyVjVvZnlXNW1sVldaYmV5VFRnUFN3bjJjQTNHYmdKSVVxeXRzQVNU?=
 =?utf-8?B?ZUF4NVk1dW45YWR0aHdseHBMVnVoVUlFZVNtQThrdTNGemlrZkVZZ21qdzgz?=
 =?utf-8?B?N0l6WEhTR1Y5UUR6V3JKOHQyTTZDNmlydlJ4NEdUUUJjY2FZYXdRRWdZL3ZB?=
 =?utf-8?B?WXZQM1FIQnJ6cEJObE9nNlNRM0l5VUJFRGVTbTVxVndQQS9mc1FibGZSYi9t?=
 =?utf-8?B?QlJnNFNHaW5mNmVKK1ROWmZ0ZkZrMEoxUG1OV1FOMGwrdnRzNXVHeXQ4dVBa?=
 =?utf-8?B?cEwvdG9jVlVyclVld2JyeVljSHNaeEJRSTJscEtGR0dCUklvaXcvUUYrZlRS?=
 =?utf-8?B?SkMzcUprSXY4K0kwWW5pUWQ2T3Z6UnpROWNxazlsUFYvaGphd1RHQUdWbzVx?=
 =?utf-8?B?Y1B6OTc3Mk90WDVPM0Z0eXpEWXA3TE1IVkdrbkpyRnp0NGsxRTN0bEZ4T0J3?=
 =?utf-8?B?NFI2SlhDcVo2Vk9NRDhQMVdQd0dJTUt2b2xEUGkwQjVsL1VLdHVkYVZFZ1F1?=
 =?utf-8?B?VUphVHpialhOOUY3ek80V1BpWkg3NzJjYUQvclBYYlZSTjVBcWhaQkhBK1lN?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa36a48-a1ef-41c6-428f-08dd87256e08
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:54:58.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gcFkoIG1RK66iatvobEkSS/H06TP/ZPD+NGgqcL2q6ABoOXYBo1QQyPulu+lo8wH6cK0ePAT7xNmx/ykJqgWiUwELGhgT0ry4okDYdeiYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5966
X-OriginatorOrg: intel.com

On 4/29/25 13:34, Jiri Pirko wrote:
> Tue, Apr 29, 2025 at 01:17:32AM +0200, kuba@kernel.org wrote:
>> On Fri, 25 Apr 2025 14:48:07 -0700 Saeed Mahameed wrote:
>>> +	case DEVLINK_PARAM_TYPE_ARR_U32:
>>> +		len = 0;
>>> +		nla_for_each_attr_type(param_data,
>>> +				       DEVLINK_ATTR_PARAM_VALUE_DATA,
>>> +				       genlmsg_data(info->genlhdr),
>>> +				       genlmsg_len(info->genlhdr), rem) {
>>> +			if (nla_len(param_data) != sizeof(u32)) {
>>> +				NL_SET_ERR_MSG_MOD(extack,
>>> +						   "Array element size must be 4 bytes");
>>> +				return -EINVAL;
>>> +			}
>>> +			if (++len > __DEVLINK_PARAM_MAX_ARRAY_SIZE) {
>>> +				NL_SET_ERR_MSG_MOD(extack,
>>> +						   "Array size exceeds maximum");
>>> +				return -EINVAL;
>>> +			}
>>> +		}
>>> +		if (len)
>>> +			return 0;
>>> +		NL_SET_ERR_MSG_MOD(extack,
>>> +				   "Value array must have at least one entry");
>>> +		break;
>>
>> I'd really rather not build any more complexity into this funny
>> indirect attribute construct. Do you have many more arrays to expose?
> 
> How else do you imagine to expose arrays in params?
> Btw, why is it "funny"? I mean, if you would be designing it from
> scratch, how would you do that (params with multiple types) differently?
>  From netlink perspective there's nothing wrong with it, is it?
> 

I would put name, type (array of u32's), array len, then the content.

