Return-Path: <netdev+bounces-59231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1685819FB0
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA721F2339F
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07F25768;
	Wed, 20 Dec 2023 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="A52WM8sQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2132.outbound.protection.outlook.com [40.107.8.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF42D61A
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQNK3DBcDL2xC3KgCOuEp7KJyZ0WPz9D696E60p6+cAetqkA/jhrKgyUwdE+Qw4DpRtQNS3O+VfwAV5W970oAKdtlxguU938N0P+Hwbsa6/U0Er0FEvuGeIHgzIJYFIT2bVNXGq8DrTF8oJ4hXMnN1XdzrhKVm+qAz2RaqbqmhQN1/y7QhflllQ6vFOgrLjyMNRNVLGvF+Kp5xHbTCnnAqyUnJx/HRWluYBSnhpYgtylndbQpLxwWHRaD1lwMSkgEUw/5Skbx0YHAVk0HjDNgIrdVbOhpgdIZXSTWWu5rrqxtoR5mJIfNtQlwvVBQAOlvlu3PgOgsmlEuehN4bxR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvlIwBUpnmTmgzUWNbg6xhuzt9F5eQVSQpBcUkyQCW0=;
 b=j9M/JUNPAUvveenEBaYGr5mQRKQGI0qsm5LycfAqKm6bYgkW6+jbdrOMRbxSCSShRr0qO7ap8YWn/h7YyB454koBydvikV54yjHjWEFZoSHaIoWYy7vosPPWREeF25W8N3HZSl3vYuym6QQq+3nEH/M5XBySERk5zStirfOgS/+nv/2ASzAEKz+uFPqPQrk0Rhpe7e90gulCoWRt6PthXl91T5T5YXQmyeMMQzu1fvlfV6uFUFH/SHMH2LHEBVd7dwQWg9z0osr9I42uYhCFLYRaHt6tOF3ugG2HxR2tR4FIh0tw1ouXZ8Mci2m9k5x11F24JddduTIsCYi5Gb/qcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvlIwBUpnmTmgzUWNbg6xhuzt9F5eQVSQpBcUkyQCW0=;
 b=A52WM8sQB7M9QXH/3Uk/aOTK8Ik9mtuQskSktIxPAlK5YGf574MggN/ILbeDGnAphIq7swzgax7uEeeZltNzRDSjHf/BcrJ2beD27JldJVthKRf3Vm6UKFOXPYC8/Xn21k+9yet/y96THyXM7OMSdr+5/IIOWwhjaPhn2owdPz4=
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com (2603:10a6:803:75::30)
 by DU0PR03MB8437.eurprd03.prod.outlook.com (2603:10a6:10:3b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 13:19:22 +0000
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::192c:39ce:80b8:fc2a]) by VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::192c:39ce:80b8:fc2a%3]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 13:19:22 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next v2 7/7] Revert "net: dsa: OF-ware slave_mii_bus"
Thread-Topic: [PATCH net-next v2 7/7] Revert "net: dsa: OF-ware slave_mii_bus"
Thread-Index: AQHaMvzUoGrPGivNqkOzEuBNM1mun7CyKFcA
Date: Wed, 20 Dec 2023 13:19:22 +0000
Message-ID: <w4qjjjt3wy5jwjxsfmg3mjqje5liocsbbnao34zbniijghx45a@3fxkroph6miz>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-8-luizluca@gmail.com>
In-Reply-To: <20231220042632.26825-8-luizluca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3950:EE_|DU0PR03MB8437:EE_
x-ms-office365-filtering-correlation-id: 46ada5e4-bf1b-499f-1ce8-08dc015e481d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SKCH1YOaCXrxb9ijLwZLsWMQ739T1oEh0A7a2nemJIwLNUgDAkp/HkPAr5F8mhrzZpnWCD7zhr2nLtWXozAqdzs1122NTJHyvKOV+/NqXwZgvea3WznAmqvZs9qj0srfq67+k9f4oHLEc2Pr/LKmeHVNNQaqqgP3C6YCrUQN9Yno1PCemEyleRhpNXPNXQqiDIAadecFd70/vISjhKXC+QcbK33IO2ME2iSAHWAixi4pJHqfmnr4KqJkCRcLcoXQV0TMjsjPtof3Huhwc4z6yoZr44O4Kh9bg+kHef70DjqR4gSaCEMgbnPREFtoH49JLv1f4/dOs9IxrNu9Jp3+zMRygmjIhqUiiHV170ozf6CrToSHaK+WXkjzjfnR7waDGUyw0sX4flt2XdJtYi25m9MhpDKDk/oc+fv9WOmwccxdh8y+PdcHSJsmyDqDnJ7MAo4jrAwup/HQXIYTWR/OmbzAZs/ZdN+hPtSiERlaF7SFxk0XqTrjQnMqHiF1/yO2nZ/ReL60RNm2gZU9kTL2RvVG/rdfle0J06yTNYdn/WHytToMwMH7alSlKuVtF8uWFfx95j3SCYoA8jWczlvLE41GNZ/aROPd9HNa3KNfChU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3950.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199024)(186009)(64100799003)(1800799012)(71200400001)(26005)(9686003)(6506007)(6512007)(478600001)(83380400001)(5660300002)(33716001)(76116006)(2906002)(8936002)(4326008)(8676002)(91956017)(64756008)(6916009)(66946007)(66476007)(316002)(7416002)(54906003)(66446008)(6486002)(66556008)(966005)(38070700009)(38100700002)(122000001)(85202003)(85182001)(41300700001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkhDNFdSRkFZMHVQU2gzWWR6NTBwZkJzSDU2dE1mT0g2Si83cTZFMGgzNVU4?=
 =?utf-8?B?bGM5NU5BeUZZZnVCeHllSHpCTHM5akwxL3VOSDNrM3ZWM1BvQTJRR29NMHZD?=
 =?utf-8?B?OWVPUDhnR2VlREJmaW1yUGl2VFZRYi9HMm9VeVJVRnFMbFNGRlNJNTRZRG44?=
 =?utf-8?B?Y3A5aHFEZTVZZDY5aE1pL2YyNEVZQW5pdXJaWFVBNk5TWVBqM1NBNWZ4Vy9y?=
 =?utf-8?B?cDJ2UEZ2WUY4eFE5QkVYMTlIUDZjK0h0WHpDeGNjclhqS25IWFZQTE5mb3My?=
 =?utf-8?B?WFFDV1crbzNFdmhxYzZuRmY0V3Y3Q2ZWc2psajFabDhSY1cxQ2ZiWTlCR0Zi?=
 =?utf-8?B?ejl2TGkzU2RBQXo3eFkrSHhFY0hnUFR4YS9IYWVhcUEzdSthazR4QlRpZC9B?=
 =?utf-8?B?ZGhHdXNZVkRWbHp2QWJEaXJ3c1FZMWpScVhZMnJ5SkNUNlgyMFhHNG1mc1By?=
 =?utf-8?B?Y081bEs4eVY4V2ZPQ3M4c1F6U3FYdU5NMmo1MkxYMHc5QW0yMThoenk0UzRv?=
 =?utf-8?B?RzUrQW5iYUVNZFVWQ1lqamxBNGRpbEpkOVlkbUhGMGtHMk5qRUczaHNTZzFs?=
 =?utf-8?B?QVZhbWlHdDlBYzdkRmFBMTN6SzBQUTJkM1VrUi91aWFBOUE3MWJJNVFKMTBs?=
 =?utf-8?B?TE1DNVRCUXJhZ01JRmNLc0tQUGorSnpGK2N1emNVREZZQTF2RFpSZnEvQktz?=
 =?utf-8?B?bmZxVFpoNkIweFhVSUhZa2lkc0EyT2hVS1NTWmdtaWh6NzBaaG8rQXg5aGRv?=
 =?utf-8?B?T3l0R3A1WGVzNEkxOEJ5bDF3V2g1c05pbHA1emE5UGFBSUU3WHVIN0xEVzFm?=
 =?utf-8?B?bzlOeEk5aXNlWEk0dTh0b3VLWUliMHFLQ21XNkRWWC8xOGYxV1pTYUxqZHVi?=
 =?utf-8?B?NGtDbEhmTE9abko2bjhjL2dsRzBnOVpzRWRuY3FZcHp6Wm55NTlPSFd4SmJE?=
 =?utf-8?B?aXFxdVRVQks2U2toUThNY0JRVjdaS1dKRUZSVVUyTlZjRUFCbzkzVWN3UXFG?=
 =?utf-8?B?S0lsMkxtS3IyYTRQekRMTk9PK2xzV2lPZUg4NDBaS0w0VHJlVFBGSTYydDBq?=
 =?utf-8?B?bGJLSGVOaW4weGF4bVBOVm5kSSs0OFEzKzVrRUVXVEk1M0tVQk83amNISUpC?=
 =?utf-8?B?UllSK3EvTWpoZVVYWkRTaENzbHI5SHpLUk1heDdxd09saWs3bDlGaU1HNDY4?=
 =?utf-8?B?TnNFSGhEeWlFTFV6VW04cG91V1ZYVUs0NkFCc1g2WVZKL2xFNmdYcEc1UXA5?=
 =?utf-8?B?OW9vVU9HTjRCMDMvKzJjcVNPVSt5K0hsRFhscHgxY0pZVjZaR1VKZUozdWJm?=
 =?utf-8?B?ZjNXU3BtVlZJRlZpeU5NdlhDNUhTTVpmMmR0R2tiSGROVUJiM2FyRDcrN2FN?=
 =?utf-8?B?czlncFpUNVUybHBWN1BBMTFtcXhyYW9NZmpCQ1dLTFhVZXkwMFBaUDlkR3lT?=
 =?utf-8?B?bjY4bk9renBmYzFtQS93ZUpjMExTcFBraUQ5UlJOdVgzaHV4eTBiMTJPV1lk?=
 =?utf-8?B?SWF3UHdYMkVmU041ZFo4Y0dMTUhKTEdMUzRwS1dvR0lkNzExTi9NQUw2RVZj?=
 =?utf-8?B?Q1FQcmprWjdONmZDYzF2VDBHYXQ2MDdVc1UxSTRzTWJabFYwdUtlb2tEbVBG?=
 =?utf-8?B?RlVaMUUySkNMQm16RndtQ20yMVNMcWZ4cmpqL01xUGt1cWtlSWdGSFpvZXZx?=
 =?utf-8?B?Mzg3TDhmLzBrcjE5OUdTWllrUlZzY0tmNWZ4bXJrMUNaWFd5WXBGOUlRSndJ?=
 =?utf-8?B?a0g3VkhKV2NicjRKNFhianp1NU9BZ2JOaGhENkFtbG13YjZ1Mm1tMEFQWlFX?=
 =?utf-8?B?ZitmVVlSZE0wRGZ5U1czYTBBU0NNby9RTUNCMkIzbGI2TkJYc0FYOGxsTkYw?=
 =?utf-8?B?WFI5MzRXZ0Z3Wk5ZTWw5N2pKeEE5UHhMOGNXZ1hTUUhrdXN6RVdqdWllaG4v?=
 =?utf-8?B?QzZnMSszaENXZFE4QTlqcjZpRE9lZU95N1RlRDFTelBwYzRvNElFTkc0UHFp?=
 =?utf-8?B?V2R0ZHBWTlpvNHNYNlkyemY2MGNKbGdkZEg2L2JNZVZDdkVtUEsweFRLVlM4?=
 =?utf-8?B?dlBwQ2s3d2hVWDFGWitzRkNIU1VMSWk4b2llbFNBWGJWdFJlNFY4UGpjdHcx?=
 =?utf-8?B?dlJSTFJqaVluU1NNRHNVNjlBOW1GM095eWRyeHBoSFFiVHRoQWRVRXB5M3Vx?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <144871C019710845ABB4D1645F440B7A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3950.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ada5e4-bf1b-499f-1ce8-08dc015e481d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 13:19:22.7682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJx5nTq3A4r3dWlYjU4WoRI0pNBX1A529fIwZTR+cDms4eg3CwGuk6PZgLkmLadOqyLIn0qHwkWyDw/fme8lRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8437

T24gV2VkLCBEZWMgMjAsIDIwMjMgYXQgMDE6MjQ6MzBBTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gVGhpcyByZXZlcnRzIGNvbW1pdCBmZTczMjRiOTMyMjIyNTc0
YTA3MjFiODBlNzJjNmM1ZmU1Nzk2MGQxLg0KPiANCj4gVGhlIHVzZSBvZiB1c2VyX21paV9idXMg
aXMgaW5hcHByb3ByaWF0ZSB3aGVuIHRoZSBoYXJkd2FyZSBpcyBkZXNjcmliZWQNCj4gd2l0aCBh
IGRldmljZS10cmVlIFsxXS4NCj4gDQo+IFNpbmNlIGFsbCBkcml2ZXJzIGN1cnJlbnRseSBpbXBs
ZW1lbnRpbmcgZHNfc3dpdGNoX29wcy5waHlfe3JlYWQsd3JpdGV9DQo+IHdlcmUgbm90IHVwZGF0
ZWQgdG8gdXRpbGl6ZSB0aGUgTURJTyBpbmZvcm1hdGlvbiBmcm9tIE9GIHdpdGggdGhlDQo+IGdl
bmVyaWMgImRzYSB1c2VyIG1paSIsIHRoZXkgbWlnaHQgbm90IGJlIGFmZmVjdGVkIGJ5IHRoaXMg
Y2hhbmdlLg0KDQovbWlnaHQvIG5vdD8gSSB0aGluayB0aGlzIHBhcmFncmFwaCBjb3VsZCBiZSBt
b3JlIHByZWNpc2VseSB3b3JkZWQuDQoNCj4gDQo+IFsxXSBodHRwczovL2xrbWwua2VybmVsLm9y
Zy9uZXRkZXYvMjAyMzEyMTMxMjA2NTYueDQ2ZnlhZDZsczdzcXl6dkBza2J1Zi9ULyN1DQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBMdWl6IEFuZ2VsbyBEYXJvcyBkZSBMdWNhIDxsdWl6bHVjYUBnbWFp
bC5jb20+DQo+IC0tLQ0KPiAgbmV0L2RzYS9kc2EuYyB8IDcgKy0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L25ldC9kc2EvZHNhLmMgYi9uZXQvZHNhL2RzYS5jDQo+IGluZGV4IGFjN2JlODY0ZTgwZC4uY2Vh
MzY0YzgxYjcwIDEwMDY0NA0KPiAtLS0gYS9uZXQvZHNhL2RzYS5jDQo+ICsrKyBiL25ldC9kc2Ev
ZHNhLmMNCj4gQEAgLTE1LDcgKzE1LDYgQEANCj4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvcnRuZXRsaW5rLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4N
Cj4gLSNpbmNsdWRlIDxsaW51eC9vZl9tZGlvLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfbmV0
Lmg+DQo+ICAjaW5jbHVkZSA8bmV0L2RzYV9zdHVicy5oPg0KPiAgI2luY2x1ZGUgPG5ldC9zY2hf
Z2VuZXJpYy5oPg0KPiBAQCAtNjI2LDcgKzYyNSw2IEBAIHN0YXRpYyB2b2lkIGRzYV9zd2l0Y2hf
dGVhcmRvd25fdGFnX3Byb3RvY29sKHN0cnVjdCBkc2Ffc3dpdGNoICpkcykNCj4gIA0KPiAgc3Rh
dGljIGludCBkc2Ffc3dpdGNoX3NldHVwKHN0cnVjdCBkc2Ffc3dpdGNoICpkcykNCj4gIHsNCj4g
LQlzdHJ1Y3QgZGV2aWNlX25vZGUgKmRuOw0KPiAgCWludCBlcnI7DQo+ICANCj4gIAlpZiAoZHMt
PnNldHVwKQ0KPiBAQCAtNjY2LDEwICs2NjQsNyBAQCBzdGF0aWMgaW50IGRzYV9zd2l0Y2hfc2V0
dXAoc3RydWN0IGRzYV9zd2l0Y2ggKmRzKQ0KPiAgDQo+ICAJCWRzYV91c2VyX21paV9idXNfaW5p
dChkcyk7DQo+ICANCj4gLQkJZG4gPSBvZl9nZXRfY2hpbGRfYnlfbmFtZShkcy0+ZGV2LT5vZl9u
b2RlLCAibWRpbyIpOw0KPiAtDQo+IC0JCWVyciA9IG9mX21kaW9idXNfcmVnaXN0ZXIoZHMtPnVz
ZXJfbWlpX2J1cywgZG4pOw0KPiAtCQlvZl9ub2RlX3B1dChkbik7DQo+ICsJCWVyciA9IG1kaW9i
dXNfcmVnaXN0ZXIoZHMtPnVzZXJfbWlpX2J1cywgZG4pOw0KPiAgCQlpZiAoZXJyIDwgMCkNCj4g
IAkJCWdvdG8gZnJlZV91c2VyX21paV9idXM7DQo+ICAJfQ0KPiAtLSANCj4gMi40My4wDQo+

