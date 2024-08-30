Return-Path: <netdev+bounces-123596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B58965763
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB43D1C20A5E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 06:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BB714F9C7;
	Fri, 30 Aug 2024 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jz/Ig+O+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBB12F59C
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998267; cv=fail; b=a3W28mCxxjt9G+94iHoictspPhgeu+AHj/YA5JU00HaHiYRJHBTARggZq1wjgE61Mwdw5xv34J3XqG2IYeDZ7hTJj39lqqsEAXdAbcrR2oMcqOIvLjVW65PfGytN3GcBE1iC/E1dBRQaGT6VvETD4DiPohGzZBqNl6UeYx0Jlo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998267; c=relaxed/simple;
	bh=rndnPKXNCimEDlsskt8AaavpCnGyZVMwx/gWGM8QO2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GTsX+Qb9TUnjL2HyYv2LZIEk5Fy+dogo2jn3Ni8bpsAL1djcmv/5GVrfuKxpLCKYu/XSXohVl4Ll8XLuUDMhyIwVMZzO7tgOsqg5EQTQWJEKzvXs8zfjywCKDrCXKqxUFZaBRroKyTQeiQKa/nlbPWMecWvzedQDp7TIPG4JPJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jz/Ig+O+; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuxuZxA65Bl9SFpyIKEL44Ae3vDyaV1n9w9BLvQlKO4l86fow/jlrZAUYzV9frDV2B1+nNe1ivyfHt58ojlmfQr59UJkX+Mekwk9Uy3h824tZewNk+H9cfDIfcY7qcLoWSOodwrVJWGz5TId+X83lKlkbVs9KUtHymNICn/mc5BTVS7UK5vjEJmGuLVwurdOFcrsPqMGDSffGGKgRgJZmLlmlufG4NZ8dT/gZ8cY5VPwRGOuab54a9WvA3WmP6sXTuZH+gNnvbd5DOjIqxvWg6KIy3c/dhk8rPyP3a4HEUQg/CW2m0CA8Bxlb3mZ67hVlFRSIhazTsy6R2q7c7dfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXwWdNOWXA5B7Y0j+10GGbTBtoQ1WuwvZET+dWrhxKw=;
 b=OVHb9M67g6+fKgPBHN92BvaRcdjDqgajNewxxnYPEUCCdLJYnjYkUU8teZwoxHQiToEx61xSfPP1TXaqp69b1MxYTMKbzoBjfXogViarLNSj9Op5kevWc4TaoHi7Xs2rO5c6BM+cKg3xQzmcPiM9t62sB378y4z4hmJTgq7AUo8FKcU8R0AhdeZaabT509dbHvlrqCZFOYGBHZ7QUZMQtZFb0Ak1jPn5E7F4zmtfHW0O+J9EjygCtqtRPKRedoUbhxA/gFk5HLgDhnROdXIUCTX9+J5wD9bwdfSaID/Hh2v8pv5Xk39nrpvgTNxZzNLBtbXzAmOOU64qqQBfTiXE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXwWdNOWXA5B7Y0j+10GGbTBtoQ1WuwvZET+dWrhxKw=;
 b=Jz/Ig+O+LVi1yXU3KiclXFxPR7cD1RGxLGdfjHToiAoOSwVdrlL3EG2lkVeoqdiMxakyhIfk4pk5rWSES00f+FhfHoeulA1vMQv/dIVHDDDJC75VT/JLZ4d/6TAFEVufYCLbvRM0S19NVvqd6bZy6Fg8+/vspJsChxSA/vbxP5S48usZolV5s0jqSaFtyXtHtKNHVRN/rLQTkM72Cgp27IvekB217WtrQ8+XTh45xltMEvpxPugccLhqAWvjeFThWnR4U4y3atQoEo/VWxWC/CX6BcQLRbyc3rpamYOqZrHK3qdxhg3wOGwlczJyoRkdqdnN5HxlZHSTILa9Gf9moQ==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 06:11:00 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::a624:b299:5062:5ab0]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::a624:b299:5062:5ab0%5]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 06:11:00 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <gal@nvidia.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <jv@jvosburgh.net>, <andy@greyhouse.net>,
	<mkl@pengutronix.de>, <mailhol.vincent@wanadoo.fr>,
	<Shyam-sundar.S-k@amd.com>, <skalluru@marvell.com>, <manishc@marvell.com>,
	<michael.chan@broadcom.com>, <pavan.chebbi@broadcom.com>,
	<Nicolas.Ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<sgoutham@marvell.com>, <bharat@chelsio.com>, <benve@cisco.com>,
	<satishkh@cisco.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<wei.fang@nxp.com>, <shenwei.wang@nxp.com>, <xiaoning.wang@nxp.com>,
	<dmichail@fungible.com>, <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<shaojijie@huawei.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <marcin.s.wojtas@gmail.com>,
	<linux@armlinux.org.uk>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Horatiu.Vultur@microchip.com>, <Lars.Povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <Daniel.Machon@microchip.com>,
	<alexandre.belloni@bootlin.com>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <s.shtylyov@omp.ru>,
	<yoshihiro.shimoda.uh@renesas.com>, <niklas.soderlund@ragnatech.se>,
	<ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<mcoquelin.stm32@gmail.com>, <s-vadapalli@ti.com>, <rogerq@kernel.org>,
	<danishanwar@ti.com>, <linusw@kernel.org>, <kaloz@openwrt.org>,
	<richardcochran@gmail.com>, <willemdebruijn.kernel@gmail.com>,
	<cjubran@nvidia.com>, <rrameshbabu@nvidia.com>
Subject: RE: [PATCH net-next 2/2] net: Remove setting of RX software timestamp
 from drivers
Thread-Topic: [PATCH net-next 2/2] net: Remove setting of RX software
 timestamp from drivers
Thread-Index: AQHa+iHpFgG6TypaYE+PzNaKyEMF0rI/T+Jw
Date: Fri, 30 Aug 2024 06:10:59 +0000
Message-ID:
 <LV8PR11MB870012278E21DDE4091D36759F972@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|PH8PR11MB6732:EE_
x-ms-office365-filtering-correlation-id: e848a000-e9a2-4cc4-9ced-08dcc8ba84f6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?pvttxAJnk3GdGtJ1/eFi3DT3HIzQbtJ1kZH+dzUjN1yk/T1LUdLhQy+qix?=
 =?iso-8859-1?Q?8IoKu5XPFX5faKnjG0R+5glHooKcpRGhs2OUxdvjmotvr4flYd+SZY9KMi?=
 =?iso-8859-1?Q?4wum6mOHB3mxV3G+l5z7g4MdlEXBjHSH/j2p9aZ2yUWqoDarxEbVzeaQRF?=
 =?iso-8859-1?Q?F/94x4x9ReshLy1iP1glGWAgmUxg4WWMdLBo+xoYc3yhVGXWbt/ljD939O?=
 =?iso-8859-1?Q?W/uFOa/O4q5ZAUJex92rIEuhIphdk8mxZlR1D9kodeWO6Llkqmr2TzfOY+?=
 =?iso-8859-1?Q?20GA072bSZ069KW6Q7oNo+1xkzqbDuEMA4a6svWaB81o0DobBQMnMNmYoX?=
 =?iso-8859-1?Q?/yT1wOAiRSiuQDYRawa5F0+RD7hV8Fbf/tnmCbp9VdV+nUTqVmmqwB2yJu?=
 =?iso-8859-1?Q?akWXr2QlZDw+VCpeVRErQHAxW0i5MOJda/Bb+IMlQF+nf1RYUKDvzrWTet?=
 =?iso-8859-1?Q?07PTd5FbM1uEz/07i1uVy7PBao3sYfFa4pPGr4pOrdot1tV4nH+wuLsagJ?=
 =?iso-8859-1?Q?Z8iMxE5XBCc5AnF1JanCl5l36Iv47o6MBPGgvLOslxBoMd3KsYxXGWnX8u?=
 =?iso-8859-1?Q?HrSXipgbr7kwO7AN1Hexck8zW+lUNdqXibQdKrHuFLG7T3dYLzg4yFsVhI?=
 =?iso-8859-1?Q?3hno489EhcNIs7HslwyGc+iQt2nZ4xepJc3OREc+QQNtyp5NHMaxxX2WDs?=
 =?iso-8859-1?Q?hWJiNOCWRBAUw2/5Fxa+ZW4I9lBT3S4JbRFBI9zKrcuznSoTophB8lS4/p?=
 =?iso-8859-1?Q?2clbQCmvZ5Y+sCOfcV5mcSAEJ2ybJqVKiP+483TEw5QQE7szOvSbJXGmqm?=
 =?iso-8859-1?Q?7UqCTnxYDx8vw4ZWkrVqRUXNWH+LSu5MwCJ41wePOu3KpGNKIV9lSU8S46?=
 =?iso-8859-1?Q?7+JFpii8q9sEctnx73HUEv3FB2JZlZrw6bg/++jciIKBVN2IBzeKwBRccc?=
 =?iso-8859-1?Q?LUPJ9S74Mdw0B7W5zyGU9SSZDo9h+FBqLN9D8DJ57aOcrxTYG4XKLyysjl?=
 =?iso-8859-1?Q?VRk5uDt+vDBR1f3D+mPuoT7+tsyEJh31dabBKHrp2Bi28wzvVbFM65EakO?=
 =?iso-8859-1?Q?cHter8C44nIk5e1yraOCKV3NVY3DXvvalP/HEdGYv//P1Worr5HQj9yWAj?=
 =?iso-8859-1?Q?q9f3RCGpYFwVCSpX3sWG8HZQN2XSiLv/virBLduxWzh00OK/SfqCt5JDIP?=
 =?iso-8859-1?Q?kn8l5z6ey2CFT/kNv4AMMOaEXhBh9+YXkHt5IJ7itCYl6zaW8T+OcooglK?=
 =?iso-8859-1?Q?t9blC1MOqmFY+54wMXtFUwY+1gVv4K4mG73coIRWnYaOgkgxLmcW1I9gSc?=
 =?iso-8859-1?Q?dIv3TPxcgM2p0Pip7SpPo+DteZe2hEIFyK8bD+pQ67A/jvrphheGW/tDxo?=
 =?iso-8859-1?Q?k3VJXokwD2kDKI6Hsz6sNrNxYvhKHrmKVqK2UU77a1oe+/nXRlaoX1znHw?=
 =?iso-8859-1?Q?t7AMt2BpMh/MH7IFVeOeg8dgdh6T879adXjGyg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?b6zRxFiVY2pFRReWW1UQfI1B4NPyZt9RtMTXjuR3L/dZTBoCl+L9tKlzhE?=
 =?iso-8859-1?Q?EcyG9RMXePec99P84rX7I2a+nZ7tWwi+6TbkKpADJj2Gk12420fYtAmnNq?=
 =?iso-8859-1?Q?95tvOdzsjGdOPJKUHi01TypVsrlzA2W1qn1QtZISQIqhtZnLpVPFhs94Mg?=
 =?iso-8859-1?Q?weBk4GeoZe9sG4316gusb5rCCnZPimNyOZE0Kn/SbA2NTYxKWRAh/LuWuj?=
 =?iso-8859-1?Q?+s7ys5F6GaPXVOnbJM0g8tsuwWDiuFbTUCME0mdRczLPXXCSV+lPX5eV1E?=
 =?iso-8859-1?Q?DGD+vGndODGzorsT4y3TM3rkdnDChgwgxXSEzwYhEayNz0+uIZkHWhRYrv?=
 =?iso-8859-1?Q?mnfXfs1bebqN1k0hB5kwnbhRNw9UyIDh8X0x8mGrGWxLr+QIuiXPlUIq3d?=
 =?iso-8859-1?Q?TTF0QoBSjq/YQ8ZeoJHkLc5VkiTj7gW/vGyD5b4NXq+2UEi4AhQCSjdJgd?=
 =?iso-8859-1?Q?7oisgPwsW9FTspayQxYCEeKgn3G9+jbUg4Fgz/1JTWUVdnk/THLwTmjVqm?=
 =?iso-8859-1?Q?DF4C4FNiZmoTTBT7/+cDkBO1Rc8iDdbHQdHgVeH2K44L5q5T9Dxa89IXrX?=
 =?iso-8859-1?Q?zWBBLj34OFEJjC3Ttu7ewLTEr3skUm0p4kSLXGsB3jawjYedWhjv2hoaQV?=
 =?iso-8859-1?Q?s6QZVErqaYUjCpITymsr7BJ5yJ8piQ1MzR9lQEsmQiDP46G1FxRr7xtrjw?=
 =?iso-8859-1?Q?ECpEim9pc/iW4WY3lwm1C/s34za32yL5TiTf2PJnb6uNOOpIiAgtzzHQ0V?=
 =?iso-8859-1?Q?9ygYPTSMMkWHQZjAfxcfVQh2jLnkh2Jmdsw5cYF2h3h4DhoHglU9AFpdgp?=
 =?iso-8859-1?Q?2m+BU6ii0lTRnJKQo/iztEhEDCHjMJREDEwp4hGwKGeaHh1mWAPbS3WRBn?=
 =?iso-8859-1?Q?gUd5qf6KonFr89Un+Wsihix/subfPuwXa483VD21ypgTwYGvNQEwDzb8pb?=
 =?iso-8859-1?Q?0mv2BMpaShN4uM4bXMnvx84U9sWccees1alW/rIfj9ECV0y4kzsCMkBiEU?=
 =?iso-8859-1?Q?cIYnjgkwmtufsPnwjtpn/Crff+spQe3JrMqlmVaPFCF818kLotwf/NR85T?=
 =?iso-8859-1?Q?VcNxceXo60oQL4w4HYaoGjMpg8wi2SFVSFB28aBxsLNDIbb/Jbhf9artAl?=
 =?iso-8859-1?Q?5zSdBnEQmuQISs8sSWwPZ6qxxZ18HU4RftOLbjI24fg1Dw/QNvl+Nw+3bc?=
 =?iso-8859-1?Q?28e2tXRGELNtJaOx3OQTJMVn0Vx4z+p1j+zsLjMJsX6obfKKOsiAt6O01e?=
 =?iso-8859-1?Q?abzTkfgXewQ2I0D8AOlRefOiHRlc/FeV8Vbh2iYnwXMS1cmDK6uQv3K2hJ?=
 =?iso-8859-1?Q?+KeRd15Zt8xmgSgKVOpVO4Xdg8bXb1w88U+deT+t4NJkwCB57EEOa4zrd6?=
 =?iso-8859-1?Q?044Tpb4q7BklyxXEBnrzbtuY0n73qOB0FhwYLOVxukOBZxkge1vmI+TcjX?=
 =?iso-8859-1?Q?O/crhhVLG0/WL44/igXOq8cpGbwunDoaHCgK6HhqN/CO+m4MWRkdjlk8Aa?=
 =?iso-8859-1?Q?1QKe1D20BR2YQTwKHsYiy5+/1SYy0VsF+UmWdIVjaOQjE2jOcfUugCtXFM?=
 =?iso-8859-1?Q?LmL85ZGR+oCBB8XBMI5DRuuRgM68n+pJCZ62Ck2wEE6+udGBhAiqT4j0Bn?=
 =?iso-8859-1?Q?DQjWVPZvg614Fnf+7g/xMWh1+b7MWvU1RnvRMtvvhRh8EWv5zA10ejig?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8700.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e848a000-e9a2-4cc4-9ced-08dcc8ba84f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 06:10:59.9726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KswG4RDV5tBCUOk+NxKAssaMMfnaiG+dhhGaytR7wzIuhARuech77M154LMoVkwSvaBGdlrvmUcyU+lNQOR1KR6M0h7jAmN6BGYz9flTR94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732

> [Some people who received this message don't often get email from
> gal@nvidia.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
>=20
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---

> diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c
> b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> index 3a63ec091413..0f1c0edec460 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> @@ -1034,16 +1034,12 @@ static int lan743x_ethtool_get_ts_info(struct
> net_device *netdev,
>         struct lan743x_adapter *adapter =3D netdev_priv(netdev);
>=20
>         ts_info->so_timestamping =3D SOF_TIMESTAMPING_TX_SOFTWARE |
> -                                  SOF_TIMESTAMPING_RX_SOFTWARE |
> -                                  SOF_TIMESTAMPING_SOFTWARE |
>                                    SOF_TIMESTAMPING_TX_HARDWARE |
>                                    SOF_TIMESTAMPING_RX_HARDWARE |
>                                    SOF_TIMESTAMPING_RAW_HARDWARE;
>=20
>         if (adapter->ptp.ptp_clock)
>                 ts_info->phc_index =3D ptp_clock_index(adapter->ptp.ptp_c=
lock);
> -       else
> -               ts_info->phc_index =3D -1;
>=20
>         ts_info->tx_types =3D BIT(HWTSTAMP_TX_OFF) |
>                             BIT(HWTSTAMP_TX_ON) |


for drivers/net/ethernet/microchip/lan743x_ethtool.c

Reviewed-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>


