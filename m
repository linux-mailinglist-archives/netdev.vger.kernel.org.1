Return-Path: <netdev+bounces-111721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C869323D7
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87775B214B6
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0582A1E894;
	Tue, 16 Jul 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="btMX/CbO"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD3EED8;
	Tue, 16 Jul 2024 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125373; cv=fail; b=A0PRDIT+6TjB01drQBYg5w2mM1se/vEBnO7BvDPX3HYrHAK3qRQfmK8JQy4JJpcYLpx95af8vRQGsaWG8v6qCWg4M2nDFkL/DgrA4SJhwVqIe9j2LlOIEB8zpI2NdYB7r+Pcu26XJkwUeuf//R/w2Ql9pgSozDEznLv4dVitPnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125373; c=relaxed/simple;
	bh=s5m3WCGGOrIK3HwBsri2aNe112ORDiwGLN6QwPgYcgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qs6vb7BX2iIEuIPaVDwHTuhPZ5jIoGlihjbOfnl0I5GPro/tGsVZO/kfJpOdFBK+kw4uR9MdOor01YZNYACn/5hYcYki/Uux38lcRx51Rk5eHp5P2JDsrZf3JYygEJQv7PxIF0P2ce52PshXH4fNaw4JsJ6wBOzHV6nmmwtSOMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=btMX/CbO; arc=fail smtp.client-ip=40.107.255.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnjnBXq5YCQJQvMtbh+rePloEG2XcGFVPgHoTyDtxQmYMzfibnBbCgZSiFiTJthEfCVliCqcSBgbs+3TbsYhu5VKmT7lS3r6aiEvSnUlq95JERIat3NN7aTY7k+1BlrS/dPKtzU6UAkLfrvUyDr3I9C20dDFhmGf+///v8NjG9NOCUkh9V/Qm7yGbK7/EnjPh4L0WP/lxqZJbHw/w+cOXeVy3mScjF7RV185hD/Jrj3JGL3lDA1v9cHGqitrsxpZAXuOqHMK/QAwKvXOBiBzan5qKKIZ/m8TPDIkZ46yXsUehPEEOMl4CRkNCcD5wScV0km0LlO7znEUKQKhlZC25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0irhWYJMHgEWi4i8jj88holb166JthjFqDZskjYpLFs=;
 b=b9YIRe06R9OBNlI8CxrGF2SheMYZhsmo0oCLj2UZBwL2E+2dcjhs8e6KL7bQ+rHXibw5LNLoBpq+DZ9XBxCelHjZ44U7heSQ1Wg779Zza1jIdnpRoFkkQxv0Kb2s09J3niu4riNhvchFtYmTxI2vuwBx9yE0zc4xgUomcRGPZB0pmSZ+J7uhEt+kf0I1rvmjrVfo3vOSg5blXXyRLmJVuqQFlMnzY5vz8tQY5omJozMYcM0+TrcmahRh2V+tij5j9oZy194pLtuU6nZerIaSqnDjtKzC7KNLZkNVSpi0VIiumV3WIQuc4ywweAKGKMDtEnUwKMQU92RGIJ9CUY6KzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0irhWYJMHgEWi4i8jj88holb166JthjFqDZskjYpLFs=;
 b=btMX/CbOB6nkb2rnwxn+tjBDN32UaK9dnUAHH31qKfyOupTMXXpoomI9fB9utykytkUMCTCgwdLK5m/oH5kgpa7iqt0rsXNAXSz59SD93qoON2JpIaBYPSQreq04agpNnoxelDka+35Vsz3TE5Ht3Wqm6kcirXPQaRaByvNAn0zU2e6+cbd6FAaUkSk3X8dCPI2Kj4mSSTED7k3UkErVKpTWndjAjpaVwMBbwS8Mp2DHyR9UhI7oJ3ILX6kaGi7JECQHaeZyrEk+FHHAXNy42mUE+D3Gp0O5odTMu5aitoL3KpFw3ZXZryX5LVYkJaI02v31s5ocTo7bCtXU2/7c2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by TYZPR03MB7576.apcprd03.prod.outlook.com (2603:1096:400:427::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Tue, 16 Jul
 2024 10:22:49 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732%7]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 10:22:48 +0000
Message-ID: <32a452ea-6213-4de4-859e-cb6404710da4@amlogic.com>
Date: Tue, 16 Jul 2024 18:22:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Add support for Amlogic HCI UART
Content-Language: en-US
To: Yang Li <yang.li@amlogic.com>, xianwei.zhao@amlogic.com, ye.he@amlogic.com
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240716064346.3538994-1-yang.li@amlogic.com>
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <20240716064346.3538994-1-yang.li@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|TYZPR03MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: d1731521-86cc-412a-cec7-08dca5813dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU5mcUFnek84YnpsSmRSVDlEcUl3aVRGZEh4OFVkTTNVMFR4REpkUkcxMXVF?=
 =?utf-8?B?aUxLMlNNMnJyWk5WeWlCQWtxTG5vL3Nya1RCYTV6a1N3dzZzSlBNZXo1NS9T?=
 =?utf-8?B?UGhwcEVGN1o5MXdtcTRRRXI1ak1BVkNlWWt0RmxoK29ETlVYcktRWE1JWExm?=
 =?utf-8?B?RWxGUmZNRCt6NnZjaFJieU9ieUppd1A1eEZCSE5XL25vS1pEWTRMd3dVNExZ?=
 =?utf-8?B?bDVPaUJJMHRsWkFjK3RieERiQjYxdkRmRldUdlAxOHhGK3Rvalk0Y3Y5WWtw?=
 =?utf-8?B?T2xJSXFKU0NCR1h6alFUMUMzYW5EL3VrWnVGOWdDR055SnE1Vkk3RlhJYmha?=
 =?utf-8?B?alowdlpTak9KYjBQbDFMVnEwZWV3SFV5UU8rcnFuZTVkbVBjMDBDRWpPV2t0?=
 =?utf-8?B?N2FrT2ZoVU1wSkswZHI0Q1l6N0s4VkxBUUlTOWNOMEJoQzF2WUlyOGZXK2V3?=
 =?utf-8?B?RmNHSE9zUVREL0NwZDVqQllQRWorNm52cGhLdXNSbkdiQ25MZ3ZDODA5U1JJ?=
 =?utf-8?B?NGsyTjhPRURibW43bWFaR1JtUE9iTlN1MU9LTDBYVmVMMGhpWVJObUJFa0VH?=
 =?utf-8?B?eCtZWWhzNkN2YnRERFBpWDNJWnVVWW5lcnlqakV5VHdqbm9oRjlwRFF5eGp4?=
 =?utf-8?B?UmRhbDk3MVdRdWt3YjdOSnk0Ylp3R1JJVW9EeHBvaVU4U0Qvc2dReHB3Qzcw?=
 =?utf-8?B?RUY4R1hXTlJOYmJBcDF4QmpDY0E0WGhDUGJLRzlpNjkxS0hqeFpzbUFvSGhH?=
 =?utf-8?B?SlpJQ2szcUtlSDBVWG5tSlpoZFVCckJZdzJVV2lySk9qSE1DR1FVMEQrSFlT?=
 =?utf-8?B?L3lRMXltS2lQcUtnb2FlNU1JNUJwRFY1TEpPenlQL20vZ2tiNmQ0NnRVdjRY?=
 =?utf-8?B?QU1VNERXRkRmVUFsVGJOM3hFZ1B4UjdVR25vdUtTekdJbVQrTmpoVVVvY1V4?=
 =?utf-8?B?UzRFRTg1cEtlQ3JlUm9wQlpiTlVscmRzbmpyRHZHOFpqWnFOQklMU0xwQXhO?=
 =?utf-8?B?Y2pBVDVTYnZaOGEzbW5qNzhaSTVBNWZqN3RqaDZkSU9KZTVuZ0JCSUlCdjRP?=
 =?utf-8?B?a01GdXEwVUxSZUZrMW9LOTl5Q1QyZ0tISkViVHhKdUhlNnlsbWtXb1lsYlJF?=
 =?utf-8?B?SkYrNDVuejEvODMxeFhjUjhRWFRJMHRycmpkYTVPeGpIVUxhcDZuRUY0VWc1?=
 =?utf-8?B?RVVqMEI0OTVFZUxJVzBrQnJLUXhBVUNJbkNOMzRxWFpxTm5VdmQrb1V0TXlu?=
 =?utf-8?B?MExRUDVSUTdzaGZsc1MzeFhQSE9yVmZVRlIrMmlxNmNCTnloQXhtRXUvc2Yv?=
 =?utf-8?B?N2VjcjQ5R2xkSWduK1N2dUJkajdFWmFRZFloNzBkWUVhb2pWY3J1WjhiWnBB?=
 =?utf-8?B?MFN1aXZGYXVOQVQ5OGE2RjRUV0JMWUNrUEVSUmJjSkVsVjFNSFZqbVc0eXdL?=
 =?utf-8?B?K3FnYmk1TktFNXNrLzZ4NEtzZWI5SHMwQUF6WEFoM1hscDg0azZtRElVcExL?=
 =?utf-8?B?VXlpOUhlTysvdHFqL29BVlI5d3dnZVZqZmJrNEI5MmRlN0J3TDQySlFudXhO?=
 =?utf-8?B?M1dqdklIQi9kb2w5UmMxdnZqRVcyUTd3c3NUbzhLeHltZkZucGh2ZzRNRW9y?=
 =?utf-8?B?SkFKWWcwWDd4WXNOdEcvTURxckZKckZLNUZDM1A1anZYSTBGOEl3YjhFc3Np?=
 =?utf-8?B?RnRzdXRUUTVsaFAyS2tFTVd4SnpBckF1R3dLYUVwNnAzNW44bCtIM04wc3Mz?=
 =?utf-8?Q?qdf6pCpIrh+//AyYf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWZDL0lscm01UFp3Ui8waE81by90QVVEQUFMWm4vK1JsLzBoY0tWcklUbTNC?=
 =?utf-8?B?NGRrN3Y0WE5NM1hDcjFKaFhpSWc4dHJOZDh2ZHMySHZJNTNNZ0YwL3FSdGt1?=
 =?utf-8?B?WDF5Ymo4Tit0NzVOclY2cnJsdCtyV3JYODBQazNmSlZWYTA1N01UUGI1U1d1?=
 =?utf-8?B?RzQ3T2NJaENteC81UnUweHZmeGp4cnJnc3FobFpZYlFrcUdna1dDeFphNDFO?=
 =?utf-8?B?MS9xM1oyRExlTzdqekpLMFNHelNHZVBtdFM3SXk5QjJhSStHZVpvQ0JrMVlD?=
 =?utf-8?B?QXNQQ3g5cUZTcTFIdThCYm8zUE1UZVRDakJwcXU5Unl2d0Y3Vzg2NXVMYUpz?=
 =?utf-8?B?QVZOUmZodzUvcy9MdG5jSUU1SGR0OGpqeUwwbFAxSmk4Rmt2LzJpN2dTUDFY?=
 =?utf-8?B?RGllSHFGVktvUXgycklYb05EcFVhZDZkRDlvdDJwN3Q3SHRYSTAwTGpDelZG?=
 =?utf-8?B?b20vTnhnaStPajZoVXlmUVdEbVhGTURsdjdJODdGVTVRWG5zRXR2d295Z0hi?=
 =?utf-8?B?ZU9jQ1NMUEZlNGVubDZCRHI3Q1BaUDdxc0JMUUJLZGpYT1A5bE00NWpwS2hs?=
 =?utf-8?B?ZHJUckc0a1lGV0RTN1dtSFlUS1cwQjZFSkxoZzJVQUtQNWdINkxmWGNRMGlD?=
 =?utf-8?B?QldXaVNJUXJPeDhEcEg3ODY0Q1gwNS8zUG1NKy9sTGFGd09vUnh4Z2d3bEho?=
 =?utf-8?B?dHhNVkRaWElIWUNYRHlPeHBnTVFKdWx5b3ZybDhsck1UOXV5cmFrQWtLS3d1?=
 =?utf-8?B?Vy8wQjNjVU94azBNL1VVd3B5Q1RSZElpZlVPV0swVWNpakFpNW5LM2lMRjhJ?=
 =?utf-8?B?VVJWZFpObVczUmliSm5xZUFBaE1lbVY5R2tQVGFyVERHSHpjTnJNY2tTOTNM?=
 =?utf-8?B?NVViQ0N1U2NvMlN4WThTZ09TczE2UnBsY2tnMDhjenJmRzdsY2s0RHVKc3l6?=
 =?utf-8?B?aEhUV2pyb0ZHODF5REh6ZnlEd1RGOExkenF2UitRa3UrMDZvbG1uU0JGMHF3?=
 =?utf-8?B?Y1JUMDFUejZUbkNBcWhhSHB2TEhNakx0Z0Z3QVY5T1V5dytHSXE1U295S0NG?=
 =?utf-8?B?SzlJcm5ENHlkSW44VjBCZzA4NG00T1E5dnl3U2dHZTZZZjhQdDdLaXc1K1BZ?=
 =?utf-8?B?YWRIVjl4WXJOTTVkV1BwbkdrMzVOdVhCVXVyS0pKVkJoUjAzSjNQQlRJWkFk?=
 =?utf-8?B?UFNpelFmRjVPNExzdElNWWVmbjhjdmdMNFdhS0c1eFpBdTlibUVacUNkNjBF?=
 =?utf-8?B?Yk8zSjUzYmhyREMxc2pGQjJjQ1BDVlVrSHNTYzFVS1VHZVlJM2J5VVdIMEw0?=
 =?utf-8?B?N0RZaUtCNTRxcytTWXRBUHcyM1VPb2ROby9aVjdudnlkWHNzWFdvRHNiMS9M?=
 =?utf-8?B?SkpIVDNrNjNPdnNOWW9kc0VGa3V2VGdoMVFqYURmZzhaOTRKaXNKRFA3S0xN?=
 =?utf-8?B?NmVNQzY4ZHBUL0RKZlZjWUhPdjVucG9TNmttWWFTRk9ud3kzQWNKd3JzK255?=
 =?utf-8?B?YlVOMFJ4QlBrcHFKcVpZbmcxV2Y1UnpCQnIvb3ozdmZGWlAvckJUbG5xRFl3?=
 =?utf-8?B?NjBWUjZQMVVVMlp3TC8zNVpDZDdDMGF6cmQvZ0F4YWVxWDNpd0NPbTJ1Yk9H?=
 =?utf-8?B?NFFRUzVQVVlPSy8vSFJ3d0ZIRjNVd2NsYUVURUtyc29LWmw4NCt6SmdYeDI3?=
 =?utf-8?B?cUVnbGRFM2xUNWhlc2puWkFTR0VNcHB4dFY3b2htRk5PajZTTUsrYUhMczFk?=
 =?utf-8?B?c29yTE9rZWJ0UzRDOFczSjdDOVhjZUR3aldOemRjdzlIWjF5RGVLdUtrUXJt?=
 =?utf-8?B?QjBrQm1TOVBabXZ6eVRRVHN3bUxlUnVHMDBBMlR5VVlZakU5Z202dlF4KzdL?=
 =?utf-8?B?OUt5ZjNTUnRsVDlQeFZVNHNLcG1kZTVoWmZmRDY3QTRmLzFQaVNkRElQa1h3?=
 =?utf-8?B?OGZjMFFvQWVITEN4UldqVDkwSEJoc0RFMkkwZmx0cGdjaUM3ODdhM3Zib1Bk?=
 =?utf-8?B?SzhIdHFITDkvdGQ1TEIzQzZ6bkNFcWRzZkcvNTkvZXZ5MGZOR1dKQXQyZzMw?=
 =?utf-8?B?T2F6M1p6MWpGajIrQ2oxRk42OFliWU85WUdON2NNci9LN1J3U1JvYkl2SEVS?=
 =?utf-8?B?R1NWY2V1R09OeDJDaHhoVDB4d2l0NmZEdUxzeVNGcTRJaTY2VVFCcnMyNTlY?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1731521-86cc-412a-cec7-08dca5813dcc
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 10:22:48.6641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WH96BLpNDFJMzgb+r38550EBsOHAhA9HLDU/jnJJRPAjTWK3/V1DsQt2lZpHgX8d74l8k82xPG5I1piXkFirphpTxEVoviGdosnS3wBWXho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7576



On 2024/7/16 14:43, Yang Li wrote:
> Add support for Amlogic HCI UART, including dt-binding,
> and Amlogic Bluetooth driver.
> 
> To: Marcel Holtmann <marcel@holtmann.org>
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Catalin Marinas <catalin.marinas@arm.com>
> To: Will Deacon <will@kernel.org>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> 
> ---
> Changes in v2:
> - Employ a regulator for powering up the Bluetooth chip, bypassing the need for power sequencing.

Introduce a regulator for powering up the Bluetooth chip instead of 
power sequencing.

> - Utilize the GPIO Consumer API to manipulate the GPIO pins.

Use the GPIO Consumer API to manipulate the GPIO pins instead of ...

Minor fixes

> - Link to v1: https://lore.kernel.org/r/20240705-btaml-v1-0-7f1538f98cef@amlogic.com
> 
> --- b4-submit-tracking ---
> {
>    "series": {
>      "revision": 2,
>      "change-id": "20240418-btaml-f9d7b19724ab",
>      "prefixes": [],
>      "history": {
>        "v1": [
>          "20240705-btaml-v1-0-7f1538f98cef@amlogic.com"
>        ]
>      }
>    }
> }


