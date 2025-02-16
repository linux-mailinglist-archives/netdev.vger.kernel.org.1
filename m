Return-Path: <netdev+bounces-166780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F451A374A8
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 15:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1741890C33
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8718DB18;
	Sun, 16 Feb 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O5gKAlz9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8212145A0B
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739715326; cv=fail; b=olncM+NTKzQINnpfcLjIr6OH0zh1HTDb7HpIuTlfekQNcMvdsjZsk+iowaWDNcdRvgwIvVfUcFTq0LxNp9+sMBlZvXKODMeFfPGl7Xd5ozB2GSGhiQP07fIo0NA3AC9j4jFfXAlpJjE83yr4Ecdsd266y/cUctKCU8baeP3UuWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739715326; c=relaxed/simple;
	bh=kDtffDlD5pdBtcJ/BHan5Qm7i7ucK9SCcjUovNN05RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n9Xownd4YzuuSo+TEFSFqznuUIv8fQ8dfaabuwB52pdIrU7sylp/grQ4cTnOzNd2OsDXohOi1D/lE2Zdok0aSca7urEPLGRfdNbkU6jZbjIDT5nIZv+X6cQPzKcnlDNFMaEvw8UCSU5gVUqUhs51cgSzH8fj2j61/GpiI3H0HL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O5gKAlz9; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6Gt4ZGXq83Fx4k+/MbbVZ++v4Bp92tOE9kSCLFrkPE1OP/z5nny0Lg66WbG67gl/UnOqjpMSffED4bpODHCbajtUL0e7RQZmhmjOhpF13J+CnN4xx/eKGPXdjIk8yVKiHzSKoEigE0R1b8g84S/pNX2kN9yIvgP6VcmVYJvieZbQpZeQFtcdgpuJPkUIX7NlogSoaWjvsr9vQd/uRj6vlPsVhQt0Dw9RTJPTj7i+QyHUTBrvroTBDdnu2TLoG02P5twXkcbLoyluIJ5Y3+AUOyL8CLTzpn2nAllj1IqTyqu8KEVC6WVBemgmilA+CJ9CKe4nH2E+SjfzR2P9aNCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs3NsYppHpdun9uHJYsYRycN189NeMNMeafEZSZwIR8=;
 b=fb8zbCxR7RMxfMUJ5OQhBWIlXxXAiSRiouiNCsbD5pu/azbfaHvF49mY78ALSrYMtk7m8BJR852ZDq41WUKtxShZMx8LJUmmdkEHShQKM/17R8XFLdJGntuIpC6MVv34uVrHKqw9uSx67OQbB6FE8kIvilRYo3x/JDI5bLDfBVaIochabrMOxJ2NqcK6z82g+65yX1l+W7GRgDrnoLDJI1E+Xx01C5tz24gNIvgXZdIJyzGhHmH3uKMdBqqLOSiNKCiZLgx2W5dPSzmYWeGoi9EeOzWqrTkPOMlBgJH7IvdD6psf918Yocbv5aBWLWEyoVYMzkw8OmP9tCnR4gp6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs3NsYppHpdun9uHJYsYRycN189NeMNMeafEZSZwIR8=;
 b=O5gKAlz954oYDFj1xZOEF9iKTEnb62tjSfVVracoBKjd9kS20G5RqC1XTR5abOrXduNTV3t2VlsC3YmGd1N+bAdw1omMIIEc0iw28+4eVFxfsoN3XvruNN74Sk0pEKlSfSZjNY+mzZgkomghpXVREsy6QTGim9Xc3foft19GDmefGHSYgdliD0wNsJXTRGt6RPPLC6wPxOjFsVl9gJ8l961s3SlnDyy8vlR+6N9SW62V/NZJwiE1h8e8SYAFvgdbDTzTtoATL3wlnD3yyByBl3EdLEU8c/O423EJnkcH9O/XbjPsQc/L6ZbmUdJ1eAOazUdD80klmTKATvpO5cFNlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sun, 16 Feb
 2025 14:15:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8445.017; Sun, 16 Feb 2025
 14:15:19 +0000
Date: Sun, 16 Feb 2025 16:15:16 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net] MAINTAINERS: create entry for ethtool MAC merge
Message-ID: <20250216141516.mpop55rl6d2f6ar2@skbuf>
References: <20250215225200.2652212-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215225200.2652212-1-kuba@kernel.org>
X-ClientProxiedBy: VE1PR08CA0027.eurprd08.prod.outlook.com
 (2603:10a6:803:104::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e4cfd7-2e8b-4752-1eb9-08dd4e9457cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n43AmdYNr3CUOI3Q2VPICw8rPhHMrihwLBw1lhqRaV4lX5Q2abe+a8SK8g9Y?=
 =?us-ascii?Q?Oz9akJhhYAGNj/cgIBrUantRN0bb0qn4rla9Yy4yjnCP3iWV8YssDbajLHxA?=
 =?us-ascii?Q?c2uM3I0PKbZqJ5fE47RPqMwHQt3dLO7L+5FGEdphHe14BMYMEXHdHAZXREsY?=
 =?us-ascii?Q?Xl6VrRAkG6hyVkuNdZkIGQ3fweSr8kExoPIUvUWh8aesbPQk3J/VHv9mDIvD?=
 =?us-ascii?Q?HkLWuAr0XLBUfS3+gKqx/A74jIeLZLHxjfWFGOffJaOYV/iGvcRuvYvIYmIf?=
 =?us-ascii?Q?vE6B69k4oIDtGKZIZKOnLgX5KfAdYv/Dl5VQPp0bBucYiimUKAlkKiE1xDBx?=
 =?us-ascii?Q?PRlF/CaXGn6drxHY9fedcdJYpicgUjFBZsMiI5d78dIBM5yUe8TB2NIBdtV9?=
 =?us-ascii?Q?ovqrKZ9Kw30qA3ZgiUq19g9F2IT1MjJJPBFa3G4oUMKrap+/XBjJsdV2pwG2?=
 =?us-ascii?Q?NJy6kY9lHSE/HCJOcmOTs4VcyMiY/ZxAEV5IwG4EW+9CNFpHsgmB9ecnHMfA?=
 =?us-ascii?Q?ac1XG+v76j5QAbqAB0t5rbiBUXFHe+2p1rre0xK7D8KlX3RcYU/BH5xOlbEU?=
 =?us-ascii?Q?NDu9rI5iGgOKeCOEzDr25hHFnpPrKQHXQmde0OCNTQYxlpIeVQPzNM8QcoVK?=
 =?us-ascii?Q?TpYGRzTfH0mbJy3//3ytATVbtBFf/9odDSTiM+8YhK53dj+Xm2pxzePFT9QI?=
 =?us-ascii?Q?0N0VdM1+wOUavGsEk4cJrSTXeJl5mTks/3JiuVIg24BbQo0nlZXNxmn+LC2e?=
 =?us-ascii?Q?+p3VQlOKC4INtW1OdJpbJCG6BkAGTsN+93eSgEBgemD/ZCUhwIE7ZGbU7DYC?=
 =?us-ascii?Q?7My2b7+5IIVYstC8d8DPV6wb8j+Smnxzoz5gWbKexkDqEJWzUhPrQ4RwJuaf?=
 =?us-ascii?Q?vzCd8EnYJs6fC/2NRbbuI6eJ/AFRVBcNFwV9dXF7y/FRvnNEEncRTutHjBEZ?=
 =?us-ascii?Q?g1Wu/RO2MFZqo/3RsVr5VmHg9uybDjY+ytup7aW5c6De6TRK8I/K2TxC3zMz?=
 =?us-ascii?Q?5YaVQr+0+HAmvDlYOsN75/sEGruX5hcT3i/uZfDrJPXFFrWL0CDPZ6ulSHeU?=
 =?us-ascii?Q?wC1PySvBrHcloNBRE0EnkBYESwneVe5WDe4q4EUIEI+bskzM3RqkGIm+a1vn?=
 =?us-ascii?Q?7uU/ecfQbIYsSHn0xUJRALKByzh66qOIfWD44KoIjiwkL6647mdBq/FWpkZn?=
 =?us-ascii?Q?tKSvuS8XaK18mS/vhSPIPw6Gi2BQoVf1FHkfonHA71ywZoYfvF5z7Zfsq9L4?=
 =?us-ascii?Q?L7mQ58eOh8nqkL39pD2om9ctZwd6muGdiB4JXylPmMR8YQCBYqH0fUSyz3ZW?=
 =?us-ascii?Q?kW9v0iDk5aT0OgX755iRL+9WviM03G/lpLzIJWhdr+TN1/l4+62QQ4347GDL?=
 =?us-ascii?Q?QNVJmuVJQPtIlBhGuKQWZLu1Db8L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mdL4739PctI2ijoBHk349m5x5VUPfNgAv27Fwyy+DV4Q+SLf2mNlszktUqAr?=
 =?us-ascii?Q?58wXQhpBwkIHkapiMTgdeayYVVE9ZyX2szZZR/4ddYGrdiTEItn5aVHVDhx6?=
 =?us-ascii?Q?T4QkTnHuUV31Ocv3RDDcXbV112TKE69V5eGXGhd8BaFga5Ejtlzyc6sC1FT8?=
 =?us-ascii?Q?iDUeEnaFWIguSlkxbQWiJZTTNEb/ii4uwRV2Yuiem4+EjKZI9qQzSvCADUZI?=
 =?us-ascii?Q?7e2DLbdNuITLmmeSZPRWF5Z8WCFaLyvvch2sEptizSwy9cez+puJKV1NJvJ0?=
 =?us-ascii?Q?QgW3OTcgfFAw7OJUz7wPOL7bExt1pL4njYNBeIJBbx9cJpRhj2BbXrWXjiWH?=
 =?us-ascii?Q?2EopAEyf1WRN2ng0yI4eKQCr6fBRikIwXv3ArSZ/Daj89xTbok1mwYAXI50g?=
 =?us-ascii?Q?SxzWpn43GP3iOKT1kQuTfVCx23K+nZ8uhTFdcioPL9JxijMqMZzzuSW/YDZ4?=
 =?us-ascii?Q?gGVXoIlFnMoP/G/nFPaSRG01hVAHNDhNkHrnlDYihr0VfFKsgdRpVC7pQaK1?=
 =?us-ascii?Q?/0wbGywBrbJbd4XgXTqi00QtmUB+4lzul9uir9Lh1Zx1B4E1QKycc3J+lXpy?=
 =?us-ascii?Q?x4I3a4PscMTVSSS1Zg8RKHODaac2/1YBtCPZAVbqPF57WKWFwhsDjPa910rl?=
 =?us-ascii?Q?vzpizDJpvBoRe/BBgStdfEuTKTPpT9v5UsDB+FPO1sAi0XXauus1wT91xqoU?=
 =?us-ascii?Q?9lVkhHqXWfAhbyFBQi6dkvOOQP7e7eAN8BRRvcJ+/YslSzCTEanTJdnTPzND?=
 =?us-ascii?Q?4WY0tJIXgDMsBgtD1DkxCTvyRQUVjNY9ZBSUCF69SsqaImyyBrHF4dWJ7uPV?=
 =?us-ascii?Q?dlv2JonDebafOK+lQxhMUHqj2P2qgQHCIuzTfgUUlN7TVbquBCDOPEoLyngc?=
 =?us-ascii?Q?j2yw42qIWw+MLT9NmDKgIozY8Cq/SMcEQ6+inkV6DkN640ob4cZXO5AOzWvG?=
 =?us-ascii?Q?+fRdxHBm7bDZwJwvorqTIJ7HNKRjbZhdA75dMc4Hq6hk+6lz7QGoj12AV5aL?=
 =?us-ascii?Q?+5lJCiA/8jS+LGEp/plRWb5VQ+2sbx0LgVoMszQXEDHj1Zpv9XmxT1Awi7j0?=
 =?us-ascii?Q?EqbdB8qptMCngOnYYmITZXUxGaN6BW0M3P26TDwWoGyXjvx7yya0+X5DHNfY?=
 =?us-ascii?Q?qFHaI7n6bWuZdUJCwBfm/vUvUbxmJ1DqYdLBrnr20sSDXoOGyl7VkwyKwOds?=
 =?us-ascii?Q?DIPYwI8LwCZZtPLnQMdehZRo/ExenpFU/hj/2qB7tLKKm4W4IWX3VXoYp/0/?=
 =?us-ascii?Q?Ce+Pa+9WtqLRL56gc7BUfTzi3cLFQpm8ro03G1zFTYdfTkzuJDMdxc3+PDRA?=
 =?us-ascii?Q?681mYqrnes+dnCz+dbp5fYWR2ZSBBoN5fP9SelWstJV92Sbqm8ZZmrUbtgzC?=
 =?us-ascii?Q?2CG0S7kgLtKAclEAjRanwelCZSUBvQdfvkfh+p34uh4Hc6QkvhFYzLu5k2wn?=
 =?us-ascii?Q?Vxc/FyhpvdjuU8zxg92vOT7DLTonMkVYNclUeMNapf9T/vPikKuAmem/Ti1S?=
 =?us-ascii?Q?Hr+6bCoura1oyrzHqR9bX7kDi9jr3GyJnC9QUFCOyXrgBtgMRulK/xh+q6Qi?=
 =?us-ascii?Q?5JrLrvYfVF7emHnJuRHuXOGi+/Me1HT8ZyJzSNAZ2Xh/2iyLaX2a2UWIYprP?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e4cfd7-2e8b-4752-1eb9-08dd4e9457cc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 14:15:19.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdftLXfVQdo2VVPqUzQqH2TYuJuJarYgYz5EOQJJA05SCNTmuYwyTe+w/n7m9UQWc5Qlou9q10AeA/FJhi5mnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

On Sat, Feb 15, 2025 at 02:52:00PM -0800, Jakub Kicinski wrote:
> Vladimir implemented the MAC merge support and reviews all
> the new driver implementations.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Acked-by: Vladimir Oltean <vladimir.oltean@nxp.com>

