Return-Path: <netdev+bounces-108823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A621925FBA
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8F2B3B248
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEF61741F9;
	Wed,  3 Jul 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZ038jr3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343521741F4
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004958; cv=fail; b=n3elXcOxNcoA9a7FI5Iyj6NeCAOh7LHqEX+87dbnKQUMK3dmhptv6rFBsUTQ5f5GKVKybS/gSyni8VSGZ6qZrQvUcXadDB02aZZ9XDuBaOkqKKHQVo2kSxcu9XQYXPnOhOlKdjdIlXLYQXXyumi4zJNOuqyXQMEK9Xt4kOGm7aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004958; c=relaxed/simple;
	bh=+7LBwGCYTv+bncN0jXptSR2/ljKj18sOe40f3hG8w3I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HCwaRHS1+pEirDH/Njy2sB+GxoSQ9TXaGesmEdBVSlpPi7o2dGdINOnjkHnvIsGzFTzHDuxyNk9twd8FVuCJDZXBiP6gYAg73kHwtPo1/KPKYkW9jHGHuZAtU22j5G0fmLzaK27Af8WtBjNM2eS/AgGeH5+T4S5vOrv1xMabOiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZ038jr3; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720004957; x=1751540957;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+7LBwGCYTv+bncN0jXptSR2/ljKj18sOe40f3hG8w3I=;
  b=mZ038jr3vIRb4l/eXYbTUlsWLUGtN1+A6IOxWda9KrN4i0MGTjr2Kkm3
   fjRsSQC8OICjjRIUfQXHU4Mnu+oBuZcUQyh7GlGuKTowOgEWDv/rBiLQA
   oTzL/iG8QwVU9x6X4emIAOXoakXOFBKVc8fjKvz2Z/HRL0W8NipsZkRlt
   AtiZKKv2S2yX6N1mH/83BaTPVnFKBEEXkmypGepopN/5ZKriYMxS78P9M
   EpjWfaks2YkxemSh2JcendtndEuXnW08bnr7zcDm0lfI1MiEa96wABz/P
   gHLDSH6jTUG4HGCXg4fmCZreNaA3HgnwxYYT0vKFOZjmCqXc3Fqfk2EyH
   w==;
X-CSE-ConnectionGUID: W8gOcQcbQxaUsWdWSX7HZg==
X-CSE-MsgGUID: 1DQwdkvNQUKZ3u7nA0xrIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17346556"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17346556"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 04:09:16 -0700
X-CSE-ConnectionGUID: 8LAHXpoNRG6E4KZ4HC9SVQ==
X-CSE-MsgGUID: Syrs7JhAS2ulBQutc9ZntQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46001043"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 04:09:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 04:09:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 04:09:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 04:09:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 04:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zlf+VFc5eQt4xJnUL8HErIvuMTAWnOfJPEC4W+ukTVjFz+hCX2lFWLbwf2X/pL4JAGVMG2zzaiz7r715maVQ4/4m9KvG1GBXfEGmpUYZ0WTHnbmLL+YXghI8SkbDVoN4KvehrTRQdObtghKJz0waich2lMFptpuz0mbfG78TyG4Nbx4CYnvriKDDjj3dBjEMHcQTcBG7WDVH5wl+lxjn8grNi6qQmPhVVMVBfEdoWZu607Dx/zkCskkskcmj/QTsMHBU9QUtCL4GL1HaYm6eSfuTLWYfSxlRUjxg9BYzODPH93A997WyDYP0FtSvMOsm4PWdFGSVEHvLYMlCRiE4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwTPh8E97397hLAfoMGdqwxb+9XS9HIRbGMVD1KFSlg=;
 b=amZj8F7+WAtoP8ZDZ5uj41J3RzBaXaTous1XGhlqgBAWKOhPjWLEuMq46eV4871763LP3RsUlEAW1zzXcQR79OqgyycO8KWENy6fMAlwMfubrFM39YAPlDFvedcuceNy3QcdWcgGhmEGQO7BnGjiRfRftUQwufFeflUFl3oZqPH/2C7fvNHiIlWP6zwsTqBkDeuEZjwzVOHogptj1ob2yXOQ+IMy+RFcrsRLz2MbbWk2ferrQPqoMN5rIj05RQer8JlwZXtSwXsDwwGTB3O6DjtVuRd/yp+9eK/BqJKTKpGruUcFOILm0tsIimGkdtKLUzA36+kiLoJcXKifO5bFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 11:09:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 11:09:04 +0000
Message-ID: <ddc6c983-6975-4c6e-a612-74d957b01738@intel.com>
Date: Wed, 3 Jul 2024 13:08:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/11] eth: bnxt: use the indir table from
 ethtool context
To: Jakub Kicinski <kuba@kernel.org>, <ecree.xilinx@gmail.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<michael.chan@broadcom.com>, <davem@davemloft.net>
References: <20240702234757.4188344-1-kuba@kernel.org>
 <20240702234757.4188344-12-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240702234757.4188344-12-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: e072f8bd-f1bc-4f72-88d4-08dc9b508d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEhGaDdZNE9CWGZMb1NoNWdEMGFXckk5R3FMdWxtVHB6Q3pMbmNDdHUzcWFj?=
 =?utf-8?B?T3lWbG9yeE90VjlPUms0aVZWalVLL1hRY3lqV0xMOE1LUSt3NldWZUVyRUVn?=
 =?utf-8?B?RTc4dng2TDBZelA1UlNDWjRKVjJmN20wbzJRVXJESU1mYUo1WnN1bjg1ZmZm?=
 =?utf-8?B?U29lajk2RlBDQlFjUktlaHZTVjg4bUFpM2xOdDNhWlNqN25FVHhxbDgzUDlY?=
 =?utf-8?B?QVRiSTJ1ckRBZU1zWW0rbFJGR3MvMEVHZlY5VzdVbjlOMGtwcnhTa2pPOWh0?=
 =?utf-8?B?STB0TEEvV2cyQis2TmExZ2E5VEJmc09NMUQrOElzdXp6UTdwQzh4WitTTkhO?=
 =?utf-8?B?bVphSG1iQkVsakhZclVsYzdUblU4UGVXbGxoTzJEdysweko5ZHZmaVJlRjVQ?=
 =?utf-8?B?K3pSajVjajZ4VFdpa3lYT0p4bXdHQWduSFgxbExhblBsayttMEhCdDNSemhY?=
 =?utf-8?B?YWdRaVlhc1NnMUVNdUxiT2VSendBdTIwUDYwWWtnS2h2S2Vab3dieFR2U2p6?=
 =?utf-8?B?VmZ6Q0RPV2szU3h3VmNYM1dWaXI0amR3YUlITGZZa2hqRzFDQTJFTVZCVDRJ?=
 =?utf-8?B?TDhLMTgyajFUWmdvWHk3S2s0Kzg1TDNkRGM4UXdPVWVGcnB3WFlwcDhmTGNT?=
 =?utf-8?B?YU9sMjZQM1ZzanZEdGI1VEJ1cEUyTzBtU1VHYlRPZk1hMDJORGlJRVh5WlJt?=
 =?utf-8?B?WjNvbi8wZXlmbmJscnE0RFNmdFFSTEdCY3lWRjk2aGkyenBOWnVoMVZTWS9t?=
 =?utf-8?B?T1NYTmNNSUJ0YW5HdjVmRG8zUkhqUDZGVlJrVVQrOFcrTG9vM25GVEpHQm1z?=
 =?utf-8?B?Q21xUlpsNXZza0hGbkVFUmNDQXVlTlRnRjdjZWIrUjkreXQyRlJKM3hTNFlu?=
 =?utf-8?B?MFR4TGkxeU9icWlFdk8rUGxNWXd4c3BVKzJ5UkNQTkFRMkhQVkJZVkJ0MXMy?=
 =?utf-8?B?MVc1cmFURFFUUjBzRGlncjdZQ2VPNE91Y1I0a0sxZVdYUHBNSE1uRVNINFQ5?=
 =?utf-8?B?OHdGMTM1blU3VG1JQjhMVGxBUG9ZWWtENzRZdVNQSWpvM1B4dTVxeXBvQ25u?=
 =?utf-8?B?cXNaUGllOWZoQnYzMXpaZmkvem9OakxLdXFsZzRlcTZpYnB1V09xbG1lZCsw?=
 =?utf-8?B?K0NTeHp0UlQwRjJOL05ka3AzY3pacEJSQVVvZUpRVXh6SVNWNWRkWGNlMGkv?=
 =?utf-8?B?di9zVjFxd29yTEs1c0tYZDc2Z2l0UlVKcUVaK2VPcTlZZjM5T2V3bjRadHhT?=
 =?utf-8?B?LzF2VTMvYlUwb0pIUjJwWSt5NnhzR09tTU9WSHlnSXFwMFhvSWEySzJYMjFy?=
 =?utf-8?B?aTFTeWlUdEl3S3FZZ2Y2OXJNeG5zTUo5MldLL01kc25DOExPNm9vaVZuREg1?=
 =?utf-8?B?a0VERE9JRVNOZ1dYdGNCZmVYS1V0b3k4ODJackhYK280Wk13MFdDVlI3QkZp?=
 =?utf-8?B?UmlIeWdCRjIwYkJLbGdoay9WUXMvZTBkSTBsUlY5RzhEM3dxbnVoNWtCMm1r?=
 =?utf-8?B?WmFBRFhnOSt5ejhpaXBvWE0raG94czZ6bVpCcUgxTHhMUmt4ZjBhUVpWdXps?=
 =?utf-8?B?MnE4cm1RVFE3dWNhV1lJV2sxMG5SUzBPU2VPZEJnVitxWDFIbzBySkdhTWE5?=
 =?utf-8?B?elVJLzlpK1Z2ZGRSRW9CZjNUSXlNc0JqOUUyNm81QWc4d3BBaFQwR1o3UHZo?=
 =?utf-8?B?Yzd1TEhkd0RDdHgyNHFGa1ZOY0VsNU9sN3U4OG5JcUl3ejRJNld6VkdaZFpz?=
 =?utf-8?B?Uy9ucGNRNnFVZ3dOSlgvb090L0FQbTJ2UkxuNDlRSW9YRmJQdGJhOEFWTEtv?=
 =?utf-8?B?dUU5R2JTb0lTTlRZV0JjUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXJZNmVpSVcrVGNkNXF5TXFoeTFrdWY1d01jNEdMSDJJZTdQY290NHJiV2h0?=
 =?utf-8?B?am9nQTlZem1FUkc3UXZsRjZmTzFjVWd2TENZSUhXd3k5R0pCODdRZzlFVUdh?=
 =?utf-8?B?NXJXdzQ4clNXTEpvaDRyZ2J6S3d4Mi9ucHo1UXRHbFVoVktYUkM5S2x0TDhn?=
 =?utf-8?B?Z2tXRVR5emxRcGNHOG5mMmdEZDRGamt3cXpDbVd4UkxoSm9qWFVRejdHRW9h?=
 =?utf-8?B?UEN2Z09DYVpxbHRWSDBLeGtnU2dKcGZ5YWZWMGprRTlmbUo0ZnFMaE9tdkRB?=
 =?utf-8?B?RTc4MHB6R251bGtXUk5FN2NjVk9YRVVaT2Z2ckthRU9Rb1NDK1JpSU9BYWNI?=
 =?utf-8?B?V3hHWWg0aUlEaVpmUVZhSXdBbUVKSVZjMGlicHZLQ1V1NjFRZndidjVJTUQr?=
 =?utf-8?B?bGlVanhHNjNwZ2lWVXI0dmRwMzdiS3dVOW5wMHRpTTFkd0VVaGx3ZnM5eC8y?=
 =?utf-8?B?ZmVkY00xenR0dXd6MHdENDV5QTlSN1M4Wmtab1E5M21qR3ROWUxsM1VEbDhE?=
 =?utf-8?B?cVQ0VzJydzJPaTAzL0Ntbnc2QTRXdnd5eEFBUW5yVmRJVzFxeHVtVUFlanpK?=
 =?utf-8?B?STVJSnRBQ2NQRG45S1FjOUt3RkhxdCtzM1E2dGg2UjF4RFlOczh1MHNNM3hj?=
 =?utf-8?B?cVU0YjZoaVFpTlNzZlZnR0pBS1p6OVlsUjJkd0dzelBXR01BMm5vdW9BeWZt?=
 =?utf-8?B?MnJ6U3RNOEJjMUR6TG5qK3Q1NUUvaWtkSDBkWGFMRCt6OWxHVDhxdmdkaS9G?=
 =?utf-8?B?ZUVjaWFhcTRVNHhtQm9qYVhNSi9rSk5CR253T1lCeFdub2JDZ28yL3h4Ym0x?=
 =?utf-8?B?OUJOVmxoeUVoeFZOUEgyeWd3RFN0MzlTKzE1YzM3MXArcXA2VENkWEZGTjI5?=
 =?utf-8?B?WEEyby9wcW5waUMxdUVGbmhCZGFyeWdndlR6QTZncGZoWHlEc3NSQWxYVDN0?=
 =?utf-8?B?dklTWTNmT0VyQVF3MXhPS0s5Y20vL0xVbEVueVhNcG9NNHhydEJXT2Y4d3Ey?=
 =?utf-8?B?b21ROENac0JCd0NrMjhOYVFWMjZIczRTbk1mV2NySyt3YjdmOHE2Vnp1VEFX?=
 =?utf-8?B?VWhGR1RsT3I1UmNTL1hmNWxMaHR3MFIvTzRteE40K29sZWRUWnVIWk5ONERH?=
 =?utf-8?B?bnA0dElna1dXTlJqL29GTzc4VGhlcFBxd2dOSkJlSWJRd050aWNvMGtLeFph?=
 =?utf-8?B?SndrdE13dFNOcEMrUjZPbWVNVHhndWRZUjhLKzVGN1Y5QXBETlVSdmNjU1U1?=
 =?utf-8?B?cXp1ZTBiY1crUjMzZDBnQzZ3YnkvOVd0RVNSanhsV1NqKzdFWFpDRmFQWDE4?=
 =?utf-8?B?T2d1akUwVlRSQjR5UGphVFZJRWEzRTdmM0dFVEYvMExWVjJmdm1xOEJ5QVQ5?=
 =?utf-8?B?V2g4Wm01Z2p5OU5GOHpaZ3A3eG5WS3hhK09PSFh3T2xMSlpySFRab0orVmhK?=
 =?utf-8?B?MlI4R202a3gzYlpqcmZVRXVTaStWd2NUbXdnSUpRZlR4SzNIRFk5bDZCUUpG?=
 =?utf-8?B?a3pEcnptK3EzZUVnZ2lxUi95T3ZIUDdkYks5Z1ZoSE53ZmYxSkFidFRXSHEv?=
 =?utf-8?B?WTJ3eWlvY2wxclE4S2hOYkNrSlBZbDBqZDNKamlZSmI5c0JXbCtBTFlQN0Rs?=
 =?utf-8?B?cVJZV2Q4ZGU0T1hNU3RKb0FRTVRoOUl5S0RkeGFjT05IRWlZTnJ0RWdvN0tz?=
 =?utf-8?B?aVNZNmhScFI3eWs3TEN1aG5ZNmpUL3JpUERkL21aenlZblQzMkFIMUdDQnVZ?=
 =?utf-8?B?dnNISzZMWW1xd2tYcnhGRUpiWjhKVEFQTFRjdnp6a3dlS3JoTTdtSXFkNFhQ?=
 =?utf-8?B?cCtpclgveE1aeTQzQ2lHRzh2WXZmeUpXRi9wTFZ2Qnc1OEVGdnZ5MG1jb3R6?=
 =?utf-8?B?dTBiZ0RRbjFvL1dTa0pKLzQ5anJlUWdKeVVNZy91S3RwSTdmME0vLzZRMFlC?=
 =?utf-8?B?S2IzWFNtdlYwYmIxK01ZQlBNaysrb0xqMUtOUERFS24xOGVtSEI0bk9zaXBE?=
 =?utf-8?B?bTZUOWZobGp2TkNTRmUvZFNpMzdURG1WZlpuY1UzaVVpcjdROWpZaDc2SlFy?=
 =?utf-8?B?TzA0SUxXVjZEcWhoRVVMMVF2bElHam9JU2x0RHNyLzFVcXB6bk9OOUR1cHhJ?=
 =?utf-8?B?Qkhvb1FGd0lxMGcvdTJIaTNmbmU4ME5VcFNJK0NIalpyanl5TXp4L2lSVFBu?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e072f8bd-f1bc-4f72-88d4-08dc9b508d19
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:09:04.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCRUk2X7IrHOlpRlXboaObH30AsDhGKyQfqS+h9w1wMUTpcPQXRrggzk41KeBbNekQOrOzWwplt0JOJlx0wUCnzG5aFDnuYIhB6+KGchxWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com

On 7/3/24 01:47, Jakub Kicinski wrote:
> Instead of allocating a separate indir table in the vnic use
> the one already present in the RSS context allocated by the core.
> This doesn't save much LoC but we won't have to worry about syncing
> the local version back to the core, once core learns how to dump
> contexts.
> 
> Add ethtool_rxfh_priv_context() for converting from priv pointer
> to the context. The cast is a bit ugly (understatement) and some

could we wrap flex u8 data[] array of struct ethtool_rxfh_context
in an union with void *priv?, then no cast will be needed.

but I still would prefer to don't abuse ownership over in-core data,
and just keep it as inactive there, at the very end this could be
moved to devm_ to avoid leaks

> driver paths make carrying the context pointer in addition to
> driver priv pointer quite tedious.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---



> @@ -190,6 +190,11 @@ static inline void *ethtool_rxfh_context_priv(struct ethtool_rxfh_context *ctx)
>   	return ctx->data;
>   }
>   
> +static inline struct ethtool_rxfh_context *ethtool_rxfh_priv_context(void *priv)
> +{
> +	return container_of((u8(*)[])priv, struct ethtool_rxfh_context, data);
> +}
> +
>   static inline u32 *ethtool_rxfh_context_indir(struct ethtool_rxfh_context *ctx)
>   {
>   	return (u32 *)(ctx->data + ALIGN(ctx->priv_size, sizeof(u32)));


