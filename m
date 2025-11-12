Return-Path: <netdev+bounces-237793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D518CC50410
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94563A8E83
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2AC28EA72;
	Wed, 12 Nov 2025 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l2zNtRZS"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A628C037;
	Wed, 12 Nov 2025 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912639; cv=fail; b=VlcQ6LQ12L6eY+w7UxkVOEGE5s119axETmQLt4sTqM/63JSa5Vx0bq+1fM7nwXD+za/m6WBD09OUouQL7UDFwamwnVgo79XI7XUCSo4VsYkzc1v2+mNvGc8XsJvqAyk++87FogE8zhgDw1rbnpuoVy6ToSrWd4FXnIRdBDMN8LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912639; c=relaxed/simple;
	bh=EpthJV8Tg+sDanBpB9tL+nZQ0V8GFI8uXNPg05Avyac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TsDzJGFI76CeA+9XA7RoiX4DF1X1gaQd8zAnP/Sdt47i6bjJ6twm0t7/Xy8WWy2IaHfEMrKaDxCX8LPC93VXHv9c6I8jvxLBhTxOfeaX5t/gEV1OLo/Har1cRHQPa2vOW+9CQ7llj/SHzDWl2u5QK2DMFX80P92dqqUBwfeyih0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l2zNtRZS; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiXdnUwWNkEW8rDdeuZQz1piyTdpAkUl2aQx3eKfkCaa/vG8EfcaKqPNx/PfPAVjrmDPPXokxOAnfGEOkS29TWGmZcFRc+yvaTnJeuT3Bv8v8UEaolkmLU62ODbs9rB3nm9GLWtEoRD7JzNus+bXF7IrwnpXkfjivjRxcP1HdQ4e0ieNFfq6OS60lm1O3L4WTv9yn0jRiEfkOBxRHPDqV0Or4BL0EaQekpljMTMevjScfrZ2Adl35Y8d1B9fie2yMLIvjV8arIQArU/BGHELzo2Bc9o5r/v9J7+J/cQS63gAjssdjl1kpA79KZIJ3WGsUHvjRvOf/Z1iBM9XXOGGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19ENdQkiZoBU4/lvYqZm5Qu2y3BwGykiLt+ap2PnFdA=;
 b=zHnWyiBPWytYKvHst5ny6Kq4ZStU6hMtPEsQGJq9AD/V2qr/yNuf9RPa7wEo6b3QBhtwNL4iPknOpSXrAft+TaLNMpnw0EebDZKuN41vFfhQne2ftiiMfRvUCCN+NPrNbZrFlezEMxJYqNAe40P8ER5otL3rufYJaJ3Dw6DdL6HDN/lBMxBODYgfUh6TEDNh2XM6ESrrKx2Yp+nPyXb7zwj3wAC7Mq9dyvi2QQmWsQJlzemCMeiQ5WQbQsKlY/a+KDeSMoywrwJywdg1yQrlypTa/JYiWwM2DA33lkbvHTO1yxTrNI1gZ2m2IN9d4ePSC1cBYYIy08UE6ysFcPEA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19ENdQkiZoBU4/lvYqZm5Qu2y3BwGykiLt+ap2PnFdA=;
 b=l2zNtRZSkvCSSSMd7WDyWT3H2MjK+ZfTFzvx9bEacGJSXMGfuYqW3tCh6gRJO1aJBp6WBFRCXtbiDGsuouzHc+W7eFUQbXvBSM9k5hqkPBYxqrmMCTV8jIP1CCTIJtCdR4saddauW6EMDCoFyxvEC8XdPteypOK7NannilGyi9neLbRDb/ARlh8qWp1dgSt8SemLVs5wwdTRVVGkV/ar15wgXtH48xI450a3ha21TAp4vokpxwxkRP8GHIIrmfjKvjD3/GSWFrYNUHT4XsplNa6nSb9wvBeqME4DDnuIzA5KNw5BJngQHttDKXAh307CFuEDZ9xEhpCwkgi/qW4T2w==
Received: from AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17)
 by PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 01:56:02 +0000
Received: from AS8PR04MB8497.eurprd04.prod.outlook.com
 ([fe80::24f6:444b:9e8d:6aec]) by AS8PR04MB8497.eurprd04.prod.outlook.com
 ([fe80::24f6:444b:9e8d:6aec%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 01:56:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 3/5] net: fec: remove struct
 fec_enet_priv_txrx_info
Thread-Topic: [PATCH net-next 3/5] net: fec: remove struct
 fec_enet_priv_txrx_info
Thread-Index: AQHcUvIKH2FInZZFjUWB+RQUe8JnErTuD6QAgAA41cA=
Date: Wed, 12 Nov 2025 01:56:02 +0000
Message-ID:
 <AS8PR04MB84970C0D18E20CAB8693558B88CCA@AS8PR04MB8497.eurprd04.prod.outlook.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-4-wei.fang@nxp.com>
 <aRO4/l1bMgugPYhN@lizhi-Precision-Tower-5810>
In-Reply-To: <aRO4/l1bMgugPYhN@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8497:EE_|PAXPR04MB8427:EE_
x-ms-office365-filtering-correlation-id: f9f26979-42f7-433c-35fa-08de218ea24e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TyrMvdLKjlqSrgWj/fMBTPSkGaNppYinq/DMPI81rTp0Imly+5Jr3OOEBpG9?=
 =?us-ascii?Q?tsJ16CTj59JYqf99mLX0FQTfzDXfLuUgofsnV9eIGQ9BUsUe8fPWmKgl2QHW?=
 =?us-ascii?Q?v2U2dLUnhlWr7RHl3UeQQeQZjRSU5eVQdH1RRtf2ru6l9TPRZEcBxdkG9RQ5?=
 =?us-ascii?Q?81xv41mQbzpQFUWEJnRmIASVOpafAAXxJs3XT7fWgGpj1bjWnv8BeIUk0je5?=
 =?us-ascii?Q?Y4PU0aWwaLnu3FbvhppiiFRIbYUE9r9lyL9qnTepHgQpWyYnGlJuGUhOIKj5?=
 =?us-ascii?Q?Ml99lDAfRq6VOrCofmIm3wEXhDGcXg6jmFkKHZindQgIUUIhiY8LYcurlMU5?=
 =?us-ascii?Q?NcaEN8VI70dQcl2VDHGXQuALBYrpNWv96VFKyW3AJ3TXDTPKMVUJDvL8L9ra?=
 =?us-ascii?Q?yu6qt/bqDjMqelji+J1lWnNtB5rh/EosrpPRZBvGXtHXCaqjBhRYRF+8j0Iu?=
 =?us-ascii?Q?+aSQnzqkOOYs1bwaQczAqwr2yOqRag/GmAATgFOD5rvdb/IItJR4LQbwXSaQ?=
 =?us-ascii?Q?aJLlKcZ5fPOGEgCLtrQQKZdZB0NCbFoWh9UR5GctIHfdbNndqGdZGDjLxcxr?=
 =?us-ascii?Q?bfziyzCuhP8ohI5NeZpYKVCrwRHso+nOxBmOrBzgsrr1wAX7IwOdn9Tj+Hpx?=
 =?us-ascii?Q?1bsehp6QAETTyAua1EUJKTMqtbZG0e4cjGQPIzeq/QqXcO7xKAD/PnFhifI8?=
 =?us-ascii?Q?a54x2jo3vUfH6VzqsTaPsskchlLk9LpSZOGKDa0+4EpnDA/OVV6xk3CWWYlY?=
 =?us-ascii?Q?2Br1Gc/CwGwIksj/8d15tAGEQ6to5t7/K7o7CIZ0Ngardkt03+qSR23f5EPC?=
 =?us-ascii?Q?RBB++piTWJbtvOpFFZKAjI1ODA3qdkWTjszvYlHLVKyM1nBPvbMmm2hOw1ft?=
 =?us-ascii?Q?lE8bZ/1L6VmYJ2Vk6AC7lbiS9HeE66cBRUyZ6OE6TrgolX6FBm2gWbBL+OSq?=
 =?us-ascii?Q?XwXZLNbsCqgyqQjrYMzQioGZK2RcBOfWLcvh9zX8LPDF8qwxT1X6S7GqZ1VA?=
 =?us-ascii?Q?CUVsJ/rv3ttNX/EowfDvJ3U3QL7rvXutNLeLr8ngkAoOy3TNAdRWuSCDZPy/?=
 =?us-ascii?Q?ssbKFOygudtAPXpUyqeLh+s13zuE1bBlxEqH+9JVV9QKQfB/97qD0CsSSBd8?=
 =?us-ascii?Q?qrm9UYonOgkwgiFuz04Z5L1B1XaLOCnIsEtYK4kJZ8sMcLodex278QlWHtkR?=
 =?us-ascii?Q?vUtrrzD7BB/rGlfeeMS3woTbWkA8Qiq580cVlIt/Osx/wSgEW90msOGeF6m4?=
 =?us-ascii?Q?9O/JC/KWPKwdMiHooIJs3IAPgF81xdSW7DWTNmIymlESOjDBM7Mj9La32Mfo?=
 =?us-ascii?Q?OwadN52HsaPWwbFAY6232XpAgwvYjywNScE6hrFhlS77ZR1mCaSDK0lY7xk4?=
 =?us-ascii?Q?+UTSSF0KmbbwtNvGhv5oEIi+XmZAkUTZQ0KFeH9BW57U4AOJB1SFhEqF39+8?=
 =?us-ascii?Q?A9UbhKZzGN+oqsaaBGj/7jFf4aqs1pVVjzzeXy0/Bmm8Ws4fCENE9VENx/Gp?=
 =?us-ascii?Q?YGDUdW1B5jceZjWOIYmT74YMGFZC0AApvKzP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gyz/2XFRsqryemN7vA81kwnp/QOO72UKfceOWNTkMXn1FwGy2jF3EpB8pzc1?=
 =?us-ascii?Q?iS8RvV4TNbVsO80STnM8qD2nWh9kdzXJJE7Mgz6FQb8EP2QUmK+TiCcQfBQI?=
 =?us-ascii?Q?U4iDKzpSdTxviuN5MC681hLI0S62P7IgJUZwbRUu54qKrnL7M4GuqARmrLjy?=
 =?us-ascii?Q?FNOIiGayn/5/j55QbIubZ1lCQdcz/FAUrX+TxNLgQtWJNWO5B314gm0QDIlD?=
 =?us-ascii?Q?Zk87Y162U881oMEA99pa7sMyWwIi/uW14+wAKdEv7Fo9Wo49y+NiO4VY5rdQ?=
 =?us-ascii?Q?VnI2HxIAdIvP1+J1P/D7PmF0umUfcJabaYfeN6ya3rOwxJES3MQuQaNi+HdN?=
 =?us-ascii?Q?Bs50XERk1ataA4raxt+Wst7JmIog6kJ/n/IGtCr+Pe2kmxXswewe+EVi3AMY?=
 =?us-ascii?Q?qFjpWxX5amqG9LAtVwqFhluw8etYmX49V+Wji9NxhvbI4NsaXtaHD72AFPRE?=
 =?us-ascii?Q?jDVTNfxS0yuvIWLb1+0pU+pG8PBHMFwuXfwOeYJ0kYPE3xg6UVPR6c/aubG7?=
 =?us-ascii?Q?YuGMgATK+mKWqmoWbvGdmYyQWOSRcAkhc+Q0TIDnQD/cHCmLj9Hb7C4hC+j8?=
 =?us-ascii?Q?nnXxPnyN85h9TPFjfRfJ14q1nYO7NeU6WlorV45bAW38wike3d5R9smS5LX9?=
 =?us-ascii?Q?f0U4yD97pWVIOVHdon8KoKnIAjs1gGNV8/JsT2QvVxhXxwQwVHAxI0jZ4FPi?=
 =?us-ascii?Q?kxuF3Ox0sy0Rbwg7m3+ACOTzPu1flcYQ5cmNkg+3Tlz1+vYhSUC9Dza8H2UF?=
 =?us-ascii?Q?LYfU0OPzu9F5SgOMPqPwdtxJ6FqsoOn9080SnU6o5MRtl/ddq/YR+NLcniPO?=
 =?us-ascii?Q?F1Y4myouxHpkLydEbDdG+bXXmEr/DGcdSUFs35ONZldw/gF7eIIF+HucuAtG?=
 =?us-ascii?Q?EZuYUOvEap3O7i+Sp/GhpN4ZiQX0vu7skAstuQM5icHbepNwSFknfAOxsOsC?=
 =?us-ascii?Q?wC1y+akQF8FLNYXZHPXzDbxQB5f+d4ir5La433ulap37JV6cKQ6oN8jygKrb?=
 =?us-ascii?Q?ty8Io2JdmNkzF2g07u8ge1iFjEUb5iWFOaSaaMGteXknKXDFKvIJVugC1cvb?=
 =?us-ascii?Q?UebWB/kENDdEQI5HWrGHxQQdq73hq07jzn6nKURg/QtkqhtDSAIEfSu0aAJY?=
 =?us-ascii?Q?8kzDfqEZsExxpyQml7PnD1imRcKxG+doLyjaGagrqyeOvIE1QE2NsfhXgxAU?=
 =?us-ascii?Q?z6b5SkKc4SnVbWJ062BwWkaId+kBWaT7YG37RiRAj+JY2WL/77ZBZHwCi49C?=
 =?us-ascii?Q?KEydlOIscCCRxbaO4YcV1hdtWFoX4IPefpwjv5XKFw1qyJI+rDiThGtRj0F0?=
 =?us-ascii?Q?OMGrsCtcJQpCx71Gx8McO++xAEHt17qC4Jzl3+Yz+z6NIyHPXfIsYAoE0zjO?=
 =?us-ascii?Q?t1MLafFpF1j3OoOfg4wxWGkfZbRLI/xVu2F4x3hRQnw766NludDIzIWI4N0x?=
 =?us-ascii?Q?Nbu+3s9ZwimoSA2PzdBscpTtUukbJdHmEpPkF/zZi8EEoUopZ7TbD0dv5GKp?=
 =?us-ascii?Q?0JvN2gSIh7p4yYG7R/5AeXTk2Mly12k0rZrX3M4x9Fy6N0nd2syXXaQpoqYX?=
 =?us-ascii?Q?DgcvwcNQK0Gl10Z9NLw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f26979-42f7-433c-35fa-08de218ea24e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 01:56:02.4421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n07L5tgkRIkLD5NBwFS0IKS261nWksGpYut/TpSH36lcnlWfpY8Lr3X0bVUrVZ4IxGVoZUQFdXk2xN/0DZLxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8427

> On Tue, Nov 11, 2025 at 06:00:55PM +0800, Wei Fang wrote:
> > The struct fec_enet_priv_txrx_info has three members: offset, page and
> > skb. The offset is only initialized in the driver and is not used, and
>=20
> the skb is never initialized and used in the driver. The both will not be=
 used in the
> future, Therefore, replace struct fec_enet_priv_txrx_info directly with s=
truct
> page.
>=20
> > we can see that it likely will not be used in the future. The skb is
> > never initialized and used in the driver. Therefore, struct
> > fec_enet_priv_txrx_info can be directly replaced by struct page.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/fec.h      |  8 +-------
> >  drivers/net/ethernet/freescale/fec_main.c | 11 +++++------
> >  2 files changed, 6 insertions(+), 13 deletions(-)
> >
> ...
> >
> > @@ -1834,7 +1833,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16
> queue_id, int budget)
> >  		ndev->stats.rx_bytes +=3D pkt_len;
> >
> >  		index =3D fec_enet_get_bd_index(bdp, &rxq->bd);
> > -		page =3D rxq->rx_skb_info[index].page;
> > +		page =3D rxq->rx_buf[index];
> >  		cbd_bufaddr =3D bdp->cbd_bufaddr;
> >  		if (fec_enet_update_cbd(rxq, bdp, index)) {
> >  			ndev->stats.rx_dropped++;
> > @@ -3309,7 +3308,8 @@ static void fec_enet_free_buffers(struct net_devi=
ce
> *ndev)
> >  	for (q =3D 0; q < fep->num_rx_queues; q++) {
> >  		rxq =3D fep->rx_queue[q];
> >  		for (i =3D 0; i < rxq->bd.ring_size; i++)
> > -			page_pool_put_full_page(rxq->page_pool,
> rxq->rx_skb_info[i].page, false);
> > +			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
> > +						false);
>=20
> move to previous line.

The line should no more than 80 characters


