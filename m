Return-Path: <netdev+bounces-277522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BVVKWJI2WlToAgAu9opvQ
	(envelope-from <netdev+bounces-277522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:58:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 192423DBB8A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B2F53033228
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645362BCF4C;
	Fri, 10 Apr 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7NL76do"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA11862
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847515; cv=fail; b=XQT1yLXjwGwtcjs+l3LgbBXqTdsxY5ddvOOLKAiQV2XmbvR4ZVhg7V8gSSzz1ij9qdI0XF9DSY8KfdYIKYGB/TDoRLrNeSztAdUknv3ZML31nrJTxU/VvbEuQuWT0lrnz3Ej2iby5urR7cIzVadaVFfj8Lepe2P9vuqjxg6FlvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847515; c=relaxed/simple;
	bh=5A8w+cwR4uWwAGMul6RzKzxTpCJBmYclentq2vt0N+w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TvGmyczoTvgUVqDpvBymKke/IBow0JZMK0A91Y88BtIiOg38aI8tZYyyem7S56NCzlh5+PaofBeFd5oS//uRYh8gbezyGMp+H4zrHrK1lNPVtLg2g6KlYg6MYW2FaXTrICUJh5RvTa7fU+RWki1rg94weuEuct9sxEyCD4p70wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7NL76do; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775847514; x=1807383514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5A8w+cwR4uWwAGMul6RzKzxTpCJBmYclentq2vt0N+w=;
  b=A7NL76dovCwNumQM/oHCAL5LIBmGl0Qco9iKjuyR7yO4w/AgeZRv6ZpS
   kPqbGJZ4HGDyrQu5PRVhe8hO3YTT+g3JBe0PMR2jLQ9eNiDjHIR3TISpt
   Wp4T+zoNBMb7MRQNFa34Tv8T3MNY45ak9G0r+dcIeSUAaw40A/b08xiGN
   o7DY5kTUK3gnkUSzWO89tQBspEm8DoOvsFWW5TYkybRGWY6JUPB223kLB
   mKBYg+O11HMBsLxtRUkNYxkF3HmdXPlrZ6o5V72OyymolbdZH6MK0PxUw
   Qeh7ssfuR8P+4qGKDg8VL8LSAkIXr5eh0sI9iGM27FfA0GaHWQX8nZclv
   Q==;
X-CSE-ConnectionGUID: ++k8qc52SMuCRj4urCZhqw==
X-CSE-MsgGUID: bF8ghZbkTHaq3wBZe6Ueyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="88260475"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="88260475"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:58:30 -0700
X-CSE-ConnectionGUID: wl6ZGW9IQfCHK4RCbx0JBg==
X-CSE-MsgGUID: ZJ+u1uoURqarks8YCP9jUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="234152493"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:58:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 11:58:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 11:58:29 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 11:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1/VmWAcCVglloYn+ojDCgNvjGa2AQrRAyDDlAkZ8Z9TqL+P1/caUkmGuKNTOnDywrcp+F8oSjc9nLFmL3UlHeKLQwC4W0UvvlZpHgnX7rkmb0D95nBSs/vdOrWdlIfLptr4fiLWWQKgIfIfG/MTs6pveYPf4u2g8Biy79GxM7HUkL0U4m3kI4Dhxy8MyaBWQEye1NoflUfq6T/U6mIVu9SbfZfdU0+cjE9ZbU1VgmQVGupomJG8QKVSbf7dhRI03/88AFg5tXPMRHpgFXa1UwitDMHIIdP09nN9wgtVMrhu7prcmP7kPYhyw9D12NXvjbjqMl3lo2im/qhcP+rG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFt/c4xYcwsM0JEvETk9mLKqTQneAnNW65stQCp+FwY=;
 b=Co1qHjGASjg1JTJMfFAgIuoczya2Fh4zy/7SFEs3J2/fCnt6guuiXmNk++1jEZlNkQaoZq4Xxh5+GVBRrJHSXbEwrs2sggAj2lco4OjgsqhnHFbXrO9XulhxdeTXmWMPe0EPNP1Ll2m2gKqPTW4/qMilYO3XmPBZzPOYLc08FYydxTDWBSDwFp5Gec4IkndMg5gdV8HlW0ILnhGf+ibuaUM6ahZ50PQb4p8Fovr1ZnIjFmi01HpcUyJrD5k/3qoHeAPXq0w/4uy17v6o2/2GpAUVwHUSl4XqgDa6r+1D6TkFCLGKiAGu5n/PE4V88E/7SoaVGsXIyW5d/xfL3nA/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SA1PR11MB6968.namprd11.prod.outlook.com (2603:10b6:806:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 10 Apr
 2026 18:58:27 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 18:58:27 +0000
Message-ID: <713893a9-fe42-4b74-9eb9-a4c9ac607d7c@intel.com>
Date: Fri, 10 Apr 2026 11:58:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 10/10] ice: allow setting min_tx_rate to 0 to
 resolve VF bandwidth oversubscription
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
 <20260403054029.3789616-11-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260403054029.3789616-11-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SA1PR11MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d19519c-e83d-43f6-0490-08de973325ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: chvRrI7lhqPhLvdN5ap+nyQxK3rB/XVUELYO8SmGuuSXurFVN9+cUWIIBIhE6N3yhCdQCu//6pWX3WcLONS+lrPQiCrLDQivsMUfUdiXGQ949sqqUivLj73a8zn3az+WFUQ2yMeST/RHnH2XL2j64NKok1aHOuLuWFheWm+jYmigkxiw9T4zs47AUeYl7OR/vRAel6VDzsWdNvcslmEfRHG01/nOrkccWW0OD6O5jAKjqFI2orzWWcuY561AMhqbZmxtLlU7E0Ov3FRYoR/bn1Mi7L60YWBgQUDfU9/07/8Lrd5MjbePMRy7i99YXnR6VrGIv8oYTZGOixOm79d6uD5hwPO4SZtiQw2aX8ZgstCOyck391c5dfTcmT85lwDto5gb0+G2GfzJo95nFG7pCJAyjbX8m4CRh8HAC2RLe/KZuBLCTpnP/NzEHTOBV4HRBUUDLh7soDz2YORnsNCbceDeh3pCbOidQ33CyspuVliZUYV2t9wS56eeC0B5HmPfj8fg7as4sn7PAv8JFlfIJMkOO5O00Wj6gz7sVDaVaXNHrDrGRDNh38wvmSh93j1F86WvnokPOFw0VwZGx0ZSwJq9YkXxIXgpZP/q4NHPv/XvKJ0gAZAIBqolwMuc61a068zett3w152YMfryHvPe2m9Ee8HSdd10kA3pox3VCoCCzoAtwiUwPOfqLbYR27xrQQRvLOI5PxweUJDKtEkdzREGhHKcu3+93xCBx1T63Aw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXJCNnRnV1dVc0M2NFVaZVdVa24rcjRkS1IvazdtcWhaN0dvcWx4OVZWUDJk?=
 =?utf-8?B?SVg2UTFCOGIyL29sM3JDVngxMmorZkFXaTVZLzhiZW1RUTVnZ3NmZG1Gb1JS?=
 =?utf-8?B?UWN5dUtWdkJGYklVQTFVR1JxZVI2MkFaSEsrNThqSkd5Z3JVOWI4SjNCL2Nw?=
 =?utf-8?B?OFlXdmprdmJLeWZ1Mys5VHl0djE2QTcySHA0cCtwR0FlemM4b3lsR2t1NFRx?=
 =?utf-8?B?ZHpIRTZBQ2REWG5kZWZweGVZc2lDUk5lMVJlKytyem4zTnNraDBpajhqeWxh?=
 =?utf-8?B?c09CSnhzU1JFMXkwREk0NnRFU2kxWjloQXMzbVlyL2lkZzlpdkk4dXNXT0c5?=
 =?utf-8?B?Qi82bzFQdVVNUWhHZkVQMzI2YVJPMzRodjFzeDdCcm5CeXo5ZXdyUXBCMUZq?=
 =?utf-8?B?RzhBQ2hDSG5SS28zcHBJZzNvSUlFOXdFaUxqU0NZTkNBUCtkeUpobGhYSzZK?=
 =?utf-8?B?Z0loM1FqNm1sbmJoNWFOcXpTaUFDK2JWeUl3TnVFU2d6UVdndFZIaFRCRFhQ?=
 =?utf-8?B?dC92eDlLYkJ0dHRDcWRhWExUNVdvck9YcnlQYXFQQ28vL1gvVk5rRk5GMWpU?=
 =?utf-8?B?NWFjY0U3ZnA0SWZUQkVPRWE5aXNUT1NvN1ZncjZMdThLS1IxdlhXaFdpejJM?=
 =?utf-8?B?QUJhNytXakk4TjZ5RXUwTThGbWVJSENCTVU1WCtxZmhudUpMRXFEVUVaV3VI?=
 =?utf-8?B?VWxiMk9UU0E5V1duZnNESG8zbWdvNEVFKzIxb3NOZ2VIYjRKYlNiczVzdzMv?=
 =?utf-8?B?RlRxUWdqZHBnRjZQMGlYL1BkTVlhV3JjdmV1dEkxVnBkemlDMWtkNWxkV09a?=
 =?utf-8?B?RHN0bkMyVEdOaVd2Nlh6SUVLMnd0NE9zeER6TFdKNzZpSzB2M0pjV0krdC9D?=
 =?utf-8?B?NnVna09wOWV4alBDaGJPeWlqQ3B4VFc4RUJkT1podTMvU3FlVEIyK3dua3E4?=
 =?utf-8?B?cjdieGlwUjdrVVg4KzlyOVE0UkZ6UW9VK09ZR2Z3ZnRLQTZJVFNSM0JyMHRE?=
 =?utf-8?B?ayttRktRZGduVDh6WVpQOHM0TkFBcDJTeVBXdUVHRHBkYy9ZUENZUTRZaVVj?=
 =?utf-8?B?N1F2S0ZOb1NMckJjNDdNb244MTNzK2kyWC9BRkRzODZxalIxMURmZ0FhWSt6?=
 =?utf-8?B?eG9zUjM1MUVLSjU4ZzYwMHVObXFZQ2k4bkFmNEVQM2lmUStJSnNhTkJ4L3dZ?=
 =?utf-8?B?dEVzbWZVQktNODdWYkVUR0plTG9xZ1VXS29heWlhUzlTYkllQ01ybU1LLzFw?=
 =?utf-8?B?YTd1QUNJQXZaY2pjQ3NCRDhBL3Zxa3A5SzNkcVh5cURrMEFPRE5VL1gycFIz?=
 =?utf-8?B?VW9aYWlTVUJUbGEyS3d2WnVkbFN3MWdqRGd5VENuOGRHQkwzdXpGSHZkbFl3?=
 =?utf-8?B?K1lMNHB4RHpxTE1admVzT0hPbXhrcWtNWWpaMmVKWGFteU52WG05aUs4a2FQ?=
 =?utf-8?B?RzhlQVZrM0ZWbm5WekdTYXZrSGJSWTNXaFZhWE5HbStzY09LdXdjUDBhV3o5?=
 =?utf-8?B?RTJxYlRLc0F3dXNyb05BeXpFTjgwVnQxSjFMeWZaMTBqUVE3MzlDUUNPMWpk?=
 =?utf-8?B?NTZRejZtT1U3TGgveTYwRVdBSzdiWkdBdmFhaU5TKzdLaVAwRCtkYjZOa09Y?=
 =?utf-8?B?ZCtoeW1vWHZhVkZ4S05wbXlQckliUzU2blhQZVBhcUMwZlRDNDJHaS9xaloz?=
 =?utf-8?B?Zmo4ODlHY241bjBwVWhOMk5KdTM5Zk9KYnl3UlhQNVRVZ0FidThvNDlEUXhO?=
 =?utf-8?B?VW5RLy9TdG52d1hWampna0xEeW5VQ1dSWFpYUlpYUXVHTUtkb05iVW5FZmNH?=
 =?utf-8?B?SkNUZzNHa1Y2bzFmL2twd1lZTGtJYXlzTnROYmV0c21aVDVNWlQvdVRlZFZr?=
 =?utf-8?B?SjFKdytKT3JqTWQyYUVDQWhWZTFiK3prRHlQLzlKSUpIcEQxbFQ5VmJUNW5C?=
 =?utf-8?B?enNIallrbVl0d3YxM2lHWkdvMjhxNlJuVGY4blY1QSt1V1hEdGlEQlBWZlB3?=
 =?utf-8?B?aE9zK0VtVlh6Z0E1TXJOOXB4SjlqYi9wT0Y5YWRWbzJxa1pDc1BzNklabE9s?=
 =?utf-8?B?bkViempCNFI2ampTYVNCTEs1QVBQNXJudGFHemVjd3FOL0c4Y0lIY1pRZDl5?=
 =?utf-8?B?eGVGamtXVzNRQWh6YUZyUm9YdUo0VEpZNGZjckw3TkNJNDdCMS9DcExrYlRL?=
 =?utf-8?B?N0lnSXJmWHB2NkdjSml5czBHTGx2a0ZXdCtNSkRIc1FMalIxSHFPWGtOQXVy?=
 =?utf-8?B?SjIyWDZuamlieE9VY2Exa2ZwdWVzTHF4dnVFcW9HM2NPblo0amZGUCtmQThF?=
 =?utf-8?B?bWNDZ3pWRmFkWFM5bHplSFBRS0lQU0p3QUFtVXhoTEpzVENUL25ORGdrRFow?=
 =?utf-8?Q?A0XzxA7viwWC1U2k=3D?=
X-Exchange-RoutingPolicyChecked: vNuKKFTDp49z20D4Nc//+NiNO5S8CKwMP9msygQLamoEHLx9mKV689WGivvD6G0L2DGtQcV/M0ZfcHbDy6tbt9LOZ7HCpthix+/5UdQRhZW54C9tHGjA+9KaK4sqwhUPKjpUzNTf4GOQfSolEbmNuRbDEwGbL9vOlLwZvQYlBZl+8oOThzvP0mLB1GXa95PSTo5qjzi47WeeMZPDIH1TnQEsyyIkNtAbHMOV6KPQgo6WXfPy1yS5b77Iv3exnVe0QaOf0kIKrTp9lDicMiPfwKuhAEJDWUrAhgwU1IwLvl8KOyB84KuVCwGtvH3s1LtJyN+4TCa0QhEpkW3q6dNgqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d19519c-e83d-43f6-0490-08de973325ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:58:27.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lt9WEF6wGUBbjb8gHRYUF7ArHWOb4c4yfGTkvwshs/40PtMw4Abc6A4q0STslKBTzpx8T6f4k1NWf8tSEyCrSJSpRYoX6mWX+CqeO5sRMyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6968
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277522-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 192423DBB8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/2/2026 10:40 PM, Aleksandr Loktionov wrote:
> ice_set_vf_bw() refuses to accept any min_tx_rate value when the
> total guaranteed bandwidth is already oversubscribed, even when the
> requested value is 0. This makes it impossible to recover from an
> oversubscribed state via "ip link set <pf> vf <id> min_tx_rate 0".
> 
> Allow a zero min_tx_rate to bypass the oversubscription check so
> users can always clear the guaranteed rate. Additionally print an
> informational message when the oversubscription guard fires to help
> diagnose why a non-zero request was rejected.
> 
> Fixes: 4ecc8633056b ("ice: Add support for VF rate limiting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_sriov.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 7e00e09..6e3bec7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1507,6 +1507,12 @@ ice_min_tx_rate_oversubscribed(struct ice_vf *vf, int min_tx_rate)
>   	all_vfs_min_tx_rate -= vf->min_tx_rate;
>   
>   	if (all_vfs_min_tx_rate + min_tx_rate > link_speed_mbps) {
> +		if (ice_calc_all_vfs_min_tx_rate(vf->pf) > link_speed_mbps) {

ice_calc_all_vfs_min_tx_rate() is already called above (out of this 
patch context), can we save that to an interim var and save this second 
call?

> +			dev_info(ice_pf_to_dev(vf->pf),
> +				 "The sum of min_tx_rate for all VFs is greater than the link speed\n");
> +			dev_info(ice_pf_to_dev(vf->pf),
> +				 "Set min_tx_rate to 0 on VFs to resolve oversubscription\n");

Why not 1 string/call?

Thanks,
Tony

> +		}
>   		dev_err(ice_pf_to_dev(vf->pf), "min_tx_rate of %d Mbps on VF %u would cause oversubscription of %d Mbps based on the current link speed %d Mbps\n",
>   			min_tx_rate, vf->vf_id,
>   			all_vfs_min_tx_rate + min_tx_rate - link_speed_mbps,
> @@ -1556,7 +1562,7 @@ ice_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
>   		goto out_put_vf;
>   	}
>   
> -	if (ice_min_tx_rate_oversubscribed(vf, min_tx_rate)) {
> +	if (min_tx_rate && ice_min_tx_rate_oversubscribed(vf, min_tx_rate)) {
>   		ret = -EINVAL;
>   		goto out_put_vf;
>   	}


