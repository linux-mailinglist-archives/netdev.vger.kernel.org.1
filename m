Return-Path: <netdev+bounces-193398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607C5AC3C88
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EBD17569B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA11E261F;
	Mon, 26 May 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/RK9+gR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6619DF8B
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251304; cv=fail; b=SqZoLO8o16UH6zcznpFL3c/RDfBu/nwCMiPV3b3RwWov6PajTmA0n+iuLYLOvFlr1mLsxiaTVpCm5kinJqolR3Evg3CON/I/E0a2sXC64aFDA3tmEdBZt5Y0I93tg1gOLLAwe17SKwbvapUTF6SDCmI6C0zLKeeEICWcpZtyZ+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251304; c=relaxed/simple;
	bh=n+bYBWOEf0NbZhbTCK2d64QuT6M9DLGpWJMHNFXl2Ro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LPaZ09DjonS8boeNA6YCSGYn2n+1ipB10Pb4WTr9010EEMAYPG4Pm4r/keCe5hsbO/XAI+tTWQfDReY5qbT0cfGkFgMP6VsjpuyeGuF+2JZy+g0PIUyBBXPVoVhmvr/6srztU/aP8x7tywPZYI06RfNA4nTQL558koTLF0oqqxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/RK9+gR; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748251303; x=1779787303;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n+bYBWOEf0NbZhbTCK2d64QuT6M9DLGpWJMHNFXl2Ro=;
  b=K/RK9+gR+5AbzOkynY7eglNdfTh8IOaCsAu5rOv4nMS13cUy1yet55jd
   XdgPuaURXx94/DAczTNfDKAmQIOMOJO2ivcgNNWGw6xiw8RWYzTv4vQxs
   I5jzpMSAQoCDregiJTQswDrLSAk7s5zBTGux+FXgqrZXY9D4XjE0LuCi6
   Qq+ZFQc1DJiCqttHAnaNqpAEu66euezq2AwUOzUAHfSqYjADqRKfwcuqc
   vgBmaPT3hdjhJ3C/AHcAh5AsjN7O7ne9Yf6Zh0BLPLWTxj1Jmn98GaAas
   agMTz3l0uXWPwP/K4QlkAZxdmKThtQ57tVx40bIiUGAah085j+qhFqxSN
   Q==;
X-CSE-ConnectionGUID: 2kBiTHJ2TbqVJ7NZSuis4A==
X-CSE-MsgGUID: l0Aq/mS9St+d28mYRyxxNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="50375697"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="50375697"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 02:21:42 -0700
X-CSE-ConnectionGUID: UVcThzApRaCWkgf9LJmE/g==
X-CSE-MsgGUID: zA5rvSx9TNiBuOdE3MEdQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="147056759"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 02:21:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 02:21:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 02:21:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.40)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 02:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6+qZUKbtssGMgT3/PgnTb6aabgmxddXlFkNjRVgqQe+O9wNzG4qUA8YZ+idAOHjfF5vLqY2CsKhGwC94l+oDt9JrC8qYF5GhIt5D6qlh8mhLVYonVYL/feesE7hOwN72RyJcpwui7a+4nhuHzlsGf2wAV3JVMGblUaC173my/zSnFqknMcJIAtTq1+5f3KkzWYPg1hjp6E5PQHP90VRy2eGRzDrk/g7dzwh4MaDnCTOBaj1aj2m2tZut9/wGjPs0dlV47jPPMTwjUwxwq6mstmywcF2OJmQWRrg4qWVrbNhk4oAKqHouS9VsBKMEGqv27LgERnfHPvAjIJTNb0RwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeHncI9SAMWezTkFy/byYTZVyJBfaLrGsFkCO95a96Q=;
 b=GtjSLT5W8sfM7kjKE3iYc+Vj3k586ArWD4AhquTRldh+UPxFb+ZpehYOOP9YKopglz7QiwE1aB8wb9jVxnk1HGAVKRPeOBSEvaRp5dN0gAd5a1PiCo4Usb2JJ+ys7jgJXdDz1mDZ7q7E9DaXbFbPZWmBaZ6lca5hP0qHNzt517SSojfJlURFyPCSKkRyfZuelygq2k8Vh5uBafc/+tNU7kHk85rWBXS4B7cqc7ci0VX9iw+6lwRMmr6+KbQO1JqVNNWGcS6jnqKo3TYpIsELTEmlVSCXUejRwG2JBk618G8e0VRKdwN00cScPeP4N26BxNVLmlFN783Sx4VrYnHvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 26 May
 2025 09:21:39 +0000
Received: from MW4PR11MB5934.namprd11.prod.outlook.com
 ([fe80::96ae:ce0:2a38:7408]) by MW4PR11MB5934.namprd11.prod.outlook.com
 ([fe80::96ae:ce0:2a38:7408%6]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 09:21:39 +0000
Message-ID: <d53c8ad5-069a-4e5c-8dc8-3b2d8618b510@intel.com>
Date: Mon, 26 May 2025 12:21:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/5] igc: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
To: Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-3-vladimir.oltean@nxp.com>
 <20250516122611.GA3339421@horms.kernel.org>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <20250516122611.GA3339421@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To MW4PR11MB5934.namprd11.prod.outlook.com
 (2603:10b6:303:189::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5934:EE_|SN7PR11MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2cb316-42cc-46c9-f1ed-08dd9c36b7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXI5UHBBN1htaTRuanpQeTdZREhDcEhRWXZoVVdLeHlUNGFCZEkrbk4xWjJj?=
 =?utf-8?B?SzRXZ3VjOWFRd2FjbEpoZzJjU2didEFiOFZ5bTV1WFE3dmNBRkQvd0JFdVlz?=
 =?utf-8?B?UndEc3dyZHRDNW9OYWtCc0s1dEY4MjNxenRzdXJ4cE1lWnE1QXV1T2c3eDlx?=
 =?utf-8?B?dS9TMGRUTFB5MTdqbWJyb3RQak5yZW1oY2F2YUprZWFsbzhZVFZaL05zQ1k4?=
 =?utf-8?B?YmRGODhnUlMyeHdUQmhxNXNpbWt3dkVBNTgyTVNEVGp1aHBXcFZBQVd1WHVL?=
 =?utf-8?B?ZGx5Ni9jZ1VOSjhxY3RFV2NEcUx5N3ZuVDVKQTJsRXVKa2xmVkEzVi95cUdR?=
 =?utf-8?B?QTZObkpjSVZnYStXNm0rbHdwMmNTbk5WUk1JWlljMXN5ZUlGbHlFODdMS1Z2?=
 =?utf-8?B?QlVqVXIxTVp0RjcweHJnU2lVSDQ0bGwyVlJjc3AzQ093aHM3ZG5ZaEFyTUN0?=
 =?utf-8?B?U1N5SzBsZGFjRHEzUld1b0FtZVhpWGRiYnVRdTBiU3lGdStUc1lmbFNtU0lB?=
 =?utf-8?B?OW5LQzVrNWhaa3FPWGZPdzVZdjVESDU4cDR4aHNqTjJoeTRlVmZiZmxSbFFv?=
 =?utf-8?B?RTd0d1ZDTzlLTzRxN1gyVnhRUllCZjhtalJtNDVQUjk1VlpYSDlLY1UvZHNH?=
 =?utf-8?B?NU5qdDNoRVRxdVQxSjk4SnlVTlAzTHhiWVhPWXZuTllqOTlTUVphWHo4NHF0?=
 =?utf-8?B?YjJUYmI2VG9kK0VpUURyOTYra3VpOVVNMmFjRnh0SzNQWCsrZ0Ftc0g2L1A1?=
 =?utf-8?B?bEsvOFMrYTFjYUx1YWMzQXk3Q1lFTWJuWU5UVHJZL3draUpUZVlITGhQQStx?=
 =?utf-8?B?VFN6NkdhclJRa3V0U01yMTdlalk3THhEeHFMa2l0WU9ueHFobUxWRW1Rei9M?=
 =?utf-8?B?cDRZbHRYekFPWGhOcDk4TzZyQ2Q4a2s2K0lDWkFMRU9FcHJqS0txdzY1SzRz?=
 =?utf-8?B?aGlhQnBrNFBrS3huWTBuT1ZZM011NzF6VjFkTVFmZmd2azZwWTFQMWs0V2FL?=
 =?utf-8?B?eWsyNW1GUDd1NkVYajBkbEE1YmhNdEpEd0J5WjJYa2ZOWGowazFtL2k1cDVr?=
 =?utf-8?B?VWJTdXFDVHdwSXlRTDFtMkRWREwzT2o3UGlKd3k0SlpWYUp3ckVuOXZQbWFU?=
 =?utf-8?B?cU1Oc1FWMWsrUE1lRDNVeW5kemdaSktqNlo0dE9mMTU5YVhhbVFkUTAvQU8y?=
 =?utf-8?B?emNxeTI5YlV6U25JcUZxQ3VaUVA3bFF5WkVNTUt2Uk13THVBcjRnbmRSZ3Jo?=
 =?utf-8?B?NEx2UlE3Y1NBNUZITXpDUnVXemUveWJ0US8wN2ozcWNseEVIbVE2ZjVBdDRk?=
 =?utf-8?B?cU1yaCtpRHUrcWg2NE1FRXhsTWNqK1VGaFdOUEVpbStraXJQV2tiS2xpNDFY?=
 =?utf-8?B?OXpnYm9oRjZSeWtOSzZLNEpyTi9Ga09kN2lia2dvVmN6cGpZRERCaW9pZmR6?=
 =?utf-8?B?MVJKOXMyOGgrRkxmd21RdVIrdDdJWmF1cVdaYjBML0RSK2ZJaUREZG0xczZw?=
 =?utf-8?B?eGpDblhWbWFIN3FENHBxOTFkSWpmQmV5NHU1RUh5MEh2djl3dnp3bU9MTXp2?=
 =?utf-8?B?ZGtqdEZvZVZIVlkzTXM1TU9zc1o4TGVLZHFCY3NrTmI3d25xcDZXbjc5L1Fm?=
 =?utf-8?B?Vi9BTkFvMDRSQi83eHJ6dHhVSG1vcHoxRUFOcW14cEhLeGFNTFZWc0pBY201?=
 =?utf-8?B?Q256N3FJb2QzQnluSVdubGVPVU0zQjVXWEQzaVdBdzFSQ2RQaDkzZ3h3eWNL?=
 =?utf-8?B?MXVodUZaOXFZRTVBMTFwNVd4SlZrM2tHMTdwbnB3VWgwSTlhcGNrZFNDOVRx?=
 =?utf-8?B?cXloODdzK3UzSnlDMmg2VUtxU1ZKMSsxMSs5VGdTYkpkeXZOSkZsTHFMWE5Q?=
 =?utf-8?B?aEYwTW1SalRQYXFYaHdWbmtlajg4WU9sRXNwU2Q2ZGowcWRVb01ZTWRuQmZp?=
 =?utf-8?Q?ckANNIJjDYU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFVEQWhpNDl1RHBPdVJHbGNlMW9BNUR3cmh4RGR2R3hwaWk2d1l5RWNidExo?=
 =?utf-8?B?OUlFUDcxS1lISVY2TTlyTnNVaVNKSHZCVVZ6ckt0NHJjZzlVQlpjM0ZLSm9x?=
 =?utf-8?B?SmVTeExadEJickZPREdOeEYxNisrdTMyZFBmYk9WRXJ3Nk1QK1VZT1pIQUhQ?=
 =?utf-8?B?OWNrbGh0bFlGelNPRkxOMjhxK2R3QVlBWFQrR3IzalRBM3dhL2Fsay9aT1ZG?=
 =?utf-8?B?ckVKdm53ZnhqYXBPa0JYbE1xUzBNUmRLcUVxdU13ck1nVXJRVmtXUW54M21Z?=
 =?utf-8?B?UGoyUFU1QVhDUHVoa0FoZWFuVEtTdm85VGZvTmt5OEl0dzZwaXF3Rml2WmRT?=
 =?utf-8?B?eS9NMmZDKzBJdlBoU1RQZU9NNytZUCtWejBzcE1YT2h6YUx3Nkp2aVlhd2Q2?=
 =?utf-8?B?TERDTnBJcEZhTDBXcE1xUzRERS9SR0cxNDVsQ0FMRXlVSzV2R2ROVjJvWFBl?=
 =?utf-8?B?R0wyY2hwT0dUZkQ3Q1VBSk9Qay9yeWxMMVJhZzVLR3NlYUpLaWNFTS8zOGta?=
 =?utf-8?B?OHVHd2JTSVdpRWJUZW9nZjE5ejhrUXQrV0V4NW96UDNlR2p1djdaSVEwRkFz?=
 =?utf-8?B?NmFYSUEwSUtpRlRmWVZIc3d2eENQT1Y0K3U5emREaXlnOU0xUmRxWXFYUk95?=
 =?utf-8?B?aEFwZzlibHF6SHVIZDYvd2NyY2l3V3BwMlBuUUhYOTR5K2ZwRXY2M0RKem0r?=
 =?utf-8?B?elViQzNUYkhyYlBTTDRzaTBkQ2gyY2dqUmtKbnBhQUdDTkRqS3d3R1FHNUp6?=
 =?utf-8?B?NEdMSDNFOWlzaWxlZkJ4RHZzV0NaZ1lDc2ZDWmdqVzg4YjhFQnBYZTJPaENV?=
 =?utf-8?B?THlZY2Q2V0tHOUtTQnkzdnhHT3hNV1hVWW9sUW8vVUdhdFRyRkJHT1pIKzFj?=
 =?utf-8?B?UlhtRVVmU0xrMjh6eFNGL3o4WDhsMW83a3N0ZVdiVjBvWUxxRzlSMkdoekFH?=
 =?utf-8?B?aElOUTlCbWpxVUkxQmRJdGlia055ZlAvbmVRSE9BbGM5U3g1ZE9ZckpiLzRi?=
 =?utf-8?B?b2l1czNXenNyVzNLT1dpQ1A1RlVxNUQyK2l6ZU56eWJ1bHNXTkxVTi9xOTQw?=
 =?utf-8?B?Q1l4M0Y0V3Z6TE9TMVdLMTJxeWtueXFrMyt5OFlqTC9nOFRucjg3N2NjWVY4?=
 =?utf-8?B?dE9vdkx4cExYUEpxK2JGUFlRWnFVSXJldWtxSndNSk0xUkRwZG1lS0JUa1NK?=
 =?utf-8?B?c1U1ZUJ1S0NQNUozUkRraC9EZ1EwSXV3NTdsNEV3dzdJV3lCMkVTTjA4cWNH?=
 =?utf-8?B?dGcvdnlXSmdxZjZMUlBTam1QVXFjNDJOQlZ1elRncmZOalNLOHVncHpERnVZ?=
 =?utf-8?B?Qng4VkhUVEYzUUZkUE5leXl4MDlCZEVQWWlzMFNCL3Brdi8xY0ZTSHRqL3h2?=
 =?utf-8?B?anUxVXFCQnFVRlIxWXo1aTBGUWhyMHpJV29QVFdwbWorWElzeGRMQWpXRkVW?=
 =?utf-8?B?UVE4UDJvNFpyUk5WbjY5RURWVkhkbERCYm9WRTMwMkNYTkNlS2xGRmlkWGgr?=
 =?utf-8?B?RzVBaW93MnB5YStWWXdoOUZkTmRnZ25ySmo4ZHIyYjc3RkZMa2s5VjA1V2dP?=
 =?utf-8?B?Wk5oZ2JUa252MGYrQ3FvWTI4bHkvaEhRZmpxSmxPbks3dW9XeUtqbEE2ZUcz?=
 =?utf-8?B?SVMxNnpYMWRZaTZaZ05LLzJYTEM4bFAwMnorZ3NQVmJUbUpMMDVzTmdYdith?=
 =?utf-8?B?eXFmcEx0UlovMUtLOGNpdzRlVkJ5dGlBUVVxSHp5TEZwcVhRZzJyN2JTUlhJ?=
 =?utf-8?B?RFNOeU11WmJzZ1lqa3Q0QWowYzJiR2hRcFZPWTFBcDZ3Tk9pdVlBRS9OYjZs?=
 =?utf-8?B?NGIwb1Z3aEJuMUhFcUl6bVpzdVVXM281aGN5ekhhOVArZ3NKM2dqZmJuOTVx?=
 =?utf-8?B?ZkN0U0V1cTB2UUlpSkZ4WXZUVFBjTFRZWlJDak90eFNFNXZwSEF5OWJBSFZ5?=
 =?utf-8?B?eVpxOW1wL0xlSzNHZzB0QjRJNFpjcDVlbmlMRGhiTFVZWGthZTVNcXp2c1Yy?=
 =?utf-8?B?QVh2cTgyaGFDbi9qcDc5eXVHZHRGcDJpMEJSdDFxK21xWEUxZFpKbjgwTGdl?=
 =?utf-8?B?UDRKSUdNOXlNeG9pVlB3dmRDLzBDakNva1M3dlladHRNVTVrL1FreHMrenUx?=
 =?utf-8?B?QzgwWllGd3FibnZ6YTlpQkZlMnBmbHMxUGk4VE1rSXN6YWZPTmRSS2NqTlhw?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2cb316-42cc-46c9-f1ed-08dd9c36b7ff
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 09:21:38.8876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVu5NPJd08LgyMIOOn3ks/7wbC1OQlf6t+1ZPaA19yCBUXU6IItH8hnqiZyAtG7ahfbkOqGc2Ha7zWlGjgHbGswnleSytDHEkYswqp3JCKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
X-OriginatorOrg: intel.com



On 5/16/2025 3:26 PM, Simon Horman wrote:
> On Tue, May 13, 2025 at 01:11:29PM +0300, Vladimir Oltean wrote:
>> New timestamping API was introduced in commit 66f7223039c0 ("net: add
>> NDOs for configuring hardware timestamping") from kernel v6.6.
>>
>> It is time to convert the Intel igc driver to the new API, so that
>> timestamping configuration can be removed from the ndo_eth_ioctl() path
>> completely.
>>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>

