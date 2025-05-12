Return-Path: <netdev+bounces-189795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34106AB3CDB
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57EF1639FA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3F6242930;
	Mon, 12 May 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VRjXdNnG"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012057.outbound.protection.outlook.com [52.101.71.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CCC1A08CA
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065535; cv=fail; b=KFQePP8kuQvXwtnSmq/1P95g0YwJyQ0xKphe7su4qztR4i5gEXGRAuDoBPxd64BlvsJD0thf8WLVPflcDopBcEY1RDFgk30vWxk7D2aGr79ekouNmiZtX8miFm5J8C2YvcXSp50ee0NOV6MROuBuk+ZLwsh2pR94JhtwYufzHbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065535; c=relaxed/simple;
	bh=VlaWVGcnJP6MmGxEr5+dWf8hBu/+GjfF2JV/WY0bbZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O4fiyES0oce+iyvyjqtbwTQt8S0Se8i5lAkW3E3LYpEfSuI2ia7oIb/18ZLl16T1XeG8HT8iBO4mHt3909zqQsrScvX1WDyAtEuBPXL1GqDb6hXrtgcHiowmygpGVb2TUeEzmxc5SuJHudosfDyrGsORUsuuMTPc0Ita00ByTdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VRjXdNnG; arc=fail smtp.client-ip=52.101.71.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9todrpDAMwlDw1jysk1szYMI5z4w3hgM0tptFt+vk5AMKtB0VPcNL7ipQMa3Ke28P51+bGNK3KycngkhIqUgNG17nmtzmvhNkJlK1jYoWeYaRzJ2xxPBb6H9kLnH3QPHjwmgi+jXNPpV9bmn2tCpaFK33QgUQT+TTXIymIyOoZyqK/CCWGRMzBTW0zxpWPpy5kCS7WozgBVdtFk5pXKygoXeaOKbNSUpdq277RoK0SpVtM3pWE9ByyGGUR/84tX6grOlfsG0Md9IRoR/agzj+VH8UNaRinz/6V1uaB/e0Qk7m1OJ9hNezmfvfAIEIhLwawecuOYyM6SdmPvop2kJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf2jn9KCxWdWaoOzMX0C43Jg3QFUvUDDLDf8GVM8oEk=;
 b=rkfDC/oDfoJwgxf/rIAk+0SeZ74babCxcapLrAnu1wloZw8P70H8I9I6i5WIEK9q/z3+HeNIxKGbOgsC5nJ/QIx/dlHiVpbh3Q0o+sIjU7WlwCrOD6nyw8Z/UJhcD3WqiLjIZdDcZqG33l5o23rJA15KULZTyBGu7pPMBnXYgmqkkGsUXY4wyJhj283Rr7v13P2ALzEWnKkomSeBaDw5hKE/QxAb8NDeAB7IilJMTxY+urJu4g2RQzwv9kLx4J2ETFh7pYmYLTJiEswIWQITJX1RjOgZD5a/MVPLIKwCNyWKBzBr4nQmC/7p3NQQ98KrDvu6XT3TWL/DuDQSyHVN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf2jn9KCxWdWaoOzMX0C43Jg3QFUvUDDLDf8GVM8oEk=;
 b=VRjXdNnGFTVUkDUwwnh51F6WUQmTLsYspZXns42B31ElWTX9vI77J+91THUG3I+KfieqKzcz3c4JTpfvTVETdqps25JKeA065sq5VbV77AqWhyXneRQ0M/QnVN9N5bss5dcPjnxBAFbYqoZ3RzqSfJwLffqRn8W8LQv26am0LCu3c5l+/Jw5cC9o8NKoeOGH3sw0rXVrF9lyBDX3dwMOhot/iLUWv0czzNJedzj6871q7RgIP9RNqANYWKH5R66P8mItDqe03CVfH9x54OJYI5154nDTHfyzt0oMC5nMbVr+W8+HlaYCT2rV8Nm+J5ZWm3PKTT74QkwzbXcq90LsaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7822.eurprd04.prod.outlook.com (2603:10a6:102:b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 15:58:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:58:50 +0000
Date: Mon, 12 May 2025 18:58:46 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Furong Xu <0x1207@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250512155846.vbmc3wrvpidbzxqc@skbuf>
References: <20250512143607.595490-1-vladimir.oltean@nxp.com>
 <2ca5f592-74d3-41ff-8282-4359cb5ec171@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca5f592-74d3-41ff-8282-4359cb5ec171@linux.dev>
X-ClientProxiedBy: VI1P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: cb620f09-1a5c-4c2c-51dc-08dd916de284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZBHvk4b0IDefolb6KBRiYOf9/K3ca0/iw/yPchwAfuU3GBFskLDv8jmDRXYO?=
 =?us-ascii?Q?gh449DU82q7xi3jxmIU0RLn7wn2Zum6a0gtG2tFDZkC23J6Vq0BprG+pnqr7?=
 =?us-ascii?Q?/3NCt7MHsYTQKz2Vd46+xGFzsqhcto2yz1FT0e0gmh5CPvUuUX+T2VZkR8T+?=
 =?us-ascii?Q?96yO8dt27l9dfKTHBheAkwsB8MP5ygoMDkRcyzWrzoIPkUU5AbUOFmPyOMr2?=
 =?us-ascii?Q?8Jx6CAASKxLRT/4pqxXSTj7xLzr1A+7t5hU/Pp/yDNQD14FD4DgJIy2wtjf/?=
 =?us-ascii?Q?Ds7jzvQHl/nCzr+cUaX3pJVTA4G3+W24c+AMn+t/em1cDl3tH2wBrNXoQW+f?=
 =?us-ascii?Q?YqGJ683yiQ1RNDGki/5O/vpbHx1YZ834N7uUrQM5ZK6HmIujFV3atTqKA1D+?=
 =?us-ascii?Q?15TrTJ3JYtLZAoiyz/ya8x7S7E67OiZkkhqsr8VvMJ/0vtdjCcrC/HmcUg1m?=
 =?us-ascii?Q?4LzMzuv1jdogb+RYE1RmspC1+FZQAhvv+xKNmJ2CYNCcweSj4yyQMzpLXqy5?=
 =?us-ascii?Q?NfgNx/muv2/gQnS/xqzMFZRb7AvKItWpMpAm/3zSgVQVe/iDqtAMMj6zDfZ3?=
 =?us-ascii?Q?bMEa0dQN00se08/OG+TteCLl0bRkentRUoF9pE/jMMww7Wy5yElvZxa8Um1N?=
 =?us-ascii?Q?LXzwfC4GSszSWvNBaLzz666i4jvKY/NDxi57l954Ep5tIWyNJvvujmsxwjQy?=
 =?us-ascii?Q?HQ3rpR+jS1a0gAIee0O4DakjSvX+gS7rVErEqVxj/qp8qdlnr2mFsMHInVQx?=
 =?us-ascii?Q?VgwqQuPABiGoZmTk1fdessH6QoL1InIHaky3bxTg6uXPL2zKZF69grJ29QSo?=
 =?us-ascii?Q?tryCfV3Sc7rS9uQJKx4RROuogLgyjzU7rR2Qv/gN+QvvRCAuwE9PELUgVVBr?=
 =?us-ascii?Q?TArAKy6GsDo9WnYWKyI36EwHjeOSe6TP5bB6JVcI//E2SszxPF4OaJGiCD+B?=
 =?us-ascii?Q?1h1+ZKEOQ0HLslUf+bpxNMKcQFoqPP5WM5VhVaMawgfvijM9ig10oehVxiCc?=
 =?us-ascii?Q?XfdCJ6pcds/968gttRuR69XitW1a2rfyq/AIUM5zEIC4e39e2ekypZydcc12?=
 =?us-ascii?Q?H9mMd8gXWXdPzEiIXGzPzvkn53I5eopXYXVPAUEZQdKIRSt9DNO0p56zHHwY?=
 =?us-ascii?Q?m8JOInSItnn3alozTmzD7m1vbw3gy5XOw/nNocRyBXw9kjIC8OWYYtul9O4D?=
 =?us-ascii?Q?r71uJphfCYwz1wL/EwL3j7Rk68KCKB4AgPGuGK+ABdq6kvSIWFYuEA3YNqIY?=
 =?us-ascii?Q?6v+I8lkrYOyLEZNcymb3xyae4IkorUizuWjpzy8AC2ZCq2BPEZQODkqcusXr?=
 =?us-ascii?Q?BXQpTThZOUW5w2sMI6WOEdw2HiyErTbW0Esl0vG3B8Sk+4DyAe89cd0wH0wy?=
 =?us-ascii?Q?ZpZixqwo//Um5RocGZ1+WgfB3IlmGNhwwrYEzuKrYEwItz+eYPYKCP+xjoti?=
 =?us-ascii?Q?Khe1DbJMhw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CF5i6SrVA/GFqN3HiKHb50+wJZCVcG6e3H+ZUq6nu+txunkr0e0RjJoc5IBl?=
 =?us-ascii?Q?8cxq8gixwJg90a3tI5JNBdiMVyUdksr2oiASzBDRbj3L3201PeSHu53Q1ce+?=
 =?us-ascii?Q?7max+0yOxHIlUchvwWEsQLKMUtD/fHliK4blFYTpcvOnO6xYwAqcWqibQVok?=
 =?us-ascii?Q?DzGvDr0tHkIQhMeQpx4XBIAN5F7M5W0pEiihHQJjvp4g9wwYND+hPBV0CA1n?=
 =?us-ascii?Q?B6R53pHT6wy6eeDRJVMNVPFtjhOZMwBjz2h10Gralt474bpOBrjkYbytuEXO?=
 =?us-ascii?Q?vdDQnUqSCDb2C4hwKEGiuc+NJQ4NxP3pGnOlqvcyortJJrsgkQb3G/BVrzAu?=
 =?us-ascii?Q?WS2eAXn9+bUgR3XoFGc7f/PVNd3/+Ry79Ri7yUxx95jNtMpFHgUIeWm5tndB?=
 =?us-ascii?Q?MrXg3Lr49KmCf4hz4BxsDt3sfl/QcNPwovpcBXaYr+LD0k8Rl2xIyvG9Bqdv?=
 =?us-ascii?Q?tOGVS4voqT/3M7mBOKf8yNPRu2u5JBWwEcMO4htMi6Nbtoruun5f2qVVeJz3?=
 =?us-ascii?Q?QZ3Txp6PAVb7A4RVPrSkR2JPkp0ayZy3aZmYUQQvMVqUljU9kpfKSFFeZ30Q?=
 =?us-ascii?Q?4SGK33kqkckdkH9aFYc3cOfdxrVxJxluCXF2zG328564GRBppY5GzK3taEen?=
 =?us-ascii?Q?/AHncqgOceWjJXIedF4ffo9S1ubkTuFRudbolJ6FK7DPH42KknKDfLTl8TiM?=
 =?us-ascii?Q?afYmugnOuVouU28x8y96uF6zs0VYfQl2SUGF4DmohfJxsfh3yIcJaZqrTcIK?=
 =?us-ascii?Q?awaM7PJTGpro4sD9+QQCXeBhK9F/opscdhGj0HfN20ytWtjFuY8Oj6am1GL3?=
 =?us-ascii?Q?KG84+uhnvSPc76aeK8+0eV2aY84CAf5GZXcRgbhsypIb9zzIPjgB/RmFV2wF?=
 =?us-ascii?Q?i2488QMIJCVhN8GxFD5zVo+9CBAZL8iMXQ6lY7sason+0zgT8TW9fgj0usEI?=
 =?us-ascii?Q?boKssSkjR4kMrJZAoifwsl6WJspQ0DFvxEXtw3mWal4AVVYbx+obE14pxHwW?=
 =?us-ascii?Q?pwV1OpE6PoO2jQQr0hKJx7/cLlVJ7rVpsb/VrvCYg+T49RNDGEiTKn2G87OL?=
 =?us-ascii?Q?kOVD3qn+SJzbLj/8D9lqdZFis0UZ8TdyfYtm2YKipaVWE8EAAiSeUnrE8bNh?=
 =?us-ascii?Q?lEj08ex9QZ9XyYvle5MmSTGqJu9srCl5QwzoZZwwWO3xzPqNUNCiO01uG68t?=
 =?us-ascii?Q?iZdcOPBwE60wMxMjaw4khyh/JfcSriN8OCPJE+cBNlO3m8sh6dUTrWEIPivX?=
 =?us-ascii?Q?xEs53CiL7cXbvxdtgMjow0G8UneWWyrgS+8E0QsmH4ihYA22B2naTQUitL+n?=
 =?us-ascii?Q?DxFDKovmE74DtNHbI8XE3kCIqE7mh9zdoNwbdgF2FO9771BxT/RlQPgtDixK?=
 =?us-ascii?Q?1HAlASKHVx1W8UzBrBdsF3RH0Vj4fp8SZDcbGF5/g3hy6N/dUFzCSt+MkhWB?=
 =?us-ascii?Q?5m/ejgExeZUyzvg2YTjed2bHcMRWSaSgZ9fAhF0CbQK1vOZ77ZQQ0jG06bj9?=
 =?us-ascii?Q?qUOSyI7ScAa5GL31TdiJk+JzPKo4BvBoDn8YAf0iN9YRawaShhqoXrvBKtoc?=
 =?us-ascii?Q?6Xz1KKI/wk8eqRbLFRQBBQLkYZuPNQhN+zjDjs3zCW4ZqBwKz90dnlNjdwnp?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb620f09-1a5c-4c2c-51dc-08dd916de284
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:58:50.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mnBlas0vmo6m2sE+jEmFSFSV6fLCojDt2nEVs6b4wl3Pc6nWpmx5wJr7/U/DDe+q4bKm0EXDB2CCqclgzW9Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7822

On Mon, May 12, 2025 at 04:50:35PM +0100, Vadim Fedorenko wrote:
> On 12/05/2025 15:36, Vladimir Oltean wrote:
> > New timestamping API was introduced in commit 66f7223039c0 ("net: add
> > NDOs for configuring hardware timestamping") from kernel v6.6. It is
> > time to convert the stmmac driver to the new API, so that the
> > ndo_eth_ioctl() path can be removed completely.
> 
> The conversion to the new API looks good, but stmmac_ioctl() isn't
> removed keeping ndo_eth_ioctl() path in place. Did I miss something in
> the patch?

I was never intending with this work to remove ndo_eth_ioctl()
completely, but instead to completely remove the timestamping
configuration path that goes through ndo_eth_ioctl(). I apologize for
any false marketing and I will be more explicit about this in further
patches.

