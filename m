Return-Path: <netdev+bounces-190782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA6AAB8BCE
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF4CA04C3B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8914821ABDA;
	Thu, 15 May 2025 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="bTY/XG8f"
X-Original-To: netdev@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022110.outbound.protection.outlook.com [40.107.149.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2E33DF;
	Thu, 15 May 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324702; cv=fail; b=TIarVzBmFUxD2iosLYQVfZmgZd8le5sHelr+AxVK4qKxJzd6uzpEoyrnhil89W4oAaRFYB6lv8zHqc6nNR2004VhHcyB/WvNPuF3nR0EGFTkIqBt8r5GpN3m2eQXlNi+Pg54nS4KSo0IdQfV2sCj9bsIlJbbjlLYBvUbQmvMEF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324702; c=relaxed/simple;
	bh=IOqwsxN/3kx9FCE2D5c6i7QHxVHQbN34mpX77WxBKzw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FqpbIKS9hvgLd+ewrcRDnWoyM6O+N0YcNLxZuwu0ePzsxTJKrqHZQX/XhHEsk6+2K+/znbmHVoP6hkU6aaNUIo08JAmevBf8r8zG7TWZ2FYu1d1qfHXRz+jfpchn+7UFUdeQFiOVVRAzVz3jXH9kJzvLaRY2BCVZAuG9NXTk8TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=bTY/XG8f; arc=fail smtp.client-ip=40.107.149.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlOeSeyuzkl+05+PbG9m13uLQBq+5nclpJsD/fSA7aTP8A/6vfKn4WyFlLQX04Sc0EsAFWyap/foP2KjC75z5VMlAnYWsdsj7XEQBG50A4rRmIMcrkXODecEx1SIE5nSYcbfd3BgpIERrUiQHPiomasdJeK4divGZ5KiW5zhXVTTJgMPzAsAlKk+t24Gjnmgud/YmuB4d29o196wC7DNXYsOwByLMW8UMtJb/MNFnwwJLh+T5e0WTVA0aEdwaaxvfyAd5/3nILxf5MrGNiwIvwoWtkCUYihIrD5ZXQ3YgL8w3EUMyWpx94AQn9ZfED1IieKSzwiYompdkntgjelRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOqwsxN/3kx9FCE2D5c6i7QHxVHQbN34mpX77WxBKzw=;
 b=QRsvVsAyQzUOLUeWbZEYIOko7WzNzCAGfKwgEtesKGFN4Szu+c9REyJN6SCzmfBxjCbOk4s6HCJ2xngDVOYn/XWOmmUnspu+ayEu1tzibqq1kV4Y1A4kWsNuZo8VC+jNy5REypRDh0vaYSvQ4CUy3doXu4IC86fw86fQ1XuwCOniY3XWKBzMwFoXPfX7LKKjrntOIIuDdDzAWtCVDhn3nugrXcr7b3vc/Qn+nxn83WCHI5gETyIeI6Lq+l8c7Wh2ampnn9ZgxHw7+bpHXan0jYLiFOR60LJa3qjHdbVL66JMoIdXRk33KwxQB6H3MN4lKMq4TjYoP8BWRdec0N7tTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOqwsxN/3kx9FCE2D5c6i7QHxVHQbN34mpX77WxBKzw=;
 b=bTY/XG8fO3411gmjrK87+lTlYSfRfJyBvDEmLIchUb86rZQHt89KohXpWv0iWsTQ6ayDMKia2UvBe+b59a3AR5TAkAeTu813XAAjQTKtJovy1Eggc1a+7l2Nk58SdDwALpz3LBgpI/gJQL8KMMyEwlURFcsKZk5t7LFE1f/TIes=
Received: from FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:30::7) by
 BEZP281MB2102.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:53::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Thu, 15 May 2025 15:58:12 +0000
Received: from FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c74c:31e4:c86a:ca51]) by FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c74c:31e4:c86a:ca51%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 15:58:10 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH net-next 2/2] net: pse-pd: Add Si3474 PSE
 controller driver
Thread-Topic: [EXTERNAL]Re: [PATCH net-next 2/2] net: pse-pd: Add Si3474 PSE
 controller driver
Thread-Index: AQHbw4oP7kmltPptQk+Wpi6abB2GU7PQNWOAgAOdZoCAAAWhAIAABNEA
Date: Thu, 15 May 2025 15:58:10 +0000
Message-ID: <c23d2b2e-6ebb-4a44-bd23-5a66b2cb4e38@adtran.com>
References: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
 <036e6a6c-ba45-4288-bc2a-9fd8d860ade6@adtran.com>
 <4783c1aa-d918-4194-90d7-ebc69ddbb789@kernel.org>
 <45525374-413a-4381-8c73-4f708c72ad15@adtran.com>
 <1305689f-1673-4118-935c-f91705d17863@kernel.org>
In-Reply-To: <1305689f-1673-4118-935c-f91705d17863@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB2217:EE_|BEZP281MB2102:EE_
x-ms-office365-filtering-correlation-id: e2d363f7-c84c-45eb-99a1-08dd93c94a84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?THJRbFpJZ3pKVmlReEhGWmJYS2VvbmY3VUMwS2dTNmh5WTFCMHUxY3l6MXU3?=
 =?utf-8?B?Sm9lMHA4REwxVzNRMi84c09WdUwxUVc3emdDTEVpZkk4RVd6WTI2TlVpVjZJ?=
 =?utf-8?B?Zk9QYWw4bWVHOHhCOEdtY1hycW42OXplTUhESnhnbUxmVURaWkp1Y1RUT2ww?=
 =?utf-8?B?SmVranV0SzZyb0t2MmpsTzFXektNRDVRYWJSYzJDRGRkTlFUdUhWenFMV3cy?=
 =?utf-8?B?YjNVYzFoc0VSQnpKOXlLZi9aUmtadDRhK0kyRGYxckxDL05iMXN6RHNONlp3?=
 =?utf-8?B?Y2Yvbm9ORnJEazFCUDdnSk1yOHdSM0pmaWFDa3VjTFJaK1dmaDNtYSs0TzJX?=
 =?utf-8?B?NVBlSmxnMHVhSXNuTU1iWEV5aWdsS1VKQTh6Qk56ejU4RUNCSDJhK3kzRHUw?=
 =?utf-8?B?eFJLcWFZQjdDSWNxRVR3Tzk4M1FocXQzTk5hZ0lmQS92bC92NjNuUzFsT215?=
 =?utf-8?B?alpIQzI3YU5Pdi92d1FIaUZIS1VHbzRDL1FjeEJaZ0dXTlgxLzBqck9pVGts?=
 =?utf-8?B?eXoxMXJiandsc0p2aDlldW16cEc3dlBYR1Nya1RrSXN1bTR1bFBva052OExh?=
 =?utf-8?B?UThRTUw3VHlQTUN1MndtbGIrQzNDTDNVMGNtOHZRZnBZRlE1Z1hqZVVnazNB?=
 =?utf-8?B?YjVsZW5uOHR6SzE4MEw5ZG9TM1BqK29aWmNkVS84aWswVU9jeXRRdEIwRm1i?=
 =?utf-8?B?QzBEcnJKOFprYzY5S1hXSUFNdUlvNEZHaDdiM0Iray9OVEFyVS83dWlyYW9q?=
 =?utf-8?B?UEVRWjlJQUF2OURubVlPYmt6ajltQlRyRXlmZ1BQc0gzamFFc251a1M4Uyty?=
 =?utf-8?B?YVVrczhFQXo5Y3hGRWs2ei9YWlA0bkxwMUwxZVBUKzgxUXdGWVhZVzVsUTIz?=
 =?utf-8?B?Q2VIcGVkSnVLZHVjV3c2Vkhrd1B0Y1J5eFRabTNVbDVJUGRNcXZrb3ZXVVBO?=
 =?utf-8?B?VHVMUzhOZk5Hdi83SS9qRzkydEpQa1ZqV3VPS1cvN0RIcXZ0bnIvaHI2WkJi?=
 =?utf-8?B?U3lKbWtUMHJhQUN2VzhDY3hlNC8xK0FjSFJNa1NqNVJtZ0J0TVFDa3h2Um9k?=
 =?utf-8?B?ZkN5ZFVtSjNtMUh1dWlGdmZON1pxYlRUNHN0U2Zmc2grWGpSVnFzNkdvU09k?=
 =?utf-8?B?elcybXQ4eFVOOXllZEtBSzVadEVTeFliazFCMWljUUp0Y055S3pYNHlYMDNM?=
 =?utf-8?B?ejlqRWtROFFMMTdrL1YwNGw1OWJNNTYya3Y4TFE2U080enFLdG5sR1kwSWJr?=
 =?utf-8?B?WTJJanBLYXBQbmEwQzlnWlh3b0ZuWk1FZ2srZFA0R0hOMWJJR0xlcTNrM0RR?=
 =?utf-8?B?Q2RVVWloYSs5ak9nckwvaytpWGxQWG52QUNtdHZJTUFRR0kxUUMxOGJqaG52?=
 =?utf-8?B?eWpHQmN5STRnb2lDWWN4Z1hSMzBESXJzS2VCYTAzdHovVTRPWklqRkdyZUts?=
 =?utf-8?B?OWEvRWZkOG9PY1lId2oyV2lWR1F4OXhEYXFlS3YrU2hKcnoxMmltTXUrWms4?=
 =?utf-8?B?V3VWSkYwK3hqTEV5NmNNTHZnR0FXQnFEUWhnLzNIVUM5ZlZMMFBNK0xBYU5W?=
 =?utf-8?B?ZWZ3SFBvOEF6UHhvQ2xCbGJCNXV6dnRlcXhIVE5MS1dvaSs1anoyUWQ3THNo?=
 =?utf-8?B?OHJYbW1MNW9IWDhsYUdlZHh4ZWFFRDFpUlRNNkhnZjhueFF1RmpCMjhXaXJT?=
 =?utf-8?B?bHlWWUY1cjkwZ3NRK05mdzlVMFUrS0c4Y3dDMys3WVpFb0lmZXRnRFU4SURy?=
 =?utf-8?B?d0ZVRWdGRXovcSt5eGlKSzBqdmhvdU1mSVhuS2phM0RxcVp0QlRQRm9FdThG?=
 =?utf-8?B?d2JoSWY1OWRvaDZ1RmVMaS92aTJIZlg3dE56QkRzc2xndGwyano2UExzbTF5?=
 =?utf-8?B?R01PeWpTVEdvK25wOFVQTHFEaUtFSDJKYWRwQ2kvTXVqbHJvaldVRWxkQ09D?=
 =?utf-8?B?WmlZNEg1dEErb2RaeUoySEdnQ0hSZGhlRlVmN1VONWpmd0VTWGMxZWVBRXZJ?=
 =?utf-8?B?RGpSYjJJME0zZzlOMjc5VW0rZ3Y4K3ZYSnhyYUpiampZTjA1di83VU9QV2V5?=
 =?utf-8?Q?oSieBw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UU02amlRZC9DenhGWGc1cUZhaEo1RWdVMk5ldnR3OEVhUzBmWWFFR1RxZ0ZP?=
 =?utf-8?B?VzN3L3hLaWdaWHNKVmU5QVNWMHNsT3ovai9XQjBaTzVGaUE4ZU9XVlV0V0VV?=
 =?utf-8?B?UTVlNVA0TDN0WHQzZTJ6UHBEL2VXanB0SEd0NmNnejJ0a0tIL3JnOURRczFi?=
 =?utf-8?B?dEJRTFJVWjFGZ09uWUpma3cwUU4vNkUwUVlDOXM5bkkxVDdyZkorc29pSDZZ?=
 =?utf-8?B?TDdCL1I4d2QrREtxVXMzZW5ZZlZIT1VkNDFsOG5CaFkrOUVTRmo0bUJHYmc0?=
 =?utf-8?B?VVpGakhPci83TUdVUnRpNTFYUE5IcGFZMzdROVZkNzF4YlNEMmxQT2g2MHJ4?=
 =?utf-8?B?NmhkQ2V0VU9XR0lOR1Y3V2R2RGtDL0tCY1ByK2lza0JUL0d5NHVyQUxNTlMz?=
 =?utf-8?B?SE1yc2tOa3lveGN4MitqbjNjYTR3Z1d6Q2Q0cDhiZUFHZDZHSUtFeUUxRjVx?=
 =?utf-8?B?aEltNnBCMEtGaUJkcXJUUy9ZcE5DdUV0WUM1dVBMNXpMb1Mxd3ZBNGZZZk12?=
 =?utf-8?B?dEpLQTVrd0dtZzRqUUdWNW1IZ3FEd2VsT3lkNHFIMkw1S0VqQUpiKzM0YW9B?=
 =?utf-8?B?UzgzK0ozdG5PRStHaTRQY3g2dFBQVGlhZzMza3dTV2lZZzJmb2ZMQlZqa1Yw?=
 =?utf-8?B?VHVTK2xTN25LQjkyMEtEdjREV3BtckY3RWRlQjFvbDJXVGZtK0g2WlVPYkhH?=
 =?utf-8?B?WXB6cmxGVDU5MjdBUEtoZGVSUjU4SDkzU0hXTE5nTk9ReHhSaGJaVWhJSGR3?=
 =?utf-8?B?ZEFLTFlreTJuTTdDNFQyTnZaVFV3UEdGZ245azkzU2xFTHJjSFdlQTdELzFm?=
 =?utf-8?B?dnhGSXpUalJjWFpwNVp0QzBiTFc0UzNNY0oxOFdVR1BJNE9KV2lVK3FkdGhh?=
 =?utf-8?B?KzhhbFBiNEwzM2dacWZEZ2p1ZnpSOFhPVDZ0cWMxSE0waVFiVnlrTUs5UVVu?=
 =?utf-8?B?NXQrMmFIZlBueDBlTldZdVgzQit0bGFWeW55bC9rRlA1a1RiSERobzlIbVBJ?=
 =?utf-8?B?MlFqanVoWkh4RlI0aHJiUEtkQlhZVW1CTkwyWmVsb3VmdGc4VFd3VFg1Y2xx?=
 =?utf-8?B?bDF2d3FmUVlLWHc4dnhLRGhiR25vTktEejF2UzQ1ck9GT3dLY1J6a1J3TzFa?=
 =?utf-8?B?VzMxZzVnNG5IcDdJanIybmNoNHFUSWRBeGRKbUZqVkVBOENqcXdYejFwZmhC?=
 =?utf-8?B?N29USnErbXFLcVoybzB2OWRkQ3pYR05rM0FLa3BiV0g5emJXakVYeVJhMk1T?=
 =?utf-8?B?dnBzZ2k2WlllRFdrK3VFMlVFS1dLWnJyRFRQM3hySjhYQlk0V0ViVW1UbndF?=
 =?utf-8?B?K29tVHlHeUhFREdWc1lURTVxUktzeWZvVE5NRHp2cTFvZTZwZXZEaDdpQjR6?=
 =?utf-8?B?MGhheTU1aHFPSUJ5UWZUcVBFekE5S0ppVHByZSt4Z2NVT05SOERoTjVHQnNz?=
 =?utf-8?B?WVY0MXRsNThwUnZCano4MjVuRkZYZ3I2bm0vNkJQSnhTeThnR3pIYkJxWEl0?=
 =?utf-8?B?RWpjWHBNNVdrSXlXcXpkTEtFYnR1VjQxNUo1OXZJQXJ4c0pqQ2lrdHFFRTJW?=
 =?utf-8?B?UmxjaXF6WnFSaGlMSkdyNHJXV1Y3dy9zaUczQ21qay91UUZ2bmJ5K0Nha2FN?=
 =?utf-8?B?WFBEanpFY1JhMVFQTE41RmxiQngrbEhiQmVIek14WTJ3c3pHWHF2M3kzWUV6?=
 =?utf-8?B?WmNSM2JRdmw0QUNpMW1rcmdXamsyc3hhVmxaU2RIYzdyazN2QnFmNkFncFk3?=
 =?utf-8?B?QURKbXduNXRGU21lbk9JcFVtM1Q4Y3BKMVJQbFMvQzVKOGdWRkpFclh0Z0xp?=
 =?utf-8?B?NjFvWXZvUm5DV1lzS2o4WnNYckhmSG1BR29ZOGpkSERURDJ6eTZ2R1NNZWNL?=
 =?utf-8?B?TElwVVVYVWt3V24yMUFCd21ldVhXekdhTlRvVjVzUXpvSW9nSTMzUWU3QzBD?=
 =?utf-8?B?UlVQdW9BZWdraEp1ZEtvUzlSa3dmQldwYzlOeGEwelhGTE5KWC9OSlhPZVB0?=
 =?utf-8?B?Sm9ROHU4ZmU2U0tnZzFmODRHVjRoQkpiYnhJb1A1eU5FTDdQSkZRMDFqYzZw?=
 =?utf-8?B?U0dsaytqczhqMFBBZWpZbWxsblVUQmJucldCUlZnRGxDTnpBR2hINFRla3Qx?=
 =?utf-8?Q?vhfKF2dGefCqyFmejLSAx0PdZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27BCE58AB1241541BF5E0223C1CEE3F0@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d363f7-c84c-45eb-99a1-08dd93c94a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 15:58:10.4213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHx4pikupwT072czbKRGmhb7a4cVd1hPq6IgSApBcAmZuvEl6lcun2WLNTjG2lFBUMOSEEP98F9HEU3NRnDEyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2102

T24gNS8xNS8yNSAxNzo0MCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTUvMDUv
MjAyNSAxNzoyMCwgUGlvdHIgS3ViaWsgd3JvdGU6DQo+PiBUaGFua3MgS3J6eXN6dG9mIGZvciB5
b3VyIHJldmlldywNCj4+DQo+Pj4gT24gMTMvMDUvMjAyNSAwMDowNiwgUGlvdHIgS3ViaWsgd3Jv
dGU6DQo+Pj4+ICsvKiBQYXJzZSBwc2UtcGlzIHN1Ym5vZGUgaW50byBjaGFuIGFycmF5IG9mIHNp
MzQ3NF9wcml2ICovDQo+Pj4+ICtzdGF0aWMgaW50IHNpMzQ3NF9nZXRfb2ZfY2hhbm5lbHMoc3Ry
dWN0IHNpMzQ3NF9wcml2ICpwcml2KQ0KPj4+PiArew0KPj4+PiArICBzdHJ1Y3QgZGV2aWNlX25v
ZGUgKnBzZV9ub2RlLCAqbm9kZTsNCj4+Pj4gKyAgc3RydWN0IHBzZV9waSAqcGk7DQo+Pj4+ICsg
IHUzMiBwaV9ubywgY2hhbl9pZDsNCj4+Pj4gKyAgczggcGFpcnNldF9jbnQ7DQo+Pj4+ICsgIHMz
MiByZXQgPSAwOw0KPj4+PiArDQo+Pj4+ICsgIHBzZV9ub2RlID0gb2ZfZ2V0X2NoaWxkX2J5X25h
bWUocHJpdi0+bnAsICJwc2UtcGlzIik7DQo+Pj4+ICsgIGlmICghcHNlX25vZGUpIHsNCj4+Pj4g
KyAgICAgICAgICBkZXZfd2FybigmcHJpdi0+Y2xpZW50WzBdLT5kZXYsDQo+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgIlVuYWJsZSB0byBwYXJzZSBEVCBQU0UgcG93ZXIgaW50ZXJmYWNlIG1hdHJp
eCwgbm8gcHNlLXBpcyBub2RlXG4iKTsNCj4+Pj4gKyAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4+Pj4gKyAgfQ0KPj4+PiArDQo+Pj4+ICsgIGZvcl9lYWNoX2NoaWxkX29mX25vZGUocHNlX25v
ZGUsIG5vZGUpIHsNCj4+Pg0KPj4+IFVzZSBzY29wZWQgdmFyaWFudC4gT25lIGNsZWFudXAgbGVz
cy4NCj4+DQo+PiBnb29kIHBvaW50DQo+Pg0KPj4+DQo+Pj4NCj4+Pj4gKyAgICAgICAgICBpZiAo
IW9mX25vZGVfbmFtZV9lcShub2RlLCAicHNlLXBpIikpDQo+Pj4+ICsgICAgICAgICAgICAgICAg
ICBjb250aW51ZTsNCj4+Pg0KPj4+IC4uLg0KPj4+DQo+Pj4+ICsNCj4+Pj4gKyAgcmV0ID0gaTJj
X3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNsaWVudCwgRklSTVdBUkVfUkVWSVNJT05fUkVHKTsNCj4+
Pj4gKyAgaWYgKHJldCA8IDApDQo+Pj4+ICsgICAgICAgICAgcmV0dXJuIHJldDsNCj4+Pj4gKyAg
ZndfdmVyc2lvbiA9IHJldDsNCj4+Pj4gKw0KPj4+PiArICByZXQgPSBpMmNfc21idXNfcmVhZF9i
eXRlX2RhdGEoY2xpZW50LCBDSElQX1JFVklTSU9OX1JFRyk7DQo+Pj4+ICsgIGlmIChyZXQgPCAw
KQ0KPj4+PiArICAgICAgICAgIHJldHVybiByZXQ7DQo+Pj4+ICsNCj4+Pj4gKyAgZGV2X2luZm8o
ZGV2LCAiQ2hpcCByZXZpc2lvbjogMHgleCwgZmlybXdhcmUgdmVyc2lvbjogMHgleFxuIiwNCj4+
Pg0KPj4+IGRldl9kYmcgb3IganVzdCBkcm9wLiBEcml2ZXJzIHNob3VsZCBiZSBzaWxlbnQgb24g
c3VjY2Vzcy4NCj4+DQo+PiBJcyB0aGVyZSBhbnkgcnVsZSBmb3IgdGhpcyBJJ20gbm90IGF3YXJl
IG9mPw0KPj4gSSdkIGxpa2UgdG8ga25vdyB0aGF0IGRldmljZSBpcyBwcmVzZW50IGFuZCB3aGF0
IHZlcnNpb25zIGl0IHJ1bnMganVzdCBieSBsb29raW5nIGludG8gZG1lc2cuDQo+PiBUaGlzIGFw
cHJvYWNoIGlzIHNpbWlsYXIgdG8gb3RoZXIgZHJpdmVycywgYWxsIGN1cnJlbnQgUFNFIGRyaXZl
cnMgbG9nIGl0IHRoaXMgd2F5Lg0KPj4NCj4gQW5kIG5vdyBJIG5vdGljZWQgdGhhdCB5b3UgYWxy
ZWFkeSBzZW50IGl0LCB5b3UgZ290IHJldmlldzoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzZlZTA0N2Q0LWYzZGUtNGMyNS1hYWFlLTcyMTIyMWRjMzAwM0BrZXJuZWwub3JnLw0KPg0K
PiBhbmQgeW91IGlnbm9yZWQgaXQgY29tcGxldGVseSBzZW5kaW5nIHRoZSBzYW1lIGFnYWluLg0K
Pg0KPiBTZW5kaW5nIHRoZSBzYW1lIG92ZXIgYW5kIG92ZXIgYW5kIGFza2luZyB1cyB0byBkbyB0
aGUgc2FtZSByZXZpZXcgb3Zlcg0KPiBhbmQgb3ZlciBpcyByZWFsbHkgd2FzdGUgb2Ygb3VyIHRp
bWUuDQo+DQo+IEdvIGJhY2sgdG8gdjEsIGltcGxlbWVudCBlbnRpcmUgcmV2aWV3LiBUaGVuIHN0
YXJ0IHZlcnNpb25pbmcgeW91ciBwYXRjaGVzLg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KDQoNCkkgZGlkbid0IGlnbm9yZSwgSSByZXBsaWVkIHRvIHlvdXIgY29tbWVudCwgc2lu
Y2UgdGhlcmUgd2FzIG5vIGFuc3dlciBJIGFzc3VtZWQgeW91IGFncmVlLg0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzM4YjAyZTJkLTc5MzUtNGEyMy1iMzUxLWQyMzk0MWU3ODFiMEBhZHRy
YW4uY29tLw0KDQpUaGFua3MgZm9yIGEgcmVmZXJlbmNlIGFuZCBleHBsYW5hdGlvbiwgSSdsbCBj
aGFuZ2UgaXQuDQoNCi9QaW90cg0KDQo=

