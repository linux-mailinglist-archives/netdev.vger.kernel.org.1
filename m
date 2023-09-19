Return-Path: <netdev+bounces-34869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB787A5878
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 06:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6D02817D3
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 04:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C4E34CD6;
	Tue, 19 Sep 2023 04:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E8341AD
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:45:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE128F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfCdg/4UhdoVvj5W63hBZlbXpHCcddcfVJSFyig1mde1kEuYNtIx8ra+lPk1N3ahBiluwd1RyynD2Rc+4AMLPqRlIBpVojLql2+rU+g0XCKXTKKOuBi3a4HNsAinpra6G6KAfYFUyL05K1yB5AN/xmQXcJ+QR6KJ1NWwHJinw4NVFPywB1iUTRtT5vW8wHqgce2qDGAIb6Zy2B1CMi7KMfPBcs7QcAdSyWt4aqan0GWoVWSB33jNzL8xBWkYL5IJtgFSKU5pZrMJEtiouSfV6tXSY+EmNP4L71gPnP1APGNShALMzu2Nr2bUMPVbJP+f5Db7Z9TlReSGPLWrrGQYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci6tCw0gbwQopkGKv2ldXesk9xaJeWSTv8LJWyNpU3E=;
 b=QRAmFCzVH5ADyc9LEkToPkpsiCA1zpKwGFOZrS7gPU8jURu2AxVsZaMAgEoGB6Ur2si3L7Gg5Vv2i+l5a97xyEdprYKXa3j6jylJMMRHUnDX3LYPub7BPfs/ZQiiIxSh0RafQA+IylMqeukoF3M09PXKCUFde/Sct3A012GHq3RhFfQLQ7IX6gV+QvolbRiWGGwf/WIUoxn8qkl1Gete0qVwwn7+ArSUdCOtSBJlSEprGdEzijR2IvzCE/C3/SQO0c/wlIBC1c/BVph60HjbGSZI81BxhLoBcZpgUHHeMBAbmJ4M2fVeb34PcU2ybb8oSvQyfV+MyK+zDLyjUMSMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci6tCw0gbwQopkGKv2ldXesk9xaJeWSTv8LJWyNpU3E=;
 b=2aKEvK1b2Tcg764PsPHjPAxOzyfYoNzWN9wC6COQ+o49BAe1jrmwDNTvC6A7TLo26d3/aMWZFzM1ADT9MBrLiDlX6cmfpg0F4iQ3s7P6AtbZhylW16e6yoZYDlTw6hv0evn3MHEFHCNmKrWO/LOlZiODDKz8RCI/UTeQenowS00=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:45:04 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5e1:64bc:e8da:e22f%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:45:04 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "Katakam, Harini"
	<harini.katakam@amd.com>, Haoyue Xu <xuhaoyue1@hisilicon.com>, huangjunxian
	<huangjunxian6@hisilicon.com>, Rob Herring <robh@kernel.org>, Yang Yingliang
	<yangyingliang@huawei.com>, Dan Carpenter <dan.carpenter@linaro.org>, Bhupesh
 Sharma <bhupesh.sharma@linaro.org>, Simon Horman <horms@kernel.org>, Alex
 Elder <elder@linaro.org>, Wei Fang <wei.fang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH net-next 53/54] net: ethernet: xilinx: Convert to platform
 remove callback returning void
Thread-Topic: [PATCH net-next 53/54] net: ethernet: xilinx: Convert to
 platform remove callback returning void
Thread-Index: AQHZ6qxWZdCfeKFYVEaFyeRJyF4j2rAhkiUg
Date: Tue, 19 Sep 2023 04:45:04 +0000
Message-ID:
 <MN0PR12MB5953B8AD645AA87FF2672200B7FAA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
 <20230918204227.1316886-54-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230918204227.1316886-54-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|BL1PR12MB5876:EE_
x-ms-office365-filtering-correlation-id: 51513b7d-c0a3-4e96-dca9-08dbb8cb3102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 We1gd6G/8BeTiWGRqAicJzyX7ggHlttiBRrapBf2IY+vMbSuZtcouSE3Z7tUoq0qM9YiSg+LSxfosxSTNFQZn2XuM7kW0B5RVTKD1wEEbWEjALr2l7rO29AtTjQO6gbr3gJI4EflMN1XNTff7DCPO8ligYj+WBiY3mh0aEjCYHODAOMHmHwm6RFayiw1WuPTCKAgiopjD0FCPUnvvME6h0cYZd58PDkUClDWxNdhCxtyGQuvhUKmDBqaSuUekdqBA+sFfhLj3oCO88gDRB3BJOHQodVWVA2SmSn6KCl1Iz9i8+Defkt7dSqHC0JVdD/cEjJwPaz57wE/hQDPDgpUS+zWraJ1F5GK3eqJiHJsAhCBSydxbkZ/Ukp+Y7W3wc6mOMAhPk9UvOOqKPLeJKdhpDQKHIEqY2R+5KSDryn3u8gObvMUYHKEzmYBONV1ua3aypMf+wCE3RxQSlxQgBLT4Je+mkLLC5cRTCq+2VH7sHfDNfhyE7TpBB9DvjnXvHp0lwLy4P+9TPAXPXxdcLIizX1Z6EZ6VTyW9Gar/MN0FvyGE+uSUBUckst83/CiS9LT3hScVve5ZnnCzttwW8JBs8aLRN/1rzf1Z8NSVpz9ZG17bhKKjai+osspZNOmxAYn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199024)(186009)(1800799009)(54906003)(52536014)(110136005)(316002)(66446008)(66476007)(86362001)(64756008)(76116006)(66556008)(66946007)(33656002)(38070700005)(38100700002)(122000001)(2906002)(41300700001)(7416002)(5660300002)(478600001)(71200400001)(55016003)(7696005)(53546011)(6506007)(9686003)(4326008)(8936002)(8676002)(83380400001)(26005)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVpTcitRQVpaZitnQ0R6ckpNWkhjK1pvK016NTVxMkhpNjBGUlQvVW56Ykth?=
 =?utf-8?B?QzFKNks5TWZxb04yWEtjSFpqMk52UE52SjdaNnR5SnV0ZFVzRDl4SHd4aHZB?=
 =?utf-8?B?bEJJWFE0NkNxbHNYRU0vYmNuaHNqN3BKR0NHTm1zdlUyQWpUVjJxNHdQWXdD?=
 =?utf-8?B?N3BqRVlEU1NlZk9KZ3N0MWN4WUtzencyRGZiMFZGYXBSSFhFaDNGQXB4cFR0?=
 =?utf-8?B?QnFjQXVYNEVjUlc5eWRwTSs1SWNveTduV2p0N3hFWGVHM0hNeEtNbEVCNUZ5?=
 =?utf-8?B?dzgyaGhvUE1iUTdOcXBrRlE4Q25yM2RBWUppV2FEK0gzYTVpUTdHaEpWekQr?=
 =?utf-8?B?V0J6SFZrTHVGakNkTGxJaVFaQUN4WEVBTGE4cDE0bWN6a0dURkVSYVFpU3Jv?=
 =?utf-8?B?YTBnaFJsNXRlYnJpaVVsTFF4Y0h1cXVUU2pLMlJrTU5sVkErcjRJcElTQW1j?=
 =?utf-8?B?T3ZmYlh1clhUcEFQemFabE02aEEwWHliRVJkR1RPQkhFSk4xY0I3WkZIR0JO?=
 =?utf-8?B?V2gzYTE4am9mOThMQU1CMWVBSlVFM29GakVNK3R0OFhzakhUZFVaQjJGLyta?=
 =?utf-8?B?TEZMOXhMNGdZL0dmMngyOGp5OGgvdldQbVNnUnJSMFF2andsa2RHQWcwbktE?=
 =?utf-8?B?azduQzZ3Q3FmWmd4MVByaTB6NGlDR0Nsdkp2R3V1YzJMU0RxRzE5SHE1UXZh?=
 =?utf-8?B?QlhHb3JONEtnTnNhZ0dNS1FoMVI1bFRHazR0WnZYUXRuRXllc002Ni9PK2Rv?=
 =?utf-8?B?U2tkZUU4Tld0WWFYdi9pckIzYU1xQ25LdERZUlAvQTBYMXp4M3BSaWlrdW4x?=
 =?utf-8?B?VVN0aVNaZEdvTlFHamN2NlhkMHRIenZVTXZhMjNKanBrV094VDczVmdhQzV4?=
 =?utf-8?B?M0lCenY3QytweXhUOHpPTTRWYmNCS3FCWWJpQThlMzJITlEyUy93bGJaRkVX?=
 =?utf-8?B?SDEwVFhZQU82UHRiVXpRZFM3OW1nS3IvbjQvUEZONlA0VTg3cGg0NndxTWhq?=
 =?utf-8?B?UjF3MnExdS9oUU1xL1RwZ21TYkRIRnBOOHIwV2EvZnRqUFNBWEJidEZpeWZz?=
 =?utf-8?B?aTkxNmMyNzJ4TS9Qa01UZ2syUmkvUk9pZGpobmo0bGVBeDU5SjJKSk5pVE10?=
 =?utf-8?B?UVBpZTJlS25CeVpxQko4OVpSbVJTVEdWQm9ydm1SaXNyb1hPc2xGS1NCVHhX?=
 =?utf-8?B?VExUWWxWUnJOYk5CUHF3S3NVb0dvT2xFaTZDNE1pOGVaM29VZVkzU0V0Z0Z2?=
 =?utf-8?B?TnpXekRkWXprOWdBSFd3akVnWEZON0pRK05BUjQ5NE14MGpkWmxBNUZ0ZEFX?=
 =?utf-8?B?WWxrcXNFQTZLZWRZZGtkd2J6dSs4RlBjL0ZlWU5tY29FMVovaktnVzZZc3lX?=
 =?utf-8?B?bzJQRE9yVWxZWHdYckVrbUNOWVN0Y24xVU16YmxveFhXQTFhdE5DTlpHLzYv?=
 =?utf-8?B?ek9uQ3ZYVXpqMFpvenM4eWJ2WkpnVi9XWjkzQ09vNkZNQWVsZllrdEY2NlNI?=
 =?utf-8?B?RGJpSll0WDhlVVNLdGg4MnhWajJqMFR1TW9vb29sQlRZVmZ0dUtTNWpxYWgw?=
 =?utf-8?B?Y3FManptT3pJMmZ5UldSSUVWN0l5bnRNVkRraENNaWsza0FKMU5hTnlZQW4x?=
 =?utf-8?B?Zm01SmFscldNVlRMRGJtcnRoQ3VXS05GMHFPREhnOFR0YmFST2d5K3E3SkhC?=
 =?utf-8?B?QnZHSnRtbFVFdVVpZU1kMDgxSTFRT243M2p5dS9VZ1hUMjJaamJ1TENXNFNZ?=
 =?utf-8?B?SmtiUnRFNWZWUW9uTWlLdVYweFF5RFJadEYxKzA5b2w5dGc1S2lyMFhyOExJ?=
 =?utf-8?B?WHh0bFdXdVNROHpkaXR6WUZ2cEhmTFBWWWNQMG91WlNXanJ4bnY3MnY2RjZw?=
 =?utf-8?B?MnI0eU9GOUZaUlJUSy90U1F1YTBCR3pYaTF5WEV2Z1V5eFpoa0R4Q3MxbGwx?=
 =?utf-8?B?cUZXVEx5a3NJNmhJeUFmLy9DN3R0WDVTMUVMYmpLYmljc3J0SWI1MEZQVVVF?=
 =?utf-8?B?aFFUbHdmREZaZys3MlAySmZDdlNTc0NJSW1DY0lWeDM5a0Z3bEcydzk1WDk0?=
 =?utf-8?B?SXByUEgzTWtpb014VFF4NmgyTy9kWGVQUXdCd3lCWFMwUnlWL3VFZ3NQa3dX?=
 =?utf-8?Q?uR4E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51513b7d-c0a3-4e96-dca9-08dbb8cb3102
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 04:45:04.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgb+Z8kly9NyPfyBMlhu9pS0ecUXYvb5oZFYo72QlxAe6vLjqcO3XMzAEyZWKcZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1i
ZXIgMTksIDIwMjMgMjoxMiBBTQ0KPiBUbzogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxv
ZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2lj
aW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNv
bT4NCj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgUGFuZGV5LCBS
YWRoZXkgU2h5YW0NCj4gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT47IEthdGFrYW0sIEhh
cmluaQ0KPiA8aGFyaW5pLmthdGFrYW1AYW1kLmNvbT47IEhhb3l1ZSBYdSA8eHVoYW95dWUxQGhp
c2lsaWNvbi5jb20+Ow0KPiBodWFuZ2p1bnhpYW4gPGh1YW5nanVueGlhbjZAaGlzaWxpY29uLmNv
bT47IFJvYiBIZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5vcmc+OyBZYW5nIFlpbmdsaWFuZyA8eWFu
Z3lpbmdsaWFuZ0BodWF3ZWkuY29tPjsgRGFuDQo+IENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBs
aW5hcm8ub3JnPjsgQmh1cGVzaCBTaGFybWENCj4gPGJodXBlc2guc2hhcm1hQGxpbmFyby5vcmc+
OyBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+OyBBbGV4DQo+IEVsZGVyIDxlbGRlckBs
aW5hcm8ub3JnPjsgV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+Ow0KPiBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGtlcm5l
bEBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHQgNTMvNTRdIG5ldDog
ZXRoZXJuZXQ6IHhpbGlueDogQ29udmVydCB0byBwbGF0Zm9ybQ0KPiByZW1vdmUgY2FsbGJhY2sg
cmV0dXJuaW5nIHZvaWQNCj4gDQo+IFRoZSAucmVtb3ZlKCkgY2FsbGJhY2sgZm9yIGEgcGxhdGZv
cm0gZHJpdmVyIHJldHVybnMgYW4gaW50IHdoaWNoIG1ha2VzDQo+IG1hbnkgZHJpdmVyIGF1dGhv
cnMgd3JvbmdseSBhc3N1bWUgaXQncyBwb3NzaWJsZSB0byBkbyBlcnJvciBoYW5kbGluZyBieQ0K
PiByZXR1cm5pbmcgYW4gZXJyb3IgY29kZS4gSG93ZXZlciB0aGUgdmFsdWUgcmV0dXJuZWQgaXMg
aWdub3JlZCAoYXBhcnQNCj4gZnJvbSBlbWl0dGluZyBhIHdhcm5pbmcpIGFuZCB0aGlzIHR5cGlj
YWxseSByZXN1bHRzIGluIHJlc291cmNlIGxlYWtzLg0KPiBUbyBpbXByb3ZlIGhlcmUgdGhlcmUg
aXMgYSBxdWVzdCB0byBtYWtlIHRoZSByZW1vdmUgY2FsbGJhY2sgcmV0dXJuDQo+IHZvaWQuIElu
IHRoZSBmaXJzdCBzdGVwIG9mIHRoaXMgcXVlc3QgYWxsIGRyaXZlcnMgYXJlIGNvbnZlcnRlZCB0
bw0KPiAucmVtb3ZlX25ldygpIHdoaWNoIGFscmVhZHkgcmV0dXJucyB2b2lkLiBFdmVudHVhbGx5
IGFmdGVyIGFsbCBkcml2ZXJzDQo+IGFyZSBjb252ZXJ0ZWQsIC5yZW1vdmVfbmV3KCkgaXMgcmVu
YW1lZCB0byAucmVtb3ZlKCkuDQo+IA0KPiBUcml2aWFsbHkgY29udmVydCB0aGVzZSBkcml2ZXJz
IGZyb20gYWx3YXlzIHJldHVybmluZyB6ZXJvIGluIHRoZSByZW1vdmUNCj4gY2FsbGJhY2sgdG8g
dGhlIHZvaWQgcmV0dXJuaW5nIHZhcmlhbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xl
aW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC9sbF90ZW1hY19tYWluLmMgICAgICAgfCA1ICsrLS0t
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54X2F4aWVuZXRfbWFpbi5jIHwg
NiArKy0tLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfZW1hY2xpdGUu
YyAgICAgfCA2ICsrLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEx
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hp
bGlueC9sbF90ZW1hY19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngvbGxf
dGVtYWNfbWFpbi5jDQo+IGluZGV4IDE0NDRiODU1ZTdhYS4uOWRmMzljZjhiMDk3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngvbGxfdGVtYWNfbWFpbi5jDQo+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC9sbF90ZW1hY19tYWluLmMNCj4gQEAgLTE2
MjYsNyArMTYyNiw3IEBAIHN0YXRpYyBpbnQgdGVtYWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldikNCj4gIAlyZXR1cm4gcmM7DQo+ICB9DQo+IA0KPiAtc3RhdGljIGludCB0
ZW1hY19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3N0YXRpYyB2b2lk
IHRlbWFjX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgCXN0
cnVjdCBuZXRfZGV2aWNlICpuZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICAJ
c3RydWN0IHRlbWFjX2xvY2FsICpscCA9IG5ldGRldl9wcml2KG5kZXYpOw0KPiBAQCAtMTYzNiw3
ICsxNjM2LDYgQEAgc3RhdGljIGludCB0ZW1hY19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZQ0KPiAqcGRldikNCj4gIAlpZiAobHAtPnBoeV9ub2RlKQ0KPiAgCQlvZl9ub2RlX3B1dChscC0+
cGh5X25vZGUpOw0KPiAgCXRlbWFjX21kaW9fdGVhcmRvd24obHApOw0KPiAtCXJldHVybiAwOw0K
PiAgfQ0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHRlbWFjX29mX21h
dGNoW10gPSB7DQo+IEBAIC0xNjUwLDcgKzE2NDksNyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9m
LCB0ZW1hY19vZl9tYXRjaCk7DQo+IA0KPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIg
dGVtYWNfZHJpdmVyID0gew0KPiAgCS5wcm9iZSA9IHRlbWFjX3Byb2JlLA0KPiAtCS5yZW1vdmUg
PSB0ZW1hY19yZW1vdmUsDQo+ICsJLnJlbW92ZV9uZXcgPSB0ZW1hY19yZW1vdmUsDQo+ICAJLmRy
aXZlciA9IHsNCj4gIAkJLm5hbWUgPSAieGlsaW54X3RlbWFjIiwNCj4gIAkJLm9mX21hdGNoX3Rh
YmxlID0gdGVtYWNfb2ZfbWF0Y2gsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC94aWxpbngveGlsaW54X2F4aWVuZXRfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
eGlsaW54L3hpbGlueF9heGllbmV0X21haW4uYw0KPiBpbmRleCBiN2VjNGRhZmFlOTAuLjgyZDBk
NDRiMmIwMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlu
eF9heGllbmV0X21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGls
aW54X2F4aWVuZXRfbWFpbi5jDQo+IEBAIC0yMTgzLDcgKzIxODMsNyBAQCBzdGF0aWMgaW50IGF4
aWVuZXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAlyZXR1cm4g
cmV0Ow0KPiAgfQ0KPiANCj4gLXN0YXRpYyBpbnQgYXhpZW5ldF9yZW1vdmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gK3N0YXRpYyB2b2lkIGF4aWVuZXRfcmVtb3ZlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYg
PSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gIAlzdHJ1Y3QgYXhpZW5ldF9sb2NhbCAq
bHAgPSBuZXRkZXZfcHJpdihuZGV2KTsNCj4gQEAgLTIyMDIsOCArMjIwMiw2IEBAIHN0YXRpYyBp
bnQgYXhpZW5ldF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAlj
bGtfZGlzYWJsZV91bnByZXBhcmUobHAtPmF4aV9jbGspOw0KPiANCj4gIAlmcmVlX25ldGRldihu
ZGV2KTsNCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkIGF4aWVu
ZXRfc2h1dGRvd24oc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gQEAgLTIyNTYsNyAr
MjI1NCw3IEBAIHN0YXRpYw0KPiBERUZJTkVfU0lNUExFX0RFVl9QTV9PUFMoYXhpZW5ldF9wbV9v
cHMsDQo+IA0KPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXhpZW5ldF9kcml2ZXIg
PSB7DQo+ICAJLnByb2JlID0gYXhpZW5ldF9wcm9iZSwNCj4gLQkucmVtb3ZlID0gYXhpZW5ldF9y
ZW1vdmUsDQo+ICsJLnJlbW92ZV9uZXcgPSBheGllbmV0X3JlbW92ZSwNCj4gIAkuc2h1dGRvd24g
PSBheGllbmV0X3NodXRkb3duLA0KPiAgCS5kcml2ZXIgPSB7DQo+ICAJCSAubmFtZSA9ICJ4aWxp
bnhfYXhpZW5ldCIsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngv
eGlsaW54X2VtYWNsaXRlLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54
X2VtYWNsaXRlLmMNCj4gaW5kZXggYjM1OGVjYzY3MjI3Li4zMmE1MDJlNzMxOGIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfZW1hY2xpdGUuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54X2VtYWNsaXRlLmMNCj4gQEAg
LTExODMsNyArMTE4Myw3IEBAIHN0YXRpYyBpbnQgeGVtYWNsaXRlX29mX3Byb2JlKHN0cnVjdA0K
PiBwbGF0Zm9ybV9kZXZpY2UgKm9mZGV2KQ0KPiAgICoNCj4gICAqIFJldHVybjoJMCwgYWx3YXlz
Lg0KPiAgICovDQoNCk5pdCAtIGtlcm5lbC1kb2MgcmV0dXJuIGRvY3VtZW50YXRpb24gbmVlZHMg
dG8gYmUgdXBkYXRlZC4NCg0KPiAtc3RhdGljIGludCB4ZW1hY2xpdGVfb2ZfcmVtb3ZlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKm9mX2RldikNCj4gK3N0YXRpYyB2b2lkIHhlbWFjbGl0ZV9vZl9y
ZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqb2ZfZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBu
ZXRfZGV2aWNlICpuZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEob2ZfZGV2KTsNCj4gDQo+IEBA
IC0xMjAyLDggKzEyMDIsNiBAQCBzdGF0aWMgaW50IHhlbWFjbGl0ZV9vZl9yZW1vdmUoc3RydWN0
DQo+IHBsYXRmb3JtX2RldmljZSAqb2ZfZGV2KQ0KPiAgCWxwLT5waHlfbm9kZSA9IE5VTEw7DQo+
IA0KPiAgCWZyZWVfbmV0ZGV2KG5kZXYpOw0KPiAtDQo+IC0JcmV0dXJuIDA7DQo+ICB9DQo+IA0K
PiAgI2lmZGVmIENPTkZJR19ORVRfUE9MTF9DT05UUk9MTEVSDQo+IEBAIC0xMjYyLDcgKzEyNjAs
NyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciB4ZW1hY2xpdGVfb2ZfZHJpdmVyID0N
Cj4gew0KPiAgCQkub2ZfbWF0Y2hfdGFibGUgPSB4ZW1hY2xpdGVfb2ZfbWF0Y2gsDQo+ICAJfSwN
Cj4gIAkucHJvYmUJCT0geGVtYWNsaXRlX29mX3Byb2JlLA0KPiAtCS5yZW1vdmUJCT0geGVtYWNs
aXRlX29mX3JlbW92ZSwNCj4gKwkucmVtb3ZlX25ldwk9IHhlbWFjbGl0ZV9vZl9yZW1vdmUsDQo+
ICB9Ow0KPiANCj4gIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoeGVtYWNsaXRlX29mX2RyaXZlcik7
DQo+IC0tDQo+IDIuNDAuMQ0KDQo=

