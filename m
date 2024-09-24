Return-Path: <netdev+bounces-129467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B69840D5
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA701F22D80
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309D4152160;
	Tue, 24 Sep 2024 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kqO+7sXM"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013066.outbound.protection.outlook.com [52.101.67.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B91514CE;
	Tue, 24 Sep 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167435; cv=fail; b=Y/J96LClGuxZgDucLGz19ayNqxOEo/UASAsuSOsE6WxQLMcvkDLmYRYzEwip6wJhcx1vz/nQs4qYlC0ji+/uLFf0VcVVeIRHGpsu0WfHZ14qafVbu89GdMU3hyYlfKpfy1S/M3IEva7SDV+aBeuEp+A7xSwL6NvLf+sBEv31tWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167435; c=relaxed/simple;
	bh=L3WLWOwkgzFy15ZivQDqh1+GKfl4rba8oEwiH0oOvKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IrfOo8MHrk2Iqe0qH5d2v1S0vptoI3o7DNqxlNEJJIDo8dsupYQ0WgvqN1m20fQg+SNGtp3l0zQM1XrtHpzZvr+aaCqXQOZ7rF9VPKrbSDZu519Bu7qlOcz/kSVNUXmuj8S+PahEufmUxLmLKoyrS/wn+3Cd88K/f8vc+nrLtio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kqO+7sXM; arc=fail smtp.client-ip=52.101.67.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RshepHDIUQV/dVoBbA2EIX1pBnniFyN3gUHcUU7r1TzwmlZeosV5XWYiA7Fzx3T0jlcHJLfrtKSvMJoIKeWiFrDhgfG7HPYfqWdfl2kYlv7B3KcWCVbxjJM+vGixXq1W8YHgEa3kMrIglioos/4e1wd6bH/ld15CzHz6gfkVXg8Kz/o4W45W7Ti6FnFzJNqVEQtOPMKDfE+oEqxXSU8vsnvyjDGtrxE99S+ZlZ5A49ammi4GLJQ3fiU/7PkW9K6+Dv5QCJewQUGQwbUJzBBe9FkJu5IFrqufWCibRYfJcn8m/V2T/UeAuG5zOc8cxIlAiOVpR69RWdRPwOWh9n+d0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egSsnBFCI5wN0J9L2T+qsH4R58tZP95ZMVAlMuLRoqQ=;
 b=oyg2rM0Mkg2ROgAJx6oTb2G5kqVJ0KIZ2S+XdUUOcokdBQF6uEGFyT/nRXp58cicllJGp/E7wSIfbVP5k1r6Es7Z+9c6NOK5s7FT3WtGaqclzZSYZlOYyd/k0JtjEbp/diyorgp9kbD74nY2L04Kna9ggdF42Svjj5y/NqMwO11DUpG9KEJcCmZTGaX7Nrr+cscxZGRsJ1J11xqBsfTfm2+UiXryWNQFoa5iU8cThMfkk0qunhilLhrzkGRmL5Fo68YAuOKqdalRKOzxHrKMubmrPzNf3sXYZiRhozmsV6c/KRYBb5fFJsNWqJymMIJKCnGafMjj6IAPD1SV3/K01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egSsnBFCI5wN0J9L2T+qsH4R58tZP95ZMVAlMuLRoqQ=;
 b=kqO+7sXMzSepYnSOzXZH4hy4iCNudyKNnfGvIgtyttEQE85Vb4VFYrZPGG3HBUGgwpEf0kQ6bvmtopBJrUmJe87U5gqPwAj8MNIl6qAYQgzFV8Efv4Up0p+MooHAsaeUWxrIANSaWsKcyrmF4bSjwQREf2gqc1WsKeBssxx/DUdks2RAJSDFno9QHk+vZds79B/pIKwGflimO96iNao1woEq37qzzrOVPZclpybf4AQpBBayT/eogfS4rnLR7tHA2yoMW5cQ9mB5g5D9rpPd+sHhpk65FnhE/ZoFIcKUfw/2ZBMpfVmm6qi0bkBpPPJkhNLGGNkyN+WvMc2gtDJoeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10625.eurprd04.prod.outlook.com (2603:10a6:102:48a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 08:43:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 08:43:46 +0000
Date: Tue, 24 Sep 2024 11:43:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: improve shutdown sequence
Message-ID: <20240924084343.syhmwim5swcgppha@skbuf>
References: <20240913203549.3081071-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913203549.3081071-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VE1PR08CA0026.eurprd08.prod.outlook.com
 (2603:10a6:803:104::39) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10625:EE_
X-MS-Office365-Filtering-Correlation-Id: debd766a-f2ad-453a-7140-08dcdc750094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GFCW+ILKKj43WzIQTW3EJdzDPZLlJs8aCKYE1AZcwQsRepRS7arXZOGW/yp1?=
 =?us-ascii?Q?VMPm9+ATb3Gc+epG2NvcWYnYrVXRUkop4Q8sRn2wq+iVjFToAyxZhqLogTGb?=
 =?us-ascii?Q?aAmBxv+K9kB1LaERjJJNcpIeDIVb1KgMS/2xepK3pUpiMAOolgSM+CsTn9m1?=
 =?us-ascii?Q?UdaCQJ7nQoZ4GliHZtiOMEmJ+5NMss4z5jWQpexnzlpcrD7Xp/SBdMCK6qBx?=
 =?us-ascii?Q?sVNnhr3UwhAwda8yFc54oeNNIYOK5YNlTK8asYpvjExEjCHXQvTQFl5GBM1U?=
 =?us-ascii?Q?NP60gzZpHEq+wK0sk3RRfcNntGijwuOj9BMlrihmoCleisv+NJcGrOVolEX/?=
 =?us-ascii?Q?D37fCRYMXQUKBZu3m0MR3Alv9/ouTh8ezQes5oNNq/6OYY/mpezgma/DwHnn?=
 =?us-ascii?Q?sJuGb4Vb+hhLj1YhUH3edsQ+9gtqVa7Z3pd7sQMSP2YnY3qLiZL640OZ1S/4?=
 =?us-ascii?Q?CtpU6y49vft0hKKY9sG8lQkagaSm7aGYJ2yaJCUBGg6p/6P648NSRGV22muM?=
 =?us-ascii?Q?SD9e2g0VROVeDGgUxpx0QnYtKL/xsG74WlfnhOQYK2HrGwKi2aX9C9HCN5jD?=
 =?us-ascii?Q?YpSD9WtX0etTUVFFeUEWD3cjfbKSFk//njzkROKhQIhC26pGUwTmMX8vVHvj?=
 =?us-ascii?Q?AcXJnwp5RXhAnKJhhUkBhnOWDExtALZ1Hh0LoxzSf+NvqFDbda4E5PPlZxXs?=
 =?us-ascii?Q?35XFfQahArMg6ylN3i84YfFMun6VQCIKQrs3jozRcYG0ABLBEfF0DfBAFEom?=
 =?us-ascii?Q?Q/PNto7WZ4bp7rkAVPey39bcXWvRBJobkBO8eRAZBqySjQlykAs0bTP54c9m?=
 =?us-ascii?Q?YuI3gJaXnJkJjpvHHamMi4lKUuQ+xMpaLyuRH4QJVbQv3EPBYEUK/175LVl8?=
 =?us-ascii?Q?9E3gtuxaSWDyaYTQKV1cxChYtp3RFww16GK2xPP1RF3QK3l4l/PAd/2aA0T/?=
 =?us-ascii?Q?BqFrBtWwEnp9MX0KTxBfpdGwApKPI6zXtyg5BcxKVGoEznotD5jMbqCLHSXL?=
 =?us-ascii?Q?ljt7frRadJ6Q3+BBxErk4g+isq7uGF/RkBneZo68ylncPVQCEZSQOcJO1Vj2?=
 =?us-ascii?Q?lWBJ1a5dhCZFqgYQmoZ344gNMctZdCCJvnJF4ilkao7uFNCuhlzEZ+HiVQHx?=
 =?us-ascii?Q?a3VWQk/V6oABP+qW7CYIxC3Lg1D0Aqz4dFUQLZcGBqAObSIxP2wEfcB6brjl?=
 =?us-ascii?Q?qAPCc2aDWX/cMDcM8Z2a1n8KgwtZhjAm/E4620l4sO3g4qtKFPxwut0oQLgH?=
 =?us-ascii?Q?umHDuP1uomP5Y1kwqZatNB8c7MyeEadzSLttuoHJwgTWHsrHhOeKtydVdVHe?=
 =?us-ascii?Q?4g/qLTAlBbc35J/mfDPNDWI0gmfax8dhCliG/EA6sR3QEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owskENG9FHO/YH6NRTzo/j78yWP2gVRS3iSYMJNnVpQT5DMzDEJA8mWSX7WK?=
 =?us-ascii?Q?LH86efVWLxc9LLK6qi3Qow0m1VhV9iiGRJMEH7ymGlNoYXU4EnnJdVRP2lbJ?=
 =?us-ascii?Q?BpCMZMfTlLVUEPjLU6t2ytXWJz+U7jlB3CI0eJSdfPaW2yERLMAMpuom3UHj?=
 =?us-ascii?Q?itHqLvLETgYC12QeFVOShZckjqgStOsBinfA77+IecX6yXWFXoBeB19UwnUN?=
 =?us-ascii?Q?FR0MgwUT/eegP9ysC7v0h8l0i9SmKzEDOkckERnxh87IjMl8PoCz5jBVrMRs?=
 =?us-ascii?Q?vjcOKJf/KUR0J4LDNgTc1H6ISE4eKZKpkaRreOTx8kzEPvMWVINc0GfnDP+X?=
 =?us-ascii?Q?kcAvTA0Y00T9gah/KuEarJG3DoTztZpfPNJpM5c5lz4p88L1TuSI2rPq6qkc?=
 =?us-ascii?Q?OYWrWhYlHlCuzgNT7zTxySvmpi4Sq0CLSgybZcXo4yhASbAlMiv5KBcjfyuh?=
 =?us-ascii?Q?0UN4CnWwRB+0p/5lnP9E6Byu0HU84xfnMlqbDe3Oy/m9yWmkLwjNyFDyoDcu?=
 =?us-ascii?Q?fZcNg+uuFJwbpkHxFWOPxr/vNNLyYR0yPZH/X/AeD/Yo+ptmD8cAspav2u8i?=
 =?us-ascii?Q?gKkLF7o6TsRYuGgvw6rLJTjHuVabOg8OhLje7+mb2++/d9C5/eiSIpBdKTSa?=
 =?us-ascii?Q?yuSuHsiD13xszHdhfi3+IV/IyB26r5zblyDvrZqxfI55hmWvApSEaM1hIBD/?=
 =?us-ascii?Q?Bs5A8F0McVIvqJt1zSWfD7W1pybL7RxZJEkNLaIsM/h6oNmH4KKiALFlORXZ?=
 =?us-ascii?Q?XzeA3FnSQRSanSXj8NQyw2GjuPA0xVlJ4rocCjeRPDbDz0FeS8zSN7xa0w2U?=
 =?us-ascii?Q?NlYorBg3VnnrxP3bpNlQvMfKcFLObAjwurbwGDtudDMZ7eYm7ZgTsNB7h//c?=
 =?us-ascii?Q?IqrO8mZpR6gmbVvPAbXmN6zhFuhyYL3BPvQI9c/+/2yfV0G8lBweS22pL+84?=
 =?us-ascii?Q?dUsDrp/YbzO549wk1bmgyxpiWWbrK839AP5EQ5rQFXnucZei+icqQXxEQ2s1?=
 =?us-ascii?Q?Ma2hev8kT4Mf1sJkl931i2hKsa7Zxm5R0N/00YVV7v3PPqyWmjFrbaOOBQb3?=
 =?us-ascii?Q?AUUXfJL4rlDy4VYIgRAUb+yHRcCvqwY71zRlwY4sQEXI1Qv5pPrCkQol99LK?=
 =?us-ascii?Q?JjYLRkgiSrpp2uPODgCej8yaZH+dD4oI7+mshYSSToEebntVZzMiYv6V7+kf?=
 =?us-ascii?Q?TNQcmX3FyT+ITMffpwbClRIi2Z6cU4TauEHp/joWr4YE4hdIxA/Pw9re/EkE?=
 =?us-ascii?Q?jSNcbY10WaA/yh5GaU0bdALCUxLrlVcSdGBG+Z0NcA1q62Gk4UyUn+MRwhj1?=
 =?us-ascii?Q?mPtbSZanXHv/6zut7GreNRRMKYlclU4SlhOEUvFZqveOtkeAo55DKjcITr8Q?=
 =?us-ascii?Q?6cB7hJPxzDA7H2dfNiQVsCHiQ9f5/GhGL5n8YcFKc0kLVEz6aJbz27YyhKbx?=
 =?us-ascii?Q?tKOGGh/CGUL+sf6cYFRk1CjQLZmg3bIrrzLtdM3TGxPFGClhSpWHlyBlqv6f?=
 =?us-ascii?Q?pyhFom8xT2wkhjwZS5Dwge2Q2lRfyxKdMuMvBH7XQzUt+PQEwTdk21baYjJ9?=
 =?us-ascii?Q?CfS5CEZ1cYfesUFHtuR8I6+28TsihpfnHOiAO25U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debd766a-f2ad-453a-7140-08dcdc750094
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 08:43:46.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xh51z/ualX/9QCmngEUqSTLDhICXmRCTol8yYuplh7pbZ9nrFHkmt8Y57dYbUcodU7Oo3B8nwk3g00ybFGnXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10625

On Fri, Sep 13, 2024 at 11:35:49PM +0300, Vladimir Oltean wrote:
> Alexander Sverdlin presents 2 problems during shutdown with the
> lan9303 driver. One is specific to lan9303 and the other just happens
> to reproduce there.
> 
> The first problem is that lan9303 is unique among DSA drivers in that it
> calls dev_get_drvdata() at "arbitrary runtime" (not probe, not shutdown,
> not remove):
> 
> phy_state_machine()
> -> ...
>    -> dsa_user_phy_read()
>       -> ds->ops->phy_read()
>          -> lan9303_phy_read()
>             -> chip->ops->phy_read()
>                -> lan9303_mdio_phy_read()
>                   -> dev_get_drvdata()
> 
> But we never stop the phy_state_machine(), so it may continue to run
> after dsa_switch_shutdown(). Our common pattern in all DSA drivers is
> to set drvdata to NULL to suppress the remove() method that may come
> afterwards. But in this case it will result in an NPD.
> 
> The second problem is that the way in which we set
> dp->conduit->dsa_ptr = NULL; is concurrent with receive packet
> processing. dsa_switch_rcv() checks once whether dev->dsa_ptr is NULL,
> but afterwards, rather than continuing to use that non-NULL value,
> dev->dsa_ptr is dereferenced again and again without NULL checks:
> dsa_conduit_find_user() and many other places. In between dereferences,
> there is no locking to ensure that what was valid once continues to be
> valid.
> 
> Both problems have the common aspect that closing the conduit interface
> solves them.
> 
> In the first case, dev_close(conduit) triggers the NETDEV_GOING_DOWN
> event in dsa_user_netdevice_event() which closes user ports as well.
> dsa_port_disable_rt() calls phylink_stop(), which synchronously stops
> the phylink state machine, and ds->ops->phy_read() will thus no longer
> call into the driver after this point.
> 
> In the second case, dev_close(conduit) should do this, as per
> Documentation/networking/driver.rst:
> 
> | Quiescence
> | ----------
> |
> | After the ndo_stop routine has been called, the hardware must
> | not receive or transmit any data.  All in flight packets must
> | be aborted. If necessary, poll or wait for completion of
> | any reset commands.
> 
> So it should be sufficient to ensure that later, when we zeroize
> conduit->dsa_ptr, there will be no concurrent dsa_switch_rcv() call
> on this conduit.
> 
> The addition of the netif_device_detach() function is to ensure that
> ioctls, rtnetlinks and ethtool requests on the user ports no longer
> propagate down to the driver - we're no longer prepared to handle them.
> 
> The race condition actually did not exist when commit 0650bf52b31f
> ("net: dsa: be compatible with masters which unregister on shutdown")
> first introduced dsa_switch_shutdown(). It was created later, when we
> stopped unregistering the user interfaces from a bad spot, and we just
> replaced that sequence with a racy zeroization of conduit->dsa_ptr
> (one which doesn't ensure that the interfaces aren't up).
> 
> Reported-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Closes: https://lore.kernel.org/netdev/2d2e3bba17203c14a5ffdabc174e3b6bbb9ad438.camel@siemens.com/
> Closes: https://lore.kernel.org/netdev/c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com/
> Fixes: ee534378f005 ("net: dsa: fix panic when DSA master device unbinds on shutdown")
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

Andrew, Florian, FYI: this is marked as "Needs ACK" in patchwork.

