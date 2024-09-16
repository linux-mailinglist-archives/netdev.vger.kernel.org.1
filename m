Return-Path: <netdev+bounces-128531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E9197A236
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F3DB25415
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F51F158845;
	Mon, 16 Sep 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g6s7UE5w"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AB156880;
	Mon, 16 Sep 2024 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489481; cv=fail; b=eXqcBAlHIBHqAcKucpZUFM5UVjnslp90GYrwtVH8wvAhEjldSg4h+nkC9TW8xn60aBRZELHjPH0WkfQQ3bxyUnzJks8l4GCAYWYbRtw1lz0ILUxxxV/Tmwfjd70CGqcb14yuhBzH5ML7sdS4ifoolwpm2Os1anSfiXASFRfnF3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489481; c=relaxed/simple;
	bh=sgKMlqD9vITGl+2qglbAr+8JGab6V8QmTGPosseMjL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IxbeJQW1C/DD3kFVShfssY8nW3LSyMPE+dcBhFF8SsCCVRBawa4RHQD5h1UFMVxAWdS7AsF2xVPBVIMwj4yPbJFSHflz186yE6QUOtLOtArVpBIAZesS8Fz7k3M+yfukWwYgqnMHFYFJwRJ5HYKMRhWWbR5DSrAVMFvVcKyy1ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g6s7UE5w; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xgto/1JYXObbEy9AnLn1gGMThmEkIGHcelAdlvqydTnWk4XGteeNpsZ3/eUaUNXrbebLQdidP9qYRsT4RmEP4v/F5XJX11EHDkWvxHd7cY/rp1owTuxqCfyTm6/jbCOrOFDubzYW3uQPwKkvz5af+3lpv+iX7Xfu/DGO/x0dArx+a0779Dtcipre1ke2D+3T2fYYjZMZP6zXmyQlJoWBmlAr30AITHzx5z6s8gOm+/sy2KxyS2exP0+pOCxQglWta9clnpjzzg/gCK77SYN3QOm+rUCp0DakpQY/6tceIxX0YJsfHe8TKmJlnt8Oto6m+4vxVRAx0HsmxADb9rVJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE+dFcHFIC5mu880bB47sa+nFWLZs0Qc+eW97mHXapw=;
 b=qc1M/VHbqmEUcUdXIbyleYCJLpamSfLOl06fyMigv9mrkyTExlnZEycAe1wG0xy64bp2cwmDukz8DUEnIKH/lZpETM7N2m3c5QRa4FjiD+FrzP2RepY1JUk7OKgY1bYt77kRafvdFBgWfGKtqJGyvqpJx+ABVLm2LYBPsVXrfL2Dw3nvc9bsMJCmTw03LMEB61x6wQIzmTYd0TojqpTvzBkG5DQDKPJ5T46eMLdkDXNWNt0Xlyii/uJJ3J9hpLqTJ39jvKA7AAUXEK9/KbdYg0Z+LDfNPAcC7t8n4XOxdG9U38IcCHjgE9hb2lF1GIoNkx38au1UthcSzBmNaRhHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE+dFcHFIC5mu880bB47sa+nFWLZs0Qc+eW97mHXapw=;
 b=g6s7UE5wkpmJzc0GHOBNcq8vHLbA1KrntbulzI/oT//bX8BPyruXY6CZjikjHvDDMWSl2vxJRZlW1adIknAxy0AklBmw685X2tPvNC0uy8Tiu7GFGmfFkZI+O9rRkfmergQ7c9XLSWKxE0IKXsSrVd+/ESxM5Bnw7nIvBe6MPsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 12:24:36 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 12:24:36 +0000
Message-ID: <518d49a7-5dab-1ec5-5d85-7a84e487b9f9@amd.com>
Date: Mon, 16 Sep 2024 13:23:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 05/20] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-6-alejandro.lucero-palau@amd.com>
 <20240913183240.0000371b@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913183240.0000371b@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::30) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 874fd865-2116-4cdf-99c4-08dcd64a8712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1g3cGNqeTJRS0o2RjZMbm03eFdyK1JPWVdISjNWTUNjY0dSSHRPZEhNQmRo?=
 =?utf-8?B?RXBZSExsejdlcVlDOUhGdnJsWjl3SDVsREhIWW1jcU9rWDRxOXdoY2FRQzdn?=
 =?utf-8?B?NzdudlNSczFnanlKcTRZQ25VK0xVVld4b0VqT2FBVWNYb2RKcW9wclR4OVg2?=
 =?utf-8?B?UUY1cTF3ZmkxbDlOdU5haW8zV3ZzOTRpZkppTGFZbm1rRmJuaDJqaDhCQVd3?=
 =?utf-8?B?MG84SnZ3ZFR1OXBKdUoydXpkWmV4V1k5YjNEdUFrTFJBUTU4UHl5RU9rRWY5?=
 =?utf-8?B?OW5SakRDU1ZlTjl0dWNxUENINmtBY1lVc0trUnJZOGVBenNlOXFUaVRGOCtT?=
 =?utf-8?B?d2VEeXViN3J3bjFRUkhlcm1rOFRHak5KNGJvK29JZFJ0VTRTMEd1emFSS2dn?=
 =?utf-8?B?QWxLN205KzE1RDNTUU5Gc3M2MHhidC91QkZJRnpMdG1pMkVkdFVYY3JFRE5w?=
 =?utf-8?B?RHE5NU0yWDNhTlJnRDdMck5Zblk2QkZmMklFWnZFeG1wVUFZZ2t4V3UwZFFV?=
 =?utf-8?B?RGpJVnhvakZhSHFCNThrMjV5ZXY5VXBoZ2VFZUlYeGUvd21wYmNVN1hiVFRH?=
 =?utf-8?B?bTNiTkYrSUI0dVdmWVpDdGpDUnNUaTBwOWhsU1lueDhDTVpiM1pYbXhlNWpo?=
 =?utf-8?B?WHBHQjBkWjErdDB6RnBtbWdLUkdBZWJxRmlPTzMxRTRJUGpnZ0xpOVl5dG5m?=
 =?utf-8?B?THFFV0lUUlhVVWVtQnJhejZBT3diMGk3d2dtT1dPM1I4Tmp2NldlUUw4TXpI?=
 =?utf-8?B?dXJRb1ZlVWFReHcveDYrL3U1WThYekdyQ0ZsSUFXa21ldG13a0RIZktBZitt?=
 =?utf-8?B?bERabGxRTWZSdHd5WEFaSjJHVUlMQ2ZHYlhlbyttVEF4TnlVSXEvS0VGYyth?=
 =?utf-8?B?UGNWdjIwM2FNdzgvZWIyd2RSWE1iUFJtVUh4QStqK3AwL3ZEK1BVbCs0WFBR?=
 =?utf-8?B?SndlUDZ4RzBBSFcyalp4QjdjZDVZeVFBeG9EWXlYcFV3R0piOURBUGl6NDVl?=
 =?utf-8?B?Z1RzOGFkb3BwYkNKc1JjME5BRng0cTR5TlZ5NDdYWUpsbjY1aXdDcy9LU3or?=
 =?utf-8?B?OWVPbkE4bjZhQjdtTzZ5anZRVElERjY3QjNjK2RFRkl3b0V1WXdSYXp0bTdz?=
 =?utf-8?B?WnhXdHRtdS9EK0htUzAwdEhLcDBGOHVNa0tUeEtRalNBUm9rSXZWN1A0RjhQ?=
 =?utf-8?B?SHJiMytsZ1JZQW1IVUVzQW5wVDBGaDd0cndJSTJIbVhSUFFJc0t0YWZBVmJK?=
 =?utf-8?B?SEhMWDJhWVkvWE43TTVJMGN2b1pXRWt4NFFWS2V3VHowUlhoMStzeUM2Q2Nt?=
 =?utf-8?B?WGhLLzg2TDd6OXIwOUZkV3VIbDJNRGxaV3VtdlJ2b3RISzdzUDhINklaZlRG?=
 =?utf-8?B?b243UnZyQkhoNjNpY1U5SENIR0Vta2NzU21ucUFhWG0wNVJjWldPZ1hrQ0x3?=
 =?utf-8?B?OGF4U0xlN01aWEd4eDFONjJnZ2pYM0RJb1VFSjhrdlNXRUp1ak1lRWs3N2to?=
 =?utf-8?B?dE5QbVhXYXdPYnN6M1lod21JQ1puakZxYjI2dHZEMTJEWG9Kc1Q3aHdrREVh?=
 =?utf-8?B?dGU1M3RlRVRyN0twQTdoR0lLYmx2S3hPU016WVRLdGltbmtzL3U5NTJXUzB6?=
 =?utf-8?B?T2pzZndEMjl0WDNWb0YzNTEzd1FnaW45MmhMbzRBWXNhWWtUK1RsbExybFhF?=
 =?utf-8?B?c0VYYlYwYjZBS084RWlZZUNPNDBBY1NsY2NmV3ZpRHpkWTR2cThlZ2ExNzdY?=
 =?utf-8?B?VmtXb1FTOGlyNlZDbmlQR3hJUVdqblZURkFGdk5TaTdSYVVUL21SN3dKMmFU?=
 =?utf-8?B?TUxJOWptVmhzVjdPRUdBZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmFET3dxRmNjUnp1YmRNSmZEYUFWL3ZTeFB3TVpyYjhkYXJGTGp3V3hRSXlt?=
 =?utf-8?B?TzdINnZIR3V4clpGaXJCWFllaE1SNEYxazRWM29ZN1Y4cTM1UklLaE1YRDRD?=
 =?utf-8?B?N3hNMWdSZm9EMHI0NzNVcnB5elByU21iQUJXU1JpNXgwWDAxRkhLc0gyZllI?=
 =?utf-8?B?TkpCZFNEL0RZbmxVVmVxK1psUkxNaXJRMzFMWjRMaHc1azRyUHFFOFg5OVBw?=
 =?utf-8?B?T3RZVExJL0FHZ0lpYzJWc3FFQ0Rad3pDSTk1ODI2dDd2MmpoTFE5N2kwM1lO?=
 =?utf-8?B?TXQrYlRyQnE4N3ZtMmlJek9TQmNNZDlTZWVvWUJDV1pjdnBmNnExYTgzYW83?=
 =?utf-8?B?dmhVNzA4aEw0bXZlR2JKQTdxbUc0Z0dFUVpQZVZYYytBWFBkNXBwRFBwYUlt?=
 =?utf-8?B?eW9HY0lzMzVmUTN1UE1xSHh3N01yWnRuVFM5RWNRR1Z4YmdDVVZwTHpEYmxR?=
 =?utf-8?B?cTlJckQxSE44NXIxb3ZYNTB3MjVJYjdTaTR3QTV4ZVJLQ0tKZGxkZWRNYXQy?=
 =?utf-8?B?V2c3dE1sRU9SSUE1UE5LS21GR280UmkreDFoZkl3RDExZ3l2djY5M0NiTC9X?=
 =?utf-8?B?TWlMdEFuUHQzSmtoa1ROMUpaMmJHSldEMnRIbHpNWllEc1p1aE9lSmE0b2V5?=
 =?utf-8?B?UVpnWFN6NDJZemF2Qk9CWEc4Mm5rZk8rZXVVUEYyTlpObS9CdUMxY0U3aWJS?=
 =?utf-8?B?NHY0cVhBcGplTFhPRG1xN1lRZ09FU1E5bzdyczdGeExsZjU2TmxKMFpZM0Q5?=
 =?utf-8?B?RnAzOERrVDFPaVEyRUNIcWpmTTYwNzlhK0hpVVgxMUpURXNKc3NHeU9KWlUy?=
 =?utf-8?B?cHJsU0tlNkxqa1hOckxpRHI5Mklpci9ZOG0zVkxsSS9YYnlBUmMrMi9XV0Jn?=
 =?utf-8?B?OWMwS1FLcFRSQWJuSk9idUR1ZFhLUk5WTEs3bHZnQmhpVHl3U3RERExjQkxP?=
 =?utf-8?B?M0N3WE1uaE85TStwNWE0enNiOVl1VFVGcCszWVFhYmozdzVrVVMrM2ZwTDdQ?=
 =?utf-8?B?VE9NN0JieWkzOVJ4UzZ0MUluUjVpKzZUbHVobEJ1V2tsdlJDYXkrN2NlcFBy?=
 =?utf-8?B?WEJvdDZCUEY4aDZHaEpyN3dsbDF6WmhLTGdtaHRzWWcwMi84VWZodlBsN2R2?=
 =?utf-8?B?bjNlZG5ObHpZZXVrVE1ub050Q3k5dXU0S2hRVEtJdjI4QURRd1JlMzNjT2h1?=
 =?utf-8?B?SmJ2Q1pmTElPcFdMMEc4Nm1MbkdvcUxXTzZROW9YbFRvQkdXSVVqbGdqT0xi?=
 =?utf-8?B?bXg4OEhmNzVFSTAwQ0hXMHpWTTNUd2hKcnl5TGxIcXVuWGVZWlppYm1NSlV1?=
 =?utf-8?B?WEVHd0Nac0FUS1lEL1Q1VmlUb0N1Vy9YLy9KWHdKZkRLZTJwakZLd3ZWRDJF?=
 =?utf-8?B?dE5lWkU4cmtGeWRVRzZvemFETDFrTjQzc25XV0VNd0RCS0JZZmFsN0ZMQnhE?=
 =?utf-8?B?QUxFYlp2bm1QY0M3ekoxdHhIR3RUTEIrSnNYdDNjWk1pakhmeXBkVHRrWnFE?=
 =?utf-8?B?TU84bURKZDJsM2x3NjNNRFd1VjA0QVRhaGFjZlNXbGl4WnczWlhTdkJUOGlQ?=
 =?utf-8?B?a1R5NkVWSEdJQmhaKzk2MmpteTdnaXhPMWRzaVU1ZUl4Snl1Z2JadWtnYnRC?=
 =?utf-8?B?R0poc21BbC93anROaENraG1QSkUrVDd6TE5LTVBQT0gzVHpQTk5xYTFKenZu?=
 =?utf-8?B?cWhjZEllTEFDV0FXRnhjYmVESmFZbmR5UGJET1NUNXl6ZW14akJUbnhzUE1q?=
 =?utf-8?B?ZndOWEFvR3VPUDh4UmIyVEV5UlNNazVraVF1Yi8vYStjWlhuV0IzU3lVMG04?=
 =?utf-8?B?TG9SQzV0TG1rNWxsQUdJdytaeDgyZDVGSE0rYU40Vm4wN1Q3R3IzSndRSWZR?=
 =?utf-8?B?QkNra1VtdHUxM1U5MU1vYWZ5cEhZZ1RLdkN0VXBhcUNOdFkzQldiUU5Ickpy?=
 =?utf-8?B?YXg3czRNMFpNQU5wNFQ5a1FMZmdaajNMczlMajlWVHdXWC8wSnRudkh4UFZ4?=
 =?utf-8?B?TzhMbEZsOWVwa056aC9hNWxvbERWbzlQTDBtSnNJenN1bUluaFF1RlRaRm5U?=
 =?utf-8?B?NktQaTVTcCsxeEJDOGRyZEdJTXFrZE5LcEY0V2VQVXhXUkhkWW1RVUpHUjJE?=
 =?utf-8?Q?FyXTcc4Mkhgh4k6pM7Gi1UIZb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874fd865-2116-4cdf-99c4-08dcd64a8712
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 12:24:36.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgqX8cBtjcs2pfzf9pwC2ou6cC7yV+mO/Q4i62JD/27V7ykmZtnbWCvzIIppE6oXscuiPj6LS9csUXiEf0wpxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995


On 9/13/24 18:32, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:21 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c             | 30 ++++++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.c |  6 ++++++
>>   include/linux/cxl/cxl.h            |  2 ++
>>   3 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index bf57f081ef8f..9afcdd643866 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1142,6 +1142,36 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
>>   
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>> +				&cxlds->capabilities);
>> +	if (!rc) {
> I'd be tempted to wrap these two up in a separate function called
> from here as the out of line good path is less than ideal from
> readability point of view.


OK. It makes sense.


>> +		rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +		if (rc)
>> +			return rc;
>> +	}
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map, &cxlds->capabilities);
>> +	if (rc)
>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>> +
>> +	if (cxlds->capabilities & BIT(CXL_CM_CAP_CAP_ID_RAS)) {
> If there are no component registers this isn't going to work yet this
> tries anyway?


Right. I should return if no component registers.

Thanks!


>> +		rc = cxl_map_component_regs(&cxlds->reg_map,
>> +					    &cxlds->regs.component,
>> +					    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +		if (rc)
>> +			dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>> +	}
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
>> +

