Return-Path: <netdev+bounces-121290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD98895C945
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 11:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29491C2230F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC208149C79;
	Fri, 23 Aug 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T9qYlQfb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A120DF4;
	Fri, 23 Aug 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405539; cv=fail; b=qeTAejYEoh9Bkr5NTksmw/LijlLAUx+hZAnX3HbpNphx2+tElQ2Gm8760w0cojK1eyl6wk7xYYCHCxoFO0YXggoVoZ9teQYk30NDxzy8yiegxj0F/X/HaPuD/kJpYGPAXt1Ky4yfjvpiFAyHJzOG0atpQt2z39s1lzO79wGM0yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405539; c=relaxed/simple;
	bh=puLksp6KTwzghydy+QavdoHx85OENfj6r4ARaNTHylQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DHqWxz0DYgI4iDaFsb9ll5wkSTsLtqwuSXCvOK35UE0UTeI6bbTWBFWngIjfMXPoXnXRUkrq1/g+x61DBBY/+9HBeLvqoW74Hbl8FwZC20SX9lesbjsybBRc/GOGXw+Wp4Y+O1BpzJaCobQxc+N8MtnJeiLxfWn5S2Mo+fcDTsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T9qYlQfb; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpu9AWsWBiw/PO40FdTP6iJZ3f73z+NW9/Xuu9Xgtm1YK+/vJpMkEigmtrULcyTBe9AdX6GQmRukiqyZP2zlLUF95FmJgfcwpJqZPdU6Hlqh3n/MyiepFr9OwgD9lFtIhuFNo3Jje2GC85vebZ5wlA/G2r2OIQHbLF25+XzTN+CiMqmfuVUFPXZhdAFZOkIOkW3lpGlQNVt5glsLpvhwJc9islzRGtV7vj8BgobQeMdiNH63m9k7kpHAaUyYSMKEyuCrve78JwHDkiotFgFGRrNJumQbG1pOgEEhE7PcdrURczl48lLRarDT778alLh8d3ydGI9WOFb1JPTeNiPx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbREYIddyPIsVD7V/hy8S3WreqTeFn6Pan/7VBeJqG8=;
 b=UmTp1AqdgZiqVgnJEeTQ7O9rkvkjhE6qFs/XMHdszMG0HpYtVrFXPjXK4I09DXM2HVeTCxqWBKvTlvKrtKzTVWzAkP8Jm9mliAnmuAkxRkl7eZwHj5DbqWUfOSea+COVXYsox8U3TG7kZR74Ykiny//OTj9Huj4DX1tPBf9JeDH9TapZfb16L1sHWLkOQ0JP4KybPvTKx6KPd5at56hHScZvZ5fG446LX/EIuuja5v9xQZKoPwNZnWKeGbAYIGzLCYiD/AxA4DlK4I+tbYG0NLhIhBVSWx+Pcb2r7oyKC7R6qQQlx/XgZaAmgk2aVTqrjeodNvk9rpdsKVr+h3oXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbREYIddyPIsVD7V/hy8S3WreqTeFn6Pan/7VBeJqG8=;
 b=T9qYlQfbyZyYW1MQyoXHUBJM0W1NTfb8Dkgq2DHKmO3n3B5GIRrxEGiMtVdAMSuNK/yKjuS7aks9dBx0zM2rv8JyVVemT3rwiYcaVsDH0yA2u5Vhi1/IsjW3fgsSfB7p0QNOINAUtGm+bU1YIwKDlE9vIkeIRNAb1YdGNvoI1FA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 09:32:14 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 09:32:14 +0000
Message-ID: <17e5cf38-39f2-4136-fe2e-6936d8f45633@amd.com>
Date: Fri, 23 Aug 2024 10:31:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/15] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com, targupta@nvidia.com,
 zhiwang@kernel.org
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-13-alejandro.lucero-palau@amd.com>
 <20240822161226.00001736.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240822161226.00001736.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0207.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9b9bf8-1313-4cab-8c9f-08dcc3567900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjAvS2U4dEk4cEp0d0ZzdkZyYkY0YkFyK3JtazZjSXljVnFDZ09PaVdFdHJX?=
 =?utf-8?B?K2FhdmJrNEhyaEZjc2UxaFE3SWtRYytDK2RCb1pvTmR5c2JmaTFML2Y1QnVX?=
 =?utf-8?B?bHIxT1ZpbHd1eGNNMStVWC8yUFd3K0tGSXA0aHc3QXY2cmRwS2VuZEtteVpT?=
 =?utf-8?B?cUVwMnR2cnZwcDNvMUNFVTlpbzJrTUsvcGE0NksrRTBWMFY0UHZ1eFlUajAv?=
 =?utf-8?B?bi92cUJuN2Q3WmZ0a21UazF6OHd1RWZBbHV4eWNreTlLbjlrWjFPam4vNGdG?=
 =?utf-8?B?bk1uaHdHMGNiM2JDVEVUMHdpOUZRWGk1eW1ma0NGdzYyTmwxejVxZUxBYzF6?=
 =?utf-8?B?TXg2R3l3OURDOHpyTHJQT2w2OTY3R1d1MGRVN1VERElwNWp3TVh2Rk9xeDJo?=
 =?utf-8?B?dk9OeGRaU3QxNG10OVQ1aUZ5UHdwek9HY0kwZWFBTDIzeEpIVDh0dTdSWjcy?=
 =?utf-8?B?NmxhT1RjaHNOc2VKNFBaODM0MzI1U093RDE1K1Roc3BCUEhBUUV5cm1sRWxJ?=
 =?utf-8?B?aXdvNHE4bXNDVUtGdjUrdms3Y212ZXRGT29Wdk9wa3VLc1hNY1U1SktDU0p4?=
 =?utf-8?B?SHJtamZzRzhJcXg2Q01FS2plYmR2WFNHaklCcGhNTytpR2tBZjlOZjRXMys3?=
 =?utf-8?B?RlVjODN2WXRRZjdycDkxS1J6ajZCUHF6ZExrUlk0WmtjT1RVSi9kYlZLUFZo?=
 =?utf-8?B?QkdRZVoyOVhidGhCMlpmUWVrRi9ULzB0RWlLbFBUalJoc0JReW4xc3JKVVpy?=
 =?utf-8?B?THowZk9GdHZJY2lQbFYwRDlwVi9lWGs2NU80Z1J0U3YzSVI1VEdlR2hocmlt?=
 =?utf-8?B?WVdReG9MVVAzdkRhbGt6a1hnRFg1aG0vOE44bVFTN1pvSHhWL0p0aFpmSmdu?=
 =?utf-8?B?SUVzbHF5TVNRNGl4NEJWNGk0RWpHN0hNUzgzQ05nSzRmSFZNZE9sMDQ4ZHBN?=
 =?utf-8?B?L3plZUEzTjJUKzlDb0ttVGtGdlFIR0t0K29rZTZYRzlVcTVSZ09xVGlwa1Yy?=
 =?utf-8?B?dU9MSnl2aU9VMVR3ZW8xYjQ2Z1NyMm50ZFZGU1dmeUNvdy9za2VjUWs2QnhH?=
 =?utf-8?B?cjRlRFBmd2tvdkRKZnVGSU92YnNoQUU0Q0h0NmZDUkhhNUFGVDA3T0FUUkdk?=
 =?utf-8?B?WUJXclNYUFhOS05Yckl2YkFwYVh1ODZjdVZPOVdKNktVR1lsWVVaaTZJOTVa?=
 =?utf-8?B?aDRTaEJGTjRRR3lyL3lVK1l1TnNLMVBHZWxpZG41Q3hDeUpJQnFJaTg0cmVv?=
 =?utf-8?B?VE9qTWZoWUVHMVl1SU91cDNyWEhqcW50U2lJd0daWTA3ZmJxZmVWM0Zmcy95?=
 =?utf-8?B?ZE85SXJOZzgxakN5KzB2bGNxQ0hsSDdRYmE0RUFvVTQvZ2VBRzVBRE9Jd2kv?=
 =?utf-8?B?TmRVK0xFWE4xUmVzSElvVkxjblp5OFpLakRteGFPejZVZjJnTzUwckJUR1dv?=
 =?utf-8?B?VFhRcmZLa0FGTVZiNGdzdkVTOFljSVpjcUtPZXBzUjNPbjhUaTgzVm1aeVQ0?=
 =?utf-8?B?c2c4Vi9SQm5Beml0d3NQRkYrcHVMT3huZmJycWIvYWVZblcrNVE4T25RTno2?=
 =?utf-8?B?UE1ya2NpREdsZGppb2Jnd1c2dlphYXVHZEVKS3o2RUs0UHFhRXF4ZzBBYUJj?=
 =?utf-8?B?YzZhQ2NBMUNCWmZZYy9jZHJMUEdWQmhkRi9RRUdtbFJqNTRvN1UrZXhMaU9a?=
 =?utf-8?B?UHhQN0NoWlE0VkJlSmRmdjhGaGIzbS9DSXFpbktRUmR0bTRkTzNOcThmTTMr?=
 =?utf-8?Q?yTV9wYesCKHM5qLfIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXNXYXdFUmxSZnlsdFhnV2poekc2UWlSdmFaUERGT3hDejJpUnR1ZVpJbW52?=
 =?utf-8?B?VkhpU0RxbmlDcUU4YTNwb2F2RzIrRng1OXY4M2pma0RSbnZUbnIvQkoweVJX?=
 =?utf-8?B?STBSNWx3bjdoOFRNeUl2c1ZoK1RlRzVmSmJkTmRxNlpjOXNDRHIrVDJ4ckJZ?=
 =?utf-8?B?OGJCQ1ZWS050VmU3b2FsdVlWOHRWcE5xejY3RDNodTJTN3ZQR0I0T01sei9y?=
 =?utf-8?B?NWZzNGQyWG5Pak8yRjEyd3htdzVENUd6UDlKU3Fpd0pVcHNDck8zVHZhRVFv?=
 =?utf-8?B?VXgrMDlOL21LdzVtdm5NTnMxbFhPUld3bmQ4bFhVei9CbzRmZkpoQkJEVHNU?=
 =?utf-8?B?eGRZSmJpSXV6bmhVbEQyeWEyQlJqemtnd3FHb2Yyc2ZwMXo4dkZLWU9EUzNl?=
 =?utf-8?B?cjJ1Sm1mWkpuKzNOSDViSXJuSnNyNVQ4dlRvVGpwODNOeTV1RHRnakdTdXlE?=
 =?utf-8?B?OGdwNkMyNlRHcE1Ic1dTdnFsRFI2ZW1XZ0RzcHd4SjRCSmw3WVAyMm42WUJv?=
 =?utf-8?B?N0VUYUd5NG0weDJCZE14b2JvM2F2VjhQcVlWdko3N3RYb2hWNWdaS282WVJK?=
 =?utf-8?B?QVRDU2VadEdXRmd5WXBPVFkxb1dLd015VmlhdTlSTFdoTmxEOVhsOVU5dE04?=
 =?utf-8?B?S0F2c01tZEJzc0U4Q05ZTml4YzNmVG9rOGs3WWl5cjZyT0U4VEhRd2hBbS8z?=
 =?utf-8?B?T0J6dDFUUE1yK2RadmZvMDJic1M4VnVVVWhTZU43QXltNlhrVmxYcUE0UU9s?=
 =?utf-8?B?NW5rZ3JsMTJxVy9PUWlGQ2QyYmdyUVpwMzFiSUNGWU1jT0RJdnYxbHBmcTdh?=
 =?utf-8?B?S0c2OVpBL0FLd1VTRTZWenpCRGVRRE9tV0NxK0RjSDcrUFRhY2FHekFLR29Z?=
 =?utf-8?B?WkVEVmYvcmp2d2QrNHNmTTRaVUFkREJ2N2dyalVqZ0NadXF6UjVkVnBsZjFH?=
 =?utf-8?B?cXc3bU94RG9CUW5NTDVrQmxwMGYwUzFYSGFGM0ovTXZYT0piVlFTV3pUekl5?=
 =?utf-8?B?Qkc3cExQUis4SHlvdURUdVpubkZpODczWkcxQmt1a1cvNGRhcVhHVVUxenRp?=
 =?utf-8?B?blN6ZFlnNm5xcUdnQUNVZEhCTkxpTjVoalI1S1hCZkd6WFc0dTdHeldSODkv?=
 =?utf-8?B?TnJZZzlTYlN6MWxqalZYV0VuWEZSSE8zZ0oveWpmYUV2cmRnbitJQmlRTFkr?=
 =?utf-8?B?Myt5WWl5djI1TCtTR09uZURHMUc4dWlHYzZidlowbENWbERUUGZQcXp2K2lt?=
 =?utf-8?B?VW5qcGlma0ZyeVZ1MGxPRExoaFNjSXViOGlJODBBdnBweDdpNEp5cjVSUGFR?=
 =?utf-8?B?VHJSZm9ZbDRrYURjdWJrdXdRa0pBMGQ1Y3FlcmFSVVdyS2toQ3lJdDl2N2o0?=
 =?utf-8?B?dHZ6R2t2Y2lrZEJXaXZBajh3MGtkN3hYY0NaMmgvQW1OSmZ4czdUUHBGeFIx?=
 =?utf-8?B?Q1NSZUxjUjdyL3ZTSHgzcnBuVWlDai92K2pTdXJISnRBV211cnJBQi95eUdM?=
 =?utf-8?B?UDdYcC9GWE5EdXNETTQ2NjNMczFMU3VNSnNUbFVyckdCTTFqRkJSTTNRc2ha?=
 =?utf-8?B?RmxoWFVvT1ViYmdXKzJBY0FLMTRxSzhiTjdTVjloc3VDZjlOL0RHL0RCZEZn?=
 =?utf-8?B?Vmg2bVpPVkxsazZtOHl6cE80N3BOQzhSTk9ZeEdlNTg2WHRjQUhyenF6bnZD?=
 =?utf-8?B?N3A1NkQ4Z2VNOFJUemt0RDltbEZwYWNHakZza2cxZHNXNVRubUNkcWpWUGYz?=
 =?utf-8?B?NnlUWmMzRlBTUjY0Z0QzMzR6Nng3bjJJQkV3M0ZLMkEralp2Y2NTbGNabGlo?=
 =?utf-8?B?R3I3YncwaUFUaDg1QlJjNUtETSsrNDlHc1RzS3A4QnBpVG9WNERON2NpeFl5?=
 =?utf-8?B?VkRMTFBjeEZubFN6QllmTkpQdlQ0OHdJclN5c25ud2VhdVc3NTRWOWtsUGNr?=
 =?utf-8?B?TGRrdXZHdkpxZXl0RmtNNXl6L2hmTlp2YncyUWVEVWJZeU8wakxudlo2RGJ3?=
 =?utf-8?B?cEJ5VVFXTE5EeGJRZ3VsRVVVZFlvY2FZMGcrdUJ1Z1A0N2hQZ0d5YVlDSjht?=
 =?utf-8?B?dU5MdEVhRkR4cG9UcWFGc0FoSWpoaGU2cHgzaVhjUHFpekRZelhoUUFsMGE3?=
 =?utf-8?Q?wKo/T5Dn+/f5G+wR3GrZPvj1P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9b9bf8-1313-4cab-8c9f-08dcc3567900
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 09:32:14.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/eRjVMZlp/eq8bHfocbAUswOntjYMc6U1UL7c63xtVbsfGNIPnJvrEkhtiMxzYh3TBhlaolb6taINuaTUAXyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966


On 8/22/24 14:12, Zhi Wang wrote:
> On Mon, 15 Jul 2024 18:28:32 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Based on
>> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m84598b534cc5664f5bb31521ba6e41c7bc213758
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com> Signed-off-by: Dan
>> Williams <dan.j.williams@intel.com> ---
>>   drivers/cxl/core/region.c          | 265
>> ++++++++++++++++++++++------- drivers/cxl/cxl.h                  |
>> 1 + drivers/cxl/cxlmem.h               |   4 +-
>>   drivers/net/ethernet/sfc/efx_cxl.c |  15 +-
>>   include/linux/cxl_accel_mem.h      |   5 +
>>   5 files changed, 231 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 5cc71b8868bc..697c8df83a4b 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -479,22 +479,14 @@ static ssize_t interleave_ways_show(struct
>> device *dev,
>>   static const struct attribute_group
>> *get_cxl_region_target_group(void);
>> -static ssize_t interleave_ways_store(struct device *dev,
>> -				     struct device_attribute *attr,
>> -				     const char *buf, size_t len)
>> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>>   {
>> -	struct cxl_root_decoder *cxlrd =
>> to_cxl_root_decoder(dev->parent);
>> +	struct cxl_root_decoder *cxlrd =
>> to_cxl_root_decoder(cxlr->dev.parent); struct cxl_decoder *cxld =
>> &cxlrd->cxlsd.cxld;
>> -	struct cxl_region *cxlr = to_cxl_region(dev);
>>   	struct cxl_region_params *p = &cxlr->params;
>> -	unsigned int val, save;
>> -	int rc;
>> +	int save, rc;
>>   	u8 iw;
>>   
>> -	rc = kstrtouint(buf, 0, &val);
>> -	if (rc)
>> -		return rc;
>> -
>>   	rc = ways_to_eiw(val, &iw);
>>   	if (rc)
>>   		return rc;
>> @@ -509,25 +501,42 @@ static ssize_t interleave_ways_store(struct
>> device *dev, return -EINVAL;
>>   	}
>>   
>> -	rc = down_write_killable(&cxl_region_rwsem);
>> -	if (rc)
>> -		return rc;
>> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>> -		rc = -EBUSY;
>> -		goto out;
>> -	}
>> +	lockdep_assert_held_write(&cxl_region_rwsem);
>> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>> +		return -EBUSY;
>>   
>>   	save = p->interleave_ways;
>>   	p->interleave_ways = val;
>>   	rc = sysfs_update_group(&cxlr->dev.kobj,
>> get_cxl_region_target_group()); if (rc)
>>   		p->interleave_ways = save;
>> -out:
>> +
>> +	return rc;
>> +}
>> +
>> +static ssize_t interleave_ways_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t len)
>> +{
>> +	struct cxl_region *cxlr = to_cxl_region(dev);
>> +	unsigned int val;
>> +	int rc;
>> +
>> +	rc = kstrtouint(buf, 0, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = down_write_killable(&cxl_region_rwsem);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = set_interleave_ways(cxlr, val);
>>   	up_write(&cxl_region_rwsem);
>>   	if (rc)
>>   		return rc;
>>   	return len;
>>   }
>> +
>>   static DEVICE_ATTR_RW(interleave_ways);
>>   
>>   static ssize_t interleave_granularity_show(struct device *dev,
>> @@ -547,21 +556,14 @@ static ssize_t
>> interleave_granularity_show(struct device *dev, return rc;
>>   }
>>   
>> -static ssize_t interleave_granularity_store(struct device *dev,
>> -					    struct device_attribute
>> *attr,
>> -					    const char *buf, size_t
>> len) +static int set_interleave_granularity(struct cxl_region *cxlr,
>> int val) {
>> -	struct cxl_root_decoder *cxlrd =
>> to_cxl_root_decoder(dev->parent);
>> +	struct cxl_root_decoder *cxlrd =
>> to_cxl_root_decoder(cxlr->dev.parent); struct cxl_decoder *cxld =
>> &cxlrd->cxlsd.cxld;
>> -	struct cxl_region *cxlr = to_cxl_region(dev);
>>   	struct cxl_region_params *p = &cxlr->params;
>> -	int rc, val;
>> +	int rc;
>>   	u16 ig;
>>   
>> -	rc = kstrtoint(buf, 0, &val);
>> -	if (rc)
>> -		return rc;
>> -
>>   	rc = granularity_to_eig(val, &ig);
>>   	if (rc)
>>   		return rc;
>> @@ -577,21 +579,36 @@ static ssize_t
>> interleave_granularity_store(struct device *dev, if
>> (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
>> return -EINVAL;
>> +	lockdep_assert_held_write(&cxl_region_rwsem);
>> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>> +		return -EBUSY;
>> +
>> +	p->interleave_granularity = val;
>> +	return 0;
>> +}
>> +
>> +static ssize_t interleave_granularity_store(struct device *dev,
>> +					    struct device_attribute
>> *attr,
>> +					    const char *buf, size_t
>> len) +{
>> +	struct cxl_region *cxlr = to_cxl_region(dev);
>> +	int rc, val;
>> +
>> +	rc = kstrtoint(buf, 0, &val);
>> +	if (rc)
>> +		return rc;
>> +
>>   	rc = down_write_killable(&cxl_region_rwsem);
>>   	if (rc)
>>   		return rc;
>> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>> -		rc = -EBUSY;
>> -		goto out;
>> -	}
>>   
>> -	p->interleave_granularity = val;
>> -out:
>> +	rc = set_interleave_granularity(cxlr, val);
>>   	up_write(&cxl_region_rwsem);
>>   	if (rc)
>>   		return rc;
>>   	return len;
>>   }
>> +
>>   static DEVICE_ATTR_RW(interleave_granularity);
>>   
>>   static ssize_t resource_show(struct device *dev, struct
>> device_attribute *attr, @@ -2193,7 +2210,7 @@ static int
>> cxl_region_attach(struct cxl_region *cxlr, return 0;
>>   }
>>   
>> -static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>> +int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
>>   	struct cxl_region *cxlr = cxled->cxld.region;
>> @@ -2252,6 +2269,7 @@ static int cxl_region_detach(struct
>> cxl_endpoint_decoder *cxled) put_device(&cxlr->dev);
>>   	return rc;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_region_detach, CXL);
>>   
>>   void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>>   {
>> @@ -2746,6 +2764,14 @@ cxl_find_region_by_name(struct
>> cxl_root_decoder *cxlrd, const char *name) return
>> to_cxl_region(region_dev); }
>>   
>> +static void drop_region(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_root_decoder *cxlrd =
>> to_cxl_root_decoder(cxlr->dev.parent);
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +
>> +	devm_release_action(port->uport_dev, unregister_region,
>> cxlr); +}
>> +
>>   static ssize_t delete_region_store(struct device *dev,
>>   				   struct device_attribute *attr,
>>   				   const char *buf, size_t len)
>> @@ -3353,17 +3379,18 @@ static int match_region_by_range(struct
>> device *dev, void *data) return rc;
>>   }
>>   
>> -/* Establish an empty region covering the given HPA range */
>> -static struct cxl_region *construct_region(struct cxl_root_decoder
>> *cxlrd,
>> -					   struct
>> cxl_endpoint_decoder *cxled) +static void construct_region_end(void)
>> +{
>> +	up_write(&cxl_region_rwsem);
>> +}
>> +
>> +static struct cxl_region *construct_region_begin(struct
>> cxl_root_decoder *cxlrd,
>> +						 struct
>> cxl_endpoint_decoder *cxled) {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> -	struct range *hpa = &cxled->cxld.hpa_range;
>>   	struct cxl_region_params *p;
>>   	struct cxl_region *cxlr;
>> -	struct resource *res;
>> -	int rc;
>> +	int err = 0;
>>   
>>   	do {
>>   		cxlr = __create_region(cxlrd, cxled->mode,
>> @@ -3372,8 +3399,7 @@ static struct cxl_region
>> *construct_region(struct cxl_root_decoder *cxlrd, } while
>> (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>   	if (IS_ERR(cxlr)) {
>> -		dev_err(cxlmd->dev.parent,
>> -			"%s:%s: %s failed assign region: %ld\n",
>> +		dev_err(cxlmd->dev.parent,"%s:%s: %s failed assign
>> region: %ld\n", dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__, PTR_ERR(cxlr));
>>   		return cxlr;
>> @@ -3383,23 +3409,47 @@ static struct cxl_region
>> *construct_region(struct cxl_root_decoder *cxlrd, p = &cxlr->params;
>>   	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>>   		dev_err(cxlmd->dev.parent,
>> -			"%s:%s: %s autodiscovery interrupted\n",
>> +			"%s:%s: %s region setup interrupted\n",
>>   			dev_name(&cxlmd->dev),
>> dev_name(&cxled->cxld.dev), __func__);
>> -		rc = -EBUSY;
>> -		goto err;
>> +		err = -EBUSY;
>> +	}
>> +
>> +	if (err) {
>> +		construct_region_end();
>> +		drop_region(cxlr);
>> +		return ERR_PTR(err);
>>   	}
>> +	return cxlr;
>> +}
>> +
>> +
>> +/* Establish an empty region covering the given HPA range */
>> +static struct cxl_region *construct_region(struct cxl_root_decoder
>> *cxlrd,
>> +					   struct
>> cxl_endpoint_decoder *cxled) +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +	struct range *hpa = &cxled->cxld.hpa_range;
>> +	struct cxl_region_params *p;
>> +	struct cxl_region *cxlr;
>> +	struct resource *res;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>>   
>>   	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>>   
>>   	res = kmalloc(sizeof(*res), GFP_KERNEL);
>>   	if (!res) {
>>   		rc = -ENOMEM;
>> -		goto err;
>> +		goto out;
>>   	}
>>   
>>   	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>>   				    dev_name(&cxlr->dev));
>> +
>>   	rc = insert_resource(cxlrd->res, res);
>>   	if (rc) {
>>   		/*
>> @@ -3412,6 +3462,7 @@ static struct cxl_region
>> *construct_region(struct cxl_root_decoder *cxlrd, __func__,
>> dev_name(&cxlr->dev)); }
>>   
>> +	p = &cxlr->params;
>>   	p->res = res;
>>   	p->interleave_ways = cxled->cxld.interleave_ways;
>>   	p->interleave_granularity =
>> cxled->cxld.interleave_granularity; @@ -3419,24 +3470,124 @@ static
>> struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	rc = sysfs_update_group(&cxlr->dev.kobj,
>> get_cxl_region_target_group()); if (rc)
>> -		goto err;
>> +		goto out;
>>   
>>   	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig:
>> %d\n",
>> -		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>> __func__,
>> -		dev_name(&cxlr->dev), p->res, p->interleave_ways,
>> -		p->interleave_granularity);
>> +				   dev_name(&cxlmd->dev),
>> +				   dev_name(&cxled->cxld.dev),
>> __func__,
>> +				   dev_name(&cxlr->dev), p->res,
>> +				   p->interleave_ways,
>> +				   p->interleave_granularity);
>>   
>>   	/* ...to match put_device() in cxl_add_to_region() */
>>   	get_device(&cxlr->dev);
>>   	up_write(&cxl_region_rwsem);
>> +out:
>> +	construct_region_end();
>> +	if (rc) {
>> +		drop_region(cxlr);
>> +		return ERR_PTR(rc);
>> +	}
>> +	return cxlr;
>> +}
>> +
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder **cxled, int ways)
>> +{
>> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> +	struct cxl_region_params *p;
>> +	resource_size_t size = 0;
>> +	struct cxl_region *cxlr;
>> +	int rc, i;
>> +
>> +	/* If interleaving is not supported, why does ways need to
>> be at least 1? */
>> +	if (ways < 1)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled[0]);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	rc = set_interleave_ways(cxlr, ways);
>> +	if (rc)
>> +		goto out;
>> +
>> +	rc = set_interleave_granularity(cxlr,
>> cxld->interleave_granularity);
>> +	if (rc)
>> +		goto out;
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	for (i = 0; i < ways; i++) {
>> +		if (!cxled[i]->dpa_res)
>> +			break;
>> +		size += resource_size(cxled[i]->dpa_res);
>> +	}
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (i < ways)
>> +		goto out;
>> +
>> +	rc = alloc_hpa(cxlr, size);
>> +	if (rc)
>> +		goto out;
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	for (i = 0; i < ways; i++) {
>> +		rc = cxl_region_attach(cxlr, cxled[i], i);
>> +		if (rc)
>> +			break;
>> +	}
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (rc)
>> +		goto out;
>> +
>> +	rc = cxl_region_decode_commit(cxlr);
>> +	if (rc)
>> +		goto out;
>>   
>> +	p = &cxlr->params;
>> +	p->state = CXL_CONFIG_COMMIT;
>> +out:
>> +	construct_region_end();
>> +	if (rc) {
>> +		drop_region(cxlr);
>> +		return ERR_PTR(rc);
>> +	}
>>   	return cxlr;
>> +}
>>   
>> -err:
>> -	up_write(&cxl_region_rwsem);
>> -	devm_release_action(port->uport_dev, unregister_region,
>> cxlr);
>> -	return ERR_PTR(rc);
>> +/**
>> + * cxl_create_region - Establish a region given an array of endpoint
>> decoders
>> + * @cxlrd: root decoder to allocate HPA
>> + * @cxled: array of endpoint decoders with reserved DPA capacity
>> + * @ways: size of @cxled array
>> + *
>> + * Returns a fully formed region in the commit state and attached to
>> the
>> + * cxl_region driver.
>> + */
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder
>> **cxled,
>> +				     int ways)
>> +{
>> +	struct cxl_region *cxlr;
>> +
>> +	mutex_lock(&cxlrd->range_lock);
>> +	cxlr = __construct_new_region(cxlrd, cxled, ways);
>> +	mutex_unlock(&cxlrd->range_lock);
>> +
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	if (device_attach(&cxlr->dev) <= 0) {
>> +		dev_err(&cxlr->dev, "failed to create region\n");
>> +		drop_region(cxlr);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +	return cxlr;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
>>   
>>   int cxl_add_to_region(struct cxl_port *root, struct
>> cxl_endpoint_decoder *cxled) {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index d3fdd2c1e066..1bf3b74ff959 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -905,6 +905,7 @@ void cxl_coordinates_combine(struct
>> access_coordinate *out,
>>   bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>>   
>> +int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
>>   /*
>>    * Unit test builds overrides this to __weak, find the 'strong'
>> version
>>    * of these symbols in tools/testing/cxl/.
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index a0e0795ec064..377bb3cd2d47 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -881,5 +881,7 @@ struct cxl_root_decoder
>> *cxl_get_hpa_freespace(struct cxl_port *endpoint, int interleave_ways,
>>   					       unsigned long flags,
>>   					       resource_size_t *max);
>> -
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder
>> **cxled,
>> +				     int ways);
>>   #endif /* __CXL_MEM_H__ */
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
>> b/drivers/net/ethernet/sfc/efx_cxl.c index b5626d724b52..4012e3faa298
>> 100644 --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -92,8 +92,18 @@ void efx_cxl_init(struct efx_nic *efx)
>>   
>>   	cxl->cxled = cxl_request_dpa(cxl->endpoint, true,
>> EFX_CTPIO_BUFFER_SIZE, EFX_CTPIO_BUFFER_SIZE);
>> -	if (IS_ERR(cxl->cxled))
>> +	if (IS_ERR(cxl->cxled)) {
>>   		pci_info(pci_dev, "CXL accel request DPA failed");
>> +		return;
>> +	}
>> +
>> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled,
>> 1);
>> +	if (!cxl->efx_region) {
> if (IS_ERR(cxl->efx_region))
>

I'll fix it.

Thanks



