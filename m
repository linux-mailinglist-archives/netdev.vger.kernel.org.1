Return-Path: <netdev+bounces-154337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F99FD1C8
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 09:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363323A0602
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D695814D430;
	Fri, 27 Dec 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WvpfbOx5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604414AD3D;
	Fri, 27 Dec 2024 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286670; cv=fail; b=jU6jW3v+wOnYwiQwF3zOCFJ9YAAdbsBcgoJOSSnIN8sOCGfK9yVTpBOUAA5TzTTOZ7XUxLhwgLg43ZF5X8UE1qOpeUaMEcw5bXpALV+qdqsPN5eLZVUJ+Ekv1+RUW7W6iZhW02tkfCASnnIxxDVIJblSX4PwxLxkk1jooTdyGXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286670; c=relaxed/simple;
	bh=ChZll7QpReiY5X6ipzUSz4BgGioZByT30eOXvmbn1pQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUA+s6UxV0iQBpjGUQCTujOFuooUUAmgsgnc2ayfHYa3O2AZnk4LCwEMa3P5w+xvTdDTNQvy03bzWMB8d/gpndu4yl/79zoAE53I5Apw1LcHBJ+hJkscxJ1CXcesIB7mGx/o7y6yw9OxJogcaD1X+AZ77EBST4nW7ZP+JH5ytXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WvpfbOx5; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/FOGv8nX2ksHMyt4VwSi9FKgvfQWsDnX9hPGBzsb1NGTr/54bh/7qM6DhkJ8MChTKgEYcNm7LW1X4pDiu/nS9rAdOu0bOEIPjfTwub1nMffhoOYyTWnDxdADzIEUbfQIZTmS2ARmBkD1BHCy0u7h+lSI1gmYElv3KhpUBr/aXNl2mz7NcTMKLm4kRNb9XN4VSt1PW2VtaumdNXQPx3KVoSwi5emeehxahcmssKoleGqKHm6U8DIFWtAi+ci/sz5inDlwwk3V+Z22GCscb1lqBM57Uq8wR/aeF2vhAwSISIDcMGEbkTl6dgqwNFXvGkqEPZ+UgNNJfJwPFI0GbLPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o6/VdXe6QkKRwVUx3xpWbUHcV2yzR7iq3KcGbTydQU=;
 b=S5VGJOjla533b0cn0ez6A+DxcL/YLM6Xn5F8agnbO/T8Ci5Dj6UTAW1fm9rR8DHztlekQb3EkMSZNcVL6DY5eiWBjmqiM4VuuCYx9HP1fu4IhFGct2wrl8Nu1laDzosZKFTjzeuAZkt3ktDI3HJHAGylEymlLULIJw466KuOvm/fLDh7xtmm6En+DTesESvh+ytfD194NbGaUWqvxD9SaavXYsXM4nxpI5XlII2nE4eo1iUQi2nawCiJOIqoseswJmt5VIKSmexb8dy7lZccPC3vPME3NH6dh76o4fPuss4UJKo10MLMvZz8Vu1hi4N5bfNOACDLAjQIgE7pBGjiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o6/VdXe6QkKRwVUx3xpWbUHcV2yzR7iq3KcGbTydQU=;
 b=WvpfbOx5UZSGLoots+ImNQvb7XpQEDyKMqwIVrzyHTyZUoS6W44s2bocwy/RMqUeafZ9YVY+Flghiq5rR1t2GN7mGkYn+IW38JwiGytg+znLViTV/IManGZAW6oGR0dhuZV57u6zVxOYfVoviL0+zZEp8+dcYFwASz2EB8J1ijQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 08:04:21 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 08:04:21 +0000
Message-ID: <e814e5f4-a48f-cb12-1d00-3367f5355d93@amd.com>
Date: Fri, 27 Dec 2024 08:04:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 06/27] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-7-alejandro.lucero-palau@amd.com>
 <20241224172236.00007c6c@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224172236.00007c6c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::35) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d4af48-c117-4731-df4a-08dd264d11ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHp4VHFiWGV0dGMySGd5bElFalc4NFF5cFo4TklUTkFteC9TWlRaUmIwdENQ?=
 =?utf-8?B?V1RBeE1sNy9wWUVkODNhNmJBWG8wbXN1N3M4VTlSTGcwRC8zNEFJcHR2eXJG?=
 =?utf-8?B?Q0ljZ1VoZ2o5aVJVY2k0ckNLVVVqeUJJTXJraWJWTFE1UzlUSCthbzRaSGJZ?=
 =?utf-8?B?T3IzNllSL0VFeHpzN2ZSSlZHY08wT3dGSjdzdkIrb1ZKS0ZrMHprVjJndUdU?=
 =?utf-8?B?ZENpaGhMdkYvZGVPMDJ1eVEvZkVtaUYra201UkRwY2xWclk0b1pCbWdScngw?=
 =?utf-8?B?SHVCM2lyWFJaY3lLUlhqemNJRVNOTEl4U2VhRTk0VW95T3piZCt4cG0xYjFQ?=
 =?utf-8?B?WkEyaWZPRFVIamVLRDQ5cXJpT3pLdVZCVEFJNGR6YUR6SVFGT28rTlZpbjRE?=
 =?utf-8?B?ZHQyRmpoSU81V24ydDJSNGdxSGlDdUMvSVdOcnM0aC9kTUhNN1hIK1JqVkI2?=
 =?utf-8?B?N3NCdCtDemw5VjJvditGdGNzZjU2eUJMbkNTUkVxVGZrWUYvZW9KamU4SFBz?=
 =?utf-8?B?WHpNdG5ETlVYOTlJbmJoWHoxL2RjTkVGcVg4VEJVM3RIZkV1Wm5ETEtFTGJG?=
 =?utf-8?B?bTExM0hvYnAycXhSVXN2WXp3elBCWEFXQld3UGdoK2hHbE1jSStQTm91UjJN?=
 =?utf-8?B?Mmo0aHhyZGtYTStvazdZY0h4SWI1ZU9EU2FFZXR4Y09qdzJvQWl5MndHZnNx?=
 =?utf-8?B?eWNpdlVmUW1xQWV3cm1xMlYyQkRLV1ZvMUU4MnUwUnoyOTlGQ3dTVVdYeWN0?=
 =?utf-8?B?K0F3eVVBVWVDNDZXR1BwWmJpamx5TWZ3RHdVZjhnQTh6MUpMa1VpTFNITHVL?=
 =?utf-8?B?NFVEV1JkaGJHUUQvN0pGL0pzc2hJODFvV3V4cUxrZ1ZRdW1vNnN6WWJSc3JK?=
 =?utf-8?B?VXRlNGZpNHpETzhldHFmRFVLYjNzdFpKODBUckJob0YvTERVTDdpQzNuQ2t5?=
 =?utf-8?B?clNkbDJPUmNBMDhaeGdPQnV3SzVTaU5ITFdENjE5RmpNZFU4UXpRaTJucWtS?=
 =?utf-8?B?Q1RPaFo2WHlGK3IxbS83b3paZDUxZUpWQnlGZllSMWVGS2hVMXlHd29QQVZ4?=
 =?utf-8?B?WlVSWXl6SW45Q0pJRUZvQU9Ua3p2cHdTRmNyd3cwM0VRNzJuL0dDTkFYcnpM?=
 =?utf-8?B?RzMveFdzVjVvdHdBbkR0VGtFNVRVN1ZMV0pvQ0RiMmU4ckdxWVVXdUpLUm9F?=
 =?utf-8?B?bUJtUFZWS084T0tmN1JIdlY5aTlHdVJuRkRiQUVwVnpTa0xTcjZTODJ3VlVt?=
 =?utf-8?B?SnRySmJqL1dQZ2xUVkJjY0x3cUZmVkJzZnlwdUg3ejVYL1djQkt5RnZtMU9z?=
 =?utf-8?B?UGkrT1dwZENHV3pHaGdZcFkvSHMxd3hHOThQSW40bGNraVFuN0tMME85eHFm?=
 =?utf-8?B?UWNGY284eEJGajhqZTBoZEdWdTlJUVd6M3VQZjhvejNqVDdnekx1OGR6WHF2?=
 =?utf-8?B?d20wQlU3RXRHaklDUG85Wm5WZ3BZVXZMaWFFU1d4QzZUTFZOLzVFUTNRT0cy?=
 =?utf-8?B?aS9xTGphNGNCRHZpZGlnQ05KQ0QzeE9DQmFtRnQxMHZIODFEZkxkdmNsWDg2?=
 =?utf-8?B?QUpZQnc4TkUyTFRqQWJTY2dybUxYNzhqYTZGS0dRdEEvZGJxaE5PcmUxTnpx?=
 =?utf-8?B?SEw0Qmo1eGRybFhNckNyczAzVFUzNTJlSFpHbks3ckxBeUxtdUhudU1BajZ0?=
 =?utf-8?B?VWtwOFM0MUs1dlZ6TkxhOFAxa0lmUkJNZW0xZzJRdy96K1dMdHFNZTlmRFh2?=
 =?utf-8?B?WjNMWVlaTE81NS9zdm9WTmNsMXphK0Y3bm5VOHRRa1hYLzN5bnVMeFk2aSsy?=
 =?utf-8?B?eG9ScWZpY3VWRW91RS9nWlJDaUxvNDQ2dHZIVUx2b1dWeTBZM01iUnlZVHN3?=
 =?utf-8?Q?n9/CF4arUeKow?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nnp5SEF4ZVVRVHlNdTFmOVFqd1FyNTVPUiswSENJeFNwOGxuVGNmcDFSc0Y1?=
 =?utf-8?B?YTdkVTJDSmhObld5WVNpOHRCTnF5MDYzQ0h5ditWb1BTZlhJUFYwL0tEMWQy?=
 =?utf-8?B?Zy8wZ05ybzBiQ1FNUitadkdYa0JtZ0lpbk1xNHNXR0FQTXRhTXJsTnVlUVhN?=
 =?utf-8?B?YU1DQXFmTnBoamVzWDFYZnlMNXh1THJGbHFwNXVXaXp1c1RoTGkrQWZBUzJj?=
 =?utf-8?B?TUhKbzRFTUJOQVM1TndudExCeVRhWTcvVTR4ZFJRSWZ5a2tyMGVFWXlCaGV1?=
 =?utf-8?B?Y0NaWmg4Mkw5aTV5bHc4cXhPdU93ZE9SR3VPTzgxdGJONlpKSHM4LzlONk4v?=
 =?utf-8?B?NGppZmVVNENBRHkrVFdrQXhVSFlaZWhyU25nTjVqODN2Q1RVOWhlSkk1U0s5?=
 =?utf-8?B?RjhwTTNFQmJZM005eENEbGNPd1I4YjVtZlcyQkVOTUtqbUVFQVFzMm9hT1ZF?=
 =?utf-8?B?dDMwVDNUSnIrTE9hZFlITjluRTJkaDdmMExGN0FyVDZtR3R2ZEdEZW5oL0k1?=
 =?utf-8?B?ZWduRUI2NFZSNitaMjZidkgvWU5VaVJrd1N2ZGg4RXJJV3FTRHIzSUJ5ZEUy?=
 =?utf-8?B?d0Yzb2lZWEZFTUVIRFA4dWpQcG1zYmJzL1Y2WVdENWw1TkRTNGczU0Q3UjdO?=
 =?utf-8?B?eWh2UXVoVGt0NmRxNzgwd2ZWVEFJVk9EdUZVSUU0a0xBWmtQUEluSUJuTHhO?=
 =?utf-8?B?TXFVcnQ5WURDRFVhd3pTcDN2RXZ4R2RpYkV1cFdSdkd3YkZxQTNSdkMwbTg4?=
 =?utf-8?B?RjlXMlNHcG1uUkZ1enJocUdhUFRxNjlzNGI4ZDE4Y3VpUjNReUxmbmdSRksr?=
 =?utf-8?B?MGxkZ2NoOGtzSFAvRHBWTGZXM2FhV3c3VGxmdlNJbmh1WEp4WE0yS1g3TTZ5?=
 =?utf-8?B?Q1RrOXhIaHJZKzZoNnB3RlVUREQ0UmlTVnpyTVl0Z0pobU1EM2I0bnVKbHpR?=
 =?utf-8?B?UDdSRkVhYk5EOG1oVm14Q1RVNmJxMUJ4Z3U2Tk50MVFPZU8rVmpRU294WTJM?=
 =?utf-8?B?MUtvN3ZqYWUwS2xETTl4T21hSnBHOFQ5RkFoQUt1MW1yeG94NU1tVW80THZa?=
 =?utf-8?B?V0V1MzM0QUg1NEFYUFlhaWhMSnc3UkJuTHhTR2ppT2JoR3lyUGcwcXZaUGpY?=
 =?utf-8?B?a1duM1NOcHRsbHQvcXZnRDE0UGdPVmtNckpSSUcrK0dOb3hmR00ydDZsc0lx?=
 =?utf-8?B?Sm9US2N1TDRwNUc3RFhoSTZoMjhkMlhHMnpiM20xcHlqZnhkRFpsbStkUGtP?=
 =?utf-8?B?R2NSR0RBT1Y4NHowWStJS3hRQ3FNazRXZW5nTHRLUHNhUTIrTHg5WEppNkNM?=
 =?utf-8?B?WmNraTVkK3hoSVE2QnRoSXM1Q0lWbll5bThUck1CS0xDbVI2Y1EyNC9ZeEFB?=
 =?utf-8?B?N1huNG1IODlicU5UZldmc2ZJSGs3bThtbVhSOUJuR2FaQWhRZWdQWjdqYkFo?=
 =?utf-8?B?b2JPTSt4TVJlN1dodEhpamQrUklYcHFQZHJVZXhqdFJ4MFpzamhkK0dlMVh2?=
 =?utf-8?B?M3QvNmU2dEl0cVU2ZVYwV0ZTMStMMXFYQXV2U3Q1ejBsWEhMMEZaWHFDU0ZQ?=
 =?utf-8?B?OG9UdThRV2JOcHNrZjJ1OHJJWGxURkI3b1pHVGdCaDZjQ0I2Tm1BYUhiTURK?=
 =?utf-8?B?YjZVN1VTVTZCSytyWTV5alg0eXk2WmtiOGZlS1FqQXRXWTV4aWtKS1VhTWJw?=
 =?utf-8?B?WU96Qmc5S2pKSytkSW15c3pIaXlRTk44Q0JaRk5ZRXIxYXVXc1VoN3REbHd4?=
 =?utf-8?B?QXdtZ2JCMXh2L0JqUHRZWVZWYlpYK2t6enhFUFdVUW1GekNaT2JMSFB0RXBR?=
 =?utf-8?B?ejlWMWxzV1VnYnNKVFZWWGRJYnRrS2plYTJCVTZFQ1dQdkcvd1RrUnlJTGx1?=
 =?utf-8?B?UzFoYnAydlh6VWNKRVY5azA5SGN5TWlqRGhKODdhNUdGdmZIQm9HQnpEU1c5?=
 =?utf-8?B?cGg3SVdQYlcvMGJEa0dxN1hWREYvbU5zTXVFZ0xMMHVVYzdPdW42SDdtdkRn?=
 =?utf-8?B?TFhIRjk1bTlkN1ExYW1MODgwQWZDdWRWZVdyL3hPMU03VlZlSFVPMDJSOGZt?=
 =?utf-8?B?UlRLRG1VREJCMDUxZHBxMTFtTjFMVU0ycmZOc245cXpSMTdyRzA1YlZJSkhL?=
 =?utf-8?Q?sbSootqRzJscYOnQSF13Hp67j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d4af48-c117-4731-df4a-08dd264d11ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 08:04:21.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78HNRIdQJIsfVVY2GPZoe18grgLt6ONr8LYsuDa3/7ta31Q+hfgV/0sliofO38x1QKOtZ9pzv/6pm15OTG+cDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451


On 12/24/24 17:22, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:21 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Comments below.
>
> J
>> ---
>>   drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  2 ++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 3cca3ae438cd..0b578ff14cc3 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1096,6 +1096,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>   
>> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
>> +				     struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>> +				cxlds->capabilities);
>> +	/*
>> +	 * This call returning a non-zero value is not considered an error since
> Error code perhaps rather than non-zero value?


Makes sense.


>
>> +	 * these regs are not mandatory for Type2. If they do exist then mapping
>> +	 * them should not fail.
>> +	 */
>> +	if (rc)
>> +		return 0;
>> +
>> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +}
>> +
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map, cxlds->capabilities);
>> +	if (rc) {
>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
> rc is 0.  I doubt that's the intent - if it is, return 0;


Well, if the conditional is true, it is the end of the function, and we 
know there is no errors,so yes, return 0 will make it.


>
>
>> +		return rc;
>> +
>> +	rc = cxl_map_component_regs(&cxlds->reg_map,
>> +				    &cxlds->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc)
>> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 05f06bfd2c29..18fb01adcf19 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -5,6 +5,7 @@
>>   #define __CXL_H
>>   
>>   #include <linux/ioport.h>
>> +#include <linux/pci.h>
> Use a forwards def if all you need is
> struct pci_dev;
>

I'll do.

Thanks


>>   
>>   enum cxl_resource {
>>   	CXL_RES_DPA,
>> @@ -40,4 +41,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>>   			unsigned long *expected_caps,
>>   			unsigned long *current_caps);
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   #endif

