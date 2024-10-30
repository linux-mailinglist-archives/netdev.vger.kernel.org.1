Return-Path: <netdev+bounces-140458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37529B6936
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E01A28178A
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F5F29408;
	Wed, 30 Oct 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZiY0qOif"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13426296;
	Wed, 30 Oct 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305901; cv=fail; b=CtpQg4BvHBfFZWnu5dCVF1z6wZoUHYWRnF4UaTvReDvlwcXIcl+AyFjbpo0IKC9K5r60OtF6k6kW0f7/ZMIZLrg5d8h4Y5GiCWFalnj23FAKlo1cTJe0DVDE0xUWuNtFtKs4HktoRnbFKvAiaOgJDQjfr3QLD1SktO899JTmTi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305901; c=relaxed/simple;
	bh=VfQyYgr7rRCtuubGER8TXQFid+xQPM/1LhLDIhfAEJA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kemXKbqV4+sSr52F/mOjToKMYdiQ3XFKwK+ghiQfMTN1s43agUie71EF8u4ZTasYSazlgGxUg8mKpFqEyrtj1UCsphw6ww3TTcNrY5qFQPjNrh5JOF0UiRq8ybsXrQYVRN2/PuoKwycbrfYzkROz//BPtPeHWvAjHkILSOBw2KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZiY0qOif; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHVqnUUBDlAieWLiI5gVLfIhV9K8E+pOcRFZ+CiFYV+sJKp73zwR8mjtmdLapdKogrt2xJ24xEqZDIUxXOG9BTCyUER0TUJrUqUwvUPetqDR49fjCa2d5YPiofTrfQ7su66D0OcwSiN23hcZcubEep1LmY8e6Vj1wPcC+TbP6jBDX4iURGO3dZyGw9HxtFwwE3NCWVblP4/XIDzhXbWOo/iJ21x/kwcgO/GxqNtNJp+Gn72XVT8RPXiNpUJOn1CyuIizq2w9/oUSCoU5Pti8smd/npClvT6ynhWmB83CXdQgJEHRwSgHiE+Ts6Qr24HJULuxmoj9q2qSk0VlwazhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEmiWspA0GM5xWv4Uxn/EPmf0zfHklA0xal4dtf9rwk=;
 b=pJGgxU2nVArP3j9mW4lYJN1GkDJmDASs4sWpRjjgfKRoicDbmgK2JJjj4AcASAmUH7OpKHP+pRyHgVqOaEr8LGtnEYGvL+tOqWEDoLOCOySIS4eHGz4d+GOg4KjwDRt1r56m0t/NLDkwfCUfYZkhfPZdvRMie8pMalhi9Uw6Ky6R61PQxYZX89yexio1PjLCq37mtjGMXtlZOZqStV/ulUYNEqw51UUQAUZNLY+61pUmjKZY+AOSXRHmx/4gpi38qi5A51WbbDeMeNd6bF6D27FYMuLx22QPKCbFFdi8GNtjd5N2PqW1xmgo3ZbLJgOkve9GH1xO4baqiBytpOjQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEmiWspA0GM5xWv4Uxn/EPmf0zfHklA0xal4dtf9rwk=;
 b=ZiY0qOifHQ0fzPb16anySAZxokEKyVIJIt+GOtEQPbZyf7BA2UOuN3CiJHOHIbscxVkZdrWSAQlxvnDmgkxgFFYnGLCfh96xPS13lU+ZTCjo2PP725ZjQWP0ApogLw/u6xP4lrLSC/DqXEstFdbXWRpM+IhYrCtvhCACRDqsRgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 16:31:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 16:31:36 +0000
Message-ID: <c34c6734-6936-a7a9-448f-64bf48731bb6@amd.com>
Date: Wed, 30 Oct 2024 16:31:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/26] sfc: add cxl support using new CXL API
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-3-alejandro.lucero-palau@amd.com>
 <20241025150314.00007122@Huawei.com>
 <b6c1ced9-0038-7819-8e61-7e486da8bd35@amd.com>
 <20241029151404.000034be@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241029151404.000034be@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0178.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6711fa-4b22-42ff-28db-08dcf90052f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGlONDZWVmV5RkI5WG1TQUFJRHpxRFdKWDFFVS9sTmh3c0JyVFBhVE1Kdld4?=
 =?utf-8?B?MHIzNFpUdHRoN2F1d1N1K2dtTmtJYjQyNjlIZ3gwcVRxU0FyRlR0azAzS2xE?=
 =?utf-8?B?UkFqS1Y5TDJoWDlWaU1UYlJ3aFBMSDFiR09hWGhOUGdjR2NDZitVaUJ6aVU5?=
 =?utf-8?B?ZkNPd0R3US9oOEtIdlc4bzBER2dRZXRMdW9JQ0JGekxrbkYwczNpY0d2ZVBm?=
 =?utf-8?B?dUcvUkJ4VmowdGFIUzl0VUF3NDM5elJESzZIQTBFYlVTU1FQVThobDlQTnIy?=
 =?utf-8?B?Q2c5T1UxWng2dEw5RnZGL2RYdGNiWkNiOTJWdkdLcklWT1djcXFkcXo1Mmxw?=
 =?utf-8?B?K0htNVpuZVhNTnBHR3lKa0NoQndSSW1QamdVMUl2bUViY0JHeVhJREhjekVq?=
 =?utf-8?B?a25VZzdkWE1MZUxLeXBqNjlVS08vSFg2ckgwUFRVb1Fyazh0WSttd1M1dTZv?=
 =?utf-8?B?NUs2a1ViTWNTeEZ4cS9rV3Bycjh6MkFlU2tiajdyOTRsTkN2My9ieVJVWm40?=
 =?utf-8?B?T0k4WE03bjZkdERlRVJHY1UyNHdmV1ZsSU5DYWVxK0RvaTZYYitiR1ZPUGlL?=
 =?utf-8?B?cDNaWnE2cllvOGZDcXJzV2pRYWRtUUNTdzR6ZVl4c2RhWjlrTzJ1cTRmNk95?=
 =?utf-8?B?V2JHcFovY085c0hoZjVKWCtQT0Y5L1RWUGFxTG5FZkF4aktaMkEzYi9zWGoy?=
 =?utf-8?B?SEZKZ3A3NXNhUXlOR1Q2MUhIMEdSalRCbStCMGZMd3k4blRiUmQvbldwZlVw?=
 =?utf-8?B?T0hMTHBRY2VLRjdtME05ckNjU1dkRVNQV05WWXJQRnNBUVlmTFV0aFl5Tkly?=
 =?utf-8?B?NDhBY2VvOVhmdUJRYmw2Z1lDTklsb2NNcElZYVJndllmYmFPWDR4WFh6SFZh?=
 =?utf-8?B?czdoajhqMTZVQWcwSlExNTZqZmxVTXZrOUN6WUNlc0NtMWlKaEFZUGdyQTZE?=
 =?utf-8?B?OGxDS3daMm5ycmh0OUNhL0luS0c4U2tWNENyYm9VOTZCMXpwTHFaa0J6TFFX?=
 =?utf-8?B?VmVHZU9lMlFGbi9GQnJtMjhyT0swYlpwZitKajJ0cmJ4SFFWbVFvTmtwN1dk?=
 =?utf-8?B?YXVUeUtqY0lWNVJGbmc5NzAvdTJlM2RDTmhVVkpMR0tPMFdzbkx3YU5ScVZV?=
 =?utf-8?B?RThIeG5NSDNlcUFLcEhCOEo3dkF5NUdRdEdyQTJ4VXdCU05RK1FPTXZJeVNL?=
 =?utf-8?B?VTNQQ1FJODFZc0JVU3NuRmFDOWE4bGJJTFB2MXkrQkpRK1dvVVBhbXFFNjZl?=
 =?utf-8?B?bCtoWlBkTElhcVFmMWlhT1pFY3h1VGd1Wmt5a2UyVjRnTzF2bTZaVFhDbzRt?=
 =?utf-8?B?Wlo4N1NkWHQ5c2R1VUQzb3RBVGhxOWpDRjR2N0lqOXJFT25EVnFrc3pBZndD?=
 =?utf-8?B?YVM1bktFTGcxWUZXdEcveE5kajR4TmF4UGdzQ0VvVDdSRmY2NGc1NExNRy9Y?=
 =?utf-8?B?czJxMUxXQXJlS1gyR25ya2dUOG9XTHhyeDlUaUViWHNoSWJ5OTJDQm1JTTNV?=
 =?utf-8?B?WEtoOGhSTk0wTWRxR1Z2NFJBTW8zZS9RN2hWUzZLMTIrM1JPd3BqRHZ5Z01I?=
 =?utf-8?B?OTJqdGFuTTQyVVIyMU1EenYwZkh6WlpjaUlFQ1lsa0IzWlJIQzFIWlZIVnNE?=
 =?utf-8?B?QVM1N0VqNEpDZnlBU2VWdmhmK2pRa1BrTUd0SjUwUGIxVE5CaUxZekdpVjF0?=
 =?utf-8?B?Z1VCcmE0U1h4NFdtblArT1QvVXJUazhkY2FMbUlPcVhJcU1kNWFCMkZKTjlp?=
 =?utf-8?Q?uDtI7dcwrxeVX7MPs1mX5lRP26nigkmxVTi0Cyk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1BPMnFMZnUyY1o2WWwxdUdRdGZIWjVEMXBsM2s0M2l1Qk1mNld3RmJnY3oz?=
 =?utf-8?B?SzM3QXp6Sk45cWQ2Ukt6cEl5b1ZJVDhqL0ovTnVKVjdMN3FRejY0ODdyWEIy?=
 =?utf-8?B?dUo0SCtiOU1ZVW9lUkd5d0puNUF2cFkxaXB6dGJPaU9hdG1Ybnk1OWcvUjU5?=
 =?utf-8?B?MFFHZHEzcm5kN2lpbUMvS0xORldXMTlza3RyR1BPMkVYam5NTXZpa3RBc09F?=
 =?utf-8?B?Sm9oT3pNdUYwdnowNEdvdlZSVnRqK1ZoUlNIczBmNkVKZ1Z0NlNKYk9RcVpH?=
 =?utf-8?B?K3cxNmhpT2paWG1jMy9mcUZLY2ZmQjRVZjYwZVF1bzNXTlo3Nm5sV3NWRWxZ?=
 =?utf-8?B?QTJYYUNOdWtjQlpSa2NCVXRNaEtSR2hyZllDY1gxMTRFeDc5ekFKTXZMcDRV?=
 =?utf-8?B?Smo0bXBPM280VUM2K0JvSkFDRDZQSHhvN3plTHZXblNSdnFqZTVEWHU2SERi?=
 =?utf-8?B?QnFCcXVidGtGY3dYaC9aalRRamQ3cXB3aXdicFJVSHVGcjBaUDJZZVlUSEYv?=
 =?utf-8?B?Wnc4eENWbGN3OHBzVUpUZGVVblZNWW9YeE1FdXR5Q05DVFdMbm0zVWZyQzlh?=
 =?utf-8?B?SVl4RUtCN0o2REN4S3JqZ1dPRDVzeElFclRkK3plMytGcDhFTnJxcklSWVFX?=
 =?utf-8?B?Q3ZHUVRwdmlGNjVpdmdaRG4xeDhHbDVObGE2S0htN2Jwbjk3WVVyakp4YWVF?=
 =?utf-8?B?TUt3Mk5tcXhEbEJXR0NFcHdKM29SUFZ5ZVI1YVlnTFJ1MklrMlNZQzVncThy?=
 =?utf-8?B?aWpTck9BcW1pMTcvSUtRWGxCaUdkNjRRWlhEL2VyQktSSVUvZDJ5am9vOXla?=
 =?utf-8?B?QjdhVTU5SnhFSDdWVjJZaDRCWnRnSW91S2lNN0l6Qk40QkZLTWxYN2NPcWdi?=
 =?utf-8?B?VjRvZHFVKzJaaFpiUG5uZ2FVakc4UmtEV1Z6RHNsMWYza2FoMWpUU1BVUlU3?=
 =?utf-8?B?MzBBMGNxNGZyQVVuNis5SVFaV0w2NCtaaUhOanI1QVpSYkthcXM4MXNaNXhY?=
 =?utf-8?B?SU8zWUNYOWFGS2pDdkpPU2VFV2Z0WGM1a3pubjM3dUFUanNSeEFyTG1Xb2xD?=
 =?utf-8?B?clUvSWorQXJkc2hXTUxlWGlKclMyaktuU1ZKdnRTakxzRFRsZGtBZXVKWENw?=
 =?utf-8?B?OHdOZkdsWUtZVjBwRTBrZEFRVjN6WEdnbzdvNmxCVzIrSkkrSGhFOWRIK3ow?=
 =?utf-8?B?RDFRVWhIMWczZUVRZy9DSzFEU1NGSWF1K0dFbHVnaElFUVpnNDdNd2g4VXZs?=
 =?utf-8?B?Q1lIdHJraW00VHNDSmhRdGNZZnA0SEMzRTNFU2p3R2txQUNiaTBScDJrUXgy?=
 =?utf-8?B?bFRPL1E5cWVkN3hBY0laUWZrUWRKNjhNMkVtQW50ZmhSR2JjRUo3aDZmV1U5?=
 =?utf-8?B?eUZPenJIalU0MTg5UGQvSFhMKytnMTNyMVFHb29wQk5qNFEwQTFaS1hEWVFV?=
 =?utf-8?B?VFlVNzNTM09ERHFMWVdqU0tzOFVSeDFYdVBrMmErN2NlaTFiN0lGOC9nQzNu?=
 =?utf-8?B?WnVjYWJOZEttS3JhSlhieGxKVmcvby84OSs2WmR0U2dsYjMzbE04U040Vy8v?=
 =?utf-8?B?dTJqcktvSXM4MDZOb3VRUGY1WWRaeEZ0cW9RWng5NmU5dHNDZndJUU9qVzI0?=
 =?utf-8?B?Wjd3RnVZckowUURpQ25FVnJwR0RyVnJaVitBMmlXeHNQOWFTTzIwOW5oMjB3?=
 =?utf-8?B?VllaWHFhK3VFcEM2Ly9Pd2lCRlRQUWs4dHF2c2o3SElFR2VaSlZGaU9FRGRx?=
 =?utf-8?B?K3ZvOGJSZThxOHUxTmhKWjJJby9SNXAva0VhenREMmV1K05Yb1FHUTJGT0c3?=
 =?utf-8?B?bkFKSFBWbURvbFBCUUxia08zWDhVWU9KRC9OMGU3aVNzLytVeTNIZ1JYK0hJ?=
 =?utf-8?B?TFMwbWkxT2thVVNNTmw3YnRLa1VleUc3K0pPbW1wVkp5RU5LcGVHcXBIdCt4?=
 =?utf-8?B?bHQ3SXorWWhBR2NUSUZ4WnlDY1JkVXg1bTZZbEQ4bDdnWTl3VU1NTVdIeDlT?=
 =?utf-8?B?WVdYQzZ0OTZtalM4ZVY3YnhWYmE4T3NzZTdITGFtUmVCS1o4a1I5NWswQWhu?=
 =?utf-8?B?SU14ZWF5Nkc5MEhxZG8wNGJVekJoaGE3MFRUVGM0VUEyTW5IK254Zm41RFBV?=
 =?utf-8?Q?Z9ZW62aQMhcCMYXsZgCrcQ6qH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6711fa-4b22-42ff-28db-08dcf90052f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:31:36.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFBhWDSst5DxoDpesFu0icQKcLOIxtuX5eH6fk8JuVLE/9mfU2mqcvmsFWIwIn6gLeMK8bLqfLxbgm/wq3JqpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898


On 10/29/24 15:14, Jonathan Cameron wrote:
>>>> +
>>>> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
>>> __free magic here.
>>> Assuming later changes don't make that a bad idea - I've not
>>> read the whole set for a while.
>>
>> Remember we are in netdev territory and those free magic things are not
>> liked ...
> I'll keep forgetting that. Feel free to ignore me when I do!
>
>
>
>>>> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
>>>> index b85c51cbe7f9..77261de65e63 100644
>>>> --- a/drivers/net/ethernet/sfc/net_driver.h
>>>> +++ b/drivers/net/ethernet/sfc/net_driver.h
>>>> @@ -817,6 +817,8 @@ enum efx_xdp_tx_queues_mode {
>>>>    
>>>>    struct efx_mae;
>>>>    
>>>> +struct efx_cxl;
>>>> +
>>>>    /**
>>>>     * struct efx_nic - an Efx NIC
>>>>     * @name: Device name (net device name or bus id before net device registered)
>>>> @@ -963,6 +965,8 @@ struct efx_mae;
>>>>     * @tc: state for TC offload (EF100).
>>>>     * @devlink: reference to devlink structure owned by this device
>>>>     * @dl_port: devlink port associated with the PF
>>>> + * @cxl: details of related cxl objects
>>>> + * @efx_cxl_pio_initialised: clx initialization outcome.
>>> cxl
>>
>> Well spotted. I'll fix it.
>>
>>
>>> Also, it's in a struct called efx_nic, so is the efx_ prefix
>>> useful?
>>
>> I do not like to have the name as the struct ...
> You've lost me.  efx_nic->cxl_pio_initialised was that I was suggesting
> and not setting how this comment applies.


I could try some excuses ... but it was my silly side or maybe not 
enough coffee.

You are of course right, and the prefix is not needed.

I'll fix it for v5.

Thanks!


> J

