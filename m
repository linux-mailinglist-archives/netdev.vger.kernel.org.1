Return-Path: <netdev+bounces-13915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15F73DE8F
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 14:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21061280DC1
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED7F8BF7;
	Mon, 26 Jun 2023 12:12:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FA883B
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 12:12:27 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2084.outbound.protection.outlook.com [40.107.117.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A23110DD
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 05:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltokiLmdJzMzt5eGlSF2rg6k5rnNq7po4E6aVAPih/snInXu9jZJJFOWH5c2wWsUWBR0ynpzzV+Ajvwxnv6Lg8ci/FqylqxKhBU6qD420P7qYM+fDBIinM6KYULuI74Z91OAKqRUHwXN1dqyu6Zbb/0+i+aPIDQIUzmhAPgDxDVqfpaLdNjirSPz/6IokJZgSTXH7DmBVTHHz4PQabBG08EHWkoe0oNhsZEVByTk6Xigfgq0iSyckzc3Dlriy6tEj+LqV5GW0w2oxtPoUViy5nxombGsbNaLSNgGrprm4nxX93DUsO/jcDxaWzrV92c45dve9tITx4prFCNy4yDltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abEiZ6/Kbcq3W1FbzvrGwmD7h92xtnWF90gsvhlMgBU=;
 b=T1CK0Vq2OVLtuGYZ5fXuFBGUPNNMsE0+IBrA7OI5MIE89z8Amq+Mh++LALEiZLYj8IKZ8ZxyVWw1iU6GMJumn7oApZT6hVRVsQTe1JGZOV98G4eOtZZfyjpkhfpbSFYRPo21hd5Io59m0JyXC0AiBC2cK3xiyPyqar83uU/Vn0ZWvA9HUsnNnWIP54ePR/GpYftOkrYvxhifCPLBjTROj1A6YlJE7QW/FVLL/z4wEBa07llEdV1+PY4DTxZLAYEP3HcNLwbFkfqvPYFcYjuIpxDq815WDNWFh1NNYQWWxMEqVjx+8lE4Y6DIVy0y+xxvL2DQcwemoxRfJf8KiTg85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abEiZ6/Kbcq3W1FbzvrGwmD7h92xtnWF90gsvhlMgBU=;
 b=f5oe9Gpr8FZg734jv41DtHRopE0fkwdJdWnJ+G6Yj3h//tkYxQ8rc2F1FQj+B83FMse2z7DKW9NuLiE3xRXbj99TdRamlUtY3yobh5VvC1seefVHkMdy3LsghjuwyObu80mcwBV5VUnt3oYLy9789xtm/6cvZ74/G5kDBZDHik4=
Received: from SG2PR02MB3606.apcprd02.prod.outlook.com (2603:1096:4:34::20) by
 PSBPR02MB4455.apcprd02.prod.outlook.com (2603:1096:301:e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Mon, 26 Jun 2023 12:12:08 +0000
Received: from SG2PR02MB3606.apcprd02.prod.outlook.com
 ([fe80::3ffb:69e8:1ca4:2b0b]) by SG2PR02MB3606.apcprd02.prod.outlook.com
 ([fe80::3ffb:69e8:1ca4:2b0b%5]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 12:12:07 +0000
From: "Jinjian Song(Jack)" <Jinjian.Song@fibocom.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: "Minlin He(Reid)" <Reid.he@fibocom.com>, "bjorn.helgaas@gmail.com"
	<bjorn.helgaas@gmail.com>, "bjorn@helgaas.com" <bjorn@helgaas.com>,
	"haijun.liu@mediatek.com" <haijun.liu@mediatek.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Chongzhen Wang(Rafael)"
	<rafael.wang@fibocom.com>, "somashekhar.puttagangaiah@intel.com"
	<somashekhar.puttagangaiah@intel.com>
Subject:
 =?gb2312?B?tPC4tDogW3Y1LG5ldC1uZXh0XW5ldDogd3dhbjogdDd4eCA6IFY1IHB0YWNo?=
 =?gb2312?Q?_upstream_work?=
Thread-Topic: [v5,net-next]net: wwan: t7xx : V5 ptach upstream work
Thread-Index:
 AdmXp0lc6IJADlWQT5iWSDfvOhIbAgALNRCAA4PgOgAAAPGzAAB6gUfwAA1oCgAABDBlkA==
Date: Mon, 26 Jun 2023 12:12:07 +0000
Message-ID:
 <SG2PR02MB3606B60EC8E0645A4055048B8C26A@SG2PR02MB3606.apcprd02.prod.outlook.com>
References:
 <SG2PR02MB3606473ED18C4A0F105A25B28C26A@SG2PR02MB3606.apcprd02.prod.outlook.com>
 <20230626082018.15625-1-jtornosm@redhat.com>
In-Reply-To: <20230626082018.15625-1-jtornosm@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR02MB3606:EE_|PSBPR02MB4455:EE_
x-ms-office365-filtering-correlation-id: 189dac45-a307-4433-26ed-08db763e8feb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xGAfta8evPXMDKVdro6A6WaSziCKDz/GjmMvqyurKwFmVYCtHVMB4K2JuERqbCm/T9v3tf8gv0XN8uiK2XLR4tG0PXc++gAZz8fJgECyO+8u0CZyGUTMxWzshnvBSiQVnxHOZVKJj1MSUoB32SMHVkyW+klUBrkg0AJgx9s2VJPnGK5vXoHykNtmvlhD8skqArvk9q1f9Ol8tOrcHWxANpCMa/KcgmuzWZevg6IcxXriKgFUd10v5KOVPl3WbYbsbolJGTOXKlkVwNoSEbWaoAyJKsO+8KvLK+RgfsH2bob886IbFd/Y/CPqBljXbzOzfwkrqFC5MzjyPC2BOWR0c8pME/v/M3dLeQMM0cCoyVEc/Anzp5X7oLdOGmMcn/x+uVPJem8pEzvVMT4gr0La9xQOsW5fgINNdMhvAsiJgoRJQWxHtoVnUSFZbQAa/gizisdbUQLDbQA2Cf+bcoxtCfRTEEue0f0bQd2eviCVg0O5xFwYoz38oY6v4efAPmEBV27XuC5YuqvsQELoJWlLF1cPdn2XandP2Pdr2zlziUB4s2UwyqK/lFBwtbk+5VKRcoxZvbCQof54ipNY9ayJec4oaVUowbmtw4CVjo8JlGQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB3606.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(366004)(396003)(376002)(346002)(136003)(451199021)(9686003)(33656002)(66446008)(38070700005)(224303003)(52536014)(66556008)(38100700002)(122000001)(5660300002)(55016003)(8936002)(316002)(26005)(66476007)(86362001)(6916009)(76116006)(4326008)(66946007)(2906002)(41300700001)(64756008)(186003)(71200400001)(7696005)(6506007)(54906003)(966005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TGF2VXJzZGxOa2RKMEhzMFd4UWhPM2dBRG8xdThDdkJ6MkNiZDUwVkdzUnB0?=
 =?gb2312?B?RTk3UDR5VktoYnRCNlZSUG4zQkpXdEE1V2VNYnJKNjBHdW1jZjFybzhvTlpt?=
 =?gb2312?B?NEM2ajJ6WFo2Nk9GSVhKNUMyaVRiUG5TOGZhZ081RThlczZGa0FtYU5vMVNS?=
 =?gb2312?B?K0FoM3BnMW8yeXNkQ0MvbGdVU3pYN1NVWFlMUUdmWGdzYlArVUJwNUhMTTFH?=
 =?gb2312?B?QXpTc1FScVgxM0JGWnMveXRmdHAvdyt4L1pGaFZTUFFMV2xJTUZrWmFJbnA0?=
 =?gb2312?B?Vks4Z0N3VGc2UWk0ZVBzWWlCQWxTY1NTT1BFQnpqNVJzcTU4eVh3dEhrcW1T?=
 =?gb2312?B?NnhFUU16aFVBUG8vWUhCam5PY2hjL2NVdDdJdHBscHJJb3M1cGxUNzE1VkNZ?=
 =?gb2312?B?R1BVZFpQeHE0dnpaejVlYmg0bGxJWWVzSVJkczY2V1NQNlJLbVVzaklPZHVo?=
 =?gb2312?B?QWpJVDJnMWt0QzZ1eElxcjN0TnZHSnJvTVJva3BOWjh3Mi9HNXJaUW4zTDkv?=
 =?gb2312?B?UlZ4SzhrYzdnNW1VQlhKRFN4ZWFQN2tYelRka1JjeU9kTi9rQXNEeWZHTjhY?=
 =?gb2312?B?WXRXa1JmZ1FFbW1rYTZiVEthMGJuZ1ZKNlI4eWZxaHFnT2ZFMTBEK25UdktH?=
 =?gb2312?B?L2FKSHpNYVJZVC9nbjM0SkFCZ0d2QmFCejlOemtxTFo0M3MyMjc5UDU0NW5X?=
 =?gb2312?B?VVFXaHJDaGVlL05WZ2V2MXBRM2l2Q29vL0VpeWdYSUc0d2dvTkdrVFRhU01a?=
 =?gb2312?B?alMrc3dqM01ZazVJbUFvMFdjYjljZUY2T0NwMmZuTm5ac3JUTi9Nd0doczI3?=
 =?gb2312?B?eGlTckhpK0U1V20zVzd4bGgxcndlOTZvU3hzcnFSUHFjclFiQkJaUXQvd2wv?=
 =?gb2312?B?WjVGaTc2WkZrTzM2VmhnRHlRbDFlVGZzV1ROdjlVWGtLMDZWbGw3T1dqVkhD?=
 =?gb2312?B?STNPb1J5eGtIVDAxU3E0QzE2MFZoRzliUStCcW9yTGlZY3c3cFdDR0tnOHQv?=
 =?gb2312?B?Tm4ySWtOZDlYSVhaLzJGamVpVDhaUWh4Q0FvcEpWQmQ0VTlFaVZObnpaZzlJ?=
 =?gb2312?B?SjQ4RWtQL3pqbk5BMk9qNW83SFBFaW4rQzY1bEJvWmUvZTBEejZmakRFTGUw?=
 =?gb2312?B?TmkzK2lmQmYrYlp0RFV5bHZUakFvT3UreHYxSDdIL3VtWkVSeVl5Q1lvbUxl?=
 =?gb2312?B?VjVlQk1DNHVwN09IMzAzYWRvbGVUWXB0bDlhNEpjajFsSGFIcUtjTlBhcXJ0?=
 =?gb2312?B?azNldjJQUzRDc2tNMUpFeTRWR2VRRi9BTTl0RVpuTGRER3hrbTRGNjhObElG?=
 =?gb2312?B?SlE0OTZRNW85QmJkNHZhdk54MFcxZ2V2em03K0lSWGtwY2todHEwbnF5Ulph?=
 =?gb2312?B?VytObjVYMVo4SWMrV3NwSU5CMFRTWGZlQ1RUMENOTG5OQ3VyV3dSMGRrS1hl?=
 =?gb2312?B?eWROV0J0bnB1TUtuVEpWb1BlTk11akNUOUNqdzdtTWdaVVl4L1NwcWFSRUQ2?=
 =?gb2312?B?SlNNVGJ6WlA3NTZHOHJDRTVudkhlTlN3VmpPc0NkT2RBdFhSb0FnTHE0N0Uv?=
 =?gb2312?B?NlMwcTNZeG9wYnMwVWpROFdPdWpFaDY5L2t3WFVBYnR3RG4yWWhDdWVOZHpj?=
 =?gb2312?B?T2hEMGk4R3NPWG9mTWZpSzZ1TFg0ZWUvajRnaDRoSUp4SVBXTHJTTGZjUXZG?=
 =?gb2312?B?K0xwRnZuaUN0NUVGdHdHRFNNY053eXk0bGE3anRvWWhqUTM5Q3Y4VXJWalBU?=
 =?gb2312?B?b3VEZitVZG1nNm5IQTJvamRjVDMrNW9UQzFKQTBaL080MlpLNlFEYWVuUkZ1?=
 =?gb2312?B?UEFGMkFiQ3Nrbno3V09sT3AyNEY2SjloZFhLbFIxMUV0SWlERFBZUENEdE1W?=
 =?gb2312?B?T2xieGZXRCtSTHdsNk8rTnVENkN3TUZBbmFyWElkQ0NFWlpzaC9nQWQrUGdi?=
 =?gb2312?B?eU03RUxLaEh6ZlJwWnZVYU1rOTlNYzl1K3k2VUNZTU82WXhGUXA2RzFzK09u?=
 =?gb2312?B?S2dCZFdRNHF1Z2tuaUtCUy9UVFB0cUVvR1VUNGFGQUQxZXYxbFVFQVhiSkND?=
 =?gb2312?B?Ym1kTFkvUlU0VlpvNndnUUpzZE9sSG1DUkNiSXZKQ2dUNG1PMUM0ejU2KzZY?=
 =?gb2312?Q?f6iCUST3l/eNgAA7RM/Jxxosm?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB3606.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189dac45-a307-4433-26ed-08db763e8feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 12:12:07.7645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3fbxvGU9H2c7uJpnWDjATDlBV8Mmch3VzdINCOn1jLWmcury0GYlNadE9XqcddN52C/PVMM3+hTBImhmDiBRJU+/et0Ag6aafnwYcBbrXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR02MB4455
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgSm9zZaOsDQoNClNpbmNlIGQyMGVmNjU2Zjk5NCB3d2FuOiB0N3h4OiBBZGQgQVAgQ0xETUEg
cmV2ZXJ0LCB0aGVyZSBpcyBWMiBwYXRjaCB2ZXJzaW9uIGFib3V0IGl0LCBJIHRoaW5rIHRoaXMg
cGF0Y2ggaXMgbmV3ZXIsIGFzIHRoZSBsaW5rDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3Byb2plY3QvbmV0ZGV2YnBmL3BhdGNoLzIwMjMwMTA1MTU0MjE1LjE5ODgyOC0xLW0uY2hldGFu
Lmt1bWFyQGxpbnV4LmludGVsLmNvbS8NCg0KdGhpcyBwYXRjaCBtb2RpZnkgdGhlIGZvbGxvdyBp
bmZvOg0KDQp2MjoNCiAqIFJldXNlIGhhbmRzaGFrZV93cSBmb3IgQVAgd29yay4NCiAqIFJlbW92
ZSBBUCB0cmFjZSBwb3J0IHR4L3J4IGNoYW5uZWwgaWQuDQogKiBSZW5hbWUgdDd4eF9tZF9wb3J0
X2NvbmYgdG8gdDd4eF9wb3J0X2NvbmYuDQoNClRoYW5rcw0KDQotLS0tLdPKvP7Urbz+LS0tLS0N
CreivP7IyzogSm9zZSBJZ25hY2lvIFRvcm5vcyBNYXJ0aW5leiA8anRvcm5vc21AcmVkaGF0LmNv
bT4gDQq3osvNyrG85DogMjAyM8TqNtTCMjbI1SAxNjoyMA0KytW8/sjLOiBKaW5qaWFuIFNvbmco
SmFjaykgPEppbmppYW4uU29uZ0BmaWJvY29tLmNvbT4NCrOty806IE1pbmxpbiBIZShSZWlkKSA8
UmVpZC5oZUBmaWJvY29tLmNvbT47IGJqb3JuLmhlbGdhYXNAZ21haWwuY29tOyBiam9ybkBoZWxn
YWFzLmNvbTsgaGFpanVuLmxpdUBtZWRpYXRlay5jb207IGhlbGdhYXNAa2VybmVsLm9yZzsganRv
cm5vc21AcmVkaGF0LmNvbTsga3ViYUBrZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBDaG9uZ3poZW4gV2FuZyhSYWZhZWwpIDxyYWZhZWwud2FuZ0BmaWJvY29tLmNvbT47IHNvbWFz
aGVraGFyLnB1dHRhZ2FuZ2FpYWhAaW50ZWwuY29tDQrW98ziOiBSZTogW3Y1LG5ldC1uZXh0XW5l
dDogd3dhbjogdDd4eCA6IFY1IHB0YWNoIHVwc3RyZWFtIHdvcmsNCg0KVGhhbmtzIEJqb3JuLCBJ
IHdpbGwgZG8gYXMgeW91IGNvbW1lbnQuDQoNCkppbmppYW4sIEkgaGFkIGFscmVhZHkgcHJlcGFy
ZSBpdCwgd2UgbmVlZCB0byBoYXZlIHNvbWV0aGluZyB3b3JraW5nIGFuZCB0aGVuIHlvdSBjYW4g
Y29tcGxldGUgd2hhdCB5b3UgbmVlZCBmb3IgdGhlIHBlbmRpbmcgZmVhdHVyZXMgKGZ3IGZsYXNo
aW5nIGFuZCBjb3JlZHVtcCBjb2xsZWN0aW9uKS4NCg0KVGhhbmtzDQpKb3NlIElnbmFjaW8NCg0K

