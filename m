Return-Path: <netdev+bounces-31416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0178D6B1
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 16:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB4A28105D
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C356ADC;
	Wed, 30 Aug 2023 14:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3503D7C
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:55:45 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F1A198
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1693407343;
  x=1724943343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oQTBSwUe4rh2zn7AhRFqCVcy5kPwkUTVhBbQXE0NBB4=;
  b=p7RszK8h5WY2tf7S85AhVdYP/S2CEqdJtzhrahSD2mwrzJ2K1HEC8x3E
   AN4+wYPGCNw8Jq47jjrYJoxoeYFNUDCfMnBHZLH/9h89kmnS9mcTpSMaw
   FkKS9IUV85AxsAihrDVYdSZeW2c0C4LRy3CSicvUF+vwX2v93yINq9n2C
   yJBwf84sMKZcerRrQPT75HhPgse/orCVtq9Yv1jaYHbZYTskjzFAMZkpo
   izN88k6siFVj/CnUnvJhfXblgWJkn5cJQ/kCVUoxjmggQQjV8raYNLVoE
   fCxeBqOfuMTGFIp3eDs9JaLQTkvaGhQvabh5rD7Nkt5oIxRp4bF3XalEj
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV9/eO5UViN4wSkAeZaYP5DHFVDtsIBgJ0NVvj06em+3S2tDgWA1xEBYh748/a6P3rPbEPIzfO0v8LXE0JtvOCvBJw2RNZWpOysQ9ozPfrfxxob9lamnwuqoeWzwZHoJSMOpBT3PPFDT4Mv5+EDG0/U/WYC/anKFGnTCMGBmjFrnNn+NH7xyy1/+7sRzN9Q0/IvRPK8B48b9jcYZODlP7Y1v3a5ORXlZtiMrhy39I86xciSfsoo3yOdLd1GN9tL8Ml4rhTTiU0XuGIXXMoBb6IkQWZTeL9OIVYoKR0W72xcyphPqAMkvCCBqybIx0BOEd1u5HuktFwfkpQfyxuSpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQTBSwUe4rh2zn7AhRFqCVcy5kPwkUTVhBbQXE0NBB4=;
 b=MxgOXT//NgtB/MW9cDSForKN9hI3gMMWyA/QkyFs/xbhRvgabQSu9s1M6HIdtuswTF1Qei5GYFsD7sOHiYY9X1FaKPvvkqBRzHOKLZKm5A6mssSDOuDtKg+TPs3HJNSzlb9I9sRNMqKBaK1c7G194T9R5WSZObDwNuc7ZHX7EqaJxtbufw9yWUqRm5G/LQCiyjaYYysVNOQVpswc4mDMDL0I+KXGrfUtGt4jagA4ASATVRvqTH1sUCx7TPBtOlV6MVQMMWk3apejwePoRgtXSIZYDvGJzBmp6QJm8/qz6pUztfoqgmRWAyAT218KyA64AKFAvNp2wScf2PBnV3Ck3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQTBSwUe4rh2zn7AhRFqCVcy5kPwkUTVhBbQXE0NBB4=;
 b=Yqc+2skXNtF5tWs3qcAVxcgTTnFUQV5nVy/Q3uY976Fn0/0RhVYWJujqqogPG5hdQKIXCFZnVVZGrXI0V1ptiC674vZ1by5wo5dh9s2kyzIiykrm2ipNcWeT/+duxIx8wFeCbzvlGfj3T6A2ecZexz7Hk7yGJWJTnCa2pcUfV+o=
From: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To: "alexandre.torgue@st.com" <alexandre.torgue@st.com>, "nbd@nbd.name"
	<nbd@nbd.name>, Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "joabreu@synopsys.com" <joabreu@synopsys.com>,
	"peppe.cavallaro@st.com" <peppe.cavallaro@st.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, kernel
	<kernel@axis.com>
Subject: Re: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Thread-Topic: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Thread-Index: AQHWv04gJ8ZamJtkVky0JUyVF0YJta/+f16AgAK1/wCAAEHkAIAHrjMA
Date: Wed, 30 Aug 2023 14:55:37 +0000
Message-ID: <f3c70b8e345a174817e6a7f38725d958f8193bf1.camel@axis.com>
References: <20201120150208.6838-1-vincent.whitchurch@axis.com>
	 <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
	 <2e1db3c654b4e76c7249e90ecf8fa9d64046cbb8.camel@axis.com>
	 <a4ee2e37-6b2f-4cab-aab8-b9c46a7c1334@nbd.name>
In-Reply-To: <a4ee2e37-6b2f-4cab-aab8-b9c46a7c1334@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AS8PR02MB7771:EE_
x-ms-office365-filtering-correlation-id: 8f11e5e3-5012-442e-7f8e-08dba9692c06
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gVcm0lzLrxaAsOn3bzjAMT5bWwC6yIU+3uGuE2P5P1DRkftrExeeYDin7coHH8sUYYKuyaGuBEgeytORWz7joeLsKAH3hOEn1NzNKDcL80rU1Q8H2Czdu+mnN/dCBf+ZQqrTGoLLPJQMd9mWDRi5p771uDqooj3dAu/JMsCzoZ9sJGjkpgVOPfMA2k4Bm6YkWRvdms+v5JyVi5+k4myQO1LEAwKWo+VxXe9wpgH6nUWqKe5SkNS85mXuDCdepj1hXfD5UBybkQOGd/Z+OLDg9O0+zO1eJaFRr8b8UexNiQdNjG4tmzuYVOEQjCiMyOs+SqB7RopXeRunVRb8laZ3A0CRnt9ZTF+HW9bMJS2GDV85KXIoGI9rUO9zQXlzG3EqzLyO9xRGcgGReFU7pVffizEZ0aMAHlNR9QuU7pKlUBKKpyf3VqOqM3Y9Cv6qXyu59Gw5y1dHpvSt9zwMtUHAEG6dgIlICDS6BcFmOqLg0NTNClLyrlc5s0GupTiJgBCWh1gXpTA779SDxns3ovD0E/fuXX7H3AQAKVynR9+AXeUUeCXwCZgI26bKQQar6vHX/UaN55g4ZFviuZvT2wC15cCBhL93Ck9IWFBzicTQLRjf8pGnH/vNSFzaYsvLDzaL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199024)(1800799009)(186009)(36756003)(2906002)(66946007)(316002)(66556008)(110136005)(64756008)(8936002)(66476007)(5660300002)(41300700001)(54906003)(8676002)(66446008)(76116006)(4326008)(38070700005)(71200400001)(53546011)(6506007)(2616005)(6512007)(107886003)(6486002)(38100700002)(122000001)(26005)(91956017)(83380400001)(478600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWpyQ0xXbWM2UENObzhqQnB2S1BFc0JXdXg0MjVONjdWYjNKWUxYNFR1WUFQ?=
 =?utf-8?B?Z1BBQXFYZHZNZHk3SkFuMWI5bTVlSmUvYXZ5YTc5VjBKblVlUVBYYk1ieFR4?=
 =?utf-8?B?VS9Wb0ZpejIwNDhvTmloalFkUmRSM3pRYzRtSFlyZDVoK25LRjV1bzRhQ1Bi?=
 =?utf-8?B?UEF4THU2eHJCb2VnL2lFaG1vOC9aMEFBK0thZVhiSHZiZmlVTnFOTzB5bWVI?=
 =?utf-8?B?OE12VmlyV1R0VHN0TGNWUkhjTGJ5cWh1SG5MMGdrdi94dEZCNUkzeHlpMXdW?=
 =?utf-8?B?QUxOWnZTTzJuNFhIVVNLUlY0SzllYTlXNDVGUHlRRUVuVUF0ODNUYzlGamJS?=
 =?utf-8?B?MEFMM1RYRHdSc0tUQUxDUGFCZ3pENER1RE1WbmhubTJHMUdQRGNCUGsrSmJY?=
 =?utf-8?B?N3JoeWZscnB5WCswUjkxY1c2UkxSaXpmUEw0b0lnKzhva2grS1gyVVFndGox?=
 =?utf-8?B?UWJaeFl4TVpabWh1R2ZBWXhJZTk0bWJ6WUwyODFVYU96NDZzdVQ4dzFuRk1V?=
 =?utf-8?B?MHhNdGZqMjVMOGgvS0lFcG1tbWFYc2s5LzZNUFZVOWhLeno0WVBzaWdxU01x?=
 =?utf-8?B?cVpYaGdNTm5lWmIySGRVenM5Z3NMMXFTclFSeTdwTWZqUmtjUUpOMEtRN2ln?=
 =?utf-8?B?R20xcnhHMEpFdDFEV0Jxc2J1MUxpNXd3bW5pajA3czE2dlFBbU5yOHhLTzBK?=
 =?utf-8?B?Q0llb215cXZYL09yZlFNVjdGYmR6UFBsV25WSVlTUXZhT3VSV0hleVg3cWov?=
 =?utf-8?B?bUJMNG9sTDBKQVgyVncxamxPaWI5RHhPZUJ0UmYzMUJhTVdjNUJQYkg0UUpz?=
 =?utf-8?B?V0ZFcWtDRGJmL0ZRNTZJV0EyampwZUVPK2ZaTVF0NDRjN2dQLzJpVUVTUG1h?=
 =?utf-8?B?THdPalBlLzE3N2xUUlA0UW9WZVlLaWxlR1Q0aU1PejBjVktDMWFnYWtBWWRR?=
 =?utf-8?B?WTNmQTIyQXc3dU1SVGJzdEZlV1liRytmUDZDdGZ2dFNlT1oyaTBzWmhnb21r?=
 =?utf-8?B?aFFqYjFLQTVQOTVBNDY4aTNPTWZnbjU3RWQveGRNNFZNVUVoNjMrSWhQOTVN?=
 =?utf-8?B?QVhSRXlsa0lCVm1MZHdFSlFmN29iamhuR3U2Tm5zN3htV1ZhR2RVY2J2ckIw?=
 =?utf-8?B?OWgrQXVGNnozYnlDWjhNVFJVbzJkanFtYWhsSFhHSUZOTk5ob1U0NWNtT3Ey?=
 =?utf-8?B?VzhIanlERDREb3NYQ0puRDM5N24yc2N3cFJncmx1ZVplZCs4ZEdCYTVraUh6?=
 =?utf-8?B?QklObXVDNktEbHJzKzNMb0l2Vm5MK24ydnY4QWtWRVdHWFVVOWN0YTRmSy9l?=
 =?utf-8?B?MVlQMWtHTlJGYTlaNEZ2Z0FkM2hwc2NqODVUK2FFdy8xTzFPaCsrZ3NjQS9J?=
 =?utf-8?B?Unc2K3AyZkZvVEZramJQb3dqSzNKZlRuVjk5OFNFbHl3YjgwUEUyNEpodGt2?=
 =?utf-8?B?UGpXbTh1VGNHZytRNUxCNktSRTg2aS9ES1IxUnAvTlpnb05YZmxWZ1E4YUVm?=
 =?utf-8?B?VU52S0NVYWE4RnNhQ3oyOWpRdXI2N3h6MFVvMVFxSklSQlo3MEk2QnVFOXpQ?=
 =?utf-8?B?SDNSU1g3UnpVQlVLNFcvVVBzbnlkSlRoNVhnK2JjbGVSL1RudFhnZkl0eE9k?=
 =?utf-8?B?eVNJUlNkL0QrVVNjTm5mY2VLUU40OUVHU0pjcmsvbXR5MHJhY2VFcEI3OGV1?=
 =?utf-8?B?WHZhNXZLVFdsWlJNc0dpM0FzRXJ5YURBMEFWNXU5a0NJQlNNR2lnT00wWlZM?=
 =?utf-8?B?K1hzdXZiZGVTTVE3cVJIYThBQ0hETjQ5TUF2WDJmRmxvOWJTRit5UC91VXUy?=
 =?utf-8?B?N0k1REp6d2ZHaUpzQlhtemRhbFJZZmRmeXppdTJaZ0FpZG90dCtPd1VtSUZ0?=
 =?utf-8?B?d1hrazVKR2ZkL0FROTQxenBVR2FQNlBaZjVESFh3aktWZ0pZUGZzVzBYcVdX?=
 =?utf-8?B?QWkvTXJ1T25UNmVyYVFuZElHUXplNjBwVTZDKzBaRzVaRHo3cnVReVVXY0pB?=
 =?utf-8?B?c3FNV3hrNVFacmtDTU1kL3kxZXMwYlhla05QcEM3b29Tc2duNnVFbkRCaFdk?=
 =?utf-8?B?RVVMaHhnMU9NZ2swTVNEb1B2a0lXVkhCdHo5b1lQV2NOUUtoaG5MaklkQlc1?=
 =?utf-8?Q?qxIzbJBQjTqwzHut2RWB+CAt6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD92027670E9054DB17700D5ADE7721C@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f11e5e3-5012-442e-7f8e-08dba9692c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 14:55:37.7970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PNaP7rglsWtjmqjG7h98MHDccgZWKI3/8I2qSLRRK1qwhebtCn+Z419MB+AnOo8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7771
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gRnJpLCAyMDIzLTA4LTI1IGF0IDE5OjM4ICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBPbiAyNS4wOC4yMyAxNTo0MiwgVmluY2VudCBXaGl0Y2h1cmNoIHdyb3RlOg0KPiA+IFNpbmNl
IHRoZSB0aW1lciBleHBpcnkgZnVuY3Rpb24gc2NoZWR1bGVzIG5hcGksIGFuZCB0aGUgbmFwaSBw
b2xsDQo+ID4gZnVuY3Rpb24gc3RtbWFjX3R4X2NsZWFuKCkgcmUtYXJtcyB0aGUgdGltZXIgaWYg
aXQgc2VlcyB0aGF0IHRoZXJlIGFyZQ0KPiA+IHBlbmRpbmcgdHggcGFja2V0cywgc2hvdWxkbid0
IGFuIGltcGxlbWVudGF0aW9uIHNpbWlsYXIgdG8gaGlwMDRfZXRoLmMNCj4gPiAod2hpY2ggZG9l
c24ndCBzYXZlL2NoZWNrIHRoZSBsYXN0IHR4IHRpbWVzdGFtcCkgYmUgc3VmZmljaWVudD8NCj4g
DQo+IFRvIGJlIGhvbmVzdCwgSSBkaWRuJ3QgbG9vayB2ZXJ5IGNsb3NlbHkgYXQgd2hhdCB0aGUg
dGltZXIgZG9lcyBhbmQgaG93IA0KPiBjb2FsZXNjaW5nIHdvcmtzLiBJIGRvbid0IGtub3cgaWYg
ZGVsYXlpbmcgdGhlIHRpbWVyIHByb2Nlc3Npbmcgd2l0aCANCj4gZXZlcnkgdHggaXMgdGhlIHJp
Z2h0IGNob2ljZSwgb3IgaWYgaXQgc2hvdWxkIGJlIGFybWVkIG9ubHkgb25jZS4gDQo+IEhvd2V2
ZXIsIGFzIHlvdSBwb2ludGVkIG91dCwgdGhlIGNvbW1pdCB0aGF0IGRyb3BwZWQgdGhlIHJlLWFy
bWluZyB3YXMgDQo+IHJldmVydGVkIGJlY2F1c2Ugb2YgcmVncmVzc2lvbnMuDQo+IA0KPiBNeSBz
dWdnZXN0aW9ucyBhcmUgaW50ZW5kZWQgdG8gcHJlc2VydmUgdGhlIGV4aXN0aW5nIGJlaGF2aW9y
IGFzIG11Y2ggYXMgDQo+IHBvc3NpYmxlIChpbiBvcmRlciB0byBhdm9pZCByZWdyZXNzaW9ucyks
IHdoaWxlIGFsc28gYWNoaWV2aW5nIHRoZSANCj4gYmVuZWZpdCBvZiBzaWduaWZpY2FudGx5IHJl
ZHVjaW5nIENQVSBjeWNsZXMgd2FzdGVkIGJ5IHJlLWFybWluZyB0aGUgdGltZXIuDQoNCkkgbG9v
a2VkIGF0IGl0IHNvbWUgbW9yZSBhbmQgdGhlIGNvbnRpbnVvdXMgcG9zdHBvbmluZyBiZWhhdmlv
dXIgc3RyaWtlcw0KbWUgYXMgcXVpdGUgb2RkLiAgRm9yIGV4YW1wbGUsIGlmIHlvdSBzZXQgdHgt
ZnJhbWVzIGNvYWxlc2NpbmcgdG8gMCB0aGVuDQpjbGVhbnVwcyBjb3VsZCBoYXBwZW4gbXVjaCBs
YXRlciB0aGFuIHRoZSBzcGVjaWZpZWQgdHgtdXNlY3MgcGVyaW9kLCBpbg0KdGhlIGFic2VuY2Ug
b2YgUlggdHJhZmZpYy4gIEFsc28sIGlmIHdlJ2QgaGF2ZSB0byBoYXZlIGEgc2hhcmVkDQp0aW1l
c3RhbXAgYmV0d2VlbiB0aGUgY2FsbGVycyBvZiBzdG1tYWNfdHhfdGltZXJfYXJtKCkgYW5kIHRo
ZSBocnRpbWVyDQp0byBwcmVzZXJ2ZSB0aGlzIGNvbnRpbnVvdXMgcG9zdHBvbmluZyBiZWhhdmlv
dXIsIHRoZW4gd2UnZCBuZWVkIHRvDQppbnRyb2R1Y2Ugc29tZSBsb2NraW5nIGJldHdlZW4gdGhl
IHRpbWVyIGV4cGlyeSBhbmQgdGhvc2UgZnVuY3Rpb25zLCB0bw0KYXZvaWQgcmFjZSBjb25kaXRp
b25zLg0KDQpTbyBjdXJyZW50bHkgSSBhbSBleHBlcmltZW50aW5nIHdpdGgganVzdCB0aGUgZm9s
bG93aW5nIHBhdGNoLiAgVGhlDQpzZWNvbmQgaHVuayBpcyBzaW1pbGFyIHRvIGhpcDA0X2V0aC5j
ICh0aGUgY29tbWVudCBpcyBtaW5lKS4gIEFGQUlDUw0KaGlwMDRfZXRoLmMgZG9lc24ndCBoYXZl
IGNvZGUgZXF1aXZhbGVudCB0byB0aGUgZmlyc3QgaHVuayBvZiB0aGUgcGF0Y2gNCmFuZCBpbnN0
ZWFkIHVuY29uZGl0aW9uYWxseSByZXN0YXJ0cyB0aGUgdGltZXIgZnJvbSBpdHMgbmFwaSBwb2xs
IGlmIGl0DQpzZWVzIHRoYXQgaXQncyBuZWVkZWQuDQoNCkkgY2FuJ3QgcmVwcm9kdWNlIHRoZSBt
b2RfdGltZXIgdnMgaHJ0aW1lciBwZXJmb3JtYW5jZSBwcm9ibGVtcyBvbiBteQ0KaGFyZHdhcmUs
IGJ1dCB0aGUgcGF0Y2ggYmVsb3cgcmVkdWNlcyB0aGUgbnVtYmVyIG9mIChyZS0pc3RhcnRzIG9m
IHRoZQ0Kc3RtbWFjX3R4X3RpbWVyIGJ5IGFyb3VuZCA4NSUgaW4gYW4gaXBlcmYzIHRlc3Qgb3Zl
ciBhIGdpZ2FiaXQgbGluaw0KKGp1c3QgdGhlIHNlY29uZCBodW5rIHJlZHVjZXMgaXQgYnkgYWJv
dXQgMzAlKS4NCg0KQW55IHRlc3QgcmVzdWx0cyB3aXRoIHRoaXMgcGF0Y2ggb24gdGhlIGhhcmR3
YXJlIHdpdGggdGhlIHBlcmZvcm1hbmNlDQpwcm9ibGVtcyB3b3VsZCBiZSBhcHByZWNpYXRlZC4N
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1h
Y19tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFp
bi5jDQppbmRleCA0NzI3ZjdiZTRmODYuLjRiNmU1MDYxYjVhNiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMNCisrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMNCkBAIC0yNzAzLDkg
KzI3MDMsNyBAQCBzdGF0aWMgaW50IHN0bW1hY190eF9jbGVhbihzdHJ1Y3Qgc3RtbWFjX3ByaXYg
KnByaXYsIGludCBidWRnZXQsIHUzMiBxdWV1ZSkNCiANCiAJLyogV2Ugc3RpbGwgaGF2ZSBwZW5k
aW5nIHBhY2tldHMsIGxldCdzIGNhbGwgZm9yIGEgbmV3IHNjaGVkdWxpbmcgKi8NCiAJaWYgKHR4
X3EtPmRpcnR5X3R4ICE9IHR4X3EtPmN1cl90eCkNCi0JCWhydGltZXJfc3RhcnQoJnR4X3EtPnR4
dGltZXIsDQotCQkJICAgICAgU1RNTUFDX0NPQUxfVElNRVIocHJpdi0+dHhfY29hbF90aW1lcltx
dWV1ZV0pLA0KLQkJCSAgICAgIEhSVElNRVJfTU9ERV9SRUwpOw0KKwkJc3RtbWFjX3R4X3RpbWVy
X2FybShwcml2LCBxdWV1ZSk7DQogDQogCV9fbmV0aWZfdHhfdW5sb2NrX2JoKG5ldGRldl9nZXRf
dHhfcXVldWUocHJpdi0+ZGV2LCBxdWV1ZSkpOw0KIA0KQEAgLTI5ODcsNiArMjk4NSwyMCBAQCBz
dGF0aWMgdm9pZCBzdG1tYWNfdHhfdGltZXJfYXJtKHN0cnVjdCBzdG1tYWNfcHJpdiAqcHJpdiwg
dTMyIHF1ZXVlKQ0KIHsNCiAJc3RydWN0IHN0bW1hY190eF9xdWV1ZSAqdHhfcSA9ICZwcml2LT5k
bWFfY29uZi50eF9xdWV1ZVtxdWV1ZV07DQogDQorCS8qDQorCSAqIE5vdGUgdGhhdCB0aGUgaHJ0
aW1lciBjb3VsZCBleHBpcmUgaW1tZWRpYXRlbHkgYWZ0ZXIgd2UgY2hlY2sgdGhpcywNCisJICog
YW5kIHRoZSBocnRpbWVyIGFuZCB0aGUgY2FsbGVycyBvZiB0aGlzIGZ1bmN0aW9uIGRvIG5vdCBz
aGFyZSBhDQorCSAqIGxvY2suDQorCSAqDQorCSAqIFRoaXMgc2hvdWxkIGhvd2V2ZXIgYmUgc2Fm
ZSBzaW5jZSB0aGUgb25seSB0aGluZyB0aGUgaHJ0aW1lciBkb2VzIGlzDQorCSAqIHNjaGVkdWxl
IG5hcGkgKG9yIGFzayBmb3IgaXQgcnVuIGFnYWluIGlmIGl0J3MgYWxyZWFkeSBydW5uaW5nKSwg
YW5kDQorCSAqIHN0bW1hY190eF9jbGVhbigpLCBjYWxsZWQgZnJvbSB0aGUgbmFwaSBwb2xsIGZ1
bmN0aW9uLCBhbHNvIGNhbGxzDQorCSAqIHN0bW1hY190eF90aW1lcl9hcm0oKSBhdCB0aGUgZW5k
IGlmIGl0IHNlZXMgdGhhdCB0aGVyZSBhcmUgYW55IFRYDQorCSAqIHBhY2tldHMgd2hpY2ggaGF2
ZSBub3QgeWV0IGJlZW4gY2xlYW5lZC4NCisJICovDQorCWlmIChocnRpbWVyX2lzX3F1ZXVlZCgm
dHhfcS0+dHh0aW1lcikpDQorCQlyZXR1cm47DQorDQogCWhydGltZXJfc3RhcnQoJnR4X3EtPnR4
dGltZXIsDQogCQkgICAgICBTVE1NQUNfQ09BTF9USU1FUihwcml2LT50eF9jb2FsX3RpbWVyW3F1
ZXVlXSksDQogCQkgICAgICBIUlRJTUVSX01PREVfUkVMKTsNCg0K

