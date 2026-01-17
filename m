Return-Path: <netdev+bounces-250732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E29D39082
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 20:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44895301276E
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 19:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573E2C1598;
	Sat, 17 Jan 2026 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="brtBlw1Y"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021080.outbound.protection.outlook.com [52.101.65.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D422571B8;
	Sat, 17 Jan 2026 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768678049; cv=fail; b=agMNTPh+IAcw4lw2S5UgCOnLNNgoTq+iuLdp9316oxn4Uw49MIw1oIhcDrIkcbHW8UkPzB0z0VSkJbP5rm7WSBSjU1CKGQh4bxxiCmxALqYflD799gm2/OJSCSZP93Cd9FhRZLUEL7EXJMDnKQpioizsMUFkVIiG3lr4pXJkutY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768678049; c=relaxed/simple;
	bh=DHr1vb4CIoA+8G7M/aQZ6jh+9+/AvzmsfB+3Fkggpys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RJUdnEURBGpynU2GNpUt1HX5MQAD9sjEzc989lwNGS8HhRkuCQKRMjZa4MaLX76lymgqUZZ/+xKLmIyPoXJ5qwJsF8EiNJ2rhfAAT14rJqAPCWi557k2NI7hdeZLqjY8ZqNOAEpiu2Abp96fFgHTf/lkiCBllt0QJAJkDTVv6dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=brtBlw1Y; arc=fail smtp.client-ip=52.101.65.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inXYmF3Q5bfka7p3+61nwflJQb1JCLExSZAHlY34IVxnBHSjeuZSX0PlxAh2TWHMH8cIS5zMCfZOnafOncWCy4uydW+ycJN+2CsqagmhRxQoEfbcP3J/a/2qdhkLFiDDiM3WUpO5AieSfWbTnfKjglOdVxU1ijdRQjkhMQddCalvuUxJA6AJZsROahZipsNLrxWp2Ig3Fsb4TZuqdSC8pj58smBzaeYkai1cjKt4O88WjBY9lEiWURvmBtm+KDBLXcrLSDzvHZTrHHvwmOQ6gA/yOgLNDZSR3Mh0eeE9E63rxcLVgOKfJYW76J79xwsThss4HUPOf55QqY4MbcYoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkqCuUAVPJk2Dt9T7MMv8tqiHaQg5jaIxaRAOwt4T/0=;
 b=l35uw0iV4buomJSZW8D/7JPqGwdrKfA/dQJ6ryIL2+Tw1O9jmSkcn7tAWQIXU6211F8O6vkx3nV4TlNZiFcnT4m2i22g1zpW826kMu2eHlh0i1UTxaul60TSxF8b9zmFI598nOomKC4Lo7JUaMJ1dgNhBUVP9sIw8jjEJtSchexvgg5tnuZ4XSrozt2gTbZ2j9BVAiD+f9YsV54LPvq+4hsl/e8qKBrgWBkSwe5YsqGb/QIonVrGVEyr/gewxlNJAtKY3VZYiVCEg11faeb4bqqRCdLOLNUzRhgko8UJu+4ks4pqt/+OHvMptBIQORuI4e0nZpzqBD2i8ZIjUikSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkqCuUAVPJk2Dt9T7MMv8tqiHaQg5jaIxaRAOwt4T/0=;
 b=brtBlw1YDsKQiUJZgRlj6VPH9UvyNhercW13bQJ9gl4atOj3Yw1rMTTaI/k0Y2ls0FLlYKBd7y+J58ZQWhsF4Ekr2KYHX+M3+FR/k2sKZe32owCiZj/rikcN3rUpYEeMxOuTorCdK7RXNpc5U2PrGvxHFgdjf42fLHw0fjDrjLC3EH2/ZHcarsfHYYriL5CbGPEShqgsnINiMjsTt63KcyhYX0+/8a7GMbsTUqn28hHbTEnJAc6VQuKHtPuds7fdira3kovOmfC4AdupY+fEjdFFSzdL81Hao5yH57eRrk7JD7SwgF0XcPbTu5/ZE6CPLRcpOb8BXxpEubEGdueWzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DU4PR08MB11149.eurprd08.prod.outlook.com (2603:10a6:10:576::21)
 by VI1PR08MB5406.eurprd08.prod.outlook.com (2603:10a6:803:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sat, 17 Jan
 2026 19:27:24 +0000
Received: from DU4PR08MB11149.eurprd08.prod.outlook.com
 ([fe80::8b3b:ee06:2f0b:a94d]) by DU4PR08MB11149.eurprd08.prod.outlook.com
 ([fe80::8b3b:ee06:2f0b:a94d%4]) with mapi id 15.20.9520.009; Sat, 17 Jan 2026
 19:27:23 +0000
Message-ID: <4d4661f9-6820-453a-856f-bf5dedd8fb0b@genexis.eu>
Date: Sat, 17 Jan 2026 20:27:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <e2d2c011-e041-4cf7-9ff5-7d042cd9005f@kernel.org>
 <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
 <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
 <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
 <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch> <aWfdY53PQPcqTpYv@lore-desk>
 <e8b48d9e-f5ba-400b-8e4a-66ea7608c9ae@lunn.ch> <aWgaHqXylN2eyS5R@lore-desk>
 <13947d52-b50d-425e-b06d-772242c75153@lunn.ch> <aWoAnwF4JhMshN1H@lore-desk>
 <aWvMhXIy5Qpniv39@lore-desk>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <aWvMhXIy5Qpniv39@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00006631.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3c7) To DU4PR08MB11149.eurprd08.prod.outlook.com
 (2603:10a6:10:576::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR08MB11149:EE_|VI1PR08MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6d4646-d799-4ce6-83eb-08de55fe70bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1UxSUFGalJLbFRoTXdMRkt2a29NUndleVg0cUZ2MWNyOHRrektvZnRham9B?=
 =?utf-8?B?NVN6Z3JYbTNnNXBqZ09OUmhjcFpONUZSOE56NHowK2N3eUNaSkdmeDJBWnZG?=
 =?utf-8?B?WTNJdmQza2tHV0xiWERZS2NMUXRaVkk4RGMvc0plMDVoaTcyZ3VtVmdrTlkw?=
 =?utf-8?B?ZFhxaVV4dnluVldMMFE2SWFXaHdkeWFUK3RKdjlMT25iVlc3bkpYZWZrbUJ4?=
 =?utf-8?B?dDVpWFFNc0RoSHpBQ0ZQcW1ucnN0cmhCeWNWUmhqTFJDZkF4bjFsSHhJZXJr?=
 =?utf-8?B?NHpQNExuZFU3bWt3Um5XSlhaRzh0NEpaNDlzVklCOXJGcGswNmFHcDFIdTlF?=
 =?utf-8?B?K2s3Qkw5ZW1HZzZZejdudjU1bzIrbGtFOTdUaU5kVkxXdEZJWEk4cjVKUHIy?=
 =?utf-8?B?eTVlMUhNSXhlN3ZENW8rQlB1bWpaOHZ4aTFtS3E0bTZBWVNIT0JVWkR2M2hQ?=
 =?utf-8?B?REF2YnF1OUdsSUduWjVHRGN5K0NUVWN3OWJhcGYwZE1CbVVlbGJDaXgxM1ht?=
 =?utf-8?B?Q0g0RkxuK3dVcjNTaUh5Y3IzWnpKWGVBZUxYa21SUUg2VUR5Z3NFcW5CbStr?=
 =?utf-8?B?WVdPc2NIUmlKVzFucitjQStDMzlvRlppODNHeWhjaWRhbHlsWXBDeXpWUDN2?=
 =?utf-8?B?UFZwUy9hUEhCY01LR0JadW5rZXE2b1B3dUFhZmdXUHBOMHdLVlBSMzdGQ00y?=
 =?utf-8?B?dHBWaHZ3ZTNnT1RVZ1ZaV0VNV0FTQ3FSdEI0eWt0dllFS0ZwWDVhbzhSdVNI?=
 =?utf-8?B?Q1RIRlYydnA2NzFWYUdmZ3pXNWREWWhDT1NLR3Q2MzFXYjNXeG83eElFNzda?=
 =?utf-8?B?UFBOMUROcU8zMzV1VllqUCtyWUVBWjBobEMwMjdYT2dJSVBjWnJUMWN1Qk5W?=
 =?utf-8?B?ZTNHS1oxa1pVNDVWZ1dKTDJ1cU4rS29CZStQc2xCUmlnQ3dFUldGOEZPcnNa?=
 =?utf-8?B?Y2dMS0lkVzBhdGp6S21uK040WUIzNGlhZmJLR0dsRnJ5RldpdS9tbzVwbWtG?=
 =?utf-8?B?RTQ3MCs2Rk9wdSszVXA3aEtKMU5rL1UxTWtyTEgvVTR4aUxqKzh0VXdPbzRM?=
 =?utf-8?B?dkZkMnJCUE4veHlMbEZHSlU1ODAybWdPMFdnakpzTk83Q04xNnE4RXp4Q2NV?=
 =?utf-8?B?c2lBR2NlSDZSUXFTMlNidlRFQUMrTWEwbEV4bzRjNW1DTXJNU2ROZHBaNkla?=
 =?utf-8?B?VlRocUVMRVlJSGVqNEU1V3VMYTg1WkhzejdMWnE1eTN4aU9laEtXb2RkQkhK?=
 =?utf-8?B?L3pYWm9WY0lDdkdIL0tXQzd0blVEa0dQVGJKR2dSaXpKQ01LNE5aV1hkaWVU?=
 =?utf-8?B?eHFxM1RVYmpITUNyZ3lyc3VzVTRNVFhsS2xHUlF5UEVPbGJWQW9OYk03d0Z0?=
 =?utf-8?B?T1IxSWpBdy9NOFFzdlFyZDBVdENGNjJISVQ0V2JEZUszaDhBYVVtdElaa1VQ?=
 =?utf-8?B?cnlpUzFGbG04Ykdqbzc4QnhYZXZnZDRta0pMUTE2NE9QUlFDRGFNNisyZUUv?=
 =?utf-8?B?ajRQK3N6bXFrS2RVeW4veEU3M0JlN2ZwR3dkSzZ1R3g1V1RKQlJFTGNoREFF?=
 =?utf-8?B?dXJ1UUZBWkcrcGhWL2Z4YVViWkVUeTZ2b0lNdnk2NlNpUFVnZ2I5Q3dtc2M1?=
 =?utf-8?B?YUNNcHZSK1lVZEZHbE5kRkFwQk03amJpRG5JdWdYaEdobVFQYm1nSU12UTFN?=
 =?utf-8?B?UTZ3S2hGTFNMc3hkSVQ0dm1yRHpXME00ZVF5dk1kUytwZXJ5dVkvaVd2Y2tS?=
 =?utf-8?B?eFJIcjhBMi9NVE9HMzl5VjliQm4xS1lRSUNoQTIrcE9mY3pJY2pPSGJPaEFP?=
 =?utf-8?B?bWRnZ2pUN0JkeWxoMDRobWJ0aGp1QmNxWHg5M21wbTROSzAyWUlKdXBMWmNO?=
 =?utf-8?B?ekpmcUxDQ3Q4TEcyZHJ3QkJyRHhxMi9GUnoxWXUrYnRQLytoS1ZobUx1d0J2?=
 =?utf-8?B?ckRyR1BWcW0rVlQ4Nm1hMEdBL2ZYRVY5WWk0VU5HcjBoZ01uRGtPVE9RWklz?=
 =?utf-8?B?aVpiZmFaNmZYaDlNeThxSkJyclZvRDFQaVZsQXVDNmZjYUlPcGxZZ09iOUFV?=
 =?utf-8?B?MjJ0dzduZ041MFUreVRJZmo2TE9waUkxSzZaVFM0OFgyU1U0RXJCMGRLK0dj?=
 =?utf-8?Q?U7JQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR08MB11149.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWpwNHZaSENnakEvTnJXVG5WUHR6WU4xU2NOekJaRnloRVlkaVZyZkhlUmNW?=
 =?utf-8?B?YUVUWFB0T1RQTzRCMnNLWlhzSU9LNEMya1lpekN3TGRhbTE4OXhTQUlYRHdo?=
 =?utf-8?B?eGJBMDl5RHUwN29zYitBczAwNGpOV2pnTnhyVTRwV0pjK09iOFhFeDFNb0tY?=
 =?utf-8?B?U1o5Z2dBQWM3dEN6dzM3V1gzNEQwcGZXQWplNCtEbzhDUHFlS2t4ODlDQ2Js?=
 =?utf-8?B?b05VdlZXQktJY0prOUdiL1pQMWdaeE1qSkx0ZjVMR2RXLzJXNTFCRHVlZzlK?=
 =?utf-8?B?TXZLaVE1NHlmMjJPNWVhdVpUUkNIdFNpbHJSSDNpL1R4ck9PYzFGTUZMRTF4?=
 =?utf-8?B?STJvTkU2VUUzOXZFQXJvdWRJcVRsNkNPVXBQcHovSXlDZVZrSTdkUFc2QTJs?=
 =?utf-8?B?RmpNVDlEeEtFSHdDdE50V0RGSXRSMHB3WFJ0ZU81VUJDNHlReGFOclQ4WWo3?=
 =?utf-8?B?dzQxODRNUmE2TlcyQlNiYng2d1BGSUZhMHhZa2ovWXpKdWtHS2RkL0VpOGRS?=
 =?utf-8?B?enhaaGh4Z0NiaEtObEs5K1EvSk9HYWNVdU9VUGxGS2ZmY2o5TWpCMGxKZnMr?=
 =?utf-8?B?R3dsK0dzUjM2cDBIV3l3dXQwbWdIWXJwS1JsV2ZENUQrQ1ZwbXQ5Y1lOWllo?=
 =?utf-8?B?enlYSWkrWU9vVjVnYTV3T2ozSnhoNEZFTWcvVGRYVHR2cG9LZUp2dnNTTHJo?=
 =?utf-8?B?Y1F3L0l6S09SWjJlbldGci8ySUUwTy9ET1lQckswVHIwZXRqZDdwMVJDQUY5?=
 =?utf-8?B?M3NnQmxUOWNJQXNmSDVlWUlJNXpHR1Q5b3RjdFFQS3hDUXRJVWlDakVzbGRI?=
 =?utf-8?B?akhGZUJZdGZWNmhDcjBtaUNQZ09mS1d6UGZQWFUvZVcyVktGYjcwUTQxU0o0?=
 =?utf-8?B?ZEZzaElJMzZlUkpINkFuSzdwcWQ0SjBhWnVzbzJscmE3OUdybTh1dlozQ1h1?=
 =?utf-8?B?a1hJbXJMMXZ2SGhicmVHdWRCOUo5YVJaSDliR1RCa1dtTjRkM3pkVUZ6SlVU?=
 =?utf-8?B?U2tEMDNFWmdUYWtKZGdSNEJIS040TWVEZGI5N3hIYnpzb0hhR2pnWThyaXlw?=
 =?utf-8?B?cHFjb25YcVQzZmRlbDhFTXRYM1J0WGZDM3R6QkVocTBJNzE5eXp2VnZhK010?=
 =?utf-8?B?UEFrNUpTSm1RcGhNcCtOLzYrNThrM2dVRmpML2FZTHdCMHhwZHVDT3QyU2d0?=
 =?utf-8?B?eFJOZjA3b05LaStTOGNmUGdFb0N6U0g0Z0N3cUt3dGFidk4zTGI2c0xERU0w?=
 =?utf-8?B?QnFMYkFEUWtZcTM2dS9kZWhCdUNWWjB1Rmg4N0NBZXMxMlZETzJEcks2Qjda?=
 =?utf-8?B?NmxKTjZZQVZKZmdTT0FoZTZ3K2dhbzh1VlE3bWFSUmR3dEFPQlFDMU1yS1I0?=
 =?utf-8?B?SW9jOHN3anNQbXVoVGo1MFFCVmQ1eWRlRitZTkdsYnM5MTZ6SDlhQlVkUWlF?=
 =?utf-8?B?YmM3M054Z0RXblZFTWVRd2xHeVh5Y2RZWDhFUFJZREd2T0FmTmpFZ1ZDTmlI?=
 =?utf-8?B?ZVJuYlUvc3JjSmFqTG9MMGgvU09SVHpWTndEU01VRkVWZUZrZ1pMYUNSa0wx?=
 =?utf-8?B?NSsyWDBQTTV1aW1tcmlaejlFb2F4NUo5VFQ2VjJRcnhrcWlVc0RiZmZUamlq?=
 =?utf-8?B?RkdsYXhFSVpYYTJWNFd6YUh0dlRIZzA0NHgrdHcvQUZGS2x0YzViYmZuUkVj?=
 =?utf-8?B?aWJ2Vm0xdHV5bkpKamFqZ25lTUMwV012R1Rpa3phTkNKSHpRamtNVjZnVUVv?=
 =?utf-8?B?S2VpamFiNHB3K2xnY0RDNlFVQVRFYXc1MXl3QmtGaWE2dU1BMVFnVmtLWUth?=
 =?utf-8?B?cEVEMEhBZkRSTmRqWW9pQmlLU3hpRnlZZEQxRFR6T2Q5bTN3SXFkeFZZZ2Fl?=
 =?utf-8?B?WCtmUnp6bGsreDJBUTNPZ0hDOHFISGppSWRTazNGQjFOVjAwVEFKQ0NvZVNx?=
 =?utf-8?B?YTkvQTlTSmVPeW03YUNCd0tJNkpHb3NmblpXODFZUXY0MktYY2t2MFV2OHYx?=
 =?utf-8?B?dlNOUDhzZXRWQ3B0eEZsNk8zVkduZGxWbmJmSVhRSGRDWnJHTTh0WUV4UkVo?=
 =?utf-8?B?L0M0RWk0dWdXazhadnBmdGNES3ZFUHRldzk2Umt0bzY1T3pUbm1qT2NzVmRH?=
 =?utf-8?B?Yyt4SGVab2lZUmZtRUprLzJ4NXRDd3J0d2s0SUtkSkhsdHRsTncxczVlWUxD?=
 =?utf-8?B?Nng5Q0tUMlV4VjFwTmQ2RUdGYTNKWXRRaFdla2QyQWRYUTN1VlMyU3NQVlVX?=
 =?utf-8?B?eG4xWW9WaDJQNElnL3VNNWE1V205dVVQVHo5SkNmb2x3endQaHZoYU5IZlFp?=
 =?utf-8?B?K0RyT3JFbmxpYnd2TVhRMVcrUmFTYjdVODZFTlhOZnQ1NzhzNk5tbjZ6ckpv?=
 =?utf-8?Q?WrweEWCtMGVSBja4=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6d4646-d799-4ce6-83eb-08de55fe70bf
X-MS-Exchange-CrossTenant-AuthSource: DU4PR08MB11149.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 19:27:23.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJtv3CbM1RPrNZXsyQNu+0s0jDvpcGipz9ASAoyGhALx8UZMAzNj91qJt2LyDEXILOAvG3p3YfFaDwYp7CAB8vR2E0OSKQgMsXfrbYKmxf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5406

On 17/01/2026 18:53, Lorenzo Bianconi wrote:
> Airoha folks reported the NPU hw can't provide the PCIe Vendor/Device ID info
> of the connected WiFi chip.
> I guess we have the following options here:
> - Rely on the firmware-name property as proposed in v1
> - Access the PCIe bus from the NPU driver during probe in order to enumerate
>    the PCIe devices and verify WiFi chip PCIe Vendor/Device ID
> - During mt76 probe trigger the NPU fw reload if required. This approach would
>    require adding a new callback in airoha_npu ops struct (please note I have
>    not tested this approach and I not sure this is really doable).
>
> What do you think? Which one do you prefer?
>
> Regards,
> Lorenzo

Please note that there might be nothing connected to the pcie bus thus 
nothing to enumerate and the mt76-driver might not be present. (Lots of 
fiber termination only products use this configuration).

For those cases I would prefer the v1 proposal.

MvH

Benjamin Larsson


