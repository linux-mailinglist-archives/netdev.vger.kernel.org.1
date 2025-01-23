Return-Path: <netdev+bounces-160461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82293A19D12
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 03:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D5816BE3B
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 02:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6054D35977;
	Thu, 23 Jan 2025 02:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="noxzT8Rd"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2040.outbound.protection.outlook.com [40.107.103.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75D3596B;
	Thu, 23 Jan 2025 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737601119; cv=fail; b=l99xp90Ros2J8WEZbJE7e522IhgRxLQ7eD5f9IftI3WuzDsZbVL7gq3GRZ46NiqCkAMoFn7gbPvZqU5gyDRYLLSlw3Vp1pblPCkxIwKJLq74APTovGfKjg4ao2aXRUaeXcPssPmA/MEiZ2eqR46j3BKFy3ZiMQl5z7Ks0Lsqrg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737601119; c=relaxed/simple;
	bh=nPw2aiwzhtCBh0ubTytXZUIx2p+ilWYITZUS5GVwrhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XvQQdqNJNfv8/SlS1enDjjgddJr40Q9JBP7xiKvlbexhkB8QaQGllsdaKKm2kTXWGvpWl9MtRo41sXKbXHuALnoPW/+2Ek+4ZF6hnlmDzlZyAlWfND44Ty12Q1U5iEtyGcg9LWWt4iqMUZRffJtZvJ/YnayBIHR1U4Xk3bHPA+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=noxzT8Rd; arc=fail smtp.client-ip=40.107.103.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8P1HGvRYM925N3ui3OkZmsTLqyrjpEGHWT2FdYu3PnowlQEC/Z+fVLewGKF/xlQoFSvURKo1aebhc6I7XixTuLIfVyRMPgwyidWAF3YJ1lq4BM9k7pX0uVs4DLP4kIQq7I7iJqeCc9jYIXSzrhwzfGGKB44m2cRHOMJssfYSKu3weLlkOvos9Cgz3IR6QegaF9zlon0oKKM2inKT3jSmNt1/GmUW6+1tCTL/nX1Cc+qCXaKUEoIPcds+aVP+ZJmTehmpbimxUVwR+hBaKIBLq/oNjiwFvJNl4XCJhFneE1cGLLZmaBhfJrxMBV2JW6Nj6QVsPxjyk8p8hiAgj2FOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcO3itXMaP28XQlWeaadHcv4dt/asEIaOnA3wxEhEc8=;
 b=U8GX0DhPZCTbim+VpEx2ZeyfXiMrNw51wPdTtf46GkuODirmC7ojso6nvLB/yvrr1rAbwaOt4pu+rpR9OuY3cXqUIHvwDOSZb5D31Az11OQlIZOpI6WIK9Jgy0Nmfcq+raAUoOC44tGFERqCh9+CNkl121TLIwo3vfeI/GVnfo9/KS2JdSCMNDv7PC5QOTrymchmnETe0/R1bqHlEOI+DU8yPlYITyDfpVNYaNamdxIVtIBJPctMPgWJ62QupwDZfl7u5XeK/zDg6GoV2ayEQZ9AYCZ4klhT9uBcDBZ1ycQVMehZVYjXWOssbZdgdniLw0MfAe7kP3s7bWgQg5oCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcO3itXMaP28XQlWeaadHcv4dt/asEIaOnA3wxEhEc8=;
 b=noxzT8RdLpOsVS96NAMLg/yUX5/7gqsUfWi3W1uIYVvHEBB3gV7OzXipmtc+tuqxIVSqkyS59O2/S59AOQpkaEQFO7eR6RNtGkA6lnegf+bNuspc7b0P+5nOhP7a2gLH3KfhkparWegwim7Vu2PzXOT07ogqP0/KVxeGhVtZKoMj1rl9R65t4nYdS0ydvEr5aTBzpPOHWxzjnE4aT4yv86ivOlvcfWKuHDab4Dy+OhNEGoXK6XrFEYCboAiA/hh227lALhWVvuiQZqmU3E+/9MthYBUacvjKudcQnWBErBCgcZVUrcesdEu8PV9f+0GQ2wzFHnt/pmpsSBTQ94YnfQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB7050.eurprd04.prod.outlook.com (2603:10a6:10:129::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 02:58:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 02:58:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: fec: remove unnecessary DMA mapping of TSO
 header
Thread-Topic: [PATCH net] net: fec: remove unnecessary DMA mapping of TSO
 header
Thread-Index: AQHbbLqLupyHdAm0+EG/wIJk3lnmObMjn2OA
Date: Thu, 23 Jan 2025 02:58:32 +0000
Message-ID:
 <PAXPR04MB85106CE97288D52A04EB685388E02@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250122104307.138659-1-dheeraj.linuxdev@gmail.com>
In-Reply-To: <20250122104307.138659-1-dheeraj.linuxdev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB8PR04MB7050:EE_
x-ms-office365-filtering-correlation-id: 3108db4c-fb50-4461-68f9-08dd3b59d287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Uhh3l9X5F5+KiaRh6MLVkZV3KhzGECovsLCOhinhHJyvECNn4E3vU9UHmgwZ?=
 =?us-ascii?Q?leMtl4THMTL77qqg/ao22OZQpFI6iMVOdNvw09sg0mf8jNi2psAqL+rAZNpM?=
 =?us-ascii?Q?ZBfBbkqd9D6duDXE4tC7WWQRBn7cTVtRl+7FlTkVli5cA+c8EfuddVz5SKJs?=
 =?us-ascii?Q?lt1HUKAxczOSTTxZ1j13SVolIXEWHNFFkgALCE1h90hM0acAxIOUoZgLfqz5?=
 =?us-ascii?Q?S9KzIzF9DBM0XBbyogtl091CQiefLbFN9HZVImmuRXGaY2iKbqN18z4zY7LU?=
 =?us-ascii?Q?91sKSW35HobspqHhK7EXrTJMLy+iACKtMd7jd9iW0CNPkimNz9UedOINBbxx?=
 =?us-ascii?Q?XrAswao/5fo2kRkXKw39WFhm3HsjoOgFbeYXeMtSWNMeFD7ESE7cTZJKTN+n?=
 =?us-ascii?Q?RwqjmW3F5JhOM5Tp78QwK37dJW+6LObYKS32qdyjNQnlsurSrL0o2MYaLThh?=
 =?us-ascii?Q?N0TIo/AI4wulBTF3LFGcFuFup6HbM2C2o+mjpMIZaSzH5j0q2lAgYF3ztbLE?=
 =?us-ascii?Q?kJzPvGKpMY6OMIrCzRykrrDXUkpt5IG316vjExoJkSbMRvPjScjbwcUuuHps?=
 =?us-ascii?Q?QzfPFLowevPwUXtoNeMtvaOspL/a8Z0EvW6qHYFD9xM2kC7nFIUnahHNKLEa?=
 =?us-ascii?Q?rBMPlgm951gifk1tM6POkehpuW/HpVrIx9ImnmjmTLA+nApGweO9r8E/sPWA?=
 =?us-ascii?Q?v34Xt1g+BSyOjuhHZWiRBtTAAaBx+LwIF+qh5Pl15LzfW5litBP/ua7cFtjL?=
 =?us-ascii?Q?dm+1WmMpOXKSbYkew2g6C2vFpyLLnbu2Js5FE9thoyBE1z7t/W5pip+1G00m?=
 =?us-ascii?Q?BT4hoxrwu4NN9S24l2QHDg83b14L4XmILnsmvyGSMKRt4b5a3zgfOqENh/PM?=
 =?us-ascii?Q?RDQbrgUn15rViT0idRyS+e3kmcXx6gDhYPz6I2zO3VGS0yg+jZlUAJ2+JJJd?=
 =?us-ascii?Q?98Jcjl32vE+0rGctyb0D2TFiGHbcL6Eu8V8Gjkp3X84tl9ElxFVov5TlMJQn?=
 =?us-ascii?Q?Qhne/voZyUomRcebxwt4HhIIHFlgnG/NCHOWH/Ly6V7SA/H9IHjwkj4eQlBN?=
 =?us-ascii?Q?yWsoOEPs/Gq1bsC9xFkV4habqUj+HJQAcDGFGUr4LDTD0EGE9pUHHCzBItt9?=
 =?us-ascii?Q?rW7SQHFLtXJuAK1dfnQE817bNdYSxJG4xt4eAhw6t/vUZhsqIGuPkQnBukGd?=
 =?us-ascii?Q?h1LmllhuaJNTuyOaI6BcLRmWQC+7gBehzbip2l8em2dA5dzfJXALHjV9Cqpu?=
 =?us-ascii?Q?VM5UnXGpVhXFv64k3Q6Iwvkfqs9a2R2W/Wj6fXHECFrMVGLMXO9kx12RKmoW?=
 =?us-ascii?Q?EPBd1RXzjOuzb4oJuMQlsiZr1lTaq7+cM/MqHJRhZ85vU5fBIr5OAM1GNzI/?=
 =?us-ascii?Q?eoLGYe13PsyGj/dip6E0Y29j8M03ZHvpaN/0IvBExQyeESQEIrClwPgt4x2U?=
 =?us-ascii?Q?U3DLnVFG6kbDEQhswaq+pYhdeA38sljU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7oThwwDGNpKjF8iHERgjppXxMejGqyFvua/2s5+JrXeiKhO4ROkJ/GcZXiYQ?=
 =?us-ascii?Q?Gep86Yx6ahE9GYKrMD64AKTorA6pUNhon+FwQga+CGl8LKLaP+MJdaBt0cZt?=
 =?us-ascii?Q?6ElJKlPkTzdTRVzARY3MZccTsSKRKNPw++EiBGzHUGPRzDiLZ74KqBR/vbtQ?=
 =?us-ascii?Q?jjyU/IjEfmesBQc6KxUyqCG3rRxrbRzUmRozFvZqdNekydDMQnDSWWeTdc5Q?=
 =?us-ascii?Q?BM9elZiF21lTkTEszBUfDM2F9H+DH79lAcBUqvF25hdNkdHBpS7aczshzJ6K?=
 =?us-ascii?Q?TyuCitcN8Owh8q8tzOdJBOUdTgDAPIOGGKKh5AIF5pcKJqVRHhPmw1IlT5qK?=
 =?us-ascii?Q?dEJJ6aJe1zSQytudhjVTsJ6EOsz/aB0PWx2jDlgWB7wDZDv/Kjr0jrZmRtoP?=
 =?us-ascii?Q?pQccC4KeSLiXyvnuGIy5Z3yNwiG1bwpXlZNQxq1hXOUXXhFxjQ5hTjWCEN9w?=
 =?us-ascii?Q?E3kSvgSrMlesw6E/JtZMDjev9QW0LTHIJf0Kf0+EEWMds2eiQnApygZMsyb/?=
 =?us-ascii?Q?z5AWv2rskRBfcpJXEUrp3EfHuXOiZf9wAb6f2fgX4Gpr7fQ2DoaaMv9Xa5eR?=
 =?us-ascii?Q?SA2gq2W7PHFfVm61pXFhGb4C/okzmzC3J6gG0/6tRt2DFvFzfWCCSiAgo1BF?=
 =?us-ascii?Q?NzRhBV4mad5sElbDiVgfIO3QCuagjU+3w2IEJAvmVLT1riTHkcYRZZWIEtzS?=
 =?us-ascii?Q?YXp1RPioYsNlW+IKno8K+dWLSkGApCQIjaUhuatkvYbKUcP7a5VSZN2AzaGJ?=
 =?us-ascii?Q?/SUCgLtT9/2lMyTF9mQM0zzpzvUIdpLvxy0omMNSXLB/fMBiWoAeOZ6M8fQB?=
 =?us-ascii?Q?59TCzgRQ8l+fG3uTgmEkNASEQLAL8T8MhBxIcDs9yLUvrraJ2jXyn4SetNfL?=
 =?us-ascii?Q?XeXQ8Gl4hgWNAZ+LEI9P3Z3y+QvQiFHteRQml4NGGZTwCLDpULghVXLwvEgJ?=
 =?us-ascii?Q?FZhI3/z1g2gS0UQJIaw2BDnQ4a6u0hks6qFfmPbrtPnIKetQ8ZKQlLJpGMn9?=
 =?us-ascii?Q?Gx7i77lgrGJOXGaiHze75Zp4GMjLslmR4I4Q2pv1nIo7Z7IRC/Kl0EkVoJB4?=
 =?us-ascii?Q?3tbUatdy0AAUQQ67UApPuueLwO/XtiVCa2mqj1Unb5yAj/60NHD+D76ZZEo4?=
 =?us-ascii?Q?tetn/X8LPp85kbB3/R72DxBiyDAXHL+bgMOJ/UNf9LgElqAasSDJhQtBi1OV?=
 =?us-ascii?Q?JLTODutLUtHuADdKgZ/5kVhLfJuArQpKDIo20ox9jA+XCvkOR2lE1LEYreCP?=
 =?us-ascii?Q?I+9dcPceGFwkCTZDo9T4PE3sFS9aH6KqXq6OR0HOnxp4ZXxbv/Et9yiYgatm?=
 =?us-ascii?Q?14PZ0BfRbfy/Dx55MfFUislhq0pZGRwrbwcMzDrdSACFQBX6rB9DBrwGYQID?=
 =?us-ascii?Q?+uq11if4vzW4JN5Kz3Ze3DdWCLrUhDhEmt/AKVbxbq/jVeUmCyAPwBywGeiy?=
 =?us-ascii?Q?etFeyb0IgTjuv6KC3nlWjTQ4Pbd9o6WIpdMcLCpwmosgylCO/iRI7B8YjAuo?=
 =?us-ascii?Q?eRLSa4k3pHGuDA4IxNdmYDGXakesPh9UhNoHX1eoh77POxx5KAWxVE8lWoq4?=
 =?us-ascii?Q?XRYOu/h1ml5MV7bJj+w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3108db4c-fb50-4461-68f9-08dd3b59d287
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 02:58:32.6376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3sXowGnHSxZN04m17VN4NP049jG/aHLDnRviJdn/BGkypMDY4Do+V88usMLZufJnkRJYqe3MTnb1Heik1jjhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7050

> The TSO header buffer is pre-allocated DMA memory, so there's no need to
> map it again with dma_map_single() in fec_enet_txq_put_hdr_tso(). Remove
> this redundant mapping operation.
>=20
> Fixes: 79f339125ea3 ("net: fec: Add software TSO support")
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 68725506a095..039de4c5044e 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -805,15 +805,6 @@ fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q
> *txq,
>=20
>  		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
>  			swap_buffer(bufaddr, hdr_len);
> -
> -		dmabuf =3D dma_map_single(&fep->pdev->dev, bufaddr,
> -					hdr_len, DMA_TO_DEVICE);
> -		if (dma_mapping_error(&fep->pdev->dev, dmabuf)) {
> -			dev_kfree_skb_any(skb);
> -			if (net_ratelimit())
> -				netdev_err(ndev, "Tx DMA memory map failed\n");
> -			return NETDEV_TX_OK;
> -		}
>  	}
>=20
>  	bdp->cbd_bufaddr =3D cpu_to_fec32(dmabuf);
> --
> 2.34.1

Hi Dheeraj,

I must admit that I misread it too. There is another case in the TSO
header where txq->tx_bounce may be used in some cases. I think
the most correct fix is to make txq->tso_hdrs aligned to 32/64 bytes
when allocating tso_hdrs, then we do not need to use txq->tx_bounce
in fec_enet_txq_put_hdr_tso(), because (bufaddr) & fep->tx_align)
will not be true. This way we can safely remove dma_map_single()
from fec_enet_txq_put_hdr_tso().


