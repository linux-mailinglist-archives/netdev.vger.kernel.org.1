Return-Path: <netdev+bounces-55288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C080A1CE
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 12:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC081C20993
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2D19BB0;
	Fri,  8 Dec 2023 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="mNck8oHH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2113.outbound.protection.outlook.com [40.107.241.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6704E171C
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 03:06:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7ShLWxi42ZCb04L7BB9glAjKf5elUZdlTfWprPhDfWmam+ZhCJB4F8hlmKRf3HQRnt/kLdbGNXk672iD3ImWGUrdmYSwhWPZXxgNR/cQbj/roiB9t/9ZDGVtF+8gMLMHzCLURD+nOdvyfYuGc1281lg4AhgxI/AhGNIvswsiaqGSpPzGUOzH/kzyG5mhmR4qJd+ynMDpbnuAAC/aY2WqtoXMk4nDKcNG1U2tsod7WpmfeqSH/8LBBbPc8g3uvEEFt6mPO8AQ6VtZQ526eDCmM+WtZhb0cRKSINS7UfAobx4qm3GnXQsj06U8dNvrjBpRDqQMLrWrLXWUdKG8EnsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lmPJayUPhYG5YB2qCGCQqzdLx2C906iqgeFuAjOUEo=;
 b=UTWHV+qJvZKkL+yYIaIQrfWvS+KNQFT4NwhQlOL5+BPcbnH4Epv3C5UehWdw82eTQZ8eS3h5dnlSkwmoQbMJ1gtVuHpyy9c9OEtP7er6utFJ59Jl33SSKdTGXZsCYatEWNX63tS+YmZ14/au3GRshTk17eUFU8ooKwruDx4HrtLuohwBwllOgRhBkTwJBInJ2a5oybxDqkWQ4wTEXp0mwBvyIRHJFxVwzZGQG/XOKQyFzQ6UO0s1gFRWkQK3+I700FX4SHJmn6cAeNPqzJTjzvpBrrcKifbErgNix6HBy1FDD73srayN9lFTOlKpbPvCB6NiNTG6aRFRUO5e9Ekk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lmPJayUPhYG5YB2qCGCQqzdLx2C906iqgeFuAjOUEo=;
 b=mNck8oHHyNyeQnIRiArce3WSbKfskdu3ODiZtBeLbKm57sGBFM20UGlf1OACbqBEakzSE3q2pIUqiLd8PDX6FbRIbdC3t/TpoaX9jsAgQ2jKUXnLUk4rJH1aLNhem9sf8KMyCHtaC4z1H1wiYdHSabiBV1iMvI0YPZUBHXIKFLk=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by VI0PR03MB10281.eurprd03.prod.outlook.com (2603:10a6:800:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 11:06:48 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 11:06:48 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 7/7] net: dsa: realtek: always use the realtek
 user mdio driver
Thread-Topic: [PATCH net-next 7/7] net: dsa: realtek: always use the realtek
 user mdio driver
Thread-Index: AQHaKZJNPmNXeSeVGkKPXKMTsGzA3LCfOiEA
Date: Fri, 8 Dec 2023 11:06:48 +0000
Message-ID: <5hln5qd5p6mbg2hpmptkhlrjymgwzf3ioufwqbzmtrrfhkgecb@ew57gxpcjgwr>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-8-luizluca@gmail.com>
In-Reply-To: <20231208045054.27966-8-luizluca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|VI0PR03MB10281:EE_
x-ms-office365-filtering-correlation-id: 639f6a2e-2098-465f-9c49-08dbf7ddc629
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TNld519pOMZgu2+qZiKz3O9y8big+hR7uFGeVsKhnuIiFgO5y4vJpx2iB+kmpR9F5HOq4cw+Pl4sta6eMRmfM34zzNX842mzz1a+tlHC9MVeDoN+cSR5XLghivZueUlNLYzypyqnTzy9UA3a3MUoJM/6EhvSs3YVPoyOg6JTsnkEZX/aXu5RXaOjShmvH/2bL9naBNl3aDoZmLqZtVznmwI99VhmsJjA91vEK5CJJihuyFx9zGIlJWWyndTe1jXvtsSKbAcoZeWef7AHqpk+TNGK0eW6KmhUK48fLPF/4X8GDaXh3r0gBZwJ+kwV9RPZbBhiaOml/qEkzIHETg4FB7C/93mGvgP09NaXIHoXfnT8dXzvbaRziwI//CrBkwHZQHPN+b0uJnLmWHPU/JhV4O+U+OvH82Na+wQ16Q82Q1cSlGYui0VTz6ojhGtXuLZRX0gDMejIQuyiBvH/hERh0OuQOe4Iaudpz1z298Hb5eXtkvG25eVEa0J0iJnzOeOE4CkzcNex8L1gVJsJap5w4jcVvPuvEMEPdcFimxVhaRDJSqEpSdQKnm8DjH5jODeVPLXLS6gP7nkxvXCpJeEvQ4M3+LM9bL2X5Xq1nB58H/8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(396003)(366004)(39850400004)(186009)(451199024)(64100799003)(1800799012)(7416002)(4744005)(5660300002)(33716001)(8676002)(8936002)(4326008)(86362001)(38070700009)(85202003)(85182001)(41300700001)(2906002)(26005)(38100700002)(122000001)(66476007)(66556008)(64756008)(66946007)(66446008)(91956017)(76116006)(54906003)(6916009)(316002)(6506007)(71200400001)(6512007)(9686003)(966005)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZStyWitHd1ZwZnRzVHJtTEZhakMySTJFRHM2VHJ5Y3c1L3Y4S0VwZFEvUElC?=
 =?utf-8?B?OG1BVU9raVoveEFPU09rSnZ3K0ZibEMybWwwRDdNd0U4WThlN3F2dlNsdGtE?=
 =?utf-8?B?Nk5NQkRwckJWS09UZmprZ2JCNUdLMEszUkpqTGcwSHFtSEFIcVpSVTdQTzdE?=
 =?utf-8?B?L2Nsb2RQSlBjU3pYSlpsWVBScmVFTENFSHNsRnZYK3RMNmcyL2hGUnEranRZ?=
 =?utf-8?B?ZmFaTFh0ekxteDNiNXJXRm5oVTgva2UxY2E4RXNjM3R3NUhnMlpNaFEraFIv?=
 =?utf-8?B?MklGVEtRL1ZlMkFmT0lVZmtYWHhOYmlzT29tL01FNnRLb0hHMFV6RnRkZksw?=
 =?utf-8?B?YUxINGlLejlKZytFVFFKQSt1ZXVvcWlJb3J2N1puYk9wWVdndFBnUmxPQ3Fk?=
 =?utf-8?B?b2plTWh3MDJtR2h5M0I3WVV5OVhlbWpNUUc0Q3RXSzYraHhyNnB2VG54M3FR?=
 =?utf-8?B?RVh4MEdlb1lRbmF0Zy8zOEg4RTFQV05SSVFFNXBsSUZ1QXNpWkdiSFNnS0xz?=
 =?utf-8?B?RC9lOTd6Qkk5bXlON0F0V2tqR0RUbDlUZ0ZQNDBlWjRteVM0emFEUHh0ZDN3?=
 =?utf-8?B?M2w4Vkc4MlhsMHJoN0R5QThjZWFPbDhaM0lTUExzNzVDZG90OTRuMkVlbDlB?=
 =?utf-8?B?cFhmOXhqc2RBZUJaOEpCdFh1cHZqclkxNEtMTy91UzlyOVV0cGpMVUlodzl6?=
 =?utf-8?B?bG1YTW5KVHQxYlNiVWcxRk9RUmJmUDhjVnByU2xrTFFQcVVDZU5vZGxyazJU?=
 =?utf-8?B?cXFGTVAwVzFOdzZVaU1DMy90Y2szaGxLWTcxOGFDZHI1R29LV1Z5dy9XVG5G?=
 =?utf-8?B?WmtXTlFuazJ3RHB3QVVkRm1DdFBZTW50ZjhHazNmbkd0ZmNRLzBhTHdLVkhX?=
 =?utf-8?B?UFVXbi8zSFM4L0pKKzFzYkhuL0I3bUFtOWpFdFhmaTZqRmgvUUNoWmY0MnVX?=
 =?utf-8?B?cVlOTXZEUG1oQk5UUDlYMEdyOGFZMFY0OU1uUHNxa0NhQ1l1UUZZZ09pMzQ1?=
 =?utf-8?B?SHdnL25QTnJEcjg0ejRlOVNzUzJ0eWp1Vjc4NjgwWnoxUEY4aEJjMTdnRjdN?=
 =?utf-8?B?YnJWYnRQK0h2TmFGUlZuQ1pYdXFXNmIwZXArcVU3NkI0Nm1UWm16c2ZSRE9D?=
 =?utf-8?B?c1p6aTIwQmoyWEpxZU5jMVR5TVN3cXFPbVVCTUtLOUorZWRFUkNsZDNlTGxT?=
 =?utf-8?B?bHp0d21kczFUMW4xcHdwblliRjNCd2E1ZkpDUVNLdElVdWFFd2FzcVFIdjZY?=
 =?utf-8?B?TzFvVDFCRVJhQ1FiRTQwbW93Zk5GQUpCTkIvcFlvMlNldUpVRWsvTHdSb3py?=
 =?utf-8?B?Y1FHd2tLVUw0aHIwQis5N2hnQlBGL0dYeE9LRWJ3dEpBaUFBSGIvN0RRZnBZ?=
 =?utf-8?B?aFhxZU1QK1JTV0cycHJ3ek4ranNPQUZEaGh4VjE4S0prWEJPRnZvZ0ZKdmtj?=
 =?utf-8?B?OUV6aWo0Tk94ZXBpWXFXdVVyeE5vR2JwR0lQdCtFcVVCSkFkanAram5NQjlO?=
 =?utf-8?B?OTBUb3paT0lzTDN5Q3lWV3hIKzU5TzZmRlllWFhPaEQ5dlBLcEhJbm9xdEY0?=
 =?utf-8?B?SEdRblZCNFpEWThpNUEvbE5qQmp0cEpOd0VHWDAyWlpGZzdzbWJnMDFlK016?=
 =?utf-8?B?M1FIZmNTSHhMUnBRZnIrK2FBbnlzd3cyY1NxcFpob3d3TUdySGxxTkNKZ1Nu?=
 =?utf-8?B?bWZpTlRkVEQ3UEpueXBHeWxHWStUbVJodUs0dHFlOWl4b2orK1BCNFJIanA3?=
 =?utf-8?B?dWQzV3NPRTQzdmJ5bEJZV01udGV0ZlNuMlVLQmkycWthWlpleElqdmE3NXFp?=
 =?utf-8?B?cTEyYWdqQ2VFem82dHp6cFh4SU5pVkJtS081WUZNNUpjZEd1T0hpN2E4c2hv?=
 =?utf-8?B?WWJ0Sll1c0dvNmVHRWtPMnpFUy9LY0JweHhvZlFiTVB1RUpwM2wxdG8zTkZH?=
 =?utf-8?B?T0w0eXFJVHlJejFIbWJxWjdhSlVoYW1EMUt0djdSaU8rcGxseWR6RG93cXNG?=
 =?utf-8?B?ajZLUHZHMkE1VDVId3hVcVdIa0NxTy9mRFlyMGhOYldSZ1ZFU1BnejdNekZz?=
 =?utf-8?B?d0owbDhWTW1wWFdyMFEwOGhXNVpESnRaMzg3aDlIVGR2dmczWk50eTBzcXBT?=
 =?utf-8?B?dG1yVk1aenJjVFpEZGdVZmlseWNlTDZTZ2xQM1EzMyt6K1Nma3JrRXVTaklF?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <778535EC03D83F4DBF527131FEFB49A8@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 639f6a2e-2098-465f-9c49-08dbf7ddc629
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 11:06:48.7186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ramw8L1ak+FgbXHzG6VJ7jkvIzQDGWEXHCxwUCtexdttlcluOKIqvj6bUT9n6YTx5XKPCxSL0tN/+2FTn3NywA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10281

T24gRnJpLCBEZWMgMDgsIDIwMjMgYXQgMDE6NDE6NDNBTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gQWx0aG91Z2ggdGhlIERTQSBzd2l0Y2ggd2lsbCByZWdpc3Rl
ciBhIGdlbmVyaWMgbWRpbyBkcml2ZXIgd2hlbg0KPiBkc19vcHMucGh5X3tyZWFkLHdyaXRlfSBl
eGlzdHMgKCJkc2EgdXNlciBzbWkiKSwgaXQgd2FzIHBvaW50ZWQgb3V0IHRoYXQNCj4gaXQgd2Fz
IG5vdCBhIGNvcmUgZmVhdHVyZSB0byBkZXBlbmQgb24gWzFdLiBUaGF0IHdheSwgdGhlIHJlYWx0
ZWsgdXNlcg0KPiBtZGlvIGRyaXZlciB3aWxsIGJlIHVzZWQgYnkgYm90aCBpbnRlcmZhY2VzLg0K
PiANCj4gWzFdIGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL25ldGRldi8yMDIyMDYzMDIwMDQyMy50
aWVwcmR1NWZwYWJmbGo3QGJhbmctb2x1ZnNlbi5kay9ULw0KPiANCj4gVGhlIGRzX29wcyBmaWVs
ZCBpbiByZWFsdGVrX3ByaXYgd2FzIGFsc28gZHJvcHBlZCBhcyBub3cgd2UgY2FuIGRpcmVjdGx5
DQo+IHJlZmVyZW5jZSB0aGUgdmFyaWFudC0+ZHNfb3BzLg0KDQpBaCBPSywgdGhpcyBtYWtlcyBt
b3JlIHNlbnNlLiBDYW4geW91IGZvbGQgdGhpcyBpbnRvIHRoZSBwcmV2aW91cyBwYXRjaD8NClRo
ZW4gaXQgbWlnaHQgbG9vayBtb3JlIHJlYXNvbmFibGUu

