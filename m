Return-Path: <netdev+bounces-149164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F919E4A2A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 00:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8FA1882B40
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC82B9B4;
	Wed,  4 Dec 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMtCif7O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A869191F77
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355827; cv=fail; b=W7OZu3cm/z+MxOFOrJXoVrE35T5SFQwKrTXpI022q3gnwBqpHLDZBKaW1pyeZvcVMjkEcP5gdDdEvZSx8krTdWsy1BZ+P5aF4V/xLOwEtYfKjeuXOkzVLR1Z1QXg4AmA+Ohz9CNDY3cKCKEJ8Mp2hlt8rS/2CvhYzijPOvOW91g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355827; c=relaxed/simple;
	bh=+DoSwEb/DRWfbF2oxJYuetsqa/7s6HQvonK3BlQCQ2g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EFrR0ccmztmMEuizdBq0qY2B2EvA8gfDk42OpIQ0dubEa7YGhVLO/9vSfGOUNrDKw9Aa1HAOA2c3fht70wb9XQNHM8wU4FtBp6lNzmhl9mHWv0MHFUirYqSBfzZeCIB43mqlaekoZvXsnZPj8dbEDx6Bq25FVE+yr2dAKRIjz1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMtCif7O; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733355826; x=1764891826;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+DoSwEb/DRWfbF2oxJYuetsqa/7s6HQvonK3BlQCQ2g=;
  b=XMtCif7Og7oEHxc0L87MPo+G4ECCexv8vTedBaI+drNAoxXxPceq8BEK
   30fh5WwFXgKtvIpgllEVATrDVR1sLaiagJJeF1Ry9AN1PRK3J7b/xiJLY
   uUgSsZp3XYhXRV6u2gZb6IDCmYaQ6RQfNIA3/G/oRrY22F11BdVfxfrTf
   EdE50RjYAvMuwaWEKd7A2CBw892gxKzTjPDTM4jD45dDur8xGBA5fnlMo
   OTYPTD63lq7DQ2ZX5Q+R02xUkK+ZBdlTRU2GlI3EKBhpZ3En51oiNvvgM
   +xZvc9OVlik+4N4wWTfn1R4zmMi8dNqfCskrzw3czD90BINGAItXlwHSS
   A==;
X-CSE-ConnectionGUID: OtHQyaC/S7Kz2Yb3FNdwNQ==
X-CSE-MsgGUID: FVef+OkyTc6jPF5DqMrhSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37424929"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="37424929"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 15:43:45 -0800
X-CSE-ConnectionGUID: NSNm3p1ETX+sJbJQ7PV9lw==
X-CSE-MsgGUID: t+QSSeywQ1SeDOYxzJgdkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="97978488"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 15:43:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 15:43:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 15:43:43 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 15:43:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s58x/ZFCdFrURp/dI7Vfby7sqyuJY8Byj4TET9SnXVXqiF43ooL1BmiSfvMxr0e4KLFbRGiQDtniB86sCYdKJCy9f1N7RH0mMebuusDWMJnKBDIy30ppFg5+BWqpfQ4hIpdDjxMeekDDIxvLDzEtpNh08g+hQkAsne55DDgFIlT/CzZjHRKI55SM7XyO8m6V1GZsOUAW9cKUNhDgus1to/jAlhscxmtRC4F6faPxo3z6FEQ9BXaol5i3s02BKjXDEto8LKxO+FNES3qgfFDjjS0T+kQf3/z4APMtzO0a2//PXnkdZhOXKo04YeyzT8dGa22Womkj7RZe57KqPzNv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FerTDGOkplx7a1staM1Bdyn2LSLbiCkKNStU69umjrs=;
 b=oKcFBz96xna00zBT51n/RLChceJKClpinuh2b630taCBl+NLoMNfkVkRSYU1QTHepq8kjJsicTCag023WpDWAzurih12Ptq8G0WUBfcsW9zcv4YQ+1TTyauRXSOXVf2NJ++7TSHCQcbwkstKPML0TykVJZXIopRMLE7avsAaSfL/KgqR05pMfALnUO6FJD0wvwAebYjxj8tF6KhUa1ifdgM3PL5QtnvXSDazhq4QNsCOAbq5uYzGfI434WuzCDqaPjBZjCP7annU73ApPDrUSbhOptR2+PJ5RgRLIo6E1eHcggvjVndBtFK17/hntNV585eay8dyWXwmnm4GjqBDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN2PR11MB4760.namprd11.prod.outlook.com (2603:10b6:208:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 23:43:41 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:43:41 +0000
Message-ID: <4c0cf560-e18f-4980-918e-8a322afd866e@intel.com>
Date: Thu, 5 Dec 2024 00:43:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/10] lib: packing: add pack_fields() and
 unpack_fields()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob Keller
	<jacob.e.keller@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Masahiro
 Yamada" <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-3-2ed68edfe583@intel.com>
 <20241204171215.hb5v74kebekwhca4@skbuf>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241204171215.hb5v74kebekwhca4@skbuf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN2PR11MB4760:EE_
X-MS-Office365-Filtering-Correlation-Id: ac159f68-44f4-4450-7e94-08dd14bd7b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RS9KNW4yQktUK3NJZkpWRjVvTkJTaG1SdDMvVjBjcW1qQm1yVWdLcGdZenU0?=
 =?utf-8?B?R2c3MDB6VU5LeEVkSXRETHRUWlVZTHZjSEN6b2NNVTgrd1pDd1VoVDNrK0s1?=
 =?utf-8?B?elQ4aHFhWUFheEZpcTNGaElJR0tMZlJqeVV3UmpYWGdacTY4Nk9Ya3JCeXJw?=
 =?utf-8?B?RXYxN1RjTmlCY0tuTU5wMnlIYlNXRkxvLzNXcUlJMUpyTjlrR2xLcmdLK3Vz?=
 =?utf-8?B?TFFJWFM1U3RPd29Kd3RhcDA0K2M4RUpqc2N1U0c4cmg0blAzZ0ozNlJzTmZS?=
 =?utf-8?B?OUNjMmlCdy9Ib0I3M0xFUkJwRDU2b01nN2JtT1JXNlZUMGh0NFZOMGF1RVN5?=
 =?utf-8?B?elFZUlFxbDQ2QlBtSCtmaE1LSDl6QjdpZGhMMUY0bmMzUCs3UzZVQUxBTVA0?=
 =?utf-8?B?SkR6dTlPQmNrdXJxTlhWR2V5Wlp2R0gxYXlUd0ZPSlc4KzBEZVprWExLN0Uz?=
 =?utf-8?B?MVk3MDBrTmhTRUZZK1BPMko2QzgrNW4yM21jYjcxcnZ4cEFCdUxSZ1pSRmpn?=
 =?utf-8?B?V0V6T1kxV0FMeTQ1UWQzZllLdHh5YmdUWlA2RFpUQmgxMEM3SDFNb3JGY0ZW?=
 =?utf-8?B?TEFtVjBmcU93NkZ0dngzUnBJb1hVdGh0cG9IdlpvNVNOQTFIRThHWkJXb0k5?=
 =?utf-8?B?amZmUzhNSnVVWitsNTFqVG9iR1RXY3d3ZDRidkZ0cmFSMkJLdlk4dWpqMGdF?=
 =?utf-8?B?TGxPZWlVWVlHamdWdHRLZ3NKUkRoR1NiYXRKKzJuSFRuQmxGa3JLa28vOE1P?=
 =?utf-8?B?bWtGb1NUUXJBSUg4K2NjSVZsRlRQTHVSYjVnUGdpSDRSM3U3dmNxb25IazZI?=
 =?utf-8?B?R05yQ0N2TE9ocExPMnlndmZqcVBDM3NhTDZoa2l5c21Cc0w3RHhjekpKVVJ4?=
 =?utf-8?B?cDNDVXpjcjZ4RFRVWTRzd0hHL0wzSVZCQUtQMm1vSDdVV05oL3ZJS3loY05X?=
 =?utf-8?B?UGFURURMZDBETENXdElCUGxOajZvcUtaNmcvYkF1bFRhVCsyNTRhNDFJcDFk?=
 =?utf-8?B?V0FBQWE3SnVPRmoyMXpyNHhhS1plc0UrWDF0TFNpTHB6QWlhQXNqNUpndk10?=
 =?utf-8?B?RmNpKzFzb0JBNE0zZzllYThEU1I3ZEMxV0FmdUVTdlQyWDVsRTZaSmwyZDJr?=
 =?utf-8?B?dVlXWjZUQUo2WEh6M3hUSUtveW9aUlViNGJ0WGE1QW5SY2FhblZEMXNUWGdv?=
 =?utf-8?B?Vk16Yk8vQzVSeTQxZXNhajJKaHZZQTVLb1VzWVZDSUFtSDM4NjdMNWJEZk45?=
 =?utf-8?B?Nk1hSzZmdi9FUGR6Zzc0OHA0M0lNTWd0dzB5dXdZU05PM0NDNWRCdnJaOVI3?=
 =?utf-8?B?OVpXUW1qcVlBby9EcHowRzIyVllkMmpweDVlVE9YRW1jNWNXMnV5eFJ1Qmk5?=
 =?utf-8?B?dzEzb2FkNTVMdWxvTGlxd21UMlpHQ2w2a0ZKb055UGszdXhMTUo1L285ejVL?=
 =?utf-8?B?MktyNmxxdzhlMUk5dFBIZUVkZHhxQjJQTTQySHZNMmhsV1JKaHhhMC8wRjRv?=
 =?utf-8?B?c3JqQld5ZmRkVCtrN1NiWXl3anhPTWNkS2tocnFTMFNDYVQzREhqVWVxZVJ3?=
 =?utf-8?B?YmcxUm1GZGZHVkpUM0JsTGlKeDZVZStlZkxDeVRuaFVmck1kRXNZQkJaeFdv?=
 =?utf-8?B?QXowMjUyQi9oSTVuT1U4dmVXa0laNHNGaTBUZ3hXQWYzMGkxV04wUjc0TTFo?=
 =?utf-8?B?ZzhWNVYwWE16cDRjVHprSlZUMlNIdFlPR0NJMlhqSEM4VVJCVEx4b01wbXRB?=
 =?utf-8?B?NUJja0thU0pacno2R0hVQmNlcmlsYkFmTGkwVnN1WldtVXFrdW5mNWZ5aTZM?=
 =?utf-8?B?ZjFJZXorMTlpK1pub3h1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXpLclNsN1ZiR1VaYStydU9DTDIySDNtY2prRXhqWHMxWUpTV2M5d01kWFQ3?=
 =?utf-8?B?Q2V2SmFFam9tOXVTamRvUmxOT2dxWmRNbklWV3ZQWndtMHZYVUhnVk9BMUts?=
 =?utf-8?B?Y0UrSHJOZW9BeWhyN1FqRE56ZTZDdWw2ZEp4VjJ4RndIUVJ5bDcxTlVvR0hu?=
 =?utf-8?B?ODVJaGs3ZXkwVDAxalBnQk85Z1JSaEVGeXlobCtncmdsaHdudDNDdDRybnIr?=
 =?utf-8?B?RHFBcC9wcGZqbmFSUi9UQ2QrL3MwWlVxWHd4SEZzL0h2VXNMcmJsTDNyUk1t?=
 =?utf-8?B?YTBwNnFaRjBucFRjdVpXaTZrWldvODdzWlhRRDBsSlFuZW45T0NEYy84MnUr?=
 =?utf-8?B?Vk5BeXNac1NBajlFL2VQVXN5UnJ1WWRFVTJaeGpsRHhpVmFiTThxQnJJS0V4?=
 =?utf-8?B?UlNGZGRvYmpDbVdlaG5OdDlzNHdqelAvUkZuaGJUcEJqeGVOc2lCU3UvV29m?=
 =?utf-8?B?RE9IcmkwUGhwOHorQ1duaStxanAvZ280TGRjNnJ0WFZJck9pdmlRNGlTb2pH?=
 =?utf-8?B?blB4Uy9GTXI4WnFNYnlGRUNHMkcyRk56dkhhVkN5VmVVNi90QUhBeXRiUTdD?=
 =?utf-8?B?TzM5YVkwTUhLNXQ2OWVZVExJUE8vR2N2VHAzRllRSVRLS0dLamxVMlIxM3FI?=
 =?utf-8?B?U2tPYzBWMUhXbklyQ3VhR2RHc1g4WnNhT1pFWUo1SVl5TVlyN01rM0lPNEFl?=
 =?utf-8?B?Ui9MUWpqNlNVNGJIWmZIS3AweTdqL2ZzUUJKU1dZQUhJN1dqMitRcHhyUXZH?=
 =?utf-8?B?RHJuYXJHUHRWaFpEQXdZYTJOSThtbXV6QzZNZG12STg0OGZiMHkvVXd0RG9F?=
 =?utf-8?B?SGRkaGI4OVN0eFp0aU1FcklYalNhcStBTTZXV1h2UE85NkF0ZUhMMlZxaTBG?=
 =?utf-8?B?a0h3eHRxRE5qdVJva2JmMTljSDJ2TncwcXZCT1p6Y2h6WlVTU2hTcThYRjlu?=
 =?utf-8?B?K0xuMHdtWExqVE1Jb0cybnpnRDZGbkJnR1ZyZ0ZUWE81N1R1blpsNlcyNk5T?=
 =?utf-8?B?Tnp3WDE0WWlUb2U5ZzlBSHgrTmtGazYvQ0FFYVNKYWJqV1lVWjFOb0tUUUxQ?=
 =?utf-8?B?YlBUMllVZDI4YXF2eDM1SmMwcHpic0V0Ny9QS21GQjBpQ2d5TkpzWGROdlFz?=
 =?utf-8?B?TktBM09nT1hEODV6WWE2MFFXZ2lncHNLTDRMcWZVK0VqclhUZ0Q3WTFQWXdU?=
 =?utf-8?B?TUVwYS8rejR6TWIzYyt4N1ZXS09YMVovRUVadVhPeWNHS3dROG5NUW5sWWFH?=
 =?utf-8?B?Zk5vM3lpaFVNRzFTemlxcUVIUVlPUWl4KzVFY3BCajVmSzhxWGtVUngrd080?=
 =?utf-8?B?cmZIUkJMNEVxLy9MZ3BoRGpKeVVBelFGOURqR1JMdnNTczB6OTNNYkRWZVlQ?=
 =?utf-8?B?OERKcysrUjRBcU1VU3FqeDhwT1RHTzhDT3VBUmJReHpQRTNSNXF6eFhaZXBo?=
 =?utf-8?B?d040eDc3bFNsL3BiN296cERyNi9MNlpLbTdxeXVkNmJHOVBkVGRWQXRlWG1W?=
 =?utf-8?B?T2N4Qzk4WUxCazJlWWQrWW9UYUF6eVVXMHBoN1gyOXBwSWg4Z0NTUW1pWWht?=
 =?utf-8?B?bG9YeHI3Z0xod2huU25GM0lRdVBzWHNWdVJsVkJNZEpRbE5RTjVBWnZmbThm?=
 =?utf-8?B?T0hzQ0xZaUFXYUljSmEyeXVqMmNOUkJCTlN2aVpvREZGNEJuMGdrRWxQbEZF?=
 =?utf-8?B?b3ZvajVFWVd6dHUrbG9qT2lURGh6b0hEVEJnc0dqbkJSQ1RuT3E1TUovMVNO?=
 =?utf-8?B?aWlWaTcxRDVFZGtIa1ZFcGNaMzNUN0ovd2p2eXNTYXNpUDQxTDlkUjhUN3pu?=
 =?utf-8?B?dHJkOFJWRkkvRHZXelp2VU14dlQ2eHhIVmVmK3JlMmt6cGlWalNPZGZxUE1t?=
 =?utf-8?B?TTNicUZFSWU4ajZ4S2JoVjJCSUMrcExQRGNPTDBCdGNxL0EzT1dFc1Z5eGNB?=
 =?utf-8?B?VFBSZkhnUjFNTmlKNWZtTnpZSmNrSGJXQVVnVEdZcFQrYkZ4SnVwTU9sUXZk?=
 =?utf-8?B?aVdibzBZNVdyc0JUYTdnOHJzVjV0c1ZTV0lCV0NSSitLUFlyY0NFamVBT1kv?=
 =?utf-8?B?cjgreVFTbDcyRGFNaUI0anR3MzV2SythMGh6d3FNbnBRZTJsOUVPc0pyL1ZX?=
 =?utf-8?B?d01SckFINXdrWEM0TjNXK1NsaW44dmVHWm9sU2NMY3dsVWRxN0dPdTg3YjJi?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac159f68-44f4-4450-7e94-08dd14bd7b66
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:43:41.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrhEkFrEEHCS4XOolAW6prudGEUl5ITmX9gmQx339XS6YQeALNm8DwZKpFd+Tv0YftpvtSmjKZftX7UzuXA+thdnVS4E07H6WS9YGBoydqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4760
X-OriginatorOrg: intel.com

On 12/4/24 18:12, Vladimir Oltean wrote:
> On Tue, Dec 03, 2024 at 03:53:49PM -0800, Jacob Keller wrote:

Amazing stuff :), I really like the fact that you both keep striving for
the best result, even way past the point of cut off of most other ;)

> diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
> index 09a21afd640b..fabbb741c9a8 100644
> --- a/scripts/gen_packed_field_checks.c
> +++ b/scripts/gen_packed_field_checks.c
> @@ -9,15 +9,9 @@ int main(int argc, char **argv)
>   {
>   	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++) {
>   		printf("#define CHECK_PACKED_FIELDS_%d(fields) ({ \\\n", i);

[i]
@i in range 1..MAX_PACKED_FIELD_SIZE; inclusive

> -		printf("\ttypeof(&(fields)[0]) _f = (fields); \\\n");
> -		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
>   
>   		for (int j = 0; j < i; j++)
> -			printf("\tCHECK_PACKED_FIELD(_f[%d]); \\\n", j);
> -
> -		for (int j = 1; j < i; j++)
> -			printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[%d], _f[%d]); \\\n",
> -			       j - 1, j);
> +			printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", j);

[j]
@j < @i

>   
>   		printf("})\n\n");
>   	}
> 
> And there's one more thing I tried, which mostly worked. That was to
> express CHECK_PACKED_FIELDS_N in terms of CHECK_PACKED_FIELDS_N-1.
> This further reduced the auto-generated code size from 1478 lines to 302
> lines, which I think is appealing.

a lot :)

> 
> diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
> index fabbb741c9a8..bac85c04ef20 100644
> --- a/scripts/gen_packed_field_checks.c
> +++ b/scripts/gen_packed_field_checks.c
> @@ -10,9 +10,10 @@ int main(int argc, char **argv)
>   	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++) {
>   		printf("#define CHECK_PACKED_FIELDS_%d(fields) ({ \\\n", i);

same as [i] above, ok

>   
> -		for (int j = 0; j < i; j++)
> -			printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", j);
> +		if (i != 1)
> +			printf("\tCHECK_PACKED_FIELDS_%d(fields); \\\n", i - 1);
>   
> +		printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", i);

prior to the change CHECK_PACKED_FIELD() was called on values smaller
than MAX_PACKED_FIELD_SIZE, compare with [j] above, now you call it also
for the MAX one

>   		printf("})\n\n");
>   	}
>   
> 
> The problem is that, for some reason, it introduces this sparse warning:
> 
> ../lib/packing_test.c:436:9: warning: invalid access past the end of 'test_fields' (24 24)
> ../lib/packing_test.c:448:9: warning: invalid access past the end of 'test_fields' (24 24)
> 

off by one error? see above

> Nobody accesses past element 6 (ARRAY_SIZE) of test_fields[]. I ran the
> KUnit with kasan and I saw no warning. The strace warning comes from
> check_access() in flow.c, but I don't have any energy left today to go
> further into this.
> 
> I'm suspecting either a strace bug/false positive, or some sort of
> variable name aliasing issue which I haven't identified yet.

PS. incremental diff in a single patch is harder to apply, but easier to
review, comment both in a single reply == great idea

