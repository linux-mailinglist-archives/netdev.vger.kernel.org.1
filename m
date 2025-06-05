Return-Path: <netdev+bounces-195332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3CEACF9C3
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 00:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183B717280A
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 22:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4D727FB26;
	Thu,  5 Jun 2025 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wJm5JAC+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1017548;
	Thu,  5 Jun 2025 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749163292; cv=fail; b=DNoCVIhQdnarNBggXSxwkeKsopaeJoy4xv1/DzjTAuIN6euNRhH+MutYHOx5t/i6xetkaBFThwMq0SU9kPgt52REToJ7WZVGm3cOj1d4ett4gB844C+HvvHuCZAMiN8npRPsXr/cCUIm2OXuybUvkP89O4rf1y6kyBkJUhUg8v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749163292; c=relaxed/simple;
	bh=AlU+W3sxgzCyMlHZ8E5Htqh0ac1LEkBOwtfOEDEWP6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W0TycyR/fzUYR/O0udCppXwaV6tt1pEqZYiLHcA9HGhfZdWHBnzSlYR1kWR529joa/piUfaMYyvHWiQ7mDI0FIed+6EETlXiK4VyYLw9w74SkGU458AHHf4NMuxzAfUpuu+cResMVx08C/ZQuL+/soYDphB7Z8DDmEQWKCYtewc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wJm5JAC+; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMW1ahb1tlmaNKyh3M9Gt8YsBgzL7f9PZhoPnPkilYZES6Eb2Tm2M9XT3b+KNEvg4/XWCwi+Ri0HqC/SNnSf4/ehlLjfuQHYJGNSjApfCT7uWTBfo7xB12Vy818ovg/Dlw+OZHBPMAEMMU2y4OMhnSKlAsWbrsHedlCwmPnCVvjsScAJVt3b4FOaM0d5DHjCZTzQbLWf1qW8PjIVHOXhG5CnlIDK5rH2dmuZUWj8EjAgnSi+XagF8ULAEeskRv3/KaMt/cvEz2iGq05LNCKAw/tOENIYB97hiktfmAvTbw7B+WyubqPef/AledQPO7bLA+JTlUnM6K28K8SeoOPdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EDXFJKCkccUV5qHAFufFvMXveX9MqZo/528p74To+w=;
 b=AhDFT/FnDz+xKqtzpKp+iXUaF0nsagaqCnxl18YBUKtQFijIaQkg3EG1cTFzpUAYEcv6aQ/Kibu3zLbUNb0V6SmV2N24Myq6kczHZDm9vsKz9OXK7HAG0v9M/9khHzt39WKh9YJT6nX3tD3qhUKMGJZc/gwZE7WMswEJOsWbTEE47qIkRBLuQeJ4q2P8M58FF699FxyH8OBjgKJOqn3LqPXqA5t3hThUe6WoaQ2FOfc72Oao4wcX5qTdmpvN7cDFS/PwavU70Rs9miZ+hFnn+hbnr86iqGTsmr5NyrPwMuPIXQJo6hn6d2HG7+3r9rWgGQ5JrQI5FiqdK7MwOjdEzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EDXFJKCkccUV5qHAFufFvMXveX9MqZo/528p74To+w=;
 b=wJm5JAC+BdcAC0mgSK5eEX/EHKPC+glkRfVKjo2oLBPVEpthaZju3joowAjBhUlaQ2denU6O9M2yVtZaucm7yGbQKU90lyvsDhY2CdPZTap+pupb/2u+/ZQ5fFaoEY4Gx65/mNiTW3MJJw5qlvTyeHdW1MwP2CuSkvSbQyQbNc4F6/0nG6Svj7/y3t7rqk+zWmnOOdWst8+GIsw58wk51ot+n+a9RcngkqfOreXawVstfdBsLPlvdlhYx/MQIh5vqkfJ1udf3yWcgwHxdeaQgUYf5fxuGgmdQHt8s41ovz+IyqxtEWoGZuYcxS1yKB6dVpAGVSs2XlAB1LWlIr3KDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by LV3PR03MB7707.namprd03.prod.outlook.com (2603:10b6:408:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 22:41:27 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 22:41:27 +0000
Message-ID: <215115d8-b312-498f-a3a7-0a3cee38ebf3@altera.com>
Date: Thu, 5 Jun 2025 15:41:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 maxime.chevallier@bootlin.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mun Yew Tham <mun.yew.tham@altera.com>
References: <20250530153241.8737-1-matthew.gerlach@altera.com>
 <20250605175948.GA2927628-robh@kernel.org>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250605175948.GA2927628-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:74::27) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|LV3PR03MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: c8738b98-0f88-469f-1688-08dda4821b0c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1hmdXBNbGp6alRUc2ZvWUxISHFLN0xKWHhieDZINXpHSE01UUJXa04wSWQ5?=
 =?utf-8?B?NUloRjNPYmtOTDdRSEZQTXBWVnBEamRWUlZ1cDdJS1kzd3FtaXIvS1JZclpC?=
 =?utf-8?B?WGpXTWVaUVM0empseS9uMlhCaE52TmZqSGpnOHNheHR2M3VRSHVxdmh2VXh4?=
 =?utf-8?B?WTRjclFlMDJxUGV1UzIxSmoyTlZ0WU1nMGs5Vk8vWHZ3dDJKTDZWR0FWOWdx?=
 =?utf-8?B?Z0JKQ245K3NEUUoxK0E1QkV4WkhMdUtocXB4UVdDT1dnYkFCdWF6WVVPOEpG?=
 =?utf-8?B?aHR0eWhRc0VCa0ZHVmhIcDRIL3FydFgyY3JVa0RlZEVBYkQ0d0lyemVMeVJM?=
 =?utf-8?B?RVJqUGhCV3NRbFA2YWFsMUdQL2xrSzRPKzFRQTZmYlNxdVcxUytoL21YbVF2?=
 =?utf-8?B?dnBJSjZEOWovdXU2cFdLRHB5VER0bEpKVjFOYXlIR3Bnc0xvNXJlaDZDRC9V?=
 =?utf-8?B?VitDWFlWSjhTUkgvbm5ndG1sL25WalF4aVJyK0R5VFNMZkRKNXdlUnFKQkQx?=
 =?utf-8?B?bkphOWxmVWM1RW9LUnpHZkZLYW1WVFJLdWRnUzNKcHp0dkFEcWxwY2NNalBo?=
 =?utf-8?B?WSs5bXdWOFhSK0NMeW1lTHZzVGdCUTBDckF1Qm1nZ1BHZlRJZW54Rm10SzlF?=
 =?utf-8?B?NFIwQzhuVHQzMDQzVERMNllIakc4WVBOdTRmN2FQaTQwSjZMaVMrNGNiQ2Z1?=
 =?utf-8?B?cFV4bWVXc3lzQ3lqdHRPNVVvNEtUSzdwM1VVSGJrMGRTcUVOU1Q5NWo3RnVt?=
 =?utf-8?B?dHpCaDF5dlpMcFVkeU96VzI2b2tHcEpmLzVrR1g3bXZBSi95UDlLM2l0MFdx?=
 =?utf-8?B?MGRhdzRFbWhvS3FnWGtaNUNSODF6YWM1SDFlYlhJTHVoS1cvZ2twL2F6STEr?=
 =?utf-8?B?c3dvOVJBcU55Q0M3TFMvODVndFpMdVRLWmpBVGJRZVd4c2VjNVZMcnA1Q3Mw?=
 =?utf-8?B?cEVxYXVNeldadVgxb0ZEVEFzdXNMWUprWXdBclBwME1zdUQrNTNJZ1Y4bUsy?=
 =?utf-8?B?ZSs4eVFPNUkrYU1jcFUxMW1BTVliVEQ1YWJpR2JhU2V0VG9tMEZySjhuQ2NG?=
 =?utf-8?B?UmVqWWdHYXBqWnVSMDdyQ2t1eWdCVTU2aGFCQWNWaUkyRHVud2RFQzhLWGVE?=
 =?utf-8?B?aHJ0VkpsOFhkeVBwd3pXV0oyTzVRekZUZTFXMzdEMGFWNTYrZis2QjNoV0V6?=
 =?utf-8?B?OVI2eG0yMk5rc0VqVkdOV1JqSjBhSlhaMVU3Mmg4NWJJWGtBdFFHRHZKenJJ?=
 =?utf-8?B?ajhWTVduYTkycTlKb1BvYVhzaitlbno4bVpQOG9nOEhQaUlsSHlheDhmSlZ2?=
 =?utf-8?B?M3c0YWt3dEgzTFB4Zm9tOHRyeFJkeUVnWEd2dlVaMmp5U3U5MlV3RVRsNWpY?=
 =?utf-8?B?LzNtYnhuK0RTT1N0QVdGcTZFMVE3Ukkzc2F3YWVWWmhQRDRYYWdqSlEwUGp6?=
 =?utf-8?B?d05CdHpwaXVRRDhqSmF6cUFGUVNwM25RaVNVcTRFM3FFWXIzWGxSU0swMGRj?=
 =?utf-8?B?YUdMTThsZDVlMHNmOExDbmN0UWJlNGhtTllwdjkyNFlRdWQya1JrN1Z3TnE5?=
 =?utf-8?B?R2RmOWcvOU9URzJpYmNiMkhBQ2dZZ2N5MkdKWGc0cFpPUzQ5QVRjbGkxMTBU?=
 =?utf-8?B?Wm41UEFibzJEVGZ1YmNQUVVvU3VZV3lFOG9Nam5EQUh5ZmplM1FCWmR4djBH?=
 =?utf-8?B?VjR2cElQdEg4UkNMc2FEMDhNUGtrK0RRUXVvVGNzM3ZlbkRhWHJOemVOU0ZY?=
 =?utf-8?B?UGVORXpzNzJzRkxkVEhxNVZQWTB2MHR5blQyMTZJNEI2QXo4V3hVcURSR0hu?=
 =?utf-8?Q?e50P7lkEh5seIzIWOBohUrTTbUzp2QVFTlmcg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEk1NmlPQSt0Z3dsQmxhK2hQSVM3alJFZWcxbTY1V0RtZEVGbG1qb0hPOUQ0?=
 =?utf-8?B?UkczOFVJSzdnalFPaW4yaHFQaXVIem5UMy94RXhjMC9ZSWJLNFZmdk5UQlA0?=
 =?utf-8?B?b2xORHFXUWV3N1gydWhhdGo3bzFRdjk1YXpZUXZJaXJQZUFhMm1SUHMra0Q2?=
 =?utf-8?B?WWRxT2t4bjd3ejVaZ1pUaCtsa2dsT1FnU21QbW9jdnMvaklkbXZKaHNZZGRI?=
 =?utf-8?B?V0RkV0MwbGYyeXZyQi9BVDNZaGViYnRjUlJ0ZXFkWElTQXFkWVU1QVVZaW5X?=
 =?utf-8?B?MXBvNGpqbHFyTGFNa2hRbWphM0l4SzFQd21LV0RXSWJoYnQ3NFh0M29RdHJE?=
 =?utf-8?B?UUd0L0tNTnRpYWFiY0ljRUhEWWRoU0FySkhicWJkTE9DMVRLbmhHU3VnU0JU?=
 =?utf-8?B?dWlJN0VDQjZ5bmNnSnVKcExMUUkxMTl2WUhwL1NhZENGNlNSZGcwWlR4UzFG?=
 =?utf-8?B?aFY0Ykl4VTNJS2N1QkxUaGZxRU5FRHlZRHZLbm5WMTBKUUZMaEpUT2dzQjJy?=
 =?utf-8?B?SWNSZXpMczRtSVBKczkvZEQzUXArNStRSFVHci9ZSW91Y1pIdlhHcEt2VkZ5?=
 =?utf-8?B?VkZPUGh1WFZaeVAxaUd1aHkraWtESElKcWF2emkwc2tza3hrRnVsMWVHRUJl?=
 =?utf-8?B?dWdxSndtYng0ai9sUXFDWkVSY2VDK1g0NnhkS1NQSy9Mb21LV1BlODhQbDVs?=
 =?utf-8?B?ckNjS2JIS1pMR3ZtM1dvRzNqYU53K05tS0tWbzFPTU5reFN5TTJlaHJtOW82?=
 =?utf-8?B?K2dPY1JuY05VOFpXbGl4Nkt6ZHlSQXV3UlhGc0g1RmJmeG5iekRST3UwbXVw?=
 =?utf-8?B?U1BwNDVjalBGaWxRSXAvQ3JJTFNYSG95RWZSczZEK3lYeW41YkNESW02UXA2?=
 =?utf-8?B?R29TclB0ZTZ4Y2pVVkw0bzJYYnZqOSs1eWVIVUhaS1hwY2JnUEVnU0F0ZzRG?=
 =?utf-8?B?K0hHeTBXYVZtZllDNVZlS3docjdDaDVsUlJNbXY0QjkvTVdqYjBFQU5sWitE?=
 =?utf-8?B?ZGloR0lpM3JaVVMwTUMzeFYvSG1OMk9VMFZnZ0dFT1JHaERReEt2Yyt6VDFq?=
 =?utf-8?B?WjF4U21jUnlhZlVEMDBBRG82RUZrcGZXNm5MeUpuck1IeGpzajlHL0hpWk1J?=
 =?utf-8?B?SGlNMWpsN1lpVFQ0dExnbkhFc1dUcDlVdUxGK0NHaUYrcWJTUTk4Zzl2WFJL?=
 =?utf-8?B?NHFCWGtpT3NJamhneitpS00wdktLTWIvNkV5Skw2clhVa2RmNDVZVDlQcDRz?=
 =?utf-8?B?Y3BsSExjOHk2L2ZDZEhIdVZHWkpoblZWR0lUQkZBemRGQnZMNm0yWS8yQURY?=
 =?utf-8?B?Zk11V0UzODV2UGpOYitpTGJBbDFIam9NeWlaUjMxenlwNithZ05zcnNkYzlv?=
 =?utf-8?B?a1lHKy9TbitTbXUvVlFjczVTRU9vRSt5d2c0a3NYSGoxeUQ2WEEwcWQ0YVEv?=
 =?utf-8?B?dVhGc1p4eWlONm01MzVKQVdSaExzY3lOSjdNOWNlakRSMHNvY2ZKR0tWRFd0?=
 =?utf-8?B?S2VTZFJBditGTUsxQyt0cC9hcWpUVHJTaU15RXJSL2t1T2lHa3g1K256ak1r?=
 =?utf-8?B?c2hhdWxhV3BFcDZoMDA5MFZwempSYlppUm9IZWppSWNBM3R5V1YxK21ZK1Jp?=
 =?utf-8?B?MFdHNjI0b243cFB1ckFmTmVMK2FXMElGSGx5NkwzdlYrNlYzNjZxbmplaExL?=
 =?utf-8?B?MHR3MUMvc24ybzl4djF5dGlVYThOQ29rbTJKL0VOclljUklTS3VXMmNvelow?=
 =?utf-8?B?NG1LOVZsaFB3cm5nR3ZNQ2RIeC9XMkUxckE5TlFPYnRya0tGQ2R5ckgyVlFh?=
 =?utf-8?B?NWczU0pqMi9tMHRQTWpjYVVudW5NbEg0SFBsZ1NKa08wTjFtaysyVTVRa1Ir?=
 =?utf-8?B?N2lzd0tWMmptSm02bGZDOHlpeGs3TFVYVjU0NHh5d1VBaXdUajgyNDU3c1pZ?=
 =?utf-8?B?T3hGUXp0bGlmK3ZPUHlDZSsrKzJ5ZGIrKzBxVlRNNjU5YVYwZVZTSFJ5ekhp?=
 =?utf-8?B?OTVBZEpaVGsvWjNZMzRFSjlBSGxFaHo5SUZpcGd2RXpwR2JOWUV4THRWaWFi?=
 =?utf-8?B?eGo5M00wbmRaQzZkSXYweVVZcS94Q2UzaGh1cXM3cm5kaG42QXFkRHJCMitm?=
 =?utf-8?B?ZnBXQWNlYTRSL1VTK3EvNDRnNWUzSUF1YkE5aVFhTElySi9VK3V1aFl4Rm9r?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8738b98-0f88-469f-1688-08dda4821b0c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 22:41:26.9187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyzBQa1JaJHB+MxGCYdXOpXETIGPyTNlxZ6mFmUEyz9GnqHfJydxOsQhDZr8V3HABpUHYoGxqeyFRevMso0HxLxU7RFdwPegFlc5ytsf2pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7707


On 6/5/25 10:59 AM, Rob Herring wrote:
> On Fri, May 30, 2025 at 08:32:41AM -0700, Matthew Gerlach wrote:
> > From: Mun Yew Tham <mun.yew.tham@altera.com>
> > 
> > Convert the bindings for socfpga-dwmac to yaml.
> > 
> > Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> > v3:
> >  - Add missing supported phy-modes.
> > 
> > v2:
> >  - Add compatible to required.
> >  - Add descriptions for clocks.
> >  - Add clock-names.
> >  - Clean up items: in altr,sysmgr-syscon.
> >  - Change "additionalProperties: true" to "unevaluatedProperties: false".
> >  - Add properties needed for "unevaluatedProperties: false".
> >  - Fix indentation in examples.
> >  - Drop gmac0: label in examples.
> >  - Exclude support for Arria10 that is not validating.
> > ---
> >  .../bindings/net/socfpga,dwmac.yaml           | 153 ++++++++++++++++++
>
> Filename should be altr,socfpga-stmmac.yaml
That is a better filename.
>
> Don't forget the $id
Thanks for the reminder.
>
> >  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 -------
> >  2 files changed, 153 insertions(+), 57 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> > new file mode 100644
> > index 000000000000..29dad0b58e1a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> > @@ -0,0 +1,153 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/socfpga,dwmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Altera SOCFPGA SoC DWMAC controller
> > +
> > +maintainers:
> > +  - Matthew Gerlach <matthew.gerlach@altera.com>
> > +
> > +description:
> > +  This binding describes the Altera SOCFPGA SoC implementation of the
> > +  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
> > +  of chips.
> > +  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
> > +  # does not validate against net/snps,dwmac.yaml.
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      oneOf:
> > +        - items:
> > +            - const: altr,socfpga-stmmac
> > +            - const: snps,dwmac-3.70a
> > +            - const: snps,dwmac
> > +        - items:
> > +            - const: altr,socfpga-stmmac-a10-s10
> > +            - const: snps,dwmac-3.74a
> > +            - const: snps,dwmac
>
> This should be defined under 'properties'. The select just needs:
>
> contains:
>    enum:
>      - altr,socfpga-stmmac
>      - altr,socfpga-stmmac-a10-s10
Got it.
>
> > +
> > +  required:
> > +    - compatible
> > +    - altr,sysmgr-syscon
> > +
> > +properties:
> > +  clocks:
> > +    minItems: 1
> > +    items:
> > +      - description: GMAC main clock
> > +      - description:
> > +          PTP reference clock. This clock is used for programming the
> > +          Timestamp Addend Register. If not passed then the system
> > +          clock will be used and this is fine on some platforms.
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    contains:
> > +      enum:
> > +        - stmmaceth
> > +        - ptp_ref
>
> stmmaceth clock is not required? Looks like it is from 'clocks' schema.
> I'd expect this:
>
> minItems: 1
> items:
>    - const: stmmaceth
>    - const: ptp_ref
This is a better description of the hardware requirements.
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +  phy-mode:
> > +    enum:
> > +      - gmii
> > +      - mii
> > +      - rgmii
> > +      - rgmii-id
> > +      - rgmii-rxid
> > +      - rgmii-txid
> > +      - sgmii
> > +      - 1000base-x
> > +
> > +  rxc-skew-ps:
> > +    description: Skew control of RXC pad
> > +
> > +  rxd0-skew-ps:
> > +    description: Skew control of RX data 0 pad
> > +
> > +  rxd1-skew-ps:
> > +    description: Skew control of RX data 1 pad
> > +
> > +  rxd2-skew-ps:
> > +    description: Skew control of RX data 2 pad
> > +
> > +  rxd3-skew-ps:
> > +    description: Skew control of RX data 3 pad
> > +
> > +  rxdv-skew-ps:
> > +    description: Skew control of RX CTL pad
> > +
> > +  txc-skew-ps:
> > +    description: Skew control of TXC pad
> > +
> > +  txen-skew-ps:
> > +    description: Skew control of TXC pad
> > +
> > +  altr,emac-splitter:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Should be the phandle to the emac splitter soft IP node if DWMAC
> > +      controller is connected an emac splitter.
> > +
> > +  altr,f2h_ptp_ref_clk:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to Precision Time Protocol reference clock. This clock is
> > +      common to gmac instances and defaults to osc1.
> > +
> > +  altr,gmii-to-sgmii-converter:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Should be the phandle to the gmii to sgmii converter soft IP.
> > +
> > +  altr,sysmgr-syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Should be the phandle to the system manager node that encompass
> > +      the glue register, the register offset, and the register shift.
> > +      On Cyclone5/Arria5, the register shift represents the PHY mode
> > +      bits, while on the Arria10/Stratix10/Agilex platforms, the
> > +      register shift represents bit for each emac to enable/disable
> > +      signals from the FPGA fabric to the EMAC modules.
> > +    items:
> > +      - items:
> > +          - description: phandle to the system manager node
> > +          - description: offset of the control register
> > +          - description: shift within the control register
> > +
> > +patternProperties:
> > +  "^mdio[0-9]$":
> > +    type: object
> > +
> > +allOf:
> > +  - $ref: snps,dwmac.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    soc {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ethernet@ff700000 {
> > +            compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a",
> > +            "snps,dwmac";
> > +            altr,sysmgr-syscon = <&sysmgr 0x60 0>;
> > +            reg = <0xff700000 0x2000>;
> > +            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "macirq";
> > +            mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
> > +            clocks = <&emac_0_clk>;
> > +            clock-names = "stmmaceth";
> > +            phy-mode = "sgmii";
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> > deleted file mode 100644
> > index 612a8e8abc88..000000000000
> > --- a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> > +++ /dev/null
> > @@ -1,57 +0,0 @@
> > -Altera SOCFPGA SoC DWMAC controller
> > -
> > -This is a variant of the dwmac/stmmac driver an inherits all descriptions
> > -present in Documentation/devicetree/bindings/net/stmmac.txt.
> > -
> > -The device node has additional properties:
> > -
> > -Required properties:
> > - - compatible	: For Cyclone5/Arria5 SoCs it should contain
> > -		  "altr,socfpga-stmmac". For Arria10/Agilex/Stratix10 SoCs
> > -		  "altr,socfpga-stmmac-a10-s10".
> > -		  Along with "snps,dwmac" and any applicable more detailed
> > -		  designware version numbers documented in stmmac.txt
> > - - altr,sysmgr-syscon : Should be the phandle to the system manager node that
> > -   encompasses the glue register, the register offset, and the register shift.
> > -   On Cyclone5/Arria5, the register shift represents the PHY mode bits, while
> > -   on the Arria10/Stratix10/Agilex platforms, the register shift represents
> > -   bit for each emac to enable/disable signals from the FPGA fabric to the
> > -   EMAC modules.
> > - - altr,f2h_ptp_ref_clk use f2h_ptp_ref_clk instead of default eosc1 clock
> > -   for ptp ref clk. This affects all emacs as the clock is common.
> > -
> > -Optional properties:
> > -altr,emac-splitter: Should be the phandle to the emac splitter soft IP node if
> > -		DWMAC controller is connected emac splitter.
> > -phy-mode: The phy mode the ethernet operates in
> > -altr,sgmii-to-sgmii-converter: phandle to the TSE SGMII converter
> > -
> > -This device node has additional phandle dependency, the sgmii converter:
> > -
> > -Required properties:
> > - - compatible	: Should be altr,gmii-to-sgmii-2.0
>
> You need a binding schema for this node.

I will add a binding schema for the altr,gmii-to-sgmii.


Thanks for the review,

Matthew Gerlach

>
> > - - reg-names	: Should be "eth_tse_control_port"
> > -
> > -Example:
> > -
> > -gmii_to_sgmii_converter: phy@100000240 {
> > -	compatible = "altr,gmii-to-sgmii-2.0";
> > -	reg = <0x00000001 0x00000240 0x00000008>,
> > -		<0x00000001 0x00000200 0x00000040>;
> > -	reg-names = "eth_tse_control_port";
> > -	clocks = <&sgmii_1_clk_0 &emac1 1 &sgmii_clk_125 &sgmii_clk_125>;
> > -	clock-names = "tse_pcs_ref_clk_clock_connection", "tse_rx_cdr_refclk";
> > -};
> > -
> > -gmac0: ethernet@ff700000 {
> > -	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
> > -	altr,sysmgr-syscon = <&sysmgr 0x60 0>;
> > -	reg = <0xff700000 0x2000>;
> > -	interrupts = <0 115 4>;
> > -	interrupt-names = "macirq";
> > -	mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
> > -	clocks = <&emac_0_clk>;
> > -	clock-names = "stmmaceth";
> > -	phy-mode = "sgmii";
> > -	altr,gmii-to-sgmii-converter = <&gmii_to_sgmii_converter>;
> > -};
> > -- 
> > 2.35.3
> > 

