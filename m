Return-Path: <netdev+bounces-230907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2A1BF16C6
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835211886DCA
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805E32F8BCB;
	Mon, 20 Oct 2025 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rnFD6Utz"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8513F245033;
	Mon, 20 Oct 2025 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965482; cv=fail; b=YF1pgQ3XA6oyownyRwZcbf/fvmZ4VWrFNnMpE67yEd6CyIq0HTv7l6qB2ZQEYECNgIeAE/2Ot/hvMyppcIOmmKFWM1ZwYOD0+XusqAgBqIwLWbbu1CnVvenvhgfuq/GtEjF4vxpYfRRe7OJn0DdAi/Rruih2AFWgt+jH7iogDP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965482; c=relaxed/simple;
	bh=fcvdAAbYbQaONUc9lCHbJW8+z4ivnpI0XQ9JmILsbBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H+gG8+CRLBj1Z25x0pqZtKbEClxqpY+a7bYAfGtHe8Wl3Fr5fdm7SfW/Fj/bA3h1pU4gYtJsHhjgSXclc4/c0T4/3TIXH78gSQzrXf8d9jsiTm4RMreM3khBPgzTH9qFm2y8+WQVHPTdt0YvFPZmZsESJjteQT80j2AsQYZ47cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rnFD6Utz; arc=fail smtp.client-ip=52.101.193.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgNc7wNwB3DinWU9dtZpbltc4GA5Pcx6VWyrJfhcZJ64DJMwvKc2JIibRIjke5OsSOqe6bGsXmZ7KYQgToGHD8TFN+zjcDcf/e4CWkD0GknmzcRlrDcNUjuQ+7VATNw+epKeO/1dg/QVuBpPMpPKS5VC5RWN1yCQnoRZpts+NT16/4J8VxiQJuZavBd1zjgvYL6W2HxV3FSodP4y7sB3TmT8UYEs0S4Xtr92Afcy/p+78ggxdnofTqHAvjL1NWlOyKhv9Z0hgLpKTid/d8vZtuTO3S3lLDhhGOL+3NKbgOtBOWqfrlMKLnTbkfRyRaf1s5ZRyiH5pQy7s7EapxnsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ycNwEz/58Eb/+5Bw7xsAfpMUzm4dQbuLFw3w4vAE80=;
 b=b78P9JzXx0YmK9NLTVQsOWLRVFp1vJAVtCcDHtZSM+qutZuSZ/yhuY5e8Mkms10ndVwiq1VMXcQtHdUczdXbWtQn3aU5vxQUI2yUJj7lsSRuwDmMgw4zGSGrEY+/Od0ap7z1YSlX9nD71PjuqrPMsAgbzX0rJOV37vySgwolBcs0RlT5/qvw5NM8ahVxFq9ZujFZOXoKOaH69Cy8gkzubC3g0a2T+jh1lKamsNg6vhY7ArmLucsss+mhaPsRxUNoNx2Cn6ighc13S+uUWy/3EQ5p/kWiXsOjveszF5G1Uh50LZkcqOxO9+RZ0uVPsFChxgo157807xry0hAy/Lyqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ycNwEz/58Eb/+5Bw7xsAfpMUzm4dQbuLFw3w4vAE80=;
 b=rnFD6UtzB6cn2eO797vWswmPXg5xuQYHqrcvi6kOh4x5IdFKsdoAxEJFWfQx/VduBJsRrzWXHXN7YF/fJM3aQMUb0xgjpc5RL6tArJxRyxz3dXCnExotQEn+C3926YRtr+VvLzbMDneLL4SpjBdUHOPRzWAqXdeq86BxRNshu1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:04:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 13:04:36 +0000
Message-ID: <4ef3feb6-d925-4a88-938b-5cf8d252a1b7@amd.com>
Date: Mon, 20 Oct 2025 14:04:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
 <477bdadf-b249-4e45-a57f-fb323ca4c923@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <477bdadf-b249-4e45-a57f-fb323ca4c923@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 81985997-9db9-4524-11a7-08de0fd93850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTJQMlBDWTVwTzNsNHBaYTJNb2Q3MWNwcFBjVHl2aUtwQVRBckFoMWl5bitl?=
 =?utf-8?B?Z243UEUwczdWYlJjYlUwbVdyeHlsMXV2VkdmUnVtUDBMZkYvSUlsemNIZ2lq?=
 =?utf-8?B?Y2xSTmZvQ2NtLzhkd05aa3Y1bTdxYlJNRWlyTTcwMVI3ZFNRZTVkc1pFdk9E?=
 =?utf-8?B?VjRMcGUwbXF6NlZIZHNnQXc4a3dJMVZYOElTTUtiV2FrOURRZyszNXViQnpy?=
 =?utf-8?B?dzFQRVdCVWdxbGZqaC90NTRDb3dNV1o2VTNYQTkyWk0va0JvTkp2L2tKRmFt?=
 =?utf-8?B?bHlQa08zVDZtMXVLTHZIUlQ3dmRsZk5LRGl2YWYwRWJOYzNJTks1ZEdkaWxX?=
 =?utf-8?B?cVRNVnRqVXJIUHNLb2F0M0YrSjI3dUFvVkxLVHZ0Tk1KbHNWdTIwdW5SLzk1?=
 =?utf-8?B?TnJRQ0R0NUNOVDJ6QTJLQnQ3Sy9UcVRGQVQ3bVFRUHhOMzRNUXduOVhGa3gr?=
 =?utf-8?B?QWZiaDRubWRvYXgwRWZvT0RIQVc4dlpQVWdhLy94UzFHdkhVNWtORE01bzZ5?=
 =?utf-8?B?bVhHV1hFVFVYNkRVbnZWZFQ1RXRlcEx2d2lLd1dlL1JJL3JBU0lXV0Y3ampo?=
 =?utf-8?B?T3kxVlhvYmNpZ21yK2lPcUo0akFuMVJUM3UxOEVKY3RBa0hCeWdqL0tOZ2hk?=
 =?utf-8?B?S00rajJRTC9ML1ZhNUU4MnNVSnhJWFNkSzJrcnRwWmVFbUkvUzNsb0Zta015?=
 =?utf-8?B?NXFFRU4xN1pFTG5HK3VhcUFZZUlyWUkvaGNZcDdrN1J0czNsNEpFaml4Qnl2?=
 =?utf-8?B?Y21ZUEdBSTBvLzZ5cHJ6R25ub0d5SjRZdVMvUmpydS8vYURWTy9aZzlBVTUr?=
 =?utf-8?B?cHM1WFBrcTBTTFJzWlJka01IaktCcWgvR3hpY2lBUGZzL1E3Y1VwOVBXRzN6?=
 =?utf-8?B?T1pIUFMyVUN5YkcxNVpKOTB0QlVodkJ1MEs4VWhSUFFIT0cxSU1FWFhmUkQx?=
 =?utf-8?B?Z1VuWklmUXNBbGJzNklUUGk5QUIxNHNEdkpJUmtUM0xLZmkrNU1PQUVUZEM4?=
 =?utf-8?B?b0pENndGdm9FZHkrVGpZb1dESnA0RlZWeExGbC9pdVdqa0RFN0Z3SGpyM1Jq?=
 =?utf-8?B?NWtsajBHWGxyYkV3cmtNMDBad3krTnJFZGtaaEZ0WGE2dkZrZ1EvNWVBWjRW?=
 =?utf-8?B?YXRYY0R6NnVCc3FYRHh5RVV0ZFpEY09XdG1XWjNNbGFoUWtxUEpLZGZWbmdS?=
 =?utf-8?B?L0JNbU9QRG1ZMlUzbUpzK2VFQ0ZCcXhTQVd4QXZWN3NYcTNMa1ZUcm15dFY1?=
 =?utf-8?B?VDJLWTFMc0dtUzFKVnQrTUFwVlhTL1RFVGo0QnN3bTAzQkc2OVBSMjI1bUFB?=
 =?utf-8?B?MEJCNDdaVUJFRjU4NGZwSHpwZG5Qa0dWYWdOQnJIaDJRTDFYSk10N1BCQ2pG?=
 =?utf-8?B?Rk1EZmlYS1Vxby9KSkNJckFHVmgyVHdLUU5tZElVOHA2Q2orRHV2VVF4VUV6?=
 =?utf-8?B?Ym5VUmcyQlFjalVVWkY5NDRUZ0xHbUdBNFpHV3JRazh0WnRhU1d6VWRueTlU?=
 =?utf-8?B?YS9DZlFvSU92cVpGZ1pnbnJLVjhJenJaeGRWaHRMSXU1MjdlenI4NW9Edmky?=
 =?utf-8?B?VnYxQ2UxZ08wVXdxa3diUWs5dGN4Y281UEM2ejBnakwwRzUzSzNNbTZlS2Ux?=
 =?utf-8?B?eDR3cXhNbEVxb1kvWkhQTHVFMWdpdmRaRktGQytWTW13aStGZlRRYVY3ZWZD?=
 =?utf-8?B?RWVtSGxRYUxRQWZTMll2a1UzVHJoWmUwbjB5RWUzbjNwRVdZS0thYThLazlk?=
 =?utf-8?B?VVdhTS9FREo0dDR6QkZDNjVXYTRIc2RZbWRxYjFzUnhHMmg0bFppalIyc1pO?=
 =?utf-8?B?ZHFNVUptY1NlZ0hpeTdNd2w2RUZRVjA2S1Q1bFI2OHdzRGtZeEloeXgyU0JV?=
 =?utf-8?B?cnVVeWhvelNUeHdKWTVHSnJVMjdYSEtlaDZSMzUxTGNzQS8yQkRCRTRlRHda?=
 =?utf-8?B?cFhzdndZMkZRSHd6L1p1TFgrSkJxRG5EQU5LYzluY3lEU1FML3FLN2w3a3pa?=
 =?utf-8?B?aGpXenl5U1ljaGZaNUxSd2JlK0pYYjlGelNZNktqZGl5TzZ3cmRkdkJpZGFT?=
 =?utf-8?Q?c8R5/r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWo4c1JtdFF0ZEZPMnpzbzJHdXRrWGFjZk14d3NzSFhFdlk4NG9Bdkc5OENp?=
 =?utf-8?B?UzIrQmR5YXM4NzkrVUV1eVB5Y3pZZjREVGRFRjJZbHlNQmd3UnJEenRyQmxw?=
 =?utf-8?B?V0ZlSW9JcEliTlRyTlNiMjhDMHhUdHNYcjdUdlJxWC80b0J5UFE2YklTV3E3?=
 =?utf-8?B?aEtPUklBT0REUmJnVlRTSTFINEZ6b3BTUVZicUJsWnEvMnMrQTZDSi8yOWx4?=
 =?utf-8?B?NWh6aCsxRzV6SGxrbjl2LzQ1UytncWc1UWhhbGJjalBXUEJDYzQ1Sy9PZkt0?=
 =?utf-8?B?NHlEVnNGUldjTUg3Y0w4U0ZlamEvNWo3dVJYRUJqcHIzcjVkVzFiYzVzc2sv?=
 =?utf-8?B?T3h3RzVHZ1htSUpGd1lLWTgxRkN5TEZZcjVmbTc2aGxyQzhyUEtWaUZPYTdU?=
 =?utf-8?B?QTBERUJNME5KKzRyc3haUXI4VHl4K1k0ZGhCL1NPaFZ4SXROYy83bDhKZ25E?=
 =?utf-8?B?bndPVklmVGZSMEJYSC95QStUSXg5SzNBNlY3MHJTQVJ3STNCT1dlUEl4d1Z4?=
 =?utf-8?B?SVRGVlN6M0VkQmVlQm1SVjBodXJNdzBHNmY0dzczU3BZbEJteEl1MXliZklm?=
 =?utf-8?B?cndwclJyc05tZ0s3cjM2NnFkU0sxVUlVKzdRRk1panpIWk85VFBLekdDeGdU?=
 =?utf-8?B?ays2SXRjRFBkMU95bG52UVpkUXc5Q2ZsZnJWRTJMWDFsb2xFbnRxUHZraU5q?=
 =?utf-8?B?VDgwZThVaUtIYU9PanJ5RkU2Z2wxM3lSOGYwVHNzSVp4VWxxSGppSDFvQVlr?=
 =?utf-8?B?azN1SUNrdktjc0F0ZW5TTGZTQmN3bW1wZnNORnZCeElCYmZuSmUzSHd5RjU0?=
 =?utf-8?B?clN2dUZ1WUUzTDhXZFdOTXdGODlpKzdTYnFibldLKzFMc1REN1BFWXB1cGY5?=
 =?utf-8?B?ZFFTY3BabFJ5RUpDNXYxT2xpZHRPTC9zQlZuWHJaRkJXeWZ0bEYrVzdUQTNI?=
 =?utf-8?B?WFIzbk4yYVpvd0FMTFRNUHFSS2kxS2JIQlcvSEpTb0NJaWVCVUgwSGtpUE9S?=
 =?utf-8?B?UmVkRDNha3J5YzJQcFcrQjFCdWdZcnBXVWhTbm9qeHpoaVNiWWxENm9KVE5Y?=
 =?utf-8?B?bFkyM3liaW9lUk5QZTNrRmVRVURDVms4M2gzTmZiamZVeUg3bFNXOVB0SkFB?=
 =?utf-8?B?NE0wVW9neG0wckloQzNzVDl4VHBQMHpuNU1mVmVrQUhsdURpUkhVNUhiVERI?=
 =?utf-8?B?eE5BZ2tNWmhxbnBLRGVZZlBhR3ZhNVNDa3JtQ0FZbWdHQVdGQTFhUFB3eWR2?=
 =?utf-8?B?NHRCcjZ4UHpCOGJBM2hqaVUzWUhNUUFWdGhBTmlSL3JqdUJ5S2cycFVFUmpP?=
 =?utf-8?B?V3REQzZZcFVIZ3owUmd2SHcyNndOZ2V5Nms0d2Y3UFhmOVAzS3d0OFJ0SHhh?=
 =?utf-8?B?anZTV0xEMDBsc2x3alFMb2gyd09UQWV2dm9VZE0zMGNmZjNPUkw4SnY1ck1i?=
 =?utf-8?B?S0ZQMTJWSXBrWHRZVTN3ZjhmUmwvVlpBZ1dCMzdFazFWK09ZZVRXOXRwR3ZG?=
 =?utf-8?B?eG0xM01uNSsyM1dYL21KUDZnNU1ZVmMwZitLMVBmSDdXZFUvUm8zYW9uNFVp?=
 =?utf-8?B?YkQvekErUDR5S3FzWGMrbmFCZml4cHM1bHdyMmo4eloxdG91aGJwL2VhbTNE?=
 =?utf-8?B?U3ZSRkJSczQ4MlJqdFZXZFlFM24xUXl5aGdON3FLV3FjUzlQMFdWdkJjQ1Ri?=
 =?utf-8?B?dENMeFMwcXUyV1RoK0Y4ZWFMQy9hcTVkbExYZkQyWG1ZMDV5YVJsd21ZUmx0?=
 =?utf-8?B?M2M3RXdkY1VnVkdES0JYdndzc0ZhdFlmL3AzdDN1L0hhYUVHQjlUOGhzTHds?=
 =?utf-8?B?dmIyWTZwUkpOTmVhaE1yL0NIVHVCcXRycHd2Vy9tS3dkSWphY1BCcm9mQStO?=
 =?utf-8?B?aEh1TW1UODZrS3FhKzlFbCtJSFlYYUR3N1JIRVVDUWRyODVpOGtLOGZSUk5p?=
 =?utf-8?B?U3JWZHE1YW5nRitBclRaNS9TdFFXNEtHTmNtUlZQc2pLVU5RbWVXTE9nSlRN?=
 =?utf-8?B?ZmtqWncxaHZQY2pTclNxMmRQRzdMV0tUNXZ1VEVhQXdWY1BhcThzNjRSSVlo?=
 =?utf-8?B?ZWFUREVzb2Z4RHk3Q0V0NG1oc1RMa1FhKytyTm1lQnoyQStuSlUzMmsxL1Mz?=
 =?utf-8?Q?XX1mi8PHvQZio2btVRO6okuRp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81985997-9db9-4524-11a7-08de0fd93850
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:04:36.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2i9Nyi3tmNaTpNskqFYCH9TQAfsfO8UFRR8p1Z3Se2TrO7nOuskxWCYDdW2cZ9C2rSeDpIu5BANCb4+eVlEuXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919


On 10/15/25 22:36, Dave Jiang wrote:
>
> On 10/6/25 3:01 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Support an action by the type2 driver to be linked to the created region
>> for unwinding the resources allocated properly.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/core.h   |   5 --
>>   drivers/cxl/core/region.c | 134 +++++++++++++++++++++++++++++++++++---
>>   drivers/cxl/port.c        |   5 +-
>>   include/cxl/cxl.h         |  11 ++++
>>   4 files changed, 141 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index c4dddbec5d6e..83abaca9f418 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -14,11 +14,6 @@ extern const struct device_type cxl_pmu_type;
>>   
>>   extern struct attribute_group cxl_base_attribute_group;
>>   
>> -enum cxl_detach_mode {
>> -	DETACH_ONLY,
>> -	DETACH_INVALIDATE,
>> -};
>> -
>>   #ifdef CONFIG_CXL_REGION
>>   extern struct device_attribute dev_attr_create_pmem_region;
>>   extern struct device_attribute dev_attr_create_ram_region;
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 26dfc15e57cd..e3b6d85cd43e 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2375,6 +2375,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>>   	}
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
>>   
>>   static int __attach_target(struct cxl_region *cxlr,
>>   			   struct cxl_endpoint_decoder *cxled, int pos,
>> @@ -2860,6 +2861,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>   	return to_cxl_region(region_dev);
>>   }
>>   
>> +static void drop_region(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +
>> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +}
>> +
>>   static ssize_t delete_region_store(struct device *dev,
>>   				   struct device_attribute *attr,
>>   				   const char *buf, size_t len)
>> @@ -3588,14 +3597,12 @@ static int __construct_region(struct cxl_region *cxlr,
>>   	return 0;
>>   }
>>   
>> -/* Establish an empty region covering the given HPA range */
>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> -					   struct cxl_endpoint_decoder *cxled)
>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>> +						 struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> -	int rc, part = READ_ONCE(cxled->part);
>> +	int part = READ_ONCE(cxled->part);
>>   	struct cxl_region *cxlr;
>>   
>>   	do {
>> @@ -3604,13 +3611,24 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   				       cxled->cxld.target_type);
>>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>   
>> -	if (IS_ERR(cxlr)) {
>> +	if (IS_ERR(cxlr))
>>   		dev_err(cxlmd->dev.parent,
>>   			"%s:%s: %s failed assign region: %ld\n",
>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__, PTR_ERR(cxlr));
>> -		return cxlr;
>> -	}
>> +
>> +	return cxlr;
>> +}
>> +
>> +/* Establish an empty region covering the given HPA range */
>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> +					   struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +	struct cxl_region *cxlr;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
> Need to check the returned cxlr.


Hi Dave,


Yes, with the refactoring this was mistakenly dropped. I does not help 
this is the codepath not user by Type2 ...


I'll add the check.


Thank you


> DJ
>
>>   
>>   	rc = __construct_region(cxlr, cxlrd, cxled);
>>   	if (rc) {
>> @@ -3621,6 +3639,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	return cxlr;
>>   }
>>   
>> +DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))
>> +
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder **cxled, int ways)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
>> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> +	struct cxl_region_params *p;
>> +	resource_size_t size = 0;
>> +	int rc, i;
>> +
>> +	struct cxl_region *cxlr __free(cxl_region_drop) =
>> +		construct_region_begin(cxlrd, cxled[0]);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	guard(rwsem_write)(&cxl_rwsem.region);
>> +
>> +	/*
>> +	 * Sanity check. This should not happen with an accel driver handling
>> +	 * the region creation.
>> +	 */
>> +	p = &cxlr->params;
>> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>> +		dev_err(cxlmd->dev.parent,
>> +			"%s:%s: %s  unexpected region state\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
>> +			__func__);
>> +		return ERR_PTR(-EBUSY);
>> +	}
>> +
>> +	rc = set_interleave_ways(cxlr, ways);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>> +		for (i = 0; i < ways; i++) {
>> +			if (!cxled[i]->dpa_res)
>> +				break;
>> +			size += resource_size(cxled[i]->dpa_res);
>> +		}
>> +		if (i < ways)
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		rc = alloc_hpa(cxlr, size);
>> +		if (rc)
>> +			return ERR_PTR(rc);
>> +
>> +		for (i = 0; i < ways; i++) {
>> +			rc = cxl_region_attach(cxlr, cxled[i], 0);
>> +			if (rc)
>> +				return ERR_PTR(rc);
>> +		}
>> +	}
>> +
>> +	rc = cxl_region_decode_commit(cxlr);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	p->state = CXL_CONFIG_COMMIT;
>> +
>> +	return no_free_ptr(cxlr);
>> +}
>> +
>> +/**
>> + * cxl_create_region - Establish a region given an endpoint decoder
>> + * @cxlrd: root decoder to allocate HPA
>> + * @cxled: endpoint decoders with reserved DPA capacity
>> + * @ways: interleave ways required
>> + *
>> + * Returns a fully formed region in the commit state and attached to the
>> + * cxl_region driver.
>> + */
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder **cxled,
>> +				     int ways)
>> +{
>> +	struct cxl_region *cxlr;
>> +
>> +	mutex_lock(&cxlrd->range_lock);
>> +	cxlr = __construct_new_region(cxlrd, cxled, ways);
>> +	mutex_unlock(&cxlrd->range_lock);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	if (device_attach(&cxlr->dev) <= 0) {
>> +		dev_err(&cxlr->dev, "failed to create region\n");
>> +		drop_region(cxlr);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	return cxlr;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
>> +
>>   static struct cxl_region *
>>   cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>>   {
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 83f5a09839ab..e6c0bd0fc9f9 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -35,6 +35,7 @@ static void schedule_detach(void *cxlmd)
>>   static int discover_region(struct device *dev, void *unused)
>>   {
>>   	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_memdev *cxlmd;
>>   	int rc;
>>   
>>   	if (!is_endpoint_decoder(dev))
>> @@ -44,7 +45,9 @@ static int discover_region(struct device *dev, void *unused)
>>   	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
>>   		return 0;
>>   
>> -	if (cxled->state != CXL_DECODER_STATE_AUTO)
>> +	cxlmd = cxled_to_memdev(cxled);
>> +	if (cxled->state != CXL_DECODER_STATE_AUTO ||
>> +	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
>>   		return 0;
>>   
>>   	/*
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 1cbe53ad0416..c6fd8fbd36c4 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -275,4 +275,15 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>   					     enum cxl_partition_mode mode,
>>   					     resource_size_t alloc);
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder **cxled,
>> +				     int ways);
>> +enum cxl_detach_mode {
>> +	DETACH_ONLY,
>> +	DETACH_INVALIDATE,
>> +};
>> +
>> +int cxl_decoder_detach(struct cxl_region *cxlr,
>> +		       struct cxl_endpoint_decoder *cxled, int pos,
>> +		       enum cxl_detach_mode mode);
>>   #endif /* __CXL_CXL_H__ */
>

