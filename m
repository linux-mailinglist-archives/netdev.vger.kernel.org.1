Return-Path: <netdev+bounces-247488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 852FBCFB3C1
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 23:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D82863016CFD
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194843168E4;
	Tue,  6 Jan 2026 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ofxb/mOk"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB743230BCB;
	Tue,  6 Jan 2026 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737772; cv=fail; b=gYRmwvSZcIqJ9dQ8PTnVpLVuix0vY6SXULDb8bkTfX8NX/KpyBILHS7WD6/6F/FHCiet8H0IN4oG4BhA1DJlY9qOMBURHKYW3/nx3UTc+J2BgxA8CTURZ4VM8F1ZVx2Vdix9sbcJa/I/beXQjSccW9yCd1D02Fg0V5FDAvaglhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737772; c=relaxed/simple;
	bh=DSVIUM7ilMZy0efcy+JceqeYBqf8T1scBrKREJbE3mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L3UMD9gKPgMFKRut/pTklO+5Uh1iuzuiQPv+GfoLSlSfiq1pZSzw065OcvHO7wRDcECDx/mpPpsCKDANRbUBAIUwLHq04LWuLLWVkjaBescRGg8i6y6c/I/G/KvzPBNVTT443PbA8i1GN5yD9hNXcxSp7g8bpA8+BVOdfHZIRAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ofxb/mOk reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XM03VyXGkP9eIA9JOrcv9oZQ0uGKEPHx2wEkRo+Bi0LhAOVPXSLImyEip+z9jqNTk5NOolR5HFAXgp1hX8eGq9Dgs4sgdfqrjF4hVBaRir/TV6VgLsqwCtBoNzlJCGaLfceKYL2qxA59lzyY1GcoIV9wJVPPP/MloWNDhNy95PAMGtAsb0W2MpvMm/MiZAGfESwlec0VoakPpHcTwUq++ZPcEAcm9mlvIBVo8ks1MO5fIceI9ZVvB9uq4GnUxfPp4ecTagW9/1E4s24wNVajgtHJw4kAJ/UAkX+y9+t8bEhqvAqv6pjlTqMpb9Gh3DUIzbke9EqXjfPiK6rb5V11Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY+9fBXo60+ztgqDHBVhhSAFDFv87G2M9KmrlhV65MI=;
 b=D4lsrxdmBeeOKCyn8sycOKfsxeni7U0sBokwG3/mlAv66fpasFpbKTmZScT80lLdwwHnqA4yYtoaxqW2VqH1owsaOrdyPAa+fPAdyS0HYS8oDMy17GlcxePhGpEcgo+133vLuU60x/ZJfQ881Am3E0BIxrTotZfnN3uGu542hlRzuxfWD9p+C9wbevxBwshFopTpcMK4Jwsq//YPAD3VK4VqZk0Tt0VHknryiY/XNHMd4FjfVzjti0V6EOrEi2hHiR1O2qF8i7FzO7tU3OhNY7dy8cU2PZPhKHmgVymrBan25++lYfMRHLa9uxkacQGXQ8Rta0Pwx6d+XXEQG12QZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY+9fBXo60+ztgqDHBVhhSAFDFv87G2M9KmrlhV65MI=;
 b=Ofxb/mOkuapKEvf6s61hH5Q6CJSB9PyM8tUJBlovRKjoz5SylLcGQJ5u0eVbXgYDHNGgJ/nMqXhVD+FtsQy6+tzQLDd+ZPDCTcpuXFcebU4KyyhzUTNT0ts+oSPI1UAjHSYXKuxfp7rkAjOQqWbKFcl8xJ3N1bMzubRnjb6Z9cu12/bEXgY4CTB/gaQ0aDK4U9mvKH6AE9RuNChoTn0hvJSvNl711id2VUGSRJtPkq9N0Hf50DsrSc4Vpcc6ChyCTLow4RWv8jn1InXIbNYhfCmnDn0lyi2ihU+u9eA8aQyTMT8q7wOzQGw0SZoBRYHO3ww1FvjOzokAIJxh38Wovg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 22:16:05 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Tue, 6 Jan 2026
 22:16:05 +0000
Date: Wed, 7 Jan 2026 00:16:00 +0200
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
Subject: Re: [PATCH v2 net-next 07/10] net: phy: air_en8811h: deprecate
 "airoha,pnswap-rx" and "airoha,pnswap-tx"
Message-ID: <20260106221600.ewx7xprbqrymzbjf@skbuf>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
 <20260103210403.438687-8-vladimir.oltean@nxp.com>
 <87qzs2a7hl.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzs2a7hl.fsf@miraculix.mork.no>
X-ClientProxiedBy: VE1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:118::32) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: daecd811-70a0-49e8-a4ee-08de4d712eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Kbot1pMCXubxLDoDp2iQuYtANDiEDFWyW6tRPePqOuDOR3ixZ1XMH+9UuY?=
 =?iso-8859-1?Q?qWBK0zTAvz1MHjwZA3c2RtDwE1+PGS1Af60AQEiQkMCXbq5Ivk1N6Wq1G5?=
 =?iso-8859-1?Q?slRKyGN9O8pC+2VIpsFynvPU781tz8gJCwVRXWvy24mzeTJVrJnWqAE/4w?=
 =?iso-8859-1?Q?F7zwf82LJyfENB+ZjbrCGC5PG/1fBkhCQxwa5vCOlbOTdyaI4hiValavpE?=
 =?iso-8859-1?Q?wKGVjQAkD+w9FyGwRH1wUJZSryQPQ13d1pUFOVf8PmVk/nKTZ4Nowa4LbB?=
 =?iso-8859-1?Q?3bUddNOtW38KyWXfB3bcqtbupGJSpn9u6x0tgyMG0ZTO11UOOfStieHInx?=
 =?iso-8859-1?Q?HcuBT5gjmpv1li1F83jhARb5jEVPRHZzubH6337/Lq6S3bsjyXOqZD9AGV?=
 =?iso-8859-1?Q?aA2U9f1ykmQFAr2HBTnDOjq1CWWdYmwa2uhyJv8/USJ2BthYRdS0nkIvMp?=
 =?iso-8859-1?Q?oPhLe9A+eXgO7xbeaIVCWid6CUMi/69PAc6gUQmjfBZn8QbEtAQd5CLa+f?=
 =?iso-8859-1?Q?DlaO7xiqmx2ngK7rBDxcDO4gbppPOzMWVzbMj9FNKgLk+PXnV7oXm7A06G?=
 =?iso-8859-1?Q?3W132s/7E+4FM1h7yw79kw2IH/cH7QKM11Bds7o/NXba41MmLJ07XUznBm?=
 =?iso-8859-1?Q?LVYIhlcYrnPmHFW09r1WNDgZhXpsrBy61JL/k/HFbON0M1xj8QLoOMbNeQ?=
 =?iso-8859-1?Q?44oX9A7WdsvsKMVley64hcfPjT0k6m0JvCztxambNCwhWRzvPvEbKBMJwt?=
 =?iso-8859-1?Q?wXZnQMDWm18QSfeUJtv6lZppiddxLgFR78ZxADTe3/JPbs+u2FydKaedLm?=
 =?iso-8859-1?Q?qW7R/GbKwZjPEYhxsO7vnNYmyYsCpJy93NT1w4n3K3wyJeoMImM4iuKTwR?=
 =?iso-8859-1?Q?L7m91YGr0QrScCDG3DknSfAFKufc+t7n53+m+6GxVSSEkE5zVXB9zT9mfX?=
 =?iso-8859-1?Q?xuS2KR+SlXIreIXcnN2W7XCEfnM5AXbQ54La0t1IOTY+8b44uhAqPFkZAd?=
 =?iso-8859-1?Q?c195vYdI5y93Eb+1+bLpg5aSCWkGkDfVfF7FSP+VtzA4R4ySGW+aqMMEq5?=
 =?iso-8859-1?Q?wMg/ArHXNJakSfKezJANb8dU9vQWYRwYuaABwY6ljqo7msiykNMCL8yFeq?=
 =?iso-8859-1?Q?gF6oGtAy4T3v7lU+dLbTlbRYUFN2VxVHuZxqsMi1W4G1Tove9zq3sKlziG?=
 =?iso-8859-1?Q?efaKRc6sE2B9mVkp8lFkqwmWE8QE1dp4yAEaA8zt/FptwYyysn8R/zNw73?=
 =?iso-8859-1?Q?HVZyZTtgUoXl5AeMFO3D88NLgyt+NmhGYG5yHnReXXaX57K12slVv9alYE?=
 =?iso-8859-1?Q?sZdqzm7c72dVA3EAMxlXERMsybGCQyNi6ECtQi0q25l2nAZLax8AfYpVyc?=
 =?iso-8859-1?Q?LpCloRAp9NwSJYMmAWS5co9x6zCPhNpi8O2t0QTu8/A74IYVUYMwM+zZq1?=
 =?iso-8859-1?Q?yZUmiHervudueSPyEFKskEYH2zy79972UzCy5uEWSTkoh6+/S4d4Ogz+c+?=
 =?iso-8859-1?Q?BoumThGoEk+TLcRVHfD33c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?EXf7TLa5ucyoUQ++sWZ3Bqb8O8aqDRLiCx0dna37lgUa2DNoNdrLy81V9K?=
 =?iso-8859-1?Q?4jrsjUwLRxit0/htagSFTHmaCdRQnk20TwZjnaPsXk9gsB9gCY0L+0fqAa?=
 =?iso-8859-1?Q?Gf9e1kwVUq3uJ/iuFuf/1Pl6jgcwyQoupoGFf3zvgFC7Iw8sH77CLMM98y?=
 =?iso-8859-1?Q?ufgdGPDrqXsxwSmby72Xrdohxzz3q+WVVIV6wApWef7KyQosUZAl5IQjEb?=
 =?iso-8859-1?Q?I780NNVtWbTlTgsKs2yzOuu3F2ZfVC8KPS6vjHdsBWRSbUSMtX2/B/Ji1M?=
 =?iso-8859-1?Q?PYRyb3prdSD11rdG2KrppBZjSEcB0M46f/BCXkE7cpY3EyTOD68xvwlVsU?=
 =?iso-8859-1?Q?k+1BKB7OB/rY3JaBvaomjWmBLVDq716hGKQgXTgDeanmFNV2isNkcOE+3k?=
 =?iso-8859-1?Q?+CRNCf4xU3YB3OF/Q+zpKFkG5RI6cHcpoyIRbjOivvWxNPhhYV8pGrtxpX?=
 =?iso-8859-1?Q?eCNNnfa5ZhPgYRaVe4znoj25p0ybFMVb1wNIuFBpZTjL7cJlS1a7KXK56Q?=
 =?iso-8859-1?Q?PknwIAM9jPGxQ/k9gjSdO+pHucJjigs/cD9yGiHjRyTMR1asjeQHHLktmn?=
 =?iso-8859-1?Q?CYCCPRMOKlTCacc7X5xy2YVINn46wUZWmHZq1dd4UMM2vV5vIKlirThckn?=
 =?iso-8859-1?Q?YyKxBI3CjCQH59fVxeQWP/c+zlHppDLrTvJDQSpW0n+DTWo8SEpcnhbwB6?=
 =?iso-8859-1?Q?V3JVNOorffJA4ykcPNc0dYnVoQVpVBxRmnFScdLu3b6vCwOAFxTlmCgy72?=
 =?iso-8859-1?Q?wab/Yye5pFuGYD7sPNpAK7C+GZ9XkaHiEgD1habfKX24e3QuLndUIAONHU?=
 =?iso-8859-1?Q?MJUZPHUWlarBoi/YE8xyDp5Jtf4O2C21ee8YeU6ZD0Dv9uOLviMHOcQj+j?=
 =?iso-8859-1?Q?YN0HBa06pMijtHX/R0WziXq+LvKTH2Kv56+rA2Tce6O3ANVSuysmHvBTt5?=
 =?iso-8859-1?Q?n/aQGEOsGrXp/oD258z8+j1q3QWCmHiTvZWXyfLqI8SLbB5YQnkiv5mcaZ?=
 =?iso-8859-1?Q?Sx8N4iXgaNdbLwNRdCi3qYvWb5KFQk4Js2p1SgEu6Z+H0b7WmlTjfUpqob?=
 =?iso-8859-1?Q?s5X5bAr7qxVjsuo5iorP9WnrOjyUHWxtDvxY/L2jeFyq3I2pX6RR2ZXlzs?=
 =?iso-8859-1?Q?heUryz/9J42moipD96DC9kQ0LNhBjrn37ilZ2sCum9eTxDcFXZt2JIgm+3?=
 =?iso-8859-1?Q?QGvASlZlgtLO4MdJN8eBS5ozxK+xp3+AUO0OU1sDGCppWR5IAOg8xPgPeF?=
 =?iso-8859-1?Q?5/dpgqVlNwA0bhfKOfHQ+zN1qlW1+XuH117iq4wvYZNCqvIZyQ5K8IJBh0?=
 =?iso-8859-1?Q?O6cCAPHaPyB7RfInqdsQtCFNkZuMCt7r5K4Dfc1araiNAu8B6XGXXSi0ya?=
 =?iso-8859-1?Q?uAzblGaO0+iAaPsCeB6LNS6bPpE/dmJU1Ax2eLZ5oQvpQqfjlXzyHjBIQa?=
 =?iso-8859-1?Q?9/F0LUyvTUWHvAmaufS6mixLklIiH5y/Z7CB+mT+5Je9o5k2FbKXlA2pYL?=
 =?iso-8859-1?Q?nzB2Cyn0tJ5KElVHTDYSd9u+cIm2Z4Ui1yy5g7/vWDu8JXZkvKpAmZGooA?=
 =?iso-8859-1?Q?MbEzqz7VyCeTJzn7be6ypYMkI1HRCKozWsRpUbbbo7koIl097LbjYj+7qf?=
 =?iso-8859-1?Q?hW3yBQO02tr0NZBNBAsLMLJzFoZgM/k2x26L7C9BmWa98QUcI6+pE3XGr3?=
 =?iso-8859-1?Q?dS5uDC3TyvJ1ykoZsV+5UWxg2FWSn6ZFsMpbP4rO8VfBCLVu29n0C37JWD?=
 =?iso-8859-1?Q?30nd/vKmpq8xfdlUZb4As/vaCjCq6FHyT6TMPWztXY5M/XXMRolkEJqZ/k?=
 =?iso-8859-1?Q?V5kRj4k0G7HUTkOuS5uGnZDx9tdfB5Uzw10Yyc76ebgWiYSenIe8gF+riI?=
 =?iso-8859-1?Q?un?=
X-MS-Exchange-AntiSpam-MessageData-1: 7mvVhxQsmZUxyQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daecd811-70a0-49e8-a4ee-08de4d712eeb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 22:16:04.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QN31t1VzbuZgNC5e9vKgWha9jXYlCQTTOCBU3zoF7WdK9D8pGrTeSKZa6DhXSsNezHPQg3zeJd0E50gFfFQMxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095

On Tue, Jan 06, 2026 at 08:03:50PM +0100, Bjørn Mork wrote:
> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
> 
> > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > index a7ade7b95a2e..7b73332a13d9 100644
> > --- a/drivers/net/phy/Kconfig
> > +++ b/drivers/net/phy/Kconfig
> > @@ -98,6 +98,7 @@ config AS21XXX_PHY
> >  
> >  config AIR_EN8811H_PHY
> >  	tristate "Airoha EN8811H 2.5 Gigabit PHY"
> > +	select PHY_COMMON_PROPS
> 
> GENERIC_PHY_COMMON_PROPS maybe?

Thanks for pointing out the inconsistency with patch 05/10.
Yes, this should have been GENERIC_PHY_COMMON_PROPS.

