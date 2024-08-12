Return-Path: <netdev+bounces-117673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E84594EBBC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA67B229C1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286E916D9BE;
	Mon, 12 Aug 2024 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Md033HiV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE15130495
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461814; cv=fail; b=KSdK5hJ4AtRIp+ARciqZngCa+LoJyvpG4BtTvmvLIMiMlnlm92s3gzmrfh2Lc3gT7FdznTSl9g/+syQp1HO5nG/m7CCmpfi/guEzEgXhMpYjli+dI1hXP4EQzQUkVRY2zQA1Rsgp5M6L0YPuU6xPJDgfvEBYHzkBOySX/weP3wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461814; c=relaxed/simple;
	bh=k/Q31x/ew/j76pfhFi3/sR7++kP3caqnYt4qR0r3q1s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I2svSrLSS7736sgLECoFn501Xbu2+MvvpiBAqB3NeWDKjAemVlhioxyp4OxQaK9F9jjhdx+EBXjwRv+ys9TNiRjDnTYdhl+ZsBVzqVhobkrjaPxMv+OqO0f+0PyjWKh6ezh8ww6FXFrGfWCYgz6VafBR/1C3GnUFibV9iv9cl7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Md033HiV; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723461812; x=1754997812;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k/Q31x/ew/j76pfhFi3/sR7++kP3caqnYt4qR0r3q1s=;
  b=Md033HiVXDeHx0ilwACKDd9OI8WQUCjmxNIxRpa0QKbI4ZE7T80jZk2o
   Q1ozMpAJUMX5zem541BCrbL8BqRMEvx+SZfpcL2Wp+jYzt647DtIhvlSK
   jsI9mTExajNeGOYeaDbyEAl1SOYYCzQe8M9qKnfyG3SSMUlUBmNiKcD2R
   vjaX9jBMWsHwgffrw7yreDJVFV+Xj59ehIjh0joTUAW+UW+cdryTU/0tF
   C7hVGpvFzlfF94LJW2a9nYo3iQQCdhnGFYQyyO4kGuYWoSspa4JOEnFqQ
   sCy/KDlqZhJbIZdZscsdI+aCqO6zpNnAyZwPOslHMNpZd1dOYsZ1dzyud
   w==;
X-CSE-ConnectionGUID: CFqT6bpmRc2/pPyWmqJwOQ==
X-CSE-MsgGUID: dYz011oUQr2g7Wt/MQVmfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="44082900"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="44082900"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 04:23:32 -0700
X-CSE-ConnectionGUID: DQ3oBCncTgOnRxdPb3GCAg==
X-CSE-MsgGUID: KTRs5L2nR4WVxjH6txyTTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="63168731"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 04:23:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 04:23:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 04:23:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 04:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LL330495VGvpdDrAbRopAua/B6wJzTQeO7g9T+YZjXs/YczvUPzY3nvOuXRK5r2rl+VuYzF3YothCkQABgLA0MUcBv+rAc3ywD9zJYibfBntTcxzw6PJmrrKlkhEyjqDjWS0pygE/rkOnxz2r4Xh97AqcZrLdrY2z9kuxh7MaEuIBjbADR0CdCOzqD6n1dC5DJre+Zr5SUuu2uRrJnZ80uUPdnBKqsvl1RV5SG+NFa6vzXZcSbs0gNgJxOE6uGpIn0xmk4VqbwZ1SZ9pnmVo1ydYsnt0SxSm/NL9d3Pg3cYsnyHdwdI1DQf4hIodsJhVQP4gnWgrBkP06Hmz9zzsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i4rLqVrViSSSmuuqSxiyMP55uxm925lcfep9puYUN8=;
 b=JQVoDgxizCvE2gORgozUMxGSAGcBIdthkmQ2ALYhZdhHPm95lmqATPQe75absl6ubPfUpTCPwJVrhZC76y/prN9fWgTgkbs7Zg8om3iyrscXUew8DAdz5r9hnlK2kuHDyK2kKNVXLkIC7DlbmPLcmyH0Qgkm7tEwb26vmIsMkgO4LIaU3Z9kpEKjYEa6Uj26ggfej2klAGqhchuGjzR9+1A9T7GAdiPqvDHurz6pt6uphFq9aZ0GCfa6JIeKd9b68lBVzVg7xEVjjIwiSQOTQZQUHloPnp/6phqh/ga96S+oxQcJWr/LbuT41NPWrs/r/hDMBUKv1/lv51v556aw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN6PR11MB8217.namprd11.prod.outlook.com (2603:10b6:208:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Mon, 12 Aug
 2024 11:23:27 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 11:23:27 +0000
Message-ID: <31a55447-60ef-4cfb-bfd9-cc613619e29c@intel.com>
Date: Mon, 12 Aug 2024 13:23:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] mlxsw: spectrum_kvdl: combine devlink
 resource occupation getters
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
	<olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
 <20240806143307.14839-6-przemyslaw.kitszel@intel.com>
 <ZrMYfIN7cKUpYb8u@nanopsycho.orion>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <ZrMYfIN7cKUpYb8u@nanopsycho.orion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN6PR11MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8c7efc-25c5-4335-8878-08dcbac12f91
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0ZCSlRJd0JQeFJZazAxbXBZZUdKcWU0QmE1a3hickRSUmM4UWlDSEFBUzRB?=
 =?utf-8?B?KzcrVHZBdEczRzlsa3ZQVlowU1Y3SkEvSEc1K2l0U0xtaW05QVVobkNxNGQ2?=
 =?utf-8?B?WHlra2VlOUJIaWVFUWF0dllwbWhFRVdjdDBJTEhQaktDRFRJemU5ZnhPbFFS?=
 =?utf-8?B?TGhJcmZLbFJ0V29yOWxUVmNmbFB2VmxRWTRwWHhVT1hQODJuNzllSG1iSW9a?=
 =?utf-8?B?YXhVVXF4Z0NieVJqSFJXdWJVSVc3UHIvWWs4NHJMVVFidWNWMUxybHJMd09I?=
 =?utf-8?B?L2xWdVNleVlCSnlEK3BINmNXMkdLT296WW9ORjZnNCtXSnpkcTQ4RXdHVko1?=
 =?utf-8?B?MDhMYlNuelJVR09MZlJlSnBqN2VSeW00aEZrMjJVNU9ROE5IcTArdFFlUkFm?=
 =?utf-8?B?cDVPVmhuV3FJSzdpaGlWdk1kVXpwcE5GSGdRNUp0czFFdS9vbkUzVm1YcHZq?=
 =?utf-8?B?WmtqMlU5SDhXRTNBc2xzSnc0b2Jhd3VpdmZjMmEzZVEzek04andtSThMeGdk?=
 =?utf-8?B?Sk02U3dUWUhBTE04MUZwcUVlQUM2enRSSW5MM3d0cFVBaXZBbC93REhKd2Rn?=
 =?utf-8?B?RTBCbzk5bGMwVUkxU21PWklaS3J4MWJJZ1d6d0M5bUFpUFpEWXd5czdxN01F?=
 =?utf-8?B?RTM2THdqWWtMZlFSMkVlZGhPL08vUlJITGJCbG1idDFrNGhXK1NvbEhUcmpX?=
 =?utf-8?B?NFpxRWh0NmtZMnRNKzNiMURvV2J2Mit4RVVrNzZReGowT0pSLytteTNXaW9t?=
 =?utf-8?B?YXNpSXkwaE5RcjhDampONklJVGMxTUdtQ1NjUFVYRXhOQ282MmVNenE3eEw2?=
 =?utf-8?B?N2lZYXd4Sm1NdVR6RUFrZXZmT3NUaTJqTnRhVENKTmo5MHN3TER3eUNHRFk3?=
 =?utf-8?B?NUpzZlZCUUErTTlTeW4yYWpPN3kxaG5FdzdVQjk2bHFObG1CUnFRa2xvcm9J?=
 =?utf-8?B?UWd2aUN3NXJ3UzBYdks5YWlyZXZiaHVsR0svWmNGeDZhQzdwc3NKUmI3QmxX?=
 =?utf-8?B?VkN2bEI0cWFLT1NmblhEMTgwMFhSSkZCeEM5WFJ0aTYyd1g0OElJdGpML0ZM?=
 =?utf-8?B?Qnd2bTdUZjYvU0dpY1M1TGFmT2IzRWkvaHQ0QjEyQ3BnWnVxWUtBSXFxalRH?=
 =?utf-8?B?SGdnTG5xUGZPaGRyREhYd3RuWjYwanNBTXB3eUd6N0ZkbFhIUkpVRm9hWTda?=
 =?utf-8?B?cDh6RUczMlM0ZkJwTFl3L0MzSzhWendoa3FiUzkxdkJPVDZLZlFUS3lnK0N2?=
 =?utf-8?B?TWNiaDBPU0NpRjJyRERyQ2szcmR0eS95ekNsRTFEaG1QMEtLeHhSNzdWdGpT?=
 =?utf-8?B?Nmk3ZGZmMkJtbEN6ZGgyOEVqczdJUitXTjBGTkxmQzYxMk1vekh4Y0IvaUlw?=
 =?utf-8?B?Mjg5aUpQdXdqTVA3aGJMUG1ldGdqWWZCSE8xdEkwNUJSUkxKQmpVUjc1NzJ3?=
 =?utf-8?B?eThWdE43MEJPaHlpOHZaS0lqdHptYWZPSndSUE5wZi8yem9IUFZGd1EzUHFT?=
 =?utf-8?B?QW1FbGJLd0Z2RFpQbGNKS05UMDVrZDNRMVhzR3lTeTVOTzR1Y3ZFVnFtekJp?=
 =?utf-8?B?aWx6aHhVWlQxUzZjRlNyVDJzOE9wVVUzeUFCd0hYeWNhSXNTck9UTG0zaXdn?=
 =?utf-8?B?aVlOUWJidWxsZnJJWm1wTU50NWhXWGprTUhwWDFieHFwdkVHOHBxdVJlYjQ1?=
 =?utf-8?B?VFRRSnRzZ2MrRmxTREJrZU53SXBpSmNUK1V2QjQzTnhGVHVSa0taUlRLL04z?=
 =?utf-8?B?YjhudUV6UEtmdG5nL3pWRHJjWDFxelBUMUlReGpTRTdpUW4zK3l6Tm83cEh4?=
 =?utf-8?B?Z0R2aEx0bUd6cTRuMTkxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEdURlp4TGV4Q3ljWDdaT0svWWNCY3Z1bSsrcGd2T1NOdEh6R0IzbTM2VGtm?=
 =?utf-8?B?Wk04QTBlWGhwUENEK1FzZENMNkkxdzdEaFJQSzlnMUU5NEltNUJvQzBpVDFU?=
 =?utf-8?B?K0trL0M4M012eTdSMk1HTUhDSWZtbENVM1VzR2laMFExOWhGcHVuYzdIT3d3?=
 =?utf-8?B?Rml1anpKb1NrVGN5NUtZU3ZqY3Frc3cwVUlHWUNZU2dLK1V6bW5VVGV5b21D?=
 =?utf-8?B?alRVY3QrNDlVbTQrYUtwWEZqdG11OXZPK1NBMnUxZXdqQ0JCSlZNdUt4KzVs?=
 =?utf-8?B?cEdFRjNnNWtYNDhvWnRyalB1dHVTeVpWUFh2Uk10T3A1T1lwejE3SDdwSjBo?=
 =?utf-8?B?RmNwYXN2MSt4MG1xY3ZoK2xSWitBM3FNZ0t2SXI5eDljMjJhR2ZLU3lNNGQx?=
 =?utf-8?B?MXBKdXlhVW1mZlVJaCtjUUJXNktqUEtKZWFJaUltOUR0QkhFOW1lUzBOZ0hi?=
 =?utf-8?B?c05VQ3BWTlpRNlJ2NllYcGRrcU5aT0JaTFpEeWkwb2tZSzVtdjBNNDNVbmJJ?=
 =?utf-8?B?OC9iS3oydFR5OU5HV0tpN0F5amFtSGZ5WTU3YjNSZytkaDZ1WG1UNnpDNnNy?=
 =?utf-8?B?cnVlYmk4amdkZWtGRnYxSThFZ2pFQjVzdmZpWmlXSTF6WEFSOHB1NmJ4RXFQ?=
 =?utf-8?B?UnpJaG5aVU8rOE1KWEpLWlc4TmRkNVlzNzhoUHNWVVdnSUw0akdmVXF4S0gy?=
 =?utf-8?B?ZUtGR01DdDVzbE5oL1dWYlRtMzdCVGcwcUFrUVE0NWovR2g4REMydUpmR21r?=
 =?utf-8?B?U0pKL2tDZkZDRXQ1SmJzVmhrNWRvVW5tcjhXVjJIRnRHdG9WVmhhWENDVExL?=
 =?utf-8?B?dDdWN010U1NGbkVNY3NueG5qT1pZRGNVc0krRGJadGhnNGF1ZEFjaFBicjdo?=
 =?utf-8?B?eUFMYVo0WUdrZzlGaGQwTEhvaldCTVVLbmNpMjE4WGhudWdPTytUSVo2MG5U?=
 =?utf-8?B?Z3FKckNsVmZvVUlMdFVKT3F2NVcrUDlqM25ZUEd0MnhDSTJQRkNUQVMzUEt4?=
 =?utf-8?B?eVV2QW9ydUk2cnhKMEdaMTA0UXA5dFJRbit6TWd4NTZTSUlia1AzZWRTWG96?=
 =?utf-8?B?WG14VXpEaFJEOXV1MjRxSTlFSFlxTUU3QmNodDBEZ005R0pZNFBSYjBRU1ZT?=
 =?utf-8?B?Y1FPT3VYeERPNGtrdmkxYXkrdjd5V0pPY1dESGJmanZnUUIvejBmNzh1NTdn?=
 =?utf-8?B?VThhSW1DeXBONEpJUWNiSWhrVWQ1ZUlseGVncllYMnBrQzIrOUJwVHpHcFEr?=
 =?utf-8?B?OUF5VXlRU1RXTmgzOFA1QVFwMUVtSnhSdnZtT2ZzcWwxZm11b2RMRFZHd3d6?=
 =?utf-8?B?K2NjL3NJZmRFc2JaS256MldtVmhjaFJQVnFLT0NPanBrSHlGTkV0RUFyb0RB?=
 =?utf-8?B?OFRJSVkxakZjeUJONCtLQkg1elVPMXpzYU1BNGdnY2hzVHNGZEpsMWc2U01v?=
 =?utf-8?B?eDNjRFpiaHdXTm9CQUplbi9RdzdGUnZ3VHQ4UDBCcW1LK0c3emtKano4YXE0?=
 =?utf-8?B?YXVUT0NQQ3V2dDM0U0ZSZWVtSndiOUNYT2FqdHYwQmFPWHpDS0JraGhudjA5?=
 =?utf-8?B?eUMxV3lZVlRRVEh4WTVkWUo1MWxzQ25NMzFMNWIzR3FRZjNUNkh0MkJ2M3hW?=
 =?utf-8?B?aDVKaUk2VXVsTytXN05pZ2RjbzZNVitNdk5jQk5KbkxqTTZ6cnUyWTlQaGUz?=
 =?utf-8?B?clFndUVoV2UyR2Nxam9WU1dpdkMzaFNDdmJxYmdpbVp0T3NwUEFmMzQ2U1ZD?=
 =?utf-8?B?WDFjRFA1MjRxdTJsckl4SEZyenIxdVN2WVpjUjRKK05WTW1OeWM1NkZZRDB5?=
 =?utf-8?B?TlRVVm9xRDdjSWN6eWtyUnFvbExzNEZueVFXVHJOMHpoK25aT3hob2drcHZZ?=
 =?utf-8?B?WWMvRXNFZ0RBTEZFSSsxakYxMHVTTHY4Wk9QdXNuT0MvL1NibnY4V1FVT3Zi?=
 =?utf-8?B?ZW9DZTlIaGgwMTZsRXZWKzQ4TzlLTElPZjJHSC90U05mcmYybm9JWVBLYjdr?=
 =?utf-8?B?NGRUZEJFdEVub3dDcmNod21EVytqYVRLV1EycHF6dnJBMnZqajJsT1YvV2xR?=
 =?utf-8?B?Z25qSkZvWEY2cEtma1h1eUVDYkt3bGNhUzdRQkhBa2ZLS0JCdlNSWnp4ODEv?=
 =?utf-8?B?aGpBam1yb0tJYlEzQVI4elVFN0hoc1k0c2N1anE0OU9yR0o4U3Z3aTlBS0U0?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8c7efc-25c5-4335-8878-08dcbac12f91
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:23:27.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYvndoRxD1aP6IzW4B3ltHWSFYly1LH1TF9YZO7xnbqIeABTAmIOPG5Q7CdoS7B/ROZV1ggPcBifimSKmLze2eIlfNV+mXpO+d4jL0kV308=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8217
X-OriginatorOrg: intel.com

On 8/7/24 08:47, Jiri Pirko wrote:
> Tue, Aug 06, 2024 at 04:33:07PM CEST, przemyslaw.kitszel@intel.com wrote:
>> Combine spectrum1 kvdl devlink resource occupation getters into one.
>>
>> Thanks to previous commit of the series we could easily embed more than
>> just a single pointer into devlink resource.
>>
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>> .../net/ethernet/mellanox/mlxsw/spectrum.h    |  5 ++
>> .../net/ethernet/mellanox/mlxsw/spectrum.c    |  3 +-
>> .../ethernet/mellanox/mlxsw/spectrum1_kvdl.c  | 80 ++++++++-----------
>> 3 files changed, 41 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
>> index 8d3c61287696..91fe5fffa675 100644
>> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
>> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
>> @@ -836,6 +836,11 @@ int mlxsw_sp_kvdl_alloc_count_query(struct mlxsw_sp *mlxsw_sp,
>> 				    unsigned int *p_alloc_count);
>>
>> /* spectrum1_kvdl.c */
>> +struct mlxsw_sp1_kvdl_occ_ctx {
>> +	struct mlxsw_sp1_kvdl *kvdl;
>> +	int first_part_id;
>> +	bool count_all_parts;
>> +};
>> extern const struct mlxsw_sp_kvdl_ops mlxsw_sp1_kvdl_ops;
>> int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core);
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>> index 2730ae3d8fe6..3bda2b2d16f9 100644
>> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>> @@ -3669,7 +3669,8 @@ static int mlxsw_sp1_resources_kvd_register(struct mlxsw_core *mlxsw_core)
>> 				     linear_size,
>> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>> 				     MLXSW_SP_RESOURCE_KVD,
>> -				     &linear_size_params, sizeof(void *));
>> +				     &linear_size_params,
>> +				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
>> 	if (err)
>> 		return err;
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>> index ee5f12746371..a8bf052adf31 100644
>> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c
>> @@ -292,68 +292,53 @@ static u64 mlxsw_sp1_kvdl_part_occ(struct mlxsw_sp1_kvdl_part *part)
>>
>> static u64 mlxsw_sp1_kvdl_occ_get(void *priv)
>> {
>> -	const struct mlxsw_sp1_kvdl *kvdl = priv;
>> +	struct mlxsw_sp1_kvdl_occ_ctx *ctx = priv;
>> +	bool cnt_all = ctx->count_all_parts;
>> +	int beg, end;
>> 	u64 occ = 0;
>> -	int i;
>>
>> -	for (i = 0; i < MLXSW_SP1_KVDL_PARTS_INFO_LEN; i++)
>> -		occ += mlxsw_sp1_kvdl_part_occ(kvdl->parts[i]);
>> +	beg = cnt_all ? 0 : ctx->first_part_id,
>> +	end = cnt_all ? MLXSW_SP1_KVDL_PARTS_INFO_LEN : beg + 1;
>> +	for (int i = beg; i < end; i++)
>> +		occ += mlxsw_sp1_kvdl_part_occ(ctx->kvdl->parts[i]);
>>
>> 	return occ;
> 
> I don't see the benefit, this just makes code harder to read.

You mean in general or this particular function?

Anyway, a part of motivation is to avoid dumb (even if easy to read in
isolation) getters and replace it with a one that exposes the logic.
(Now you have 2+ functions that reader needs to manually compare).

Re general oddities:
sizeof(void *) stuff just follows from the main idea, and is a temporary
solution (see this patch, it removes such).

> 
> 
>> }
>>
>> -static u64 mlxsw_sp1_kvdl_single_occ_get(void *priv)
>> -{
>> -	const struct mlxsw_sp1_kvdl *kvdl = priv;
>> -	struct mlxsw_sp1_kvdl_part *part;
>> -
>> -	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_SINGLE];
>> -	return mlxsw_sp1_kvdl_part_occ(part);
>> -}
>> -
>> -static u64 mlxsw_sp1_kvdl_chunks_occ_get(void *priv)
>> -{
>> -	const struct mlxsw_sp1_kvdl *kvdl = priv;
>> -	struct mlxsw_sp1_kvdl_part *part;
>> -
>> -	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_CHUNKS];
>> -	return mlxsw_sp1_kvdl_part_occ(part);
>> -}
>> -
>> -static u64 mlxsw_sp1_kvdl_large_chunks_occ_get(void *priv)
>> -{
>> -	const struct mlxsw_sp1_kvdl *kvdl = priv;
>> -	struct mlxsw_sp1_kvdl_part *part;
>> -
>> -	part = kvdl->parts[MLXSW_SP1_KVDL_PART_ID_LARGE_CHUNKS];
>> -	return mlxsw_sp1_kvdl_part_occ(part);
>> -}
>> -
>> static int mlxsw_sp1_kvdl_init(struct mlxsw_sp *mlxsw_sp, void *priv)
>> {
>> 	struct devlink *devlink = priv_to_devlink(mlxsw_sp->core);
>> -	struct mlxsw_sp1_kvdl *kvdl = priv;
>> +	struct mlxsw_sp1_kvdl_occ_ctx ctx = { priv };
>> 	int err;
>>
>> -	err = mlxsw_sp1_kvdl_parts_init(mlxsw_sp, kvdl);
>> +	err = mlxsw_sp1_kvdl_parts_init(mlxsw_sp, ctx.kvdl);
>> 	if (err)
>> 		return err;
>> -	devl_resource_occ_get_register(devlink,
>> -				       MLXSW_SP_RESOURCE_KVD_LINEAR,
>> -				       mlxsw_sp1_kvdl_occ_get,
>> -				       &kvdl, sizeof(kvdl));
>> +
>> +	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_SINGLE;
>> 	devl_resource_occ_get_register(devlink,
>> 				       MLXSW_SP_RESOURCE_KVD_LINEAR_SINGLE,
>> -				       mlxsw_sp1_kvdl_single_occ_get,
>> -				       &kvdl, sizeof(kvdl));
>> +				       mlxsw_sp1_kvdl_occ_get,
>> +				       &ctx, sizeof(ctx));
>> +
>> +	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_CHUNKS;
>> 	devl_resource_occ_get_register(devlink,
>> 				       MLXSW_SP_RESOURCE_KVD_LINEAR_CHUNKS,
>> -				       mlxsw_sp1_kvdl_chunks_occ_get,
>> -				       &kvdl, sizeof(kvdl));
>> +				       mlxsw_sp1_kvdl_occ_get,
>> +				       &ctx, sizeof(ctx));
>> +
>> +	ctx.first_part_id = MLXSW_SP1_KVDL_PART_ID_LARGE_CHUNKS;
>> 	devl_resource_occ_get_register(devlink,
>> 				       MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS,
>> -				       mlxsw_sp1_kvdl_large_chunks_occ_get,
>> -				       &kvdl, sizeof(kvdl));
>> +				       mlxsw_sp1_kvdl_occ_get,
>> +				       &ctx, sizeof(ctx));
>> +
>> +	ctx.count_all_parts = true;
>> +	devl_resource_occ_get_register(devlink,
>> +				       MLXSW_SP_RESOURCE_KVD_LINEAR,
>> +				       mlxsw_sp1_kvdl_occ_get,
>> +				       &ctx, sizeof(ctx));
>> +
>> 	return 0;
>> }
>>
>> @@ -400,7 +385,8 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
>> 				     MLXSW_SP1_KVDL_SINGLE_SIZE,
>> 				     MLXSW_SP_RESOURCE_KVD_LINEAR_SINGLE,
>> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>> -				     &size_params, sizeof(void *));
>> +				     &size_params,
>> +				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
>> 	if (err)
>> 		return err;
>>
>> @@ -411,7 +397,8 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
>> 				     MLXSW_SP1_KVDL_CHUNKS_SIZE,
>> 				     MLXSW_SP_RESOURCE_KVD_LINEAR_CHUNKS,
>> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>> -				     &size_params, sizeof(void *));
>> +				     &size_params,
>> +				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
>> 	if (err)
>> 		return err;
>>
>> @@ -422,6 +409,7 @@ int mlxsw_sp1_kvdl_resources_register(struct mlxsw_core *mlxsw_core)
>> 				     MLXSW_SP1_KVDL_LARGE_CHUNKS_SIZE,
>> 				     MLXSW_SP_RESOURCE_KVD_LINEAR_LARGE_CHUNKS,
>> 				     MLXSW_SP_RESOURCE_KVD_LINEAR,
>> -				     &size_params, sizeof(void *));
>> +				     &size_params,
>> +				     sizeof(struct mlxsw_sp1_kvdl_occ_ctx));
>> 	return err;
>> }
>> -- 
>> 2.39.3
>>


