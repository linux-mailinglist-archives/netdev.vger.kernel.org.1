Return-Path: <netdev+bounces-145876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D303C9D13A9
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D73B295EF
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D31A9B30;
	Mon, 18 Nov 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nn5ZXFoK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F4199236;
	Mon, 18 Nov 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940986; cv=fail; b=sJ2kwzjzY1bdq7uzeqlJ+O/Eqw4/oawXHqVAn8EH0CM7E6kFmsS/rMBe3ztrn/BTFp2BG+QN5/xE+SIMUZuxmMMZV1COid7zH02uwInhyZ0x00dR5D/bTAtJmPXONaMuL8kfcP5QPuaJAviBRb39cFNDNI5StaOEBvUAkJ4UhUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940986; c=relaxed/simple;
	bh=lBGGG9H+O8K2lz9CvkpkbSFzCAHhPTHeEDC0MN4TMDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r1vEKHg1+HseIrSVWxACYo5iBZuMdGedLkajgBk+uIdhor5Wy5VPOgtlNr7+M24E8VkdfsFvI9jbHRKrt59iUuzbzN9AhYqSQcIuGDfs5Q0r5ZtlRUBy9Eo72VNAIX9NuF0zI6EkXM7Vy/6bI9ImqCuISesVvmiXn72Pc4/BuOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nn5ZXFoK; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6KaNhHvmAzm5JZRysLgqDOmnh94FmKQ4NvVhZXn8htQwGOQguE85OAxsUue7do/xnmdyAZKrMgpNgJ6zxKp76ySOU/y+I2VRja+t/BBudCcqmHemrx6PuEJ/GqIsBjRN1Fcw6bZqOc4SjqMxof8whQa6LGj5NDr8mig9gDfiii5vG62T3t5Nxg2+eNkyZ3kObSWmhzyJyHAWWyjRDy56EDQijRDqoxXqMIQeOVAVVyjBZAz2u+djibqCZrWOtpxxRnl8ASY34+TcPyq1d7Q5UjC4o+3n2dT9vklNV2G9xx4pAbTvNoTEMfIdMC/WuNAfzSS639r0QX75mjba4okcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57Zk5pb/1mXummfCwv6xmcKXu3ytU6+jOecynDoC1Sw=;
 b=G5Tgz8R77ylFloAxTCAULC0lRrNZ26ezJUCbwf7YBDs6isourggrBLCDaA4jWXeWY6Z45BxbuFkDuHKMjFDOJykiXQFG3U2wFdlVJIYjbumaKzEgVHfGXxBeF1BMLkJ7+hGV6rTFmVQEyWnDYShYy8p3kA+XfMRo5DlrQvD6BbvU1qmvIh0wI/AJiTmFUkME3ffTCrFgIVoS9fhG4OhdOXQqRC+PfSWMGOhg9TZsW9x66Cr/0Gg0G2/KWV68mNblu7/5Rh3Z592Hh9Y7crW4JfczdGApqyC9F1Pd7YOj1poCtsbam378hg/W9ch7YgiqGsQqXK9xvqHPYCZNmKK5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57Zk5pb/1mXummfCwv6xmcKXu3ytU6+jOecynDoC1Sw=;
 b=nn5ZXFoK/7Pcs0/fOcmn5bHMCJ9jPsOG5iZNxytF4vd7el8W6JGWVZvpV2UCBpaRCnlTB9xnf7VTDGSV6Pimz55NvYyJNsuSXrTFFQoLwnByDRF+n/J9TH4+RJUTNvRfpthH2FzNU0d+aNpa/sg1Y24PeY+sfn0Whq28QGUDbLo=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 14:42:58 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 14:42:58 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "sean.anderson@linux.dev" <sean.anderson@linux.dev>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Thread-Topic: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Thread-Index: AQHbObk35YvZESLwV0+n1uONXKXyWbK9HGng
Date: Mon, 18 Nov 2024 14:42:57 +0000
Message-ID:
 <MN0PR12MB595399792A32D8832F1B54EAB7272@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
In-Reply-To: <20241118081822.19383-3-suraj.gupta2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CH3PR12MB9021:EE_
x-ms-office365-filtering-correlation-id: b1d70008-ae10-40ee-a5f6-08dd07df4b69
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b+6vgiZ0y2FeNO5lrzaN7YJw8LFnPSyD7WK10NmOW6MQiSrgHGpqgCvcHFL0?=
 =?us-ascii?Q?kYDVxbskGN/yxfls+BKaGfHLN6zimDMBbqSnSRzVZ4oiDLnNi6QIvcv1xY4i?=
 =?us-ascii?Q?nwsWYhFlX6+2YkBoYUMxpma8lyeqUR7NHfs6KQv3nkIJMmpVeYDQuGnbTZUS?=
 =?us-ascii?Q?qNGjj23k0GbcDUD7VsAHXqXCY3ipuYR2tr8WgS4Uue0P8Q5N9VtEoCgWjMlx?=
 =?us-ascii?Q?SJw4bkeh+9RZNPuigeXPESPmaSx9VU7+WpRaqJ2dwyyI2nURzV7KPXtKCZa6?=
 =?us-ascii?Q?a+9R8zbfZQiqUAtCruFfFD0o0ZseMy+mAW9wMSa3CixYjMcJNpNwZWj+9DvW?=
 =?us-ascii?Q?YafDoCft4Y/VQqO/OER6MzB+ZnlpzX7NFU8oi2XSCHpw9CxKsWMDXTjggq4P?=
 =?us-ascii?Q?T5wfWO2sAzw5iXs7/EAz4hVF9oreTu4mYJC6XoUw7lSnSab6cys7vszu9VaB?=
 =?us-ascii?Q?cPks9RfQQV2RannDYA6oApjdJdQkg/RkhPFjaEmJes3Z5FiEU8bqgDFVfa3d?=
 =?us-ascii?Q?JrOd1SoO/DyGwszBhw0ymNQiJ6d6vwFuMhFgG0te7fvUTvPYGlofk3Torz0u?=
 =?us-ascii?Q?rYTyf5WhkNZ0JCZYFWXOILcb5S1uJYgoRf7atr2Vi1vIQUkTmwq2oKMs05eu?=
 =?us-ascii?Q?KW4QHa+0ejyvWWE3cnsTqyhZgZ8bX8P2HlZdnAwfMNCkV2ns4KS+OFohPiKg?=
 =?us-ascii?Q?UQnNhd6vnotBPI9OFXGQICp9Tu0dC7vQBV+rEZx4UcSmr2QOd1MhH3AXU/JB?=
 =?us-ascii?Q?kCtJ4itRMP4BaZ5StQyRsLi37/BhoKL6kYpGLzn1/aaQ+3DkVVgP5zISNKvk?=
 =?us-ascii?Q?SgRHvFAunUKj/aotPhuML//nwBExfsqOX3SmlJjxW3dZvwxZfvkdafY9L/TX?=
 =?us-ascii?Q?GWl6jS3W0TKBvVC/RvDw0NS0nxoic2QR6IhFNtjaTB68XuJXJ4lJVNh5Q4iT?=
 =?us-ascii?Q?RXK25SXovrqjisbycxy/ZJN6Z87YOd4V0c/kYyUM/NN/JcX9n3+o2PrXpA/5?=
 =?us-ascii?Q?tb3zVeLvzfT95l5FEvAyQIigCsCrNtIgbtoWSP7ywp/dJhxraG1ype41KN9N?=
 =?us-ascii?Q?g/Y9OW8aDRiY3e4ouxOUjkKmKGqX7HASGru3SWzPFtB/Ijz3xxlUf4xC6vlv?=
 =?us-ascii?Q?MHfX7PpzYX0mQGKHwivDG+5MiAtlOCi+kpy8UBMiC/QQO1nA2goI/sy9ysFh?=
 =?us-ascii?Q?GKXYI71pMD8PgPkBP3wrRssrTHM0rVz/Ov5Sto8HTjuEldlpbIIdsr/QCuJx?=
 =?us-ascii?Q?0ef5JUK50VXAX00FwB/lJAjRSkAEJeTGoipxr6L8j5mWZZ6XF7SfG1x050y4?=
 =?us-ascii?Q?SVdFykO1fr0WWxSfqVtSjE5HdebW4fbFnuLrcXW/wIFjb2KfXMKPRWHHsi6D?=
 =?us-ascii?Q?xkSPi7D2yjuxzZGFMab/XvzqBvgI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OHOHtwbftgMEyBX20cB8+eS+3hpfirDjT2aPTjis2tuu5JJgj8s8ysgra+2H?=
 =?us-ascii?Q?G+hncpXv8IZT5/w3fINwDB4QLoE9Rs6emW5mc7g5lqMPx32uz+OQUDYs/z3Y?=
 =?us-ascii?Q?x/IbZU0gL8ZTh1Ur8ypI/F6pAa1TEvCtpmAEOShIBi2/G5jqEZxPm+T3THvb?=
 =?us-ascii?Q?I/Wk/CEBV/y1bJV7r3YSGwHWU2M0xy/8MEcCenqoC5ctGg+MDHXVb4GXxJYu?=
 =?us-ascii?Q?K4nGOsgVJFl2t4vUqwqAOf3+I34sXlZP03dKcHIu+EpIWhddMt5HpCoHYVTG?=
 =?us-ascii?Q?yubUurRIBmP91GwzcSEh4W8icTgq6cHywtc8omp5+POjwQcLvWEZ9x3qeatY?=
 =?us-ascii?Q?aGRiEqIts7mShuegZa7nwHHzGMmqMIQQJgYAbT4Q0S5TEUkWR+Zf8582KmCk?=
 =?us-ascii?Q?DUYcTJRGJRWkK85lASd7D2mFs0SczFpOu1wFJPDGAPvhqoIeR7l/hG2j3JdA?=
 =?us-ascii?Q?x5TyJ1KSrzR6t8ulRrql3Vvih8/anlWOEHe9Og5VNEneNeRmTb5qwKMKlwnl?=
 =?us-ascii?Q?iogxW8h+lcZUcF2PHKgNB9SEywytWMCGxvGioZ3pMCJz5hxQeNB9O1S8BQ+0?=
 =?us-ascii?Q?nkbPMrLJCSSdHckRJzEiU+emzHBY7cBk1msAk4zESDZICZWc2qrYev8ZdJ2f?=
 =?us-ascii?Q?B6XyVuDAQ2teIEapyLQiil31vy60iDvRRk7x1BUOygJ5dwoNIhenTJTwcDRE?=
 =?us-ascii?Q?q89lOBJ5WI35cVJf6WSrY8NcUScElUUn2tBPUYoPP/MZT170dehpuxNsAomY?=
 =?us-ascii?Q?Zhh3zfDPwQc4CHxhmUGkkKhGphInBgoWbc1tQXjgpuOWJL45y9UIgTXqXgG1?=
 =?us-ascii?Q?nKa7mF/omts35YbvqIRCP9JaRh3EiX/+1gq/b/uT1xtK7dj8t5epBuQHb24m?=
 =?us-ascii?Q?/SvCSWpoGbvLmHSiPiWw+9tSHdzotc8C3ME6YE1FQwm7szO4baM6BaYeDMri?=
 =?us-ascii?Q?yLwDifTqOgeJjltVWwn9e6Nvva9Yx8cPMzlzkWTClSknq+8Jp/0kuMHvbQMu?=
 =?us-ascii?Q?wPF84Ij0C0uWN2fm384Rp5xTEbCXDogIZ7bOMrH1WmdILu2xC7zA3Ys10egz?=
 =?us-ascii?Q?ptqoYZF5GoY0PPfHUotoxy+08ufXPnvXtVYMbzlObS4tY2W3zWN7RxH5VijS?=
 =?us-ascii?Q?M3Kz/BzC985+ajVxFi86RHPb1K2q2v+jQBeh9qS9A2DVnchJ9VK/MmRWtXSk?=
 =?us-ascii?Q?4bROzc7xAHRDFjOSFYtj3nrQ3dwMsx//yY6G9S0xSebc3b+Y26Y3VR5ngeKT?=
 =?us-ascii?Q?YWFWngqQ7pv0IMwAuHiZxcrY54uDf/7syg4ttxUy0I2muukBSR3n4CXp6gKE?=
 =?us-ascii?Q?n6/ntiJjjqc6VDz7OqthpYxMZesjZpuhMHWibz9ckV5HUv5s+7a5//rrUJR7?=
 =?us-ascii?Q?yPSaOm9c8vNQR+Ezw/vW/4z97O31I9DfggiyNFgKv/IMqSF5gzmdkk13VDtc?=
 =?us-ascii?Q?4b4dgBW5D/Vj/gs6sbrcvJtJ7HQzbzYW/8aohlv3sWq1oRT51idFSykDlYH4?=
 =?us-ascii?Q?eDxS0KBmGM9lxODOBE2FSvkqeeDFJBAOHW9L27oa706wNdCOjjxw4zya9gJs?=
 =?us-ascii?Q?thTkAwe0wojBf+Di7Ok=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d70008-ae10-40ee-a5f6-08dd07df4b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 14:42:58.0176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWMo1NbOxyfsPQKk6bk3sE5peZZK9jeNK2VvgVsgk4hv6ezr7kfhiK5oZRP2v9F2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021

> -----Original Message-----
> From: Suraj Gupta <suraj.gupta2@amd.com>
> Sent: Monday, November 18, 2024 1:48 PM
> To: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> sean.anderson@linux.dev; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; horms@kernel.org
> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> <harini.katakam@amd.com>
> Subject: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
>=20
> Add AXI 2.5G MAC support, which is an incremental speed upgrade
> of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property
> is used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> If max-speed property is missing, 1G is assumed to support backward
> compatibility.
>=20
> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  4 +++-
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 24 +++++++++++++++----
>  2 files changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index d64b8abcf018..ebad1c147aa2 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -274,7 +274,7 @@
>  #define XAE_EMMC_RX16BIT	0x01000000 /* 16 bit Rx client enable */
>  #define XAE_EMMC_LINKSPD_10	0x00000000 /* Link Speed mask for 10 Mbit */
>  #define XAE_EMMC_LINKSPD_100	0x40000000 /* Link Speed mask for
> 100 Mbit */
> -#define XAE_EMMC_LINKSPD_1000	0x80000000 /* Link Speed mask for
> 1000 Mbit */
> +#define XAE_EMMC_LINKSPD_1000_2500	0x80000000 /* Link Speed
> mask for 1000 or 2500 Mbit */
>=20
>  /* Bit masks for Axi Ethernet PHYC register */
>  #define XAE_PHYC_SGMIILINKSPEED_MASK	0xC0000000 /* SGMII link
> speed mask*/
> @@ -542,6 +542,7 @@ struct skbuf_dma_descriptor {
>   * @tx_ring_tail: TX skb ring buffer tail index.
>   * @rx_ring_head: RX skb ring buffer head index.
>   * @rx_ring_tail: RX skb ring buffer tail index.
> + * @max_speed: Maximum possible MAC speed.
>   */
>  struct axienet_local {
>  	struct net_device *ndev;
> @@ -620,6 +621,7 @@ struct axienet_local {
>  	int tx_ring_tail;
>  	int rx_ring_head;
>  	int rx_ring_tail;
> +	u32 max_speed;
>  };
>=20
>  /**
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 273ec5f70005..52a3703bd604 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2388,6 +2388,7 @@ static struct phylink_pcs *axienet_mac_select_pcs(s=
truct
> phylink_config *config,
>  	struct axienet_local *lp =3D netdev_priv(ndev);
>=20
>  	if (interface =3D=3D PHY_INTERFACE_MODE_1000BASEX ||
> +	    interface =3D=3D PHY_INTERFACE_MODE_2500BASEX ||
>  	    interface =3D=3D  PHY_INTERFACE_MODE_SGMII)
>  		return &lp->pcs;
>=20
> @@ -2421,8 +2422,9 @@ static void axienet_mac_link_up(struct phylink_conf=
ig
> *config,
>  	emmc_reg &=3D ~XAE_EMMC_LINKSPEED_MASK;
>=20
>  	switch (speed) {
> +	case SPEED_2500:
>  	case SPEED_1000:
> -		emmc_reg |=3D XAE_EMMC_LINKSPD_1000;
> +		emmc_reg |=3D XAE_EMMC_LINKSPD_1000_2500;
>  		break;
>  	case SPEED_100:
>  		emmc_reg |=3D XAE_EMMC_LINKSPD_100;
> @@ -2432,7 +2434,7 @@ static void axienet_mac_link_up(struct phylink_conf=
ig
> *config,
>  		break;
>  	default:
>  		dev_err(&ndev->dev,
> -			"Speed other than 10, 100 or 1Gbps is not supported\n");
> +			"Speed other than 10, 100, 1Gbps or 2.5Gbps is not
> supported\n");
>  		break;
>  	}
>=20
> @@ -2681,6 +2683,12 @@ static int axienet_probe(struct platform_device *p=
dev)
>  	lp->switch_x_sgmii =3D of_property_read_bool(pdev->dev.of_node,
>  						   "xlnx,switch-x-sgmii");
>=20
> +	ret =3D of_property_read_u32(pdev->dev.of_node, "max-speed", &lp-
> >max_speed);
> +	if (ret) {
> +		lp->max_speed =3D SPEED_1000;
> +		netdev_warn(ndev, "Please upgrade your device tree to use max-
> speed\n");
> +	}
> +
>  	/* Start with the proprietary, and broken phy_type */
>  	ret =3D of_property_read_u32(pdev->dev.of_node, "xlnx,phy-type", &value=
);
>  	if (!ret) {
> @@ -2854,7 +2862,8 @@ static int axienet_probe(struct platform_device *pd=
ev)
>  			 "error registering MDIO bus: %d\n", ret);
>=20
>  	if (lp->phy_mode =3D=3D PHY_INTERFACE_MODE_SGMII ||
> -	    lp->phy_mode =3D=3D PHY_INTERFACE_MODE_1000BASEX) {
> +	    lp->phy_mode =3D=3D PHY_INTERFACE_MODE_1000BASEX ||
> +	    lp->phy_mode =3D=3D PHY_INTERFACE_MODE_2500BASEX) {
>  		np =3D of_parse_phandle(pdev->dev.of_node, "pcs-handle", 0);
>  		if (!np) {
>  			/* Deprecated: Always use "pcs-handle" for pcs_phy.
> @@ -2882,8 +2891,13 @@ static int axienet_probe(struct platform_device *p=
dev)
>=20
>  	lp->phylink_config.dev =3D &ndev->dev;
>  	lp->phylink_config.type =3D PHYLINK_NETDEV;
> -	lp->phylink_config.mac_capabilities =3D MAC_SYM_PAUSE |
> MAC_ASYM_PAUSE |
> -		MAC_10FD | MAC_100FD | MAC_1000FD;
> +	lp->phylink_config.mac_capabilities =3D MAC_SYM_PAUSE |
> MAC_ASYM_PAUSE;
> +
> +	/* Set MAC capabilities based on MAC type */
> +	if (lp->max_speed =3D=3D SPEED_1000)
> +		lp->phylink_config.mac_capabilities |=3D MAC_10FD | MAC_100FD |
> MAC_1000FD;
> +	else
> +		lp->phylink_config.mac_capabilities |=3D MAC_2500FD;
>=20
>  	__set_bit(lp->phy_mode, lp->phylink_config.supported_interfaces);
>  	if (lp->switch_x_sgmii) {
> --
> 2.25.1


