Return-Path: <netdev+bounces-265943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNKVAdrbr2kzdAIAu9opvQ
	(envelope-from <netdev+bounces-265943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:52:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A2247AA3
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B32930330C8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907D643C069;
	Tue, 10 Mar 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XFsueQdw"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715343C046;
	Tue, 10 Mar 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132708; cv=fail; b=qqeSKBTSFmxA9OIZEaDr3S01toh8L9BDv5FIJQLhjHunPbtHU28H/Yue+W0+5Re/0eiWY0U9/l/yYDwRaEQ1K7lYmv0T47qxh5eXSYBrPiy3VV1SH9IoIc9qp6S16+V4Sz2KYJCjOL250eFnenZMpPF4Gf+U2tKHsO1c2fxZB9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132708; c=relaxed/simple;
	bh=hBRzXXoXgNC2jVvs7YcNdKPfcF14ezjgNwtQ7Tz1ibM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KcDlA9KAxKRqLe8lav8POJFDEaa4zUJxCCzrAWL/MqHNUlyIo/0YJedDz3copactzMhM/oR6XKGw5BAiMuywjMdS9XSxyGZmYJxvMjTN9QTA9TKEHWV5NGDpI8hqwGOyq+vjqVElVsPiVCfg9kXnT/GBmBCSXLibuLUfBC3XEPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XFsueQdw; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbCvLrSLmf1P6ZQCVH7wyDU06Zt6hKFRlvA0F3W9bJAdApBivZspjhVTPe15SJIdZGGUZgOM6bdyj9cic/8VR/RzLV2D2VUlV5nwHbgK/mBXVwYbJw+J4g9GtN9Y/RmcDopNSLLFHXfsznM766zivN6YoxYbHjWwvevbZ+ORpuICdLnVtKh2IyUkq2HhRIAb0ejGJrglbnZLnMgpDgGVpu+iQVDTJSnuDb+5SEpB0Gk2RBWLOg1ne7xIWnwiszh2vJlshbENw4f750qxD8NMaG4w3mN0A016jEyHJR1gnwUQ0t4naI0z8OARhSCwmtxIOHj+k37yQ5sPB2C/wCPtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIh6WH4mBTDFUAkkqkguSGI5v0KpbC7WG/IjyrOkMb0=;
 b=Eqox+eFuhzeCVmFK+7IClH9ZU1Z055zsIZtaroyCsVvyspTzyAMJHXEXK6okWbBoKkge3iyAuc2qgiOA+mvJ1icD/V0FEk5Tg6/uceqXnG1WUU5egVOtkWxMTMA3NU7KC2tL+XcXOdjOyN8XGjSeOuy4NuiocJJbNWnR82K7wvPqWQFAHSs8ZFkV30tF7HeYZzw6zM/ODjUPHFvR1uAFqTpNC7MOwSamaDkvFMffii4fAy04jdDMeB68YUaGpMaGVY6S/hOHv701shr383EG59OeSzlp06uCAPxyZFq0ChYcVEsO5LaPZp18KcXXHvXal01PsT001b45E5LNnncCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIh6WH4mBTDFUAkkqkguSGI5v0KpbC7WG/IjyrOkMb0=;
 b=XFsueQdwVmdxU8JiVgbhg0eAslklj1ryJHblVYGtwuHWagXP02qTNe7+1MMJH1M9HpFPYoQ6cewy8b7COzp6tsk0bjsWio4pNTlwVE7XITmJpclk9BVeHyR3yT2GVunWR/DR9wWfoK6FO60POHQGlzhr2ToSv272yS+VK0R2utv71g0Yti1lwNlVKggoiHHABAvNy0z/iX1n+4dkfTD9JwiRZh6cOB+dffLzyIlcKpAGfqeWA9djyAIsQYDc2vtNtAdN0Si4VsEf3AocePzIylwPX05UxL4kLaTrCAZawGRvuHVuUrFnX4oAmBixAAQZLgxsV1MnTZ9vGWNTklUCNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 08:51:42 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 08:51:42 +0000
Message-ID: <f5f3c425-30b7-4778-8173-4f69b91a30b6@nvidia.com>
Date: Tue, 10 Mar 2026 10:51:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] selftests: net: pass bpftrace timeout to cmd()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
 linux-kselftest@vger.kernel.org, Nimrod Oren <noren@nvidia.com>
References: <20260308192126.2490631-1-gal@nvidia.com>
 <20260308192126.2490631-2-gal@nvidia.com>
 <20260309194108.4a68fec9@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260309194108.4a68fec9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0441.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::10) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: adc8c608-1b6f-4dab-510c-08de7e824047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	bU6lzZuNeanQ/xngBEWboh5SgrGeu9qlSk7Uug9ykAubY9nU8KzCY8utbTy/b0aysehpmqUIZUy7jTlQZPDF69B6MDYBspxJBaD5qnjVU99fkebKGba1RtixsRoFBUkQmruTpTETT3FGVON/TjYEhqzwavt4Sck2Gd285KS/JyLxiT2wh+GrgAmDNw+3Q5CJCO9qlzsNelWSLjcJJ/zAg6GN10oHlVxIEOokgkFtTVvQ9j/1//7YeXZV/NrA8P1oTmkizCj3NPgO/P/AM1RIo/XHSuBXkEgCXLI2ginEd8YPZtvzhKIQX1MAXK0udIZDQL8xBZG+3O0edAg6T/SCpBJJn6bsYpMRMZWN/475drNwirMzjOY7HUCWMgG42AbVmYEgPHViRLNTCaAAPROBlXSkGVyvR07a/nLDtJynVCSZB8YGZClzJw9v8CcoDVXoNAtXvBQU3mX0Y0ImMv/+5ZNa+JjLy5vRcIBEHE6z+ZBz0cvqLn8Z0j73rMUJN/0MD2S+qAhdghkH85/8aQHQyfx3iAyj5hTVpGIYntV0A+merbx7qznGJS+6JFQr9L//E4rMqsXqL2R7MR9sc96cpyoEws+XLM/z3cYlFS1LvLAvLWCc8NVw4/PcSc3NnEWFJzyn1EtHjKi0hMHpTapVrAk4k7t1FK304wMpt7F3G3FOmpjnNpcaPjc2UvjXTPaBne5zDktKc/SEM9AVdfPmNzkzpRVrm/pavyGcOz3MG2c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzJoQm5KRmdGMlB4cFFwMk91WG40SnN3WFBEZHdEK3RraVRCRTFRSXFpeVQ2?=
 =?utf-8?B?OSs3UjMzZ2xtdkpiOU1tc1MzNk13enVFcThhS3BjS2J6clFWVWFZalY4ZnpF?=
 =?utf-8?B?MXEzazRuSUJCclF0Y205amdON3Uxbys4TTBORmJ3MW9OQy9IdDE0bzcyNUZi?=
 =?utf-8?B?UEtiTElBL0FReG50ZVo5Ky8vTUJPemt0NnM2UjlaSk9rL05wWDJtb21teGJp?=
 =?utf-8?B?RUxmQUJHMG1DRnhiNForVnVTZDBrTDFWMHZqOENlVGtNM2tLcFJaY0dUcWRx?=
 =?utf-8?B?SmI0WTlvWHdUaGpyVnZKS0VrS3lVczc5WGFoL2ZUaS9oc2x2b0poaUd5UXhw?=
 =?utf-8?B?S0owbnh3OFFiZ2dIRDJSUTRNWUhHbi9tSnV6S0ZiS0I0dURPSkU0Zk5FWnI5?=
 =?utf-8?B?M3BGYjFUZXl5Nm9vSFprb2dQcFRvWDhrL0N3Q2FWaU1OMjFIb09MclZjdmVL?=
 =?utf-8?B?UnltL2dpYUpFSkNsaVR0TWdDZU92c2x5ZkZsWnhVdzZIckV4NTZkYXRkdnFm?=
 =?utf-8?B?M3ZHcmlFSHdiM0V5VVZGZlVSUkxISGRKSmVGcDNVdkZZNWg4MHhzamcyVHFk?=
 =?utf-8?B?dHFtTzRXaTExNVU3ZHp6ZkJYTFVESjBCd0hPa0hUam9hc1ZnVmQrTDMzcjVx?=
 =?utf-8?B?ZDBDeHY0QzFhQ2hWcWVkajI0ZVQ2MEd4WXlpMnhSS2d1ZGcrdlFFNUF1SU9I?=
 =?utf-8?B?Z3ROWXZhOS9rWElQZk5UdjFXYzlrNXNEYitWdnJoS2NaVTVvaVJzOVBLU2l3?=
 =?utf-8?B?SFE4c2VGb2tjakR2WWRyK2tJL1hEcExoYnoxT1pVMTZiSjFsZU40MkptWkNh?=
 =?utf-8?B?RjN6ZjBPQUpGeXF2UnFqOG0wRUtZQ2pib0RVWjgxZmRVRzlMdmQzYXd6d2hT?=
 =?utf-8?B?UWZiM3FxMTNxYkxXb0drQ0l5TVN1Ty9GSm16czBLeFZibEN6MjNWaHY0a0Vj?=
 =?utf-8?B?WXJwS1FKSkNUZjlDdE5JT0d2aXBLUDkzV3FlR0VpeGRhMWdMSVBvT1BLbk9M?=
 =?utf-8?B?cjJEMFQyUUI2U2Iya29zWHJIZTA3RUg1Q0VPWFFIOEJ2WUhFWHMzV2xaNStX?=
 =?utf-8?B?MGhDT1Fnc1k3K0EyMS9KRi9HbzhucHVHdnJOa21EalpWY056NjJselE3M0ox?=
 =?utf-8?B?M0FLMGErYjVGSlVSSm5ReWUraVhST0NSTTdneGcySkoyeWRSTlNGcld2citI?=
 =?utf-8?B?YkJXQXM5MWFCeHJ1OC9ia0szeEpMRGlFczlDZkhUMGw5QmJFd2tObDRRRG01?=
 =?utf-8?B?cVFzbUZVWUxwRWtMQWp1cGEwRmo2WHB3alpsS09tQ0p6RWY0K2R2V2paMTBL?=
 =?utf-8?B?SVYvaU1LckNzY0dvMWFzWXlXejcvQkc2WEU4ZUUyYXNZeTdCSnNUUG1QMXJU?=
 =?utf-8?B?aHZieDkvdzNCSDZNZDNTaFFUV2dHYTFSeGRmdUk2d0VRYjQwTUVML1l0T1Uw?=
 =?utf-8?B?c2ZoOEpUalRiWnhoV3ZUcXFPZWNvWC92SkNIdzFpT2U3Y1hSbVJzZGxjOXcy?=
 =?utf-8?B?d1RTdTUybnhZVFdNaEZMdStheE5nYTB1NmZ1NW4yaGVBMEswRCt1MWRYQ2VC?=
 =?utf-8?B?cEVvT3MzYVlQNU9Bc1hVZ3p5L0pVemY4Q3c0ajNPZHRHZDNSbnBvcFYzWkVJ?=
 =?utf-8?B?Sk5HWDBreWo1aXNJTWh4SXZVcXkzQXdvb0IzQlZMUzBsd0I5TG82Yi81eW14?=
 =?utf-8?B?TWNOYjZWY2xualVkT0ROVW1SeUc4TkJONTQvQTRyZVM1dDdycG1IbWF6WHFZ?=
 =?utf-8?B?c0w3TEt0SkhZODhmNGtFbm1MbVpJVHBSTUhhTENUK21BbmdKTVR1T2NlYlRz?=
 =?utf-8?B?Y3JwQmhsOUxQVkJQc0pZMzBmcE9rVWF4NGhaank0bkpCVTR0L2NQU3JUNW5Y?=
 =?utf-8?B?QXU1MzZUWnNUZnRGS3FYbGh4Q2JERUs5cUZNWlFmRXk5a3RyRjN4UWUxQ1Rr?=
 =?utf-8?B?dytYeW1Ga3lqVnNmQm16QUM3ekxLdnJRNDlHWVZjd2NwMkpKSS92OHhVZFRl?=
 =?utf-8?B?VzdiZnFhQXRYdFlFUTJaWjdCeHdWV3dOUU5TemgwWmVlWVkybkdHZExpUDAr?=
 =?utf-8?B?RTEwWUJNcm44ZkFQaFNqejhtUGp3aTZDZ05rU0lDeGtQd3p2OU5mZUhUaGJs?=
 =?utf-8?B?WlNnaGVrdElmOXFMQktnMjdVVGhVNS9PVmpRWG92dTRhYjYrS0RiLzk3aWdw?=
 =?utf-8?B?dVhsaWx2YXhrQ2paVlR1ZEJlQXh1VW5CT09XempXakJkVHhVajhZb05nUXlh?=
 =?utf-8?B?V1Znc2NhcVhDQzFYdW5ENW5CTXF1UExzNEQwVkM5NzVybzRoa0xnS3VhaUp4?=
 =?utf-8?Q?PrKw9txDSsArr4C+cf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc8c608-1b6f-4dab-510c-08de7e824047
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 08:51:42.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+J4kocu68LJ/UXmA9rlPWZOKi7sCd9gZgbwsP9ugFXP3cHIdqDrp4BZ+Cg2e2h4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
X-Rspamd-Queue-Id: 9F6A2247AA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-265943-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Action: no action

On 10/03/2026 4:41, Jakub Kicinski wrote:
> On Sun, 8 Mar 2026 21:21:25 +0200 Gal Pressman wrote:
>> @@ -240,8 +240,9 @@ def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
>>          cmd_arr += ['-f', 'json', '-q']
>>      if timeout:
>>          expr += ' interval:s:' + str(timeout) + ' { exit(); }'
>> +        timeout += 5
> 
> it may be easy to miss that input arg is modified so..
> 
>>      cmd_arr += ['-e', expr]
>> -    cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False)
>> +    cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False, timeout=timeout)
> 
> timeout=(timeout + 5)
> 
> here instead could potentially be cleaner, but up to you.

timeout is None by default, so I figured my version looks better than:
timeout=(timeout + 5) if timeout else None

