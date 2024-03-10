Return-Path: <netdev+bounces-79026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDB387775E
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 15:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949BA1C20DBC
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06D2BAE3;
	Sun, 10 Mar 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5+Bt2eY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA361E485
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710081922; cv=fail; b=n3Z/dd3Sqvs1qB8SqPh1JFFr9whHe58c6+cxfrVx4qe7dBMAHm+nXfbE9yHgg/Ygp7/QKFAq34o1uarYv3eYPGdV7rkBd7tUUEtK/vVfklkwFfigrY7ORsGL7ffZxFnlsT4sJKCnUF6FyVq5ytY4H/5iu8Lj1Qrh5o5IOKnGZYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710081922; c=relaxed/simple;
	bh=r1nRy5KLg/kDOkU+013OTp+4sfqTxQAJ16pr621QDhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u21Hjfob0e9hVun2k/wIfMj/8yT+jgT+Crno7KYNBs1VrDXrRyO0oQxoc+e/0fbal7iJFN7g5GO/WTZk5fcHmgCn4HBrCLXef+QlAgw1bax6c6jFe14Gs3dC715L35VbCW2YfLl4/dCT1CUnrZl2ZMZpwjZj+6OFWTY/Grd+jSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N5+Bt2eY; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErlqawHsKdd3PACBfGKR49YR3gvr5KdTWp3qVMfCNNEgUdL5DSdskywfBealh3V1uhdIXgJ+2X/hxFsqUM/SDQ6JyUNkQWNUPzuNB+uffkwYJQH+KggVlGfsxI+kawYj37SN8uo5/xY8ZuPoAck+D3vRdPL1o0RqlXC0+d4rAK+VYf7Rn5qZ5n3A//J1YGNVmXmlj0kq7MmJAMH9/JwAqrrpz4aC8XU9FyxxLsZ75IprZgKnOhVoddhxsRKK6TLd2/YAaVsOt7YGl3VaNHHjK+o+S6ukSV5MjVF61RKAWJN//g2zUxxV8joPFC1940n+jLvTC7OAmq2NZx2bt6D4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3VD4Pl700ek0RcqeqJcUCU9vGd6ep1qmYEBagZnnuw=;
 b=PQT5tpBEoXV1PJXb5mij6zG1Dt5j+8xSD5aeP7DuXNp25ka7Qklw8JuMiJthBtDM0WKod3dEvyJe+d4WFMpgihW25IanpWu22940wyvw76nU9CfT8wigZycA1UDsJOjbf4gL1eBAtPd46DnTi/oDSjW8jyujRCHXW6E51aKe+mSnlwUrFG1JTFfrHCaSMGhPfJN6UVpBZZMJsoSu+sNUl8H/3dlkHRCCdag/XkjWIHyREx+cNvbpzowKJYR46vNvSifFVsaxGcy4ZBOsaeNLawEmOYYLuJS4tucOT+3uhRGtu3ys9x8WSrobPd5tLh74d4z05Sn0S8SEgNvWDMK3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3VD4Pl700ek0RcqeqJcUCU9vGd6ep1qmYEBagZnnuw=;
 b=N5+Bt2eYbIqXQM5uTlmJeeVtu9pl2dB0HxuBHSVFW1uJeLkhnMMk+Zf0utrreC3b19yaB7KAhtGHseeMdFfhBkQsxjZXYSccfR6ozvIQe1wADhDIPhi746XGOxfu2AhpGN86GV6E6vUomP9LzQJexb+AxPJmHkDtnEOTFl+eZll20bty41G+bHmbwII0ELscxY36lO5VuNps/ZKE1gptD+0XnKDrRuVb3FL4EdyeM+TdVu41TspfP9EiY7rKIwE4UgyDV3kdycY82XKRpz7357mKgqnYYipy9TyxCHIprsUzzzvIFjFZJSOF+kIAqoLHUpQCwBLx/NSGLnCSjAtRsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Sun, 10 Mar
 2024 14:45:17 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 14:45:15 +0000
Message-ID: <9536267e-6a3f-484f-bf09-dd53d704d8ed@nvidia.com>
Date: Sun, 10 Mar 2024 07:45:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] devlink: Add comments to use netlink gen tool
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com
References: <20240308001546.19010-1-witu@nvidia.com>
 <20240308201515.3b4aef71@kernel.org>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240308201515.3b4aef71@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:303:8e::14) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c204065-9928-435e-628d-08dc4110b2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OBJQ2E7ZDKnD+7DKhK8C5pmTArKGBstAH/0m7ZLLPBonJQ8DwgDYOPsapvoyCvigvjQ0WxH4BcMfrYEbY6HKs93xobHdpCcJuLmutoC2FqoSPmThhdHnbEuxHDYpNuhdapvoFRF9IOh6u8Arq72Z+u/2Qajc0FBtcMHvgpwAMfQRv1Vga0AVqWQHmjvVlMDavnPRmk1/smOF5UKVVmWROUuZ1N1Fi0kYKTvpnbGMUH5GHQeDtjNXVm+hbY97b4nuKNO4YldgccdCzMDnmmH3jSmTQRGf5Me3Yk6qaAYC2vSXzeaaKfFSF50Hf1TjW4E6s5tWixqwwsdl3gQmhG1RO1Ft5cXNRBOn26bGJYB9ssGbSMfHO27jP9zI+rQ5TQh9wbZt4DZBRE08ajPq1a1n7QV9HW61yY8TsdqEYsNNLJEuqk1EfRG9NUjjmcTzbMgoYz1XVll7FRNV3rM4LRp2g5Rf9jiwGjYOL2cZyoq5kKCRb3dW8vr9wJlthxgpInh25s4+koY08Gs3RrTrMTWGtozfl+jGJxCX9xwkBA6FwG7ybherAOaVlwsMwzq6XbfVCDsxlcNcpjbb21FiukEylJ4DKfYi2CpzIVwyxND2K7H/xC+U1Mw1oQXubYmn32HELN6zKCZPbF235NN6kKig1m7zWHGLJNFndIhdsuzR7ZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk53M1E1b0FwVGVGMlJMaytNbVV6S2FTMkpveENnTVdSeFd6SmswV2ZxYWpS?=
 =?utf-8?B?VktqWHpmK3plb0lQR0x2VnZLc0l5cHhRRkEzTkZra0RGMXBTS2JCV2RKTEoy?=
 =?utf-8?B?L0J5dEFUTzJTNy92L1JxaFUxZEZXVlk1MWhIcStWM29BWllHcE9sa0JmSk1k?=
 =?utf-8?B?OFdLR2lPR1lQaGIxNEhaVm9TYUlFbnZYek1tdWo1NENUajQ5N1N3WU82RmR3?=
 =?utf-8?B?cm51aDhYdlMwR3o5V3Bqa25kMTA1UFlLamNBbnZRenlCenl6UHpESHc4NkNP?=
 =?utf-8?B?NHgyTFdEbzRBc1FDUy90My9paUMyQTNxLzI5a1VOcGt1ellIa1FLaG1INDZS?=
 =?utf-8?B?VUFTaHR0NWc1NXorTUFGWWxFN09uaGNlSGluVHdWYVhRUTZldVdmSXh1T1VY?=
 =?utf-8?B?aHJEQU5WUjBhYjFicXFhdkJVblVZZjlXTWpoeDQ2NktRdmU2SlFXSW93cXhp?=
 =?utf-8?B?NU1zMW93aXl0RFU0UytpUzFyV3RoWFRVNTdpbm9KbzlQZm9HNjlpZjVLRUJ4?=
 =?utf-8?B?b2thVm1Kc0ExOWdMSG15UlVUYnJpblplWFlmQUMrckh1ZGFUbDV4ZXFqMUVO?=
 =?utf-8?B?VTVUS1NLbG45Wk94NnFsb3hUZER1ZkRqV2ZRcVh6TlZkd0VSSWtMN0Z3dkls?=
 =?utf-8?B?RHg5d1hkSWNpZkowYTlwWGQvYU1VTFZqODBKTTFDd29Hb0Excjc5RjBZdlRE?=
 =?utf-8?B?MEw3TGY1UG9xR2I1SmxKeFhFWDhEZU85TFFUNHlHM25jVUljam4wSklhR2VZ?=
 =?utf-8?B?blZzaU5tZUdkU3BnWU5zZnE5MEFVWXk4UFBycDkwVHVjVGcyNkVPT25aYUZ5?=
 =?utf-8?B?STU4YjgzUE9Cc1NWYXNsSW5IcmFGdWxPeDlMN3NIWXVVcFJ0TG5vd21WT2Uy?=
 =?utf-8?B?eGd0ZklrUmwvUG5ta09iajV1MU9kM2t0c2pnN3cxQWpRR0x1cXJqV1g0RzFq?=
 =?utf-8?B?cXFrWHNzQ0Q0MDQzZytpVjFQK3p3RVNZWXVJSEJCeDhnVU5YRXA1dlkxeEpX?=
 =?utf-8?B?NnJkWUllV2k5ZE5wYmxXUlF3S044OUluM21VVGw5N3FsL0xkZE95RmtmOFdL?=
 =?utf-8?B?TTZSc3FqNFFibldsbTJiSG8wRWJ6Qi92Tkd0MEF3dlk2L3lnY1U0SDlCaldH?=
 =?utf-8?B?OU0zMnQ0SW5JYmxKL0pRd2s0OUNYQS9QYmxaMTNjR0dJbTRac2ZIMTVpWU5H?=
 =?utf-8?B?VXcvdy9nWW8wNEJ5TWR6NTloZTNVMU05cmErYk8wWWszRHM5dGZ1WW96M3VP?=
 =?utf-8?B?K1QyNEFsMDkrcVZNQ0lQQXlscDBDdGJwKzRwWE94VlNzd0o1aHJDZnJtbXhM?=
 =?utf-8?B?bTR2L0l4d3ZhT2xjb1FFRmlscVlJRzMwcmJhVXJneFJtRVFENmxZcC9LeXNx?=
 =?utf-8?B?REZadkxtcktNZ1ByaXFWN1ZyYkJ0T3NWa1I3UkQvNGNaSGpUeUtBUUdBUTNC?=
 =?utf-8?B?STErZEF1ZWt2MlJCRVlRZ2xCc05Ud3pLa1hvVnlZcVJwYkszRkxlQ3RueFV2?=
 =?utf-8?B?dkQrUFJKS1pwRkZtYk44STdqY1E2eHFITms5M2lYZDQ5T3hvZnBRMkpEUWpj?=
 =?utf-8?B?MTkzRVI2eDhOckczaHRZTzNLZTdGU1JlL3dYQWhUYnlsT05RcDVjQ21VYzIz?=
 =?utf-8?B?MEx0dHlVbjdlWDQvWTR3K21DSVZVSXFzdzlrM3k0bXFTdkM0WnlQdWwycmds?=
 =?utf-8?B?aEMzZHF2RDllc2dFdmFHOS9UeFFwZThBczR6WVl3R0taQy9OSFRBeUtCczgv?=
 =?utf-8?B?L0c1S2daWEFXODlyYkYvU1JWZlFRT1FjVUxjUDIvQWRrYU5PQTdvRG9PaktE?=
 =?utf-8?B?amJTNUNsVFFZejZnUDFOS2dvVCtJOHlYUzlZZE8yRmVWNHhoRWt5WHplMGhL?=
 =?utf-8?B?WVo5bmloVnF2b3AzOFpHd0ZYS2RrTWxlc09uODBFQk9mQVArYzZhTjFGbkFr?=
 =?utf-8?B?YzExaXcvdFVHYTVDb1U3S0JJRXJMZzRwdkJHMXBQMG8rTzBIMFZJRmpLa2Vm?=
 =?utf-8?B?d0NxV1FvNUtKUVR0VVNXQXA2bU52aC81d0FGbUxMQm5OeW1xWXR5Q1RJUDRm?=
 =?utf-8?B?Z1d4aUVrdWxZUllTeTdIWjRNNGhhUWh4SGd4NlBKSVlDaEFaaFBVUUhXNWpy?=
 =?utf-8?Q?hXxg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c204065-9928-435e-628d-08dc4110b2b9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 14:45:15.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqBtuzMToj/E4xA2TmfCfGioG147s9hlYrw/HFZzfsNvivPrrafxUTzH+KfZ+jSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858



On 3/8/24 8:15 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, 8 Mar 2024 02:15:46 +0200 William Tu wrote:
>> -     /* add new attributes above here, update the policy in devlink.c */
>> +     /* Add new attributes above here, update the spec in
>> +      * Documentation/netlink/specs/devlink.yaml and re-generate
>> +      * net/devlink/netlink_gen.c. */
>>
> Unless someone feels strongly I reckon we should heed checkpatch's
> advice and put the */ on a separate line.
> --
> pw-bot: cr
Will do, thanks
William

