Return-Path: <netdev+bounces-212021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2816B1D49B
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 11:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB9094E0423
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B5A282FA;
	Thu,  7 Aug 2025 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LEJ9aE83"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4126281;
	Thu,  7 Aug 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558175; cv=fail; b=Ek+UzY45h3gf626AklvA0vjH6Wr0ooYOwc1HaHs7Vwy3zgolSVhpVdg+JOD1UqIN9gUEDOsDfOvMceWxvs9ULi/dvkr4IFzPPkRJJ7QGTF78HxIcZGFuvxrVJ0gdAtgwdBwNIhsyUEj0464sauQSb+HkC0noOaCU5UmresJBSZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558175; c=relaxed/simple;
	bh=su5woGPc47Arm/WlNWI0NrqRVk1Ui8cKndcN4ryWvJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C2u9BHNG6iztch57wDF8JK5RNqdvQ5+K1DsKu7sfvtyRhtQmb+cenkqt+snP1msOERrT4vL/GsTc8+Z+DpVxB676dKbJJEsPR7LbrEY2ASsi5m9OIMhcUeurqj5+3Ib8dsNdp/zy3QCXxuzmvx30/zzL6MB7gPebMiv17WYDnfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LEJ9aE83; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDf4vBQGcXi/k+L0m3uTYMrO9MAeG7DSRcsIum8wJjgsnvnyKJ1nPoTWPT6rvYB30RW7xlQd/x4PewfrvhjFACIvao5lFiQQMFqrUxQXUZAabjwi6r4PAXQu7INllJM4+Elfqas+hrE2FE7NoHjKCXV66aFe/j2/Ip1OI+GXna/hAnkUWgw11otDMNvzmuOGdQd+He79WzTNSfVCHhE4pn6bN8gglgVb+1saWP70OmNQHLLCRaOHW1ovQwfOAm2COc9L2Tq6kcK/hlOUoXHGCJ/FwfU7RRR1hzKyJST8jOi6Izsu6QvN0asfbMiSJ0S8uyhoJ6aKtuMno5CcaHxTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJqSqPq+NVlmcfn790iTzdLENTiW08gD50ImSxP/9i0=;
 b=cZd+UE0O4CIyCmN4psTG9oMfu+p8hEoEldAM+DRMiEzcDz9Z4/RRKCVG8yr6Ml86h6/zazmiHSlHmySOP1IMxNttlzespgYC3+pX0dBzk1UN2BMTipO/40yjmlUm1g35Lpnva/iEHI7NUJXeiwtTx2GdHAC1ffLboNayMbMIq6Mpj6yHNN9m9sFy8nas6eZECBjhxhvP2pLcfk8+Nuiv4wbAb2ZQwtCcYEZgwzGj0b9iy5ESjYLBx0bn/DwFO4KTHiw0zLQZKxvnVJhL9kFXqXOpgQkyuXpc7Xe/VGPu3HamOHvSWShhFRK+M1hhU4+/l1oISdV6cm+2Vt6+ZUXIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJqSqPq+NVlmcfn790iTzdLENTiW08gD50ImSxP/9i0=;
 b=LEJ9aE83vy7vAOMthkYnepYT4FaqGEuj6WRPdaSWcya95VMxbuAqeLD7iDpLjBcIqVZnZzZnQaRCexz9eNGrQfrnFqAPXUMmkf29H0Un6hEKrLLClOMmHOxAxxBe1uMjx147ik2/tAHc/JGPmI50p/tVoW1I4QtyEX6oUTfFOKbGEKRHjueE3W+AiJAq8WISQcZHVeAcf6XheJHJ5TJ9d8BkEk9iNQECB1SV8Xc0XP2l7VZjRhzgHfeOBWcyA4+zV7Z028vWpEX8RQ5p7gBNdaEgdv+nEuQKJSICnDZihEc4iFleGc3h3ZZLg18iMg6XN3CljjP2H5AURrGz+lwgJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by MRWPR04MB11519.eurprd04.prod.outlook.com (2603:10a6:501:76::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 09:16:07 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 09:16:06 +0000
Date: Thu, 7 Aug 2025 17:10:39 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, hkallweit1@gmail.com, 
	o.rempel@pengutronix.de, pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <ogh66evbiin6ugz2nkhpn33iffsjeo3kvdawe6cig4jjt67ygl@a3nqlqefvzwb>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
Content-Type: multipart/mixed; boundary="xdhybhgdthz6o5ig"
Content-Disposition: inline
In-Reply-To: <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
X-ClientProxiedBy: AM0PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:208:be::30) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|MRWPR04MB11519:EE_
X-MS-Office365-Filtering-Correlation-Id: 689b2eff-5d18-4991-6f3a-08ddd5930817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|19092799006|4053099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i2vroxpYTwPgPB4hx+VS2dtAlIdEdeFVQM6WIai9SukQZL2lWtkmU0WLZk9/?=
 =?us-ascii?Q?uAnpyl+XaHFbwBXmZj8TM9WcKAlBlLJuiLWK35i3wR+qeqfmyfFFTld+qOxO?=
 =?us-ascii?Q?0nH6HYNwaQQsRwiTXmuXJocNYYR2LEUgr5ZDnNHQu0XPslWmNLS5hnH36a4S?=
 =?us-ascii?Q?OlsMw0nYB5ikuTrCpE7TYcsTXqzzVxiJBBOXtgIP2KrOghCb/VpWwKzhGRsf?=
 =?us-ascii?Q?ljNEmcOsQYH+TJrmi9/zhWhMmJDy+SMTUaajQNzuD4ygyR8U4UNJRR+SGCz1?=
 =?us-ascii?Q?hK8MWVOqew/2AVckZKrVvOZRvQXR+hR3I2yI9u3YrtV+1/UCLueuL8vzhNig?=
 =?us-ascii?Q?32CmK8q0uJx4FElgekHES+5zI5KUKLAojcgXbHMEzE0ygM3WTj2samO8k96s?=
 =?us-ascii?Q?WdJpiA80QCtg4GAQVv57SHRsz5KDthS+hwFur8icp9sXpNVYqccgZ9ySHC7y?=
 =?us-ascii?Q?9VtzIbct9P+CyvfnDDHv6dAdreKTMJSdmblibsQQfNF5zextBdz0mBqoBcFg?=
 =?us-ascii?Q?593yV+lxcgNEKhWizJvsmdW4dgp5pBahxYJSJHASCDewLCXwRHjYalODmy7w?=
 =?us-ascii?Q?/5Ms9na/57F+AP1OtX5nqAx3w5lsaCVMwkU3jtE3ifGCX7HRhBcVEP0ZgvQ/?=
 =?us-ascii?Q?rsZFkADZVR5cUGaPNrcuPzVMa+6AQC2waBJgX+p3ghmT7C+Sz2oylqu4S3Ml?=
 =?us-ascii?Q?1BzULpyOGOJ9lNQ6KT6sPaUQnz4tN/ZagBppiyKlqlZ5bOV8s61r7W0mbK8g?=
 =?us-ascii?Q?7BH7zW9b/HcQ5GjEPB1nQuWOXKw5TzATHuzeuRJmaQWIq0hV9ddATo9y4OcL?=
 =?us-ascii?Q?0x2y/Qmhz5rvh5XmV8j0TXfA1+yOu6vZBtzIvnNOwr0slD4+IgqEmc39Kvtj?=
 =?us-ascii?Q?klosgy7QnWVuv9R/sv3LHdpKMJMpgfmoLI+FMp9W/63bW5SOsNxKNsWS4MaB?=
 =?us-ascii?Q?UPjatzFk7pAQ/JMTSJqQjauNdGSoLnO/0M4tcIB4Uw2NBLXPWA3UzqG7dXT+?=
 =?us-ascii?Q?D5ue2oGq02+m2AVv7wqButSi6bzMktjM69KfR6fymwzWW+NeU4ibRvvums4s?=
 =?us-ascii?Q?YRyBdTiPbi+27Wf1pgI3x7LBimJWYtFEo/wUw4bkPFU+CgI+Ok6LbzuD6aZj?=
 =?us-ascii?Q?BxUBL3uHPry2KBYssbd/KBY/NVk/eUfKDhjSB1/N58BNf0bcWdEudC8yhJW/?=
 =?us-ascii?Q?tyK3Yxb8eaK8wQKz69Rml4dXT2dVdt22RhmDI+hUmcSPfCPVsFEObsk4jeEl?=
 =?us-ascii?Q?HVrBjULXbBmQAQGIOJ5ESx98E5nm62MHUvyseeNFKTHsVw3YnUXjMmXC718w?=
 =?us-ascii?Q?Ebk7BN6t9CUwIj3qz0Xw0rthcz9B86hJdydwILBKfUHf/l7nAgIMkEffNOIr?=
 =?us-ascii?Q?qWJAeHYNbyRGQXHLUUw6ftvVws3YQWkZDAsaHkPIx0wqr1IRMFE3Y+fD/Prf?=
 =?us-ascii?Q?CMrKOHZJttWS9qqB9Enk35EJYnThD4g3NGkbodNFGj4RvlEtW/QjvXUrFujG?=
 =?us-ascii?Q?xCNkx6m7zZXy8vg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(4053099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqSo7LMAX5Ldd+DwO++jq1lQRyY69BhwO5xYYGE6n0stB0MGYNZSTTf3DObM?=
 =?us-ascii?Q?jmDPjbQav1YB3drCwniLhOKvvH2E/Jl1ngZNyuOsbZnlvpsrwpJxo23tShOR?=
 =?us-ascii?Q?NsvXfimrfxPb/Knzu3jExkrGLy6epebQFy4dgzUYQCZuebWX3Ob0d0gODr/R?=
 =?us-ascii?Q?3LzsasKvyhtWJ46GGtPOB9nz0AsWvtwgQE1zo4mzlxYT9/yiClNOWKQgppAO?=
 =?us-ascii?Q?P6Zd+BiP9/A5xLdbvzxwQaXASboj+gWbq2Fds5PbROr+u9jXQyGUXQjoyraE?=
 =?us-ascii?Q?rBX+NiumCqDMr1UDRLj9vVk+N0Wu9vI6HH2fRJYQEsw1P2dscQyrcADS07En?=
 =?us-ascii?Q?vXd/wQExd531d58l0TBVArJ0gv5m/EYzMI5wCyFWzYmlJND+rrtiW8TUDYZ0?=
 =?us-ascii?Q?LvQRlFmESHshvXTPXQoD9FSV/fTx0HYmNGJyrgK4+zcuRsUIVS3EKkUl8Zz7?=
 =?us-ascii?Q?JcEVqL74cFZngzShRNsnubnbWVE2x8S7Wwp2HnRpoLb02TdfuAswCyjrfwfW?=
 =?us-ascii?Q?B8bzqmWc0RZfURLCCwEelhFY+TSPWs+1+qf5m4jb90Y3Xhv2Xlmhuu12f/z3?=
 =?us-ascii?Q?QJ7cMpvtUdNFLYT3NVGw1JlSW1mqhudZQ0mYHrJSxgngbo+p9872w/bHKXFh?=
 =?us-ascii?Q?VuniIaq6TnDRielVlU5Gq1nxPwNai6yqa+MZ9PD2aZsbU61u/3HPQ9+1lCtj?=
 =?us-ascii?Q?5PeXxYLZXolah2UxH1DZoo7TP6egFcjQKU9PtFg/2Wo1jIjW/Dw007NGooKI?=
 =?us-ascii?Q?G6rnDRVCHZnG1WrYrKx5VZx9l1F4xZGTRP3TaBoQkz/g3/i3nI0+adf+yeag?=
 =?us-ascii?Q?l4MjtDKcwRe3DlzX/qbO0pFZ55HVPrioV3D+3zaaNO31wnn7u+f5gDyncBTw?=
 =?us-ascii?Q?1f1p4zvMnKyeWY1zMLJce4GijAwHD/66CroqrxF2mGxUDuoUt3pyXnRqViz2?=
 =?us-ascii?Q?Mqg4ixoTcR29IfnuonGSTwoFhLiH9BJEfrPSaQg2rEKZvfEbRgAA3yzd9DWg?=
 =?us-ascii?Q?Hf/N4Qkafo4+iXraMnJHuYcjoj3LB8LHRjKKqKhaikHLlbQHyVl5JaSdlYjt?=
 =?us-ascii?Q?VNuh9IPT12Lnq+Z/tKaos7E54gjQIUoKnLvog5CAN6ifwcrcdbSp7CpzhK3n?=
 =?us-ascii?Q?CzN2Xi9ggCGx2fAlvn8WcAXSihN242tKIjkwoY8/VrHrtMaKyXPQffPrxNUp?=
 =?us-ascii?Q?F/9KQc/IN+43SL+VGIT/U0jViN8sLeAEmr+Fo678nIZWPgUOFp4uUva8364v?=
 =?us-ascii?Q?09za/dF9oEuDJIoOcPlc3SZQFpLM6sCG3r1VM0JBYQ7DTFc2ok0BlVEAW6wq?=
 =?us-ascii?Q?lUuI7beE4vqyEUIdIua/Wn9/Xaph7zAcN7DcH0S38EznNoTJrdQwMV6Rh/hh?=
 =?us-ascii?Q?QMm8TfcmVkWHplO0QBpwM2O/huDwKCOokjVQria59Rt+zGZFdp6j2HbPhWrl?=
 =?us-ascii?Q?WHw/l6cIaVae7PxHguuTSXYwFyzlya7z5wpqUWbMVoWnG2/GESXz93j2lc7j?=
 =?us-ascii?Q?uEAqHyyjWj+ElKJSsZOVnakuw5JnvYePU2o4qr1EAstTM6j2t+/vb9m7jcQS?=
 =?us-ascii?Q?BJOgAThikas4sJrGv5T3HjM4uw5bf5xhU6U1n7T8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689b2eff-5d18-4991-6f3a-08ddd5930817
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 09:16:06.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nveolU1OExkBfFlhT0g3zOwqs/sPA0PtrN/FL3RUbOHAK3AgjBl1XKQNm2xX8/YZhD49pRIA+aaCnN0swX/2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11519

--xdhybhgdthz6o5ig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew,

On Wed, Aug 06, 2025 at 05:01:22PM +0200, Andrew Lunn wrote:
> > > > Reproduce step is simple:
> > > > 
> > > > 1. connect an USB to Ethernet device to USB port, I'm using "D-Link Corp.
> > > >    DUB-E100 Fast Ethernet Adapter".
> 
> static const struct driver_info dlink_dub_e100_info = {
>         .description = "DLink DUB-E100 USB Ethernet",
>         .bind = ax88172_bind,
>         .status = asix_status,
>         .link_reset = ax88172_link_reset,
>         .reset = ax88172_link_reset,
>         .flags =  FLAG_ETHER | FLAG_LINK_INTR,
>         .data = 0x009f9d9f,
> };
> 
> {
>         // DLink DUB-E100
>         USB_DEVICE (0x2001, 0x1a00),
>         .driver_info =  (unsigned long) &dlink_dub_e100_info,
> }, {
> 
> Is this the device you have?

static const struct driver_info ax88772_info = {
	.description = "ASIX AX88772 USB 2.0 Ethernet",
	.bind = ax88772_bind,
	.unbind = ax88772_unbind,
	.reset = ax88772_reset,
	.stop = ax88772_stop,
	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
	.rx_fixup = asix_rx_fixup_common,
	.tx_fixup = asix_tx_fixup,
};

}
	// DLink DUB-E100 H/W Ver B1
	USB_DEVICE (0x07d1, 0x3c05),
	.driver_info = (unsigned long) &ax88772_info,
}

This one.

> 
> > > > 2. the asix driver (drivers/net/usb/asix_devices.c) will bind to this USB
> > > >    device.
> > > > 
> > > > root@imx95evk:~# lsusb -t
> > > > /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=ci_hdrc/1p, 480M
> > > >     |__ Port 001: Dev 003, If 0, Class=Vendor Specific Class, Driver=asix, 480M
> > > > 
> > > > 3. then the driver will create many mdio devices. 
> > > > 
> > > > root@imx95evk:/sys/bus/mdio_bus# ls -d devices/usb*
> > > > devices/usb-001:005:00  devices/usb-001:005:04  devices/usb-001:005:08  devices/usb-001:005:0c  devices/usb-001:005:10  devices/usb-001:005:14  devices/usb-001:005:18  devices/usb-001:005:1c
> > > > devices/usb-001:005:01  devices/usb-001:005:05  devices/usb-001:005:09  devices/usb-001:005:0d  devices/usb-001:005:11  devices/usb-001:005:15  devices/usb-001:005:19  devices/usb-001:005:1d
> > > > devices/usb-001:005:02  devices/usb-001:005:06  devices/usb-001:005:0a  devices/usb-001:005:0e  devices/usb-001:005:12  devices/usb-001:005:16  devices/usb-001:005:1a  devices/usb-001:005:1e
> > > > devices/usb-001:005:03  devices/usb-001:005:07  devices/usb-001:005:0b  devices/usb-001:005:0f  devices/usb-001:005:13  devices/usb-001:005:17  devices/usb-001:005:1b  devices/usb-001:005:1f
> > > 
> > > This looks broken - please check what
> > > /sys/bus/mdio_bus/devices/usb*/phy_id contains.
> > 
> > root@imx95evk:~# cat /sys/bus/mdio_bus/devices/usb*/phy_id
> > 0x00000000
> > 0x00000000
> > 0x00000000
> > 0x02430c54
> > 0x0c540c54
> > 0x0c540c54
> > 0x0c540c54
> > 0x0c540c54
> 
> This suggests which version of the asix device has broken MDIO bus
> access.
> 
> The first three 0x00000000 are odd. If there is no device at an
> address you expect to read 0xffffffff. phylib will ignore 0xffffffff
> and not create a device. 0x00000000 suggests something actually is on
> the bus, and is responding to reads of registers 2 and 3, but
> returning 0x0000 is not expected.
> 
> And then 0x02430c54 for all other addresses suggests the device is not
> correctly handling the bus address, and is mapping the address
> parameter to a single bus address.

I attach the usb bus data about this USB device for reference.

If you search "1:002:0 s c0 07", you will locate AX_CMD_READ_MII_REG (0x07)
transfer.

For address 0x00:

ffff00008598c780 71304432 S Ci:1:002:0 s c0 07 0000 0002 0002 2 <
ffff00008598c780 71304609 C Ci:1:002:0 0 2 = 0000

ffff00008598c780 71306137 S Ci:1:002:0 s c0 07 0000 0003 0002 2 <
ffff00008598c780 71306359 C Ci:1:002:0 0 2 = 0000

...

For address 0x03:

ffff00008598c780 71335993 S Ci:1:002:0 s c0 07 0003 0002 0002 2 <
ffff00008598c780 71336203 C Ci:1:002:0 0 2 = 4302

ffff00008598c780 71337758 S Ci:1:002:0 s c0 07 0003 0003 0002 2 <
ffff00008598c780 71337942 C Ci:1:002:0 0 2 = 540c

...

For address 0x04:


ffff00008598c780 71346488 S Ci:1:002:0 s c0 07 0004 0002 0002 2 <
ffff00008598c780 71346706 C Ci:1:002:0 0 2 = 540c

ffff00008598c780 71348311 S Ci:1:002:0 s c0 07 0004 0003 0002 2 <
ffff00008598c780 71348541 C Ci:1:002:0 0 2 = 540c

So it is indeed returned by this device.

> 
> What does asix_read_phy_addr() return?

If you search "1:002:0 s c0 19", you will locate AX_CMD_READ_PHY_ID (0x19) transfer.

ffff00008598c780 71134999 S Ci:1:002:0 s c0 19 0000 0000 0002 2 <
ffff00008598c780 71135082 C Ci:1:002:0 0 2 = e003

So it returns 'e0 03'.

> 
> This is completely untested, not even compiled:
> 
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 9b0318fb50b5..e136b25782d9 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -260,13 +260,20 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
>         dev->mii.dev = dev->net;
>         dev->mii.mdio_read = asix_mdio_read;
>         dev->mii.mdio_write = asix_mdio_write;
> -       dev->mii.phy_id_mask = 0x3f;
>         dev->mii.reg_num_mask = 0x1f;
>  
>         dev->mii.phy_id = asix_read_phy_addr(dev, true);
>         if (dev->mii.phy_id < 0)
>                 return dev->mii.phy_id;
>  
> +       if (dev->mii.phy_id > 31) {
> +               netdev_err(dev->net, "Invalid PHY address %d\n",
> +                          dev->mii.phy_id);
> +               return -EINVAL;
> +       }
> +
> +       dev->mii.phy_id_mask = BIT(dev->mii.phy_id);
> +
>         dev->net->netdev_ops = &ax88172_netdev_ops;
>         dev->net->ethtool_ops = &ax88172_ethtool_ops;
>         dev->net->needed_headroom = 4; /* cf asix_tx_fixup() */
> 
> The idea is to limit the scanning of the bus to just the address where
> we expect the PHY to be.  See if this gives you a single PHY, and that
> PHY actually works.

Because it's ax88772_bind(), so I can't test this. Sorry for this.

Thanks,
Xu Yang

> 
> 	Andrew

--xdhybhgdthz6o5ig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usbnet.log"

ffff00008598c240 70725746 S Ci:1:001:0 s a3 00 0000 0001 0004 4 <
ffff00008598c240 70725823 C Ci:1:001:0 0 4 = 01010100
ffff00008598c240 70725852 S Co:1:001:0 s 23 01 0010 0001 0000 0
ffff00008598c240 70725871 C Co:1:001:0 0 0
ffff00008182d000 70832071 S Ii:1:001:1 -115:2048 4 <
ffff00008598c240 70832119 S Ci:1:001:0 s a3 00 0000 0001 0004 4 <
ffff00008598c240 70832157 C Ci:1:001:0 0 4 = 01010000
ffff00008598c240 70832216 S Co:1:001:0 s 23 03 0004 0001 0000 0
ffff00008598c240 70832238 C Co:1:001:0 0 0
ffff00008182d000 70887306 C Ii:1:001:1 0:2048 1 = 02
ffff00008182d000 70887351 S Ii:1:001:1 -115:2048 4 <
ffff00008598c240 70896181 S Ci:1:001:0 s a3 00 0000 0001 0004 4 <
ffff00008598c240 70896231 C Ci:1:001:0 0 4 = 03051000
ffff00008598c240 70896255 S Co:1:001:0 s 23 01 0014 0001 0000 0
ffff00008598c240 70896274 C Co:1:001:0 0 0
ffff00008598c240 70962628 S Ci:1:000:0 s 80 06 0100 0000 0040 64 <
ffff00008598c240 70964599 C Ci:1:000:0 0 18 = 12010002 ffff0040 0120053c 01000102 0301
ffff00008598c240 70964714 S Co:1:001:0 s 23 03 0004 0001 0000 0
ffff00008598c240 70964757 C Co:1:001:0 0 0
ffff00008182d000 71019703 C Ii:1:001:1 0:2048 1 = 02
ffff00008182d000 71019720 S Ii:1:001:1 -115:2048 4 <
ffff00008598c240 71032106 S Ci:1:001:0 s a3 00 0000 0001 0004 4 <
ffff00008598c240 71032158 C Ci:1:001:0 0 4 = 03051000
ffff00008598c240 71032187 S Co:1:001:0 s 23 01 0014 0001 0000 0
ffff00008598c240 71032208 C Co:1:001:0 0 0
ffff00008598c240 71092077 S Co:1:000:0 s 00 05 0002 0000 0000 0
ffff00008598c240 71092415 C Co:1:000:0 0 0
ffff00008598c780 71116241 S Ci:1:002:0 s 80 06 0100 0000 0012 18 <
ffff00008598c780 71118141 C Ci:1:002:0 0 18 = 12010002 ffff0040 0120053c 01000102 0301
ffff00008598c780 71118214 S Ci:1:002:0 s 80 06 0200 0000 0009 9 <
ffff00008598c780 71119372 C Ci:1:002:0 0 9 = 09022700 01010480 7d
ffff00008598c780 71119420 S Ci:1:002:0 s 80 06 0200 0000 0027 39 <
ffff00008598c780 71123363 C Ci:1:002:0 0 39 = 09022700 01010480 7d090400 0003ffff 00070705 81030800 0b070582 02000200
ffff00008598c780 71123425 S Ci:1:002:0 s 80 06 0300 0000 00ff 255 <
ffff00008598c780 71123612 C Ci:1:002:0 0 4 = 04030904
ffff00008598c780 71123650 S Ci:1:002:0 s 80 06 0302 0409 00ff 255 <
ffff00008598c780 71125581 C Ci:1:002:0 0 18 = 12034400 55004200 2d004500 31003000 3000
ffff00008598c780 71125678 S Ci:1:002:0 s 80 06 0301 0409 00ff 255 <
ffff00008598c780 71129355 C Ci:1:002:0 0 38 = 26034400 2d004c00 69006e00 6b002000 43006f00 72007000 6f007200 61007400
ffff00008598c780 71129410 S Ci:1:002:0 s 80 06 0303 0409 00ff 255 <
ffff00008598c780 71130851 C Ci:1:002:0 0 14 = 0e033000 30003000 30003000 3100
ffff00008598c780 71131678 S Co:1:002:0 s 00 09 0001 0000 0000 0
ffff00008598c780 71131854 C Co:1:002:0 0 0
ffff00008598c780 71132791 S Ci:1:002:0 s 80 06 0304 0409 00ff 255 <
ffff00008598c780 71133363 C Ci:1:002:0 0 4 = 04033000
ffff00008598c780 71133542 S Ci:1:002:0 s 80 06 0307 0409 00ff 255 <
ffff00008598c780 71134104 C Ci:1:002:0 0 4 = 04033000
ffff00008598c780 71134430 S Co:1:002:0 s 01 0b 0000 0000 0000 0
ffff00008598c780 71134595 C Co:1:002:0 0 0
ffff00008598c780 71134850 S Ci:1:002:0 s c0 13 0000 0000 0006 6 <
ffff00008598c780 71134961 C Ci:1:002:0 0 6 = fc7516cf 6bfe
ffff00008598c780 71134999 S Ci:1:002:0 s c0 19 0000 0000 0002 2 <
ffff00008598c780 71135082 C Ci:1:002:0 0 2 = e003
ffff00008598c780 71135112 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71135206 C Ci:1:002:0 0 1 = 00
ffff00008598c780 71135237 S Co:1:002:0 s 40 1f 00b0 0000 0000 0
ffff00008598c780 71135322 C Co:1:002:0 0 0
ffff00008598c780 71144057 S Co:1:002:0 s 40 22 0000 0000 0000 0
ffff00008598c780 71144209 C Co:1:002:0 0 0
ffff00008598c780 71144234 S Co:1:002:0 s 40 20 0048 0000 0000 0
ffff00008598c780 71144315 C Co:1:002:0 0 0
ffff00008598c780 71300226 S Co:1:002:0 s 40 10 0088 0000 0000 0
ffff00008598c780 71300532 C Co:1:002:0 0 0
ffff00008598c780 71300588 S Co:1:002:0 s 40 1b 0306 0000 0000 0
ffff00008598c780 71300756 C Co:1:002:0 0 0
ffff00008598c780 71300812 S Co:1:002:0 s 40 12 001d 0012 0000 0
ffff00008598c780 71300999 C Co:1:002:0 0 0
ffff00008598c780 71301053 S Co:1:002:0 s 40 14 0000 0000 0006 6 = fc7516cf 6bfe
ffff00008598c780 71301256 C Co:1:002:0 0 6 >
ffff00008598c780 71301308 S Co:1:002:0 s 40 10 0088 0000 0000 0
ffff00008598c780 71301494 C Co:1:002:0 0 0
ffff00008598c780 71301544 S Ci:1:002:0 s c0 0f 0000 0000 0002 2 <
ffff00008598c780 71301756 C Ci:1:002:0 0 2 = 8800
ffff00008598c780 71301807 S Ci:1:002:0 s c0 1a 0000 0000 0002 2 <
ffff00008598c780 71302005 C Ci:1:002:0 0 2 = 0603
ffff00008598c780 71302858 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71302996 C Co:1:002:0 0 0
ffff00008598c780 71304193 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71304382 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71304432 S Ci:1:002:0 s c0 07 0000 0002 0002 2 <
ffff00008598c780 71304609 C Ci:1:002:0 0 2 = 0000
ffff00008598c780 71304640 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71304727 C Co:1:002:0 0 0
ffff00008598c780 71304756 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71304851 C Co:1:002:0 0 0
ffff00008598c780 71305997 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71306110 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71306137 S Ci:1:002:0 s c0 07 0000 0003 0002 2 <
ffff00008598c780 71306359 C Ci:1:002:0 0 2 = 0000
ffff00008598c780 71306406 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71306477 C Co:1:002:0 0 0
ffff00008598c780 71313142 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71313363 C Co:1:002:0 0 0
ffff00008598c780 71316290 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71316488 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71316515 S Ci:1:002:0 s c0 07 0001 0002 0002 2 <
ffff00008598c780 71316718 C Ci:1:002:0 0 2 = 0000
ffff00008598c780 71316739 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71316834 C Co:1:002:0 0 0
ffff00008598c780 71316856 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71316956 C Co:1:002:0 0 0
ffff00008598c780 71318085 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71318210 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71318229 S Ci:1:002:0 s c0 07 0001 0003 0002 2 <
ffff00008598c780 71318458 C Ci:1:002:0 0 2 = 0000
ffff00008598c780 71318475 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71318577 C Co:1:002:0 0 0
ffff00008598c780 71324727 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71324856 C Co:1:002:0 0 0
ffff00008598c780 71326978 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71327111 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71327153 S Ci:1:002:0 s c0 07 0002 0002 0002 2 <
ffff00008598c780 71327339 C Ci:1:002:0 0 2 = 0000
ffff00008598c780 71327371 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71327451 C Co:1:002:0 0 0
ffff00008598c780 71327479 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71327573 C Co:1:002:0 0 0
ffff00008598c780 71328729 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71328849 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71328877 S Ci:1:002:0 s c0 07 0002 0003 0002 2 <
ffff00008598c780 71329093 C Ci:1:002:0 0 2 = 0000
ffff00008598c780 71329138 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71329314 C Co:1:002:0 0 0
ffff00008598c780 71334244 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71334336 C Co:1:002:0 0 0
ffff00008598c780 71335860 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71335962 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71335993 S Ci:1:002:0 s c0 07 0003 0002 0002 2 <
ffff00008598c780 71336203 C Ci:1:002:0 0 2 = 4302
ffff00008598c780 71336229 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71336309 C Co:1:002:0 0 0
ffff00008598c780 71336331 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71336432 C Co:1:002:0 0 0
ffff00008598c780 71337573 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71337714 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71337758 S Ci:1:002:0 s c0 07 0003 0003 0002 2 <
ffff00008598c780 71337942 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71337969 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71338058 C Co:1:002:0 0 0
ffff00008598c780 71344959 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71345079 C Co:1:002:0 0 0
ffff00008598c780 71346264 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71346450 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71346488 S Ci:1:002:0 s c0 07 0004 0002 0002 2 <
ffff00008598c780 71346706 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71346758 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71346918 C Co:1:002:0 0 0
ffff00008598c780 71346937 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71347040 C Co:1:002:0 0 0
ffff00008598c780 71348166 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71348295 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71348311 S Ci:1:002:0 s c0 07 0004 0003 0002 2 <
ffff00008598c780 71348541 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71348555 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71348660 C Co:1:002:0 0 0
ffff00008598c780 71352858 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71353054 C Co:1:002:0 0 0
ffff00008598c780 71354192 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71354301 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71354321 S Ci:1:002:0 s c0 07 0005 0002 0002 2 <
ffff00008598c780 71354539 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71354555 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71354655 C Co:1:002:0 0 0
ffff00008598c780 71354670 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71354801 C Co:1:002:0 0 0
ffff00008598c780 71355962 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71356047 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71356075 S Ci:1:002:0 s c0 07 0005 0003 0002 2 <
ffff00008598c780 71356293 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71356319 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71356408 C Co:1:002:0 0 0
ffff00008598c780 71363244 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71363420 C Co:1:002:0 0 0
ffff00008598c780 71364563 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71364669 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71364694 S Ci:1:002:0 s c0 07 0006 0002 0002 2 <
ffff00008598c780 71364913 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71364935 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71365022 C Co:1:002:0 0 0
ffff00008598c780 71365043 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71365144 C Co:1:002:0 0 0
ffff00008598c780 71366271 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71366397 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71366414 S Ci:1:002:0 s c0 07 0006 0003 0002 2 <
ffff00008598c780 71366647 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71366664 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71366764 C Co:1:002:0 0 0
ffff00008598c780 71371580 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71371783 C Co:1:002:0 0 0
ffff00008598c780 71372923 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71373033 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71373058 S Ci:1:002:0 s c0 07 0007 0002 0002 2 <
ffff00008598c780 71373276 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71373299 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71373385 C Co:1:002:0 0 0
ffff00008598c780 71373405 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71373508 C Co:1:002:0 0 0
ffff00008598c780 71374636 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71374762 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71374779 S Ci:1:002:0 s c0 07 0007 0003 0002 2 <
ffff00008598c780 71375010 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71375027 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71375128 C Co:1:002:0 0 0
ffff00008598c780 71380087 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71380272 C Co:1:002:0 0 0
ffff00008598c780 71381413 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71381522 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71381548 S Ci:1:002:0 s c0 07 0008 0002 0002 2 <
ffff00008598c780 71381764 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71381790 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71381874 C Co:1:002:0 0 0
ffff00008598c780 71381896 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71381996 C Co:1:002:0 0 0
ffff00008598c780 71383126 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71383250 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71383271 S Ci:1:002:0 s c0 07 0008 0003 0002 2 <
ffff00008598c780 71383500 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71383518 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71383618 C Co:1:002:0 0 0
ffff00008598c780 71388660 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71388764 C Co:1:002:0 0 0
ffff00008598c780 71389908 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71390011 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71390036 S Ci:1:002:0 s c0 07 0009 0002 0002 2 <
ffff00008598c780 71390251 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71390271 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71390360 C Co:1:002:0 0 0
ffff00008598c780 71390379 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71390484 C Co:1:002:0 0 0
ffff00008598c780 71391612 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71391739 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71391756 S Ci:1:002:0 s c0 07 0009 0003 0002 2 <
ffff00008598c780 71391987 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71392018 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71392106 C Co:1:002:0 0 0
ffff00008598c780 71397350 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71397505 C Co:1:002:0 0 0
ffff00008598c780 71398663 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71398871 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71398900 S Ci:1:002:0 s c0 07 000a 0002 0002 2 <
ffff00008598c780 71399114 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71399140 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71399229 C Co:1:002:0 0 0
ffff00008598c780 71399256 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71399353 C Co:1:002:0 0 0
ffff00008598c780 71400500 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71400612 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71400638 S Ci:1:002:0 s c0 07 000a 0003 0002 2 <
ffff00008598c780 71400860 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71400886 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71400976 C Co:1:002:0 0 0
ffff00008598c780 71407637 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71407747 C Co:1:002:0 0 0
ffff00008598c780 71408909 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71409113 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71409144 S Ci:1:002:0 s c0 07 000b 0002 0002 2 <
ffff00008598c780 71409351 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71409378 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71409465 C Co:1:002:0 0 0
ffff00008598c780 71409493 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71409590 C Co:1:002:0 0 0
ffff00008598c780 71410735 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71410847 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71410874 S Ci:1:002:0 s c0 07 000b 0003 0002 2 <
ffff00008598c780 71411096 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71411121 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71411212 C Co:1:002:0 0 0
ffff00008598c780 71418044 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71418230 C Co:1:002:0 0 0
ffff00008598c780 71419388 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71419595 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71419623 S Ci:1:002:0 s c0 07 000c 0002 0002 2 <
ffff00008598c780 71419836 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71419864 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71419951 C Co:1:002:0 0 0
ffff00008598c780 71419979 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71420077 C Co:1:002:0 0 0
ffff00008598c780 71421214 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71421325 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71421343 S Ci:1:002:0 s c0 07 000c 0003 0002 2 <
ffff00008598c780 71421574 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71421590 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71421693 C Co:1:002:0 0 0
ffff00008598c780 71426783 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71426963 C Co:1:002:0 0 0
ffff00008598c780 71428041 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71428205 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71428228 S Ci:1:002:0 s c0 07 000d 0002 0002 2 <
ffff00008598c780 71428446 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71428468 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71428560 C Co:1:002:0 0 0
ffff00008598c780 71428578 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71428684 C Co:1:002:0 0 0
ffff00008598c780 71429810 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71429939 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71429956 S Ci:1:002:0 s c0 07 000d 0003 0002 2 <
ffff00008598c780 71430188 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71430204 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71430306 C Co:1:002:0 0 0
ffff00008598c780 71435263 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71435452 C Co:1:002:0 0 0
ffff00008598c780 71436592 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71436694 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71436716 S Ci:1:002:0 s c0 07 000e 0002 0002 2 <
ffff00008598c780 71436932 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71436952 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71437048 C Co:1:002:0 0 0
ffff00008598c780 71437067 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71437173 C Co:1:002:0 0 0
ffff00008598c780 71438299 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71438426 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71438443 S Ci:1:002:0 s c0 07 000e 0003 0002 2 <
ffff00008598c780 71438676 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71438692 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71438795 C Co:1:002:0 0 0
ffff00008598c780 71443773 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71443944 C Co:1:002:0 0 0
ffff00008598c780 71445085 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71445180 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71445200 S Ci:1:002:0 s c0 07 000f 0002 0002 2 <
ffff00008598c780 71445421 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71445441 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71445538 C Co:1:002:0 0 0
ffff00008598c780 71445555 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71445662 C Co:1:002:0 0 0
ffff00008598c780 71446788 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71446915 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71446932 S Ci:1:002:0 s c0 07 000f 0003 0002 2 <
ffff00008598c780 71447166 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71447183 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71447284 C Co:1:002:0 0 0
ffff00008598c780 71452143 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71452305 C Co:1:002:0 0 0
ffff00008598c780 71453452 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71453544 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71453566 S Ci:1:002:0 s c0 07 0010 0002 0002 2 <
ffff00008598c780 71453786 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71453807 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71453901 C Co:1:002:0 0 0
ffff00008598c780 71453921 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71454026 C Co:1:002:0 0 0
ffff00008598c780 71455155 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71455280 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71455298 S Ci:1:002:0 s c0 07 0010 0003 0002 2 <
ffff00008598c780 71455530 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71455548 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71455648 C Co:1:002:0 0 0
ffff00008598c780 71460735 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71460917 C Co:1:002:0 0 0
ffff00008598c780 71462058 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71462156 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71462179 S Ci:1:002:0 s c0 07 0011 0002 0002 2 <
ffff00008598c780 71462398 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71462419 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71462515 C Co:1:002:0 0 0
ffff00008598c780 71462536 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71462639 C Co:1:002:0 0 0
ffff00008598c780 71463768 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71463894 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71463912 S Ci:1:002:0 s c0 07 0011 0003 0002 2 <
ffff00008598c780 71464143 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71464163 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71464262 C Co:1:002:0 0 0
ffff00008598c780 71469809 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71469916 C Co:1:002:0 0 0
ffff00008598c780 71471073 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71471278 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71471311 S Ci:1:002:0 s c0 07 0012 0002 0002 2 <
ffff00008598c780 71471518 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71471547 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71471635 C Co:1:002:0 0 0
ffff00008598c780 71471664 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71471759 C Co:1:002:0 0 0
ffff00008598c780 71472907 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71473016 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71473045 S Ci:1:002:0 s c0 07 0012 0003 0002 2 <
ffff00008598c780 71473264 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71473292 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71473382 C Co:1:002:0 0 0
ffff00008598c780 71480109 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71480277 C Co:1:002:0 0 0
ffff00008598c780 71481443 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71481639 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71481671 S Ci:1:002:0 s c0 07 0013 0002 0002 2 <
ffff00008598c780 71481881 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71481912 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71481996 C Co:1:002:0 0 0
ffff00008598c780 71482026 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71482120 C Co:1:002:0 0 0
ffff00008598c780 71483266 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71483378 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71483407 S Ci:1:002:0 s c0 07 0013 0003 0002 2 <
ffff00008598c780 71483627 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71483655 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71483743 C Co:1:002:0 0 0
ffff00008598c780 71490672 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71490887 C Co:1:002:0 0 0
ffff00008598c780 71492049 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71492253 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71492287 S Ci:1:002:0 s c0 07 0014 0002 0002 2 <
ffff00008598c780 71492508 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71492528 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71492601 C Co:1:002:0 0 0
ffff00008598c780 71492621 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71492725 C Co:1:002:0 0 0
ffff00008598c780 71493855 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71493980 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71493998 S Ci:1:002:0 s c0 07 0014 0003 0002 2 <
ffff00008598c780 71494229 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71494247 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71494348 C Co:1:002:0 0 0
ffff00008598c780 71499382 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71499494 C Co:1:002:0 0 0
ffff00008598c780 71500670 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71500861 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71500884 S Ci:1:002:0 s c0 07 0015 0002 0002 2 <
ffff00008598c780 71501101 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71501121 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71501215 C Co:1:002:0 0 0
ffff00008598c780 71501235 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71501339 C Co:1:002:0 0 0
ffff00008598c780 71502444 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71502593 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71502612 S Ci:1:002:0 s c0 07 0015 0003 0002 2 <
ffff00008598c780 71502843 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71502861 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71502961 C Co:1:002:0 0 0
ffff00008598c780 71507824 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71507980 C Co:1:002:0 0 0
ffff00008598c780 71509166 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71509349 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71509374 S Ci:1:002:0 s c0 07 0016 0002 0002 2 <
ffff00008598c780 71509590 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71509612 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71509704 C Co:1:002:0 0 0
ffff00008598c780 71509724 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71509828 C Co:1:002:0 0 0
ffff00008598c780 71510958 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71511083 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71511102 S Ci:1:002:0 s c0 07 0016 0003 0002 2 <
ffff00008598c780 71511332 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71511351 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71511451 C Co:1:002:0 0 0
ffff00008598c780 71516490 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71516599 C Co:1:002:0 0 0
ffff00008598c780 71517768 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71517961 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71517984 S Ci:1:002:0 s c0 07 0017 0002 0002 2 <
ffff00008598c780 71518201 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71518220 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71518317 C Co:1:002:0 0 0
ffff00008598c780 71518335 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71518441 C Co:1:002:0 0 0
ffff00008598c780 71519567 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71519696 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71519713 S Ci:1:002:0 s c0 07 0017 0003 0002 2 <
ffff00008598c780 71519945 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71519962 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71520064 C Co:1:002:0 0 0
ffff00008598c780 71525042 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71525211 C Co:1:002:0 0 0
ffff00008598c780 71526387 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71526577 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71526600 S Ci:1:002:0 s c0 07 0018 0002 0002 2 <
ffff00008598c780 71526814 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71526832 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71526930 C Co:1:002:0 0 0
ffff00008598c780 71526948 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71527055 C Co:1:002:0 0 0
ffff00008598c780 71528183 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71528311 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71528328 S Ci:1:002:0 s c0 07 0018 0003 0002 2 <
ffff00008598c780 71528559 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71528576 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71528678 C Co:1:002:0 0 0
ffff00008598c780 71533509 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71533698 C Co:1:002:0 0 0
ffff00008598c780 71534845 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71534939 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71534960 S Ci:1:002:0 s c0 07 0019 0002 0002 2 <
ffff00008598c780 71535179 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71535198 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71535294 C Co:1:002:0 0 0
ffff00008598c780 71535313 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71535419 C Co:1:002:0 0 0
ffff00008598c780 71536548 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71536675 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71536693 S Ci:1:002:0 s c0 07 0019 0003 0002 2 <
ffff00008598c780 71536924 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71536940 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71537042 C Co:1:002:0 0 0
ffff00008598c780 71542204 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71542309 C Co:1:002:0 0 0
ffff00008598c780 71543446 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71543552 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71543572 S Ci:1:002:0 s c0 07 001a 0002 0002 2 <
ffff00008598c780 71543795 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71543814 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71543909 C Co:1:002:0 0 0
ffff00008598c780 71543927 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71544033 C Co:1:002:0 0 0
ffff00008598c780 71545177 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71545291 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71545310 S Ci:1:002:0 s c0 07 001a 0003 0002 2 <
ffff00008598c780 71545539 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71545558 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71545657 C Co:1:002:0 0 0
ffff00008598c780 71550695 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71550807 C Co:1:002:0 0 0
ffff00008598c780 71552325 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71552430 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71552480 S Ci:1:002:0 s c0 07 001b 0002 0002 2 <
ffff00008598c780 71552667 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71552698 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71552779 C Co:1:002:0 0 0
ffff00008598c780 71552808 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71552904 C Co:1:002:0 0 0
ffff00008598c780 71554045 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71554161 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71554187 S Ci:1:002:0 s c0 07 001b 0003 0002 2 <
ffff00008598c780 71554410 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71554435 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71554525 C Co:1:002:0 0 0
ffff00008598c780 71561222 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71561409 C Co:1:002:0 0 0
ffff00008598c780 71563954 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71564165 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71564189 S Ci:1:002:0 s c0 07 001c 0002 0002 2 <
ffff00008598c780 71564391 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71564409 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71564507 C Co:1:002:0 0 0
ffff00008598c780 71564525 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71564631 C Co:1:002:0 0 0
ffff00008598c780 71565759 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71565887 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71565905 S Ci:1:002:0 s c0 07 001c 0003 0002 2 <
ffff00008598c780 71566135 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71566152 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71566254 C Co:1:002:0 0 0
ffff00008598c780 71572554 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71572653 C Co:1:002:0 0 0
ffff00008598c780 71574649 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71574785 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71574837 S Ci:1:002:0 s c0 07 001d 0002 0002 2 <
ffff00008598c780 71575013 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71575042 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71575124 C Co:1:002:0 0 0
ffff00008598c780 71575152 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71575248 C Co:1:002:0 0 0
ffff00008598c780 71576406 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71576503 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71576537 S Ci:1:002:0 s c0 07 001d 0003 0002 2 <
ffff00008598c780 71576748 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71576765 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71576866 C Co:1:002:0 0 0
ffff00008598c780 71581975 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71582143 C Co:1:002:0 0 0
ffff00008598c780 71583648 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71583762 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71583788 S Ci:1:002:0 s c0 07 001e 0002 0002 2 <
ffff00008598c780 71583988 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71584031 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71584108 C Co:1:002:0 0 0
ffff00008598c780 71584126 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71584231 C Co:1:002:0 0 0
ffff00008598c780 71585368 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71585487 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71585507 S Ci:1:002:0 s c0 07 001e 0003 0002 2 <
ffff00008598c780 71585736 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71585756 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71585855 C Co:1:002:0 0 0
ffff00008598c780 71590729 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71590878 C Co:1:002:0 0 0
ffff00008598c780 71592045 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71592246 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71592274 S Ci:1:002:0 s c0 07 001f 0002 0002 2 <
ffff00008598c780 71592481 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71592502 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71592595 C Co:1:002:0 0 0
ffff00008598c780 71592615 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71592720 C Co:1:002:0 0 0
ffff00008598c780 71593846 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71593974 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71593991 S Ci:1:002:0 s c0 07 001f 0003 0002 2 <
ffff00008598c780 71594223 C Ci:1:002:0 0 2 = 540c
ffff00008598c780 71594240 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71594342 C Co:1:002:0 0 0
ffff00008598c780 71599416 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71599612 C Co:1:002:0 0 0
ffff00008598c780 71600757 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71600853 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71600878 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff00008598c780 71601093 C Ci:1:002:0 0 2 = 4978
ffff00008598c780 71601114 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71601209 C Co:1:002:0 0 0
ffff00008598c780 71601230 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71601333 C Co:1:002:0 0 0
ffff00008598c780 71602463 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71602588 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71602607 S Co:1:002:0 s 40 08 0003 000d 0002 2 = 0300
ffff00008598c780 71602836 C Co:1:002:0 0 2 >
ffff00008598c780 71602854 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71602956 C Co:1:002:0 0 0
ffff00008598c780 71602975 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71603082 C Co:1:002:0 0 0
ffff00008598c780 71604211 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71604336 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71604355 S Co:1:002:0 s 40 08 0003 000e 0002 2 = 1400
ffff00008598c780 71604584 C Co:1:002:0 0 2 >
ffff00008598c780 71604602 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71604704 C Co:1:002:0 0 0
ffff00008598c780 71604722 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71604829 C Co:1:002:0 0 0
ffff00008598c780 71605959 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71606083 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71606102 S Co:1:002:0 s 40 08 0003 000d 0002 2 = 0340
ffff00008598c780 71606332 C Co:1:002:0 0 2 >
ffff00008598c780 71606350 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71606452 C Co:1:002:0 0 0
ffff00008598c780 71606471 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71606577 C Co:1:002:0 0 0
ffff00008598c780 71607707 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71607831 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71607851 S Ci:1:002:0 s c0 07 0003 000e 0002 2 <
ffff00008598c780 71608081 C Ci:1:002:0 0 2 = 4978
ffff00008598c780 71608101 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71608200 C Co:1:002:0 0 0
ffff00008598c780 71608338 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71608453 C Co:1:002:0 0 0
ffff00008598c780 71609841 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71609983 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71610092 S Ci:1:002:0 s c0 07 0003 0000 0002 2 <
ffff00008598c780 71610343 C Ci:1:002:0 0 2 = 0031
ffff00008598c780 71610374 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71610453 C Co:1:002:0 0 0
ffff00008598c780 71620994 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71621069 C Co:1:002:0 0 0
ffff00008598c780 71622197 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71622310 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71622326 S Co:1:002:0 s 40 08 0003 000d 0002 2 = 0300
ffff00008598c780 71622557 C Co:1:002:0 0 2 >
ffff00008598c780 71622570 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71622678 C Co:1:002:0 0 0
ffff00008598c780 71622691 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71622803 C Co:1:002:0 0 0
ffff00008598c780 71623923 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71624058 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71624323 S Co:1:002:0 s 40 08 0003 000e 0002 2 = 0100
ffff00008598c780 71624560 C Co:1:002:0 0 2 >
ffff00008598c780 71624578 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71624677 C Co:1:002:0 0 0
ffff00008598c780 71624693 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71624801 C Co:1:002:0 0 0
ffff00008598c780 71625925 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71626055 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71626071 S Co:1:002:0 s 40 08 0003 000d 0002 2 = 0340
ffff00008598c780 71626303 C Co:1:002:0 0 2 >
ffff00008598c780 71626318 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71626424 C Co:1:002:0 0 0
ffff00008598c780 71626438 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71626548 C Co:1:002:0 0 0
ffff00008598c780 71627672 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71627802 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71627817 S Ci:1:002:0 s c0 07 0003 000e 0002 2 <
ffff00008598c780 71628051 C Ci:1:002:0 0 2 = 0031
ffff00008598c780 71628067 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71628172 C Co:1:002:0 0 0
ffff00008598c780 71628191 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71628296 C Co:1:002:0 0 0
ffff00008598c780 71629428 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71629580 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71629632 S Ci:1:002:0 s c0 07 0003 0000 0002 2 <
ffff00008598c780 71629826 C Ci:1:002:0 0 2 = 0031
ffff00008598c780 71629873 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71630066 C Co:1:002:0 0 0
ffff00008598c780 71630116 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598c780 71630197 C Co:1:002:0 0 0
ffff00008598c780 71631443 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598c780 71631576 C Ci:1:002:0 0 1 = 01
ffff00008598c780 71631626 S Co:1:002:0 s 40 08 0003 0000 0002 2 = 0039
ffff00008598c780 71631822 C Co:1:002:0 0 2 >
ffff00008598c780 71631865 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598c780 71631937 C Co:1:002:0 0 0
ffff0000858470c0 71643333 S Co:1:002:0 s 40 14 0000 0000 0006 6 = fc7516cf 6bfe
ffff0000858470c0 71652526 C Co:1:002:0 0 6 >
ffff0000858470c0 71652557 S Co:1:002:0 s 40 10 0088 0000 0000 0
ffff0000858470c0 71652689 C Co:1:002:0 0 0
ffff0000858470c0 71652709 S Co:1:002:0 s 40 1b 0306 0000 0000 0
ffff0000858470c0 71652771 C Co:1:002:0 0 0
ffff00008598cc00 71653305 S Ci:1:001:0 s a3 00 0000 0001 0004 4 <
ffff00008598cc00 71653344 C Ci:1:001:0 0 4 = 03050000
ffff0000858470c0 71658923 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff0000858470c0 71659032 C Co:1:002:0 0 0
ffff0000858470c0 71660170 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff0000858470c0 71660268 C Ci:1:002:0 0 1 = 01
ffff0000858470c0 71660287 S Ci:1:002:0 s c0 07 0003 0000 0002 2 <
ffff0000858470c0 71660512 C Ci:1:002:0 0 2 = 0039
ffff0000858470c0 71660529 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff0000858470c0 71660629 C Co:1:002:0 0 0
ffff0000858470c0 71660646 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff0000858470c0 71660753 C Co:1:002:0 0 0
ffff0000858470c0 71661882 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff0000858470c0 71662016 C Ci:1:002:0 0 1 = 01
ffff0000858470c0 71662036 S Co:1:002:0 s 40 08 0003 0000 0002 2 = 0031
ffff0000858470c0 71662257 C Co:1:002:0 0 2 >
ffff0000858470c0 71662272 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff0000858470c0 71662377 C Co:1:002:0 0 0
ffff0000858470c0 71662411 S Co:1:002:0 s 40 16 0000 0000 0008 8 = 00000000 00000040
ffff000084a45f00 71662420 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000085847000 71662433 S Co:1:002:0 s 40 10 0098 0000 0000 0
ffff0000858470c0 71662512 C Co:1:002:0 0 8 >
ffff000085847000 71662520 C Co:1:002:0 0 0
ffff000084a45f00 71662524 C Co:1:002:0 0 0
ffff000085847300 71662631 S Co:1:002:0 s 40 16 0000 0000 0008 8 = 00000080 00000040
ffff000085847000 71662655 S Co:1:002:0 s 40 10 0098 0000 0000 0
ffff000085847300 71662773 C Co:1:002:0 0 8 >
ffff000085847000 71662782 C Co:1:002:0 0 0
ffff000085552d80 71663686 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000085552d80 71663929 C Ci:1:002:0 0 1 = 01
ffff00008598cc00 71664546 S Ci:1:002:0 s c0 07 0003 0004 0002 2 <
ffff00008598cc00 71664792 C Ci:1:002:0 0 2 = e101
ffff00008598cc00 71664820 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598cc00 71664881 C Co:1:002:0 0 0
ffff00008598cc00 71664902 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598cc00 71665004 C Co:1:002:0 0 0
ffff00008598cc00 71666138 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598cc00 71666259 C Ci:1:002:0 0 1 = 01
ffff00008598cc00 71666277 S Co:1:002:0 s 40 08 0003 0004 0002 2 = e10d
ffff00008598cc00 71666503 C Co:1:002:0 0 2 >
ffff00008598cc00 71666519 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598cc00 71666623 C Co:1:002:0 0 0
ffff00008598cc00 71666640 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598cc00 71666748 C Co:1:002:0 0 0
ffff00008598cc00 71667873 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598cc00 71668022 C Ci:1:002:0 0 1 = 01
ffff00008598cc00 71668045 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff00008598cc00 71668255 C Ci:1:002:0 0 2 = 4978
ffff00008598cc00 71668275 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598cc00 71668372 C Co:1:002:0 0 0
ffff00008598cc00 71668391 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598cc00 71668496 C Co:1:002:0 0 0
ffff00008598cc00 71669624 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598cc00 71669750 C Ci:1:002:0 0 1 = 01
ffff00008598cc00 71669767 S Ci:1:002:0 s c0 07 0003 0000 0002 2 <
ffff00008598cc00 71670000 C Ci:1:002:0 0 2 = 0031
ffff00008598cc00 71670017 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598cc00 71670119 C Co:1:002:0 0 0
ffff00008598cc00 71670136 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598cc00 71670244 C Co:1:002:0 0 0
ffff00008598cc00 71671370 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598cc00 71671498 C Ci:1:002:0 0 1 = 01
ffff00008598cc00 71671515 S Co:1:002:0 s 40 08 0003 0000 0002 2 = 0033
ffff00008598cc00 71671746 C Co:1:002:0 0 2 >
ffff00008598cc00 71671763 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598cc00 71671866 C Co:1:002:0 0 0
ffff00008598cc00 71671885 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598cc00 71671991 C Co:1:002:0 0 0
ffff00008598cc00 71673124 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598cc00 71673243 C Ci:1:002:0 0 1 = 01
ffff00008598cc00 71673258 S Ci:1:002:0 s c0 07 0003 0000 0002 2 <
ffff00008598cc00 71673492 C Ci:1:002:0 0 2 = 0031
ffff00008598cc00 71673506 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598cc00 71673612 C Co:1:002:0 0 0
ffff00008598cc00 71673626 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598cc00 71673737 C Co:1:002:0 0 0
ffff00008598cc00 71674857 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598cc00 71674991 C Ci:1:002:0 0 1 = 01
ffff00008598cc00 71675005 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff00008598cc00 71675242 C Ci:1:002:0 0 2 = 4978
ffff00008598cc00 71675256 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598cc00 71675361 C Co:1:002:0 0 0
ffff00008598cc00 71675374 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff00008598cc00 71675484 C Co:1:002:0 0 0
ffff00008598cc00 71676610 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff00008598cc00 71676744 C Ci:1:002:0 0 1 = 01
ffff00008598cc00 71676759 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff00008598cc00 71676989 C Ci:1:002:0 0 2 = 4978
ffff00008598cc00 71677004 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff00008598cc00 71677108 C Co:1:002:0 0 0
ffff000084a45f00 71723211 S Co:1:002:0 s 40 16 0000 0000 0008 8 = 00000080 00000040
ffff000084a459c0 71723278 S Co:1:002:0 s 40 10 0098 0000 0000 0
ffff000084a45f00 71723494 C Co:1:002:0 0 8 >
ffff000084a459c0 71723522 C Co:1:002:0 0 0
ffff000085552f00 72704172 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000085552f00 72704538 C Co:1:002:0 0 0
ffff000085552f00 72705838 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000085552f00 72706026 C Ci:1:002:0 0 1 = 01
ffff000085552f00 72706088 S Ci:1:002:0 s c0 07 0003 0000 0002 2 <
ffff000085552f00 72706269 C Ci:1:002:0 0 2 = 0031
ffff000085552f00 72706326 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000085552f00 72706505 C Co:1:002:0 0 0
ffff000085552f00 72706562 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000085552f00 72706753 C Co:1:002:0 0 0
ffff000085552f00 72707955 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000085552f00 72708138 C Ci:1:002:0 0 1 = 01
ffff000085552f00 72708181 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff000085552f00 72708388 C Ci:1:002:0 0 2 = 4978
ffff000085552f00 72708446 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000085552f00 72708626 C Co:1:002:0 0 0
ffff000085552f00 72708681 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000085552f00 72708875 C Co:1:002:0 0 0
ffff000085552f00 72710059 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000085552f00 72710262 C Ci:1:002:0 0 1 = 01
ffff000085552f00 72710317 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff000085552f00 72710523 C Ci:1:002:0 0 2 = 4978
ffff000085552f00 72710580 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000085552f00 72710748 C Co:1:002:0 0 0
ffff000085552f00 73724193 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000085552f00 73724515 C Co:1:002:0 0 0
ffff000085552f00 73725816 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000085552f00 73726004 C Ci:1:002:0 0 1 = 01
ffff000085552f00 73726068 S Ci:1:002:0 s c0 07 0003 0000 0002 2 <
ffff000085552f00 73726370 C Ci:1:002:0 0 2 = 0031
ffff000085552f00 73726434 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000085552f00 73726605 C Co:1:002:0 0 0
ffff000085552f00 73726667 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000085552f00 73726855 C Co:1:002:0 0 0
ffff000085552f00 73728114 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000085552f00 73728241 C Ci:1:002:0 0 1 = 01
ffff000085552f00 73728287 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff000085552f00 73728500 C Ci:1:002:0 0 2 = 4978
ffff000084a45c00 73728549 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000084a45c00 73728715 C Co:1:002:0 0 0
ffff000084a45c00 73728749 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000084a45c00 73728838 C Co:1:002:0 0 0
ffff000084a45c00 73729984 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000084a45c00 73730095 C Ci:1:002:0 0 1 = 01
ffff000084a45c00 73730128 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff000084a45c00 73730344 C Ci:1:002:0 0 2 = 4978
ffff000084a45c00 73730375 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000084a45c00 73730462 C Co:1:002:0 0 0
ffff000084a45c00 74748099 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000084a45c00 74748445 C Co:1:002:0 0 0
ffff000084a45c00 74749636 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000084a45c00 74749809 C Ci:1:002:0 0 1 = 01
ffff000084a45c00 74749867 S Ci:1:002:0 s c0 07 0003 0000 0002 2 <
ffff000084a45c00 74750050 C Ci:1:002:0 0 2 = 0031
ffff000084a45c00 74750107 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000084a45c00 74750286 C Co:1:002:0 0 0
ffff000084a45c00 74750340 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000084a45c00 74750534 C Co:1:002:0 0 0
ffff000084a45c00 74751711 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000084a45c00 74751921 C Ci:1:002:0 0 1 = 01
ffff000084a45c00 74751977 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff000084a45c00 74752295 C Ci:1:002:0 0 2 = 4978
ffff000084a45c00 74752350 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000084a45c00 74752531 C Co:1:002:0 0 0
ffff000084a45c00 74752603 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000084a45c00 74752782 C Co:1:002:0 0 0
ffff000084a45c00 74753952 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000084a45c00 74754150 C Ci:1:002:0 0 1 = 01
ffff000084a45c00 74754182 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff000084a45c00 74754399 C Ci:1:002:0 0 2 = 4978
ffff000084a45c00 74754430 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000084a45c00 74754515 C Co:1:002:0 0 0
ffff000084a45c00 75772099 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000084a45c00 75772446 C Co:1:002:0 0 0
ffff000084a45c00 75773623 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000084a45c00 75773820 C Ci:1:002:0 0 1 = 01
ffff000084a45c00 75773880 S Ci:1:002:0 s c0 07 0003 0000 0002 2 <
ffff000084a45c00 75774179 C Ci:1:002:0 0 2 = 0031
ffff000084a45c00 75774236 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000084a45c00 75774413 C Co:1:002:0 0 0
ffff000084a45c00 75774472 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000084a45c00 75774661 C Co:1:002:0 0 0
ffff000084a45c00 75775841 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000084a45c00 75776046 C Ci:1:002:0 0 1 = 01
ffff000084a45c00 75776109 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff000084a45c00 75776296 C Ci:1:002:0 0 2 = 4978
ffff000084a45c00 75776336 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000084a45c00 75776525 C Co:1:002:0 0 0
ffff000084a45c00 75776561 S Co:1:002:0 s 40 06 0000 0000 0000 0
ffff000084a45c00 75776648 C Co:1:002:0 0 0
ffff000084a45c00 75777808 S Ci:1:002:0 s c0 09 0000 0000 0001 1 <
ffff000084a45c00 75777910 C Ci:1:002:0 0 1 = 01
ffff000084a45c00 75777947 S Ci:1:002:0 s c0 07 0003 0001 0002 2 <
ffff000084a45c00 75778159 C Ci:1:002:0 0 2 = 4978
ffff000084a45c00 75778194 S Co:1:002:0 s 40 0a 0000 0000 0000 0
ffff000084a45c00 75778271 C Co:1:002:0 0 0

--xdhybhgdthz6o5ig--

