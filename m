Return-Path: <netdev+bounces-182232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2194A8848A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB681902BBA
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD701DDC3E;
	Mon, 14 Apr 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mnpsbyjd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1023D28D;
	Mon, 14 Apr 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638752; cv=fail; b=NkIGnrKVPccMm/y3Aw9pBYL3B8NxG/lIffiS8J4t0Uz+A1FKC79/6IMFXrcaDiK4rBAPmzUo28LEz0HicoWjNnMaMjuoa/IT1ULWlSxcsi4C1BW1anZbSPpxgr5fMM7lMhh0WZQsEVvGxv+8BGfdyG5A3o589hSxFP1R6rBYY2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638752; c=relaxed/simple;
	bh=ZWjFxUjM5+qdtqCjVMjKvXUx+2vxtkSsvweBREz0jNc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ucDKAq/x4wjgn7N2cbVx4qReR42hds+sDgLrnjc2Eh93MqWXVJz1iqiPsBNk32f9NkI8DlqvR1Wx3o+AqmOVu7nOCJYlhR34y3BSwRLNnd4JeOXy+ORPAtkyArXmhkMkLQLTTY9e3Vtl7FNPIgUq9O1e4dUup9ScDA+27xjTKSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mnpsbyjd; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxKmRYYTxj6sKW1F6FBhQGoMVRRvwjRDGuOYPL1ChtxQZXXxU8FTTGywsbe1N3LXXzeXDs4owX/8W+mfGlQcg1YKyUg8rsXUAzla/Po1J1sz4jVbk+tc2k4EXnoU0IlVlDkPQzEPwUxYkYzmcDwNZapTF70oZG9zf2oX50aLMgcWhPQM9Il7rxm0fWIC2zZE3ovvxXVDmc7kvZEVeP61ctn5Vy0eyF+Syt8RF8lBpSxWYjV6Z0aNB8GUBGnbJwRJuWT9AQT3oO5CuTMN0Rnn+5+3Dag54zqfFw/U40HEkOmSvQ07xp7Hjv0YoGLEWRNaW1YIVBwxQVU7D9rBRGG86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JvTYLcZQbUmTF/dD9eBolqMFiwohTsmVVVpzaISr50=;
 b=nC59Yu7wbQPSDpnpn1cFpWhypRkogyuKuN3qlBdp/znOEJmJ60d+CDoLkqpnEjlGkJ7GczK8AuRparc58+uUAppxAGsvX6/bpQpa3lAXoY62G0qQERK8fyvf2PB4QOwDpdEEuG2rhVoLzQPI6HFVERLN1hiNUEo4MmP9bxvqXj6fQAAW7DPYO5GvQ5JkJ+mMOTw68yUEDEH69s9OXB/DcGWjRx8bmX7O94NzEtmAD+8rIrk+C9uutzPsz8MpNdUVGKLdyXyfBdb277lScjpwJ9svDnoIsY5QQxLoYk/nQqtW++l+mUHmAO+t4X55DZ5NB1PjJ+4uP6OtgOKT3WTU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JvTYLcZQbUmTF/dD9eBolqMFiwohTsmVVVpzaISr50=;
 b=Mnpsbyjd8cpgZBAp5j290p7NUnAPSaoUlqTafdOkxHDwzmd8nb1dZFVdqFfGw8vHz3rD4Y9/F2bZJQG5j9MVscylIIEe8TdM3OJwI59E6j8PJBdYUiZO6Aetnuq7+mMt8bLZPf51Lg1cVODj8l9gTnt8204ql+hT0WMhZo/54Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 13:52:28 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 13:52:28 +0000
Message-ID: <b94407d9-6ae0-4b71-a8ec-2cf3ba612b36@amd.com>
Date: Mon, 14 Apr 2025 14:52:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 18/23] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-19-alejandro.lucero-palau@amd.com>
 <9913bfa1-c612-4b51-8b53-4b5449c8dd30@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <9913bfa1-c612-4b51-8b53-4b5449c8dd30@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0495.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: f29d551c-e823-41da-e238-08dd7b5b97df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2E5UUtWTlRJM1BWSjRNQkphSXUwUzVQYW9PTWwwellRWHlhQlpQZkhwT01Q?=
 =?utf-8?B?OTVub2tmbWY4NEZxZlpEU0YzNUpPajRFVEVvdkZkWXVYREp2d1BCNmgyZW5X?=
 =?utf-8?B?cDdkVDVMT3VuOXd1OXdUYmtKRFpjTzhoVDJZTkM0dVBjSkhvUGJrc0hEc1JU?=
 =?utf-8?B?TDNtUzZ6YjJLTUpGSkdxdjV0Y1dYRm1oTzNyUXNpcTNnNno5TE1McXkzYUY4?=
 =?utf-8?B?SEttTVpTMGxleFNxZEgyTDU4b05oUjJJS0taQmtEUyt2N1R2eWcxTUxDNGQv?=
 =?utf-8?B?VkVsOTBpQ0VnMkJtU3NLdE1VNXJYWjYwQlpYYTJJbUFqVDl0MjRMUHI4Z0VZ?=
 =?utf-8?B?WlczbzYwVHZ6UVVtYXN0cUJnNmlBcWxSb3QyVnY1UjBraDBYYSt2UVkvVU1a?=
 =?utf-8?B?RFdRUElJb1RoM084ZU9MZXovZEdoUVNZTVVlOW1mdTdLRWN2aXMyVmdtSyts?=
 =?utf-8?B?emdWWnFYbWVpWTQ1NVpsaEU0Qm9BbXBpK0xySVpsOS9ydkZYSkZLRVRnbXN0?=
 =?utf-8?B?QWFFS01oNm9FL29HbVdvTVplY1IvZVE2bzhKZDV5Z2JOWW1WUndKaEl6WUZI?=
 =?utf-8?B?RVFIeDBJVVFncE10LzJ3M2dUMzNEOFFHUjBBWGhVQmxGT2htWHNRL0xyZnNN?=
 =?utf-8?B?NW1PYkZpK2RydHVpTi96d2dzb0YwdDBObHlML2l2OE1TaDlBSzY1cHI2UHBV?=
 =?utf-8?B?N3d5MmcxcUNPWWNSRXBaVVFYaUtYazZUYkoxbEJRZ1ZSazhjcVRsTGtIaFBF?=
 =?utf-8?B?OXJNUFNsSFF0NUFjUFZray93ZXRUT0FNamt5VVFlOHl3b2VoQUk3dGpmcVUr?=
 =?utf-8?B?d3ZhVzBpRnZFV3RzM2phZStibDdXYWxJaHhTUEtmYmNiMWlSc25nblNKMzJH?=
 =?utf-8?B?MmEvVVZkNXRTOGs4TXdsS2FCSENQM0xZbUhOSElDdUZ1ZktpM1QxS1paYzcv?=
 =?utf-8?B?SDRGaDdEanRqdHFBTFVRejBXTWdSNXdxVERkYWYrb0dobmIxV1N6RzdFV2hP?=
 =?utf-8?B?U1ZrU1JiV0JiQkMwMVhwS09CWEpNREVQZnQ5VnhtbUhMU2FMcVlpTW9tSkcw?=
 =?utf-8?B?ajFCUWdDK2M3MXVCTkQxcElGUWVQeTYzU1pHTkhQQ2YyWi9OTUVBZkJHVGpT?=
 =?utf-8?B?T0RKOGJKSXEwa1Fydjh4bEhJYnlMQ01TTzBwRHBoSWVieCttUEJxL0NXMzg2?=
 =?utf-8?B?T1BCU2VDcW9NQkFFdXAzdE1oaVJIcXZ0MjZ6UitSMHYzZXE5R0Q0TnYvRkY0?=
 =?utf-8?B?NTdxR1hSY1JNMXc1S294Lys3V2JwdGF4OXFXVklRVG5XVUQ1Z3ZJZ2ZtQ0JM?=
 =?utf-8?B?MXRLMmxZWWhtbktoWThKRUVpSFRpWC9yRlhxZXVuVVJmZVdxNThidGFuaFZh?=
 =?utf-8?B?eXRpNXA4NGZnYzYxZzRDd29iN1pha1JjaWFqd0JvTzdVMm85TzNzMC9oNWtp?=
 =?utf-8?B?V0VxZXlwNk1xMHZZYXVvcGZNN2lZT2VoVzVuRmNIWWpORnZwejhra1lBejhQ?=
 =?utf-8?B?MHlERlczOTlOZ3FLTlRDVTlyMXl6RXpob3ljOHRmOE15VE96WFVJN2x0MmxG?=
 =?utf-8?B?WnhzcG01S0F3elFkWng5Q3R4cGU5VElJUERSQVFKd1ZpS2tqRG9TZUJPTDRs?=
 =?utf-8?B?VDg5czVkZFdyV29qV0FNUHpUcGNDcVM0dUJWb0c2Qk9EZmFpeFEzMzVIbkdw?=
 =?utf-8?B?bEdHT2NVRFRvN1FsUzFncHEybjJWM01UZVNrb2taa2VhSjI5eFpHcVJXcG45?=
 =?utf-8?B?dXVXL2Q0UmFzcnBDQmxtcW5DWlJKbnpFYVB5azZOWlJHQmtTbHY0SzZaZVZK?=
 =?utf-8?B?c0Q5TTlsYmZjSmEyU000MGVMUFBTR0IvbHFnejgyMVlBWWhqQW5EUnRPSS9W?=
 =?utf-8?B?ZUY4bG1iRm5uNkFLRzl2cnNVUm1VUTVxN1lnaVpreVF6QXBqWTlqdUR1WlRX?=
 =?utf-8?B?OTRhbkk2c3VqdFBSMXRwbi9DbCtvTFNMMDVKb3hJemlxWnFHU2o1UW1kZVFL?=
 =?utf-8?B?TkdidU1zTzRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVo5RERFVTFWbnRERnAwT1VYQWw2RzkwR3ozVmpiZVhlK28wd25GcGNkMGVk?=
 =?utf-8?B?OHV1NHMwWFBaVXN3OTd3Tkhpbjd1L1VsSFdneGZhMWlkaTRROVZZdDBEbWRt?=
 =?utf-8?B?VFFJdmFaL2lndHRtRUhWNno3ckZzc2VKS2szZzJleGUwUVVLTFdnZEE3VmQ1?=
 =?utf-8?B?Z0JmWEZPODFnNnJCTWNSanZLd0ozZTVzZmo4MVhqSlJEQXhYTTNRVXdTWEU4?=
 =?utf-8?B?di9WckdSc3M4MEk5ckpmcUFjUFN3SzU4Y29WRmM3WXpUQ3l6MjIydU9nbjJp?=
 =?utf-8?B?aFU4MWFNNTNxU2w2dkg5Z0d1ZmpQMHg5VkVTNWo3YVJwQUd1TWZBa3paT0tP?=
 =?utf-8?B?ZDhHN3dWMEZiRExtb3VLTjZzek03TTNmWVg4U3A2MHZRNklmb3kzYmtpT0V4?=
 =?utf-8?B?VFMvWllvbVNoZGs0eE9pN0ZLMDlRc0lGY2N5d3FZdVA2d2c1VjVuUndzdC9V?=
 =?utf-8?B?YUFIajNCbThZWk55ZnN1QmNhM2tBc0YwRGtUK0trOHBRWHBOSHc4MlphUi85?=
 =?utf-8?B?Zm4wR0FkSnRuczRsVUQ2RXhEY20vS0VTNWhmajRMSEVhWGtyOGhUT1BHRGhp?=
 =?utf-8?B?R2J3YXhwMkZWbGd6WnNVbXJiRk1wdjRad1A1MW1CQmlyRnVvQXlRb2haWHY0?=
 =?utf-8?B?bGxwYzA5Zkl0QVBrM0c0M3g3VUNrREdGcG9RM2Y1N2dEU1ZVZkcxZW1KaFZI?=
 =?utf-8?B?ODRKLythQ3hhUGJVWXpjY2pzRjBTREZTKzBBVFpnK1JCMHhRRHlKdWRUMzhx?=
 =?utf-8?B?L0JxelI2YmkrZXRpVWZiSW0xcWFqczFoa3F5RWhEMVNnTXc3eGpocEQzYXdq?=
 =?utf-8?B?UTVsbGF4bmZiZUQvUStMb0pacCtwYmdUM1ZmSDd2V0ErMnZGWEwxN0RvNG1B?=
 =?utf-8?B?Qng4M3p1QUY4YzZDcUVyVTl5dnM0Z29oOFFYOFhNMVRLYktNTExSMmluQkM2?=
 =?utf-8?B?VDdZWEFoVVFMVXUzOWlJYkhJektydE50Y0RINlYzVndXNGhuUVUyVXByenJB?=
 =?utf-8?B?d2VLNWcwQUFpQXB1MGp5WWJSMnF3OGdhUmlEWElOUDJHU3M2dnl2R00wdmd6?=
 =?utf-8?B?ZHNMWjlKK2NWR1NITmxRTlhjWm5tZ3hVV25CWGZsZnlvMS8yT1NveTlBYkp1?=
 =?utf-8?B?RllCaWg4S3FDRHFlL25NWGVWNVlLVkUwOFZ5R0Rsalhac0daSWtXOS95cGNa?=
 =?utf-8?B?cjRrcVgwclhvcndHNHhiak13OGhVTGVCZ054UjBnWDR4ZkhVejllZGlUbTh1?=
 =?utf-8?B?a2ZubStGU2lyR0paczQ3ZUhEbjU5SWVIb1RwUUhONTFXMnl5ZEw2blp6eFly?=
 =?utf-8?B?S2ZvYm5aMVVMR2x6ZW1wcmZLQjQwQXNYKzRXZ04wNHMvYmtVdjZ1QVlaTnh0?=
 =?utf-8?B?VHIwZDJ0TU5rVjYzMVoyNGRPYTdFKzdyOHpBZ08weHdnSzRpT2pnMU5VN2NO?=
 =?utf-8?B?UEtvM2Q5TVBiWHViU3MvVWZDbHBFWDJROTRyMzdnQzhaZVJTOGJzb1p1cmgy?=
 =?utf-8?B?SmxrQXg4VllaaDVXa3FSZlF0aktNS0lDWlVKTlJOazBWY09jMFo3dlhnaG42?=
 =?utf-8?B?SzVyblVEMDFXU3VrWGhJUkQ3d1Y0MWorVFZubTZyT3pOTlpEdE9HZVUvWEls?=
 =?utf-8?B?VWt0Y29GL0dzTFlZVU1UazF6UlZibjZmZmhudjB5bWNUUUZaM0szTkFBcUtR?=
 =?utf-8?B?cThsV01GY0ZtQk1IVFE3Q09TK3pNaGswUzczamduRnFFb3FxOFhnOFFsN3Q1?=
 =?utf-8?B?bC9PdXlQUlJFdXBvWko5cE1NUVdoOC9rNlBKSmo3RFZxVldmQ3VmN2ZpSW5G?=
 =?utf-8?B?ekVYTFB4a1AvK3VuOW1kazFqWXVLQ1hUdWw2eCtDcXEzaEU4VU1KSmRBOFRu?=
 =?utf-8?B?d0s3N3BCYVFKVGkrQmIzdjh6ckJmWEV2bTNqQUJmMHdvSVhLa2pkSDY4Yklp?=
 =?utf-8?B?S1hwTlVGUHJLOWU1ZjJVL1VvTlRhV040N0xEYUVsdk5JNEpDYjh1d3ovSEd1?=
 =?utf-8?B?OTlvdkFnazF1L1Uzem5Gb2drMmx2cmRySVdiQjY3aTNGak9hVnczNHcrV1NO?=
 =?utf-8?B?VVBsdHJNc1FsUFVEQTJMWkFFdCtNQldJN3o4VjBtZDJ4RWZDQndWVHp3WEdS?=
 =?utf-8?Q?64sNwuW37pFF05PWx+NVdgER8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29d551c-e823-41da-e238-08dd7b5b97df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:52:27.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlIpHt8CpUgqwGRr1rf6izADbHvs6ZIICs5jXl6T2Fv7eP6g3hrRYI+AESU0ZgMR6nqaiTr8OGDSvjbGJDNkdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039


On 4/12/25 00:18, Dave Jiang wrote:
>
> On 3/31/25 7:45 AM, alejandro.lucero-palau@amd.com wrote:


snip


>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	rc = cxl_region_attach(cxlr, cxled, 0);> +	up_read(&cxl_dpa_rwsem);
>> +> +	if (rc)
>> +		goto err;
> 	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
> 		rc = cxl_region_attach(cxlr, cxled, 0);
> 		if (rc)
> 			goto err;
> 	}
>

OK.


>
>> +
>> +	rc = cxl_region_decode_commit(cxlr);
>> +	if (rc)
>> +		goto err;
>> +
>> +	p->state = CXL_CONFIG_COMMIT;
>> +
>> +	return cxlr;
>> +err:
>> +	drop_region(cxlr);
>> +	return ERR_PTR(rc);
>> +}
>> +
>> +/**
>> + * cxl_create_region - Establish a region given an endpoint decoder
>> + * @cxlrd: root decoder to allocate HPA
>> + * @cxled: endpoint decoder with reserved DPA capacity
>> + * @ways: interleave ways required
>> + *
>> + * Returns a fully formed region in the commit state and attached to the
>> + * cxl_region driver.
>> + */
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder *cxled, int ways)
>> +{
>> +	struct cxl_region *cxlr;
>> +
>> +	mutex_lock(&cxlrd->range_lock);
>> +	cxlr = __construct_new_region(cxlrd, cxled, ways);> +	mutex_unlock(&cxlrd->range_lock);
>> +
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
> 	scoped_guard(mutex, &cxlrd->range_lock) {
> 		cxlr = __construct_new_region(cxlrd, cxled, ways);
> 		if (IS_ERR(cxlr))
> 			return cxlr;
> 	}
>
> DJ


OK.

Thanks



