Return-Path: <netdev+bounces-293008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPZpAx44GWrzswgAu9opvQ
	(envelope-from <netdev+bounces-293008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:54:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 603CB5FE352
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3DA4301E6C2
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB693AB284;
	Fri, 29 May 2026 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YvHbLU7I"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF251E5702;
	Fri, 29 May 2026 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037271; cv=fail; b=nBSwjjyvrBksC6My6ItFtZjgo3t3GNc3cwI8eGIpsqsDbfHPAhkJFlW/4PZ77xA0siZ7PlLu0hBgyJ2Z8MAY0+iEz7K3Nf30LmTkG5ExUMhSWm05aIMtREqQttqQEJZLBeWWC/DSNpEAXO6yn4LAfQSemCQVyqAIzFLm0QDrh9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037271; c=relaxed/simple;
	bh=7Q9c4+2Qr9Qcm0TcpMamRUBlAS7OF7joracS875CNOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tsCiCPutmzeTaoUh5FMdxDVHEoZ7mbUOS3EApJDlBr7FrjU0Fy8LYcvSklarsGkoGD4iRuDw1enJY9TgHFIzHzaGIKyGId4X4sHLCVf/vKNeFp6RNflfpwoQgTcccdx12S5Ednxsbtn1wfJFSn2y1Rx9v+tOL16MOx84KyAwO88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YvHbLU7I; arc=fail smtp.client-ip=52.101.56.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjXGXBuT12F0dFylL5TatzNaD22EB357Ah0M+o8yCPH3HWdaqbucqr/AuULbwMnaGuIlaphVu8pw0MJkLgwYHGlVPUlW8mnqPJDRIeKH/RThfgkX2kLLgaDitcwx6MzmR2a1waXkM4I756xSJKOjiZ6Tls7JmzqAIXqHN0q7LjZP1aBqJB0uq5kdNW7vD9KtvhGmbpVKKdOe6aEn6ShoDLiJCmn7ZL+qLfU/lqX3NaWOiHwF0wDBZGi/9iT5IFy3CqAuYfgjGduQxnq7ne2aYlBPw5GBc0H/HTtxHUKYjGwUpXrkIdEIp7j2Iq/gs/m/WmJ2zfgLPR/CWCNU3EBHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Q9c4+2Qr9Qcm0TcpMamRUBlAS7OF7joracS875CNOI=;
 b=GncsyPMK8xMCSixpLSN/hIjWS8w02LlaG1imd+iSd15LZ19BjOOkWvPnVTY9we6mnVDhAeQyG91A7LtpHQqprAk+GEcmjk4fXmN/7aKwdm8PL9NKZDyz9yb7L5i2HOc5nedsGUDgZJWl04E7gwWJbtacwcY3d8upsrwldIAk5DTkX7exIiZH1IhgpxLhDyXJqTPdm1FTOnGx6JFSVwvoVt96zkhIfZEgpY3KuA44sNyk/D8mcOIEMJ9NGc2c++QgL9scsu6GNaEqAJ3uW6CUGYWsLkRR72bjwzDx4LAVNlwh+rd2q9t/DFBE6p4L4Uxkzx6iYBfyVNhRfMuHETXWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Q9c4+2Qr9Qcm0TcpMamRUBlAS7OF7joracS875CNOI=;
 b=YvHbLU7Iqx7HKv17Gy6ZNda2WBccSRqj9uY4Ys8wLx/YFKS1sTG85AlCZ3Djo4S14YzRMFwq8ji6tI9hie3rMUzWIq/t5OZHQZHLdf+uvI0icpypSrpagO/y/mMH9/kThuoJRb2YoV9BzJ12TUcraZdNy54EESRqeGeuiCw/50f/SIe9aDllL81Ma72efr8VP5TB6wiKVMjumSOI278ADTkdn4PQwg2AZMZLOZjznJ2IsAT/lfPwPm99LG03D4ODKSb9Ue+jzWjTZCqjD6TSthyiyw/VFI8H4emLqZz94RxHckZyAKOCjGKedTpCok1eM+zQiqM4W4Xi0D1dEPL5iw==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS0PR03MB8200.namprd03.prod.outlook.com (2603:10b6:8:293::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:47:48 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:47:48 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: stmmac: Improve Tx timer arm logic further
Thread-Topic: [PATCH v2] net: stmmac: Improve Tx timer arm logic further
Thread-Index: AQHc7YFGyhadwxLyUUuvDyE+WpcKlLYir+wAgAHjMAA=
Date: Fri, 29 May 2026 06:47:48 +0000
Message-ID: <1175310d-5c8b-4a4e-a597-5acca4ec0db8@altera.com>
References:
 <20260527023359.18876-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <a0cdbac8-c7b2-4dc2-b08c-7fae99a73e93@lunn.ch>
In-Reply-To: <a0cdbac8-c7b2-4dc2-b08c-7fae99a73e93@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DS0PR03MB8200:EE_
x-ms-office365-filtering-correlation-id: cee9e07c-7a14-4a0a-3485-08debd4e3277
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|38070700021|55112099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 BAR13zUkPKNYdXhEaJySbl/le1fljYR6RPATwBlhK+UI2SjGf2/2jCYA8E+E0nrE4pBjyFMwJFx5ZNrpHYQA7102JOISY8K0qnq3mKQNbRu9EGT6kB35TeUEz1o+76OwgQ/rG7dFbXLi4kRgonAgKReKa0L8yKqaQ+qiR9uRwAnV/jeM1RXTyJZD5zTwi729WYPulK62U+Fm+5mDlwFu6iOJL44Yxt3KKD2DfWfg7NY6V7YjClnB31VCUj8XkIrAFdzjV+W2r7ZIoliy5IYAtZqzkOXbP2f8BkuqAnijEV0F7sehdTeoTmfYSUXSmyqw2JJiuyEQ/UTGvnM+dK7YevI4qACW5+EIigG8Xty/gOaBEuD12u5I+y6LTw2vpEqthelqPsGtNbmyYQMckDqhdmJWr0SmoRsYoRIVhkK1sR/W5DmBnzuSfix5gT75+vF1e7yoHBuzSY1yOwJjUAxmK8YaB4V7j7vEgLYkYiZeH34A59frupoYu2rKZXFdN0d094i4L/dF5hbtIL/lsfshMv7f3LXW22P+RUQKH2OdXW6fufR5ggeqvdCT+GWlVsoTk9pM+lgxB9XBX7I+GlIqHax/rJ2hwZJuP1HaCImmqlAcbMEuM5g3ZVaSjJF5hiXQkD2FcuMNEtkWNAKHP4i0LF95eUJwuTGve3RRtLBwDYivRkl2TsW4C3+6ImXa3qazpzwwQc03/ac/u5vsoXS6/rm1LLBhjE5dBNf+xAKdUu/ye99miwq/HBQsh29afCWm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(38070700021)(55112099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejhZV1FtRjlNNndWb3oweEdQL21oUi91VVJVdXlMS2cyN0Y1N3JDZlZzaWNq?=
 =?utf-8?B?ZWJ1RGh4cU0zUEwvMXNOWmR2R2NVTjFRL1E5UVIydmFRdlgvMG1vUmVveFdU?=
 =?utf-8?B?RkJsU3JNSHVlcmUvTzNPMzNYTW5ldWZiWlhlNGZvaDB1R1NrS3hRamhzZm85?=
 =?utf-8?B?WUlJQ2dFQXozbHRiZmlqSUZ0REN2VTBlc0UvaXRXejZjeUxRY1B4a0dBNVdt?=
 =?utf-8?B?TlF2TWRTZjFETlFSSFZKZ3VDK3F2UE92MWZBMitrZW1zSHE4S0kvZk9QME95?=
 =?utf-8?B?TkFRekdqSW0wUnY4Mlh1Vm8vU2N1M3RGTDZMSVFqUGl3Sm5KdHowQU03RkNP?=
 =?utf-8?B?V1RTR205VnJWZXBwaW94TUFyb3pHZjdRMllmM0RRRGhXQlRWMjJSclhtY2h1?=
 =?utf-8?B?dTFmTnhENFhkVEpoOXV6UzQwTVFaQ3o0MkRRcGVYbWVRQmRqUlVwR0ZDZ2xG?=
 =?utf-8?B?bDVJVkRBNzdnWk4rTEZRS2dYbC9HQUtJWjVGWnRHTDdyRHVRaEdHd0ExU2Rh?=
 =?utf-8?B?WUZPcDM2cUE5Zlo1aWxPczFyS0E0ZnV1RUFrMk5PU2l5RjNUTlRtU2xBV3c0?=
 =?utf-8?B?dVlPYUFxTGdLVXdyTUJneEhuN0ZJUWE5UTVaWmMwTHE1R0FBall3S2FyZDA0?=
 =?utf-8?B?Wk9yUEdUQm1JRTVhYjRYdEI3a2NzTWFBRlFMQnRoVjN1WmlQc3Y4UFV2U2ZY?=
 =?utf-8?B?OXpSLzcvTUlNMnp3M2RmbFYya0p6QmlVUEovMWdiaGlRMnkxdXdYZFpDNy8z?=
 =?utf-8?B?cWcwUk9mNUY2T3lSYVh5T3hvMWRzQWNKMjNnOFR2WkVpOFNJSG9CU0xNWlpO?=
 =?utf-8?B?dmtXMWltZTNzT1dieFhwWjQ4MDZaVlk2YXI2RXZzU1RrdmVXTFowS09obVhS?=
 =?utf-8?B?UEJvdDFtNjl2aFNIa1JiQ2ZMVVlVMUtmbC9WRlJudFBraGZoRlgxdW04dE9L?=
 =?utf-8?B?RjRocmwwVGJjQWVGVnk4RmEzY2NrSjQrVWxBYXdsWll5Y28vd0VJSm1CVnFa?=
 =?utf-8?B?QmVBNlc5ME4wL1luRU5ObklwVG1DbWpCWXM1dWRtbHRMTEVPQmZlNyttdlRm?=
 =?utf-8?B?bmdMMU9tcnd4emVhNDdRZHpUdEs1eDFxR0EyZTI0YkdWREtoVzE1Znc1MGFx?=
 =?utf-8?B?T3V4d1AzZCs1QTFuOTRrdU5DcHlwdzl5QmsyREE3THpva1A0ZXBhcHdKMHRl?=
 =?utf-8?B?cDUxcjRkQlR0WVRiVWFuN1BKdHZXVnA0bk1xTnRENkxpUjFoaDg4L1J5MjVN?=
 =?utf-8?B?OEFZUTYzUTV3ZnRyQzRrZU1ZOC9ITFh3NTk0UUh3a1hUM3pHREE0cm54Q0Fl?=
 =?utf-8?B?UlRzNk43ZFA0c1hKaW9seTNHV1ZwT09ZQzh4UHM3MURqZ01VUyt3NHRaUXZG?=
 =?utf-8?B?c3RRTXJRTDVRK1c0UFlPR1B5b0VzOHRZQXZxdjBFZmkwNVhWRUxQZTZaZkdK?=
 =?utf-8?B?MkEzelE3Wk5vK2hRMERuOU9IOEpTNDRPN3h5L0kvUVRnNDRDVTZyKzMxNWR2?=
 =?utf-8?B?aGNIL3Z0bkt1QjQvWC9xZ1JIOWRxOGtoN3MrbjVlUm9jMzBoUjNFcGtDM01U?=
 =?utf-8?B?RWxld1N5MlVqOTFXMEZRTXBRenpFOHgzTHZjVnpCeXBtc3d4MU5NcWp0ekJ5?=
 =?utf-8?B?Si9YaTE0Y2VyK1pEWnh5dUIxTnUzWGVNU1FVWjZtOW11djZvcG1lTnBleWs3?=
 =?utf-8?B?WUFjdXRwTHFVQ2V4czB0cEhZTFUyZklPanlNWENQZnBpSzkyaXB1L3FHL1pa?=
 =?utf-8?B?YVRKZ2Yzc3REQ09DSW5ZVFpMeHB1aUlvbHJ5UVBWdmVrdzl3NEJkVlFwMjI1?=
 =?utf-8?B?bDN5TURLQXN5MjdjYTR2MUVIQ2lKZWRxZ202blNhbEtBeFVvN2Zoc0Rlc2Jy?=
 =?utf-8?B?dVpqdnNxbjVPQUNzRmJOODhCY1lHekhWNFY3cDZVUmk0Y3ROQ1o5QnBKQWdx?=
 =?utf-8?B?NmpnUzRpaSttajU5SFNLSU44Ylc0ZXJrTmdkNVAxeGVmMjRJbzJxVHBMcEVt?=
 =?utf-8?B?dHhyTW9LVEtValFSL0tOTkJpbTI4cVR2SVVtcWhxS041MlQwVFg5Qm9LU1J0?=
 =?utf-8?B?NGpaVVJ6RDZ3eXNHejdYRTlUdHArbmxld05EWlgxVGoyTk1FcllCQTVHdzV5?=
 =?utf-8?B?eEhZY3RGT1dRY25hdTlsK3U3UVA3cXhqTmhJaVMrSG9nWkFiOS9LSUNPbjVv?=
 =?utf-8?B?NndWRXRHNTFHVE5YS3hJSEd1aDZadkUxVU9rUEtEME1jZkZpQysrSjVLOGZY?=
 =?utf-8?B?N056TVB6em1lRlpFemEzdUpNVDVMK2JZYUFyNmNValY2SzBJWS9jUi9pckJv?=
 =?utf-8?B?c1BLRTRGVmtER1VFWU94QkxSdU1JdlpEdmdRQjNYK1UxUkFqM3Uya2YzQ0l6?=
 =?utf-8?Q?Pc9SNLsYfMx/o0NSBt/hlv4o+lE18YbVOOHGYpZWPc4KD?=
x-ms-exchange-antispam-messagedata-1: 8QQZqfaGJQ8mZA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDFC743BEBDD654186ABF20D2F914195@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee9e07c-7a14-4a0a-3485-08debd4e3277
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:47:48.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylQYVO7Lvff0mqt/xxjKGKehnFewqsAOPD7Dq+zVjcWjpu0+XWoBVct1AUhWja1PEvJ9x3L87TyB0WJEJvIDVRTYDl3rjj65I+cld21PeTWTegADdXcTfBaqZGaANyVmlYYN7XdCv0IHeVmOJvbrPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8200
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-293008-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:mid,altera.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 603CB5FE352
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMjgvNS8yMDI2IDk6NTggYW0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPj4gcHJlLXBhdGNoIGJl
aGF2aW91ci4gVGhlIG1lYW5pbmcgb2YgdHhfY29hbF90aW1lciBpcyB1bmNoYW5nZWQuDQo+IA0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1h
Y19tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFp
bi5jDQo+PiBpbmRleCAzNTkxNzU1ZWEzMGIuLjM1ZGE1MWMyNjI0OCAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMNCj4+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMNCj4+
IEBAIC0zMzQxLDEyICszMzQxLDE0IEBAIHN0YXRpYyB2b2lkIHN0bW1hY190eF90aW1lcl9hcm0o
c3RydWN0IHN0bW1hY19wcml2ICpwcml2LCB1MzIgcXVldWUpDQo+PiAgIAkgKiBUcnkgdG8gY2Fu
Y2VsIGFueSB0aW1lciBpZiBuYXBpIGlzIHNjaGVkdWxlZCwgdGltZXIgd2lsbCBiZSBhcm1lZA0K
Pj4gICAJICogYWdhaW4gaW4gdGhlIG5leHQgc2NoZWR1bGVkIG5hcGkuDQo+PiAgIAkgKi8NCj4+
IC0JaWYgKHVubGlrZWx5KCFuYXBpX2lzX3NjaGVkdWxlZChuYXBpKSkpDQo+PiAtCQlocnRpbWVy
X3N0YXJ0KCZ0eF9xLT50eHRpbWVyLA0KPj4gLQkJCSAgICAgIFNUTU1BQ19DT0FMX1RJTUVSKHR4
X2NvYWxfdGltZXIpLA0KPj4gLQkJCSAgICAgIEhSVElNRVJfTU9ERV9SRUwpOw0KPj4gLQllbHNl
DQo+IA0KPiBXaXRoIHRoaXMgY29kZSwgdGhlIHRpbWVyIGlzIGFsd2F5cyB0eF9jb2FsX3RpbWVy
IGluIHRoZSBmdXR1cmUuDQo+IA0KPiANCj4+ICsJaWYgKHVubGlrZWx5KCFuYXBpX2lzX3NjaGVk
dWxlZChuYXBpKSkpIHsNCj4+ICsJCWlmICh1bmxpa2VseSghKGhydGltZXJfYWN0aXZlKCZ0eF9x
LT50eHRpbWVyKSkpKQ0KPj4gKwkJCWhydGltZXJfc3RhcnQoJnR4X3EtPnR4dGltZXIsDQo+PiAr
CQkJCSAgICAgIFNUTU1BQ19DT0FMX1RJTUVSKHR4X2NvYWxfdGltZXIpLA0KPj4gKwkJCQkgICAg
ICBIUlRJTUVSX01PREVfUkVMKTsNCj4gDQo+IElmIHRoZSB0aW1lciBpcyBub3QgYWN0aXZlLCBp
dCBpcyBzZXQgdG8gdHhfY29hbF90aW1lciBpbiB0aGUNCj4gZnV0dXJlLiBIb3dldmVyLCBpZiB0
aGUgdGltZXIgaXMgYWN0aXZlLCBtZWFuaW5nIGl0IGlzIGFscmVhZHkNCj4gY291bnRpbmcgZG93
biwgaXQgaXMgbGVmdCBhbG9uZSwgc28gaXMgbGVzcyB0aGFuIHR4X2NvYWxfdGltZXIgaW4gdGhl
DQo+IGZ1dHVyZS4NCj4gDQo+IERvIGkgaGF2ZSB0aGlzIHJpZ2h0Pw0KPiANCj4gRG9lc24ndCB0
aGF0IGNoYW5nZSB0aGUgbWVhbmluZyBvZiB0aGUgdGltZXIuIEl0IG5vdyBhY3R1YWxseSBnb2Vz
IG9mZg0KPiBzb29uZXI/DQo+IA0KPiBUaGlzIGlzIHNvbWV3aGF0IGFjYWRlbWljLiBUaGUgcG9p
bnQgb2YgY29hbGVzY2VuY2UgaXMgdG8gcmVkdWNlDQo+IG92ZXJoZWFkcy4gVGhlIGluY3JlYXNl
IGluIHBlcmZvcm1hbmNlIHNob3dzIHRoYXQgdGhpcyBjaGFuZ2UgZG9lcw0KPiByZWR1Y2Ugb3Zl
cmhlYWRzLg0KPiANCj4gCUFuZHJldw0KSGkgQW5kcmV3LA0KDQpZZXMsIHlvdSBoYXZlIGl0IHJp
Z2h0LiBJIGhhdmUgdXBkYXRlZCB0aGUgY29tbWl0IG1lc3NhZ2UgaW4gdjMgdG8gDQpjb3JyZWN0
bHkgZGVzY3JpYmUgdGhpcyBiZWhhdmlvdXIgY2hhbmdlLg0KDQpUaGFua3MsIE5hemltDQo=

