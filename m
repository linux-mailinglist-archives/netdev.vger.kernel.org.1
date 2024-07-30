Return-Path: <netdev+bounces-114071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1B7940DC6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5791C245B6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781618C335;
	Tue, 30 Jul 2024 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkuqvsuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E6189F2C
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332021; cv=fail; b=ZrcxNAGMAs5lyq8o/Jb8uczrYhGR7vn/WaQDkLnGugur6QtkQyWo4qqVOG9h71XK2J7zlYAa4Lp3IcMZkcDrAP9a2erFecP720mmLYVD6zWR6VVP7PV0OjRmGriE3trFmZuENWui2FYS9y7oq58Zfp8nt5uvnT4Qil8gKafFeIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332021; c=relaxed/simple;
	bh=5CBUo7TDA/8q3lhpWa00Zcm2n0ytlG8r5ClALUFoG8s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QoAU/mV0ZUahumKqIlh/w+BjwAGJ+nP5awcFNKBruNXcoEO8WCc+SmtFXewxjnNx7DWzkTrDQxGr7lsjCwONmIpJppqhi/51oBiN1GXd5N+UVLA+YyVh4NfaE3W3RKLtmnM4x1B6AhwMrLoDGzFWrBR4ZK9d7auT+y8JvYRkChY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkuqvsuZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722332019; x=1753868019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5CBUo7TDA/8q3lhpWa00Zcm2n0ytlG8r5ClALUFoG8s=;
  b=hkuqvsuZjQ/YqoUpPyHLxrD04oy+oT5UIZTsmAOR2ng9iLXzaRH/YmlF
   euKcB2k/wqxEjFKFJLPQXASMe7Gy3nzZEx8sQpwrtUCFezvsuMWcC/Avf
   K6JvXQWNS6I0IqxMrDxzt4owdgXeg9g/yDsqbWISu64eSix2Ox3kWllgB
   cEH6Nu7zot9DODXy1ggVomzI56Pf2c1Z6UoKyC9hK1BAi8YISGABWkhhw
   Kph1jjdaP84BpHCI+CCdOpJ0DxMft0wOCnPL8z4eERMjezlmCkJJMG9o+
   bgHHEDGZK57yaKJXD2Uj3hCuS7knYqk8AtO6QCfi95HTnYyfvfAfmcIXS
   A==;
X-CSE-ConnectionGUID: iGFBnb/ASk+I+6Dj8q9wAw==
X-CSE-MsgGUID: 4hUxQZEwQaugDYuKr/Y0/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="24000681"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24000681"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:33:38 -0700
X-CSE-ConnectionGUID: mTLMd34rSW61zDTT/jZMhw==
X-CSE-MsgGUID: IewfnblARC+M+h8K92BaRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="85228610"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 02:33:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:33:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 02:33:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 02:33:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMLBn4iSVH639NVQCnwV50VyUi1fTu/kiZ1wz3PYEYOFE4yBXW6UsRTj+VAioGczM+5Am6AvGZ+rGGs1rKqAfBzYyJ0d+BpgXxJESD6iaLXrOx4m8ggJB3Mmn9JudVVUPPXOaYGRAjFqVlVoxHeR0DZKHMHqGOs7ae94Uhi/YuqQy7BRz15hu0KEcybvFOWnAFTyxV0mWCg967unvlIhf7GvdX2p+JtcvOAM5/goLrjT2gu1TIX6aw5q0cJBwyRApV14kesS/uNZfsJC1EnQp17P4U7Lwdwb+P7ZqZd1L9c653VRmm+Xk5ug37fTaKxqc2Nex7i1DrE91QNu8mdiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUEnG1zJNJoiFlA7NyoWfJ1W2a+DLUq76H16XvC6fNo=;
 b=QrGUn4CBePRX6ueOOeCzYVOhGqMt+Ok6nRDQadLyD435HBVzGPoTUFH4GXKM9yY+ZnGZgMd0Dv1VVKNwYRgcR2yuSTu3nxr7nq6ew8qVhlb//EprrxydHb6JodZmizOznOteFcPUO9kO01mG0Mrv5QlzBegD2pIlRxvLlaUeyONqeXh2zadOosSo+mlBqtvtmJiX0ggvHnXeK/sYGNummFhfCg0u8FGeidzTNpoucRw0YvmL8noEgT7nvm1wiy0lzT4+WBrsbxO2nT86KFccVd/Igs3546BDCZZFrWB5l2JQ+VhuBvdxQN+fsYhU4F6/OddM3Pa1V9vUwRGuAzVHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:33:34 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:33:33 +0000
Message-ID: <2b1253cd-a75b-4ced-ae97-40c26395933b@intel.com>
Date: Tue, 30 Jul 2024 11:33:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/8] net/mlx5: Always drain health in shutdown
 callback
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
 <20240730061638.1831002-2-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730061638.1831002-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0216.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::7) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: fd60cb37-c1b5-4f8c-fcb8-08dcb07aae24
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0swbVY0Z29pNFcybHRMQXlVME5KMlZ4NTMwcFUvc1I3QmJ3ZkhZRlNsYzBj?=
 =?utf-8?B?bGZwWDlIRmxVT1FKZklOZC8rQ0VRVEFHUkpEdnVhOERtYnhMUm9LTVlJRzBm?=
 =?utf-8?B?amJQT1pQNU50VFZ1UEJwYytQb1M2UHFaWm5XY0FFTlZSWU11bVZMa0pZVXBu?=
 =?utf-8?B?d1hORFluQUgxOXZhb0RSQjUwVDZ5ay9BMWpvZ0dSY2pxaUhqQitidU9nazcx?=
 =?utf-8?B?VjFUUE9MeFBIaElGNG1BMWRWVjlKMjZVQmpCaHRqMGVaOVpDQkFBcGhXNXJx?=
 =?utf-8?B?UlJZRGpLM0xnQ2dQTE1wOSthbWRCUVBheldHaWNGUXIzenRRTkhWK0RXM25V?=
 =?utf-8?B?SW1QWkhLVDgvS0pTRUxXT1MzOCtFcUxIcUVIQTQwL3I0Y0tVM0RkNDhGcmxG?=
 =?utf-8?B?SUJaQWNBdVJMOEpDSFlOdEdXN3dJVEdPU3dSYVQ3SDRWUHFjdmx4VHRiWURi?=
 =?utf-8?B?R0FmeEt0Qy9KSUMvRXBTQ2ZqUWMvTnhvOVZQcGJSQ1lBbVdyVUUvOSsyYUc4?=
 =?utf-8?B?cWRPWTd1M2kvcWY0QS9Ea1RkSWpsNFdQZElBdXU3SnFNdkF2Q1hDcTV3U3hx?=
 =?utf-8?B?Mys0Q2tiZm15VUl0YlRGS2YyZ2lXK2NvNkh0MmV0SnJZV1Q5emJydUFYQnFS?=
 =?utf-8?B?QjhMcWRLNndLMW5yU3dscjUvWVAwcExCN04yYkJSWm5HZGdFcGlqVkhMQnFY?=
 =?utf-8?B?QzRvb01QRUlpRWl0WU9zUUFBNzlld3g1VTFzYkxTYkIxSmpMc29IWDZIOWUz?=
 =?utf-8?B?cjNLUDJiN0hlZG9PK0h6dmZ6bmYrQ2dkRGk4ZC8xOXhvK1JSd053TnlOSjVv?=
 =?utf-8?B?RHJNRkdSbVJuS1N3VG02cXpsdXZ2YnErQTB0ZWs3YlM4K0dsV2FCb0Vsckgy?=
 =?utf-8?B?NDB5TXlUUHc2NFRCb2RqbGVIbHRCc0N3czJ2UG8zYUZXRTZ6cmhacnhCejVP?=
 =?utf-8?B?cWd2ZE5TNWw4cE9TNGxuZ3A0NXZoZVI5dDNSTkljRWRiMFhBS1BTU1VSeFVn?=
 =?utf-8?B?YXE4VmR3SlZJTnhFaWZLZDdOMlVLRzV4dDRSTENHYjBzUGdOVHUweWJ1aVpQ?=
 =?utf-8?B?WG0xM09EQ2JnQy95d3ZxejY1Z0VCUGpMRW5EU1p2dHJvZi9TcnRlMnN3b1pV?=
 =?utf-8?B?RHR2bGFTVCtRSXNsMkp3eWk4RFIxeXFoNzViMVVuMlRHTUJUbzRDeDBQSmlX?=
 =?utf-8?B?YkJ2RmRqak5vaE9tdzBEUkRlem16MkFMOHROWnVrNEJUNmtLTldQQWh2M0hX?=
 =?utf-8?B?bG1YczdUQTFaaFJRNGxKQzlhcmJucTZtZ0w3MW9IR0xBOFlLeW81ZVFSdTZP?=
 =?utf-8?B?Y3pUWEZmUkVoTlVjMXlLZEdwdVF0cnNxK0NxWVZEY3RrQTJ3VWM2MmwxeCtU?=
 =?utf-8?B?Myt4TjgzTys3ZS9POUNLa3I4VmZtY0lXeGFWeFRrYWhVRzhGclUyRllLRHBv?=
 =?utf-8?B?TVZ3bkNpQjdEQU5UeEw3d21XeTRNbGRyYzZ6LzJzbVdZOHBkTW9uVjVWMjNP?=
 =?utf-8?B?WVltcUtzV29jTmJ3M2k4OGMzaVZLOHJBb3J2SVhoQVdtTTRndEVPR0I0cG54?=
 =?utf-8?B?YnRGWjhKKzN2ajJwcDZrcm9CdnZPcXhhM25QUXpWbFo2NURzTG9EYlppdFdT?=
 =?utf-8?B?TGxmaXF2ckxDc3pNZTA2YkdmdW1ZejZnN253ZldaT2JDcmkvSi9INm9LMlhH?=
 =?utf-8?B?UVQxWURXOWhZYytSNFdsMktzVXdCK2VzOTdIM00xanBQNkFpejBNem5nQ1Z3?=
 =?utf-8?B?Y0o0ZWdXVkhCVjIwMnBjRjZnWG9qUmxEYmxEemp3RWFmVXlKK0NaT1FSQWRa?=
 =?utf-8?B?b3k0OFFDVWw2YXlESDlUQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGozNlVnZVF4a0cyN3pBdDVTaG51c3BFc0hkSFVpSFhTNlVuUy80eHp2djdL?=
 =?utf-8?B?NEJqMWxhbVlPM2w5YjlYSWdvMmRFZUhLVHJtcW8vbDFxeENEenN3RWVtdVda?=
 =?utf-8?B?RWRDT2hzZWJzNVQydERMREUyenFMSGhzV05IS1hEdGpENDNURzBUa2pxbXd3?=
 =?utf-8?B?bVdTK1M4bThtaDRjN2FMUU9UV2dSUk1uZEIwQXhCVHhWU0Y0N3NIMnVIWTE5?=
 =?utf-8?B?NysyZ2hRMDdrcktBckdqYzFQWEVTU29UTG5KUk0zY0tRaXU1Qm5mcmVvbHU3?=
 =?utf-8?B?cnczQ1hrYm9HWGRPQ2U0amhoM0xBYlU2TVlCdStXZWJ2bTR0UVo5Y2ZFZGpw?=
 =?utf-8?B?VGk5a1QvNlRSYWdjNklJSEUrM0JrKzJEZXgxWHhiNTNDVU9UQ1Y3Qiszd3gx?=
 =?utf-8?B?OTJmWk84TGNTYzFjWm5yWGxCT1VCQnlCUmFPeEpvdHhsTDNINEloNWljUWlz?=
 =?utf-8?B?ZkVmRm8vNUk2dEpvQ1A1bFBJY2dMMUFKL1B1VUsxaTI0eEFWK0NMbFdKSy9w?=
 =?utf-8?B?Z1JxdWtEbDhqTDZOMU45dzhFSDBUa3VMNDFQMEptakJaTjdWbnRSOTNHZ3c3?=
 =?utf-8?B?YjJ1SmtzU3BNeldRUWhESmRmVFZMU3h0R2daamxEKzIxeUMvQ2IxZHFLb1Qr?=
 =?utf-8?B?RW5GRXQ3MmlGRThDbkVveEFndm84ZndDNElQZmlVd3VORVp6cEJ5L25pZkcz?=
 =?utf-8?B?emJXcDdicnBKSE1VbjBxaTFKU0tBMXZ4cnlRZFo1QXExU1daTEFQT01aeTBr?=
 =?utf-8?B?clNQZ1pZUURncVNxS3V3VUpZZjdmRWdFZ1F5NUhsNHQ5SmtTNW5rVmV5STBZ?=
 =?utf-8?B?czdLUzVFdCt4eWNBd2YrcjJKSVhMRVQ0ZkVCMFNvZ0laVEdJOGNQeVJZOEhr?=
 =?utf-8?B?bjFuejdyQ2x0Zks0RzNrVGZCM05qV2NSUC81NlFqa2dDc2xoUnU3bW56UEZ2?=
 =?utf-8?B?UVVIWmZFNkY1TmJQMS9ZNE82QTNNY2kxcTArdWVrRUk0V0p5YTdFTkdCaEY1?=
 =?utf-8?B?Q2pnYXp6MWdPWkgxaE80L3o5WXBPbFRFWDdGUkxQVVhJbzQ5Tk5oTGl3c3Nw?=
 =?utf-8?B?Y0lwc3hSdms1WVdvMy9CQkdkdEVEaU4rNldJeDVBU05wenQ3bFFNTThlYSts?=
 =?utf-8?B?YSs5a2V0YzZIQ01TbFlQalVVTnArNkt2c2VrNjVNM1AyK0h1R1lmYU5YRGE2?=
 =?utf-8?B?Vll5N2RTa2V1aUErU0NZeTdpejMxL2Q5RDEvcWFUVzlnSlpFRW0xQzNUQWNn?=
 =?utf-8?B?M3F2K1BER3ZsRUdUanJad2RQZGF4WlJOSDVBS1RYUzVVTWxpd1FwcDZaZUFL?=
 =?utf-8?B?Y3hWN0l6Y0lGTFNrVnh5Y00rdTRmVy8zU2crV2JpbnZCc096LzR5aUI5WHNX?=
 =?utf-8?B?VFF5SzMyc3R5UGFJblEwbkMrS1phZGRGYmthNm1FcU9wTWszSkYxVE9rNlo3?=
 =?utf-8?B?N0UwdjAyTGcvSm5Sd1p3d2VqM0h0aTVRUjhqaXBpVmIzYUdSei9QNXRzMkFv?=
 =?utf-8?B?L2hNbURSeG1uREI1MEJReDlmcFY1TjkvaXcvdzF0VDBXZGM5dmRTaDF4TVFN?=
 =?utf-8?B?WU9KZ3g5N1Z5ek1KbVUzdzFJY3JmNkpRRHpqWm50Mnc0dzRkKzJJME5KOTJh?=
 =?utf-8?B?MHRUamo2VUczek51NDFqQm1Vd1dJREtzNHU0U01xMEF1TlMyaGpaaisrM0xR?=
 =?utf-8?B?VHBwVnlNdkJSM281YlJaT29ZaWNWTG5XSHhyM1dKbzZLbXdOc3B6VnRwekZa?=
 =?utf-8?B?UmxHU0pnTTBjcU5lTVNBTEQ1VEpQRmIvL0pabzhGOG1tSk1zSDVtTlRiSnNt?=
 =?utf-8?B?OFkxTFIwMWJuMWY0UFBYaExUU1hPQnY0enFlVkxoTWtyZlBSTzNyOXhRVlA2?=
 =?utf-8?B?YXJrSkJnS3BibXRBV0lZTDE5N1NjYlZJcUlLbVJhL2pNZ2ZPb0Zlbm91cFhr?=
 =?utf-8?B?MDhlVk9EVkJDeVo0OWx3ZDhmdzN3TWJsQ2xRQTZMazFiQjVGZ3FrTHRWY2lk?=
 =?utf-8?B?K2dQRFh6MjFhK0tocWtqeEd0RXpsMzIrNnVhK01QWGtCcFI4dVlpRVlxQkw4?=
 =?utf-8?B?Zis4eURHeUU2cXRkcGhrVlZ0SzB3NU41MDRPbmdXeGNUVlpvQjc1ekhaNnBv?=
 =?utf-8?Q?Fuvelyke0orb3mT20Np0WGDl4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd60cb37-c1b5-4f8c-fcb8-08dcb07aae24
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:33:33.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KvRwzKKz33rY/Tl4HvT3UCMTmP6bCVvQ07h5kfMT77neGnSkcUy8DMy/lk9uP+5y3FWH/f175NSTdju/+magTYYHV+lcHvYplmI30Y2Ajc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com



On 30.07.2024 08:16, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> There is no point in recovery during device shutdown. if health
> work started need to wait for it to avoid races and NULL pointer
> access.
> 
> Hence, drain health WQ on shutdown callback.
> 
> Fixes: 1958fc2f0712 ("net/mlx5: SF, Add auxiliary device driver")
> Fixes: d2aa060d40fa ("net/mlx5: Cancel health poll before sending panic teardown command")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/main.c          | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 527da58c7953..5b7e6f4b5c7e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -2142,7 +2142,6 @@ static int mlx5_try_fast_unload(struct mlx5_core_dev *dev)
>  	/* Panic tear down fw command will stop the PCI bus communication
>  	 * with the HCA, so the health poll is no longer needed.
>  	 */
> -	mlx5_drain_health_wq(dev);
>  	mlx5_stop_health_poll(dev, false);
>  
>  	ret = mlx5_cmd_fast_teardown_hca(dev);
> @@ -2177,6 +2176,7 @@ static void shutdown(struct pci_dev *pdev)
>  
>  	mlx5_core_info(dev, "Shutdown was called\n");
>  	set_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state);
> +	mlx5_drain_health_wq(dev);
>  	err = mlx5_try_fast_unload(dev);
>  	if (err)
>  		mlx5_unload_one(dev, false);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
> index b2986175d9af..b706f1486504 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
> @@ -112,6 +112,7 @@ static void mlx5_sf_dev_shutdown(struct auxiliary_device *adev)
>  	struct mlx5_core_dev *mdev = sf_dev->mdev;
>  
>  	set_bit(MLX5_BREAK_FW_WAIT, &mdev->intf_state);
> +	mlx5_drain_health_wq(mdev);
>  	mlx5_unload_one(mdev, false);
>  }
>  

