Return-Path: <netdev+bounces-120312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2F9958E6F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C06F1C20C9B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 19:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A653C1547E3;
	Tue, 20 Aug 2024 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XZz76eNt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8F7BB14;
	Tue, 20 Aug 2024 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180699; cv=fail; b=MZDtxEXcDeG1jEw8zAD29+YWzTcZ6Yo+QPEl60EiqWirM5KpySHXoUNDf+NfHYz1WiqHgySNfRWJKe7BjFSz1Oj7X0iyAMNmmWGAUEOt3KT2BX9SQTk0Pxw+KBC7GLaYimWmqXVPRYC6Ge9GT0cU4Ih3bPJp9a+UsMVbjJpiiNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180699; c=relaxed/simple;
	bh=iydtB84MYt7KqWjbmPkvc3tUc6kwyMTWqln/ErEfXjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qFzF3aHBXuWyhwJK3UcwOtJRtYg8G2o8HMJGFjU4j5NywdnEklGRQEW66Yiwk34K2RYjjzggOXIeR6UjFS/7XqvlM1BWWCe0lLrMh2xIH8Q5RMRZ8QRBWLp0ep18ZPW4Wf1lskgg+ZMqNm3GU+vuHK6x9AmckLfSBLVzXH7b7LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XZz76eNt; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvHHcsEhSfuw3V+aoXVJQFWjHgbisOrjsBwHb4WUMWVyP1dY+5nYcmXrf7Nimtgi7Tir+EBUiUi1hSjpmA3jbragg4kp4/6n7N80ifOAd/iMkSKHSgXVD5FCuP29H9UZxZ3Te1m5VVzgJf6ljPa1hiEdAHTxctkTuk+dGVmuqcWhqDOZQEesWPm4kchxeYOU+vhMgkc3wuXUsy0ikFqzuMp+OVPyCowCBnyUJZ4ReENGCf9lFtroUhptVsOdpvgpJ8PY25sH9cNfnm31v+TKJOfFi4fEeZ5qVmOQ94ybDR5avKor76OrPx+9EuY8P9Sb2eBu3AJWCWfNuWbzW3bRBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdhNf3YF35gTrrHPDzTUD5MiZogMgbH/A5Fkv2/uE28=;
 b=vzrmchffHzJxbUb3NlqMzNvKnrHFtdwYufB9a7F346M+KlTfxA5qQ8RBOlAiAoOjkf9gUokpR2LvUYLbLfVmZyyRR4L7ruVopP/Y1/HYQYEUsQocHpusBuw7FFOzt+fQDMxKfzeansx6UaujhRmUUZ/+4XBYo+8no8Gqs+p2ro/8Ig7Q8JSKIao5nrF0PDLf3/JKjzpPKWVtyt1DkwUKkS2UuZWG/zFaabnCFWro3euOc7dfmoBaV2rD4M7rmB9J4vAn8kB8BTfuHDe7k01vPqM4fGqNYYRDjQYm7oUHhIZb90ok0aVYRNdpzGmbeQXeSLaK+K6uuxKe0SmRjyNquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdhNf3YF35gTrrHPDzTUD5MiZogMgbH/A5Fkv2/uE28=;
 b=XZz76eNtQKtAZ/6h1HSG+XiO/lRizR7ympw0jTYpWWkBPDLyQ0BV20I4vRkhM6bKOKipR/JVDb6MfMO85wTjkrS/oWCNxliYtWjx/KGRq8Wblw5RdABE5MRL+nJ9tQKj69eDScvrWY/lPkBfwegoFPS9yxQ3oc2SzndrG2oh2wo=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 19:04:51 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 19:04:51 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "David
 S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Simon Horman
	<horms@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Katakam, Harini"
	<harini.katakam@amd.com>
Subject: RE: [PATCH net-next v4 2/2] net: xilinx: axienet: Add statistics
 support
Thread-Topic: [PATCH net-next v4 2/2] net: xilinx: axienet: Add statistics
 support
Thread-Index: AQHa8yn3BkdSiRdrXUS4shyHP5OItrIwf9aw
Date: Tue, 20 Aug 2024 19:04:51 +0000
Message-ID:
 <MN0PR12MB5953C46BA150B0382F222534B78D2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240820175343.760389-1-sean.anderson@linux.dev>
 <20240820175343.760389-3-sean.anderson@linux.dev>
In-Reply-To: <20240820175343.760389-3-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB6417:EE_
x-ms-office365-filtering-correlation-id: 785779ae-7520-4e1f-cf7f-08dcc14af854
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VTLpFCmoyLqynv6gN8f3hFv13tC4X8D8b73KoYsvmSgTUF/7iUo8SaizbQzC?=
 =?us-ascii?Q?fjfsx8OwGOCXoHPMIDrvNUXJ91auvVQgWy6qIBe4kIcos38Jlr1m+NBHOmgB?=
 =?us-ascii?Q?Xr9dA2iB2wSMZD3WatNC+BBG5pT29rV9ACN+5XdNao+W8/s3nl1XQHq7oO4o?=
 =?us-ascii?Q?H+nHkoX4cYOLxIzKLJVLO7nd8Q7RoZlYdQdivu39OCo5ZAPD/rCX9rJbaNL9?=
 =?us-ascii?Q?CTWCojehZ5m4vgg5JG7vNRLDSMawouQIJizov//0+hUWz5GySfAslHA0o0T4?=
 =?us-ascii?Q?lktek2C+q5RIFmpMZvGrUYEqCOESLjm/6Uo7H67z8QEB5AtM9DtsYzaf4/Ww?=
 =?us-ascii?Q?/i+oRh2rNz/6oTgwxSjtalUHviSZqER0Cy4Op+Es9Zp9Jjl6bOjriEpk8WeE?=
 =?us-ascii?Q?fIaTNJPGSzdGl1h4HnSojsDFXwoUgWLPD8J1yCUdCRZO64G5vZMT25JTY8lM?=
 =?us-ascii?Q?p3lDURpHi8SKoKo2tsm6RBvCv9lTEKxLiMGN23aAKko5jrCKnYMr43AFyfLP?=
 =?us-ascii?Q?6GIItYnC9y+53UrS4DYSrdmQX+saYFicoSBh0/JElZhe+Y0QwVuMaLbCRATp?=
 =?us-ascii?Q?0rPFExi09JQvk5N2+FR2Nsti49GrKxlAPMpP2kgweWnRqA3aDFPGjxq0HASl?=
 =?us-ascii?Q?oZ0nSnn6tVgRZyFxhpbisEsZ0WWlF5KQ3l95/F6G8yuEn6OBv+NMzysHK9/K?=
 =?us-ascii?Q?OduvMPNHZhRwqCOtZQ36rd8QkObYheiiFnioyuvXwnqyt6ERbGgfBPC3sdAL?=
 =?us-ascii?Q?993REW8EpeZ4ahHzpE7UszvSaE5xceuCux0UXHZ05bn8Kk8sbPE6Sg/4W2UF?=
 =?us-ascii?Q?jaI+ECaT6rWAmVt9hX6MvX0uPyUvqa5RhAeJw/FW1QebbB4pcUopBaLJRNBA?=
 =?us-ascii?Q?Nx8FV7UlsHsgEmSDNO5kZHbDwAcTAFVgrMn+YQqP90aLf4Zp/YX2wMQrr1oR?=
 =?us-ascii?Q?8e3JbaH3gDS/tGX/DAdNqaIizeWqIlhZqVn3z+1sFcDumjmswNsiXm1aI/b/?=
 =?us-ascii?Q?VyubA40OSdRwI4+xyUyyHtQgBSB6VxG/vqhHtE0vIPmvHJshRboEZsi26d/M?=
 =?us-ascii?Q?r8RgTKsANkPqUpoIVTJYitGvcgCewf13zlnDWN0+qf+7tCk7tXZB6IXJyoet?=
 =?us-ascii?Q?dbC2HlV3/oA/hxXRUautMgq2cBq+qAGL2uMcHKLHWGEhVmmTC45WmepRaOBb?=
 =?us-ascii?Q?fBLyAnApbAEcVDYuA/Bn2E8IEpo/kK3mQL7g9/4FNGYCzMUIqY2grQ0ty0aT?=
 =?us-ascii?Q?K8NSB9GLX23FFoY2MAg8yKq2DwXoSDIsUta1v4Do9/NKceJfzHe+MC/ybB0X?=
 =?us-ascii?Q?qzIROSOLA99pjEn/Q7wvO6KhtrcX4faw4y+F6QGPxSf0eKHmADvDiG01E/n5?=
 =?us-ascii?Q?XQhCGv6Vqcq3yMiwipT3061PJ3Kz4VIvYEJM1qMrxrPdPkQRrA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x8BNHueAaW8E6ea8vemCGXp5noho5HP4IWXhR1vZpdRlXYfsRdSIkkc5gBah?=
 =?us-ascii?Q?AZUH9J/Rejbg01DEkuT+1juZ5WuhWSDdD7HVwicPBB3HI99HN3aQF+rUlza2?=
 =?us-ascii?Q?A3VFHlLG5rvWNvOGU0B26f5xg6E28/gV+1rbMfVrP+IQGbkQ2mSeo3HgnAEb?=
 =?us-ascii?Q?dOnrawhKO8C3dY36/aeZr0S9vC7ZBhD3pg2M8+HYSbfh11XW9E+m+oNCRPKW?=
 =?us-ascii?Q?5+y08e1UIDBLKv7zhkK+WbsN4y5Wwdrl+it6nrrjGluht+S+60o9n7Qyclvk?=
 =?us-ascii?Q?A3VgZzPg0+QdrU9q10xNtRY1bQ1rEu7Aahf2Z+yizXHel/s/XuhiD3umsKpm?=
 =?us-ascii?Q?qZbX8LMGvSUr4vRyU+dXRbJ0OUl2MhAHr+sTvAZrrm2/NRB03gbkY+Fs+xee?=
 =?us-ascii?Q?tU0Y0omE3z7pZpwYi2APGRbcUGdTAKt7PFbvnE9ylXG2aEZ5GDxeBv9kPxlJ?=
 =?us-ascii?Q?LMP/cq+JRb7RO05nw7lBVP5ubo+Zk1Gn1E3OuHxoBflVzP1UR929iD4IvK6c?=
 =?us-ascii?Q?0si/lUBzIwQZJk1iKv25O4PcVbdZ07fVEwwFye/SlRIohqIegtXtD6nmhu0d?=
 =?us-ascii?Q?DTtzSeEGrn+lKp82XjfBOwizS7m/Wya7JUTHVvqB+iIJUVoiAwNy30uRFPxB?=
 =?us-ascii?Q?dzao9zCU29ymJZoaUpv37iC18BgT//nZoDHFfWk2+Q1wNR5lmkOXHqQhhzZv?=
 =?us-ascii?Q?aDHAwkwXBzSY7yu0/DcihrGxABwFGK/eOsiN1iWetO88Gy4Vz9mprm8kGa1p?=
 =?us-ascii?Q?m98oHxNPK1zYNb8xyOUxw0A5A53Pr3SI9CSHAl/F6clolmfBXlan3PnEgPzy?=
 =?us-ascii?Q?UfVOfCvcDChn6oFLJmVe15hv930PCOM+ImPC/XqmfmL5n9xtzMP3Kh3B8aBQ?=
 =?us-ascii?Q?QB8+JMsPcOT27GFWpSh3IEjA4ozqqtCthpSGUTJ2sJ4P0IUvD9DxFcAxOr6b?=
 =?us-ascii?Q?5rEKuvW+N6xvASmQASzMzryEArlsLq+Uy/ayHgjh556Ll/AE0+8kapyhK2R3?=
 =?us-ascii?Q?V7SOkpvpTG5ZX150+ZWQz+lZvT0tGeHYlYhEHGF+HJzzwqVB+Crb6qR5FZ8f?=
 =?us-ascii?Q?DOE62pyPF7C+fNZl3zTRKIZ2PvuXJIK4M1cjubAD6IesWfjnzfITCCKDyvPM?=
 =?us-ascii?Q?zEm5uMWCCVzaR+DzhUDqSZLM7oP/CWwbtH9gRtki7nXD3F/HiJ75vZ92vDIw?=
 =?us-ascii?Q?tbXxvYEHyxRgoiQF3nQLHdLcAXvr6Rn87QUEMB1R44uhkRHYLekch+MQWEoF?=
 =?us-ascii?Q?4ozBwzVE0pxrVTU0kmT5OdgWPOtLeMqH5TupAhlfmEkUVwmCr5nWq32JjjXD?=
 =?us-ascii?Q?5c6zfpXenPViKoy7mxuD+Luazff/QiCkYt2u86PCXnpGYeZrcE8rXRWIFdMV?=
 =?us-ascii?Q?t8ttVS5txVJoq03EHebVZ54Vee5lrACXe9B3pVERnxJiWjgmKMuK/2emYnt7?=
 =?us-ascii?Q?s8zb6zLdxVmSHhRxfz8nFJ/pmYD5zOUnzDI7qpFOfeDzOwZ8Q1P4N4Sumdnq?=
 =?us-ascii?Q?kip/3siwSBw4QK/MDQj65NEbj+6fucKl5693GTZPT7TRQi3Pee0DCkFZ3v6c?=
 =?us-ascii?Q?m6ktS0X2GrFaZI4m0aQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 785779ae-7520-4e1f-cf7f-08dcc14af854
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 19:04:51.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +DoSuuCAZk893YgFaykZGnxKnYKHAC2QDpx64N1LplPMhb9yQqER4jFPY5r3AXdj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Tuesday, August 20, 2024 11:24 PM
> To: Andrew Lunn <andrew@lunn.ch>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; netdev@vger.kernel.org
> Cc: Simek, Michal <michal.simek@amd.com>; linux-kernel@vger.kernel.org;
> Russell King <linux@armlinux.org.uk>; David S . Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Eric Dumazet <edumazet@google.com>; Simon
> Horman <horms@kernel.org>; linux-arm-kernel@lists.infradead.org; Sean
> Anderson <sean.anderson@linux.dev>
> Subject: [PATCH net-next v4 2/2] net: xilinx: axienet: Add statistics sup=
port
>=20
> Add support for reading the statistics counters, if they are enabled.
> The counters may be 64-bit, but we can't detect this statically as
> there's no ability bit for it and the counters are read-only. Therefore,
> we assume the counters are 32-bits by default. To ensure we don't miss

Any reason why we can't have DT property to detect if stats counter
are configured as 32-bit /64bit? The IP export CONFIG.Statistics_Width
and device tree generator can read this IP block property and populate=20
stats width property.

> an overflow, we read all counters at 13-second intervals. This should be
> often enough to ensure the bytes counters don't wrap at 2.5 Gbit/s.
>=20
> Another complication is that the counters may be reset when the device
> is reset (depending on configuration). To ensure the counters persist
> across link up/down (including suspend/resume), we maintain our own
> versions along with the last counter value we saw. Because we might wait

Is that a standard convention to retain/persist counter values across=20
link up/down?

> up to 100 ms for the reset to complete, we use a mutex to protect
> writing hw_stats. We can't sleep in ndo_get_stats64, so we use a seqlock
> to protect readers.
>=20
> We don't bother disabling the refresh work when we detect 64-bit
> counters. This is because the reset issue requires us to read
> hw_stat_base and reset_in_progress anyway, which would still require the
> seqcount. And I don't think skipping the task is worth the extra
> bookkeeping.
>=20
> We can't use the byte counters for either get_stats64 or
> get_eth_mac_stats. This is because the byte counters include everything
> in the frame (destination address to FCS, inclusive). But
> rtnl_link_stats64 wants bytes excluding the FCS, and
> ethtool_eth_mac_stats wants to exclude the L2 overhead (addresses and
> length/type). It might be possible to calculate the byte values Linux
> expects based on the frame counters, but I think it is simpler to use
> the existing software counters.
>=20
> get_ethtool_stats is implemented for nonstandard statistics. This
> includes the aforementioned byte counters, VLAN and PFC frame
> counters, and user-defined (e.g. with custom RTL) counters.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>=20
> Changes in v4:
> - Reduce hw_last_counter to u32 to ensure we use (wrapping) 32-bit
>   arithmetic.
> - Implement get_ethtool_stats for nonstandard statistics
>=20
> Changes in v3:
> - Use explicit mutex_lock/unlock instead of guard() in
>   __axienet_device_reset to make it clear that we need to hold
>   lp->stats_lock for the whole function.
>=20
> Changes in v2:
> - Switch to a seqlock-based implementation to allow fresher updates
>   (rather than always using stale counter values from the previous
>   refresh).
> - Take stats_lock unconditionally in __axienet_device_reset
> - Fix documentation mismatch
>=20
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  85 +++++
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 325 +++++++++++++++++-
>  2 files changed, 407 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index ea4103a635f9..8165f5f271ff 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -156,6 +156,7 @@
>  #define XAE_TPID0_OFFSET	0x00000028 /* VLAN TPID0 register */
>  #define XAE_TPID1_OFFSET	0x0000002C /* VLAN TPID1 register */
>  #define XAE_PPST_OFFSET		0x00000030 /* PCS PMA Soft Temac
> Status Reg */
> +#define XAE_STATS_OFFSET	0x00000200 /* Statistics counters */
>  #define XAE_RCW0_OFFSET		0x00000400 /* Rx Configuration
> Word 0 */
>  #define XAE_RCW1_OFFSET		0x00000404 /* Rx Configuration
> Word 1 */
>  #define XAE_TC_OFFSET		0x00000408 /* Tx Configuration */
> @@ -163,6 +164,7 @@
>  #define XAE_EMMC_OFFSET		0x00000410 /* MAC speed
> configuration */
>  #define XAE_PHYC_OFFSET		0x00000414 /* RX Max Frame
> Configuration */
>  #define XAE_ID_OFFSET		0x000004F8 /* Identification register
> */
> +#define XAE_ABILITY_OFFSET	0x000004FC /* Ability Register offset */
>  #define XAE_MDIO_MC_OFFSET	0x00000500 /* MDIO Setup */
>  #define XAE_MDIO_MCR_OFFSET	0x00000504 /* MDIO Control */
>  #define XAE_MDIO_MWD_OFFSET	0x00000508 /* MDIO Write Data */
> @@ -283,6 +285,16 @@
>  #define XAE_PHYC_SGLINKSPD_100		0x40000000 /* SGMII link 100
> Mbit */
>  #define XAE_PHYC_SGLINKSPD_1000		0x80000000 /* SGMII link
> 1000 Mbit */
>=20
> +/* Bit masks for Axi Ethernet ability register */
> +#define XAE_ABILITY_PFC			BIT(16)
> +#define XAE_ABILITY_FRAME_FILTER	BIT(10)
> +#define XAE_ABILITY_HALF_DUPLEX		BIT(9)
> +#define XAE_ABILITY_STATS		BIT(8)
> +#define XAE_ABILITY_2_5G		BIT(3)
> +#define XAE_ABILITY_1G			BIT(2)
> +#define XAE_ABILITY_100M		BIT(1)
> +#define XAE_ABILITY_10M			BIT(0)
> +
>  /* Bit masks for Axi Ethernet MDIO interface MC register */
>  #define XAE_MDIO_MC_MDIOEN_MASK		0x00000040 /* MII
> management enable */
>  #define XAE_MDIO_MC_CLOCK_DIVIDE_MAX	0x3F	   /* Maximum MDIO
> divisor */
> @@ -331,6 +343,7 @@
>  #define XAE_FEATURE_FULL_RX_CSUM	BIT(2)
>  #define XAE_FEATURE_FULL_TX_CSUM	BIT(3)
>  #define XAE_FEATURE_DMA_64BIT		BIT(4)
> +#define XAE_FEATURE_STATS		BIT(5)
>=20
>  #define XAE_NO_CSUM_OFFLOAD		0
>=20
> @@ -344,6 +357,61 @@
>  #define XLNX_MII_STD_SELECT_REG		0x11
>  #define XLNX_MII_STD_SELECT_SGMII	BIT(0)
>=20
> +/* enum temac_stat - TEMAC statistics counters
> + *
> + * Index of statistics counters within the TEMAC. This must match the
> + * order/offset of hardware registers exactly.
> + */
> +enum temac_stat {
> +	STAT_RX_BYTES =3D 0,
> +	STAT_TX_BYTES,
> +	STAT_UNDERSIZE_FRAMES,
> +	STAT_FRAGMENT_FRAMES,
> +	STAT_RX_64_BYTE_FRAMES,
> +	STAT_RX_65_127_BYTE_FRAMES,
> +	STAT_RX_128_255_BYTE_FRAMES,
> +	STAT_RX_256_511_BYTE_FRAMES,
> +	STAT_RX_512_1023_BYTE_FRAMES,
> +	STAT_RX_1024_MAX_BYTE_FRAMES,
> +	STAT_RX_OVERSIZE_FRAMES,
> +	STAT_TX_64_BYTE_FRAMES,
> +	STAT_TX_65_127_BYTE_FRAMES,
> +	STAT_TX_128_255_BYTE_FRAMES,
> +	STAT_TX_256_511_BYTE_FRAMES,
> +	STAT_TX_512_1023_BYTE_FRAMES,
> +	STAT_TX_1024_MAX_BYTE_FRAMES,
> +	STAT_TX_OVERSIZE_FRAMES,
> +	STAT_RX_GOOD_FRAMES,
> +	STAT_RX_FCS_ERRORS,
> +	STAT_RX_BROADCAST_FRAMES,
> +	STAT_RX_MULTICAST_FRAMES,
> +	STAT_RX_CONTROL_FRAMES,
> +	STAT_RX_LENGTH_ERRORS,
> +	STAT_RX_VLAN_FRAMES,
> +	STAT_RX_PAUSE_FRAMES,
> +	STAT_RX_CONTROL_OPCODE_ERRORS,
> +	STAT_TX_GOOD_FRAMES,
> +	STAT_TX_BROADCAST_FRAMES,
> +	STAT_TX_MULTICAST_FRAMES,
> +	STAT_TX_UNDERRUN_ERRORS,
> +	STAT_TX_CONTROL_FRAMES,
> +	STAT_TX_VLAN_FRAMES,
> +	STAT_TX_PAUSE_FRAMES,
> +	STAT_TX_SINGLE_COLLISION_FRAMES,
> +	STAT_TX_MULTIPLE_COLLISION_FRAMES,
> +	STAT_TX_DEFERRED_FRAMES,
> +	STAT_TX_LATE_COLLISIONS,
> +	STAT_TX_EXCESS_COLLISIONS,
> +	STAT_TX_EXCESS_DEFERRAL,
> +	STAT_RX_ALIGNMENT_ERRORS,
> +	STAT_TX_PFC_FRAMES,
> +	STAT_RX_PFC_FRAMES,
> +	STAT_USER_DEFINED0,
> +	STAT_USER_DEFINED1,
> +	STAT_USER_DEFINED2,
> +	STAT_COUNT,
> +};
> +
>  /**
>   * struct axidma_bd - Axi Dma buffer descriptor layout
>   * @next:         MM2S/S2MM Next Descriptor Pointer
> @@ -434,6 +502,16 @@ struct skbuf_dma_descriptor {
>   * @tx_packets: TX packet count for statistics
>   * @tx_bytes:	TX byte count for statistics
>   * @tx_stat_sync: Synchronization object for TX stats
> + * @hw_stat_base: Base offset for statistics counters. This may be nonze=
ro
> if
> + *                the statistics counteres were reset or wrapped around.
> + * @hw_last_counter: Last-seen value of each statistic counter
> + * @reset_in_progress: Set while we are performing a reset and statistic=
s
> + *                     counters may be invalid
> + * @hw_stats_seqcount: Sequence counter for @hw_stat_base,
> @hw_last_counter,
> + *                     and @reset_in_progress.
> + * @stats_lock: Lock for @hw_stats_seqcount
> + * @stats_work: Work for reading the hardware statistics counters often
> enough
> + *              to catch overflows.
>   * @dma_err_task: Work structure to process Axi DMA errors
>   * @tx_irq:	Axidma TX IRQ number
>   * @rx_irq:	Axidma RX IRQ number
> @@ -505,6 +583,13 @@ struct axienet_local {
>  	u64_stats_t tx_bytes;
>  	struct u64_stats_sync tx_stat_sync;
>=20
> +	u64 hw_stat_base[STAT_COUNT];
> +	u32 hw_last_counter[STAT_COUNT];
> +	seqcount_mutex_t hw_stats_seqcount;
> +	struct mutex stats_lock;
> +	struct delayed_work stats_work;
> +	bool reset_in_progress;
> +
>  	struct work_struct dma_err_task;
>=20
>  	int tx_irq;
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index b2d7c396e2e3..38f7b764fe66 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -519,11 +519,55 @@ static void axienet_setoptions(struct net_device
> *ndev, u32 options)
>  	lp->options |=3D options;
>  }
>=20
> +static u64 axienet_stat(struct axienet_local *lp, enum temac_stat stat)
> +{
> +	u32 counter;
> +
> +	if (lp->reset_in_progress)
> +		return lp->hw_stat_base[stat];
> +
> +	counter =3D axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
> +	return lp->hw_stat_base[stat] + (counter - lp-
> >hw_last_counter[stat]);
> +}
> +
> +static void axienet_stats_update(struct axienet_local *lp, bool reset)
> +{
> +	enum temac_stat stat;
> +
> +	write_seqcount_begin(&lp->hw_stats_seqcount);
> +	lp->reset_in_progress =3D reset;
> +	for (stat =3D 0; stat < STAT_COUNT; stat++) {
> +		u32 counter =3D axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
> +
> +		lp->hw_stat_base[stat] +=3D counter - lp-
> >hw_last_counter[stat];
> +		lp->hw_last_counter[stat] =3D counter;
> +	}
> +	write_seqcount_end(&lp->hw_stats_seqcount);
> +}
> +
> +static void axienet_refresh_stats(struct work_struct *work)
> +{
> +	struct axienet_local *lp =3D container_of(work, struct axienet_local,
> +						stats_work.work);
> +
> +	mutex_lock(&lp->stats_lock);
> +	axienet_stats_update(lp, false);
> +	mutex_unlock(&lp->stats_lock);
> +
> +	/* Just less than 2^32 bytes at 2.5 GBit/s */
> +	schedule_delayed_work(&lp->stats_work, 13 * HZ);
> +}
> +
>  static int __axienet_device_reset(struct axienet_local *lp)
>  {
>  	u32 value;
>  	int ret;
>=20
> +	/* Save statistics counters in case they will be reset */
> +	mutex_lock(&lp->stats_lock);
> +	if (lp->features & XAE_FEATURE_STATS)
> +		axienet_stats_update(lp, true);
> +
>  	/* Reset Axi DMA. This would reset Axi Ethernet core as well. The
> reset
>  	 * process of Axi DMA takes a while to complete as all pending
>  	 * commands/transfers will be flushed or completed during this
> @@ -538,7 +582,7 @@ static int __axienet_device_reset(struct axienet_loca=
l
> *lp)
>  				XAXIDMA_TX_CR_OFFSET);
>  	if (ret) {
>  		dev_err(lp->dev, "%s: DMA reset timeout!\n", __func__);
> -		return ret;
> +		goto out;
>  	}
>=20
>  	/* Wait for PhyRstCmplt bit to be set, indicating the PHY reset has
> finished */
> @@ -548,10 +592,29 @@ static int __axienet_device_reset(struct
> axienet_local *lp)
>  				XAE_IS_OFFSET);
>  	if (ret) {
>  		dev_err(lp->dev, "%s: timeout waiting for PhyRstCmplt\n",
> __func__);
> -		return ret;
> +		goto out;
>  	}
>=20
> -	return 0;
> +	/* Update statistics counters with new values */
> +	if (lp->features & XAE_FEATURE_STATS) {
> +		enum temac_stat stat;
> +
> +		write_seqcount_begin(&lp->hw_stats_seqcount);
> +		lp->reset_in_progress =3D false;
> +		for (stat =3D 0; stat < STAT_COUNT; stat++) {
> +			u32 counter =3D
> +				axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
> +
> +			lp->hw_stat_base[stat] +=3D
> +				lp->hw_last_counter[stat] - counter;
> +			lp->hw_last_counter[stat] =3D counter;
> +		}
> +		write_seqcount_end(&lp->hw_stats_seqcount);
> +	}
> +
> +out:
> +	mutex_unlock(&lp->stats_lock);
> +	return ret;
>  }
>=20
>  /**
> @@ -1530,6 +1593,9 @@ static int axienet_open(struct net_device *ndev)
>=20
>  	phylink_start(lp->phylink);
>=20
> +	/* Start the statistics refresh work */
> +	schedule_delayed_work(&lp->stats_work, 0);
> +
>  	if (lp->use_dmaengine) {
>  		/* Enable interrupts for Axi Ethernet core (if defined) */
>  		if (lp->eth_irq > 0) {
> @@ -1554,6 +1620,7 @@ static int axienet_open(struct net_device *ndev)
>  	if (lp->eth_irq > 0)
>  		free_irq(lp->eth_irq, ndev);
>  err_phy:
> +	cancel_delayed_work_sync(&lp->stats_work);
>  	phylink_stop(lp->phylink);
>  	phylink_disconnect_phy(lp->phylink);
>  	return ret;
> @@ -1579,6 +1646,8 @@ static int axienet_stop(struct net_device *ndev)
>  		napi_disable(&lp->napi_rx);
>  	}
>=20
> +	cancel_delayed_work_sync(&lp->stats_work);
> +
>  	phylink_stop(lp->phylink);
>  	phylink_disconnect_phy(lp->phylink);
>=20
> @@ -1692,6 +1761,35 @@ axienet_get_stats64(struct net_device *dev,
> struct rtnl_link_stats64 *stats)
>  		stats->tx_packets =3D u64_stats_read(&lp->tx_packets);
>  		stats->tx_bytes =3D u64_stats_read(&lp->tx_bytes);
>  	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
> +
> +	if (!(lp->features & XAE_FEATURE_STATS))
> +		return;
> +
> +	do {
> +		start =3D read_seqcount_begin(&lp->hw_stats_seqcount);
> +		stats->rx_length_errors =3D
> +			axienet_stat(lp, STAT_RX_LENGTH_ERRORS);
> +		stats->rx_crc_errors =3D axienet_stat(lp,
> STAT_RX_FCS_ERRORS);
> +		stats->rx_frame_errors =3D
> +			axienet_stat(lp, STAT_RX_ALIGNMENT_ERRORS);
> +		stats->rx_errors =3D axienet_stat(lp,
> STAT_UNDERSIZE_FRAMES) +
> +				   axienet_stat(lp, STAT_FRAGMENT_FRAMES)
> +
> +				   stats->rx_length_errors +
> +				   stats->rx_crc_errors +
> +				   stats->rx_frame_errors;
> +		stats->multicast =3D axienet_stat(lp,
> STAT_RX_MULTICAST_FRAMES);
> +
> +		stats->tx_aborted_errors =3D
> +			axienet_stat(lp, STAT_TX_EXCESS_COLLISIONS);
> +		stats->tx_fifo_errors =3D
> +			axienet_stat(lp, STAT_TX_UNDERRUN_ERRORS);
> +		stats->tx_window_errors =3D
> +			axienet_stat(lp, STAT_TX_LATE_COLLISIONS);
> +		stats->tx_errors =3D axienet_stat(lp,
> STAT_TX_EXCESS_DEFERRAL) +
> +				   stats->tx_aborted_errors +
> +				   stats->tx_fifo_errors +
> +				   stats->tx_window_errors;
> +	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
>  }
>=20
>  static const struct net_device_ops axienet_netdev_ops =3D {
> @@ -1984,6 +2082,213 @@ static int axienet_ethtools_nway_reset(struct
> net_device *dev)
>  	return phylink_ethtool_nway_reset(lp->phylink);
>  }
>=20
> +static void axienet_ethtools_get_ethtool_stats(struct net_device *dev,
> +					       struct ethtool_stats *stats,
> +					       u64 *data)
> +{
> +	struct axienet_local *lp =3D netdev_priv(dev);
> +	unsigned int start;
> +
> +	do {
> +		start =3D read_seqcount_begin(&lp->hw_stats_seqcount);
> +		data[0] =3D axienet_stat(lp, STAT_RX_BYTES);
> +		data[1] =3D axienet_stat(lp, STAT_TX_BYTES);
> +		data[2] =3D axienet_stat(lp, STAT_RX_VLAN_FRAMES);
> +		data[3] =3D axienet_stat(lp, STAT_TX_VLAN_FRAMES);
> +		data[6] =3D axienet_stat(lp, STAT_TX_PFC_FRAMES);
> +		data[7] =3D axienet_stat(lp, STAT_RX_PFC_FRAMES);
> +		data[8] =3D axienet_stat(lp, STAT_USER_DEFINED0);
> +		data[9] =3D axienet_stat(lp, STAT_USER_DEFINED1);
> +		data[10] =3D axienet_stat(lp, STAT_USER_DEFINED2);
> +	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
> +}
> +
> +static const char axienet_ethtool_stats_strings[][ETH_GSTRING_LEN] =3D {
> +	"Received bytes",
> +	"Transmitted bytes",
> +	"RX Good VLAN Tagged Frames",
> +	"TX Good VLAN Tagged Frames",
> +	"TX Good PFC Frames",
> +	"RX Good PFC Frames",
> +	"User Defined Counter 0",
> +	"User Defined Counter 1",
> +	"User Defined Counter 2",
> +};
> +
> +static void axienet_ethtools_get_strings(struct net_device *dev, u32
> stringset, u8 *data)
> +{
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		memcpy(data, axienet_ethtool_stats_strings,
> +		       sizeof(axienet_ethtool_stats_strings));
> +		break;
> +	}
> +}
> +
> +static int axienet_ethtools_get_sset_count(struct net_device *dev, int s=
set)
> +{
> +	struct axienet_local *lp =3D netdev_priv(dev);
> +
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		if (lp->features & XAE_FEATURE_STATS)
> +			return ARRAY_SIZE(axienet_ethtool_stats_strings);
> +		fallthrough;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static void
> +axienet_ethtools_get_pause_stats(struct net_device *dev,
> +				 struct ethtool_pause_stats *pause_stats)
> +{
> +	struct axienet_local *lp =3D netdev_priv(dev);
> +	unsigned int start;
> +
> +	if (!(lp->features & XAE_FEATURE_STATS))
> +		return;
> +
> +	do {
> +		start =3D read_seqcount_begin(&lp->hw_stats_seqcount);
> +		pause_stats->tx_pause_frames =3D
> +			axienet_stat(lp, STAT_TX_PAUSE_FRAMES);
> +		pause_stats->rx_pause_frames =3D
> +			axienet_stat(lp, STAT_RX_PAUSE_FRAMES);
> +	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
> +}
> +
> +static void
> +axienet_ethtool_get_eth_mac_stats(struct net_device *dev,
> +				  struct ethtool_eth_mac_stats *mac_stats)
> +{
> +	struct axienet_local *lp =3D netdev_priv(dev);
> +	unsigned int start;
> +
> +	if (!(lp->features & XAE_FEATURE_STATS))
> +		return;
> +
> +	do {
> +		start =3D read_seqcount_begin(&lp->hw_stats_seqcount);
> +		mac_stats->FramesTransmittedOK =3D
> +			axienet_stat(lp, STAT_TX_GOOD_FRAMES);
> +		mac_stats->SingleCollisionFrames =3D
> +			axienet_stat(lp,
> STAT_TX_SINGLE_COLLISION_FRAMES);
> +		mac_stats->MultipleCollisionFrames =3D
> +			axienet_stat(lp,
> STAT_TX_MULTIPLE_COLLISION_FRAMES);
> +		mac_stats->FramesReceivedOK =3D
> +			axienet_stat(lp, STAT_RX_GOOD_FRAMES);
> +		mac_stats->FrameCheckSequenceErrors =3D
> +			axienet_stat(lp, STAT_RX_FCS_ERRORS);
> +		mac_stats->AlignmentErrors =3D
> +			axienet_stat(lp, STAT_RX_ALIGNMENT_ERRORS);
> +		mac_stats->FramesWithDeferredXmissions =3D
> +			axienet_stat(lp, STAT_TX_DEFERRED_FRAMES);
> +		mac_stats->LateCollisions =3D
> +			axienet_stat(lp, STAT_TX_LATE_COLLISIONS);
> +		mac_stats->FramesAbortedDueToXSColls =3D
> +			axienet_stat(lp, STAT_TX_EXCESS_COLLISIONS);
> +		mac_stats->MulticastFramesXmittedOK =3D
> +			axienet_stat(lp, STAT_TX_MULTICAST_FRAMES);
> +		mac_stats->BroadcastFramesXmittedOK =3D
> +			axienet_stat(lp, STAT_TX_BROADCAST_FRAMES);
> +		mac_stats->FramesWithExcessiveDeferral =3D
> +			axienet_stat(lp, STAT_TX_EXCESS_DEFERRAL);
> +		mac_stats->MulticastFramesReceivedOK =3D
> +			axienet_stat(lp, STAT_RX_MULTICAST_FRAMES);
> +		mac_stats->BroadcastFramesReceivedOK =3D
> +			axienet_stat(lp, STAT_RX_BROADCAST_FRAMES);
> +		mac_stats->InRangeLengthErrors =3D
> +			axienet_stat(lp, STAT_RX_LENGTH_ERRORS);
> +	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
> +}
> +
> +static void
> +axienet_ethtool_get_eth_ctrl_stats(struct net_device *dev,
> +				   struct ethtool_eth_ctrl_stats *ctrl_stats)
> +{
> +	struct axienet_local *lp =3D netdev_priv(dev);
> +	unsigned int start;
> +
> +	if (!(lp->features & XAE_FEATURE_STATS))
> +		return;
> +
> +	do {
> +		start =3D read_seqcount_begin(&lp->hw_stats_seqcount);
> +		ctrl_stats->MACControlFramesTransmitted =3D
> +			axienet_stat(lp, STAT_TX_CONTROL_FRAMES);
> +		ctrl_stats->MACControlFramesReceived =3D
> +			axienet_stat(lp, STAT_RX_CONTROL_FRAMES);
> +		ctrl_stats->UnsupportedOpcodesReceived =3D
> +			axienet_stat(lp,
> STAT_RX_CONTROL_OPCODE_ERRORS);
> +	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
> +}
> +
> +static const struct ethtool_rmon_hist_range axienet_rmon_ranges[] =3D {
> +	{   64,    64 },
> +	{   65,   127 },
> +	{  128,   255 },
> +	{  256,   511 },
> +	{  512,  1023 },
> +	{ 1024,  1518 },
> +	{ 1519, 16384 },
> +	{ },
> +};
> +
> +static void
> +axienet_ethtool_get_rmon_stats(struct net_device *dev,
> +			       struct ethtool_rmon_stats *rmon_stats,
> +			       const struct ethtool_rmon_hist_range **ranges)
> +{
> +	struct axienet_local *lp =3D netdev_priv(dev);
> +	unsigned int start;
> +
> +	if (!(lp->features & XAE_FEATURE_STATS))
> +		return;
> +
> +	do {
> +		start =3D read_seqcount_begin(&lp->hw_stats_seqcount);
> +		rmon_stats->undersize_pkts =3D
> +			axienet_stat(lp, STAT_UNDERSIZE_FRAMES);
> +		rmon_stats->oversize_pkts =3D
> +			axienet_stat(lp, STAT_RX_OVERSIZE_FRAMES);
> +		rmon_stats->fragments =3D
> +			axienet_stat(lp, STAT_FRAGMENT_FRAMES);
> +
> +		rmon_stats->hist[0] =3D
> +			axienet_stat(lp, STAT_RX_64_BYTE_FRAMES);
> +		rmon_stats->hist[1] =3D
> +			axienet_stat(lp, STAT_RX_65_127_BYTE_FRAMES);
> +		rmon_stats->hist[2] =3D
> +			axienet_stat(lp, STAT_RX_128_255_BYTE_FRAMES);
> +		rmon_stats->hist[3] =3D
> +			axienet_stat(lp, STAT_RX_256_511_BYTE_FRAMES);
> +		rmon_stats->hist[4] =3D
> +			axienet_stat(lp, STAT_RX_512_1023_BYTE_FRAMES);
> +		rmon_stats->hist[5] =3D
> +			axienet_stat(lp,
> STAT_RX_1024_MAX_BYTE_FRAMES);
> +		rmon_stats->hist[6] =3D
> +			rmon_stats->oversize_pkts;
> +
> +		rmon_stats->hist_tx[0] =3D
> +			axienet_stat(lp, STAT_TX_64_BYTE_FRAMES);
> +		rmon_stats->hist_tx[1] =3D
> +			axienet_stat(lp, STAT_TX_65_127_BYTE_FRAMES);
> +		rmon_stats->hist_tx[2] =3D
> +			axienet_stat(lp, STAT_TX_128_255_BYTE_FRAMES);
> +		rmon_stats->hist_tx[3] =3D
> +			axienet_stat(lp, STAT_TX_256_511_BYTE_FRAMES);
> +		rmon_stats->hist_tx[4] =3D
> +			axienet_stat(lp, STAT_TX_512_1023_BYTE_FRAMES);
> +		rmon_stats->hist_tx[5] =3D
> +			axienet_stat(lp, STAT_TX_1024_MAX_BYTE_FRAMES);
> +		rmon_stats->hist_tx[6] =3D
> +			axienet_stat(lp, STAT_TX_OVERSIZE_FRAMES);
> +	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
> +
> +	*ranges =3D axienet_rmon_ranges;
> +}
> +
>  static const struct ethtool_ops axienet_ethtool_ops =3D {
>  	.supported_coalesce_params =3D ETHTOOL_COALESCE_MAX_FRAMES
> |
>  				     ETHTOOL_COALESCE_USECS,
> @@ -2000,6 +2305,13 @@ static const struct ethtool_ops
> axienet_ethtool_ops =3D {
>  	.get_link_ksettings =3D axienet_ethtools_get_link_ksettings,
>  	.set_link_ksettings =3D axienet_ethtools_set_link_ksettings,
>  	.nway_reset	=3D axienet_ethtools_nway_reset,
> +	.get_ethtool_stats =3D axienet_ethtools_get_ethtool_stats,
> +	.get_strings    =3D axienet_ethtools_get_strings,
> +	.get_sset_count =3D axienet_ethtools_get_sset_count,
> +	.get_pause_stats =3D axienet_ethtools_get_pause_stats,
> +	.get_eth_mac_stats =3D axienet_ethtool_get_eth_mac_stats,
> +	.get_eth_ctrl_stats =3D axienet_ethtool_get_eth_ctrl_stats,
> +	.get_rmon_stats =3D axienet_ethtool_get_rmon_stats,
>  };
>=20
>  static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pc=
s)
> @@ -2268,6 +2580,10 @@ static int axienet_probe(struct platform_device
> *pdev)
>  	u64_stats_init(&lp->rx_stat_sync);
>  	u64_stats_init(&lp->tx_stat_sync);
>=20
> +	mutex_init(&lp->stats_lock);
> +	seqcount_mutex_init(&lp->hw_stats_seqcount, &lp->stats_lock);
> +	INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
> +
>  	lp->axi_clk =3D devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
>  	if (!lp->axi_clk) {
>  		/* For backward compatibility, if named AXI clock is not
> present,
> @@ -2308,6 +2624,9 @@ static int axienet_probe(struct platform_device
> *pdev)
>  	/* Setup checksum offload, but default to off if not specified */
>  	lp->features =3D 0;
>=20
> +	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_STATS)
> +		lp->features |=3D XAE_FEATURE_STATS;
> +
>  	ret =3D of_property_read_u32(pdev->dev.of_node, "xlnx,txcsum",
> &value);
>  	if (!ret) {
>  		switch (value) {
> --
> 2.35.1.1320.gc452695387.dirty


