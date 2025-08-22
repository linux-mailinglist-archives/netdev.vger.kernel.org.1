Return-Path: <netdev+bounces-215948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2610B31177
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3483A3BB5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5622EAB6C;
	Fri, 22 Aug 2025 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YkSldrL5"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A82257820;
	Fri, 22 Aug 2025 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850494; cv=fail; b=DW8Hd3DbYREBmcy/QAn4fHJIZAocQSic+Owbvw2Pp9ONdT2Kdi0pk9gCiqnmxQjo2+gsKYcpS7YgOUde5HC9wYrq28nywthrr6zQc1GFIv7RzF11r65JTkwfV8Rco+sJtQ3ubcDXRVAyeTVfT0ATvea2Zj+yq3Ufzjm3NgRR5bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850494; c=relaxed/simple;
	bh=1LDOsLld7KGz509iKufKmPzg93w8GomCgq6Ci1wkDBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hM1VcS1fqDrfZk+QrcQstbtHnXQ2NpR2vnvwmBA8sQPIMNkoCqSKdhOAuj7ZbC7kFbg2EF3mlH/o19vdGIwrg9Aqj+gjFfi1jmg5xK14mNIaCmklzpGuwMp/wopysLbv64PtvOvO0L/YOfsMjpqds1lh3hLBJpDV8oJ9lVtyo5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YkSldrL5; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhhR89Ms8hpEKg3FjLk3xCfBQATy/SRfF+n3yDbLD651sbbBlMrnEBgWa2t7V7pC0B9mmxvY75rkRBvR2vQuQCkyJRUQ7qXwk8JFg82qJfU7oZTP9ed7XrRR4aqWXm/JiB5f6OL8jHjqj0+5AhQy2SVi0Own9sdsnkgu5WibSIwVoKRkPoPy/3RFlGW3D2O8lIOy6bJJ5t/T+OzRBIOtI/KjeAejQd5+UoKedO3AC/Zf3Yc2sXGG2d7ykANqkzwSdwavxTZeViYCWk7IwEpS1qA7ITe+yYyJpu7GezUZsnttnOJ6mLzXCoG1KS/V3cCzhjf1DtuH4nuknPGjbCYcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LDOsLld7KGz509iKufKmPzg93w8GomCgq6Ci1wkDBU=;
 b=qqqRruRAknKSkpQUGs9Ic5njuStUnkgYEfw6u5/B2ZTNfRb62Qi+Q0+qMTCr0jFI1qProEvEDOT10qi/Cb/72JXJyM4QiWarFLeMvj4Cj8oeKjZxAzNo6ScW1rQCsoyoB5nOO2xKQzdJjVR2wx3Rii1givGtC5cccRsuZvA5+XjzaqF9djzEchqKFFp5rKWsOfJDP51SrKRcaOzRhkJco1jOqZXEmczD6tGRKBGLPH0RZHkLOMcjCpzY4t0jMtskEsxxkaXBXY7GfcKpKivzLdr561IHyvLLOq2seNIqiSKmU0IUHPlzLbwo/YQX5kTIORGlWSQ4I1QwfUhMAfdv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LDOsLld7KGz509iKufKmPzg93w8GomCgq6Ci1wkDBU=;
 b=YkSldrL5+p7QMhXoYfWhgaoLlL0YcE/Zgp/WGnzaGyzYC7yFe+56+t/k+RcEqH1S+hwYPKn7mrCSNmKshEwf16Lf3Ocy+XAF4SFVUaqitFirwI+WukLeYd4QWntcP84ubo4LTu62f5e8LHvDuJ7YAW/QL8xqvwf3E0Z2buL4sBTmuNdG5B9+SP/iihu4Hi4p0hJ5T9wb+6+1U/OOJKZLHjR57MBfAlZFEocw6IcInC/DrsGSd2NCaZI10KmWpZvgSgcQ3c583i3OnwhHLLmVxAhTwCEopT/54xEdVOAIVDfs4Kxhy3B/pQy7Pr8EXOeSGW6qXKAPWua9649QBTxlrw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8800.eurprd04.prod.outlook.com (2603:10a6:102:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 08:14:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Fri, 22 Aug 2025
 08:14:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcEsoyoJ7sYfSghkG8db/Gx4Jg+bRuUuRA
Date: Fri, 22 Aug 2025 08:14:50 +0000
Message-ID:
 <PAXPR04MB85106504E1B984403DB3C02E883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-4-shenwei.wang@nxp.com>
In-Reply-To: <20250821183336.1063783-4-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8800:EE_
x-ms-office365-filtering-correlation-id: ffda731c-ca32-4e13-1fb6-08dde153f76c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/kiTjuba0qdTJ3bzeN36NLA3iUPaEF3BkYx1NVj+uv3QVbitKLz3jmjL7Lnj?=
 =?us-ascii?Q?WnVZrZtexk0O1gvyLyL9e65HqR84vkX4egup1O43GN9JUhd/QW6wcSTBdcrW?=
 =?us-ascii?Q?DJSDRNTTU7SrH83HUPVql53ZLr2bAZm876PvEukd0Ntt7VuWR1Fgs+ieUpae?=
 =?us-ascii?Q?b20mz566sEcXN1QP4rE49dbG1c1rDKvbfFiTgzWg3FbJAK2V5y4dKubacDio?=
 =?us-ascii?Q?Xko8Hz/4SfyOqUfAhjo9c9jgstLghsD9Eg+YtUhk5yuE/Tz9+Wdvzjm0+Gr4?=
 =?us-ascii?Q?fwnA/mK8X0c1jAPBym7H9Jj9hNehXUaCB686N7h/l8MEfdoWtMV+U+CFxVK/?=
 =?us-ascii?Q?ucYKVSUw4lHGfC8ZH19PnNNNhsmquV8XEDOG3S87NwdKeKpbmtHQPpIJhtlL?=
 =?us-ascii?Q?7j/XuYfPekb4sNRXMlXRmGVUt8oPLnKOT3MOXmxNa5+zER80g4L8r6OhwWue?=
 =?us-ascii?Q?NDFkoOBHyygJYhVHKL1MSLAU1vaUvBai+VPIlKZUNq6ktJg4YEApcS6idDOP?=
 =?us-ascii?Q?fBwUL82vRrdcwsUtw0l+qWq27FgPZrMdAE/TPp+ZhrAuNvzU1Oog181gZgis?=
 =?us-ascii?Q?UURZbOGxWvdOnIHIBtZ+/uOD3e4R5DNcdl/Z+P2mllHet8OJby0At7RyUu5R?=
 =?us-ascii?Q?s7oRUcLnwppOzkDwrRc0DUBswgWwwsxHSxi+1yGkyxnxuWgwHiPb3WzalbTw?=
 =?us-ascii?Q?S8rquiFhB1/1ovulkCuCUVDlwlbjvxTLZswb2BFVDwWBxq12rhe9U85a+x1a?=
 =?us-ascii?Q?QixznYNmKvsMaeGG9PZf3vdpqxDx937qUi5ue7TCNrOdHygbg97VRkPvD21x?=
 =?us-ascii?Q?t2OoROgPZp5tdwzQR3tXDBa5LFAo0dMTHikzXFKiLaO4FCPcAjWUeejmwqjU?=
 =?us-ascii?Q?J6/tcWoFQEqDcexL8jeHTYRE/w4W62Q4fg7USoChWwaVYmzdoKS5czx+XRci?=
 =?us-ascii?Q?Gmcu9LBXYhaKQQJYH6VMiNy4E3bVjkcIjytqsW4WYDeTNIo+6bGXdrG0ahZg?=
 =?us-ascii?Q?Yso/Iw3aQYqoCuD7tZNEJSEe/xK7h7FWhdY19qFJ5cUpRpQ22+Ngrbup7P3a?=
 =?us-ascii?Q?UKErHs33r1xmRhUCWSQXK+hPo8bdNkfqzO4R5Q6f1gImG+9TNnlGbFZ++Ff0?=
 =?us-ascii?Q?pnChV+WUyRlb/y1hYedGFxlbCU3zfP7gzKSGTLvGxU3Mwj+Zz2y4i09lRC3R?=
 =?us-ascii?Q?qi1ab9qp3C4HugnTDhH5ViCyt7nPnSYCacUOMgqhIjn+6vUNybs3cZQGrfIQ?=
 =?us-ascii?Q?leAx5Tplq8GZoa4V9Sd0Fq9HFSk1rVHl5iQJtRz39zX0qkowqKM2WbPvtIO7?=
 =?us-ascii?Q?XzZgitmeJaZ95sHqjZF3i+0kcGnw40SGRHxJVuOKB0Q8GFZzpmwIBzxr0HHe?=
 =?us-ascii?Q?czAcPTcSscBSlREmlcO6D3gIg/s7Q5vp2JLeUagLXnYJBXSkYX1vaaWPjYe1?=
 =?us-ascii?Q?RJ0bg3CCNh0j+zRkPzCHFcnDOGWPC5LAXk/QVMXEUC3Wi0AHX0NTfA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7uRoEufkzZcmiD5F6b9ug+AtyrGf0HAHtRxuGkNMLaUaJzUPoal7cj+mfrYX?=
 =?us-ascii?Q?Pk6xY/392px5y7xT5NWj07PTb1QQqYhK7ozVlvQAEe++cbo9NrFDob8FZ3sh?=
 =?us-ascii?Q?QyUAhCLv/aAnv1NdIBWNS3SU9kfBiMMYf8wcgJ9UrKdNfJeEvm+XoIjVOg7X?=
 =?us-ascii?Q?vnlF7xOJz5BFoWA084czd6dVRMGqy1gV0Y8LOL54BKobcCHh4WbsE0di2TjH?=
 =?us-ascii?Q?RoadeCoAA0w5SCJsCGXhHZkTJZLceUngY+ZLfk6qCT5SCgpEJVYopi4kCU3O?=
 =?us-ascii?Q?U7J3LbwjB3IjKFcXnfC/bxc1RmqVsufI2OLMiu8s/vjx1OhGqjq0QFbQV0xA?=
 =?us-ascii?Q?wo2swK+y7XN2FcchHtFHM4ysgvY8jpIgNhMjE0Xp+XlGn0htp8rdu1rxXlxi?=
 =?us-ascii?Q?GZAI199mUYdYuXXTdRDgQUk8IbPQVzMBh/VNHeR0fD8OgzYO5E2tiipYsLpc?=
 =?us-ascii?Q?rMYwZBV2AXgfKN0N/NkqWTBMvKAfjyV95ztLKnIBtuCY8++Dy3zzAcB/ZUoq?=
 =?us-ascii?Q?RXJcSAX/zZ59MjJUBu4XfxfimagRcFvI6nUBsplkf11OojE81LALMhxozUo3?=
 =?us-ascii?Q?FFBgep+CXZofJ/hMUk0kmp51a2mJGBBVihYmQOplSdhxOFo4ay0R3rvCOaGK?=
 =?us-ascii?Q?fPxYes90Z+x0Td/gCSRSKh6Xv1O8BpJs0+WE3BdXIHyoYNocpT5/FxrJdnX6?=
 =?us-ascii?Q?MtRDhw7sunsXcvckjqXDq/ejsPbwmgZHfczRfWZuv335h1lYS0rCieCpKH01?=
 =?us-ascii?Q?qnsbpvViN6Safi20USYJWRvD+GfPH2qfyN0jLuqDHPnHtl+5m2dDnwNge+Ir?=
 =?us-ascii?Q?Tp/jVChDeHKWaMMIomQPOAkSNfItoyZwmHy+TH8WshAdGIQMuJWKmicsXzlt?=
 =?us-ascii?Q?ilKLyYIHEfln9G/nIVXzrE7di/O2lFJQMCFgfqg3NihhZWnZxfi6mGhdGCUw?=
 =?us-ascii?Q?D9VnM13amXDxPK5YOYNoniWXRVrLHp5vEh+H+KXU1E3D1mVAem2pwIG2zp5+?=
 =?us-ascii?Q?0/m0kvVZa41uoVrnwRGQWmWBuDkU0PfbBH4QAFWikYGJD8LxTDVuZPGcdP+W?=
 =?us-ascii?Q?QXRNUhuNc/2TtrwzISuGMBDgn4K19q1ZaBpHFGHL8hlYqZeDP8rGFLRtpzLU?=
 =?us-ascii?Q?QKBN60WrZ1KBAiP0lGMWA8mf0HSJg7kJemCzCAAbeLIVvW0I9kPS+a1hCDaT?=
 =?us-ascii?Q?yTifpXrfqTeGXVe7Bi0RXvcDDzpbX/KXpPAr5moCpnWi3tQcSgMDmQ3kW+6y?=
 =?us-ascii?Q?pmsrtJptnL2OJMbjal6qOw8Lkcw4SUFMBL81PfOwCaTtUiJD0hFsHciyeeof?=
 =?us-ascii?Q?5TiiWeytteWln56ZRS11J5d7An/isWVxjK/iVvbEu0SIJDJ/Z4kWB65pkmh8?=
 =?us-ascii?Q?PzSashNQjXU6k136acBap7Jiuc+filfUcJh1zsp7sq3WhEzD827koJ6o79DZ?=
 =?us-ascii?Q?/Qh/bZaR8NwNI2uwY6JC2/yjOnR3e5A1eioJSYUY93P3FE9kqgpHphSVZ5r3?=
 =?us-ascii?Q?SLMVTQpS/H1LSVDmllfD4ERklX/BG0sFToemIa5vbdOdEVa4SjZR0wKXNjmV?=
 =?us-ascii?Q?KMTQ1sjdJI3G7a8q/UM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffda731c-ca32-4e13-1fb6-08dde153f76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 08:14:50.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqKlcFIujwd2a7cu0b0p78QKYNc7Cf2e4Iir5ztTchu1TDQM1hHwqXF6oNON0Tiz/6auRNh++60J34qiY9E+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8800

> Subject: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support

nit: 'et' --> 'net'


