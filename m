Return-Path: <netdev+bounces-254757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMXnCJE/e2mNCwIAu9opvQ
	(envelope-from <netdev+bounces-254757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:08:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF8AF673
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA761300F694
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C13859DA;
	Thu, 29 Jan 2026 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMLK7XiT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C03859C0;
	Thu, 29 Jan 2026 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684628; cv=fail; b=IBFh+tuiq2fbmTItAUFNZ2W21ISHSkejYMHWd8lhYPmFUlEihvgDAPYxppUDdvTPyoKEaCpREvR+D48BwQnt+MBF/xLygIOKbddG7tmzS11O9oRNbYKT5iNVCJa0lPm4iHG+xyq5rtGBHcd4CpPhQ56JXMret0FqBSm+GMbbX7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684628; c=relaxed/simple;
	bh=Q9ck2msIV4HCQWTPJJcVAGuCA+H0NrSoTM8bG6wh6AY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQQg101+ey/CNhQe09YdRj+GrViMZbQ/1v9X0QHntDvrnfuaKOZZmcfJANO6dQk4/KRRV8tf8KmnqwU+haG5gGZttGgjDO6SxuucEoBvcIktKftkg+4NhAdtQspd1AVFa2wOduYWwoSDYivCmXtyxcE9MSA9RQ+2ncH5Z2p8MVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMLK7XiT; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769684626; x=1801220626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q9ck2msIV4HCQWTPJJcVAGuCA+H0NrSoTM8bG6wh6AY=;
  b=YMLK7XiTOh/PC9tlVyswEOJTSJX0AWzWKHceifG0jcL0+gSrr9BSPRgT
   gxkB7DkU4YOgSXIjT5WRxB/rtLv5ALcRt2jqbftC6WllslhR6C7c7E3cK
   Msv//dlmTdPbTmjb7NqmJ0ui1FPV1+jVlEuEFcrVgphnrai0X75sm3zYC
   5UWiHLYy5MinZeEFsavIQZL17nilgeiGs2dPse11c0xTv2sIKoR+Pkmox
   2d+xCinvNdRDVdzLU4UVOIGm3VE1wBBxO32lcfbVPS4x4gMLFFO5hPsH8
   uCL6r5UxTlAIqO9Q/nANMUdlq/KoBkLZcTU/VCNs0F2D9JOWIEEARg1qa
   g==;
X-CSE-ConnectionGUID: dKbM/VyJQbWIi6B6mttJYA==
X-CSE-MsgGUID: 0E2YMaf5StK+IZDkCU0jQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81234498"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="81234498"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 03:03:46 -0800
X-CSE-ConnectionGUID: z2FgJgvuRAKt/RCeskHKig==
X-CSE-MsgGUID: g6EzF8LKTXmmjHqfHXJK9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="213510654"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 03:03:46 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 03:03:44 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 03:03:44 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 03:03:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uomSUZKbDIWAm85B8ucchiYbQ5NmvCkClmAWUSFhHOzeGr0T2btMWCSUziWcK4opU42puyy4ZuINaIqsuoelzCRQnMVpjFbLk4Ch1MfPtznQm8bab8PraLAKEv0lrPLxbA4/M51gym4ue0B4hDo45rBMe+9KZrC1T3VPj0tDwpkelC6Aym0mPCtrViLf6yMwGkU6jP0v/czBefMcNr6fYo61ES+468sRqznc8NH59NWhKGfaR5TisCEgezCt4Bm/MHe1QqFU5qvdDCRFF2XAPvWfPx8wV+VVBrVZTQMON2ujBiVKChH/sz6xLzk+5orNiJAjpEBGH4PSb39Rxv8cqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHUdeMrh0owa9gE7onbAMvD8KH9YU8zM/hl4dzz4IRk=;
 b=ArfAdtOnfiXDYeIq3KgyZY+47cj1AQv5+h7OhyWcryP9mphXUTcTj2q8mBwe6a2y6BqP1Xnuos0XigB24jqW/BvOiFXk2N4zn/7XgITm7AAzWRVxxkV8ii4pIZqZg4bz8/Z2OnRtbPIbBRGKJu4v21NCKSzB7Ts5HDc7AKfjwL+7arJsgHmUKmT3xZwZDE4vGqkyo7hDwx436esDQyEIACxAFZS4PlqIm+n567D4gMvKA0KceOVVnmog0A6p9SmwW+GyXDy6kvypuJsDe0tCJOnJxdC6tbiKQC77/+kK0Zj4WfK9PI9D9SmFO26wVGJRoX6MK3/Pg8MVnuci+dInLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5152.namprd11.prod.outlook.com (2603:10b6:a03:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 11:03:35 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 11:03:35 +0000
Message-ID: <93f55dd6-44a5-4309-aed1-30e352cd2825@intel.com>
Date: Thu, 29 Jan 2026 12:03:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/5] ice: add support for devmem/io_uring Rx
 and Tx
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: d996cf54-55c2-43a9-8969-08de5f260c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1NQYzJSZ2FDbStxNWd2VWxteGNkRnB0Ly80cE9ZVC9FeWlnYVlTSVNjUldz?=
 =?utf-8?B?ci9EbkRWRllFRlYrZTQrYVJtYkJFU0JNOTY0My8rNEE1WEFKakdOVzd0U1BN?=
 =?utf-8?B?SHJ3ZFlhbTFEMHg3WFZIM0Z6dTZWdi9EK2VYUDRKU3NaSUNuQWdJaGxCdENO?=
 =?utf-8?B?UkJxNUN5WXNSTUpHb3pVODVPd1BxWC9DSjRVVUtiQUJWbTQvb0ZHL2tCV2U0?=
 =?utf-8?B?NFpBcHFFWjdJZmhBUTA2OS9SWCtqTGZyQU1LOEJwc1NPNWRsMng1UVdUSm84?=
 =?utf-8?B?ajdnTnk0a0ZldGhERCtQa0ZLZkJyb1Z1Y1dSZU5CbGtBckxXbUNTUzhBVnA1?=
 =?utf-8?B?Z3ZnRk9FTmY0RXUzV1ZkUkF2aXR1SkxXbW53L1FYVi9SR1pJSlNFa2NsWXNv?=
 =?utf-8?B?T0N6WW45ZXBvdkRRWWcvNlh4OHBJSFpieTNOUWszOGdEaG9xSUU0TVVRd3gv?=
 =?utf-8?B?S25mdTdEOVQ5bTgveWxFMHJZT1JXbGgwWUZ1NEFyYzdrRm13bUl2Q0VRUW1l?=
 =?utf-8?B?OTlCbGJVWVhOaitOOFJCeDBncStLRENySEtjdWRSbFFqUStjekVjRmJ6K2VH?=
 =?utf-8?B?cmdDeWFocmNCNWxDc1hPRGFUdUdoZGRKWVJaSWk5ZnNqV3BZWlpLb0dIOWlq?=
 =?utf-8?B?SkpkZnZpWFFmS05hYVQ1SkZhcmdiZm5MRERrMkdndTdXZnBxZi9ZdHlPdW40?=
 =?utf-8?B?eTFJNXlrbnpiR21QanVVZVdrakNlNWNSS0h2c3hQZmJ1M0RqZjJvQUorNjc5?=
 =?utf-8?B?ZEtkWUM4SWlUNys2Mi9hT2VuY3dwN3pub2tJNDFRWWtRWS9SRkZHdzJLdzhS?=
 =?utf-8?B?M3dKVUJCd25DNTFFVkZIM3h4ZG1ESkhULzl4cXFETHJIMFJwcXZESTVCcFhj?=
 =?utf-8?B?YW9DSzdqNU14V2xrSDY2OVhpaXBpekNMMmY3QktsU2xkWUNacnBiVVhUdFQr?=
 =?utf-8?B?WUZRNjQ4b0g0Sml6YkVUZ2RTSTVqM3RaSWd6VnIxK0V2cjN0blRNaEZlS0ti?=
 =?utf-8?B?WEZWRjdHL1pmeGsxRWlMeHM1cXl2TW9HcGxhMmNKK2xORDhXL01hMmlUcEJq?=
 =?utf-8?B?N00wd3JVK1MveGJQdWlpSFYzemd5azlXcWlQZFRPNjBUcGhqNE5XK2dqdjZi?=
 =?utf-8?B?eVpld3NHTGwwR1ZKb28yODFGSStla2d1dmVBZ1JqQUpZVXNod0ovMnF5QlJL?=
 =?utf-8?B?VUxDdjlKQ0ZLVXQ4TU9jVTRxOVpsWWFBT2IvbEk3Sm1pblVEU0JGUnRiMHdl?=
 =?utf-8?B?am41QnBuVXRvanBka2E0OHg0bXZMUmNqNHgvM01lSlBTL0hiN3lKbEY4dG5x?=
 =?utf-8?B?dUVZYTBRRkQxYWJxM0VmMnlLQTFDNEZCVUhWNW04UUFTUlBaNjZuQm4wNGNH?=
 =?utf-8?B?OVJoQ2ZuUlVzMXgxblNSeFdaZTRWUjQ5VStUNkdQMWZxMW5JRDFTU21QMm90?=
 =?utf-8?B?OHRhVUNXZERPU3NQOHpvYjFnRnh0YnV2ak5CUWJINGpGaCtqTmt0aENpK2cx?=
 =?utf-8?B?UmFmTjZwdWNITW1aeHdEaE5seXg1WWhNNGNzWDRXcmY1STJwQkJXZjNqUWhv?=
 =?utf-8?B?bW5rOXpqUVBZQ2ZxLzcxZDh6L0xMdm1jMWtiVXRKcEVKKzVtVEszWHdSMEQ2?=
 =?utf-8?B?aW91Z2QrL2JaekMrSjdFb29WdktSZlVzOXYyK1FiSnhzQjkzekdvbEM0RS9D?=
 =?utf-8?B?VytETVpOcmRUMU13RTR6eDRMaGg3elpUbk5GQlNINi9sWFB5WkZiM2xvVGxE?=
 =?utf-8?B?eVVMUEFLYzg0bS82c2o3eEh6VWlIOEp0Mlc2WE1oazdiRUVDdVRNWW5WY1FI?=
 =?utf-8?B?Qm12WktPODQxNUhQNVNHN1NKU09WUlg3M2sxVDNaQkRkYVZiY2tJbnJEenkr?=
 =?utf-8?B?TkVjSHpiUmFnMXpoeHhBWEw5SUp5MVZTTVU0eVgxQ0c0K2xqakUxRUxRS0Jz?=
 =?utf-8?B?QnhmbStEdlNuVmxuc3dGQWxIYWdBc3BsZDRlL1pQdWNvS21QbnN4VE93ai9r?=
 =?utf-8?B?ZFNrVnVyejB0UyttU0FLcHJ1SlVQUUZIQ2hVbXp6WW5FZzE5RHk1ZDIvSmpT?=
 =?utf-8?B?S1hGbzZJcUVLV09pbDFFYitISitEbTluck0wQ3owcktlc3lrVlg2Ym1GN280?=
 =?utf-8?Q?COes=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDcvZkpxME5ZYzF1d0hzeFdsNFpjdEcwN1hFT3BiWldhRk1IQkVGelloeDZB?=
 =?utf-8?B?M3lIYW9YbHZzTGhtaGZqa05VQzhBeC9wa0dhQ2p0VUNYaDVTUFdncFlPVkcz?=
 =?utf-8?B?N1ZkRjNCM2plWmliRllMb09UZVVadFIzQlVTQ0JPUlY1dzVaK082bENKeUdM?=
 =?utf-8?B?V2ppc1BoZHpTVVRTMDhLaC9TMnN3SzdwZE9jVklDNHdQcld3VDVwdGxSa003?=
 =?utf-8?B?eHVhbGVCVlVQWm9uUnRONkR3emthMWgyUmVaOGVDUnlpQVBMdWlHeWlHT1I4?=
 =?utf-8?B?djd0bi9MYTM3SVVMdXRlZGYrWVFGTlFMT21mdGNZUkl3TEI5dlhmVHNqYzJV?=
 =?utf-8?B?cGNjV1RYVTRVc1J1bHdOSzgwQzRwcTJkYysva0VhTVBTZ3pzU2hDZlFSOGVw?=
 =?utf-8?B?a1BtNDZKam5haHJ5Z2FaSkdQK3VuUkU0YWx3MW1XKzdMNE1zTGlzN2NBdXFX?=
 =?utf-8?B?cjlQWVpISGo4bElKSFZSa2N1ZkxsOW0zNlVreWg5RXVrNURscEF3MElsRUxT?=
 =?utf-8?B?U1JjSTZNeDh4QWZGVllpS3RnS1lWSE1sbDU4dEdrbnFYaDRIUitFSmVSVGxp?=
 =?utf-8?B?bmFibmpOQ2Nha1MzaDV6THExaTBDWVR1ZU5VRTcwOXFlcU1nemN3dDVZVkNw?=
 =?utf-8?B?RnNLS3F5Ty9nR1RoRVRhRzhGK0g4c3NteFUzVTJHWHAvMnZzTFpsWEgwMjBF?=
 =?utf-8?B?NVBTeS9aTHRMQlZRUDR0ZUdvR25OK0I0a2IyRExtLysyK21wckU1ejlzdWRs?=
 =?utf-8?B?a0tNZlMrY0tzUXYwMlJ6NDlUTm5VUHB0bDRNZWxFRzV3NjU1WVlEQVU3L01J?=
 =?utf-8?B?azJVZG9qWWVlNjFJN2J4Y3pUTzFPaUlSZmFWTkJORmx5QktVTnR2Vy9MWDJD?=
 =?utf-8?B?M3hOcTFNYS8razRhSER1dit3TDd6TXQ5RGFRU3BBTUR4SXhwajRLekFBZDlu?=
 =?utf-8?B?L0d4b2hiWmpZNHJYWm9uZXg4d2V0YkZxY3FlSmNCTWZNZDM5NWcwMk51bSs1?=
 =?utf-8?B?THlYR1JSVkMwaEd6ZXAvelk5LzJ4bGR5bWwzWVZiODVOM08ySjB1aFo2dlVV?=
 =?utf-8?B?L3VYTzRCRngxaU5Vd0pMYlBwaCtQTGpLVUZkcEUvUk03dWtYTCs4YWJBaXE2?=
 =?utf-8?B?T09IL2o4VC8xZkEwckJwY1grcWZ0Tko2T0ZHQ2h3TWtyT29yQzBmNnExRXZN?=
 =?utf-8?B?ZWFyYWY3Ry81MVhCdE11ZE9EVXRLdE5YVUttNTRHdys3eFdBSmpGekhMenF4?=
 =?utf-8?B?V2szWllaOSsyRmFwMlNrUjRHV2JpYy9WWkNHd2o4clQxbko3UTNlU0FMOVZM?=
 =?utf-8?B?ckJYWGovYjBKNVlRSHVlRC9HL041bm1CWGNQNDhoSXREczM2dVB2SEZycUNU?=
 =?utf-8?B?ajlpaWd0am9GdURvVkF6UWFydUZmTmlaRUQrVDYrOENvdGc4M1hZN0Z5RXI4?=
 =?utf-8?B?R29xbUVJMWoyaDhLdGs4UUFpOENIcVNKaVhManlsMlFwK08vSHd4a3dvVlBj?=
 =?utf-8?B?SHgwc20yeVdRencyVWlsSGFKQjJySzk5bnNzb0xhQkRocVdBdWxMalp3Z0cy?=
 =?utf-8?B?Q05UTmdjVnFvWTJ3d3BDYmVMU2toMWhiNVV3OW8yaGxrM1JPSTc1WGQwb1cz?=
 =?utf-8?B?bVZVSVpQLzVmYXZuWFdGbkQ0TVNvMmlGeC8rYVNMTGJIdGpSa0J0K3BRbFlV?=
 =?utf-8?B?cTRJekc5TWI0eVBKbFN1aVdxZ0pGNXVob0JENTI0M3lNcjMzVVBXNmNYKzYx?=
 =?utf-8?B?OEhQVlFrbE1vZlk5d29pei9OWllYSTUyM2k2V0dkK1o4aDdydC9ENGdrWkFK?=
 =?utf-8?B?NTVqQXVmNFhmalpJOU1PL0hNMkkvSkgrWkRKMEtiSVVNQmhRNXlSN29WK2s5?=
 =?utf-8?B?cDFTY0dyNmRTZzJ3RnRuZVZ3K3FweDFTSXVSbElKZEtYQWJQRmcxRDNYRjNR?=
 =?utf-8?B?RE9wR2FoeHZxTXowV0x0YVVqSDV0VnNvR2dPK0ZNTEVaNU9MSVhRUWpqa3B6?=
 =?utf-8?B?aktTWkc4dlZBTkJJQUtuRFd2dkFCelFneGJ0cGNPbFQ1d0tCOWF3azNPbFRN?=
 =?utf-8?B?VWpmQVF1VUtpSnZnQVloeUFia1h2alVJclRYUmdZSnJPU05NZko0M0pGZzNm?=
 =?utf-8?B?OFdKZnBrK21IRTd2M3FzK055c2tIVkdDcDJPVzZHNyt0aVREdDVwWC9JOXJr?=
 =?utf-8?B?Ymw3VzJrRUN1Q1ViQjNDTlBPdmp4QkNKUGlIQkw2bGpQMGhyRmt5TC91cHJQ?=
 =?utf-8?B?UlNvdks1MEhVbmdUSHVzektJVDJ1NWp2NkFCOHV0bDFpNGoxNS9RWUk1QkdO?=
 =?utf-8?B?VXVUTDRRUzFoUTJGUE9xU2J6cDlwTkg0REE4bUs0MUZIS1pzQ1RETkJJUCt0?=
 =?utf-8?Q?R4fFY1va7Qn4g0Ug=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d996cf54-55c2-43a9-8969-08de5f260c4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 11:03:35.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hp7d5plaLzItcT20j5Gs588+6FUre/iHw6ULs2Kb7WX4tvRaqmlEuwGDEHHMsRQY6yzXtE45rDQdsf4wQg/cr28yF5pC7hyFWXDG7AW5ixs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5152
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-254757-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devmem.py:url,iou-zcrx.py:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3CEF8AF673
X-Rspamd-Action: no action

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Thu, 4 Dec 2025 16:51:28 +0100

> Now that ice uses libeth for managing Rx buffers and supports
> configurable header split, it's ready to get support for sending
> and receiving packets with unreadable (to the kernel) frags.
> 
> Extend libeth just a little bit to allow creating PPs with custom
> memory providers and make sure ice works correctly with the netdev
> ops locking. Then add the full set of queue_mgmt_ops and don't
> unmap unreadable frags on Tx completion.
> No perf regressions for the regular flows and no code duplication
> implied.
> 
> Credits to the fbnic developers, which's code helped me understand
> the memory providers and queue_mgmt_ops logics and served as
> a reference.
> 
> Alexander Lobakin (5):
>   libeth: pass Rx queue index to PP when creating a fill queue
>   libeth: handle creating pools with unreadable buffers
>   ice: migrate to netdev ops lock
>   ice: implement Rx queue management ops
>   ice: add support for transmitting unreadable frags
> 
>  drivers/net/ethernet/intel/ice/ice_lib.h    |  11 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.h   |   2 +
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |   2 +
>  include/net/libeth/rx.h                     |   2 +
>  include/net/libeth/tx.h                     |   2 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c |   1 +
>  drivers/net/ethernet/intel/ice/ice_base.c   | 194 ++++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_lib.c    |  56 +++++-
>  drivers/net/ethernet/intel/ice/ice_main.c   |  50 ++---
>  drivers/net/ethernet/intel/ice/ice_sf_eth.c |   2 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c   |  43 +++--
>  drivers/net/ethernet/intel/ice/ice_xsk.c    |   4 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c |  13 ++
>  drivers/net/ethernet/intel/libeth/rx.c      |  46 +++++
>  14 files changed, 325 insertions(+), 103 deletions(-)
> 
> ---
> From v1[0]:
> * rebase on top of the latest next-queue;
> * fix a typo 'rxq_ixd' -> 'rxq_idx' (Tony).
> 
> Testing hints:
> * regular Rx and Tx for regressions;
> * <kernel root>/tools/testing/selftests/drivers/net/hw/ contains
>   scripts for testing netmem Rx and Tx, namely devmem.py and
>   iou-zcrx.py (read the documentation first).
> 
> [0] https://lore.kernel.org/intel-wired-lan/20251125173603.3834486-1-aleksander.lobakin@intel.com

Current status from the validation:

* io_uring tests pass, except for tests which try to setup RSS Rx
  contexts -- after recent changes in the kernel, seems like at least
  some of our drivers return -EOPNOTSUPP when trying to configure RSS.

Tony, did you have any related reports or planned fixes?

* devmem -- only the Tx test fails, may be related to our complicated
  .ndo_start_xmit() logic in ice, I'll investigate this as soon as
  I get some details from the val.

Thanks,
Olek

