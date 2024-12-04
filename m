Return-Path: <netdev+bounces-148911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE109E3640
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C476168A05
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3781993BA;
	Wed,  4 Dec 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJhktzAU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E41993B5
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303420; cv=fail; b=pGApcbjvW6nq7McGevko0jAzmdBdRqqk1nnhOdEefIr/E2SykgopvFMAw81ONZi3qGWAmlU4lLHmTo36Br66lvEZy6HGUXb65WRPBKMb7Ffx+p0/B9sEkOo9LqNzrd39/X3Jr5pmgsyvSOMNs2lheo2HOOM6P+ENC4Y7wmxGUhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303420; c=relaxed/simple;
	bh=o1VPdkXBd5KcmVibsrSk/YMuqND43vYbW1/T5PSK7oc=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W64P1a6DeuVMKowbqiNdleq64iHjWENwnGuTGq0yxSlcpLCvnueGIoAijWFeRTSQGSc47Vg49zDNNHnFXEDG/IevwHtQF1BNpYE//tCvXQGC9m9i1z5mR9VO30bcdvLyaCZvs0TwCXACGPFcHaCDUme5MLEBiuC76NaIGHu4U3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJhktzAU; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733303418; x=1764839418;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o1VPdkXBd5KcmVibsrSk/YMuqND43vYbW1/T5PSK7oc=;
  b=LJhktzAUk6uWDjVQGCMml14703cHn9CV6tqJ+VeX5Hqua8Npwg+lSdLp
   Y2kb2JUy76vOf2h/TODgFxABgJEiw6c8RUxmSZ+GfqRfs/NNcLww811Ap
   F4k1fUBUVSTuQ+HwpsGg7+RHS3xYfIDSNcD7IqitFq9wT1dhQr6mNIDUH
   61Cs8I0QSVDxiKr9lfZRvs6CsT/4jBo2OBlIcNsgj6u3KQ7CWFzM++DVu
   y+gMSQn+KgMQQ0pv01IqBw9HAU4gb/I5cfrTSY1G2tmPPu1Ux1A78d30E
   I8gKFf+1TEvDEyPHFhU+MxhV38cXtocWzI/thgO6BraCEywDZcAppvpNW
   g==;
X-CSE-ConnectionGUID: Du9SAQkKRlucndejz9RM6A==
X-CSE-MsgGUID: u/ZkTQARTAC3uwuVm8RSTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33617846"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33617846"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 01:10:16 -0800
X-CSE-ConnectionGUID: sXFxEOdzQyGOn5EVFR9xUg==
X-CSE-MsgGUID: HbWXb+/jQKqLthmWf2RISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94535650"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 01:10:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 01:10:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 01:10:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 01:10:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdFkqIZEgVcQPeH+gduy+DIb0+V5hamb2gDYeVzC2Mzthy6KpXmSiuSLnoCWLjA7IVc64mJ+9Kl+FmLfZjKRcn3OH9RMQwS2OuD2ekgu4Np4mxBoPSQjdh4jye7B2lC679DVnag4/hp34BWkSsxmTEdgnWfsCUT+nPucNNUfIdI1TFzeDd80XVVSUNFZO5im1OpKLa4U3/mcLeVV24M2HtOFxvYDYYWLIkOv3QZYv321yciB6Ea6JyQq5Cjk06ZBxebqOE3s6rXlit3qtCD6Uq+x5xSQQFIHC/9DY3K+U1LWYSAtihUruSTE236snHXpsS6C/IKV4zERA1/zVujQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dloUIdQuSTjiIql4OAK2NNBOyPXXQFslHXnw6/mSjhI=;
 b=vJmeMovboQyzdkAvZd2kbElL6wGXtlJ2DdMGPwqTyhBVpPV4HPojDIGeFh4s0+yKE6Ob1N73/WLI170z5jBsyWJirAr7V9YnBxSbd0IUqgP1iz0VZRDfTVsoYFOwBE8JEd2s+OTf2q6elPGqIS561uuihy0zxS4eVfP7kH0w/etQ2WjYGLyjDnrADqxWF6OTGeCdXfb9ogJSh/9/ZthLdjKGLyLnREuIZREysGi2Lt0oMEvHdMGeRa7nB5XvKe1vTanTaPy1nd3l9jzPuZNQEth9XrsPAZQ+InRrhyRTrUI/in4FRsZo6PmhFhjPSzw2dec/7LWO5MRf+UwpzbiDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 09:10:01 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 09:10:00 +0000
Message-ID: <94ab7f28-c74b-49c5-920c-a3a881de0b86@intel.com>
Date: Wed, 4 Dec 2024 10:09:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCHv3 net-next iwl-next] net: intel: use
 ethtool string helpers
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Rosen Penev <rosenp@gmail.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20241031211413.2219686-1-rosenp@gmail.com>
 <d97614cb-1798-46d2-a3b8-88fa100d9765@intel.com>
Content-Language: en-US
In-Reply-To: <d97614cb-1798-46d2-a3b8-88fa100d9765@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0145.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::38) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: c63c7333-98a2-48a7-1aaf-08dd14436e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3RJWVRxZ1ZEbE1RWWhpTUxhdzJKT1czMnBYa1hBbkl6MXZYUFN1OGJPbjlR?=
 =?utf-8?B?ZTBoM25HdlJJTWp2SlZWaHkycFlLQjl5MWlJQUFPYkxBbTdqQ01SbmNzVml4?=
 =?utf-8?B?MWJobFVWdzltZmdOMmZvT0ZpMllRNHdhbzlaWnMxajc5MzZSVVZ3djFQMW1W?=
 =?utf-8?B?M2UydmJLdFFVcStFMU1zOWI5NVc2SzIwRjV5V0h0aktodXlxTmwydjlNa29r?=
 =?utf-8?B?TG1rUnk4emhpMmJUbktOejRqWGFLUkthc2VlSmF3eThqOHVDSVJ5d1psYm5a?=
 =?utf-8?B?U2lTNXRvS3BPdDFWazJST0ZMV3VYSUdhV3ZTUHZaZ1YwMk5SM0QwNllSb3Mx?=
 =?utf-8?B?RExVSDFCMGhVNnVxdk1WMjltMW1jNVlnclFLWHZ3Z1BqdTB6S3V4WkhqTlVa?=
 =?utf-8?B?S3l5UmZNbGlpYURDaDZaS203NlZLcVNOUGtRcDgxVGVTM1NSQkhZMEdOMGc5?=
 =?utf-8?B?Q1dxN0IyOEIreklLTnMwRUNWazVab3Z4WGNVRjIvZ1FRTC9kT2pxVXRBYURx?=
 =?utf-8?B?KzQxN1B2YnM2UFRlVVVzVXNENDlPQVhUeWZFcWt2UVlKTWsvRGNka0l4eFpU?=
 =?utf-8?B?bUFuOFpGMEloYWYvZ1ZyZ0hpUXFCZUNlNGN2SWJ4SkFDdk5PblZOcHkyNTlD?=
 =?utf-8?B?YVJOQlJTcFovbXJ1NU9pdjFYWnVUamhFQ0dVcEgxUTJ5azZNamFLWUxoL0dY?=
 =?utf-8?B?WlZtR2pnbmRPTkJ0b1BKZVFiVjZ3Q29LcE82amJiS2h4Ri9qYWhVbnlDeDZu?=
 =?utf-8?B?eVFqWnBhRHVxc3ArdFBLcC9sU0xEbFlMNHpMLzh0VVZrTE5BUkI4bmNrNloz?=
 =?utf-8?B?SWFjN2JlVnZBUzhDVEZDdXRZdjdoSU5LTkNzd3BrVzhKb1FOTGRZSG85cU1E?=
 =?utf-8?B?Qno0cXhQbEJaN1QvVUtWS0ZEdTRoYWhsV1JuRmFyNzVlMWVnQkVvRmF0RnNy?=
 =?utf-8?B?Q1JKSXFNK0NDS1JDSS9ZQzlZZXpSVWE0Y0EySCs1WnZha2VOekN3UUpreFdO?=
 =?utf-8?B?OGs2NFpGYVlrVENPanljOE14Qi84dldGN0ZQc0JaVmZmc2VBR0xNbk56S2ZB?=
 =?utf-8?B?NGhLMDhxcGtpcnRta2taNld6eHdlWVhaWFJaQW1JWXBZODZYbTJJM3ZpcVF5?=
 =?utf-8?B?ODZUUERMQlNiTVpNYmF0YmJPWkhidTBZYzgrQ0NlYXMxcEtPS2VNZlpTUmJq?=
 =?utf-8?B?Sk0wUVBVWEtPRXFrVE5Ed0JObFRmZTNsbWpEMXZKSGJvVS9kQmVYM3lUMWZH?=
 =?utf-8?B?dEZTNUtGUUM0ZXNGeDl1OGhXVVlyTlNsdklkanZqQW9PQlFQWnNYRkw3Skwv?=
 =?utf-8?B?TDYrb2xkaVduVmVYVDRWM1dJaExYK0svN3hvNE1MenNDRytXMTRpRFJTd0k4?=
 =?utf-8?B?ZjdDd1ZPaGN2Z0hPUkwzMXQweTMrTktrU1lQdjNtWkducW5VZWNqR0R6N0Vm?=
 =?utf-8?B?UjVVZE9zZ0lZS3BNeHBEcGo4K3BhRUpCUE4xTWpNVXA4bFNUVGltUVZwczA0?=
 =?utf-8?B?UVZGeTltaThXVGN6L01WbXVvN0NrcHJ2NUhndklITHJuQVgvdjZJV0E1ZTRt?=
 =?utf-8?B?UTlxODZMeGdoQ2lIMVZHK0tqYUJFVHN5ZVdTaElJTmU5bWdYRnNDc0tvb2tI?=
 =?utf-8?B?WDNOLzk0MVYzQmZWcThTdGpWdGwxaTZ6VVFuRHRPKzNUTk01bldTTkpQWTMr?=
 =?utf-8?B?aU8wTzdwSm16L01USVgrK2dHbUVuVFR2dzBUVzZNMmdHRkZqU3dGYzdBRTY1?=
 =?utf-8?B?Zkl5eDE2dDlwL0lXaUo0QUNpWHVEcENiK1V3cUZxdjVoMHByODdQNE1DRyta?=
 =?utf-8?B?QjlSS2MzTVlhYUlIZVovZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3RiS1dWbHowRjdyaGxBTmZRY05kb1h6U0FLMnlxSnJFNlFpZFhtdDY3cWhs?=
 =?utf-8?B?SjNxaWkrWjlhV3RUMm54anZXMjNOZytaK2pHM1JWVG5vdW9wT0JGODlJbTY4?=
 =?utf-8?B?aWs1b0ZMRlR4YTkyZFV6ak5LaVFSdlZ6T3FUb1VtdWVSMEU4Y0l5MHJ5NHVW?=
 =?utf-8?B?UVcxV2JSYnBYclZPc0dWcXNTbTZCdmVhN0UxamtKc2pycUZqbUx5ZFlHU3c4?=
 =?utf-8?B?Z2NJVWRlZTBzWDRSNnMzV00wODVwL2ZwbTJMcUdDRlBQY2ZQN3RQa050amI1?=
 =?utf-8?B?Q0pETjJma0VvQ3hyb291M0dRdjY1aDlPS2orNlRkMUkzeUZVRzhkNW12SHlx?=
 =?utf-8?B?dlM1alVITWwwUEp0Um9ucGFWWUlPVDVRZllINzQrZk8wa3ZJY016VWljUEgy?=
 =?utf-8?B?cHJFUVJuMXB5b29LREI1THIxSGlDRlBwaDl2U1ZPTGhSYlR4ZnBONzg4UkVI?=
 =?utf-8?B?eVIra2FSVm9SL1pkNGhVRzBlY3VrN3Bld254UWs1ZzcxR0wvVnVWWDhWR0lQ?=
 =?utf-8?B?UlYxZ25TV2g4aGw0UFkxWVBISHVJb1N0QllrN1pUd24vOXRyN0cyTjBaL3A2?=
 =?utf-8?B?Qm1aa2x1VDJNODI3QUxjT2tQc2JWbUZIbnZmZUQxN2hGYmZPV2FnaGlLbC9a?=
 =?utf-8?B?WmVsd0RPWWhnSy96aGNIbWo2SjBFRFdTWGNUOWZSL25WdUU1MmpqdUpIT1NK?=
 =?utf-8?B?amF2VGcxVTB1Z0d2LzN2K0NNbzJzb0RwNlNsSUVPMG5jTDIramZwamU0bHdl?=
 =?utf-8?B?ejAzN1dTUHBWckF3NFNiUjFmYm8yN0ozb1loTERlZ3F4Zm8wS2dCOXpJT1E1?=
 =?utf-8?B?dFh2L0tKU25OVDdyZjFWckV3ejN0SElLWUhBSUVTWVUra0FUcEFvSTkrcnFQ?=
 =?utf-8?B?QmFBN013c0pVOEg4TndBU0E5SCtEL0o1MnFnN05tYjZtNmU1SGEvYno2bkJC?=
 =?utf-8?B?dmhQUVVVTFE2TVBjNzNiNXZGd0p6dStxSEJEbWZOdkgwaUtuVXFPN2JyQkRq?=
 =?utf-8?B?VmRTS2E1bjZSVk5jaUVJVnlYc0lXa01telZURXhUVXQ1WUZaNHJBTG1XWGtM?=
 =?utf-8?B?UE1FeXJxWmlaVjdKdVY4MTFBdWV0dUtKTS9sYkFLOXB0ZHVhMjB5UXVMbllG?=
 =?utf-8?B?anluc2lSM3BBd1VJK2tRUjdvZ0xlQ1NHYUFNVnh3bEtieWN6cU1peFpnZk0x?=
 =?utf-8?B?YWdrVU1DM20rMEJVN3U2RyttL3JnV2xaVmtDSGErYzk4Yy9UdDIvZTZmWGx6?=
 =?utf-8?B?MzhBR0xMRnd0TkFMMEtqa1ZSTUtNczQ4czF4c2JZS3U2aDZmYVFaQ2srb0Q5?=
 =?utf-8?B?TzFVb1ROR2NQSCtId0g3QXZYeTZDQVNjcVczWGFCa1NUdWkrRUwvSHhxUzVt?=
 =?utf-8?B?anVVc3hJcThvUUc5OGZZd0hkV1grcUNxOWhMK1lxTnAyVEJnTE4vZmVkY0RD?=
 =?utf-8?B?US9UNVh5S1o2NDVVcG5rVzNLejUyYWVBRXZYaVlKSm9zNTh2R1dJUWZyMHNC?=
 =?utf-8?B?T0hFZXNpK21uS3NBVnRKdDBOR3A0VmFBSEYzd3FmUUpQOHJuT1d4WGFLMStl?=
 =?utf-8?B?OWpJMU1Pa2hvWjF0S1pwZU9PZGZuUG5peGdERW93ZFV3czVnbXpVRUh5aDdr?=
 =?utf-8?B?UkhMbmhjVjZEZkZ5RGxyZjBOb2gwaG9tdlJtWDdCT295bzJtTTRFK2FVM2tL?=
 =?utf-8?B?dW5PUUVra3ZXSkN3WStZeDFRNkYwUTF0cTUxUlAzWGxZSmRjSjhydnRvT1RI?=
 =?utf-8?B?Snk2VE1JcU5OOTdTU1BtZE9TZWdBK3JLYjhVVVVFSVZUK052N3V1NlpEY3JT?=
 =?utf-8?B?L29LVmhQRWZ0bktNajR5MVZpTjVPYmZpdXpMYVVJcW4xb0dPSnM5UHlxc0ls?=
 =?utf-8?B?L2V1Y3Z6Mnh6QUw2aG9pQzBRMEdDWW10VmEwclQ3QzRtZEZmZ3A2OEF3MlFx?=
 =?utf-8?B?WEd5eGJhK1d4UmVBMWliWW9DeWIxdG53Qnk0S3hlOS95YnpheTl6bUcwVCtq?=
 =?utf-8?B?eGdNRVRqKy9BMlBUNXRLRVZJbkVVYk00bEZZT2JpQXdlSjVMTW40YnF0Y1R4?=
 =?utf-8?B?ektoWmw3SUlIaXJsenoxbzYwbnpnbHB0ekJFRkJaaUM0MmxtcDRSM2NtUlcw?=
 =?utf-8?B?TXpFNHBnMTBpZmR6WG15TDRlSmdWYXI1ZDZIRllaVzhNMDBsWlFKYnB6cjFQ?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c63c7333-98a2-48a7-1aaf-08dd14436e94
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 09:10:00.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4Hm+OZX0j6KtucCDYQupnrpn8g91iZVz8Fa/iJjFyw7w3Fw8KBc/oOTqeHD9RO92p80WEP0U1/YZbGmocUG5Mje5S1/svI2bo3hOUL+2XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
X-OriginatorOrg: intel.com

On 11/5/24 06:47, Przemek Kitszel wrote:
> On 10/31/24 22:14, Rosen Penev wrote:
>> The latter is the preferred way to copy ethtool strings.
>>
>> Avoids manually incrementing the pointer. Cleans up the code quite well.
>>
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>   v3: change custom get_strings to u8** to make sure pointer increments
>>   get propagated.
> 
> I'm sorry for misleading you here, or perhaps not being clear enough.
> 
> Let me restate: I'm fine with double pointer, but single pointer is also
> fine, no need to change if not used.
> 
> And my biggest corncern is that you change big chunks of the code for no
> reason, please either drop those changes/those drivers, or adjust to
> have only minimal changes.
> 
> please fine this complain embedded in the code inline for ice, igb, igc,
> and ixgbe

I would be happy to accept your changes trimmed to the drivers I didn't
complained about, I find that part a valuable contribution from you

PS. No need to CC XDP/BFP list/people for such changes
[removed those]

> 
>>   v2: add iwl-next tag. use inline int in for loops.
>>   .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
>>   drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++---
>>   .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 10 ++---
>>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 +--
>>   drivers/net/ethernet/intel/ice/ice_ethtool.c  | 43 +++++++++++--------
>>   drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++-------
>>   drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
>>   drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 ++++++++--------
>>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 +++++++-------
>>   drivers/net/ethernet/intel/ixgbevf/ethtool.c  | 36 ++++++----------
>>   10 files changed, 118 insertions(+), 114 deletions(-)

