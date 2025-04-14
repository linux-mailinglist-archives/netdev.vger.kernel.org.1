Return-Path: <netdev+bounces-182197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA0FA8817D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1BD3B8AFD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F22D3A7B;
	Mon, 14 Apr 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cCimE9+k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9DF2853EB;
	Mon, 14 Apr 2025 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636503; cv=fail; b=oasQ2uW0O4x2dDsfcVw7szdqaliApW1Km8LPMypXbrr9b3jHS5z76CJZx1c1fKPH+A2jdWBQbYghknoA9MM1aBOuHYf15Z746CcR/A0dY+5Gq6b3PON+n79LhSrWIgUXp+5IoRAGJPxJgubPdvl/aOWo8j1q/l5Gz4OmywJUBwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636503; c=relaxed/simple;
	bh=czd2o24anLe/H/1rzvgep6DiO7vGclNO3EmnToNoxhQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lG80Tg3sccDTuNxygCTjgpw+nkgzg1oBOeSug5r8zU7rbFb5q6Op7e/zseLGRubf/g6w/VyjMyaYm86zvjrdI23Lf+ln/Oxdhb6A5u746EjrdgM8WNMTRPSxjw1X0nmjBdksQPiEfyShfj0jq2lt8sdxUxnz/1h60fF2b5OJdfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cCimE9+k; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfoTXW+8ZQpB7qkXLzX8PxcDgskumh4BxJ275H8qvq3lbpHd6aI4aseiH2jgGVD9Q39eIEBT5UfrloaLx7zYs3Q9+4Ba/H43pDFpyYxoVArHn7F2n3TUvEo0jGjFMrdPFwLAHudtNUc0MPZKTi2ry/iF+WQIvCMUwYZqU5IN9DBp3EgZZYT9scKOUQq2GjrEVGshp35KZT3Ex4HZ8CO9p9gNjIsbgA0UbvwbBj0c456n/F7MmZY/V6BW3laT4NULe5huDeTwX1FMOsUFYGsYT/oSE1m2nMNQqn6G5zlEYzVtM879K7+NkPWJY9jfaY+iBsPaktgnrJB8WOnHCxDetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbmAXxQaSjOLhpzEKi2ciOFv/tHgB8oXQ66FKt36Q5c=;
 b=zOP/PYc+N0rDQK8JvHr5rO5oZcMrFrGNgLaG3Rxe21CMpUZSsdSvrONkGbjLrkNaZsO5CZt9tGn1p/ZUHS895nQHSiQdyJdUfTvvPcuumV5XnpuL6HJf7bTSw43CXmqwzD7A5WzHqNcT2NGQlFjRSdnY3CXWlSqyzj/12CNicWqN69zacDpyhkXZX6/6vuvLsWfCvINp2S5mDU9nYDDkgI3PZtzslSLWZni9ItzhEW/+yr9zUXodRRdNixH1dlfPS3R3RAkfRFJtdNxFrn145noAcW56LnqTfU6Bbjgfi96NY4aDx3swvwzDb+czvRmND/G797I0GSe6McErQ/2s7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbmAXxQaSjOLhpzEKi2ciOFv/tHgB8oXQ66FKt36Q5c=;
 b=cCimE9+ke3RSN5i+YDjXuwR9udD7+zS0u8vj4TYzr8IxLOqGPuvp1VYLB76OdR3e1sMmymB+xU6sF+Dt5bfAJc/rHup+VrNK7gLH4K0Q+L0/FumJudj8gd8w3IBGjtlJ7IqlDh0uHeA/pH9kaQoMGGIYDzDzwG9jQUBvizTlKls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 13:14:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 13:14:53 +0000
Message-ID: <1989d6b4-905c-4784-ba68-5a0e97ecaeab@amd.com>
Date: Mon, 14 Apr 2025 14:14:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/23] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-12-alejandro.lucero-palau@amd.com>
 <8b954086-a896-4787-aa0b-cdf796e6d3bc@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <8b954086-a896-4787-aa0b-cdf796e6d3bc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0224.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cac266-8fbd-42a0-f16a-08dd7b565804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEZMSXF5eXdGQVhxWmM3Qk83Q25IZVFNVVdJNTR6N3dlWnRBWWJRZE84eStn?=
 =?utf-8?B?WEd2djJrZm16VlFiTWhCVHlmeVhDd1pvREZQNitlV1dWUnpJdlA3Rm9hSVUr?=
 =?utf-8?B?bW11OUxvNUIyb0dzQTZjdzdqQm41OFB1dzRmRjkvbTh2b3Y2RXlzYjRjM2lR?=
 =?utf-8?B?WGZ3OFdpaUgxRXJwS1BFR1pMR3Y5MDBKMzFHK2d1S0J3MG5xUTc4bStKYWR2?=
 =?utf-8?B?dG84N2JtMDFidUUwaUQ5cFhoTC84QWZuNUJxRGVjeEJkdUJ3S2N4V0UvZnhz?=
 =?utf-8?B?QlZrVlB1cTVGMlRqb2JIZmQ2alN5YnpFbHl3R0NGbkpUd2JaT1FvRW16S3NG?=
 =?utf-8?B?VlBiYXZGdmdYS0lmeFpyKzJ1c1J3NmNGN1R5a3c0ZHVaRFBqVVMyZWhkYzM2?=
 =?utf-8?B?azYxL3NVbjM4Zk4rUmZTK0Y4TWE2SlRqeFg5Nm5qdmVWbzhJMTE3cWdBQWw4?=
 =?utf-8?B?TDJrVFZFNjhIa0RnNG12UDN5THFIRVh6QzBFdzVaRC92SEVpbmRabWZyM0Vo?=
 =?utf-8?B?SHZVUkJZRUw3Sm1yZDRscngxdW4vTUVzeTZEbkpBeDRGblo0OHZ3WHlMc2RN?=
 =?utf-8?B?cjhYcmJic3JJVEdzOUxTRHRyU3pLak5KM1NwdHNUSkZRM0NQSTV5K3pOaFo2?=
 =?utf-8?B?WFZTOHBpdE1iUjVSZTRzMStGbTVjbytIYWZqQklLVzNDUFpmS1Qvd09iV2Ux?=
 =?utf-8?B?QllaeEh5bG1nTUlnVExsUld4VC9BeWtHT2VoTk0rb0QybWIwaDk3QzZaZm1v?=
 =?utf-8?B?WjUrd3o0aG50M1Mycy9UeWIzdHdyTDZEOEFwS29Xc012MENtZjg1djl5SkhY?=
 =?utf-8?B?OC95LzhpdE9VbmVoSWY5RUhCVW04cnhuemVqRDFMc2xiUUhNaW5MRk1RV3Q3?=
 =?utf-8?B?d3I2Mmt1Ukt6TEFiSUhVVkZLcUNMVkxZRkROZGdGTWY1S0UyMDdMdEtzUVBI?=
 =?utf-8?B?eWpBUnAvRnpiWjNtcWJRc1ptUGROdnRpd29HWUhQT1k5T3BHakJxbGZIU2ZN?=
 =?utf-8?B?OXNrWlZYNjdNaWJWR0VVamUwMXo3QmNGN1lUelFXRkt2Q1NFRlZMTzRLSldM?=
 =?utf-8?B?QXhId3VlSHBnbWI2aXFjSGtTNkF2d1oreWV5RnBHQWtabVpBeGNuM2hWOWFO?=
 =?utf-8?B?Wmt3WkVUR0g3OTNrYS9nL1pnSE93R0ppU2djRlg0T3M2b3FaZ2drY0VGNFd3?=
 =?utf-8?B?Ylp6V3cxTVR0U0VKYnJTc2FHRE1sSkd0RDd0MkJoODhXekkxVGpTRVU1R09v?=
 =?utf-8?B?OHdLYmFnc1RQTFl0MitNMTN1K0dpQ3hubCtFVnA1RnF0MEtiOG4rOUU5M2ty?=
 =?utf-8?B?a2hOZjJvLy9nOVJHc3JNOGNwTGVzYVI5TWgvYUF4bUpmU1l2YldSY0Y2bGg0?=
 =?utf-8?B?NkxMelFYYlR3V1dYQmRPUENadG1jclhtSnVFMDVxS0NacFRnNmhYeW9QNmFz?=
 =?utf-8?B?TDBtVWpDdk00QW04MVJSR1pTNGovaUZ6elorSzdCd24xdFMraFlqY1lGWG52?=
 =?utf-8?B?WjNmTWp0TkZ0b3h2dWQrazVPU0UzckdOYkhQWDhscVlDZzJMdFVMRE5WVGVv?=
 =?utf-8?B?ZXE1RGZMeGx4VHdMckgzeFJkQzBKSXFUMC82dElzckFVSHRYV0UzKytFdGhr?=
 =?utf-8?B?dVpBYzJjK1ZEbWdkV3RzZmJNemlUNVRTK0Nldk40R2xrVlVYK2Zxb0tkZ0Z4?=
 =?utf-8?B?L09pcW15YmR1eFF0bCtnM1RwQmszYTU2ZC9LQkhXTFlTdng5cWNMa3Y3NS9I?=
 =?utf-8?B?cWxROE1NK0xFelExM0REcFVPdVRnc1dLNGZCZzBGUGVLRW10UkhZY3pFU21a?=
 =?utf-8?B?Z0RkRCtyUStydHovUnNlOEcwbGZKbkVWQzYrR2c4bTg1YVk3cVAyM1VhdGxa?=
 =?utf-8?B?ZzI1aFFnNGRlOS9RR3JOdzlrNFlROGZyeHk4Q3BMZEFNQzJnb0FkZy9nT2dD?=
 =?utf-8?B?cC9rSHdRa3RaUkxYR0NWNENHc3VwMWY3ZU5jN29zblhzdkNWYWpmU1lUWk8r?=
 =?utf-8?B?T2NhdllDRVJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTJHVTVBYVh6b0UyWGc2VGdBNlNIR2toU1B0T0ptckxtVkRLNldlL2RETjZY?=
 =?utf-8?B?bHVLWUxVcjZ6WncxMkc0SjRuQkRiU1hRVnIyTVNxWHVvWlZiM0tXalpnTjRW?=
 =?utf-8?B?ZDVXR0lHcVVZT1RabUozNVVjb29rN3BMeFkwbVpINktZTkNmOGV6Z3JZdjhL?=
 =?utf-8?B?RjNhc1UzT0E1VzRoM3ViREJQS0d4MERHTjZWM3pSb1JTTHJ1cFdZd1k5ZzU2?=
 =?utf-8?B?Q1dLRDlVZnBWc3lDV0pIeVJOVS9ocTlEaWRFb3lkUmhwOExkcFNlcThKZjdZ?=
 =?utf-8?B?TWUwdXBMTnVHTE1GTmczR0IrYnVoUzh3cTBwTDJwZHcrRnFLZFhkdWoySEJl?=
 =?utf-8?B?cWVpdDJVUW9RSHFkb2YwT0I3ajVGSjFZUENZNGFOdDM1YmFpNGJkckZBcHdG?=
 =?utf-8?B?SVVUZ3hvSFQwZjFsRjJTMXZ1dHhHdUVNcjJEMHI3M2s4NWk2ZG02OTdyL2E3?=
 =?utf-8?B?QTJ5QVB2RmFqcS80c2Y2ZjllYjk4OHdnZDNXTUNuczl4dEkzQytVNVU2K29M?=
 =?utf-8?B?SlRYK2pjejFoQlpESGFjdkYySUZaUzZhMjBjaVZwanQ0VHVMM0lVcWduTnB0?=
 =?utf-8?B?aGJDWTNpc1V0bThNUllTVkhwTCtWLzRYbDlHeTVUUTRjM243NXhKSXcyOFVr?=
 =?utf-8?B?c0hweStxSnhoUHNBOCtLdytQLzZmR3RHK1ZsVmdWQ3pjK01hSmRvUHZjQXJG?=
 =?utf-8?B?WGFtL1pqSHAwS000L3ZPeC9hTFZyWnZyVlhlUVprVGFvdEY4SWwzRWtFUmR4?=
 =?utf-8?B?dWpyRkozWXNjNUM5YzdCTC92WlQ4aTNDejN1ZWpVWFZXaVo3UXZ2V0NJZG5C?=
 =?utf-8?B?SUViajRyNjFQTmRlWU4xalNwNy9uS2Vsa1MrN2x0MjI2UGNXd1lLSk8wRkJu?=
 =?utf-8?B?ZjlEakJxM0wrTDlVZ0VYcDM3eW5DbGYvWDY3TjBCaVdvNXl5VmVNMytvb0oz?=
 =?utf-8?B?dVpPcXB1WGdMY0FJZVorVmNnYklxQkhOdy9VS2tMMHdaYzFXbExleS9wb2NJ?=
 =?utf-8?B?VmhGNDlRQjRIdWRQcVNzczNCR3RnVVFxb2lxTjNmRURqQnVXYmN3cHIrVGhO?=
 =?utf-8?B?YjY4N3pMYzlnd1Z0VmhrbmRDaXRPdFVHdTQ3dUwxcXNsN2l1WEFyR3J4SnlC?=
 =?utf-8?B?dDVLeXQyVGNhSXh0c25lblhLdUdsdXdWNUdqWi9sdUl6SzFYZ3crVkhhR0Y4?=
 =?utf-8?B?VEtuSDdPNHFiRlpFb1drektieC8yVDBPVG1DWUZKZUxjb2lIT2VhSjhhd1dk?=
 =?utf-8?B?T1laajNDV0tXMFRHcFRKVlN4a0pvQUcxYndnWmZNTDJzaHJaYmVIV1pLQWpC?=
 =?utf-8?B?L0pWeHJrRkgyNDdtTTZQVEFockdjZGFhME9ZdmlvUTFKb3ZMeUd3K3IxSERk?=
 =?utf-8?B?MS9CcVQ5QUdFbGkyRnFNQkxOSXZWTXpIUDN1Q1ZkYnprcEorcDdwdlhBdXhZ?=
 =?utf-8?B?SXZacmNGK1k1MERSa2d1T1krcWNSNWg5VUx2NjF3dURsb21rRVZkUVFDcy9m?=
 =?utf-8?B?amNiUDNTdXJPR1JQQ1crblp0czFnWWRKNEZJSng4ZG1sRnMwWGVzZ1hUNkx1?=
 =?utf-8?B?Y1p5L1FvQTM4TmtMVCszTzZkM2V3bzV5c0grWEpZRjd6UjVYWFliSlZYRWtk?=
 =?utf-8?B?MklydVpOandnZVl3bVFLUmdIbUJKeEZZMGRPb2haNFo3LzNTTFZpM3d0cjVR?=
 =?utf-8?B?azd3L1AxYS9QWHFYc2t4Z0ZSS3RCN25ubzVvWldXS2VSSUpnWnBoY0YvMk1x?=
 =?utf-8?B?Y1RhQ2FWclJ5akpFYStqamtpN2MwVHlwdkR4d0UxY25LQVM2OWFWQjdqTmdG?=
 =?utf-8?B?UTFuUHlpRSs3QjVhL3h0cG9WTXA4OHdsM3Y2UGFndHV3UU5DalA4OWpQb2Y5?=
 =?utf-8?B?T2FoQUY5ZHB2alBrMGliUytmazB6cktnMVl0T1kzK1hiV0txZ0Ixc3JHN3RS?=
 =?utf-8?B?aW1TS1c3KzYzeXMwM1ljZDdMSjJFYzZkL2o5Zm5NR2tpMGgwa0E5ZGU0NzlY?=
 =?utf-8?B?TUg3U09paUkvMEdjd1VmUVFmS25XK0hUNFQ3QlBzL3RpNUxTdUhUQVdXRXV0?=
 =?utf-8?B?VU1FTTVQZVBLaXBiV2dwaFVpc25FWGFDNmxQN2JRM01IWTdENk9pcVNzbUdF?=
 =?utf-8?Q?qzuxfGigDkMUAqDp1t19R3yNn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cac266-8fbd-42a0-f16a-08dd7b565804
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:53.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5oNSGqRxsRjXQWeNH73mcKDEyxW7LIsIpYRCHJKAnDo+518NaStXDkuNMJLT/xufwxiz2nka0slZ+s3ZGF2kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029


On 4/11/25 22:30, Dave Jiang wrote:
>
> On 3/31/25 7:45 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>>
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	down_read(&cxl_region_rwsem);
>> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);> +	up_read(&cxl_region_rwsem);
> Since we are moving new code to guard(),
>
> scoped_guard(rwsem_read, &cxl_region_rwsem)
> 	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>
> DJ


I'll do.

Thanks


