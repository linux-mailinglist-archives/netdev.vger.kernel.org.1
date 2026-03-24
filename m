Return-Path: <netdev+bounces-271323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMYSOh0Kw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:03:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E091931D15A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14E22301F401
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A93333442;
	Tue, 24 Mar 2026 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QFXIfA2d"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4219343E;
	Tue, 24 Mar 2026 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389784; cv=fail; b=SQNQaQD6Qpjp8zJxVQK9xILmFh6XCeiPsHoACJ5JdkujEmx5eirYF979Vw4woo7mTfjHazZ3e6jjCip2UjE91GliEYYDAUs3SMNSH06tB38QdLr0BkRaY4BrAdkOduUacO69C6P5B2Or1KvI3cPO2qBrzrTyGeR+Y9UiJcIEq+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389784; c=relaxed/simple;
	bh=dRVGlqyz8pdMxRs+KPm001x6dkv5jawHoq4E5Et1EGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oYI1PtYmG7WxwMFt2hHi1QeoePh8EOUHMh41yWzvUfRP4UYf6ihg4MXOuZR3vk41U2/ewJh57YU7dxOG8CfuBVf9Xsz2wJ2Z10kJrL7tBZ7UwI6pVIixZsJy59nxWnhGPLhtUteizNamZV0NkCHrxrCv4ATRB003ONJYXP4dees=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QFXIfA2d; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sW0Ks6qD4ZVGPvpU32BQuNyGuKa7GQqVQbeJRIpPzQYBbwexVGQ+CiNWLRh5ZBZy7s7/pLvCiV2HJ0lD1IiQD0Ve6x6qE5+nAuEKssojjdYuef7pjKalc+szdEmuhjQP3sxjfpew26WJ/3Rg+paeTKthP6WrDzzY7nqbtiZRUwowVWiy0w4qJjX7mjUYCuQ3Z8iiUHF9uGcPKRXD80P9bacMRlJL13f3kQAVphias6srkAS4zKzYNbnhYg+cqE3KCDe+60NGPGsXGxB/wRhX8po9AgBria/ZnZoFb6oHhAKgdFBRGffz9Tw8Fg4zqGHum2Z7/mSMyK9v+H/0XPCS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49pnHdzsDn9LK0XpCTusidbFnmMJGfCueJjrLHSpE40=;
 b=GJqRr7b+XB/lR+MVALw5LDSdLS9c+PrK6HCG5MqCorkGc/yCQzhKj76V6fNSuJps2GZtFV70sNi+Z229gtxNefNHCStJVswVkqe3axbjnON2T883TE+6Krs8SGU/iF3YjiimALyzJh+JKYpcLtDhvvTQxvIh9aY7CFaZNmX90p09+DvCaZ6Jgah0HS2FhitPTQMPI8bkiD+ptu8617/bOEikPOMmG5u8Zqsk1GFcZC4rkIhWzL6t2BYut4YBOtGC1sdpKhtY+zA06PokTLhamYsVZINmQt/0gNXxaGDaY3+v+wDObloga6lEIaJJNxPvTxtcVxPfq2NraO+wPOIjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49pnHdzsDn9LK0XpCTusidbFnmMJGfCueJjrLHSpE40=;
 b=QFXIfA2dkCVw+ukHjn7J0XCOOJQNVTcMO/RACGnpB5xyG+S2QWLk00UdgzB4HIWC2p/knxDiboH0x+0o4mVnlleU6C4Z/7OuHDbkVdj4NKFNVGC0PmaL77fNFAJGszrXcv/ngt8r89LKUuQpbxe/YnqpmOnLqp/YtegMyGZFIIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 22:02:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 22:02:59 +0000
Message-ID: <08c760d3-f33f-46d5-a53d-3f6cd24f431a@amd.com>
Date: Tue, 24 Mar 2026 22:02:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 09/11] sfc: obtain decoder and region if committed by
 firmware
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Edward Cree <ecree.xilinx@gmail.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-10-alejandro.lucero-palau@amd.com>
 <9154b54f-32f9-4963-b25c-be30c4ceb8be@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <9154b54f-32f9-4963-b25c-be30c4ceb8be@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d4cda8-674d-4034-f9bc-08de89f11ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	B/ZXln+DeF4x/xaXq7J5EeeC4vVuoFAsfcxWH/RzDsx/F5OezvnmK8qEJ6dIy8AcjXgcFRNXRSwcPcZfYz6lNgap/RzUeVav+BdKsBG2CsVcbZSGoGvdH+mHbtVhf08tkvcurr+TeVhsp8Ux33cMtZRsufU49yTEjMrGKXma8kNJfOdgOTrRBpb/6PCP2F8EBxRHIaJq6tajYgSvC+lF+I0DOBA/3S9+EZVWAUUdQ7xcNaDCHt1fscQ09dSf7+4N9D3u8QwaAzw66Cr2QnA3XGx0m0Vr+qaDgP+a9KqYEoOGVlluzAqBzOnGWGuZz4mgjazljJpCKSVNziP4+1T+P4Q7biFaKDrwYdQJ93FB9o6yG4ujIwe8c04tMhvAszbnY8NTzwxL9jV2L/d4Oca7iqRXI10x5WdiNJzFHdn0IZFkLXy/T3AvgGrGmdHlUkCBHL96EYWt1Rmc7c1+cWaVzeIWTGbZ5tHJup+KcD/+j7ccpmkQFfrgjGPD0Wfn2FK04eEHNxAohf2oRpczjLLyoRGQrH5uH/pbDb/pPwcGDfY0v4XIkSrJIzlfFUvojrniyxOtJpHdwR5XGtuwfp3y4MylnEBYGpKSBcNbimU/ndGUUAJquLgCb7prDwaLtrBW6aJVJiR0Uflk8bFhCQAypeWEA3+m3UrA6yAYZLF4VbKEQv0syfrIiElDPWoTAQmqTiJhfWxdJSdMRkQTeicRKHy1C0FioXzOWoRBxECL7h7xdDxYP/+K+T1HgpYvah4fQ+ELKsLS2Xg/YCoENFFmaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUdPa3B1T2hlTDJIWG5obVdEVXMvYk13cTlXbTNjL3NqM3Jrb1RCYWZTdWpm?=
 =?utf-8?B?a3hGSHZHdjZ6UGpOYTB0WlRaZlRibnZsVGpJazFxWUlUKzVnZ0owaXZST1F1?=
 =?utf-8?B?TU4zYkMyenU5RG44SGs0enI3MW1ObTY2UG81cDdsQjhhT0wyN1YrTkgxcytC?=
 =?utf-8?B?S0h4WWNYV1FCR1hlRWxDcHhZUkEyOC9zbGw3Y09Td05VWmtTN3RRM1gzcEZx?=
 =?utf-8?B?MDFZWVpNK2ZkMmJTT2MwMmpzVWVZMlhvc3pMV0V5WUwxMzZ6dnAvY1VoRTNa?=
 =?utf-8?B?UkpIVElPejFaR0pDd1czMmRSQUpGZHV1K082eisyMmpNcExENkZKQkJHc3M4?=
 =?utf-8?B?bWExcFBaQVNVNlpjUlFXMU9CdVhUZDhnamp2L2ZwVXhTb0hZekdKSXNJclBz?=
 =?utf-8?B?OVRtQlpxdnh1eWg4T1Z1YTErTGc1ZC9aY1oyblNEQ3VvcFEwWm9iSzREOEI3?=
 =?utf-8?B?SVR2QWcwLzFTYkx5bUc1RlRRZm1TaXhaeGd2UmJ6aUZtM09GV1E0RGtXT2Z2?=
 =?utf-8?B?dGg4YzNBdWpZdjBSYmx5LzNYUWN0bjRuY1VWaUNjVEZHb1ZuNDJiTFFUaXJy?=
 =?utf-8?B?SzJxR1pxR2dsNW8zMDlSV2JKTHNGUGdmdjB2QnZjK2l2ZHRHVSs2Q0FHUlNn?=
 =?utf-8?B?ODZNZlA0THBlME4vS0JSQ0ZIR20xOHVHd1dxRkpTcEFDWGJuZVhDVnhta2dP?=
 =?utf-8?B?VnMrTWh1NlhZK0doRk04OEpGem9PeUR3YzBobGFGY0FOR2MvVFZOakpJWWp4?=
 =?utf-8?B?eEx1TnZQMkhwRTNKdTJ4TEd5MTF0NmJHRDhJTnlPMnd4QnNObTFxQllYSjMr?=
 =?utf-8?B?eUErTTlaSjhtTTlUckVqU3RPTmxtK0kwcFM2NVlqMFhOSWppTUdCaDRHVW1L?=
 =?utf-8?B?NXNTZFdmQldzOTJQamlNbzRlYkI5K1l0WEZNbzRNa054RUYwRk8wN0F0SEJE?=
 =?utf-8?B?VSsyN21rSStldDBBY3JkM3JlU3VGeko3cHVIQlN1NkxOUjEyek45UFhkNUlp?=
 =?utf-8?B?WXRUMm5WV3lZOW93ekNiZ1FtTW5vYXJmYXQ4VmwyV1d1MGFFL3IxR0hCcFha?=
 =?utf-8?B?N2dlcW1iS0QvdnBIQjBSdktGRkJIWEdFRVFqOTlCWmpXcDBqcW9xYUNtRUQz?=
 =?utf-8?B?L3JhR3lmcEZGQldJNmJGbHVPYit0RnJhL1dwODBVblVvV0ZyMlNkOHFWNUlx?=
 =?utf-8?B?WmpScnRwV0h6ZjZVb2hTdVdVZFIyR1N1czhpVHlHTFl1eHJmdWx1YThxSWFK?=
 =?utf-8?B?UVNWdmxyc1JCaHp1cUJRZUUyRUxRUW4yTjd6SmRja2JsWTc4dlNSYXVSV3Zy?=
 =?utf-8?B?QXZGZm5YendTVGFPYlVWaVpqOWtNR3hKNVNuL2ZTSy82eUMvR1VoUzVLdHFE?=
 =?utf-8?B?SmZnaU1iNmpYVkdyRXQxUUI5UWltSUYyc285cUNvSHYxaDhwRDZrNHVDOFE4?=
 =?utf-8?B?VGRRT1RjWW5FYmxoWEJ1ODdZeU5pdER4dmVtbCszbjRHNkNOc0lNUHYwd1Rx?=
 =?utf-8?B?SHlRWXBaT0RqVHNIUnpDcDNnMDZWR2VESUgrK2tQRmhjSnpHb01VN3U2YUNx?=
 =?utf-8?B?bEVEdEF3anRUcEF4MDMweEdmaXNJK0FrNlRTVXZ3eXNkd0gvaXpSeE80YlUy?=
 =?utf-8?B?Qi9DdEhpN3hjbkRHZ3JJNm1QSGIvWDlkeE1iYzNJa0R5U2JrYXI2d3ptdTd1?=
 =?utf-8?B?bjQzSHY2NE9PVEZLVmR2TzRHbHhoMnVJSHVpc1h0VmNtZXBlSDFXSTlOZmFP?=
 =?utf-8?B?aEJCUkdMS0F6MEdFS2syaW1uY0tvTUFvSDVTZ2JxVHVCTlJ5aDllNVQ0ZEI0?=
 =?utf-8?B?TTVTWVdlWTlva3dnVkh1WDVRWm90c25zTm0zUmNKVVlFbldGa21mT0RIeTlD?=
 =?utf-8?B?Q2V5K05lbldGOGg5S2NDVEhyRGREbmxTbnF5dlhFamRPWEhuVDQ4OWdKOWpW?=
 =?utf-8?B?WVRpKzlLdmxqNVVqbFNJYlZMNUYxNGRjb0hWN2djdWtHaHUxS1l0SThHMzhs?=
 =?utf-8?B?MjNlWGwvWEk4Vy9uNE1kcHBUU3NzcVFnTzVVUEpNS2NORjFmTHJGU2tjOHpt?=
 =?utf-8?B?SjE3cWpQL1dOQ2xDbytlTW5nNnJyclFTdlQ4NTNqS0FPT0xHZGk4SGgxalRK?=
 =?utf-8?B?WmttTXplME5ZNzcza0ZGS1JYQThVRlFDVHF3SHI2YklqV0hYTWdIdkRzbCtw?=
 =?utf-8?B?c2dhZXJUZmlsN2RCYVVxSHNwd2dnU1RzWEdLUEt1b0xFRWZVaUhGdmRXK25Y?=
 =?utf-8?B?ZnNKWnFZMFdmRXlMdC9pWVNWRUw5aDBxVFRsbjcyZFdzbnJkK0p5MFIvRXVQ?=
 =?utf-8?B?dmZxd2J6NFBtQjYrYjRhNlplaE9PVVdFRnorOWNwaGwvT0EwQmY0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d4cda8-674d-4034-f9bc-08de89f11ca3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 22:02:59.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gScty4QzxAAXxkkTYX8rqmaKWmdo0pfIXHJC0e+x+9yi2noaDQPnuCoe8oOKc7qRqGLgUKHFZ3t3sxLvTwjF3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271323-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E091931D15A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 17:38, Dave Jiang wrote:
>
> On 3/23/26 4:31 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Check if device HDM is already committed during firmware/BIOS
>> initialization.
>>
>> A CXL region should exist if so after memdev allocation/initialization.
>> Get HPA from region and map it.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 22a7d1d95425..78f926300943 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>> +	struct range range;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -82,6 +83,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> +	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
>> +	if (!cxl->cxled || !cxl->efx_region)
>> +		return -ENODEV;
>> +
>> +	rc = cxl_get_region_range(cxl->efx_region, &range);
>> +	if (rc) {
>> +		pci_err(pci_dev,
>> +			"CXL getting regions params from a committed decoder failed");
>> +		return rc;
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap(range.start, range_len(&range));
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
>> +		return -ENOMEM;
>> +	}
>> +
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> @@ -89,6 +108,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> +	if (!probe_data->cxl)
>> +		return;
>> +
>> +	iounmap(probe_data->cxl->ctpio_cxl);
>> +	cxl_unregister_region(probe_data->cxl->efx_region);
> Would a device_put() on the region dev be sufficient here? Not sure if everything should be torn down if SFC didn't create the region to begin with and only retrieved it via cxl_get_commited_decoder()?
>
> DJ


I do not think so. The region will be around as current region creation 
is "linked" to the root decoder. Only if the root decoder is removed 
will the region release action be invoked. As I have mentioned when 
replying Jonathan, maybe that should change.


Thank you


>
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");

