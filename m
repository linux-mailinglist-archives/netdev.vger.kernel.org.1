Return-Path: <netdev+bounces-157935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CBFA0FDF0
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533C33A34BF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C5C20CCCE;
	Tue, 14 Jan 2025 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OaZhYjIf"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE2205E2E;
	Tue, 14 Jan 2025 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817564; cv=fail; b=KfAG0Zl9oArjSRrdkF+lrQYduFJj+XOMoaqw8Ogq9xhJGJTf9741O/g1fGRfFRUbQOJuaAJs0BWV/0pqlZYBwW7M6/rW2RrAmh41DGbZqNx0tvl8q2vO6ZtxbQsnldjk9/WYS8k1xet+PZXbg3jW7AmWn1WLeoTHTQCkvpwm9Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817564; c=relaxed/simple;
	bh=QyzH+LcFpZldajmn+/M7MwWfCu5AjdS+hEaiVWRpGoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ns8cfb97NuWu1KRFOno5JR9N7ugJUVMWtCSLhVvv4ckMNcGtZYAHUasyyrL0UPOBepupU+82yYiZQYDjD8AnmyQMTgSOBlRDvsHLep73r1i+BHHWwsPek0SxydkDhjLYDhQjq049YTJy271SAjN4O4aBk/EBOSCEaI/TzdRa9qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OaZhYjIf; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjR5brtyb0AXsAsD80OYTMky7ZR3hznCrf9RNitCrEfDNReqQh2Y5umGfkuqMTGJ+PLgvGbgKWWEe5LYH0yHPAMXun1DbGWFVD8koEts5H54vehIt8InWgUxWmOLYtX5mSTHzs/teeHcxcE9QdoiU2HbYiuCajlDBwm6ZMfT/WFBoE+afQ8rOXYmwEMwQszQmRYDYcIemAPtFECUG4wTRugkM85kaAACbCxW1TyUpKXgplsJemW+C4Db8oVh9StXtTLW/rztlNmMnpVIzJCSnr5tx5vu+UMoB83PY47Mb1PvNybhUj/zSHC5zuqrotmApTqpwScPs+uFnPvk7CAhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MldGC6rw08ldpXjc409WsUYccHcNJGuEeHnruAepCN4=;
 b=QFhaxVnW+NzOcf5CX3CLLyAPzd/fAz8HToo6SP4IaxLgS2lLOGS1qgV2ItePb3cfo3M2OXRYYyoUfTaMsEI4TMRD6TOhgConLhJVb2aCckfPb/O/xaQbZ3eRfzt6Gnuj9/Og3fg4EOC+uI1Qs/G4b5uYrgyR795kOwy6sYZi1ZYrIoW+FsZgdptoOhMy/D9X8L68iRXrdXUaeIe18PRCBmknhwdjimSlbKOxHp/wrABjU+F5KC3d/TLHSmpMsV4ZtKMYMQSYoXHlN1yQ+EUMgBUm7IMJnWGuQhjP3JlhQLVf3z8K6O+ykqKT3X/naApnT96wd1l8WSXaviWiiv65+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MldGC6rw08ldpXjc409WsUYccHcNJGuEeHnruAepCN4=;
 b=OaZhYjIf5ccwIvEY5OqeTVcBjPPPu8DaOWAbaYcgIA3HP+xZslx8qCS9kjBcFxvIuBwhhWMsMVHxTmA5LEerGpxdAqe/8qz+ifeHJ24VtTB/C1BkK32h97IHhjenZ1ebOjcNns6yfHFLreTvrSM8/4Dhlv6wPk1EmSrBoghX7RGbkYjr5ajaOUoCcy5PdyoVYnj2bSAe9oCDD/gMELEVbqNNWRb6htZxw7Zy2NKSYcXR6h/Pt3sxr3hh5ZCbbRaAcyjsgnQ7mB77RCdR4G9Ti1GF7InxOIh9oJ6lAPk832VAoAgNLTweYx0e1OpS0vk9nX/aw7KXf6F9bc7IuYsBkQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB11035.eurprd04.prod.outlook.com (2603:10a6:102:493::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 01:19:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 01:19:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Kevin Groeneveld <kgroeneveld@lenbrook.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: RE: [PATCH v2 1/1] net: fec: handle page_pool_dev_alloc_pages error
Thread-Topic: [PATCH v2 1/1] net: fec: handle page_pool_dev_alloc_pages error
Thread-Index: AQHbZdKqhrWxUqOrnU6Wp6F3x5VmCbMVeMEw
Date: Tue, 14 Jan 2025 01:19:15 +0000
Message-ID:
 <PAXPR04MB85104133C1720610CDCB640588182@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250113154846.1765414-1-kgroeneveld@lenbrook.com>
In-Reply-To: <20250113154846.1765414-1-kgroeneveld@lenbrook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB11035:EE_
x-ms-office365-filtering-correlation-id: 30634aa0-bfc7-406b-09ab-08dd3439766a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1X4zgygKR3xvBKoUhJjDCdiSkrisLUfxwbyWVIN418NYvxHabkXMka00nrhC?=
 =?us-ascii?Q?A5OWxX7yxKnvCv0on+yMyscYLpFcuQNkzur6hzWbJurVMtwiIMs+qMZdNll+?=
 =?us-ascii?Q?CVQZ4Q8peO3Ajd++Im9T4YoV8SS7YXyCZw+py7MjB29oOY3ZYeFuGSrLqOM9?=
 =?us-ascii?Q?mbJJBSSOyhd2PBl/e9omlhyW5nxoknj5TB9mBkKrqs2gpsiz9+wpWaThuf0x?=
 =?us-ascii?Q?PQHrlJ2I50+MS5CL1ArGd+mWfQLB+qpHlYMLuDkCbA3jGKFt8/ezgNpDgMpE?=
 =?us-ascii?Q?vHsEptNLj26M95MTwJWrqJUP7Hrd9qQ2Wo7gUV1n7ouTLY7Du7bQQYbWcv2F?=
 =?us-ascii?Q?izyFttU2yUilenM40HjmJKWm7Rfci0ME4kHTE7Kc4tjYpuM4EtnksKU1OBGO?=
 =?us-ascii?Q?qmgDe/OSSqejL1j5uXMPu6iHwY8L5TNa2WH6WhUcrRQwhbmShfIxPYtAjT9a?=
 =?us-ascii?Q?6+1aYSbI9+Ek5HD4eoBESfh5cC5AAIgBiPAGrbKUbtaGjblb3iJ9m1ru24oU?=
 =?us-ascii?Q?6mR+Jus2J5anwwAkw1zRrQG79XBTquL0BOYyez4kbrfKYLNpY9pgvchQuita?=
 =?us-ascii?Q?Qxxo1NlglKF4Ut7eW3lM5sU6In+JkePY5TR2QrPThHCUfTjdXfXHbJBGV2qx?=
 =?us-ascii?Q?91wo4h+4751kl51KjDS1FubFULWysj+tlV/O/nFd7FEqDBSLsLQUe9660NqS?=
 =?us-ascii?Q?GTHQcscB1ket44YR1NyI0pVfSiwRPE3xAwXTrOTEboHAr0LvtLiAaKfRiv3l?=
 =?us-ascii?Q?qVMKJAMiXfGtvFfEm2IaGyLQYmyMOkI7jGrgRbKGtfLe8RuTbDx7KZBMF9KY?=
 =?us-ascii?Q?giHAwo1CCPfTKnZfsDaKPjx3DwGpTuNt08Qdb84RILqokk50Q9ceiELoMY5Y?=
 =?us-ascii?Q?N2qRAUgsgV7TfJOBgKP/8C8AijuL6LzojJv9zf1tG7Sn0/Ku9wa0bYCvo5Hx?=
 =?us-ascii?Q?PeOTUkFl4qyNpFIaIUUIdWkgvnY2hO/B8Lc0N/6fCLiMVwPPnc5KIPkOBXG7?=
 =?us-ascii?Q?PqEPitkBGNI0R3iiaUb6jUNH0aJVh/LOqVd9tuXkeagRGyKtWiYDOrUuiPpK?=
 =?us-ascii?Q?lFXLLEufUCOiuzMGZEpbn7yHdqoSjmeIEoqN3pNsUpA744hRH1j+Hu/66tTZ?=
 =?us-ascii?Q?dhDGBER7pOVNem0nYcu+jOkqKftsFA6ppneWclS2CDsJxeGcEI6jYKx2J0K3?=
 =?us-ascii?Q?DFEdKXckRN1ele5CXZLqJteQ0rzUjWm4vG+5Qa4zOvCMUWHHugBxEI6Rhrg3?=
 =?us-ascii?Q?rOjNX0wgBdR3IxqEpn87ONsxkUoXJ3daMgLHgkEiXPT0T5wtyHAdrdX0l06X?=
 =?us-ascii?Q?Z+Jydo6MU7PGEP87pag8LSzOxzq1eELlMTCcE7+qOeUAM4OHKuvMgUbIkbK7?=
 =?us-ascii?Q?OLr0Zbr9V9Kui5lSp8gSJDJf8YkHJzySpiARLdp7YJ1bEu3y8cKPkjXIsgJG?=
 =?us-ascii?Q?tkzdFcccp3wNqE59NZSSjDqu0wWwRzo84D8PAOPx6O5mFC2+YZVVuQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cvJ2AIPy53tDpqZIV/UylKvWoshlg2zPRmHKP2s0jovVC3TpJd8VexR4bMRm?=
 =?us-ascii?Q?bczD5MVbdtAIcXBBD+MIUS9L519ekIiWnilhrYKksNpyI5puonB8dWjirMb9?=
 =?us-ascii?Q?jc0tlrXZ3C338v1h/XuUiVcbP58nBCWSWOu4NSDQ0q1ci87M1nip7JPxyiDr?=
 =?us-ascii?Q?LSDs7WwD9G1xE8g5PhSUnzQbXjze4BUgr8mzyCZebmkcyG+VcNrJM0JEJ48r?=
 =?us-ascii?Q?W0XINeuY6URt0Te+eVlZXJG+A919DfXO5oBOH9tvZKR3Erxsk8beumgWas4I?=
 =?us-ascii?Q?uT3+5re07GrJpJpOXGJ2eFOfqf903NhOUkLNw5C7Ezvdff+uL1b4eBk6r2aQ?=
 =?us-ascii?Q?61NHaugK62PADqRTXD5ZkQKCbxVwsZw+8x2uGwRx/eEJcySSg577zQrcIT+i?=
 =?us-ascii?Q?zSR2UtvmpW+LjJv7vy6J4CT3gRdM0/ou9QKr7FoT6XpoQq/ISVR2FkoEM2zX?=
 =?us-ascii?Q?zAkojhBMzoo+lQPZvhFVKzNX0HcFjBaBHfQCVOnykeC+Evt//Dm670n5X33q?=
 =?us-ascii?Q?pEgfNpBDVa9drAoSzAWPq11RMdcksaZYtUKX65dNT7EVHWyYZwope2/vKAmk?=
 =?us-ascii?Q?WYpL3PvNiePJNjFE5h4SB20AB8YYbivuD6bKdM6oDALwerH7fxVFC9diLsT1?=
 =?us-ascii?Q?dtxJ0V3yrBeQvc5oopLcJ4KFgzYNKivak8loBPGfT4g5q0iSRcjTk/qhtYXv?=
 =?us-ascii?Q?/4xgQhH2GDMQUzZfeVW8Wo7qPqbvNHU03+Oz9aCBMGImUQGbbpn+HIhV+ADq?=
 =?us-ascii?Q?Ohd3wiR6lDnVmWOiWdPwrjiwNFOL/jBJ/DwwDStngefyh/+qFcL2+s5l6m/y?=
 =?us-ascii?Q?EYVzMJpqvZG6HOE0sWxjCc0IxBY04uYj+RGjpVxuIGIUYxRAqx3Q1t0VGPEk?=
 =?us-ascii?Q?0uMZxT/MWjSVEa8BKS2+OKNX64ljDf5Z8yIbXYpvyW7CZirveI30CRf+V/Ge?=
 =?us-ascii?Q?GiPgyj+3eswA7dvqUkfQZF2pF6Ig0UPvjuJ1NzI0wTu7zGrYJJ+Vp6tl/zpr?=
 =?us-ascii?Q?6BqVFTU4hDb3/2g9l8bXgQXovJjwH98b8RHENEPm+liTup9vEhLsJFB2c3Pf?=
 =?us-ascii?Q?9V69g5Kb1iK68UVXkrWE1zNnSQcFcFcdp42FPN92oES0sAQFu4IW/jwjzh4L?=
 =?us-ascii?Q?MnwTzjEUcBNSzoLpSqueZ9xqb0fFpW86QLNo1tmVd++QAGCwiUjymB8E1XHq?=
 =?us-ascii?Q?4PMKWot1oqYWmEyRihIv/tQfpoTaE37TfM+S+hPwv3G+2mVhHWJJ3FCNpBmB?=
 =?us-ascii?Q?scuHwDS3olac+UcvFaHhTVj/jv1lxIB97ucOIvUEk31ytFF3kgmbvSmgaUzm?=
 =?us-ascii?Q?/eaiAykTDC5ngL99yI4XlTApdU+55M0P/3ox62blkopPZH3FBscUUOEqjF3W?=
 =?us-ascii?Q?IYwcq/ib76yIdPs6ayDXkX9HqIXxN2zLuE1ddnznYjqDTEk7yztJcBja0JU9?=
 =?us-ascii?Q?Y3yIIBZVwrSlnjwk1Yq5Qggzb9rJWbwuOzy6oeLuglSpX9oTdSNx4R6OT1lM?=
 =?us-ascii?Q?CfwpyYKrsVrkn5Xr7T0IUQtOz3NIm73ZZBB555kYc6SH/eMmLrSN8ROdYhR3?=
 =?us-ascii?Q?bcv0BtESf5v6i3Fsyy8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30634aa0-bfc7-406b-09ab-08dd3439766a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 01:19:16.0295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QWw00KyMoCW+7xGsqj/YRa2gnebjE0JJH1oz9QzRxoIUI4H23ftnHQx6Du13mRwcy3HLPm80NqODDgRhECxFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11035

> The fec_enet_update_cbd function calls page_pool_dev_alloc_pages but did
> not handle the case when it returned NULL. There was a
> WARN_ON(!new_page)
> but it would still proceed to use the NULL pointer and then crash.
>=20
> This case does seem somewhat rare but when the system is under memory
> pressure it can happen. One case where I can duplicate this with some
> frequency is when writing over a smbd share to a SATA HDD attached to an
> imx6q.
>=20
> Setting /proc/sys/vm/min_free_kbytes to higher values also seems to solve
> the problem for my test case. But it still seems wrong that the fec drive=
r
> ignores the memory allocation error and can crash.
>=20
> This commit handles the allocation error by dropping the current packet.
>=20
> Fixes: 95698ff6177b5 ("net: fec: using page pool to manage RX buffers")
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
> ---
> v1 -> v2:
> - Simplify commit message.
> - As suggested by and based on partial patch from Wei Fang, re-write to
>   drop packet instead of trying to return from fec_enet_rx_napi early.
>=20
>  drivers/net/ethernet/freescale/fec_main.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 1b55047c0237..4566848e1d7c 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1591,19 +1591,22 @@ static void fec_enet_tx(struct net_device *ndev,
> int budget)
>  		fec_enet_tx_queue(ndev, i, budget);
>  }
>=20
> -static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
> +static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
>  				struct bufdesc *bdp, int index)
>  {
>  	struct page *new_page;
>  	dma_addr_t phys_addr;
>=20
>  	new_page =3D page_pool_dev_alloc_pages(rxq->page_pool);
> -	WARN_ON(!new_page);
> -	rxq->rx_skb_info[index].page =3D new_page;
> +	if (unlikely(!new_page))
> +		return -ENOMEM;
>=20
> +	rxq->rx_skb_info[index].page =3D new_page;
>  	rxq->rx_skb_info[index].offset =3D FEC_ENET_XDP_HEADROOM;
>  	phys_addr =3D page_pool_get_dma_addr(new_page) +
> FEC_ENET_XDP_HEADROOM;
>  	bdp->cbd_bufaddr =3D cpu_to_fec32(phys_addr);
> +
> +	return 0;
>  }
>=20
>  static u32
> @@ -1698,6 +1701,7 @@ fec_enet_rx_queue(struct net_device *ndev, int
> budget, u16 queue_id)
>  	int cpu =3D smp_processor_id();
>  	struct xdp_buff xdp;
>  	struct page *page;
> +	__fec32 cbd_bufaddr;
>  	u32 sub_len =3D 4;
>=20
>  #if !defined(CONFIG_M5272)
> @@ -1766,12 +1770,17 @@ fec_enet_rx_queue(struct net_device *ndev, int
> budget, u16 queue_id)
>=20
>  		index =3D fec_enet_get_bd_index(bdp, &rxq->bd);
>  		page =3D rxq->rx_skb_info[index].page;
> +		cbd_bufaddr =3D bdp->cbd_bufaddr;
> +		if (fec_enet_update_cbd(rxq, bdp, index)) {
> +			ndev->stats.rx_dropped++;
> +			goto rx_processing_done;
> +		}
> +
>  		dma_sync_single_for_cpu(&fep->pdev->dev,
> -					fec32_to_cpu(bdp->cbd_bufaddr),
> +					fec32_to_cpu(cbd_bufaddr),
>  					pkt_len,
>  					DMA_FROM_DEVICE);
>  		prefetch(page_address(page));
> -		fec_enet_update_cbd(rxq, bdp, index);
>=20
>  		if (xdp_prog) {
>  			xdp_buff_clear_frags_flag(&xdp);
> --
> 2.43.0

Thanks.

Reviewed-by: Wei Fang <wei.fang@nxp.com>


