Return-Path: <netdev+bounces-175598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14974A66975
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCA317B551
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 05:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042B41D6DBC;
	Tue, 18 Mar 2025 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ZXsW/aIy"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42891A5BAD;
	Tue, 18 Mar 2025 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276054; cv=fail; b=frCSE5BULB34a4Hq8lMPdBySF4aGf93mZamD1+5FSgU+dj+EcqqnWmJWDjHBoHLMJFAeynWcwqrYzHyQSG8T/ueNtxMEZ5ULJw5kOLxJS3kZXPFFeMNmEMEvYvamHVbBNMEkZ3E3jnA0dDp7RigLKyUr7QXZ91UukOp0o7IlI9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276054; c=relaxed/simple;
	bh=QN7ED3sG9y4bLnUB+bMD6Q/1SdKfO8SikofzqfVau/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uiddz4hHMCELgnu9vo4m3GGpzk2hAVeG5KuwRY9UaflPTl1eEPas0Ec+VRsBrpl2k8jX3OR0Izhv/LSr2/YYtMv506CdPuxmhkJFCE+3CNxX8sFwxtegY0YW0kRJIl/x7gjmlvGahECXaM+EvXQ3lqcheAfzKWNzZ2t2vJjnZ/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=ZXsW/aIy; arc=fail smtp.client-ip=40.107.117.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nslgn3UxmpoY2Iy6RuOH/9NAJ7FMKaELDIjTm/EzrMGEfIVriag/P8CseXAdVXiT2p63iaAeqp36NThWpdkgMsc1Ge/MCcZgQdaoiMVk500dC0LhpqEPWrNoCbSBnhDN3zj+rCS/KjOBaa0Sv5Pmf39ssXl11Pl6MtvhKonxQP9Yw/1enrW/pqRkOjkrOkHyn9HbMPC/HxDERkaNySUB9wXGOqe7tcvY92haTOncZk07EITE4Tn15pDdkll2ZhTPWDuxdiA26sxUK1q3wNe6G3SBJ+DnSPGWrinO34ASR7M44PLimXuQpmVH9JXxMOUe1I8aXjB9bvaoEs2JGkYufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN7ED3sG9y4bLnUB+bMD6Q/1SdKfO8SikofzqfVau/g=;
 b=CMrSzNXIuUmnD7lhBWTM6UxFtqUC5GTaDjxQx08IL/zbcEzfWNWeAOddqnboqqytQoWpvLb70vOad38cVVFGVi+iPVZOM6ys3SgN53ghlRSf+sGrbjvcD9fJVJS4nzvhWk+2BIsLEcUW7i3VljYEIPKqn7yiDnaiZklpfsWcmGnOmFj2KbkgsFLbIaDzvXsXPRgVriGZf2nSuJWaeiwbILfx4H+6EVpxkuU2lFXr5sy5YiqXUpWzYciVPOzuRiYdQ0gTiQb99WR6Sfbt7kobLEM+za6blOUxG0ffbMgaXF/5HmOdjgc+NKV06zDfq18a6Wqwzs06wLLw74LE3eqGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN7ED3sG9y4bLnUB+bMD6Q/1SdKfO8SikofzqfVau/g=;
 b=ZXsW/aIys34cLJIQSc+MNK6jHUL2U56ZQ8y0toZdurEWBbTkgR6AlUC+Sy25SV+PeJ0nV2gKDHR9vek2bNwofBMI9NHeLu98W4Pu1aF2exSad0BfFhbGeOth6I1bvAGK6fbs/VtMYvabBRfbx/iQ0YppnAzt3fA/IhUyC8+co7DV2auQp5Rr2bykBg0EQqnCeBh6ZA8WXiicJQ9+h42wwCZUO7YnWciL2TAhzi4rHA5Cfwb+NUrBbHs399ZANA44S4uxvTxAgRVLBxFjCT4B7Or/EbhOnrFoUZ5QAUmjtmrd1zwxqQUS+GNEDuVeqAEH2bOsOltErIHrJtpSSqILJw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by PS1PPFF8B9260ED.apcprd06.prod.outlook.com (2603:1096:308::26f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:34:08 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8511.028; Tue, 18 Mar 2025
 05:34:08 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Russell King <linux@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, "andrew+netdev@lunn.ch"
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
	<linux-aspeed@lists.ozlabs.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject:
 =?big5?B?pl7C0Dogpl7C0DogW25ldC1uZXh0IDQvNF0gbmV0OiBmdGdtYWMxMDA6IGFkZCBS?=
 =?big5?Q?GMII_delay_for_AST2600?=
Thread-Topic:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDQvNF0gbmV0OiBmdGdtYWMxMDA6IGFkZCBSR01JSSBk?=
 =?big5?Q?elay_for_AST2600?=
Thread-Index: AQHbluibt/La9I2bwU+d8Trs1O9LmLN3Bk6AgAAl6QCAAAE58IAAG6yAgAEVPPA=
Date: Tue, 18 Mar 2025 05:34:08 +0000
Message-ID:
 <SEYPR06MB5134C8128FCF57D37F38CEFF9DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <20250317095229.6f8754dd@fedora.home>
 <Z9gC2vz2w5dfZsum@shell.armlinux.org.uk>
 <SEYPR06MB51347CD1AB5940641A77427D9DDF2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <c3c02498-24a3-4ced-8ba3-5ca62b243047@lunn.ch>
In-Reply-To: <c3c02498-24a3-4ced-8ba3-5ca62b243047@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|PS1PPFF8B9260ED:EE_
x-ms-office365-filtering-correlation-id: 5f8c9b5c-c898-4e6c-ea20-08dd65de812f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?a05TOEp0U1AyTEtEdWYzOXRHSS9mNi9VREMrMXVNekZpTWV5NkZmT3ZsMVVOTVd6?=
 =?big5?B?a0xYbmtwdHFVTnl6TFdVc1dTV0VFcjBwOWRua1RnazY2UFpybWdhZjhIQUJRWGNn?=
 =?big5?B?WURPMDkzVkhWdTF4Wm53WklOSzdwOEs3bERIU2pEcUhCWDFzdnVXRTI0ZmZBNTFF?=
 =?big5?B?b1FuNWFMU2R6NWd5U1ZlM3dGVlVpcFc0K3NheDJrdTBrZWRJeHBFQW1lYUZOZVlr?=
 =?big5?B?WmdFdjR4UFcvUFAwb0xLMkpmUXVaVURXbFhwMCs5Z3AvN2RlQmlTWDRvT3UyV1Nl?=
 =?big5?B?R01uWnZRZ0VSV1VEcFhxN252S0xJMUhjenBXelZaWnVzMlVPV3NCaWYyRlFrUk0w?=
 =?big5?B?TFZ2cGZwVDdSL2Y5cjZ6bUR3cXZUNEx4UENKWERKdkc5OWE5VHU4ckt5dU9jRE5E?=
 =?big5?B?dXdWNnVieElibER2QWZidGZqKzJSeGV5RWpnWmtwUjh0UHJTQlNTTlB0K2VzUjNZ?=
 =?big5?B?eit4RkkwZkluOVRjVTNGQ0FKT2hGTEF2VUtkSG9BKzNWK2lhZlBTNlJSQzhMVk55?=
 =?big5?B?VEtoOVhLT2dOVU1qbnp1SXVJWm5PSzNHVDRac3RYVEdQMDJ6Q1p2SjBGbkpFV3Mr?=
 =?big5?B?VjlqazF0Mk1MakNwTm1jNUJPcmlaSjI0V3JLRkR4VUxYQzJLUDNwa3p0Sm0rc1Vv?=
 =?big5?B?Z1dIVllZeHpBOE5CU05odU9uQWFnUWxRSFNFNFljRXZSbVM1TGlDbWRlb2Y4UXdE?=
 =?big5?B?SlVZQkNIL1VEalFLODF1SUVVMzBxZ1lVNFpCZEV6RXBMbDIzQ3FIeHdLZHRiLzRj?=
 =?big5?B?L1V3M3FvcjVZV2U5dGRzajBaL1p5NTNjQW1aVmwzR2xranB3QjBhekhoSXZuaVEy?=
 =?big5?B?RHBMTkRwSWFZdUE0MlR1MkJYU1F1aHFUUzhBMVY0ano3R2RCczVIU05CREk5UE1Y?=
 =?big5?B?NHUva2tUb0N4cmEyUHFHOEFiakZsT0tRZ2tiN05VRXJYekNiUHl4VjZEa2hpclJh?=
 =?big5?B?L1YwdlNwaGF3SFBRbHI4aXhESmVhTjhEQjRWaVVwWmhldnJyWkxxY3dzM1RhOGhE?=
 =?big5?B?S0lQcjhseTI1RDhhQnVZcXdwdEpKTmtIUVp5MHNlWVhibEx5bHlNbmY1VERrOVpm?=
 =?big5?B?K21NdFd0RzVwU2FvbUt4aURYRVlZNll3YUZaNGFCL0VzamxqUnBaZFZXUHJiSEI1?=
 =?big5?B?UlR3eXF6MXZPUXk2bGhXSFR3SkswYUFaSXlpN1FScHZiSXd0NitydWFiSDh0dk5N?=
 =?big5?B?K0YvZEZTcGVjZWYrVHBZUWg0b3R2ZEdpMUpSZmVDVzY5cVU3L3NvbERmeHN6VUtD?=
 =?big5?B?eU1qZ2ZWK1ZBd3lpakRuU1dyV2lER3U3WmtxQzBhY0c5R2lRQjFGc2pVQ3JGYkxo?=
 =?big5?B?dTdpQnlHWGFMR1UySDdqTEhyTXJmSnVPbVRRTExiRGc2WmZVUS92UWFMTjEyYXJp?=
 =?big5?B?bm5aQk9wOTVrU1U5T0dCZHpYTjJ0N0JhT2FMK1NMRjdud3BJUnFxRTEyakVoY0ND?=
 =?big5?B?cDJlbXEyUXBaL0VOSEJjbytNaWs5bzRtMnloM3JIRm5MSmppM3NkSVpzOFNnTUR4?=
 =?big5?B?bSs3QWJNaG94VTF0ZDJvUGUySEJrU0xEeUdhOVFBWUZyL1JEVXhVQURhU0M3Zzlk?=
 =?big5?B?TXhOb25DREJaOXBBWjFYQjVqN3J1Qm4zZm1jWkE4bVgrUld1QlZYMzhVZ1dHYVdW?=
 =?big5?B?U2RWcW90b1IrektGR2NaNmdCQmxOaGloTlVONmpJb3NpbndMczNaTzlZdXhBLzZL?=
 =?big5?B?azMvcFcvaXpCRVk0eGd4UHlDSEFGaUU5a1prbjBLMzJyMFdmVFlPMU05Y0E2YlV1?=
 =?big5?B?VXNFUExLM05VNVJHYTAwbFBwdFNyYUNGQVBEdUVyV1dyMm45NnpFMGZlUDRteGpF?=
 =?big5?Q?s9ElGkQQwtThyRMXEvkkx3G7pKkmrfQ4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?YzRSd2pGUFEzK25Db1Q5a2Z2Mnp1L2lwQ2VxMStQZUZ1K1Q2eDdmejZJaXNzR25J?=
 =?big5?B?Ry9UQVNFQXJUbXo0aEtZRWdDMWVPN1AzWWhyazNLbFZtNzE4SWZ1WnZUVmsrQjdY?=
 =?big5?B?S1JZbTErUG85QTlJd2YxelpaZG5EOTh5aFZVYmpIWVVRellpZC9XcWVTTlJSUzBU?=
 =?big5?B?SWRpaDQ4U2hzRGN1ZGxMVDd6TFVRR0tUQXZobE94aFduRHBnbWFuQ1pBRVQvSm9R?=
 =?big5?B?NVg4K08wQ1dyU2Z4TUtydk95M1BiRmFxbWdFUHRnNU0wNkJENHMySHlXZmtjU0RM?=
 =?big5?B?R25SY0FicFVDMXQyK0Q5Z1QvWXNuMDhDK1FNQk85TGVqMWg5QWlBNzU0b3BwUE5h?=
 =?big5?B?TzZqYnRJTjhRZmxDZzZZbGNWRzdESmJ3QnB6cVA4ZVFwc0JHZzF3aUQrdmcwYnBX?=
 =?big5?B?K3NHb2l0bUh6SXpYZEphN2VrYUk0ODFySHBISFVCTEovbzJaTjRRbkRZRTBoU0Nm?=
 =?big5?B?YzlLKzdKVVVSVUluM2U0QWZsZU0yUmVPbVg0b3dTbjNnRUgzNXpjM2pHRmJPZzZO?=
 =?big5?B?SXMwWjZXSlhpMVNoWkZ5Y3Z3L0dYbk9IRnd1QUlFdEU5bmF3NE5LWkcvTGIxZEFo?=
 =?big5?B?TFAzdlpScTlXMjdlQ2FBa2xyWVdGZ3B3RkN5Q0JxdXZCRWxTdVhpbnBTYk80cm5k?=
 =?big5?B?ajdwK3pxZm1BTkJPRnlIcmZ1dFY0M1ptRDJmaWNBTmEzQzlzQzJsdVRxYURmb3Ru?=
 =?big5?B?SHhDRjRkb3NncTZLWHZsSld4VmllLy9CME0wK2lnd0xDb2VHMmk4NnQyR2ZiMUF1?=
 =?big5?B?RElZMVI0MmloTktkamZNemRCb3prQ3dkT1l2cTNUdXBxSmJvZ0dRL3FwVytJMUNa?=
 =?big5?B?WlprVUhmSE1NVzRUUzc3NzE1VktTcVdMeE15ZklpeGpNbFRZaG1GeC8xNjdMM1F2?=
 =?big5?B?cXdsZnlzdXNZUC9WVDhJSVZnVE5saUZJM2Z4ZVJBemdwd1l0eCtCQkdld3VGSjZr?=
 =?big5?B?c1UwWmd4ZjRBbnVLRU5rZDNXYXZsMjZMZm1ad0t6TzBIQ1hpVE5nTkJqVGFkbGUr?=
 =?big5?B?S01Dd3R3K3AzU3Z6c0hVTEVLeUF5THBmMXlDY05JRUhZam00ZTltTFgxSStLRzRZ?=
 =?big5?B?Q1h0TmVCSVFXS0lpWHRjMUZrYlcvTTEzWERQUmdXSFUrYnJiaHpkUlVOMm5PZWdI?=
 =?big5?B?SlVSV0tTUk4zaFUvVVJVeXoxOWw5YlRqZkRFQVdJMmxQMEFhN0ZjZGt5ZGt5U1JL?=
 =?big5?B?L0xxMWt4Z1pqL3VMaG92a0trMXIxYy9MODB2N0gvdmZ5R2c0dUFDUVc3dEd1MTVL?=
 =?big5?B?Zy9nbGtuYTN2SEFBQk9LZVFCT01DVW1keHAxbTg0QVBkaUNwUHd3eFM0c1VnMjIr?=
 =?big5?B?b3g0V05SNVpleGRrQitMUExpakU0OXBrYk1SZC9waVUrckVKaXMxczRJZU1UcTAz?=
 =?big5?B?c3NOUWs4V0k2Sm5YZ3FZUnJYRHU5NngyanE1YzlJQ1VmSkEzQ21yeE9QOEdMOTRj?=
 =?big5?B?ZWZ2UHI2enRCSHF3OUNRcUJieVNtcFdsTlE4dUY0Y3JjZ29GeTRSQkt4ZEFVOVZV?=
 =?big5?B?bmlMWDVTWkRnQ09xZjFqQVQxNlRpd1RHRlM2OW9GaGwvRG14L052WG5zdzFUMWRj?=
 =?big5?B?V0xWeWtwT2tCN0pDWlo0dnU2aEI4Q21ZV2ZoMGcxWnNCd01rb3pTWEYrUUFhRnVQ?=
 =?big5?B?aklUdlJSbzJkVnRrMENPQmFWQjlrNnZvU0xOblRNb2JjWDR1aDV4ZVZBMTNUTWlK?=
 =?big5?B?MjcwMkFrMXhNYjJVaTRyT1dZVXNtb2NpMitFa0NUQ0ZZb2UwcFNhZVhsRDlNTS94?=
 =?big5?B?czEvbWRYbmZ2NGlpTkhzeURiZGlRM0Yrdmt1VVBYSlUxRmo5Y2NIOFlOU1BEaU1t?=
 =?big5?B?VE9vTEs2ekR4SnFQTmVRUjExTVJmTW5MSTF1eUg0UzBEOExyV3B2WXAxakVBYXBC?=
 =?big5?B?WDluTWxnTDcyazIvR3FSQzJjYURBM0Nqd1E5S2djdjg3bWNKNWRwNVBVQkVtVkpB?=
 =?big5?B?UVUyQUlFa3BiSEVHVkJWSllmMUttVnY1WXJmSVQ2TDFudWxpMkM4dXczRy93K3Ux?=
 =?big5?Q?J2zdEA+OSLnlV9T9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8c9b5c-c898-4e6c-ea20-08dd65de812f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 05:34:08.0559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDGYLWljnfa6d0DviHxy2mw3R4F6iG5BaW6m6w5xn/Q6v4rYHc3a8QREdycFIkeJdB8xLzhzCfQ8AVxCAoFeLTc2yHC8wvOdbYWzkBhbmzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFF8B9260ED

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiBUaGUgUkdNSUkg
ZGVsYXkgb2YgQVNUMjYwMCBoYXMgYSBsb3Qgb2Ygc3RlcHMgY2FuIGJlIGNvbmZpZ3VyZWQuDQo+
IA0KPiBBcmUgdGhleSB1bmlmb3JtbHkgc3BhY2U/IFRoZW4gaXQgc2hvdWxkIGJlIGEgc2ltcGxl
IGZvcm11bGEgdG8gY2FsY3VsYXRlPyBPcg0KPiBhIGxvb2t1cCB0YWJsZT8NCg0KVGhlcmUgYXJl
IGZpeGVkIGRlbGF5IHZhbHVlcyBieSBzdGVwLiBJIGxpc3QgYmVsb3cuDQpBU1QyNjAwIE1BQzAv
MSBvbmUgc3RlcCBkZWxheSA9IDQ1IHBzDQpBU1QyNjAwIE1BQzIvMyBvbmUgc3RlcCBkZWxheSA9
IDI1MCBwcw0KSSBjYWxjdWxhdGUgYWxsIHN0ZXAgYW5kIGVtdWxhdGUgdGhlbS4NClRoZSBkdC1i
aW5kaW5nIHdpbGwgYmUgbGlrZSBiZWxvdy4NCnJ4LWludGVybmFsLWRlbGF5LXBzOg0KICAgIGRl
c2NyaXB0aW9uOg0KICAgICAgU2V0dGluZyB0aGlzIHByb3BlcnR5IHRvIGEgbm9uLXplcm8gbnVt
YmVyIHNldHMgdGhlIFJYIGludGVybmFsIGRlbGF5DQogICAgICBmb3IgdGhlIE1BQy4gLi4uIHNr
aXAgLi4uDQogICAgZW51bToNCiAgICAgIFs0NSwgOTAsIDEzNSwgMTgwLCAyMjUsIDI1MCwgMjcw
LCAzMTUsIDM2MCwgNDA1LCA0NTAsIDQ5NSwgNTAwLCA1NDAsIDU4NSwgNjMwLCA2NzUsIA0KICAg
ICAgIDcyMCwgNzUwLCA3NjUsIDgxMCwgODU1LCA5MDAsIDk0NSwgOTkwLCAxMDAwLCAxMDM1LCAx
MDgwLCAxMTI1LCAxMTcwLCAxMjE1LCAxMjUwLCANCiAgICAgICAxMjYwLCAxMzA1LCAxMzUwLCAx
Mzk1LCAxNDQwLCAxNTAwLCAxNzUwLCAyMDAwLCAyMjUwLCAyNTAwLCAyNzUwLCAzMDAwLCAzMjUw
LCAzNTAwLCANCiAgICAgICAzNzUwLCA0MDAwLCA0MjUwLCA0NTAwLCA0NzUwLCA1MDAwLCA1MjUw
LCA1NTAwLCA1NzUwLCA2MDAwLCA2MjUwLCA2NTAwLCA2NzUwLCA3MDAwLCANCiAgICAgICA3MjUw
LCA3NTAwLCA3NzUwLCA4MDAwXQ0KDQpJIHdpbGwgbW9kaWZ5IHVzaW5nIGNhbGN1bGF0aW5nIGRl
bGF5IHZhbHVlIGluIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KSmFja3kNCg0K

