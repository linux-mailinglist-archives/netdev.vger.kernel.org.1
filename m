Return-Path: <netdev+bounces-300312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gnI9L2xzM2phBwYAu9opvQ
	(envelope-from <netdev+bounces-300312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 06:26:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A1569D7D6
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 06:26:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=xU6hmyh7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300312-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300312-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C20573015C3A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAB237880B;
	Thu, 18 Jun 2026 04:26:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7797311940;
	Thu, 18 Jun 2026 04:26:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781756777; cv=fail; b=UE089r+KU7qzMIwPkbSegyRQ3zs8pCHQYLc3okhy4pbxAn3IPOhUwyNvd6/tf1nkUqyGldacS2Nx5mKhVMD1nPrMBvOJGYu7PQTEuo1HnhAMt/Amb8DPTxqVLuE54pGTOMkfNLs4RK54kL/kdbFOTETN2PWoxixqjEdDjOJ3V6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781756777; c=relaxed/simple;
	bh=g9D/7rMuUQxTfnOxpTgXMKu1Ua9eVxNG72J+0EKintM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SrYbqpg+104eeyJ7/kHeX00ISnGEUYTaiRFrJXKxFH+lRFWUzwsCgUHTdHH21yboYNFnLNcPpZWGceyCdus5Su6hNX7FIVXL1LaX6KgfJInUnXfTmXsn7LmoGFfHgy9P2sdCp14XL3aFDoJI6WQZ72F/HtHjjGLziTGQb6ix1WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xU6hmyh7; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrDyM/QCU1tQGQCVLm6xW75HtBohda+bNhKMahNczAHUyRYy4qUNXBk1s8vdOqTlsJuTolV/vYKbzd7q+isDTeZj3fDXLKpQifJoCLwWuG3f/92ktfWvjOCB17HRIOLj+LrQbVpaoVtldM8DCrtDlPXdoKscifs87/XQWCu68DtFQ8VlytLlLrq6V0Q8YYFt/0zujePt/VIdRXBj9BfXtZN3OzHHZrA9XK1YiHlqU5/JTFJtChaMSVjC//EgC+sqxNZzoNdsmTo4opPYSaVJc6JrA9OnxoRfR24C55sEPsI8bfXGiFHoJ3Fi/qXoQGFOBDgAUeqm1FkKrRymEsM+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9D/7rMuUQxTfnOxpTgXMKu1Ua9eVxNG72J+0EKintM=;
 b=Pmi5ahkxqLS7yLeqEEx+8FID7gnD7vAsvCx43Y7irhrFuzl+yYGG5F4PyIqZIQWlSXm4NQ+4UJ0fv+VUUMGil2CYY5APxYMPfT9QbzjNaEPck1Xcnv623GpchVy9lAFrM6jG/QX2ZwFsLx12ygpd5LwHiwlHhXPbUd3FVblG7KU+Ja3CLS5Wm22Q5Zt9PxJC3heFb5tajR0HxaegzLBzJEDePLKYu1XqVT+kCgQCZ15+ewiF+SKiEWQ4ekb5SnmyaOjBVxaECOCgsrBHs9jH4TkgGTmNOzpmkVUkW7WNntWFLpJjwk8i9fQUfGvJJiBgzhDxWF8wD8WCbah3+wHGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9D/7rMuUQxTfnOxpTgXMKu1Ua9eVxNG72J+0EKintM=;
 b=xU6hmyh7/F/bD68atVuOUM4cuKQoOaYHH5kkBBaMar0YWzBXfxojImwdChcrGel46UEpPbDxBbTeUcaDipe/iZLTb7RlFXa2q58+q0SC7R+Pfir81oSTVRiiQoz6HzVkOH5ruhkIjgVhAc08MJ2Vn4TcKO8Qc4ZRqtflt4eqdkOH16AqgMrqBQF9Nm6/J2qfu2l4xrwE0dcyXG2Qz+68cb/bA4iERe3s0s5EZ6dL7hv56Y3IZTVFXmL0Y6ESd6XaVH+asLu2iWes67Ry77Ga9e2HbcankLMa+CdlsQXVDFJj5mhhM+7GiAfjXUqXZdquA//nqwx2c4v2TMM1XTOuoQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by LVUPR11MB9785.namprd11.prod.outlook.com (2603:10b6:408:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 04:26:13 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 04:26:13 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Selvamani.Rajagopal@onsemi.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Pier.Beruto@onsemi.com>
CC: <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Conor.Dooley@microchip.com>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Topic: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Index: AQHc+e0XZNEa+AKE3E6e8zsz3KcUMrZAt0IAgAF/twCAAYpcAA==
Date: Thu, 18 Jun 2026 04:26:12 +0000
Message-ID: <5e716006-e8d1-49cf-9e01-d1f9129e0239@microchip.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
 <CYYPR02MB9828B41845A534BDF0B0C17083E42@CYYPR02MB9828.namprd02.prod.outlook.com>
In-Reply-To:
 <CYYPR02MB9828B41845A534BDF0B0C17083E42@CYYPR02MB9828.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|LVUPR11MB9785:EE_
x-ms-office365-filtering-correlation-id: ffcea088-feca-481b-eeab-08deccf1bafd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|56012099006|6133799003|4143699003|11063799006|921020|38070700021;
x-microsoft-antispam-message-info:
 uexnaYZh3eB9ZADwdHCTMA+V+dEFWR6+oIC033Ni4S4GMpuqLJisr4q9kLtRyGOa/jEoQOGVsyjN5jZJokcAoanIjheEfIdRuL2qwO+lZrOfLNKJZJfilkKiN74ubEGqL4ef+svlmwntLHUeE0rULgKt0QuPCcbmqDv+qLr9WgWgE0sQiNXZDs4ql+Yvkx2wg2zonOvjXnkDBRuEetGwTBB8fiQ26398EJdR2nnXYKyy0HsA+q1TJ3ThhF5X+ZYIqcU8CVY8T/VcjeiFC3dGDA2JTzC9vLQ7ICQxMYwJ8mrg2WkJL5HIiisMfEQGkwbkNYLq374KMKeF9GlGgkJAfiwNwZ1a4rFQfKt2yPp5cjGFKz0+8K83ssp+lAiQpWMlB18yjTcRyxrTVH0a0nYdz4RI2fwII6/P4aIirdJcI8bVq5qNDkHnUqzFttyupRpsNb3yIct4Dk9gyNdUqScJF9kNuEJSJoBfhdcKh9CQc9XqA0mHfOYg3MA3p8SB7sKiyHUJzu3POdX5pDOU++BsM/Zo9m2vUwTRE6FP126A8vhytzWZADtc/t9qIi7wpY+F+MOqRAn55R6HFk5RyTjvV6yZTSgYiDDkkFJMLcXqYV/f9p1phys/VJ+p2nqwrYWMPGmvxWK6Zv5Aup4HhmesoPajVufmIl2A7kT0jOJwY4HeLdzVp4h9gtuAcSp+W9Z54zia583NmlR3k/i3KsveWPo5KH1Qlu7FW06wEOqR8Z4QAHKqKKZ57pY8wpTd27mB4i7+Ub4Q0UdDabKeh0wTDQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(11063799006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUoxakdtaXkxL1FwZzRTSy9EaDhIT2RQU1I1b1FKU21jMm9JZWtJNENURmNU?=
 =?utf-8?B?aHdWTmFBNW9LRHJ3bkptTEhRUnVUbExkdEc0OGhnTU4wc2ZNTDlMNzZSMkV1?=
 =?utf-8?B?MEZOU1VJVnkrMTZBYkg2ZjRVeTJVMXpUSm5uNVlwUldRUGh0SHpNNlFHV294?=
 =?utf-8?B?TWZRSE5Udkt2TW82TlFGRkFYSDIxMlNxanh3RFVDakcwMExFYWp6WHUrNStz?=
 =?utf-8?B?RzhXQUQ3Um1TbkRaWFJYZDY5Q1JjV0FwdDA3UGFXVDg2Nm9aS2tyeTZpeEta?=
 =?utf-8?B?STNHSURyRFdVek10ZnNwNW9qS1VmaE1za1NJaC9LeG4xUWJCNCtmZis2c1Mw?=
 =?utf-8?B?T051bUJ3c2ZabEIwZ09vSFFLQlRScG01RXpvQnJYN3h2ZDJtMFk5YlEyZ2FK?=
 =?utf-8?B?WTJRajZMREZFYkJ1UGJVcFN0VzFNMUNnK0k1OW1XR3l0ZGZvK01ybUZPZ2hP?=
 =?utf-8?B?Y09qQ3JQMzBXaldWTG9rWUJDZDhaaS9RY3gyYlFMano4UkxiaFdBNVhXdzBn?=
 =?utf-8?B?QWFFWHpIcHo1NHh2WnVYdmxYOG5YY1c0SFlWOG1PYUxGMWNvcWlKQzdrMHl5?=
 =?utf-8?B?WnN2d09QbWd3YW5mMlZzKy9YUEo1ckVIakw4VjVPY1lSREVtY3crRlRmNksr?=
 =?utf-8?B?ZW1kOFVSbjRTSTYvT3ZhS0FCdGUwR3EydTZhU3lESUNOaW1UbGlDdngrYzVv?=
 =?utf-8?B?NFd5MlJISTEwSkN2dTVZblp0UkV1dnRlTDFhT1dPbXcwTkNZa3AyZWVLVUYr?=
 =?utf-8?B?ZHE4dHhZSkhwdjVoT2NISXFWWHZJRkx4djUzUE5PaWhtem82RzNWOVNOQTkx?=
 =?utf-8?B?TUFDZmdVYmFIODYvM2IzN3VPdUVkT3F3VjJnY3BRZU14aTB4b2srKzdydUFq?=
 =?utf-8?B?cEhWelBlejZjTjJialBNblhVTEZReXJUMmNjRDJkQWl6OUlIUEZGY3ZwVVFG?=
 =?utf-8?B?SVRKVWJjVnd6RHhIRXVPZmFmZy9OekhpVWNHWXA1SU5Xbnc1d3QzWEd5SE9Q?=
 =?utf-8?B?R3RQb29CcmlrZFludGVXSkV2cDltV1BMS3d2TVZpZm1IQkRvbm8xaVFJaXp3?=
 =?utf-8?B?YlhIWkIrVnBVb2FsenNJWHRManlpOWl1WjNkRUliMzFMNE1NWHRucTZibXV1?=
 =?utf-8?B?ZFgxWGFjSWErdHZNcjZmV3ZDaVhyR094a3ZmdVgyYnMyQTcybG5xWUhubHFE?=
 =?utf-8?B?dzdMOGdlR1IxRlFXTVZRYmYyNmRzd1Y2RVE2Q2drbndaVFFQQnFBTVhUaURI?=
 =?utf-8?B?N3VFa215aXk5V3phZHEzUGZHTzZmeitDT01ZcUdGSEZPRzlLaFNIU2lYQ3dF?=
 =?utf-8?B?SjdmSXQydzdoSjc1WnUwemNjUGR1T2FYQXVvd2FFSllYbXFSQzh4VjFDUk9r?=
 =?utf-8?B?cDhKYjd3dHRPVTIrVkpabGJkbkF5WUdPYi9CUWxRQU5SbWxSeGp0eDZyYjVT?=
 =?utf-8?B?ZDlsSjcxbyt1TTduSFJHRXgzM3hOa3JXbG1VcDJGeXJHQXhFbjY4M0RLcmhP?=
 =?utf-8?B?c2VnWVhVT3huTGVMKy95ZklQc2NEMXpONytScnlkbTFkcFJHakUwWk43RXd2?=
 =?utf-8?B?V3ZSOEFqVkNFUW5iZkhJcDgyeU9JV1pSZFYvRTIyNUhoRkFONFppUkYwRDJM?=
 =?utf-8?B?bEVXOVU2ZEtxNGp6TSttSTkxeFhNWjZWbGVTOFEwQVhHZktRYTdyaWlnVjFq?=
 =?utf-8?B?dHpHR2ZLWnU0WHExRkpURVdiMlVVdE5QZmN0eHZOa0ZKVjZaYzhYUWxKWTVj?=
 =?utf-8?B?S01RL09ib3Z3NVdCUUtZQ3pWM08xS2pscnNoeWk2UGhlMHhYT053RGZLLzlV?=
 =?utf-8?B?VlRvdU1pZ0crZ05nRHBvN2FpcFpNOWdXWDlpVHZLT1h1UVN6S3BVNDJab282?=
 =?utf-8?B?YWlYbVFLMDJTZjArZXBLSUhSRFhhbWI4RGJSRytlK1pXbm03N0NacDFlMTk3?=
 =?utf-8?B?V0dnR0pLWWNPSnFjejlPYWZaalBaWkdmbWQwcERvbXFjMElQZGhOemtqVjAz?=
 =?utf-8?B?YXdDVmxvR1gzK3huUnlQcERXQnpYRlVGOWtZcE5jMVozLytnY093UFJDdjlr?=
 =?utf-8?B?bEVRQURKS1ZqYzN4Tnk1S2pwQ3VpMTdLRXFUWitQdUp1dUtoV2NpNDZ0Ulhr?=
 =?utf-8?B?T2Zrb3JoZDBLUkNrQkxMVXh1c21IMG1iREx2eG1ZelVCSGJzdzFNTUVTTDFI?=
 =?utf-8?B?dmlIMjJMdE92eXNNOCt6NE50QlhFT2xsOXBPencvQzdmNXZrMGRoZmVyYUZu?=
 =?utf-8?B?MVVhVE9aazM5cXc5d2RvQjE2VmxZWGV3Nk9IVGVnSW8yNkVnM2xZTjBGMmFO?=
 =?utf-8?B?L0JxU2I5RUFMaE55WkZqem5GVEQ0S3E0alNYWmkrZXlabFpNT2cwcDVQTVY3?=
 =?utf-8?Q?xfyj8xhQmwXQeq9Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E844CC47F659E34E90BDAD3CA0007207@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcea088-feca-481b-eeab-08deccf1bafd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 04:26:12.9151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJQkeiatXW0LN0FEG5lDlb+u3zoDfLqD6OIMDOejh0l7/yPhKnY5y3qse4+6bSnV6kb+ULTVXX7mxhs4bkDo2qIZgz4bvyL9HnL3BBz3i0KOdkAdfMN4ZaRFATJ7wj42
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9785
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300312-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55A1569D7D6

SGkgU2VsdmFtYW5pLA0KDQpPbiAxNy8wNi8yNiAxMDoyNCBhbSwgU2VsdmFtYW5pIFJhamFnb3Bh
bCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBuZXQgdjUgMS80XSBuZXQ6IGV0aGVybmV0OiBvYV90YzY6IEludGVy
cnVwdCBpcyBhY3RpdmUgbG93LCBsZXZlbA0KPj4gdHJpZ2dlcmVkLg0KPj4NCj4+DQo+PiBIaSBT
ZWx2YW1hbmksDQo+Pg0KPj4gSSBkaWQgYSBxdWljayB0ZXN0IGJ5IGNvbm5lY3RpbmcgTWlrcm9l
IExBTjg2NTEgQ2xpY2sgdG8gYSBSYXNwYmVycnkgUGkNCj4+IDQgYW5kIHNoYXJlZCB0aGUgZmVl
ZGJhY2sgYmVsb3cuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBhbnkNCj4+IGZ1cnRo
ZXIgZGV0YWlscy4NCj4gDQo+IFBhcnRoaWJhbiwNCj4gDQo+IFRoYW5rcyBmb3IgdGVzdGluZyB0
aGlzLg0KPiANCj4gVGhvdWdoIHRoZSBOVUxMIHBvaW50ZXIgcmVmZXJlbmNlIGFmdGVyIHNrYl9w
dXQgaXMgYSBjbHVlLCBJIGFtIHdvcmtpbmcgd2l0aCBvdXIgdGVhbSB0byBzZWUgd2UgY2FuIHNl
ZSB0aGlzIGNyYXNoIGluIG91ciBzZXR1cC4NCj4gV2lsbCBrZWVwIHlvdSB1cGRhdGVkLg0KU3Vy
ZSwgdGhhbmsgeW91Lg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4+DQo+PiBb
IDgyNzYuNjkxMDY0XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvcg0KPj4gWyA4
MjgxLjY2MjYwMF0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJl
bmNlIGF0DQo+PiB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDA3ND4gZHJtX3BhbmVsX29y
aWVudGF0aW9uX3F1aXJrcyBiYWNrbGlnaHQgbmZuZXRsaW5rDQo+PiBbIDgyODEuODM5NDI3XSBw
YyA6IHNrYl9wdXQrMHgxNC8weDgwDQo+PiBbIDgyODEuODQyODY0XSBsciA6IG9hX3RjNl9tYWNw
aHlfdGhyZWFkZWRfaXJxKzB4NDI4LzB4ODgwIFtsYW44NjV4X3Qxc10NCj4gDQoNCg==

