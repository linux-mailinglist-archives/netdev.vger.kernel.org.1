Return-Path: <netdev+bounces-210749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE7B14A92
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE560168594
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637FC285CAD;
	Tue, 29 Jul 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Mv49X6H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5202741DA;
	Tue, 29 Jul 2025 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779554; cv=fail; b=KuK/Uq7ty+aBKZwR9oZEGzzjchM6xGKHMsB0/9nOEPX2m9n+r36zRh9cL6oDRJkq52IsA3qRTJaSmV080f6EN6wubdLZovc+96ZzkkBwQhkAbcbBwCrOm15lueGTlzWgPc3JuWrtuRNTfU8tIbpBHaOfv99OViO+kxZ5Ci8z9WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779554; c=relaxed/simple;
	bh=dzh/mdjusjV7eHKj2bhN0iao9/TZ9+MOfgZpgCLG2eY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BBNAuyEixsGe88rMAqHgLODW+TQnbTarRuhcyQG4Hnnu2+b9eZbRJCQXtbAt9fkMZ6NzxB0PbvxRXS1eUdWhFGNty5l2e+5f3BC7ThXcX/5y7ZyfsU8J0N9PnhFrenTjTm+R1tD3PtW7LipGqrK7qbkQ4xrb4EZTVjmqmfHiZGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Mv49X6H; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMoVpzwVb6rGMSDBryrLrQAv/r7GZZIRL2JP5WvUQFpwli8vtRzBZ+ew0fDAyHyJT+KNlodhNCSdp4qspMji+F0xhlh1MplErxu/dFw+xR7V1AzKvl9xt+kHFPn6/eZxZVCyCb/K/6YISvJ0Xw5RDnmroUtmrkfdplkWhbI81OBtTWHFTjJtofnmQhRhi9W+zXqAJMdwfOpnGLlDEuNJxfY7UId0WmpVhH3Pw9L4kFlfFQ9ZcQmyZUYdwcnbnVsJ8PfIw3w2NwrF+4yMA3OQSR6CT3Ck6bqfCPsu4AuUCN+zRlciV+hM5KUmiHtaF3Exy9vMrK1gYHLNz63Ak0rkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poaBe5RXnJcAxTLjGH2lp/UxkFqLeihqTexsCukkQ2Q=;
 b=EAkM8hD5BB6Tnue6UVanqxH17HKzT1hXUBq+gNJ+fHdyY+khqoj7+knm0oiArgmmYWvd6FK/LDganxLsx7Bf3CSjbqmw/3NsFZToLcD1FodjlwB2fbl4SVsNcQhZiyBwxqHwLdfey1OBgrmPZYrW6K7Vp0/4fjku4hjBlBQTSgU9065G6bOzkcLzA2atvs6aWT2b+ATf6l22AnbTh5tfAd6wiW0h0LB3bYWs8mIHvf08VKh7noQ6ff9cvnMSmuHclWM3hbVxtGn3Qy7Np3f6tNZ6NFmjJ5oFgSQlCH2di34dlASbIfKqltcCynbXoHyToJKi68+ajhMIyRICcsaFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poaBe5RXnJcAxTLjGH2lp/UxkFqLeihqTexsCukkQ2Q=;
 b=4Mv49X6HECGdqGmF9pxQbXGYYBTndS4lopXIQ6Vh4hpj+2bU2gfDfD404lubKXBTJ2Ol/7K9VQZiINiCUB9Hkh/xzgH26kxAUsakqqgPhURSluzWx3APs6zLJ7fDXG5+Rqob3SPJgAq1DI28vHQcw4/X8M5U/ADhE2e+c+3JHDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by IA0PPFD78AA37BB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Tue, 29 Jul
 2025 08:59:08 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 08:59:07 +0000
Message-ID: <c296f03f-0146-4416-94ca-df262aa359d4@amd.com>
Date: Tue, 29 Jul 2025 14:29:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net: macb: Add IEEE 802.1Qbv TAPRIO REPLACE
 command offload support
To: claudiu.beznea@tuxon.dev, vineeth.karumanchi@amd.com,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-4-vineeth.karumanchi@amd.com>
 <64481774-9791-4453-ab81-e4f0c444a2a6@tuxon.dev>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <64481774-9791-4453-ab81-e4f0c444a2a6@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::12) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|IA0PPFD78AA37BB:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2daf42-b2c6-4336-a4d0-08ddce7e2d26
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk9ONGJVNG9QTWNNTExHVjQ4NVh1eExsL3B2K3FFV1B5Wi9rbFgxbCtZU1lm?=
 =?utf-8?B?V1lDUjFXS3VlVzFLZDFrSjE3THFZVERDcjZwaVJ3eDBSK1FZK080ZmZqaHpi?=
 =?utf-8?B?Q3BSd29MTm02WU4xYUJ0TnQwblhlNkJKb1Y5V2ZjeFh4TWZ1ZkRLMFFEMUh6?=
 =?utf-8?B?SGhRUDlwU1F5V1pPb3Z2UkJxRDIwdUlBVDBxdHpVaXBOTk4zNlNoN3hJWkZK?=
 =?utf-8?B?Yi9NQktocTRKa0xPYTlkamFqS1lvWnZrTmZzTGYzSlJpL3BLVGkxbmw4OS94?=
 =?utf-8?B?VmF6N21WczR0MHhrTHN0andZVm51WU9SQXpQU2dUZSswL0laVGZQM09aZEM0?=
 =?utf-8?B?c0VPc1NHMmZBYjNRQktCSi9jS25QS1RSNXcreVdKSjRiMENKN24wMDFOa1Nh?=
 =?utf-8?B?TEkyMnZiV1YyaHlIWGNtaXVnUTlXZm5DOVFxVGhNS2lMOXR4eFY2RmF2L0tI?=
 =?utf-8?B?V0hnOXQ2ZjdwVUlKRXg3MndXSmpQbGZVQ0pwRm05VXUvb1dlT1V0R0hUZHkz?=
 =?utf-8?B?dzljMk1CUUlFS0hpL2dQMDF0Z1l2SjJpcWE0NEl2NlNLL0xoODBudWhTU1hX?=
 =?utf-8?B?bXE5ZmE4MG9iOWF4TXZESzFhSFNleWNScnFFVy9lZm8yT01OWEdLaFY3bUJt?=
 =?utf-8?B?VXl5akJiRG1ZeXVJWVU1citpemwxNzQ1dDI5NHYwVm80QzlqdGd6WTlzenc4?=
 =?utf-8?B?NUFRb1I3NEhRcUt3azIraTZ0ZGdwcUlzLzVtUjdST2tETUdZSWdTbnlXRHVu?=
 =?utf-8?B?L3QweFYvcFlvMW9sR0JYdTNSbWRsRkNmcUFGaXRuMnpBUmdGY2EvUkhDZ2FP?=
 =?utf-8?B?a1ZsWDd5SWlhb2R6cUs3Vm9sdnhHMGV2WFR5Q1hUK0FWRlVvVUQ2TW83eStI?=
 =?utf-8?B?Q2duT1I0S0FhS1dtYnQwb3FuaGxOSEdMMy9PZ0l4QUdTRXZLNUJVRUI5MTlo?=
 =?utf-8?B?WFJkeXBpajFtWVZlVDdaVGdlN2JTdkNudW5wejFqQ3kyS1JneExQc0ZMZklD?=
 =?utf-8?B?Zm5OVGZIVkhiOHRhOWszRXRvQUxXOTZFTXRFTjBrRVkyZjByRmtJUlI5NFp2?=
 =?utf-8?B?clB1QXVyV3ZhSWZKR2JXWWszQVVGZ1NsdTFWS094aGRDNDUydGl4V1JQbkty?=
 =?utf-8?B?Y3ZDMXl6cjJCZkw4bnF4RG9RL1pQNjZxb0xWVWRCQ3Q4TlBpcDNXeFZnQVlK?=
 =?utf-8?B?azFHT1BZa1YrWndMZzRRVnBvd0tWbVlza2orY0hFbDhSZTJNUmNjWUtXRURT?=
 =?utf-8?B?enRlTml5NlU3MlRkUDRiK3dGNGx3S2tZdk1vK1RNVGNyeTlVcGtkQUFjR3JV?=
 =?utf-8?B?cGw0ZWh4QkpjRFk0V3NudE9VVjJ2eko4TnZJcVlMWFhWcGdUSThEaXBTV0tH?=
 =?utf-8?B?d2dzR3RsZlZick40QW5GY2MwUEtBdzd5UVZPc0p6UkE1VldaZnJWT1VDWXhB?=
 =?utf-8?B?dGxtNnhJR3ZIU1NVVWh6UWF6NUFXOTliT3VzNUNIRkdzYmJIbUxGY1BDQmlt?=
 =?utf-8?B?bmlsakZtQ2paNEwrbG9pUE1qOEZEN1Mzck1aek94cy9wWDBMUFRadTZIQ1lB?=
 =?utf-8?B?QTJ0bE8wQUJvdC9PUWtpcDNFNWFObWM2R2o0NXNZMnFLbnVla3QwN1EzOUlY?=
 =?utf-8?B?L0FGRzd3eldiZzJ0Y0xleHZIT0M3d1pLWFV5bTdWdGF1VFZ2WFVNL1hZRS9Q?=
 =?utf-8?B?RnJlZmd1cThBYis2b09TNUpTdmlSMlh4MFpseXdCMTFKSUwrQXppRm1PUGp1?=
 =?utf-8?B?czc2T2JLTGpxY3hUTXNpT3J1Q29JVmRsZlNaNllQdk5mQUJwSDNJLzZvK2hR?=
 =?utf-8?B?Mk5yZ1FEdDMxaFArWG8vYk1oeHJtdTRQZFRYZXNJSHQ3Ukxvd01PaTZyTTZj?=
 =?utf-8?B?a2MyY2JwcG5uamN1TDZQN0NoUjI5dVFiRC9nZzc1NmRxamY2ckJickRTTy9z?=
 =?utf-8?Q?lCISK3GsJRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M29WMEtKalZWVXlDUU1tZ0hFUkVyMG1JZy8rcGhGY0UrTUpHZ3FFS0dlTzl3?=
 =?utf-8?B?c3J6LzBwZDBZVm84aVkyc1JMbThEcHhsVGJOd3VndzZXU0R2VzlJTVc2d1Vv?=
 =?utf-8?B?Qk9pTDRrcWV2cVJSZkhvVmRqT0FWaSs5OUhYYUt6MVJMNWk5L25LNWJtSVRZ?=
 =?utf-8?B?eEYza1c0S2JQWHc0UkVuY1l4ZC93NnNYcjlRdzd5a1Y2ajYzbm9QSHozb2pE?=
 =?utf-8?B?TTVzNHF2RlpYaWg3LzlHbVBQRVBleUQvTUpseHpYbGtNZUtiNC9QYzhyTzZh?=
 =?utf-8?B?WWFWL29BWDVnZ1dVdU1FR25LRE1EdUVXMEdvamRzdlpPLzR6RkJvQk8wSng5?=
 =?utf-8?B?a2VnK2hpTldIZ3RSVVN0ZjB2cTVSbVdNTW0ySksrdE5qZXhJTFBtbUNTdWY1?=
 =?utf-8?B?dlExREE1TkZjQkYwU2NZSGFubE1ocm5vK0xkZ3lYSUFadkZlR0pja2JmRGQx?=
 =?utf-8?B?cWdQck5IYUdSVWh4dGNYcWRNN281TEZpdi84OUphZXRUZ24wZ2YwVlRzRW9Z?=
 =?utf-8?B?NWJlNXB4WmR2dWQyZ0poNC9kUGFLRkQzODJZc1owL2x3V2hjZHgxenBwR3hZ?=
 =?utf-8?B?U1JSMmxFNlZ1MmhVVWpEb25aRTAwQUlYcjVwOXVuUDUwbWxJUXNSVjQ4MUF5?=
 =?utf-8?B?RHdtTUQzNjRuQ1NNZHlIUGtZWnBGNE5wbnN5NlVZT2VmRk4xNGYwTlpyR3Zm?=
 =?utf-8?B?SzFVVHBqVTVvNER0eHFDdW5melZzUStscnBSbnAwQVU0RjdGbnZqeXdEWEpP?=
 =?utf-8?B?VjUxUjBlUFcyQzdWMGczdC8vcitLYXh1UDdCcXhYcjJ1ZmNQMHBIN0pwbTZI?=
 =?utf-8?B?TzlULy9jSU5yMWl1aGI3SU81UitqV0lVM0h5dUYxY0EyamFmejFmN0lxblVI?=
 =?utf-8?B?Zm1CMHQwRi9QUkxOa0pyaFZaM29iaFdlZStCakRjUmk1VW1mVk9iK3pPM1Bl?=
 =?utf-8?B?MllLR3JQZkQ4K0RZK05zdHRHblY5N2ttWU5KVmhMeXJBWWRoa2FpR240YkZB?=
 =?utf-8?B?TWliK04ySGVSbi9WS0ducnNMN2tubVV4ZWlTMEtkT2Y3dlZ2S0hQU0lXd3ZE?=
 =?utf-8?B?L1hMc2xaRXNEc3NDZkxwZlloMFJwcFZUamRwU2YxcFZSMkRVZUF1OG5LcXBR?=
 =?utf-8?B?aDNaZ0Y1Nk1tMURFdERZNFRrRE9wQUlWZFF0N0ZERVl4dnZmVmtta2RzU1ph?=
 =?utf-8?B?aCtFQS9lZnloYit6VXFKUkQwQTVDOThMbGxiR1p3M2kzMklhRE9wVGd5TEtq?=
 =?utf-8?B?N3pwdDlNUjh3R3EwYlNUK2hDOWJiTHAxNnNFbmNqTUVIS3M2NG1rN3NiVGFn?=
 =?utf-8?B?LzErRjdHRFZCaExEU2tSdWtZRFdGYzRKQi80Kzk1SHlYVmpycmtPZms4WVlR?=
 =?utf-8?B?U3BxbXY3QWZ2c2pOZEZ5RDVKTVBvMmZnNTB4UUUzUnE1MGRBYXY5dExsTlBQ?=
 =?utf-8?B?ZWZJckUvekxKL3RYNkJoUXdEQldMWGg5TzB1ckpWTGFEc3hHK2N3K1hlanY2?=
 =?utf-8?B?OVdoYnBXZXEvNzlPRk83eVNBQ2lZaGFySndJMVhjTDVVeXBGeVllWEZYemNB?=
 =?utf-8?B?dWpWeXo1ZzBJUlRDaGF0UHdJWGE0ZVlyU00ybEJsMzV6N3ZRaFZvTHcrK1V1?=
 =?utf-8?B?NGZWNzlHdFFDY3ZpN2QwdUpoWlkrQW1tTTlvelNXK014dW1ybE5vdmNvME1C?=
 =?utf-8?B?UlVKdk9EeStHK1RDazVRaTBDc2U3MmZJenlPSTc0bmlRbENBV1VYQlZBQmd5?=
 =?utf-8?B?Tll0NVdaT2NhVVN3d3VwbElYRytyM09CWnVxTU9IRWt2dDQza3lPNlRWUWlN?=
 =?utf-8?B?b3kwWEpOSXR0UUlWT0czTlFWa3RGcjlCWlJrTHlkY1dhYTI4eVZicFg5UU9m?=
 =?utf-8?B?QlZnTGZYUHJyTTkvbmN0dUxCcGMrWnNQdGIrWUc4SVFZY3ZLbjRmZ2IxTDdw?=
 =?utf-8?B?UTI5NU9aeUp5aUNpc0ZoUTVDajZpZW1HOVRObHdjWUY2a2pucnJmNytaa1Vu?=
 =?utf-8?B?eFZPaTkrT3hLVytZR01YOGVMS3c5NndNcUpxdUJ4cWFuSmV2cFBqM3FtZTdm?=
 =?utf-8?B?MFcwOUs0a0dlYTVQRjlDWVBFRmQrNzJqdVo5bFpOcENlME1kT0t1dzNSM3V2?=
 =?utf-8?Q?bqoLf87w64S1rsNviST2rLH76?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2daf42-b2c6-4336-a4d0-08ddce7e2d26
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 08:59:07.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlRg2VSnzRyigVQvXPFRnCM8bKlJsz5iSHQhZM/chLVHBahbMROuqwKMbRilYfBY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD78AA37BB

Hi Claudiu,

Thanks for the review.

On 7/26/2025 5:55 PM, claudiu beznea (tuxon) wrote:
> 
> 
> On 7/22/25 18:41, Vineeth Karumanchi wrote:
>> Implement Time-Aware Traffic Scheduling (TAPRIO) hardware offload for

<..>

> 
> as it is used along with conf->num_entries which has size_t type.
> 
>> +
>> +    /* Validate queue configuration */
>> +    if (bp->num_queues < 1 || bp->num_queues > MACB_MAX_QUEUES) {
> 
> Can this happen?

Yes, GEM in Zynq devices has single queue.

Currently, TAPRIO offload validation depends solely on the presence of 
.ndo_setup_tc. On Zynq-based devices, if the user configures the 
scheduler using tc replace, the operation fails at this point.

<...>

>> +    /* All validations passed - proceed with hardware configuration */
>> +    spin_lock_irqsave(&bp->lock, flags);
> 
> You can use guard(spinlock_irqsave)(&bp->lock) or 
> scoped_guard(spinlock_irqsave, &bp->lock)
>

ok, will leverage scoped_guard(spinlock_irqsave, &bp->lock).

>> +
>> +    /* Disable ENST queues if running before configuring */
>> +    if (gem_readl(bp, ENST_CONTROL))
> 
> Is this read necessary?
> 

Not necessary, I thought of disabling only if enabled.
But, will disable directly.

>> +        gem_writel(bp, ENST_CONTROL,
>> +               GENMASK(bp->num_queues - 1, 0) << 
>> GEM_ENST_DISABLE_QUEUE_OFFSET);
> 
> This could be replaced by GEM_BF(GENMASK(...), ENST_DISABLE_QUEUE) if 
> you define GEM_ENST_DISABLE_QUEUE_SIZE along with 
> GEM_ENST_DISABLE_QUEUE_OFFSET.
> 

I can leverage bp->queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET.
And remove GEM_ENST_ENABLE_QUEUE(hw_q) and GEM_ENST_DISABLE_QUEUE(hw_q) 
implementations.

>> +
>> +    for (i = 0; i < conf->num_entries; i++) {
>> +        queue = &bp->queues[enst_queue[i].queue_id];
>> +        /* Configure queue timing registers */
>> +        queue_writel(queue, ENST_START_TIME, 
>> enst_queue[i].start_time_mask);
>> +        queue_writel(queue, ENST_ON_TIME, enst_queue[i].on_time_bytes);
>> +        queue_writel(queue, ENST_OFF_TIME, 
>> enst_queue[i].off_time_bytes);
>> +    }
>> +
>> +    /* Enable ENST for all configured queues in one write */
>> +    gem_writel(bp, ENST_CONTROL, configured_queues);
> 
> Can this function be executed while other queues are configured? If so, 
> would the configured_queues contains it (as well as conf)?
> 

No, the tc add/replace command re-configures all queues, replacing any 
previous setup. Parameters such as START_TIME, ON_TIME, and CYCLE_TIME 
are recalculated based on the new configuration.

>> +    spin_unlock_irqrestore(&bp->lock, flags);
>> +
>> +    netdev_info(ndev, "TAPRIO configuration completed successfully: 
>> %lu entries, %d queues configured\n",
>> +            conf->num_entries, hweight32(configured_queues));
>> +
>> +cleanup:
>> +    kfree(enst_queue);
> 
> With the suggestions above, this could be dropped.
> 

ok.


> Thank you,
> Claudiu
> 
>> +    return err;
>> +}
>> +
>>   static const struct net_device_ops macb_netdev_ops = {
>>       .ndo_open        = macb_open,
>>       .ndo_stop        = macb_close,
> 

Thanks
-- 
🙏 vineeth


