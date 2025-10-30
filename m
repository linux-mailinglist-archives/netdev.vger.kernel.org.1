Return-Path: <netdev+bounces-234500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 099DEC220E9
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 20:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D9F1899DC6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 19:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2562D311C20;
	Thu, 30 Oct 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWLiV71D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E189B314B6C;
	Thu, 30 Oct 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853679; cv=fail; b=UvPypSvgKEa/L8THdOocCFw0tsb7Wi1ReYf1tjghziiE3yAFGhf08Ioh1i9vXp/3ozII15UEGmJjJKJ6ZoTwfkjw44L0f+EFERBEoYagRvW+Ci7j3ys1XoiJ4luJ78MCMwMlN1erAtCtllVcByYfrXzqEarrEFc6Om3gjr8Gk84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853679; c=relaxed/simple;
	bh=iQNd9H9BHTFD7hZbUY1idaCDljBl2MwpOuNUDCTOv/I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQX1WtHIcQjard33mcxC31dyi+0IXYWBY8wTxRKJdYKswZWP+tTWzvogBBpB9vEEdJfCucwyJY/mgrCRR1ymCTynV41EZrHq3Pds42qeKjjQ8ciAyVJwzJCGuTj51esf15tH/JnH946piCiL9/1V57vpiSnW6nfqqgdQIcK9YU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWLiV71D; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761853677; x=1793389677;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=iQNd9H9BHTFD7hZbUY1idaCDljBl2MwpOuNUDCTOv/I=;
  b=SWLiV71DEtu5xARqzcFmFemz33/HmkCV4dAtcwK4f5osQqWM8MLr7Lr3
   ahF74i9ftGjxNLzNCK/XbPNJvrk/Ic4nLVoDHYHlMpIrIZraK8DpUZ0nb
   RrCD44FT/lvom78xku4/o+8YhxiwSbNkhjndWQz9BmoG1XlSvLPniBql/
   OHmWnCvYrg3RSJBogc2asLqOI3Py47LJcb70Le/wH8YPICvoXimEUkqh/
   Uz2CkDTNqPdy+v1Q5vRiV4NkzL12eLl1lkFBH8nnmJTyku7nz3J0txYLb
   LSBDmbSpxVX0fqc5MK1Pjpt5hGhrR4U1VTRD5e/8wADmjf0S2AeFk6UVm
   A==;
X-CSE-ConnectionGUID: Wt7MpZMNSue9fkoPLljCSw==
X-CSE-MsgGUID: A7zJHByuSamHh/1umCvwjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81636821"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="asc'?scan'208";a="81636821"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:47:56 -0700
X-CSE-ConnectionGUID: MU57NHsFRdyT8Z1tAPPCZg==
X-CSE-MsgGUID: MInz7nN4TwWKInTVFGLZNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="asc'?scan'208";a="191196232"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:47:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 12:47:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 12:47:55 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 12:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx3FAtvLhNKI1fg4TMo2qUxrQ7Dh7K7TUqjShX+8L7MWPRpq0yqoJ8tZOOdZ18usRGYhbXXo/xlyBOMuUTplJOQ6dRerUaye8T3w2TRlp+AXZ6dzDoqMuqBmHzH/VX5+meG41KgRD49FjYP/iqyzhIE5pvAYadj53XTjmoN0QxkMAlGaRsrH+/XUBQc5SU14STUF8LzlDhvIp5iNEPwMWJbQSyqMsXd88V8pAJ7PnkTDjS057YfnB02DpXNwISU8C75MssaWza2r9wI36UERzXy1TFiC+iOEgoh3RnzTILVQxBIL1GpnkCxpLqMmztLgIYrZdQukqhwJ8IAWDmxYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvhHD5x3BTp4pPQQLHO5mI3z4AdrlZsRVOFxfVA82l4=;
 b=GENcig+VWHAd0+VQAJxPoiGm3KmEObs4kFT6JQewyrkKJWb7xqnPtvZ9ph62KduELtG6lcIhvFyZXuoWpr5+bwhX0Ccebb97muk5m/Luwho6pyxhkPAWEUxTTYe8CdvtxgWpzSKv5NDq7CzHjdOUKoULCe1UXPuJzYVcq3e6JXFN9gpfySYFxFc7LCeyJw0mEDlZW0r5MlwrtSPTQkwj5zNnVm89geT7/AqIic9c8Cawr3W1mgxiteei3ghd24e2x2VcmXUjCCtxJ7odJmLmsOJkOxbdd2tNi49ZY7Mn0r6lVhs73LJW7Abz1BWM/XFpvz/rutgybBslvrgRiwpLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8459.namprd11.prod.outlook.com (2603:10b6:408:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 30 Oct
 2025 19:47:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 19:47:53 +0000
Message-ID: <0d8d4b82-f663-4bf8-abb3-87296c01ed22@intel.com>
Date: Thu, 30 Oct 2025 12:47:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kdoc: fix duplicate section warning message
To: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
 <87frb0miti.fsf@trenco.lwn.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <87frb0miti.fsf@trenco.lwn.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------hPkJcH0V203FPDrGlkSEhbV3"
X-ClientProxiedBy: SJ0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c36c936-939c-41c9-11c9-08de17ed3659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3FVdUxQN2poMUlwd2VUSzE0QUJ4b0xBb3RGMTFDcHhsUXJHSCtTVWJ2TlVE?=
 =?utf-8?B?VWl2NHNDUnZWOThnQjgvRzZtUUxUUUpVNmtVUzJ0OWJqV1BMaFd6Mmk2YXNK?=
 =?utf-8?B?d0lJYURNSmszSU9nOXUwRytYOFlSMndNcFArQWs1SzBSRUhPRVpRT3hhUHB1?=
 =?utf-8?B?dVJrM0cyZU1lVzBmd2wvRjdxYTNsNEJzOUhnSEpOOFZYZXZRMzEvKzJ6TUJJ?=
 =?utf-8?B?RHRxOWZvVWV1NkUwR1YxZUpYM2p2eVZzUHpCdkY4Y0M2N24zK29XR2ZJSTJn?=
 =?utf-8?B?OFpIS1dwZk1MMi82NksxMXZlWDhSS3hkZHFseE5KTm1GTFR1ZG1ET3Z6aUFa?=
 =?utf-8?B?Z0toSXNCRzdJTXd1cmlZSnJoQXNna3ptU29rd2hCcHVzZnRTMkhwOEhTbDkz?=
 =?utf-8?B?TEtLWUEvbTc5RVRhb2V1NlMvQk1lTGhnNXd1NytYUGREZ3dNQ0ViN3BUOE5O?=
 =?utf-8?B?ei9WaklLaGF1a1EySTVvWlFRRlRoc0JITzhUNHFzT2N2elVaNERJbEVVU3FC?=
 =?utf-8?B?R2V0Yk0xaUxiNFRkTEllVE5NcE1mYk5ISy9GL2pMcXl0bDJqcHBTa1oxbUNv?=
 =?utf-8?B?WDlmVWttYkFhWUpTblBYL0t5WWcxMjdPNGgwWkNUdzJzVllPcGkzSjNPdzZm?=
 =?utf-8?B?NTZRdUthc2FvR2JnMDRvN1ZGYXlDd0MvMWZrVDNkMlNvM2YrNDIyR0hibEM3?=
 =?utf-8?B?eGtaQmE2RXN2aUZNSElPRjBqeFVIc3UwTXd2aUkyWU1FZXdpTU1WVzZHbDMv?=
 =?utf-8?B?TlBuRHRjUWc1YmZvTWJYK1Bsdzh2ckt5a1U5Rlg0NlRkcUg3NHUrTm1yUXBB?=
 =?utf-8?B?Y3U2bDYwb09VSHBuZG1vdXJIbjR6bnlZK3RxWHFTMDJtU2xtR256ZElaMDh0?=
 =?utf-8?B?QWlBYmJBUDdlRkhReWh0bFNlY0VTaGI3czg0K3djZTRhcFgyc1hRekJLWnNP?=
 =?utf-8?B?ZDZQZGxvN3NnenFvWkNmSFpJazZPWVVvQ3ZVWHlZMWRsWnRwVHlyRlIzK2R4?=
 =?utf-8?B?eWcxQVozejlDeVhDSkFadHowVDhOM25OUmFGWHJseEgwVVpqUkJ6NHhvREpK?=
 =?utf-8?B?bU5sUjU1aVpYTnpuejJxci9WKzMrMU1MOFNEMVNMWjlmRGRuKzBvaTN4TUdQ?=
 =?utf-8?B?TmV6bmtxbzU5dktNRmsvVGQ3dHlLSjQ3TmovRHgwNk1JWTZnNUF2WUEwam12?=
 =?utf-8?B?YWsxREJlU0p1MEhhNzlWdGxrWUlqbGs3b1JOek1jQmR0QkNYSi8rMk5HRFZC?=
 =?utf-8?B?ZFdOMENVWXJhUTdFMDVsUHVaeDVndVZuaUE2MlhwbHVUSXg1M3J2YklJVEZp?=
 =?utf-8?B?Nm9XWEhocUMyTTZsQjg1ei9CY2I5VnhTSStvT3g3aEdxV0VPSThtZ3pYdXhU?=
 =?utf-8?B?QnNEQ0xFVlJLRVkwNXZxNTB6bHdrcnUrRjlJbVlOUE9kN1U0Rm1QSUVQbmFS?=
 =?utf-8?B?K0RTcEJrOFhMNkFTclR0ekJVTFhLOWg3OFpEMFFXd1U3UnhQazJqMzZJd3Yx?=
 =?utf-8?B?SXp3V2tEdDdST2tQUEx5MXZMc2g3TGFZNnFNRlE1Nms4ZXg5WkdSQzJpd2h4?=
 =?utf-8?B?QllkYkF4REN2RC8vcTRZRllGN2oyY2ppbjBlQjRPSFhXcHBiNTJUOStvamdx?=
 =?utf-8?B?VW0yVG52SE5Ja3B5dUxlS0N6eDI5VkcvR3BqYzRKVjE2enROQWV0VzhycVVI?=
 =?utf-8?B?dWw2VUJMVzd2QVArWHRPQmtPZDJRMXptUC8xVWh5eW42ZWd2ZXJDdnduUytw?=
 =?utf-8?B?S3RnV0R4eGxaNjNQWkoxSXMxaVp4dHBCakN4Qkh4NkRTMjNzQUpnWUd3Q0V2?=
 =?utf-8?B?cTdKOGRldFZuZ0h4TVpEZDlmU05PQk01bUxoRE5mMzlSMDlTQmg1ZzhoMWNn?=
 =?utf-8?B?K00vM0t4ejhVT3NlU203dnFacGVnbzdqUHFZZmZXblpVZkdaUHBIRmx3cHAz?=
 =?utf-8?Q?cnuYlhxLcopLbwcasM4rtfyvXhoENLkw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXk4Nm9nV3AxRHZoN0F1aHp6dVQrUU83R2ZkaHRibmNpUEhtV0NBWmozYjRP?=
 =?utf-8?B?N2grNTIvVkRFcXdjOTAyTlZZSHJLcnRmNTZsdVE1SWtGOVRFYVlpejBqaklL?=
 =?utf-8?B?a3Q3WWp0UEpkQWptSUFqRkd3R3ZaeXZMMmZiVjZkaW5ua2cyL2IyaDRYNUQv?=
 =?utf-8?B?OWFSS2lHR0RLU2dkNG5SdFViRXZpYnNXZWdwcnVJeGhlM3M5YmZPaTdwMTJZ?=
 =?utf-8?B?QWsxRFFoSWtTYWN0V3UyNTFtMTg5eVlOcHVtWjJ5STRWdTYwREhwOGh0Y1Bn?=
 =?utf-8?B?UHJNMDR5WjB5bTJEcy8wQ1J2SXovMU1IbSthU1pZVUFXZTNCb3luelZVcXpX?=
 =?utf-8?B?RnZwbXVINXpqMnVmRUQyWUtnamdKb3N1NStHS0pFY1dPTXh5K3BaYTA5Ykdo?=
 =?utf-8?B?T3cxU3JvNS9keFp2aXhxUUtGeGFUMGYxS1kyNkdrcm5MMHJCamFoelQ1KzZr?=
 =?utf-8?B?SVFqYmw0SllPbXY2OE52cGw2SkhiKzgzS1dpR0FUcEhPN3lGRlE5aHJ6M2RQ?=
 =?utf-8?B?ZVRNVDkwNHk4VEdOZ3h0cVVSWlM5UTkwQkdERnJaNzJtZlRYQ2xqQnZVN2hL?=
 =?utf-8?B?MkhWRjZRcDFVQW93WUlKL096MUJUSW5CbzNKVGMzWDArVi9YVGtNcWFsUzJh?=
 =?utf-8?B?S3ZzM0tSQVFoNmJ1TnhsZ0pLQ1ZmaWRUM2syT21OZ2JZNEx3V3JTMmxpYXJO?=
 =?utf-8?B?SzlZSTJNZktCOVRIWjFlb0oweHF4ZGNsakJiVzcxd05yRzBiY2R2NDlaeXJO?=
 =?utf-8?B?bUtPaFM4THBBMzRPTFNIVGJBdVRFZTRGT2tZd29GTnBNWWlJNnN4U3F4NjEv?=
 =?utf-8?B?MmNPZXRpUDlERGcycWMxMEtwcG9rZmg1WktQSmRQQ3c4SDNmU3BLTW96TmJI?=
 =?utf-8?B?UWxWWDcvOFZjRTIzRWRyQmpwSGJjcE9oSEY2d25GRFQyNFFETkYvaitHZ0lL?=
 =?utf-8?B?SXZyVXdpYytIZm9UQ2x5c3dNL2M5c3o4L1pMZlFpNEpMM25HYzZBSTllL0VM?=
 =?utf-8?B?dzNIMXoxU3RDL0k3MjhXdG4vZE83Q1dGTjYyMFFTNVZFTWVNOGJpSm9oRk43?=
 =?utf-8?B?a3JmMXVvaE8wVnBKNFdjMk9GMVhjN01uMEFOamtXKzh5ZlpFaDlnNkVTQmVt?=
 =?utf-8?B?YVNUNkI1ZmtSanU5YVppL3R2MlFITnIzMHBsTVBtczZLejZucitlTytGMGd2?=
 =?utf-8?B?MTFhbVFQTUVDc2lIRkxFcWY3c1VQWEdXQXJJMzJld3pIQnJ0Q3lOakVOcEt1?=
 =?utf-8?B?cjdOR1pTYVZxUFFhUVVrUGYrZFJrU1ZjYlRWU2M0NG94QThPTHVxZE1DOFRY?=
 =?utf-8?B?TzhPRE5DWExtS0tvUkhvR1p4bkNPR1BZMHV2UzBYN1poRXNkOTZmcnFEUm1D?=
 =?utf-8?B?SzhzTGFvbTJlL0hZcFZsaXl5RWRUcTViRGtJQXpGV1JGbGYwMTV4RHNFcGwx?=
 =?utf-8?B?MWVxeklqVkxNSi91VXhkNU5IMnVvYlJFRHA0cDVVQmxHWjZBSG51QUhuSHVn?=
 =?utf-8?B?T1JsUy9Na0ovR3FQbGhVZHlVVlZVT0hNcmIxQmVaRmJDUEZUNTlpVWpIK2pO?=
 =?utf-8?B?NXIwTjhBZDFrMkw2SDJhOFlnZzZzcjlxQkJCTEhoNDFpOUQ4alhiNmw5QThp?=
 =?utf-8?B?YWlvODFROXJteVB0T3Zwa3pMYkNjaExXMHM0eVRjYUZyeUlpT05CY240eUs0?=
 =?utf-8?B?QWhIcHZtVHQrakhUdktlTXlTVzh4L3FjeEFjdzFmOENTUHVnMW9KSWFmSGVn?=
 =?utf-8?B?V2Y0MHc0TjBkR3lXU285NzFjdUtBYWVOS1kwUG5ScVg3ejlzWDFLNG1peXpK?=
 =?utf-8?B?cFdFVE9YMVdrRHNiNzFTYXFESVFKUEhHZURPdExGc2psVUtFZktDdU9RT0p2?=
 =?utf-8?B?NUxNdmxKVUV6dGV3UjNtWVd3SmdkWXB1Y3lOWHVqam92bFdvNnVwd21GT25G?=
 =?utf-8?B?eUtJYjBkU0NrWFk5VDBqQXd2SWlWY0Q4QVI2S253REluN24rb1BPYy9hczdL?=
 =?utf-8?B?Wis0V0dNVDFiakVLd09iemFWSENPZlFPZmlja3lLT3VCZzBqdklIenluNDJG?=
 =?utf-8?B?NnArL3lzMmd3Y3lsT0czMmFYZVg2c0MrS0E0eUErN05aZHhNazBhRjYrRnRi?=
 =?utf-8?B?S3NoWVhLMzZXTEFNditUcWxpWkZYMWVoOU5aemFhNFdnZ1lwRTIxV3RqeFNE?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c36c936-939c-41c9-11c9-08de17ed3659
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 19:47:53.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyYtkiwHjBSZAzoAo2szPwyzTUVqOQ3ob1CVbpD0DYzA3QRc+lSqu6A39wYZ8lvK6n8XIqrmZGd1LoUhXh6zydxVWjMx1x5kR8/8P8PVEHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8459
X-OriginatorOrg: intel.com

--------------hPkJcH0V203FPDrGlkSEhbV3
Content-Type: multipart/mixed; boundary="------------PeYVsTbqY4bkZ0WTO1zqyybU";
 protected-headers="v1"
Message-ID: <0d8d4b82-f663-4bf8-abb3-87296c01ed22@intel.com>
Date: Thu, 30 Oct 2025 12:47:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kdoc: fix duplicate section warning message
To: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
 <87frb0miti.fsf@trenco.lwn.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <87frb0miti.fsf@trenco.lwn.net>

--------------PeYVsTbqY4bkZ0WTO1zqyybU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/30/2025 9:54 AM, Jonathan Corbet wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>=20
>> The python version of the kernel-doc parser emits some strange warning=
s
>> with just a line number in certain cases:
>>
>> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
>> Warning: 174
>> Warning: 184
>> Warning: 190
>> Warning: include/linux/virtio_config.h:226 No description found for re=
turn value of '__virtio_test_bit'
>> Warning: include/linux/virtio_config.h:259 No description found for re=
turn value of 'virtio_has_feature'
>> Warning: include/linux/virtio_config.h:283 No description found for re=
turn value of 'virtio_has_dma_quirk'
>> Warning: include/linux/virtio_config.h:392 No description found for re=
turn value of 'virtqueue_set_affinity'
>>
>> I eventually tracked this down to the lone call of emit_msg() in the
>> KernelEntry class, which looks like:
>>
>>   self.emit_msg(self.new_start_line, f"duplicate section name '{name}'=
\n")
>>
>> This looks like all the other emit_msg calls. Unfortunately, the defin=
ition
>> within the KernelEntry class takes only a message parameter and not a =
line
>> number. The intended message is passed as the warning!
>>
>> Pass the filename to the KernelEntry class, and use this to build the =
log
>> message in the same way as the KernelDoc class does.
>=20
> So I would like to thrash the logging more thoroughly in a number of
> ways.  Having separate log() and warn() functions would be a good start=
=2E
>=20

I do agree the current situation is a bit messy. But I'll leave
improving that up to those more involved in maintaining the tool.

> Failing that, though, this looks to me like a reasonable fix.
>=20

Great.

> However: it doesn't apply to docs-next.  I can try to make a version
> that does in the next day or three, but if you could respin it against
> the current docs, that would be great...?
>=20

Hm. I was able to apply it cleanly yesterday. I will send a v2 based on
docs-next this afternoon.

> Thanks,
>=20
> jon


--------------PeYVsTbqY4bkZ0WTO1zqyybU--

--------------hPkJcH0V203FPDrGlkSEhbV3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQPA5gUDAAAAAAAKCRBqll0+bw8o6MoY
AP9B9OHC+YsdwDnFmU5UX/OvGsY3qpJVL85uO9khk9WFFQD/fE1u3QDZk39DGhddvuOTDLrlqa5w
9TUSidb0nzkd6AA=
=gDkX
-----END PGP SIGNATURE-----

--------------hPkJcH0V203FPDrGlkSEhbV3--

