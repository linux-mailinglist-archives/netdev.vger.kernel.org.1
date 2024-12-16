Return-Path: <netdev+bounces-152113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11809F2B6A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448CD188AC27
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE6F1FFC74;
	Mon, 16 Dec 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7/SARBu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06511FFC7D;
	Mon, 16 Dec 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336016; cv=fail; b=K58BsAHeDO7V45hli9upWsivt6UwlV/Jdp+4W0ePskqC+qcVic2ilSUOh2627SSPHvvQiRpqoG3GlS5oXsgN6fP1M+3dY1Glyz9XaU9EOUZfGkyKUYNrp6zmShPSUYiAdDmQZT67ncjBZESsurunAZO0irqmUEmddevW6i73SSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336016; c=relaxed/simple;
	bh=bjpUK/RdyQ6UKSIASBLIowJrOz73RR1rhAW2HtrXkMo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iPSf7zR3INypmzzHUUJoISDCgfIxyM4wYJKmsdGrupzNA4BA1A+eEU3KOK0GKFY6XWECyxR5w35dFjwjWTNi4R/9uhUO0Mw3xTgtNmw9+Ht6oEiOiVJAjjv/1t5mdlaOABvmx+nqrYhMP+sbmdy3MM3JDLAA/575jLD8EPnIKvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7/SARBu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734336014; x=1765872014;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bjpUK/RdyQ6UKSIASBLIowJrOz73RR1rhAW2HtrXkMo=;
  b=Y7/SARBu2O8bQIF1liBmr1YQ7iDnZh60k5SFpZ0J9ryLZETgTIgBFsY5
   T7QVxd1ZS8FPSoTScq540MfK7DSIMvHLapIR53bvA1pIRih6SO22i/e2h
   BN+5kKgyDSvEX15zm9BTc/dlLeqqJE1UFAnycPVg+A4BzlFXMe/onURyq
   YfF2FCDplStarh4GPtTwgym+dkp/lnbxP9dGRxu8g2ItpQGymkfAptwIw
   WTb+jHDXTtfOx9ocYnzT1S0wCNMwISv/dIONOCLudN72DtG+NepwdIGNw
   FFL7+IpHbMS7mgWmVBbgf2QqttAqEEQHwSrOg+OTvSPlSMYhmSqH0ZUd6
   A==;
X-CSE-ConnectionGUID: 3g2zB4g5Smu+Ngd/oX2qEQ==
X-CSE-MsgGUID: sLmmaiDGQoGyisljKyR0aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45712264"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45712264"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 00:00:13 -0800
X-CSE-ConnectionGUID: 0qcHlyu1Qa6EG0lyF9BW2A==
X-CSE-MsgGUID: +ZFMvscfTv2H1VCUJ4TSKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="96877158"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 00:00:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 00:00:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 00:00:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 00:00:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zo6Lcc9rgwfRRJwhX7ugiVZXjpvJUHEGGdVjlWcmmCEjlpxfSJV54g+hJdzxvh7B9WoAHXXmbv95nnqrDrIy75xZplPtTI4tkJSf4U4ZZdASRe5SX3Eq2h4qqgKh6jSHVMPCNLx1wN0bBaP9xDKfdkxAq/N4O4Ni41WidnbG1saDsQBVDJSgDDQSeSJ7ZazkqtZscmyRwoUUSum7Zztzupr/VxXwa0HQ0PhB+CjKm9aUc266EGR3IP2yUL15mSk39ATi2h77d73fkW0XnZTO0THw2q1k1hjJS+NrWkp+T4L5HT7eGde2XPP4YPbtRWmJLb9uTovppOvQTog+r5OszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdQh+2gPKkaf5NifBRhZXeWJoc6PXuN+WssPjx6JrYc=;
 b=AefrT9RqFwKJiq3H9q8b0mcxkEhAlI5ehlDmOoCBAcIrToYxpw65alTlutSSWPuMxB7x9ZkJxBc7hNUbGjXPuOvrSaHOBmjTM9fczlY8OCSiCSNtlTDuuCXYju5J9EodryJoTN1yY2P8zeopt2UXOno4yE2CumH8314DpH4WIfs5kmTI5n5kdKdcoeY/FZRdW1TnHx+Wyb5vOEsfp+asNkLIB9h2s6TKSXkLhk7pG9ncxR1qRvhAPfdhcHB8o3N0VJuxVnzKvwnXku8GoEJ7+pt4LwIBdBwzI8Tn42PdrOlhtdo2Flny41ZXn6NgxZzt0TuN6BsTJs7f4tx49p984Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 07:59:42 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:59:41 +0000
Message-ID: <1fbcfdd7-e2ad-450b-8670-df67132e9de1@intel.com>
Date: Mon, 16 Dec 2024 08:59:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Staging: rtl8723bs: Remove unnecessary static variable
 initialization
To: Junho Shon <sanoldfox@naver.com>
CC: <dsahern@kernel.org>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241216061625.2118125-1-sanoldfox@naver.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241216061625.2118125-1-sanoldfox@naver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0034.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ2PR11MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 619a6646-3e4b-4b52-7664-08dd1da7987e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qy9DYUhLQnA5TDN6VXFGbFM1ZUZQN0lZRWljWld2YmlXczNrdURkaVZibCtD?=
 =?utf-8?B?cC9NSk53ZlhTMzFUUFljS2p3S0p5TFZCSXRNdEpHanV3aFpVRzl2WmhVNE5t?=
 =?utf-8?B?Q2sxcVA1a2VnNjYrdVZqcUxqTnVVOXZjLzJ6UGJob1RvUW1BeFljZXFMWDNw?=
 =?utf-8?B?MVRTTFh4V1RFNm5XK1hWY21IMDJEMkIrL2Rid0VDS0dqZDF3TGxlS3VyVjFx?=
 =?utf-8?B?TWk1TDlSZTNCZkdldU1KSEVMZlZOd1hTaDBwYXRGblFGbVpodmtic29yRVdk?=
 =?utf-8?B?enN0ajJkWHJXOFA2OXJsZHdING9xblFYZ3dxazEyWnhOVWdtN29uYThnVXBY?=
 =?utf-8?B?K2JUWWgxNm9SN2VPRTd3TEJDV3pYcHBIdnpjU0ZDVUJSU29seWw0RDRLWVpU?=
 =?utf-8?B?Z1VSTndQTE5VdnNvWCtnR1RnZGdpQW5qRlJVS09ObU85ek5jUTcrTnEybEpz?=
 =?utf-8?B?bW8zbHhoWDI3ZU9BdWtVeTlrdnltajU3Zm41d0IwYnAwRHRYeHRYWkhQNFUv?=
 =?utf-8?B?c01pdEZ4eVZHd256eFNzVHU0WjllWUxQTWJHWDR6MUpoZ2xvTThscjlrTGJ0?=
 =?utf-8?B?WEtHQlBjejJuMHBKQTRITUlweXF3dTh0QkFmWUpaV0E4cVdIckJ6amxJTXV4?=
 =?utf-8?B?UjNOYkRpVDVXQlI5ZXRyaVFqalJ4SlF3djFBTUVOcEVhZTlIV2E3dFNvQklX?=
 =?utf-8?B?NFdjeTFVN0hHTVhpMmhLNnp0NmZ5RGtBWFNhMG9jLzJLL0w2QXNlTnJGMTZh?=
 =?utf-8?B?cFV6N0dCT1ZlL2FJcURlZVgwMVVrWFpnUlFxcDZYRzFQT0NDbjRaM1dWQVlp?=
 =?utf-8?B?WnNOTkxNR1hjYUV6Yy9teGtFTEJKdityT29PaUYrdHB2NlFpcXUwQ3pqeVBF?=
 =?utf-8?B?UXJESFlkbXk5NGxFa2ttVC85VW1YSnl1emwrN1hIeFhNN0grQThjMDJRbTUz?=
 =?utf-8?B?VE5TQ0lpRkNVcG01QTJoUEtFdTJDSVNESVFmQThNOGFoVmQweXcyc3E0MjVw?=
 =?utf-8?B?VFYyOTE0U3dwbkxqQzAvTmpqRkhvTlF1TndQUHRhaTRBdXdUZmllWFVYTnU2?=
 =?utf-8?B?ekkzQlEybnErcGp5azJKT0poRGt6Vi9sUWZTdUJkQjBWd0NIV2tSL3haREdy?=
 =?utf-8?B?M2JxMU11WG5wK09QVkhPOXBQZXZmajEyajlvRFF6aHFscG0yYUs0Zi9WclRK?=
 =?utf-8?B?WEZ4d3ZkdEk3YzVEcHhjd1hGRndWb1pmbE1HWDVEeFJvbDNESHhoYWNBRzVi?=
 =?utf-8?B?Mjh1UGM4akxvQUtFR1d2bkY0MTJxN3U3MWpTaDhQL2t2RzlPR3EzblZxcHg2?=
 =?utf-8?B?MVk3MXlJeFpCZC9tV3VobVhWSE9DNHRQRU8ycmRSMWdlMWxMM1RybkM0K3kz?=
 =?utf-8?B?VVZqS0FLL1dlNFBOejRIM1ZKREtpUGhQWFVNdjNJRjhLYW5HYWxJUWdKU1hp?=
 =?utf-8?B?RFIreFFRWGN5eWpQYk94ajkxTWd5RzUyVjR1UEY0Wk1XTmxPWVFFRmc5QWlk?=
 =?utf-8?B?UndPZVFGSnJ6ZUxJT2ltSXozMmlyaWJDSmNORlUyTWRacG5NQzFmcWF6eVQw?=
 =?utf-8?B?UHg4V2NZSEp0L1grNHM3YXhiRHFOLzhyT0grMTErNEpiQlEyL0tmVXpSYVdI?=
 =?utf-8?B?ZkZYWCtNR05aa1dqUGdXbXdEKzVpN2ozWTBQTEtOaHBORVZUOTdiMHdlWVJR?=
 =?utf-8?B?N0I4ZVJSdUJPU28vSE1ZZkJJRkY5Vm02bDBPd0RhOFJBOE1CbVNIQVZZVklk?=
 =?utf-8?B?M2dFeXZiaWM2UCthUEk2Q1pVWFM5ZW1FMFVtUVR6SDZ5aTZLcklFUkVHZTB3?=
 =?utf-8?B?b3NKRnl6Rk9UUFVwelhhMGlHMlJyV3pJTCtNQlBHd29ZV3N2YUd0M2dlTW5N?=
 =?utf-8?Q?Fc6S1XhKKjciz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJXZzZ2UlJJS2dzNDNpYUx2S1l0MlZFdHU0OFcwRVJ4Ymg0NzJVVVA4Rkla?=
 =?utf-8?B?bG9Ec0RTRXVmUEd5VnZQb1pRek1nalo5TFg5RGtBdnBQb1FMWExiSzY5cm42?=
 =?utf-8?B?YWxGNFllZUxFTGVDcVpzSkUrS09GMldNbkJzRDVRRitrR3U1M1Q0WmZNRlYx?=
 =?utf-8?B?UTZXMTF4TW9VZFFkalV5cEo3U0pINVVqL2dsNlBLaTNEeXp1UEFPRnBMZi91?=
 =?utf-8?B?OVpBRlBxbmEwUVE5bzJRQ3VJNERScHVURzlpb3ZWT3pjUEEySjZKTTdBSDZU?=
 =?utf-8?B?djAwR1FvcDlHWXNib1JSb1dSK0JwN1hteEpBem84OFZtbkE0THFqVmlyUFBp?=
 =?utf-8?B?TFdIck52MGFaaHVNcXNpdWUxeE9aVzlVQXEvMXJhVnhtcyt1S1dLYmdaalZk?=
 =?utf-8?B?aFNHY3Qzb2t4dkRkUmlDQzhzSysxaXF1a2JCaEk1RHYzbHBvcEpsMlpLQ2JL?=
 =?utf-8?B?ZGN5ODJtNU1CRmJSRmhPODlYaURGU1FYbk43dW1NdnZGRk9MemQzVzVyN3NV?=
 =?utf-8?B?NkcrQ2s2bnhlVWE3a25ZUEpiYXFvL0RDNkt5WGxJU3VyK1ZiRjNPS2NFZDcy?=
 =?utf-8?B?aG81elZYZnpENzhreGgwYXpZM1lUdlU4ZUxNS2xCcXBQSEVScGRMU1liSTBu?=
 =?utf-8?B?R0o4aFhQbWJiWmhTU2M4Q0dDVzV4NFFuMzBVVXhIdEhxbEcvMlhGMHUwVXNq?=
 =?utf-8?B?SXdpOU8zTFpXREhBWHRCRjB4cHhRa1BRZGNrSEZNTHlOQ3JMZVgyc01BTnp5?=
 =?utf-8?B?ZHlqV3puUWVoeVNwc0o0VkFTS2ZPdnRzT3FCQmdRNGQ2NkszK3FSTzN1TlhJ?=
 =?utf-8?B?TXg2cyttTStlbDUwSFNveGsyZ0M5VGkzbTFmUDZrbTZ0RnpGZURDZTlIcGdM?=
 =?utf-8?B?dDRjS0FUNHVldng4MHFOV282aXRWWk1JV2xyRk9XOFJFdUM0NEFET1pidWRv?=
 =?utf-8?B?MjBRcGFSUk1CUkZDUVZWUU5sanNnUVI4NkVXbHZkbEZnYlkzOWtyMy9BSDBD?=
 =?utf-8?B?RXNaOGNRdlBmVUNCSUFsQ0ZDYnJTbGxvNDdmR2MyYUJkSGpLZzJSNkxJQmw2?=
 =?utf-8?B?dEF3eXBLQjRBZzdmUnJCd1E5S1ZyWWV2OVZpeXk0RTVaZ05UaTJ0SFNiOFJp?=
 =?utf-8?B?NUZQQXB2K09CdE5GY2M0UWx1MDZLMllWQjcwOFhFWitBQ0R2VVFGaVB2cDRI?=
 =?utf-8?B?WjRxVU9BbDhQU3Fjc0VzNWJYOFRON3JzL004cFFMWHExOU41MzEwN0duYi9k?=
 =?utf-8?B?YkZyMElhTndPcE1uUVRveWhYQ1hVR1FXcFY4ekM1eUN6bFZMbkd1L0xiUHRX?=
 =?utf-8?B?RHpCVlEydkJMS1NYTm1xYlplR3J1VXNOQmFqRCtOcHgwZWRBWUd3bmRKdmJz?=
 =?utf-8?B?TEt1Qkoza2hzTmNKeDUwTWhXU3pMYVJIaHp5ZU1QT3F6OG85SFJJZjloeWVm?=
 =?utf-8?B?cXJKS2dQMmxIVGJhWHhaWEtESk0wdXBSZTdjTTJiMW05eXVtVHJQR050T3dq?=
 =?utf-8?B?R1RyWmVkU0gzeDJ6ZEVYYis2dzBsaUQ1UDg1T282QmtKeW1HMzgyM3dNRlVW?=
 =?utf-8?B?QTZibkgwcXh5NkhGT3ZVK0JrVzMyWDhyaERQSFdtTVlqUUppcVZnOWlVclB5?=
 =?utf-8?B?cnNQejNmc3I0SE5JZnBzbk5FT1FUYktNNi9ubHFOb3BrL2t3OVNpcWhhc0Vi?=
 =?utf-8?B?ZmY3QjBPRlFjK1NNTm9RSmllb0w0VEYrYmFXdE5rMVR0MXRZV3JxR2xHMVR3?=
 =?utf-8?B?VnVFNC9Eb1J0OHhlM2NjNUVvN0dxd3Yvb3F5M3dSdExhNE40aGRnc3NHMita?=
 =?utf-8?B?RzBCbWZ2dG5DclJ3OTROdVFVaHJjM2ttWmhwYXZEUzE0a3ZySkpRTGRUM1Yy?=
 =?utf-8?B?VUFRbzFIVlFub2ZEWWMxYnUwalVMZU15ZlZSQjVRblNYaUlSR1FNR0E0RjdL?=
 =?utf-8?B?ekNaZHFsanVWN1ZQb2YwUXFwaE5ZN0dzanJqVmljenRuUUM2d2pqK1ArWXN5?=
 =?utf-8?B?aFA5Uktqd3hDZzFQSE53b0dzMjhkWUpERTJPWkFGVDc5TjdnakpQcVJ3Y2hs?=
 =?utf-8?B?Wjl3Nmk4dzJQc1ZoOWtUNGZWUHZhZlI1QzZhK0gzYVhTMHFWcVg3ZUw0M3FR?=
 =?utf-8?B?UHFlTE1URTNUSHk1elhhSk5YL0M2czQxc1FLcnFoYTJPYnlqR0R5UUw2bTE2?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 619a6646-3e4b-4b52-7664-08dd1da7987e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:59:41.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/VKpRmOyQELnFIPQP40AKUYe1RLp2W85yXEWt+SSKxTXYX7Z8+arh9ac5p1QWVDid1owiBzkbKGD3VDuZVkVJ93CfBx1BLG9lVspwC2on4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8587
X-OriginatorOrg: intel.com

On 12/16/24 07:16, Junho Shon wrote:
> From: junoshon <sanoldfox@naver.com>
> 
> Fixed a coding style issue where the static variable '__tcp_tx_delay_enabled'
> was explicitly initialized to 0. Static variables are automatically zero-initialized
> by the compiler, so the explicit initialization is redundant.

Please don't post patches with the sole purpose of fixing minor style
issues. Also, the Subject line has wrong prefix.

Removing initialization of stack variables that will be assigned
unconditionally is of course a different kind of fix, still welcomed.

> 
> Signed-off-by: Junho Shon <sanoldfox@naver.com>
> ---
>   net/ipv4/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6..b67887a69 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3498,7 +3498,7 @@ EXPORT_SYMBOL(tcp_tx_delay_enabled);
>   static void tcp_enable_tx_delay(void)
>   {
>   	if (!static_branch_unlikely(&tcp_tx_delay_enabled)) {
> -		static int __tcp_tx_delay_enabled = 0;

Even if not needed, it improves readability a bit.

> +		static int __tcp_tx_delay_enabled;
>   
>   		if (cmpxchg(&__tcp_tx_delay_enabled, 0, 1) == 0) {
>   			static_branch_enable(&tcp_tx_delay_enabled);


