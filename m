Return-Path: <netdev+bounces-189868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97791AB4410
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17223A476A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B801B297117;
	Mon, 12 May 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zgn2mBrZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB0296FC4;
	Mon, 12 May 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075661; cv=fail; b=oMO4ZoVQmXBPDFMKzj23jeXVZ+B/DKiQ81vkkH7bl+l6HBm72y64Vt3M7fRcqMC3eoH5xKhD5JHIWoGue3vv/k/gHBRG4qeGqiUpa4zcfC3YFSnkKPVe8GH8Mw1WHIsH9YZWVLC/uMbWtdiuxUQSAabObAibVfTghfiQyfjwbbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075661; c=relaxed/simple;
	bh=lHJxJ+cGVubDrgOxASSTevNseeDtcUpxIly0/6AcIsw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tH8mCYo/x+eNWnDHwZtGP2uazvUsfPeXMg33nIUIg2EVmIFwg2qRfecPPXz2WiR3mgN62j84wD+8oxRcUTjPvLdsRO5TOpVHi/ZferlzrAZPf2hqpLgoK/sRZbxdpo+zxv1OdtZK6DzuePY3mCWFkTCFZvMqThajrjErhNGcSSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zgn2mBrZ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747075660; x=1778611660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lHJxJ+cGVubDrgOxASSTevNseeDtcUpxIly0/6AcIsw=;
  b=Zgn2mBrZmZ5Z7cOvabWTk5WQPnaIDybx6LtPb+3AylXAKbxXFpnplQqV
   Jsn0hsDkga0sM9b261wZW1g5NKMA2mCDo0YfiKnYFJPyIJ3lF78T1bWzK
   JHVCS3Mo1DC+P+VGEPQ6+cen9LtxJhP9wQOycq3GPdImgvjASDwj1g+vo
   w0Q9TMluLNKtjI4eu08oYeKNKJqATfj2ByV5d5kt7qf8jJt7wz2MkSwad
   SFWzYA+ekzUF2q4IZS1dVRGlgHN9QMwKmTeEi6sWI9hPssmozEBza2IFZ
   b987yQV7ZQU2Bg45bvJD+kXE2q+lPFOtqgcf0aBSjtYeQtRM7BPXkoqF9
   w==;
X-CSE-ConnectionGUID: Za5vckU/T8eBCWUbHNKE2w==
X-CSE-MsgGUID: EL20wOJ6T02tFeHceu6G8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48966618"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="48966618"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 11:47:39 -0700
X-CSE-ConnectionGUID: 5AnV/OR9Rg2hS9p66g1KiQ==
X-CSE-MsgGUID: vf3pyn7VQYyIkGb0dKhYJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="174597876"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 11:47:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 11:47:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 11:47:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 11:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTvaHznhm8s4EwBarGoChksZ3922ZEMFCGEOBSlY1oIe+zR92rf/KQ7RpRBFYsQY7YT2ngpVG6eWaE7CTSKnqW7710Kd1Cb8qSa267XIxu1MnwTy8/IMeZ2t+2yZX53FErlyD/JkqdLTUc6x2LEi8Diy62JEl6KjO/fkZb35g2LPmvipNpQeYa8YhHoR4UMHUXgzivQv6abHOgjRXpTmw1VpQkUCY8Fr/WjVn0kxdIeIttMmU1y/qD3x5dIxK3q1e/b+WBVe31LZ83ZwOFshLO/PgncNEFdGt1j6d1g4dJSz/5YvPsbO1RogzYURvXZA8VmqrnpouIYvJrCS/fhh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwLYDaI1e+4aq1ibqVnC3WilFgl2FYuzFwxIn12GL7g=;
 b=tWoG5aL6ZS0h8rv6tQMr+opJeSLdtCykQhVsVXtd9Z69Ni6yPdVOgexcvlBk4Y6Khwxa71/UkmWyfc7DRZkv0ujQ/wZpLYKbxRYt3ZLIR8OVYD3jET+2CrE2reCEBXhJsUaUrjrxm8qSH46UKqp3B5Uli88r3XgodXs0+I/LYv8lUqJOxtXB4Qb0uF5gctF2806tUr379r8ZPZt5i7FDq9Mewi235fKTlNby1bCQVINZLeXZ1VCOvnzVvL1SG0Y58l9vWxvS1QOPW6kRIIdxvQn4c+CIV45ppMYvvzXH+TSSSCc7f3pT1XHu0DGJbW5Y+OUMcFEAMhSttOkRJXB8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB7022.namprd11.prod.outlook.com (2603:10b6:510:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 18:47:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 18:47:23 +0000
Message-ID: <a406ecb3-a94d-47a7-bff8-becc6302a775@intel.com>
Date: Mon, 12 May 2025 11:47:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/5] eth: fbnic: Accept minimum anti-rollback
 version from firmware
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
	"Jakub Kicinski" <kuba@kernel.org>, <kernel-team@meta.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, Sanman Pradhan <sanman.p211993@gmail.com>, Su Hui
	<suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250510002851.3247880-1-lee@trager.us>
 <20250510002851.3247880-3-lee@trager.us>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250510002851.3247880-3-lee@trager.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0353.namprd04.prod.outlook.com
 (2603:10b6:303:8a::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce22cd8-ac15-48b8-ac3f-08dd91856ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekg5MFYyc2treDNjdFgvbkRVVG8xWEFrc0ZtK2huTnFpT3RWTC9BbVQ0b0w5?=
 =?utf-8?B?S3JBcndqQWNpalJGb0VBK0E1OVA0S1VEYnhUT2YrMHlabm5QZkpVdmdXSXlC?=
 =?utf-8?B?TFNETmRVc3ozWTAyS2lLWG56SXIrYWlqRmh6bld1eG84WXQ5cE1JYTdHTjJm?=
 =?utf-8?B?RXZUbUFDZUFzR1NMWSthY05YZnk5ZUx1MWJzMFpFWXYxN1dRRFVERzBmQzhv?=
 =?utf-8?B?QkNXREpXNzRpRCtpd2l6ampkOFNnMUFjR29IQStZZnpFWC9uQVN5V2gyT0hl?=
 =?utf-8?B?V1krcjBrWlhGSXNwWlppSzBFNWVvOVJwanZwQjlOUXNkeDk3aGM4M3JYcHNO?=
 =?utf-8?B?ODN6eUQrVVdNNzl3R3JIUVFpOWloc1hkRHBaL2dsMy9hcGhaMnVhdWNjQ3A5?=
 =?utf-8?B?THRpb1hXaTh6aFBUSjlnVEsxM0VLazRPS00wNGJ4YTRuUmszcmxRemZPMEk4?=
 =?utf-8?B?d3M5Nld1TEtyL3ZwV1BrbitXSFFHUWRXVDRRTCsvNEFDUWV6QUZ0VHp1dHFT?=
 =?utf-8?B?d2grMUVlMGdxdVVQZUdkOUJ4SUtuS3pzQWhEazNBOTRDVEtINnE1T0xSRXZi?=
 =?utf-8?B?cWJveFk1YXB6WXlleDRLZHdXaWZqSFpXNm84MEt1ZVJFeXRhLzFoRVhsNzVm?=
 =?utf-8?B?SUxJdU10aVdENFVGSEtFemhZQVR1dXUxTUgraWNZNlVBbDcwU2x5cWJLaVdj?=
 =?utf-8?B?bjd6RUVjL1g3MTYyYzFCa0FPcTFyL0p4VlI4akNZZm9IR0xNOCtTWHhYbGVy?=
 =?utf-8?B?Um4wT1I1RlhDMkk5S2U3Z0dJTWlQS04zbElZcnB4cERDQ1dlaVNudzJ6NG1u?=
 =?utf-8?B?WmpSdVA0Q1MxdnZJU3FUTlNqMTdrR25hUlBCWWc2Q3Jvb2QrTzMwQ25SUmhR?=
 =?utf-8?B?U2dLeWFXdzA1b0ZsNHN3azEwUmZUMi8xWThuNUlUS2hMWnR3L1N6ZTk0azZs?=
 =?utf-8?B?emMyMEdEMFkzTlcxMEdFQnVsVU0xTTVZY1o1dlRFUGdJU21xRTZSbTEwV1dq?=
 =?utf-8?B?UFlES2g0MVUzYWhOamdzaFVIT1dFK1FnOEtoYUo0QmtEazJMdi94Nm1DOGxX?=
 =?utf-8?B?RXRxS2kyeVBsUUErVzVraGlVbFZpTVRsdG9IZnJzSUViK0VnVDdHZjJnaXY1?=
 =?utf-8?B?ZkNxL1A1dVdRSXRjWFNoT2ZXWnY1T1FPeVNENC9oTWt6d1VzTEtrd1haOGRh?=
 =?utf-8?B?dlFIK2xjTTh5NzVPeEx0aHdsRk95TUxrQld1T1dZTUpONmV1dzJWcnVBVVJI?=
 =?utf-8?B?d2o5VFd0Y3FCRUluVFZYdk84WVcyMzAvMEI0S3JuaWFJbGpKQ1E3bGhLdFpu?=
 =?utf-8?B?ZVdzMnVzOExPR0E0TldYK3ZZNWx5Y0RMTk9SWndKRUI2dWMxaCtoWmdyWVpQ?=
 =?utf-8?B?UlFaY2NFYnlocERuL3pSRlFPbmpRY3J0U0ZtZnZqc2NvZ2hqRUpJTHNNR2xn?=
 =?utf-8?B?OGlKcldlV2xpUFA3Zk80ZG5HZ2R3K0xtbm9QQjU4Y1Y0eDJYWG0wK28xQXgw?=
 =?utf-8?B?S08xbXY4V3c1cnk0UEUyNGF2NDh2TDQ3WXJ2c28zNlhKdVIrcE9TeG1MZHYx?=
 =?utf-8?B?K3dtU3p4ay83cDdNQ1J0YnJ4c2RxRU05OEVvVDVJZG1pdGw3L3JlbzR4VnRx?=
 =?utf-8?B?MGM0WG1yakFKZmhlVm9rZ0ovQmliUkdnK0VqbzJhU3pGanpGY3N0eXFmbmkv?=
 =?utf-8?B?bXdMbWFSZ2xpV2graDhwWG83MExMb3REbzdMUUlzMXpzSUVsc0FNM0I0dndk?=
 =?utf-8?B?VSt2Wk0yRmdycmpQcy9YQkFpdEtDcVVVdTNoeU1qTlpGWFg1Y0UwODFFZmx5?=
 =?utf-8?B?TVp6K1VUN0N1cEhCQ2pRUkVXVytUaHZyU2lRQ1lDMEpzZjNic0FIUlJ2MFc4?=
 =?utf-8?B?aGNiR204VERNckZSdnpJUnQwbUllODloMGlpeFB0UjZVaytRQkh0aU0vOUd2?=
 =?utf-8?B?ZTBVNURVL211dmxneXpNZEYwbFU2dE1GZzRGMHZNbkZZYTNlaDRlRmxiNkhV?=
 =?utf-8?B?c2hJRWdCTWd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC95djBFcThsWjJVUG5sZWJ5ai9SMFY0NW1PbnRsVzJiUGhMUVhBWkpKUml5?=
 =?utf-8?B?a2tNRy9DeFZwTXBWM2hVWUdSTDkrekMrMzZUSUJQYXhnV0kyeERZNzk1N1Mx?=
 =?utf-8?B?V2g3K3Y3NUhDZFRWVHN2NE93eWNKVjlhRUlMaUNBZXNqVEZVRExIMEpnZFRu?=
 =?utf-8?B?SzRQK3FnbmFUaklwajBvMlhvaVJRZkZuOVlNd2JDaUpuZmhwUW9EamZmOEEy?=
 =?utf-8?B?dVNlQlNHNGpWTEttVklsRVJtaTZTWTNQU0dHdktmNmRWQkVsUEdIZHRDaTI0?=
 =?utf-8?B?MXlweThNMFo1QmVOWk92ZHNnVVUvY1RMT21Ub3ZhcTE2MzR1bkNGVHVlSm9h?=
 =?utf-8?B?QlMzR3N4S0phcEhGbzMyRTdYbnowUElnOStRVUtsb2w4MFBLVTFac2lCYit0?=
 =?utf-8?B?WWNXUnRFTG1tUFlsMURXdFFYVGV2Nlk0NEZNSk4rYmlwT2hnRzA2OFl2YkFy?=
 =?utf-8?B?QlMvcjZJdEg0ell0MTZmb0FKa05XR0laeDRuZWtjTExsVDdoQnZpandHQXdR?=
 =?utf-8?B?VEtmdGMwMklnOGNhS0Y0RHNkNHA2MkY3VDNzWlRDZk0rc21scEg3NXVJOFB1?=
 =?utf-8?B?TGwxeGRTaVhxL2xzdWU0QXZOUGw1ZVVlbWQ0eHZyWjdzY2JMNWxDMDRhRTkz?=
 =?utf-8?B?d3NRYmh2RG5Va2VYdlZIcXMvUDNyWjd2ZkhQbDNGaHFCc3NrdlJKK2FCSmh4?=
 =?utf-8?B?RElFeGZLdUoxYkdRNkhOcGwwOUFKaVJFSGNFcnlmeW9qcGIyMXZVYVJkL0t1?=
 =?utf-8?B?cVpkU1IwZ0IzNkFBeEZWbTBkb2VFUmRKS3E1QlJ6ZmFic2Y2ZXdRY0lRUGdv?=
 =?utf-8?B?MUJnOUcydzNDQ3lMZEJMaXZnd2tCT1BMRDlYVG0ydXU4TDFhZGVkSkRWQ2o4?=
 =?utf-8?B?dkMvNTdrR2xEQjRxSW9vMEMwSUFZR3JqLzFGSHNzYVdNdG1FeEswbmdYYWpH?=
 =?utf-8?B?Y0JKMkFXcEJhZVRFS0NBWXZBVHZMd0JpenAwa29SeEZ4RGNwdEVhUnNjV3cr?=
 =?utf-8?B?Yjc4aStWaUEvUFhGbEpvbG5TT1NsaHdyTHpURjh4blBrVENTNjUxdGdjcEFq?=
 =?utf-8?B?dTZ3Z3FJL2o2elJlaUt3QnZSMXpoSjduZGsra3hmWmgrdXAwWFNPVXNMYXFO?=
 =?utf-8?B?R3lRV1d3cTI3bFE1blZjdGhBOUd5bElWNDFEV3VlT0wvb3ZQK1hVTjFFN2xY?=
 =?utf-8?B?RWhIS1RJTmtleWs2Q3Y0WTUrbXFBQmk1RmhnUnJLWDYxNngrTWd1VWVkMEQx?=
 =?utf-8?B?b1ZWcFZmdlhINWVaU2o3S28rSjlhMEZ4MkhsV0VEbmllS3pVY3R5Y3h1SmpN?=
 =?utf-8?B?Y2JIbDI5ZnUxU2FCcDBMVEFLam52ektPd0hnRDhJWFc4WU85WnBGUUgyM2Rx?=
 =?utf-8?B?NnJLbWl1czh6R2RLRXVkOTFRM2FlWldTZFJ0YlBJVCtKZE04NmJEc1JTSEp5?=
 =?utf-8?B?Sk5SZ0lBd3RORHBMMFl0VjY1cUpjMVB6TGZHTFN6Y1V3dzVKOGlheWs4Qnkx?=
 =?utf-8?B?RUpoVklKSGRBNzZqQW1nZ0J2c09qNE45NEdNNytIQ2xKMnNsUnpheTYyM3RQ?=
 =?utf-8?B?WVkvU3QwTG5EY2Z1TnZHdSt2VXJkKzhabWJhb211UFlCS2ZqRDJ1SWdHaFdP?=
 =?utf-8?B?WlFBMG11K1pQM1lydm1HUjkzdXpUSm81VHJmanlWRGNXSG1DNm9vVVZ2Mmlz?=
 =?utf-8?B?U2NIVGtSSC8yYlZGWlplYWgvazc1Y2VUNmpqLytQTGhvaXNYL3E3VTRyRnhN?=
 =?utf-8?B?czZaY0gyUDJSMFlLUGxQK0t5RFNNY1pyOWNIcEE5OFdodkF2emsrTmgvR1lI?=
 =?utf-8?B?YXVtN1V1TlY2N1FLVXFWMlNhcnBJZzZoNGZBS0xxNmhCQ2R3dlV2RElWdWdM?=
 =?utf-8?B?OUpOUS9DTXJFVDZBbUs1eFVzMzdUZXhIbi9NcmU5T25BU3NidkRYMDVKQ3hB?=
 =?utf-8?B?ZTZkVHg4WkdWNXFzc2oxdER0T3o5WlpWYmtvSVJCSmFmdzROdWo3b2tBLzlM?=
 =?utf-8?B?RlRsQTJUZ2pMV2l4dGdmMWhvSWs1ZE1XMVhZWlRUMWdoMVhBeGZTaExvRkpZ?=
 =?utf-8?B?QXg4aHU3UmpVODRFOGo0ZEtDaUVUVjA1Tit3aE1JK0NSbHpmVXBySUd0eElQ?=
 =?utf-8?B?NFg0YTZCaVNXRkIzVUtRN0ZkNGNPOEQ4OWNUdFU5ZVVYQmt5OFh4R3FxNVpQ?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce22cd8-ac15-48b8-ac3f-08dd91856ea6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:47:23.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGCyt6nJ64Jfr6i1TZxAD7BxxC9kaoli8PXJP0nwiDtWfbB0NLxKRVeVbUXOHrXahdBckC74Iah4REWBWtAN8+PCmaEWTKPreV5tvlXoUS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
X-OriginatorOrg: intel.com



On 5/9/2025 5:21 PM, Lee Trager wrote:
> fbnic supports applying firmware which may not be rolled back. This is
> implemented in firmware however it is useful for the driver to know the
> minimum supported firmware version. This will enable the driver validate
> new firmware before it is sent to the NIC. If it is too old the driver can
> provide a clear message that the version is too old.
> 
This reminds me of the original efforts i had with minimum firmware
versions for the ice E810 hardware.

I guess for fbnic, you entirely handle this within firmware so there's
no reason to provide an interface to control this, and you have a lot
more control over verifying that the anti-rollback behavior is correct.

The definition for the minimum version is baked into the firmware image?
So once a version with this anti-rollback is applied it then prevents
you from rolling back to lower version, and can do a verification to
enforce this. Unlike the similar "opt-in" behavior in ice which requires
a user to first apply a firmware and then set the parameter, opening up
a bunch of attestation issues due to not being a single atomic operation.

