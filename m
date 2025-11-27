Return-Path: <netdev+bounces-242202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993C6C8D71E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487A53A9D4E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469FC2D948A;
	Thu, 27 Nov 2025 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cRpCm5nR"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BE2D8DB5;
	Thu, 27 Nov 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234537; cv=fail; b=gCk2vAoLmGnF3YGm2poMM8crKH7Ly2SIhL3lS5S6C/QYfgSHvk92HI7Q8INSYk84oLn3jtCRskldkrR2EY8rBAPx0/ahDWq9CHAMURI8+gsTP5OLXyXyV4xDlssQPPiT4429GvQd/sDTHAsMOK2G/t0Sfc93X4H3febja/lv4U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234537; c=relaxed/simple;
	bh=wTOhiGil7XuvnxtyMOmPWHg5T1hpds2RWaX7bFElXCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mcxijswDlULW+S71s3ZESSaRSND1AVa6D0Gl6eK2Rs+guX7yHUXEYawpW2Avmd+wraMhRvvFAZCCZEmspRHsNmeoXki6mBNYyTx8r/QFc872vplzooicQYIKKLj9Uas4pBWhPpZh04VSeIXNo7h7YRN8ndJRXcIZqmL76eNVKVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cRpCm5nR; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRlrxSYcH/XkJUHCd3FcINbbQbUnp/h5fYB/6mr+DnFslr3aLQWxKVdeTuBalIUVnHMyZ/5xtfQrnsDHwvj0yb10OKjtQH1buohthsJkzJysBl5lTCNkjYL/Ha04QeXjW6O86WJGuN0QZ7mO5f9tzu2JWyKCpAj0Mt21Nd/8ThLkIO8JKXUL2PTWjH9S227GKw7vftfYstfBTamVHU9hZW+Ge0FZ2ICOlwWwMcxZ12uArNiVrARuxPSxM7M1GPoint7Fh7QxuVSAvMOhdO4MVj2jNh9WmDzzV68oCVkzxR1pr5yt9tBx7sWnbPz7CZ1zIlI6zN9wq6BXjc0VvPWkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+r+Lrsc1p/zE77OXTUHM5+t+nGLnI/Ok503M8hhuzrQ=;
 b=gOn/GtjYqU2nvYwBr2bcCinRTMJMfa3bNiVWBvcDRQzr0EzUGEF35IGTu/mXBTdJxOCwvOwzoOoFRM00RdzudlMLrVFHnzkSs0kgZfhsoB8zOgehOtuhOdmgSu2wP8VPaJPnBG6YnSXRKqT82ske22z1RUuYAaCO7pO8czYehveZsahBs6M2Qvna2av4LPjzYxCNg/9roouwqrgA/mVKweTOkLtXLGHbTvv0YFM3MtJUhRNQi+sGULlm7RJcveeV3zx3ZLw9WjNneB4jxMIbkDJ+h3ns9v5hFjabxmx4/NNrMKqdDua2a2bPwgl5ky3OvPnlS64jHywI5dhKLXGPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r+Lrsc1p/zE77OXTUHM5+t+nGLnI/Ok503M8hhuzrQ=;
 b=cRpCm5nRLOdGExRidiIJ6uYfW04yyOAxfeUxk4+k7m+7nSOB20VLrJMoCgvZwoFMaysd2WQS2eAoyIjUp9+tZ1GWzYtuSL5ed+NDmJbHRAV0ZKhKc6hexRIqh0NxIAyJ2vlEm5qrpCu8HResmOvBe5EnoAftUC3vFg5P/J0iddo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 09:08:50 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 09:08:50 +0000
Message-ID: <ab182638-3693-422b-a7b6-b3630a35a0be@amd.com>
Date: Thu, 27 Nov 2025 09:08:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 15/23] sfc: get endpoint decoder
Content-Language: en-US
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-16-alejandro.lucero-palau@amd.com>
 <4aab1857efeaf2888b1c85cbac1fc5c8fc5c8cbc.camel@kernel.org>
 <34f7771f-7d6d-4bfd-9212-889433d80b4c@amd.com>
 <7f1e56067bdc46195a9e36f914aa103dc76d4f7f.camel@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <7f1e56067bdc46195a9e36f914aa103dc76d4f7f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb36859-bf59-4f0a-abd3-08de2d94942d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEpkb3NMS3k1Yy9LYzhzUXRnbUtOd3Y2bFFYZVZrKzN6WG1FaDNhU0d1V3E4?=
 =?utf-8?B?dlh0UUFqc1FIUEhHbDFXRXJyckRabHdIbzR3S2x2dWpLMCtUekFrUmpsZExD?=
 =?utf-8?B?T2d2dnBjY0o1cVR6dExVc2ZmcXBoSHcySStFR0FyN2wvZGhDUlFVWHJpNVRz?=
 =?utf-8?B?MHpDUzFrWEdnbVQ2UUdhditYbUV0MHJ1SWVlSmlCT3FYVGxxUm9oQzN0Ylo2?=
 =?utf-8?B?VzBOc2xZanBmZVJETU1aaVZwb2ZGWW5YZDZwQkVxVFlteFBuMXdiTWs4aDRO?=
 =?utf-8?B?UTB5LzgxaXNpV3VPNjU1T2ZUYnI2NU5oclRoT0luWnZ3emtvSDBGeTExcmNC?=
 =?utf-8?B?bkg3cUJId21ZaTE1K05aUDFsNytMTlM3d2ZSUnlYQmIvZFoybkhDNXMxTFY3?=
 =?utf-8?B?YjRReGlqUEc2ZndCNWdwWk42SytYbVhpM0xzT3M2NW1XSjc1dTEzUVdNR0x2?=
 =?utf-8?B?OElpcmloWGw4cW5kcGVjYUswMmhDaFlSdE1SbGFoNHozS0hNVG1SNHFuUWlm?=
 =?utf-8?B?cjRkOFdaM2pMN3VONFhxalBENEoraFN2aDV1VE1INXFRWkRaRkNERnNMTzI1?=
 =?utf-8?B?UDkyS1hBWHdrRUlGKzBudGtyM0REOWNiVitRaVAya2lVWXNzL2QzWGg2c3kv?=
 =?utf-8?B?SmszNWdqMFFNc0tFb2M1endFTmFCSHNRTnZQeFYwMmdYSFI2a0tJV1VSWnp0?=
 =?utf-8?B?R2U5T0lKK29jL0VKV05uaVBvazFDWk1lODY1a3ZOL0tERjEvUDlxK3cvRndC?=
 =?utf-8?B?K3RVeDZPZkQvcGdtcThxdEVuN3FGYzhsY1dLTTdUQjdFQStNK0dPQUhCcm9j?=
 =?utf-8?B?WFRuUzl6d3FjUVlJbmsxUzFLdk53Ukx2ZUVaZThuR1hrbzAzWEJRY3pFT0po?=
 =?utf-8?B?Sit4K3k2aDF1dldQbmlXcUNyWE1CWWdnRVV3R1p0cWNiN1R4dktXZWxOa0JP?=
 =?utf-8?B?bjV5TG9JK3dxbGlWZXBSMGFtbjVrOFhHT0M2ckQ2Z3ZuVTVIeWNQaEZBRjkw?=
 =?utf-8?B?MlNRSUlYejlxNzhmbTVVdWdZeDdVWWFjOVg4cFNPdHlSTVk2OS9yUDFSMS9u?=
 =?utf-8?B?K1ZIaDNrVVgvVW9uVVhLdjRkRFRrY0pWcEF5aVUxbUx2QUY3VDZEOUxKbVVS?=
 =?utf-8?B?RlpoMFg1S1hPWDhOYVZlT0p5bm1ybzJIdHdKQUpkd08wT0JjK3ozeTF5aGhZ?=
 =?utf-8?B?YzE2Z2NXc1FWK2V6Y0tYUHJmS29LcFcxcGN6T0lHa1NEeUNCMU5wb2lDRVZK?=
 =?utf-8?B?NjI1bExDK0crdDMxUjAyZmdKYVZJT0RtTnB5Q0dUZWFIWi9LUXpYbXRyTC9U?=
 =?utf-8?B?Y3dNb1NzSHl4SmdLQ1J1NmdQSlRnbFNhUGY0SDNNbDZNWVZDV2xlaUZPWW44?=
 =?utf-8?B?a1lGY3FvOVJyNEtLQVZtc2V3NmFKWTdYRGFiMThxbVhkOVl6NjVMK0lDVEFr?=
 =?utf-8?B?VHYvNVdYOGxkSllxVkIwc2VuQ29PdmxjbWN6V1MyTjVKMkRyYVdlOFdoaUhi?=
 =?utf-8?B?M2NxVnR4L0dla0VIc0VISnRzWmRuU3piOUZpRGFGdkNJVXh2ODFsSmhidXFy?=
 =?utf-8?B?UHo2UHlJb2dQNnA2VnordGdlUGhjZ2FyZ1VnSEN4YVFsT2tuVW16K3NNeEg2?=
 =?utf-8?B?eHUydlR3ZTlrWDlwZFN1M0REWWR1Ynh6b3F2RTNPTTJOODcwTklNbDhoREIw?=
 =?utf-8?B?Q0w0NFgvWE95Vlh3QTg4cFVLcFFwaEtSWFA2bkJVSTl4QUZhZDZGVTd6eXd2?=
 =?utf-8?B?N1Q5UC9zN0Y3UkZ2SkI5V1dReVpZM2UwMG40NzMvRFZaQXRJQVdqZ2doTkhU?=
 =?utf-8?B?cFZ5RHl2VkRDQ2VKYnFMdXdkekxodTl2Q29BbFVzSGN1Umo0UzA2UWtTZktU?=
 =?utf-8?B?TEJaRjhoZHQ2eU9OZ1J0d0dDKzNrd3l2K2JNM0lXbGY0eThFNElmbUc5RTdu?=
 =?utf-8?B?YUlsUnM0dGRVODVGejMyZ1k1Y3U5SkN0RDRVVWJyM2M5WHFQUW1oKzFoWkhk?=
 =?utf-8?B?K20xTlRjQnh2blo0NzB1MjFKamJ6Wkd2dytKZ2JTTDdVZ2JkMzZ6WGxibVNu?=
 =?utf-8?Q?fh05it?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmZadFFEUmFvSTVVTlNiM1R3UGRWN1lnZGNST2Z3Q2JjM05SOTcySWhLd2ZU?=
 =?utf-8?B?YXFtVlhSUVRmakNqZUFaSWJIdGZmeXBHOHU1ZS9aaTNPclQyNWoxc2dDSFR0?=
 =?utf-8?B?VDF2eDdqeEtpMnJZMWhDY3p3OW1adG95M1lQTnIvQVREQ3RwWDI5MWtneWtU?=
 =?utf-8?B?L29ZNkpCS0RteXBEYVlVbVVjOUZ4RFltTit2d2JNamJTcmt5WXVldURYcm9P?=
 =?utf-8?B?MHE1VUowNS83T1AwWk9XZVo4dkNWUDlyYzYwTHdKRU1KcytrVG5rL1B6dktH?=
 =?utf-8?B?aTBQajZJa2R3eTYxcDhDZk15eVhVMEZObEVIeFZManhuNWtVNG53bDZnUDZ2?=
 =?utf-8?B?amJjUlNzT1RxaERqbVAxUDFHOTZmTVJFQUQ4cldBVFRDak80d1VkNUlsMmk3?=
 =?utf-8?B?NnhaWjEwMVFHQzQ3MDNqNnRmK3lEdndYYllYeUtGRzRFUDBGT3MrK0J3Sk1J?=
 =?utf-8?B?TXZLREpSSHdNSGgvYy9hNVhlS3E2K2NlSWx3ZU5ySjFlcE5YK2wza3B4Y1Jm?=
 =?utf-8?B?anc4TE9maFViYTJXZlJ1LytsWG16cHhFRXRaN3NnYWN5R1lCRXA1OU91aFd2?=
 =?utf-8?B?a09iRGM1bjRDa3FqZXBFT05LSCtRSHN2bXV3ZFVBaU03b1I1ZkhJeUtEU1VD?=
 =?utf-8?B?S1g0dGdMZ1J2bEcrQ0kyUFlRNnZwT2ErU0tScVBZd3BvZVUzQVlETzE5cTlO?=
 =?utf-8?B?MHZ1TG5UUTc0QXJNU1czVFlXMGNPZklTdTZEaGxMa29lV01ROGNmcGN1WXF0?=
 =?utf-8?B?V2NlWDJZRlpENFVnTE05eEpVRXFBblhLQkd2cWpqK0dkbFFXeWEwSHlITENy?=
 =?utf-8?B?NFJJdHE1YXRMb1RTbTNkRTVhVUdHT0p3T2lnZExLTklNT05vNGxlZHJlQmVy?=
 =?utf-8?B?NlBVdkpzejZqNWw2TEVtS3JIbHh2bzV2SzNZTUtXNDhkbmpuSnJ1Ymt0TEdJ?=
 =?utf-8?B?dGVxTnlKVDE4TTI4c2RVZmhuL09CUTZKRFlnT0R0dHhEakw2alE2TWR3WURT?=
 =?utf-8?B?KzNlRGVGVk9nMFF2WXV4RkNlbDljQzFkeUNWQ29RNExBVFhvSkVGZEdaei9s?=
 =?utf-8?B?NmkxdTJaUm5YSENiSndvQ0VnWi91SnZUTUx0WTN5VkRjVjR3K25ucEV5V084?=
 =?utf-8?B?MFVlWlZOSDB4VUgyYXJSbjB0cmtoMjhDYnlWcm95ak5Yd01kVnBZNEduSFZy?=
 =?utf-8?B?bjZRcyszTG9wUCtLeW1TZWhXUDNtUGk4WXlsbFRqM01KUXhiVmgrMFB6K2N1?=
 =?utf-8?B?d1JYc3dKZVJTUS9ybndtN1FvdTFCNGhvaE5SMWZPaEJReFJENVMxYXYreHp1?=
 =?utf-8?B?ZkY2RlkxcHlpRS9QQ0U4TGJhL3lrUElaTnpqYzVtVk5qbnh0bmxTSkpYUndj?=
 =?utf-8?B?VlhVWjdScFFhak9DdDQwU3lPbUtNUWwzdW1RcW9sQ2R3Z0FINTZIOWFtYVJF?=
 =?utf-8?B?ak5OZlFhTmZMTnFFcWk0UnAvbmhqVXYrVkd5dEhJVFd5TjJ0SFAwWFdqZVY3?=
 =?utf-8?B?ZHdJOHl4QzRVWXp4U3VKcmFLM0t6RGJVQ0V2SzdWQmVHTE90RUhmM3J4L0NZ?=
 =?utf-8?B?UGhnRUNUdzZIZThla2VtTDlvNlVFUldLRmhPUE5WRjIwQmxYMTA5VDVTNm4v?=
 =?utf-8?B?SE92dERDNkF2MGJJcVkzcldsRlZ0LzJwbFVaYm4rSlRBSFhiWDhWR29PNWx1?=
 =?utf-8?B?T2xyUitlaVNrd2tLRzBQdHFGYklTWFRhZlVVbWpIT1NFMkppWGl3dDZEbzBZ?=
 =?utf-8?B?OUNPZEFQckN6cWZtcEFwQmJsL2pJZ0Y4amQ0L0tvMUJuYjJFMWppYnJ6UTVL?=
 =?utf-8?B?aUFuMXpxK2FuOUYyZ1RrN0ZjNDRTeU45TGNhakg5NCtCR1Jiamd5UlMxUTZn?=
 =?utf-8?B?diszbVZkT09SUkV4NEt6R0NYajJOZXdmZVJNZ3FvWnZ6Y3lJUGtmS1NvWTBu?=
 =?utf-8?B?cWo0OHI5eXNLVjNpREpqNWlOekYzRnA3MW8xbkRJcDk0SFk4akIvK2VUZVFq?=
 =?utf-8?B?NTZ6NVdTWnJrbUdTSEd5YzV1ZzZsSktYRHY5N2NHK24yVkpjUGU2VVhTa1lI?=
 =?utf-8?B?blVNcFBEWUd4TmpEWEZEWmVkbHAxUmxEcnpvZ2x1Yjk2VHNHYVk2RE80ajNM?=
 =?utf-8?Q?1wNEVfgnS1j9uPQXQT3v2sSR3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb36859-bf59-4f0a-abd3-08de2d94942d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 09:08:50.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTMZL+ZTwhTWHf8z+pzHCImw5V40ErJVcxlmjOZOhPbbnlldkiUO30C79VaVXUktQdNRDrPeVIuSaWWfBtCSww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558


On 11/26/25 18:35, PJ Waskiewicz wrote:
> Hi Alejandro,
>
> On Wed, 2025-11-26 at 09:09 +0000, Alejandro Lucero Palau wrote:
>> On 11/26/25 01:27, PJ Waskiewicz wrote:
>>> Hi Alejandro,
>>>
>>> On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
>>> wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Use cxl api for getting DPA (Device Physical Address) to use
>>>> through
>>>> an
>>>> endpoint decoder.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>>>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>>    drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
>>>>    1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
>>>> b/drivers/net/ethernet/sfc/efx_cxl.c
>>>> index d7c34c978434..1a50bb2c0913 100644
>>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>>> @@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data
>>>> *probe_data)
>>>>    		return -ENOSPC;
>>>>    	}
>>>>    
>>>> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd,
>>>> CXL_PARTMODE_RAM,
>>>> +				     EFX_CTPIO_BUFFER_SIZE);
>>> I've been really struggling to get this flow working in my
>>> environment.
>>> The above function call has a call-chain like this:
>>>
>>> - cxl_request_dpa()
>>>     => cxl_dpa_alloc()
>>>        => __cxl_dpa_alloc()
>>>           => __cxl_dpa_reserve()
>>>              => __request_region()
>>>
>>> That last call to __request_region() is not handling a Type2 device
>>> that has its mem region defined as EFI Special Purpose memory.
>>> Basically if the underlying hardware has the memory region marked
>>> that
>>> way, it's still getting mapped into the host's physical address
>>> map,
>>> but it's explicitly telling the OS to bugger off and not try to map
>>> it
>>> as system RAM, which is what we want. Since this is being used as
>>> an
>>> acceleration path, we don't want the OS to muck about with it.
>>>
>>> The issue here is now that I have to build CXL into the kernel
>>> itself
>>> to get around the circular dependency issue with depmod, I see this
>>> when my kernel boots and the device trains, but *before* my driver
>>> loads:
>>>
>>> # cat /proc/iomem
>>> [...snip...]
>>> c050000000-c08fffffff : CXL Window 0
>>>     c050000000-c08fffffff : Soft Reserved
>>>
>>> That right there is my device.  And it's being presented correctly
>>> that
>>> it's reserved so the OS doesn't mess with it.  However, that call
>>> to
>>> __request_region() fails with -EBUSY since it can't take ownership
>>> of
>>> that region since it's already owned by the core.
>>>
>>> I can't just skip over this flow for DPA init, so I'm at a bit of a
>>> loss how to proceed.  How is your device presenting the .mem region
>>> to
>>> the host?
>>
>> Hi PJ,
>>
>>
>> My work is based on the device not using EFI_CONVENTIONAL_MEMORY +
>> EFI_MEMORY_SP but EFI_RESERVED_TYPE. In the first case the kernel can
>> try to use that memory and the BIOS goes through default
>> initialization,
> I'm not sure I follow.  Your device is based on using
> EFI_RESERVED_TYPE?  Or is it based on the former?  My device is based
> on EFI_RESERVED_TYPE, which translates into the Soft Reserved status as
> a result of BIOS enumeration and the CXL core enumerating that memory
> resource.


My device will be based on EFI_RESERVED_TYPE but it has no that special 
flag with the devices I got for testing, so the BIOS passes it to the 
kernel in the HMAT as EFI_CONVENTIONAL_MEMORY + EFI_MEMORY_SP.


Not sure what you mean with that CXL core enumeration. With a type2, 
supposedly not a PCI MEMORY CLASS, the CXL PCI driver can not attach to 
it. AFAIK, that memory region can only be used, or what I think is 
problem you have, reserved/allocated in terms of resources, by DAX/HMEM. 
However, I thought with EFI_RESERVED_TYPE that could not happen at all. 
If so, I would say it is fully wrong. If not, what is the meaning of 
this EFI memory type from the kernel point of view?

>> the latter will avoid BIOS or kernel to mess with such a memory.
>> Because
>> there is no BIOS yet supporting this I had to remove DAX support from
>> the kernel and deal (for testing) with some BIOS initialization we
>> will
>> not have in production.
> Can you elaborate what you mean here?  Do you mean the proposed patches
> here are trying to work around this BIOS limitation?


Apologies for not being clearer here. The  proposed patches discussed 
here are the right ones for our device ... once we got all the pieces 
together, chiefly our UEFI driver advertising that special flag and the 
(AMD) BIOS supporting it. If you got such a BIOS from AMD, lucky you!


>
> I'm not sure I understand what BIOS limitations you mean though.  I see
> on both an AMD and Intel host (CXL 2.0-capable) the same behavior that
> I'd expect of EFI_RESERVED_TYPE getting set aside so the OS doesn't
> mess with it.  This is on CRB-level stuff plus production-level
> platforms.


 From your previous emails, the systems seems to detect the memory as 
Soft Reserved ... which implies DAX can use it.

Not sure if you confirmed the flag being used by the kernel from the 
HMAT table, but worth to double check if not.



>>
>> For your case I thought this work
>> https://lore.kernel.org/linux-cxl/20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com/T/#me2bc0d25a2129993e68df444aae073addf886751
>>   
>> was solving your problem but after looking at it now, I think that
>> will
>> only be useful for Type3 and the hotplug case. Maybe it is time to
>> add
>> Type2 handling there. I'll study that patchset with more detail and
>> comment for solving your case.
> I just looked through that, and I might be able to cherry-pick some
> stuff.  I'll do the same offline and see if I can come up with a
> workable solution to get past this wall for now.
>
> That said though, I don't really want or care about DAX.  I can already
> find and map the underlying CXL.mem accelerated region through other
> means (RCRB, DVSEC, etc.).
>
> What I'm trying to do is get the regionX object to instantiate on my
> CXL.mem memory block, so that I can remove the region, ultimately
> tearing down the decoders, and allowing me to hotplug the device.  The
> patches here seem to still assume a Type3-ish device where there's DPA
> needing to get mapped into HPA, which our devices are already allocated
> in the decoders due to the EFI_RESERVED_TYPE enumeration.  But the
> patches aren't seeing that firmware already set them up, since the
> decoders haven't been committed yet.


If you mean the HDM decoders are configured by the BIOS and the CXL Host 
Bridge is also with also the right configuration for redirecting to the 
CXL Root Port your device is attached to, the (AMD) BIOS is doing so 
without the EFI_RESERVED_TYPE as well. So apart from that potential 
conflict with DAX/HMEM, which I'm not sure it is happening, you could be 
facing here the problem of the current patches not supporting a Type2 
device with already committed HDM, but you are saying yours not having 
it ... Annyways, Benjamin Cheatham pointed out this other problem which 
I was also aware of due to my testing, but as I said when he brought it, 
I would prefer to support that as a follow-up work as the client behind 
this initial (and basic) Type2 support, the sfc driver, not requiring it.


>
> My root decoder has 1GB of space, which is the size of my endpoint
> device's memory size (1GB).  There is no DPA to map, and the HPA
> already appears "full" since the device is already configured in the
> decoder.


This makes me to think it is weird your device HDM not committed. BTW, 
is the Root decoder CFMWS size the same in Intel and AMD systems? I bet 
it is not from discussing this with Dan and cia, but curious to know in 
your case.


>
> TL;DR: if your device you're testing with presents the CXL.mem region
> as EFI_RESERVED_TYPE, I don't see how these patches are working.
> Unless you're doing something extra outside of the patches, which isn't
> obvious to me.


Yes, sorry, that is the case. I'm applying some dirty changes to these 
patches for testing with my current testing devices, including the BIOS 
and the Host.


>>
>> FWIW, last year in Vienna I raised the concern of the kernel doing
>> exactly what you are witnessing, and I proposed having a way for
>> taking
>> the device/memory from DAX but I was told unanimously that was not
>> necessary and if the BIOS did the wrong thing, not fixing that in the
>> kernel. In hindsight I would say this conflict was not well
>> understood
>> then (me included) with all the details, so maybe it is time to have
>> this capacity, maybe from user space or maybe specific kernel param
>> triggering the device passing from DAX.
> I do recall this.  Unfortunately I brought up similar concerns way back
> in Dublin in 2021 regarding all of this flow well before 2.0-capable
> hosts arrived.  I think I started asking the questions way too early,
> since this was of little to no concern at the time (nor was Type2
> device support).


Maybe we can make the case now. I'll seize LPC to discuss this further. 
Will you be there?


Thank you


>
> Cheers,
> -PJ

