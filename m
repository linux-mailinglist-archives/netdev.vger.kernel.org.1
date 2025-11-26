Return-Path: <netdev+bounces-241782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B1C8833D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756E33AD65E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609B8315D5D;
	Wed, 26 Nov 2025 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="QDhIKoQt"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB6315D57;
	Wed, 26 Nov 2025 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136898; cv=fail; b=USaofLellH6Rzu3uVaHFkAEOPv9BSZSO1bvCduU7GzFXzARY+18GbAGOQBnXa+mGmHyOiHJW+Jk2UKmLF72qvnO44zD/FMtiKjcNQVzKYbl32+LmtYQL1iTKpBk65eS45kjE1LUBgYgdedv/eoFKapKXQZBHysHpTv9jSb9qoVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136898; c=relaxed/simple;
	bh=JIZFJpYCN06+jxIwKO5Hw7wDLla9+yyUmW+3zXqL2iE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r4h+x3dA93fjVMkAuwxKII4PXr3v23blhIPlksLTLM3IVy4SJ6rlB0tNplyAjya7bxseYjmpaTJLvun2fbk1mKJGqrAAvqXpwVu1S2fgqAISlo+OSAfCqviIr8310cMkg9sjvjzQoeCqCd0FrHFyJetbXfur2gKQkhVGI0Pxj9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=QDhIKoQt; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCQMYO0cM/jDxSDLc/m/I9APD+7B31fHP6a4rd36X7/UHHo9cM5swYWaZwSKGGqXTRS2x/YScJ2/W//Nc5J2m6g9r/jtZqgHPY9KpfZ7hS9mNZGntwuX2UwQCt4QNa2236L/gEn9GX655vP7zi91gpoXFmaBfIpMB45at1HeKS7XkJNZtnzwaol0dtAHdKfAA12XUJTcC11L3H0r4FLG07+rCxrDN5fli+OVhI2+6tcwYMGJXwQvEyHtmqrHz9AlYMvM9QMpLYOkReaqi/BVDyYoKg1I/Jsem0vETEBQhEGLJ56qlibd6U7PSRPgftZAEA3eD7WZmXvilQ2FVskM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKYq/BQ3B7xwRtjFEySwZ7igwynfVSrQ53nw/GtLFpo=;
 b=WOAWURUwmwhcHNpZxJ88hHahWfDDzKCcIJp+dfD9g/Gwpv3SiDBBCzjenJfvBAVWcyYUgeorGGSAeTl2cUHFVBA6lvjt3ta4JKzzhyZBp1UdyybsqisB3/GMWLb4PIIVCm3G2P3NnIBQ2TgeFLTE/LITmGBEBnKGyWlR8/elAYSpZBdhpwBfQA3goxyHjFGgmzZcC6nYt9xAeYwo8bwwhWca8BlKvoCKDJ//KNjPUPrIwuZqUGSEPoBK/0zzHSqaY3xgSvi3c83l+4ByUJAco5MGopHupZeZPjBcwx4ua5JYgF5RQc2ls36HDIoUWE/OtY3Qo50qREsZe6uNogFHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKYq/BQ3B7xwRtjFEySwZ7igwynfVSrQ53nw/GtLFpo=;
 b=QDhIKoQtvJXDXjdfd8dvpeji7n/3pXqqTps7HNt59NTTgQzVr8/XiVwymoxh9HqCZQxJtKPlFNx/l9umXoxDrQ4IdC3ehJRLCY5/uY00tbJaXgCzInPZlox7+6BflXpR1PC+pwp/Bt/PstDYDNqaDPL8Ct1YiTbzWWYjC0zZ8FmaVBkzfOK5wY7af6hWTb8Xf4XYz7GJvKcMnfpD0kUd/krpIyvaG0a2zYOlz0rmb5VoPUtcs/BpycGnyFyIs+JJbWYut1Zw5vvjZ0wXgciXfz1E/RNiyJTsMsYPPF7+D0OfBq83xa5dD2blIsvxeaa7AIhn4oPkedb16Py+NNiTOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by PH0PR03MB7081.namprd03.prod.outlook.com (2603:10b6:510:29c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 06:01:34 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 06:01:33 +0000
Message-ID: <8f30d884-f5b9-494d-b094-a3065d83fbea@altera.com>
Date: Wed, 26 Nov 2025 11:31:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: Fix E2E delay mechanism
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Fugang Duan <fugang.duan@nxp.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com>
 <aSY5ayT0X_zFeYFs@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aSY5ayT0X_zFeYFs@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|PH0PR03MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9416501e-a5a9-4da8-58dc-08de2cb14069
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXp4cUZMemk0OEEyWEErVHd1TVlrTFdxdE1JL0Y3Z25iREMySW83Z3JBSGFm?=
 =?utf-8?B?R0FDY1BCRmlpRjFSaElMa1RnUTArUGlnWTJLR3VtZ3lqK1MyS24rQkN6VTRp?=
 =?utf-8?B?U0w2MXE2UkF3Z3R1S2tvZlgvNS9FZ1V6bFV3UlhESWt3eFJMUWxnYjZPY1Ja?=
 =?utf-8?B?RmU5eC9wVzZ3cjNUdUtOVytvOU1oRjhTS0xDWHZDVWFyNjlZcnpzdCtIM0NI?=
 =?utf-8?B?S0hiaXd0ZkVWTnpEcjJKSWkxcTZZQjE2RjcrWUtSTTJyZ2kwTm9XN0wvSDVu?=
 =?utf-8?B?Wm95MVJGeUNSVzRabElPRlNNU3VJbE9PdmQvcVYvMmk1UUx2RG9lTXBiU2Js?=
 =?utf-8?B?UG5ndmxyeTc1SzIvNFEvOEhBRTBMM1lubUphZUlZbmZRWjFzKzJ0MDh6RjY4?=
 =?utf-8?B?UXhDYUFJWGlNdkp3TlJZT0o3aDBVaHJmSU5ab3pkeGpwWVZ5ZndyandzWjZv?=
 =?utf-8?B?NU5DMkZpdUhMd1E3bFlZTDJFV3l5VG1pMVdKa2V1cUltNk5CMHFJMm1tUW91?=
 =?utf-8?B?Zzd6eVlTR2ppMVI5NHFoa2ROREh0cXgrZ0JRNG5YczF1amFBSmtxUE5lVkhG?=
 =?utf-8?B?OFZOOWZ0MnV0a2xxMzFTMmRMd3o2THdIVkROUzlrOGZOR1BpNlhrRkJteHhi?=
 =?utf-8?B?bHVmUkxhT0dZazRwYnIrTHh1Y0pFbzlYekc2OWJOMSt6Z0tRbkRuNU1vd2Nm?=
 =?utf-8?B?VUg0eWhhL0I0ckliVXZaWGJMYWlqdHVrR013K1FCNklLSTJhY08wSjZlS0pZ?=
 =?utf-8?B?RW9tcWdPMFJ2RitNTFNGWEdTd2I2elBONHE1QU45WkkwNHZ2UmRpSEVLNThj?=
 =?utf-8?B?QVU5eHk4b0lyNFdPNlZpelpHbXYwMEdlY2xhUldlM0VGbWNuamZoc2M5czJp?=
 =?utf-8?B?cnFCamJlWjFzUnBBZElKcm5GYUE3V2YrTHdoODFDcGVEZmhtME0xdkpGWWZr?=
 =?utf-8?B?cXJJaW5uNTJ4SUQ4a0ZMckFLMkVDbnNkNmY1MCs1bEdGbDZMZ0ZnMk5CRnVP?=
 =?utf-8?B?T0VQOHVFSjVEKy92MEEzZzQ1eVVhUXJVeExrdDZ6QVdmdGlxU28zY0tRSFZE?=
 =?utf-8?B?YXBlRTdXMitva0tRTnVFR0NsVTRGY3lHcGlxdjE4WmZROGxCKzVneUZWTG92?=
 =?utf-8?B?YVJwS09jS1duVVR6TkllWkFBbndNM3d3cXFIKzhoTlBZWHNWQUJ3S1dlMTlF?=
 =?utf-8?B?eUtnVnhRemFQUlhYc3JLY1dSM2tVem0xSllHZnZGMFFTUXl3MDJaam1lRlpr?=
 =?utf-8?B?cjdSdUNvN0dTbXZwQzdhdVRHaVFwSi8yUndIcTh4Wi9BWXZ1VGYxczc1YnRP?=
 =?utf-8?B?cFp0cG5tSVVDdENQTjBIblc1b1lMcm5VRGpvbnVlaWVNcGtlWU9qZ3VCOEYr?=
 =?utf-8?B?Smc1YVB5bGgrOVpKR29ZKzZQRlF1dWtySm56cFdsdnIweFJ3L25ocEREYlFL?=
 =?utf-8?B?eU56dW1URWFVaWpSTDd0L0RERituZUFpbm1MWjB2dkFJUjFXWit6SlpWdEZh?=
 =?utf-8?B?c3B0L2cvSWp3bXFKV2Rxc0xTajcxZEtIVWU3Z1RJN1lxS1haZ2NoRXBIR3cw?=
 =?utf-8?B?Zm1yUEkrMFpZcHNENTJDSlVnSXl6SkdoZGJhd0tvV01oK3l5QWRMYnN3bnJp?=
 =?utf-8?B?djZDaUYxRGIyeVdJL3NzcVFNa2R2RGJvNG9LeDVpOGxVeVVaeXN3ZVU3OVhz?=
 =?utf-8?B?WDFGb3d1cThOVzFBRmE1aWFuV0ZmTjF1bHNFODN4NHJMY2dSM0NkSC9mTjIr?=
 =?utf-8?B?ZjlHOVhyOGlPdTkzbVhpaXhCcFRSY3RhaGlhWFE4dEJmcE1Pa0dzZmdRMHVv?=
 =?utf-8?B?N2FjUWt5aFRLTFlGd3VEUERWQUNQWFRJUFBzdnpXcmN2cEYxMmtub1F6V1VF?=
 =?utf-8?B?bzV4NGJWd04raFRXeENxdVh4ZTBNRWJjMzB5aXVod3dyR3Y1N2dKdzN6THpl?=
 =?utf-8?Q?T2Gf3J3A1Ywoo8WXRXaZlspnHojI/JQS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk9ObkR2dkFacWI2aGNndWNTZ2cvVWJFUjYxR1lHRWRndk9wQnhKZDEwcDRC?=
 =?utf-8?B?dDJTZndUdWo5QlJDdHh4Z3NvWWlTTGVvNEYvMmd1RDUvVHJOb0pRUmNRV0Fz?=
 =?utf-8?B?M2YyYjRzYm16QlFzejVYc0VDeWxSanNPeDErcmdkbDVyQVBrUlFCQVdHWWZE?=
 =?utf-8?B?T2p4RFpCRll3TVgzZTExTWsvdlNtUS9OdWZwU1dGVG9FTU5Cb0FvSVVpK3VE?=
 =?utf-8?B?M1FvcXpLUHBVd0RNOC9hUVI4eXNUSFpPR2RoaTFJeWdoMXZmQXd5NDZ3Vlpl?=
 =?utf-8?B?M3RxSUk5bVlPMjkzeG9GalQwaTc4blJNeU1uSzJrbEdvZ3RKSmJLVExNRm1W?=
 =?utf-8?B?NCtPbjRCSDdhZ0NlRkR0UkxoWDRkYUNFTDN6YWxheVNVMEdqQWhSOFBMQ1VP?=
 =?utf-8?B?c2ZQRzY5Y2JueEZnek9OYTFjL1pBTytLSHRlREFPTHQzQU1BT3RvSkVTQTMv?=
 =?utf-8?B?RkpKS1Mva2R0ZU1pbis1SHlQUEVTcXB3MisvblA2VmJ6UGdGNWdEVDEraXlN?=
 =?utf-8?B?TjMvZXN5dW9PaHJ5UFFUTEdGWXlEOHlIZWIwSCtlaU9Zc2NOVk5lUFpIRVp3?=
 =?utf-8?B?UEV2ZHcxMkxHdVdEb3k5ZENWUmZrcTdBcFQ2NlQ1OUhObjVtYnhuL2N4cTBy?=
 =?utf-8?B?cGpWb0lSUFJLb3lLVVRUbVJubXc0MS9FNWl5cm8zRWZycE9HbGZVakFnTmFY?=
 =?utf-8?B?Qy9leXgwNWtLM3RLTGdZRFQrVlBvMDZqd2h2UldCOGcySDE3YzIyaVc3OHZr?=
 =?utf-8?B?UC9nUlhHdkJtNTFLZ1NZNlFmZTdTMXhmV3k2K04wM1NicVZYUWwwUGVWWjYx?=
 =?utf-8?B?VGY1SDRMOTcrWTVwMTVYdWx6TWt1dTVLMi9KOGs3dnRoM21PMzBVdThTZEFG?=
 =?utf-8?B?OEpndkw0ZXpoNWNabUJZNFZpOTI0YzBIN21kTXNyLzJ2REdmVVVHWGpvWE5L?=
 =?utf-8?B?NWtxMEJlaVR3L2lZYWtJdkkyN0lqZnlBZUJPL2tXQmRGOVZmekZhVmdIOHp1?=
 =?utf-8?B?TlVzY1FETitwSHFsTm4rWEVwWEdiMGFjSG5lUFBwaU9jWmlCSHFLL2pJKzlJ?=
 =?utf-8?B?a2xZYTdkVkp6cHd2c09pRlF6UHNudy9vZXk5RjFoU01XSjkvazNKaGlubHNa?=
 =?utf-8?B?a1dLNkpmNnRNNk9iN0ZKdHRhV0I0bzJEakhBNzNOeTlFZGVFcm1hbDRlaGg1?=
 =?utf-8?B?SUppNEN6OHZKNC9xMzk0ZnA5M1Z3djhaYlQ5ejJlQktxUStGNHdjUXc0UCsr?=
 =?utf-8?B?UjQ0eWJ3UDR0TWhmSEdMVFliSDlDVGExT1ZUUjAvaUEzU1RXOFR5aGdSb3ZF?=
 =?utf-8?B?dGpaY2RRaXU3c0lteTR6OGpVNXBZSHNSRkJzNVpvVGtVcEVnSS8wMFdpTTZZ?=
 =?utf-8?B?aUxqMG02bEVweXJQZmhPdHpEYlRLamJRclB0ZXVPb0NNRXNvY0Y0eXcrK1Nx?=
 =?utf-8?B?d2k2NVdpcDR3ellCek54ZTArYWdmUzI2b296TUhxbGtwVUhjM21Oc3oyZEha?=
 =?utf-8?B?ODVHcHRWdVM5MlNiejUzTXN2UFVqRzd6dHJmS3RodDZtMWRWSHR1Z1owalJu?=
 =?utf-8?B?UXlPNGlVZm1CVSt3dXJjQnVBcGdMNzNCS25kOHBrR2tRU013S2lNSEs5cDI5?=
 =?utf-8?B?bDI2RVE5ZGZxc1paYUVwUVQxZmhCWmkzZ3VRRnFwd2JiK3RhVDlvL05aZDUr?=
 =?utf-8?B?VGlmVlhvRW5pVFQyTGphalFGNldpcVQzY0JFV284dzEza3lrbGNXYTY5M2Va?=
 =?utf-8?B?azhVS2I1UXNhZDdSSEhMV29YeDZQNHFRRWIxRzdEQ21ZTlk3VnZUcGhhbnZV?=
 =?utf-8?B?bG9OUElIcmFjdjJjZE5mdURJL2FZV0VpemdvVHEvVXRaWUZoOXNqanlaZFg1?=
 =?utf-8?B?aTZyUjQxTGJOSnhyZi9hdU02a2F4d3d3ZjcxSVR5RXhvTlEzQUJxalFjZmxu?=
 =?utf-8?B?TUxGb09ENE9iR0Z3bVE1VzFPblRNQ1RvdXVsOEtOTi9tbmY1dE5DSEhncUVV?=
 =?utf-8?B?TmlJeXU2RU1JNmZrbHRXYVZRMjR4bWVSZjJJL0VhT2VqSWdXQVhTSE9QLzM0?=
 =?utf-8?B?bWdFamFKeWlSUUZwRjVIeXZaS2JJeWZ0RXFDa203VTVma3UwL2pORjNETDZB?=
 =?utf-8?B?YlhnZnFXWlZPN3Q4Q1VaSU1qQzVLT3ViV09zUTlQYzdOM0gvNDNpbmJzM0hF?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9416501e-a5a9-4da8-58dc-08de2cb14069
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 06:01:33.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZAyPf3gPXvx8+2Cu3H/VpwioxGJ83ZUrNCyTLCEP/rUX119wTrdm7WcHz8wI5md+GqITJc8C6FabkJ2XvQXfIXoDIVlzusvGb1FFpsGiZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7081

Hi Russell,

Thanks for reviewing the patch.

On 11/26/2025 4:49 AM, Russell King (Oracle) wrote:
> On Tue, Nov 25, 2025 at 10:50:02PM +0800, Rohan G Thomas via B4 Relay wrote:
>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>
>> For E2E delay mechanism, "received DELAY_REQ without timestamp" error
>> messages shows up for dwmac v3.70+ and dwxgmac IPs.
>>
>> This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
>> Agilex5 (dwxgmac). According to the databook, to enable timestamping
>> for all events, the SNAPTYPSEL bit in the MAC_Timestamp_Control
> 
> bits

Sure, will fix this in the next version.

> 
>> register must be set to 2'b00, and the TSEVNTENA bit must be cleared
>> to 0'b0.
> 
> Are you sure 3.70 is the appropriate point. According to the 3.74
> databook, SNAPTYPSEL changed between 3.5 and 3.6.
> 

I’m not entirely sure. As per the dwmac databook notes that SNAPTYPSEL
is not backward compatible with functions described in release 3.50a,
but it’s unclear if this specifically relates to TSEVNTENA. My
understanding is that at least from 3.70a, TSEVNTENA must be cleared to
enable time stamping for all the events.

Best Regards,
Rohan


