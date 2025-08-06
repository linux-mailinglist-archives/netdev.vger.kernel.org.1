Return-Path: <netdev+bounces-211885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D505B1C367
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 11:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974EA17B048
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62181CB518;
	Wed,  6 Aug 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2JR/USjx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248828937A;
	Wed,  6 Aug 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472682; cv=fail; b=Sqz371ibkilmjUIEHibTkoqYiWutzgGMQ2Drn4mmBTCNbCcs+qB+yxxTyIObzkAHF2k+tqfLerK3ihYNf559I3ybopFifL/19uY/iL14GCJ4HLISVGN3V/Xe98Go/TCOR5nlZtlH+907h6koC6zqvFMNaMbKSi2x56I1PGt4meo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472682; c=relaxed/simple;
	bh=SAXd5mGgQQQWDZLMzl95EHU46uJtOkRfndZ9uZXsTS0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HG5nklgXL3WezrHSffiMp6zPApwE5QLFczSLfV1dm79fFJzzpWJGZHAfC+ovmRyCMlrjRRiNUTK0Ii3JMnr0y0IcCyfqTCsowNe82EI8abU0dk0aJaWLNxFy0IvKEMyNoJpfle7pBf6j/x1PfDptxpoVpuEonoILQJTZ5sIBfsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2JR/USjx; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEoNog1BXKXBEbsDzfM/kCAyFnA2nKv1D17NQGWnkuq/8pQKiVMgskcUtl2OIEGIG2qVcD4svEZ/yGsjQBhC1eJS42k8fyva4DnhQdlS9z5bFPK8li1KP6i8ldRzGU+cG/i2vKmBevSxIY2FGNBQBRWQWu0A7NNo3IjPWxKfeXPWvcian4Keg/jRUrwAni+m2zJosHMBZsROcDdf2tiJ5JavtP86PL+zQA/AwjBdHzxTpUfShHrjmWVzMWrCpCP5+d6eOXAIJIkJK+M9VAndKric5Q/Ud/R0A1pIXgBiPG9UXVpIkPxOVljWV81F6krM9YqS2EydvUPyn2TfKNQqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mk2ukuxWvO4ubpoBGH1B/sNGYO46igkyLv+d6LdTGEA=;
 b=CGlO8Tr6L0dydOUQUnP7o8j+CADuGKETf+XNiLaJfV/qJ2WZNxCcNH4qvS7RmbT8k2ihby4W55qxJMVD9KmbN2UEIpFwxT6lPGGjZBdrev6xllgYU1Tsum1ViTTpBak8Sp51oNXFdBogjY8bhfD3Kw9/L3B1CbKHaf8LAK4su0YrOJPUYJVLKmdqAEP0Jh4PImA91aiCxfTi4POOQocISVDcBCC4q+P0YMzzbITXLYsRcwXrHwUvHHo7n0teYNXYXwfu/2eKmNBNnN/TxkCqb14TIRHFqjfyVWjf3d2QE51Is7wXjUcMkV8uBL4ISIOWg14UxP3FF3epd4gfrFLUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk2ukuxWvO4ubpoBGH1B/sNGYO46igkyLv+d6LdTGEA=;
 b=2JR/USjxUD5dK43RKBN0Zm/oUxKHdVhQrmAHVv8fQpsJ+MjhJK8vZaNt7hsyZzw0lUwi27iAD1AKAtMNfo/i5FGyfao/pCH/JW4Ps0bSh6pAfLaFGBnN0I6jsZR3buo513PyQHmwHJDI02LWrJTv6X/kC4t+QFvhUEcenSMmmCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 09:31:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8989.017; Wed, 6 Aug 2025
 09:31:11 +0000
Message-ID: <f064072b-f3d6-47cd-ae05-c8438486f710@amd.com>
Date: Wed, 6 Aug 2025 10:31:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 03/22] cxl: Move pci generic code
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Ben Cheatham <benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-4-alejandro.lucero-palau@amd.com>
 <6884080b24add_134cc7100c@dwillia2-xfh.jf.intel.com.notmuch>
 <3d24d9cf-4b8a-4d70-b222-982f4d71ac89@amd.com>
In-Reply-To: <3d24d9cf-4b8a-4d70-b222-982f4d71ac89@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0164.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9f5d41-a9bb-4688-97a0-08ddd4cbfada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEtBSkdYN2tJNEJxT2xkSll2cnZFb09yY21sLzRpMDVZN1dUVWV2WmFwQjVo?=
 =?utf-8?B?RUl5TEd5OHBFU2tRR2V2M2NJZGw5Y1ZGU2wxL2lBREZjS1hJVFRaRFBvUjc3?=
 =?utf-8?B?cmJXMEFMRzRQNG40eUJlYU9LcC96eWovUnVaekQvNzhVZCtHTmdxYUkxSGw0?=
 =?utf-8?B?ajJRZ1UxRFoyOWRzSWc1UkZhaUd0L2V1OEhLU3Rrd2hIYWVqVGtuMFlmWktD?=
 =?utf-8?B?clhxTmdocDhjYUtZaktjUUdKT0wzM0dDMXhmOWh2bHppVDZBb0tMRnc1b3dJ?=
 =?utf-8?B?VmRZS1o3WE11bUIvd3orelIyb2pnSVRVWnhsWTE1QUhxaDBmeG0vckpjSVhI?=
 =?utf-8?B?eUpIbW9pYWlOQjJrSmd5MVJYaVhtK05qb0V0dEx3TjRGNnQ2WmorOCtlODZm?=
 =?utf-8?B?Z1J5SGFrMUJkMFVpN0RobUtBd01nbm12azhQRVBGVDg3aE5jdWw2UUFRSjFC?=
 =?utf-8?B?ZEhMdnNTWmUzbVJBclBuTERvc2tUbFhBd05iSGUrZEtUSmNFUlU5VGRKbER2?=
 =?utf-8?B?akc0VUUzdVRISVRPdXlycUdKSVRHY1J2dUJIRUl6a3pXZWs5dGZVNDVWVzRv?=
 =?utf-8?B?dW9wSW9JRGpBWGkzNlZ0amc4eDVYRnhhd1o2VlNFci9XZ2E2K1NCZE1qSk5K?=
 =?utf-8?B?YktRTFIzL01WdlRJeE1sNzF3elE0bThhekxFVGhuNUNUUWphY2FZemhMOWJh?=
 =?utf-8?B?WjF4cUNtNXJSclFsYWEzZ21UbHlJMjRuL3N5RnlOeXBmaXVVVlBISGdXM3VF?=
 =?utf-8?B?dWszTFFWcStIYUNEcFNZV0ovL05wM3p6MXJETW1PWU9lZVpRQnlQaUVnZGth?=
 =?utf-8?B?djRIZlVSbGRmU3Z5WmJvTmo4dXRRN0lBSC9wREFXZkJGZFVjRlpLaHprRWJx?=
 =?utf-8?B?RFVDQnlvSzR6MnRvNFdVbFk1aDZ6Y2pMVXdqSzRya2c2b3hvR0dqZFZRUzJz?=
 =?utf-8?B?aWc2eWw0ZmRDUHlMRGd4VUZnczBkamlXc0FjejhnS2U1YXVNZmwwZTBweVo3?=
 =?utf-8?B?eDR6L3NVa1g4RWZodkp0bDhNWnlXL2wyeEdjOHdoOG0zVGRzbFVESCtiSmMw?=
 =?utf-8?B?Y0VkR3JSaGdncXQvV0libzdoN2VIeW5iaC9JR3pGcmhmREQyMks5dXlUdEgv?=
 =?utf-8?B?VEZ6S2JqUW9jZGlHSENGdzZCRGR2N0dOL21EdTFlL0RCU1FndE5TaUEyVCtp?=
 =?utf-8?B?dWpnSkFtK3RwbEg2cWdMZVQrd0RYM0pRLyt2SDRNcVg4Z3NiL1NwUVVQMGVs?=
 =?utf-8?B?cGs1T2wwSWVDdUtueEJ1RTNsNG5aOGtNbnFNTW9vdXYvYm1rMzFkRmJ6Mi9I?=
 =?utf-8?B?Z3FaamdrQnNTZ0JMd0RCM2N0by9NQ2VUSnVyeGpnUk8xa1dJQWtHQjZxSk5L?=
 =?utf-8?B?djhwTy95VGpFcWpOWmdOOTVTdUM3a2c2UCtlNmNOQ29rekZlWDF3TWp2dmxL?=
 =?utf-8?B?WFM4Q0xtNGNjaFNiTTJ0R3p2MG1yd1I0cHRaZEI3ZS80QmFRV2VGRS9NcUJO?=
 =?utf-8?B?MkV6NysrbmduK29RMzd0anpHM3VtQzZxaWw3MlE3MmI1UEhwNDNROG11eU8x?=
 =?utf-8?B?T25CUVZPNE9sYi9VQmVSTTRHMW9WSTYra0tIUjF3S3luSFFJYzB6SkZPUGt4?=
 =?utf-8?B?b05MY0NqTWZNWXFPYkk1RFd4dGJiWFZtU1J2S2JNdHdUUjBuMXR3SE5ETHZS?=
 =?utf-8?B?VmN0SUVIbzQzdzlSbXBLVmtISyt6SFdVUFk5MmZUbXdKMTN3TVlSWFdpdXJi?=
 =?utf-8?B?aENqOHN4ZlMvR1ZnR3VHRnFPalVPTDArRWIxNDM0TFNKcDBBQXdVbStTUzh5?=
 =?utf-8?B?WXlIeTFMT2NjZnFURENCZXg3WFFuRmVPTFR2YlJJUm9lNXpUbVNtS1IrMys5?=
 =?utf-8?B?N3pHWlhYWm54NnFMb211VndHWG9vKzZ1eHMySHZVTTh2ME1rdy8zM3RUZ0oy?=
 =?utf-8?B?WVVPdUdqNU9xYUFIeXN0dkh4Mzk4T2I0ZVUvaGovYklXMFZXeW9lcHdoWVZq?=
 =?utf-8?B?Tm5OeXRiRFhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUZYaVRDc1Blb09Malo4K2ZIZ01idERPWkJKWEp6ODE0M3BNNFVUNCtwUzJW?=
 =?utf-8?B?OFpzM3l3M1cxa0hsc05JZERsNFE4blRHMmFUdGdWczVyOVFEd25UMVpuN1RP?=
 =?utf-8?B?dURaSFRNWWhRSVJEUUZZUk9OeW1rZ2xrWlpCby96K3p2UlBkb0I0Y25XMnIv?=
 =?utf-8?B?Vmk0K0N5WUUzbnE4WTFXWk9jUUgvQTNkNHpwaHZ1c3VobEw3ajRpNUJpNEJS?=
 =?utf-8?B?eDYxbXhnakZUTSsyNVdwRXB3bTU2Y3hLd3JxQjRwZXZsWkVuMEtsZmdKeUR5?=
 =?utf-8?B?cEplcEZhUmsyUHZxTTJBRW4rMkpBY0FKbVVTT1NVaEpUS0ZjMDkxV0Vndngx?=
 =?utf-8?B?UHFuL3I4SUswbG0rTW5nOWUzZW5heDErdk1LODBLWThEM2xjOUpXYkp6eU54?=
 =?utf-8?B?TGhLWTlXL2JxdCtSSHZHVENlM0ZaK1NML3pYS0x2REVUOCtYOStuZXNad0ZH?=
 =?utf-8?B?SWI5Q1lndXU1RERiZDhtWUFoaXZ4bHBURFJUQ0gyTmxGNHFoUVp5ajJzMVpn?=
 =?utf-8?B?Rmk0cjF4TmtObk9rejU1RXdUbmNXV0ZKdHlORCtFU3ExbHNHUE1QcmdxYTdR?=
 =?utf-8?B?MHc1QnFKY2tBaTU3cEFzbXg5RGdaU0J5bGJ5U0FJWUQ5Njcwc25NdFl0aVQw?=
 =?utf-8?B?VDVPcW9wcW5MUk5BNVpMTGlla2FMNnZvQzJXckFiRVU3YU05Z3JDVmcxN2Q5?=
 =?utf-8?B?Tjg4anhPRmx1RWE2YnZzLzkzeThudnc3S09CZ0RVaXNKUWluZmR5K2hpb2Qw?=
 =?utf-8?B?bHZvY1ltTXpGcWdCcnRVSlMreTJrbVVOYU1pbmJ0eFVoWGYyTG5MVy9uTWg3?=
 =?utf-8?B?Z2cyZkZRc3p6clZ4bHdqZ1B5TjJNTzlDdnZMbEpKeDJ6ZzVkS2UxRlZmb3Zh?=
 =?utf-8?B?VzJ0UTQ4YnJWTW1SYzRRL1VTZEhVSjl6TXJzdSs0ODVPK2tlQ0EzdmhZdzc2?=
 =?utf-8?B?U2tYWk5LYnhoY3FlclVTYmhiRW1za1lydEVGT2VDK0MxS0cvR2dCYkxzcXdT?=
 =?utf-8?B?Ym8vYk5CemFoOFpiWVQ2ZVVVQVB4Z2ljbi8vWnRDVGpFd2pmc2lIL2RCdnBY?=
 =?utf-8?B?UEVkZlJTUThRV2hSeU9zaGF1a0VYVnV0bm9aVDk4d05IRHkvUXU3VkpjK3J6?=
 =?utf-8?B?ZGtBVkV0c2RoVEZKTU1WY0ZWYnRZSkVjdUJOdzgvN3RIRStzU01rdStCUm93?=
 =?utf-8?B?V1ZpYlVkRS82b2ZiQ0wvci92S2x4WHk5SUdwdHV6N1NXTW9LTzVJMnVVUkdu?=
 =?utf-8?B?aXBTMHFSQVVDQ2lETHk5cEYzVFd0YVpxZ092VitiQk1zQnAzdGZpQ2J6WEhS?=
 =?utf-8?B?bFRFbjlJYytjbndzVGF6WkUrWGExM0tIckQvQWxDZFJjcFZSSWdTT1U2Yld2?=
 =?utf-8?B?WHhrRktKTDVpQkZSeDdjZm1IQWp1QnZhRUdBTTdQR0luZkhkRHdvQUxqWDFJ?=
 =?utf-8?B?L043WXRocnFZTDkrUTAzNTVNWXI2M3lYbEFEQ0JwckRJUE5kbnNyMGk0QnIy?=
 =?utf-8?B?UWFKU2FDeEZLM2xSNC9jQXkrSVE0WHJCZ0RMV2FvamhkSGpMVkZWTUhoVUFq?=
 =?utf-8?B?SzVsaWM0d2IrMFBtMFpyRzJVR0pkUVNUOG1oU1p0TG8ycnRUa1JVbllKeVgy?=
 =?utf-8?B?T3E1WWozbUxWK214NVVwRnV2am5WVWRyS0Qva3NUdldSaElsREVKQ2wxaDdm?=
 =?utf-8?B?V0tVc3NGTThsTyswNElRa2ZHZjRTS2ZVUFpudS9nTzNiYW0vcmI1d21XZkdq?=
 =?utf-8?B?NktsK25YazdHVnJCSzVVTDJkZVZ3V0oydTNYVzNPbFpsaHFwekFKN2wzdTVp?=
 =?utf-8?B?V0pvellOZzY4MFhPcm1LclFmejd6TEtCODE2UU9EWkZtZXgvUEkwYkZBTFZS?=
 =?utf-8?B?QW5KNGU5dFRONUpEWU41ZlppZGNhSzVOVEQwbUQ5ZnNvNUZHRFl2S0s2VmZL?=
 =?utf-8?B?enZuN25adFI5Uk1IVTFFaWtKZVJ5U2pqVGVydU16Y0hmTmowY08zZ29SanFh?=
 =?utf-8?B?eUl2eU93WW5rbS82amlmUStWM3Z3WFJTM0dtbW5ndE8vdHNBRzJRb3RBTytL?=
 =?utf-8?B?L3YyWU43QVNIak1pQnV2MXJpcUJ4Ny9FSTg2UjNtRWJDYmR3UmswbWpQa3dW?=
 =?utf-8?Q?LrF/39PVePyXETeZVGGVvz/Jp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9f5d41-a9bb-4688-97a0-08ddd4cbfada
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:31:11.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0c0l6aim7PN/vHJBHjyrp3YecBHwJrZji8njP1DMb8580W2LGSAWGz/07iZ6TBG2Ck9xnc+mmYDRjrJkn8xlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020


On 8/6/25 09:46, Alejandro Lucero Palau wrote:
>
> On 7/25/25 23:41, dan.j.williams@intel.com wrote:
>> alejandro.lucero-palau@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>>> initialization.
>>>
>>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>>> exported and shared with CXL Type2 device initialization.
>>>
>>> Fix cxl mock tests affected by the code move.
>> Next time would be nice to have a bit more color commentary on "fixes".
>> In this case the code was just deleted to address a compilation problem,
>> but that deletion is ok because this function stopped being called back
>> in commit 733b57f262b0 ("cxl/pci: Early setup RCH dport component
>> registers from RCRB").
>
>
> Thanks. I'll add this.
>
>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by still stands, but I question why is_cxl_restricted() needs
>> to be promoted to a global scope function. Are there going to be RCD
>> type-2 devices that will have Linux drivers?
>
>
> This was necessary in previous versions where a new accel API function 
> required it. It is now gone, so it can be defined as before.
>
> I'll fix it.
>

It turns out this is not the only reason. After moving 
cxl_pci_setup_regs such a definition is needed in two files, so it needs 
to be in a header, but not in include/cxl, so I'll put it in 
drivers/cxl/cxlpci.h



>
> Thanks!
>

