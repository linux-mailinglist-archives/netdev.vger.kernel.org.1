Return-Path: <netdev+bounces-72894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E585A0CB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 11:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697651F2351D
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FEA2561A;
	Mon, 19 Feb 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="hHWStFqw"
X-Original-To: netdev@vger.kernel.org
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2115.outbound.protection.outlook.com [40.107.12.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C925616
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337851; cv=fail; b=eHIJ8v0sweaTmoifWxluiyNuh1cQMIATQoVZoIV6AA+JNkLJhi4uuiPh9xKCeloKwSaVg8TeLiM83CuI9sgDQ8iezlcKqOTyXJX0/XNUl/AmUf7IEqeBP08PdVRIiPY4hRWRmVAq/lxSVfqr5jrvD7+KpqGwb4TUiwmhQglThcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337851; c=relaxed/simple;
	bh=Qx7iKgefBTBrHGXzRNm8PGQT0pD6kIdGtFhvkV6PVfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nEwbK+L4L9+uH590cSbrhMlT61Ra6Lvas5LBcquKewXI81hz5uqHeHgRaRW5NRvUx2CwnlCpPnNr8V98KeVzyFCHf0A0+V9Km6bY7E82LinokyNeCC5rLD7V0f/SWEI+FSwIlyHF5fYOdh0wXKn6PJG9Xr55ccWhgbvfv5iMCHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=hHWStFqw; arc=fail smtp.client-ip=40.107.12.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2BpiisqDXFQFpYXYrhC6YzVvCnI6Q7Ug4Ts00fYNdSWGkNwwnrcW5OhJaEBYbKSQV6TgkTvgqkwqt1HND2hftLFGPdh4NGwM+TNW/kOc6N99xywaI3+k6PYX1lWZNYUItgrI3aGje588lpTcIuOrpaFMOA/Y2MbCn6K7kwrOwWELo4KWn/gda3cBkoglO9aGImyIfljHzzBW6W1olcOrN2cTVyUB1fmemQ0KPBoIn7cT2a1gLhgFDEhG8UW8WgauS3fEo+3evttFJfFyvdeOPh8ApJPi3dC2kMYWtRQ36PuVv+UUTmo3Jb7CDOjDW0wftq+shj5Oqc0Dol10DL6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx7iKgefBTBrHGXzRNm8PGQT0pD6kIdGtFhvkV6PVfM=;
 b=faCeUmg6JS55J76cV/D7IJUJCx1REcZ0ePSg0CMH1iCWXji7Wh0cV5f1wWyFh25JXvTwIw8fdF0Ca2NBebplmH9KKYOUTqSLgCvzOSAgTte41W1iTerwOsxbFyEH/DhGwVyEzzTJVT9Z0aVotr7yvh5Eq55qU+VEGWWLhAnZUZh/ziPa0Osc9hao2FdlTcFxMb5BT2NF8Tzcr66MMw2xaMaGRt9tOcjCTqhYg2jhtEK38Afg30Hmo8mFu7F9Kj5U+9xBsxP+MayUpyzAmcBEejdzM895OY3r2LksUAxnj9URJknmX0Zas9k4WPrWqetFTRRduwYJYE/ROKY/H8r0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx7iKgefBTBrHGXzRNm8PGQT0pD6kIdGtFhvkV6PVfM=;
 b=hHWStFqwD6+6AWIVDkxfn2nPfmhhYoAeMorr0sjNTx3aiLPv5TZYzTQpWGanP8DxxvuNRBkwFj4HTLg6Mrq0ocgNVrBCboBdE46+jyfWpZ8Lq91ZWaXxabFXu8WV+nlLJRO/qU697zjBSSE41rbthbtqqNvjtx2qkgf6fFpk9zTPC2CqRwFgB+9CSeFVtWJxZHCt7TR3jmvJNhx3Hi4IObTkT0H8tKnasz7UHRCNap6KNAYiSeel5PYwvQAx2V5cACvFwfX0xemfQ7DF9k5fYPtecXGsCSloW4WP3HNyukXiIqHsL6R49ETwyvIUyzXlV9dZS/5mEbrBZWFGYcteqg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 10:17:25 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 10:17:25 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Geoff Levand <geoff@infradead.org>
CC: sambat goson <sombat3960@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v5 net] ps3/gelic: Fix SKB allocation
Thread-Topic: [PATCH v5 net] ps3/gelic: Fix SKB allocation
Thread-Index: AQHaYxPgjalXLsKxXUqd1JTUeRwjWLERc4KA
Date: Mon, 19 Feb 2024 10:17:25 +0000
Message-ID: <ede0bba8-4385-40bd-99a3-5020b22e52eb@csgroup.eu>
References: <2f2b4550-8c66-4300-85b5-b9143cc7d918@infradead.org>
In-Reply-To: <2f2b4550-8c66-4300-85b5-b9143cc7d918@infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2047:EE_
x-ms-office365-filtering-correlation-id: 7fef48b2-d533-4546-1b58-08dc3133f85b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Cj0uKe1scUUaT8I09o5XaTf1IKXotrXuXG5F850ZJuKGQJ3viqHmbS81R5C8lkdjrdSC3QkLcggqhZCDPOAlfUVmiXBixzNZ9BAs0BYzEawXNAMECpFXfvwtGBSDLXBjxwqap9hG4po+ftxYDtOJnB0doOFlikxqAIAsAeiCdd6z+frkCPvNUrqrIe1zH1baFM0UAlSf4lUhNQm7Op/8qLLuAY1OmqV/5qxblMwH9O55BFTuV0rxL7z2CBVZZN36Teh17YhDB+BhjGQuebYHKj+48Q2KAU+lVidORyVj6PUvl6UcnPjFf8JSUPkXi2N1oJP0vFwgnsOAnD0BG6VwY/F8WGQAlOrFyTxYHqRUB4x1xH8kig/IyGwj2QrQnYDVEElcIK0g+u3rkoIOXg8lxIH1ce1kkD8oqb6ElpktAmWwvYZII5yQVJZieHffz39oXEAM2JRnc1ZSOB8s5bohINOU/v4sjLR9bCnweKSclj3DJnxSDlSOTbxs1N0blmJDiaGjFo/nV7P8ycUlNSymD9HP+LVM/qvedbWLouvRdSZpH4w6fi2S9my6lSWS/jcnhBUGEYlNM6giCaoolVkH0Y9+/5/2r4tZOMEgM0Q30WNnoMISITkjPcGqMburIt31
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39850400004)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8676002)(38070700009)(26005)(2616005)(41300700001)(83380400001)(66446008)(66476007)(66556008)(64756008)(6916009)(316002)(66946007)(4326008)(8936002)(91956017)(76116006)(478600001)(86362001)(71200400001)(6512007)(6506007)(6486002)(54906003)(36756003)(122000001)(38100700002)(31696002)(2906002)(44832011)(5660300002)(31686004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXRnREEzNVNCZlN5YkN1NWo1aGRJV09NZG8zUndQSlB4YXV1dkNnZWs0MGVV?=
 =?utf-8?B?dmlCSVQ3Y1RzcS9pYXdGV1NVeGprUDZmZjJVN25pRk5xcVNlQ1N3bkQ4L2FD?=
 =?utf-8?B?dUFybVhWbzJ4REhQRzFFcy9ITVltcVdPR09nZEVjVHYvRlVYS05GZ21SNUU1?=
 =?utf-8?B?RmdxZk02RGZzbEtCQ1dGdUovU1dxQlBQemJJVW1jS1pDaCs1M3JnekFoVGdv?=
 =?utf-8?B?L1gzN0YwTW4yRWwycHRpMGUwR0JKZk1ZL3ppODlScUtET01UVi9idEYzUzd0?=
 =?utf-8?B?eCtPSEJDam9sdC9zaktHUjN0VXhhTVJsZllFRm9SS2N5Y3hlVEhRR0dDMHY3?=
 =?utf-8?B?ekEvQ1NZbXN2c0NuSldyYUlrV3ZQTUtUQlRZMVZDUzM1U1RaREpReENMT1Bw?=
 =?utf-8?B?bnhWbjJIV0VsVWVydmhNMHI0NzYyT0lrS1RiQTR3cWtXcDAzcXE1eHZDWEZV?=
 =?utf-8?B?N1ROS1RLTGdXaDZOZDd6eXBuakhUSWtmV2VzSHNDOTdSRjMrQnZSNFgwWlVL?=
 =?utf-8?B?V0FCbU81K1lUdlJBcVoyVGRwc2pyOEUrNnBaeFNDMWtCZTIwWVZvZE1wWmZp?=
 =?utf-8?B?T2E5VW5zR0VXbGxhcE1aQk14ang5R1RQay9PK0oxcEw2YUV5NVJpVmYwbG5s?=
 =?utf-8?B?dHBERXM4WmZYWkVDaVl0OVZELzJ3RllGblZqNyt3a2p4Z2lhR3Z0ZHhNNlcy?=
 =?utf-8?B?OWJHdlJYZjRCRW1MTXdmalJxSjgxMlZ3UExUQjlVOFBNaXhWazFHWXRNRlUy?=
 =?utf-8?B?ZXBvMlE4VXJUNmhXUE15Q1BZZDBiWGVlb3p0YmVrMjhZSnhrcnoxYjF5SEtt?=
 =?utf-8?B?WGdPVXdqaHlKS3hpelpiQUJvR2R2aHhSNjdEOTgxeGVuUkFlUlpsZ0UwaUpR?=
 =?utf-8?B?VkpDNWtYR0t2bU5obmhWeTdnTVJSRVlxVnBzRkJRYlo4TGt1TXpMWWUrLzV3?=
 =?utf-8?B?TFZ0ZlE3VlpyZkFTQVR3ZDRoSUsyQzJKSnhna3VaOGl6VlNNK0t0L21rUVE0?=
 =?utf-8?B?akZFVE5oNVVJWXU2QUR0Y0EvWXVPUVI2ZDJtOWQwanpKU3cxYVkvS3A2OGFw?=
 =?utf-8?B?YzVlK2dBRVp1QXBZSSthNEJOY2c2ejB2RG9ORCtzWjlIN3ZkcGlLdzFGbFZ2?=
 =?utf-8?B?VGxGanZ0WG5Pb2plNW1qZHJNTW0xdUF5b05DN0dXcnY1MWt4ZTkxUzdBczli?=
 =?utf-8?B?MTN4SG5EWVhLQVFwSFpOMytYekVzdXFtVkFpdnJZOXRGVU5xcW5HaTlROFIw?=
 =?utf-8?B?b1lUUXFhd1lPa1ovVGlwUStkOXFRSEthNm5adXBxQ080RjN1S21pM0M4ajRE?=
 =?utf-8?B?NG15L0IzeDNhSTd3bHlETjVNcUZFSTRlR2paSDdrUnN5QXU2K3JxbUhMMUEz?=
 =?utf-8?B?eC94ZmMrV1FteUUvZmhoanZsaTdvVTJzRUxDNUsxVExoUWJDdWVjRkZMclZt?=
 =?utf-8?B?MmhVZWdEWnlnbHZMQmh2TnVqSjlDQzZhNzdsdFg5STE4LzJlU1U2eVh0bVRt?=
 =?utf-8?B?L2xFbFBCM2dnaWQzcndHbUNRLzdLVVEreFhGZUk5TUdNbjVsaEJuZmh5cm15?=
 =?utf-8?B?WmFJVWJvUEZMWHE0d2FzcFMzeDN5Rzg0TTBUS2NGcmdTbHMweENPa1FuY2la?=
 =?utf-8?B?RS9ITkZRcmlhMXRSWFBUT3loV3NBWGVJTUpkWUZDdDNDZ2plT0xCdlFXVG1U?=
 =?utf-8?B?UWFMbmhsUElOTXFrdk1HVkxhU25oTEFVWTd3ZGY3cEQ4MTQ3dFB0SktnNVha?=
 =?utf-8?B?Z0xIdWwrNEVKQWN4VVdtelJTZWJ2bGlzRVZObVdKQnp1WU02ZjhsaktQZDFF?=
 =?utf-8?B?NkkzV1plL0NHSWlxbEpaL3d0YjdmZHpRL3NvbGtLVW9NY3RNMTlCTStJcm9W?=
 =?utf-8?B?OWUwdEE5azhYSE04V1kvQ20vTllwdThvRnJ1dmZuUktlN0xtN3ZoOHBidU1a?=
 =?utf-8?B?ZjFzaGRHQUU2bUc3NXdWUHUzQWQ4bm5hMzc1V1RMcElmVi96VmRpZlJjS0hW?=
 =?utf-8?B?SDMwOTJtWUxVZ0c2QlpIRzkxc3N2SjV3aSs1dExCN2NGYmFXbkg1NUg4QnY4?=
 =?utf-8?B?R0o4VTBSeHJuSUgzdjhkWUhwenNIT2w3UkVFa1l4TCs2VUlIWnRLbTI5Wndh?=
 =?utf-8?Q?T7AeyARbnHu1wc2fPhbbpCX/F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75C42A972E7D0E43A98309D10DDADA14@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fef48b2-d533-4546-1b58-08dc3133f85b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 10:17:25.9192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfa+9U/p0gzVAgvWbI2t1ToQfZ5DNea+GtBd44AfOj11rz77Iu834Zm1E2rVVPaITZsQZ1GZKcn2zwkPBJMX3wDzTqeOmHBe0CsOwJrs2K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2047

DQoNCkxlIDE5LzAyLzIwMjQgw6AgMTA6MTIsIEdlb2ZmIExldmFuZCBhIMOpY3JpdMKgOg0KPiBD
b21taXQgM2NlNGY5YzNmYmIzICgibmV0L3BzM19nZWxpY19uZXQ6IEFkZCBnZWxpY19kZXNjciBz
dHJ1Y3R1cmVzIikgb2YNCj4gNi44LXJjMSBoYWQgYSBjb3B5LWFuZC1wYXN0ZSBlcnJvciB3aGVy
ZSB0aGUgcG9pbnRlciB0aGF0IGhvbGRzIHRoZQ0KPiBhbGxvY2F0ZWQgU0tCIChzdHJ1Y3QgZ2Vs
aWNfZGVzY3Iuc2tiKSAgd2FzIHNldCB0byBOVUxMIGFmdGVyIHRoZSBTS0Igd2FzDQo+IGFsbG9j
YXRlZC4gVGhpcyByZXN1bHRlZCBpbiBhIGtlcm5lbCBwYW5pYyB3aGVuIHRoZSBTS0IgcG9pbnRl
ciB3YXMNCj4gYWNjZXNzZWQuDQo+IA0KPiBUaGlzIGZpeCBtb3ZlcyB0aGUgaW5pdGlhbGl6YXRp
b24gb2YgdGhlIGdlbGljX2Rlc2NyIHRvIGJlZm9yZSB0aGUgU0tCDQo+IGlzIGFsbG9jYXRlZC4N
Cj4gDQo+IFJlcG9ydGVkLWJ5OiBzYW1iYXQgZ29zb24gPHNvbWJhdDM5NjBAZ21haWwuY29tPg0K
PiBGaXhlczogM2NlNGY5YzNmYmIzICgibmV0L3BzM19nZWxpY19uZXQ6IEFkZCBnZWxpY19kZXNj
ciBzdHJ1Y3R1cmVzIikNCj4gU2lnbmVkLW9mZi1ieTogR2VvZmYgTGV2YW5kIDxnZW9mZkBpbmZy
YWRlYWQub3JnPg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3Rvc2hp
YmEvcHMzX2dlbGljX25ldC5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvdG9zaGliYS9wczNfZ2Vs
aWNfbmV0LmMNCj4gaW5kZXggZDViNzVhZjE2M2QzLi4yODExNjg5MWQyY2UgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3Rvc2hpYmEvcHMzX2dlbGljX25ldC5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L3Rvc2hpYmEvcHMzX2dlbGljX25ldC5jDQo+IEBAIC0zODQs
MTEgKzM4NCw2IEBAIHN0YXRpYyBpbnQgZ2VsaWNfZGVzY3JfcHJlcGFyZV9yeChzdHJ1Y3QgZ2Vs
aWNfY2FyZCAqY2FyZCwNCj4gICAJaWYgKGdlbGljX2Rlc2NyX2dldF9zdGF0dXMoZGVzY3IpICE9
ICBHRUxJQ19ERVNDUl9ETUFfTk9UX0lOX1VTRSkNCj4gICAJCWRldl9pbmZvKGN0b2RldihjYXJk
KSwgIiVzOiBFUlJPUiBzdGF0dXNcbiIsIF9fZnVuY19fKTsNCj4gICANCj4gLQlkZXNjci0+c2ti
ID0gbmV0ZGV2X2FsbG9jX3NrYigqY2FyZC0+bmV0ZGV2LCByeF9za2Jfc2l6ZSk7DQo+IC0JaWYg
KCFkZXNjci0+c2tiKSB7DQo+IC0JCWRlc2NyLT5od19yZWdzLnBheWxvYWQuZGV2X2FkZHIgPSAw
OyAvKiB0ZWxsIERNQUMgZG9uJ3QgdG91Y2ggbWVtb3J5ICovDQo+IC0JCXJldHVybiAtRU5PTUVN
Ow0KPiAtCX0NCj4gICAJZGVzY3ItPmh3X3JlZ3MuZG1hY19jbWRfc3RhdHVzID0gMDsNCj4gICAJ
ZGVzY3ItPmh3X3JlZ3MucmVzdWx0X3NpemUgPSAwOw0KPiAgIAlkZXNjci0+aHdfcmVncy52YWxp
ZF9zaXplID0gMDsNCj4gQEAgLTM5Nyw2ICszOTIsMTIgQEAgc3RhdGljIGludCBnZWxpY19kZXNj
cl9wcmVwYXJlX3J4KHN0cnVjdCBnZWxpY19jYXJkICpjYXJkLA0KPiAgIAlkZXNjci0+aHdfcmVn
cy5wYXlsb2FkLnNpemUgPSAwOw0KPiAgIAlkZXNjci0+c2tiID0gTlVMTDsNCg0KWW91IGFyZSB1
bmNvbmRpdGlvbmFseSByZS1hc3NpZ25pbmcgdmFsdWUgdG8gZGVzY3ItPnNrYiBiZWxvdywgc28g
YWJvdmUgDQpsaW5lIGlzIHVzZWxlc3MgYW5kIHNob3VsZCBiZSByZW1vdmVkLg0KDQo+ICAgDQo+
ICsJZGVzY3ItPnNrYiA9IG5ldGRldl9hbGxvY19za2IoKmNhcmQtPm5ldGRldiwgcnhfc2tiX3Np
emUpOw0KPiArCWlmICghZGVzY3ItPnNrYikgew0KPiArCQlkZXNjci0+aHdfcmVncy5wYXlsb2Fk
LmRldl9hZGRyID0gMDsgLyogdGVsbCBETUFDIGRvbid0IHRvdWNoIG1lbW9yeSAqLw0KPiArCQly
ZXR1cm4gLUVOT01FTTsNCj4gKwl9DQo+ICsNCg0KSXMgdGhpcyBjb2RlIG1vdmUgbmVlZGVkIGF0
IGFsbCA/DQoNCkF0IHRoZSBlbmQsIGlzbid0IGl0IGVub3VnaCB0byBqdXN0IGRyb3AgdGhlIGxp
bmUgZGVzY3ItPnNrYiA9IE5VTEw7ID8NCg0KQ2hyaXN0b3BoZQ0KDQo+ICAgCW9mZnNldCA9ICgo
dW5zaWduZWQgbG9uZylkZXNjci0+c2tiLT5kYXRhKSAmDQo+ICAgCQkoR0VMSUNfTkVUX1JYQlVG
X0FMSUdOIC0gMSk7DQo+ICAgCWlmIChvZmZzZXQpDQo=

