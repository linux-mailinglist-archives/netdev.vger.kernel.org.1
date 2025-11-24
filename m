Return-Path: <netdev+bounces-241150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA04C806C2
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2F6F4E4D0E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEF321A449;
	Mon, 24 Nov 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="OXIO9AE4"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013073.outbound.protection.outlook.com [52.103.51.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9791272631;
	Mon, 24 Nov 2025 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986596; cv=fail; b=Sl++jZW+2x3wAoG+lMMmOJ9wKBJ1cHOuNZZb0by/CfHalL4DECXlSMxU7AjRJeJuxl9sAXgI1HU1JaM6qGq8uAyw1vzvuT/dLLuIMusjSNOiQLGK5kYImSehGNCvOhvQxGJHdM3zuSHqOal+We0pkX3UvJij7EOZD5wv3gTyHmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986596; c=relaxed/simple;
	bh=yhJinT/AaqtIcNhx1ZCKxHPf1C83j2omZvur0TuseQ4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DGoj5TjiL/BS6Z6eNUmbybJ/MvaqwDmAKOVYFfBODr0Kll9zgt0pf0KvRRxNm/GAMzEIPhmgAnfGNxOwAwqgGWojP5NHCR3C527rjuuFzykLGZxxQKPtSZ6PhMbb+qZQO2ui8QSVrukaF6fNjI/Zsl2BW/K0l7ulhfoUOQj4SIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=OXIO9AE4; arc=fail smtp.client-ip=52.103.51.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmA7+wHcXDBEyOKk2+Efq1/n0LKzgTvwIns+M1hx9hB5zVOT/rclp8a0MGtkK15tfGor2c5jD1YQ1BOpjtZA53hdgpTId/wnH87A2Ki4kAn/UxLIcWirT+WafyOBqspb/tb8iESVnE9GYjvWFWdHwYcqyqXdtJ5azl6G/itkf23Oi7fJ3hr7XNFBe7fhv5+E0EmTVSYwaBI0RlezGfMASXWgbvb/3AkwOK+73HyUsSF7x97zRF/oXQcGURl5H7HKIr6pERYKvUR8YzthgqF/C77hi70m3cBSKREVbWXYKr+s6o9Kvf+aweYou+QeSvUvj48NZIAI1+bcMNq2As+azA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpoP2YXvdkoFgpJSbzIe7Io2AX4R8SHTsOfGfGnKzd4=;
 b=aFQzoENdUM3FGmBgWTcq6P5pW/t8Q4M4A7tkcCn4yBipLozYUzg1Rw7TtiYVE1LuG5wc/GQll8m6XggFPJ8ttAn3d2WIawDScmxuBlZYKkaVm6Ge429jTF5kK0jf/Q1gohAqLibaSLcYG1CmRtB7P3fGu/UMGeitOjm9kcaBPpj+y4kMl9J4D8OU4+4BvfDJDWR1HaUGu+0BIbXwcHlQQqmTPpO789OpiNjKn5wQJelqMqlwOEl2hJU+pBWgAqNgar5pvxOsNzJWH+4Y/KQTu8wJOvWQjGZ6zcZZ0WOd9YWy1DC82L4j/S5FphVsU+95Ph2bYU3CEuTWAQ7JoUT7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpoP2YXvdkoFgpJSbzIe7Io2AX4R8SHTsOfGfGnKzd4=;
 b=OXIO9AE4wmg8uoiNqJyLWHTE5XVqeSjFIvR3HjqDpEL1Qr0R6BuwBg+/iIMGT0ASvzSqSBFaNOwB/h9hInGLsGh+4jTVaWrz5TT7r7aPnfiaGa4uKvI5IBCG6XblSWDRwK2wKLGOithxCBbOosKj1ZUt1fF68JUNflxU82lU4MIWm78fQMEWJz3f+z3j+WwXuPwE10EsuCtLDzPQRLLSqj4Iaac/masLDfOMDJzxE99mwe9S3hp069wA2wXneKD+pdSaW1PQCm9HYh60M8sgReFbhzbhtJ1L1zIQKcUaJs5tsz5OxlMlwlgSNbK9QlDrhrjxaAn8Dl+Xeh5MKJffPw==
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com (2603:10a6:803:85::14)
 by DB9PR02MB9683.eurprd02.prod.outlook.com (2603:10a6:10:45b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:16:31 +0000
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::7280:4925:465e:c1d2]) by VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::7280:4925:465e:c1d2%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:16:30 +0000
From: David Binderman <dcb314@hotmail.com>
To: "manishc@marvell.com" <manishc@marvell.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: linux-6.18-rc7/drivers/net/ethernet/qlogic/qede/qede_fp.c:964:27:
 style: Array index 'i' is used before limits check. [arrayIndexThenCheck]
Thread-Topic:
 linux-6.18-rc7/drivers/net/ethernet/qlogic/qede/qede_fp.c:964:27: style:
 Array index 'i' is used before limits check. [arrayIndexThenCheck]
Thread-Index: AQHcXTupFkgqgBqwW0GWJ7BG5J+4BQ==
Date: Mon, 24 Nov 2025 12:16:30 +0000
Message-ID:
 <VI1PR02MB395249746F298D4EA6CEBB239CD0A@VI1PR02MB3952.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB3952:EE_|DB9PR02MB9683:EE_
x-ms-office365-filtering-correlation-id: 35e28cfd-d269-4114-3ef8-08de2b534d06
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQlyZYN7lBkGh0fTfigHYmsfqCKz470Jt9vHC0n8JpQ7fNhiZOayOEIqrC99fFr8J0C6GZN0nuGXnFn6lvNarK2W2ZO983znACwfCRFwCrJPYsXzTOYH49OjI+q4NnjoNmyR5pKNIfQCj5nDn8JWl/4e6A9mHVUiPeNb391vbo2Pv5nnWxT7EW/uEfR71y6rPZKZc+lrC1AlaQkKNq6VDu/ElgLx5O2x1vHF0cnmLynqbF8779qhdwJCFnknkA2pEnEwtlKnNb1GAq6ptkJK06OluRszDn7HHxtrwUM9fG7jCchUUE/cTX9jQ9JOAd4f3Mf5qqrKNAKvwIVMlSiz7lBCV3YG9LqddnavINfrinZFUP9/IYj0OSru6tcmwUJ4OqGcskCPVsRMFNTmvFkNcyuZU3CyZi53yZpOh9cAyp+9O1HutiK5FO4zTtErjin/CFDKQrdAElkp3sHl4Z8h9Fjv35dRV00L8nVsFM8qZCwELvmmC2MMg2uG7OYQHT+KvTlSLTiYWYZCIJV4ZVSYWf6X/XIMDVXI+CSB31DkOYXLrQMEbqSpAUzjDCsmxdo9zY3M5/AJQGD3SrBXxCHQ4QiB+6Dv/1+ug5b+oIo8fnGCMXm+Hf/yAJ4QkxcjUYMnfWlLTAzQi+9PnnncArnyeCdaognvzbDxtaCS8uqiGePqwhxoQ+BeWDGNqVQPh2P+mHaK5s5tNbU1rbY0M7YD+SlHdeyzxL/nHLM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|39105399006|31061999003|19110799012|12121999013|8060799015|8062599012|15080799012|15030799006|3412199025|440099028|40105399003|102099032|21999032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?N/sv2Y+LJEsyQX3BgYdNfx9opj8ZQAr720ySQuEEBjnJJF+j7TxdeaA04Y?=
 =?iso-8859-1?Q?tgNqDG14FkwH4cFMg4tct+65nwXfu1GJVc7TgsF73I0J61MIVMXXKWu98G?=
 =?iso-8859-1?Q?KuqYC7yKdAhIOYEEipC8rcc6FRDMYcg3wKKxaNOtY03QzN7iTdj9Ed/Q43?=
 =?iso-8859-1?Q?LGHWQr759wYsxlPzgQ5kKBlg8hUEHVrPkvjB1ZKfEgmuTLr/gEA6QDrBig?=
 =?iso-8859-1?Q?C72ykT3Vpb5ZfM1pTudVk3eyLAdzilKGjLdKzn6swLXdw+U9YCyzJPBB1c?=
 =?iso-8859-1?Q?8KqIE1RGHchbUZBHU1JXX3u/CQxKcM1x9Gomm59sQwOhGffo/W44T90S8m?=
 =?iso-8859-1?Q?bfGkExS0LzLotyJvZ8+BxrMuxkDWlhqOoqREUKBSxRfc50qmbUhF7m2Thh?=
 =?iso-8859-1?Q?Zc87MKGM8OkPmwXf3fzhA6otL86uGaHaOq5PFiSBymtGfHn5rdvg+WhQ8J?=
 =?iso-8859-1?Q?luF50HTUZcK+13s753kzC/WRCtEzVfpdb/uQN3KzF0FIZSvfIiAIC9LiaL?=
 =?iso-8859-1?Q?vGw92eps8p0wzTn+l91gtmhyS4YU5Y4AYV5GdS409MLx94yWPpTsNvKJKf?=
 =?iso-8859-1?Q?np51zvEzOroGxqPFa4W/p4uqPMRlnrI969tamvlLMx+t5svxbRu/bmbXCy?=
 =?iso-8859-1?Q?mzKufVweQOH0vGSx0cykAB1daINRq1nROQlwpWoFyvzEnRpZaIE1AH5Pgt?=
 =?iso-8859-1?Q?AiTMKQdjARQFTvs5MVB5CS6GDpjeYC6iuo8OOhC3mydJ/sinyxhPrnVqyD?=
 =?iso-8859-1?Q?wj1zQeFeY4FPi8GLF8kJv2Jr8iB9K5As3deJT4TUH8P7l0InBh1R0xrpvC?=
 =?iso-8859-1?Q?1WAayCmkhYi6rEowHII5wx8TLVxXeW0ke2XZu70cFvbExuJzL3mzlayfWC?=
 =?iso-8859-1?Q?0mtVIAzDkF1PaW+s6tjN2UuoQzwaenw1xQlu5dD7QSwXjo/6WXewihU7Ku?=
 =?iso-8859-1?Q?x6euU8+lLRLasOocvg1NfQwOUsBtoGKNYzxdLYZmK453VmozuqliaXUsTy?=
 =?iso-8859-1?Q?MqdNU8qsqwOqeUCqFKWtc5q/+44ZfB57/nHC+Pkz4FpNvujZuBgCyUe7v1?=
 =?iso-8859-1?Q?k9AZ2ImOtRcoFPi/Xwr2NAEP9hD9Baio4RRfr1dHM0XEQ3kcSwsYGI/zxr?=
 =?iso-8859-1?Q?a+jCNlcVAcE4aqnIA+aMVgmrxUcXrKQwdLRydKlZBbk1nioiFl0LrdxuU4?=
 =?iso-8859-1?Q?fDE5HS8lvOEe0+7NDVUjCItiuEJG9YH0Lf1+pWWs5BDc1WcYgl4dBTPu7q?=
 =?iso-8859-1?Q?82jvhbY59wyqUynUHSRJn3S49kqFRacSb6Xe9m/5gNhZODNONrWGmsNG33?=
 =?iso-8859-1?Q?UOhv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Y8zDvEJM6ockBNHay1YpSQt6jweLKQENiSea70z/VmnBeEbNRfCto63F8b?=
 =?iso-8859-1?Q?bq0ybK+8VARSCaXODMIK54YBqVoB4CkPHFU7OHWfhgkcdSj5cXn+zdXHmz?=
 =?iso-8859-1?Q?Tvtzcy35uHJO3sCa67vrudYAbe9jIWjhXV5E0tQJHAnWzU24GjD4UY4YSt?=
 =?iso-8859-1?Q?KDW98H3T+8ZvVemcNcOR4DDpQhOlrMCZgWymVgaFHTD3POH+7aUap8AMIx?=
 =?iso-8859-1?Q?0hiqC4xPD7+nAfQqk0stwVNQwZ50+d9viPUsxkPdfFkXBK8UkFeifdMYKh?=
 =?iso-8859-1?Q?RCu0Q82P+YiAyC6d8qrCe81sZ909mnpmk75qLk51erDVNhe10rwK5jJiEj?=
 =?iso-8859-1?Q?JRpRd8NdaaSlMOccfm0ZtBXS66BxrcAEp3GSn2GYeOFN0hncZrebChnimv?=
 =?iso-8859-1?Q?wU37GpM5IGBCpAEtHNfbACX7nscnPXcRBh3FaCNEozr7femp8+gA+vRg0I?=
 =?iso-8859-1?Q?dWvsMVg0jc67M746950+FNbDz7bcxl2KKEiZyzxI3O5dDcJ3BWCWM+C6vT?=
 =?iso-8859-1?Q?jrXGBLTIx9uKvdDoszHWKxKMlNfhDOlBdK1G8KX719QNtwW97BexGdado4?=
 =?iso-8859-1?Q?EbEc2CvLYqzgd+nAo468qRC2V/wJBCEWsn5luGox8J2ZWrGGc+i+jTQ2Zu?=
 =?iso-8859-1?Q?JWEx/z4QpNfPKsgMPYvyZNx2jrnzn0QaBMiMGO96P+xsasMDv/8E5nYGNk?=
 =?iso-8859-1?Q?5COc4v5u9glrY14w1K4IlpiJbkFghbK7Mvu5Mobf3TbkqC5t9tVLeAUfIP?=
 =?iso-8859-1?Q?dsab6S/XCo4hnG6ehYfBbYBMewMttxgouvoVEFTmAUwpBT1e9cZjIe6a2h?=
 =?iso-8859-1?Q?ZZXIpPuYLdSg/IqxFmBXxphg+e63h2kz8XvrRyZvGpaHo2DIJ2SPPgEdba?=
 =?iso-8859-1?Q?gP03tr6t3gb79z0Laa7Y1l3qT3EziEwErMjDCA6nKFakFB7jQjYnaZQvTH?=
 =?iso-8859-1?Q?7ATenbatz8vymTfIER9YGxc8a7/MKvtru4rqvXCkk7gVNZk4P9VqXXcMl+?=
 =?iso-8859-1?Q?SIktKjHrbxFQIgDQhAJg0SOxDW1XyeVZ+Bu7x482csOJyH/5ElMvHqqYX1?=
 =?iso-8859-1?Q?Bss0JCZYGl1/ggcVVIjJXhM+1D88SonUX7yWsp0Kk73vhQoOInNLQC91o3?=
 =?iso-8859-1?Q?y75zdYXMjRXh5oKcd31MEA0LpOn8lJcWwYJU/Cg8rnVm0GgfHyyCkWFjgX?=
 =?iso-8859-1?Q?ZiVtnOTEbhTuBAL9Gz9uRa6RRkpBtHc2HGjXCOI0Yw2EmtOfxOISWmv0I0?=
 =?iso-8859-1?Q?UoSHfRXGWjtRvF2N6+rg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB3952.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e28cfd-d269-4114-3ef8-08de2b534d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 12:16:30.7663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9683

Hello there,=0A=
=0A=
Source code is=0A=
=0A=
    for (i =3D 0; cqe->len_list[i] && i < ARRAY_SIZE(cqe->len_list); i++)=
=0A=
=0A=
Suggest new code =0A=
=0A=
    for (i =3D 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)=
=0A=
=0A=
Same thing at  =0A=
=0A=
linux-6.18-rc7/drivers/net/ethernet/qlogic/qede/qede_fp.c:989:27: style: Ar=
ray index 'i' is used before limits check. [arrayIndexThenCheck]=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=

