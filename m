Return-Path: <netdev+bounces-55617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1480BAC1
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 14:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987101F21075
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D112C144;
	Sun, 10 Dec 2023 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="RhVZNwoS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2119.outbound.protection.outlook.com [40.107.13.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6907910A
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 05:00:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQRIoSssu5FrDjDBqUvtpk4iVRKBXl8Jg+5C+g0BzOGFv+dAIpye0yp6iTVvhCns1tO7etbmZMcLzCKRzaNbOZK8euaItOnem9UZ7ZMwWsVYG82SPloBmzjmMul/DZpnqhU1DwXpcp/oYeoiHaHpSxPt2roWfkCcVFjZXfYx3/+5PIT7Hb29Ix4qMMysxlCIiSsCJp7NHpfRVwyR+CbhkGXBMsYhsAlsDoXW5bjp8y4DUTPSgWQlNyEfwi3cQLtnLmsbJPd4W502dJzeDircXiNK6RsE9KHoo6uK/SYkXKhn83dLq4CMTjgf1Y4Wu/fyxA3f4fX+t4AwWtlHgkLD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEnJ5T/b2E+QOUJS+1raexP3WI0Wk3A7eNA24c0b7b4=;
 b=YQmGHpAgbTOvvGrYemFYpKrUN+0Iy364po3rGQy0VAxAbZGzFmfYlEgF/+yqTvGqJhNgx/RR7fHZIoBpY2crP37C9sn1nmOj8ewWM4alHAzjwYQ2pf1hnucCf8i6rPkvbBJLZ7FjSTEe8UKgqrBZBJ1kJcIkOOai7VJmzSffzawR636rtpVo28zmUCznErlpeqaXpCTatzRZZnvS9l6mQJI7vPi8tmRHVX/XFOgU7GzbirDGwDiXRsgiInViI9EJbiea66auH2yj3n5TjmcF4DXvKykAx+19XbFMbQXXIbT3bjyT3uNI4syOUtZSrokVz0ciCAlUnqYnxsEJ2JHKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEnJ5T/b2E+QOUJS+1raexP3WI0Wk3A7eNA24c0b7b4=;
 b=RhVZNwoS0XaW6FO0t+6j2ExL4Il2JkQOm9P3H95yI6TI91EmQj68pTJ8jHG6SlkdfC7F/J6mFL4GK1Rd1DpCgR/+L24v4PWkP07GWQOZYfmqDuBDTy2K/3fGd6X5AkCxc74voVJddu5gzKHrGJyQcB2/xW8IgLwE2MvHxCE3NDk=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM7PR03MB6513.eurprd03.prod.outlook.com (2603:10a6:20b:1b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 13:00:31 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 13:00:31 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: Rename bogus RTL8368S
 variable
Thread-Topic: [PATCH net-next 1/2] net: dsa: realtek: Rename bogus RTL8368S
 variable
Thread-Index: AQHaKvBTHMQMXYREK0aJEN0JEn2sRbCie9MA
Date: Sun, 10 Dec 2023 13:00:30 +0000
Message-ID: <surgf4zypwwthiulvmxxj2bbijvj6bxivcjyffiduyjlt22okm@borejh2vkgpl>
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
 <20231209-rtl8366rb-mtu-fix-v1-1-df863e2b2b2a@linaro.org>
In-Reply-To: <20231209-rtl8366rb-mtu-fix-v1-1-df863e2b2b2a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AM7PR03MB6513:EE_
x-ms-office365-filtering-correlation-id: fcaa1162-823b-46f0-055c-08dbf97ffd50
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /2w1BjYrlE2JYXh0nPg8SJxzxEbFJzJF122zLZIEdn9JHpg4SJgtQJoxrGLxj09NHqdbgTiAAdaa4Muns1AxV5Mm26PzP0N85iA0FXCb7lvgWYrOf6hvgFXwG1EWUK1Jeyjtqwf5Ns9Dupvgc2rArBPPQQD+TZ3dZlGG2hVjhUiOBjg3wW6YvM+537BO7kbrPiAm6V0pYPq/S+mauql6uGhkL2s6Z2ruRecau5fGGWPtZrJM0p4Xy9OnCLGrwYYaIW41XaFs5C7hXNfQRaU6WZLPuTGHryjs84pRLDaoVnJp7ICGg0rjHwDekbc+9u3w5SZqdvnwMeOXLs97siZKAZ/+ub97hw59SKsMWtFvDgGY7OKGxMddp+uBNv6KT0AaJwmain+8TCOiJg/c/k60OK7FBHfbvlv39rnYQYNoX0Ox6ZBJCvJlYk+2DPDrQHNml7XDiGfkd7QU3NlImXYzTi/QBIpMhBD+tGQvuYoZuAmMdQ+Pjwv2rStolR7/Od32gObhAOgA5i8QHiGLAR9pQUWyaKu2epjaZk9MU/B0UjYjnk7zL8/BtqSvIq7gmbwETp6Nl56ayOpp6eKKlN69nMMlOtL5jrW0pzXcKyBJP7Y3a1Gtf1bysGbXBW2Ij2W8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39840400004)(396003)(136003)(376002)(346002)(451199024)(64100799003)(1800799012)(186009)(9686003)(6512007)(33716001)(6506007)(5660300002)(26005)(85182001)(38070700009)(91956017)(76116006)(6916009)(54906003)(66446008)(66476007)(66556008)(66946007)(64756008)(6486002)(85202003)(66574015)(2906002)(83380400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(122000001)(316002)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUMxTFh4Q213MUVjY0RTSVpjU0NMYkRzclBGV0t3anFiYU5uakRaUCtnNVFx?=
 =?utf-8?B?RVphQytuTzJYRC9pbXh0ZDQ1THo5MTFsb0ZwaWpXbVdMdU40dm9rOTJFK2tS?=
 =?utf-8?B?VWNhSERRcEZKNXlMMWZ0OTBZRUZNOUdaOXg4UENoRUY0L1daMU1Lajl5V1NX?=
 =?utf-8?B?Y1hRRThETVNGUjdLNmhNWHJsUHcxcC9kVjJNVFRYZm85eGQ1bkF4Y2llRW1Q?=
 =?utf-8?B?dkRkejJndXJzaFF4dzBxWWNrcDRJNzRUdVpCeG9LeE8wMStTamZCK3cxREtU?=
 =?utf-8?B?OHgrYnZDNnJkUTA5NW9xQnhWUkh3SStkQTV1MVNBd2prTVFoREQ3Z1Qvb2pM?=
 =?utf-8?B?NE0wVFI2M1JRWWphbUIvbE4vTGl5b1kwcHh2bGhDQ3hYNml0dC9EYjF2eWF5?=
 =?utf-8?B?OFpnOXMrY2YvOTRydENpb1A2dllVQXYzWVp6eGhneFlKVFd4dVZrN2pVMGR3?=
 =?utf-8?B?L0JQUWVucUQxenE2YmVLQXRZWWR4dkMwR0ZjaXZUaWpmYmFKVzJYYytlV3FL?=
 =?utf-8?B?dngzMkUrUThvUHRtSktrRVJ4MGlmWGRVdm5GTlZuYVowT0lpUmRXclZIbG5r?=
 =?utf-8?B?NVNJRll4NVo3Vm1LREhhN3h2ckJUN1RXQ0lIWnNiVGFjRWhDTXNyZVpreXYv?=
 =?utf-8?B?S3Z2a2p6VlV6aTNxYjB2aGZEcEFQdHNOWVBPZDlzZWxYejZFdU00cExNZEhU?=
 =?utf-8?B?UytyZHFucXpmTkZrVkR3UjNmbVV0T3J3aDVIeDQweTU3NVNUV0l2M2FRelJB?=
 =?utf-8?B?THFoVVpVTHowRWkxcHVqYUR3SVFGT1ZmZTU3YTdOYlgrTVhzd0hNdjBDdzZv?=
 =?utf-8?B?Z1JhV3BvZ0JUcTlVLy9MZVZaSVQ5SW41ekw4NldIek5ubjJXczZGeE44ZXBl?=
 =?utf-8?B?Qzc3MjNMbU1zU2xGRXIvWkZLNnZaK3E4YUc1UU1GRkM4aDhEVWhBVWxlTE5x?=
 =?utf-8?B?a296QitxNWV2YzlpS3JLcjhJUjFBY2xrNVYyQ3RUS2ZqbjRYb1hCTTVuWUZG?=
 =?utf-8?B?YXJMRWE1ZHJYNG1PaUdBb2t6dWFDNUJpQlFOdXc3aUlyVWpIOWtpeHl4MjhI?=
 =?utf-8?B?YXdiMDFFR0FybmJrcFllY1VYQldDWGthRUxTbk5XZmhIMWZ0alEydk43bTJD?=
 =?utf-8?B?TDI5d3BwYWdsUWJsbTAwdlZweTU1WlQwQyt6b1FlK2xwNk9kSStKQjZhSk1C?=
 =?utf-8?B?cDFjUnlPeFB3TnVwN2lrMC9ob1B5ZEsxcjhJVlU1ZlFNdkp0dnMvZWJFc08z?=
 =?utf-8?B?TDUyWDQ2eWs3S0tXVXBvb0diSU1kUXNXekNhenE0a21MN2dlczNydjlPZXFJ?=
 =?utf-8?B?Rko1ZGJVSlQ0TGNCUmVKOHpEbFdlemVLNERrcGVPTFFyMDV1NGpUbktmVWdK?=
 =?utf-8?B?Ynh4ci9GcUZ2NDZsNzU2cXc2SFJ3U2pJZkJ1MTRpYmhQYVZtQm9PR0tvamhz?=
 =?utf-8?B?endjcDB5RWcvM09SQ1FodTRzYjIzenpldTVSYnRqcFZwV3pCTDV3QkxFTWF4?=
 =?utf-8?B?cy9TeTcyanRrcElxWE5HbXNGcHFpQjNXREJvT1NWVE1YUTVWcXFGSHArRGRV?=
 =?utf-8?B?bFpycXBnVk5EY3ZuMHFranNnMmtCMmhTU3N1c2VOL2svZGIyVSs0NEVVN3Fh?=
 =?utf-8?B?ajFLYVlTUjdQbU1wNmZTbFRnMW45T0RPaDB3MXllTGEyMmg5STh1QUIxcEk5?=
 =?utf-8?B?RDlFWEwxTXJtMkZjazZuQk5LeTBGVkRYUVZ4Q0RqdU5xWTlkc0VhbjlCNFEy?=
 =?utf-8?B?NTF0Z0orT2FGWWlZTmJmMnNQOUpDUG1wVmJMalEvRktncGpGeUQ1Y2xlQ3lQ?=
 =?utf-8?B?MmdWdlBMUEM1a3E5WXlteitkM0hVVForOXVyZmdKYWEvcHdKU2JXc0xmT3h6?=
 =?utf-8?B?WkJtWWhTTVVDQ0VmN1VjdkRhai9JakpTUlRuUUtyeTVPclVwTGhsei9oOU1t?=
 =?utf-8?B?TDFpSmRjWXlqelhwNHByWU9xQkxjR3VJQUpzQTQzZVFXOXZVVStKRWQ4RmpY?=
 =?utf-8?B?MDRPd3JUK2FPTHdWREJqOGpTTEFLZW5XMW1vaUNxZDFVK1Fxd3V6UEt2RTht?=
 =?utf-8?B?UWphTWt5N0JwSDQvRFltKy9IbU5VWkxyRkxuU0xscDdwbGFVc20xb2pzeFA2?=
 =?utf-8?Q?bs1gEHHXKGfOlRFCzT+RxWmb5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4E25F9BEFACEC4E9C4207142BAE73C8@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaa1162-823b-46f0-055c-08dbf97ffd50
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2023 13:00:30.8470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbpH5ENI3vjkAJDMJjXvtI8dTm/D2gVVLYS2koHq+d6IK1B6uNnt3PAU7DTptoGDV72XN/Ixh56CYiZHRC/2eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6513

T24gU2F0LCBEZWMgMDksIDIwMjMgYXQgMTE6Mzc6MzRQTSArMDEwMCwgTGludXMgV2FsbGVpaiB3
cm90ZToNCj4gUmVuYW1lIHRoZSByZWdpc3RlciBuYW1lIHRvIFJUTDgzNjZSQiBpbnN0ZWFkIG9m
IHRoZSBib2d1cw0KPiBSVEw4MzY4UyAoaW50ZXJuYWwgcHJvZHVjdCBuYW1lPykNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCg0K
UmV2aWV3ZWQtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5kaz4NCg0KPiAt
LS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzNjZyYi5jIHwgMTEgKysrKysrLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcnRsODM2NnJiLmMgYi9k
cml2ZXJzL25ldC9kc2EvcmVhbHRlay9ydGw4MzY2cmIuYw0KPiBpbmRleCBiMzliNzE5YTViOGYu
Ljg4N2FmZDEzOTJjYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcnRs
ODM2NnJiLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcnRsODM2NnJiLmMNCj4g
QEAgLTExNywxMCArMTE3LDExIEBADQo+ICAJUlRMODM2NlJCX1NUUF9TVEFURSgocG9ydCksIFJU
TDgzNjZSQl9TVFBfTUFTSykNCj4gIA0KPiAgLyogQ1BVIHBvcnQgY29udHJvbCByZWcgKi8NCj4g
LSNkZWZpbmUgUlRMODM2OFJCX0NQVV9DVFJMX1JFRwkJMHgwMDYxDQo+IC0jZGVmaW5lIFJUTDgz
NjhSQl9DUFVfUE9SVFNfTVNLCQkweDAwRkYNCj4gKyNkZWZpbmUgUlRMODM2NlJCX0NQVV9DVFJM
X1JFRwkJMHgwMDYxDQo+ICsjZGVmaW5lIFJUTDgzNjZSQl9DUFVfUE9SVFNfTVNLCQkweDAwRkYN
Cj4gIC8qIERpc2FibGVzIGluc2VydGluZyBjdXN0b20gdGFnIGxlbmd0aC90eXBlIDB4ODg5OSAq
Lw0KPiAtI2RlZmluZSBSVEw4MzY4UkJfQ1BVX05PX1RBRwkJQklUKDE1KQ0KPiArI2RlZmluZSBS
VEw4MzY2UkJfQ1BVX05PX1RBRwkJQklUKDE1KQ0KPiArI2RlZmluZSBSVEw4MzY2UkJfQ1BVX1RB
R19TSVpFCQk0DQo+ICANCj4gICNkZWZpbmUgUlRMODM2NlJCX1NNQVIwCQkJMHgwMDcwIC8qIGJp
dHMgMC4uMTUgKi8NCj4gICNkZWZpbmUgUlRMODM2NlJCX1NNQVIxCQkJMHgwMDcxIC8qIGJpdHMg
MTYuLjMxICovDQo+IEBAIC05MTIsMTAgKzkxMywxMCBAQCBzdGF0aWMgaW50IHJ0bDgzNjZyYl9z
ZXR1cChzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMpDQo+ICANCj4gIAkvKiBFbmFibGUgQ1BVIHBvcnQg
d2l0aCBjdXN0b20gRFNBIHRhZyA4ODk5Lg0KPiAgCSAqDQo+IC0JICogSWYgeW91IHNldCBSVEw4
MzY4UkJfQ1BVX05PX1RBRyAoYml0IDE1KSBpbiB0aGlzIHJlZ2lzdGVycw0KPiArCSAqIElmIHlv
dSBzZXQgUlRMODM2NlJCX0NQVV9OT19UQUcgKGJpdCAxNSkgaW4gdGhpcyByZWdpc3Rlcg0KPiAg
CSAqIHRoZSBjdXN0b20gdGFnIGlzIHR1cm5lZCBvZmYuDQo+ICAJICovDQo+IC0JcmV0ID0gcmVn
bWFwX3VwZGF0ZV9iaXRzKHByaXYtPm1hcCwgUlRMODM2OFJCX0NQVV9DVFJMX1JFRywNCj4gKwly
ZXQgPSByZWdtYXBfdXBkYXRlX2JpdHMocHJpdi0+bWFwLCBSVEw4MzY2UkJfQ1BVX0NUUkxfUkVH
LA0KPiAgCQkJCSAweEZGRkYsDQo+ICAJCQkJIEJJVChwcml2LT5jcHVfcG9ydCkpOw0KPiAgCWlm
IChyZXQpDQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+

