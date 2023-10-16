Return-Path: <netdev+bounces-41479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCBB7CB181
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD701B20D09
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F731A9F;
	Mon, 16 Oct 2023 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cypuOZX6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D3330FB8
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 17:45:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0307D83
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 10:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIF41tzfnDUcCOFUf2ogHMHEezEZ0Z3rxPnhYBxKIXNVS3WGRqkqaeFc8p6hMDnhwWQcYlBFzD5fZA61BlAZdUu/QqQH+czsKn1PJzJRJ428IDud8EwGCsCNvwlHtyluhjqaCQ1HRF/UVRyigJL5GlvHw4yKaf1cDFrrdrjB4w4pTyIoM2ukbGk6Xh/4zgy2V/C6dKUBJ2xLMAJNPD7PD+OUF9fsVQUqCFCACKlfebDmgchZTH43DJ9ocSIkfFVrzyUHB0L5FFePXJWdYix8MCeTYZ/rf1M9gDz5JtFtc03PMebrcDpSze7XT7hPAu916VeI9vPPvrZqHJSjVOEz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VP/RxlW9hHILUxDj60XH9sicckAxHa+pR+GTZBIJ/78=;
 b=MdnVPGcQB7Rkl0qWZVkKlAFrxvPweZDnZ5wc/h5Chy6mMkqVl8OEwJoaffbJK1aadYSv1tx+olrB1cFFAuO7VQLKlxuDUcIiMKMaBmUr4ixOaVHi+yi8pBDkI7vlvNQAMO+iNu62y3Fo+nVOEj7eUGYxaLes8mr+sCsItbvikkPVxOQ3/klxS2d+YbouBpM3gyiGBM0cQpAo90ynKG2SWlEHruARzM7R0G2/Zove9JBRUhh/vyaFQuMFskXRV06yXsuAdejPANyy7h8oh6XA2yjkdIgzKTe0ulhS91LLru86t/QEMkukpO/XRrLgzH88/qZbJUcATdz1yqjf8oKs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP/RxlW9hHILUxDj60XH9sicckAxHa+pR+GTZBIJ/78=;
 b=cypuOZX6bjSluKjPlAgVLAAk0aZlFkXt5b51qafFVT5QsZO9jUnG3xuJPsPDVY5RwRuV7PeG5hWEG9sL/+Yrs4IjgBqwi1koTdeCm1IkxMqXrKwFUXXMOBgb6/TBKYaw/y0CbkD6nXacmka3gATH/mmV7I2WwShs5z1PPO0z+549Kn1GKE1/D3vMK4+HkWAij+cZOzPbJYzHFXgC1bXPAGSveKKQf7C/poRYhhu7kBsyaJUteYLK4Xm/4t7gP+iFWXMXLpmnCHDZxJtRE+Tal6Jp3lsQBGHdoCjKUJ3Qz+C1Nd81fFcSEtv0kvzQ+GwBjDkai2RlUNwDpSsYjSbCzA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 17:45:13 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::a50a:75e9:b7c1:167b]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::a50a:75e9:b7c1:167b%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 17:45:13 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: RE: [PATCH v3 2/3] mlxbf_gige: Fix intermittent no ip issue
Thread-Topic: [PATCH v3 2/3] mlxbf_gige: Fix intermittent no ip issue
Thread-Index: AQHZ7Xtc1mUUBAgSDUusiYUH4tCd1rAnHs2AgCDRy1CABN7RMA==
Date: Mon, 16 Oct 2023 17:45:13 +0000
Message-ID:
 <CH2PR12MB389559F06323672319B696ABD7D7A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230922173626.23790-1-asmaa@nvidia.com>
 <20230922173626.23790-3-asmaa@nvidia.com>
 <763a584b-ead6-46fe-a50c-147ce5846768@gmail.com>
 <CH2PR12MB389581114D62133AA36F1997D7D2A@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To:
 <CH2PR12MB389581114D62133AA36F1997D7D2A@CH2PR12MB3895.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|PH8PR12MB7133:EE_
x-ms-office365-filtering-correlation-id: d03abbc8-fd05-4474-e21d-08dbce6fa670
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ppkDlHS6gcjQ/ER6Z7DfeizHyuhm1GIv4bYsZBhQ4p0hy9X2cjj+Pvj4g2S7A7g+Pz4YhTqEPzz10pIaecGj0xyHbNU+Fn3dGEEOQBE9rSGmQi8N39prqtdwKRVdhYyb/pMU3ArYWmHKmv2bCDWtg+PBW7XYvGsNm1/OGFj+qbjtV8ucZDymmEu49k3Qz6t0MftJPVbEfsYabhupv7qRvNhp4ayw3WdSkkyk3uGFZRHvXFd8cMAIt9n3Fm42yUQ+Qjvo9CS98EM0wUaikaZepv42tUAJL1BVPFXRoHntFJOgGVx7m9ut1QZrdmmYVqmGoyFrMPfE+elwO7kWzGZodzJHFqeaUrkNXLrWDHvzQYjIZeW12ITZMOyyO3eJUpEFnuRW8fj44f3AefcP5z3kcUw/EScfwG1d5W8wyCg0OFjIxfuwadu9WsX9XP3SxoA2wlAcG079fVrTfz7xCyFgkwUoT/+DZDxpOH53+Ch1Iv8RmOSuPCHvRnCuBqiK8EgxHeRAERr5Q9xzJZHA3UeTUKpxYmhog/dyMI3gaB1GTPcb49+A5TLNMUwHCl/ccx1BskokmVWcT+X19yEsvh/+YItdLOBI3wX+GFG1YeZ/jghWNut8YTl9x6wMId9vmtbD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(41300700001)(66556008)(110136005)(478600001)(76116006)(71200400001)(54906003)(64756008)(66446008)(66476007)(66946007)(107886003)(26005)(316002)(7696005)(6506007)(52536014)(8936002)(8676002)(2906002)(9686003)(5660300002)(122000001)(33656002)(38070700005)(4326008)(86362001)(83380400001)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b002eCtDRTBJd3FpUlFpWHFFRTBSS3BYdGVnYVViZUp5dkZWSFF6bVJFTUd6?=
 =?utf-8?B?c25YdlBZRWFhRTR3UFh1WGpuL2xIZ2tLdWdIQjB6Z25sRTU0dUhObW5xTEJk?=
 =?utf-8?B?SGVMalZydk5VbGd2WkRVc0RRdjNvd3piUDBoZE5HQXVGZEY5VTJaSTFYZzB5?=
 =?utf-8?B?N2g4dzFHWEJRNjhDbnZLWFRkUU1rT09uK20xTWltamtVNERPZ2dYd1VmSkRY?=
 =?utf-8?B?ajhJVFg1SlFNTjQ5TGJKc2JodnF1RFA3NjNzcVhoaW51NWhMTk13cnV0Q0Vw?=
 =?utf-8?B?dXNNY3RzbW9YNzFPOXBuR2p3NkQxcUJKVmtBUnVwZkUvYWpwNEN2VjZyMDZO?=
 =?utf-8?B?NlRPcDhUMWFRdWhTNGFRbU01R2o0UWltUklKaktXdGxBMjhZODl6N3FrZ1hJ?=
 =?utf-8?B?STZmTzd1dGxDR0NOZzlza2lxSy9tWWhTSlpsQ0pZQVlHQXk1ekNOSXVkVHUy?=
 =?utf-8?B?S3lHY0xkbWhOMGcrUnhYUk5VQ0JhQjVSTzY4YmJMRmtzTGZ4RkNBREp3UUdI?=
 =?utf-8?B?RFh0UHVqZDArYWhQTHZubHhPU2pGRzZ6a3NoZERqYk9kbDM0N3NPcXAwS1Vm?=
 =?utf-8?B?cGJEQllIRlJjaE1iZjh5aDI1eVBGZUV6OXlRbjF1K0R3eHBBaTAvOSt5TTU3?=
 =?utf-8?B?L3ZwaEwyQmZzNENlNlhlQ09hRVVJUTBpK0labk9JUVFubGZyM1RKeUdjY25C?=
 =?utf-8?B?Ukw2K2pHSUYzek9mVXZSb0w4ZkRDTTFXSWVNdjgrN3FYeXF0NER3QWwrejZS?=
 =?utf-8?B?RHNpZWM5TVpGbU51a1c2cnd1WGN6ZzI0dytCQUJmSFRVTTgxd0dja1lmTlF4?=
 =?utf-8?B?Y3BITEcxSlUyRStIUTc4bExXU0I5ZWtjblZ3cVdvM3RHUm12UTdka2lyUXBU?=
 =?utf-8?B?bVFmditYdUVXQnhCNHd2WGZnWjFCRDRpUlNPSHNHWS9IMGZVQjJ3UTRDK09M?=
 =?utf-8?B?RHZ3aVhLekxUYjNqWnpweCtOV3hmdStQL3hSVnNDQjB6SnI3WHBjUzlpenVk?=
 =?utf-8?B?TG5WcU1JTEJ6NUJFbUV1SnRaY09SbVBrbEhEMkZZVDJ2aExTZERhZ2Y0Y203?=
 =?utf-8?B?MGVGVnVmZVdlcU1GOWJaRy9uejNTMTNZalZaTFBJR0Q3MHBVUFo3VXRjMkIz?=
 =?utf-8?B?cEV4MjZHNTJoaWZsejhGYWptQWphT3J6RTREUFhxZWt3YjAvNUQ0QUhlMmtq?=
 =?utf-8?B?QUZHcG55aWU2VFlWamVrZVFiOWVEbSs1eEVTTWd4Zm82K1QyeCtJN0g4TFJv?=
 =?utf-8?B?WUNYeStzcHVPSFlobTJ3V3paZkNaN0tOWURWblVaL1RhT0Q0aUwrWGlIZ3Mr?=
 =?utf-8?B?eXhoVDM3QlduR25taHJRTHNyckpudXpMWGlVcjZtaFBmUUdJM09kcjlEV2Rr?=
 =?utf-8?B?dHpSVmo0V2VLbTdHamp2RXhCK1dUdCtPUzhsVEZ5dEpmb0lIcUw4MnU3bXlB?=
 =?utf-8?B?VnM0N0hnMUhSRkJ5elIvT3d0TitraW1rQ2F3NFBVSjVIWUVDS01zSFh6cHY1?=
 =?utf-8?B?d1lFdzlTYUNFOGxGbDRQT1grN2Y3STdWajJwbzE0Rnp0N2NYS2J1REFnODFu?=
 =?utf-8?B?Ulc0VnZuZ0ZMalBuUU56U05ZNzhtUUhCQk01d2RkbzdIdUdsNlY5a095bFdp?=
 =?utf-8?B?aWJDS2V4ckdhYk5oK2xnRG9ZVWxNaGs0Y1N0bGFFZWxEQ1V6eW9HYTNkYkd3?=
 =?utf-8?B?MkUybVNPeWNyb3JIWmdvcnQvUHJFLzdHYzBTOEIyM0xNL09ORElGZUNOVmVF?=
 =?utf-8?B?bkVQdTMwSyttTllmR1lCMFZ1NHY4eldiWmlNVEhDcUF5bmFDTm1nQWVwQytC?=
 =?utf-8?B?aGxSR1RxS0ZMTzF4SUw2cTVyOEtJRHNndElzZGNjNGhYNFhwVURIMkdjVUd5?=
 =?utf-8?B?ck5OandFTkc3TVdDSzI4Yy9rNkkrdlNzOUZUSnljZE5FblhUdTdOaXp5WHl4?=
 =?utf-8?B?bk51WHFaTE0xNnNDVkZ0L1RtM2NWQW0yUysyWjVYQWRmZlNURHduTDRGTnR4?=
 =?utf-8?B?YWlXdUVwamd4ZjkzSmdlOVczaEZYVWtOQWhjL3ZsVEJOTERURzRMdHdVaXdG?=
 =?utf-8?B?Sk1kSDdGemM5WVNBZFNUS2RnYjYwTnVKWUtEcVpmQjlieTV6T1lCcmpkSDFB?=
 =?utf-8?Q?nHM0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03abbc8-fd05-4474-e21d-08dbce6fa670
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 17:45:13.1639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmLIiGhrYqdbO611ZQ8BT+o0zpWcoWW58FfBsMp2V0HMBRgFt8/aJipVI+kr8obMSfepDstZ7FAWpYtsSqLXwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiA+ID4gQWx0aG91Z2ggdGhlIGxpbmsgaXMgdXAsIHRoZXJlIGlzIG5vIGlwIGFzc2lnbmVkIG9u
IGEgc2V0dXAgd2l0aA0KPiA+ID4gaGlnaCBiYWNrZ3JvdW5kIHRyYWZmaWMuIE5vdGhpbmcgaXMg
dHJhbnNtaXR0ZWQgbm9yIHJlY2VpdmVkLg0KPiA+ID4gVGhlIFJYIGVycm9yIGNvdW50IGtlZXBz
IG9uIGluY3JlYXNpbmcuIEFmdGVyIHNldmVyYWwgbWludXRlcywgdGhlDQo+ID4gPiBSWCBlcnJv
ciBjb3VudCBzdGFnbmF0ZXMgYW5kIHRoZSBHaWdFIGludGVyZmFjZSBmaW5hbGx5IGdldHMgYW4g
aXAuDQo+ID4gPg0KPiA+ID4gVGhlIGlzc3VlIGlzIGluIHRoZSBtbHhiZl9naWdlX3J4X2luaXQg
ZnVuY3Rpb24uIEFzIHNvb24gYXMgdGhlIFJYDQo+ID4gPiBETUEgaXMgZW5hYmxlZCwgdGhlIFJY
IENJIHJlYWNoZXMgdGhlIG1heCBvZiAxMjgsIGFuZCBpdCBiZWNvbWVzDQo+ID4gPiBlcXVhbCB0
byBSWCBQSS4gUlggQ0kgZG9lc24ndCBkZWNyZWFzZSBzaW5jZSB0aGUgY29kZSBoYXNuJ3QgcmFu
IHBoeV9zdGFydA0KPiB5ZXQuDQo+ID4gPg0KPiA+ID4gVGhlIHNvbHV0aW9uIGlzIHRvIG1vdmUg
dGhlIHJ4IGluaXQgYWZ0ZXIgcGh5X3N0YXJ0Lg0KPiA+ID4NCj4gPiA+IEZpeGVzOiBmOTJlMTg2
OWQ3NGUgKCJBZGQgTWVsbGFub3ggQmx1ZUZpZWxkIEdpZ2FiaXQgRXRoZXJuZXQNCj4gPiA+IGRy
aXZlciIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBc21hYSBNbmViaGkgPGFzbWFhQG52aWRpYS5j
b20+DQo+ID4gPiBSZXZpZXdlZC1ieTogRGF2aWQgVGhvbXBzb24gPGRhdnRob21wc29uQG52aWRp
YS5jb20+DQo+ID4NCj4gPiBUaGlzIHNlZW1zIGZpbmUsIGJ1dCB5b3VyIGRlc2NyaXB0aW9uIG9m
IHRoZSBwcm9ibGVtIHN0aWxsIGxvb2tzIGxpa2UNCj4gPiB0aGVyZSBtYXkgYmUgYSBtb3JlIGZ1
bmRhbWVudGFsIG9yZGVyaW5nIGlzc3VlIHdoZW4geW91IGVuYWJsZSB5b3VyIFJYDQo+IHBpcGUg
aGVyZS4NCj4gPg0KPiA+IEl0IHNlZW1zIHRvIG1lIGxpa2UgeW91IHNob3VsZCBlbmFibGUgaXQg
ZnJvbSAiaW5uZXIiIGFzIGluIGNsb3Nlc3QgdG8NCj4gPiB0aGUgQ1BVL0RNQSBzdWJzeXN0ZW0g
dG93YXJkcyAib3V0ZXIiIHdoaWNoIGlzIHRoZSBNQUMgYW5kIGZpbmFsbHkgdGhlDQo+IFBIWS4N
Cj4gPg0KPiA+IEl0IHNob3VsZCBiZSBmaW5lIHRvIGVuYWJsZSB5b3VyIFJYIERNQSBhcyBsb25n
IGFzIHlvdSBrZWVwIHRoZSBNQUMncw0KPiA+IFJYIGRpc2FibGVkLCBhbmQgdGhlbiB5b3UgY2Fu
IGVuYWJsZSB5b3VyIE1BQydzIFJYIGVuYWJsZSBhbmQgbGF0ZXINCj4gPiBzdGFydCB0aGUgUEhZ
Lg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIEZsb3JpYW4uIEkgd2lsbCB0YWtlIGEg
bG9vayBhbmQgYWRkcmVzcyB5b3VyDQo+IGNvbW1lbnRzIHNob3J0bHkuIFNvcnJ5IGZvciB0aGUg
ZGVsYXllZCByZXNwb25zZSwgSSB3YXMgT09PLg0KSGkgRmxvcmlhbiwNCg0KV2Ugd291bGQgbGlr
ZSB0byBtYWludGFpbiB0aGUgY29kZSBhcyBpcyBiZWNhdXNlIHdlIG5lZWQgdG8gc2V0IHRoZSBS
WCBETUEgYWZ0ZXIgdGhlIE1BQyBSWCBmaWx0ZXJzIGFuZCB0aGUgUlggcmluZ3MgYXJlIHNldHVw
IChpbiBtbHhiZl9naWdlX3J4X2luaXQoKSkuDQpUaGUgUEhZIHN0YXJ0IGxvZ2ljIG5lZWRzIHRv
IGJlIGRvbmUgIGJlZm9yZSB0aGF0LCBvdGhlcndpc2UsIHRoZXJlIGlzIGEgY2hhbmNlIHdlIHdv
dWxkIGVuY291bnRlciB0aGlzIGJ1ZyB3aGVyZSBvdXIgTUFDIFJYIGNvbnN1bWVyIGluZGV4IChD
SSkgZXF1YWxzIG91ciBNQUMgUlggcHJvZHVjdGlvbiBpbmRleCAoUEkpIGFuZCB0aGF0IHJlc3Vs
dHMgaW4gYSBNQUMgc3RhdGUgdGhhdCBjYW5ub3QgYmUgc29sdmVkIHVudGlsIHdlIGNsZWFudXAg
dGhlIE1BQyBhZ2Fpbi4gTm90ZSB0aGF0IHRoaXMgYnVnIGlzIGRpZmZpY3VsdCB0byByZXByb2R1
Y2UuIE91ciBRQSBoYWQgdG8gcnVuIHRoZSByZWJvb3QgdGVzdCBhbmQgaGF2ZSBhIHNldHVwIHdp
dGggcmVhbGx5IGhpZ2ggYmFja2dyb3VuZCB0cmFmZmljLg0KDQpUaGFua3MuDQpBc21hYQ0K

