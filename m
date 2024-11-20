Return-Path: <netdev+bounces-146535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8239D4087
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 17:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC631F225D6
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BD914037F;
	Wed, 20 Nov 2024 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TufKm4V4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E524B28;
	Wed, 20 Nov 2024 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121442; cv=fail; b=fUvAOsTY3L0Ztkuw3leGHpe8BUsBHi8F59FQ9pE3Cf1rwYcFuB7V1YoB384jXsTmRPIQFSjUKYQEA8bEBkfuscZwf5YSvNbmXZ2uMHiAiielC2hA/2BHFwCoSG7C420JgwRNJNpiuOYWraKqM+Tjp1YO6VLywFAXsSoJedxYzPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121442; c=relaxed/simple;
	bh=Nj1UhHEUgYZvxC9cy+G6QLTlS/LDRczhWZmqIfVAQ64=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SgeCK+3Lb9NyN3C0396ZskoytAksgv2RuBw4KTmoBKtviTQgH7YoyfDN7vx4AQCKuftdV4iDccCwBDceIbJCvx6Gjag4ErZZPjRthsTBEJi/WynZqTHwuvyZuIcSWN7ztJFk/WQjhvDrtDaylIqOjbJ0Jd0N7cIc5MesrdYLz28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TufKm4V4; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljvmKIznEzd+cqJsE79nc9kih9Frosqv/12KO5d1J1v9LGOjN4ColXmRY/HYk+Jr9z06NxmOV/ZnMa5kEqvFnrLrMIzTR+zklNoXKHMD8FsKao8lOzPmp1OelltrCG5DI7IHCJ3hrWu08ZsLUaKY4JWHSywVtvfTLouCQ+Qc1IQSC94zUTmVsrOI1OoGxg5qSv25gQfN+MKkJJBPKSO4q2O8Eg4reIPpfl/YgDDOixrnLrC8NeahQ3T0KtuFwJUBeg6Kzd0fPKAHSvBuBFMxWmpHSOnPHLpj0mLfa7Ok7ZzFKYRPc4hqxTbWIg1m+pm2H2kccJUmUAl8NPmyfPTg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjei/Y9K9VaAkjbYdFlAobkxphVGYvew00wOlm0r/5w=;
 b=iiJXALYJWSo1zhzzRlhPQCs2/cNcYdhznD/kXLCIAu5ZvnQAwa9KwaMjMT821ZZ7jemPBosz6wmgP3iFKOfcxbA2dMexSGnR5vsNV1gtqr1bFHNM+vVMbW2r/ZG86WFOxJiJu4OmD4c8+vqxd/kw6A6vdWgZ/qkWNagznpEwNp1u3U9f4hpp14JPdX+LUSbzpnFyjoas9M6gb+xvVA4/pvEd7KyXCW/eCzgkLkxcYJ0E+p4fRTQGoJsBLTVFbSHk1JmgV7Xo2hATu74nfEY2V70LUpxs/WY0gXNfYHrxe+E5z4+h3K6fXA/zPE2yWYDMsY+fCm6NxpwuF3JMoFefCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjei/Y9K9VaAkjbYdFlAobkxphVGYvew00wOlm0r/5w=;
 b=TufKm4V4w++MFTRFf/NToN6m3mLz4cTtcVNXDtlCsjt8Vf03dAqKoO7xSTT6Zg8gwd6T8ckuE17XjRhEbzIO01sLDcG2zxcgsAQg0cqNZ7XLHCEZ315T1PIy7CadiPWECo533V8A/bbfC6imapV+BWmcium3MGow2x1gYukPufg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Wed, 20 Nov 2024 16:50:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 16:50:37 +0000
Message-ID: <f14777c1-9a38-86e5-df39-c52b7df2f300@amd.com>
Date: Wed, 20 Nov 2024 16:50:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Should the CXL Type2 support patchset be split up?
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Paolo Abeni <pabeni@redhat.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Dave Jiang <dave.jiang@intel.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <fb2d7565-b895-4109-b027-92275e086268@redhat.com>
 <86522c97-350c-9319-6930-01f97a490578@amd.com>
In-Reply-To: <86522c97-350c-9319-6930-01f97a490578@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0016.eurprd06.prod.outlook.com (2603:10a6:8:1::29)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 96930b6c-5789-4f30-4489-08dd09837524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2dsdm05Z2JXQ0VrSFUwa09aamc5Wlp5K0tid1JIMjQzSUw5a2syODZaU0Vh?=
 =?utf-8?B?czVub256YmRjQ2JhMko1YjJKYXhNTXBvOVhUSHpTSVNtOFBYMmlqcUF0MU5H?=
 =?utf-8?B?RkJnQWhJSmZqTzFheVJGbTF0Z0NMWVYxTitQOUZJQWJqNkN1emU1c1p5SFkv?=
 =?utf-8?B?dmNoNS9DRk00YUN6SmxkMVJkL0VZQUE5OWpweVZ1MUw3ekl6WHlTd3hzZHdV?=
 =?utf-8?B?Zi9mSWF1eTJDbzRmU2RBaEdtK2w0WlJzSTZydHJjdE1lQ0dSRThTZ1dqSHhE?=
 =?utf-8?B?S2dDejAvMVI1R1RYTzZYMmZnZmorZStwMWhHZi9PQ1A4TGtlam9LS2ZSS2FX?=
 =?utf-8?B?eDg0WDNrVDFpK2tXQk5mTm53QkN2NzRuUXVXZnBob2FseGFDZDJGYk1vUDE3?=
 =?utf-8?B?S0JxdW8zOXFqa1gyNENGdUhnWFk1S3F5b0V0S3cyNmZlRVVWcjVvWUlxUzZz?=
 =?utf-8?B?T3Y3L21aeW9ZZU9JWHNaODgvVlZmbXVWUjQvUnpQc1JlTWh3TllZdkI2alM0?=
 =?utf-8?B?Zm93alFvTTFDY203aDF1VGRRU09odENxdDA1TGpHdGJkNHY0NWRuRnMwbmRz?=
 =?utf-8?B?c2ZDM1BnRmNUMElsNTVBaXg5ZXcwWHVFb3hXSWUvbHhBOU1iSldJdGl3Q09N?=
 =?utf-8?B?SVBudmxsMzIxVndjNklpaTUwc2N6Yy8zbDdwbWZUQWdpYVI2a1VWUlY2QjBF?=
 =?utf-8?B?SjVWdFR3M1lCbzRUNGFHZjhWZ1RLL25hczU5T2t4RU1vbUppcnhuM1M2OUVL?=
 =?utf-8?B?NldjeWhXNjBlNTB2V095QXFqUUpmb1lJWGJIS0hMc2NaYnEzSmZvKzZBQ2ty?=
 =?utf-8?B?ajlNb1ovbHZuMlR3ckdwWmxuUkVaUVZSUVB4U2hWR0dxbnFWTUFzSDlGaUQr?=
 =?utf-8?B?WnVRUU00Nm9VTGozajBUN0VlVDhlODZ0QXZOWFpySHFFaElITFRBOWptSGpz?=
 =?utf-8?B?Z3hHeXJJYkd1U3VtUWpXa0xoS0F5cEY1TGlITDRveFB5VzdNNzlnNnVJSXEv?=
 =?utf-8?B?S0pER2NzRVVCQ0paanBwYmlmMWV5d3NpQ0xPcEhIUmxvRnRmRmt1STJHc0Qr?=
 =?utf-8?B?OUMybU4xcGtwYjJHVkozMWw4MUR5WVNVQ1BUYmtNMkhSWm96c2UxeFpyeUxU?=
 =?utf-8?B?QjNLa1BzM1VIMlVnTlBBaGlMYTZwOE00MXZRc0p3QXplVnRFMkZqcERzVzc2?=
 =?utf-8?B?TWUraGFDZjk5cytoYmY0VFhsT3FRZEYrOTVEcjJyRHMvM3Rzb0diZUlta0Q3?=
 =?utf-8?B?WDVkb0owM2cvM2Y2UzRXWDlQTEI2bFNaeGtPVk9Qcm5MalVkOSs0N1poS1g0?=
 =?utf-8?B?R0RHZjdEWk9hOUNoUWdCNTRFdW5STWh1MXphS3MzZ3VaVjAvVWdnWDFXWmVs?=
 =?utf-8?B?YVp5RmIzNHN4bkZQTnoycW8xZjRKVU00WkxnS0hQU1AzaFRzK3BqdURIanZU?=
 =?utf-8?B?RWNoeGlNM2F5TThLamdjdXJIa2ZCNXc2dEg5TFlEUUtPVzhWbXBSS0tONlBP?=
 =?utf-8?B?STQ1QmwvSmxBNnJDcHhzYmlZbWQ0MERpL3ZsYnVLZVducEx6dDRnUnViV0ty?=
 =?utf-8?B?NmE4aTNGYWYrUys0Qy9vNVFPc2ZaT3Z6UFMrZUpIeTVoa3lQWkNtZ2gxV3M1?=
 =?utf-8?B?WE1oOFR1SVgvY1o2ZlhLb0I2aFRqbTduRVJjaEJid1Nla05HUGpnU284ZXI1?=
 =?utf-8?B?TFQxSjhPM04veUtHTlA0VG9uOEdTWVlsOWxST2VwOWdZZG9SWkZuaHVrOXow?=
 =?utf-8?B?NzdFUjk0V1E4SVR1TTErV0hBZHlhNVpvZWY4NDV6c1VxR292S1duRzhKSXk0?=
 =?utf-8?Q?QQxvDxD5Fm6wYa4fkigik8oJi7L4EJMSAxEqI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cndLa21hQmdjM0ppZGYraTJkb3gwZ0VhSzR5cUJNMkdWaWdRczVWV1daL3hT?=
 =?utf-8?B?aEZjSjM2VTJLaDdhUUswcWR3OVhveXJuY2d1UDlXcjdIS2V5M1BkOVdEdzVR?=
 =?utf-8?B?cEVIaWUrL2dadXJ6UXRBb3F3QTc5aEtDUW5MMWhrOVdPamJWT1V2T1RNSnpR?=
 =?utf-8?B?SmZaRDJkY0ZudnhVN0pVcmwvQVRFTWoxeTNkNWgzYmgxeGphb1puYjUrdkdq?=
 =?utf-8?B?dXhuYmJyT3E4Y1dhTU92bU1CVDVxb1JzTHZmNUNQV25OOEI4cy9aYyt4TXBQ?=
 =?utf-8?B?RElTWW5rR0grVHUzK25YRTdDSTdWL3JicUUrMENvMjhvc3pQcEY2Wm9hQXdP?=
 =?utf-8?B?cnl5ZHJPZUs1eEloeUhsZmp1U3VuSVc2NGRKTmU0bzZ5ZlVweDdiNEJid2VX?=
 =?utf-8?B?SlZWR3dHekVXQW5CTm1mSk1TN0w3a2lOWk54SVFSdWM5QjhnbTl4a1FIM2l1?=
 =?utf-8?B?ZVltb0RjMEFQTURWY2RnOExhVCtFNFRYSG5qQ1Y3VHJvK2NGaXBsUlBKL2Uv?=
 =?utf-8?B?TmdnQis0Rk5KZnhhZzNUNXZUNUdRMzlUSW5rRG91eG9jNi9UaHlmOGtUdzZ6?=
 =?utf-8?B?UTlORnZ5M2w1dnhUK0ZNNVdhOEl1UWhPdC85ZFRqd2dkMVZIb0hjOUpuUDFV?=
 =?utf-8?B?NHdXT2JNaVlDTlNYTTNUd1dpSGt2eUp2OHM0elEzeHpyVStBbGlQQm9Sb1Uz?=
 =?utf-8?B?TndMdTJjSktVMGhzT1JNQlVXdllSYXgwTklqcGtFU0ZOS0QyWEY1Wm9lMk1U?=
 =?utf-8?B?YVNGekNuSnNrM25Ndndabm13OTZVdDloWDJRcmV0T3JzWWt3ZWFkR3JRemJY?=
 =?utf-8?B?Q2lxK3J0UUduZGxYeURCYWJvU2JnS28yL1ZjU0tJMjl1dzdua0l4cVE0VktZ?=
 =?utf-8?B?aVJ4ZnBLNDJlRFBOZkhXNmpQS1ZWL0E1RlgxQ0F4YVJ4NVo0WEpnbVpncGN5?=
 =?utf-8?B?QmI3NXgvRlBiSG1FcnppY0VPVFduODUwc29Bd1FhSitRYkFkd1g1dURaL25C?=
 =?utf-8?B?ajYrSHM5M2wzUnh6VG9UNVhobXRTdnBmR2NEUUFMMVdHWFFkT2xrbkkyYnla?=
 =?utf-8?B?WU9jdCtja01zTmx4MHpTNWdhWFpGa0ZyS1BwMncxSlZlSVVpSy9QeHdxUmxY?=
 =?utf-8?B?Y243Tm5xVVhRWm1QTmY3ZU9HMkR1SHNwdkVpRHBPMW9JYUZEUStZUjl3TGdk?=
 =?utf-8?B?dWFsaHdBUHlSamtyZFpialRUZnVvOVk3SEZUcHFpNEx4clZ2elNkMzdZMnBx?=
 =?utf-8?B?RHFhVHc5UXNUV2RIQXdxajdGSEJqUE1sRXp4bEk2QitMWTNZOXFTV3VqVWFj?=
 =?utf-8?B?OGQ5bStNM1BSUUFJbnZ0T2NXdGdPemsyeWYvNEpQeUZtOC9CNXV1aUNaM3hs?=
 =?utf-8?B?MG4xSmxsL0ZCaE84R2NRazBjNlhOOUVXUjd3RUtSZFZ5dUIyTjNMYTd3L1hw?=
 =?utf-8?B?UFZJTXNFMThPZFJXenFKY2JaN01Wblg5UFo4OFZxK3crbURzWW1UdHVQd2xi?=
 =?utf-8?B?cjc1amY5cGFzZUhWWXVNZmJabjcyaHQ2SXdzTGZEbThjMElaME5GNHVjN3ZM?=
 =?utf-8?B?YmdwQ0lhbEtnRHk2amt0dEFqYzZGM1NqNjkraEM5ZTNJS1F2dXhxL1c5cDEz?=
 =?utf-8?B?TUVSSjIxeE4vVHNUR1Uzbll6RWEvRXdkak9Sa0p5V1JLZDVORFJieHF4dVFn?=
 =?utf-8?B?VnZ6cHZMbi9Sb1JRZkJSRGlJREJ5VHpiSWtqWUlKQ0IwNUNtVmNwZkhXSGI3?=
 =?utf-8?B?R2hNK05NNVhkOXZZWkk4NlFXNFNMSHVlTlFmNHR1TDY1UTJBdkk0UDNGbWFT?=
 =?utf-8?B?ZVpESEk1WGo3U0kyQWRGRVcwUHJZUmFLbVBXcWp3QlI0WklsazZGbUpxb0VM?=
 =?utf-8?B?RDhXV2sveUFRRHhYYUFvb2NkVTE2cEwwcWdKbGdkb2VhSlFlWGpJMHJkY3k5?=
 =?utf-8?B?MXArQXA4WFhSOGx1OEZJREJTTy9Jc1RLMWxxU2NjandHeEE1SFBnRHVrejIy?=
 =?utf-8?B?ZDh3VVVXd3MxdUVrSE1oQ2ViMTd6U3JuRlFLbjEwcCtIYjVHNUdPL0IrR0kv?=
 =?utf-8?B?WmZVdGpEYTFCSmVJb1lQMWsrN1Vpd0ozMmN1cWhvdjRPVHF1QU1MaTduWnkr?=
 =?utf-8?Q?onrxbbjM0MBTBxcHTRUYOxusb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96930b6c-5789-4f30-4489-08dd09837524
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 16:50:37.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //YOxXywJdSsSDUPonybH/fV64Gs+hYY6uHcNH4De/cPue/XFl8TEbYUtlcEeq9jl7MeQteydW0oo8OpKkF3hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

Hi all,


Facing Paolo's question again trying to involve CXL and (more) netdev 
maintainers.


Next v6 could have two different patchsets, one for cxl, one for netdev. 
The current patchset has already cleanly isolated sfc netdev patches, so 
it is trivial.

The main question is if CXL maintainers will be happy with this change 
as the sfc is the client justifying the CXL core changes. Also, the 
split could be delayed until all the patches get the Reviewed-by tag 
what is now only ~75% of them (sfc related patches without the public 
approval yet but internally obtained).

Thanks,

Alejandro


On 10/23/24 10:38, Alejandro Lucero Palau wrote:
>
> On 10/23/24 09:46, Paolo Abeni wrote:
>> I'm sorry for the late feedback, but which is the merge plan here?
>>
>> The series spawns across 2 different subsystems and could cause 
>> conflicts.
>>
>> Could the network device change be separated and send (to netdev) after
>> the clx ones land into Linus' tree?
>
>
> Hi Paolo,
>
>
> With v4 all sfc changes are different patches than those modifying CXL 
> core, so I guess this is good for what you suggest.
>
>
> Not sure the implications for merging only some patches into the CXL 
> tree.
>
>
> Thanks,
>
> Alejandro
>
>
>> Thanks,
>>
>> Paolo
>>

