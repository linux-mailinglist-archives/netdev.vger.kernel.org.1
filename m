Return-Path: <netdev+bounces-170715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABDAA49A76
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DB33BCC1F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D126B971;
	Fri, 28 Feb 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RaV/S5lk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D326D5AB
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748994; cv=fail; b=i5+C+6FRsln4NGs0g9E69t/pMRKIxX5MgcIViFJitFrge4wjr88MerJSXPL2d52BU362F4hrKAF2CGXmVdjYpnsg8U6arrjPsVBsiIHTfJdDq7uOGuBBQ9K3oJj1/i7XAbd2enwWgJFqYzJjPQ7RkMAsb56kTyiBt5FoogmRhoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748994; c=relaxed/simple;
	bh=8Vib4cyMz05aoKo+dkAZE+J7AkuXzI0/Ok5nNwRB1SY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WU55gXcUTho9PZ4CWJRGdK4PvfsAnZeK3k+dT2BiiJgPLfzZ6CyHcQil73aWTkxivzfTVI9MjGXL8JBCaR276MW1iZidVP1IJECIl+FxTLN9alMjUT7GuS5JJtlIWNxYmJwqPWT7szsKc0GbsAJWLx9faUaoaCMcWyzPyhe8vq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RaV/S5lk; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740748991; x=1772284991;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Vib4cyMz05aoKo+dkAZE+J7AkuXzI0/Ok5nNwRB1SY=;
  b=RaV/S5lkt9lDEfKi17Vpztubc5zFm1fHc+Wg9XSdqhkSqgB7OXOQOKqf
   hejNkmhtpEZ3AuNT3JiQ2sUkpbtx5SWhDW3sIoOt+BpcEaA2T27f+5ghe
   ZotQ7SBorpoiAmWR/lEaBIGwLguFwoySKDygEWnYnEwRM85IYESWUK0+d
   AICYiv3zbG33Yl/L0XyigvGxrb5q7S7EUviGtnCLneKjVPDFBhrKg/aAj
   2YV0pYZ3RPqonpRUxvFQjQq2jnMC7JekXn6W0Ee2Q7vXpfntshS+m9G8q
   c2S/zRVGUfJrqyU6T8786WajpTjBOctBxM/CV+OM73zDcE9FdKI/FdmC5
   g==;
X-CSE-ConnectionGUID: TnqUjPGZTj6GLo4OmQduPw==
X-CSE-MsgGUID: 7Md1B5tJTr2CkLXJPe+n7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="51881009"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="51881009"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 05:23:11 -0800
X-CSE-ConnectionGUID: RINvDmyDQASJklnJ9D8cEQ==
X-CSE-MsgGUID: YwjwANj5RfWr6MKGhrAnkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="148137701"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2025 05:23:11 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 05:23:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 05:23:10 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 05:23:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMpG45b0xx8C/Bicy67g9OZwgfB+4K9oozSGuZrlcNqi2Oz4nVa/I4Bcu09CUKYOmQZuwR6gKWztqB2W+GCh3DMuWlK3Q4sW4goSv5V07xCRBGo09LGXe03TE+l5u3FMbNY8M06DbLkWbfRan/1UIuco93VMhYoqtYXfFQ+gj8k4mF24QNl55+QGySMTzdQ7riBPVwcXofMPbsHG9FTyNq2c6PkRHaMk6cf6xZRdJUvzHnlRts6RsQ12msF4E8z2IBl3Mm62pbyewKDXPGpMP876NC++Hw6w6V2fZmoqPBUH1Rf3bOyHhnIwkrH/jQ/dM75hcFruIkdJ9YdPwt7gLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhnLegTlaQfiRqTxGRWKIYlxGfBFbsg03L/JsryuAtc=;
 b=q02Vgxs6iOuXdeQJE9uZ8DqvB6BFwPv62/C8+eS/O+PIVGtVQt5+wfYoXHoIZtztk0J1/1bwk/ejPOdm4fi6oVbk/fypbViSecQ6I8y3sGpRcNPScAjpqpHS7e9SxhG8+/+Vc5/0/GY/03AxKIPsxwau/g3O0tfpqjV7GqkkukUf7j0uXqnG7GHzeWZQFKicKC2y7tZrl0sQVkKL9KbpzKpKFuC5ionmoxn7fo2AuPfpDuYzcA6hm/8nCW59PuJ2UEp2vhlUg84H/w5PQp6FYN1f658DXdxlS/92UswqJbdwVylA/cyQ9kO/PAX5UTLirkxXvfA8EwHjUiMRDShLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 13:23:07 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 13:23:07 +0000
Message-ID: <d2fc9e7b-e580-4989-880f-9b47fb5b5b4e@intel.com>
Date: Fri, 28 Feb 2025 14:23:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/14] devlink: Implement port params
 registration
To: Jiri Pirko <jiri@resnulli.us>
CC: Saeed Mahameed <saeed@kernel.org>, Jiri Pirko <jiri@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-8-saeed@kernel.org>
 <56581582-770d-4a3e-84cb-ad85bc23c1e7@intel.com>
 <oqeog7ztpavz657mxmhwvyzbay5e5znc6uezu2doqocftzngn6@kht552qiryha>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <oqeog7ztpavz657mxmhwvyzbay5e5znc6uezu2doqocftzngn6@kht552qiryha>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0059.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::48) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ2PR11MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bd98d3-4f25-4403-11a6-08dd57fb0a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEhWVC9FaEs0ejJGbUhGRGFZYVBZeGFlN1hHSDN2U2NZcGY4Y1JFdnFaY3FM?=
 =?utf-8?B?Ti8xTlhRSnJHeWhmTEV1NEdUSFVMY1Nnb0g4YVBBUFBMOU1icFVLdGt5YWx6?=
 =?utf-8?B?ek9KenpmUitjMFVVZmdkQ3JUQ0tMTjF6V1dReS9KSi95eWZRN25xQlpLS2hz?=
 =?utf-8?B?bjN3eVZqMVVNdWgramdZc1lWZGs2NkF0YVhCT3FpUHVFN28zZG42RGFyYktq?=
 =?utf-8?B?MWg4NVZPdnM0M1pacE1XeklXY3RvMDlaU3N4MFdldE8vS1Z4QXBIUDE4TldL?=
 =?utf-8?B?TEVXOUwxclh1cUVheDJWUDNhdTF1V2NMVDh5UGtITFhIZ0RWUW9LSEFraVpS?=
 =?utf-8?B?TXlUbjlGT2JVOTB0K2wxVVVUMEhPUVczbzVhSEp3eTU0QXYzNEJrVmJ2amNm?=
 =?utf-8?B?bllIRGpOeGVXYVZaSnY3NUlqbWQxVXZ2UVl3Ui9kd29wcXB2eTRCcW5jeWtj?=
 =?utf-8?B?cjgvZmZJRkFQVWJrSnNqWEE0MEdWTHZJWTg3VTJ2U1Q2eXRsYTZGWXZyRTU0?=
 =?utf-8?B?d3I5c0dtdVRpV3BzS200TFRWMlhYNzRmc1A2b0VZY1VXQ2ZndEI2MXNVZlJH?=
 =?utf-8?B?Z1ZQVHVReUdkZERvT2Y5RXFEeFhZekVuc3gxeUZ1L3NYVk9iK090akR4TmRI?=
 =?utf-8?B?VzNGeXRXakU1cVo2Z0JmdFNwKy9zaUQrOTc0RVR1eXU2UkJBQXdwWWtRbUQz?=
 =?utf-8?B?NS81WndNYjJySzdGdGd3YXpmcDl2QURHa1VqUmUxb3pBaWFOc01XTmFJYXhx?=
 =?utf-8?B?Vm1nTEFQVWYxRmdZaVpDNlAxa0h3c2o5R2c2OWdFckZpbGo5TmlHVzEyVWJi?=
 =?utf-8?B?MmhoQ2ovOHlsaHRBbWtjMllHNTVDV0ZtRU0vWTc0UGlxTjQwbldyalZhWjVy?=
 =?utf-8?B?SmZQYjE5eVAzRjg3d2NoZGV2NWZJdXNKMXZJWllaWUNKUUxoWlRXR09LUlZN?=
 =?utf-8?B?ZWs5dVU4M3ZpVEh6aGh1aFBzWTJrZWJDN3pUZUxyblNXWHZWTFZlRElSWk9I?=
 =?utf-8?B?TzhBaFdObWVqaUt0RWRnbzlkcVhUMW9UQ1ZBdjhOUjM2a2Q1L3dRVk5FRjc2?=
 =?utf-8?B?b0EzaEJ6SzBldGhxVGxkNUVseTVWSDJ6SERGQWJFTVA5S2tDRVprVlhrQ3lj?=
 =?utf-8?B?MTZjUURWQno1K1ZSZ05UTFo2cUY4ZWRnRkIrVmZlWEhlTmh1a1JJc2VicDdY?=
 =?utf-8?B?bWoya25EcUIvdWhGcEZOY2RwMlZUVXVJMVBORzlMR0hGUXNlaHdWTnNkMmhP?=
 =?utf-8?B?RGFlcHBVZENZUDRib0F4Sm5oZGE2ampUZHF4SWE4OTRGVjJZRGpkUTBjcmxY?=
 =?utf-8?B?RThHUDFrV09NemVlTjNGZ09MNVdMT3pITmRZYVByVCtLck9HSHhGUVdjeWtT?=
 =?utf-8?B?WnpHeCt0RXN3OUlnaUwrcHhUNkIwK2JUVjRISXVZcHgvYkgvWVl4OFZ1YmJZ?=
 =?utf-8?B?NVVyT1dHOWFxVzBIMlNHa25iR2hGOExuK1VoVzE4NFhCYVRLSS9sejg0aU5Q?=
 =?utf-8?B?MWZBdGIxZTM2cFBJR21YZlluZE14ekVZelNxR1VSMFBiMmVMZlQrMU4rYjRt?=
 =?utf-8?B?cUdFYk1jLzMxTXZTeXVvaWdhcDNpOStiUTlRWDl5WWFKeHBCZkozTEFsUlRU?=
 =?utf-8?B?dmNQcElNMzQzOFRrRFlXalA3OXJnQW1KUU1yNkFJSkFVK3FrblRxUjlyNnlt?=
 =?utf-8?B?RkZCRXBMbXQ2ZHU0RFMrT3JNbDQxYW9oQzNNY2tsVjBYVVdSWVRqSCtUVzhW?=
 =?utf-8?B?aytUWHJuV1l3cGFnRlBYdDlNM0djYm1JaGZvN2FXdzRYc0tFRHRDZ25FZ1RJ?=
 =?utf-8?B?L2NYSmRuQW4xcWI3Vlk2SEJEQ1kxb3QwU09SMDBESnFUY1dCVzlZVFNnb3ZX?=
 =?utf-8?Q?VuHENymGjLd3o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTh2MUI2MUExRzhxS1Q0aXVtVHJ5dmVtZDViSFJNNnA5em96azNFeWJMNi9s?=
 =?utf-8?B?eWNnamZvcDRQNWI2cFpDMllmTmZwaG83UXYxaTVBRU5tNTE3WWVZZ0wyVDJN?=
 =?utf-8?B?ZzFXTjhBYnovWktyd1ZPS0VYblR5TlZkYXR4YkRPUmdKZUU4azg1TmtOZ3JT?=
 =?utf-8?B?TDBDT3VjVVBybzA2RzM3eFVYYjYxK3RKZWx5Ym9CdzF2YlZ4MmZMZ2ltb0wz?=
 =?utf-8?B?cWc2blVKVnhMck5MTEVWdVJRM0hzbWVyNlUyV2NJOFFPRWZnQ0M0aSsxUFdF?=
 =?utf-8?B?YUwxTmVUU25sMFdnNndlRDZVeTV2dGdrQmxXUkgrbGZDSUZtYzdYbHBJaEw5?=
 =?utf-8?B?ZzVEdU1kcG1tUGpSZHB5YkYzcExqMStFMjlNL0wreDNERTBLbnhNanNwZWZM?=
 =?utf-8?B?cHVXdVNNMS93THMvNm1tcGVuaW91cGpmczdMUGRlQnQ5UkU4MEJtV1Jza2dr?=
 =?utf-8?B?TS9RZldjb2lBcWdjQU8zcU1DT0dVQ0dQVDdwUXpzcFp6dHFNTzV6a3hNWURq?=
 =?utf-8?B?ejg1WW01ZC9oeXhYNXFhQVdPQWtES0hqQmJzeXZnSU1VaHROSndUR1UydkZZ?=
 =?utf-8?B?Zncyd3d3dVlQMjhCUVFnWURkb0pVTHZ2dDA1VHIyd3lWNk1VVjBvQXpMbHMw?=
 =?utf-8?B?OWsxSkhGd1poeFE3cnp5M25RcHk5emtVTXFCZVk5ZDNHYmNPaHRMbFdVV1Yz?=
 =?utf-8?B?Tk9jaWVyZ0o2TlF2ZTdCaXRhUXlEbjloRDNmcFdjTTFwZ1lJanFDaG5tclJK?=
 =?utf-8?B?TDhVbG9CN0svVGdBVi94cHc0cUk4d3JhTTVEYjlFWnUwRmowRXB2a2ZVYXNW?=
 =?utf-8?B?eTRaQk45SzdyUlJZSnVtaEswMXBTU1krd1BwaGJrb201ajRZandsMHZpc21Q?=
 =?utf-8?B?dHJSako1QkV1RmRCaVMwWndRV0VnL2VBVmd3dXdJN1I4VTNWVjZTeTM2ekpS?=
 =?utf-8?B?QjcrK0UzVnJqeWc5aVBqVDJUc2Y2QlFYaENTaGViakM4aUtLc2tUdElSai9B?=
 =?utf-8?B?dTNjM0lHdnExV3piZjZ1NXdrMG9PVTFBWkNXREV1aDE3dk5uT3pjRDV6eWNO?=
 =?utf-8?B?b3FvcUtxNE5yYW1udXlZMnd6Y2pzdVd3bU9UTEdKRmpxK1plRjhMcm5tTndL?=
 =?utf-8?B?Yk1BaUYxUVZ5azZFQy8vbkNkdXY2a0NNTm9tQ2h5aDRtMHdzZmpXYk5tSTVn?=
 =?utf-8?B?RGVVT3ZaT2FzSzNFVnMybnV6UnBJZDRWcjY2VDAwQThaVG9jV3N1NElyV1Z3?=
 =?utf-8?B?a0ZQbUlXcExWWXVTM1VWaTZWZGdvUzFPbDFkcnpJM0ZkejV1TmlLWktnSE9q?=
 =?utf-8?B?eGxlUWVqNU8zdmE0SFkrQUJlUjhkaTRZdVp0bWVKMFRoNlc4cGxENFFPbElk?=
 =?utf-8?B?VGQ2WElxalZQT1VyVlpCV1gvMmljd1AxZ2ZsNFdRbWNKczhwcnppdHZtZ0tQ?=
 =?utf-8?B?UDN0eDJVVFlVaDIxTHlFUU9LdnFyTmc4b2RWb2NoSko0L0x2T0hEaFQ3ajRu?=
 =?utf-8?B?L1BueU5RMVB6UVJ4RE1PQUxtWHcwdWF4UmRkdXZMZE5NUXhORVRnalcvRFli?=
 =?utf-8?B?dWI0NThOSWI4T3J3RmNRZ2RjR3ZvSmdBSmpncWZNUEl6R0tmRUcvR2UrbzNk?=
 =?utf-8?B?UW1oU3k4cFFYSmtsTUViQmJTQlRDb2xqV1RYYWV6NURaTFc2RGI5M3V0U0xD?=
 =?utf-8?B?L1lsVWhlYlh5eURCa0lPQUJsNHc1Tm5OYVdXV2gwaFMvL3k4QytSeWI0K2E4?=
 =?utf-8?B?VjdnOHZXNU1QTklvYUI1ZFFhU3JUNlN3SUh6ZjR4bjVHaDRmSHVIdUVVZzRw?=
 =?utf-8?B?QXkvU1hOTHY4QUJ6Szd6K054VXAvVG5zYlhlcWZPOXB5NlMvYTlrdStkRk00?=
 =?utf-8?B?dGw2a2lBZUZrdmRDMUdMVDFqWlltU2RJTGJicS9sQTZrRTJZN05vcmNpOTd5?=
 =?utf-8?B?UHFJMGhlb1lhcHRibEp1c3huVnFYeDVWNTU2ViswZUE2TEhTbWRtTnJONExx?=
 =?utf-8?B?MnhFWUFZZ290alFpMHVmSFFxbVBESGRLRGttOEpVakRBZGRqU3U5VytQRFhK?=
 =?utf-8?B?U1ZUSjU5Rkc1dmM1TjU0VnlFeUQzQk91bFBZWDA1WlFkUTl2ZU5rSjVWaGhr?=
 =?utf-8?B?TW82OXZ0aGNCZ3pETjY1aHkxRWdXZGZkOWpDbCtxbDlraFlEc2FYQUhaS2lk?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bd98d3-4f25-4403-11a6-08dd57fb0a10
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 13:23:07.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKGVqxBaOdfXvpLxPwkuIRwVvH+fIHPuL7VhTj7kgj3tqXsTqK0Aoa7J66DLypB/iITVxv1gGoXFpulu9mCVwtkQMAdy42P44JKpSThJaVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com

On 2/28/25 13:28, Jiri Pirko wrote:
> Fri, Feb 28, 2025 at 12:58:38PM +0100, przemyslaw.kitszel@intel.com wrote:
>> On 2/28/25 03:12, Saeed Mahameed wrote:
>>> From: Saeed Mahameed <saeedm@nvidia.com>
>>>
>>> Port params infrastructure is incomplete and needs a bit of plumbing to
>>> support port params commands from netlink.
>>>
>>> Introduce port params registration API, very similar to current devlink
>>> params API, add the params xarray to devlink_port structure and
>>> decouple devlink params registration routines from the devlink
>>> structure.
>>>
>>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>> ---
>>>    include/net/devlink.h |  14 ++++
>>>    net/devlink/param.c   | 150 ++++++++++++++++++++++++++++++++++--------
>>>    net/devlink/port.c    |   3 +
>>>    3 files changed, 140 insertions(+), 27 deletions(-)
>> For me devlink and devlink-port should be really the same, to the point
>> that the only difference is `bool is_port` flag inside of the
>> struct devlink. Then you could put special logic if really desired (to
>> exclude something for port).
> 
> Why? Why other devlink objects shouldn't be the same as well. Then we
> can have one union. Does not make sense to me. The only think dev and
> port is sharing would be params. What else? Totally different beast.

Instead of focusing on differences try to find similarities.

health reporters per port and "toplevel",
just by grepping:
devlink_nl_sb_pool_fill()
devlink_nl_sb_port_pool_fill(),

devlink_region_create()
devlink_port_region_create()

and there is no reason to assume that someone will not want to
extend ports to have devlink resources or other thing

