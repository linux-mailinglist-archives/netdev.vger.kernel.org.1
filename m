Return-Path: <netdev+bounces-139359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAB29B19DE
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 18:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46531B216FE
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8D213CA93;
	Sat, 26 Oct 2024 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fAPXprJR"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ECF2F36
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729961528; cv=fail; b=gNrNf4w7Ukj/6MUy/2zcxZnPN1JLlDzq48WV5gMfLTfObiXT1UV7+O5WdTu0StVLkeK/RptSAM7WWXkEc8LahE4gdqoULg8GO7vWHQIwQY+vROgnMnO5Bb74mhRqB9mHYESaHCSSa+hvIMAXLBdqJXFvMUv8MpKwU6E/sGz8IVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729961528; c=relaxed/simple;
	bh=n9Ov68eSl9usf7ZfCQ4cbqSFsqPZCopK+5dUD/HHm/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uW6DzPSHpn413WAp8fDznlwhr8tEDueCXofI9GIA5pfS1y/FkCkETemo0aIl8oI427AeUn7gQOrntVSKPt89onyLM/vnmXR8rF64MJdZCVDXurp1A/E2a8cp/S0Lm0zoCj3uCDGwZoU5sWeQpM0JkUKGQ45pOrdl3ZSnBHaNb5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fAPXprJR; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nh7AZTNpKXOBgTG+yeuEg7c3aG5l09nkosCCOFWt9PYAVC33gSNX1ASnI+UKGUU7ZV+V63y8K5agAUaB73FwgOSfjVVbSMrt/upuucfLKHqxnbt4hT6aISarAhwhqcZTmXWPS9TChjcrvmx3B4MigBj68lgyTOkwBMcA6y7lRobIhqJb4OmYIKxEA0bNcOi8pLtGJmzN1VIyjPXGGvReuoal9S57OpEehVXv/nvcCc4aKNpw7VJCp4h220VGvYKSDDTpPfEgtMKtMfbeBqzCf9o5SWb21pljBM23+Y6cM54Ca+oHiFVHQzAgmsqLULD4K4YKrgPGnLJ97oOa5h+2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9Ov68eSl9usf7ZfCQ4cbqSFsqPZCopK+5dUD/HHm/s=;
 b=Yv6nLXgJGH6fgEP5ajLPg2noS1qnHfugZ70MGMj7nU4sMbndzn1TbJ0GChJjLstcX5KyyVB3jnm18+Fs0Om6c50HVuupCat9ki0Te9fkhgL7bhKhBXh1/O+Hl5y9V7hNTWiWMuoRVyiVdqvV7HoFjeT5EGtVmmDcTrIeZtuBhnQ2pzSJrB3l4fjcEmFkhGzzSZZno0/QHRu1XNU3skP7h9vrou+YzEXOGsYcnMdL4yV7OMSI2PNlAoexBDlJyPEDWOd7d85tnU18iYeGpCzJy1vH/OjN0uomIIIzuor0jh+MruzEe4kdG5iP5kDUvZgwG1eLtw7EyqtR3QXLFyZzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9Ov68eSl9usf7ZfCQ4cbqSFsqPZCopK+5dUD/HHm/s=;
 b=fAPXprJRhmVz+mocACWOXsDyhM95bq8Eih8iL+2YKeXjJsBsDj/ChC/1QQ5zgryxOzuJnXRI/3WADT9JugDgfEnN9g/QbobzPsOIwSSv7X8GJELDU6F6BDz8lNXoOxuNiHslw9zdc1Qburi/dpMfwYJwM9RrmLcxBPH8PEAowRWbv5l8NCZ71rHjKVPBUvY/bUjoy4HrLqyU7NYxjJMrY0rNxhTPYBWEJJibMkOQwy+lk76l/uotcSs3R/7v+SFHzwRZEvsRU6VdYzDy4TqnGuO6bD/foHNHGW/aBtYFByX7DMidbh5ZjduqZVpQYtXhEESPKDV+PsVcFRRjH9BtpQ==
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com (2603:10a6:20b:396::12)
 by VI1PR07MB6477.eurprd07.prod.outlook.com (2603:10a6:800:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sat, 26 Oct
 2024 16:52:03 +0000
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692]) by AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692%7]) with mapi id 15.20.8093.021; Sat, 26 Oct 2024
 16:52:03 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v4 net-next 0/1] DualPI2 patch
Thread-Topic: [PATCH v4 net-next 0/1] DualPI2 patch
Thread-Index: AQHbJAZn4KgP+XoXsU+SvdGZhgkcLLKWK2uAgAMa1lA=
Date: Sat, 26 Oct 2024 16:52:03 +0000
Message-ID:
 <AS8PR07MB79737D085046AE1820483C87A3482@AS8PR07MB7973.eurprd07.prod.outlook.com>
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
 <CAM0EoMk6EGGWAbYiumPZOxdNV93_zt2ycNQETGXGK4Y5RG60RQ@mail.gmail.com>
In-Reply-To:
 <CAM0EoMk6EGGWAbYiumPZOxdNV93_zt2ycNQETGXGK4Y5RG60RQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7973:EE_|VI1PR07MB6477:EE_
x-ms-office365-filtering-correlation-id: 704c4aa2-41e3-4f4b-c1bb-08dcf5de8488
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFJhamdIWmFDcVFIb1JrbWw3M1JNUURXc0NXTTVleVVjVE9vNXJtQS9pb1l2?=
 =?utf-8?B?ZVpDNFVQVm1LZW1jWmV0T2tESXBUZXBDcmJkL0JuQXh0bk90dXJjZW1pWlB6?=
 =?utf-8?B?bUxVS3JCOU1nSjRNcjJkVUxxREI0VEhxS25JdllSY2ZXUWwyaU0zRHF4UmU1?=
 =?utf-8?B?dGVvK3g5THJHNFlIMTlQN2dJZm9OVWZlOFpveHpESzZVaFZWSHpEMUdhNXVC?=
 =?utf-8?B?UGZPYWlkQUc5aXpTYjVod3JFL3FrSnB4M1RkWVZwaG9tQkRKYi9yYkFZb1dE?=
 =?utf-8?B?cTVvanhhQjJPT3lqbC9aTkVhakk4ai8wanp4cHFNd0l4bUFDUFlYam1Fa3Bq?=
 =?utf-8?B?c20vSlBqVlg5TVJiMXpDTFNoeFlYTnZXSXBvbFdtNjlHSnQ2NFRqSFI4dXlh?=
 =?utf-8?B?ZFhJNXJYK2J6eThLRFZVc1dZNnQzUVRIc3h4L1RYaEtrNXl2RVZnemZOMjVD?=
 =?utf-8?B?NjR5WjRYVWRET25KZ0Yyd2phWXhESGNzSG5tcGkxNnhrN0ZpN1JsdUFOaWl0?=
 =?utf-8?B?Z0ZWalY2MnA1MWZBZUcxUDYyNFFZeUg2TEM4VTZyUjVzTmV5ZTBIdExBY3JP?=
 =?utf-8?B?TzZVVGVpMXMyOXlnZCtYV2FzVHNURlZNdHVFeWFEaHVoN25KR1BlQWZRcWg4?=
 =?utf-8?B?MUp2bXFhQzJRdjF4MWZWQVQvZUFNUmtpeEpoQ1JiYUpGZ2hwNlJJN2I5LzF4?=
 =?utf-8?B?RmZLQWU1Sm4vb3hRaVEvRzg4NDZvSWVnekRVQy9maXpIMnlYOTN1Y1hKZ2xX?=
 =?utf-8?B?aE5nemhCUm5vR3EwM1VNcWtVem0reWQwUFIxSkxOSS9VcHdmVXJpQ3JzTlI2?=
 =?utf-8?B?VWtSMjVHSjJYdWk4T0dtZXVWaUdyNG9pbjE4WFJyUU41MVNBVktKUHBVdUJL?=
 =?utf-8?B?VkdBSVU3Y1kyTTcwdkVNQXlVS2lINUF1TTRPRFUrbGZUc3NWRDBTVStobGdP?=
 =?utf-8?B?UXZ5K2tqWmZkdml6NEF2TytyVHZYZThWVURGS211dUt5ajY1UXZkVEJUOHFt?=
 =?utf-8?B?QzF4TmV1NEJGU1NxU3RjSTFPcVRQUmFWTURBWlZ2bVZxRXdNMWVvSkNuWGRz?=
 =?utf-8?B?Tk1CNjY0anpnNVFnREhKcmVxTFNLTGpEWmlPaUxQOUwrRDhSdVFpQWg1bktM?=
 =?utf-8?B?b2p5UE1NNEoxU0x4WHRFaHhIUnpodExYTFlJY2NiWDRqUUZHSS9XM3RGWDJp?=
 =?utf-8?B?aFpTblVBemdlZ0E4ZVhpMFRIUkVvMHpMOVZjVXAvRS8wRlhCYmtGVHQzRUR6?=
 =?utf-8?B?dUQyVlVtM3ZDQklIVzAwYklrMWlyV1U2bzFvcFBDU2o1Vm8vQmt4dGFVREpQ?=
 =?utf-8?B?K2U5bXBMeDBQUCs2bWYxTm91MmhtR3p2SThVdFFLb3VhelV5SThvWEwrMGxL?=
 =?utf-8?B?ZXgrWldXVFZISnRBVkd2bDN3T29sbkVjb21Xb1pLbU5hVkhRZGEwYzZHTUQ0?=
 =?utf-8?B?NW9PZ2lKeWVuaFVLb2xGTEx4QXQ1QUUwaEV4b05Ld0grajdOLy85NjRtQnhp?=
 =?utf-8?B?blcvdit1YU13MUdSUVJBcjY2QmU1Q3lDNU1vd3liVjRrRkRsV3ZiQXR6T2ZF?=
 =?utf-8?B?dllnK2RaSmtrK3BIUUVYcFEwQWE5bytyYkJ3VDFuNDAvVFlYTTVhRnNzOGV0?=
 =?utf-8?B?emJKS0hrZ2ljUkhyc2lEM2RyNXJaVk9lVm50YUxVVHh1VmxMWHlLVTZkbVNC?=
 =?utf-8?B?MVFvOUJLbi9MdUJ0Q3RGL01jSm0vVEpVNG9LTmZwZnprSi9MSTFUdVY1cFM5?=
 =?utf-8?B?M3BRQys5eE9HZlNmS01pb2kzMk4zZHA1aDROK1o0dVBvZVkxblZxWjNtS29Y?=
 =?utf-8?B?TzVZQ092VEMvZGpMTVdIUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7973.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWNXNGtjeWxoV3ZZc3JhQWdYWENmWkxPU3FTM0dwdzBqa0kvSzYwNExWYVp6?=
 =?utf-8?B?bXdwWHZ6OVJScGZMckpvRlBaeVMydi8yaDZ2bXB3N1FpM3NyWEsvd2VtdS9O?=
 =?utf-8?B?QkEyYzFkdkl5dENVbDhzTmpxTXpBVzlucTR6MUFnQW1iVFdXQ1ZvZXkra2R3?=
 =?utf-8?B?c2E5NCtyVlFLNFJJRVpYUTNjelIzd2tjZEU4NElnSG5vR0Y5TnRYbElTTFIx?=
 =?utf-8?B?TkxCT3NYbHBKTlhyV2pmdTFubWtpMDQrNlJubGZIQ25lUGhiKy9Lc3ZxYjgy?=
 =?utf-8?B?QWdFV2wzUHB0UDE1L09LQ0dYYlFvS0FxQk12STBPYXp0VlE1UDhGVFNLMXJo?=
 =?utf-8?B?cncrWW5ibGsySmYyM0phWHpnNVRJeFN1VUREZHNOVVNNZXYya2R0SE9ITXhn?=
 =?utf-8?B?U1VXd0NOWnNZQ2luaVkyYUpoOUdjSWovTDBhaVFHbkQwQTBhaFdqR1ZPWldS?=
 =?utf-8?B?Yll0aUN2VEovQUI1bHlWY1h0Zk1Va25Jdy9DOUdhYThnY1Y3ejg5cnpBemUw?=
 =?utf-8?B?UHZTKzlqczgzZWlMQUt2Um9VUVFJdVh5c2N6NU8rWGFBdG5uM1dac3B3ZmlZ?=
 =?utf-8?B?R1NUYjUrMnhiWW1YZ3hRRk56Z3pBN3NsamxJTUgzUlVBWXRGSzFkOW1uVUdl?=
 =?utf-8?B?bnVoOXVINHpwMHJ2T0JTd041RkJWMzN0RHhyYk55NWhOV2V2MDlaYlFjUkM2?=
 =?utf-8?B?TVcrUk1yN1N4NDVONzVKUHYvalR5djVaUElZYU9uWkNJQ0FCSGRqa3Zuenpi?=
 =?utf-8?B?bkt4TFpFL1V0NGYvRy9leVNERTljenFOSEFuZm9GcUJKOFk5a0wyM1lvUGl6?=
 =?utf-8?B?SUlOZHlSVzZsdDdYbjhlL1BiMlRqVE5UL2llbG52My9UenBzc2ZPcnB3ZENW?=
 =?utf-8?B?Wk5IL3JHbDlGdTlRUEdtaTF0cXNFNlQ1bnRWdmRXWk9MOE0wSlNLdFRPSkEv?=
 =?utf-8?B?TXh4bkRrMmdTcmJ5WEE2cU5TVFJuOXRmNmN3R0FQTzh6aUtibmlzbExqa0V2?=
 =?utf-8?B?TFJpU1hFVC82bTBpeHZkT0Y2ZnlvNzdKaUV2Z05EOGZKMVArblplRVRIMXV0?=
 =?utf-8?B?MFpZLy9IYncwd0tFQ1lDRHJwVloxTkluenA0K1FIUnBEYldIdWg3WVFBSm45?=
 =?utf-8?B?U3Rway9rU3p1SkhpYlo1Zk5KWHVBNE13NjJMelNHRTR4TFc4endITUY1Z1pB?=
 =?utf-8?B?em90dHlUUHdGd0Fjc1Rpc2QrWDhLTHlTRWU0Z01DS1I0VlFMZUI0ZHNuNDJM?=
 =?utf-8?B?SFQ2T0pWYXJyaDB6RFVHeUFwWHFEbGFHQVRiS0V6YzZKcjNIYzRndHp0NnBE?=
 =?utf-8?B?Y1NKamFUVHN1eWpiK3pQaU5jNGlEZEJBa3AxcDBBb0hpSS9JcTJTZ0N0Ti96?=
 =?utf-8?B?ZzMzcTFtNnF5OW5EaUphOElzME42dm0yVFhSVld5TU9LZmRLVElOTDQ4M2N3?=
 =?utf-8?B?NUV4YXYrZXd4dVdMTzNYU2xTSWN6Z09LTThCbTJyUER0RkRTaHdoSzlTSURw?=
 =?utf-8?B?UWpRMkc5QldZTHYveGg4Q0JQYzVHQmw4dlZYd3E1NmhJVG85Z0thSWwrSk1l?=
 =?utf-8?B?d3Ruek8zZlhodHlZbU9WZE9WWWlyTzcwU0RmdVVnT0Z1S1h2ak1kUWV5NnZt?=
 =?utf-8?B?L0V1OFNYVExDZ2ZyNVBPQXBHRW1pSWpUdHB0ZER6S3hORG9PUm9jRFZjNWwy?=
 =?utf-8?B?SVEyZWMvVHUyS0ZyV1RKVHlFam1WMjRRVzVlRFRUUTdLTkR5RHJHREQ1b3lW?=
 =?utf-8?B?T09VSmw4N3h5SVdrakxoOG9qOGxKYW5abE84cGNiUHBtbmpCODlIN3pIMTRn?=
 =?utf-8?B?WmpUZlV4SFd6S2xDLzVUWGVyNkttSitnZnQ4aXovOXlZWW80VlVoQlM4aUtq?=
 =?utf-8?B?b2lza2JuK3dEWk8vK0VTOXVtUVFPMHVNWFJTRUZjZUlqRnRDYVUyaDNIaDR6?=
 =?utf-8?B?bGUyaEs4S2JDSnRKL3dQTUxmVWlhRUM5VXhFUmorYzh0R09jM2NCM0ZYRnda?=
 =?utf-8?B?Tm0xcHN2d3c4YWpEMGl0RjRqcUJ6Q2NGWXFSazhBZ1JkaWJLNERNS1FYN2JC?=
 =?utf-8?B?VGZybDIvV3N0eTY3LzBLUnJWQjBJS0UyeDBKVmdCWVBaRVdUODhhelNqakNp?=
 =?utf-8?B?K0lGZTkxdHUwZXRsVWVubWV5dElQV2hpOXROajRUeDdGSXF1WkdNU3I1d0Qw?=
 =?utf-8?B?M1E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7973.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704c4aa2-41e3-4f4b-c1bb-08dcf5de8488
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 16:52:03.4243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfxQPJ+SZ0SMZPA9VXIZwe4k+mskqDdqzDXM4tAWDZZ3cqVNhcZIQc6zqSarRlHJdZIGzIKFL9aV742tsi/Yf+TqMOroaInvE4MvHX5T/TAgDn87ixoeU8TSsNjouVIj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6477

SGkgSmFtYWwsDQoNCglXaWxsIGRvIHRoYXQsIGFuZCBJJ3ZlIG5vdGljZWQgdGhhdCB5b3VyIHBy
ZXZpb3VzIGNvbW1lbnQgb24gdXNpbmcgcG9saWN5LmMgaGFkIG5vdCBuZWVkIGFkZGVkLiBTbyBJ
IHdpbGwgdGFrZSBhY3Rpb24gb24gdGhhdC4NCglBbmQgdGhlIENDJ2VkIHRvIHRoZSBNQUlOVEFJ
TkVSIHdpbGwgYmUgZG9uZSBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCcnMsDQpDaGlhLVl1DQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW1hbCBIYWRpIFNhbGltIDxqaHNA
bW9qYXRhdHUuY29tPiANClNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDI0LCAyMDI0IDc6MjYgUE0N
ClRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJz
LmNvbT4NCkNjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBz
dGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJu
ZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgZHNhaGVybkBrZXJuZWwub3JnOyBpakBrZXJuZWwu
b3JnOyBuY2FyZHdlbGxAZ29vZ2xlLmNvbTsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2Vu
LmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207
IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNz
c29uLmNvbTsgY2hlc2hpcmVAYXBwbGUuY29tOyBycy5pZXRmQGdteC5hdDsgSmFzb25fTGl2aW5n
b29kQGNvbWNhc3QuY29tOyB2aWRoaV9nb2VsQGFwcGxlLmNvbQ0KU3ViamVjdDogUmU6IFtQQVRD
SCB2NCBuZXQtbmV4dCAwLzFdIER1YWxQSTIgcGF0Y2gNCg0KW1lvdSBkb24ndCBvZnRlbiBnZXQg
ZW1haWwgZnJvbSBqaHNAbW9qYXRhdHUuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQg
YXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCg0KQ0FV
VElPTjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3
aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5v
ay5pdC9leHQgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQoNCg0KDQpIaSwNCg0KT24gTW9u
LCBPY3QgMjEsIDIwMjQgYXQgNjoxM+KAr1BNIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFi
cy5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5v
a2lhLWJlbGwtbGFicy5jb20+DQo+DQo+IEhlbGxvLA0KPg0KPiBTcGVjaWZpYyBjaGFuZ2VzIGlu
IHRoaXMgdmVyc2lvbg0KPiAtIE1ha2Ugc3VjY2luY3Qgc3RhdGVlbnQgaW4gS2NvbmZpZyBmb3Ig
RHVhbFBJMg0KPiAtIFB1dCBhIGJsYW5rIGxpbmUgYWZ0ZXIgZWFjaCAjZGVmaW5lDQo+IC0gRml4
IGxpbmUgbGVuZ3RoIHdhcm5pbmcNCj4NCg0KVGhhbmtzIGZvciB0cmFja2luZyB0aGUgY2hhbmdl
cy4gQWxzbyBwbGVhc2UgaWYgeW91IGNhbiBhdHRyaWJ1dGUgd2hvIGFza2VkIGZvciB3aGljaCBz
cGVjaWZpYyBjaGFuZ2UuIEFyZSB5b3UgYWJsZSB0byByZXRyaWV2ZSB0aGUgcHJldmlvdXMgdmVy
c2lvbnMgY2hhbmdlcy9oaXN0b3J5IGFuZCBwdXQgdGhlbSB0aGVyZT8gSSBhbSBhc2tpbmcgYmVj
YXVzZSBJIHNlbnQgZmVlZGJhY2sgdG8gd2hpY2ggaSByZWNlaXZlZCBubyByZXNwb25zZS4gVGhl
biBpIHN0YXJ0ZWQgbG9va2luZyBhdCB0aGlzIHZlcnNpb24gYW5kIG5vdGljZWQgeW91IGFkZHJl
c3NlZCBzb21lIG9mIHRoZSBjb21tZW50cyBidXQgbm90IGFsbC4gSXQncyBqdXN0IG1vcmUgd29y
ayB0byByZXZpZXcgc2luY2UgeW91IG5ldmVyIHJlc3BvbmRlZCB0byBhbnkgb2YgdGhlIGVtYWls
IGNvbW1lbnRzIGkgbWFkZS4NCkNvdWxkIHlvdSBhbHNvIHBsZWFzZSBpbmNsdWRlIGFsbCB0aGUg
c3Rha2Vob2xkZXJzIGxpa2UgaSBhc2tlZCBsYXN0IHRpbWU/IFRoaXMgaXMganVzdCBjb21tb24g
cHJhY3Rpc2UuIEZvciBleGFtcGxlIGkgc2VlIHplcm8gdGMgbWFpbnRhaW5lcnMgY2MtZWQgeWV0
IHlvdSBhcmUgYWRkaW5nIGNvZGUgdG8gdGhhdCBzdWJzeXN0ZW0gZXRjLiBJdCB3b3VsZCBoZWxw
IHRvIHJlYWQgdGhlIHBhdGNoIHN1Ym1pc3Npb24gaG93dG8uDQoNCmNoZWVycywNCmphbWFsDQoN
Cg0KPiBQbGVhc2UgZmluZCB0aGUgdXBkYXRlZCBwYXRjaCBmb3IgRHVhbFBJMiAoSUVURiBSRkM5
MzMyIA0KPiBodHRwczovL2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9odG1sL3JmYzkzMzIpLg0K
Pg0KPiAtLQ0KPiBDaGlhLVl1DQo+DQo+IEtvZW4gRGUgU2NoZXBwZXIgKDEpOg0KPiAgIHNjaGVk
OiBBZGQgZHVhbHBpMiBxZGlzYw0KPg0KPiAgRG9jdW1lbnRhdGlvbi9uZXRsaW5rL3NwZWNzL3Rj
LnlhbWwgfCAgMTI0ICsrKysNCj4gIGluY2x1ZGUvbGludXgvbmV0ZGV2aWNlLmggICAgICAgICAg
IHwgICAgMSArDQo+ICBpbmNsdWRlL3VhcGkvbGludXgvcGt0X3NjaGVkLmggICAgICB8ICAgMzQg
Kw0KPiAgbmV0L3NjaGVkL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgIDEyICsNCj4gIG5l
dC9zY2hlZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ICBuZXQvc2NoZWQv
c2NoX2R1YWxwaTIuYyAgICAgICAgICAgICB8IDEwNTIgKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDEyMjQgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IG5ldC9zY2hlZC9zY2hfZHVhbHBpMi5jDQo+DQo+IC0tDQo+IDIuMzQuMQ0KPg0K

