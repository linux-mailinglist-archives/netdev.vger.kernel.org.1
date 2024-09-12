Return-Path: <netdev+bounces-127906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F6976FD0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF10286B29
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACEE1BC09F;
	Thu, 12 Sep 2024 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jgAwe7HA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B905143C6C;
	Thu, 12 Sep 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163464; cv=fail; b=GgFPK6L7UWa8KVCCwPWGfm8yfzxa6mnXo9hqEkLG+yZBMEu8QqP44/Mf7tBvn36ElyUObCPko5UIO12rsYxFnQHACu5TgByLOkQTRlU4VvAICkmSqVswAWXIBVPvmupIR/IxrZnMzFyf1Nx6wFO4eOyzrbCy42FEni/2jsDWzao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163464; c=relaxed/simple;
	bh=SgE4rrqPrGKI5qee0739yceOmiPuJUBGMpeO8GLVcdQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gtem14u6KmY4ytpK2qN60PHatjytkerDo//bzYM24md3bMeXZ/lZywivd8eE0WyAJBQb5r29r/TuB97AAS+Y9l49KraJ3LhsadCDLbhb4+/s/bpbqb45Sr9ej5kiJay+PQ58ysw3X0HWK8///tYZloNSQ/9pVngxLlfB7wCFJBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jgAwe7HA; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdwlmM3qmE60Wfk1mIP06BjdUwgYaQM3nh64jUEuSZ1nDY6YcGp7IYpAlw69O5EVtDf7P0OgoED7knfgPoXudNZFWrkL55of+o8xoKVNtSNjTKiuj5f2hd/w0HCk1BdRcvKsnyB9ghn53C2vWTl4Kxd768a3jEGyvaDW/vbeC08yMraO0iaz286vi2zFGDJt7NXpyC8lm5/etMU2Dy5mrmvt3BzL+oUHbHTqNOtR9q44L82CUC8cPw85WAjuMwzwd3P55NPQQ4lYyQUjzK4kcsPuJS3xk/x83G5OZyc2fQwCC1jrafJYP2cs8I8mMk1RvZC7Vlx6LcVQFHhlzmgq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Onm6pcqxQWHaxGj9W/vk1RMLyZkQgsCqKxbcauLRo9I=;
 b=V8ogaWXklOuG89dC8/GqhoT7BYmk8Kscf+JdROxckNpEjmqEU9hgQujy45w5/4k0udp5/+sYnibTqLSZf/p6g88sipD97J2zLrdnVSNAT/z65R1TKIn9hF2QWI27hKu9quIXhaVKo9J7HvpWBP5nExxq9FdyeNItctAt+7D8HHAcMkbzdbzWCGxMFG3z8wFO3a4I4ow4smjhEouytQ/57yphG9VFJycb7xfoKyaWaCtGxF7cMxie+xgUAjFXQmEUXnfkNyi+VDy98iBGxmPFUf3j1jQuFSXJDA+oVPQFm7F0GwbJLRHwmWVo6lSFdmV3xHHSXY3288JsGFUSk38Q1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Onm6pcqxQWHaxGj9W/vk1RMLyZkQgsCqKxbcauLRo9I=;
 b=jgAwe7HAT0+lbWBaAVTkyMYPoxrKeXk1tRWy0QGOCjit/nE7rJOFUmgzxfDCUBZ3d2PdDlpRwLOoC0YrP1W/4JvYXGlDRXsa8ajfcfOZtz+CswzrLWMrMo2FkcGvw11IsZPK+pzWGkj7a8vFZWsCE+W6NDMDdRLXEoBirD95Esg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 17:50:59 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 17:50:59 +0000
Message-ID: <2ddd0888-abef-4d28-851a-adeaa380641a@amd.com>
Date: Thu, 12 Sep 2024 10:50:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tg3: Link IRQs to NAPI instances
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
References: <20240912155830.14688-1-jdamato@fastly.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240912155830.14688-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::17) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3d9417-104f-40cd-f651-08dcd35375b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUxPVjFnSXU0WWxHZDdPTHRJdkhGUEVWZllmYnl0U2UvZmhpUE1iZHl1OGFq?=
 =?utf-8?B?VDhSR1hJODFEWkFaNThZSEpBQVozVEhiVnpDTVFKWVJIZ1NwZDZPbUJ0WEcw?=
 =?utf-8?B?YWZqbHRod2RnTmNtTSs0c3ZGTnBUZ0lqMktqRFRYN3FRWXVpUlk4Skc1Vkov?=
 =?utf-8?B?UGRhSE1sZnJpc0VlMzhiSnBwaWxIQm5WTUZNM1RFUEVlYXlsL1VqeWVzdGlX?=
 =?utf-8?B?bzZqTFBkK040RXJYU1NsZ2dHWit3cHhzeDVhWC9CTVhTMlBmN2cyNHIydDlt?=
 =?utf-8?B?cTJTSjh2eEl3Z0hORjhMeWZSTWVPb1l6UHRnQ3dsbG8vK2dpSXd2c2NIRURK?=
 =?utf-8?B?R05RYkdzN1B0bTY4YzU3b2F3bWpWTURUWVV1OW9QMVNMSW9PT0piMVpyY3ZT?=
 =?utf-8?B?Vk5UUTB6aFhkNmp0S0FTblN0Mk5YRnZNeVduWHZlTHdpUDREWXBPR0JCZzMx?=
 =?utf-8?B?RHBVOWdBYkcxdFFQSjVlMTgwaTFFQ0FoVVFaeVQ1UEVNU0dBRUdybnFWcHV4?=
 =?utf-8?B?U0FTRjVVcEQ2Mm9VSDE2ZWlOY1BxN0N2R0NFVi9ZVlBidnRaenNHOGxEMllB?=
 =?utf-8?B?eUwxR1J0VnhqMkduQWFIUC9TdGhwS3grWkpsTHpXNjkyMHNPRDlzOGFpSEha?=
 =?utf-8?B?UjdLZTJ4a3FaYVBqdFlvem9uQmdDdWMxQUZweVdjQTdFSk5rNTFGL0Z4dXdE?=
 =?utf-8?B?UnpkdHNiY0ZCR2hibmIwenVDbGJLL2ZmQ3RUMWQ1RjVZMWFJUDVHSnJYL012?=
 =?utf-8?B?S2FDOTNndjZDbDNub0craHQxdURxb1l6RmdFWW9hN0x1S3pjSmFvR2ZEVmdk?=
 =?utf-8?B?N25ncGhVanZRcHFpYjhDY2paaFp6N0ZoOU5ZT0s1aHlScld2dGtMSGlFYXR6?=
 =?utf-8?B?WVpPU0EwZGVGeTZuR3h5T053MWxlUkhVQmtWVmJVUTZxRmVwZks2NThnbGFV?=
 =?utf-8?B?Y2JKU2NUdEtuWS96d1N2YlNQLzhkNkprY2pQUTE2bmhrcXhxdGJHTUxFRDZJ?=
 =?utf-8?B?UHF6aVBSWTlEcExudGtoVkVpQTJwbUlVQjZwZWcxWmlVeW01amkwZ3ZzOGxC?=
 =?utf-8?B?dm9yWjJZMmpCaEJZRllGZTZ1ZWw4eTQzSkUzblByM0VBMExnTEt6Zy9SL0NS?=
 =?utf-8?B?eUhDVjdjQXBIdzlnWTdRbWltR3VMdU1KYS9Pd0dtSDZ2bktESFZTQWNlMUdz?=
 =?utf-8?B?UEpGVTQ5NEdLbXJHU3d6b3ZEenZUSk5qTjU2dFNZSjFsWThWVkRGelhYam1h?=
 =?utf-8?B?T3BJM0gvRTZpSjBIQkx3ME1sVkFlTkhLYzUxVEZEZEhid2JSbFljRHZNMCts?=
 =?utf-8?B?OFVtZStld0lYN3Z6bG1xTXdoQkUrNkhxRG9wcjhCWDlOMkkwS1huVXRNazdI?=
 =?utf-8?B?RG1qa2dZZ0VFTEQ5SlpkVGc4Sk1nYkY3WEgxWXpmMGhIM2hpL0FVTE4xUDhq?=
 =?utf-8?B?Sjc4MHBoMk4xbGVCdy9TQzlkV2tTSUl3TlpWYnlPaXU0QklweEkzR1JieW5m?=
 =?utf-8?B?TGVnUGdwcUFOVW4xMm0xZVlFcTBwRU5EaTBHV2NUYTFCRjM3OW1tenNZQkhZ?=
 =?utf-8?B?ZEVlT2QzeTQ1TUNpQ3h6OXVzTk1aYlVRSGR6blJuNDNQcGUzK1g2YnlPNkhF?=
 =?utf-8?B?Tk80dGRDSU1VeHFDZ0pTNUxVVUxLUExKU3RheVBkbGJRd2RUTExJaVZQWi95?=
 =?utf-8?B?NXp6MUcrMU0veEpUY0pHTytEWCs2YUZEVkFPZ1R3V245MTQwSk1GYktwcW5k?=
 =?utf-8?B?WW5MVnJjV0k5Z1hQSE9vRmlCQmJ1TS92SzY2VDJ5MDlROGVGS2JXM2Z4K3V6?=
 =?utf-8?B?RTM3akQzUUhPRWIyVEYwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzBBclFPaGVDczQ3M1BOSVlJMHpoQ2IyVkNvbWI3eUNjaFk0ZHU2NCtiSERV?=
 =?utf-8?B?WHdSdmc4MUd1L3FxQjZ1YnFXZTRmR014a040WWZJS21Pd3BRUTRicmVlTGxQ?=
 =?utf-8?B?eU5KS0FDZUw5ZStKZkt1Zk54S1FSSHZEejROMUR0c3VlTXVjSnpUL01zaDd6?=
 =?utf-8?B?ek5idDVCQmVmYkRoMUl0bElTS0p2aXhHcndtZWxMRzJ4ZTd1d2RpSW84SXhx?=
 =?utf-8?B?M0dBL1FhYjBmd2xBNCtIa2VNK1N0N2gzNy90OGM1djRxU1BiblgyRVpLK3Ju?=
 =?utf-8?B?L1A5MXRNbk1TTmdpOGVpWStMa3FrNHQ2aFBxK21LMGV1eFlQNDlvS28ydDFB?=
 =?utf-8?B?M2RPaVdCMzdzRlNDSkpBMDQ5L2FIK0s3U0VubWtvVEZhaW9PTTJ3dXptS09E?=
 =?utf-8?B?dDAwS3p4TjBHUitZQkQrakZ6TWtoSVVnUVovbWplaUFBVEt5VGtKU1BNTllJ?=
 =?utf-8?B?M3JYVnZKdENGOWtSeTJjNzRDL0JKbWc2VHpyUEQydFBlbWROWGZ2Ui9FNnVv?=
 =?utf-8?B?VVI3dkIvVVduQStSdWw1bUM4cFM4MjlQTXREUzIwUXFsVHZmVzVscks5Mm8r?=
 =?utf-8?B?aEdZU2hOTUdsRnRnRzEwT3lVSWJrVHlWKzBQK2hiaVR0ZXlwdG5UUnFZUURN?=
 =?utf-8?B?QzBMVWw0OFZlYnNjRUp0N2J3NUhRRURYaTFneWN6SnBvSlF1V1REb1VTQU1v?=
 =?utf-8?B?VWk0RVdDMUtYeDBNS3QxTnQ5bXMzVUpWVHZBTDNhdm53OUJpSU1FNHVnRlJT?=
 =?utf-8?B?VDdsRHFsYWNMUGpzTVpTM2hxN3NETTdkaGZMeTlwdmEwREIvZ2kzYTZxZjJu?=
 =?utf-8?B?N0w5L3U1R3plUnZENmJ6SkpmWm52cng2Mjlpd2RjR2Y1bXRBbzJ6L0tQYWxD?=
 =?utf-8?B?Nkt0Um90bm5HOTF3MlJUdjdIVjBkRjZ5clpSL0hVYWR0ZlhVV3ZjVEVXd1Rw?=
 =?utf-8?B?a2hKTnRFQzBIQURNQWlWQnB4VVAwdWJUd0RNL1pqUHdDSWNuQkk2SlRxVHFN?=
 =?utf-8?B?ajZYZGU2SjY0bVJxc2d6Wm43UWVwTVczbmFKK0RtaHMzalRGR0wyVE5MRnMz?=
 =?utf-8?B?MUNaNHQwYWtxcmhpbnRNejRnL1NvbEtyNkF6OUE4NXI3a3hDc2R0blZpZnNI?=
 =?utf-8?B?WFEzOE5lV3hqUzlqMGpmUFc5aFJCY1hWY3RrMFNTdWlwRTR6QzFWVlFBU2Vz?=
 =?utf-8?B?MExnUXlEQ2JhUzRKQ3VTQjlmSkRkZHlYSVF4Zys0YjhCbytocnJVUU9TZzFW?=
 =?utf-8?B?UFE0QzVpVlY2TXFPdUxKNmh0Y2IyTUJqUFlTTThaZ0VURC92WlpRSlRoSWlU?=
 =?utf-8?B?eHQ3ZWlVbkR3MmdhMWpyMFVDc2l0S0ZaSlRqNCs5bFU0Z2ZBWG01QjloQXVo?=
 =?utf-8?B?N05ReThnMmIyZWhwRkJUK2pkbXlOdERNRTU4ZWtiai8zTlNLeEJOWU13VzdY?=
 =?utf-8?B?QkhzRU9reE5BdVo1ZU5nZUl5eXdiMFhKVWJrNWIxQXJhekZHTWUwd0FRbGw0?=
 =?utf-8?B?MWhUaGpWK0RuZGdZZ3JRT0RCQ0o5UzBYL1kxWTdDamNxOGZMT0VxVE4zWm1C?=
 =?utf-8?B?YXpDZkhWWFkxSUdnRWJLQ0pZRzYwUVFqTmMyeEhGbDY4OEdOY0ZLVFNoNmNi?=
 =?utf-8?B?emNReWNjZGh2OHJFWjEvSzlnS3Z0ck5hQmhLMUZjcXk2MzhRekE4SDIrWTZ1?=
 =?utf-8?B?eEtLY3F6Tk13Z1B2alVleTAvQTMwSzlpUmZKM0hsNnQyZ2d3SGpHd2ZyQUNJ?=
 =?utf-8?B?KzBZR2Rja01TbnZvWkxqLzU0STVGRUw1V1lyMmh0QlNoQjFFaWN1MVUxcTBG?=
 =?utf-8?B?VTdQVUpWOEt4UUtPTmR1bUtWRDY0L2tlWXlvVDRPaGFtQlRJSi93MUxnL1px?=
 =?utf-8?B?aE1BVFlrSHJCMTM1WEZFS3h4dmVYcmd0Qm1pemNGbnhibFVzV0NadEJCM3Fp?=
 =?utf-8?B?akdPK09kUS9ub0pFRWcwaVRQbWFXRDZBc0xlbEcyM0JVdjlWTHlWcksrcE1s?=
 =?utf-8?B?ZVRPWVExSUJHcDdIakRJTG4yaTg5MEthMWlpUy9CZDBQM2hTSVY5OFVjN0N1?=
 =?utf-8?B?Z0paTHYreWN3aGF0VmxyYW5DT3ZVcVRJdTNWeXliWGw0dVYxVVkrdUhQcHNP?=
 =?utf-8?Q?ExtI0y8KGSvKjdxDE9H+sCp4x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3d9417-104f-40cd-f651-08dcd35375b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 17:50:59.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btgPR+dQmoMrVGiNFtmm/2+KUmtJVw+RnsxQ/t28w3GpdWeu12C+HhNm8NrOAfBMbQ1v4TQcjFn4cG2jJDjl2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408



On 9/12/2024 8:58 AM, Joe Damato wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Link IRQs to NAPI instances with netif_napi_set_irq. This information
> can be queried with the netdev-genl API.
> 
> Compare the output of /proc/interrupts for my tg3 device with the output of
> netdev-genl after applying this patch:
> 
> $ cat /proc/interrupts | grep eth0 | cut -f1 --delimiter=':'
>   331
>   332
>   333
>   334
>   335
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                           --dump napi-get --json='{"ifindex": 2}'
> 
> [{'id': 149, 'ifindex': 2, 'irq': 335},
>   {'id': 148, 'ifindex': 2, 'irq': 334},
>   {'id': 147, 'ifindex': 2, 'irq': 333},
>   {'id': 146, 'ifindex': 2, 'irq': 332},
>   {'id': 145, 'ifindex': 2, 'irq': 331}]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   drivers/net/ethernet/broadcom/tg3.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 378815917741..c187b13ab3e6 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -7393,6 +7393,14 @@ static int tg3_poll(struct napi_struct *napi, int budget)
>          return work_done;
>   }
> 
> +static void tg3_napi_set_irq(struct tg3 *tp)
> +{
> +       int i;
> +
> +       for (i = 0; i < tp->irq_cnt; i++)
> +               netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec);
> +}
> +
>   static void tg3_napi_disable(struct tg3 *tp)
>   {
>          int i;
> @@ -11652,7 +11660,7 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
>                  goto out_ints_fini;
> 
>          tg3_napi_init(tp);
> -
> +       tg3_napi_set_irq(tp);

I haven't used this API yet, so I was trying to figure out if this is 
the right place to call it. I think it is, but other examples may not 
have put it in the right place.

I think there is a minor bug in fbnic/fbnic_txrx.c. I say this based on 
the following:

fbnic_alloc_napi_vector() {
<snip>
-> netif_napi_set_irq() # napi->irq = irq
-> netif_napi_add()
	-> netif_napi_add_weight() # napi->irq = -1
<snip>
}

Just as an FYI I submitted a patch to fix this just now based on 
reviewing your code:

https://lore.kernel.org/netdev/20240912174922.10550-1-brett.creeley@amd.com/T/#u

LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

>          tg3_napi_enable(tp);
> 
>          for (i = 0; i < tp->irq_cnt; i++) {
> --
> 2.25.1
> 
> 

