Return-Path: <netdev+bounces-227612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1AEBB377C
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 11:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B0719C2585
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857F72DC771;
	Thu,  2 Oct 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X9d+eMNj"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3061A4F3C;
	Thu,  2 Oct 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397781; cv=fail; b=LmjTG0DSxzH2vRKfv5SIgbE7q83yITTlIZCIwefy4qAyJ6qMuM1252IbjGkopPnb3iTriCZxVZpCvnQg9ThdUy6iQpmQ1BPszR1dnNoJXiBp3rMnaT1CRqbpHHAQ1o/Y50AUrRo+nFNhwPGG84uBq2yawid41/9e3MLS+pG4IZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397781; c=relaxed/simple;
	bh=MZORqkau9WSvp9MVnIGYMvXuC0UzHDv4fN1LrOA/198=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e3I/PKN+0fm+IF+sUKY9hPCuJZlERAyIKA5JW2BD99IVw6lGlJkk9VB5mTrlh57iLXKhd65uuYYspHAEYkQB7Aj8T5CUj7lvTQbkgrWRLrxUeB8XxoX56wiKZs2Lnz5XNY9jBm/F5q9xoAaY5p5B5+21V3lJsf6M2ysduwNQqQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X9d+eMNj; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y90md/1ql8Mhxj09XTDQvt1/kJyHA9W69xVQC8QyfwXxKN1W87bMhNY5KtZCHnD/3F5hlXs9iW3hthhvHztb2iA3XrEpKJdISOgYGhCAU0xQ1WBSzVGuFX1I8YtQhqLLfU5L0rcsf6O1/WMvpEXaupEly2l12b7l/cB4JP179nVliVmvEjyYByUTy5zLoJSUAh/sczBvmksJteQwr86RBfoeZDy+MFRB3HyJPk5FSJ0S76GzbNp0zjLH4W2g/JgRxYIUtArkJdhh55a8l/dxnco6b1GXDL/KA5915P+E6Spu4AlBw3yAPEAH8e8V2QCLdWQTu3pCbPLbR3JM4hp2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym5F59jlNK42p83jhdl7vqxyQ/0AWcY0YRy/24XcnQk=;
 b=C1r7/slHUG/8WQ+2GwxQbeTImEY8Dcatx644GcNyrCfIG1rt5OJvpfomMB9Q5fTi4W4zF0aZI+GW+MR2GgElY7i66PteOgeBBquHaeCYLNgpbCneQANFk/ltVhTw+AALG638seg9l11hWyeE9as5vL6AEPDji05IYvXjEjzDb9HC3iH58t+scX1BsLtm2bKH1TkbapBMEpTTgx2933GU0Uj6jsRDOHVFlvh4HKqq1p7cjwsMRuFzYeQlOghx/WkDHLYecw1N5KYC4dY3e7yFNyG8He5Hvy6n2QUDNBRkPILwB9GqmwNke7EIbC/vDZSmsq/VmoqJhgNHYPQsiKlW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym5F59jlNK42p83jhdl7vqxyQ/0AWcY0YRy/24XcnQk=;
 b=X9d+eMNjO321RJ3cTm8GihJiHwRkpC9oGcHclkY7YNXWLxh5BsrfZFEge8Hvl2X/tfAjxgbkf710t+ePrH+IjolANk+nTCJYoQ2v/eAmTNOG+9b+8AZNxOYUkwZxZpv4DhmT3/Wp2C5ZCH29NzeNgXsN5pb0IcD/LpdHfmZw/A4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 09:36:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Thu, 2 Oct 2025
 09:36:12 +0000
Message-ID: <36fdebc2-b987-40ee-abf0-624b55768e3c@amd.com>
Date: Thu, 2 Oct 2025 10:36:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 04/20] cxl: allow Type2 drivers to map cxl component
 regs
Content-Language: en-US
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
 <8b6d2a9dfafe1cbf4311efe157f50e8f21702d04.camel@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <8b6d2a9dfafe1cbf4311efe157f50e8f21702d04.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0490.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 61276d08-bdaf-40d3-1e05-08de01972017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MldiVi9IbTdHbit2WCtDSnErVWdldFJtZ2E4dUpoYkhrbS9GbHA5QXJ5VDZQ?=
 =?utf-8?B?RDV2S2E2ZHNjS3c4VjRJNnR1VENLM3MxRDNkSzIyODNlWUhud3FCZURka2w2?=
 =?utf-8?B?ODRSeHEwT1hxTHBxQzMxc1RHWHRuZUVCTVNhVmdxQ1NnQlFDWlcxM2tGL0Vi?=
 =?utf-8?B?bCszOU1yMEhhMHlPNHdRUEdzeWl6WWFXT29GQlgzOWE1REVUcFB2dEJJNnRE?=
 =?utf-8?B?NHloQjVvZ2JHUWdFa1d4TFUxbzkwZzNvM0lnaE9WbUZGSG8vK2paajArSjZl?=
 =?utf-8?B?c3dmRk1SVitQTGFjV1BsdXRGSnlvN3RGbEV4QTB5TWhxSXFIVG00am1mVzhX?=
 =?utf-8?B?T1RqL3VqYXN6NnR5R3R5YmlLdjVIYlgzaGxmaGlDdnFLQ3hNSTBiZ2tBYkNL?=
 =?utf-8?B?THA2anVpbFU1cllRbmduMThwZCsxMUJiSnVOVWlCNWxTWm40ZU51eVdISGVr?=
 =?utf-8?B?aEVCaFgvQmlEK2N5MFM3SGVodnlhRVRpMU4xdC9pWDV2N1N3aHUxVzY1MkJH?=
 =?utf-8?B?VllmamY5RGxvNTZQM0pNT00yTFM1dGJRT0ZBeXoxMHNqRHZibGJNNjVuSkpM?=
 =?utf-8?B?OWN1dGtaalNUS1ZldTJubUN1TmJRRjExN1d5akcvcDFLMG1VRTNkU2ZybWhZ?=
 =?utf-8?B?N2ZmOEJ5bDljWHJSemdEdGJSYndUSzFTdzBJdWkyaU5UWHlXQUpRMm1HdzNT?=
 =?utf-8?B?R2tqbGJUNmxrbUlYbStkQjNlZjMzYlgweDZ4Yjk5Um1MTTNHbWkrMDhNYTVG?=
 =?utf-8?B?aWx5ZEc2V3RaQkVsaGFtc0w2QTd3V2RCWUExbDVveU8rVGlDZ2lzcWp3UGlF?=
 =?utf-8?B?ZjVXNzZVK3lIWWZYNDFGUzBuM2JvME1sUEd2QStacE5JVnpqdUdjVG9lL25D?=
 =?utf-8?B?czR3Tk5GalB0MFdKVEVSY0c0QjJnZjdpelRLcDBrWis0U3E3aDhIKy9jWnhX?=
 =?utf-8?B?YzQrdGV1Ym5wcUJIZTN5ODZxVVVSMU9wM1lVajZ0VERGVnRBQWpIalIwQ2dV?=
 =?utf-8?B?d0NJQzBTYjRSa1RhMEN4aWI2RUgwTUxQOUlSOEFBUUx5blJxTWtOd2t3RERK?=
 =?utf-8?B?OENIYzNlVkFMenl5WTFERzAxdjRrQUZ0SUJaeU5KTVpYcWtXSWV6TmUyU3pp?=
 =?utf-8?B?eC9UeWxVc3V3Y1gzSUVIcXZ4Rnlya0JRZlMzbFpySkFndW02WGR1aG9zcFVQ?=
 =?utf-8?B?TnEwRnVZSWh6Umc0eXJIVHhFZUdiQkM0Q0I3ZW1VQWZuYW1LMytSQmdySytm?=
 =?utf-8?B?RlAySTlvanpyUlNrcHVnb3JDaS9ZZ0VaUnprNnE3TE51VkFOWGVHa21mTzVI?=
 =?utf-8?B?VFdVbGxhaVFkc0dmVnZYZEdGUFlWbm5peXQzSlBoME5SSG9ia2RqcHcrYlFy?=
 =?utf-8?B?dUNVRWlTMlN3QTEraW9sZTNtKy9xZ1FKUkRRNUdxeFQ2R2FVYUVMVlVieEty?=
 =?utf-8?B?Wmg4RGJBbzN3enBHNElDeDdMV3VyUGQycEhJQjVSN1NBdUFFeWZDWnRvRk81?=
 =?utf-8?B?MVFFb251ckREdXBKdWQwRllVUElMT3QxK2tLVWltcHBVZTN5SXZ2TzhGMlhU?=
 =?utf-8?B?U3Q5RldZbi9SOHIzRGU4d0NtbzNsTjI1OE5wb3B5ZXVDaU9zd2pRc3V0elVt?=
 =?utf-8?B?bmJFTnNySG9QU3d4Yjc2ODVpMll1Y1BTVnhiZHNZQUltMDQrY2VwMHpyZkdT?=
 =?utf-8?B?RysxMjdOU3c3by8vckJTR0RkcmhwR2ZsYjBmMzVrVFB0azVzVmhUcTFDaTN5?=
 =?utf-8?B?RkFGcis1K21la2pRSTBmMC9qa0FaK1VDZW0vaHFlcmljb2ovRGNQYWlESXhV?=
 =?utf-8?B?MlpCeW01SG5ZN0F0S1RjWjB4Tk4xMlpzNGR5ZHpmTUorWk91RnpMdHh0ZXNh?=
 =?utf-8?B?SVFkSzRZMWpoZEtLaUphNEJtQXpqdnJZd2dXNFZycGh6Tmwwc01IUU5RY3Mx?=
 =?utf-8?B?UmRwM3FnVlBkM0RsWXdvaldDa0Z5T3lJWm1Wcmc3NTVlLytpc084bGxwYmRU?=
 =?utf-8?Q?y6gIIxMe2IDp/SsxV5CY0is5//UU2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWQvTTRuTnE4Q24xMUtJTUZ3bm5MVWgxTWxkQUlSOGgybVYrcVBzc25wUmFk?=
 =?utf-8?B?RldKWGMvZXdCNytpckJnMGdPQWJuVUhSeVQwK2s4VGxscFFnNm11SmV2OUkw?=
 =?utf-8?B?aVF4a203KzRjRGs5RWhqOExEUFR4Y1o4ZjcxS01iMjM2THVWbTBSK2J1Vi9E?=
 =?utf-8?B?YTdUMGlPd1M5M2tSNmltQ3d4TXpZU3RSYWh0S0ZsSENGMUZhRFluZWlxTnFH?=
 =?utf-8?B?a2RUaExjdTIySGpuU25BM1lSN09ad3dYVjVOb0EyWnJ2dkduOUlwTzkxV1NS?=
 =?utf-8?B?SUpyWktwV3dhMnlIcldja044ZXdGaGtZc0d4YVFQZm5RSk1FVlNZNkE0MFNR?=
 =?utf-8?B?WVltYllFUWMrOCt5NUd3WVFvSWYwOEc5VmpmUUtOaGoyUmY2emJQb29rUGZv?=
 =?utf-8?B?eTFOVDNpZnM2cWEwRFFyTlAwZ2FJamNjMnUwbFJiNy82NjNPQVRERHlYUEww?=
 =?utf-8?B?eWo4K09Ia3hlWWNOMWlGVlNGTHozRktERzNxY0pROEYvYWZjbHkrakI2UjZa?=
 =?utf-8?B?aTU1QU92YnhNajkyV1lJYWJ1VFRVaEMvZlhhc1BqbkN5YzhzSFpJcEk1bVUr?=
 =?utf-8?B?aStPMmVQdThQZklVRmswNHpjbVU2aHBlQW8xd1JGY3lNUTdYd3d5MlNDQjF5?=
 =?utf-8?B?bDhwcXg5aDQ4ajZwRW00NkhyQmM3L094dFB3dW1nZDJCbnl6R1dWd011Zjcr?=
 =?utf-8?B?WGtKMFdnS1pOWmZpZWdhczFNUFN2M0VoYWdrd3Z1aFk2WDJEUHVoLzR5cFA3?=
 =?utf-8?B?a2F0U1ZJQ1NxTDB6cXJVL1VncW9JTlZKc0lONlNYRkxweTB3clR1SVl1UEtC?=
 =?utf-8?B?MGorK3VBS0JaQlBFSXE4MWhZR3puQVphYWJhRjBuaEN2SnEzVWpNTGszRy9p?=
 =?utf-8?B?N2hlVUNhTVVFUXo4Rk5sVERlREo2Y3M0QU1iL1hXTUdVOGFVeVI2RUprc0t6?=
 =?utf-8?B?akl6TTNvNEZnSy9CV0lXMXNtOGh5L0p0SVRKazF5cEhVemt5T0gyQ2RMa3hk?=
 =?utf-8?B?V2I1ZWtnaWRpaFpNQXZFOEt1YWdNb0t0VEFDa29jbldnWGlRQm92SktOYkt2?=
 =?utf-8?B?N01TV29hRVJ5N0xSSHFrRElRSE5mckdSV1JhMXllYjRtYndVMS9aejAzb2lM?=
 =?utf-8?B?VDllQXR6azQ3U3VnUWUxYmlZakdQeGlORWt4VlZNTzM3Z20wcTZjQUNxR0li?=
 =?utf-8?B?NGpPWEYxYVRvaWNhNWloSXg0dnNkZVcvZjR1V1ZrWmJ3a2RxR290TWVDSmtK?=
 =?utf-8?B?ZU8rVUFXSmVMV2lsUnBQOW1WU0ZZK3pNeldGZW9qd0tVSHVJcDVkb1NTRGhy?=
 =?utf-8?B?SnJqaEJFMmR0RjRFbjdMVDJxQzFTOUhsOHVuMG8xVlJDVHlxZEFlYnQ0T1Bh?=
 =?utf-8?B?UVE5MEpHQzMrM09NNE1tdjc3RmVHUTR4NWZmRUpDdDdaVWtOZFBrUGN0NVFQ?=
 =?utf-8?B?UjhQN0V5OE00OWhjNVRPeTZzNHBHWnk2cU1uWG1oS0tKUlJIU2R4ZXJHbUdK?=
 =?utf-8?B?bTVNZEtqUHU3TEVRbGpRbjBqdXpXOXYwUlZmZG9ibGhML1FRWS8rcXk3Q1Bn?=
 =?utf-8?B?czBrbkZSbHRDbnFsNzI5eFlnWm0zYXFBVWlBWnZLZXY2cWhoWTZZL01FVEth?=
 =?utf-8?B?TUR6dUcybGc2cmlwTjdBK1FlVDd0SFFnWm15QTRwN09weGZvNThla3J4UzBr?=
 =?utf-8?B?REVocVk4WUkxK3hFZzJWaUhuQnNYS0tJMmFERVU0ZTFPMU1wb0xGdmgvdmx0?=
 =?utf-8?B?M3VXdGRWZXoxenJ1R1Zqb2s5dk90RGVjZEVENlFzQkVWVEI4OUZvd2lId2x0?=
 =?utf-8?B?TVFjL1ZrSFVEbnZMVkZFMVhvWTRrMXFpNWVDNjhRbGVDVkNCeWdDUG1salR5?=
 =?utf-8?B?UnVZdWg4MHZZQ2M0TEN1ejZBN2tXK0lRRE5HaDVoSHNZY1dueUMrY0ZKL3lZ?=
 =?utf-8?B?cUNJQ0xPMFlZV0wwTXlMQVU3aThROU5Hd0dDSjlyeWZyb1NpdUt5WTBUZVBV?=
 =?utf-8?B?WStsZ2VuaDJMRUtMMEZVZ3dvNE81Q3h4L0N0bFcwbEttTU9Ic1EvcHdIQVZG?=
 =?utf-8?B?cTFOUjhTbzdWOHJoQ0ZrT0ZEaEdzRG5vcFF3ZVZyRG1iU0JHODdIWWpoVUZI?=
 =?utf-8?Q?UaahNgaMPK1Sw6lQEn3QWdM0V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61276d08-bdaf-40d3-1e05-08de01972017
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 09:36:12.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIR5RnqiyrEzF/pKedl/Ca1K0I1vVM0lndIMXC1yk6vFgvG0p5rHTh68gkx71IiOv+4BRk9bOhZ5/rVq9VMO2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139


On 10/2/25 00:20, PJ Waskiewicz wrote:
> Hi Alejandro,
>
> On Thu, 2025-09-18 at 10:17 +0100, alejandro.lucero-palau@amd.com
> wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Export cxl core functions for a Type2 driver being able to discover
>> and
>> map the device component registers.
>>
>> Use it in sfc driver cxl initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/port.c            |  1 +
>>   drivers/cxl/cxl.h                  |  7 -------
>>   drivers/cxl/cxlpci.h               | 12 -----------
>>   drivers/net/ethernet/sfc/efx_cxl.c | 33
>> ++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h                  | 20 ++++++++++++++++++
>>   include/cxl/pci.h                  | 15 ++++++++++++++
>>   6 files changed, 69 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index bb326dc95d5f..240c3c5bcdc8 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/node.h>
>>   #include <cxl/einj.h>
>> +#include <cxl/pci.h>
>>   #include <cxlmem.h>
>>   #include <cxlpci.h>
>>   #include <cxl.h>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index e197c36c7525..793d4dfe51a2 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -38,10 +38,6 @@ extern const struct nvdimm_security_ops
>> *cxl_security_ops;
>>   #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
>>   #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
>>   
>> -#define   CXL_CM_CAP_CAP_ID_RAS 0x2
>> -#define   CXL_CM_CAP_CAP_ID_HDM 0x5
>> -#define   CXL_CM_CAP_CAP_HDM_VERSION 1
>> -
>>   /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability
>> Structure */
>>   #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>>   #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>> @@ -205,9 +201,6 @@ void cxl_probe_component_regs(struct device *dev,
>> void __iomem *base,
>>   			      struct cxl_component_reg_map *map);
>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>   			   struct cxl_device_reg_map *map);
>> -int cxl_map_component_regs(const struct cxl_register_map *map,
>> -			   struct cxl_component_regs *regs,
>> -			   unsigned long map_mask);
>>   int cxl_map_device_regs(const struct cxl_register_map *map,
>>   			struct cxl_device_regs *regs);
>>   int cxl_map_pmu_regs(struct cxl_register_map *map, struct
>> cxl_pmu_regs *regs);
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 4b11757a46ab..2247823acf6f 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -13,16 +13,6 @@
>>    */
>>   #define CXL_PCI_DEFAULT_MAX_VECTORS 16
>>   
>> -/* Register Block Identifier (RBI) */
>> -enum cxl_regloc_type {
>> -	CXL_REGLOC_RBI_EMPTY = 0,
>> -	CXL_REGLOC_RBI_COMPONENT,
>> -	CXL_REGLOC_RBI_VIRT,
>> -	CXL_REGLOC_RBI_MEMDEV,
>> -	CXL_REGLOC_RBI_PMU,
>> -	CXL_REGLOC_RBI_TYPES
>> -};
>> -
>>   /*
>>    * Table Access DOE, CDAT Read Entry Response
>>    *
>> @@ -90,6 +80,4 @@ struct cxl_dev_state;
>>   int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm
>> *cxlhdm,
>>   			struct cxl_endpoint_dvsec_info *info);
>>   void read_cdat_data(struct cxl_port *port);
>> -int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type
>> type,
>> -		       struct cxl_register_map *map);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
>> b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 56d148318636..cdfbe546d8d8 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -5,6 +5,7 @@
>>    * Copyright (C) 2025, Advanced Micro Devices, Inc.
>>    */
>>   
>> +#include <cxl/cxl.h>
>>   #include <cxl/pci.h>
>>   #include <linux/pci.h>
>>   
>> @@ -19,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>> +	int rc;
>>   
>>   	probe_data->cxl_pio_initialised = false;
>>   
>> @@ -45,6 +47,37 @@ int efx_cxl_init(struct efx_probe_data
>> *probe_data)
>>   	if (!cxl)
>>   		return -ENOMEM;
>>   
>> +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxl->cxlds.reg_map);
>> +	if (rc) {
>> +		dev_err(&pci_dev->dev, "No component registers
>> (err=%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
>> +		dev_err(&pci_dev->dev, "Expected HDM component
>> register not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!cxl->cxlds.reg_map.component_map.ras.valid)
>> +		return dev_err_probe(&pci_dev->dev, -ENODEV,
>> +				     "Expected RAS component
>> register not found\n");
>> +
>> +	rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
>> +				    &cxl->cxlds.regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc) {
>> +		dev_err(&pci_dev->dev, "Failed to map RAS
>> capability.\n");
>> +		return rc;
>> +	}
> I've finally made some serious headway integrating v17 into my
> environment to better comment on this flow.
>
> I'm running into what I'm seeing as a fundamental issue of resource
> ownership between a device driver, and the CXL driver core.  I'm having
> a hard time trying to resolve this.
>
> If I do the above and call cxl_map_component_regs() with a valid CAP_ID
> (RAS, HDM, etc.), that eventually calls devm_cxl_iomap_block() from
> inside the CXL core drivers.  That calls devm_request_mem_region(), and
> this is where things get interesting.
>
> If my device happens to land the CXL component registers inside of a
> BAR that has other items needed by my Type 2 device's driver, then we
> have a conflict.  My driver and the CXL core drivers cannot hold the
> same regions mapped.  i.e. I can't call pci_request_region() on my BAR,
> and then call the above.  One loses, and then we all lose.
>
> Curious if you have any ideas how we can improve this?


I ran into this issue early in my development when working with 
emulation, and I had to share the mapping somehow.


It went away with newer more real emulation so I had to no worry about 
it anymore. But yes, the problem does exist. I can not find my old code 
but I guess the solution is to pass a pointer to the already mapped 
region implying the mapping is not required. It requires changes to the 
cxl core but it should not be too much work.


> Cheers,
> -PJ

