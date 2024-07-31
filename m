Return-Path: <netdev+bounces-114604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4064B9430FA
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9A1281E68
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A201B3F0E;
	Wed, 31 Jul 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSvfpTfS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A31B3F09
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432827; cv=fail; b=HAfZdBh2wTkBkgA8Xq4J1n5eyEGxj75/nf2EovbpJpmKRC+H3N3YsSF0P0r17WP1zErvkOzGJ0it/qeX+U0s5kmpJD4YiiZivj/R29z7wvEH6jrYDDO5mXJZOhuD8rQkdhptgNQgTIrob4b9dxDceRbhaU6FdXKPgiJJUMzlDXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432827; c=relaxed/simple;
	bh=xqt7ZGI99cianSADFObBl5fX0iVLkjFG6TINOhQSMe4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vDOEX6Ntv6O/VTJMxHSL0nAf+pvj2fQccmG5BhGA6M9yJWYC/KpWWYWMWt89Atcg8vgUY7BdyvQh/0EfQSkIZlN9bPawibyu+CGmGtSc8HoyqK+iFGI6awMHbPL9vYKJr80fQg123vstd6HbMnLI6yKe/HQJL14N7wMJ7YlOMs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSvfpTfS; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722432826; x=1753968826;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xqt7ZGI99cianSADFObBl5fX0iVLkjFG6TINOhQSMe4=;
  b=cSvfpTfSyPooNMSQoL1mAqUNM1yhwUTqxgs+7HYXoXgeYhlDQn56MM3I
   b5id5o5w750tcSt8cOkVe5t/zEBz6rFzlcbR34LqeCPYrnt2CDOMFBBZj
   nE1prJC/cVKG5niy/YUyNzzj4z68AMbAKhr/oyyKzif5lESc3Y/sxoLrn
   U3QpCFnc3pQHq2Gm+qd8NqUacu0T9HpdGZBiJo5YBvMjoIcHdYSBwTrdY
   +BhOLiPXBp43Ea3FB7ghC24QJl9tRcf6Vok9bDGRl9uhyA1b4Te7JcaEn
   7s1WX5BfvoTo20reKXWOJcOaGuRsVfHxB7rNhYJWShrDAibZER7b4S2II
   A==;
X-CSE-ConnectionGUID: UVRdr5VvT867SRguVJU1OQ==
X-CSE-MsgGUID: avnUI0ouSgua7TRgnBFwIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20494651"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20494651"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 06:33:42 -0700
X-CSE-ConnectionGUID: HkLh+1v3SR6cmEC/xWLafw==
X-CSE-MsgGUID: P4T0DPc+REmm+aBB78KDQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="85617806"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 06:33:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 06:33:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 06:33:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 06:33:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 06:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bq5qJxnpVTqZsFErlQJxqRNdcPVvc0eFft/9wCUllJeWten7bOWoVEodXmhJKRin6y1VTiYL5p+KGPEdCA5DYDh+HsEdesQ5bXCvF6abWFAV1vpuotWolJvzgky/P+tOVLfphED92iJtwSHUhgNlqTvgiWxNrnmFatZtLVnedsCQM7JjoWXlbp7TZ0HE9VwgLN1NqjS3QKB7KlNBSicAl1VAySWvhdt4147jcfWJ34/SbvAGf/PGAHrt5wq2Z0RTXD+5pEZ0iClO3CX16zbkesycX2ryca36XGW8lPcbsrfDJFPHFcnV7DFYuB3DSfYZr+CIXW2WciTpCDfB8J2Ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPc9vS/J68DtlCc5CiCCAVOvL+slPlqvsFmc1+plATk=;
 b=W60KsQfXsRZYz3omaLv7jJJmdJ/TEnQn/QuLbYmrRYyTVHo285xHGNFl2OxrpVNkfz4GB1blgSilBa0t5pQ4R703vh/Ol+G/FF+0jYG6vW1zCTaKMRXUHEXubQBYdfNKegoH1xcnVGwVW3Tfh8r52TyNpa6h9O/ah9wD5Vtt7mEr37sXQXunaUK/Vx+7Kn3oOplViQj1WHkKwtvEn+uTWbAc82DDQ82HAmRP1gjUaoZZVCoc9nChlcNoi+tAo3FyVIwiQegdx2N5uj0F2qcfd3Tm8TbVxXbkg1zQ99cJyzho+ZQVubElyOiIOaxBef1ubJuuU8Md8xFIL3bFtwlFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA0PR11MB4638.namprd11.prod.outlook.com (2603:10b6:806:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 13:33:37 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:33:37 +0000
Message-ID: <f2dcfb5d-19b5-4c00-89ad-2d63992d8f50@intel.com>
Date: Wed, 31 Jul 2024 15:33:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] fix bnxt_en queue reset when queue is
 active
To: David Wei <dw@davidwei.uk>, <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael
 Chan" <michael.chan@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>
References: <20240731131542.3359733-1-dw@davidwei.uk>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240731131542.3359733-1-dw@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::14) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA0PR11MB4638:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a08888-c1f7-4fa6-59c5-08dcb16561a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ui91S2FuMzQrcHcrSkNKZlEzZ3B0dlNIMUl0dWxtaDExcnZRc2QvL1pJVkxX?=
 =?utf-8?B?Z0pJdmE3b2xNM2VrUjdJKzBtUlhiNTB5U09hMm1CRjV3Zml6V3M4RExtZG9y?=
 =?utf-8?B?YXE1TFFDRTNQNTBROCtIVFcyM0ZrSGgvcXA1TlF4bGVZT3RxUmhPWks0dEhK?=
 =?utf-8?B?dGg3RzF5cUV6WDRLd3lWWTZKZmVxYStKU0RvY1RzZVlndlNUcld2UnlwTzhO?=
 =?utf-8?B?eXZMZjVvdFZaZ0pYSkVXMytrclNndVpESXJDQzlGQkxsQVlkMjVudTlaemJi?=
 =?utf-8?B?ODBlZHpJdGhGTlVQYWtEQzEwSnpwTldxZHU3UGQ1N3ZHS1o5dVhqdDMwb1lh?=
 =?utf-8?B?Z2hmRFljWFlFOEl0RmVoYS9DaVo3STYyRWZNRVNCcm8wT1BQLzJWdS9kMUpv?=
 =?utf-8?B?UHVMbS9xRG5uNTVtcmNQTDJ1ZkRscHF5VFlidGlJeGJ2d3RJV0pUMFdHM1Bu?=
 =?utf-8?B?QzdjbGptMStkelR1T0wxV1RsTHNUWlZXQWpqQUl1ME5zSFpSdE81RXJsY0hW?=
 =?utf-8?B?UHMwcUhRZ2J2eGoxM2gzVVd6dkpyV3c5WUhiejNrVVF4akFlc3pJRWh4UkZq?=
 =?utf-8?B?WHN4RlJGUVRCakQ2TXZFb3VtR21oRWpiMmh5MUpXNzcxOE5HUTdHc3FwVlhn?=
 =?utf-8?B?OHBscUVlYzdna3NwM01tMWFwQ0NlU2N5aUJ5SzNuM1dWMnR2Qld3QkxZa3dZ?=
 =?utf-8?B?WlZOcVFmenhEVWNEYnZrcWNMNkF3S2c2M0pHQkRUQ2ZLUVNDQXlxZ3hhRC9S?=
 =?utf-8?B?OGxhUjFyTXlrMzNtVVA2VkJQbHBVTVhjMjF1d2ZhS3VIZXMzeWYxb1JSMzFK?=
 =?utf-8?B?SFhsOW82TTQ0ME5yeXZIUlJ2U1pYL3IvQnFONi9jakxEeTArWnBsQ09ZVTZD?=
 =?utf-8?B?ZjhqZWFXRm84d0E0TENoRzJCY0dRMmgxcXdhODNKR1g3bzlPZUF6bFFDT0FU?=
 =?utf-8?B?QjVBaTExdkNPMXJtNERTRTRTUVRVKzhHdHFkVGsxS3Fya3BuVlRxTTRrY3hN?=
 =?utf-8?B?am9MQXEySUpNT0xjYmhlZisxNDc4VnRURlFTOTlqdmJDbGFGMUZGbUtja3hW?=
 =?utf-8?B?VEwxdjRNbE1iUk5yVUVBSkVmQzQxTVcvVHR0UEphaUNiUTEzYnlpb0p0Q2h2?=
 =?utf-8?B?QzBhdkc0NXhIWGUrbXVsdC9Nd0x2WlkrS3lPWWovUGxZQlJCVjhDbE9aWWJl?=
 =?utf-8?B?M1dwazJjZlVrU1Q3TnJiRjhqc1lSK1c0QWVPeW11S2NnVVNuYWZ4QU9jSWNj?=
 =?utf-8?B?NHBhVnh1TnMzRTA0VkVpNmtYc3NiZkt0SytGL0R4allmRXdRbDNJYlMydThz?=
 =?utf-8?B?T2FWVWgzMjJDTmIwUEFBK2w2Wmh5em04elFiR0MxejBIcTZhQmZHNWl4WkhB?=
 =?utf-8?B?cWxLN0xIMHl3REs3dm1EQWEwcEpDUzJCcHlIRDVKMngwdmR4OUJpQnNBYUY4?=
 =?utf-8?B?RmVJNmdGNm9aZEh6bnpxeldXcC8vdzBMTURIMDcvK3VYbG1ISzIxYkpJVHRG?=
 =?utf-8?B?VlpsN0hxMWZic05waHlNcDFvQjB5c3k4NDR4QitQdVE1MEtOakhlSkVVZVE4?=
 =?utf-8?B?UHhTSDBJRlFjMi9mak9lcWVqeGF1TE5IbUpISlZuckpoVmtGdnc0aDRVajRC?=
 =?utf-8?B?Y01KajJQZGltS253aEhjaGdDWjhxQWRxZUpjMkJwczB5cmtWRmxhYnhkbGt3?=
 =?utf-8?B?N2pWeGhqSFdpNy9KSnJPaStOMVUrTE5XazV1czRENXpiUENBRDRtVDJjTzl6?=
 =?utf-8?B?NXFWNU5vdmJXWlJWcStWUFlib3lsQXhIYXc3VS9jZGd5ZzY2VXF1ZFlwRWow?=
 =?utf-8?B?OFZ1V2tRU1hJcWFhQTh6UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0VoUlluRndvQndTa3RJemNMWWxYNEN5TGxJcmN5OCtteUlOOThwbitOOGNx?=
 =?utf-8?B?Q2ZrQTZWMTlhOWpSMXZTdTMxcytDaVU2ZWtkcXd3VXpEYS9nRHJkWTQ2WDlU?=
 =?utf-8?B?RnJkUDYzSFB0UFRrWE5RU3k2NHFzeHpNcUthTzkyQTd3QzNtQWQyYUZBSTJF?=
 =?utf-8?B?N2RkTHhIcHFseEFNTXRRMVdqL3VBWmtCR0xWN2ZVWURtSVVSODJrVklXeG9Q?=
 =?utf-8?B?aUJlQm16YTNpOUNMQXNoRHNCaTVDT2Y0amhuUGRiM1ZPMlp5cnZnbDhubUln?=
 =?utf-8?B?VmZwYSsvNE05NGR4dHZnVCtUaWwxYUo3aVVzaWRnRzdVcWw2bDJteTBXbUhN?=
 =?utf-8?B?ZEx0S2VmTXY4ZktCeVozY1piekZsS1F2LzFtc2ZoaGVselJyeVpaN05zd3ll?=
 =?utf-8?B?TTlsOEhnaTJGK0I1R3V4SHNBYlBYaDNUMFcwOXJja3puMkpta3QvdW91UTdy?=
 =?utf-8?B?ZkdlSURPdmZVbFdLU0VtbHdQSGh5aWRkQWJJSDh3eGdja2RLdUtGa3RPTUQ4?=
 =?utf-8?B?QTVhempsY3pDc1lxYzVyOVNnZlU4SjBJM1JyQXRscG5MaDVrUFBpYnVtZGJz?=
 =?utf-8?B?dnhGUm44dlpkb3F3SzFZTE5QYjNtTlExVDRubUl4Q0pXSDgrcHZZRkJQSWZz?=
 =?utf-8?B?NmQ2SmdzWkI5bWt6d3EvT1JIbUI2OE1ZNUdDVHZNdGhJZDRNVit1a2RHY2M1?=
 =?utf-8?B?ZHhqSk0zQ1hzRTdyZFA1NHl5VkxLRFoweDhHT09EQ1NTQ3NCbGVBT3VuaXBm?=
 =?utf-8?B?V2hIcGhCRFVEcENzWHIrRitpSVRBTVlBRzM2ZER6aU0zTHoxZE9vUzhoYnBK?=
 =?utf-8?B?UXdKWDhZL3BHQlR0Z29IdXpGd1dKTTVBbTJXMWxzUHp6cEM0S0hzREo1STds?=
 =?utf-8?B?U09ZcThuUkhkak1BS0pHdm9nVm5zeHpiUjJ3VkxtSWNyM2FSUk9GYzBGMTNX?=
 =?utf-8?B?cTN2RFFWT1ozQzRwZGgweDFCV1RMaXMyaFUyQi9uSnJsaXl3L1J6d3NKU0V6?=
 =?utf-8?B?VkhKYXh2T25vb2F5dEhFamZBdDhCS0JDNmJ2Y1VjQVpnSWlma1pielJXcGg2?=
 =?utf-8?B?QktjKzlPUGZ2dG1IajIrYXRTTjlLand6N05LeWlUNVFNN2NBd3ArUzdkNW1r?=
 =?utf-8?B?VXZzUnhjR1htRkhDMXRMTXV6Z2NzT0FjQjlrZUVhV3FuU0laQXVzTHUzUHdT?=
 =?utf-8?B?eXhhcWdsUzh4WmQxR3FnSkhtWVUyWHhiNUxPYzZIUEZIN2FoaFJ3eWhlbFdp?=
 =?utf-8?B?WHJwU3ZzdTN1aS8zVDJpQjR5REl0aGZucUkrd3V3d2hNbjBtWHZ2aE9QNitD?=
 =?utf-8?B?c0tWcEw0aGhBNUNQdWZrZUVXRXprTHR1d3BRZS9xMERIeUg4cGNYRDIxT0dP?=
 =?utf-8?B?TXhxOHZ2UmdwNk1uV2FlMStwcWtnVEpUQ2pTMERNZWNJM2x6cU5lMWlFSDh2?=
 =?utf-8?B?RitsVFNNWFUvaGljM3N3N1d6Z2lYMHM0RnRGUFg0VVNwUE1xSWNjd2lVS2lu?=
 =?utf-8?B?bURZcHdvSGJUeTJ6dU5sNHhCS0pjNU05RC8wYm1KYS9VY2traFlMWWg1Y2p1?=
 =?utf-8?B?cFZUK3BLWXBSR2xFSEVDUXF3Q3BOYlJNQUtYL0pqTW16RHlwbVpVK1dSdDdF?=
 =?utf-8?B?czV2TG1ZVFNQUzR5L3RFUkZoVzJER0d3b3VjOWNvNFdNTW03Nk56cnVQWFhV?=
 =?utf-8?B?ZlFpaWp2UG9NTlJxMWg1OUFiZkhjYy9xT2FubVVxS1J2MER1VTR2cFBibXJs?=
 =?utf-8?B?WHJYQzhYd3duVkFXODBsemZWOWFjeUpHS0JaQnpWVlI4M2FnNXpnNzZ0Zy9Q?=
 =?utf-8?B?MVZFblpCbGE0NkZEQkFTa0MrR2tYZGhSdVhRL1FoYThiUnEzMUNXeDBaTlRi?=
 =?utf-8?B?U3FtN3pPOFR4T0FnTEJ6ZzVHbUo2Y3paUG8wc21HanZmSFNOVEhXNVlaYVht?=
 =?utf-8?B?Zjhvc1RtN0JnRzNxemcrTlhFdVFIMjlPSXJQLzE2MHdWY3gxUHBGTTZRcGVo?=
 =?utf-8?B?QktQRW1rdGdqajRWd2VqUThUUEhFWFpGTWRMazcwQTczMW4raDFMUTQ0UmR3?=
 =?utf-8?B?R1RBcnpNSEpPL202Wk1ybXJsNjh4M3MvRGFrYmpyYXh0SHRFaUxsVitZVFRw?=
 =?utf-8?B?Q2kyc0s2MW9jdmh3ZStDWitCdW5aSGtCcTI2U1FYeUhOa1R5bkJPNnRYc2tL?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a08888-c1f7-4fa6-59c5-08dcb16561a7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:33:37.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xN9Vv/ltmAI80zlD/q0liKc+b6Wlb2OxciI44fIODlqPEefUmf/TiWgbFQSg5CtGSd6ZyFkxK9TI9t4ZbuJBVcEFG9e2f50IhNLrXyXfbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4638
X-OriginatorOrg: intel.com



On 31.07.2024 15:15, David Wei wrote:
> The current bnxt_en queue API implementation is buggy when resetting a
> queue that has active traffic. The problem is that there is no FW
> involved to stop the flow of packets and relying on napi_disable() isn't
> enough.
> 
> To fix this, call bnxt_hwrm_vnic_update() with MRU set to 0 for both the
> default and the ntuple vnic to stop the flow of packets. This works for
> any Rx queue and not only those that have ntuple rules since every Rx
> queue is either in the default or the ntuple vnic.
> 
> The first patch is from Michael Chan and adds the prerequisite vnic
> functions and definitions.
> 
> Tested on BCM957504 while iperf3 is active:
> 
> 1. Reset a queue that has an ntuple rule steering flow into it
> 2. Reset all queues in order, one at a time
> 
> In both cases the flow is not interrupted.
> 
> Sending this to net-next as there is no in-tree kernel consumer of queue
> API just yet, and there is a patch that changes when the queue_mgmt_ops
> is registered.
> 
> ---
> v2:
>  - split setting vnic->mru into a separate patch (Wojciech)
>  - clarify why napi_enable()/disable() is removed

Thanks!
For the whole series:
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Remember to include my tag if next version will be needed :)

> 
> David Wei (3):
>   bnxt_en: set vnic->mru in bnxt_hwrm_vnic_cfg()
>   bnxt_en: stop packet flow during bnxt_queue_stop/start
>   bnxt_en: only set dev->queue_mgmt_ops if BNXT_SUPPORTS_NTUPLE_VNIC
> 
> Michael Chan (1):
>   bnxt_en: Add support to call FW to update a VNIC
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 50 ++++++++++++++++---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 37 ++++++++++++++
>  3 files changed, 83 insertions(+), 7 deletions(-)
> 

