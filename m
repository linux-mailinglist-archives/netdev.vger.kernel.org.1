Return-Path: <netdev+bounces-208214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14907B0A9F6
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B5817806A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693AA2E7625;
	Fri, 18 Jul 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="dP45eL9x"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022103.outbound.protection.outlook.com [40.107.149.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A30215F42;
	Fri, 18 Jul 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862167; cv=fail; b=Pp5kRnOZ79LiDtiR6ILqwFJ1JKlmkG6G+/7PEnYsPLBJdJtKJ/t+GbMbowFzoszg/mV3RNuLKualgjEASWWBh8jaBDxeKecI2LPNLC+xN5qj+DMkxS/KeES+dBEex8Lo/RMTC4QwZgVWIXgAou+6T9/JD04qLfBmatn8lfwziOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862167; c=relaxed/simple;
	bh=lGZKO9ctoDOsIdIPqApJyXpo2Nj3LlEKoZylxl2wt+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=usEBT1v7VGwrQHN8J4m8PhqtsmKw1s5QUrK2ZCTUOygTadK8BYwZkMYp0p31JZQwDRI7A4/uY9OFl5OWYqNYmXxGO/hwXn5HRaT01t9x1BcrugvbM93Ej8VD8PEodnARjXk4QqKNXeKrzF+1pC/biMnxfsJiVONYP0KSq+qirsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=dP45eL9x; arc=fail smtp.client-ip=40.107.149.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIC4HnnHsJ++ybT+xMmfkktRCpfwYaSFXFFa2qb3+IvLCw+doNPQ+uMHIP8MEGHdqCfYymBx3lifaJgB+gcodE7A/IDaYHupv5UnGicNO33lTRaAvUGlSgYdQPoECwWKN3aVLeNiFM8ih4SY/UHaf1tjFIUXJ7cKH042MHm+xDtEt0JCoccNazuMpHV0Bf2c82AD8xCuFQd7QuLER5zvLPlGXc9R7IPPG69flbSldx3GDJn6mCTA2aTGXyQixH49HZBwyw7iztjjACBg2cL7RYZ8qoeufIBuZ7cJguOpB0NHOboAvfQCELpyi7QPkGGdzvR3Lgc/tp+ezXOcjSWMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGZKO9ctoDOsIdIPqApJyXpo2Nj3LlEKoZylxl2wt+E=;
 b=FBr7LtgWO1NNVG2TC4/Tbazv/UxQ6BrTlew5ag6LxmTj9X17RZqV1vkKvx71uavjY9z4BbgoGqumraV5AbGAhmeF2QNvm6tIU92MXocn/c7/a8YkhV3zPgMdHdcsXCqVIkfjSZtPn/Jtxigl0tWayQ+lRE3hZWMr9WPaeiRzqcxIeSM+jRtaCFzYTve1K5wptQxuCBlzvICzTgg/3WG0pF7SsrVcXHJul0e/9Tc41CPgPRXdmn9McwmjTETatP7W+TqaG4bVrcjQyf0gfdbVpVlRQRTQD66LY7jbaLgJ/1S4dsg7yfj6IsDt5Ty/SjdMNPgRn71bjkboiQV2x9Vb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGZKO9ctoDOsIdIPqApJyXpo2Nj3LlEKoZylxl2wt+E=;
 b=dP45eL9xVUtMUqSDDWDn5jDX50IZEUOZewFi+wR63ht3fIpNsi/+dvDN99lzQtkIztxTgxLnaQiWf8dZ+jc7tjzZ0C72rdXpbsTHuakP1hFg4P9L5Ewol+pzGVkpWtc8uo6xqURNYutvY+lr0pF3MP+EOjGM93Z82ZX0u+oT6Do=
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::126)
 by FR0P281MB2429.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.26; Fri, 18 Jul
 2025 18:09:21 +0000
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::934d:b034:c445:f67f]) by FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::934d:b034:c445:f67f%5]) with mapi id 15.20.8943.024; Fri, 18 Jul 2025
 18:09:20 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH net-next v5 2/2] net: pse-pd: Add Si3474 PSE
 controller driver
Thread-Topic: [EXTERNAL]Re: [PATCH net-next v5 2/2] net: pse-pd: Add Si3474
 PSE controller driver
Thread-Index: AQHb8lZxRAWe+jAgjUChamjVjqUvBrQ4LY8AgAAL7YA=
Date: Fri, 18 Jul 2025 18:09:20 +0000
Message-ID: <01bce50b-77e1-4ee5-8a02-9db7a2845c8f@adtran.com>
References: <be0fb368-79b6-4b99-ad6b-00d7897ca8b0@adtran.com>
 <b2361682-05fe-4a38-acfd-2191f7596711@adtran.com>
 <20250718192638.681ef327@kmaincent-XPS-13-7390>
In-Reply-To: <20250718192638.681ef327@kmaincent-XPS-13-7390>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3PPF3200C8D6F:EE_|FR0P281MB2429:EE_
x-ms-office365-filtering-correlation-id: 208d784c-786c-4c29-2b22-08ddc62637b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Uytwd1IvN2l0alFxQmp6a1ZIYnYwMDUzK2s2dEd4eEtWVW0zeXZTTWZLNjB6?=
 =?utf-8?B?bEhVUXZuK2UrQzZuTTVtbmJSNWJONjNta1RtTWQzSm1VV3FEUlhtWFNPS2VS?=
 =?utf-8?B?TVQ1QTdxdkRIUEErWVZ4NkNObnRIYlQ2dmNESGVHSzdENTVTSm95SndqVERu?=
 =?utf-8?B?Q2lxTlFkSC9VcUlZcW5jTEY4K0gzUkpCL0xwMGM1enRRQlB2c1gwRGhHMnRG?=
 =?utf-8?B?blFPb1ZjTnBsMmttdFJaY0RPajBFQ0c5TDY2SnJvZnlFWVNaQ1h2NGNlZlpD?=
 =?utf-8?B?aXdQUzNCbWpMVFg5NXlRSW40NXcxVHNYcHFlL2F1R1IrWG5SMFZGRHJ0NGpZ?=
 =?utf-8?B?cnFTMWFEVy9hOGt5dmZqRmZUNDRZNGdqM1JwTXljNW9MNnh5WnVmTmd0eGFh?=
 =?utf-8?B?a3ZsaE1NRUp1VEk2RXBzR3F2VzJBbTFPcWF0VVcxb25jOENnVElGTGw4dng2?=
 =?utf-8?B?aVlxazNsVmVWUVhZZkxyR08xNnNDWWRIZFg4UzlPc3RBOUdNNEdhNUM2Nk5v?=
 =?utf-8?B?M3ppejA1N2RDdnl1dWJBcGx5OGtJVXhIUEVKb2sxKzNWRmR4YkFEOW1zNHl5?=
 =?utf-8?B?NXRWU0EyM2EwRUVMQ0hVSG85a2JQemFsV0d2NE4rTGNaU3hRYU1QbStldk1n?=
 =?utf-8?B?MFUrb0JhY3RZYm9OT0MzMjNrcWNsUGV6UDBPd09rekthZWdURnBWN0diVmVR?=
 =?utf-8?B?TUVTaEdhblV6VUZleHZ0ZHRDT0kwNjMxOVFuc2NQQ2ZrelJYN0ZONEpJOTNM?=
 =?utf-8?B?TDBMRGJhWjFReTVQY28reGVwbDJNOHQwSFR3bkZBbElHUkp0ekZsYVZpcDQ5?=
 =?utf-8?B?WFhNeXhINUFhL3NHSkJ6VVZWWlRkSWZRRWUrcGY2NGVMKzUxRVIydW9iMUZV?=
 =?utf-8?B?d2xrRHdwUjBYdExiRVhhTWNPMEJQUDFPMmVGdnpkK3RTc0pIamg1T3pZa2Q4?=
 =?utf-8?B?N2ZETTA3UG1odGpzaWlEZWVEWEo1WFg3K2R0U2JxS2J6cGhTWXRxNW90QkxP?=
 =?utf-8?B?VWJSKzVKOGpBSi9RY0hPRVNPcU0vMHRUMjZsTlM2RDNsZDNwWlVNTENTRm1q?=
 =?utf-8?B?bDdSTFM4bUJNRkdZRTlBZXk1NTZRU0w1cXlPaDRlL3dGcnM2cDlDL2RpQTAw?=
 =?utf-8?B?SmcrNHBvR1hBN0tvbHp3ekRPNldQMUsvb292SzBkMUxmdkpPa3E4dnFuVkhS?=
 =?utf-8?B?MnAxb1IwZzJoa1BXMmFhQWZRVThZUUFOYkZIMzZEem12MDc2VmdVc3hoNlN6?=
 =?utf-8?B?cmZNa0tiWUhTczN6ckJ4SytleXdIZnJ0WVFyMnJvN2lMYmdNN3NkTE1NQkhE?=
 =?utf-8?B?Y3YrUlp1VktqbUFSTVVNWURzUHRFb1RQOE1ycW1rMDRXc0xCaTJLL0dLUzJ5?=
 =?utf-8?B?Z21NZzV6d0p3MHlyMUNQWEhzZXFwVEVHMmYzTk1sVGNObUhJcmVoME9pcFRt?=
 =?utf-8?B?SXc3VWw1VkUzVUplUjlLeVZUS3RXdmlSYWtqN3hGS2hGRFpDMVVzbHBIdUpE?=
 =?utf-8?B?RStJalRSbjk4aUd2bGpwZGpVOTREVVlHV3RUUEh5Z3Z2SGhjNCtjRFhuWm9D?=
 =?utf-8?B?RmVRa3BpZ1dHbkcwN2J6eEtNN2ovOUh0dmFKN0JqdjdnSXZFWGFFZFB0S2tj?=
 =?utf-8?B?TXFHaHkzekZJeWhDWHhiMmJtN3lTQlh5TGNHaSszRFpaT241MStXejRJQnY1?=
 =?utf-8?B?M25tbm5qZ2V5VUNzR1d4OGQ0NzFDYnIrVnNrUGFLL2dPRmdDejdPT1E5clBt?=
 =?utf-8?B?cWlkZmhXQndZT2VNVmlOMXJLZ1RJaisyUmhQeVJacXhCdUdRS3A4ZHh0Ulc5?=
 =?utf-8?B?UkxFc2VzSU9YeEZoUUMxSkNuUC9VREtFTVBKa0x0c1ZoaEJweDFMVm1VNVVz?=
 =?utf-8?B?WlRWalBkYmVLWFExRy96QWQ1SDRlb0pjQkpxazdjWXVhVVhkeXk2bWh4K0x6?=
 =?utf-8?B?b09iQXBjNGs1MDdFb0h4MkdvdzIxQzY2bEJkbXU0dm9iVUw2QWVYWXNkU2sr?=
 =?utf-8?B?c0w0amZzVDJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEdkQXdyVzRJZEtyRW9XM3d5b0NUaGhwQ0pXbDhuaHQ5azdHYnk3cHZGa21w?=
 =?utf-8?B?L0VpVjhUaE1BWVU5ck02YVUxMHZYOXlsZVk4bWkwYjlzbXZyd2pRTWZJNGJO?=
 =?utf-8?B?ZWhjaDJzU3BIVEhaaDVOcHdiY29LcXlSMkFlWkoxNXpCZnFMVlNwMUhQd1kz?=
 =?utf-8?B?L0t1dUxQL29qUTZKUi9zUGZLeXZqL0lZZWxUZzRWZjhTckpneDlhZVY3LzBJ?=
 =?utf-8?B?bTlDZFZjSFlUeEgrckhTUkh2UUFKMi9UNHVoMkczektsWUF0dENERUJJV2tJ?=
 =?utf-8?B?TzcydXE4Snc0QldvTGFacUxQb2NPOUZIQVo0NitORDBVVWI0YXZuYkhYMkFH?=
 =?utf-8?B?cHVTTUEwTWRoZU41eFM1dlE5UDhLU2NVQ2t0NTVmV2hFZnpQUmk3Vk9LUEZ4?=
 =?utf-8?B?ZVVwS0hqQytaNm55ZXJuK3ROWUR3L2NEL1puTHdyMVJ6d2NLU1JuT2lkTWU5?=
 =?utf-8?B?UXdpRjdQOERvcXlmRlM3R2V4c1JEbjdYR0o5RjZEZFRBL0lNcUM5QmpXNWtR?=
 =?utf-8?B?RG1EaVhmRVZBWW45eXJ6YW9VbHgvRkhCQ25PSEM1SWtudW1IbkNSNzRLb24r?=
 =?utf-8?B?M1dMMVRNYmZQcGc1Wk1ZQ2FsdHp0aks2dlFWY3ZHa1V1Vm5qcnVibGJyRmlm?=
 =?utf-8?B?aGh4cnpJZUpNU3JXSW5LdmFkSkNwTTNpVktIL21wWGNmc0R2TVMrVmpOOGJ2?=
 =?utf-8?B?WjdxOVpFYjRPb0R5RnhCQXZJRU1EckhORXJocjFPdEluaWFlNGpjQ0xvSXZm?=
 =?utf-8?B?MjAreE1aYTVHSmpTaENvL1d2SktuclJjNlN0ZzEwSHhDY0JSMGZUWDRCNnlI?=
 =?utf-8?B?Q2tkQ08xMHpqZCtITmpydXZaMlEyQm1uazFPeVBLcXZCUWFlcFBLOVFuTFVI?=
 =?utf-8?B?RTk1K1N3ZXdOV2xkU0dvbFVZN2Y4Rndvd1ZudS9rSGlKd3ExOEdTU00wQk1p?=
 =?utf-8?B?VHkwZ3ZsaU1idXUySHdqK3JsNVBlNUJ2R00wdWNxMW9jZHgyeGkveU00eFJx?=
 =?utf-8?B?OTNrditIOGl2aFNlSElGY0hDaDQ5djNGS2U1TmR3azhQT0paaWw5emNzOGE2?=
 =?utf-8?B?eDRrU0pjbTR0d0xpd3RxUmRSVFdaaEhhcW9uTk42anl6ZlhxTlhoNUhvVElX?=
 =?utf-8?B?eFJFTWZUT0M0aXdmWTAweXNQNGkvVFBha1JjZUVpcVpzTHJVQXR0T3h3VWF1?=
 =?utf-8?B?U283TkJXUCtJZm4vZnlQOTFacUNwNU8ybWVEbHdGaENGYUpiZldvaGRzWURW?=
 =?utf-8?B?d29ZbllhL1NFWk56bE9INFI1SjRDQ1BRd2luQ1R1a2wzWFRuL1RINDkxQ0xG?=
 =?utf-8?B?VXc4YUoyWDVBdzk1RU9CTkpwSEI5WUJhTHh5MHRyMmNkSExUbXIzUEIvMDlP?=
 =?utf-8?B?RVEzaHVwRWVSRlY5QzgwWEZOSTJ3VUVwVzFOQjRWQ3pEcXk5M2tTaDFmMkV0?=
 =?utf-8?B?WTFiZFNhRjlEMzhwdGQ4ODdvdisyL0tvRmlNZ1hTRC9XdTZETnovdktBTnRG?=
 =?utf-8?B?Z2d1U0ZVQUU5VXFjS2tsaFJGdDJJTzcrSkJpZ0lDZW4rQU5RU1lTcVZqWmwx?=
 =?utf-8?B?OHBrZE40WGFMakl6cS8rT1oySCtUOFI1dHVSMmdnSk1NZTlXQU5od25XZk1R?=
 =?utf-8?B?N3Vhc2t2RDZYZFlZc0pYenppbEdVTmtJZ3VGNWhBaXR1U3UvSDE4R3JEN0Fs?=
 =?utf-8?B?NFJiOTlrWFhYYnpJS3lJNTZJZEttdnBBK1U2V3dEaFE0Q3h5dHpieDFyM2RS?=
 =?utf-8?B?c3VIYTBtdk1UNWlsYWNTRDRjOVFrV0hJYkw0MDVjdVdVOFp3N1FadzM3MWMx?=
 =?utf-8?B?bkJZY2hlQ0ZJdzBPeVJ5SWI1ZGd1WGlpWnJtdWVrMGZaeWVxeW5Qd0xPRS9n?=
 =?utf-8?B?VWxIdmFEWkp1SDZjTDAwV1hCbk1sUldoZndqZGRDeWVUMnpnQXVEQ2YzNDRV?=
 =?utf-8?B?K2pkL0JTVkpHUmhOT3hFYVlTWkpURVMyb0ZVUWUxanc0N0xKSEZxRmRCRTVm?=
 =?utf-8?B?M0R3RjFCbTArZzZDdzRaUVE0OTVDRjRFazdPWjBhZWFCRWU1OGRYcUVaWGFk?=
 =?utf-8?B?bXJSNUNLQlNqdkJsRk9RVnpZbW5RMnM2QytNckVVNndWTkZZTzlDVCtQRmdY?=
 =?utf-8?Q?Qy5MAbM9aF7KS2y/vsfEIoYtD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FBCD9C11F3FF442A2B451E5F9F6DDF2@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 208d784c-786c-4c29-2b22-08ddc62637b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 18:09:20.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ab3Z0nB1Wp44OdLrseYzRgDh8DNUIOBAzG7sWgT1pd8bw6sm7d+ehpbodVeiSE+0mNtFjHyCt4Mq02KkKScJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2429

T24gNy8xOC8yNSAxOToyNiwgS29yeSBNYWluY2VudCB3cm90ZToNCj4gTGUgRnJpLCAxMSBKdWwg
MjAyNSAxMToyNTowMiArMDAwMCwNCj4gUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5j
b20+IGEgw6ljcml0IDoNCi4uLg0KPiANCj4+ICtzdGF0aWMgaW50IHNpMzQ3NF9waV9nZXRfYWRt
aW5fc3RhdGUoc3RydWN0IHBzZV9jb250cm9sbGVyX2RldiAqcGNkZXYsIGludA0KPj4gaWQsDQo+
PiArCQkJCSAgICAgc3RydWN0IHBzZV9hZG1pbl9zdGF0ZSAqYWRtaW5fc3RhdGUpDQo+PiArew0K
Pj4gKwlzdHJ1Y3Qgc2kzNDc0X3ByaXYgKnByaXYgPSB0b19zaTM0NzRfcHJpdihwY2Rldik7DQo+
PiArCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQ7DQo+PiArCXMzMiByZXQ7DQo+PiArCXU4IGNo
YW4wLCBjaGFuMTsNCj4+ICsJYm9vbCBpc19lbmFibGVkID0gZmFsc2U7DQo+IA0KPiBJIHRoaW5r
IHlvdSBmb3Jnb3QgdG8gZml4IHRoZSB4bWFzIHN0eWxlIGhlcmUuIA0KLi4uPj4gKw0KPj4gK3N0
YXRpYyBpbnQgc2kzNDc0X3BpX2Rpc2FibGUoc3RydWN0IHBzZV9jb250cm9sbGVyX2RldiAqcGNk
ZXYsIGludCBpZCkNCj4+ICt7DQo+PiArCXN0cnVjdCBzaTM0NzRfcHJpdiAqcHJpdiA9IHRvX3Np
MzQ3NF9wcml2KHBjZGV2KTsNCj4+ICsJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudDsNCj4+ICsJ
czMyIHJldDsNCj4+ICsJdTggY2hhbjAsIGNoYW4xOw0KPj4gKwl1OCB2YWwgPSAwOw0KPiANCj4g
QW5kIGhlcmUsIGFuZCBvdGhlciBwbGFjZXMgaW4gdGhlIHBhdGNoLiBBcmUgeW91IHN1cmUgeW91
IGRpZCBpdCBhcyB5b3UNCj4gZGVzY3JpYmVkIGluIHlvdXIgY292ZXIgbGV0dGVyPw0KPiBUaGUg
Y29kZSBzZWVtcyBvayBvdGhlcndpc2UuDQoNCldlbGwsIG15IGJhZC4gSSByZWFkIHRvbyBxdWlj
a2x5IGFuZCB1bmRlcnN0b29kIG5ldGRldiByZXYgeG1hcyBzdHlsZSBkZXNjcmlwdGlvbjoNCiJP
cmRlciB0aGUgdmFyaWFibGUgZGVjbGFyYXRpb24gbGluZXMgbG9uZ2VzdCB0byBzaG9ydGVzdCIN
CmFzIG9yZGVyIHRoZSB2YXJpYWJsZSBkZWNsYXJhdGlvbiBieSB0aGVpciBzaXplLCBsb25nZXN0
IHRvIHNob3J0ZXN0ICh3aGljaCBJIGV2ZW4gY29uc2lkZXJlZCByZWFzb25hYmxlKQ0KDQpXaWxs
IGZpeCANCg0KVGhhbmtzIA0KL1Bpb3RyDQo=

