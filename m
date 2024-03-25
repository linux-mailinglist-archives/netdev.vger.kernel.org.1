Return-Path: <netdev+bounces-81505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8102488A58F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81CB0B25C29
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940012EBC6;
	Mon, 25 Mar 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="GY2ORUWJ"
X-Original-To: netdev@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2107.outbound.protection.outlook.com [40.92.102.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A3139571
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711344864; cv=fail; b=RRQ+k9nWnBAUZmtDPUT/4BjmNhOjhjYop7JNqQdZLVYmL33lQvk3k+/ZOtTwIRNDIFgzSWrawCtD3iUXxpaV049lhEzOwsn3DVjvUnrARc8xkm78FEZ4TEMpEhKQdZR7ZFBZUDeZyODS1Aj01v2WlfuOIpROjmnTUao9oDVrq1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711344864; c=relaxed/simple;
	bh=oXYpJ+c3XKCCLFpyE4uikszE7RZous+nZwZnBGS+K6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d0ja1N38sna0KRWReKwnxLNTTS+k0aONVyGePh7ALFSrdpC9BrLCPf9bg8xG+kTxZgFypRpoqFkSniOxasQka3v77JTDFyN8fV0KOy4UC8miqiioCMIojAjWw0qH9JJ7RTIp/DijjE34/LNy71Hws6kEtlACMvkTNn76l4s2VKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=GY2ORUWJ; arc=fail smtp.client-ip=40.92.102.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzf+VdS3VuitiyZZAk0dPG1KQXLeGAbq2yQF4GixsySMpaY564Uaa+T6VbFs5VzAzXfa+JdxfO6l/s8sliNH2XD1/DFUJxs/6YhEigGqXdvXvFkOm2OhZ2KUoKK8lSrbdg8hP64tqmq2IdJPF2sGThxzwCX+BYRgoSh/ndko4sugoijDjDOXwsEmgW++DENDtLVyc6QdGGXszT3q0V0j9kSobwfTf+hT0Ezt9UPYcnRKFENX/STDPOYiXUy3zqz46Dd3BfRpTjfZSKq/rh1z92lCkPrPLb2lfU3FVnLG6r15dmPSAeMBnt4WNDthSd+ABmgrIKJfDAH4bcs/OoH7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+XfOQRJ5RsBJv8xmUGuyeQJI3aVxmdC2JbvnQeBBRg=;
 b=ng8pRQZHbhxDLL6fEHThmYUVt6Lq3fLeE49p192cEoUMgiOhH4sOET1wQPxNdG2f7jNiqePGVhBFFsT3SHbo6nFvwMnV6aiV2FFGmv8ttpWrgqvCg396WxpGXQHlwnL+VDWaIFfXQi3HpXKqI8x/6jpsGrfSKBUSyY/A40ZUgIy8E/WSN8nxReYirl5gLFeCUt+xGNgFdqQ0R33bwXbCTK6Ffsi+X6bTbcyxWzaXiw1epDIL7GmEjwXpeAUlsBkohoPwlGingDquich6jsrUZ0E1h1G4gyUnnwaQXnTAhA2PXIFfwkXQYXiBxdOxG2fT/OHs0u6glyOyl1L27mEu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+XfOQRJ5RsBJv8xmUGuyeQJI3aVxmdC2JbvnQeBBRg=;
 b=GY2ORUWJ0H3vh+BiRrK2OxPN01w0HfbWy/jt8R7o5mJfY9DYHgUE1ZsCay1lTm4FVadBiM7BsFHutj5Q7SvnTE8ERQ/GFnwutAohwGhR5+QK7lRGdRDqA42Zjr46BdsOp7hzFHmwEDnMQC83Aeqsa/0VwmVlNIsqhH2OrbrVPekwq40RIxdrBGqsSsp6V2NZBERvT/2kSOGHAH6CFoQZFGXMOIgLasDPAg3Zgx+j32GKgLsfkVRXSb5dhjFEjgo8tA7NBq3NrlC0BfkmeE/2Hsf9zYb8CqGj5i05lQ7BtvmTCfa01YscdyVANprBy50NreMszWiCEp5J68aqYLEv8w==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 MA0P287MB0913.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 05:34:18 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 05:34:18 +0000
Message-ID:
 <MAZP287MB0503E04A5039E47B073C8E2FE4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 25 Mar 2024 13:34:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 2/2] bridge: vlan: fix compressvlans
 usage
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: roopa@nvidia.com, razor@blackwall.org, jiri@resnulli.us,
 netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20240322123923.16346-1-tjjh89017@hotmail.com>
 <MAZP287MB0503BB0A5D2584B43A734CB6E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
 <20240322084145.3e081475@hermes.local>
Content-Language: en-US
From: Date Huang <tjjh89017@hotmail.com>
In-Reply-To: <20240322084145.3e081475@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [FArR6f2jZ4bwbYzldO4Vknfncw6wSuoidX+aHaz2pljehbp2Xx/pmWfi+M45LUDMvSBY9SwtBNo=]
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID:
 <0fe414be-9a90-4324-8d5d-c1eee648ec84@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|MA0P287MB0913:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c62d63f-f4ed-4550-caa5-08dc4c8d36f7
X-MS-Exchange-SLBlob-MailProps:
	02NmSoc12DeffcjG+vpDyKOKsSLQMnbCbSCO3BUpcDTkABW3b+sHF67i3olHiEOKs1xnYkKy+EPOMy8lBRFEIfCkpFFXcYYhmFIK85YTw2wEIe8ptzb3Mh1z9ta4IDVNyga6sQ30z7jKG2IcN4NJTIetM2kvsu2zlhjiyzaLtcgzcRrqjtajDLM0F+V5c+Kv8+9VPnRYtg0+ElFrIfWatxxvIJ7KxyyFyuhPTMQyjKk3KwZ0Mth5AA3LQYIbSsHm7l5oWPtGmUTrlMTJhkf4DxjrAy+C7X3j7aS0/pJHamBgW+Gphm0me30cC5r151xdPEC4uOMYYj3sAEeT6vjatJWFjoBPi1ni9ENARaC5Pmioon/11Fvj+S13b1tB5tZjRu5zRVXKivFecgm6QUZdcR5jlIoMg6ua+Ha13jtujVFzNkqoroBuq6f4HIcy4kFzGQBW4yUNxaJ+n/yJIjJR/hCRRwik/OPX27ha8S/2uL4F9ETjXEb/bb+JrHiI87DSx9ksFbb9CCCJvY17S+xV+toqb3Gah+mOrvD8ZgsFOrb22WsIwof6K05kp+RwVsKgEGVaB2a+caNroayb4kerQr3KyP0+siHTuVf1yWNxhzr75wrQbTRpeXvHmzoBUfOg2WZwfpVACS7s1QU7UR7jeNNWuXOr+hUDyvGZEo8Oh14l/6zfC98u06BPBWYzsf6nbhcD/tfSC+Vp0VbchLR/ES6cw1GHT0JiBNE33NwkCMDIc78ozn8y0qGL0cRCFd31
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j0wy2b56itWcu0ZLKj8XbqnvT5NBvXiJpa1XOQXg3gKL2w3N4I59IlDVCQHyfJtmQ5flrDknDsHeIaqK6VsyyotuPAnHIZX6AraU2WlA3VG0oFwsDD3cpgRCyDNczR3oLa1uCEmPogwHzndVypMGVKpauHov2jbnmcchfWC4sdfQgz5G13UmvhFCjUOlb6xdkRShPDGgz8mTuufvXUjzDM05hvlPJPfPo8gNyfDGCP6NjllVHtm7yf5cunrBa/CmVO4StWQSceszy2MfRH/A3XegWTSgQgD/NhAENM2I6KZ7+zT2b6TEwiwFpGw5McdUFxsZlE8/dDLNUcQtbpkqeqkdPfOKqUZ8vGMszWLBIWYtZx6294EDZ8Ly7pQKN7FExl8HDHIBK/SvseiY8h7c0D2lryge01v+IxTpLv5dfyVbnD7ZdBL3efxO9ZJwN0qdv2NA7y4gCgb23zb7N1Pj/iLhD/kecz/VDLQmQ0TjnLVDk2Sg9vH0//lA9bQrfKYlZUM2DNponqQEKY9NsUB5oLXXyigUJ6hIKPbs7RMmuUb66I7Tznk/Kks1YSmWUNg6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDRFUWpaZkJUcEd2aGRBRStVSDRBZkwzSHhuL1ZpRU5SSzk1L1FZcU1sQlNB?=
 =?utf-8?B?bEpad3VCa3R5MmhXUUI2N0MyYndxeHZnNjY1a1RNcHYrWWZMam9vN3NJRGhz?=
 =?utf-8?B?czZEQUNvMGdqRkUrckpSYTZIbzFFcUp3U0FwSWlGaW9xY3Q1ZDFHNkpZNEJ0?=
 =?utf-8?B?eXJIMFdsdFowbm9Qb1RjcHBGWnBpRVBYanFsRlh0MzExamplNWpRMzNIYnZh?=
 =?utf-8?B?b2djWUdoYUgxOTkvQmgzalVRQ2l5Z0xMY2o0UjBSWTF3U0kzcWJWMklhbitE?=
 =?utf-8?B?cjlSSXN6ZHZFQ2tXY2taYU44SDZud1RmemNjU0g3NnE1Nk5ReXpKakV2SGMx?=
 =?utf-8?B?N281Q1ZxVEp0V0VYZmFhRU03b0JvOGVQd1U3aU55YlVzTGpCaWgrSFlEQytj?=
 =?utf-8?B?RDZkQVpYZ1pZOWpSU3hZek1uaDYzOWFwT0pYOUlDbnhnOTIvWlJHbW03a3l6?=
 =?utf-8?B?UWI4WHdVbUtDeXFsTmxEV1BDOGZxZWFTZHNmb3oxQ0V1dTk2N1ZhYTN0K3Yr?=
 =?utf-8?B?YUdhZTE5Z2htSEdnOTMxWGdqK3NYaWZ6VEorMG1XZ0tCUXo1Uko5SmorSWFX?=
 =?utf-8?B?Y3Q5Y3E0TFZsZWhiWkRGWE82Y0oyaDltT0pGdTlzT3c0d2VSQVIyODF3VUQx?=
 =?utf-8?B?SWZVUjFCL2lOTWc2azYvQUVqd0hMK2gyWE45b0M2eW81d2VOazU2dWduS3hN?=
 =?utf-8?B?UFlib1pjZWEvNFNaVjc4TmNVakJ3cTdMOGVIc0tXeldqclF6T2p6U0JpbWtC?=
 =?utf-8?B?MHE1MzM2Y3NjdDJSVDBHTmJEU2VqaFhVTUVOMDVWeVRKNEFhUFZlWU9FbXI2?=
 =?utf-8?B?djBBKytpaXAzQzViMVdYS29USWtXVXdaNG5wM040UUZxM2lLalBpWmpmeG41?=
 =?utf-8?B?YWZoQnN6Tktjb2hKSTZlQ3hvV3gwb3Q0OUFZYy9neUlpWWpvMWNublVUQjUr?=
 =?utf-8?B?ZDN0MmFJTDU1ckpuaDRIMERiRGY3ZG15b2g4bFRBbEMrZVlIUHpHUjRHWkxZ?=
 =?utf-8?B?d3ZITHNPLzI2ZXQ4Q2hXaUlkODc2RWovcHBQR0FrQ2ZtN241cVVmL1RJQVRm?=
 =?utf-8?B?VVpvd0lSZzFDclBsNWlRYUt6SjZJbkdvSjRSb2NCWUk3b1VsaVRBRm5Oa0lt?=
 =?utf-8?B?TURoenJJd2dIK09EUlBSdm96Q2xJWjFyQktoWUQ4MjhWRml5MnJBczVTWWhL?=
 =?utf-8?B?NEx0Zm5LR2oyUGFPNG0zU2VHdnlXTmkyOXh4VDNORkVSRmc1OVVoSlNJN0U4?=
 =?utf-8?B?YVhXd3RTbDl1aU5rdTJtSytENi8zeUUwbmlQNW5XMUxvMHFBRFNZV2JxZU9O?=
 =?utf-8?B?dWk5TW5wVzlSU2RNNXVGa1R3ODlySjdEaWt1MzhqVUVBbDNaZS9XbTgvSHg2?=
 =?utf-8?B?N05LR05lUjNkS2lXay9HZFMrRkdJclVjM1cxQW42QUM1VmN3UXdJZGduajFw?=
 =?utf-8?B?eTVhLzgwTzZxUmc1dUgvZnFuSEhvd2Z0MXRENUdKR05pdjZQd2d3NGJ0ajJt?=
 =?utf-8?B?S1c3dUQxbFJrTTFFekcyNk9KMVJNdDhWcHA1bWEzVU1Cd2VSUGdLUEpNV3hz?=
 =?utf-8?B?VHpiLzU1amJSbjNhbjNhNnJOTGxSdzhRclBsbUgvcXRiK3U3OGMvZ0E1YW1h?=
 =?utf-8?B?eEl0RThhbmR3NWorWlBJOU11RitBN251OWxGKytMTXRNL3RWbmUrVnl1R3V4?=
 =?utf-8?B?bzJNejhSOGdvNHZqUFpkNXJpaC8yVHJRQTYvNXNWYjNYclBoeUYzWnl3TmY4?=
 =?utf-8?Q?CZVCGkz5TEGQRzwUgqz7B9UfTOf4BeeSdWEfxJr?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c62d63f-f4ed-4550-caa5-08dc4c8d36f7
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 05:34:18.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0913

Hi Stephen

On 3/22/2024 11:41 PM, Stephen Hemminger wrote:
> On Fri, 22 Mar 2024 20:39:23 +0800
> Date Huang <tjjh89017@hotmail.com> wrote:
> 
>> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
>> index eeea4073..bb02bd27 100644
>> --- a/man/man8/bridge.8
>> +++ b/man/man8/bridge.8
>> @@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
>>   \fB\-s\fR[\fItatistics\fR] |
>>   \fB\-n\fR[\fIetns\fR] name |
>>   \fB\-b\fR[\fIatch\fR] filename |
>> +\fB\-com\fR[\fIpressvlans\fR] |
>>   \fB\-c\fR[\fIolor\fR] |
>>   \fB\-p\fR[\fIretty\fR] |
>>   \fB\-j\fR[\fIson\fR] |
>> @@ -345,6 +346,11 @@ Don't terminate bridge command on errors in batch mode.
>>   If there were any errors during execution of the commands, the application
>>   return code will be non zero.
>>   
>> +.TP
>> +.BR "\-com", " \-compressvlans"
>> +Show compressed VLAN list. It will show continuous VLANs with the range instead
>> +of separated VLANs. Default is off.
>> +
> 
> Overlapping option strings can cause problems, maybe a better word?

I just add the missing manual page and change the usage for the current 
implementation. Maybe you could suggest some better option string for us?

Thank you
Date

