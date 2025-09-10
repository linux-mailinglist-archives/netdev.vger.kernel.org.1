Return-Path: <netdev+bounces-221721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FD5B51A87
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1A61BC2C4E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C405333EAFE;
	Wed, 10 Sep 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JqwRFBYI"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B893314B0;
	Wed, 10 Sep 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515419; cv=fail; b=hS83NCIm0cftzQIGrJYoEODvsw8kB4ps5rEooHTbHGOV52gmNmD8ZcUZtahPR/nVOmgMfYRzkxGidg5obamzXvx80jux7WAQxGW4I5wUU8A/UTmVvZrGkBSuTghYT6Dz5KQKyTpP/XB39tZzAUX3LLecw7jS1nIwLBSsjskeR1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515419; c=relaxed/simple;
	bh=cL1+/oe/Qbt5tQ8YuxqungbmTgUJDslhexGyDPwvtIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a77+mHnF8S0FJw3E5A9bQf21mVxl4TyYjYpI/N6ORCzA1JQDfkLzLlLpDj/fyC80dZVwmFblQ4VZzn/X9rLMwKw3U4+WcouLWJ/3+2bAX5cTA9o8AliTgH+vWLQbqSKkBHkzZb0qQ9G+YNwmTUPW6t5hgph23uF0b22ve14eKrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JqwRFBYI; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHPG9W/5vNupr/K3fdWNsAZOCYGkZ5+ANBH5A3HsG7WJn1ZK+TtF6SZmy9PMGb8M8Fb0iJWBZi1jddSUpXNJ22bt1WpFSnaTHJzDRKzi6nYbLRNX+3CzciPbdX86oXsb4hVfu8OHYjmS9Xvic+W+ZauFKnmF4ZDLrcfyS4wVwjYIBc4OMFFa7/fd9e3T6+zC4wZrw0GJjk9XvBLx63IMmag7yh5i/owMLJN8gBkj/QHXSm4CU/C2J/T3it3JMmY/xCENAK39Q8EMTj/R9llU9kxkcIHSd7r9Psu1S8DqaCQuWNGvvYt3+a/rPun08gmYGNCu++OVTj3MTzn/3omm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHY89c2TKwm71DH44bKX1oivHjZoVZz21ATPdjAYUwc=;
 b=O0xlqUmApMq847dt2VnpWs07/HfdUg8AGg00PCmt8S5Fb9r/qo0Z9TB00dylJ3Wx1XbyEewoDv2hsGmFwWMjbwcKAoLl+bDzpIo0Btg++BHugpWnjivOXLbQWRq6HT0U5mSE3+YnYmMrDU8SEBpQ0MlrMYLPyqlNPnH00s/KhRq8OwUL+LTerMIjvMDlrm6+kwRIbYHF+oYtOlryyCIXCsgt0YNOGP5+LORKSMyZOvGSSIkNGvIQuOKNoA8KojFiAi/xYSQwh2/qime/KvChq9oH736ufxS/QGQ0rpBmCaUmYPyJIMrQfJRiWlUYw/cKEZzRzO5dYxcjDFImvTQptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHY89c2TKwm71DH44bKX1oivHjZoVZz21ATPdjAYUwc=;
 b=JqwRFBYIGz0YF6Gip58NdXVD5htiNIRoslRG5OJQpk8NaKmJFa4eKd350RlkTuLAKPA0tR2QcJ5uyfQICzvpiINWwW4495g3utHae5awCp/A5mombhjIxI4nWi7tvaVVg0Rl76XoEP9/Nf+2BufkReoWqT2emeS0BGyNlg80x9IRcq5jlPDAVilOFUqjaSJK3idI/88TDOF40zcjbZeXgPiUrf7PZCi4Ou7JaT6+9tgMVzZGxeRnDNz8WKrfMMZyDVNZWC3QvH7I/EiBQn1d6/mfRSqftGnnqfsiOIUpbTqz5bXIrlG5UpQ/d9MbGl+nnd3bhZReb2DkZXGY8IGBJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB9680.eurprd04.prod.outlook.com (2603:10a6:102:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 14:43:33 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 14:43:33 +0000
Date: Wed, 10 Sep 2025 17:43:28 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Jonas Rebmann <jre@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
 property
Message-ID: <20250910144328.do6t5ilfeclm2xa4@skbuf>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
 <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
 <20250910143044.jfq5fsv2rlsrr5ku@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910143044.jfq5fsv2rlsrr5ku@pengutronix.de>
X-ClientProxiedBy: VIZP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f54c46e-004a-4635-ca27-08ddf0786a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1WzKHkUmcts730uMc9xp7cnphQUhmJJ62AtivfFMJ5ikQDMlbFxhy3Td7mKE?=
 =?us-ascii?Q?KRYejx7IRmjdI3VBlPQAaYhiBC18cwvqFKC+bI1t9s4+5TJNb7GWGzyxGIJZ?=
 =?us-ascii?Q?7mtGLTD4eta/I2XLJIXEVJbY25UAssbscsP3jLOfTnUBuLhYQWvnsspN8NFV?=
 =?us-ascii?Q?3qSWIjVVFJVwPiiV0/DhxEVloHJBg/8D6ENQPy3KbSJ0f2alGtdW2kfnxgWS?=
 =?us-ascii?Q?c+Xexg5cVZcz+nyFJOBckJv1G2avfqv6ZmLn02V25t9Ulcs8auD+q5AatTLB?=
 =?us-ascii?Q?Uvhe64MGTvkAaRVR0s+2MVvETgGu5ZMr44lvok0V+smeE5mcfORgFqoM2l9O?=
 =?us-ascii?Q?M/ABySFe3fcxbVArjK0nWIK+xLV8mY6Myvc7KWHgnoZORs2C2BJitrk9wPU8?=
 =?us-ascii?Q?hl6kT9ly6ZWcd1J5Yrzxx5EhGviok+sHiKzKMrSjB/XfMjT/PGUnrX5zwzXX?=
 =?us-ascii?Q?zhUDMU2lH1oXJKx30zpfMNl3ABk60XF6Xo6GWHuI8aC9qeCK2z6I3hnmw7lq?=
 =?us-ascii?Q?UOhw+fYpgAlh/MyFj6TyuC6Ngrb7csmiYEfvKEdu9O8mHnj4akKskTmZxM8v?=
 =?us-ascii?Q?i5VL9Uw4+BLybZ0ou+gw6av5DoidG7SzNJIFHZme1HaxegKwNFcD/NnK4GKW?=
 =?us-ascii?Q?xZxshmA/kZfyLRN1P31oeolfs8DPH1mpl5fW1w/Mg26x3uApCsNFZxLgc3SA?=
 =?us-ascii?Q?+P2rQYLNUa7W7hFXKArulNLmMFqTMWJAzvFyKe0nirlgtvwrlpaDyRag3xkk?=
 =?us-ascii?Q?aLiC3iapGM/uORl5vdt5PBqSF5KFoATDhPMVFGtg+HEuidJRU8uGUOtjr1mg?=
 =?us-ascii?Q?RZ8Zbf1Oj/8t5q/ztTq1Ou/fIuLCBa7DuzXR4ohFlBKjTJd/abcEUFciVGDr?=
 =?us-ascii?Q?eMX5YX8fVAWEV58M4vOtEkLB0Zu1aMZNTI6I1BkA5P0V8uFWEM4yiZsyS2F2?=
 =?us-ascii?Q?HfMMqTQJmbaUwMWDedtu4CrVtfMea/niLrXPpo9e8/3JwADzJxoYDFLweqLh?=
 =?us-ascii?Q?pliegiwKw7FVcv+sDs0Nctx3zsouc/UIeNWE0iUrcYEIDLTAj3aFiDBcw/Vl?=
 =?us-ascii?Q?Tu11Unbp5fisNkqs4AJVL/wPaQKjUxfpW6Btrlw+nNmH3PJVLYETgjKBrhj1?=
 =?us-ascii?Q?OgMjEiZpuXAcExga8wOytY8pBfnk5tA0ARgWNzObjmpxlUrWjdGEJUGvxj4A?=
 =?us-ascii?Q?6j6JEksjtn5e6cOV4fHZRTqPl/k6M6pjW13vEYMx0sUUmTRdyP6CmEaVLW2L?=
 =?us-ascii?Q?qJQu/oD9edTRvZxF2iM8jKi9nr4J7E1AM2WGhWkaEaXE+C6UIhW6Ti0JZwe7?=
 =?us-ascii?Q?9/M9I3eNfPwny6xC5/CSQKI7rEpclchKhYLiv82fGtLDdrPA8QabMnoLo1aB?=
 =?us-ascii?Q?WPGsZt/alJs1jDUtV1y+7r7fgMbELMFOeTzgFIWVy+Vci8r71+56n+FoCykz?=
 =?us-ascii?Q?GKwP2WqMVA8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZV101l1gn7hqBCpcV5QyS/Zy/kxibfHauMmkgvC4futytPwH5HLBdPKwOm/p?=
 =?us-ascii?Q?5blIIi3ucdgJLSRv0a1y3gHZkrztWs148d3pQ43axbJwjIhqC66bHREIetTh?=
 =?us-ascii?Q?duZb15Vdu1Xy/xxKbaAK9i/VJ79fiB19igJm+8NLfisgsRfFapi2edXz3tAm?=
 =?us-ascii?Q?Khuxx4hD/UOTpmQK9pNW/r6B7zP+Qxp8xHbYoTdCv9v+bDFV1DTtOt29Th7i?=
 =?us-ascii?Q?7Eswu1QwjVoDh/8f2BMqO7IlFAePk0bVwCaGWn4rMGawHXIguaZ4Df7XUSxD?=
 =?us-ascii?Q?GerRmCLxsg7d98VupJ0zT1NVkhszKB5BHxVpwM2HBVuSPsoca/ZmwT3EKyF7?=
 =?us-ascii?Q?HLmAiZD+IgpvbMwMAcf0QJaQ8XgWQ1NiNgf930ywtlDNf44Pl3I2MZOgUpgg?=
 =?us-ascii?Q?NzLUdAbEmdPDa7EUBCUuduLS2he+yagxnfY0SPJncf7gjoPD/XEu2LzFJfUg?=
 =?us-ascii?Q?FSj8/R1iDG81gSWGrLBgLHpbUwJxTcQCZkz2Y7T9flMVQZKXnfS1BPX23fnu?=
 =?us-ascii?Q?iOKqQUTJswzEnPRmMbbgKHmjDl5YQo8siXYgrCjqVe53/fbYkQFtxGnTGLUb?=
 =?us-ascii?Q?g6tUEIJmv4ZATPewqX5wYrP9rYL8JALRBZX0aP/sIn1fQPlAyqoBM2Qg7ekB?=
 =?us-ascii?Q?4cVv/1OMB//TVG9CNei6qhz5qh6eSK8zzo8k8Fw2CpWl7TNsxAeNSH4ityH9?=
 =?us-ascii?Q?Qr+PEqN5OsRtG4Sb7rV/1r40fhUbp4zq3ZziqtQxNt8c4oCwIOFzjhbj6MO3?=
 =?us-ascii?Q?xM0yXM1Qz0zpMBrk7njBrQQdPZlLHuPCbgFB0oMzjWiyMsDtPMVz/WWFmhdw?=
 =?us-ascii?Q?zzbiX3W4ZZfwFbsG4x4vHFhtzOI0a/nq0luloR9aGMFsTFJPo2uon6dJINrv?=
 =?us-ascii?Q?JGhxgNX0wDI1OqCVSSU5hK5pRvpi7bVTIfNWCeHYvpgTfN7PzYnZU++PiPMc?=
 =?us-ascii?Q?8pXxyIUUEKiBAXVUTiXQm3IsouQtpGohzQfLmnz5aSxCPrTnG9nLReFOxQQJ?=
 =?us-ascii?Q?BRQaA2fHpd9tVhX0GO2fyh0yV39CVnuEqlmUjcMlSc7gy1KiUip9FCvJUMdx?=
 =?us-ascii?Q?qgLrL9puSTLC5gGQPWGOyFslHPbpne0LPxjFjKejg4vEqQwEaErqqVmBoOAb?=
 =?us-ascii?Q?NhOL7JJnl0zWicg87nZyBJZyaGHYbvPW64iGlkTHVDQErc1guqeDdEHFS/LW?=
 =?us-ascii?Q?P5lpwJvVS7Yrw71B1JdaZHGruF5PxTs7RVIU8T5sdoMg53d4HWyDGZHvEgP7?=
 =?us-ascii?Q?7euaL7rs95zjBqg7KTbEqyarEWKA3ZZkw3qYX+EJWyOcO+3aQdJaBO27ygnO?=
 =?us-ascii?Q?TieJ/SehjdMWVvTHtaNNnnUJTt7hixSwFeutb9GgbOp6swpqvbPU5xNwcYq8?=
 =?us-ascii?Q?kW92aZVISLH1HGdyiJaOukFkaD+8eQUwJvCKhDgplvX5xXWIbyzZ8BQluYIc?=
 =?us-ascii?Q?eTsT/RQPMi1wQaCHFbBBgPS3fEucfT3vJgpqprTGWTIM3axmX5NE6fDttl5D?=
 =?us-ascii?Q?OoWsIcrU+MJyxd38jR0ufYpwrR2pvw9xeRztinZtq5QWjFwfl+7QSb/VrMSe?=
 =?us-ascii?Q?bFQzwtx5rngBzQrRuQdo2AQ65z655h7uAX1L7lW5z5xgNsHaXnn5T2LZqw4e?=
 =?us-ascii?Q?gCvij+n547jBW+fHn6BbJ7ijZ9xOe9mzEx+VTYmrnkPWmkQmQGJfx4iI11Nb?=
 =?us-ascii?Q?YJP+Rg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f54c46e-004a-4635-ca27-08ddf0786a9d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:43:33.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK7f0pznUZZDjlOqhcIINUKVGSFrCqrxGoNhlZigbjSGNmXBOafC+uJAcMNyP/s71xuXnkjjMaVEVrSM6xX1IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9680

On Wed, Sep 10, 2025 at 04:30:44PM +0200, Marco Felsch wrote:
> Can you please elaborate a bit more? I was curious and checked the
> AH1704, it says:
> 
> "The RST_N signal must be kept low for at least 5 us after all power
> supplies and reference clock signals become stable."
> 
> This is very common, so the driver only needs to ensure that the pin was
> pulled low for at least 5us but not exact 5us.

The statement says that during power-up, when the supply voltages and
clocks rise in order to become within spec, the reset signal must be
held low. This requirement lasts for up to 5 us more after the other
signals are in spec.

> > Additionally, routing the reset signal to a host SoC GPIO does not bring
> > any particular benefit, since the switch can be (and is) also reset by
> > the driver over SPI.
> 
> I don't know the switch but it's also common that a so called
> software-reset may not reset all registers, state machines, etc.

Neither should you assume that RST_N resets everything. I can't be a lot
more specific, but asserting RST_N at runtime is essentially equivalent
to a cold reset as done over SPI, as done by sja1105pqrs_reset_cmd().

> There it's common practice that the driver tries to pull the hw reset
> line and if not present falls back to a software reset.
> 
> > So, at least for this particular switch, having a "reset-gpios" actively
> > points towards a potential violation of its POR timing requirements.
> 
> Really? Please see my above comment.
> 
> > That is, unless the power rails are also software-controlled. But they
> > aren't.
> 
> AH1704 Fig.10 just illustrate a reset and power-on sequence. I highly
> doubt that the host can't pull the hw rest line if the supplies and the
> clock is already running.

I didn't say that it can't pull the reset line if the supplies/clocks
are in spec.

I said that _while the supplies and clocks aren't in spec and 5 us after
they become in spec_, RST_N has to be kept low.

And if you plan to do that from the GPIO function of your SoC, the SoC
might be busy doing other stuff, like booting, and no one might be
driving the RST_N voltage to a defined state.

It really depends on a lot of factors including the reset timing and
supply voltage distribution of the PCB, but RST_N has essentially 2
purposes. One is ensuring proper POR sequencing, the other is cold
resetting at runtime. You can do the latter over SPI with identical
outcome, which leaves proper POR sequencing, which is not best served by
a GPIO in my experience.

> You're right about the fact that the driver is currently not able to do
> a proper power-on sequence, so the kernel relies on the prev. firmware
> or the hw-setup. But this is another problem.
> 
> Regards,
>   Marco

