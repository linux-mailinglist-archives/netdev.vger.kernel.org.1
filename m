Return-Path: <netdev+bounces-215089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4CB2D16F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C09E52648B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAB22367C0;
	Wed, 20 Aug 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W1sOuaLm"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219215278E;
	Wed, 20 Aug 2025 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653572; cv=fail; b=EoNfqJZQzL8wOApu34vFu1shsRXxSsmGLbMwdB/6Y45JhU2/uIgTzCfxhhhP/oU7Qf4OT+jODKj8ptnrJrn8BKfI22WWVR56oMfVGkCxUUaIYSCKU1KEiY9XuxPsQAsi07nNb1D6DTKbkQNxEzSyG3tL49cGwa7j/o6y4yoshNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653572; c=relaxed/simple;
	bh=vywIL5TvZ4juggry/kGDhaEAwr7QWzw8dbbsWH9v0cQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soT8IeHTDpZQ2IyMrNVgvQTjJxUh8+5tDgIkn2zGOTZbMIr87/jbww/d2srJvnqT6WVTGT+PvsgTjOI5LZ3kFmfgrJxrnA8axipHYZTtyjNYmHHIJRHvwXCVlbNRTzzVqJajFaj47WemEYip0pof86H4J9Lb+/Ps/G/RnleLyVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W1sOuaLm; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5LBWoVkoRtStcWjACIx1B7GIaSm0F7P1dyuP3P+nRsd7u+qZU5qJ5MVcGS2ZsGOLiEwtj0en/I3gg+s6vxBKkX/pPxsZxZ1lmaaCRE1x6JE+4nS9TRnPcGBjZyqfZjqCkgunZjKPmjo60Ax2GSIHaR9E1P0ICnZBRqOIu6u1UyDLqdevSlvgPnF8TiIkYR0X/9G9a9vk85NbrwkXnZIWtM5EPyCoeYJKmDiZCaJfaMBp/M0tD/3hnNT+1McTDSePACJy+Nh00FZJFh0hiMK5yYCuqeFJU2ZD2eCgeqrCMGJZ8XDN7a5phqpgb0f3p1bK39XRczsCr5r6LI0ptk+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imtVqYq1dIMDqv0rTfHpwozXAATF/WZJFPZX0fw5uS4=;
 b=DoFjkBZqZgxgD7hlMvUqV1kbFQ3EwFVoCohtGFtbnJ48zfnBJcQ9eXwCnXtqYXND22gY4AGaCo18nZy67scjYKAWHzAR291yzeyZik9YwX7+2N7BqMpSgs4phelJyGQbXzBJokeji8Uh2HhcVZU9XinCDbcxdF36HoQWhT/WVt2VfLjKI+RRseAQ3L24TOQ0nyP5VI61MEd3VyBKpP/Qv14tCZLe+MHiO25+69rlpKryuuSBmQcGWIz7neg2Of0Zk2VPVj572m4bSXxoZPuL0eu8MLrPY9FXskueolJiMQ2xZ9ywc+W6NJAWwlK8iaWPvT47z+BnWMkcCmaK8s2UHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imtVqYq1dIMDqv0rTfHpwozXAATF/WZJFPZX0fw5uS4=;
 b=W1sOuaLmYs/0kpirs1uoGYtJW+YiRQIHvbmRcYDtlhMtsTIlB4PtZasly4e5c56yvV05pIrgsHdB75DGVh6InSmS+8KhEXcNVfpeunwMD8LnbgLJXXJvFWDaDBW/gurxyWjHQuKAlDKRwD5303coD3Mg0DztTZLBWp3RvuQ3qmgzVUfrvP4CNt/Tw5OVk6hjptuMpIxkwAFUd/8it3tUQw0KqTndckmJP2oRnob2NpY2AKBy3J4vpbEoPtJkqfCypHGVrOyYlieXa0mCCnoGEKstZhS72hZEfSkNFBT3JoS/3xb+6RqR7oIDXPzI6/pefIOhxAKIvYB+l6h2X7R05A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9061.eurprd04.prod.outlook.com (2603:10a6:20b:444::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 01:32:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 20 Aug 2025
 01:32:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v4 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
Thread-Topic: [PATCH v4 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
Thread-Index: AQHcEQjsPA1X71nr3kOgJNN3EeSGOLRqC+AAgAC2bPA=
Date: Wed, 20 Aug 2025 01:32:46 +0000
Message-ID:
 <PAXPR04MB8510813D4147B167FFFC1E198833A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-2-wei.fang@nxp.com>
 <aKSMeI/mBmRxxDZt@lizhi-Precision-Tower-5810>
In-Reply-To: <aKSMeI/mBmRxxDZt@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB9061:EE_
x-ms-office365-filtering-correlation-id: ffc29c4d-a36b-4461-36ef-08dddf8977a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sn4yR+ZKeDZHkjd1mzmK8INEV06PbpjBlLxKMEAuHIAfaWc4hgJkB1YdU8tG?=
 =?us-ascii?Q?xYWabZH63fMGMa+tF00CEwQEqfKxMNmi3LEYxIykY+1znEj/n9knyzvQawrG?=
 =?us-ascii?Q?5b8DxVAjTBk/q+7iTGIVkzWU/W5S2nMicv90cI+uAEU1bN4X+MzXTWgKZbQO?=
 =?us-ascii?Q?TjD1fZxZLaaMmvopPYse4WJoYZvuOCUIuFJM5updO+VYzqpYOR1lwVpFtx0V?=
 =?us-ascii?Q?KSNMNrjigBUBWdQFsehsdwM/TGIWmfs/VQhpBUiURfS5htr3I3z3WjMafv3M?=
 =?us-ascii?Q?Wvq5fl8o3WE/EREXoaSYw3cbZcOkpvWB3cDmJw4+nzD10JKvU5EBGcpnvSbq?=
 =?us-ascii?Q?pjMg5Pt6HJIpwjNPbBjzI5Jizs6tlo6pr6OtNaDKF+xwJ0DMElneI0DETgn4?=
 =?us-ascii?Q?2eIRdcJwO6rgP11efVtmHvcIz/XljaShh0OYbeCofr8tLCQlW+a6p1aMgzxb?=
 =?us-ascii?Q?EelIleEgL44GVP4ja3FGlSOZl1tyvYxVyr14e28ty4hHBoyn+0LBRSnu8rCh?=
 =?us-ascii?Q?niDPwePnMfyFWPWxqe/2ci8AI1sASwra7FiTJXPSokCjY6JM0+glui2PfW25?=
 =?us-ascii?Q?5baz5gBrCecjtiD0sP/hd3eMW0IuLb86LjGz0thclE0KMGkDKIbqiuk68tEt?=
 =?us-ascii?Q?UuWgDXqr+WNa3tEgJXtSdSFKtygmg5yRRsIBa4SVXUznFeJ0EM08NhHfHdLB?=
 =?us-ascii?Q?YMWo5vqy3u6+HicrwGyKplYaFn035b9AD1D/YzSXvkelBWlCOBrEmY2Y3tR8?=
 =?us-ascii?Q?59Vt4sWaKyWqd/2Qb5XGd8fHkfPwtq4Ujjb7Ah54MM0P0tSzyVIPE4mAzSsi?=
 =?us-ascii?Q?UPHGZnSlM4vpBmeQYPIArTTvV1KThhNk9FFTRKlp0SgBajWyaAi4XbBguWDq?=
 =?us-ascii?Q?fPJMlA1JQPzHFnBX6YeasGMpCGGqltSrFwVf8uPctEdBJAdPrLOKgWJWaTGb?=
 =?us-ascii?Q?alLR9sffoIfwz1T404CuXThDM9TvYqherBMxH8vnZzJl0XYNNC0NE0hGJwbs?=
 =?us-ascii?Q?47j/o9zdXJDk/G8QNNjG4QGv/oQWIB5vNlAtuR4koVvrEsj5+ZtdPUbmOpkv?=
 =?us-ascii?Q?r7dL5duQFB39M97O+6gNSmcCynb5DVEiEh6eP8PCCnG5BhD7NWA8jdFNE3MC?=
 =?us-ascii?Q?Pox9iGzNSEBPoe2+FdFp8FLe6hphcyG1NRIUq6EMqSzoXTYW6hrZYOOX+lOD?=
 =?us-ascii?Q?k7JK40f2si6tB57pdGeC0JDVJCn9eaDigKZnY5Yd/Gqj3+5jENBU3CRN7vuU?=
 =?us-ascii?Q?kmx5AcDSrwL7l3hu8+sj2QSCG/24VtQoZp0hXP/PonwCWLsMD6CMKkzL1/zQ?=
 =?us-ascii?Q?RCeTNwMWtSLovufpHoEOA/frEfFA9SphZYLYveoJDL8fq6+v4CnQwXGe9+Tz?=
 =?us-ascii?Q?/ZLLNrgoLwZ9D5fnAT6WcoR/ajdmy1M+ZlHE57ixpyDR6bYwxmwao2C4t4NU?=
 =?us-ascii?Q?wW+KJd0bFFmyX+g4ZF0vkwMuqioRHkew?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yA/GSoyeTuj+XCHCreXjgICzSUoNtvpmhxz6AKG0Q2eUct3Ga3oj+jhQOOvq?=
 =?us-ascii?Q?6u5xZNUqv7rRP9MPfYVWMRvdPExdHrDWJO8nd0J7qZWqSp0Ph0ahPoY40mUn?=
 =?us-ascii?Q?tJVPnuB+3l5aqv+uro8XU64xOtn2T/Uyal2eoUo7koZP2ZVoEn8U1VG1jY8h?=
 =?us-ascii?Q?e0jGaeBZzIhStev4oLaNzMaaE361WzKKMRW/QexmnakW3MTGxj8iV0LKo25L?=
 =?us-ascii?Q?aFkODkwsUY9hJSd01dua0MIForH3I1CyfO/s02bUT7onS4ZQQK5tK7ecB4mh?=
 =?us-ascii?Q?451J9h+mW4J5syrbS3xtpknlcI423HUjsIb5dFeyfoBk1oazy++5RpK9PwQc?=
 =?us-ascii?Q?RtTNO2GymM9Wtj2yZE+EoibabcVlaTgfzcj4TDYbO1YvwcnReC3auPZwn9or?=
 =?us-ascii?Q?Xm92IJ4TRJoH3NhL08b7+s74tiEZa/Dy/8XytCgJImwbGbEVckFvCojZBs0U?=
 =?us-ascii?Q?K87qUQwQThoEmWj2XC033h5+SZgHdD2tQkP4tip5tLv4WC2NgNo16KEfhIm8?=
 =?us-ascii?Q?pggHIxe08DFVWk/oAbZSE4gzRjaT0CdgnUJZv8am0dz0cv6l4ucUX4KPwCDE?=
 =?us-ascii?Q?PbfiUOu/aMr32KpTf+JyIMQtWPguDnBCWEQMtCE/TFDlonctv+PGn14M1abV?=
 =?us-ascii?Q?XQd07NPV/I8FtQEAnTbDOv8CpcvheMXHLAt+xWakLVMoPLrOOl9LpwKXfXCU?=
 =?us-ascii?Q?NtR2CPH8t4a7AtjRXK6mRX8EKcNKFSF9T0PXbiuyOpWU2LLPDorcZ/Z2SY5a?=
 =?us-ascii?Q?Y1M58cPymdZ5Y8DxefxwTpg+q394fxxlQHm2S1feTQcUiNuMIQQ9m0qe1LIB?=
 =?us-ascii?Q?9edlv1IZYGNahuOKzzNt7kzZ96c9Gv7MLropYKNN2VOuig+KOH5SKdYVO4uG?=
 =?us-ascii?Q?2vHc5bvFjwdLtzPjvtMxI5i44HFU4fd/5+sdLJ6zXiqQziSicPztt/PzOi3d?=
 =?us-ascii?Q?UUFfRCbMpAfQ+eMXZzO4hMRugMftF5Pouf9ewSLmZh+UiIzKaFwdFzJYovcc?=
 =?us-ascii?Q?+7VCidRQ8aTJXR+ubmswRN6i5k9CtYQNNe0SC2UhvHTwsKqZz5l1WbLZWzD9?=
 =?us-ascii?Q?v52fFN3cKWossBUSVlSx6byTj2mtnHH/f2EoCiOhZFpM0Jc9/x9J5pzdHd/0?=
 =?us-ascii?Q?7jcTTGJLJf7Ve8FtAO7kAo9LrU/pcnaaGUvAOamktvbsoYT4Q9kuD7snxoTd?=
 =?us-ascii?Q?xX/pkCNAW8sIv3PO9VrHba2aiXJtRt9mBIhWaIAOP8O9fKRWi3gM/lHn2f1V?=
 =?us-ascii?Q?Xu9RL3eTB2dKa3Xm4gh5z4xrwXHYEFAC2l7nknfQjZThD43HbA7dch/huN8H?=
 =?us-ascii?Q?i2snNeyCdFFMiaYOtM72yK3SYZ8MQoY5c5JsYovfyxOYxAVx6NuSmiKxOeK2?=
 =?us-ascii?Q?BXRKiZwgJcOmHukqPbzWmPbNd4w7gxB2HeAdytAXuhYg6TERYuE160cVwell?=
 =?us-ascii?Q?myqeyH41Lf54W10ktyEJLsLeJ+58FVI5c3uxQA51FtOdlzb2VSwC0ueAn2Bu?=
 =?us-ascii?Q?sX3RaZBthv5VVWMIB2D76wfdNJkWFBLvfeR+UxQ4BPLAcVlAcae7mlk8hk0Z?=
 =?us-ascii?Q?+swqnDCYGGXQ7GIVydw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc29c4d-a36b-4461-36ef-08dddf8977a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 01:32:46.6539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tba7FRs7vqRgJ0x3/DMpqwDVQeWB8+u0+XekPgxMv3lcuxctIpYYrb8ObBTZWBoOxllJvH36JNh5ZtK2AaAUVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9061

> On Tue, Aug 19, 2025 at 08:36:06PM +0800, Wei Fang wrote:
> > NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
> > Integrated Endpoint (RCiEP), the Timer is one of its functions which
> > provides current time with nanosecond resolution, precise periodic
> > pulse, pulse on timeout (alarm), and time capture on external pulse
> > support. And also supports time synchronization as required for IEEE
> > 1588 and IEEE 802.1AS-2020. So add device tree binding doc for the PTP
> > clock based on NETC Timer.
> >
> > It is worth mentioning that the reference clock of NETC Timer has three
> > clock sources, but the clock mux is inside the NETC Timer. Therefore, t=
he
> > driver will parse the clock name to select the desired clock source. If
> > the clocks property is not present, the NETC Timer will use the system
> > clock of NETC IP as its reference clock. Because the Timer is a PCIe
> > function of NETC IP, the system clock of NETC is always available to th=
e
> > Timer.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2 changes:
> > 1. Refine the subject and the commit message
> > 2. Remove "nxp,pps-channel"
> > 3. Add description to "clocks" and "clock-names"
> > v3 changes:
> > 1. Remove the "system" clock from clock-names
> > v4 changes:
> > 1. Add the description of reference clock in the commit message
> > 2. Improve the description of clocks property
> > 3. Remove the description of clock-names because we have described it i=
n
> >    clocks property
> > 4. Change the node name from ethernet to ptp-timer
> > ---
> >  .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> > new file mode 100644
> > index 000000000000..f3871c6b6afd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP NETC V4 Timer PTP clock
> > +
> > +description:
> > +  NETC V4 Timer provides current time with nanosecond resolution, prec=
ise
> > +  periodic pulse, pulse on timeout (alarm), and time capture on extern=
al
> > +  pulse support. And it supports time synchronization as required for
> > +  IEEE 1588 and IEEE 802.1AS-2020.
> > +
> > +maintainers:
> > +  - Wei Fang <wei.fang@nxp.com>
> > +  - Clark Wang <xiaoning.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - pci1131,ee02
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      The reference clock of NETC Timer, can be selected between 3
> different
> > +      clock sources using an integrated hardware mux TMR_CTRL[CK_SEL].
> > +      The "ccm_timer" means the reference clock comes from CCM of SoC.
> > +      The "ext_1588" means the reference clock comes from external IO
> pins.
> > +      If not present, indicates that the system clock of NETC IP is se=
lected
> > +      as the reference clock.
>=20
> 	NETC timer reference clock have 3 clock inputs, sys: from RCiEP,
> 	ccm: from CCM of Soc, ext: from external IO pins. Internal have
> 	clock mux, only one of three need be provided. Default it is from
> 	RCiEP system clock.
>=20
> > +
> > +  clock-names:
> > +    enum:
> > +      - ccm_timer
>=20
> look like just ccm is enough.
>=20
> > +      - ext_1588
>=20
> Missed kk's comments at v3.
>=20
> "This should be just "ext"? We probably talked about this, but this feels
> like you describe one input in different ways."
>=20
> it should be "ext"!



Thanks for reminder, I will change it.

>=20
> Frank
>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-device.yaml
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    pcie {
> > +        #address-cells =3D <3>;
> > +        #size-cells =3D <2>;
> > +
> > +        ptp-timer@18,0 {
> > +            compatible =3D "pci1131,ee02";
> > +            reg =3D <0x00c000 0 0 0 0>;
> > +            clocks =3D <&scmi_clk 18>;
> > +            clock-names =3D "ccm_timer";
> > +        };
> > +    };
> > --
> > 2.34.1
> >

