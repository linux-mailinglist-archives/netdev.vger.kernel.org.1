Return-Path: <netdev+bounces-19703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DBC75BC59
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 04:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265651C215DE
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 02:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF937F;
	Fri, 21 Jul 2023 02:35:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A07F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 02:35:46 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2081.outbound.protection.outlook.com [40.107.15.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02B4211B;
	Thu, 20 Jul 2023 19:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW1m+EcUDgj+k40dYeQPRSEbbA5YVdmWPBF7rOYa5tRS/HRnLB6GAwPtG9sjWtWcMhpFJ4DZU9B8Bdv8pN8JJ/LfBEHJv8ub8M8Dcj7MJHXSwzWavu4EGhAOLXxXFeGHkySEuUMhoscc7L6OtkyQ7WErztHoeQviwXnC13yn4FUbIxg46zMO4nhKhJfWoKPBzq1wLHv4GrTzERl+LQSn5lrj2b5CwhgusrYZWspdiW3lnF1Ay9xITCu7eaLIDII5mDzvNZ8IiG7S1uw31HCpHnsQLCwDyfH7HJpWabq6IRh07bOqoigtv+rPY1nQBU4i9dh34JaqpOzm9pm/rmrTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSHr/iafwapBCYg3WoDzsCVjZJ/Xt95Wg7N8ZyYWj3w=;
 b=A1+VotnISkkcqZi6gPZUptcae03P+bZBp9moDBRoj69xEE8yDfPUyiDVPdHSKT19qWg5S77rKwBv/AUxrRtxcfcgchfz4gCxIgSwr4JIRkxvuAucIoPpQZ92bZ+wzytdLfHy7pQL7X6lvQtSisNjvtNSd/F4eUSWU8BeBejWxZTaA1HBQD+p6iNyJm4AMLtCTHBrjPA7Wdu7zJoT7xuAvi2/XaDNDkwT0iqZbIxaobp+YssQesnPjIAjvhS3zBiYWCqIQyDD2IWThIf/Cskzmii4E5+rIY505mrJ1tiJOW0sPK+B3H1fEdU7VF4SgU5PXwzAlLeiMsdS9MQcWes2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSHr/iafwapBCYg3WoDzsCVjZJ/Xt95Wg7N8ZyYWj3w=;
 b=ZBo41L9O1NXHYLo1MtlIOxg5I5GwuzTiRk1EsyAXpYeh3qqeW5Q19kh8mc7ep8uh4wIhuOTmywTRzbd/9V+GDEtxbRELMvaLL2RL5EJrm8o/zCUIs51liWK2I6sQxXU2KF1FLxVObHEKs0aSXTD5RmKNJLfoWVoh+Td51ZBIU7A=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 02:35:41 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 02:35:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH net] docs: net: clarify the NAPI rules around XDP Tx
Thread-Topic: [PATCH net] docs: net: clarify the NAPI rules around XDP Tx
Thread-Index: AQHZuyUkcnIl2SClQESpEUnlGQ6wha/DgMyg
Date: Fri, 21 Jul 2023 02:35:41 +0000
Message-ID:
 <AM5PR04MB3139FC41B234823EE28424E2883FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230720161323.2025379-1-kuba@kernel.org>
In-Reply-To: <20230720161323.2025379-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AM0PR04MB6900:EE_
x-ms-office365-filtering-correlation-id: 5612f47c-92cc-4a9d-baf0-08db89932d71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NyOxYyT9j81wBqIzC6ltFuVpOJRtvfxt5J1f/PJ4nRuD4KibKny7MQulzUL2H2JQUt/AJOlqBspQt3w6MHM2tn6rAkvi18IDh4dgB/mFrIrLoh903PxY2AJts9SI9TCbbL+9eaNcsGQg5dc+FLKuUyAhKor+Yenv6CCVUYbkBP6jsCBeyS+IfnQGRgwe2yJM2ceJmVyctVpX8aYW32yFcQjTrPcPTuVCoiL3qI7UUykqJ2dwoWWFm4KZjpPCUCIaftWYfMwzTq6eM8k/eDfZswWwMSkFoy/mDOcTuj1zL3avq0OGQueBtQWQZeOrgb4Z5jstui0tDH9GYaO2CbCE6k14qCfgZOFlDsYzMOM4mkClDYG33Gt0xTyGzXMj0QoBJ0lYVSKWW+3OuT0OiEO4l37hbd/QlLg7OtIBzPjT0Pblik7VPo68rCEXMFz3OeqlQ+gMf89ZPaNm60/4JT5SV/AuO5T+uivCO+2Eb+hx7nVtOC7QPBD/muMfgxSOsJGiuU37OiREoEixXTCNO9uYSbJyo6BZpAuywdnp+vgda2aTgGFI6PWAYAywadob7jK5hPZU15im0G8pVMOicBr2SDCGXtm84yBQH02xh+vtNVgP7xF71affhy6l7Avhf+aA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(7696005)(41300700001)(52536014)(44832011)(6506007)(53546011)(54906003)(9686003)(26005)(6916009)(186003)(316002)(5660300002)(64756008)(66556008)(66946007)(76116006)(66476007)(66446008)(4326008)(478600001)(86362001)(8676002)(8936002)(33656002)(71200400001)(2906002)(38070700005)(83380400001)(55016003)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dEdYYXdSK1M2VmJzcDdlNGYvaG1MSytOMndpMGdjTTdVM24raXJ6blliaHIr?=
 =?gb2312?B?T3JQcmR1WWpxZDJHWEc3cS9Cb0hvS0NGRk9mZWhyM1FYQkdQSm0xTFpJN3dw?=
 =?gb2312?B?T2YwZHdEMG5kd01OaVBodGlZOUU5eFVZRUNheVdEVTBIRWZqV050T043MXVu?=
 =?gb2312?B?R0hrMjgwM1VmQTNiZmVBOW9ISm4wdWkwOHVDYWFuOEdhVzNWdlkyTzh6dDdH?=
 =?gb2312?B?L3FGS0V0K3BxbGlpSFhlcFAvMDk1d0sveGFXVUpZbkYzMTFsOUtGakxNdUR0?=
 =?gb2312?B?VGtWdHkzMVpydzZQYjRXczhPa21DQlNZU2R6cERtci9VNFdiREJlSUlXOWtE?=
 =?gb2312?B?b2MrVUFKSnBhTGNnZnNqcWJDVFZWZVJ6ZVo0a2l0NGVMZlZ4d0JjWGFWOFBr?=
 =?gb2312?B?SEtKNlB4MzdRM1FzMzJ4ZllNNnVWcGoyNkx3V2prbE9pazlhM0Vha0UyQ1Yw?=
 =?gb2312?B?amt0c0JvU0xSR0ppRjlFbStvek0yNURJM21LSWpWYmg0b2d3c1I0bWpabzY0?=
 =?gb2312?B?eEtMSXlVTjErS0x6MVBkWEw3VFkwVzNrRm10OFY2NW1jNHJiUExHZXc0UlVR?=
 =?gb2312?B?ajc0TDVpaE1hMTU4RWV0NkNuY1p5OVpCcVR2eUFnS3BCOC9zR1E5MWw5NXNj?=
 =?gb2312?B?VzlIVENtR29IUjBLSGltR2pSZmVZTlFrTWJ0RGFrVm8vaThyNy93VnVDa0FI?=
 =?gb2312?B?MDkvUGJSaFNzeDkzWlVIM0lhb2tPU0dzem1XN1R1N3FJbU51WlBIZkl5UlVu?=
 =?gb2312?B?NysvY3RIZlh3OVgyZ3JqcEd2V20rSGpvbDg3Yi96Sm9zbk4rNVpmRnV3dkEx?=
 =?gb2312?B?WlJ6THF4a1FQV3hlMXlRSlhiVFZWenZ3dE5GWldzOWZUbGRuV3hFdmtRS3kw?=
 =?gb2312?B?cm5TU0FUdlhadnhIS3dDWHg3WXhIZHhQSTZya0QwKzVvbU9zczcweS9FMmNj?=
 =?gb2312?B?QTEwNEZPUEhyY2JFWU9rKzUxbkxkbGcrOHlVMFdaVUNxVjJqd3diKzhEdFZS?=
 =?gb2312?B?YjZPanc3elFhaHJqMjVyMk00NnBPNEZ5VzVtTlRDT3F6d2V0Qk93d1gzcEtj?=
 =?gb2312?B?cG9WKzhlSXY4cXlIblI3clVNSUNYM3NOSVZoVkdmNkd4dWx1UXNDMVNvMTVt?=
 =?gb2312?B?TmJaREhyVDR3ZEk3TFpzVzZjb2pYVmpWRlo3SDUveS9GZXBUVU96K2d0dDM1?=
 =?gb2312?B?aFcvcFVQN1FPcU95REdlbzYvbU9YVmM0ZGZZVm5UVUp4Tkx2MVB6T0dReDRK?=
 =?gb2312?B?UUNRWW4yYis4ZXRId1hkb2FNTGl6M3Y3ZW9BNEJxUmRYU0h0cys2UkI0YkVC?=
 =?gb2312?B?TDhZblk5bnd5ZXFwYWtnRGVOSjFNdVVHNGhjdlhReGNjV2hFTjR2NHhmU3Bw?=
 =?gb2312?B?cklZeGJvQmR6d1pFV3l5NERmNFlndjlUdEt2SmxLQWVZNHE5RS9oYnp2ZEtP?=
 =?gb2312?B?TTZKc0Y1L3l5OTJkSTN5UkRYU0FHRXZuK2xZYzBuTTJscERxanUzek9rd2lV?=
 =?gb2312?B?a2ovNzBvUG01NkNwNVVKbnFKejNjUzlpdkMrNkNHTUtLK015bjNzSHRxZGJn?=
 =?gb2312?B?WmJ1dmkyaEJ6VE1iMW10Yk5wSm9TMzd1ZXhTcnFtWmRHR3o2VjZ5TEtJZXpm?=
 =?gb2312?B?RFJYMEhVR0hSY0xrdllkejhvRUxGekNOa1d4d3dXVEV2N281SUQ3TWV2UmR3?=
 =?gb2312?B?YjFIMlM3Y2Y2Lzd6U20yeFlHSDlxdFFPKzBPc080eHQzUzNlczBnNGZrVEFO?=
 =?gb2312?B?bnpNbFhyMEtUbXlhSWMxck1jaUhUaG10SVBkWmdqR3V0WFFIZDhxaGNOL01M?=
 =?gb2312?B?ejFpeGVYRzFWVkVtNmkvU2NQQWZxSThQZUVwakltaStrcUVWeFBucXpCS3p0?=
 =?gb2312?B?cG8vdU9sZjZjcENxbjR0YmZHd1hBZ25EZ2EvRUNYb202MXZwWHljVFR5Sm94?=
 =?gb2312?B?NlZ0cFhvcFhMUUc2VmZzR0hwZUMvY0c2WWJ1cTR2T1Z0RS9sZUFZV1NEKzZn?=
 =?gb2312?B?NkR1Y3I5S3YxT2dLblhhaFFQL09UOXg1YlpabDZSRkdWUFlDaE9BNjJxWVYr?=
 =?gb2312?B?NzdZaVBqcitoZCt5V2Rha1pNWEtPKzFlalZna0VzVlhnNWZZR1RQNGl4MG1V?=
 =?gb2312?Q?KNVs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5612f47c-92cc-4a9d-baf0-08db89932d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 02:35:41.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpHB2J2r83IECTznuVW5bDZ55dJr9dncvTne6nLfS6TKeJmRyUq6g/ou6svVFV4RBQPAezmVERPTscLwjU7+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6900
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOo31MIyMcjVIDA6MTMNCj4gVG86IGRhdmVtQGRh
dmVtbG9mdC5uZXQNCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGVkdW1hemV0QGdvb2ds
ZS5jb207IHBhYmVuaUByZWRoYXQuY29tOw0KPiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwu
b3JnPjsgY29yYmV0QGx3bi5uZXQ7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogW1BBVENIIG5ldF0gZG9jczogbmV0OiBjbGFyaWZ5IHRoZSBOQVBJIHJ1bGVzIGFyb3VuZCBY
RFAgVHgNCj4gDQo+IHBhZ2UgcG9vbCBhbmQgWERQIHNob3VsZCBub3QgYmUgYWNjZXNzZWQgZnJv
bSBJUlEgY29udGV4dCB3aGljaCBtYXkNCj4gaGFwcGVuIGlmIGRyaXZlcnMgdHJ5IHRvIGNsZWFu
IHVwIFhEUCBUWCB3aXRoIE5BUEkgYnVkZ2V0IG9mIDAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBK
YWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gQ0M6IGNvcmJldEBsd24u
bmV0DQo+IENDOiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgRG9jdW1lbnRh
dGlvbi9uZXR3b3JraW5nL25hcGkucnN0IHwgMTMgKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvbmFwaS5yc3QNCj4gYi9Eb2N1bWVudGF0aW9uL25l
dHdvcmtpbmcvbmFwaS5yc3QNCj4gaW5kZXggYTdhMDQ3NzQyZTkzLi43YmY3Yjk1YzRmN2EgMTAw
NjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9uYXBpLnJzdA0KPiArKysgYi9E
b2N1bWVudGF0aW9uL25ldHdvcmtpbmcvbmFwaS5yc3QNCj4gQEAgLTY1LDE1ICs2NSwxNiBAQCBh
cmd1bWVudCAtIGRyaXZlcnMgY2FuIHByb2Nlc3MgY29tcGxldGlvbnMgZm9yIGFueQ0KPiBudW1i
ZXIgb2YgVHggIHBhY2tldHMgYnV0IHNob3VsZCBvbmx5IHByb2Nlc3MgdXAgdG8gYGBidWRnZXRg
YCBudW1iZXIgb2YNCj4gUnggcGFja2V0cy4gUnggcHJvY2Vzc2luZyBpcyB1c3VhbGx5IG11Y2gg
bW9yZSBleHBlbnNpdmUuDQo+IA0KPiAtSW4gb3RoZXIgd29yZHMsIGl0IGlzIHJlY29tbWVuZGVk
IHRvIGlnbm9yZSB0aGUgYnVkZ2V0IGFyZ3VtZW50IHdoZW4NCj4gLXBlcmZvcm1pbmcgVFggYnVm
ZmVyIHJlY2xhbWF0aW9uIHRvIGVuc3VyZSB0aGF0IHRoZSByZWNsYW1hdGlvbiBpcyBub3QNCj4g
LWFyYml0cmFyaWx5IGJvdW5kZWQ7IGhvd2V2ZXIsIGl0IGlzIHJlcXVpcmVkIHRvIGhvbm9yIHRo
ZSBidWRnZXQgYXJndW1lbnQgLWZvcg0KPiBSWCBwcm9jZXNzaW5nLg0KPiArSW4gb3RoZXIgd29y
ZHMgZm9yIFJ4IHByb2Nlc3NpbmcgdGhlIGBgYnVkZ2V0YGAgYXJndW1lbnQgbGltaXRzIGhvdw0K
PiArbWFueSBwYWNrZXRzIGRyaXZlciBjYW4gcHJvY2VzcyBpbiBhIHNpbmdsZSBwb2xsLiBSeCBz
cGVjaWZpYyBBUElzIGxpa2UNCj4gK3BhZ2UgcG9vbCBvciBYRFAgY2Fubm90IGJlIHVzZWQgYXQg
YWxsIHdoZW4gYGBidWRnZXRgYCBpcyAwLg0KPiArc2tiIFR4IHByb2Nlc3Npbmcgc2hvdWxkIGhh
cHBlbiByZWdhcmRsZXNzIG9mIHRoZSBgYGJ1ZGdldGBgLCBidXQgaWYNCj4gK3RoZSBhcmd1bWVu
dCBpcyAwIGRyaXZlciBjYW5ub3QgY2FsbCBhbnkgWERQIChvciBwYWdlIHBvb2wpIEFQSXMuDQo+
IA0KQ2FuIEkgYXNrIGEgc3R1cGlkIHF1ZXN0aW9uIHdoeSB0eCBwcm9jZXNzaW5nIGNhbm5vdCBj
YWxsIGFueSBYRFAgKG9yIHBhZ2UgcG9vbCkNCkFQSXMgaWYgdGhlICJidWRnZXQiIGlzIDA/DQoN
Cg==

