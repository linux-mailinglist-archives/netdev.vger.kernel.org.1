Return-Path: <netdev+bounces-61588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B574F824568
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1746EB20E2A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11CE241F6;
	Thu,  4 Jan 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="jvMFFZJj"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2093.outbound.protection.outlook.com [40.107.104.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F624B21
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWbWPtSvQmidA22cp7PLThemxdcDSVCIReZaWwO3UnPwuGeMixWvPv97aW9p87JNDsQWEd0fjYQXjOdxf8X9l/Yp8SQrYEzEadwJxK6O/lPcX/EM/pHX/yWAz7t03zAPdGNc13XnwSxK0VNJp+fts6LICQqJxbzi1b8IqU6ebhm0RV1wdjIq7PidkG1Pnv1S2usTB6S1q6kEOuJNQ836Fb9GaYnG+I7et6/sSWMDtfE9bSsK/rjiht6muWUieru9UdoIWxhw/zk2tz2t5IG1kVdn466ErtuUs6TT8fm7f9rqs0qVDGincj2q7CnwnrVyuVEQK34jX3PEO+LPEd3xdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M07fk7uP6YASplIFXHBGC8EgkjcX+55a7AJFb70BGHk=;
 b=aRtwCW3M3/eD2Mlf3cue7xnTDjFTmCG6kLs8jSrVT7bgNuFw1RugwH5r/KQ9DNpC0g2IG+NBL5ipEaK6KUoF5R6/4tbkPIkp2LGwqs1J+YVNFOh4HkZBnngKBX0BpGFm/L0yvT8mVEpY8gvYL3Pq/EBW+U3w6nJXiY4DPwedJsuwjmKrcWaJ+TB+Wk0Wjjh85BMcEc1hFuNbXwp/+ySXc7RyGIeal47GJ71I+3L/ckIBxo/LlpCqsKtnaAc+aMrv6zYKQ023ovZx3iQwm5N1PJR0EbzSdgVxc2XNXcIGqJ22AJq2oNeyBT3eyILNB2YoqfTnjdpYgXAmvv/3abv4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M07fk7uP6YASplIFXHBGC8EgkjcX+55a7AJFb70BGHk=;
 b=jvMFFZJjBBo4wDk3rd1tCF8xSPhvjsEnP0pv4dAsOzvg+mRX5HrNNOKX3Qza/fNpLEBg7r9qbJczC1dWQI0BUzZppQPK/APIO55DWn6QCbmm3KRZQxggE2Num0NoGPs/xCGehqEUYW2cqYSmBjwKpOEiy5zrRl8+4ksKKMT4WpA=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by DB9PR03MB8422.eurprd03.prod.outlook.com (2603:10a6:10:399::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 15:52:24 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 15:52:24 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Luiz Angelo Daros
 de Luca <luizluca@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>, Hauke Mehrtens
	<hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 01/10] net: dsa: lantiq_gswip: delete irrelevant
 use of ds->phys_mii_mask
Thread-Topic: [PATCH net-next 01/10] net: dsa: lantiq_gswip: delete irrelevant
 use of ds->phys_mii_mask
Thread-Index: AQHaPxZ91O6kxg9pVkaeYniwQSoFvLDJzdcA
Date: Thu, 4 Jan 2024 15:52:24 +0000
Message-ID: <yvvmeznegq3hatqhgbj43cy35wt4cqohxze3mwfhzgeqrv2sas@mphzu5eohbtw>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-2-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-2-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|DB9PR03MB8422:EE_
x-ms-office365-filtering-correlation-id: 0eaee79b-38e4-4bf4-bf8d-08dc0d3d2513
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 39apuMie8qvAfTmBM9cbQe3q7wFUmOkQlkx6r69EQYjcrAANjy4HbjGX7TDYcNAdWs37ldUCDh3/abE6QuE2OJPXnaxNHCdg40QB0oxliZEAYJ9GPdajKB11jYz1BfC/OKuGkM0NFnh1u2lRUwmfOUETaJ/y3A6B/J80Nkkm4Cs9f+fSM3/Tvfh0MMZ7qwPUk1w72Gbyk8cnwiVwG9zSmltGIYD0HdEenv3GDZyFqzZ193TGYgK7+Zw8RDLi1iw1msDESbFR7i5FNHjqn6mIeqJ+7p4YT/3d9ebs8dLIeb9kTD1+6JfP+D4rPNpHfuhk4uPnhNnoEf0EUAiG/WG5Yfvwf99m7/T3MvSBR57U1BZv19Yd6oFkqU32MLH9PFTea/clfDQqt2YbsI5qXHsu+Cz1whVUru68u1rmFx61NUWc+tPqJGjj9nf8sKMf4PdDcVUI0Auc9IS/at4jLip5ZecCX2MLfVTfx4kLQ7N8NGc3EbzANob1JB6UAKBCxMg6fKWvOIyuhhMzKVfrXqE8jWAtOPlHTJgEkNjQs5vGMRwQ54yt5nAWKXqAjo6sgggjyBPdvvkdeYt42AOaTQdKhY8reY81N+8ldoD2Q4KmypbWBH42bsjA8y17vhBJN5US
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(136003)(376002)(396003)(366004)(346002)(64100799003)(451199024)(1800799012)(186009)(85182001)(85202003)(6486002)(66476007)(91956017)(66946007)(66556008)(6506007)(64756008)(66446008)(76116006)(38070700009)(86362001)(9686003)(6916009)(6512007)(66574015)(38100700002)(83380400001)(26005)(122000001)(41300700001)(2906002)(4744005)(71200400001)(4326008)(478600001)(8936002)(54906003)(8676002)(5660300002)(316002)(33716001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ny90RkszSHI0TVVML0RweUt4aXptVUpzZ1pEQWtxYlhpSTZhUUwyaGZqVGhO?=
 =?utf-8?B?UnphRkhYWFFlNjdNZXpjZG5ORHdRSEkrUDI5Wm9uWW5SK01JN214RE5qS2lG?=
 =?utf-8?B?cVkvNXhzOFJsMGJ3dE1WZERNYjJpRnpkTFkzZGdxY0VYVE1YeHlzTklSeXN0?=
 =?utf-8?B?RDFtYTR6WG5SWDVadk1HY2VLdlc5aWp1bEJubURsTUV3K3A3M2REblVmS1hp?=
 =?utf-8?B?T1JCdkdOWGpLWHk1emVVbXlDTWcyNmJtSzd2dUp5ZWF4Wk91WFFxczduUmRy?=
 =?utf-8?B?aXp5eGYvRk1scGdmRGlWaTlyZUJyTzRycWNRQndPMGtyQUIzQ3oxQ0NDVUMr?=
 =?utf-8?B?cDhHN0o2TTlZUUFTYTFNN2ZCd3VEeGpSeFlwZjV1VEk4R01KVnRIK0NQMDd3?=
 =?utf-8?B?NXpXTm9QZTc1MWx4ajRVSzExU3A4N0craS9XYm9XNU9VRzJRS1dQVGIzOHBR?=
 =?utf-8?B?MVlrd01TNVpKVDdiOTZ5elFBM3dHL3g2SFN2N3JnRHF3eFN4NklWNkF5UFg2?=
 =?utf-8?B?cU1mMENBemZaQW85MHM5encra0dOVExzL0JxZGs5ckRxbkJpZ083ZjJxSUVo?=
 =?utf-8?B?Wm9wcWNtVmd3U1pZamsvdGxBRlNJSTBCSUlETVZCa0hNOEc0MXVuN2NJU1h5?=
 =?utf-8?B?ZmNYU2JLbVFNUU95KzdUU1VsZ2htYjlaSmJQa1g4WnNmVmdlUXRQMHEyTUE5?=
 =?utf-8?B?UjBsMFVNRDBHNXJWLzdkaWd6dUhrVHJwZXlub0MzUU1JMXdBNGdXTHBScTMv?=
 =?utf-8?B?dkNtb0IySk40WjN6SXN4THE4WnEyZGh5eFdvL1gyaXlXTnFCT3paYXBaY3pD?=
 =?utf-8?B?S1hvM0NKS0Jkd0pEL1hocTJmeEhKQlAwMDdLdmNBZjV1Y0FJU2szYktYdDda?=
 =?utf-8?B?YytUdnNtQk1tNEpPMmVqeUlLcURrY1cySkRQa2JWbVVjWjZ3N3FsTzA5SkdJ?=
 =?utf-8?B?TTNQdFd2QWtyem1QaXpzcmlIUnpVSlc2ZjVIVTIzWTczTWtWczJxdTg2WlNk?=
 =?utf-8?B?ekV1ajVFQ1NKckxqdWFYMHdDZjM2YkwwN21HWTBSUHNWSG5QNUdKU3NSVWtH?=
 =?utf-8?B?eHpmZ28wTmJnS1hjTTdjVnFCbzhtU3VLbVFUdnZTTHRpTlVGT25uWG96QTcy?=
 =?utf-8?B?Y2dnVnB4TkJFQldNUDVWMDF0MWJkc0JXQXFPanI4bWlHb3RhOEhlVUhlcWF3?=
 =?utf-8?B?MmxGbEY4TTh1MWkzNzFsS2NsVHpBZ28rUUdVVEp0Y0tsMGdyK1hndXQyS1A5?=
 =?utf-8?B?b3BtWUFjNVFycDQ5dkprMGRWeSt0SXFxUlRQK2c3QWRNdDFIb0VpN0RZa0VH?=
 =?utf-8?B?cW5NakRqLzRQY3ZBM0VPek1Sd21IM01MUmlzYzlxOERvV1lpRHUxMmVJRHJ2?=
 =?utf-8?B?SUd4WXBFYUdXcXd0S1YyU2k3cVh4aUMzcmhYTFZ1S3RLSDRTdi9lOVRzM2Y4?=
 =?utf-8?B?RHAxRFRYMFh0ZWZCcnBhUGFhVXM4OFhGMGt4eVl1ellmWDlkYzVaL1VEYUJ0?=
 =?utf-8?B?U1RNNmdydHUwaStQckpEVU5tYlVGR2RFbDZkMEFOVmFEUU83bE1ITzRWeW5B?=
 =?utf-8?B?aklKMXY0R0xabmExV2FIOFp2WGEwbHZMQnFZN0k5ZDlXQkh0UC9ZYWdoZjUv?=
 =?utf-8?B?OUxlQTZHZ3VBMFcwWnF3RW81RmZITEtsdkdVOUc5UEdTdjVpK3pmZjI1Ui9p?=
 =?utf-8?B?Q3lVaVU5ZDczV0VkMm1OcDhmZFVQWkF3MkVWSWltTGplbHB5S3lNTlBKYjhD?=
 =?utf-8?B?Z2dCb2tlR2cyNWt5c3drYUlYUWdNSUppRXVHNVl5YTR5YUxBVTVhbmErbGxj?=
 =?utf-8?B?SlJ6a20xMVRXQkdlK0Y4ai9UZjR3ZldxSmtXRFVMQ2xJRWlwV0JIOFJQYlBz?=
 =?utf-8?B?eHlqbXBJbHhjbzI2S0k2citlU1dXOVBteGxlejR6cmpYQzNCNWNwTklzQlhm?=
 =?utf-8?B?U2RQUWowQzZYbC9HNHJTdU5KRjNuSUFJdTZ0Slk1Y3ZwdnRjMEZMVFBTb0RR?=
 =?utf-8?B?WkhrZG41QUVWNUhDMGNLUUZHN2FvZ1JWKzNLaE1KS1R6MXR6ZjhsUWxJY3Zq?=
 =?utf-8?B?YXViQUh0b0xIU2FLRXdpVjRvTHRWVzh4Y2hWWWZCNDUzNTk2NlRwQjVORC93?=
 =?utf-8?B?akdLS2NGdS93K1NzQVVMYW95cnlFa2llUlVEUWwxVkVZYnl3RDJheWVqL2pU?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D45817AD0A31E4FAB5828447A766C12@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaee79b-38e4-4bf4-bf8d-08dc0d3d2513
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:52:24.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrkodQAMDYbuCEMSOlK6aWLV8xL+AyBaTTt9TQdG5oozkOsFKMc/IlsAgTNGSVjxhklDhCukiAJ1eR4l18I7uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8422

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MjhQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBfX29mX21kaW9idXNfcmVnaXN0ZXIoKSwgY2FsbGVkIHJpZ2h0IG5leHQsIG92
ZXJ3cml0ZXMgdGhlIHBoeV9tYXNrDQo+IHdlIGp1c3QgY29uZmlndXJlZCBvbiB0aGUgYnVzLCBz
byB0aGlzIGlzIHJlZHVuZGFudCBhbmQgY29uZnVzaW5nLg0KPiBEZWxldGUgaXQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPg0K
DQpSZXZpZXdlZC1ieTogQWx2aW4gxaBpcHJhZ2EgPGFsc2lAYmFuZy1vbHVmc2VuLmRrPg0KDQo+
IC0tLQ0KPiAgZHJpdmVycy9uZXQvZHNhL2xhbnRpcV9nc3dpcC5jIHwgMSAtDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQ==

