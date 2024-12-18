Return-Path: <netdev+bounces-152850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598A39F6026
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C4E7A194F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979C415853C;
	Wed, 18 Dec 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bo6RaDe0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2E154C04;
	Wed, 18 Dec 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510770; cv=fail; b=PaymtBTXfDNby87fLktdEYfVcnmCbarkpVB0VzOhKQNWZ1cnwPNccDy7INrz6JCuTO4BCpdslLri/IDFjfWwBXMjdRFPZiTjVekGEfZ+KbZTSIKDxmMGt/q8fINBp8QLEbRWD72b0I7Rzi78uV5ah8jx4iuDzyr96MxBWhDLW/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510770; c=relaxed/simple;
	bh=FbeSP5EVMVENH0bsg86WdPrvD53zhmusUXCfnBxD2pc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qLEaennjy9gxQ20+ivvMgcxoZwgdPF8rpI51opEgoAMFscmvhvbscZqkUwtjjaGUnyAGhCLOvM16/4TkYkh2TXKk/YyZ2XknrtqBqw3VyzlYssgzMN4utFC2dAb5HovWjKrELNdZ0gyCL6g/d9qol4F9ojzQ8s7LMrllkg+pbu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bo6RaDe0; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9H9mvtbH9K8xHd/UFaxQDb+1GoHNyJF4RdUdYVq5p/wcQeVC49PYoBDVdBtw8dRiidlqG+xR5TJnv+foqYVWoAglj8IIYXKulVCNacJZJWtsNIPPSKc7vWpvyese/yafEsXpW3oOYCXvW0aeo2FmSAtgY0RhSW1a0YN8+39wubVTmsazI7+in4br/YkspXS2BKeXMAH+25Pdan1Et38NqvrbfQ8iefUMay+HwriCdS/uo+gZj7p9F5y5FPmh62fDaBMX7UCKYHU1ETpR6p5fqNJOrUCmSYAQLQywsi1fRWe8sELJZrVKHmJZpclp+7jpBaqLSAenksXNA5Ct92orw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBr8Eo1UTqEWMY+HEVVHD9x7BfjamdY+JbbAbejJqUw=;
 b=udsDj25UmXRihbOanbQ3KakNuPUWCyI8B6ks2H9EjL2ovOCQ9vhjJY/yhEoj0r5fU/CqHE8wXML+sq9Neulqjf1CKQNONGuoYil+HA9sne5NCGzxhAJxXMbL2zGCxkfFXgoiq2kx7SpwrPh/peXgAnTNKwpUuAWh0QPI4SFXexpku2kNwkr/duox2Y3xkTo5hbuwo/eoGriZg+wUW1PHZQ4ZibJ3f/WpttawlP7DbcOfXlfg/ofWDMO7fxvmmQ4xDQWtSB2emsmdfB13pW+ZFxc/s6MwYyN5NcyK2UG3jhS1QwqASABKVkh8ETJfPgVjt/A5rDlee3FOtpOezvTT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBr8Eo1UTqEWMY+HEVVHD9x7BfjamdY+JbbAbejJqUw=;
 b=bo6RaDe0de1JYENW+imuC5NWvut2dKo4IVotmUNDkU+F/sKKxFjtmHKAXXOYdsrCU/7VfApAiiMKKbAi4lerHRP8u/BfpDjADpKLE865+yIpGOLrPRSgXQIEOATA5OnD2Fb0zADteO7FztrGBeFCHsr3Er41qIAUHgmQp2p3+xQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 08:32:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 08:32:45 +0000
Message-ID: <616ec928-eed6-dd1d-496b-73c6794c102a@amd.com>
Date: Wed, 18 Dec 2024 08:32:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 27/27] sfc: support pio mapping based on cxl
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-28-alejandro.lucero-palau@amd.com>
 <20241217104726.GQ780307@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241217104726.GQ780307@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: faca9173-4337-4fb9-2e0b-08dd1f3e8c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmF3V3VVbTZwSy9xQ21kc2pabEN6NE5vZHpKQTFSZmM5NzMzNVdFVFVERkJl?=
 =?utf-8?B?T05RbUZ5VEg4bXcxZ3Q4MThLZWx2VkM2SVhHdHRMemxaamZWUnNGdzJKU3Rj?=
 =?utf-8?B?ZVo5cHhkdmJXR2xqdmM3Ui9RQjVIamR6WmtrTEdNbDBWcCtGUU5xQjVsNmY2?=
 =?utf-8?B?ZS93bFFPdS9Na3gyQTNUT3V5aEppcjBGUzI3QkFVZm1xdzRPR2pGdzJoMmE5?=
 =?utf-8?B?clVJeFU5ZWhmblE4bEV0Y2phZjgzbEhDcjFqaEh4S0N1L2lxN2dvaWlSbEt1?=
 =?utf-8?B?MGVzNFNmb0IrNnRrdWE5Z0xXQTE5d3dkbGF2Q0pyYkU4K1BXdHA5Q1BHcEdp?=
 =?utf-8?B?Kzg4T2s2dlpNSzlKMnVYaWRpVHFNaUZXc2Vhb040WWRtQVZsZE1MSGE1SFNF?=
 =?utf-8?B?ODhhVC8reHFlVUhXZjAvM3EyY2ZXSkdVSkpBZENYVVhKS2tJUi9NRS9iU1ht?=
 =?utf-8?B?NFdMTG9TMStDRXhiSEVIaVRPMmhoMURtaThlcUE1ZjY0YlF4bDFaL1IzeU9h?=
 =?utf-8?B?d1kyVWRwUkgyQ3pZcDV0TnpVai94dTZMMU5xSEY1Z2h2OWhEWjFIOXUvaGMz?=
 =?utf-8?B?L2UvWW1aSlVCNDlhTFBIVEtwOUQvc1AwYjRBdjU5WldXK0ZSRVhhc0JOTVVk?=
 =?utf-8?B?d01hMkZCL0U2WlVpQ2Q2cWpWK2cwMGc4RmtwS1dERkJybTJFUjZHVkV1QThD?=
 =?utf-8?B?Z0M4VUNCRlN1U3FIY0svekFQUng2cjhtc3NVWTdWVE1aUThqV2ZzczQyaGV4?=
 =?utf-8?B?NGhIeVpJRmhFdXlmTWJCRmdBckxEbDNFTFo2bzRaRGNDcWVGS1hWbk1ZT2xy?=
 =?utf-8?B?VzFTS016R2NrVXJsWHkwaElIUjIvbStBcGhNQUc3Wld2NFgvOW1YdW51THN3?=
 =?utf-8?B?clozcUlRYThWbzlTdW44UmdLaDdvaEFJelc2ekJha1ZLZ2xXbFZXV0VyWkhj?=
 =?utf-8?B?cnZjYnhMNnphVWRxRkJsYitOTTVjYmJzVy9mbHpMc01tVGhkM3FzQ3Rpdk5l?=
 =?utf-8?B?TmtFWkZvQWJvcHJyaHpwazdHYWVLdVo2R1hCUmhSNHk1L1R5TXNoMTRUMGdv?=
 =?utf-8?B?c2t0Y2dCbllvNzkzZ0F6SE5ybThvZjRZbFlISlROc3Ewb2dRVmpnMDRMTDBu?=
 =?utf-8?B?eThEMzdTcTZsVTZpNWJWT3lZWmh2RGx2SUJleE14L3ZnL1VoZHk3N2RDWlB1?=
 =?utf-8?B?VTFJQ0JMTEwxQmtmd0pSaXBHSFo5MzdDMnpjRnJVOE1NRExYZmF6ODIvRXRX?=
 =?utf-8?B?VHVmanRIMjZNZDhOdjA4MlliaUR2aEphUlhyZ0Z3QjdXVjd4QmFXaEM0ZmxZ?=
 =?utf-8?B?NUVvaVJJOTdLZXlCQWRML0duWWF5TFVadWNVYjRwaXJ1eFJUVWtaYWxrVjNR?=
 =?utf-8?B?clRFR3NEa0l2QitBSkZiTmlWNGtaY1lncUFKUlIzY3lNdG5uaVYzbXlnaFAz?=
 =?utf-8?B?R1ZKL01Wek9WQUFZdnQ1ZUdLMWUrckdNb3FUNEtLQ3JkNUlsb1ZUWU9YRm5D?=
 =?utf-8?B?VVpZUU9rYmV1QmhUVmJIK2V6R2lwbzQzRnpYVG5CcjYxQ2VXV0x3aGdqUDF0?=
 =?utf-8?B?Ynhha3MxbS92OUJqRzdhc29QbTlsb0tYQTlLK2RsRXVDeDNERVNFbkZaWlNt?=
 =?utf-8?B?UnZEdXBKb1FBcEpyUEY5VW00NlRla01HcEd2MHY1Nk5NYkt4dFN3MCtIelIy?=
 =?utf-8?B?TXRkVGRJQVFrNTI5UmNISWx1dGdWdnF0VjFaZnJlT1JjWUJpRXNlcHJ2NXpx?=
 =?utf-8?B?MlE0czBwcm9hQTNXeVF4MWpMeFY3aEwvZENsMjAxc3BYRENoZ1o0dE1IV2th?=
 =?utf-8?B?bUhDV2I1c0dYaE1MOUlhUk9oSHpBSUx4OU5kbWZTVHYrY2UzUUpRbGlFcENw?=
 =?utf-8?Q?swdNPXR9x7BWR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0FPY0NES29maHhsbVZLcGdjV3V4NFdFMkFQSWpEaWFtYmFnSlVxSGdCMlNW?=
 =?utf-8?B?UWR0ODdjdXErcTdmdlcvczRFdGJ1SktlbkRTemQ3cGpwUzV0dk1ibWpPTE51?=
 =?utf-8?B?Qk41UHF4cFhKQnJFcFltOFRNRDlKanhwTjB5akVmQ2VuMHdJaXoyQlhWZ29v?=
 =?utf-8?B?UHl5THZkbFVGSjR0bStJOVE2R0pwbllMQ1BPM2gweFMxWUxhSkNacG84dnhC?=
 =?utf-8?B?djBGeWFpcnJFeHR4UlNxQzZDZXpqZUVHYmtFcjhPSDEzZFVIb3VrdUs1Yi9U?=
 =?utf-8?B?R1pqbjJrSzJzRzR6VzFTMmE3WHpSczdWWkZBU0RuN1ZwRzZQY0FQUkRoOHZS?=
 =?utf-8?B?OXVmcHZMSjNKRWNWWjgzNzk3MFFWRTBYMko3clVyaGtYeXBES2FoTlhTVVpP?=
 =?utf-8?B?cStJcGhMU3RWTjBuRTBjby9XTyt4MlV0ZE8zd01VaXNNQTJTN0FNYlRmRXRF?=
 =?utf-8?B?TFd3d1AzT2I4eDBEMk1xVUJwMWFoQ1g4QjdrQmphaC9ETGNFczNUYTF2SFlp?=
 =?utf-8?B?bUNIR1lWbzRmTnRvTzV3QmJOQ3hId0NkYm5lNGhEcjRvd0FkNHA3RlMvRGZD?=
 =?utf-8?B?Q2hSYXhNQlZKRDVOcjdOQXl6b0dhUTFZUGhxeFAxMkFTOXRCLytTcmJZQTM2?=
 =?utf-8?B?elNybXhqMkhsc2NVYkpsenBsUkRIL1g4Mmx3cTY5YTFucUc5OWRaZUNSdkdO?=
 =?utf-8?B?cXpVMFY2M0hDSmRtaXJqYWEvNEUwZnYyNHpBRk1nK3BpYmErZFpSc0M2ZCtv?=
 =?utf-8?B?RktXbmcrS2lSV1N1K3dXUzlsRkQzWm53U3MvM3d3OWdEdUVFc0ZuUkNZcXlY?=
 =?utf-8?B?ODZMejBtcWpPUmFqRkFKYUJXNmIwd0ZqRHhQU05Gb1BYbjhyaEQ5ekFEUnBZ?=
 =?utf-8?B?VFpYclA2Q1B5aUpZekpEZ1dyeEJsajhCR0dQOHdxa3BpdXcrOXR2Q1FKZ21H?=
 =?utf-8?B?VHgvMStzMEt0UnBrVFB0Ynl2ZStMRnpyVEtubUJxYXVmUUZqam9MaWpUVE1V?=
 =?utf-8?B?aHpmMGltVDZQdnpIejdxQk5zNHNPc3ZkRnNzc1hWT054U2pTZWwzbG53ZHh4?=
 =?utf-8?B?RHBHUHVFZ1IyUngvYnpFWldFR0VnZjhBRWNySno0emtVbmNqa1Y1aGZTSWtX?=
 =?utf-8?B?Y3V6VkpFTTJWa2N1ZFFnNlNFa08vOUg2Q1FheXdNS3BaZXg0RVVaR3VGRkI2?=
 =?utf-8?B?N2NsOUVrUk1kSUxKbURMdkZUZGJJOE9BV0R3S05JeE0rQXJhcHRuQlpuWE1U?=
 =?utf-8?B?dzdhQXBpenF1clFPbFV0OC9zRlhqZkRSeTZrWkJKNHNGZFZpdVVMRzJsRHRj?=
 =?utf-8?B?T1dIT3FHTFlDdDBQbG9leUplRUpPQUkyUzhhc3JlenZiVTdLU2s3OFlTMHh5?=
 =?utf-8?B?MFFha0hSRkVGaDdyUUJ1NmVYVmdkWjhmRCtxL05UZ2VPY25IZlNabk1ZTVhw?=
 =?utf-8?B?TllMYlljUXZ5OW5admtXdTJOWmdNd0J3aGlTRzJjSmF3T3NiK014TUQ0Szk0?=
 =?utf-8?B?akZEOHBwekYxdUJDMFJPNFFIaEcxdHJKUVBOTFRFMWJYVDllQjZaWWJEQVhw?=
 =?utf-8?B?Vm9jekJGSWR4MjdMY3NldWo2U2FHdUpCWGFqS25oR3hLUEg5TlBPVHpqWmwy?=
 =?utf-8?B?MloveDdkaTA5a3lJZnRmTWNkbzJ5RzYxSytWWmpKcUdLMlgxSzBORkNPWGtG?=
 =?utf-8?B?cHl2TUVQczlBMXpiSVFvbS9YVEt5aTFpOVoxai9YdnA2SFA4cWo0NHpoK2c1?=
 =?utf-8?B?dDJLbkhrK3Z5YUxmQkUxQzllMmRpWk5BcDBaQTc5K3ArTHpjVlRwMUJ3Vkpy?=
 =?utf-8?B?eGd5K3dSa1pLcEJUWjhCclRGWUNaVHMwMXJkQ0duZHRINGw5c2R5aXR5Y0g5?=
 =?utf-8?B?bVc0WWtIenlER3p4MWxnL0N4UTZZeHZyNXJOcmRsYVVzN09Ock16UDRQcXo3?=
 =?utf-8?B?OXNoeXlJb2lzT1pDUEF5UTZYQUt2SEphWjRyVzlpT2UzaG1WSlpjWUI0Ym9K?=
 =?utf-8?B?VXBtNHFxNmhmREZLdjBzY1lYSUpMa2gxaW9wbUxBSStWNk13Mm9zcUw3Rkkx?=
 =?utf-8?B?SlNid1J2U1d5QXdWMkllQXBRZXE0VktmUnlwaXZYRGtDcnIvNm12N2JiT1pY?=
 =?utf-8?Q?1tm6sg2wCdOigOF5A1FEGRXON?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faca9173-4337-4fb9-2e0b-08dd1f3e8c13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 08:32:45.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5EXInHOy6K3ifnPgUtyefssBbmbyGJgg94eczZ5n7biSgr6jERcXnFxxczogsR3nZsW6xkELI9SgQUnvurrMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939


On 12/17/24 10:47, Simon Horman wrote:
> On Mon, Dec 16, 2024 at 04:10:42PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> ...
>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 7367ba28a40f..6eab6dfd7ebd 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -27,6 +27,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> +	struct range range;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -136,10 +137,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err_region;
>>   	}
>>   
>> +	rc = cxl_get_region_range(cxl->efx_region, &range);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL getting regions params failed");
>> +		goto err_region_params;
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start);
> nit: Smatch suggests that resource_size() may be used here.


Yes, I think so. The resource was not available in previous versions, 
then a requested change did not update this.

I will fix it.


>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) pfailed", &range);
> I think rc should be be set to an error value here.


Right. I'll add it.

Thanks!


> Also flagged by Smatch.
>
>> +		goto err_region_params;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>> +	probe_data->cxl_pio_initialised = true;
>>   
>>   	return 0;
>>   
>> +err_region_params:
>> +	cxl_accel_region_detach(cxl->cxled);
>>   err_region:
>>   	cxl_dpa_free(cxl->cxled);
>>   err_memdev:
> ...

