Return-Path: <netdev+bounces-132869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110D49939E8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3571F21E3F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11A018C921;
	Mon,  7 Oct 2024 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ti5NcMNd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4718A6DC
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339189; cv=fail; b=pYBxgiHWdiMJcUBZrBfpgrsyAy8Ii1CVPRnjcjtnQaL+m79ZGyYaExoCAiA2ptOJDF+9dN4tU1fEeDHzlckErU/MENcfVRJj5IsEkViT/Ijp62TPtbJc8A2VegH7unNt/OYvCC7XfRlnQjJyv+aMC/yOkkJemaYYLdOSC8GOYbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339189; c=relaxed/simple;
	bh=KcC1oYDkRf+ourB2jcyJ/vFqL8074ZeayHwk0tdqgyQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mtKYu/4xRra90jzx58U3i7XBBO7eBWp4kAf8XLKUI6uye+4Msy4PG4aaVUO4bisDxDYJ7p5NXO7rgy5NmcqeK97QlpfQWRZRyvmlQtgREcvcNzfugJWT+QBHRTyzzOUUv3q6BqaInMk/VUYZeYwn+/11tYxLlKVVMbJbWU/u1xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ti5NcMNd; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728339185; x=1759875185;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KcC1oYDkRf+ourB2jcyJ/vFqL8074ZeayHwk0tdqgyQ=;
  b=Ti5NcMNdu0SMOpqkRmhKvJZtaqtC6TWwvisyhdgehHMemLcYZc+22V38
   1xvLA1l4tqw6ZyaAbCH52kS4ZZRMw2xGODgeUNpL0F49FmvxOYRSfldf0
   vXXv6LI2WahQJb1XMysqvHHslGqCl6kK/KPhe9ydbyeHrH7uQqLRP1ZwC
   dXZkGuCBqhpBz/LM3sdLHMbUdeeyNEcSuiKvZTFngFKXd6+XMelT1xLE8
   6gXzhYYpYvHnWNprspkYKqBJ/TkhsLDCXQUc3dRe9p5zGBRpsZ80elDT4
   sTIuvmGkyU2EXUGcZc+4z6QfLWvmacNkhw9/4DD376NZqQw2E8x2upRYc
   g==;
X-CSE-ConnectionGUID: jWzCSiA2Q2aswKoB9937OA==
X-CSE-MsgGUID: gGVscWr2RtGRxMCqbdOoLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38897892"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="38897892"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 15:13:05 -0700
X-CSE-ConnectionGUID: hFr68IGVQ2amS5vZYg/R+g==
X-CSE-MsgGUID: ai7K366DSn25GlMZGhzd1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75615869"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 15:13:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 15:13:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 15:13:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 15:13:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 15:13:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgRNFFNW+yuvUQxJvebn7dkFZimpZ70Bd2W/13MBco7cieBrXp1FH2Masi+229DD7T0oA3ZVqsIGclrrtC8aEu7JOmxrKhIH5apEOwEXVIDXVVM/8f8hwB/JOhcLy/hwuXYH4JH6vPnP86GgYy1HeBkoYub3fEGumRnO4fxbQdMcq5QmEUSyQ4lgn7ikd+VwJlmxHK6k+0gda5TkYoG3hjpXMcC4lV5vaBTP1I6gRrzPUThWgeYXEdTcGr87DKL90748moJIikQaiup8W4VIY0Zmz+nVQ7MW/KDmok5lMUYrhE6H1jGjG4PDZ5vD8xE4ZDvdIq3d6cxjhdvJ+a21Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx1d9alC2L7NJHFHDm7Lxq5J2FFZV2w650MKm1BF66I=;
 b=H1Dap2861bma97fsqAEriX0XJgBsavAD0JEMeHP8BwKYAAkEfrrOVDP7SEIAFToFIcASgYctc5gvp+5TYUwajLLxBRcJE4ilRdcxHCyPVFEDbcD/MTcpumi2Z3Q8qA/fwT9QACIAedYZ83KB+RvO4du1dUsnBYce6pwr9OvRXy3caB/+Pk5IIzzWkLUmmn+j9WHIWkHsHRlMPsKB4L/YKh8/AKanr4CXDaGErYvehMDzDIgkr7Y2xOlwHrkZOPK/drwGI3LMrX6czr7GU6NemQm95LBgD4PCe0FSNopV16bcJMPi25pgvvKK+MAv+/VmwwCp7ikko4WOBAYPa9PHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 22:13:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 22:13:00 +0000
Message-ID: <6e25afe6-cab3-4a0e-97e5-b82e9e97a8ab@intel.com>
Date: Mon, 7 Oct 2024 15:12:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
To: Michal Kubecek <mkubecek@suse.cz>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>, "Mogilappagari, Sudheer"
	<sudheer.mogilappagari@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240913224858.foaciiwpxudljyxn@skbuf>
 <IA1PR11MB62661EF398124FC523CC3C03E4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <45327ee6-e57c-4fec-bf43-86bd1338f5fb@intel.com>
 <20241003091810.2zbbvod4jqq246lq@skbuf>
 <dcdnyuvjksvebfgcavogszlcoro3gwinzc6fzfjjtijadyg3km@7spc2j4v2ci6>
 <20241003134916.q6m7i3qkancqjnvr@skbuf>
 <tctt7svco2xfmp7qr2rrgrpx6kzyvlaia2lxfqlunrdlgjny3h@77gxzrjooolu>
 <CO1PR11MB5089C7F00BCDDCBB678AF260D6722@CO1PR11MB5089.namprd11.prod.outlook.com>
 <lxkqtnik6q6xjpjhgmy4kwbbsgtxwa7mszz7gcv3i2aafhkx4n@tdudjcsuxg7z>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <lxkqtnik6q6xjpjhgmy4kwbbsgtxwa7mszz7gcv3i2aafhkx4n@tdudjcsuxg7z>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fc4917-0d03-4bc4-fbd2-08dce71d34b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHozandsSHBTY2Y1VlpOeHBqTGtVSWVZSHpGWVZoVnJvY3dzYzdIVHkrWnZ5?=
 =?utf-8?B?aU1ZM1JGeTZsVUVZZVVGcWZHVWN0cGowSVZBMGtNUkJGYUpyN0hqNDh6YjRL?=
 =?utf-8?B?dDBLSHVheXlRVzQ4cHI5QjZtTUdyK2lGTWh6UGF2MXM4bnA3ZWZ3MzgvUU5I?=
 =?utf-8?B?Z1JRRlA2T3UvODdoVlFUcnp4YU5zNlRKL21qRFg2WXVXOE5ibS9wKzVlbFY1?=
 =?utf-8?B?TDI5YTNqQ0I5YzkzN29SbzhXU0o0d1laemc2OGYrUFhLRHNZdVU0Y0RMWkdH?=
 =?utf-8?B?V2tUYkd6cVFnQjExV0ZhMUw5Q0kvNEI4SkoyTGM4Y1BqOGs4cXJwY0xoRCta?=
 =?utf-8?B?WEs5S0VvcEhSbG81ZHVRblZWTnEzVVdjNDUzSXh5WDFlTW5HN3E4WC9pS08y?=
 =?utf-8?B?WW1oaTlndm9mTUZOM0V2T1pDTEtxcHgrSmludTZqY3hJdGJyS1JjcTNFSnp6?=
 =?utf-8?B?ZWlaMGZGTE9TUWpPM0h2L21sWlo0MmNkY3g1NzJQOXhTUlN1TFJWbE5JcEov?=
 =?utf-8?B?Uk1UVDEzSU5uS1FaVWNvUVhFYXNSVXFSNnBUeDZ1WlZwUVd4cTZpaUJWNDR3?=
 =?utf-8?B?TGxlR1pob201YWtqdlNsY1c3aWJ6QmE4RlBJVmZVR1JSU2FidkFkdmtaaE9G?=
 =?utf-8?B?SU16Q3VncTlLRDNTV25GUWdrSGhGNWdaaU4vYUllejJ6WDRTSmJhTWhqaU90?=
 =?utf-8?B?aExOSEU3akFINWl5SE5DQ2p4YnFsRGY3eU1SRnNWemJLUjZxSHhwaGljZHhq?=
 =?utf-8?B?cGc5THZmS0k1Y2pFdWhlYndIQVVrdnQ4V1NHOWNkckhrYTYyQlBMdVEraHM1?=
 =?utf-8?B?d1JvdWlrVUtqdjZ6b1E2VUZHYyt5QTBtQ2dyZFh5WElZMVRtYWNBRDNwdHk4?=
 =?utf-8?B?NmRCMnUzVjJsbU0rSjU0d1FrdG91QURldWFSQVhrcENmbWpYN0lyR2FDUnBS?=
 =?utf-8?B?S3lmbUkzZHd3NGJOZUJ2cVJxSzVmaHMyRFBQdU5ZK0VWWGhNQzV3ZUpDaCtI?=
 =?utf-8?B?MG5Jc3RBR2NlTkpWdWtnNkdOMldaMTFhVE41dmUxTmJGY05ZUmR3bXFORnhJ?=
 =?utf-8?B?TnkvcFg2RVFDZzEzMFhMb2RwaGpsc2pySkZnRE93QitId1lHdnc3Qk1TNUZs?=
 =?utf-8?B?ZzFzcjE0eFBVY1ptM0I5bVlIZmtHdGVxNjA1dncrNmNxbmdHMjZGQWQ0Wjht?=
 =?utf-8?B?NWQzYjcyYTBXMXFqTThjcW51bUNBMkJrcXlYN01DN2g1ald4QXV4aFJ4TnlY?=
 =?utf-8?B?c0NzdXhHa3JLUk5HR3pLaEJseW1STnJlRTVtaWVLMEhUeWFVRWhJL25WRjZa?=
 =?utf-8?B?emdQREZRSHI2NWVuakJsckZoWVkyWWw5UjI4Nk1Oc0E2K0l6Z0p0WFVnb1hJ?=
 =?utf-8?B?TVc1dmFaN2dUMjBtQTN4dis5QW9pajdRbjF4TmFHY3ppWlZoTFNlYkV2TFZN?=
 =?utf-8?B?UnIrNi9wOVVsa2lVWjQzM2lGZkhIdTJJaXRkTnZ4MXFQWExYK016OVVxK0V0?=
 =?utf-8?B?SlZqZFNLTGYxNlUwR1JSd0FrMjBUOWY2emUrZVRDSHAvWVMrYWpBOWk4UHFr?=
 =?utf-8?B?eDJsSXlZMzVJNWNHYVpsQmZzS3FEc3E3KzR6eTNkZWg4U0p6aTFBeTZaVjg5?=
 =?utf-8?B?TjNTU1F6MXZHUUc2cVFQYm83L0dhUGhnVjU2T3V1cThxdEdFNmp5c2d5SHFL?=
 =?utf-8?B?OHB1QzRzcWtRVEtxdzZTRDl1cE1JblZGZ1N5STNRUWxJYTJPR1JJeWZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEVBY3hnQ2I1NHRyeURIdGJMOG96dWhESTcza05iUzRndXMrT09tdytIQm5a?=
 =?utf-8?B?dWJFcU1LUHozK0lTb1R0eU5XL3RxTGNOTllwNDVzUmJGcmp3WUFLckdXV3d1?=
 =?utf-8?B?OGp4YTBXa0xJbmYrby9rcjBrK1NCdlUxUVZCakpTMGxlb0xpaWU5SEMrL0xP?=
 =?utf-8?B?bWN5NURrVjd6V05haW5zVjNQbnRRNXRrbVRzUldLekFqekRyZjVtNVI3T242?=
 =?utf-8?B?a1pXemtaZjBlRFh6cDltSzhJUzRxa2VLVUV3Nk5rTHg0T2ZXeUtNUzZwYWIw?=
 =?utf-8?B?ZWRjMWt4THZQZ0c0QitpNVM0aDlkczlnek1iZDFaZ1hxakp4aXBXamdQUHJt?=
 =?utf-8?B?ZDE3ZTNJcEU2K002eEM5eE1GK1hXcThjT00xckh3aXExMTdOc28wamlySUF3?=
 =?utf-8?B?WVVkRmlwa0RQQnNTaTFmV0lRMjYxK21mS0xpUXlUOWZpM29sQVl0V0NBdjN1?=
 =?utf-8?B?YmFPSEh0NHBjNDUveUVxYWJ2ajYrc2V4cW91aE40UG1qZzl2U0IwYWh4eHBQ?=
 =?utf-8?B?L0F5TUwzTmVMOUpqUXIzZDR5YWlFVkRsQitZY1BjNHprcUFrcDRZMWdIQThT?=
 =?utf-8?B?ZEVIYm16UHA3RlhMSEdIUjlvbjdiWWVBblV2NDBsZWJ1eCs2WURnY0RlWnJi?=
 =?utf-8?B?M0pUamo0SmdQVk1iaDJZNVZxTndGOVpST29VRTJJcUZwR2FoMnI2SGxCVmhx?=
 =?utf-8?B?a1ZNSlppS0VYSkhuaDRRSnNBcjhaQmUrZm9kcXN4OGFiV1lGWUpmZUo0Qk1L?=
 =?utf-8?B?T1hOYWtEWWdoa1lCbDlNUXVsMzNJbzM3Y0x3V0xveVA2M1dGWGNqdHhvaVhD?=
 =?utf-8?B?VnhsMzY5Ri9CRWlOZDVUZHRHVXFsVlZDOWdyWFJ1c1ZnUWh5YkV6NU41d3FC?=
 =?utf-8?B?elZuLzFUaFRrU01XWHZZU1BaS20zNmRLckp0VU4xUjVxcHBLeG5LaXhzdkxr?=
 =?utf-8?B?Z1dCNm40R01Lc0h6Sk1mMm41OWorR2NMbVh0TTVxTWVVMnRkZGpqZlRMTlBx?=
 =?utf-8?B?cG04N1pobnhTcWtMZTNCejBDb3JGK0UwaDdCQkxpQjlXT1czalhYeFV6Tm5K?=
 =?utf-8?B?a2NFaG0wYlN2a0ZacmdPTmtZQ1VnVWJQOWNXc2NvSHNtTVJwSWgzTDhxNXZm?=
 =?utf-8?B?L2ZmRWlrOGV5cGtRcUVTOWVFOThUQUI1ME9BSHZsYmJhdHRuVFVQaU5qSWQx?=
 =?utf-8?B?QjQzTmd4Q1hjVWhwRXNiRzRrSnE5K3cyM1VxNWw1SXdxYVAvWnYvV2lzNW9n?=
 =?utf-8?B?bm8vZ2pKcU1RSVorZzVWcm95SWRGRHQzZTJvWFRWRFhqc21lTHd0R1hkMW9h?=
 =?utf-8?B?b0V3OXRPdUtRN1pRY1QzMWJIUUIvSUFpY1hEbDRuc05USk9laG1VY2x5am13?=
 =?utf-8?B?djdWTW1oa3duU2Q2UzRoT2QyTTVacGUyOVgwbWkyQk1qQlI5azc1Vmw3OVIx?=
 =?utf-8?B?M2ZmZDBwL1V1YU9LczBZOXdWQ3RnQVkwSG9PTndGNGdyTWUxdDNHV3FFSU4v?=
 =?utf-8?B?Z0JKWWI2eTJ2cXBncm9ZcDNVTkpCLzUvQkhvSlR4V0sycWNodTNkNy9XQ2xX?=
 =?utf-8?B?dE9iY3VtTUFnZURZQzFJZXdwSlNFbWkwaHJYc3ZZRGd5QlM4NzNROGl5MWRL?=
 =?utf-8?B?ejFmTXovNFEvd0JyYVN6ZTBCcXM1eUVMbDM0d0hETjVVa2ZwYjdReFBBMDZi?=
 =?utf-8?B?M2pHVzJNZ0NxMG9pQ0JpUmpnRzczTUREVUN3b092U0FtdmlwaVdSYWdVYmdV?=
 =?utf-8?B?cm1qUVlUN3BxVjVRZXpSblBKQ0NzRG1CQVdRT2Q2ZEtSSmNwY1Z2NHlVM1FI?=
 =?utf-8?B?NUZGUlFFL2UvMVFPQnRUUEpja2dVM2d5V25kaXJodVVDOTRiTmEwVzFWcXhI?=
 =?utf-8?B?VWJob1R3K01YV0lLby93dmVXWUpLbENuVGdVY1lDRWVWdVhzd1NrTlBhenFz?=
 =?utf-8?B?YlBKc3dWcVF6eW1ZNHlQRjlYd29EeGgyaDNlcnhWZXhwRGJIWUlDNzdjVm9C?=
 =?utf-8?B?U1FzcHhESEVKV2JjandyemdjWG1KWUdFL0MvVUNuWHdZMGM1WEwyMUJOaHdn?=
 =?utf-8?B?T3NvaUF2d1VKVSt4NlM4UWpUV3RSSlNyOXVkOUljc0dybzVlUVRhNjNxWkVU?=
 =?utf-8?B?R1o4UUM0N1YybVFDRjJNL1hVOFVoaFdHQ2VUVGgyek5uTFVYQmNhM01LNzNK?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fc4917-0d03-4bc4-fbd2-08dce71d34b8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 22:13:00.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKtGeMKIengoRDpeX+7aNoxqjhyFF4GDzHE+n79nIJktozTLZqhoKJxuEDTw1jnmq/sq9kDeeR7/8vzvsASKvUvxbQcAdNkfrh88iPu/IbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com



On 10/5/2024 12:46 AM, Michal Kubecek wrote:
> On Fri, Oct 04, 2024 at 07:19:24PM +0000, Keller, Jacob E wrote:
>> I have no objection to your patch, I think its correct to do now. My
>> suggestion was that we can improve the netlink interface for the
>> future, and I believe we can make ethtool continue to use the existing
>> ioctl interface on older kernels, but use the netlink interface once
>> its available.
> 
> This is not the problem. It's what we have been doing since netlink
> interface was introduced and it's what we are going to be doing for
> quite long.
> 
> What I'm unhappy about is the mix of netlink and ioctl where we use
> netlink request for RSS but also an ioctl request to get the ring count.
> I can't help wondering if it wouldn't make more sense to fallback to
> ioctl fully unless we can retrieve full information via netlink.
> 
> Michal

That seems reasonable to me

