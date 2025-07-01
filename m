Return-Path: <netdev+bounces-202963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D570AEFF1D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22741658B3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C49274B3D;
	Tue,  1 Jul 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VKZ95Jeo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69B347D5;
	Tue,  1 Jul 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386082; cv=fail; b=kX3/0sAkuFVVigWOS/isa7vgpwIc2mRN9flCRXYvAooGGZ2QPPxzXnxAyn/YRMdZmZV73Mh5fp0DUiiGjQN3ipiGKXtkqNA5mp8n5hNAwCCiZiBYFg+5uVflcNJHAQwNLBg14AoUb/9LnIFNN/7Vym/QLViCIZWeUkrZTg+yZRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386082; c=relaxed/simple;
	bh=et/idFVtkjDT9lQJEPeOfJw+Ug7KRqMqSByyLKm225Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GmF11+m9KX+BwzIr/NQxagpeAjZYAzFqslf8kq6+KiiHly05ygJA+CeJpsGLtM7gFJlQ96d4f0kdUoi8YeDsLJ8nkkN0W+etk3cI/Aw1kdfecIZBoc1PawEcGjktQE4LkzcN7zfLQoa3GMN9noRdj49cwSIqzCnfcuvcHPR/5f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VKZ95Jeo; arc=fail smtp.client-ip=40.107.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoFumcDFse7VSXsUYMkyDM9fYQweBcrTa3f9L/E7KFel4dHXqfESXx51Wynz8EJmoan9J0jTv6BdNRsfI6WbtBFO7se6wBDUWu/30kZvkNiOnWpy09+pLquFDq/rOKnSJ6tdQFlsQcDZNtJigvaGfSlOsOSDDaVUz3tqka7JzWFrs79malEPpM2KVaiSbcXv8D9/rkyWDtEhCNNghxcmm69ylzQUZWvk4ZTP05pDpJDDprth1k2J011pgtQ59hCJ7tM9wrPPsGe21vptN9cSoVwTrBhm5cpI7DSqLu0CCLOLnTdCLCVaDMEdCysvQiCL2hqAgL2IWK10EU5eXy6E5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbX88PkcupiE1C+0vcktPbKCeZ5fkvVutGyzmKWNrd8=;
 b=UopoVkk1zJpb/ZlydEGHUm7PPlNRVnvY4KbuDYjzKHbGCWvAFJJFzIHYDkxCCyciLVvn8rT14iBbTQAqYACLq3707v+6Xax5oQ79WQxTjw5auiKCL4DMbCrStsfkHE2QmWO51nPoC3MD199YvpLQgRZgkIA0OV11pJVZoGMJ9DPFudnrhD9VGV32B4lWNejyPoRYQncZY9SOdtxlsy+Qoyje5QoJHRFFYLLFcVGaaBCREW6rDdWWDCAVzmpbV2Fvi5Qtb8a40gIAiJ7y+PkOIxjDfp69N4hSgzsC0L/G6pFdgFQ3nDy6F0CukLenSv8KxgPxVL02yMajacl47jMcqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbX88PkcupiE1C+0vcktPbKCeZ5fkvVutGyzmKWNrd8=;
 b=VKZ95JeonPyvz0LZzVBLsT/B5tVYACGqf0/6m9iooqqJgOpb/aTPIH8RmDEuy6J2ykVpZhwHxk0VNtxf31pQbh+Hw7tlAOUC4+chc3ILLw9UAZbuAdR7C/3UjNt8zvJUHINeqdqHz9SB6Wml2kzjJyfpvgpH/gkh4dZDVXMLPRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 16:07:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 16:07:56 +0000
Message-ID: <34d7b634-0a4f-4cbe-a96f-cd1a8cea72ef@amd.com>
Date: Tue, 1 Jul 2025 17:07:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
 <30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
 <20250630172005.0000747c@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250630172005.0000747c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:10:232::29) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a0c334-118d-4e7c-5b92-08ddb8b970fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG1nVnRXek56ZXJJUTNMNGpSZlZXSVB1dHozMXRhUFdDL0hhRFNqK0tOSS9k?=
 =?utf-8?B?UXdqbklPNGtjM0NkUlRzVWtVMml2S0gvRmNOV0FzN0VZVDRwUEtVeDBUbFNW?=
 =?utf-8?B?a2RQQlJFb01FR215S1lzUGY3bkdrWlE0Vk9VNy82Wkd2V2VoUUxmc25tc3kr?=
 =?utf-8?B?anJzT211ZndBTjRZRWh6cTA1YVpmcTlEMFpkL0hWNjc4aVZzOGJ2L1c2NXEv?=
 =?utf-8?B?YTJhK2gzTEVkSjA4WnQ4MDFtOWYxTmEyZXJuaE9Wc0hWRSsrZC9qbkpNd0Ru?=
 =?utf-8?B?UGxhVTg5d3d0UUNQaXcwN2Q1KzFvWTl5NHZwM3BJYkdYZkNqdXFVMkdwY3hG?=
 =?utf-8?B?V0dJRkhEY0RUNEg0YTh3TkRld01ocldMOXZnVXpUaWU4R1F1MmpSNklrazlR?=
 =?utf-8?B?RXE4MFRrQWx0d1ZYdnZvRE1iZUZWa1NBanRpRUhidFIxY2MvWWRuUW8yaEdp?=
 =?utf-8?B?di9ZM2VCS1JGenhrd3pxNXg0eFV0L3lJelFtakNQRTRXd0VtUzhrYVBrK1lJ?=
 =?utf-8?B?Tnl2Z3kxdkx4R3ZyNUZXbGJwUmF3TFcxVWhyNDA0NVhacXBWVnNQbUd6bHlS?=
 =?utf-8?B?Yk51YmlBVXltdnp4WVgvRE13S3V4NkYxZ2JPaTF2WUpJR2VmaXNWUlhWNHhQ?=
 =?utf-8?B?ZFJtWHVXYUllY3VwWlRKdFhZdlJMbzNyR1BBdVg3eGNKK3N4Y2JqQTlyd1RM?=
 =?utf-8?B?NDNrSUROTHMvcTBHV3N3TUhRbk8vYi9vZ3RwaGJ5TmcyQ04yUFRMMksxS3A3?=
 =?utf-8?B?ZTJPcnQ4YURLNlBNZlh5OXBJTHR0cXJuTTU2VWJDSDBVU0QxajczRmh1M2FO?=
 =?utf-8?B?eXhXd3BZYmxXWFk0alA0K3hMOFhwM1RmSW1idjNKMEpqdDVCQjVIckZmNi96?=
 =?utf-8?B?VzFpNkc4aTA5MWdOa0szMVo5Mms5bDdXQjhtdUh3RDZkM05XckJxNnRRc0lD?=
 =?utf-8?B?d0dDdmc0OEcrYk14ZGpWWG05SXdNMlo2VVd6TThTVGlNdnRia3RuSEtCb2Jv?=
 =?utf-8?B?dFQyVFBDNXVnR3VYbWt2Ynl6bnJXZUEvMDJoT3NIT3QvZk1sZFVTOWw2Z05U?=
 =?utf-8?B?dEhvWGZMMG5tSEtaQkU4WUxaQUZWd0Z2MHJ2K1BWVVRNODhMdHl2ZU4xdHlF?=
 =?utf-8?B?dXVtejZwWEJKaDhKa1lzZTVYMHRPVlE0MFJVaHhQUkVDblpXbjRIK21YdVph?=
 =?utf-8?B?QmM4RmpEdmxRMjl3OVZMTUNtVDFYSVVhM3JXQVJBV0FpQnFUWXR6R3cwZXMv?=
 =?utf-8?B?bzV0Z3JJd1FtWGJoeWJBSlhxMG9sRkZ4WUQrSmtqb2RXa3l0YWtKc0xpMi85?=
 =?utf-8?B?a3hyYUVFbWZuVGVhME1CT21maXhRc3pHMEtGbkcwOGdneWdENkw2aTBxbk9x?=
 =?utf-8?B?WnkrZmNQeTFQUG5nNEVSbTBiK0pHL3llMWNTbWJPR3NkaTAyNWhub3JlT24y?=
 =?utf-8?B?ZU40NXBjdkl5eUtiYU94Y0M5d243TFdOZVkyRFpHbjBDbDhKQlJSK2tIczVy?=
 =?utf-8?B?TmtCUjdFYmMybXlQVlFGMGJhcUswaHlyR1IwcmdIZ1N2U09QVXZyZ09qT016?=
 =?utf-8?B?QjEvRGNDS3NyeTJWREpwRVlEUXN6aUdPc29sYWtXVmFhOXo4a05ZSXN4dXp3?=
 =?utf-8?B?SHB1RVZkdGRJRkIxU2dEWU9rdGphZVRvSDA3bGRrNEh3UVVkSWtLaUhsS0NN?=
 =?utf-8?B?aFpSbUMreHpqK2FvSVR3TEczS0xaS3hUU1NsY2pZM2E3Y3FOWWRxTE5sdWdZ?=
 =?utf-8?B?UlBXbVhsUjZ0N0JRTmdYbndSN3ppR1ZkZ0c2ZFpVRml0N01nUENnWmRFdEJF?=
 =?utf-8?B?cHJuK2FxdXZhakVBVUIwNHBMUkZGUEtUa2dTNDBLdDFzb0tLVlRURC9GQTU2?=
 =?utf-8?B?NlE5YVIxN01sd0Z2Wi9SZDdrbUlaYXhUWjBKYzMyalI2TVk3RkQrZ0JlUys3?=
 =?utf-8?Q?tokp+IZp+9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlkxZlpRWjVQQ3RIdEp4Y0JuVkFDdDJGNTVTclExcU0yNVFNRlkyYzc1bmNh?=
 =?utf-8?B?UVZZdTUvTWJuNThtbzZqYSs1V3FRVDhLM3ZEMDJMMytEZkg2RXZ4UnFGbHhE?=
 =?utf-8?B?NFRQdnkwQm8wV0R2c3p6REd0YldIdDBOTWFVV0VaR3I0MHlxOTBqUFNaaU04?=
 =?utf-8?B?WndmL3FPQ2pjaTNGQytnQ2QvNUNHZFJYNW5XTWd1dklqTitLSEhiRHJpLytP?=
 =?utf-8?B?b3ZyNVJZRy9uWldYSDM4NFRDVm51dGxPMlZiZ1hveGNEZTVnbHdOOXA2b0FC?=
 =?utf-8?B?aU9hNEltTlgvZFV5OW5iRElWK0JUdkY2blUvUmtpbzlrZ21qdVU0WFpBb3d3?=
 =?utf-8?B?SVlrcTYxQTAvamkwRFlHQTdCRWhQRVNvQVFIWUJyeTdQWno4Zmdsa1VaMFB2?=
 =?utf-8?B?SCtYMnhZVkFBQ2xCcUx0MFJpWGNETTRkcFA2K1lFQ2d6TXRWRk5jUWkydUg2?=
 =?utf-8?B?S21tVHI2RWZKMkVPQmNJY0o3amJQYkFCRVc5UENIdFhJVGRGRzZ0Z0MxRmh1?=
 =?utf-8?B?MnVMMnQ3WnlmOExhUmllMzIxN2diYXdVcGU5WDJlRFdGdjJ0NWpCUWdPcE8w?=
 =?utf-8?B?dUVkVytxRnlNMFk4OTlQbFR2MU5sSTVPZkJEckFJYUYzbUI1Wkg4emFXVnUw?=
 =?utf-8?B?K29HWnFoSjhtL0RSU0RXWDBibWRZUDNDZWlmQTl2bnYxcXBmME4vNU1QMlhQ?=
 =?utf-8?B?U1JkMFMzQWxyRjhxd1Z1d0FXeDVZZHdsamxtcllYeFY4eXc3SHdrLzB4WEow?=
 =?utf-8?B?R1pSdlRWNm0xT05LOFcyejNjWWEyeFRsMU9RbmJZVnZvNERzOTBVU3lvNmxG?=
 =?utf-8?B?N1l0SERSNUJnR2ZZQm1vdW1OZHB3VXg2MHpaNlR5UGZ3UGtzWkJHTjdtUjhx?=
 =?utf-8?B?SDM4TnhCMDZFdTBzK3d3S3dwQlRsbWZ3RjBpemZrdzJOeGtESjhwR0JVZDIy?=
 =?utf-8?B?OXE4RDhkNFN0TEJqUDJvZ0pZRm0wU0hLaTdyVW1hTFpEWlFYYi9WOCtrVkJS?=
 =?utf-8?B?T0hEM2FzNkZJM0NUd3FXWlprbVY3TTlzWURqczVpQTBnNno3WFY4Y2tQVEhI?=
 =?utf-8?B?TGVGakN5Vm5GWVpTT1pWSVdPRTI3d1dCOXpubHY2U1Y5NFpiVHE2Mzhmb01B?=
 =?utf-8?B?Z1NtZjNLRnlpd1Q3bHgvY281WW96SG9qMGhJY1hsRXlxV20wdW0vTkwwWUlJ?=
 =?utf-8?B?N2hjajNyQzRXdkl1SXVEa2E4eERxZEhUYTdjSy9DejZNSGFtVUhIWDl4WGN5?=
 =?utf-8?B?WGdFNzR6L240d2NTc0hTRkkraGZkaU5WMWhRL1VNcDRHM3NVVUplaWd3RFkv?=
 =?utf-8?B?UFNUR2RodUhWRVZST0pQVnZKYkdma2FaOEpMbHhzUHl3NDVyL2NQL0Z1Y1RX?=
 =?utf-8?B?S0NjUTNFbk5jVzh4MGFkRU51MEVBbVZiSnpPUEYrTEVYTVJUbFhJaGpaSzlV?=
 =?utf-8?B?ZU5zenFqcnAvb1dFNVVFVDIramsyWEx0cXNjaFVSbU5nYzZWbXZpcXRTdk9w?=
 =?utf-8?B?SWQyT0NWczBxSVRaaU03NnZHbnZuakdaT09UeE1uRVJLZGhtQ1NrUU9DdEwx?=
 =?utf-8?B?VmZCaDZDbDVzZzFvSWxMSDNUdkQyNlFKOU9wYi9iS0dBS1JMQWZtVWdjblAx?=
 =?utf-8?B?UXVQdlBuT2pFZ3hBSGF6OHdwdDVKKzJod2h6bDM0TWlVVUM2N3hKcTU2V2hk?=
 =?utf-8?B?ZWx3UGF5Qi9MMFltUktQWXNsS2hFWUhtVzY1c1F3SDV1c3lMeVdRWkV1WGxu?=
 =?utf-8?B?WWU2ZHZCd05yM0t5M1drSWE1NEZIQUZxOTRoWmRaaWVlTXYyd1dqMnUwWDdN?=
 =?utf-8?B?c0JuUjRGVlVVTk1UcUdXTTR3Y1RGMDdPL2ZjbFlHcUNXWjlqZ2MzNkttRWlp?=
 =?utf-8?B?b2pNenFZL3pGclAxYXlINkZ3TUV4ZFd3VW0wSzFpUjVuMEhiMnZqNE43c3Vz?=
 =?utf-8?B?ejdobGdwb3dSUlBoTjhyVDJWanFkNzgxMWc1TWxGQ1RyaFY2OTA5TDdtb0JH?=
 =?utf-8?B?a0tlZ0ozeDV4dDFyVW00N3dLZy9rck0wOGUrcFlzQmdaY24xNmdLd0xHL1Jo?=
 =?utf-8?B?czBuWnlXa29EY0VyRXRMeWw5NDJhQUtNSWN2emExaVVTZHBOUllWaytJaHYv?=
 =?utf-8?Q?BEF7x11OtKMZXm46BuPVNCwQB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a0c334-118d-4e7c-5b92-08ddb8b970fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 16:07:56.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1+1G84FFhdMQbplRy/DpRz617X4unadW3gl6ZbQOtF4zIOQxd1Y3MtxYvcCkvglLmyBwPLc3N+iomzfIp0n4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664


On 6/30/25 17:20, Jonathan Cameron wrote:
> Hi Dave,
>
>>> +/*
>>> + * Try to get a locked reference on a memdev's CXL port topology
>>> + * connection. Be careful to observe when cxl_mem_probe() has deposited
>>> + * a probe deferral awaiting the arrival of the CXL root driver.
>>> + */
>>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> Just focusing on this part.
>
>> Annotation of __acquires() is needed here to annotate that this function is taking multiple locks and keeping the locks.
> Messy because it's a conditional case and on error we never have
> a call marked __releases() so sparse may moan.
>
> In theory we have __cond_acquires() but I think the sparse tooling
> is still missing for that.
>
> One option is to hike the thing into a header as inline and use __acquire()
> in the appropriate places.  Then sparse can see the markings
> without problems.
>
> https://lore.kernel.org/all/20250305161652.GA18280@noisy.programming.kicks-ass.net/
>
> has some discussion on fixing the annotation issues around conditional locks
> for LLVM but for now I think we are still stuck.
>
> For the original __cond_acquires()
> https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/
>
> Linus posted sparse and kernel support but I think only the kernel bit merged
> as sparse is currently (I think) unmaintained.
>

Not sure what is the conclusion to this: should I do it or not?


I can not see the __acquires being used yet by cxl core so I wonder if 
this needs to be introduced only when new code is added or it should 
require a core revision for adding all required. I mean, those locks 
being used in other code parts but not "advertised" by __acquires, is 
not that a problem?


>>> +{
>>> +	struct cxl_port *endpoint;
>>> +	int rc = -ENXIO;
>>> +
>>> +	device_lock(&cxlmd->dev);
>>> +> +	endpoint = cxlmd->endpoint;
>>> +	if (!endpoint)
>>> +		goto err;
>>> +
>>> +	if (IS_ERR(endpoint)) {
>>> +		rc = PTR_ERR(endpoint);
>>> +		goto err;
>>> +	}
>>> +
>>> +	device_lock(&endpoint->dev);
>>> +	if (!endpoint->dev.driver)> +		goto err_endpoint;
>>> +
>>> +	return endpoint;
>>> +
>>> +err_endpoint:
>>> +	device_unlock(&endpoint->dev);
>>> +err:
>>> +	device_unlock(&cxlmd->dev);
>>> +	return ERR_PTR(rc);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_acquire_endpoint, "CXL");
>>> +
>>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>> And __releases() here to release the lock annotations
>>> +{
>>> +	device_unlock(&endpoint->dev);
>>> +	device_unlock(&cxlmd->dev);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_release_endpoint, "CXL");
>

