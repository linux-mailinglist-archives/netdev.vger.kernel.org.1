Return-Path: <netdev+bounces-217898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0956EB3A5E5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391755829F5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50042D24AC;
	Thu, 28 Aug 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calian.com header.i=@calian.com header.b="JihwzVbX"
X-Original-To: netdev@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022082.outbound.protection.outlook.com [40.107.193.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F36239E65;
	Thu, 28 Aug 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397645; cv=fail; b=WVwi+1EM3e3YDzrz/lPu50X6gHNyQJW1RP/5P6TE8Ii2H9/FgWKwbQrtFQGPeiNeYvr/t9zwD5HuXDEgG+9TaG5zbMOuXHXXeNRCny+Q4JrkW5+wLIQK+dGxJTNADIUhYmmGBixRnOxJlshfzdioVFNKX1C+0tbI57/s+gMo12g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397645; c=relaxed/simple;
	bh=tda6UtnUe7pQSfM+t9rHMS1jgROsXyZEeYYrkJagC6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q1qYkRtIGRMHjK0Z9fq7h1qDcx5mSrtARKofnHsSksyYPLjqsR9B/zcDoGgtw04S/R+e0T65HHBJCFunUx/q5pe03DoJxMW8LnwT3liBLpN70512AfI2frPIBY5QeUDe7biGdrtvY7SM0WOyMFeqJXPsbRJzqmJRQO/rpgBxGlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calian.com; spf=pass smtp.mailfrom=calian.com; dkim=pass (2048-bit key) header.d=calian.com header.i=@calian.com header.b=JihwzVbX; arc=fail smtp.client-ip=40.107.193.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calian.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE3L6F6UZWzl7dxnItoWv98ryY71H3Q7FPBpFFimtVUrW4SfA/YXJys472IkY8PH/omnnGDPamTPWntP9t9hSwsJwWg2n4YWwiVnqOQk403B0x3t7sXnou9Cf2CXkkGuGShwZx8e8+jOVObKcNktTbSS760zwifmQ5hN3G7+67o7Q4/3dkt7egWRgwezjnJChMmvJAMDrC5VG3ANnodcVW7GHXBbu+LiDQATZh//HFm2AE6/XIQ/sTwKZtNpcvHYzQu2/0oENHthuCyA+g4knUBmOlxV1rabI+1Pszf+RoSPHCDlp8J532oFIze9DpcN3mel9ovSj1LotawBM5Xolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tda6UtnUe7pQSfM+t9rHMS1jgROsXyZEeYYrkJagC6k=;
 b=BxRlAkANAJZ9X3JRHzZeR+/K1xcsY65Bfxzemlp2pidi5AvVV3fnMXutijbb9KLrs1dcjnBQyrAVd/7wAREIGVlHZf3M+bWzJBgcV06hANV5KK54t5oLnCx10ImQWBiOBfCcm/G4oX5G9QgEuob1svQDF3kCZdTBhtYHw5Mfn1KlHUfF0lIq39yuiySE6Kh97WA7qgGwZsdojabvdE/mwb1TkA20WXIJQYLWNKivd4POojUC3RZjVH1XRwRYZe8ERmUMzDb6M0fw6JPqOzjOikgS1Y5+/s4ifSRpsAuwH+JUyek4BOOMI1yMtEm+1ZVM7ZvHLvaGX7PxafsLlsU4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tda6UtnUe7pQSfM+t9rHMS1jgROsXyZEeYYrkJagC6k=;
 b=JihwzVbXdr4B2Mrrs7os6/pIdUE9l41TbmcigrseRxWSPrdpTdPfvw6xxza3/euxOnJ87i9+8c1TgwVaMUJf1IKYW1NPJAXxTa1zRcyhFPsD6xnWs9JeUO1EWHEqgRM5Fg4kogKSxBz8SuUBg/mEtOrT5AqwbI9KQttNMG/onHd6aWPRlT7B47jkZJ3L6J38CVGeCViRQsfZfOmAQ0ARnub94+v7mwbgnDgiVXuLeFJ5ZcqTGbSfa5ahNE+2R1evJwU1Rl6FwJ1x8Y99s1NG8m53z2T/tHGM30cQAqtWQZ0vlKXj5wURCM9vhUXljTvyqlkpQSGHQejjClNcOPWgEA==
Received: from YT2PR01MB4142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:36::10)
 by YQBPR0101MB5521.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Thu, 28 Aug
 2025 16:13:58 +0000
Received: from YT2PR01MB4142.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::adb8:6d4f:66a4:6d59]) by YT2PR01MB4142.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::adb8:6d4f:66a4:6d59%4]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 16:13:58 +0000
From: Robert Hancock <robert.hancock@calian.com>
To: "sean.anderson@linux.dev" <sean.anderson@linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
	"efault@gmx.de" <efault@gmx.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH] net: macb: Fix tx_ptr_lock locking
Thread-Topic: [PATCH] net: macb: Fix tx_ptr_lock locking
Thread-Index: AQHcGDTy7t4Q2cLRk0GsGZekSnPqZLR4PRgA
Date: Thu, 28 Aug 2025 16:13:58 +0000
Message-ID: <382f53239ff21a050089bcabb38d31329836ad98.camel@calian.com>
References: <20250828160023.1505762-1-sean.anderson@linux.dev>
In-Reply-To: <20250828160023.1505762-1-sean.anderson@linux.dev>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=calian.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB4142:EE_|YQBPR0101MB5521:EE_
x-ms-office365-filtering-correlation-id: 077a1681-eda2-4881-f658-08dde64de4fb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YW5yZDZFY0JCUjJwV1dKV0kzWHZyLzBKV0l2OVFsWUtXUjhtODMwaFMvb3dM?=
 =?utf-8?B?VWN2OVZ0Q1pLajJaVk5JYTk4eG02SXRHSlFMWCt6V01YakZjdnIyc3p5NXZH?=
 =?utf-8?B?ci9VWDVYaklXbXlMVmF2cmJOMS8xUUxtWVp3U21DZmJ3YXNpdTQ2dFdZSmZC?=
 =?utf-8?B?b2dsektjN1ZZNHBrYVc4WlVKdmt6cS9EbjhMQ3BUcTRTMG5YWEw1TDMwNFlH?=
 =?utf-8?B?dEthMCttOFVJL052UVBsUEdLaUE1N0tQV3kzazB5a0h3ekhtYmFVY095ejFH?=
 =?utf-8?B?TDBxTXR0K1N4ejJkaUVhVTlCN0tLSDAzWTZjWjMrWGdkMU9FQmdZaHlwYzhW?=
 =?utf-8?B?MllRK1ZhSjdjb3J5QWNKbXovMk1Va3R2WUtZcVBlREtoMlpNeDN2SmUvSmZy?=
 =?utf-8?B?bTFKYUVmbjkzOHZEQVhCYkttejI3NTBCRHVJdmd1ejZLOU5CRTJ4SGNiL29W?=
 =?utf-8?B?YkRmdEo3NEQrNndvVHJ3UjhXSXYwWnJWS3ZFMU9DblJkQmdYM0NFeEUrS253?=
 =?utf-8?B?QVBCTVFBRDUrT0tuREdVR3dFaitOQWZkb2RCWG9Fckk1OVFkbjQ4NzJEQW1l?=
 =?utf-8?B?NFJtZEVvMDdqKytENFN4QjNEN3VBbXUwMnFQNVMzTDBObzJUL2IreXVLZzh5?=
 =?utf-8?B?d283RVZrTk5JVmNRZ2NYQkhjNEVhWmNNd1ptei9kdVRBdGp1dnlXbFdGTVh3?=
 =?utf-8?B?SFZsMmdzaHgvYm5QSldORDAyM0NpemRUMXd4aVlURDVKQjA3VWZyOXBUWFpo?=
 =?utf-8?B?bzVNL0E1M09jN2hmYXhrN3JwenJTMWowQjg1TWpDRGdjRCtBMGVZekxiUytC?=
 =?utf-8?B?MzFaa04zVXRzKzdYU253bTBlc1I2L1hZNTcxNk9KemNUUDc1YlN1L2xzc1pR?=
 =?utf-8?B?UC9zQVZWUnptVmVvdmhqTEdNME5hcmtRdENaU0cxYjFlU2duNVJkOXIrTFFr?=
 =?utf-8?B?QU15T3VWdTBIc21qNTVqaXNSREYzZGJHOHM1YlI3dWF0ZWtXRzlacFdYZkUv?=
 =?utf-8?B?T2d3em85cDVISHJhMU9FZ2E2a00xczNjRTd4ZGUxNEY5bHB3aHdKUnNXNjM1?=
 =?utf-8?B?cmN3b2xxbWxJQVFMd2RIeDFhQzMvWTBmbXFBdjkvQU5LVndQQXVDc2dTWUFl?=
 =?utf-8?B?ZmNweDl4cU5CMjZuNGRuQ1NQbTgzbDlReUdTUjQvemV3aTJLZ2JiK2hCMHI0?=
 =?utf-8?B?QVQxSzRMeVFUdjRldlZzQ2VFZjd2Q04vTitWKzNhVVVudEg2UUhTcXV4ODNy?=
 =?utf-8?B?UXRodlE1YmpEUWEra3hIUDRtK0ZwYzhtV2ZIcXNiemNvVEhieEdWQ2hhWG12?=
 =?utf-8?B?ZUVtNFQ5eUM5YWtpa3QyTXlrZ2gvQUNiUy93NXJzNk9QTWdXREhSU01uUGsy?=
 =?utf-8?B?bzlicEhyS0V6QklUaGlhZk4xeEZtU3FwUTU4TGxOMXFUeHlQMTN3UXllcGtl?=
 =?utf-8?B?YW5iWDkxbGZraTU5Q01FZEpUQ3ZIVm1ESlR0UkJ1RC9ud2xkdFdmVW51SUNk?=
 =?utf-8?B?MTZLS0xNYnVMOHRyTERYWTJYN3RCOEFkdllaU1d1eXNqM2lrZ1g3WUY1WVZ0?=
 =?utf-8?B?LzczMTE2eWlMWFdZQlFEeFVCOXIwQUZ0RWpZUGozRUkxYUFsN0V3dHNCdCtX?=
 =?utf-8?B?V1lmQ1lzNVBvR1dyVXhtWVJNVk52a0RkSnl0MlRsMjJOQlVqVFEzKy9jakVz?=
 =?utf-8?B?TmJLR0orZFI4S1NNcjc0emVvZVZlUFg1bHN0WmxDd2Q1aUI5NWppczU4SmhP?=
 =?utf-8?B?VTNZckhZdEsrVEdHbHBVNlEzS0hWSUMxb0dKL1hoeFJoeXlMR2FIdmQycXhm?=
 =?utf-8?B?T3VWRHhwUDVUQTlaYlZmRVREdVQvTU9GT0E2ZUhIUjdibC9jaXY0ZTM2RXJm?=
 =?utf-8?B?R1h3TGNPMXg0aFVCS1NsdFE4WEFVR0luQmpHWVFva2MxNTBEWjl3L0tiOG1I?=
 =?utf-8?B?MzZzYUlkQlNBbWFhUkdIVVNyZGdkcTVlOWx5elRQcng0OWVnL1pzdGdxSlQ4?=
 =?utf-8?B?RjEvZXRJd3dHMmRHaS9zRUtVZlNyYlVsSDhUWTFtZHAvQmZNdDljVnl3eGh1?=
 =?utf-8?B?S3hjYTZVM1NPd2Yyd1JUMGJuaDg3NTBnMERFTVVDTUwrK0Jvd2taSzRvclha?=
 =?utf-8?B?VWxMNFF5SFNvVUtGak1DSzNIRm1aUFJnVXpEcmtJcGRoeUhxQzBCUjBvd0Nu?=
 =?utf-8?B?WnlFYTE1TktZUUc1YTltczUrMU50Z1RRN2hoY0VoRjRrb29WZFYrdTg2SEgr?=
 =?utf-8?B?MkUxWVJLZXlhZE92ajlWSXZtMGxRTUJqbUFhZXVqM0dOSHpQbDJyYTk5RVM4?=
 =?utf-8?B?NnhBL24vWmpIK0pzRnkvN2JsdlIrYnJBQUxzRi9DVmhUVFo2bEgrQ1lUYW9P?=
 =?utf-8?Q?pQtYu8ivBqg5XkeQxK/1mO+0ddh9KOTS433XI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB4142.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dno1NkF0N0tyNEpvVWJQSW9JTjVNdTY2aGFNNHdPVlpab2ZzelJ1Q0ZXYUNm?=
 =?utf-8?B?aWFHeHhKUTJINXRVY2lDc1ZiNkRWUWFKcU5pdVdaWFptZGVvVkQwYkJKR1Vh?=
 =?utf-8?B?UHBqMmdvcXhJZTJCVEFWNlEyQlNsZ3J4T2ZPRWd3SDRvck5veTBzNjBHcWVh?=
 =?utf-8?B?MVpSYnNEN0VyZTRtUzhwZUl0UE5PTi9kbHNFVldRL2dObElUejFLNktXREpl?=
 =?utf-8?B?bVErVXkzaWVGSWRHc0VYNzZORGxUMEI2SU5MbjJ2anp2V2REeTFheU9qN0ZD?=
 =?utf-8?B?bWduL05mT1lWTy9sMDQ0bHhnaTZPcVVxNiszRk16ZndhR004Y1R5YVlJbHBL?=
 =?utf-8?B?WDhEd0lPanZuODFHZE5hR2ZWWEZKb3pCczQrdkVPZ0pwUUd0TlkwU1ZqbEtW?=
 =?utf-8?B?anpsK1dFcCt0SW43YmRWWXEzNEppTHIxNnl4QmgwamRENkF0K2l0bnBaLy92?=
 =?utf-8?B?MkhsOTlMZFBCYmoxOFc3SVRCeFFjM0hZRlUvWFoyclc4WWk2UzVQTGxlRVJT?=
 =?utf-8?B?ZVl1d1grSldPTnpMZTAyelZ5RFNpb1crUVpFSU5xanB1MkxITFUvQWNTTWZO?=
 =?utf-8?B?ai9CVk1ibXBiQnlaRU5PVmY2ZElUYXNFaEMzclpCWUZZdlV2ZzJCZ1VaVnlL?=
 =?utf-8?B?eXRvS1oyQ3ZiUndKU1J6MkFsNlhsbUYvMjRXaU1qN2Q4TWRqUVZUY0ZwUXBW?=
 =?utf-8?B?YTlEWWt3RS9zZlRPRk84MnNhbG93bnQvVm5tVThJRFZiUXp4a2JDY25nZm0r?=
 =?utf-8?B?Q2FUSlFMbTZya1pQa0ErbkcyeUxEWEcycXAyWWFYcHpYM210ZHZkWmo2VGlk?=
 =?utf-8?B?YzlwZkM0Zm9GdjlEelNwejdEak5IM21zYkN4SHFEalkra1I4blFLWDNmNmpK?=
 =?utf-8?B?UjNQY1cwcnZYUjg4KzlLTExiT2p5TlkzV3JoWTYzWUVQV2I5RzROTVVqNUdv?=
 =?utf-8?B?SXZPam5IYnpmb2x4SmJPZnFJbmpubURpT08zUlVRTGw4M0NVTWJScWRiWmM3?=
 =?utf-8?B?WXhOUVZBdGlEa0RzK2loVlZBL2JlZnFRRDRybEhaL0haMmNnMDhWM3pNQVlH?=
 =?utf-8?B?Y0lBOXNzKzBvM3g4MzJDaW1CZEJ0OGV5dWlLaWU1eEZIY0NsY1lRaWZrMFNU?=
 =?utf-8?B?K0hPU29oYnJ4NzBuL2JZVzFjSnFMM1NDSDkzV0t0K0Q2dCszNTZkU3FuVXp2?=
 =?utf-8?B?dlZxYUdtWVFKL0xyRDRtK29xUFZIbnNpMWZvK25CcjQwbDVWNG5JdGVwS1Bj?=
 =?utf-8?B?enNTbXcwbXkzcldsUEJ4czcvODdWd2RHNVpaaTh0eDNRY2sxUnBLZEY5WW4v?=
 =?utf-8?B?K1M2bkhVMWVBVnZ2YzJuaHVXbndiMlBTODFhYlZSMGxTejBkOGFtUDZUNVVC?=
 =?utf-8?B?S2J2cks3R21RRDh2YUV4Ly9oaGJJWWxjY0UzYU5EQzEvNlFuQWxQYzJzWTlS?=
 =?utf-8?B?cENLNldGZHFKNDFzNXBldnp2TWw5MGhBaGxrK3FXalZ6MVpoTDk3c21xSHd0?=
 =?utf-8?B?K1EzTW9iL044YVdjM1lUT0s4b3VQZUEvWm1YYk9xMVZWV3hXY1lUMlZpVE5E?=
 =?utf-8?B?N2tVVVhIVnZGTVZzTjRRa1dpcDNQTi9xSXFhbFdHMmFDRUpnUHNlUzE1a2xn?=
 =?utf-8?B?dW5OQWtER0xVQURsR3pST2xIZk1tNTVHVWc4ZlNaK3JPbXNOek1BYjRMVDht?=
 =?utf-8?B?aDR6bmY1Ym9GS09FYmFmWnhZRjZHTWNiblpBRjBXdGpVUzBWUkRmTkZBUUVJ?=
 =?utf-8?B?UzZ0SGVKckxKS2I5V0NkVWRXTWdDaEtXTkl0QzRLb3NGbUVjRGwrVlM2N2hO?=
 =?utf-8?B?UnBzWEd3MmdkN2ZwazZSSXN4M2RDYXFUQ3dLUkF3VWNtRDFZZHlBeFYrSGpX?=
 =?utf-8?B?ZHlxNk8wVnNTeW9CT3VPYVBUekN4ektHVm1kdWZVRHVWbk85ZlZXL2g2Nzdk?=
 =?utf-8?B?ODZ1R2d0Z2NGUHNkaW1XT3JveEIvczdYNDJWQ0RMem5JSElUMFluRlJnRVBH?=
 =?utf-8?B?M25NNVpxSEx1b05zUlN1M2tpTmNyRko4cUp4LysycFU5aUZTd25QbXRHRDJ2?=
 =?utf-8?B?NlhaWnlLOGxMTVlOYVJMVzJESklPdG1Va01lekV3My9ZUktpRG0zTnNCWVpN?=
 =?utf-8?B?Yy9jcUE0YWhKdHdrRk5QMVJNNE5QWXRlcGtMWUJqejJqNmd1WEdxaHl0alkr?=
 =?utf-8?B?ellMRXJEcVBlZUVyMGNuNDFpcDdTSm5zQythaXJyRGJiVHRKUFZ2ZmFXbFJT?=
 =?utf-8?B?bTFySjZTTnZjSm5JbzZrVDZQbHdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E39BD0BC7BBE149BE955F9B487A1E33@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB4142.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 077a1681-eda2-4881-f658-08dde64de4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 16:13:58.5030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wQ7GnV1kIXVJ9S5bpSaZTBDXoOUsHzpu9NAD0EmKYiPulZHeFYq+smeom3PAysALtlcvSYLiWojiJri3Rd2+FCXMEl0arlnV3AI309aeo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5521

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDEyOjAwIC0wNDAwLCBTZWFuIEFuZGVyc29uIHdyb3RlOgo+
IG1hY2Jfc3RhcnRfeG1pdCBjYW4gYmUgY2FsbGVkIHdpdGggYm90dG9tLWhhbHZlcyBkaXNhYmxl
ZCAoZS5nLgo+IHRyYW5zbWl0dGluZyBmcm9tIHNvZnRpcnFzKSBhcyB3ZWxsIGFzIHdpdGggaW50
ZXJydXB0cyBkaXNhYmxlZCAod2l0aAo+IG5ldHBvbGwpLiBCZWNhdXNlIG9mIHRoaXMsIGFsbCBv
dGhlciBmdW5jdGlvbnMgdGFraW5nIHR4X3B0cl9sb2NrCj4gbXVzdAo+IGRpc2FibGUgSVJRcywg
YW5kIG1hY2Jfc3RhcnRfeG1pdCBtdXN0IG9ubHkgcmUtZW5hYmxlIElSUXMgaWYgdGhleQo+IHdl
cmUgYWxyZWFkeSBlbmFibGVkLgo+IAo+IEZpeGVzOiAxMzhiYWRiYzIxYTAgKCJuZXQ6IG1hY2I6
IHVzZSBOQVBJIGZvciBUWCBjb21wbGV0aW9uIHBhdGgiKQo+IFJlcG9ydGVkLWJ5OiBNaWtlIEdh
bGJyYWl0aCA8ZWZhdWx0QGdteC5kZT4KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxz
ZWFuLmFuZGVyc29uQGxpbnV4LmRldj4KPiAtLS0KPiAKPiDCoGRyaXZlcnMvbmV0L2V0aGVybmV0
L2NhZGVuY2UvbWFjYl9tYWluLmMgfCAyNSArKysrKysrKysrKystLS0tLS0tLS0tCj4gLS0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYwo+IGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYwo+IGluZGV4IDE2ZDI4YThi
M2I1Ni4uYjBhOGRmYTM0MWVhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Nh
ZGVuY2UvbWFjYl9tYWluLmMKPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21h
Y2JfbWFpbi5jCj4gQEAgLTEyMjgsNyArMTIyOCw3IEBAIHN0YXRpYyBpbnQgbWFjYl90eF9jb21w
bGV0ZShzdHJ1Y3QgbWFjYl9xdWV1ZQo+ICpxdWV1ZSwgaW50IGJ1ZGdldCkKPiDCoMKgwqDCoMKg
wqDCoCBpbnQgcGFja2V0cyA9IDA7Cj4gwqDCoMKgwqDCoMKgwqAgdTMyIGJ5dGVzID0gMDsKPiAK
PiAtwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmcXVldWUtPnR4X3B0cl9sb2NrKTsKPiArwqDCoMKg
wqDCoMKgIHNwaW5fbG9ja19pcnEoJnF1ZXVlLT50eF9wdHJfbG9jayk7Cj4gCgpIbSwgSSB0aGlu
ayBJIHVzZWQgYSBub24tSVJRIGxvY2sgaGVyZSB0byBhdm9pZCBwb3RlbnRpYWxseSBkaXNhYmxp
bmcKaW50ZXJydXB0cyBmb3Igc28gbG9uZyBkdXJpbmcgVFggY29tcGxldGlvbiBwcm9jZXNzaW5n
LiBJIGRvbid0IHRoaW5rIEkKY29uc2lkZXJlZCB0aGUgbmV0cG9sbCBjYXNlIHdoZXJlIHN0YXJ0
X3htaXQgY2FuIGJlIGNhbGxlZCB3aXRoIElSUXMKZGlzYWJsZWQgaG93ZXZlci4gTm90IHN1cmUg
aWYgdGhlcmUgaXMgYSBiZXR0ZXIgc29sdXRpb24gdG8gc2F0aXNmeQp0aGF0IGNhc2Ugd2l0aG91
dCB0dXJuaW5nIElSUXMgb2ZmIGVudGlyZWx5IGhlcmU/Cgo+IMKgwqDCoMKgwqDCoMKgIGhlYWQg
PSBxdWV1ZS0+dHhfaGVhZDsKPiDCoMKgwqDCoMKgwqDCoCBmb3IgKHRhaWwgPSBxdWV1ZS0+dHhf
dGFpbDsgdGFpbCAhPSBoZWFkICYmIHBhY2tldHMgPCBidWRnZXQ7Cj4gdGFpbCsrKSB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBtYWNiX3R4X3NrYsKgwqDCoMKgwqAg
KnR4X3NrYjsKPiBAQCAtMTI5MSw3ICsxMjkxLDcgQEAgc3RhdGljIGludCBtYWNiX3R4X2NvbXBs
ZXRlKHN0cnVjdCBtYWNiX3F1ZXVlCj4gKnF1ZXVlLCBpbnQgYnVkZ2V0KQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQ0lSQ19DTlQocXVldWUtPnR4X2hlYWQsIHF1ZXVlLT50eF90YWlsLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnAtPnR4X3Jpbmdfc2l6ZSkg
PD0gTUFDQl9UWF9XQUtFVVBfVEhSRVNIKGJwKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbmV0aWZfd2FrZV9zdWJxdWV1ZShicC0+ZGV2LCBxdWV1ZV9pbmRleCk7Cj4gLcKgwqDC
oMKgwqDCoCBzcGluX3VubG9jaygmcXVldWUtPnR4X3B0cl9sb2NrKTsKPiArwqDCoMKgwqDCoMKg
IHNwaW5fdW5sb2NrX2lycSgmcXVldWUtPnR4X3B0cl9sb2NrKTsKPiAKPiDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gcGFja2V0czsKPiDCoH0KPiBAQCAtMTcwOCw3ICsxNzA4LDcgQEAgc3RhdGljIHZv
aWQgbWFjYl90eF9yZXN0YXJ0KHN0cnVjdCBtYWNiX3F1ZXVlCj4gKnF1ZXVlKQo+IMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBtYWNiICpicCA9IHF1ZXVlLT5icDsKPiDCoMKgwqDCoMKgwqDCoCB1bnNp
Z25lZCBpbnQgaGVhZF9pZHgsIHRicXA7Cj4gCj4gLcKgwqDCoMKgwqDCoCBzcGluX2xvY2soJnF1
ZXVlLT50eF9wdHJfbG9jayk7Cj4gK8KgwqDCoMKgwqDCoCBzcGluX2xvY2tfaXJxKCZxdWV1ZS0+
dHhfcHRyX2xvY2spOwo+IAo+IMKgwqDCoMKgwqDCoMKgIGlmIChxdWV1ZS0+dHhfaGVhZCA9PSBx
dWV1ZS0+dHhfdGFpbCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRf
dHhfcHRyX3VubG9jazsKPiBAQCAtMTcyMCwxOSArMTcyMCwxOSBAQCBzdGF0aWMgdm9pZCBtYWNi
X3R4X3Jlc3RhcnQoc3RydWN0IG1hY2JfcXVldWUKPiAqcXVldWUpCj4gwqDCoMKgwqDCoMKgwqAg
aWYgKHRicXAgPT0gaGVhZF9pZHgpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdv
dG8gb3V0X3R4X3B0cl91bmxvY2s7Cj4gCj4gLcKgwqDCoMKgwqDCoCBzcGluX2xvY2tfaXJxKCZi
cC0+bG9jayk7Cj4gK8KgwqDCoMKgwqDCoCBzcGluX2xvY2soJmJwLT5sb2NrKTsKPiDCoMKgwqDC
oMKgwqDCoCBtYWNiX3dyaXRlbChicCwgTkNSLCBtYWNiX3JlYWRsKGJwLCBOQ1IpIHwgTUFDQl9C
SVQoVFNUQVJUKSk7Cj4gLcKgwqDCoMKgwqDCoCBzcGluX3VubG9ja19pcnEoJmJwLT5sb2NrKTsK
PiArwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZicC0+bG9jayk7Cj4gCj4gwqBvdXRfdHhfcHRy
X3VubG9jazoKPiAtwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZxdWV1ZS0+dHhfcHRyX2xvY2sp
Owo+ICvCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2tfaXJxKCZxdWV1ZS0+dHhfcHRyX2xvY2spOwo+
IMKgfQo+IAo+IMKgc3RhdGljIGJvb2wgbWFjYl90eF9jb21wbGV0ZV9wZW5kaW5nKHN0cnVjdCBt
YWNiX3F1ZXVlICpxdWV1ZSkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoCBib29sIHJldHZhbCA9IGZh
bHNlOwo+IAo+IC3CoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZxdWV1ZS0+dHhfcHRyX2xvY2spOwo+
ICvCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2lycSgmcXVldWUtPnR4X3B0cl9sb2NrKTsKPiDCoMKg
wqDCoMKgwqDCoCBpZiAocXVldWUtPnR4X2hlYWQgIT0gcXVldWUtPnR4X3RhaWwpIHsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogTWFrZSBodyBkZXNjcmlwdG9yIHVwZGF0ZXMg
dmlzaWJsZSB0byBDUFUgKi8KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcm1iKCk7
Cj4gQEAgLTE3NDAsNyArMTc0MCw3IEBAIHN0YXRpYyBib29sIG1hY2JfdHhfY29tcGxldGVfcGVu
ZGluZyhzdHJ1Y3QKPiBtYWNiX3F1ZXVlICpxdWV1ZSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKG1hY2JfdHhfZGVzYyhxdWV1ZSwgcXVldWUtPnR4X3RhaWwpLT5jdHJsICYK
PiBNQUNCX0JJVChUWF9VU0VEKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHZhbCA9IHRydWU7Cj4gwqDCoMKgwqDCoMKgwqAgfQo+IC3CoMKgwqDC
oMKgwqAgc3Bpbl91bmxvY2soJnF1ZXVlLT50eF9wdHJfbG9jayk7Cj4gK8KgwqDCoMKgwqDCoCBz
cGluX3VubG9ja19pcnEoJnF1ZXVlLT50eF9wdHJfbG9jayk7Cj4gwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIHJldHZhbDsKPiDCoH0KPiAKPiBAQCAtMjMwOCw2ICsyMzA4LDcgQEAgc3RhdGljIG5ldGRl
dl90eF90IG1hY2Jfc3RhcnRfeG1pdChzdHJ1Y3QKPiBza19idWZmICpza2IsIHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYpCj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1hY2JfcXVldWUgKnF1ZXVlID0g
JmJwLT5xdWV1ZXNbcXVldWVfaW5kZXhdOwo+IMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBk
ZXNjX2NudCwgbnJfZnJhZ3MsIGZyYWdfc2l6ZSwgZjsKPiDCoMKgwqDCoMKgwqDCoCB1bnNpZ25l
ZCBpbnQgaGRybGVuOwo+ICvCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFnczsKPiDCoMKg
wqDCoMKgwqDCoCBib29sIGlzX2xzbzsKPiDCoMKgwqDCoMKgwqDCoCBuZXRkZXZfdHhfdCByZXQg
PSBORVRERVZfVFhfT0s7Cj4gCj4gQEAgLTIzNjgsNyArMjM2OSw3IEBAIHN0YXRpYyBuZXRkZXZf
dHhfdCBtYWNiX3N0YXJ0X3htaXQoc3RydWN0Cj4gc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXNjX2NudCArPSBE
SVZfUk9VTkRfVVAoZnJhZ19zaXplLCBicC0KPiA+bWF4X3R4X2xlbmd0aCk7Cj4gwqDCoMKgwqDC
oMKgwqAgfQo+IAo+IC3CoMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2JoKCZxdWV1ZS0+dHhfcHRyX2xv
Y2spOwo+ICvCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJnF1ZXVlLT50eF9wdHJfbG9j
aywgZmxhZ3MpOwo+IAo+IMKgwqDCoMKgwqDCoMKgIC8qIFRoaXMgaXMgYSBoYXJkIGVycm9yLCBs
b2cgaXQuICovCj4gwqDCoMKgwqDCoMKgwqAgaWYgKENJUkNfU1BBQ0UocXVldWUtPnR4X2hlYWQs
IHF1ZXVlLT50eF90YWlsLAo+IEBAIC0yMzkyLDE1ICsyMzkzLDE1IEBAIHN0YXRpYyBuZXRkZXZf
dHhfdCBtYWNiX3N0YXJ0X3htaXQoc3RydWN0Cj4gc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KQo+IMKgwqDCoMKgwqDCoMKgIG5ldGRldl90eF9zZW50X3F1ZXVlKG5ldGRldl9n
ZXRfdHhfcXVldWUoYnAtPmRldiwKPiBxdWV1ZV9pbmRleCksCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2tiLT5sZW4pOwo+IAo+IC3C
oMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2lycSgmYnAtPmxvY2spOwo+ICvCoMKgwqDCoMKgwqAgc3Bp
bl9sb2NrKCZicC0+bG9jayk7Cj4gwqDCoMKgwqDCoMKgwqAgbWFjYl93cml0ZWwoYnAsIE5DUiwg
bWFjYl9yZWFkbChicCwgTkNSKSB8IE1BQ0JfQklUKFRTVEFSVCkpOwo+IC3CoMKgwqDCoMKgwqAg
c3Bpbl91bmxvY2tfaXJxKCZicC0+bG9jayk7Cj4gK8KgwqDCoMKgwqDCoCBzcGluX3VubG9jaygm
YnAtPmxvY2spOwo+IAo+IMKgwqDCoMKgwqDCoMKgIGlmIChDSVJDX1NQQUNFKHF1ZXVlLT50eF9o
ZWFkLCBxdWV1ZS0+dHhfdGFpbCwgYnAtCj4gPnR4X3Jpbmdfc2l6ZSkgPCAxKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXRpZl9zdG9wX3N1YnF1ZXVlKGRldiwgcXVldWVfaW5k
ZXgpOwo+IAo+IMKgdW5sb2NrOgo+IC3CoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2tfYmgoJnF1ZXVl
LT50eF9wdHJfbG9jayk7Cj4gK8KgwqDCoMKgwqDCoCBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZx
dWV1ZS0+dHhfcHRyX2xvY2ssIGZsYWdzKTsKPiAKPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0
Owo+IMKgfQo+IC0tCj4gMi4zNS4xLjEzMjAuZ2M0NTI2OTUzODcuZGlydHkKPiAKCg==

