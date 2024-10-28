Return-Path: <netdev+bounces-139619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD279B3944
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1179E1F229A7
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005DA1DF990;
	Mon, 28 Oct 2024 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="MZnZcnx1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5E1DF989
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140638; cv=fail; b=RtEbif2yEABF8aln0U2oDLvViU7A4nigyhLtkoQIk8b2/fVJ1Gb8uanePEzqzlRt2J5CJNdnMtAMKc1OKmyv/iSgg+Vv8mgxR6NkzurvJBkuYqmnHNfwUNZFPP60Mpb1l3g6sLu/6amhbrTExKh5dlJL4bsrOZUwtX+QGQJ8YKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140638; c=relaxed/simple;
	bh=AyVi8ICQR8JVzKGCXr0TUdtz9m+Qp7UboKyPQXS/D2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lqEPgJnykbMOIcbeWO8nRmGRCPAOPiz3NuQGqxAe8AEmvadH0dZmH2t/MjyxlnJRUclt2XUlnKcugv2p6G8rZnAL4YXK7JPPneNv/ZeGXR3+wFtroZl4Tyz7elo1VsF3r0ZigAQ8cwS7X4Wclg+b30//tjFs2o++ypDjT4ynUAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=MZnZcnx1; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chYf3oIy5GUdpxDyYLyYuV0yRMVcF3Y0PYjl6T6q+vXnbRggLcCvSLzyCfleb8PK2sMPWoY22F056IqYhdGTsjSpmu4Xpdn31FpRNZ9GVzQK+KSgO9XByFT2vu3MAp3D+v1pbGmrTUx7UQrQdLgxS6usggbgJ9TSKpxB+1yx6O5Sb0zrSAH//cbLoWd7Z2eVQqW/HSpgVL+UO6vB2uM4BB9dLX6+xSQzDXqVkiS/BDWodjbYIWS/exHtIAKv155QHp2Mhb3R7zfEz8Dc1/KLAjSsqeZcjFOW3aCiKqL0/bnRoVaIflkFb9U0Jkb4vzoTKQKCIhgI1KtE76lgU9ZR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyVi8ICQR8JVzKGCXr0TUdtz9m+Qp7UboKyPQXS/D2g=;
 b=RNxeo9YaZ/rMEyZHba0Cd1WTwWWMQ5BmZkV49KB6BgMmKulF/lFwpZLOINqCiTPWDKYpmB9fyHMTzGQKu5azv0wgJCqLliVfmU4/qgWZ1Pblga/JAz/2nj6QFV3WCIdXOqVp0jUc9vs1OYzcgZWourN+HFKb2RqqsxvaZUu1aEakQ8nC4gPqGKEyTyphgXhy+1ObRuMtggGQuHX1XuIcUuC2tRr0ao2KRKcu2rGktkaHwC3maLyIGoEmVsX4cOXb8Oa+uDRiXrxwRq5SnBHTBYsVJdiRNy5840vzTg5kM+ObHv2TeBZbfC+Xiy3UaR3oZxj0RMAUIXrNn1ZHeUntSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyVi8ICQR8JVzKGCXr0TUdtz9m+Qp7UboKyPQXS/D2g=;
 b=MZnZcnx1ya3dO4pcHog+AeKuH1ELv9WpBg4a4WqsaZdxjUeXdR/16rOOkYpSWfFGOpzeev/3eoCxY2MwTfhO5yWwj3L03KTwnjcQSXsp6OEf199hJgWPCbjHADIFJL+KyflqXWwGo/9OSxWHpMwrtqv4TQeCPSTDi/+YPdcOFDIqNdu1Of+dr8fG4FKZ6YsglpS4P642p0AayvAdMJXAUNVM31fS2ag1bLyQLhvpPMKTBPSxmvYE8s/5PDXN1/NqFm/H684HqEXI1uxh7F1gmvJaogYdqlYzBZkbdX3knKfOmf+zmWKEqfffkgnB1L+lH5MwhSNc9ug2JdBdQusffg==
Received: from AM6PR07MB4456.eurprd07.prod.outlook.com (2603:10a6:20b:17::31)
 by DB9PR07MB7849.eurprd07.prod.outlook.com (2603:10a6:10:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 18:37:11 +0000
Received: from AM6PR07MB4456.eurprd07.prod.outlook.com
 ([fe80::9dad:9692:c2c3:1598]) by AM6PR07MB4456.eurprd07.prod.outlook.com
 ([fe80::9dad:9692:c2c3:1598%4]) with mapi id 15.20.8093.014; Mon, 28 Oct 2024
 18:37:11 +0000
From: "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>
To: Dave Taht <dave.taht@gmail.com>, "Chia-Yu Chang (Nokia)"
	<chia-yu.chang@nokia-bell-labs.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>,
	Olga Albisser <olga@albisser.org>, "Olivier Tilmans (Nokia)"
	<olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, Bob Briscoe
	<research@bobbriscoe.net>
Subject: RE: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Topic: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Index: AQHbJAZucSW+6b+sVkmTjRB4hLlQJ7KZabiAgAMGZKA=
Date: Mon, 28 Oct 2024 18:37:11 +0000
Message-ID:
 <AM6PR07MB4456C6F8010187F5783D959BB94A2@AM6PR07MB4456.eurprd07.prod.outlook.com>
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021221248.60378-2-chia-yu.chang@nokia-bell-labs.com>
 <CAA93jw7G+CiLMdcQke5ZkCH90Y21CXjM7L2-cQriXDfXxfG8dQ@mail.gmail.com>
In-Reply-To:
 <CAA93jw7G+CiLMdcQke5ZkCH90Y21CXjM7L2-cQriXDfXxfG8dQ@mail.gmail.com>
Accept-Language: nl-BE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4456:EE_|DB9PR07MB7849:EE_
x-ms-office365-filtering-correlation-id: d542358d-a4a5-44d3-45b1-08dcf77f8929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWNYeU9NNEVwSlM5bDR6Z2pST3RBQWIzeHFtRVgzWlhwOXFwelJXcVdFaXAr?=
 =?utf-8?B?R3FRNmdodjNtV1JVNi9OTHNrQW9PZjQrdEYzN3dWT05iVEp1QlArQ1pQVnB5?=
 =?utf-8?B?a3psNGF2UEdLMWxDaXpHOUZVMUF4ZlU1WFZSdlN3RTRLNGcyQkxpTWx1Nm4z?=
 =?utf-8?B?UmdGUENBZG50TWRmUXhqdi9FM205SW5FQnNsdHh0NzQvZERnNnlqQllFcGhw?=
 =?utf-8?B?b2F6UlJyenljS0V0UGxPaFlLWnFZaXFlWmhmc0ZEMWEyYWtVVDhWcU1rdXVn?=
 =?utf-8?B?eHREYTY1N3JuWElvU1hneE8yYXB0MmVjYWJ1RU1xVGFiR24zdHNVQ3llMGgy?=
 =?utf-8?B?YllnV3lBV05GZitHbkxncVVGRDRLYmtRWGpNanFkS3h5SkwxejNkVVBNSDdK?=
 =?utf-8?B?emtjZ24rNmdHenc4YThGOUZNM3lCbVBRalo5aGEwUUxpaTBTck1ZL1o3WFk3?=
 =?utf-8?B?VHVMQTBPR0lyL0NqbGNPOXJCV2d3L1FyR3hxT1BzZXlxMWFEdVVJbjRTdDlj?=
 =?utf-8?B?T1RpRlF3clFoTGxIWmZUVDA4eVRoTjV1MmxCeXNxNWxzeXlqbzZ3VzFya2dm?=
 =?utf-8?B?U1JrTURuemZPT3Z4WVpZcUFQMXAvcDc2Z3M1d29UbXhRVkdyMVk5azdUcEsx?=
 =?utf-8?B?YllHRFpxaGxiTkkvejEzamJlVHN3S2cwQnY2L3RoVit4S3ZxR2dqTy9SVWdS?=
 =?utf-8?B?STlMRGRmWW9EVXdCOXVUbnN4c01NZ2dyeUFrTk5nYUdOWjBvOEhZeHlEOURW?=
 =?utf-8?B?VDhydlJiVjlNT2o4bHBJblFxdVo1VUFzRkdaNnQzeDRubm1SVDliNVZJUUhr?=
 =?utf-8?B?TGdVOHpLMmRZdFREODFTVHRGVk5DbytvNG40Z1pEajZubzJBa3lwZDdoTGlS?=
 =?utf-8?B?RE8xYnRJUHM0YnIxb1FBRmRGcFBHYzlCMmhaN2wva2M5Q2x1R0tOa2V2NEdJ?=
 =?utf-8?B?a1ppZEdQY0Q3YjFSS0F5WkJSNytjNTY0Rm83ajJLdGRvUndpbW15a0tOWDRH?=
 =?utf-8?B?VTBIWHlGSDZQaHdoVnJoMXF0MkJJYXhkaTVDT2JtalVqMDArd0hYbXpNZGxU?=
 =?utf-8?B?R0hJdE1MN1ZOV0NTdW9wRzhMOUtaazJTeEJnN2toaEJXQnVPQzU3TnU5NmhV?=
 =?utf-8?B?Q1V1dWtEdFEwbEQvN0FqelN4NEVwSm14K0NRQytoYUNIdGVReXUxWWMrSU5t?=
 =?utf-8?B?WFF5Q3d5ajl6b3ZTVnhOY1oranp5Smt0VmpveGtiUi9pTzhONThZSlJrWXhY?=
 =?utf-8?B?c3NnVUlyS1NWMGkralFKdVZBeUc5VjVUY29qTC9FSDFKQ3dUQkQ3bHNpd1lz?=
 =?utf-8?B?UGoybFpocUwzeEJHWk5zNllLK0s0czhqc29HWks1cWxzMGhWNGJWQTdSR3po?=
 =?utf-8?B?dTRSTkN0U09BUWVJZjVNbXlGUW5TeGdIOHJTWXExVWZUelQzbXZHODJVb3JN?=
 =?utf-8?B?S21wUTd2YWZGeEROYk1KV1dnL2Z2WWZua2xyejE3V2hZRjE3R1ZqK2NLLysx?=
 =?utf-8?B?bTdsMlVaSFBDRWp3MStMTUdZdGtZaVZka0NrMUNtWlZ3d0pNQkNwYXZJdVRt?=
 =?utf-8?B?ajdVVVFhZmJBR0lsVFlZb21DMTlEb0NJM1V2bVA4Y2lpMkxQRzkva3YxbDhV?=
 =?utf-8?B?TFNzV3J0ejhwMzk2UjFTQ1N6aTEwYjN4VXV6QXJDY1AySHRGTXFmYUg3NGdx?=
 =?utf-8?B?Z2ZUZmxwSWNHOE5zUGVublJRQnBkZERtcFJBR29FRDZsT2wwc1REcEY1SU9M?=
 =?utf-8?B?S1NoWVdtTWNtRFVEeENPU3NjZVdvNjlpb3dwNFl2OFozOThKYkk3QiszRzlK?=
 =?utf-8?Q?6vxaBZ3o/ru8cbCpAAR9n4DeSOyy4bSQ0/fIY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4456.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?US9yVWxPZ3RDalpGQnhnUURVNUVnV05VRmNmUVo2UEFldXFZa0xvNzN1N21v?=
 =?utf-8?B?b0NzT0o3OFlrMVk0dys2L2lHbC92d3NHd2lQY1I5ME4rWkRDbVQ1SlJaQXhk?=
 =?utf-8?B?N2hSRlNuZVc0ZUVTWHh2emt2dk45OFlhOTAxakZvZ2ZlSS9SSm8vdEdHcjlW?=
 =?utf-8?B?a3kyYnJKOElsd21GSFdMclVYR0RYRDlId0RQK2IxSll2aCtYdkF4TjNqVW9H?=
 =?utf-8?B?bStaV0Y3YW81dHVuUS9VV3dZTldXZDQxWUR2Y0FRckVHY0IxQnRtcHNuZjJQ?=
 =?utf-8?B?SUtaYmllWEYvUklnS0ptZnFpQ2IwdWUyc00rRW9iaVNaWjlqYXBiTEZmRUt0?=
 =?utf-8?B?ZHNjZW9GSEVLb3VhNTdVbzJEeHdUc3JseWJrcFR0dmRHTzZVcXVic3lEait3?=
 =?utf-8?B?QTFRWVN3SHFNaWdMQ2FYbmx6UWJHZ09La1NjclVTUWNhOWNhZFZLSUM2OG4w?=
 =?utf-8?B?bVQ2ZGVpQng4Z29ZaXVkajNUcUtKT1RyaXlFL1JoZnBQRFJZWlBuSXVPckRv?=
 =?utf-8?B?ZWhBL1BLM1ZtbzFQSVVxZDh4NWx6V1BYd0dLMTJuS2RLdTMycFJlZW5aWi9i?=
 =?utf-8?B?ZktzaXg1Y0tYQ2ZpMUF0QkplamJDTy81N2pMdzQyQmtUeTFrc0Ywd1piODVh?=
 =?utf-8?B?bUVud1dRK2NtZXQ4QllYTkp5OTNPWGtTOUVtM2d5RU5NVmYzZXo0UCtzMUVu?=
 =?utf-8?B?dVZLa041bEdudko0V1Zkc0Jjd1h6eFl5bG1HOWg2ZENTSHYrYlFSeGZMSjlJ?=
 =?utf-8?B?b0NibXFRVWpGUXV4UUkwd29QLzJneXpicGxhc1pCa0hhRkQ3UDBtanF1SFdB?=
 =?utf-8?B?K0Y4R2VkTkx5QUJNbGMxb1BGbzZRWkx4SG1WMW0wOHVkdUhjOVJ0c29EaXNo?=
 =?utf-8?B?K2c2dzFuZlk3dUY4bWtHWHNpeWtpN0o5aURHT2tXYnFzMSs0OUtUTG0zc0Z2?=
 =?utf-8?B?Ym0vTlhjUW9mYXQ4N3BCY1E4aCsxNkZDNjQ1L1NKeGtLRURUeklSTUI2UGE2?=
 =?utf-8?B?QkVxVHc4bmtDWGtPRm9ZL2o5WlYrQXgzcllBeU1sZGVjd2VlOWwvbE5sbzJt?=
 =?utf-8?B?SVY1TlpEQ2t4ellzaHRKckxGZ2tlL1EvWE1wOEprZzNOZ1pjNUFXeGN3SEht?=
 =?utf-8?B?ejRZV25Ud2k3MkV4T2RvcjQ1bGFKTHkrZ1Y3cGU5aEVnWk4xdGJzUjVNdlFQ?=
 =?utf-8?B?MlJyelJOaFM3bnZGOGFjMW01NThZd3liQzRVRGNUYmUyeWtqVjFnTUpVNlgz?=
 =?utf-8?B?UHoxSUdyL2ZpbFFaSmZjekgwcTA0S3BTRFNPc2UrQ20wYXN0djVLeHBDOEx5?=
 =?utf-8?B?UnlpYWoxYkRpdlQ5OUdtOUVUdXdLQjlCaUN5dWFwbTFNckpSSndEVGxIdEZh?=
 =?utf-8?B?aTVsc00rREI0ZndPNE1QQTZmeHFDbEpHRWlZd0c3bmtiME5ja3UzWGk0SXd4?=
 =?utf-8?B?RFdjaFpmOVphb2RXUUdqMGZOZWVsRzdmN0Z4U3ZPYTVTSmJxMUxhK0JaS2NX?=
 =?utf-8?B?S205M3hXZ3NmMTBGOGpYUFJnYlZ5WlZDK1BTbnd2VDJxK2xaRCszdzhYYjUw?=
 =?utf-8?B?YjZkRnFIQ0pVd2JVeGtMY0c5VUNXbWNPWTBmeW55VGFqWi9tY3FMd213bkRR?=
 =?utf-8?B?c1lLUTFWYzhNYUprTnp4VXpWZVFjeXl4ajFzMXMvVHNvbzRMN0ZzeCt6VmlR?=
 =?utf-8?B?M2l2MkRzVjFFYTEwZ2JFQzlPcDhpa3JNSUFEeXpndG1rNXorUEZ1QjcxNHNJ?=
 =?utf-8?B?RnFMb3kvQktxZFV4WTFTUDhaZzZ5SFFnQXN0ZDhGYWFVZDZRT25wTnRUWXNP?=
 =?utf-8?B?dHEwNm9uN1B5ZitLOTkydmVvTkZ2dW9hNkYwazN0QS9GNVEyVjJIMDY4bkxy?=
 =?utf-8?B?dWRXZnZVcU9IMldhZkVzcDViYzcrQ2lTT0dYZWFtMnRONzMvVzdCcDJ1cEpj?=
 =?utf-8?B?dFJjVldITVZrVjduWEtSWUJaTFF1VWthL0cyNExldTdLKyt1SkllV2tyQVl2?=
 =?utf-8?B?dWJ5bUFyTWFPMTRJdGNPbTAzRVdXK1FXSWtGQmU1Y3BHNis1R3c5Y2RjSncx?=
 =?utf-8?B?RmxSU2RnVEcvVkNzeXkvMlkwK3JRVnhwUkNTNnFFeUpWRmM5Z3VGeGx5SGR0?=
 =?utf-8?B?cFZ5ZUVGbU9TNkxpakQrUnN4V0xidldPQXlZYkVyU2JpMTNDaHhsbjlwdndp?=
 =?utf-8?B?aDE2WHFXV3JmeDBHSFRvakVoUGZ1d0l6enc3WGg2ZWY4T2VGYnNDVm9QUUw1?=
 =?utf-8?Q?y0poFmMXndirc9BI/ELazIxNYyfcsx0NGBideSb3bw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d542358d-a4a5-44d3-45b1-08dcf77f8929
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 18:37:11.3366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywaVPbFcUXcKlMTfuOhi6m0G3dKP4PC7u+CXOZPlHmsyusbUuDVBifjol8WZWS9JLFY8oV11e6wQEMJBRhOLw5aIl1rdwqO+U2Li/d4k0AdrlNXxdCRXpgoXYWGqVXF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7849

U2VlIGJlbG93LA0KDQpSZWdhcmRzLA0KS29lbi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBEYXZlIFRhaHQgPGRhdmUudGFodEBnbWFpbC5jb20+IA0KPiBTZW50OiBT
YXR1cmRheSwgT2N0b2JlciAyNiwgMjAyNCA4OjU3IFBNDQo+IFRvOiBDaGlhLVl1IENoYW5nIChO
b2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4gQ2M6IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IHN0ZXBoZW5AbmV0d29ya3BsdW1i
ZXIub3JnOyBqaHNAbW9qYXRhdHUuY29tOyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5l
bC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGlqQGtlcm5lbC5v
cmc7IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtvZW4u
ZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVsYWJzLmNvbTsg
aW5nZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nz
b24uY29tOyBjaGVzaGlyZUBhcHBsZS5jb207IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdv
b2RAY29tY2FzdC5jb207IHZpZGhpX2dvZWxAYXBwbGUuY29tOyBPbGdhIEFsYmlzc2VyIDxvbGdh
QGFsYmlzc2VyLm9yZz47IE9saXZpZXIgVGlsbWFucyAoTm9raWEpIDxvbGl2aWVyLnRpbG1hbnNA
bm9raWEuY29tPjsgSGVucmlrIFN0ZWVuIDxoZW5yaXN0QGhlbnJpc3QubmV0PjsgQm9iIEJyaXNj
b2UgPHJlc2VhcmNoQGJvYmJyaXNjb2UubmV0Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IG5l
dC1uZXh0IDEvMV0gc2NoZWQ6IEFkZCBkdWFscGkyIHFkaXNjDQoNCg0KPiBIYXMgdGhpcyBiZWVu
IHRlc3RlZCBtcS0+YW5fYXFtX3F1ZXVlX3Blcl9jb3JlIG9yIGp1c3QgYXMgYQ0KPiBodGIrZHVh
bHBpLCBhbmQgb24gd2hhdCBwbGF0Zm9ybXM/DQoNCkl0IGlzIGEgcWRpc2MgdGhhdCBzaG91bGQg
d29yayBpbiBhbnkgY29tYmluYXRpb24uIFdlIG1haW5seSB0ZXN0ZWQgd2l0aCBIVEIsIGRpcmVj
dGx5IG9uIHRoZSByZWFsIGludGVyZmFjZSBhbmQgd2l0aCBtdWx0aXBsZSBpbnN0YW5jZXMgaW4g
bmFtZXNwYWNlcy4gV2UgZGlkbid0IHRlc3QgYWxsIHRoZSBjb21iaW5hdGlvbnMuIERpZCB5b3Ug
c2VlIGFueSBpbmRpY2F0aW9uIHRoYXQgbWFkZSB5b3UgZXhwZWN0IHByb2JsZW1zPw0KDQo+IEkg
d2FzIGFsc28gdW5kZXIgdGhlIGltcHJlc3Npb24gdGhhdCAybXMgd2FzIGEgbW9yZSByb2J1c3Qg
dGFyZ2V0IGZyb20NCj4gdGVzdHMgZ2l2ZW4gdHlwaWNhbCBzY2hlZHVsaW5nIGRlbGF5cyBhbmQg
dmlydHVhbGl6YXRpb24uDQoNCkl0IGlzIGEgcGFyYW1ldGVyIHdpdGggYSBkZWZhdWx0IG9mIDFt
cywgd2hpY2ggaXMgYSB2ZXJ5IGFjaGlldmFibGUgdGFyZ2V0IG9uIGV0aGVybmV0IGxpbmtzLiBJ
ZiBpbiBjZXJ0YWluIGRlcGxveW1lbnRzIGl0IGlzIG5vdCBhY2hpZXZhYmxlLCBpdCBjYW4gYmUg
cmVsYXhlZCBpZiBuZWVkZWQgd2l0aCBhIHNpbXBsZSBwYXJhbWV0ZXIuIE9uIHdpcmVsZXNzIGxp
bmtzLCBkZWRpY2F0ZWQgaW50ZWdyYXRpb24gd2l0aCB0aGUgZHJpdmVyIGlzIG5lZWRlZCBmb3Ig
YmVzdCBwZXJmb3JtYW5jZSwgYnV0IG91dHNpZGUgdGhlIHNjb3BlIG9mIHRoaXMgQVFNLg0KDQo+
IEl0IGFwcGVhcnMgdGhhdCBnc28tc3BsaXR0aW5nIGlzIHRoZSBkZWZhdWx0PyBXaGF0IGhhcHBl
bnMgd2l0aCB0aGF0IG9mZj8NCg0KSXQgbWlnaHQgd29yayB1bmRlciBjZXJ0YWluIGVudmlyb25t
ZW50IGNvbmRpdGlvbnMgb3Igd2l0aCBjZXJ0YWluIGNvbWJpbmF0aW9ucyBvZiBtb3JlIHJlbGF4
ZWQgcGFyYW1ldGVycywgYnV0IGl0IHdpbGwgY3JlYXRlIHByb2JsZW1zIGluIG90aGVyIGNhc2Vz
LiBEbyB5b3Ugc3VnZ2VzdCB3ZSBzaG91bGQgZm9yY2UgZ3NvLXNwbGl0dGluZyBhbHdheXMgb24g
d2l0aG91dCB0aGUgb3B0aW9uPyBJIGd1ZXNzIGl0IGlzIHVzZWZ1bCBpZiB0aGUgY29uZGl0aW9u
cyBhcmUgcHJlc2VudCBpbiBjZXJ0YWluIGRlcGxveW1lbnRzIHRvIGJlIGFibGUgdG8gZGlzYWJs
ZSBpdD8NCg0KPiBXaGF0IHdvdWxkIGJlIGEgZ29vZCBEQyBzZXR0aW5nPw0KDQpUaGUgYWxwaGEg
YW5kIGJldGEgcGFyYW1ldGVycyBhcmUgbm90IG5lY2Vzc2FyeSB0byBiZSBzZXQgZGlyZWN0bHku
IFRoZSBlYXN5IHdheSB0byBjb25maWd1cmUgRHVhbFBJMiBpcyB0byBzZXQgdHlwaWNhbCBSVFQg
YW5kIG1heCBSVFQuIFRoZSBvcHRpbWFsIHBhcmFtZXRlcnMgYXJlIGRlcml2ZWQgZnJvbSB0aG9z
ZS4gU28sIGZvciBhIERDIGl0IGNvdWxkIGJlOg0KICAgICBBdXRvLWNvbmZpZ3VyaW5nIHBhcmFt
ZXRlcnMgdXNpbmcgW21heF9ydHQ6IDVtcywgdHlwaWNhbF9ydHQ6IDEwMHVzXTogdGFyZ2V0PTEw
MHVzIHR1cGRhdGU9MTAwdXMgYWxwaGE9MC40MDAwMDAgYmV0YT02MC4wMDAwMDINClNob3dpbmcg
dGhlIGZvbGxvd2luZyBmdWxsIGNvbmZpZzoNCiAgICAgcWRpc2MgZHVhbHBpMiAxOiByb290IHJl
ZmNudCAxNyBsaW1pdCAxMDAwMHAgdGFyZ2V0IDEwMHVzIHR1cGRhdGUgMTAwdXMgYWxwaGEgMC4z
OTQ1MzEgYmV0YSA1OS45OTYwOTQgbDRzX2VjdCBjb3VwbGluZ19mYWN0b3IgMiBkcm9wX29uX292
ZXJsb2FkIHN0ZXBfdGhyZXNoIDFtcyBkcm9wX2RlcXVldWUgc3BsaXRfZ3NvIGNsYXNzaWNfcHJv
dGVjdGlvbiAxMCUNCk9yIGFueSBvdGhlciB0eXBpY2FsIHZhbHVlcyBjYW4gYmUgdXNlZC4NCg0K
V2Ugd2lsbCBjbGFyaWZ5IHRoaXMgYmV0dGVyIGluIHRoZSBkZXNjcmlwdGlvbiBhbmQgbWFuIHBh
Z2VzIGFuZCBwcm9tb3RlIHRoZSAic2ltcGxlIGFuZCBzYWZlIHBhcmFtZXRlcnMiLiBQcm9iYWJs
eSB3ZSBzaG91bGQgYWxzbyBsaXN0IHRoZSAiZXhwZXJpbWVudCBhdCBvd24gcmlzayIgcGFyYW1l
dGVycy4uLg0KDQo+PiArICAgICAgICBuYW1lOiBtYXhxDQo+PiArICAgICAgICB0eXBlOiB1MzIN
Cj4+ICsgICAgICAgIGRvYzogTWF4aW11bSBudW1iZXIgb2YgcGFja2V0cyBzZWVuIGluIHRoZSBE
dWFsUEkyDQo+DQo+IFNlZW4gImJ5Ii4gQWxzbyB0aGlzIG51bWJlciB3aWxsIHRlbmQgdG93YXJk
cyBhIHBlYWsgYW5kIHN0YXkgdGhlcmUsDQo+IGFuZCB0aHVzIGlzIG5vdCBhIHBhcnRpY3VsYXJs
eSB1c2VmdWwgc3RhdC4NCg0KVGhhbmtzLCB3aWxsIGJlIGZpeGVkLiBUaGUgc3RhdHMgY2FuIGJl
IHJlc2V0LCBzbyBjYW4gYmUgdXNlZCB0byBmaW5kIHBlZWsgcXVldWUgb2NjdXBhbmN5IGluIGFu
IGludGVydmFsLiBDYW4gYmUgcmVtb3ZlZCBpZiBwZW9wbGUgdGhpbmsgaXQgaXMgbm90IHVzZWZ1
bC4NCg0KPj4gKyAgICAgICAgbmFtZTogZWNuX21hcmsNCj4+ICsgICAgICAgIHR5cGU6IHUzMg0K
Pj4gKyAgICAgICAgZG9jOiBBbGwgcGFja2V0cyBtYXJrZWQgd2l0aCBlY24NCj4NCj5TaW5jZSB0
aGlzIGhhcyBoaWdoZXIgcmF0ZXMgb2YgbWFya2luZyB0aGFuIGRyb3AgcGVyaGFwcyB0aGlzIHNo
b3VsZCBiZSA2NCBiaXRzLg0KDQpBbGwgcGFja2V0IGNvdW50ZXJzIGFyZSB0eXBpY2FsbHkgMzIg
Yml0cy4gV291bGQgbmVlZCB0byBiZSBjaGFuZ2VkIGluIGEgbG90IG9mIHFkaXNjcy4uLg0KDQo+
PiAgICAgIG5hbWU6IHRjLWZxLXBpZS14c3RhdHMNCj4NCj4/IGZxLXBpZT8NCg0KVGhhbmtzLCB0
eXBvIHRoYXQgd2lsbCBiZSBmaXhlZC4NCg0KPj4gKyAgICAgICAgbmFtZTogbGltaXQNCj4+ICsg
ICAgICAgIHR5cGU6IHUzMg0KPj4gKyAgICAgICAgZG9jOiBMaW1pdCBvZiB0b3RhbCBudW1iZXIg
b2YgcGFja2V0cyBpbiBxdWV1ZQ0KPg0KPkkgaGF2ZSBub3RlZCBwcmV2aW91c2x5IHRoYXQgbWVt
bGltaXRzIG1ha2UgbW9yZSBzZW5zZSB0aGFuIHBhY2tldA0KPmxpbWl0cyBnaXZlbiB0aGUgZHlu
YW1pYyByYW5nZSBvZg0KPjY0Yi02NGtiIG9mIGEgbW9kZXJuIGdzby90c28gcGFja2V0Lg0KDQpB
bGwgcWRpc2NzIHVzZSBwYWNrZXQgbGltaXRzLiBXb3VsZCBhZ2FpbiBkZXZpYXRlIGZyb20gdGhl
IGNvbW1vbiBwcmFjdGljZS4uLg0KDQo+PiArICAgICAgICBuYW1lOiBtYXhfcnR0DQo+PiArICAg
ICAgICB0eXBlOiB1MzINCj4+ICsgICAgICAgIGRvYzogVGhlIG1heGltdW0gZXhwZWN0ZWQgUlRU
IG9mIHRoZSB0cmFmZmljIHRoYXQgaXMgY29udHJvbGxlZCBieSBEdWFsUEkyDQo+DQo+SW4gd2hh
dCB1bml0cz8NCg0KSW4gdGhlIHRjIGNvbW1hbmQgaXQgbmVlZHMgdG8gYmUgc3BlY2lmaWVkIChh
bHRob3VnaCB0aGUgZGVmYXVsdCB1bml0IGlzIGN1cnJlbnRseSB1cyksIGluIHRoZSBkYXRhIHN0
cnVjdHVyZSBpdCBpcyBub3QgcHJlc2VudCBhcyBpdCBpcyBjb252ZXJ0ZWQgdG8gdGhlIG90aGVy
IHBhcmFtZXRlcnMuIFdlIGNhbiBtZW50aW9uIHRoZSBkZWZhdWx0IHVuaXQuDQoNCj4+ICsgKiBu
b3RlOiBEQ1RDUCBpcyBub3QgUHJhZ3VlIGNvbXBsaWFudCwgc28gRENUQ1AgJiBEdWFsUEkyIGNh
biBvbmx5IGJlDQo+PiArICogICB1c2VkIGluIERDIGNvbnRleHQ7IEJCUnYzIChvdmVyd3JpdGVz
IGJicikgc3RvcHBlZCBQcmFndWUgc3VwcG9ydCwNCj4NCj5UaGlzIGlzIHJlYWxseSBjb25mdXNp
bmcgYW5kIHVwIHVudGlsIHRoaXMgbW9tZW50IEkgdGhvdWdodCBiYnJ2MyB1c2VkDQo+YW4gZWNu
IG1hcmtpbmcgc3RyYXRlZ3kgY29tcGF0aWJsZSB3aXRoIHByYWd1ZS4NCg0KQXMgZmFyIGFzIEkg
a25vdyB0aGUgQkJSdjMgRUNOIGltcGxlbWVudGF0aW9uIGRvZXMgbm90IGltcGxlbWVudCBhbGwg
UHJhZ3VlIHJlcXVpcmVtZW50cyBhbmQgaXMgbm90IGludGVuZGVkIHRvIGJlIHVzZWQgb24gdGhl
IEludGVybmV0IGFuZCBub3QgZm9yIHJlYWwtdGltZSBpbnRlcmFjdGl2ZSBhcHBzLiBUZXN0cyBz
aG93IHRoYXQgQkJSJ3MgUlRUIHByb2JlcyBwYXVzZXMgdGhlIHRocm91Z2hwdXQgdW5uZWNlc3Nh
cmlseSBhbmQgc3RpbGwgZG9lcyB0aHJvdWdocHV0IHByb2JlcyAoY3JlYXRpbmcgdW5uZWNlc3Nh
cnkgbGF0ZW5jeSBzcGlrZXMpLiBXZSB3aWxsIHZlcmlmeSB3aXRoIHRoZSBCQlIgbWFpbnRhaW5l
cnMgYW5kIGNsYXJpZnkgdGhlIHRleHQuDQoNCj4+ICsgKiAgIHlvdSBzaG91bGQgdXNlIFRDUC1Q
cmFndWUgaW5zdGVhZCBmb3IgbG93IGxhdGVuY3kgYXBwcw0KPg0KPlRoaXMgaXMga2luZCBvZiBv
cGluaW9uYXRlZC4NCg0KV2Ugd2lsbCBjaGFuZ2UgaW50byAiIHNob3VsZCB1c2UgYSBQcmFndWUg
Y29tcGxpYW50IENDIGZvciB1c2Ugb24gdGhlIEludGVybmV0Ii4NCg0KPj4gKyAgICAgICBpZiAo
dW5saWtlbHkocWRpc2NfcWxlbihzY2gpID49IHNjaC0+bGltaXQpKSB7DQo+PiArICAgICAgICAg
ICAgICAgcWRpc2NfcXN0YXRzX292ZXJsaW1pdChzY2gpOw0KPj4gKyAgICAgICAgICAgICAgIGlm
IChza2JfaW5fbF9xdWV1ZShza2IpKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcWRpc2Nf
cXN0YXRzX292ZXJsaW1pdChxLT5sX3F1ZXVlKTsNCj4NCj5zaG91bGRuJ3QgdGhpcyBiZToNCj4N
Cj4gICAgICAgICAgICAgICBpZiAoc2tiX2luX2xfcXVldWUoc2tiKSkNCj4gICAgICAgICAgICAg
ICAgICAgICAgIHFkaXNjX3FzdGF0c19vdmVybGltaXQocS0+bF9xdWV1ZSk7DQo+ICAgICAgICAg
ICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgICAgICAgIHFkaXNjX3FzdGF0c19vdmVybGlt
aXQoc2NoKTsNCg0KTm8sIGl0IGluY3JlbWVudHMgMiBkaWZmZXJlbnQgY291bnRlcnMuIEluIHRo
ZSBmaXJzdCBsZXZlbCB3ZSBrZWVwIHRoZSBvdmVyYWxsIHN0YXRzIGFuZCBpbmNyZW1lbnQgZm9y
IGFsbCBwYWNrZXRzIChhbHRob3VnaCB0aGUgcXVldWUgYXQgdGhpcyBsZXZlbCBvbmx5IGNvbnRh
aW5zIHRoZSBDLXF1ZXVlKSwgaW4gdGhlIGxfcXVldWUgbGV2ZWwgd2Uga2VlcCB0aGUgTC1zdGF0
cyBvbmx5LiBJZiBDLXN0YXRzIG9ubHkgYXJlIHJlcXVpcmVkLCBib3RoIG5lZWQgdG8gYmUgc3Vi
dHJhY3RlZC4NCg0KPj4gKy8qIE9wdGlvbmFsbHksIGR1YWxwaTIgd2lsbCBzcGxpdCBHU08gc2ti
cyBpbnRvIGluZGVwZW5kZW50IHNrYnMgYW5kIGVucXVldWUNCj4NCj5CeSBkZWZhdWx0DQoNClRo
YW5rcywgd2lsbCBiZSBmaXhlZC4NCg0KPiBJIGhhZCByZWFsbHkgZ3JhdmUgZG91YnRzIGFzIHRv
IHdoZXRoZXIgTDRTIHdvdWxkIHdvcmsgd2l0aCBHU08gYXQgYWxsLg0KDQpJdCB3aWxsIGRlZmlu
aXRlbHkgYmVoYXZlIGRpZmZlcmVudGx5LCBhbmQgbW9zdCBsaWtlbHkgd29uJ3QgYmUgdXNhYmxl
IGZvciB0aGUgSW50ZXJuZXQuIElmIHVzZWQgYXMgYSBEQyBBUU0sIGl0IG1pZ2h0IHN0aWxsIGJl
IHBvc3NpYmxlIHRvIGRpc2FibGUuIEJ1dCBhcyBzYWlkIGJlZm9yZSwgd2UgY2FuIHJlbW92ZSB0
aGlzIG9wdGlvbi4gV2UgaGF2ZW7igJl0IGZ1cnRoZXIgZXhwbG9yZWQgdGhlIHBvc3NpYmlsaXRp
ZXMsIGJ1dCBkb24ndCB3YW50IHRvIHByZXZlbnQgb3RoZXJzIHRvLg0KDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC8qIENvbXB1dGUgdGhlIGJhY2tsb2cgYWRqdXN0ZW1lbnQg
dGhhdCBuZWVkcw0KPg0KPnNwZWxsaW5nOiAiYWRqdXN0bWVudCINCg0KVGhhbmtzLCB3aWxsIGJl
IGZpeGVkLg0KDQo+PiArICAgICAgIHEtPnNjaC0+bGltaXQgPSAxMDAwMDsgICAgICAgICAgICAg
ICAgICAgICAgICAgIC8qIE1heCAxMjVtcyBhdCAxR2JwcyAqLw0KPg0KPi4uLiBhc3N1bWluZyBn
c28vZ3JvIGlzIG5vdCBpbiB1c2UNCg0KIkF0IGxlYXN0IDEyNW1zIGF0IDFHYnBzIiBpcyBpbnRl
bmRlZC4gVHlwaWNhbGx5LCB0aGUgbGltaXQgY2F1c2VzIHRhaWxkcm9wIGlmIG5vdCBiaWcgZW5v
dWdoLiBUcnVlIGlzIEdTTyBpcyBpbiBmdWxsIHVzZSB0aGUgdGltZSAoYW5kIG1lbW9yeSB1c2Vk
IGNvdWxkIGJlIHVwIHRvIDQwIHRpbWVzIGJpZ2dlci4NCg0K

