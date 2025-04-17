Return-Path: <netdev+bounces-183912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B0A92C96
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917D43AFA18
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C84F204F6F;
	Thu, 17 Apr 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DcJMd+Cy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239141D07BA;
	Thu, 17 Apr 2025 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924949; cv=fail; b=dlB9qYadqKI3hRgtgwmJVT3qjsUc9bjuFntOdF8OhCUr09fIjiTuQsJ3ON0NfRMnj8oF+/XykiIi4Y6wniOhc6Q/dmevKGRp81BI9ljRl59Uiyk6cvIKBdgzsb8HwUM3WdyQGAZKc1U+DVPHmQ5VGVwDPoaT+TEcL/IaeROG+Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924949; c=relaxed/simple;
	bh=RldQ9t4Z5RnwlAtQ3KfcgQMFDS3emUNM4lvG8mP3dF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RR+N8rPb2Tyuk3ET0IGe3mKKIOWylI8E/4P29Q75qD7h4s4c8cY3k/xM58ycY08NnGjdWhrK72y10y41tidN6L4Or2UZtC6Q40P4gjjbBpvVv3xiRbjIlxn7PxCI5W6+2+Lh1LIM2bds6WUHbO2nsQoXNa2EoVFLPvQKkWAluFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DcJMd+Cy; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s73w59lwAKK+qkyjvqYmMmLyQio34oZFG7pf52rsaNqRjbF2WQ2wsbA9JBmnj6kcVMwPIVct0Hbvna6VfeyorWYUz7YDRfpdQSXFhr7AQpuBJv+A86+cF3woyCX3fiveL0JfIDzq7ITA4BCAyTCWa7BZroP8ufk7neDrTFfUS0v8fBhePL+CsnSLARShp2Db97FxIhmHRAFPY8m4Otgej88lbZ2sH2SaZA1xqhyUzJSIETphkYWCg6njDVuajXWMiZZL3oGajx4sNH8vX17Q8iqkxlkZehUWTBaJGdfwo3A9NQB9KSdgTVXa5dmf2AkAwhlIzzb0/CGtTPu+MLaQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjdo3M7ATq6GDbKuQdRJdar0eGndjuzIDAiuCPOeelE=;
 b=jMJiKktqBJXtZqdiNlv3JD1yZFYUMGPznOD5mDw9oictgTT2W03pdEO+DITMgo4vZSN2kkqHSBW7sBK2ToZfg4Nx4G+4HdPoDQwUZlpuCGfIy3qJDH3Qzma3CW0/bORR78/hKLVZoCcyDSeWaM0y1mXildOivc3nYDg6/dy+0v751uE/lRYOYpUKoHaR2ZmPc0Q/vk1vP7aWpJYJsrM/cEPN+8hSsc6059kurbAyK6v4AUknGvKC/lG2CO8kFibhMKRsqn3q1GaMTZgyl/zXpBC2w0MQhE9dR//6pNy3UjrcrSEOXFN5sqK2Xr/aSms8dT0UPc4iMainQvVw37R9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjdo3M7ATq6GDbKuQdRJdar0eGndjuzIDAiuCPOeelE=;
 b=DcJMd+CywdhJ2+2+INW4pnuSmuQA7sjiw9pLEfEEjFBYJhOV8Lm1oGXiWkBKutFpn4ELpcykRSF7EVBUws66QMX/43oiq0TrS1fwdkdYmHjibga0zea+D/rv6ihp2tG3NJ6sIDnt6BsG9tvrs5cDTTiawihsVtVqdBrz2yw8G64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 21:22:24 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 21:22:23 +0000
Message-ID: <eb1e5fca-7a8b-4ff1-8222-ce2eb16777dd@amd.com>
Date: Thu, 17 Apr 2025 22:22:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/22] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
 <20250414151336.3852990-12-alejandro.lucero-palau@amd.com>
 <20250415145016.00003725@huawei.com>
 <eb5f16f8-607a-4c71-8f81-5cdb4ff73a75@amd.com>
 <20250417173650.00003ee0@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250417173650.00003ee0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0302.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: b88bf273-98c8-4e16-8b3d-08dd7df5f1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDZKeTRRRHBMZ2YyRUc4V0FUcktqKzdSelZTSUtEUnA3Zzc5ZWp2WVJRQXlv?=
 =?utf-8?B?S1B4bHI1a21ldWtSSUhBbUNiL2loSVVmTU1CS0VxS1ZOOGMxeDNLZFh3WXdX?=
 =?utf-8?B?alhBUGhvR3JsK2k2ZENPZmI1c2pnL2Zicks5cmVBK2FQNGJHdHR0MHJmaFI0?=
 =?utf-8?B?L2IzNll3SHA2WVpRWklRUzh6ZE84VE5uZlM5dHZaZGs1MzlJM1UxcTNJaHVZ?=
 =?utf-8?B?djhpTUpnQi9FVTMrUzNqbm5OTWlwd2dqd1YrVmhLbDNEbVQ3Znp5ME4rM2tW?=
 =?utf-8?B?MEJpVnhBRDRwcGVmZEdLRjBFRFd5dktUS2xrS2hQRlAzWFNidytGSldBVDND?=
 =?utf-8?B?MFpaTE1wQ1lhR09oTFBvUHZHWkZJSVhlMUNWTmYzL2dKSWJJTWRJbXRCTFg1?=
 =?utf-8?B?UW5vdUJnV095ODl6OUNERnRrMGVhUGtpL3lQdnlFTlhPWVNLK1JJYVErV29J?=
 =?utf-8?B?L3RIN1o0cUtobHd5a0M3THZQcnhlcE9lb0k1ZEc5K3BLdnNHZzBJMkUwMWJ4?=
 =?utf-8?B?QlZocjAwS1ZKWkM1WlVDNjNQcUt5ZStHN0xkUkFKa2JaeW1qa0FCU2kyeE9B?=
 =?utf-8?B?STdLNHY3UGNWdHFiaUYvY0dRbCtpSGZWYm5mNXlvei9HRUwyMEV4b3R6VTlO?=
 =?utf-8?B?MllaM2NTNk9OS1ZhcnIrOFl1R1lDYUl2aTRkNjcxdDREZExnMmxxbXpZVmVW?=
 =?utf-8?B?dXdMN2llVlpCV1lWM1pQN0EreHFrdnhxM0NqZWtWTFlZYmp2cG9lRkR5YXBk?=
 =?utf-8?B?ZkhiRkZIOGp4dUZuU1FhSFh0MkZUdUVrWno0blg3cUtUdjc1OFZzbGtMMHdm?=
 =?utf-8?B?cnFHbnlROWRQbm5TTFdyY0RvV1RvdGxXbUYwamZLZnBTZ01jaU8vck82K1Yv?=
 =?utf-8?B?YkF2VDZNS3Y5dEwrZStYek8yMjJVanpOSFN6aUNxc2lSWlJuOHB0eE5ldE1o?=
 =?utf-8?B?UElWbHREY0FxOG9rK1p5YmMwTXEyQmlFV2RCOGhHcTQwaWdXUTNnNm1PTG1C?=
 =?utf-8?B?V1paYldQM1BUSkVhV3Rua05DdVFmUGFmeS9CQXZBOWlvMUtmeEx0amlRSnNu?=
 =?utf-8?B?U1RqUmFXY2plZ2RMNDRKd3g2THVTaWx6MXVWY2FVS0ZJRnFFcGRpbnVyTnFB?=
 =?utf-8?B?bTB6K0RDWUdBZkRpeFVHbXVqQVVvWFRicS9DYnN5K1lVK3plRkx1a0YxWWl2?=
 =?utf-8?B?VTZHTUx4bTJBeUVPbmRkM21RUDZYbFNDWmVIaVZGdDh1M3RWU2FCOU5mNlIv?=
 =?utf-8?B?U1FMVUYydnkzZFA5MFlaV0ZRcGpuZllEZWRtc3FMMTMvVUNJZ2xpd1htQjVy?=
 =?utf-8?B?L3FhQ00vUVhmSVVjVzJ0TTluOHJEUGlzbXNRZDBYNkhkSEhkUUFYemY0NERl?=
 =?utf-8?B?d3JTUUZzSkt1TUxsaVgyeCtwaXg2MlRMaXJ1c1ZPbFFETVEraVZ6azBFaUI0?=
 =?utf-8?B?WFlVUWN2MTROUjV2S1JBOWJ3YlBaSkhrMnAzMVJvbVdzcmFrSVRQUGNMODFF?=
 =?utf-8?B?TGVjejZwUGVjcEpGd3BUWFhlR1N4RFdNMHdtS0NuRGZXRW10MXRDbjdBMkli?=
 =?utf-8?B?dncyTWQ5UEsvTFNZdmZBU1loTEYzZmVOUUptMlVTdGMrZVFSSTJjY09ZMXNr?=
 =?utf-8?B?OUdmVkpRTWFjOXc5TUVNWElKTkdzTHFhNjNjZXRvbE51U1hPdm5oRUt1dDdx?=
 =?utf-8?B?WFhqOElmTml2SFJoSVRXczhYTjhaMTdrTEJxekVZaWpPSEtha0hNcUZkeW5j?=
 =?utf-8?B?WVJvRGdsUlVaUTdiM2V2emN1NzJaaW1WamtYNi9jTHVFbjJ4cDVQV205amNx?=
 =?utf-8?B?TUlpS01pYkxSNXZTUXM0SWVva2NVeHd5bk9WeDFmSEd0SWdtN2YxL2VXSzNx?=
 =?utf-8?B?dWp5R3ozTEswV2ZyaXdkQ1BwN2UwMlRIMnp0NjB1UEkvd1F5a3pMUXFmVm5C?=
 =?utf-8?Q?4z0jmPg7L7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGp4UndNTmU3SWdlNXZROElVK2huRmxBM1c0TktXRWQzUlFlaFE4dXU5a1F1?=
 =?utf-8?B?SGYxUWZQdWo5V05hYzZFWVZnR2NaS053S1RIK0tyWXYyVERLeEZaQ24wRzlT?=
 =?utf-8?B?eFA5dVZ1WG55S0FmOGtWL01XQU9JajRYMVZEQ3hJYStlb2RVNGhoUmx3bEcz?=
 =?utf-8?B?RE5nTyswWHFsMVZ4NTBGUlpadjAxbGVkMXBtSHlqM1Zma042Qk1FMDVjd2Ur?=
 =?utf-8?B?RmFrVEo1Z21QcUJmcWFCZWNxNWtkRzVhR3N5U2h3VFlLQ2JiN216OXdselJD?=
 =?utf-8?B?ZkMvWFpvZ1cyckNSS2w4WHZoTmRrcVhlaVEybkZ4SWlCck15SVg2SUZzSzhj?=
 =?utf-8?B?TG5MVVVnZHNkVzV3ZHZLMzFqY2UzUmtxeUNuM2VETGt2TVdaWW81dnlZWkJ1?=
 =?utf-8?B?R3FoY3E4Tmw4VFVVZTE2NVVTdWsyUXY1NFhFMnZsVnF3eEVPTHNnWUtEbmlu?=
 =?utf-8?B?TVhrWDVSMlpua3RvR1pkVGVlWDJ3b2NTK3hFaHpxZjNPY1h4dll0WHhaVUhz?=
 =?utf-8?B?QzhHcGk2cUdzcVZvRytvZGRPTTZ6bHJSWit2NzJ6OFhGREZJUWp6d2pPY2t4?=
 =?utf-8?B?YnNzYjJxVFZ2Q1VKRU1HSkZMR2Z4YVg5NWFZaXM0cWNDSy9YbE81M0o5ZnZS?=
 =?utf-8?B?NFJlVzJiU2pIZytSN2lxL2RWdjd1aVBiMStLNzdTY01XaE83aHd2RjdpNElu?=
 =?utf-8?B?TjdVd1pRZkp1SHRWekY2SlM0VngyYzQrMys0Tk4yL1ZFMjlCTVptRm5xU0RN?=
 =?utf-8?B?R1NuWnVkbHlzdFdTeXNFWkVqZFVPNjh3WDFieXpIbi9GcndQN3Q2aDYraThK?=
 =?utf-8?B?VnBjTVNIYTRtVlp4TVovNlczS1BPRzBDT0NFVkRUNFJSdUhwZHNOSzdNRFFw?=
 =?utf-8?B?QnJLdWsxWXpXOUlpaHd6WHFwWng0ekN5SkVYNlgwZmJybXFXRUZJK2hJU2Fm?=
 =?utf-8?B?SmhubkpTNk9VK2cxN3dQaXprUkxzUGs3WEkvVDNaNTAxVXJIVUdqZWNUWWN1?=
 =?utf-8?B?TGxSMXFBUnorbGIyeTcyTnVwR3lXL0VmeVFnc3VNcEdhWThzZGZMblNMQkVj?=
 =?utf-8?B?RTAvS05hYUVzdkwvUS9oTUhaMlRoNlVWMlE3clNBSTJQN0VhUGJuZEhEekQ0?=
 =?utf-8?B?UDhjMitvOTd0bWtLd1VhMjJoeU5QMnFSN2ttcGhKL0g4bk0wQVIvNEhVU045?=
 =?utf-8?B?ZG9iSGJ0OHZldThndCtHdjZ1YUdpQmZjOERrS21HVEJCeCsvM2pwK0NJeCtD?=
 =?utf-8?B?aVlOQktDVGRXZytSRXVvS3VmL1hGcVBJUkNoS0ZQY01CTnhUR3MwN2VOVmFa?=
 =?utf-8?B?bmRwUG85RDJYa2F1b21zOUYxUFhid1IxUUZtRE1HYmhrMFF6N3J1VkM3aE5q?=
 =?utf-8?B?QUFRUllYMm5scVVCSFE4L0VCSTRoSnVPdWZ1bG1yelEzRTRsTmpqaHgvTnBE?=
 =?utf-8?B?b01mR01wbk1xRW4vU2xDSWpaMmhnaVhKeWV2a3VXK3cyK0xSaFg1MHZLL3Zq?=
 =?utf-8?B?VUY3a2RoMHhlU0Z5djVOWGR4ZmxyOCt2OTNZRmtwMVZoMGdQSTRpejVJenV5?=
 =?utf-8?B?dHBWb0pHdldtRE9sVFZ2ZytweWFaekVnaW1WaS9qbGhFT29WaTBjT2w5Tlly?=
 =?utf-8?B?eVdNT25yREVLajlMOGoyYnp6OWcyQkJBRHd4TS9weFdqbWw5eUh5bExtMHdD?=
 =?utf-8?B?OTRTL2FaYTlaaU41Y2h5M1dPVGpYUC9wM0lFbEJKTGJyZzlXYjZPMXl0NzNw?=
 =?utf-8?B?R2dKMitpVzlaRFUzajRNYnlTYkdkM1VxRUV1WUR6Y0pPSHFuaTJ6ZkpaRC8v?=
 =?utf-8?B?SmgzNlJDYkd0TjU2NzFBeG03TzFiMUNTZzRmRHR2V0ZqZFByVllzVW1aK29K?=
 =?utf-8?B?eEJuNDdJeWFJODBPUi8vb2RoK0RTR0I4cTZuVTlBaksvT09NaVdqR3d3K09z?=
 =?utf-8?B?S09JeU5rcHdXNEV1Y1VHUFFDNi9zUHVSUjJiQjAxY2l2Z2tZMFF4RTl5RmNr?=
 =?utf-8?B?MytaaXc1T01DZm5ab0ZQMzVCNFZsSnlFeExuamR6amlJalQ4L0tQVVcyODht?=
 =?utf-8?B?OEdXWXRBL1VNbk1MOVdBNFpIRG4za0RwS1BNYzBhOG0xRnRDZXBrYlE0clBk?=
 =?utf-8?Q?emRI+mrDpAV6HNANNChxcCmbt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88bf273-98c8-4e16-8b3d-08dd7df5f1b3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:22:23.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoqnvuYW2OreW3533xIJ2Lkbhef8tYWH4OroOr3jtkgzN7ca525vijDl2ItWrYEtekxwM26Tmy0+cwSS9crUQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868


On 4/17/25 17:36, Jonathan Cameron wrote:
> On Thu, 17 Apr 2025 13:11:00 +0100
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 4/15/25 14:50, Jonathan Cameron wrote:
>>> On Mon, 14 Apr 2025 16:13:25 +0100
>>> alejandro.lucero-palau@amd.com wrote:
>>>   
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> CXL region creation involves allocating capacity from device DPA
>>>> (device-physical-address space) and assigning it to decode a given HPA
>>>> (host-physical-address space). Before determining how much DPA to
>>>> allocate the amount of available HPA must be determined. Also, not all
>>>> HPA is created equal, some specifically targets RAM, some target PMEM,
>>>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>>>> is host-only (HDM-H).
>>>>
>>>> Wrap all of those concerns into an API that retrieves a root decoder
>>>> (platform CXL window) that fits the specified constraints and the
>>>> capacity available for a new region.
>>>>
>>>> Add a complementary function for releasing the reference to such root
>>>> decoder.
>>>>
>>>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> One trivial comment inline.
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>   
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 80caaf14d08a..0a9eab4f8e2e 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> +static int find_max_hpa(struct device *dev, void *data)
>>>> +{
>>>> +	struct cxlrd_max_context *ctx = data;
>>>> +	struct cxl_switch_decoder *cxlsd;
>>>> +	struct cxl_root_decoder *cxlrd;
>>>> +	struct resource *res, *prev;
>>>> +	struct cxl_decoder *cxld;
>>>> +	resource_size_t max;
>>>> +	int found = 0;
>>>> +
>>>> +	if (!is_root_decoder(dev))
>>>> +		return 0;
>>>> +
>>>> +	cxlrd = to_cxl_root_decoder(dev);
>>>> +	cxlsd = &cxlrd->cxlsd;
>>>> +	cxld = &cxlsd->cxld;
>>>> +
>>>> +	/*
>>>> +	 * None flags are declared as bitmaps but for the sake of better code
>>> None?
>>
>> Not sure you refer to syntax or semantics here. Assuming is the former:
> Just the wording of the comment. I'm not sure what it means.


Ok. I just want to make clear those flags fields used in the 
bitmap_subset are not declared as bitmaps, just in case someone points 
this out.

I do not think this is problematic, and a good idea you gave me, but 
better to comment on it before someone complains about it.


>
>>
>> No flags fields?
> Not following that either.
>>
>>>   
>>>> +	 * used here as such, restricting the bitmap size to those bits used by
>>>> +	 * any Type2 device driver requester.
>>>> +	 */
>>>   

