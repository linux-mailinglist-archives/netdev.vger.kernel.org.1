Return-Path: <netdev+bounces-135862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246F799F72A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DA11F2704E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7271F669D;
	Tue, 15 Oct 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/ODG50u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D51B3929;
	Tue, 15 Oct 2024 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019958; cv=fail; b=EsqOFXC5lTs2gPM+4WG1UQYD+A3tz+uFlEpw0K5K2OBtQeKvf+0ksuk17pZQbAIHgJWtJf3O0BEHiIyj58bHUHd/StFq5JzN+mH8LL/OOF9peILaoPDIQuhp2oHt7tS7eS49ceG6wPPzXvvMQT+LeqL/ZOM9kD2BYoc+cF/sXkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019958; c=relaxed/simple;
	bh=gYlhxWsPhrwMGmXJFyyA5EQr9iOuoO82C7nUr5q9LaE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0tAucHiYJ0vTQOpalhNZoeyV0gnTAEMk2sBqJHf9+gHIQRpAbe6Gi6B3PX4IUJqyw4BHH19IN+8PQvaIhUSk8aAB0XsLTfGaPOxkx+CkPMcCmtN+Urdx+YIiyLQGp5WgQYzVQ+4YnTBfzDniINkz4FoNkzDiCukJFcXCgjNWPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/ODG50u; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729019957; x=1760555957;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gYlhxWsPhrwMGmXJFyyA5EQr9iOuoO82C7nUr5q9LaE=;
  b=d/ODG50utT1hD0YkQntopF912xES8qLHTo+bMV7gRTrWLUnj/lY0qyjH
   2YrJ02EFI2BbVf71tzh+hQj52qOZock76z2G6ekuEQdq8diIfaH+5a1he
   fdJB2n5+Ld4u5xWBkf2GuGCTi4dv7RUzuxziBr/FLTJytA0pyppRBCu6R
   wsNdYrPiAK7toZFPpmZT71rdsH+Co66b79AGfmYcFJaQ3ajZQUFxBf6r1
   Rv95SJbZmaWGxxe5oKzs9kIIQmhPUdOjn4Is+lhL8k0AjI6yXubfZgbL3
   steCKUNjP847p1ROg5YvGzajwWmJaGJPlsi7GWLQpfg3TRzcuNSng2DWh
   Q==;
X-CSE-ConnectionGUID: 7JlZLrQcQJmwJYnkgv9AjA==
X-CSE-MsgGUID: UnpDGZJGQPijdnnjFRdhzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="53846860"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="53846860"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 12:19:16 -0700
X-CSE-ConnectionGUID: VlgtFzg/ScGl0Sfzz7pnMg==
X-CSE-MsgGUID: DAwpOZczQ1S9BIpZo2Ll5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77876820"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 12:19:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 12:19:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 12:19:15 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 12:19:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/bDds8aZNhezXkCrHvQyqDTdT1lnsdP8HsUhZbPPAveMnXsk4la3jmZr7rRzcu/FLHDo4EGoU0ljqlMzDXOuQHaB0zyn71DsiRtYqmZqfERXY6ZVAHafBCa5CzSmXeFUXSvKJ2Ru+Ba4YdeLXLEAEDnKDqzqW5bnAP51DmCQg0lLajflX0JpEZWwdnqYj5udMcVGbq4m7QDOYZf9z8OHfKMGjPFiBc6epUwhTwnaHwmbhFAAVgwpgKE5Rauc0n6ZuGSZJtfSRD8Q3dGPzUy9pkne00DotWpFGghr81p0lsmvYDeoS5H+9na83hYWu8N5wi/+VSo3yhxyiFKVbopKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YC8Q413ogFt/WGCOrZggjjQzp+u6BOpWvo899TWErU=;
 b=eff3fFA24Xbp24WkK/VDPrpcZIBI4WWbemsrQTT2JX4V2DgdWd4aHsJykKqhq7dwO99SxeOeLKfoK1IqrG0zkL/1dYd5gk83RA3lRgFL6FHoU6oqgYJncGspSKukK9Yll/VttwBF6SU1uKn7gi9B/e0xiYes1CbCkquvEAU490SQhcwEwTgqcQJwJYi5aS4Y0yaUvIDDJPDqTrDOpGPE1PT6aevlOU4n02U74Re7xoATg588wBlneWp5QSNz3uB9jT9lX09Zso88IxlSX8l+z1ORA3KngF1YJAXLQhNs376FeyA7PNt7UIBKfcUbXdJ8fwc7R5XXowl4LiGzwX5vog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 19:19:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 19:19:11 +0000
Message-ID: <6cf46beb-92e8-42b4-a49a-aaf897143d8b@intel.com>
Date: Tue, 15 Oct 2024 12:19:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
To: Masahiro Yamada <masahiroy@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e5e9c8-bbd9-440e-9c81-08dced4e3f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0IxRFJQTW43OWloTUFYejVyM0V0WVg4UnNlZHlzeGZWbnZaMTMrbGdZdHRB?=
 =?utf-8?B?N0tQTG03T2h1dm1XbDExY2l2akJ1VExTQ2UxRVFCUG9GK1NDdEdRMExDdkk1?=
 =?utf-8?B?ZXNNamxBbmMxcUVBbVZJOC80S2FGY3RqWnRBayswSlFmNHRsc2gwVEJzUkFa?=
 =?utf-8?B?N3g3VERma3FmTURYSW5acHMxZThKQVFaR0djS25HQ0l6WU54eXloQnJCVlFl?=
 =?utf-8?B?MWs3T1pXZTdUM1VKUVkxeFFqVzhpbzNpdUFkTWc4YkhBdjFjU2o5NzYwa282?=
 =?utf-8?B?WWEzU2F2d3l6dFRJaDFKWlIrSXpLYkdWMEpJNHRSa0VLeEFuQlg0U0xrS3ZZ?=
 =?utf-8?B?TlNueStjaWZ1dDhZaXJUTWI1THNkbkpVUDVuZGRzamNjQ1hQSkpzb2FtK05K?=
 =?utf-8?B?NFBobk9qalZOd3BUS1U4dmpTRXZhTzZSdis4M1lkbjdrbGIzS3ZhWGpTZ0Z4?=
 =?utf-8?B?M3I4enhraVVqR2ZzOUdtU0duWlVjdjB2d0Z2QUhiNjArNUVjNTZPanVLWng2?=
 =?utf-8?B?cmFuNW1XcFErOWdFalN1cmRMbDhuNFVZMFl5TU5ETFRMMkNTTWl6WDZYZjht?=
 =?utf-8?B?cHF2WEdwbWFBT1RvbVBXWGtZdzZoeG0wYWVFWktRZUtZRWNPOU9VZU9RRTRC?=
 =?utf-8?B?ZW1UZ1QrRmtmMmNlQ3VtZkhBT011Q3NqNjd2cml2WmcyNkJsSG93MkpZSjNx?=
 =?utf-8?B?RFRvNGFncXF2K01FSXIvajhyb1lWSFRldmEraUd5ZjQyTi9BUUdBakRJeGZS?=
 =?utf-8?B?OHVoM0dqaTY5aWx5QjVBek9GWnVOY0pBV0NHWVA4U1ZHdEZuZTZnc09DTWtH?=
 =?utf-8?B?cUdjS2F6ZFZnQjBUcE5mTUljUzR0VlI5cEdTUUhWS2lUd2JJVXN1cURiOG41?=
 =?utf-8?B?UUFSZkMwUWU1MGd3bjRmWlZUVlBxSEQveEIxT2wrT3QyeTB3ai92Z2psZHc0?=
 =?utf-8?B?QXByWW9heGxETmhUNGwwK2VOaUpEcGZJNlkzWU5nMTZZY1JaMWNWajZWWi9P?=
 =?utf-8?B?RjJMR3ZYYVlQdjRaK1htcG5iaW1EaFc5dE1LUWpmdjllSUtFYjRUQlJsSFFZ?=
 =?utf-8?B?ZTJ3elcycjBmcjlmMHVhOFVsR3NQWWdUcGhVVGZSSUp0Rm55dGM0QTFITXgr?=
 =?utf-8?B?S3RaOG5mcVpySytDaC95MmlSZDdSNnJocXhKWmlwMUpKNWQwdExaTis5cFBM?=
 =?utf-8?B?eTIxazVuUjdOTEhnaVIxSTdZQko5N214bSszakJYNStXUVBycWpPcjRvaWFT?=
 =?utf-8?B?OFVESnFpbG9DckFHWW9udzdFWFdSbVFSOXF2QjE4WFUrZHpNYTB2NjFBR0Rx?=
 =?utf-8?B?OUxaaG42NVdSRmRvakpMMlNsS0p4MThmR3NDNlc2aXg3MFBZWE0zTXJIVDBx?=
 =?utf-8?B?VlhzaFVvK3VPNWhOeGxHSkNWeEk5bnQ1YWZrUWs1bThHYkYrZXlTL2daNnd2?=
 =?utf-8?B?TTJjbHJMM0lheUluOFhJY2hzWXdlODFSU0h0MGgxenpLanRvR0c5RHlmVjUr?=
 =?utf-8?B?Z0NYNi9ocXdtTWowZVNaNzh1RUxGWWpLYUhsQ1JTVFg0TFJ6UVF2VjBIbmpm?=
 =?utf-8?B?VTkzalhxQmtCNi83bjFFWlF1aXBjVXNOMDdZWDhhVFJJTmJqVW5QdVB1UUJs?=
 =?utf-8?B?VXVoTmtaTHJFK1o3ckhiWnBPYkhmd0ZLSGNYZlFjdkpjQ0kyakNGRWdOZ3VQ?=
 =?utf-8?B?WjZhK1U0Z1lUbXpRNHlOSUo0UjhrUDNGQmxDRVRUT0wwTE9tVnhZYjZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE5NR3FwRTcvRjBONDVGRWNrNTh0OXpSdVpLcmNlWkRBRzR3dlYvT0VWRlgv?=
 =?utf-8?B?NE50UDdEa2ludmhCM294STZ4R2huYTJVcnNrTXg5SU9nNjJBRldDTmFhd2xB?=
 =?utf-8?B?ZWh5MkpYcVJQR1FFbFVIU2VPVGprOXhsR2FUSS81cjNKaVNpRy90UDQ3S2sy?=
 =?utf-8?B?VC85YlY1MjBJU3Y0T2NONzFycERMWDZJR29lVVl1QjYrSUdhbEFIbzBhSnJu?=
 =?utf-8?B?dXd4WGZtNGJxbWZZWDVCUmZhaXJMU3BGanFEbGhuLytySVZ3cjdad3FQMnA0?=
 =?utf-8?B?aW55a0JrOVBDeDVrVlVMOVgybGM5QlJ3ZjBhT05BNVZ1d2RDb1BUTU1FK2ZD?=
 =?utf-8?B?K0V1ZWt3Y0JKV1lYR3poZ1N0VHlJOVB2dTNJUCtmdG5JTDBjWk5BM0I1RDM3?=
 =?utf-8?B?cW9YWTNGamNRWnExOFFqWDNTYURkd295TkhxYkp5Nk9DWGo5M3JreTZEdERw?=
 =?utf-8?B?ZUJxd1ljRjZNN0ZzNTJWdzBQWXNsNFRLVm5vWi9SWGF6ZDFDN1BFcUJJbzA0?=
 =?utf-8?B?ZUZZRHZrU2dvV0x5Y1FvNlk1a293aFZpWE4wQUhzWlZNUWxQa0J1MjlmTlJN?=
 =?utf-8?B?blcvWGZnQVpCMVFYZ3lKTXpsSDZYblZNZ1Z4RnBiaURjSU8zbmhlTW94WHpI?=
 =?utf-8?B?Nnl4dUo1SDkzU2N4VmVwRFlQUTBGclRNeFZrNDdXQmNIem1mQ25zcFc2blN3?=
 =?utf-8?B?NEdlRmphN01ESjBjZVdhYkFna2l2eEl5REdWMnU4ZDVMV0duc3NsZG5YaG9l?=
 =?utf-8?B?dkVUcW1NMEtoVWcwSVdkTCtteStnOUVRcnFDMDhWcWh5WmhlVkNuYXFBVW9N?=
 =?utf-8?B?cm42WkdDVWpxSXFuMXJ3TkdzVlJ0SmxwaXlMZTZEeFNOVStyOVYrMGRTUkFr?=
 =?utf-8?B?VHJEYVpPT2FDdHhOM1ZUT09nZ2FmZjJzaVVOa2VOK3dZaTE0VG9FeldzWEZR?=
 =?utf-8?B?ZXNkNmptVmlXUXJpY0lkQzFVdTNuLzFjUHNLWUxJWHRQODN3Szk3b0pKWkNB?=
 =?utf-8?B?QXZPQk9zcU0zMVJ6OUVpMDlnR09sV3Z4UGZHaTFLbXhNcThLZVRHUlBSbWpW?=
 =?utf-8?B?bGs2djg0cDR3dnh0a1lxWVpnMWFHYUZqelZQeWQwQ3o3OWVZOVZ5OUZmTHFD?=
 =?utf-8?B?S09vQnZTbkt0akZjUXYxbGpkOGVNbkoydkZpUnJENkszZ2tncnJHWXdLN1ZO?=
 =?utf-8?B?Z1BuR29hMUxPRGtHazg1YUtYdkNuQ1dqOUZTczQrTmhqVWw0RVFpS0gweXIx?=
 =?utf-8?B?KzU1SzhxN1E2ZmVrRmFrbklOV0xYc3NGN0ZMK01jUkFzQ05CSnBHWnJvRmxM?=
 =?utf-8?B?N0k3U1VGSnd6ZjUxQzI3ZXprVmttZ2pibUtNWm94SEEyM0lJa3M1NVFCZGxt?=
 =?utf-8?B?dFhXT0VyVytSR241eHFQcC90OVpmOVZYWnV0TjJlb0w5SUdGRTMzS1pxenVt?=
 =?utf-8?B?WTVNc1Q1b2FuZ01XSGgwcm1UNHZNbXFPd08xOHJZc3ZGWndhY3ViK2M5MUdR?=
 =?utf-8?B?anNRSWJRY1NseFNDT29pV0p4QjZpZEdpMzlTVHFFRVgzVEpVUFc2UWhPMFV5?=
 =?utf-8?B?WE1kNnBlc3hBa2YyUDlmcTUxb0h2UmVsNmkyRjdEY3ZaYTQ4VFhDcFpqMkRa?=
 =?utf-8?B?UjBYTXIvS1R1KzJpNEV1L1FrcnRlS2hTS1NKNlhQaEwxeUx0MTNxa2dZa0sz?=
 =?utf-8?B?dzM4VzVKVi9hSFhOQStSNXlFTXN6Y0o3bDJqc0l1bFVGdGJLdFZRbkxtZ0hp?=
 =?utf-8?B?bjZRSjFFYXN5aEZqRkIzWUZ6K2pid3FQOUdEd2ZCa3lyY2pacGxVQUV6UHRJ?=
 =?utf-8?B?VjVsZWVjSVpDdDNSNXRhWk1NWmRNWWE5dXZyNDc2V281aEE5Tk1ibk9iT0U3?=
 =?utf-8?B?MkRVbnNlbk5Zb3lkSzA5LzdjSy83UGJHbmEzVFIvV1pSRjA1Yk41OUxtekda?=
 =?utf-8?B?U2U3SmpiVUVZZmZEMGJLSjlIa3VHd1FFL245VWlMTFp4a25yd2FUVS91ZGZ2?=
 =?utf-8?B?Q05wWkIxWUxwN05WR1R2bjYrZzJ5aHIwMklOQzZBWHE5RkJIS2tLM0lIUUdY?=
 =?utf-8?B?UGFXaGdVMEJlUzQwb1lFalRlMi9KSGxOc2lNM1ZtK2gwb1NvdjY3OTB0elNq?=
 =?utf-8?B?UWVybkZXck91YzhlV0U1QlVQUmJvUkpVUjk5cUQzOUJIeXhXU0pQU0x2d0M4?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e5e9c8-bbd9-440e-9c81-08dced4e3f77
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:19:10.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gykuiEO+dC+2wI5Ns8sWVxEFEC5ZLsWOj36HSyIRDe3qFbxrRkl/yqHjOIBBmkbJi5kMcjW001/z4zs3AlKQF2h9zsKd/0HjrRXYaBKbQB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
X-OriginatorOrg: intel.com

On 10/11/2024 11:48 AM, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This is new API which caters to the following requirements:
> 
> - Pack or unpack a large number of fields to/from a buffer with a small
>   code footprint. The current alternative is to open-code a large number
>   of calls to pack() and unpack(), or to use packing() to reduce that
>   number to half. But packing() is not const-correct.
> 
> - Use unpacked numbers stored in variables smaller than u64. This
>   reduces the rodata footprint of the stored field arrays.
> 
> - Perform error checking at compile time, rather than at runtime, and
>   return void from the API functions. To that end, we introduce
>   CHECK_PACKED_FIELD_*() macros to be used on the arrays of packed
>   fields. Note: the C preprocessor can't generate variable-length code
>   (loops),  as would be required for array-style definitions of struct
>   packed_field arrays. So the sanity checks use code generation at
>   compile time to $KBUILD_OUTPUT/include/generated/packing-checks.h.
>   There are explicit macros for sanity-checking arrays of 1 packed
>   field, 2 packed fields, 3 packed fields, ..., all the way to 50 packed
>   fields. In practice, the sja1105 driver will actually need the variant
>   with 40 fields. This isn't as bad as it seems: feeding a 39 entry
>   sized array into the CHECK_PACKED_FIELDS_40() macro will actually
>   generate a compilation error, so mistakes are very likely to be caught
>   by the developer and thus are not a problem.
> 
> - Reduced rodata footprint for the storage of the packed field arrays.
>   To that end, we have struct packed_field_s (small) and packed_field_m
>   (medium). More can be added as needed (unlikely for now). On these
>   types, the same generic pack_fields() and unpack_fields() API can be
>   used, thanks to the new C11 _Generic() selection feature, which can
>   call pack_fields_s() or pack_fields_m(), depending on the type of the
>   "fields" array - a simplistic form of polymorphism. It is evaluated at
>   compile time which function will actually be called.
> 
> Over time, packing() is expected to be completely replaced either with
> pack() or with pack_fields().
> 
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  include/linux/packing.h  |  69 ++++++++++++++++++++++
>  lib/gen_packing_checks.c |  31 ++++++++++
>  lib/packing.c            | 149 ++++++++++++++++++++++++++++++++++++++++++++++-
>  Kbuild                   |  13 ++++-
>  4 files changed, 259 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/packing.h b/include/linux/packing.h
> index 5d36dcd06f60..eeb23d90e5e0 100644
> --- a/include/linux/packing.h
> +++ b/include/linux/packing.h
> @@ -26,4 +26,73 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
>  int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
>  	   size_t pbuflen, u8 quirks);
>  
> +#define GEN_PACKED_FIELD_MEMBERS(__type) \
> +	__type startbit; \
> +	__type endbit; \
> +	__type offset; \
> +	__type size;
> +
> +/* Small packed field. Use with bit offsets < 256, buffers < 32B and
> + * unpacked structures < 256B.
> + */
> +struct packed_field_s {
> +	GEN_PACKED_FIELD_MEMBERS(u8);
> +};
> +
> +/* Medium packed field. Use with bit offsets < 65536, buffers < 8KB and
> + * unpacked structures < 64KB.
> + */
> +struct packed_field_m {
> +	GEN_PACKED_FIELD_MEMBERS(u16);
> +};
> +
> +#define PACKED_FIELD(start, end, struct_name, struct_field) \
> +	{ \
> +		(start), \
> +		(end), \
> +		offsetof(struct_name, struct_field), \
> +		sizeof_field(struct_name, struct_field), \
> +	}
> +
> +#define CHECK_PACKED_FIELD(field, pbuflen) \
> +	({ typeof(field) __f = (field); typeof(pbuflen) __len = (pbuflen); \
> +	BUILD_BUG_ON(__f.startbit < __f.endbit); \
> +	BUILD_BUG_ON(__f.startbit >= BITS_PER_BYTE * __len); \
> +	BUILD_BUG_ON(__f.startbit - __f.endbit >= BITS_PER_BYTE * __f.size); \
> +	BUILD_BUG_ON(__f.size != 1 && __f.size != 2 && __f.size != 4 && __f.size != 8); })
> +
> +#define CHECK_PACKED_FIELD_OVERLAP(field1, field2) \
> +	({ typeof(field1) _f1 = (field1); typeof(field2) _f2 = (field2); \
> +	BUILD_BUG_ON(max(_f1.endbit, _f2.endbit) <=  min(_f1.startbit, _f2.startbit)); })
> +
> +#include <generated/packing-checks.h>
> +
> +void pack_fields_s(void *pbuf, size_t pbuflen, const void *ustruct,
> +		   const struct packed_field_s *fields, size_t num_fields,
> +		   u8 quirks);
> +
> +void pack_fields_m(void *pbuf, size_t pbuflen, const void *ustruct,
> +		   const struct packed_field_m *fields, size_t num_fields,
> +		   u8 quirks);
> +
> +void unpack_fields_s(const void *pbuf, size_t pbuflen, void *ustruct,
> +		     const struct packed_field_s *fields, size_t num_fields,
> +		     u8 quirks);
> +
> +void unpack_fields_m(const void *pbuf, size_t pbuflen, void *ustruct,
> +		      const struct packed_field_m *fields, size_t num_fields,
> +		      u8 quirks);
> +
> +#define pack_fields(pbuf, pbuflen, ustruct, fields, quirks) \
> +	_Generic((fields), \
> +		 const struct packed_field_s * : pack_fields_s, \
> +		 const struct packed_field_m * : pack_fields_m \
> +		)(pbuf, pbuflen, ustruct, fields, ARRAY_SIZE(fields), quirks)
> +
> +#define unpack_fields(pbuf, pbuflen, ustruct, fields, quirks) \
> +	_Generic((fields), \
> +		 const struct packed_field_s * : unpack_fields_s, \
> +		 const struct packed_field_m * : unpack_fields_m \
> +		)(pbuf, pbuflen, ustruct, fields, ARRAY_SIZE(fields), quirks)
> +
>  #endif
> diff --git a/lib/gen_packing_checks.c b/lib/gen_packing_checks.c
> new file mode 100644
> index 000000000000..3213c858c2fe
> --- /dev/null
> +++ b/lib/gen_packing_checks.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +
> +int main(int argc, char **argv)
> +{
> +	printf("/* Automatically generated - do not edit */\n\n");
> +	printf("#ifndef GENERATED_PACKING_CHECKS_H\n");
> +	printf("#define GENERATED_PACKING_CHECKS_H\n\n");
> +
> +	for (int i = 1; i <= 50; i++) {
> +		printf("#define CHECK_PACKED_FIELDS_%d(fields, pbuflen) \\\n", i);
> +		printf("\t({ typeof(&(fields)[0]) _f = (fields); typeof(pbuflen) _len = (pbuflen); \\\n");
> +		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
> +		for (int j = 0; j < i; j++) {
> +			int final = (i == 1);
> +
> +			printf("\tCHECK_PACKED_FIELD(_f[%d], _len);%s\n",
> +			       j, final ? " })\n" : " \\");
> +		}
> +		for (int j = 1; j < i; j++) {
> +			for (int k = 0; k < j; k++) {
> +				int final = (j == i - 1) && (k == j - 1);
> +
> +				printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[%d], _f[%d]);%s\n",
> +				       k, j, final ? " })\n" : " \\");
> +			}
> +		}
> +	}
> +
> +	printf("#endif /* GENERATED_PACKING_CHECKS_H */\n");
> +}

Hi Masahiro,

The changes in this patch contains some code and Kbuild changes to
generate compile-time macro checks at build time (instead of committing
20 thousand lines of code directly to git). I'd appreciate if you could
review this change, specifically the auto-generation of packing-checks.h

The full series can be viewed on lore at:

> https://lore.kernel.org/netdev/20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com/

> diff --git a/Kbuild b/Kbuild
> index 464b34a08f51..35a8b78b72d9 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -34,6 +34,17 @@ arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)
>  $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
>  	$(call filechk,offsets,__ASM_OFFSETS_H__)
>  
> +# Generate packing-checks.h
> +
> +hostprogs += lib/gen_packing_checks
> +
> +packing-checks := include/generated/packing-checks.h
> +
> +filechk_gen_packing_checks = lib/gen_packing_checks
> +
> +$(packing-checks): lib/gen_packing_checks FORCE
> +	$(call filechk,gen_packing_checks)
> +
>  # Check for missing system calls
>  
>  quiet_cmd_syscalls = CALL    $<
> @@ -70,7 +81,7 @@ $(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
>  # A phony target that depends on all the preparation targets
>  
>  PHONY += prepare
> -prepare: $(offsets-file) missing-syscalls $(atomic-checks)
> +prepare: $(offsets-file) missing-syscalls $(atomic-checks) $(packing-checks)
>  	@:
>  
>  # Ordinary directory descending
> 

In particular, I tried a variety of places to put the build-time
generation logic, and ended up having to stick it in the top level
Kbuild file as part of the prepare target. I was unable to figure out
another way to get the include dependency correct.

packing-checks.h contains the set of macros generated for checking
various sizes of the packing array, which we want to have at compile
time, so we need to generate packing-checks.h before any code which
includes <linux/packing.h> which is what ultimately includes
<generated/packing-checks.h>

Vladimir and I tried to come up with other methods of doing the compile
time checking and validation of the structures. But the limited C
pre-processor prevents us from doing loops, which is what led to the
large number of generated macros.

Thanks,
Jake

