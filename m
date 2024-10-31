Return-Path: <netdev+bounces-140778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E929B8079
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7492728353C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7B1BF7FC;
	Thu, 31 Oct 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Y5vOc5OP"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DB1BD03C
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393107; cv=fail; b=Rs7aD4wQ3oeTzhIgtQUY7qDNUTn36CO6VRDnb/mcPJtNtzYOzaoCuZfgG5SPED2IT01Yjk5V1VwSM7MO67hPaufKdTLCoj9O8CfaPG0Iyjw3Etbw2n5xNFa9ndj2hz8DawSuRQNd3VfTrqFJmtfXez6QOLsf8b4MyOVTHVNjbGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393107; c=relaxed/simple;
	bh=3rxN444IT/i9Y4qmEiJpt8u8de/+eHTAzLJNHCr5i6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W+HcCsYQ610Pn0HOBfkzDCmWg/z8vz3cEKsWFCKdGHBFNjvmSZArqzjlwNJWKuu2TGDnG3r2Kxsb8OhZUcMkeFuYqo8PSGO0JUW7pZ/bdY2/Mn341YEqorlEGsBvtUb1nnZOX+/x56Mn8y9vnGUrD3n5biM50yor4Nd13PaO1y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Y5vOc5OP; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dokrPZKjghGv9JUZp/PlW+qEnPj+1JNJMdwnPB588Lq7dMokCRs/X2IaY6drnZkytyK5xbuC4cXj7LwLLkRtpazx09fGkawpHJ96a9qvM54JwsiZNgRH/yhnFW3bY9YZFzcVwDKwEZ+WCOwT6jjwaw8T84APheEA4VErjO3Vc38bh/K/meMqtSBYY73/kNk5xNhQsnvtmbLXCNPOChgSbRuucjohuy9L56i0pPVVvVB+kRt3N/IH7te0h4gzTrvfiTmECOO5nbnCdCZ6/B9pDoPhbxzktrO7sKN60e9ufVim3hWUxxXZOEOFA4iy8OIPn7pz0bVmQRu3u3oaajlEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rxN444IT/i9Y4qmEiJpt8u8de/+eHTAzLJNHCr5i6g=;
 b=nTCoCrQky42uNTEEmiRsr9JMrDAYPM4TufAH5Dcco34utJsJMbVjkaaWutO6CrtBGuQlUQJfaFMiB1CAGkI1eTjUu+brQy8+vZA/IEosQEL6GLoNBcPRAYa3Z+yThNXpLNU60ORXk3bX3cLXOe62h0HfJbWyv2HmGxC1xOcA6NQGaSGwdLOCpcRJpEHQhzK5tUvyzVRaCJq9b9a0/yTVnVyHsoXFN5lAjlqN3zH5k4z2mHvtYNucpJ34wPLLPAnPE8OLKVYUwF7Q3yYZ/RvgUmbLiQ1LFYzXLUg1ihEnUiltYCRfHdkmzUha8XlTWNlk1lmiI1TNzZgR7lTn8yo1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rxN444IT/i9Y4qmEiJpt8u8de/+eHTAzLJNHCr5i6g=;
 b=Y5vOc5OPfuk3DsFABgZ1R4dlGwoXkV45m+Mz9aD0DhvOlVqdjHXLtla/lFfNyUAd3CW+1hXGWcSojeIGSXGXRne7DEDci30/dtED8h0e3+4xdXUTLOqEsIdTMo3Nz5CKlqlrIuiQpGOLxomnC/0m1cLhasZ1FwY1abmHBRehqCpAnaI1K8slC0ri5ZKXrDmEySGsxaI4L6AZKBoxBIbNeAVBzmMTXmod5hypgclytzCZqJZiHJfpvU1gc8p8nHCNjqCb3k/n0jiQ0Jpy/YRH9OBA2JPzMiD7t3G9ew3qx/ulqjiNuGVxwHkyhBYEzcBxT9VsUlrMJy/P0iO7CQU5+Q==
Received: from AM6PR07MB4456.eurprd07.prod.outlook.com (2603:10a6:20b:17::31)
 by GVXPR07MB9727.eurprd07.prod.outlook.com (2603:10a6:150:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 16:45:01 +0000
Received: from AM6PR07MB4456.eurprd07.prod.outlook.com
 ([fe80::9dad:9692:c2c3:1598]) by AM6PR07MB4456.eurprd07.prod.outlook.com
 ([fe80::9dad:9692:c2c3:1598%4]) with mapi id 15.20.8093.014; Thu, 31 Oct 2024
 16:45:01 +0000
From: "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
CC: Paolo Abeni <pabeni@redhat.com>, "Chia-Yu Chang (Nokia)"
	<chia-yu.chang@nokia-bell-labs.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>, Olga Albisser
	<olga@albisser.org>, "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>,
	Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
Subject: RE: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Topic: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Index: AQHbJAZucSW+6b+sVkmTjRB4hLlQJ7Kdu9sAgABCIYCAAutSgIAAEZkAgAAaMsA=
Date: Thu, 31 Oct 2024 16:45:01 +0000
Message-ID:
 <AM6PR07MB4456EAF742A691AD513AE8C1B9552@AM6PR07MB4456.eurprd07.prod.outlook.com>
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021221248.60378-2-chia-yu.chang@nokia-bell-labs.com>
 <ea2ccad9-6a4a-48e1-8e99-0289e13d501c@redhat.com>
 <CANn89iKU5G-vEPkLFY9vGyNBEA-G6msGiPJqiBNAcw4nNXoSbg@mail.gmail.com>
 <CADVnQy=Gt+PHPJ+EdaXY=xcrgeDwusSBmmWV9+6-=93ZhD4SXw@mail.gmail.com>
 <CANn89iJNi1=+gAx6P4keDb9wuHoTjZnN0DNRgBEZ5cJuUcaZHg@mail.gmail.com>
In-Reply-To:
 <CANn89iJNi1=+gAx6P4keDb9wuHoTjZnN0DNRgBEZ5cJuUcaZHg@mail.gmail.com>
Accept-Language: nl-BE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4456:EE_|GVXPR07MB9727:EE_
x-ms-office365-filtering-correlation-id: 1fea71c4-7bc0-46d0-f7aa-08dcf9cb5d07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NG9aTm1YNDg5Z0g5NHNETVY4RmFNZGFJMDJVdVNuZzkzdGV3eEh3MjJ1bThm?=
 =?utf-8?B?NS9taXNBYWdjdmVZOXpMcVZnWXdHWHRCbVNJdkdHNVluMTBkWFBEL2IrYzRu?=
 =?utf-8?B?SjVxdHFFVGtWY3lUc29DVGt1QjZ3azNsb3dCRWVBTVplb3ZoVS95SXhKSEZt?=
 =?utf-8?B?QnNxOXBOVUtic2EwekppZk5jVTF2ZWdxQ1BQZTNhRmM2ODJWMDZRWmoxMDM5?=
 =?utf-8?B?N1A0QjNnSllxZzZaU2FjSE9XMDZuQUZwMnpJUWtlV1paejZHYzJmTzRzRG0r?=
 =?utf-8?B?SmhnbDFiQzQvM1BwQ1ZmWDBYcWhEcWdmWisyVXM3YngwRnRCejhyWVlmaEF0?=
 =?utf-8?B?WDNZQmNiMVVMankrZjJZRXUzRUt6OFVZL2g1N1AySFhyMGd5SmlJcXFVSnFW?=
 =?utf-8?B?SmdXbzJnTnpSWlkvUGZzTjNJeXVuQzhmNFhQNGxuZk13ZE84RWttUjlaakhn?=
 =?utf-8?B?OFlJUW1PbFNwRjBIWWNoS0todktTcFhXc3dtNUtaV3NGMXdyWDlvUUcvSG1S?=
 =?utf-8?B?OXh1T2NpNkNGU21VenBiaDIyYzVZRFE4TllQeXpyK29mcnYyblhNVzJRQll5?=
 =?utf-8?B?bUIwczUvQ1lPZWpvTXpEcSs0MUVvMDA1S21NbjN1S2F5RENuZlRJU3lCQU9P?=
 =?utf-8?B?VTRlbGs4T0JCUkxsZmJIUVBxZzFQN2JNUFBLT09FeHlhZW9qa2RrSjBDaEQ4?=
 =?utf-8?B?cTVPZXRpeEdXdUJ2WWZ5cXVISmlnRmN3bVdIMGxGRkZGVk9KOExRdE5nTzBX?=
 =?utf-8?B?Qk5HcEFmV2s4bFA2SjZ5ZTdiNGhZWlJvUS9vWUxMa2dHeE5kMFBwVTVhS2M0?=
 =?utf-8?B?ZitvT0F3ZmVQS1ZVTUJ3eDlBVDdxZi9TMGxubjhneDNoYU5tNW9pV2JWR05Y?=
 =?utf-8?B?elVpakZsTUt1a3d6YWl3VTNGeU5nTDJmeEF0UjVCcXcrbHhzWHIvOTk3aEZD?=
 =?utf-8?B?Z1p6U0dOYXp0NVhYamVabXdxK2dPcmJZU0xiRCtqdHZ0OSt2NW5WcGVIK0hn?=
 =?utf-8?B?OU9ndlFNN2xMLy9oYXdqM2swQUxRU0tic0tLbWpZNm1FMXFzdWRQL1dUUTJh?=
 =?utf-8?B?Ui81U09HcUJyT0s4M3dyVCtUeHJwMStPZW5uT0pCNVJJMm1hd2NTR2JFcGNG?=
 =?utf-8?B?TmY3YWRGM3BtL1Q5UnRKRWg1YlFQUHBNNTBEZlU5R1M3eENRZ0xyN3FKMXR4?=
 =?utf-8?B?RXdYTHE5Njh0Z3QyV2gvWE9hZkNzQjMvNUVIbWFxQXdXZ1c1MHBTNklOTEJ6?=
 =?utf-8?B?bHpGaEQ3ZUlVQnczZHN2ZWduWXZERDJ4OTBsaFkzdnZDWmlyTGc3dzdlVytv?=
 =?utf-8?B?dzlKekdLd1FldG5NQStBM3ljei9OTVdvWGs3WjhOSFMrTGhxN0lXaHlUUG0z?=
 =?utf-8?B?OTJaa0hmNG91RERldmZJOVZDa3l2MDZTTC85enhjRnpLZWJGc2VLVVFWOU50?=
 =?utf-8?B?QXFlTmM0aUFpSm1tWEhUR0JUK05DRGxYbU9XN0tUckp5eE12NkxBc01rV0Fm?=
 =?utf-8?B?c0tXN0J5Wm4xNms0cEttRW94VkdWcEZvNHBGRSt5UmdBODRJRFlwSEpEeHI2?=
 =?utf-8?B?MStpSktKNFdhcmFCNGh3ekV3Z0hIRzlIRFNLRnJ2Y0R6MVF3Q0Q5ditObGVo?=
 =?utf-8?B?RXdNSng3MVNlQ2lGRW9YekF6UURrdS9NeXdVWGpzZjgreUJpUU5PRDZHL2Uz?=
 =?utf-8?B?OWdHaFdLRDRkTUdYSXZaS0lTbXEzRHBxM2tuWXRDaDRWNnQrOWJUcmt2cEpw?=
 =?utf-8?B?U3ZRaXVBN0NRNkQwUVFYT0ZSSmVncytScXYzQ3NnYmJScnlBRHE4ckJnb001?=
 =?utf-8?B?V1lEQ0xLa2RtaWN4SlJkc3BMWE9RdDBRZk90QUkva3pra01rbi9JR0RzblhJ?=
 =?utf-8?Q?Dkys0IujaRjAO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4456.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGtVTTU5eTRpOGtJcmhPQ0RlNnJmQlcvWmRaVDVQYWVKRG9uM3NPcitBeHpY?=
 =?utf-8?B?dituWmFhdHdoYTNnRUdKdDB6aEJ1KzREbkhOU2JrM1hsaVJqR1k0TER3bkMr?=
 =?utf-8?B?alBVbzkyWWVSbmJlZnlodEZVenNDT01QN290UHAveWZwMVN0MVNwNUZqVG1D?=
 =?utf-8?B?UDcwVU4yU0JTcG52bERVekMzM2RjY2tTQW95aW5tNndVTkI1eStpdEVUYk03?=
 =?utf-8?B?VkhkOExySGl6c3ZQNGUzTGZSU0hUUWFwcUh3Y3RwRzVyeDNRTjdpYjlWUE1k?=
 =?utf-8?B?Y0ZXR2NlenBFQnhxc1VYQUhnb2l6aFNXeFZRSTkvN3NHQnBoZk41dG12ZEJ1?=
 =?utf-8?B?dUtGM0s3ZERnaXYrR3ZaQ1NJOHNGN2RaR1ZsaXFTUW10bXBBVTltTmh6VjZC?=
 =?utf-8?B?dFAvRjErWEpvZVJQc1ZPbWxzSk1DUlNmYjRvRGwyUzZmUVVHbzQ2TXVHbE51?=
 =?utf-8?B?MHI3bWZNWkdKdTJ0SWg5KzBLeE1sRWRTYjdGMWVYelRGbjJaWWVWOUc3RVR1?=
 =?utf-8?B?VVFCU2xhbnlULzY2NGRnKysxMFpubEt1Z3FwbHRHRXNYdGVjd3cxallKRENV?=
 =?utf-8?B?bm40UVpOaWhrR1VOWURXYllzc0xuTEhlTElZaXZyNXBUdWY2OHJHK0FIVWpD?=
 =?utf-8?B?eUhYd2lrS1l4K1F6aTNtRnZvT0p5SFQrU29LYXVUd0JQeVFDaG1aOU1helI3?=
 =?utf-8?B?YnZiSGtLZE1RRkxzU2ViaVJoOWRCOGF2eEcvUmJacE5wWEg5a1FSWCtwMENh?=
 =?utf-8?B?TXBmWkYvTVRPbFdRNlM1L0RYSnhycHpQZk5RK3hEdWtST1I4S3hERU5MNlh2?=
 =?utf-8?B?ZzFaNW5rSmltRERhMG5odmtuUTgxQTBId0YyaWNhWWxjS25wblJlcldTcDNp?=
 =?utf-8?B?WnlzeGIxZnJaYzdhbHZEbGxPbUN4bVlOTVcvaWg2YW1YYlpZR1VzTVlDamVG?=
 =?utf-8?B?WTJGOW1sU2tPYmxMK3pMbkZmb2cvWlppQTJ6MVdkR3ozaFVDT1VMbGcybVRP?=
 =?utf-8?B?OGRRMmU5V0U5TmVuZ3NJbUdMcGk1b0lkdGkzSnh0K3EwdHFJZzhseCtIL2F6?=
 =?utf-8?B?bzdvblhaUEtGUWdQSG0wcHVxUFhXMUJLZEZlWVNrdjB2OVF1NlA2ZFVzbVhx?=
 =?utf-8?B?QnhiajdmZWhzWk81bnBSSFV0dXcwc2ZHTVIwZWR2ZHpEVzVlbllORThxYTN6?=
 =?utf-8?B?L1BVeHdPTlNuMkJrUkZBd0FHQXBTTFJoWmR3cVpSa0JPa3pRTG5hNjZVUWlQ?=
 =?utf-8?B?VFRFUnR0UUtRWHJUWjYwTjJSNFgxM1NrU1pzMHNob2xPdUxxbjIyaGo2b1Ix?=
 =?utf-8?B?VkI4UUVVSlhWMHoxUm5NZU1XY2pGSFF4SHdKYWlaWmpiQ0ZUYjh5YzYxT0sv?=
 =?utf-8?B?UjNVRFFMV2h2QUxrek1uUmJpQVNWdjdsR0NIc3pqWkN3UDlaeVQ1WFROSDRH?=
 =?utf-8?B?MUlBbXNVVXh3bkFSb0J1VG0yTTRCdWp6TEhSUUhaMjczZ3c4R09ta0FLeGVH?=
 =?utf-8?B?bmgyUndOZFV0VU9DUjRYaHV3ZTJxMlFKbXg1ZTJjeklmWWszejlLS1ZtNnFk?=
 =?utf-8?B?ZWUvTU5lRXlXejJOS2pCR0FDU2Q1TkZIcThkdk1SYmk3S1FTZ29iQXVoRVdY?=
 =?utf-8?B?TDl1WGlwTEJ5dUczbUpTcXNFN3BwaFI2THRPUFB6NXRoV0xxNXNkc3Y5MVZE?=
 =?utf-8?B?Z0g2MkJPd1RVUE1SS3RkME9xbW41OWZBU3h4ZG16UmpMRlNFRCt2VHJNS1VN?=
 =?utf-8?B?MlJCZU94SjRQYXppWlVDOFBFRUJ3L2U4aEhsanQ1UnpRYTRwdGVnUnJJSWdr?=
 =?utf-8?B?bEtTVEh5RmFKU2FIdGFjSEhiMWkrM0pTV0R1VjFWdm1PS1kzL2NuVGcvRCt2?=
 =?utf-8?B?aUFrSVgwOU9WU3RuRUR6ZHBPUitSVmlGV3FKanRhR3dHcldCdUtYZkpaeWRG?=
 =?utf-8?B?cXk3ZFJkU2hrTUZhZVQySlZhbGhWdzJ0cUZIa1I1MVdMTFBjUXZuOVVMZHd6?=
 =?utf-8?B?NThwbmxWRnZ2MVlLZzVxT2FYNVQxaC85NCtVbmM4NWczZ3ZlRVMrWndCbVRD?=
 =?utf-8?B?c1FxR3M4a3F5ZWNrQ1RDNjRiUTV3TFdiYUM5QTZDOWlDMjNoQjhwR3JNSUlo?=
 =?utf-8?B?MzNtbHdWTjMzWVVaSEtRZHh2QUJaWGdzajBoRFZ1UDlMQkhTdEpBd2RqNjZv?=
 =?utf-8?B?cU8ySlpjN2tjWkZaRzdRVWR3OUllRHhxMFlyaWFEcWRzdVlXRlBEMU5QdWZa?=
 =?utf-8?Q?b8uq0dhWmCt6kJzxwP7A/QQYmwW0r9mQkZqd4u673E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB4456.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fea71c4-7bc0-46d0-f7aa-08dcf9cb5d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 16:45:01.4230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rl0n6xnPfhoVMRLDtDcq/5QC5hXjM2U3vLlXFaWD966HKSqOrGk6UqF7CtYx7UekFmxPd/0bPsISjEdppoc9Fxg5io5xj6FHC4S6PZSyu764ZmB/5QguONvU5zLNTkkr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9727

DQpGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+IA0KU2VudDogVGh1cnNk
YXksIE9jdG9iZXIgMzEsIDIwMjQgMzozMSBQTQ0KPiBPbiBUaHUsIE9jdCAzMSwgMjAyNCBhdCAy
OjI44oCvUE0gTmVhbCBDYXJkd2VsbCA8bmNhcmR3ZWxsQGdvb2dsZS5jb20+IHdyb3RlOg0KPiA+
IE9uIFR1ZSwgT2N0IDI5LCAyMDI0IGF0IDEyOjUz4oCvUE0gRXJpYyBEdW1hemV0IDxlZHVtYXpl
dEBnb29nbGUuY29tPiB3cm90ZToNCj4gPiA+IEFsc28sIGl0IHNlZW1zIHRoaXMgcWRpc2MgY291
bGQgYmUgYSBtZXJlIHNjaF9wcmlvIHF1ZXVlLCB3aXRoIHR3byANCj4gPiA+IHNjaF9waWUgY2hp
bGRyZW4sIG9yIHR3byBzY2hfZnEgb3Igc2NoX2ZxX2NvZGVsID8NCj4gPg0KPiA+IEhhdmluZyB0
d28gaW5kZXBlbmRlbnQgY2hpbGRyZW4gd291bGQgbm90IGFsbG93IG1lZXRpbmcgdGhlIGR1YWxw
aTIgDQo+ID4gZ29hbCB0byAicHJlc2VydmUgZmFpcm5lc3MgYmV0d2VlbiBFQ04tY2FwYWJsZSBh
bmQgbm9uLUVDTi1jYXBhYmxlIA0KPiA+IHRyYWZmaWMuIiAocXVvdGluZyB0ZXh0IGZyb20gaHR0
cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvcmZjOTMzMi8NCj4gPiApLiBUaGUgbWFpbiBp
c3N1ZSBpcyB0aGF0IHRoZXJlIG1heSBiZSBkaWZmZXJpbmcgbnVtYmVycyBvZiBmbG93cyBpbiAN
Cj4gPiB0aGUgRUNOLWNhcGFibGUgYW5kIG5vbi1FQ04tY2FwYWJsZSBxdWV1ZXMsIGFuZCB5ZXQg
ZHVhbHBpMiB3YW50cyB0byANCj4gPiBtYWludGFpbiBhcHByb3hpbWF0ZSBwZXItZmxvdyBmYWly
bmVzcyBvbiBib3RoIHNpZGVzLiBUbyBkbyB0aGlzLCBpdCANCj4gPiB1c2VzIGEgc2luZ2xlIHFk
aXNjIHdpdGggY291cGxpbmcgb2YgdGhlIEVDTiBtYXJrIHJhdGUgaW4gdGhlIA0KPiA+IEVDTi1j
YXBhYmxlIHF1ZXVlIGFuZCBkcm9wIHJhdGUgaW4gdGhlIG5vbi1FQ04tY2FwYWJsZSBxdWV1ZS4N
Cj4NCj4gTm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoaXMgYXJndW1lbnQuDQo+DQo+IFRoZSBkZXF1
ZXVlICBzZWVtcyB0byB1c2UgV1JSLCBzbyB0aGlzIG1lYW5zIHRoYXQgaW5zdGVhZCBvZiBwcmlv
LCB0aGlzIGNvdWxkIHVzZSBuZXQvc2NoZWQvc2NoX2Ryci5jLCB0aGVuIHR3byBQSUUgKHdpdGgg
ZGlmZmVyZW50IHNldHRpbmdzKSBhcyBjaGlsZHJlbiwgYW5kIGEgcHJvcGVyIGNsYXNzaWZ5IGF0
IGVucXVldWUgdG8gY2hvb3NlIG9uZSBxdWV1ZSBvciB0aGUgb3RoZXIuDQo+DQo+IFJldmlld2lu
ZyB+MTAwMCBsaW5lcyBvZiBjb2RlLCBrbm93aW5nIHRoYXQgaW4gb25lIHllYXIgYW5vdGhlciBu
ZXQvc2NoZWQvc2NoX2ZxX2R1YWxwaTIuYyB3aWxsIGZvbGxvdyAoYXMgbmV0L3NjaGVkL3NjaF9m
cV9waWUuYyBmb2xsb3dlZCBuZXQvc2NoZWQvc2NoX3BpZS5jICkgaXMgbm90IGV4YWN0bHkgYXBw
ZWFsaW5nIHRvIG1lLg0KDQpUaGlzIGNvbXBvc2l0aW9uIGRvZXNuJ3Qgd29yay4gV2UgbmVlZCBt
b3JlIHRoYW4gMiBpbmRlcGVuZGVudCBBUU1zIGFuZCBhIHNjaGVkdWxlci4gVGhlIGNvdXBsaW5n
IGJldHdlZW4gdGhlIHF1ZXVlcyBhbmQgb3RoZXIgZXh0cmEgaW50ZXJ3b3JraW5nIGNvbmRpdGlv
bnMgaXMgdmVyeSBpbXBvcnRhbnQgaGVyZSwgd2hpY2ggYXJlIHVuZm9ydHVuYXRlbHkgbm90IHBv
c3NpYmxlIHdpdGggYSBjb21wb3NpdGlvbiBvZiBleGlzdGluZyBxZGlzY3MuDQoNCkFsc28sIHdl
IGRvbid0IGV4cGVjdCBhbnkgRlEgYW5kIER1YWxRIG1lcmdlci4gVXNpbmcgb25seSAyIHF1ZXVl
cyAob25lIGZvciBlYWNoIGNsYXNzIEw0UyBhbmQgQ2xhc3NpYykgaXMgb25lIG9mIHRoZSBkaWZm
ZXJlbnRpYXRpbmcgZmVhdHVyZXMgb2YgRHVhbFEgY29tcGFyZWQgdG8gRlEsIHdpdGggYSBsb3dl
ciBMNFMgdGFpbCBsYXRlbmN5IGNvbXBhcmVkIHRvIGEgYmxvY2tpbmcgYW5kIHNjaGVkdWxlZCBG
USBxZGlzY3MuIEFkZGluZyBGUV8gb24gdG9wIG9yIHVuZGVyIER1YWxRIHdvdWxkIGJyZWFrIHRo
ZSBnb2FsIG9mIER1YWxRLiBJZiBhbiBGUV8gc3VwcG9ydGluZyBMNFMgaXMgbmVlZGVkLCB0aGVu
IGV4aXN0aW5nIEZRXyBpbXBsZW1lbnRhdGlvbnMgY2FuIGJlIHVzZWQgKGxpa2UgZnFfY29kZWwp
IG9yIGV4dGVuZGVkIChpZGVudGlmeWluZyBMNFMgYW5kIHVzaW5nIHRoZSBjb3JyZWN0IHRocmVz
aG9sZHMgYnkgZGVmYXVsdCkuDQoNClJlZ2FyZHMsDQpLb2VuLg0K

