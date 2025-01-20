Return-Path: <netdev+bounces-159788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D9A16E82
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3587A07F4
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6741E3786;
	Mon, 20 Jan 2025 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3xoxGNJO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB371E0E08;
	Mon, 20 Jan 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737383749; cv=fail; b=esKept5QUruWf4DtaRVMLQlMpPY0yo2bdGP9Vm24/oNizznZZJ6XF+7aD8zAnwmFrioTFqyu7tZ0MtSBAe5UxchqAXPhNbG0HqK0E7lzeJRP0PclTxdR16CpDXqZgWChqD3jMBQzU2S0+5YB7mXjJhjmvau57uHOdppkUABVhGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737383749; c=relaxed/simple;
	bh=RJl2cqqMZKKTk5zzfZcFsdWyMeJT2tMofycSa0TTxgI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KBGB6x9hnEy8vOQtRj8yL7LxLx/1jiJwkSBUSZVaCASyBJ7x3W2cGEIfuDDLQyCkC9bGGNbeBN2GC6wDYjLRuqirTqD1m6etZlXHeEInmunPqlvn9SxGlTFQl/LJpWMmxu/6EIHe+AC1Db6aLFciisZU+zqkHgz5bjZMTMgn/pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3xoxGNJO; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJuqvKr4HArgDpeYBSUAuEO+jb89nFNdn0aoGKRP78YrUVEcJfnuzj31PvLLcXkkZ3ekbvgVjFmCJTwq1/z73fSA91yny4tjgaztsBA2Ljp+cXI1Vm/qCgQ2PN5Wfi8lNXDXQNzrm7M4fB+sUK62mtv+PPGf0z35277npbN8XpCDSIsf0Uo6v3nlB+fFfs0tM+5U30ukvmzfsXhZm5oUzZNzWo9pUBxDrCj0XFPU50csPK01OTDHv1rCkGK1GHKQ32MFTkChNlckFImwj/eZ15U/d6Ha8C5VS8vqpIfgZKubMBD44FX7QYUbkIcK2iH5RJJInQEbdr3nSZbfndBY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubMiDw99UcyUlz3YQv0ziIs/ABKriRuym1nSdkBLZPg=;
 b=ohQSTVj1Dh2GvLlHFQHThVoVEn49BmEvdtBFW9X8b/BKw5pXoH/4cwnWwO1226mAuHLJxlcW3wMdYKGEX0ERLrXbndXe7yjQem9exJkTZMPj7GgsWxZSEOILlhri7W7HfN3pzU9MLFY2k7JJT0sbVR/ctdJ2T1gs0dZ45rUjoq3EBnDTWHfperXZkBhIIEJONPfFAzZ1opdLV/Sg1J9N9gCIe8zuZXKZsi9Zv02qnnV7jxdA8zstBulydYn/KDIkA3cjJ2RuyeOqrX96k8fShvQHnNubt4hVAV0uyoT+IKHI4g4kE49HwTrjJIoN2lMFzLt2GPyLuqHkp6qUn9KGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubMiDw99UcyUlz3YQv0ziIs/ABKriRuym1nSdkBLZPg=;
 b=3xoxGNJOMriRPW3Zv4ifz/dp6m/mHKTQEdx2KxEQgx/y5dHtXG/ji+ZKipgIiCEhpOVyPHkCBpm/HPtwDZJUnMrNj6DAejAkrSO/dKrbkCLqw8uaXwFIpneDwSao7gW/gSZUbClgXZdO7PVrZY4FOY6zb8KBGF5j6d5Bs7Adits=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 14:35:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 14:35:45 +0000
Message-ID: <7e395c6c-6922-53ab-b4d1-7453cfd9a86c@amd.com>
Date: Mon, 20 Jan 2025 14:35:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 02/27] sfc: add cxl support using new CXL API
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-3-alejandro.lucero-palau@amd.com>
 <678b043e3b876_20fa29423@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678b043e3b876_20fa29423@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0059.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::36) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d66c1c-9e4c-46c6-ec90-08dd395fb980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGFVWEJvSXkvS3pJQTZ3Z1JnT1d2N2QrWlkzOXlMeSs4bW11VTlWZ1ZuUWZH?=
 =?utf-8?B?RVNRWTRXZ2tVWTRnWGlVTUFKZHVueHIzZjN1UGRmYXhZWlg3Wms0WmVFbE03?=
 =?utf-8?B?NDUzZ0ppRFBmaWhGU3NWbFhrSDZGNVJZOE9qZ0p3R2RoMDlCd3U4MjE0YUpx?=
 =?utf-8?B?T3krR2ZxajdXS2xQMUx6VURjZVA4cTluUVBOazhJWUhGUDVwdGN0THNQd01G?=
 =?utf-8?B?UGU0VkZESm4vOWhTUkZsYThJUlZrWWJrOFZMZHMrUGpJSm1kWEoraWJaT1M2?=
 =?utf-8?B?U2UyRjF5WnhvQzBNT0R4SHZDUGVTbFFyZTYrTlA2RTVqaTJtcFZSYTJiKzE1?=
 =?utf-8?B?L0ZvbjBBeXFiWUdyY2lJUkIvdEdIeE9iN1RGZFo3L0xrcnBuMVJGV25WUGF6?=
 =?utf-8?B?Z0hFYVJWMVRSNmo1YXRjQ0dFd2VVcm9ubVVmcGFXdDFnbytiSEd6OVd0cW56?=
 =?utf-8?B?a09Cc3F3b0w4dGl4VEdkM2Z0c0VxaFA0dFRraTlKVjJRQUZ1VXZyZHZNY0d6?=
 =?utf-8?B?K2RZeUR3TG5QSko1ZGsycVZIMWJFcWZrNFlDNzZsblZYd0pYeWJZT0laQ0hO?=
 =?utf-8?B?UUJVVkFXS2ZyWjhNaEJTT2dSVENvNkxkZTNRWEpoQ2I1a0JTOEYyS3ZaOEND?=
 =?utf-8?B?YW85NFZqT3RwakNBdzM5R2E4bUFFdUlqWHRWbFN2ckpUMlhGTzBvWGhPREp5?=
 =?utf-8?B?RWtiQzc4Z2N0TzdENW9vZWkreDg2MEY3OVhpNllqL0daRmdSM1pmajFFdjBS?=
 =?utf-8?B?SXNLK2MvM2xoVlBmVUwyN21mSnp1U1MwYUROU01CK0tENXZ2SEhyS2lDd1lk?=
 =?utf-8?B?Z2d6bTRRb3lsU2JEOEFsVHFZSGpJcFdJU3ZMUmQwV1lVdmx6VHVOZEFrSDcr?=
 =?utf-8?B?c3VEaEZhM1VUazlib0FYbnNvc3Q1dnMyNS9Za0c1Q1JuWnpZdUJ0V1hIMG9p?=
 =?utf-8?B?MnMwK01QNVcyTStkSE0rRnNSRXhzSnZLTUJGbW04ekhtVksyU0QrdW9YdktT?=
 =?utf-8?B?UTJUbFVhQ0QrS3pwUEN5bTFRbVBnNlgwUGY5NWNIQ0Uzd2M2TjhaZzBNUHE2?=
 =?utf-8?B?NDhPUXVPV0RETGxwYWpBUEFjSHlxZlMxcjQ1MFhNbFh5bEpyU2d1dkZqNEho?=
 =?utf-8?B?UW5qaTdDaDZ0MTJiYm1JT05SRGo1V2cvUUtyamlTZFdLMXNsT0czbmx2aFY0?=
 =?utf-8?B?SzhYZmJzNlFwNzBuc28weFVEcnpDUVRqVitnU2RMenVWcng0YVVnNnY2SnZO?=
 =?utf-8?B?dU9aUnNWTTFXTFhjS1lvUVNub1NKU2VONHQ0RjVPbXFvNzlTWVN1WnVWemV3?=
 =?utf-8?B?TU44aUJvaVBQTi9RbXhNWWVDanN0bUhPM1QvOVNQMDUwcFVkS09DWEhBbGpB?=
 =?utf-8?B?TWpBUVhRZy9jNWx1ZnZxV0crbllwczgyZ0hxaUk3dkM1VUJkcmk3ZVV1dzBC?=
 =?utf-8?B?VlhJM0tmY2ZUbWJzY3hwRFhXdU9zanhEOEgwSldPU0N5cEVzVUtHR3NpMjRN?=
 =?utf-8?B?SEJ6bGI5NlAwU2dQSWVGWUZoeVJveDhTNFV0dENYanFiQkxkZGxCM2tjdGdO?=
 =?utf-8?B?bnlTcjhnc0ZJS25yR0t0Z044QzVHZkZLSjcyeWR5MElTQ0Z2elFxbGU1M0c5?=
 =?utf-8?B?ZllPbWFBNDJlNDRlUHZNcHc2cWlpZDI4MXV5SkpMcmU0RnhPQk1wbThySjRJ?=
 =?utf-8?B?eElqT3JWT3hwN1pxU0hFU2p0Rkl4VGtpVDBCSUJCZXBoR1VLNE82UFIrTHMv?=
 =?utf-8?B?K2xkS1dkUSs0MWFoZWhwMW5GandXbHdVVzc4N3Nxd3F4WjhtUnpOc0l2Q3FY?=
 =?utf-8?B?U0RLOEFiZ3RVakNNU1JSR1FEcE5MdzUza1ozU3VLNk83TSs4b3VCY3JkQ2Iw?=
 =?utf-8?Q?w/uEnVEmn4+MO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmpLRGdXTWliNXZDZGZwZzBzMk02NXVnL3ViMkZISEhMalE4ZDd1UjZNMVVX?=
 =?utf-8?B?dU15bnRZRXFqTTc1dDFLdUNlVEM0M2xPU3FST0ZsZ1gwV0NXd1g0bE9sQmd3?=
 =?utf-8?B?Vks0UGFtMDM1dldsbnBydEg3UXJPYTVqbHlvRXBQL0dQcVVvUWRDR25rL1FV?=
 =?utf-8?B?U2d6NHh4cFhDRCt1c3R6WjZwRFYwN2ZvajFncDExaG9VelgvdWEvMVMwMFNz?=
 =?utf-8?B?WEE2alQvRFRwbDJBT1ZtNHJPZTZIdUdEZ1RwRG0rYVV2UHJzUjdTbFBNQjhn?=
 =?utf-8?B?S3VYQXlkYmRreWlXaWpMT3VHNUIyOTN6RFN5bGpKZmpSN0JseEMwTkhVYnBq?=
 =?utf-8?B?aUN1dkQ5bGFha2hscmQ2ODVubmRGN1owWjVhT0JKMktVRk5ZZmRBK3Z5M3FV?=
 =?utf-8?B?Ynd5Ymx1M2VuQ28wc3dWdGZ0aHpreG1UakRFK204M2lGMDZUOXBLdlNrTnRN?=
 =?utf-8?B?SlBaamhQeTJqRWVTRWVwaU9sdUU0ZlVIY3FYV0c4QUE2dGV6RU03ZEQwWU5E?=
 =?utf-8?B?OCtEemJRSnRxYlM5TW5ZVitvOWZTck01MDFoTlpEbnVHRndPV25vNWsvYndu?=
 =?utf-8?B?dWxHeHhZbzdSWjJEdmNTbmc1WDJ1Y3lkaVR4VkEzbHFTQWE5Wjd3VTQxUHho?=
 =?utf-8?B?YmdpMlFJbjBnR3cyNHJDWVIybFlKeGlXOWhEWnF3NW1SM0hpK2s0Y21Odjh4?=
 =?utf-8?B?QisycnNwVStOVlE5S3U5WnM3QURRelVROGFiOXdaYUlkV1dMVENNZHVPZ3FZ?=
 =?utf-8?B?ZVU4enVDK0gvMkQzQVBqdXRqY1E5NFMzeG9iNHl3ay9GN1l0eUZ2L2VPNEhX?=
 =?utf-8?B?TUJmZis2eTcrRnprV0tDWDhCUlI4Y0plWXdsV3dLL3FTSk5pSjRlaE0vZnZ4?=
 =?utf-8?B?Y2NOZjNVRmozWTBZRkRsWUMxNi9WY2dKL05tbTQvMWkzSlRCa2lteklVSVB1?=
 =?utf-8?B?b2VjeCt5NWdPdVpBVmVJYTluV0xUdDc2VEdiaWl4emVEamNmUitYS1IzN1l6?=
 =?utf-8?B?MytnemFvYVc2R1UrN01HM2gxRExsVmllUWJEaXJCTVFUZzFKK1o0MDAxaEcv?=
 =?utf-8?B?M0M5R2pqWnhEMk1EQTJYb0F6ZnhKanYxd2poeW5UdkNFSCtDQlo4bGl3cFlz?=
 =?utf-8?B?d2YvaXVkelRtd1lEUTBLV1g1TXdDcXEvRE0yeWFQMzJnMFhrYmdZT3IzZUhH?=
 =?utf-8?B?eVJGemd6SXVVUWlBWFg0Rm9rVE9Da1UwK21DM3ZZaUtNa2VWVkh6cGdRT2FG?=
 =?utf-8?B?ekFPR2NWV2V0NGVqTDNJODZheUZ5T1hMNEZ2dmlwYUx4c0NiUStMVjdpUnhH?=
 =?utf-8?B?M2dmKzdLWFEvdDltZ2NwYXZaM29lOE10b0ZuenVhdTdQcGhFNGc3WStLbnFZ?=
 =?utf-8?B?QmUwMi9PS0NEbkluVTZYQ29taW5LMVJVcGtwTzY5SlpzbmdUMVE2bXNqb2dD?=
 =?utf-8?B?NCs4Sm1QdjJyV2s5bFhyOERNN21JZWh4VFBRYXJReERuWDRyVTJLakdVb0Vh?=
 =?utf-8?B?YW8wb3JiU0xwVWhkYmM5RkIzOEsvRUxQWEtEcWpUbUJ3UHMrVWxlYjZFUkZS?=
 =?utf-8?B?cFR3endNMnZScFVNMzlmVDhWU0s5dG9hZFo4QzZVOW9jSHkyZTR5ZmZiUGpR?=
 =?utf-8?B?SHJaQzc1TTZYWkRnai9jdWRpV0pRWVM1OElLcjN6d0FYeXNLeElNdldONEFk?=
 =?utf-8?B?Sms5OW1LdENoV3loRURDeHY5WGo1cU4rUXYvTTcwZWRCV2xMd0hoTjN1KzNV?=
 =?utf-8?B?WTRvb3pPMXdSMnZ0U2JWREpReHUvVWJjWG1tbEpYbUljUmdSMGdra0djU2xz?=
 =?utf-8?B?Z05lZUhFNjQwZEdaaVZSWDE3Kytabnl0c0tuVlNMR0duRjVWeW9IQ1JwN3VC?=
 =?utf-8?B?NUhubllTT2RTZjg3c0orQlUxS2FnZyswWG9WbUtpb0RISHdOWXpQS1hNOCtT?=
 =?utf-8?B?UG5TRzh1dW1HSjd3WDlwazdiZEZQenRhb2VmSUtxbTBpTDlWRVIyMVFpb3d5?=
 =?utf-8?B?SGdzZWFxMVFhKzhXMDNHVkdUQ0JmVzgrYk5iV2F5V2xvQTd1Nm9rc1lNRWdJ?=
 =?utf-8?B?Tk1zME9EeTRhNHRqM2czL3pjTnFoZjhNcjBzNGVxbGV2eGMyQzA5RHpBMWVP?=
 =?utf-8?Q?OIgvzcy0NsJ/oHcg1hKJbN3tQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d66c1c-9e4c-46c6-ec90-08dd395fb980
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 14:35:45.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yK527g+BSyZJN/bG4+HVWEdPAnJLFlXjer9w1ECscwr+X2LQ6tnuP/DlIryXclIWgNh5SVAP7xcTjRBsSRoQtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149


On 1/18/25 01:30, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig      |  7 +++
>>   drivers/net/ethernet/sfc/Makefile     |  1 +
>>   drivers/net/ethernet/sfc/efx.c        | 23 ++++++-
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 86 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 34 +++++++++++
>>   drivers/net/ethernet/sfc/net_driver.h | 10 ++++
>>   6 files changed, 160 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> v9 did not pick up the comments I left on v8 of this patch:


That is because v9 was out before you commented in v8.

Those patches did not change from v8 to v9, so your comments are still 
valid.

I did apply the changes and they will be in v10.



> http://lore.kernel.org/677ddb432dafe_2aff429488@dwillia2-xfh.jf.intel.com.notmuch

