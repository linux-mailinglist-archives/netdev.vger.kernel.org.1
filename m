Return-Path: <netdev+bounces-218619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EAEB3DA48
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92924176635
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490C525A341;
	Mon,  1 Sep 2025 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LefTvYEP"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D3925A2B4;
	Mon,  1 Sep 2025 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709558; cv=fail; b=jr41VduzZ4oUa73sx2C628tID7Jh28k10EMrdkB0YgsCmgRfap0+7IGzM0qravdPZn3CcISJ/lOyG2jH6twBUmrb/KKhQQ46C98xIDNhye7ebqwZJME6xy0cusIwnZFMM0U7dqEow6168QSnXSYEpBxO58SJjxl4giVGwsmBJuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709558; c=relaxed/simple;
	bh=QetNiMAtg9q1l057AiteiLCJPY/5al+Ly3fPIWDCAOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SoEHUvlsj4e4ucLMxSc13V1Kyp1FYTfUMuyLjobfUyUW6FykbvBwxkcPEPxmCz1x4IQ7Zp9LtGeLQE3cZZepVJw2vBbf4nnCGsIn99+0MxHS7Rqc6ii7/S7W311zg2XPxIyX0Y5OZYoULNQOp6EKQdRJxe+1jmFLq5bEAfap0t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LefTvYEP; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/iPWeihjl4VaAooUKhin/olXL0cx6p3CKSZ0HE15QWiWIerH3ISqvJbTYmEl0KO0rm51no74UPS1DbSHKUrWNg/pNIcV0HTfzF8eLAlSSMbKSa0f4nyjwr1X3yMgLnjnbzR3OEupIreuaOYL5he4bKsUkyNkCcr1/7s8xZ3aPS/kMjIsKiAFTzVZFq6QurPc3fA8GboNnpQAK7RCHDa0cicP6pmgzT0tCt+jWIwh/9t/NBERnLKEKXsByEAaLEJLnlIMj06sqG/pOtSH7K1qgA9E+WwIFAC2nI4x3d8/y86Xvtbgt+DdmwCL1nzbzfBv61eokruHeeVTcRVuEH55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFpS1m69EZ1TYV43OBH3ZZrXc5fZn0963VQDVK6DvYQ=;
 b=k1so3BZ9uoNBId9cBERKPpo2PKMSLamidAzoxq2Dph+kE37+/yXfFTczNw58Mm+Po88owWoa2ee+V4Dz2o3AGr30HAVeQsDW+nPx4mytkWcC5WS5tmOBzt1naTXRXaSix2fPAUQvmv/n+SsTfHuN6iVetf3GHFldKZa5SwW+I+XeBkFDi178QGfHnNcMpivqDILNfwVrB0DrzMab+EIz1/e5Lplz/70FYQ0P9Jt8YlDX10blWeRMlTPtM2CENii6v8TztG5RLGIIBh7765lHK80OMXQref8VnxNmqSnYUdBZnrz4aRTAvcHPq54RTqp0EHug5WE5knfesourfTg9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFpS1m69EZ1TYV43OBH3ZZrXc5fZn0963VQDVK6DvYQ=;
 b=LefTvYEPgE4H7BbasXyLEHYT7eHDY21DAnU/h7ctZ6AJJ90rLTv2Lh/UHgxP6F70pE/h0quyRcU7t8WmziFHWwLIPJqHbG/4ChaJcFdaLUHpUQqpeFJmwha+KK241k+ZJhFz/sZ+e0YLiW9cwCeh0fk71E+oFGW8e0u63BGysduL1q7hmPQG0UgxVoRBtDHnHYlsZpB1vmeybOQwRfBF4ONe4fPPbyOX31BvYsoaYYH3l6DuheYM8XO/XF2tglx4ZnC1RbADIY9bXnMTOyrOL8AjyziwJt/jVcpdIWLlAKvijIpZ2680e7itu9094QiEUqcXSkyN2rJEb1i7PcS/RQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 1 Sep
 2025 06:52:33 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 06:52:32 +0000
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
Subject: RE: [PATCH v4 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v4 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcGryO+DVqxyerjU+TUjsu8Hl/y7R9k3vw
Date: Mon, 1 Sep 2025 06:52:32 +0000
Message-ID:
 <PAXPR04MB8510EA7CD915DE9340303B0F8807A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250831211557.190141-1-shenwei.wang@nxp.com>
 <20250831211557.190141-5-shenwei.wang@nxp.com>
In-Reply-To: <20250831211557.190141-5-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8491:EE_
x-ms-office365-filtering-correlation-id: bcd1c15d-84ae-48d2-b16f-08dde9242070
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q5EzMFZLISGDuQJ8nlp52c+e/IS7f59enrocbBZdplVOtUXRmHqEIA44+gp9?=
 =?us-ascii?Q?AjFKF815P6qYqyn8Vs7HFm3MezlQvpcFptv/z/TQZGYGmJfE5xIkSwQzeqLZ?=
 =?us-ascii?Q?Ahb86HwShG8pArMj4u1lCdCCs6/pPbz3u2Kuf8Tc+fz9fBZ0IyaZZ/r8V1/f?=
 =?us-ascii?Q?XYtZsdusQXdIRbpuUH0SRk6U3//yGO2GXtNzh3Brg0XlccDOmumCtkbsUOOj?=
 =?us-ascii?Q?kRJgkMKtHJsEXVUfTyDCX2LPxcF0KBDUpqG+UuwmTlAtPMK2/JTvcf+Pu9CO?=
 =?us-ascii?Q?cXQad12Jzji7BuHBO5HNaOC9AZPFs8qw205BSxPa/kzt9J/TqxCdrop0TzlD?=
 =?us-ascii?Q?RaJLy4KYpotUZOcvP/vSPnzOAwqFza7/27XsMCCb/zo4+B45zp2xRGqbn0FY?=
 =?us-ascii?Q?+4UFa8Ew27snukSbB1EQ8h0bAHBpBTz/iSnVicEUysg7sxhU41dKZNLUUXCR?=
 =?us-ascii?Q?VS2aJXupdKDakvPakUe73URajx5jm84i9IOgHCq82SbAGbpmYbH7dT9xjdXF?=
 =?us-ascii?Q?SVPcq67waodRnffrz4c/g+bO/aGS3mgrogQi2svNEAqX8UQ4Wm1tg80AFMAd?=
 =?us-ascii?Q?s3ffRxmWT3m1pFz7sjrak+km3KxBOrQY2WgTDlnvWVELnAy7VLhGlYGkG0ou?=
 =?us-ascii?Q?0SP8AyYxuwxLVIuCVTUMDrrCY/argAqjxu/bdPbaU1DuCORhOqE7S+7J50Sw?=
 =?us-ascii?Q?NuQA3aCAJnx1faJ/owgnRm7PHBAyk4MDjcks4hqXTJh5N2yHD0vVseZ0h+MR?=
 =?us-ascii?Q?2XoS45okqPrli44PegHqcxyt1+cqBfq9ijuu7nlcJQjUhsj+Hjs7PtInfMhg?=
 =?us-ascii?Q?yDzDvzvPWq9fmuYy/2KiJsqaPBifc4mdafMfwXusw3LYgS4ioxDMIxkAjM7C?=
 =?us-ascii?Q?Com7VxU07dk+Q1AFCKrZ8t7s4261fTZ3PP0LczS0KGoZjC3vO43vai05rYV5?=
 =?us-ascii?Q?n4MSnFZeIfI1e76e1HieV7ffLItiI/1ibyD5JHjq+6Pp4+lzJEQi9ToShtpR?=
 =?us-ascii?Q?pCpl4e5f67DL/6tMA5sDy5dZeVqt3z2HsDl4KfJqqUuLKhMqyr0E0m1zZkXg?=
 =?us-ascii?Q?QdeM/i8vU49YPr1D7qcV1OjCfeDdK/t2Xnccqq12xet/kDK5BOeQCivNr3nd?=
 =?us-ascii?Q?GdSKFy4KKsJXtJnXeA9phTnSsDla0YvpjcmF8ZJ7GFI5j23xSSIdrMLjkZge?=
 =?us-ascii?Q?TEySuL/d5Qf9pcEWYjo10twkt4yC1YirMyLihr86zcW01+GhbAxiFjdedrVq?=
 =?us-ascii?Q?x+wNHvCmyLva6yHl7MIrr7KF4cfZRjTLcXfNnS9MtqlSi0Vbk3gEo1rphF5L?=
 =?us-ascii?Q?6fHWYgy6LxO4o5vcjTTjRC+BM/AKexzVRjZoIiFO3Z1gnR7e9d3yC/rfzrDG?=
 =?us-ascii?Q?ZvF4WC76lVRxfkad2mHAjz9vScxovUBibx7mE253k21wcuD+y8OL5A+d73ql?=
 =?us-ascii?Q?IKBk1vI6QyP79UQ0tW0XwFtEXzM5WbAxnKNYOICeziV23oGHMKfxOg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+knZdiGoiD+Ksw1nDTYaZMcdUAgYslRzoBKSEGrq8TwXJkucG9UArsECm0py?=
 =?us-ascii?Q?Iuyl4QtKDMDMc2Hm47rqQjEppnZeC372xjy7YV0dflSV1VAFPPjR8UZPtNPA?=
 =?us-ascii?Q?XdlInsHTq+3OkHk6U0FliFeA36B4yJO+9C5aPUBBtv8DRdmcRcVa8eqK8hV8?=
 =?us-ascii?Q?KBu8FwidDoK+jTN8fBvyCqJ3LzIHE+WCUX/4QN/ev9TJpJgvwON8nR23Zoin?=
 =?us-ascii?Q?Ys/zLCANoc2VKjLrsmoAkmgv60x4W8Bur5S/YhJjdi/mkfhsriflKKGXGy6A?=
 =?us-ascii?Q?nYgBS3PL44NjKRyhiO1YTpxlfrCgu3CuTEIOGTGzfr40+/Y1PCIxQD/FXmYG?=
 =?us-ascii?Q?ubnlSHu1Rkg6JxE/rDLWouCkUsP9msu9aVWue9LSkcFLiJvgVbx3WDwl9rd6?=
 =?us-ascii?Q?JyjAIUr1dm0XUPWaBALrkGP1iVFC68+q5ItkanLvCjq3ScnnzYV0AtJ1yPz9?=
 =?us-ascii?Q?3KN4umc011SgoCAZsGU8MWaHlFZ9CdAn9kO3IJ9krw3mqiIm5Z7Sfwn3mcVu?=
 =?us-ascii?Q?RVbAZlGpvXk8CleDAwSEn+M+A8LeryUvS4A4lCLp8CyfFmaMcItOXPpS3SBm?=
 =?us-ascii?Q?URb3JBb3Caky6FpgT0+S5L4mz/4Cd95UuhWvJBcJLeFmU4ZB2Sbx9kHYpNdj?=
 =?us-ascii?Q?+AHcHZH0afy1VZfpDg4V1bVVLfq9bGawnO0/MUHo+7X133fabYgrrybkHxUY?=
 =?us-ascii?Q?ebyCUKaHKoyn0Hzu/RsShStBLpWlqqv6RVfAE3Wbnbsjb++n62+XNLnQ7n03?=
 =?us-ascii?Q?cW0N9cpSE5MFZZg5S99vRzbe6u2hpc4oyNM2W8l6yv5nU3uttJAwa+klIlxh?=
 =?us-ascii?Q?Dg9KpE12z7EWbd6MOrUbWRIC+O6a286KEbxqLkZnIy4U3jkaVtYMU4bbFvpV?=
 =?us-ascii?Q?Vx6QBFz0MJiMkJBZeXRLZd6UhN/roqz0Q8hHJ/2qyt5asXR1YHcsyblH0fyN?=
 =?us-ascii?Q?AuuQTLmX/3RTrXGhoc1+Qr6jhKMEsAXfbqIP+m45+jZ+vXz4sg5v9zaaJSjc?=
 =?us-ascii?Q?zbbt+CfYpnFTyERDgZhalcR3RSiTyBNlunFuisZjhBg7tsBjxof9MtI+JUtJ?=
 =?us-ascii?Q?gwpxN3ke9oPdHmZ3s1FzD5RO3uSI2D9JILJWCsYnhj/w7Gu1OlL7nFqsKdo5?=
 =?us-ascii?Q?wOsExx30jpj1bnQHCBaGgxnKmPmPHptUpzDmUm0ocpUNG7l1Tqb+rLT+vhLm?=
 =?us-ascii?Q?FZwgnjJws1rZFecFVMtKAbUPrvfD7uTh35+//ytNdI46TyJMjTijgfwl+Srh?=
 =?us-ascii?Q?Jc6Ir53dA6rKDWP18+r+A8C3RrBiBsqvMslYjPV9CpK4EROHOsupBQ0sJXmt?=
 =?us-ascii?Q?1nRojrxTeNFkNqQVObtt5KwuIBSrIbOZKlzAzzUX23wBPZ9rhSXiPCRgvMvP?=
 =?us-ascii?Q?FwlXqbRlnVaEB82l2JvUEsSZkZtY3WwOE+7yfWdYYyoX0LOCSDOprgsyrMJ/?=
 =?us-ascii?Q?57WoxZnxgNDZoxt0D6+tp03/kHljkocODAkOf6dUqeHvZT/fa0JkF48DIcvA?=
 =?us-ascii?Q?3lGAw6EgIqQmqTRiQ899dzTO9uM6vleTxj4lv779lkyuPFPDgcrXEEVdTAnD?=
 =?us-ascii?Q?ucJDqPorPQYXw2VZCWA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd1c15d-84ae-48d2-b16f-08dde9242070
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 06:52:32.8486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OT4iQdBgrchb6vUgRwRfQGHCSA70veuAUm8OZw+uH4NeS+jMysa8aS5QbDLr2R5usWoQv6pCz9aroHM48BgEXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491

>   * 2048 byte skbufs are allocated. However, alignment requirements
>   * varies between FEC variants. Worst case is 64, so round down by 64.
>   */
> +#define FEC_DRV_RESERVE_SPACE \
> +	(XDP_PACKET_HEADROOM + \
> +	 SKB_DATA_ALIGN((unsigned int)sizeof(struct skb_shared_info)))

"unsigned int" can be removed. And please move FEC_DRV_RESERVE_SPACE
to fec.h, FEC_ENET_RX_FRSIZE can be updated to
(PAGE_SIZE - FEC_DRV_RESERVE_SPACE).

> +static int fec_change_mtu(struct net_device *ndev, int new_mtu)
> +{
> +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> +	int old_mtu, old_order, old_size, order, done;
> +	int ret =3D 0;
> +
> +	order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN +
> FEC_DRV_RESERVE_SPACE);
> +	old_order =3D fep->pagepool_order;
> +	old_size =3D fep->rx_frame_size;
> +	old_mtu =3D READ_ONCE(ndev->mtu);
> +	fep->pagepool_order =3D order;
> +	fep->rx_frame_size =3D (PAGE_SIZE << order) - FEC_DRV_RESERVE_SPACE;
> +
> +	if (!netif_running(ndev)) {
> +		WRITE_ONCE(ndev->mtu, new_mtu);
> +		return 0;
> +	}
> +
> +	/* Stop TX/RX and free the buffers */
> +	napi_disable(&fep->napi);
> +	netif_tx_disable(ndev);
> +	read_poll_timeout(fec_enet_rx_napi, done, (done =3D=3D 0),
> +			  10, 1000, false, &fep->napi, 10);
> +	fec_stop(ndev);
> +
> +	WRITE_ONCE(ndev->mtu, new_mtu);
> +
> +	if (fep->pagepool_order !=3D old_order) {

If fep->pagepool_order is not changed, why need to stop TX/RX?

> +		fec_enet_free_buffers(ndev);
> +
> +		/* Create the pagepool based on the new mtu.
> +		 * Revert to the original settings if buffer
> +		 * allocation fails.
> +		 */
> +		if (fec_enet_alloc_buffers(ndev) < 0) {
> +			fep->pagepool_order =3D old_order;
> +			fep->rx_frame_size =3D old_size;
> +			WRITE_ONCE(ndev->mtu, old_mtu);
> +			fec_enet_alloc_buffers(ndev);

fec_enet_alloc_buffers() may still fail here, the best approach is to add a=
 helper
function that allocates new buffers before freeing the old ones. However, t=
his is
a complex change, so I think returning an error is sufficient for now, and =
we can
consider improving it later.


