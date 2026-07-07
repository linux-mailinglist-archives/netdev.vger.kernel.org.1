Return-Path: <netdev+bounces-305253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ih/sIWJZTGr9jQEAu9opvQ
	(envelope-from <netdev+bounces-305253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 03:41:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 226C5716A4C
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 03:41:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=bEcWGRap;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305253-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305253-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8722B3026AF0
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 01:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E60C30DD10;
	Tue,  7 Jul 2026 01:41:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D008282F03;
	Tue,  7 Jul 2026 01:41:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388510; cv=fail; b=cXwOohrigRsOQDcyyt5j5DkROPLjjLdU4PyUu1Lsn6VuuefVwFPB5SHK/47/Psj3dx5wJNNbHpavLCgMUjRIaYJXaikin6QQFOVNb6E/xzmffi95EgL/SytfIXSauXYYMDQaffkEQ1BDEKUItnk7IaoVzax5dWRnEnME6QfugxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388510; c=relaxed/simple;
	bh=I647hPCPQZJiQ4bv8L2j8kLAo4moS4VqQuErV6ekzNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C8vHwtI+tArmKgf7RrHerJcJSYd90b2clfFnP8nc02YoPvECS2EoalKwg4nMEf3X4bbFvhRehogcsDKSvuWlI2a32GNmOTrbYAd0TYAIhIc/GLg4U+ozCaS4QAOAjFqc8b7e3++KRJAZDHEk+ASwq10rjHkZSrWmsgepjD59wqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=bEcWGRap; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKRIBM0LIiDwqxD1UfBIXqGOXtEj52W6NJc6DD2ukI0g8CtWwXwVKlaWoPLU6l6Bvz+J+70oXx8t/uMhXyvf/fdYtpuq8AhMC63b4E+kczs3gqXRTap2aoHeufNUXNhXfgco/kZYGZcR+mIa+LrbWSDmw+5SasnxHuSc+S3mArAyOHgYf3YF+H6TlylIATdYWtSiurDyIjYaFLs9xYN9ktkEyanOdiYiOlNRcNp2zxLHRYrcSwBEZUb8UeZbH30vjWyMIhtEhXqFF3uYSJH6K0RUx0aeWJNg4Z+8E8zeDJN/AOBy4epOOxnvxpqiAXjJGtJVsPHIYbGC5P8pz9mQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I647hPCPQZJiQ4bv8L2j8kLAo4moS4VqQuErV6ekzNs=;
 b=SNK+d7xgfjDS3dIJKIszgvQHnRkw8BDiIPH2U/5x2sIzpHynq6kUhIjUhEpkoWkaEI7SnJMXscvfFGwSKjUtxAb1bEHSVKRh/Bq2pfuT5oTVCcACmDWdS7ZWtLYuGYd4n7sec3WdVpo67p9Gguu3DXogdPcP4julKvDcJg04EqRWGQ3VoksgTmqB5MjoJBOXdjcd6tglN7SqRDbpwPtSzfhAAVkClmHpbZhBtmGNv32l+bn8zbQ5WP+UXPGAY7KnCK7bi8Adik5cvdy4IFQ7vuQiUBJeRP0xhcY/jOmE1/7bpW45Ed6t2trqmDR39TVf60vD/OXwtSFCkDTiey4gxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I647hPCPQZJiQ4bv8L2j8kLAo4moS4VqQuErV6ekzNs=;
 b=bEcWGRapKZZlFv7oP6LaD1d2zQhMhMOfrEeY3DxMdUGL3d+CMvUqNuCH1nSjOM8bxBhOoqfbbq/z0A9kx4BmX9KS7FZcbQdaMMOkD5NuD+WeLkXeLD4oQHhIDouImrt4tPCsh4ZTyeeg4xsYWIfItcZTcLzX25xPa5+CTa06TZHaMg0f85YzZcogKiO88ArnvEIEBVnC4lSvt+ZelOIzjh0vmqKXIhZ85K2iZGkk2EQTirnRltyEBSmYB/yNJHNVkIeQktpiP+s7jp/4N7znonzaWvOIXHpmjHRC9NTR9OHjjKXUUKTvfBFfCzQSRk1D5V4YwwtD56uLlnyRj5YR0w==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by LV4PR03MB8306.namprd03.prod.outlook.com (2603:10b6:408:2d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 7 Jul
 2026 01:41:45 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 01:41:45 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Thread-Topic: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Thread-Index:
 AQHdCJS3eKbhTF393kOGxrO3eujj3LZXH+EAgAALkICAAAzEAIAAr76AgAC2g4CAAsSkAIAAZs0AgAWIdoA=
Date: Tue, 7 Jul 2026 01:41:44 +0000
Message-ID: <64ddd953-d609-41d9-95d1-c251da6373cf@altera.com>
References:
 <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <edf84080-a5e0-478c-9977-af2376cb71c5@lunn.ch>
 <347c50ed-234a-4f29-b63a-1e0010c6b09d@altera.com>
 <e4cf8d95-0467-4bdc-8e19-228ced3a8bbc@lunn.ch>
 <5a0c962e-1af0-4d6a-b871-d8a0b0197ff5@altera.com>
 <d70a6795-e1a2-43e2-b523-0fc668324674@lunn.ch>
 <b8ca3bd8-af8f-43e7-904c-1ac45512296b@altera.com>
 <bf7c6343-e0c0-47bd-a857-0f1881fc8659@lunn.ch>
In-Reply-To: <bf7c6343-e0c0-47bd-a857-0f1881fc8659@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|LV4PR03MB8306:EE_
x-ms-office365-filtering-correlation-id: d74d762d-4c40-40d9-cfe3-08dedbc8e721
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|22082099003|55112099003|56012099006|3023799007|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 efwmBv39NEAUouFyFQOmYvnBHfzYEYvHTrLV1JDWFGIgHAwJL0w186PHoNEHjlDsS8OuXDIjqeM1ndvA9TslHyYMNMu8WrWN0zCuFH5/4xMforoXUfRpQjcqk8y6WrC5kDH7fZTa2dAL1OwrLVNRKxBhAwwFGL+zZUjP8wJCm+9kHl2vhIbLprlqPZsvZzF/hnsP2Y4Ohv0Y2dclWdvUltoKWVR72pn1PjqBewfS0oxdKM3CWH67W3oLaRXaaREU23TeaCwybV7l52Uxw5QWoytzNX3h+GOCdYyQNj78mAF/QyhdKh3sP/lkCDceRbaZSvZH50M7ydM9EJhIgTyrZlEil7gF7rctAwYmwVXBGrow5yqDKVChoRullzzIsjeyHew3ngfYADZUSo8zWe6hS3HyN806tIP9tNNcr63Tr9FaoawRYNqDRTTMuPzA4oT1cnhHQtxHb+XrYWeyngmBDJUsvLLWloohL/Nq/RX3fJIMkaFZKOw3FgOP/scxued8PGQuOg+JtCwI+4TB499Xb+nwMgvsD1Z8Yi9uhHr5eXyL4hOyZv19jOiwlwwWi/57y2fLAwnTQlJ5l3KiQc/4J2L+C5J+WXHrdANK1A61oWD6jCegPqLYLSmjCM73d1Vdzl2Bh0e0uVGT6urSW51vqgdZhTtCy6+EBBAljmZqaoQsX7TLf2hjBddcFhtIf9b8J/tQ82XgKhnUE3yUD3Ps1nrb4bgB2Rb29bvT7kNBIis=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(55112099003)(56012099006)(3023799007)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHpPQWZ5cFZhWWNhMXhJTm1ES2ZsZmFWeldBY0FRZUhEaTQweC9EVTEySlNC?=
 =?utf-8?B?ZmNpYjU0QWp0dTNnZmNYMStaRnVKdWVqa1k0UkpoWjU4NC9rVHZGdG9Kb1FL?=
 =?utf-8?B?eEk0Z09meWJTczB5M0lkRUhOZzdGaGU5Y01naENZRzA2NGZGeGhFMWZMYjFN?=
 =?utf-8?B?cG5hU2RxN01iaW9WRFExOS82R2RwSHhReGwxSVg2b2l5Vll0NEVLKzVvaDk5?=
 =?utf-8?B?NWhRVSs3WldmWnR0R29lU1hjeDZ4NEJROEc0Vm8reW9BS2FvYVdDS3VidDFX?=
 =?utf-8?B?UFRNZUVNOXdsZWo0MFZUTVJSOTA4TVlXUC81UVNUbGs5U1h4cUhBcjNMQXhW?=
 =?utf-8?B?TVZjNEdkRjk2bnM4ekNGNjRvK1VNR1JKNWsyd3JKOFlDcG9TL3ZLQ2o0SEQ0?=
 =?utf-8?B?bzc3N3BVRGI5a3ZvdklKUm1DNmxONnB6bk9EbXlsamR2MmRBUWo1VDkrTW5O?=
 =?utf-8?B?WWNkU2Q0UUVIZWs3cndjckZOWHZLaW1zc2lPS0lzY2dPaTZxS2xUTjR1enJB?=
 =?utf-8?B?TzFvUE1kcE11U0k5Yi9IMFVpU0FWT1dBRDJkTTZNZHh6dG51eG1QWHFqTVlt?=
 =?utf-8?B?YlQwb081ZjJ0NVd0OTJBdlMxaU1nb2hHdWgvSVBIczZIVGVuMGY3SndYaEgr?=
 =?utf-8?B?UkhvYlQ1VUFmemJaQzZTSi9EL1NNaHZGbVcvNXNLS2FQRTZvMWpOUk1QdzJj?=
 =?utf-8?B?UXNMMklkeDNVd0R6MTJ5Rjd5MVppZzNtaHlCYWlWVmc4STNhR2NMeVdXTEpD?=
 =?utf-8?B?N0pMZnBPeFpIaWd3dWY5UFZWQURxWGJHR3FMU0ZrU1pBK1huY05jQ1hCZzlv?=
 =?utf-8?B?UXQvdGFPK2laRWtNSUJzT0NOS0pac1k0OUkvY0NXQXlOdVdxQ3p4NThaL3RX?=
 =?utf-8?B?RWZHTEpad2pqRVF6bTlGMWZteEszN1BWNlBvbUY1Y3lZNDgvdU42SGpBSUhJ?=
 =?utf-8?B?cTRSQS91MkhaTE9NTVpEN2tVV0FmeG8yODdOVzFaVkVVaHQvbUU0RnR2YjZ5?=
 =?utf-8?B?U2t1MjJBWkZEVTA3N0RkZ0NNNzBsU0NQamNzTGY2MDBCQS9iMGp2S1VZbUdy?=
 =?utf-8?B?MzEzelhuSTl6aGkwSnJrRWVxYlMwVDVFREw4L29qYVpaMldJNFVUSHdVSGJh?=
 =?utf-8?B?RHBaQW8zUWliM09XNTVRMmJidERicXhKRnpZd2VJNWNYWkx5dk9UM3M5NzJs?=
 =?utf-8?B?RE5JOTU3RENZVEF5ZUhCVWdyQ3NRb0o3MkhUQ09GZ09RVStUaDdQenZ3Zkoz?=
 =?utf-8?B?eUZCUDI5dFVFWVdPMVJXYU1rc1BKb1IxdXJhWnlHQUFiNS9jL0ZEMnFqbHND?=
 =?utf-8?B?NzlxMjBtT1orZ1c1VkFuUHYydEpxbUEwM3QyUnJVR1RGbEhKYVJrZk1tTTNw?=
 =?utf-8?B?Ym9PeHNDN2dUYS9oSUMwTGxYdlBMZWlmUk1mbUZ1UnNuL01aUHZOZm9wY284?=
 =?utf-8?B?cUpvSTZZQ2tLLzg5UTlQTG0yTXFrUnpPeWlmTDFqcEg0a3RkUzJkMlArZ1lY?=
 =?utf-8?B?ME80NXNVN3RNU3RGallITFV1UlFUbmFkUnk0eDZvNnNpOUZIQmZ0RWZLb1Jt?=
 =?utf-8?B?aVRzWVpWQzY3REQ1MDhEMm1PQTRaUWFFeTZlZXhpOEtFV0ZWVXFLMXI2bVdt?=
 =?utf-8?B?TVltWHl1R2xKMXU3cmExanlYV3ppa2pyOEF3cDNSYlQyNXNtWFhLeDNhRUtN?=
 =?utf-8?B?WVNuMGsxSUVuL2NFMllTSmlqQmtIdWl5elFsMCtDNGxuRE4weENDTmtaakts?=
 =?utf-8?B?UVduMytEMDhXNTJqaXR3eU92REFVRzloUUVlUU94alIwN1lLaTFZOTFQMkxE?=
 =?utf-8?B?UHk3Q0MvTlJERUhMeUtiaXQyWmQ1cVUySkdRSVY0ay83M09JNVBNQ3JhbjVM?=
 =?utf-8?B?d05QYUF6cWpMdUQwekdLb1hmMXBQSmpvb2NoNmlSbDB0ZlhHWVNBUmpZaHp2?=
 =?utf-8?B?ZmIxdWZiWEwrQW84VEVMR2hPcG9mVHByRDdqOHZuUG5CdGxKdUR4RENueVhZ?=
 =?utf-8?B?Z1crUmN4VTV3VCtCRmZGV1puYWw5VWdXZ3grVUM5RThiTEcxdFR2OXJrR01p?=
 =?utf-8?B?YkFtZmdqSzk3TzdVYmI0UmJqK3h3d0I1SUJCNHkzZnZGNFpMcDZ1bUkvVEtZ?=
 =?utf-8?B?L3RwL0I4dnVMNGpXYWdXTytRWVdLZ3hYdERKWnhNUmVtN3Awa1dJekM3OFFN?=
 =?utf-8?B?VnMxOFZXVEwrOFExUms5L0l0WHpHOURPRXFqU1FyYkdna2RoZ0QzMmRURFhn?=
 =?utf-8?B?V0xGS1VIdUM4OWRtV3QrbHVXNFJUMUdxYWJKRSt3ckc5eUR2NTBpQVdnR29U?=
 =?utf-8?B?b1ZqWU9Damo4RzhWNlhwbTVTaE1xRUlLOXI1K1pMRCtMYVdLOXFDM3BLTi9H?=
 =?utf-8?Q?U4pFEu3dLGmtW1W+bbW903u3xBt2rxpQLr38EKwQVSFrh?=
x-ms-exchange-antispam-messagedata-1: 2za+/2E/6sFOkQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB79AE5E5D5005448C81514E56760E4D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74d762d-4c40-40d9-cfe3-08dedbc8e721
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 01:41:45.0494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nUf4yXs4goypn81bdm7WMmGmS47zkDf/ssktpbNaO/AQFOO279VlWs1wPZd1tiFVsLqmA8Czgc7mSxnp5W1oA+zXRSWqP+RdhTv85NNsYID3NgOwuiuTXMPWwN8Xq5s4o0zXUCyrIIDfLIZiqFJJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8306
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305253-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 226C5716A4C

T24gMy83LzIwMjYgOToxMiBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4+IFRoZSBkZWxheXMg
YXJlIHByb3ZpZGVkIGJ5IHRoZSBGUEdBIEdNSUktdG8tUkdNSUkgY29udmVydGVyIHNvZnQgSVAs
DQo+Pj4+IHdoaWNoIGlzIGhhcmRjb2RlZCBpbiB0aGUgRlBHQSBiaXRzdHJlYW0gYW5kIGNhbm5v
dCBiZSBkaXNhYmxlZCBvcg0KPj4+PiBtb2RpZmllZCBmcm9tIHRoZSBkcml2ZXIgc2lkZS4NCj4+
Pj4NCj4+Pj4gVXNpbmcgcGh5LW1vZGUgPSAicmdtaWkiIGlzIGludGVudGlvbmFsIGhlcmUg4oCU
IGl0IHByZXZlbnRzIHRoZSBQSFkgZnJvbQ0KPj4+PiBhZGRpbmcgaXRzIG93biBpbnRlcm5hbCBk
ZWxheXMgb24gdG9wLCBzaW5jZSB0aGUgRlBHQSBjb252ZXJ0ZXIgYWxyZWFkeQ0KPj4+PiBwcm92
aWRlcyB0aGUgZnVsbCByZXF1aXJlZCBkZWxheS4gVGhpcyBpcyBjb25zaXN0ZW50IHdpdGggaG93
IGFsbCBvdGhlcg0KPj4+PiBBZ2lsZXg1IFNvQ0RLIGJvYXJkIHZhcmlhbnRzIGFyZSBkZXNjcmli
ZWQsIGFzIHNlZW4gaW4gY29tbWl0DQo+Pj4+IGM1NjM3ZTVjZWI0YiAoImFybTY0OiBkdHM6IHNv
Y2ZwZ2E6IGFnaWxleDU6IEZpeCBwaHktbW9kZSB0byByZ21paSBhcyBIVw0KPj4+PiBwcm92aWRl
cyBjbG9jayBkZWxheSIpIGFscmVhZHkgaW4gRGluaCBOZ3V5ZW4ncyB0cmVlLCB3aGljaCBhcHBs
aWVzIHRoZQ0KPj4+PiBzYW1lIHJhdGlvbmFsZSBhY3Jvc3MgYWxsIEFnaWxleDUgYm9hcmRzLg0K
Pj4+DQo+Pj4gSSd2ZSBiZWNvbWUgbW9yZSBpbnNpc3RlbnQgdGhhdCBkZXNpZ25zIGdldCB0aGlz
IGNvcnJlY3QuIFNvIGkgZG9uJ3QNCj4+PiBjYXJlIHRvbyBtdWNoIGFib3V0IHBhc3Qgc3lzdGVt
cy4gTWFueSB2ZW5kb3JzIGFyZSBoYXZpbmcgdG8gZml4IHVwDQo+Pj4gdGhlaXIgZHJpdmVycyBh
bmQgRFQgaW4gb3JkZXIgdG8gbWFrZSBuZXcgYm9hcmRzIGNvbnNpc3RlbnQuDQo+Pj4NCj4+PiBZ
b3UgY2FuIGxvb2sgYXQgeW91ciBzeXN0ZW0gYXMgdGhlIEZQR0EgYmVpbmcgdGhlIE1BQywgYW5k
IHRoZSBQSFkgaXMNCj4+PiB0aGUgUEhZLiBUaGUgUENCIGlzIG5vdCBwcm92aWRpbmcgdGhlIGRl
bGF5LCB0aGUgTUFDIGlzLiBUaGlzIGV4YWN0bHkNCj4+PiBmaXRzIHRoZSBkZXNjcmlwdGlvbiBh
Ym92ZS4NCj4+Pg0KPj4+ICAgICAgICBBbmRyZXcNCj4+IEhpIEFuZHJldywNCj4+DQo+PiBUaGFu
ayB5b3UgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBXZSBhZ3JlZSB3aXRoIHlvdXIgZnJhbWV3b3Jr
IGluDQo+PiBwcmluY2lwbGUsIGJ1dCB3b3VsZCBsaWtlIHRvIGV4cGxhaW4gd2h5IHBoeS1tb2Rl
ID0gInJnbWlpIiBpcyB0aGUNCj4+IGFwcHJvcHJpYXRlIGRlc2NyaXB0aW9uIGZvciB0aGlzIHNw
ZWNpZmljIGNhc2UuDQo+IA0KPiBTbyB5b3Ugd2FudCB0byBiZSBkaWZmZXJlbnQgdG8gZXZlcnkg
b3RoZXIgc3lzdGVtPyBQbGVhc2UgZXh0ZW5kIHRoZQ0KPiB0ZXh0IGluIHRoYXQgZG9jdW1lbnQg
dG8gc2F5IHRoYXQgdGhpcyBkZXZpY2UgaXMgc3BlY2lhbCBhbmQgaGFzIGENCj4gZGlmZmVyZW50
IGRlZmluaXRpb24gb2YgcGh5LW1vZGUgdG8gYWxsIG90aGVyIHN5c3RlbXMuDQo+IA0KPj4gQWZ0
ZXIgZ2V0dGluZyBtb3JlIGluZm9ybWF0aW9uIGZyb20gaHcgdGVhbSwgZm9yIEFnaWxleCBzcGVj
aWZpYyBkZXZpY2UsDQo+PiB0aGUgUkdNSUkgdGltaW5nIGRlbGF5cyBvbiB0aGlzIGJvYXJkIGFy
ZSBwcm92aWRlZCBieSBhbiBGUEdBIGRlbGF5DQo+PiBjaGFpbiAoSW5wdXQvT3V0cHV0IERlbGF5
IENoYWluIHByaW1pdGl2ZXMgaW4gdGhlIEZQR0EgZmFicmljKS4gVGhlDQo+PiByZWFzb24gZm9y
IHVzaW5nIHRoZSBGUEdBIHJhdGhlciB0aGFuIHRoZSBQSFkgaXMgdGhhdCB0aGUgTWFydmVsbCBQ
SFkgb24NCj4+IHRoaXMgYm9hcmQgb25seSBzdXBwb3J0cyAwbnMgb3IgMm5zIGRlbGF5IHN0ZXBz
IOKAlCB0b28gY29hcnNlIHRvIG1lZXQgdGhlDQo+PiBSR01JSSB0aW1pbmcgcmVxdWlyZW1lbnRz
LiBUaGUgRlBHQSBkZWxheSBjaGFpbiBwcm92aWRlcyB1cCB0byA2MyBzdGVwcw0KPj4gb2YgfjAu
MW5zIHByZWNpc2lvbiwgd2hpY2ggdGhlIGhhcmR3YXJlIHRlYW0gaGFzIHR1bmVkIGF0IGRlc2ln
biB0aW1lIHRvDQo+PiBhY2hpZXZlIGNvcnJlY3Qgc2lnbmFsIHRpbWluZy4NCj4gDQo+IEFzIHRo
ZSB0ZXh0IHNheXMsIGZpbmUgdHVuaW5nIGlzIGRpZmZlcmVudC4gWW91IGNhbiBoYXZlIGZpbmUg
dHVuaW5nLA0KPiBpbiBib3RoIHRoZSBNQUMgb3IgUEhZLCB3aGlsZSB1c2luZyBlaXRoZXIgcmdt
aWkgb3IgcmdtaWktaWQuDQo+IA0KPiBBbHNvLCB5b3UgY2Fubm90IGZpbmUgdHVuZSBqdXN0IHRo
ZSBNQUMsIHR1bmluZyBuZWVkcyB0byB0YWtlIGludG8NCj4gYWNjb3VudCB0aGUgUENCIGRlc2ln
biwgdGhlIGxlbmd0aCBvZiB0aGUgY2xvY2sgYW5kIGRhdGEgdHJhY2tzIG9uIHRoZQ0KPiBQQ0Iu
IFlvdSBjYW4gaG93ZXZlciB0YWtlIGludG8gYWNjb3VudCB0aGUgZGlmZmVyZW5jZSBpbiB0aW1p
bmcgd2l0aGluDQo+IHRoZSBGUEdBLg0KPiANCj4gT3IgZG9lcyB5b3VyIEZQR0EgdGVhbSBwcm9k
dWNlIGEgZGlmZmVyZW50IGJpdHN0cmVhbSBwZXIgYm9hcmQgZGVzaWduLA0KPiBhZnRlciBzb21l
IHNvcnQgb2YgY2FsaWJyYXRpb24gaW4gb3JkZXIgdG8gZGV0ZXJtaW5lIHdoYXQgdGhlIFBDQg0K
PiBjaGFyYWN0ZXJpc3RpY3MgYXJlPw0KPiANCj4gVGhpcyBob3dldmVyIG9wZW5zIHVwIGEgbmV3
IHBvc3NpYmlsaXR5LiBJdCBkb2VzIHNvdW5kIGxpa2UgeW91IGNhbg0KPiBwcm9kdWNlIGEgbmV3
IGJpdHN0cmVhbSB3aXRoIHRoZSBkZWxheXMgc2V0IHRvIGp1c3QgdGhlIHR1bmluZyBkZWxheSwN
Cj4gbm90IHRoZSAybnMgKyB0dW5pbmc/IFlvdSBuZWVkIHRvIGRlY2lkZSBpZiB0aGlzIGlzIHNp
bXBsZXIgdGhhbg0KPiBjaGFuZ2luZyB0aGUgTUFDIGRyaXZlciB0byBtYXNrIHRoZSBwaHktbW9k
ZS4NCj4gDQo+PiBDaGFuZ2luZyB0byBwaHktbW9kZSA9ICJyZ21paS1pZCIgYW5kIGhhdmluZw0K
Pj4gdGhlIGRyaXZlciBzdHJpcCB0aGUgZGVsYXkgYmVmb3JlIHBhc3NpbmcgdG8gdGhlIFBIWSB3
b3VsZCBwcm9kdWNlIHRoZQ0KPj4gc2FtZSBoYXJkd2FyZSBiZWhhdmlvdXIgKFBIWSBhZGRzIHpl
cm8gZGVsYXkpLCBidXQgd291bGQgYWRkIGRyaXZlcg0KPj4gY29tcGxleGl0eSB3aXRoIG5vIHBy
YWN0aWNhbCBiZW5lZml0LCBhbmQgd291bGQgbWlzcmVwcmVzZW50IHRoZSBGUEdBDQo+PiBkZWxh
eSBhcyBhIGRyaXZlci1tYW5hZ2VkIE1BQyBkZWxheSB3aGVuIGl0IGlzIGFjdHVhbGx5IGEgZml4
ZWQsDQo+PiBib2FyZC1sZXZlbCBoYXJkd2FyZSBjYWxpYnJhdGlvbi4NCj4gDQo+IExvb2sgYXQg
dGhlIHdvcmRpbmcgYWdhaW4uIEl0IGRvZXMgbm90IHNheSBpdCBpcyBkcml2ZXIgbWFuYWdlZC4N
Cj4gDQo+ICMgVGhlcmUgYXJlIGEgc21hbGwgbnVtYmVyIG9mIGNhc2VzIHdoZXJlIHRoZSBNQUMg
aGFzIGhhcmQgY29kZWQNCj4gIyBkZWxheXMgd2hpY2ggY2Fubm90IGJlIGRpc2FibGVkLg0KPiAN
Cj4gVGhpcyBleGFjdGx5IGZpdHMgeW91ciBzaXR1YXRpb24uDQo+IA0KPj4gQ291bGQgeW91IGFk
dmlzZSBpZiB5b3Ugc3RpbGwgcHJlZmVyIHRoZSByZ21paS1pZCBhcHByb2FjaCBnaXZlbiB0aGlz
DQo+PiBjb25zdHJhaW50Pw0KPiANCj4gcmdtaWktaWQgaXMgdGhlIGNvcnJlY3QgdmFsdWUgZm9y
IHlvdXIgUENCIGRlc2lnbi4gUGxlYXNlIGZvbGxvdyB3aGF0DQo+IHRoZSB0ZXh0IHNheXMuDQo+
IA0KPiAJQW5kcmV3DQo+IA0KPiAJDQpIaSBBbmRyZXcsDQoNClN1cmUsIHdpbGwgcmVmbGVjdCB0
aGlzIGNoYW5nZXMgaW4gdjIsIFRoYW5rcyBmb3IgdGhlIHJldmlldw0KDQoNCkJSLA0KTmF6aW0N
Cg==

