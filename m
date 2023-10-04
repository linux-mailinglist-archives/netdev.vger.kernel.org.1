Return-Path: <netdev+bounces-38070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632C7B8DE7
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A780B2816DF
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50177224F2;
	Wed,  4 Oct 2023 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TQZKdQrS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD4224E9
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 20:16:19 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2053.outbound.protection.outlook.com [40.107.14.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9366493
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 13:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuwuJaZM7O1vMhA/MBOzjzjlRK0n0K8gIFRNT9bdIHV2zVWd9aJzyWxCWJzZKnKmk/KjpsBlLQPNSu+07HcNEJK2qrtIoV9rAPgCLXExn7H8I4mryxV4W6bDbM8Bq74aAWMIXTdjX7wysLdLZH3K7tewDxUKBPiSSG3toiiRYN2aABmc+BgY30ah/GyTUhS4sroVXaqPrMkMQu6qkKtyn5lV0x8RgcRMZDbQy4TFp9OLtu0Hqe2TcGJoNY+iaaFJvkQ77nTBs4o0FaHjx2FzASubbtmi3fefm3ufflWKqJEjPpBTbz5TVN0aDOcx8qGKp/MnfGUMr0Ow5+axa7e2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41dNlxvm6Onjw3KwhtdVSY98WSYh3oy4MtRT/c9JNOA=;
 b=b932D0/qtBQR1vIsBmS18413JIz1Wy8osCfKrPvQ61AicPb6fILyd8vHqVp9t+bsWEjfQHub2joab7XI7WAWp6oNjCBS7BMWQY6+936bA+ed6NoslefRWezFvNJq7t4IH6+GEZjXI1XVAYD9NS1WDPcvXzZFFraxMgTVha1tza/qMRYsUBnG2T78cvTKMCIt59yS1a/ydDVG/P4byVibamOpKZyYjJg5mDGWOftniLdjIqubq3i0pEKDxmlsxTTELL64bHSUShHZy+D82oqS8Cp+Wx92KzLt87Rt1hJleFV1IA+lA4zm+Lqj9mmJwFz3Gxfx6GhItoYydBEBYqUmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41dNlxvm6Onjw3KwhtdVSY98WSYh3oy4MtRT/c9JNOA=;
 b=TQZKdQrSbyVV7KZexgXNEF4+FotcuLG/4M2d29H3hOnhzW7W8Or+KsKvqTkfqZqCTLMcqyKTwPyJZgylZmL8o6esXUBMvEaT9I4+QuXKG70bVYOCs6JrA+KhO1YKStIf5GGnErpHJAjOm2hkU/3Cezbk6l2C81AEEyJnVMDa91o=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB8134.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 20:16:15 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::6f63:8268:88c3:2ea]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::6f63:8268:88c3:2ea%7]) with mapi id 15.20.6838.029; Wed, 4 Oct 2023
 20:16:15 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Mario Ignacio Castaneda Lopez
	<mario.ignacio.castaneda.lopez@nxp.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-imx: request high frequency mode
Thread-Topic: [PATCH net] net: stmmac: dwmac-imx: request high frequency mode
Thread-Index: AQHZ9v+gntyZFqRF/kuJJRljU8l37A==
Date: Wed, 4 Oct 2023 20:16:15 +0000
Message-ID:
 <PAXPR04MB918574D60B71B5B36C2429AC89CBA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20231004195442.414766-1-shenwei.wang@nxp.com>
 <643c55ca-4eca-4dfc-9176-cf46c2504057@gmail.com>
In-Reply-To: <643c55ca-4eca-4dfc-9176-cf46c2504057@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB8134:EE_
x-ms-office365-filtering-correlation-id: dc9c5d2c-0181-482e-a5d6-08dbc516c31b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 j939ZpkLj/JTMeCqw4ra2zdyvVAbyb+ijnN25Yzj6+PhdkoxAaowNYm1HkzvhN3AbSofd3bpT4nxcOF0wBT4ikiMdxwxhfYshh4CycFVMVYWER0VopxkxP3JKcMw2QNDYpSrkfNTlBkYlEoFzfslLmyd+ustdjDio8SN35TOKCtYfFfa8ubXqoMG/11au/UqRtpKdEoKu3ECVPlZEEGeUsT6LliyTgKjHFSn+CP9r9IO4gG9gqdCpYIrYVEm0wM9tZMgX/i99E2G2LqbIQuCpMfJqva/7Qh6+KhCHlOdUmhZTK/P2UA+2HKT9B/bFGt5pg4N2wBVlZi5Gx/byqaXvjWID69Qf/PksDm/PrppFIXah2A5GHK0cAJ0mug0VI3dLG1ZAMwmn1lE/kyHfIYpuXx8Ho06b8Qo2EMPceKN4loIrKPOZF9BQwHXSn0Arv1wqO6BPrWK8kC4/wSIWfk6fVzoSwbyUj3NslDolspgDALlHK4LCI7FLMRMlVEvgwbeUmZHtwjLAURfn5uFkQKSvIhZB9iGQcIPDha0kqqUuSWkAOJgmPsYH7gZkhD1qpdiXXlDtssBvvwSSX7EtWHEzwg2C5PqVmzQSADRUreaFwYZmXOL20Gw2T76qVyu3Co9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(7696005)(55236004)(478600001)(53546011)(71200400001)(83380400001)(9686003)(26005)(41300700001)(7416002)(2906002)(4744005)(110136005)(52536014)(5660300002)(44832011)(66556008)(54906003)(66446008)(66476007)(76116006)(64756008)(8676002)(4326008)(8936002)(66946007)(316002)(33656002)(86362001)(38070700005)(122000001)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzF6VkQ2RmFSeXdTbmExM1AzQ3E4blIxQnhGQWJOek9ROU8vR0VQSFNsbXpX?=
 =?utf-8?B?TnRqKzlyZnptZWVyYVZpanZtMXFXakVGV0ovc2J5UDJoTEZjMFV5ejl0Wm1E?=
 =?utf-8?B?N1hNY25uV0FjVmUvbG56b3pYNE1qUFNJSGt3SmpaOXZkSFJPTitrSS84eEJ1?=
 =?utf-8?B?WmY5S3hVUC9QOG0xdWV0ajJaYmMrZzdXTENiT1E1VVF3QUFRcUVxNUlzR203?=
 =?utf-8?B?dzFCWXBod2RlQ0t2cEMvcVFRaHlDRTlXaXA2cmhobFB0SWxZR1JBWkdNOS9V?=
 =?utf-8?B?bkNIQTM5ZkhBYWczUDRpQm4zTFVDQnBROHNIQVlVWHg3Q3B1MEFlcU1JL0Fr?=
 =?utf-8?B?V1lkMUxZNjBuc0o2ZDJjTkZOb2RQeG5GWWlaL1pPUzJIVWxMV2FEaUlwN0pM?=
 =?utf-8?B?ZFRoWHc3MTNCY3Qxd29mZklnVVpSSTh2OEN3ZHN5c0NxMDYvekR5KzhkQlJz?=
 =?utf-8?B?NXo5bDVkMGF5a1M2MWN2NjhGWEYwNHBvV0hyQytDUVdjaHkwV3VJaWJQVmow?=
 =?utf-8?B?M1dPWGYvdndSQ0ZGZDl5V3JMZjZhVjl3bDBlVkgxaGNmWWxsS3NuK1ZaanNy?=
 =?utf-8?B?RVVCWWxmUndhcGQ5TzF6bS95dUs4WGQ1b1BNM0Z2Vm9NaEphQjNoak9CUEhZ?=
 =?utf-8?B?V1pVcS9RUklmdEMxaVlaaWt0ZGZFK1hRL1hsSk9jVTVxc3pUeERXM0NmcGpF?=
 =?utf-8?B?OUF1alM1SlRhZExSN3hLT0lsTVBOLzk5MFdrVHd1MFRZVUhMNmorTVZsclpH?=
 =?utf-8?B?b0xJMm5yVzN4ZDdJQm9QQnVQamN1cDgyVGlvOFBoTU9TZ3pRbzhUcTBmZmlC?=
 =?utf-8?B?akxtV1JMWlZnQmFpMyt0VW9rL3VleG5KWEtUYlJiUmRaWkRySHAvRG9RNXZ0?=
 =?utf-8?B?OUlxeVJaUk5nUkUvaDdUekR1YWNFb3hIN0crd0tEUEhGb1RIWk1Pc1BjZ1Zn?=
 =?utf-8?B?dlRNM0xES1l6T0RlRmsySVcrTE9DUEI5cWhEaVQzaFlCczBQOHJXZWhKT3BY?=
 =?utf-8?B?M3p4Z0xrQkkrWGpkM2FPcG5yV040V1NFZzY4anlBandDNkZIS2R1RUsvZjZX?=
 =?utf-8?B?R1Z2Yzk5UGdWMnZTbHcwZWx1R2ZrdDV0alNaOTZ2eHh2R29EMi95M2pHMFdx?=
 =?utf-8?B?QXBuQkJ0bWNqWXZNcWs0aXhrelJtTW5BRDZkS0JlWVRIZWJZMUNkdFlUZ0dq?=
 =?utf-8?B?RkUzM0c4NTFsVGhZbDM2Tks4Sk9IVnlZaGtyK1NKOFpXeHV4ZVlTQ1AwcmND?=
 =?utf-8?B?eS9EUVI0NUZWK0tYaFhGRTVtSlJuWEh0ZDc0Yjk0dlZJa3h1ci8zYStGSFFl?=
 =?utf-8?B?VjNubDQvMk1lRnQzVFhuRzBEMGV3djZ3TzUrenVtdnVlV0xaOG4wVEFuQUJH?=
 =?utf-8?B?NFNiR0xCY3JOZ24vMVBWSmg0UC9ZREtCZTd2V3RpR1NjYTlHUWR2SzQzdyt2?=
 =?utf-8?B?d0hQeFdQbnZ3cnlWRU0zczE1U2kxcHAvNXVpd3ZzTjVUR1lrc2R6cmVveENk?=
 =?utf-8?B?a3hOVVB4M2pyQ01aK3NXZFBqcHFoWldXbDVGYTJtODF4eXNoakNaYkJxTTZR?=
 =?utf-8?B?OUM5WkRwVUFSVFZ5VW40ZjBnRDBwVFQxekVKdmtwaThJRlp3K2krRjVUdm01?=
 =?utf-8?B?M3JpL2IwTkhjZWpCOGpXYXBaVmt1d29WS0ZVYWE0cTVLdWFoWnhrSkZRWGM0?=
 =?utf-8?B?YUZxZEZWWlBNcngvRWZwb1E5VWNYM3VhZEVJcHcwL2E3T1UxZCsrNVNnSnJu?=
 =?utf-8?B?aHFtN3YrSVRic1ZhRVg4NFFJb1h2ME1IV25Tb09XNWJvNTZlUjJoQTVuZk1Q?=
 =?utf-8?B?dklySVp5bEoyazR3QlhMdWFjRS8yTlFiMEIrL2YwdFZCS3QwcVpDVjVQZnZw?=
 =?utf-8?B?YVNhdXNLL0N3TjVzWjExclkrRlUxMjJCeEJoek9PKzRXWjFqdVFkVE9HOFU2?=
 =?utf-8?B?NWluTGxiR25aaWFZZlA1Y3JGMzVUMjYvUnU4NE9qdUM2Q1laMEVEeEFkK0ZG?=
 =?utf-8?B?MFhiajZEZnl6ZWFYMklxYlRwRCs1SUhiMlZ1VEJNVGtmdWJoV2JuWUcvNlJx?=
 =?utf-8?B?V2w3blB0MythNUpxWFlIOXVlZDNMUStLTXZudW16VlhVZnVEc05PbVZZcmFX?=
 =?utf-8?Q?oqOxQD3mmibtjqTbhc9bC3Lt5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9c5d2c-0181-482e-a5d6-08dbc516c31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 20:16:15.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urbQFr8w3ndDxloHuJVkcaXyZyNs4sx2KXICv2YKJaQZR5+KNTkr8WXhfjQfBKcHRaQtOAKbPRLMJ8J4ELCCgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8134
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZsb3JpYW4gRmFpbmVsbGkg
PGYuZmFpbmVsbGlAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgNCwgMjAy
MyAzOjAwIFBNDQo+IFRvOiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0BueHAuY29tPjsgRGF2
aWQgUy4gTWlsbGVyDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gQ2FzdGFuZWRhIDxtYXJpby5p
Z25hY2lvLmNhc3RhbmVkYS5sb3BlekBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZW53
ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54cC5jb20+DQo+ID4gVGVzdGVkLWJ5OiBNYXJpbyBDYXN0
YW5lZGEgPG1hcmlvLmlnbmFjaW8uY2FzdGFuZWRhLmxvcGV6QG54cC5jb20+DQo+IA0KPiBJIGFz
c3VtZSB0aGF0IHlvdSBjYW5ub3QgZ28gZnVsbCBkeW5hbWljIGFuZCBhZGp1c3QgdGhlIGJ1cyBm
cmVxdWVuY3kgYmFzZWQNCj4gdXBvbiB0aGUgbmVnb3RpYXRlZCBsaW5rIHNwZWVkPyBUaGVyZSBt
YXkgYmUgYSBuZWVkIHRvIGFkanVzdCB0aGUgYnVzDQo+IGZyZXF1ZW5jeSBwcmlvciB0byBzdGFy
dGluZyBhbnkgRE1BIHRyYW5zZmVycywgb3RoZXJ3aXNlIGR5bmFtaWMgZnJlcXVlbmN5DQo+IHNj
YWxpbmcgb2YgdGhlIGJ1cyBtYXkgY2F1c2UgYWxsIHNvcnRzIG9mIGlzc3Vlcz8NCg0KT25jZSBC
VVNfRlJFUV9ISUdIIGlzIHJlcXVlc3RlZCwgdGhlIHN5c3RlbSB3aWxsIG5vdCBjaGFuZ2UgdGhl
IGJ1cyBmcmVxdWVuY3kgDQp3aGVuIHRyYW5zaXRpb25pbmcgdG8gYSBsb3cgcG93ZXIgc3RhdGUu
IA0KVGhlIGhhcmR3YXJlIHN1cHBvcnRzIGdsaXRjaC1mcmVlIGZyZXF1ZW5jeSBzY2FsaW5nLCBz
byBibG9ja3MgbGlrZSBETUEgd2lsbCBub3QgYmUgDQphZmZlY3RlZCBkdXJpbmcgYnVzIGZyZXF1
ZW5jeSBhZGp1c3RtZW50cy4NCg0KUmVnYXJkcywNClNoZW53ZWkNCiANCj4gDQo+IFJlZ2FyZGxl
c3Mgb2YgdGhlIGFuc3dlcjoNCj4gDQo+IFJldmlld2VkLWJ5OiBGbG9yaWFuIEZhaW5lbGxpIDxm
bG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbT4NCj4gLS0NCj4gRmxvcmlhbg0KDQo=

