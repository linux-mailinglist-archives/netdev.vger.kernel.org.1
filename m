Return-Path: <netdev+bounces-248723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BA4D0DA8B
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD88230194D7
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7329D26B;
	Sat, 10 Jan 2026 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="azkT2+xP"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA929BDA5;
	Sat, 10 Jan 2026 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768070496; cv=fail; b=VKw8i3dOxxg/M0bZd8XrtjUWqT+AB7XGGc9+Jk2amviGxuna6RlLnkNKeqxQf2Yi6i4nf6sXam9U40E0KJT8CYXcIOVhtRkTyAU01V+cUZw9HKl/9xP2k17DrgZQdYguBUdo5zBjE5ayfILXtpSUvC8yRzxDVhEfN1gh77fBjow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768070496; c=relaxed/simple;
	bh=ZgApWHGnmIBY7rD3lNP3MWQxyd6KRsQmlh8IYYY9DRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p1vjazjzE7h0Itvrv/FD9oN0CTjqkZ7747C+3EJ3a47Km5LUHUb5HTRR67nv5GoB21vSN1zf7Ocw2HWIgrMstVji9adZ8cIZ+NyitqsIlCdb5PSFlKV2h4cvpvxOZQLpNBgT7Z58u6ANLsgeDZB11SXQCi9VuS03VHp4+A3Blj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=azkT2+xP reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqejsIy1bnlPMl3vHJdJUDgVMN0brNtmuxX9zQDXIAQ7fWTGiqBpyy2jWur/JiYlSqB18mx2fAg1S6W+NdsypwtENlSrsVf+VdpLIaLsyTub/Do2vBdfwbIjRuPRDJlZv2lzvKAWV5Xypv4T2h6zJlqTl1dlAb7L/xa+zIy0N6YlLaTre+0/Fz7MCvBKKi4fYEr4cjZ9mnWICG7oK2XOKDatrp8H7dpsL/2oQ5qeZ5jyMgX8ALtLc9j+EJ8T3e7lmSy86fwrocD3vRgVIcD+AuIld3cgxMiqpfuGaNa6GpN5vwHLNaurDAwwqzL4vQ5j+pD4T6PKc5ppyW8FV8f9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eqkqb47gD5V8efqbPUx5XsQJ7OIRvYkKOsBQU5HIKw=;
 b=Gs97bEAtY5aihNmCC8Es1qv3vcGV5aoNXQ7pPChS/sn2GndvCD2VKJ2nw/J5d1UVcg906yE8agRbnpdOeyFtDim0o6u7V1ApZNb4U9fwHw5020WzqVKfrPR/N1I+wMlD+BSCdGb4XbcnjuF/URZhi5Lzd4C/bBISb9+B5JO6pZGeuI2TWlAYoYePNnKstrDObMkZnAlj00He2et73s6ripfQz2bdX5IZt62SnJtgE3Cyroh3Ozf6csjKWuUGYd4H09QFLWBIUsO1dl4xA3ktKHKJiCuQ7eYGOEaSF6Zr+hf8tGM3A/zFvV12pYhIRrKEbv/COC69HLccnbSZf9CSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eqkqb47gD5V8efqbPUx5XsQJ7OIRvYkKOsBQU5HIKw=;
 b=azkT2+xP4GYrJxToIkZ+qWViW1Bzs8DgmRhGFzVJmBNDE7WpJuMUMor8ljfL5/3dyixLLjelUJQOjuRn7Cw1gzd/TNjsT1wyj8NQ5+aLUVBtwJ8SjYAXNkiAcQnvuv4RherPNI4hB/A3Pd7KbHjTg0vWQTLtFssWb5Tm2lz5NI7Tc56f1z99i2DSZ2YGQ7BWXDyB+bLEKn/rEx+b9OKgECbVw/BsBe1LV5ul0HRdY1Los8LCVO1aX/CMjUrP/pqUedfI42WeKKju5W7q5fwVQj3Jo7kX+Fv35i2XSKtEsbm/wgw1W7A/+NloLCpDgGgb1rAbiC6mmcduhRIRH72MLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10702.eurprd04.prod.outlook.com (2603:10a6:150:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 18:41:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sat, 10 Jan 2026
 18:41:30 +0000
Date: Sat, 10 Jan 2026 20:41:26 +0200
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
Message-ID: <20260110184126.echne7apfswsygce@skbuf>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
 <20260103210403.438687-8-vladimir.oltean@nxp.com>
 <87qzs2a7hl.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzs2a7hl.fsf@miraculix.mork.no>
X-ClientProxiedBy: VIXP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10702:EE_
X-MS-Office365-Filtering-Correlation-Id: eb02529e-179a-4b62-07d2-08de5077de80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?UkckwnMmWZKygePwJ9RvMjettOX9XFS9SH2WQ4nSKBMOoQDzpiSDjKOfIQ?=
 =?iso-8859-1?Q?g5PV21k3rbe3b6e4kHcE5CYwcvKRUtByOg14hfnrhMYeET3QFY74Dr21nc?=
 =?iso-8859-1?Q?DMcgjVe9jUYmEzUU40Df+TwLKPYoIDCOy5S6USac1FfLbcMlQezz6UkCqV?=
 =?iso-8859-1?Q?OLkGWEONSJOvf8/YxrYji99CzDjIX41g7DS1edxGtOc//kwEiXPZIwV9SV?=
 =?iso-8859-1?Q?EUfZFxR2ftMNmVS1vlQqHzQAPZu6Ks8/prF3CZfK+FCYolA4J4urwQLdtX?=
 =?iso-8859-1?Q?lbhTZ6kF7a9zAOFVTR6DklLOVGETdCKG507YG7lTkxuGzauOnjmuCFKuSK?=
 =?iso-8859-1?Q?saj0UIwrjl2eyvWN28ktIvvPqPerJIFJX25ZTRtrsc/0FHKdbxHXpSxvFY?=
 =?iso-8859-1?Q?eMqtlAsy4YOraUBsgGwOprNdVcwZQvIHHQNIcSamBY0xXZecmyMohAd/pv?=
 =?iso-8859-1?Q?a5Rwzw2ODs6KcKEzr2wQbEXRjB6fjxRvjmbOeoYYTH2ViQB8lWGafwqw+a?=
 =?iso-8859-1?Q?tjCArWWUn6CQ5L7b4FOPQnpfaCwKbVV1x8C2YiKB2OEnVie4YnQerz1Q5T?=
 =?iso-8859-1?Q?Kz/XxstJE+yvbsKUN7195YaI1OmQeL9zoIYHyu/5IQ5MBlCPCB3RhnjJzA?=
 =?iso-8859-1?Q?0hE/ku7XG7vJP0acRSsYkTs3YiJIKcqLG0B2QtsnZpqGCj18hAc+0EqiPU?=
 =?iso-8859-1?Q?17uI4SpbDhWeIP68hLwfCqr6HMCUGP6tjja5vKIXOwK+XBCZ1goDnCMfVQ?=
 =?iso-8859-1?Q?y9r38eI+4RQzSEXIpGz9up41TLwvYfZB2cb4Z7twx8gJGwZ2IzZq3Z8O9m?=
 =?iso-8859-1?Q?hpqCklV/tyxoUeIGrW4/NJqvL5UMgPl1nyKHZn7CEFaC94cIw2BbXnOlc+?=
 =?iso-8859-1?Q?SOoqEnfW6TI5w5VC2RWZVSeVrXnEyuw69VUjq2tEFfaLgHMNlO0WUq3w14?=
 =?iso-8859-1?Q?ogLHyzRvmZBEVMga3bUa0qAi+uB04FkbgakPnFVDftcYztJh7E6N0UR/8h?=
 =?iso-8859-1?Q?kb/Z6Blct+IFIcEZE64hRC63qEYYL9eqNL8/O6iFymWGbg9O1QbBMVrmk1?=
 =?iso-8859-1?Q?JP23wgMhGosGKETDcDIMPyEoap14JXvliCUC7T+Bd1IgtbWv/R7k6saZgV?=
 =?iso-8859-1?Q?XPWNvD2QgfMPqPeneEEr9Q4dx8Aic28Fw45b9gJEh0GLcCxpplH+40ax8R?=
 =?iso-8859-1?Q?u345EbqcL1IWLyMaZ3aWPX3BvCBoDA+Xetmd7WWSA7KAMs/yNfGw0kNpL0?=
 =?iso-8859-1?Q?6Rp4zLNrzfcT2+AQImj0o8rm56+JrIDGHwCfAEV48oVBN7DsPo1AboTU3j?=
 =?iso-8859-1?Q?PawJrkfL2Qbr5ATocpqn1RNlrUxYHTZW9fjK+TPIbUup1DGS1m/o8cgIFp?=
 =?iso-8859-1?Q?d3t2b5l7xAcbASC2DwW+Q6a5xJwcRltPy0QRjOk7+shaB7IawCCWR5xvJ+?=
 =?iso-8859-1?Q?Wh/5XzV2xs0r+vBFY7ZNmGCATpzSxyEoBd7KYy5R4Iz76rXeMNhVUDIvJk?=
 =?iso-8859-1?Q?GQWJRxQo379k7UOExoireV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?2p5aZzhSh/EG38QvDTuQjfuSMx9m06vvvYQL6poI8IAZKY7my1KU1PtV09?=
 =?iso-8859-1?Q?OglqadcjWAhBqUo7bZuqw5F02w6TQUdes+f4WU7Bgkp8dpXTIG1yLFmUfP?=
 =?iso-8859-1?Q?tHsRL693TwMqDfLsQfzZ/BpqW6NpC9ORU3Y6tGxcEm9qkHLC5MHqSJghtk?=
 =?iso-8859-1?Q?tYtVjcdsU2qy/9Sz2WE6GwbJar/lyly7L3Cp3zyjNh6nUiXmqklOMEoVAG?=
 =?iso-8859-1?Q?Ki30Wk5EbU7YtXOc0ImE6x2dfphbWh5/w5CseIkMZluZU7NKDTN/reTGrK?=
 =?iso-8859-1?Q?5eaUXm2btJq1vhQqGjFAG+RnebG0DsPV9UtiJAwbS8oYcykYz5/4B/N5Bf?=
 =?iso-8859-1?Q?gzuhMq1xxSWh2g7GvkZBKIt/sM1Cgx5DStUuIGRB8NPIcivmhoZeFT60lG?=
 =?iso-8859-1?Q?3zp1ZFsnQORylghdLN+lQ/H0CAjVAUCH1rjC3MGufggFzunrNl8jV/zPPQ?=
 =?iso-8859-1?Q?fceVgfDOOKDz8xmfOeqTsqgs3fVqW7DSug2ZBxwYPHXE59/ZW/veHdK2Lg?=
 =?iso-8859-1?Q?OfnUEiEBQd/qEXmvBcIhEUmGPMlCyQi29sa5y1zxBdXrzcFTlchoFB2O6E?=
 =?iso-8859-1?Q?1mK2njA07r+ehcJCgXEQSBGL0MDMZe0OgWl+U0XtHLDhRg5P2RD9TWtV8l?=
 =?iso-8859-1?Q?QjSYuzD0EPQrcIIMoABaTtQBoB7LcnDT82hHCVLYdkSWEQDfNXvO9r4VCs?=
 =?iso-8859-1?Q?kKjhiEsutOq1YunOSBDnBE3p0f4ebrViTqSUvIqybYvxiEyPM/vnNX6bu7?=
 =?iso-8859-1?Q?5iIaWx2e1IXANhvlcUWsJwXUzlWUZSpjatns1KfBfsMcJIoilSX0fAzqYI?=
 =?iso-8859-1?Q?CgM+y1OMKMkLpBoZcSzrFDhX0nYyzaEMw37sv2Kf8NCFlqumEIRDrE6H3j?=
 =?iso-8859-1?Q?IPkFuUd3jzXKvTpas+s3TeaCtXwM2p8L3T9hyYpXykNXHE5qNB/CHQKAgf?=
 =?iso-8859-1?Q?cqW22cgKgdcqxM1Ne5xwySkhJG1f2/hieHYqJEgVZcV60bFBRUlK/SkPSY?=
 =?iso-8859-1?Q?aUIYEhS2Ab1yquo7IhgVHk+hdqvJwkYgubMOZketdHVich4uXd7cr2KuV5?=
 =?iso-8859-1?Q?UAeufXnvsv67jM7LwyMdN6/GsjSs2Tso5V8acqXezEsB4yFOQeYIOODwRz?=
 =?iso-8859-1?Q?zpGWJYorSidxtsgiTybYoNarz0miJPeP+eyncFXCbDS8n209VkVZLS9ng+?=
 =?iso-8859-1?Q?Hu0fIKzThI9FiFezYdJnIWj/N3pZdM+ybHELKlUo5UejRno2qF+alMT33M?=
 =?iso-8859-1?Q?Y2465NoyDbKumiQBy12aimGHgl7U+BbvLMdh0j8zoCdPnpwQfvNLkTP5pC?=
 =?iso-8859-1?Q?8MFO8DmVdafsAU+83NpkmFzX7D9RJ2CwQSL/l/nf64KEAR+LVZ94SpQh/f?=
 =?iso-8859-1?Q?1nQ05/Kn4lEoWmX/YTo++uFwOL+beFNQHepVRVoS3a9ySUwU6x1vduS+xW?=
 =?iso-8859-1?Q?fLfaUPnkUQS8iSjJAS7+2pdWR7D5+VWKrR8WQgyKFIgcsctN7HsYKXcX3W?=
 =?iso-8859-1?Q?hMu/EMqUy1PySh0mfAMaJpS+V0lOjUyBJWapJvDcomf+2nRq0MFhOWIdCS?=
 =?iso-8859-1?Q?GGSk7WYioJF0W8ZU4YrajqVObZuOsmoZNKtcQXaLKElyxISNq5r5r/VDsa?=
 =?iso-8859-1?Q?uhRD7uFqZOG3BqvBOBJWFR+fi6K3f7E+Q8YXActqxTFe7CpjW1HgFMIl2E?=
 =?iso-8859-1?Q?mHuZ+2eEP7+LZK7rCTKhnngyKtmHU2f3vEXx78dQa6rbTF/rxLPIdy6NNi?=
 =?iso-8859-1?Q?uqTM4ZlRRszKv5igS0gF8YfGmxxzFsgW1ac9heomEEseDYO0CyJTzFNBIQ?=
 =?iso-8859-1?Q?D9hD9kqwqiBi0Xfa5e+2d6xVxGpLFZH5iD1eO9tYbSzdBeJfSGcgxAmKX2?=
 =?iso-8859-1?Q?5y?=
X-MS-Exchange-AntiSpam-MessageData-1: iRda69dFuGGIng==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb02529e-179a-4b62-07d2-08de5077de80
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 18:41:29.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhW3qIez2y8wOMicET5Sm4xH2/84k/iHgnT58tJPYHO0YhFgUFWL1wLr0LwHTQUynaqautZAobbzQ0aTgyKvyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10702

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

FWIW, I'm renaming this to PHY_COMMON_PROPS across the board. The
properties are common between generic PHY and Ethernet PHY/PCS, hence
calling them "generic PHY common properties" is a bit incorrect.

