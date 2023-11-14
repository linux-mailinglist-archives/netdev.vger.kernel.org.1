Return-Path: <netdev+bounces-47695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA297EAFC7
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0AA1C208C1
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4ED3FB03;
	Tue, 14 Nov 2023 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="KjClgyIr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016B3E49A;
	Tue, 14 Nov 2023 12:23:23 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2106.outbound.protection.outlook.com [40.107.241.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF62134;
	Tue, 14 Nov 2023 04:23:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3sKzLWkDw2JeUkt9oEQE5BtK5cmrBEmaeWgkV28wGx3Pezmv9SwPvIkOKXSX38X9u2e1DibKpH47wBqqlNQOWjehC3i9MKj9KMNYywJZbdXJvkY0LOhLFO8Y862bWbZP/VZWq9iENWrkLmJRNqdaXhPokwBt+r4EEk28ft3VvoEKqINpJEA2fOMTlA7cnQzetGnlrXr031nlanAKBPZz7B7zPJpRu6GCMht+7eb+oz1fVog1NgLKd+tR+aGxlABOXndEHPZixGVoqAOdAwQRNMHhfFTTqV3Xt8tCyKnsicyoo8IFy0wyjUeV6EXe/nTs901/BjBzgWa/ju9BOsNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqADKVve+oajnenDPYw4Y7jU06cmglaHUHifpBKWujA=;
 b=d9xgG9riUS0YqmEQbgZ0IeLJCb5sV2zP9+2OLdxQvt1qw7v8bQeEG2KdMdl3JzYcybEIyqaiqx6ZPT5nx/+dcYSUO4awn1KMP19gy/ppBvFImszqbuVMa73DFY8aiy5ir9Zo2R9MhfR2etqMy/+rVuF1J9B6VXo3ktATfZvwOh8Yr0EkcXcae8eGcLQT/Rv/DbMWPCXLX730pSfi7/kElhRNMgid4vXhUFnb0sa6gON0yAgX3JLbf7Mk3s/fG0YLNLq0U8ckf3IgVtjHAbHZdU+FEDhwpvfvvdVAju+4wMeBiBe6croqyH/Tf1m3yOboTqcfCYru0IMchpt5YAd16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqADKVve+oajnenDPYw4Y7jU06cmglaHUHifpBKWujA=;
 b=KjClgyIrrf6JyeIHC5nkv7bByTlcIVRcdZmBsXgKx64UYTbJD4l0SCoL70Cn+3GcrYZXu9CEOFnCpcR0dHzjOnFlbm00vvBYGBU4e5ynKeoXBXc1pGGeeJXHdoByxKF4ch7aGP1rGuH5BLQzhTV7Po+lYLE5MnQDKv9UwLGsujs=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DB8PR03MB6170.eurprd03.prod.outlook.com (2603:10a6:10:141::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Tue, 14 Nov
 2023 12:23:20 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:23:19 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC net-next 2/5] dt-bindings: net: dsa: realtek: add reset
 controller
Thread-Topic: [RFC net-next 2/5] dt-bindings: net: dsa: realtek: add reset
 controller
Thread-Index: AQHaFOoLZ2R4ynnTr0ajNhwIMVhOt7B5wOSA
Date: Tue, 14 Nov 2023 12:23:19 +0000
Message-ID: <jnqgo5cadf4aa33hhdld4jxhmlsecxpbi6u3iopf7wghurore2@56dpxdd4hatv>
References: <20231111215647.4966-1-luizluca@gmail.com>
 <20231111215647.4966-3-luizluca@gmail.com>
In-Reply-To: <20231111215647.4966-3-luizluca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DB8PR03MB6170:EE_
x-ms-office365-filtering-correlation-id: 6b045a4c-9028-438e-e3a2-08dbe50c7cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gwzaB0BH7i0DgtRLhqi6paivZGydBatHfFtLtXnupWqyZwPSSYv/9mPr7XPxHFxJx/bY0agYN7USLeNWCf/a9DPl0CNpE1ZK2b1A93rzOVIqKxpoFpirbN3hFxIYPwffNub+dAQtT+XXgAIXLvujMrBcNXfLElhVDsawaiuAqqYNC75MkEF1MC6429k5eCPinI3Up+MH1iEKlKmHbmz9mcUZ3YqZVNAaPvLRMhPrOqb6gnVUkanJGhE5CTuCvOCBMFGEzUimI5wJLri11TzFF/6nb3A5jNTCfYPMtblAAKG261M0iVThtC+k0ipMuxL7ZDNsVXmTBOhhN7XhI6pakkY8R8abdPw5bWaUoYa+nQ3HG/A03MC0iSy0xIrEViTtdQkIrr+OgLEKlnMvgQmmI3nN53ofond0bMBNwhT6h+/BFrT/WFtemvl1jKrJEmbWCgpr5H0bnRMrcctCpC9BeX5yT1Wp9en/hH0TQkxM28cvyO02O6TlYtDfLuYBIDVPCsyHaQeo9npjUVkqTsyjsV7LPiAk5/flVfDKJyVmRCCvTHWDGexmvx/cYgCm9A4HKVELb5Vo3vOPdqJcAl43BMMdRmIdiKYduhzCfjN0eyy08jWZR5XwxLP61JC8kp3d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(54906003)(66556008)(66946007)(64756008)(66446008)(6916009)(66476007)(91956017)(76116006)(38100700002)(316002)(85202003)(38070700009)(86362001)(122000001)(85182001)(26005)(9686003)(6512007)(33716001)(6506007)(2906002)(6486002)(8676002)(4744005)(478600001)(5660300002)(7416002)(4326008)(8936002)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFAzTm1ZY1BnaGtvUjNvcE5XZ2ZibEYvNG9FRzU4THA1YjRZV2k0T2gyckcv?=
 =?utf-8?B?eENWa0ZYMVFiRi9vblovbWZaTnhpa0F1RVJ1c3drZjdPY2VvNGMydmN1VTNL?=
 =?utf-8?B?ZE1mT1luZDdrL2NVMFRRSDdGaDRUVWZ0Z2c2Y2wvbU1scUFHWHE0VjlOdm1u?=
 =?utf-8?B?NDU3cmk3ZmpvOGRFeXo1ZlN3cnNSczZ3VmZlcGhRQ0dxSXRuM0pSWk54SnFH?=
 =?utf-8?B?amxhaHZ5U0JIaVYvNXlRbmpwN1NFbTYvWFVGNUZ6bTh1TEFNNHlXeVUzM3NZ?=
 =?utf-8?B?TmMyS3JnM1VLN3dIaTFMaTMwamg0d2FGUTBzdXVnS1ZrRnV5ZjI1MVFoNm53?=
 =?utf-8?B?QktzaExZU1g0S25jSXkwSlowOHl3aE1zUFcwelBCYzFQU1BJTDU3U1FXNlVy?=
 =?utf-8?B?aVhUREtHb3BkTFQ4dUFpOWpwZCtuK0ZhWGtCeXVWOTdkc3VudjdXMnU5dGd1?=
 =?utf-8?B?M0xTY1NjczFody94V2ZwQmxRRFF4cFROUXpyQVg1OVFRS1ErUUVvNEpCcnBk?=
 =?utf-8?B?QlRwWEJtd2gzdnlaVEVvNHpCajJ2NW1WdkpJUGpmVEZuQnI2d3F2T2hZNnRl?=
 =?utf-8?B?VzlzTFkyN2dZaU52bGw1cFUvZWJJYjlqVDA2VVdqT05KaTZpdXhoV3k3dnVX?=
 =?utf-8?B?MU5tWDQyazl3OGVJUXFlTTl1ajMwcDlzOGQveHpObjZSVVlVaG1Yb0lSTkZp?=
 =?utf-8?B?VUIxTGRCU05CVzFDUjdNa0djMG1Xcmh0UTkyS0NJbUpnWGlZZEVRQXI1QlFt?=
 =?utf-8?B?a09YWjE0ZmdyNjBreUwrK2hSdHpmR09NQzl3S2I4RUpkazFnK3FDcHpYNW9N?=
 =?utf-8?B?QTFNZENtM3VtWEhuOHU4UG1UNCsveFdNNEpGWTg0akNGNU00Y0JaeFBRWGI4?=
 =?utf-8?B?VGdCMytvcC9rVDdNZGtoWjZBZnUzVkZVNC9uc0xtMUxSSXBXUU91bW1lOUND?=
 =?utf-8?B?NnBza0hCTEFycDJMVFdHc1JpWlFZc29nRmtQYzNDUVg2MTBtRlIyc3ZobWQx?=
 =?utf-8?B?cTVzMGgzV2xQekk2NTZnb0xER1BzYXJBcnlkWlZlaldzZ0ZQbHpJclNmb2M4?=
 =?utf-8?B?aW9QbFJwN25OUTdIVUtsTHVzSGpIQ0VCMU04S1J0Ujcxay85SFlCUU56U3A2?=
 =?utf-8?B?azhHd0kwMk1lUzY0Q1krNFRjNENBNkNmNlArYTd2VkpjeVNydGQvL3M5TVZL?=
 =?utf-8?B?eGxaYkVCanJNb21RWWhXUzVuQW5MR2Y4eUVLU2xQZ0tMY3hzcXYySmEwKzdh?=
 =?utf-8?B?RHo1dDAwVWFKS3dxVnlCc1poU1pqd1BRWVhhMEhSNG5jMXhwUDArU01Xa1JP?=
 =?utf-8?B?cy9DM21QTnNmdGxuMzgza2FPR3lBU1J1Rk9GVmNiMkZ4ck1XdlBLK0trcjk2?=
 =?utf-8?B?c2hRdkx5bllwNUJPZFN2RkFveTFpVWVCZk53aXRaaGZ3dG1oaWhkWTlWT2lj?=
 =?utf-8?B?S0NCYm9GZ210dGJxaENaeENSMFR0UVJwdnN6NkJhR05Gb25NNzRSUUlBRHVh?=
 =?utf-8?B?NXhPSGZnT01vdWpUNERqMXd0OThuMFYxTGlWb2xaVzl4ZnFsT3pYdXNwVm9q?=
 =?utf-8?B?dXJBc0NtbFk5M1d0L3hmNlFJd3k2U2NZV0FJUnNvZ1FXTXE0S2VlWk1lOFRt?=
 =?utf-8?B?Uk1oNk4va2V6TDFFcUxVS0MwWVhhOXNBNWpvYUdlbjJEMmFLYzZna3c3TW8y?=
 =?utf-8?B?QTJyU2xrSnlaeDEzUlpPdFEvb1ZxU0xoYmt6b01NeXE1cmhRV3JleTZxb3Ex?=
 =?utf-8?B?bmZTSitMcWxBN1JvYzNGbWVDK2FxMjVWNnNXaE8xZHh4VVZZKzRYZE4yaW1z?=
 =?utf-8?B?MEhOOVIvSGxic0Y4b3pHN2VzY1ZBOG9LT2xtNy9GN2hpNi8wZmlTckVXU2NI?=
 =?utf-8?B?RmFDWXdZWkFUUEI5QXNMdzhJSjc4Z0U5cGdRaWI3b2FqTlFTNzJQTkJPSTJK?=
 =?utf-8?B?alBVanJGcjJPenlQWXRwWnZVZDJPdGxMdnJFUmtVOTAyMUxiN2NweTU0ZlFW?=
 =?utf-8?B?SnZIbFVNZFZRd05hT3V5cmJqOFFScTZ6RG1sSGdtZHRMRmExWEE4K3Q5ZU9G?=
 =?utf-8?B?WGdNSW9Rb1BZa2pYemVWd09wKzFVdXRCUTlLdEZXKzhHOCt1ZFR1SlhZZk5B?=
 =?utf-8?B?UTcyT0hsRzlFcFRLQnA1Q01wcVNicjc2QnhJYzZ3bGcybHBzTHBHdHZzbHp5?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5830343DE399645B147FC431309CC13@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b045a4c-9028-438e-e3a2-08dbe50c7cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 12:23:19.9101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faULkog0ADTWbkIu8QjwCjZNB4uPXzi4ryrlEFfJeIVyHIoF5GJfP19bByqf+UxmDDM6ShOUDQsTpt+11sjw2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6170

T24gU2F0LCBOb3YgMTEsIDIwMjMgYXQgMDY6NTE6MDVQTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gUmVhbHRlayBzd2l0Y2hlcyBjYW4gdXNlIGEgcmVzZXQgY29u
dHJvbGxlciBpbnN0ZWFkIG9mIHJlc2V0LWdwaW9zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHVp
eiBBbmdlbG8gRGFyb3MgZGUgTHVjYSA8bHVpemx1Y2FAZ21haWwuY29tPg0KPiBDYzogZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQWNrZWQtYnk6IEFyxLFuw6cgw5xOQUwgPGFyaW5jLnVu
YWxAYXJpbmM5LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmct
b2x1ZnNlbi5kaz4NCg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvZHNhL3JlYWx0ZWsueWFtbCB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL25ldC9kc2EvcmVhbHRlay55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL25ldC9kc2EvcmVhbHRlay55YW1sDQo+IGluZGV4IDQ2ZTExM2RmNzdjOC4uNzBiNmJk
YTNjZjk4IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L2RzYS9yZWFsdGVrLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL25ldC9kc2EvcmVhbHRlay55YW1sDQo+IEBAIC01OSw2ICs1OSw5IEBAIHByb3BlcnRp
ZXM6DQo+ICAgICAgZGVzY3JpcHRpb246IEdQSU8gdG8gYmUgdXNlZCB0byByZXNldCB0aGUgd2hv
bGUgZGV2aWNlDQo+ICAgICAgbWF4SXRlbXM6IDENCj4gIA0KPiArICByZXNldHM6DQo+ICsgICAg
bWF4SXRlbXM6IDENCj4gKw0KPiAgICByZWFsdGVrLGRpc2FibGUtbGVkczoNCj4gICAgICB0eXBl
OiBib29sZWFuDQo+ICAgICAgZGVzY3JpcHRpb246IHwNCj4gLS0gDQo+IDIuNDIuMQ0KPg==

