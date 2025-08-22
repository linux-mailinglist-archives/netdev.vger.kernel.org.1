Return-Path: <netdev+bounces-215946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1942B3110F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BFB1CE785E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6257727E05E;
	Fri, 22 Aug 2025 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X/5oPIr1"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27F265CC0;
	Fri, 22 Aug 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849697; cv=fail; b=aVe4ok9QPnzN0JXK9zgoarEpMt/GsFofz0GtWlLpICDaNtVZiJDId9YsGIukO3Gc+w0jdvrvmUePEUsLlHasCwjSmDCEW2jbM1Ylin/63HzRLfV4rbpSu08Ez4NH+nFn4lr6xsEYp0m4/H3vBeHNMqNIfH6bZ9YxjL3FNjsm0lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849697; c=relaxed/simple;
	bh=dMveLp3XVnK25uIa/qXhn961mWeJd8lgwBBuCx2aLgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nmtPkezYVHiTwlH0rKi22gEHdy8+VMwlqweY7JmlqA3AXy0r4OzDLHjGwYdy7eSAIsFwYUx5Yl1ltZdU0YZkCtS0Ghw/M8MwHufEfJ9si1werkE0HnhumDNM90d8jWct/AVe8tZJJ9UHbH+OxnwVhijepGsmbyplJ0ypt4TOSyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X/5oPIr1; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q90QSkkfUppEiRDHHfHI3PgQKUkxpYK066BfnJvrTU1P1ujWXaOvVT5iQ617QPrh6XsqIoYtOa1vuieeEdREcXYkT1+iHFTjFoG9SbeN20lk/1mDdKPUnMSdErZnX6pQA4+g+so25c5f1ey4NMyRuZnz67iN3pk61CozTyodg9+8NNg0KnL36s4DF1cDNkpQA5ZhCPoHGh2XPDIgzFAmx6cjRkyw80A8N3viDCfG1LC6lywzasvka4dtAuM8HAUhVuBX8uOy5f28/Jy0PXupOige285JscHxiBe5Z813vZOeffzNSyQeg/gwiWaxzQ5jaKDpAi+HELyUV0ljc0ckXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12+usbZTWua6D4gk6Ky1VNh/hgzfSfG69aJ8NITyd9w=;
 b=a/+P/Du/1AUaw0pRGur1BUQe9GomlrostBdPRJUQX5EFg6AUdAoNYhqCQBelqjdj2Lp8YEH2V8Vexfj8FvOBKbj3JYi1db0xh1fI58zPjONBMwZvsKA07vjt88HOM/xsX0k1Rlu9CQ5/sgSyxSFaK1y74O28BImjR78DH5ft4tW+uU0vzsBarN8CamV48uNPeW6KItoCVyNAVaKAHry2h5OFysig5x9k4MB2oqcYPCdm3J8U4OOcl9Q9O2LVcbJ6k4BLHlL3mgM8Ji0+KrkdQDwv2TPUblhQmMOX0X9BdmuM4AIXRcnczWdtaCCEdXzKJADwmNmPJtGvdDAXEVplyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12+usbZTWua6D4gk6Ky1VNh/hgzfSfG69aJ8NITyd9w=;
 b=X/5oPIr1AfdsyErbNs6re1jVLxWfVHnYcoRu6c3U/PJgNbrO6V1MOWjIdvaGFAd6C71UulOTMwR9pmoX6A3RCSnPM20ZpAAULdPnQGVXQP0jg0Emo06uOVJeItil9U8CoTNuTnvVQ+sIHgLbl50c4wn8rm2iOtNx+zAmS4w4aHzMfp+NFtJXX4qszrRbaT6mOGlQJklFYaR2XQcanzzDW2FfOa0gdbKI+YIRNECepVBcHNnGjZoLANVJ916n1fTrvE08IBCAhgdP/wKvy5xPx98/Xb0kklUmb2Zm15u/Z+giwew/b02rv0y5kn8pMtYQjGDZeN9dBAKWWKYCzkTdHQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8800.eurprd04.prod.outlook.com (2603:10a6:102:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 08:01:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Fri, 22 Aug 2025
 08:01:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Thread-Topic: [PATCH v2 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Thread-Index: AQHcEsosDvdi6ZhEpEGvdYTTxzqkT7RuTFHA
Date: Fri, 22 Aug 2025 08:01:31 +0000
Message-ID:
 <PAXPR04MB85109F9421FCC1381407232B883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-2-shenwei.wang@nxp.com>
In-Reply-To: <20250821183336.1063783-2-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8800:EE_
x-ms-office365-filtering-correlation-id: 89b695ca-33c4-4543-4dac-08dde1521b12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eYq9go6NR+JOTtV2EOvu2/lkxiV+5spgQvaCXVGBaGzUB+neH4+VQQCYRHNd?=
 =?us-ascii?Q?yvYwDLjcvJ/BN7vJYbTfxbzyspehdAmhjWLvZf/8PVMlDlibFHCNxaDwSned?=
 =?us-ascii?Q?+CFLdnIyEt8tiQ7igtN6a4N8cWHdjARNK6GS1J4oi0xqOW5IvOM9PAbAP2oa?=
 =?us-ascii?Q?Nx46529/+ge77htx7/g5J5JPOsEHgK2kGMTd4oCGqxpfwjkXLbIcGTZ9qBfV?=
 =?us-ascii?Q?wRxtyufV4tlnI5MfCS7IO7B3Q6L5Q24OX6K0JFE4cOH915lo0l1lpCP6w9zx?=
 =?us-ascii?Q?OnrFCmqSTHts9Iy81TOtOD33IlhIB+JpobjYiLhKNr7cHYwQoyPHbZLgbhXK?=
 =?us-ascii?Q?ZSwRdsEM88nq3aJJmlGhEoc8WQQUIcG9pixcNEhzzxYO++Bb7Sp0hU8EH5aJ?=
 =?us-ascii?Q?EEKEZEppjwVgpwEVmFgxkFMUn6Q40JAUopYNAiNzuUROl8m5Ni1G875jxWXE?=
 =?us-ascii?Q?HDiqmtZWdj1AzG5tzF/kmVU7X9mNk35UhfY+pvpvYpWaE2LUqpA77KQqUYnI?=
 =?us-ascii?Q?/jFzpeosH3D0BA+gRrSp6h6JRNMxFEWS/e7TSkk4myCpOTrfg3GcI2b5VWQt?=
 =?us-ascii?Q?GgaINs7GhiRVTcPyxaj9zJCmCvClwFPxw6XdAB4ihuTihxf04JFpbeXvEwCI?=
 =?us-ascii?Q?NPfOR/EJweenGtslRd+RIrBYGft+9OvzrWYv1KCCo2MS7IUQMWrHodJZSDAH?=
 =?us-ascii?Q?p7PXisYkdEZ3XHACcD+KVYBIoOX15vEGUfBCil/4U4o0YjrXmW4yBZiWL6B5?=
 =?us-ascii?Q?Y63Ydcf+6hBf/1rX4TtJ/+ikwrrkJyI36V73oUZPw6mNsJuKcjZ+VnidL+lR?=
 =?us-ascii?Q?/M+oX+dD8lOoSYU5iflDshk4Nccu0RKNzwkkCMvq1jk4zkEes3y8jd35+YZ8?=
 =?us-ascii?Q?I4zKHfSqpSAlmsKsFZ6yDb2seJdd0ZHNnETSNkWP/Q1juDTvvnE6kMYEnwNs?=
 =?us-ascii?Q?UPUWUl+VhYvs1borYi/kyTdrTERghV9kN25FYal2fc7Dd4bsYDyy1yQSLRtx?=
 =?us-ascii?Q?8pW0q/RbmBZFYm17uC9Q8iSDe2jdtPz0YowU4RmtUfAKlATNretKvPgm6lbd?=
 =?us-ascii?Q?jR9ezbOoGXLrXwp1TcGmth0hDBb8MNSiRka6Keg3WlQUbbw6PDOblZMSFRiG?=
 =?us-ascii?Q?Bd3xvOAafagYyhxvrqvZ5CDaiqAph21zoJMxYWjt8+//AxLUFyyK6tdWJlXo?=
 =?us-ascii?Q?tG6puE3MgVZK759h/BUdVVOc3kBG9Bnl0PRxlL6FJYO9isH5v6tLMya5sqFB?=
 =?us-ascii?Q?pZ3lbPrtIXInPu13ne+oTUicp/ZW79f3nA6a7PkXoLJzgN9s6admUtatXbtn?=
 =?us-ascii?Q?xMk5C6w4pAFT5ChwnzrKJWpzNfrgYhgWdLt6kXyaNl+bb2wvbn+fjZt+RuU5?=
 =?us-ascii?Q?2ndl5+QDcBpHRZomQve+/FpaeNyR+Wvj/Lb/N4CxhgMsWOEKBHqnkyuZu/ia?=
 =?us-ascii?Q?tyJOo2QGvs8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qfIob5QG39AQwFUpGCsjx2Yq7uMzKJTUT422YibSaohnPOKSf3RdPEvSk2a+?=
 =?us-ascii?Q?eA6cPQn9J3bJc0V/jc9nRbo6JdjjnW5X3UObOGp5UqAJSVIXQFUP1KNrJMD4?=
 =?us-ascii?Q?i77VS0dPTBJKajOkC6vbTp6d5G2zXTZW5ubYNhxGE/H0y/1dppwLwerOOYYb?=
 =?us-ascii?Q?P3YFWgnpZv2c/eXghAowGT6wJhnBLZ2d8sbjfEldgnqwoG/vc28LV4uRmMQE?=
 =?us-ascii?Q?alyhalmQsp29zq83omM+QiiHXjRtXlXpIrkVqu0NgT8HgtnZvy/ctpI3644s?=
 =?us-ascii?Q?6MKAgPghTeDY+Vh7pwlRpIXoT2KrfG9Lh1sLVmBfGQkSokn48+lFiJDM5uDo?=
 =?us-ascii?Q?d7ElAVPIHSTT+Z4EJyzhbL5CnEl55EIj9VUliQKu/wdtTqLWcsivs2OZh0Y6?=
 =?us-ascii?Q?qrGJ4dKOn9NufphzN750LpCkTbGgSFDjFtfi4a0UBbizV7kYgEG3EoTiQWZp?=
 =?us-ascii?Q?TU4ZBpfr7o3Eb5PAFRxMi9dVtVGgrNl+iiudaFDGdU/rtwZj8CKoaApakT6d?=
 =?us-ascii?Q?xpO1Mdtr69hI2U5TA1cDmmmotmELkwwJ3yaPgCEm2ngWY3ZgG0Gr6KqgLEZy?=
 =?us-ascii?Q?xhjmDA2/ApVlFl1Rslkrlo4VjnfOpCxOfxmXSE/AV1rFcYmIiPWN5VhfRTFI?=
 =?us-ascii?Q?+x/ZVCH32w8x7OGUmE+2HxceIvuEVSxhF92HTUDbire8+5F3HFZaoLWzkyc9?=
 =?us-ascii?Q?Y4NxhO0777Jfn2M1TF8ZRRFicH+Tlnqa+L0x+NSCppUR9ocRA//WRDJzFXYr?=
 =?us-ascii?Q?vh0NfZkLuJv3NXeRWfEXOyiH0IjB9pSH3z2rq9nBKR6d5pw4iR8sxFlh+cbd?=
 =?us-ascii?Q?dpS1piS9/s8/xEru9rrfHmEccnMKkAs9QVIyR7fztK+hEkvfe+Rz35e1QWI2?=
 =?us-ascii?Q?uu7x/A4WIPR81KDWSi4iUQsJAQ+wcnvjkfBvubUDcLDfLZ0ZksiI4DwX6x5I?=
 =?us-ascii?Q?wo5senM0exr4loeavC09KFeRUF3/77NFJfEf1ZLcb+yah6VJx2SXGybJnKhG?=
 =?us-ascii?Q?HqoCkggWtw5A2R/1DqV9vUffbPSxeBhk1cRELEJmG/gjA9ZhXnTwjdlm+FKr?=
 =?us-ascii?Q?vree9pbo4CKH81xr1l2/mqmRJtADi8BDFSKu3AbK4A0cAoOtkPROZui7rZv8?=
 =?us-ascii?Q?bblUrjmKtyaEYQcLcuCDgnmB2bwF/uiZr0ThkR2AecX3mmDYW5/ColLAvyVQ?=
 =?us-ascii?Q?0OunoI2W/4hOyWYMbwai80gP2nt26pijHZrQg9VgJqZZoNnpx/Mvx6eQhXkf?=
 =?us-ascii?Q?HcCjPk2xguYFM90FUWumpj16VTtUxDwAWFuF1hjztdiAZ9V7jr8hoQWdRgBR?=
 =?us-ascii?Q?pfVSmglGnU6MCjVJiKnWutL8VtwpaxZryh2+5+78dKyXBQKXs2/XGWlfRY+o?=
 =?us-ascii?Q?jD68VLFscHZCCjrVFqgGgatVnbOj0IOI53Y4YxQEdNCs19D7BZvzbP1RF/8n?=
 =?us-ascii?Q?IR6FAtgQ9uPGx6TJLhpbDwFdUfO8q4YG5Xe4iClrr9e3T2XIBVofEVuaRrL7?=
 =?us-ascii?Q?FrGN/8F53N4Bnoto1N8EjR9KNESJyFXbfjvtnhwah4mZEWn7nbk3sUDZPF6X?=
 =?us-ascii?Q?pb9K2/Ae4Co8mcvfDRk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b695ca-33c4-4543-4dac-08dde1521b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 08:01:31.3849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qL7PtnsV0AHioiUip7/AzAKPN3gLbWIy22SctBT3TqDYAm0knwZmi4y5bRFW5xzAQKrTOW2WHY1t1Kw4cT6Y1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8800

>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
> -	u32 rcntl =3D OPT_FRAME_SIZE | FEC_RCR_MII;
> +	u32 rcntl =3D FEC_RCR_MII;

nit: move this line under 'u32 ecntl =3D FEC_ECR_ETHEREN;'
see https://elixir.bootlin.com/linux/v6.17-rc2/source/Documentation/process=
/maintainer-netdev.rst#L368

>  	u32 ecntl =3D FEC_ECR_ETHEREN;
>=20
> +	if (fep->max_buf_size =3D=3D OPT_FRAME_SIZE)

fep->max_buf_size =3D PKT_MAXBUF_SIZE;
#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)

So fep->max_buf_size will never be equal to OPT_FRAME_SIZE,
so always take the false branch.

> +		rcntl |=3D (fep->max_buf_size << 16);

nit: the parentheses are unnecessary


