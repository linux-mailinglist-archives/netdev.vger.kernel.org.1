Return-Path: <netdev+bounces-55633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B280BB16
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 14:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643DD1C2085C
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECAEC2D9;
	Sun, 10 Dec 2023 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="pKIgKxSH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2097.outbound.protection.outlook.com [40.107.104.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34FDD9
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 05:37:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTU1UkSM9QPqDhxhRca44bpBxx2Ncjgf0B8zA2OfrFLaL8qf8Hax/EB52cOJWGyLrDNjsvj7IaTqFsy+NB97Qb5YyZHK4PrHwqQcPfVW6FvtoTUSkr3X2VjXFN40DC+bZgwDLhV7fzGe9EFeOmf5ryCxuCQKFehAlDTOaw2geFOledcX8jwcyd/jBbfAis90+4HBM4CiGm9AyOJL9iB/8jN6pPoobFf7PKJKPz4EocuqJL5L1sff8ZDT0mRnNKY3Oy0fR+flcSDREj/ssiy3n2UcwllhAW7eN6J1j9f90EIG6QAG0MsvClvgTiSloqaZhfJejcvXfK1Nay/EvFODCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCNeb6/G6RhsctM2p9Un4CbYWX6MtC//QbJuRpwWcWc=;
 b=GYfenswgAhMHESCFUiSquavzw9aa90P3ytnkMM3SUh8u6VrOjqmVlp4qDCxIgbItMe2SfmKt1c4l46YpJmaYjMNzW3eyuSVdF9TzLyHI0NHMqaF3n7pR3DkiV5ijertSJMrf/ftuO1rcScmpaQomJI1ZYPhdZon5sqcHerwNSfO/z0dmDdElGVkITBaFRpKo9Ds+WSBNVX2FhYySD6SO8HJamhvNgG/U059kFMnAIDNJFV0/ov4UYO5+lbirmgVIRcKPq5mY2RdKdfsdtQhJNhwdqMrhf9MzZk3jEYlHPdxhsH2ENuFILzVUZecEhmYSvzEOQn4BNmwqPa3knrB6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCNeb6/G6RhsctM2p9Un4CbYWX6MtC//QbJuRpwWcWc=;
 b=pKIgKxSH+GM+vI2L2ivw6yTEi/eNQFiICqouuEKZ/GvCMZsbZsz0mSN8eYUyIzaw0XP67j7Y+IOXavRgIG7Er6Xt8PjJDogpgqp/AqelNZZNdg0948FeHA4027VZKmY2gK68pXeT713ECLdVwyHgznIvdb5bftHU92st0GzEVLY=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DU5PR03MB10261.eurprd03.prod.outlook.com (2603:10a6:10:518::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 13:37:01 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 13:37:01 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Luiz Angelo Daros
 de Luca <luizluca@gmail.com>, Madhuri Sripada
	<madhuri.sripada@microchip.com>, Marcin Wojtas <mw@semihalf.com>, Linus
 Walleij <linus.walleij@linaro.org>, Tobias Waldekranz
	<tobias@waldekranz.com>, Arun Ramadoss <arun.ramadoss@microchip.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Jonathan Corbet
	<corbet@lwn.net>
Subject: Re: [PATCH net 1/4] docs: net: dsa: document the tagger-owned storage
 mechanism
Thread-Topic: [PATCH net 1/4] docs: net: dsa: document the tagger-owned
 storage mechanism
Thread-Index: AQHaKg3nh2Edwwe6t0uvQ+PjxIlthbCih8sA
Date: Sun, 10 Dec 2023 13:37:01 +0000
Message-ID: <v6mbksil7hcgct27k27qt6t6o7noibdzexvv7f65mjhgwgtw6s@rxaur53hu5i4>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-2-vladimir.oltean@nxp.com>
In-Reply-To: <20231208193518.2018114-2-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DU5PR03MB10261:EE_
x-ms-office365-filtering-correlation-id: c4d3671c-0223-49c2-1837-08dbf98516d4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yQtxq9GedhM3J8SKOJdTjOHrKyP/Qe2BniOLReySD+bnSNyYfQatw+mXOy2Ql3OXuObvmIwdthx7m20FGXKA8G1FbwoeFCgE29T5PaGF7/6S6bt6dRvOQNsHDcNIpskPkdbpsJ88ShzzHIJgAWj/PHzL4uf++kgnr0GtTsIhWckUYAOmNhrgC2VFs5HO0cgZle2LzSrkbEmVkUmHen3MXGJy1LRlPSRoCLpZl6jN14B9ksWsYhs2vxvf2hQ5/ShS1QM0V6jnkaLPNiekeosklJcJui5/Z7UqIh/T+ib3AO5PFhkO0vA+H4jCBSEM0EGOAfVujesuuiK8eMcha0HYtgJAJnFGz03EWAL9ILhdLmFJyUkz56xij5es+Zy1PRPDtFoytAMMD3/A/E8a2kMU3FzwQ6B09BoozQxy6L3Ga1H7EcLUzCnYEqXcBqKaAZT6khpoYJyAmaTc0o44oN8dYCo5Qf4b1rLxtey0MQZkhqkNcWeg2sL+jkQg1RVews2s5maisc/55N0Mx/Fa/UMJESHQ6bsqEc8y28MdZ6ft7pZ0RX+kAxcGwgaNj/1AR41mvP9zMSLmyykyPNz8yDE3Zx2OqMKvBYlvvkM8CHhJyyQfFeEb2VKaBHHqIkpn/AV9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(39840400004)(396003)(366004)(186009)(64100799003)(1800799012)(451199024)(26005)(66574015)(6506007)(71200400001)(6512007)(9686003)(83380400001)(5660300002)(7416002)(33716001)(41300700001)(2906002)(4326008)(478600001)(6486002)(8676002)(8936002)(76116006)(66946007)(91956017)(66556008)(316002)(6916009)(54906003)(64756008)(66446008)(66476007)(86362001)(38100700002)(122000001)(85202003)(38070700009)(85182001)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW9ua3ZsVFVSS2JnTnRqYmVybXFnS3cwVVo3b3lIaUg0RGZxMUM2VkN0ajJ0?=
 =?utf-8?B?c2Z2b1FhTUF0eHU2Q0xQWTVGcUNXN09hN0g1YnNWT1c1MGlFVkl0eWdlMVRJ?=
 =?utf-8?B?QWx0NnhOTkZQR1R0bzZod1M4NEZOTzZ4TmtRMWk3SzdRMGlOakJNYnprcDly?=
 =?utf-8?B?ZGRlWk94SDhqYzhQQ2lhbmNCVEFMS1JOUUJZYncvK3JaZjJUa1IyUXg0MjlB?=
 =?utf-8?B?L1lrUXV5WXN6VURKbFRReUkzNWtLOXVVNXBSRFdDNGVXRUt0M2R1UkJXeFJO?=
 =?utf-8?B?MjBOdnZzcVJpNHBCQzlGK1NpdmtCSHIzOTRmb2JBVjBtR1lrUmtiNHAwajZs?=
 =?utf-8?B?TFdtSmRLUGZnSW5YZnA3ajdYUE5WV2FUdXJLT2pNWHJ0ZlpxZkZwNHovVVNq?=
 =?utf-8?B?Qjc5b0lOdkhIQ2FBY1ViazN6YktFUXZ3ZkFiSjNySmJHMU5qL3lPTXk1NkRx?=
 =?utf-8?B?SlR0YURTVXJKZkZYMGdyMjhPalZkTXFTaGE3dWFSbC91S1FWWEIwN1ViWllt?=
 =?utf-8?B?Y1VndG44RGJGK0gxQWdWRjh5S2p1VnBMYzhpZmpSdXdiV3dYemxuYml2eXdX?=
 =?utf-8?B?RzVqbUFkRG5rei9PQkUvNVhkL3JrYlllbkZhT1Q3bWVpK3BuL2EwM2hmZWZj?=
 =?utf-8?B?R2JRc0IwMS92WmJKUVF3ZlFITjVQWWlXdnRJYzFkNlorRGIyK1RUYnIxaGlN?=
 =?utf-8?B?Y3RmR1l3M3JwbWZKdllBcDVxeVM1ZFBqU2dhRit1Z3hxNW8wdnUwSVhoVWxj?=
 =?utf-8?B?c0xhSVRNOCtXbWU1M002QkxMeTRzYTBKeFVreXk0YkpIMjNpNGExcUVKeWta?=
 =?utf-8?B?dHh1c2FrM0RvQU1NU05rQVZESzBISVR4TUUyOFRYanVxN2tLRE9YeW9oTFdC?=
 =?utf-8?B?TE5xWHNHYXZibU9ad0N4ZzhDU0o0SExhdWxZNTExandWQXFrYzU5dGE4Und3?=
 =?utf-8?B?OUFBSUZ1MG95MXdyZEdLTTlWS3R1TEgvemllcE4vNHR2R0xFL1ZNZVpITkV1?=
 =?utf-8?B?Ulhyc1VaUmdUcWVSRmg1Y2RXMWhwMHVvU0RVSWtYOU94WnpHekJwMkZrZEl0?=
 =?utf-8?B?cm1lZnRNd0JRZXNhWmJkbXBQamJzbWQyWVdMQ3p2VWhuS1orTU9LMVlBOExj?=
 =?utf-8?B?SVordnBkendweTRCekNxOHVKa1hpdEJ6Y3JMQjdZc0NTMFFIOGZGTkl2clQ3?=
 =?utf-8?B?VDNNaHBqVmNTYzcreHVGbVI5d2V3MjJWNDRQTmQydlZuelJ3TE9rcE9UeTlE?=
 =?utf-8?B?SG94VWtiejllQ0dMQy9zcGt5cWJMNjBqUks0UnlHTDM5eGRhRzVTMjk4azZj?=
 =?utf-8?B?SGVSSnNCb2NmcjFaa1ZaVVVQZFcxRkZXQUFnZTRxV1JvNERLUDZpL2NUSmp6?=
 =?utf-8?B?QlU0ekQyOXdva0M3OFduaTdjMFZrbnpmT3gwM05aOUlaeTRWZlJISVNScFRs?=
 =?utf-8?B?REUyMkIvdTdOWXRPOElPVFVnaGVRWE9zY3E4RG5OWFA3UEhzZ2MyNVZtWWJl?=
 =?utf-8?B?djEwRWdIa3B2cnRXckw2d2dobzFEWTlMVk8zLzdrUHdnV3kxUU1jU1hTK3pN?=
 =?utf-8?B?YXFUMFFLNmJVeTBvbzhqQUFqV29pZGEvK3A4eURQM0l3UnppRWFoWHRNSkRa?=
 =?utf-8?B?aFUvZElRbzdrK2FPcFNEcnVRRXdBcHdvQkVNeU8zMzdxVDBPdWJHWnBOT0JZ?=
 =?utf-8?B?NE9VYVBMeWtMVWJoeTRoM1ZtRXpuSVJyL29wN2dGRGgwTTlSaTRxWVJ3am1l?=
 =?utf-8?B?aks1NmdHb1lLWE1kT0lySDNXN2dIemdCNWVVdWVnU0U3akttNXZUU1BML29M?=
 =?utf-8?B?dnBETW9JVEdWRW1YK3hCWkJLZjRJS2dXdi9oRWtUT3dvelRoSEI5eUovZEdS?=
 =?utf-8?B?bCthTTd4L25zT1NmL3RhckxGZlY3WUNUOXg2Ymd2Y2s3Qmo4VlQrdjBvbG94?=
 =?utf-8?B?MkZtVy9weVpKTXdqZlZKeXRLOVZjM09XQ3BTRnhVbG1BRXhWT3lKekFsWVps?=
 =?utf-8?B?YjNXMGR6QlFraWFHcXNBMDIva2JVVHdsTnJ2bVRvQk4yVVl3SU9XUVFsVlFx?=
 =?utf-8?B?QkN3YUhzOWJDZ25IT2ZWNzhHemdQNUxmcitNWlQrRHBGc0x2WUNNVFdPeGxy?=
 =?utf-8?Q?YQzOX/O75SgZgnzV1lMogONjl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E43C402C80630F4A9B33A96F73BD1861@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d3671c-0223-49c2-1837-08dbf98516d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2023 13:37:01.1857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCOjhAtLIqpfC77ZNv1jnBDEyjKj7pbT6dPYCwjYLW0qm1yvksgc76IqGxWbqPQKCtqmrhzzVYGx15g/ITKBiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10261

T24gRnJpLCBEZWMgMDgsIDIwMjMgYXQgMDk6MzU6MTVQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBJbnRyb2R1Y2VkIDIgeWVhcnMgYWdvIGluIGNvbW1pdCBkYzQ1MmE0NzFkYmEg
KCJuZXQ6IGRzYTogaW50cm9kdWNlDQo+IHRhZ2dlci1vd25lZCBzdG9yYWdlIGZvciBwcml2YXRl
IGFuZCBzaGFyZWQgZGF0YSIpLCB0aGUgdGFnZ2VyLW93bmVkDQo+IHN0b3JhZ2UgbWVjaGFuaXNt
IGhhcyByZWNlbnRseSBzcGFya2VkIHNvbWUgZGlzY3Vzc2lvbnMgd2hpY2ggZGVub3RlIGENCj4g
Z2VuZXJhbCBsYWNrIG9mIGRldmVsb3BlciB1bmRlcnN0YW5kaW5nIC8gYXdhcmVuZXNzIG9mIGl0
LiBUaGVyZSB3YXMNCj4gYWxzbyBhIGJ1ZyBpbiB0aGUga3N6IHN3aXRjaCBkcml2ZXIgd2hpY2gg
aW5kaWNhdGVzIHRoZSBzYW1lIHRoaW5nLg0KPiANCj4gQWRtaXR0ZWRseSwgaXQgaXMgYWxzbyBu
b3Qgb2J2aW91cyB0byBzZWUgdGhlIGRlc2lnbiBjb25zdHJhaW50cyB0aGF0DQo+IGxlZCB0byB0
aGUgY3JlYXRpb24gb2Ygc3VjaCBhIGNvbXBsaWNhdGVkIG1lY2hhbmlzbS4NCj4gDQo+IEhlcmUg
YXJlIHNvbWUgcGFyYWdyYXBocyB0aGF0IGV4cGxhaW4gd2hhdCBpdCdzIGFib3V0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5kaz4NCg0K
PiAtLS0NCj4gIERvY3VtZW50YXRpb24vbmV0d29ya2luZy9kc2EvZHNhLnJzdCB8IDU5ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1OSBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RzYS9kc2Eu
cnN0IGIvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RzYS9kc2EucnN0DQo+IGluZGV4IDdiMmU2
OWNkN2VmMC4uMGMzMjZhNDJlYjgxIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL25ldHdv
cmtpbmcvZHNhL2RzYS5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RzYS9k
c2EucnN0DQo+IEBAIC0yMjEsNiArMjIxLDQ0IEBAIHJlY2VpdmUgYWxsIGZyYW1lcyByZWdhcmRs
ZXNzIG9mIHRoZSB2YWx1ZSBvZiB0aGUgTUFDIERBLiBUaGlzIGNhbiBiZSBkb25lIGJ5DQo+ICBz
ZXR0aW5nIHRoZSBgYHByb21pc2Nfb25fY29uZHVpdGBgIHByb3BlcnR5IG9mIHRoZSBgYHN0cnVj
dCBkc2FfZGV2aWNlX29wc2BgLg0KPiAgTm90ZSB0aGF0IHRoaXMgYXNzdW1lcyBhIERTQS11bmF3
YXJlIGNvbmR1aXQgZHJpdmVyLCB3aGljaCBpcyB0aGUgbm9ybS4NCj4gIA0KPiArU2VwYXJhdGlv
biBiZXR3ZWVuIHRhZ2dpbmcgcHJvdG9jb2wgYW5kIHN3aXRjaCBkcml2ZXJzDQo+ICstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKw0KPiAr
U29tZXRpbWVzIGl0IGlzIGRlc2lyYWJsZSB0byB0ZXN0IHRoZSBiZWhhdmlvciBvZiBhIGdpdmVu
IGNvbmR1aXQgaW50ZXJmYWNlDQo+ICt3aXRoIGEgZ2l2ZW4gc3dpdGNoIHByb3RvY29sLCB0byBz
ZWUgaG93IGl0IHJlc3BvbmRzIHRvIGNoZWNrc3VtIG9mZmxvYWRpbmcsDQo+ICtwYWRkaW5nIHdp
dGggdGFpbCB0YWdzLCBpbmNyZWFzZWQgTVRVLCBob3cgdGhlIGhhcmR3YXJlIHBhcnNlciBzZWVz
IERTQS10YWdnZWQNCj4gK2ZyYW1lcywgZXRjLg0KPiArDQo+ICtUbyBhY2hpZXZlIHRoYXQsIGFu
eSB0YWdnaW5nIHByb3RvY29sIGRyaXZlciBtYXkgYmUgdXNlZCB3aXRoIGBgZHNhX2xvb3BgYA0K
PiArKHRoaXMgcmVxdWlyZXMgbW9kaWZ5aW5nIHRoZSBgYGRzYV9sb29wX2dldF9wcm90b2NvbCgp
YGAgZnVuY3Rpb24NCj4gK2ltcGxlbWVudGF0aW9uKS4gVGhlcmVmb3JlLCB0YWdnaW5nIHByb3Rv
Y29sIGRyaXZlcnMgbXVzdCBub3QgYXNzdW1lIHRoYXQgdGhleQ0KPiArYXJlIHVzZWQgb25seSBp
biBjb25qdW5jdGlvbiB3aXRoIGEgcGFydGljdWxhciBzd2l0Y2ggZHJpdmVyLiBDb25jcmV0ZWx5
LCB0aGUNCj4gK3RhZ2dpbmcgcHJvdG9jb2wgZHJpdmVyIHNob3VsZCBtYWtlIG5vIGFzc3VtcHRp
b25zIGFib3V0IHRoZSB0eXBlIG9mDQo+ICtgYGRzLT5wcml2YGAsIGFuZCBpdHMgY29yZSBmdW5j
dGlvbmFsaXR5IHNob3VsZCBvbmx5IHJlbHkgb24gdGhlIGRhdGENCj4gK3N0cnVjdHVyZXMgb2Zm
ZXJlZCBieSB0aGUgRFNBIGNvcmUgZm9yIGFsbCBzd2l0Y2hlcyAoYGBzdHJ1Y3QgZHNhX3N3aXRj
aGBgLA0KPiArYGBzdHJ1Y3QgZHNhX3BvcnRgYCBldGMpLg0KPiArDQo+ICtBZGRpdGlvbmFsbHks
IHRhZ2dpbmcgcHJvdG9jb2wgZHJpdmVycyBtdXN0IG5vdCBkZXBlbmQgb24gc3ltYm9scyBleHBv
cnRlZCBieQ0KPiArYW55IHBhcnRpY3VsYXIgc3dpdGNoIGNvbnRyb2wgcGF0aCBkcml2ZXIuIERv
aW5nIHNvIHdvdWxkIGNyZWF0ZSBhIGNpcmN1bGFyDQo+ICtkZXBlbmRlbmN5LCBiZWNhdXNlIERT
QSwgb24gYmVoYWxmIG9mIHRoZSBzd2l0Y2ggZHJpdmVyLCBhbHJlYWR5IHJlcXVlc3RzIHRoZQ0K
PiArYXBwcm9wcmlhdGUgdGFnZ2luZyBwcm90b2NvbCBkcml2ZXIgbW9kdWxlIHRvIGJlIGxvYWRl
ZC4NCj4gKw0KPiArTm9uZXRoZWxlc3MsIHRoZXJlIGFyZSBleGNlcHRpb25hbCBzaXR1YXRpb25z
IHdoZW4gc3dpdGNoLXNwZWNpZmljIHByb2Nlc3NpbmcNCj4gK2lzIHJlcXVpcmVkIGluIGEgdGFn
Z2luZyBwcm90b2NvbCBkcml2ZXIuIEluIHNvbWUgY2FzZXMgdGhlIHRhZ2dlciBuZWVkcyBhDQo+
ICtwbGFjZSB0byBob2xkIHN0YXRlOyBpbiBvdGhlciBjYXNlcywgdGhlIHBhY2tldCB0cmFuc21p
c3Npb24gcHJvY2VkdXJlIG1heQ0KPiAraW52b2x2ZSBhY2Nlc3Npbmcgc3dpdGNoIHJlZ2lzdGVy
cy4gVGhlIHRhZ2dlciBtYXkgYWxzbyBiZSBwcm9jZXNzaW5nIHBhY2tldHMNCj4gK3doaWNoIGFy
ZSBub3QgZGVzdGluZWQgZm9yIHRoZSBuZXR3b3JrIHN0YWNrIGJ1dCBmb3IgdGhlIHN3aXRjaCBk
cml2ZXIncw0KPiArbWFuYWdlbWVudCBsb2dpYywgYW5kIHRodXMsIHRoZSBzd2l0Y2ggZHJpdmVy
IHNob3VsZCBoYXZlIGEgaGFuZGxlciBmb3IgdGhlc2UNCj4gK21hbmFnZW1lbnQgZnJhbWVzLg0K
PiArDQo+ICtBIG1lY2hhbmlzbSwgY2FsbGVkIHRhZ2dlci1vd25lZCBzdG9yYWdlIChpbiByZWZl
cmVuY2UgdG8gYGBkcy0+dGFnZ2VyX2RhdGFgYCksDQo+ICtleGlzdHMsIHdoaWNoIHBlcm1pdHMg
dGFnZ2luZyBwcm90b2NvbCBkcml2ZXJzIHRvIGFsbG9jYXRlIG1lbW9yeSBmb3IgZWFjaA0KPiAr
c3dpdGNoIHRoYXQgdGhleSBjb25uZWN0IHRvLiBFYWNoIHRhZ2dpbmcgcHJvdG9jb2wgZHJpdmVy
IG1heSBkZWZpbmUgaXRzIG93bg0KPiArY29udHJhY3Qgd2l0aCBzd2l0Y2ggZHJpdmVycyBhcyB0
byB3aGF0IHRoaXMgZGF0YSBzdHJ1Y3R1cmUgY29udGFpbnMuDQo+ICtUaHJvdWdoIHRoZSBgYHN0
cnVjdCBkc2FfZGV2aWNlX29wc2BgIG1ldGhvZHMgYGBjb25uZWN0KClgYCBhbmQgYGBkaXNjb25u
ZWN0KClgYCwNCj4gK3RhZ2dpbmcgcHJvdG9jb2wgZHJpdmVycyBhcmUgZ2l2ZW4gdGhlIHBvc3Np
YmlsaXR5IHRvIG1hbmFnZSB0aGUNCj4gK2BgZHMtPnRhZ2dlcl9kYXRhYGAgcG9pbnRlciBvZiBh
bnkgc3dpdGNoIHRoYXQgdGhleSBjb25uZWN0IHRvLg0KPiArDQo+ICBDb25kdWl0IG5ldHdvcmsg
ZGV2aWNlcw0KPiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIA0KPiBAQCAtNjI0LDYgKzY2
MiwyNyBAQCBTd2l0Y2ggY29uZmlndXJhdGlvbg0KPiAgICBjYXNlLCBmdXJ0aGVyIGNhbGxzIHRv
IGBgZ2V0X3RhZ19wcm90b2NvbGBgIHNob3VsZCByZXBvcnQgdGhlIHByb3RvY29sIGluDQo+ICAg
IGN1cnJlbnQgdXNlLg0KPiAgDQo+ICstIGBgY29ubmVjdF90YWdfcHJvdG9jb2xgYDogb3B0aW9u
YWwgbWV0aG9kIHRvIG5vdGlmeSB0aGUgc3dpdGNoIGRyaXZlciB0aGF0IGENCj4gKyAgdGFnZ2lu
ZyBwcm90b2NvbCBkcml2ZXIgaGFzIGNvbm5lY3RlZCB0byB0aGlzIHN3aXRjaC4gRGVwZW5kaW5n
IG9uIHRoZQ0KPiArICBjb250cmFjdCBlc3RhYmxpc2hlZCBieSB0aGUgcHJvdG9jb2wgZ2l2ZW4g
aW4gdGhlIGBgcHJvdG9gYCBhcmd1bWVudCwgdGhlDQo+ICsgIHRhZ2dlci1vd25lZCBzdG9yYWdl
IChgYGRzLT50YWdnZXJfZGF0YWBgKSBtYXkgYmUgZXhwZWN0ZWQgdG8gY29udGFpbiBhDQo+ICsg
IHBvaW50ZXIgdG8gYSBkYXRhIHN0cnVjdHVyZSBzcGVjaWZpYyB0byB0aGUgdGFnZ2luZyBwcm90
b2NvbC4gVGhpcyBkYXRhDQo+ICsgIHN0cnVjdHVyZSBtYXkgY29udGFpbiBmdW5jdGlvbiBwb2lu
dGVycyB0byBwYWNrZXQgaGFuZGxlcnMgdGhhdCB0aGUgc3dpdGNoDQo+ICsgIGRyaXZlciByZWdp
c3RlcnMgd2l0aCB0aGUgdGFnZ2luZyBwcm90b2NvbC4gSWYgaW50ZXJlc3RlZCBpbiB0aGVzZSBw
YWNrZXRzLA0KPiArICB0aGUgc3dpdGNoIGRyaXZlciBtdXN0IGNhc3QgdGhlIGBgZHMtPnRhZ2dl
cl9kYXRhYGAgcG9pbnRlciB0byB0aGUgZGF0YSB0eXBlDQo+ICsgIGVzdGFibGlzaGVkIGJ5IHRo
ZSB0YWdnaW5nIHByb3RvY29sLCBhbmQgYXNzaWduIHRoZSBwYWNrZXQgaGFuZGxlciBmdW5jdGlv
bg0KPiArICBwb2ludGVycyB0byBtZXRob2RzIHRoYXQgaXQgb3ducy4gU2luY2UgdGhlIG1lbW9y
eSBwb2ludGVkIHRvIGJ5DQo+ICsgIGBgZHMtPnRhZ2dlcl9kYXRhYGAgaXMgb3duZWQgYnkgdGhl
IHRhZ2dpbmcgcHJvdG9jb2wsIHRoZSBzd2l0Y2ggZHJpdmVyIG11c3QNCj4gKyAgYXNzdW1lIGJ5
IGNvbnZlbnRpb24gdGhhdCBpdCBoYXMgYmVlbiBhbGxvY2F0ZWQsIGFuZCB0aGlzIG1ldGhvZCBp
cyBvbmx5DQo+ICsgIHByb3ZpZGVkIGZvciBtYWtpbmcgaW5pdGlhbCBhZGp1c3RtZW50cyB0byB0
aGUgY29udGVudHMgb2YgYGBkcy0+dGFnZ2VyX2RhdGFgYC4NCj4gKyAgSXQgaXMgYWxzbyB0aGUg
cmVhc29uIHdoeSBubyBgYGRpc2Nvbm5lY3RfdGFnX3Byb3RvY29sKClgYCBjb3VudGVycGFydCBp
cw0KPiArICBwcm92aWRlZC4gQWRkaXRpb25hbGx5LCBhIHRhZ2dpbmcgcHJvdG9jb2wgZHJpdmVy
IHdoaWNoIG1ha2VzIHVzZSBvZg0KPiArICB0YWdnZXItb3duZWQgc3RvcmFnZSBtdXN0IG5vdCBh
c3N1bWUgdGhhdCB0aGUgY29ubmVjdGVkIHN3aXRjaCBoYXMNCj4gKyAgaW1wbGVtZW50ZWQgdGhl
IGBgY29ubmVjdF90YWdfcHJvdG9jb2woKWBgIG1ldGhvZCAoaXQgbWF5IGNvbm5lY3QgdG8gYQ0K
PiArICBgYGRzYV9sb29wYGAgc3dpdGNoLCB3aGljaCBkb2VzIG5vdCkuIFRoZXJlZm9yZSwgYSB0
YWdnaW5nIHByb3RvY29sIG1heQ0KPiArICBhbHdheXMgcmVseSBvbiBgYGRzLT50YWdnZXJfZGF0
YWBgLCBidXQgaXQgbXVzdCB0cmVhdCB0aGUgcGFja2V0IGhhbmRsZXJzDQo+ICsgIHByb3ZpZGVk
IGJ5IHRoZSBzd2l0Y2ggaW4gdGhpcyBtZXRob2QgYXMgb3B0aW9uYWwuDQo+ICsNCj4gIC0gYGBz
ZXR1cGBgOiBzZXR1cCBmdW5jdGlvbiBmb3IgdGhlIHN3aXRjaCwgdGhpcyBmdW5jdGlvbiBpcyBy
ZXNwb25zaWJsZSBmb3Igc2V0dGluZw0KPiAgICB1cCB0aGUgYGBkc2Ffc3dpdGNoX29wc2BgIHBy
aXZhdGUgc3RydWN0dXJlIHdpdGggYWxsIGl0IG5lZWRzOiByZWdpc3RlciBtYXBzLA0KPiAgICBp
bnRlcnJ1cHRzLCBtdXRleGVzLCBsb2NrcywgZXRjLiBUaGlzIGZ1bmN0aW9uIGlzIGFsc28gZXhw
ZWN0ZWQgdG8gcHJvcGVybHkNCj4gLS0gDQo+IDIuMzQuMQ0KPg==

