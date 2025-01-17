Return-Path: <netdev+bounces-159483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662C3A1598F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6521660FC
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9DB1D515B;
	Fri, 17 Jan 2025 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0PfARMx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA61D2F42
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153566; cv=fail; b=Dv/300lJVbRhbeVPqyQRDfTP+v0NHTvvgIyMThR/HmiuekUbCZu4rC+SDthjicz+GMJH5SdkMprNi3adCuXPJj4hKhWK+WQ1JO/tdDVKbsLLkpdT99bIFiUdZ7ecWRfdBC0Tr/5XtSu0TvQC7t7CBBtnb3XYScXt9urHa0vt4MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153566; c=relaxed/simple;
	bh=Y+x0cTuyeW5ZbjzvmciJdVj2m/aJgJGm2SEVpUccm/Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u9K1d9EVrr54Mcucs+ISJMhC9UPQa67CQhpGp39Mc+RO12VWXO0SziM5p0Gt6XKydSCJlTRVhg+frpzClv4k/z7moJKuFfAZSBQlaol9M2ncl1GpOr9feoM/HrRCbR40n57wYFaC2/oRoqlxXjtOVFXwhCAgTxoVRvBk31LvgRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0PfARMx; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737153564; x=1768689564;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y+x0cTuyeW5ZbjzvmciJdVj2m/aJgJGm2SEVpUccm/Q=;
  b=X0PfARMxodNfv60Q3hcuwKHt/Kq0MdhF/boW6nyWZAGfM9x/X5EQC1qR
   VK/KnO71w1YWXfxYfxfTSO8exJ0ufxnbK376/DGDuyyxieQJ7sJnejUX/
   XsI4GFxTpYnHIOsg0JGxg9Z+tVvlNPPCiRZJMC8xrIQoe0xXsO/nfFO/4
   vg/XPCaLsTh6ZdxBQ6Y7VtnF15wOEr6l2u+5v5WRt0M3xDcRVrrAbeAJS
   16JhDnXVd88rYV0k3W3+02Nijt/6hRWqFK6St88osb/GzyDGOD3FEWYNq
   NBbtdsT6hjarZuzdVLOYs34zgpapRCyjruo6OhI8Nz0n9pZNujPaAsTtj
   g==;
X-CSE-ConnectionGUID: nY0HP4NhTHy8NdKBRMniHQ==
X-CSE-MsgGUID: IlFWdGGzQk21+VnMc/4K4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37483909"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="37483909"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 14:39:19 -0800
X-CSE-ConnectionGUID: R6NPVkI7RumXicpfdQxeYg==
X-CSE-MsgGUID: fIzRsglSR1CRETN1+sKrpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109988676"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 14:39:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 14:39:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 14:39:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 14:39:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3OAF8PYUeW7oL4mXgOORcBNn1fEsFCkVgddb4VvFoGzHrjAIxDLiKEwJUxv0P9QxhBPfFMHpixQcDyDtRt4xHVzT5KTKFYLWyQpH6JtR55Ul50e17T+CO7na8E+ls9eelrnmoqNojOrFw4/3bb/9NOAaapSs5x6BxwkxELdZvYPaWWqUWD+5KiQjdjFUqooLJrsuVVIRbcgzE4FVs9sX38S6xsFQ/7xqlIopbn6D+ieEdrf5CDH3OcJh9r+2kbm92PB81vG5g+0qwvDgPFS/3CFj+sOqfy1PBQ7ra4A4bgZKuuFqypRQSaqMuOOf9OWcJ0P3BjDitbiIM9KXdiD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQtqGIYommFYpJE+u5OiCcknd3Z2+pgcHDSz+poKfsc=;
 b=Go+vysxsirhx0vVmH7UkEasKEPC4BKNInCo9UYLCVWanDQ6r5lnDQLKdwnfd/bWzUF1Dx1uaQAsi75z2JE8Fu+IcpmOBqeWqT+96UsJYomaotuihKiY44uqw4PoMK2WsHKKWz/shkAzf6Pk5GGuUr36kvlSJFNXkmd3/HzQ7HQ51342vi8jQ1SHA6NsgELE5sZcyoG0VSmWiLUwrmG8cJWQVrvFyJxkPthVcpBTEY1bP8dUADfHQUR3Y8fKYFPyIvDBRXsTnAwGbPXnHF1Rh0RR/GvQIJCV5Sj2JMj/K9Z1eBpquti/2vSWbIwh4TK2MIQgMu2XphbzmUA1PaPvfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 22:39:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 22:39:17 +0000
Message-ID: <4fc53607-c0e4-42fc-a0df-0ad0d0c7a26c@intel.com>
Date: Fri, 17 Jan 2025 14:39:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] net: wangxun: Add support for PTP clock
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Richard Cochran
	<richardcochran@gmail.com>
CC: Jiawen Wu <jiawenwu@trustnetic.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux@armlinux.org.uk>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <mengyuanlou@net-swift.com>
References: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
 <20250117062051.2257073-2-jiawenwu@trustnetic.com>
 <9390f920-a89f-43d3-a75f-664fd05df655@linux.dev>
 <Z4p8ZuQaUe86Em9_@hoboy.vegasvil.org>
 <df736add-784b-40c8-9982-ed8821a8bcb6@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <df736add-784b-40c8-9982-ed8821a8bcb6@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW3PR11MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: 30eb20c9-f215-4194-0680-08dd3747c685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVlzMW4ybldYaFNMUlgrbzBCdFRmNUVhNDNTRXRabm92bWpRcFJPNVZHeGZy?=
 =?utf-8?B?QStaK0t3bzRxWGc5RGlXaUltQ1JoRnFwTDR1bGc4ZU9LMlZQR2hFWXRiSk01?=
 =?utf-8?B?MHRyNkZFQ3JRV29KbkdmTUhWbFJvRUdlMUV2ckVubUNMeU5mdCs5VDI0UjhH?=
 =?utf-8?B?Q1A2TllWejhSRnJTdGRTTHFiRElmbktiejBOcDhuSHB1VTdXR1BLTnB4TnJF?=
 =?utf-8?B?bERzeVpFVzJ5WTRpd2oyc3dxUis1ZDVQaGFzalNTSVc5OVEwVnBpdkIxd3pu?=
 =?utf-8?B?Qjd4RWZwRkx6NVVlRmtCTjF2OVFDV2N5RnFlbTg2N3VQWDE4OStES1VNLzBP?=
 =?utf-8?B?R0FIYjV5d28yNi9HUzRqeWR0czJ6eHRkZ0VxYTdaemk1YnJXUnpwcllUYTlm?=
 =?utf-8?B?NnBQQmYvN1owOG1sME1xQkpjbnhFQWRUWHkwNmE0N3NQRFdOZjVtSFVoU3pV?=
 =?utf-8?B?TmJtUzB2UFhPWHZmMnZLSWROU1grNlVLN0hWVHo4dzQwdENyc1hZTVJUdXdy?=
 =?utf-8?B?d1VkQ05mVHJmUzR0YnlCdGtyTVd3YjRRV0dJVUJ3MUQ5dnFHNUVJYTJJRE5I?=
 =?utf-8?B?d3ZMck5IdWVPdUJJSUNxV1hCZ1JUaVNyVFRvcmtmRTVkbjB5eGEvT3V6SVlE?=
 =?utf-8?B?a2xlZ3hybVRENHJqTTVWMkZJeUR6dFBFQ2FjL1VldmhpUXhNSEFCSjVPRzNR?=
 =?utf-8?B?NVRydjZOY1BNNTFQT0xMOWhrcnVlOTlrTUduT1pTK0VBc1poanNMeUZUd3l0?=
 =?utf-8?B?UFh3QjlyZXIxOVY4UVRQTW11aXJDam9MeXRqQlBpTFRmQWoveURGeHZ5dmox?=
 =?utf-8?B?UUVsY3VmRmg1b0lDb1lNbTA4a204YXpKK3dmOVFrSkpWeGdzZFdlK3dGekZK?=
 =?utf-8?B?eVdLUVJUbHFGL2QyN2ZhQVFPbXYvelhxcW9TVWNxNmgwbGRFd2RUYm1mYUhD?=
 =?utf-8?B?MW5LL291dUNJdTVobUdiVng0Wjh0VStac0FFOEJORWNZcVcrWWRXUmVjV1dw?=
 =?utf-8?B?ZHBxTzhJWTRIN1pQZHVpc2VQRkh3M3Vmd24wNUcydUtYdEVOUHhXL2FDQWlK?=
 =?utf-8?B?UERtcjBLUEpmVFhtMDBESUV4K0pXSHk3US9RWElGOU16c3F3QkhWMHhmM2Z1?=
 =?utf-8?B?bFhwVURac3E3cXN6cTQ4MDZjeDBDYnJEaFB1aVdBeGt0VVVZY2wwMVQrTkg4?=
 =?utf-8?B?V3MxY2VncWRFQU9CazdKK2JRekxJU1lJemcveHRQY0s0dVRUL29xMXBPSVJv?=
 =?utf-8?B?ZlZ0RGM2enM2QjlqbE9ON05ENWFtVlpwTzRCQ2tsc2xiZVJHZ2RiRCtQd0FT?=
 =?utf-8?B?encwdjYrMWJSTVdDMmhNNGV2UXlJajQ4dDlrSW5XT3FVVDZFUEhZbGpBZmQw?=
 =?utf-8?B?Qk5wN2wwSmdUY1RqVUZVQnZ6Z25XL2JDZFM2TVFudlFxYXFra3FoMU90WGpK?=
 =?utf-8?B?UGRvNnNTdVkzMEx3cThZdDZITkI5bVFXNHJvdC96MFp3dnlnZUt4bVM5TWtO?=
 =?utf-8?B?UjF3N3B4VWVpRC9yODZOeEs1YVpmQ3ZEeWVwM3MxbzUrUmlBbncvRGp0NlJO?=
 =?utf-8?B?T1k4UmZjU3dZMGdyNU8zS1prN2hCdVI1Z0FLMVMwRUhzWlZ6LzgySml3ekR3?=
 =?utf-8?B?S2F0OE1DRXNsV1l2SC9nWFVERWtiZDdrUU1ZaUdONWUwN0ZaQmdMTEZPRFJQ?=
 =?utf-8?B?dk5KZTZRd1pjN0hlUmh6cEkzcTBXZFNna21seUFQQlFYeGZCNXFzb2NNS0Fn?=
 =?utf-8?B?YmFXbmVHdVJ6QzhyZFJlTUhhTm9hYnFDYk92OWhzRHN2dURYVEJKSTdpOU1U?=
 =?utf-8?B?bllNN3F0bXh3K2RxR3RKaEpXb2FONFlyU0l3YjU0eXJNcmcxY2Z0Z3MzS0VS?=
 =?utf-8?Q?WwK+iqL0oGqZ+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlZCUVFHQzMrUHNQMmdJNFZSVlZuaGwxQTdIbzAyYlUxQXhtQkVKVE9yaGZo?=
 =?utf-8?B?T25qMGFDRVFDa0VNckdOTmpFNkNtZzgzVmczZnZFa0R3dU1xT0J3Zm1kZFFk?=
 =?utf-8?B?NXpaYXkyQk5pdWV2TzV0Q0oyK1hoTklzV2czS0c5T0xPYSs2Y0RnSGd0OFc3?=
 =?utf-8?B?dWNpM1pmKzRjOExzUFUveVV1WlhDSDh4UnFkeldkano3QlV1Tm1SelkzelBP?=
 =?utf-8?B?RCttK21hNyswL1BJdDQwZmdqdVZMeUVZcjdZeXEzTEM1SVVZVUpicTlFdGpp?=
 =?utf-8?B?Ky9acXF6OHVhcGx5dTJHalNRQ2FMUktRaUZmcXExaTN5ekZyczEzQ2E5VTZX?=
 =?utf-8?B?V3AwTCtyNkxHVDlJNExWZXllKzU2UmlOalR2bGdIQThoSDJTdDFsajJtTVcw?=
 =?utf-8?B?WklQamo3RlJLNjJMS1EwWVgydHA5c0xSN0pjZ29qY1hOcWxaZkhVaS9OMzBO?=
 =?utf-8?B?czkzcldudlY3ay9BaTF2dzVDSWxFS2k2cDcrQ0x6SXJUaW5PZkRlVmx3ak1P?=
 =?utf-8?B?VnEvMDFMVzRvcngySjlmTXZ2eGhGTTJQWGZEY1dENjRNKzcrZ21oQ1ZuK01D?=
 =?utf-8?B?OGZoK0x5SmFCK1hRQ1pHQzIyOWVFRTd5R2xpVkF4aW0wSWpvTytJeTA0aUZr?=
 =?utf-8?B?bFo5Y2Y2c1lRUjFjOU5pQ1M4ZHNKM3hwNGVtTEh4N0FkUnBlSm40ME8vWk4z?=
 =?utf-8?B?ZWtqd09mbXhWUXRtTGZVRENTb200cjdLYjRVUEZhOHlRL3p0SDB3bk9zSEpt?=
 =?utf-8?B?Vk5aWm8vWHJUMEROTnRSLzg4RldDK0JsTzFtYUNHSE5qS0sycjNieGJBWm9Q?=
 =?utf-8?B?MlpvY00xOVVoZnJjQUZKUTk1RnRMQ2ZsRWI1QVRrMXdoeXNCaG1MMHkwd29F?=
 =?utf-8?B?YWM4OFhvRjZrbVVINldRYUljWWpTd1VzSlZ4ekVZTGtBQU84aTc5a0RmZmg3?=
 =?utf-8?B?blhZMDYxVEw4U1lRR3c0V08xMFJwMmk3WnkvU085ejl4MHJWeGJQMkJ5RzNL?=
 =?utf-8?B?RExETHFlZXlLRjVZY2ZISHBQcnN6LzhiVXU1R2lqMzRNRzZsODl6TGtTdmZQ?=
 =?utf-8?B?aHRPb3A4M2xiS2Jubm4vUmhkQnE5cUMrWUQ2SkZMY0RHWU1xc3FRVGFZaTRq?=
 =?utf-8?B?Y3lRcDJ2TWhqbVR5M1FWOHE0dEM2SHhhajN5Unc1Q2V6MEZXRXdVRGF6VWlL?=
 =?utf-8?B?VHFQbXhoRy9HWW80MHZ2blZFbC96cmFLR3RYQk5zbkdIZlFCZXRMZ2UxMjIv?=
 =?utf-8?B?NVozcDBJbWZ4UnJHN1dQNlQyaDZLcWdiVGMyL2xDMlNZck1xbG9CVFVTZGxs?=
 =?utf-8?B?SFhTUzBZeVZnZENUMVNtdWNsV2hQbHgrUmdsL1Q0ZTZ2TG5PS3VCYlJtYW5F?=
 =?utf-8?B?L2hGaG5oN1VFM1NxNGx6c21hdGRQamRoUWZoRGZPMkY1VjdlSDI0TnZwZVI1?=
 =?utf-8?B?MnU5bThFb0QzR2JrMHkwSEkreGJWdXl3VW81N09mZUsrekszQ1p5NTdxMVpx?=
 =?utf-8?B?YWZxYXRudXU5M2JQNTdqSGxFRG5YYUI0akJJcWtvaFdiQUpKTWNReHhTTnA0?=
 =?utf-8?B?dHhEek54YVF3OE8rM3BCV0o5YTQwL2dDVmRhaWVnUS94blUzL2dsLy8xVmJn?=
 =?utf-8?B?TG85RVFGUDZRWjBYdEtWZ1UxOXdYaGRwVzY1NldoNDd1UWxpUVp5QWhJK0lC?=
 =?utf-8?B?R1NXazBGaUwyc2syenZtcjVlcGpRSzQwMGFhRTA4WjhQb1NoUUo5NzlRaVYz?=
 =?utf-8?B?dktqS3VMTmo2LzZLQytOcFoxRi9FU1BidllnSWlFWUFUMC9kZElENkV4cUFm?=
 =?utf-8?B?S2JEUGFQYmtpMklFMUFvTG15MzQyMTVuUk1zZlI5c1hnWFMwbjNOa1ZTeFJx?=
 =?utf-8?B?U1ZMeGZXWFhUZ2RmcFFCUTBKV3JJS1d4UENNWDBneW9HRmlpN2MzSmdhdjYr?=
 =?utf-8?B?a2dKeEFvM3UyOVZ2U01OV3hSTWlpNU12UXRxTEVzeHhGWXhSYjExVXkxakdM?=
 =?utf-8?B?dU0wb00wcFN3TE5HWXVFVTBtdzd1Rmxuci9hZXhyY2JGZndkcUVhcy9zQ1Bx?=
 =?utf-8?B?aTBDcStSRFhlb3MzN2RNOElJL0hqc0xhSERhbW0xZTZ4SFZSUEhrMHJsS1FQ?=
 =?utf-8?Q?7z+PHRsvBwaZat+mmlceORyqG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30eb20c9-f215-4194-0680-08dd3747c685
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 22:39:17.0567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjAPDetJ9NQYYGLS8mD4vDQ+bFPe3kKl8ROQ0+o3Dito0kP3KkeU9jxnlXgBQHMhZKOjK0oGoNpY0NMuDH1wigyrbvET6BnIoVy3188Kro4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
X-OriginatorOrg: intel.com



On 1/17/2025 8:03 AM, Vadim Fedorenko wrote:
> On 17/01/2025 15:51, Richard Cochran wrote:
>> On Fri, Jan 17, 2025 at 02:15:01PM +0000, Vadim Fedorenko wrote:
>>
>>> there is no way ptp_clock_register() will return NULL,
>>
>> Really?
>>
>> include/linux/ptp_clock_kernel.h:
>>
>>   400 static inline struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>>   401                                                    struct device *parent)
>>   402 { return NULL; }
>>
>> Also, sometimes the kernelDoc comments are correct, like in this case:
>>
>>   304 /**
>>   305  * ptp_clock_register() - register a PTP hardware clock driver
>>   306  *
>>   307  * @info:   Structure describing the new clock.
>>   308  * @parent: Pointer to the parent device of the new clock.
>>   309  *
>>   310  * Returns a valid pointer on success or PTR_ERR on failure.  If PHC
>>   311  * support is missing at the configuration level, this function
>>   312  * returns NULL, and drivers are expected to gracefully handle that
>>   313  * case separately.
>>   314  */
>>
>>
>> Thanks,
>> Richard
> 
> Well, yes, this case is a special one. Then maybe it's better to adjust
> Kconfig and Makefile to avoid it?

Seems simple enough to just have the driver disable the PTP support when
the kernel doesn't support it, especially if its not a core piece of
functionality for the device. In cases where the device would be
functionally useless without PTP support, Kconfig can be used to ensure
the device driver won't be built without PTP support.

