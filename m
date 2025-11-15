Return-Path: <netdev+bounces-238844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00934C60177
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 09:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D3FE4E2C77
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 08:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDBC23FC5A;
	Sat, 15 Nov 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gjEsXgZO"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF41862A;
	Sat, 15 Nov 2025 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763194273; cv=fail; b=V0s/qxh/OGn7iv6qT6SobWLuAK7sm3fg6MFCIXY00uQi7roCGC4AEjqaAoH9+FQlPadlKteDOmheChj9nf+V+NvXK5i1RsVu8rOq7bSh2k28IsAKpS7tQvx34DcLlgch4a9vCJfQY/aOuMR4ngqVTeSWmYI4PLxgEjTyvcYTxiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763194273; c=relaxed/simple;
	bh=i3mAx7CThmdlD/lSZUTxJKdcYAih/6gIVUByYj+Shhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/L13ngSH+umCriOoK1u/pnMLHy36uvZMQBxc9JUnshUjlBslXlKbkyAg+R4+zA16jtK3cdAcFI36hO7wmdnfT3jcYwKnmGsfL9IthZHe7H7iku+fgistQdeqcsL95i92Oy5yeeY2P2NJrSTtGFvVN8GHey0mdsUXb4IjOy0dgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gjEsXgZO; arc=fail smtp.client-ip=40.93.196.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEafJXYrt7LpmRbJ4P2PSyZ1gdtHZou8d86Ub2pzpaUhdC8l9FVAtFfj7AfJdlC18YbmllOqWJcg6F6Vamm6fdLtCHYZOlJU3TxFeSDFET4+IaA/8Q93RL2n0GlnD15ow66UwKDLw+c3fL5BmAZXtmT8+heyWPf4gifL+KyM33vlI+R0GeGfeyDK2nD83OF+ErhdImuXeg2CV1R0uFtA/4SsjVPs4yyMpCz1I0tgc41keXCiE014zJHuGvlDPwXxrMUTTJGjWSVw9AqGl0s44G61Q8ehTzAQqoMEJHw+iM68CyqOzWE7RSHvVf2nVXmORjnHn4YUToJ6Hsi+0MjHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dlCoQOv5vS3VbalWK0hA2CZI1+qe6loZN+wSNTBnG8=;
 b=q39QlQv8RD3Ex1TeTPRGIyIxhYjohJPjQB6WDmRGhNgKZ0OE1TP0Wys+3RQHu7MOytHh8FXPEUx9Kr77C4heCmo9kmCAtX0qUBd3vNQsOn4QX5ts1cjy/8xM8RMckrASoS38Fm2SDBl50iLNSOswWifLBGPdJXcJxzOGcosYc/LcKmXp+ax4Tad9yLcLI+84A0Lp++OZ+MB8bOGSJJaThh3Arkt4SmLGeSUbWw8hbROHov1o6NpcyG0iIF+83xOQqraqR4nYswEqjusD53/cI8Acq7ASp7Nnvczrz8UIWJpkxcutTvlQAcxRLgbSlEEQMFTwnHbvALp02PmTlHhX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dlCoQOv5vS3VbalWK0hA2CZI1+qe6loZN+wSNTBnG8=;
 b=gjEsXgZOc12iKW029wqJWDgclhygXOZ0WZJ+pJRqtOfTYINXvUgwwqB4haMDhw75dHNCt7zGkicIO7QGZFdphJRqlTAkSEkLPIWViTHMUPwqwfAl06eY37p0X9uViiG7cQnRYX9pZB/kAD5FRhCUmf2llr7CgmwL5et6Cztilos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 15 Nov
 2025 08:11:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 08:11:06 +0000
Message-ID: <92642b5f-6b74-43b4-994b-909f90bc4e79@amd.com>
Date: Sat, 15 Nov 2025 08:11:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 04/22] cxl: Add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Alison Schofield <alison.schofield@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-5-alejandro.lucero-palau@amd.com>
 <20251112153334.00000ea2@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251112153334.00000ea2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0609.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: bc12ce35-423f-4c37-375a-08de241e86c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjZmZFc2TUU5Z1dXTDFmVTlpSzgxVk9UeUxPTldRRDlxN1VhcUpkR0tYMTBK?=
 =?utf-8?B?MDVSNlJZNVN1VGxmYUlOUzJobzNGd3g1K3RHTnd1VmJja1JVSHdxZDRNMldP?=
 =?utf-8?B?aHVYaUkreWd2YkZXNFNSMmdTUHBIZC9Mam9VQ0p6cTdpMFJqWlNlNng4dTNC?=
 =?utf-8?B?b1ladXE0MXAwOGNUV3kxOFJWOHBmb08xMDhOV0s5VXVKRmRoWk92Y3FZNWRO?=
 =?utf-8?B?UXNCbFNIdE54NTBaOVJJV0VEU0dXOEJsUXZyMHJvOGpMajRWWjA2VlRjemtr?=
 =?utf-8?B?S2dXekFoUmZsMmU1aG9GcmJKT2p0ZWFwUEtnc2c5OTYweXg2ZXhmdkJzRCtI?=
 =?utf-8?B?Nm1EZHdnOCtJYXQ2emtOOVNjQ2U0c3pER0xTMUkvS0hpQU1pa1NlRUg3WVEx?=
 =?utf-8?B?K3NLREtCKzFDN1ZUOG0zTEFtWVBXbkVlMFp5bkovRTdCN045MS9zYWxUOEJV?=
 =?utf-8?B?QTFMMGZmVUlvaEdWZDgrSEhmanJwRldBN3h6TjFqOE5ZdXQvWTFSVkt0RjdJ?=
 =?utf-8?B?d2p5cmxWUDhSdGp2YUw1SG1ZNVhGQnlUMmV2NUg1OE13UHBKSjV0LzNzTWRi?=
 =?utf-8?B?enJnQVkzY1FFZ1YwR3RZQnlxb0hjSHdHZHgwQWo1OEpCWmdDTEFjKzZXY0Y5?=
 =?utf-8?B?bjBaUjdBeEoxKzJhMVJGdWp6M0VOMzM1MXJkOFkwMm9uUWVjNDgyYVBnSFNN?=
 =?utf-8?B?bjc5UWtRL1lVeU1WMyszL2g1dml4Z29TWlpMWFovVXpEMk9uOGhTSHdLTytJ?=
 =?utf-8?B?dVFMU0JrL01iQXhSRG5BRENHc0dJTDJ6N0JNQ3g0MUtqeEdLRkFmaVBqWTNu?=
 =?utf-8?B?VVhRbWtkb0hZR3NMLzNKVTdKMGpOajRNaDVrRElKcTNGVDdzNzNoVGlFS0M0?=
 =?utf-8?B?THY5OGFHTW9FMzBlZlAyekhxYzdxd3IyQXMybm9tQWYrU1BnN0dMV296dVZa?=
 =?utf-8?B?SE1uWHE0b2RKODBXZ21zb2JzOFk5dnpsTk1YNGR4akI2b1VqZElxeHJxdzQx?=
 =?utf-8?B?clI4MkdBVHdtMllETDRRZFdvWFQ0L2E1SGVyR2VNVEVudVpKaVFmZkVzTTNm?=
 =?utf-8?B?ZDZ0NFNHQjdVYkxZUGFWSndhakNCZGpJaWFxSFNWUlFndUtBd3Z4NjFPU204?=
 =?utf-8?B?WDlEM1NCQWlidmVMckJJU1pBR1Z6UXFWbVMrNnBmNEI2TmhtWnRoeFpzaWI3?=
 =?utf-8?B?OVd3QmFtZTU4UUZ2Z3A2K1RUcTY0UldZV0hvcGljdngxMTYrM09SRnVqdXZ4?=
 =?utf-8?B?L1dkci9tRlA2eWtyd2ZUaWpPK1E1RG16S1hoKzRVbEFnU1pzeVdhYXI5US9j?=
 =?utf-8?B?bHBBbFhCT0N3NExCTkxsd3k1OURLNldyN3ZBR3I2Sm1uZUpVR1Zwd2V4TzBI?=
 =?utf-8?B?M2M1SUY0SHlvcDV3RlRJMHlkbzJ5d3k5SWtjSXVEODVEQ1NwNlVtVlZ5OHh1?=
 =?utf-8?B?RGxuWkdwc0J4TTZZSGhiV3JLbWR5QUVvWTRMcVpSZU5qUXJ0YysvM2dPTk1o?=
 =?utf-8?B?eUZvMXg2UU5yV3ZJTEpDVnFvS0N4c2UraTdaU1ZZRnNITU9PZzRHZy9sdVcv?=
 =?utf-8?B?TWg2akxJdWtpUG0wM1VTRnZrbFV4RWQxVWFDSmtlK0N2NzdZL3c1SHoyRld1?=
 =?utf-8?B?RjVlT1NCZWcxUlBHTFllZUpvWjhYUDBQeWZHYm55L3Y1SUF5NFFBU2UxV3pn?=
 =?utf-8?B?UVdTS3dZVGVZWXdlMFFwOEsyTVcxaVpmV3p6YVhuVVMvdkVlZEc5UFh6RW9h?=
 =?utf-8?B?RVB4QTY5cHhRaHMxcXFCMy85OW5XOSsyLzZNbnFpanlSRjFEcXpuQWJnMWM5?=
 =?utf-8?B?NDVjMVNUQXVEeXJsWkJ6QzU5N3Q3Qk5GRmNKSzJIREVIaUdHaDJDMGpsYmtF?=
 =?utf-8?B?MlhlQUsybjVVeUdXWnhaS25JOTRaN2VMUjNLV2NEdUdoczBRVEc0d1gyZkc2?=
 =?utf-8?Q?A718p/nX/d0s8YGF1ArKOGFSrjPsenge?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFNnN3EvMTFkV2pQeHJjYzNQek1xV3FIRzcvd2o4YXk3ek1EZHRLN3VJdlJW?=
 =?utf-8?B?NlZ5NHoxb2lkd01MWWNGZ09uVFBGVHFnVnR3aEJoUzZRbkxyalZ6cmxyU24r?=
 =?utf-8?B?d2lqalhFRzNiNktNMjlaYTdtSDRvMDE0MHVURHlXdmR1bTNwak9EZlZlY1l5?=
 =?utf-8?B?d1FJclIvQlpES2oxRTd2Q05iSTZSbXFCZEpWSGw4dHFpY0pQMVIyUndYc3ZU?=
 =?utf-8?B?ZnZCbnJPdEFVUXlZNWVvcXIzeS9rTEVMbHk2NXVMSkoxK2tvZmltVEFSTUhY?=
 =?utf-8?B?ekxucFZJM09PQm1QSFBSODg4c0NCRDQxZVhiNVlWQ2psSW9xNXBMQjgvdS9v?=
 =?utf-8?B?YWNma1o4ZWY1Z2dSdFA0OERVMC9JVzJyQVhCdUgyaGpnNnVwTzlRT3ZmZzRa?=
 =?utf-8?B?aFZnRkdrQThnUWd3ekJYODZPai9kZHhXbmgvWGo3Ym8zUEVNY2VUVGRDcjdP?=
 =?utf-8?B?Q21MM0d1SEgzRkxGd2pianNEbGpPbnZXbDllMFJndHpJSHpLUWY4S1hucHZM?=
 =?utf-8?B?TXFINmEyTEZWMEZnSzhnYk8vbUtVRFc5Z25YVkZiY2EyeHhZMGZCNithTG40?=
 =?utf-8?B?bXc0Y0NVRVdZSHNYZWFZUGhTSGFYRUYwUXVCUndFNlVJckQrTXI1dlZ0b09K?=
 =?utf-8?B?NktoM091dm5VaHd3eDlmaUJnOFowRStmTm5kNWVwQ3lXSEY2ZkZ1cVFTVlBw?=
 =?utf-8?B?c3lUdUVCL21YWkV0OGVXb3VaVytVTFJYWXdMRGxzdFFCK1BCYW5WKzJQamRl?=
 =?utf-8?B?RTNCMm1iZ0RCY0pGUy84TDFnblB0K2hHOStmbHFHeEdqS0E2aURGQTkxa1Z3?=
 =?utf-8?B?TG9FbWFZU2trYUhSK1Y2eWFxZ2xhS1lCNWZVYTZMd1h2MGVpTWFic1doS2Zo?=
 =?utf-8?B?MzZSNEczQXRKcnFQRVlPckZaUTZhNzgwWW8zK2drMmRmTFJ5ci9vL1FYZTZv?=
 =?utf-8?B?TGNCSkd6b0pCN3FJZGtLYThCbWNEbEZ3MEsxQmRlSjBsVmRKaXloVzFXVzB6?=
 =?utf-8?B?cTZ6Tytnd0g0M1BMNGZHL1NVbGJ2VFRaTmN6M1VBekFSRlpGUGprK2Y0cjVu?=
 =?utf-8?B?aFpCa0IxU0hjSmZObU9OVUthN29QcGpaS01kK0tVVjY1UGpkNzFUQkZPdWFF?=
 =?utf-8?B?MHNnNFZQam1udkhvNGpqRWZrbEJUS3poQ1MzK2thZE5pdFZlVDJnU2RmOGZ4?=
 =?utf-8?B?cjlWeDdGTzNBMmYvdHFCeTdVNEZBZlhyaDJ2OWM5VDM5WEl4TlpVSEtnc2NL?=
 =?utf-8?B?S0hLUVZPTk5Jd3dsMlo1ZmlSMUJmUTR5N2FleCtQdk9EWUVXNXZYbzRhVHRt?=
 =?utf-8?B?M090b1k4Um4zQlVxSDNnc0t3N25HTFNKNlpNYmVvZ0J3Q2N5RFFrV2hEZUlp?=
 =?utf-8?B?cGZKYzZEcitydHJzZWxpTmNFcTZsaWE3bHZEVmswL0t5MHYxUmplYnVQaGY0?=
 =?utf-8?B?b2ZGQklMYmJtVkVaOUVkNU1TZU9Fa2NJRHFnMzl2TFpMc0g3OGY1Q1ZYcHpP?=
 =?utf-8?B?US9rVWpuZlB4UGRhdkYvM2V1ZUcxZWVwdWl1ZnVsNERpR054MGNIdCtsaEMx?=
 =?utf-8?B?cUJnaTNpcTVtU1lqR09aNWZoRVI3VEdld0RIS0YxZUNNdUdMV29sR0EwQ1dr?=
 =?utf-8?B?VEpmSDZBVmZYdU1CM2UrUDFvUnJVaDRrclMrdEJFZUZ5NkZhRWRWQy9pQjM5?=
 =?utf-8?B?OUVxRDFRb0lzUE50TWZXaUhnRFhMR0ZBTFQ2TjBtOFZlSGU3K2FOd3hYR3ZX?=
 =?utf-8?B?b3VvcDA2TkpYalVBc1NFS2tNUDg5MGNkQi9yNTY2N2JUUmsrZDJGbE1Scy9N?=
 =?utf-8?B?dm1MWlhsN2Y3T1FVK0NhcVhNb3g2Um4vYmVqdFZDaUlrcFB5WXJYSWYxMGl4?=
 =?utf-8?B?YkVocG83RmNZMFVtYWtQb3BRa3MrVjR0SGpoVUNCbjhSdkoyM3B1R0VFOWpi?=
 =?utf-8?B?a2ZQQ2NEdTB5WVoxSnA2QVFEVUJwVmowRG1jcWFySUY2ZGtkdzEzRWhoN1Yx?=
 =?utf-8?B?SjJ6NDZkaTVCd1FXUFNkbWVWNlBNRVdJYS83RWMxM1dYSjB0YkFFUlFHL09R?=
 =?utf-8?B?Yk5rcWxDZTdyMGRCR3Q5RUwxVHBNdzd3NVZjMXFqWE5xUWVXTXE3cFB5UUJH?=
 =?utf-8?Q?zbLUzAzsGkAONWJyB4Tp65cEm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc12ce35-423f-4c37-375a-08de241e86c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 08:11:06.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFO6BvMGjOaOVrY6KPz3RdZoO1XBpbOqmtGKNidKSSFsiubrp3G3a+cKTW6nSUq2Gv2kVkwYzMmWJ6A7SYOtWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768


On 11/12/25 15:33, Jonathan Cameron wrote:
> On Mon, 10 Nov 2025 15:36:39 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Use same new initialization with the type3 pci driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> One minor thing that's probably a merge conflict gone slightly wrong
> or something like that. After this patch you end up with two
> CXL_NR_PARTITIONS_MAX defines.


Good catch!


I'll fix it.


Thanks


>
>> ---
>>   drivers/cxl/core/mbox.c      |  12 +-
>>   drivers/cxl/core/memdev.c    |  32 +++++
>>   drivers/cxl/core/pci_drv.c   |  15 +--
>>   drivers/cxl/cxl.h            |  97 +--------------
>>   drivers/cxl/cxlmem.h         |  85 +------------
>>   include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>>   tools/testing/cxl/test/mem.c |   3 +-
>>   7 files changed, 276 insertions(+), 194 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..13d448686189
>> --- /dev/null
>> +++ b/include/cxl/cxl.h
>> @@ -0,0 +1,226 @@
>
>
>> +#define CXL_NR_PARTITIONS_MAX 2
> Adds a definition but doesn't remove the one in driver/cxl/cxlmem.h
> That seems odd.
>
>
>

