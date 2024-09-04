Return-Path: <netdev+bounces-125059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1592896BCCE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893271F23872
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA61D9345;
	Wed,  4 Sep 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="D5MVa8Hk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E51D6DDE;
	Wed,  4 Sep 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454047; cv=fail; b=aiCr32eKaLv67Id051iWDaibVzxMn/OzUgUWleSuF9OxLCbdHHBRT5XM/aVVoEv+gNtE5c/eDSRIKtboBZIDGd5wkgdn0mZDDHPubJSHehGqaPu4RxFD7seFWIFXZoBGVXIQwP3lsBhqsYSvujAMa9vhobqWeMwEHqlpaQ9wXtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454047; c=relaxed/simple;
	bh=97Km+z9oDYp2Ik6hsTY32w8GOVkmZiKve7n1GMU4ikU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P/CHm90G2Ca7CgbamAlsj4Hx1ijmnL+PpZGSaoGrnObMAKts6AnibMaQ3b+2SWklcH6vyMHc4Q3LGvfTpq9j6LNqIzPHX9e5NmxJ96w5V97HImarOslxhM6bLTJ8petmIUxYawd2KL1uVYCmzTZoVop7mfptXIWIXuxqZajOtHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=D5MVa8Hk; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1725454045; x=1756990045;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=97Km+z9oDYp2Ik6hsTY32w8GOVkmZiKve7n1GMU4ikU=;
  b=D5MVa8Hks9RZYTc6EUZkE4uTBI7yo0nMcj5HBwrIrmym5DO+7mkhP46v
   IKlkFNgGglgq3y8pz872b6s3rgH5N44H8cqV5stIF6LGdoSotBFigteBt
   N7U6VhImP6WPPgbfOhbimog+cRV9B65CRzNyY3b/tgT9dQo+ojvxYX5B7
   I=;
X-CSE-ConnectionGUID: UC+GwCp8Tge8Vkwq6SrcpA==
X-CSE-MsgGUID: JAUvyjHlRomrcrfXQ+cglw==
X-Talos-CUID: 9a23:dvEnAm9AuA2zwWCzWZmVv3M/We86WWWN8Hjdc3G7Fn83c6eeUXbFrQ==
X-Talos-MUID: 9a23:hEFXnAVIY1/HOxHq/B3FuS9zNuds2aOrEksXn6U/+MKLMTMlbg==
Received: from mail-canadaeastazlp17010000.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([40.93.19.0])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:46:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9YTS4nC44vngJo23to3/OuIu7a/jr+e1YaVpy5f583blbbYn2gKpUp18V1DBY4ApEfipiq8BAGzmVc5dGLtrrDLgwOhJybpOgfOFyNfxuY8p8a7tA6f1G50qadG2Vg1NuRiky38f/7nhaP3UZPo5EsTosJG9ZIAWX8JL7zrnVzLDva6UsU7O4Vu6VqE98OeEhl4+Zzeu3X+TevQHCsJZ2DDe45nBpznKZ5sCzQ7QuOcdCAvk2Kn5Mf8Hj0rAz6hdLgR1FFC+bIyhHg/VOU0zRAbO5E1XgFbmHI4UkoJxeQ6f0d1YqGlqpue4mdq7UEJqjQ0gYS4vOPa2hnx3ixAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSJ4a/G0y39qsZpByjyGXhbZqIhde76MmlFPBD69674=;
 b=Y/tc2jwbzX64xtXT8svu/FYk07tx9k17M53v5HUo5IRjloBOyJgsgqJ4VEaR1VefGeKA8wYwxTJZryMcN4MVZfZP6/8Cp2jXUDWmvtIqTu+3EyedknPb3XT4rn1P3oZoSU99p5b++rN0+xZDAaMYJ2OQ0lx1GFzzYQmg+zVS5lykIIhzgEFcLkuePV/1TAyJ0ogyqW+vituX3vB4iC3zXvUWHUIglBqrAtjq2LBHRL62o8AdSnWJ/LfW3DJUoD2lx2JFOsggMV0rOz74xsG1kUmoJ2S5rMkElwxbbirjf9FrFoHrD5nUncXWw9w9WgLgrUVtgblOns4bkNkXY87g4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:70::22)
 by YT3PR01MB9866.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 12:46:11 +0000
Received: from YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7ed0:c277:f1fa:a3f]) by YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7ed0:c277:f1fa:a3f%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 12:46:11 +0000
Message-ID: <30ddb66a-aeea-480d-bf79-38fc06ea45b0@uwaterloo.ca>
Date: Wed, 4 Sep 2024 08:46:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add provision to busyloop for events in ep_poll.
To: Naman Gulati <namangulati@google.com>, Joe Damato <jdamato@fastly.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, skhawaja@google.com,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240828181011.1591242-1-namangulati@google.com>
 <ZtBQLqqMrpCLBMw1@LQ3V64L9R2>
 <CAMP57yW99Y+CS+h_bayj_hBfoGQE+bdfVHuwfHZ3q+KueTS+iw@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAMP57yW99Y+CS+h_bayj_hBfoGQE+bdfVHuwfHZ3q+KueTS+iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0202.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::20) To YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:70::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6565:EE_|YT3PR01MB9866:EE_
X-MS-Office365-Filtering-Correlation-Id: be409d70-9579-4506-956f-08dcccdf8e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mjl1anVlbWFjdHY0RXMrbnJWeHFrVlBSUlZWQTFCMm83WDBNWEhuNnY0SnU4?=
 =?utf-8?B?RXJHNmNWcGpYa2JVajZuNi8rdUFqVUk0UWwyS0ZBckFDenVCbWxaWExNK3ZY?=
 =?utf-8?B?UEgreG1MREQxa0M5RmtEa3RibWNRTEN3bG1qOTc2eWc3NUJFVnJiVnY1elBr?=
 =?utf-8?B?c0NITW5nUnVleEZhT2FOVkJkK09wNmg2MnU5RkNaMVBWdmdpRU50S3VhNTVu?=
 =?utf-8?B?ekJtOGlhSUFqVlRrWW9VMzh3bUlpV2VLSndKYVozZTBKWklteDRoMWdDRGhP?=
 =?utf-8?B?TUI5Z3I1WjJUbS81cmtucXdpUXVMQWhaejZwZDQyTDlYRS9PMjdCTmQ5UUdq?=
 =?utf-8?B?SFpmeTVzZDllTTU3dlFQRExBenZCdDJIQ09Xc0loa1NPSUtJbHdBZlZRVDln?=
 =?utf-8?B?eVQzWVlUVk1KYm1EdERZZEhubVdYeWZiUjFzSjVuU2hLRnpDb09lZkcxdG9p?=
 =?utf-8?B?MzNnWlI0bDJGSHVNZVlCUEgvZ2pXc3ZkMHNjZmMzVlQ3cm5CcERVV3BlUUdx?=
 =?utf-8?B?TEZHN0FMNmR2UjJ6ejRSWWh3ZTh5UVhCbWRIS3BzaXV5YllLUXg1OHpVUTcz?=
 =?utf-8?B?dGh4bnJNTGVzbXUyeHRQYXV4RWFxbFZha0hsbXF0ZTFKS1E4NllnNTlwWUU0?=
 =?utf-8?B?N3lNK3Y5c1VoQnN5S2ZxTmxsanlYNTRYY1lLR3NzQ2doYUxpV2xMK202aC93?=
 =?utf-8?B?VkJ4SDd1NGZTbGdjY1MrcUxvaytlYzd0RFEvUmsrZHVsalFkZnhMd2h3YXpt?=
 =?utf-8?B?YVdUZlFHdlgzTm1aNkJDT0VwdFpvdUVQNjFwMVNwQkwrRUp0eDgrb3R0V1gw?=
 =?utf-8?B?REo3VUhJSVZnSUJDTk80VlpLL2d0SUltdUI1Vk9ORHFBc09xVG9uQ0NCUUkw?=
 =?utf-8?B?UW1SYWphbWl2ck5Ob2Q1U00yUFMvMEdES1NVZGhVTUYxbklvbHRqTlRwYktn?=
 =?utf-8?B?ZUErbllmWVJRU08zTFIxQW03TExoYzBYVEZOQmxuei9ZSXdvVmJHVFdyUDVF?=
 =?utf-8?B?QUErcWdWbmdGd0VqeERMN3ZuVjFTV0wxTG9XbmlHRVRrSk1WN2dPU0h1NkQy?=
 =?utf-8?B?d09CQm5BWUVKWDFEb3RMZkUveFdlVXlnNER5anBXR0FJaDFWT3YxdmRET1NN?=
 =?utf-8?B?bWQvRUYwTytRY0E4ZTc2WE5oTDlMSlZTSzRxWFUwS0wyZWVxQVpzSFJkZlVE?=
 =?utf-8?B?cDcwcWpsenBpc1QrM0g2Y3ptODVhZ2hYVEwrV1hvNXFqS0dBTWc0MXg1cUMv?=
 =?utf-8?B?U29NRFViWnF5Tm5IMkZrbWNidmZ3T01CUGtBNi80MlRRSkZHeVVpNjhWUERm?=
 =?utf-8?B?WWNDbjF3MTVucFhXZlFEUlY3aU85OThUenBQejVDdHFUVi93bG1LMTZHbnVT?=
 =?utf-8?B?R1RrTDBXQU5LNnc1cCtmYWd0ZFNJd0JXYkFBQkgyRzlzV3VrRVNXeGozSEcv?=
 =?utf-8?B?djg2WVEzQ004aS9OOVE0YURvN1lqQ1RDOGVacXh5VU9NRHFRdTJxeklIVXVq?=
 =?utf-8?B?NHpWOFZVQm5IeXBxTGI0bHJLZWhHQkh4bm1SdkQ3RUdXNVJNejlBK1Z4QjFw?=
 =?utf-8?B?bDErZTlpeFEyV0ZrYzBqSmgzRzNKOEtJMTFPcFEvOWlOOGU5QXE4Zm5BWFlT?=
 =?utf-8?B?ZGZOUDhmakVlOGUzdWxCV1RxSERObFMyMWE2SHFTTm9sVnZzaWRpdFpPeTFX?=
 =?utf-8?B?eEYxRDNWYzN1Qm5keHVsd3FXcWVGMFd6bmJvSm9CS09nNEJSajNHVmtPSks3?=
 =?utf-8?B?WldycFd0ZGlnVDNBRnRDK2NoZ2pxRy9ZaTdRYk9aVzg4Sk5QblAwcFpYeEhz?=
 =?utf-8?B?eE9uNTN4dXQ0T012ZDRkSlhYNUhSeTdINCtvYTU3NXoxUVhrYk9XbUxOb29L?=
 =?utf-8?Q?qEpnIQJXwPnJ8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2IwSGZTR2NCdjVlS3ljbitYenc1cTdoWFRrSStYRzIrUEhsYlp6RU9wNU1y?=
 =?utf-8?B?MjUra1lJd0kwZjZ1NjljRTBjRUtLZWZmMUZRcmVEUExqNkJ2cmxaUzZETkR2?=
 =?utf-8?B?MVV6MjZSdW5pWmd5c1ZCeElUd2tZa0pzQmxrUmtNMENLenQ1WS9mQUt2cWtq?=
 =?utf-8?B?SU9sY1JnbHI5Mi9LWUt6eTVhZElvWEg0Tllnd3Urc3pmcnd5YmdqTzROQjFV?=
 =?utf-8?B?V05aVXV4VEhCQ0VzZ2VMVENGL2pPVzlVbFF4M0xBRUZyY3VTU0RlMXR5V2ZN?=
 =?utf-8?B?eWh2ZDV1akpycHVVWDg5S3NYUTZWNnZObHpCMzRDMkQ2dWNUTVlMRFJKVUth?=
 =?utf-8?B?UHNBUHJxVkd5T1VOWVYyM2lyQVlnQWF3cmxhakZSY2ZMcnUwVytnMUhCS0NB?=
 =?utf-8?B?ZlpUOFpSbUxqeU9kYytiZHdIdTVxTXR1RlYyd1lqYUlhbDgvbGJpOTRBcEND?=
 =?utf-8?B?SWVDVDJia3c1WFI4NjJUSG85UWVrTTZ5OENyQmY4eUFtalAwYW0yR0VUaWc3?=
 =?utf-8?B?NkN2TVVjbFRGZ3J6V1pnV1VtQzc2RzcvK2FqT2hDdXJMUUNxVG0zcUtpQ2Ir?=
 =?utf-8?B?T0dJWFJRK2I3VzB5VkMvRzlkWFNLVGNESUNnaVpoMS9aUkFtTWRDYjIvWUdV?=
 =?utf-8?B?VHBsUkJ1bXYrcDFuOFNEdGdVTm50ZXQxRGZ0OVlUMlJBc2U0WHBFTWxjNm0w?=
 =?utf-8?B?eHRFRXpZRFZaOC9NWDB2M1JwNkt3ZTNZc1RhOTNYTlJNYTU0ZW5aWDRmUDFq?=
 =?utf-8?B?SWc4ajJlcXFERHNwM2drVnpNZ1B5SFVXQUd4M3NPdVl3bE1rTUc3a1pLUXRs?=
 =?utf-8?B?TEFYUWFMd2tEOEltekJnUVRNSlJURVJ6OGdKNCt3M2QwUEh1ckdoaU10N1FF?=
 =?utf-8?B?Njgzd0pyQTNRSXVLTS94N3JGS3BjNjFQcm4rbU1mUGRLdXd6QTFOWDFVdjB2?=
 =?utf-8?B?OGQ4VXlYN0diMHlJeDRPL0ZDTkRnaDRDdm5BSnZjUGFKeXhFRkw5UC9XeGJj?=
 =?utf-8?B?TkN0WG9TSitkWTU1c2VJQXhEMFZ6QS94d1FYQnZEcnluekJUWUhZN3l6Z1Vz?=
 =?utf-8?B?SW5RdEVlRzF3VnJmd1YwelIvZjNVbWVFaWg1dUFTNjdrWE56bHJ3RmdhNlR6?=
 =?utf-8?B?cWNzTmxvUTdpRmNLSXc2b2Rod1lrTDBnTEdndm40WWhSRjhsV0JYUzVValNM?=
 =?utf-8?B?MUFJZzN4UGRXTUJFVWtWSGdHYnkxY2haNmpVZDZ5NmhqNlNoUTV1Yjhqb0pU?=
 =?utf-8?B?NCttdFBhZk0vMEVuaDZmMzgwNG5OZEhrR2UrMTdvdDdVWkNWMGREOWh3bjRO?=
 =?utf-8?B?eEFCV0x0Q2JDUHVQYUZvSyt2b3NaSzgyaG8rS0NKTEI4Z24yMFJ2RmQwZE5J?=
 =?utf-8?B?V0lpV0tneUlWZVdWUnFDT0FEM3hDeFR2ZjlEclZNYk1Da0d1M0tkM2lEUG9u?=
 =?utf-8?B?OGgzMnhENEF3Qjc5cDZ4SndNa2trK3dQM2lYR3RURFhZY2VqK0VyR1lzbzNX?=
 =?utf-8?B?ZzY2UFRia1Z0elpZUGJaQytXbDUrNG5zSUhpRUovaG5PcVJBQWdvaDF0V082?=
 =?utf-8?B?Qm1IWjNHRVhIM3hLZFNNR0xWVlorU1dsd0tvY2tQTE55OGpPY1E3RFRKUmE0?=
 =?utf-8?B?Zm1kSVBMNkxUUlJqMTdxd0VhSkNUOHlOT0pmclNwWDVuL3IwdTVmSTNsT2h3?=
 =?utf-8?B?dmI4a0NOYWJGSVp3TmpWSy9vYTRXZnhkSlVBNmRnWE1rMVNSRm5mUng2ODZK?=
 =?utf-8?B?OU1JNDZXZzViamM2QVlINy9vV0s5cGhzdWUwaUR3QmQxempWZW40R0JYajhV?=
 =?utf-8?B?amcvelV3WUwxa1JwNHhYRkhjOTN1ZlZndFNvOTFOdnBNUVBTM3NSbWNrcVY3?=
 =?utf-8?B?NUhQVWZFTlVyald6TmExWHl0WVc4bGJCVkw2WGdYY0hEMDM1YWozRUZ4eGpr?=
 =?utf-8?B?cUZ0dG04ZGdUanU0WWk4USt3OFh1YXNlMWdMZWFqNVlpbzhuRnVtTjQvd3Ja?=
 =?utf-8?B?VDBqR0lEMUhHQVRUQm5vTzlURW9vT3ozNGRCa2U3VVJ1VVg4d3A4ZjF3NFZF?=
 =?utf-8?B?ODYxQ2NjUXM4NWZRcXdMbjk3blVZblNtSEtrdldqZ1hhbnNselJsQURhWG5U?=
 =?utf-8?Q?JmeN14Lo+Q+CmqmjCE8X3uNF/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	glogMiyPTxH2TAd+gey/c2qhNXunsBY0raf6cHw1pebMkrwypqrUQNqJyPahoiBWneBCwvxsduLBKfAFAPqk/X+yKz2NTtXnbvQgNrPqdCOvG9goa3BpuDSrnkHFn5ZR127bUPiN0qEJjZMWa/syBbQ/n4mHh/UhZWMAIMzxK2kEZXGGeAVkU32veRPHuF7322e+OiXydq5/0m9DIpkFpSxO3ihvbEBAC76Ql5lT9UMCWfRa5ubl3MsDqIQLzTE/M3UDePj3hDx7MbN1bLEFcpC0ntUISnJglFv0aHYygiTUPEQrpx0xLc4bEepQ/0b/vgwYCfmLj7PqQcypicVsFrSlPsflOB2SiFSHttpGyihOECQbG6/JPVTOAXpdBT/X/0NaQ7m4oWZB2p3Qbo6xnM1YrXnj8h6NLUhz36kRgZ+8BUN6CsM7TbsV4gYf6KTqaBhpLCuIHuPrUITys/j2rC4y2rqeJQOfRdpcwA8ZQIajshP8Y4yypvYhDWS63lxc9RUogtlQlpFZj1viRWX4ax3KIZjFwI9y9Py8OEK0clMgZhTsuykwkllkxhNPK7tJq6TWP9ivjE2jPzwi6IRMr50y4BnSxgEBkv2OPBKRza3LC06+lE8u7m8pHCsyGm2e
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: be409d70-9579-4506-956f-08dcccdf8e46
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 12:46:11.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppK3VsoI000SnsUFGqYN71SDhMkLF4hSjezRgr6I6GBNW9J60is5SddMv9Qg3YQBfhJVzvFj1EdRotLEcNk6dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9866

On 2024-09-04 01:52, Naman Gulati wrote:
> Thanks all for the comments and apologies for the delay in replying.
> Stan and Joe I’ve addressed some of the common concerns below.
> 
> On Thu, Aug 29, 2024 at 3:40 AM Joe Damato <jdamato@fastly.com> wrote:
>>
>> On Wed, Aug 28, 2024 at 06:10:11PM +0000, Naman Gulati wrote:
>>> NAPI busypolling in ep_busy_loop loops on napi_poll and checks for new
>>> epoll events after every napi poll. Checking just for epoll events in a
>>> tight loop in the kernel context delivers latency gains to applications
>>> that are not interested in napi busypolling with epoll.
>>>
>>> This patch adds an option to loop just for new events inside
>>> ep_busy_loop, guarded by the EPIOCSPARAMS ioctl that controls epoll napi
>>> busypolling.
>>
>> This makes an API change, so I think that linux-api@vger.kernel.org
>> needs to be CC'd ?
>>
>>> A comparison with neper tcp_rr shows that busylooping for events in
>>> epoll_wait boosted throughput by ~3-7% and reduced median latency by
>>> ~10%.
>>>
>>> To demonstrate the latency and throughput improvements, a comparison was
>>> made of neper tcp_rr running with:
>>>      1. (baseline) No busylooping
>>
>> Is there NAPI-based steering to threads via SO_INCOMING_NAPI_ID in
>> this case? More details, please, on locality. If there is no
>> NAPI-based flow steering in this case, perhaps the improvements you
>> are seeing are a result of both syscall overhead avoidance and data
>> locality?
>>
> 
> The benchmarks were run with no NAPI steering.
> 
> Regarding syscall overhead, I reproduced the above experiment with
> mitigations=off
> and found similar results as above. Pointing to the fact that the
> above gains are
> materialized from more than just avoiding syscall overhead.

I suppose the natural follow-up questions are:

1) Where do the gains come from? and

2) Would they materialize with a realistic application?

System calls have some overhead even with mitigations=off. In fact I 
understand on modern CPUs security mitigations are not that expensive to 
begin with? In a micro-benchmark that does nothing else but bouncing 
packets back and forth, this overhead might look more significant than 
in a realistic application?

It seems your change does not eliminate any processing from each 
packet's path, but instead eliminates processing in between packet 
arrivals? This might lead to a small latency improvement, which might 
turn into a small throughput improvement in these micro-benchmarks, but 
that might quickly evaporate when an application has actual work to do 
in between packet arrivals.

It would be good to know a little more about your experiments. You are 
referring to 5 threads, but does that mean 5 cores were busy on both 
client and server during the experiment? Which of client or server is 
the bottleneck? In your baseline experiment, are all 5 server cores 
busy? How many RX queues are in play and how is interrupt routing 
configured?

Thanks,
Martin



