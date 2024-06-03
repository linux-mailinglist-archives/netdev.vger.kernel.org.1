Return-Path: <netdev+bounces-100377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28798FA455
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9CA1F249FB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C860E139D0B;
	Mon,  3 Jun 2024 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZSoQuvPr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05A80603
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451415; cv=fail; b=R7Zg7DfhE2k/5RR63LP3siwMG7m+aYZLXxmPHq/fXhEoMaQI7TODixOBT5TQ4odMb9aATfJc3LbMbz65notIG9leGW8svJpsNqmReUXlqEqW5fHjDoFN0Sev1nk/LdvmAt9vFSnjXBDJI4mG7DCdXD32EVoVx7hPNdXBNyrjBdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451415; c=relaxed/simple;
	bh=S6PzewiThPLU4aCU5NdUvQBZ1TYQ3ihdeXt6nZbPcQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hXYMhpNAezqTiIpGtOGzFQMKPClHCU1j6BxDbc4qfWmqc2SyvCPetU92g233aU1Dl0iZPFz7YWtRLw34774gm5X9wK0zzGrGwNwyYc+eqvmWTY+MYeopukiDzC8xP64Kx7akaSyH67XDe3qXJIw3KXVeITXzBTeIxypu9eqND84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZSoQuvPr; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClnvMGhAKJ44x1Qk3P5g+eI/Oe/78gW+Jt9CrQzwhMAq6OBwIFQ+KMSo4ew6MARqGEluerFv5zRTZ6vwg3RCVfKzYWGwOPsWBBexUKXcMBg5q+Absed6BBOdfW5U7rZcXxfU8i/ISbpcX1IB25jxGRtQeD2s9d7t2oguz1VOLohuzQYCtr4CqiaAERmmcqI/2FlvjegUALngOrg/Po7x4SD1B75BPl6cmMP2SXvyWknupAax1Yn/5axFn4fTlJGOmrnGDdP+PBQDAbYvVvHCSNTbi2FtEJWSJgIBmCbmsFFrTSjoEOU/rOJ6rf+vUTyQFiSi13Pd2zjWJateEjwZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53KZoMk1gR80nLJJa3C/9N4QUicsY9VqLygIofDlD9k=;
 b=YDIBK1TfT6CykXfWdsAkX24IawWzviIYJ7ViiiOJMXNvwl5mpzEFl+7bcFs4Wa5jwy/AN3eBVRMGrJMHwqeYWVLLcmZBQplnYzttaAEEFOqVmoeG9x+DS72kQfSmVKFfiITHo+eUe1cxXayeORoPT7Bjrqwf4y0cePLnqLj7l1P025wm5EFfbrBr2hEeVt+NLHA7gs5ki+rvb7urGMSn91TliwWmaD7XWpZcfKKpByiro6mBXb1KCJcBION/Q4zvBYwPqzvXRXaN+k2lI8/kJS8luLqgC2M5UslAo8VTCjsM309KntrXGPuC208ljkzJ3W9HK6xVz5mXGK9hb8IuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53KZoMk1gR80nLJJa3C/9N4QUicsY9VqLygIofDlD9k=;
 b=ZSoQuvPr5VbaaLMWq3xpbb37WYzEM+n3v7yls8DW/xWAUFD666YUl5mmf6sL7fo6ZnteuU5/4L4rIn/GQ67/W/8VF+v26VSBBeFUSAHJucYTE/7+uvufHdezy4L79OZwc7FbrTZg78/Vxp42GYQ7D244J9IGZEckoOrYA0foVxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Mon, 3 Jun
 2024 21:50:09 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 21:50:09 +0000
Message-ID: <4a37a47f-ed26-479d-afb9-418c802543e3@amd.com>
Date: Mon, 3 Jun 2024 14:50:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ionic: fix kernel panic in XDP_TX action
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, shannon.nelson@amd.com,
 brett.creeley@amd.com, drivers@pensando.io, netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com
References: <20240603045755.501895-1-ap420073@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240603045755.501895-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::29) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b02a07e-7b54-4ab0-27ee-08dc84172372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2dkckFudVI2UHF1ZXE2YXBpcndOMFFnSjZIZFpJb25ndHV1RHIwU2NvUVV4?=
 =?utf-8?B?UFM2OHlkREs3S1M0VjhEcEpVRWJ6dEM3THR2UkFFdWc0cWdLL1RENDc1cll0?=
 =?utf-8?B?TExkSjlFaFR1N3V1UURTanhRQ05Hdk00MElwNnhqSERUV0l2aFZoWUk5M2xv?=
 =?utf-8?B?Um9vSllYMXpTdGZ3Wnh6UUhmNk1GZ3U1ekxteGhCTFlBYWdzVUhsZFc2RWFN?=
 =?utf-8?B?MlhlcFhORU9EL016MmcxL2plTlNvY1Z6YnVybkVMZnFPZC9ZZzZqU2RFUzIz?=
 =?utf-8?B?N01KbENWeGgzdkVoWVpOcHlTWjVDOEJ1bFl3dzRETkx3Y3VJSDA4ZWtGWFdx?=
 =?utf-8?B?d3lTVHdkM09FaUhKcVRBMHdjb0pwTWdpUGpCN3dkTE0veE9oVzBSZlNPRlZq?=
 =?utf-8?B?UTVlOE01VU1WRFJuQm5LZzJ0bVAyVmNVM05VUzdvRWt6cEV5M0Jrbkt4NFlu?=
 =?utf-8?B?THVRZHZ0K2Rad1hWUmJSTVZHT0h5MmN1Z21lenRtNkg2NHp6a2VZSnJUUEI5?=
 =?utf-8?B?Z3FYUWF1Q3RuKzBzN0RybHd2VkMwckJCR3JBNnFFMHFkN0gxOWhUSVNhRFZW?=
 =?utf-8?B?Y0xSekxkUjhmcGE3TEw1REJaRkJxNGx0TlAzdG5uTC9kbjZYd200RmdvVytx?=
 =?utf-8?B?V3Z6YUNSdyt4RjdxUWFiTjYxLzRMMzVEQnNkUXB5VHZxT2F6RjZHSEtBcEMr?=
 =?utf-8?B?WVpWQVQwOThZSXdqMHgyZzBJUFkwSFhlRENkdzRCcmo4WTlFd3pjSkg3ZTJn?=
 =?utf-8?B?T2F6aHNPc1N5V2Z5d1k0K2ZWVzNlaElaQXhXQndpRmhmNUtSTnFmOHpYQnVx?=
 =?utf-8?B?cEsvbXl4UWF6YkdMamNucVZ1d0V5Y2wrVzNiei9tMmI2V2pBVE0zemp4VWRm?=
 =?utf-8?B?RFZxK28ybThTeTZCRGNad1ppVUU4Rlg4YnN5ZFYzRHpRSGJ3YUFXa0YrSkRr?=
 =?utf-8?B?YmhUTTJuSUJMdzd5V0UxVExhYmVnY3BkL0xNSTBXOFgrQWRQVHpJeS9hZlJs?=
 =?utf-8?B?UGg2cTFKYmd1TjVCYmVLT21uSjJ3K1pvcmJqR1hTNnYvVUNwSnA2TkR3alFN?=
 =?utf-8?B?SVpMSGt6Mm9jaFJHK0s1V0puZGhwMGxwNjUxQWF6V1NBQlZWTzdjdUxJN2gv?=
 =?utf-8?B?Rm9zNlErNnVEb0UzT3lOZDNTY3kzdHplTlpPZkhDL0J1NDZtZ2xEREFsUEJY?=
 =?utf-8?B?UjBGVXUzcDhKY0ZFaFp4U1pwRFcxdlYwWXE1RmJ6VHRDWldoY0o2REcvYndo?=
 =?utf-8?B?SE1KVkg3VEMyWG9hNHhWakRXQTNMcWo3YjVnWDl6R0RuRHVtREwxU2RuY3F4?=
 =?utf-8?B?OFJrL05HSHN0SDQ2R2VTdnRtUWtqa0hUMEErRmk3STQxUEhqVmdxOUl5SmpN?=
 =?utf-8?B?VDJNeHorcTc5eWV4enZXTWJQYzZQb0dCMzZOa0MrdGNrNElXd3lvT1F2REVR?=
 =?utf-8?B?UmI2ZGYvL1N0dmVRU1gvZnhXcE4vVmhBOXV4K2pRMWN4RXhiRFNFQW9mSENW?=
 =?utf-8?B?aXpYTVVjcXlYays5ZlpNS1crMzRySjZ6MHk3RnB0c1Q0NTNSZVowbVdmQ3dJ?=
 =?utf-8?B?ZmlpT2FMMGNpZmVPQ3JETTlaMno2QTVZZWY3RnZWSGNXVW1yTmdzWlNMTUlh?=
 =?utf-8?B?NTFMYmkydFozeVpBeHhSRkd2L1Flb21LMUNmUldOSUhtR3FNaW14dk1PZXY1?=
 =?utf-8?B?TnF2VTNYZk1Rbll0TXlQdjQ0WEJMbVg3cExaRjZtUGppb0I4UHZNVzJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS91Wm8vSHFWOGRjLzJjb2pqczVuT2h0NDR1S1VsY3ZjbzdQQXR4bzVoSmtT?=
 =?utf-8?B?cWVXeS85c2ZZMjFqa3dpY0F5aW9ZN2laSTd5SzBSUnlKVnluUndUc05BVmRK?=
 =?utf-8?B?b2FhNWlBWVo0S0xKcjZNcWJSNVg0bDl2YVBiQ1FQamU4THB3TG00VnZZa210?=
 =?utf-8?B?YUZRbS93MnhXeVJZWnR1TjkzL3ZtRkorajhJRFA2MThNRnFZWVl3YlhONGpR?=
 =?utf-8?B?cXRlT3A4YkJ6TXFJZGVkR2JpbFFDZkxkQmUxNTdiT3BjU0s2TDBHS2I1YWh1?=
 =?utf-8?B?aVprVWFaUmJSK3JLbGs5NnJ5MVZUYjR4NzBNUUpkcmI1aXJOVXA2amRpZU9z?=
 =?utf-8?B?QkJEejgvRXExY2NuSGsvbTJ6YUNMNTJCeFUveW1xL25Cbmltd0M3Qk9LNTZS?=
 =?utf-8?B?YlJDRGx3RWEyU1YzSmVTN0c4cDNCMUl4U1p2M0trQmRIbzNiNzErcFZTK1ox?=
 =?utf-8?B?RE1hSEYvTTJjVGVIbkZSMkwrcmkvTzFKempnSVZtK2Z6ejJ5eEhuSnlheWl0?=
 =?utf-8?B?M3BxVHYrMUx4d1dFZTNYNFdwVDVTWC8wNzZoMVNPbk0wSzBYZ050ZFVTb29L?=
 =?utf-8?B?WW9Zdkdhc29zRXFURTRuYVVET1B2eksvOXQyT0xQM2JyU3BpbWgwVzJRYUlt?=
 =?utf-8?B?MisvTmowS1pHUkN1Tlk5WDlXdWZia25Cb1p6MG5TMEEzdjMvVllNV2R6di8x?=
 =?utf-8?B?OSs0RWNkZU1scHArWTRrQmNYR1c0YTVqYWkwa0xBeVNFc3hvcFNObFltby9W?=
 =?utf-8?B?bVZzMFFhRm5QUkFmR1JKbTh5YmFWY2grL0tLQmtLNWNwbDg1c0JqWDdET1FS?=
 =?utf-8?B?Qm15QmZSV3pkS3VTYzQ1ckswQ29zZ01kbEVVdVR0NjYvekpVc0VZcUJDbHNL?=
 =?utf-8?B?dGRrK090dHpuL05tWnZldEcrS1lZeEwyajFBcFdXYnJrNVdGTzQwQlBQS25F?=
 =?utf-8?B?THRJKys2a09lZUVzRnk5TCtNTlZwM1RHcDBOSnJEME5IQ01Yd3JvRGdtU3JW?=
 =?utf-8?B?d3JxODEwL09HM0d3K0NmSW1ubHBIQ0ZJck9MVHBUTGpBRmRqRE5YU0JrYnRD?=
 =?utf-8?B?VmhkZXFhYkROUFFheEFGVFRMYktCRDhCUUZJdXRoOVVEN3Q0SGZ1WHZpbzh3?=
 =?utf-8?B?R0Y4TWVldjR1Nk1HZkhyUGJ2YldEQ2Z3citBOFdZeTlISy9QMEZDb2JCNTNO?=
 =?utf-8?B?UDhodFprNFA0OHI5ams5d2EvTjVOK3RSNDRBTE1OMmNCTjQxN0tFVmdMT0pD?=
 =?utf-8?B?ZktCblVzb2g0S3FqdldObnJrSnVyUHFib25WZDJ6ZTlJdUlEalFVL0YrRFkw?=
 =?utf-8?B?QWVSNDFHcW9oa0hHRTI3Y1hQWkJhMEpycTU4QWhkMG1kR0N1RWlnRDk1QXo5?=
 =?utf-8?B?UkRQTTdxdkZ0YmJHVHJSTDRlVmVrd09TbHl0ZVdXZm4ydWVKcVpaSVRsY2NG?=
 =?utf-8?B?NXZTZktCcGVSOTN6NFRxZzk3S0ExNzYxQmFkR3lvcEkyYTA0NDVrZDdFdVIv?=
 =?utf-8?B?MWwrMDU1dDRoRTFRTHRGdHcyakpjWGxyVzJEUEx2TnppVTN4VC9zTzBEZGJa?=
 =?utf-8?B?bWlqSDRYUE9SeDFRamY5QjBUZ0ZicGwwZFh4Y1NmUjJaK2EyNmFaMkVwS1Mw?=
 =?utf-8?B?YnpMeHJEeFNkQVdOdGdmOWJZaEFLcUcxbittR1lweFNFR2tmenNZWHhqOHdQ?=
 =?utf-8?B?Ym94c3JJKzFiTU9qMyszYnBKS1gxR1B0aXBEMlpLcEd6RG4rNVZ0MkZIdzVI?=
 =?utf-8?B?eTNrRUpPSUw2d1ExdEhId3lQWStzUXFkdEpGVUR0TnpBeGZrcE53WjNaYjU1?=
 =?utf-8?B?cVV1aVlhK0RJY3Y3bHJONzBSNEdzeGRCNXNqRDNZTE96YlBDcndsd2RYQ1dJ?=
 =?utf-8?B?STEzY3ZDejJrTlJxNjlmS0crc21nd0tTYWVZZElhK0lGdnNHa1h5V1NqZmVS?=
 =?utf-8?B?Nnk4MmxxWGQ1UWVUcnBibWYvL3NsYkxaZUZ0dTdJSmdlSlJBV2RiZ3dxZzVI?=
 =?utf-8?B?Q0dhMm13QVJweFpRdUl3WmJXTmp0YWp1K0JKYUxKdng5dVQzR0QzcEp5Ri9Q?=
 =?utf-8?B?MkF6eU8xYjJsOFZJMmZvWWJHZFl1RFRSOG1nQkM5UURnclU0cHVYTDl6TlRL?=
 =?utf-8?Q?hpsB4Nt358PUUQgFvYhUdAIN9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b02a07e-7b54-4ab0-27ee-08dc84172372
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:50:09.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MN4OAfakjqRncZ4lDzp85AbQyVudJDt+Z5ao/R7ra4qk7gmeaRhjTar3DiM4s+qqQAhh5ARRYssLuQZ8h0Id4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

On 6/2/2024 9:57 PM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> In the XDP_TX path, ionic driver sends a packet to the TX path with rx
> page and corresponding dma address.
> After tx is done, ionic_tx_clean() frees that page.
> But RX ring buffer isn't reset to NULL.
> So, it uses a freed page, which causes kernel panic.
> 
> BUG: unable to handle page fault for address: ffff8881576c110c
> PGD 773801067 P4D 773801067 PUD 87f086067 PMD 87efca067 PTE 800ffffea893e060
> Oops: Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN NOPTI
> CPU: 1 PID: 25 Comm: ksoftirqd/1 Not tainted 6.9.0+ #11
> Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
> RIP: 0010:bpf_prog_f0b8caeac1068a55_balancer_ingress+0x3b/0x44f
> Code: 00 53 41 55 41 56 41 57 b8 01 00 00 00 48 8b 5f 08 4c 8b 77 00 4c 89 f7 48 83 c7 0e 48 39 d8
> RSP: 0018:ffff888104e6fa28 EFLAGS: 00010283
> RAX: 0000000000000002 RBX: ffff8881576c1140 RCX: 0000000000000002
> RDX: ffffffffc0051f64 RSI: ffffc90002d33048 RDI: ffff8881576c110e
> RBP: ffff888104e6fa88 R08: 0000000000000000 R09: ffffed1027a04a23
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881b03a21a8
> R13: ffff8881589f800f R14: ffff8881576c1100 R15: 00000001576c1100
> FS: 0000000000000000(0000) GS:ffff88881ae00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8881576c110c CR3: 0000000767a90000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
> <TASK>
> ? __die+0x20/0x70
> ? page_fault_oops+0x254/0x790
> ? __pfx_page_fault_oops+0x10/0x10
> ? __pfx_is_prefetch.constprop.0+0x10/0x10
> ? search_bpf_extables+0x165/0x260
> ? fixup_exception+0x4a/0x970
> ? exc_page_fault+0xcb/0xe0
> ? asm_exc_page_fault+0x22/0x30
> ? 0xffffffffc0051f64
> ? bpf_prog_f0b8caeac1068a55_balancer_ingress+0x3b/0x44f
> ? do_raw_spin_unlock+0x54/0x220
> ionic_rx_service+0x11ab/0x3010 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? ionic_tx_clean+0x29b/0xc60 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? __pfx_ionic_tx_clean+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? __pfx_ionic_rx_service+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? ionic_tx_cq_service+0x25d/0xa00 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? __pfx_ionic_rx_service+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ionic_cq_service+0x69/0x150 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ionic_txrx_napi+0x11a/0x540 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> __napi_poll.constprop.0+0xa0/0x440
> net_rx_action+0x7e7/0xc30
> ? __pfx_net_rx_action+0x10/0x10
> 
> Fixes: 8eeed8373e1c ("ionic: Add XDP_TX support")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 5dba6d2d633c..2427610f4306 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -586,6 +586,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>                          netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
>                          goto out_xdp_abort;
>                  }
> +               buf_info->page = NULL;

LGTM. Thanks for the fix.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

>                  stats->xdp_tx++;
> 
>                  /* the Tx completion will free the buffers */
> --
> 2.34.1
> 

