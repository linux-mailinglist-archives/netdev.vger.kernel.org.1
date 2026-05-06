Return-Path: <netdev+bounces-284681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i49/N867+mknSQMAu9opvQ
	(envelope-from <netdev+bounces-284681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:55:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D71A4D602A
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D3B2304298E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5C2D63E8;
	Wed,  6 May 2026 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IF4vC/p/"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08249463
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039755; cv=fail; b=lKzMyft0FBf9yw6OO/m57GSrnQOPyiXdt4sCI5VV2AHeK3/b6hko+k9bl/nV1Zkrl5cgiPSPuCn77+4uwVdK09+T/8yO6vvLAnUpHHFm8x4yfViD4CjulH5vlXjzyYkP7nqRdj8WLG6K87mtJdOMo/2qrqayAXYKV6b9YzpRBq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039755; c=relaxed/simple;
	bh=LHXVWb1tQoiOaW4uJlDBRiZpbzDXi+ZtOHqTtCYwr64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TTxK+s57CN4Iqq+xh0uHwi6Ft642VjmkXTLNP9tIgntZXy40ZxWlisQ5G7k8TM4Spt0UaHHLZ9gcgHubZzp82971O3FutbcZ6FCphYuzo7SVimgXuhdd69tCBLsq5Tkej8TLxlW5VQc6zkt7UvA7o+pkk/YOTvH2VcJ+BZEAsbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IF4vC/p/; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROEe9sZcIK2EADy8vF2jOl47U8V5ImswElJNG2QzBFhL/9b+llTNi8fQ9uOeN7xh+i5BWeEnmuc7aWq5tatCI2GJmJ+ajr4TzZw2cwwMp32m3YngP38FILDIDCstOmUIU4EfvmMHw4IH4xvRGACGYzcCpE6eVCg2tPCT/1CnENRK49h4K5AtVDN1fElCegl2YdGt9PIP0cC5vXT3k1H5foiRKt0YvevjpTTzOr2XCuPOXII5chtGQsfH17G+li3BGEpks+Z7NqmVQ63Fg7vLHhHN4ntInvGtzc0SfqabZaAJgWG4b8IJHYJiO+8kEeVYkX3sAx85V6/rT0pnNYCMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/aOLYh+CC64y6BeXwVb8FGPWodie/MBT5b6snKgZXQ=;
 b=CojUf3ivHaVSmvXtAtJLk+ogkLKkOGh4oUHSqUF8KlEBOWdwW2pgSyvo6y5fJNv+zQ2DRQWEY8lNzNb4poWfLDHuvdYhHZI59Brd7bwl0YhUqgmx4We+Ig8/xZZd0i9UhpQCeT1xGMhN5UAsCOLym8/KjlKXEZA+CdI4uQZLgAkSBsaHCVIcrYH235jI7b4cT3aqs3JN/f3liKywHfGtNFVwyl0YPT+EQ2IZIsQsH/kMQyQk4NYKXdsZDtoAaQBjI4HrYYWeWWjytshgzgxAI92S4TT6G3r9xEsUScOwOG95rvavolrpqRdw3Xveg1MWy83gNRhxcD3MaKYNmLIUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/aOLYh+CC64y6BeXwVb8FGPWodie/MBT5b6snKgZXQ=;
 b=IF4vC/p/yKkGPs5weqRL33Px6vlrXPYniELx8TzaB1xWgn64tQHBvcSZFX8D+EgTT1Dk4ZRDe/mqLxnci1PaYEdhDRDzUwJID1lJLiyULZZGMSWDKaUqk0iEXsUZX2l9lFzg0IrXRi8AZYPH7aLbLZlMI5+oUnABsmXSMBCaETc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 03:55:52 +0000
Received: from DM4PR12MB5184.namprd12.prod.outlook.com
 ([fe80::f927:9cb7:cf3a:e741]) by DM4PR12MB5184.namprd12.prod.outlook.com
 ([fe80::f927:9cb7:cf3a:e741%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 03:55:52 +0000
Message-ID: <fa98f520-7539-42c0-a8f4-1858553946fe@amd.com>
Date: Wed, 6 May 2026 09:25:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: CL37 autonegotiation not working on amd-xgbe
To: Jakub Kicinski <kuba@kernel.org>, PrashanthKumar.K.R@amd.com,
 Madhu.Banavara@amd.com
Cc: Patrick Oppenlander <patrick.oppenlander@gmail.com>,
 netdev@vger.kernel.org
References: <CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com>
 <20260427162839.350135c8@kernel.org>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20260427162839.350135c8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0028.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::12) To DM4PR12MB5184.namprd12.prod.outlook.com
 (2603:10b6:5:397::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5184:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd16458-2d7c-40ba-2357-08deab235dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ejRceS3QrS3IidL8q5es0H4oqApGtfXPW44YNdb6Bi4jWcNdnXHBSIOqLPI0uUlZNLPMggcpbA0aCg3vAxD4P8dt+fCKMfDEHD4qUgv97bXKNMkraGlVRDRP2UpnS088MTW/e4RT9DDk9pDGpXfKeRBhND7YQRSvnGkpHzQBYySuIbQpZVuTROi19x+tsdQI0bix+zt9TBnQ+P7OSs8A4XnI/WFVWgJYK/4GCBQ/tHRDr8gkcIA939WAElEZjTCXSbid4NWQtRCa86bmJBxNncDn/KymR1dgOXLD9zgETlWLUjA27dDr3SLWZqe2btHq/c/RXBNoJre/WagzGKUnAIUy/Dj3MQC8xSlSRn9VQZkHFkk5cRmYC3CrFiztAjMjeenYtmJvclGkdsJthmE8rz3EMtMaTuBQWnWbQln/DZXY0rLpFDKT8LpbFbksKs2l7PvwWOwefQ88XisOB79fVns8s4L1kqQOApk6tK80RqPO34mTA3uMuXj4F9wbnYfH6O61+AQfhNjUY0j0/vunKYzlnb1hkT4iCHqwK2SwLR7AYKkh4o6ZVO9kMyfyBaZUY1ERU/L5M2ZCTU3PURxwjfTSGUnsRhsV/49F0U/TNeNvkiDqIzMKj6PbZXNQRr3DSxF+4z++gzdXNLLENNp/CRsm2x/fSgINHtTTxh6dLQDtiSfcMDsC9RPi2Uh8Iw3K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5184.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajZsVk5KRjlCUi9SVjJWN1NTR24xNTBnTlY4VHpqaW1mL1pIQjFNNGdhOHhR?=
 =?utf-8?B?NVdBRTVjNzh3Y1B2REtUZW9Qd0YyQVRHOUplNkQ3clBGcmhIbjZWb0tIb0pX?=
 =?utf-8?B?WjV3c0pvWUx6bzlLbTJNb2hnTWVPWnlqcEx5THZuakRWdFg3OGZpTytqSG1V?=
 =?utf-8?B?WVBIV01YN09PMnduYzZRTDlCK0cvcEM3ZSswWCtabmlERU9SWTNoQjZIbnhK?=
 =?utf-8?B?NDVXL3F2U2M0Z1BLN2krYlFGa0UxNTBnMXV0dk81R3I1NDNrS1dSV2p4SWU3?=
 =?utf-8?B?STVqZnN3VSthMmY4ZDFIWXlzalBDcFBjNXR6dE5WSkhvMlErdlJjWXlzOHdF?=
 =?utf-8?B?VG8raWFiWVRyMTZhRXByd0QvNjFGK0doY1dTSUcwR0RibTIwRW1BdXB5SVNG?=
 =?utf-8?B?QVdoSkJuWlBudURVTHNOYWZiNkJJb3Rzc3JhWnRBWkN3bEY0ZHV2VjIwTnB6?=
 =?utf-8?B?VkxWak1KM3l3azFoM3pubDBNclZoN2tiR0VpaGIzdFNTQVQwU3pJRVc5czhH?=
 =?utf-8?B?M3lXZlZ0Q3BUaE85amJQd01UeWM4Q0NxM0dRcGVLSnRBRUc2T2RyNzJoZE14?=
 =?utf-8?B?ekNNMGxSR2U5ODlMM1U3YWxVVzlxQXZqRlRXaXNHK0E0ajl5RnQvTHRONTZp?=
 =?utf-8?B?Y2w5K2VxUXNVL21RcXlpNXdOdC9xcnJkc0d5MDNla3BmTlZSbHBrVm0xMG5a?=
 =?utf-8?B?U2hJMTQ2S3pYeS9KNzdDL3ZvUFdXMkd6TGVGNW95Wk9iUEoxWW84UzZDUFB0?=
 =?utf-8?B?bXRCT25NTTZYMVRFWmxOdW1ydi9uWkIweVRxM0JzOVErWXNiQW1FM0w3NFh1?=
 =?utf-8?B?UHIyVGJhaHV5V3N3QkJtbHZYUXRNWThQc0pxcGtkMnRneGkxc3Urak5pMWps?=
 =?utf-8?B?dHg1UTNyQ2lwU05CN0d5V3NjeTZKQUF3bG4vdm1sVXFXNkFoak1qdzNKcVor?=
 =?utf-8?B?Z0U0L2hmYnJUZ1JXeHpWSzU4SzY1QnRLVXpEYnNndkd1OGxQUXZJZmFzeUM5?=
 =?utf-8?B?N3RsZ1I0U2NVWjJhS0JWN3RUYmViMU9jQ2FXN1EvU1M5NXR5OXVpbnpndG1y?=
 =?utf-8?B?VDZwMGc3SEJPbFlGUHo5R2QySHByd0Z4VWVhRTZ3em8zNDlVdnQ1NnRWaUNB?=
 =?utf-8?B?ODFSUHA1akpPekRhUEVMdktaSlo1V0dPUncwVThtYmxjR1RLbDUvaGZhSEd3?=
 =?utf-8?B?Uld4MjMvU3RDSVQ0UDRHeDZOUHRkajB5OHFvRlRMVkJqZFpCY0pvYXFHMm9N?=
 =?utf-8?B?eWQ2djJhRjdWcjAzYmZOM2Fack91R0ZsR1lLSmJVTFpFSVo1MGY0bStteEIx?=
 =?utf-8?B?aU9uTXpnemRuUC9wcXVNSVg5K0U0ekk3NDI5NmVlYm1YRDJQenNhWlRMcGs1?=
 =?utf-8?B?T3RDWFJMVXBXM0ZEejJXVG1hM0xFaVUwK0tCd2U5UWdOMFIyYkUwYTdNY24y?=
 =?utf-8?B?UWtlSjVGN1YxVnd4Ny9SdnZuTlJDajdRT2FDS2xubmVYR2g0QXpxZ1BNU3VC?=
 =?utf-8?B?V2Z1VjREMU1kRHhOdEZaYjgyNEltV3VFLzNmN0oyRTRFNThTREY2R2NoUm9q?=
 =?utf-8?B?ZVVCZURNdnhPTkszMW5JTm5jY2dPc1MydGhOYVA5allwVUNyMDVvRzd4R05q?=
 =?utf-8?B?YzNzNzI4VWxseThsdS9jc3ptcWRYa1k4NllMSEQzOGNDKzNHNi9XMU54cUFB?=
 =?utf-8?B?dXVSV0ZmZGgrMEZEc0t5T2VpSlNieVdvS2RXNzgrenZzdVMxbW4zQjhqUmZZ?=
 =?utf-8?B?d1JUOUx6VHB5ZVZMQnkvZzA2WmFYekRzY3hGeGZNVUl6THNxbGVweVVGZEVT?=
 =?utf-8?B?Zms2S3RSOXBFRDZ2Mm5kTlNxT0tTSDZqajB1ci9pUm50bUtNM1hrcVRKYzdZ?=
 =?utf-8?B?bGw5MjQ5WTRFZ2VyZ2xGL0dxUzB0cnJiR1kwTGg0RW9HSHZ6bndxaS85YUVF?=
 =?utf-8?B?NEdtZFRqbUd0U2M3UWtQdGdCK0plUW44OGViZlQvRjlzMXNvQUdiOEs3YkNj?=
 =?utf-8?B?aXc1U3FndU9QYkR0TTE0TklKS2xYbFVIK1lUS2pvTzR4cnY0RDgvU0toOUhS?=
 =?utf-8?B?M1NWbFMvd2YxcDJ0QlpFOXZTZm9YVXRacUpYaTVaTGxNeWlVNTFQcXhmTVJ3?=
 =?utf-8?B?Z3VZb09yNWcvRERSUTB4Z1dsNEl1S1ZGTXVuaVZPSzRFaHR3d0d1TlltdStL?=
 =?utf-8?B?ZzFHNzJKTW5uNWJLWmt1QU5DQUxKZXpMZWczUzZzN2pmRXNscGgvbXpiRVFM?=
 =?utf-8?B?dDBYY0M3N1NrZkxVWW9XV2hQRm11RTZzTXRIM1BxaktmbHBSY1JvMDNsOS9E?=
 =?utf-8?B?c29hKzFQRzV6R1JxL014S25kL3pabkN4M05XMGdUQnNsMk0zVWRTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd16458-2d7c-40ba-2357-08deab235dd6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5184.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:55:52.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qd8CZFzrzipIi2q4vQgAFxVZiKUeSxyYuIYZlscJ9zjGXx6ubHyYXoPN6syOSTlnDkSq7bjHHhkR1HygtqPwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
X-Rspamd-Queue-Id: 4D71A4D602A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284681-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Shyam-sundar.S-k@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

+ Prashanth

On 4/28/2026 04:58, Jakub Kicinski wrote:
> On Thu, 23 Apr 2026 10:18:49 +1000 Patrick Oppenlander wrote:
>> A recent change [1] stopped CL37 autonegotiation from working on
>> amd-xgbe hardware.
> 
> Hi Raju! Are you looking into this report?

Dropping Raju as he is no longer with AMD.

Thanks for the bug report. Prashanth will maintain this driver going
forward.

Prashanth, can you address this bug? Also, please update the
MAINTAINERS list by dropping Raju's name.

Thanks,
Shyam


