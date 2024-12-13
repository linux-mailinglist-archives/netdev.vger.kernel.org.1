Return-Path: <netdev+bounces-151650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F175C9F0784
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344321886B17
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84D1AD3E4;
	Fri, 13 Dec 2024 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nS6lkddv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778692A1BB;
	Fri, 13 Dec 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081483; cv=fail; b=uxJR+g2fs1CVllVsBflwClTQnpWUe9zs/MGOq7IwtQtEaGhJbCbzteAqFdzu3skSG2XH2ykxJz68ciOEdTazoh9PKt3Qpk9kuEXthiFb5FSfbHJVfGxQLk9CrDzbLjDw23cz2binpOr8UFzklPK9tjBPJlLHVYP2oSXRIqf4b2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081483; c=relaxed/simple;
	bh=XB4uG++nOZZr4/CgoKX5argO8Eb1kPBM+Bl+r9xcd2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Shb5wtUqWHCkkVfDu1tWJ0Fv+QNMDap1Cvhz7EgLqKB3bLJHSSF8X6xgDP3k+iReXu0IP1rnpRL3JnAU2cfuh8hCkpzTaVsWMM7o3qTdHi8JUCu6BOM3xqQF9cLLDmoK91iKZBrRIcDvEkJq1cWowdzwElBzFr+KRL8WI0udQqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nS6lkddv; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeYa5AngremkLPn5jGPw6fRMaOL9OMUM4XZytTp2bPwrtVF6euJQi4/T3JWT7Kd4DLMPn0XXKgN6RfExBXjda6+qMIwmsW9U3IVs0eckOlYy/v4idijKL8Tj+KFqmvIVMDSqG2nFYfNAsplFZzHbMtL7pC1lZcJPPGzcvn+BT1au87zYyhH/CGbu5Ghx3fCOnfFxfDZcMHvSpHqe8wJyyyas5IB3rtPWMBRMfH0L/Dgavo2zrfMxxnlDM61PUd5HXScWBkH5ai8IXcwVEq84Mdhj3GVhZwHliAxAoHWSzXSTh5boqVL1GGm1JEja+frb4B3trw07wqyqr2W9+txjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqqUsyvtyc/g/b68NfgMgSHzyFUKaYM1/5dWPbDe4MA=;
 b=YFrJP15gr/YZIYvb/qLstU4LieyeoqIf/vrqi04d8IHi/cfGQnOie3ct232glOs4oE6mi8p1Omj13bGiLR12Uxxv+adLA11fWNfMlkJvZpd/1lfPcpLIg+HC3TYeKXLOMcUxhEBjK5mJ0Nsz00z7yVQQJgcejmmcX92CeUgvLnE3tckERXQQ4npA5qs8Jn1LLNrX6VcXZdr3epmVCj37kqyj6kUmHGZekqA+usT6jyJ7n+/9JcUOiJ7giW3+DV3+NLuZAz4vlHFSq9reLscT/DQaC+v6NNdJHK9hbgZ52P2+4+JbSThFfOHlIAGt7yT67X/QLowhtVyQMjLRUr1D4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqqUsyvtyc/g/b68NfgMgSHzyFUKaYM1/5dWPbDe4MA=;
 b=nS6lkddvqJjgYsVGlBI+s0he+thuXJj4olhBnB6y41Vhu+yrCpaof9kExK9zvWgMWk3FdzrRgkzv8z5+rbGtJgvz/41sam2fPdeeRdGuAPizKbNqaxs/EiIFQBSpSlNK2xwPphWBuskATqPDPgCRX2x0eqYenbff025r9ylVgg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.23; Fri, 13 Dec
 2024 09:17:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 09:17:59 +0000
Message-ID: <7fa95860-5d4b-c19c-b9e6-94d8d8130793@amd.com>
Date: Fri, 13 Dec 2024 09:17:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 07/28] sfc: use cxl api for regs setup and checking
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-8-alejandro.lucero-palau@amd.com>
 <20241212180420.GG73795@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241212180420.GG73795@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b5c05a-ebca-492b-efaa-08dd1b570979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG9ScnJyYkE5WDFJUG5jUCtCTm5FR2Y3U0xMVER1V2dwWDBNMXF1eWJaREtp?=
 =?utf-8?B?aVFpSS9CNGI5Q1h3dERxckYrOEtUbER4ZVFaMk5PUFlZd0Y0MkExa1U1ODU0?=
 =?utf-8?B?eEFLZHAyaXFIMmhhSlVvdnhsWUs5NkpaQXdGaDFqc3lKREtMbkhObXpzb0gy?=
 =?utf-8?B?SUMvbjQ5QmkxOGJRS2VVdnlBZXY2b2JoZTJkOUJ0ZWMzTlA1cXhyNUI5L0pM?=
 =?utf-8?B?eVh6bVUrT05MMWkwek9sUzJtYXBsU2pFWCs2SXZ0dTNlUzExUmNBMFRENXIx?=
 =?utf-8?B?a3dZMVpvWnpzV1AzU2pHS3ZXZytzeDNieVdDVEMzM3JtZXNtNS84UFcxTDA3?=
 =?utf-8?B?anZvOXovSjh2SUlWOE5weEl1WjJiYk4yQkEvTTVJT0VtUC9tZU5mZHh2bm1m?=
 =?utf-8?B?cFpLSXRQZVJUbFFvVWI2cVd3VTIvTURXb0dSYmROT2t5MEFBaEgvVXdHRVFa?=
 =?utf-8?B?dXorZ3ROMUpJRlNUS3B1WHJQdEVyaDkraEVmL3ZpWW1VVURVYWpCWUFzdktI?=
 =?utf-8?B?bUpvOVRWT0VzN2FNR29vWnFtM0dEemRoRVh3b1NoTzFveG1pRlhFNTFNdG9F?=
 =?utf-8?B?a0JOY2FBVThTSHhhWmFLZm9ITHdHRTc1ZGZMMmRTZHJXam1lVlVSUFJXUEFZ?=
 =?utf-8?B?SkRZb294ZkFTNHdEZ0ZDeTBLNlBJbm92TTRUNk9jdnk0WUg3aWZmSk9LaDY0?=
 =?utf-8?B?UGMrZDdYVHRMR3JaRytpWFErT0d3K3FPbVhlRys0dXVqb2Y5dGcxMEVMNUZI?=
 =?utf-8?B?WHp1SzhGUmtvdTZ2ejM1eWlVR3Rzb0YybDgzc3dob21oeE9jUnBnZjhsL09y?=
 =?utf-8?B?RFg1OXpBa0tQU1ZYYStRRndnTVh3M2dNTExxMGVtdmxjRTBIcnpjSDF0N3Jl?=
 =?utf-8?B?cXJBblZIRUQrbkZzUW45cjFTYnhpMDc3VWRoRVhtcTZ6SEpxN0FUZmE5Sis5?=
 =?utf-8?B?aTdQUmtRQjgwM2lFWXAycWZOK3JLSzZVUTJFZU5XemFTb2VzalNBMEU1bUZk?=
 =?utf-8?B?U2hadEcvR2QxT3U4cEphNThpdWd6WEhsZDR2dUYxRDFqNUZlejY2Yi9rbHB0?=
 =?utf-8?B?SEFhVkt4bmk3V0NNSTNRa0xKamlGOGpMY01heFBkNndWVlJhUFdIa0g4ZVg5?=
 =?utf-8?B?YnVEa2Q0U0c2MWNmQ0JmWUJCMC9sbzRObFcxb3Nqc2JIR3NVTVpMZExLNG5y?=
 =?utf-8?B?bEVsWDBONXNMdWVKR0NKVDcyYkFmNUFZNWhNc2YzaHlVTXNrdFduVU9PK3Ri?=
 =?utf-8?B?RStJbTJiMHhaaDZZUlFIOGR5WC9wcndJRWt1bE5tZlkwWEROWWFvZ3U0NVkw?=
 =?utf-8?B?QU94YkFiZFRkcHBwN2RuL294WWtHb2NpMWVnOVNIdHg4TjJ0REVUbkRqcXQv?=
 =?utf-8?B?cXRXRGwzaVIrSDB1NTNtbEVaTTlBU0ltbkRPYjFicGp3bWZZYnk5SFFEK0JG?=
 =?utf-8?B?VER6MGpyZThFOEc3a0FlcnpHQUpVRyt5MUYyUU1MOW9PRXdKU1N6WHV4UHJo?=
 =?utf-8?B?dnN6bFh5UHBCckhoUjlnSHh5Q1lsdnZYVGlxVFh0WEZ6RUNzUlpJbmZCK08x?=
 =?utf-8?B?TXdpUzFvY012LzZPVE51R25obXRlc01zK3FtRmFzeWM0MW1hU3JzV1J1UjZy?=
 =?utf-8?B?Ym9QQlpYdHhKNUhkM25IOEVqS0V2VGxic0dZWGJmUGhHN2ZwUndncVlSaWZn?=
 =?utf-8?B?aGpicWdzclZ3WCs1VnBUNHJINFZaVi92bEY5L3E0cU9FeXJjbGlIQmNvOUhN?=
 =?utf-8?B?b0taQ3pKZWYvbGZGcEpGbWNEWHdPOERLRitzMEZoVmIrYzljcXl1RVZqREQr?=
 =?utf-8?B?cS9rMnN4YjVHMEg3QTV4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NklLa05lMG1wdndBTDViRndqOG5qOG1hVjVielF5U1ZpVWV2MkJjaTVZZUJW?=
 =?utf-8?B?Z1NnMEtIb3JyVDJ6VWVtcjAxd280RjQxOHE5cjVoVnVTOHUvcDBIblVJVGNZ?=
 =?utf-8?B?cWlUR0YyMXRjbElJVVdUT0xoVXR2WXZod0FyVHUrVHNMU3MyVTNWbkQxMzhN?=
 =?utf-8?B?Vk05M0sraXJBOEhYMGhhS2p0MFJDWnZva21SWkpyaUJmUFBuSW42UXhwU2ZQ?=
 =?utf-8?B?dzlXdFI5Z0JiZzVlT3lxZk54dlc3YWJCWG93R0RaN0UzVmtLaW5wc0gzTVNz?=
 =?utf-8?B?VE9MNzBuMU5rajVRWWhtRXdhaVdFbzBsZmE5WHlUM0svSFM3UXNRWGZzQmpz?=
 =?utf-8?B?bDJBdVNQb1hPN0xaa3VkQStBaUVYSEkvRnppWWR2ZEdPamVscngwa3FuV0lR?=
 =?utf-8?B?THVHWFl5SjN2eEZYL002QmlTanlBSzR3R2lMK21Md1pFdnJvS2RIWHlxMkJs?=
 =?utf-8?B?Wm5HTmFFR2dKR3JGM1ZQRHJOcUxFWUQ2ZTNKVmJyTW9PUjFYNmh1cUl4RFBE?=
 =?utf-8?B?M2lIQWRWbmRkdVVMMVMwZHp0eStJMHVvQ0RHM1RieHFoMmpKcm93VS81WmJG?=
 =?utf-8?B?Z2V2b2pRN2d5TmQvbmNrSHE0M3h1SUtTUVRGSlVWMkJQc0dndSsxSjl0K3hq?=
 =?utf-8?B?NnBHQUJST3FKcDUxYW03ZW8vd0ZtV2RBa29QNXNoK3pDUnMrOVVJYUVEYjB1?=
 =?utf-8?B?Z1UwTmhES08yUWF5T0NLZHZrWnhaaWxhQ1F4aU95bGJXT1ZCb0ZPOXlyOTMz?=
 =?utf-8?B?U05oQUVaZ1ByQVhMVFJKZGhVKzRma0QrS2d4ZExoczJKNFhJajZWYUlHWU12?=
 =?utf-8?B?eWpwemNXdmFCVjl1Y2VWcUJWSFZ0cGkyZGEwc2NMdGhkTm1zak5sS0toVEdV?=
 =?utf-8?B?RmlXcURvRFcrQkNETVBMU3VzR2ZBRUEweUtpcVplMUYrYWwwRUZsdkw0Z1Bi?=
 =?utf-8?B?ZVk2Ymg1aGFvWTZmQjZlUnhVUU5FRFdRNWFKdDFYcTZUb1lTQkhQUWplNjhp?=
 =?utf-8?B?eUVBQWpxY2gzWEtzZXhiQVdsV0lHNjVJZGdaekxJQnpUK0Rma1FWZkhrNDdh?=
 =?utf-8?B?ZjlVK09IQzd1RU1sd3dtemp1bnhlNlVTdGxpV2RoMjF4aEVJZ1RvVVZ4L1dO?=
 =?utf-8?B?Z2R2M2JJeGw4N3RwNTdmQUZZeVFUSjR4VjV5Sk5GZml0ZkpsVDlYTXR2R0gy?=
 =?utf-8?B?SlliS3orTEtIR2NEbjZTeUpGZjNXQXRyNVc0RWtBR0JmU1Ird0FTQWZVSDl1?=
 =?utf-8?B?R0NsTGlONmVzdXQwTy9IWE9MTElwcTczVVJjUUx1NFhkaHIvWGNHbVFvYjlZ?=
 =?utf-8?B?WGlRb0FIVzc2WWVWbzdZOGNjbktRMHVjVnB1dXBUNzQ5ekV2bjdIMU1nVDRY?=
 =?utf-8?B?cjN4cmNScTUwWG9WV3o5VXQrSmZQL0NFK0dNSDVXelpDWGRYT1o3T2E5eHlu?=
 =?utf-8?B?YzN0MFJHdHpQS1VVZFdBcGhkTGE4YUh2dUNnQmVWczR5ZE9mNnNQaStDYWh6?=
 =?utf-8?B?enB4YWhoYzlPR0g0Wkk3Tnc4K25kcnlCQnRTZExlUEl3eG9JMjRZblNzay9y?=
 =?utf-8?B?d0UrVFNJRHFINXgrNG5WUXQ5RjVxT1hxR0VLUVFwWXNENWZEendxaThRbDVX?=
 =?utf-8?B?bUpJblZXaDVLVFBiUXJpTjNFVVpSZHEyMlMyR24zaTkxbjR5dGRxcG43YnhT?=
 =?utf-8?B?VGpPK1FFV0JlZFVKOXdFb0t6dy96cnlDZ2E0bUNxTzlrdnc4ZWtCbGFEc29S?=
 =?utf-8?B?S1g4QUlieDRUN2tORjNRQ29uaXRhMFNuaDAxMGFHd1RHTmtMRUFCWjdIeTNQ?=
 =?utf-8?B?b08rN3ZIQml1RThPV2NHa04rRUJiSzUvNjRYMnpsbE43d2ZKbVc2U2ZqeExx?=
 =?utf-8?B?TDN4d3lZNmpOWWVzY3RYdXB2U2pqaE1Da1YrSjE3eWFtTlcwWXZnZUc5WjZ6?=
 =?utf-8?B?MGxHR0piNGJKbUZERVhpN3JiWWQyVzJmNjY3MlBaN2xqM3lET3JBR0RpUjJU?=
 =?utf-8?B?aUdEREtua1JtM01qMjZnc0E1QnRzSFc1dTR1UjJqOGZ6WkE0QUs1V1hEWDRo?=
 =?utf-8?B?UFprSk52bUhnT2t1Q3ltN04zZ3FqdEd0VHNTZmp4eHdvK0FNY2NSSHZQOHpX?=
 =?utf-8?Q?S9lPyvY88hk9b+AD77rx/8A6r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b5c05a-ebca-492b-efaa-08dd1b570979
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:17:59.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fViCVCTt2/WkoNzeHvCOqCE/y2F+33pvlzuFvApt3Aton156xC6253ZQ4GCksuQhIazybURWqDs23lTbZqwaFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790


On 12/12/24 18:04, Simon Horman wrote:
> On Mon, Dec 09, 2024 at 06:54:08PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl code for registers discovery and mapping.
>>
>> Validate capabilities found based on those registers against expected
>> capabilities.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Zhi Wang <zhi@nvidia.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 58a6f14565ff..3f15486f99e4 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -21,6 +21,8 @@
>>   int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct pci_dev *pci_dev;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> @@ -65,6 +67,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err2;
>>   	}
>>   
>> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL accel setup regs failed");
>> +		goto err2;
>> +	}
>> +
>> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
>> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
>> +
>> +	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
>> +		pci_err(pci_dev,
>> +			"CXL device capabilities found(%08lx) not as expected(%08lx)",
>> +			*found, *expected);
>> +		goto err2;
> Hi Alejandro,
>
> goto err2 will result in the function returning rc.
> However, rc is 0 here. Should it be set to a negative error value instead?


Hi Simon,


Right. The code is functionally correct because the driver's variable 
setting the CXL initialization successful is not happening when skipping 
with the goto, which is the key part. Returning an error will log a CXL 
initialization driver's error but it has no impact with the driver's 
initialization or the CXL usage by design.


However, the error should be returned properly.


I will fix it in v8.


Thanks!


> Flagged by Smatch.
>
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> -- 
>> 2.17.1
>>
>>

