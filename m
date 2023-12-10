Return-Path: <netdev+bounces-55634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B2680BB17
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 14:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EC3280C9F
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0995C8C2;
	Sun, 10 Dec 2023 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="RXg3nIqV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2134.outbound.protection.outlook.com [40.107.104.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CB7D9
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 05:37:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEQtHBFm6323eJJB6GqNg1Z8vRw8/I2js0qjWkdc5tAM8vS+PbOdRd4Sgxphg1b//lsPzJcaTQPqulfUpOQdlZ/WcQqAiq4F9htLg3Xh1ipIf9720xw4Ra6RSU2hXOMEc/ojc0nRsYWAGpvwuhcEHrDue0+3GXItkVJ79/q+P/qhvSWGzyQCsnaU6VYp70eanoj49GdR5BkTtyTmWFT8x4png22jcR9j+hx5NT+EHpoD4cTw2Nuc8+5wQ2c/kQGWtkax9K/VJto6tojWe49IcEG5dR21fOJ9sSyusjx1MYv4Qd1ifh29cBqGy6t+bQQfRE/v8reYKVskXOf9/6Yofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6vjbxeTjC2Gr9nQPPibsR0RhbrSH6IYgrvd63BFZrk=;
 b=Lvj6Zc7IlemqSbWJp78ZI45pu0zFgpWoWxP1SKelMzS4/F/Eo/FuH4ibs6FXagiiLsrcLwn3TYbi4galleXrUjSj+TrbD9uYK9fsg5UaXFIPNsHvkzhVIbWBW5asZv9e1eWU3gcPb380Qlk9y/cO4W0kYEE3t+9JxJpKyqhaZnWHsU4x31bg99oKKqe20iqbxKCjBDPBC5hSy5F/ZL//e0BwQrlQ9QIO1w5H7to4STJ1Juk7ZIi6ypru45ogWEgHYEGjdTtJZy7QJfQLY2Mcru5z2w8p/5o/nD2h/0rW1sad0x+sA6DJWQ2lRzW3x/63GindArf5xKfNe1dT4L0XlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6vjbxeTjC2Gr9nQPPibsR0RhbrSH6IYgrvd63BFZrk=;
 b=RXg3nIqVU5wbsOT2otiftbNKxoaI0FLJILAC97rZzb1MNvZP85+DaRG82VIDQcUakj5k6BzB1HqJlUYtrHa+/FWzyx2HAzMmDIlDF5L7Iclj5CSlOlIG+uRbFa2aagbwCsCxKLKChJG0syJmjHbGr5rYJ2lyrDekPaLTmpCunTo=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DU5PR03MB10261.eurprd03.prod.outlook.com (2603:10a6:10:518::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 13:37:24 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 13:37:24 +0000
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
Subject: Re: [PATCH net 2/4] docs: net: dsa: update platform_data
 documentation
Thread-Topic: [PATCH net 2/4] docs: net: dsa: update platform_data
 documentation
Thread-Index: AQHaKg3n2wHMFyr85k6gtwpWW3THprCih+gA
Date: Sun, 10 Dec 2023 13:37:24 +0000
Message-ID: <dm2l5z2l6oqp27tclkq2z6v4va2xc6kt5mxtwctjtdl5hu45y7@bs6lfqvfzlgb>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-3-vladimir.oltean@nxp.com>
In-Reply-To: <20231208193518.2018114-3-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DU5PR03MB10261:EE_
x-ms-office365-filtering-correlation-id: 2f85087d-4c1f-4d4c-4abf-08dbf98524eb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sy3kpYnY5Quz6HJZZV7n1ogX5JaUe4oNbx9UnUMD95Gr04vF5+7IikMeSJwBPXVJ3xi9VJfAhHbR0PWf+a4Pa1vhq8Bi2PDeqbJ38OIdXq4qJV9pO4nqTop8IVJXnj/QDi0zrI8WfQtF4oIE4tYK2oYlrKKDmN8/dbEMqOzCNZC4v0sZ37ZPWDuHUmAVDxKbBC5f2tWPUm4PvGSFmEA9uPsjW8ik6kx7wAeL44G/H7rOV6Oawh7IAbCPi8b0L9bYMX0FhSCjpUraF4vBcLD8/CQMu5DRbxrFaMwSy/Pby97aoxAHvcv5OCN05t25d3YX21OGqDEPuEFCx9JN8cL6VowztJDH6X2TmQDul82klKB7+Jxb15YOfTA2UUW6gIrl242h5a4WanDw/DcR5eFXGod810pa0Hb4DukFWSVufWM8KA68racuWe4Z4oZtVNpBMxVcKiJpQDewEcKRefCFTwkJmeeSDeF00sONMVJfFR0jYprPC//esLSztGVieHm3qYJzKqNl7qEAg3HZkcVFrYB+xbomx8+8bFpcM7vzK3XacWnrjcPAA/7ibBdzLSBxXrKIhvCkcqH9a2404enu7D1ITPtx85zo5euf1L3Egr3ct/uGeEaZp70msJa3EEABaVXNz+e966WrFuHhlvGq410ZafJsvGcHPUsnOjqMvc8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(39840400004)(396003)(366004)(230273577357003)(230173577357003)(186009)(64100799003)(1800799012)(451199024)(26005)(66574015)(6506007)(71200400001)(6512007)(9686003)(83380400001)(5660300002)(7416002)(33716001)(41300700001)(2906002)(4326008)(478600001)(6486002)(8676002)(8936002)(76116006)(66946007)(91956017)(66556008)(316002)(6916009)(54906003)(64756008)(66446008)(66476007)(86362001)(38100700002)(122000001)(85202003)(38070700009)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0hiK3lsck9wOTl6N2tMcFkzZ2JJcXZMK2c4alBuSnJudE1ydE83QnN0bzk3?=
 =?utf-8?B?Zysydm0vRUl6bWlWWHR6TGxVZ0VWS3VkMGlDM0lUYkxjU3ZKZmFObkYyQW4y?=
 =?utf-8?B?d2FERm1aZ0N5T0d1TytadlRkZGhMbHVFbnRMQlR4Y1dtdk0zMFY2N2lMMDBs?=
 =?utf-8?B?YXdhS1VYZWxYSm9YcDkrMjhrN1FTcDgwZzNERjg0MEFJVkc3U09TaVB5TURm?=
 =?utf-8?B?Z092RFFZRmM1V0ExRXFRRTFnb3JOVDVGTCtJOUJLSDVBUnZLNEljZFR4QXky?=
 =?utf-8?B?MSs2OTlpYXpocUFGOWNRVG4rZkJUeTN1NXVxTmdGUzRkN3FyV1ZZSExoYjNh?=
 =?utf-8?B?SXJ6bnVTbS9NcGovSnFvSXhYQ1BuMG1TVnF5S0lyaUg0dDZXRUwwUXFGa3Fz?=
 =?utf-8?B?QVVSRUtMblFGMVY0QVgwNG9qZHVVbEh6VDMyTTRYUG15eXBTUmVESXRIUWcy?=
 =?utf-8?B?TzB1OVlYWWp4TEszNVFEWTNZRGlnRkVhRkxZTkowa09DbGJjWVlxSForZHBS?=
 =?utf-8?B?MUNBMGRmcWdKU1gyY3FBSlQvY2hDRXowNHRlY1BrY0pmaXhqb3c3Sk40RVMy?=
 =?utf-8?B?WTZYajl3SEtweGRTVllDd3dOSlJZYVE1VUpZQnZSbFAxdTcxeVBBL3RtMkFm?=
 =?utf-8?B?TGFBZks1OEFQTnF4NVNRekErVUt5LzBDcXk0WW9Ndi9mZ0NoZGVYWHhVQXBq?=
 =?utf-8?B?eXVzemwvNkhuQUowY2VLMzlxYjZRaytEMmYxZTRmR1ZFSnY3Qm5NVXBRWTZY?=
 =?utf-8?B?NlFsQUx6RmtiV0FQOXo0U1FTcm5ubUhrTUY0OGRyUkhnS0lnaTI0aWN3Z2pm?=
 =?utf-8?B?d0U1L2VCdktkR0pGSmRJOWtIK0owQ0ZMSjFlYjFkN3FnbDVJdXZXS1Q1cXNh?=
 =?utf-8?B?SkZPZ3Y0ZHVLaFhjM0VWUFpWU3RZYWZtREZSM0hPZTR3YjFiSFlEUjBDY1Nq?=
 =?utf-8?B?MG9kb3Z4VVE4b2I3c3ZGb0VPTWVCdHZETVVjQWxpOEpjTW5URjIrcU5tbGNj?=
 =?utf-8?B?VHBmUmM2cTU3Y0lVVjc1ejAvM252ckZQUlB5UGplaFpHdUI4eGJtUTRFL05T?=
 =?utf-8?B?WWljZVNQTHhTVGdLdWwxV2ZZMEpaVHlXVHk4ZXlHQjRCTGpUaGhXVGYzSFpM?=
 =?utf-8?B?QVdSSW5VdkdMVEhTWXhmL1FkZFM1T2dOOFFONkh3MlNPaGpxVTh2ZFVaanZi?=
 =?utf-8?B?dzNyUGNKOTlqazF0K2JseUZvMGx2dnRtdHFmUk9rQzFFZ2hjYXJ0dDZza1JC?=
 =?utf-8?B?QTdNVkdGelRHbXBMSlJGdk1DVDFNMnk1NlBjcXlCcE9BUzhGbEFIQVkzRFdy?=
 =?utf-8?B?SzhRMWtEYVBsZFJ5eVdKVlp2WDVMaTlIcEJ4WGx2K2hrU1kzWW84OGpIR2dB?=
 =?utf-8?B?bVVhZHZ2V0hFeWhnaDcwaGJuQ0k0b0hBTGVsenlHR3UvUmdEQzFUeTNsMDZP?=
 =?utf-8?B?SGJCZ0NDZW8yL2JxUjFwbjYvdnY5U1JZU25sU0ZZOWJQZkNJVmcvaTBpQUx1?=
 =?utf-8?B?cTI4TCtBTytkSzczR3NMSzEvMkc3amRnL2JEZG9Pc3ZFVWJkZGdLTFpTb2dv?=
 =?utf-8?B?MXVpWnBkdDY3aitwYzR4bm5aTVoyWmxSVmZtQjl5Uk5WVlZFNTVkMkZ6TWpJ?=
 =?utf-8?B?cFVveUc2NUdrNXN1Y3RMMjNLTENDZkZqNGZtOUFKdkxiWitpR250eHdwU0c5?=
 =?utf-8?B?MUhBNlVXN0l1QjU2K2R1Q0tuNHpndHEwQ3lpVEcxRXAyWTVFbE9hejR1OHRm?=
 =?utf-8?B?eTd3cGhzeWFXZmRZaWM1SVNxNjNhUWc0OGJJUWk4RE4zMVh2UGNvS1lXWGtO?=
 =?utf-8?B?V3ZkZHViRitlTTErMEhHNEkwTUUyMTZXTllnUUZ0RzkyTUwzS1lIbnc5WFV2?=
 =?utf-8?B?SGU2UkdwSVhpV2tUUnlNTmo0T1R2QVpnZ2d0MU5FWnJQQ1ZhYUpqSjVSTUhz?=
 =?utf-8?B?a1dOejNjdE90T0Jma0k4ZWJHeTV5Nm1CNzZXSWdFS2VRR09JSnp3ZUE0Yjcw?=
 =?utf-8?B?dC8xNHNjUGNVU0NtWmY2Y1h4QW5hRjdzcU5QdVREY1UxOElPZ0NqTENnb2Zi?=
 =?utf-8?B?TUJST1R4Vm5UVnBCaWFSNTBIU0hSR0ZDU3Zld21Mc2lyTkxLK3U5UjJvZ25F?=
 =?utf-8?Q?Gky0zA2a5fsYak2gTvReX4/HV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0351C0E0ACA9D747B18E230F64303899@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f85087d-4c1f-4d4c-4abf-08dbf98524eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2023 13:37:24.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PP4S3besd735/eE6GadbY5YEiWjmugd0nlaurGPTRWE4RYK15zsfO3Cek/aS2sRgHdZUxZ0rlvnyTlrkV3+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10261

T24gRnJpLCBEZWMgMDgsIDIwMjMgYXQgMDk6MzU6MTZQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBXZSB3ZXJlIGRvY3VtZW50aW5nIGEgYnVuY2ggb2Ygc3R1ZmYgd2hpY2ggd2Fz
IHJlbW92ZWQgaW4gY29tbWl0DQo+IDkzZTg2YjNiYzg0MiAoIm5ldDogZHNhOiBSZW1vdmUgbGVn
YWN5IHByb2Jpbmcgc3VwcG9ydCIpLiBUaGVyZSdzIHNvbWUNCj4gZnVydGhlciBjbGVhbnVwIHRv
IGRvIGluIHN0cnVjdCBkc2FfY2hpcF9kYXRhLCBzbyByYXRoZXIgdGhhbiBkZXNjcmliaW5nDQo+
IGV2ZXJ5IHBvc3NpYmxlIGZpZWxkICh3aGVuIG1heWJlIHdlIHNob3VsZCBiZSBzd2l0Y2hpbmcg
dG8ga2VybmVsZG9jDQo+IGZvcm1hdCksIGp1c3Qgc2F5IHdoYXQncyBpbXBvcnRhbnQgYWJvdXQg
aXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVh
bkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogQWx2aW4gxaBpcHJhZ2EgPGFsc2lAYmFuZy1vbHVm
c2VuLmRrPg0KDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RzYS9kc2EucnN0
IHwgMjMgKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL25ldHdvcmtpbmcvZHNhL2RzYS5yc3QgYi9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZHNh
L2RzYS5yc3QNCj4gaW5kZXggMGMzMjZhNDJlYjgxLi42NzZjOTIxMzZhMGUgMTAwNjQ0DQo+IC0t
LSBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kc2EvZHNhLnJzdA0KPiArKysgYi9Eb2N1bWVu
dGF0aW9uL25ldHdvcmtpbmcvZHNhL2RzYS5yc3QNCj4gQEAgLTQxMywxOCArNDEzLDE3IEBAIFBI
WXMsIGV4dGVybmFsIFBIWXMsIG9yIGV2ZW4gZXh0ZXJuYWwgc3dpdGNoZXMuDQo+ICBEYXRhIHN0
cnVjdHVyZXMNCj4gIC0tLS0tLS0tLS0tLS0tLQ0KPiAgDQo+IC1EU0EgZGF0YSBzdHJ1Y3R1cmVz
IGFyZSBkZWZpbmVkIGluIGBgaW5jbHVkZS9uZXQvZHNhLmhgYCBhcyB3ZWxsIGFzDQo+IC1gYG5l
dC9kc2EvZHNhX3ByaXYuaGBgOg0KPiAtDQo+IC0tIGBgZHNhX2NoaXBfZGF0YWBgOiBwbGF0Zm9y
bSBkYXRhIGNvbmZpZ3VyYXRpb24gZm9yIGEgZ2l2ZW4gc3dpdGNoIGRldmljZSwNCj4gLSAgdGhp
cyBzdHJ1Y3R1cmUgZGVzY3JpYmVzIGEgc3dpdGNoIGRldmljZSdzIHBhcmVudCBkZXZpY2UsIGl0
cyBhZGRyZXNzLCBhcw0KPiAtICB3ZWxsIGFzIHZhcmlvdXMgcHJvcGVydGllcyBvZiBpdHMgcG9y
dHM6IG5hbWVzL2xhYmVscywgYW5kIGZpbmFsbHkgYSByb3V0aW5nDQo+IC0gIHRhYmxlIGluZGlj
YXRpb24gKHdoZW4gY2FzY2FkaW5nIHN3aXRjaGVzKQ0KPiAtDQo+IC0tIGBgZHNhX3BsYXRmb3Jt
X2RhdGFgYDogcGxhdGZvcm0gZGV2aWNlIGNvbmZpZ3VyYXRpb24gZGF0YSB3aGljaCBjYW4gcmVm
ZXJlbmNlDQo+IC0gIGEgY29sbGVjdGlvbiBvZiBkc2FfY2hpcF9kYXRhIHN0cnVjdHVyZXMgaWYg
bXVsdGlwbGUgc3dpdGNoZXMgYXJlIGNhc2NhZGVkLA0KPiAtICB0aGUgY29uZHVpdCBuZXR3b3Jr
IGRldmljZSB0aGlzIHN3aXRjaCB0cmVlIGlzIGF0dGFjaGVkIHRvIG5lZWRzIHRvIGJlDQo+IC0g
IHJlZmVyZW5jZWQNCj4gK0RTQSBkYXRhIHN0cnVjdHVyZXMgYXJlIGRlZmluZWQgaW4gYGBpbmNs
dWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZHNhLmhgYCwNCj4gK2BgaW5jbHVkZS9uZXQvZHNhLmhg
YCBhcyB3ZWxsIGFzIGBgbmV0L2RzYS9kc2FfcHJpdi5oYGA6DQo+ICsNCj4gKy0gYGBkc2FfY2hp
cF9kYXRhYGA6IHBsYXRmb3JtIGRhdGEgY29uZmlndXJhdGlvbiBmb3IgYSBnaXZlbiBzd2l0Y2gg
ZGV2aWNlLg0KPiArICBNb3N0IG5vdGFibHksIGl0IGlzIG5lY2Vzc2FyeSB0byB0aGUgRFNBIGNv
cmUgYmVjYXVzZSBpdCBob2xkcyBhIHJlZmVyZW5jZSB0bw0KPiArICB0aGUgY29uZHVpdCBpbnRl
cmZhY2UuIEl0IG11c3QgYmUgYWNjZXNzaWJsZSB0aHJvdWdoIHRoZQ0KPiArICBgYGRzLT5kZXYt
PnBsYXRmb3JtX2RhdGFgYCBwb2ludGVyIGF0IGBgZHNhX3JlZ2lzdGVyX3N3aXRjaCgpYGAgdGlt
ZS4gSXQgaXMNCj4gKyAgcG9wdWxhdGVkIGJ5IGJvYXJkLXNwZWNpZmljIGNvZGUuIFRoZSBoYXJk
d2FyZSBzd2l0Y2ggZHJpdmVyIG1heSBhbHNvIGhhdmUNCj4gKyAgaXRzIG93biBwb3J0aW9uIG9m
IGBgcGxhdGZvcm1fZGF0YWBgIGRlc2NyaXB0aW9uLiBJbiB0aGF0IGNhc2UsDQo+ICsgIGBgZHMt
PmRldi0+cGxhdGZvcm1fZGF0YWBgIGNhbiBwb2ludCB0byBhIHN3aXRjaC1zcGVjaWZpYyBzdHJ1
Y3R1cmUsIHdoaWNoDQo+ICsgIGVuY2Fwc3VsYXRlcyBgYHN0cnVjdCBkc2FfY2hpcF9kYXRhYGAg
YXMgaXRzIGZpcnN0IGVsZW1lbnQuDQo+ICANCj4gIC0gYGBkc2Ffc3dpdGNoX3RyZWVgYDogc3Ry
dWN0dXJlIGFzc2lnbmVkIHRvIHRoZSBjb25kdWl0IG5ldHdvcmsgZGV2aWNlIHVuZGVyDQo+ICAg
IGBgZHNhX3B0cmBgLCB0aGlzIHN0cnVjdHVyZSByZWZlcmVuY2VzIGEgZHNhX3BsYXRmb3JtX2Rh
dGEgc3RydWN0dXJlIGFzIHdlbGwgYXMNCj4gLS0gDQo+IDIuMzQuMQ0KPg==

