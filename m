Return-Path: <netdev+bounces-170675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831D1A49890
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9321740B6
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CAB241C99;
	Fri, 28 Feb 2025 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QB4HGFoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8554923E32A
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743477; cv=fail; b=i2B6F3zCAzhhskW66eFFWYWHOrYfNb2cmZDOB4qU+2YRnhxI4BcT8FrfFql1oYfBc+4ZmxoskqSN+xe+EqKSRXxH6U8daCnksyL65sg+ZOqfYPExroTJCNaN7M0P0qg2y4Rav7CYkoUAXfLLZ9gSPxoPuHpBVj7SH3UetH1flbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743477; c=relaxed/simple;
	bh=e1OTeVPOYf+d/wq79RR6oygCc7a0/2bnd8ZW9udBCwg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XsTx0BUPfKqwxY5p5gQtxCzvNVr/byOWRmp/LtLjF95ubcAFSF9IXvEMC1YS2Vab2v638zmpgtnTpF9LJCMW+jO+2d+jcDwF4oQL6ZgenQJNUmXwmTsYt3q86qgk6KExbPACnrb5wKMQc1AWhFyFeF23qbcLGkVVZSpVyxPjMQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QB4HGFoJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740743474; x=1772279474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e1OTeVPOYf+d/wq79RR6oygCc7a0/2bnd8ZW9udBCwg=;
  b=QB4HGFoJWYFyXCJjI9+GPD6s0iYZToOiPpubBeqUWHUA2ASVJ6u9R02c
   HBD0QT8BfvYF6fOeVEH+FuQkb3K6JKWX1+de8/EgeoJFLt1TakcWsENLx
   IDUDatG2kep5kVOzf+/S0MfHS55LYzwe6Oot/5iM4v2gvl1cbm2XVo1np
   Kbf0Pv0SpwA9lJMAu1T8Im223kj/GO7tv+hmvq2fp7bX2Eo8vFFgPkcP4
   6glv0XlhER17OyL/uKqFkvySOtA/wLrmv0ngtCz4YkocOOt5SeceRdzbe
   87RvurplaA5fHMcwpz9q1WawiaIn/ZvCTZFQE86c6mUIPHjsF9vv+gAug
   Q==;
X-CSE-ConnectionGUID: YcPlqrReTaGaRXFKD+e9Qg==
X-CSE-MsgGUID: IlUa9MyoS5+XkRs++HCC8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="67045929"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="67045929"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 03:51:14 -0800
X-CSE-ConnectionGUID: K8G26+u/QoeuiU0FP8zfsw==
X-CSE-MsgGUID: PaqsMprZSSOHCuN+eNugNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148241352"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2025 03:51:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 03:51:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 03:51:09 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 03:51:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afXjf4VJnASoZENjG/EoU4SA3WOP68ewSbDqmf4RdL58fgw6CtiiS3LFrZnxCbs6o33LNCiOFyRk/LE2oXHQiOWiE4Cok674vopHmmQghtU2wTOsNpMk86ieINebX4Kma1Hchzyuk7dObyheCSE+LurRptOicB1/tH2qrLAWtiI/m3oxlL8iszrDFXXz4Yw+kf3j1OsqG7oWqHuyYuq3P38V/dartpIXws27YSkRE11zYbOsO5RuB3F3nMqKmyq3zKS4aeR5WhmfFJAOdBsUsmSH9jA/f7F9cfY+78wHX0dvKaunwfig1wTl1o/kA9RReQcs5WS73ugYG+shIrxKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPHJkAvbu32ftTUsW+Ek4aoM/Ymovpbp69aFjBuqg8I=;
 b=VuIz1VdiSNZqBDneTOOoenSKvp5TyoH39DYeGR88p5bpggrEUP010BBf/qeymenTPWTa7DsYFW0jLgk9uQVBvgc35H3ngPjkOMLFxorh2NR+Qfj+4C6uh3igItwjLUrPW35Qekdyob3gazi2piRZGYtQtKin1ZTzbfuNTaYS2NN/PbaC8vASrL7yY9gYyfzSDXyTbO2SmyGq4vODVdAcL1JI8ttBEb4vWE9mSrKi/nkRuhKToNveA3GFkyldHMu3NMpToGmjWfsCwJZpEGV6Ctxx+1TOTCvdi6Kxy+HWA9YyrpKxH+9ztWRzd2DNnYCzgW1v8DKQxMBf6Y9dtk2u+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 11:51:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 11:51:06 +0000
Message-ID: <7e2ab878-3c4b-4658-a98f-106ce453dd76@intel.com>
Date: Fri, 28 Feb 2025 12:51:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] eth: bnxt: maintain basic pkt/byte
 counters in SW
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <michael.chan@broadcom.com>,
	<pavan.chebbi@broadcom.com>, <davem@davemloft.net>
References: <20250228012534.3460918-1-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250228012534.3460918-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0171.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: f54639f8-6b27-4c11-5ea2-08dd57ee2f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2xUWHN1S3ZSY2tEdlhMR0lKY29ySTNSY3FsdGRRaHdsUnhSeU04T2tBa0cv?=
 =?utf-8?B?MHM5UkNZbG9LKzJkcW5PRG9nekR6WkVDVkhJSGc4WENEZExjTEtHaHFJTTBs?=
 =?utf-8?B?Zkx1Tk92TFNRWEE3YlQrNXpPMG11YmZtdmNvT1lnSlczQlNiNzZyeWVNUjUz?=
 =?utf-8?B?V09HN3lySytkaUQveWlDcjRndmw0OE1RSHowVnR3VkNnVG85L1lENG4yVFBC?=
 =?utf-8?B?V2NSK2VPQ2o5RXJUR1I1NmlWUHZ5TnBjcno0ai9DemVHajREejJYNFF3UkRj?=
 =?utf-8?B?VGpneGY0QzZEUnNjMG1FcEphZDdOVjllODBNaWJObGk2RXhScjRSalJWUzZN?=
 =?utf-8?B?cWR4RWdyZGxTVUdMNHN6eW1sTlEyU01Vb0xDN3M0ZTVHcVVjcXdlTEJNQ0Jr?=
 =?utf-8?B?OU5PNjRLMjV3N3VFTXZRTmV6SmdiOU1VWTZ6dnhXUE4zbUV2REJwd3htNnQz?=
 =?utf-8?B?cFBISkk1SmJjTU5naGdiY3E1aVc1S0doeWFzSTZTdFdDcXJzSnJ5a0NNVWVS?=
 =?utf-8?B?b3d2Sk9qT0NUa2JsZzg5c1gya29OMVJHbXZrRlp0KzFFTlhaNTl0eWJTMmpC?=
 =?utf-8?B?ak5EeGtOT0NYRnhGcjNFNXYrRElNZk9GTFNZMmdEdTI3Slhuamd0KzRyRXZD?=
 =?utf-8?B?R0xXbmlqdjhmUVd0bWl6Y05Zek9HSEZyMnhqOEpmVC9vY2d2ekkyRDUxOU5P?=
 =?utf-8?B?bkxsQzRydkxYejdOOHREbkFNbVplajI3NzJlKytGYlJ6dGdLUG93Q1hla1JM?=
 =?utf-8?B?NlBzK0VURHV3WW5zSlplWGxERXA5QmlscVZZWURTME9JY0JRaXd6UWZhTlJr?=
 =?utf-8?B?cU5NNUlZVmt6dFhVczlxQ3o3eWJXL21CQktHN0lDM3YvazRLbkhaMnN6eitM?=
 =?utf-8?B?a3VkYUE0alFBWkl2NWVLUnNpUzRXRzVKakxwQTNxREE1R3F3L05lVDIwbzI3?=
 =?utf-8?B?V29CcWo4WGQ4K2wyUzZPNDZicjBDam5rTWp4ZkV6RGUrZGF3TkRoU3V2dFVy?=
 =?utf-8?B?emlwSERhZ1dpdjFtcndFdGJtZm90cStpZUkxaWVFaVJqaFpWUGNOcFZaZlVn?=
 =?utf-8?B?b3VRUWFGSVUyc0I1M1BRaENNZTRYT0E2MWt5dzdYc1ROU1hLcERwengwTFZI?=
 =?utf-8?B?THVReThyRHR2UUVGUXoybVFoZFdaWmdxQ29KbzkweUdZUWZsNkJFUVZOMGZ1?=
 =?utf-8?B?cE1PUEtnNnhRSEZFTnJOT3h5OTBCWTczTVE1dC9oSTFTNXVRMjJMRG9MZ0gw?=
 =?utf-8?B?c3ozcENESEVTekowTk1teEtIc084bndsODJQRjZaTnJ5TnhwS1NwNXZ1NWpP?=
 =?utf-8?B?b0J2eFRKRFVwZHN2aVZlZ2JES0dxS0Z6TTRTeXJ4aUNOKzR4dHUySXR0ZVdW?=
 =?utf-8?B?WUk2bmF1VkVSdlliUzFYTEFkeE92TDJ6cS9wNHZzVi9venF4b21EZDdIRGV4?=
 =?utf-8?B?ZlJUTFcxSHNkUkRXMHlnK3Z5U2lGS2xsTXNpVnR3TmpnK2ZucjZJZmNPdnlZ?=
 =?utf-8?B?c1ZpcldtU3YrQ2JIRHRDbEtObkQ3YTNmUU1uSlBsNXk5c0xpSDc4N1ZKZjNx?=
 =?utf-8?B?d1E0K3l3czdLMFNKTkNkeHVPS0VrS0ZYNlNsaE9FTDVNK0tsUnFNai9jNThk?=
 =?utf-8?B?MEJFVEJaamxKbGdaWkdvNktRdVFVY0xNY1JyUmNuWXBHNTArMEgrUWgyMzNI?=
 =?utf-8?B?NlU1V3RRYlltVVFtV3NJWUJ1L3A4YTZ4VW5tRm9aV0tRWVoycmxtTldSRENP?=
 =?utf-8?Q?XW/0WjzDdvEM5JloX9KXALDilfW0famagZqgm25?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGpwdytHOWhFWm52NVdRSEc2M2wzWnVqWU1SWkNpTVRZR1YvRTVaL3lWYWcr?=
 =?utf-8?B?bXhmZm5yekg3S1VDbGFTR0VVNjFRbzFyZ2NTdFIyaS9sN2Jya2J0cVNISDBs?=
 =?utf-8?B?QUgvL1JBNDdLbEVscFcxVVRJS3ZHbVdvM2laR0d5dytkQXdCUlAwMFRnUjFM?=
 =?utf-8?B?RCsxZERZMEhyZ1dWNE8wbkh1b3FCekFsTjlNK2xWLzZURFQ1U0NFTm04amhL?=
 =?utf-8?B?dTF3dUlvZ0VkbE9TL1JIWlRET3dJZi94LzlzRDZ4MWY1OHI5QmM2K2xyL0Nh?=
 =?utf-8?B?TmJ3R0R5a2RtSndld2RvZlBXZ1Y1TlNJcVhCU2ozcjBrRmJKS1N4U3FVWVdI?=
 =?utf-8?B?MW1TelhNSGFweS9vYVBZTFpJMlZyY2ZyaXlEelhaQmx4Zkh4UERBbXVDN0xQ?=
 =?utf-8?B?WkRvWSt1eEc3eVRJT3dRY0xSdlgwQlNvdXByT2tBd3VjMWJEWDR2Skh2Wk1i?=
 =?utf-8?B?bjFGTUlOaFZWaEpMUEMzMmEvelU2MTRmNGtDWHlndWw5TXF0UHRySVNJMXVQ?=
 =?utf-8?B?VjRPTk81eWVaMXpFcWhrMHJ5S0d1enZWRjlMTE81VjNRSXRRaVlBRGI0QWVO?=
 =?utf-8?B?RTVMTUExZnBXdnYrcXBEc1NjV3Z2WE1EcUd1SUVVbnhXZmtVV2xKQ0NDRVhs?=
 =?utf-8?B?Q3Q1aDFHNUUvWDNLUFdVZkhlaTZzZno5KzFueVl0NXVlNGFVejVRMjl1YUha?=
 =?utf-8?B?ZlRVeStTVzRwaVkwQWpYcUFwckZIYVhQS29vTkxWc1J6RlluOHVwMERHeE10?=
 =?utf-8?B?QS9zYXJrdmgyWlRNTW4zalczYzBCbGhpWHh4ZlRob0RXSkpNa3IyYzlBWTQ1?=
 =?utf-8?B?ZGNVbEJxZHNsREtzZitRU0E0cnhGUTlhdDc4M01HUGFCZm9vL0Ryd0dvRE10?=
 =?utf-8?B?VVl3N0M2bkdhd3RCdnlQbENPaHBkUG9kNmZXTmJ0Smp0STQ5RDAxTnFPWVdz?=
 =?utf-8?B?YnVhZEZmRC9FUW51dFB5WU9CTlhTMzFTeWJRNDRTU1Y1VnpDbWEwUkEyTmJi?=
 =?utf-8?B?bzJPSWdWYXl3ZDlSMEMrTTA5empobFVibkpNWnRiaW9vQkRXV0Y0aHMxV2E5?=
 =?utf-8?B?RTB6aERpVzB6M24yTEp1RVRIVTFJTXZ6Y0VDT1I0MVRVUFBGNXhUWEQrY3FT?=
 =?utf-8?B?aEpNLzh3blVIdmc2VUU5dlhNTlpPZnFKU0NvMVZDRHp3UGd5WkNKRFNTdVpK?=
 =?utf-8?B?TGd0U1BDLzEyRDNNcFRVOGRqMDM4ZGJidkY5TU9hd0lid3BwUTdhU1Vabm1W?=
 =?utf-8?B?bFhCMG11ckgxdDNCOGgwckxCSWYzYVdQNTA0RlcyZzVaNjNYZFVSL21aamlS?=
 =?utf-8?B?UkxnRmx3aHNjNVhqS0lIR0tmbUEyQmVIUm9XbXJzc01OMTd1RU50T3NqZWYv?=
 =?utf-8?B?OENCdzZrbGtFWUQ4U1NIbTNpclFoU3hGUkVUVmlkV05Xb1JyU2xGamo0elVD?=
 =?utf-8?B?OWJYOVpybWR4dlBGOW5QWmhXVlA1YTdYTGRPYkxrUFN4T2pCMEh2Z2VpQzJ4?=
 =?utf-8?B?ekxzL1dKUyswUjRYM1B1aHk3WDJ0VUhSTEQwSmtkRms4UzZSMVVPQkdlVzFi?=
 =?utf-8?B?WUpnanVGdFZteW41ZVplVk1uRHFMTzkrQmEwbms3OHJLQkdtTTdSaWljRThy?=
 =?utf-8?B?bVJjZmU5aUtuZFNFbnZiZnFwNzhWa1A3cVJtelY1YTMxQko1amJNYksvQ3Ra?=
 =?utf-8?B?S290SUtXVGNRcEtaZk9HbERSSGZ5VHZPSmlzYi91Skp4U0xyWVgrbDNmTXI2?=
 =?utf-8?B?bEdrMVBEemxWMzlYSFpteXo3aW5XWXdHYzFRZGZyRjdvbkJPUzN4R2N6R3FI?=
 =?utf-8?B?QTFLR2s4aTVSYW9hMXVvOGZBVUdoV3g3dEdkNWRhQXcxUk1WWTdsa0JRSWpR?=
 =?utf-8?B?Zy9iYkIrRnRseE5NYzhIYmtvOVVRYktLL3IvNzY5TmhSdXRkd0tEeFFKSVFu?=
 =?utf-8?B?N0ZaaEh3d1BrcjVIemtkTW05MGx6KzNlNXplU2NyeG1MRm1rdFg5cnZZS1ZC?=
 =?utf-8?B?NjJKVTNtWEkxaWxEekZKSHZFRzA4bm5qMDVBZDR5M0ZsazhUczBjWXFIM1NN?=
 =?utf-8?B?Z3IxQWVVOEc4d29pSStKTmZLalpzYU5JdXlFNmYyR3p1eEhGZFFhQ0U2dHoy?=
 =?utf-8?B?bEt4TnNBbnVXbCtBZGppWkplVGpnbWMzeXVmYVBYZVZRMnZsTFB5MytvUFFl?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f54639f8-6b27-4c11-5ea2-08dd57ee2f27
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 11:51:06.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6IS4N0srGCwnK1xegkbPyDRsuFBvNqClkpnFHr2/BCnkQJxhrMICoHFtUjBAgwGn+IbYazbXKK7wSWwo89QUNBL0XATUO8d63AEbJ5hbL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com

On 2/28/25 02:25, Jakub Kicinski wrote:
> Some workloads want to be able to track bandwidth utilization on
> the scale of 10s of msecs. bnxt uses HW stats and async stats
> updates, with update frequency controlled via ethtool -C.
> Updating all HW stats more often than 100 msec is both hard for
> the device and consumes PCIe bandwidth. Switch to maintaining
> basic Rx / Tx packet and byte counters in SW.
> 
> Tested with drivers/net/stats.py:
>    # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Manually tested by comparing the ethtool -S stats (which continues
> to show HW stats) with qstats, and total interface stats.
> With and without HW-GRO, and with XDP on / off.
> Stopping and starting the interface also doesn't corrupt the values.
> 
> v2:
>   - fix skipping XDP vs the XDP Tx ring handling (Michael)
>   - rename the defines as well as the structs (Przemek)
>   - fix counding frag'ed packets in XDP Tx
> v1: https://lore.kernel.org/20250226211003.2790916-1-kuba@kernel.org
> 
> Jakub Kicinski (9):
>    eth: bnxt: use napi_consume_skb()
>    eth: bnxt: don't run xdp programs on fallback traffic
>    eth: bnxt: rename ring_err_stats -> ring_drv_stats
>    eth: bnxt: snapshot driver stats
>    eth: bnxt: don't use ifdef to check for CONFIG_INET in GRO
>    eth: bnxt: consolidate the GRO-but-not-really paths in bnxt_gro_skb()
>    eth: bnxt: maintain rx pkt/byte stats in SW
>    eth: bnxt: maintain tx pkt/byte stats in SW
>    eth: bnxt: count xdp xmit packets
> 
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  49 +++-
>   drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   3 +-
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 213 +++++++++++-------
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  20 +-
>   drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  43 +++-
>   5 files changed, 228 insertions(+), 100 deletions(-)
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

