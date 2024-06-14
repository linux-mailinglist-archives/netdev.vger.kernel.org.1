Return-Path: <netdev+bounces-103616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B971C908CBC
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD5828A71A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658788BE7;
	Fri, 14 Jun 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esteem.com header.i=@esteem.com header.b="xFjyNsPx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2136.outbound.protection.outlook.com [40.107.244.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC1881E
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372956; cv=fail; b=CLLvx2OoqYNkPmzWW5fI3nrtSsQAn/+dstVv0LiyKQnqQmaXyEBNTRSgEOT6so9h8+7EhJG+t3K2JutHuoVir+VDjsM/QnykuoWnmpK2XYQXg1Myj55nhVjZIjdpRhAMITqaB0q9MFT/E5DWX5gvgJi/gk2Rd3ua+xEwfOpSE8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372956; c=relaxed/simple;
	bh=jGDSpEvAr6kg3ZdILSzLjgVaz/3o9z00izF8tUkLwcQ=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=LhjMUBQEp1vcJIDnSNxAjTG4SDV65IfsERgJGhoOsMfLvPQ6DL74gBLqQ1bRuTVSmH5bqRq0p7DMrh6Sag5Ux0VyjsYt8h4M+a/C044AsKHLHo6NHtSPvu0elOvB+1fn98sXm6+EajNvx3u7ccJzJdtlEq64hi2gjzuN+zWTsPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=esteem.com; spf=pass smtp.mailfrom=esteem.com; dkim=pass (1024-bit key) header.d=esteem.com header.i=@esteem.com header.b=xFjyNsPx; arc=fail smtp.client-ip=40.107.244.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=esteem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esteem.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXKlawSK8BacR1m1CSq4BCiIkme9K5WUR7H/SGsBC6/oyGRUOdDytjJvGAI/ArUJJ81C0cLM7+M7+8YjHNDy2ljPXJ/sdVyZpilfPq5BaHZxQSH0iVR+26GfnmMRplhLn6Z+NzyfN7ZTgSnyqIq+WRGl2m46Jm7jzEM3B9k3qCAVGlPmUq16wXQj2WV6Q6/jyDt8dQIKGtVkuzYWK/kievRb9hoY9xgrz7Iw2Vw2QJwUbaR1Qr5D3BCjpXT+MKoZUqU39135UNnQouJEbaL8i60ZeZVj6AkNgahKUVj5uWA92w/DvAbCPrUyWZ+gy643Ef/owbAXAXm/T2JCPM020Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ6w5gEFo0k1baXP+gwMlTEVDrO2OB0CWbtQ7pSWsjs=;
 b=jc2Ym1xI8fWWE/gPV0ke+O7gM2W1F3PH0Xp8P/Azb5607V2HqxjYGMKu80xSKoQAXI1QCrRuMgWrN1jaFDRba9RAvzRFpNFkDvVTydNaB+mT0wjXDeSo97b4r0lfNMOIt3KXQb9k3X4d5fxIrKLHhca8bUvmTTRsudqcJ8QUvSjncWYpQaFYZDoFQNWRKmFLm4WJ5wPvuBJ3x8wyiWG5m1t1E6qOTS9KpuhJci85QkkYor7+HKfGob4GAo0V4i/pWNRX/KsywzD4qiPSkMaK7NM2oiYURKVTZCogOX8WgPlVlTmQssAbXbGLYihe7R21DHfDWOHbR1ugk4iBPURoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esteem.com; dmarc=pass action=none header.from=esteem.com;
 dkim=pass header.d=esteem.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esteem.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ6w5gEFo0k1baXP+gwMlTEVDrO2OB0CWbtQ7pSWsjs=;
 b=xFjyNsPxMK7y+I7xUvY4UMK9MxDJDojW+wLhf2DVb2Fo/UnbVoj5kqIYyNQKeBiutelNwxFDXQfxJfFP7FcL3KOfIZhunal6hW4NllQMyKeXfepZLYee7k9MsZjEEQiLozetCAajhh41vdehNrMnXdQqB7MxwV3E36LX42hqbKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esteem.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.24; Fri, 14 Jun 2024 13:49:10 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 13:49:10 +0000
Message-ID: <d653597e-9b1f-4eb7-af36-8d79cc5146b7@esteem.com>
Date: Fri, 14 Jun 2024 06:49:08 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Neil Hellfeldt <hellfeldt@esteem.com>
Subject: Throughtput regression due to [v2,net,2/2] tcp: fix delayed ACKs for
 MSS boundary condition
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: b4796876-c6b3-42de-c518-08dc8c78c46a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2xkZVQ3ZTJyejNSVERPcnowQTVRa2s1dkE3Q3dtQzd3TGtEWDBtU0FtUHJ2?=
 =?utf-8?B?RWtKc0wwWFMrVWRMQk9oRTAvcVRTLy9NWFNGaVpPb01sMVVKWGZGei95bThJ?=
 =?utf-8?B?bnFNcSs2Um1oMmtEbVoxVThJNVc2emRTaC8yYWEyTkk0TnRwTjZrM2VRODdR?=
 =?utf-8?B?ZGI4S1NLWSsxei95UXVzcXQyd0kwZXQzdmVLa0Z6aWp5aFUyN3R5MVRNMjRu?=
 =?utf-8?B?S3JraWI1S1llL0ovbDZDYXh6RlRraEwwQkx6ekM1eDFFMzBkcExCTllSMjRk?=
 =?utf-8?B?UWpRclR0Y1FRSFNnRWkyaUs0KytYMjZFRXdibEFCdEt3UER4c2lYUDZCMk1L?=
 =?utf-8?B?VzF3eWlEdHdQY1VXRWRCNUxKcXcxczkzZURrTzhWRnE2T0s0dGhYblphNUhh?=
 =?utf-8?B?R1d2S095d0o2MWdRQzVwZm9abytzU2FCbGNpa2xoUUdOR0FuM0N4RlQ2SkV5?=
 =?utf-8?B?MGxjekE4Znl2SEc0N1BPbEVEZG5rNUlmZEFyMTVxa1RTRnVldFpjSitiaEZM?=
 =?utf-8?B?SGYvMG0xVjRWNmlFUnVSMmVoUWEvejNJUDBQbzJ2MWx3LzZDSnVMc2Jyalpx?=
 =?utf-8?B?RUxJcVordzFvK0sxRXdIM3R3dmNJb29uV05sMXFXRTRFVUxXdVhkT2FzTmt5?=
 =?utf-8?B?aE8yVHpMWFlMQ3lQU2RiRmFsazJaVU94aWxiL3ZJMEQxQ3ZNYmVqVElOVFZr?=
 =?utf-8?B?anV5ZVZKR2dmcVdFZnJLRVBoRGY1cGhhUEI4YzJsalgvdFpiTmpWWVdOcTJH?=
 =?utf-8?B?NUhheWF1SGhuRWZtL21OOW1rTmdVMXpTa0ovbzAzYmIxWDZqQ05IQ1l0M00y?=
 =?utf-8?B?WVhEV09vcXdRSGozeVl4dWxwMzc4ZFhyRkJFQkVuSjJpTlZUUTFVTnQ5REIx?=
 =?utf-8?B?QXFrSVdmY0FZTnFKM1N0alVVdXNySVI0YW51T0pYc25tc1FWbSt5NW9oUCs4?=
 =?utf-8?B?clREamRwQzQwY3F4RDBmblE5bWJjR0lqV29QWmgzOWV0Z3RiWGFPVVRoRnd1?=
 =?utf-8?B?NkllNVFvbjExc3hFbUxkVVdlMk9aWTlUUmNhbVlUU2V5dk5LVmg0R3lJR3JT?=
 =?utf-8?B?VFVVUEZQaTcrTGpWTXRVcFFtbzFnN1JCd0k2TU5pdEZJaHZTaGxaUWNQYXcx?=
 =?utf-8?B?WmF6dkQ0Qm00MWgweGRvd1VHa21NVXdzTUZEZU5KMTZqTENxNTJhWVphdk40?=
 =?utf-8?B?VVRWang1MEZSbytDZ1AzOHd2d2tkMVAybkxENy9rM0ZQR0cxMU1nUFo2TU0v?=
 =?utf-8?B?a2JCYjRRZWw5MDA0OE1qQXJnMUNGQmtIRFRiMWJFS2t4dlAvdFpxcFhvRmlW?=
 =?utf-8?B?VmtEa0Y1U0xxQVBzZzhwSWt1T2pjU0hyY0ZMMGNmcGxYYmNzOGozVzVKNmVh?=
 =?utf-8?B?QzU4bmdCWDZQMzF2Ym1GelUwbmQwUDBvbXoyb0VRS2doaDFJaStNOUZ0WjRq?=
 =?utf-8?B?TzRLVFprTldaZFhrMndnNDVUeUNyWVBxcXlwK1k3T2JrUU5OaEZNOTFSWFNE?=
 =?utf-8?B?USszdEN2bTgwTm9VZEVnaTByUTZVQWlJMHJmZnlQeEd2UTY2UE90cWlnR0I0?=
 =?utf-8?B?YkM2RDFuc0ZSZFJTQ1U0Z29QOUZMQ2ZyNUNsdTl4SnJtd3lmQjFNQlgwekIx?=
 =?utf-8?B?RE5pUXI5UHY3cGczNElaUkNrVFlBWkVPRXBmL0toY0xsVERDanF1bmpmVDdD?=
 =?utf-8?B?NEJXbjVvMndCajFLdDVET3pSbWM2Q1NFVU9VOEhuTGNjUnNjZlB5N1NsQjRM?=
 =?utf-8?Q?aO41iylw12lSpot8yuVXN7RLfuMSkOtaRY+qDxC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1A3KzdpN0c5MXFSQzE3WGpBeTZIUkk1QTN5K3MrNC9OQnBoOUlSeTJzVXZ3?=
 =?utf-8?B?d2xHM0VNc0RWQjlZTTNjUDBlTXY0RURzbzFYZUVtZ2orbS9Xend5VEZqcnBm?=
 =?utf-8?B?Ung5UUxEdnlpZExPaVVOSnE5L1pHdUp2aGhnUDFIWDM0dnptODlGbHlhQlV4?=
 =?utf-8?B?V1kvMjYxYmp0ak5ybW9yRFNFaGk3b2RDMWg3ckduQUM1VFV3THhVc0paYlk1?=
 =?utf-8?B?dGNFT1VsZUo5bHo0ZHB5Zm5Ib2g5V25NcWZ0WCtZSXpYSCtnd1k5YlZUME1D?=
 =?utf-8?B?WURxL3VENFQ5MDkyOEdrdGlGQ0RUNGFic1Zsd2ZuRllBclQxL2xhT1FjUnln?=
 =?utf-8?B?Z3BhL0RLN3J5ZGlIYUpiNXh1clluTnZ2NjVGanpjYkJIUUtvbDZidzloeDlN?=
 =?utf-8?B?VlErNVNPZW5Ya0NDU1JMNExCaWtmbEFQdVRqbyszTnpzUVMrbzZrOXZVbDQ0?=
 =?utf-8?B?U2lYTkRzemwvWWdtM0drSjFqbVQwejRWUWcyaTVWNmwrVEx6eVJUQlNFVHhw?=
 =?utf-8?B?VElLcUcrR0hIY05Jc29tc2V5U0xBQWYvang2WTVlbFAyN0NBcDlZMVBRUDRZ?=
 =?utf-8?B?Q0hCUGsvNFc1c1ZBdk1tRVhQTURjbUZSczZCYjVOVTFLYUtHVE5tOCt5RXhh?=
 =?utf-8?B?L1RjaW1FeDFjK3ViekVqY0pJcVNOV2cySnFBekMzTS8wVzErN1NuK2h0YWhZ?=
 =?utf-8?B?NzA2UWFGUndVV0RlYmlxMWhnOUtaSjZpRkpqSFJ2OVJZRzVGRGxDWHdSNG9I?=
 =?utf-8?B?Uk5yamg0cmxnYlNJQ0JLOVRaTEhpL3FtQ1hEdnZ6L0x4N21QaHovaUpGcU81?=
 =?utf-8?B?QkFKczc4OWlBbzJXZHAyL1ZrVnpLZjhKMnd0NmYxYXArVDRtZW5nWHFuYWtI?=
 =?utf-8?B?WDVUVi9tRkdlN01qa1VSWWRsQ2FNVlpuTU9WUzNwY1cxQXFBN0FJamRrbGl0?=
 =?utf-8?B?cnpvQWNlT3VZTlZqUE1lRS9Pdno5UlIrN1U3dzZYQ3REUFhRM2czWmdKdTRn?=
 =?utf-8?B?WmY5cUlFSTR3cEJIcXhicHhWZ3VwVkJRSEx5N2grRWc1Wk1XdzVndDVPdS9i?=
 =?utf-8?B?M3hsL3E2bVFLOU1TT2pwOXN5VWZSN1pyQWQwb3ZhOUw2RHNucExWbUxoTWZX?=
 =?utf-8?B?MmN2RkdNYnpSdTVYajFCS3E5YUYxSlpXaVdkUldta1dsN29PS1dYQ092N2h4?=
 =?utf-8?B?TnFDdW8xd1JHTDI3Y0Y4d0x3akU3M2dYMTFSZWtsYlltYSs4aDVKY1N6T2FX?=
 =?utf-8?B?enlOZnl1amJFWUtWR3RDM0NKTWwvOXpDclVMZy9TeWpuOGR1Q3dQbHFMeEF6?=
 =?utf-8?B?R2xERFF0UVhZcjlicXJjK1VmWnFPM3ErdCtLVUlIUlUxa1k5amM2L1hldkFP?=
 =?utf-8?B?ZzEybjd4K1VJemt1SUNkRkZxZUQ4VGZCQ2ZWTjJkM2RhbndiUUFjN3YyMWgx?=
 =?utf-8?B?Y2NBMHNJYUJsS2dQZEh2UFlsNUVJd3F1T1ZqUTJLMk1ZUmljWGMwUkdZUENT?=
 =?utf-8?B?YlFON0Z0QTRBVzlXb2dST2ViTm5lODlJUW9KcTNTa1NkZFg5MkVyTFp4TGhp?=
 =?utf-8?B?UURETS9OOENDZmh2NHFoSXZrNzRoZW4wQ3R5Q1NTQ2s1ckt6Z2NSdktZZzlW?=
 =?utf-8?B?WFgvcXNyVEpxWHNuZmhGTmVXMGFzdGZLeVdJR2hTeFg1MlBmNlQrTE43ZUlK?=
 =?utf-8?B?VTBZQmhRZnpXb1ZHV01CRW9vNHdYRzRGaVgvQm1xTk5iQnFEYkVObG1teEdI?=
 =?utf-8?B?OHlqVm5McjdZUW9CNnpCaXZlUU1ubzBpNWJqM3pidWsrV1E4TU93VksyMUpQ?=
 =?utf-8?B?NGYvRkE2YWE5NUcvSjU0UkNhTEVOOWtFY0Q5NWxjK216NTRPVHMxVTJzYXdK?=
 =?utf-8?B?Q3NHa3l3WGwvLzFIblhlNFViNXV3bXkxNGlFVUJOZURlUVVSeWx4KzdxOXFl?=
 =?utf-8?B?bWRPVDdDclpRMjFGd3hzdnpWZC9hUjV0Ty9YcmFiWDhudUl1OXFnekpaTFho?=
 =?utf-8?B?dU8vTjV2bE1ZZ1lDM0gvWUw4Y2FIanJRaElQZXFKWU5uMTl4Qjl6WkQvbE8v?=
 =?utf-8?B?SjRHeU1LYXc0NTBvS05xUXhYQ01hM2JrZVlvazJ6TGtya2FDK0ZuRlM2TVhw?=
 =?utf-8?Q?bLLmdzM4GIp/xucCg0lUkfBtr?=
X-OriginatorOrg: esteem.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4796876-c6b3-42de-c518-08dc8c78c46a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 13:49:10.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f32e9c2f-8342-451b-8efe-15edc71a9887
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlcHdg+Q6xE4j75hIi3bBw8Z2jFR+v7o7jThjqbE4ryMmyLZMkviF6eGkJu8rrJfd9ntRNhtL6pmd56AcMP9Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347

Hi,

So I believe I found a regression due to:
patch: [v2,net,2/2] tcp: fix delayed ACKs for MSS boundary condition
commit: 4720852ed9afb1c5ab84e96135cb5b73d5afde6f

I recently upgraded our production machines from Ubuntu 16.04 all the 
way up to 24.04.

In the process I noticed that iperf3 was no longer able to get the 
throughput that it was able to on 16.04
I found that Ubuntu 22.04 is when it broke. Then I found that Ubuntu's 
kernel version 5.15.0-92 worked
fine and version 5.15.0-93 did not. After that I narrowed it down to the 
patch:

patch: [v2,net,2/2] tcp: fix delayed ACKs for MSS boundary condition
commit: 4720852ed9afb1c5ab84e96135cb5b73d5afde6f

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 06fe1cf645d5a..8afb0950a6979 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -253,6 +253,19 @@  static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
  		if (unlikely(len > icsk->icsk_ack.rcv_mss +
  				   MAX_TCP_OPTION_SPACE))
  			tcp_gro_dev_warn(sk, skb, len);
+ /* If the skb has a len of exactly 1*MSS and has the PSH bit
+ * set then it is likely the end of an application write. So
+ * more data may not be arriving soon, and yet the data sender
+ * may be waiting for an ACK if cwnd-bound or using TX zero
+ * copy. So we set ICSK_ACK_PUSHED here so that
+ * tcp_cleanup_rbuf() will send an ACK immediately if the app
+ * reads all of the data and is not ping-pong. If len > MSS
+ * then this logic does not matter (and does not hurt) because
+ * tcp_cleanup_rbuf() will always ACK immediately if the app
+ * reads data and there is more than an MSS of unACKed data.
+ */
+ if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_PSH)
+ icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
  	} else {
  		/* Otherwise, we make more careful check taking into account,
  		 * that SACKs block is variable.


After I removed the patches I was able to get the expected speeds. I then reverted the patched on most current
version of the kernel for Ubuntu which is 6.8.0-35 and I was able to get the expected speeds again.

The device unit under test is a embedded device with lwip and built in iperf3 server. It has 100mbit network port.
It is also a low data rate wireless radio. The expected rate for the Ethernet is ~52000Kbps avg with the patch applied
it was getting ~38000Kbps. The expected throughput for wireless is ~328kbps with the patch applied were are getting ~292Kbps.
That a ~27% throughput regression for Ethernet and a ~11% for the wireless.

command used iperf3 -c 172.18.8.134 -P 1 -i 1 -f m -t 10 -4 -w 64K -R
Iperf version is 3.0.11 from Ubuntu. The newer version of iperf3 3.16 show the correct speeds but shows a saw tooth plot for the wireless.


