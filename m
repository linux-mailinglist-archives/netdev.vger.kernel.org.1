Return-Path: <netdev+bounces-146213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA219D24A5
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCB9284335
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC31C4A0F;
	Tue, 19 Nov 2024 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jzo5Py16"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCDB1C175C
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014803; cv=fail; b=UwI2WrE35kUERdd1j1l5aHdNZk8oylFPF3MPYdK7sF6KGePQTzYJX4OKngFRo9NCaH+xxv2+D/70nmeV3LIhgHAnl9HkkR5x4CBK1Kwcas7B32WL3j4U0ez/RUA9oZk7633mo9bZH75bCSINL61Uo/EyqkXp4aindqwLp9ssAhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014803; c=relaxed/simple;
	bh=HasOA47zUVGq0CneywU1iFpsSlC9+b1RWECRM5JjfVI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WZjO6/XN+gVE9+sphJp5eH/+D/d2DBcEeX3xITW9pnXOpS+u4CwmZTdYXA8w4Dw3fm+X+fl/e5+7Kf5JWWd15cBQ/Ly/yadx3rK4b7ONMU7rfegMq+n7o6pq4TOVjsKL0aosjD8mJ57yVvknZq5iKk9/xIalfHgLY3PkO0Es3dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jzo5Py16; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732014802; x=1763550802;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HasOA47zUVGq0CneywU1iFpsSlC9+b1RWECRM5JjfVI=;
  b=Jzo5Py16Le4d8pN4/zLxBSM8zFdiN72NvlsxmbUoUx7a5XeEAWISk2Pt
   cYfgbp7rf3rYro0RnB+Lh0sgVgJKyxZ3kg+r6Fdkit3tQRTqr5tMTKm8h
   5PwOkB+XidicGpALstEYMtpgIUJuZUCi2C42aD+5qjtMs/GexQRaNbOYL
   k+9z2BC6aBvONymI7HqaGHVHyaVb+8IpVXUwWutMT9Lxt04POvXbGvDMA
   dWprtDTw+Pf+0naILqcOAwZLHHoiRGxBYN4e0/GnYa5BjXKm30Y38ZAN4
   xGLH79xojVn7iaR9ZTRV45qVHWggie68+S8yUBhVvwOKSOeEl/hyoZplz
   A==;
X-CSE-ConnectionGUID: zRc4AbvQQsaRx4uq6racaQ==
X-CSE-MsgGUID: JFV6XMmXSi6kQHZxk6EtQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="32155857"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="32155857"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 03:13:20 -0800
X-CSE-ConnectionGUID: xI1CfzZyQjGDUXMFmedUsg==
X-CSE-MsgGUID: hcEVVLohQz22S9MhsJjW8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89943705"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 03:13:19 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 03:13:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 03:13:19 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 03:13:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BofVj5koJYEkC2ZR+0cymAd2tIX/KcTaxHnZaCnBexQVMN6nnaE0FBT9Xx6j8hdxLAp3a3L6wZF8QLaZPRP+J8l5BlIvkeSH3I1M9dppV0LdawrT0DPzixKFwvCBaEBQV8oJ2ujhgvvFA1sRy+mqoCYBH0Y19vMF/baLG2XSm3vQDvRsc19eS3HxBK+rShLhTZKgZe98qNtjUsmcd63Fq4Zk5cFDXhxI6QaIIZVHgaidC92CD7J6ydXPW7VqS1zdURIgPStpvfaKj3q+wxfOjYTp5XOYYZjLvle1GN0FXlZRtmPLlFJNSh4OkI9hKbRggW2PqFR0jR+aS9+gKlN7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hfk0ID1BozOhKY0I6/oWw58Y4XnKtO2J5xsTHLiYBjQ=;
 b=gDvbKepZ23nR+ickviEXsG+JhQzL5t3SnI5MA8f8Z88NC9AcZyr4LJZaseEyw6FatKjH0HspjoWghnNE/u7OM7HQ1tX8Y9piB2TEMhSeID9s+/hxrHQCYjSDDid+pd4qwjg8HcI7N/ffrr8P+otNp09M9Ny+s09Pp4OXqxoRQa6vaWLjwN3S5sk5IbaxBfUjQKuYdVWx9eq/QjxTrXVwWY0qtCdtyasSw8gfZBlnYqMtw3rJaz/sRoB0u/gxI4rYC+IvjC1szoQCCpHfMBNtezoQC4z3SAUxDpW0HhsBwWYP3gSUfL43wrXvd5zCmJHuKtG2JECCC1ENj1A+0UoXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SA2PR11MB5099.namprd11.prod.outlook.com (2603:10b6:806:f9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 11:13:16 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%7]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 11:13:16 +0000
Date: Tue, 19 Nov 2024 12:13:04 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: <davem@davemloft.net>, <michael.chan@broadcom.com>, <edumazet@google.com>,
	<gospo@broadcom.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, Salam Noureddine
	<noureddine@arista.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net] tg3: Set coherent DMA mask bits to 31 for BCM57766
 chipsets
Message-ID: <ZzxywJTKIVm94ep7@localhost.localdomain>
References: <20241119055741.147144-1-pavan.chebbi@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119055741.147144-1-pavan.chebbi@broadcom.com>
X-ClientProxiedBy: DUZPR01CA0228.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::23) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SA2PR11MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce71bd8-382e-4f4c-83ea-08dd088b2a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LjsiEyUVxjOL4XYuOAqZN1ARWahKC6FrgT/tdXiSJ9HOcdvMLDr2cPaoqjpf?=
 =?us-ascii?Q?zJDdIMhS/ynZalyM3R5eFLwX4yhxL5t/CZv5Ck/r+vz3HQ+XS+05YQ5dwRX/?=
 =?us-ascii?Q?zSaFaG7jU6NMxDi7X+DW5Fh/ji46HPnR0qh1jU063/FfyBDPv2mK2WljfIrF?=
 =?us-ascii?Q?cJxq+5a3oxkiTVr59D62N5v17TCD551LyclmrR1QxmKRQK1w0AEtRWvX8g7d?=
 =?us-ascii?Q?OcLeeOhUqJqXnTHDCQ341QYWbBaxebKsQYNde4LaYbBW634mn45zek5m8WQ5?=
 =?us-ascii?Q?hCS37hj2RFUIGu/Z87yrp1863G+OFgxIBPE/Yn1bqbiwABj9v1xxUhxH8yDH?=
 =?us-ascii?Q?FPgfTaXVLJo3Wf5/vwwnGZ6HaceeIXcjaUznrSzPRSk6izlfmLsJANGKibl9?=
 =?us-ascii?Q?OVTQwowImpbHA2onjKmvpgLgXdLZCG8syAxXJdV82AW7O/+T1Cqstm/SNzTf?=
 =?us-ascii?Q?vQdO5sgW3c3lLLBzavWoGxCxXv0ww1hZIzltydmLxLlbLLCcCVIg5+ouQlwK?=
 =?us-ascii?Q?mIYTUOq9/EXmNz/M0Uu/iEpM5mIrQwq1SewfTZegYE3pSX68IbiaQHkRR3Ka?=
 =?us-ascii?Q?msBLhotVH8cKHbe9CPWUXTxhTJTc9XoW/kGrzBMrEXpGTcGpSuZdKGuAh69p?=
 =?us-ascii?Q?hsrmJLDOy8e9UE8Qz78kwfEm+JCsbdcRmwRbcCdbxBeQZXh06Kq8nzE6RmHz?=
 =?us-ascii?Q?cqRvhvgZ7wOG27SYqB4T5th0oBmoAp5KZKnOoI0luKN/6bBh/UHPNPYk8LDh?=
 =?us-ascii?Q?haFW0l+ywtHUQc6K46iwyoyGTv8ddMly6+nmPOiFzw8am09PWHn2nL6VJtUS?=
 =?us-ascii?Q?bM0nkqzEulOBn76NeNcIKcxMEqFvUTpkVUs5/3m07QSzMUgh5SEN6jgupDvD?=
 =?us-ascii?Q?C/29h4fuRy4+RjxuZLFGlDu34yMnMtB/8nEHHTVWl5eOO3lhryfilp899eau?=
 =?us-ascii?Q?P+TJdSjsE/1QM9o65mbWdPEZ2Di2iCPgWfVgU6OWGATnljoaAYq9lj3lgtLk?=
 =?us-ascii?Q?RDb7TgPZM069aemAauzmwZLi1drysEulHmZrX5ag+BVAOfzqkhfItE7Ti3cM?=
 =?us-ascii?Q?DCJjbKYAkiuOwZw1Zw3Ek55/NnQzTNqLVNfYydKSegNLdiiNY5C+o089ZUtH?=
 =?us-ascii?Q?HGfks6Zunc4YlpkLjgU2ytSktVFJhiYWasjm2v5Tfvx1hO86lPWS9cYbMDdg?=
 =?us-ascii?Q?rMzaJSi8PKEReqzM8hBl5622/mIySuhT5ihZwKEPa+mXI3M4Gva6ROYQ1mSe?=
 =?us-ascii?Q?qhT4e3Tp7SZQ9YR5YF1BX1bMORLAnB7W/tSw3bdN2mOK0jPWvBY4RwDa0+yt?=
 =?us-ascii?Q?fFA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NBfll/kBI3kb7dbAcF3jCTXvMECWN0eWgAQtKRUYHNP3nHbIK1tVoB+7BYHh?=
 =?us-ascii?Q?vvGxNhayKchRTHXeSbUOuOzK5y6YLt5uwdbDZmsplNV9DkA2tMlcyyiHdgER?=
 =?us-ascii?Q?WcOE94xqtXnq6Ao57vv296uZSdnDb9UsidTQbJkDDBqUlxY/JsdHYFHYr/mV?=
 =?us-ascii?Q?DpiW3/dLErPj70Ad6hPGIQ3CfZEu+nJ1pJVGyaM6O3fUlnDfd+1j5ynUrhdd?=
 =?us-ascii?Q?Ne8x5lUyI8PG45wzwNgUlMsY9rz/GJomczX0dfYK5M924e3boc9k8bJGA2Vm?=
 =?us-ascii?Q?CjA7sxbUk7aQsBt7jp6VKB45AdQKZKi8i2FB6LafRyETkIOHSW/aNYJva1Lx?=
 =?us-ascii?Q?vHJHMLkIytnxt2ZnaCpwmkrklPq6Tacb98MRQL3cP6GFcvAQG4dumyRyza39?=
 =?us-ascii?Q?HEc9WOFFyKvM9zpfLTSQKdLTJZQR8WulO7Z5fUbOJH5Yw5ZeHEoz4GcI3WxV?=
 =?us-ascii?Q?kLdm0o+hfC/HczhEa0DJ6QFT5NcajgevYzYH6IdpBhScEuAwxuXBhvJawxGw?=
 =?us-ascii?Q?ZtxTQWiR/AZmR5MCnLbNMQ8/Yctsqt071xavMvkTed0Pd51XXz3E4AslGpz+?=
 =?us-ascii?Q?Bw1IYElz3SKNweG4PmSnA1jBeH6rZ0cszUq2UET0NbE8ZH/CjHXBARPHfn0v?=
 =?us-ascii?Q?hOhBBz5hm8fyr4SL9p1ET5ptI0MN/QKUdds3kBrfdauaErJmwygPdbQ16/Iz?=
 =?us-ascii?Q?E261hpoygCw2mdbmcHMqJ+slAstA63F8RJ5OSepwhu1PwhgtRvuRed/sh/p/?=
 =?us-ascii?Q?eIfNer172UtufKay5x84AhixYTKM2qDtlvPo41WO8Vtyr+G9isMcjLuGdcdf?=
 =?us-ascii?Q?sggPT0CAtbgElUswkRY3If3izYd77O74LiKN0lI5OtH1zGlJSJDRVdkarFjn?=
 =?us-ascii?Q?jTkCqPiyBdrwqyYxAS/s+JZBY1F3N23JPifhmMiGWjOY4lCztAvAYAkXHklh?=
 =?us-ascii?Q?Wf5RWg+1DgXw1GaNaFMCC7d0ExX0j4p5QOm/XTXiGrEId76GBEp0kpG5oMbY?=
 =?us-ascii?Q?tAemIjcSZ4khK+h24FGPMll6zckO24b7M647SdYuqn0s2wCcoqwjsfnooq5F?=
 =?us-ascii?Q?Fxv6TaG2plovRxisQOOr+LBuGVmRtcF2cu889+bcmp09UDndIaOqIdQcIQoV?=
 =?us-ascii?Q?vxTCp/QntMp5RA0xfDywuQmtJ8ngNfww3B5UhPYpZzadExFkObP806aVrYBo?=
 =?us-ascii?Q?wOoX587mmn8Sj53QhAocE4dP81sWEXSEuciBBnV9tS32xw1GAsJ7l/6JYPo5?=
 =?us-ascii?Q?iM3KwMCFsYCpRsUX4aFk2IAXxLkEX7PAoVAoKBflLFLp5rBBYkTvOEOvp5gT?=
 =?us-ascii?Q?AQwQzuHXslO6bJKbdArmYulh+7i1iptT9EGclAQ/QH38i4Thx4QiKnnDHZgH?=
 =?us-ascii?Q?nifOBo9SAVXlNGYtzqxQ78iJKJMP9RjcQTCuxKMJTJVCOWu5+e5nbH9qDAmm?=
 =?us-ascii?Q?xcmksCfBc85bdDR/8XotyA8Fyk74cp7dZX3ny34zJiryGmWujfd/PT+b+ihM?=
 =?us-ascii?Q?LKstDjUeEaaac1+5mOGS6VxHPg1XgtNh8njXslJu/gx5d5RPvIvQbTjdp2ho?=
 =?us-ascii?Q?+IvcFCz1wXKTgJwVI/EtVqRENg7/a2mz61k6ldBkLmeyX6YnULSGpvQbsCzV?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce71bd8-382e-4f4c-83ea-08dd088b2a6f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 11:13:16.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgowcJlmKtcwHCtdI5oI7v+LkV9FaOyW3I/zGkidziNvtO/OgyjqkkpB/n+iccCdnjb1V8gWAzzDRuDUX2MJPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5099
X-OriginatorOrg: intel.com

On Mon, Nov 18, 2024 at 09:57:41PM -0800, Pavan Chebbi wrote:
> The hardware on Broadcom 1G chipsets have a known limitation
> where they cannot handle DMA addresses that cross over 4GB.
> When such an address is encountered, the hardware sets the
> address overflow error bit in the DMA status register and
> triggers a reset.
> 
> However, BCM57766 hardware is setting the overflow bit and
> triggering a reset in some cases when there is no actual
> underlying address overflow. The hardware team analyzed the
> issue and concluded that it is happening when the status
> block update has an address with higher (b16 to b31) bits
> as 0xffff following a previous update that had lowest bits
> as 0xffff.
> 
> To work around this bug in the BCM57766 hardware, set the
> coherent dma mask from the current 64b to 31b. This will
> ensure that upper bits of the status block DMA address are
> always at most 0x7fff, thus avoiding the improper overflow
> check described above. This work around is intended for only
> status block and ring memories and has no effect on TX and
> RX buffers as they do not require coherent memory.
> 
> Fixes: 72f2afb8a685 ("[TG3]: Add DMA address workaround")
> Reported-by: Salam Noureddine <noureddine@arista.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 378815917741..d178138981a9 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17801,6 +17801,9 @@ static int tg3_init_one(struct pci_dev *pdev,
>  	} else
>  		persist_dma_mask = dma_mask = DMA_BIT_MASK(64);
>  
> +	if (tg3_asic_rev(tp) == ASIC_REV_57766)
> +		persist_dma_mask = DMA_BIT_MASK(31);
> +
>  	/* Configure DMA attributes. */
>  	if (dma_mask > DMA_BIT_MASK(32)) {
>  		err = dma_set_mask(&pdev->dev, dma_mask);
> -- 
> 2.39.1
> 
> 

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

