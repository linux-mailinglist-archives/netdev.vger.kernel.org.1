Return-Path: <netdev+bounces-223064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5FAB57CB1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FA07ACDC9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6108531326F;
	Mon, 15 Sep 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMM2JDst"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF09312800;
	Mon, 15 Sep 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942328; cv=fail; b=jcKtofxfK1saRgotoApu52tNcUCUztOQVxF4/p19mXHDt68tFoNRzXxE3i/BLJ8oV+WiiAa11bZ2c8D6I72NpTdpBQj3NB2kRNj8qNa/XD8QpW2OKADCNmqg3LqDfR6mJ/8AmoUGnNQUkfju+gaFdW1WDilJRQNoBR1ii+6gOzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942328; c=relaxed/simple;
	bh=cn0lvToAVhg+5/zdom3c1tjalkZy1sVIh94kga/81Fs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o2/6dHl4lezUQotmwtU9K72hCwnwtjlS6yRfF0clABlUsZ8GhHdsl81Y8HgOAfdj7wVnBvJTGbqgR//T0GQVCjohyHasGioOE7u9lyrju40o3o9tdcsFi+t0pv1aN2NGZP7qMg1gizb731aKo9OJQIAx9tYNoZ97C3iSK7OOXnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMM2JDst; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757942327; x=1789478327;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cn0lvToAVhg+5/zdom3c1tjalkZy1sVIh94kga/81Fs=;
  b=aMM2JDstgS4HHc0mh+uOcfoS3X1IzOSGu1bi0FpuPCXQOelGm/xTBFxj
   Hiz+2T+OfjKXKSvChdmiKVdhpkT+w3VEQ1iQSQBVIEFwDcrKoWy+RB1gY
   0W6X7YKb/xpn0Dwieiaf/U8vQ+LCCbSVDKqZYV8mcCF1+8xodLM1rMXl5
   fUYffGiBwqHysWYL99nfad+vTFm7/TfJb8QcPThr+1HyT4Jf3BOICcw0c
   0Dwt1nErf0EQtdvTF/7orJzazzR4ontpWVL/ofkBVn5tGN5E6BlnrDCFG
   cIJBq8Nxrqw+GQl/jUZAFA36FpwyZzeozjE1S+Iu8e57/6zoviD2Fyb9T
   Q==;
X-CSE-ConnectionGUID: X+b6QWc9R3asrRQ26zHV9A==
X-CSE-MsgGUID: ImtyMphLRHqq6Ku7KePDdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="64012604"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="64012604"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 06:18:46 -0700
X-CSE-ConnectionGUID: K5nrro6pTJS1769hmTFxtg==
X-CSE-MsgGUID: XYQCV9mXQzawA1urMEFAQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="198331959"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 06:18:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 06:18:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 15 Sep 2025 06:18:44 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 06:18:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTMwcndSnTZYvn1Mez+WBpb194QDWOh/ECage1Mrtf2Wze8DHjTQmTOhlRlvlFRpKJUMymng19xpG7Tt+50SRe0emcEu0NAe3sGnECBfBsJnTZ58IxnLjznKCNEQG0krQho02CTFyec6MVUFuYMNpIgRK71mYXf94HZh7ETwOsA4WwZPBhi+dFOKu1ltayCT2zpWREpnr+3QqKlwK2AEEDo8LkgTqdftlR0bhhZII0KV+tG3iUKTG4Q4MQZm3wo38MI55ZCJHZXk9gDbjRc8NEyvwOpWMEw6dPMZZlZg+eBZFFHsad7qY7vGc5JCFeNOYa7aHQwp+sVXSoq8ebdWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jen3Ln4mIclGuhhUlvDiIEaiPdgJGiV9kPveKKx1ep8=;
 b=Ar1iorr3UTB7MhyGAZOGF7nmaBb0JrRhi5Yc1zwIGSFWfnnOgpWQgyLe6KlXfBHck+a0BcxIQ2SSskbMjXuFdo+Rvwa3XwoaHOnp65ppUzUW2F6qunKXiBPG19v1uq5rz1aR+MFAnIpWlAj8hHx3iaSxmY38Cn8aPkDNp3L0tyfVZb5RIQ3JhatyBkzrEu4tG6RUTb11WPNvG0YTISJFZfEcZ6I+jhtLgRAFknJGkYpCKf39dYfpQEkorPPmLpXANLFhUt5yAbTU4M2emnwHC0rBZun4+8d9Hv2Llw2xYJHP2qoWj96gL2NkSn4M6PYELEyIBz1wf1Hq0W01Xsa3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 13:18:40 +0000
Received: from IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10]) by IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 13:18:40 +0000
Message-ID: <b8a3e3e7-295a-4cde-9d2f-73b5df4200d9@intel.com>
Date: Mon, 15 Sep 2025 15:18:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: stmmac: replace memcpy with strscpy in
 ethtool
To: Andrew Lunn <andrew@lunn.ch>, Sebastian Basierski
	<sebastian.basierski@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cezary.rojewski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-2-konrad.leszczynski@intel.com>
 <20250901125943.243efb74@kernel.org>
 <b7a23bef-71d1-47e6-ab20-d8a86fa3e431@intel.com>
 <f6cac0bd-3a07-40c3-b07b-f1c7f3b27f45@lunn.ch>
Content-Language: en-US
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
In-Reply-To: <f6cac0bd-3a07-40c3-b07b-f1c7f3b27f45@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0072.eurprd02.prod.outlook.com
 (2603:10a6:802:14::43) To IA1PR11MB6443.namprd11.prod.outlook.com
 (2603:10b6:208:3a8::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6443:EE_|SA2PR11MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ec9e3f-7e8a-4771-76f1-08ddf45a62ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVNNSzJhWWM2bG1GV05ObnFIK1dRQ2JzbnZCWFc0T2MwOVJ1K0JsQmdBY05l?=
 =?utf-8?B?T1Bxc1gwUlUyL2RaZ3dEYjVTNDVmQ3gxdTF6T2xQRG1yM0lqYTYwV2dZQ0JG?=
 =?utf-8?B?NXZhckRNNGRnY0o2TnZNV2dBbEFnOWxENTF6dDdabVhtdFQ5cEdmeXhlRHJa?=
 =?utf-8?B?UGZiQnJGR2VNV1hTVHVZVzE5L29naU1LditLN2ZCYjhDMlRNLzNQWTRrdVU3?=
 =?utf-8?B?b0R6SlUvR2FYN3JJREVYNG51T1hmazEwMWZvaXZ0dUJVcmthNXc3TUlCR1g4?=
 =?utf-8?B?SnBqOUxoRXNXa3R1M3VnY3dPaC95YW0zMUYvZ2M2ODNtd1MvcDI5bXVxNVAz?=
 =?utf-8?B?cE5XTXZYVlliUFFONWs5ZmNDZ0ZtRHQwWG9RUWpGUFJjaUgxdnNscW9aL2FO?=
 =?utf-8?B?WUxPNWJ5NlM4eEJIRW56WW5hWlB3VzZRYUVSdXB4Nkc1UVE1M2JGVnk5M0pk?=
 =?utf-8?B?M3JtVGQ1KzZVVmdvdVA4YXZPLzlEZFd0K1JJQ3ozRFlmZFpSejB6T015bnZK?=
 =?utf-8?B?NCtiU1dzVFpRWk10S1dPT1JxK1p4b1o0U29ROTZZcmU1Tjh5T1J3aE42S3o5?=
 =?utf-8?B?SjFHTTAxcTcxbTJYbVdQV3NaM0VPRHRncFJIQnBEcFU4UElxQUwybUd2UnlV?=
 =?utf-8?B?UjA1Q0I1ZHRVTWlteEZOaHZmZ1N0blh2RlIwSUkyNjR4QTkvYm80d0kvcXZs?=
 =?utf-8?B?eFVIcklzejhROVkzZzJ2NFoyRnZ3UE9pRHpDZTBETExxNVRXUnFFMnJRT2JC?=
 =?utf-8?B?YmIzZFAzZUNRV0Zvc2NSbnV4OFBJeXAvWTgwTGZDVWp2TzlKRWFWdW5CTnFl?=
 =?utf-8?B?WDlLeDZoODM0cktaY1YxK2VBMlJXbUd3cVRoc295Q1U2cE16WGdSaHRRV0Jy?=
 =?utf-8?B?blI4cnF2NUdvMDFJdDM2RFY0OG5yNFMwOFloZnpmMzJkRktNTytqZnQyNDJZ?=
 =?utf-8?B?YVArbm1WYzRCQTREKzlRNndocEVnYU1tODNDL3ExYWJ1L0xHUXlFWi9jVHkr?=
 =?utf-8?B?OVlPbkFIQjA4ZWtKUW0yUXNhdy9LU0dJbE5HemQxWURyYjdMZDZiRFRmL2xK?=
 =?utf-8?B?TWszTU51aWRuQlA1MFkyZlR5b2RyVUJqVmphSHFFT0docTUrNVRrcDNJQkFT?=
 =?utf-8?B?UUduTE9mWEZ2bS9rVVo5VzAyc04rZGV3YlJkcDJ1aFZuUm1aMmFJRnhuZ1Js?=
 =?utf-8?B?YW83WGZlemtsNEpiQWhRMWNlMTlVMWp5ek91aFE1aW84TGpWN2ZPR0VjaERQ?=
 =?utf-8?B?SFZ5YWNMK2pvZ0JKYVFka0tzY2lUM210aGV2UDhuQ2FRWXFJRHQyOENoYjJ5?=
 =?utf-8?B?clBtRzVWTmo3QlpKTlB3ZEdkcy9PNHBFSlVQQzNBYUNkczhtSDkvRm5BVE82?=
 =?utf-8?B?RjNObGFxWFdhNEtxU3E2d1llN2ptY2VuT2MxWGFZdTZ1d2RXTXc2STNrcitE?=
 =?utf-8?B?Zk1SVEk1Zy9lMzFWb01YTWU3WklURExQajVuV014MU1EMDR3MWhua2VHUmo5?=
 =?utf-8?B?cFhEbUg0TXpZVGJZcHlwR1A5ckxJZUw5azZMckNLVzZpSjkwQmw0SlJUZUti?=
 =?utf-8?B?UjBVQk1ZRzlRVUhFTi9XanI3QVp6bjl3QVZKdlBLQ1VjenVkOTd3S2dTa0Ns?=
 =?utf-8?B?ckdZeWE0Z05FYWM4alFBTzVxbEdjNEhFUXNseHMydjBSR3Zod3Vnbm9qVnNj?=
 =?utf-8?B?VUdybEVYTEZobFd5a2RGUkkvN2tpSjRZQ1NMMVBnd1I5cGRMbEh2eE11ZEpI?=
 =?utf-8?B?R01XMHNMOW5OazBZRDkxS3ZFZDBTanlqUExNWTFDUkoxZGpNbkVETDBDWUdD?=
 =?utf-8?B?alp3OU5Eb3VsaUcxMXlGVHltOHZqRlpva05WSnh4a0dHV2htaDVYNVl2Tmli?=
 =?utf-8?B?UGpGdVVrZXFxT0lMTlMzVG9XbCs2TkRSM25MVDRCYXNDbmRmVGpLMmN6ZDd2?=
 =?utf-8?Q?yBSZSuk2l/U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6443.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(42112799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlRBMFhVR0FxTXIwOUs3SHpoSzdVa3dNb3lUbWlBZkNvNFE3blVhVnFrK3Fh?=
 =?utf-8?B?TTBxWEM1VUdRRnllUzl4YURzNzJJODVxWTMyVnZCR04ySUI1Y0V4K2xmaElu?=
 =?utf-8?B?MVZTeWNYVVY0SWR4ckJuZ1UxNVhlRG9hR3NIcStHOGRRQVc2OWxpUis3ZmFj?=
 =?utf-8?B?VFdNNFZoZEpaN1FMTTBNQjYxaXdubFFxU3BVeWdhc3pCMUk2OHNKV1NKWWFI?=
 =?utf-8?B?ZXljTWcxcnlsa2xyeFdiclUvMjB1WTRWbGdBWlNLRDVzMVpnVzdOL09WSzkr?=
 =?utf-8?B?TEYvSHNCdDBsclhRa3JEdXcvem85bVJYOC83ZHVTRVVDV2RPMUdEOE9zbWs2?=
 =?utf-8?B?TytjMERtOWhhUjBNSlV0cGplV0pQdmZlbzBwdnhjU2NIeUV6WWM5VERNR0RH?=
 =?utf-8?B?TExWVzg3UDBVekluV1FITmp3RXQ3UEFTQmhrMnZiU2U4ZWhkSnFTeWUrcFNP?=
 =?utf-8?B?RVBVU2RZeERsVE1mZzlyZzdydFpsNDBJV1ZHK01NZXpEVUFtazNkdXhEZDhx?=
 =?utf-8?B?djFCY3Y4SlF1czBvM2UyYUo4SjIwMVA1M3pKckdrMTdlVklsS2w2SkRiRlZv?=
 =?utf-8?B?NnlhcWNsRjBPNXlYaFJZbTYwOVdVR0VtS044cllHLzJUVGlDZGZSaWs1L2hn?=
 =?utf-8?B?RjN4a2pXR2JmdXVTeWRoUnNML0Z6SFNTOUVZamM5N1g4b3dqM0FZUVJNQWV2?=
 =?utf-8?B?VmM1VW93QXB6M0k4SzRTMXlmR3VXNHRwNnh2RGxKM09pR2VyazdKMXdNTkxs?=
 =?utf-8?B?Z3lVdTdLNWR0WFBOazlHN3NRVEJWeVZsaHBWUDJrVDFySlhoeVFHZjV1Wk9I?=
 =?utf-8?B?eTA5TlQrSG1Kc3IzZnR6akdEeWZIajVhWVB4cG82V3QwN3J1UmFpcjJ5WmRG?=
 =?utf-8?B?UmtMNlI2MjRRYlg4OU4rdGE2SHZVaDNhRzFiczZJdkl1MmhySDNxSWJWL3A4?=
 =?utf-8?B?ZzlUZCtsaEp4SXVHVWRkY0owWFlCM3dRK2hVRWRLVlVXd2hRSVFWbC80TGsy?=
 =?utf-8?B?MHBiMmk3RnBnNTYzNk9UYm5KTUx5cWUvK0gxME53bG5DNWlBVXUzc0RVMGhX?=
 =?utf-8?B?cUpUSlFkMW1CMVFIV2NUblJTNEhnaTlIZFBsT1A1WmMzMkxsT0p3VzVKaWYr?=
 =?utf-8?B?bTM2RFYrM09rUFZWRFN3U0I5WGV6dlZySnBDQUF5SU10RjB5enlEcDdZK3Fx?=
 =?utf-8?B?YkJtVUc4RFJYeFQ4R09QQ2U4cGNFem82ZmFkMXBjelJZd1FwUXRLUTNhUGM3?=
 =?utf-8?B?RXFQbWtqeURnOFNpbVJ5NUFuZGdzRU9vUzRKeXdDczNlcnNmcnZta2VlRkpa?=
 =?utf-8?B?YVEraE1USENVY2VhdngxYjBXMjNpbTR0d25SbHZmNmRObjhhcTk0SHhFdDdo?=
 =?utf-8?B?WVBUYkJ3dlhveEQzeTlOSjNoRnQ3cmJWRFBUMTMyZGJkRzZLU3pvUnV4OHNH?=
 =?utf-8?B?K2dNaEgvTlNhaWZiTXhaUjNVSW5WOUNZeiswVVdzSlhsOGE1QU9wcXVQUjhL?=
 =?utf-8?B?SWIwWGoyOXFsRW1pcTBFYlJZWGljNzVLMVZGMTYvQXhIYWxKMXMvSjVKcTZ6?=
 =?utf-8?B?eE1LbTkzRFllZW1iTXVYUzFqajRrQW1SSnFRNWJDZ1NMWFRZTTkyaVltb0NJ?=
 =?utf-8?B?enBsSE95SjFrME1qbHQwMDRaT3lZZFkvdFM0azBDTkF0QVB5ajVYK2JwK2Ni?=
 =?utf-8?B?VUhyOVZqdkxybFBPNVEwSWRFU014dytFRE5HOTRLYUJJSEpLT2paZnFjUmtB?=
 =?utf-8?B?V2R4NE5HZDJ0T0ZQR0FYUjYrM1VyQktWaEliY0JxRm9XSjd5L1Q5QzVGR2Fy?=
 =?utf-8?B?R1JFTWNKdHpPNGtCZzQ5MEh6YVd3em10UmlhRmpqMUYwOS9wS3JuT1IzcTh4?=
 =?utf-8?B?Sk5MdmdIMDROQWh0bEpIWDRscFRnS0FQdjkvaitxVkZFdDJUOHI1OUpiWlky?=
 =?utf-8?B?SEsyUytUamFlcTlMUGV2bnNhZkZMOU1iaWVkM1RwWEQwVVlkZzl2b01RUmVU?=
 =?utf-8?B?eVo1dzU5UUh0L3g2ZHNBWXhsR1FqakRUUTgrSXZLSWZWaE9oTHhGWW1RQkJv?=
 =?utf-8?B?VUwxTU9QajdOa0FrNWttdjQrZ21HaWExMUZ0SDZJck03NDBuRm53bmhVMWZL?=
 =?utf-8?B?ZnBWS0JOQzNadmVwemhVWGVzblNUaUYxNTN6UDdkQ2xDVnNpZmVqSzJMdTdE?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ec9e3f-7e8a-4771-76f1-08ddf45a62ef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6443.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:18:40.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WICr0xBeuHCScQlahGisAKGMMudw7mqCKZOHfYfeIBvkIJdIhvoLRj7PHMxBfXZ2ZgIzaDlfVBYhBogukq3Sf1UK+rdmImyrIzteKFZ6eec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com


On 04-Sep-25 21:18, Andrew Lunn wrote:
> On Thu, Sep 04, 2025 at 08:53:03PM +0200, Sebastian Basierski wrote:
>> On 9/1/2025 9:59 PM, Jakub Kicinski wrote:
>>> On Thu, 28 Aug 2025 12:02:35 +0200 Konrad Leszczynski wrote:
>>>> Fix kernel exception by replacing memcpy with strscpy when used with
>>>> safety feature strings in ethtool logic.
>>>>
>>>> [  +0.000023] BUG: KASAN: global-out-of-bounds in stmmac_get_strings+0x17d/0x520 [stmmac]
>>>> [  +0.000115] Read of size 32 at addr ffffffffc0cfab20 by task ethtool/2571
>>> If you hit this with upstream code please mention which string
>>> is not padded. If this can't happen with upstream platforms --
>>> there is no upstream bug. BTW ethtool_puts() is a better choice.
>> Hi Jakub,
>> Sorry for late answer to your review.
>> I double checked and made sure this bug reproduces on upstream platform.
>> Bug seems to appear on first string - i will add this information to commit
>> message.
> By first string, do you mean "Application Transmit Interface Parity
> Check Error"?
>
> I think it also would be better to change dwmac5_error_desc, so that
> it uses char stat_string[ETH_GSTRING_LEN] __nonstring; like
> stmmac_stats.
>
>       Andrew

Hi Andrew,

Thanks for your comments. We can add the change as a new patch as part 
of this patchset. Would that be ok?


