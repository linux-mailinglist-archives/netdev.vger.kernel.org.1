Return-Path: <netdev+bounces-211740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB4BB1B6F9
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300F0189F2B6
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55BC136351;
	Tue,  5 Aug 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LfoT7QXA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD5AD2C;
	Tue,  5 Aug 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406060; cv=fail; b=EX3v1tEzKh4yRQiKYjRKCsafRNdmy1JJ6A2HJVhZuvklYsCirk5NiG/nW5tN/rQU5gz6NVU0i3HTvinEkc90Z1enClnoy2GAI3WuvCbCi9usfIvXSfhz2jrNq2jPlo2DuMrQ4TOMRxpclKteznxuQlFkKgObs+ztzlNal0fMOy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406060; c=relaxed/simple;
	bh=XTreTY23zPGOrMpHKYUAgz4njxnMHQPxHTL8R0m87q0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jonmzhj5FGhCQE3g2nPLsUbpHApaLCewjmAf4ebQQe5llwcyX+6hFwz+0yV4xe9wQwhIOLlJjg4sMVJjdHB6eVNqznssmUP10zq5WQhpzcm0Q6OwC2Vj/ZGxnqh8gF+4NuvOLQ9oeTyRzQy5mLxI9dmBIiFnCjpG+MQcw8iX+l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LfoT7QXA; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575B6h4e029666;
	Tue, 5 Aug 2025 08:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ekw8q
	LCAV/6qtV0cfeMd72RUHf5s+PG60Wlq9jYgfbA=; b=LfoT7QXAL/TWsFgjgdLCY
	3+JejnqV8vlJrpWQsXLp5RJ0FMVVqegSY46izLI2f+XY+Bg7YvvzBRXwrV0vd6yK
	/gcmuJ+2J0yU1gI9BYDFLjEYmbJRz8NLqDQpXAZTnduQkDya4tkRoI6ZZlV057JB
	9tLIFUL2tp9N4miF+vbOdXBh5bM6s81cvWmUOhDG/zIf3xYrcGXMeJIoJzt6s0In
	jcdeMHjd2U5Op9UCfVQfImgrBXe7m4ypQiL4BPzkghsV7dCAJoYD/DvXtyQv+Uhy
	6grC3pba+SicllPUZWDraKJQ408qAmCrsRnYpTNRBLvTusMOkowd1H7hhYuuBkx4
	Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48argh82sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 08:43:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SA29h3IsEegcmxN2S5q5Fuu8dPwvF0xgJFY/nvpk1PrLWYPucwLy8OJIhf6imr3gzVc/r7kiPTt343lHcCxLDlaQC6DKmVtjdZ0Q7CBVOaBHNbCGn8jHBfPOb0j0jiqcL7yAbznMoG04XV3n6kB5rfEBY7PVhg9WIEg6gZ0GUEe4UH81yqMi1lFXBgpY0WNZIsqvguqEZtKnSg+Esdjs9NyGY+5S7oGSGlgBo63xHtORvx+KOhW/VvNbKCK5FWKFkNdJi6PzTuUeKjtZRCcqHo1ZASUiWySJmpVcJ0zGbMKNeNCjOLlN4gQvptTXJ6ZsiLqJ/zz8WpR8BJyS47TGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekw8qLCAV/6qtV0cfeMd72RUHf5s+PG60Wlq9jYgfbA=;
 b=y2asfmZEFz2OzPXClLB9Ye2+JTQcfRDzMbQyS/4Nys8IrsdfTVHh5OlBN+aBqNbzligjj/0VnzMtwTDrGgfu3vdrwA+usHX7+Egh3l1x9ebuyVLmTjc++azM1E2nl3HcZaGmTRBCc4iihFhGyDxV6zcMxzvMs9KMmZ8jBEplmfvyWQ7U+krbrRAZrqMkqSHYfwgayIRoDQtP2tQxdqmLtQA+ssMqYwjQSrKHuvo7reBHbak7fL4cUG4EsQf+zd7xhTBQRTtkrgd5FTUk0eO3S9zV1mshqk3vI1Cizotl0vg794z6ZDqvlJDxrYPSMIOGIYYR/6PD74/3Sh8wvAzmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6938.namprd03.prod.outlook.com (2603:10b6:510:16c::9)
 by BL1PR03MB6133.namprd03.prod.outlook.com (2603:10b6:208:308::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 5 Aug
 2025 12:43:03 +0000
Received: from PH0PR03MB6938.namprd03.prod.outlook.com
 ([fe80::966:43bd:a478:b446]) by PH0PR03MB6938.namprd03.prod.outlook.com
 ([fe80::966:43bd:a478:b446%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 12:43:03 +0000
From: "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru
 Tachici emails
Thread-Topic: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru
 Tachici emails
Thread-Index: AQHb/I9y42duEFdMLUWHatAmwUddk7RUEnZA
Date: Tue, 5 Aug 2025 12:43:03 +0000
Message-ID:
 <PH0PR03MB693811F7197EECEE85856B149622A@PH0PR03MB6938.namprd03.prod.outlook.com>
References: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6938:EE_|BL1PR03MB6133:EE_
x-ms-office365-filtering-correlation-id: 68b733be-e60b-4338-2a07-08ddd41d9e76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|13003099007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Jl9UYp5/PQ2R1nL9DXwfYYgEtWkvO6Fj9WzcTvl+tiFaqLDY6XMXLs10GZ3S?=
 =?us-ascii?Q?b7+06u75loaMWoVQhMFJ3Rmb/T+RK0uu2jcYSIDJvw4A+0NGi/GUcLrw8IZF?=
 =?us-ascii?Q?w9n6kJK7W75nJF6hDgJsHYCNI9JlVvPKL6HW9TmDTQ9xnX7PYk7C74JHmK0o?=
 =?us-ascii?Q?mdLsL74zI6jXeHIBiP3SCgnYHLSQ65aNGuX4rxPad6WLxn0WUoie1kGMFJ2a?=
 =?us-ascii?Q?/uOf3qNrGEiIuHV3xk6SECDmff2u07mF6V4Vt/6J59zmZLDKP3acJ4BjxHPY?=
 =?us-ascii?Q?e7WuGU2tNyYVCmYFYPJNJw7PpP7obwyqkW/QzGAQ+vhF50K0EJzFuk7eDgs8?=
 =?us-ascii?Q?z6c+QhDorJZSHtl74NnrwFmRmqqHAkJgqFI6/b+F99HAirV5YgBMjdeT+uch?=
 =?us-ascii?Q?B6L4JsjuaBvIZNjUlI8SBY2simlkKn3WRq0LQnXzoVMblv/17V3KaJ5GiI4X?=
 =?us-ascii?Q?G0LmkiJDlLDoYaOFZqDglPHvyLdWlj1QLJDTgwqTlBAgezxcCnaUD0zDYNeH?=
 =?us-ascii?Q?gb+8gKBAE5UIpTTf2AxuqZaPa9Y6oRf8G3QUvxiVIhWVI+LcVG9m5vTtv7rx?=
 =?us-ascii?Q?B5WUDVVdRyuiY5lYUUYKs/1xxdkznq5HOeQ5Eiyuh1pa5hBL8OZuf6zow0AV?=
 =?us-ascii?Q?boXWT8J706cyEBUJ0WRvP6sWnx02qQ4HbORBE5Yt3QF+z8Hs/Og9P5xH5fc2?=
 =?us-ascii?Q?nlEP5qL7w1DTRPHvjhTMMfzGrsVL7EU0umfw+o1yZoWSC+RTue50dHRsgiOo?=
 =?us-ascii?Q?IblJf3KCkW8Bn1e41uH2dQIABqk+2vvihttZvPeKDiY08CbJeeC1e45xWvi9?=
 =?us-ascii?Q?DnsI5lA0VXT/pQc6cgh7c8DA2eJ0YOWUgRDnQ6HOkgRswTyu4knyEXvzy5lr?=
 =?us-ascii?Q?6Ents/jtkCGxWe77+0iZ0QFFiEUN0DweaL7LNuxHV5wSXowCP1dq4rhLbviZ?=
 =?us-ascii?Q?kBXpNoV6Ahd1c3WxOyvXa7ATsHFB2QoX2vWIfmRcO+trgNmMOXT378V6CJtw?=
 =?us-ascii?Q?rez7QUffwGUPmJAuKozmKahlGrrNa0eqcYZ9ZTkero8m4yVIh/QMVow/2pjg?=
 =?us-ascii?Q?Mz9j6wP720zHrIodFXytJ7Kw18wHxz9oHb0JRz782GjC45l4KVRU972YDPzJ?=
 =?us-ascii?Q?m4OKH8Ew8Fx4CpbbOW7KPgFQsmEBWoVYEacgJ8gqqeAoIRCcmiz9nzXb57tN?=
 =?us-ascii?Q?qtNadcRJGoiXWfOzwHdEhvRZuxWK3rdMYmAz9Q9uMl8zkmfznXWFolI2TbGe?=
 =?us-ascii?Q?b0ZvHn1gJ9VQbltQ0LkYL/NIFlgAcKtssWg9YYMz1gBrDgblD2Iom/t6A4gT?=
 =?us-ascii?Q?Fmav/n4huqRvXVryDQwx1yu6N3msK2+snlYB3dCChieO1ICbkFSPwJdi/07M?=
 =?us-ascii?Q?Ch5463siNO1w4txeIOc9jRe3vSKirY107bAqoM9pM6Hi5OW2wSt2Ct+7T50x?=
 =?us-ascii?Q?BAW2trOvPr+cdhSH7HhBlU7EKhGV/Xet?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6938.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(13003099007)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n2SPU6gFL0U9EwhUAyKjoaHxPNOKCCAf9ks7kbiegb7DLmKaaWqJGTdvAAmJ?=
 =?us-ascii?Q?XEkqTkNrZ7sqnNekf9hSJQvL56mlgf1Di1uCzLBLwHpGErdByTB0dpozNC3B?=
 =?us-ascii?Q?AnF4q08HRdAdfKF7LkURyU5egpgG8O3MNfxYmL8RCSrZCo663QnK5HHLiFRg?=
 =?us-ascii?Q?Mw6ESnYa9XaQslfGlShUrC7sLS2SfZP6HJ2FxSvtGmTCSxFilujYE3AsyljN?=
 =?us-ascii?Q?chZdNoNsuCULGMpvXmklObq+Bq/MLbo1IMTOC01e7031WWgzAAHMr7uhA1EH?=
 =?us-ascii?Q?i2UoLmiyrMQeOjHlNB2n6HpKQtAyL2s6EsiPqXgFP8Dq8xdPDc+17A2ZBtaf?=
 =?us-ascii?Q?43lRTM+64e+U1BiTpxJmnfW+OsI9etGhdzjKIZe53GWyXHXu5BDgs/UG7YV+?=
 =?us-ascii?Q?9BP3qdAMennJS+a8IrnfM0XjdfVy/vrFjL04sgDDfsVQ03OGp8Oy9gAyd96X?=
 =?us-ascii?Q?JwQ0c1/BKbIBbhVvCy0M3msr7gYTkSqky2VPOVr07isBEA7F0rLwQKCYn6M9?=
 =?us-ascii?Q?Dj42QjSamUy1d4JqptEqMc6irAixQD8nz+M5twZV7fZLsrLBYLoP2fujsD0v?=
 =?us-ascii?Q?o5OVNicvf44HAlES+asK1XX780bY0FdPC9lXWEKGr3PjYHXX94Ji167AXiej?=
 =?us-ascii?Q?5itR8enWzz2L75UAygLcGCbNrD7/No/eJeWC2h/N6T4AFpgCiwIYFaHO0PwD?=
 =?us-ascii?Q?bPGBTI0yL4VT0ao+qWNXGtqKXOdXYQPQ64Uty9jne8x7YN4WrkSLpZK2KdCe?=
 =?us-ascii?Q?KgArN5tpUwikqQu/A4WQJU7DJGyBXIX4A3pcsfLjyEGzYuG1RcZczwncHsvA?=
 =?us-ascii?Q?MvvmYTKcQTS8Q1KY0DGr/jBInRMyicKpxqPWOLUWVca2QvDiB0JeoFoatKEp?=
 =?us-ascii?Q?JpwtQCD5ZYkgRfecS7hr9zjpACv6Z/VbVVJeYRgifwxZbh9/Fjd2eWx2yMxz?=
 =?us-ascii?Q?ze8k6N71P0KUwztQ4YM+FskgoeDK+L25I470dA5i2rBbwrpXa7I3aW91bMWI?=
 =?us-ascii?Q?Fo+Vt/S0qaoTKQnFgxOVQCAd/2pmAzuNZU0E4kf9ObgibPqU3WJ11OA8/gNu?=
 =?us-ascii?Q?hQrN7uYFkYClwIYzJttLAQXFalJFFUZFemxMenhY0TOVjALHiHtE90XUr5SA?=
 =?us-ascii?Q?gsmtHMFtwTwzALWPaNZZoG7k08viJx4CazHkmh4MrT9x6JrqGtlLqf5Gizl+?=
 =?us-ascii?Q?9ZVrfHuzc17G32lYb1FmuRc568mSiwA8qm1qIV1bY4A2udWSx0jsU8bb/iSU?=
 =?us-ascii?Q?hWtJgzidCLImb32fBUDAoGJdu7wjABPE/FKdwg2zCAU7Imz1AP0v1nHszOnc?=
 =?us-ascii?Q?pprYvBJ5FSskx2kQgtfrgnN7s2u+wnQv9R/OqXXK5j3qjY8dntYwyEOgb7Wg?=
 =?us-ascii?Q?y1eqfC7rwNoyON+boO+8JaAa+vnk3G8pu1u43FbGDk/XuitjHs+sBmhWAOFe?=
 =?us-ascii?Q?pPou1J1jA7ujFLT78RHzwZPhEOQke/NOY9VuBTJ+x1T+f24vnRT7xtwbzY+d?=
 =?us-ascii?Q?EJN8ILsVaOUuF8ALpOE6zsGtdRmMfrJATYooGI6vu8+bucmQr/G+0QRTTCAy?=
 =?us-ascii?Q?FakbnIFe5rWrxG4/K+YYHUOaVwJS7Rv/7zJey5tDaXYYhHtGidjVOD3kiAMR?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6938.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b733be-e60b-4338-2a07-08ddd41d9e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 12:43:03.3568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6B+hdAu3naC/l8QR0AByYS9R76SXa1pPOdyOxffCHmcLJlYuWyANPYMJO3HcESsSCQn3vVvszbb4TosQyuSVo+rgxGsueLa+Rwk6kTE/QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6133
X-Authority-Analysis: v=2.4 cv=aObwqa9m c=1 sm=1 tr=0 ts=6891fc5a cx=c_pps
 a=JVdHkOrRnBzWLs0TqoS/Hw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=zBKkBztrWjV6rEHAp2AA:9 a=CjuIK1q_8ugA:10 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: K9VOWSScU_VTOqHfkB4EVcMFugQAyGHp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5MSBTYWx0ZWRfX9lm/NlUvn5n0
 4xT43kibhV2SjhJlms5n17YXl616Ab0+Y0+cMXhHbiLjd5HvKM3UXtzu42pn18Jl4yvRWGFASzH
 hAxULz+VHg/ufj9MVLc7yvYhwvl7NQPGj4BmsJkLaYpTtRGTShqgitLlVj7giWlYmhh5wIu7T7r
 1f8fO/OJHTghJA3j/PZkELXOrAR7RZOU7ni/xTVmcvQwpfEUDwJTmZPN+mh53fFd8aJcdpuiWZy
 aiaYuzLCrlxrJIlS3sWIKegpMyp7hFvdyCocHU0h3n3JNVYG98e80bW+CdcJY9ga+I/QepM7HSK
 uhrFL7mOAqTdIAtcpA8zyfy9PJSftgncWTQC6XAhKKsHUDc7vxAiuchsRkl+ShTsmTOaEHUlwKL
 IM5UiC9XzyX+ARRuyiv0V4g01iZGsmkua0WWJxKEm7iuxymCr6jVXnxBLu7l6I76Fo5KG9qM
X-Proofpoint-GUID: K9VOWSScU_VTOqHfkB4EVcMFugQAyGHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050091

Hi All,

Replying from outloock client. Hope it may keep the message in plain text.

-----Original Message-----
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=20
Sent: Thursday, July 24, 2025 8:38 AM
To: Hennerich, Michael <Michael.Hennerich@analog.com>; Andrew Lunn <andrew+=
netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet <eduma=
zet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redh=
at.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel=
.org>; Conor Dooley <conor+dt@kernel.org>; Schmitt, Marcelo <Marcelo.Schmit=
t@analog.com>; netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-ke=
rnel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru Tach=
ici emails

[External]

Emails to alexandru.tachici@analog.com bounce permanently:

  Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipi=
ent not found by SMTP address lookup'

so replace him with Marcelo Schmitt from Analog.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>


---

I don't know who from Analog should maintain these devices, so I chosen aut=
hor from Analog of one of last commits.

Marcelo Schmitt, could you confirm that you are okay (or not) with this?


Okay, I'll take mainteinership of those.

Thanks,
Marcelo
---
 Documentation/devicetree/bindings/net/adi,adin.yaml     | 2 +-
 Documentation/devicetree/bindings/net/adi,adin1110.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Document=
ation/devicetree/bindings/net/adi,adin.yaml
index 929cf8c0b0fd..c425a9f1886d 100644
--- a/Documentation/devicetree/bindings/net/adi,adin.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
@@ -7,7 +7,7 @@ $schema: https://urldefense.com/v3/__http://devicetree.org/=
meta-schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!73gdqTRuQpEL0--RU43XL53e-LqwYNzpe=
v_m_42IRTa0NKgxZr2OKSqH7g_Rc5ogFapE5tzSZ20mO9jn31d91LFJ8ry9jlxA$
 title: Analog Devices ADIN1200/ADIN1300 PHY
=20
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
=20
 description: |
   Bindings for Analog Devices Industrial Ethernet PHYs diff --git a/Docume=
ntation/devicetree/bindings/net/adi,adin1110.yaml b/Documentation/devicetre=
e/bindings/net/adi,adin1110.yaml
index 9de865295d7a..0a73e01d7f97 100644
--- a/Documentation/devicetree/bindings/net/adi,adin1110.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
@@ -7,7 +7,7 @@ $schema: https://urldefense.com/v3/__http://devicetree.org/=
meta-schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!73gdqTRuQpEL0--RU43XL53e-LqwYNzpe=
v_m_42IRTa0NKgxZr2OKSqH7g_Rc5ogFapE5tzSZ20mO9jn31d91LFJ8ry9jlxA$
 title: ADI ADIN1110 MAC-PHY
=20
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
=20
 description: |
   The ADIN1110 is a low power single port 10BASE-T1L MAC-
--
2.48.1


