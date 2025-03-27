Return-Path: <netdev+bounces-177934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2F7A732B4
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84E4189CA9D
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D62144D9;
	Thu, 27 Mar 2025 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTnF9dPm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3C79E1;
	Thu, 27 Mar 2025 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080085; cv=fail; b=EjA8FTYd5leWQ+Hf79NDfCD4/BOlVdhbKJub6CCzQ4bbuehT+gYqGjFu0BMvIYSRAAi8N2VMM+aoy0yr1fvp4GxpJq8lPkCB2A0JqFynlV5YtcbQ1GD2D3JZISyi8DICuChrFWxRr9S3iol0ar9glY5TyW/W1ig8+VI5kNaNySQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080085; c=relaxed/simple;
	bh=ew8w+pffUOPRQaSXtj+Gw2T7FK+T6+6/qMnckd4VxDM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jt5IekQSW4y/4ZHJ21N6N9zak/C5HEO+zWNclC9PmP7FiSz39qwgoB8ftReZMMpVpkjsD0fZBgI2tnu5ar4pme3Fcl4hR72aJ6VELmUpWkrYnZH0LwXyXhJqZaTZcdvn1aOaIitUIB3mpQPp0k98rJjShMPWoW7cPyi8Ynv9nzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTnF9dPm; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743080083; x=1774616083;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ew8w+pffUOPRQaSXtj+Gw2T7FK+T6+6/qMnckd4VxDM=;
  b=XTnF9dPmZa4jmKsx8wjhirPMXMua9d/jxuVXVx43/4hkXDSB/JCdVIv8
   +ISKvnJ5njTr3bfxa4htD4VSsB69Cc8LSY7MRASHI9zhUbxOdpiNveE7O
   M4zG422mIXWenKVOm+cXr31O04JCkZZdguu+J5u9CRQXeGL4m/qu2VOYx
   0dGK697WdoW998K9u3NJW1f4kS92ZGsBcOxOwxi16gLtXR7DQZb10JBYR
   S+ubPiBQSmV8okp9K8xawfDX+ouGwHNfpi9xjnuaS7X8gDCVswECEnoHC
   C2f4mEpwva3ItlfdNpO1ButNS9vQqqyo8kpr2vK42HdOloyNwy95Y5/c0
   A==;
X-CSE-ConnectionGUID: XWQ6s6jrR7m4xY1/xsZ1Pg==
X-CSE-MsgGUID: JXVHARvWRLOY5pkYVNVTDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44514210"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44514210"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:54:43 -0700
X-CSE-ConnectionGUID: Gjd2QuRHTOqhOuBtm6C4+A==
X-CSE-MsgGUID: ksdyFQeNSraeJU5eRYIi0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="124893934"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:54:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 05:54:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 05:54:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 05:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeFQ4BLHXFqLL60jZrrDvVoExiFZY00gEt76JHM39gGO3v1uM3XdnaMQZqa/+WfeojxU+uiwgR6LyEPM3dUeebddf1sg+9t1DubYSVKjul3NdHM2nqB2VU+n8kLDpeWfOy9msLVYgz3KYZzz12OECdLU2uNZW5Ewq5HryZxAXHLdb1PkYS3Sxox1rlE+vJbb21zHbvDbz54btgOgDIf/PmjmXUkOOud/8NXu9BuCf0VrtG+HILdRkWVNXAmZX35AbhvMuxd4WfJtiPVePQCaTpe/sjup50GWM89Sv5x6D8a+jUbWJZ3kwbUKwe0uWDFT5N/NXHmNTC7FT+fvZrLIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NoYfoFHeWN00CQDeCiRppGzw8BQebk/H1O1bPOts1k=;
 b=R0jt7Q+MDO4c6CRvijOWXVa99UYJ7+GQlwwjsz9uoo9MR3Q2m3N9wFrlBRiWmgD3e/hFi7KNNbStLDhRrSrkMLN+3QKZz4FFvLXYU65PumPd/+yHcWo1jg0pcNE4VDR/APirYYlXErqfkGyve8N17OnX8FCYYC2JSzI8EqcH9z5OwIROF/dR5qgA3gm1gm25+61IxKd+/PgDOYOvXpPpJSZIPdyKh1/nz8RlULs3VJIMkPAtj3RFLOMDkl+eKz2YhlBiJaGkrVBZHwU7pylc5eRFiCexRX4xV5f5Hm+UEKB600Qh+bMoYDS4VwXLzCsCZNog1gzHDu9DyQOn1xT6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.45; Thu, 27 Mar
 2025 12:53:52 +0000
Received: from CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14]) by CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 12:53:52 +0000
Message-ID: <2710245b-5c2d-4c1f-93ef-937788c3c21b@intel.com>
Date: Thu, 27 Mar 2025 14:53:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igc: enable HW vlan tag
 insertion/stripping by default
To: Rui Salvaterra <rsalvaterra@gmail.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>
CC: <edumazet@google.com>, <kuba@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250313093615.8037-1-rsalvaterra@gmail.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250313093615.8037-1-rsalvaterra@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6307:EE_|BN9PR11MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fabeb77-153f-4d81-2401-08dd6d2e6d03
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmNKRTJlU2JZVnNMZWRTTXUwdTBJcXA3ckoyamc0SnBHOGNwSkFWNzhad3F6?=
 =?utf-8?B?ZUFuR0hOM2JpVWl6VDZXdUdHUmdGcEk0MHE4c3lnMWxsTUJLem1qU3h2aHJJ?=
 =?utf-8?B?N1Y1azZGVmNsKzZMVVptOUk4dU9hcldFaVBUVGgxRjVQV1VuV0p1dXNBQXU2?=
 =?utf-8?B?K0kyekp2MjJwckxkUDZBblNsRVp2dnJwdmJKRUhmT0M1WTRTUnI3QS9heWFO?=
 =?utf-8?B?MFg1Y2ZHZ2Vqd3IzdFpPbTlFejllaDI2SURoMW8vY2JJUlJVOTljd0ZrZlVP?=
 =?utf-8?B?ZkswbitPVy9vQTVoM2plUlBWVWwyR0N6WGxINnMxYWJoOVI4TXNoeEpQMXRQ?=
 =?utf-8?B?NU4zbmNUKzRaQXVKaGJSN0FtQkY3Um1lU2UxMGZTUnBUdW9OZkZMSTlUeHVM?=
 =?utf-8?B?MC91ckVMV3RPZGVVRDgxYVZuRTBOTU1IZUFRc3J0ZklSZ2xqaUN0dTNEbUk5?=
 =?utf-8?B?TWZYYkdSTDEwMWk5ang1QVdsZllpbVRiYW5WL1R0dWNvdFkrc2FWYTZiUHdo?=
 =?utf-8?B?dUdJbDFpK0VYM0VUdTM5K2ViNkJDZVN4cEV1Rm1aZXNaRG8za2RDMGdSVkRW?=
 =?utf-8?B?S3M1d093RVJxR3lSb2Fkai82V3NTeXp5M1JhYk1nQlllMlFKSGNRRDZVWWZj?=
 =?utf-8?B?OUhqYkhVNmxPcG0wQ3JxVUJvakcwSnVqWUQxRjljSGYyYy9icGpyVjQ2Q1Fa?=
 =?utf-8?B?Mkw3YlUyaW52ZlRlU01mdmUrdmFERnFVdnIxdDhFSVJaVW5jRFF6bWU1M3dZ?=
 =?utf-8?B?R040OWRObG5sTGl6MUNCaXZsQ0pPQlVzOXVEVW1yU1haNFNVTjFBTkp0dThD?=
 =?utf-8?B?Q0hCQzdkd2RQYTBhZCtqWjhTdXE1aVZPZzNFOGNmOS81UVpHaHBSN29vTFg5?=
 =?utf-8?B?UzhXT3VTaUNlbDRTcW5kVUNURTBBaTZ2T1pNVXl3cHhhRHAwZVNIK0tydkhN?=
 =?utf-8?B?a0F4bCtsVVdDMWp4S1F5VHZzTVNVRFN2eDlYU1pYY0NZajhXbFhXTmZ2ajVS?=
 =?utf-8?B?SEkvRXhYckx5bm03WldqV0xaRmVNbHIwUG1IYy9aOUsrY1o1VzlYeFY0TWlD?=
 =?utf-8?B?VGlyWTdRV2JuOHNSWGZxNEcrL21ZOWhSZGJCblJtejRtTXA4MGh3VmRISXhz?=
 =?utf-8?B?M2ZhSUhpZXlpVDlLSlYraWNlWVFQWEc3VjRrbmxRZkJOOEtTRk43cE55ZSts?=
 =?utf-8?B?NVdTTmRHQW1yYmQwcml2WTAwVFgydzB3bGxWOWx3WllmNjJaNHdCajZBcXJC?=
 =?utf-8?B?MWI3TjdpQ1c5UmIxUmVOdGFVV2lPN2NSb200bnlrZkRkZXYrSW05ZVlmd1Nj?=
 =?utf-8?B?a2JqamxWbmdlWXJyZER2YUw2Z3hscTluNjZzczZZc0dwTkpoR1E3MmtEZHRY?=
 =?utf-8?B?UWdPYzQvN0NydGR0M25aUGE4ajVISnNkdHZTU0VTMlExK3BKL0RROW5vekZu?=
 =?utf-8?B?alkxcnFYUnhKa3pyR1BpcWw4ajdyTHRWcXIxNWxUa2NZeUhMdnUxNjgvUkIy?=
 =?utf-8?B?RS9kaitjcUhCV2VjZ1llUWVUMGhRbnBCU0FBVlBMQVNHeDdtT1E0WGVjbUI3?=
 =?utf-8?B?TmpVVlhzL0xSejBSNlZyNm9weDgxemFCQUdpckRtRmowYlNmdW00VStJYWNL?=
 =?utf-8?B?dFFjMHR0a1ZQUFdBTjJVQVhFNURnck5mR2pVSWZDMEF1OVduT0xKc2d2ZUo1?=
 =?utf-8?B?RDY4REs3c0x0UEVJQitnd3krbkV3bHZTNktzUElRYXJpcjhjaTg1K0dOU2Jn?=
 =?utf-8?B?SDBsQU9TRENlcGNzR0ZSS3J6VFJKV0RIb0EzQ3Y3NHhMVGxhMkEyaGFMR1VT?=
 =?utf-8?B?a0JiOXRxYStYYVc5YUd0WGZyMXRXM2EzdDFsSnVDdmg4R0JlMmJZTi9yamRN?=
 =?utf-8?Q?GlPU1XUaj9nIZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRXV0pZQkkrVDVWYys2TEVScThIZUVzaytzYkF6bzV0amxVNmRTNkhmS3hX?=
 =?utf-8?B?S1huUncwSUVGUHpHWC9DaWw5T1hTWHBVdzBFSWhqelZqNFI4eWdZdmVhY1hS?=
 =?utf-8?B?ck0yRitDQlVZVEYzSzBvazArRmNDZFFQeEQ0bEd5YXJpcFJ0MUwzT25vTFFM?=
 =?utf-8?B?RGdYSnY4VWp5NTQ0eENZeUE2SjYxSkIvVit0dHFDQTRNb2g4TlpSbWJvUEsv?=
 =?utf-8?B?N09RcXFwM0JyTjhhdEk2ci91SURackYvQ1NhOEh4R1ZiaVlEMk5kYjRvM2tk?=
 =?utf-8?B?Z3AvSFNnT3hCTEw3ZUlFN05IVU9XYVhpeE1ENlVYbkZtZERLeVBVcldUZVRL?=
 =?utf-8?B?YndVM0I4eWtxWjduRU50VGxiR0NKVEhwNm03cVpsZ1h4UVpHUHhTeUN1WkFU?=
 =?utf-8?B?QkJyZys0cG42MnAyYVMvRTQyL1RiYmxjTjkwUVBVRXhhTWUxSzdIZDdCSStS?=
 =?utf-8?B?ZHdIUXRLWFRpZ2pLYWtqbUVtK3FYVk15RkF3TVdkR2tack9aemUzWlFQTDN3?=
 =?utf-8?B?N2MvYk9tOWtUSFc0dldFeHpYT21tTzBLZFpWV2JFN3pIWmhrSENKQWU1VzFG?=
 =?utf-8?B?WUI2RE9GZ21LS2tJWVdEL25KVzE2alZhb2YrMlRVVXhjMXp5T2F1OXpFV0pU?=
 =?utf-8?B?ZTgyRkFPQlRxN0NtellyVFFQNEliRVBLcC9PbDBDUDU1TXFFSDdBaWh5eXJZ?=
 =?utf-8?B?Z1c2L3d3VVBmaU9SRmJpNTk5THBtbzJWK21ObmRsUjUvamlFTVo3d1NTNVVl?=
 =?utf-8?B?S0dIS3hiRjJZN003Yno5YmVucVpsRUJwd1JWa2NrbzliNDJBbTM4aDFrZVlG?=
 =?utf-8?B?Nk16VDE4VmVGM29xVXVZaVpKSDhuMXUrR2ZnUE5Vc3liRFJoUHhxc2RCNUJH?=
 =?utf-8?B?aTg2N0dQN3Vwc3Awd2d5NGl4d0d3SWJDb0x1Y3I3MVBGZVZnN3RWWkdERk1U?=
 =?utf-8?B?NXNCL3p2SFRaVEExYUh4RDhiS3B4VnY0cVNuYzJ0QkRTaUxzSXlsTjlpdDJT?=
 =?utf-8?B?d2pmOU9QbW5kclNQTWVwZUpZYStsOFg2dnoxWnZEellycjA4RVpMT1BMMFQ3?=
 =?utf-8?B?WC9NK2UzSHNUVW5VQjdPMG1EaWI1MFBqc1VXUURxSFN1SlVYUk1ReFRCUW5Y?=
 =?utf-8?B?U2hkUVJZVkhIdnNTbDBLWkgxZnZzOFpkMTZXQlY2eFZxT2RyVloyOFhudGtE?=
 =?utf-8?B?cUJlK2w4RUl0MDFLS2FTYWlkVDFPSWlDUm4vaTNGN0RDL2owNktTSCtLWlRN?=
 =?utf-8?B?WEIxaVNDbCtFaDhBckhVU3YxU2VNS3ZQd2FyWVhTUHdrSHRzR0NUanRFWmlB?=
 =?utf-8?B?WXhVWXZqaGVhY1dVdFRwR29sUUZjWnFiVUhvZUJ6emJNWTdpazNvQVI5SkIy?=
 =?utf-8?B?RXhNWnBXVDNSckJnSzc1Qk9sZklkNWhiSldISWRwaHJIVWFWTk9YbGZNSC9z?=
 =?utf-8?B?OXM0Z2VtbVRZc0NFVG5MbzVVTGlKMUVTNFo4MG1TQUp2SmZNLy9KaXp6T3hO?=
 =?utf-8?B?NnhubC82M3N5OWlKN1VVUmc0ek5Da1pqRmJqNXVZdnF1K0EwYkQ1aEhiT2dH?=
 =?utf-8?B?RGJoNm1KMUQzOXNIaWFRVFdhVFpJMnhrRjBEQ2dOQW9mdUNvb3JiSmMyQU5H?=
 =?utf-8?B?aW1SL2Z5aUVKaEI0Zzc5U2NRcmoycGJhSlE3eHIxQkNrQmY2bngyelFWU0Na?=
 =?utf-8?B?OGdIYWcvNkpDN004VHBncGRFQ2JnRFo0em10NGV5bUtVclBQbHZkYk9BQWVL?=
 =?utf-8?B?MDhJak11TGFLY1h2bnFMd1kxcVRKdGd4LzNuc2U2RHpXbWFqL096b3BCamln?=
 =?utf-8?B?cUZkR1QzQ0RXajlsZDZ6VHU0Ry9GS2FBQ3JmYkFCM3Y2VGoxMSt2NXVpUVlh?=
 =?utf-8?B?NnBsNUpaZzViZWFmd2FQYWsxc2tKVExWWTJxbkpBQUpvR3QxekE5Rzl1K205?=
 =?utf-8?B?NWhza3hjalVBQTVGY24xR1JnYWUreEZsWnRHQmZ4MTg2UGFvaGlLV3BQTFdi?=
 =?utf-8?B?SzNCQk9ZL3Fja05pTjhtTk1MY1pFYjdWNEdQOTBCWFBFcy84eDRpanppTGJ5?=
 =?utf-8?B?NVlqUm83SUdkZ21wQUIrZVNNT0Q1cnJFZ0V2alFOQzFHbmh6cnl2emxiOHZm?=
 =?utf-8?B?b0NPMmFwOVR5aGJRQk1ib3JNK3ZyNkNmR0RhUXJFeXh4SGZOVHhIVFdWNUgw?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fabeb77-153f-4d81-2401-08dd6d2e6d03
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 12:53:52.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYkDF9XNfHOTsNEBM9ErGhT99+bL6YFLyCSnnMVhw+Hk1Tta6cATWG9zz+IDbKXpogcwM8N5oRDiZHl3EmAt0PwCY5+9HimqWy+7wufokHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com

On 13/03/2025 11:35, Rui Salvaterra wrote:
> This is enabled by default in other Intel drivers I've checked (e1000, e1000e,
> iavf, igb and ice). Fixes an out-of-the-box performance issue when running
> OpenWrt on typical mini-PCs with igc-supported Ethernet controllers and 802.1Q
> VLAN configurations, as ethtool isn't part of the default packages and sane
> defaults are expected.
> 
> In my specific case, with an Intel N100-based machine with four I226-V Ethernet
> controllers, my upload performance increased from under 30 Mb/s to the expected
> ~1 Gb/s.
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

