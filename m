Return-Path: <netdev+bounces-244950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 699BBCC3C50
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07B60318EDB2
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4CC343203;
	Tue, 16 Dec 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SKiiLB9t"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C911246332;
	Tue, 16 Dec 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896149; cv=fail; b=c8OTwME89g4cOujV+W7GpDM3MgTe1oqzXRe0MNdfMO9zi0gPPCQOh1RFCUE52a0DOTvvm0m+/dABCdnHvClk/bmtkVHohfKNJXZBZjJ+HhshVq3zpLD7cGNH51Iq5KX8yu8NIh8H/TW6R7D4qcGS4DL379788kY+D1W4+QBrDvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896149; c=relaxed/simple;
	bh=1PDZNog2A4gV5AT5HNVjA4A5FlJC+j7w59zKJM/+72U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SowjIiSFlUoLfLVJ6nHgEeH3Q6QNk1ZtUzYwUDbswaVk/odtHeax0Nvv8ab/h7ND5s5GBb9ugQzI/wYXeyhvU0pvJRJW5+cXkLQshaTsVLJc+EaR0IMyeO9qccrkQM8DQnAhXjH9mBQUfBocuVUFLi1wzwEGADIG+B7bvJwHChg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SKiiLB9t; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSuMaLKqRlDw1a2l1p0BelP9EDPB7obZjzD6EhF7BwlNxdUDAsZWBkcgHkel6/ld4xSzpx2Fh882QAO8EAzfdMOJvzWluuG1kbiA99Wo+WIwGxD9isWaewR+DvtJTt8gSPFUcmKAxX19J/btGukBjLixR53Z8k6UqNW+V1z56MGnokY7RCXPGtsGX1/dLWO1cLr2MhZ9GOz7mnL+3+btjq8Z3Bqwcl6Zgo3/48Bld5pZ6LwQQ5NIF2ylpSRfA0p3bBna4zELSHDjnBFoxYJJc+/+JK8U/OZa6YuhrAoIRxbP3skzTaX89RZLvUZqFAlFFQN4zmjDg6vN1Dh/jE7rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyB1m9AUoFyAxeM0O8mXIkJSDauPa3LsyNCkr//3bFc=;
 b=CW9BiLfLUpnSm5xn7TB2VX7qaxr1CjrYlIv9B++KevkBiT21Igt1k3poDd7Bga0kPY6OGikZl8OBM5z60uCouBW6EiqIBt5Qh5BVIHbpJewXLiYel1bkVxpq/jimaxxQ+d41onbQeS8yhSwjNNdl3zWiXFSiwZH2RHP4YmiXA6mlrccWbHX0bR1ruGIn+DVwcW7xyg22J8OcEXjAs/LTi/E3OyUKzPpsu3dvFvOTr10419Ogz7lcobpUK7foiRFiJBxoTWXB35rrPLyO6RmROHSbaMSfbTeI12SpU/PRgV4hJA4NjqsTWklrAdbiviJSSh5ZLDiTvgkqW1aV4tJeYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyB1m9AUoFyAxeM0O8mXIkJSDauPa3LsyNCkr//3bFc=;
 b=SKiiLB9txa6dEeIhxCtRvwcX/pjBUOQiIHveU0i6filU2zO8MYEPW5ZfKNIzpoG+OlKM23buIyFHEcvDak4DoHiXHN38STVOSeu7/Vp/POcHFKd9elld8XRwdH8mpnlVObU10vYCbjZoonEcOGhvFuCqIROLCzJvAi5syj5MDg9SPAzlndqO7HWWjclmtszUWircEu+rs8MFT+NE+SmH85nAA87yv9nKu8wdAWz0tBtAq6ShUwkf+1exNfccfi3KUR6hZxteMGum1kRrpBx7W5hpuvOpeCRRM6FjiXIZi42zGKYW/ArJUWBZsAkcs6i+aJYbQdYQQGLd8HhPKN58pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 14:42:18 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 14:42:18 +0000
Date: Tue, 16 Dec 2025 09:42:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: Re: [PATCH v2 0/4] s32g: Use a syscon for GPR
Message-ID: <aUFvvmDUai9QrhZ2@lizhi-Precision-Tower-5810>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
 <aUAvwRmIZBC0W6ql@lizhi-Precision-Tower-5810>
 <aUBUkuLf7NHtLSl1@stanley.mountain>
 <aUBha2/xiZsIF/o5@lizhi-Precision-Tower-5810>
 <aUBrV2_Iv4oTPkC4@stanley.mountain>
 <aUB4pFEwmMBzW52T@lizhi-Precision-Tower-5810>
 <aUEQkuzSZXFs5nqr@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUEQkuzSZXFs5nqr@stanley.mountain>
X-ClientProxiedBy: SJ0PR05CA0184.namprd05.prod.outlook.com
 (2603:10b6:a03:330::9) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS8PR04MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f5781c-3382-4a43-1726-08de3cb15002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RAVrC+xuh5CEg62Fw/O5NDDrsqvfmhzjxNgF3MJZFgGMCFNhhHV7NUYV4eTv?=
 =?us-ascii?Q?bmXDhrlEI5F9QCOQpLis8vNSRo1ynF8Xq+imdw8ypg0Rnj5e+lLIfPOvy/6v?=
 =?us-ascii?Q?VCBn4bSNpjlViOyqwSwQiRnczeSbdH/Q3z0MEc1UjSZnwvUMGNDnZJCrRzrY?=
 =?us-ascii?Q?UIamtr0Fknuy6KR/N8DldjkCfiwnfgD4vA7JiApmmY8TXGqTJ2OOI4IS7K7M?=
 =?us-ascii?Q?kXNCovtEghtosxu09vRViS0nsHSrgdTZfxE1LZJ6T3+NvPBydtrfFFX/NeHn?=
 =?us-ascii?Q?VlrbDhj/+OKTOoyT7Xm30hSB+cRov0RgHgR7tkRT/mBqvaBOekw3h4JElE9M?=
 =?us-ascii?Q?EF3qC/re38y+Q1akCH+f8FyfLxdzncF8dk0Q2vREs4OpNCExbiN3+NTmGs1y?=
 =?us-ascii?Q?DuXPE+ObYXABRLvJYp+BY3gXZZxMRGtLaxdYkIvlIwExTb/SZbdTX4erjb2b?=
 =?us-ascii?Q?ccc1VS6SUcxyyGFRLW2cMoAlt/KdMMaWPeXTYrSVL607+cxoWLmHE8YQNprh?=
 =?us-ascii?Q?3PD01g2OC08SAZvn+5om7sN69GpbsZ3WDErUOFwaLbOKUIymGERth37BYGa/?=
 =?us-ascii?Q?B/F0DNIzchFoLU+koG8+WB4O/2t4s5XXbtwjsGxPKnr5L7nVcgE5vBPx4uSX?=
 =?us-ascii?Q?DODRO5koLDI35UTg4ilmQvOP4xh9EXQOo31nxFVvpguJKhvmWhcL9zKCGto0?=
 =?us-ascii?Q?jTfLRqdn1Oc9oiU+k/l0QzN8RgS5Fpi6uxpB6p5s3JngdjIVvLCKvDbZZzhD?=
 =?us-ascii?Q?DaL7lVUoIXHIgEgVi5dFPY4XcpDZzKuyhRcv9oCpDpA9tGRJ+AH2uNyekl6Q?=
 =?us-ascii?Q?L9vaN52Yt2ru9nISg02o+FcOf9QtGpqLAQPUxkrHH0w0TjKK3mQN1+hvehTR?=
 =?us-ascii?Q?QT2GjqOSX/bB0T0evCKJJC8TLWAxISuCtl0ecwL9WQDV7UR+zXutnKgpO7QR?=
 =?us-ascii?Q?nZBPzwzQI/KKqpzxgUG5nW9YIbFWWBaOpwO8lwO2olqX5DB09wVhA+ODkWCK?=
 =?us-ascii?Q?yK1yeQRxIqCjzbJQerlz9MU1R6RsRjzmB58jCY34emATggCNJudQ3e56zdp9?=
 =?us-ascii?Q?X31zbJWHGxenfbHhpXowkcRv8xFFpaZp9zIYJoCpCOp8OmGZdmgAerH+4BeL?=
 =?us-ascii?Q?jh5A599J20Fj8DIVfOA+a2pSyQA1pguBt6lf99tiaefaS6Dk22xuUlyOEVJI?=
 =?us-ascii?Q?aen8LG8DWQ3salPf3R4YPkV2JSsZQrfQGlAnpSMoJDL0U8KthVADz2emMusm?=
 =?us-ascii?Q?2xPuS2BsvLz+K7Z3e/buQMN+/ADw949ag3RX4UKOf+l+ESKIgvABwrqIRR0E?=
 =?us-ascii?Q?W5auYIXlP91mcs/aWvEMw2+RGSiY5WWENWG4sWibYkUAxtHB7GCDmb1q9EDy?=
 =?us-ascii?Q?dB5Gqn3poMszUHIrhrX+SKpa5XPKuF1SYMQR7Tw1ZcVbNziIzJX1ZoTvqGuE?=
 =?us-ascii?Q?dE3vkTNXbuavyCt2cumL944GOQ7Z+36zjj9OVqjSZsBNVk0vLtWcnOis/Yj+?=
 =?us-ascii?Q?4CJdvr+7BqAMm6T7PSExqz+lPEg1eOjRa9ZJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iSzbRhwZkLTNQXhAO+HEohPEBih+sxm9Xrkst5M53RkWVaisFszXaGxJNOEp?=
 =?us-ascii?Q?An+cjMb9cx0U802KvCGpnfbMbxq7lQoK4LS+krO52USXRbpNxemog1Ecdp4y?=
 =?us-ascii?Q?VUk3BiubtiCO88N9/+MiimP6vJqnEwXmlKzlvfzBQz8edh9+hNk/i7qBomUf?=
 =?us-ascii?Q?NnMkmOm3C4hSNCFglLrK3wWDGFNMDiLIWyzhjHvvpAXD3TbDNtKoXo6alEdO?=
 =?us-ascii?Q?3llxXj0I3RHFkkxWYAa6OOGhHKQw8e2qAj+uhJMdZNZ4XJE4//pRWyqUv82W?=
 =?us-ascii?Q?TmkDCsvKDTGmLHKPuzJLniX4yCY9Q0kbMVdv2h0GBadbQ0LGs6pq5c1CG+1O?=
 =?us-ascii?Q?uCtqPcNPkYTXEAVoqOwg51EOWufHF7hKEoLO6xI9w/32qNP8xLJbJo9CTmtL?=
 =?us-ascii?Q?StJP823NfXSD5NbyK7R10OUCd/Nbt4+8CV0s8t5r+esScRerEImqGg9W010J?=
 =?us-ascii?Q?lAFP9flc1bhXJQIj/v0/AzOdQEu/sToJPVk3eVDFlr4CNLeI4+gAAcfWV3dp?=
 =?us-ascii?Q?IeYzpHxTq+zvgQlnAPod5EkB+b90DjPEdXU73w1dAhv/jU4GceuTPj1MLdGq?=
 =?us-ascii?Q?pV8UBKF18Dd2K5O4XpGUH+kSmeUbZ2ff/bsX9IuxDgA/GRETjF+yj+suoJzR?=
 =?us-ascii?Q?KdcK1qVUFINktkoejCC4Ll1eCfMcUlD2vHtNhhTBgONgCjZ0pu7wsq2fpfPR?=
 =?us-ascii?Q?KiQnDPmVLVoIfgzaSCg23MsGC5pvjuQOPrDy95kQ15gha700cNBxAwBd32PM?=
 =?us-ascii?Q?SopHt1nUXGzgno/+zG/2a+fnng5BXDU2PXwCJaKCKnrVQB+uYUl4V3Z8+Ejc?=
 =?us-ascii?Q?Wf9QZl8ct+bMoP4bhKy0XhOKeQSAzrVzBTgkgwVMhfUtGvnrDPZ8sS6gd8tr?=
 =?us-ascii?Q?bzqMlgUs9o1/FtWfHczPxFrAkxCbqHwTUSKQ6V5w2ZlNqQx6zNCGsv8d+gO+?=
 =?us-ascii?Q?Cczkd2iOh1zPmib9Npe5YeSrnKiDRf+Pf3asknmYI+Mzm9edUAADdWqwlLlx?=
 =?us-ascii?Q?tE3G7rtWUXlLcC2Tcl//835+LEm/M4mTXmZgyYhCh6ALdxHSdTvb4EeIl/4G?=
 =?us-ascii?Q?CjBEDywEd+Mo8UXVfgQh+fLo7s+/8FwzRsuTcXIave24E1jNwGAkEEc4bYWM?=
 =?us-ascii?Q?RQfKR/m3tZnNudjPdmm5HW8wo2YUY0JKjBy3XaIgh7M7+TlIqm6jYmHDvP0G?=
 =?us-ascii?Q?88F77UfZBizhHDvTirOrG+BudSEQZH4yvyYn5NK6i3nLrBmkTrOVs+sXGX3G?=
 =?us-ascii?Q?KCFzHYbTHtzW+ZCQulNvMrU6C4HjSf8HJF7th551WWrObUfg3/B3WlDMq+7U?=
 =?us-ascii?Q?5usgFH7jtR5zU7Mq8JxiAckjDvaUy7GppVIiwN9zGAMvclPS7+dduuA5FQh+?=
 =?us-ascii?Q?UI2oi4J8Nsp2aJWCNYdHcut2wlXix8Be6m1rSGSxHPapKwKJ7u7+q/h18lXG?=
 =?us-ascii?Q?uNzuVE5Ff3pQWZioXpkpPg43ufHikBXmp7x0bx39ByUGkLCUTgMl9X6B3kde?=
 =?us-ascii?Q?BA1E13Q1s9ggRcEkCF2MFtAqS/wZTbZVrY2z9fPfMCraDgaD6neXjcRK+QUB?=
 =?us-ascii?Q?nJMbgGNUPsCJmBW6Z7WDEEwAafF4EiRLxEuqgbSH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f5781c-3382-4a43-1726-08de3cb15002
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 14:42:18.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3pnHxrM2IEY7VV92XDVNYD6sVCaQydZvVvvlPeKfnUidBhU5336vuMrkW/gK37Ybto04P0fjUM1TMlsmC+GNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7590

On Tue, Dec 16, 2025 at 10:56:02AM +0300, Dan Carpenter wrote:
> On Mon, Dec 15, 2025 at 04:07:48PM -0500, Frank Li wrote:
> > On Mon, Dec 15, 2025 at 11:11:03PM +0300, Dan Carpenter wrote:
> > > On Mon, Dec 15, 2025 at 02:28:43PM -0500, Frank Li wrote:
> > > > On Mon, Dec 15, 2025 at 09:33:54PM +0300, Dan Carpenter wrote:
> > > > > On Mon, Dec 15, 2025 at 10:56:49AM -0500, Frank Li wrote:
> > > > > > On Mon, Dec 15, 2025 at 05:41:43PM +0300, Dan Carpenter wrote:
> > > > > > > The s32g devices have a GPR register region which holds a number of
> > > > > > > miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
> > > > > > > anything from there and we just add a line to the device tree to
> > > > > > > access that GMAC_0_CTRL_STS register:
> > > > > > >
> > > > > > >                         reg = <0x4033c000 0x2000>, /* gmac IP */
> > > > > > >                               <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > > > > > >
> > > > > > > We still have to maintain backwards compatibility to this format,
> > > > > > > of course, but it would be better to access these through a syscon.
> > > > > > > First of all, putting all the registers together is more organized
> > > > > > > and shows how the hardware actually is implemented.  Secondly, in
> > > > > > > some versions of this chipset those registers can only be accessed
> > > > > > > via SCMI, if the registers aren't grouped together each driver will
> > > > > > > have to create a whole lot of if then statements to access it via
> > > > > > > IOMEM or via SCMI,
> > > > > >
> > > > > > Does SCMI work as regmap? syscon look likes simple, but missed abstract
> > > > > > in overall.
> > > > > >
> > > > >
> > > > > The SCMI part of this is pretty complicated and needs discussion.  It
> > > > > might be that it requires a vendor extension.  Right now, the out of
> > > > > tree code uses a nvmem vendor extension but that probably won't get
> > > > > merged upstream.
> > > > >
> > > > > But in theory, it's fairly simple, you can write a regmap driver and
> > > > > register it as a syscon and everything that was accessing nxp,phy-sel
> > > > > accesses the same register but over SCMI.
> > > >
> > > > nxp,phy-sel is not standard API. Driver access raw register value. such
> > > > as write 1 to offset 0x100.
> > > >
> > > > After change to SCMI, which may mapped to difference command. Even change
> > > > to other SOC, value and offset also need be changed. It is not standilzed
> > > > as what you expected.
> > >
> > > We're writing to an offset in a syscon.  Right now the device tree
> > > says that the syscon is an MMIO syscon.  But for SCMI devices we
> > > would point the phandle to a custom syscon.  The phandle and the offset
> > > would stay the same, but how the syscon is implemented would change.
> >
> > Your SCMI syscon driver will convert some private hard code to some
> > function, such previous example's '1' as SEL_RGMII. It is hard maintained
> > in long term.
> >
>
> No, there isn't any conversion needed.  It's exactly the same as writing
> to the register except it goes through SCMI.
>
> > >
> > > >
> > > > >
> > > > > > You still use regmap by use MMIO. /* GMAC_0_CTRL_STS */
> > > > > >
> > > > > > regmap = devm_regmap_init_mmio(dev, sts_offset, &regmap_config);
> > > > > >
> > > > >
> > > > > You can use have an MMIO syscon, or you can create a custom driver
> > > > > and register it as a syscon using of_syscon_register_regmap().
> > > >
> > > > My means is that it is not necessary to create nxp,phy-sel, especially
> > > > there already have <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > > >
> > >
> > > Right now the out of tree dwmac-s32cc.c driver does something like
> > > this:
> > >
> > >     89          if (gmac->use_nvmem) {
> > >     90                  ret = write_nvmem_cell(gmac->dev, "gmac_phy_intf_sel", intf_sel);
> > >     91                  if (ret)
> > >     92                          return ret;
> > >     93          } else {
> > >     94                  writel(intf_sel, gmac->ctrl_sts);
> > >     95          }
> > >
> > > Which is quite complicated, but with a syscon, then it's just:
> > >
> > > 	regmap_write(gmac->sts_regmap, gmac->sts_offset, S32_PHY_INTF_SEL_RGMII);
> > >
> > > Even without SCMI, the hardware has all these registers grouped together
> > > it just feels cleaner to group them together in the device tree as well.
> >
> > Why not implement standard phy interface,
> > phy_set_mode_ext(PHY_MODE_ETHERNET, RGMII);
> >
> > For example:  drivers/pci/controller/dwc/pci-imx6.c
> >
> > In legency platform, it use syscon to set some registers. It becomes mess
> > when more platform added.  And it becomes hard to convert because avoid
> > break compatibltiy now.
> >
> > It doesn't become worse since new platforms switched to use standard
> > inteface, (phy, reset ...).
> >
>
> This happens below that layer, this is just saying where the registers
> are found.  The GMAC_0_CTRL_STS is just one register in the GPR region,
> most of the others are unrelated to PHY.

The other register should work as other function's providor with mfd.

Frank

>
> regards,
> dan carpenter
>

