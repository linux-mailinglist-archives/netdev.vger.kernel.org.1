Return-Path: <netdev+bounces-234146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD2C1D2EF
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED1418857DA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A8334C20;
	Wed, 29 Oct 2025 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYh/f+Qq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C862EA17E;
	Wed, 29 Oct 2025 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769020; cv=fail; b=r2j/gC3o0JpZ50c+TCYgZCXVHay8AqwzZv35UGXyTEt25WX4HsZDyckjFtpRg5OFjQOb3c0mkFFswr3mZTSrdFfd6im3Sf8nJ9ECyy0IdsYwOAUseiDxXQBXLjU00BcB8cVMtbII28SoJlkb82FzbcDSjd8Sc0UY04fX4uvCJ8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769020; c=relaxed/simple;
	bh=TSfYComudZErnYKsH7jURycwPIrwOb8rlOE21Pc8w7U=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r259xFJdo6gu61RsBh6wIanEJMOhrL3rTrYLQtWPn1swWpjPwoiO7wHHQiGgHv8CAc+65xYr1/Nfwlls5WpSN1a3bgSwBHGPTjZJRFnmkzUCB2vds4YsD6liOeiiSvyQ7qIk6TRJt40tmszCwj7P4AoeiHP3t/RjNIcM3QIhySI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYh/f+Qq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761769018; x=1793305018;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:mime-version;
  bh=TSfYComudZErnYKsH7jURycwPIrwOb8rlOE21Pc8w7U=;
  b=LYh/f+QquC7HSqtzsfgLUuSUxiUGzs+tpUYb1n4guGYZULA0X0tXxbJ8
   PwQhri3MHwRg7eTqO4gBE64GQ7w0N4kuSOVrlLInILTSFc+sD5MVrEAjS
   W/ncRLuPcwFHQSUaRKTveNPaDJs4M0MKzcW18/z3Em4fbrAGvYOCWzuUz
   GnwYHSurv0sU42Aioey6zNKLPE0w/1DrFFg4f/Noa6N8PbI758ehAKNCc
   3qagn6wGFjgoVU84hbuyCao7znUrRlq/hGqE5aTCyAagKSl2U17aWXHEp
   zd8Mjx2UbQB0graT4ZiBYDxNKiHiHuctJis5iWZSpYDEBfGw4mZHC+TVe
   A==;
X-CSE-ConnectionGUID: JoALFaVNQtG5UozaRemR0A==
X-CSE-MsgGUID: Zdxckpz1TgO6kYyzAforoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67738286"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="67738286"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:16:58 -0700
X-CSE-ConnectionGUID: pevI70znRKGKHk9TxjvZUQ==
X-CSE-MsgGUID: DKAV3Z6dSlGot9Lfb6qg7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="asc'?scan'208";a="190895134"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:16:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 13:16:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 13:16:57 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.59)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 13:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8/upTCRhFf7olCx/8hcj2PvagMXCcAdK3wN+LGhI8bUDHEtJSN6KHtmcruUJ6KicrKAWqPyc6YoxKOGZ5DznyA2L9RnSp4i/05UmfnEo+QN+rEGrpXK0Xq9/eyW2G26rpdYV0bYsysWgce+Ph406B9oAjmFjH2inA1FRE6XlPn/+Zvqher0OayZD1ebveL/eWlhDDevVaaiB4+Rb51J+QxCaw45vCuNwRFAhwDUiAcOPJ8SJa/b2+lcQB3Nl0rDF9UH00RVPMdbWQFEQaJ99xJqytPi94MsFyjaNAzxmV46XsIE1AibaNDV3gOurwyJTADh+o8pIMQEyh2YZOkYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R3NUsrVi3kXIGrtKx77REbRipoHR9P5hcT7pViB6ic=;
 b=Aa5XTi+tpTK2BAFizaBMQ2MF2WBJNxFd08+dVznUC0HcpuWNxONed+Cdm9VOJnkAOgHhoW80lXTFbSzePw/dTc17/P/dKR2nu3lE3eeh6ofuP80lzE2Ykc1dlfErT4DrtP6rDGoneXc84MfUOyMc7WEyvIPo16lJWQ5Q1ecT/WpWgMLueNpFoMaz5amgqRYV1mi0nQ4qkEUQLLdR9XmJRFI1O0umyaOiI76qIfpvajsDnVuBfiLBGZB73vWMXrwlZDD/VlF9mhjelOw7gzZn9HdQ84cZvNGa/QxeaSMFx/dyPA48B4TzJnBzN+9SwHlQgec/x3hf24+FCP1lIQ4Srw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH3PPFB9A266170.namprd11.prod.outlook.com (2603:10b6:518:1::d45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 20:16:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 20:16:55 +0000
Message-ID: <8eeed232-8cf4-4a80-a7eb-81d72c49c8a2@intel.com>
Date: Wed, 29 Oct 2025 13:16:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kdoc: fix duplicate section warning message
From: Jacob Keller <jacob.e.keller@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
 <94b517b7-ff20-463b-a748-12e080840985@infradead.org>
 <e8e0cc0d-3f71-42a9-b549-39840952ef0c@intel.com>
Content-Language: en-US
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <e8e0cc0d-3f71-42a9-b549-39840952ef0c@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Vh8m9R9uYcgoVkgnRTwHMNx2"
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH3PPFB9A266170:EE_
X-MS-Office365-Filtering-Correlation-Id: c22d66a2-04c9-42a5-69cf-08de17281b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXp2UWlYZjJwUGZFaHQvekZiRDZ1b2NQa08vekRBMzZrbnBxVnlWTWVqWFM1?=
 =?utf-8?B?MTVYT0hKUCtXRS9sYk84Z3BMaUZ3MHNWdGpFKzBuOVdKT01pclpscVJUSTUx?=
 =?utf-8?B?RlJnWk1VazV5dFh5Yk5vNXFjK2ppdWhzSi9PWWRDd2MxeXo1K0F2ODIyOWxJ?=
 =?utf-8?B?b1RZVGw3N25JRmhYY1QralhLREEzRzRDdGJCSUhaR0kyUEMvZnAwTnNCYnlN?=
 =?utf-8?B?dlZXdS9FR1dYeXBEdVEwVkdlSEFzNnRjcHpSS25GZ1VRd2NOaXZ4QVVwVUZi?=
 =?utf-8?B?UVJvcTNxeFQ3UXVUbDdVWHNNcWFoYkRWM1BOMGkxa283b3FRNmFOMnBsTGor?=
 =?utf-8?B?TzM1WVNVVnQvakFqUmtGQTRjTWk3WU0wRGdOdVIzVW9TSmRmUUdtRUplK0Vq?=
 =?utf-8?B?LzlhQW1aaWtPMU1Xeko4a2x5dTMrUkR3cVNqS2JTV1I1VHE5S3lwTERSQXZF?=
 =?utf-8?B?OHoyRkNRb1JCaUxFVmdaQUZoOWpPNVpxbUp4UVY5WUhyd24zZVlObjJOaHd4?=
 =?utf-8?B?c1VoUG9aTDZ4bUdDSTM3cTg1NllpUnRGV05DTDZKRjNsd2kySEhBQlgvMm56?=
 =?utf-8?B?ci80bEFRR3ozRmFOR2E1MUYwcDlKL2VSYmZ0dUNYOVgrUUNGOGNLYjltd1Zw?=
 =?utf-8?B?MGJzZzhWZUlpRWd1WDhISlFwMmE0VVhNRjdNVCtxMTJhWFlaTVJKWDVRK0Ey?=
 =?utf-8?B?QnlGdzRqR1drcjJiZUNaMG80cWVxelJhMDZBQnZFVTlJQWpMRDJaQlcrc1Bj?=
 =?utf-8?B?MlVtR09PRVViUWpqeHgxbVhzTTc5OFI0dTZGbm1Bam10bm9FR09VWkJZSGxz?=
 =?utf-8?B?V1FRMVF2UmIwOFNxMFk1Y1lBRVN3cHNnSVRHbEszK3p0ZVMxc2hORG02SWY5?=
 =?utf-8?B?TlJpa01VYVpZb0N1OWh1T28wL3l4U25BQzV6WFhmS1gzYkFRbE8vdDd6UzZz?=
 =?utf-8?B?NWpqQ1FpdGZwaVNzbHVkWkttNldmcXBpallrY05uYitPWGtMRlZwRWFjNnNZ?=
 =?utf-8?B?ZlVhVUNUalYrOFFldWpDenU1cGFoMW92ZGJCVVZ6RElvcDdTaHpDRmtYWXZS?=
 =?utf-8?B?WXRhWFg5MktUTmZJMHN3SFJqTEoxZTJSTUFBUkpoVjU2YXNMVGQzVWplM2tj?=
 =?utf-8?B?ZGcyWlZzaFBZWHl0Y084SEI2WDRLQ2xOdlYrWnZBTFFXTklGRlBqamZLeTI2?=
 =?utf-8?B?bit2MVJRYnVnclREMis4M3UrdDZRU1kwSmluRXR2cjNwbStNYkVKSzJDK2s4?=
 =?utf-8?B?WS9VdjVzRzVOaDdYNG5UMnBNZjlEbGdZZ1BzeUlzSld6UzRZb056ckdhYWN1?=
 =?utf-8?B?VVg2LzBIZjJaSStiZEUyWTJiV21uYm5TWndSR1pwTEJIVEFiL29EclQ5ck92?=
 =?utf-8?B?L3BkeExNTXBjbk9ZQ1BFWWljbmVGR2VFVFlFd0twVHVYeHFsMkZheTI0djQz?=
 =?utf-8?B?Zm9ST0JsNy9TWGZ6MTBjTHNaakxWNElwS1hGQUV2SW1GNnRqTEZabVFaN2Ux?=
 =?utf-8?B?RkhCNGFxcGJPYXdXb21pRGJOYjdjMklTRlQ2MjBpalBNeWljbnNIaXFodTk5?=
 =?utf-8?B?MkpBM1Rmd0JSTHhBQTA1aytCeXBDU3BlWnFJSW9Xc0MwcEM2OW84VlhEbHpw?=
 =?utf-8?B?cUNBZDRPbkdmengxSkJ4Ukd6VEprZENvc1lIWk9IamltNEpReS94ckNKRG9H?=
 =?utf-8?B?dFZucFpYVEZ0SFlvbWw5OVFpYzBHMTREM1pKTmt2eEVmUUw2TlQ2L2tLajY5?=
 =?utf-8?B?L1pJRlRWSGV1enp1WDVBdkZMZlZ0d1kxbmNJU3h1SFhNbEErNVdYMW91SHMy?=
 =?utf-8?B?dlpPcFhxUFZ2UUJlanMvZUdEUGREYzdNU2hQZFdKc0tXbVNaelVYaTFPTkVH?=
 =?utf-8?B?QVg5LzFLU1luQWlqd1dRV085V1h3R3duN2tqTDU2UzJFUG53MzhYL0VCVWNF?=
 =?utf-8?Q?rQL2QaoNAMM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjY1OEc2eXdVdmpVY3ZZTDhCK05DVXVnUTRyTzFzdHlIeVB5MWRJc2daMG91?=
 =?utf-8?B?OENYU21YaGt6V2dQK1d5bEVwRkxPelh5WFBNZ3BrWFhXQUJ5bWhxVDRHeDM1?=
 =?utf-8?B?bXhPRjNHZGlMWS9TbTVCVnlGbmM4MjdhMHEwQlExTm1PWllhWXJpYjZnRnBD?=
 =?utf-8?B?N0JIZTVnMUI3UTVKdXpHNUpQWHNpMHZSbUJabWxnQy9QVG9zQlMrTXdjS3lG?=
 =?utf-8?B?anJ2WnczOXI3LzVCVTIxVFNHenVHNXNad0lseFVuc2tHUmprMkloRmZsUk1v?=
 =?utf-8?B?ZUpYbUhsbUluUmhBU1BkWEdhQm1yRGJaWTBPWWIvZkZxd1ovZGU2WkYrMWNq?=
 =?utf-8?B?V0k2dnZjd2tUUFI0MW5PZklheUorMS9ldDg1TGJNVHZmWnRQdWx2d2dia05x?=
 =?utf-8?B?Z0NKcFNTRGo2amw0YkNFUklPVkZ6aDdVUk9HUlZZaXdnazBKMWRtM2xXOUJG?=
 =?utf-8?B?aUZLbTI1WVNYQTVWSjVvSlN5aXUvZU1obzVxdkxBSDF3cFdSYjFFRElYd0tN?=
 =?utf-8?B?dGpoRVBveDhDYmNlVGpCM3orVmZjekJyeGxacHpIblVLNUs3NzA5WG5EUXgz?=
 =?utf-8?B?bHlHbkpTQ2JiM1Mra1l5dFRPOFBCU29nb3Y4djRLUDBqK3MvVThJV1RwUzAz?=
 =?utf-8?B?bDVLcnNMMHM1SDhsQVFJOGI5czF6NzltZmtRRG1wYVAyYUhnTkgwUm5uNDJw?=
 =?utf-8?B?bDdiY1ovcWdjbjBwRmFNOVlKa2srQlNPSmtydGJmV0NHNU43K0xoRzJPNW9a?=
 =?utf-8?B?YzU1d0tSVkMwQmlrVVQ4NFdYTHRRR0g3Zlo0NTY4Wjh4Vm4vYjVCdlE4RzZ4?=
 =?utf-8?B?QldXcEptV1hFaFhTSkFHRC81K2k0RzBnVWpWK0I5dGRXRGo5UDlOaEpJaFo1?=
 =?utf-8?B?T0U5U1dVcjg3NkN1cHBMVWVuRkRIaDZQcU5pVmlkQXlqbUNmQ3c0NjlEVmpx?=
 =?utf-8?B?QStYYzNmYk9CbkdWRzl1LzRjYWQxMWVEWWdaMFRBUnAvTzVQN1NZOHFQNDNU?=
 =?utf-8?B?SnhMT3ZqU2MzTERiUmlYaGNMSHYwakg4WENvMzRML1ZTS1kzWlQwemRMbGZT?=
 =?utf-8?B?TlREOWg1c0dUNCtZN3FmaGthbHRGdjkvV1kyd2RrS1BzaTN4bk1LYy9OZWpy?=
 =?utf-8?B?VUhkUVFqRnFBWFYwODR4eTN5SnkwUHMvUEQ0S1dDYVptM2JqdXhvNjFSTHdR?=
 =?utf-8?B?QnIrSHNrazNnZFhVYzVuQVdOWWhKN0QxZGpXUjc4dmFlRWJHaXYyOHpqcUln?=
 =?utf-8?B?cFVFNUhEWnBBMlFPV3I0Rm1iazl5Rm40MUFiM0FSWTVOdFF5Mm1QTUs4YzFH?=
 =?utf-8?B?UDVoazhiR0xxNDFQZm1nOC9iNXJxMXlZR2dsZEhES1BCWkQrUmVJSm9RUGlH?=
 =?utf-8?B?Y0pIR0dmYk9UU0pmWHgvaFJWZDNCaWtRQ3p3b0tTdzNnak5hSzlyeDl0V2Qv?=
 =?utf-8?B?Y0o1Z2xXTmtadldOZ0hSeEJCQ3FCZWUvOXlqalR5bk9RUUhoQ0RQazRTalQz?=
 =?utf-8?B?MndMZDhUTFdoTHROZUIzUFNqWE01V1BrQTZMUDFpM2pJTkhIdHZMRVc0UGZ1?=
 =?utf-8?B?L2R4NzhWSFhEREx6L0Y3c05hNVBWMVZVM0tTOXlwUkVQVXZiZlFYem5yZjM2?=
 =?utf-8?B?WE1CRGhnMWpoWEZ0ZnJERHF6TkN0S1F3R1NxRzErTXgxUlBGVjRNQzFXbEx3?=
 =?utf-8?B?NDR5dHpWSzYrWUZZRmoyYWxTUWdJdXllR3MyVGVWVCtidTN4UVJoNFJOQjVl?=
 =?utf-8?B?NUgxQnE3SlJnaStVK1RWV0xZaDRidlVndDZ3Q1BpNklIMG4rVS9SY3ZlaE5n?=
 =?utf-8?B?Mkh6VERSbnR6Z1RSRDI1ZHl2RGpwWTZtUnZjRkExMlExbmRNR2FuM2VOQXV2?=
 =?utf-8?B?RTVsb0tPR3VYTjFGbUJ6Y201M3dRQnM3YTlMUkFIdksyVzZWV05YeWp5cFk0?=
 =?utf-8?B?MytxS2h5ZmpVWkNsZkc0OFByRE80U3k1d005UElRQ01GblNZTjlvUjZJRzIw?=
 =?utf-8?B?UEh5b055aHdkL1ZWbjRndFkzYkUxekVPWjdvaDBqRERvT2MyaUVXUWJrNHZv?=
 =?utf-8?B?b29RQTljKzNwZXZRQ045ZlU4SWRTSDRJc09WUFY0N05hZHgvWjVOS2NDRGpo?=
 =?utf-8?B?K3V4by94eFprYitNbnNlNFEwODlVcndxQ2dDU1pwVFk5TG4xTzQySlc1WVAy?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c22d66a2-04c9-42a5-69cf-08de17281b0c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 20:16:55.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6vWuiMf2KsbOdFNOGmy0BN7yOw1TAZfFaeZqEuad/SJHiB1ZQNFZVSJwcAra5Zx8SIWuTKedWxIKAfL0deUn6s4ej6K/cegVdS1eY8TP40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB9A266170
X-OriginatorOrg: intel.com

--------------Vh8m9R9uYcgoVkgnRTwHMNx2
Content-Type: multipart/mixed; boundary="------------I1ZjE0XUEgvx0sUU0Jjq4qpq";
 protected-headers="v1"
Message-ID: <8eeed232-8cf4-4a80-a7eb-81d72c49c8a2@intel.com>
Date: Wed, 29 Oct 2025 13:16:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kdoc: fix duplicate section warning message
From: Jacob Keller <jacob.e.keller@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
 <94b517b7-ff20-463b-a748-12e080840985@infradead.org>
 <e8e0cc0d-3f71-42a9-b549-39840952ef0c@intel.com>
Content-Language: en-US
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <e8e0cc0d-3f71-42a9-b549-39840952ef0c@intel.com>

--------------I1ZjE0XUEgvx0sUU0Jjq4qpq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/29/2025 1:04 PM, Jacob Keller wrote:
>=20
>=20
> On 10/29/2025 12:45 PM, Randy Dunlap wrote:
>> Hi Jacob,
>>
>> On 10/29/25 11:30 AM, Jacob Keller wrote:
>>> The python version of the kernel-doc parser emits some strange warnin=
gs
>>> with just a line number in certain cases:
>>>
>>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>>> Warning: 174
>>> Warning: 184
>>> Warning: 190
>>> Warning: include/linux/virtio_config.h:226 No description found for r=
eturn value of '__virtio_test_bit'
>>> Warning: include/linux/virtio_config.h:259 No description found for r=
eturn value of 'virtio_has_feature'
>>> Warning: include/linux/virtio_config.h:283 No description found for r=
eturn value of 'virtio_has_dma_quirk'
>>> Warning: include/linux/virtio_config.h:392 No description found for r=
eturn value of 'virtqueue_set_affinity'
>>>
>>> I eventually tracked this down to the lone call of emit_msg() in the
>>> KernelEntry class, which looks like:
>>>
>>>   self.emit_msg(self.new_start_line, f"duplicate section name '{name}=
'\n")
>>>
>>> This looks like all the other emit_msg calls. Unfortunately, the defi=
nition
>>> within the KernelEntry class takes only a message parameter and not a=
 line
>>> number. The intended message is passed as the warning!
>>>
>>> Pass the filename to the KernelEntry class, and use this to build the=
 log
>>> message in the same way as the KernelDoc class does.
>>>
>>> To avoid future errors, mark the warning parameter for both emit_msg
>>> definitions as a keyword-only argument. This will prevent accidentall=
y
>>> passing a string as the warning parameter in the future.
>>>
>>> Also fix the call in dump_section to avoid an unnecessary additional
>>> newline.
>>>
>>> Fixes: e3b42e94cf10 ("scripts/lib/kdoc/kdoc_parser.py: move kernel en=
try to a class")
>>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>>> ---
>>> We recently discovered this while working on some netdev text
>>> infrastructure. All of the duplicate section warnings are not being l=
ogged
>>> properly, which was confusing the warning comparison logic we have fo=
r
>>> testing patches in NIPA.
>>>
>>> This appears to have been caused by the optimizations in:
>>> https://lore.kernel.org/all/cover.1745564565.git.mchehab+huawei@kerne=
l.org/
>>>
>>> Before this fix:
>>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>>> Warning: 174
>>> Warning: 184
>>> Warning: 190
>>> Warning: include/linux/virtio_config.h:226 No description found for r=
eturn value of '__virtio_test_bit'
>>> Warning: include/linux/virtio_config.h:259 No description found for r=
eturn value of 'virtio_has_feature'
>>> Warning: include/linux/virtio_config.h:283 No description found for r=
eturn value of 'virtio_has_dma_quirk'
>>> Warning: include/linux/virtio_config.h:392 No description found for r=
eturn value of 'virtqueue_set_affinity'
>>>
>>> After this fix:
>>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>>> Warning: include/linux/virtio_config.h:174 duplicate section name 'Re=
turn'
>>> Warning: include/linux/virtio_config.h:184 duplicate section name 'Re=
turn'
>>> Warning: include/linux/virtio_config.h:190 duplicate section name 'Re=
turn'
>>> Warning: include/linux/virtio_config.h:226 No description found for r=
eturn value of '__virtio_test_bit'
>>> Warning: include/linux/virtio_config.h:259 No description found for r=
eturn value of 'virtio_has_feature'
>>> Warning: include/linux/virtio_config.h:283 No description found for r=
eturn value of 'virtio_has_dma_quirk'
>>> Warning: include/linux/virtio_config.h:392 No description found for r=
eturn value of 'virtqueue_set_affinity'
>>> ---
>>>  scripts/lib/kdoc/kdoc_parser.py | 20 ++++++++++++--------
>>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>
>>> ---
>>> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
>>> change-id: 20251029-jk-fix-kernel-doc-duplicate-return-warning-bd57ea=
39c628
>>
>> What is that base-commit? I don't have it.
>> It doesn't apply to linux-next (I didn't check docs-next).
>> It does apply cleanly to kernel v6.18-rc3.
>>
>=20
> Hm. Its e53642b87a4f ("Merge tag 'v6.18-rc3-smb-server-fixes' of
> git://git.samba.org/ksmbd") which was the top of
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git as o=
f
> when I made the commit. I wasn't sure which tree to base on since I'm
> not a regular contributor to the docs stuff, so I just based on Linus's=

> tree instead of linux-next.
>=20
>> and it does fix the Warning messages to be something useful. Thanks.
>>
>> We'll have to see if Mauro already has a fix for this. (I reported
>> it a couple of weeks ago.)
>=20

I rebased clean onto docs-next, so if there is a fix its not on that
tree as of 90b6a53073df ("Documentation: fix reference to
PR_SPEC_L1D_FLUSH")

Thanks,
Jake

--------------I1ZjE0XUEgvx0sUU0Jjq4qpq--

--------------Vh8m9R9uYcgoVkgnRTwHMNx2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQJ2NgUDAAAAAAAKCRBqll0+bw8o6Bno
AP9phOXUufLRUsbsY4RWqRHw++f6+Cqv4zoOL27/GUZkPAEAvP5jh0gs02K/evSYZ4MOGN/gxUif
5npIFcYYUWedggc=
=+fpS
-----END PGP SIGNATURE-----

--------------Vh8m9R9uYcgoVkgnRTwHMNx2--

