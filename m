Return-Path: <netdev+bounces-248721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB4ED0DA55
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19C2B3009F4F
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687C1F8723;
	Sat, 10 Jan 2026 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lmzYGI3W"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012808F5B;
	Sat, 10 Jan 2026 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768069199; cv=fail; b=knCZeFBBM33lg3UBmLV9YL0+Z4REYpNxHeVXnvaDSDOamb9PmYRxY1vb2T9LG1S/EHOcJBmx6YGNsuE+jd/s6zKwArVpzBHZLGKJsLZunMisOwR0qvHwY3+p7Ca7w4BrPUMW4MVgSVlwiHtNl8SLko3Q8n4ZsJGsa9R8p8BL/5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768069199; c=relaxed/simple;
	bh=ntV088D6nHwbtlNSuhImEs8J4jJFx1IsuXTw5Z6wcEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gfhyYHAa5eJdPK7XQA3cxWz2QYPosG5tU5CYc9Ewfa9CAIQrzoHZ1uK9zs1dWvFdMPKRzaunojdN7eOuPlgWI7fmw4eKo59brdkrGLr39P5nhSTR91rUitmjLRrx5Uz6UbZLJ0j74nT5V4lnQZqcn5+IxCZfLhdOGXz27YR4qxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lmzYGI3W reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZirsLbea02JYJYhCUuHANkbI6bw0UP77aD40i+ADWS98OSOTZewYdg6w56ZE0bt5kk/U6w9qwHIxmwv9cIp/0IHPd36N7KK23xsM2gwK9P234TDfP81fYvke/NpUxGp+g+PXzNc63LgiyVC0Gg/zvM6g4CvgzEMgXWAMKwlMgEJW25i6xyrTWvclUST84Pf307CDVbfM+Nlt+ESq1UVghdjdmrncR54oGqBD2avzlLFOBnWPE8jYiQyCLu9GLeYWdMakGEmDpV4qtYV4KdtJrytPKabudZEFd+dgFgQ/Dj+mVldUFSOhEaspERthu63J0dOwiGFC4j+++ro4hwXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVmHi/j4JsZzdsCC674kGOtvAxbdwzCr/648PxHf6o8=;
 b=EYSDui6lhXQCX+fVwnwy3xCa72Gze4X+GpRLAB9EUuhv3Q6bQWjib0qRvtOxKOVDGaTwCcIFdRQf0D4JN9RkDgtX+8VLaexJqSGMH0nnP7fTBB4qK+YvyatSTViMugwcgGEV6BZP/NO9CiRch8KE4SxMq0TfRfeZEoO4lvLeaNcY1vtCIf/AsSotUD8O1+QDqnKyI/J43lk8WVdOgWyZ+5ayJmcJDiRBB4clEq4SjakQC/jqzWp/u7V4rfScDG/TpQGXKNEqCFInKjPavHyHSaHCV9cLuVUfw6Rr2MYj86+Xw7jo+w7iwCMcklbnC47VudJZPOSJMRM+NldZR+sJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVmHi/j4JsZzdsCC674kGOtvAxbdwzCr/648PxHf6o8=;
 b=lmzYGI3WLMD78u8SrucVKAXUCfB+y+VHI92jBebRFtgbRUird2/2xBDaAW9bLZxvycbgf1WuZ3H9DSYob6t4zVIdxgbI2vRAaI4MvVaADodMzJ2XPW17180OnzOLzNd9lgDYIKiT4ZhZW165fU+Ow5rW7vHaMQQKVZoZH0zOBGiX0/f9L3ZmsSorFW47JWSfVwGrFnDortNFfqsaysV521kHTskfzaxnRfuY7C3y4xZcwfwvw1gF32kZUKBx61kQAPUap98o2P/bO5jxb5UhH+6fJsRD2KNRJbSOj4+4yfUB2TyqnNNtKnXe5l16YFPuHjGiiwGaULyUR7jq6gnDDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAWPR04MB11676.eurprd04.prod.outlook.com (2603:10a6:102:50b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 18:19:55 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sat, 10 Jan 2026
 18:19:54 +0000
Date: Sat, 10 Jan 2026 20:19:50 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v2 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <20260110181950.md3iu2wekhkzrnx4@skbuf>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
 <20260103210403.438687-6-vladimir.oltean@nxp.com>
 <20260103210403.438687-1-vladimir.oltean@nxp.com>
 <20260103210403.438687-6-vladimir.oltean@nxp.com>
 <87jyxtaljn.fsf@miraculix.mork.no>
 <87jyxtaljn.fsf@miraculix.mork.no>
 <20260110180433.bfg2hxbdjkfllkiq@skbuf>
 <87zf6l49y9.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zf6l49y9.fsf@miraculix.mork.no>
X-ClientProxiedBy: VIZP296CA0025.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::15) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAWPR04MB11676:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c22335-a130-4b97-3a64-08de5074da84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?qacsf3aB2ojRVSGPrcKl3s/4qqSEjDUVY3COj291QPwliEbAM77DmZ4+7W?=
 =?iso-8859-1?Q?YfR7sd/liZFFX0P8nyDJjQustx3VoHIZYnZbr2A4jLv2Dy2Yy00qEszm0D?=
 =?iso-8859-1?Q?EJey7orccWdugxf6ewUWnhmBBbe0ZCWxzouuotfpQuXKKI1fdkDUmqpnqm?=
 =?iso-8859-1?Q?sw8/JPKw7E5Zhbnzg00A0AObO2hEvE9odTtNQP48e6evGY0mBYBKxBC2dD?=
 =?iso-8859-1?Q?b64qf1qUni8atFzAVFIqzYFnlFsCFhatah/JtS80YwULqbbA0NHpM1VEgA?=
 =?iso-8859-1?Q?2Hx1wDypNI0a3Y1xhUQB5n+lABsQKM97s1PIUEsMA9gn9J63jcceANpMmL?=
 =?iso-8859-1?Q?i215UN1g3CHnGV6hZkpQv9mvXvKbwBNF9VtLaElzZ+QFD2SnBsILwUPUz1?=
 =?iso-8859-1?Q?Xx2nOlTuWNuts/8wMTop9a292YBAXlssrA1hZilG/NLPYAMdxFJvg+gTv+?=
 =?iso-8859-1?Q?UOiwMaax93HquB3Gamggae20bQNnmeMDjxvyhFVt/5a15mAWlERVi9C4Ju?=
 =?iso-8859-1?Q?6sVBmzzLjz5nA3xFxskWT1lmRY2z3hG3N+05kPbJXvTeSTAoBsH7t1kv0v?=
 =?iso-8859-1?Q?fVAf4KTtNuwMDn3JyFGbn2pEWF5+JgftQtVZLPENwKUcRdwR4yikFKFflO?=
 =?iso-8859-1?Q?t537ep+C8P2R+w40RJ5W2xSBMxce6j6Vozg4HQC4xDlNDSbz0MBm/YCJ/H?=
 =?iso-8859-1?Q?L5VFBolohGlECRGq5nw7tiuK+jjEr1qKKjG57zJP0zVNHS8kUAy9aN8I0g?=
 =?iso-8859-1?Q?zFoF88OC/SMWLKMkkGWzjZxVdQzNtX38rdJ41RibS7Q3zs5XtiN+AXXd7k?=
 =?iso-8859-1?Q?UNE8LDMLr4EyKcFu4Ul98QySSY/sTWj+1muqt5/c2zR/l9tBgrMaYsw8M4?=
 =?iso-8859-1?Q?Bxuc+X0tEV2CksRJcrtJvV0LIus2VBRfc7vnbVpWht1Ob9+YfpuM1Fq+XR?=
 =?iso-8859-1?Q?4AnVH0TGu81X/KDf3PO+SkGC8ej8OZb0YyBym8AMz+FZOQ5ihDvCNaknvI?=
 =?iso-8859-1?Q?WZ3BhmjWVvU1yhtgFIkKSoGWHXeIzDL07NYZ/ShS3jo39STBi6ki03k2xf?=
 =?iso-8859-1?Q?2p445ZOCGcArbtq3XroVIY6Lb3gu42FdLhClAxGX1H3wcWKcuxIho7NePs?=
 =?iso-8859-1?Q?wDH8UVs5JnGBhI4z5ZE73a+jlPEsRQEKIRL79et/2XObHLgvFiD083B7Ci?=
 =?iso-8859-1?Q?4p5ZKdRYVf7SCGMcg8xhTt4YwJ78AD2qZ2weSTRQWnl4bPt01g5n9XFvQD?=
 =?iso-8859-1?Q?PMC6xtQRRRczhoepJ0TpB0O8R/O185kfKVaZVufMf9BnyEMtOwptJoI6TB?=
 =?iso-8859-1?Q?U8+EG830Yq+T20ltVMLQyWgwC3zlDRA88pA+k6ldEX8GDYZvAO1+stSMb5?=
 =?iso-8859-1?Q?W/Kap6gkY1jeHII55ovN/ABAb84LtrRnfurPP1y+GhYC0BitUhjA0U55Bz?=
 =?iso-8859-1?Q?JWKnMXE7HmnLuC/vrgJXzpN84Qxdl0lx8qgTS79KIjmKw+z5JCWqwX18Ed?=
 =?iso-8859-1?Q?qPM2Ls4pm7OVDqr34YpeL2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?pjXOn5qcBPYTOoUoLpoOpr4PvQdf3yygG0COd5SnFfaX/TlyWdXI+LV60f?=
 =?iso-8859-1?Q?q4+4vhHCdMhwpGn9XkgC8C3XyrkiUOqkEI2EbojmV6h6T6L8n1UYWtF1Ia?=
 =?iso-8859-1?Q?B/sKYm1QYO0gMV1T5nXpHmc2L7OhQoDXbQxk0Vq5cqoPENrD9NyeFkyM31?=
 =?iso-8859-1?Q?hpwDh/14Qtk50P5gVliAWKZCXjYU0yJKv9l7tnN3ZwPZ1Ey8JkfDYfRiKY?=
 =?iso-8859-1?Q?F04GTZCDwVPrD74tK1esVx3j5IGB2AWxBoTyTaxxdWDt+JcDuqOAQIeS3V?=
 =?iso-8859-1?Q?qzm1ZcpvZFIIhIyDI89T2vbJjkM5AgSJpR7Lgx1X+HBZkOtRk/O6rDx6qY?=
 =?iso-8859-1?Q?Z1icVpxtUJs5nNxiGXz5tYNve5vYtWN1c/Lhf7aJaNxeJQ/FjcQaZfSNx7?=
 =?iso-8859-1?Q?buJmiuG0cFKpJ2s0T0bQVXvw7n7UUgQPOZMGKv1fQlCInpLXIpKzmFfPcm?=
 =?iso-8859-1?Q?qBJZwb7+bmyfGA2E8oDD5bF/oc79PBUPOmdRrRmME+/38DKiNqkDzZry9/?=
 =?iso-8859-1?Q?E1GWzIOQggpzI8fIqUHyCwlDFvgOXgbuDPM3Me9yewAZoPki7In66Uk6H9?=
 =?iso-8859-1?Q?fkx9WyRGoizJt3ZKpP0uRfP2gZf1B0MaMiWqz97dUiwOUvnD4UCJB7MCjf?=
 =?iso-8859-1?Q?i/F5ClxQhaVHMMOCdzCwwpjcaYL76QuivYxxXLfe3Xi5pIYgGWtP+SxYy+?=
 =?iso-8859-1?Q?El7Fw1ef8OPf/h6UYDML6cmXVQ+3+bPYH0SOw0Sw9BXy2wXXWWY3ZXDmGB?=
 =?iso-8859-1?Q?sYYBirp9a1OiFiFxIMKfpq1ezaxxBtGsPG+JOalE9XplLk+SrodTGtPHm7?=
 =?iso-8859-1?Q?EiaVum2nKKC2i6x+VFxtZjlVvLmhKwhV28L5EHv+v0vSR8Gy9zQtQLD3bY?=
 =?iso-8859-1?Q?vWwFkpG/KYQZm0fbJ9lRxLyItVHdx2dUekyrG3F+KS4kt3tgy8lt3fi61i?=
 =?iso-8859-1?Q?hgXZ5cWpr+cppFFFNVkH8sv54MCUYQ6rQ2DD3QdoD4fY2bA5/S1ZXB3q0y?=
 =?iso-8859-1?Q?TcCiDeUiAlcy4LXL1s8PuW/JqsS2+3Xrexv7eu2CUs+4S8m/mWRLyDCQgr?=
 =?iso-8859-1?Q?eKs2P1lSiIL0QoJ0bM9sU1v/kpp3rFAFp8lKo6orhBHem1BrEgNfcYTbj3?=
 =?iso-8859-1?Q?zlBYQ7U10TupvNEp2Hufg+7X3hdIZpqnwsUrnfFZheMyv4Oxt6zz2Bw0J6?=
 =?iso-8859-1?Q?/jABbE90ZUxhS4ke9DITb8WmUbOb2ojb7V0ay8VNg3QHBpsxLnCcQAAq9g?=
 =?iso-8859-1?Q?HdLAsTe7FcwG2a4QfiuNyMMllZQxh9EXaB7zGjnQjkESn52tx6zs7zRcaX?=
 =?iso-8859-1?Q?0ob3rYTbQPJxADIIEIzfWt3hx0zpIP7KlhJ7fsPV4ZFBnUU3l3yeLO5fDy?=
 =?iso-8859-1?Q?useSzn5zqSgLthC6DAXNa3lrDSqNNb2KQ7SIbaGCsNsN7ipkxWku54ogVK?=
 =?iso-8859-1?Q?2uu6+aoEU/dN0NmRlNknZWeHLBuEX1+ftr3jyoLGSa4PZ/M3VO8eK26Hhk?=
 =?iso-8859-1?Q?4ArV+tpsfTOeOhidsHIFafjZzd10X6kgpY1qBmLWFguCj2qdE7rH0pcC8v?=
 =?iso-8859-1?Q?Pv5weud0alrTvwmrwVCLL6eVVi+nDsf0PHzjJXi86j12wcJqjqAZqytwt8?=
 =?iso-8859-1?Q?Ey1+mX9oNLM2u3y0e/lkBCv6lMyJm+w3Im79V8Vl8MNxeuijBexV3PvyOK?=
 =?iso-8859-1?Q?sIQY1qjfXbc5PIggfea3Hztppuesp++Bm7V88KxUKvyegqwhcbbGVvSIhR?=
 =?iso-8859-1?Q?ZDuVYiZQmiTA5vwnFtdChv3tuUX+9CuopX4OiIETgYBuAdnm/gQPnH6lUN?=
 =?iso-8859-1?Q?FQLK5e+Ra1jlRpGk9JSOINRsBxlBLjnf3tvClyQbGpusJ8pZsOrogAEdQX?=
 =?iso-8859-1?Q?Ws?=
X-MS-Exchange-AntiSpam-MessageData-1: EyDp3Vmwa3CgtA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c22335-a130-4b97-3a64-08de5074da84
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 18:19:54.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDfNxYrjApCOeoDmb9IrMsESg7LoqOYo1EwD35P/YFnTLPXEbTb7aNpGHMXcMra2kc1wrwhczuDJp8yJrV3YLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11676

On Sat, Jan 10, 2026 at 07:08:30PM +0100, Bjørn Mork wrote:
> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
> 
> > I've integrated your test and added one more for RX. Do you have any
> > further comments, or shall I send an updated v3?
> 
> That was everything I've found.
> 
> 
> Bjørn

Ok. I'll add your Co-developed-by and Signed-off-by tags for the tests,
if you don't mind. I'll also do some build testing, so I'm not sure if
I'll manage to send v3 today.

