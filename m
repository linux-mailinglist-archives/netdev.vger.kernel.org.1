Return-Path: <netdev+bounces-185640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F0A9B308
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665019A4D8C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244F267391;
	Thu, 24 Apr 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ga8tD8ns"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1127FD60
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509887; cv=fail; b=BOrVbkOBSVQ7Wrqxtk6IpiGw5Akt9cmRsypJUOiIW1dPC1RfhEPe6Bt6mP7nPfl/RUq0zFXfJGn8Se4rkikeSx1P713aRB0hU3OM784eWDzx2a6F6wkkGIQr23Gu+egHdN5DWYrO7nzp8swMZY9VfFuUEw/fFtwpTG2LVvz5PBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509887; c=relaxed/simple;
	bh=q7hO2S4o7a217T4Qr2y87Xx6nWCSbvj96+VemQaU9UQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vAuj1otsYBsMe/pMfT9zbxneYwsc4FQ71FZWmv1vviHE9HkidfJpncopWsB5F/gOHaAAXIOx6XgfCZ1+Nn8BQYuf4fUencUY5q/AAHs8uAyeVu4RX6xtbG+8OnOq0FRi+MHFF0+yDwwxUk0fZNtDwnn9auyvoN3nrinhqkk7uNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ga8tD8ns; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745509886; x=1777045886;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q7hO2S4o7a217T4Qr2y87Xx6nWCSbvj96+VemQaU9UQ=;
  b=ga8tD8ns2MIUavLLiv5u7KVQCZKfHhf7HoUHTt+ZkJoTzZe3O4ccKQ57
   yTPkTuaSVpt5pHr6paojdiM+zm1qA2smSQDeDxtkZC7yaV+YeBT3Hy9Wu
   hicqh97TP8WnefcRt9z4csCdReX4NGxxtaC2yxi18/A71wajuV7mkcsFt
   cqoJNCda36sL2JezK5BCChUmGT18zLlL6Sk6T82AdY9DzPXlsx4od/sbX
   IqChh/T1SdLF0TRZzvGzmDfsKITrQo7X0RJTj1sMCo1x1GQ80hYktzd9L
   cmx59xvK4IAJZJyJnyZEvmBAXBqDVYuutzBiV3Ya9ab8y8qIKR4Y3sDut
   g==;
X-CSE-ConnectionGUID: 6HJQaNPZTMuC4IHBILex6Q==
X-CSE-MsgGUID: TqGSi3ynRbGXDIyrPqcj0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="50974250"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="50974250"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:51:25 -0700
X-CSE-ConnectionGUID: shThdDWCS+qK3buNs+s9Eg==
X-CSE-MsgGUID: mCOHgpKmTge+3jxZSzUzyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132962764"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:51:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:51:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:51:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbQuG0j1LyZlbKymmtU8sv6Za2JGtHD0WX6INA12U4jap0KtR+2Gj57XM3W/JXqH6LIa/GZIxoR5qcYlAJeB1RtxfW51GfjkXK5o35fuc9aa2suG9D9zp39VlEtT+W3L/7H28oIZ9iJbkzKfzl0abnFwAg3gZQt8KBdhIxJhOr3La4rBCSu+vksIBArV0BgVXeGZ84Zfzw4rjWJHU72AgCMwu7H+L9NIPM0xpPYebhIZUNzv1VYaT3oARWutuvBlFWllHCG+AByYmc1/pIvjw1enu2t1j3mtFaLYGdDer17RH7sWHp5yrH4cTNyKLUIWMCFhPVgG3EZYr+iGYkjaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0MLXN73mS5mKwMRYfug4Cm2Yr6qiJ5a+X6Hv97jNKU=;
 b=P58yjMfckGPuoKEv2gSoeLhZM5U+co+n4y567x0UKBfdBDHxNtORpwvSLVcIeed5w28ZKsPQF7IESKAIw8n9oB2FnMBW5BUWz+jhQtjDB06EeLdck9IDqbby05QKw9fefDM5sWLaGQXq4AycRs+HC8vvoWS+NFuUm8AI4Pf829mXF7ChSt8rwXVcB8yG23rXUZsFeVTR8SECysB3Yc/Dw8HYP5jUpe8YiJqBoGeVTq6DCTHieVNyp2wcfQ58xyCZpen3nk29j0b+ExLVWcW0PWISPLBo6IKXFzJu05Ys/D9kddAmN26wcEs0JGtd1kfoGcm8jflCmLJsMrnBrrA5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 15:51:03 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:51:03 +0000
Message-ID: <258215a4-f3c9-4f53-b8a8-f9424edc8141@intel.com>
Date: Thu, 24 Apr 2025 08:51:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/12] tools: ynl: let classic netlink requests
 specify extra nlflags
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-5-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-5-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:303:86::13) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SA1PR11MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 04338e08-fec3-4311-520b-08dd8347d115
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnF6QUY5UEpIczZqcjVGdG5UV01CUVZFOUdXcGRvemEzbXJlekhkdXlBYXZR?=
 =?utf-8?B?SjAvK1d0Vzh0MWRiLzVUK0ZWdzF6Vzk3RGZlRVd4bFZCTUk0NG9QUC8xRCtD?=
 =?utf-8?B?Tko5WVpSZ2Zhdk5TZnZybHdkdTRabmc3K1FBaTRiRmhaZU5LVkJVdWE2NmpE?=
 =?utf-8?B?WlBnejdUTjFiR0JpMlBsWXpLcHVXRHRITDBsNzRMMHJBWjRBOWRRQmNlNFRM?=
 =?utf-8?B?alpMbXpid29RcE11M016S1NZU3FYK2JPOUtySWNBaS9MQTh1dDlWbURUd0xO?=
 =?utf-8?B?cUIwaGw1MEE5MStrYzQ3ZzY4cFNXWElhVjJyZDZBclA0OGFma0I4SWx0QWZa?=
 =?utf-8?B?L2ZXRDFJTU9EZ3U2c2RHNVZkZHVkemRpeFhQUDRSR3NKOVFZZk55TFRaVWNw?=
 =?utf-8?B?Rlg5aGpkZ0RZS2c2QmJnTTNSblhUdDZsazgvaFBVWEttSGh4OUJTcy81bHlT?=
 =?utf-8?B?WEs0UlhHWnRkT0VIM3pXQnNWbElGQkUzRnFPUTlKSTZRT1RaSlg1Y3RST3FN?=
 =?utf-8?B?UHFrVk1keXZBTUxpRWJMWWJHSGVHU2dDaFlxaXdZVnJWME1Jc01oMFIveU9S?=
 =?utf-8?B?UmVmc0puT1ZBaVBlNU9UOXJRUm9ocFc0VjMvSmQxRU1XSGptR3RFQ3hCdmxR?=
 =?utf-8?B?L09Sdjd4MGtlbmVza3M4bG0vL0hYZjZKL1A4MXNlRFZ2K20vRjJRNFE3ZTBD?=
 =?utf-8?B?WEVnYU1xRWR5R3dPQjRqN0tPamVvMm1kb2xabVBHY1EzRldNbEVaV2t3amRY?=
 =?utf-8?B?MjB4RkdrbWtydEJER1RCaWExaGZUZDJjdnlPejNnV1N5cmZBZk5zOFd0bDdG?=
 =?utf-8?B?WVJWWkhVYlF5ckJSakF4S0hXRllZYmNCWFZDYXFUZGVZVngwU0l1bFRxQ1E1?=
 =?utf-8?B?TW1NOGk5c1NZK0J0K0dxaldoeUF5OTgyaGk5MGo2Z29sTEs5SzBNaDFnZEFi?=
 =?utf-8?B?N005ZEMvVVJ3T1c4MFV4VzdKWGpRejJlaG4vbDZ3ZzFzbWcyZHFsUVY2UWh5?=
 =?utf-8?B?RkVMRGZMUzE5QndORmZnZG5rc3pna3hhU1JCZzQwNmFOY3ZiWEwxUTBRbDVO?=
 =?utf-8?B?Z1dXdGd4bS8rdms5Uk11QXZEenpIaG5ySklEMTdVaHBrZkdwNlBRcjdma2pX?=
 =?utf-8?B?aXVIWmVEWFBmZ0gwc0VYbEVKajRuNU5KOWRuRC8rc01pcnFDallkY2dtZGtR?=
 =?utf-8?B?Z1AybXVKblNwdUd6dTJtZy80d2FNZ3Z2OUJYS0k3ZHRjdUVZZmViWURwSUI4?=
 =?utf-8?B?L2V2T05vNjhGc1RHbjVTbEJLck9ER0VrQzdMeGZTY1UvYnA3Z1hpQVNCY1Ey?=
 =?utf-8?B?Y3VFS0IzanVuZmU4WUUzSi8yYkIvTWIrdVA5SEkxYW5hMGE4N3lzRVFOOTdS?=
 =?utf-8?B?L0t2VEhjaG4xa2c3UFJmejdrb3AyY1o4dXBOS1dNM1FxRmJqVS8zaXAzZUU0?=
 =?utf-8?B?NlpFemRnMjVFQXdWNWFsT3Y3blpQalE0QlR2dFkzMEF5ZlNzaElEUUx2ajl3?=
 =?utf-8?B?cVNyZkxaUjhsaGsrMUR6bVpFVTZKb3RxYXEzRDdHL2F3eVA4dWUrTEI1RHlv?=
 =?utf-8?B?cWFJOG1IY1U4ZDFLT0NuSTljR1JORDhuVVV2UFZybDNINm5qdFFJWWdqamNP?=
 =?utf-8?B?WDVDb1dEYXFTLzJ1cVNhb2o5aXg5K0NzUmJJQk9MQStGbGhEMjRET3ZVaXVp?=
 =?utf-8?B?OVc3Z3R1Nnd5Rit6QmlxT2NoL09VWTN3aHRYdE1VbzVXWk9waGg3YWNIRTZV?=
 =?utf-8?B?eU96eGN4UUlMa0FrZ1EzVlNVb0g2eGJSZ2tlRWNLSDhHbnVLL1Ryemd5Wmls?=
 =?utf-8?B?bit5cmY4LzR3K290b3VyeW1VRnF6VUxoWHRXT3BPZjZlSXlrd1ZMTWRQSEYw?=
 =?utf-8?B?TXlHdXNFR2ZZcVNFNmVheUprRnM1VkNxenF3Nm9BQnB6Q1g2eXV1SndxVkhk?=
 =?utf-8?Q?UjUpei4uCe8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enRXZzE1SWpVaWdSZis2U3U0ZE9oT0oxbHJURmpzMFVvSU10NnlsZW5RL0lQ?=
 =?utf-8?B?Q0ZSK3lWYlN2ZHJ3QSszQUl3cHhXRnVkT29pcXkzUWw0TzVhSU5QN1BVaytH?=
 =?utf-8?B?YndZY0VtNXl0ZWZFWlZMQ0t4SUoxb1p2OXA4RFlzTmhHUDdHODlwTVJuYjB2?=
 =?utf-8?B?VmVjYUNnTFl6VzZoZE85czBaT0dIb0FtNDZUTldEeVRUQTB4ZGoxTkJ4LzZZ?=
 =?utf-8?B?b1RWU0QrNW1pQmNlVmpwVkVhb3RWNGpyamZvb2JocHh6MVA3bXo1cUx1QWFj?=
 =?utf-8?B?UmFESkZQZi9mUUJNRXdYZHFYVEw3d2lTSVc5YjcxdHJSK3UwbGNMUktBOWxo?=
 =?utf-8?B?cFY4Rk43b2NJV1Y5TGtmTHVsTUJMOTJxa1FMRUorQkdWMGpMNW1kSlpWa3VN?=
 =?utf-8?B?UWtETW15TjdqeWVJL0tIcVhrMDNVVE03d1JNaXlhelRSc1g3VjBDK1RvVnFC?=
 =?utf-8?B?U1Q1OTB2TWNZV1NEbE9yTmIrUytzYXBPby9HS0s2VVFrTFVHWjdKdUpNU3JL?=
 =?utf-8?B?LzB1ZkxBblNweGFlY2RIYzMwRW1xWFJ4bG1uaWRtV2svSVhTcCtkTU1RMDAr?=
 =?utf-8?B?M09zQmVmZG5mSytpVnd5ZVQrakNSMnlCbzE1anUrOVNodGhuZWxSVUJWN0xq?=
 =?utf-8?B?ZXFnZ3JXdksvSlJrRThjSkd2eGVIcGFlbitweFZaZGVhNHJCbEFZa0RaS1pr?=
 =?utf-8?B?czgvWXIzUzVSaGd6eVdJSW0ySUVRM3BpZnZROHVPMHNzQXlJVW1Wci9IMHBr?=
 =?utf-8?B?Q1hQWHJweDdpRHBtSU1hTDBGQjZnOStQbThFb25Hci9CSjIvRis0eXBkSkk4?=
 =?utf-8?B?ZHkrNWYzN09DTGQ4OVBzdjk5R1o0WHljTW9MUTE1YkR0WVZtVlZ0L3NpZFJw?=
 =?utf-8?B?MGY4QkZMbU9SRCtVcVJEMWp0RDhHM3gveVNjTU1yQ2kwMVpLSHptbWNaclZL?=
 =?utf-8?B?RGpiM1ZacHJ6cUxUaVh1RWhReHZVMFhwQ0RjdmdEdE5pdExqNWdhbGwxL1Fw?=
 =?utf-8?B?NE5scDhOc0Z0M3VIcGsxR1BoNVNDL0Z3VFdLVjZMdHMvWVV1bmFtUzljRnh4?=
 =?utf-8?B?djZwSWpacmdDSzNQM1lSMFZCQVhmMHh5cmlDOU1US1AyRWl5Tmd6K1VaMTVG?=
 =?utf-8?B?UUNLcS94Q0FGa1dTMlFwTVBWeDl1d05KcWt3U2k0UFZtbjZxek9GRzUza2RL?=
 =?utf-8?B?WStrNm5nc1VLcWpvOTRWWHNwWEJNVzFkYmN4SGM1WmttTEo5cXVLekF4SU5I?=
 =?utf-8?B?L1R1VzArU1RNNWwvMUthbGs3K1R4L2N2bGM0ZlIyRnZkWnZock5TZ2liUGF6?=
 =?utf-8?B?WnVZWkxRdGo1K25GbUg2NlRXWnB3NjVidnpuKzR5bGgvOFpWcEdtS2lZakdJ?=
 =?utf-8?B?VlVrWjZMVFlrZzdCODJ6TEFsSE9Xb2NCaVVHNnFTQnlJVGZySDQzK0ZZVjF2?=
 =?utf-8?B?Nys0M0s3QXBvOGJaVDVGT0Q2eEdjZ1FYaXJFQkRmM2VGTUxZZ1BOTzhmL0pJ?=
 =?utf-8?B?RGtvVGNmY1JsZkNNYS8vM3VnZlN5cExiV3FpSmUrTko0QWp1dlZuMjdEQU5u?=
 =?utf-8?B?NzIzS3ZhUTBwZXlCc1ZZd3l3S1UxUVk1RENmamJpOStiUmljWHk2T1ErYjAv?=
 =?utf-8?B?SVVXY1ZVbVRuYklxeTduUzlvODE0TEVMYzFiL1E0THZQekNQcFF1Vi9LS1N2?=
 =?utf-8?B?elRBVE53L0ZobGRCQ0lTUDJmY3hzSFYrNFNsUXI0L3NBb01jc2xGeVdoYm8x?=
 =?utf-8?B?Tm1QNDFGcEl0LzA2ay9HSHhrYWdBbVRsWDRIak9nWXJkY0tNUXhibXBCTVVn?=
 =?utf-8?B?Q1dhckJCaW5HZ1ZGaS9BZE9UN3dLQlBFVkVycTU0M3YxVW5pZVZTVG0vZEZp?=
 =?utf-8?B?UWozU3dicDE1SVhWUmphSWE1VzJCNEZheUtqTFE2blpEa2hIcFZiaXJjWW01?=
 =?utf-8?B?RmRzdXgwMlV0N2xDSENIQmplZzRoSDhxU1dVV2NIZXJYUk5JMUorbDVxdnRr?=
 =?utf-8?B?N0gyay9GdHdCUmNnb25LcGF0TzBHYkZ1Zkx3Qks0ZmRWLzRtRFpKZ1pkRDlw?=
 =?utf-8?B?QUQ0L2gyb29COTNjWUVUZHovd2pvRzJWSFZHNUtiN1lNTmNHYnY0SnNocjdP?=
 =?utf-8?B?S3B6aWVLZmNwL1dHTDMrQ093TEVxaFFicUUxNjIyRTUwMDNpTHY5eEk0YnVp?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04338e08-fec3-4311-520b-08dd8347d115
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:51:03.2893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mURkq9YFanRSYiCEYt3AW+oWkoxkeIbIzVd2spatOpMNWqv55gNZW4u+/A41oTdUzUu/xd3C5whUzvLpyKoRYG3viz1f84JzY1PY3700pdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
X-OriginatorOrg: intel.com



On 4/23/2025 7:11 PM, Jakub Kicinski wrote:
> Classic netlink makes extensive use of flags. Support specifying
> them the same way as attributes are specified (using a helper),
> for example:
> 
>      rt_link_newlink_req_set_nlflags(req, NLM_F_CREATE | NLM_F_ECHO);
> 
> Wrap the code up in a RenderInfo predicate. I think that some
> genetlink families may want this, too. It should be easy to
> add a spec property later.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Ya, I recall the flags occasionally coming up in genetlink, though not
as much as rtnetlink does.

