Return-Path: <netdev+bounces-100878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB38FC703
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040162838B2
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AEB14AD03;
	Wed,  5 Jun 2024 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7o6kWyc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616CF9D9
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577691; cv=fail; b=INo8H3XellFNejQMqksxOCQYRtFyU4oC/tDZ7Mzo/rEdf7GS7KKR8R6kAcNjPMM5PKoeeQWhF6XdlAVtBZu2je/djptzMC46Dr/HfIBT5BcmHUxz3KeY4i8ffuRKlPCI+UX6o79L/hKUrxenWZyXCXfW/fq1REbuM/IJin1bi88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577691; c=relaxed/simple;
	bh=03eKsCYBKrwkmc/Q4+bHHDCUFqA3bmr/q0RwfgxfuxQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ELSew3hgAG9GCniRJun9Kdo3LECK8juuOWGvtF/LCugaXF84YkL16S1QSFQwiKrk5y+x5uv+8KLBd49Jlxs2eppDO/kM08zt3BGJCfj0rN9bea8a7icSKdw4HRQ5k+p745bLNS9VEXlLSQAXVho+lZKgwusUUt27BVQxyhtHRX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7o6kWyc; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717577689; x=1749113689;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=03eKsCYBKrwkmc/Q4+bHHDCUFqA3bmr/q0RwfgxfuxQ=;
  b=U7o6kWycb9x+1Dhq6QSUGg9iI9We2PtLoMfAoywEmsT1hhVeGCT/N0Y2
   2ftC+sWfc9YkuVMRttfbupE2Y4wjqBPEow6TAE3a7Bu5JbbL0SXuJZYjL
   a31PZMPwzAUqtcOboE7mk0D+7c/IwAKPXOLpGCJIZbHxcQ79StzlpHoi7
   0PMmpYb0uxuauqnG71NNkZ9Ny3O4j+Nf4VMJfE1/1a5OSB8rtAutgOe9z
   sr8xR8DrKmAYeXxsG+PVuHQJwVFJnBkOzGk9j2PrTszFQfe3MZZnqEKSw
   fqdon24qC8JIvudu4aqLHo/OkI/tS72mh7dKz5eexWNgZCUNkBxr7L50O
   w==;
X-CSE-ConnectionGUID: QGliOyqpR6CT3JEyxY8uVA==
X-CSE-MsgGUID: j14usCeWQC6HkVCtOLuuTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14389186"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14389186"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 01:54:47 -0700
X-CSE-ConnectionGUID: NW4+ZAi6QsK0Gcx/aiMIWg==
X-CSE-MsgGUID: 02/JpTZTSh+xUyW5RoxlyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42480905"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 01:54:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 01:54:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 01:54:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 01:54:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfNsKwWgYqvNWy3JCx9vtXnfzlWL7qWGLmxOQu5BkfDqQgVMqybI/hI0UunQmagOl5ji9F222UQeVO8nmz+b0qm1xqf5W4ECNWYA33pAqZZZckKwUNmmFAxoceuZqXhILTypW3ftdJU+8JztkKWGTUtjmM9oxRY8ttmsoL6K+wRZK0lUjytbcQVyPG6MELFiaiTQ5l8oDhvnolf1zbsawlSKtyaEPFW22woDLvY5+QaA8JJRa4E0Zst5RiED58lCkU/So7TlT2vpD0ZqWxOKsvHTwioebHKergndq2YGaZ8zhzUCwgwDhPLmgaFM3W8uikfCFknJz1kAbzzdj1zIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4jKjwVn1eGDIZhBoAl8X6Z38YbZzTcGCQbQntD3DFc=;
 b=KsbQBR5VxwkeVMLWbyLgOEBwaItfEfXkfxdt8qOza14MjNq8Z1ETv6sA/NMHln+gSyTytDj44OVE/Joq1kCOCmfNFumMSLqNaTWRBSJWrluom5pAxZas8hT1Gyd1p+7z+iWDaUNoQp0VQ6R0SeYWJs+oCPI+IMa6hr5sXmWn56vr2dPIWldK1rBjDuaAqqo0/IVv+jJV6fdfCmp29/WCkNWJOVRTsUwVKcE38SQuPbTckPvPaepHsrBYv7DY4YovSAHHwxJYW64jpX5luL0v7g/Hg4+TkplH4ZWtZa6xLK0ZSKNxpkdBmr8LHEFrQk4nAWKFCRWa/71Hh/Ui1YN9jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 08:54:43 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:54:43 +0000
Message-ID: <03f0279a-8ed8-4068-80a7-3cdf7740c6b8@intel.com>
Date: Wed, 5 Jun 2024 10:54:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/6] net: libwx: Redesign flow when sriov is
 enabled
To: Mengyuan Lou <mengyuanlou@net-swift.com>, <netdev@vger.kernel.org>
CC: <jiawenwu@trustnetic.com>, <duanqiangwen@net-swift.com>
References: <20240604155850.51983-1-mengyuanlou@net-swift.com>
 <795D7A235C594322+20240604155850.51983-4-mengyuanlou@net-swift.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <795D7A235C594322+20240604155850.51983-4-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::8) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MN0PR11MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 952f24bb-4528-4317-43f9-08dc853d2457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVMvTVhwVGx3RDBKSWJzM0VPR2MrL3d3LzY1MWdYMmh2TlE1RGh6eWdhWTRY?=
 =?utf-8?B?bzd0WWwraXUvZ2MwOGc2V0x3UXkybDNMbVJYQU40Tk9UMlpwMytGRlArdFRm?=
 =?utf-8?B?amRuUkdnbG40SEpnTUtTQlA5RWd1OGM3aVphaStFM1AxL2hUUWdWYWVnaTVz?=
 =?utf-8?B?QkZKbE9jTEsvcEhpNE1TdERISC9Mb2tQcUFIMlhkM0NZQU5FYkxMdFJKK0Rz?=
 =?utf-8?B?bnQ1VHp4YUFjUWxOWDd3aGRTZkN0eUNFeUw5Z0tqeGMvbFhsUnlZNlNIbW1Z?=
 =?utf-8?B?Q2dxanQvOFFZcVVzZElzUVRHRXF1SjBHN3VmS3FoUkRYbjh2alN1UW1aTVFT?=
 =?utf-8?B?OHRQSmVSMXRWRDJoTHNzT1B4bzhCVUMwK2tYaVdwQUdZNUkyUzBSYXNiWnFT?=
 =?utf-8?B?NUNPczJUNU1yRGdITldFM050dDFjRWltSGM2Ukh5bDluSHNILytlUzBQeDVj?=
 =?utf-8?B?T3FpSG81RlJjRTFUN1V3MU8wZGpHeTRJYkhBbWdBdC9ySFhXRjF5bWdXQ3kr?=
 =?utf-8?B?T2p5a3JxNDhZNnVjM2Y1bnFTZ29GWEFlZGZTb2p3c09SaGVBZjJtZUVkc25i?=
 =?utf-8?B?ZWtZeC8ydHY1V3lvby9GelByZGJCc21LeUt6VERhL2NQdGZFTVo1SkhqQjhk?=
 =?utf-8?B?ZjB1VHp0eko2WGhSWG55eTdrV2MveUQwV3l1c1YrQUZnRko4OFg5QUFXNDhz?=
 =?utf-8?B?Mnl1Wi95bzlVSW5TNEh5OXljTXR6dVlBTFpkK0RZSXlQM1k4bWwrVWJQaU4x?=
 =?utf-8?B?REFSSWs4WWI4ZWsveHpGbG9LQnZJM2J5cjVISm5ZS0MraDNVby9PaW5vcy9J?=
 =?utf-8?B?bFNjYWkvUUVpL1Y1WW01aG9LT05BSlUyOGZqTVZzMmJIc3VINFNvWGw4a250?=
 =?utf-8?B?Um1CSFFSRHdvRktqTXhzdnpzVnpjaTlyVDE1TjVEZjJyWTR3QlRoWVRnakpS?=
 =?utf-8?B?ZTRFYVFtL3BBU3JwRUhSKzRpL2VZK2x6bis3RzhXU2kvQ2RwVmQvNENwdUdx?=
 =?utf-8?B?VXpFajF3VGVlOHpEZHhYVVM5K01LblJYcGE1VlZ2K2xJcnUycDRSb3d3VTNI?=
 =?utf-8?B?Y2lLYnRyWGlUdy9DY082Mkt3SFJyL1BrYlUwZnduQS9nVDJqeXBiQ3h5VmZD?=
 =?utf-8?B?MkdiNWdkSVJRK1BqbTdPenpYKzhzdExGMEs0K3ExSlk4RjQweGwrQXE1bGd2?=
 =?utf-8?B?aDFnUEhHeThGdFpsb0hVaU1aQzdhcHM5bFIzZlJobnBFTjVvRmFqT0lVVzkv?=
 =?utf-8?B?cXJweWtGWjZWSEhKVkl1Q0FqWGk3YXk1empPUzRDWU1XM1N0K09IOVRxclhV?=
 =?utf-8?B?UGFqWUtUMXRQSEVMcjJLVllVZ1BNbkhOV1F3SjBsYlZ4Z2R0a3BQM0hkcE4r?=
 =?utf-8?B?L20rL05lcnNyMnRyOUkyRk1QTVVNRmVtOWZjRWZvd1ZWUjFkczRPbFZEbEFl?=
 =?utf-8?B?aHlBb2xLVC9hcVJHa1V6UU9WcWYwaHNQVFRPWElGU1doS2FyYW01NmNlM2VX?=
 =?utf-8?B?aHpzVXl1VWEvTGZ4WUg4OUxKalRaZXgyK2NNdUlseE9FSDROUGQwYkVnV0Ru?=
 =?utf-8?B?YStnc1RKUUE5QUtwdi9FT3o1YUIvY2NWc2ttZlVBd1FLTGZTZGpCbURkZGxY?=
 =?utf-8?B?VmlqclBUeWxnbVBDdGF1ejV3KzRrWER4YnhyUGE0Z2FnUVEyaDRPNDI4MDFo?=
 =?utf-8?B?MmR2UUVsMzRXQ0UyT1BzWFc4TUN6TUVqSE43bldOemlNRTJoYm9CWlpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk1OaG9lZW9RdHFibFdLbmI3aE1DbFNjM3BFck9pZEpuOHpRMFhEWFFydjV4?=
 =?utf-8?B?WFZjdXU4MmJIMjZoc01ibGlwSll6RGIwRUIwWkhsaFRsbk5kcE4rWDZPWExX?=
 =?utf-8?B?ZkR3ZFZuSWlrdVIwMno0QStUc01hclRNU2NCa1pKdDZBMnBuNTFnS1BIQUhH?=
 =?utf-8?B?UWNuL3JwU0RWYk1RTjdBZ2NibFVEVHNSelVJU3cwQUczWFVaMHdIZi80TkdG?=
 =?utf-8?B?TUt3WCtWZmVHUDFyMzBDNlNsdVdFZ1Qxc2dhYlVJdmtNb0VEeHhUZUFFMGNq?=
 =?utf-8?B?Y2hCRHlWSlgvRU1wUGNYYkp1blk2RXpVbXpCSTY1dHU0WUZCUER5WW0xSGJK?=
 =?utf-8?B?TFlNa1hCZTJvaGtBWEptN2N5dFFzR3J6Z0J5dzlZQjNsdERwdkFVQW9UbE84?=
 =?utf-8?B?R29ubmt0MWhOL2VwWFNEK29aZkVhYTB1ckRXeE45YjJmSXFzTExpcjVvdVdr?=
 =?utf-8?B?WEJSYWNxNDhkV0J4aEw2UFVCV2F4d2hWMVB6UW56c3lhVkQzVnFMeEpvYTZp?=
 =?utf-8?B?emlnQjdaSjVOc3BmL1c2YkQzM01pMGFoV2Q3UTZsZTRrOUN1R1JLQzgyMUtD?=
 =?utf-8?B?eEdiNWljd2F5dDFMWW1UR0h6cjZTYSs5RTVuaFg5RlBoOVg4Szd3UVVWZnBQ?=
 =?utf-8?B?R2NBbVNOMDlpVHZoRDRZTVdXTzZ2ZWM1RGdGWENnQVJQQUQzL2k4RzYrVTNq?=
 =?utf-8?B?MmNsemlOazBaRHowQS96TytZYldVSTN2R2xoNGtmdXVjdlhLZCtrd0ZVZE0w?=
 =?utf-8?B?VS9mbXovNytzOXk4YVRRWC9rQm5BQ2lYenI2TXd2MTM3N1ZlamJ6RCt3NXE3?=
 =?utf-8?B?d0FLcVdYTUtocUlyQ1ZhT1FLRGdXM3A4K1diVHBRL1RncXo0eGZRQVVyUlly?=
 =?utf-8?B?T2pOMzJtOWFlSjJMTm9ILzlGUW9NL2RiZEUxNCtaY0xMVHlLWTRmbFdlNTJt?=
 =?utf-8?B?QUtBcEpUVk1yUWdGSjZLUGwzZTFqdC9zckhEVDFrR2lBLzNHNzN4NGE2cU1h?=
 =?utf-8?B?UklJa3k0bG1TS1JzS09xMEQ0WGZvY01iOUZjT251TDhmUURYclJCRFlkTU1C?=
 =?utf-8?B?Y0VKY0ZXWTIrL2J0WnJHczBTRWJySUVEYllQUzZ2bllvOVpET3k1VHlQeDlh?=
 =?utf-8?B?Sm9vTHRlNEVJeEdMd3A1NjVXQkNrdlplalpGNzQ1OFVsT3dRclhxZW9xQ2Z5?=
 =?utf-8?B?U0laT0RWMktDdzBlTUVKVmsxQWVYZWwrbmFZTmhTWFpNRmVROFR4TU5kVEFH?=
 =?utf-8?B?MlZmV2pPOGZuSWUvbDVSMmlVcFFSZWsyMXdaY1pZRyt2SFJqaGhyeHVQV1Yx?=
 =?utf-8?B?WWMxYmhqZFVEd0h1S3lSWUtDcmh0bEJsRSthNmx2Yk9UT0FCUVhOQ2RxNnhQ?=
 =?utf-8?B?TW5xV2NpSHM3ODU4K2Z1ZDB6SjRSN2doM2RVcVpMS1RKdWVlU2hFV2dySnJq?=
 =?utf-8?B?RExPd0lNekhTYytPVS9Td1BHMC9xMlUzSnJmbGhMemEzd0cySnB5TkJtK1Mx?=
 =?utf-8?B?T0xGY200REl2clZSbmRNVHkra0RJMkZ5UlJwdTF5Y0l5elJHd0duUVg5SUtl?=
 =?utf-8?B?MUVLV3pGajRuRWpLemVEOEwxVUplcU1mczAxUDFRWUp2U3JPaWg5NXlEYjFt?=
 =?utf-8?B?aXBnV2xxREpNNkVsbnI4UGtDNzA4SFJCYTRLRmMySno5U0JsQU5HKzhrWlR6?=
 =?utf-8?B?L3BQaE92bFFwRDdudFNTcFh5RGZBeFhtcWlCVzVseWovbEd5dWc4TDNlSzc2?=
 =?utf-8?B?UXF3SWRkQ1c3Mlhpd01GR3BhZ2NuRWtZOHNsQlZ5UjBjWHZTcHVBMW5FMC9m?=
 =?utf-8?B?cC8xSHo2aG1XcmtBN1JrM2JKUzZGcVlVcWNNYVBQck5FaDc4WWtBbkJwdkZj?=
 =?utf-8?B?azFEM0l1eE9CblRFUXF5eU5SZ3o2clowOXNNVmFBUi9wcUtkL2lQWE43VVM0?=
 =?utf-8?B?ZFgwRVN1UlBRc0hoUlVldlpPODFoOVc1UXZzTkNxUlZWeklHcUIrTklnNWw0?=
 =?utf-8?B?amsvMk5MNkI4bmU5V3VDREdLdWlZWGRGaUlGbzN2NmgyZVFrOElOMktNbHhI?=
 =?utf-8?B?WVQyZ2NoT0oxbFMxR0tTQ1JUcE1oUnZPRVRUOWg2Z1NrbjlXUHR2Tk1ac2JX?=
 =?utf-8?Q?h8qs9iPqqPy9FITnsDvGftJTj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 952f24bb-4528-4317-43f9-08dc853d2457
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 08:54:43.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JecTw3Q2+VqhpkrdLyqaHeeak4CVwkeUgbVS+auohQCBZZ9xUU9FDw8ukkxasZf6XaDiqrFiYfvVUL5HutUqUD2jKoC2eU8mzGrDVsnQ8/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6304
X-OriginatorOrg: intel.com



On 04.06.2024 17:57, Mengyuan Lou wrote:
> Reallocate queue and int resources when sriov is enabled.
> Redefine macro VMDQ to make it work in VT mode.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 293 ++++++++++++++++++-
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 129 +++++++-
>  drivers/net/ethernet/wangxun/libwx/wx_type.h |  37 ++-
>  3 files changed, 442 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 7c4b6881a93f..8affcb9f7dbb 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -10,6 +10,7 @@
>  
>  #include "wx_type.h"
>  #include "wx_lib.h"
> +#include "wx_sriov.h"
>  #include "wx_hw.h"
>  
>  static int wx_phy_read_reg_mdi(struct mii_bus *bus, int phy_addr, int devnum, int regnum)
> @@ -804,11 +805,28 @@ static void wx_sync_mac_table(struct wx *wx)
>  	}
>  }
>  
> +static void wx_full_sync_mac_table(struct wx *wx)
> +{
> +	int i;
> +
> +	for (i = 0; i < wx->mac.num_rar_entries; i++) {
> +		if (wx->mac_table[i].state & WX_MAC_STATE_IN_USE) {
> +			wx_set_rar(wx, i,
> +				   wx->mac_table[i].addr,
> +				   wx->mac_table[i].pools,
> +				   WX_PSR_MAC_SWC_AD_H_AV);
> +		} else {
> +			wx_clear_rar(wx, i);
> +		}
> +		wx->mac_table[i].state &= ~(WX_MAC_STATE_MODIFIED);
> +	}
> +}
> +
>  /* this function destroys the first RAR entry */
>  void wx_mac_set_default_filter(struct wx *wx, u8 *addr)
>  {
>  	memcpy(&wx->mac_table[0].addr, addr, ETH_ALEN);
> -	wx->mac_table[0].pools = 1ULL;
> +	wx->mac_table[0].pools = BIT(VMDQ_P(0));
>  	wx->mac_table[0].state = (WX_MAC_STATE_DEFAULT | WX_MAC_STATE_IN_USE);
>  	wx_set_rar(wx, 0, wx->mac_table[0].addr,
>  		   wx->mac_table[0].pools,
> @@ -1046,6 +1064,35 @@ static void wx_update_mc_addr_list(struct wx *wx, struct net_device *netdev)
>  	wx_dbg(wx, "Update mc addr list Complete\n");
>  }
>  
> +static void wx_restore_vf_multicasts(struct wx *wx)
> +{
> +	u32 i, j, vector_bit, vector_reg;
> +	struct vf_data_storage *vfinfo;
> +
> +	for (i = 0; i < wx->num_vfs; i++) {
> +		u32 vmolr = rd32(wx, WX_PSR_VM_L2CTL(i));
> +
> +		vfinfo = &wx->vfinfo[i];
> +		for (j = 0; j < vfinfo->num_vf_mc_hashes; j++) {
> +			wx->addr_ctrl.mta_in_use++;
> +			vector_reg = (vfinfo->vf_mc_hashes[j] >> 5) & GENMASK(6, 0);
> +			vector_bit = vfinfo->vf_mc_hashes[j] & GENMASK(4, 0);
> +			wr32m(wx, WX_PSR_MC_TBL(vector_reg),
> +			      BIT(vector_bit), BIT(vector_bit));
> +			/* errata 5: maintain a copy of the reg table conf */
> +			wx->mac.mta_shadow[vector_reg] |= BIT(vector_bit);
> +		}
> +		if (vfinfo->num_vf_mc_hashes)
> +			vmolr |= WX_PSR_VM_L2CTL_ROMPE;
> +		else
> +			vmolr &= ~WX_PSR_VM_L2CTL_ROMPE;
> +		wr32(wx, WX_PSR_VM_L2CTL(i), vmolr);
> +	}
> +
> +	/* Restore any VF macvlans */
> +	wx_full_sync_mac_table(wx);
> +}
> +
>  /**
>   * wx_write_mc_addr_list - write multicast addresses to MTA
>   * @netdev: network interface device structure
> @@ -1063,6 +1110,9 @@ static int wx_write_mc_addr_list(struct net_device *netdev)
>  
>  	wx_update_mc_addr_list(wx, netdev);
>  
> +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
> +		wx_restore_vf_multicasts(wx);
> +
>  	return netdev_mc_count(netdev);
>  }
>  
> @@ -1083,7 +1133,7 @@ int wx_set_mac(struct net_device *netdev, void *p)
>  	if (retval)
>  		return retval;
>  
> -	wx_del_mac_filter(wx, wx->mac.addr, 0);
> +	wx_del_mac_filter(wx, wx->mac.addr, VMDQ_P(0));
>  	eth_hw_addr_set(netdev, addr->sa_data);
>  	memcpy(wx->mac.addr, addr->sa_data, netdev->addr_len);
>  
> @@ -1178,6 +1228,10 @@ static int wx_hpbthresh(struct wx *wx)
>  	/* Calculate delay value for device */
>  	dv_id = WX_DV(link, tc);
>  
> +	/* Loopback switch introduces additional latency */
> +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
> +		dv_id += WX_B2BT(tc);
> +
>  	/* Delay value is calculated in bit times convert to KB */
>  	kb = WX_BT2KB(dv_id);
>  	rx_pba = rd32(wx, WX_RDB_PB_SZ(0)) >> WX_RDB_PB_SZ_SHIFT;
> @@ -1233,12 +1287,106 @@ static void wx_pbthresh_setup(struct wx *wx)
>  		wx->fc.low_water = 0;
>  }
>  
> +static void wx_set_ethertype_anti_spoofing(struct wx *wx, bool enable, int vf)
> +{
> +	u32 pfvfspoof, reg_offset, vf_shift;
> +
> +	vf_shift = vf % 32;
> +	reg_offset = vf / 32;
> +
> +	pfvfspoof = rd32(wx, WX_TDM_ETYPE_AS(reg_offset));
> +	if (enable)
> +		pfvfspoof |= BIT(vf_shift);
> +	else
> +		pfvfspoof &= ~BIT(vf_shift);
> +	wr32(wx, WX_TDM_ETYPE_AS(reg_offset), pfvfspoof);
> +}
> +
> +static int wx_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting)
> +{
> +	u32 index = vf / 32, vf_bit = vf % 32;
> +	struct wx *wx = netdev_priv(netdev);
> +	u32 regval;
> +
> +	if (vf >= wx->num_vfs)
> +		return -EINVAL;
> +
> +	wx->vfinfo[vf].spoofchk_enabled = setting;
> +
> +	regval = (setting << vf_bit);
> +	wr32m(wx, WX_TDM_MAC_AS(index), regval | BIT(vf_bit), regval);
> +
> +	if (wx->vfinfo[vf].vlan_count)
> +		wr32m(wx, WX_TDM_VLAN_AS(index), regval | BIT(vf_bit), regval);
> +
> +	return 0;
> +}
> +
> +static void wx_configure_virtualization(struct wx *wx)
> +{
> +	u16 pool = wx->num_rx_pools;
> +	u32 reg_offset, vf_shift;
> +	u32 i;
> +
> +	if (!test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
> +		return;
> +
> +	wr32m(wx, WX_PSR_VM_CTL,
> +	      WX_PSR_VM_CTL_POOL_MASK | WX_PSR_VM_CTL_REPLEN,
> +	      FIELD_PREP(WX_PSR_VM_CTL_POOL_MASK, VMDQ_P(0)) |
> +	      WX_PSR_VM_CTL_REPLEN);
> +	while (pool--)
> +		wr32m(wx, WX_PSR_VM_L2CTL(pool), WX_PSR_VM_L2CTL_AUPE, WX_PSR_VM_L2CTL_AUPE);
> +
> +	if (wx->mac.type == wx_mac_sp) {
> +		vf_shift = VMDQ_P(0) % 32;
> +		reg_offset = VMDQ_P(0) / 32;
> +
> +		/* Enable only the PF pools for Tx/Rx */
> +		wr32(wx, WX_RDM_VF_RE(reg_offset), GENMASK(31, vf_shift));
> +		wr32(wx, WX_RDM_VF_RE(reg_offset ^ 1), reg_offset - 1);
> +		wr32(wx, WX_TDM_VF_TE(reg_offset), GENMASK(31, vf_shift));
> +		wr32(wx, WX_TDM_VF_TE(reg_offset ^ 1), reg_offset - 1);
> +	} else {
> +		vf_shift = BIT(VMDQ_P(0));
> +		/* Enable only the PF pools for Tx/Rx */
> +		wr32(wx, WX_RDM_VF_RE(0), vf_shift);
> +		wr32(wx, WX_TDM_VF_TE(0), vf_shift);
> +	}
> +
> +	/* clear VLAN promisc flag so VFTA will be updated if necessary */
> +	clear_bit(WX_FLAG2_VLAN_PROMISC, wx->flags);
> +
> +	for (i = 0; i < wx->num_vfs; i++) {
> +		if (!wx->vfinfo[i].spoofchk_enabled)
> +			wx_set_vf_spoofchk(wx->netdev, i, false);
> +		/* enable ethertype anti spoofing if hw supports it */
> +		wx_set_ethertype_anti_spoofing(wx, true, i);
> +	}
> +}
> +
>  static void wx_configure_port(struct wx *wx)
>  {
>  	u32 value, i;
>  
> -	value = WX_CFG_PORT_CTL_D_VLAN | WX_CFG_PORT_CTL_QINQ;
> +	if (wx->mac.type == wx_mac_em) {
> +		value = (wx->num_vfs == 0) ?
> +			WX_CFG_PORT_CTL_NUM_VT_NONE :
> +			WX_CFG_PORT_CTL_NUM_VT_8;
> +	} else {
> +		if (test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags)) {
> +			if (wx->ring_feature[RING_F_RSS].indices == 4)
> +				value = WX_CFG_PORT_CTL_NUM_VT_32;
> +			else
> +				value = WX_CFG_PORT_CTL_NUM_VT_64;
> +		} else {
> +			value = 0;
> +		}
> +	}
> +
> +	value |= WX_CFG_PORT_CTL_D_VLAN | WX_CFG_PORT_CTL_QINQ;
>  	wr32m(wx, WX_CFG_PORT_CTL,
> +	      WX_CFG_PORT_CTL_NUM_VT_MASK |
>  	      WX_CFG_PORT_CTL_D_VLAN |
>  	      WX_CFG_PORT_CTL_QINQ,
>  	      value);
> @@ -1297,6 +1445,83 @@ static void wx_vlan_strip_control(struct wx *wx, bool enable)
>  	}
>  }
>  
> +static void wx_vlan_promisc_enable(struct wx *wx)
> +{
> +	u32 vlnctrl, i, vind, bits, reg_idx;
> +
> +	vlnctrl = rd32(wx, WX_PSR_VLAN_CTL);
> +	if (test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags)) {
> +		/* we need to keep the VLAN filter on in SRIOV */
> +		vlnctrl |= WX_PSR_VLAN_CTL_VFE;
> +		wr32(wx, WX_PSR_VLAN_CTL, vlnctrl);
> +	} else {
> +		vlnctrl &= ~WX_PSR_VLAN_CTL_VFE;
> +		wr32(wx, WX_PSR_VLAN_CTL, vlnctrl);
> +		return;
> +	}
> +	/* We are already in VLAN promisc, nothing to do */
> +	if (test_bit(WX_FLAG2_VLAN_PROMISC, wx->flags))
> +		return;
> +	/* Set flag so we don't redo unnecessary work */
> +	set_bit(WX_FLAG2_VLAN_PROMISC, wx->flags);
> +	/* Add PF to all active pools */
> +	for (i = WX_PSR_VLAN_SWC_ENTRIES; --i;) {
> +		wr32(wx, WX_PSR_VLAN_SWC_IDX, i);
> +		reg_idx = VMDQ_P(0) / 32;
> +		vind = VMDQ_P(0) % 32;
> +		bits = rd32(wx, WX_PSR_VLAN_SWC_VM(reg_idx));
> +		bits |= BIT(vind);
> +		wr32(wx, WX_PSR_VLAN_SWC_VM(reg_idx), bits);
> +	}
> +	/* Set all bits in the VLAN filter table array */
> +	for (i = 0; i < wx->mac.vft_size; i++)
> +		wr32(wx, WX_PSR_VLAN_TBL(i), U32_MAX);
> +}
> +
> +static void wx_scrub_vfta(struct wx *wx)
> +{
> +	u32 i, vid, bits, vfta, vind, vlvf, reg_idx;
> +
> +	for (i = WX_PSR_VLAN_SWC_ENTRIES; --i;) {
> +		wr32(wx, WX_PSR_VLAN_SWC_IDX, i);
> +		vlvf = rd32(wx, WX_PSR_VLAN_SWC_IDX);
> +		/* pull VLAN ID from VLVF */
> +		vid = vlvf & ~WX_PSR_VLAN_SWC_VIEN;
> +		if (vlvf & WX_PSR_VLAN_SWC_VIEN) {
> +			/* if PF is part of this then continue */
> +			if (test_bit(vid, wx->active_vlans))
> +				continue;
> +		}
> +		/* remove PF from the pool */
> +		reg_idx = VMDQ_P(0) / 32;
> +		vind = VMDQ_P(0) % 32;
> +		bits = rd32(wx, WX_PSR_VLAN_SWC_VM(reg_idx));
> +		bits &= ~BIT(vind);
> +		wr32(wx, WX_PSR_VLAN_SWC_VM(reg_idx), bits);
> +	}
> +	/* extract values from vft_shadow and write back to VFTA */
> +	for (i = 0; i < wx->mac.vft_size; i++) {
> +		vfta = wx->mac.vft_shadow[i];
> +		wr32(wx, WX_PSR_VLAN_TBL(i), vfta);
> +	}
> +}
> +
> +static void wx_vlan_promisc_disable(struct wx *wx)
> +{
> +	u32 vlnctrl;
> +
> +	/* configure vlan filtering */
> +	vlnctrl = rd32(wx, WX_PSR_VLAN_CTL);
> +	vlnctrl |= WX_PSR_VLAN_CTL_VFE;
> +	wr32(wx, WX_PSR_VLAN_CTL, vlnctrl);
> +	/* We are not in VLAN promisc, nothing to do */
> +	if (!test_bit(WX_FLAG2_VLAN_PROMISC, wx->flags))
> +		return;
> +	/* Set flag so we don't redo unnecessary work */
> +	clear_bit(WX_FLAG2_VLAN_PROMISC, wx->flags);
> +	wx_scrub_vfta(wx);
> +}
> +
>  void wx_set_rx_mode(struct net_device *netdev)
>  {
>  	struct wx *wx = netdev_priv(netdev);
> @@ -1309,7 +1534,7 @@ void wx_set_rx_mode(struct net_device *netdev)
>  	/* Check for Promiscuous and All Multicast modes */
>  	fctrl = rd32(wx, WX_PSR_CTL);
>  	fctrl &= ~(WX_PSR_CTL_UPE | WX_PSR_CTL_MPE);
> -	vmolr = rd32(wx, WX_PSR_VM_L2CTL(0));
> +	vmolr = rd32(wx, WX_PSR_VM_L2CTL(VMDQ_P(0)));
>  	vmolr &= ~(WX_PSR_VM_L2CTL_UPE |
>  		   WX_PSR_VM_L2CTL_MPE |
>  		   WX_PSR_VM_L2CTL_ROPE |
> @@ -1330,7 +1555,10 @@ void wx_set_rx_mode(struct net_device *netdev)
>  		fctrl |= WX_PSR_CTL_UPE | WX_PSR_CTL_MPE;
>  		/* pf don't want packets routing to vf, so clear UPE */
>  		vmolr |= WX_PSR_VM_L2CTL_MPE;
> -		vlnctrl &= ~WX_PSR_VLAN_CTL_VFE;
> +		if (test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags) &&
> +		    test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
> +			vlnctrl |= WX_PSR_VLAN_CTL_VFE;
> +		features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
>  	}
>  
>  	if (netdev->flags & IFF_ALLMULTI) {
> @@ -1353,7 +1581,7 @@ void wx_set_rx_mode(struct net_device *netdev)
>  	 * sufficient space to store all the addresses then enable
>  	 * unicast promiscuous mode
>  	 */
> -	count = wx_write_uc_addr_list(netdev, 0);
> +	count = wx_write_uc_addr_list(netdev, VMDQ_P(0));
>  	if (count < 0) {
>  		vmolr &= ~WX_PSR_VM_L2CTL_ROPE;
>  		vmolr |= WX_PSR_VM_L2CTL_UPE;
> @@ -1371,7 +1599,7 @@ void wx_set_rx_mode(struct net_device *netdev)
>  
>  	wr32(wx, WX_PSR_VLAN_CTL, vlnctrl);
>  	wr32(wx, WX_PSR_CTL, fctrl);
> -	wr32(wx, WX_PSR_VM_L2CTL(0), vmolr);
> +	wr32(wx, WX_PSR_VM_L2CTL(VMDQ_P(0)), vmolr);
>  
>  	if ((features & NETIF_F_HW_VLAN_CTAG_RX) &&
>  	    (features & NETIF_F_HW_VLAN_STAG_RX))
> @@ -1379,6 +1607,10 @@ void wx_set_rx_mode(struct net_device *netdev)
>  	else
>  		wx_vlan_strip_control(wx, false);
>  
> +	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +		wx_vlan_promisc_disable(wx);
> +	else
> +		wx_vlan_promisc_enable(wx);
>  }
>  EXPORT_SYMBOL(wx_set_rx_mode);
>  
> @@ -1621,6 +1853,13 @@ static void wx_setup_reta(struct wx *wx)
>  	u32 random_key_size = WX_RSS_KEY_SIZE / 4;
>  	u32 i, j;
>  
> +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags)) {
> +		if (wx->mac.type == wx_mac_sp)
> +			rss_i = rss_i < 4 ? 4 : rss_i;
> +		else if (wx->mac.type == wx_mac_em)
> +			rss_i = 1;
> +	}
> +
>  	/* Fill out hash function seeds */
>  	for (i = 0; i < random_key_size; i++)
>  		wr32(wx, WX_RDB_RSSRK(i), wx->rss_key[i]);
> @@ -1638,10 +1877,40 @@ static void wx_setup_reta(struct wx *wx)
>  	wx_store_reta(wx);
>  }
>  
> +static void wx_setup_psrtype(struct wx *wx)
> +{
> +	int rss_i = wx->ring_feature[RING_F_RSS].indices;
> +	u32 psrtype;
> +	int pool;
> +
> +	psrtype = WX_RDB_PL_CFG_L4HDR |
> +		  WX_RDB_PL_CFG_L3HDR |
> +		  WX_RDB_PL_CFG_L2HDR |
> +		  WX_RDB_PL_CFG_TUN_OUTL2HDR |
> +		  WX_RDB_PL_CFG_TUN_TUNHDR;
> +
> +	if (wx->mac.type == wx_mac_sp) {
> +		if (rss_i > 3)
> +			psrtype |= FIELD_PREP(GENMASK(31, 29), 2);
> +		else if (rss_i > 1)
> +			psrtype |= FIELD_PREP(GENMASK(31, 29), 1);
> +
> +		for_each_set_bit(pool, &wx->fwd_bitmask, 32)
> +			wr32(wx, WX_RDB_PL_CFG(VMDQ_P(pool)), psrtype);
> +	} else {
> +		for_each_set_bit(pool, &wx->fwd_bitmask, 8)
> +			wr32(wx, WX_RDB_PL_CFG(VMDQ_P(pool)), psrtype);
> +	}
> +}
> +
>  static void wx_setup_mrqc(struct wx *wx)
>  {
>  	u32 rss_field = 0;
>  
> +	/* VT, and RSS do not coexist at the same time */
> +	if (test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags))
> +		return;
> +
>  	/* Disable indicating checksum in descriptor, enables RSS hash */
>  	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_PCSD, WX_PSR_CTL_PCSD);
>  
> @@ -1671,16 +1940,11 @@ static void wx_setup_mrqc(struct wx *wx)
>   **/
>  void wx_configure_rx(struct wx *wx)
>  {
> -	u32 psrtype, i;
>  	int ret;
> +	u32 i;
>  
>  	wx_disable_rx(wx);
> -
> -	psrtype = WX_RDB_PL_CFG_L4HDR |
> -		  WX_RDB_PL_CFG_L3HDR |
> -		  WX_RDB_PL_CFG_L2HDR |
> -		  WX_RDB_PL_CFG_TUN_TUNHDR;
> -	wr32(wx, WX_RDB_PL_CFG(0), psrtype);
> +	wx_setup_psrtype(wx);
>  
>  	/* enable hw crc stripping */
>  	wr32m(wx, WX_RSC_CTL, WX_RSC_CTL_CRC_STRIP, WX_RSC_CTL_CRC_STRIP);
> @@ -1728,6 +1992,7 @@ void wx_configure(struct wx *wx)
>  {
>  	wx_set_rxpba(wx);
>  	wx_pbthresh_setup(wx);
> +	wx_configure_virtualization(wx);
>  	wx_configure_port(wx);
>  
>  	wx_set_rx_mode(wx->netdev);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 68bde91b67a0..8e4c0e24a4a3 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1558,6 +1558,65 @@ void wx_napi_disable_all(struct wx *wx)
>  }
>  EXPORT_SYMBOL(wx_napi_disable_all);
>  
> +static bool wx_set_vmdq_queues(struct wx *wx)
> +{
> +	u16 vmdq_i = wx->ring_feature[RING_F_VMDQ].limit;
> +	u16 rss_i = wx->ring_feature[RING_F_RSS].limit;
> +	u16 rss_m = WX_RSS_DISABLED_MASK;
> +	u16 vmdq_m = 0;
> +
> +	/* only proceed if VMDq is enabled */
> +	if (!test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags))
> +		return false;
> +	/* Add starting offset to total pool count */
> +	vmdq_i += wx->ring_feature[RING_F_VMDQ].offset;
> +
> +	if (wx->mac.type == wx_mac_sp) {
> +		/* double check we are limited to maximum pools */
> +		vmdq_i = min_t(u16, 64, vmdq_i);
> +
> +		/* 64 pool mode with 2 queues per pool, or
> +		 * 16/32/64 pool mode with 1 queue per pool
> +		 */
> +		if (vmdq_i > 32 || rss_i < 4) {
> +			vmdq_m = WX_VMDQ_2Q_MASK;
> +			rss_m = WX_RSS_2Q_MASK;
> +			rss_i = min_t(u16, rss_i, 2);
> +		/* 32 pool mode with 4 queues per pool */
> +		} else {
> +			vmdq_m = WX_VMDQ_4Q_MASK;
> +			rss_m = WX_RSS_4Q_MASK;
> +			rss_i = 4;
> +		}
> +	} else {
> +		/* double check we are limited to maximum pools */
> +		vmdq_i = min_t(u16, 8, vmdq_i);
> +
> +		/* when VMDQ on, disable RSS */
> +		rss_i = 1;
> +	}
> +
> +	/* remove the starting offset from the pool count */
> +	vmdq_i -= wx->ring_feature[RING_F_VMDQ].offset;
> +
> +	/* save features for later use */
> +	wx->ring_feature[RING_F_VMDQ].indices = vmdq_i;
> +	wx->ring_feature[RING_F_VMDQ].mask = vmdq_m;
> +
> +	/* limit RSS based on user input and save for later use */
> +	wx->ring_feature[RING_F_RSS].indices = rss_i;
> +	wx->ring_feature[RING_F_RSS].mask = rss_m;
> +
> +	wx->queues_per_pool = rss_i;/*maybe same to num_rx_queues_per_pool*/
> +	wx->num_rx_pools = vmdq_i;
> +	wx->num_rx_queues_per_pool = rss_i;
> +
> +	wx->num_rx_queues = vmdq_i * rss_i;
> +	wx->num_tx_queues = vmdq_i * rss_i;
> +
> +	return true;
> +}
> +
>  /**
>   * wx_set_rss_queues: Allocate queues for RSS
>   * @wx: board private structure to initialize
> @@ -1574,6 +1633,11 @@ static void wx_set_rss_queues(struct wx *wx)
>  	f = &wx->ring_feature[RING_F_RSS];
>  	f->indices = f->limit;
>  
> +	if (wx->mac.type == wx_mac_sp)
> +		f->mask = WX_RSS_64Q_MASK;
> +	else
> +		f->mask = WX_RSS_8Q_MASK;
> +
>  	wx->num_rx_queues = f->limit;
>  	wx->num_tx_queues = f->limit;
>  }
> @@ -1585,6 +1649,9 @@ static void wx_set_num_queues(struct wx *wx)
>  	wx->num_tx_queues = 1;
>  	wx->queues_per_pool = 1;
>  
> +	if (wx_set_vmdq_queues(wx))
> +		return;
> +
>  	wx_set_rss_queues(wx);
>  }
>  
> @@ -1665,6 +1732,10 @@ static int wx_set_interrupt_capability(struct wx *wx)
>  	if (ret == 0 || (ret == -ENOMEM))
>  		return ret;
>  
> +	/* Disable VMDq support */
> +	dev_warn(&wx->pdev->dev, "Disabling VMQQ support\n");
> +	clear_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
> +
>  	/* Disable RSS */
>  	dev_warn(&wx->pdev->dev, "Disabling RSS support\n");
>  	wx->ring_feature[RING_F_RSS].limit = 1;
> @@ -1690,6 +1761,49 @@ static int wx_set_interrupt_capability(struct wx *wx)
>  	return 0;
>  }
>  
> +static bool wx_cache_ring_vmdq(struct wx *wx)
> +{
> +	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
> +	struct wx_ring_feature *rss = &wx->ring_feature[RING_F_RSS];
> +	u16 reg_idx;
> +	int i;
> +
> +	/* only proceed if VMDq is enabled */
> +	if (!test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags))
> +		return false;
> +
> +	if (wx->mac.type == wx_mac_sp) {
> +		/* start at VMDq register offset for SR-IOV enabled setups */
> +		reg_idx = vmdq->offset * __ALIGN_MASK(1, ~vmdq->mask);
> +		for (i = 0; i < wx->num_rx_queues; i++, reg_idx++) {
> +			/* If we are greater than indices move to next pool */
> +			if ((reg_idx & ~vmdq->mask) >= rss->indices)
> +				reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
> +			wx->rx_ring[i]->reg_idx = reg_idx;
> +		}
> +		reg_idx = vmdq->offset * __ALIGN_MASK(1, ~vmdq->mask);
> +		for (i = 0; i < wx->num_tx_queues; i++, reg_idx++) {
> +			/* If we are greater than indices move to next pool */
> +			if ((reg_idx & rss->mask) >= rss->indices)
> +				reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
> +			wx->tx_ring[i]->reg_idx = reg_idx;
> +		}
> +	} else {
> +		/* start at VMDq register offset for SR-IOV enabled setups */
> +		reg_idx = vmdq->offset;
> +		for (i = 0; i < wx->num_rx_queues; i++)
> +			/* If we are greater than indices move to next pool */
> +			wx->rx_ring[i]->reg_idx = reg_idx + i;
> +
> +		reg_idx = vmdq->offset;
> +		for (i = 0; i < wx->num_tx_queues; i++)
> +			/* If we are greater than indices move to next pool */
> +			wx->tx_ring[i]->reg_idx = reg_idx + i;
> +	}
> +
> +	return true;
> +}
> +
>  /**
>   * wx_cache_ring_rss - Descriptor ring to register mapping for RSS
>   * @wx: board private structure to initialize
> @@ -1701,6 +1815,9 @@ static void wx_cache_ring_rss(struct wx *wx)
>  {
>  	u16 i;
>  
> +	if (wx_cache_ring_vmdq(wx))
> +		return;
> +
>  	for (i = 0; i < wx->num_rx_queues; i++)
>  		wx->rx_ring[i]->reg_idx = i;
>  
> @@ -2089,7 +2206,8 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
>  		wr32(wx, WX_PX_MISC_IVAR, ivar);
>  	} else {
>  		/* tx or rx causes */
> -		msix_vector += 1; /* offset for queue vectors */
> +		if (!(wx->mac.type == wx_mac_em && wx->num_vfs == 7))
> +			msix_vector += 1; /* offset for queue vectors */
>  		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
>  		index = ((16 * (queue & 1)) + (8 * direction));
>  		ivar = rd32(wx, WX_PX_IVAR(queue >> 1));
> @@ -2134,10 +2252,17 @@ void wx_configure_vectors(struct wx *wx)
>  {
>  	struct pci_dev *pdev = wx->pdev;
>  	u32 eitrsel = 0;
> -	u16 v_idx;
> +	u16 v_idx, i;
>  
>  	if (pdev->msix_enabled) {
>  		/* Populate MSIX to EITR Select */
> +		if (wx->mac.type == wx_mac_sp) {
> +			if (wx->num_vfs >= 32)
> +				eitrsel = BIT(wx->num_vfs % 32) - 1;
> +		} else if (wx->mac.type == wx_mac_em) {
> +			for (i = 0; i < wx->num_vfs; i++)
> +				eitrsel |= BIT(i);
> +		}
>  		wr32(wx, WX_PX_ITRSEL, eitrsel);
>  		/* use EIAM to auto-mask when MSI-X interrupt is asserted
>  		 * this saves a register write for every interrupt
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 7dad022e01e9..126416534181 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -19,6 +19,7 @@
>  #define WX_PCIE_MSIX_TBL_SZ_MASK                0x7FF
>  #define WX_PCI_LINK_STATUS                      0xB2
>  #define WX_MAX_PF_MACVLANS                      15
> +#define WX_MAX_VF_MC_ENTRIES                    30
>  
>  /**************** Global Registers ****************************/
>  /* chip control Registers */
> @@ -75,6 +76,7 @@
>  #define WX_MAC_LXONOFFRXC            0x11E0C
>  
>  /*********************** Receive DMA registers **************************/
> +#define WX_RDM_VF_RE(_i)             (0x12004 + ((_i) * 4))
>  #define WX_RDM_DRP_PKT               0x12500
>  #define WX_RDM_PKT_CNT               0x12504
>  #define WX_RDM_BYTE_CNT_LSB          0x12508
> @@ -89,6 +91,7 @@
>  #define WX_CFG_TAG_TPID(_i)          (0x14430 + ((_i) * 4))
>  #define WX_CFG_PORT_CTL_NUM_VT_MASK  GENMASK(13, 12) /* number of TVs */
>  
> +#define WX_CFG_PORT_CTL_NUM_VT_NONE  0
>  #define WX_CFG_PORT_CTL_NUM_VT_8     FIELD_PREP(GENMASK(13, 12), 1)
>  #define WX_CFG_PORT_CTL_NUM_VT_32    FIELD_PREP(GENMASK(13, 12), 2)
>  #define WX_CFG_PORT_CTL_NUM_VT_64    FIELD_PREP(GENMASK(13, 12), 3)
> @@ -114,6 +117,10 @@
>  /*********************** Transmit DMA registers **************************/
>  /* transmit global control */
>  #define WX_TDM_CTL                   0x18000
> +#define WX_TDM_VF_TE(_i)             (0x18004 + ((_i) * 4))
> +#define WX_TDM_MAC_AS(_i)            (0x18060 + ((_i) * 4))
> +#define WX_TDM_VLAN_AS(_i)           (0x18070 + ((_i) * 4))
> +
>  /* TDM CTL BIT */
>  #define WX_TDM_CTL_TE                BIT(0) /* Transmit Enable */
>  #define WX_TDM_PB_THRE(_i)           (0x18020 + ((_i) * 4))
> @@ -186,6 +193,7 @@
>  /* mcasst/ucast overflow tbl */
>  #define WX_PSR_MC_TBL(_i)            (0x15200  + ((_i) * 4))
>  #define WX_PSR_UC_TBL(_i)            (0x15400 + ((_i) * 4))
> +#define WX_PSR_VM_CTL_REPLEN         BIT(30) /* replication enabled */
>  #define WX_PSR_VM_CTL_POOL_MASK      GENMASK(12, 7)
>  
>  /* VM L2 contorl */
> @@ -230,6 +238,7 @@
>  #define WX_PSR_VLAN_SWC              0x16220
>  #define WX_PSR_VLAN_SWC_VM_L         0x16224
>  #define WX_PSR_VLAN_SWC_VM_H         0x16228
> +#define WX_PSR_VLAN_SWC_VM(_i)       (0x16224 + ((_i) * 4))
>  #define WX_PSR_VLAN_SWC_IDX          0x16230         /* 64 vlan entries */
>  /* VLAN pool filtering masks */
>  #define WX_PSR_VLAN_SWC_VIEN         BIT(31)  /* filter is valid */
> @@ -244,6 +253,10 @@
>  #define WX_RSC_ST                    0x17004
>  #define WX_RSC_ST_RSEC_RDY           BIT(0)
>  
> +/*********************** Transmit DMA registers **************************/
> +/* transmit global control */
> +#define WX_TDM_ETYPE_AS(_i)          (0x18058 + ((_i) * 4))
> +
>  /****************************** TDB ******************************************/
>  #define WX_TDB_PB_SZ(_i)             (0x1CC00 + ((_i) * 4))
>  #define WX_TXPKT_SIZE_MAX            0xA /* Max Tx Packet size */
> @@ -371,6 +384,15 @@ enum WX_MSCA_CMD_value {
>  /* Number of 80 microseconds we wait for PCI Express master disable */
>  #define WX_PCI_MASTER_DISABLE_TIMEOUT        80000
>  
> +#define WX_RSS_64Q_MASK              0x3F
> +#define WX_RSS_8Q_MASK               0x7
> +#define WX_RSS_4Q_MASK               0x3
> +#define WX_RSS_2Q_MASK               0x1
> +#define WX_RSS_DISABLED_MASK         0x0
> +
> +#define WX_VMDQ_4Q_MASK              0x7C
> +#define WX_VMDQ_2Q_MASK              0x7E
> +
>  /****************** Manageablility Host Interface defines ********************/
>  #define WX_HI_MAX_BLOCK_BYTE_LENGTH  256 /* Num of bytes in range */
>  #define WX_HI_COMMAND_TIMEOUT        1000 /* Process HI command limit */
> @@ -435,7 +457,12 @@ enum WX_MSCA_CMD_value {
>  #define WX_REQ_TX_DESCRIPTOR_MULTIPLE   8
>  
>  #define WX_MAX_JUMBO_FRAME_SIZE      9432 /* max payload 9414 */
> -#define VMDQ_P(p)                    p
> +/* must account for pools assigned to VFs. */
> +#ifdef CONFIG_PCI_IOV
> +#define VMDQ_P(p)       ((p) + wx->ring_feature[RING_F_VMDQ].offset)
> +#else
> +#define VMDQ_P(p)       (p)
> +#endif
>  
>  /* Supported Rx Buffer Sizes */
>  #define WX_RXBUFFER_256      256    /* Used for skb receive header */
> @@ -1005,6 +1032,10 @@ struct vf_data_storage {
>  	bool link_enable;
>  	bool trusted;
>  	int xcast_mode;
> +
> +	u16 vf_mc_hashes[WX_MAX_VF_MC_ENTRIES];
> +	u16 num_vf_mc_hashes;
> +	u16 vlan_count;
>  };
>  
>  struct vf_macvlans {
> @@ -1017,6 +1048,7 @@ struct vf_macvlans {
>  
>  enum wx_pf_flags {
>  	WX_FLAG_VMDQ_ENABLED,
> +	WX_FLAG2_VLAN_PROMISC,
>  	WX_FLAG_SRIOV_ENABLED,
>  	WX_PF_FLAGS_NBITS		/* must be last */
>  };
> @@ -1085,6 +1117,8 @@ struct wx {
>  	struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
>  	struct wx_ring *rx_ring[64];
>  	struct wx_q_vector *q_vector[64];
> +	int num_rx_pools; /* does not include pools assigned to VFs */
> +	int num_rx_queues_per_pool;
>  
>  	unsigned int queues_per_pool;
>  	struct msix_entry *msix_q_entries;
> @@ -1118,6 +1152,7 @@ struct wx {
>  	struct vf_data_storage *vfinfo;
>  	struct vf_macvlans vf_mvs;
>  	struct vf_macvlans *mv_list;
> +	unsigned long fwd_bitmask; /* bitmask indicating in use pools */
>  
>  	int (*setup_tc)(struct net_device *netdev, u8 tc);
>  	void (*do_reset)(struct net_device *netdev);

