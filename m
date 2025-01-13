Return-Path: <netdev+bounces-157787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DFAA0BB91
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E83165697
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D181FBBE8;
	Mon, 13 Jan 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQXhXUF0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532A1FBBE0
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781203; cv=fail; b=gcQXBxO/rNONiYan1sNNmKG6PRxt4tZ6/nFLxW/MEIhdd5/JmoXel9z6NnNWA8zv/YYyRffeurD3WEeVweYpXDLmaZfdVGvW51LBcBl+q92YBG8RX86er2tMzmt8p6ZrF5vz9l4oWYSYWYz2cVwPvWSXbX+SUAuwtRcFir+gJOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781203; c=relaxed/simple;
	bh=ASr2sOhhREO6t5lRunhpw2WSivWEUFQvHtQLn1mlwbw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qWkFbOnBvM3Wl7f2CXYVizr1P9FpzTHC1XmQz3iGIOC6+nNr91tqy3e8KgLyrL0VtfoJxp0v5K1XisRseNOT50YPUi914MUX3o3bI7kDNuju3OKUo+OtCx4apMExsYpoc0hpW2DuQsCwWNB2MWnJNgKkRHrjKNPpa+X0G9Rx0Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQXhXUF0; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736781201; x=1768317201;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ASr2sOhhREO6t5lRunhpw2WSivWEUFQvHtQLn1mlwbw=;
  b=TQXhXUF0ogafegdwRZx62mMjP+9iz3w+10eTQJamdjR9zIiQrUaVx6ka
   EcER9W37ogD4ySc17gj8ocPIXd7xvWbK7fc78eX8BE5FfjxEIh2XZT+7J
   FYbpjU57pzUib2BT9V3UhrhmKxMsL7ufNdJddvB73mOR/3r5KndzcyIyl
   1lYcRPpDvf+jpf0aRHdWFFU7zTsqG1OoOmygzl2ORkrTXU/R3MKCjNpD9
   9IHrmIen4oH3muj4ingdcd0tQ82I1yNkYzJOPOSn5ofCXha0FvDS+MT/q
   H4Ef3HCPITRpA8Qg2Jr4d5MKf5OeaMOoX8ZrtB921ndAkJpSjnTZgBDZD
   Q==;
X-CSE-ConnectionGUID: YCSqqwZLR1y7zEsAsKpxpg==
X-CSE-MsgGUID: WMS0E/VTTj+Dwq194Pmj+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48050796"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48050796"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 07:13:19 -0800
X-CSE-ConnectionGUID: nRF2xYGoQTOyhg/d9QxKug==
X-CSE-MsgGUID: KzREXQF9QvqquUJ3wwcWrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104461266"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 07:13:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 07:13:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 07:13:17 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 07:13:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssLfFK9BTGwhnKGm+EMVGjGUMFpnLF8B5qMFAG1bDLvpbvO5etKLmChb16EbWOC27EcSOBdsdhbhp/ZN4Ubnmu2TvepPmv1heQUbqib8n4jJd+oF2cqDTYGsY9ZZjSYSZOWuyY5GG4OQpuyvD+9ANHs7Oaey8zP/WBYNhPERF+O1JMWxEsAOUaxuXu6nAnVUTFHFkSqmBD6G58smsD0I3d1YgybgZhcYjZVxxU/QuZ3m59Smbukjo7PWAto9Yb87JaW1ZlpzUWHQmHFJVyDlX4An5bdXnbb3+tV1nEfQign8BCCaXN5USFDZXanQ79OtuhEm0ymQZO8trv/76Npy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxjWAxft20p1sFCFlzOldJmAhtjKE0Q8nHjQUiTIOlw=;
 b=PnSk2mnK14VijYnMgtK9Exp9CQRxC4AkjvjsfqCH5Z3gwjoAnkGGJLHIxw9CavoluKjSvyV6pGd8k+3nQ63b4o3OFEEf/hjWxxl/zUrj54WFJAHLJy1biSAcMOqUMuMj2Xd4KuS9mlbUURivlMKi7BUTEOmJWiHUGBwH9UExUdRUT6UCOJ34DxkX7VF6gK87Q3InsNMGxBMkeC0Iho5iClZ0+R02ZaUIuNxD2N7ZQHLsEX0gMmulExRD2vJAhYBu2NAVSDuaJgoI5dkeolkbxDZRkES/Px+6PLgXPrEDw4X7z5Elyn3D9fuEvl/wo0I4dpHsiXzhvPteSaIiqz2zhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6329.namprd11.prod.outlook.com (2603:10b6:510:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:13:10 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 15:13:10 +0000
Message-ID: <0be63e70-74bb-465a-a933-0258a45033a8@intel.com>
Date: Mon, 13 Jan 2025 16:13:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: txgbe: Add basic support for new AML
 devices
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <mengyuanlou@net-swift.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux@armlinux.org.uk>, <horms@kernel.org>,
	<netdev@vger.kernel.org>
References: <20250113103102.2185782-1-jiawenwu@trustnetic.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250113103102.2185782-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: b7396649-7ebc-422d-cdc0-08dd33e4ca7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGgrOW1pU2pIRGorKzlobjA0UDdsc0I3dzNmNmgzTU5BZEdPZkdtcHJhVUU3?=
 =?utf-8?B?SUFsYlo3bmpYUGFKTDZ3YmUxN3JKeks3KzNXYk9PVEFZVHJxcUwyY2xreVVO?=
 =?utf-8?B?SlVkaW44dFZDcTJFNHNVcnpMTTUrbUJGVkZ2NmdCU2tOKzNjRDF1RFlJUFo3?=
 =?utf-8?B?eGl0Qit1V0NtTXBGcmZRQTljQTl5YlhRQVJXU05VWGRLcC9RbkRycTNSNmxE?=
 =?utf-8?B?ZGJUd3NCYk8xYk1aYitzS2FBQUxBaUhWK2xwUyt1RHVXWE9DWmtiTlplRlNR?=
 =?utf-8?B?YzJwaStOZHdyMGJDdzk2N3EyNGZoSDRtVDVYZHpFY05UR055Sk1oSVJwOFZw?=
 =?utf-8?B?QmYyWEgwTVpuUlhEL2xLY0lUSmwwWWtTaFVGV3ZaYzJJMWd5bVlxUDFnV3ZQ?=
 =?utf-8?B?QjNwdE9ObFJ3VGVseEtQUmN0OWJ6SCtrU2doUjRtclNTenFkUDBoQ2w3Ymwv?=
 =?utf-8?B?UVk2enZSVlVISU05L2JrQVNSTWR4UU5OejlpRFBCZTVRL0xDVC82RVZyYlk2?=
 =?utf-8?B?SlNpbGJ0ZEdmUGdwNUJiSGY4amc2VWhwQVNuemQwRlE1OGViSHpvek1YRzF5?=
 =?utf-8?B?amJIL1ZaWllIa1ZyY3FsVUt5Z091TkJsa0xnR2hQSVJGYVFzWXVsdUFPTFU4?=
 =?utf-8?B?bnN4ZUE1a1NPMHphQXIxbTI4aVVHcE56SnFGOWFzY1ROWlRCNmJuVzlVSFQ0?=
 =?utf-8?B?eWtJb09MRng2RFF3TGNoT1lSUnhpZEJadzE5b1NpcXpDenN1NDl4NmZxZWlC?=
 =?utf-8?B?YXpxVGRwSG1uTXJsWnA1YXg5Y1VqNDA0YXV1Mi9CdmJ3VTA0b1ZsMHBDMVZw?=
 =?utf-8?B?eDZLMjluNzdxRnU0USt5NGxGdkVzd3VPeUNkNUdpcEhHRnd2bWV5OHU2ZTdN?=
 =?utf-8?B?aExCdHhFdDFkVlhhb2poTG1FOTNxSE1DbkJTK1ZPU3NkeGpMZTFXQkhkN1Bz?=
 =?utf-8?B?RkFBSEFwUWZPTFlRb0RGK0NwbzBBRmhHS3pSU004aml5OFNDbnpVUTdORlZT?=
 =?utf-8?B?aCs3Y3F2enFQMGV1Tml2cFpUTTFzdGFnczdLOHpHSHdvOXBoY0JjakdOekk2?=
 =?utf-8?B?Wlk5b1N5d1VUWU42QlhmZFFFbnBtVldTZGFCMnJTcVdXdXVuTklVZTB4cDZZ?=
 =?utf-8?B?TVg2bzk0alNUcFpXR213YlRDellrdTR1eGpobURMWW1uQ2d1b1kzeHMrTVlF?=
 =?utf-8?B?NW1LVlhGQ3BrL2l3SUxwQ3ZzejdlU0FHWGlCSFY3akFHTW5kS0phdUQzOExF?=
 =?utf-8?B?amFkK0wrbE04Ulp6M2trUk1iQjRVaDFHcHNuS2ZKNHVsWUZaUG81QjVJaFRE?=
 =?utf-8?B?NGdPeUNGbFRMcW9lQlpsT2JzVHAzNmpNNGZINC9hTGFsS1lGd1JNMFJwUFgy?=
 =?utf-8?B?VFV0SnZaQU1aWitOUWhFeGc4TllYK3NicHNkKzdEalIvWCsrSElIRGZiWE9I?=
 =?utf-8?B?NnJlTEFTV3pxUk9uT0VLVXQ3cDJhd3oxcENRZDFyK1VqbjMydzY1ei9EWmtW?=
 =?utf-8?B?OUNXL2Q3L25IdzFTUzNRMFo5aEV4ZW9NUEx3ZnNPWnNRL1VIa1RMRjF3Wnlv?=
 =?utf-8?B?dGxsajU5WldJZFVBTko4emRnTkN0aEpvRldwZjE3aGtwc1p1em1FN1VMemRE?=
 =?utf-8?B?M0I4dER5OTNXWFBIMjhrYzFIL0V0SVk2Zlc1TE12RmlEeUZtSjA3MHJRaW5W?=
 =?utf-8?B?bE5rR3lzMFcyZXFNUDdvL2ZNQ3QvN3ZsNDlsY1VoejQ1VXR5WGN3R2tQaENw?=
 =?utf-8?B?R3JMQmswL2tYZHBwU0orVFN6emlzS3FJcit1MWx5elJvWkVrWHFDUWhhai83?=
 =?utf-8?B?YTk3OVU0RXEyd0VQUlN6d0VDMUd2V3RyM3I0c1EvdXc0Vnc0Q2hWcnpDZWdu?=
 =?utf-8?Q?CsQZ/7Ca389U1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RllzZE9DT0FISEVyMGFybnJNVy9pUWpRQTRac3VXR1Fha205YzFPY1h4WHNB?=
 =?utf-8?B?VHNGQTJRbGplM0JxUTRIa1lpOXpGYW84dFRNSGRMeXJxSmJpZUpBKzBEejNa?=
 =?utf-8?B?NWRFVG40NThmaFcrK0Fvak5NbnY4YTRTVGJlWnFkUnJiU0lwREhvcU84azMz?=
 =?utf-8?B?ak11N1ltVTI5V3ZZTm9NRWFIdWN4UjJTVERuOXp6WjNSREFabVhXbXVGV3Mw?=
 =?utf-8?B?d2xYMEVDSnE2Y0N2bVJGcjZEdlh5bGcyeXZsb2NrRVlYWXFLUjNKMVdqWFhQ?=
 =?utf-8?B?WkdodEptMlRKQjdYbkVTNU01cUJqbk5oQTdMK1Evc2V4Ri9uMllhWEtIVTlP?=
 =?utf-8?B?Uk5QZldIdENrRlhRSEtWTnhpekVMOHdBbTkxVk4xN2d5T09xRnd2UmFRbklh?=
 =?utf-8?B?ZjFGUkpWTFVXclBCc1RibXVUczNFSHNrcVVHMU1EN216RVBZbWt4S1JxZjJ1?=
 =?utf-8?B?T0lIelNDM1JqYWh1RkhYY0NXRU9ybG1JdEZVenJMOG1SR0IxSkZtN2loUStQ?=
 =?utf-8?B?ODVzaGlpcTQvM3lZcjZyR3M5VjlSQVMwN3YvbzhVVzRaTm9MNzh2U2ZiMTFj?=
 =?utf-8?B?TXE4LzB2aGkvWTZKaWF3R0pIVWUvampIQUJvK010SFFrZk9pRWJBS0QrYk5w?=
 =?utf-8?B?QWlKaXFXN3NMMUF3Vmcwa1lLbkxGYzRBb3BuRDRrOFJXRCtxUVNTQ1FlR05G?=
 =?utf-8?B?eDRLTGdZMVcxamVlcnVZdXJtZHZqN2xNbEFpY3hPbUg2VEY2WGFqckc3bEhJ?=
 =?utf-8?B?aU9UY1N5L0ovNDBlZUhVTHl0Z1RsUXIxUElxcWlzU0VCL3JYdVgvTXBmSDRy?=
 =?utf-8?B?NXBLbFNRZmgyWUdYNE40NUQ3citVNGw5Wng3S2JxRmxqVGtLWStMRnpBVnNR?=
 =?utf-8?B?bmpkVDlLNXNiQ0xaaDBMRHhodlRiNThwV2MyWmp4TzlnUHh1bXpEb3N1a05l?=
 =?utf-8?B?SVRpZlRkR0pBaU5ja2ZUZE8vU0VXbjBvK0VHSWlXRnBXcU9kS0p1K1phcnRN?=
 =?utf-8?B?dlpRbExvMUFNUG1MVVhhMG0yTno4bXBiQ1QydUV3VmZrS21SNnNMdCtHZUpl?=
 =?utf-8?B?ZVZ1U2hFVW9VMTAvZFVXNzBxSXZFS1dWaFFDODBZL0RySDNQSHRsOEs1TkN1?=
 =?utf-8?B?L3F5a1oxaXhsalNzY0NkNVI4V2I1b1lRQ2h0dmk4Y3dxL1NWdWdTd3dSZHcx?=
 =?utf-8?B?YXc5QXRQdDJxZ0ZOVjR3OElQcUp2Ty9FQTl0dnBmSzEyMWdjNTlxdnkzVEg4?=
 =?utf-8?B?ZHhIc2J1WDFua0d3empJMWxBeWRITEpaU0RMREV6R2xkVkNnd3ZxSGovYUo5?=
 =?utf-8?B?RlcyRVhFQXV0NFJsZkp6bXZmeE92OWprU3VsRnEveFcwa0t2QzIwZlFKRWlk?=
 =?utf-8?B?NEFIcTZTMnh6SlNiOVRrZmFtV2RkS0JZdVpnVm5SVHM5Yi9kOGpPa2pXN1dX?=
 =?utf-8?B?S2pxVlRpYlpCQWU2WjFwSUR0ZE0zczdENkJSZGJFRmZ5RWxmN2xJS0EzU1Bp?=
 =?utf-8?B?SjI3VXAzK25pNDF1T1kxMmE3YmhRblFlU3NEOW5mQm83ajFKVWJsVTR2d2JT?=
 =?utf-8?B?VzlYV2hHVmdlOGJ0cDhyU1hWYmxZRVoranNuOUJvT0Nua2lkczZFUVcreE40?=
 =?utf-8?B?VEJXMXYyb3dlbXlTY3VPQWZESVVER2pRT0xQMWo0bFJFdEZlU0VXc1JZS2xa?=
 =?utf-8?B?R1ZtbDZ4bHRzRWtYSDc0WEwwNW5YQS9MVjNkMnlaak15YmxYMVJkYWkzWU1m?=
 =?utf-8?B?QlNQb2F3L1VWeVErMXY3emgzR0JPMmJaTnpQSHo4RzY1Z1AwZDZZc1RLbkxj?=
 =?utf-8?B?R1pqWStGWmJhUStMdi9CMEN1anExTUNhMHJ1RFkxcG1YZkR2a0FZdlBnNUti?=
 =?utf-8?B?ZFpQODhPNWxKQm16cDBVTkhNdzFpbWljNzFVQ3FXRzdSMjRDVTJDYlp0L1dq?=
 =?utf-8?B?amxzOXpvcXdUSkFoTStRWUlrZ1FSU1NoVWNOMXFkM3NvS09LY1JMdnhHcXk2?=
 =?utf-8?B?emx0VEFGT3VNaWwyZzVjdWxQLzErb2RPc0hncGcvMGE4aFYxVjNGT2h0dE5p?=
 =?utf-8?B?anJYV2I4NFY5RXVUNHIwM2p0Y3pQa3hIbkwxa01DZE9PVllUQ2lhT1d6N3lX?=
 =?utf-8?B?TW8yT1dZL1pyMjU3aVRmMEgrcDRFQTFpdytDUjFLM0pwODB0SDg1V0QyZlkz?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7396649-7ebc-422d-cdc0-08dd33e4ca7d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:13:10.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dye7SQU//uMxjfVpVS6tH2fUxmb03F9NZ46X1tzR0z+ymA1ULnNsWb4Vkt7sNYEVfSku4T6Bt9P3JN3pjBYkzVRujzt4OMbCN9HXsvH9pNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6329
X-OriginatorOrg: intel.com

On 1/13/25 11:31, Jiawen Wu wrote:
> There is a new 40/25/10 Gigabit Ethernet device.
> 
> To support basic functions, PHYLINK is temporarily skipped as it is
> intended to implement these configurations in the firmware. And the
> associated link IRQ is also skipped.
> 
> And Implement the new SW-FW interaction interface, which use 64 Byte
> message buffer.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
> Changes in v2:
> - Add missing 40G devide IDs
> - Add condition for wx->do_reset != NULL
> ---
>   .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  44 +++-
>   drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 209 +++++++++++++++---
>   drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  25 ++-
>   drivers/net/ethernet/wangxun/libwx/wx_type.h  |  27 ++-
>   drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |   6 +
>   .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |   7 +
>   .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  43 +++-
>   .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   6 +
>   .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  14 ++
>   9 files changed, 328 insertions(+), 53 deletions(-)


> +static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
> +				       u32 length, u32 timeout, bool return_data)
> +{
> +	struct wx_hic_hdr *send_hdr = (struct wx_hic_hdr *)buffer;
> +	u32 hdr_size = sizeof(struct wx_hic_hdr);
> +	struct wx_hic_hdr *recv_hdr;
> +	int status = 0;

"err" is a better name than "status"

> +	u32 dword_len;
> +	u16 buf_len;
> +	u8 send_cmd;
> +	u32 i, bi;
> +
> +	/* wait max to 50ms to get lock */
> +	WARN_ON(in_interrupt());

the comment does not belong here (@timeout is a param, not a const=50ms)
the warning would be better left to be triggered by lockdep
(sleeping in atomic context is reported then)

> +	while (test_and_set_bit(WX_STATE_SWFW_BUSY, wx->state)) {
> +		timeout--;
> +		if (!timeout)
> +			return -ETIMEDOUT;

it is rather
ETIME 62 Timer expired
not
ETIMEDOUT 110 Connection timed out

> +		usleep_range(1000, 2000);
> +	}
> +
> +	/* index to unique seq id for each mbox message */
> +	send_hdr->index = wx->swfw_index;
> +	send_cmd = send_hdr->cmd;
> +
> +	dword_len = length >> 2;
> +	/* write data to SW-FW mbox array */
> +	for (i = 0; i < dword_len; i++) {
> +		wr32a(wx, WX_SW2FW_MBOX, i, (__force u32)cpu_to_le32(buffer[i]));
> +		/* write flush */
> +		rd32a(wx, WX_SW2FW_MBOX, i);

do you really need to flush all registers?

> +	}
> +
> +	/* generate interrupt to notify FW */
> +	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, 0);
> +	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, WX_SW2FW_MBOX_CMD_VLD);
> +
> +	dword_len = hdr_size >> 2;
> +
> +	/* polling reply from FW */
> +	timeout = 50;
> +	do {
> +		timeout--;
> +		usleep_range(1000, 2000);
> +
> +		/* read hdr */
> +		for (bi = 0; bi < dword_len; bi++)
> +			buffer[bi] = rd32a(wx, WX_FW2SW_MBOX, bi);

no need for le32_to_cpu()?
(if so, reexamine whole patch)

> +
> +		/* check hdr */
> +		recv_hdr = (struct wx_hic_hdr *)buffer;
> +		if (recv_hdr->cmd == send_cmd &&
> +		    recv_hdr->index == wx->swfw_index)
> +			break;
> +	} while (timeout);
> +
> +	if (!timeout) {

you will enter here when operation suceeded after exactly 50 steps
please check inlcude/linux/iopoll.h for ready wrappers instead of
reinventing them

> +		wx_err(wx, "Polling from FW messages timeout, cmd: 0x%x, index: %d\n",
> +		       send_cmd, wx->swfw_index);
> +		status = -ETIMEDOUT;
> +		goto rel_out;
> +	}
> +
> +	/* expect no reply from FW then return */
> +	if (!return_data)
> +		goto rel_out;
> +
> +	/* If there is any thing in data position pull it in */
> +	buf_len = recv_hdr->buf_len;
> +	if (buf_len == 0)
> +		goto rel_out;
> +
> +	if (length < buf_len + hdr_size) {
> +		wx_err(wx, "Buffer not large enough for reply message.\n");
> +		status = -EFAULT;
> +		goto rel_out;
> +	}
> +
> +	/* Calculate length in DWORDs, add 3 for odd lengths */
> +	dword_len = (buf_len + 3) >> 2;
> +	for (; bi <= dword_len; bi++)
> +		buffer[bi] = rd32a(wx, WX_FW2SW_MBOX, bi);
> +
> +rel_out:
> +	/* index++, index replace wx_hic_hdr.checksum */
> +	if (send_hdr->index == WX_HIC_HDR_INDEX_MAX)
> +		wx->swfw_index = 0;
> +	else
> +		wx->swfw_index = send_hdr->index + 1;
> +
> +	clear_bit(WX_STATE_SWFW_BUSY, wx->state);
> +	return status;
> +}
> +
> +/**
> + *  wx_host_interface_command - Issue command to manageability block
> + *  @wx: pointer to the HW structure
> + *  @buffer: contains the command to write and where the return status will
> + *   be placed
> + *  @length: length of buffer, must be multiple of 4 bytes
> + *  @timeout: time in ms to wait for command completion
> + *  @return_data: read and return data from the buffer (true) or not (false)
> + *   Needed because FW structures are big endian and decoding of

In other places you were using cpu_to_le32(), this comment seems to
contradict that

> + *   these fields can be 8 bit or 16 bit based on command. Decoding
> + *   is not easily understood without making a table of commands.
> + *   So we will leave this up to the caller to read back the data
> + *   in these cases.
> + **/
> +int wx_host_interface_command(struct wx *wx, u32 *buffer,
[...]

> @@ -716,7 +731,8 @@ struct wx_thermal_sensor_data {
>   enum wx_mac_type {
>   	wx_mac_unknown = 0,
>   	wx_mac_sp,
> -	wx_mac_em
> +	wx_mac_em,
> +	wx_mac_aml

always add comma (,) at the end of enums that are expected to be
extended, to avoid git-blame churn as here

>   };
>   
>   enum sp_media_type {
> @@ -1026,10 +1042,12 @@ struct wx_hw_stats {
>   
>   enum wx_state {
>   	WX_STATE_RESETTING,
> +	WX_STATE_SWFW_BUSY,
>   	WX_STATE_NBITS,		/* must be last */

BTW the entries expected to be least should be not ended by
the guard

>   };

