Return-Path: <netdev+bounces-118906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2743A953780
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD321C25271
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4C91AE843;
	Thu, 15 Aug 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i2cMEqIv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44991ABEBC;
	Thu, 15 Aug 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736663; cv=fail; b=M795Ri9GN+Mk5m1QcGBNnBF68/PLUrdb4h3Nsw0Fosn+BKStjb9YJUtdvSt4iOuZ/BeYa3pf1qkxTtI/JZ1anvM1Kx0IZRwUk2pqZl4k2x2qzKHIfjEOvbVtc32zJs0WvMgO3xFVjlHGUAkmr3O1VOWvQGzB/DBhJ7TzjwBaYbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736663; c=relaxed/simple;
	bh=b5eUjJkatjoLSvmFobMLzFnsmU2gegYkUDJoVsGHVE0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eEC47hiIjlvNlbSPAX5QOHZR6v75laAWP0D/oumK9RbVyuBv72zCpYF2Jguxc+IOswIk7RR6s2nWIxPVGlqgI+At4WGve3l96JBtj79YefRuUzYZgWGWIbsalt6P0/llNaLodRs+8W7lJdCQSQ7bSz52FofeNMN8ObrobICdIXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i2cMEqIv; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVuE7ypk/vmD7Vt7f8KZ3aFtC91ZOV7fjd3NYirN81vFG1fWafgvH3LW3ljGiH9NhVHiIReuwlpNr/vOsDFaq4nkOmTMnOwaQ0aa4EpHmawO3EJ5ImWxpFUOJNZVLm59SS1/DYdI+ZGkz9ivRIPuJrYOuG0MsxqdPzHW6TfARbSLLIaAX16W2IxY5AbeOsuFuOsplS03bYWZk0/XUtFKW84loM2MaqiFZy2xJG318n81dt1HmiNikdT/xbtu0/SrqSJ7HUPb0VGiA/AU0NVZywTumH0Y8DzJab+FAjQD6Eg3NbbUVhRjhIRoDOQ/Iy7X/KUuGFwzX+njJEjIKLgV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CST+NsZQe74tHOjpkHi4Je4fI5rZNfelpgF1uDWLR5Q=;
 b=BhRzsXT4tIUNmSHOivO7vEBJTVv/IuHGFY2qWX2drrkN7SRouuyHGmqjD3aLh/vXMS27skxsi1vu+reQKJZsCYJgjKWCN8pRnOBAzr43Z+x94TkXiPqcJwtuTnTGBGB/0G29e3JOftbTZ+U54HqlrahrQ4PxR+F0fgMs/AoTcGEYCo0QjmVMHfsA1i6AqeKWUfSMwBuod4u0KwufYmAyoo3VDMst2FGlLxt0m4LKdJgc2tmm80TB4BJPmkPIoDBMF5GszJK2zC3YKTDlT+vTMCIiTNtwd+q8DEg9mPWxveJX0EpyRIL5rzTQAvl+XWYGWDkSr+zFiWPdf3b3seiuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CST+NsZQe74tHOjpkHi4Je4fI5rZNfelpgF1uDWLR5Q=;
 b=i2cMEqIvLXfVn/o81DCr21FRkaaNM4mc19ISL02qguUFdWGZUpKm2oH/aJRuocotZAUl6+xKATTH8EYzccAozJkYpTLU1hJn1jOJWoxKxJ95V/2YETuJVB0Pcd4ycSFNNCDis4uLxKpw58dTZzJvVdafDNylJ0n/klPs9MLTt0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 15:44:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 15:44:19 +0000
Message-ID: <087e4326-4473-9dda-d19b-6a3118f321c4@amd.com>
Date: Thu, 15 Aug 2024 16:43:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-5-alejandro.lucero-palau@amd.com>
 <20240804182232.000014b8@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804182232.000014b8@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb89313-f258-4034-4d68-08dcbd412030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWNPcXE2blNxUGtCa24wNE45OXh1d0NRYlpNSEt1b0E3bXQ1YjY3bXNndVVP?=
 =?utf-8?B?WVlnQkV5ckFidklUVUxXRFFBSGtqOVpUUTNNKzhMbllsTXlIbGNMaGhnbS9E?=
 =?utf-8?B?MlRTWlJLSDNoWW4vcks1eUM2b0tOWDJXUEs1TXErQjFSdytxUDFETjlyN0ZK?=
 =?utf-8?B?djU5cnNFanpCMG1lMURKanZ5Vko4NkU5c0MzWHFhOXlqS1NpK0MzbW92ck5k?=
 =?utf-8?B?ODMvUnI3UkpYRDdma3AzZG1TZ2p4Qk1DU3d5Y1BzVnJPdmRSblBwNW9kUlds?=
 =?utf-8?B?KzZsRzArcXYwcjdGSkprTGNEK0JZeGcyaElkeUJQS1VtZXVVMGNkMVJNdDln?=
 =?utf-8?B?Ni82VGE2SXlEbEZhNHFmSCtSZko2bnQ3ODJPOWtxcHJ6OFI0Qk9ZOGxZTjY0?=
 =?utf-8?B?dDdtcTRSMDFJbmRQdDFtYWtTVDRHMmF1WmtoWlcrMDR6bFI3aFhIM1RPVVVs?=
 =?utf-8?B?Q1hZSFV4VG52Z2ZYYTlsbjJyM2Y3Nnd1bEFvVk9wczNkbVpEMGFjSXBFdzFE?=
 =?utf-8?B?N2JlWVVWSVNFQ2RyQ2s0U3hKNnE5ZUdpZEcxOGFzZGNPWll3YmtWdjVqQllm?=
 =?utf-8?B?Zk93VU41WmRKUDFzb3VENUFqRFh6QkVYZmVuTFk0dnNjU2h5QnVKVzdBQ0ZG?=
 =?utf-8?B?Z2dNYWZ6V2tEaFdnRkhINlhUOFpnV3VyZmE1MWovYzBIWHFCSzNlcVVGN3pI?=
 =?utf-8?B?RElBRXBWKzRxREVZNFJrMU5SQmJWRFRaZEZaSUE2WnM1WFFKa0dmN1dxanhj?=
 =?utf-8?B?UlpQSFJJOWU3eHJnYUhvU0NpbG8yUkpSM1J2NThaUmhRR1RMZjB1allFZ0tD?=
 =?utf-8?B?MWJ3bDhCanVVNk5QVGJwN3dxVVVGWnlseVZnem1xWFdwNGd3Nk1QMk1FeDNx?=
 =?utf-8?B?cU1YcnQwTS9WbFVDK3U0NndlbHVzZU9KMS9KMHdWenJEcGVLMHRQMUxQV2VF?=
 =?utf-8?B?aGduVnZRenFrMDY1bHNHZlpzSUcxRFRLOTJxQkNWdG5CaG0ycVhoNDBUek96?=
 =?utf-8?B?cEFtazNEQm1WWVpHTWc3aVB3T1FqVHEvZ2pCaUVoaHZTRmpaUExrZ2NHdlBU?=
 =?utf-8?B?WFU3Wi9SZVI5alNJei9Mck10UVZGVVJFamxoUkVMQU1uM1FNTFJJa3dkTUQz?=
 =?utf-8?B?OFpwNjdwRW4rM09rclBkRUU5TXhLeDllK2x3bjFhWUNwRlowTHh3b2EzTmpP?=
 =?utf-8?B?Qks5b3J0M3d3Q2owQ3M5eERzN015RDV3dHZYSWVDdEhZSjlZZXdLb2RWYWJT?=
 =?utf-8?B?d3JHNlg2QWNLZU1ibmdxM0FPdWpCZExCQmJsQTQwUDFnQnVaelYvRVB4UFFx?=
 =?utf-8?B?eXlpUk8rUHBpV1VNUUxlUUdOSE8xT1pLckZhcldkWmxaa0ptQjlQelFZU3dw?=
 =?utf-8?B?MjJyNVl1UVFzMDBwbnBBRGVSVWRmYzRsdEgwcEs4NzZOS284ZFByZitWN0oz?=
 =?utf-8?B?alZVUi9JbWNHS2dTTWdwNlZUN0hzVE1NWW15R0lWc2EyQ3gxWk4wOEJmUTlC?=
 =?utf-8?B?elpUbVZOT2c3YzFuSElLVExUQWp1YzJNcUxsTFIzWWJXVFJiSzB5eEdOZmJm?=
 =?utf-8?B?RnFlWTFSZ0NtZk45Rk1hU3lnMGtqeUJmbEUyZ0U3SUxwZFEraVkwTFZtMW1I?=
 =?utf-8?B?UVVzTnM1d0ZSdTg3S2svYmVyRGxxSGJsYzg4QkNRY0M5Z3dId2R0QWVZQmZm?=
 =?utf-8?B?SmZIc3E2cFdWRUc0QmJWeUhudzJMZnNWNC9udUthc1pWeEYwTFlWUWNNTit3?=
 =?utf-8?B?T3crTU9mWmpiV2dGOXZRaVBHaUZOMGVteTRVRllCVURJTWtrRE96QWtYSWZp?=
 =?utf-8?B?eS94dERVRVVFMm8vaHVPZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTR5NVhsMmhBVjVvYXlhTHB6TVFCNXZaMjVpVUZIS3Q5UkRDYmFBK3VpTWRD?=
 =?utf-8?B?TC9ocndvcXVUWEswYWZNaktKOHVJaGNzZ1FkN05DUG9NdFpqOWV5UVQ5c1JT?=
 =?utf-8?B?MG9sOHVQL0J0LzB3YmhUSnJNR0RDWTVWTHlKZkhBM3FwSUswSjFXQ2w3N3Bu?=
 =?utf-8?B?TGRSZkVSUXhNdW14aXNmRVJtYnZGZVgxWUdhZkJEUnlmbGNkZldrUFJiL2g3?=
 =?utf-8?B?OC9JcWozVTN1akhsVVRMdUtORmJCbVpDdDNBU3NZSmxjVHdXUVNPcEM1SVQ1?=
 =?utf-8?B?VTVTTDdSNHN0Y0xCOC94WEsxMkdtMm9pT3E4UjNqdFhzb0N4TjZ6ZGU1bEdo?=
 =?utf-8?B?bXZhOTJJRTNSY09xOWNKZGloM0Z2eDdxNmFCT3BhdmtrK2xSQm1Jd0FiN0ha?=
 =?utf-8?B?ZldZQjJmc0J2UGEzS2hpK21GMEk2dll6VXZaSHRaV2VkMzE4K2FVY05WcDI3?=
 =?utf-8?B?VFBJTUZ4MTZ2b1REaENYM3R3NTRDb1lVVDNuc0FXajBlUExUSHd6YjVaeFgr?=
 =?utf-8?B?WEE2TjdINzI0VlZhU0d1a29sVGFtNXVKQ0x2L0Y1SEpYUXdIQUNKcGZSRXNZ?=
 =?utf-8?B?NjRxTkUvYU8rZ2ZmRm12ejVnd09SeWRMNTFhM1lPQnBIdEI3MUlLZWpPUms5?=
 =?utf-8?B?OTRYdzlMeEhUSGJ0ODcyY2NBYUdYeGF5WGowbUlJaXNZS0oxcXd2ZUxYWmlB?=
 =?utf-8?B?bFlSc2d6b3JSWWtRc3pyWnBZNFBZblo5Vi9Vcy9BenRpQmVROVVLVmFWUGRU?=
 =?utf-8?B?emN2eTZacjB5dDAzRHZqT0hoZUNHY2l4UXRGYmFpckNGdTZnNEVPNGhlUGl2?=
 =?utf-8?B?dmtTQVplaXRNTVZ2bWQ3cE1oRU12dEZoNjIyakFvZ2tpV1ZzRnhKY3ZMUjVr?=
 =?utf-8?B?S0dTL2trWGQwUmw5VFYzRzhOL0xLYnRidVEvbjh4M09rRG1SZTI3SzkyUy9D?=
 =?utf-8?B?NU91S0V1OERCUkVQMlZ2eXRmN1hVWUZnVUV5N29NWlI2TjhJNEVhUXNmYlEx?=
 =?utf-8?B?UjlrY0MzSCtVbzNPL0tzdENsV1JRTE16T3lZYXdqVUhpWlJyb2NpZXhuanBm?=
 =?utf-8?B?V2JhVGdYaWpweGE3akdTcVNLNHdIb200K081b0YxRzBqUy9HMDRDdVhzbWJs?=
 =?utf-8?B?ZGI2NG1LNS83SWxTSFFjdEt6SDgzaG1GWEJtcncraXpma1padkdRZFhkWU5I?=
 =?utf-8?B?VEZ5NlVPQTJqc0tJVkJ5SHU4dlNJeksyaGpUNlBsSU4vZXpLTGE3b1Vhc1Vt?=
 =?utf-8?B?a3paQVRBUU53eTlVdy9PeUZDdlBEY1g3VnBESnF6YUJFcS9CcHQ0K0dFQ0Ro?=
 =?utf-8?B?UjFzaW1RTW9pOEhaYzFuYTlyNFAxZHZ4VFhOVHVFa2g3OE0xTlduZHBLZ0Vt?=
 =?utf-8?B?OHRTbmt3MVFBQnI4Nm9QRnRIYWc2Vm9VK1FTUFVMR24yZXlkYzJxNDNmKy9W?=
 =?utf-8?B?K0QybkE4aTA4a3dyeUc4a0ZZZndZOXZhaGxXeUp2MkE1MnhMclVWWFpmZWlp?=
 =?utf-8?B?Wm1pNU81RGtxRUpROWJEVi9DUlE5ZW9INGl4UmJLaWNQdnY4a2NQWXB1STRj?=
 =?utf-8?B?TXJoK1FKMlhxdmhZcDc4L1VHZWtxc0phdzRubXBZMkU2bnBXVlorelpwemNj?=
 =?utf-8?B?TUx4R1BkSkV2Y0FFYVN2R0Fkd2Z5VjJTVy9ZWkcwN1VLdmw5eEQ0WjlaRnd5?=
 =?utf-8?B?bGtMdnhndElxTXVsMElRc3JieDVZMVRHTXAwd2ZKeGVjcUNpbk1RTk45RlFF?=
 =?utf-8?B?dFQ0V0x6c094QVlxcU16YkVPb0tKTDAxaHRJSHlVZWErc1FxYVgvNDZYaUtD?=
 =?utf-8?B?M1JwcmJTT2pkL2QvUmJUQVlIQzJlWDREb05sams3am52a2dsb2hqWWs4bFVF?=
 =?utf-8?B?ekU1VEczS2FucDZDWks2ekVuUCtUSi8wMU9NR3RscVpKMjNwb1pIM3FQM1ZY?=
 =?utf-8?B?dW00TGh3eXZ0RmpMd1dUWi9LS3ZaczRNNzNxVnJkODZ6cnEzYldualJXeUlF?=
 =?utf-8?B?M1lpQ3lNS2psUmpGL1c4UG5PcStHT0NPelk0aVpOazFCRVZBTmRZY2l1VTlu?=
 =?utf-8?B?bWNGMld1Y0l5V3BlbEU1a3BmcWpxVnFUT2xTQzFXempUa2dCdXJYbUdtMkNw?=
 =?utf-8?Q?pt+g8Q1vgIFPEUr3aTW0ATMX6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb89313-f258-4034-4d68-08dcbd412030
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:44:19.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTyqovjaWaIkUbXl6gF9pIhNzzhK3ik2w2QDbFPq+A1+CRXp7dC54s1qf81UtCFCxnoFggFcypf7X0sw3Rpb/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470


On 8/4/24 18:22, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:24 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type2 devices have some Type3 functionalities as optional like an mbox
>> or an hdm decoder, and CXL core needs a way to know what a CXL accelerator
>> implements.
>>
>> Add a new field for keeping device capabilities to be initialised by
>> Type2 drivers. Advertise all those capabilities for Type3.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> In general seems a reasonable approach, so just minor comments.
>
>> ---
>>   drivers/cxl/core/mbox.c            |  1 +
>>   drivers/cxl/core/memdev.c          |  4 +++-
>>   drivers/cxl/core/port.c            |  2 +-
>>   drivers/cxl/core/regs.c            | 11 ++++++-----
>>   drivers/cxl/cxl.h                  |  2 +-
>>   drivers/cxl/cxlmem.h               |  4 ++++
>>   drivers/cxl/pci.c                  | 15 +++++++++------
>>   drivers/net/ethernet/sfc/efx_cxl.c |  3 ++-
>>   include/linux/cxl_accel_mem.h      |  5 ++++-
>>   9 files changed, 31 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 2626f3fff201..2ba7d36e3f38 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1424,6 +1424,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>>   	mds->cxlds.reg_map.host = dev;
>>   	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>>   	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>> +	mds->cxlds.capabilities = CXL_DRIVER_CAP_HDM | CXL_DRIVER_CAP_MBOX;
> Add a reference for this perhaps.  Make it clear that a type3 device must
> support mailbox and hdm by pointing at requirement for the various structures
> in a spec reference.
>

I think it would be worth to have documentation, distilling out 
dis-ambiguities from the specs about mandatory/optional registers.


>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index af8169ccdbc0..8f2a820bd92d 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -405,6 +405,9 @@ struct cxl_dpa_perf {
>>   	int qos_class;
>>   };
>>   
>> +#define CXL_DRIVER_CAP_HDM	0x1
>> +#define CXL_DRIVER_CAP_MBOX	0x2
>> +
> Enum and BIT() for the defines.  Avoids someone in future
> thinking they can define 0x3 to be something.
>
> Definitely only one definition as well. Seems reasonable for
> this to be CXL wide.
>

OK.

Thanks!


>>   /**
>>    * struct cxl_dev_state - The driver device state
>>    *
>> @@ -438,6 +441,7 @@ struct cxl_dev_state {
>>   	struct resource ram_res;
>>   	u64 serial;
>>   	enum cxl_devtype type;
>> +	uint8_t capabilities;
>>   };

