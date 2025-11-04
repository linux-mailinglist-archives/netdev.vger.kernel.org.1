Return-Path: <netdev+bounces-235401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A1C2FF9D
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 09:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BA03BB637
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 08:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFB9295D90;
	Tue,  4 Nov 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="BGy9Et3O"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023120.outbound.protection.outlook.com [52.101.127.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCF280A58;
	Tue,  4 Nov 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245345; cv=fail; b=AG5X+8BsS7MGiKvS0fk03DsRO2QPkI2JcZFp4RIrjzwyQ9rw+UAa3A0WeoghXVzM/pqV0wWl+BryXOfiE4+ONBGnvARofHGyGgabtdgArEzkP5A0P7YtVXD/3D06qpE3M2QKn7wtxjuvm+FEOJjI1sLjC37sklsC6D9LBYG+U0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245345; c=relaxed/simple;
	bh=WUiECuR/rX/XxFIm+5NTDj0IdFsMmzfyh2AD5iXrg6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/m8RgeHB9xjUTfv0zhlTwcvQNwueLoNsOsfsUJWznxRB6BwS68VDzmKLy82kIRO8OZ5TE8U7pkujzwn5+U5E03OZIoGuEaijOYufCRVaqVIX1oFkm8tw/7dx72lvcSM64WgL0FAFl34yRZqm4guZmRsbKu05OXEjEEFDpobqlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=BGy9Et3O; arc=fail smtp.client-ip=52.101.127.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhraKTKEkipzvyCODFxuIa1Hmxy9FEeOA9M15HfsNKX1ux7JhQy61hjy+4vEDtM2oFaelw5LQETvdMRDxPjZWPLXotuxbAXkjgn+6eYsF05F+2G7IF5SWNxEWVbBBOa/h6tsD71t9L1k7/eDM55hAR4mee2JdknZqCLg49DO7XAQO9juqrevssnZ1ITM8SSlVnAC8RU7zwjixYsBxNqvmtG+FMnWz4dewYgRPeqhdAS3zPsByvFc38PMjvVNlhmsdRlyHyb0DV0H7CnSqaImHOueczl3KiyOy+usZ4r9oUFa8ihC10MjucCl+EmQaSmZPnlCgAaUu+VjD/4mSnJaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUiECuR/rX/XxFIm+5NTDj0IdFsMmzfyh2AD5iXrg6o=;
 b=CLxoS3HcC9BuAjz8PNpCUkyUskYGGx6RvfsvKF19OcZ1sahbTRX2UPEAkjBu5Cbx25x83h+/nwWr4UR+V18BstevfbWy2zS1jPzJ72mMFD79h2mvYrm8Qu0NFBTx8XHyJbF8MIxSXUECvtXRAWWFAUrqtAGI/tp/BQphVfQ4nPk4i2HBROiLUwAZgNJKUYdZ3QY5BTT9tO44JrfnRLsuOW/KS7vyF9r/iBfmmi0mYeZ5Bk1ezUImpbUgObb91CsxMWL+ZKealpqJu3clt/QEaSuASedo939Vajq+0pZxB92GciWzJEV5EQszB5Dudpm4Sxg4/jvskNFgn8JddCndCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUiECuR/rX/XxFIm+5NTDj0IdFsMmzfyh2AD5iXrg6o=;
 b=BGy9Et3OSLNTUoqJnhbA+9ktIUx71kqneRxA5Mx2IF/+iU9E58UhKFwOj07pFf+KsnrN1fxSd2itPSOI8+BbRDe0cpDBC+BzYO0vNyg5gIUl+z6K3DUpajSs6YKO0I1a/+L8t9VqodpiJwBfFVCUMN8I3Ome8avSdoRPdcz85+Vc8SvyIeCbC0PTvvGRtfLnsgJjLkt5HkgP+ygsQuVX7P5+gM+FkQp6UjLYytpVIIsRrCWiwx3R7tyI28BGfGTgmdxTFDlhSSUz6I1sQsSwkgtPFAqkRS8CwsxSmabRCE0kF7k34dyUFoPL3nMbyhUvHHIkMl5wtcaRhT5RBTrAQw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TY0PR06MB5401.apcprd06.prod.outlook.com (2603:1096:400:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:35:37 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 08:35:37 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHQgdjMgMC80XSBBZGQgQVNUMjYwMCBS?=
 =?utf-8?Q?GMII_delay_into_ftgmac100?=
Thread-Topic: [PATCH net-next v3 0/4] Add AST2600 RGMII delay into ftgmac100
Thread-Index: AQHcTJT/x96fax4fRUGWRrw/l8DMzbTiLpaAgAADPOA=
Date: Tue, 4 Nov 2025 08:35:37 +0000
Message-ID:
 <SEYPR06MB51347DC658F062BD79BE18A59DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251104-dangerous-auk-of-order-6afab2@kuoka>
In-Reply-To: <20251104-dangerous-auk-of-order-6afab2@kuoka>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TY0PR06MB5401:EE_
x-ms-office365-filtering-correlation-id: 63e44bdb-dd5a-41d5-b283-08de1b7d2114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWJyTGd1d0VFcTZPSHVuVEFoUldxQ3dCOTZ4d25sbm9uU1VTSGtFOW8wUDRK?=
 =?utf-8?B?dFFLK1h6dUlOSGplYitOMk1YandoL01BZ2ZhcUZ0bEdmZlYzUkJTSzZOQk0z?=
 =?utf-8?B?N251Y3V0OURIRXhtdVVxL0JOb0l3NkswVk5LM2JqRXdMN3JnRE5TdnFyWVVP?=
 =?utf-8?B?Q3hpKzRtTVo4UGtDT0J5dzBGazc4NE80dEd2YndscDFMSmxxS3owdFo3bGVk?=
 =?utf-8?B?aWdpYXZFYW1DNjlWUmpMT1NHSWo0MXBzZ0RQaDJhU3NIVFA4MkhvNC85OHZK?=
 =?utf-8?B?L21BZUorSFJQT3cvdlBnaVJlTkhPQmx6Szh5MDk0T1gxNUI2TnA2alU4T1JX?=
 =?utf-8?B?UEVrOUVXOGtGQzByTzZYLzVZdjBiRW9kRktuWnFPR1d2Q0paSEVhN2NTQ2hV?=
 =?utf-8?B?bDMrZTRrTlgvNzh2RENBSUY2TG5vTHBuY29acTZYbTlyaXdnMXUxSUJvMDdN?=
 =?utf-8?B?djZwdkVvU3k0MVdseWZmbGFzUHBDM0pKVjBiaUtaazgxT05DUldlQ1MrK2cv?=
 =?utf-8?B?S2hzOVFMa2tXRlFvZzdTV2lZMUlydGRQN05HcHhsc01JZk5vUnRGVldWT2My?=
 =?utf-8?B?TnNYaWt4dzQ3U25mL1FINVFCaHZBUXlFSHBsYWI0RmMvR2VMbnZualBGVW5R?=
 =?utf-8?B?UDR2UUVFQlRDSk9RWGpFeXQ0K2NnQkpnODNBenhuYW8zdVpncm5WYWM2c00z?=
 =?utf-8?B?djVKWEN5VHNnakJCcXRlT1paZGtWcGpiR2RVWG8zek04Vndwb3VFYzFmaCtD?=
 =?utf-8?B?dUdvbkUwUHNoNEN6VVJtMTZ6Y2FNTWZHdFN2S01lWlFvb2liZ29CengyL20r?=
 =?utf-8?B?RDB5Y2tEcko4OWxVT1huSU50QjRGd3dUdzlqdVhqZUs4SFUra3BlazRHUjVr?=
 =?utf-8?B?aERlOGZrMGYxek5CL29BZkJ5Tmh1QmdYTWQxUXUrU2NaV1ZJRVREblA0Mmk4?=
 =?utf-8?B?dDV6TUFKd2ZkU25kTHdDSTVhN3gvVDBVdU1sTk9oT3p3RVBsZW9PdkIyWEZh?=
 =?utf-8?B?QWlaMVdpejF3N3hyTzlXMzdkbXk2UnU1SlMzSkZyOGVITmI0TnZtL1M5Ymdl?=
 =?utf-8?B?cGFqWkRIeDFwV2RoeHpTcVZvVXdCRXJVb0xSUDBpWDVJOUZZL2Jodzg3VFZ4?=
 =?utf-8?B?YkhDb2NmSE5RM0tnbzB5TGdaTXc1K1oyYm1JeHlOMktYa1Y0WklJZEJJdG8z?=
 =?utf-8?B?NURJMk1ucjZLMWN0RXR0eDA4Y0ZMMzgrOG9ia0dNaWxCTHIvalRmSSt6Nkg2?=
 =?utf-8?B?YUYzM25PNnlkS0QxZUQzQWVvQ0IvZGVyMGJJOEZpZWNVZ0JVSWpiejJQZ0hB?=
 =?utf-8?B?MFpDeEJ0bUZyM2tobkZFY3Rkd3lOcUZVc0VUMjhYUlBmdXY1NG5FaW5DeWRr?=
 =?utf-8?B?NEY4Zml1dm9IazhoSFk1U3dGbUZZRDBuUU4wekNCSURJMkpEQjM2eE9pc2lq?=
 =?utf-8?B?V0FqWktMazJSZkNGMGdtZ1F4a25pdVNwRVpHcEhrazRjWlMyZFVqVUVER0JB?=
 =?utf-8?B?a0hPWHZjYW5QMUIzUUY1TTNaZW5YQ09ZRWtVbG94dm1vUVVLdmxMa2h2QVY2?=
 =?utf-8?B?Wmo2NTQrNkJOYWpqWWExcVFFdjVISDhzODkzZFBPYjlxM2RCY2UzblVWQm95?=
 =?utf-8?B?N1F5dzJ2MmI4Z2V5Z1VEMlRockdyRXRyUStud3lRWHpZcmI4ZVBuYTJoTFUy?=
 =?utf-8?B?V2w3RHdLd0lJQVYxazZJYnVqTWhJM2ZFMXlpbDBHblk0L2tiWndoSUJDMHVX?=
 =?utf-8?B?NjB6S1lnclc3dzlaV0xJN2FXZnNDbG1FT000MERPbUN5b2xtUHU0NklqbnRw?=
 =?utf-8?B?bEF4QVIxamd1bjlRR1hwTEZNVTdjL3kyTXVKRnJKQ0xER2JvQU1Rd0JoNEF6?=
 =?utf-8?B?TlJRQ1JaTlViQXVHSFRDZFpydG12ZkVtcWcyMkF6N1J6b2VzVncxc0ttSHRK?=
 =?utf-8?B?aEdNbU1uMXdPRVhkeEJyY3k1ak9ySTVHckJSYzNWUjNwdFRyRndTNU1EUU9u?=
 =?utf-8?B?dXM3c1hVektGbGw3Tmc4Z2NHcW9Icm5kaHJqeEhacE9Fb1pCREZYQkE3c1hh?=
 =?utf-8?Q?VIn1mP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnN3UHFBcEpaQVJOcWdBYVF6QlMrNUluWDFFOGJESnhxZmIxZVBBNXlFR254?=
 =?utf-8?B?dXVBcDNqVEhNUmNoNWJoaitJOXFVNDJnbFVWK0JtSDBSVHZPZENnWHllNGY1?=
 =?utf-8?B?U2FqZ2RabE55TE85SXhnbWl0ejU0bnh5Rm80bVozOTY1T0tPSktHYm1tQ1NV?=
 =?utf-8?B?dzBrVXJoTkkyRzdUNjFVRDVJTDNqbC91Q3JMQitjckhTZkhFYkU2ckMxRjZE?=
 =?utf-8?B?LzVRVng5ZzBkakw1T25YcjNkWUNpbDF6SnJnRWRmdUw1R1o3Qm5aNE1BMXND?=
 =?utf-8?B?aTRUYXBLYWJGY2Fuc3FxY1dvd29uVVNPNmdMZWZnUHJTaFNkMTVEcXBDa3N4?=
 =?utf-8?B?SWhxTXlrWkpaWjlDUWliMXRPemZzSWtZOUxra2dkOTNBU0J0aHJnVmZ6VFhO?=
 =?utf-8?B?S1JKeit0ZTZlcmc5QUZLY05JRnhpT1BJWFFRajltMHVYMXpOVXZnKzBqbHl6?=
 =?utf-8?B?U1RwSG01SFVJNWRqWnJwRXZBZXQyMDUwZm1jNktsYmcwUHlRZWVOQytIWGFZ?=
 =?utf-8?B?YUg5Nm5lRFF3U0tOaDcyb1R2QlQwaVhFRGR3YVFtVlkrQnIxVEJPdnY1K1Z5?=
 =?utf-8?B?eFFnamUyR1REcW9xSSs2QmxDZnRxQUNyUUpqVUk2em56ZXQxNGhqVFNwYTRi?=
 =?utf-8?B?T1NxcDd3YVhEL2RKSFFzVFBzUUowaDNMcWlSZzVPeGpCVllONXlaU0JpbDZh?=
 =?utf-8?B?NjVHWXBzR21mMzF4VTdwN2gya1pVYkx0RWVFZHQ2WEFoc09zeTNTM0h6ZDZz?=
 =?utf-8?B?T2YxM2dQQmx5eFpHMTJMWHhCNU1KeGhkRzZ6NWdqYzlTTVpTalpOTEwxZ2NH?=
 =?utf-8?B?eDZYR1lZeXAxTjFrRitKZHo2MWhSN1ZuVzRxaGhxRnRuNGxNVTNCVkRsNkV2?=
 =?utf-8?B?VVFyQ3N2Uzg0dDJoT3BiY0drbWt5cGcrenl4MUd1Q3MzQ3hxSTFQZ2lpbEdm?=
 =?utf-8?B?ZFRxWXZjdmVuNkdsNmUwM3E1UzJHUjFlZTNnUWZYdTViUFUwTFNCdmkvTnNu?=
 =?utf-8?B?WlRWYVJtNlRiNzZPMW1uVHk5NitYYkd6aElZQ0hJaENhblM4YkhlRkhCN0JX?=
 =?utf-8?B?VFZvejZIN2JCcnlrSkZRUFlST252OHRoMEFnWU9EOTFueS9ROUVJUFBTM2N4?=
 =?utf-8?B?YXdQVEVRYUtvTktBblJCOVljbCt6MFZQcGh2QlltYTNRbmJBaDYrK2c1ZUFa?=
 =?utf-8?B?OUtMZVVGZ2FPK1hrazR4dzU0dEVWdXlnYVdEZEhQY1MrNURkUEgyYTFxT1JO?=
 =?utf-8?B?VS9KNGpKUTF4Q01HVWpWSVR6TXFodFkvNDNHQVdZRTlYajlPVWdtTVE2UEJm?=
 =?utf-8?B?cGRHUitWZFpCSERIeXBjMVBWT0ZPdUJ2VENtMmRvSW4rOHhVQUdQWk9lNkFD?=
 =?utf-8?B?aWo4UXYzVzA2RENLWmliVTVvTVVUYmNyYTZwSUE3SjYrZmV2Zzd4VzJCWUt0?=
 =?utf-8?B?Y3VubEsydG40Q1FaaDVVeDZhVjl4VGVNZzBDWTJQaWMyelQ1Y2d4MUx2bnEy?=
 =?utf-8?B?KzVyeFpNRk5VVTFIL2ZVVUYyc2ZuNjFvNUdjZnpiSGxYa2FGclVXUDRLOWRN?=
 =?utf-8?B?MmVFdm5BNGFyY1F6UXVzbHRkWHkxUXNCMkNsRVdkWTNJWjZ0YUJYM3JUbjhL?=
 =?utf-8?B?TGRFTC82V1dHNDEyR3pEdDBUK0NUa3FFTlhhVm0zbER6azY2R0VvTzJLb2Zu?=
 =?utf-8?B?NnEzUFZCMU0zcjE3bnB0czl1TlhFcnlaTmVyVEVYU1lDV1J3Z2lhTVRTa0Nx?=
 =?utf-8?B?cXRrdW8xUDZNN0phS2UxcU11TWFUMTdYVXB4dDQ2VEhYUWRIWForUkRFQWdR?=
 =?utf-8?B?UWQ0YWZ0U1kvNEtlaXNyUWw5eXVwS3VjaElLd1dOSmlzWXlqUjhHcGlubWVs?=
 =?utf-8?B?Mk5tRmZySTg0TzhxV1lRNU9TNHRrWVJ3NEFLek40MDVrZkc5djRyeUp1dWVR?=
 =?utf-8?B?ZUg2KzhERnFqdllMOC9jUkpqSW9TSCtiazBKNDBnOFBIaEhyUEllT2Uvcy9S?=
 =?utf-8?B?VUVweUlpUW5jVGw1V1VtT09MTzRMTjZCeW5US0xieGJZUXQ2blJGODI3bWpW?=
 =?utf-8?B?RjNVOVkra2lmVkdMb0o5Z1lvSG9BWG9ISFR3Z0REVXJBVlN4RTRFVmwxL1Zv?=
 =?utf-8?B?M3EwdjNNeEozWHV1aFVwbHFsSms2cVhwV241aXdxaG5HampzNEJSRk9IWTNP?=
 =?utf-8?B?a1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e44bdb-dd5a-41d5-b283-08de1b7d2114
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 08:35:37.2702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwOhYQQJeJcG5ZJvuM8dl7SmC3ka1RDVn4wy4QsrJ3kEAD5lwzvy4COy/VmeaLcSbttayqQrPVQnEnPfXj5XZD6AIs2SdhN0OnRgsCtgIpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5401

SGkgS3J6eXN6dG9mDQoNCj4gPiAtLS0NCj4gPiB2MzoNCj4gPiAgLSBBZGQgbmV3IGl0ZW0gb24g
Y29tcGF0aWJsZSBwcm9wZXJ0eSBmb3IgbmV3IGNvbXBhdGlibGUgc3RyaW5ncw0KPiA+ICAtIFJl
bW92ZSB0aGUgbmV3IGNvbXBhdGlibGUgYW5kIHNjdSBoYW5kbGUgb2YgTUFDIGZyb20gYXNwZWVk
LWc2LmR0c2kNCj4gPiAgLSBBZGQgbmV3IGNvbXBhdGlibGUgYW5kIHNjdSBoYW5kbGUgdG8gTUFD
IG5vZGUgaW4NCj4gPiAgICBhc3BlZWQtYXN0MjYwMC1ldmIuZHRzDQo+ID4gIC0gQ2hhbmdlIGFs
bCBwaHktbW9kZSBvZiBNQUNzIHRvICJyZ21paS1pZCINCj4gPiAgLSBLZWVwICJhc3BlZWQsYXN0
MjYwMC1tYWMiIGNvbXBhdGlibGUgaW4gZnRnbWFjMTAwLmMgYW5kIGNvbmZpZ3VyZSB0aGUNCj4g
PiAgICByZ21paSBkZWxheSB3aXRoICJhc3BlZWQsYXN0MjYwMC1tYWMwMSIgYW5kICJhc3BlZWQs
YXN0MjYwMC1tYWMyMyINCj4gPiB2MjoNCj4gPiAgLSBhZGRlZCBuZXcgY29tcGF0aWJsZSBzdHJp
bmdzIGZvciBNQUMwLzEgYW5kIE1BQzIvMw0KPiA+ICAtIHVwZGF0ZWQgZGV2aWNlIHRyZWUgYmlu
ZGluZ3MgdG8gcmVzdHJpY3QgcGh5LW1vZGUgYW5kIGRlbGF5DQo+ID4gcHJvcGVydGllcw0KPiA+
ICAtIHJlZmFjdG9yZWQgZHJpdmVyIGNvZGUgdG8gaGFuZGxlIHJnbWlpIGRlbGF5IGNvbmZpZ3Vy
YXRpb24NCj4gDQo+IFRoYXQncyBiNCBtYW5hZ2VkIGNoYW5nZSwgc28gd2hlcmUgYXJlIHRoZSBs
b3JlbGlua3M/IFdoeSBhcmUgeW91IHJlbW92aW5nDQo+IHRoZW0/DQo+IA0KPiBTaW5jZSB5b3Ug
ZGVjaWRlZCB0byBkcm9wIHRoZW0gbWFraW5nIGl0IGRpZmZpY3VsdCBmb3IgbWUgdG8gZmluZCBw
cmV2aW91cw0KPiByZXZpc2lvbnMsIEkgd2lsbCBub3QgYm90aGVyIHRvIGxvb2sgYXQgYmFja2dy
b3VuZCBvZiB0aGlzIHBhdGNoc2V0IHRvIHVuZGVyc3RhbmQNCj4gd2h5IHlvdSBkaWQgdGhhdCB3
YXkgYW5kIGp1c3QgTkFLIHRoZSBiaW5kaW5nLg0KPiANCj4gTmV4dCB0aW1lLCBtYWtlIGl0IGVh
c3kgZm9yIHJldmlld2Vycywgbm90IGludGVudGlvbmFsbHkgZGlmZmljdWx0Lg0KPiANCg0KVGhh
bmtzIGZvciBwb2ludGluZyB0aGF0IG91dC4NClRoZSBtaXNzaW5nIGxvcmUgbGlua3Mgd2VyZSBk
dWUgdG8gbXkgYXR0ZW1wdCB0byB1c2UgYjQgZm9yIHNlbmRpbmcgdGhpcyB2ZXJzaW9uLCANCmFu
ZCBzb21lIGluZm9ybWF0aW9uIHdhcyB1bmludGVudGlvbmFsbHkgZHJvcHBlZC4NClN0YXJ0aW5n
IGZyb20gdGhlIG5leHQgcmV2aXNpb24sIEnigJlsbCBtYWtlIHN1cmUgdG8gaW5jbHVkZSBhbGwg
dGhlIHByb3BlciBsb3JlIGxpbmtzIA0KYW5kIG1ldGFkYXRhIGdlbmVyYXRlZCBieSBiNCBzZW5k
Lg0KDQpTb3JyeSBhYm91dCB0aGUgbWlzc2luZyBsb3JlIGxpbmtzIGluIHRoaXMgdmVyc2lvbi4g
YW5kIHRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KVGhhbmtzLA0KSmFja3kNCg==

