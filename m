Return-Path: <netdev+bounces-191037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FDAB9CDF
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133025004D3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C42241679;
	Fri, 16 May 2025 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="DorKGCqt"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020090.outbound.protection.outlook.com [52.101.169.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8123182F;
	Fri, 16 May 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400791; cv=fail; b=csK7TelwEoGo+OI+nEW9Yc77UMhIisuNYtRbW+3qNSCg0DYqrZ4vK2qr2b6UCteyNSfto9zP8ifomwOzvFwDnwllqJsTydt/EYb1vOYC+oPdGs/eGVIxTIDYQufiF+YsDxcmpK+XPwnnIRpet3yJsdPqCRzot5m23LBLjbRU+yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400791; c=relaxed/simple;
	bh=MChH/7kIrqyEO3HOf2DIQ94WeOhIntBERJgLyikvQnw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GhQR/bq7cSjvfvn2UE5SR2YkURRGGYYJwUdMxW8UCy3vdsX/8UVsW+vDt9j83qW9D46tJd8S+/rH1/hmwxx4skuF7b5qzHJU1mNbSh65E9bP9vfB+NN66yNYkDWU23ukEqfRG3mdhFBf7xULLtXrQ6UklmeobYMIiDPhZPvf9ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=DorKGCqt; arc=fail smtp.client-ip=52.101.169.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnHUkz+uJuBi894eRsD/5bC6Lvt8hi8NaiuACwkI41Aq0cQuqALLnDLpW1moh0EM4LeQDWmlHjD5mu4rvzX7pU9RVOyQpQ1MeyISHkxSL1NhFl+hqVcXZbTyHcERF/rrJbC0pEXXauNpd7ZpDeTnxKnMAMoQNw1xzeaeokYJEYFanboeastFngWRCEiOy2jUyZ127g5DtRGUZ6ENtigpXDcOjNkce8coZrnRP6aZyUHpAqw2f7psuqnSGbX2PDJeo17P7ud5dn2AbMrn5EFABujycnkpcd8zDd3vOK9MEX8+nieihikNDGsQX1STS3aSLkmil1YCDxLTfb7DVqHX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MChH/7kIrqyEO3HOf2DIQ94WeOhIntBERJgLyikvQnw=;
 b=tmakhieSRs5AxyJhBaOiPQIjjCJgxRJn+w+4VYaKMTGFQVUyEAco/xY5DGkbkGccJdxg4ej7lkPGtdCpMQrwmBmmgc+XrAYdH3Qv8whXTn68LtETvCE3nIQn+4ReOBgghoHlYIqQjKNH1nORkbmejY83XbthVwu7TvGIA6jLB4kSUVPE3xvwD2RiHJ3bbjtTTOu0sE+R+rJgL24Kidsw8AWnx0T8wV8cnxNfFgkWcq36VB5Wb7BGljR6VVN7ARDQBzH4crvn2dfVdULgplreC5bi3deB0KEMNA7TXMYGEVCkFapQdjBN0eJwV5ZazmAEdgk8Cp0/SUDD5sfnHXK5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MChH/7kIrqyEO3HOf2DIQ94WeOhIntBERJgLyikvQnw=;
 b=DorKGCqtrYGCLAU9jxFCiSPZegHeASu1uImN8E14ZpW+vC8Ee15xS+ym4vexUOdv62L9KB8Ihv1nIxjlDcnlfmo1ShYoZh0mFbt+fjI2mBdvqpsP6ppNZQIQPiTEiKGrQREkvfgIXsl8qNNwtvYd1gRr4ZgziJZrcrTvCXvsBbo=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 FR3P281MB1742.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.32; Fri, 16 May 2025 13:06:24 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:06:23 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Piotr Kubik
	<piotr.kubik@adtran.com>
Subject: [PATCH net-next v3 0/2] Add Si3474 PSE controller driver
Thread-Topic: [PATCH net-next v3 0/2] Add Si3474 PSE controller driver
Thread-Index: AQHbxmNTLj3krZvKfUucMx4evxq8dg==
Date: Fri, 16 May 2025 13:06:23 +0000
Message-ID: <f975f23e-84a7-48e6-a2b2-18ceb9148675@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|FR3P281MB1742:EE_
x-ms-office365-filtering-correlation-id: acc8d020-74f6-4288-f0d1-08dd947a75c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXB6ZVN0MXkwbUIwajhmaGt3NTZUK3Nla01TNUdLVXZubUZsYmNEOHcwVjN6?=
 =?utf-8?B?OGIrckYzU2Q3VWF2aGF4d3p1U2ZqTkwzOHhCWUtqUmdvZVNZa09DWnpsbGxo?=
 =?utf-8?B?M0ZWUW5CMmZZUlp2T3pKQ2xRNVFPL2dRTHJSaHFXUHQvU04vZXdWL3hZZTlx?=
 =?utf-8?B?YTlGVVhYcXh2QW9lOUtIU2JmaUNuZTZQWHk4S0pZL2kvN3pUL0w0cW5sNWdB?=
 =?utf-8?B?RjRhRDNCYnQ5aEJQWGFxa05ZQnRka0JMazR5NmVvNms3a2ptcEZ2SFo1dURi?=
 =?utf-8?B?ZmdhZGJPZkdBN2w2SEJlRlBOOXdXU3B4YnlGSkhxb2xDU091T2lKQXFHai9h?=
 =?utf-8?B?Z1QvUlk4NS9GOVpHdWlxbTBSdHg1eEVYejdJZ3JPMXdLWUlFV00ySDRXNDkr?=
 =?utf-8?B?RXYwUGdEL0R5bllaUFVHVmFZc09Ga2NabTZ6MnJwb1p3VkRnTm5ETnIrOFBC?=
 =?utf-8?B?VldGallHTU9XNVdQRUJxVVpaNTFXaW1pM2M2d0hnd2hHU0VDa05vbnpERXFp?=
 =?utf-8?B?a1NMZnFvdXJ5bFU3NlhYNUI1ZXN6ZGFYZWVtTThPZ05XVzA5enJTeTc5ZWla?=
 =?utf-8?B?ZkRTMEIydHNaN2diandZUFFXTVZiQkRDUXZReG9laWJUOGxJeElPNHdqeGUw?=
 =?utf-8?B?TnhRU1ZPdzFLOVZjRy8wbk5wZXNaZ3ZyWlR0YzMybjNSSU1DWjhCaTRCNHZ5?=
 =?utf-8?B?OVN1OHlPSkw4YjVIVUpyckIwcloxM3Bhd05YQkQ2Mm50S3VCS25vZy9Bejl1?=
 =?utf-8?B?TFFGSUFXcXFnZlBlTkVpR1kybTdsczJ3MUQxdE1XZWVRdVJOSG81ZVdLY2Fm?=
 =?utf-8?B?cGl1clkyUUlCTzFnYVM2cEo5dkF1amlsTkd5Q0hDaWhUYXplMXZBQ1RZVUtj?=
 =?utf-8?B?TmpKRWVHZHdFZ0RIMDdmRHpjbHJ0NDlUK3MzMVlmUzcvK0FVMTFtWnVyTStY?=
 =?utf-8?B?bWhEaW9YekFGZGExemNQajdqalJKL2UyQ0Y0ejI0enJucWhFQWpabzdxZ1lK?=
 =?utf-8?B?L0w3UlNwT1g3bExlL0lVaVdCY2svR2tzbDNpSUU0T3lkY3dFUDZJYXN3UFhy?=
 =?utf-8?B?bzFCNVhDQU4xVkNpMVA5bWhIYVNwZjVnWHgvZWFzR2sybnlEeUZLWGJ4U1Yx?=
 =?utf-8?B?V2YxZWErR3pjaGd4WXJva29lU2lhdDFmU2Y2UDBsRjVibnVhYzlxTkQ4bXlX?=
 =?utf-8?B?anV2MVJhSHg0VzFCTEJnaytCMVB5cnQrc2dYdytBSWlrWjE2RnJlMjNOVG8w?=
 =?utf-8?B?bXJOd2ZHdnZZVzNHSUpGRE54Qm02VGtmb0djWHdSeE8vVnNEd3lzQVJRSG9m?=
 =?utf-8?B?c1NBU3BOYVRYYytRRUxEcnAxaXFzeThmQUI2V0ptYTlqbHJDeUxWWGxyVjdR?=
 =?utf-8?B?Z3pnbGFkV1dvUkxKRUs1c3VYV0JwMnViTnJ5RlUySndTY3VucVdJZHhIS0xw?=
 =?utf-8?B?a3k5N3pwWExNaVNFRVhEY3VRNWFFOXdtaE1xUk5ua2VqcUFyM2RmYTlQRVBZ?=
 =?utf-8?B?Y0xIRU1ZR050Z2d1REVoWGpnVElES25NdTc3c01qTVdKaFlzcGU1azVBYzE4?=
 =?utf-8?B?OEpyaGN6V1U3dThBTDVvV2Mycyt3ZzlHVG12RUp2U0dpbExGbGxrOWlCczhj?=
 =?utf-8?B?RmNjanViUHJPbzk0MmdKVHY4VE5pR283a0Q0alZHbDFWT01XaXA2dkJBS3Zt?=
 =?utf-8?B?TGdIQU5ZdnNkbzl1anpMYUlRRVhoYkFjTm5CdmorTGlTWDN3WXpVbUhBbjFB?=
 =?utf-8?B?NmliMnQ4WVU3MXRqbHdFaWVMOHhzWjJKUWJ3VEk5N29rOUlueXg5RUMyQXNu?=
 =?utf-8?B?d2pNcGVjY2pSK0pBbjVXQXc0Qk1YcktYZjFvSWxCRUFGZVVXSStEM1pkVU84?=
 =?utf-8?B?U0lkVmI3T05vSXA2KzFRYWIzb0ZGMmxraldJZHAvY00wWmVYNG5UcGFLN0RO?=
 =?utf-8?B?WnRUY3RRckVabmQ3S0pmcmxXZURSbDhlMElvdlQ3ZUJiREJWMHdnaGFzN054?=
 =?utf-8?B?UVAxd2lMUlplb0c0U2lucnhSUzVEZ3IyREpSb0YrbUJwN2pHNkZBbjVJZWFE?=
 =?utf-8?Q?UwiPox?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXZOSmZ0aE9adEdmREtBaTZYOHBLdTd6a2FjdmFGREpnd3FwK3VDNFFueFJ1?=
 =?utf-8?B?UHBsK2VOZit3Mm40L1hzRGRJOTVpVXMxSWdrRitHcTZtT2wrT0pkWm91Y05m?=
 =?utf-8?B?aC90bStTcWt0Y1FNMklrR01kTVpkWmNtVUI4QjdXT3RCNUJwaTIyalRBV0xj?=
 =?utf-8?B?bmRqMXNyRlNEV2RteTBibUQ2RXd0NmVqc2VxQ1hzWm1HakRzYm45WDBhK3Vh?=
 =?utf-8?B?cjBtN3BBSW9oZm1lM1h0ZEhjSTFQb3d0ZHdZMUdjYVNKejZmMStXbm9MV05E?=
 =?utf-8?B?MUVZeWt0b215T0hVa0xiWlNBckJwU3hVemVKNkZpblBDNlpJQ3pCRkVXS0xD?=
 =?utf-8?B?Umhkd1pVWlNrTjE3V3E3YXJqV1FsaDJYMm5VamVRUDBJSEszZFh5UTJCNy9D?=
 =?utf-8?B?MjFnd3hsczNnUUQ2dnkzRHpocHRKeTkvWExzQWtsN0hjQ01LS29YOStKYUV5?=
 =?utf-8?B?bTFhMFBVbnJiVjdLbjdua201SFFYNTVvcWNtZUVzek5id1ZOQmdMY1d3bVQy?=
 =?utf-8?B?c0dqQWF0NWVRRGRtQmhzVlNNR1U0UUdGaEFiRGVsY3VyVmNRWC9NeGJDdndt?=
 =?utf-8?B?SzE5VXBoTzVOVmJoZ0YxYlZ2aDZKL3RzTnVIbEcrcDRFY3NVWnVZVEw3UDdi?=
 =?utf-8?B?T08zN2ZYZlBEUWRNWTNlaHE1QzRYUmdaKzdIOWJLN0FGT3JpbERuOVNKMTVN?=
 =?utf-8?B?ckI4ZCsvam9PdFA0SUlQZThqRTBMaGs5ZzI0RVJHN1VTVWs0ZmNxZERKM0JF?=
 =?utf-8?B?eGoycGlkS3RDdmtwRkd1R3B2SDhQZUQ3NHdrV1U1QzFGek5aSEhNbUJuMFYr?=
 =?utf-8?B?Z3JwQ1BKMnBCK21rdHp5Nm5JVDh6RDNpczdkRzJWODZNekU1Z1RVSkxhKzFJ?=
 =?utf-8?B?ODU1amxYZHhxSnlEbkQ1MjY2UlVSNkpmY04zU2dBdXVLN0Fub1VqbzV6YlVI?=
 =?utf-8?B?MGV2VEIyb20wQ3dCQ0V4SUlPTTVNVk0zWk5ZWkhRYTcwem9nNWljNVRqY1hv?=
 =?utf-8?B?WTRFb0w5RjluK1k5ZlFRZXFsSE9mSnFNL2ZxOVFUZDduNUpkdUZURG53WWJQ?=
 =?utf-8?B?YitKUEZrb1ZvWitLVnBvaHpNTGJFcG45UCs4NFdxc3BoSU5xVm1JclR6b21N?=
 =?utf-8?B?TXh1YWdSYUJnVTZKckhOTEE0anY0M3hreTkwR05md0w3NnVTM0N1MjhCNTVM?=
 =?utf-8?B?a2hwTzgrN1dVT2xBSHhJWHkvNyt1TXdRcTNvd3JqSjM3c21TVjdhSnhSSlVn?=
 =?utf-8?B?MGFYcE5oNGVHRkc1SmlueWlxdUdlenVrZmtwV2FPUU13NjkxVHVpMnhQS0VR?=
 =?utf-8?B?ZEthY2swdzdvZzBwWGlXbkk2alRkMmYzSVJ6Ykk3Y1JVaDNhWVRMMFk3NVBF?=
 =?utf-8?B?RklyNjdvRnNwcEY0YVJTd3JrQzViRjNZQis4R01CaWdYQjRnQkZXaFlmbyt6?=
 =?utf-8?B?bGQzQzltV3liQUl5cWJEVm0zcDFjSDJJNGhkSiswc3V3UjltMXdudE1iaGZR?=
 =?utf-8?B?YVVaSDBJN05scFQ3Wk1kcFIyd2hLKzl2RUpuYTlQRWRiWHJMN05vUDBRUXE4?=
 =?utf-8?B?UzcvbXRLV0lQVG5yS2V1VWlNMDE3UkxCRGxIOUxxTVhFc2dXK05CRnNPM2N0?=
 =?utf-8?B?Rkh4ZTJNeTd1c0RxZGRHdzloakQ2K0MwWFFDVkhiY01kNktYR05tRGFGVUli?=
 =?utf-8?B?UUJVQWVPTDM3UDUzOG5NUktTQ25uNHA3c1NodkwwV0VYUEk4S3Z5MnFRdXNq?=
 =?utf-8?B?a1E1R2VNMHVmUFc0VFZUb0lVbGRIRTgreTVwS1Vqd2pqZjZZNkk4cml6bWdV?=
 =?utf-8?B?NkZjcUNQcXgxc3ovNklEM0pQaWlvdGRLU3pqY0d0TUhLOUF2K3hYYm5pVWtv?=
 =?utf-8?B?dUQwaWRHamRJOU95anhnRlVvRnRQMTlSaEhCWHZ4QnNnUmNQRG1DOW5wZmxS?=
 =?utf-8?B?WWRXWFhtUythMklZVXdMTnFPME5LQlBxZ095MERLU0JxZXZVTUJJNXZPWG1F?=
 =?utf-8?B?cnhPM2Y5dDRIaGE3L3hLeUpwQ210Nm5BYlVlelZlWHNsdHdGWDBycnprVW5R?=
 =?utf-8?B?M1hCbzJhTjdmbDRPc3ZLcjhId3lYZWJiS1kzcVRWMWczMmkwNXBIdFRjY3lI?=
 =?utf-8?Q?fR34NAUuXcgsc51YhQ9db/7Vr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B658F3762DDDA44AFDDBB6BAEFBB55E@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: acc8d020-74f6-4288-f0d1-08dd947a75c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 13:06:23.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zaz6XpBxpRuWHAWM+Wh8hdUn3FddIlXzyGogdXJBETPuSGI0NPuOZ1KQUGly35VddnvaOj4Bt70XbtxfC6fRKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1742

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNClRoZXNlIHBhdGNo
IHNlcmllcyBwcm92aWRlIHN1cHBvcnQgZm9yIFNreXdvcmtzIFNpMzQ3NCBJMkMgUG93ZXINClNv
dXJjaW5nIEVxdWlwbWVudCBjb250cm9sbGVyLg0KDQpCYXNlZCBvbiB0aGUgVFBTMjM4ODEgZHJp
dmVyIGNvZGUuDQoNClN1cHBvcnRlZCBmZWF0dXJlcyBvZiBTaTM0NzQ6DQotIGdldCBwb3J0IHN0
YXR1cywNCi0gZ2V0IHBvcnQgcG93ZXIsDQotIGdldCBwb3J0IHZvbHRhZ2UsDQotIGVuYWJsZS9k
aXNhYmxlIHBvcnQgcG93ZXINCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1
YmlrQGFkdHJhbi5jb20+DQotLS0NCg0KQ2hhbmdlcyBpbiB2MzoNCiAgLSBVc2UgX3Njb3BlZCB2
ZXJzaW9uIG9mIGZvcl9lYWNoX2NoaWxkX29mX25vZGUoKS4NCiAgLSBSZW1vdmUgcmVkdW5kYW50
IHJldHVybiB2YWx1ZSBhc3NpZ25tZW50cyBpbiBzaTM0NzRfZ2V0X29mX2NoYW5uZWxzKCkuDQog
IC0gQ2hhbmdlIGRldl9pbmZvKCkgdG8gZGV2X2RiZygpIG9uIHN1Y2Nlc3NmdWwgcHJvYmUuDQog
IC0gUmVuYW1lIGFsbCBpbnN0YW5jZXMgb2YgInNsYXZlIiB0byAic2Vjb25kYXJ5Ii4NCiAgLSBS
ZWdpc3RlciBkZXZtIGNsZWFudXAgYWN0aW9uIGZvciBhbmNpbGxhcnkgaTJjLCBzaW1wbGlmeWlu
ZyBjbGVhbnVwIGxvZ2ljIGluIHNpMzQ3NF9pMmNfcHJvYmUoKS4NCiAgLSBBZGQgZXhwbGljaXQg
cmV0dXJuIDAgb24gc3VjY2Vzc2Z1bCBwcm9iZS4NCiAgLSBEcm9wIHVubmVjZXNzYXJ5IC5yZW1v
dmUgY2FsbGJhY2suDQogIC0gVXBkYXRlIGNoYW5uZWwgbm9kZSBkZXNjcmlwdGlvbiBpbiBkZXZp
Y2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRpb24uDQogIC0gUmVvcmRlciByZWcgYW5kIHJlZy1u
YW1lcyBwcm9wZXJ0aWVzIGluIGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbi4NCiAg
LSBSZW5hbWUgYWxsICJzbGF2ZSIgcmVmZXJlbmNlcyB0byAic2Vjb25kYXJ5IiBpbiBkZXZpY2Ug
dHJlZSBiaW5kaW5ncyBkb2N1bWVudGF0aW9uLg0KICAtIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL25ldGRldi9iZjllNWM3Ny01MTJkLTRlZmItYWQxZC1mMTQxMjBjNGUwNmJA
YWR0cmFuLmNvbQ0KDQpDaGFuZ2VzIGluIHYyOg0KICAtIEhhbmRsZSBib3RoIElDIHF1YWRzIHZp
YSBzaW5nbGUgZHJpdmVyIGluc3RhbmNlDQogIC0gQWRkIGFyY2hpdGVjdHVyZSAmIHRlcm1pbm9s
b2d5IGRlc2NyaXB0aW9uIGNvbW1lbnQNCiAgLSBDaGFuZ2UgcGlfZW5hYmxlLCBwaV9kaXNhYmxl
LCBwaV9nZXRfYWRtaW5fc3RhdGUgdG8gdXNlIFBPUlRfTU9ERSByZWdpc3Rlcg0KICAtIFJlbmFt
ZSBwb3dlciBwb3J0cyB0byAncGknDQogIC0gVXNlIGkyY19zbWJ1c193cml0ZV9ieXRlX2RhdGEo
KSBmb3Igc2luZ2xlIGJ5dGUgcmVnaXN0ZXJzDQogIC0gQ29kaW5nIHN0eWxlIGltcHJvdmVtZW50
cw0KICAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9hOTJiZTYw
My03YWQ0LTRkZDMtYjA4My01NDg2NThhNDQ0OGFAYWR0cmFuLmNvbQ0KDQotLS0NClBpb3RyIEt1
YmlrICgyKToNCiAgZHQtYmluZGluZ3M6IG5ldDogcHNlLXBkOiBBZGQgYmluZGluZ3MgZm9yIFNp
MzQ3NCBQU0UgY29udHJvbGxlcg0KICBuZXQ6IHBzZS1wZDogQWRkIFNpMzQ3NCBQU0UgY29udHJv
bGxlciBkcml2ZXINCg0KIC4uLi9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55
YW1sICB8IDE0NCArKysrDQogZHJpdmVycy9uZXQvcHNlLXBkL0tjb25maWcgICAgICAgICAgICAg
ICAgICAgIHwgIDEwICsNCiBkcml2ZXJzL25ldC9wc2UtcGQvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvbmV0L3BzZS1wZC9zaTM0NzQuYyAgICAgICAgICAgICAg
ICAgICB8IDY0OSArKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDgwNCBpbnNl
cnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvbmV0L3BzZS1wZC9zaTM0NzQuYw0KDQotLQ0KMi40My4wDQoNClBpb3RyIEt1
YmlrDQoNCnBpb3RyLmt1YmlrQGFkdHJhbi5jb20NCnd3dy5hZHRyYW4uY29tDQo=

