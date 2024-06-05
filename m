Return-Path: <netdev+bounces-100940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159A18FC92C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7791C234A3
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB1018FDAD;
	Wed,  5 Jun 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Whyl1pF5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4414BF85
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583755; cv=fail; b=d+FJQeKmg8kSr6Kn6Om2MahDVWoKvoPb+eEJoTG8IogLR1NPvcP9LOC8e8gRFhuAzY5PfBntjGiBISy1b4orXDlInX4MetB4XC3hrfRK+6AVc8jCCNNud0/uh5y4rJ+Nc1j/qVsPQYTWeSiikBar0ccb5vls1YWPxJBPFLPO5Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583755; c=relaxed/simple;
	bh=4UBROC+/s0/wUyetlUgNPSGSluYU+K++3u6maYII3Xk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N0dD8AXFaM82lgWuwTk7eCwSmzPslhMquttRHkL5Gb6YxTcv67I3YZ1zOzQlbDwW5/pQdKIxx0PoqTKdZBoLa4hufL0XJaC1EM6p0HGCIFPKhAxjxvMU5qmZJf6QwYP2hrRH3iT/lKK2+9RPqw+8/oqKvJ5raUqyIWC4ybWE6bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Whyl1pF5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717583753; x=1749119753;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4UBROC+/s0/wUyetlUgNPSGSluYU+K++3u6maYII3Xk=;
  b=Whyl1pF5G+IxQYEyzpmPYaVUpGraYskbsp/6gasm+Jaak2UB6DmbuSCq
   Wxb5KggYrZeu4lOOBH24RWZ63UvKzcsyXKHFnS0nR+UkrjN9O5+F80Fpp
   EZGdFA6s4KZ6kYgho5HD9EQL9PN6PK/lSap1tF8O5vx4CtNztxU/GU1Wm
   JCjt2rxQy1SNIlI7lv5SERUMlhazQkQv/DOZrNV1V6A5ILzPCo1NcoAXb
   d/VF3U4IB6eg07hWlSV8pzc0xYw/mrj2596/t1TiuH7Nc40qCrYiRRe1L
   l5uhPyLcXK9uVRhB+tQ5/jUAguW0UVjJZYLWk+AwUCSaYTCwuZDKgDhqh
   g==;
X-CSE-ConnectionGUID: ZIbbL2OqTsSz6+InQADzXA==
X-CSE-MsgGUID: O/sTncOEQpWe3p/cdR9gvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14137591"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14137591"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:35:53 -0700
X-CSE-ConnectionGUID: tDL0HT8KQfyS2p+QqRfQLQ==
X-CSE-MsgGUID: /whdm0LNQA+nVGojy14y4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37620128"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 03:35:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 03:35:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 03:32:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 03:32:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 03:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B49Jw2zp1SmmLdiLO4BiRdYBaF+ylqhZw5mg7tqeiVozVJ0shCde1loQpFGMM6Z6ax+MGn05X2no+fwNRe2r9JdkJapRB/jxKRjV/d1mchtBabFD3pl8S830m1yHZL4Do19SBHD+A80B281fLeIjOe2AO1ZUuWWmy+ZHmslSl3zCcTUlIbwfJSgku9EYqhp6jPDa52fU/2f1I1uD2XKzuxQQai9aeTiXsTqScsNHs+xAXjYdyOuVE8ktf6Ur5x+leSEsiS+4eZx7XwS7ZFSRawymW/o9vsqxPn2K/9xe1DiaQZmM6J4NW0Hlkgo72sxZS72hB0Dkf1HKy7QoJXDbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvjzj2YKTf5pLTI5aG5dU3runR2yE52S7Yytssnc6+k=;
 b=kjJx3tR23zOd7UxIlXsyiqXfR0r/qrLE9WRiSiyfymcKuXIBVZ71OcfGtxMZNV8WC8woNg6W58dLIooVIzapdl0QJmw78fBUg/c/NmynKqPpyATN7Z1LDSdBstEl4gcUSPZLFOoW2wQFJXgtPycTyciW1ixGC8KlYzcWg+zJEhWswa+dgRdWBUXRPfPCNA0xJfHTZtQGiiMWiqUfTRVlTRIO1HkkwnmmDMIHeZXOiq8omigeGepkwlm23Cev6VoD5JNXmbIpGClbEk5XrJ8CC2TZ78HhHSpTEsMi0VNx4AYT1w2E3zSpMA5YPgJVdT6HnPYbqWr9Leh/lomo+RgoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CO1PR11MB5203.namprd11.prod.outlook.com (2603:10b6:303:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 10:32:03 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 10:32:03 +0000
Message-ID: <83a4c43d-5c5c-4764-b911-12171deb1b24@intel.com>
Date: Wed, 5 Jun 2024 12:31:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v4] ice: implement AQ download
 pkg retry
To: Wojciech Drewek <wojciech.drewek@intel.com>, <netdev@vger.kernel.org>
CC: <jacob.e.keller@intel.com>, <kuba@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>
References: <20240604125514.799333-1-wojciech.drewek@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240604125514.799333-1-wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CO1PR11MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: aac9c962-1206-4a40-ba71-08dc854abd8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWxLdnU5ejNvbXV3R1Z2a1JHTFpIbmhNUFhENUpEMGNWcFh0QndLRjcwU3Ra?=
 =?utf-8?B?Z3ZDTjlNTStHUXg5R3lzV3g4WDZjOERkVmdHSFY5K1lTSEVlVU0vekNLdlph?=
 =?utf-8?B?L0FTR3BwQjhyZmhBNjVhbEI1cUQvVXBCTGJoUHloMmlPUlY5aWQ3alM5NnBj?=
 =?utf-8?B?Q1NnMEZna09rSUVTeTA3VFMwU1VYTGJFZ3dadlc3OElUaGhZTCt1YzgzWEto?=
 =?utf-8?B?UjBORGxpVHVtRFFhbXNrNmNlekNITk45cVh2WFZZQTM3VnpKakVhNnROSW9W?=
 =?utf-8?B?b0ovL0s5UTdsZDdCQ3hvT25oVmN6RzN0ZnRaY0hEZFBxTkQxSFUrQXlqQWJz?=
 =?utf-8?B?SXg2NkI5cTNrN2FtcTcxSUw1bitHYXZZYXp3T0VLYWFValZ4Sk54bDVBdi84?=
 =?utf-8?B?Ymp4NWh4WFphYkp2QUozcUFmR2cyb3NuZ3QvNW1FbTMxMzlIR2VIR0FrRVNE?=
 =?utf-8?B?TkdQNWlKRERNbGg3MUNzdkp2UExOajJZemViY2UxU3NZUkEweXBMdW1ZMm1K?=
 =?utf-8?B?M1J1MENlU0Foc3pGcWVsNUM3aHRhUkx4cjZMYjd0ci9SbUM5K3ZlbW1ha0Zz?=
 =?utf-8?B?cy95UlN6dFlMblB3WjhRZ0tzeVYyWjAwNTloOWEySUMwNUVwb2lDZ2VFMWJx?=
 =?utf-8?B?VGU3alNhUkh5QzUxNDZCOU9wZllBVndETXg5eDhYdThtcVRxamNnVWNSbFY3?=
 =?utf-8?B?WWVuSFUydEFKNDdJVklFWVREUVdnV090MTJaZFlRUTc5TUV4aG5taU92YjRo?=
 =?utf-8?B?ZUo3Q2ZUTFp1MC91c0tCYjFoODR4cE12RWRwMVZjSS82cU1SeTArWGZ0U0la?=
 =?utf-8?B?WU1ZQXFGUHdkbVkzWnE3NUVZT1Y3amR0Y3dKWUhjdW1SSGlETFFSOFB5cm1Y?=
 =?utf-8?B?TUNwYkZrUkhBbkJiMTJidEp1MVQrVDY2bElrNFhnSnhWWEZXSHIwa1hROThC?=
 =?utf-8?B?dUtHZG5EUkJEbDUveHlBRThIdnZhNWxqYXQ4LzhyNTVTVlJzNmpMZUF4NS9q?=
 =?utf-8?B?Z0FhWG5mdGw5UFlCamZySGVYeGh4aHhsbFVJYjVxb2NIYU01WjZpc21sUDdz?=
 =?utf-8?B?MUVtdkFJM0U3WmZJSGdvUWIrSzVDNVVkd0Q1S0F6WVI5UHU3bTV4R21RUlZu?=
 =?utf-8?B?bXdNTnFockhYVFR0blRzcUUzUWRqNDdWVlJiRm00MURjcnpJWDZ0QWs3bjVp?=
 =?utf-8?B?TEcxYmZKeHhRU0laMUx4a0pQTmdqVVRIbS9WRFNZV2dSQlVGR3o0K2l0Skcy?=
 =?utf-8?B?OWJ1UzFxaHR3YWRtSUlxTUh4WGE4bGhLa2taYm5GU2grbC9LUXh6dytHZ0ts?=
 =?utf-8?B?NVhMQ3ZhNXJ5WmxiK01UT2h2dStwRW1TdUtDY0hZaFNpN3p1WGhMMWtxYlky?=
 =?utf-8?B?NEdIRHcydmJJQ09rNzBxWGZURUZxT2FVUHdmWW5aNzhObDJwa2w5V3FvZkY0?=
 =?utf-8?B?aEx5SVJMTS85SzRFUzJLZXpnNFRTa0txb0gvd0J6SFhmcy9tWEdMdStsbGJK?=
 =?utf-8?B?RHF4dHFhcDJpZ3JVSEU3N0ZjbFp0LzlNOUVBa21rQ0FvbFY5UDBPdG1wNzlr?=
 =?utf-8?B?QitzQWpXaTZnRTNLZ0ZTNWt2L205NGM5aVVhVVZIWHZXejJTTmt3VVdibkNz?=
 =?utf-8?B?ZWdXaWpBcnZLMlQ1c0JkOHBhOUZBa3d2SWF4eWV6azYvSTViVDVvclZVY3pn?=
 =?utf-8?B?cE5EWjdkN21nQzZUd3FTRnM2YkVOcEZCOUFTWmtXQ2VlQ1JqNVFVMjlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGlXdDY0V3NOR1d6bnljNW5BS0pwUUR2bm5zei93anNGZnJNb01pMWN2SzQ4?=
 =?utf-8?B?Mmt4OURnUWhjOE9HMHNHZ3BJbVV5QXRvMCtjRTEzY1hyQmw5UUMwMWpkN0pT?=
 =?utf-8?B?Wm5ETVNvOUFJbzhzTUdVc2k2YnJJS1JqaWFRdjlWbWJ1VC9qSnp1Y29PckJY?=
 =?utf-8?B?ei8vMnJyb3kxU1pXejlFRGM3NHgrZ1JwWENRMGE1clVTRkM1NWhLWG52K0Jh?=
 =?utf-8?B?RXlXcE9yL0oxdjRneGlEUmNKOGtaVXN6TW4yaStJbVRmajBwOUNMdWozcDhC?=
 =?utf-8?B?cDFZelhUYUVpUTZxWnR5d2FiaGh6WVRSZnpSdDgxNUdsa1E3N1NLam1mSDI0?=
 =?utf-8?B?UFdLZHpyakhTdEt4dnBucWZ5djJxWEFONk9BYlkvVHdtQW1WaWRUYkhpcHRY?=
 =?utf-8?B?T0J4ZlNYUGtPY0txZkI1b0hPRHVVdDZYSHllWWlFNmR2TThUM3IrRVJlemhM?=
 =?utf-8?B?RVZvaHlhcC83UklWSjU0U1dxOXRXYkpoYjV3Qm1LemZhMFlXUFMyTW53OUNU?=
 =?utf-8?B?eGxqTFpadkxXUE1YbDArS2FSUEdVSnRzUk5POEttVXhCUE4ybUx0Zk5XL1Np?=
 =?utf-8?B?Tko1S1BPZUFkY2JnM21UeXZDblpSQzhWOHZqdjdFZVNybHF6L0hYTktjQWpo?=
 =?utf-8?B?Umo1VzE3UUQxVzQwNk9NaVlaTU5SVm1iMFZKUk91VStvVUR6c0taOUNGcmdD?=
 =?utf-8?B?ZnpFVmRYNGZWcVZnVFlKS2UvVjBocWxRVUNZYk91SVBTWjQ1bHZhU1BTSlkr?=
 =?utf-8?B?WXNCaW9YczFERkE1aVdRUW03NGZCcTFzd3JObWxPeTBrVk1sdkthZThvVS9s?=
 =?utf-8?B?MUpjMGtINkRyL053ZWhDaHZCMzV0ZXY0TjFKSjJOSW5oV1M3WVdRNTM5a0xW?=
 =?utf-8?B?MG9BTllXS0Vhbm01aG5kS1lmSUtqMVg0Z0MwMlBUYmExVGlBTUM3VHA5LzJZ?=
 =?utf-8?B?YkM2NTdPZTh3VDZKemQra3d3ck4wMTVDU3QrNThtNkNWM0ovUjExMS9lSGM5?=
 =?utf-8?B?bm95ZzBnWFhEajVMM3ZRVkU3V2RDa2N1K1o2blQ5VUtjNUtDbWJSdy9WbDFw?=
 =?utf-8?B?WTRwZHVKVUxoL0REU0NscldPSWlIb0RnWStMVEw4b1RRSllJWi8vbVZnVlFo?=
 =?utf-8?B?alBxR2NORnNDcHhBZ1F5dmxlQXl4QjVWOUk3ejRQdTdsMFA2ZGlHQ1hnWk1Y?=
 =?utf-8?B?SzBLdUZQcVBHL2ZmRkxZMWdkMHpvblZheGZTMGdlN0lIM2s5RkRKY3ZoUzlD?=
 =?utf-8?B?MHoyUGJocXhiTXMraTNvMnhNeWFENXV1UnlQcTR1aTZkcElBaEo4Y0NzVHhB?=
 =?utf-8?B?UzZvbGdOeFJOSGJOVzhWYnhpck5iaEsxVkpRSFBkYjZ6RW9QSXpmLzZ3cTI3?=
 =?utf-8?B?cjBXVStoWDdBaXNCbUJyd0IyOEFmV1k0RHRvU2xCZkpBeVI2RDVqNUQzbmQz?=
 =?utf-8?B?TG1YYnlmN3doZ3hWczdYVXJIaGcyc3J1YUlvWFQxd2hxNUZJeFBVOXlBSDRm?=
 =?utf-8?B?Z2FOZjdBeWJuTnU2K3hiRHpDVUpMNmVJM2RMZVA0V0RvOGZQNnRSb3dENXVU?=
 =?utf-8?B?SENZL2ZsS0tQU2JHSGNuZW1DNnVKekxuWkJWTjlkMHJiVzRRUVA3NHB6QjV3?=
 =?utf-8?B?MTlPMjVyWXZQRkN6SW5LQjZ5UE96MEpDRWVkY08yVWhkeGREeE9KTVRqcjN1?=
 =?utf-8?B?UnFVZDVqZDlZdENDbVdJOVlybmNDWWs3elc0dmhpMUNqNG5TUmswM3dQRTFT?=
 =?utf-8?B?YzdpVnJRNVQ4T1pXc1JLdEhHR3B0WXZwdUlEam01TWgyK3Y3SDBPQ1JHdSsz?=
 =?utf-8?B?RzJRbDBCcGFCcjI3dGE3R2tuMjcrQ1ZpWGhodDlrUEI3Z0UyOS9ZM1Q0c3Ri?=
 =?utf-8?B?SElteU1oM0dpaWZQZ2xYSmt4L0JVUk9IS0ZpTTZLMktVNnM3Q3NOL1BmcHIz?=
 =?utf-8?B?bWZSUll6dGxnVzdzQVRjdFhKdFo4Zi92NUx0QXlkU2xVcEVmMHdwZjZEQ2hB?=
 =?utf-8?B?bmxBd0JYYVNaS25nVTkzK1FmU0piZ0FQRmRnTE81THFPOEtUZjVadFM2WmpJ?=
 =?utf-8?B?emRYUzhDNW1zWkdPTmZqWTJJdGgvVlQxeS9JSnl1bktpbHNMWHJEdGg4czJw?=
 =?utf-8?B?QkMzVUcrc2tUTFpKWk9GdnBiNGFPNXNzS1gzL091NXdjNzFRWHF6MTZBU3RY?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aac9c962-1206-4a40-ba71-08dc854abd8b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:32:03.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGmHq4FJKYt3MWnf9iGJp3JHUEpKusuaOYJpqpbYVPWyo0UdfZl+yPkWiG9fKQWpxERyZ6drLu3vXa+ih+KGJzvuWIvvjzS3E20DqroqTRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5203
X-OriginatorOrg: intel.com

On 6/4/24 14:55, Wojciech Drewek wrote:
> ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
> to FW issue. Fix this by retrying five times before moving to
> Safe Mode. Sleep for 20 ms before retrying. This was tested with the
> 4.40 firmware.
> 
> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---
> v2: remove "failure" from log message
> v3: don't sleep in the last iteration of the wait loop
> v4: Mention the delay in the commit msg

you have swapped v3 and v4 description,
and your SoB should be the last one

no need to repost of course :)

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
>   drivers/net/ethernet/intel/ice/ice_ddp.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index ce5034ed2b24..f182179529b7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -1339,6 +1339,7 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
>   
>   	for (i = 0; i < count; i++) {
>   		bool last = false;
> +		int try_cnt = 0;
>   		int status;
>   
>   		bh = (struct ice_buf_hdr *)(bufs + start + i);
> @@ -1346,8 +1347,26 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
>   		if (indicate_last)
>   			last = ice_is_last_download_buffer(bh, i, count);
>   
> -		status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE, last,
> -					     &offset, &info, NULL);
> +		while (1) {
> +			status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
> +						     last, &offset, &info,
> +						     NULL);
> +			if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
> +			    hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
> +				break;
> +
> +			try_cnt++;
> +
> +			if (try_cnt == 5)
> +				break;
> +
> +			msleep(20);
> +		}
> +
> +		if (try_cnt)
> +			dev_dbg(ice_hw_to_dev(hw),
> +				"ice_aq_download_pkg number of retries: %d\n",
> +				try_cnt);
>   
>   		/* Save AQ status from download package */
>   		if (status) {


