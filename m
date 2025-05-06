Return-Path: <netdev+bounces-188437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5CEAACD73
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C28E4A4285
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA936286438;
	Tue,  6 May 2025 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REoba18U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A67283C8C
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557084; cv=fail; b=Nhf8xsDMcFLrOnXbOyXszDOne5rLdxjDCxj55EdjqeueK4JFqKobMqk/lbKmNedcn0i8crvn9Nklw3CxzPq06NIpp1jTWc0pH3ItJePL67icjOJtIP6EDIRjgNcEcjllUQsmXjBb7OtDOr1WpFj0gR/kG6Ymqxrah5bDIU+ALHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557084; c=relaxed/simple;
	bh=avLNp4HPLHWkHhg2qg3omRN3sCkbiqNxr9VVnYI4PAM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=swjMa7gKl3kQKpLW5zqystdBVLpcIPT0BdYb5Aqh/HYtXk8anVvDcwOFEKhTzXQMQV1KrWeN/CGDu4/Rn2tLnQAdyz0Y28/GvfNzP94t7KLJlwsrQ3UeLtpxeTu4URtjfD6brGey+tOaFsY1xLaMPi+kaCI2ZA36aaeCazbGQNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REoba18U; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746557083; x=1778093083;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=avLNp4HPLHWkHhg2qg3omRN3sCkbiqNxr9VVnYI4PAM=;
  b=REoba18UmsxhSlHybV3986bPkurT2opCpqFwIOnUis5YxbW2NyBnKfal
   6BYUPUD8woqh9kPGnxK/9al79Hm4zhhK6HP30NKr1VD9Q8JH+M3aJ+9m9
   gzgsr813v37na72SVk5Y0wsxxyYuNWMvh3BdzNfyDgU4Vj8EhyyqKsK/m
   ddifD8URLD3eSepL1pdtJvD3XSadDtEwoOfWlH8RA0itzfIC8nPu3ODKs
   /15uF+IRKSEOwOoMjxhhTyrM6Ov/mPxFefuqwIabXsLuMfg4G3jwxec2B
   FbiCibZo9aEg/9P9fVGOhcbkLPQEkpfRvWmz8VDKUsle0vrXEx6U1bdo0
   g==;
X-CSE-ConnectionGUID: auUN7gnaSFOQGhuLj1rlCg==
X-CSE-MsgGUID: Y3sSxNLrTD6qdhfKr2+c6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59608717"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="59608717"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:44:42 -0700
X-CSE-ConnectionGUID: mtBrWyV+Swmd5gpG8q5xTQ==
X-CSE-MsgGUID: cwRxE15OQjKT2CqFlbXPzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="166751045"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:44:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:44:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:44:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:44:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMxND6kY4krl5sivRDrSSO/sH7zwYm9Ch4lphSMzf0a3EeWEB81+6z17rTyL2NSAQl9tHblO0UYaNwKVujIk0fUWgFCsqOwjpOwONlxV6IPuwyRYH69yy4CUOdjnUgb36/jkuvwy9yw6Eta3vSdZxDHtuwIFVhXHrSGUzgEKZXHUID8gdpZBGpfU9wgUWWczUTW+JbaSddZZ5MkKYId5BrtZd9ugP1uLmWOYsMDFe/V20Z0/02PslWB+bYJ2dCxxvsEL9tA35pcbD78YcMsUIq9ZqRklJqbs0NF9T5vLIOH/6n3wWJs22hObm2e3YWlHvHPen9GgD4j9UhVV+ixxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCyAepnvlSkpgED6pDsKjhO+XoNX5YWiVqGRG8WAkzc=;
 b=wyvkPfk0JP9IMqbeKICJZbt/SCLR5Py/CkWyk1H3HDPtrafUy9QwQRPa7eRTnwBzYImyakdN3/JMlrbKYgZfAuR8ak5pdJFzCnadlwJiUX155xVyWO63ohwKBRPbYIRLencrelqrfQcT6L66ZalzSRorGsaO7W72/aGcKgrpWz4tTGx7BCbQTNj6Dd3IPv38XUqkysQmwL6zKrbsI1t/GVLFkdISrUMt2cWa+LifNLbBC6GMTQB7dlnFVWpidfcDMkxqjXL6UVRmGJBnoggu8sm6CbtSmbvoEmabTPNRGkOQjS8tJ+uHw1VKBjBy1l4BbAcBX5CChIXs7P+90BC9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 18:44:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:44:01 +0000
Message-ID: <1860c5ee-efc9-45e4-87a9-59592ce58505@intel.com>
Date: Tue, 6 May 2025 11:44:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 1/8] fbnic: Fix initialization of mailbox
 descriptor rings
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654717972.499179.8083789731819297034.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <174654717972.499179.8083789731819297034.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:303:6b::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a0a4b4-4f0e-48c2-c70e-08dd8ccdf81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGtyR05vWWFvOERJRkJ5R21qanZGbmY3Q3JDL1MzWUhmY2RncGk5MDFvMVRk?=
 =?utf-8?B?QkVaY0lxS1VnMmpCdmNZMjFlSXF6SWUyeEtFOFpTdUt3OElNNHdITEhrdG56?=
 =?utf-8?B?S0I3R0pNN21pQVY1bnR6WVFtbk42YVFXZkRWZlNsWm0zaXlvRU9aM0hibHBY?=
 =?utf-8?B?bmIwQjNLaW5IRDIyYTV4ZythSFJFcDFJRzRzdG9qUEovUjZvMjlnVXloZVFa?=
 =?utf-8?B?Y2R1cDRhbTkzM21QQXF5ZUh0VmYwWStFL3lhZFFZS0loNjFuNlYxWmhodkQw?=
 =?utf-8?B?em9LVnFTTmhlclNSdkR1c0tPcm5Bb3ZqZkpuWmk0byt5K0VCTFRQT05rMUhM?=
 =?utf-8?B?QmZiWWgyRVVJZEsvVlRLVE9qb2tYcDY3bmc3Y2ltVkp5QnZpWU1QZE1jOGx3?=
 =?utf-8?B?MWxKUHAvNHRScUorMXlkTGxSdldZRVZRdWRzTDlPeUhYYTVibmZNVXRzNGwz?=
 =?utf-8?B?QkFNTG9iNHpmbU9vdyt6MURad0ZoNVZaQkVBd2dlQW9CUkdlOU05a1Z4UFFZ?=
 =?utf-8?B?L2dOU0UweWNiWDNlOVVCdnFwa1ptZFNVL3RHKzM5Q29pU05TRHdmWUxJUkFM?=
 =?utf-8?B?WmZyck9RZis3TUcyTFdhQ0JKNE5GelNCNWVmaVFkNkM5Tjc4alRMdU9rWEhX?=
 =?utf-8?B?cFZIQW5XakpHTExQUnVVU29RN1dTMjNPWkxGbGhRc290bUt6ZXRWNlpGZm1E?=
 =?utf-8?B?TlNrRFlPS1hHTVJFT1QrSHc3NEV5disyZ3Y2WDlTOEZqN0FEcjVLelFTVTFE?=
 =?utf-8?B?YzRWTnk5M1Z0aitOLzJHTmJUdjRNQzNLRTYzREp5OHFUdWY5bThtWnZaY2ts?=
 =?utf-8?B?c3pxT3lrL0d0TTRlYWsvN3R5eTE5cVNBbnljZnZFMWZmSUxqU1V2UTROenY2?=
 =?utf-8?B?MEhkOFZzUEhOUnY0dDFQVzIxRU56NzN2WFE0MHJaL0lGWDBpT3lBZHQyZ285?=
 =?utf-8?B?SjBleUxGbkJ6dWdpTEdqcndRblpJTnZJdmpjUlFjZGhqYVdnVUMzM29wZUtl?=
 =?utf-8?B?a2VidzNRRytqYUFzUmpuUU9ET0YzQVJlMnZkaVIvZHhvR1pST3I2aDEzb3ZJ?=
 =?utf-8?B?bTBnYlpIdDl3dDVqOWlTd1pxTTdpa0JHaUdTMVVFVk9aZ29sSml2aEpVUmZV?=
 =?utf-8?B?VSsxc041bjExVGlLc0REcVRmNm9qY3BtS0xDb1pwdVdEYTVvN0VyY25VNzJF?=
 =?utf-8?B?NlArSFpNV0xyNGt2WjFtb3Z3M1dZSVpWS2F4cmxST1hENmRYSFh1Z1REMjVS?=
 =?utf-8?B?RzB6dDg5Z0VQcEV5dm5PL20rTUZYTS9BelJ5UFcrdjNKc0twQUF5TFc3ZUxQ?=
 =?utf-8?B?aS9lS1ovdHlCck1VeWRDcDc0bjVDMzZlUXdhMGkzaTNhRW5pZDJtM2pPa2dP?=
 =?utf-8?B?MThKcjVDalJ0TFZ1VThjRG5NY1EzVmpibi9Pc0dXUzk2YjNlU2t1RldwUFBN?=
 =?utf-8?B?eExPUXVVQ0RtaVRsZGs0YmdkRzh3WnBXMlZRY2tabHVRUWVuaTZudmd2NTYx?=
 =?utf-8?B?OFo1T0N3Y3NHcUpLYkpTLzhseTlEK1NjL3piam9uUHROWUhQbmk5eU1Md2Fp?=
 =?utf-8?B?K3VodnJleC9Gc0Vmb0Z5cnoxSS9zRGZUalFDV0dKcW5zU3hpYm1KZWpJZTN2?=
 =?utf-8?B?ei8xOG51aDJQU1FvY1lEOUJSYVNFdDgzWWlpQ3NZSFdvZlZxVWxjZ21IQy9j?=
 =?utf-8?B?MnhmS2N4d0IwWXR2cHZPV3dSOFdFNVFySm9GODRobTNxMXRsa255SFlYK0dh?=
 =?utf-8?B?aVBBUXh5RFZ5T0p1Ly92NVBBcU11eDU5KzR4Vk14MEJxalMwQ0ZJcmpYV0E3?=
 =?utf-8?B?OFpML2E5a25hd25YVXZwbFdEQUtXQi9UeUw0SXR1aVR5cUFla3hVa3lUcC9D?=
 =?utf-8?B?Lzc5aitKd0VxNG5iMmFteEt3MjR3Y1ZDdW96Szd0c2RZZDFod3RNZXZuL1dZ?=
 =?utf-8?Q?BVZ+oRB7xko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRqRGxWTVZTQzV1TXZHcnNxWjRaR1J2ZVozZXM1czh3SzROd1BPSWYva3k2?=
 =?utf-8?B?NU1aZjYzc0V5ZG9WMGJkTU4zbXA0ZmYyRGlkYlBQcVYwdFV3WmpCV29wVG5C?=
 =?utf-8?B?TDFPbnBRa2lYc0VKbHFzdW53ZEpqdnN6cTR2N0V5S0lhRHBmeE03a0RrdTJE?=
 =?utf-8?B?dmpKWFBDSnNXR0plSDZ2TnA3L1lWSVlRU21HT1NzSVJEZ2hsS21jYUdCcTdZ?=
 =?utf-8?B?Mi93UCtyN014WGlzU2tuUVkzWHpJbWR1UUxBYXphNVRPL1g5NERZOUgzN0J5?=
 =?utf-8?B?RTZMTzlVVVBqc1l4UGpzaEw2dWp6LzRUSXpCTXFjZndIbDkxQUNiSzZMeTdz?=
 =?utf-8?B?NGEvZ3MrQWp3WlVkSXhHNytPb2tIQ1cwemJYSGh4eVpHNUF4c2dSZGdLTXd3?=
 =?utf-8?B?UUg0aXlXcVE5ME1lb1NXNVhFTzBna0lUYlhhek9JR040cTlUanNjV0duU0hO?=
 =?utf-8?B?VWh4cU9jYTVQNmowcFZpSjBpd09ORDhEMlp2YWpHNHVxbk9UWk52bDZ6aWM5?=
 =?utf-8?B?VHM0NVNMcVFseUZDQlZXbWFCcTEwdXhBcm9WSFV3OFcwU0g2UDU3OW1iR1lE?=
 =?utf-8?B?ejYyeWNidzdZV3RueUtFc3NDd20vOERlVGJvSUkyQTRYcmFmZWFPTEhMR2VS?=
 =?utf-8?B?cVhjUmQ3aWRtOEZGNjMrQTBBTFpVRlFhS0pMMzZXMytEUkVoV095Z0N3eUVx?=
 =?utf-8?B?NHg1anlCV2FiR05iRkxraXM4SHlpLzNEWWlJdlRHb2VrbmVEWmFRNFhYRURm?=
 =?utf-8?B?K1dZRkk2Q0lYZVJ3azd6VVRySXMwM2RsNldiVyt1dnZJTGxocS9SYTRDWDJF?=
 =?utf-8?B?aTYwbVJJYys4d2UwbUJrL2wvMlYzV1RuL2M0MGRmVk5mSG1NMCtwdEFYSEh5?=
 =?utf-8?B?MHRkcnRzZFlrMFAwVXU1bWVQY2FJVHgwYVdEUDlSOFZDUEF5QUllamNWR2pw?=
 =?utf-8?B?eDQwdDkvVDdrQ1l3bExxK25KcGZBalJaT2xTd3VYem1TM3BsbXpIK1YvVjlH?=
 =?utf-8?B?dnEwbFRZV0pZQ1ordlBVVHBSSmFpOGd0V09la0NEL3AzaGJ5M0drNDVYTVI4?=
 =?utf-8?B?VXhHSFJWUUVNb0ZwcEZVT0dNNE95Si9BWXlpOGpkM2ZXaTl4bFJEN0Z4VzQr?=
 =?utf-8?B?WFZKOGIyZUFEalU0K3NUSEQwOEJUd0F5ZmxmNm1xMHdmakpQbUVzNTkvQjIr?=
 =?utf-8?B?MXVrVkFGWlRuWFNsRmFZa25RUE9wSXhubXlUL04xLzFxaWlsdXZFT21LWTk5?=
 =?utf-8?B?UVVJZ0U3RXJKSGsxdnYyME93cFY4TDVIaWlObFVNMVZzcEhUZ2JrMmF3NmZp?=
 =?utf-8?B?SHA4RmdyMFNqN1BRSFlOMXhyNWRsMCtkMHpkaU1rajBxcTAwWUhheHlFMUJn?=
 =?utf-8?B?T2tROHhFR2NzV2s0a3JjZjdWOTVubSs2T0ZMTi9mZjZRcDJBN3FvcW1ZOUdR?=
 =?utf-8?B?Z1hzczd6Wk03ZEx1MkpXaVh2RjBKVW9tc3pOUXBMaWY4dmJyWUFGcHNPajc3?=
 =?utf-8?B?bnY3MEJ0NDQxREpzZlNzc0dyK085NCtHa3Z3clRiOXlGaE1ZYzNsSjZmT3FF?=
 =?utf-8?B?ZXJqL0JGQVBDSTNpY29uLytmektkc2p3YTZ2VHNoc2ZkaFZmV3F2QVB4RjZ0?=
 =?utf-8?B?eXVxcmxlb1VYR1QwN3JmY1ZBS2RWdkRQcGVJNWlGZENINFRVMlYzd0dQZ0Ri?=
 =?utf-8?B?eEtTd3BneHVFYzYrb2JRT3pYVnN0bHpGL2hpMUNTbGE1Nm5SZVpOSUpXMlgz?=
 =?utf-8?B?Q0tEZ2xLclI0UHJpV2xzMUtoVGJZVlZlVWRRSlFWVDJaWUlKd3pzY3BSZzBK?=
 =?utf-8?B?TlIra1hEYUZvRkFveG1hcE9lNlloT0U4U2RaMkNVMUFTb1o3Qi95d21kRm9h?=
 =?utf-8?B?eFA4WVdBbW1JMTFOVHYwVWI2V1NuTXJnZjFQaXkvQnFBUXhLTDVmQUtreXJK?=
 =?utf-8?B?WllGZ3V0Wlh4ODdwMWl1a1Q2VjRRQm04Sm5lYUR5SDBUekhjN09IT1F2R3dv?=
 =?utf-8?B?c056NW5SNU9UVGdXaFJ2T1RCVm9ObXdpOXc3Skh6MGpOSW1yM3FOMEhpMVVo?=
 =?utf-8?B?ZkVQOHFiV3ZQK2R4SFZGaUR2SFZuclJQb2VzeFhnUWNzSGlRMWl2d0dyRXNR?=
 =?utf-8?B?aVJnRitFeHlFVEQ0WWdPd1d4SFJ4ZTZPOFZQRXI4eU9zemxQQVZBdkxZaXZ4?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a0a4b4-4f0e-48c2-c70e-08dd8ccdf81b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:44:01.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4frX9kdf4iy/zUCGuMSq1Uk/SN38k968QZMjG0UMRklhYUEXKp2WYb6+LiE+YulEE5j/2gYDoxCHn5S4vHVjiQtVxFfdZI/XlMozCZw+rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
X-OriginatorOrg: intel.com



On 5/6/2025 8:59 AM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Address to issues with the FW mailbox descriptor initialization.
> 
> We need to reverse the order of accesses when we invalidate an entry versus
> writing an entry. When writing an entry we write upper and then lower as
> the lower 32b contain the valid bit that makes the entire address valid.
> However for invalidation we should write it in the reverse order so that
> the upper is marked invalid before we update it.
> 
> Without this change we may see FW attempt to access pages with the upper
> 32b of the address set to 0 which will likely result in DMAR faults due to
> write access failures on mailbox shutdown.
> 
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

