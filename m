Return-Path: <netdev+bounces-241854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EC0C89645
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA53634455E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D753164DC;
	Wed, 26 Nov 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mV1h5D5y"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1C248F7C;
	Wed, 26 Nov 2025 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154289; cv=fail; b=T94fQC1wN9CLVfhXOhrMqTt5LsS6qoB3cNFNu8MQHNhjZROpxij2CMkvdPOE/3a7L7Q+UEWxrGTObb8Aqlsh4vdkmknFg7f5R2aa9cTv0PkpdoxIm9hdSMmanDZ3E83nhDzKnJOyY1Jq8KJ6Xt+V9z+A7cAcrys08ZMS64/q940=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154289; c=relaxed/simple;
	bh=5FUvYX/9P78O9tB9+LyGvOCbzpnOQuLWWi5IwdHuHBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l2Uh+Z5ITN4ZaFU/mSZaPExSOhmEl5gcwKRjWo7vGxvm8JCqTuwzLe9fgl7OkHLX5myH3uLRZzUiOHhiAs3TGndB1Bgzi2WTMAl6GZVIqs3Qw5clkYVC4skq5FWw98bq9WxCHZoSV/gKwPEQ0Caf70eTFco+y6ue/YDAOwZBtxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mV1h5D5y; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTNweeZchf8OS2uHAbyCJMx0kaJQFuf4mGEmWf3+dgzyHmVBWnb9gh4ZlVHcrDrDCW1Hqz6ZPonsYgPFN+CYhlQBwagdATtzwMC4x1W4Osdq/+Dz6ZW8Bk8RvhSsI9I8arkw/bA4dlnUK4U9j7fZE11ET2ndHQ+DAngjS+KXGCnVV39UNdb4UDnV8FV/8mFOK2C+nReOA6HF4rxa+yTP9KzzikR6OJH3wbcV/WmtZ5A3vx0hHd12Js7J1Bxf0if11djBsMwo9/hkwcM3xgu4d/DWw8YmrRkccO3S5zqxo240t22hYqbGwYxMmTc35b9IfCJi7eSUql7zuzT3IEkH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7z8mFHElAJ8hjCpkCtKNJ7XS9m9mK64ZspRldRGXfV8=;
 b=OkN28qaApY/a4xQm4p0M9tVLCDgTfrjh8D/hZ7gqjgsRKVkHZTu9gS7cRiUAjsJo43MoPGbhvGBLn6qq3tVM5GLjtwUNecMGc3d+l5Nym4Z2Vc0aC8FTB7zu8AG8KkFqNzIRZ94FHD0NdFfAXHvLF+harLEm8HmqKyAer9zVEKSKmHLq8wTDAF8qzc/ufNU3UOhSrCBYdgKkfDI2wUfmOz0MMF/QwN3cTml0JgholYP15rsqIMEM5tCkD9HjPcjzBxaLMt9A5HbhbtwdRzer24ppTEt2YJPOmkLYmDK0ng25ewtsTxRojwSiTQzRR0Lyafbq0a98KLKlTUGkI12fwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7z8mFHElAJ8hjCpkCtKNJ7XS9m9mK64ZspRldRGXfV8=;
 b=mV1h5D5yjmkVWD1VDbxBwKpE0JhHoeXZmsc8KZGapwZkme8aQCrWWWihVWhxZb35myvsMd70LGHU2M0l6+nI9cHPSHd+avrTfsXZMf8w17ma7iX6WaTWT9qGkckkxa1TbqtThpwF0JPcW/iv4K3cI04AsiX/YAIeRVHuP/xLb0kzWtL+pQjJwS0uW+Dwqq4X2sfPPhWNWNN3tMisXZntI4HtH2/SbpsUIWkgE72HxqlVQ4jeRj9AHe1dsa1Ye11ULgmyoCe7Hxb+B1CUUjCZ5hpsfV7oXC9VAjSSmQFhobJBq+gcF8WlbklZB8t6MuSdtbAnA05UNM6ug1oaK748Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB10463.eurprd04.prod.outlook.com (2603:10a6:800:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 10:51:24 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 10:51:24 +0000
Date: Wed, 26 Nov 2025 12:51:20 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVo4oia4oirbg==?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Message-ID: <20251126105120.c7jtuy7rvbu4pqnv@skbuf>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
 <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
 <20251125214450.qeljlyt3d27zclfr@skbuf>
 <b4597333-e485-426d-975e-3082895e09f6@lunn.ch>
 <20251126072638.wqwbhhab3afxvm7x@skbuf>
 <AM0PR06MB10396D06E6F06F6B8AB3CFCBEF7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
 <20251126103350.el6mzde47sg5v6od@skbuf>
 <AM0PR06MB10396E5D3A14C7B32BFAEB264F7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR06MB10396E5D3A14C7B32BFAEB264F7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
X-ClientProxiedBy: BE1P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::8) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB10463:EE_
X-MS-Office365-Filtering-Correlation-Id: e24d93d9-283d-41db-26d9-08de2cd9bdea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7E8xz0QMs65wLZxVpyK3I9KkXG3oMw+rX7zr6mlt/daqS7bc0yqxYvHrjrCC?=
 =?us-ascii?Q?nzq0VP7es7jb9VR8nMbiXSyCpZfaFpmZBaANZm0cfjroOWG4UWNQC5vCaBnV?=
 =?us-ascii?Q?3Nt1bb6YU8jEMIj7ULVUAw7J4TK8dTALTL9lIkALc7uZszAxmgxnnODKv/6N?=
 =?us-ascii?Q?xppmIGoi3f8W9GO3Oc7SF5Nmf5fTi2/7lY9+/5HjeIoxAnXFRJpxxM1H6IkH?=
 =?us-ascii?Q?J2rECMKx+NrTwgQgutWs7Ogu1bLw+7bjmXE4wPgtc1+nIXvxebCNYxcR3MuZ?=
 =?us-ascii?Q?uxKXDN3XBIoCCSyS36H0DhXoH6DWYpE7ZDeTmFbYWlBxgH0cvQk1SXnz8HGm?=
 =?us-ascii?Q?GTgawCZYEtNa4YgvCudoL//A9plyn8KKkou5R7vtd359DZYCzxiR4aFlPYTT?=
 =?us-ascii?Q?hHebba1r5iSOmSZ6lG1itlo2PakKpUmTew3D35Br/GhG9m8p8V9gjAbhANQF?=
 =?us-ascii?Q?jYYstGX3mxQEOceJvEzGhUbcMpjR6/FdL5KESvNUCNi7jlelvlNNe3CVNMGM?=
 =?us-ascii?Q?hI5HE3R9BNuUIXM9YZDmoKd6sp6x3flsU4hhIY3vh6bJaejJ7bu57mu3i6dj?=
 =?us-ascii?Q?OGI29q8xQHrQXwcYjc1HI5hIr6k3fXJxbzyRif4qtNHKH/pO6fjhAeu5DWnA?=
 =?us-ascii?Q?rqn7vascWLRdzlrafiP1roIyf9aOV5hgSvriXLFBV/Fck+H6J/Mjn7TdqPL8?=
 =?us-ascii?Q?iasLpeF7tAZJdJsGPRkcwX1owDmrHALKqznYVZDWB8BtQ9OyoOAfaN6XEUMX?=
 =?us-ascii?Q?uDf979xgrlfcKr5t9h//bapFthhvAUaOg4nWKwgv5kqdM9b7BmVfRipw9MA6?=
 =?us-ascii?Q?oLSd+31Z+xbw5y00Euy9OwI9jzWRhj/fHnSobhROksxF7IVmpjJEjdXxfLU8?=
 =?us-ascii?Q?e5lm1c6qH5OXvM6dIa5hrtMF6nm2WGMCqkT+78zr9ge9ddfHDbAsm0alg46i?=
 =?us-ascii?Q?bsoiPmO3EPyhcFuof3cwPSkZkFfxzl5CEuTjYNKx6bwUcDoFoSJLD4VHMPNu?=
 =?us-ascii?Q?3x9C3snXovkNfr6xvw4QnflCsUshUaRKiVqx7nQmXP8Nmn+o0JugV3BTy2al?=
 =?us-ascii?Q?IjCP+xQJE3DX+QRqZQ3q6kSgSXqKxi+U0e+dhLErbbFxIbrcLEordmGlNkxL?=
 =?us-ascii?Q?L4mrOlEdm83zUSvS+3+4uNRIztDe5w2AWzIn/asEqPzCn6R9i0rPJqlH1UeJ?=
 =?us-ascii?Q?WHd48wCsg3DHvdFJaN06Gc5OeOj/Ft76IlsU97E4uJyuk8vCL/zi8d9TPIyn?=
 =?us-ascii?Q?puDHQ68vrZBQvt96swev+VDYjLXuz+Dw3xJHwg3nEq3batFfsC8pl9IFIyZe?=
 =?us-ascii?Q?jpvqZUjWaE0lTxwoRF9zrPSyLKlkdoa5Cr6/EbhDYZ1g4+t0tIFFeDrTu1bn?=
 =?us-ascii?Q?JCXlj/hzYdixzK3Gz1vIBFIb+dtutgKPGLNQxQOU8qJKX+FKFcUUE9prJlEJ?=
 =?us-ascii?Q?bLSC7RN0+zUUXGHj24EkCb6w7jMdBvz/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vIUShrnQW2bHkorpdBjNhGvYfxj2/op+IWpQY2oMMpsGiZ4qreyYKGvSKEQQ?=
 =?us-ascii?Q?YqOikEai4YwKZMCX4M/fSe6r5gKF+THep0p/wvwtKLptcUrkkIvdzTZ4sbBM?=
 =?us-ascii?Q?O6IvEFd/ZbpaOfdj6MeC4JPdSMZQO95fYbOHyaPQt1wLgOQmGpLWELRLxYJZ?=
 =?us-ascii?Q?Rp+PSPhGJRcoG3QilQex7l3u7zzXjVHbMz3XMi7EdIye4p/1YdfvNhvNCeFU?=
 =?us-ascii?Q?cxzzSKPuBR/i5d85JxGuQqU1xiKBW+ak6ZhaNGqbFd1sZiPdRelLfKQUoBZD?=
 =?us-ascii?Q?7s1xoS7cRVZbi5PqVxhTnV5ssgzXf4tOo40w90Hu+OhjjSL7xI+/sQwPjanj?=
 =?us-ascii?Q?bUub/gKZcmi+PKZWoHcphn128L0ozhXV4N8MHCQ5s06N53eCMvvP5oSeS+jV?=
 =?us-ascii?Q?noGlw8/JBaOca/J5axLFT40iKCa/EHYlMzwBz+xfqliQgcgC1aCLsA5VRfuC?=
 =?us-ascii?Q?FPXXL13jAefzLy+O8ljbrFw3sbbQL0kRg0+RxHs5QfsHXSjDzXpy26d/4QHk?=
 =?us-ascii?Q?+HhQh/wdp6YiAzkTGZiHDlZxGvHbW6kV1tUOr91sgHTewvC9iliWe8BvYgnU?=
 =?us-ascii?Q?20WathWD2g8DmKGf1FbFsWW97EhFJZoK8b/ljWE5GWOucU+Q7e0kuT7lTadS?=
 =?us-ascii?Q?XzEh9qg37RHEv9jGI3BtGHzxqlhu17yCu4hWjSrevkK9Mfqxt3rG67RiLDux?=
 =?us-ascii?Q?g7vyKZAantXQihfOla+4fBx8QMnNSQu0fydoftmN7kqdOFJFPA4Yz65j1m35?=
 =?us-ascii?Q?tDLciCc7mX9FFYR44KgrEBpny5Uu8Tc4ieOrngSQT7fxAY+M4zJuS+o37u+n?=
 =?us-ascii?Q?tpJEzZQ/Vb+QhApOCuMBaZKRIQyw3xGSAYlJgBSLRJvoCkAlmmqLwV8+GgV7?=
 =?us-ascii?Q?PSCJV8Pb0etdC6g/eMnwmXVIxnBZCpY3d1TovnXSBuSTEd0IKVw2rzhZbcRc?=
 =?us-ascii?Q?8lTlfHBPIsdKb0y9TynkIGZ4bbPZaBYHNhMZZOa5UFcYWKmozM8So31j2BGM?=
 =?us-ascii?Q?7M4Er97DhmyBM0L8p6aDdXyujir7r22UFGRtsxv7rDOLW808A5dNHFEQufZ6?=
 =?us-ascii?Q?u+9cvaDkyUyiu34D9sNZ7aNnWHJOiOle0dphCXFFu8EWqMQ/p/GyQG1FkBdx?=
 =?us-ascii?Q?iw8IimJCRUpTfTDWZRq6kE6Mkpt2Sj30YlF4R+/4HRYvfKRrq8OmNKiVsdv/?=
 =?us-ascii?Q?TXlsKmo9R3ZiVTvdgAZ3bxFsmF7jOf69ZRJdQK0VenVUIsaV2gbjap8ADLdl?=
 =?us-ascii?Q?3st123eFzJAin0gdpoqcf2A00PKBG34eSKJ3ueTHk1zTgmUA3H12w4GIhKAx?=
 =?us-ascii?Q?sLoXBWF+vshvmKwtsi+vDtMFMqo3vCxsMx+Ho2Kg9DPXfF48n2fhX9lHGuPf?=
 =?us-ascii?Q?ePW3Ngam4Xy+P56K+XedorXFkq9RGSSZBeAgQaGKk2ZcIipw1g1QYHqu7lUx?=
 =?us-ascii?Q?5//7zgRZRTwBjFIzwJ13HT+OxgyIcZKbZFZXI47qde1KAIn5pgd4eGqsyn4N?=
 =?us-ascii?Q?Qbvc6Xi+hsCQg2/8kBbvoIM1mrSUcy5h9dA7gAR+Aoa9CCKlODMGe1xLud84?=
 =?us-ascii?Q?TLcjOLb/wsffHqLtownRsp/2n0cmMQuGYCFz/VAVFcYuv2ztUOvbUglViiRe?=
 =?us-ascii?Q?MFSeRRuKdRoKFTab945/8ML6oKqj+G9GjOgDshiMViTXonTvd5376H04JwNB?=
 =?us-ascii?Q?Oqq14w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24d93d9-283d-41db-26d9-08de2cd9bdea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:51:24.0247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSgIMhOBSRrq/C7i/OsNirS44R8I2FthBAptGmsWrhzD0S8Q7SPWbMzwqGNSJMSdjIT2SE00r3ONe0EOw5bX8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10463

On Wed, Nov 26, 2025 at 10:45:31AM +0000, Holger Brunck wrote:
> the Kirkwood based board in question was OOT. Due to the patch we were
> able to use the mainline driver without patching it to configure the value we
> wanted.
> 
> The DTS node looked like this:
> 
> &mdio {
>         status = "okay";
> 
>         switch@10 {
>                 compatible = "marvell,mv88e6085";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x10>;
>                 ports {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         port@4 {
>                                 reg = <4>;
>                                 label = "port4";
>                                 phy-connection-type = "sgmii";
>                                 tx-p2p-microvolt = <604000>;
>                                 fixed-link {
>                                         speed = <1000>;
>                                         full-duplex;
>                                 };
>                         };
> 	};
> };

Perhaps there is some bit I'm missing, but let me try and run the code
on your sample device tree.

mv88e6xxx_setup_port()
	if (chip->info->ops->serdes_set_tx_amplitude) {
		dp = dsa_to_port(ds, port);
		if (dp)
			phy_handle = of_parse_phandle(dp->dn, "phy-handle", 0);

		if (phy_handle && !of_property_read_u32(phy_handle,
							"tx-p2p-microvolt",
							&tx_amp))
			err = chip->info->ops->serdes_set_tx_amplitude(chip,
								port, tx_amp);
		if (phy_handle) {
			of_node_put(phy_handle);
			if (err)
				return err;
		}
	}

dp->dn is the "port@4" node.
phy_handle is NULL, because the "port@4" node has no "phy-handle" property.
of_property_read_u32(phy_handle, "tx-p2p-microvolt") does not run
so chip->info->ops->serdes_set_tx_amplitude() is never called

I'm unable to reconcile the placement of the "tx-p2p-microvolt" property
in the port OF node with the code that searches for it exclusively in
the network PHY node.

