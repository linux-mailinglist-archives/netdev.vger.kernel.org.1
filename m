Return-Path: <netdev+bounces-128869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D6897C2CF
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 04:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9C71F22002
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 02:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA5D171A7;
	Thu, 19 Sep 2024 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="DSQTFGX+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D806F3C0C
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726712219; cv=fail; b=tWHWUK0K7x83b/7Ap5Q6a3NLFy2CCA+VXW5J/XNf2HmLMiIxcJynjuoACblSoLkF9504cwEI67bsjY+oWgvrgPaB3FT1mAxCDcgjg86xRzIvSM5gsQVaAULMtYXzUydb/nDZySmqLG6pwBTvEze/IFVly9EoQUIFSYNtR93hC+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726712219; c=relaxed/simple;
	bh=q2NISQHcQxOQLreJV7QG0WW3k53wZ7DKpUKW9YtpbsY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RyyTP/Idp/WJ/8dmd9VBRf2tDbNkIP2M/vSYllLa24MkORWVorASSdtQz6e2uQtGtINy7+nNxhlNZo1BVpbHl/wDo+kv+yOgizvh006tYCR+yITeKdr3UTj5CSiETAHbGjTTYGSXF6/JHgJj85osyqs/Ep/PzsfzSw9lF8LB3PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=DSQTFGX+; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IHnJPT026369
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 02:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=D+LKVTuph
	KoonZVsimuSonBk4N1xSI8RDYmyvWLuisU=; b=DSQTFGX+uiArqqKYQZIQD39ld
	uAi0u8SjtS3X/zGKv8RJPRJ0UfaJha6T20ExrhVddaVJhvDhkxmwTnZ1lj0V7Yic
	rnhEqaSKuaUzNVwsz/5+C0MhPj7uBHeUTsAkRx7/YU8zXjH7BtQ5/YP9kzZ0pvjg
	AGZZOCg3yqC3w/SaQbtgL+xD4qH7VqlG6Ga1sntNYQqMwoU2DOVOVuZmIbV0w/bC
	suFhpY3j8Hl/+ECBbfxJ94mLe2OU3Ut1dEGdBwJFE9X7UIwFZzKSgWYIDzH5KiiY
	E6tevcmEFLHQWt0Thk3uaACscK5HB2s9wLAafB835kK1yJ9g1LwxpOreytQ0A==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 41qxjgp1e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 02:16:51 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id BCFBDD298
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 02:16:50 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 18 Sep 2024 14:16:50 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 18 Sep 2024 14:16:46 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 19 Sep 2024 02:16:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIOvBHlWlTUQvualy2HzW+LRgCD96y8QmjY3ZpsrDQqbqRa3pRXHCAk5XYeuCBhW4JJg3Vaflf7zQIjKl+eXq2DM4wb+MQ8csdu5yE5tmo7rmJL1TW7d5/Y8aAyCZZl8iq94dCTj1ATkN91Pgo1kHhqAoc/AT171nXBpOnxdQfTrQfGxFknrFzDWH4Xuzfae9DPu/dzFuz4ugKe1KIepNz+pEwx8INNPSY+rJR7lto2Tf0nRFcZeYQdWaziua5w3mbhrwIzWZY/s3nf+H2BcKC8Fk4yE8F5IAuWsxOrQVZZm9BHVGNstT5nROCijJEM17cmagKq63JF8zIp+8NXecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+LKVTuphKoonZVsimuSonBk4N1xSI8RDYmyvWLuisU=;
 b=sT9j54u5BYypgFh9Mk/dk+qubQK+46wyLpoHlXqYBc/7YQ7TnyxHq+PkoiqitSCoXCCfWB1BRLZAYxl2+KjyV1tEgOzsR8oYM8NIefrVP4UqDnwQaRUyG3/7X0m4rCG53xWODHoupPGgAmPhSNN4uBXYAWHvYeU+yCKUGTb46/YzZ7qpz2YzWRdsuyRu8rmJbHbvvoM9vVZMRDpmw7vdZLzlMLIOZKFVMOlhsNA85TvTJK8AsBljXZwCtsdMNX6/9sHs+gHt7kdTJD4TazUSFdQubea42mBb6BkU1n0hkuWrFiQ2K3A5RPq8RUC75MKnQJphJpvqHKQ7eu7XmdOZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by SA1PR84MB3960.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:806:3e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 02:16:47 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 02:16:47 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH net-next v2] Netlink flag for creating IPv6 Default Routes
Thread-Topic: [PATCH net-next v2] Netlink flag for creating IPv6 Default
 Routes
Thread-Index: AQHbCjn6L1n2M7jxVE2iZhYySkkRWA==
Date: Thu, 19 Sep 2024 02:16:47 +0000
Message-ID: <SJ0PR84MB2088F2BCD76D3E4758E6128FD8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB2088B1B93C75A4AAC5B90490D8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <SJ0PR84MB2088B1B93C75A4AAC5B90490D8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|SA1PR84MB3960:EE_
x-ms-office365-filtering-correlation-id: 2a517045-2334-411b-198f-08dcd8511d17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?weXnPh4sY8sXspFYtYKHHelxKZfGweh7U7PmYam6iqeFVE0N8SC9EwsY8n/R?=
 =?us-ascii?Q?8oGY/lAt0/ruL4LAO4F1hk/G6KFkSx1q62jKaRtnezdPKC+eaEzSBzkpf3Ik?=
 =?us-ascii?Q?yCz1ZKA5S5v3PpUOYRCRPFpQeggDkfagqFh+rOJkNQrlEuAl9nBJWuHeTxDS?=
 =?us-ascii?Q?IM4MkcTMvly8CiRWDyoJOMr8ViEXYfq111+vcrky37uG/C0Q97G/hYv5i9CV?=
 =?us-ascii?Q?BYjikbNcdGISZmRsG1BMenwPjVYF7E9Dr+GYTQXMCpTGpaebIYUnaKNgkBDx?=
 =?us-ascii?Q?3Nl0H3cuyQSEKML2fD+lggfi4c3hzLlZNfPl8jKOIGZjxS3osef4hHRliLdQ?=
 =?us-ascii?Q?5w3w6C/LCeFrVje66jbuC4kkLiH1c8b+DhDYsP6LdYoM2GPTnAh5m4YAVPsU?=
 =?us-ascii?Q?WU4PwJImLDdRFxaV4IwuYIWBHGdYG3ltfE4eytmVUCIwkefCCcQvX+3IyxCP?=
 =?us-ascii?Q?7ADKlQnIStDUNtvYQgKbPKD9SH3u6RaAi4Aif3hiy9SqsV+046fEDyL4qbUx?=
 =?us-ascii?Q?R2ivBVpHuMsk51jkLbb7HbmO6GXBdBbOQ2BTvFs6Nqamer0V/rbVBWwSylB8?=
 =?us-ascii?Q?jR5EaSmVvwhL0q7sd/rsCQ8B4u/X5yBa06g9aPufw0UR7YtNyJ4q9kdOVmky?=
 =?us-ascii?Q?RxhbyogDVeGw87lsz3Ea4ByRS+7PtyJ9q4iPzMhmspA+4QZi6HjV3pxhn5/1?=
 =?us-ascii?Q?dbJMHHc+xqg8pxGbIIF7J6Tev5unJg+cwQwDLFM9gBPlMsXfhGGO5zey/zBG?=
 =?us-ascii?Q?G/eLsKxfezaAfGPcB3mE5jQL65BNy5x5F7DL9z0Ot5A2ws/IJlGY9AvVZR8x?=
 =?us-ascii?Q?qdfNqthf0fObIO1+a/snUi5J09FSUZ4hut4XK54SE6HEjdv13DeIx6sEnW35?=
 =?us-ascii?Q?LWxY2N2E+sO8mfa6wl7jCHprwAEkk2q/7JtQ9XEEsvlkRWRdB+qgL/15PEtl?=
 =?us-ascii?Q?Ezj3JVW7NcVNe+5MZZgPJJTDlrOgCTikzJdsvtl6OymdXGIG6vw3jkHZfqkV?=
 =?us-ascii?Q?Op2+WN78pnaP8K4jlOUEHXFQIFrdEj/Y4sCSuqaTncGmZBehwH+TBX2ACOKQ?=
 =?us-ascii?Q?XpbXGLSOh5cmYAq8Ppzpsg5U5+xtNsmfgmDVnOUWEvNX5ojyLFl/YDUAEi/c?=
 =?us-ascii?Q?myPneL+E7ifEqV6Ts28kz2sc37sEhIhHDPmXiNaH7uYiKTztjUVC1K2Lop55?=
 =?us-ascii?Q?IClcBPMKmGWaEdSdw2Xzx8q0WiL3FQGWnRN2Z4E3omqtLbGEVe0FjPORBYZV?=
 =?us-ascii?Q?uhqcah8OyulTNh11qh/valtetZZ97+u+lpXzy87wadcFuZgO2lX1BfH4SnoP?=
 =?us-ascii?Q?jBshwOqwyg+4zpZBbRM4cp47V8vpU4vvn66R2rB1x8nEXMruKe1u2FZb1oe8?=
 =?us-ascii?Q?DM18dpp83xy58LlqMD75gjhVANpPlckhtI9yBv9Cro75CyKZdg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SIXn/26ruqyb/vUMMeJ7tVf3DGZM2C4n0tY3b/7FIZFVIckjMQZt4OXqkkqW?=
 =?us-ascii?Q?p1oJurGMu66onJbY0XvgOLv95dfBS55XYeDFVToc+b4eExkxttleAVXYPymV?=
 =?us-ascii?Q?USufv8uGOq8jWCgcNh2ygtfM7DbfjhYDJxgjrKcZY25IehKjSnPvqQAjKHoF?=
 =?us-ascii?Q?UIJm3sSzSzRlgc249JRLqtHSQ17vf38KaitZ8W+FyBYWnWLsa5OLjG9+FAj/?=
 =?us-ascii?Q?irylHFEpJRgfO9gGsTeC0C5YnE0NM/0zvivFiOA6z50fYKTvv/MAToG37b2b?=
 =?us-ascii?Q?uUL5cKVsI+BLEvn2ijuB5Vd+0eQOFHYG5pbChoylc2rbjNdQgYp3L4gEL8hU?=
 =?us-ascii?Q?gDt1e4Qj1py7ASQ50Uwdpv6VJq+O4Ggv77TbuWS9ukawF3+dWexvMBBsKpDD?=
 =?us-ascii?Q?wSRbTOpeDyJiABQVjvxeFw+vEgi7NwT2Z+b/9hsjr0TI70JrLfQ4AA53D6BD?=
 =?us-ascii?Q?20PWsW9J45ex6uo/cRLsSWrVYTPDbjtPhWRKaKb4BsZwQ0Wr7IFhuYqLh1SI?=
 =?us-ascii?Q?EUTwxws1P6RjEbcUx36JKibZHPMl8pO5xJdJ2f0BXwe9RKZ0jIrDHf0JqDHg?=
 =?us-ascii?Q?OVlji92/L+WxACdxEFAVIBNaL1cEF4oH4hJHn1UNXPpZvwvbzq8/MbWfQsCT?=
 =?us-ascii?Q?jilr2z/eOLv0sWd/aW13SnR2+bmUm6ix6Woo6XIiVa78G6D15Y9H/WUM4jqD?=
 =?us-ascii?Q?IpWl2SIC85RwstWVSIHH57LTyQ+fhhG2vtvSyAXWuepR08qD6CHxbm/uiI51?=
 =?us-ascii?Q?1IxTeysheg6KvoDAqASgH1n0JWBctq9pSX/TaFlEPVLXdaKsrmAgIry4GvVo?=
 =?us-ascii?Q?DopQHSK/cKMQRUKgUhXb0uzq//9pXUEJOI4TB94BXJlwJzrJw1BYsC5GhgC+?=
 =?us-ascii?Q?ewP97e85vtZP38/vkk0m4QSnfEUN4vHlAtKNj3N4DxVyxOxhyzu6axn3L1pn?=
 =?us-ascii?Q?u3IOBGYFWdPc5sMRwwxRQSStrEJxAsCc7CPryeREtSVlpBqrVv8EQi4Ux4jX?=
 =?us-ascii?Q?CuTXpZRxqtIqJmnDsDWEpymT4bcVI26qPHoO+o1c+p1utrG8cd/LkoXhBTsg?=
 =?us-ascii?Q?PqeS7V5AhER0oS4NhbQO4+MFwvXopHlpKOVeauZfvRXZlRoDHOUvae1b0m0Z?=
 =?us-ascii?Q?ER5Fpycz4y7c7xQGEbOJ6T8mROijubbESfLxNGvlKBY1c/neyUKvxuJxJpJd?=
 =?us-ascii?Q?nDPvc7lnibnYMZFHJ2F66x9pbCMjVWw47UG6Qn7fV6e1Bgx/2sdn+GeTuyfx?=
 =?us-ascii?Q?uwcTeVgxIXlKSghdEWi5v+NDJbo1DcaFxlFrcXZNdLM9eMgF+VKHu0cxf/rs?=
 =?us-ascii?Q?h+V8wXorjJ/3cc2YoVYsOrHejyvuZCPcSRlZGcXx+Pl0U/8woRRU8HyTRUvN?=
 =?us-ascii?Q?R1jExPpuGXUdVcPBGmxS7LmSgdWJZtJPX0AmHCz2Zu5PTj1skZIrBT92tzId?=
 =?us-ascii?Q?TOxJtLqQ6PUuYLqBgnq+G/sf6RcFIdIyDFGzFq5JpHN0nqr4lZ2/WH5r6mAz?=
 =?us-ascii?Q?/CzlN/adJ2wo7eZY21JFHBuAbLxF5OCKzrZIeP+PpHYOVFzEPrAlNfqW47PJ?=
 =?us-ascii?Q?1jt8ppbix5/ZbKd7UCFnrsq+cWXDo/7NSrPmgZyY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a517045-2334-411b-198f-08dcd8511d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 02:16:47.1467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mS+dfvBb8RzwlX7Dy9csNe31H7qweEKsLWkcf6IQPv2QJWUqaSbXkOAqTiBu/H51evVNdwT9SLUmwf5xKT/iyR0T5/Y66uwnDpFbij860Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR84MB3960
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: i6ahzGzqbpTvhMyxEnAiYG7FPVUooUZ1
X-Proofpoint-ORIG-GUID: i6ahzGzqbpTvhMyxEnAiYG7FPVUooUZ1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_01,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190014

From 95c6e5c898d3eef3e6b37e9b6e238bf6b65cc57b Mon Sep 17 00:00:00 2001
From: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Date: Wed, 18 Sep 2024 21:29:31 -0400
Subject: [PATCH net-next] Netlink flag for creating IPv6 Default Routes

For IPv6, there is an issue where a netlink client is unable to create defa=
ult routes in the same manner as the kernel. This led to failures when ther=
e are multiple default routers, as they were being coalesced into a single =
ECMP route. When one of the ECMP default routers becomes UNREACHABLE, it wa=
s still being selected as the nexthop.

When the kernel processes the RAs from multiple default routers, it sets th=
e fib6_flags: RTF_ADDRCONF | RTF_DEFAULT. The RTF_ADDRCONF flag is checked =
by rt6_qualify_for_ecmp(), which returns false when ADDRCONF is set. As suc=
h, the kernel creates separate default routes.

E.g. compare the routing tables when RAs are processed by the kernel versus=
 a netlink client (systemd-networkd in my case).

1) RA Processed by kernel (accept_ra =3D 2) $ ip -6 route
2001:2:0:1000::/64 dev enp0s9 proto kernel metric 256 expires 65531sec pref=
 medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium default via fe80::=
200:10ff:fe10:1060 dev enp0s9 proto ra metric 1024 expires 595sec hoplimit =
64 pref medium default via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra met=
ric 1024 expires 596sec hoplimit 64 pref medium

2) RA Processed by netlink client (accept_ra =3D 0) $ ip -6 route
2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires 65531sec pref me=
dium
fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium default proto ra m=
etric 1024 expires 595sec pref medium
	nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
	nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1

IPv6 Netlink clients need a mechanism to identify a route as coming from an=
 RA. i.e. a netlink client needs a method to set the kernel flags:

    RTF_ADDRCONF | RTF_DEFAULT

This is needed when there are multiple default routers that each send an RA=
. Setting the RTF_ADDRCONF flag ensures their fib entries do not qualify fo=
r ECMP routes, see rt6_qualify_for_ecmp().

To achieve this, introduced a user-level flag RTM_F_RA_ROUTER that a netlin=
k client can pass to the kernel.

A Netlink user-level network manager, such as systemd-networkd, may set the=
 RTM_F_RA_ROUTER flag in the Netlink RTM_NEWROUTE rtmsg. When set, the kern=
el sets RTF_RA_ROUTER in the fib6_config fc_flags. This causes a default ro=
ute to be created in the same way as if the kernel processed the RA, via rt=
6add_dflt_router().

This is needed by user-level network managers, like systemd-networkd, that =
prefer to do the RA processing themselves. ie. they disable the kernel's RA=
 processing by setting net.ipv6.conf.<intf>.accept_ra=3D0.

Without this flag, when there are mutliple default routers, the kernel coal=
esces multiple default routes into an ECMP route. The ECMP route ignores pe=
r-route REACHABILITY information. If one of the default routers is unrespon=
sive, with a Neighbor Cache entry of INCOMPLETE, then it can still be selec=
ted as the nexthop for outgoing packets. This results in an inability to co=
mmunicate with remote hosts, even though one of the default routers remains=
 REACHABLE. This violates RFC4861
6.3.6 bullet 1.

Extract from RFC4861 6.3.6 bullet 1:
     1) Routers that are reachable or probably reachable (i.e., in any
        state other than INCOMPLETE) SHOULD be preferred over routers
        whose reachability is unknown or suspect (i.e., in the
        INCOMPLETE state, or for which no Neighbor Cache entry exists).
        Further implementation hints on default router selection when
        multiple equivalent routers are available are discussed in

This fixes the IPv6 Logo conformance test v6LC_2_2_11, and others that test=
 witth multiple default routers. Also see systemd issue #33470:
https://github.com/systemd/systemd/issues/33470.
---
 include/uapi/linux/rtnetlink.h | 1 +
 net/ipv6/route.c               | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h index 3b687d20c9ed..9d80926316b3 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -336,6 +336,7 @@ enum rt_scope_t {
 #define RTM_F_FIB_MATCH	        0x2000	/* return full fib lookup match */
 #define RTM_F_OFFLOAD		0x4000	/* route is offloaded */
 #define RTM_F_TRAP		0x8000	/* route is trapping packets */
+#define RTM_F_RA_ROUTER		0x10000	/* route is a default route from RA */
 #define RTM_F_OFFLOAD_FAILED	0x20000000 /* route offload failed, this valu=
e
 					    * is chosen to avoid conflicts with
 					    * other flags defined in
diff --git a/net/ipv6/route.c b/net/ipv6/route.c index b4251915585f..5b0c16=
422720 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5055,6 +5055,9 @@ static int rtm_to_fib6_config(struct sk_buff *skb, st=
ruct nlmsghdr *nlh,
 	if (rtm->rtm_flags & RTM_F_CLONED)
 		cfg->fc_flags |=3D RTF_CACHE;
=20
+	if (rtm->rtm_flags & RTM_F_RA_ROUTER)
+		cfg->fc_flags |=3D RTF_RA_ROUTER;
+
 	cfg->fc_flags |=3D (rtm->rtm_flags & RTNH_F_ONLINK);
=20
 	if (tb[RTA_NH_ID]) {

--
2.35.3


