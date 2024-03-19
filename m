Return-Path: <netdev+bounces-80643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634C880225
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D11283399
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBCB84FD2;
	Tue, 19 Mar 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mQvpT4KW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9F84FD4;
	Tue, 19 Mar 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865103; cv=fail; b=a0oiR7j3BpYUBwpQJ/tVA78JNHrOaRO6hOz4zbwQd6etHFv9J7grMivYyf3v746fMMwmhf2P/zLRyjTW+0bKn5Hqa9ANDgCgGfavZx4Fl62ZLXxNivhIEKEZ4SfF747LnO7R4jo8F/SW6y+VIZxybcQWJ0BB6H+pOmBULbi6rBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865103; c=relaxed/simple;
	bh=PtEYQ8QVWWt6vx0o0S4sndWqJcsDsp4bIVhZMF2/dXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qj8OEaTEM0N2KdESjljpBZLY9QMa8sf6LHUM30HFr2/KYDDSzx7ampK9dv2EWhw1aoqWrFkgPY4zdPKhHjftI9CmGx8G9pna6PXRGWtPRy51pV6v7QijC45odIPziRiTcTZJs0zKqVob8yCV2gdZAWvSul7hzjXq9yDMZx0bj10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mQvpT4KW; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGkoBavhJ8+BNbHTFUqOC/PYn2QaUnF4zHz5G9bZndIkdvKoCmz7+SfVVFwE/6+gncXj12Pv3Y7UwgMBCC9VvYm7mLnRZFLnDBCEq9bYrJQH7DQv6XFdwoxs3t5X/relDg1rJ1hRzm7OB8ee+qnVuGqz0jxTUjqTXapDzF5UJjGsIJtenUigwqjA0s32xnpFGp22vJE/7qJcm+xsWrD68XJPy63MC3H+up9371A5c0ZaCGFfE0sFU5LtX3K65jlSgSoDQ7p6oNL+BlS8+yGnWhH4npZgCXc7+O1tJFcw7a2AA+qb1zot9OyYFvKUCGeW5eTYJYHKEtLOpk5cqfaKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSlt1OGYyoCdbfyBACOzrGe8khtkkybqSyqKxecekJc=;
 b=EaTv6RgPBWg+ZaSutHonjNLUmt+JFSYFJgavFoXFXfJlRRK3I/XXxITc30dStvjOqUJLzSmV4QrP2xpiReA4Ym7pMn3mm/oOov+XvWj1+qRJFInBOkJvHy8Qd6wN9QJKNR4A5yfchHu7mnWrB3t7m8lNQmTjx7/uDFXkrmhyjobPg8MlZ0xWLXBsGeu2KVeuyR/hMuW0rr42mcFCKz7vcOFOHT3C6Lry4yZt9bPKizUJak4sbajBrH1WhHOcb56FCTxyhLvPmGmHxMOUC4oQQNQV02ux/m5cEB8NNKQ6IjtpmyDFNaYXGKuFruH7iptpVsNjrlMGljJIcl4w15rEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSlt1OGYyoCdbfyBACOzrGe8khtkkybqSyqKxecekJc=;
 b=mQvpT4KWz5kc/xuqN1tOg0YE7BeWKJN3EoIGiMYUh3y1WymACkhEsjW7qFUf1hvU0sqIsPVsEKsW3QzA8HWdGBkKwDzqA5HFHXnC/tSHlb59fWEMPHqgXn4ixlFaNrlvwoIOupleElT1JfDbvZ5Iz1drN+Aa7vXvtGTyf4yaI3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Tue, 19 Mar
 2024 16:18:17 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::11ac:76e:24ce:4cb1]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::11ac:76e:24ce:4cb1%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 16:18:17 +0000
Message-ID: <c68a0c77-6d92-4cd2-b747-0588e6586aa9@amd.com>
Date: Tue, 19 Mar 2024 09:18:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ionic: update documentation for XDP support
To: Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, brett.creeley@amd.com, drivers@pensando.io
References: <20240318235331.71161-1-shannon.nelson@amd.com>
 <Zfjxn3tLlHGRHXMV@archie.me>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <Zfjxn3tLlHGRHXMV@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: b677939d-155b-44ab-c6bb-08dc48302f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DlAs+40R3HWwG9+Lk9l6Wx6nDKBQAf9C3bFwPAB+tipBJQu8ij/cp2kxYJAUuvdBjvG0gPWIvW8XvBeF17z9zsZikcJ5uBgigUhAm7YRDTOfJEilLt72hOBOuEEcExm8fysH9+U20FN/tVWON71Zn/aGoTp8MvEFHJwuKAx8YbZzo6/rZx1IMK5Uy/h+2Vrmr74p1LGNbHhahXCV9eDz/fjZ1qjoLN5LEc4lwkXRvT84/M0u3Y5jDSWsJFzrbFgw8Lqd1d3y4dsVM8fnrDisCSfYPS5ahL3nb5I7jsb/gHqfg+afkzKIOTdItcaHTBwpBpYvdE1zfDd/RyqkdcOVHF/Qcxk3ScIsSaerHmfKtq5CNemXL4gbxPqLiG3opnWFU83FPQGZd4pn+986Y8ivKBS3zzRg/5pmWJusk4+detBSgXHzcyFBBleXudjP/Y1SdR9LFjVQ7OZUSRobt/1aGC1deKic/m/vWjKTHe1gosRGI4hyD64kwCzccIu6NtRR5/pG5MJ8TL9z5r2m9ZmURaRMAnHk0jDfLfbtp1Ov9+jzH5wnl3OZKI7bE4lwwsapDKXkMWDI8RDqhZYa1ZJveUGdsoIAX1m/GeSH2QUq+a1e3kOIu318xPkEcrhI6N0QMEyggCJcsT4qXwCa9Zds1KXvRxzKo5iQql8OqDory74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGg4d0dQRmpSdndMQlgwRnVzK05kREhweU54dVhENTBkaCtubWlBVENKOGcr?=
 =?utf-8?B?aUpWZXlmOTZPZUVVcVg0SVI5RUpMd3pQeURMR3JtbTRPc3hPcFRvNkpmaGZm?=
 =?utf-8?B?cHZSR2ZwZlVNeTFMMzNMREdOUVN6ZzZTbTVIMjYvVVhFSXdjd2trQzdOUTd2?=
 =?utf-8?B?UEdJcEI0MCtTV1dMbUlkYk9LbnplOWFqMEJ4UFM4NnJlbWRDWVU2LytaV1M5?=
 =?utf-8?B?Y3g2L0Jld2VicEh1UUtOOFczUHg0ZXdRb2I2UWZ6eVhZeFJMR2ZOSGFXZXpJ?=
 =?utf-8?B?bFBJNUNNeWoxOFMwcTFOMS9GZi9hYmtJTkNXVWRWK0svckoxU3pFYlhDcDV2?=
 =?utf-8?B?WENGU2hkYlJtSWcrR2xUV0p2MFdpMks1TDNMb1dGbE1jbTd6V2MwbkFKNG5x?=
 =?utf-8?B?VENVSXF3U2s0NzFORVNWYk84dFFWT0l4dmF0M21uclFBQks1NlZ2ZjV6OWc5?=
 =?utf-8?B?bWRyRkJhdk04N3k5K0xueGNUaHdHNXREZ1lVQzRFYVlERXJBR3pTdk9sQ3Rq?=
 =?utf-8?B?djMwWDR0V2xzU3Ava3MySmYzdVBWbFF3Z0FaUEVySS9vd09udkh3V0pVRGFB?=
 =?utf-8?B?TWhIRkNjcWV2MXFGaDdoT2JDTDZBOVVhbEViTktBb1RiSFpIV0JqRDVFZTVS?=
 =?utf-8?B?TG1xdVFLM0FpelhONG1rU0NEZ3VCanp0QzZtK3QrQ2MwM0xvU0lIRDErdGNq?=
 =?utf-8?B?YWdnVzJzeFZhQmp1Uy9yMDlScVBkdWdvRXNOZVBzdkpHZ2oxTmkxV2V0dFJu?=
 =?utf-8?B?SDdEVEZNUkJHeklwL1B1eU5VNnhCS2VDSmVPOHBZbVdNdDkxSWVzaTVacDFo?=
 =?utf-8?B?bXo0WlNnM2d2c1p1OHk2eWd6cmNqUHNNbzYrUVdyRFZHdllkVnR4WlVSaVRN?=
 =?utf-8?B?MXp0OEl2dXdMTjJKUU8zSEsvQXczcTkvSFZmODhzMWlkbTJJWkgwRFB1R3gv?=
 =?utf-8?B?UXlFM3Q2M2NtR0tQQ0lrR0hZQWE3NGdudGJOZWJCbXVQbmFhdmMyWU9ENTVX?=
 =?utf-8?B?SEZMY1RhV08xUUxrRHNWVUVqZFROM3RCOWI3NXZEcm9vMUNwWkgxZzYxL2cz?=
 =?utf-8?B?bnpQSFo0RklxWUxOUXlIM0ZtVDdWbVlkUzcyUGV5VzBON1dwMkUrbi9wUm8x?=
 =?utf-8?B?MXNQV1NyLzkzanZUc3FkMWlPditOcFc2QTd1Vkdtb3lhWHMxOWxUU0JPU21D?=
 =?utf-8?B?VnNYaVREWWs5S3FrL283OGZ4VnpMVXcyb1V1RFM1MmpERGt1QkVLSXdjMEVX?=
 =?utf-8?B?WlQ0Vmo1ZHlqOWZuZVlrQTRpQmtzQVBjcVhWNUNENEdLWE82YUtUUDljTitt?=
 =?utf-8?B?LzRyeGliQVkxZGRkNG1yV2llWDRBTzJiUjZaa2kzKzZORzlaS0xnZzFzVU9s?=
 =?utf-8?B?Y1FNWlVKajFYY0krWkpLdC9hNGxOT0dPb3VmMDBHMXBibVRWRytUVFd4SHhn?=
 =?utf-8?B?a3pub2Y4WnBGV09uZnZULzRKYTNpaXFBVlhlRGo3dkl2d1lJQm9YV3lqdHJ2?=
 =?utf-8?B?d1VjS2NSK2o4M3U2T293RDB3ZUVhSDkrR2dJWjB0YWRHMHFOTllTMXV3RjV6?=
 =?utf-8?B?bnNVaFQzcUFlS1VMU0FCRWpuY1QxMTdPdlhWVkthK25oUmorRmpoZGQxRzJK?=
 =?utf-8?B?bHYxSUhGZWNCbXN2UFNscWRhbGZXSTBjTms4MnBWQmlHbXgzUSt6NzlIcHdD?=
 =?utf-8?B?VDFZeGhvSlZvTXRZZGdFTnB5SjVFbzJNU0pzSWxDY05wdHVjYXpYcjM4Tmsr?=
 =?utf-8?B?eitQUVJSeFk3emtWYVlnQmpUNTRRUjJvMGR3RGdGV1BQZXU0NnV0ZlJ4UzVu?=
 =?utf-8?B?TFdBWnJ3ZTFTdUQvZzRwZTFwSkRZcjM2d0l1VW5GR1g4T01LVmh6YmdDbUY2?=
 =?utf-8?B?RDhES2ZWYUp6Rzg3ZmpGVXNoY3FiVlpKdmR2WVZ2RWo3SlVDaDMwVFJkNGxJ?=
 =?utf-8?B?QXVZMy9TTEdraWpCT1hNcmIyNzIyeGtzaGxUYkNsVm5tYVA2bHQyQTFIbmpq?=
 =?utf-8?B?bVFUemFtZ21yK0ZNZmV2dU82YU1SMXV1a3BVQ1p6VnM5c3FxUzdubGpycCtr?=
 =?utf-8?B?L3hCWmFIamZyVGUwak85VWVXTjZKbVNBZEsxME5qUlV2ZjhobTMrQmw0MlI5?=
 =?utf-8?Q?MeIvbBk/WBPYzyKpagv8aXKjq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b677939d-155b-44ab-c6bb-08dc48302f55
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:18:17.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvl1pUvEmXLyp6zDtLzDVLs7nqOIHL27gPMb/yeCpZGcIHmptmM0tIyY3V5qxQ9ttLxuVIIEKI4AsFB1Ya2rtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

On 3/18/2024 6:59 PM, Bagas Sanjaya wrote:
> On Mon, Mar 18, 2024 at 04:53:31PM -0700, Shannon Nelson wrote:
>> +XDP
>> +---
>> +
>> +Support for XDP includes the basics, plus Jumbo frames, Redirect
>> +and ndo_xmit.  There is no current for zero-copy sockets or HW offload.
> "... no current support ..."
> 

Right, I'll fix that up.
Thanks,
sln

