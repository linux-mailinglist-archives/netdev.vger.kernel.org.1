Return-Path: <netdev+bounces-164931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C666A2FB7E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3684B3A41C7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D36D1C07F6;
	Mon, 10 Feb 2025 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMD+oQy4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731A158874
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221908; cv=fail; b=NsDhRx0S5M7sCwPbv/YoSGAorG9DEuDMbW8tr7g7Qjz8tAi/KcykbzIDUat0XKtP8XDlGIcoQjEvET1LMS8T6M0ipdjwplgBIHh84g+LyXhTLVan46Euohlfa2FKr+mrkNC+lkUn1CY0C24XS7m2taxgYLJeiOh2uYTrsqIAg08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221908; c=relaxed/simple;
	bh=y36pUe/RxaQGt9A4I9iWAxJidmghi2MM/lMtgD9+Ji4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZK5tm8oUOotf3I3W1zRT6DEKEHaVb+Vo1FFtxGIAjEzT7jFe2+TviLkLYTaw5MARCGjDFdMv7vevw/ZvNouxPpd6iEHISHoHy+nX8eR2U9Cdk39XUQa9W3NXU6Gc/1eln1+nn+v3HP2eiUpep1WLx8Vh/F/3xRY8otpDEztXlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMD+oQy4; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739221907; x=1770757907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y36pUe/RxaQGt9A4I9iWAxJidmghi2MM/lMtgD9+Ji4=;
  b=aMD+oQy4XT4TZM6W7A24lgDfvxaO1waY0JQ6eOJE1aDKRoTMhcrsNr0a
   /0AbDZBn2Mlp6aViuFDN4BaM9IjBezPfaDcmGcnSc/U8gcXe3ApbT9p4F
   J17I//wYdxSZav4SkcrtOnGgdzRE12NQa3e4b/6bD+weBOBJWBLVmK0DJ
   eWSHdTS+V4wGLeyV/BVGUEslmZc4R76c0T9aR9vvaP9BtD+Tb0vWQXXGm
   o9mMVQhC0lupHUVR+bajAmLh4Qg48XvzRkWI/xeDYMiu1jwavEe52Zytq
   4WzeFnLI0afitq2+pg05bEGffw69uVTaNau7ocDT3We/sg2kTmUrJ4IgM
   w==;
X-CSE-ConnectionGUID: T/YKPEdhQ9qafVFgYi6zlA==
X-CSE-MsgGUID: Cfdi+QeiSYy7XvxqwSn2Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="27422606"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="27422606"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:11:46 -0800
X-CSE-ConnectionGUID: vVs5sfyGRiO0B4viymfg/w==
X-CSE-MsgGUID: F01M9Uq3QOWZos6v95+oPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135570524"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 13:11:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 13:11:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 13:11:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 13:11:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RY8oss3oaahMu8hLqW61L/YDhidpIY3J958c1zNRZU2tuxH+7LM0QDKAS75Htruw8RaOLkBAFztmn7mg0OHm745elc6SGDZRbg80tWeyhAgSH4ttnOdOK6pHsfxWIohi0pR5Gt+mh4NL/c4E4vsmS8nQNp5qatjsHWo3DgoIay7EvempnADxRkAgpUQDxaF0d2iiny56vlGfyuW+LW5526OHOFJ7s41ERcCld1M3kGrl4djR21XqKxvOOpAaBXl79rSlqdAjoLWPuTkc/ugLpWoEkzNJF9L5tifN8pb7aGZfMjayTr5XyPM46cFpCJrJxi7AQ23RCYcT7DTpkJ+Yyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw412H6KWVa3YMbIOYvIwegai3GzWfurjIdTP5oCb1o=;
 b=mU0v583TICW2Smemt/xiJ93o9T9tY0Ho3yG3rbDIcPCsnzf7WP++mo1b6FJhMp7t05Cx38JShTEjipDWJyxewpojGWQ/+A1Mu7tgTbWH/iX1jX295ZNqjBEC108EqG771xUlkvtI4FiPpyoOoT+yD7Ey9l158FciuS8sr77WOdHMW95iP4BoobrD/iMc3lFWSf9npcn2OXoJHgvpO1KsdNFRfMafsNifMjrqdaAm37vNdgQJTGNQE6DZivFdlH9MKmnybWr6pck6l0J3fqID8X/jDB6LCcY5TrtJ/aNcRf4XcPFxg9JKdwbeTQzIDFEbnDbzSt7hokbZ6OgE3UulWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB7906.namprd11.prod.outlook.com (2603:10b6:8:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 21:11:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 21:11:42 +0000
Message-ID: <158b8192-c33c-4ecd-a4dc-de565f05982d@intel.com>
Date: Mon, 10 Feb 2025 13:11:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/4] sfc: document devlink flash support
To: Edward Cree <ecree.xilinx@gmail.com>, Jiri Pirko <jiri@resnulli.us>
CC: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>, <habetsm.xilinx@gmail.com>,
	<netdev@vger.kernel.org>, <edward.cree@amd.com>
References: <cover.1739186252.git.ecree.xilinx@gmail.com>
 <3476b0ef04a0944f03e0b771ec8ed1a9c70db4dc.1739186253.git.ecree.xilinx@gmail.com>
 <p527x74v7gycii3qfgcqn46j2dixpa62tguri6k2dzymohkeyw@rqqmgs5tbobj>
 <116cc011-4e4a-12c9-0cba-3097c6e85e0d@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <116cc011-4e4a-12c9-0cba-3097c6e85e0d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be358ef-fae9-4cc3-c950-08dd4a178455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGF6YVVjR2FGekx4OWtOVEZpOW1vYW1tY3dSYnNabTVLd09LbnpVTTkxTU1Z?=
 =?utf-8?B?bWlVcjhlR3VVcVRnSXVlbnp1UjZteFRId0J2SjhGRmpGZDJIRXBXTnR6UU82?=
 =?utf-8?B?cXd1WFFpVm5WMU5XbGNqQ1E3YktoaWlQekovRm13UWVOQ0NMUlRuaUI2S3NI?=
 =?utf-8?B?UlhwL2RUTkJSR0o2QjF2U2NFTDhaaGNJMWFSTzBKOU14eGhxcDdTdnRrQkVX?=
 =?utf-8?B?N1JMYUwxa3NzYjRJK2hFVDAwZGVPTVBORWh5THNsbmRCd3RGemVaek1RRHFz?=
 =?utf-8?B?R0RtNTl4aCsvdktyQ0Ixb3BneUpPb0NtUERFcmE2WE5FV1lwWXZ5aE85S1Fx?=
 =?utf-8?B?eStuTlVwU1piUjJwMkVnTG5uT01HL3JVU0ZHTm9Nb0VSZUFRZHkwbXR0bWVq?=
 =?utf-8?B?NkR3bnhISmM0OXZjckJUR0h3WjhtM3hZM2hZczZrcVhZZWJwcFVpMDNKSEk1?=
 =?utf-8?B?WmV5K3E0eExOWU1IQ3Y4QU1oRjJadVFlMW9STkwxZDVaRjB2cHlDNW1GZWdX?=
 =?utf-8?B?Z0NxTGNaakRjbHhVL2JhNlIvN0JIcGlmaEhxekpHSDVKak05MGhXL0VyUjlT?=
 =?utf-8?B?bGJ2Yzk0dEVNZE1iMFFmODJuUVZac3ErczJiYXJCc1RnZjRDVjJmb3BrZUJt?=
 =?utf-8?B?K3o2TkEvTTZZcnBITzdiV21GV1VmUVFNbGtOcllLNk40R2kxQlUreGhoNEM3?=
 =?utf-8?B?cUtwVlRMQ3pVaXpiQUtWeFppZTNHeW9QTU9rNHF1MmtBWk1wZlBhaU5XQzRJ?=
 =?utf-8?B?YU81Uit3RUZpZFpjVlBtdUxoQkl0dkhrL1FSYU5oQUVvZVU5UlcveUtmNHli?=
 =?utf-8?B?dUd0R2g1YXY0S25nYXBXUGtRaHIxNDdtRm9Sb0dYUDRockpoeHU2cHNMODRi?=
 =?utf-8?B?NWg4cS9iVmVIQTFwVVpRTXlZcXBxRmFqMWM4Z1JpWVU1VERLZktESmdxb3l3?=
 =?utf-8?B?ekNqQ0JwNFZTSzRoVGNIZXIybnhvLzAzWWRtV01TMmpZZGJCanVISk8vUlBs?=
 =?utf-8?B?YUFjQnJ6K054S3dvUE5ZYkwwZFdPNTQ5ZmlPYkJDS0pJWi9WdHRMU0FpdWhP?=
 =?utf-8?B?NnlCZVViaGRwOWk2VElUMjNaQTZFdzlXd1dIaHpTOElEREkzYlVZa08wTytM?=
 =?utf-8?B?TW05ZG85TkhkZzQxOTdVdkpTVFQ0eW5tVitBak1EdnR5R3VnZ1hHMTZYQTZC?=
 =?utf-8?B?bXJrZk5tcVlYVjFlRWJRYS9EZWxpL0JIWTVydWJ2ZG1VWlVFSzBFRHI2Qkcx?=
 =?utf-8?B?aGR6KzdLbkk3bFdVOVlxdllRODZ6RkxjVmNMODJ2K2UyalFaZ1NFUVF6SWVS?=
 =?utf-8?B?RmdIWTBoNGVZRzRSRGtFbUZRai81SGZhd3RtVU1SVVJKQmY0WkVXU1phOW9w?=
 =?utf-8?B?MlIrYkdlbzFWczUyTndZKzBRczdFYjY1YVB3aHplTGRHc1ZRMWR4dUFMZkFZ?=
 =?utf-8?B?MVFBZ2JYa2xCWFdhd0JMdm1ZcnVKZ1dEdHJ0K0RrOG9ONit5dUJhbEN5alRC?=
 =?utf-8?B?U2NJTStmM0RJd051UGtveHBDanpqVXJMMkxlc0JERnljRmNMRTlzTStiNGpl?=
 =?utf-8?B?RkVNU1JHT1dpZzlpQVJVcTVxR04xK2lvQWNWQjFFaE9NbE5lRTc5dE1UZFNR?=
 =?utf-8?B?a2d1N0l6Wk5sLys2NjZWdWpRTC9JTTJqZ0FKZ0pQdTg1YzNwQldocUNCV3Ur?=
 =?utf-8?B?TmxRdXVNY05kOCt4d0J2SmJYNmlnQWRDRUtpWnlnUmpVTWlBZnhEOGhFQmpt?=
 =?utf-8?B?cm1uekpqTDloTXMyTFBRK1ptR3VzeWRGb21TVGR2NVhDS0RzUElPWFNVMEx3?=
 =?utf-8?B?NllBQ1Fzd2RCRU0vOWRJajh0YXlxem1sVGZvL0FrbzVrenY2b2JhM0diRjRm?=
 =?utf-8?B?NDNWZXhNeWVVSGlVR2sxQVhsTVJZZFRqZnRlUURlTzczS0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWZWSitkdEZVTnhYQ1BPL1E1YldBT3V1SlVSd291eGRGV2JtOXJVOElNNXFW?=
 =?utf-8?B?MDFpV0RsWWtZUDd4UnhtQlEwZi9UaWRxSVppQTI0NzhpdXI3bTlCT2JOckR4?=
 =?utf-8?B?Q3RPc2M5Tkl3alU5L09WOXFkWUhWaURxTzBiRGg3UTlMcUZ3dTUyVzVZbC9t?=
 =?utf-8?B?Q1Q4MXpmQkp1MUVyQkpMSTVOUE9kVE93SFpCOEJhcG1EaVZHMDNrRlpJaEVI?=
 =?utf-8?B?TStzSUF6c0dJNlp5NUFHaTdHdVN5SDBDQm5BRW13eDdFaFdPK1loNTNQWThp?=
 =?utf-8?B?alBXbXNZeGIrdXFaM0J4SGFMaWYxUU96dzBIWmJVY0tDMDVwUU82aGNkUTFE?=
 =?utf-8?B?TkRGS1lJSGtHYUN1aXlJTkJQWjhYK0V5Q1NlNzdtdzFrWFVOQjM3RkdSNW1Z?=
 =?utf-8?B?cXpSL2M2RWUzMldwdWhDdGNqOHBYZlUzRWNqcDdNSU5jR1R5M25oVGlhd1VB?=
 =?utf-8?B?emhPeTNBS0Jhb0d1TExYaHRRWWl5eUMwVmp6ODRURk5wUlJiL0pzd1JGUXdv?=
 =?utf-8?B?NDQxMTVJMWFKd0wrMWpzQ0dvaVFCVjh4VTE2cVF6YXRuTElxUitFckVEYkdj?=
 =?utf-8?B?azl1UWhFeWp0Znkydno0TlNTT1FYUFNRNGpvcFVWWXc1WU1tdEFqeVR1aFdk?=
 =?utf-8?B?NDJCaUtmTytIRURONVVPWUJpN21qbkJkYUJuMytxWS8zRUk5M0cwdmlOOGk2?=
 =?utf-8?B?SXgrSytodk5RS3B3SzBucmN6d0N0WWNQNzhvODNvZTA0WTh4TGJIWXI5T0RN?=
 =?utf-8?B?S1NUejVYSFdFd2tNUHpsM3dQUEVobTh3MFg5NmcrbTZBYm5XMGJCTXEzbGpS?=
 =?utf-8?B?RnhMdkVxbjgxZHJCcDY2VjFmSXZsMEJJRXc1M01URTMyaUt0UEVuaGtTd3ND?=
 =?utf-8?B?Q09peXN5dWRzNDZlbHFzMzV4NGJaYkdGS2s0dFZHWUtZSlNKSEx2TE1tL2ZE?=
 =?utf-8?B?dkUrN0FUak1WUW1Oa0ppQ3cwc3o2NXA3R1VTNzNSb3JORWZqVXcyMURUYlBt?=
 =?utf-8?B?YVdqL3dCQUloRjcxOE9uKzZUVnZ4Sm1QSGpDbHV4SjM2RWN1ekw4SndTV1lF?=
 =?utf-8?B?N1J3Y1ZVU3NaTnBSdld5MDQvV3MrSVJ6bnV5cGRlcUNmSk9iaU5JTmpEc3J6?=
 =?utf-8?B?NSt0b3YwRTdzc3piUmF6M2U4WjZJTkc2bVB4eGd0RW54YVA5MjlwSFNNNkU4?=
 =?utf-8?B?Y1h1MXY2ZXBvbzdHRU8yQ3laWjlQM2M4N0RsTjZ0ZEltaEszaXpvbFJValAx?=
 =?utf-8?B?cmtYUXRGMnpsUGZoUHJ3dzdBaDZJM0RLVXNUVElMUmVOTGFJYUE2ZGlIeVd3?=
 =?utf-8?B?TDgyNWV3R0JpeU8rTmw4NHMzN0pGcldFaEl2TS9pd2ZjN2VVbkdQVlRES3pJ?=
 =?utf-8?B?SkE1dmJqcGhEME8vRGlIVllYZ1pIRit5dytqSzBiWEl1QzdGL0VwRzd1Z2xy?=
 =?utf-8?B?T0t5SDR5Y0YveXZtQlY0SngrRHNFM09wRUJzMmJHTUxvTVNSbWNhVytPYnNs?=
 =?utf-8?B?OTk0RUlJcEFvbW90SFpTODgvRVJJNkhlR3pBYXVGeU9hVWM2azlKa0thTlhC?=
 =?utf-8?B?bUg4VjlNdTQrNkVRR1R5eHpUaXcxSUdjeVloSEtIRUk5ZTd1Q2Rvd3pVYWJI?=
 =?utf-8?B?dVIyMTQ0dnIwN2hhbldqYzRTYTNQZWh4cHVCTVRHbW00U2NKaVlBYzVSNWpm?=
 =?utf-8?B?Rld5YnI5UWtPMFZ4N2k0R1pFNUhrbTk0WWpCTmxaSWxiNzNFRTBxRnR1VDlS?=
 =?utf-8?B?V282OE9sK2FORmF0cTdPWHhRTTEzUnd6MXN4ZVM3TDdYM2pzN25DeWFYM1RX?=
 =?utf-8?B?MnpkTkZWdHI0TjhVczEwdkQ2TlpoVTdKcGJVbVR2SFJiblRubnZ3aXpHbUVw?=
 =?utf-8?B?TnhBbU51L3R1aUdnempLNnNWOGFXS1B2NDFkYjR4L3RGQXBtZEpBVVZXczhn?=
 =?utf-8?B?M2psQUlucytBY2VOVkpsTGRhMmpvclVNL3RBMExSbzZpZHdLOWx1MEZTampq?=
 =?utf-8?B?SHNQUTNtcHBTUmJ0b2NSNDB0MWJTN0NnWG5RODY4ODVTN3RUcXY1UHNmZFYy?=
 =?utf-8?B?Tk1BS2tWbUFPRDJ6NHN2aVc2R09JUWUwL2NXVi9hbFRFVWxMaEZmM1laY0dG?=
 =?utf-8?Q?j3fqjYxCTB6QVToR8DbdzE0/H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be358ef-fae9-4cc3-c950-08dd4a178455
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 21:11:42.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjJcE4xj2PTyU5zPe2/2byOScjGtzcBuVYFeTriL9fpvxKaq4ADzo7m4/EkJ+KT1Z+eKv/slmWRUioLMsexFZpfyCLBfgxfyPIu2501NxHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7906
X-OriginatorOrg: intel.com



On 2/10/2025 6:50 AM, Edward Cree wrote:
> On 10/02/2025 13:51, Jiri Pirko wrote:
>> Mon, Feb 10, 2025 at 12:25:45PM +0100, edward.cree@amd.com wrote:
>>> Info versions
>>> =============
>>> @@ -18,6 +18,10 @@ The ``sfc`` driver reports the following versions
>>>    * - Name
>>>      - Type
>>>      - Description
>>> +   * - ``fw.bundle_id``
>>
>> Why "id"? It is the bundle version, isn't it. In that case just "bundle"
>> would be fine I guess...
> 
> bundle_id comes from DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID in
>  include/net/devlink.h, which git blame tells me was added by Jacob
>  Keller in 2020 as a generalisation of a similar name in nfp.[1]
> Its use in sfc was added[2] by Alejandro Lucero in 2023 but seems to
>  have been left out of the documentation at that time.
> The present patch series is merely documenting the name that already
>  exists, not adding it.  Changing it might break existing scripts, and
>  in any case would affect more drivers than just sfc (it is used by
>  i40e, ice, and nfp).
> 
> CCing Jacob in case he has anything to add on why that name was chosen.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c90977a3c227
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14743ddd2495
> 

Yep. The versions were discussed extensively at [1] and I ultimately
settled on re-using fw.bundle_id as a generic name rather than having
nfp use bundle_id but everyone else use bundle [2]

[1]
https://lore.kernel.org/netdev/83a7a25e-50f0-862d-f535-92d64d86fd4f@intel.com/
[2]
https://lore.kernel.org/netdev/20200321081028.2763550-8-jeffrey.t.kirsher@intel.com/

I don't think we can really change this at this point given this is
effectively part of uABI.

