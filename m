Return-Path: <netdev+bounces-177475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924AAA70494
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F273A93BB
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284E825A2C1;
	Tue, 25 Mar 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nH9NoDlR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7DB13D8A0;
	Tue, 25 Mar 2025 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915260; cv=fail; b=ZI6vkq4MRlNq9LuLHQxbATZ43vUsYIyPgKGrXQshXkyrhkX9HKXiEQ+nMBSCadSraZC5wfxZq1FWKvWU3v7MPNCcV3KvqKTwI+/kUd/G8PtCFHu0iyxQGVXaKjhjq98EMHpNopvNLkqyEAC6+1xEwleiERoYmDiW4b3NdhoulD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915260; c=relaxed/simple;
	bh=ArPyBrrbH7u8pZvsCnCU9b3JkU0CvKSexRk73ucv00A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m0q9LNMUKTdEe5xAiHFufXFj6e/z6+dxE8RV3OMBOxprE4cRn+3HUZBrtH/o+zJW3lDl/OgDrp8XIE5kR+Szi8zf4yXpl8kypj+WRGz0S6CVLQAny7ah2fcTNlsP6XijD2IDZy+baS/ij0qtuzfbCtO9C7c3nNYwMBP0yJDP/GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nH9NoDlR; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6iTAOCU3VqqBExYxldXdzFbHEoLYqvAx2Lw8sYKrKBhVv7UttT7Mil1gKVt8C339NxfUif+eBsCNxStgu/CXE6Lg6uQyA/fu9uohFlB78jTK9O6LLVAW/omVeixabgQ3e3582QROu9B0/yS3GQTv9jAkpR04xvcj6gkAXdPd233y+/1GNQ8BxStqPE5v3GIdwZhHWgd3oG8mBLuYQLmuMlEjw8+ZnXgRY72u0/fkLNfeiB5m9p7gi0HuUUXNtQKoUCaMzXpbuq24JRZiBR+q+CuJiq/eB9AklOZTCIZCh3gGAgVlozM8G4xAD3wAGP5Nq0hkpPSX2JD75KYr6JE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vspdmLVyErgS+vuEARXeOJY/uzM6RM0OjXQTarXtVhc=;
 b=urzebk/wctIMGeEROQiIPZ0ToG2o3dEEiQ0EiEM8gh4e6fkFeD/wIAt6crrv8dmJKmAwlahYC6K+ZzDzIWwRumFwRrCIA4NpBE2VBhEa+h/V+IFlEN6xCCoxifX5YGYpT35tGLWLT30GVC/HSLmK3BrO6DI28+RTzP3sLj2QuBRiSCGN4NeOD8m848gvj3wbV49Tnnw0JS0aUF9jpzycW1j0s7obzVqd5pebyn6IHYUiHjrZPrW3yofq2oc85BjB3OfG3gqo2ekqOns8QSKtyO09EKRQYJ3S7myy8H0OOAmTKajKTxH4oVTWMUUAY0kNiEBc6Jlrh3twNoLJR4d2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vspdmLVyErgS+vuEARXeOJY/uzM6RM0OjXQTarXtVhc=;
 b=nH9NoDlR4NQlW81sswByp0H/+LYgQXvvY6dtNrKZBhOwsUqNZ7fAFXMr7wMt+fcO3Eaxq16kIlPa5nU/gKM6m1EunAQCO/cmAUuScsP075n/zs+QKJ/WXwgiz71gj3UEVZRsdbHRHFJ2F5B6zpT9R9SEtPzmjOqdtP+B5IHV0PI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:07:35 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 15:07:34 +0000
Message-ID: <72025133-8d0e-4ae8-af7a-410c1aaced06@amd.com>
Date: Tue, 25 Mar 2025 15:07:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/23] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-12-alejandro.lucero-palau@amd.com>
 <34efb2e9-a2fe-4362-a1d3-43b63a4d7c76@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <34efb2e9-a2fe-4362-a1d3-43b63a4d7c76@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JN3P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:71::17)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: b00ba4e0-f218-427a-5fb1-08dd6baec59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVpJWUc0b2ZYTjRLRHJ6THpxbld4WXFyNUdBMXl6UkpkVGVSSnplbjJXbmhw?=
 =?utf-8?B?Q0ppWEU2S3hqTTI3Wlo5NC9Zd2I0YW9sVDk3NUsxU0Q2ODVsaUFRY3ZDb2ZV?=
 =?utf-8?B?QzlmeEFwdytQUlM5U3B2MzI4anM4REo4MnVHN3NiZEpVNUJpKzcwS0REOW4y?=
 =?utf-8?B?UFVWakpIQXpLbUxvMXBYNnFkbGpVZThnMVJ4dHVGNnVuQ0VLaXJJbUIyc3Bx?=
 =?utf-8?B?bDlNdjdJV2tyQVJtUk4yaVVBZlljQTdyUG9wMlUrTS9pdTRMUVF2ZUxPOElh?=
 =?utf-8?B?em9VUkdaU2poaTJITXRxVmFRbGVxOElOSkxKN3FLZ0cwVFZ1bmNsREZqeWRR?=
 =?utf-8?B?STlEZjZsS3pTTzZienNXQ21sNkVvRjdmZjRQSXdSWlRsVnlsUFJ1SzdFcGJR?=
 =?utf-8?B?VGlXR2RkN2k3TGo2OHYvZ2FVK0Z1SVdpaW5zK0U1MUd4UWlBa1RPY0hhYjNh?=
 =?utf-8?B?RmppelpzOGRNODlGY3BOcjRJR2xuUVlub2E5dEZ4MHhpNjNXMUFZemNEQjh2?=
 =?utf-8?B?YlZtc1VKUWVLN2ZKSndWM2YwWURjV2tSdHBsRFJhQUp5NWI3a2dDMU9ONi9T?=
 =?utf-8?B?blBhN3AvVHo3ekdEcFhnOUhHdjk4S05oNU1GMmg2RWlzakNsZDBGSG9FY21h?=
 =?utf-8?B?QnliNExRSXMvaU1Oc3hwcXIvZ25iZlFXUmMxWXNsa0dYeGZKNVhkTmwrckV6?=
 =?utf-8?B?U3d1Y2FnSnZ4TmRyTHBBU0RkS0JQbVpsRlR4UHBPZ292UnRQUWU2MmlLWTRQ?=
 =?utf-8?B?cG1TUFQvLzNoSC9WNFFHemZ3SzE2Z25nc01mSExON3ZDRmM0ZS96Y29MaVla?=
 =?utf-8?B?T0NQd3pBdHBYQ29MdUJUV3lnSFZxeFdBeC9RZElMUkJ0bkR3dkNIQ0R0ckxt?=
 =?utf-8?B?SU16S1RVYmo0RUU4U3FKeHJnTUd5VUczc0xsciszWkJjbHpoVmh4TWpMaU9W?=
 =?utf-8?B?SnlaZnVsc2dDRk03YjNjSEtKSW9nRklUdnYzZlFOQVhmd20wbmJHeHZYb0tt?=
 =?utf-8?B?NzNGek1kZkJVczVIL2FJb0NkdXFQbS9Fdkwrbk5BSFJrMFU4VnlCNURoWEVw?=
 =?utf-8?B?aWpPVUhDb0F5RkxyUkVSOFJ1RlJIQllCaFNEMUVoV2htdUpxSUd1UFlCTE12?=
 =?utf-8?B?Z1FnQUZxSmMydVVrRDNIWUpsbnBvbm9VZ2JiZEVrWUI0WVdWQjNIZTY0SXNi?=
 =?utf-8?B?aW5pZjU4WS9Cdk1PV3lTZlBKVi9BUkRrNG9hK0ZIaEdPbjE4dG1XSWVCa2ZH?=
 =?utf-8?B?UnhNc3RLdnFHaWdIbVl3NlFUVE14ZE0zTks0RjFuTHJhNmNLbnlOM3VTNmIv?=
 =?utf-8?B?QW5yVzlqd01Cb2h0ZkRnZXhyWlN2Y1A5SjRRSW5jbzJKbTQyN0tVMlMybnRG?=
 =?utf-8?B?MmlCUStjR0hKc2dYbkoxTVpJRTFjODcvK2FXNUxjWUlaMWZETWE3dFdmaDJJ?=
 =?utf-8?B?cUtCbUV6SysrRlVUdnhSdVpwdDU2QmxVaWlPZjIxa0loQTdrMVFQeStuUC9B?=
 =?utf-8?B?QzFmV3pvL0pnV2p4eGc5VkRtYkdranZtbzNBcGtUMjZYQ3luR2FIbTM3cGVX?=
 =?utf-8?B?bWNWUjU5ZHlYcU9BcmRUN1Y5M2dJbHltcDJ4bCtCVjhNMU9NQ3lTT0JHUlNX?=
 =?utf-8?B?cFc3STNFQVlKTG14U0s3NmFhTm1zR2RmUUFXOSt2c3E3S1RnYWE0ejNqTENK?=
 =?utf-8?B?UUxMQWFSdm9mUHJPQmxTRHF1bU9qMjlGelRvTHZGR3Zod2pDUnZFMHpyL2ZY?=
 =?utf-8?B?NmV5WXhuOGRuU2VLVjZ0SlVZaFk5RmJvZnMrWWRTTWRSanJjYVRjUGVNMkts?=
 =?utf-8?B?T3JreCsxdmpVSVFrSzN1VDNWeDRQWllYUWk5ZE56RzJHbTVDNEg0RjdsbWpC?=
 =?utf-8?Q?bQkgYoljn4zGd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGhNUDlnQnp1dlVIbW9PcFI0U1BFb1ZURnZuTGY5TFUwaDdnT2k1M2U2Zk96?=
 =?utf-8?B?a2dRYThvRVZzRmN4OXVCUExDaktONGcwSHBOMzZpRzBuWFpNUDBwaFRVTjcw?=
 =?utf-8?B?V2lxWDFkY3R5U0xCUHVUd2lVV0xobHJQUTZhZFR4TG1qVC9ZSTV6M2tFZnBP?=
 =?utf-8?B?SXF2VHNXenZ4YzFSS01PV1Y4Y0dSOXI5OFhDck5ORWtrQ00wMmQ0TzFlQkFC?=
 =?utf-8?B?NGYrR0wxbHdhWk43RGhQL0hOVXdUdFZLQm1jSkV3anpDd3Qzazh0QTkzdVhM?=
 =?utf-8?B?YWg3RTZ3ZlptdDRCS3RyalFJRnRtQTNLanJkSldLOHdoelZhc2IxQlZ2WFY4?=
 =?utf-8?B?S2FZN2tUbWcxTDYxeWszL2JUUU9KWldLNlJySkpEOENBRXJnV0FhUFNvV2Uw?=
 =?utf-8?B?RzVBNzdhWC8wQVR2ZTNNTGxWanNBNWFKblg3WVZLeGVlZWt6YUkweHY5eHJ5?=
 =?utf-8?B?RzVkc3NyUjRCL2pGV3dxamhFcDZySGYvZWhSazhoSkRCR1ZMZ2VaQzB5R1Y0?=
 =?utf-8?B?c0xGSFhVWWRLNWtoaEV0dUhNNWIwZ295VG0wZmNWZStnYkpwckNUOUpieUEv?=
 =?utf-8?B?dlorZEExbVhRSFV3ZzdTNGtkM1JlLzRqWEp2cVpBRFE3THVaZUJXOE9aM1N0?=
 =?utf-8?B?WERwZDN5VVhDazFlWGg2eVkyTS9WL1BPRHZLdU9MS3l1d2RCWVZDZU51NTlj?=
 =?utf-8?B?RWlMRmpQWnYxc1kvUGY2N0lDVURjc3hFbEgzNDl4U2dZL1ArZ3dQalQyZUhX?=
 =?utf-8?B?UkVIVXVVeFhCSXJEdXRWbEVMTUcxL2Jyd1ZpdEh6TmtlWm5ab3R2Ull2VTF6?=
 =?utf-8?B?bXM2alRMK3pJYmY0ZENYbjZuY2NrZytja1N0TlVMZFZ2Tm5jZnN6WVRjM0wx?=
 =?utf-8?B?NUw3ZDRpMmZWWmRLV1M1bUkycnl6MXlzMGpPQkZlTWcrRWZjUlZ1WTkvVUx0?=
 =?utf-8?B?MXJNc3QrMDg4SFVBM1YwN1YvWGhkMnFsWWJEeHdEdFlpcUtJaGR6Q3ZaZk1X?=
 =?utf-8?B?akhnd3FJemRPZWFLbWcwWk03MHZMaFREL1N0UVdFU3RhYjdRc200N3RjODFx?=
 =?utf-8?B?Sm42NytoYTdYS3owRHFHUnVBR2NmUkhmbzBTaGlwKzE0TXN4bzZtVkR2ZmJF?=
 =?utf-8?B?NUtPa0ZKQ1hpZEdBN0s0TG1uS1orZ0kyVThrRGdUNVM1QVBSZWJDRkFQSTJP?=
 =?utf-8?B?aUU3WHU4SkNaM243L09QcnR6cTRNc01renFsOSs5SnBTZFZnRnIzNWpmcnZR?=
 =?utf-8?B?V1RnR2N2cFdnN3VyQlo2ZzlHT0RlWWJ2SHU5dXpoRUlPbFdUSmxsbmU2SzVG?=
 =?utf-8?B?azFwcEpwaXhEbHdHeEt3a3Z4UVl5dlU4YVNsbU1UekVxREVHb21qOENWeDd0?=
 =?utf-8?B?bXNiRjU0YTNlelE3MUFPOVdoVzZTV2h1NTBMQ1NoYWE0RUxwZ0RCcC9tM3hP?=
 =?utf-8?B?alZ4OW0rZ0REaVFkb1VHbVMydXZLWGl1cWtSWE1nR01VT05hSWZvdGhWdDU0?=
 =?utf-8?B?VUloalA1c0ZWTEJndkdIejByTWJiRFdmelBhVk9zemM4Y2xiY2JOYzhOMStN?=
 =?utf-8?B?S3ZzT2RHOWgyL0VLSFdpVE9wZlVmem9GSUw5cXQ4TXNxYllZK2hkZXRKZjZq?=
 =?utf-8?B?SHhaczhRY2RPOEt4bWVzRE9JQU1CT3VNSFJub1ZqQWdORW8xMDdKVkZSNmZ2?=
 =?utf-8?B?NS9Pbk43TVVYRXNzcHVRV3dyUzNxTnpiUkQ5OXVQTDRLdGZEeFBqNlcwUTla?=
 =?utf-8?B?U285MkxmMWdjenJUSFFZY1JBcytuTHpaVTNoQWFPNnc1cGVGYzNRaThqeFJo?=
 =?utf-8?B?YXRxU2FkZjNXQWZoN0tCZlpab2YyTjhDbFIyaUFXNnptUlRjMWgxTGNNMTds?=
 =?utf-8?B?ZTVRUS9GWWpTeEVWSHhORExLc0ZsWnl0UjVtZU9kNkwySm5ZRDZKTkZWLzM0?=
 =?utf-8?B?NHJldkkrMnlpZnZqaG9HWjhHOE84K0Y3VHUwbmI3ekVJVVAyZ2JDYXc1TDUx?=
 =?utf-8?B?N2FMNjlXLzVseU4zdmtndi9MMmpkM2dZZVZEMkh3QlY5bVpCM1Y1SE5ZOFBX?=
 =?utf-8?B?Mkx2VjhnRG5tN1ZCQzFzM0k1WmxoUU1nYS8ydG91T0NaeWNJaFdwb2pDUDd6?=
 =?utf-8?Q?qX/Hi7IHmS09TnpS5FOq5lqwA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00ba4e0-f218-427a-5fb1-08dd6baec59a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:07:34.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BKKysv1PcFMGL10i/Ot3PhGOcom3YPDa/BQlzVR9LdFBijBWYbkgLXKY/N7P6CLCSrERHowKcwhhRq2tLV+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913


On 3/11/25 20:06, Ben Cheatham wrote:
> On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is created equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   drivers/cxl/mem.c         |  26 +++++--
>>   include/cxl/cxl.h         |  11 +++
>>   4 files changed, 194 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 8537b6a9ca18..ad809721a3e4 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -695,6 +695,166 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device * const *host_bridges;
>> +	int interleave_ways;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +	int found = 0;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>> +			cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	for (int i = 0; i < ctx->interleave_ways; i++)
>> +		for (int j = 0; j < ctx->interleave_ways; j++)
>> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
> I think kernel coding style requires braces on the above for statements, but I may be wrong here.


I can not see a specific reference to this case. But, do you mean both 
for clauses requiring it or just the second one?


>> +
>> +	if (found != ctx->interleave_ways) {
>> +		dev_dbg(dev, "Not enough host bridges found(%d) for interleave ways requested (%d)\n",
>> +			found, ctx->interleave_ways);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +
>> +	/* With no resource child the whole parent resource is available */
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		/*
>> +		 * Sanity check for preventing arithmetic problems below as a
>> +		 * resource with size 0 could imply using the end field below
>> +		 * when set to unsigned zero - 1 or all f in hex.
>> +		 */
>> +		if (prev && !resource_size(prev))
>> +			continue;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +		dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n",
>> +			&max);
> Duplicate debug prints here


Yes. I'll remove the second one.


>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
>> + *	    decoder
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
> Looking below, the HDM-H vs HDM-D[B] flag is called CXL_DECODER_F_TYPE2, so I think
> it would be good to reference that either here or in include/cxl/cxl.h.


Well, it is not that but I agree the description requires an update like;


"flags for selecting RAM vs PMEM, and Type2 device."


I think because the patch does not define the HDM-* as it is not needed 
yet, it should not be there.


>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this root decoder's capacity the capacity is reduced then
>> + * caller needs to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with put_device(CXLRD_DEV(cxlrd)).
> s/put_device(CXLRD_DEV(cxlrd))/cxl_put_root_decoder(cxlrd)/
>
> Using put_device() isn't possible in accelerator drivers due to not struct cxl_root_decoder
> not being exported.


The sfc driver is using cxl_put_root_decoder, so yes, the description 
needs an update.

>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridges = &endpoint->host_bridge,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
>> +
>> +	if (!is_cxl_endpoint(endpoint)) {
>> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	down_read(&cxl_region_rwsem);
>> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +	up_read(&cxl_region_rwsem);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
>> +
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
>> +{
>> +	put_device(CXLRD_DEV(cxlrd));
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
>> +
>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>   			  const char *buf, size_t len)
>>   {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 4523864eebd2..c35620c24c8f 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -672,6 +672,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>>   bool is_root_decoder(struct device *dev);
>> +
>> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
>> +
>>   bool is_switch_decoder(struct device *dev);
>>   bool is_endpoint_decoder(struct device *dev);
>>   struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 9675243bd05b..ac152f58df98 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -130,12 +130,19 @@ static int cxl_mem_probe(struct device *dev)
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>   
>> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_inject_fops);
>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_clear_fops);
>> +	/*
>> +	 * Avoid poison debugfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (mds) {
>> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_inject_fops);
>> +
>> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_clear_fops);
>> +	}
>>   
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>> @@ -219,6 +226,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	/*
>> +	 * Avoid poison sysfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (!mds)
>> +		return 0;
>> +
> Are these changes to cxl/mem.c supposed to be in patch 09/23? They aren't related to this one
> as far as I can tell...


Oh, yes. Not sure how this ended up here. probably due to the changes 
introduced in v10 ... and not valid anymore.

I'll put the code back to the original patch containing it.


>>   	if (a == &dev_attr_trigger_poison_list.attr)
>>   		if (!test_bit(CXL_POISON_ENABLED_LIST,
>>   			      mds->poison.enabled_cmds))
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 340503d7c33c..6ca6230d1fe5 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -25,6 +25,9 @@ enum cxl_devtype {
>>   
>>   struct device;
>>   
>> +#define CXL_DECODER_F_RAM   BIT(0)
>> +#define CXL_DECODER_F_PMEM  BIT(1)
>> +#define CXL_DECODER_F_TYPE2 BIT(2)
>>   
>>   /* Capabilities as defined for:
>>    *
>> @@ -244,4 +247,12 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>>   int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlmds);
>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> +				       struct cxl_dev_state *cxlds);
> This declaration is duplicated
>

Good catch. I'll fix it.


Thanks!


