Return-Path: <netdev+bounces-175197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF12A6443E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2913B0316
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F4B21B199;
	Mon, 17 Mar 2025 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="SmREbsVo"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2116.outbound.protection.outlook.com [40.107.215.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BCF18C33B;
	Mon, 17 Mar 2025 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197754; cv=fail; b=Gs3ck0S0raucFVBG6HlN+/Y7tqOCZDDVKIqxCj+woQH3Q6rz9Wz3o4yUN6gS+c0LS1DYbLTKDhcPlaSl3knWi3F0pl1AgI5qnm1aDmAkqKTWQCU7op6qH5+W7g0ZV9Ln89Kn2aYD2BbDYLg6P6duyhfcLDCNlreU4vTT8a28TuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197754; c=relaxed/simple;
	bh=a0//6qX9fAwjKH6+TptAQlSfNLLEt/yUFgkk2VmHJ/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KvwaO9faVJWCFb7BmN3l1wT/8zZK9JqlJgWmvQ05MTc1yQJvB3NgJlmmSb7gTHVSwsP6WTu+9nu4JbHg2YqcbOS8H/oWrDiO6nbtT6BgUY2OfqdxyM2gbL/BtWvaeQvccbsqQDhoprJxGdPyLkadKMXxygAKQD2a4jKhoYuOuR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=SmREbsVo; arc=fail smtp.client-ip=40.107.215.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=to/QRHxQem2ygnbyhqrT5MD2WVc9ueRa2goahjGHvg6QjISPGdzhQEqc+9fIo1v5K+JKw1nmg5AWGhwpiTXSiS+CAu/Xb+ek22hZfN6OLOdJUSelHsdpPQlMFyfdYEJgCR2+YRr7pvxX+wztXq8Mo28CiZnUJVgHXO6xie6fMEGVuLOqFMu319KLhwz5F7RxGZP9Zhr+jQmWaAf9cG2NvIZkH7mzCdQ8kDbY8znast2KeUTtUe3uO/3Y4/RUB+bOCFfeg5WmXajB9MHbcpkWT8v2zCbJt9OhRuWBM0sHZXznO2b5PHELemhh/9GCkoQzA3DdeEXM35+imlcefeJFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0//6qX9fAwjKH6+TptAQlSfNLLEt/yUFgkk2VmHJ/0=;
 b=dk3ORukWBdKFCMvNn7LXt85kbn4VzOww2xgkqfynQb+3tWblb9/oxDfxUwFBhsmIt3GTS1+Q1IN4/Jb4svDxFtOOAspxbr7tIEc0GYF706IV5faDdP8y1ELIQ3LoRjQxYC/BnhkeEbOqLZdTNfPI0Y6BqRL+nhFfuvmznU60yvbgvdDeBxcT60ZkXO6JayPOi0FqHBBuIc6JUa8OkXwaKOi5LEZeFYLcNvFx5lLgz3beUyo8rx3AOO911LA8a99yJhq526XYfW9n6Yj+8D1lZrEp8WklVO15o/avc3Ge+4Pti5kcO31n7OVrYell6tstoK/YYiKflRzSjxad/sqJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0//6qX9fAwjKH6+TptAQlSfNLLEt/yUFgkk2VmHJ/0=;
 b=SmREbsVosjevx5MXI+2A5HwQly6u3Jddu7lhwWcZbE6ZHnxBcnNO7Gq5Z9YftwRttShUbfCTcdkYKr+XJGgjb9db7jwkl4A7l7pWqypqil63Z+IDonylBMDz9xeGpLlAupXnyxMMDvZD/9HirDWkozA/TNtJommDuTJ6M7n8eFKwxMwBPOxZ+y0+ZZH8Y10tQFKC13+BvgDe9W89cEun5kzOOwp7M2yD2BTOGgMYl9Pu6p87SEdHzAEgBAlusbEJ4DwoqUGavkEKngeRpQITGoIdju/+fviJKxhXlnbqlb7vQT88ctwceIq+Mgr15LI9FIBZbhjT2UhyOz8w3TidPg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TY0PR06MB5443.apcprd06.prod.outlook.com (2603:1096:400:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 07:49:00 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8511.028; Mon, 17 Mar 2025
 07:48:59 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
CC: BMC-SW <BMC-SW@aspeedtech.com>
Subject:
 =?utf-8?B?5Zue6KaGOiBbbmV0LW5leHQgMy80XSBkdC1iaW5kaW5nczogbmV0OiBmdGdt?=
 =?utf-8?Q?ac100:_add_rgmii_delay_properties?=
Thread-Topic: [net-next 3/4] dt-bindings: net: ftgmac100: add rgmii delay
 properties
Thread-Index: AQHbluibakzSkFNvg0KUuHfwK0UrFrN275yAgAACuRA=
Date: Mon, 17 Mar 2025 07:48:59 +0000
Message-ID:
 <SEYPR06MB513482399D5D1DFD62B6B0B99DDF2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-4-jacky_chou@aspeedtech.com>
 <0d5cf176-f084-467b-b4a1-9a1f862d0781@kernel.org>
In-Reply-To: <0d5cf176-f084-467b-b4a1-9a1f862d0781@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TY0PR06MB5443:EE_
x-ms-office365-filtering-correlation-id: 4f068a73-8f8f-47bf-139b-08dd65282dd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHRZcTdRZi9HTHVrTUw2RWh4YnliSG0wTy9oR0FTWTNJMWVJY3FSY2oraThl?=
 =?utf-8?B?dGR5dTNwTm1DbThoNFJmR0pZRjVNOU1yRVBTbkhpNzhMM0NQWFAzVGxQVVRj?=
 =?utf-8?B?Rks2Z0xSakVGdmdZTW5UTWhESmZ5RmFDQy9EdnY5b1JZTjhpMVI3a0JOSjky?=
 =?utf-8?B?MER5a2xCdUZ2VE5Kc3FkN0QzUXk4ZTh3cGZoRWl2dEZGRzgyOGdIQXpqR2lr?=
 =?utf-8?B?Zm9xNk93VHZKcCtTc1c4TUJDQnhSMFBhUDRpWk5YOHVyYkkwMWpyeDljaURS?=
 =?utf-8?B?dElFbTBocFBIckg5V2tKT3FqRCsyNllwSzFlQzNiaXFPUm9yTy9KZ1UvdFo0?=
 =?utf-8?B?RkphTHVPeXlMYU15SU9BN20zODRGS3NXTkt4QjMrRlpwZDB5TysyMUpsYmNs?=
 =?utf-8?B?VkpnNEdmdVF2djRiS081VVQ3L0l6bXljUzI4dDFSYUFLeDZEOVFyM1dsT3ZU?=
 =?utf-8?B?elJJbWVmY096Wk1LUllrMkVZbVdRYVJOdVZzcTBPZHdjcmVOSWpPdXZuUzZi?=
 =?utf-8?B?Y20zRXQyeWZONDVydW81ZENlNk1JVHF3eGRrMmNKQVdmMHp2NWtxMlZwQmdK?=
 =?utf-8?B?Wnd0UlBTRWNsREpqcit4NXZCVHF6b3p5UFRRdXAxT05JOENYUFhOa0IxSkJr?=
 =?utf-8?B?YkdCRy9JZE1ld3JFM21KOGU2Y21MeXk0cFYyNEY5azRDZm1xSUtPLzlYUWQ1?=
 =?utf-8?B?bEloY2tQclhJeGpvU1lDck1LM3hRTUlZcmIwQXBlNVowZjBEK04zeHhqckVE?=
 =?utf-8?B?OVcvQ2pieEJaZW5hRjRKSU1MSVpib2ZIWCtkWjFWbWdZYytua0JNL1p3VEFo?=
 =?utf-8?B?KzhINnkvU0VpVFd2UmJtbkg5dkZ3YkQzOWlBU3JWenhUaWRiU2E4aTJEelh4?=
 =?utf-8?B?THRHODNaME9OUHJ4NXJqeXF1OTlQN09NYnVwSTFwMWFEZGQvQUlNSk05WENQ?=
 =?utf-8?B?SjNMY01qdC9WellYVjlvd2VSRURsQVA2MWpDeExmZWpBUVJtQlJNYUlYalZ6?=
 =?utf-8?B?WW1PZ0ZtQzBiNC9BMmlMS3d5dEFZRUZjL09uY1hXaHN6ZGNpamRRTnhOS280?=
 =?utf-8?B?ZFVZMUltcTI0R2lqSkJSaVQrOFFOZ3RWcFhpUUNHR21KUGNtYnkya2RXMjBK?=
 =?utf-8?B?RTVEUjNyMFh3djYxK2RDblJjUit4ZDQ0bXRmRVVRTGpGRElibHVFOGFoamZJ?=
 =?utf-8?B?R3JIa2VQK29oYVV0VXB1UTM4d1ZUeEdXc081cXRkbHJrbEZUZS93d3EwSHRG?=
 =?utf-8?B?SFVieEJMWUljbkNYc1c2WG9jR1dObXNnbm9mKzhlREhHVFlKeGd6ejR0d3ZY?=
 =?utf-8?B?cTdPSmd6MFZGNnZmRm1tVzBkQ2pSd2NhUWY0R1hNRDNBUWozdllKWTduM0RS?=
 =?utf-8?B?REJobHA4NXpjYm9IcTAxVVFlL2ZvNnJrUThLNUplME5XYitqWURVTDVzZUZ5?=
 =?utf-8?B?eGY1V2R6bU80RGVuODR2UzVoSmdCLzJSYm5Wa1NvOU9uMHgvVE1ObWhGVXcx?=
 =?utf-8?B?akgvOCswb3Y0WVV1YkNQcW5Xa2pXZHFCWVhUc3FZZWJFKzZsN1U1b0NSaGdy?=
 =?utf-8?B?cGd6WTJ3SHhPTGswYjRWYzR3WkNsZnBDUytWMEtNT0c0TVRGb0RHRU1TR1JH?=
 =?utf-8?B?Q0hTcnVNdXNJWTg3L3NrM2RvY1NucVZTK3BsUG9kQ2lvNll5ekgyTmlWcnNy?=
 =?utf-8?B?WXlLYUIzNkJmdCtxdXU3eUNJWkdQckx0aTd5OTRXYlhuMG9HS3UxQUJscURX?=
 =?utf-8?B?OFphUlo4NVdsY01uL21kVzlIQzJQUWwwVEVOeW5ndE9yNm1zcEtnQkViWE9Q?=
 =?utf-8?B?a0NnRlNvU1YvZVppdEJIcXh3MmhvQ2I3dUd2ekpvbE4rdUdjNS9ZSnd2bVRi?=
 =?utf-8?B?WmRsMUVnWWVJMTVjclhZMERXUWExTlRwM0lKeFY2OXVVSmdSTTJsamxVdUNq?=
 =?utf-8?B?MEZ3R2VYcmdjZElreGdyTmxFR1NqTWZmZ2xlQyszUHMyZjBZejFEcGpyWEdV?=
 =?utf-8?B?akV4MUE2WkZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzhuMUcvQjZETEF3REg4aUdHR3lGNEtnelNRYTJPcHdwckN1ZWdISk9kQ0ph?=
 =?utf-8?B?RVQ0M0VvQndNUHZBWHlGSURPYWpvdFJGSXpWcDJFdEIyWmRTVEdSNnJTK3Fy?=
 =?utf-8?B?cVI0dmljYmhrT1Z6TVRYT3ZSc0lDQk8wVkVVb1lzOVllWEtYSWJxQTBPT1B2?=
 =?utf-8?B?TmRkUko0RXJ2MUhRQmFIK2FwbE94USttT0g5dDNWR3FqQ3lqeG8vZ2Y4cno5?=
 =?utf-8?B?YXpYQnNacHl5ZVdWOVRiRXRINVYwcTRZZEhiMWNzZ0Y3Y3o5Wi96TndvOGQ3?=
 =?utf-8?B?VGloT2ljbWR3VlZVWVhiTk9lSEZWMmxsbGNaZ3VnTHc3c1QvWi95OWozUUlR?=
 =?utf-8?B?YVM1MnVpZlRXZGNYeG1hdmJ3aG1hdTc2am43VmpHc0hqTVNRWkFKa3Y0REw4?=
 =?utf-8?B?SG1kS2djRFFkL0NnajZxRlJvUnFsMTI0RjFhcXpLSVFOREt5dVZqcUVyaUps?=
 =?utf-8?B?b29TTXRtY1BQU2tUcitzZXFpTzlINFBURll0NS93dHJzRWtqeXVqOTJsb2p5?=
 =?utf-8?B?R25RZzg3bjRjN0JTVllBbVdOOVJTWTA1UUN1Z0F2ZDZJUWY1V2tXcGRXUDhh?=
 =?utf-8?B?Rko4dGc2OTdEcnRlVVZpRXJ0QkJBcnRwQUtkdGNaWkx2d25naGdtVWxtcVgy?=
 =?utf-8?B?VGcvMEtDSjk2eUVrOWFJRjMzRWhoeDJiRjdVNEtGcmlkZWN5UXIyVkdZV0VW?=
 =?utf-8?B?d2tYMFk5ZmFIZHhPWW1DYkt2NXJvM1dZVUdMaHl4dmtDN2JxVEQ4MnQyOEVI?=
 =?utf-8?B?MXJ6QTltbzFFbEFTNGJPZDFpM2pIZi8zVjBCQmZUNVBmUlRwajBwSEpMVklY?=
 =?utf-8?B?VHpMbmN4ZzI5eGJ5YXNMRFJBS0h3NHFtWWNpcm5sYmJiSW5CREhGaFlXWWg4?=
 =?utf-8?B?UHd5ZXlzUmZydzBPYlBMQ3Q5SGo3bTN3ZS8yS2dINzFmYXZYQ3hITzN6dm13?=
 =?utf-8?B?bnRrOUZvS0wwMmhWRnVwQ2xJMy9ta00wbUt4aUZqWDhaNTF3NmliWU1nWWhs?=
 =?utf-8?B?UUQ3bFk4Z2RuSEMzZjd2VDdON3NCVjEvdkxDM3JBdVIxcGNqMjRJWW9KOEZo?=
 =?utf-8?B?bE16aGdaNDViRytrS3JnQkYzb2pEc3UxV1JqUkdRMTM2WmlwYjM0NXFQRThi?=
 =?utf-8?B?VEFFZTVMcUZLNHc3cncrU1gyRElHS09KRmYwc2d2RWZBbGZrL0U3L0prQlgw?=
 =?utf-8?B?d003cDBHeHFQRDkvNC9MTWY0RU12ZkRCU3NJVE5xcGFXSUtNRTRpY0s0dmg5?=
 =?utf-8?B?c0haYmtrT29WY29TY1JUbUlKU3M1TzdmY20zcUJKTno5SmR5TFNOajZDTC9i?=
 =?utf-8?B?TUJaajZnZDdLc2kwN3g2TmhrWWo5VzB1UE1HYS9Na25PeHFCczlQbnc5ZkZK?=
 =?utf-8?B?UmVxT05WdzloTEd3S2lrc2NUVkw3cmw3enZTUmZaaFRlZklnMHNKeVNJOFRx?=
 =?utf-8?B?eE9BTTkwZnUvM0Vyd1hRUlZzMHB4NXNpY0w3WWxPYzIwbjgrZWxIeEZiRzJu?=
 =?utf-8?B?akxsbnVjYTlLaUVqOUFGNmRwRW5oUVhjL0VIcm5VWFdxS2tFM2RDMHdEWnBm?=
 =?utf-8?B?U002aUZTNm5LWEJwbnh3ZDFOVmQ1c2dpaE16YlN6MDhEN1JSQW45NkJLVjcx?=
 =?utf-8?B?T2ljSXpWWmk1bEozcFZlYkZ2clZNVVJTWXJXNlVyMjg4ZVNVZ0pLSEYya1FM?=
 =?utf-8?B?eFlhejBMcWkwK1BZeml3Q1ZlNzhrVFlhMXI4eWxQRFVlekpnUlFlTDFlVGo3?=
 =?utf-8?B?K2VtLytZT0ZQdE1BMjhubnZPL3dUUDFyUzFHcm9NalF2Q29RbUNva0tBaVR1?=
 =?utf-8?B?TVVmWWFjNVBHZ3hEOFlxSW1kTU5TclNkZVdqMlhSRlUrSVBTUmN0S1paM0Fk?=
 =?utf-8?B?WmtMQ1BGWU8xL2NQMmJCdXFyOE5uOXBPSThscjBSVFdJZmhZVWZsYlRpbnZu?=
 =?utf-8?B?TzVFU0hRS2JxeGhWS3lFeGpaVy9CRWYvRjM3dm1JRGFZSlBMV1FtZW1Falhw?=
 =?utf-8?B?RFVoUVhXZGNaQUpBMDJBb2NPRmdZaUxDMi85U3NNQjRKZlJtK3FWZS90Q1Uz?=
 =?utf-8?B?dHJmcWZkcE5MVVduNmhnU2VUdCs4cGVTaFZXeUpubXhhWlpka09id2M1aGNL?=
 =?utf-8?Q?xGdXoXP+EdJnX9egLd12ygG2z?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f068a73-8f8f-47bf-139b-08dd65282dd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 07:48:59.8222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3GoUBurTnL70GPQggArBAviYfRLfZxMpNEXW32hucwGoA+yH79tBUDe69aKMkZOIe4RYskifiuzdyvy49KNC29dFyNWMkrGya1SJcSyINg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5443

SGkgS3J6eXN6dG9mDQo+ID4gQWRkIHR4LWludGVybmFsLWRlbGF5LXBzIGFuZCByeC1pbnRlcm5h
bC1kZWxheS1wcyB0bw0KPiANCj4gUGxlYXNlIHdyYXAgY29kZSBhY2NvcmRpbmcgdG8gdGhlIHBy
ZWZlcnJlZCBsaW1pdCBleHByZXNzZWQgaW4gS2VybmVsIGNvZGluZw0KPiBzdHlsZSAoY2hlY2tw
YXRjaCBpcyBub3QgYSBjb2Rpbmcgc3R5bGUgZGVzY3JpcHRpb24sIGJ1dCBvbmx5IGEgdG9vbCku
ICBIb3dldmVyDQo+IGRvbid0IHdyYXAgYmxpbmRseSAoc2VlIEtlcm5lbCBjb2Rpbmcgc3R5bGUp
Lg0KPiA+ICAgIG1kaW86DQo+ID4gICAgICAkcmVmOiAvc2NoZW1hcy9uZXQvbWRpby55YW1sIw0K
PiA+DQo+ID4gQEAgLTEwMiw0ICsxMTYsNCBAQCBleGFtcGxlczoNCj4gPiAgICAgICAgICAgICAg
ICAgIHJlZyA9IDwxPjsNCj4gPiAgICAgICAgICAgICAgfTsNCj4gPiAgICAgICAgICB9Ow0KPiA+
IC0gICAgfTsNCj4gPiArICAgIH07DQo+ID4gXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlDQo+
IA0KPiANCj4gVGhpcyB3YXMgbmVpdGhlciB0ZXN0ZWQgbm9yIHJldmlld2VkIGJ5IHlvdSBiZWZv
cmUgc2VuZGluZy4NCj4gDQoNClNvcnJ5LiBJIHdpbGwgbm90aWNlIGFuZCBjb25maXJtIGFsbCBv
ZiBwYXRjaGVzIGluIG5leHQgdmVyc2lvbi4NClRoYW5rIHlvdSBmb3IgeW91ciByZW1pbmRlci4N
Cg0KSmFja3kNCg0K

