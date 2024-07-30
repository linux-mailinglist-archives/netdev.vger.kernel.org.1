Return-Path: <netdev+bounces-113979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663949407ED
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 07:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4401C20D34
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 05:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF616B3A3;
	Tue, 30 Jul 2024 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="uC/YFOij"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F27169AE3;
	Tue, 30 Jul 2024 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318771; cv=fail; b=MSZMigd9hV2UkIvKLhbRTg/WwARFVaDP0pSRNLWtn5qCssU/boMbIpiS7eeDyGSaVRrdhlQi2CxoUsjZZcTjBvfRFGRCwo0lE2Z42ymHpln0fzBjEzHkdJdRxWk1OE+87kHuEo3I5qno7q0/i6wh1U19bnmsBdL0zemQqCtsYeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318771; c=relaxed/simple;
	bh=QS8QRTjWsWwLxdez6az0Wp4DmLQMqtTgfgWYaXmZzLk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LpsfkHF6IrcXcJD1Aa8pemx8Bd2TfTL5R8b0eRzCpj4m3jV2B1ly4WcKHmpzC5XcuAt4A4z73srN+FOR2EDh4xCEyGkjp/n19ZczUWVFDSX3DkVm+FcDEO/myFkatPnCx+6Xea+E4TJl53EXSDDhw6aslkTAyZcoi1ok8YO5u/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=uC/YFOij; arc=fail smtp.client-ip=40.107.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrG9LDDyJLydHc1m9ph3SLRQp6Nk4+lB3gVybZYkWNAZBZAX2NTRSzu0yL/FUnWhYlyla9YbcRV7JgTdhL8wGgOi6OgVZ3LnrdDnG1ZK9nkdERradfnkBwqI1BuqsODzpcPiE0AqHjGeg0XemGVQg5rclRBsDGjALkDtll7K+PQjrD73+YC6oczGlihH7Ak1Tm7jscSHaLZG7GGDD8F5jISpcQyFCJEcZCxpYLngCTMFY+yq9+keRBhNND+nIlOR8hUxAEpr9CrCjFrH36YW1V9b3ETrBjivTRqxJgulNXjcT5r7g1/ozanDxPk3oQsmtFS9+UPE6Wbnb2vrtcEoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm3VMip6+rPC1pLJRDObuXS0qKA03v7RYHjESawdnZE=;
 b=k1H7I8OvtXL4sDQQnqEx+EnRxFPDgnpG0WEFQC3LkahZHcm7qAjCmF8AP1qpglCQ3x2TdHttGSTvrgaPfmonQ4G6ZnkrMhj4hAuxxEGzqtDr1sMzMMv77uELXkPx0owMO8KoLNr8XzxVfoafm7XrT+VSPf+hriVlBfTHnfW5eG0h31nvw6RnhPr4aNjS2oBxA7XxosKElyy9ziLPEqwxq9oEkCoGU1cJkAALn+x9c81u8T4vVCH8suKFoJzcmvY1mQ7Hl18xB2DmhiftuJoS+z7fTh+HOqKSFDv07RfhJvAKk2FxViakRyFocfvLZVZ51UBk1Y4f0KFW0/1++TdwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm3VMip6+rPC1pLJRDObuXS0qKA03v7RYHjESawdnZE=;
 b=uC/YFOij1jm/UeWLFvAnVVUoQDm6bZ6auNqNMutv03UJMwHwApbv6WwZCkWtaKmgLbpHbqh9SSWBdJd4l80AsIHQP3paNTkTsYRA1z5KktPhYxsVskFbEU1epL7xwyHktGsfedHa2BlV5L+2BwEr4z5dq+iZ42fsvCcHn3fFiaKD3CqbNSr5Pe7tOlK5tiuOpJ7hmezBMnJrPJt4JkXhObeN3iS8Ne8s8ORaM/JUdFQL6IKK9M9Pdwto6cKi4kn5AM0OFaOh/QJUhnHAhhwY2PfrN1y5poZ9FW8v9U4sJUCdSfxAVg5FUlwvjkA/NmnqEDRMFavjqRXKgQssJzutSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB7300.apcprd03.prod.outlook.com (2603:1096:101:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 05:52:43 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 05:52:43 +0000
Message-ID: <08c3ad32-c375-4134-9f63-ead6195b65a1@amlogic.com>
Date: Tue, 30 Jul 2024 13:52:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add support for
 Amlogic Bluetooth
From: Yang Li <yang.li@amlogic.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
 <20240718-btaml-v2-1-1392b2e21183@amlogic.com>
 <18f1301f-6d93-4645-b6d9-e4ccd103ff5d@kernel.org>
 <30cf7665-ff35-4a1a-ba26-0bbe377512be@amlogic.com>
 <1582443b-c20a-4e3a-b633-2e7204daf7e0@kernel.org>
 <e8adc4a7-ee03-401d-8a3f-0fb415318ad3@amlogic.com>
 <bbe8d8ad-d78c-43fe-8beb-39453832b5bf@kernel.org>
 <ee98ce34-a08b-4aa1-aa16-d3539460c396@amlogic.com>
In-Reply-To: <ee98ce34-a08b-4aa1-aa16-d3539460c396@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbbe681-5f34-48d6-8347-08dcb05bd44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXhQYnVpZVlvUW4xNnJvbGZDdWo3dDRRR1luOEh1R3hPd0pCSTdSem1QcXQr?=
 =?utf-8?B?azA5am1JZmprVStNMVVMRW1tRHZFVUxFQ2JnZWh6NHRxcnlhRVl3cXRxa1Uw?=
 =?utf-8?B?UVZ4cjhIQk9YT2c0NlZlY3lwZWJEeGhxKzlKbGMwUHJXNUlMa3dNT0tlM1Yy?=
 =?utf-8?B?M1VPZlBQelRVOGRoOWI2aW02QkZaSGFHc0pWWnlyS3I5bk11ZlF0cHpYQ0ZO?=
 =?utf-8?B?SzhqUy9uOHpZaVhKNGlkaEN0MUMwMjRQbUJpOWg3bDY0aXhGWmxNZE9iaFY1?=
 =?utf-8?B?aGhTL1BCUXhDaWZpWTBzb3Rzdk9CSlFPTTFNSDNCYnh1bVN5QXI1VVRGeFZk?=
 =?utf-8?B?b2d4MmRKd3Q2SDlqQURyUnVJdXRYU2JhYUI2VHJHVHhCbkw0djBWZDdNWGh2?=
 =?utf-8?B?d241VHhTeHdxOU4wbWkrdFM0Y0R2VVNGV3JTRHROTWlTRjZ5Y2I0eGhlc3cz?=
 =?utf-8?B?TFZzdW5USUxPVW5odFVXb1RBR3RYendVM0dKYWlSM25nUUUvV0FNV2I1Tyti?=
 =?utf-8?B?a3c3MzVxRktwK3dtSHBmWUFtWExJdFpETkx1SlhXL2pVZTF2VTdrVVlGeDNE?=
 =?utf-8?B?S0tqOGpRZ0p1Y0lBOTZkZ0VLbWJFR1oxc1VuVG1XRzd6ZmU4dHhlVVN0WHd0?=
 =?utf-8?B?ODJhSFNGYXM5ZFNKMy9peElPdTFYSzJyTmhXNzkxU2pIYTVaTjZLby9rUzVJ?=
 =?utf-8?B?VytLdzVCZ2dvMTc2aWh1eC96RThVaGJnQUZuME9BNVU3TWJ0QTBKcWk1SDlT?=
 =?utf-8?B?TFBKUFhyTkJtbjdkVXNkRVErZGU0RFZJRThFS3VubjJhZGI1OVNaR2FhOEcr?=
 =?utf-8?B?WmV6L3lVL0dhVUgwZ28xcy9PVlpNRkdpekV2V2lDU296c1d2c1haYW94Nnoy?=
 =?utf-8?B?TnJxUU9aSkpENTVGWUUxZ245UEk0eTZvcEo0Q3FKMFF1ekRUVFE3eHVkZkZG?=
 =?utf-8?B?U2NmU1IrNVJoK3ZGRmpUNndNOVV6ZWE1VGVGRWNjUzFoVjRyaVh1WVpFVzhK?=
 =?utf-8?B?V2R2SkJlcytiekYwdXh4bXJkdjBCNzVnVjFJdjdPWTdrQnJEa1dhdVhOMzZY?=
 =?utf-8?B?cUZZQ2paU0VOYU5OMUR6R0lTQkdzeGdEbk1JRkRZODNFSmRvekdVK25CcHFH?=
 =?utf-8?B?Z3lrVUFnNjJoWUI1anlBazFMblZSMytzRFg5RnN0eTR1Q2lObk1sWGpNK2g0?=
 =?utf-8?B?L0NoM2dTNGpmbFBaV1BIUzlULytLM2lheXEvVlQvRDJ3WTBSZnEyQmhJUzlU?=
 =?utf-8?B?QU01TFdoaEl5NkJaSGJOUjZZZ2FyZ08wWldaT2FEWFowRDhnMDVBbWhjWTNj?=
 =?utf-8?B?R0F5Ym1UTWRJMUlCK1RMNHE1RjY1Z0JwUnR0alZPWk5DTEY0YnhqY1VOUW91?=
 =?utf-8?B?RGZoVEl6NStHdklybUtReXlrN2lHb2tCTnFoL3BzVGJkd3YzTHlpT1kzWXpl?=
 =?utf-8?B?ZndkdDZ3bXlaS1hYdFBleGJoNnc5L1pOdnVRVEErdHF0bzFGb1lIeElLNVl3?=
 =?utf-8?B?bXBKbEVsOGdZbjNRV2RIUGYySGdhM2d2VDVOSXdaVW5BNGx0ZE9mVmpNSncy?=
 =?utf-8?B?OUxTMmJqRG44alR6amdmWmd1ZHcyZHgxeEZSYVpkVnpJSCt5Mmh1WEY1UkF4?=
 =?utf-8?B?WG50SHZ6K1B5YkEybk04SGJ5TklDUXFFS0lsVk8rb3BOOWlQcVZRM1FIMm9r?=
 =?utf-8?B?U1ZlMzdMbG1vTmtRTTF0aFBJLzNRbmt5NWV6MmJxMG15OFBkSGowUTdzWTNE?=
 =?utf-8?B?SG55NE12dExLQ09lMVZIZlVMWUJMTG8xL05sN3QrdjFrMWJldFdLKzVieGVX?=
 =?utf-8?B?aWtZZUljZEViT1ZNUC9TUkJpb3hjQ1FDRUJEMDl3Z01QZk5sa1lvQVVUTmdF?=
 =?utf-8?Q?qn4HkBE2rl3a4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk9HenMydEFhUGtDWjRIUDk2RDQvWm92QmFPdlV6UUY1RHNBUy9sTlE0czhu?=
 =?utf-8?B?YWlnVEg4YlRsVXhiUE8vS09iajc1V25WVDk0LzlXektoOUtKbzE1Qm10WEdT?=
 =?utf-8?B?WlZyaEJaRHBTL1djcmVhZk91L2hleUdKaUdmOGNCelkxUWNIQlV3RkNzM3R3?=
 =?utf-8?B?dThrdE5ZVVI1cnNpaXRIWkhvWlMrblVJRStsWWRjcHZycHVobm5FYy9wcHFZ?=
 =?utf-8?B?QkN4cnFrL1NRcktLTnMzNForVFcvdWt4eWkzZWxjZnZSeGtQSWRlVnpiODJh?=
 =?utf-8?B?L3Z5bStBL1R0cng1bUx4ai9VMGN6ano3cFR5OE9aQVhIcnhSQ3RBUzNTUEds?=
 =?utf-8?B?c3hHMUtxYnd1emNDNFdaL01QNHozNzdHS25oSVRENkpNTzNWVWJRNEJXTWNn?=
 =?utf-8?B?cXJCMjBHUktmT3NpTGJBSmpDYmx0ZVpXNFIxWE1rdWw2R0d4QXd0QVhMcDhz?=
 =?utf-8?B?allQSG5SVytZVU1HMVN4K01sV0xRb1lya1RXd2hrRUZuYlMwZlNMVmtpM2Q5?=
 =?utf-8?B?UW5KbVh2ckJqT2JIeklMY2dBMzNpelNiRXVRVGFaTnNRZERVTnFyMklsekhO?=
 =?utf-8?B?RWtMLzBrWkwwdENRQnJ5QVJqSTRjQXE0UVU2TzU4NGR3dzB3OEZ6VHBHVmpk?=
 =?utf-8?B?SkxjRmlTNU9oZ0I1ZDc0Y25Hd24xVlFCdWNLNEsxNHorY2EzUWFGeng3cVlW?=
 =?utf-8?B?UUlaMWt0TmR4a2VyWlpQZkY3dWtYclVUYXU5Z00xWTlxSEczNGZ0eW9QQWty?=
 =?utf-8?B?OVRhSnd2TGxPclpCaWV2UGxsdndwdWNVT2FoelplRUl2bC9IdjV5Z0hjSzJi?=
 =?utf-8?B?L2VWeFV2Wk0zRkhkMlFpSmZUdSs5Sk5BL1Fuckprd1dqOE4vUUIwa29MaTBX?=
 =?utf-8?B?VjQ4eVJ1aTQvamJodExsUE5sVWVZeVo5UlM4U0VWNVJLY0lJdTlMQjFPSlJY?=
 =?utf-8?B?VjNoaGZEa1Q5bHZiTTUxblZ2NXorQmo4SHlqOGhESFF6U0h1Y3Q2ekNIeGVh?=
 =?utf-8?B?RTRJcHNUd3cydnNEc29Fa1dOLzBYN3NmMkRjbjM5b0JDcURvQVJFcXN4cVNq?=
 =?utf-8?B?a2ZLZ25XMnAveXdZbUF5V1JNRExxVEpSaCt4M1lCcWl4eU1iUFI3RkQ1RkZO?=
 =?utf-8?B?b1BuSEtQTVNTWWs0TVFjVHhHMXhzUTRSM3dLZHFxNFdBWjdQVW0wbWlxNVE1?=
 =?utf-8?B?RnVTWVRrUEJOVHdObFhaL3BnMmhSWTF2NE4yYlhIU0hVbVJlcUwraFhZa0Fu?=
 =?utf-8?B?OS9RSzdPTXl3VnJIN2M3d1R5bW5EV0RyMlFXL2c1cUZiaGF1cm04a2dLL3Bs?=
 =?utf-8?B?NGxlSS9weHhLdHJXcDE3YnJ1M2FNNXpKN0kvbXpLcGpER1FFczNPSkt2OVMv?=
 =?utf-8?B?aEpnVkZ6bGJ5dHBpRGxuVjdLbkJERGpuT0Y4dXZCcXk2MVFKOUFqakt2WExH?=
 =?utf-8?B?Uk5Sc0ErbGptYmVwV2JjaE92Mk1IUVRsNm5WbVB1UlZGeHo1YU4vbEtQRFVZ?=
 =?utf-8?B?aEJtdm9XZVpkTnBVQ21JaDRSRG5SVmNXaDR1MnNmTHBJRENlc1JXckZMcmRu?=
 =?utf-8?B?UzlEaXVVUkhTNCsxT0txN2xWWWZKbnBnVmN6OWVzdzRZNk15OGowOXU4MmZx?=
 =?utf-8?B?ck1sMTdQbElHVUs2Q3hIejRlakJyVFZHem5YTzNJQ2VwQ0R6UDJBNER3VGxa?=
 =?utf-8?B?YVBnbU9GemUrWnU4VzNpUDhyUEpVNmwvdklnaXlNUW1SUTJ3WXdvZ05GRnZx?=
 =?utf-8?B?Tnd1QjRTUmxKMTZDSHN3dm03eCtJdTdVUFhIejZYeXhvVnVFT01OQXlMS1dl?=
 =?utf-8?B?bzJNK0R4TEQ5RGdmSmd4WmhSbmRVTDI2RitmMm5haS8rQkhSOEcrcFc2K3VI?=
 =?utf-8?B?eVhPWmd1ZjMvZzRsdU0yMnZMbThKUFRDRWplVFRTeWNOemI5ZHJpQzVtU01M?=
 =?utf-8?B?NmxUUVpRakpvTEhqNnE2dU92TitkM3BrWkRvV2crSEgwdkQreFUrYnpiQi8x?=
 =?utf-8?B?OVlPOUtjSlY3ekFhc2IrUmZ3MVNCNzR6dnRXb0Y1VVptam40amhIUWR5MjIx?=
 =?utf-8?B?dmN4NDJVL01YN2pEZWFvZWxQVHNjNVQ1cEdlNFVmYkFPNFE2K280Q1pwd3JC?=
 =?utf-8?Q?5orRFX5TxAHfSteP0CgN5XpdC?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbbe681-5f34-48d6-8347-08dcb05bd44c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 05:52:43.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFafmRZe0zTNQB+4cfVKBA2pI8pxW7sKWlNg0D848+Kz6uprXAqS1ORqtxfypiojCjjRF5USk435Q2EzjduCqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7300


On 2024/7/24 14:48, Yang Li wrote:
>
> On 2024/7/22 15:58, Krzysztof Kozlowski wrote:
>> On 22/07/2024 09:41, Yang Li wrote:
>>>>>>> +    description: bluetooth chip 3.3V supply regulator handle
>>>>>>> +
>>>>>>> +  clocks:
>>>>>>> +    maxItems: 1
>>>>>>> +    description: clock provided to the controller (32.768KHz)
>>>>>>> +
>>>>>>> +  antenna-number:
>>>>>>> +    default: 1
>>>>>>> +    description: device supports up to two antennas
>>>>>> Keep it consistent - either descriptions are the last property or
>>>>>> somewhere else. Usually the last.
>>>>>>
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> And what does it mean? What happens if BT uses antenna number 2, 
>>>>>> not 1?
>>>>>> What is connected to the other antenna? It really feels useless 
>>>>>> to say
>>>>>> which antenna is connected to hardware.
>>>>> Sorry, the antenna description was incorrect, it should specify 
>>>>> whether
>>>>>
>>>>> Bluetooth and WiFi coexist. I will change it as below:
>>>>>
>>>>>        aml,work-mode:
>>>>>        type: boolean
>>>>>        description: specifywhether Bluetooth and WiFi coexist.
>>>> So one device can be used on different boards - some without WiFi
>>>> antenna? But, why in the binding of bluetooth you describe whether 
>>>> there
>>>> is WiFi antenna?
>>> Yes, it can be used on dirfferent boards. The device can operate in 
>>> both
>> Please do not respond to only partial part of the comment. It is obvious
>> device can work on different boards. You do not have to confirm it. The
>> question was different - why do you need this property? I gave you
>> possible answer, but you skipped this and answered with obvious 
>> statement.
>
> I'm sorry. I didn't explain it clearly.
>
> Board design should be optimized for specific use cases: use the 
> standalone mode for high-speed, stable, and Bluetooth-only 
> applications; opt for the coexistence mode in cost-sensitive scenarios 
> with lower performance demands. Once the hardware is determined, the 
> user needs to configure the working mode of the firmware.
>
>>
>>> standalone mode and coexistence mode. typically running standalone 
>>> mode.
>>>
>>> Therefore, I would like to revise the description as follows:
>>>
>>> aml,coexisting:
>>>       type: boolean
>>>       description: Enable coexistence mode, allowing shared antenna 
>>> usage
>>> with Wi-Fi.
>> Why this is not enabled always?
>
> The board design determines whether to enable this property.
>
> Well, I know I should clearly describe why this property is enabled 
> here, so I modify it as follows:
>
> aml,coexisting:
>      type: boolean
>      description: Enable co-existence mode on boards sharing antennas 
> with Wi-Fi.
>
Hi Krzysztof
After internal discussions, we determined that Bluetooth Controllers 
typically operate in standalone mode and are only configured for sharing 
upon customer-specific customization. Consequently, we have decided to 
remove this property. Please be advised that the third patch will be 
updated accordingly at a later date
>>
>> Best regards,
>> Krzysztof
>>

