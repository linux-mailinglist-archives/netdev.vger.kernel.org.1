Return-Path: <netdev+bounces-221796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8122AB51E0A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853A01888507
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B630272E42;
	Wed, 10 Sep 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tkj+gD98"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE641E520A;
	Wed, 10 Sep 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522565; cv=fail; b=YxjhRriO8GMB+kTwbgc8MNCzL/sn24cV3JkffM8WumHQMUcDw3Hq6n6u3wVnVjDX99RaOF8xWeqTK515JbxCoNT2xpt/Su7UqOTRJMafy1UInAuaR/R9Ib1yCTW3pPbMrY+BJsy6hweYn1PtCaEz+jRqGmFMXW187UgGzOjK6MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522565; c=relaxed/simple;
	bh=Yqm3LCP4zUZBtTXb/bnOXl/b9D9SsE4hicqKtMT7r48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KXTWg11WfxGDj31AcRSVlrrG3hVdiJdDZgx+LxyvbiSdkkf3vA+kCZnyYI1RoFpwnSL5qGbg/DyBuRYJ5H7ehnnQQ17fY4GvAW2pjasvOFe4406OM1i5EIsQ2kWc9jt+l5IZoAkAbU6Hp+Tu+4hXR1E3hMMQTVURbdt3XhsWmJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tkj+gD98; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMfRJfmcmWJ6WRY0YHg9HeT4S4jaBjwbW+iY8qX0DxZxInR0yeTNy1xq4h5ufv6X95j6gjZ67DLWzrva3ehUoS0yBoBngYfU14YurLg6G/iPYHEJKpQPEDsOpevrMxSTMoNvOYMi8wrp0F/rBG2xYBd0tfigy4fgMJ3KhTCnvHQx9W7sNpwXiqZ7oLAfwZG7taoUiqAX/8PgDqXOKKX7SKO9FtkDJzPueilAZaetHNCrHQ8OgJisO2h+L8YXfl285PgShCXBcs3kdA2Qgg42YNBVN3TpSjKiWrMb5+yTGvOsUkRSb5B0ZKqpNOOk2ercwXn/VWjU+DwYUAvMSyF7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z59v6oHJjJ1AhopuC9AX/cX3aRpxgJNh3b4rVCQTs9w=;
 b=KK/OHuqxoHmZEzx3JVAIeDlM07PC4gyZqpn/ubJmyzPTsK6DWSnT1jzXEA1gWBhG9MVttQchiHBr0Ig/W5KsfRrLdxSC0R4pnpnNr33fuz+FHisFif/mh6L6F2FkvbMqumv8D/3jAXvtcrfJchKHK1/IRL47udlum7IiYanka79PGw6rf6J7jcl0p7Xa9fHLm1sy+Wyl1nPMOPXdIYGGCuVegenqwiFRYPvHTGN+I87txlWagKjC9FZvTyjrQp7eXcQj6CF7kJT+DIjh4ybTFOXeyhKV0abg+KmrZATbhTsiq3uSo6LTX+MpRkbC2RMpZoSyF2FfFGc+By0IDWuXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z59v6oHJjJ1AhopuC9AX/cX3aRpxgJNh3b4rVCQTs9w=;
 b=Tkj+gD985MpyjAU3chtYqosu6AXeZ2vlegkMVnVFdzbtoyoLn+pG8ch7+CvvRId6HnAia/DB8xjK1N/q+9T8Ja0LCiFn3BszJDQay1NpNEzhIvWaYEBZ0O0Ievxle3uSdGhu/7uMe54a+etBXQIMRLqI8qsW6tyRnMbTlCmNQoIJtriXhsaIg3tOT7ii+jk8vmCqF4zRrcN6O0pGaiV0jxRy8osG9gvkNA6MByssbniptNkYcRmtxHnFufjWySlq3XvJr7Ux0QQ4jTRpercvRVHLnfIvedYUxmpxoEEeSjysh/888mipKkUlanYdca9ArAeGpw8iA6yxu7vdExry4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7416.eurprd04.prod.outlook.com (2603:10a6:10:1b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 16:42:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 16:42:37 +0000
Date: Wed, 10 Sep 2025 19:42:31 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Jonas Rebmann <jre@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-sound@vger.kernel.org,
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
Message-ID: <20250910164231.cnrexx4ds3cdg6lu@skbuf>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
 <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
 <20250910143044.jfq5fsv2rlsrr5ku@pengutronix.de>
 <20250910144328.do6t5ilfeclm2xa4@skbuf>
 <693c3d1e-a65b-47ea-9b21-ce1d4a772066@sirena.org.uk>
 <20250910153454.ibh6w7ntxraqvftb@skbuf>
 <20250910155359.tqole7726sapvgzr@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910155359.tqole7726sapvgzr@pengutronix.de>
X-ClientProxiedBy: MR1P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ebedae-7742-44cd-e547-08ddf0890cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?afiJf6kRxr2xcLDNyNoxX1ad6VLm1drq+UEofJ7DrpWBFUx8k7gDKrC6hh/C?=
 =?us-ascii?Q?81GuTMy1wDEKRyw4UgX9IDsYBSZjwP88jikNSDUBgmD+Yc4inzbW0Mg/YAyN?=
 =?us-ascii?Q?OBtaJdu394+qbNMWB3SJRCi1XazC9Cc3p8OEGe+vzRTrMpNB1dxFuW6bTkBY?=
 =?us-ascii?Q?Icm5YlboAJx8fykGmwD9qGB7PtNJKKX9k5BrJsliWR+I4zxJAyNoZnH1J6Xe?=
 =?us-ascii?Q?IAbJSTYg1oItSwaHbSsRV9Vzn04yyEeq0b8y+bCQ0oBEh1LkHti+YYPC9CB4?=
 =?us-ascii?Q?YNlMvY9gdvTiQV38H+HcmoK3gbqht4W5Ofi6InV/DBuB9jwQyyzRnxaxcTda?=
 =?us-ascii?Q?xLEqEuV8JFb0rmP1io4t8irtwQcewMRgVrd9W+EjiEX73t6SGJlSUgHT5RSD?=
 =?us-ascii?Q?rWttbWbb/L9U6OseSMqYXNTnvqWaFFbmlIJBXpRQWckaoh2HIihpntOH1i9y?=
 =?us-ascii?Q?x2yl4ZYpzlsN3faZ4GO9BAmykvpAA0Q32D1+Zf0LiKNBrjti9ccis65UiIdt?=
 =?us-ascii?Q?XrdwM7uL/ZwyGy8rP6de/rxH2SII/Fu1NoB+6O+skp+5vxpnpN2doDaOY4Fz?=
 =?us-ascii?Q?IqQnmHpyij6hOLLJ7vGZCJOGQt1O6whnY/0x04dBrPGEOy1T+7SPbpWMNEBT?=
 =?us-ascii?Q?QO7LssSZNrIqCy6yqhF8cc/AMKJrEXA5RhUULq4JYDdyB3t+EP2e3YwIyu5z?=
 =?us-ascii?Q?/PvDSgiIJiTw4Weh//9fbFOdUe4/3O6URthRRHtnVxWIjN/s2R7kns/PfWVz?=
 =?us-ascii?Q?prylnxooL6rJjJu3LFib1QOH60CX1a2RqKAtKflW3JV4pnfwEg8ASi/eugSQ?=
 =?us-ascii?Q?QoL37XmOUJmPkZfYg3KdFWmb00cN+MKDSpaK7m2v9Gg4rhdbaNmoDaUkJOwx?=
 =?us-ascii?Q?5aH6UAX82RE5V1o9CCNeWeUgMlBBeMDc1sBLfLwWu2YbujE4KWcSdHZaEG5w?=
 =?us-ascii?Q?4U/5bacErPDAm+jMrFgojjJn+YeqfgM2usYafz2gwMOZy9/Bzrf2v5zqda1+?=
 =?us-ascii?Q?+1TFR0WTCjJWlXxPbHNFKrx/4Ol2iLqnmETU0kDwKLkvoFVSUnulYXlXg6e2?=
 =?us-ascii?Q?XIdismheFzNpHR/LV7vXaV6TJGIDO7JJTHqe+9qYj8B3w7zMKkwhop8wc9Z+?=
 =?us-ascii?Q?AF8xrzfXmk4RY0USGTqKcnGiiiBzMEpzhQu3oaeU/fQjIsnFrKnt5RKgWd5H?=
 =?us-ascii?Q?vLHYxkf15C+AZt2JMunLKZrYA//hJkGAV0v5WX2SxvaXyc/E/TJQrNmCa9MD?=
 =?us-ascii?Q?PN/hgwo37h7IsTRFiJRNbI7I24MLDYWFW+ywl7IjjLUhF5GOFGkL1T+1VPyl?=
 =?us-ascii?Q?aQJL1o38FLn3pIJIrq9SUy+39iOkaCfHMeGnQi9lVjQ2awSwSCY82Pp0mIA1?=
 =?us-ascii?Q?79ViHsyF1sgT4VGMJ4k9kpmpJYmTZYsAyz5R0fGN0XEyWhve0M8B3o7/iATh?=
 =?us-ascii?Q?hTzlVMMJ6RY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pKaEopgZkiWFNxPmeeFnjx9HeKWIZlVys2Ehxb7zcsYxI2XV6Xp/TOo0LiCJ?=
 =?us-ascii?Q?Q2A4fXujiL651bWEnug87CojKuG28A9NFn73OIsOxg4r4ng2YSROiqY+tV3r?=
 =?us-ascii?Q?n4HUPxPSExYeqqNSMW8CGYX/GWWPwSS+qiLHoDu/ZC2C1H4ezoQ2NBlNv61K?=
 =?us-ascii?Q?rsPW1nliZj0rx58ffnqc4A4HTYGHRjLPbHNuwaWt/AvqQw/+BkAH9UC9ES59?=
 =?us-ascii?Q?8v2rxmh2s3SbW4T7tu87MFqTAZ1lnHXIR+2/+PTjQ1GPk1heUcv8WQSSzlwp?=
 =?us-ascii?Q?6NEXMUzxUCBA7kExhIPOrsBC6yCgLA71jhRtZYUiermaNnKK50nyw8Q9PCPs?=
 =?us-ascii?Q?FWS0KeQ20ZDNJFurGzTu9qSTAfoz4EwefV5jFxcUiICJXgBm+muORwCDRdaQ?=
 =?us-ascii?Q?P+koT9bt6BVCha1TrlZcNYqn9EqdF0Zqw5LXlc3FxIWpmSRX4/IQ5aQrSFrc?=
 =?us-ascii?Q?UidcS4u2nCSQvv9x58oS1bmn2hhtWkIjdsfFvy0++P+SS+ubCz2ME/LynR2I?=
 =?us-ascii?Q?vlhQ1vANfcUr6s0+uDxo6nUvdjDjTvpE/6e3qfMqd87uGC+9DxZt7TckYsrq?=
 =?us-ascii?Q?6J2fHn1VaNzxlDD8T488DTWk9pev1EVHHwMPklEP8IVMZFSSksOAvV3CQd0Z?=
 =?us-ascii?Q?FSetPNIAPoYg0iFIqONDzmM6g2n1bxXlSi51F7nwjzyfPAq6iQcTFTgCawo5?=
 =?us-ascii?Q?TFtMhaWchcQbbmdINe1HcA4QPD6nKwW40WvvYFjQC5oyHQdMefbTc/lpKSv5?=
 =?us-ascii?Q?NBG/xT/oIsNjAZUnWvO0diJ073+nW821LeDp4k7XOxYUiIJzpaBjbVYpIY6l?=
 =?us-ascii?Q?d0B2vMmrt0CKOnPDL2B8aHsVH7o2g1mfrZ4SX2/DadYC6xYVyQNkTqde3xI0?=
 =?us-ascii?Q?ekFxoEXYEWflZuStKOb7Qz3VRkc+Huc4CeP1rc3DeAnwAIgtWt1nO1jVc2IG?=
 =?us-ascii?Q?gyUA99a3yDCpvGiHgsXTMvgbdvKiZ9T459AW3jKRRVCtxAdJbKg0boCWU1lX?=
 =?us-ascii?Q?W9FY0p5nPjMu/ajS/dpa43NKXpxZ2/aOWP64+RFJpdBSCetzAOoDzn+A+vpu?=
 =?us-ascii?Q?XveCd4TR27y2MPizeaCBfQ1QLHITJDzLRfIfi1b8HYlTrLw3iGo87NJKd4ER?=
 =?us-ascii?Q?Dj6houl4EK5khQDoHiD571YGqPpcIz9FsmAtUiXboqhHIPGpEintRUdxUKHJ?=
 =?us-ascii?Q?KEMIAuUzt18tuhKwyXdCKMyFuFXrFgBuHO3xzrP2VOJHcuBOWqRAqQZTD+Ju?=
 =?us-ascii?Q?/7AwuV4SBSs4x3V2MkmS6UfIeC7FhRLqnGgCFhMrki7Hih3SPvJH1U7l6pD0?=
 =?us-ascii?Q?JDgz3nAxlybzku3Lz3PJbMVmvd17A72KjsRRsAA3jqPGMb3cIXJdGd8cv/19?=
 =?us-ascii?Q?sTAI62I2QR/s2Qx4KZuUzjN8HZBbqn/gzqXfOle/4Gs6WZ6ABQBaHE6FDPWc?=
 =?us-ascii?Q?2z/VmW9oSGukuAr7BsBe2pJtvncINJ2L/0fSNPsaWAQxNh5BboKLosMdld3f?=
 =?us-ascii?Q?oCqvaEVbIt/2odSlfrmlpzSGu6gq56A2RpFqWRLk/z1uOQ3rSxxXZ5BXYrwJ?=
 =?us-ascii?Q?wteeiJp6fWVIQbirr16yAyMDcHt6KwgPdlHBKwSFV2iiJCjhPdOZEmtj2kPY?=
 =?us-ascii?Q?6Xuj93K7u4rjNR/9HiFjSEve5bcIjxURtSL10BB0BPdHNe6YY85IXsDpyFGM?=
 =?us-ascii?Q?06uvDw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ebedae-7742-44cd-e547-08ddf0890cae
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 16:42:37.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h24HWInZabCzD28UhEPTkmp90tgOLa/85835JP2cyJPm3EfLIXyf8pxqhUJ7c31hNpy+YTm2kiDg0LIsfwRLUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7416

On Wed, Sep 10, 2025 at 05:53:59PM +0200, Marco Felsch wrote:
> IMHO silently removing the support will break designs for sure and
> should never be done. As said, imagine that the firmware will handle the
> supplies and the driver only needs to release the reset. If you silently
> remove the support, the device will be kept in reset-state. In field
> firmware updates are seldom, so you break your device by updating to a
> new kernel.
> 
> One could argue that the driver supported it but there was no dt-binding
> yet, so it was a hidden/unstable feature but I don't know the policy.

Ok, I didn't think about, or meet, the case where Linux is required by
previous boot stages to deassert the reset. It is the first time you are
explicitly saying this, though.

So we can keep and document the 'reset-gpios' support, but we need to
explicitly point out that if present, it does not supplant the need to
ensure the proper POR sequence as per AH1704.

