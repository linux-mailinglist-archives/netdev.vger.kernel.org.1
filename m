Return-Path: <netdev+bounces-122058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E895FBEA
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 23:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF42E1C225D2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC8019D08C;
	Mon, 26 Aug 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Sz6yE3ik"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80919CD0E;
	Mon, 26 Aug 2024 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708594; cv=fail; b=tw7sP3BUsTURRKgTHJeS0f04Vc/Wx59BH09bX9AUNwRtmiL/aoSKD6Xe9MIdFOY7Xui0ERVym8j3VFhWsjvAp7UT6WdkSzkYsRPR8dT0qml1ISC1eMsxg7iTV1O3oqrdjCYl+l8k5DB8GKE1gNTczoEx6ExRUGzHSv2A0LgSC8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708594; c=relaxed/simple;
	bh=bLdcWg8dAnEqQGUoPxhvyer43ZpempWjwe5yfq6JldU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NdXa4jvprz8NIdnA6JrMjn0NhXDPqanS7RxRXJX1d1pWKmc8+ofSXNqUhPpU/zCp20x+47DidoJi25mIQdoxnhsizXi/cJW1qpZmNiUrUipYBGsduch9j/mCHiZfU0CvrITCtIMPF54TWHljJYU3ww+4Asx6mVy4I5zRfiXIVyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Sz6yE3ik; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNJ8AK1YW104WSUM3ZeMyFJHXPQ3PRabUZM3N48JNV/spULw6PNPSPCvKjxl+QR92JwqdR4XfiKS5l0fi7BBT0uz+PuLw7hWJ2k+KHaHcIKIezupcQBEz1cnVOlO7oNoWiBG91JCyZoZKGLB0wr7AEAl7upOvdKIsPD0IqQd//tAn7x5vB5aPJVhGNlZjDi+ylxRdMgbW8LkIElG8rIiJBcTSOoN4jijHUTKpvtWmYmvSkcQAS5fkIsdn/PZ80SxqmIkWmfCfCa7EyzQU7YY6d5ViTj0J3AYlag6AsT7HdgYsibTpdUDMzNgkmTU/1UqWKC2whitSHrrcT7qkk9OAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeF6e7AYCuj/j5fL+fXx0cG+ULrj3dLYSUJYsouZ2FE=;
 b=M9G42sVVxCUcMgyTWX2TrFfSoO2BmM+KFFgTj4nSkx2iPir6Bb2AO++W25d0thPg+wsH9f+CwUAfH8AbpPDusTMceggbUtcvPWNrR08DHm7+K8X7CfJZZCuhCdh/3qtEGY/trOeFXXZ+hGOfEKQ3g5yoZoXfXuLL0kFSgahxLxD/0HLmiKmy9A+0ltlc2gW02OHK9riD4Pnk7EC+Io7da6PKtMn0i93VxwHBPmtsX4pJwhWtmXeiihabb3RlvHzHb7qDm3nmnvIE8z+qHantoF6JTbVQhi6JV7l1R4XpC9qBz2o085j4lCdP1OEg/IuAB4ZjyWf5tsuv9l+hYXLgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeF6e7AYCuj/j5fL+fXx0cG+ULrj3dLYSUJYsouZ2FE=;
 b=Sz6yE3ikt0Qv6AQG8BlUzrdLUX61yYdtsKV54snMib3N4hDMQXU4vAkVCglY1tvFRZWB62up01exEDdJJJydvruqxjj6MlXvhBlM/5wDFxjB5S6r6ru6kwcblTmvz7CdeURz/YjmnC9j6TqZt7ILZkxmaOpUz9xnjmZ/lNlQClgge3q9w9Vl+rgK7lSXO9dK0tsIpU/cenr11vWWXnh8CV2g1gmKSPqUbfpDMRycjsq7XvGT6oZjXZey4bfGQ190ny+3ry5dXnHGRxmzI6qfW1XTg44wI+tdwCtr36AiQKs//cjO5lbgmDgnKBmPjHVJOa0oR5IKPVlzBz8TSONRBQ==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Mon, 26 Aug
 2024 21:43:08 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:43:08 +0000
From: <Tristram.Ha@microchip.com>
To: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>
CC: <o.rempel@pengutronix.de>, <pieter.van.trappen@cern.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Topic: [PATCH net-next v6 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Index: AQHa+AAVpv/2224lAkiuDSJrmip8AQ==
Date: Mon, 26 Aug 2024 21:43:08 +0000
Message-ID:
 <BYAPR11MB35581A32F4EBB2D12BE26A38EC8B2@BYAPR11MB3558.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH7PR11MB7449:EE_
x-ms-office365-filtering-correlation-id: 39a30fc6-3974-41d8-26d3-08dcc6181339
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?z65K6dj5MrdnEltTCeAdM2d8rvxsv8NsMEddr3zuQYUb2o7uZSFXiAWrMc?=
 =?iso-8859-1?Q?SQnS3QcfmGZ4Y1lGBk8KJfw/24VQt4MCvY/0/ufZP9iQFcKqOtxVXuf92S?=
 =?iso-8859-1?Q?x6zo2S1i6yd0p0zp0ERUQH2vJeICDgQgctURIhg1VCgcU2IzVJcpcK3hfg?=
 =?iso-8859-1?Q?utSP8frqDFUqrbVj7kEYJ7FpZLgp89h7mWzGYpHgfHi4jn9mQd+STKqM01?=
 =?iso-8859-1?Q?YCBDqx9Ifk3niNj9jxExnGXv5PqFs7JgzS0MqanpzDfIYkpgz16DieZikX?=
 =?iso-8859-1?Q?ocN/640UqMyHRBWvr/gs/Eej0rzKGUNefWaZ2HGv12nB+Zp5q2/8B1AIrl?=
 =?iso-8859-1?Q?d/owYq5Cwo30ySy8dINP20YFZh86dxd8gvJWnAbPBswyzNFzh1E8pX8Okw?=
 =?iso-8859-1?Q?Iqxfa/uwSQkfw4+VvBz3UkHkUMVaf/6Ysj6qPiP93tGiq0TshydJNaUMlk?=
 =?iso-8859-1?Q?5ZOqFOapiMfzJVuYyB5hbzq8Cln1qSASk62Y5p6TnM177iPR/aOKk5Ulaa?=
 =?iso-8859-1?Q?lEHRUeGLcodrOvu21KfcOeZ4bfJtI9m9ibex3mIx48yf9tyJkq8WuHGCup?=
 =?iso-8859-1?Q?ex1ZQLHAjSnEmMk5KblORQjFshqfgZdzsKmAzXQiIqGuGrmlLYOyqGlwcA?=
 =?iso-8859-1?Q?BGnhMrMrO4SqGC0PeVLGA+gWaW2h1D1DARJ2OrHNhoN1R6NMIn70AAaWmk?=
 =?iso-8859-1?Q?lr1YbNAnX405a7/IcTV38CA/Z6W/homgGEe7R9s1oSyFQTfVCZVpZbMhV+?=
 =?iso-8859-1?Q?HSZKjx0axoctPNQRv1fXOQAqt4lIKbL+yehk0RtHNSZuNz3TQkcnMGI9VS?=
 =?iso-8859-1?Q?ALDE6W5QQyUttB2PvfZsaWRC7Mi+B18fImLm0InfnXHqBwT7Q9FVBIxLrl?=
 =?iso-8859-1?Q?NGxLvMpVro65/fMYIX96sLP+++3rbUnaqS7tIXbabr/bcuSjhVXKrWSusd?=
 =?iso-8859-1?Q?PmGX5U5Iv+Wo5eVNVFYyPZyrvbpVVdJkO21tfElg950akMyxRelbLLSuF1?=
 =?iso-8859-1?Q?cDUoSa50S/AVbZMC3atF3rM2C42uRtxo10TcSXbU6m3hmJb0P0sZTXxp/m?=
 =?iso-8859-1?Q?XXQMChI5FCdVWPFO4kHHWBMurfM3RmNwL0U5al19IpCS/r/9hrk4VLT1lv?=
 =?iso-8859-1?Q?Te1bYKyfya5XsH8VOFQnHdr2rxExKgS55vF+rW/oAgUGEEeTsB9nAv9L5+?=
 =?iso-8859-1?Q?MCsIV03m4qf2Umam8dGBZDij5hGrEATlNd5a3NAr1+o2c1G0VxGBsYBEVj?=
 =?iso-8859-1?Q?9kocbXVsMMq04/EpDjU0oM2HYy0KHBVGen2tNBp6SOE4uiYsheT9v2P7j7?=
 =?iso-8859-1?Q?UIF3NcufUf1WMeL8bUaFVzyUWnQds90WZoB6yphBdKSYtgsllKz5SMYHVA?=
 =?iso-8859-1?Q?SC18nYZ21O9LA7cyVVsvLL4zyCU8ph8l8RMyLacR8+rcCK4uzplVHsIGd3?=
 =?iso-8859-1?Q?tBYwRQZfUp0WtIQf5GH/4VVX/sumUcer3KiGag=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ctb1K+FjdDHhGdJr744jjIBa2+SUvsIXrAlEVcSLyFeTgpx/P8VJMyPYXR?=
 =?iso-8859-1?Q?F6iqyw8teX8yqPPUJBFjtutYDRwb1DqExIUzVTK1BAVaPeRI2NInRsDt8f?=
 =?iso-8859-1?Q?NXhPFFiDVdR/wvtZM7hJiuoi+2AgCPF1e19ClwwxIW41NM+/uDOKkRKwGW?=
 =?iso-8859-1?Q?C6vJNtP6xiwiCDmzis9HiZxH7k4fgg55y8Y63zbl07FckNLD3ci69SgdXY?=
 =?iso-8859-1?Q?OElLpmQ8vO7A3/yTqafQP7tKcFwuf7g8qV4YDfVWx42t086/dq8aksUpkk?=
 =?iso-8859-1?Q?hFw1lAf5F5XWmn2ARD+rJVH2ykkd0ntW8OaIxP+A2fxwAHJgRMFOtgGENh?=
 =?iso-8859-1?Q?FYENUTodfv8/tiDU1E/GBwWMo+VHcQr7aJp/90/5iARNCOfh7sbBwQNd2R?=
 =?iso-8859-1?Q?Sm4TOGNloNK3CZAZPyD7AXcR5KwFtPrWupyhVdj7TC8Y21548tdlC3vF2M?=
 =?iso-8859-1?Q?8eCf+JJNdI5eu0+iOZIjebRBwvOeW00nXNTAc+AZ+zb+hooCILSC+c+9UU?=
 =?iso-8859-1?Q?yNDCiniYB3hiEiq8eDCIV0joevew/gOwk3RjJGPA2niM0xtNTPseQ1v1yl?=
 =?iso-8859-1?Q?/s1i4U0cqww3PTlAACTl32D6O2m0ea5dM1PMToWIbfPmINIAnPObHD6cnf?=
 =?iso-8859-1?Q?GCHId0Z7XZA7m3L3xCUsqRfCajC/T9Rf3WmXyHGCvivOyQBAdi3STIRLr9?=
 =?iso-8859-1?Q?D3urJ2FygC2pPEduGS/gMhSC4KRJ89ovktbLmbk5C4r5Y0fE63sR8xCYA2?=
 =?iso-8859-1?Q?0s9DgSrrIBhSdeoJC9X6PCOGJGo16gf/XlItF4zTnhwreXey508XdvGhfV?=
 =?iso-8859-1?Q?1jatDI542n5dret/x89d/P/4+7WEiZ4dHSeze4NmQ44JPHsCurI+ALYtCK?=
 =?iso-8859-1?Q?kVcJEFer41lbtiyyXsK51jouHeEOdzPjoF2HmUmTBaecJto9o82M2//V7j?=
 =?iso-8859-1?Q?VE6GvMWvnU6Ja4vhPsx8SZ6MGz1odrO8xnnmS9M8FYG4xVZ7FcG6Rm/g4b?=
 =?iso-8859-1?Q?fi6fODpuxNZRlQqG0Fxwk4a6A3EVeNwiS3RhvkI73FrQY0iM2kd0cQPRBw?=
 =?iso-8859-1?Q?kbGnVnfdfLorMoCCA/fpBcY6aoYNfBloRZIGHKL8P8X6JTfeRM4OoLb1NL?=
 =?iso-8859-1?Q?sRnQyFG1xp0ZK0GFm2Bfbe7rpYK6EeS+EO2vqlCXPE7redMfrhj7jMZl64?=
 =?iso-8859-1?Q?Sv7ZsGblmaVJ1FsQEguYRvCoK8Z8uuX4kcrDCTZ8PtOi+2byYijF2Rg+DS?=
 =?iso-8859-1?Q?uGK+e1Uq1zYMa05AaLlUjpTP8v6K8pJZ4nxq+R6k7UkhlSOfzUZVOyEui9?=
 =?iso-8859-1?Q?qbNTtgZ79ZzLhcRCoxGbgh9+uIye9FGSX5UkdaslUDe6yLhwrCKDVe+Co0?=
 =?iso-8859-1?Q?1ZWnGvU6wlJVR3fahbY9M3nyENQ+otzaKfMqgGeusu/ANcVwsUphCLL5wZ?=
 =?iso-8859-1?Q?jwqnorpNvSNT/0qN6maJkNtBwnWPhkNZIJ0HjrZeuAuHvDnLDhMFEniIXq?=
 =?iso-8859-1?Q?+fwuTRIkOa7bf+4oMqW5iAuTp/HvDrJnQF20GxCp3o8pnCx3vPzZyLDQmq?=
 =?iso-8859-1?Q?FefEGH7wcN8aQJ1lIqOHfjv/uEJB/n9idsBMsvpppifpWaO8Ad7TdLPoaj?=
 =?iso-8859-1?Q?uDZZafdYZZ4GRns6tUUHtC0mAVF/aUH5iLcnkMswe3ZQ9C3ZC3dJQ6qW3O?=
 =?iso-8859-1?Q?NlzlC5PfaQyx86NTAnxtQyNIKJh0OAcSjNIq9jGn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a30fc6-3974-41d8-26d3-08dcc6181339
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 21:43:08.3236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXlcAqbPN2UDULTKhnNdjq4kpg+cEJ0R+O2JoNGOrRQMvEoNmXICif1q1wIrYTxY1R6Xd8adoYjNd8xM8cJDiPWq8NUvas4s2LiO7EUA8mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449

From: Tristram Ha <tristram.ha@microchip.com>=0A=
=0A=
KSZ8895/KSZ8864 is a switch family between KSZ8863/73 and KSZ8795, so it=0A=
shares some registers and functions in those switches already=0A=
implemented in the KSZ DSA driver.=0A=
=0A=
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>=0A=
Tested-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>=0A=
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>=0A=
---=0A=
 drivers/net/dsa/microchip/ksz8795.c         |  16 ++-=0A=
 drivers/net/dsa/microchip/ksz_common.c      | 134 +++++++++++++++++++-=0A=
 drivers/net/dsa/microchip/ksz_common.h      |  25 +++-=0A=
 drivers/net/dsa/microchip/ksz_dcb.c         |   2 +-=0A=
 drivers/net/dsa/microchip/ksz_spi.c         |  15 ++-=0A=
 include/linux/platform_data/microchip-ksz.h |   2 +=0A=
 6 files changed, 178 insertions(+), 16 deletions(-)=0A=
=0A=
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchi=
p/ksz8795.c=0A=
index a01079297a8c..aa09d89debf0 100644=0A=
--- a/drivers/net/dsa/microchip/ksz8795.c=0A=
+++ b/drivers/net/dsa/microchip/ksz8795.c=0A=
@@ -188,6 +188,8 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, i=
nt mtu)=0A=
 	case KSZ8765_CHIP_ID:=0A=
 		return ksz8795_change_mtu(dev, frame_size);=0A=
 	case KSZ8830_CHIP_ID:=0A=
+	case KSZ8864_CHIP_ID:=0A=
+	case KSZ8895_CHIP_ID:=0A=
 		return ksz8863_change_mtu(dev, frame_size);=0A=
 	}=0A=
 =0A=
@@ -384,7 +386,7 @@ static void ksz8863_r_mib_pkt(struct ksz_device *dev, i=
nt port, u16 addr,=0A=
 void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,=0A=
 		    u64 *dropped, u64 *cnt)=0A=
 {=0A=
-	if (ksz_is_ksz88x3(dev))=0A=
+	if (is_ksz88xx(dev))=0A=
 		ksz8863_r_mib_pkt(dev, port, addr, dropped, cnt);=0A=
 	else=0A=
 		ksz8795_r_mib_pkt(dev, port, addr, dropped, cnt);=0A=
@@ -392,7 +394,7 @@ void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u=
16 addr,=0A=
 =0A=
 void ksz8_freeze_mib(struct ksz_device *dev, int port, bool freeze)=0A=
 {=0A=
-	if (ksz_is_ksz88x3(dev))=0A=
+	if (is_ksz88xx(dev))=0A=
 		return;=0A=
 =0A=
 	/* enable the port for flush/freeze function */=0A=
@@ -410,7 +412,8 @@ void ksz8_port_init_cnt(struct ksz_device *dev, int por=
t)=0A=
 	struct ksz_port_mib *mib =3D &dev->ports[port].mib;=0A=
 	u64 *dropped;=0A=
 =0A=
-	if (!ksz_is_ksz88x3(dev)) {=0A=
+	/* For KSZ8795 family. */=0A=
+	if (ksz_is_ksz87xx(dev)) {=0A=
 		/* flush all enabled port MIB counters */=0A=
 		ksz_cfg(dev, REG_SW_CTRL_6, BIT(port), true);=0A=
 		ksz_cfg(dev, REG_SW_CTRL_6, SW_MIB_COUNTER_FLUSH, true);=0A=
@@ -609,11 +612,11 @@ static int ksz8_r_sta_mac_table(struct ksz_device *de=
v, u16 addr,=0A=
 			shifts[STATIC_MAC_FWD_PORTS];=0A=
 	alu->is_override =3D (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0=
;=0A=
 =0A=
-	/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and=0A=
+	/* KSZ8795/KSZ8895 family switches have STATIC_MAC_TABLE_USE_FID and=0A=
 	 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the=0A=
 	 * static MAC table compared to doing write.=0A=
 	 */=0A=
-	if (ksz_is_ksz87xx(dev))=0A=
+	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))=0A=
 		data_hi >>=3D 1;=0A=
 	alu->is_static =3D true;=0A=
 	alu->is_use_fid =3D (data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;=
=0A=
@@ -1692,7 +1695,8 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)=0A=
 	for (i =3D 0; i < dev->phy_port_cnt; i++) {=0A=
 		p =3D &dev->ports[i];=0A=
 =0A=
-		if (!ksz_is_ksz88x3(dev)) {=0A=
+		/* For KSZ8795 family. */=0A=
+		if (ksz_is_ksz87xx(dev)) {=0A=
 			ksz_pread8(dev, i, regs[P_REMOTE_STATUS], &remote);=0A=
 			if (remote & KSZ8_PORT_FIBER_MODE)=0A=
 				p->fiber =3D 1;=0A=
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/micro=
chip/ksz_common.c=0A=
index cd3991792b69..6609bf271ad0 100644=0A=
--- a/drivers/net/dsa/microchip/ksz_common.c=0A=
+++ b/drivers/net/dsa/microchip/ksz_common.c=0A=
@@ -2,7 +2,7 @@=0A=
 /*=0A=
  * Microchip switch driver main logic=0A=
  *=0A=
- * Copyright (C) 2017-2019 Microchip Technology Inc.=0A=
+ * Copyright (C) 2017-2024 Microchip Technology Inc.=0A=
  */=0A=
 =0A=
 #include <linux/delay.h>=0A=
@@ -277,7 +277,7 @@ static const struct phylink_mac_ops ksz8_phylink_mac_op=
s =3D {=0A=
 	.mac_link_up	=3D ksz8_phylink_mac_link_up,=0A=
 };=0A=
 =0A=
-static const struct ksz_dev_ops ksz88x3_dev_ops =3D {=0A=
+static const struct ksz_dev_ops ksz88xx_dev_ops =3D {=0A=
 	.setup =3D ksz8_setup,=0A=
 	.get_port_addr =3D ksz8_get_port_addr,=0A=
 	.cfg_port_member =3D ksz8_cfg_port_member,=0A=
@@ -572,6 +572,61 @@ static u8 ksz8863_shifts[] =3D {=0A=
 	[DYNAMIC_MAC_SRC_PORT]		=3D 20,=0A=
 };=0A=
 =0A=
+static const u16 ksz8895_regs[] =3D {=0A=
+	[REG_SW_MAC_ADDR]		=3D 0x68,=0A=
+	[REG_IND_CTRL_0]		=3D 0x6E,=0A=
+	[REG_IND_DATA_8]		=3D 0x70,=0A=
+	[REG_IND_DATA_CHECK]		=3D 0x72,=0A=
+	[REG_IND_DATA_HI]		=3D 0x71,=0A=
+	[REG_IND_DATA_LO]		=3D 0x75,=0A=
+	[REG_IND_MIB_CHECK]		=3D 0x75,=0A=
+	[P_FORCE_CTRL]			=3D 0x0C,=0A=
+	[P_LINK_STATUS]			=3D 0x0E,=0A=
+	[P_LOCAL_CTRL]			=3D 0x0C,=0A=
+	[P_NEG_RESTART_CTRL]		=3D 0x0D,=0A=
+	[P_REMOTE_STATUS]		=3D 0x0E,=0A=
+	[P_SPEED_STATUS]		=3D 0x09,=0A=
+	[S_TAIL_TAG_CTRL]		=3D 0x0C,=0A=
+	[P_STP_CTRL]			=3D 0x02,=0A=
+	[S_START_CTRL]			=3D 0x01,=0A=
+	[S_BROADCAST_CTRL]		=3D 0x06,=0A=
+	[S_MULTICAST_CTRL]		=3D 0x04,=0A=
+};=0A=
+=0A=
+static const u32 ksz8895_masks[] =3D {=0A=
+	[PORT_802_1P_REMAPPING]		=3D BIT(7),=0A=
+	[SW_TAIL_TAG_ENABLE]		=3D BIT(1),=0A=
+	[MIB_COUNTER_OVERFLOW]		=3D BIT(7),=0A=
+	[MIB_COUNTER_VALID]		=3D BIT(6),=0A=
+	[VLAN_TABLE_FID]		=3D GENMASK(6, 0),=0A=
+	[VLAN_TABLE_MEMBERSHIP]		=3D GENMASK(11, 7),=0A=
+	[VLAN_TABLE_VALID]		=3D BIT(12),=0A=
+	[STATIC_MAC_TABLE_VALID]	=3D BIT(21),=0A=
+	[STATIC_MAC_TABLE_USE_FID]	=3D BIT(23),=0A=
+	[STATIC_MAC_TABLE_FID]		=3D GENMASK(30, 24),=0A=
+	[STATIC_MAC_TABLE_OVERRIDE]	=3D BIT(22),=0A=
+	[STATIC_MAC_TABLE_FWD_PORTS]	=3D GENMASK(20, 16),=0A=
+	[DYNAMIC_MAC_TABLE_ENTRIES_H]	=3D GENMASK(6, 0),=0A=
+	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	=3D BIT(7),=0A=
+	[DYNAMIC_MAC_TABLE_NOT_READY]	=3D BIT(7),=0A=
+	[DYNAMIC_MAC_TABLE_ENTRIES]	=3D GENMASK(31, 29),=0A=
+	[DYNAMIC_MAC_TABLE_FID]		=3D GENMASK(22, 16),=0A=
+	[DYNAMIC_MAC_TABLE_SRC_PORT]	=3D GENMASK(26, 24),=0A=
+	[DYNAMIC_MAC_TABLE_TIMESTAMP]	=3D GENMASK(28, 27),=0A=
+};=0A=
+=0A=
+static const u8 ksz8895_shifts[] =3D {=0A=
+	[VLAN_TABLE_MEMBERSHIP_S]	=3D 7,=0A=
+	[VLAN_TABLE]			=3D 13,=0A=
+	[STATIC_MAC_FWD_PORTS]		=3D 16,=0A=
+	[STATIC_MAC_FID]		=3D 24,=0A=
+	[DYNAMIC_MAC_ENTRIES_H]		=3D 3,=0A=
+	[DYNAMIC_MAC_ENTRIES]		=3D 29,=0A=
+	[DYNAMIC_MAC_FID]		=3D 16,=0A=
+	[DYNAMIC_MAC_TIMESTAMP]		=3D 27,=0A=
+	[DYNAMIC_MAC_SRC_PORT]		=3D 24,=0A=
+};=0A=
+=0A=
 static const u16 ksz9477_regs[] =3D {=0A=
 	[REG_SW_MAC_ADDR]		=3D 0x0302,=0A=
 	[P_STP_CTRL]			=3D 0x0B04,=0A=
@@ -1397,7 +1452,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {=
=0A=
 		.port_cnt =3D 3,=0A=
 		.num_tx_queues =3D 4,=0A=
 		.num_ipms =3D 4,=0A=
-		.ops =3D &ksz88x3_dev_ops,=0A=
+		.ops =3D &ksz88xx_dev_ops,=0A=
 		.phylink_mac_ops =3D &ksz8830_phylink_mac_ops,=0A=
 		.mib_names =3D ksz88xx_mib_names,=0A=
 		.mib_cnt =3D ARRAY_SIZE(ksz88xx_mib_names),=0A=
@@ -1412,6 +1467,61 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {=
=0A=
 		.rd_table =3D &ksz8873_register_set,=0A=
 	},=0A=
 =0A=
+	[KSZ8864] =3D {=0A=
+		/* WARNING=0A=
+		 * =3D=3D=3D=3D=3D=3D=3D=0A=
+		 * KSZ8864 is similar to KSZ8895, except the first port=0A=
+		 * does not exist.=0A=
+		 *           external  cpu=0A=
+		 * KSZ8864   1,2,3      4=0A=
+		 * KSZ8895   0,1,2,3    4=0A=
+		 * port_cnt is configured as 5, even though it is 4=0A=
+		 */=0A=
+		.chip_id =3D KSZ8864_CHIP_ID,=0A=
+		.dev_name =3D "KSZ8864",=0A=
+		.num_vlans =3D 4096,=0A=
+		.num_alus =3D 0,=0A=
+		.num_statics =3D 32,=0A=
+		.cpu_ports =3D 0x10,	/* can be configured as cpu port */=0A=
+		.port_cnt =3D 5,		/* total cpu and user ports */=0A=
+		.num_tx_queues =3D 4,=0A=
+		.num_ipms =3D 4,=0A=
+		.ops =3D &ksz88xx_dev_ops,=0A=
+		.phylink_mac_ops =3D &ksz8830_phylink_mac_ops,=0A=
+		.mib_names =3D ksz88xx_mib_names,=0A=
+		.mib_cnt =3D ARRAY_SIZE(ksz88xx_mib_names),=0A=
+		.reg_mib_cnt =3D MIB_COUNTER_NUM,=0A=
+		.regs =3D ksz8895_regs,=0A=
+		.masks =3D ksz8895_masks,=0A=
+		.shifts =3D ksz8895_shifts,=0A=
+		.supports_mii =3D {false, false, false, false, true},=0A=
+		.supports_rmii =3D {false, false, false, false, true},=0A=
+		.internal_phy =3D {false, true, true, true, false},=0A=
+	},=0A=
+=0A=
+	[KSZ8895] =3D {=0A=
+		.chip_id =3D KSZ8895_CHIP_ID,=0A=
+		.dev_name =3D "KSZ8895",=0A=
+		.num_vlans =3D 4096,=0A=
+		.num_alus =3D 0,=0A=
+		.num_statics =3D 32,=0A=
+		.cpu_ports =3D 0x10,	/* can be configured as cpu port */=0A=
+		.port_cnt =3D 5,		/* total cpu and user ports */=0A=
+		.num_tx_queues =3D 4,=0A=
+		.num_ipms =3D 4,=0A=
+		.ops =3D &ksz88xx_dev_ops,=0A=
+		.phylink_mac_ops =3D &ksz8830_phylink_mac_ops,=0A=
+		.mib_names =3D ksz88xx_mib_names,=0A=
+		.mib_cnt =3D ARRAY_SIZE(ksz88xx_mib_names),=0A=
+		.reg_mib_cnt =3D MIB_COUNTER_NUM,=0A=
+		.regs =3D ksz8895_regs,=0A=
+		.masks =3D ksz8895_masks,=0A=
+		.shifts =3D ksz8895_shifts,=0A=
+		.supports_mii =3D {false, false, false, false, true},=0A=
+		.supports_rmii =3D {false, false, false, false, true},=0A=
+		.internal_phy =3D {true, true, true, true, false},=0A=
+	},=0A=
+=0A=
 	[KSZ9477] =3D {=0A=
 		.chip_id =3D KSZ9477_CHIP_ID,=0A=
 		.dev_name =3D "KSZ9477",=0A=
@@ -2937,9 +3047,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(str=
uct dsa_switch *ds,=0A=
 	struct ksz_device *dev =3D ds->priv;=0A=
 	enum dsa_tag_protocol proto =3D DSA_TAG_PROTO_NONE;=0A=
 =0A=
-	if (dev->chip_id =3D=3D KSZ8795_CHIP_ID ||=0A=
-	    dev->chip_id =3D=3D KSZ8794_CHIP_ID ||=0A=
-	    dev->chip_id =3D=3D KSZ8765_CHIP_ID)=0A=
+	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))=0A=
 		proto =3D DSA_TAG_PROTO_KSZ8795;=0A=
 =0A=
 	if (dev->chip_id =3D=3D KSZ8830_CHIP_ID ||=0A=
@@ -3055,6 +3163,8 @@ static int ksz_max_mtu(struct dsa_switch *ds, int por=
t)=0A=
 	case KSZ8765_CHIP_ID:=0A=
 		return KSZ8795_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;=0A=
 	case KSZ8830_CHIP_ID:=0A=
+	case KSZ8864_CHIP_ID:=0A=
+	case KSZ8895_CHIP_ID:=0A=
 		return KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;=0A=
 	case KSZ8563_CHIP_ID:=0A=
 	case KSZ8567_CHIP_ID:=0A=
@@ -3412,6 +3522,18 @@ static int ksz_switch_detect(struct ksz_device *dev)=
=0A=
 		else=0A=
 			return -ENODEV;=0A=
 		break;=0A=
+	case KSZ8895_FAMILY_ID:=0A=
+		if (id2 =3D=3D KSZ8895_CHIP_ID_95 ||=0A=
+		    id2 =3D=3D KSZ8895_CHIP_ID_95R)=0A=
+			dev->chip_id =3D KSZ8895_CHIP_ID;=0A=
+		else=0A=
+			return -ENODEV;=0A=
+		ret =3D ksz_read8(dev, REG_KSZ8864_CHIP_ID, &id4);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+		if (id4 & SW_KSZ8864)=0A=
+			dev->chip_id =3D KSZ8864_CHIP_ID;=0A=
+		break;=0A=
 	default:=0A=
 		ret =3D ksz_read32(dev, REG_CHIP_ID0, &id32);=0A=
 		if (ret)=0A=
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/micro=
chip/ksz_common.h=0A=
index 8094d90d6ca4..e08d5a1339f4 100644=0A=
--- a/drivers/net/dsa/microchip/ksz_common.h=0A=
+++ b/drivers/net/dsa/microchip/ksz_common.h=0A=
@@ -1,7 +1,7 @@=0A=
 /* SPDX-License-Identifier: GPL-2.0 */=0A=
 /* Microchip switch driver common header=0A=
  *=0A=
- * Copyright (C) 2017-2019 Microchip Technology Inc.=0A=
+ * Copyright (C) 2017-2024 Microchip Technology Inc.=0A=
  */=0A=
 =0A=
 #ifndef __KSZ_COMMON_H=0A=
@@ -201,6 +201,8 @@ enum ksz_model {=0A=
 	KSZ8794,=0A=
 	KSZ8765,=0A=
 	KSZ8830,=0A=
+	KSZ8864,=0A=
+	KSZ8895,=0A=
 	KSZ9477,=0A=
 	KSZ9896,=0A=
 	KSZ9897,=0A=
@@ -629,9 +631,21 @@ static inline bool ksz_is_ksz88x3(struct ksz_device *d=
ev)=0A=
 	return dev->chip_id =3D=3D KSZ8830_CHIP_ID;=0A=
 }=0A=
 =0A=
+static inline bool ksz_is_8895_family(struct ksz_device *dev)=0A=
+{=0A=
+	return dev->chip_id =3D=3D KSZ8895_CHIP_ID ||=0A=
+	       dev->chip_id =3D=3D KSZ8864_CHIP_ID;=0A=
+}=0A=
+=0A=
 static inline bool is_ksz8(struct ksz_device *dev)=0A=
 {=0A=
-	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev);=0A=
+	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev) ||=0A=
+	       ksz_is_8895_family(dev);=0A=
+}=0A=
+=0A=
+static inline bool is_ksz88xx(struct ksz_device *dev)=0A=
+{=0A=
+	return ksz_is_ksz88x3(dev) || ksz_is_8895_family(dev);=0A=
 }=0A=
 =0A=
 static inline bool is_ksz9477(struct ksz_device *dev)=0A=
@@ -665,6 +679,7 @@ static inline bool is_lan937x_tx_phy(struct ksz_device =
*dev, int port)=0A=
 #define SW_FAMILY_ID_M			GENMASK(15, 8)=0A=
 #define KSZ87_FAMILY_ID			0x87=0A=
 #define KSZ88_FAMILY_ID			0x88=0A=
+#define KSZ8895_FAMILY_ID		0x95=0A=
 =0A=
 #define KSZ8_PORT_STATUS_0		0x08=0A=
 #define KSZ8_PORT_FIBER_MODE		BIT(7)=0A=
@@ -673,6 +688,12 @@ static inline bool is_lan937x_tx_phy(struct ksz_device=
 *dev, int port)=0A=
 #define KSZ87_CHIP_ID_94		0x6=0A=
 #define KSZ87_CHIP_ID_95		0x9=0A=
 #define KSZ88_CHIP_ID_63		0x3=0A=
+#define KSZ8895_CHIP_ID_95		0x4=0A=
+#define KSZ8895_CHIP_ID_95R		0x6=0A=
+=0A=
+/* KSZ8895 specific register */=0A=
+#define REG_KSZ8864_CHIP_ID		0xFE=0A=
+#define SW_KSZ8864			BIT(7)=0A=
 =0A=
 #define SW_REV_ID_M			GENMASK(7, 4)=0A=
 =0A=
diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchi=
p/ksz_dcb.c=0A=
index 086bc9b3cf53..30b4a6186e38 100644=0A=
--- a/drivers/net/dsa/microchip/ksz_dcb.c=0A=
+++ b/drivers/net/dsa/microchip/ksz_dcb.c=0A=
@@ -113,7 +113,7 @@ static void ksz_get_default_port_prio_reg(struct ksz_de=
vice *dev, int *reg,=0A=
 static void ksz_get_dscp_prio_reg(struct ksz_device *dev, int *reg,=0A=
 				  int *per_reg, u8 *mask)=0A=
 {=0A=
-	if (ksz_is_ksz87xx(dev)) {=0A=
+	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev)) {=0A=
 		*reg =3D KSZ8765_REG_TOS_DSCP_CTRL;=0A=
 		*per_reg =3D 4;=0A=
 		*mask =3D GENMASK(1, 0);=0A=
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchi=
p/ksz_spi.c=0A=
index 8e8d83213b04..f4287310e89f 100644=0A=
--- a/drivers/net/dsa/microchip/ksz_spi.c=0A=
+++ b/drivers/net/dsa/microchip/ksz_spi.c=0A=
@@ -2,7 +2,7 @@=0A=
 /*=0A=
  * Microchip ksz series register access through SPI=0A=
  *=0A=
- * Copyright (C) 2017 Microchip Technology Inc.=0A=
+ * Copyright (C) 2017-2024 Microchip Technology Inc.=0A=
  *	Tristram Ha <Tristram.Ha@microchip.com>=0A=
  */=0A=
 =0A=
@@ -60,6 +60,9 @@ static int ksz_spi_probe(struct spi_device *spi)=0A=
 		 chip->chip_id =3D=3D KSZ8794_CHIP_ID ||=0A=
 		 chip->chip_id =3D=3D KSZ8765_CHIP_ID)=0A=
 		regmap_config =3D ksz8795_regmap_config;=0A=
+	else if (chip->chip_id =3D=3D KSZ8895_CHIP_ID ||=0A=
+		 chip->chip_id =3D=3D KSZ8864_CHIP_ID)=0A=
+		regmap_config =3D ksz8863_regmap_config;=0A=
 	else=0A=
 		regmap_config =3D ksz9477_regmap_config;=0A=
 =0A=
@@ -136,10 +139,18 @@ static const struct of_device_id ksz_dt_ids[] =3D {=
=0A=
 		.compatible =3D "microchip,ksz8863",=0A=
 		.data =3D &ksz_switch_chips[KSZ8830]=0A=
 	},=0A=
+	{=0A=
+		.compatible =3D "microchip,ksz8864",=0A=
+		.data =3D &ksz_switch_chips[KSZ8864]=0A=
+	},=0A=
 	{=0A=
 		.compatible =3D "microchip,ksz8873",=0A=
 		.data =3D &ksz_switch_chips[KSZ8830]=0A=
 	},=0A=
+	{=0A=
+		.compatible =3D "microchip,ksz8895",=0A=
+		.data =3D &ksz_switch_chips[KSZ8895]=0A=
+	},=0A=
 	{=0A=
 		.compatible =3D "microchip,ksz9477",=0A=
 		.data =3D &ksz_switch_chips[KSZ9477]=0A=
@@ -201,7 +212,9 @@ static const struct spi_device_id ksz_spi_ids[] =3D {=
=0A=
 	{ "ksz8794" },=0A=
 	{ "ksz8795" },=0A=
 	{ "ksz8863" },=0A=
+	{ "ksz8864" },=0A=
 	{ "ksz8873" },=0A=
+	{ "ksz8895" },=0A=
 	{ "ksz9477" },=0A=
 	{ "ksz9896" },=0A=
 	{ "ksz9897" },=0A=
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/pl=
atform_data/microchip-ksz.h=0A=
index 8c659db4da6b..d074019474f5 100644=0A=
--- a/include/linux/platform_data/microchip-ksz.h=0A=
+++ b/include/linux/platform_data/microchip-ksz.h=0A=
@@ -28,6 +28,8 @@ enum ksz_chip_id {=0A=
 	KSZ8794_CHIP_ID =3D 0x8794,=0A=
 	KSZ8765_CHIP_ID =3D 0x8765,=0A=
 	KSZ8830_CHIP_ID =3D 0x8830,=0A=
+	KSZ8864_CHIP_ID =3D 0x8864,=0A=
+	KSZ8895_CHIP_ID =3D 0x8895,=0A=
 	KSZ9477_CHIP_ID =3D 0x00947700,=0A=
 	KSZ9896_CHIP_ID =3D 0x00989600,=0A=
 	KSZ9897_CHIP_ID =3D 0x00989700,=0A=
-- =0A=
2.34.1=0A=

