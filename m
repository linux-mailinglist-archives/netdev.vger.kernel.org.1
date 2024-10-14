Return-Path: <netdev+bounces-135278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EBE99D55C
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 19:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E6D1F220B8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85D1C1ADB;
	Mon, 14 Oct 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NUZK0v9e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D741BFE01;
	Mon, 14 Oct 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925982; cv=fail; b=EK8kZXBMr7kmMuakB1k69gmRz4xMj92BeZpjcSUm2JIsaKPaZ4J3PEh1ASaKo1aOev1KffHwRGW3wzEUnRF//ALMqDDSoQ2pQd7mUt8Ku1a+w1BWfrI+EFTyq9jR3Cb/lvIX7gZSXKfZklydXex555vR9Puk/IEhu1sHBIQYaD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925982; c=relaxed/simple;
	bh=eA8H/ylNVKK2NTRP9EAvyMfoIDxM2sZkLhmhLwlu/Ow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tMoM/SxJjIULCe6BN9F6Zr1dxZjbkvwFe49qNBJoQV5EsqBoUfmMClPQuATljlVhN9XzhKjvSa4z48L3BC3trIudhX30wRzVJ3Sykpqe4p2ZU4keE0K1nD595DGM9fGVJ0XfC8K9SPyzFSbyEWiAWP9RrznZnjXcPDrcT42ZoFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NUZK0v9e; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM9IteSCY3ADUOT2+454tI9B32AVvG034qBjG33Ohphsz+HY/vUgsNYIbCfhhNfCrdTKiLWvgrU7dWuJXbHZQ+L9bKrV/oQlP457WzEumIqvVHeWuLoFhzPP1ecSGVJs/fDIJ5j8jpytls1mebwDafc9HQLYaiLBBng9lEyRrFX/h/rNqlTh7xn2RFkOPiQOE/786/EQlrItvcP9TvW6JY+vZzVuA6Af0pbHEBDgP83Xb1y7TYgFtSHl9ZwaG0qBWCQZNRNM/3WGSj/Cdg15d8DmbQwtXBb/gLw8DX7rgxaecQ3aEJdI5sIFjSq6nY0yY1m3PKC5nKWKbqwmFbU+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk3pMu6RyHar7sAQzKTrfMz0/UJAdD29/xIrUNMvE7E=;
 b=DapgNt17FV3r9iA3/PHmRkidnq3OnH4kKRZLpc4ksy7rfGzRAtFHTmEfM7Aksdje2RaFlLDLH2Pi+tiXh9ruLLOc2jTJNbSj1DUl1s+O1M7d2g0k/FaRHHBiEd+1Uqg8PuWSnWlRzC0OdCL4p08m/XZ0JwaEFKQAVfus8h3duAGFrer5gHnONP4JQHN0t3OnYAwsEMePonsr8SunAAtd8XAnoC8aoCP0XRfHXq6wn4nlUm9RWpl9VuGigcbB+q9HzGtll4TybfJU4uZ7Nfb/LdK7n5OI6//JvG9P7NyyVzrxwVyfBxp6NZqqHil1CcUoEewyW+nVzNmCoSRWbFRPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk3pMu6RyHar7sAQzKTrfMz0/UJAdD29/xIrUNMvE7E=;
 b=NUZK0v9e26J/0wRiejxd+SVJROOLXmqPYaa711rwwKPxm7V5TZpXGxellQ7fRGkipPp1aeSne0i8WOfbnivj3beGJwxhIhdrg0nm5AigAUq2/yEPYsOpMFBgM6irr2AqJoBBBOGQc3UztCmHDfWBp5uQMpa53VDCBUFezTS8Vjk=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 17:12:57 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:12:57 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Wang Hai <wanghai38@huawei.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>, "andre.przywara@arm.com"
	<andre.przywara@arm.com>, "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: xilinx: axienet: fix potential memory leak in
 axienet_start_xmit()
Thread-Topic: [PATCH net] net: xilinx: axienet: fix potential memory leak in
 axienet_start_xmit()
Thread-Index: AQHbHkaYeBvvgUdiTkaIdTH+PJICqLKGe/Jw
Date: Mon, 14 Oct 2024 17:12:57 +0000
Message-ID:
 <MN0PR12MB5953A4A57874ED62F088D575B7442@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20241014143704.31938-1-wanghai38@huawei.com>
In-Reply-To: <20241014143704.31938-1-wanghai38@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CYXPR12MB9317:EE_
x-ms-office365-filtering-correlation-id: 624bc3d3-e5a9-4270-fc05-08dcec73731e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HM5nWlB7ohk6+ndEcHaPDyx0bg73I8F/2bYaoEUVBH+0OV7buZw0O4rcehtk?=
 =?us-ascii?Q?mwccl6sNQnJ5tZLYegYwZMBmq5LR0tP3WKex7bU9zgTqneNKSTglMCSXYlxZ?=
 =?us-ascii?Q?py4Y33UIQnfykypzg5tCu2cc5mZ2yNva6nSsTUcVaKVFLLSXyDGJbx14DAqx?=
 =?us-ascii?Q?1zGlaWQ3NX9tE4gURVqK18/kZ1FVDls67Dd5j59dUCG6+S5k+zqy/Jn/9O68?=
 =?us-ascii?Q?4jiVAWzQzJADpsn4fL26DbtONBqNuCbDU48MU58fOAXMKIuqdAESCuotQVPC?=
 =?us-ascii?Q?nS6AMc/gF/O4mVCmW+cS6qNx6hBt6Llrc34KnDipe4Y204+qBAAab5zS+WZq?=
 =?us-ascii?Q?bAZCYcOU/EMNpN2Kn1bGMH70enxihh+Pbs0t4y7ZY4PmRBXoStslxW+7wBqc?=
 =?us-ascii?Q?ZeAhCqhtPfy+XSy9ot3PmCi3qf53zDTwd1h/dke0rKxtZbrr5lUw0Ta0FN5I?=
 =?us-ascii?Q?sx3X5Q0/HhJt70oOJaJX9ufxtzaTS9JHWA8RuM21L1o9On5SPWO6IMV0xZ39?=
 =?us-ascii?Q?EHws7892XuKlFHx5AEZHnUnbbmpqhxNlbNf0m14O8I1F2b2MfWGr3FVb4ZXc?=
 =?us-ascii?Q?ufkknF1e/bC9FW3rjn7FQOrLbgp2i+VhHJ0xroiEsELQoJbHWoOIT4vCVdnU?=
 =?us-ascii?Q?4o2liHbRdXVgptfau+IbFjEC6KWIhJaY2AafLEn+gsezVGirPpCRE1PkOo7R?=
 =?us-ascii?Q?sgECDPuSLMU0OWpyREC9/K9kOOncQGBYvrqKIIwDOuZqKJW2tRGqPepZuKyC?=
 =?us-ascii?Q?ZG4+XcM36hoath3CO+ldLXzOHOr64viDDvXCTtWinl8pbcKxzqMCmc1hbrMm?=
 =?us-ascii?Q?5HDrj3g5g19/hCaSg8PKbQWpalmrjH1UY3ULHEEOVXdxlghO6J2rVoRun8r9?=
 =?us-ascii?Q?leWZEtRuM7obFPklsZ+trNZ4hqhLZTUu2aBXyEpUkEFVQvyEuPHdH8wxUvSO?=
 =?us-ascii?Q?9wut6m5PrygB2yOAXB6SJ3TCJd+dxah2rSoYbbRGfCwngU9WL1DKSubmLrNm?=
 =?us-ascii?Q?uwaIY0Yl/X67TcztIGhVSguHDJqbfJRpag9IDDZYY6OiANUii5s/T1n6jeMp?=
 =?us-ascii?Q?I8fjm+NL21nC7i+SGBEyqhG7XFvKXGFn1QwkHUS3PypKamVwpowdLb8eOFxb?=
 =?us-ascii?Q?gHBt74d76cplL46W697MpSgsJ72k4b63VdTQkkxrroOE3vIMPX/RO5xtVHbr?=
 =?us-ascii?Q?cFpiYWI/DTdiECp9xDKBZkMkshudklnyB9U50IBl8a9kXg+AeCVFh5OOH2bL?=
 =?us-ascii?Q?aks1rubDHNFl7dH5dmCrkLxFOpE8j7fp2myVjEvYMRi8XKRhb22fzvOl2bGW?=
 =?us-ascii?Q?jv0aFeBiEXrdJBmVsjGknWR43ISU7kQCO61+KyHD7GhfrQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QtQReiMOoJLHcwpFd60TAanWQXd9jb4+IYpbJnLlAHaL20y1nc3WhT6nahE6?=
 =?us-ascii?Q?BR/Sv06iX/sbQ8aQk7Tqk9F9yUZ1xlpAdpF5TEIDlWH3PHph/T4Es6udtYKF?=
 =?us-ascii?Q?zEFFnjbo8OD6D+0XY3Dl1NfFAg3qsRLJOq57rUtQfF+8sNgtdX1QD44I8P4O?=
 =?us-ascii?Q?0bsVB+TyMv0WIBPFttYGqrb3WpcO1dQvsXysveO/yKDiuqxBLJlX2qpGAPfn?=
 =?us-ascii?Q?jyvLS+y5j7mgKlNI9Hpi1jJMlR+LRQageva+5DsjLAqvvi5fGgaEZ0Dp+tCE?=
 =?us-ascii?Q?WmspCdiWEeHdHx/Q5Tt991QCwjpxobNrokCaWY6Er8+NyZ56gZdkjopx5frP?=
 =?us-ascii?Q?3pxBhap1aI3YpIF7Y7qHdBLA1Nr3IC6O5V+W7WdTbh3EgF1D911GJ0AkXCET?=
 =?us-ascii?Q?NKHYOAeDoBzHkLmixGg0HmPDW2LwihHkRUtKvUqUni0+vwQsMNsXziowkIpr?=
 =?us-ascii?Q?NtsLyCXUVwkDIvWGrc6tpbu6iI11uNckz1tD02Euf9gkMBoldRYxUdfvyPgI?=
 =?us-ascii?Q?W5TPYaCqx3oMTsD8jRibh+hdieS57gOD+nwJnADiw4Uc7ShSyKf1zCkh4lsu?=
 =?us-ascii?Q?IjFuGQ7jkn+z+uD2y6WNgla1yHyYHUhNHrxUTQtiLclC82Ryprtx6e1U9ZiZ?=
 =?us-ascii?Q?QCYedo77424Nk31IScLSdK5FNWh20Com3vwXpaKc5L2tx3efP9JpHApPW98m?=
 =?us-ascii?Q?5rKCHCs70uva4/o8k/2eFUZpzXfZUn7R+vjMLXPuDkfJLv8o0aKv1g0bC4I5?=
 =?us-ascii?Q?uyoMFnn/i1Bpu7yOK7q1jw769+La6+69wJE1AAq4aJD4Ol/FtZBUjKINyemN?=
 =?us-ascii?Q?NAAGiZa3hLpxGdrx/iABU+4PbaTQS+MFcJmvYdPt89l0Ur6UVq+sX+av1FDX?=
 =?us-ascii?Q?s994iHYuglpjbji+Ln88Lq8z2SJBtPjSi3jO+7bW5mxm7o9KVOi4m0HUQt6G?=
 =?us-ascii?Q?ZohxHhl3gSmCbmyrVkRJAtX6183rMNSRTmrvWSokIEAeo2t9cfVK5IUNTMh4?=
 =?us-ascii?Q?9exQ1SSXRHlyTImugGDiyA+udZVxKiCVQMnrWWnNWr7p/R1lT2PyNRGmufbi?=
 =?us-ascii?Q?EQQGM1V1Mcxdbf/wQ3sH9Z+F8XJB/kD5MEh4vT1ciLEjqL0cXHTfOZk9NbXQ?=
 =?us-ascii?Q?MDsMMopx3r9JJf8c7Ec1L9RywgH+hi3zD580uwTPBsENlqTKWE1ParoYdwrR?=
 =?us-ascii?Q?bYXojG8xW19v5dkHrIXYiuA9Snea1hFsev/zPE8B+Td4jkPDSOf7T50NZtRN?=
 =?us-ascii?Q?hZVFisP3A+UBwdz4UXsavXFo/GoJYmVJ9UIKJoujU9FavqSUHi2XeAjbQGwZ?=
 =?us-ascii?Q?lVRyEzIAfuo9xzTxpk0DyjZr3mXC55VmXyEn22U4Mkgsi6KMCzISTTFCbiXh?=
 =?us-ascii?Q?Vz+h47whVU6kxw11ltOccvuTxBHmuQnWIrAobw+Ug2EFJvxyOGCNIwhh2HV3?=
 =?us-ascii?Q?/UxJUHbzRxY34fSpP20l9pH8bGnuUF3ghRt38H6KxQSD/Da0i9RSkqyF5Zkj?=
 =?us-ascii?Q?dOPrCo6cIAWapLCYGxe/RgfFY06Bt4R6r1P6I+A7pkZLURRgH4RypUC15xE2?=
 =?us-ascii?Q?kK3lgqr3SkWdsUgRfyQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 624bc3d3-e5a9-4270-fc05-08dcec73731e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 17:12:57.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMtsZEM4T2DA1FeWfiWGHPhSVrRFoq/DNO/+uXIdG98o34hUsdozlIiVPGuvGAen
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317

> -----Original Message-----
> From: Wang Hai <wanghai38@huawei.com>
> Sent: Monday, October 14, 2024 8:07 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> andre.przywara@arm.com; zhangxiaoxu5@huawei.com
> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; wanghai38@huawei.com
> Subject: [PATCH net] net: xilinx: axienet: fix potential memory leak in
> axienet_start_xmit()
>=20
> The axienet_start_xmit() returns NETDEV_TX_OK without freeing skb in case=
 of
> dma_map_single() fails, add dev_kfree_skb_any() to fix it.
>=20
> Fixes: 71791dc8bdea ("net: axienet: Check for DMA mapping errors")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index ea7d7c03f48e..53cf1a927278 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1046,6 +1046,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_=
device
> *ndev)
>  		if (net_ratelimit())
>  			netdev_err(ndev, "TX DMA mapping error\n");
>  		ndev->stats.tx_dropped++;
> +		dev_kfree_skb_any(skb);
>  		return NETDEV_TX_OK;
>  	}
>  	desc_set_phys_addr(lp, phys, cur_p);
> @@ -1066,6 +1067,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_=
device
> *ndev)
>  			ndev->stats.tx_dropped++;
>  			axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
>  					      true, NULL, 0);
> +			dev_kfree_skb_any(skb);
>  			return NETDEV_TX_OK;
>  		}
>  		desc_set_phys_addr(lp, phys, cur_p);
> --
> 2.17.1


