Return-Path: <netdev+bounces-192638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5862AC09AF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B05A24280
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573EC2356CF;
	Thu, 22 May 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kjGU4PD5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814DF2914;
	Thu, 22 May 2025 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747909469; cv=fail; b=qXZC0nFMIx/u/hebnV3DjiN2fckpLEN6r7KM1ajWwYJvbp/HmIAu/otgQb+9uAhJmf25pvsNoV5VyOrCS9d1wJXPVLNiKJeHa2Fi0NL1cCky6s73O0dEVT4quMQLmG+aMtIlwufpzucRa9Zss9EaSkKtBV31xQ+7lVI/dsaFA6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747909469; c=relaxed/simple;
	bh=2PGri+tc+MYnnX870v4j6gnM5sxl7N2ama9iGxI40bM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YrmmBeUxtfpBbLXrOyarq7BvxML2kHUQR3XhDZ0uGjgJJ9UNlCzGyYgAkL+qOcxN8VYqTLqq/gAOQqrPyScZi+h8UYz8SKVk38q5BcRozykijH53AZScRc3bAuzmg82P9to8xKNvUYwQTXi/wcKaF0MXIhDmGqPbqoivwCR8peo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kjGU4PD5; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHAl6XsIjBwvZm6gphl//UO/N2eYqMtBmCORVMru8WG69gnMfBHDAkGqWBoeIyR8sgpZ4iSBfnfdZ1MmmptwFQnxSBEexUnb58koXZLLH/0sZv2HrDIbN20fxwYbMGJZxB1ZUcv6a6TzWrGDoyPd4RdD525C2IvYC0RLIXGDhZloBQ2uGLKDGaK+c2udoDCtEZe2A0vE5edrjUgo22gCiwrF/xkZ/py140llMcQA9iWDmROH+MKpMbHbkiMcwptxksP/JcHr3lYKOdrGD7WpqoloSpsN0RBNa6Smj4LzjOza6HEIayLwrvRGuvutcHp89SE1/VCf+VXmiMSLHMsh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekUOqBY41XXZLkeWLqZcas3wIUmFxAglgA1WWwNGI6A=;
 b=fs2wbZlpzNm/yn88GpuaiBxXHeC6b93GzvssiEfvTmL1GnJs6TrzeFEIRSEKcS9DV/3onrYR1COFJ039izS3aitwa9QGYRSSfPCDcgrUXO3kQ/ddZe717sAWunjYQ4K53I+U6nnviOhWs+SQkXyPgM0/bAvGwTTrgxaKjpTSVHnaE3TcDC2SR6g9Er0ebxPnXRzvm6+kXEm6NYuEAPoYHohg6bX3rwOHEvs5Ty4HmWIi7hqMOS3g3dkYK6mhqVrGnF0noP4uyt4Xw6ORY3Yu/g1DHDQ0AQ3R/Ofu6nE/oV+31FmsIEaqROUd6eNBtCDXoPilKilWDpvkYfzCb/MfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekUOqBY41XXZLkeWLqZcas3wIUmFxAglgA1WWwNGI6A=;
 b=kjGU4PD5n3YK3aDXu68gEm5BDeqT3WrpaNmCTrLKJYnndQIGZ+WfEMjtQV4uk0mduB6c47JpaJiELiqQgGbNeQZej2omoMbLn29RtgUgpfeprmSW4xyMN996TUhL4KFq7nRPKURo7dV8PQYPlGbUjz7CClCNG0weZQuS0YgOBls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.21; Thu, 22 May 2025 10:24:25 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 10:24:24 +0000
Message-ID: <edb78c4e-f9ad-410d-907c-0564222f455f@amd.com>
Date: Thu, 22 May 2025 11:24:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 07/22] cxl: Support dpa initialization without a
 mailbox
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-8-alejandro.lucero-palau@amd.com>
 <682e1fc963402_1626e1001c@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e1fc963402_1626e1001c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ba8b1e-1c90-4349-c0b0-08dd991ad286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTdzV2EyYUp4d1FDMWtsWFZmbDJnMVp2WmowOHhnN2xSQUFNU3VZVTJzdkx5?=
 =?utf-8?B?RGVna3QzOHlhVUh2S2tVRkhDcHkrQ09OZXJKYnljZnZhTG9Cd1RaSHNhM0Fh?=
 =?utf-8?B?eEF5UU9nMmROUElHa25BSDFnRFRyOEV1OTNPUThZR09DVWtJdmYxVlFXbHF1?=
 =?utf-8?B?Ti9JMDFyLzhjaUthdXBWcXQyUDk0b1orSUVMZk50Y0VqRUJqT1BvL2hhRyti?=
 =?utf-8?B?aTlOSkkycGpySE5PMUpGell5Szh4QWxIQnVSak9UL3J3OCtEVGdyRjlsR0Uv?=
 =?utf-8?B?ejlkSTM3dUpsSytUR3RnRkNPb2krSTFTYktSK3ByS2ZqZ3BsRElDdy9GMzZj?=
 =?utf-8?B?dVVBR1NXdDYrdklzWlBoblZGejRldzY3ZzNhYWhoVlh0cHF5d0NkRzV0NnZs?=
 =?utf-8?B?T216cEttRmg0aHZPZGIwd1E2TFdsb0lpYm9HU3hyekY1Qm0yUTE5c3BYUVBS?=
 =?utf-8?B?b1FzQm5RaW9CNzNiQVh2UXZQNGFhNWZLb1hmTnBQZlM3OVRmaXd6Zlg1WFN2?=
 =?utf-8?B?ZXR3eXR5UkZNeFdhbnJWNW5tUWVLdWIweFJDZ0djekpKVE9taWNNMlZoTldP?=
 =?utf-8?B?LzZhcjc3UDlYYWI0ZEZUN1M5QVg3R3NWcDF5MzdQaWJ1UXlSTkl2WUNVM3Fu?=
 =?utf-8?B?ZHNJWVdQanlJRm1OUE5oc2dRUE9GdDBtaEdxZWd1NkZSMWM3MStwMnZzNlZK?=
 =?utf-8?B?MVZaVS9rdEhsOURwT0c5M2wxMDQ0VHhMTEhTQTd2QWEyYVlISFdDOEVic1hC?=
 =?utf-8?B?S1JlWXFoUW9ZbW9JK01JaFVOT1JGZDZHdTRIS25oemlnNHBWa2hjNUprcVFv?=
 =?utf-8?B?d01NdEJwM1pZY3k2TlBKdVF5VGdLWW8wYTJVZ2VUbTZlOThhZXFBYkNTSTda?=
 =?utf-8?B?MFZYMVQ4d3N3T01sd2Z5Nmw3b1ZobVozNDVnbzhYT0ExZGJqSHhYQ1daS0xp?=
 =?utf-8?B?a2c3N09MSDJJS3Mxelk0MVV4a1VHRHp2SGFPcHJxS3FvcHRLZXdLd0liM3lr?=
 =?utf-8?B?RW9Cb1Bma0xRSUU0UHc1cElSSENWczdqZ2N3bm9HOGtNMmlFb0tQeDVIRWx5?=
 =?utf-8?B?eDgvVVdzdGQrSFhNMC8vNktJUFlKRUVqSW9XWTFScEhacU80L2xVeDFGZE9G?=
 =?utf-8?B?ZmdCeDFKKzZWbHJNbTRSVFpKTXd4MkRUMUpUVnpTY3I3bVExR0tQZDdzOFZJ?=
 =?utf-8?B?d2lRLzBNdVpwRllsbHJYeUxqcmtkbnVKd05KbHlxL1h1SWhjcDBZT3g5bjU5?=
 =?utf-8?B?ZG5heGJzaGgvNDJuMkFMMjZza2k2VkRiaFNqcDJhZENhUFBFNGQycXBaK3pL?=
 =?utf-8?B?aitPMmpFR0JOQ2VqM1NyNnBOMVIxcjNaT0FZZE8rc25ZaW82aFR1QzVyaVFa?=
 =?utf-8?B?SjNmdzhBRkh1YXNsNGlrU1RlSXllZXFrSXZ5ZVVZb1lxOUJSZEdNeFhveGhs?=
 =?utf-8?B?bUtBdFBsNUNEczBlMjdpTHNzbWV3Q3Btc3dpcDBsKzY2MVUwSXRYZDlHc3RZ?=
 =?utf-8?B?MWFqYzV3bEQwalRzQUpwVDZYa05OdG1tZ21NeStPeUd4ckkycExXMWlzREdp?=
 =?utf-8?B?cGI4TE5BcjNOSEk5MEZqZkE1SDJrdGtzNDM2T0NLSjJPSFlvVHUwVFZPUU16?=
 =?utf-8?B?YzdaMHFndjNybDN5aFM3TmxzTFJSYkJlVzViWGFSU3M1V2RrRGtoODAzR0NP?=
 =?utf-8?B?UlRVaWg5dGhJOUhaOVlFcjhtdWxxVzR6cmFBQk5udHk0cm53a1pFNFo1Y1Zz?=
 =?utf-8?B?dm1UY1ZyeUt1bFpETmFGSHAxZ3N4WUNQSHIzazByLzBLNFJkaURNQy9Mcnpz?=
 =?utf-8?B?YXV5ZVdkb2NvVTR1ajFIOHRFV1VHdks3YzRzVlpxR3czbTRhSnRZYmdDcFpK?=
 =?utf-8?B?bnRZcFI3c1dxU2JGdis2cU1HK05MdmtBNmtER2FLamlVYlQyZm9ZUWp3TThZ?=
 =?utf-8?B?NkRRUU5JM213Y3JvSW0zcUxwbzlKQldpRWovT0ZMcGhScWllN0NoaFlLR2NJ?=
 =?utf-8?B?UUtCQ1BKeVNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDk4WTZ3b0pYZDZCZ29kN2FvYWpxdHZvdXg5K29FZkdqdjZNU1kzNGs1L0Rn?=
 =?utf-8?B?VkRlalUxY2phSGdMRmxOOHRncm9Rbll0NFg5Q2hzdmtjVnAyVkIwd3I5ZFZD?=
 =?utf-8?B?MDJSQ2lwa3hQTHlLcDA2dDZVUXBRMEFWcm1KSStHWXMxQm8xZlJibU5qZUh6?=
 =?utf-8?B?dkN4bitrbitOdzZlR25MblFvMlM5ajBrZFNXeWVlalgrbVpRZFVwWjg4Snls?=
 =?utf-8?B?a2tudjU5bmdwZlpUU0FsMlhwd0NXc290Mk43R05MLzJ0RVZkY3lmNWx3VHIx?=
 =?utf-8?B?V1l3b1VlUHphQXZkbktxZU81RHpFdDgydWxRU1hvOFFpVjRBT3F4aTJZdzNE?=
 =?utf-8?B?a1h1VGU0cUpRbjlpMFROWXc1UkJrOS95b1VGMmY5UG90R056TjkxOC95Ly8w?=
 =?utf-8?B?UjRxclZBK21ZaU4yZW04ZHNURUdvc1Z2WkFsVWxMZnlYdWVHNFBvVk5VWnRv?=
 =?utf-8?B?cTB3OUtmV09HK1R1dEFkODczMi8rNXNFUzFMTldqVzN5ZXJ4NE5wUHl6QXJX?=
 =?utf-8?B?RXY2bk53azNwUStVOXR2RTQwVHNHZXBRMjZtK1ZKYnJBdTFCK0pBNllIQkFD?=
 =?utf-8?B?TDVUUjVGUlR6cWwvK2QyT1BjaGRYOVVESlU2NkExVkc5RXVzOW4vUUorcUFS?=
 =?utf-8?B?ZW8rQlFRRE5WZTQ5V0pROE5TT2NLUzNSTGJGNjFuL2gyMHpkZGZhem0zSDJP?=
 =?utf-8?B?OGJoSmRvcWNSSXg0K1RxYTA2UWVPeWlWT0pwRnZHb1JSTlY4TXk4S0xOMGlJ?=
 =?utf-8?B?TE55VyttaHRYKy9uUDZKd3dwNk9CR1EzdW81RHhHbW0xcFQwc3hjaFZDSGJs?=
 =?utf-8?B?Z3JOVlJmVVFlVkRub2RsTjVWTFRRdEVmN3VqdVdqaVBxS01pRG84djZYeDhj?=
 =?utf-8?B?OGNtbU1lMUxmalZIYTZBOCtyMDZPYi95TGVLNjBCY3l4bC9SemU2L3ZEbWNw?=
 =?utf-8?B?YW4zS0k3ckFaaGpKazJZZkJNVWlZdS9XR0RPWFNYa3Qva080eURrdG03MTlQ?=
 =?utf-8?B?dTk4NGppZzZWRGRzSnhrcm9FSUM1REkvOWhWWjRuWWg3a2lwSnBUbUwxcHg3?=
 =?utf-8?B?Q1U3N0RGMk5EbnVRdmJSMm5GVGYwVC8rUjhpVkdDM1o5MWs3cVhMVk9sb1Bz?=
 =?utf-8?B?NXhVY2gyWWNMdjN3eHBYVWlwcVpFVWdONUMycXY0TjVjc0FvZ1hrSFdWcGdz?=
 =?utf-8?B?NEl0OHVJY3F1Mk0vRXN4Vk14TCs3blhFd2wyNndPZ2haYmxUWHpxWDZLcG1I?=
 =?utf-8?B?R0I0RTdwV3E3ZUpQOHRBQ2FkeDZDbXB3OThvcnFvMDQ4MVpSVmlvaFhBK0tl?=
 =?utf-8?B?ZGg3bXFKYitxRDhoVGczRGpSbjZDUlduRUtqMC9VY2U4Q3FJd3BWcDRPbUwx?=
 =?utf-8?B?Z1BYZDcwMitEL1RHQlRacDIvTUU5alBsL3M4Yy9ZV001Yk5ScmN2MkNKaTF0?=
 =?utf-8?B?OFM4TFRkU1VyZkhUbFc1bmIrb1R2eDlyYjMveGxPNjRYbnVVTmM3ZUFOek5j?=
 =?utf-8?B?eE4xM1F5a1FRa21lSHFST3poL3NSZEJMSUt1SklwRnJTWG1oMUZBRVZtSytu?=
 =?utf-8?B?TURUamRQREFCUFRQd2grNDVEa2ZKeTBFeDRyVzh5U3RyVTBGZHdiRVZiLzNF?=
 =?utf-8?B?aWVhY2dLWHRFL1ZTbjYvek5tVlFwcWNVRXN5MURlMHZ5TnprWlZ1ZzNyc0Rs?=
 =?utf-8?B?SkFXOTlBTVVFbkhISlNiRElMWjM5K2FIS2JkTjR5bGJSQlRtM2ovNFpmZEZ2?=
 =?utf-8?B?dFpkK2hHTHpGTkJqNDh3eUlySW4vR1dUK2Y3b0dhMW5IdStqTFFjYUdqdTFp?=
 =?utf-8?B?MVN5SGVHMEdNSUltbStTTDNiYW41ZFlhc0tqZGVvTnZORDF4QWhhVlJ2TlFw?=
 =?utf-8?B?SExraFBmdDlzZzFqZXFFMk9ydkZTZjZmYmZzdHhvNzBXUmhrdEJ0VXdTRndD?=
 =?utf-8?B?QXhNVFFjem9zdll3UkJWcWNWUXM2eElEbDg5K0gyOTQxMGNZL3VRdFB4S3FK?=
 =?utf-8?B?TnI0WVlrV3BwTEVUTlhuMmV1RlVtaEl6cUV5amxuTUR4cTJnaXdyaFludEps?=
 =?utf-8?B?VXg2Y3RLSzVPTjFlZHVsTjliY0dINERFMkcyT0ZhbTFUa05acG9UQkYxWnVm?=
 =?utf-8?Q?lESv2Ol7AjtJ/tibIVUUvEGn4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ba8b1e-1c90-4349-c0b0-08dd991ad286
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:24:24.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3l1CdfJqPV6XDEffYl+7Rx4cHaYzkDnA4MbeCQC05DVGKtVnqo4K5cGfWOVpY9WVOE0b9wV92PcFY7tJNvuCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389


On 5/21/25 19:47, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>> memdev state params which end up being used for DMA initialization.
>>
>> Allow a Type2 driver to initialize DPA simply by giving the size of its
>> volatile and/or non-volatile hardware partitions.
>>
>> Export cxl_dpa_setup as well for initializing those added DPA partitions
>> with the proper resources.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/mbox.c | 26 ++++++++++++++++++++------
>>   drivers/cxl/cxlmem.h    | 13 -------------
>>   include/cxl/cxl.h       | 14 ++++++++++++++
>>   3 files changed, 34 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index ab994d459f46..b14cfc6e3dba 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1284,6 +1284,22 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>>   	info->nr_partitions++;
>>   }
>>   
>> +/**
>> + * cxl_mem_dpa_init: initialize dpa by a driver without a mailbox.
>> + *
>> + * @info: pointer to cxl_dpa_info
>> + * @volatile_bytes: device volatile memory size
>> + * @persistent_bytes: device persistent memory size
>> + */
>> +void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>> +		      u64 persistent_bytes)
> I struggle to imagine a Type-2 device with PMEM, or needing anything
> more complicated than a single volatile range. No need to pre-enable
> something that may never exist.
>
> Lets just have a cxl_set_capacity() for the simple / common case:
>
> int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
> {
> 	struct cxl_dpa_info range_info = { 0 };
>
> 	add_part(info, 0, capacity, CXL_PARTMODE_RAM);
> 	return cxl_dpa_setup(cxlds, &range_info);
> }
>
> ...then there is no need to move 'struct cxl_dpa_info' to a public
> header, or require type-2 drivers to pass in a pointless PMEM capacity.
>
> If more complicated devices show up later the code can always be made
> more sophisticated at that point.


That seems fine to me. The only problem I see is a driver with a mailbox 
will initialize this differently, getting the cxl_dpa_info first, then 
calling cxl_setup_dpa, or all that also hidden in another function. In 
any case, I guess the first driver needing that will have to work it out.


