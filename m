Return-Path: <netdev+bounces-226222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2025AB9E451
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A6616B056
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725932DF15C;
	Thu, 25 Sep 2025 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JAgswC7h"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7549D2E9EC6;
	Thu, 25 Sep 2025 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791933; cv=fail; b=MmR7H9eo6OMAmCjKd1Gq3vwTj5GBBrD4fLYO4W49/Zv3RQojUFAbBpJGb+TkSVlevWXT7Wq/HizxBy5Ttjfe70cbmiacKbXtbN5WoBAfvstxx4zRRT2MT06j/95lRnUj7jITPrCUGqimZ3HLTpYQUOrjb2A7t3hEflwUfZu9zg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791933; c=relaxed/simple;
	bh=XLaSEPtwyTQoqaWW4FUySO2nGMXSS3h7TVpdMaoTRTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YX2CswXSqaPaf2nNkbt3FAAFoEplNdkP59LVbo6qSl6k2klNbZyW7F6scKe5OrTo2VrIKYZDZ/XNTDtxXZ8R6kOBZiNksEW/Yzfelnr/tYu97yLPrPAGIQIgH5A3HM66EHDcjAhJjwxj8oP9cW4N6GsKVQ5TC+7lJL73vJwRvZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JAgswC7h; arc=fail smtp.client-ip=40.93.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzW5o7C1ZRaVXLhorKfY/CiVJN9DpeJZzBoMzBYqEOsgrP8AmZA+S/Oyr3WGe54Jm+QPxKJl3SSpPHN1IZ+kGfSlvKvDR7/YnZ7G18kwvkyEUQx8kh+ZDadgJcBvAE6ziExQaBiOJL+P1CWQ58eLbAEziPohPjbLL7ZPeovAUuIYx421sx6l1IazI2HxjzoD6PpyRBU5eRovXphUeHRfdXjrWXm1pIE9PLRspdZ+u9GWgGRBOuASserzzVGR4KaJr0U6gchGTWMJYbOEWYBvh9oIpSWRwizST/CsP8/T5t6eX41HdgGFS0e1mqOBoIPAaCfOTPVnCpWL2pWzceEmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x/RPqEYknMGI67as4UwvVbkKapo/K/y9ImUADzZJNA=;
 b=ezGP41DMlny48C1xUuOK+26+Vgclw39iq9Y/p4xEy6nApvsNSo4/ByUQ8rxFLwIqDLUFHRilLHZnVnQgdND8turAwgpbDNCZjF7SrrBOAxVL9TRCqCyU1mBmJ+wqoh4BJJ5np+hOA1+AEj09rCvy4dcxSYFhQXR5rP38J/NLr+dUxMUp6z0BovnxRAwWRg0j5oy0kT5XF6Ev2l2ldzlnosdiP9r1MhPed7RWAUxhZkBgNKGQOHkdIAa71e5WeT+kT8Ko6y5iHNMsJU8pghASjDXRvshW583qN9VNMY+uwGRscE7nqzmYxEQ2SpOGsdOzdSLO32mM2b+CM5VKWjEPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x/RPqEYknMGI67as4UwvVbkKapo/K/y9ImUADzZJNA=;
 b=JAgswC7h4+vmoA4NBgazaPufrDQ2Nxi85lNmXspTCYj1YdQ7L4DcMf8SPojiRwyf0l6VglaZWEyjegZSh6T2SkvST5J9UY4X01Stku3JqGl/6ABuqonXPmmm3pF589Nl6RliLZSMIwzU6e/wVWdO9ahFYwpkIfXeIVH9j/uXXHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 09:18:48 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 09:18:48 +0000
Message-ID: <a779bb6d-b513-4325-8a8b-33b802d928fe@amd.com>
Date: Thu, 25 Sep 2025 10:18:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 11/20] cxl: Define a driver interface for DPA
 allocation
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-12-alejandro.lucero-palau@amd.com>
 <20250918155222.00003bdb@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250918155222.00003bdb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c18ba2-e39c-4e5e-9603-08ddfc1488aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmZkWnBpNytzZldZKytTM2RZYlFvVUxua2o1Q2F6RFV4cGdJWkRoRzVoc1Av?=
 =?utf-8?B?UG1jRUF4SStPdHNtYVFxSmNwSFM0azZYNUc2UVpOUDRyc1BPcVVmazJYQUNS?=
 =?utf-8?B?aitRK2FTenZLV2J1TzFrc252cmdJREs4dXN6L1ZSaENRTDFON2E3Um5melVI?=
 =?utf-8?B?bVZVTDlUanZYbFZHL0tId3BTZnBWaTRTcDlZT2Evd0VZNnRVYkdCVGdmUHZ2?=
 =?utf-8?B?eTVWU1BGUk5YZDZPeGxpR0RnSGI4M29ZNVdPOHF3YmNHbHF4ZlNOaTRtNXFS?=
 =?utf-8?B?Wjc3RHFuNWc3M2NXZnZ0VndXYnFGZXczZ3dHTVRhMFBOU0YxTXRSOTZmK2F1?=
 =?utf-8?B?dkkvU3Y3TFNMSjY4emJSMGxEaExUVjl4WGkvMTV2aUJYNXNiS2VnZ245WEtG?=
 =?utf-8?B?RllGcld3V1czamR2UnhkNlZ6MCtBVFIzQUIzaGRwSFA2aUYwMDB0NExoT0Zx?=
 =?utf-8?B?ZjVMWXY5anJUbjQweFNBR1ZwNSs3MVRzYXNsdXd5TE4xNlVlUHRxZ1A3Mk91?=
 =?utf-8?B?ejRFN0NlTVRIMFpnNy92YmtvQUhpbmFmU2t5R3FtMjM4YlIzbk1OVUJHLzdH?=
 =?utf-8?B?eXJWVUJxdnB1aHd1M2tvSW1NcHF2aGZlRk1aT29URUZyVEhoMWFTT3JTTFdV?=
 =?utf-8?B?a2ZaTGl3dWozSmxFS091Y0t0QS9CYVNmak5DZ1ZRekxENnY5WkZRaldRalM1?=
 =?utf-8?B?Sm9MQ0R0MS92a0pITDBXSG5ydHhwSCs0U1FIYTdONVpqbzdoOXk5U1orMDZD?=
 =?utf-8?B?aEtLK1lEZDBpc0llUEhBWDZjY2RRdlJtVjJjQ2hlNFF3ck1HQ011Ymk3bWt1?=
 =?utf-8?B?TFRVczRwa3RacnowMDZUMkZ5RTRpOWdnMWJsMkZUdGR0RjZKVHpuVklZUTJ3?=
 =?utf-8?B?cEpKaEFvUno1T1dHNmZEYlVxT0dSWiswN3FxcVIyRHk3WlZUeWlWZEE3d3Qx?=
 =?utf-8?B?Y2NDSS9ZekZkUE5HMWhoMHMrYm5DL2loNmsyOHBvTjVJSEhVMDY1THc1bFJn?=
 =?utf-8?B?aU9Ka3VIVjhzUUlvMC9NZ0EycndmZVpIYTUvWE1TUkltK0RsUTU0NUJWWXQ3?=
 =?utf-8?B?RmgxM2RITWdyUUFEeEcwWXJSSDVSUDJCMjdtNEJta2p1bE0wU0UzbE9YNmhq?=
 =?utf-8?B?TVVzbTFFNVFkY244aUgyWHVrdzY4QVVSM1paK0FBS2E1T2RVL0lvSjNPZjll?=
 =?utf-8?B?aXNQS1JtZk5iTlBSM0FlZFFWdFhCUnVzcHlNL3FscVlMVTMxbkkzbHVZTnhJ?=
 =?utf-8?B?OEpTR25LTlNQZVFLOWtDeDBSMXNnOHFYOWV2LzI5TG5Mdm9iQWlyV0JhSUNQ?=
 =?utf-8?B?L1pyd1pCYXVycFJoWGdyT3dZVTEzT3IvdnZNZ0VZSms1YVVrdjk4NlV1VnVR?=
 =?utf-8?B?VUtZcEJlak01ZWZtaFZvaWFBMXEvc0t5UGI3dFF2Ti9nVmRLeW1XOVkwUURi?=
 =?utf-8?B?dHhuT1lzQzhTWkQwRDAvTnNFV1FJbERsTG4xSWd1aENDU1NOOENMMThiYU8r?=
 =?utf-8?B?TFNOeXV5SVpFelBSR0s3M2MrVEFPQmIyVGQ3cjJ0b1pyUnJFZHIybStiMmtS?=
 =?utf-8?B?VHJCakZmVmRoQ3BiOWhXYlhRTm9QRHN2a09oTE9qaThpdk5qRE1LMjBNTXRY?=
 =?utf-8?B?NTVrMHR2d00ybnZlTC9WaFZpZTJqcjdlN0RFRERBY0x1KzVUTVpzdzRwSUlR?=
 =?utf-8?B?dGVuMlFhTFVmMHljQWxPeDFqdXpWd1dGQUVodzFsNTJJN1d3bE8wTTVOV0sy?=
 =?utf-8?B?Zk9VSEZXcWRuOEZWMHJkM1pkdmJES3lxdndtL2xlR0Yycng3OThJZENwN0lV?=
 =?utf-8?B?TVdHZlBQaTErTnk4WnRCSytKU1FSM2F3YlpsVENWM0p0QmhwUnI4a0pRbENR?=
 =?utf-8?B?UmdNOHJpZlpkdDZRczV6cHlaUzhITXN6T0pYMmI5ZlltWXhFeGFmaVlPWm1q?=
 =?utf-8?Q?YxA5VUUoVnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDlsREJaYXBVeHMxNFFMMmh2bUxzc0Fyakp3b0VmekR6SlBsQ0puUmIraUFl?=
 =?utf-8?B?cWx4RjlFbE9wMjVhWEdXaGI5QVVkdDlDMk41NSt5TFZyL09jNUZ1dThLN1Rj?=
 =?utf-8?B?MzlCVjVWcWxZZDJnQmV0SmJvTmcwRjEwdTRWT2k0NFFySElOdkxLbU5uajEv?=
 =?utf-8?B?bEtwbWpLZ210SzRXNTlMVzFJZ1JvUVM0b0FGVXJFcnJnNmIxelZKQkJjWk9O?=
 =?utf-8?B?MWRzNXJieExRY2dxSnhjVG9EWG9FQXRtZ1VETHFvbFhQbE54RThSZ2Z3ZUpo?=
 =?utf-8?B?T3VlRzhPRDV5T2w5UnczNy9pSlpDSWg5dnNzUVcyaUVWTmFyQ0sxTlIvUmU3?=
 =?utf-8?B?eGpIUSt3blFqRkRyenZyRzVRV0VnMmNUQVJMYnE3TDhDRXF2MWhnT0t3UTlZ?=
 =?utf-8?B?VWwwc0E2N1VmSDlqd1cwb2NSTG1RZWJqKy9hMWtab3l1YVV4ejZXanYyR0pH?=
 =?utf-8?B?dnV5dnRjR3dCQjg4N0Q1S2hYWmREaGJBai9ZQlJjTlptcWs1Qkl1Mjk5MzJU?=
 =?utf-8?B?SWl4Z2hvbXhOOHVocXlqQnRWei8vcTlidWI2bFNLdjRkUUdxcUJUdWViQ2ds?=
 =?utf-8?B?VFFCLzhGdGZ6R2dOZFZuSzdncnFUSEZQNVNVYUZVY1Bwd290Z3Z0UHlTTW1D?=
 =?utf-8?B?WTV6VWI4V0hIenVPNHFDSm8veXpPcWd5WXJOdDZzS0VuT0NFMkR2RVNKS1BL?=
 =?utf-8?B?UzJpSFhqaDN3VHVya1g4R1R0eHdmSmdJUFhxUU1IMjBXZlFzY3VyblVLRSt1?=
 =?utf-8?B?NVBZcC82U253RHNnS2pFejBBRTJuRXBIR1RTQ3ZMbGFDcDFGbVF4UnYvSE9O?=
 =?utf-8?B?Zkxhdlpxb0ZoVzBLblVRNFcyS0VVS2xoWmxCamkwTWVCV0swR0R3QXM4OTRW?=
 =?utf-8?B?TFd2dGdvN0VkQUQvdVBkMU9wdStnMlRpeVlleTRjQm1NSGNzTXBvOGRFRFZw?=
 =?utf-8?B?ZW1tSXJrQTd3MEZoZnpNRzZNeTVWWHRObEtFYmtlZGRpdDVyODBFQnNOK1dI?=
 =?utf-8?B?aXpSOUFCV1E2dUhDUHpiajZPTnh6Mk1vOEptWDZHb0k5NWFPZ2ZKZVFVZkFi?=
 =?utf-8?B?bTJjNHFBejRxV3NwK2JjNFJjTUNBbmhlOUNRUGdtdTlUZ0dlM2tZVVZXNE55?=
 =?utf-8?B?MVl5Y0dFV0d6QjB3QU54Tnlrck1LbkVZcnIvcStudWM0SmhtR2NqMGd1UGR1?=
 =?utf-8?B?c0YrNE9Lb1hyd2s5R0xoVk15Q0FXZjF5bytoNTlXUXdENEUyY1dNZ1hPeDVi?=
 =?utf-8?B?TkJBSGZLck1qbTFYWUNYSDlTRGZjeU55UTlFTWNSS1Zza25UL0llL3I2alc4?=
 =?utf-8?B?RWNBMVVtZWR5ZHlGZnpCcnA5SDE4ckNmeUc3K2Noa3JBd3Q0c2tQS3RGNDcw?=
 =?utf-8?B?TExvVHArV1NidFZ0eU5RTSt1RlZnclo3NkxoQzU4eTVZd0tUc2ZIcjhRV0Rp?=
 =?utf-8?B?RFBHWXQwV1o5c0VoWlhuMVFEaFY5MmtaYUtlUGJJaWRQcnFpVTE3SjliTlVM?=
 =?utf-8?B?bnIzRTdIZUhXLzhVWWFwWFZsbUlESFFhS0ZKd1ZkOHVDV0FoVUJUclZkZ2Fl?=
 =?utf-8?B?b0hvSDY3a2FQWXlwaWtXUkp5ZjYyem1kWkdvbzBIWW1UZEpXOWhFVlZJZm9p?=
 =?utf-8?B?b20xc1ZxNE1MS0dHSWNLOUE0c3BvbXdWb1EvR0xTcjFxMG9pNTB1bS9IdEVE?=
 =?utf-8?B?SzZrWVZFZDl3MjdPRHN1ZkRvOTR6UGJqTDYwdGVpaWExMTBaNmhhYlZkY1Jl?=
 =?utf-8?B?TmUyMklZdmlqMmpGcHFLMUFiUGFLeFgyTlo4VmY2YjhOQ2ZtVjhWb2prU2hK?=
 =?utf-8?B?aGpuU25HV3F2RDhBVUVCMzQzbWlKZlBGZVIyN0xFcWlQWEJYdEdEaGJLQmNh?=
 =?utf-8?B?dlNJLy8wdVcyWldvQmUyeFBFWGZNd2dRdCtjejVlTjlWd05uVWY2R2xXeW40?=
 =?utf-8?B?dFFOR3pYQythWlFtQzJzWFhFd1RoNmhONGN6MHJvKzBibUVSaitCdGFvNFc3?=
 =?utf-8?B?UU53aTBJbzdURndVNU5pRFVrLytIUDdxZmxjdWV0ZFpDZkFiVFRRZkZDYTQz?=
 =?utf-8?B?MmgrT2gvaGtoTjhHbTJvSkFWSlhRRnYvODNLUVQyWFVTMDdJakpocXJwT2dJ?=
 =?utf-8?Q?ir2PfsCUEbPsoxciZyH+rHXyQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c18ba2-e39c-4e5e-9603-08ddfc1488aa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:18:48.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUHPlrhWUOINYOc5MTNrNWZjlFjdnA+Ip4xJDmRTSvI6wkNGY0LmoPUCAIy3pY+9v/6Xl0zUNZ5zpG0+OgX94w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687


On 9/18/25 15:52, Jonathan Cameron wrote:
> On Thu, 18 Sep 2025 10:17:37 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space.
>>
>> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
>> that tries to allocate the DPA memory the driver requires to operate.The
>> memory requested should not be bigger than the max available HPA obtained
>> previously with cxl_get_hpa_freespace().
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @mode: DPA operation mode (ram vs pmem)
>> + * @alloc: dpa size required
>> + *
>> + * Returns a pointer to a cxl_endpoint_decoder struct or an error
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. The expectation is that @alloc is a driver known
>> + * value based on the device capacity but it could not be available
>> + * due to HPA constraints.
>> + *
>> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc)
>> +{
>> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
>> +					cxl_find_free_decoder(cxlmd);
> I've no idea where this style comes from. Local style in this file seems to be
> the more common (I think?)
> 	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
> 		cxl_find_free_decoder(cxlmd);


I'll fix it.


Thanks


>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(alloc, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (!cxled)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	rc = cxl_dpa_set_part(cxled, mode);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	return no_free_ptr(cxled);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
>

