Return-Path: <netdev+bounces-144691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE219C8317
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197042861C9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 06:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79FA1E9098;
	Thu, 14 Nov 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Rv4AmD4x"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023091.outbound.protection.outlook.com [40.107.44.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED712905;
	Thu, 14 Nov 2024 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565616; cv=fail; b=RRLoHnW9EEb/1EIdzn2ckmoy44lVzZ6ABkD62gFnowHtBNsaQNbVBVXm3EQF2lomm6JSG61cbWuCQfdXPye/8cc/kQBVj1MkYxqDZwXYRP3H/ulP6kNpZbA+LOl2abxHdg1rCzTT6MsB7iZqN3sVso0wlNEmKozBz178khVXeEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565616; c=relaxed/simple;
	bh=3j874vXCRhsx/HZQh0ZRatpYW9KPsIhVrprWlHXWsmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uN4zxU+bCOyEOF5Hd2rlCapZ8ncx7Xir0p14ADqY2KE2NV6sVBKd94TrqrPJtUg0o7w6L3dyQq1+VM6kIuSHUvzWhoL5VMQJnwaGkq8ADyLsHUcPJxkqUu0aDCs1djxYJKotk5LUJXFrpZFWBM8zmDE3RU9WDU0wwIZpSx+3/hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Rv4AmD4x; arc=fail smtp.client-ip=40.107.44.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyGSkG8rswl9aTKjk1yKRUkKdAB6pswakTNOySnlr+rFF1O253hDAVtZ2YdjSHEY97vWCkmi445W9u8EsjsGhKXqkaNkN0pi9qvdnOVB47tUGa+iMstFaDBtcNTLyJQwWw65PuZ/lcbXIASHuG8HfY4Rp9nlR/m+LJqF2YRWpme9K4m+9shMhVBc6bMs55Jdo+xyrz7QlKpfIwLrc/neooNQSwtBDeNnbVeLznIUrG+ScxzQGQDry872YKMh8dTH08stvZxxyPTVi1eXhtMztOKfWS91R7bQAbSO0nYvE/CCOqOZt6FLlpiafqzIHgw+0bE15GismXew0tl7+t7NkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j874vXCRhsx/HZQh0ZRatpYW9KPsIhVrprWlHXWsmw=;
 b=M8flqu39GTf1PNfCXCEQDrvr06spxQYYnPod4ZF7WM1TO6OjkauOUJu8ajyUE0+wj665pVtslWpYVMTgd4XYSkh9iwEkt6TrbZjbFfCs8dxR4alCwjZMp0VGnj4JzD0gqTR201hjalxuNFqqkDIcXDkU1Q3SqQ9rBfsjFHqc2IGM8+a/56kBAFhk1uqiUNo7Ja3fegqxrAVljFCMaZhjOluTJ21rawFJlejJsl+7CUv5y9KO1hdr2xLMio6RQi5Q8ng1y3vAcRh0JXI3H2qQyISIjkNA1VTk85rZ8IR4Oc25JUPqGORkzHgHANJkyq/NEBvTvMr4+e2TFMfKJwCk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j874vXCRhsx/HZQh0ZRatpYW9KPsIhVrprWlHXWsmw=;
 b=Rv4AmD4xGwA3Z98DLK3TEy1CbyfCxFa7nZsJDYF//kwIaKS0dRFajgIna3kk/XVAGr5bseqB3ClPwR0nUTBMYuOVXVr3BtzE7wAz71xDWcO9LYrrjm+AwwPPF43f2peoE3hE/6NeCcIQZ43IcenVcRtCgTUzn/3ATyTbgiFKcD2IkDgwnQAXv0hwYYpJoA4swm87qG5pk6dlXv+sUSBxyopngsOioUtB6UxJ4/9HZr2ovul7R7YMrmPqpzKxogQqrozrpPjyxMP+aQ23Ve2WIqUARpTyyq8lcxFBSNlwM33q3ilLHYrGyjbbJfalGmXuC7eEBbF3uG04GK7M5mZ+4w==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYUPR06MB6123.apcprd06.prod.outlook.com (2603:1096:400:352::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10; Thu, 14 Nov
 2024 06:26:47 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8137.011; Thu, 14 Nov 2024
 06:26:46 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0Dogpl7C0DogW25ldC1uZXh0IDMvM10gbmV0OiBmdGdtYWMxMDA6IFN1cHBv?=
 =?big5?Q?rt_for_AST2700?=
Thread-Topic:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDMvM10gbmV0OiBmdGdtYWMxMDA6IFN1cHBvcnQgZm9y?=
 =?big5?Q?_AST2700?=
Thread-Index: AQHbMQZSanPeA3sdNU6SnHF6uEd5/rKsdfaAgAmV9iCAABAdgIAAPV4A
Date: Thu, 14 Nov 2024 06:26:46 +0000
Message-ID:
 <SEYPR06MB51340B957ED63E32BEDFBEDF9D5B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
 <20241107111500.4066517-4-jacky_chou@aspeedtech.com>
 <1f8b0258-0d09-4a65-8e1c-46d9569765bf@lunn.ch>
 <SEYPR06MB5134FCCB102F13EA968F81869D5B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <e06668bf-f878-4a81-9f52-8fd047c1921c@lunn.ch>
In-Reply-To: <e06668bf-f878-4a81-9f52-8fd047c1921c@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYUPR06MB6123:EE_
x-ms-office365-filtering-correlation-id: 7d37da0b-8876-4f50-7525-08dd047550aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?Wm9hM2xUVWZodFZmZFV4Z2lJcmRvOG9Ydll5aUxqclJuZ0N0bFV2RGhsNDlvMFFK?=
 =?big5?B?UW9IMWdSQ1FLNzRuOGdpWTYycDhKSHkvSTlXQUw5d1NBQ1lRcUM5YVZrNktQVEVv?=
 =?big5?B?SUg4c0N1Q1Q1bTlDbXAyTzBSNWlRTTVQK1BXYlkyQ21ES1BQSmtSWUtMNlRsTlZm?=
 =?big5?B?YUdhV1BMb3l6a05uNS9aK0dOaGhlQXhOZkFBWVVNS25JVDNiL3F0aXFYZldES3RY?=
 =?big5?B?NHlJdFFWQU90TXhhcmE4TUdubVRWblFhSE5EUE1XcUpqUGVHb0t3UmlreFVDSUdr?=
 =?big5?B?eWJiTHhkdEdoc2RCajJKQVZFRzVONjI0VHZhV0QyZHhiUXZDSHk3Y1JsS0ZXVCtv?=
 =?big5?B?UjN5SkNmL0RWc0VURXRvaGhiZXlnMzJRZ2RqckhtK0lZWU1ONkNFRFA2YVFCRWYz?=
 =?big5?B?ZzdFS2FneFM2QjJDRWpBeU9OM0c0REQ5ZEpUenQvL0ZDRW8yNlkrVnlOREQwRkhk?=
 =?big5?B?OGIzaGs2RHMrcWxrZEMyZk1uamRRU0U3WXhmdWdFb3ZUZmZOTGp2NzJWc3ExNzVO?=
 =?big5?B?TWpaaVBhR3V6OHNrMWxIQXpob1JjWHBmZVlxTjZ6aXE5Y28xNlhiM3V2cnc4TnBq?=
 =?big5?B?RzY3UDdpVnZPYVc2V1pQdThza0FWODF0SDkzOVhSWlFUV0tBM3hEejhXdlFCTlNU?=
 =?big5?B?UFlxSGcrMitlNCtHNVNJVU9vVk1nb2dFOXUrKzR2bkFNekFidDJzK3ZvVnlqTk9o?=
 =?big5?B?engxekRpUkJ4WVF6UUNOTTdmN3lGT2czUmMvemw0SmZpZE4yclhCUnhYdkNWUnY2?=
 =?big5?B?RDNYUzNKT1A5c2k1NnM5NUxDekFlRzZZcEFHeEVjWU1SNUhPaUpUYXpZNkFrMzA5?=
 =?big5?B?VHZDaWJCU1dUUVh2aTNzRmFyZXVHU09XaWNGcGNvd3RrVHBmNmNIV2tYS2dqTm8v?=
 =?big5?B?Szk1NmMyTFJhUXhPWDUybFlYdjVieG5paS9UTjJNaVMzZjNwVWtuL3ZweWRqYnNy?=
 =?big5?B?NnltRXlTVWRIWmdSMjhlUTB4TjRlbVlmSU5rVGcvL0cwU0MxeERzUzU5T0V3NVBr?=
 =?big5?B?UXlUTHl3a2FHcWRjelJjOGt0RnJVazk4dVRhaHBieXIrbkE0bGlRRytTYWlqc2V2?=
 =?big5?B?eWRHa2UyZklERzJ3TWNzS3BpRzZtMW5HczBwOVFQSjArbWNFdk83eHNOdTBjQVhJ?=
 =?big5?B?NVdXZWNtTFNUZmJtVXExeXFhSFhOU2lyZjU4YmJyQUhOOVR4MVVEKzhuU3VpRmls?=
 =?big5?B?NWVBNHR3MGNONUJRa21BSW9pYWFmZ1ZpVmNOZjhKY2s0UTJjUEpVMkM5Rm5HWmFu?=
 =?big5?B?OGZ0clVkcFU2QW1kRC8xM0swLzdXSmk3NzZkZkQ4Y1pKS0xsazUxQ1ZaZHMyVWtv?=
 =?big5?B?KytDLy9FZjM5Q1YyeW5Oa2dVcEtsUVBrNUNGV0pGeFdQYmtTTEpwUEVaSElENDdK?=
 =?big5?B?c2twaE9NZXA0Sk05TFF0K21MYzJhd3B5eFY3N05RcjVnNlhVWVRZa2Vtdk8zTGpZ?=
 =?big5?B?WDdIa0loQk01OGpmK2ZHSThSaXZZRnRlMkd1cGROMUIyd2V2YlFoTkxEZ3pMbm5S?=
 =?big5?B?OFlzaEc0MWdLZk1wUFRMN3dXaHkwZkxZaTVDTXpHWXBFYjVoOXJ3WXNVUjVJQjFz?=
 =?big5?B?R0FhVS9sOUdxaXdweDhrSG84T2JxOWl2SktSZGl0L3lxZ1VsUXZyWVhFSWYxR1Zq?=
 =?big5?B?dFE0QTRXR1dWYS9BQ0JSSDZEUUl2dExUZmdBcEM4WXpCcHVLaFZhZE8xeUVEUWlS?=
 =?big5?Q?NEOOmy07MvQkMiMMFrPnxWTDmxvWL3uWWfTzZxDK3NE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?Z0RTakRhRFJTNlhnNGV0VFMvazhlbktCVTUwZGE4eTBTT3FFRFpOZXJBYnpUVklu?=
 =?big5?B?ZngxeXp2cWl5UkRCbC91U0dQSTQvTHo1UkhpZTN4bUxHUjVnbFczYVBEZ2U1VThp?=
 =?big5?B?N3A1TmRINWMzM0FLRHluOXllZEhoUmY0OEJKQ1g3THpUUUY4WWp5NWNwZDlFc21L?=
 =?big5?B?MmhlclpDMzFLVGQxQ1VNUm9sSCtEMElnbGxjK2NGM1lYNW5JL1BXMnhoMXhzaFlX?=
 =?big5?B?Q01CYnVrdC8waFk3NnhxMnBBM1d0MlNSenZCWmlkQmVFR1lsTFJGalB5RE41NU4v?=
 =?big5?B?Z3ZBMUFaZ0kyVW5UQnRjaHBqTHR6YkZZNm1wYVRPakxoaFMwc0hqbDZvSmRidHJV?=
 =?big5?B?SmIzMFBJSXVLU0xZYWV5Q3ZSUTNaZGRidHBaSkVGTE5RMFBmMUl3VG5rTkd6bXJB?=
 =?big5?B?aC96SmZoYm43OXc1Snk2M09vWkRtQ0VsdVRyVzcyekVTVVpjVitaOGFmV0hVbWU1?=
 =?big5?B?ZTQwazh5WFRqQXYrVXkxemt6bUMxdDh4YnB4OUpocFQzZlgxTkVXYjByb1pJV2Zs?=
 =?big5?B?eXFBRWdDK3FkSWVtN1ZiRHZybm1OKzZCVVlEcWNndkdnVWVqbitNTHZkcHp2TEhv?=
 =?big5?B?L29wdisxOG9OUTR4V0l0dUs2N21uSkZPc2hTazlJa1ZWdlVseUphczM0QjB0SlAw?=
 =?big5?B?VmNMeUE1akQvUUtENHdEVjJ5Z1J5dUVva3pDakpGV08vcHIwcUdzU09FQXE1cEhm?=
 =?big5?B?Z1I3SWN6T21sQjNFcHJCSks3bERMMHNTRitDNWRQKzk3R0x3QmN2MENRbmt2dnRF?=
 =?big5?B?K3hlK1ErSEM3SzFyZDZpOGRTQ2hseHZEa1dOZ0RHOGNMV2JjVVQ0Si9qL2c5c1Mz?=
 =?big5?B?YThEbXo1QXo1N0pEeDJHSkJYMDY0QjhIbkViS3dRcklCZlR5YzdhelNFbkZVWENV?=
 =?big5?B?RTQ2Mkg5ZDJ0MmN5K0tMZUFQM3cvVnM4NWJNSkNJcTRFV0kyek1GWHVtUDJhd2dG?=
 =?big5?B?T3oyaTB1TmMyV2k3cTBESDBnQTl2ZUhnYkRFZ0loTEQ0MzlGd2hKRW5Qd2N2d3F2?=
 =?big5?B?WWRRN1hTOERYSG83TENZd1lyYmVQOUVjV3NxSjVlMGlxeUZ0UXFpS3NncjFIZm11?=
 =?big5?B?WVFaWHdYNUowMzB6ekNKS2JiZG8xUU1WdDBCcmZ1K3hWNjhORzV3MENtZGJBNEJs?=
 =?big5?B?a2orMTJLUUhxcGxqTGF0UTVQV05mZ290K0t4TEFnUzgweEJQZUM2eTVNOXZ5ZnFV?=
 =?big5?B?Y3AzMFg1RjJvTnF4TStqODdoUmR5ekNvTWoyTEhXbUM0N0dXMFJmK29adytBTzcv?=
 =?big5?B?SHRaNGxWUlkwMjltN2F4bnZnbDlDVXhHblRzU0JYeTlmU0xGaUJHZVFUNWZPa0hx?=
 =?big5?B?TGQ4SWJXY25waHZRQXV1QnlTdW4zdnY2V2tyTFp2Y3d3ZE5Td21FVEJWV2xTTmZI?=
 =?big5?B?NWdhVnhBZ1hJczJCcHU5QmZOYk1lUDl4MWFERjM1VzdURTdHOEZrZzloUE9IbGFF?=
 =?big5?B?YjEwQ2g5bHRpVWoyS1BZUFl6NGxnRDk1MUpiL0NTUy9WUnoxd3FtMGxFRmpyZVRo?=
 =?big5?B?OUZmZ1VSdG9XMEJOQkY0bjBJNlFITWZNVEd3bkhwNWN0Ni9vaC9yREJDT3kvaDQy?=
 =?big5?B?M0UxM2F6aWNHYUpnUVdRMnJWTSs3NktPdDhpTi9hUFZ0QVBVRUJjK0FZQW5GNUVL?=
 =?big5?B?bFZkK0V6OEhaUllxZkFHRmdJTUhWdXRvc0FoUUZQZWFtK3R5MDBHNlh0bFI5YjIy?=
 =?big5?B?eEYyTkc5WFpFOEN3T3M1b0Zsc0QyS1F1N1kvM1pCd0NaQU9KYkp5SHM1RmF5ZEhq?=
 =?big5?B?ODl2Q0xmTFNmbGdLMG0yMTlrZVVEZndnMGlWd2grb3p2ZTVtNDRDc2tZNkcycW9F?=
 =?big5?B?bmFXd3FkSVQvM0FYOVF4TUFSaXM4Rkh4R2oyd3F5MTRYUEtIR2k1bi8rMTJyR09N?=
 =?big5?B?ZnVmaVo2QU1SK1B2bmZSZjBBRkxFT3ZuVUwxS0U3WFQ1TTZZSzBVZjkyNmI0NDVG?=
 =?big5?B?REgxc1l1THpxVERDTFVLaUJsRVoxOWVDa1hhNTdTbnRxYU1QWktLQ0VPM1FJUndD?=
 =?big5?Q?fTLcgqCuwQLt46TY?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d37da0b-8876-4f50-7525-08dd047550aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 06:26:46.7013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIQIjbg9fo6Oee/cPsjVEYSQUm4HlEEn0IS4VgGYHGj+sSC0wcGa+wP4UAPNtKjKwsgTEirIKEYXcJ7LFy/sdfbH0bnZ+Elrm9v6KDshtAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6123

SGkgQW5kcmV3LA0KDQoNCj4gPiA+ID4gLQltYXAgPSBsZTMyX3RvX2NwdShyeGRlcy0+cnhkZXMz
KTsNCj4gPiA+ID4gKwltYXAgPSBsZTMyX3RvX2NwdShyeGRlcy0+cnhkZXMzKSB8ICgocnhkZXMt
PnJ4ZGVzMiAmDQo+ID4gPiA+ICtGVEdNQUMxMDBfUlhERVMyX1JYQlVGX0JBRFJfSEkpIDw8IDE2
KTsNCj4gPiA+DQo+ID4gPiBJcyB0aGlzIHNhZmU/IFlvdSBoYXZlIHRvIGFzc3VtZSBvbGRlciBn
ZW5lcmF0aW9uIG9mIGRldmljZXMgd2lsbA0KPiA+ID4gcmV0dXJuIDQyIGluIHJ4ZGVzMywgc2lu
Y2UgaXQgaXMgbm90IHVzZWQgYnkgdGhlIGhhcmR3YXJlLg0KPiA+DQo+ID4gV2h5IGRvZXMgaXQg
bmVlZCB0byByZXR1cm4gNDIgaW4gcnhkZXMzPw0KPiA+IFRoZSBwYWNrZXQgYnVmZmVyIGFkZHJl
c3Mgb2YgdGhlIFJYIGRlc2NyaXB0b3IgaXMgdXNlZCBpbiBib3RoIHNvZnR3YXJlIGFuZA0KPiBo
YXJkd2FyZS4NCj4gDQo+IDQyIGlzIGp1c3QgYSByYW5kb20gdmFsdWUuIFRoZSBwb2ludCBpcywg
d2hhdCBkbyBvbGRlciBnZW5lcmF0aW9uIG9mIGRldmljZXMNCj4gcmV0dXJuIGhlcmU/IFNvbWUg
cmFuZG9tIHZhbHVlPyBTb21ldGhpbmcgd2VsbCBkZWZpbmVkPw0KPiANCj4gWW91IGJhc2ljYWxs
eSBuZWVkIHRvIGNvbnZpbmNlIHVzIHRoYXQgeW91IGFyZSBub3QgYnJlYWtpbmcgb2xkZXIgc3lz
dGVtcyBieQ0KPiBhY2Nlc3NpbmcgcmVnaXN0ZXJzIHdoaWNoIHRoZXkgZG8gbm90IGhhdmUuIERl
c2NyaWJlIGluIHRoZSBjb21taXQgbWVzc2FnZQ0KPiBob3cgeW91IGtub3cgdGhpcyBpcyBzYWZl
LCB3aGF0IHRlc3RpbmcgeW91IGhhdmUgZG9uZSBldGMuDQoNClRoYW5rcyBmb3IgeW91ciBraW5k
IHJlbWluZGVyLg0KSSB3aWxsIGNvbW1pdCBtb3JlIGRldGFpbCBpbmZvcm1hdGlvbiBpbiBuZXh0
IHZlcnNpb24uDQoNClRoYW5rcywNCkphY2t5DQo=

