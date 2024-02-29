Return-Path: <netdev+bounces-76295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8D86D296
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9A51C2177B
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E257A730;
	Thu, 29 Feb 2024 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/IwIR3l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162FA160629
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232851; cv=fail; b=s/Y9zkUECkj5nE+Y6AspV3SJNGQB7hGDCQRSWX05IicBMSq6GHzEEVozgw5ATlf+jnvw/b1b4wCynm4N485vJjSfhRsqJukaeSSLVcjfJem0X2BPtVhHsi5SGOt/M2q10HuAu7UUrCt0l6rT7tyvGkIlNeQCy7yshuWzdmc+K+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232851; c=relaxed/simple;
	bh=nVilKAHG10HSzyZjcsizo4tPHjnqPuVzvNFd0pwGqgY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XBL6+aIPG0nReBxXrLWKI58rW7FYHZ0Cv+JetvK70wB7i4Dds3NUneOL7lJ9lOKXlV7psIp3pfUUj6o16VgJDi/yArmWvOuZcacCcAKqdGSag4pccA8EDgZualWRNrs2/9bT7udBfAfHZ/cW7Q5Xona8veaX3qAMtXafrKYrwOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/IwIR3l; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709232847; x=1740768847;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nVilKAHG10HSzyZjcsizo4tPHjnqPuVzvNFd0pwGqgY=;
  b=f/IwIR3liSjVdbn83OzneJE1SKByxjstj3GSNsxlym2nNhYD2gD9l3jW
   VHz9OFy0pMZZhNFYkTnaOa0KP4xa0rUtiu+ngBCyRwbhL18CoGa8aRUJm
   TUdysY8zgpa3IRv49h6HL7jk97L7+FNzmMFsdewlUhXyjBayKT2lls9/I
   iZYWB9pf1Xo37nBCsCi2sgsNOWdYzfjQilm+P3VGP+O1pFLNGrPbIspeP
   WS3kNwYFg8yQd0iNzv2eRiMtWvvA+0aOudxDhLdOZ65D7LxR3QplEqmpH
   2VomFD3IbeqP9vFbYhm+PZ6MLDfuFNbEkgXClGMnS8uuQ/jhNGUDK8iDI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="4308009"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="4308009"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:54:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7845591"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 10:54:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 10:54:04 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 10:54:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 10:54:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 10:54:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYKNdFhkLJFkklsn42Iv/LFPYV9T5DjZNwWORVuxAn0nYzJgCGJI6TgxxqvUNoGbMUV2u1y5ZKPh0Vm9g52yNb4cv1Buqs/SePY5J0M5QNKlTbKVNIsJuVqZBEXenmp380m7+HizVJ/h+UbURylbdaJVluh/jOHpb5Ab+03ggk5BxsIELQqXe6OFR5a9kJ1KIrXDUxZ4m4RSEOLmthKQK6s3K4Ot/IqQOCa2YD/KMfs9bgjaYGZU4T0fm9f5Ji0nE8bLz3R/YHVGy/eHc6rS+q8/s1JrZ7IFCUaj/oziosND9+DcSYFB617cqiJTT0HCJa/jMfBVDgmQMNTFUFoKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNR3hYjCYI+hgjy+y+aJPANBUrnduOE5CRfofFTgVGM=;
 b=nBKA3XOgW3nofQYIXbBE0H8bGwnCv6nmdrZ+f8v0oPMf7Y+1XRJZ6J0Mq/KmgO+AtiU5Q36+YVwZ1W+V9SpZRl6aRnpscnN6IGx9QgEazfbqvhGqJGCgbI++POe2SMnScsqOXw39lvc8AWsMPEqn/8TqyxVO65fLtX/ZMNXumxlDlkbYPHdWw4EjBDP/Bxen7J0hNHsuXm1k77t//06pACBTbZATCkW0Bu5HBSmv67uRQHzwwwXIkryeJBobTwDJA1Ox9kDIPztOcOeAEmkhfG8rqeQW9fdh2YcY3BfAvcf6IsxLQ9q8rrXOYQgSavsSusWWVpTjYyPTbIu4VY+p0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by LV8PR11MB8560.namprd11.prod.outlook.com (2603:10b6:408:1e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Thu, 29 Feb
 2024 18:54:01 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%5]) with mapi id 15.20.7339.024; Thu, 29 Feb 2024
 18:54:01 +0000
Message-ID: <197d5ce6-8e90-4f5a-871f-abd1ca7307ab@intel.com>
Date: Thu, 29 Feb 2024 10:53:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] netdev: add per-queue statistics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<danielj@nvidia.com>, <mst@redhat.com>, <michael.chan@broadcom.com>,
	<sdf@google.com>, <vadim.fedorenko@linux.dev>, <przemyslaw.kitszel@intel.com>
References: <20240229010221.2408413-1-kuba@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240229010221.2408413-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0257.namprd04.prod.outlook.com
 (2603:10b6:303:88::22) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|LV8PR11MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: ff018411-64e8-4bb1-c112-08dc3957cb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPrzeYkvTx6nv3cD5vUQjk30vr9KZJXnKQtO/s2+noP56V6G65lQo/ztc2flKEZhNW+znA42rhnWQd9uNSMtkMJ0uT1xhlu6JuDg95EKWHPNLrcUh4v+ues8pBnBHd8pfF4Kk5qSNIS4xMaaycQTa6Q/ve+sT8Xstzi6VWCskUXqFfsxJdGx+FIJoFSWO6oJD8uS9AsVKaScpCWMgNGmANWp7QwJsn8l7ZLCKKgwrYwALU1GMgzxVWqcYtmdFmotdO/BuAiL3cojXvxn3GEC7MkiVVzFdLcsMcwJq2bKDkMyK/wE1Uh/Xrpxxjyo3hmBrAfk+ric52S9iaWl3yhuhWLAmof0mxFRKyVFc/3xMX6TTax8YYN6avrXwXOtZAA1pJIRBmH3hSuSehFsNNmO/UwLl4rCY4w9hv4XzeqKArZpl3pSdTgCHmRO+wci657dV/UtF7/cai5HZmlxJ0Ya7QtVp4OMLjpfwW3xMSABBXgC9+H775fl3SEwqxsqKf9msG8NPJULi412MN5mOwGtPh5eFqBFt909QjvKGeEP82Iw+CpIDWNlV67wKQ67ZOYATXJaB4XYy3xgNgez1do5HrxXkUnEciJRiwAAwmo9SyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDYyZ01vSENoMWhSaWI5ck9ORnJVUS9SS3BhK0FqY3dpV2ZYWXVmUlpKZTdF?=
 =?utf-8?B?RHNuY1k0VnhsRGxZcTVjYzF2UkhIVkhMZVFJSmY4dDA3RG02REtMMStSVWZH?=
 =?utf-8?B?d0dCUlJIczY4eVBrWVdranNpZ2E3OVFlcXVoT2ZOTVBIQ0pUZ3FNcHh1MHBi?=
 =?utf-8?B?bVpMN3FXUU9YdENRVFJFWHlkZFJZWDVHWWsxK3V5ZUhFd1p3MUpHaWg0Y3lY?=
 =?utf-8?B?SXV0Q0tKSmlOOFdZM2FOdXdXekFVKzlHeEd1VVBoQjhMdGZhSGRsd0FaNnlp?=
 =?utf-8?B?RUgyVGNoRDBxOTJMTk5iQXFobVgvcDYvaStNUmsrVmo5MTdzSmpjUlhNTHJi?=
 =?utf-8?B?L1hUM1FNUU00OGxZWTJtcGpIQmpYSm1DbFJBbHNvYlVSMVdocnpiU0RIaU1j?=
 =?utf-8?B?dTQ5aHpPSFBEUEsrMW84YStXUWtPYTB6dHBFbGdNdmtad0daTXBxVVROZmpT?=
 =?utf-8?B?TTlnUjV1Z3FYTzg3NEVSanJmR0tvaTZJbGFDMWFGVGo5dWVIbi82MUFpWlc4?=
 =?utf-8?B?cWtLSHg0Z0hiL092N3gwMFJaL1pHR1JTemdLSlp6NGVoekxQRFJLamxPY2pa?=
 =?utf-8?B?WWN5MlR3Vkd1R3dlLzh5OHp2U1h4bndnM3JGOE5vSjEzSnlpUEdDUEpRY2FM?=
 =?utf-8?B?Z2lXSGJOSzIyM1MxZnlwd3JwUmxmZ1EyYnpDc1V2WHk2QVhnSTNPUkMzdnBS?=
 =?utf-8?B?SS9RTUJtT2dob1RWdFpQbWE4dnhScEhVcStqL1B2RkoxTDViVlJleGwzZU5m?=
 =?utf-8?B?VTJ5clBiUld6c2xnUXRYZmVCVkNzTW9jN1lSOWNTaFd6OEtOczhQK2huNjB0?=
 =?utf-8?B?akw3enY0RXkxZDVDVTBvODNPWmFKbFIyTFBKS0c1OWVpR05mNnB3UXhFbnEy?=
 =?utf-8?B?RHVQb3lqaSszcUxBNXJaTnROM0RwbS9oRHRoK3Z5QlFFTmlaeEJ2SVk0WFZY?=
 =?utf-8?B?bTVrd1dNeFZtQk5UcDZaajZ6Zko5T2d6ejhqMUVPLzV6ZkhKV1o2cVhHL1Z3?=
 =?utf-8?B?MDBIR0dXODBaSHFpaEI5bWNkUnNHQ2huL1FzcVVYNTNSZnkyb1RhSExWR2NW?=
 =?utf-8?B?d21QWnVCUElaMHZBZXd3T1phZ1NmaWdYREsvRDFFZzB5L0lzc2JOVDRWdW81?=
 =?utf-8?B?WEZCQysrYU12azdCT1dtd1lYeFh5dWlDdkgwTzZwTXRqZHNYN2pOSUR0SGl1?=
 =?utf-8?B?V29sVmNHR21CRUZtbFRYZUtjSGVtTnBFdmsxZDNocFRTTmRFWldqYWVzdmhL?=
 =?utf-8?B?M3M4RUR1QVdpY0x5R1BiQ2o4ZHJsWnRGZUtab1AyakZKeVhWMjZ3cHdBMVY5?=
 =?utf-8?B?UTZaMWFmcnd6RTRWMndzMHRxSEhSMmVoTE9vdjViNmFjZFdOckRENFhFU1dY?=
 =?utf-8?B?aUx2S1RyZ3VLKzdaZjZpcE0zZDRDUlpFOHNFRWpOeVcyaXFOZHBCZmxYMDdy?=
 =?utf-8?B?SkhlNFp4TGpFeER3dFJOSW1zcVppSnhXUnNjajUrS3lEVDV6d0xoUmZndmFC?=
 =?utf-8?B?dXM1a29aWTViZW04a1kyTTlyNC9NMWg2WUFuTVRlNWh0Ymg5eEd6M2VrRUxy?=
 =?utf-8?B?VGI5VzBNOE1CeTdXVnJialZIcDhkcTVVazZBazk4ZHlzcWt5UzdSL0FuVzBw?=
 =?utf-8?B?QjFlUHBaMEpOaURiS0VETVRMbUpIQmErY1V4N1R3ek1XK29jNUVLVk41ell4?=
 =?utf-8?B?ay90dWx3cEtMcHIrYmpwekZpUllydlh6a0d6QXEzeHlRVlorc3JYMFZ2WVM4?=
 =?utf-8?B?WXlWdmFqb3V0UmVmcjY0c0doNUZvOXQ3cUpZRmtGQ1RaOXd6L2djK1ZDU3Q1?=
 =?utf-8?B?QXl0VEdlUE1lVXl5SUhuNEhib1l2eWlNenF1M3N4OXJTcHVvUkxzRUM2KzNi?=
 =?utf-8?B?SFNReXdwWU9XMWxPdlNLNWZiWUpxMmY0YnpZeDk5UEU2eXNHcnIrRnk0UmQv?=
 =?utf-8?B?NlltZ2Ywem9SakIrL1RRSUdMM1RwU3MwYlBUTE55OGdHWUJtcklyNi82QWJk?=
 =?utf-8?B?a0dzWjlSU0lScDlkaTdYMXRaRW1tQ1c0QlV4K21VbUxacDVOYlZXeElERHJj?=
 =?utf-8?B?bk4vSkNscDBrMUNjc0U5eWtTaThLYnZtbTZYL0tCNDM2aEJObXRlUHAwK2U1?=
 =?utf-8?B?cDRmVVBXOURpOVZNeEZsY3dBc3lhR0dNdmNQTlFocU9GcjBjTW10ci9VVGJs?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff018411-64e8-4bb1-c112-08dc3957cb40
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:54:01.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJT/Je03L3KqqaLjkNkJmbaRvR9M23IM/Z868mcK+eCK3QyOWW2P6blNHaIJ77c5fQp/tfTUmGeM/X3cC2Kuo9oonUCfACASTtLGT9S7eR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8560
X-OriginatorOrg: intel.com

On 2/28/2024 5:02 PM, Jakub Kicinski wrote:
> Hi!
> 
> Per queue stats keep coming up, so it's about time someone laid
> the foundation. This series adds the uAPI, a handful of stats
> and a sample support for bnxt. It's not very comprehensive in
> terms of stat types or driver support. The expectation is that
> the support will grow organically. If we have the basic pieces
> in place it will be easy for reviewers to request new stats,
> or use of the API in place of ethtool -S.
> 
> See patch 3 for sample output.
> 
> v2:
>   - un-wrap short lines
>   - s/stats/qstats/
> v1: https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
>   - rename projection -> scope
>   - turn projection/scope into flags
>   - remove the "netdev" scope since it's always implied
> rfc: https://lore.kernel.org/all/20240222223629.158254-1-kuba@kernel.org/
> 

  Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>

> Jakub Kicinski (3):
>    netdev: add per-queue statistics
>    netdev: add queue stat for alloc failures
>    eth: bnxt: support per-queue statistics
> 
>   Documentation/netlink/specs/netdev.yaml   |  91 +++++++++
>   Documentation/networking/statistics.rst   |  15 ++
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c |  63 +++++++
>   include/linux/netdevice.h                 |   3 +
>   include/net/netdev_queues.h               |  56 ++++++
>   include/uapi/linux/netdev.h               |  20 ++
>   net/core/netdev-genl-gen.c                |  12 ++
>   net/core/netdev-genl-gen.h                |   2 +
>   net/core/netdev-genl.c                    | 217 ++++++++++++++++++++++
>   tools/include/uapi/linux/netdev.h         |  20 ++
>   10 files changed, 499 insertions(+)
> 

