Return-Path: <netdev+bounces-75592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A621686AA2C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5937A289813
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D362CCA0;
	Wed, 28 Feb 2024 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S0HGpJEW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E836126
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109292; cv=fail; b=su+ld+xEYDXRpIjeDgT1muSmKsj3xTF0BcPJ2TF2vnk0A/KiJ8yLAoCMCQIwVEQbzTkZ8pcMAOLnacqUlUl7tPST7a1NNM5Hy69ZWFY6+k9is6ajkXRLyHIaXg7VSBIldiK5DoA4qHCtdzb4GD0VHbVUcSRbnCikHIzcZ/P0n7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109292; c=relaxed/simple;
	bh=/R+kPPx9qHbHg2pAmjmCSEQ+rm6O7g01WApIOUcahz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nv0WVB6IEvhfla+GTS7zrEf1nyYxnR8b2tMxCbSYjA0WjqLDJJ93Ywh32jw5a79WIA76Pcyipef30rxAJyO1eP1Xr+2vb3Gmk3vOpICV8gpB2GEf3UZnU8mMTu2fkt7mRQ27ntgum06c8xNKXBNWvtp4ByjEyN3wFq8k/92JHsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=S0HGpJEW; arc=fail smtp.client-ip=40.107.249.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRwqRuZ2E7vojUpUjVzlq7/Sr4FtUIGMh6hbWg2Bl1S84VLMYrOxde3zEg+92jsS+agmuUqv5/OhJNjg7p2gshOlwCTZrZVr1TYhmXphcOqYysepODK2vhUSjDBAibRa28TXeXQ9OWryHhWQH0UXJocFda8XZQ06yDUphmbK2IvdGQDOjcb9V4LPgv2MRLKWLDx5iYsMaepEnxWUSNQIPw9Fn4BD2YwH7PEIHkfbxmxGuaFRXRWji+GU4P+6Uf5rph92fMkKRdD6uZn+YrAeUVSzzWGa6eClCSvtGGJmfq6g2v5jNtDsuIQ88YZhrVYIOXbOBW0RrOFtTVuh3Jg9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/R+kPPx9qHbHg2pAmjmCSEQ+rm6O7g01WApIOUcahz0=;
 b=KsjAazIHuRfCYc01QwhvMlTkeMNXT6jYHqfz2mjkCcR4/EQ6lsQ+8pXyq69RNO08foJWZv4bzlfvoRWPJqJo/X9uk/BUqa2OGqWAhcqw75lLusnLGsKEjQn0ckNH8sJZU6Azti6HJZxCjp89A3f6pipi81vQSahGL4Pl0sjGxZVXpjs1O/KicMFkmEVg0VxxD4ei67SdoKMlsikrYLracIV4g66xpuhhP4Y2R8eGqLzhX2UpL1lO4gC5ygRmXHfezJ2Dj3vgm0K0S3oBFoE68LD7HJgIzWUJdVL1dOnT6u2uF1esxGItkzIeKw/ReCXzkB/XSrqGHhNOfMUQDi4opA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/R+kPPx9qHbHg2pAmjmCSEQ+rm6O7g01WApIOUcahz0=;
 b=S0HGpJEW4aRwrovilKVwwPX+P9a0TxVTUPH5t2k945tsePxKQuP7PaZplIY1t57Gzj313nGkvRqsJCMpPTQccx0ttT1l7tOEjK6226csSuhpSZWhgP5Y80dR8Xf/3nver92jeiOPpA+oju8Xq11PBj3TL7hLB6n+sxTlXrPdeVo=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 08:34:45 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::3abf:2c03:8dfd:a058]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::3abf:2c03:8dfd:a058%6]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 08:34:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: John Ernberg <john.ernberg@actia.se>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Jonas Blixt <jonas.blixt@actia.se>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Subject: RE: Broken networking on iMX8QXP after suspend after upgrading from
 5.10 to 6.1
Thread-Topic: Broken networking on iMX8QXP after suspend after upgrading from
 5.10 to 6.1
Thread-Index: AQHaWpEPpeShfAur10u61GX5crs7mbEQD9jAgA9iWwCAABl+kA==
Date: Wed, 28 Feb 2024 08:34:45 +0000
Message-ID:
 <AM5PR04MB31391FBF10F18312F0E87C6F88582@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <1f45bdbe-eab1-4e59-8f24-add177590d27@actia.se>
 <AM5PR04MB3139C082E02B9C1B2049083F88512@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <521d30d8-91b5-414f-93bd-19f86bba4aa0@actia.se>
In-Reply-To: <521d30d8-91b5-414f-93bd-19f86bba4aa0@actia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DU0PR04MB9276:EE_
x-ms-office365-filtering-correlation-id: e706cdff-b52e-4cea-3d06-08dc38381e26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yXo3KKz8ju+bkorQmwhQf5w/oACaKMN5IzBJIS8xT8bOCcr8opwM39slBY0/7Rc0yKAikXEyQprwwI2Kul8CssSbeNcnmbxs1EMS3QrQwEAQNP8B/jmyLxJKQLtsVr7vb12FqZnBFBPTNhXyTcIwV5xKudu0O+5606ElKv/2OxeXa5QTuGUwKwzcq0aAna0ZADXleWVFaVXWNFJWZRWNduDBTDSAtHYjVCMrboCdZ7XDdCmB1dScbaeeZ3/0iPRi4/yYstDWaMHtsh1v2CSHqK8kfjMZOvV18o6z/KKIuWBMLHiDJntE+fvleWt8CRmAzdthy7++imI2t9pO3e/yoFgTHMHasjraGy6mM+RZhAUX0Ov3fFYKr8kbmN1jW3UDRjTLi4uOJkszxhq7rpsVdZxvH8D+iYmr7kNNJ2F4FZfugF9HLbCv0aQRwbRs3NEKkuYd2228bLu8bGLiNiQjbw8eAgggQYrrqcOSKsIykF1vX2SZ8hK40VViwv7pT9bggmAvyltqPkTO281mNp1QH37wrgjajFyQHpHV0w29Mlz+VkOXmjsUydCPQGoa9uZpLO4rhtOH/tF+h/qD5UjSRKqENEP2MkvdriVohqgANewpgdDKpQnYje9kbpRZP0fzxHW/cDFe4VW2glCF3zmmVBg937eEtLyirevekH13giY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?anVIMFA5ZXorNXJ5TEdlWllNMlFCSi90a2FpWCtUZEZhMFNKaWdqNGdZbW9P?=
 =?gb2312?B?b2t6MEVrMVV4bGszSGNTZXRCWStKTnlsQWlqMmlvYUROeml5QkxtVmJEZWh1?=
 =?gb2312?B?akVQU1lPU3ViRTVuWnIyTTNYek5OYnBKM2NnRWpmc2V3NnVwY2FWeGw0Qi9B?=
 =?gb2312?B?QVd1YlNqbDhLWHltQXF1clEweW1jZFFwSlhaWFQvZjE1cGFUUjlRZE5xWXJp?=
 =?gb2312?B?eHB4R0JHNStqYUtuWUZoOE4xWTk1bGYxOC92RkliNGI5WjBDTHVnY0hxK0ow?=
 =?gb2312?B?cUp6SjFkL09JRnVyNTVyMFhNWkFwTm5uOC9nT0RJU0VoazYydy9TajBMemZ0?=
 =?gb2312?B?NDRmNkhpQThhQ1o4ekdIclZhdGJnbXpTbUpKNGtMdU4reTYrUlZ0Q0dtSlNm?=
 =?gb2312?B?MGoyTS83TnpiWkdwU2dlRTdhUU5WNjQ3MGQveWtkdW9NTVJyOG1lM3ZXQmVG?=
 =?gb2312?B?N3hYYi90VzBEcTJmRjA4YUZsVFB2UGM3UUkwVm5sWE9KS01KTWpLM0RkWTRt?=
 =?gb2312?B?UFUxVFlxelFCMThIUWM1QS95ZG54VG9KMWlGUDdRRy9NTEtpWUFTbzZsYm5X?=
 =?gb2312?B?YXpDQ0p2K1RWNkFhaUVabm9aN3krRkRYMmZaQmJvMEpaVEpjRElNVjRzZUxV?=
 =?gb2312?B?UWE2bTZaYXdWbU1XSXQzd3FnUHlDWWs5N3dsVUlydFJ5dSsyRXM5c2xxb1gz?=
 =?gb2312?B?M1gxOWdaSC9zT2c1WnJKSjQyVFBXT1dJQ1FuaHZudjJneWxudVd3V01xQ0V6?=
 =?gb2312?B?b1A5a0o3bk14bzZVT29saUt0Uk5ZTXIvMGNHVG1sMDIxYlg4MU9RYWRUK2E4?=
 =?gb2312?B?L2xvSVJ5NTFzUDhZaG9EbGpmUGE1c1hEc2JuN1NTbHNQSkVWdmQvMis2eTVC?=
 =?gb2312?B?RFFPdisxZ1lyMVhyeFM0ZW9ZOWxCY0hsang0dTJFNlZzamtFMnNPbEtjRGJT?=
 =?gb2312?B?ZzNLKzJEMTdSWjR5RW0rbWJ1RlFnd0lzVDBtb0RqWFZNektLMm9RNiswd25z?=
 =?gb2312?B?eWprMmhsdDBvd21IZmg1M1NNaWE2NVlORDZqdmprdEUzSHlBTkxRTnZFMFc1?=
 =?gb2312?B?S29US05DT2JBaEpyNE9ucnVyeSt6Y0JvcnhsODAwak1qTHpFc3FhYlF4N292?=
 =?gb2312?B?bS9ZZTVhWjMyTU5UbDJ2aXpJK0VaUmVDT1Rva2h6dEhnckZkVWxYa3JxVVAy?=
 =?gb2312?B?WjcwS1Y3dUZFMXUwRFhTdkhCSzEwdnpGYnhDdElNeURvd1RWeTdkaU9YdHZO?=
 =?gb2312?B?WFpXNEdJblpYNWZTYSt2TnhYT0k5ZFovM2IxVmhyY1o2NktHZHB5THYza0xy?=
 =?gb2312?B?YktseHFURlFHd3JsaVc2ckJGbDh1dUxWS1VYZnBKTnNreXcxVzVQdUdxcFR0?=
 =?gb2312?B?eklzdnZPTlVUc01Qa3ZKZlJRQUU3Y0p2ZkdZUGhjVGNwYVdJUEhNSE00R29Q?=
 =?gb2312?B?NEZrOUMvOFNXNXJ5b2kySk04NFVtRCt5Uk1WTmRZcDNuZDZLdXd3T1lwZXNq?=
 =?gb2312?B?MHJTVFhuN3pTSzZlUy9CZTl0cnEzR3NsWk1ac2dyc2s2dUVNR2o4VUhwaERP?=
 =?gb2312?B?OVVZaitGa1JiNGcxT29NOWp6MmtXRmRuNVhYWjRmSy9HcjJIZEVpbk1COWQ3?=
 =?gb2312?B?Ri91alk4dnRBY2kyTHZZTUk1ZXNEcmFUcERPNVpXc25UdnM0Y3dNT2kzUkhZ?=
 =?gb2312?B?OTRGNkpwMERIQWRLN3hpZWRVSHRiV1Q4L0JmM2JEVGI3WmtJQ3NaTUR4ZEwy?=
 =?gb2312?B?SzV4c3VKdnpCc0w2L2gwWVpSb2dEL0hVMkROakFtMHo2YlNIVmN3dnBQSEor?=
 =?gb2312?B?Y1BBcDd1NHpzdXNiVTlYRjZoejlLVWVyRy95Q3dZWERicFlYc3h2VWM0L0wr?=
 =?gb2312?B?eEpGRVI4SG5naWU1WnA4a3VnTUJUYStjZUg4Vzhrd1RlbUhoZnV5Y25Zako1?=
 =?gb2312?B?YWJuZWtCdVpRZnR0R1lLT1RmVksxdjJHZXZpT3NPd2Z6bWNUbkZCRGRacjJY?=
 =?gb2312?B?NG5tQWhuTVNlcDFTN3BKbG1LRmdtZG4vdkQ0VXlSZmMrWUtxYUZzck04MTlX?=
 =?gb2312?B?WE85QTlzZ1ZJSy9EbWFzZGFNanN3WkVOaUdGU2tGYlUyVFptN1d5TEJPTDhE?=
 =?gb2312?Q?d07Q=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e706cdff-b52e-4cea-3d06-08dc38381e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 08:34:45.4862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lisULHxekY538Ushmt1BPI9VOyyOLDaq2QU4Y+uYjhnWRpcme6ed1o5nF5QFm5Ng/DSfci9+ueMwCqmKBg13gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIEVybmJlcmcgPGpvaG4u
ZXJuYmVyZ0BhY3RpYS5zZT4NCj4gU2VudDogMjAyNMTqMtTCMjjI1SAxNTo1OQ0KPiBUbzogV2Vp
IEZhbmcgPHdlaS5mYW5nQG54cC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBK
b25hcyBCbGl4dCA8am9uYXMuYmxpeHRAYWN0aWEuc2U+OyBTaGVud2VpIFdhbmcNCj4gPHNoZW53
ZWkud2FuZ0BueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgQW5k
cmV3DQo+IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsgSGVpbmVyIEthbGx3ZWl0IDxoa2FsbHdlaXQx
QGdtYWlsLmNvbT47IFJ1c3NlbGwNCj4gS2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPg0KPiBT
dWJqZWN0OiBSZTogQnJva2VuIG5ldHdvcmtpbmcgb24gaU1YOFFYUCBhZnRlciBzdXNwZW5kIGFm
dGVyIHVwZ3JhZGluZw0KPiBmcm9tIDUuMTAgdG8gNi4xDQo+DQo+ID4NCj4gPiBTb3JyeSBmb3Ig
dGhlIGRlbGF5ZWQgcmVzcG9uc2UuDQo+DQo+IEkgbXVzdCBlcXVhbGx5IGFwb2xvZ2l6ZSBmb3Ig
dGhlIGRlbGF5ZWQgcmVzcG9uc2UuDQo+DQo+IFlvdXIgcGF0Y2ggaGVscGVkIGdyZWF0bHkgZmlu
ZGluZyB0aGUgYWN0dWFsIHJvb3QgY2F1c2Ugb2YgdGhlIHByb2JsZW0NCj4gKHdoaWNoIHByZS1k
YXRlcyA1LjEwKToNCj4NCj4gZjE2NmY4OTBjOGYwICgibmV0OiBldGhlcm5ldDogZmVjOiBSZXBs
YWNlIGludGVycnVwdCBkcml2ZW4gTURJTyB3aXRoIHBvbGxlZA0KPiBJTyIpDQo+DQo+IEhvdyA1
LjEwIHdvcmtlZCBmb3IgdXMgaXMgYSBteXN0ZXJ5LCBiZWNhdXNlIGEgc3VzcGVuZC1yZXN1bWUg
Y3ljbGUgYmVmb3JlDQo+IGxpbmsgdXAgd3JpdGVzIHRvIE1JSV9EQVRBIHJlZ2lzdGVyIGJlZm9y
ZSBmZWNfcmVzdGFydCgpIGlzIGNhbGxlZCwgd2hpY2gNCj4gcmVzdG9yZXMgdGhlIE1JSV9TUEVF
RCByZWdpc3RlciwgdHJpZ2dlcmluZyB0aGUgTUlJX0VWRU5UIHF1aXJrLg0KPg0KPiA+IEhhdmUg
eW91IHRyaWVkIHNldHRpbmcgbWFjX21hbmFnZW1lbnRfcG0gdG8gdHJ1ZSBhZnRlciBtZGlvYnVz
DQo+IHJlZ2lzdHJhdGlvbj8NCj4gPiBKdXN0IGxpa2UgYmVsb3c6DQo+DQo+IEkgaGF2ZSB0ZXN0
ZWQgeW91ciBwYXRjaCBhbmQgaXQgZG9lcyBmaXggbXkgaXNzdWUsIHdpdGggeW91ciBwYXRjaCBJ
IGFsc28NCj4gcmVhbGl6ZWQgYSBzaWRlLWVmZmVjdCBvZiBtYWNfbWFuYWdlZF9wbSBpbiB0aGUg
RkVDIGRyaXZlci4gVGhlIFBIWSB3aWxsDQo+IG5ldmVyIHN1c3BlbmQgZHVlIHRvIHRoZSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uIG9mIGZlY19zdXNwZW5kKCkgYW5kDQo+IGZlY19yZXN1bWUoKS4N
Cj4NCj4gcGh5X3N1c3BlbmQoKSBhbmQgcGh5X3Jlc3VtZSgpIGFyZSBuZXZlciBjYWxsZWQgZnJv
bSBGRUMgY29kZS4NCj4NCj4gTWF5IEkgcGljayB1cCB5b3VyIHBhdGNoIHdpdGggYSBzaWduZWQt
b2ZmIGZyb20geW91PyBJIHdvdWxkIGxpa2UgdG8gbWFrZSBpdCBhDQo+IHNtYWxsIHNlcmllcyBh
ZGRpbmcgYWxzbyBzdXNwZW5kL3Jlc3VtZSBvZiB0aGUgUEhZLg0KPg0KDQpZZXMsIHlvdSBjYW4g
cGljayB1cCBteSBwYXRjaCBhcyBsb25nIGFzIHlvdSB3YW50LiA6KQ0KDQo+IElmIHlvdSB3YW50
IHRvIHNlbmQgaXQgeW91cnNlbGYgaW5zdGVhZCwgcGxlYXNlIHBpY2sgdXAgdGhlc2UgdGFnczoN
Cj4gRml4ZXM6IDU1N2Q1ZGM4M2Y2OCAoIm5ldDogZmVjOiB1c2UgbWFjLW1hbmFnZWQgUEhZIFBN
IikNCj4gQ2xvc2VzOg0KPiBodHRwczovL2xvcmUuay8NCj4gZXJuZWwub3JnJTJGbmV0ZGV2JTJG
MWY0NWJkYmUtZWFiMS00ZTU5LThmMjQtYWRkMTc3NTkwZDI3JTQwYWN0aWEucw0KPiBlJTJGJmRh
dGE9MDUlN0MwMiU3Q3dlaS5mYW5nJTQwbnhwLmNvbSU3Q2IwYWU0YjMzNGJhZTQ0ZjUwZDM0DQo+
IDA4ZGMzODMzMzE0ZiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAl
N0M2Mw0KPiA4NDQ3MDM5NzE5NTQxNzA0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9p
TUM0d0xqQXdNDQo+IERBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZN
bjAlM0QlN0MwJTdDJTdDJTdDJg0KPiBzZGF0YT1iMlE0ZVloWHVOSHdSZkc3a0lJdGVJZ1VWdFZ4
eG8lMkJBd3F5eXQ4T2RQaVUlM0QmcmVzZXJ2ZWQNCj4gPTANCj4gUmVwb3J0ZWQtYnk6IEpvaG4g
RXJuYmVyZyA8am9obi5lcm5iZXJnQGFjdGlhLnNlPg0KPiBUZXN0ZWQtYnk6IEpvaG4gRXJuYmVy
ZyA8am9obi5lcm5iZXJnQGFjdGlhLnNlPg0KPg0KPiBBbmQgdGhlbiBJIHNlbmQgYSBzZXBhcmF0
ZSBwYXRjaCB3aXRoIHlvdXJzIGFzIGEgZGVwZW5kZW5jeS4NCj4NCj4gVGhhbmtzISAvLyBKb2hu
IEVybmJlcmcNCg==

