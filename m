Return-Path: <netdev+bounces-179584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C46CA7DB9D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C416D628
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089E82376E4;
	Mon,  7 Apr 2025 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uz7gZmZU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9923814B;
	Mon,  7 Apr 2025 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023427; cv=fail; b=Hla5CBgdnSF8MdmDv2O5RlAhlJcTsdvZWJGRQu4StjB/db0aUxYKIRj+Augk2hUgr8XBVdK9D/nNraCqLeL0chEK5EfNfDwjqiwo76XfIsOWIpzgtmOgcjmyQk5GexHUCA6IhM2wwyutph8rrFHIYB1bld+nS0ZEveUAWhHseWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023427; c=relaxed/simple;
	bh=uZHcxXgwgY98ULigU4bAhd2kjTVE5rDC1fhIuBJAO9A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=glZrgmuB22OPR3E6RngPWUaCXjytUdIbxSsP6Flae4ShDdMXzwMF6l59VlTpm5GGKVSa/J0me/0QiDtHnbQMV3xj0WRrU8C8M+w1z1xr/H8KtTibqxVZ7PbdT7AT9HU/WKDePMcreXkQAGchZAu3yvn8AxYNN4k1Hyr+T3h3ZGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uz7gZmZU; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVEpxyVSOjSGOFn2ecPVzCiT70jBNXgRx51KBFJFQQerg1VkoecOxagR5fmH1ztNN58LjNBrMs7MWQqo9nd3LCxjTC7jnwmTfFXC1UccdhsjbsUJBKtm8+zDSdh1iHN7LrGYrIY6nKdX8u5StkKhuav2bI+h+cOZX1h6d87E/98GmFNIC4PFSaRDwY1kCB+wan2Cg4R7kT6bSnIE7xjggMWNhc+akQmFGwfKGiNwiiRh+lO+eQ80v3U81shMyi+Og30IFUDisn6z5AxHXEDSHW3UMEFmS+3A2O0hZ82jqONZr2MGH7Z/lrTyWr8oPUpnPg5jqoc9mU/O3G6TeNqXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HghEbUTZ1ju4s5cR8RV2YWYAR6j/ehiDTfcTVgqN+Bg=;
 b=BoZOvVsTl6Jkg31OwjTTqm4t2EjBwTtH22ifsMQTVhg5wVjFLNKJVN0DJLY8rzyV+YgvEJk9zQe8oKrDsZUjcKKxIjMAMJ86LKt3Ve3xt0e1g0FBL+dNXMhkF/wZ55brWn7BRWvDrUWxaskB3jnW/G2Rl7EdbI5yWm2j04nbo+el9VifRb7Yspg/Uxk3AunnJ3NWbfno+hbRPiwPzqdaLpdYAM6H2+Y5d4tTOHNNUQk4bVeWuWY3A+kz7RHB15VONdjdYbGnVsZ15P/zbL6WZ0iJkKlw2vQrmmLz2rwNwezIoRm3oAk/gvAIunrRx1uQuF8/t4+lokTChn6aVNhkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HghEbUTZ1ju4s5cR8RV2YWYAR6j/ehiDTfcTVgqN+Bg=;
 b=Uz7gZmZU8FWRVSYhuOUAReYWNwqBTjfRILOIhksQqQESXWViOjBIOj04joaV3lop7JTmgYI5E7Awhklj6NzI3mInLtKHf5i7AVWckadv4ff3V1HuL4BazwJF+AvadgtIgJd99QDPahays0U+UhVHVA6299VLGzjLogIOhQgruEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 10:57:02 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 10:57:01 +0000
Message-ID: <3a5a57c0-f3e6-42c7-b698-c495779b7b46@amd.com>
Date: Mon, 7 Apr 2025 11:56:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/23] cxl: support dpa initialization without a
 mailbox
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-8-alejandro.lucero-palau@amd.com>
 <20250404171146.00003258@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250404171146.00003258@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 57656fc4-16d2-4b25-22a2-08dd75c2ed05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTh2ZXBzN3NNT1hJcWZIOXhNNkhwaGNRUWNiRFBQd3hWaGtpSEhOUFpqdnVS?=
 =?utf-8?B?VzlSM0tpcmNjZGd3V29iN0FIaElIR0lhS2hBZkxKN2w2VVcrWTluejd3Y2ZY?=
 =?utf-8?B?cHB6a25qTnArRTh0QjlIWSs5VmNaOG9OcWt5U1JrRGx3d2M0OExyeVVDMENB?=
 =?utf-8?B?c1R6Q1ZqUkMzcjNiZlR2Y25rY3F1blNNb2FObDY0TjRPdW10N1BOTmhnemZG?=
 =?utf-8?B?NzZpUGYrZjZ2aHg3eUM2cGhoUkxuTHZwL3JQMzRCV0FsU2dkdklQc292WmZD?=
 =?utf-8?B?dWJFdmVOd01xWlgwV25YUXBBMXU2L00zRDVJR0p0Zmk3WUs1OEYvVnBhUWJ6?=
 =?utf-8?B?QzVvd0dFQW9FQ3FlWFRheis3TW5IL3BoT2cvZCtZZ1NWc1VmaU5KdSt6QUQx?=
 =?utf-8?B?WFVlcFFUWExoUUJmMjJuU1dhUWkrNkE5Nnl0SEVOT3VWMW1qei9VVnpqVUtB?=
 =?utf-8?B?Tk4zcVlSRG91RW9uRi83a1NnS2lJTFM3MjVDaElyQmlvT2hVYTZMVG9NSWx4?=
 =?utf-8?B?WnR0WkFQeTdNb1BhOE9qZCt2YXBZWlkxR3pVdGNVeE9iT1ExTFFtNko5MXJU?=
 =?utf-8?B?YnQ2bXBnalRsejFmdzN1OFdWOHdaR25tb0NiNHY1NjhMU3hmc3BLKzJqQ1ps?=
 =?utf-8?B?Z2lld3RkYUhOZ1MreW04NTFTSG8xWnU0Z002cDhsSG41UzZYUzh5WUlpRFpm?=
 =?utf-8?B?OHd4ZnZXQ3ZyZmF1LzlKUHh4TktnWmdwVXQ5UUxXZWFidlNGOWZhNmtLU0Fx?=
 =?utf-8?B?ci9TOENOS0tScjJtbVhHeEgvRVFwQUl5a1RpNkl6SXczd2JlYllGSGlmaURE?=
 =?utf-8?B?VlYzSWs5RTlMTzdmS0xTWEJGekZ2TUtycHAzMjk5SG50TXFXaU5tQUlPYlAr?=
 =?utf-8?B?OXg5WUFxSEluYlQwanE1U0lROEJQWFF3WFZUQUFabE1PNlo1cWhLS0wycVNa?=
 =?utf-8?B?L21EUks1NVVDTWhqN2xUbi9SNTFsQ2tjRURwdDNZOTlMRklmUHNCKytZOXRn?=
 =?utf-8?B?MEFlRGRCdTZVQ3N1cmdsTER2N3hYdThoUWF3UG9GNkFTekV5clNMUmlkR1pz?=
 =?utf-8?B?VmFkWkhKS3d6a0lpSTkxZnFwMkNaeXJRZFFDSWIvdSs3TzB3bXBCb2ZVUjBG?=
 =?utf-8?B?cjBySHlibHJhMFVZYlRwLzdqcmlLWitmZHRJM2NHbzllZTlJR2xvc0dEbVdh?=
 =?utf-8?B?TGNINUdmV0RVTGZqOXJUeXMxN1VhQUovNjkwaEMrbHJXSDlEMGdwbW85MXZF?=
 =?utf-8?B?YWQwVnZnWGV5ajlQeDl6VXM2aXNmbDk2RDhSclZBalZsTWYyTy80VVJIWXdJ?=
 =?utf-8?B?Z0xHMHJ6UjZBWFNGbW5BKzJoNE1sVmY3OWhDUVpLSXNHWHV3MEpFaG5SZFUz?=
 =?utf-8?B?dkE4bkcrNDI4T1hKdyt5cEJiUFk5bGl4b1U3T2phWjFETlJLcWpUazJJTDVJ?=
 =?utf-8?B?a3VKN25zRlhBNTdhdkVQc2o5L0FaZ3VqdGVQM01zQnVkeVpSMFBSMEJvVWlK?=
 =?utf-8?B?SFhON0NpdDg2VFdQMmFLVU4wc1FNNWRIakVLNnN2bWlUenlwUVdJZG0rVlZR?=
 =?utf-8?B?R216Y21sSUZNSlB1WlJqSEc4ekZHanZBUjVsYnF1YUM3Z1RMd0VrdmtHVnJV?=
 =?utf-8?B?TXpkVTdpVnZSeEdIUFg3TEs0Umc5OThkc3NxbUNKL2xmaG4vZnd1WTVLblN2?=
 =?utf-8?B?V0hRUzlVWXV1OEtKZ3JFNTc4ck0xL1I0ZE9RdlBjOXBFelNiSkNxRzdzM1B6?=
 =?utf-8?B?TXRuWVFFbGg2MmlHL2MvWDVIWUQzZHZOaXQ0Uit2OWc0eEdPMW0rQjBSNjRo?=
 =?utf-8?B?bHN6b0tVL1VmdUJnRHBSaEp2NlJpbWt5QkZCVG1ib3NvcXhBKyt0cWhqaDFh?=
 =?utf-8?Q?i9hQd/fmlrCVa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGNGZXpLdklrVVdCWms3RUhKdElXYjVaZE96YnhPbDJjNVBJVlBLZ1JtU01S?=
 =?utf-8?B?YTVML0dTSzdJd0hBN3FoMXUxUit6VDgvRjFzeEJROHp2ZUpoVEdpa2FpTUJ4?=
 =?utf-8?B?aHpISkdWUHdrdkQ5YjNSWlpxQ3A5alhTcVRpcnYxRU1NSEZ3Uyt4bUR4VXNn?=
 =?utf-8?B?dmZGQ3phUndTdE1tUzVST01nQTQvdHpwRmxkMTZRZDNsTlBRUk1CTW5DYi96?=
 =?utf-8?B?RFFXU1pZWkl6VytHZmpRcDNIVXA0TCs3b2J5MVk5dldJdllBMUIxcFpySWtT?=
 =?utf-8?B?dk5BRVUyelM3ZWxoYzlvSlpNeGVtQXZISTVBMlA4YStMQWc1dWFZZFFBcXZX?=
 =?utf-8?B?ZEp4T1FZeGtLTG91WnJ4QnVNL01GZndJdEdMU3dFdzhKY3U4cmFNUmY5Vkd6?=
 =?utf-8?B?NFJMQ2NaMzdlRHd2VTFhUEtmWnlGN05HckhNWHE0SlFPUFg2dVFTbUFMSHFt?=
 =?utf-8?B?MitkWEJLK2tTM2FRQ1creTA2WDJFRnFrZFI4WkY3R2p1aTcyRnFIM1E0UFJo?=
 =?utf-8?B?Tm4xRlc3bUFuWlk2YmhBS0FoQnJkbVN6UEJnZ1VXMzNmU0ZMTkR3bDE0K09I?=
 =?utf-8?B?R25LWEQrQk1wcWJLejZ3TFluVEc0WnZRR0srN1BoM2JmeWdkRGxUWHU2SmJH?=
 =?utf-8?B?UGI0R0NUUjZQclI5a3IwTEFpaVBsUjhNNE1qZTdURjdCR1JQbXVXeFduTFdZ?=
 =?utf-8?B?M2lHby9oK0N1Q1kvYnQ2enZQeU55emgwZzRQWmNJZ3pHRmtoRzFxUC8zZDNp?=
 =?utf-8?B?bGwyaS9IUmpYYlI5UzY5ZmhOS0loaHNnZm1GN0lJZExDaUxnN0J1ak5KL09t?=
 =?utf-8?B?RVdod0c3YWRKLzhmMWR5YXNHd2h6VnlDL0ptRkEwS2g5NzF3WXZIcS90clJW?=
 =?utf-8?B?TDNOSXJ6NHdOODdJS3I1SHdIbkl6WW9PbGw1Zm1PeERSR01zY05ydHNCc2VV?=
 =?utf-8?B?Vkxnd1RldzRqNXZBYkg5eWdQSFhJM3lWRXZOZDdqancxeWdjbk5DSFV1cno2?=
 =?utf-8?B?MEptMU56MnA5RVMxUjF5TnRRMWgrWVp4L0pFQ1ZrZGRjaTYweWhXK1FRZEF2?=
 =?utf-8?B?SzlQWTYySVc5QVUzdmFyOU5MaFU3eUZabCs5aHZ1dTlxTFFQMnBGQS9WQmFa?=
 =?utf-8?B?NUd5bWxlZTlOdDJhOFBVRTlrb1QrdG16VVp6eHEyelFwS3VFOXlTT3B1R1ZM?=
 =?utf-8?B?L1J3VkpML09Fb2NML2ZyMmtEYklHMkw3RENYUTVmMXBCVW1ZZy95ejR3Y3Aw?=
 =?utf-8?B?VERBbDZIaE5TOG5RMmduajV4S3FJRFVqVEM4aWVnNHRvUzgvVzJmd2FadXJ6?=
 =?utf-8?B?bHByNjYxZUwyU0RJL2lGNTlGN0w4aEVRSDgrMVI1N3dHSkVPK0ZBTHhYTERa?=
 =?utf-8?B?ZEVselpkUENHT0NZS05zM09CdU5qWVVpdXZBV2JNRGFsU05IeXZPRHJ5bWtt?=
 =?utf-8?B?MzMzVDFtbmxUSjg5QXcwc1NtQXhlWDJxQkRmWWxxUzNvYld4Q0FPTjRPM0Fp?=
 =?utf-8?B?SlRUN0g5aTdnZTlUQXgwcXJoZ2FJclVyNlBnZVJTbGY1UFBrUkpEN2k2WmQw?=
 =?utf-8?B?NWNYNDlZNTNzTlhnNjRsLzFsa3pvTWg5M1U1TU94cExNWU1icU1yN3RVSjVs?=
 =?utf-8?B?dVMwMndVWU8yT09sS25oajFCY3g5VG1LSFBEZkJ0aXJFYjZtN0hkUjVhSXZP?=
 =?utf-8?B?bUJFQlZNajlTdDBCcTRQSi9NQWVsZG84K2NTZys4aVRwVGFvcFo2KzI0bjV1?=
 =?utf-8?B?TWtYbWJPTlNMVFU1ekVpeTQzbEVWQkJJM0xBNXE5ZHVWVnFuUzgzOWRxY2RW?=
 =?utf-8?B?elJUMXJlcTZ1cTJOeUM3MHh6RGdZemIzbEpqNGd6aUVIa2lFSzZzZ1NDcndv?=
 =?utf-8?B?NmxUUGJwRFQ0TkY1TGZwKzRSQUprSmFSQldpK3JybHBQRzY4SjM4eGI1ZElH?=
 =?utf-8?B?QjFCb2xRN1ZnaThGalhCS2V5V2k4dVJ5TFBVVHI1YjFza1Y0MWdsOTJmK25C?=
 =?utf-8?B?YklBNVNOcmgrL1BXWHlKWCsraTRqTXc0M0RqaEFIaUl4a2ppTXkvMU5QRllK?=
 =?utf-8?B?UWl6SWRxK2g2RnVPTC9VdUFWZkltakx2RHl6bllmeWxTM3gzTUgwcEZlcGRk?=
 =?utf-8?Q?uNUsIvoIfZTDR8FJw7/NrL+r0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57656fc4-16d2-4b25-22a2-08dd75c2ed05
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 10:57:01.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TdU77JiVnSw3Ic8C4Bi51xR/skbKiOVfOW+0fI7Ds5vaAbPoaouj8HCJ4tcdakOdllJzlBeK4i461Qcg/4Yzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487


On 4/4/25 17:11, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 15:45:39 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>> memdev state params which end up being used for dma initialization.
>>
>> Allow a Type2 driver to initialize dpa simply by giving the size of its
>> volatile and/or non-volatile hardware partitions.
>>
>> Export cxl_dpa_setup as well for initializing those added dpa partitions
>> with the proper resources.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/mbox.c | 17 ++++++++++++++---
>>   drivers/cxl/cxlmem.h    | 13 -------------
>>   include/cxl/cxl.h       | 14 ++++++++++++++
>>   3 files changed, 28 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index ab994d459f46..e4610e778723 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1284,6 +1284,18 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>>   	info->nr_partitions++;
>>   }
>>   
>> +void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>> +		      u64 persistent_bytes)
>> +{
>> +	if (!info->size)
>> +		info->size = volatile_bytes + persistent_bytes;
>> +
>> +	add_part(info, 0, volatile_bytes, CXL_PARTMODE_RAM);
>> +	add_part(info, volatile_bytes, persistent_bytes,
>> +		 CXL_PARTMODE_PMEM);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_init, "CXL");
>> +
>>   int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>>   {
>>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>> @@ -1298,9 +1310,8 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>>   	info->size = mds->total_bytes;
>>   
>>   	if (mds->partition_align_bytes == 0) {
>> -		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
>> -		add_part(info, mds->volatile_only_bytes,
>> -			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
>> +		cxl_mem_dpa_init(info, mds->volatile_only_bytes,
>> +				 mds->persistent_only_bytes);
> Why use this here but not a few lines later where the variant with
> active_*_bytes are used?


Good point. And then the previous change for setting size if 
partition_align_bytes != 0 is not needed.


Thanks!


>
>>   		return 0;
>>   	}
>>   
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index e7cd31b9f107..e47f51025efd 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -98,19 +98,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>   			 resource_size_t base, resource_size_t len,
>>   			 resource_size_t skipped);
>>   
>> -#define CXL_NR_PARTITIONS_MAX 2
>> -
>> -struct cxl_dpa_info {
>> -	u64 size;
>> -	struct cxl_dpa_part_info {
>> -		struct range range;
>> -		enum cxl_partition_mode mode;
>> -	} part[CXL_NR_PARTITIONS_MAX];
>> -	int nr_partitions;
>> -};
>> -
>> -int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
>> -
>>   static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>>   					 struct cxl_memdev *cxlmd)
>>   {
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index a3cbf3a620e4..74f03773baed 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -213,6 +213,17 @@ struct cxl_dev_state {
>>   #endif
>>   };
>>   
>> +#define CXL_NR_PARTITIONS_MAX 2
>> +
>> +struct cxl_dpa_info {
>> +	u64 size;
>> +	struct cxl_dpa_part_info {
>> +		struct range range;
>> +		enum cxl_partition_mode mode;
>> +	} part[CXL_NR_PARTITIONS_MAX];
>> +	int nr_partitions;
>> +};
>> +
>>   struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
>>   					    enum cxl_devtype type, u64 serial,
>>   					    u16 dvsec, size_t size,
>> @@ -231,4 +242,7 @@ struct pci_dev;
>>   struct cxl_memdev_state;
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
>>   			     unsigned long *caps);
>> +void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>> +		      u64 persistent_bytes);
>> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
>>   #endif

