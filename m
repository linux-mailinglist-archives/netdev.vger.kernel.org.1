Return-Path: <netdev+bounces-135806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103DC99F40B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4621F20F0A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C51F9EAE;
	Tue, 15 Oct 2024 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a4nk8oVu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B461FAEE0;
	Tue, 15 Oct 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013396; cv=fail; b=rYYZm9wQzQFb5j7fGzcRdCjKQ/w1/lsp4x3Qybm/HHle/R3O6TOmvcUm3ub6vwSqdB4uJZZMjSgc49wGMIeOcu2twsvq8hEWqMcb26Sue9ZR7qa8NDlBkH8AvKKX4c9/PMHFyRIn78Vo006jAFbLQ2cqFIRaolAnkC4ODzgHUKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013396; c=relaxed/simple;
	bh=iqaNkKlaAbZm2eiP1qbSoj9kj4alZHe/pTKhv6hrZJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lhM26VjrGJyEKO1WXSpRfxkT8ArwtDsLv/bQH5UlZQQpcTigXysqFIZd+BEZ0Imo4M5ZDlMNfdipi7hdoqJxO0yMFyawqgTvV30j6SoUibVzZKyHyZIjhJjMAHr75XUtQhhRw83Fq2jMS8zEw6KsPSV0IP+sKqikLIoV0kE7LuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a4nk8oVu; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibZpFQyoyd3Wc1tRXt05+mFjHh7W5WVkcord3n49cmT0RNUtRwrZD61XGlspyE6vB416gwyHgN8qlJLCgBWoyaY7q2mQuT7KRcIiwlPcIliWuWBXamosVheh/EJBvbPhVKJ2600cXrMo2qbO26PX39tv1wQQKacUR7QD6lHtOKWvE0+uXMHuSOiiZtBCvla9KI2sAQoZESQtgRXxVMHWjEOpN+BOkoYeZKbw2aBDNJwAF7IDn/0N1Ev12OdEgCkHZWknnSi/JkOxmRogHPAl7WYFBcMYdHoh+YSaw2BJqo3GFsbawmOi4ov5FU3e3I5i6lTJa9fKMjliGf1gkZ6z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3YiibD17f+yOMI4rorypzf8N8CM2lCHyJQ60/Iz0Oc=;
 b=q0ztjA/oGNjc3USbNacz3Q9sgrKW8i7WinNGjx/V4XE6nb47UuAdPMaUUHJr5axyWGfk7QTcxLHSpagzibqlN77hL1g+IaT/Yg4ZW92Ob8RnPPyxb8lioALVoBKe4BGeVsfBL4gSYfm2otS5OVkuq24/VxxtEVszOat0S4k+EL8+XyuOtVDVIx+LeJXIS4HLcKDrIw+VXCP4c5I+H8vI49cS+Zt76pKdYFBn5/oXB12+A2tMlPpkk1gRtzqoiMdNrHZgvXZFwpk8lqR6t+sKXdf037OTooozuzU3uBLx8JPAIEVQYaDIJofalLg7MW5VcNB1hzjJa2Jn50WnIN2KnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3YiibD17f+yOMI4rorypzf8N8CM2lCHyJQ60/Iz0Oc=;
 b=a4nk8oVuO59Gp+3Q5m1CYAsjFoc461hfg5aAEMUuLSBzVqHw7FHcKyOeq7JIDtwdjtCUakY2vnOxiADlwG5SYW23NSrF1L2Aysy3uYJrPtDkR7e7uNv0WV+Sb/FxuI/CKxWv/YSYdjLXNeUyfaFDhO/BHOkxuMt+VaE76hPWo/qmyucBx0Sk2cxoDj+GXcUEMR71zwaZ2q64sestj1Tx8hWn/bXoDOoz8X1/7eCU3/6Z3YuXCJaTnkgCG8JyHOz1PPbAUVPtt4viMh8kC75w/+bXDhLkvGVmQuqn1v6g0MF9g+SUZirUnuie7g1/yZi6ak24Z7OxuR2MirDuyJyOWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7636.eurprd04.prod.outlook.com (2603:10a6:20b:281::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 17:29:52 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Tue, 15 Oct 2024
 17:29:51 +0000
Date: Tue, 15 Oct 2024 20:29:48 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:" <llvm@lists.linux.dev>
Subject: Re: [PATCH 1/2] net: systemport: Remove unused txchk accessors
Message-ID: <20241015172948.xvb3xoed52zhaqtm@skbuf>
References: <20241015172458.673241-1-florian.fainelli@broadcom.com>
 <20241015172458.673241-1-florian.fainelli@broadcom.com>
 <20241015172458.673241-2-florian.fainelli@broadcom.com>
 <20241015172458.673241-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015172458.673241-2-florian.fainelli@broadcom.com>
 <20241015172458.673241-2-florian.fainelli@broadcom.com>
X-ClientProxiedBy: VE1PR03CA0022.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 234cbd4b-a293-4e0d-f8d9-08dced3ef9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jyVwayIJ4m/13QWjqKBDpG71h7Wm9HLn6RP1c06ESTU1TQgKFn48nJ3RVsrS?=
 =?us-ascii?Q?ltLBWIA4mjs/njc9gf9ZliMIon4zkt8YK+KsImDFU6rNj5xxrK2UYt0mFWGd?=
 =?us-ascii?Q?nMiVlqFnf3afak9I0Pq1NrvBW0CKIyrddr24UtpjlNInkRUCvCGm2+4ffevB?=
 =?us-ascii?Q?DKPLWW3vNDoJiuua3HGJ0kyMQGIxAc0D5RpbI1blcKAZNPdwFfMHjUHZMmZW?=
 =?us-ascii?Q?lgc/pqCshXq2C99H+4/vynEIE6hJPTPHxorw/jZBSvoqH1Y67p7ke1irSdNW?=
 =?us-ascii?Q?8N/6MWbQEi7+RdazCLsLtxFA3f2oCHezKJJoAGUe6lwbtvxJszzVX1cu1/1J?=
 =?us-ascii?Q?WL3mf5i6WSm4sQYKcn+7uR+MFhKpgLq/P7hx39Iljd/B02iSqXCcHWE+m4FR?=
 =?us-ascii?Q?Hf4YKJVGD+YjpPsMzuWf4v8QPj7zl8epd9XVp6QJ6HH8TWJCY3sYA0XgKJFX?=
 =?us-ascii?Q?cywkcWX7Askh/2MwGbqva8dhIsjE4cxoS+YUK/cvjqML6A4/sgdtKybUyykM?=
 =?us-ascii?Q?mDS7pM2oT+vpE7jHGYPnM0dK0+zT7iDOlvnyn9cmRvB+2OmfJVW44/tgGDP6?=
 =?us-ascii?Q?/bwYzkCzmYJDn7lyLyfuAbE+EDIWSh2d1CfXAWK4O3t+RuapcjyWw4rc0eL+?=
 =?us-ascii?Q?tYvG+tdhDuJ2M1Wfi6gSJednAOYDnHy6wg1/CUHioTQSRO+2Q6YMhCd6IxKj?=
 =?us-ascii?Q?6FD/aeOPoSCBPdqt1P+KRm3+7IJimVzwE3MyHlz/mGeErBpogcqr6RhjcckD?=
 =?us-ascii?Q?ci2evlJCk5f+x8fG9iR0B7gNcKKKBrYlWXot6mbFgyVwGV3Qyxb2RvSLCHFh?=
 =?us-ascii?Q?g0KGT3hsc+dMLub3pNrTwhuqD63Oxl5rGJulCwrhjiSpSEdkDzLniz529X6s?=
 =?us-ascii?Q?9LZdK/bXdjYpO6kl8gp1G6ckBF9D6Xy3lTugWeEztiqDDrLQQqlAGGaDzKXv?=
 =?us-ascii?Q?u1LCppkdBIPNJD3CT0qrVIR5Baiymmp9SJfL8AQBg4bR5CRdwLOnN82Uua6D?=
 =?us-ascii?Q?m8vSqU92W7y1FUdrMtDRDQFhv8MyCk+PvGZ1R/J+4S+mVYWHBVLeGZhoVBrb?=
 =?us-ascii?Q?o+BDG/4Iq6g5s1wUp2QLYa6hSuqO9MkakpaSHn/QZW4nWE3N5Ac76/T5dIwr?=
 =?us-ascii?Q?dkeU0P4s5etztrbmSLfNCXXJD7M76iiugy8W5gNOGWhDcsX3iUJgsGWFT3ns?=
 =?us-ascii?Q?bpteDbeDaDe4nhReKrYxcTbhFwDIf3fE+AsV2EJV3t52QDxZT9jsiM6OEfaQ?=
 =?us-ascii?Q?r/trswmaKLO4tiPp7k6sc2eKEtGu69xkHVMR145aPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y7p6eU7aObNKxTHJRpxtkDRSJ1xkCi9/lW2ypVjzcdNybw4uEb5XRKQVszR8?=
 =?us-ascii?Q?okF0ueGhIva+biWccVQHB2i3Xc3mSegbGcklYxBNfDUpPAOacZt8tZMjklT8?=
 =?us-ascii?Q?aphchcrd6URRB4qoRwvEvO2lqUbzEciGqb2WOyqQflhxMcqDZJh6WIi6VGGx?=
 =?us-ascii?Q?noqD4eYwPuJ4DYKPBsxd57xwuErBHXcA76GqvW1mjFssDxRocIRBUwBGP2jK?=
 =?us-ascii?Q?C7tgnr7hOQ90VaS0H1hPOy5pdMwevdFCnbhWYJn/RAMaDWEWpg4ZUpTXNIwk?=
 =?us-ascii?Q?BKsB3SyRJ8SWzIA4BfF/g3Pv3QUibrPf+4efBFNTMyzcdaOIM65Oek3QqOgn?=
 =?us-ascii?Q?qg6XXXM3+EhxIEBeIOgOzGVliGjflTArOW+EDHqHAJDCtmcBmuChYEdXW4XQ?=
 =?us-ascii?Q?6t1uNhDhwV86k9EG/PantOL69s2l1wtIPbzImSmMl4BQkx/uhtAwWDVGD6yW?=
 =?us-ascii?Q?hqLnMxgh9Yy26cln+v5khzjvQvzUEuXk6j8IQF1TCFpUo5odgjP3SfI2LpgM?=
 =?us-ascii?Q?V0+zRyYPCzuPgxju870EhjqhsN6yx653u/5Wtr4nTaaVqADUyHGGnmr1v2t8?=
 =?us-ascii?Q?IA6sDXtTCxvnaJ2RXygSpnN6o9QSQok06+8orwVCL+fBt3XXnBWVMfwIZyCB?=
 =?us-ascii?Q?EMpCaFKtlwsw1rmordCYpuUxTAp6WrLmP7Q1fHPDF1xWwQGfjNQQntSIQTL6?=
 =?us-ascii?Q?Sr8LDYrAnkjRu7HwN1DtvITUvNuNBVnrYhioB25JhWHeGdlhl+T1KoufsMk7?=
 =?us-ascii?Q?k3+yMAZE+eFah1phyHchlB166joN1j1YAaI1/8iXKuP4xUebinWsXPWRSGLa?=
 =?us-ascii?Q?mP9tXTK+P2wZYmevSmZThNytKY6xCvpgYqzmh2ATc1NMeHIqjIgqHgGEIpLB?=
 =?us-ascii?Q?PG539sCUkdHsEr2+vPjLS6P0gXFqJJXKVptW3IstxS0rtcm/7DkFCJSwJhbq?=
 =?us-ascii?Q?/i8ytY18UFUUXS9JaAIRpGeNDhaKHmP2j5wXCKEO606EDanRKcNdlKDVs1+r?=
 =?us-ascii?Q?+xduer7gsnE5RTd7KG3A0LrzfWUnA4hD+2jDb1t+c3OS8B8q/im+5YPp1Dk+?=
 =?us-ascii?Q?iXZsS5xh4ffc3RPBHEtZx/nuVvmpDOc8/3zk7uwDEnckTrSpQ74qFUj1dzWf?=
 =?us-ascii?Q?DFiWkb01nL5APV+HmruwuFd5pGi6i4HHxKe6h8dM4pKv3UHjvJbcV3G//4ge?=
 =?us-ascii?Q?SO2o6K2H6q7yQcGPwysvBWNW0sFAAi+hLvZy4NMaHTmbVsXi3zpPhnm2eZfG?=
 =?us-ascii?Q?gke1zt4sjody2MOPaZ14fkCTMysXsVGSAzKVsZmIKl6mH+564YiQ6lSIlUPR?=
 =?us-ascii?Q?baeabRk3F8altvHV74oGx9ivx7NgwIqhV3Jdu4v+LMR8O2rOetd7rvqDA7N2?=
 =?us-ascii?Q?vLdVTu64PuVKeur0YexrglVRKbb/lKyD6ueoIu7kffad/bjyzpfyfE1WqqU5?=
 =?us-ascii?Q?YpoO/p6W3uNTXySMQnReAOkUNf8qNs04oigRabywhbPA+mE0hBVkwhxgdFi9?=
 =?us-ascii?Q?0ZhJSzF7Jck9smmZIKsqwKUcV4FgcfbdHUM0/Nfx6JhIzzsICNkvDfF7CQoM?=
 =?us-ascii?Q?7azv8dRSQCLL32/4DLQru6g2fzl4rI1lODqZE8xqQzRPD0Vxxiv7kv61rZAq?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234cbd4b-a293-4e0d-f8d9-08dced3ef9e9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 17:29:51.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbP1PTz0lsd3GOc50owvB6HGJlhhEEMmvgyyabZMD875uyc4oRKPYGyRoLw+d35+cX6c0ZIu+kntTT45SP9kFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7636

On Tue, Oct 15, 2024 at 10:24:57AM -0700, Florian Fainelli wrote:
> Vladimir reported the following warning with clang-16 and W=1:
> 
> warning: unused function 'txchk_readl' [-Wunused-function]
> BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'txchk_writel' [-Wunused-function]
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'tbuf_readl' [-Wunused-function]
> BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'tbuf_writel' [-Wunused-function]
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

I mean the warnings do say that the tbuf macros are unused too, yet you
only remove txchk? I did ask yesterday if that should also be deleted,
and with it the other unused transmit buffer macros?
https://lore.kernel.org/netdev/20241014174056.sxcgikf4hhw2olp7@skbuf/

> 
> The TXCHK block is not being accessed, remove the IO macros used to
> access this block. No functional impact.
> 
> Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 9332a9390f0d..05c83cb3871c 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -46,7 +46,6 @@ BCM_SYSPORT_IO_MACRO(umac, SYS_PORT_UMAC_OFFSET);
>  BCM_SYSPORT_IO_MACRO(gib, SYS_PORT_GIB_OFFSET);
>  BCM_SYSPORT_IO_MACRO(tdma, SYS_PORT_TDMA_OFFSET);
>  BCM_SYSPORT_IO_MACRO(rxchk, SYS_PORT_RXCHK_OFFSET);
> -BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
>  BCM_SYSPORT_IO_MACRO(rbuf, SYS_PORT_RBUF_OFFSET);
>  BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
>  BCM_SYSPORT_IO_MACRO(topctrl, SYS_PORT_TOPCTRL_OFFSET);
> -- 
> 2.43.0
>

