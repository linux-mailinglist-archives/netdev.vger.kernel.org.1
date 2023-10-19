Return-Path: <netdev+bounces-42489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B37287CEDCF
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E77FB20DA5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB1E65C;
	Thu, 19 Oct 2023 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CXUxKg/X"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8D656
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:58:42 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080E7FA
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HttAvpOwyW31F3zwc2/EHt+POXsw6FktISjKVYpzp3dv6LBilt0GweZdlJ+WB09Bk0sJIToG0pqHJUJNLSnILj2ilFe9BCyIkAkowVhkU5JlnZDiy5drHU10cIHOnPBCVfux2E2b2zFRK0J/+hr0wWhrz8Lt8udmS+ij9akAP3NIM8bbgczzPkXuubWF7RRwFsDly1vVNF3DjgZji2RxpmghdTCHvuzeQQBB3KGtedVIo4F/adUrlVcLSRcHTY+81qg6TDHUsBri2kXp624351AnBrdqcH+H6u92oHvFt0A0Fz8CE0YlynyKonYsKApLgpdbmbx7XcSgzZYtjGLXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72PeqzRsKIWONlMMGXEeLVCrjmCYas65kR67l11XwAo=;
 b=QL5jitQoyR9mwj9RF067+E+vUJoihGzuR3ALnTHAw/hsVxMiynnJRL2ueX0c677rZDbgHEN0smb+gNyUurSlI54+P+R079xddSkImfhnBT1kFlarrd1oZM5CPAq2V3zv/8A5+NwJqEFGAXF1ViyUmh4uXWKNuDi41h6MPr+vQ2lg2qgh8Zo7N9s0bAM1OWfk1t+8tVJP4W/HZHr+RwjQY67hq3UV3RnBES2OwF0un3gscApgdE35M/2A0fGixCEvrEtqnoMK9AC+LNDWQ5PZ64LHjmMjWaA+0eYRBnC0wSz+zDcI5KGa2Ce6EUTgflIxPbIzloDD5vaoHZOxDod73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72PeqzRsKIWONlMMGXEeLVCrjmCYas65kR67l11XwAo=;
 b=CXUxKg/XTEKDo/ndPEgHCJ0JSvR/h+YtiVGSx/s5YF+ZV+wfXmoM0ErDBD9/AobXvkECo5A6EtUmPrgHpmZOX7shPnP8CeDbzzCpO/OQaWXM2ABvnwP7z43Wu0VaOzAFPaeRpDJalOPZ4ACfiUdDZsDdDyNyCeTiUSB9i6cYT5g=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PA4PR04MB9592.eurprd04.prod.outlook.com (2603:10a6:102:271::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 01:58:37 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::9c92:d343:b025:6b07]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::9c92:d343:b025:6b07%4]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 01:58:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "Radu-nicolae Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>
CC: "Sebastian Tobuschat (OSS)" <sebastian.tobuschat@oss.nxp.com>,
	dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] net: fec: fix dev_info pointer
Thread-Topic: [PATCH net-next] net: fec: fix dev_info pointer
Thread-Index: AQHaAfW15oqaaW9tDECF9MekfTEN6bBQWO1A
Date: Thu, 19 Oct 2023 01:58:37 +0000
Message-ID:
 <AM5PR04MB313962280DF8C65B2D72ABE188D4A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20231018190229.1880170-1-radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20231018190229.1880170-1-radu-nicolae.pirea@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PA4PR04MB9592:EE_
x-ms-office365-filtering-correlation-id: 525af59e-04f0-4818-f34b-08dbd046e8b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 M2Y2H8cj++eHIACO6cTyroeCxgJAX5f7R4OuRS6pSrKb1jQxMaQPDj23obM/d1fDiW0JnpZTLSy0AZHCZCFxU1XSR0KpeFItW84M3VBgRhyyOZMmAO/TmeYT0HwYHIPrSrkq2Ri6r0Nmj5UGnT1G9AejDzHEBDeqD5GhkRVMHm1S+Nq40IbOsZkcmQ1+E5cWNJvd4GSUIoDQ1i2pF81s63KSXGwdxr9rfoe2VRF+7uf0x8vpc4eNCgEMl1Gb9bbg09w5uw0OoNjv/WeX8JxiXL3gxOVeg6tf2ltFsRPvJljAISwPue+aaptYs7oRwSa5ywSytf24a7z9h19MJxCohJ3moNNMbmfqG9kT2+ICtVk/bpgjLRl+mKwrn8YqpbU0a689ajCPcBqbLeZgQeReiC8B8eOMixplCcuBun4hp6VQVnF9UZjM/nKOZU2rCXPUBIJsECEfk885GDMQZoDGwhHb7JCJbj1PoHD5+Uxivn8ThcAhnxVbX0QfYT4ZijedrVrGQFcl70rjrOtIL7yy8/aEy19K7QOPTaiv3iSIM7d/9s7/vfhZMPiI3+AK0wR2isWNNN/CAPZ8g4Lqhu4pSV4TLKiUuOT1vH25br8YKpI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(966005)(38070700005)(53546011)(38100700002)(122000001)(41300700001)(66946007)(6506007)(76116006)(110136005)(71200400001)(7696005)(478600001)(54906003)(26005)(66476007)(64756008)(9686003)(66556008)(316002)(83380400001)(66446008)(2906002)(86362001)(44832011)(5660300002)(52536014)(33656002)(8936002)(4326008)(8676002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?S3NiVnA2V3lsSjhHQkJId2JhNDhaR3IvK0wxdGp2Y0VwVEc0a0paZmpkNk8y?=
 =?gb2312?B?c1o4eXhQbGhLU1lFdjNVcnpkSE5LalZReXZpajNZT091aUxzeUhCWnRMRXNC?=
 =?gb2312?B?elUvYnBkK3lVT1BLOVg3Ri85T3d5c3pIb21IY0FPbjVzYXUzemV2cTJQZTgr?=
 =?gb2312?B?ZEZxZnkxbmtGQS9yVEdJV0Q4djFjaUlESzZPWVQ5TWw2VlpZaFRXcjJCNEZ1?=
 =?gb2312?B?TmdyYlJsOU52WUdzakU1ZkUwdTBzVHVEbWlCZzlxZk9HZ1U1TC9kU1dMeTZF?=
 =?gb2312?B?aGVPNjY1S0M0RHNsVUxyVk5VYnZNbVN5UE4wYXRBZVJ0UnRLTmRtUmJlVjJG?=
 =?gb2312?B?QWhENzBBWjRuQkJ6TkdYZTE5TXZucmZOVG1VQWdtMUNhK1haTExDbzdYM1Fk?=
 =?gb2312?B?SHAxWm1qS1NGQVFxdVNGcWdoZWlCQklSOGZTU2t4YnJ4b2NnVkM0YVMrUzBB?=
 =?gb2312?B?aFhta3RxOEhxaXpIQnljc3hUTzVteGJIZkE5SURGTVNvaXNCQ2dsQjhKQVU5?=
 =?gb2312?B?UVFlM0hzRTVwOW85Ty83V3R4NDNUblJSYlVKWTFEMnMvSU5Uc3M5WXI5TDJS?=
 =?gb2312?B?TG1IN2diZ29wQThNenNEY2NpZk9tUkpqUjBnSGdBeFhUekJPZ0d4OFpVSkhG?=
 =?gb2312?B?ZSsyblpZem1yMk56a0F4bFducGtVL2xwTmhtb3J2M2htTnBqUkZIcHovL2t0?=
 =?gb2312?B?dDNNTDlLR2NpMVN4U0s1OVVXa3NhazhNMjg5Ry9NSFhDenVjbnhaMUtJSDkw?=
 =?gb2312?B?Yk5oSlN4cmY2cHEvZkRCdDdKWjgzUFFPdlRQWHJMdjk3K0xvK3pyVktQaFcv?=
 =?gb2312?B?N1NlSDFNN2c1YVpzNU5CK0x3Ymw2aFM0N2puRk5YcHFpd1hZZE5oUmxDb29Y?=
 =?gb2312?B?RDhVUHZtQU41bnpSWCtwbnRvY2pIMncvcFo5RGppNkFkbVh6TFFoaDk2WmJp?=
 =?gb2312?B?bldkeExZdDVRM2g2aDZpMzRVSG9hK0RIYlNTSnRTVmh5UEUzdHQvYWdEakoz?=
 =?gb2312?B?QU81dFZiVFBKQU0xaFVzTmxrdUsxL0lqUHJSaXJ5d0tRV0RENHlwajFXN0V1?=
 =?gb2312?B?eDFpcVQzV2RybjdSVGhLZ3N5a1V5cFpDazFyaDFmVS9oZDNscW5jR2VaNG8x?=
 =?gb2312?B?aFdSaXJiYjBSTElkWXFWQmtpM3BqbFgveUNRZjQwTTRsY2dmMVRoR0Y0em5I?=
 =?gb2312?B?eGZxdEUyTmwvY0FZOFZROFBxZEVKd2JIZ09BVmM0V0ZKcUF6RmFWUTVwTGho?=
 =?gb2312?B?a2ZCRDhIWHFiMlVLeDhTOU9IcDdtL0VEN3hqdEV3SWl4VTNYSHBzQUZtWnN3?=
 =?gb2312?B?SUQ0Y0x6dFdEanoxTGRxbG5vb3UzbFo0bkpqa3RHemsrM2RhNkFQVlc2aElX?=
 =?gb2312?B?TzBZYUVRazM0RWk5d3BUOFBTdTEwSTh0ZkJwejlOdERwcmRSdmdvZmUxazNw?=
 =?gb2312?B?Sk9pZ3NtdmNXanZ2RHovZXdSUUVhUU5WakloRm93Q3YrbW9ySGllcVE0OUlz?=
 =?gb2312?B?dVVqQjIzWUZpNlN1RUpheGp2Z25yRXRYbGl2U01YeFd5MFJRak5UMVpVVnEv?=
 =?gb2312?B?ZkI2SEkxYUF6aVRjS1RTTllPYXRJdjdSSXpwWmJRZGZJc0N5Slpxb2NmdlBW?=
 =?gb2312?B?K2V1MDJkYUd2dEtVY1FVazZsbktCc0xOUHZWaGlHaVg5YVIxd1pLNkFIdkdK?=
 =?gb2312?B?azRwWWs2M3JIWmovYmpBSWNaUm4zS2piOUZVbjVqaExRSmV0bmJMRGR1REM3?=
 =?gb2312?B?M3R0R01IR05OeEZmaVVvR05FK0c2RWtoVHliNkExZ3laSS80U1Q2TUZzQVBV?=
 =?gb2312?B?S20wQlBjNGpVUk9KOGxqZFhYYXo5RHFnYTN2RHVUanBwZjZ5ZjhuSVk2dTV2?=
 =?gb2312?B?R1pUNURXbXR6OVV6K1NmY0RWOEJKUWUxditWemxxNVhEak1sVXF3VFJwQUZa?=
 =?gb2312?B?QTEwV1Y3WlNEWlFJdHNtbUg4NWNXSFYvb2VtSTFoczAzaE50Rk5rZG5FNGhu?=
 =?gb2312?B?MTEvM3Q2Ui95RXlxRFdGS3JPYitvSTNKZzNKMU9FdU43Wi8xYWE5Zmt3a2ZU?=
 =?gb2312?B?R2d0a3d3RkVzazRiajgyazR6SmovSnp2cTBhQm5tQzRka0NQNm8wb0dwVGkx?=
 =?gb2312?Q?qaWU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 525af59e-04f0-4818-f34b-08dbd046e8b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 01:58:37.3247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSY68UVA4LdHrhWTuCACwPGxL+dvFd71ins+RyhcCdhG44V9u4NggQdpgNCc1ESs2598a9gJKv7kB3W99+KRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9592

SGkgUmFkdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWR1LW5p
Y29sYWUgUGlyZWEgKE9TUykgPHJhZHUtbmljb2xhZS5waXJlYUBvc3MubnhwLmNvbT4NCj4gU2Vu
dDogMjAyM8TqMTDUwjE5yNUgMzowMg0KPiBUbzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+
OyBTaGVud2VpIFdhbmcNCj4gPHNoZW53ZWkud2FuZ0BueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlh
b25pbmcud2FuZ0BueHAuY29tPjsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBrZXJu
ZWwub3JnDQo+IENjOiBTZWJhc3RpYW4gVG9idXNjaGF0IChPU1MpIDxzZWJhc3RpYW4udG9idXNj
aGF0QG9zcy5ueHAuY29tPjsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IFJhZHUtbmljb2xhZQ0KPiBQaXJlYSAoT1NTKSA8cmFkdS1u
aWNvbGFlLnBpcmVhQG9zcy5ueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHRdIG5l
dDogZmVjOiBmaXggZGV2X2luZm8gcG9pbnRlcg0KPiANCj4gb2ZfbWF0Y2hfdGFibGUuZGF0YSBj
b250YWlucyBwb2ludGVycyB0byBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkLCBub3QNCj4gc3Ry
dWN0IGZlY19kZXZpbmZvLiBBIHBvaW50ZXIgdG8gYSBmZWNfZGV2aW5mbyBzdHJ1Y3R1cmUgaXMg
c3RvcmVkIGluDQo+IHBsYXRmb3JtX2RldmljZV9pZC0+ZHJpdmVyX2RhdGEuDQo+IA0KPiBUaGlz
IEJVRyBtYWtlcyB0aGUgZHJpdmVyIGNvbm5lY3QgdG8gYSBHZW5lcmljIFBIWS4NCj4gDQo+IERp
c2NvdmVyZWQgb24gRnJlZXNjYWxlIGkuTVg2IFF1YWQgU0FCUkUgQXV0b21vdGl2ZSBCb2FyZC4N
Cj4gDQo+IEZpeGVzOiBiMDM3NzExNmRlY2QgKCJuZXQ6IGV0aGVybmV0OiBVc2UgZGV2aWNlX2dl
dF9tYXRjaF9kYXRhKCkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBSYWR1IFBpcmVhIChOWFAgT1NTKSA8
cmFkdS1uaWNvbGFlLnBpcmVhQG9zcy5ueHAuY29tPg0KPiAtLS0NCg0KQSBwYXRjaCBzZXQgWzFd
WzJdIGhhcyBiZWVuIGFwcGxpZWQgdG8gbmV0ZGV2L25ldC1uZXh0LmdpdCB0b2RheS4gSSB0aGlu
ayB0aGlzDQpwYXRjaCBzZXQgY2FuIGZpeCB0aGUgcHJvYmxlbSB5b3UgZm91bmQuDQoNClsxXSBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0
LW5leHQuZ2l0L2NvbW1pdC8/aWQ9ZTY4MDlkYmE1ZWMzDQpbMl0gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldC1uZXh0LmdpdC9jb21taXQv
P2lkPTUwMjU0YmZlMTQzOCANCg==

