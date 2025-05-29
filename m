Return-Path: <netdev+bounces-194158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD04AC7985
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA06A23FB3
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 07:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7422459DE;
	Thu, 29 May 2025 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dn0blOdd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD119CD07;
	Thu, 29 May 2025 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748503169; cv=fail; b=tHDO4XGCp6+iiZaVCfQGQmfF9SrrHAFZVNzZgimUHCT5hDO3cQzOKtYN2MPDPDjsjsGwcJ+Ps8yHdnrjPRGhww4HxGVe6PRn9G3a2w9+kLGkxV57WzbuPaJdjYIDKeP+3RRTGGUJRtoYP3hTyTfGF2y6xFdyzI+UfZBMlmKMU+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748503169; c=relaxed/simple;
	bh=mkgksR02Qc5EA0RKaPqf98pQWAfNTqfzjN9uSxWO1qM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bL7F+ceoJcpqNfOTfSUU6JdC/u/lK4WpOpXXuaw9mq9IvY5vW/iwfj5YVLwXM8kr29Uc9qJRpRLUvtq+dLSK8m94fpce+ZjFbboPJTSQ7PD3zHH2DMHIU8aM3ueYx1RHylBGrHUywcpHQ2kXOM5JQBxjfwuXgMdujfudvulzPik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dn0blOdd; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748503168; x=1780039168;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mkgksR02Qc5EA0RKaPqf98pQWAfNTqfzjN9uSxWO1qM=;
  b=dn0blOddks6JOuUOtWvKW3Wl+oOySSsqJdXq5sgEjSFfbCSyD8t2LMav
   lgyoA3/T5QvOlnbbOhJPEyYdCYGtrxmb6F9j3gRavVOMhc8gfrislmjwq
   E2Mbl5+6Li0g43Pt2raRnDck1dtNYqKQCZfMuiDDidSAUeMCWCDm5Phjc
   +k/Y1Z42MpbRUnS+N5yCDg+KPyfo5cs95I7LEzepmiueJEuea2yzj/Ks7
   mqFtgPrZL6oO4/vUTpS3UHxBWapHbj9f18IiwI4z8z5eATLp4KPTeGoDb
   QV15ng+v+euua4l9f9Hs8aQ78BhL/t90FZqy+eeHkiFqcN0a4a0fv9lzI
   A==;
X-CSE-ConnectionGUID: sj+1Kc2MR3ObECAVRwtUdw==
X-CSE-MsgGUID: HH30X0wXSOa49sSx9tMImA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61214272"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="61214272"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 00:19:27 -0700
X-CSE-ConnectionGUID: euTFOhGnR3e6pUmwLzGNpg==
X-CSE-MsgGUID: jbHiHqRfQYWqV9XE26aYLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="144455364"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 00:19:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 00:19:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 00:19:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.74) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 00:19:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYC0hcoxJ6mN28B3Y1MjaKCOxk1Vlptt+IC4lGw/kaUb3lG6soMhwQLJ+t4ZzreVpRex3GSNte1q8nXpevovsigWLd3leVRZ91pbdscQh+NnNxv3PmNKYZzTpRH/wQ/cqd85++HUJg2n53w8g+MGSk/nDdxgq4PSx0pC/9V4wD48JbCUA8ttSaxWtUDsgkld2TVCtFz/bke63CcyahPzJnjyaHFmThIQvfBcSdqyinhcweFnwS/PYH8gjp4lh7siddiTGxloHDQChCVOMjzsFbPgxaRPeVSftJF3TXkh6HGexrn6D4AcJiRcub54T6j+QAjhbVAeranUco7GfHNbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HluW0/J/2RWvSge4hzAfueE+301iHpem/lZyoa4+wSE=;
 b=BGrV6PbPccIUvLORNlCikbb/iDYX5Z36cfSYD4iM0f7vBDMpfuqnz6iL0IuR7f1ujdK1QutNAlJ1+CUkvOqYNE47C7OWILB4DobfOD/UXhg4RDQKQxU9xAMniaF5NX1NoRRb40lagC5ZcxUn61j7PNkwpnJLs3jaNVtX1MI4KUYIdfrFxbOjoDKEBlOOue0l+SuP8alqsYHEk9jzd8TuS9s3etQFRlk6mg1DRhBd4sDhIytQYmy86hvbpsqllLOkRD2/3yRkdUfYbLTmfjUEamxzsao6E+6sTxJdjnuzK27hRgQ4DUUXGH7BEYSyKzXggc0HnXu9eZ9H9HOSIUBx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 by SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 29 May
 2025 07:19:22 +0000
Received: from CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14]) by CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 07:19:22 +0000
Message-ID: <592a8212-dbbf-402e-9b11-f4edffaac8be@intel.com>
Date: Thu, 29 May 2025 10:19:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 2/7] igc: add DCTL prefix to
 related macros
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>, Faizal Rahim
	<faizal.abdul.rahim@linux.intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Chwee-Lin Choong
	<chwee.lin.choong@intel.com>
References: <20250519071911.2748406-1-faizal.abdul.rahim@intel.com>
 <20250519071911.2748406-3-faizal.abdul.rahim@intel.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250519071911.2748406-3-faizal.abdul.rahim@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6307:EE_|SJ0PR11MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e31409-23a6-47dd-96e5-08dd9e81225c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU92ajFlSVVZbHhUTnUwWS9SdlB1YndQbHpQVWo0Qk11cU1ibWg1cS85WlpY?=
 =?utf-8?B?UlNQZE9iM1J1WDNXS2NlRGo5aWdQWmdBZTZXelRkZStZeHp6YTFzVUJtM0RN?=
 =?utf-8?B?RGpUaVptVkYzUVAwckxQM205WlFNN05Qak5mSG9NeWJuazV2LytvUFJnZ2w5?=
 =?utf-8?B?U1YxZndhdjI2S2twMThWcmF5NC9JTWVjQXl6bnNZK0tNd1d4Q3ZBd0tUWXhY?=
 =?utf-8?B?aWxCZU9yTkZXVjF5cW9uUzMyR0VKUVkzcXdQbGJWUFhBQUc5S201UVl1Qk9q?=
 =?utf-8?B?UjdtOW1ieTlRVnUrVWljeVlzRWlLajZhcEFpU3ZuTzhPUmVNSEloWG03dlFK?=
 =?utf-8?B?eVcySjZhU1hOdENJNG5MNHF1UExnSE1uNEVNZWVjMnZCazRMODJtTE5vdHU4?=
 =?utf-8?B?OERRV2V6Vk9CYmlRMWozUEptWW56Ry9NRVF3UGlDYkY4WmpHUVhCaXVQWlp5?=
 =?utf-8?B?QVR4cUFYL3VKaERnTENYL1I2SGQyWXgwcjBFWFVjUmxkd3BMWXJXd3B2NzM2?=
 =?utf-8?B?N2NZZVFibis4NEdzOStTaEtYaHZETmRkRTBPYW53bGtwb0krK1RJWTNJaDda?=
 =?utf-8?B?THA0Q0VndUcrRU1QRmhBNi9nVVduTjUyR2hsb2V0UFNwdWc3ZTBQVDRRc1lV?=
 =?utf-8?B?cU1LNWk5Smoxby9OTjBDamoybUVXSnpya2VLd2w4TlBlOVMxUGJKWWtmTlRU?=
 =?utf-8?B?aXhpUUdwaXQ4SnluYXFxOXd2UVVrY0hvUHNXRFhmYjN2dDVwU0tzV09Sd2tJ?=
 =?utf-8?B?bkdZMHZnVWFNKzh6Q0MxUXdpYTN1RnpibXczUmZGTWlrR1hEeS9hVUwxTTB0?=
 =?utf-8?B?UWdLVmlha2RFcVVEV3dyVE5TTGkwQUZtZjFsNGdZNklSTFhhdEo1Mjc5K241?=
 =?utf-8?B?NHEyWEh4K0N5OE5zNGtYZlVtQUJuV1Noa1B0Z1E2aTJqRmFxUE11czRTN21u?=
 =?utf-8?B?aE1INm9pa0pmak94YTAxcVhEMGRZNWFJYTg4UFBQRXdtSi9oZnZRbTZyOFNJ?=
 =?utf-8?B?MHJTWTJrRDB1REc0VGROb3ZXZkFweFk0MnUyMXQvZlQ3SHVSNkVHam4waVNh?=
 =?utf-8?B?RXJiYmg5U0paNHVzc2pWaFg1eTVsTElXamlSTHJjWkQ0TUdsSjhjYzhnVjV6?=
 =?utf-8?B?Ymw5VEtmQ1dxTTlHUFV3WVdYMlovai96eUtZbnhDei9ISDFSeWJoTGw0UHhu?=
 =?utf-8?B?d1Z4ZWtGWGx6U1czSGp6SGhuaWRQOHdPWmp5NDBGWVdJb055NWFzSXRTdFZp?=
 =?utf-8?B?Zm9lazlFTFl1amhBeDhtdHdCY3NaeFVnRlR1czFNZ1UrdTlZYmZMSjZkckIr?=
 =?utf-8?B?WFovRms2WXpzRnlpaUhQTmJ1elJ3TndKaTg4b21xM0MvT1hINEdWcjIyUmF4?=
 =?utf-8?B?Q29qVEhvNlNQZ282dmY4S3M3NUV0bkI5ekp1Mi9ackllVEZUai9hRytPZks2?=
 =?utf-8?B?TCtrUlVnY1BuY09odVR0eVpYZTdTU1RzY0NrcFd0QjVFejd3cnJud0puTk5r?=
 =?utf-8?B?ZXRFejgwV2Y1KzhtWkdZZVROVWoyUjRVQjl1L1UwelJ0TVNBeWZOVWNWYXBT?=
 =?utf-8?B?Zi9DdWU4Y2dBbVl6STUrb1JkMlRWWVRaVVVsOVAxZlEwQ3dvMlBZUjJ6ejFs?=
 =?utf-8?B?TFhXcG9sM083VXliUjlhSy9lUDVQYmZxeUxVcU94RENUNGtpUCtHOFRSOGov?=
 =?utf-8?B?SGtaaFZKYjBzTXU5SVpiN2loTjNLenR1Nk5DZERlRUQ0MjZsOHNWK3pGVDB3?=
 =?utf-8?B?OERBYUJCbGVpdksvdEN4WjdJTkJZaStmR1JQN0NBTlZlbi9saFQwRU1sdjhl?=
 =?utf-8?B?emNmTDA1NEh1RzI5eU5aMXJsWE5CSmdYenRELzhNbzNJUkdZV1ZCMTEvdE5v?=
 =?utf-8?B?SXBmcjhYRms5VHVuOWhwb25ZKzJqOWs2L3pVYkpOa1FXaDE0dlRxRWNaM2pN?=
 =?utf-8?B?WlozbHFyTllkaUhzaHNVeEFKYzQ2Z0VOSFpsZjgvSGY0WXorVkJKUnhjRUVr?=
 =?utf-8?B?S211dlphZkd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0Y1QmZZMy9QcDJhUFVZVmFJYTZFUW9DMGlxdGlncXExNW1NYVQrV29FWHpu?=
 =?utf-8?B?cmg3NWpaZTdPVkRzT3NucjZtWk56d0JINnNkZEY5QWNwdlg5SnFrazVLVUVr?=
 =?utf-8?B?VE45OTJoZm5uODY0N2ZqUmFqaEFRSGhQWWhjV3VBcTFRNytDOFlmaWhWWm8r?=
 =?utf-8?B?TkdsWDFoeDVwbEx4T2NmRjZPTUFSdk0wR3BsdFlZNFNacXlOdlY5am1oNjNQ?=
 =?utf-8?B?d2g5bjNCRHRTNkNFSnBJcGtmRXVWYmt5ZVVGU0dVZXNpajJVY0RSbVBWQ05Y?=
 =?utf-8?B?RXlWZ0pSd2gwUnlTcjVVWmtwM2Q1V3RMdG1TNXZNaVFqMk93UlI4OTQ1SWho?=
 =?utf-8?B?NVhqL29Uejd6WG5vT2IxdVFOdjVxejE1d1FKZXBuVlo3VGZlUGhYais2aXJ3?=
 =?utf-8?B?VnpBdGtCSytITVFLRjluYkI0SEE4bzFmNW9VdUFNR1AvTnp2bEk2Qzk0MUtB?=
 =?utf-8?B?RjRNNEtBRHkvV2RFZFppbndLcnZFRkxGWE5kUWcxQnc4djRLTWNDVzd3MElG?=
 =?utf-8?B?Rmhqa2lrUzVCRlBiaWEwY0tHZTk0V0ZJTkNxNDJmSmpRSXErV29BcnJZYW5L?=
 =?utf-8?B?Qi9TQWhQYy9mN3JHYmxMelNLbUV5dTFBbk1ZNWhEYjAxWVBoQzduOUpXZll5?=
 =?utf-8?B?RTdPWUFhOWJ2cFdDcmJFZnNXVE1WVkxNQmNWL1JhWmVxMDkrU2w1UzAzYlIv?=
 =?utf-8?B?N2RveTJNM283WURLNHJjbkpRdnJyUG9OaC9SS3lTMkFWMFlidVlRd3BUY2J0?=
 =?utf-8?B?cTBDNXoyaUwrUTdNTThKejVOMGlaSyt1bXRNaFpyaE5zZy93WHJHVm81SFFS?=
 =?utf-8?B?Sjh3MlFJRmlLZ2k1amhCKzNOZFRSY0VmcWZOcXVvemo3bUlUSUY4dm03YU84?=
 =?utf-8?B?SVBJZ1hqc0hXZFpUcEdUaUxZbVcxVnVWTEQrK1NMNWJMSW1IbElWRlhYczZY?=
 =?utf-8?B?UnNuNStTSkJZMUtBQWJ0UWptOUd3SzQwUHBKd09sb0RzSEd0bkhWUTZEcVZP?=
 =?utf-8?B?dnVsLzkvM1JORHdHZW05dG9aWXlXRHZ2emF5VFhTa2J6WXNKUGdpUmxiSi9j?=
 =?utf-8?B?KzFpOTloampMOFhYdTMrMC9waDllZklwZzJlSlJnR2hlM29LS0NjZHE0UGdR?=
 =?utf-8?B?RmpVYVFxWmw5dmlWeG1MWHFpckxZUS9RQTZILy9RRFJHY3NCbW5tRkl4b1Zp?=
 =?utf-8?B?RmVWbjdFOGVBSUl1blZhb1Q3M0lhZU82TDZZQVF4ODFvY29pckN0RmNLSlNn?=
 =?utf-8?B?bGdDTERwazlLeUZmRjVnYUFib0ptczdlNExBMHJQZkVGRFVQYW11bXVlcUVi?=
 =?utf-8?B?UDFMOXJQajZjNkVvUTh4Uk81WHRZWWtORXhGTHE4ZVlGVWFDaGVZeWZ3bGVD?=
 =?utf-8?B?N2t6OTZldFFTaEYwdEJOVmFZNFdqU1VhWVFOYjJIVUNNVTdyZnUrU0c4Qlh3?=
 =?utf-8?B?MFhXU01hOTRRVEkyVm5kaTZpTDJGQmJLdzI0ODRhUDd3V0hGcW1qUm9rMGNk?=
 =?utf-8?B?V2Z0NHRrbDNXK3BIN2hTZDhiYnZDV1c4cG43eHdzU0d3d1EyVTNOcFZ0a1l4?=
 =?utf-8?B?K0hGUWJjUTh4TVRZL0RuMlFlMVR0YmFKQWpodlliQnoyNGJpSVpNc1lOVTlI?=
 =?utf-8?B?dnZ1UU5XQ1lGTEVpd0pVNWN3VWx5eVVjOCtYcXZqaHlSenIyc1N3d2RyVUFC?=
 =?utf-8?B?cDdNK0dxYndCTm1xMW16TWxrZThQQnRzeVRuQlREVC9VT2g3UWkvaTBOOFNn?=
 =?utf-8?B?amhYTy8ydTZINTg3WUgza29GQy9yWDgrc2dZZkpwamdGa25SMlZLdklTejRl?=
 =?utf-8?B?UlE0RUc1bHlwZDVrZmRQdGVYaTQ1andTRVV5MVEzamtjNnJDelVwMnN6Zll0?=
 =?utf-8?B?UEhLZmxZdzhuMTRPK2N6TnVyQjJBakFIZE95MWpjS0VLMjMvWCs0MStpU1dR?=
 =?utf-8?B?elVzRlR6djVOZlA1ekNCWk9KMHB0N1F6OWF4bE54SWFhQVRDVzN3cUsrdXZi?=
 =?utf-8?B?OVZjTzdtQWQ3bm9iS29wUStoMjlWZHVQeEVEOFpDcHFuOWpkbVlZYkFVVDR5?=
 =?utf-8?B?VGJYTEdWV3REOHY4bUE3RXNTVndDM3pFdnJYL3cvWWZqRkJheGVlQTRMOG12?=
 =?utf-8?B?bnFTanFlNUsrcDF4NjJQZHVRSGpHN2dOQVNPSU54dTAxU2FqcklnOTFaU0du?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e31409-23a6-47dd-96e5-08dd9e81225c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 07:19:22.3801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p3f53qEfRCnHc1ASQUG2/ecl5VBxpDzPBNM08/AXmvDX9rMp/r+xTmByiqN8OARn0BIwXfVIxknFmxKSqymr8238XRp+y6EJumGan8EBSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
X-OriginatorOrg: intel.com

On 19/05/2025 10:19, Abdul Rahim, Faizal wrote:
> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> Rename macros to use the DCTL prefix for consistency with existing
> macros that reference the same register. This prepares for an upcoming
> patch that adds new fields to TXDCTL.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      | 12 ++++++------
>   drivers/net/ethernet/intel/igc/igc_main.c | 12 ++++++------
>   2 files changed, 12 insertions(+), 12 deletions(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

