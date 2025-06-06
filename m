Return-Path: <netdev+bounces-195435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1760CAD02AD
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E4A1892159
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2729288C03;
	Fri,  6 Jun 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UCW7YMbq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C21E4B2;
	Fri,  6 Jun 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749214750; cv=fail; b=neF29+MUN5iI37IDBw9nWoelh8O7tvyNj3nTtzLPX+tk6pYq8OeVffYFg3U3lYiLGLmVvMl3CzKCXG4ZsWDiZWWUAkaMR4gxfHguwUWSbq/X5fYd2o5ig1KarJ7QahfL3pLgnbtXNF6CSVcE9X6ErBJnKeFmERt8drQIxVS7Z0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749214750; c=relaxed/simple;
	bh=HfdJBu0y2lmlOa0SeySf5mYEWk4ykFecpamJwg/yER0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UoQI/swdNmcU2VMBSKfbaDlGtngW8SzrvUd+tbIbbKISQodjWLRqfcSj/K29ElKgopYKsecH4+obhCBgX3EP7bCiIDPzNWY0/edvY7UNvUooGRBIF4lxjP1V4eA4tmluHqG0pG6psSLsOwMoFPUAEFSdU/D+lfB6gezdIezYZ34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UCW7YMbq; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kkt6p+Lkv0jxTVvmuHnVTYqLffsRs3XeV+fETVLlxhDTObXycEtH45wE6ClcJgsskqy87o9euQJKfK8uwSVE/BhhQHl9BTDP4Jv/alOQR6+YL+2DJrbTB0/B5nuPnWUR59M0vZNJzAdwytQI1lIOM7+cbXksnI64ORYp9sTCxsd1SDxuxVbnz0WCMcmPZSDlOm2KMDmgpcdXyZeqrb1/2Nu37mC0xDY0wMIOc2rfwzN2aEVDP03WoTwSVOZXSuX9X9+ZnznaoCOtreUgm+hg69OL8UeBo1oNGdhP4V3clGk0VIL7xow9R24e/3u6AG79Lb/kiqbo8eA/Qd8p72fuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DdqLhCbUZDZiuShUlB6gJnwy8IpWurFTq5yCES3kjg=;
 b=tSZnJvYR8YYWJZZKRiJFJ1SU1YjVgOVmJqoMV8ubmtiH3Rx9Wa0LAvEbTx3kQrYGUew45y24cR9AP94bKP7z+Mq5+PmwK0Pjk+J9oJhJFFafCx9QIugRAoCQRbrN003AwFvgiHpmrzOnhS8DN4xXEl2B6HZ+emL83qJ6WZV601Aet3pdAJsfB6mGujqFXIkl6p/8HDvW1IXXkOhL1pWKp7sFLH6vPXIM2chtwHIkiYkwNtHoGegYZKWiXiZBhdcSQ8bx1Rx++V/WvGw1fp4kK4l/BVKXOI4iITwvp8mBEgLZoYqYQ7z0Lyu6WiT0AEq15Ctfd0toLn7qmu1MAJo1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DdqLhCbUZDZiuShUlB6gJnwy8IpWurFTq5yCES3kjg=;
 b=UCW7YMbqgYAVEgGmzld/3+ZorQQVdiAmBt50i1l7qyapsw39IBm/hSfK/VS0i2BkYv2OE8IsCpvIlTpGCuqAKHJqTl+p87vXNQHQf9IrarAezoPJ3thYuMMzeDQN5VxEaRmEVUSvd0Qh8w/o4+dWh1l1NKdbrn3JTVnDuTJ1fGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Fri, 6 Jun
 2025 12:59:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8792.036; Fri, 6 Jun 2025
 12:59:06 +0000
Message-ID: <075cb524-a515-437d-bb9f-b80c52eb5de0@amd.com>
Date: Fri, 6 Jun 2025 13:59:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 12/22] sfc: obtain root decoder with enough HPA free
 space
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-13-alejandro.lucero-palau@amd.com>
 <682e300371a0_1626e1003@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e300371a0_1626e1003@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: e162b06a-ce32-43e2-917a-08dda4f9eba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFVLaGhsNGhhVGJodzQ0SmtyQVU4UDBGbjNIdkhxRExaM3FXclkwcHNKeFhY?=
 =?utf-8?B?SnoreDhYYjFGNWdQZCtNY0VpbXpXOGxySlQrbkRlWExLYzFXRDFackJoUmsr?=
 =?utf-8?B?bXlPQ3ZqUm8xN01uZVFMTW8vZnZ3dnRCZTRPRjhTdTEyTTlQREhuZC9vZU9i?=
 =?utf-8?B?OVI2Ulh0aVB3R3orNkNKODhISkxtQmdCTHNmdDJUUDNrdjdLNjFKelpIQ0dH?=
 =?utf-8?B?S2wwK2QzbVp3Sm9iUjUwZWZhbGZEL2hTUDdFWENJTUw5bWxCL0ZUUEIxRXRL?=
 =?utf-8?B?WVdzbWRhdFZTNzBidm9HdzJ4cXE3eUxsZzJZMWlqbzdyMGFjMW11ekxYNVkx?=
 =?utf-8?B?alpSMlU1ZXFMZEs1RUtoOTBYYUZwSXFUT1QzUEFBL0NGQ0JtR0tQVHhtZGR0?=
 =?utf-8?B?VGFnSU1qbllHUytLQlAvcHJ4TEd0L1c1MlI2NmJFQkpYRmllSzFlWHRaSEJq?=
 =?utf-8?B?Q0RyMWViUGtCQTltQjFzektCc1hMRFZ2WmQwUWhqUmIxaSs2UFZKSjZNbE1R?=
 =?utf-8?B?NStRci9nSFUvYlVNT2wrS2lLaE5lRDZLcEtWWUFybUNvbDUyMGxyU2pkVWJV?=
 =?utf-8?B?ZTE2RkgrNzM5T2M3U1FoODRvZWQwdzBLK09POVFjUTU1cGFobVNycGRxRGJM?=
 =?utf-8?B?RHNoOTVnZEVEWnlVZkpGTUlpMEdKb1VWR2Q0NGIxbkJzZjJzUFRrN3RPclFq?=
 =?utf-8?B?eHliMS9TTmszbnh2Q2ZXMEtDYk5YTEl3eDBhWWtjY0R1MGM3aUx1SG1CYTFi?=
 =?utf-8?B?UVBibjJ4VnBBbGhMNk9JS0Z1UzMvNnZaU3NtSDhhQ1pWWmZJbXhHZWpIZ0gv?=
 =?utf-8?B?TjBhMitBVitzWmU0NEdXcjA0eHpva0k0NSsyazJjNndEamFNZy8wMnVYRmJZ?=
 =?utf-8?B?TWtic05IQWlUUmlpU2FUZERUenJBdGVZbDFWQzNqQnZMMjRwOEd3VU4ydG1Z?=
 =?utf-8?B?MTlTR1RwUlJ1OTlnNlVCWnVwcVV4aHlnSitZTlQ5QjRlTDlXak5pbzVCaUYr?=
 =?utf-8?B?L05rSjlWYTI3Ny9jdmhYZzg3ZkhXMXlEQXAwV0JHSDh2M2NySWVqS1R6d3Zh?=
 =?utf-8?B?bHZTQURuYmJTL2FXbk9GckJRVGoyeVNUa3ltSUZLa1p4S1p4VkRkaUdIVU0y?=
 =?utf-8?B?OFNta3dzbFljcUxxWUhkUDBaQkpiYVYvNVZEejRjNWpPbHVGMzk2bFd3eFVQ?=
 =?utf-8?B?bkhQRWNkdnJZNExITXNOa1VBWnZpSGZ0VHpPQmxTdGVkSXhLRHdrc2dsUzNs?=
 =?utf-8?B?Q21hQUVyZ1NKYnBpQmJFaWkzM29pWHUvbDlLUFNQbXJtNG5Rem5HeWpRQTU5?=
 =?utf-8?B?TlpIYjFWaXZRR3IxaXlFR0JtUDAyQlNxaGNrejRCQTFCYlJwcWVOT204emMr?=
 =?utf-8?B?cGhldFJGZzhiMVR4ZUpQWktiSTBrU1dTMG1KVUY5MVVBQ0FnQjNFaGFvUi9j?=
 =?utf-8?B?UTNpbS9kM2c3Ym5Lc3RET2pQc2lQQ1hMVGZDdGdybkQ3SFRJdExVMEUrYVoy?=
 =?utf-8?B?Q1AwSmFta0tQWXk5c0xDU25qUVZJNm9Ndjc3b1ZwbituTDBnczFQR1I3UDVX?=
 =?utf-8?B?Zk1QVDdJY2hlT1NOZytBZndMb2NtVk85OVk2dFlmY1cyT01tajh3dmRIR3hp?=
 =?utf-8?B?QVIrdUJIaGs5NHlwUEw4NjZkcDl3d25yRTdINWlOT2hTVm41bS90Vy9rOExL?=
 =?utf-8?B?TUxjUnNkZE5WKzZLbVRzVWwvVUFGUTRFNmswd2dpUFRYaThxVndBT1NuSHVl?=
 =?utf-8?B?eERIemxDSHhVRkI4dE81RkFCeVAwZDFFbmhLblBWbHhpYUVEaWFLdGdQb3c4?=
 =?utf-8?B?Q1UvWUQwTmFWampxRjhSTi9vTWZZQm1pZ2tHM2J0d0NCZnBhaUl4dzZlcWtQ?=
 =?utf-8?B?M2dQdGZzS09obndPMlIxaFN5d2VuTU16eHZHd3E2eC9BS0cvSk91bEcwdTlv?=
 =?utf-8?B?YndEZ1kwM2dnMkk5aDBPSlpYeHoza09NRWF3Y3ZyNHFTS0hGbkc5NDhraEQx?=
 =?utf-8?B?TU1rMWMrNHN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2RDdHBUS1BmN2pOL09JSkNETElWT2xjKzNFRjhKNzZtdG9aWlhnM1liWWN1?=
 =?utf-8?B?NDVJUEdFSGlhZE1kYWp6TVVaK2k0UDhhL3lDNVphRkhGUlVMZWcwMHhPNTh5?=
 =?utf-8?B?YnJmNE5hRHVHa3BPTVBSSkxhcmdDVE9wSkRHUWFRTm5Jc1RFMFJKL3NrRk03?=
 =?utf-8?B?aWJwR2wzbWNNSmJLYVlnWkJvNVcvRldLQmUrV0JNVEdHQWRIRnR2dU5DeGlX?=
 =?utf-8?B?aGpPRE5pV0FqNnRiMmg1OWdkdE12SDRyTnRHZmNrOWlRQzRmSkVPRkp1RDlX?=
 =?utf-8?B?S0xSdHdYeWYxbTN0U3dHMUsybkVnSVk1SThYL0RRV3lnbm1yUW96bzRlSWJk?=
 =?utf-8?B?SUJwcUl0TXZNK0UvVE9Kc2VHUU5IK1loRmVvNmQycGRsc2w2ZS9DOWZ1eXc4?=
 =?utf-8?B?SHUxMktOWnpEYlZpd0ZNT1BCR2s0dC9kSkRKWnMrNjlvWFkyRDZLQ3ZXUVJx?=
 =?utf-8?B?d0VzQUpWOCt4M0NQMnI5Qjk3TzY2SGRsODljY3Fpbmd0b0s4YnZHSHVtRThz?=
 =?utf-8?B?Q3NRUlpNVVJEUTU3Vm1wQU1xVGQvL1lGL3kwc2ZHcTdMN0ZyK3VZZlkyQjl1?=
 =?utf-8?B?TGdBOHhVcjl2cmozemgxa2hFTWhvYVRIZ0JGTjFaQXJKVFZpcjRyKzNGVm1G?=
 =?utf-8?B?Y0NGK3FZczBhQlhhSHpaU0NLSXNTSm5XNHdYdXpkZnMxSk41cnpBRWliZzFP?=
 =?utf-8?B?dStNdFdxSS83Q3F1eGhEWDBEQTVDcXREaGVPSFN6YUdkU2paUUhRU1ovei9V?=
 =?utf-8?B?WnhHblFtRHZYOERMUG1OMGdsSWlxendrMjNLTjR5M2pFYy83czFGeEVKUjA3?=
 =?utf-8?B?alJ6UUZJR3pMeEtKcmtqSFpaekw4UTI4TWw3NzMyb0FsMTZWcDhvS0MzdGhk?=
 =?utf-8?B?WEl6OE51cHVRTG9McEVDNkJQV3AybE83OVpMYnl3dWFRWWM2ZTV3ZWpEZms4?=
 =?utf-8?B?RUUvd1RRTzBZdVBNYThDajhPT253bG55QUtQWWViRnlGOHBXM0VyZEpGandx?=
 =?utf-8?B?Tk9tU3BKcVh4dEh3MlYvRWRtb0Y4SHZGdXZqcVJ0TjlCZFg3L2daZ2QvOEpl?=
 =?utf-8?B?M0h0ODBVUmhHbUxYcmN4OGFobHp5czM5akJkOGRIaWRaTlRmbDB3RTVCUmpK?=
 =?utf-8?B?dGFQTmJGdGlhY3UwRWhCcjJ3ZGhISVhrajVDN0NUM0dvRlZGdEp1ZDYzcmds?=
 =?utf-8?B?MmNmaC9TaW1zYzVDRk4zTWhCVm9qNzJUTmdYaXZhc2N4Q01VQllPOXo0em9O?=
 =?utf-8?B?c3FVUUIzNzBZNzNLcE5XU2tkMmpiK2xJcEcvMXBOWERGQm9weWs2cC9vbytG?=
 =?utf-8?B?QVNsQnlIME5wM2dQTWpRUTlodGgxNmVOWEEyMWJ5aXFGeFpxMnV0NEtsdktX?=
 =?utf-8?B?QzhkaEJYMnZhb0NoVTJNMUU3VmExeVpTN0hUMUNwVVlaNzhORGtwRmJHOU0r?=
 =?utf-8?B?bE1hdC9MaCtKaU5KaC9LWXJ4S0IybFNDanlmVDFyd1JLenNES0hHWnhZa2My?=
 =?utf-8?B?Zy9kNGE1dS9pbzdlV2ZvQjRUOUlyeGtGYkdrZXdmbllXK1hkb2hjZ1ZXV2FD?=
 =?utf-8?B?d3NQSnFodE1vUk9IN0JiRUlvZ1JtRkIzV2pMZnpzRU05NHo0bVBtWHpwWVVU?=
 =?utf-8?B?VFlmV3U0QzFiZWJZZUorcGJ4Z1BEeEcxK28wWDBNb2dzWko2a1Awbkd0RWE1?=
 =?utf-8?B?R3YrVktkZkJQTmNhcDdsYlVKMHE5U3ZnM09xUkl6Q1ByU2c3dWkrbkZObC9m?=
 =?utf-8?B?ejZTN09FN0l1Q1hNaHdTL1VXTjRBUVhjV2k2VWZEdkFqMFpkZmEvOGlFWU02?=
 =?utf-8?B?SExCc1E5UVBTT0lUTTNNNFN4SEx2ZjhwVU52R3lWWFNWSHRta0Fvak9vdHBq?=
 =?utf-8?B?MTVTTklCNUlid05kWThiZHhDQnpTYTdjUUlNL0c4bDhMdVB1MW4zSnBtN0VW?=
 =?utf-8?B?TWNoL1cyaExtZ1Ryb2dqTkk2bExpOHQ5SFZGcUpHV2w4U25wWUVuUG5nQTVz?=
 =?utf-8?B?a0lJQ2taUWp5TktzM0k0bWthdzlHcDZvWll0K0wvTElRSTRwcnNDL1cyUk56?=
 =?utf-8?B?VnRsTkd0WmlMYXdacW8vS0xtNGJuUzFNRVNKNFRUSkk1YVg2YXRCb3dwNFM0?=
 =?utf-8?Q?YWTdnlQG28Dv3UWyoHWQVZ1YQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e162b06a-ce32-43e2-917a-08dda4f9eba8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 12:59:06.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tfLgcuztmTflqLqdzmAEIe6Z5afEortawFQXdYef0/Log63WQZi90ZSZ11+Vrndah0lx0KhB2HSzgiGHTM20Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515


On 5/21/25 20:56, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Asking for available HPA space is the previous step to try to obtain
>> an HPA range suitable to accel driver purposes.
>>
>> Add this call to efx cxl initialization.
>>
>> Make sfc cxl build dependent on CXL region.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig   |  1 +
>>   drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>> index 979f2801e2a8..e959d9b4f4ce 100644
>> --- a/drivers/net/ethernet/sfc/Kconfig
>> +++ b/drivers/net/ethernet/sfc/Kconfig
>> @@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
>>   config SFC_CXL
>>   	bool "Solarflare SFC9100-family CXL support"
>>   	depends on SFC && CXL_BUS >= SFC
>> +	depends on CXL_REGION
>>   	default SFC
>>   	help
>>   	  This enables SFC CXL support if the kernel is configuring CXL for
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 53ff97ad07f5..5635672b3fc3 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct cxl_dpa_info sfc_dpa_info = {
>>   		.size = EFX_CTPIO_BUFFER_SIZE
>>   	};
>> +	resource_size_t max_size;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>>   	int rc;
>> @@ -84,6 +85,22 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
>> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
>> +					   &max_size);
>> +
>> +	if (IS_ERR(cxl->cxlrd)) {
>> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
>> +		return PTR_ERR(cxl->cxlrd);
>> +	}
> This is a simple enough model, but it does mean that if async-driver
> loading causes this driver to load before cxl_acpi or cxl_mem have
> completed their init work, then it will die here.
>
> It is also worth noting that nothing stops cxl_mem or cxl_acpi from
> detaching immediately after passing the above check. So more work is
> needed here (likely post-merge) to revoke and invalidate usage of that
> freespace when that happens.
>
> Otherwise you can do something like:
>
> Driver1			Driver2			Notes
> cxl_get_hpa_freespace()				"Driver1 gets rangeX"
> 	--- cxl_acpi unloaded ---		"forgets rangeX was assigned"	
> 	--- cxl_acpi reloaded ---			
> 			cxl_get_hpa_freespace() "Driver2 gets rangeX"
> use_cxl(rangeX)		use_cxl(rangeX)		"...uh oh"


I've been thinking about this and other similar comments in later 
patches. I have to admit it is confusing, at least for me, because I did 
not understand why cxl_acpi or cxl_mem can be removed when users/clients 
depend on them. I think (but maybe it is a wrong assumption) they should 
not, but the code is not implementing that restriction. In other words, 
it is not a functionality but something to fix with two options: to not 
allow that to happen implying the removal needs to detect the situation, 
or allow it and the removal unwinding everything depending on them.


If this is the right assumption, then I understand your comments about 
cxl_acquire_endpoint. Maybe it is worth to say I did relate 
cxl_acquire_endpoint to the problem with the initialization and device 
model probing, something that IMO requires further discussion.


> So longer term there needs to be notification back to the creator of the
> memdev to require it to handle cleaning up when the CXL topology is torn
> down either physically or logically.
>
> To date the CXL subsystem has not reset decoders on unload because it
> needs to handle coordinating with HDM decode established by platform
> firmware. Type-2 driver however should be prepared to have their CXL
> range revoked at any moment.
>
> The Type-3 case handles this because cxl_mem is the driver itself, for
> Type-2 that driver wants to coordinate with cxl_mem on these events. To
> me that looks like cxl_mem error handler operation callbacks.

