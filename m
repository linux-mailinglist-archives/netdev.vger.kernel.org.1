Return-Path: <netdev+bounces-268661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOiuD1F1uWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:37:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8352AD25E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 920C63010749
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A1F3E8C6B;
	Tue, 17 Mar 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVS+pjVO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782E280325;
	Tue, 17 Mar 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761623; cv=fail; b=I3jKB0/JLsISZU8CnZnbdtvxnQkn+5smnwFdhpYgkbr0z3yGSRxlvDINpNSCVVTyApEHAcca0hRoI1t+oz5gZRV1dbKQC7Lv71vN/XvH6Oc58OmiB6E8Oohov1LFOpttiBfNtTg5Dlrpc86EZxj356oBeXc1vm7VajeTqhoVW4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761623; c=relaxed/simple;
	bh=kseG7Eag3b2ntHMLIPmp6KOOXXLLzBcvoVSSLXRzJIY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WQHdAMyHOokO7JEj0yLMqsUKoCWt2FPqnNLxEve9LE49Nx69hW9SybxLYPkWKKflXTgh4uH/5IDiJiuSelwD2jvg2UvNUCzRRrYm1xcB/xjhUrCgEfiW7M2g1DS6suj9BmQCcHiOGM4cAgmPmGpe67jSXQHdeWsf3TeUXdswBfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVS+pjVO; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773761622; x=1805297622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kseG7Eag3b2ntHMLIPmp6KOOXXLLzBcvoVSSLXRzJIY=;
  b=ZVS+pjVO6BTKxNe3i7NyI1WBa5eVjYiw/ftMH4L8UTuftZIDM+73VtaW
   3XubiklQpjckf7Hys+3fSrqXRJu3sfTrTqR4UwrMresMjLOMJk0OS1lzZ
   2Y8tIhpW31ffU27a55rsDXqDFQ5ClDPr1P9ZcHEsS6+Q109Nqq+GPz4iR
   zKow8FTUhK5/R0X8tWsigSEk4mJ8+iNoy4+dYpSGIVl4lP3hiwGC5BbgG
   OBZG86+gYxjp85P3yY9Nx3C7+pr/OJ0HjPIE3rJhR1OWW6/Ocdc6swMie
   dS7VcJuFssW/9kVb+sKPd49h9v+/mIp+ZYwCDoo0C9wyoWo7uBAwQdARN
   A==;
X-CSE-ConnectionGUID: cKLNJIUeS1eSQAXzGbbw+A==
X-CSE-MsgGUID: wq2ztgydQLSHGPAHHCt7ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="86152344"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="86152344"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:33:41 -0700
X-CSE-ConnectionGUID: bcMm3upPSeClX1QHuPsBNA==
X-CSE-MsgGUID: 4twLdvMySXy3bP3TU2ICUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222526614"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:33:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 08:33:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 08:33:36 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 08:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Umhhfj/xtSr0adPDxlewiwwYOPXeDk9OfgDQ2h34pwbxqnjkNub3rBC5IDWJakQR2Fmvjm1qqv4UrnfOEDeQdjDcqmN1Q3szK0yfZci885pe//mnAUSiHzAkHiv9UxF9y9kHtoRTAmqgxk9+NvzpPWneLBmiRVq/lsbmudlrmEG9jyovkElZ1YijDIe1OmBytIF4ONcnR3eJSmdDhP7Xh94bo4aIO2bq8yaRN3eR7XFbPGnrTLRq/hK7DrXRVDLwFTACMyRZeRP1e7tX4u4zrlyX1A1sZpULXIqMnP5HF6Kk1WWgUWxBdFySwoXAvwBH60ST7V9LcUJPwIho1NCwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj8rRAR5hv3suL1usZlC1ErvIeaIv9PykkaExAUKG+8=;
 b=l89iMFRrv9p5EVwqV8n0FIMWQabc1iFIIAc7dbi/MkrlLKZIjNbKOyZVcddltHCffRUsvQDjZY0jaJcyy0oLLJjWS7AoN/X+DQciSnIi/ts5vviBPsKsCeKtCiTRn/mx5ATKkJMHxO2TV1J1ha+KEGrTf2k7uzFHmtq/ug2EEw3lhb8cWoK1T5yBvfQe6zahYt1F9WW4JQFXW3v1m06ywrMneRjfBTKYkjld1mi8VBeEWFFdo6ErrXmffL1hrC2622j5acjNAjJxmkCC+ul92xx5RCGLd/fLVCzCEGSWwyJgzP5cX61LP30Nx5K1Hw9Eg5Qk8Cu6f6HDwEbQ1F8fsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH8PR11MB9482.namprd11.prod.outlook.com (2603:10b6:610:2bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 15:33:32 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 15:33:30 +0000
Message-ID: <a95fa7f2-909e-4b1c-b25a-1ee88b292ecf@intel.com>
Date: Tue, 17 Mar 2026 16:30:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,3/5] ice: migrate to netdev ops lock
To: Jakub Kicinski <kuba@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <horms@kernel.org>, <edumazet@google.com>,
	<sdf@fomichev.me>, <aleksandr.loktionov@intel.com>, <ast@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <hawk@kernel.org>,
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, <magnus.karlsson@intel.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, <daniel@iogearbox.net>,
	<maciej.fijalkowski@intel.com>
References: <20260310220624.537917-4-anthony.l.nguyen@intel.com>
 <20260313014628.1509116-1-kuba@kernel.org>
 <4537e162-6610-4c3f-b8d5-e62415322282@intel.com>
 <20260316161630.2d9ac04e@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260316161630.2d9ac04e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0029.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::34) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH8PR11MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: c16b38b5-9d23-4508-3846-08de843a8a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jVAH7bhqoCUiTkGXjRpXjPFOuMxMTmmGqVOSvY2txM/NoyTg0MB4hWaxnWQrLkRPjsBaidLUmZ7THyf+QWw31pZ3D9Z7GbvjwTtyjqhrl+GLL/7mlE2hbrRWQ/u3fdBy3rYE+I84r6lCKb2CRE1aUKCYgFAJ0d0cy5TRaiq4s1tbStEWBnoxjFMe+S4hQZ8ZvfcZ+i28Mop5BqkOBzGAjTTGyDGHxOmYmofgMVyabYMV1rF9ZVu0ord6kA1D1yY+K7ZITyx4YEEOPIXxj6Ca53MsyPP2V7S7Lw3lmgFa9EOitnq05gzGpqZPtaS9QPPtFuFTr0tJ1u4CvL9WOMY0ST4zR2JMcaLAoDtx0meycTXWzozVwkZlEydI81lpDetxh2gajvnGi0A8ksWK63NN3G0TD2+zLeltL6pumYMoGRqeaLoj0GqVTKMLO1NoTw2GmfrPpcfAohTt6NKBZh6MOM0wD6Eq+lQ2VLwBCoJ2Cr0j2szo+m8Iv9VOouMrFQartL+Wimp4vvn7GurXT309gLS2otTZsBeWBNOGtkjJuqloPAeRRgFoZR4v/50xCGhXXdwhEDJt0Zp/FGIRkRD3gzGbr+2KMgOnybOhXYyZfP6yjVXycxM5L3TPkO+pb1tHK9ctoQGAcJxxOzMvYlw0c+MB/Q6rlA7wZgS543k79kFCyUbxpZe0dFvFBnJKkJ2n7SPpK98YQq1zFqugwwV0KwOXJR6JfJWYTWdg1AzXz30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHlaSjNWVy96RFZ1K3lSTXVWUXdaYmN0Y1ZFVTRrOXcvcHNaZWRqaVhac3Ra?=
 =?utf-8?B?RGVpWXpwMk80S1pSTmp0clZFcUJkY0JFK1JhQzdZbVFRRFd5YTIrazR3S01C?=
 =?utf-8?B?S3UxTzlTYThSdVJtNXhsV01oNElvYzFzR0YwcjI1dVhpUzBORjNFdGZ3WDh0?=
 =?utf-8?B?T3piKzhRdXF1aTdkbnhHWStZK0Nldm84a2xCVW5XU2Z0amxKQUVGMzQwekdL?=
 =?utf-8?B?L0lIRVNacWRLdGNCTDhnMzVMOGVSYzgvVHl3ZFNpMXQyQjRHMTRWQXJUVWFE?=
 =?utf-8?B?a25jK0t5SUE4RU5UeEIvdHZocXo3UXlWQ0ljd0hValNRRVBLQXM4TzV1RGVX?=
 =?utf-8?B?SElrWG9jaTBoQjJydG1nL3lsUUpEamRYSGxGSjhHUjdyRklYaHkvT2JaK1li?=
 =?utf-8?B?RjdEM0NuQWpWai8wYnB1N2xmY0VyWDh5WVlsTXVka1MvaHBiMENXT3VFRHN5?=
 =?utf-8?B?Y2NhQlVrRGc5YUFvb0Via2NhbUw5UHQxYWZZKzdDblo0UCtncGEvZnA4a2c1?=
 =?utf-8?B?YXZxajRvbXRTZ0R2MUxyeGJ1Nm9iWW9qeHZjaENuWkNxOXc1bnYxVmJ3MFU3?=
 =?utf-8?B?alFoMlZhRGV1WlRQaWRzbXd5M251SjBpUGJQOTIxcHFTeGluUTB3TjVvRGYz?=
 =?utf-8?B?dlBKS1ZYaFpGL3FwSzZCSzRxK1c2Skh3MENKai85VE9rVXhHVnJKazBaOVRJ?=
 =?utf-8?B?WHpHL0hyWDBDcGR2S2c3OWtGVk9jaHdld0J1bUZZV0hUcitFQUhmb0JkYmwy?=
 =?utf-8?B?ckQrNEljbXBhcFluUUNqTytzVldlMFpjWHRycnZZRjUyNFV5Y0Z3Ukp3NGpz?=
 =?utf-8?B?cEZsTGJZcXE3aTl2TnlHeWVrU3dQeUh4eFdDZE43MHB6V3B0azFjU3BWRWFX?=
 =?utf-8?B?NHM1T3MybkVJU0pOMnM3em5WT2g1QXhhZ2dTTklZQVVTNG5BaXkrZ011VDZZ?=
 =?utf-8?B?NWJUb2xmWUxFRFZGWm5kQStvd24zMGVVSVIwM0FSQ002YTlkbTVpWDU5ZVJY?=
 =?utf-8?B?cWtOM0xWSS9adFo3UXp1Vm1oSjR3cXI5TTJxVG5PVWJuTTZ5TUJIRmRIdDB1?=
 =?utf-8?B?SEtLZzhVRm0vTERrMXlSMi9UZ2tFWmlMcXUxdWNwNFo4TmhlVk5uaERUSzBP?=
 =?utf-8?B?NXUrMmEySkVELzhZT1ZmU0lPKzlBdTZVQ3IyQkRYQ3lzbnhMell3bVRhVjEx?=
 =?utf-8?B?RXAzS2ZKUjVqUGNtNUM4d0M2MTIrSjNlWW1UVE9FVGFYVDVBTW83YjFUNEZ0?=
 =?utf-8?B?RVNPaFNJYzlDa1JyZEowVUc1S0V6aFZNVnlaZXB5QVZiS20reG8yQUVFU1JQ?=
 =?utf-8?B?dWMraDM2TmlwMVpQeG5aU0hvYzBKZ1lCSGJFZDN3b3MwSlF4T25kQTdWajha?=
 =?utf-8?B?Zjh3Znlia3RYNGxBZncyZExkYytIeU5lM3BqcmNFMUZ5WGE0bnpZR1J5OFlL?=
 =?utf-8?B?anJtSU5Idk1pTDdwVE1sVkZMOXJ4cVdoZU5LR3FxUzlEL3BuODJVcVUvNHlr?=
 =?utf-8?B?Q0RzbG9VbkF1Z2JXMmZ0RFQrOTU2dERpMS9TY0N4UEEyelY1MFhWQW1oZ096?=
 =?utf-8?B?YUdaZVFDTXZLMFhYNHJOeWRibStZSFJuVVZvNlJsYXFESUtCcUFoV3JWQWtG?=
 =?utf-8?B?UWUxd21JYmtXNXdjbzNyMmozMEhUcFlKMXFpanFUV25FQXNXdjUycXBGeUVB?=
 =?utf-8?B?YmJWTTZwYmE0L3VPVWR2VmdtT3ltRVUvc0FqQ2FxdmdnWTBMVkRoZ1M5YnNM?=
 =?utf-8?B?ZlRqMmpRL2k1QXB3S1IxTlNVbUE4bzlORlVZelEvRWFsTmlkMXdsK1ZaSmhG?=
 =?utf-8?B?cW5YQnN2VkQvcisrM0dXajhzeWFmQUlxbldqZXJSdndGVTE5Q2RTeWQxL0VM?=
 =?utf-8?B?aGJtSTNsaFBINXVnM2ZrRTd0dE5sd3JqdjFZeFhsSFJGazMxRFdlWDQrb1hD?=
 =?utf-8?B?cmhKSk90WnRDU01wZElyeTYyQ2JHalFFa0swNldEVWJRZ1hDa0tMd3RUVmtn?=
 =?utf-8?B?b2VRbmRESUpEUVBNYzlIL2grb0tyL1ZTdS9WckNMWXJ1WWdGRDBZcFVmSE5W?=
 =?utf-8?B?Nm5HdXpJTGpRcUlPaUl4VFowYjgvWlFXemNIdng0NzdRQ3R0dTQvQ3JzY21H?=
 =?utf-8?B?OFZyWVMzUmFOcjJtQmZadDVEaisybTFkeWJUQnR2VDN3VERJYjlsdGJpM0cr?=
 =?utf-8?B?dkZhL2lVdjU2TFFpOGFseitab1ZqM25uWVZQRmhpZ1VlYnp6T2kxenkwL2sw?=
 =?utf-8?B?MXdpclFObThtRmtqa24xR3RPMkZjOTBKd09KUHlsREtKM2QrclhPc2IwYUho?=
 =?utf-8?B?Zmt5dHF0VXZOUUJjNlFYUitWdU9nOEZGd0tyT3Z4RUl6T2xTSGY2MW9RWUxw?=
 =?utf-8?Q?2pawCRt4EwYBSRIU=3D?=
X-Exchange-RoutingPolicyChecked: dZekpXu3w6cJKV2/lafWEWGtgWGwt9MSpTXDFfYMa6EtMtdg4M/47aJO1tlvfChZLpxebEMYQQDpsMcSec+lLDJih+BFvmNLTSUgA5ZiIfnWQ5n1iP9Hk8Xi9KaUOQo0V9kdSdHLQG5Gdh68rtJSyDj1K1EEvAkYRBvecUj3t+cXbN33+snFq15ksqxwSI2XU2/IB7sDyED3IwQcB8FNs6D62w0FGfI2IEHeUTQdPC7QLuagwXjzCkSjxzUPcdh576yR+6xqGfDvA0L3CLBnJnmVk3W6/WJf35MlZfvzUJOKIwvwSdK+uerpxMZ+Dh2MJTb8VxDXX9CX6HGVa254/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: c16b38b5-9d23-4508-3846-08de843a8a79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:33:30.4190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ity7pYpkLmW52BwLdW+fvZcX6gCLtIRz0gBQ1Ei4VJXr+v327vdpFk268MLZ6yapn5oEwbF5NiYgLqPNQC1KpXLky8ff5dr29I0xcqHv11M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9482
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268661-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,fomichev.me,gmail.com,vger.kernel.org,davemloft.net,lunn.ch,redhat.com,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4F8352AD25E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 16 Mar 2026 16:16:30 -0700

> On Mon, 16 Mar 2026 16:10:49 +0100 Alexander Lobakin wrote:
>>> Does ice_dcb_ena_dis_vsi() need to acquire the netdev lock before calling
>>> ice_dis_vsi_locked() and ice_ena_vsi()?
>>>
>>> Looking at the disable path, ice_dis_vsi_locked() calls ice_vsi_close()
>>> which goes through ice_down() -> ice_napi_disable_all() ->
>>> napi_disable_locked(), and that function has netdev_assert_locked(n->dev) in
>>> net/core/dev.c. Similarly, ice_vsi_close() calls
>>> ice_vsi_clear_napi_queues_locked() -> netif_napi_set_irq_locked() which
>>> checks netdev_assert_locked_or_invisible().
>>>
>>> The enable path calls ice_ena_vsi() -> ice_open_internal() ->
>>> ice_vsi_open(), and that now calls ice_vsi_set_napi_queues_locked() ->
>>> netif_napi_set_irq_locked() (requires netdev lock) and ice_up_complete() ->
>>> ice_napi_enable_all() -> napi_enable_locked().
>>>
>>> The old code called ice_dis_vsi(vsi, locked) and ice_ena_vsi(vsi, locked)
>>> where the old ice_dis_vsi() only dealt with rtnl_lock. The new code switches
>>> to _locked variants that require the netdev lock but does not acquire it.
>>>
>>> Callers ice_pf_dcb_cfg() and ice_dcb_process_lldp_set_mib_change() hold
>>> rtnl_lock but not the netdev lock.  
>>
>> Doesn't the DCB core take the netdev lock just like netdev_ops? Or it
>> only takes the RTNL?
> 
> DCB is not covered by the instance lock.. but TBH purely because 
> I just always forget it exists. Feel free to make it take the lock
> if that makes more sense.

I'd leave as it is for this series to not increase the diffstat and room
for probably bugs (as other drivers would need adjustments in that
case). So I'll make ice to take the lock in its DCB code for now.

BTW, if it's not top secret, how do you run these AI reviews? Because
Tony used the same link as these reports provide to deploy a setup, but
we didn't manage to get as meaningful results as yours. That's why
several respins of this series only due to your AI reviews, sorry =\

Thanks,
Olek

