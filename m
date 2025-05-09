Return-Path: <netdev+bounces-189185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B645FAB107C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE324A7A25
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB528EA67;
	Fri,  9 May 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UwwtKpFX"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013050.outbound.protection.outlook.com [52.101.72.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E538FA3;
	Fri,  9 May 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786254; cv=fail; b=iZnUIfXeKR/vhRya+9V3sCp0agOqU3PW4RdpJKBRRq8KNv3XlQGFZ3waMGbgXvlwCKiW31aGTlsALfNhhwaa4f98u7hkNJqlSCFmQZcviWhcjuF+4g4I1T4PmegOm3D51nviTsYdzPbMlkFcc2QiO78n0LxD/Te4bcJqnIcFUhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786254; c=relaxed/simple;
	bh=Ym9lCIc7IqAi4rAqHKZ6Mu0FbAlZxGn8fIyRq6aZPyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lFh0n5cJDvRLR7VMHL0punLce8Czda5Hjp/tSCN12cMfRSBKLmAfxe+FB2fQHzzyY6M1tk+61jLSUBS8DHY7NaWtOLR7kIhn2AIRv9NKs2Ytxq6XwW3vHRzPs4gnn8lRyDVgWzPBr+lrQ9cJCErRMqIqsQ7x55mx8k9QwgA8zJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UwwtKpFX; arc=fail smtp.client-ip=52.101.72.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDJ1rkznFRmhLAmbGIm0L9a8HBoht6LQHMtPadBbQHmeIxXpXRMwudg+wEZQqMfFcUCEZKgQjOiOxIv8Si9lfNcPg5je2TrQ963Y6ePACLqugdeMiqk4E8DwloeXdUayCaqHmaOh+I+aqyg7REj5Kr0PJwMB9N+fb7s7jTRI8EGTeuhWYCzNNYaly0tTFuukgkx11jqr5gDnrlL4h5cxRlA4p/IidRUpB4nswMgPjED/4WW9HpYnkqqLVsiLNOgCYv1XwhwvtGtD+BscTW02HlttN4+aDkfL0ZmDGem7mwtVhZUZdCA4LdL7B7GirSayCt2rkNKX+kWZjdeT49ByKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY4EWLJGAiEmOGRC5ASOnBkyiDdu+ABfkZwveIVsx9A=;
 b=Tl8NwByrcROBIhpU1O2xAdRXdoBafnwOK1P5Npg8nxhvHvmY52e6JjnV3FrrlLkO9K0ztNQ+09tpxdLZsFXjkVeyN81wd/0Fm6iTwsZmQX2z4P/sC91r2/Nmmilukj4zSu65z1uE4rb/H20y6RjPIc45SUJA7Jphzm5g6AYXN39KmJzBxE33X2FzMlGek3i+L6Z/LN26u7vC2ngymPzIMTJ/qiiv9f/WoCzHRQ3kwAUfv1j7InmZfwHvIM3aUQz/XLi9FNjEawwfXDCPkOP67mts5AY7tZIEjDIqs/m64lyHh+i7AA0ANDRqwYSljeISgKfod1wW0qzkzFJ0zxbzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY4EWLJGAiEmOGRC5ASOnBkyiDdu+ABfkZwveIVsx9A=;
 b=UwwtKpFXt3KgWOHMBVXGrishW6htwV8fc5Pm9k54UQ4wJ46NNannvRRBmHQ1LPtG7j/M86/Ndqa+jlrzfq/qa7ZKQX3cjHVg88mAigEuezdvxAEEykVpfOxzIGcv0l+LkZhhaAlgv4ElCgW9wGci/rmHCXFmo+BU9Wza1Jz4MpbC9PHpC96Sp5kK4ElxuwVC/6qA6cype46NhreleZBtkFKp5MGQB/jrRokpcSwwQZIgW/uQsPbPK+6OXE/uJBiF4n34FKpntwOIM6719/AlohTjEusuYtGM5SiYFcSJlzauu3Gth2r1Jl5NN5xvQ5qgBtMycrGCPsr5F2WkIQApHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10719.eurprd04.prod.outlook.com (2603:10a6:10:580::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 10:24:07 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 10:24:07 +0000
Date: Fri, 9 May 2025 13:24:03 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?S8ODwrZyeQ==?= Maincent <kory.maincent@bootlin.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: enetc: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250509102403.6bpb6chwwbxoqlvw@skbuf>
References: <20250508114310.1258162-1-vladimir.oltean@nxp.com>
 <AM9PR04MB85052DADEB4DABF9C7F83BED888AA@AM9PR04MB8505.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB85052DADEB4DABF9C7F83BED888AA@AM9PR04MB8505.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:803:1::23) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10719:EE_
X-MS-Office365-Filtering-Correlation-Id: ceae35eb-86a0-403b-74fb-08dd8ee3a113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nq0g8wvxVcFtxShNsrOE2Lr3YzldmF88rAYM7R1StM0WuG5xAzU2lYtMZ3FC?=
 =?us-ascii?Q?1kd727Cw8FGpALq7OpARu6D6rkTeadGzoAzskrMSJUKvstZ1OPj7a5i3Gqaa?=
 =?us-ascii?Q?TYRbIHZdrPbg+teFqYb04llb5xY2eSLTIOoIJ1tlgauYgSvs23zsIEedm73l?=
 =?us-ascii?Q?WC+lQbYVU4fvPxe0K+vaN1anDT+wNJOftzFyuPQeZgTMXzjwK8anM0GFsazo?=
 =?us-ascii?Q?OJZG7f8GN87pW57j5/EFAPLqm5cjD3evAF6yYQwScuB260CJip1kav3PS/zB?=
 =?us-ascii?Q?Ko3kSZzTe1K1vAGQK0k0jwmYeAJeaUFPBoB16TboTyNp8sD8mBHEmKpNuDpR?=
 =?us-ascii?Q?08Fk6GOtc/04daqvzb+FWCL9kTLxusaClmiYJMnqbXv9OPyIKNiqK91Q6OVA?=
 =?us-ascii?Q?ENr0iPRG0ol0I5Y0erYbHN6Yz03LB+FYSbwyMkH7bji6gwTdmM3W1XIWT9dj?=
 =?us-ascii?Q?Bk4c94Ck6+V4wKBHqz9ZpMmGOnTLzdz39tZ4qbv0oFe5IX6SHa7myB+KJO5x?=
 =?us-ascii?Q?gnysZ5UFCzSt1xSXwqAf2Ucsj8niM3X1QjfopdKxLPP190bitD0YTiu4EY+F?=
 =?us-ascii?Q?f4yOzgGq895rYp6xQYB5KWWmddpitgciCYOqZS4cJGEftAWs0SMgsiba2lBT?=
 =?us-ascii?Q?bbISdYeRuLeaBiB+O8BAJGXlfYJtFQmd25TTmRgnB/gYY0eBIrwS5z5INqLf?=
 =?us-ascii?Q?kVncnd+TIOpEYSs5z8sdcgDeVpDn41MvlJYknrBCYYkMGBdn1wYeeP6hn5HV?=
 =?us-ascii?Q?+RChwdd8YWx7kl9cOqMceWzj0XsjVvg0CSqUEgpzVXPw18JwW8oHMKxWpDaa?=
 =?us-ascii?Q?icQzpXqHTS+qr9Y8PQpgLlsJ3sTTDouHwc/SgjhKOMdNnvZVKZfCSci1t7+G?=
 =?us-ascii?Q?AcUgDcRV5MGLH8fNlkXR80VH7fkBrKpRTA0UIGkLBVtVUowDt1NBt5iuSLc2?=
 =?us-ascii?Q?pZdWR8mj/8Q5BmzusY3Ck05AC19KSFagrbXKic9qraro6Q4z9hVLgaIxPfkZ?=
 =?us-ascii?Q?chfbYn9wAVLYU/ii5nM7Ep4FrU2xcRXvx7vqF9dHhHcQsslCh2MqZ2uDDPX3?=
 =?us-ascii?Q?D3c5W4EwMR2Lnvb11B60RMIuPVOfA4K6CI3uVJqI07Emq6nJe/YwMpoFwroI?=
 =?us-ascii?Q?CfQRZkxJvC0UPqdImoudahF6pBCFP3dQmZ5XJst8JIIIlFnUJJ8D1rtrM39D?=
 =?us-ascii?Q?q+KCqz9XqHvfV5ZdHlT1tbbG3gcNndjktQyMAFE7teGCj6dYM8p06RPDSEX1?=
 =?us-ascii?Q?QSIhEw1mKSfBVb8gtfq5oWMf0KPrZ9AfZgVt2MNyrWgbubBGCwKMs0r4BjTw?=
 =?us-ascii?Q?+sobYIomwTM8CVIBiXMxzXyeVsGZP7IsY5H/NQedM42nDp06ZYeQdnXG28xA?=
 =?us-ascii?Q?x4exj3X+3c6fWczvzeWtM03V2lrkYRaKS8XvNia+nyzpmaCH5YvoQnjW9sVF?=
 =?us-ascii?Q?P/EturZCwP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZrVLW5F4jQa0hMHd/MJwtOb7qXZJoQaKIgv2CRLuw5aFbKpL8mEyu/RxpJOX?=
 =?us-ascii?Q?rsl8uEGkBECHaDAHC/eH4aw0hcuDM8mTQJORxMOP1sUyNmGlrJ9zJzYUHi1g?=
 =?us-ascii?Q?YYibPuEtqK0Rxl++rkA6mVWf7bbGgux3RtrWTZ5Bz0tV0KXtna0PHfG6jLp1?=
 =?us-ascii?Q?6wYiL0Z3DHWdHS/BTsHocrrgzN/8DBYE50G0aHBc7V2cwzeQ/nwfqsZQU9p8?=
 =?us-ascii?Q?xhpGPnSgcHZwjXYHdZMOoH7QV4smv11GYVrLobhJZdISO1L2PT3QdZ7uLw8Z?=
 =?us-ascii?Q?NnK4NE2Svz1XAn5zqFyr+f2v2oQeg0977hyWN5kG+qeGtr/S9oOTPWCcBEKY?=
 =?us-ascii?Q?uG/CpzhwmrcJd0XNNZw+BhylF/EDkpa70ei6OYthy34j4ZrBSl2cQZYkGAtK?=
 =?us-ascii?Q?k7UjGl+UNtBJuPQyWlFyHM+e54COp4YApGCt5OQwWmRxJeaA2J66J7uUR0+T?=
 =?us-ascii?Q?jLunDBz6XVlBNLpSRlvG4NiYUgzxDMOmCOVSSXaZF7PCRamv5dyFcJ8Z5SD9?=
 =?us-ascii?Q?1jXKRluO14MZQ4U17qd7bVbgloerPnRtvTjz8X1pMPGOAvMf8ruCYvHTmAs6?=
 =?us-ascii?Q?emVydqwzFghwJiJzQPkxtwuWDeBA2jgh3+J5FJ8py3Q2ukHSnOXuFTbVV23h?=
 =?us-ascii?Q?Bj7pFKeb4UkzLuj+92vVy0hwiWDUqxwVFMlvNE+Pz3ZvKAB5T6h02SUMJRI8?=
 =?us-ascii?Q?TsWRqhM3SSTcDEkNUHETaK+JrymgVvx9pH+nfmQp6PCLAb9Bioq+5bt+Kf78?=
 =?us-ascii?Q?QMJDW8pCA70qVEJpCCXkD2vZaGTrcaAZekolE8xD8MotG8i1PRXJX2RUjAQb?=
 =?us-ascii?Q?7wd/yGpp1BZEJrby1SoDXSZRWs66NhxbN4otbZuueRd7ClSXs5iZD7j1NX5f?=
 =?us-ascii?Q?qsAXhQhYj4Rwh59CeluwnJJ9BQ6x1TLMbTcC0fsVGM40Rz+SdXXfqOzwqGUf?=
 =?us-ascii?Q?IC28yBDyI9Up68qcG38V3JVlnrTgyoO9ByRWuNFaoScCjxsbDXLZjVHMMA9Z?=
 =?us-ascii?Q?2yrOCgx3fRtlKpue2lWlDVg6lReiSOFPstF+c4aKeWv0G/RyEqfFf43Bmd8b?=
 =?us-ascii?Q?q933bZqnoyJALFVQxEvtEgs9AvG6DXqU7Xl4YC35A6LKp9KYvJZbOxlxFrVY?=
 =?us-ascii?Q?5DYeUhxzozTB0u8LTdRPcjSBeWBeAbgvj5V1yrd7ibHkiokUbSKy6plAn/AN?=
 =?us-ascii?Q?Z6DIUc7nlU30cMkgkKmjxsrsumxxial46shjix6r9HP73vYg8X3rxobiZckM?=
 =?us-ascii?Q?AnJEK3JjBIQDjmFNOgNXyJxQdMm7bIGz6LxBDbv4Wpn+7nD2TLO/HJ9jTTRK?=
 =?us-ascii?Q?9BlFAPlfwUp8q814LjXs/RoGkQ420zn2rSowXYKjQZDdb71uyLtAw7VpCBIn?=
 =?us-ascii?Q?QTyDg0XcEF7Z2xKY9PpRpE4ugnI8TQhbCEFWu0aHFs+11jPEMuhU3tz5Luki?=
 =?us-ascii?Q?YyWAFDidQFfnvrC6oIwCu+iY00yvX3q8mlG00WM0FhMXUwusCr7X8swsuY6i?=
 =?us-ascii?Q?fgu66l1gsRB/4DGTVN1hsNlfLtRBJSrO+WvagECEzL4yPUB3RwRrbcoo2dfr?=
 =?us-ascii?Q?RihTXkdPN+ZsYdm5hJxIaAOHALoFPIGuCSr+o6flpNVnT4dsq6kp4oiixCPZ?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceae35eb-86a0-403b-74fb-08dd8ee3a113
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:24:07.0102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nms/JG47BhIRlzqP2lKXaTLLN66IA4lKkdmDR0AKvTxg+GxYLiq6DapzQmeAHzwNBLhiZL9WlRvVWjqUgdFT3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10719

On Fri, May 09, 2025 at 06:15:40AM +0300, Wei Fang wrote:
> > -static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
> > +int enetc_hwtstamp_set(struct net_device *ndev,
> > +		       struct kernel_hwtstamp_config *config,
> > +		       struct netlink_ext_ack *extack)
> > +EXPORT_SYMBOL_GPL(enetc_hwtstamp_set);
> > 
> > -static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr)
> > +int enetc_hwtstamp_get(struct net_device *ndev,
> > +		       struct kernel_hwtstamp_config *config)
> > +EXPORT_SYMBOL_GPL(enetc_hwtstamp_get);
> 
> The definitions of enetc_hwtstamp_set() and enetc_hwtstamp_set()
> should also be wrapped with:
> #if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
> #endif
> 
> Otherwise, there will be some compilation errors when
> CONFIG_FSL_ENETC_PTP_CLOCK is not enabled.
> 
> > +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
> > +
> > +int enetc_hwtstamp_get(struct net_device *ndev,
> > +		       struct kernel_hwtstamp_config *config);
> > +int enetc_hwtstamp_set(struct net_device *ndev,
> > +		       struct kernel_hwtstamp_config *config,
> > +		       struct netlink_ext_ack *extack);
> > +
> > +#else
> > +
> > +#define enetc_hwtstamp_get(ndev, config)		NULL
> > +#define enetc_hwtstamp_set(ndev, config, extack)	NULL
> 
> checkpatch.pl reports some warnings, for example:
> WARNING: Argument 'ndev' is not used in function-like macro
> #140: FILE: drivers/net/ethernet/freescale/enetc/enetc.h:531:
> +#define enetc_hwtstamp_get(ndev, config)               NULL
> 
> And there are also compilation errors when
> CONFIG_FSL_ENETC_PTP_CLOCK is not enabled. It should be
> modified as follows.
> 
> #define enetc_hwtstamp_get		NULL
> #define enetc_hwtstamp_set		NULL
>

Ah, you're right... for some reason I forgot to test with
CONFIG_FSL_ENETC_PTP_CLOCK=n :-/

I'll send v2 as follows instead:

int enetc_hwtstamp_get(struct net_device *ndev,
		       struct kernel_hwtstamp_config *config)
{
	struct enetc_ndev_priv *priv = netdev_priv(ndev);

	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
		return -EOPNOTSUPP;

	...
}

Much simpler to handle.

I thought that enetc_hwtstamp_get() is in a translation module that only
gets built when CONFIG_FSL_ENETC_PTP_CLOCK is enabled, but obviously
that's not true.

