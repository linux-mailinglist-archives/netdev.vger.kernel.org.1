Return-Path: <netdev+bounces-100908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A78FC83A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479581C20F29
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F055318FC89;
	Wed,  5 Jun 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDSyYN1Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD31372
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580696; cv=fail; b=KkV+f7DdMwsebsuixDEgV5yvz2VVqGr13lHui4PCafH5tW5gzFVFwl6uifBTQgI3jM4j5x/PJJ0yskgJXZsclMPd2Awc2mgpes9rdhh9qvez0oj0G2LYUk0YKFJMk9m6ivjiwZ/xiSA3D52t45uazfX0/+svwcFQV9vxSAqdyW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580696; c=relaxed/simple;
	bh=WyxIVbtprimIzFjVYf44+ll/9qQLKTnjeI7IPtumqtU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FT7nCFv6VvK1taUVBIqiXg5OlEnourZjFv5RXynb1D+cWA2CMrt8mUU4QnVpQb1FuOL30XVGugUwLNC1aAvF/v+DYuWE95jJz1Wo8x49C+9afcIORGN7hTTXRb74eqiXhH54LMw1ECoAE6rs4bHQMqHBJdxdLoB2kjsy+L55Lcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDSyYN1Q; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717580695; x=1749116695;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WyxIVbtprimIzFjVYf44+ll/9qQLKTnjeI7IPtumqtU=;
  b=gDSyYN1QmaPKgoDfZpuGa0TVZFiaXdf9eSubEKi5uifjHjhOABkyC61R
   k9DADML149FruhIivw6l0Z/ACZeYfExh8/ZEcjlP62aAZpyxebRbO3rVk
   aFQCJxd7UIVLyMkEwvBfAexmqUDeX8Lc2viE/4/b+TmS8VzN0LmvTOnHK
   ym8wc2JTyE9+qCchcrfpUCug2zbvWo/DKUe132Md5zOR/Jr3UDI7NuPVn
   uwPqRKfBLzAE8tGy7oQJtIB9KtZ5iudlYqykPuDuTM6cZK/r6/kpNKih9
   Yc4aQZ1H775TI59ODbec2QxtXQk7Cau9IHDRpzXr7Ovs9XYzJd/M+Gp63
   w==;
X-CSE-ConnectionGUID: sfEMoDfWSi6eMK66k6d1xg==
X-CSE-MsgGUID: eAC50l9xQ764mq94x6z7Ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17965508"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="17965508"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 02:44:55 -0700
X-CSE-ConnectionGUID: 4nTMwah+RO6aKU7ecMSw5A==
X-CSE-MsgGUID: tVUHT/XQR86mzZt0EdN+BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37473779"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 02:44:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 02:44:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 02:44:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 02:44:53 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 02:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/iJ9PacdnwPk9Qjk0LD21314TWd3zMs5YfRL3yOl5LaoyXp26MCaBTYNrtFclNpRUoksI1XYoBrJ6jBrOMdY0H1poze29DGVQlFbtCvULSsoaxisimMsXFtuIDCbx9RBXQ2RnyqTFQElIcs5vqMoZqmD7/RiezQK2R6mABnt8L6E7dR9ahQOw0BicybDFKedSJKpvXJR8tj1WekWdQGWzyFHK/afYeBuq3AQSpBk27W9+B+CW21HqtPRIZGftoYFcmS0iTPYVFEBYmBv611+e8elukYNmMSKF0phjT82YKWHFn5SxVVLTHGHPpcrUMFwOVmqoyiZ0Mw3sSEi+jgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/WXqFNl4psqZV4W6A/Igq5GKQ8n8rDIgizIpJ0oGj4=;
 b=k5aLWjQLw7bXB/gGD3hr7171R5N0mg+PgO0eLPjPMkX289A6L9wJViA1LWa275zz97pSNQ4rGVRGnpxCWtfrDJYUp21ad+OhWP3N0m+ZMqWJUZXvvk4h1HXkadZUYKS4voDl9xcqa8UyrlKd3q8DV4yw6XgVTtCr9tV4e13wrCGtqm7Uet3KPpXoacFY/XvtlM9CY2VnqSc2khiJsH4uDiRAYsUMNuAs47GHP3AxJDY35vSz/Q/nTuvhZBGJOW/y4Y5AAiUyiuwesywB44SvYAMcoaw5KIFbnVKPlc9AIYybxGBvxXj+2SaObRwFE+DQWLBtC95y83JjbdI16R/yVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.36; Wed, 5 Jun
 2024 09:44:51 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 09:44:51 +0000
Message-ID: <ea2b8fe1-cdd8-4dff-a3e2-f896c0e6da47@intel.com>
Date: Wed, 5 Jun 2024 11:44:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/6] net: ngbe: add sriov function support
To: Mengyuan Lou <mengyuanlou@net-swift.com>, <netdev@vger.kernel.org>
CC: <jiawenwu@trustnetic.com>, <duanqiangwen@net-swift.com>
References: <20240604155850.51983-1-mengyuanlou@net-swift.com>
 <43A4981B56011827+20240604155850.51983-6-mengyuanlou@net-swift.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <43A4981B56011827+20240604155850.51983-6-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA1PR11MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: a80566b0-7e4c-4d69-b5fb-08dc8544256a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG1mckx6UEVCZWhTdE90WFE5dURTVlVzN0RUVDdENVg4UVNWcVk4bkl3MkZy?=
 =?utf-8?B?N3ZNMm4wZERHQ1B6S2xOeXRhNmdIVXRNeGc4d2Z2T0oxL01uMkM5a3dYWm1V?=
 =?utf-8?B?dEZrdnlOSXhHdkpJbC9WZWt0c1ovNm81OVBEaUx6YjFoOFk2YUFtcVBWWWpV?=
 =?utf-8?B?R1YzVjNobTZhbnhxYzlDM2gzUG9VMWpwZDdqYlJGRStYaS9IMzRWTmJPSzVF?=
 =?utf-8?B?V29Cc2htNFozTEN3b0owQXI1ZmhJUGxQTkkza2N4MnZxT0h4TTNVdXVnZTZp?=
 =?utf-8?B?aFlxUGJqSzYvak1EbDVaMGpnVlpMUmJYWWwxbC9mS3krb3VRKzRDaDM4REtw?=
 =?utf-8?B?QUs0VUJSZjFua3VkRFVVWVlRbm5kQUhBdDlrc0lJbFpRbW5IMHVQTUdRS0Fz?=
 =?utf-8?B?SmEyTC9NNEZFUXMyelAxb3ZVZHF3SGVYVitQbUJmanAxSjI3RTUyelRhUmVx?=
 =?utf-8?B?NjJQbjgvRnA5ZmsrNTd5NzhEOG0zRDh5M0EyVThiMGsxRnFPZ2xUdm1qR21r?=
 =?utf-8?B?ZXlBUTdpeGgrbiszdUpZbFRTWFBDSTJZNSsySXVsVkVHc3luS01xempoZFVw?=
 =?utf-8?B?dlovN0hUWTJNdDk4bGVBZ3B2ZDFsTXFWbG1kOUtCTmM3eFJFcXVvOTFuelUr?=
 =?utf-8?B?OWx0bWNlYXFlanNyRVhZbjZYRkpkS1BWejB4eFVFTUMzQlYwYW1nT3hFMnQx?=
 =?utf-8?B?UGt6SW9iVVhjUXQ5M3p4RnBzdmVpd2M4d2tkcFpRd0lYR0Z0SXdHZWFvODd2?=
 =?utf-8?B?Z3g0MFB6eWxyUmxFdUhwUG5wZ3JMckUwbW14L1Fhdnp4OU5MdVJOWVBITkZH?=
 =?utf-8?B?QW9BcmxyaGgweSswSTdMUFFpd1NTcE5jbTJwMG90Z05NUC94RTdoQWc1SXBy?=
 =?utf-8?B?SEt4Q3hOZkxCRzAyRXIxYithRC9XOFNQVTB6QXJsaU5waHMzNTdYL1RhOEMv?=
 =?utf-8?B?ZjNOU0lpOTQ5QU1tenZkb1JOVzVWa0ZjSzdrbHhUTFlFbzI2TndGZEtLb05a?=
 =?utf-8?B?MEI0d3JqM2ZSWXNyaXZyN2ZwcDhYemN4RVo3OXJKelVDU2gwNDJDQlJNMnYw?=
 =?utf-8?B?VGJaN0ZiYWJGSWpHb2JTaCtianE2R0xyN0ZNZWZFZFRxbS9xL1Y4K1pIVWVz?=
 =?utf-8?B?WmowWGlxTU15MndBWkkyYWFhc2NTcXByWjFZVE5TZDVDeE9IMG1VdFphbTds?=
 =?utf-8?B?clFsN0dlT2pBRlJaUGRrN3BYU3JYQnNEQTdQR1RSTnFVQ2ZlYk1tNXllTFBm?=
 =?utf-8?B?WGpuQ05qcVVVMVE2bTZxeFUxOTlLY1Y4U1NjWnhKdnFUMkZSdm43clFITUVY?=
 =?utf-8?B?akhINmVxYmg3YS9QVEt2MTk4U2h4aEh6Yk84d0ZnNlJ2SWpNV2VCREFQRE9K?=
 =?utf-8?B?Q21XUTJsYkJDa21lbHpRYTExeWxSTXpYT3BlUjNNcExCMzkxYU5Oa1Y1UElj?=
 =?utf-8?B?QUpwZGdUdGxJeW5CQU1rVkFlVHVncTkrOC9MdEs2K2NlYWM3V3pVbXRxVHBS?=
 =?utf-8?B?VGhKWkphbnVreVJZWTJnamo2S1JuQXAwaWM4VlpJRkhsalRhc3lYQ3ZYOHVp?=
 =?utf-8?B?V0ZicElBTExhRzEzdlRwdUlySkVKeFRIbjF2b1lveTBlV1Y1UTN1cXFZME9y?=
 =?utf-8?B?NHdKZUhSQmxRZmFPZURSTVBWOG5XWnY5UEF6ZEk2OXF2dm5PdEkyZ2JjZ0hI?=
 =?utf-8?B?aGFMRDRDUjNmUVRLSlhlTGJMRjFjTUkwNElzYjlPZHBxSFp1QlIzdHU5UnE4?=
 =?utf-8?Q?4/cD7LP52mTAiXrgqbzFRjjdmD8EdGefb1af0SR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlMQVdOMm41NU9LeVlVVVAvRDBEMTZqWEFGcUhCZXNZaWVGQkhOSzhYbVZw?=
 =?utf-8?B?akxVMEFPTzZ6YVBpeWJkMVRUY01VZ3lSVzhoRmJUK2dyMkZnUllFWFZzeEpw?=
 =?utf-8?B?OEJ4YkN6OEtKSFJDUTRnNUlsMXA0N0lHYi9sUmVycjUvVnJjUzlQM1dGSVVB?=
 =?utf-8?B?TmxxQU9GMkUxcVJjS0k3eUtRZE42cTJlQm1HVFBnMm1zL3kxdXA1MTBuMytP?=
 =?utf-8?B?NGNHT2hZQ3pQbGVhcjlTb2xNWEFFME5SdGF5VW5CUVBMV3RPUkxPMHg5d2Ny?=
 =?utf-8?B?TTVPUHQvRjltOWVzTUM2WFFNS2JUTDBvQ2dXZVJ0OWZnZys4cDF2OUlaTVpM?=
 =?utf-8?B?NVhEMUsyNnBSVmJTNDN5bzFtKzUxdFkyeVh0cUZraGxpZThOMXdSVkJKbEY4?=
 =?utf-8?B?U1dMS1JVVjVMeE9uM3NKVndHVStUYjVod2xaL1FRM2x0anViRVpvV1RZYVlZ?=
 =?utf-8?B?OUxrMDJWS3hvUmFoUG15NkJpVmdQNGdTdDQvZnZmQzNEd0dxeTk4TUt1bmZN?=
 =?utf-8?B?MVB3ZnhKTVU0ZElwQlRtRzlqdGZLU0lhVWFWTmhCTURDenRIUUFIR3JLRjM4?=
 =?utf-8?B?S2hKRyt2c2pkd0ZIZFZhTWxlM21NMFBPWmNWelVGNHNhbDdNM28rUE11NUto?=
 =?utf-8?B?VEhWQnVuNE0xQllrOVpod1ZPcDkzVU9oQjM1cU9TTjFaSVJ5L3ZTNXdvYVJz?=
 =?utf-8?B?YjFVVkMvVUVaTEpqWFFjZUV4WGtOcDdySEJ3eXJONUJKM2RZeFhIOGhIUEpZ?=
 =?utf-8?B?dWZPU1RObXlNZW9YM1NsMFVCTDJjUVVYZWFMVmZSd0VRR0txM1l0UDdTU2ZV?=
 =?utf-8?B?VjBCcmtFNUU4Q3pJSW9yVDBFNXhVL1NxRkUvQjFkWVFkQkdySFM1NGEzcGkw?=
 =?utf-8?B?QXB0UXRJK3hoOWJ3a1NtSHp5TlRpR24yVEVTTU1uWjJKVm9NaTRtSFlmWU1t?=
 =?utf-8?B?QXhYRmc4aXpReVhoMHcvdDIxKzA1Vm1sYUZQYTJvU1F1d1dzTzdsY0JPeWFt?=
 =?utf-8?B?TzR4RTQzbkd4SzdCRm5PTjdUdTd0UGJKUjhlb2RUL25sSmJFN21HQ2kxbDZT?=
 =?utf-8?B?b0NrZzVrMXkwK05YRHhScVN1ZWZ1Szg5Mlk4K0ZoamZSWTBHdFdsbkxOUkdo?=
 =?utf-8?B?cUJnQ0MrU0F5ZVYrVnh2QlpSdFA4aWlsNy85cnhLaXRSRG9YWW5uanBrMDdK?=
 =?utf-8?B?VmZTNjYvOVNQaUo1dmViL1BJRXFEeG5ndFZFWkg0UWNyd2pDWmxVWDJGM0V4?=
 =?utf-8?B?bXNMa1R6ZW9oeWxHRTd4QjZCVWR1QmUwbTFMU2RSZjVLNVB1V2FlcGhGc2VV?=
 =?utf-8?B?OFNBOFBmN2JYVUlzR1BSVUg0SzZ6WjdHZ1lpS3FLMGNyT3BJTnFTOUJyWGV1?=
 =?utf-8?B?RS9KVjd6K3g3QXhKR3dpRmtZWEd5K3RJdHpWRDk3OEVKMmZONjdIUzFLTnQx?=
 =?utf-8?B?ZGxkeVJ5VkMvazVVQUV0VWFtY3pyb0FFdGxQTUJ2TzE4MVpYcWJHaUxWcTNq?=
 =?utf-8?B?V3lNSjcxamhHL2hMRXhxbkluczlWYmZmcmp1cm50Vk5keDNWL2lpMHpBVHNt?=
 =?utf-8?B?emdRTDFqMGhYdjNud1YzcXlKanYxZEIycVlPT0s4NmZvNUhiVDlaWFlYZUE3?=
 =?utf-8?B?MS9SbEI3RjF3UkpaRmQwRDhtSXh2K20rVmwxcGZnT2hYdFQzcmEwaUgvV1dM?=
 =?utf-8?B?MmVCKzA2UEtPY3hpaE9RdW5JUlRsYzJOcUdOVE1GSWlJdmpXTEpHQS9TWXJZ?=
 =?utf-8?B?alJRRkd6UCtHZys0UVVwRDZmam1YY1Fwb2tDbkZydkhmRTY1ZHVHQjFUbXd4?=
 =?utf-8?B?MXZBWHJ2aGJoL0xXSjFuUFBlZ0dYMXpFVHN2dkpGNXpKdG45KzJ6UzhuQXhk?=
 =?utf-8?B?R01Ud3Uzb3FCT2lsQXdPRTc4VHRJbUpXVWEyRnppVERCY3BxR3FERU5oWU5U?=
 =?utf-8?B?R3V2NllwRFJNd0hVZ0ptcjdVcEprTTVZMFYwSEpkVUhmeHV0V2lmeGsxQ2Jl?=
 =?utf-8?B?a1doNG1SajhtY3RDNWIyRmRhMnpjOERnd21xRG40M0hDMDdkcXdDQ1REbFlo?=
 =?utf-8?B?MjNxMTdMNUtDUkFJUUw2SmR3YnNoVS9CWHpNVzl5dmdkYmFKS1pWUFh5MVV5?=
 =?utf-8?Q?ZDDZXmGxbgO/9QIe/RiC0KC2U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a80566b0-7e4c-4d69-b5fb-08dc8544256a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:44:51.3959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqPbiNW494JxNruKngFX9hIc+zaSUf7hVxa0BZy7qvoTnrxhoJUCfi90x05VFCXOKJGaUSmVmup6ZrR4d93fKeWfo9ph7LJNQKuPBxJf9hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8393
X-OriginatorOrg: intel.com



On 04.06.2024 17:57, Mengyuan Lou wrote:
> Add sriov_configure for driver ops.
> Add mailbox handler wx_msg_task for ngbe in
> the interrupt handler.
> Add the notification flow when the vfs exist.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---

Only one nit
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 31 ++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  2 +
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 58 +++++++++++++++++--
>  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 10 ++++
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  2 +
>  6 files changed, 101 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> index 315d51961449..6d470cd0f317 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> @@ -944,3 +944,34 @@ void wx_msg_task(struct wx *wx)
>  	}
>  }
>  EXPORT_SYMBOL(wx_msg_task);
> +
> +void wx_disable_vf_rx_tx(struct wx *wx)
> +{
> +	wr32(wx, WX_TDM_VFTE_CLR(0), 0);
> +	wr32(wx, WX_RDM_VFRE_CLR(0), 0);
> +	if (wx->mac.type == wx_mac_sp) {
> +		wr32(wx, WX_TDM_VFTE_CLR(1), 0);
> +		wr32(wx, WX_RDM_VFRE_CLR(1), 0);
> +	}
> +}
> +EXPORT_SYMBOL(wx_disable_vf_rx_tx);
> +
> +void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
> +{
> +	u32 msgbuf[2] = {0, 0};
> +	u16 i;
> +
> +	if (!wx->num_vfs)
> +		return;
> +	msgbuf[0] = WX_PF_NOFITY_VF_LINK_STATUS | WX_PF_CONTROL_MSG;
> +	if (link_up)
> +		msgbuf[1] = (wx->speed << 1) | link_up;
> +	if (wx->notify_not_runnning)
> +		msgbuf[1] |= WX_PF_NOFITY_VF_NET_NOT_RUNNING;
> +	for (i = 0 ; i < wx->num_vfs; i++) {
> +		if (wx->vfinfo[i].clear_to_send)
> +			msgbuf[0] |= WX_VT_MSGTYPE_CTS;
> +		wx_write_mbx_pf(wx, msgbuf, 2, i);
> +	}
> +}
> +EXPORT_SYMBOL(wx_ping_all_vfs_with_link_status);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
> index f311774a2a18..7e45b3f71a7b 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
> @@ -7,5 +7,7 @@
>  int wx_disable_sriov(struct wx *wx);
>  int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
>  void wx_msg_task(struct wx *wx);
> +void wx_disable_vf_rx_tx(struct wx *wx);
> +void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up);
>  
>  #endif /* _WX_SRIOV_H_ */
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 3a7931c2e4bc..b8f0bf93a0fb 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -87,6 +87,7 @@
>  /************************* Port Registers ************************************/
>  /* port cfg Registers */
>  #define WX_CFG_PORT_CTL              0x14400
> +#define WX_CFG_PORT_CTL_PFRSTD       BIT(14)
>  #define WX_CFG_PORT_CTL_DRV_LOAD     BIT(3)
>  #define WX_CFG_PORT_CTL_QINQ         BIT(2)
>  #define WX_CFG_PORT_CTL_D_VLAN       BIT(0) /* double vlan*/
> @@ -1102,6 +1103,7 @@ struct wx {
>  	enum wx_reset_type reset_type;
>  
>  	/* PHY stuff */
> +	bool notify_not_runnning;

maybe notify_down?

>  	unsigned int link;
>  	int speed;
>  	int duplex;
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index e894e01d030d..583e8e882f17 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -14,6 +14,8 @@
>  #include "../libwx/wx_type.h"
>  #include "../libwx/wx_hw.h"
>  #include "../libwx/wx_lib.h"
> +#include "../libwx/wx_mbx.h"
> +#include "../libwx/wx_sriov.h"
>  #include "ngbe_type.h"
>  #include "ngbe_mdio.h"
>  #include "ngbe_hw.h"
> @@ -128,6 +130,10 @@ static int ngbe_sw_init(struct wx *wx)
>  	wx->tx_work_limit = NGBE_DEFAULT_TX_WORK;
>  	wx->rx_work_limit = NGBE_DEFAULT_RX_WORK;
>  
> +	wx->mbx.size = WX_VXMAILBOX_SIZE;
> +	wx->setup_tc = ngbe_setup_tc;
> +	set_bit(0, &wx->fwd_bitmask);
> +
>  	return 0;
>  }
>  
> @@ -197,11 +203,25 @@ static irqreturn_t ngbe_intr(int __always_unused irq, void *data)
>  
>  static irqreturn_t ngbe_msix_other(int __always_unused irq, void *data)
>  {
> -	struct wx *wx = data;
> +	struct wx_q_vector *q_vector;
> +	struct wx *wx  = data;
> +	u32 eicr;
>  
> -	/* re-enable the original interrupt state, no lsc, no queues */
> -	if (netif_running(wx->netdev))
> -		ngbe_irq_enable(wx, false);
> +	q_vector = wx->q_vector[0];
> +
> +	eicr = wx_misc_isb(wx, WX_ISB_MISC);
> +
> +	if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
> +		wx_msg_task(wx);
> +
> +	if (wx->num_vfs == 7) {
> +		napi_schedule_irqoff(&q_vector->napi);
> +		ngbe_irq_enable(wx, true);
> +	} else {
> +		/* re-enable the original interrupt state, no lsc, no queues */
> +		if (netif_running(wx->netdev))
> +			ngbe_irq_enable(wx, false);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -291,6 +311,22 @@ static void ngbe_disable_device(struct wx *wx)
>  	struct net_device *netdev = wx->netdev;
>  	u32 i;
>  
> +	if (wx->num_vfs) {
> +		/* Clear EITR Select mapping */
> +		wr32(wx, WX_PX_ITRSEL, 0);
> +
> +		/* Mark all the VFs as inactive */
> +		for (i = 0 ; i < wx->num_vfs; i++)
> +			wx->vfinfo[i].clear_to_send = 0;
> +		wx->notify_not_runnning = true;
> +		/* ping all the active vfs to let them know we are going down */
> +		wx_ping_all_vfs_with_link_status(wx, false);
> +		wx->notify_not_runnning = false;
> +
> +		/* Disable all VFTE/VFRE TX/RX */
> +		wx_disable_vf_rx_tx(wx);
> +	}
> +
>  	/* disable all enabled rx queues */
>  	for (i = 0; i < wx->num_rx_queues; i++)
>  		/* this call also flushes the previous write */
> @@ -313,10 +349,17 @@ static void ngbe_disable_device(struct wx *wx)
>  	wx_update_stats(wx);
>  }
>  
> +static void ngbe_reset(struct wx *wx)
> +{
> +	wx_flush_sw_mac_table(wx);
> +	wx_mac_set_default_filter(wx, wx->mac.addr);
> +}
> +
>  void ngbe_down(struct wx *wx)
>  {
>  	phylink_stop(wx->phylink);
>  	ngbe_disable_device(wx);
> +	ngbe_reset(wx);
>  	wx_clean_all_tx_rings(wx);
>  	wx_clean_all_rx_rings(wx);
>  }
> @@ -339,6 +382,11 @@ void ngbe_up(struct wx *wx)
>  		ngbe_sfp_modules_txrx_powerctl(wx, true);
>  
>  	phylink_start(wx->phylink);
> +	/* Set PF Reset Done bit so PF/VF Mail Ops can work */
> +	wr32m(wx, WX_CFG_PORT_CTL,
> +	      WX_CFG_PORT_CTL_PFRSTD, WX_CFG_PORT_CTL_PFRSTD);
> +	if (wx->num_vfs)
> +		wx_ping_all_vfs_with_link_status(wx, false);
>  }
>  
>  /**
> @@ -723,6 +771,7 @@ static void ngbe_remove(struct pci_dev *pdev)
>  	struct net_device *netdev;
>  
>  	netdev = wx->netdev;
> +	wx_disable_sriov(wx);
>  	unregister_netdev(netdev);
>  	phylink_destroy(wx->phylink);
>  	pci_release_selected_regions(pdev,
> @@ -782,6 +831,7 @@ static struct pci_driver ngbe_driver = {
>  	.suspend  = ngbe_suspend,
>  	.resume   = ngbe_resume,
>  	.shutdown = ngbe_shutdown,
> +	.sriov_configure = wx_pci_sriov_configure,
>  };
>  
>  module_pci_driver(ngbe_driver);
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> index ec54b18c5fe7..dd01aec87b02 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> @@ -8,6 +8,7 @@
>  
>  #include "../libwx/wx_type.h"
>  #include "../libwx/wx_hw.h"
> +#include "../libwx/wx_sriov.h"
>  #include "ngbe_type.h"
>  #include "ngbe_mdio.h"
>  
> @@ -64,6 +65,11 @@ static void ngbe_mac_config(struct phylink_config *config, unsigned int mode,
>  static void ngbe_mac_link_down(struct phylink_config *config,
>  			       unsigned int mode, phy_interface_t interface)
>  {
> +	struct wx *wx = phylink_to_wx(config);
> +
> +	wx->speed = 0;
> +	/* ping all the active vfs to let them know we are going down */
> +	wx_ping_all_vfs_with_link_status(wx, false);
>  }
>  
>  static void ngbe_mac_link_up(struct phylink_config *config,
> @@ -103,6 +109,10 @@ static void ngbe_mac_link_up(struct phylink_config *config,
>  	wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
>  	reg = rd32(wx, WX_MAC_WDG_TIMEOUT);
>  	wr32(wx, WX_MAC_WDG_TIMEOUT, reg);
> +
> +	wx->speed = speed;
> +	/* ping all the active vfs to let them know we are going up */
> +	wx_ping_all_vfs_with_link_status(wx, true);
>  }
>  
>  static const struct phylink_mac_ops ngbe_mac_ops = {
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> index f48ed7fc1805..bb70af035c39 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> @@ -72,11 +72,13 @@
>  #define NGBE_PX_MISC_IEN_DEV_RST		BIT(10)
>  #define NGBE_PX_MISC_IEN_ETH_LK			BIT(18)
>  #define NGBE_PX_MISC_IEN_INT_ERR		BIT(20)
> +#define NGBE_PX_MISC_IC_VF_MBOX			BIT(23)
>  #define NGBE_PX_MISC_IEN_GPIO			BIT(26)
>  #define NGBE_PX_MISC_IEN_MASK ( \
>  				NGBE_PX_MISC_IEN_DEV_RST | \
>  				NGBE_PX_MISC_IEN_ETH_LK | \
>  				NGBE_PX_MISC_IEN_INT_ERR | \
> +				NGBE_PX_MISC_IC_VF_MBOX | \
>  				NGBE_PX_MISC_IEN_GPIO)
>  
>  #define NGBE_INTR_ALL				0x1FF

