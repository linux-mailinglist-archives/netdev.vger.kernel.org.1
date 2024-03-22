Return-Path: <netdev+bounces-81256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C522886C1F
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE13DB23220
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611D1E892;
	Fri, 22 Mar 2024 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AJQO+iHn"
X-Original-To: netdev@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2094.outbound.protection.outlook.com [40.92.102.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326116429
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110733; cv=fail; b=KhCICfCQ7GiEorscCMeipYpiyrOCSNe1a7f3Bai6TRD376zjvPRzxxvQhnpxMls9a07wF3zRTP51Uvv38wAxrs2dhKc88d0HUEK8zyN+WXW2dj/65grYAltcIue75p7KFQyDgsOxoOyxfXXGEfNK+pKCUSH08OxoL+gz020OVkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110733; c=relaxed/simple;
	bh=WtFoH9f3rp2VG9zMZm1gnajWeEYWUsP1FhELYDMSEr0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oUnxiYvt2wJxy+uxrWPkz3oT4ikq020NZ1f3iLT6eAgY8pIWVgoaenKJZUhgeU2kF62C3jxlh8z0kxR4+EaSvc/ftoFjGB6vv4eYMTJfAdKpIzdug8PJXKSs6ByqOLLarXShia/on6r4miGH9LjKBPiKRHZlCiJrvcyovT09BwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=AJQO+iHn; arc=fail smtp.client-ip=40.92.102.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBVM5goBYnDpa2CTQOl4DYpLatB6QN6HHuqNGNN0UCjImTKU4cxMijk6xbGCp+nxws2VgZ+INFA+FELnHm3J1D76DevngonVaokJuQ/ppBnRpXky2W2suohB4V5G9IlPQAC+gUAyAJvkEKxRYTMfc1LlYc5sdJrS3aR0agzvzBuXesQE1y2lmPrJSaFtnOxKCyR7ywNy3ET7/Nhpsf2g2nxHFpOEpDwDA4eaLUtrFihG600ErUX0ScV/LNWIdYuqrcS05HhuzP8hDRZaF8zqXegDSvGnqw+CIF9lAQMSbKXv2bInzilkOZrr1dAcTLQgYr42W0acfaPzu8ZUjPEdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSfKJ7pXOZy7tFQ2ImoipFXLrORHAg+J3ilcnc00qdE=;
 b=E6o8LcKM3ZTknNmfxK6asLS/eFiAnKhWCJHY8ON8mReMDfYYgsavS4taqytIwpbRdizwtamJxlY4UUUvl386mC4SNBlMKitE7UggPVFYzuquck0CeXpk7ILLP+soe0VXFEBo73D0LPZM8zIfWUFXswNRKnJmgpISbEjukoOTbbTxeY94lRq8vxjVXeFd8zcghPZBKmtF9kl4y/5KCOsMGYP2NsKpRyovM2sVgPHKAncL2t4gg5wuIo7LeYXsYfyJHy8tZAnukjJk0bwQMesOjYnYTzTDGo/VLH/HfOYV5nZFsjEnz7q3rsBgYDX3cCbfv+Gl9miv6wy3p2ykvACOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSfKJ7pXOZy7tFQ2ImoipFXLrORHAg+J3ilcnc00qdE=;
 b=AJQO+iHnHmp/PfHENsqbG0UNpjEN5HEXnpYmtHHai4gYmQtQ/qgyfm0m3meMBm2ct4rnibbV96+8y1xm0SW8c6l7d9VvhsrGdjjNNSdfGeZtGZ8acwWqWcQxWVp3Lf5gZ48n7zJlZM6F6qg1lk70mswr4XyD79zgG0653Sx21c11K24HUwhCAhGjRbYZP6dGiBdpjJ/NYmWY2LRVY4BA3T1yVUozCkV73QDtkMT2Zqh89GXBdj8pdOaqD0fiPwwmlz8/zWGjNazGBTnpBDLc1DjXGrbpy0UDTWDedfcR+marHRJsyqnI42WujM3nweGxAb9twS3seoQ2cRxa9QYoEA==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 MA0P287MB2022.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:123::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.23; Fri, 22 Mar 2024 12:32:05 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60%3]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 12:32:05 +0000
Message-ID:
 <MAZP287MB05036EF508C09397B4BE31CEE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 22 Mar 2024 20:32:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: vlan: fix compressvlans manpage and usage
To: Nikolay Aleksandrov <razor@blackwall.org>, roopa@nvidia.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
 <d6ac805e-1bcd-4e06-b3eb-58fc2bb84461@blackwall.org>
Content-Language: en-US
From: Date Huang <tjjh89017@hotmail.com>
In-Reply-To: <d6ac805e-1bcd-4e06-b3eb-58fc2bb84461@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [cD8BIeC/DZAjtwmQ61P6RBE834rdrY8pjevJvNaVK4VizkAa/droiT5crFXRi022LVg1JBiGHWk=]
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID:
 <9473db69-135b-439a-8301-83b98ee6ba8d@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|MA0P287MB2022:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1ebb31-ed37-46a5-17fc-08dc4a6c1548
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jxVtGN5MsFVSJUMsu/93HDjj70gct3Hs2A0hqEaO78k/E1MBblWmAKShHqDmJvXw7nLSoujaCANjITXmvLXPMEwete5z4wE0GaZivt+KIFtAvczUX0IfkBvr1Lge0irWx5hGk6/5wQFo9ucxmQ4lerdoofqwnUND/vAZCOY7YVqCPfdbl3W8X9VJNVCed3Gnwux8oWXCmySStULnqrD71uctIYqVKQKAI0No25wxQMoTlZauIxPIRdiPMkfVMxASTlg1MCCJFcx0GWbKPVUVZz7rvrQCl9ve1I65Xl/NLGv9aG05lex/xfBtrLL2dzs02RY94yjANYUHSOPKAi3uJX536P+gOaes+vnETgGxjarjfjSsjCLa0pcFOk+dF9I86Jg0dnNqNDDbOtY0zzvt6d0oW8uPGpeAQcVtLrc0nUZDaS4m/p/lnqsioh7SzxUvd29EYFRrhWU4U8Ux0tfOF9pVtkqMsaXxmi0umHlJtQdLUI4Mix6qOFb1w0uxHrfC8VHGe/VR0Rv9kDcQU5BKF1Pl7Ocz/ITS9fDF2n/+1VgBim2FNHDinTYeOjP9XkiU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SThqbEtJRnNYUFJSSyt4L0YwcUVQaUtoZ2lTNFExMGZlSzlGR2l2dTFsV3RH?=
 =?utf-8?B?dXJEZXFRYUpSZjJrK3MyT3plUXpBdk43SGJJcXhmNGNHeDRJSmRuTG1GdElP?=
 =?utf-8?B?ZTlYMGJTYXNhTVpnN2s1WXM4d21iQkE0MnR0eTdXeVdJMUQ2cHBjTzIvWXhr?=
 =?utf-8?B?dTFLZ29zUVN4WmtPeXdSRFZzeFZCcTlvWDhvS3NreVNIa3VvR0RmZjFWS0Fl?=
 =?utf-8?B?aHEwWnpSTzZISDBUZ21teWxXdVJ3bTZIUE9KdjdidmpsZnZMYytPbmVZSTVI?=
 =?utf-8?B?SmpyY3hLZUdhSGRoRHlzaXM1c2xObWtSTFRQVitpNXVKallmVE03L0RJK0tX?=
 =?utf-8?B?QnNSd1RyWDZoNGVtTmIzUDZUeEJpYlRUWnZYRWZDeGUrWjV4Znl2L28xV2VG?=
 =?utf-8?B?SFhjQ3VvUVArUFNUL1d4UEFUd2RQRWk4anlxKzJhbmpxL2tWZWhkNFBwRVVs?=
 =?utf-8?B?VzZKdkdCWlhjdmcvVzhnazNBUTNhaDd6eGk4eGdYclFLSDhJWUJyQjVxTXVm?=
 =?utf-8?B?dXFBS2JJa21PdEoxUFpJVE9wTDRPbUxVaVJyQTVHcWVxOUlJd2JkMXY0NDY2?=
 =?utf-8?B?QnpuMWFYd3E2RzNCLzFTUGFPZnBWMTYyMm9tNk5sQ29makxhNms4WTlDdmFC?=
 =?utf-8?B?RXdRODlzUkdtdlNjOFpoVFQ1MktqTUhMTEhnQnh0R2I5TFJudGZoYUk1Mmh0?=
 =?utf-8?B?eE9FRGcramtQYks3ZVg1Zk1WQnVVdERUd05NL05uY1dsSkRwWXpoZ29SUXlq?=
 =?utf-8?B?Z3VVSU5MVDRqSThwcENTL0w3ZTBrTElqMzErUTdOVFhnMmdoWmZwRCtJc1ZG?=
 =?utf-8?B?SU5DeXIrWlZBbURLeHJ0ZFJxRVZqaG1HVUxTVjQ5a3Z2bXZWUnhmbmt0ZDJE?=
 =?utf-8?B?dmFUZXFUdkpqWmlCcjRobENWakVrZjdJK3Vpc3hCVVg5V1c5ODFLeHAwOXp0?=
 =?utf-8?B?ZmxDRUptQldUTVlGK1ZyajdnMWJCTzBaaTg3aUt6dVkvRWtoN2RLSXYzSmhp?=
 =?utf-8?B?bEpzTUkvOVBHa051cEZDOEVXcmtvcXVVZnhhNG9VM0pVMFFaSnRNK0ljcnR2?=
 =?utf-8?B?ZnlsYmhMczVuWTlZZmFqZVZaZjhSeW5JTjJrWk5rdGVkT0kyYm1HbUZTTGUx?=
 =?utf-8?B?TFlTbytMZFVKOERtbWl1Y2ZWVW1TN0ZhdFg1bVBDdjdzM0ZhQTAzaVNscHVa?=
 =?utf-8?B?NU8xZzlGbFkrWUhHcEIybVAvdnpRYmZndWNiUms2TURSSGM0cURTOGNwR2hP?=
 =?utf-8?B?cVZjaXhZbTQ0blh4ZHp3YnVXWlRhL2toMmw4SWxaRTVIK2xjWXNNWkpNcC9q?=
 =?utf-8?B?blR6eXI4R2xuUERyMHBabmFMQU1FVTEwVnV4M283blBuQmJqcTZaL3JXY0NN?=
 =?utf-8?B?SkYyeks4Mm5lZ2w1d1kvN0JITzdxZnk0YTY4SVJLTmFLMHp5dUdQc0VNQXg2?=
 =?utf-8?B?VWxJY2d3V1hzOTBaQWs2YytwWHlVVzRDaForZUI3T2dxQldoYU04enpCTjU3?=
 =?utf-8?B?RmsxTjc5eXVaQm51V1RkL1l6djh3eEtSNWlybU95THhFWFNxWVY3UzkrajNu?=
 =?utf-8?B?TkJ4Rk5JRWRucVFvckdtT0x4aFQ2dWdkOXBteHRUdEE1djF6S1VXUTdCVG9t?=
 =?utf-8?B?UzFLeUo1UkZ4Vno5c2U3YklaZnpKWVJDZ2lSc1BNNCtrRm10S3p0bnFPVlA1?=
 =?utf-8?B?dFNyajVNcjY0Ui9rSVk2di94cGpWb05JZER4cFdzL3FFTkthaU1LTjJST0Zx?=
 =?utf-8?Q?8nKOrydLoS1Ix6Sr6rSUu38v3zEK7mbS8WXlZya?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1ebb31-ed37-46a5-17fc-08dc4a6c1548
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 12:32:05.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2022

Hi Nikolay

On 3/22/2024 5:25 PM, Nikolay Aleksandrov wrote:
> On 3/22/24 10:56, Date Huang wrote:
>> Add the missing 'compressvlans' to man page.
>> Fix the incorrect short opt for compressvlans and color
>> in usage.
>>
>> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
>> ---
> 
> Hi,
> This should be targeted at iproute2. Nit below,

Thank you, I will update this in the latest patch.

> 
>>   bridge/bridge.c   | 2 +-
>>   man/man8/bridge.8 | 5 +++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/bridge/bridge.c b/bridge/bridge.c
>> index f4805092..345f5b5f 100644
>> --- a/bridge/bridge.c
>> +++ b/bridge/bridge.c
>> @@ -39,7 +39,7 @@ static void usage(void)
>>   "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
>>   "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
>>   "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
>> -"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
>> +"                    -compressvlans -c[olor] -p[retty] -j[son] }\n");
>>       exit(-1);
>>   }
>> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
>> index eeea4073..9a023227 100644
>> --- a/man/man8/bridge.8
>> +++ b/man/man8/bridge.8
>> @@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and 
>> devices
>>   \fB\-s\fR[\fItatistics\fR] |
>>   \fB\-n\fR[\fIetns\fR] name |
>>   \fB\-b\fR[\fIatch\fR] filename |
>> +\fB\-compressvlans |
>>   \fB\-c\fR[\fIolor\fR] |
>>   \fB\-p\fR[\fIretty\fR] |
>>   \fB\-j\fR[\fIson\fR] |
>> @@ -345,6 +346,10 @@ Don't terminate bridge command on errors in batch 
>> mode.
>>   If there were any errors during execution of the commands, the 
>> application
>>   return code will be non zero.
>> +.TP
>> +.BR \-compressvlans
>> +Show compressed vlan list
> 
> s/vlan/VLAN/
> also the explanation is lacking, please add a little bit of details and
> what the default is

Ok, I updated this in the latest patch v2.

> 
>> +
>>   .TP
>>   .BR \-c [ color ][ = { always | auto | never }
>>   Configure color output. If parameter is omitted or
> 
> Thanks,
>   Nik
> 

Thanks,
Date

