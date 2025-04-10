Return-Path: <netdev+bounces-181420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4E4A84E51
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0FC17FF3E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 20:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8E22900BB;
	Thu, 10 Apr 2025 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wtiMPNU0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DC1E9B1C;
	Thu, 10 Apr 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317649; cv=fail; b=mMF8Gkl7i4FCfM3RnLz9SlO+ziSwxPMjyMxuVpUIRluCrZOx0pjglo2Axky2kSiB/VLICyM/unk3Fv7RxkXxuc0Q5gpGvr/uPX/vXY7/9nIYRjPak1mRgn9yAFWnxp5s8G40KKCM2p6DxGiLqT8MVrYYWSd0YYbH8RVzqVUHuhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317649; c=relaxed/simple;
	bh=Qaoh8aI8uX4h+YAqKeS+ED/QdyZ58HcjJhgPsNN7uB8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NRQV8yrtZF3O6opwG+Ehb8jlIpNiXv2rjJtMPLneuX3rKGTNLGyrDpnX8G2HqexbKe41A3YL7q2uC4oPm34cAAaQduxSvOv1+bpDVcJJA8U8TaxJadLpYnNBc3+OyEk7B9tmLrG0YmlDoh1rpPHduNm3I97Z85/paUIB7fYPXFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wtiMPNU0; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrXO15j7eArAovotn0HCjRzEHLxcKhsHugWfgWMSmI1F5Ia/Oqw2yHVhKYV+1ekNRQI9+HzqnPt2IaivgZlOVRFrudQVd/h12XN3twBr+uhc5l8mA4VD/gKYKulfMB1AiN/vlsNPYYqvkjjNr14i2gTMGk28MILctMuVJhzEjYgsIACJ2zUhZc8f657WEoKHf9Xf11vDHwEGSKxYEOmVh0+Vo3UEsEtbW4BZWtNnOh1FFvFKTkYQ0q4R6fgMOGz42IUu3YqhX6bHwyTYpj7YP1X0bPlLo5YXRjDHvlQRg17YZ8PWW4qa9KKrB0bOp4clx3mc+yOIzFYIOcFlITz5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxqPuSUv6BNjmKYeyh+iBHVz24NyAdepX0HgXw48HBY=;
 b=GXyOO5JYo8hYHonS4FnOucxkB26EPUWKo1q5ofvB26WEDjK2kOzTZb8C/9uF1bJUZjD+G3b8/daZMLU1TRef4ofqpImM66z+psXT2p6c7sDMCynOd0jISw9H4nbePRzoUdqTb0RFFfi/NtZ15Or1G0asXu0xMNfFaLfMDJYJF9ApA2dI2iC6L7JD9Tomeyq5PUdmlvbxJnXb7qKBa8vtryUIVB7xJStPTrYPikgSO2dGv//Wb8LLX4fhBpdsHlHZgfwxHD4hg9iIf7wTcbkd0WVgN9pEKCEFMAQGa+ahEbg/TvTT4fFLWii4p1cfdqAMAe1EwyAo2AKDBSGXhslSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxqPuSUv6BNjmKYeyh+iBHVz24NyAdepX0HgXw48HBY=;
 b=wtiMPNU0MYipSgIyohIsDOW9cvgQivcnhg/mq7xODjemtHXvFSwainO6vvnBcwTl9BaZipmnDzjHR71GVO8Aa7iWcLoILFEVeZvDavSUEvcol7DZ3CIKI1T56YEkZuHopacGfG2GTBry4JPJULwlapjuLQx7hLzhxH3FOhEAe1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 20:40:44 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 20:40:44 +0000
Message-ID: <16bc3288-ede5-4777-aac4-60426aef1321@amd.com>
Date: Thu, 10 Apr 2025 13:40:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipconfig: replace strncpy with strscpy_pad
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20250408185759.5088-1-pranav.tyagi03@gmail.com>
 <1168af15-14dd-4eef-b1d7-c04de4781ea7@amd.com>
 <CAH4c4jKm9ewfL3G7SAGokzGT3VpLaKWQrbrxcLAnb-G8_MUjSA@mail.gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <CAH4c4jKm9ewfL3G7SAGokzGT3VpLaKWQrbrxcLAnb-G8_MUjSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: ac08d70d-7abb-4acb-2131-08dd786ff757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnBuL0ZpKzNGL1dNaHlrbU43RmZ5QUI0OWk0ZVlqZ2hlVGIwMGVtQzVXK01V?=
 =?utf-8?B?dWdRYWQ1eEM3aUxMK0ExWFYwc2JiaFMxNGdQczdCL2JaNkNucXpRMUhzbzFQ?=
 =?utf-8?B?Q1V2WHNrenZNM3FvTzE3blk0eWZ5SG4xYnRkU3RxWGlmWllGL0M4SDM5Q29l?=
 =?utf-8?B?U2NQNWdhSXdTbUtMQ1BEYUw0SjBEVnFWaU9iRHJZQVdyTnRLM0had1JkSDlm?=
 =?utf-8?B?U0hJOVFwUHQrMlBXcnUxWnprc2JmNy9GUTBwWTg4dWZqajJCZE5ESTgxQVZS?=
 =?utf-8?B?WTFwUEh5UkYwOTFYSURCV2NWb0cxZmxJankwazVEaFRmaGhuS1BCK044bTBl?=
 =?utf-8?B?Y1N6VHhybmdwQTVuTEJBMWszbHVWVGphdnJ5R3dDRzdxWkQ0TFBWeGZUOUdE?=
 =?utf-8?B?Mm5aVUp0ditvWUJNd21CQ0taNE41TEExUkp0aDh2N3pYWFFGemlJOU13SnJv?=
 =?utf-8?B?czFVQzY4ZmRpTWxUcGVPd25vZU5IUjNhaXRFekNXYXFYTGZZY1ZrbFNQaVZk?=
 =?utf-8?B?TkFoTkNmTFNycVBsMm53aVJYZjBVenl1d25aNEpvUWpVWUpyekR4UzRteWhi?=
 =?utf-8?B?Z2tqK0pWWm0zNlloRmx5LzYyK0g5bldyOWFSWVJmdGVSWWxjT3hkbHJLMHFq?=
 =?utf-8?B?b1IweGsrdGxmdFZaYjZYcEgxb3REa3RSYjZ3TlpJckVEeXNURnIxUzZ4YnRp?=
 =?utf-8?B?WDRwK2RYbnljUDk1bnlLMjdzUDJ4WXJteDU0TU9TRk9tVDh4dnQ5M3k3VTBy?=
 =?utf-8?B?UXFzNnhEWVFSZk9DY0twUWxMbGtscWpXSUNrb29YRERRQ1lqSDVpeDRhTWVs?=
 =?utf-8?B?ZE9JT1Z0RFhzZ3FzVm1vb28vMTN0VjJNd1hNZDlUNnlmT040M1pWOXlQemVn?=
 =?utf-8?B?a0FkcTB2SHJsOFY2UXdpNk1GbjBUemVOVlR1RXhNZUdQWEpTdnRRc3ZsM0xU?=
 =?utf-8?B?Qm94SUJkVEZMdUtyQXk1UjdvYVVxazJLTy9QTWVZNUI3ZVVqeDFjWHhGNVhH?=
 =?utf-8?B?SmF5TnlHeEVza09GRHF2eVBWSXdLb3VNaHpBZ3BxcmNPWFcxQ0hUT1gzYUhY?=
 =?utf-8?B?NEFDZEJpK2VNWXRYbnVpL0VPaFNueU5rS3VWa0xzQWxDUDI5cFV6Yld0b2dD?=
 =?utf-8?B?QzNEVkpFRkFWdkEwOHp4c1lBZ2lGcjBsaU9SVjBRdGI3UTJXdlZpTXM1Q0Vo?=
 =?utf-8?B?TVJ5QkE5eTZyMnpZUXE0ZmVYY2xLMGM4Mi9Ta3d1Ri9uMWd6TWtVZGxoaGdo?=
 =?utf-8?B?NlFsdUlnUFNrZG80OUc2aXJzdjJBbWx6ODNvNVhqV1FNcUV6K2UwSlpUSlpT?=
 =?utf-8?B?MWlqOXNESEQrWFpLc1p4TkVBcm9SeGxZVi9YeTN3QmRVb3FJWncyaFZkM0hv?=
 =?utf-8?B?aTVWS2pSY1dyMS9IeE11MlRxS0RWQ3JtellPbFNtNHFBVHJNSFU3aDlxSmhp?=
 =?utf-8?B?ZlN1Um9uZ0pVMG9KMVV5WU5WeFVibEkrQUVIMkVicXM4Nm11ZThxYmJkS3Fr?=
 =?utf-8?B?N3FzMVVHYm1tNWtIUnREcmZUQVQzUlBIM3BiTHFySVp6T0YzY3ZZZ2hjZGUw?=
 =?utf-8?B?bGU2bXZDYTBxYlE5UFRzc0NHQ1dGRHljcUswZHRNRFlScEh2c0VyOEo0aWZ3?=
 =?utf-8?B?MGtrVHNqK2dlRDVVSWZnRFJPaXRnRHgyOUFEZ3Zpb3ZtZnBvOVRmeTBaMFFV?=
 =?utf-8?B?ckhET2JHMnhDMHZTYUx4eVpkb1BOaHpIM1BJU2tnVS8yaU9KajVkZERtRXJV?=
 =?utf-8?B?ZTNqUG5lV2pyRGhGb2JXY2ozVVBFbElYcS9NZEd2MkZvWFg2RGQ4Z05uWUht?=
 =?utf-8?B?UjcvYUtObVduTDc1NzdiTG52T1hNQU5mcjZqTVJKTTFwL0NyUG5ndWNCY0Rn?=
 =?utf-8?B?L3pzZFBXWkRHK0ZJUEtra09kZVQvaUhSRDhJelM3SGV5UCtQc3BDUTNEWlBy?=
 =?utf-8?Q?qtJYIAktAA8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHNLRlo3TUxqMnA4TExLb0hLWGVoUFZZSER0NUJvdnM4ZHhLWnMzNnlwWkFy?=
 =?utf-8?B?Q05TL0hOTWRGNWpTcEFTMFVJZXVoaWcyVlBhRkYvQVI5cXpWZ1NiL3N1N2Ez?=
 =?utf-8?B?THprNEdaaTczWGo4bjNlOWNMWHpkbzh4aDVUcjlMSVRJaW5PM0s4MkY5ZFNw?=
 =?utf-8?B?UkxjK1hHZWlkUjdDUFNGY0NFR2lNZ1dhWThzcjQ0MG9JdTg4bmxJRmE4d3pX?=
 =?utf-8?B?NmEydGhBYXV1ekk5alhpdHY5dUpENkx0eXQwSDYzRHJ3NklPb3ZpK0M5TFRL?=
 =?utf-8?B?WlZMcW1HUHBnQS9TY0dCSWxieWhVVmt3cHVFa3dHRUpYUVptZTBqcVYxaThJ?=
 =?utf-8?B?UHRpYXgyOHJpcWtLeUNWQ3VUNXpDMFFzcFYwWm80c280Q2Y0UnJkbERDWTVW?=
 =?utf-8?B?V0hvY2svUUpMMHFQOUxWa2FObUtjK2pHWHloQmxMZ3M0WHpRN2E0WEY0MWNH?=
 =?utf-8?B?QjR4aGg4QVo4Z1ptWXVtZ2FRcFNrYWdueUhkcTcvN3doWEJTa0RQbC8rVXNa?=
 =?utf-8?B?QmVUYkM1cmJUK1ZoNStKRU9PKzFHUWZxaUUwbGVscU5DUWlmN1VTMGEySVBE?=
 =?utf-8?B?T0tHa1I4bzFONWwrZjVJUFNSejVSUnlnWFJBaTgxVlR3NU1kZENKeS9jak15?=
 =?utf-8?B?MGlva2VCc2dyQnZuT0syVEUvdW1ieVBwWVhTcHhRNlVFUU5KY2dHRW9HWCtN?=
 =?utf-8?B?ZncwQkNrOTZBOTVvSUhlOU44Vnp5OFpuVmkzUE9ZSUVLazRPclZucEFTOFlS?=
 =?utf-8?B?L2VNVVk2Um05TW90aSt4R1BDSHh1SVBJRmllb3h0bUlOYmd0UWdNczR6L1M2?=
 =?utf-8?B?YzdBdXMyK3d5QXVNV1JnbHBvS3M2bnhSYzlrU2IwbXB2Wk5BZStyTEkrcVNz?=
 =?utf-8?B?UWdLaklhcDkrQkRVUWk2UTV0aXQ2U3Mzb0d2bXdxUkFEUmpwK29KVnlwSkVk?=
 =?utf-8?B?cDBydmE3T051aGlXTSsxVU14cWR1QkVSNUY3d2lhK2Q1OVNMbnhSc3hTdUZO?=
 =?utf-8?B?cHdaUzhicTE5ZGtmSk5IZE1DSmNMNTdmVkhwR2hHTlBLMjlTVUFxVnZBT29w?=
 =?utf-8?B?dDkrWC8wT1E0VTI3U2JFeEZCWFo1b1V5TXdjT2ZkbnltdER3NGJXT1lFU1Z2?=
 =?utf-8?B?TkNLQnhPMUxZcFlmK1VQeDNkZy9FTlJtaWFPNFJOT1M1dHFOcjEvUVY2NWFy?=
 =?utf-8?B?M2oxNGFwc01lTGtQUEgxQVVaVTMvRDZIUy9xS0s1dXh6TTNGSkt2S3F6V0Na?=
 =?utf-8?B?d04wQklWQjNydHIyZWJHTTRtQW9qU0Zhc3BLT1dkbTdVMkhqakYyTElaTGpz?=
 =?utf-8?B?eEQ1VmlYNWREMW1iTXcyN0lTQUozTFJHcFh0dnQ5SmtORE8raXN5aFR5TWs4?=
 =?utf-8?B?eiszSHUyY2ZNSnQzQmxRY0hIMnhqS2FUSUV1TnJJcEN2MWZFTndpeGEyb2N1?=
 =?utf-8?B?bG5kNTFBbnlvNkwzWW1aeVRPdEJKYmZVd3lNd2M1c29UNTIzL3VtNWE2MUpt?=
 =?utf-8?B?bXEzR0xLd1p6VXlqOXl4dmRsM0hsL3lrTzNCMTh2NzV3aFVieG81OUJHdDl4?=
 =?utf-8?B?bHcwTGUxQjBGdnZpeXlQY1F2UFlWZHRXdTNlYXpSc3lGQUpqMC85ZXdxblln?=
 =?utf-8?B?U0hQMlB4TVg2MjVnMWxaN083NUE1Uy9DaFY0TmxjeGEzQVA1TWRORjJlUUlr?=
 =?utf-8?B?WW9URytadGJ3dEJta245L2ExRXJ0UytIbkJKVXJsN0NKRDVoWVhNendUK1hn?=
 =?utf-8?B?Tk9STCtDTzFMNGhZbVhPZXhrZU5TRW9QUU5ENzlpMG5qV1ZDVzB4Z05OR21C?=
 =?utf-8?B?UWwyNk15ZUpsYXR0VkpCWWo1WmRqTEsrbTRjalNZQ3N6SWswMFV4a2x4N2lm?=
 =?utf-8?B?SFFncHFGNzh5Mno5WXlUb1I1R3M2bTdESWFUTzZOTE15VU9nMmhCakZWa3cv?=
 =?utf-8?B?Z2RJdUNiOWRiN004NThzalV5bGswTkRKSUpoL1dkQ0QyLzFBR21QNU5iNm5B?=
 =?utf-8?B?ZDJ6RUIwV2FOekJVQitMY1BBaGxzV25aMldJZFdYRmlhZk9wTWhpOGF3d3Aw?=
 =?utf-8?B?cHRNRnFKMzJ5RnI1dHZGd2ZHWSthbEdaZ2Zya01ZZ1lHZjg2QTJaakFyclRl?=
 =?utf-8?Q?ux02lOMUjW7/J5A+ivDC9KTgv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac08d70d-7abb-4acb-2131-08dd786ff757
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 20:40:44.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgn/Uk/6/25W+XB6n0KtFmsjsJ3N8nfnaQHH4Oh9swOKYP76xR6lJaunx/qd/efhztPL5rLSaAsID1I0os+bFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728

On 4/10/2025 12:59 PM, Pranav Tyagi wrote:
> 
> On Wed, Apr 9, 2025 at 3:14 AM Nelson, Shannon <shannon.nelson@amd.com> wrote:
>>
>> On 4/8/2025 11:57 AM, Pranav Tyagi wrote:
>>>
>>> Replace the deprecated strncpy() function with strscpy_pad() as the
>>> destination buffer is NUL-terminated and requires
>>> trailing NUL-padding
>>>
>>> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
>>
>> There should be a Fixes tag here, and usually we put the 'net' tree
>> indicator inside the tag, like this: [PATCH net]
>>
>>
>>> ---
>>>    net/ipv4/ipconfig.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
>>> index c56b6fe6f0d7..7c238d19328f 100644
>>> --- a/net/ipv4/ipconfig.c
>>> +++ b/net/ipv4/ipconfig.c
>>> @@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
>>>                           *v = 0;
>>>                           if (kstrtou8(client_id, 0, dhcp_client_identifier))
>>>                                   pr_debug("DHCP: Invalid client identifier type\n");
>>> -                       strncpy(dhcp_client_identifier + 1, v + 1, 251);
>>> +                       strscpy_pad(dhcp_client_identifier + 1, v + 1, 251);
>>
>> The strncpy() action, as well as the memcpy() into
>> dhcp_client_identifier elsewhere, are not padding to the end, so I think
>> this only needs to be null-terminated, not fully padded.  If full
>> padding is needed, please let us know why.
>>
>> sln
>>
>>>                           *v = ',';
>>>                   }
>>>                   return 1;
>>> --
>>> 2.49.0
>>>
>>>
>>
> 
> My initial assumption was on the fact that dhcp_client_identifier
> is directly used in DHCP packet construction
> and may be parsed byte-wise. But on going through the code again
> I see that it does not require to be fully padded.
> Would strscpy() suffice? as it ensures null-termination and
> does not fully pad the buffer.

Yes, strscpy() should work.
sln


> 
> Regards
> Pranav Tyagi


