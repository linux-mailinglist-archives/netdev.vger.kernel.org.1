Return-Path: <netdev+bounces-71357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF43853100
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5EAB2255F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E743AC8;
	Tue, 13 Feb 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="jSGn6zVJ"
X-Original-To: netdev@vger.kernel.org
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2123.outbound.protection.outlook.com [40.107.9.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78913446C6
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828988; cv=fail; b=fLEgcqHbhoFMyn5qD+B55JbyyHOBoY2l3XmqHL0aF5OobCPpBbTEdjryz847xqHDXjRGGNgFqEk68zIxttY4Sji+HLzWd5d+GofOSj7XqKxz7TcXnd2I2uPJ9g+3oKZB+Z3CyH1hwH448UM9fWa19hicvCEZYAaTTpZg++5Jly0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828988; c=relaxed/simple;
	bh=uxZeAUA6uOUJGo9oiRBALNz+KitBldk9haMQoZcgtj0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C7e9ESsF+ARvRzZzM9jEFnsBOQ38oTEwPQlU99704dmPuODwp2hPOGvJC1gbukFWmZuKjnB/dUmZEr2DHZj2H7mPWPDoN2Xws82FX5+nlfFX+Gfh3lv4ZgFNMKe95cHLvIl+OFN0UROsnh/ohohPnLOJjnsVEJO+1x8LWZmygR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=jSGn6zVJ; arc=fail smtp.client-ip=40.107.9.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I78YjFrs8usQagL1yAK1hIBMbd2P8tYwg5+r1SvZ14PVe2menN/SHlQxtbExFCdK1O+wGhl+JOBytZCMm58eaK9vPyVlMJ776dfkOzLzS1SmZrxLx0DEdxd5WaGEI6+F4yLBxIPb8ZCSJgLOdRgP0x4+1ZnZsn9k2iaCssay1gpNVLY/OjVnQKxkyaBxmrR3fDBpBRyMOdxNweljyE9a8J6u234dBL1BTFIvIiTyBfPvl1yQN8EMndxmdaSf7f9MkdDNK6/KYd3Ww8iq8dKjUJRhMoSGGMOqMNdvHaDUyIlbGbHcoKQmw/xkMHOSYgu4Zlqgi2wZUQD7f7A73V+9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxZeAUA6uOUJGo9oiRBALNz+KitBldk9haMQoZcgtj0=;
 b=KWBg5ZRNOSzipFcfwX7mkrn6EgCmx+GGtc/p6Q+bAr1iibHSJpO8EhB5W9v7BK1yQkaWUm/2JvXG2hazdyDFsCdQlZCA86HZea3Ubu5zJrvyB1N0Gv123AxtVmaC04vItpCZ2w6/zZWnuHDR9gCqRZC8IVH7mIn8tLr/nGnw9l10N0ihu1Ta4C2jpJtPIwsH2E3ejxRjchPY6QbtQcDfR3ygs9Rtv3CQS2+4DNZzn4KCZY3BjpA546py9UoHCpWdmJhR7/mCCU1/+4NbMSTAAxqjMlurTTllEOSgZtKim+FKQaDYltDar2PPndXvlg9yKIA2Bbe8qZLkz3gBiEFVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxZeAUA6uOUJGo9oiRBALNz+KitBldk9haMQoZcgtj0=;
 b=jSGn6zVJYwtuvLnZm6oLQJ/FFvMxDY+Kh12NzVE1i6nmV+iIiK7ddCzDsJupZ+RUze1JVeVZVLlkHv0wb7HISnltSXsGDHh3Wo46z3a9sniv1lB/BBH/2A3xz35WMv017jRWFWKfH7NK68ggpTfau57IavlKO/0mglfHSjhFYRZ02WN77EgyqWVkqIv3Kwd+BNYhvMLjew4FoSI2KAHmRYpOmImvRvWa0bRKQFtxsd7+xAZrZK7iimDRNdy5tNdT5puSfRwDnNY8TxSTPiiOMTIis9ILea4veFS/E44bEv8WdqKmpg0g2u1uDSdZSTIgrOau9PYCcLgkOx7SfCcnYg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3233.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 12:56:22 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589%6]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 12:56:22 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Paolo Abeni <pabeni@redhat.com>, Geoff Levand <geoff@infradead.org>,
	sambat goson <sombat3960@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v4 net] ps3/gelic: Fix SKB allocation
Thread-Topic: [PATCH v4 net] ps3/gelic: Fix SKB allocation
Thread-Index: AQHaW/l8NqjV1AFrB0m4lgCoqVjR9rEIMmkAgAANuYA=
Date: Tue, 13 Feb 2024 12:56:21 +0000
Message-ID: <7b695ae5-f7ce-454e-b94a-295013efddb5@csgroup.eu>
References: <4a6ab7b8-0dcc-43b8-a647-9be2a767b06d@infradead.org>
 <125361c7ec88478e04595a53aacc406ef656f136.camel@redhat.com>
In-Reply-To: <125361c7ec88478e04595a53aacc406ef656f136.camel@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3233:EE_
x-ms-office365-filtering-correlation-id: 4fc43559-5222-433e-4857-08dc2c932dce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pStPpKrtX47TcKQd4YeVOuR+VcbFAvRl35s8yuWEnu2ERCrOvV4dJLCKpNzd1cdFqoMDTgPwpzRUyFBMhyceNID6G/9qB8y4MI2O8dAyq4W4d11lKztVtSc6upckvSIIcFHTbx+9PTkM8OVCO363MqejC49S26M7kNx85VKqKpLlLODsSliq9DEhtkIFDDOq4LHTReSegXK0zEeRKaYz/WtxjDJ7FeX/0rfzCLTgy9+MIug50Rej5K0XZ2tOWIslNzaybWGduh3XEnXkyKaZOOEHc8OlMJQA6OvhvystI/Gbca9ieI4Cgj+YrWwp6vVIR95Ikt/g8A6gqDG8s93UOBr37RcIZF7wDpMU91nuPvJrvz5f6erOqr4vibNUdM6vt0dDcSjv8SjrHOJ19sifu7N2FkCAz2vfyDjZ1rPqFq/9WQX5AT+ssvGWB1lPzugQDAJcJPfDbcO2KIIsUuPVH0y23UMIEg4jRfdRquCJZXkGeWSBh3weLXQCwPFYQxXpFPh8RBpOf2MKViKQ3kxjDZ3B8UQlUtyUC8t9Id7x0zXGNnKLTnSspVyvyUXj3fENGIA0oaJhLYgaUk+9Nh+AJP8srm1hwMIa4DT2DBf1UEBcXO/NOHLR0yw/8h9gR8Zp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39850400004)(376002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(44832011)(31686004)(41300700001)(110136005)(2906002)(316002)(5660300002)(86362001)(36756003)(31696002)(38070700009)(83380400001)(66446008)(26005)(66574015)(66476007)(2616005)(122000001)(478600001)(38100700002)(64756008)(71200400001)(76116006)(66946007)(8676002)(8936002)(6512007)(6506007)(6486002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGp5SlR6V2xuWXFra2dWVm1QdHZnd2pvaUVjWmxpK05HNXdENER4TW5sdlNK?=
 =?utf-8?B?SkJzTElrdHBhNFVQdEFhR0dpRWRwVDViaUFZbFBDVTdrcXVXdDAvNU55TU1m?=
 =?utf-8?B?aG55NElSNEZmY1YwNEZhdDd2Y0hVTWI5VlNvTzN0bG1rVXl5TkRYMndPbHNK?=
 =?utf-8?B?ZitkMVRDdzdMRG8vQUt6em5tS0Z3OFh6ZXNFT3ZQZzhBNHZ2MHFpTE1QVHUw?=
 =?utf-8?B?UmN2TmJqK0x4UXl2WUtDbjJNLy9SMTFJNmJTRCtGS3dSbEpTRHhuQzcrZkhM?=
 =?utf-8?B?T1JTWHFGUTM2eUhQQ05GeUUyd3NWNHJycVVqNnNjcWRPSWxGdFhwNzMybFJD?=
 =?utf-8?B?YnNSNWFOZkpKV1o3N2dBMyttSmU4c3ZjTWdSaXM2N2NleG1ISGRLbGNIRGtO?=
 =?utf-8?B?ZUZGK1ZHaGw4SWtsSmx4T1ZQeEh5SWNROE0xTWhIQWx5MHl2N04zdHNLMmJC?=
 =?utf-8?B?dnd4S3lqMEN5dU9EaFgrTXlRR1UvZWlpWkZVem1MN3Nacm9ObEc0WGhCZ3ZM?=
 =?utf-8?B?SUtGZ25IMGptbWxUOGNIWXpsRTlCMm4veTFRdVRkZUdaOFIzYmFFNzdMNlR5?=
 =?utf-8?B?ZEJwVjdwU2Y1cXpDdHF2aUJHaWtiaHBpMEpQWEhGdnhWbzRSRklGY2cxV05X?=
 =?utf-8?B?aGxYUmtjdG1VSWMrWFB3NDlpbUV2ckUvcUYwcDAyRDVRa0h0K0RvdnMrUVlZ?=
 =?utf-8?B?eVlGVDZNWld4VnpERW1ndDZOWWZjbGJFWTR5YmlVWUpOa0R0K29zOFFTNFgz?=
 =?utf-8?B?TXJpb1lNa2tXWkRldjBOelhnUTlwdDl0UEkrNkJGbTdQcGkyNFAxbEhaUTBM?=
 =?utf-8?B?eDhETWFKVng5UmpNUWpiblJta0ZxS2VtQkFpQk5PU2xpZW92YXNZSEVSaWdD?=
 =?utf-8?B?MTdWMXBIaFM5bUVUQ0Z6WmRxd3VNeWY2WGluaE83bzJVOVFIL1Q4anBpYjBD?=
 =?utf-8?B?Y1RoVzlPZzJ1V28xVXBMY0F6VWIzMDRVQU1NSllMN3pnWWYyemFwS0FqMG1D?=
 =?utf-8?B?eDUyekhoZ2hyRnh5ZDltRHBVZmJubzdqc0pJUG5CeDdReEVabnk0RzhKNDhO?=
 =?utf-8?B?Vy9NbUllWnEyMHdlRVY3cG1sbnFOb3NacDliSWFOdTY3TitEb0k1Qld4cS9J?=
 =?utf-8?B?U1NGcTY5YTdGeDErWXFwUHVvQnNTS0lEcFllVDRkWEU3cWdkV0FreWs0d1NC?=
 =?utf-8?B?THdMRUxjTkpaYm5OMU05enQzV1ZCcGduQ1lUSjN6TU1jb2NUVjRBWERQK3Ry?=
 =?utf-8?B?MXgxSi8zeGlZRkNzVzBhVlFvbXVSWnNtZlZybW1rZDdrUTJzZGNmL0lWRFdj?=
 =?utf-8?B?M24xWW13a1FsbFFjdm4xWEI3bVIwWlBReW1KUnZsRU43L0pPV2lwYlIyUERG?=
 =?utf-8?B?V29RRXZGWm1pOTlPenFUb0VJUENwaDVHU2syUTFXZFlGMWZIanJHK3RIcjVS?=
 =?utf-8?B?MmxEL2VMYWZMTHFyK3JCMk5aLzBnWUN4bkNvb28vbVp6RmFEM1ZJWVk2c3JL?=
 =?utf-8?B?eTgxTkxVZUlodzk5bTZ5VzA2R3dZSHE5V1czY1VSaktWTFIrd3BLVzFya1Zr?=
 =?utf-8?B?NTQvdHUyc3B5UWMvbXpCRE0zVzhPNGM1d1ZMK0xIWGo1cU5hWDZGMExMa0xM?=
 =?utf-8?B?K1VJSWs1RzRZVktxU2F0cE40dDR1bG9wTGV6eTRTR1lCbWQyVE95bDJLckJO?=
 =?utf-8?B?U0ZrbjBLdExGQ0M0QWlJZEFsMkQwbS92bU55Yk8vUjM3NlRnTUxjaHlVakdj?=
 =?utf-8?B?MkhFL3ltUlJ5VkdqWTlkYWw1RWNQOTNvcC82YmpRTHVubnpFWlc0b2k4bkNy?=
 =?utf-8?B?YzdNZW1FLzdhZ2Z3eEVBSFdOS2ozcGI4SEpHS21YZzJMdSt2V2Z5QXJxU0sz?=
 =?utf-8?B?ZTJXWmJwdVFFTUE4Uyt6Ny91bWFEN0wvWXVEdTFuU2VEbVpTOExlaDRqZWdR?=
 =?utf-8?B?cGthY1lFOTJ1NkFSQ1dPL3JhTlRzeUdYbUhvcS9RQmpYK210ZG51b0k1V0Ez?=
 =?utf-8?B?aVlPTmZjck1iOWcwamhVdWxNNjFhTzhIMXVPT0VXMmxPVUdMY2Z3VlhmMEsy?=
 =?utf-8?B?OGJyVzZ6MXNCK2UzQ1l6WWt1QWlWVUxDMndRMnp1ZmpWU240NmF4cDJPaDZL?=
 =?utf-8?Q?bLQ58x+0LeRIwQSQ10sZqqIpz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66622786EBB58C4EBB4F7D1FFDB5D28F@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc43559-5222-433e-4857-08dc2c932dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 12:56:21.9682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOpqPN+NES5XIr0b/kZz+cegurlZ0WWuz4Smw18EJVbJIxwojcj64p15w3rgUceulAWdsWYGS2jHQg525EcouU2I+Wbm0xvRWiXz0UAiJbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3233

DQoNCkxlIDEzLzAyLzIwMjQgw6AgMTM6MDcsIFBhb2xvIEFiZW5pIGEgw6ljcml0wqA6DQo+IE9u
IFNhdCwgMjAyNC0wMi0xMCBhdCAxNzoxNSArMDkwMCwgR2VvZmYgTGV2YW5kIHdyb3RlOg0KPj4g
Q29tbWl0IDNjZTRmOWMzZmJiMyAoIm5ldC9wczNfZ2VsaWNfbmV0OiBBZGQgZ2VsaWNfZGVzY3Ig
c3RydWN0dXJlcyIpIG9mDQo+PiA2LjgtcmMxIGRpZCBub3QgYWxsb2NhdGUgYSBuZXR3b3JrIFNL
QiBmb3IgdGhlIGdlbGljX2Rlc2NyLCByZXN1bHRpbmcgaW4gYQ0KPj4ga2VybmVsIHBhbmljIHdo
ZW4gdGhlIFNLQiB2YXJpYWJsZSAoc3RydWN0IGdlbGljX2Rlc2NyLnNrYikgd2FzIGFjY2Vzc2Vk
Lg0KPj4NCj4+IFRoaXMgZml4IGNoYW5nZXMgdGhlIHdheSB0aGUgbmFwaSBidWZmZXIgYW5kIGNv
cnJlc3BvbmRpbmcgU0tCIGFyZQ0KPj4gYWxsb2NhdGVkIGFuZCBtYW5hZ2VkLg0KPiANCj4gSSB0
aGluayB0aGlzIGlzIG5vdCB3aGF0IEpha3ViIGFza2VkIG9uIHYzLg0KPiANCj4gSXNuJ3Qgc29t
ZXRoaW5nIGFsaWtlIHRoZSBmb2xsb3dpbmcgZW5vdWdoIHRvIGZpeCB0aGUgTlVMTCBwdHIgZGVy
ZWY/DQoNCklmIHlvdSB0aGluayBpdCBpcyBlbm91Z2gsIHBsZWFzZSBleHBsYWluIGluIG1vcmUg
ZGV0YWlscy4NCg0KIEZyb20gbXkgcG9pbnQgb2Ygdmlldywgd2hlbiBsb29raW5nIGF0IGNvbW1p
dCAzY2U0ZjljM2ZiYjMgDQooIm5ldC9wczNfZ2VsaWNfbmV0OiBBZGQgZ2VsaWNfZGVzY3Igc3Ry
dWN0dXJlcyIpIHRoYXQgaW50cm9kdWNlZCB0aGUgDQpwcm9ibGVtLCBpdCBpcyBub3Qgb2J2aW91
cy4NCg0KQ2hyaXN0b3BoZQ0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBQYW9sbw0KPiAtLS0NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3Rvc2hpYmEvcHMzX2dlbGljX25ldC5j
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvdG9zaGliYS9wczNfZ2VsaWNfbmV0LmMNCj4gaW5kZXgg
ZDViNzVhZjE2M2QzLi41MWVlNjA3NTY1M2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L3Rvc2hpYmEvcHMzX2dlbGljX25ldC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L3Rvc2hpYmEvcHMzX2dlbGljX25ldC5jDQo+IEBAIC0zOTUsNyArMzk1LDYgQEAgc3RhdGlj
IGludCBnZWxpY19kZXNjcl9wcmVwYXJlX3J4KHN0cnVjdCBnZWxpY19jYXJkICpjYXJkLA0KPiAg
ICAgICAgICBkZXNjci0+aHdfcmVncy5kYXRhX2Vycm9yID0gMDsNCj4gICAgICAgICAgZGVzY3It
Pmh3X3JlZ3MucGF5bG9hZC5kZXZfYWRkciA9IDA7DQo+ICAgICAgICAgIGRlc2NyLT5od19yZWdz
LnBheWxvYWQuc2l6ZSA9IDA7DQo+IC0gICAgICAgZGVzY3ItPnNrYiA9IE5VTEw7DQo+ICAgDQo+
ICAgICAgICAgIG9mZnNldCA9ICgodW5zaWduZWQgbG9uZylkZXNjci0+c2tiLT5kYXRhKSAmDQo+
ICAgICAgICAgICAgICAgICAgKEdFTElDX05FVF9SWEJVRl9BTElHTiAtIDEpOw0KPiANCg==

