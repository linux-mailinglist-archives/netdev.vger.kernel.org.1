Return-Path: <netdev+bounces-81260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0471F886C28
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD27F287747
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9D446BF;
	Fri, 22 Mar 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ikRakqPA"
X-Original-To: netdev@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2109.outbound.protection.outlook.com [40.92.102.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153DA446B4
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110802; cv=fail; b=Yvu5L8XfFivwnkJO4nTLAP5QTy8kFnu0wQDxi3C5pGwKNz4XSONOnMZRwAuAozAHVUV+ufihaY53qoEQjDjQkWdP0rs80/lHcjOacQT4U85delgkOKddAqIuIPjxjsKtYTk1TzSiDcYikhWgXkeae65Wv3ny9m+vfMtZtRj47JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110802; c=relaxed/simple;
	bh=3tMZ3ONwoo06esxoMRau84kojByTUgxR83zU9F1G8HY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LSsY7m9P7HVzfjahX+WUYq7KS/9LFmxkp4e2ygZd8tJDjVqbsIwgUyxnLp4pKCzVPXDn6eJByaP6j/KxU1FSadcQVgvHmfM3VPRiG2kmj+EeTHtq6XKMZa3G4qqIGOvypbHD2cJ/xsbi7MIUmVWEPaNoGgTps5mxLB7RktUpzoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ikRakqPA; arc=fail smtp.client-ip=40.92.102.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRZlhR2hg6YP5+R2BGoRnPpNlC6upB0d7kPmioDLDuObl0WG+KbhalkFxyzbkQ5Dh3K8CAasNE+EsgR79khwK/bDykJb4TZR7Rx3xr5OCQmPVRUMIdbqUKGdjNtNLsnjmxeaPfwyL0Xr7Y+4iK5BZnlrY409pD6I3FfLnieyjemLRQxySlUyImwkPoJAotJ4SYe8w4IpjmjqC2U+BZ4erB5FX0hVc43T+6A39bhy2vK3pR9jlnX3LHIgN10PoYQURXyqnrlJ6LueK/DVbgP4aFJS1ViX9KAa2+QnpZOKuJRw+QGJLUOHHTRCjRf8/Wz7E7CcNg1hJGcrHl1nHSvZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoEjGAg9RdyShnpJy5zbrEoyAKyhMisKUkxeF7cH2m4=;
 b=N0tc0QMSE5YegOXLv2ap3zjlbvRrxlBiUNG/L6nvTh5j5J2p8+xM9xps2ncdCpPlt1Em5MVF87hZQaiA1TBYp62y6SORzg7E+gHY4omFE4P5Dg+npEH6on57QRuS4jYve8oyv9grgBRgy0HI/6SVsN7SnLrRLY9oY9RO/LhY6cGfZSD+DUeVBbnlN+2OqmwaOTmSbzhxEcyeYhh7lsov3HW+bocsE0VhhHbXFQpTLLd+nDt4mpa+NW5LJHlw9B05eZTKkwJKWc+pbENp5OQXSSckXIdDqNwnSiTJ1cCC/6FfTmki77T/SJZcuSOLIsP3IE+UQx0M4tJdQy6wsNaugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoEjGAg9RdyShnpJy5zbrEoyAKyhMisKUkxeF7cH2m4=;
 b=ikRakqPAOkc1iJqpCUzjjrkr3GRcIbODKtE7YSQCs/oAY57oMaSZ12XG40HJBOZBbsYA50YIirya6LWykYZel9c8J5s4fWFLf/z7wT59rKQ+SRdZ/qBo9glNydOJ1qupPKkaNxk4n6/e/zdhA9K1cDqqEaJRrgw2tuTYtr1pVZvkrQ0aFSVl+DrkTqvHRnC9+dKEhQEyJxoo844j2VRF7AxQ0JDQrPV6x/9UKgy59XloZ/yPx31Zf+QzT1vUjOhrYDFUK1BVXY5HcZOhgOEMogxobd32U9ODokjV9TfvTMtXei1cHId7AuUq/71iNiNw9txfIvt6Wpy1NzRtYQ9Njg==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 MA0P287MB2022.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:123::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.23; Fri, 22 Mar 2024 12:33:14 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60%3]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 12:33:08 +0000
Message-ID:
 <MAZP287MB0503ED9A05F83485CABD2513E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 22 Mar 2024 20:33:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: vlan: fix compressvlans manpage and usage
To: Jiri Pirko <jiri@resnulli.us>
Cc: roopa@nvidia.com, razor@blackwall.org, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
References: <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
 <Zf1SH2ZVfBG6O2EE@nanopsycho>
Content-Language: en-US
From: Date Huang <tjjh89017@hotmail.com>
In-Reply-To: <Zf1SH2ZVfBG6O2EE@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [5odL/J55DusfiHBo8r9N7yFBotHUmJ+na7epajx+9+56rTr4BAkfcrim6a8KafeIbJU2KxzA1Ec=]
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID:
 <57e4a3b7-1aa1-4674-a84e-3f88b64b63f4@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|MA0P287MB2022:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9975c8-d758-4f4e-711e-08dc4a6c3a9e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s6ovRZVWG9N+VuhHoNPIoZDkcCAJ1KzekqdtVNUQmss+Q9R9VLu0QinKfVcK4084/Z8JGJdmNP3cblKbkUKBN1+X6dNiUdVB2CEOTUo23sacPKtqlij7F+MnXlIvMPc9btbpLkREzqaO+mkf/QhtM7NB5r5R7+a4EVXIE++L5lKffKx0TqTeKQ+j5Bl28X28OFrEXvnNlOvb0hF/9twk5kvPWCuEIXXAVhwJutJIBpikGmnPmrDWF6gZ7Fi+eOfiMkzc/AJI2zDEJALT+xw+zG+8StwgViMwxmRxNyrisH9Dn0Z0LxWMsACIxgzSwXPrnPalnQAyUDyV4zvNfgwYr4XOksCAaFjGZ8HFHqY2A6QbXj2a5MxqMcUnCEY4Ezwj5AS0W9Y+1Yoy6mj1wZpbZSSHd6+WqzKmzsXrHzNhI6iOFZ9xMirycsMKgv+V8LZ1YFsKbh90hIXYGHr7QKQejkDHeKFaF75AWiHomMzN2+QfczTOFgK+I/4HVtQsk85e0LlR4QI+v+pgzD1MhmHUodifrthJeeHxOf/yGNpKs/j65oOW/jOsZpSPn2Rua5qz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUw2U0g2WlF6RDBQUGRVUlBPcXd4S2VFbDQzOHZ3TzRlSVZXOVd4cUVNRW05?=
 =?utf-8?B?NUFkaXZFS0dPd0NrSDNnZyt3cUVVRk1FZ1NrWkZVL3NKMmNEbDZ5Z2E2WFJ2?=
 =?utf-8?B?TUw2OXYvbTVoeFpFUVIzajFQbDJYRWY4d214cGpyVWxlTEUxeXYySFhQWVkv?=
 =?utf-8?B?YytUOGVzLytmWVFGWG5CNmdJZWRGMGxESTJCaEJlMHUyNkRtSUNDeUd4cHFs?=
 =?utf-8?B?cEVSbkVZZmpldEhLU05HbHJFa25jWWR5MGJWYzBOWlJjQTlLNDZNS2VTOGEv?=
 =?utf-8?B?OWt3a1pDbXlYaVFXRHJmTVZLd2xUL2VLcUhOZC9rYUV2aFJDYUd4YWVZMW9h?=
 =?utf-8?B?YS9seXhFcEppZ2JMdG5VUUFab0I5L0UxcFRqdkZNVmJsSXVSblYzLzN2Ni9U?=
 =?utf-8?B?QUEreDlITU4yOUZWME0yVkc3V3dXc1pyQkVNY000ZHdpc2dWSkg5ZjNaZFBm?=
 =?utf-8?B?UExuNkx4bkE5SHlXQTlvWTVZU3dWOHdqSXpxajZQTlFVb3NTNlhwNlJjUzhr?=
 =?utf-8?B?Y1A1YTVzVkdUM05TVHpuSU9tV21mS3EvTTdWcjUzL3dDV3drL282VTNuaUY0?=
 =?utf-8?B?ZXBqM2E5YmgzN295VHJEQ2VLZDNCNFV0RkFqeTlyWFZBZm5XY05jUVR6S21G?=
 =?utf-8?B?QTZXU25DWDVHL042VXNVL0VUOWViTjJ6b1hYWllKdVRjTmlaRFlEa3lDTis5?=
 =?utf-8?B?bmxOVW1QTDhQVzdDb24ycTdPOUx3Y0g2Nk53Y25oM1FMc0VZNmowZy9KSVlT?=
 =?utf-8?B?N3lZby96WllGaUVUZ3hib25tRU5tcFBDQlBuV2o0bnkvTEVNRnIvcmlUOURt?=
 =?utf-8?B?MENtb1R1NEdvKzhnR29WVmNraUJQa0xJUnZ0eXJkR25Ed1RiMkNreGtTb1ox?=
 =?utf-8?B?NmJuNWl4VWtEcHo1ckY5Yk82bDNmR0Z2NUJ3eUwxaGtOTjNCZGVpS1o2TkND?=
 =?utf-8?B?NVRJVXJVK3NpdDhFTWNRK1o5SFRFY1lWdWRnY05sTklxLzJYL1RyU05rcmVk?=
 =?utf-8?B?TEovUGhhaWJwclM3TG43MEpoNUxXNkxpNVhjZHNSTWlxTFlwMjlHTDJYTWpF?=
 =?utf-8?B?Nkxuc1E1ajhPMG5jYmQxTFV3STN6c1lyK1pBT2hlZGVza1ZmazVvODFnMlFp?=
 =?utf-8?B?S3JuV1duWExRbE9SUWJ1SHFpS0M2L2MxQU0reVBEaWRnUno5SGdTdzhFMFRx?=
 =?utf-8?B?L0V5MGFVWjhJaWgrcTlPUDcwd2ZpR3NmYmwwMEwwU1l0ZzJRL0lqd20xaXRH?=
 =?utf-8?B?ZHgwSnZ3K0pScXQ2OVFpcG45WUlJbCtYYnQ4VWljS2w4bVRVejlZcTZKVXNw?=
 =?utf-8?B?N0Q4Y0VOTnNDZUJOZEllcmVmeENGTUNEaC9DSHFySHZGSTlWZXNXekl5ZEVy?=
 =?utf-8?B?V2FwRmZKak9INVhuVm56ZUJkZVNRTEh3WmRYcXZOaFN6YUhxNEZHTm9WdXp1?=
 =?utf-8?B?VGplQ20wc2lPQi9FMUY3S3RlT0VUQS85VU5OU3RzTldIUnlvN0FIZWk4NURU?=
 =?utf-8?B?U0FXTllDUUZJV05ESEVSdUFUNjJoc0tYOUxraWlaakVNbTQxd25IVjdXN1h5?=
 =?utf-8?B?Nk5HWlRtM0h5R2s0ekZOQ0FWMjVnQ2xjZ09oUjNTcHU2Ni9qYWsyVlFzdWhY?=
 =?utf-8?B?R09TZEUzOEdma2o3TnJVbHl0RDhrWVlNcmgrbUZ1SVRTWllIMjJmdnExZ0pp?=
 =?utf-8?B?RUYxdG84TlNJbWZtT1VxVGx3M2dCVDhROFFSdXZLNzB0YkhudjJkdldJbzNp?=
 =?utf-8?Q?FS2ksH2S5IhXQm0juYRvBZ+OU9OE7DdQtZYXIBp?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9975c8-d758-4f4e-711e-08dc4a6c3a9e
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 12:33:08.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2022

Hi Jiri

On 3/22/2024 5:40 PM, Jiri Pirko wrote:
> Fri, Mar 22, 2024 at 09:56:29AM CET, tjjh89017@hotmail.com wrote:
>> Add the missing 'compressvlans' to man page.
>> Fix the incorrect short opt for compressvlans and color
>> in usage.
> 
> Split to 2 patches please.
> 
> Please fix your prefix to be in format "[patch iproute2-next] xxx"
> to properly indicate the target project and tree.

Thank you, I will update this in v2.

> 
> 
>>
>> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
>> ---
>> bridge/bridge.c   | 2 +-
>> man/man8/bridge.8 | 5 +++++
>> 2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/bridge/bridge.c b/bridge/bridge.c
>> index f4805092..345f5b5f 100644
>> --- a/bridge/bridge.c
>> +++ b/bridge/bridge.c
>> @@ -39,7 +39,7 @@ static void usage(void)
>> "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
>> "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
>> "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
>> -"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
>> +"                    -compressvlans -c[olor] -p[retty] -j[son] }\n");
> 
>  From how I read the code, shouldn't this be rather:
>    "                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
> ?

Agree with you, I will update it in v2.

> 
>> 	exit(-1);
>> }
>>
>> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
>> index eeea4073..9a023227 100644
>> --- a/man/man8/bridge.8
>> +++ b/man/man8/bridge.8
>> @@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
>> \fB\-s\fR[\fItatistics\fR] |
>> \fB\-n\fR[\fIetns\fR] name |
>> \fB\-b\fR[\fIatch\fR] filename |
>> +\fB\-compressvlans |
>> \fB\-c\fR[\fIolor\fR] |
>> \fB\-p\fR[\fIretty\fR] |
>> \fB\-j\fR[\fIson\fR] |
>> @@ -345,6 +346,10 @@ Don't terminate bridge command on errors in batch mode.
>> If there were any errors during execution of the commands, the application
>> return code will be non zero.
>>
>> +.TP
>> +.BR \-compressvlans
>> +Show compressed vlan list
>> +
>> .TP
>> .BR \-c [ color ][ = { always | auto | never }
>> Configure color output. If parameter is omitted or
>> -- 
>> 2.34.1
>>
>>

Thanks,
Date

