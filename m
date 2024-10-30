Return-Path: <netdev+bounces-140457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAAC9B6929
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D951C210BA
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761B21443B;
	Wed, 30 Oct 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sOxIB70I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D22141D3;
	Wed, 30 Oct 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305730; cv=fail; b=XWNMOfQWeCEVjglkaD4wF/Dfjy9/KSR6S29Wb4+GQr8WWcusZ552RENk4Mywd/AejIiPezC02A+Qdoah67xxaU5wDT6HE+uTVNYhUcBH5XWkNeEa54N10+ZELiboKluySlowuPKsavxWR5KWL5Yw7YHxA8zxGSwFq6zxwbU9kXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305730; c=relaxed/simple;
	bh=x0xWHAJ3E0FeTX9z8/77mm9bXt9TXI+SWPqweo2m/uI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IRvtZ51rsfxw9TbvIP7Zh29+ox+/sQH93aLmc3qZYzQtovpsff7AxRgORWtxdcxjfCu28eQqlUElgbciCQJzpmdl+kYm+9xUhFg6YCFHSAbN4PYAQu8/RqF4h7s+cuW+TRxS4T38f577hG2UEqfLO1v3IncQln8Mscdw615BxTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sOxIB70I; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N05OHn0kl4RkwIpXfufNm0VtSzU/6j6zt+eXoffkMx7r0xweZ3tYgYoTByhWBozfgQP+FQXA03aPT4axRj316qxgNIyYQFYqgQ4avWc7pNoF+6pN0AKHXWGEnRFeXl9G0OCA9mfwCSWi1ZrHvPTI+m21tQQ7IKVXgDDU3tZdvJ9vFkiuvswotN8g2AcrSjmkoy77kugJevAFGWb6Utx/6to5WLNLduiI24UgLn2ZFBD3wLC7NEys0ZBdHS9UZLuUfDXFOJRssEjveMiZx0B5icS+hPSXhMBYq9ST/ITzy28UGkYmlngsnzLV5ZKj67VFLYlUmuBLt7CItxWoonSQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4cSNZShmf6UXbWQRy9PypRsE8B7Rsu8CaavoXZKqts=;
 b=kd9R6ZmwMfrv2YXXy5yF9ckS9qsMdYQHmlacaFg69jC6IQuk7IPagjhii1xSGkg1b75NmOPB7FdLBBKa6psYtU6H0oelSMpxsmpgDa+6sgPYRBL24zWIbDaZxi5FZ/+a40lJurHyOvTLoYjqbFvjIfemi0/JI8upi/VzkTEQNAiUIOHZUzZgRrZytTwCCyZk8FqFCcI9GbhiQ91UMPgplTncHVJHiBXS2VZ59ksdgNHcp2U19mXljqEj/5FMUx+PDCoPWzzP6K+UcGTXqNLSclmmg7DtKjrf2Wr8rC4dO3cZ16agCazR4xk+vDFu1U85hY4O8FoZYb93wyHjqzSkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4cSNZShmf6UXbWQRy9PypRsE8B7Rsu8CaavoXZKqts=;
 b=sOxIB70IWJKEC2/eQnOsgFo0qc+W34xlHKVR59+c6pvyZuDyjUQ9g1BRArU4gMQJZAFqn8NfJRx82Kpm5xKo5HTGL1hignd6DlUr/XFfBmutSruhbqFew7To5AOimtj04Qi3Qo9KyK488IEMQ4AQ5goEyR3d48/9o03AkavuYms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 16:28:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 16:28:41 +0000
Message-ID: <cce5b073-cdd9-6231-1c6f-d3a0b4e2e419@amd.com>
Date: Wed, 30 Oct 2024 16:28:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 03/26] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-4-alejandro.lucero-palau@amd.com>
 <deccd9ee-5868-4a2a-a756-13f4dd2a27ba@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <deccd9ee-5868-4a2a-a756-13f4dd2a27ba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0085.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::30) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: a8645870-7f4a-4df8-98e8-08dcf8ffea40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUdSbWJ5dkE3QzNVbjJBVHVuZ0FpVTFnU1JGaHJvbFpFR0hIb1YzYWFmeTJW?=
 =?utf-8?B?V29GbzV1SXgwYzhSdXl6Q0g2WjFORXVBN0VaTjFaOHRNaVN3RkFBMk1uK2tv?=
 =?utf-8?B?cCtUNnJUR3M5WHhmbXJITlF3OHRyYWVSeGozZGhEd0QvY0d3TmdKbFdtYlZB?=
 =?utf-8?B?N2sxRDRrRHU1RGV0M0hlU2xzWUlxWlBldStLYVAxMUR4RVFRMWhLTkVjQmxL?=
 =?utf-8?B?Z1dlMmNFNXhXOVY4c1BGMEcrT21WSjlEamNyN0pOWGdzcys4NU5Hdm40SzNM?=
 =?utf-8?B?bzVHTkgrMmxJbWVDZk43UzRtZVJaa3RJUERuS0p5WjBVbUtmUXhPelRlc0xn?=
 =?utf-8?B?cXVwUFlKZmI2L3p1eFhEWXNXZ2hEb0VtZzZtNnFKSUtLYkUydEZDSnBtb2pt?=
 =?utf-8?B?aFVzRThJSFVLMVdSVGwra1h0L0c4VVplTXVsQzhIb0xTUENQTXgyMEFiMm9B?=
 =?utf-8?B?TUZBUzNoWk1zSDhLS01rYnJjUm5CMlRVWDd0azZ1MlQxUENFV20vSVZYcS90?=
 =?utf-8?B?cTZkNUc2YW9UaHFzYnAzdjlZTTZoRENqZmkvQVpQZGRTWSswYmVKQks4dUxs?=
 =?utf-8?B?eDFDOWRkd1ZxaFQrblR1Wm9PV1BNaWF3V1p0QWViTkNZYlAvUDFDVThQTlBm?=
 =?utf-8?B?aUNIdVRKeGsvcVNTeThBSGsyd2VSQ2lta1VrOFZFdWlVbmRMUll2Q1JQajRI?=
 =?utf-8?B?UWJsUFY4Q0R4bFhMYTV6YWZwNkZoYUNQMFNJSmxobDU1Q05Gczg2aW9IekRj?=
 =?utf-8?B?ZkI3c0RTY2p4a3JOdmFzN2pjL0dITUxiUk1sbUx2VkZ5L3psR0xBVUJPYVcx?=
 =?utf-8?B?czZTUnBVclN5d0JFeWtWUE5QdUVzTE1iR1BxWG5qQmE0aGFEcTU3OUtYelFx?=
 =?utf-8?B?dldpUUZwazN1Rmx2U1RGWFFEZG9OYTcxWFgrUGJpUHI2RzhXemNreXNiSlZk?=
 =?utf-8?B?QnpzWENBTGhOSkNqRVhlck82ZHJORi8rRUlIY1F6Y3AwTjFIWm5GNCtXdGs3?=
 =?utf-8?B?WFdqRVM4QzRJV1BvOGw5V0ZQYUVvTk1halRuV2tKL1NMcGFkL3Y3RFB1TDUz?=
 =?utf-8?B?UEJZcGo1SWorTEJaYjZTbW83YU5GYXJ0Zm1PNGt6eld0emxyM0J6YmJlNVha?=
 =?utf-8?B?Zy9RbmRYNFJwbnZnM2lTbnNENXNpME5JMDR3V0ZHRHhaT3krWTN5MXdSV1c0?=
 =?utf-8?B?czQ5VGl2QSswL3IxU3EzTHNRM0prSWJHK2sxMFM5d2Fyc04vMks4enRXZkVq?=
 =?utf-8?B?S0ptN0xYQjQyc2JYQ2VoWkpmamx6Mnd4NU9OckptaFc3L2FWTHJIT2tnUy90?=
 =?utf-8?B?dUNZbGphUUI5aUdXMnBtNW5yUDY5eEROTHlVRmRZbndKZFVyUmtwVmdTbjNL?=
 =?utf-8?B?azVsZ2l4c2tCemFWVld5OVRMRWhFQTVaUUFtcitOY1BQaVY2emE0Z0Zrd2Vx?=
 =?utf-8?B?VGJzbGtmNjh2VDU4MzFabFlDbkdiWmQ2ZUNVY1B5alRaWFRPdWFBcEVFemVG?=
 =?utf-8?B?N1gycWpCcDZhNHo1cGszb0ZFNWNxVm9wM0hqK3Z0Y2pWRCtjb3JtWEJRNTRW?=
 =?utf-8?B?RnFna29tNGJseXgyQjZLQWdwRHBQcXRrbW40bFRPbDBlcGxTOW56Nnh0SGU1?=
 =?utf-8?B?K0V0UmZUaEhVbEkxNU9hOGhtekpiOU9JVGdSZkcwbWRKVzgwOGd0N2VaemQ0?=
 =?utf-8?B?MEkzT1NnMDgycjdubkY4SGdYMU5WcmJqanc1bytWM2orTnF2VHBKYnVrc0M1?=
 =?utf-8?B?aGV0NDdJM0NGNml1bEJTQU1RUE9zMVF2cWdQY29Fc2YxdHZBK08xc1krd3or?=
 =?utf-8?Q?uaus4h2dphT+Hd7ByN0ssFV6e0Eqvo8J1pLZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXlHa0lHMXhneGNxYnlEalQ5Z2xxOHJ1aFprbllxTEtkYlNnS0pObUxmTFFV?=
 =?utf-8?B?Y0pFdGZyVDFKcUZUcFVJRzBQV2pybG1hZnZVcDZpVUxOa052aGZLM3BtUjVO?=
 =?utf-8?B?U3VqbzRuWmZMOXZkbUdKeHF1ZHNkRTFLaGpuYW5SVHBuaTM3Z3IweVRTazIx?=
 =?utf-8?B?d0VKYktiZFMxbEJTcExKS2pzT2NLckpVVUpkVURRb1cwenczZ0NtdlJpNFlC?=
 =?utf-8?B?TFpkNWlhdCtTcEJPN2l1anR6aEFuUGV2Y3pQS3lvUG5uY1RFVTUvZ0NqZ1hG?=
 =?utf-8?B?dHNJNHVudDRTRFFQQTkvWEF6cEgzaHFxTlF1WWRjK1VEZVY2alVGZ0ZwYzFz?=
 =?utf-8?B?dmhzeHZIZEpuSjh6MWZ3Z2tZT2x6N0dCcGxUc0tmaUg5aWZ4bFkyM2U2UkdI?=
 =?utf-8?B?K1J2TUM0VGNvSVE2MkVYYVhraVNlWUZNT0czdUlXajZoY1BCbXNPcGczNnFx?=
 =?utf-8?B?Ym5ZdTlrNUZqbHpPdVMzNlpRMDJIKzVCYVA1MVgvNXJBT0VnUEhZcEo5N3lZ?=
 =?utf-8?B?SVRJajBWTTh3eHoxZTR5ZS8zNmpCWnBQLzlvRFZiSndXS3RmN0RacHZrUHlD?=
 =?utf-8?B?MExOWlIwekFHaWFtMXZnR3BDUHZ1dnhjRlB5TFVKSXcxUjFnYndCUFBoWC9q?=
 =?utf-8?B?RG84RXYyMHJVeVR3amdlL2kyVEhoWlk4bUx4T2tOQUtzZkpxZWxsSkFFc0lQ?=
 =?utf-8?B?T1VOakhDRFJKcG1oVDVXTXdEU3VnVzhQZ0hNTUgrUGFXc2NqYi9sazdZUGZm?=
 =?utf-8?B?T1NXdU9WcllRcW5iVDlxTGwrQ1F3RE5aYkl3eUsrN1BXNUhlTWRhQjV6M1Vi?=
 =?utf-8?B?UWRYaDdGZDlKazFsMUpSRFl6aHJOdUtVTlNWK296SU5ZcE96M1dpU2VZQ0Nh?=
 =?utf-8?B?alovZWRTeHdmUUVEcVlEN2VjbHpXM0NHS3g4K05lTnpPZ28wcktZN0RKVU1X?=
 =?utf-8?B?S2dacnBlVzRhZlFCK3ZPY2tVODVQSjcxMGUyaFVJMWZOc0YzOUV1cjBNbnBQ?=
 =?utf-8?B?Z3JmejhHaW9kRlZndkExZVdXcXVwdXJSM1dnN2dMNHFXU0ZEL1g2RDNoOS9L?=
 =?utf-8?B?YlZoa214eG9VTExQN0dyZTY5OU15bm5Wclg0bUFqQ3oyR2tMV3VoNlZVSkxv?=
 =?utf-8?B?ZzhMUGdmYnBYVm8wVlBNbnd6ckZWWW1BSS9VQXpWWU1TZHBWaStLU1oxdXFm?=
 =?utf-8?B?ZzRYQ1lsc0k0anlSTWl0bnVPSFp4YUpKN0RER0VVWXJ6RHhOSFhvUUFiVTB4?=
 =?utf-8?B?ZXl1KzRIWUhRdDVkeXk5dkhGYlREb1dCZ016UTJGL0dYczhlQ29MTFVRTE1E?=
 =?utf-8?B?YUFLWDExb3lVNkhyaXFWSWJObHBJelJJaWpkd29IbFRCMDBKSlFkMEFzMjBw?=
 =?utf-8?B?bUZDSUFUL041WW0wK29nUWE3S051NVVTN3Y4ZmEwKzJCUGNRTlNvNi9WbE5F?=
 =?utf-8?B?S3pMSEpPaFNKZXZJRDJmaUEvM0NZaWlRVjhQYVEvODE5WGU3MjJoODZOSTEx?=
 =?utf-8?B?K1lrYTZRUS9ESjBXdXZla0J3OTJ3bGtoYzh5RmhvbXIzS1gxdlFWSGNkMWlp?=
 =?utf-8?B?OFh4T0JlSENKS0xRL1ZMNnRNMnZOWXF4M0NrVUlMTVpGSUUxWklhcTBoT2xY?=
 =?utf-8?B?UDAxeWM0ZGJpUjd0Z0dqME9USzJIWVBFSkJ4ekJ0UXFzY2RPdWNBejhiZmNv?=
 =?utf-8?B?Z1BnV1hEVHdzaHBJL0swTmRZY3JzZVFNOFZXYll3S3FWelhhU29oeXk0K0c4?=
 =?utf-8?B?MzlkS1V5ZWR4SzZ1WnRjd2dyN3FQdDQyaEN6VWkzZ0ErUlZsTTBQVGJ6cVQz?=
 =?utf-8?B?ZjRNeXVFdVhEcHYwMDIvaU1lSFphZW82d3p1UWU0VUNiOHFibUo1d3RQVit1?=
 =?utf-8?B?M3QvVjBYVDlEMmkrb3ZaUjNXc3FGMm54SHUxUkVnOTZWME94K0tGS0hHVTBE?=
 =?utf-8?B?a3djQXhTZXBLNmFndnk3VDVSczRlRHJFMXo5VW1OTXhUSDVPNWZ4UEZKMWJp?=
 =?utf-8?B?b3ZCL05QWXBseDRJd1VIR1lqbVpueDVjL21FKzBRSDdhWitXcy8wd0tqdjB4?=
 =?utf-8?B?dmIrNThNRExoa0txQm1RL2tLT2tIeHF4dE9jdCs1WGVwN3UxTVRkSDFhMGlO?=
 =?utf-8?Q?GgRuzYeEb8jWH7cNs7wpV8Nai?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8645870-7f4a-4df8-98e8-08dcf8ffea40
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:28:41.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydrdwU8kkKrOkj5HMfOsMs+UXl+ASeRZEFtnv3OO6XOM/zBnRTiGPwTvhIu5fOSm7f91cHrlAtYUqjj01G45NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898


On 10/28/24 18:19, Dave Jiang wrote:


<snip>


>
>
> +
> +enum cxl_dev_cap {
> +	/* capabilities from Component Registers */
> +	CXL_DEV_CAP_RAS,
> +	CXL_DEV_CAP_SEC,
> +	CXL_DEV_CAP_LINK,
> +	CXL_DEV_CAP_HDM,
> +	CXL_DEV_CAP_SEC_EXT,
> +	CXL_DEV_CAP_IDE,
> +	CXL_DEV_CAP_SNOOP_FILTER,
> +	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
> +	CXL_DEV_CAP_CACHEMEM_EXT,
> +	CXL_DEV_CAP_BI_ROUTE_TABLE,
> +	CXL_DEV_CAP_BI_DECODER,
> +	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
> +	CXL_DEV_CAP_CACHEID_DECODER,
> +	CXL_DEV_CAP_HDM_EXT,
> +	CXL_DEV_CAP_METADATA_EXT,
> +	/* capabilities from Device Registers */
> +	CXL_DEV_CAP_DEV_STATUS,
> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> +	CXL_DEV_CAP_MAILBOX_SECONDARY,
> I think there was a previous comment about dropping this cap since OS would never access this cap?
>
> DJ


Oh, yes, Jonathan raised this and I forgot.

It'll be fixed in v5.

Thanks


>
>> +	CXL_DEV_CAP_MEMDEV,
>> +	CXL_MAX_CAPS,
>> +};
>> +
>>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>   
>>   void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);

