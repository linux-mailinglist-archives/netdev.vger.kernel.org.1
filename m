Return-Path: <netdev+bounces-212072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4544B1DB85
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053C61AA5DCC
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF62269B01;
	Thu,  7 Aug 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmSUGsZn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A826E146
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583456; cv=fail; b=ldDUPbkcN1qhuLYY7zEXF8PAzu9Sq7P/td3mK+l1AfVyZJYMOjIGOEEyiXmZhYT67ig+pHpi2MuUGOZESLE28ocx0ViIohx2nq/oecK6W0AY387+qwaXEbv/nQTeF3BhB4kf1WtW37CBrN5LIxsbPuJ36n+d12uGaHfMyysePn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583456; c=relaxed/simple;
	bh=AwSTGQm37JVyotWybs32k0d0lv/vBrckDKSIQ/NXxvU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T9L5wnz98iA9cJcF2odaWgzD6IzNt6N8HiDtQhkwDFXx+3f7JXPQYcvALndxAIjcdWJK2kqpVyIeg7cM6i68VMfDKMwpJcCedHht6kEu+DjMIim5pGU580yv6T83RSCr75MF90qStxbJf6Aun3lJfuNMiDePyDl7KJ6FvSms0Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmSUGsZn; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754583455; x=1786119455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=AwSTGQm37JVyotWybs32k0d0lv/vBrckDKSIQ/NXxvU=;
  b=FmSUGsZn2HQlRJ6awcp6Ll5+pr5jfOniXX9IalAsVHm7qmn7JjMQrbIs
   uW4KHYTTuMvgflO/+K263DRZz08QCf24DgKNcBc4DUVQCF/VctFyIVh6E
   0b68mnhxYyi0lZ/FnfMriI1kVGatlO5Twn9Gmw1QVz5JuP79EszpBFzkM
   Bz6wVW7sPCv38pHzzdFkB2q0rIa9wfa8kNy4eHhTE6iOeEzWQrLi+E0ht
   z0DmQhaUkT1c3MOknbQXdIWt66MmRPMMBMxEEkWuMWQ3VqbO2Bvmzs9en
   pJG7dG/+4Gw1+EOklbkK6EHl8rnW3vaLqUr15HkKiPrjjfQdYYLFfEifw
   w==;
X-CSE-ConnectionGUID: nA1CmamfSRy3obBoERJyNg==
X-CSE-MsgGUID: MJlwk4RlSJumvEyzvqd/9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56845690"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="asc'?scan'208";a="56845690"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 09:17:34 -0700
X-CSE-ConnectionGUID: uoKPjIgsTyebk7VKA5taYw==
X-CSE-MsgGUID: DA1N0I3OT466iNSKxyf7ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="asc'?scan'208";a="195938000"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 09:17:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 09:17:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 09:17:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 7 Aug 2025 09:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnxto+pR0vRh3JRjjdmAqVa3kCVAKDHzb70Du251YdxrIKxx5C+DoiOi6+wPn0FLrgfsUu2COieGifgYq4tilV+T7XOCgFsvYUlgIlT9u8WdXd8a6indU4SF/W0Mf1G9uh2/Gq2tAbw5Yla8aB30mjh5y1kUdIKARz7fZyB5OTYScEfZ1eQ+jwTKXSsyAmMLDa7/R3hk/61f1SyJsyNkl+5jvYhPtkaUNW9bwgbhvt8uqGPFwMR0fb2cbwSWKHzNserOMqBa53llVHxmauvbKh1tFjS4SdoYf5Kc8B6pXjQkxL5nxFgDjTMB1daBwZweT+cge999SQZ9m7MSXMzhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89vgXNxCCWg4O8hzmBqdi9Bny6qKFKRHrhzK4sxPZZc=;
 b=oYOKbQrosuVh4ZDx73v6NEnbhwvhXYKK6pfgr5PzqeC+laGEcjX9au9Za9mxZUbuxoqLE6IanEAUSJUN8Pgs1RtwxW8glpuYBSt9Wl1xLemAYiy0hl7+elf/tM7ZyNvA+i24eqE+9jCgMGFEzJ24eRfqAT15WC5SrOgoQExc2wKIZEEMHHT9G2hZwIZtReP6BIrQRlftt+jP1sJmq2S4podOvBoKoUuXNPlBp2yFYp7PMNzaN3c5ULzNsauPPNtYs8a3OT4K6/dAGvMnjRATP6MtBJgNysYD7msyD5areegK89+h98yRCpfIQSESzw4/m0YYRlVij4SyseMG8IJYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 16:17:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 16:17:31 +0000
Message-ID: <6133c0c5-8a1a-48c3-9083-8cd307293120@intel.com>
Date: Thu, 7 Aug 2025 09:17:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PATCH: i40e Add module option to disable max VF limit
To: Simon Horman <horms@kernel.org>, David Hill <dhill@redhat.com>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
References: <20250805134042.2604897-1-dhill@redhat.com>
 <20250805134042.2604897-2-dhill@redhat.com>
 <20250805195249.GB61519@horms.kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250805195249.GB61519@horms.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------AGUI1q4ko65KB7kwLqVAE5YB"
X-ClientProxiedBy: MW4PR04CA0255.namprd04.prod.outlook.com
 (2603:10b6:303:88::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: be4fcd65-e061-44bd-e3ea-08ddd5cde942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3lTQ3F6TVpFQ2hSc2srbkF0VURaQmpwQ0UwZGRhOTdzTWZXWktHYjRzT2hr?=
 =?utf-8?B?WWlza1d1MkdEaERzZVhBZVRLbFp6aFByTGJJSytteUlFTmdwVHVFTXI2c3J6?=
 =?utf-8?B?YnF1S0pQWm1GOVNaakpXU2UrZVM4NmsweUh4Zyt6blNwSUFpbjIzeG9hc212?=
 =?utf-8?B?ZmJsT28zdGtIWjlQaTBqcGpLeFQ0WW5OSTlYeUNLUUwrRmdBRlQxdk5mL1dm?=
 =?utf-8?B?UGJhSncwOWtFN2wwdlNEWmVyMm5xODJmWXlBOWV0RW9zK1Y4OVRaV0Qvbkpx?=
 =?utf-8?B?NjBma3g0MGhZeGtpQ09TWFJNVUg1ZkdCV3NSRDJOMTZBQ2w5UStzOVpVTFlY?=
 =?utf-8?B?TkNsK3gzNmVhbUFOZUhOTWtYcmRzOE1sLzdVMTVmOUlYbjNoYURjYlc2bVQ1?=
 =?utf-8?B?OW9sTDVIZHUwZnhPUDB0VG9xeEs3OEtzc1FlOVp2UlFOQ2p0TDFrUzZMRC9P?=
 =?utf-8?B?Qkd3aUM0NHh0cFlqUENxVHoxQVJzU1hva2ZkeFRiNW83SDZIbWJIQmJkZnRK?=
 =?utf-8?B?M2g0Z0xtWkptN1JtZmxNUm1lK0grb3N4b3p4dkYzaEovbDRCRk4wNDUyVjh6?=
 =?utf-8?B?OGdFb1RNbW52eDc0WVlqL2R0RzN0MjhaNmhwOHkrelVtb0NXU1UzU2lFcnpx?=
 =?utf-8?B?UVlkZEs1QW5ONGEvaXVheDlEMmttTHF5OWNqNXhkcnNLM0R1SGNhMVM0OW5a?=
 =?utf-8?B?WkJqeWV4cjBuVWZ1VEsvRFZYbjdkOXl4VWxSNWhsaHR5dUlUSjFnMXNmOG9l?=
 =?utf-8?B?c2Zzd0lKV1VsVFlhbi9wVHhvdXFSRm55WGFmeEI1anh2WWRXT0dSRWFwdG03?=
 =?utf-8?B?ejlsMCtDdnhzOTk2c3k3YUFIWlR2SlljWjJmWWJlMCtlV1NxRXVJL3BrUVZL?=
 =?utf-8?B?dERZOTlpYWJVM21aWHRpRzlzRngyUUM0dm9ZaTVCV3B4L2dpMEFxWnQrT0Ez?=
 =?utf-8?B?di9FL1FOQzdvaWN4S0dyM1YwQXZJQjBmTmxlYk8yMnRMREUvQ1JhbjcwSGVN?=
 =?utf-8?B?bGFCRCtwMk1jVmorTVFEbEJxaGh5NFFYVDdROE81dmRvV0xYaTRTZWlPUVRD?=
 =?utf-8?B?L1BaUERGUittWXhOMWpoZVJKUnNzRFVQMjgrWFczQ0FsSXBDMUh1a2lzKzVS?=
 =?utf-8?B?Q0pYZGhQbXhLRDNpUW1FeXAwdkoxREJEdThLcU53YmlFUU5hWFZObUhGQk5p?=
 =?utf-8?B?dWYvVC9sM3RBbVhVODh2d1A4NGFQdDQ4ajNVM3NPOW5CMUl2QkV1K3FCMjB2?=
 =?utf-8?B?RGJVT3lPNUJvd2JUaHN3T05oMnpjblE3b09YdnF0VE4zUEZUT2hvb1dFRmpH?=
 =?utf-8?B?WnhVSndtekJDcWhYSEpqZDhXOHlxbVF5MFc1VHc1NFBrZEFTalJyc1IxWDZT?=
 =?utf-8?B?RUh1dnVVeVVmajQwYWYwdUlmNU4yTmtNT2o1SEpHS2VDNFlCZFJrVThLUDhv?=
 =?utf-8?B?SWxXZUUwcFo5WGYwWnoxR0tkK0hqTGxzckU2T1FUSXlaaWNnUHU5bi9sV2Rs?=
 =?utf-8?B?VUttSXVlSXJzL0RLQ3F1QlpBWFNTSkgrVWU1dHE1WFlPM1N6QnRMQkl3NkE4?=
 =?utf-8?B?d1plOVJYYzFuMUxSdmVsZ0diWWZaK0NWeWtFWFNNOWZyTVVMemQxdktSOUpD?=
 =?utf-8?B?K0ExbUw2YVk5VmJ1eW9XV0o1dWRPbFN2a3RXSUZML0lqcnovbGU2S0tldU1W?=
 =?utf-8?B?R1J3QmtqMllILytHbXRBdUZsUC9mUDlzNGtHNVJqeUJkZE5lRzJDNlFqOXpa?=
 =?utf-8?B?dEdvUTNPQkRUQ1BsYWxmZlpJUG43MDZkU1JBTzZIMkYwbjJIYklHMEp0SHdT?=
 =?utf-8?B?S0o5QUp0THhVYit3SGdCeVpQUU9FaFh5cVI3TGxydVVhdU9XU3Rmcm9teUNK?=
 =?utf-8?B?bHNYVmNiaU1CUWcvdUFrWUYzMndMZHIxek9JYm12V0NRUkVrbXkyRzlQTjI2?=
 =?utf-8?Q?Ls5563vtJnI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk1UbjVjcFZrL0xLVTdOQ2N0RW5oeUFydGFyMDJMZnZIYmc1WnVlZFZRditu?=
 =?utf-8?B?b2dvcVA0a3dxUmljaXNnNW11bnFEeGNoaUZqK1BMb3REaU91K1dSb1VJQWY0?=
 =?utf-8?B?SHQ3ZHNzeFdydXkzOWhSenBWOG1peWNwZzQ5SXlzRWlRTFNnV0JzMytQZlQ3?=
 =?utf-8?B?TmlMWmlTQXorZTNFZWJheDdXQ3cvV3pzVGV2TEtJcDJmdFZCTGQyVXdEekNs?=
 =?utf-8?B?VUQ0dFgzZG5GaFRTemNBK0kyUHFETVM2YUF4dlZBTkllT2lnTUNJK1U0V0h0?=
 =?utf-8?B?MWRvZExRNkZ1MXY3VE16YnBMYXBsRVcvdFlwQ2RDWkdXckw3alJ5S2FIS0t3?=
 =?utf-8?B?Y3NEazIxNWM5K3M2S3ZqWDRHZHlWcXVCWld6NllZVTFyeVVObTBpTWRwOTYx?=
 =?utf-8?B?czFxR01pTXp3TXJ5YnZremxGUk56Zm5pRXMxejVXV2JkZ0NsQ2pCYnNybVQ3?=
 =?utf-8?B?dS9iT05Bc1JqYngxVE0yMjNNSnhZTlhoR2VFQis3TTNyN3lVWWtXZ1ArcWR6?=
 =?utf-8?B?bSs1Z1owZ0tIOG5waFFaT2hZdlNWZklZekVNREtTRDBhZ2d5cEo3UHBid2d4?=
 =?utf-8?B?c2FuT2krT3JDUDF0WStEbHhCK1JRU2VlcUJ5VWtUUGtscFQvNG5vQzErV2Zp?=
 =?utf-8?B?c3h5eGpyWjJkUm45U2h1b1lkSHhMUWNwYS9UVENrUmc3SkwreXQ0Ly9KbU5C?=
 =?utf-8?B?aUx1SWFWNUcvS0syWXpuUHZLN2lsZUNEQ2RxTENWYmZSVm5KV0w2cVBnZHpo?=
 =?utf-8?B?bisvTGFOSGszZUR6UXZOMkJ1WUJ0MW9Gbm5hR2JKVEwxYUZrTmRvQm11ZnBR?=
 =?utf-8?B?M3libUpidXJoNWZKdWpaQ2hFL0p1cGwyYi9KMkY3TFdLZDRNcGlyd2JISi80?=
 =?utf-8?B?bDFyV2psUlZWNktYbWtnY0V6S0I1Nnp2cG94c2ZEZ2hjNlpXZW1MWjMrT2VL?=
 =?utf-8?B?V1BxSHNFcVJVRHJqSTBkTlRpc1BlUml0SVAyeDFFaGM4cEUwRHlSa0hVc01F?=
 =?utf-8?B?TS93anRGMU1CTWhid2tEYlRxWmViT1dlQ2hiNk5FUUFldjdqN0lJRHROT1M0?=
 =?utf-8?B?S053cHVNZ0R6VWpUQ1BydGEwcEJnZWNDVUdKVGpDVTczS2I4dDNBV2JEandu?=
 =?utf-8?B?OEdGYmUyUy96NEdOaFlQbFZGZnZsRUhUZTJpdUdBSTkrTlVxRVBlMWhtK3NU?=
 =?utf-8?B?VGFlR1RkZUx6VUFTMi9RV2ZINmlhV3ZYMDE4WVdVV29PaUsvRi9IcTZTWGxJ?=
 =?utf-8?B?NVVtLzF3ekQxT0Nqd1FYSHZzR0c0UHpxaDVNekZpMDRRcWxxY2FzbDBWbWZk?=
 =?utf-8?B?TytjbVpIUi9jOG5PdW1lZEdBb3FjNGVZbWJuczlJM1lpeWxkQk5iM1ZLTTVT?=
 =?utf-8?B?NTZsdHhReDNyckp0U2pPLzdKb29XTHJWbmEyamlvQlE3ZUNyYmc2SFhsYUJm?=
 =?utf-8?B?QWNQY3JvUzVjTnhFbW5HcGxxZXRMdHVvUXdtM3ArK3JuejRjMGRWYXdzSDR5?=
 =?utf-8?B?ZFUybUNlZGFFNUhCTWJHN283YitCek5QUXpIVFZKdzJwbG9sRXV6azExcHV4?=
 =?utf-8?B?YjRtT0pBTm4vOVZOMHRJT080U3g4OE43aVg3akkrRWNtbHpWa0xDeWlMN2dp?=
 =?utf-8?B?Qit1RjByNCs1MWR4WXo0dkNsVldzTStORWRGSnp1aWlwL0xKeUVpMnBONXZu?=
 =?utf-8?B?amJuR05SUU5JbVlkTlRhTUFWWmxkdWFJa1pRYkpPQkZLQ0RRK1lTdEFwSVd1?=
 =?utf-8?B?UDF6endDZnVtM0FkM0ZlQmhYdkRXRTlOMGducHQ5NHNQdXYvVUthck82dEpB?=
 =?utf-8?B?cFlYUXVkRVV1Q090d3FkK0ZJMkw1bm52d2h4RGg3NHNvMW8wbTY0cm9EYUdN?=
 =?utf-8?B?WWZVdWJTTFhFQWcyQVhWRTg5T3ZaVDhxWWxyRFZCTEg1QzJMMDk4Q0pLUFN3?=
 =?utf-8?B?czFRdHdSak5TUTJGSnVEditBdFFsdWtSd0UrU1hXQ1M5YXVCSXhLcG9kMmJS?=
 =?utf-8?B?R0RyYTVGN0RmMTVpbFFQNGJHT2liVS9WVnltVjZQUG9WM090MHMyWnFwRGl1?=
 =?utf-8?B?TTh5Rk5pdWdVM25NNzB3bFpNNXhidmtGcUZ0MDd3eXNVdkhmRFpmYU9YVU1h?=
 =?utf-8?B?azNXOTJ0cm9vMFlPbld0ZHBzdzg5TVpsdW80ZE1YbGZHVTkvdklsSDV6RWZX?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be4fcd65-e061-44bd-e3ea-08ddd5cde942
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 16:17:31.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3Kt/OvadvpbtDp9C+wDc5smEp00fi7rzPtIab0SlWhjJ5XijQsAFvb4Be/qs7EOj6lAvYpJE5NSntJ+CFKE6U3G5OaE2+dJNwXEHD2aSAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-OriginatorOrg: intel.com

--------------AGUI1q4ko65KB7kwLqVAE5YB
Content-Type: multipart/mixed; boundary="------------03NceILYoX0aY5g0X0dY1rF0";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>, David Hill <dhill@redhat.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Message-ID: <6133c0c5-8a1a-48c3-9083-8cd307293120@intel.com>
Subject: Re: [PATCH 2/2] PATCH: i40e Add module option to disable max VF limit
References: <20250805134042.2604897-1-dhill@redhat.com>
 <20250805134042.2604897-2-dhill@redhat.com>
 <20250805195249.GB61519@horms.kernel.org>
In-Reply-To: <20250805195249.GB61519@horms.kernel.org>

--------------03NceILYoX0aY5g0X0dY1rF0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/5/2025 12:52 PM, Simon Horman wrote:
> On Tue, Aug 05, 2025 at 09:40:42AM -0400, David Hill wrote:
>> When a VF reaches the limit introduced in this commit [1], the driver
>> refuses to add any more MACs to the filter which changes the behavior
>> from previous releases and might break some NFVs which sometimes add
>> more VFs than the hardcoded limit of 18 and variable limit depending
>> on the number of VFs created on a given PF.   Disabling limit_mac_per_=
vf
>> would revert to previous behavior.
>>
>> [1] commit cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for=
 every
>> trusted VF")
>>
>> Signed-off-by: David Hill <dhill@redhat.com>
>=20
> Hi David,
>=20
> Unfortunately adding new module parameters to Ethernet drivers is disco=
uraged.
> I would suggest that devlink is an appropriate mechanism.
>=20

At a glance, my initial suggestion would be modeling this with devlink
resources?

If each VF has a devlink port in the host, we could create a resource
that is the number of allowed filters for each VF, and the host could
control this through the resource...

I think this might even let us nest a resource so we have one for the
parent which is the total amount available and each VF port could have
its amount available.

A devlink parameter could work but is a bit less flexible and doesn't
show you the hierarchy with the total available filters within the PF vs
what each VF is consuming.

--------------03NceILYoX0aY5g0X0dY1rF0--

--------------AGUI1q4ko65KB7kwLqVAE5YB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaJTRmgUDAAAAAAAKCRBqll0+bw8o6NJd
AQCPziSw4UVkgZnmS1FKhTAuHIhMYXQXp1szbyzJscXi+AD/d24AOeqa8PHX3N7brbDMnd4I8byo
BB16eH3f1uxYaAA=
=Fs9O
-----END PGP SIGNATURE-----

--------------AGUI1q4ko65KB7kwLqVAE5YB--

