Return-Path: <netdev+bounces-267266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNTfM+tws2kEWQAAu9opvQ
	(envelope-from <netdev+bounces-267266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:05:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D227C780
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35AF8301C947
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5C33859A;
	Fri, 13 Mar 2026 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="njHlkwEX"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6142F6918;
	Fri, 13 Mar 2026 02:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367527; cv=fail; b=mfyN4gxEoJR3DWQDBJQIvHxFXx6d8dJIJRa6wqQfg9c9GJjBDtunkDAQUKocIfYhkLYOVvAdVyuPB3SGDNrAfVc+9Z8XIAHL+IvThyjTQOnksuAALTPJFW0u8mpgFVMzroiffhjC56amyKqgk53rgN6cJ//NbWo1xZKErOeMYmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367527; c=relaxed/simple;
	bh=Qmkw2PQS5OipPo5WvboRjq1Jayxql/D8XinUq9s/rsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C3Nwes4Sh34Rd56BpZnnlW9lIdUUq9j7SWV2tqItWoggIm4sBKpu056oJbvvdY15peLzsU2Jear6Y0u0ZVBezQA3aLqDk28d+oGPrKzXMhP/0EJmViOW0cDY/JkTu+Q3OA9AGCSy199DdGCTq7wnyKPxKDmoJw2WgMZWbmqJsaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=njHlkwEX; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQZRhCog3vwy/vjj1JecNGOtUYyAOoi8R6PKqa3Kl8d2E4THaZOuyCmDfm1ASLC8yeit+N9Lf5OvLcMEZf4G55HlO+4gW+R105ln+I9p1MTfvQQvLeuLCLagdHsI5NEo5KEeMsoJD6GVHK/9OaM1r6AMXd5ZM+Ddb5WIH2HTJ46XvDPvJIJp62TgLeOTMRJkC1QBJ2y5Eq8ZsIl2EBaKT7vzSZ9F3KDKcCA/5HTYLeYMg5J9jx3aAGy9Z8ZWxZO1pKn7WRL+UZz0RqXS0twIQhlyT9Dq9fr8Uh2PjQ+001eopRMAlHSAc4IoBXsyct8rJokDg+D/9dM3kuL5GPeiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmkw2PQS5OipPo5WvboRjq1Jayxql/D8XinUq9s/rsQ=;
 b=BVQbYujd9KCVKVGSz2OHsjyPpKPDN7UIVjl555bVJhkMevelrg2/BnFYIPgN+I8dUp1ts54BwT/q7dn9jFUFdJoP6vmPQJkTafoN+e1awtHNgqSHjbmoQnIDvm12NtLNq0revQqlRQ+XFwvHB1KC/jP/wu24q3Dxr/XATqtu6M81GlWCFyaoUiqbJJXYDiqAtkyYHclWIjR5j1z/8/5ZTFtf8XzEZxVCE2lx4n++8eqO7Z/wnandEA08SgWKbhTHmywxRpeN9jTbzzM5IwM0QNSrEe4GIhNXPw62XsyQHo1o5YRmgCMfKRX43+IKEfe9yZbkM7IP7Bp5qwzfcqTnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmkw2PQS5OipPo5WvboRjq1Jayxql/D8XinUq9s/rsQ=;
 b=njHlkwEX8NDrPtSjv9I+whsLLyeGbUDvcmd7ydTbY4FqvjclkxfpnB9B7BuheGef12DWZaUhqls2qSjVZZIJ5oniwF8m6nLnfOY+zdzjwwtyJf35fdOJU6jsilITmQtzHmVVV4yDjLsA6TVmu60pplCR0aTP/ivQkNQZCh4IuzKVngCpHaasOT9Fxk+Knfsrhd0NUaC/oOYIZJC7LlXw5g/l8GHYwOx+VZ0mdQBbzkEYE5z2il38+kAFCFIYEZ2dPKeMCnrFuSYE4UZSkEDog6vgDpFdTcc20b20qEF3+nuvtr/0yO6CBAirFgPN5PvydxJMos/huDS0AJr4h2wSYA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 IA1PR11MB8785.namprd11.prod.outlook.com (2603:10b6:208:599::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.6; Fri, 13 Mar 2026 02:05:20 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9%4]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 02:05:20 +0000
From: <Tristram.Ha@microchip.com>
To: <bastien.curutchet@bootlin.com>, <olteanv@gmail.com>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>, <pascal.eberhard@se.com>, <miquel.raynal@bootlin.com>,
	<thomas.petazzoni@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maxime.chevallier@bootlin.com>
Subject: RE: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Thread-Topic: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Thread-Index:
 AQHcq8BZxyCiqHlsBEeDQ14VW7yu3LWftUwAgAAtaoCAAANygIAAH+SAgACs27CABX1SAIAAhfyAgAJuqICAAB8cAIAAEK4AgAAReQCAADL0AIAASjAAgAFhKICAAH9iQA==
Date: Fri, 13 Mar 2026 02:05:20 +0000
Message-ID:
 <DM3PR11MB87360F40688561859B685425EC45A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
 <20260311212404.xsx55lh3gnuze253@skbuf>
 <cd3acaab-5b77-461e-bbcf-de475ee29280@bootlin.com>
In-Reply-To: <cd3acaab-5b77-461e-bbcf-de475ee29280@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|IA1PR11MB8785:EE_
x-ms-office365-filtering-correlation-id: 156745a7-b062-42d8-3d83-08de80a4fb03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 u4Zwi1ptdIZ8WUMSd7yU/iMaOhkYK4Pj3hrnugvh3jxmYLMarmVXBafpxr+7mnuwJxpNu5GOB/PnSkzBfVbBy+dI1LbzbrFPmaxRxHz3fcJOitnfnDbvm4q0xNQ5htazzw5XCbO/HGL5zG9qVkvpe1VVkCXzYVUP/c2BG0NGxEmxTIJSTzOXcf1byZMgTtDk4iV5+VmAMgV7qveigwtcEA5kb3m4Yn4zr18rcV+qHzMPThV4aA5QKgMzEgO1FUBFnRnXpxfq1zc9IXBa03+w2Hgx4icCogROYx8sSNHhXLvOnh8XoLjY8u1XQ/SxXZNwM7AwaeYaGCeuAsd4YvlxMOO49BCEdpiBq9zFTLYyY7GK8TtUcFsjWDBmom1D3Usjovck76x4777jruw7PIjNI2AatjKoTsH5rGTgu1X+VzKR/YWer5B3C0dXx7mF8j2QRLhsAVw4fOmXMxljv8/cKWPkkXRRwRh7rt6gozSd0MvFKAC7Z6uG8qwQ5mhqxk/eSP+OM60wmhLFohGJwJUiDtgN6XxRZA9LyiWOR2EEoI44hC179fphF4BVf+kyd6Xnni52AmCifgctATmhTemPiwjL0Zw0AkPiujAOZw5rUXDCQYZocxai4GqGIm5IxoW5ORGdtoVOgQBeic1YizFGWZWnVPLY6VNEzgpbod9jzAbAhJfG7HQNJlDPi6IKikOwZOTdDhXKjXTIrlTpRU/XuLwRT9O6lVmMqweHYiptwuEeQkMh+ApQ4NBIGY9cEDIGmzkz0ZhgBvtmei1ZwCkmKGZaGdp7ffYwRg4/5q7p250=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzJnQjFDUE5DN3VOL2FHQmRoR0VNNlBjamZabFdIdithTk9OUlYzUEpORzJL?=
 =?utf-8?B?Zk4vRnhrTUNJUWtwVy9INTNXVTZGbW5TYm9zRVZrYTl2MGovdCthbjZxNDBG?=
 =?utf-8?B?MXdyci9OdWNJcXp1WWlhcVg4bXJZWnlFbkNodEdBZDZVcDdkSHh5OWphVlJG?=
 =?utf-8?B?V01hNnhOMWtPc1RWb3VTS2VtcldVb25mNWlKcTdsZURCS3VrY1ZDYTBwVHpu?=
 =?utf-8?B?N1dQVFM1eWlyWFdyTG9xNWRwdkNWOEVZNkJqRFN5NTdlTzh4YnVvd1VmV05Y?=
 =?utf-8?B?OVJhMnVuY09QQ2hPOWJ2YUpQbHVoVUEvZHJub2xPTWhFTXFkVUdRdGd6NGZa?=
 =?utf-8?B?WDNiZ2kydDJkZmVSRG5SdEZtckRYREJDTjgvU3Q5SDFWb2F4QnZnWFhjV29N?=
 =?utf-8?B?amZzSmJtQXRERHBFUVVVZkVZZnJBWFNhMlNhaG91ZEJNdWZteE42LzVZaVB0?=
 =?utf-8?B?TFZaZ0lYR1cyL1NrQmhOSDR4WHFYZXZ0djd6bFU5c2hGY0tVbXcyRXdoMHQx?=
 =?utf-8?B?dzU1OU05UVN3Sm4xd1dmTEt6STQyV281amZDaFFlK1FJQnJZbFpyVkxYaDcy?=
 =?utf-8?B?SUc4aGNZTlZMYm43N29hUWM5SUk2a2IvK1RQcGdaYnBrMHBPbWlZYVFncStq?=
 =?utf-8?B?eDBDUkFGY0ppZjd2WCtIdkFQN09rYW5vUWhUdTZKOFBnaTR3azlxSVBhT2lr?=
 =?utf-8?B?QWNOU0x5RWJ1RzZwNUNPVEhtY1BVajZkbG1mVlBrZ2NRYzNnYlJVVk84TzJZ?=
 =?utf-8?B?dVRMcm1ueHp5bm1zaVV6R0wwQjNza0Y5TXZNeHBmMjBBK1ptTGdXN0RDMFFQ?=
 =?utf-8?B?VE9LRElsK1ppTzVRMHNqa1F6ZnRaVUJZZU96ZGdHSFNSbGJxTXZwZVV4alBG?=
 =?utf-8?B?cXBtcGhhOW9sNDQwWDFBaG8zZHZPVG1XbGRUUkZZNFY3OTgzWmpoYlhkNXhU?=
 =?utf-8?B?bzAyNXhqVGpKMnpWMUNRc1FpVzR0ZkpRVG05cFlaM2JKUGpoL2h6QTZ0RXhJ?=
 =?utf-8?B?Q0ZYYnpLMzZJVXNjV3c1M0xyY2RpeFAzT1RzUURyWmdmWUVrT2hVUkUvek5D?=
 =?utf-8?B?aS9pdmc5b2c3QnpVbUtaUXlXczNWWXJEaEY0TFdsV0M3dk1PeHJXaEZtbE1m?=
 =?utf-8?B?VGkwZEZwZGhnNlFiTW04S3licE9xZGJKTHl0OE1iUjFzaU5oczRteDZscUZw?=
 =?utf-8?B?Z1ArRGgvblVzY0dxczVxZ0VRdzhYWFpXV2FzclBUVHUySi9hOXdXbWdaL3VJ?=
 =?utf-8?B?ZU54S3JOK29laTZMN0ZNZlo5aHFxaEwwdTN4aTVDeVBMQ2I1MThIRE94RkVP?=
 =?utf-8?B?VFU4NGIvYmJ4OEdVd2FGeEYrcHhPWDBaTVc3elo1QURlRWpWbmpvVm5vVG9T?=
 =?utf-8?B?YThaWlpkQURTUXJBSS9scG80UnRxVUtEUUtSenl3UEdYNWtVSHE4VUIxbHF2?=
 =?utf-8?B?enBJaXVtbjFvNkFqcHNyNEU1MXpLVnRuemZsL3hCTUhqQU9SNS8wWk92VTcz?=
 =?utf-8?B?ckpINHNab2wrSWxBUzFBcmxxRzZINGR6cnJmNlNVM1NLekN6SzVrVTNMTUZa?=
 =?utf-8?B?OG1kL2RmWXdWUEJpQ0ZXejI4KzJMZmg1N1IrL1duN3IrZDZPYllxMlowSG5h?=
 =?utf-8?B?K0JQTEg2bmRKYlNXTzdQRyt2YU9nVVZVamFUTG1uWXR4ajc4TzYxQ0d0ZUdP?=
 =?utf-8?B?dHh3dU0zSCtGNGNmYTlVRjNqSEhLbTlzNU00REtseHM2TEkxRExxL3pXM0ZJ?=
 =?utf-8?B?SlBaYnJoajlJQjJyam5FUkZFaEdSWmdvRHhWZVp5L0JTNkFmbXVhL2tGM29v?=
 =?utf-8?B?d2VZMm5YYnQ1bEZMYjBKSzVmL0FNS1RmOFVVMHk1VlBnU005SmVnZElQR3E3?=
 =?utf-8?B?d3VSWXBmN0NKc2JWZDFsWng2K3FUS3N6SGNXVDdqVWdLVC9QM255cXJIeXlL?=
 =?utf-8?B?SnU2dDNnQjdTNjExbFFPamJZdFNYVURNaUtRMVUvd2NnRXRzTVhtdSt3YjMy?=
 =?utf-8?B?M1R4enRxblNFRGFiZEpKQ3RXbk9WTHhJaUF6STNMYXBVRVBGbVlzemJmWkVF?=
 =?utf-8?B?dHIrQjdqTklSeGtZdnlZb0pER1BzOXFLRnZHaGw2OC9CL0pLWHByU1VERUFD?=
 =?utf-8?B?N29aS2Y2UHVkTkMxWE1HUUptc3hPcTdMQzZzTkFIWHZ3U3F1bVVjL0R1Z2hv?=
 =?utf-8?B?TnBVK1MyNnhUOVo4OUxtMW8vbmpieXdXN2hMZ1hZUjhuTTExbFJWQ3pCd0pE?=
 =?utf-8?B?Mm8rSG5lZldiU3puVitWMGhlNm5TZmVLR2dvSnM0akhKeVNNTk96b2toZmVh?=
 =?utf-8?B?cXlobFVjZG5sMGpzTlNOQ1RVa1hyUTNYcFg1QVBnRlRiTVQzT2J3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156745a7-b062-42d8-3d83-08de80a4fb03
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 02:05:20.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oj8Vb0gaYSp7BzBXqZFjrDiv4eHHOlqS+UiJHEYVpeRuJHq5+1VF0ZH45JWZ2haJPHJZj16Wi4+cKvgSwz4Wy9ini9iufjOpYAeQcXq4Pak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8785
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267266-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[Tristram.Ha@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:dkim]
X-Rspamd-Queue-Id: 4B8D227C780
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiAzLzExLzI2IDEwOjI0IFBNLCBWbGFkaW1pciBPbHRlYW4gd3JvdGU6DQo+ID4gT24gV2Vk
LCBNYXIgMTEsIDIwMjYgYXQgMDU6NTg6MzJQTSArMDEwMCwgQmFzdGllbiBDdXJ1dGNoZXQgd3Jv
dGU6DQo+ID4+IEluIHRoZSBlbmQsIGl0IGZlZWxzIE9LIHRvIG1lIHRvIG1pZ3JhdGUgS1NaODQ2
MyBpbnRvIGtzejg4NjMuYyBidXQgaXQncw0KPiA+PiBoYXJkIHRvIGtub3cgZm9yIHN1cmUgYmVm
b3JlIGFjdHVhbGx5IGRvaW5nIGl0Lg0KPiA+DQo+ID4gU29ycnksIHdoYXQga3N6ODg2My5jPyBJ
IG1heSBiZSBtaXN1bmRlcnN0YW5kaW5nIHNvbWV0aGluZy4NCj4gDQo+IEkgbWVhbnQga3N6ODk5
NS5jIHNvcnJ5DQoNCkkgYW0gZmluYWxseSBhYmxlIHRvIGJyaW5nIHVwIHRoZSBrczg5OTUgZHJp
dmVyIGJ5IHVzaW5nIGZpeGVkIGxpbmsgZm9yDQphbGwgZXh0ZXJuYWwgcG9ydHMuICBOb3cgSSBo
YXZlIGxhbjEsIGxhbjIsIGxhbjMsIGFuZCBsYW40IGJ1dCBJIGRvIG5vdA0Ka25vdyBob3cgdG8g
dXNlIHRoZW0uICBVc2luZyBhIGJyMCB0byBjb21iaW5lIHRoZW0gd2lsbCBzZW5kIG91dCA0IHBh
Y2tldHMNCmZvciBlYWNoIG9uZSB0byBicjAuICBBbmQgaXQgY2Fubm90IHJlY2VpdmUgcHJvcGVy
bHkuICBUaGUgaW5kaXZpZHVhbCBsYW4xDQpkZXZpY2UgY2FuIHNlbmQgYnV0IGFsc28gY2Fubm90
IHJlY2VpdmUuICBPbmx5IGV0aDAgY2FuIHNlbmQgYW5kIHJlY2VpdmUNCnNvIGl0IGlzIHRoZSBv
bmx5IG9uZSB3aGljaCBjYW4gcGluZy4NCg0KVGhlIGxhbjEgZGV2aWNlIGNhbm5vdCB0ZWxsIHRo
ZSBzcGVlZCBvZiB0aGUgcG9ydCBhcyBmaXhlZCBsaW5rIGlzIHVzZWQuDQpJdHMgb3RoZXIgcHVy
cG9zZSBpcyB0byBzaHV0ZG93biB0aGUgcG9ydCwgYnV0IHRoZXJlIGlzIG5vdGhpbmcNCmltcGxl
bWVudGVkIGluc2lkZSB0aGUgZHJpdmVyLg0KDQpTbyB0aGUga3M4OTk1IGRyaXZlciBpcyBub3Qg
Y29tcGxldGVkPw0KDQo=

