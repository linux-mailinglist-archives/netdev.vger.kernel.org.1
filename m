Return-Path: <netdev+bounces-155808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6AA03DF9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46471886EB1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C761EB9E7;
	Tue,  7 Jan 2025 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9ZLYBDn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE81E9B31
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249812; cv=fail; b=p+wdYQPdYIYBJyD6kNeIwza4V1vFhy7y9+31OHiZynXkiPphORbBtAjUgcGXRh1xm31XmhLHRqJFTylS3WOQZ+UAMFZKxuMgHZd7o4edELbThFq15+2DG53Elbz3FSZQnYj80p3kH4582C9FUzOVt8BjKV5N+AJADrQiwsf4iEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249812; c=relaxed/simple;
	bh=w8BcQ8Yy/io9P4CagDpZxXkGmtHz7MszV28jHc76n6E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yh5wvO7tIjP2A3f5w9eN2ouCaRT5W07nbQ6yLIPVHu7GwkRBljoZVQiCbemE2LJWKoXJiRvDHfV6EDQjy0Ry3cI8HCGketYpSxl7enkU0oRISe53b6gd2i3SxMXpAU/kCBnZWec9nrnEBBu6H/KgfbqT0BsjzvE7EMMEfh5PhwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9ZLYBDn; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736249809; x=1767785809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w8BcQ8Yy/io9P4CagDpZxXkGmtHz7MszV28jHc76n6E=;
  b=e9ZLYBDnIEEaBYiHkA9xbTGtBz3vZkIGINCuk+v5spiumRo1oclXvkBN
   N3n4umhdwy2pbQ/DoGNi7mzLfvzCEGUBX91iGkmGn3mHo4f3Lja4Jo1Q3
   SEEG8kBdiITTasPVvUlz3JVNS3NDqqYrlvb4Ija5Tl5/Ib+Api8NDkwah
   icZeWnHea6QLhINzuShYtJYIGBxEMdalG8+/vcVbFWHuPoOLc2FEp8XQ5
   ynek6f6dkOZWiNrTgxASTacdCIY60aFk+eVvcN9QNTQlg6bqLZIgb1VZk
   eoJHsghGyeERDnKJ8HzgjJBvOByPNm8bq1oGalC8nmXAvQbnjXtfDuk6P
   w==;
X-CSE-ConnectionGUID: Mug13lrvQm+zndsdaaRDXQ==
X-CSE-MsgGUID: kDOavPhkToOqvDEIDtT8Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="36444169"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="36444169"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 03:36:48 -0800
X-CSE-ConnectionGUID: ef9qY1ROTT2cvfMzS/CYKw==
X-CSE-MsgGUID: sCdJNQT1SE2grnl0x9Fi9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103238980"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 03:36:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 03:36:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 03:36:47 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 03:36:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZfpy71LMToyywtNH7ifx0vc+3UNvSc3rCX22ffYQG0nV+LM+1uMMVNibonodZl6j35Nj9zVVBgaiQWCl1+0iRUrILVSlmyZabT2Wcog1CuCfWg6bh/YgRRmt389nACCuwT20TybHMsqd44/u9wCeBaPoUUZh3wrZl+bv03K8F+ld6iXNDUTZ8ohJ0LsfHRRhhYyODT1cClWvEuWrrWyJoDOH9pDdGWPpIL7LrSbwciozF8asiz3qAQmlsFx9d7GRenhJ6WHXaC2Kb138OhjVk1t8xXyUKyVNmqbfPVbnzM2Sjv2tcbwMCL0WITxosT6mwS5PqDmbPS7Scf930lFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKuCxjtd/8nKXyS8qngviPlcxIr+0CoY/phDn1K71lU=;
 b=vmViYkSwe0FLRysCy86qQ+A3yCaPv7zdUKPzSeaL1S5vnnt9c3ELx2Biv0FoFei9aaVb2FOLorYVyOJQ4wOi51Zl9Y5TQWZUWgTmp+awjUAnpENfJq5A3xWIQPJl0BtwnuadpjaldbbNcF6ZY081C4f/cqpMQ6kxPXNCd+XUIDWuE3YyFahbpbVycPrTUxc0nmjqAwnHSWk5M4JHvzl3++VrHTazfLrlGsslYFVksol7Am8xOrY38E5qGVjKZIq0eHxrBV2hYt6vDlsoAIr3iEME4ZZWGj2qdI7vfQTEoqamaU/t0Ev2a/dPgSJJfJDR6lMqEv/GKmQ4MGkuwd2PDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 11:36:36 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 11:36:36 +0000
Message-ID: <a3960405-b6a1-42a5-8904-b7f13cbfcf98@intel.com>
Date: Tue, 7 Jan 2025 12:36:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/13] net/mlx5: fs, add HWS actions pool
To: Tariq Toukan <tariqt@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
 <20250107060708.1610882-5-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250107060708.1610882-5-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d46f31-11bc-4a4d-5bf8-08dd2f0f8b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWNLOGMyS09kRWx4cTZuRmhVMGZvNjFaT1dkZGp5NDFhZXRWdk1NaUNYeDhH?=
 =?utf-8?B?cVR2b0JyQWFNUGQ0dVpINktCdTNIR0pFS0NmVmFJckJwT1pleWV3azQxTDk1?=
 =?utf-8?B?SXR3T3RBOHVBaGlHVUJ6UUJmWmxaTjNxM1dub3NHNG9GMEV0WG5lK01IY3Y2?=
 =?utf-8?B?b2xtbHBISEVkWm10WFQvdlV0L2FqSVpjanNOUkdpclBMaW1qU0VpcGdNNUlp?=
 =?utf-8?B?cFZzUSszam1GZWJxNmkxcmJYenJ5UFVDQkNBSEx4ZHhiYlRxaFRXU29rbVg1?=
 =?utf-8?B?R3NEbHdqZVlUMXAwZkdnSUR0eTBrNm5MNDIxejNwYVBubjh1ckdDa1BJVDJo?=
 =?utf-8?B?bU1XMHc4ekdpcUFHWGYzUXYyNWdrQjYxdGk4QVIxRWd0c204TG5VSThmQzVl?=
 =?utf-8?B?Ri8zSENDakFDcm0wNitWTGxMZlF6K2U3ZjVUZXZYdGdpLytCM2FYNHJNR1U1?=
 =?utf-8?B?Q1RFOHFoeXVUbDYxVnc4cUx1N2hpbzZVWnpMc1NlRGNWVVR4a0diSTJPbDhr?=
 =?utf-8?B?bmttMERBRlFiaUVjNWgyVHR1dE9BRkdCeWM2VUV1MCtuclZlTDNmV0Vxell5?=
 =?utf-8?B?dzJLdWhMdHRJZjRDTTlzZmQ4Z1k1M3VPWEJQWUNiVUJDNm5ycHc0aHpDbGg1?=
 =?utf-8?B?WnlacUVrbU9TcWxnaGR1Z0hpbnE4bWRWbHJycENOdTNyQnRDcm9SYytYNHlh?=
 =?utf-8?B?VXdad09BR1dqTE1JTk0yWE1iL3FFejZ1R3FhWFdaUTg3TkpyYjVCcUExNlFJ?=
 =?utf-8?B?OGJSOVgrRFEwalgxYy82N3VaTCsvOERBL2pWMVFzOFBFY3VuQWlMc2p0L3lD?=
 =?utf-8?B?RGkvVFZOMEJneG5sRGxod01RSXFkV0xIUXZkVU82VnNxNkF4akx1SUMwN010?=
 =?utf-8?B?dzJicTI3YWFVMStCbkJSazdwaS9IcVFKT1hKR3ZIdUVHbkV5ekwyUlJyYU14?=
 =?utf-8?B?aVNkclo2Y3YyQnEzUHdFa05xTDZ1VTdheURmb0oyMktqSFZHRml6QktxTEhw?=
 =?utf-8?B?ODlQd0x2MWVhNzg4bXlmVGZHZGVOa0RZL2tLWVowaDA4c2FSZm9tUktBdk1p?=
 =?utf-8?B?Yk9oNExiM3YxTHJqRzQwSE1jRzVXRi9QZnBRcXBQS05nTGkyMHBvMVBDZjU5?=
 =?utf-8?B?LzBXVVZoTjFXUDM5bVk3RU5oL3NUbmlZb0pyWVBacHVzNE5idy9VTkt6c1M2?=
 =?utf-8?B?cG1FMzZ0dDJlK3FQWnNYdS9RRExnRC9XbEZMbWRJU2VUWGIwUHY2cmdZbHcr?=
 =?utf-8?B?WGlVUGk5NFdCajdqQVV3WXdUdDhGWVB5OUVKbHFoQmlVMEFtSEhtWkhmSHNW?=
 =?utf-8?B?TVIzVHU2UGducnVENkZRcHpiMFdpZWc1MnpCSGVXbmVDRFNKTGtsMkpvcERI?=
 =?utf-8?B?WnE3Wi9RbnZpbjhhcWdpN21lQTFpN2duK2VqR2s3ZWFpSUp5OERhVExEWDR4?=
 =?utf-8?B?Q09mbUhrOGx2UVUwbmRwNldmRktVVGRERFErZU50cW1haHJYL2o5QWlZODlK?=
 =?utf-8?B?Z3VXWDlISUpWTzIvdHFZRmZSRlhvVUk2RUlDbUx1WVluRjk0WWpCdTZDblpv?=
 =?utf-8?B?cWNCNlRJQjlQdFZTZGNtRnhuSHFqU3FZdGdSZENJeVVhNytUcjdnNkYydTRh?=
 =?utf-8?B?WVdpNEF5VStiNy9TSGhIZitQUlRvTXg2ZmVHWUFjZ2UxZGhvM2d2MnZ0eWpZ?=
 =?utf-8?B?Y0RsbU5lOU5EMXpPMDNXTHBlTnB6bEFRKzBHb3Zxenkwa0lLRFVjU2NNanUy?=
 =?utf-8?B?QVdMSHpuV0tsVEkrbjNyQzJmSmU0OW1EZGl1VDVFQ2tzbWdzN0ZkMEdJTUh1?=
 =?utf-8?B?bE1hd2VEckoyeXdaNG1ycjZmVGJyT1doT3ovQXZmQXNCc09nK2xWVnM5ZXMz?=
 =?utf-8?Q?mvR4IrFdyGQiL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTVJcFY5YlpsS2pqWnJUK3duSDZlTjYxKytQd3h3SzFJWVRkQWZrR09NYzVM?=
 =?utf-8?B?Y1VjS0V1SVl1bnUrV0M5aVBFSThLMXJmQzdDUTlIWEttbGsvSFpXMFhzcGw5?=
 =?utf-8?B?ck9aTHIvcDVvdUt5djVMSGwrWkQ4ZTRCM0M5OHk2KzFYUjJIa3dVcDcvbldw?=
 =?utf-8?B?OVlVM0Y3KzhPK21ldlZSMlhKVUFUc0RLTUdhYXRkMldxYzdra3BReWMrc2Qw?=
 =?utf-8?B?M01yTVJHRkg1R3EzOHhCNjhHdVhHbWdCVVBHTkRJdm1ia0o0aDg5MDhWUjJY?=
 =?utf-8?B?WTdqRHgrT2VFR1V0aHJtR2VjYTJVbERMQTVDTDZPK3RTaEI0Qk5rSHFWTFJx?=
 =?utf-8?B?TjlPbmp1cmpKRytESHNpQW94TDFiVy81ZXp3NkFWZ0RvQW5YcXhkSjZRR2hj?=
 =?utf-8?B?ckRQVk5CRXdvamwvTTZVNWVTQmZWUHEwTUtiZEpONlpMV3BJYUlVdHlBNFJs?=
 =?utf-8?B?N3hQaFZ5cEk5QVVFMzZUemVCdWRURUNUR3UzLzhUcDN3TUtucUdGQnp4Y0Y2?=
 =?utf-8?B?Q2NFcS9lTVpBREpnekFuUmxDZmZhUEc4ck1wUWFLOW1LajdnUUgzSi94aDli?=
 =?utf-8?B?dUhVNkRIbEIyb0tRMERXVkpJMWw1RWZSNUpZaU1kUnM4N0FzS3lnREdsMHAx?=
 =?utf-8?B?OVczNmpBdE02WmtaSitTMFJCZmpHaGpmN2s5VThMYlpCMGZrUWlwT1o0bGk3?=
 =?utf-8?B?d1BzZVNyRjY5N3pySksxaWdLc2xSbWtlWXV6ZmVYeThGdUxjak9EVTYreFRS?=
 =?utf-8?B?SDc5NUtTdThoTGtFWm1DZkxTaWh6ZjJhNUQ3Qi96bm9PRmpBdXRraGxEZ085?=
 =?utf-8?B?WWwrNXRNN2R4dlBSZGk3Y2s1a0ZDcitlVk5ZVTA5SVBqRnoyVE9BK3hab1Bn?=
 =?utf-8?B?ZldBbVZ4RDJSVWVsQ09KcWFrTjNtajIyckljdVdDejBqbEJLY01RWDA3dGYw?=
 =?utf-8?B?emdTa0g2cklQV1A3dFhveVJHV1pYd25JNU5wTi92Vk5LdFVWUFAycEZEMHAv?=
 =?utf-8?B?eVVrMXQrWnBzUXptUWQxaXRob2V1VG5uQnQ3ZFVJTmJlbkZQbkJQK3UzRUV2?=
 =?utf-8?B?dVZPZmNlb0tmNWthUnBMeElxd1YrUFBlTGpUanlRN2J5dUtNZDJ0NU9JYmxw?=
 =?utf-8?B?R3lpclA0TktXdWtJRE5Jd1RaWC9EWksxcURVSmpiNTFDZmFqci9YZ2N6RFBP?=
 =?utf-8?B?QzFjNEdRSDdEelpUUGdZWlhpV0FiTmZIVTdUa01mRUZ2b0dpMUFCWTBVNVIw?=
 =?utf-8?B?Z0Y0ZjR2aHN0ZjAwMjk3SGRUd0RoM0ZDVXFkY2J1SzZUMWJlSEhtNkNEK0NH?=
 =?utf-8?B?U3dQWjZiMlBqUVJ0TWlVazlCOW12NlNhMTBFN2VZeHhSdnNFYklZTC8yU3kx?=
 =?utf-8?B?YnRWQkFNbkNxWjlWR3l1V0ZWdlYzZ1BJU3BhV0FiT1ErNXFRdWI0dnBra0xz?=
 =?utf-8?B?S3RwWEFPQjRwU3pualN4czJCcG52U1NMS1F3TGNvUUlXWU1Gd1lzN1J6U1Nt?=
 =?utf-8?B?dDNKbm9Dd3ZjTHRNRnNCUDlmYkszbG05L2dtVkI2UnA1ZkgrVUltdFAvd0Zx?=
 =?utf-8?B?dTY3RnRsY1dCeWVwdVNtU0I3MU43VFJWbFNNOXAzVFZEMG94TzdJcmZ1M2lI?=
 =?utf-8?B?TTE1SnJDa254SmluNXlWNng2dVV6THJpRXBJWTkrSGtucGVSbU1YWEJiclNE?=
 =?utf-8?B?R1I0aG9KZ0dVeWVEclNsWGJZOHV3b1A0Vm5OVkJ6QlZDaUh3elVCK1ZkcWFm?=
 =?utf-8?B?Nm1wUnZSa2h2U2lmVUtQZnBuSTVhWUJVUUo4amtNczlzUWxZSzRYeEs2ZzRs?=
 =?utf-8?B?V21NUDNlckhNcituVk9RQkZoN2V4TkdqYURqNDVhZVU3RFBObGlPa0dCVSsy?=
 =?utf-8?B?UVJRckQzSkhsUGtSVUo4UmFqdWQrNUlheVlENlFWaTJObmxEcDR3SGN4cGpa?=
 =?utf-8?B?VGVRbDlFWXZxRHVHd3JZY3VPNlhHekNCVjE4RTRaR3NMSVJzK1l4WlEyaVFa?=
 =?utf-8?B?MHVZRDlPRXdvaVpQY3NieSt0cDdGNVVsNTU4TGtGNUk0blg0MzRFYlF2WVBT?=
 =?utf-8?B?bkgyQ2IzU0tUdXg4djZ5OUhvWlpCbkd5clFnSDRHaGxSckk0TjhtK3dVMmkx?=
 =?utf-8?B?K3FRMDZoVU9ab293WTRkMXhzelVhMzdIK0ZGRXBWRkk3b2pSOE40MUJIUzZV?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d46f31-11bc-4a4d-5bf8-08dd2f0f8b23
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 11:36:36.3452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OMne/ieKcdbX6KXKwQKd7ZGBQjHukQ+seS+Kg7b6oUjOVbSxAdCzvdyvsmChhW0YwHIxA1A6uK5z0FhyBwBo/YEiDMHvx2Y9+CEZmiVBnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6985
X-OriginatorOrg: intel.com

On 1/7/25 07:06, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> The HW Steering actions pool will help utilize the option in HW Steering
> to share steering actions among different rules.
> 
> Create pool on root namespace creation and add few HW Steering actions
> that don't depend on the steering rule itself and thus can be shared
> between rules, created on same namespace: tag, pop_vlan, push_vlan,
> drop, decap l2.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 58 +++++++++++++++++++
>   .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  9 +++
>   2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
> index c8064bc8a86c..eeaf4a84aafc 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
> @@ -9,9 +9,60 @@
>   #define MLX5HWS_CTX_MAX_NUM_OF_QUEUES 16
>   #define MLX5HWS_CTX_QUEUE_SIZE 256
>   
> +static int init_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
> +{
> +	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
> +	struct mlx5_fs_hws_actions_pool *hws_pool = &fs_ctx->hws_pool;
> +	struct mlx5hws_action_reformat_header reformat_hdr = {};
> +	struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
> +	enum mlx5hws_action_type action_type;
> +
> +	hws_pool->tag_action = mlx5hws_action_create_tag(ctx, flags);
> +	if (!hws_pool->tag_action)
> +		return -ENOMEM;
> +	hws_pool->pop_vlan_action = mlx5hws_action_create_pop_vlan(ctx, flags);
> +	if (!hws_pool->pop_vlan_action)
> +		goto destroy_tag;
> +	hws_pool->push_vlan_action = mlx5hws_action_create_push_vlan(ctx, flags);
> +	if (!hws_pool->push_vlan_action)
> +		goto destroy_pop_vlan;
> +	hws_pool->drop_action = mlx5hws_action_create_dest_drop(ctx, flags);
> +	if (!hws_pool->drop_action)
> +		goto destroy_push_vlan;
> +	action_type = MLX5HWS_ACTION_TYP_REFORMAT_TNL_L2_TO_L2;
> +	hws_pool->decapl2_action =
> +		mlx5hws_action_create_reformat(ctx, action_type, 1,
> +					       &reformat_hdr, 0, flags);
> +	if (!hws_pool->decapl2_action)
> +		goto destroy_drop;
> +	return 0;
> +
> +destroy_drop:
> +	mlx5hws_action_destroy(hws_pool->drop_action);
> +destroy_push_vlan:
> +	mlx5hws_action_destroy(hws_pool->push_vlan_action);
> +destroy_pop_vlan:
> +	mlx5hws_action_destroy(hws_pool->pop_vlan_action);
> +destroy_tag:
> +	mlx5hws_action_destroy(hws_pool->tag_action);
> +	return -ENOMEM;

I would expect to get -ENOMEM only on k*alloc() family failures, but
your set of helpers does much more than just attempt to allocate memory.
-ENOSPC?

