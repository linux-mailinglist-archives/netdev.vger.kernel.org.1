Return-Path: <netdev+bounces-279066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPPwJbvp4Gl/nQAAu9opvQ
	(envelope-from <netdev+bounces-279066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:52:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F258F40F398
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6002930038FC
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE63D564D;
	Thu, 16 Apr 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lzc8tapQ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A63D34BA;
	Thu, 16 Apr 2026 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347566; cv=fail; b=TmbKYTolhXZIFf5JhpQ+A0LSLAkQ/TQ4MxjJTN6RP/mOFH//ejvVkCtetio8v4Qcd271mm5rujJ8hJKjpar+cKlD2avhb/hkqzeCbvUX2HZUv4VzehnBu3waFyYnOZ2jdYyio4ttVfmxu8cJG7A3gDl3MKIoKU5Vz7cVF5rhZQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347566; c=relaxed/simple;
	bh=i2rQY56Xa2RVp9CN1r7vrHyGtufhAmR3SzAD9Tc+OwU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=brOa8GXiRkLmMvNFZwyYuE7a6jPPZao493+wOgtlUy+9yj5G926f1SMxWXd83AxSUFubbq/CXFkSUCDWe8Ll3ChrkRe3cgcae8f4GX07r0JwdPSPTAGbPHZWLpO+lELTFLqnJox9v3W7miORRv/VDU6KSRXOCjOd9fRKdN4C02k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lzc8tapQ; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aA2ZLxUkOvh4a6SomZTPNBmNRzRj9epHTePPcu9CUz5OnI4zXP2+eCx1JVCePxpxJcsm95EwgS964rPDD/eEF6gds7zq0Azc0P7Jkfb6daeQ9clrsnpro3ruRCZUxWpp3ALQLkIX+KK9jAeM4vWZqqq6SpwCwSyva4gEEW2XRLSaHNr2xkgHdTQEtPe+rQTV6kI8beCRSq67omqERWjZrzqDdqNLpSFLcArz7BEthXgaX9+a9UMKYeEbHBgfVNOIwSRSO4WJ0fhksUzb6wciqFu5jPcPd9zN3+VoY35X0OzRaCGjLk9H6Uj5CtZFXwo+GJO4r27hSrAv4uBGNOucDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2rQY56Xa2RVp9CN1r7vrHyGtufhAmR3SzAD9Tc+OwU=;
 b=ZW2iJ82C059wXXOwnyQZLb1o5Vxtq08sHHt7Up8ouynTc+fjCvcmmWEvuKHpLCvrI/c/bWlw85/9La9uFKEMl5TfOl6HgW0M+7FexpL7Iwn1vOXeB9uEyIVG8TbAIId2i+4nwrY69akzPzLL1hwlYuqxUHQ03Hp/cipIvzWmbTNNBNvHpLZXsFhLkU1i0Fuyra8qeXyaEWK3pb2wipXNTPLLa4D1X8jvOE5Y9uieO3OvEe44JyGnAIHMtfUwXJlWui+5uvDX29szYgfklu8DQ9O+/eZMuUeeZnLEGrfxzs3oAkC3qigXJyiL1yIMdgIE419d3ptPJwH7Iin3Hv8ClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2rQY56Xa2RVp9CN1r7vrHyGtufhAmR3SzAD9Tc+OwU=;
 b=lzc8tapQWNrOu9IPD5/uoBK9qlRz0PMVWy9WQJ7I/VEu1FPEffkB5XJx6FUUFftKrXvnpDyOyD9OyOAMAACca0g1G8+bsDlqhahDVUIywjEdjUYJKTbKgmTrKIG4q2VgedAnANFGdOxNl2LJnwp5IEUj+xgkaDdF0eG6JlK2C2sMfS5OK/8egFk07eal304ArBvnxE38K27N3V4jAl3LpscsXrPdKV9VzRxhJzL2g1RouMMMLtAyclwdGmPlYwIbnP7vhWr+0B3+mwhFHtyf+T56RNwsgKVzTmDPt5j0B0P9rtHtrhjsOr3t5RBtrdxQmCtFBkTgiOsVwWNMJ7EYFQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DU0PR07MB9089.eurprd07.prod.outlook.com (2603:10a6:10:40a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 13:52:37 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 13:52:37 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
Thread-Topic: [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
Thread-Index: AQHcy2PbTaK4pMw7dECxmKB8O6sJv7Xhsj6AgAAHI4A=
Date: Thu, 16 Apr 2026 13:52:37 +0000
Message-ID:
 <PAXPR07MB79842958F5D96FD55F41A7DBA3232@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
 <9ff2df3e-08cf-4f61-8a58-cac0a6980b2d@redhat.com>
In-Reply-To: <9ff2df3e-08cf-4f61-8a58-cac0a6980b2d@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DU0PR07MB9089:EE_
x-ms-office365-filtering-correlation-id: 8bc59662-647f-4e94-8923-08de9bbf6b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 +43RDpBuoFM+muLRHxvoOt+3j0xmMQCDkzKZCT1qmOREFa/MKqsHQPAGtBjObOoZSGHRIyRXSAHVAtvSqp3kkBsrsiylfBVDSXHtR+v/EgZhdd1lKND8UlhW0+I/IQlQhmc+FOMV6Zi93Vu2Ig7bsvtJT8C/MfUXSbgTSA98wPRNmGUXRy3Hijvx1sMqXSij2n8NO9AqhDQjXYYt/ntJZ7cJE3+X8w+gqpumHrQGP77QmU+06O8Cpk0Es6p/+WfHsuqTSqHXZ6TlS0VJ+TBdm7qMUnjGlZEsA/r5TJ02IVgZ/wVNqX2EUTVbc/q1xPpg4bWlTGBpw5KBiSM19dlQPksWVG1SGVm9G/ESFimyDb0FN3NGvIMhm3unpaxQlAThuo4ZqdXjrTE0tgj3NghSC+G8mSNOqr2PjRpyyTd3wfgq9AUqmR0AzPDd13JC+QHxlCDHoorAIhuX2qcOoCeVsv9uF7URWo+ncsaPY0nAhDPTgbTalgQ/gZglBnLSv5ZzPqO/gTA/m5K7jEtagYtlXhe0YOxiGXbiEaCiwyj7XBu/S8MXDp6Bskfu9gfwEwu0LVNIncSVlO2gufZEECmfQo9ec5mhBziPQSY5regSOwW3OCPwnxQ39LzGVkj2bQFRu5Le8P4rKLE2N2sw7XO/55MrWyDa8N0p6dTeTFb6D01MR4MHpQHTWZnONJHjqaP070L/ZInJwBu5ZZEXfJFQMVooC5um2ZxwL/Fk1gvILGM9rJO+xbItWtRqflKHYd2Ci7xmQRKnYKkKPCfiuwdGrJUbpnEb248WtVPzqpbaTKsTU0m6n6WS3qxxjnL2zhyj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmVRSUtWSDdqdTBtY1daSVQ5ZzBsQnRFWGM0dDBmMEFRRk1Wa3B1aFZiRVJz?=
 =?utf-8?B?b3BRWS9LT24zY1NLUFBNeEJIcDVkdUZYOGp1L21xV0NBbSt2QUpLYUFBYmJp?=
 =?utf-8?B?MXd2aE1QUFdPUlRIZG8zR1JXWkRrRnZ3Sy9TWDJrLytCdS9KeDdBeU5ZVStn?=
 =?utf-8?B?aVgrT3VGc05xd0dlcGZtMmFMa0RUWTV4WWUvWlYxWTcwem5aMm9GRkJiamRB?=
 =?utf-8?B?UTB2NzJIZTVvSzUvSlRLOFpVdkxNMXV4cEowNXZXK0g0RmtnRjRET1BFT1lw?=
 =?utf-8?B?N1BTU28xazJiVVJ3aHJCUTdMRk5vNFd2NUdzbHd3VnorMVJ3NEpvL3lxb2NV?=
 =?utf-8?B?emRZYXV2NUN0dTZONFRjcWgzVG1tWFQzeXN1VkVaanJPdUtWM2ZJQmFpeUVX?=
 =?utf-8?B?VzgwVXZVNUd5QVdwTENJRVlsU21LY2hwVDRkaTF1dGhkbEhab1hTU0hIaUE1?=
 =?utf-8?B?K3BoVFZTdVliV1d0QlIxL1NKZXZDdXNETWp5cGtwa3FsTnRhclBWMnlVaW1n?=
 =?utf-8?B?K2lpVEdWTkdGSmx1V3huQnMvYjRoaG4yNitoTXVjMk1oOEpBVWJueXBJbG5U?=
 =?utf-8?B?THM5ME9WdTN1cUJ0WjZ1LzJqN0hnWlhiaHN4eWRGWmNINGV3RjF3NU9mWGVW?=
 =?utf-8?B?S0pJWWdXMHpDZUIyV0RrbkVNV25jclQzTVl2blhYK3gvU0NOSnlJdUo0TDFh?=
 =?utf-8?B?alJ0NFJRb20xZVZIUHpzd1pyalBEbUxGOTl2SHRBb0NxZ3h0bzRVVmZSeHpy?=
 =?utf-8?B?N2d4dnR6V1BmYXRxR3FTMVdudTJ2MzZEdEgyWjYzSEZxUzJNdEtFTnNTM215?=
 =?utf-8?B?UUZOK3YyNndPQ0lKTFB1SE9uWWRCMHQ2aHJFcGJDR3Uzakl2dkhEZ01JY1lQ?=
 =?utf-8?B?SjZIalhnaHl4alI4Mng1SG1ZeDgzdUtqSE5NVk9Ta21yTmp2N3JvWW1ubnlG?=
 =?utf-8?B?RHhscFdUYzQyYTBBYzBwY2UxMTVJWDhBRnJTMUlVUFhRbEJmQzVGRG1uKzlC?=
 =?utf-8?B?NVR0VU9CaXp2dWFVYmtiZXVjcFNBSFF6SUdpUlRESmJLWW5BTjJqZGpiNWJT?=
 =?utf-8?B?U09JTDZLR0ZOVERkNlY1ZFJudzdMSmQwVUdldHFVcXM1Z2lNWkNNMEgxMFlZ?=
 =?utf-8?B?d00zMzJTdGNqcUo0WGFPaElITzdXdCtkVDVUUUh0OHc5MVlBc1hBTEFYVTRx?=
 =?utf-8?B?SmFmQ2szWFpWUk9FQWh0R2xDYjQ5WG1hNzQvTHF4eFl5dHpGWDhEUG5KNlJJ?=
 =?utf-8?B?dE9RUTBKbDFjREMzVnhnWGdLbCtVc0RyZUI5bDdVQlJxbnZ0SHArQVZiMXYw?=
 =?utf-8?B?MTRpQjRmZlMvZW9QOCt2bVJZOHBWRFBUcVV0ZjVvTWl0ZUpPaXVDemJEWHRF?=
 =?utf-8?B?dDRmUUZwVUtuUTU3OHMxNmRxdVhMTEZRUTNxUUJvZ0RoR05oSnNERDZaTUg4?=
 =?utf-8?B?TkNYU3RBbDg0aS8wak1PdTVrNU84YjR0VE5qWk9IZHE5OWVUcGJ5MmRYbVM5?=
 =?utf-8?B?SlplbE1ORkMyd1RUNEpoRFBzSlh3WVI0STN6aFJWeE43K3o1MWUrcmFGcmg1?=
 =?utf-8?B?Vkd6cHpIYjlFVTYxZk5POG9ielR6dXQwRE04eXNPVllTdjJOMW9qSEZ6OFh6?=
 =?utf-8?B?RHU0M1N0ME15djM1d2cxRHFQd2YzS3M3YXh2ZFQxTVZTeEtDUEJmaXhrU3lE?=
 =?utf-8?B?eTB0and4SFkzZHBLaUp2UHNpTUxkcWlKak9oQnlCZlNFZXNBMTgyTGFNMlov?=
 =?utf-8?B?WDRUWjlmeFY4OTk2dFp2Q3dBNVY4OHlsTk5XdlFCM01CK0JZV3gvTTZFbG9n?=
 =?utf-8?B?V0VLUUsxNS9uZWNvMGkrRm9TU2NHV3JFcXlvT1NCQnMvdU1EYW8vMnlOR1hE?=
 =?utf-8?B?L3NoY3pXK1JFNzhHcDBydnNzVkttSkVNYTlYMzFRYUJNQXd4dm9rSGNYTUpW?=
 =?utf-8?B?NGJoM3hEVEUyNWRXb1QwMHJDMHBhZk5odTFqa2xBVFY4R0EvN3JJTlZlclVp?=
 =?utf-8?B?SzlvdFM2UUV6aE5saHZPcHpXcll2UGJWZVUybnZ6N0JhQ3FNTTFUeEZHTjhL?=
 =?utf-8?B?V1VoL0RZK3lBWFpTWE41bGVCTGNMd2NTSTBTUDZmcVhCQVROWTVSTThUVjF4?=
 =?utf-8?B?bkFRL1BaYzlDUFBhSi9kM29Qck44K2VOTkMvenltWVRIZnV4c3FCNktWSUtj?=
 =?utf-8?B?Y1hDL2oxb3JxbWFaWGMyNXRtOHc0TGtGajZDcWpXM2F6enZ5QzJ2WHdpVEJy?=
 =?utf-8?B?RTFrYSt2M2hFcm9jKzBBc2oyd2Z0aFRQTjJNbEoyeWFuQlFzelNnelA0aWdO?=
 =?utf-8?B?dWNJalNlS0pVQ05lYURwbWtjdk9xQzRVTTVYVDZVK3NIeFF1OUJ1OTVJMkNs?=
 =?utf-8?Q?0S8o/06EYw4q3HmE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc59662-647f-4e94-8923-08de9bbf6b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 13:52:37.5779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CruVC7K+hj3ymrSNGqgkooaWJ1stZNfTSyOTXGbzfZapY8dpI78H/+meXHyCqhnCslRk9ytEgvBGOZZyf8NHW5ksA4NXUYL5DiMt7OwahJDKhKimeNgrbs7L1QI+Awrv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9089
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279066-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,vger.kernel.org,kernel.org,mojatatu.com,resnulli.us,davemloft.net,google.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.at:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,cablelabs.com:email,nok.it:url,PAXPR07MB7984.eurprd07.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F258F40F398
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTYsIDIwMjYgMzoyNiBQTQ0K
PiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFi
cy5jb20+OyBsaW51eC1oYXJkZW5pbmdAdmdlci5rZXJuZWwub3JnOyBrZWVzQGtlcm5lbC5vcmc7
IGd1c3Rhdm9hcnNAa2VybmVsLm9yZzsgamhzQG1vamF0YXR1LmNvbTsgamlyaUByZXNudWxsaS51
czsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBob3Jtc0BrZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxAZ29vZ2xlLmNvbTsg
S29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFi
cy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nz
b24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVAYXBwbGUuY29t
OyBycy5pZXRmQGdteC5hdDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2aWRoaV9nb2Vs
QGFwcGxlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIG5ldCAxLzFdIG5ldC9zY2hlZDog
c2NoX2R1YWxwaTI6IGZpeCBsaW1pdC9tZW1saW1pdCBlbmZvcmNlbWVudCB3aGVuIGRlcXVldWVp
bmcgTC1xdWV1ZQ0KPiANCj4gDQo+IENBVVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwu
IFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0
dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0
aW9uLg0KPiANCj4gDQo+IA0KPiBPbiA0LzEzLzI2IDY6MzcgUE0sIGNoaWEteXUuY2hhbmdAbm9r
aWEtYmVsbC1sYWJzLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1
LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4NCj4gPiBGaXggZHVhbHBpMl9jaGFuZ2Uo
KSB0byBjb3JyZWN0bHkgZW5mb3JjZSB1cGRhdGVkIGxpbWl0IGFuZCBtZW1saW1pdCANCj4gPiB2
YWx1ZXMgYWZ0ZXIgYSBjb25maWd1cmF0aW9uIGNoYW5nZSBvZiB0aGUgZHVhbHBpMiBxZGlzYy4N
Cj4gPg0KPiA+IEJlZm9yZSB0aGlzIHBhdGNoLCBkdWFscGkyX2NoYW5nZSgpIGFsd2F5cyBhdHRl
bXB0ZWQgdG8gZGVxdWV1ZSANCj4gPiBwYWNrZXRzIHZpYSB0aGUgcm9vdCBxZGlzYyAoQy1xdWV1
ZSkgd2hlbiByZWR1Y2luZyBiYWNrbG9nIG9yIG1lbW9yeSANCj4gPiB1c2FnZSwgYW5kIHVuY29u
ZGl0aW9uYWxseSBhc3N1bWVkIHRoYXQgYSB2YWxpZCBza2Igd2lsbCBiZSByZXR1cm5lZC4gDQo+
ID4gV2hlbiB0cmFmZmljIGNsYXNzaWZpY2F0aW9uIHJlc3VsdHMgaW4gcGFja2V0cyBiZWluZyBx
dWV1ZWQgaW4gdGhlIA0KPiA+IEwtcXVldWUgd2hpbGUgdGhlIEMtcXVldWUgaXMgZW1wdHksIHRo
aXMgbGVhZHMgdG8gYSBOVUxMIHNrYiANCj4gPiBkZXJlZmVyZW5jZSBkdXJpbmcgbGltaXQgb3Ig
bWVtbGltaXQgZW5mb3JjZW1lbnQuDQo+ID4NCj4gPiBUaGlzIGlzIGZpeGVkIGJ5IGZpcnN0IGRl
cXVldWluZyBmcm9tIHRoZSBDLXF1ZXVlIHBhdGggaWYgaXQgaXMgbm9uLWVtcHR5Lg0KPiA+IE9u
Y2UgdGhlIEMtcXVldWUgaXMgZW1wdHksIHBhY2tldHMgYXJlIGRlcXVldWVkIGRpcmVjdGx5IGZy
b20gdGhlIEwtcXVldWUuDQo+ID4gUmV0dXJuIHZhbHVlcyBmcm9tIHFkaXNjX2RlcXVldWVfaW50
ZXJuYWwoKSBhcmUgY2hlY2tlZCBmb3IgYm90aCANCj4gPiBxdWV1ZXMuIFdoZW4gZGVxdWV1aW5n
IGZyb20gdGhlIEwtcXVldWUsIHRoZSBwYXJlbnQgcWRpc2MgcWxlbiBhbmQgDQo+ID4gYmFja2xv
ZyBjb3VudGVycyBhcmUgdXBkYXRlZCBleHBsaWNpdGx5IHRvIGtlZXAgb3ZlcmFsbCBxZGlzYyBz
dGF0aXN0aWNzIGNvbnNpc3RlbnQuDQo+ID4NCj4gPiBGaXhlczogMzIwZDAzMWFkNmU0ICgic2No
ZWQ6IFN0cnVjdCBkZWZpbml0aW9uIGFuZCBwYXJzaW5nIG9mIGR1YWxwaTIgDQo+ID4gcWRpc2Mi
KQ0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEt
YmVsbC1sYWJzLmNvbT4NCj4gPiAtLS0NCj4gPiAgbmV0L3NjaGVkL3NjaF9kdWFscGkyLmMgfCAy
NCArKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L3NjaGVk
L3NjaF9kdWFscGkyLmMgYi9uZXQvc2NoZWQvc2NoX2R1YWxwaTIuYyBpbmRleCANCj4gPiA2ZDdl
NjM4OTc1OGQuLjU2ZDQ0MjI5NzBiNiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvc2NoZWQvc2NoX2R1
YWxwaTIuYw0KPiA+ICsrKyBiL25ldC9zY2hlZC9zY2hfZHVhbHBpMi5jDQo+ID4gQEAgLTg3Miwx
MSArODcyLDI1IEBAIHN0YXRpYyBpbnQgZHVhbHBpMl9jaGFuZ2Uoc3RydWN0IFFkaXNjICpzY2gs
IHN0cnVjdCBubGF0dHIgKm9wdCwNCj4gPiAgICAgICBvbGRfYmFja2xvZyA9IHNjaC0+cXN0YXRz
LmJhY2tsb2c7DQo+ID4gICAgICAgd2hpbGUgKHFkaXNjX3FsZW4oc2NoKSA+IHNjaC0+bGltaXQg
fHwNCj4gPiAgICAgICAgICAgICAgcS0+bWVtb3J5X3VzZWQgPiBxLT5tZW1vcnlfbGltaXQpIHsN
Cj4gPiAtICAgICAgICAgICAgIHN0cnVjdCBza19idWZmICpza2IgPSBxZGlzY19kZXF1ZXVlX2lu
dGVybmFsKHNjaCwgdHJ1ZSk7DQo+ID4gLQ0KPiA+IC0gICAgICAgICAgICAgcS0+bWVtb3J5X3Vz
ZWQgLT0gc2tiLT50cnVlc2l6ZTsNCj4gPiAtICAgICAgICAgICAgIHFkaXNjX3FzdGF0c19iYWNr
bG9nX2RlYyhzY2gsIHNrYik7DQo+ID4gLSAgICAgICAgICAgICBydG5sX3FkaXNjX2Ryb3Aoc2ti
LCBzY2gpOw0KPiA+ICsgICAgICAgICAgICAgaW50IGNfbGVuID0gcWRpc2NfcWxlbihzY2gpIC0g
cWRpc2NfcWxlbihxLT5sX3F1ZXVlKTsNCj4gPiArICAgICAgICAgICAgIHN0cnVjdCBza19idWZm
ICpza2IgPSBOVUxMOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIGlmIChjX2xlbikgew0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICBza2IgPSBxZGlzY19kZXF1ZXVlX2ludGVybmFsKHNjaCwg
dHJ1ZSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmICghc2tiKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBx
LT5tZW1vcnlfdXNlZCAtPSBza2ItPnRydWVzaXplOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBydG5sX3FkaXNjX2Ryb3Aoc2tiLCBzY2gpOw0KPiA+ICsgICAgICAgICAgICAgfSBlbHNlIGlm
IChxZGlzY19xbGVuKHEtPmxfcXVldWUpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHNr
YiA9IHFkaXNjX2RlcXVldWVfaW50ZXJuYWwocS0+bF9xdWV1ZSwgdHJ1ZSk7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIGlmICghc2tiKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBxLT5tZW1vcnlfdXNlZCAtPSBz
a2ItPnRydWVzaXplOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBydG5sX3FkaXNjX2Ryb3Ao
c2tiLCBxLT5sX3F1ZXVlKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgLyogS2VlcCB0aGUg
b3ZlcmFsbCBxZGlzYyBzdGF0cyBjb25zaXN0ZW50ICovDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIC0tc2NoLT5xLnFsZW47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHFkaXNjX3FzdGF0
c19iYWNrbG9nX2RlYyhzY2gsIHNrYik7DQo+IA0KPiBTYXNoaWtvIHNheXM6DQo+IC0tLQ0KPiBU
aGUgZHJvcCBjb3VudGVyIGlzIGluY3JlbWVudGVkIGZvciB0aGUgTC1xdWV1ZSB2aWEgcnRubF9x
ZGlzY19kcm9wKCksIGJ1dCBpdCBhcHBlYXJzIHRoZSBkcm9wIGNvdW50ZXIgZm9yIHRoZSBwYXJl
bnQgcWRpc2MgKHNjaCkgaXMgbm90IHVwZGF0ZWQuDQo+IFdpbGwgdGhpcyBjYXVzZSB1c2VyLWZh
Y2luZyBzdGF0aXN0aWNzIGZvciB0aGUgb3ZlcmFsbCBkdWFscGkyIHFkaXNjIHRvIHVuZGVycmVw
b3J0IGRyb3BzPw0KPiAtLS0NCg0KSGkgUGFvbG8sDQoNCllvdSBhcmUgcmlnaHQsIHRoaXMgaXMg
bXkgbWlzcy4NCkkgd2lsbCBhZGQgInFkaXNjX3FzdGF0c19kcm9wKHNjaCkiIGZvciB0aGUgTC1x
dWV1ZSBkcm9wcGluZyBjYXNlLg0KDQpUaGFua3MhDQpDaGlhLVl1DQoNCg==

