Return-Path: <netdev+bounces-155821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3294A03ECB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D85164C0B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C301F03F5;
	Tue,  7 Jan 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOEQ1G57"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C852594A5
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251830; cv=fail; b=p8tuV2UYFux9CAevDjDzBLi9ml1NVPEjD4gjrTL43FN+nRJVaMagYrQfS27RN7FX0A83LvuDmj8BdIh/2eEtUkW+V+XAa9tr/kKplxBiye9gdusutuFppqkIp9vfWU6ZVpNBEMYeUiDBLbhx9djmFCfcTnCEzBCVJthDeCirHaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251830; c=relaxed/simple;
	bh=1tZpVbwQgVU6zEuLASc64QlRTfLuyJ/rQkeSgETdq/I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UvQuMaqvqoH6aUb6p+at4FdVm1ngkaX06FxJ4YMBkXCT9EIPAYAu599jKAkNGUpDNMVMAgsCkDizoaq0E2YpcsZIy1X9JVf45VHcl+jXyoU7e1loS59p27/II7LqDuHXzLZuhQbfqlUuYQoq9hE52RJGhblNI/YUIQHyESBoWAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOEQ1G57; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736251808; x=1767787808;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1tZpVbwQgVU6zEuLASc64QlRTfLuyJ/rQkeSgETdq/I=;
  b=WOEQ1G57YmMRGK57yDHWAiu/ls2WBaGdBBRMOUjF0shg+1PClt4+pkN3
   Va1+Q1Jvn6fBV/jf7Rdy9IXTD8HiR+pBCfqA7K2UZbvzqcGTjJhnYmTy9
   vAeAr+/jIVmjzJF6qDeRYgbQYCOkYdNufzlHmiIflr6X8GmXls+TX9CHw
   AaJZ6OdrN9N2HpxudbejfZKRs+JUj9i5JIUd+drwxofFzOvGa0hNuGgWR
   icdRgx/8bkp21/DsOjbDXaAIvmFKA7Ewu4J53U/HA11vTtkknyOu2wTbW
   GKe5f2oHwlMfKSlAbawHWZUK6NIMxQy+xozZwUUHhCIzBIw5TuQFt316F
   g==;
X-CSE-ConnectionGUID: +zIEV0kdQZ2VMD497wtxmA==
X-CSE-MsgGUID: kTVmTTRVSMejsPw4lDOl7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="40201731"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="40201731"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 04:10:00 -0800
X-CSE-ConnectionGUID: onjbSJp+TE2p8IN+E+cdnA==
X-CSE-MsgGUID: cSFq7GJySZalE8GmD8h/ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102619856"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 04:10:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 04:09:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 04:09:59 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 04:09:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgijwHmSqS25vunzo2ffG4uzcozfAo66DEMgQY8HQMmaVOcOYk4odlHxwno7qQfDeKRtnjuJLCBhcQPzxDoFwTiErfsyRmX0JkCjaxIsoXKHNemydqcf0KqVUVDNEEYmhwDVVsAWSzsfemISGF4lGGnJR8GYouUyRqHwBdzczMmgvpGgRWUgAp26C0CoCS+bwuWFLsdIwCCwpduZYzFx2Tm+ZlcQuzuaxOGCd1GTTZPSGGAJeVO3DHRXuXuzahdgTEJv1NATdTnVwPGglMPsS29pyykciJiVuUlKBpjfXKk/BaEhQwsLtmAz2aApUEr77bSt4QHo/nGHVsYVcOGM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5gWfL2JBq3pQV/yqt0/KBByDgvaIcAVcwn7TTHlbW8=;
 b=errFLj8D8VRZyydp2hjfXc7tK0UUmSUIbHYxczxENgU3uYjd6gIPooWZIbVSNE4rotx0VhExw22UmSkNLLRSMI5jHGDAPoTVSeZSWIQPMW0y8/N687Ht6rhjgnfQtHLVLo+stMysY3YOWpFga2XbjifErS9IYU6LyPH7uTGrHuLilYPjcJg1fdQlvc6pK+vIQflmY6KnIl4sLw+iMHLyeqr7Tw+6YqxR9JtgEeo+NFPzR3i7wHLKhMHS2U7C1Gue6C1B+DOdwkzL3EjGKyNrG5TeUL7kIyVumfTE5plPRsD7fAqNNRNDKcPWHocY579sZaIqf92oMMIN9Whtj/SaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH2PR11MB8836.namprd11.prod.outlook.com (2603:10b6:610:283::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 12:09:57 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 12:09:57 +0000
Message-ID: <0a115ea8-7be5-47db-9fa5-b248bccbcd38@intel.com>
Date: Tue, 7 Jan 2025 13:09:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/13] net/mlx5: fs, add HWS modify header API
 function
To: Tariq Toukan <tariqt@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
 <20250107060708.1610882-7-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250107060708.1610882-7-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH2PR11MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: ac388cfd-5e73-4b8a-663d-08dd2f143402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STVwNjFaMHdYSjZsNVd5U1hpcFlwKzBBdnIzbDl6V2E2Wk1jeVVuY3NWWDNk?=
 =?utf-8?B?NldCUEtjME9Ib0xmdTUwOFdhM1lBSFZTSWxkQ05LeXMrZE1xVjdNcE4zUXRL?=
 =?utf-8?B?UnVabHo1M2VDcmxaNmY3Rm5kaHBTN2M5OU42QzNxRXVCdndrT2FYQU1GYlJK?=
 =?utf-8?B?bTRiMHorNXltZXdldE1RNDZzb2YzdS9DcG9VUitwM1lUWWFKUS9IWENzcnF6?=
 =?utf-8?B?V01Tbk96V1loV1Q3TzYzc3N3ajZvVTZNS2p6MzNiSXVzcTduVmpIYnNKcXp3?=
 =?utf-8?B?V3NPVGJ6QlVsUXJ5RndVVWhtaC9jejkwUDFVOWsxMGxMUDZLREVUTGo0cktI?=
 =?utf-8?B?d0hDbWZPY3BWK3lNN0hBYi93SWJWU2F4ZmEweTdIczd6Vm1acDRsV3EwcktF?=
 =?utf-8?B?SnRLNjJWRVBGdGJIOC9QNjZMSDNLS1BvT1FEMzFJUFhvOEFwM0UvcU1uSCtT?=
 =?utf-8?B?eXU1ZTRhZE9iUkZEakp0cFlIaGR4Tjg1SDNBeHd5QUtaSURta0ozYXE0Um0w?=
 =?utf-8?B?TlFKbG55djg0dWo0VmJEYlJNUnlVTHhHdzVXejZ3MnZ0YkV5cVc4VjE5S09T?=
 =?utf-8?B?RFNLUkloalR6dFRxVW1zdzVnWmh1a0VmVW9ZSXBWSTU3SEFWb2lrVkwzNHFW?=
 =?utf-8?B?K1dvUVVEdGI5bmEzUy84OXhvNjNKYW1mQWNrQ0U4ODRuVkdMeHJvVE44TjdN?=
 =?utf-8?B?cU5HT1VlYS9aa1ZIVURlRytHeTdEWjJyb2JaZXZNUElRUzlJVUFHekZqUFpq?=
 =?utf-8?B?d3d2RnVtR2ZEdFNqN0R4MmlSc2RiR1BMSUxvcVloRHk1TFBmbTJyZGl0b2ly?=
 =?utf-8?B?Myt2RkZ0RjA5MG1XbjIxaDJxUTB1T0JoKytMcVVUWEFCcURPOUhOaElJZjFu?=
 =?utf-8?B?VWVtTWN6Vnc5V2VGWE5JdnZ4V1Q3ODJJTWwvdEZycnV4MEhrZlNMOWk1Z2py?=
 =?utf-8?B?dCt6RVNNNUN5RC9mMjIvMFZ6VFNvU2YrQTNTQjhDMEgvTTg1aWNxZUZVWVAz?=
 =?utf-8?B?RmpxakJFTWt1Mzc0ekZqR3pXdTY0eC9iMHlUUm54VjZyWXFNTzRTanAyY0Rh?=
 =?utf-8?B?clJYOTZBQ0xhQ2hjS21uMWd5Z0N2Q3hIdlhGa1ByV3k0ZUo3MDFFZ09QZ3h2?=
 =?utf-8?B?ZG9WSG44MEdDM2J6aC9jVGY3aXR5QmJXVERjQ043OWhBWHhFTGkyVU1pem5D?=
 =?utf-8?B?WFZzYVNjV2RZb2tRcU9MUVc3cDQveUFENkZNQm1LRW4yNGIwREpiVHJMdnBZ?=
 =?utf-8?B?c08xcVVlMTlYSEoyM2dSSVJKbmtXdG9GUnBqVTBDanV4dGdjNE5LVkpUUmVx?=
 =?utf-8?B?MEVocjNXZGRtTGVQR1RnUFFxN21ld2ZNNGlRTmRhQUVYbFU4c0lTdjNKdU9W?=
 =?utf-8?B?Zmt6MHJoUVB4TGRiM0Y3bC9Pemp1cndxazZ0ZFhEM2doRXlRYUs1T1JLMzhW?=
 =?utf-8?B?SWNUTkVoS1IvVzUxK1gxaTRUSXR1OWZDTjNpK0N0bFZseStFWGpkMnQ2dEUz?=
 =?utf-8?B?ZWNZWThJWjNGMG1uVHViZlFuUGlvWGZrT0VJeVI1ZzJiVElkYkhwYWhEVlZT?=
 =?utf-8?B?TS94MG1HRGU3TkFxR01JaU5mWlVOak12RmJyT0prN2h4d0FXbkp1WFpLL0lT?=
 =?utf-8?B?bFZPdUtpdjBlUG9zc0NHSHRBUExRcWN4ek1LRk5EZ0Q2VWxwV2NOY3J2YlFV?=
 =?utf-8?B?NFRzMk5VWDVvMCtFQU0rN1ZOSlVFeDhLK0Evc1FHN1k2ZmM3MFBocXdrMCto?=
 =?utf-8?B?L1NrcUM4anlsVGdJQ0R5cWR6UnRzY1c4RkRlV2hTSWZxVkdJVURPbllEbFdI?=
 =?utf-8?B?MytMVlNrQ0NkZjVWZlQ0TERtK2hhbkpaVTFRZU90K3l2NUROSnRtMC9Gd2kz?=
 =?utf-8?Q?Q6bkCMELcfSBj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVg0RHhUYVNsaHY3bmM3NlFTT2ZaRGdJcUNNNy8yb1VibXR3QmREM0E0YW9p?=
 =?utf-8?B?QmhTUXpOaW82UWRMclNPVU0vbUhRRDF5eFliTmc1K3NJTlFFYTFYdm5XUU9C?=
 =?utf-8?B?OVVpN2dZbTQ2MjhaUVgrSzFZbi9UVkZTclFldDc2R1N4NTJteUN4cFg1V3d0?=
 =?utf-8?B?bUoyaEZ1ZXRxUVdwZUxOcUozbkI5VmZoVVZ1Ty9YMjVQZzJ5THlxT3NJdWlM?=
 =?utf-8?B?VUEvMFc5NFFzVnRjNWIydzlLZHZJSStJNW1JRTYyM0ZNYkxoVlVlVG9kY0ZT?=
 =?utf-8?B?R2Y3djdSSHg2a1E1K1Y0R2xWVlRjc0htNk94dGFUZk1SNFVsVXg1MzNZRXpH?=
 =?utf-8?B?U090UXlkOGx0YU1jb1VHOXBHUnB5aUdaWThuZEphMUZBUFVCRUFydU1JMXVF?=
 =?utf-8?B?OWYzbVRNV0dxVGovTVEzYXBWSTNGVzNNNDFaVEtMVGF0YVZicVlkWmNTVDJa?=
 =?utf-8?B?L3Q3cEJYRjF2bCtkdlhJNllJcUlBdlAwTGdPYlBNWHhOcU52UmMvcFo3N2ZH?=
 =?utf-8?B?cjhJQ1ZUYWl4TmVmMlNtWjZ1d1I0TFNmMFpkSXNOdkdKTTU1eEVEMm5yd0V2?=
 =?utf-8?B?K2Z3M1RpZVFSclpwd2pkL1pGa2NaWkJFakk0dnNFOGptUmtQNW0ra05RVUYw?=
 =?utf-8?B?VjJYR1RCNG9VNHBXQndwQmI5MWdoYTdoa3RaUXhnTXdUV0VLRmFhdlk5UXgz?=
 =?utf-8?B?aU8zZnV6c3UzdnQ4dHZrZU52UTJwODZncHBuTmZuZHBwSEEzQ0lRZHZVYlJh?=
 =?utf-8?B?YWpOVFo1OE9rNEVKalNmQWRYQTM3NmR4eHpSMVVESmM3NTQrYWI4NWhtcFZ5?=
 =?utf-8?B?M3dhUEkwQXJOUnJsUGVaNHJTeUlSUWF1VGRPbEdQS1JDTlhTRHNxK2F5YkFK?=
 =?utf-8?B?ZURyZlpxc2M5d3lFeDlzZW1HZHBkRE1WblpGZlhHUGZuenBUUFBhdXpFQ1Fi?=
 =?utf-8?B?ZEdrUkM4bFJOZlVDUm9QakVxTnZJZW5tZnJqTWZiRGt5Mlo3QzFmUGYwcVdD?=
 =?utf-8?B?aWptOGlENzhLSlBBS1FvSjNkdGN4aXRyck8xa0dTbitlbVdqRmM5Y3Z5QlE5?=
 =?utf-8?B?VThFeVIrQXdoTEIyd3hxanU3bEVEMG0rVHFBaHZ3WmtTeHQvZk9kdk9hcDN3?=
 =?utf-8?B?cGhEWklpb1VwWU1yaytQS2tSMHFBeFN1SjNyVzJIa0l1b2FBQmVHVjNwaXRX?=
 =?utf-8?B?ZnVLUFNZWmZPbVdQVzhmNVg5M2hKQyt0ekZ1TytrcFRnTVBvMmdKV1JQWVI4?=
 =?utf-8?B?dUVGdHhlZ0xhNWJnajhORzV5a05iLzNKclczTnJjbVRWZVh3eHRlZFp4YmFz?=
 =?utf-8?B?dFZkdVlxdDV4U3JKS2FQZjZiQzN2SFEybWk5K2RtNGh5WGtqVllKN2pQajhm?=
 =?utf-8?B?cEM1allsYUJ6Q3dZbzVNRWlkaGtSRm5TK3c5MFFTUnJvR2tFSVg3NkdCZzJZ?=
 =?utf-8?B?cHV3WS9UYnp0bkQzRTRNclYzcENxakhPb1l1TUF5TnFKcjNVd3BqbWJOaGRB?=
 =?utf-8?B?N1V6YmQ4L0dsZTdrVVp6dXdzTjN2bVlmYzdjdzZrdkc4c2piME9NTlk4YkFi?=
 =?utf-8?B?V3Z1Y1VkanFxZmJEdEhRMzFZU0Fkb1RBa0xzSDdMbmRsd1F1YitCb3pycjZa?=
 =?utf-8?B?UDZSVkw3K1h4SVJEVUV1RlFnWjFsS0trbkJydWJORVIyNFNvUTlsZjgzblVz?=
 =?utf-8?B?SzJJaGdSSG5lZ3JtMk8vTFRuK3hraW84cU16WUFxYmcwbmYvOU8rYUl4M1No?=
 =?utf-8?B?ejN4U0RVQXdHOGJPNXZvMGYyVWxCYVJXVnZISVY3WVhKUHgvWnBJSUo3REww?=
 =?utf-8?B?d0xvc3RRVzJ2RkFrZUxad2g3Tzdmd0xzbEtqc1Q4d05sOEtYYVI4SS9ZU0VT?=
 =?utf-8?B?N3hGVkd1Yk9Qc2s3Y2dIZERzZHlHWWpGVzhzaGdrT0JnOG5KNTNEMzdicUlo?=
 =?utf-8?B?NllZM2ZrMnpYRXYxckVOOGZna2hCMzJsZVMzanhTVlA0cnFjWDkzS1BBT2VV?=
 =?utf-8?B?UW42amN3YWJWMWxNeGowZmRXYTd2TkRQdE9DRFYxN3ByVWtZOWltZktkSEdi?=
 =?utf-8?B?WWZHUFA3Q3J5WnRveFlRVmFEMEIvS1loMFlnZHIrUGQwdG9oUUk2YVlOUDFl?=
 =?utf-8?B?UXpqMlBYRWJIRlpvN09QbzRYSENCMlNtL0NLcmlkcnZwd1VwbGJCOHZwbDZ5?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac388cfd-5e73-4b8a-663d-08dd2f143402
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 12:09:57.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ca/iF4KYl65Z8idb+4+0vGifvi835TX0TWGxexIBkbg+2FLD8g++7XmRZ784ynOb7PGwFgHbae6zS+a2pim25WPCutVYAG6tn9heF4oG3d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8836
X-OriginatorOrg: intel.com

On 1/7/25 07:07, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Add modify header alloc and dealloc API functions to provide modify
> header actions for steering rules. Use fs hws pools to get actions from
> shared bulks of modify header actions.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/fs_core.h |   1 +
>   .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 117 +++++++++++++
>   .../mellanox/mlx5/core/steering/hws/fs_hws.h  |   2 +
>   .../mlx5/core/steering/hws/fs_hws_pools.c     | 164 ++++++++++++++++++
>   .../mlx5/core/steering/hws/fs_hws_pools.h     |  22 +++
>   5 files changed, 306 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> index 9b0575a61362..06ec48f51b6d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> @@ -65,6 +65,7 @@ struct mlx5_modify_hdr {
>   	enum mlx5_flow_resource_owner owner;
>   	union {
>   		struct mlx5_fs_dr_action fs_dr_action;
> +		struct mlx5_fs_hws_action fs_hws_action;
>   		u32 id;
>   	};
>   };
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
> index 723865140b2e..a75e5ce168c7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
> @@ -14,6 +14,8 @@ static struct mlx5hws_action *
>   create_action_remove_header_vlan(struct mlx5hws_context *ctx);
>   static void destroy_pr_pool(struct mlx5_fs_pool *pool, struct xarray *pr_pools,
>   			    unsigned long index);
> +static void destroy_mh_pool(struct mlx5_fs_pool *pool, struct xarray *mh_pools,
> +			    unsigned long index);

usual "please add your suffix" complain

sorry for mostly nitpicks, I will take deeper look later

>   
>   static int init_hws_actions_pool(struct mlx5_core_dev *dev,
>   				 struct mlx5_fs_hws_context *fs_ctx)
> @@ -56,6 +58,7 @@ static int init_hws_actions_pool(struct mlx5_core_dev *dev,
>   		goto cleanup_insert_hdr;
>   	xa_init(&hws_pool->el2tol3tnl_pools);
>   	xa_init(&hws_pool->el2tol2tnl_pools);
> +	xa_init(&hws_pool->mh_pools);
>   	return 0;
>   
>   cleanup_insert_hdr:
> @@ -81,6 +84,9 @@ static void cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
>   	struct mlx5_fs_pool *pool;
>   	unsigned long i;
>   
> +	xa_for_each(&hws_pool->mh_pools, i, pool)
> +		destroy_mh_pool(pool, &hws_pool->mh_pools, i);
> +	xa_destroy(&hws_pool->mh_pools);
>   	xa_for_each(&hws_pool->el2tol2tnl_pools, i, pool)
>   		destroy_pr_pool(pool, &hws_pool->el2tol2tnl_pools, i);
>   	xa_destroy(&hws_pool->el2tol2tnl_pools);
> @@ -528,6 +534,115 @@ static void mlx5_cmd_hws_packet_reformat_dealloc(struct mlx5_flow_root_namespace
>   	pkt_reformat->fs_hws_action.pr_data = NULL;
>   }
>   
> +static struct mlx5_fs_pool *
> +create_mh_pool(struct mlx5_core_dev *dev,

ditto prefix

[...]

> +static int mlx5_cmd_hws_modify_header_alloc(struct mlx5_flow_root_namespace *ns,
> +					    u8 namespace, u8 num_actions,
> +					    void *modify_actions,
> +					    struct mlx5_modify_hdr *modify_hdr)
> +{
> +	struct mlx5_fs_hws_actions_pool *hws_pool = &ns->fs_hws_context.hws_pool;
> +	struct mlx5hws_action_mh_pattern pattern = {};
> +	struct mlx5_fs_hws_mh *mh_data = NULL;
> +	struct mlx5hws_action *hws_action;
> +	struct mlx5_fs_pool *pool;
> +	unsigned long i, cnt = 0;
> +	bool known_pattern;
> +	int err;
> +
> +	pattern.sz = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto) * num_actions;
> +	pattern.data = modify_actions;
> +
> +	known_pattern = false;
> +	xa_for_each(&hws_pool->mh_pools, i, pool) {
> +		if (mlx5_fs_hws_mh_pool_match(pool, &pattern)) {
> +			known_pattern = true;
> +			break;
> +		}
> +		cnt++;
> +	}
> +
> +	if (!known_pattern) {
> +		pool = create_mh_pool(ns->dev, &pattern, &hws_pool->mh_pools, cnt);
> +		if (IS_ERR(pool))
> +			return PTR_ERR(pool);
> +	}

if, by any chance, .mh_pools was empty, next line has @pool
uninitialized

> +	mh_data = mlx5_fs_hws_mh_pool_acquire_mh(pool);
> +	if (IS_ERR(mh_data)) {
> +		err = PTR_ERR(mh_data);
> +		goto destroy_pool;
> +	}
> +	hws_action = mh_data->bulk->hws_action;
> +	mh_data->data = kmemdup(pattern.data, pattern.sz, GFP_KERNEL);
> +	if (!mh_data->data) {
> +		err = -ENOMEM;
> +		goto release_mh;
> +	}
> +	modify_hdr->fs_hws_action.mh_data = mh_data;
> +	modify_hdr->fs_hws_action.fs_pool = pool;
> +	modify_hdr->owner = MLX5_FLOW_RESOURCE_OWNER_SW;
> +	modify_hdr->fs_hws_action.hws_action = hws_action;
> +
> +	return 0;
> +
> +release_mh:
> +	mlx5_fs_hws_mh_pool_release_mh(pool, mh_data);
> +destroy_pool:
> +	if (!known_pattern)
> +		destroy_mh_pool(pool, &hws_pool->mh_pools, cnt);
> +	return err;
> +}

[...]

> +static struct mlx5_fs_bulk *
> +mlx5_fs_hws_mh_bulk_create(struct mlx5_core_dev *dev, void *pool_ctx)
> +{
> +	struct mlx5hws_action_mh_pattern *pattern;
> +	struct mlx5_flow_root_namespace *root_ns;
> +	struct mlx5_fs_hws_mh_bulk *mh_bulk;
> +	struct mlx5hws_context *ctx;
> +	int bulk_len;
> +	int i;

meld @i to prev line, or better declare within the for loop

> +
> +	root_ns = mlx5_get_root_namespace(dev, MLX5_FLOW_NAMESPACE_FDB);
> +	if (!root_ns || root_ns->mode != MLX5_FLOW_STEERING_MODE_HMFS)
> +		return NULL;
> +
> +	ctx = root_ns->fs_hws_context.hws_ctx;
> +	if (!ctx)
> +		return NULL;
> +
> +	if (!pool_ctx)
> +		return NULL;

you could combine the two checks above

[...]

> +bool mlx5_fs_hws_mh_pool_match(struct mlx5_fs_pool *mh_pool,
> +			       struct mlx5hws_action_mh_pattern *pattern)
> +{
> +	struct mlx5hws_action_mh_pattern *pool_pattern;
> +	int num_actions, i;
> +
> +	pool_pattern = mh_pool->pool_ctx;
> +	if (WARN_ON_ONCE(!pool_pattern))
> +		return false;
> +
> +	if (pattern->sz != pool_pattern->sz)
> +		return false;
> +	num_actions = pattern->sz / MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto);
> +	for (i = 0; i < num_actions; i++)

missing braces

> +		if ((__force __be32)pattern->data[i] !=
> +		    (__force __be32)pool_pattern->data[i])
> +			return false;
> +	return true;
> +}


