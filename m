Return-Path: <netdev+bounces-206048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD3B01257
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 06:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27251C834C9
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 04:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8275B1946DA;
	Fri, 11 Jul 2025 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RFJi3bh3"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011024.outbound.protection.outlook.com [52.103.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F6151022;
	Fri, 11 Jul 2025 04:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208668; cv=fail; b=LV4adSvBz+B7StbHS1XBCRRkvB6mgBiHUcX2rQ2bzE45b3J0KBP1JOMU1WcEkc+xQ4MF7ElZfFVYQuCXwEstFZW0IMeYCtwdCRM9plCgZqPMzuLxUNr8CpkCcWNu5Cnp33D+clQoiSmopOfM0mpzxDV0cSs+WWELYun2aD1aibM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208668; c=relaxed/simple;
	bh=S5x9mYGNSwwGC63+Qk+uw3ozdwYuzpfW6nB/7JVJBxU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NULAGEFw8W0jpZsApFw/7kQU7TZQZ5gLuj2oCM3Uy8RHAgcy01FHJhRWek3rk0X/Lf3RYZmSzctGQCiSOEUdAuqwMpr1LUOHwCMpMADN0DB2yCmGnx5jSPeUYj8ANBzAv27Z/lMgIOc/cnbxItthtoja12pSAk3saQ6yFjkqeZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RFJi3bh3; arc=fail smtp.client-ip=52.103.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sT5H2lAkB3sDpRjVp9mTZWDafSyNLI2UY0k/Z6e2AolknZJ9qz6WtwXmNrlz5Mr2INh1FOVZYJy4aTpKIzd3Hn9SrmC6DwrDUFpm2n6F0L7SVoNs4U9WcXewDTzl1BaunyLJ9Aal4FKXjfaWIMvTtV/jlteVoC9Qli5DviO3g92fI+e5/GKkTOZGe4rynjxKbyje+wj9D7fb9+xlf6BIXJogQhIhVf4GNlY7DYFr/Yya2tJZ55ZW8RZ3tAV3eE28bQgIZZRAPqurvYnIh+sDmtB6znMdxWPjJGquWQ5H+QcefsGDmnMN09TphhGU64/yMtfiBdkhlpgG0kg6b4FnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5x9mYGNSwwGC63+Qk+uw3ozdwYuzpfW6nB/7JVJBxU=;
 b=zWzjhGZXWTXsNBnyuurFXDciQ0sRfdGBsdIA8YZvWRMWqctv+Z9YOui+maqaMmKhR2T1ZZaIXBNpGm2BQZqPoUrmXoGtlPS3neIpiaDifdErOkjr0taBaf7c5aCcFyrTvjxGsAE3QTUGZJnvAhLxenPcOHd7HPlbs0PS5Hd1q/lKSdeAVXkOo0U8WUoxSCUEkCh59yFNfBCIUPsVRUCPAxzj7tZrUGFpsemoUeceog3F4JEHmeCjGPHZHx8fbuAkwANYkHZV9/p7bXNCsYpCEVmTgvz6AYz2Nxu7KBTxhcnLMvN5PbkUqX68ZR+lno91z+KnqLmHQu4UxtHvusC93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5x9mYGNSwwGC63+Qk+uw3ozdwYuzpfW6nB/7JVJBxU=;
 b=RFJi3bh3YWekO8F3L3aoWMdIvMUghz55omsqvJcSCRHMIRQCulS147I6q0edjo58AcdjNdoqShqo5lV8/T8/T2mUiIxK8yiJl9o7MNLNVXRb3hoooc0dIVl0C7Eopo1uwFQEFVVU81Mdc+vrgVpxQavJsYw/G02oNGzHxGZdyrEPoc9FntKDHAUcwa3e76ndtsfhk+7CbXb7gjUlBoSDL/MeTC9g5PQ0LMnJHJ1a04uOiSEMjBaPUGH+t8JHhKf0XqpfeDBmL56Nw/pOoM9k3d3DfiK0p12AbTI+QVVzOrW2Qpmn0K6M+Y+HJZaYow8S/ermlftHbw7woxtJcCVsZw==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by TYCPR01MB6834.jpnprd01.prod.outlook.com
 (2603:1096:400:b5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 04:37:42 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::7679:e9eb:aeb2:f12f]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::7679:e9eb:aeb2:f12f%3]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 04:37:42 +0000
Message-ID:
 <TY4PR01MB144321BDC50DEF7A2537C24F0984BA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Fri, 11 Jul 2025 12:37:27 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: net: rfkill-gpio: document
 reset-gpios
To: Chukun Pan <amadeus@jmu.edu.cn>, Philipp Zabel <p.zabel@pengutronix.de>,
 Johannes Berg <johannes@sipsolutions.net>
References: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PEwu0jM4H70poiX9GQi0Qozk"
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID:
 <2caf6f2d-64f1-441c-a600-d893768c8dbf@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|TYCPR01MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bfbf0b-7788-499f-b6aa-08ddc034aa56
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799012|41001999006|21061999006|8022599003|6092099016|3412199025|440099028|26104999006|26115399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHYva3BWTW5Jb1VQRmNHRThIQWtLYTUrcmxCZTd3Q05UN3BUSUx2c1NZTWlF?=
 =?utf-8?B?eFNzYks1UVd3WkZpQ3Q5bnBCbUZtdXNCOHZjLzRoUmZCRGEzdWVSQWkvbyt1?=
 =?utf-8?B?TVBtUmgranJmK0JJMy8ycFhXVVdKc2NUU0pHL2dSY0R0NjdDZWRzdzludDEv?=
 =?utf-8?B?VDdZMllEcjVsSVdyR21hTi9xSENZVUtlUSt2OTFoMWQ1bWtyM0FRamUweGxw?=
 =?utf-8?B?S2VNSm9WYUNLVUplVVk4ZjdQeWlqQ3hrTnZIUVhwSzdmeU9HeWVmM3ZodnB3?=
 =?utf-8?B?MmFpNzBoSEZDNmtRRFpWYThBOGw5UUFjaGcvNWx4QzFncmJDdHI1UVYzZUYr?=
 =?utf-8?B?NEFOd1RJNFlNUXR2b2c1SVZJcFh5eEorQlJ6Nzd0ZG40VTZFQ1hnV3pWT1BJ?=
 =?utf-8?B?MG1vVXMxNmYzcWY0SlhycEI3TXhYNlRkSG5JRmNhbkdsRG1HZzhtajRsdmY1?=
 =?utf-8?B?a3RaRTVtSjkrdDdKOUU0MHp1ZExFUFgraXA0QnBPbXBsWG80VWk4ejErV0ZR?=
 =?utf-8?B?VlhUZHc4bUNHRG9SVTloeitmZFpJQzdZcUYvNzA4UTUrV294dVVJdGM2akpU?=
 =?utf-8?B?OTRkcjVkdXZheDlMeWpmbW0xOG5rZHBpNXRxbGMyOHg4b2xQU0taVmx3YWtE?=
 =?utf-8?B?bDNUem5xQnp1WWJvNC9FMTFEVlBwRHl2WCtnelVYSTIrTjI5aUFPODVxUVFL?=
 =?utf-8?B?MUFvNmNxUWl0RFIvQlUyRE14VFRxZnNUQzAwdEhsNkRtT2d5eHNjZUU1c2s2?=
 =?utf-8?B?d3AxcnA4L1h6RWdEM3MwTktCUm5LUGx0aFROT0tlTktseWFXTmd3R2NzMU9H?=
 =?utf-8?B?VEhva0dnR0trUlZiUTViU2IzL0JFY0ZLTWhNR3kwZFh4TkI3MU1YM0dSbnJG?=
 =?utf-8?B?bnROSVNkYXk5V3Eyc3ozSUNJUkN2RXhaWUo1Mk1ZYlkxY3FjRXZvTDhHNXFz?=
 =?utf-8?B?Ly9jZVhCbFR2TEhYUEg0Z0J5ZWdlZDRtSTk3bWZsclllMVNZVy9SMnhxZmJa?=
 =?utf-8?B?Um9zUzd0SHdBWkdYOEdjTjJabmZwUVJteFVCTU1Mb3pqZDJDY1JjOVpVaHln?=
 =?utf-8?B?c1JlZUtzbk5teHVQVUNlOTVBN1VHeDJkTnQwVHBpQ3BiNk5GWmtuRXRQNjU1?=
 =?utf-8?B?UU5ONEVXejUrM0wzcm1Ca3MxV0ppbHdZQy8zK3E5SUVQaXV3dGxrNmRvNVVI?=
 =?utf-8?B?VEx5RmR6dlY5RHNNcUdoSld3T2M1TVl5WGFGTldZQVlRQ3kzYmZ0MlA0ajB2?=
 =?utf-8?B?MUlySkVHb01uMUlyc0ZVV3NzcTJwL0hBd2RGV2J2NDlhcnhMMk9kVklEWGYw?=
 =?utf-8?B?Sy9xbFJBbDV5dE5mbmdYQ0FyMmlBQmpnN0xCcldPcnB4VG1DOFFIMy9XaXd1?=
 =?utf-8?B?UkdVUDFuZWN5VTdOemZFaWpxbG9uVnhLeGR2WFN3WjJkN09xcHIxeERlRzRM?=
 =?utf-8?B?MndLUk9yalRpME1wZ1FMTkNKMEN3enFmRkpEVVZxa1NiTjJEMkFOdlEvMy90?=
 =?utf-8?B?c2w0QjB0dEdFamFEbWtEKzlDMU1ieCtzaTNEUFBnWUI0aHlpYVpZNXZWRFpv?=
 =?utf-8?B?d1JJVFVFRStIZkZIU1Bua0IxTjIvYzZiL2VZYnB0c3k1bldIb3k0TmV0TnFw?=
 =?utf-8?Q?AYPCxxmjgC0dcM8Kjrq/7jdhcQvu9k2vSWn1tWdsZQXI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFpEVGNoU0hIRFJQSlRaTXpORWd2R0cwNUczUTZOazJKMDMwRms5V1U2dmZn?=
 =?utf-8?B?U2V0VTR3dnBZbWpheElVaExpUlhMQU5LYWxqOGFCc08vNE9WSmluWitYL25G?=
 =?utf-8?B?RnFoeEk2dTVUUzdENzJqMVJpd3RiK1VwWDRjWW1USngrdk9SMkFpRUQ0Vit1?=
 =?utf-8?B?cERETnBJRkpBVTh3Y3g0OEZCV1h1RnkwVmtieDNGb3UxSGlaL1NVMGJUcXlG?=
 =?utf-8?B?YWZjc3ZqMmZ4cXpiRjNSUWVSbmw1VEhBWHpoN1dQNWIxY0NvbWswL1I2VjVi?=
 =?utf-8?B?Sk91VExOKzlDZFZZU3ZyNThMNlRpVXJGa0xNTGF3RXJUUXdVT2VKelVsM1VW?=
 =?utf-8?B?OTkrY2tQNG9NL0V6UFRJbHBHZDE5TEhucnhjV1Bub2RGOVd1c29WdmZDdDdS?=
 =?utf-8?B?NjhNNGg3czRzWFhPQ3JxOTRpcWYyS3ZIaWIwOXV0RVkyR2IzbUdBN0dVZzRT?=
 =?utf-8?B?TlBIbG5yd3FVdUdpdnpNWWRveVVPanZqRk9FUjgxeVZ2bUFsY29HcXVvWVov?=
 =?utf-8?B?Tk5WTlJuYWJCTHRZVmFTUjdYYUdrdkNZTm1BY2M0U2YyNDNhTG95WmRqZGlJ?=
 =?utf-8?B?RVRxRlpQbFdFZVNBUTNlVkliNDZmQVNzMCtqelZwdEJEVGFTbi9ORVZJd3U3?=
 =?utf-8?B?c09yTVdoVEVma2NidHFtWE9vQmQxWXlEMGpYZ0RrdldZMzdPZXYwbDhibThJ?=
 =?utf-8?B?cjZNNUN5V0IxaWxSNUNlUi96Zk93VURpdklJd2pXbTV2SDd2dTBlOTNTb2dT?=
 =?utf-8?B?clp0Qk5Edjh3M2J0QkZyYmJYRHJBYmh0N1Mwek9sNG9Ldkl6LzVLZzNqMVhB?=
 =?utf-8?B?aTFuY0djL2cvMmx5Tzhadms2TVlCejJQVGtyT2xud2tzQWs3MkJGNURSZnZD?=
 =?utf-8?B?a3lnWXY4WVBXVHR5ZzY1SUpKY3dQWko2ZEFNT3NNRXRTWFU1ZTJZTnJ2UW4w?=
 =?utf-8?B?bGNjT3NXS0tLOGQzRHZPeE1kNjlJUGxta2paSGxndzZKNEh1U054NGNCZmRX?=
 =?utf-8?B?aHlwbGRMU21md2lwdXgxTW9LVk91bDZjcWk1M2V2bjNxbFErNW90aDNoTys3?=
 =?utf-8?B?ZzJ0MG9SRnl1bU9QYjRpdjdTOTMvT253S0pZd0pXMXdWbWN1MVppc2Y3eDlZ?=
 =?utf-8?B?elJUYlgwMUZNblFhUDZWcVVJVlZPZnF2ZDRKRTFuNHRvNTFWU3VHeUFGSDNW?=
 =?utf-8?B?N1lRV3dEbnNLUGVIZ2FIeWdaSElCMlEzWjhxRVQrcVA3VXpNZUlUZGYrOHIr?=
 =?utf-8?B?R00zVWJSUW5Ib0dBekp5TnFjZmIrMFdOQVdpYUlEVm41a25IUDNVTHFOakNM?=
 =?utf-8?B?eWZFdmdDS0ZBQ3pQSEt4TWx3RnkwRGdrem1FSDh0WTRscGc5YUdVeUQwZzNm?=
 =?utf-8?B?QXo0NmdrVVRSQlFiMkFVOFNscWJQSGFhSTByUTRHMnRxdDk4WEF2a21xMElp?=
 =?utf-8?B?R1NRaTlmbjM2VEE3TnFkZFY2RVljRTE0dEVKUm4rNTdiWnE3ZE0zbUtHNUhx?=
 =?utf-8?B?ZzVxK3RZZzdwTDdSekFodHpJcjNCRTMyNWRmZTdndThKUGNHY2ZiTzhmTUVF?=
 =?utf-8?B?aE11Mm5wUHBQRlFFRW01VlF0Tm9RL2pYU1o3OWVFUlVpV21SM3pGN0FVZE91?=
 =?utf-8?B?Qlg0bGpGZFJtcDFSYWhRVVBqeWF6NVdqNzJhK0ZBaEQxcmhKSUdsemhxYzd3?=
 =?utf-8?B?Rms4NUZpU2dtRVpXSlVqUG1pZXA3M1hzSlZ5c3J0M1MreXBrZ095R2JmY0p6?=
 =?utf-8?Q?SSPA1DrNId/uFt3t6g=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bfbf0b-7788-499f-b6aa-08ddc034aa56
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 04:37:42.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6834

--------------PEwu0jM4H70poiX9GQi0Qozk
Content-Type: multipart/mixed; boundary="------------IbCJJ2eFI8DG0uI7Ps3iifCy";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Chukun Pan <amadeus@jmu.edu.cn>, Philipp Zabel <p.zabel@pengutronix.de>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: wiagn233@outlook.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <2caf6f2d-64f1-441c-a600-d893768c8dbf@outlook.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: rfkill-gpio: document
 reset-gpios
References: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
In-Reply-To: <20240528143009.1033247-1-amadeus@jmu.edu.cn>

--------------IbCJJ2eFI8DG0uI7Ps3iifCy
Content-Type: multipart/mixed; boundary="------------f0ZLeduyxAK85p6faaBjCEse"

--------------f0ZLeduyxAK85p6faaBjCEse
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCldoYXQgaXMgYmxvY2tpbmcgdGhpcyBwYXRjaCB0byBnZXQgbWVyZ2VkPyBJ
J20gc2VlaW5nIG1vcmUgNUcgbW9kdWxlcyANCm5lZWQgdGhpcyB0byB3b3JrIGNvcnJlY3Rs
eSwgZm9yIGV4YW1wbGUsIEZNMzUwLg0KDQpCZXN0IHJlZ2FyZHMsDQpTaGVuZ3l1DQoNCuWc
qCAyMDI0LzUvMjggMjI6MzAsIENodWt1biBQYW4g5YaZ6YGTOg0KPiBTb21lIDVHIFdXQU4g
bW9kZW1zIGhhdmUgbXVsdGlwbGUgZ3BpbyBjb250cm9scy4gV2hlbiB1c2luZyByZmtpbGwg
Y29tbWFuZA0KPiB0byBtYW5hZ2UgaXQsIHdlIG5lZWQgdG8gYXQgbGVhc3QgY2hhbmdlIHRo
ZSBzdGF0dXMgb2YgcmVzZXQgYW5kIHNodXRkb3duDQo+IGdwaW9zIGF0IHRoZSBzYW1lIHRp
bWUuIEFsc28sIGl0IG1pZ2h0IGJlIGluY29ycmVjdCB0byBwdXQgdGhlIHJlc2V0IGdwaW8N
Cj4gYXQgdXNiIHdoZW4gdGhlIG1vZHVsZSBpcyBjb25uZWN0ZWQgdmlhIFVTQiBNMiBzbG90
LCB0aGVyZSBtYXkgYmUgb3RoZXINCj4gZGV2aWNlcyBjb25uZWN0ZWQgdW5kZXIgc29tZSBV
U0Igbm9kZSwgYnV0IHRoZSByZXNldCBncGlvIGlzIG9ubHkgdXNlZCBmb3INCj4gdGhlIFdX
QU4gbW9kdWxlLiBTbyBkb2N1bWVudCB0aGUgcmVzZXQtZ3Bpb3MgdG8gcmZraWxsLWdwaW8g
YXMgYW4gb3B0aW9uYWwNCj4gcHJvcGVydHkgYW5kIGFkZCBpdCB0byBhIG5ldyBleGFtcGxl
Lg0KPiANCj4gRm9yIGV4YW1wbGU6DQo+ICAgIC0gcmVzZXQ6IG1vZGVtIFJlc2V0Iw0KPiAg
ICAtIHNodXRkb3duOiBtb2RlbSBXV0FOX0RJU0FCTEUjIG9yIEZVTExfQ0FSRF9QT1dFUl9P
RkYjDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVrdW4gUGFuIDxhbWFkZXVzQGptdS5lZHUu
Y24+DQo+IC0tLQ0KPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9yZmtpbGwtZ3Bp
by55YW1sICAgICAgIHwgMTQgKysrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9uZXQvcmZraWxsLWdwaW8ueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcmZraWxsLWdwaW8ueWFtbA0KPiBpbmRleCA5NjMw
Yzg0NjZmYWMuLjdmMjk3ZWZkYzk3NiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9yZmtpbGwtZ3Bpby55YW1sDQo+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcmZraWxsLWdwaW8ueWFtbA0KPiBA
QCAtMjksNiArMjksOSBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgIC0gd2xhbg0KPiAgICAg
ICAgIC0gd3dhbg0KPiAgIA0KPiArICByZXNldC1ncGlvczoNCj4gKyAgICBtYXhJdGVtczog
MQ0KPiArDQo+ICAgICBzaHV0ZG93bi1ncGlvczoNCj4gICAgICAgbWF4SXRlbXM6IDENCj4g
ICANCj4gQEAgLTQ5LDMgKzUyLDE0IEBAIGV4YW1wbGVzOg0KPiAgICAgICAgICAgcmFkaW8t
dHlwZSA9ICJ3bGFuIjsNCj4gICAgICAgICAgIHNodXRkb3duLWdwaW9zID0gPCZncGlvMiAy
NSBHUElPX0FDVElWRV9ISUdIPjsNCj4gICAgICAgfTsNCj4gKw0KPiArICAtIHwgIyA1RyBX
V0FOIG1vZGVtDQo+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0K
PiArDQo+ICsgICAgcmZraWxsIHsNCj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJyZmtpbGwt
Z3BpbyI7DQo+ICsgICAgICAgIGxhYmVsID0gInJma2lsbC1tb2RlbSI7DQo+ICsgICAgICAg
IHJhZGlvLXR5cGUgPSAid3dhbiI7DQo+ICsgICAgICAgIHJlc2V0LWdwaW9zID0gPCZncGlv
MCA1IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArICAgICAgICBzaHV0ZG93bi1ncGlvcyA9IDwm
Z3BpbzAgNiBHUElPX0FDVElWRV9ISUdIPjsNCj4gKyAgICB9Ow0KDQo=
--------------f0ZLeduyxAK85p6faaBjCEse
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------f0ZLeduyxAK85p6faaBjCEse--

--------------IbCJJ2eFI8DG0uI7Ps3iifCy--

--------------PEwu0jM4H70poiX9GQi0Qozk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmhwlQgFAwAAAAAACgkQX75KBAfJsRnM
vA//WCzpxaMQebbwNwo7V5Bm+SLGHixlBhGTOHGIy12Z7Fk2n7GU7UrcRFOHg28l0YY1q5K40O9y
zeS3FeOkw5z/vfoId/qn1uBL+UTkfnrkVcG2HTKS/rsr7Z038UdeBzQcktK05LVeB3AUPa03XWNB
T6+7MkoiHxKGWJZVlUSnonHTydJ8HHPl0pRU8PwG2GLSySAHZWKiqVCw1JhDnh96NwTMd6wuJRbt
JSoMIKgOLncQHTpl9b3qz0f9jdar9z5rUDMTuRWjCfF/LD1S2/g8UbuA5o7fdkGZnDleQRU5l33D
kEacaoumdRTqvHShx/QrRHHG6vdHrRlipbb8B4e4/JOTb6V/J0E73Z+Num22V8QFmOHjBnzdrAEI
miCIybmEcZumqwcgx3s9zeHVb0K6YgLYHR9DfkOCJnUgSd1MCkLe3otgPJluDpUz/whfXq+O22m8
ymnmxdn/uiUcoJW1uE4VRBbGWzVnjHNZKI7DOmzIR9L4UbQmBFCLnSWeJ+jTIQk9/z7J6ypQtrA7
h+o22N0CkmZ6dNRJRR4D2uDa60+YDGKE7H2vJP9SDunV7lLBH1zRlst5cVA6U6ETQbnIpNuuj9qz
W30EZVJDKGw6ohg2sdvAoFsqiZw+GCUFCvEWMzJgV4aaFZpptvfrxTuMFcT0ig20+H0mXGw7c71E
Y7I=
=tRXz
-----END PGP SIGNATURE-----

--------------PEwu0jM4H70poiX9GQi0Qozk--

