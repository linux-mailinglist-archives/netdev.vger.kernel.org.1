Return-Path: <netdev+bounces-150111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14999E8F1A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4C2282955
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B88215F6A;
	Mon,  9 Dec 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fULKXna+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38BD83CD2;
	Mon,  9 Dec 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737691; cv=fail; b=ag+k2sXBjZsBNA0cgXOxuzWEqT3U7YnPCbdUsKQdvHHA4fR8YN3rLlDj0X0GVpaNXObJstgnjzArHkq47Z2AUuynY0Jp2tBl0qX0bbbJ88r4ojp3U7aDOdzPOL4jKtHsNDmT3Wiq0RullxwPvncbhJVyx7jUndEzJaVS++4yHgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737691; c=relaxed/simple;
	bh=SybYQLBX6Rmz89YyId7ZuWr7GpkBUd15x48SV/1emew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k7p1jv1r7xMMXBAo6mVHIrONGQ3xmxbENZTP9uMF7/2mPmqMJsLFCXWSnEGU3HwlQDZ7z3IAzUdCy/L7GNrICjdXL6Oriv/1vxy59CyUmf05nyT3E+lyG1PNAg1I0XCfYEAxP908hpnK/hp9Ur1+n2hcuT/+WCq6FaRjsqr8yuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fULKXna+; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuorAvH+YDYsQnLGw3VRzX7zjL4bxrLwb1QUJxIgIrZ/QCOdXYl8TXoCgf6JECm1CkIuyixniIzhO7s6akBx//IMgWEitVtChbljcKyno7l7lucUPzo9bkjDIYQM6TLAUSV/ICiM01k/hhAGXFD09xpxuz6zQU1fWNNTJiYeYlhWeoVzHgv5MfdLSWI48qdrmkwDs2FHRi7y3EfuVvVoIoeXZT8uRQqRRz2awbaPS0oKJEdRTu0u6GO/3E0kxiVupbYgJJuYdNfBmoWAp1y1Y0zcf4JS7UhB7CsQAqah9DvxJHlktDUvvqbHMDCgk3w09OM374mUjEEZvNn6t7Vgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cEoKFam/ypsONXhzTbx0xTJlUDEVg3Kiq1eYFILiGY=;
 b=QLlS4Jx+pEqpH3dJ36tLMyNHVv6RHmufSBdtEBagUa8fLeg1xMq68tjMSGSAjPyQggFqQV4LdX8cmqqj825zFSsF23xoguQ0TYpccltGDXveO+miYJ7xPjPvAaLtlAiVkEJTpN9wFQYh2oXFu/0ZSU+wofEVEoxbX8qKXVs1Um1sKu6PGPtuwK+5XOmp5naNnq1Y1ucri7NpR4Y3o73pNNPkyo38gFyv59w7iGyav7ONs7QeIPGHzkTYshPc8SllkSgDzdB7rwfWtCR92/9iQ+OaAiGC1ia5sC2E7TSWt0EBRE+uYkQ8dAslCUtlHjO6dqPHJB39jaTbbLyWxJGFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cEoKFam/ypsONXhzTbx0xTJlUDEVg3Kiq1eYFILiGY=;
 b=fULKXna+OKLTbUBgz2McR3xtlb+gZY1gzrl7j6dV4587KtiGyACKYuNfHSnQQ6+jAwV76rvhnm5Y38yjIjpKY7JBoDo1iDWi1M2jJo90CbkWJtLZdUMbt1bFu96seP3Mp2aqnou/5HJpdDR73X4IgbIDMxPWrZrNWStyNwv/s1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:48:07 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:48:06 +0000
Message-ID: <57793990-1350-de8a-efc5-86dee5b215e2@amd.com>
Date: Mon, 9 Dec 2024 09:48:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 26/28] cxl: add function for obtaining region range
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-27-alejandro.lucero-palau@amd.com>
 <20241203205355.000079a4@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241203205355.000079a4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0281.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6d621f-1676-4ebe-7c8f-08dd1836952d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEQ0MHZGK1plMEM2VnpSNTJSTXdPbVVOa3VqSWdLaWJBUEVYOGFpUmtaR2JT?=
 =?utf-8?B?djJYR1BPUXVlbVJqQllrQXlpMURpZTQwMkQyKzhPVzNpeVdrY2RrOW5SWnUz?=
 =?utf-8?B?MEh4ZmhDSk9WeFFENnlPUWxFR3lDVEZWZTFHTHVZVUJCUEtUNGVtdm9jeTRr?=
 =?utf-8?B?S0VpWnhVMEQxR0RYb1VGRnRWTHMxczdJQ0NpRDV0N0tIc3o5ajFEVG1aNm5x?=
 =?utf-8?B?dGZhRG4xRDQ1Z2RXQzU1T3hCcHpmemp5ai9RRWhsKzdJS29TRzdYLzNPVE12?=
 =?utf-8?B?amVTVXFUaUxhOEdPWjZLUVZ3dXRBdjlOcCs3UElyUWVHamRxdkJGTlJNTlV6?=
 =?utf-8?B?VlRvSmxyYnF0TGFOeXlsRWZnZlBxZGpLMFVEM2NhYm8rbmE4Z0JpVytWM1Rj?=
 =?utf-8?B?UlRYU2h4MDNFeU9MYU4rSGwxZDFPckRnYjlrVUlXK1FYSkNvaEYzdTVhdDRL?=
 =?utf-8?B?WkFDNlErc3lqaXBaTXdyMjdMck1nOU10aUdnWERGb3NOb2lPdzhDc1hXSkNk?=
 =?utf-8?B?aVhOalRzRXJBQ25uT2JmaVlaZ0d0RW1IaTRlcUJTekpQdmZPYUlsUStIUHc5?=
 =?utf-8?B?cHQ3SlBkWFBFWE5qTlhTaDl0NmtHMVFhMjl6R3ExVzI5WGZ3WGFtWWE5S25h?=
 =?utf-8?B?VnIxUTdqYk1ycDEwelBURVdoRnVEOTZqcWNObEdTTFZzNE5HOEJ3Qm9MWml4?=
 =?utf-8?B?akVWa3JOVEphNWQzVjJxOHdPcjI5dmx6L2FzZ0hjWCtJbTR4ODlzaEFwQk4w?=
 =?utf-8?B?Z2wzVFNBSUJ2M1ZRZXpBTkRXQUd2blJ5MzIzaGd5RS9vSkdOYkVXeUcwUmpI?=
 =?utf-8?B?QllCL09kRGNJNjRoNG9oOEw2Z1k1VSsyNk9qVHR4WitDV0ppN3k0MHZHRG0w?=
 =?utf-8?B?SVJCUW85VU5yQ1NBSHE2YWdmYUhxc0Rod09ucjIyODdqZWlzUERJK1dwaTZC?=
 =?utf-8?B?bU5ZcldUcUdzY1dKaEU3NUNyTGU4dmpJVENnVVdjcTJpbDh1V3BPNXYrMExq?=
 =?utf-8?B?dnFodzdiSTlKVHVLRm52RHJ3ZDdDZ1pjWmFqNHE2WHhPNThIaW5JbTQ1YzZU?=
 =?utf-8?B?bGE2b0RkMGZZbmRTTHlMNjNuMnV5cTBYeCtrVjBFZmxrVGJTa1lVVEpkZExF?=
 =?utf-8?B?SVNNSk5IL1QrRmtZYTM5enByWmJJU2lPTmtmR2ZhR1lHTVQ2bnZFMUlzTVB3?=
 =?utf-8?B?dGhOZGFETzNYWENIWXJQcnVYNWs0ZWF0aCs3VWl6Ri9MZHg0dFhhcWUzUmdp?=
 =?utf-8?B?MUdGWXhkaGlWU1NKS0k0elptWG1UMk15TVdnY1FkT1FHY3N2QUZBb3NaTjdF?=
 =?utf-8?B?QmFGTXdNc001b25EREl0TWVCZi9rYTdZTWxWS1RDZG13d1FJZ2djem1IN0Qy?=
 =?utf-8?B?R05IY3J6MkFzRWd6L1NZVFZPZFFIQ1hldXVjOFZBWEU5SmZBcklGSU5tMExI?=
 =?utf-8?B?V3RFd3k3Q2p6dEpXUXBYWkZoRXNyZ2cyOUgvRDlhR3BSeEpseHlRRHhxL3Nm?=
 =?utf-8?B?bzZ2cXF6blc4NU1XVGxKcFhaYmVZUU9qZm9GaDd6clJhWXdoQXY3am9ZSnM2?=
 =?utf-8?B?eWt2dFhxeG1rS3A5ZjFUVk9kdFlKR0l0ajdublBmNlo5RE1ReEhYbG1BSUhm?=
 =?utf-8?B?U3BrOVk2YnByRkJibzZOM283bXNNazQyZVZuUHdRQm9mbEp5NGlYYnN4cWtt?=
 =?utf-8?B?VWNMS1dSVk1aSkxpbkc1RDlNYlVZNkM3aUNYK3lmenhwS2l1ZlpTTmdnYzly?=
 =?utf-8?B?TWQrcGJ0SFBSYmhCdHpaRUMydFdiWXp1QjdlYkRJbVozd3hLeGw0OHhUSk5h?=
 =?utf-8?B?Q0VuRWcrZDBKY1J3TDVmUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djN0Y1hrV25vOG4zTlMrWFExTExNRXNPWEl0T2tHMS9pMDkrVGh3YWV6QVBR?=
 =?utf-8?B?dXpuT0h5MzdLQ1NISjlra2ZNUTY0RlZveENHQjFKODZvWHc0eENxR3NQUG0x?=
 =?utf-8?B?eFhIcUtqaEN0MURpK3NRdTlhbmZHbW91ZHV3YzE3SHZ3SDdoYU1SaW5kQjdu?=
 =?utf-8?B?aUtiV0RYenZMck93d0FZU3o0L01sdnNpRE1CaUZRS2xnWlp2V3pHeHdxalJx?=
 =?utf-8?B?eGxxUkdudUhJT043MzlCOUxVbkREMXMzQk1vdU5Vek1VOWV0NGdRV2FnUis1?=
 =?utf-8?B?OHhER2l4eHFWV3FuTWpvTWxaUkR5Q3lxNjU1MC9jUWJsWElSV2Nid3Jlbm01?=
 =?utf-8?B?NkZ5SDBqWjhabVJHMWthczY3eTJUWnczVW05MmpUaHJ6dVhNRnpOZXMxRFJU?=
 =?utf-8?B?bFliZ0l5RC9CekpqTVlLTTRvR1pIaGUrQzB2bk9zZFdzYXVZdXdnRXNuNTRO?=
 =?utf-8?B?UTZPSzZuMXFCYVhhVW4yUjNwRGcvU28wNHRwQjNZUTBidFhvblVTeFRVZytI?=
 =?utf-8?B?Z0lOQlovQk1JWFNBVi9SOE0vSDRPNGpCZisyNGpwbzlUZUVMYk96ZjU1TkJs?=
 =?utf-8?B?SlhDTVJpamNSa2R0WlIxTXFwS3l4NXVONHBJaVA5TTFBQnFCSzNYRmN3NTRq?=
 =?utf-8?B?V2pDaGFFUmhtVVcyZFAxSUR2ejI5aHVPUGxxd1NBS2N2aWtYQ2wrZmF6bVN6?=
 =?utf-8?B?SFNxVG5KRU9QVVNjTmtheXo4Rk5pL2QvSG4zYWVSMUFoZWt3YmdydUdpc0Q4?=
 =?utf-8?B?UUtuSUdsVXM5VGplQTRMVzZmU3RRd3d0OU1UNjBwRU85dXphbmtITHhkSkdS?=
 =?utf-8?B?WCt1QlQydFo3TFF1eTZqaWdCNFdodU1TaFBsMjVQWlptako3cndKLzl3dFE1?=
 =?utf-8?B?bXFBV2ZTZzZGZThCajFlVWUvN1hsZDZOa2wzaVpQcmxuZ2YxM3U4ZmZZcmZE?=
 =?utf-8?B?SkFzSG9kUjBwb1dqQzRod3hheVRHeGNoakV3a3pkeUlGT2ZHK1NCUWJ5eXJI?=
 =?utf-8?B?czRQMURyeW04S2Nkc1pOeEZyVnRtS0V3Tmdoai9CMTZJUERJMjBsUzZOem5G?=
 =?utf-8?B?MVgxTTZ1ZWxEK2NhR21zQm5Lc0p3RkhoeUpRZFdnTWFPbGh2REhSYUhLbzJB?=
 =?utf-8?B?YUJkamRmZ0ozUkdZNjhvQmJhUzVLbEFFWGc4cU1kQ3pzZURySVVIRHBHSjNo?=
 =?utf-8?B?cUNVdjFMTGNaWnVZTmJzSTd4ZzJLSmpDWloxUG9mQ0dnWk1yeVJHeXc2eTRY?=
 =?utf-8?B?RkxZOHVGWE1XQ0ZUMzA1d3NHQklMNXdCQmgrcmRla0JIaUNHYjZUc1RHNGZC?=
 =?utf-8?B?MkdicmtaYUdOMStNai91LzYyYml2QUJQb3lQc0Z2NGU2MUZrbjJkQThZWmJM?=
 =?utf-8?B?ejYvN1AzVWk0RVN0b0piSXM4dEgzcnpKbGZYcDczcXlNV1ZhNTA2SlBIeTVS?=
 =?utf-8?B?ODBGWUhObUdMeWxVUUhKamFhMkNkSEh1VkIvbkVydnQ4QUs2M0VDWWRlVnc5?=
 =?utf-8?B?c1Vqd0tvc3BiQUdkbVpPY01NbzA3NjZFMGRnd2JQUVJtdkVWakNXVm0xY1ly?=
 =?utf-8?B?a0JVeDNlVDZBQzZBbnN2NGdkQ3JwV1JmaDE0aVNSdzZYQ3I3U0RTNHhLcWpT?=
 =?utf-8?B?Q296TFg0SDUrbWVsRXJXSHlEQ0JwNTc0MmdQYXJsb0ZuRnBWbHhKZHROalJk?=
 =?utf-8?B?UWRmR1p0UDNVK2ViVldJZkNnR0ZRUERDTzJ4M3VWMkI0QmkweWZPajN6V0kv?=
 =?utf-8?B?OTdoeXQrV0w5OVE5NGhhU0c1MHgyL0ZPQ1ZqY2NrZkU1a2hJQ25OZ1I3TERn?=
 =?utf-8?B?aHBORDRLWUIyTzVvUnptY0ZxV3lFaDRPbytCdTZEN21VQXlMUVRyVEg2dEs3?=
 =?utf-8?B?TGZXblYxU0gza3BNenk1WEVCSmtmWnJSVlJ3ckk2eXJZQjVtM0tsa0YzTjVy?=
 =?utf-8?B?VmJESnpMdlpCemRQUUZLS2pCM3VKaUNhekNYL1czck11T1BBcmY1VHUwLzJ5?=
 =?utf-8?B?QUhrQm9vUG1GeW9mZTVKWEJFUnFVYmdINkZIenAxUkJpbE0xWWpaV210SHI5?=
 =?utf-8?B?UGNQRkhVUXVVSXhOTDNMaUlHWG9ZcWJSTjIva2doQitjd29PR3ZuWnE5YjRS?=
 =?utf-8?Q?T78ORoIZwAJUlLZWBrSIpBR5b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6d621f-1676-4ebe-7c8f-08dd1836952d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:48:06.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYczWCSUgunIMYcoP3uKUcWW8rgBDGAK++VNEUPrqXUFCHj8HSv7G0IS4sYKjygeOMLAKsbGF8wEklpgQDhJ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258


On 12/3/24 18:53, Zhi Wang wrote:
> On Mon, 2 Dec 2024 17:12:20 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A CXL region struct contains the physical address to work with.
>>
>> Add a function for getting the cxl region range to be used for mapping
>> such memory range.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 15 +++++++++++++++
>>   drivers/cxl/cxl.h         |  1 +
>>   include/cxl/cxl.h         |  1 +
>>   3 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 5cb7991268ce..021e9b373cdd 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2667,6 +2667,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>>   	return ERR_PTR(rc);
>>   }
>>   
>> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
>> +{
>> +	if (!region)
>> +		return -ENODEV;
>> +
> I am leaning towards having a WARN_ON_ONCE() above.
>

Not sure. The call is quite simple and to check the error should be 
enough for understanding what is going on.

In this case any error implies a problem with a previous call when 
creating the region which was not likely checked for errors.

And if a log is necessary, I think a WARN_ON should be used instead.


>> +	if (!region->params.res)
>> +		return -ENOSPC;
>> +
>> +	range->start = region->params.res->start;
>> +	range->end = region->params.res->end;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, CXL);
>> +
>>   static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>>   {
>>   	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index cc9e3d859fa6..32d2bd0520d4 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -920,6 +920,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>>   
>>   bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>>   
>> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>>   /*
>>    * Unit test builds overrides this to __weak, find the 'strong' version
>>    * of these symbols in tools/testing/cxl/.
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 14be26358f9c..0ed9e32f25dd 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -65,4 +65,5 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>   				     bool no_dax);
>>   
>>   int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>>   #endif

