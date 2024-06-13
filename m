Return-Path: <netdev+bounces-103412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0821A907EAE
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B064B2371F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C36A1411C3;
	Thu, 13 Jun 2024 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2it3BsG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79813B580
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316839; cv=fail; b=CnEoN19CKbZpMc1F3Y2+h94qC4MlQFEkdFfk4LKYC0OGVPV/orurq/RJI+6wsxt7ibSGj2zyOLFtGbus7oF+8XTTVVxawjO8SW3LsIaWwq5WupK9OqP2BSSf8DIxczqG0IDBawZgcL6KGlRrejbZYeTzg53CBzTgWbIIi2ibj0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316839; c=relaxed/simple;
	bh=E1u/p1pL5CboSSNKV6WRgktAi7IXcV9sYSR/NrDyBcc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=deOq7R6kzniF5bpQkbLX9HKGbzCz1Y4eKvlxPdiaCX89Z2E2KnUwsFpfVXihh3VTep7Pyah2sF/K2vyi281KYeHEM201Ha53bu0moAvP2PJYXA9l8CQnhPCxBJpEyIY59SON3odrrkqc+Y/DO2I2dWs2/3mQLi5yuPaymQ41V8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2it3BsG; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718316838; x=1749852838;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E1u/p1pL5CboSSNKV6WRgktAi7IXcV9sYSR/NrDyBcc=;
  b=M2it3BsGRe38d9PDMrY6CaMb7rPsgKz3naDd1i+HOm6O/igvbh3Ap/1P
   sr5VqKIaOZaNmIvpAYh6z551gARScc1itb0O9VoH8g4GHkOSUv5M/d2gl
   issfelQ1k34sqOS+5CtHO9sJQVE2LKiQR3eNW70yHzyK3frVvgTlcRcTW
   zQUa23Ki2YtVQI4zPZOsx64pj0EXVpQp6H5pj9IvhCPKUT/vbwfPB2FKd
   KlIZHaXBydQFKRwqUVaz8QjZ+lvFG+nxdRoUpAJmp8vGjYAWyXUMsc21n
   s+1OuMnykGji4yeWZNZikO4S97MTq0f81/iIAPFQzcwP7Vx7jN1SjPtga
   A==;
X-CSE-ConnectionGUID: DvrTpK+eRBCm6zDHkeuDyQ==
X-CSE-MsgGUID: 5j9Bi7INR0WFxaFMxXS71A==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15329874"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15329874"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 15:13:57 -0700
X-CSE-ConnectionGUID: zW41JacUTBeKtK5Z9l8Cjw==
X-CSE-MsgGUID: /O6JTR60TKq2cAUCrIJrSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="44724306"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 15:13:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 15:13:56 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 15:13:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 15:13:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 15:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZAYCed5BO28r17J5W+gYizTOGrzQRAeIpvPb68fX/90oMB6LyEoqFolb/3OlIn/tAzK8ffwRX+AEJZrQU3JlfrpO5znBfKY+6nUI64a4P1krCDWPlGP+Kj4xRMFYxgFXo2G6D7G7us7cAb+fLw2vvYvVlaKyB5eIg/PVU02Cy+fqhpb1M+81fnMFjkyYT8yACxx+e//MKVMsThkJ8mExwAUPfoYmR7JAnL1rWe7j9RP2jNE1oSP+3Msg1kLum44gR/qHSTdRmaC5fGFreAZnCeUcla4oxaadV2z/+64mRNBQJa+IqU1HQkA9YAxFuyJ0haPSrdbbmFtsgdD7FzRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/GYN55uMUWQ/LJhBn/bONqK33Uar6PHPXPi+co5hNk=;
 b=nM8puAk0yuhVtBNVb5YtkghwYhLKfvx7tRzuoAWotKPY0lxcAsyoNd83FPRSzH2a7g2W7Pj+7iiiYgBcbwaBNbV+Ma/tTqfaBqJsw2PM44SlNNUE2UufhsE5l0AarEit0hEF2uCPUNYa4k9JoXsnzHSwG8wEM6s5KOdeqpzGJwAbq2FSSAqyqipxUI7gP4WOfG5rymC53Oa7iwf2AOvOOLYMGX3sA/gmy8ND1t3HHTov37OdrxeZvM3Oi+9r9htDCvcNXJjZ+rq7J25ro62dhjKIMUcDt+Qd7HA5JvKihpW3vgTZjQD/DnY9uSCpD3qjnhAwiC9/7WoXbthhl6iZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7878.namprd11.prod.outlook.com (2603:10b6:8:f6::20) by
 CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 22:13:50 +0000
Received: from DS0PR11MB7878.namprd11.prod.outlook.com
 ([fe80::9c01:865e:36af:9dfb]) by DS0PR11MB7878.namprd11.prod.outlook.com
 ([fe80::9c01:865e:36af:9dfb%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 22:13:49 +0000
Message-ID: <c3a580a5-cc6d-4bfc-b233-94a3d3377c95@intel.com>
Date: Thu, 13 Jun 2024 15:13:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdev-genl: fix error codes when outputting XDP
 features
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <sridhar.samudrala@intel.com>, <alardam@gmail.com>,
	<lorenzo@kernel.org>, <memxor@gmail.com>
References: <20240613213044.3675745-1-kuba@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240613213044.3675745-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:a03:54::34) To DS0PR11MB7878.namprd11.prod.outlook.com
 (2603:10b6:8:f6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7878:EE_|CH3PR11MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: ce05657b-919f-4088-3265-08dc8bf61a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHNoc1dHT3lhcTkwRVlONHFrT2JaR0tDdTVVcjIzaU5vSE85S215RzVjMERK?=
 =?utf-8?B?c2s0YXo5RkdTNVQ1ZGdTSSt0OVByQldjYk1iTzJaRVh5VnBIMWRHU2c0c3ZY?=
 =?utf-8?B?VmVGeFFCcE04bWp0U0ZwNFVOUnN4YmFRRG9adlQ0ZGdiNDdEcHJxb0tmWjhS?=
 =?utf-8?B?eEZPQWJIc1NNbk5kdUhqQkVvUWl6RFdlY1pVclY2enNKaTlxNVFzcVgrTFBx?=
 =?utf-8?B?MDJXTUVNaGNYUkxqT2dZd0lQM1VROUFoYkFzT0VGZDlGS25RMlNVV3RZUWo5?=
 =?utf-8?B?OXcxbmU5cFFvQ2pHNlorRVp2Y0JEaWNERzNkVVZ5TWs0UHJRQ3o3dnkxVGds?=
 =?utf-8?B?MHQyNW9QTGZKWFJJckxJdjUvVkt1eHdnR2lDUkpxS01mY3RsTGtSMmR2dzlC?=
 =?utf-8?B?bWhjRnY1cnVrdjN6VzFld2lEcEFDeHdvekU4TlJWOEl0SlV3SVFCaTd6YlZN?=
 =?utf-8?B?S0M0Z1dNbFBaZG9FWG9jUC9FWTF6RVNpVG9rdGFxOWF5cCsxSXlwSHpzeGtt?=
 =?utf-8?B?M0tYa0tobm03OGo3QjYwdmp3U0N0WExVQnZBdWp5U1Vwc2c3U1BGVmpVLzdE?=
 =?utf-8?B?ZnQxZ21CTDBDNnJsUWhNSDJRb0xZOFU0SmVyUXhwVnNFMnkrcmhyOHFsYjl4?=
 =?utf-8?B?alV2bXF6RlRGVU5JOGdHcGNWKzFPcjlhYzBDZktsMmhLUHB6UDloMVVWdko2?=
 =?utf-8?B?eHFhWk5HY2N4K05sWFBmc0J4NERMUXc1cmZud0NpNVJ3UzJDQXl2dXRtdGJQ?=
 =?utf-8?B?NkdRVjlMWFBmVzBxN01CR1JQQXhLT1dYOTFFdWt6S2FtcG5iOUFLQTdzRVhr?=
 =?utf-8?B?WHlxMnB3Tk1pVnE2Z0Iya0FtNGZOdHQzd2pYUmxDSUgvZm9nR2Q3dy9rZUFU?=
 =?utf-8?B?SUVYeVdWKytXNTJqUmpVOWpUUDllYjhFSTNYbm90bXhBYzd1WUw4ZXN5a3lB?=
 =?utf-8?B?dVk5aWhpcUVmdncrYW5MRHNCU0RRcHdIRlEydHhydFZERTFRTGdWTUU0RlNM?=
 =?utf-8?B?eU83VGUzN0cvMlRmNWxDdUlHdUtKWjRaUC80eDJKY2lyNXpNakU1ZlB1N2tu?=
 =?utf-8?B?a2s2TkhBVk9neElqSjlMYlYxbER1SkhZbVJOdUREWnlhYzZqOXNMRTAwaC9K?=
 =?utf-8?B?UkdnVjVBamtsTXlCTHd2QVJyMHlWL3E1SHNCU1EwamtyR2kvdkpDaWROcmFj?=
 =?utf-8?B?a253RUtrZ004Q3ZHd0M3d2RvYzFRK1Z4MVJ5TDQ1VU5VVUtFRzdrQWxyaUZa?=
 =?utf-8?B?L3NrNkwyNzZoMnkvcDlhMFFHK0taWXNRLzRDaHBHVmJ4M0hDZ0RXekZNRDAy?=
 =?utf-8?B?dlY2NURaYnFPSytSeEJUdXpkaGVMaWU0SWw1SCs0ZFBwQmJneVRIZjh1aUJq?=
 =?utf-8?B?VG51OXp2S2sxYjlVYTMyQytvYWhKZ0toZGRMRmYxNm8xTWk2dm0zbWxMeTVN?=
 =?utf-8?B?NGFTekRLbStqYldxZVNlMm9hRWJXQUhQdS9FUG5QZ0ZEY3NZUGtVQ3RVRmVW?=
 =?utf-8?B?YkdZOEdUTGVNbEtZelNjVnJVMGk1cjlxR3d3VWVYWjZ5SGxEUjN1bm8ySlhY?=
 =?utf-8?B?TEtSTGsyNXNLbXY2cGhueCtuNnpydkNFK0kwT2c5RVRuS2QxTkdxalBpNEJs?=
 =?utf-8?B?cFR0MmJPQWJQYk9UUnpGQjF2TUxrd1o4Vi9nRG01SGZyNHEzL0xqZ3lPak1G?=
 =?utf-8?B?V0ZBaXNVbjlSOWhNMXRCY01KNHFKNVpsSDk0SzFZTnlQOHNLb1prdWVtVndV?=
 =?utf-8?Q?MyNB6khTejlDI8TQWVjdQdTdnubjoMHja8x9kj7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7878.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ROa3FJSUNUM1BvNGFNRGFhVVRZTUJERDg1TnlCbDk1SXorQlViM3pGVnFu?=
 =?utf-8?B?WkdncHlMeHlTZGVZWU5CUkhrRGtRdzA0d0RITjk0c1F5aTVDNjRtSy9YOXhh?=
 =?utf-8?B?TUhOZGJyZTBmbmJoN0RDSlV1UlVRUWF1QTZvVGdoakZMVHFpR1Q2VW1JQzBy?=
 =?utf-8?B?YmhWREFjWTBwMmNwejNhRjVLRnVvQzYzWVQ4aU56b2o0bm1HVkJVbHJ6ejNC?=
 =?utf-8?B?OGZxTm5VUnFUZzlwQlBuRzlVMEc1NFZvQVpLR0R1RnVhYXFqalpsamcvM1k1?=
 =?utf-8?B?cDIvZXRtR0s5NlZqWklUWVJwWGlKd2M1NVBXUzhJcUdCcURvZURFREtWWitw?=
 =?utf-8?B?RGZjbzcrMWRzekVGYnJkRW50MGd5Um9sbDN6RmVGbG1SSnlKODNxUitqY1ln?=
 =?utf-8?B?NlNIZEhESDNOb3drWnJsOGRBcVpUUkt4Snp1RkdHU05wU3pPV3Q2bDFHN2hy?=
 =?utf-8?B?ZGl3SExiWkxkMXpQb2hXOXRVR3ZuVFpMT29MWlQxRnp5YzNzSTh2NGswK0Rt?=
 =?utf-8?B?cVRJSDZUdW5pS0pkMThQaWVHdFQ0QkVYY0Y3ZUp1QlYwT3I3Z05RbEpmZ1lE?=
 =?utf-8?B?VmNHRFoxZHNuM1h0Y0FIOXdMODBKOGNoSjFBc0hDNGg1azZJVGxURFRMVkpQ?=
 =?utf-8?B?WkRQVHAycStIYzd6YU9rVmFsak9HR0s5aEdOLzkrRGxLWHJ2UUpVVUgwZUxM?=
 =?utf-8?B?dGRCbjJYRGFsUWpTQUthdFlraDN0bU50ZkZFbDhTb3hoNjlFTVJiQjNKazMw?=
 =?utf-8?B?UjlINm9UVmJDdWtKZUVtVEhlYldqM0VzLy9MLzEvTUd0NkxWeFI2bjZhSmFu?=
 =?utf-8?B?SS8zR0hDczVoOVE4N2RnajUxL3kyeDU2RU9rMWdpYW05NHhvdUZWU1BicENR?=
 =?utf-8?B?T2JjRHpqQzI2RkZjcjJmdGRlNjc1Z1FQSkZ0dUptWWI1UUFpaEUrbCtvS1Vz?=
 =?utf-8?B?MUUzTVp3YjE2a1NkV1Q1UDJoVVNzSXpKYVBQMVBGWDVocThzTExIRXE1eHRR?=
 =?utf-8?B?dTUzU1REc1hoUW5XUkNvZlhxTTkxb1lxSHFsK3hXQTF6N2w1SURsbGpSczJm?=
 =?utf-8?B?OGc1RXY4TU03Wnh2UVZHU2VqQmZYY1pBRlY4V08rU0JoRTVwbFE5VFBaem8x?=
 =?utf-8?B?MEFjb0RSWW4yUXZEVVRkTzc5Szh3ZjhPNVNpbzVkM2lpTXhwS2UvcXBWRDNB?=
 =?utf-8?B?Zk5IR3Y5cDhaL1ZIV0VmSW1yN1NnUVRZK3ZEUVR0M0t0aXk0MVdoaUZ4NjFF?=
 =?utf-8?B?M2FPN2FDYXZYOUFVTkdXY3FEVHB6UnU5Zys2YkIwaFVqM3FRcEZISEpvdDE2?=
 =?utf-8?B?aVY1dE9TSjM0ajg2YVhwck9zM3YvL2hlNnFneXJYb0NscTZpNFNza1g5bEpI?=
 =?utf-8?B?RHhuRytLVlJGMkc4bXY2N0MyZ0ZFenY1eUJJRVV1VTRHdlJlRVBabzZXL1lJ?=
 =?utf-8?B?bkMyaHR3Uy9wMlNNakRGc3ZZVG9qZHRZWloxYnVQQkVpanpwTHhOSUYxbk44?=
 =?utf-8?B?MzRvUzVzYXR5b2JtV2JoVGg3TVQvdmV2ZXorSGxLcVNCSkNUMzQrV0pQWUNo?=
 =?utf-8?B?aDJHczBSREZZdXNLODVsTElXb1JmQXRGZ0tIS1ZnK3RDc2JmK24vYXZzYm5q?=
 =?utf-8?B?WW43cG41NGxCalUzYU5YVTRGUUd5MXdFVGFCL003K080Sy83YkZHK25MQWlo?=
 =?utf-8?B?amRTbVUvcERlK2JhZkRzYzg1Zkl1TDREL29YMG5JTnpRTEx2VDJzTkhzS1A1?=
 =?utf-8?B?K0s4S0ZhVEFSd25WN1A2bUZSV3dXUHJodXBVOXJlUk9vZHRJYzhOb3ZmWENP?=
 =?utf-8?B?Q3pqUXl1dFNsVE9NdXRuVzgwUlB4ZkpZclJlUzJiZlBobThpcXBwZUtncXR2?=
 =?utf-8?B?cnozdXRUaTA3YWs5OFU1ZkVJNGd2YzQ1ak56L2dLTnZ4dWNNUXZQTUNqZlJB?=
 =?utf-8?B?U2txbWpPM3NNbmtpUHFaM05iZFIya2hiY0UwRmJNM0RRNzhONUJKMFpJc24r?=
 =?utf-8?B?SnVtK2NtbzR0R0I0dm5rU1R3d254UVlaZ0ZpdmtXbTl1VTFscG1VOVk0eGRI?=
 =?utf-8?B?TTk2RVE1RCsvQjhpc2crMVdJMmNoWEZ6Skc3UXBIRkZML0FPcUVQWFR5TFg5?=
 =?utf-8?B?c2xuRnlocDh2NExzaDZEWDY3MkNUN3hXaVRZeFVpSEJTZktQZjNQd09QbEV4?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce05657b-919f-4088-3265-08dc8bf61a0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7878.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 22:13:49.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NujrU4wCk7XKiYga3BDGyT1ocikoEAAzvroAmV0EpegyrOAhrXVB3y6JV8Wl6HrcrkVYeekGQ/XQZVYPSTBJDGNilOSufnlUBP1xTcOc2Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7895
X-OriginatorOrg: intel.com

On 6/13/2024 2:30 PM, Jakub Kicinski wrote:
> -EINVAL will interrupt the dump. The correct error to return
> if we have more data to dump is -EMSGSIZE.
> 
> Discovered by doing:
> 
>    for i in `seq 80`; do ip link add type veth; done
>    ./cli.py --dbg-small-recv 5300 --spec netdev.yaml --dump dev-get >> /dev/null
>    [...]
>       nl_len = 64 (48) nl_flags = 0x0 nl_type = 19
>       nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
>    	error: -22
> 
> Fixes: d3d854fd6a1d ("netdev-genl: create a simple family for netdev stuff")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

LGTM.
Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>

> ---
> CC: hawk@kernel.org
> CC: amritha.nambiar@intel.com
> CC: sridhar.samudrala@intel.com
> CC: alardam@gmail.com
> CC: lorenzo@kernel.org
> CC: memxor@gmail.com
> ---
>   net/core/netdev-genl.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 1f6ae6379e0f..05f9515d2c05 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -59,22 +59,22 @@ XDP_METADATA_KFUNC_xxx
>   	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XDP_RX_METADATA_FEATURES,
>   			      xdp_rx_meta, NETDEV_A_DEV_PAD) ||
>   	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XSK_FEATURES,
> -			      xsk_features, NETDEV_A_DEV_PAD)) {
> -		genlmsg_cancel(rsp, hdr);
> -		return -EINVAL;
> -	}
> +			      xsk_features, NETDEV_A_DEV_PAD))
> +		goto err_cancel_msg;
>   
>   	if (netdev->xdp_features & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
>   		if (nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
> -				netdev->xdp_zc_max_segs)) {
> -			genlmsg_cancel(rsp, hdr);
> -			return -EINVAL;
> -		}
> +				netdev->xdp_zc_max_segs))
> +			goto err_cancel_msg;
>   	}
>   
>   	genlmsg_end(rsp, hdr);
>   
>   	return 0;
> +
> +err_cancel_msg:
> +	genlmsg_cancel(rsp, hdr);
> +	return -EMSGSIZE;
>   }
>   
>   static void

