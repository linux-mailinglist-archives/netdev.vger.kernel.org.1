Return-Path: <netdev+bounces-122726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051DB96251D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820681F21601
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAFD1684B4;
	Wed, 28 Aug 2024 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cl4V/vMt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17F5A79B;
	Wed, 28 Aug 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841682; cv=fail; b=DIsSjKBXSWVIcc59+Je4ZQYIAgZOx8XNT6kfLgzJ+IyEEvQxzWoodG+gyAuUAwiAOug332B/GmwdjuUTzkWecOTmeTfwqFNi1sGyGpLuFgOUEcW3mcq4Ja4lOPju6/vRE8ANHmc1Z8n2tR3o5xOE3CCyDS2Ug5E9x1KpH9NFaj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841682; c=relaxed/simple;
	bh=LGoq/x+h6NzScVEAegH8QFep60DF6S5fxT5G+T/lGxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DtNY+6rxEzi5oIe6gnFctWNt+n9td3K1VFxSGi2oD9YVVD9iMS3ycvmXQ75yINMlRaxmAzvjv/nU2Ljt3Xje67MCgQFuMSRKjPSDOcH006PfwfbizBxal3MkzjtHdG4c1HoT6pGQFQ1sALl7FaTU8vYLioS9dZIKJgDMXCD2Fa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cl4V/vMt; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxxLt+HR7XzCZwVkRhpnnt5GJdMaWCc12oE0c9L2yG/SUJxCu5a7hYOH8Im/tY+eFgbeg7/sU5nOE53Qw4EPDEso9OmYebJlN/aEc+mmqXTKkkPqgY/79xZ2zFgeywhp0gd0WieffWhSJG+GFMbgTEC5RP+TxIrbEAODOexxE5e10n4lgvKYylLOe73Z+PCvolrmBVF3ur8WnGxoVWfA0DQtYPLAkcHYwk4cCP5Vbga6IbZqFb8wnWM78QRpg86/IuLbqo1P49kwPMKUHUgKlliI4OalX9qnJTlE5nfwIexw5DuxhQx4dF65IBBO7woCpThozLWf+P7me1QbrPFPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWfYBpIh45ipZ60ODm7nNbvUVG0Amd2AM1R7zB8hC6o=;
 b=xkORnmLCtkCiyYdRL/3oMWs8XKBM4YmcF4IMANrQw+Ddq8inrsCyMB+jqAJiRnXTAKfi6KlDvqttJmFq1y7K+30KrEAGa0FPwJSR79t4jn4FrmIyL3CPQ7mVgx9ElyBLf7O9V6Y+XzAmOojR40fy7TPsm2IUllr0OgJUhKxHovqZJc7C0/St2MqndzKHFGy7XYgJwsOOplalDV6cyf5smTtDaQM5KKBZnJO8OlYuLpmBAIrY7hPEKZDkhG3Ts4OHRGJMa3jDRbHzCl0VoAOm6hi5lBzAK7v+UH+eO2vm0WNyDXkPVFmAROSAjF0fWQMWSAxSj8YXA1DOQX3o7SgS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWfYBpIh45ipZ60ODm7nNbvUVG0Amd2AM1R7zB8hC6o=;
 b=cl4V/vMtYh+Y/6wMhC4RbzxeU+FgN8SHxwHKxfF+TJmeRbOaSDiRrKOX1FES3672GXbiKW0fv02Rq5uXryn+xauDjCBwsbl50a0kwkrheGFe2lnQcdQJHtmNOiBMQrOWbt2mFHd6mno1xjY2BJ5eWll5Fq0PiqPXAo0wQIrFxS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 10:41:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 10:41:19 +0000
Message-ID: <446d8183-d334-bf5c-8ba8-de957b7e8edb@amd.com>
Date: Wed, 28 Aug 2024 11:41:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
 <20240804185756.000046c5@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804185756.000046c5@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0677.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f0625e-f6bd-4f86-857b-08dcc74df344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU1McWc1WmtMVm9nV3AyRW9reS82TXF0UWw3OWk2ZHZ4ZE5xVUF1SElWYzFT?=
 =?utf-8?B?STlPZUJtazNOMHRYbVRrMWJheEZ3cnFicEVpZTJCVlRDNEs0RUg3bStZemVu?=
 =?utf-8?B?K0c1OG03YmhYR3A5ZXl6eUplWVI2UjY4Njc5d2l2QUd3LzN2b3BVc1RXSjg0?=
 =?utf-8?B?WWVzcHZpNktpN2wyZ09PUDNnTE5YM2Y2Tk1TaHBab1B6eW1CZXBXWGdWRHZu?=
 =?utf-8?B?R3F6eW1jYUNFZkFSY0VsN2JxbFVpKzlzSVlFUDh0QWpLOVUvdU5ycmRFOXU5?=
 =?utf-8?B?U2g3MU1GbmF3VWtuL0N4cStOd0hhR1lkUitRTFhNc1NISVVrdjZMcStubjV3?=
 =?utf-8?B?V1VmK01pVFppeGpheGkwTlFKUTFkWjIwMlMvS3FWZitQSjRNejBObnJFdDR2?=
 =?utf-8?B?R1BHZ3czQldEQ1BNTmJCc1pRSGhxaVE0NDhXL1FyNnRRbUYvTkRYYnh0R08x?=
 =?utf-8?B?aTFJR05qSGVRdDZVeUp0ODQrWk1mRTFKOG1wZVI3bHJiV3daaktMai9YdGhS?=
 =?utf-8?B?S0pzY0tIMWF2QXc4MHN1R0pOS1NRS3hJS0N5MVIxOEZqdm1RYVlPT2orR0xH?=
 =?utf-8?B?dWgydHB6OFZkUlBhNDFycTVBdlpkQzcyZittTkFNWDFHT1lWaUdsK3V4K1ox?=
 =?utf-8?B?SW1WYVA2YTNCZkd2TUVwejJoSkF5eTFsUmdOVTVTRmkrZStKOXQwUDEzMkkr?=
 =?utf-8?B?R2RLcG5iRmJWTFY3N3dtcXNkTGF0QWZzNTFydEY1S2JvZUhUVW41UTVuYWlG?=
 =?utf-8?B?aC8rK1RmOGZMK29XRTJRQWxyZmpXTjAvVkZmTVowdndVQkpLckt2UXNSamM2?=
 =?utf-8?B?MUVFTThSUkttM0dWYkV4L2ZFWFJPS2c1dkNJSDdlM1pqWXVidENoRHQvVnJh?=
 =?utf-8?B?NVlydURPV09NNUFOQmZOMHZnc283R1dwMmhnbkIyQ0hyenBBeGRpUnlvdEMv?=
 =?utf-8?B?YXRHcW5FQ2p3eXBObnRyaXNYRUpGcWROb3o5UXZjM0JxN1JsOGJpVDAwV01N?=
 =?utf-8?B?SU53Nmt2ZVJyYVRtYzFBVWdBcFN5Y2xGTUdmMTNFdDI1eWV5b2FSMG5lejlj?=
 =?utf-8?B?dFJjZkdnWjhPMWw3ME10L3FOWmFGaUlyMU1EUDdhaEJzODhqdDFURmQrQVRD?=
 =?utf-8?B?TEpkZTFQdWUwZ2s1eXozUTRhSytOVFBhMmtwTGlEVmZGWEJYUkR0Y3g2cTUy?=
 =?utf-8?B?TVJNdUF5SEI4N0dOcGhtNzdEM283TWhBSDlVclhoSVRLQVB1RGdFcHVwSHB5?=
 =?utf-8?B?TVh2VFo4YndOeGozNmFNaFFXZW82dUlVSGJBWDNXVml5K0VscTZyVGhCRjVx?=
 =?utf-8?B?enVIaUZIVUVZVXFEd2ZsYlZhdDduSHdWTC9rY3NmcUNKSllMb0kxVEtkRDJn?=
 =?utf-8?B?OSs3cGNlZVEwUDlUTkhuaGhlWlZHWEdIOTJpcktCc1BxSUltUWx5OUQ4RE9t?=
 =?utf-8?B?dWZKMjU2TjR4WDZnOEtUSXdjSE4zczVSZ0NTM0VIN3hYbGY0NGI5T1UycDFR?=
 =?utf-8?B?cklGVFpkQ3dYQkFqOHpaQkdPcWVESWh1NHhUQVQ4b2owRnZ4RGVqcHd5bmlE?=
 =?utf-8?B?cEhQbGZqQm5iQU40REdWSUMxbTViVlhLRVhLUm5qMWw3bzN2NEJIOXVsNEVX?=
 =?utf-8?B?V0o4RjFIQ282b0d6K20zWGdBdHYveEdOUStUek9oQTZmZ2l3Ym5IN1VmNnVq?=
 =?utf-8?B?OThreFMxR1ptcjJNbXhRbExxMnVkejFCekRtb2FEOWtVdzhjUTdJYUM5ZkNO?=
 =?utf-8?B?Snh1OVZRQ0hldWdjVzg4RHFrMVVGVUdBcWFzVHh3NkFvYnR3L0JaUTN3T2Jx?=
 =?utf-8?B?ZnJvcStJNXA1WWZqUUxtUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmJOWlFRdUxWOU5pSUFQM21FMzFiR05SdHprS3RES3VlejN5VndZeTdFb0hO?=
 =?utf-8?B?TDVrZG9XMzZGYjVtTkJRV0xRV1plQ3FNZGJBcWYyREt1TTdldTRCNFpTTU9G?=
 =?utf-8?B?VjlMWnBQd1Jyb0F5dWJrRE5LR3dVQmNUdWpTYXh6aldjeVRXaDBKcHR0SWs2?=
 =?utf-8?B?R3I0N3hSb1lteHVvYWxRUVBmT3JwZ3p0TXA5dnAzN2RKU0JzRk9LbWxJUTJn?=
 =?utf-8?B?aWU5WUhLSG1xQUp0R0NqK3ZDTklEWHNtbnB4SmZUemZ2QUFLOGI5ejFPcjZ4?=
 =?utf-8?B?aERDY0lFMzAwYTdUMklKbnVheDRrWTdvV2dKa0xrRGlhNU0zVEdHdmU3Z3oz?=
 =?utf-8?B?dGpneDM4b2xyTkdzUzlVU3lnZkJaS0dEWXRmL1NTMCsvNHpJcVRMNWxQV0xB?=
 =?utf-8?B?UXpsY0dDdWpTdTU3MTRYY2VuVGw2UUpDRTFHWFRLbysrbG1pcDRBVk8rck1j?=
 =?utf-8?B?ZmNUaXR4UUVGVVRCN0p1NGdrRWpRZDVxeDV5MUxFc1ZXSUY2R1BlU1pGbjdT?=
 =?utf-8?B?U0ZwOGNaNENXcitScGNrWDMyY0tJNDhjck9pQUlreW1WenNIdWJvZXhzaTJQ?=
 =?utf-8?B?eEUyc1VoS0pFL0RBYzFWaXQvOWhrSFFHZnVYcU5wOXlSRW52eEVOc0phQno5?=
 =?utf-8?B?OVd2bG0yYTI2ZDlZTWM4ZU1QTXg1b1hJSy91UVY2T1J2THJTd1NpWG5mVk1K?=
 =?utf-8?B?ZEswMm9JQWdwTkFza0VSTmtzTjhPT2R0TWNyUlowQkRURC91TVBnZy95TWdm?=
 =?utf-8?B?NnU1QVljbGRzeEZUR1VFNjlwTGk1bDRIc05oNm5uUUxPOThWSFpxZlRUTEdn?=
 =?utf-8?B?bVo0RzZpdmFHdUhVdnRsTERMcGlsaHNkVDZ1RjBuY2toRG1RR3dmRUhON242?=
 =?utf-8?B?MlNucTVDaVdEY0RyY2Zxbm5JNTZMV1FtMkYwT3dIVkExM0tvdUUrTHNZVHRX?=
 =?utf-8?B?L2UzWGliTXAwZ1ZxdEFsTGh1WWVPd0FYUmUzdlJrall2QXJBZ2pzM1BqTWYx?=
 =?utf-8?B?T2p4UDUwQzJlR3lUR2Y4K0M5WElCZDdIYUZYU3p2aXpseDJqNHJjdWppWHQy?=
 =?utf-8?B?VVRDSmsrNHRremlQU3EvbUtoTjJSeTJQUEhuRGFKdHZjK1RJNFFqSEwxdEJT?=
 =?utf-8?B?OHZlZXRuSmJGZXJrcmQ2LzVqYndNeU0zTGROMlJJQWh5UFY5RXFZeitqQnFr?=
 =?utf-8?B?Ykx2QXp0TjlQVXkxWGp0OVIvWGZIY3REdVhVQmR0a1VHMHcxMy82UXNFNHNr?=
 =?utf-8?B?QS9xSVkzSE00Z3ZMdENjRDI1ME5jS1pIK1g4bTJZTzZ0MXdhcVBHS0lSRGtR?=
 =?utf-8?B?RitYQUMvSWZIOTFISkxzZEJmV3FWVmk0MFNSUnFlUG5wcHIyVWwvL0xLZEhG?=
 =?utf-8?B?SXBNaEpOVStDdkZ2ZjhmUjZ4bG5ZWGxGY05BZzdiTVFoUHJxMWc1dHNxKzI1?=
 =?utf-8?B?dk5MV2sxZHVidE5MUkdseEYwTnBmMTVRSkZzeVRZKzE0eHE0TTI5eFFjdGlw?=
 =?utf-8?B?UXNrdU5COExWNFc2Q2xVUDhRQ254cTl1K2JBeE5iZXVIazh0NTRCdFY1Z0pY?=
 =?utf-8?B?OHRtTUZzRzJqWXBoYWh6eEFzbzdoa3VnTmRmQU01OElUMG5GcklNSGtCbW82?=
 =?utf-8?B?V3ZOeFZISDM4WFBxSHFrRWp2Skt6UGpNZll6NEQyeDRQdGpMVmc2TXF2Ykpj?=
 =?utf-8?B?QVBVSWMyVFpkdlI4YTZ5MUZSUngrMStXZFBVSStNd2UvTUE2Y04yYllIWHhB?=
 =?utf-8?B?WkdBNkl0OTZFR2ZEVUV3b0x3d1gzUWhtaW92d0FZT25IYml2dnozd0N3YmRY?=
 =?utf-8?B?ZkU1ZFZiZ3Q3QWMrVWRST0N6bVZUY25FU3pxZ1VNNElnV0MrNEg4RFpCRmNI?=
 =?utf-8?B?NHhjUE8yZDUwcXdDSUQ0VGZkZzNWRVI1Qk9wUnNKNW9ZQkFjOHVEbmpveVR3?=
 =?utf-8?B?TEk4dW45b3dDY2lVWDlwbnQzRjdOdXRZQnNGVncvRDJyTW1QK0ZzcVkzTWEy?=
 =?utf-8?B?TWZBNmxCNEd1dXc0dVZyOHhXMnBvTnByL2JyTWJrSW91Yk1TZlBpUzdJZ2pW?=
 =?utf-8?B?NVNnSFBxMXNOaFhjNmI1ekxNV25LLzdnbjVKK2x1SndOSTE2RDlqUkJXL2Vy?=
 =?utf-8?Q?29YUNsGxmoH1ltiMU0hJCWfPz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f0625e-f6bd-4f86-857b-08dcc74df344
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 10:41:18.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCJ0aBAckObfQj1OYk8IW/dB+Htb8lObDlXpgvIvJ+uSr7j1Jq4t5O3RRr62xa8x1mw+06d+HdFVBUrGFE3nHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431


On 8/4/24 18:57, Jonathan Cameron wrote:
> + }
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @endpoint: an endpoint that is mapped by the returned decoder
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>> + * @max: output parameter of bytes available in the returned decoder
> @available_size
> or something along those lines. I'd expect max to be the end address of the available
> region


No really. The code looks for the biggest free hole in the HPA. 
Returning available size does not help except from informing about the 
"internal fragmentation".


>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
>> + * is a point in time snapshot. If by the time the caller goes to use this root
>> + * decoder's capacity the capacity is reduced then caller needs to loop and
>> + * retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
>> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
>> + * does not race.
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max)
>> +{
>> +
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridges = &endpoint->host_bridge,
>> +		.interleave_ways = interleave_ways,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root;
>> +
>> +	if (!is_cxl_endpoint(endpoint)) {
>> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	root = find_cxl_root(endpoint);
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	down_read(&cxl_region_rwsem);
>> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +	up_read(&cxl_region_rwsem);
>> +	put_device(&root_port->dev);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max = ctx.max_hpa;
> Rename max_hpa to available_hpa.
>
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
>> +
>> +

