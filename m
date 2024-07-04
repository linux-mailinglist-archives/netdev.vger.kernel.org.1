Return-Path: <netdev+bounces-109115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B553892706C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87111C2261C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF71A08B5;
	Thu,  4 Jul 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOWG0MNf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C6FBF6
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077822; cv=fail; b=kdUWdcZXp5B1drbVuC9DSjzYDs1dvOWL4ESVsyeIJkPnBdoXfI7lZBLzr7llJQ+nfqVINc7W8nHVbLYfrZiBpgvodknGpIIkauv5SCShav/kOL20WcrmEvDgsdD00agKaOd0VOWCEoqHNakOgyJoDRi29Eo56G9hbGtTEQw3XgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077822; c=relaxed/simple;
	bh=Ofh6//yj0VrcYssaqJDh2dpLwDQbOlqLvpMInQZigmM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J4/9wM8bFlwPZfHvBgpjvqh4YXDaEDjDuJnrnFCJXLNEq6f7F1VJm4+8Z8pdJUP4BoX+TbeGIWQ0UiN/x2NxlVTLFx1tv49IuM+PC/cLMDjwid5Q4CXAyzmZzRZFgYXHNijoln6J/vuRLnvRviSSCMP0CubuLn3kwHJ5yEsWz/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOWG0MNf; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720077820; x=1751613820;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ofh6//yj0VrcYssaqJDh2dpLwDQbOlqLvpMInQZigmM=;
  b=MOWG0MNfdFxFwXC4yLjGyU4o/UVniv0KpBR+LcojTux7nADd8YoxxCK3
   qrnOPo1uNLj9lXhIEJZ1XkrCTXlK7OQ9wD7eqHl39VeAWtOpoFjyiMcEi
   5GCYiloYdk9NF4a2f6x5gGIJmS+VeJyqGkH5CAP+sZ2BUD40oJQ+h6WRW
   Ym7shEAbnutXpKpult82DCghq+p7/uuwLtZadheQtlmOidEyQzNEpymYI
   F/SQSSDZJCNdh5pn6c15FRo5rV9/w/x7JnEmZsua8Ji5abUzKrJLNqqII
   VaOLhjtctyCwyfZX6f3SDrAfxtH4L3r7SuAytSCkUMaOwDr58Z29U0ZWH
   A==;
X-CSE-ConnectionGUID: NQ60k4eKQHm6Vgr3shrsXA==
X-CSE-MsgGUID: TESW225oRHq3M4Un0y31Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17475875"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17475875"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 00:23:39 -0700
X-CSE-ConnectionGUID: UdaiDPtCTdizFLdazladEQ==
X-CSE-MsgGUID: ces3vr6BTkqT3ceeUYLNxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47165149"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 00:23:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 00:23:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 00:23:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 00:23:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 00:23:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQqBXLPR+ZBAkycq0kNqEaFX6U0c1Az9HRK8VPW9Yn1j3sd83P253LE40aqhEchOtUF+O1SxE+fov/NUBN5Ixh4EGqC/YiwkBbU/7l6uAmsVxMKnU6KqnDHQ4aireZaQOoLKnpO+hE86a7I7Rh4GzWJiy9Fr3M85pCHfsqXtKJINiTa9u14vRz0LPuP2vMn/dZVKj5b7YjyUoFSsNI0lApobVoxbNqVscKxyCd8CshjrDKHHlCtSHJJ4Gt1dukoGlrWoV9B1maMhCnv6gobBulzLnLD5s4TvW7iYOAyI+VjzrAXiW/bMxNhS7ma/roN6vxcd7GQZ/QSw6lXxdtPt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NraBkaiOKhjN2O6KekNtHjfKOyxvPfp8gvgbNWOVrsg=;
 b=KIMwUI687JeIaT3dZ8pwEHmi2xvaxeDuBTT7q2HjRBeQzEHqOAEhGzhkbg5clYHWPm2rt8wiIYc0SgUS8qnjExF55MNhr/WR52LkZQ+lDk8eBgJGP58mYpp0tZt6y8JdmO81GgzK7HHu69ECvNn14FeCt6coHNYUxfUpdvwmaSahTfZ8hq0zQFjHchl6GUq5P36iovXJvkWRRIzHLQrzY8V9vLVbHrrlxImhGBDgOvZ0zhwsY664WfbYfTDIB3RhRkysvN7sbetc/PaFyLP2ZYgbMN/6IaVN5efOUs2GtyU+xGLsJGS04hR4rRyiMNHBTUAPkYSGPwjr5HC9yhWz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.26; Thu, 4 Jul 2024 07:23:31 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 07:23:30 +0000
Message-ID: <5e2b3c47-7117-4529-a54e-e634d40b7763@intel.com>
Date: Thu, 4 Jul 2024 09:23:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next] generate boilerplate impls such as
 devlink_resource_register()
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
References: <4886830b-73fe-47f5-9635-0f3910c8e205@intel.com>
 <20240703175111.0832953e@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240703175111.0832953e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fba66ec-19b4-461a-2e5b-08dc9bfa346f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXdmUThYRUZBVVYyQ2xxN2NlNmk0TGFwaWkxWHpVNzVLbSs5YmRjOG9ac2k4?=
 =?utf-8?B?TGUzYTZuOHFvVTdIMUxqUXRNZmVENzBFM3Ura1FPdWZsemdCQWp4Q2QvaHhS?=
 =?utf-8?B?QjBLTVIzckR1amxUMm9nZkRxeFRxSGx2R3ZsNFVwOVFwU1Y0S2FLK3ZuVzhK?=
 =?utf-8?B?V1IyQkhrWDVjSmE2N2o4cFcxdERjekNUa3JFU1ljT2dmTWRTK09ySWhVUkVM?=
 =?utf-8?B?ZUljUXhWaVpwR1I4QWxoZGZwdm9wYVllcmtzUFNZVmFVT1ZUbFFrMDZDR2p5?=
 =?utf-8?B?SUpVUWIzUEpzM3pmOWZVWTgwZmkybjFSWmFQWVdHVEZxSXhlTTJWOVNXbDdr?=
 =?utf-8?B?cmtjMlFHS2locEowWXBWMUxINHRCc3psbmkreUVEUFI5VE5kR1QrRmVwUlRF?=
 =?utf-8?B?d01BaGRkWmpIZ1phVUg2SlliY05PUFN1eitsNWVsWWhIblgzYktKWmNVZEZk?=
 =?utf-8?B?THFMSnVLeVF5T0JFNzB1dkl5bkpaMUlsYUpXamhITURSSHA0a0xFR3VlVlUw?=
 =?utf-8?B?NFcvZGNnQUVBYVRpdUgyanhiQ3I2c1dMUW1KUWVpUXpYVC9pQ3lRNTUrTC9X?=
 =?utf-8?B?RnY0Mnpla29zYk80Z2JxMHM3UE5wOWlFZUNBYUkzWW1YVUdZcGF0OFFBcmh6?=
 =?utf-8?B?emc4eDVORmlpYmpGZkxPTU9RRnZINEJYd1ByUngyNUhpaHJHcmppNjliRjB3?=
 =?utf-8?B?TGRGZDFRK2RzaGRMWUJBTGNNVllyUXVkU1Y3SUwxWThLbS96L3lMTDN6R3Qw?=
 =?utf-8?B?eDdXd1RyRFVoU3BuR2pIbXJtYWNZdnIzRzcyQXYrSmxBZmFvVUdlZWs3ZVQy?=
 =?utf-8?B?ZlUvbm1DK3d2c0gzRzNHb1AvckpMOHdEdW9SbDZkWU5USHlkWFYvRXorTEJX?=
 =?utf-8?B?MERHL09WNU1kV05yaXdwM0hKZ0hNMEk2WUUwWk5CUjJRcE9WbURTckZkUjFi?=
 =?utf-8?B?LzVuY2Y0SjB3QkZQRzNNSExnVXpYUDBwZDNiaUEwaU1IbnVoSDNGWU1FcFJK?=
 =?utf-8?B?YXJvWDVNano0L0grQkFoYi9hVmFha3dVZ25JVkN4eEZqVFlwNjh0Y0RKTXZo?=
 =?utf-8?B?S09uVTZPOGFxMlN4QVBjZ0NlRlZWUCt1bWVKSEhNLzNhK3B0cS9IZmo0bDRm?=
 =?utf-8?B?NmlXR3ovWmc3RitOU05TcTVMYytFRFJyR3N5K0ZuVnM3bWtNZHlTSlJNVFlO?=
 =?utf-8?B?MGE1amRjZ29KYk9sU244cmhla212QThSVDI2K0M2eGxQYnRMOEd4aHFzTGNq?=
 =?utf-8?B?MW8ySVRpOW5TT2daZlZsSE42YVp1K2VjR2wrVXRxQlZGZS85NDBRd2hhU21H?=
 =?utf-8?B?U244T0wzalY3THFnenNINUh6cHJzbUVUaHB3YXhXU1NGS3lENFJpQTRWNFB6?=
 =?utf-8?B?bVdPVUxxY0VoT0g4ZHg0V0dvSXYvRmdhcXdNZm5xZXRHVnhkOEhLYzMyUW9X?=
 =?utf-8?B?ZUJpZ3pZcW9kaE81UzFhQnZQcWVQNGhHQjU0S1daeDJqNU5MSjR5UTI5VE5v?=
 =?utf-8?B?czdNak9oK3RaUkk1dXdMS01OallsZHBzbDJVYmlGTEZZVUozWEV6YVVZMjFj?=
 =?utf-8?B?R3dTR0E4bnFDb3UxMElNQnhkdXpjS0RyYUs5Z1c2QkxZK2tnd2sxeXg4MnhE?=
 =?utf-8?B?L3AzQ3Fjcm1WMzd3b1BMdkszdTRlSytXVkFiZTlEaGJzbStjVkF2bkJhYk1n?=
 =?utf-8?B?Q0ZkMWh3cnVlY3RCbWVZT1JRdnhWOWR3dHhHcHgxdnRSNFRXUk9MZTY3dkdO?=
 =?utf-8?B?RzFUcFF0SXJCOWR2Ly9MMGR3UmwybjlFUXliSXpsY20vcmc1ZzlMeHU0L2lY?=
 =?utf-8?B?NW5zV3Joem4wMzBDcHUxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkx3V1NYT2c1TkxYQklkRDJWS2VnUkVvSHBMcnJlS0hMUG00U1JHeDRtdGlK?=
 =?utf-8?B?N2toY1ZlS3JzNitDbFJLMk8weGlXcHZKZWRETlpsdzZUZ2wvLzRWMUprMGhH?=
 =?utf-8?B?WWFLbmpwclM4c3o5cUxRQ2pDZlJHYlQvV2tzRitiS0dkckNkY1VRbHBOc0py?=
 =?utf-8?B?bVFPOHJLSnk1a0lEa0lYeXlPdk0xQzZJeVE1NVlLM2Urdm4wWjFGTzFwaWNT?=
 =?utf-8?B?aFNXb1NlOTJBQU9IRkJDYXBqWHR2b1JzUXRwR3d4TlRUYjFwTVRDUEJmQnU2?=
 =?utf-8?B?VzJ0V09UTVNPQVNYMFp3SVk4b0JIUmVFV1NGQW5iNGpTTUMvRklMdDlIOTJR?=
 =?utf-8?B?VG1zQ0VkRFp4MlFBWjJIdFB2VTdXWWpaeHhFa1NBMmxJLzJDZ0FtWkwwcW02?=
 =?utf-8?B?NFFjL1lmc0ZvVysreUg5UnQ3OG1QYnpyOUEyMy83TEREMlE2OEF6L2FZNHBL?=
 =?utf-8?B?T2Z4S3hBcWRQbUJyeU1BTnUwZ2FZditJN0pZZnhyWEd4Qmp1a2JvR2JIdFIr?=
 =?utf-8?B?eVdBZGtYRjRYRXVBNE9vbXJWYnJmL0JUaWNvOWJJN2gySUFPeXkwREFrNjRR?=
 =?utf-8?B?cVJCY0JLdzVyTDJKMDRCREpwWkdkb1YrdjBNSUxiUnVxdnR4KzZobHRCeHo3?=
 =?utf-8?B?NzZqaUxiRCtVU2JjeUtZdDJUOUdVc1JhYTNiL2FtREY1Nm5wemNtRi9ldWY2?=
 =?utf-8?B?K3hyWmFSLzIzZTRTQTVUdFdjZHVDWUR2bzhhbGI1QkRMaUd0MHJzdzhtejBC?=
 =?utf-8?B?d1NHa0VhVWQ0cnY1dlZFUzRQSSsyUHNENjB1VEZ2NVJUYU9TSllpMzRna1lq?=
 =?utf-8?B?VkZvRVRUdUR6MWlDbGNGeDJIUGZISjFzNmZJRmdsUE90S1F4ZXJ0Q2w2dWg2?=
 =?utf-8?B?NEVqUjRGUmd3TU5QbVloUW9KbEkxdGVBM1BPMHZjekJsQ2ZIbXVqVnBPY0lS?=
 =?utf-8?B?Vk9VN2gvRUo0N0RGWVhqOEVKdk1Dd2tsajVKT1pVKzUxWHpyVXJJRkNUNDdr?=
 =?utf-8?B?blRVZldTajRNNjhWUjFaMU5zM2JtODBPckpWLzU0NERUUzNqNHNRMng0L2hy?=
 =?utf-8?B?b1F4NUI1dFFPNlNueTMrcUVDZGp0U3I0V210SGpXWTJOSTl0azRtbGV0Zmwz?=
 =?utf-8?B?bVZ0eDl4ZzYvYWQ0NURubnRLSUIzaXNQVjV5Y3cwQjJnWGphaEc1bk94Mmk2?=
 =?utf-8?B?ekFYay9ZMWI3dzd4RHBZRllJSFJxSVR1cUgrdUhyc1JSbzNWQXd6UGJPQlNw?=
 =?utf-8?B?TkI1TDZJMklGOHNYeUs1ck42RXU5YURvTGYra2VYMkxIUVhaTWlaSVZxd3Iy?=
 =?utf-8?B?RVArc2VUMGRlWWFVc1pGTGhhU202ZEVkcDlHRHpLN3ZERVFnUExOMVZOVjli?=
 =?utf-8?B?aUFucTYxdnJRYjl6anVxKzZTOGxCandTM0Y1bkNEeUM5T2pmTTZQdjFxVXJK?=
 =?utf-8?B?YXpxdFJUSnNVYVVzbWNjcFhxTUxrUXcxQitIeHNnMTNNLy9JUU5pUUt4ZnNz?=
 =?utf-8?B?eTQrdWhiTjB2NVVBUGVMSThGeU1sTU85ZncwS1JHaGNrZDE2UWloQklWYVNp?=
 =?utf-8?B?VGtuejFBNUFJK2dmYVg5cVE5Z2xkUjZPbXNJSGRyeDVsRjNSU1RqbjMrSmlt?=
 =?utf-8?B?bkJCR3dEU3pDS0ZiK0FKb0dWdXVRM25SSUxiamtrVmRacDB5Slh3WUFpM0Rj?=
 =?utf-8?B?ei9rVjN5dURQSS90MEZCODd3eFdBWmIwajIrTVhUR1JDS2xwMVJXZDFlS29P?=
 =?utf-8?B?U05zc0ZmMFlaQ0tlSlhQSlV6SCtqZmhTVjNDYVpzWTYwc0FFT2oreldRNlNF?=
 =?utf-8?B?OE90ZjMrUnBFSWp6T1pxQVJLTzl3NU1weXZNdys1eEpCK3E4Zk9pVE1xayt3?=
 =?utf-8?B?cncyRVBjQVhtYjNDNFlqT1ZobVdqUmttTjI1VjNyZWFYRDEzVUZzdVlMNjN0?=
 =?utf-8?B?MkxwWk9vVFZDRmVGck54cXMzMFpzUzVKSEY4SlpVb0t5OGJDUWF4aXJlSGp2?=
 =?utf-8?B?b0ZHRG1VVVJIZGJEc0ZpSXJRaExoN0xSa09HVFhIRlJESVlaVWx5R2RrUytH?=
 =?utf-8?B?SVk1Z3JEc2MxRmhNNWNVRC9ad3pGcVVENGV6Q3VtRllsc3NkTVpoRktyQzR5?=
 =?utf-8?B?c3QrWU10MlRsUHA5L1gybTZ0RU5vK3BzUHd1bkwyTlB2VXNQZXhDRnFwcjdN?=
 =?utf-8?Q?m6jN9s0cobeNqzzakoYX0SI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fba66ec-19b4-461a-2e5b-08dc9bfa346f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:23:30.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKMy8EyN6kdkia1GsqGJoWECfb6+PSrs6OhnzZf4TXPyE6y5Te1AWclXgCIbDt6vnakg3ZByLvxhRXFIvKBDyfDR5ykKGXJhBoZ0brjnNJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7904
X-OriginatorOrg: intel.com

On 7/4/24 02:51, Jakub Kicinski wrote:
> On Wed, 3 Jul 2024 12:13:58 +0200 Przemek Kitszel wrote:
>> I have and idea that boilerplate devlink_ wrappers over devl_ functions
>> could be generated via short script, with the handcrafted .c code as the
>> only input. Take for example the following [one line] added to
>> devlink/resource.c would replace the whole definition and kdoc, which
>> would be placed in the generated file in about the same form as the
>> current code. This will be applied to all suitable functions of course.
> 
> How?

there are two options:
1. function is declared in .h but there is no impl in .c; a little magic
2. there is a line requesting to generate implementation, typically put
    just below devl_ variant; makes more sense for me

if you rather ask "how applied" instead of "how decided":
a. a helper shell script finds functions to generate (the list could be
    saved as an intermediate to speed up (to don't go through the rest)
b. the main script generates gen_devlink_wrappers.c file

(instead of intermediate file in step a., the output from step b. could
be `cmp || mv`, aka "don't touch if the same", to avoid .o invalidation)

> 
>> The script will be short, but not so trivial to write it without prior
>> RFC. For those wondering if I don't have better things to do: yes, but
>> I have also some awk-time that will not be otherwise spend on more
>> serious stuff anyway :)
> 
> What's the exchange rate from awk-time to other types of time?

I spend there only between a few and several percent of my time, but it
yields returns counted in months of C/++ devel saved :P (not saying
about this thread of course ;))

