Return-Path: <netdev+bounces-149562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E58E9E63CE
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1C9282E44
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959EE13C8F4;
	Fri,  6 Dec 2024 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="rkLALOJB"
X-Original-To: netdev@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020101.outbound.protection.outlook.com [52.101.128.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7878B60;
	Fri,  6 Dec 2024 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450261; cv=fail; b=ovtoIo/Edgu3BEEokgPbHIzSJMZiKQKukaW3A0TGeSgHG+lxbnp+i/OKozUFH/Kv8vcL4PJBsgl5uf6ZVcrCFOlARG0t1XP+Me9lG2pgntkK/JCsRL2F982n35LPtrWFcgN21agYCTwhDuuAqF5mO6M8SytrUB+MRau+w4jId14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450261; c=relaxed/simple;
	bh=I5DVmDfoD/4KJeoVGQkYEwhAWDNyjm6/1mKAuPDcFlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BKyFcVU0cWwJiPLyCMtXWPczKpmsSv5vrBMuMKTuZrvA2SW/KI3MlPMCUGDSEuOtzN17LD4c9Wf2bE7IijgkYauNL6A3j1HElfXz3sBv5H6jGAFdtO0aZNXyWuQ6yd/ltMI/YIbqwWYhtuubt9XX/uirGITydBf+Xo5Q6PEOBzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=rkLALOJB; arc=fail smtp.client-ip=52.101.128.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jL8EDdoX8LUEPjQzEUyD09cU7GADxtxSHCbtOJLWACY4pYi15ZIgjI23iPi6PpMBSuH1DDoxRPIu7/9FNhX0dOOTpwaFCz+LCSNRW23zM5X0xkqj8KwiLQBpN34wn8dsDrqpBVuVn+u1HEYy8PPcdEfLTliR2Z3RE5kOvxGvOhkHR6kFDuqwjTLzrqSUg9X/OfeZiZIMV1w/7eolZeyoV+LpJWwqWGpnzGxoRoe62mmzHfjz9TpsjwTgFz4a8NZ19WlU9rOpaPz7Zx3h/NhmAHo+iFihB4/P3vCL2D5p9ykOid+WkWwhazKhD7spebKM6PZSlRJ1xbASqisbrRJ7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5DVmDfoD/4KJeoVGQkYEwhAWDNyjm6/1mKAuPDcFlc=;
 b=cYLFpHUg++uBie8uwBUuBbt8imFn4QsVHr/Ix0aHIdLzdYfTggFKmhX48vQJW+9JjpcE630eclhdNpXR/ZMkuw/0SwUyQtFtEZNgB012jyNJDrDzKhXuors/oWZCTyAH/jWGWa/992ProriEbKmhxedGT32m1xFHtywclTs70xlBx9jz9JUhXEYvhA75b+ZuXJraa57tucrOOvZbMY9kuN9fiPhfTx7cINlNqi5vSYM1zbTqusHFXXO7WaByGMUUov+Yqf1/V+VWobdo5T5nKQCWoizqW07Q55fm4dzn62uYafqzFuQjJ6K13W9TScPgRpntTdB+T8wJ02qtRp+iQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5DVmDfoD/4KJeoVGQkYEwhAWDNyjm6/1mKAuPDcFlc=;
 b=rkLALOJBDwmJ4RDe3/Iaulh11xc4kbvtFqynTLH4GEuyVo0nqkQg0G7u+60kgtL2Djzxbf3H9xwlVXG/lOoRZfg79Z1GtP+ue34zwkY/hp4sJdk7jYpB90PB/4zQ8+WMlff7/ynHSQf6kBZXcR0VN9/J95IQNETEqPD7EsRbaq5kD1JEhInYukJrlFVkwJE1VhETbo/P0+9BI2RQWzrnoL0t8lD4zs6OUaaT6BUI+uURHiEZeZ/PrR4McXjITcLqHqrcfdVd7R5/TYC+/8lpIo6fsAb3GtxHS2MgcgqbfCI9wx6aOGKyeaZjmrsxc5jUcmH2N+WlfE6rJ3kbODRmhQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6953.apcprd06.prod.outlook.com (2603:1096:405:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.8; Fri, 6 Dec
 2024 01:57:33 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8230.000; Fri, 6 Dec 2024
 01:57:33 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHQgdjQgMS83XSBkdC1iaW5kaW5nczog?=
 =?utf-8?Q?net:_ftgmac100:_support_for_AST2700?=
Thread-Topic: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: support for
 AST2700
Thread-Index: AQHbRuY5FffynarTF0OvfHW16Ng5+rLXYPCAgAEUZ5A=
Date: Fri, 6 Dec 2024 01:57:33 +0000
Message-ID:
 <SEYPR06MB5134245024FB21E4D823ADCE9D312@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
 <20241205072048.1397570-2-jacky_chou@aspeedtech.com>
 <e6hwuf5mtr5vwm7d2jn4raewinkwpswyceimahur3xnpi2zyqs@t4cqgdqilerq>
In-Reply-To: <e6hwuf5mtr5vwm7d2jn4raewinkwpswyceimahur3xnpi2zyqs@t4cqgdqilerq>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6953:EE_
x-ms-office365-filtering-correlation-id: 73e2d8c0-7472-42f8-3806-08dd159959c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2JsblFkMUVRNmhHUmVwTFhQZ05pa2l5SEtHVGIyd3I0WU5TZU5JZDRXV0kx?=
 =?utf-8?B?SVdSMjRWZlBMamI3S2trMUwzMXFVc2Iwc0o2Mm95M2pER1RKZTdqeURPTHg5?=
 =?utf-8?B?RG45UUx1VUkxa1oxQ3RScW8zb1NSaGljK2xuQlA3ZjNjT3pxRHhLWU8yd0JG?=
 =?utf-8?B?cTdxOC9XWThSdFNFUGtwQTdEbkoyakFsREVRdDlBcmhlM0dMQTYvVEZPYUlp?=
 =?utf-8?B?Z1A0akxMb3VVdExVY0RtTDB5WXJaSXRsQlpIVWh4cWZwT0FVK3ZSNVFSYUtt?=
 =?utf-8?B?SzJXU05VaUFVVERjdk1rN09jY3YzbHRRSGJXbm1FUVFLUkdBSGpkNWxlY0JK?=
 =?utf-8?B?T0tTQ05pY0cvZmxvL3VFSTh3SmRRdWRkSGl6WXNQa0c4REtDSms1MytYMm9E?=
 =?utf-8?B?eWlOdVVwdmdHalJ5M01pbDBkeGhVMUhNZnR4elZVNFFxVWVTT0FrZzZVb3hl?=
 =?utf-8?B?bk1UNFJBU3p3R0VFb3dzQUR5dGh0UjBvRVQrckE2by9hamUwQmlVZ0xpVzRC?=
 =?utf-8?B?WHM2b0JXR1ZTUlVYY2NmRThDaURDUjRyTDdQQkhYU2RGQlFMdktrZG85ajNZ?=
 =?utf-8?B?aHBCaHF2ckRhV2RiWDJGVE95aklGSEgzY3dOU3p3eFNHT0IvQzJEQjVpMys4?=
 =?utf-8?B?RFQxdVNlMStUQlc5RWh5ekxHOWNhNGpPM0FjVDdnZHI1WFpaLytDbWJSNTg4?=
 =?utf-8?B?SStibGszQWpFODQ0L2g4QmNEbXRXUGJPQ045cFdxTmIzck12YlRzR3pTL0k4?=
 =?utf-8?B?Q3V4N2ZzSnNIbFBFTGlBZENIQ0hHeUE3aEliREQ5bldZM0EwRk1LQ3NTcVhV?=
 =?utf-8?B?LytUblhqTDUzbmgrRnFaTk9qQk00SnNpWjZRU0YrNi9EcGVJWm5VaTRHZnBI?=
 =?utf-8?B?UEVLNTNYVTNmZElaVS8yWkZ3KzJESFNEdGZtSFg3WjhlQUh3TWtHTVVhaEZt?=
 =?utf-8?B?OVQycCtrcktXbUcrNkR2dDY1Q1dEZFl3eXM5RlkrQXliR1pmL0xGRWo0Yjgr?=
 =?utf-8?B?QlZLajYxUGEzL1VEdTRmaDZIcTZiaEk5c3hOdHhkTlJiaG11Qmg4aUN0bW05?=
 =?utf-8?B?TmhxUVhTa1VobkZ6R1NySWQ5T3l6dllGRjUwK2J5K2F6VEVKUURkd0lqdklv?=
 =?utf-8?B?WnZlNC9yTGJReVVxeTJSQ2x2YllhUFlMTHE3T2xQNE1uNXd2QkFPY0lhU3VQ?=
 =?utf-8?B?Mmg2enlnSVNJWndxVDhjOFdob0Q3NTNRUjBxTjd5dDU0Tk1BZjBtaU8yY1BV?=
 =?utf-8?B?NWc2SGJYUTU5eXg0VmRmZXl0T3ppMDZtNWNOSTRadk1sMjA2bm9IMVVBTXhB?=
 =?utf-8?B?UUttZWdaRkl0b2pjaFRRZFIzVnRFRWIwcStGSkZ2Rms3ZTFvSmtiTHFncHM1?=
 =?utf-8?B?dDlBMHhuVEx5aTVPU2pNWThlZ0c3S05ldWdGTWVaRUZmbzlrRUoyMFBzTGxa?=
 =?utf-8?B?WDl2YmhyMHJrdmh2eXZzRzI1QlorYVN4cEZQR0cyOXdSaTB6MGpHMGNlTFFs?=
 =?utf-8?B?WFhveU1od1BBV2xxbFQxS0twU2tTblU0SlZVY1ZsVEZ2YW82UHphNU1FZWVa?=
 =?utf-8?B?RngyU3lzQWhiQXRHWUJqbWNrVjlMa2tOVSt4REphTUFoN3FHRlJ5M21kaFhi?=
 =?utf-8?B?VW5PN2FNd3ZndTdETC92YzRacVBVdXVCRWloVm1sdURzbEVqdnU0dHZlb003?=
 =?utf-8?B?TUhZNXUwbUJ0V3NKQ1F4YlloOGdlZWZNeCtGbHpIZHE3bEVsQlE4YnlZdjRF?=
 =?utf-8?B?ZjNPWDRUTnBRZXg2WmVoWXQ2eklWUHc0TGI2RkcvNjIxNkdCbWc4ZWlkK3Nu?=
 =?utf-8?Q?apXBm+DPoO3P/DgQNsOtMsUpePvFCN58QuAAI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alY3ZzNpL1Q2TkY3ZUc0dkFEa2s5NlEyNHhzd2pRbUR0RXRnVWM0WUxEUExk?=
 =?utf-8?B?RVcwbFFxR2w4ZlFpT1FFYW5qZWUzdWw4SnNPbUJJVWNIWXNvNCtENzRZa0pJ?=
 =?utf-8?B?RVZPajR0ZVNPQy9mU2lRS092Slp4TTE3S3ZubUJlVTNSdWg5U1o1T2wvTmxi?=
 =?utf-8?B?VThEQ2thMWdlTXdvY2ovc09PTFJOaHpIZFJySTVrdEpURUUwMmVvYkdZcHQx?=
 =?utf-8?B?UE1waStmUmptemI0S25CTFFjUTFJdnFWVkZXMWkrRGk1U3NRS1FJSUo1K3Nq?=
 =?utf-8?B?ZGJuZkV0MUxxYmVGRVZnd2RMQ0x1Y1VTVzJEZWVjdllPbEowWXlTQUp6NlhY?=
 =?utf-8?B?K3ZCb1V5RzMwQlJIZEI1ellxZUU2ZXNSZkVwQWtOMWpvb3BNY25oUXVpWDJq?=
 =?utf-8?B?cUpLTWx2Z3lNWVI5UlNCUHhHSzhnMlZVZG5OdTJNQlZjY0dURXRqd3ZTQklH?=
 =?utf-8?B?UUR5Z2E4MFY1SDNkNnBrcjI0bENTVjI2ODdzVTZoc2pnbThheXpWR3VDZ0xx?=
 =?utf-8?B?VWQrc05QUDc1VThUajRvZnBYS2Q4STIwUmpoMm9iN2hrcEsxb3JqdHpvcWFZ?=
 =?utf-8?B?QklCZEk4Y05QS1dZS3pBZlliZUJudEljeWljcmxmcVN3alBZNE1tM21nMFdl?=
 =?utf-8?B?TWdIb2NXT0o4TGVIeldPclVsWGlvaWJ3eDFLRWFaTy8zOVZoZGFpbW1zWkZM?=
 =?utf-8?B?N2ZoQ2d4M2E1cHE0SGUwZCtnVFVnWXVVTjJmRTBwVzY1UnM2RURTcnZqSFBU?=
 =?utf-8?B?TC96V2I2U2lLYlpUQzJGZmt5NXpYYi9lTm8vd25FWWF0YXJLdkRhVDc2SG5N?=
 =?utf-8?B?Vk43dERDemdYMGw3NDZQWmdyQTBZWnY1M0lMMkxraUxRNm1FdnZjei9HNkZJ?=
 =?utf-8?B?TE93SkpYQjNvSGIwUDFLNmcxeXNMdW1XOS9OUWFFU1kzUWJjcFpXWlpMWWtv?=
 =?utf-8?B?WmlDUTJzSFlJZ2h5YytnZlIzbk4wdWRKVzMwaGdkKzBZSW9IRWpVaFBGdlNQ?=
 =?utf-8?B?YXJZWGlBL05qa29yQ3pnazZlREdMTjltY1Myc0RkS0wwaENwa0JvYmcrZ1pU?=
 =?utf-8?B?TWtHS3VuaXlsQkZtaGRqTnk0RituQlJkdkVUMDlmNDJuNXJOUDN5ZjMxL2cv?=
 =?utf-8?B?dTQvcld2cm5SK2lmOTd2TWxRNTZWVEM2VS95alpWTFFLUzdRS29vcDMxN3Q0?=
 =?utf-8?B?SzM4WG1TSk9YaUFtOTNTWGFNWGZ2LzNPZzYzcjRqTG9iL01YS2R2aURXK1gv?=
 =?utf-8?B?K0NjUUY4Y3dOK0ovdnViWkliMFFMc3FHYS9hdnk3ZlBNSVBLdEgyQ1R0bnAv?=
 =?utf-8?B?cmluaFpnaDg0bEx6bXlFUXg5eThaR2VqZ1B0bUhhZDRhQURwOTQwMk9wMUhE?=
 =?utf-8?B?SnB1eVRBbzdodEpheExQSlI4alpGQ3lQVFJIby9idm5NUmVPbUk5ZDkxNFNv?=
 =?utf-8?B?bkRtM0Q1cmJ2TG53WC9OaXJ5SnhQWVVJSmNMN0RxNG40dXYxaFBObGVIUG9V?=
 =?utf-8?B?NUZrM2xBQUZhc1V6WFV5TGJXWFpWWlJyT0k0WXByZlhGOTBrKzJlY1FGQjVP?=
 =?utf-8?B?aUFYS1NRWnNWa3JtL256QnQwSTZlaTFkMlorb1daL2VGOVZVWDFyTDcxUVFl?=
 =?utf-8?B?dHEvendQUFN2MGNaMVdnc21oK2ZORmtoT3YzSW9Qdy9pUlJKMlRrUjB3YXdL?=
 =?utf-8?B?cEhEN2xRd0MwVldHeGVlVitiTHl0cFZkSXNZeEdRTTNyTEZ2KysxdGdKNFJG?=
 =?utf-8?B?dW05OHVoMHlFQ3h6dnlLci90dzBYczFIOUtUYW8zaEZmTUhjQWdnT2I2SUxh?=
 =?utf-8?B?aXRQZnVzZnFmb1EvY2UwRWE5MzliZkk5VllwcythRS9ITXpBM0lEV1ZyUVlK?=
 =?utf-8?B?QVIxUVNBT3k4a0dQSitkNS91MFh1UkdSK01nU1JmSmxhVnZKZFRQbjM5SzhD?=
 =?utf-8?B?TXhLaC9lY1NsQzhhb25kSzF5YnByMXZpR210bE12Z2ovYmJneVYwWmZjQWdX?=
 =?utf-8?B?NmdqWlBlNW14T0NTalM4SXF4T1hub0lRaTdhd0x2TFJnVkorTVkvbWRyVlNO?=
 =?utf-8?B?VkRJNSt5U1hyK2NaV1dNUUdkUVJkZ25TUEN2d2ttRElUQjZnYXhlT1lPL013?=
 =?utf-8?Q?YNk0432ckaJ6ekFuSFzshHRJa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e2d8c0-7472-42f8-3806-08dd159959c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 01:57:33.6629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /SWEw5WU8WpERSYwWW1GYorZvMdZrhBtLyfz2G1eA3FKJ/xsDPgsj0nRar7Oq4FtZec3cG4bjjxZJhy/iaOFv1FSNYMDV3/ugDvPMcZxgDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6953

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gT24gVGh1LCBE
ZWMgMDUsIDIwMjQgYXQgMDM6MjA6NDJQTSArMDgwMCwgSmFja3kgQ2hvdSB3cm90ZToNCj4gPiBU
aGUgQVNUMjcwMCBpcyB0aGUgN3RoIGdlbmVyYXRpb24gU29DIGZyb20gQXNwZWVkLg0KPiA+IEFk
ZCBjb21wYXRpYmxlIHN1cHBvcnQgYW5kIHJlc2V0cyBwcm9wZXJ0eSBmb3IgQVNUMjcwMCBpbiB5
YW1sLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFja3kgQ2hvdSA8amFja3lfY2hvdUBhc3Bl
ZWR0ZWNoLmNvbT4NCj4gPiBBY2tlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWlj
cm9jaGlwLmNvbT4NCj4gDQo+IA0KPiBZb3VyIGNoYW5nZWxvZyBpbiBjb3ZlciBsZXR0ZXIgZG9l
cyBub3QgbWVudGlvbiByZWNlaXZlZCBhY2suIFdoZW4gZGlkIGl0DQo+IGhhcHBlbj8NCg0KSSBh
bSByZWFsbHkgc29ycnkgZm9yIGZvcmdldHRpbmcgdG8gcmVtb3ZlIHRoaXMgJ2Fja2VkLWJ5Jy4N
Ckkgd2lsbCBkcm9wIGl0Lg0KDQo+IA0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvbmV0L2Zh
cmFkYXksZnRnbWFjMTAwLnlhbWwgICAgICAgICB8IDE3DQo+ICsrKysrKysrKysrKysrKystDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L2ZhcmFkYXksZnRnbWFjMTAwLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9uZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbA0KPiA+IGluZGV4IDliY2JhY2I2
NjQwZC4uM2JiYThlZWU4M2Q2IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbA0K
PiA+IEBAIC0yMSw2ICsyMSw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAgICAgLSBh
c3BlZWQsYXN0MjQwMC1tYWMNCj4gPiAgICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNTAwLW1h
Yw0KPiA+ICAgICAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI2MDAtbWFjDQo+ID4gKyAgICAgICAg
ICAgICAgLSBhc3BlZWQsYXN0MjcwMC1tYWMNCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IGZhcmFk
YXksZnRnbWFjMTAwDQo+ID4NCj4gPiAgICByZWc6DQo+ID4gQEAgLTMzLDcgKzM0LDcgQEAgcHJv
cGVydGllczoNCj4gPiAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gICAgICBpdGVtczoNCj4gPiAgICAg
ICAgLSBkZXNjcmlwdGlvbjogTUFDIElQIGNsb2NrDQo+ID4gLSAgICAgIC0gZGVzY3JpcHRpb246
IFJNSUkgUkNMSyBnYXRlIGZvciBBU1QyNTAwLzI2MDANCj4gPiArICAgICAgLSBkZXNjcmlwdGlv
bjogUk1JSSBSQ0xLIGdhdGUgZm9yIEFTVDI1MDAvMjYwMC8yNzAwDQo+ID4NCj4gPiAgICBjbG9j
ay1uYW1lczoNCj4gPiAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gQEAgLTczLDYgKzc0LDIwIEBAIHJl
cXVpcmVkOg0KPiA+DQo+ID4gIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gPg0KPiA+
ICtpZjoNCj4gPiArICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgY29tcGF0aWJsZToNCj4gPiArICAg
ICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAgY29uc3Q6IGFzcGVlZCxhc3QyNzAwLW1hYw0KPiAN
Cj4gMS4gVGhhdCdzIGEgc2lnbmlnaWNhbnQgY2hhbmdlLiAqRHJvcCBhY2suKg0KPiANCj4gMi4g
VGVzdCB5b3VyIGJpbmRpbmdzLg0KPiAzLiBQdXQgaWY6IGJsb2NrIHVuZGVyIGFsbE9mOiBhbmQg
bW92ZSBlbnRpcmUgYWxsT2YganVzdCBhYm92ZSB5b3VyDQo+IHVuZXZhbHVhdGVkUHJvcGVydGll
cy4uLiBpZiB0aGlzIHN0YXlzLg0KPiA0LiBCdXQgeW91IGNhbm5vdCBkZWZpbmUgcHJvcGVydGll
cyBpbiBpZjp0aGVuLiBUaGV5IG11c3QgYmUgZGVmaW5lZCBpbiB0b3AgbGV2ZWwuDQo+IFlvdSBj
YW4gZGlzYWxsb3cgdGhlbSBmb3IgdmFyaWFudHMgaW4gaWY6dGhlbjogd2l0aCA6ZmFsc2UiDQo+
IA0KPiBFdmVuIGV4bWFwbGUgc2NoZW1hIGhhcyBleGFjdGx5IHRoaXMgY2FzZToNCj4gaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTkvc291cmNlL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW4NCj4gZ3MvZXhhbXBsZS1zY2hlbWEueWFtbCNMMjEyDQoNClRoYW5rIHlv
dSBmb3IgdGhlIGluZm9ybWF0aW9uLg0KSSB3aWxsIGNvcnJlY3QgbXkgcGF0Y2ggYW5kIGhvbGQg
aXQgYmVmb3JlIHRoZSBEVFMgaXMgcmVhZHkuDQoNClRoYW5rcywNCkphY2t5DQoNCg==

