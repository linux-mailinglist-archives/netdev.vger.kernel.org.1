Return-Path: <netdev+bounces-19718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A8875BD49
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 06:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EB21C215F6
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 04:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB9D37D;
	Fri, 21 Jul 2023 04:31:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79884635
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:31:51 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8C426AC;
	Thu, 20 Jul 2023 21:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHQI+4IQBw/tXYLc1xkqKKwcDc4Cxr+EFY+PeUgI5NWqJBojSnkj10AsA70WudTRNzhx0nF0ITqfLYrpH3zjXzyL++woZKU6R7T6s4hATC/mgXI/iUQxT7PxR+SA9k6yaaUG1zPKQim0X+Aqy/fZGWZWi7xZYDPOYye/l7AEQWBRm2FAivVTPwlYszgFzRsbkSFf1C4AWSxTiSU7YmYc1MANQsdWCuM8+1wkOL+6aDL8UXrqIp/3FqokzvSGlUX5qM78aWxM5DbccbvPAy34FEo+E9+bxh/+jndolro7ydkhZ31h+g5u4/dH63BKY1xHRzGqg+54JpnBADkeyNQgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ek11O8/JJ+6ETML59ajoNFDXhPqozSolu/sQNumt5Y4=;
 b=BG/Ph5LNJ3Qbk+FgbMj9SzF/8nvE3oC3oXCzLVAvNwjzaSAT4RTagiLA8mx3T+ivw43DGrHlsTiT1Xq1lS+6TkyJ3OccCaM3D6cpUOls1VjWysDrPZ0h/0Fu+kLAprVJB0yevOkyEINJf7b29ljZEEa6phOZUc4iFx8ORaurzjXAE/G96Wdo3d+voSE0JtncgN+0YcGW3aawHJwdBFTJA0N5XxplUS+aWDlJpvagsSA7B0JPuY5lEsRsvwnqgTYfjFLVG4rM8aTvjIXiJOOZOuFqBVzfi8Pt2Xqgp5P0nu34QsmyHR3jly0hEHbGrQ5A69TWPQB5EN9KCFrY7MJR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek11O8/JJ+6ETML59ajoNFDXhPqozSolu/sQNumt5Y4=;
 b=SKmmfdcGw2uP8/N2eWLnKzRdtCrUfJYTgZwBzdnXM9cuS1Ylnx32j66xKyn0qspo9wDEbhA9FSut4gP8YnoTvg2+tjHlxit57h6YtmMiVTO8b7tJ5CWPVYCUcKWQWQ+WgVcQsYN4sAVVsQCFHNNTfhyg+qW05Tu/cF4t7xBbqDY=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB9PR04MB9844.eurprd04.prod.outlook.com (2603:10a6:10:4c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 04:31:46 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 04:31:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH net] docs: net: clarify the NAPI rules around XDP Tx
Thread-Topic: [PATCH net] docs: net: clarify the NAPI rules around XDP Tx
Thread-Index: AQHZuyUkcnIl2SClQESpEUnlGQ6wha/DgMyggAAJvgCAABeY4A==
Date: Fri, 21 Jul 2023 04:31:46 +0000
Message-ID:
 <AM5PR04MB31393F7A4258D96DE309F45E883FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230720161323.2025379-1-kuba@kernel.org>
	<AM5PR04MB3139FC41B234823EE28424E2883FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230720200700.162b29c6@kernel.org>
In-Reply-To: <20230720200700.162b29c6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DB9PR04MB9844:EE_
x-ms-office365-filtering-correlation-id: f79680c0-2154-4216-c3ed-08db89a36492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gSNoiXBf6nVZJLO/FlZDiggAxYLSIhNApQEpIl+nuOGRaGls02Ldq28J4LvwwBhaCHrEalieK2/INjPGzPAhl0h7ZYWviGqNM+INaLgy/Q6HtJE/s4PWgmD38E/g0Dzh62kW+qmSHU+7/Pv0Ff9zbEZwr1EpjbP35kDWT8tCXrSlaZZOgnFSjGbl3ZEQm20utehkJm48JL+6mUsHgBzVPrjrskjW2FCl04vXMdonFq+RtdhQeNm31Jm/VQ4q3dIAL3xyKPek4G1swYFW3RICyya1WLZFYh/AnD0+AOBZXxG/RvzOZ2OVC3Z+ZOXOumoH37FbyiDArCSj+236dmW9TJhZEp/1eeWyw9Y5z4zwFU3G8tfGgkQmLZ0r1XjbCrIA3ddh4t2UhbcxjSgPmPFmWDfCulK57zDCYQthSNCNSg/z6jsJs3C1q7e+03JuQv9QOiqipkO5gf9OoTH0BvOfVydH7SyNVem6+E2SQ96bljZRib53FOgiqOPjNbgSmAzrbZFZJnks9lWIQ2x9ZJ+shtvAh+pXz668koyvdeiQ/dVpaobfJKGCWRZsvSQgn19wXnyVOmSX3j+JMOQtbPiA90/B+nxD3y+X3S1fisSER+d0CzY5Vb0ljUZyusbzubQk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(38100700002)(38070700005)(55016003)(83380400001)(6916009)(64756008)(66446008)(76116006)(316002)(2906002)(66476007)(66556008)(66946007)(4326008)(9686003)(71200400001)(7696005)(54906003)(478600001)(26005)(186003)(41300700001)(6506007)(8936002)(8676002)(52536014)(53546011)(44832011)(5660300002)(122000001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Si91S2dJRGlsN3I2cnJncmtCUFNDS1ZPY01BNVloRkVpUjRQZ1NXUi9hSFBN?=
 =?gb2312?B?Qm9HL0NoVEpCb1YvWWdjYTI4WS8wOVBmbVJPSEhpeGVpcWdwYWpTckdlTnNj?=
 =?gb2312?B?b1BtVG4xVjYrUWZ4clNxcjg2WWtKWk1ZSFY4UWd4aFNsbmNWQWF3cjR1LzZu?=
 =?gb2312?B?bGVOd2pwMnZoUk9aRXdacm9QSWdNL3pxUVNZS2RYbm1sRlFDWlpRUWFPZ1JE?=
 =?gb2312?B?d3MwOVdWYTBaNHI5UFl5KzNGdWxOLzdYQnpBTXRuTTBpVXZXZml0a3Z6TkYw?=
 =?gb2312?B?TnhBTmxDSjZNM3lvTkpLdytqOWZTaUFqN1RxWms5dUhBS1ZJOXVWcExrR2VF?=
 =?gb2312?B?eDY3RDFPZTQ4ZWxucVBidnU0MHhhaXd2MGdtMTNtZ0o5dDhJUHRsS1ByVkVy?=
 =?gb2312?B?VEdSdWlWS3MvS2FOMWh0RXhZa3k0RmVRci9ydWRyVlc3SXdtWXh6VnUzeUZn?=
 =?gb2312?B?YzFiY0JXdmtTanZHQjlUYndkbEUrV211SDMrMU9sWnBFLzRDTXpBOFB3Rzht?=
 =?gb2312?B?ZE9lT3M0dFduQlRBeXB5MStDaGZYV0Z4ck5QcTFrTy94WG1HWVgxSjkyK0Yw?=
 =?gb2312?B?N1ZvWjd2Z2gxY0RzY3J6RHlqM2xNRms2d2dTNkhtM0JjdWFnZTJ1WVhxYWVQ?=
 =?gb2312?B?c3h1a3pEcmNPZ245dzY3R21UdkpmRW5KYnBmRkVZZm5YY3RVZzh2RFphbC9V?=
 =?gb2312?B?andmY2oxYk1XRW5ZZlVKZEcrekVsYmpySXFKT25Wdk1wd0VSREtxWEduNUhX?=
 =?gb2312?B?QWdFY0E3cC9COWx5dFh5ei9idXJWckN6YmM3U05DWFZOUlkxNmNDSDJqWklD?=
 =?gb2312?B?dWdlOGVmcU5OY3dmNTFTK2wvR1RYdDArbG5Vbnc4ZExpYUZlMjJBV3dGL1RQ?=
 =?gb2312?B?MTQrQUsxZUFiQUZvUiswUXBxQTNzRE1rUVdwUFo2Nnc2WkRrVnNXT2ZRZFQ1?=
 =?gb2312?B?Z2syV1BJbjdNSjBkWEhINGdkN3VmRG1RYUNiUS82UW1UZVJlbWhzVVRQZk04?=
 =?gb2312?B?c2pCeThQcjlMV1o3ajdRV2RCU09WUFJJSjl3RFdUY3laenpYYmwrYkQwMXYz?=
 =?gb2312?B?cDlTT2p2NHh3d29zN2NqUytZTUVpdE0xUmhiNndWaS8vZWZWd3dYYzBEbi9F?=
 =?gb2312?B?YUxmbGR6S0RkK1RJL21aMEZNY0J0UEpxSDVSaUlVNWl6aWtMcGdNNEdsTEo3?=
 =?gb2312?B?NDk3NlgrMzVqUHk2c1lFK0pkcGRUL2FTSWV1QmZRcXZIZXl5UWdTWkFobmlX?=
 =?gb2312?B?Vk4vZ0djSkJFOVB1dFhmYjBVVDM5MDBGWjFmSjVSTUZPamlGLzlLcFBFUkRw?=
 =?gb2312?B?R09oSXRvUFpOcXZuZjlyNEVnenhwTWdUMytxUmpZUFFrK1FTSWY4VVlzZGxZ?=
 =?gb2312?B?SVZ6T2hudHBGQWN3RkNja29Ma1NKODNVSDFLUTJnbU1HdzRDZ3oyNUIyTXJE?=
 =?gb2312?B?YjIycnpBcjVjb2NGNUs2ZnUzTXM3Y2pVWjgxNjd0b1czWDd4T1k3UmdUdGhU?=
 =?gb2312?B?dlgyV1Y1UEM0SkM3MXhGYy9odWUrT2tFdU1COTUrbldVZ05PNlZpendCMkxT?=
 =?gb2312?B?UEd0cndsT21RZ0xSR2pTbHlOZUdWM3Z2RXJxb21WUlRTSm1JbjlxSXljUFBH?=
 =?gb2312?B?TmtoWXNzVCtJRnhaT3RvMTFxeU1pZG5uSHJxZ3k3UDRPM1I3ZkxrRFd4bVdw?=
 =?gb2312?B?ekJ0MENJZEpUSGFvY1ROY1ZnTVFUYW5mNnZzQnh3VUJ4bEhObWhscEdYbDVw?=
 =?gb2312?B?WFJ4R1VabkVSemNlU1VKK3QybmtRN1NaSG5XaGd0QnFnTlFxV2p0L3A4SXdZ?=
 =?gb2312?B?aTRnTjRuaXRSYy9wSkMvQm55d2s3S3Y2dUdNT0ZWb25xYWhjZmR4L0s3ckx6?=
 =?gb2312?B?M21zYys2MW1QMU95eHpXejJuWmtkdUp0MDhrMWtMZXhwTzFhZFVVUkVjaWRx?=
 =?gb2312?B?bUE4c2M1V2tMMWU2ejlGalZhMVVCNFl5dTNHNlIrMmY1aHI1VFlPZlZYT1Q1?=
 =?gb2312?B?OHpLSUpQenFlZnNsVkFiNHhrSTV4enA0WUZ4cm5vbXpJNUdvVXR0SGlQTHpz?=
 =?gb2312?B?aU8vNDdYTEl5Vmw0eXBxMytmVXZEWlV0UlV5NWc4MnVjMmRDSTJYek1Gb0Y4?=
 =?gb2312?Q?PFlA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f79680c0-2154-4216-c3ed-08db89a36492
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 04:31:46.2642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0i0ucXnx3irsPm2fL4KC4DjaU8gDijk/TAvR2BeP72ObiCTVlVhv1jrO6oWjsF1dMaac4xLy/z/OBKZMdKV4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOo31MIyMcjVIDExOjA3DQo+IFRvOiBXZWkgRmFu
ZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGVkdW1h
emV0QGdvb2dsZS5jb207IHBhYmVuaUByZWRoYXQuY29tOw0KPiBjb3JiZXRAbHduLm5ldDsgbGlu
dXgtZG9jQHZnZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIG5ldF0gZG9jczogbmV0OiBjbGFyaWZ5IHRoZSBOQVBJIHJ1bGVzIGFyb3VuZCBY
RFAgVHgNCj4gDQo+IE9uIEZyaSwgMjEgSnVsIDIwMjMgMDI6MzU6NDEgKzAwMDAgV2VpIEZhbmcg
d3JvdGU6DQo+ID4gPiAtSW4gb3RoZXIgd29yZHMsIGl0IGlzIHJlY29tbWVuZGVkIHRvIGlnbm9y
ZSB0aGUgYnVkZ2V0IGFyZ3VtZW50DQo+ID4gPiB3aGVuIC1wZXJmb3JtaW5nIFRYIGJ1ZmZlciBy
ZWNsYW1hdGlvbiB0byBlbnN1cmUgdGhhdCB0aGUNCj4gPiA+IHJlY2xhbWF0aW9uIGlzIG5vdCAt
YXJiaXRyYXJpbHkgYm91bmRlZDsgaG93ZXZlciwgaXQgaXMgcmVxdWlyZWQgdG8NCj4gPiA+IGhv
bm9yIHRoZSBidWRnZXQgYXJndW1lbnQgLWZvciBSWCBwcm9jZXNzaW5nLg0KPiA+ID4gK0luIG90
aGVyIHdvcmRzIGZvciBSeCBwcm9jZXNzaW5nIHRoZSBgYGJ1ZGdldGBgIGFyZ3VtZW50IGxpbWl0
cyBob3cNCj4gPiA+ICttYW55IHBhY2tldHMgZHJpdmVyIGNhbiBwcm9jZXNzIGluIGEgc2luZ2xl
IHBvbGwuIFJ4IHNwZWNpZmljIEFQSXMNCj4gPiA+ICtsaWtlIHBhZ2UgcG9vbCBvciBYRFAgY2Fu
bm90IGJlIHVzZWQgYXQgYWxsIHdoZW4gYGBidWRnZXRgYCBpcyAwLg0KPiA+ID4gK3NrYiBUeCBw
cm9jZXNzaW5nIHNob3VsZCBoYXBwZW4gcmVnYXJkbGVzcyBvZiB0aGUgYGBidWRnZXRgYCwgYnV0
DQo+ID4gPiAraWYgdGhlIGFyZ3VtZW50IGlzIDAgZHJpdmVyIGNhbm5vdCBjYWxsIGFueSBYRFAg
KG9yIHBhZ2UgcG9vbCkgQVBJcy4NCj4gPiA+DQo+ID4gQ2FuIEkgYXNrIGEgc3R1cGlkIHF1ZXN0
aW9uIHdoeSB0eCBwcm9jZXNzaW5nIGNhbm5vdCBjYWxsIGFueSBYRFAgKG9yDQo+ID4gcGFnZSBw
b29sKSBBUElzIGlmIHRoZSAiYnVkZ2V0IiBpcyAwPw0KPiANCj4gQmVjYXVzZSBpbiB0aGF0IGNh
c2Ugd2UgbWF5IGJlIGluIGFuIGludGVycnVwdCBjb250ZXh0LCBhbmQgcGFnZSBwb29sDQo+IGFz
c3VtZXMgaXQncyBlaXRoZXIgaW4gcHJvY2VzcyBvciBzb2Z0aXJxIGNvbnRleHQuIFNlZSBjb21t
aXQNCj4gYWZiZWQzZjc0ODMwICgibmV0L21seDVlOiBkbyBhcyBsaXR0bGUgYXMgcG9zc2libGUg
aW4gbmFwaSBwb2xsIHdoZW4gYnVkZ2V0IGlzDQo+IDAiKSBmb3IgYW4gZXhhbXBsZSBzdGFjayB0
cmFjZS4NCkkgZ290IGl0LCB0aGFuayB5b3UhDQo=

