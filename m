Return-Path: <netdev+bounces-168817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB9BA40EEF
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 13:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202FC3B6C0A
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615A71E505;
	Sun, 23 Feb 2025 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="biS+gtNB"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010011.outbound.protection.outlook.com [52.103.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6494C7D
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740313819; cv=fail; b=otVP0eWbhvxDiv+h6Qmds2FAS8nOyCET+bCG90xBB5vYdUUemLCA/NkwTaESAEUq4doSez95O0fJARx3rl7ok7EuOtcd/z+vJ2JDO9kYrjBM1IbelTmq6o4fTY9+o3W1G5IUWtX1gJXVS/HzpJ1iN6aoK6atMg6xV850h1YNUEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740313819; c=relaxed/simple;
	bh=xc/VPx4ijKc2MxnnnHrSlDwDWFK0uk7bba3xW239CBE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XbgYu4FLQDnlvhP2OOrLcAu6Q4z24J8ULmEyZxnercgN9tD8DxKOtbN22k+/WWWGvoKLQK8gJktmaDWAPeTAitLtcX5Rb+Z/efuR1EP+uRI/HLd1Z85uNrB+rpYp61CuwceKYLakPZufznlQr/jGFI4pqHyB7vjTFFxr1nsFAqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=biS+gtNB; arc=fail smtp.client-ip=52.103.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNtKn0gkgMTTWDkJPwha2sdeZvVBgAxo9+yDv1t3u6lLwP2CniTh7hjpaZhnxIKLc6sNh6fbHTVy/0Y+LHdoEGplUXV+v2KIhrpEc/lQl0vyDaHG3KK9uCcxr4njUM5IiFK8yua4uSmDGjUo5lG7Epxs22kinHZwyqTPKr+L40jdI8pitR25izdybeHIbI7fpuyVFoOR7tUUqMUx7sKwqCeP66yt6aRVORW4kRX0CmOi929YaJzqKoJgX1mAr7POtuasr7VrfOAaaxiYqVbtNwaeZu2OUB5i+fybCB3wTAd8g3ttRLhYlo0shwPH2BrPZtehMBLsK27QHwB14OXdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5WT42nzu6DWAGflR9mziHMtAH/amdKGKM0gHCfl3Ng=;
 b=M4DhhIQbPiZSl33vf5l4kJ+MzwR2RhysMh2ZewKL/G7dLEhCRTNPhyXn+malw2zuq7m7+47iFoF2uklM4ejDgYCLAJ+KX06CZcABYiX4Cp6fWs/FFhKz2vHnwvcVApe956jV2wHB6Cy4DN/caW0JwhViMy66pe/jMli6QCmjeijGCDZwBYNbnNL/1stAlsEYwI+f4egRaifTWavLAspWsainX4R5EYmS1bt+gK9KC3UPf2WX7n3o8jlmKBc2LKNLxYp1dJoL8L/MFrZ83M/fr+TiQD66eTKnkmnGO8elzqHcf2DkzizqNJ+Ce5hyhUNqNv+qNJ34wEHcOTptW3FHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5WT42nzu6DWAGflR9mziHMtAH/amdKGKM0gHCfl3Ng=;
 b=biS+gtNBizVm4NawT/AT7ms63CdP4XUKVYQF1nDpsMaL0z++W+KZgh+bz38OtcJ8Whrpac/woJUIsXOwrtI8whXL4cN5FAKcPTleme31l6gBThahVlKvx5BbQHpmg31yH/ip7IKVYO/aMHM0L64ApT4pTucwijzNu7fARlC5RMwWiJ8+XDJwl6GDy/YtyvaEq6DGt5dKluukIHgSsfjX2qW6iwzIxnJIkCNkFrMifGObR3yXAhwHqecCmdIg53JV5j3Y5JberafPZEWoZQKhzTxN+X7prJBSDBWl0C6rXF7fo79Rhg/INgEdv+sB84SKA4fK2SfTfZd6y54moympPA==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TY4PR01MB12959.jpnprd01.prod.outlook.com (2603:1096:405:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 12:30:13 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 12:30:13 +0000
Message-ID:
 <TYCPR01MB8437B8B1654ED6575F3019F498C12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Sun, 23 Feb 2025 20:29:59 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com
Subject: Re: Phy access methods for copper SFP+ disguised as SR
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, netdev@vger.kernel.org
References: <874j0kvqs3.fsf@miraculix.mork.no>
From: Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <874j0kvqs3.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::17) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <7b741b42-409c-4f0f-bca6-77e0093565d2@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TY4PR01MB12959:EE_
X-MS-Office365-Filtering-Correlation-Id: f70cb05d-f8c5-4f8e-3a44-08dd5405d23f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|6090799003|461199028|19110799003|5072599009|15080799006|7092599003|440099028|4302099013|3412199025|10035399004|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGhLbDgvaUE0MTNVSGJ2bFA5ZHZGOXZUNFdidnN5VDZjYjBBZWVkZERtK2V4?=
 =?utf-8?B?MXZsYThCSFhMRXFjTER4ME5XYlE4S2RldnBjMUtCcGcwZlVwdkRGbUFHYWRB?=
 =?utf-8?B?WmR0RWh2aXdWemtjUmo1NlZiRWdua3l4SkhnZFVvUmZYZHF2aHRXbXRxWTQ4?=
 =?utf-8?B?dDhFWlFTRjlzNmw3dXEzRHd6aXZ4YmJDRDJIRnpuUFlQaTlXeGIyQ0tlK0xo?=
 =?utf-8?B?OVJWYTRBbGpkNVZaTnF1R3ZEbjBBZVZodEJ3TitBaCtEdSswZExOTVhRdHh4?=
 =?utf-8?B?aXhEa3ljM0FsZ2s4cFVIc3NSa1BkeXZVOVMzUXJHY05Pc20zK3dOY2k3WnZV?=
 =?utf-8?B?NC9SSERpWGJOZGYxSjlqUWhEMUxJMGd2WnZETkREN0ptWFZIblowekgxTWdy?=
 =?utf-8?B?bThNWVgxMnZOdWhSbk03L2dqOE4xYWJ1cW9tQkZiZWtPbktLQUJtK0UrOHdp?=
 =?utf-8?B?Skt2dGNSNkpzdGJIS2ZKQU9uVXBWVEszMFM3aVhLb3J6ZjJQdUxzMTJWb0Zz?=
 =?utf-8?B?MlZ3NDZvSTJ2MkdsTXNVQ09TT1pZZkl3c2tzZzViNEwwY2pHWkZiTWtrN2Zk?=
 =?utf-8?B?Wm5tcEtTb3BicHVmQXN4TndPMTZIMlQ3T3hFSDVVbU1JcUxpN3BFeFVZTURY?=
 =?utf-8?B?LzRYTERVd3dxWVJIbTBrTkxzN1g5ODJKMTAvZ0dCdWoxV3ZYbjhsRThjcEho?=
 =?utf-8?B?dTM4YW02VnVlTVpNWGJ0OWU0V0hKK29pTkNld1VHMEEzMFFpSVUrTUJnY2VK?=
 =?utf-8?B?NUNZUEY1d3hDZ3dzNzU0bTV4M3cvRmpIT0NjaFIzOC9majVBcTRPbFdHaFV5?=
 =?utf-8?B?aktnczh4KzZBNWRhRUpRNm5NU29BbitlQXlZTUg3K1VyODM4bExzZzd3a2Fz?=
 =?utf-8?B?TG5pdk5CaHVYdDdHaXpPM000QkNmUU9MRHlydGYyNzA4UTVVSngxajNaSUho?=
 =?utf-8?B?SnAreE9YeVJvbGdBL2JIMnVVeTZuRHlpdVVkcm90azRxOENGcWxQZjJpSFlT?=
 =?utf-8?B?N2poSVlLNmFCb24zVThkNHc5ZmxQdHJjM051bE0rRDRoMmZyb3VKOUxXM1Zq?=
 =?utf-8?B?aUV5SE5qQmVhVDBVY2Q3Ull6U0twR1h4bTVZVGdTQS9HS3I3Z3dXelcrNWZq?=
 =?utf-8?B?N1pqaFFxTy9Pc0VIM2pDaUdGK3Z5TkNXZHg1MWxwUUZqUzFERmhBdElueEp3?=
 =?utf-8?B?Y2tueEZsOFVmOTNGNUd3K1lwa2xvbXVvZGRMWnA2elJ1K29WaFBNaXJOWWx0?=
 =?utf-8?B?SnQ2K005QkhqM0RCbGR1TTB0UVN2TkdBakRFekFSamxSSXZKdm9tZ3prNW1W?=
 =?utf-8?B?TVIyK0k3a2QycTFkRlBkOG96Z2FLditCMnV6RU12UFpNQmpGRCtsMGhCTEls?=
 =?utf-8?B?cUNhbVVBcnhCVXhxTVlwZU15WFVEMXFyRjdRb1BqTGlkRCsxMno2a0hqR0RK?=
 =?utf-8?B?bGY4UnVZblVFcFB3dy8vQjlDMVlmUHArNDh1Q1B2T3hWQ3Z5MzVZaFB3QWJs?=
 =?utf-8?B?akFkTGhjbzdPSGZmaWVkUjllMWlmNjVEVTZPNXNOTUZIQW5FQUdvd0gyUDNp?=
 =?utf-8?B?WUpvR2RVbU84dXo2aWY5ZTRwZHRvNkIwTTlGRFZUQ3dZbFhzMjNiZExmZUls?=
 =?utf-8?B?Z0FzZ3BnZkE1S3hIL0tadVZKL25WZ3hjWDlUZDdtSElCazY4TzA3aGRZM0NR?=
 =?utf-8?Q?SVURzYlArcobrne3MM22?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGc5dVFaK3dzM3d5UmdxRWd6c1VIVXNMUTd5Z29uZ1B0ZkRablBGRXExTnFr?=
 =?utf-8?B?QUdSU1Q2eFhSUnJnZkR2OWs4Yy9MeUQxc0l2SVE3OGtEU296T2ZyYmJzSnRX?=
 =?utf-8?B?b2pvcmxObDgxdHBoM05hMXI2RUN2SkxQWnpJckdWYlo1UWJFNVhBOGpBcVZ5?=
 =?utf-8?B?OXJaYkhvUnAzQzdYdmFtYjhvR1RMMi96cTJTNkV0cDhwN1VXSi84cDhIS2d1?=
 =?utf-8?B?MFBHZWs3bVRLQ1U5Nm9qcTExYnJXbEdmMzBja1FoNW5CSjMrdG5CdmRsWHBK?=
 =?utf-8?B?SXpUSFU0cEM5RXVscUkrVUl6TEo0TlpYK0NTd2FwaTBaSlZKbG9jd0NPTTBk?=
 =?utf-8?B?Yjk2N0pvN1FpL1BMN0hVYUN4UnZZdUNaYUxaeUNOSTcyRHFSQ043aVlCNTR3?=
 =?utf-8?B?clpwb1lFVFBqUFhyZzJuZ0RUSHB6eUlreGVxcTJRMkhGYUJ0MUQvSG0rZU5n?=
 =?utf-8?B?OUtYOHJManlIUVNrOWxjb2RXT3lxbGIvMFJmMmVPZlRYZ0xWUVVGNlVpcytV?=
 =?utf-8?B?ajAvM0V0eGxSQnc0U096QjZuQTF6aVJLaWhQRnR0SFBYTStoMVg4RzNmek05?=
 =?utf-8?B?My9qRXNxNVdPZTZzL25OSVRjaTd4S2FzNm9relZYS0VpT3hManRSMktXOGFj?=
 =?utf-8?B?TURyWis1UFg3R0p2TGtoNFBNMEhtSmoxWWJjQlF3dVF0UUY2MFlidEM2VTI5?=
 =?utf-8?B?bS90YjFhU0tOekFvQ2x4RHlTeUhGa25LKzkxZUxnYm1uVmJsQ2Z2RGpiZ2JR?=
 =?utf-8?B?YU9vczJGMVlLMEdJYzhtU0ZVMCs2M0RUVnF6Y2VyV2k1VzgrdlIveklwNFlr?=
 =?utf-8?B?ZDI1NGxnaWUvQ21Qb3pnQkhXa3ZKdWlCaHFrSmhxWU5SeS94TXZVTkdzRWoz?=
 =?utf-8?B?dzBab2JYQ1JGdG1TYllsblAzK2I2VWFDbEVRUk01TWIvQlhJRnU4U3gyY0Nk?=
 =?utf-8?B?bXhITUpIb0EvNi85ZTBScEZzTjN5YnRDcUxQSlpOekJSZHh3ek9KQ2g0RGpJ?=
 =?utf-8?B?cTJ1aEc5YURWVGc3WENLa1pXZXdwTHJUYTlpWFpjTG9RdDcveXJZQzFLQ0lx?=
 =?utf-8?B?NUFkeHVNRXpXenJSeFBDK1JHVTVpY0NvWVZSSWZLbHYvOFlPU0dORnMrVWk0?=
 =?utf-8?B?NVJYekpXYVFTMjQyQmRSWGhMa2I1Y0E4RWhJZXl6cVJHRjZoTVBVcUFKKzRs?=
 =?utf-8?B?aFBzeGRqN0FyMnppWG5rZUpVN2pPYnNqTlRtZGNpYVd6OTR2MDdvQ2xUanMz?=
 =?utf-8?B?dHdpcUh2Y1ptSFA5Z2NHQTJicUZrSlNnaTdnK1YwZjBUemRtMHNKck9iT3Zm?=
 =?utf-8?B?QzRhRVVHR29VM1paYnNGaGc3YnJmeU1nK1dWczBYTnJQTDhhK2J4RlFsMUpi?=
 =?utf-8?B?c0t3NnppM0ptN1lOemZnaGxhRWdtOVU4THQ1d001dC9XN3R1aVlSWTUwRnBs?=
 =?utf-8?B?TDVyakZ2dkRaRCtPUkZSUkwvOFpQVndDYzlwSzBlYWZpVzZKY1lTNlJuWHY1?=
 =?utf-8?B?eE8vaitGYXNmS1dMT2diK0lGMnFvaDRhT3c1Z1lYMStPWTlPVnM1R0xKSkhk?=
 =?utf-8?B?N0RjejB6ZERMQ3ltalg5RUk2VXdldEVYaVBnWXIxQTlCVnRQNTB2SDBEem8y?=
 =?utf-8?B?a2FpbnR1S1Rmait4Y1ZHZ0lDbzBhVld1RW1yNWtoRDhNcWgxeXVGUC9vVHdu?=
 =?utf-8?B?Q3FReGJNYVZDb2lIZWFTL0U0c3BpUEFGemJPVUlselBSaTBYQ2VsSlJ2Y09I?=
 =?utf-8?Q?+nLJ1GOOVWeETXERAg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70cb05d-f8c5-4f8e-3a44-08dd5405d23f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 12:30:13.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12959

Hi,

Maybe rollball protocol?
https://forum.banana-pi.org/t/sfp-oem-sfp-2-5g-t-kernel-phy/15872/

Best regards,
Shengyu


在 2025/2/23 19:34, BjÃ¸rn Mork 写道:
> Got myself a couple of cheap 10GBase-T SFP+s and am struggling to figure
> out how to talk to the phy.  The phy does not appear to be directly
> accessible on 0x56, and it does not respond using the Rollball protocol
> either.
> 
> Are there any other well known methods out there, or am I stuck with
> whatever SR emulation the SFP vendor implemented?
> 
> This is all it shows, and 0x56 just reads zeroes no matter what I do:
> 
> root@s508cl:~# i2cdetect -y 8
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:                         -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: 50 51 -- -- -- -- 56 -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> root@s508cl:~# i2cdump -y 8 0x50
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 03 04 07 10 00 00 00 00 00 00 00 06 67 00 00 00    ????.......?g...
> 10: 08 02 00 1e 4f 45 4d 20 20 20 20 20 20 20 20 20    ??.?OEM
> 20: 20 20 20 20 00 00 00 00 53 46 50 2d 31 30 47 2d        ....SFP-10G-
> 30: 54 38 20 20 20 20 20 20 41 20 20 20 00 00 00 0c    T8      A   ...?
> 40: 00 1a 00 00 46 32 35 30 31 31 34 54 30 30 31 30    .?..F250114T0010
> 50: 20 20 20 20 32 35 30 31 31 35 20 20 68 f0 03 eb        250115  h???
> 60: 00 00 11 6b e0 e7 c2 e1 ff ff 18 79 21 c8 24 ed    ..?k????..?y!?$?
> 70: d8 45 85 00 00 00 00 00 00 00 00 00 1c 24 98 22    ?E?.........?$?"
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> root@s508cl:~# i2cdump -y 8 0x51
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 50 00 f6 00 4b 00 fb 00 8c 9f 71 48 88 b8 75 30    P.?.K.?.??qH??u0
> 10: 1d 4c 01 f4 19 64 03 e8 2b d4 07 46 27 10 09 28    ?L???d??+??F'??(
> 20: 2b d4 02 85 27 10 03 2c 00 00 00 00 00 00 00 00    +???'??,........
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00    ....??......?...
> 50: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 7e    ?...?...?......~
> 60: 42 33 7f ca 0b b8 13 92 13 92 00 00 00 00 00 00    B3????????......
> 70: 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00    ..........@.....
> 80: 43 4f 55 49 41 38 4e 43 41 41 31 30 2d 32 34 31    COUIA8NCAA10-241
> 90: 35 2d 30 33 56 30 33 20 01 00 46 00 00 00 00 c6    5-03V03 ?.F....?
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa aa    ..............??
> c0: 53 46 50 2d 31 30 47 2d 53 52 20 20 20 20 20 20    SFP-10G-SR
> d0: 20 20 20 20 33 32 00 00 00 00 00 00 00 00 00 35        32.........5
> e0: 1e 28 2e 2e 31 34 29 36 00 00 00 00 00 00 00 00    ?(..14)6........
> f0: 00 00 00 00 00 66 00 00 ff ff ff ff ff ff 29 e3    .....f........)?
> root@s508cl:~# i2cdump -y 8 0x56
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 
> 
> Bjørn


