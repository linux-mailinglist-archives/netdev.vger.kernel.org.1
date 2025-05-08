Return-Path: <netdev+bounces-188967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B6AAFA52
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3471C21591
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E8347B4;
	Thu,  8 May 2025 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xZBjpYKN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5AEEEAA;
	Thu,  8 May 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708330; cv=fail; b=nMhjFStQEAOTv1HQr1QYYyF39rzcpgDH0kTFiHCOzU+GoBOJWskGa3OE7UMBjuBtJN2MtL5Db5dLmz6P3KI8K+OGnJsUU4hTYr3ki0yZ/n8lk5Q91MIhGa2HkM/9yHOjEcXYLAXyTVcfMB1fS8ejQm25UrF1eeOee4+iY1EeDVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708330; c=relaxed/simple;
	bh=9K9hmlP5rn0qKB7zrPl+WwvssL8t/VK07f9eAF3TvvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nnQKiiOcq6LAVTMP4C3qEYgKKvBR+y6Wqj1A+BB4Ki3tFR9GJy4Uw9xO7CgnmH3PdAQ91W6Pm3mwoyt6+H9S9tqSzDwQCJgoAV4KWv9pRhRYQrXlgJ5KbK6hLXdADB6/i270cZI9IVuMxI+V1JTwNFRXK3Nx5b1HPpRVUr7iStc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xZBjpYKN; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7emVXbZwCQbhfA4jbaOEaFBuw1pZ8CInaa4Uk5Or3CcQWsVV0ogIGuzdfQwBMp9ZMPUwGd9o1j9R6QDLOnpfVnAyT9EvsARyWHY+IvnWalaTDgZaNrKASuTELF+pMbPJ3qJNlX9e5WnP931jx9W4HY/JpgxNrNleKnZyULFQYgPx7qVXzlHnw39DMpnm0w8ZVdkzvbNE6ixoUSm4Ouvs/A1MuSPZyNPRDnW07CwhP35BdFrdE042q0uTOMJx5Td7Q+igSee97uN0Rl3ReXJRLG2J/a25bulqCeNOc7c4xlY35wEpCQ13Exgp2eMC56v++MtP5M6Hr4nDJib45DjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nj+OQnh6W1ieAXeBABytLuHdl2Y4Pduhc2FRCStUvP0=;
 b=ycnw86fBwJgLlJ2yu0DGlk4xHG8Rq74pX5emgNocz4oBFv/9Uyezdn+HV3IiFwzTvnzwCCGZgkvvJv+hV//DDxqc1NlgsB+4zPAjsFIlz1CAGDGo7zpbbxkFqhSfIjwqvD0QwA30CXlBOQcnRZGfxdgAmT+yw1q9fNhuxUnl++z5rMv0Hnn00wZZJoFU4OZ7lFv0bAZZnoDu2BkHW1kAGiUjbtfzaLdoogK1HNMQ1G64obY8syYnOrxLEDl6sqOb8LFnz+Ok9Mcc6NYFKMit1LSRVi4DCfcKZoG1jnPEeflJHPy2U8JzJ5BmKgk0eFTfCZUFysGMbgNYnpcMakNTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nj+OQnh6W1ieAXeBABytLuHdl2Y4Pduhc2FRCStUvP0=;
 b=xZBjpYKN9cNrloJvmznLvQ6i1aIgq+vJxyR8SjjsHYCp4Ow/ik2N8liyFkp+eQ9pDE/9hipJzznUNcmwGOdVgQqqE/5cKYkWP37JmDW6KiUtDw9PFomS2DPldJv88lhnyD5qyklMEkhE3f3Iup56Fwc62CP1TJ4KjQNnHbkdlrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.23; Thu, 8 May 2025 12:45:22 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 12:45:22 +0000
Message-ID: <92ff6f90-3b32-490e-9b62-0f516cb89ef4@amd.com>
Date: Thu, 8 May 2025 13:45:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/22] cxl: move pci generic code
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>,
 Fan Ni <fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-4-alejandro.lucero-palau@amd.com>
 <aBv8iyReoXruSaA7@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBv8iyReoXruSaA7@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0040.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 145f3f5c-1992-4f52-c34b-08dd8e2e321a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1FoS1hObll3b1pPQUlHd1lxM0ZmeWJMREpjUWJ2NGd2K2FjaE02dEt0Q2F3?=
 =?utf-8?B?Q2RWK1I1Vnlkak5YN3V2Tys5TkloMkJBR205N0hROVEzVEFkUTV6RkgzQWZy?=
 =?utf-8?B?c09iNERWRFlpT0lsdTM1eFBnNE5yazNDa0VjenJsYktFS3JuRTZpN2V1ZWhs?=
 =?utf-8?B?a2puVnpWOXd0YkZEOU8wd3lDcUpXR1pJRE90ckJkczNRT20vWEs4V0pUR0pS?=
 =?utf-8?B?OStWaXRNbmhRbzVUdWZUemc4Qzg1YjZMZTgzN2xDK2V4MXdkc3NvTW1tZUN3?=
 =?utf-8?B?UWNQQkJIYndKK3ZxMUJMQUxqOFhEaTlidExxZzE2eEpDR1RQckJOVGluVk1J?=
 =?utf-8?B?dlgxVnRZWkwwQUoyMExuaFZHUGZqRDZmWmpqSm14OFNzakYybE4wZ25ET1Jp?=
 =?utf-8?B?MGFZQUZYVTUrZ1Z1WDhEMitoM0dQWEVISU03TllZcVgvTUQzT3oxdVN0WUI4?=
 =?utf-8?B?UWl6Slh2cnd6ZDRlV2tIMWcrSGdvNEE3WStaaTY3eFdOSWxuVlFZa0FjcU9F?=
 =?utf-8?B?QkN1eSs3Q1huYU16QXEwSkhuUmdxc0pxVlFpSmJHV3M3ZkcxMHU0YUNuVFpu?=
 =?utf-8?B?aURUc2hORDhNWlFqcUNWTGJqbmZxVzVZRVZkK282ekQ3a08wN3lxVkNzVk84?=
 =?utf-8?B?cVhHeGlNenV5cnRRYndnVG9UaVo0Zk9STUVDTHZvVUVwSXFvT1lLeXFubWVh?=
 =?utf-8?B?L2k2TXBoUHhsZ0NIbkovNnhLUXdaVzhCVGhPcFhYTkVRSDN5UzExSyt5VzBN?=
 =?utf-8?B?OGVTaTVQallWQStQZ0Q0UzNzcHFtQ09UQzYvL1pVOXF2NnZyTUV0RTA3Ymdn?=
 =?utf-8?B?K0p6Q2h3cmw3bTR6MzcvczZRTWxOS3pvTWw2VGJpSmVaekEzVExjbEM4SXZQ?=
 =?utf-8?B?NXFTSlpQWCtab2FZbTFLZHU2dm9JRTcva1hjTUFDOVd2QWZYNjIvbG9wQmxp?=
 =?utf-8?B?ZFQ3YWViM2ZmM2p0YlNla2tKWHZJeEo4VE94clFqV28wOCs5RzZ6VXRmdDN2?=
 =?utf-8?B?R1libjZQdXR5U2RBZ3hiN0EyeVBQNSt4RDU1YUEyUnJOMnQzWWVTQVFIZFJI?=
 =?utf-8?B?RjNKbE5VRTdndG5DNS84ejZKYlAvcTJGSy9peHFkald4VDQ2UGo1UDlkZlFx?=
 =?utf-8?B?ays1TDB6RXRnbW93RDhRdmdGWm1ibzVYTklPc1R1cWVEdTNjZHlPcS9oN1FB?=
 =?utf-8?B?Zmo3Z3BxeU1mb3hTem9HWWd6bTBEMm5xNGhMTWFQZVhwTy9jWUQwVEpIdldr?=
 =?utf-8?B?R2pRTUIvUmFDTUQ3S2VBSmxsVi9IMG9kbEkwRlFhSUdZUFBKUHdmbmh5QzBV?=
 =?utf-8?B?N0o5MWZNbXR1cWRSOGxoSUZ6WXcrdktYa3NieVkzVUR0bHcyYW5GL0U3REpw?=
 =?utf-8?B?b0dqU0ZYUVA2eWJUZnFTdHJnVWFQOTZjMmExODJ5OXpPaUxaMVd2TmZuVVpR?=
 =?utf-8?B?S29HYk1DTVR6VGRkRHo2NkV4OXcvYjNjWjloS1lMTFFaT2tYT1ZjZklqSGwz?=
 =?utf-8?B?K0xhZUY4WUdSeExYRlZwNmVLZFdXVlkyRHJCYnNRNHZwbE82N3FoU2ZNRFU5?=
 =?utf-8?B?bDYyblFwV1Q1RUpTc25MRVovdDc2T2x3UkpkTWt4MU9ic1J3dnNNSVJrdVdt?=
 =?utf-8?B?VFFXclRBQ0t6THJJejB4RmlzTXM1YmNqb0p5SVBKYnNRWWFSZkRsQ29Pd09X?=
 =?utf-8?B?cW9LL05PNy9keXZ2TGtCY1JXVmpvZDlHZGlqVDdpZGRYbitZcm9ueGZkcEZl?=
 =?utf-8?B?T0hPeXNxV2lld09ER2RhV0NtQmREVE1JV2FkbnhSNG4vWWJSMXlkUXdub2JM?=
 =?utf-8?B?TXVFTGRUV1FHckNXRytKL1RNTHNEM05KWEFGVWMrVDBPQ1B3UEhGWWYwYkt0?=
 =?utf-8?B?TUdqY2RMNjFTZWJEandRS1pVUDRGR2hRdE1NbzVqd2ZLVlVMRjlTeXVkUU9o?=
 =?utf-8?Q?LpHjZ4ekz3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjhKOUVvRGY2MXZaZUFLTVY2V1dUQUZneVBlRGNJbUhkRC9Wd1BWdjhQb2ov?=
 =?utf-8?B?dEpMNjJsUkpFRlg1U3J4aFo0RGFZQlcrMXVBK0hIK1lNZ3hyTm0vcnRJYzVm?=
 =?utf-8?B?YnNPZmdybDlFZEdyMThkc0hKUWgxdG9pNG1jL1pRenJXWmx3dnlRSWJOZW1u?=
 =?utf-8?B?SWdXMHlnWDg4SGR5MjE5dEF4TlRLQkpFSnNDbzF2WVpUbzdFaFdNZHNoY1RK?=
 =?utf-8?B?dVJnU3lKd2xEaUMwajNzTWo2SUorYUM0ZVhNZjQxQ2loTWMxeVozN2xSSFBN?=
 =?utf-8?B?bWRnZGVLUU9UYnBSQVF0RTB3VHlnUDI1cDdBN1NPOWNmMm9BMjNNeHZHNW9w?=
 =?utf-8?B?dGxrbVhvVHRTbHFTTEFDVGNrRVZFQzZNb01oMUpLVjBuY1RjNXlsKzVib1dq?=
 =?utf-8?B?NkpkT2ZxcndTRzB5NU9QZGEzUWFLcnlpaGZNS2NuQXdReUFZTjlvRTgxSW8y?=
 =?utf-8?B?Q0RCUzVLUEJqTUJZa2ZaTEI5RjB0MUF2UDdhcEdpcVpmTmIxcllCRXJ0b1hx?=
 =?utf-8?B?VGZJeHhSZnp0aU1qVkRDUjRJRFN4RXlmaW05QjFVODc0UWtVN3BNNmZUaVZW?=
 =?utf-8?B?bW5WV0RsVFdYanZFdG82NWRObzJJLzA3NjVWSjM1UEsrT3Zab0hGRTdCQ0Jj?=
 =?utf-8?B?QW1uTm0yYWQrL051RXVVZmFySGhFblhBM3dDWmRGbUFtTkJlc3dsMStPRHo1?=
 =?utf-8?B?VGJTWXBxTnFMeU5DZDlPS2svV1FucUx3d2tHTWtBcjNjZ1pGdytqOVFKM21t?=
 =?utf-8?B?eGJzVlVURXdRYU5tOUU2bGxIbm0wYzFnZFZxOVBGNTBNR21Wa3k5MWt0ZnVH?=
 =?utf-8?B?ODBOYXNjUTdRUWU2YkM5aWJWNEJ5MDZvcjVPcDdsVXpES3ZlWHVPMThMdy9h?=
 =?utf-8?B?UEhNVGczaElwRTk5Y3R6UXZHY2laTGRXZjFGMkJPL1dCck8rQy96MXlzSTB6?=
 =?utf-8?B?bW55OFZ2eXRFaTltSVU2U3ZXTWxpeElvcmtqZkZYS2kweFZ6M21qTytRVlpx?=
 =?utf-8?B?M3ZkZXYzbG9zOVZldzVZN285cFdJblBxeVQvczNaKytCU3dYRkdyS2xLSWRP?=
 =?utf-8?B?bmZUZE1YTmdaZEhSL0M4MzhiSFdXeGtwcjZyYXJFc0l3elNXNDR4cnVZbkoz?=
 =?utf-8?B?ZCtOUlNuOFFFYmpXZldYM1owaXZiREY3Q29hNWJNcVdMOXFZWlNNbFR0SGpv?=
 =?utf-8?B?N2wzV1FsT1hob3cwendrTElDYnNURlQrRWNlUmcvRWVPVG9aMmsyWmZzNGJU?=
 =?utf-8?B?V0JlM1FLTTNuYkc0Ky9xQmFmMGl4NUNZZUp2b2xMSlVXeVhVRGZ2TDRjeXFY?=
 =?utf-8?B?L3NwdW5OazZQVmFSQ0w3MEs3dGpuRjB2VXJkWUNJcUlCdDNBbjFRMjBDd2pB?=
 =?utf-8?B?RVh1VERSZnVaNHlRVGl1UU9temRFMTRiR2pSQnlqNmdybmkrRGl2QUVLeVN4?=
 =?utf-8?B?eFlYWStqNlUwSjNtWnhtQmdXS2RyVkdyUjE0WHlEVTFoeGJLaG0zdjhuNG42?=
 =?utf-8?B?VVc4eGRyQnJrM04vOEs0VTU5WUJqRFVHVmhqSVFDWW5iRCtLaTN2WUY4U1Zr?=
 =?utf-8?B?SWh3S1lFNE10WVVHaUhSdng3b3U2Vy9JUzcrNTVNdGxvWHl4c2hYb3hWNjFu?=
 =?utf-8?B?MHFnUmxjdkkzanVDVDlMR0o1M3o4VGtZRDc1U1RHY3V4THBuY0RxNlhuRVk1?=
 =?utf-8?B?ZnhjZGJzYUs2b1JTY3ZCRHZOTlIrQUhLTHJwVFAzTEI2U1RkOGRWY0RKalgv?=
 =?utf-8?B?by9UN3UwVDlwZTQvb0ExQWd2R3JqZm1tLzhvL1lrdkpnaWpMU0oyd1d5b056?=
 =?utf-8?B?UUVNcjBCVTNEem4xR0pSNWJiaDFxUXBmSnByay9TWUxidFloN1hOSWRNZDkx?=
 =?utf-8?B?NWVMTFh3UXdUdE1MRVlPWGJubGVrSXhQM1pRVkhFN01LTHBKK05CakJFQ244?=
 =?utf-8?B?YmJjeGhYV3pJUXZ6b0JkUy94VzVvdkxrSytLWFNDeUd2YmR2eDZuaFhDcEVp?=
 =?utf-8?B?dGhJcENnV0FyblJqSGl3RlhORmZ6eFhzU05hNGQweWkxLy9NOWxwdDhVWUpi?=
 =?utf-8?B?YS9WbmRXMDNCN2IxOHVNZjBaUUpyTG96dDFYY2d0dElwbmxMV3NpaDU3RDNr?=
 =?utf-8?Q?Yy4QVxCJcL4dlZ5Ph+gHzl4SW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145f3f5c-1992-4f52-c34b-08dd8e2e321a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:45:21.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGSWJcA810lEJtyKQwuEEwpUNWU7MD8iKzR0Ak/1yyRygSM70s2mkL4RkSUBilLvgMaOQeVERuXO3Hv3UtviGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372


On 5/8/25 01:36, Alison Schofield wrote:
> On Thu, Apr 17, 2025 at 10:29:06PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
>>
>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>> exported and shared with CXL Type2 device initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/core.h       |  2 +
>>   drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
>>   drivers/cxl/core/regs.c       |  1 -
>>   drivers/cxl/cxl.h             |  2 -
>>   drivers/cxl/cxlpci.h          |  2 +
>>   drivers/cxl/pci.c             | 70 -----------------------------------
>>   include/cxl/pci.h             | 13 +++++++
>>   tools/testing/cxl/Kbuild      |  1 -
>>   tools/testing/cxl/test/mock.c | 17 ---------
> The commit log doesn't mention these cxl/test changes.
> Why are these done?


If I recall this right, moving the code has the effect of not requiring 
this code anymore.


This comes from Dan's work for fixing the problem with that code moving.


>
>> index af2594e4f35d..3c6a071fbbe3 100644
>> --- a/tools/testing/cxl/test/mock.c
>> +++ b/tools/testing/cxl/test/mock.c
>> @@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>>   
>> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
>> -						  struct cxl_dport *dport)
>> -{
>> -	int index;
>> -	resource_size_t component_reg_phys;
>> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>> -
>> -	if (ops && ops->is_mock_port(dev))
>> -		component_reg_phys = CXL_RESOURCE_NONE;
>> -	else
>> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
>> -	put_cxl_mock_ops(index);
>> -
>> -	return component_reg_phys;
>> -}
>> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
>> -
>>   void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>>   {
>>   	int index;
>> -- 
>> 2.34.1
>>
>>

