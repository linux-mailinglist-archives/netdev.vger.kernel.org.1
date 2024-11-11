Return-Path: <netdev+bounces-143667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD6D9C3906
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 08:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A63B20EAC
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADE5155382;
	Mon, 11 Nov 2024 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AV5g3dX5"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B404D8CB;
	Mon, 11 Nov 2024 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731310130; cv=fail; b=gM6GNNqeReSwiNqfCLM00lhHUu45dS3ZNd7m9rUcbzyaQxBJ8t3PTBBVCocIITIT7ur3m0C7hX7qZzyFogMZbEtJGZfYL8Crzb+2a/LhBmxj4JGPsRjDcN/iV/SR1UBNyDWKxgtPQpt7Er6QNQ99j16mxHyQR/Z/s5tp9CH4TQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731310130; c=relaxed/simple;
	bh=EB6UhGB2NsOpsrEUuLNPQvlJ84bp2C6hpFCY7PCHoJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bk/4d4xIiF4vCURsxJDz3AQUGK09F67G8h41fK2xWO9umdTP3il3+01eqqgFgxOwnxmq1BdAefNauffxxQQwpY+iMt4FwgpV5w0e3zPjwcIu58paivgJ8XC/xSqpHTB6NciZehmSxLkvAHbW+dGmmDZIzhgfM+FiYhy4LPM6GvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AV5g3dX5; arc=fail smtp.client-ip=40.107.249.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSwz7eEEMGxdDKVzmCHDidxLacFKvy3jitosd9bDf2+Np4NX82pRyS5x3PK1kPfMEIIHElIUPfgDsTOLNdS2Gfs15rVds+9R7mQeuIBNUiK/lW+bPhU5ObM4MtxTpkgkg+lLN6u+3f32X3CKrt2Ias6h/MAs9b0kSlaf8wH8kbK59Ej9DZeGbVYRi4RixR4Vdn9qBtYe/IRo5zJc4CC7vC/9iVvPt5L3/XS+J0BxIT2UM4fLRUV2Kvohp5WbifYRkICv/s1A73s7XC0buq/fzigFhiMfISeSg4G1J43YJVnobI5JLFZH+4muru06Ny3Aeub5tQONulKxi3wZf3tI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EB6UhGB2NsOpsrEUuLNPQvlJ84bp2C6hpFCY7PCHoJQ=;
 b=Z5JZbUPm8DBawFTU1Y+oD9lVw3pFmRBjLvdEblzbCU1S83578DwQJrLmek3UIknwaapU60XajZV5po8zq+KecWeCCYgmLPYEIky83CUxeOfQCGN70xN5LknZpdHTH9tsGf5Voz7nC2MNjsz51rOml0vqwLcCXynTuqNJ+FihpwXY8/bJW2+gP0hIS1BNCFrSDcLWr3D5xyZVXgpjzzGtCns/rRk6WIofltbXGxJMnT+Bl48xAqn9WF/Fe6TzKvl0gauPhehKaLhbRMsO0UWJ3uJUx9KbGVNKyJ9HUyD4RRZsWkBTi/RDW/FlabBnDuSw9quWgscjgZC3OFoXMiITEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB6UhGB2NsOpsrEUuLNPQvlJ84bp2C6hpFCY7PCHoJQ=;
 b=AV5g3dX53DqGarknuydZ7vDa6n0cdAPASv5agvjNO8FuHL3Cr0sIoDkhen0fBtDW9ujaAAIG4WQmZM+34kdeBg+qRPlQVujpR7DsRUFLqzswGfjB9lDH5X9rjenfoW7xh7cIVVVeekZFvAEcPsaUwoXKsBweDPvd8DF31e7dhdm8ISHtTMVH/mLo63wwxYL6Aj+32/aH6zy3OpJXE8O6GoxDvnH0ZIolGJM2p97FmNlI9Bw0B2j57yg26z9F7Qsd0YB61KUJfj4vAHmKNP8t5es+jk3gGQEeuRkc/KvfI9bsw91VYWQKk25DnQ2g2Ceu0sXrOSDMyoxs3+A0P6BeHw==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by DBAPR04MB7477.eurprd04.prod.outlook.com (2603:10a6:10:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 07:28:45 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 07:28:45 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Frank Li
	<frank.li@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next 1/5] net: enetc: add Rx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH v2 net-next 1/5] net: enetc: add Rx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbM96K3RveBsHlx0mg/hdPKFgO+bKxrpNQ
Date: Mon, 11 Nov 2024 07:28:44 +0000
Message-ID:
 <AS8PR04MB8849441B5718183BE61BDA8E96582@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
 <20241111015216.1804534-2-wei.fang@nxp.com>
In-Reply-To: <20241111015216.1804534-2-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|DBAPR04MB7477:EE_
x-ms-office365-filtering-correlation-id: dd556984-c083-426c-127b-08dd022279af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kfANetHSpWIfw3CjkSgbq7IiswNA8J7aJUYJGnKyu3hhHg5yuwZsow5yfcEa?=
 =?us-ascii?Q?743VwUdg7EeHMnpL281CKA3CUdgwbURGxXe50dMXqFJjL7JP2oo7b3p0PLzi?=
 =?us-ascii?Q?Vyp9TzhIfQIyVuxYwB/n6d9fViK9VJ4H8c5BMvMRsojmwn8q8Dz7uH27a6C/?=
 =?us-ascii?Q?7PjpumQpkLdIBLI/OpropZP85H5z5xhidyXipQoA+mypqWKhJbqyDA/VS3uk?=
 =?us-ascii?Q?elGg576V5AmjwCLREUT2tnyHDtw1lRMFeG7j/KZW02g/hvtwSRaHJDt3QKij?=
 =?us-ascii?Q?FuhuiDQDqiSQMgOZ5YrTQxQhuMXw+9oaksNcAomDILg+yBOdgaSKTmKfb/De?=
 =?us-ascii?Q?6SwLcq9Hmv8oULavtZLocfFJ9jFDz5j+r5w4KAYxUFp4zozLOe1F4Txnw6x4?=
 =?us-ascii?Q?HIoCar+z7qigwZf8yYymQNHVpFt5K04MDxfxmGuNUAfJhJ7zoYZUPHruMMj7?=
 =?us-ascii?Q?EVwbLwZJvVLxMmR2mTlrCU3DcSRFEI+ZBhaK3LyXHU2ZpA704TxUlfRcOMBU?=
 =?us-ascii?Q?LbsXI9WTrwNqilgWuEUplrqiOOOfUXqFBtAcK9CgspjAynIv1ZBrq+B22t6o?=
 =?us-ascii?Q?pS6o/CenY+Yi0CPEhm/Li9MV3h5Ko+IlbeqUqVm9SJj3S0LOJVPG3ipxZ/oT?=
 =?us-ascii?Q?YtD982tLjz9gOJMWBFpvX/RkMo4EQwHp1El0eZxr5SS3WfREyzYH6dcF/U1K?=
 =?us-ascii?Q?43qIMCmCpI1G78uma5ERlieqJG7c4HpMdrqlrdD4M/uA4CWIgLBY9G144OAM?=
 =?us-ascii?Q?/9MOTOUR8VYdXJUKPD6ljSCpX2G5gXKTzEXtifEeqDg7vn6UWOWCILCjIKcJ?=
 =?us-ascii?Q?BSOYueU/VrWOw4UPvdeJdYqXOfPDUv/O6XEfTBP+St3Q0llPrmt8HMFoqat+?=
 =?us-ascii?Q?Q3yIUHS95DWOzKyGZNAN3MSuJMkGZFIvad69HpybnRTCBdHB3GRTqbzb0xGM?=
 =?us-ascii?Q?tcZrT1VEdTiocEfz2pPeDW0UGb2NXsKGOSKpKajw+rKuin3uOMGBq7Bgsnwj?=
 =?us-ascii?Q?zz0NmLnCiMMQSLTMZzkwmB8BtyJ9lTHZLINgrS4JPG+QB/IzP2+n/U6pobjZ?=
 =?us-ascii?Q?goV1G7w+Q27azqpVtwv1eAUwuMe+5VGPWgRa4h5O34SJ1AX8zKIgKUgrqhN/?=
 =?us-ascii?Q?o1BX0GJg7F8Xtk2nQ5k2FPVuwZ5ylVzgxxma246MTBhNnYS67fvFBnw97Zxt?=
 =?us-ascii?Q?R/1EvJt+NUuCPHvVR3mgvFvFgHkQBcRkoPH/+FBBFqMf9schemh/GLbfRLQW?=
 =?us-ascii?Q?M07XySPMxdhzWet5MkzsGyCtIhku7Z0tWTyT16n2SIdmK19lswHfF3bArpMu?=
 =?us-ascii?Q?IkxKbrdzIFMbUIjqRzTYu+UpaTzt48RdTfw4i4qh3MQXgTyKEq4D5G7G9LNl?=
 =?us-ascii?Q?o4+T5Y4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v/P61u/TDYM72CaWkn9vp2uH8NvADK0e7rVKv/ed0dOhCebQwDbsQvGKScEp?=
 =?us-ascii?Q?wRKhLxM7wl3wFjCJP0U3NbxCstltrrQYPiA9tdFWb7wmLtrG3vWjjSgO7B15?=
 =?us-ascii?Q?OP1lLi2aQGmV3KUK9tUdeplQCDv2P2mPvR3x0En/fVzl2/eSbDicGqzWCAQg?=
 =?us-ascii?Q?8+1AOl+geseMLiaogR6u6fqEG37yvWb44jkP3in+83bbg2op1nixA891jV1m?=
 =?us-ascii?Q?Mhjcxo8oFizGAUNDLqd/1J/iuaSZR2NPqjnDIvpKvrCh4reae8cbJ3ctUYEB?=
 =?us-ascii?Q?+GIZF1bVUOcn3uunHLmPvpK9c2+Xuca1zpH6M+a2gA+DJJKezkMvJc6wpZ/P?=
 =?us-ascii?Q?MyucqLhntVgg1he4OTprgCY5UnsYySmOHfaNbG+Mjp14qNQfpONoFGict/Pp?=
 =?us-ascii?Q?MYqv8tCFZHTcP4vz/nJL0ATGsjYsW9RjJJSs78nrUWPEyBbS5Slh4hyZjMiG?=
 =?us-ascii?Q?eurhroKNtowOahGyMlDQ2zatocLon0pP9T3+m7ei6HHj1zcQ+aSyvgTuywvy?=
 =?us-ascii?Q?ugA7OttvfAyr4A/5b/Y3NClHj7lehMVYXHhhcamNcfslgtvds6SD6T9xBuuL?=
 =?us-ascii?Q?lEZZegEe7k1R4VG7eaNLThpEbZEtwE/bNFyOhf/pJcIED4CoTPjD53UIAdPp?=
 =?us-ascii?Q?acFhT3Zko77M7Gc9HhxYcea3ndQL6nTYJMJ62gKnunpghZVw9eb2RO8ySsPf?=
 =?us-ascii?Q?AEYYfw5eBU/H4N+uV+r8HzBVAwSQEeAOEQWwlj8qbUXYyTWKXb0yn6k9SR1q?=
 =?us-ascii?Q?mNRPfWBpRI/rbyjBzosIyPyRgEWZsFxuECWVQHHCzxVxKKZXnD5YfIdaEGvD?=
 =?us-ascii?Q?CIzoS69oQ96qE0VayQSpzuSUZF+/mgqUATu9XjhOLR/EqzV5gCXOqhzibJCg?=
 =?us-ascii?Q?b9haaVWX2JfYN5SQ2m1JZOen67b9FmvKT+gNovMDSSFOU02xnJoVdM4Iv1M4?=
 =?us-ascii?Q?+r2D0m/ow870kAmVdDgYNnSxyGSz+OF2E7UILb6EGIeIbLpB9lPqb7kgDYza?=
 =?us-ascii?Q?Ce3Zrw2iYBt+KIWC65bdqZEC6MxbXvhqyH9OatBhV7K6GuHjTzPHgDUil9SN?=
 =?us-ascii?Q?9qR6DNgRv0JSN69YgFXS9nmYwajDTZy2IDx6FOxoZhPHQJsCEGHPcdnXve/9?=
 =?us-ascii?Q?JsvWFricC8TVrsHJIPZkOSnppJl3CBgV9mSCVHYOiwUa6EOWMX+uy+zwEF5l?=
 =?us-ascii?Q?7bHciGDQOHAOD3UXVgAGujXxUIy8Dvb5d8T0QY+MJbrRwCPDlfG/N0oxE2l9?=
 =?us-ascii?Q?4rsSKXKTh14Pe3AjcE7E/aRHqlqVFWzG48STlAhbCkJJc0jgjC6HhSlalT5Y?=
 =?us-ascii?Q?/Dy7YEQP+qIgvMxLdONHje8spHIPYxZmYqCQWQ1Gj1NT4+gsMwYR/zrwPtIB?=
 =?us-ascii?Q?pjbkpL3HBbL1WpgMnKSwK50a2So5OMaF9axbxDXKv02cOniLbmXT1cXB7c4B?=
 =?us-ascii?Q?csi65JUjRKTNCFwjogWMMWfT9hgey4gO7hy6PWNF+/+ZcX3ZdA2HBpMFp4P+?=
 =?us-ascii?Q?iiuG71wp84h1YE/d/E1GuVkuwSQiDbYOQDRQHS60bjSLdbI4H662xu7HIVNn?=
 =?us-ascii?Q?hEB1NOxQpnL0YQYn/40Nf4vV/YX4kXT3uVjGdU/p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd556984-c083-426c-127b-08dd022279af
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 07:28:44.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zyzkr0h3LIwCICARq9MEZgqwRfVgwRzqzDYx2B5LcRMz1iA2PlwJCGDleMpOLA3Ud/G4ZXYovdpeTXdTBoSeJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7477

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, November 11, 2024 3:52 AM
[...]
> Subject: [PATCH v2 net-next 1/5] net: enetc: add Rx checksum offload for
> i.MX95 ENETC
>=20
> ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
> 108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since th=
is
> capability is not defined in register, the rx_csum bit is added to struct
> enetc_drvdata to indicate whether the device supports Rx checksum offload=
.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v2: no changes
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

