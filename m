Return-Path: <netdev+bounces-278256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB0oE4qO3Wn5fQkAu9opvQ
	(envelope-from <netdev+bounces-278256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:47:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B8B3F49EE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D083019901
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81C219303;
	Tue, 14 Apr 2026 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4SMyn9H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476813AD05;
	Tue, 14 Apr 2026 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776127623; cv=fail; b=Y+r993TQssphl5IEiv0Ufbds/mLvP6eC/G5dFfg2Z9ulUWVBKs4e2XM3MGi2AlqjtKRjsj90YmLKKnH5sWGMJOCSmMfDNgMt0+fQmq8J2uBF0thaalpQwcpP+/pWo76ehIx/LA4UjtI8jQ1KDGDxE8+A3H4nupOurE4fx6pry7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776127623; c=relaxed/simple;
	bh=VPDLZmNy8uRtrzRATp4EDfzDAw6oGSkuJt0YKYyMQ9s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H8akf6p0QX7VWxEV87CRmruEuWTRGC9RrFd1PCkzy3+k9yTyHeAI46t7hVtCgcT5f2w5IIaEIzFOPQvpUxnsuYv21BUcQNqhUa8+B2a+VZPRQIGdNDyHFrWIXPugkEzm6Q7nFp7pva7UyYx5z+RtLmgafk+I1JmgKtWy8pH1fpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4SMyn9H; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776127621; x=1807663621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VPDLZmNy8uRtrzRATp4EDfzDAw6oGSkuJt0YKYyMQ9s=;
  b=S4SMyn9Hb+xdlNZot+uIctxdMKU1B8L3sC35nbOx2pGCCbpkl5mxucGb
   uxFhPulMHrqnkF9DqqAjENnzvzoEf3CVeuLCnOtHCrU1RoD93d4qw9xCu
   STSjJnF+8jbvFX6F2I8rORBJ5c62OFZwVvzV2C3khYo0i6Tsrvn0w1lcT
   y3VDNDpq1MgrC53eNGO4Gf2JViD97GgQ3MDQTMXB8p+50wMDOJ6NY3MVC
   dC22Gu+mnQ75P43muTIzlxZgkqao/u03GRexUc/5dkc5E4WfrUkzK83i9
   jYj5m+wUYpW/r4j/CoNa3H8qkKyblfoERhPCH5XV1rlyM75f7zRl9pHyG
   A==;
X-CSE-ConnectionGUID: C82qJYsoQf+RxZ9kl7CIMA==
X-CSE-MsgGUID: CRpUkKwuQIi/Xnf7Ts5bsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76238577"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="76238577"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 17:47:00 -0700
X-CSE-ConnectionGUID: 0J9HbI62Sxisd6pSvNfXIA==
X-CSE-MsgGUID: /RICMNQBRe6kxlsZT/FDQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="233965560"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 17:47:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 17:46:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 17:46:59 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 17:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nrkq3KICbRK8IFu1uR17aCDwUUVWOzPafyilJaq3HyKiZNEBsLoDWpuMrYK5rUqp6YszzVTgD2P7L/RJ4DpO2P4Ut/eDgneVGw7kLujwFmfyEunD2nN0yGXe6A5P3z3Y2eV0fFPHyTa3KTKLs5PNiDwV/l5sBpkokGIGw+cb3xHodnFbDXobDV8mVnC6PQyU6m7SHKogQq4gKehzA+FD3yk3l7BiSoc66OCOwvXuaNVMTUsBi3XyFawPd7ECNICDj6laXM9gi+w+3f02U3ZMB5f0apGEIuHVF7HTDy91D35xxHRj5kCZ+BKT8dd42B/vCZ+OH6U0LcMvZPdd9wsirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dByCiFUKFC0gnLHfCvFxk7BLtQXcJtwrXIIh8ViFps8=;
 b=lYx98lCdEkL4X0xek9xgJYULCXFQaBS6MuLQSodEyrvDaz2wS6Ftb4eV6dHpy8/2uCismpImWMgb2fiY/uWHqHNLciYDrWvFyr6JkyFcrpup1WRxuIQD/Adep/g55NMwWvSh1Xw1PNGnGJJ82zKeJnxddSUOxtT+/CA9fFi1hGBgRBrSYIaPCD313JJsyFuzg6tx4DajBcw1Sia4CbF7mLCUyHUJtPwMhuDQyaFD/Dtna+gcoO0SSGApTFB6/Hw9Ls0L0J+QdA3Yjrfbft6LRXvKIa8DeEwiF803jz5L0WAmc+/ayTzLAeHN816lVV4PL15w9IQXniAfegKtmnrX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Tue, 14 Apr 2026 00:46:57 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9818.014; Tue, 14 Apr 2026
 00:46:57 +0000
Message-ID: <193fdf9e-db5f-4ae0-9a8e-d7049fa74ee6@intel.com>
Date: Mon, 13 Apr 2026 17:46:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] idpf: fix double free and
 use-after-free in aux device error paths
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, stable <stable@kernel.org>
References: <2026041116-retail-bagginess-250f@gregkh>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2026041116-retail-bagginess-250f@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:303:16d::7) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|DS0PR11MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: e169e9db-4d55-42f8-93c0-08de99bf54a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: PP+qiXr7VRc/I4WP+9FhsQPEtbZ2Kx29OI7qQfGzszGRxVcHrt3WlodUbrAg/PtZS25aCquG4bcheC4ZNaw4vxThN6uU0GwBBq9/SvWYBIHvhwMyPZM1czZUpmwSqD83u8LpJuU6E9OXA1ymq0zftaDKAOr4zjN1TnaF3yZNPmgrvRO4JOcGdfCkXN5GXWPMsLeIq3XpffOHiHylIlZIBNeOMABlzn7O6f+weBfA6Ac/6LZwC0VvR1p5mb06N8oiD6QTXkJIj40oV6t0ueFhXlVsCWQVVgVGMPNRJj58d+CDcTf5816shs8wNHt0+ax3attyP6CxPlN8XX3CtB8vCGDlMK+emDtVwS0rrJdBuglJFOiGcgmIHMM3iBdXMXYzUQUs9EkhKO8ufJfyo2v80R53DmWNrqf5ApB5D8ngEJwl44G+q1ktfaem1ui+JgbRtEIGPdoiJ6NeJVPqwFZEnrVn+wwATFm7zV/MD/waRmFU3KPs00qF6AhP78Hnb9kdXmXnamZQoufxhYSjI1QEu+ZhKAPlPuiWs3S4eGpGhBCl9K4CFfQP/rGtttnEiP+pkWDfORhjXWEw3zBGTmuq0x3540kCgWD+SWc19YWasSXOuUnto1h4UiH2x0Go1v9tsietXeggH3QkefEOBYDoJ2BRnIUzwaCXGZjpQNaKVIwpCQqtAQeVIpeqk99ttCzLeRjB5L8aARIHoHQj2YkREmZNjljeIhvrRS9rdJMtujw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFQwVWxQVUR4enhQb1dBdUs1ZE9neE1kNUtxMUxzeTNoYUlQWVhuYmhSYUVn?=
 =?utf-8?B?S3d0alptbGRkbmlVbG1JZndnZS9ML3dmZUZSZ1VuSDZ2ZlR4Z2w0QUsrNjlS?=
 =?utf-8?B?VnZ0OER0S0hVYUtRdnBHdU9iNHpPQmFLd0hieWhYaDYvaTRCclBnVjNXdjJT?=
 =?utf-8?B?bEwvSjl3ZWdLbWJzbjVQVHY4MlNsSjJIT2JBNjZmc0hRa085N0JvM0E4d08v?=
 =?utf-8?B?L05Kbm4xbldHN0R3N0NZdk5wcm1JUjl5L2VNU3c5WktQUjZhNi9UR2VmY2Fn?=
 =?utf-8?B?S01UVnp1dFRIZmt1K1AveEU4MzZ0L2wvSUJ0Z0pyeTZRYWxaaG9WdWU1ZzJ4?=
 =?utf-8?B?aFBaOHdUblVYTjE0RjBESFdEWWMxejRhWVYzWlYwdzRNZFU1MEhSRTcyOGhQ?=
 =?utf-8?B?bVA5VWxrcE0xb2RRSVdRMENBWVliOHYvRnROK3h0M0dsbXYrRERqeUhpTW9R?=
 =?utf-8?B?dWZtMWorclM3RWhoQWZqQXFPT2ZYZzJINDMxcUtNNk9idWljN3RDcWxsem54?=
 =?utf-8?B?R1dPbmpPdzNQalMxUFovNnI0U09NaEdtVXlzUnMzTHJhZElPOUpnSlZaZy9w?=
 =?utf-8?B?dUhyOGtMck5vQUR3aXVCb2EwaFU0dkt5UXdBVzRWRWdGRW9Eakd0NmhndW1B?=
 =?utf-8?B?bGEwUnhacjdCekRaanBQb2F6SmFPd1pYUG9vek5WYTFuUnIyaXZqcmZkS1V6?=
 =?utf-8?B?cEw2OHl1VExDRkJlNEFWY0p3NlphRHhlaEtyb1FGOXZEY2paZ2NFS2Z3eldy?=
 =?utf-8?B?MmkzTTNKTTBlNHpwMEtQc2orZGhhNktGeFFTOG85cnh5eklHSThuV3hqb2NC?=
 =?utf-8?B?L3lZQjJtNUh6SFVVS2Q0UmVWQXU1eENOVVdsRGNySzZzZ0JVTlBBL2dZais3?=
 =?utf-8?B?VFBYTkFOYjJMRjY2VUg2Y0pqOE9nYUZiV24wTVltZXJZT0Vkcy9SREh0ZGIy?=
 =?utf-8?B?UXJDZTVSdmd2dGVXM3Q5MnJXdGtrRGlLaGZadU9UTmdBdi9nb3hJeDlUZ1B2?=
 =?utf-8?B?ZVJvN1RmYmVaS0RDb0JjUVhHSWMrYUt5TmcxQ0xTUC95S3Q3aHRwU2RCakRl?=
 =?utf-8?B?c1R6eWk4bGVUM1JQR29LOXJDcXYwL0d0eUcyaGNDNDdsTHVuY2JaRTRVRGNt?=
 =?utf-8?B?UGptdUFYSlJVODkrTFdKVjBlZjZyajYvN3lmR01rR2c2NE84TVRLeTVaZVl6?=
 =?utf-8?B?ckMwbS8vakE4aE0rQVFwWWFuYTMwN1VkcDUwZVNvZ2lsZ1dqakloTjJ3cEw0?=
 =?utf-8?B?bnU2clF1b0hrSXNiSGZlNXk0NTRneWtkakVMaXR1OERjMUNoSmQvS3k5R0la?=
 =?utf-8?B?YVJUOHZRYjNDN1QxQ3JsYlVlS3lwWTZsM0VuR1RMdm9Ta0RRdExQdHFpd2FQ?=
 =?utf-8?B?SDREaGh4TjdNSVBkeU9aT203NHdtZEFIQWpSanhSaDhIYlNOQ1c3d3lVSkk5?=
 =?utf-8?B?ZFcwdm1jd3RIQ1cxY1VIenRtZWVMLy9wS0NjTWNaazVYbFlUMU9XUm9iU3Z6?=
 =?utf-8?B?b2NnemhtRGdQRlJMT3QvUFEvQnpjb29ZMDZJU2t4VEpLWmZPYmtaeHNHOFk0?=
 =?utf-8?B?enY3eGxtOGlmTWpoOERnVzBiaVppT29FTzFneWc3aHJDcnVDTlpKYlp0QUU0?=
 =?utf-8?B?enQwVk9aaTgrTVB1NUJiTTk0c3FiUUt5dzF6cFlEUEx6THVrVk52Y05WZTFk?=
 =?utf-8?B?YmZYV09ST2RYR242dXRScnFySGJnaW9DaEVYOEFpQTlaSkhhYkVRci9kcjFE?=
 =?utf-8?B?VXY1N1dZRGFWVXFiaGdTRWdxQUZKSjVxK1ZxOVlWMm1IcXFKUVovcFVXSXlv?=
 =?utf-8?B?RmRyYXU0dzJ0YVJXSGF0b0dsNUY3dVBoSU4vOE4wT3hwRUVEcFkrbm5jRnNE?=
 =?utf-8?B?L043T2U4WmJ5b3VyMEVJV1VOTkNRWE56dGdPS0QvdWVTa0V3ME9MOXBiNEJk?=
 =?utf-8?B?QThYbmhCKzFJTGNzOUhYbkpOS3NMZXd0bU1kQzJzNVRzTnllSWxxcDJxZ1Fr?=
 =?utf-8?B?WFdFMXJQd2MyVVorSlBGU3RvZ2lsNGI1TGpyQldTKzB4T21LbUNVcmtXREI3?=
 =?utf-8?B?ZVdrakc2WTdlR01kOW9JWVNyeHZiZEdTczlRT3ViSVlPZm1CT0dHMmhnM0RI?=
 =?utf-8?B?UHUzRzBINUl0ZWwyMS9DM1pPemRvUzEwWTlweUpMWW80K1pHTStSTXdHblph?=
 =?utf-8?B?NlRydTBJUzFGVTYzd0hmT1ZuSXBCTXorTG4zcGlmNzk0Vlp2T0JJYS8zNmth?=
 =?utf-8?B?Wi9TMUo3STVPSlZ6ZmZ1T1JybTRHZWIxdTFhV1ludVlYN0Z0WFNGUDZRNzRM?=
 =?utf-8?B?RzgrT0VlZXV6enNkUEFRNmQ3c0tQd1dOUVRUMkRraVBuOTI1MEZmUT09?=
X-Exchange-RoutingPolicyChecked: gZaF8nh7R4okZ1opvEO3cKdmLI5SL/IEw38tznyHjEQqRc8UPAYLAGlWxTp35S8k2HZOtfBDdv0Hrm8cWFW2eEORcoVpvCuruXrZbKAml+Y1DI/Q7rQ1iqCriX1cCFx5nAvQraJmHEHvcU82dwyCazaTSXDEunx90uiENHsqWGsjsd2TgXVLIZTQrJ/6HpjXbz1lW9Gz+YFlFqFS5VCuLg3pVWg/ai7DmItIK/nnXVZuFLZPqW63dNVrx0u75+HdHxEsfiSaD96V5iAscBrlFR/aBAYQqlo7+atu9hUTombcmyEOetL2bgmeK3yrgWK0519vyrjtzLV/EPUmmr05Rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e169e9db-4d55-42f8-93c0-08de99bf54a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 00:46:57.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esgpJdqrnfV5p1kGo20Fiwk/7LLXPRBa9xfbRKQ8xwgRPT+DLRlCJvlMyHJ9oiTqaz/cWUOpkqbyQ/dXtYvWxGAIcLivQ5M92jWTkiM5rds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7785
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-278256-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A4B8B3F49EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/11/2026 3:12 AM, Greg Kroah-Hartman wrote:
> When auxiliary_device_add() fails in idpf_plug_vport_aux_dev() or
> idpf_plug_core_aux_dev(), the err_aux_dev_add label calls
> auxiliary_device_uninit() and falls through to err_aux_dev_init.  The
> uninit call will trigger put_device(), which invokes the release
> callback (idpf_vport_adev_release / idpf_core_adev_release) that frees
> iadev.  The fall-through then reads adev->id from the freed iadev for
> ida_free() and double-frees iadev with kfree().
> 
> Free the IDA slot and clear the back-pointer before uninit, while adev
> is still valid, then return immediately.
> 
> Commit 65637c3a1811 65637c3a1811 ("idpf: fix UAF in RDMA core aux dev
> deinitialization") fixed the same use-after-free in the matching unplug
> path in this file but missed both probe error paths.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: stable <stable@kernel.org>
> Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

This is targeted at [net]. The fix seems straight forward enough.
@Jakub, I have no objections if you want to pull this directly. I am not
sure our validation team will find anything when testing since this is
an error path that is historically been difficult for us to test.

I'm also fine with taking it through iwl-net if you prefer, but just
want to avoid duplicate work if you're already considering it.

> Note, these cleanup paths are messy, but I couldn't see a simpler way
> without a lot more rework, so I choose the simple way :)
> 

Yea, I didn't see a better way either.

Thanks,
Jake

