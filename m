Return-Path: <netdev+bounces-213380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95732B24CC1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B923B5757
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E6309DA9;
	Wed, 13 Aug 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XoMFmtt/"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B332DEA7D;
	Wed, 13 Aug 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096960; cv=fail; b=NQ59pxlvbtij6uZvQI/KRbVdBlGVwBP0izfQCSpMiVNsLTDnseFyfEDlVLpEzRNiUakB53kVU3m5S/aLT6Am6uJ4K8+KYtRVz/fo/FGMjE3cX9R2o9W3xQ/LSzVvtGU2c63WkXBrHtqoFjBej6xs1FvRufauXYzR0yAM1ihSeko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096960; c=relaxed/simple;
	bh=gEd+DrsXX6xaKKIdTnH0zz2kqyr59RKcqH7yDKKH/v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rBn7TBHuPK7l8M3JMtFeyq+ZJm+lX+OioTo41Md5Xy8rheVVqK1ABP+23rQFgolBOB6quHYOCNCNKrX5x9yGJmQEFyMk5fnoBM3knCqQ2UBymaehhupXmndLlryNDiMibqMNV0A6ZWJgdEMSFDqvNrtSoDILBNIR1wPMSVEZ+/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XoMFmtt/; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYcflgmmwIAmUUM8RbipU0G2NneTT+aWthGF48Vy3Ss+dBx4fs2Shdr6xhhnyixtPHXDyW/Hj/9tMEj5UxRM+bwt27arGaPwG+9CLX4CbFxCHg5ZaK0moac68cyClhXP0NKEh8s0aCDzTChoZ/13sdR8kF59Ynu+kXsqtu6LAT/x+CRRJGf7nqN9ugXlAjpCXjHIyQs8s3UrwlOGi8JAzMSdXcK60jV/hWQ0I2nGn4Ky+kJBuCHT5lAEwOWBMa1dWpNUwWcQ0j39Xafp0/eisCX4Yyms7XdMngP0fgy3CigaypM39Tp2CPyGIEXxmWiHWWXOMb8KPKAFUIIoxg7qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwMdOgOOQ+t+279t5VlHOngljEeNlSXVlgZWzOwkXpU=;
 b=Rs1lbuTE+rvO5UoSwPAjKV53fC+FvBd/pl8kxEPNKKd000EiPrskBdX1MW4m5+p92cCq3VQcjDGS32O3SpsVY0zvMUlYXOsnskCLJs9lSX4UbTT2lHeUuPfMID84ddgXatUREqdPFIgjjE443FmSkepS0Fcwvtcevt5QMnTVJOzrUYOA8+ER0IqZCMY3YHIiy+IF/5h6E9nhUZ7sqhNBULFZvU4M71L/ybEorf2if+c12xBMCWeq762OeV+hJWxOgiP6kNZ5oPSSw1l0nhz/fH0YdKonFp3hGU55KougxtBzZE0uEcuUAiYNIlmTzVi1y+VWHfxO+bGf7W0Abz5VEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwMdOgOOQ+t+279t5VlHOngljEeNlSXVlgZWzOwkXpU=;
 b=XoMFmtt/LkHW2V0AT5LkdL3AizSUY3pkDsKAL407wJrsgAAhX2m79Ka6kM9RMUDWNFwBII7gg3OZvgICPI4suHaNjRCFm7/Ms7Pzyvh4xJZyimQnVmiDBCBUcxq2UVsyLnWbSdubFpCuR8rGs4pXcQxl8cnkVyayveVEkxoyLtxAytp6OmVrzwVu6Bp5VLFhCn6kEgsJzi2GXirS41/nK4zMJCAm/tOPGlF0BNxAdp3e7tmyuDbqlBMJeRrZ2X0aKhpB0Fagb0GgZUciCfSZQ28mZW1+hhWd6BjbzTxEkO0+pmX+XvWwiFzNEDApB9LaBIi3JwfaMDYM70y8vQspPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7312.eurprd04.prod.outlook.com (2603:10a6:800:1a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Wed, 13 Aug
 2025 14:55:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 14:55:53 +0000
Date: Wed, 13 Aug 2025 10:55:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 net-next 13/15] net: enetc: add PTP synchronization
 support for ENETC v4
Message-ID: <aJynbJt7FFTfOKml@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-14-wei.fang@nxp.com>
 <aJtkpFbFTnmO1rbz@lizhi-Precision-Tower-5810>
 <PAXPR04MB85104E9C3BFAAD7FC566AF7F882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85104E9C3BFAAD7FC566AF7F882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: f20db4db-6458-4d67-22bd-08ddda797fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XVdc3ubFuanLG0ioEfFDwzwIv4WKaW8XX1Rp7c0S3R//cVHkfrrSTQKtgGWV?=
 =?us-ascii?Q?AJXHc46S7ZhqXcBUcOAAch/zXHCebgwFR2/FbUt9OVpVfSCoQcSoZNU/CMWo?=
 =?us-ascii?Q?b6pdTUaqLH/Ylu1cmE8mMcCoAbJjb2j4Kj7LdTUU0Xg6gp5GC+pi68QxFQ3a?=
 =?us-ascii?Q?urckn0FO/hTT25jpBCIGbNM9EF+udiX1+XIKiI+vBQBzNzYRUyx3OG6ZPq4I?=
 =?us-ascii?Q?98Bg5QK3qMgHSinUjNih/K6Eagr2dy2/Zd+++As/gttW/3uo80TLROUKdop5?=
 =?us-ascii?Q?zhJJYlD6hm29MxbZC2P4hLan4uqnBh4W2V4WdW2PZVzd3x4zaR85bzj5N3Yf?=
 =?us-ascii?Q?moXZrBc/g9fb+J223zi5zOQqlf8d6gyGzl84p+/Uyqn9Afrn4pPMQ2gVKVD3?=
 =?us-ascii?Q?BgcrLh0aCK0JPdUtWubHFwtztNDQHnagC3EjfxW1JJtQliDVtbUFwQ709jJg?=
 =?us-ascii?Q?Eiq62d82a722bp/lMJBRe8heg1yiV9HgAu554DGymUx09bORvdUasrlcaRjC?=
 =?us-ascii?Q?bZvzJik7+virHNS0Iszn0kD1jrtpUgjd9RzfdF73A38o7Wvv3Y4/vETZwaWw?=
 =?us-ascii?Q?I3lg4/04bwfpGxmpAd5jTfp4kNxS1XooAVP/oht1mxO2bTS5YXTjIUuD44ys?=
 =?us-ascii?Q?39kXHzRNWZAZ+ab+h/Hy7L1G+6/QBm0faEvxmYg5VbB2w+XFph9FlVKN/Sj0?=
 =?us-ascii?Q?GJWw/c5BZjAGzZMiEORpooh2jOoa4C5NZrBk7GsN8gcjL0oZ3BL1y06MFclj?=
 =?us-ascii?Q?s9jhmTLuFw+bOI3NgdOKiuQfRethQpLbRO2fgeoPkNNG4rawgUEUy6J3Q2z5?=
 =?us-ascii?Q?n6UM30C5yqySEuMNxpoiO4Lg9IAuZ7s95NZ7UrEZHJ6+4Z7yjRS5SxPYUDoG?=
 =?us-ascii?Q?vkJdZTGHHJyQM3E7o2YzRxdtWf4mzX5dxIh1iV+pQRww2JUQRQnr8Mi1kWRc?=
 =?us-ascii?Q?+OB5Gi0RVCn6XmIb9DrrRLOvivdk19AjNF+PW2P4Pcb0wIJLuM+kkF6TpFb4?=
 =?us-ascii?Q?U4Apm7ccRAtppyFygwoo/Gxr9T/CN+IAK6jSpEQ5qcICmjuHiuXQYkGGYCvk?=
 =?us-ascii?Q?+u945ry+GWC6CYqSgHYrPDG0HivXvMw4MBiTYoNngT+wjLA4TpMBCtwXZXw5?=
 =?us-ascii?Q?5rhFq5+mOBjMlTld09c38Y9Eu43vhrUvSymOykSnXWtU2lRM1si/wPpiLxw9?=
 =?us-ascii?Q?01vLxr6yyvePZfzSC+cIpUHWkOQLsHb/q8wPsB49kjprOFPbmvH1+Xrz2t4m?=
 =?us-ascii?Q?ErBSDgRdjyHOuIM5vPX7h1qIeP/nwGZBtpr5JkgqGQ/rvhcHFgaOoWwXBMKc?=
 =?us-ascii?Q?oySEbeI68pyhgqw3qAQnZBm1qz0+7Lt0ZCHv16IY+kcbYnosLVQ8UjP9njmP?=
 =?us-ascii?Q?A/aHcxEQsD4Tf/VqNUogNdAyjW0eBQex7K8BHwaKSYHkH6M4xgOPha2itSzG?=
 =?us-ascii?Q?wUWjYKuM3ryG9o3/RBuLmFxZhREdUf+DQ2o+kHqHnssOitab7gki/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/O7kwSnWCFq94HpxGETGGbgEEMcmjBOBa3+pKdu6PFuo3qgbuTkuCvwUJGyi?=
 =?us-ascii?Q?x8+ESi5sUlATIuKHpBP93rANQ5ITYA4IT6MU2tjLLC1gamvGThBf4NXTtfpD?=
 =?us-ascii?Q?yYlYDw9LsQgCndpniUbMZYCW7WNF1/yHOdeonm3VTwFv/g4gDEyez0hvCs3U?=
 =?us-ascii?Q?3mA5VdiDFSaLWSzOjO7iPcurDgvRztBr0khYb2mbVEj5Ey3APld1/rxs0DEP?=
 =?us-ascii?Q?Pzd9uTHM0fA2eguJAvQhZYdSoDMxXaT2PGAKB8aMBvBjAKMp8cAs/qaGXA9j?=
 =?us-ascii?Q?4hK0FaNDLvs045TuQBmgcwUi3c/eS6C6Ax8QpkkQpcbVCJKU2bHCoWGiY8/E?=
 =?us-ascii?Q?phmsQoRwBBFeVU92LBwWvmkDMuKsTqnobKjgYCjxIp52nLvdtUgn3124U5GI?=
 =?us-ascii?Q?HN5QYltjBOYItXjRCRi9CuXNetF/zVvsu1nPexwtvZILnm5DV+uKhUlCBKTj?=
 =?us-ascii?Q?iyq0b3rO64XjrdhqETuReErCyRdOlp0QjMBLC/M6c0KqZiRyUM2rysh1l6zA?=
 =?us-ascii?Q?Q2LrxGYL/FJiOgK7BEJ5Fg5cYJCZaHtNgEZtZbGiI24oxwdJXAzuSFdhbxhQ?=
 =?us-ascii?Q?Xwk6l1CCThCoItHSpvcg+OUShsNiBrCy6bkfXKd0KryZxx6DSdMaiqL19gqZ?=
 =?us-ascii?Q?AfTBE2hYmRM1+K27QhJuUX56stgV47U4JrkK+nOOQLxaLxfNlNCfW+YBPlzL?=
 =?us-ascii?Q?IAjZPKl0bmYutCRRaVUSK5xQGfZZZPiu/fhLkP8A20+5bd0MYvLju0ILiWcE?=
 =?us-ascii?Q?2rvtEHPnQ/amCWYFVye19bp4oFKc85uDn2ezmrpHMlIfWIn+dGjTtg3K+vwo?=
 =?us-ascii?Q?JBP/GFnLPn+ffmhLRhFrgaBEvffVaXm7ETgBPY89/KihnJeE8uWGLlCddSqJ?=
 =?us-ascii?Q?FUaWujfYaxkm7UUhWCUvq/0J/yef69Yb501Z3lCSLx7l+1ZDTesQM2AqKIoK?=
 =?us-ascii?Q?vWKlNNPd3sy+jShzg75x6fDOdksttSo0II/pCXUV1kgkf9U3Cdr5g0q/vhay?=
 =?us-ascii?Q?3ZbXtCgGI6eNy0+KouQN2rurKi0UnuXIYLZz2UcKYvFtr1mONE54r1S7/HK2?=
 =?us-ascii?Q?ahudEA1+4xdU7uhRWZlmdTjomRJ13q639g2Wmcd7ZmwY9L275fHKG3gx9Q/t?=
 =?us-ascii?Q?iy7OE05siq0ASF2LiFevxomRjzDbIuBhw+TC78006CN8HydtYAmCwynh2wBp?=
 =?us-ascii?Q?rt0us9PtKQFrRZ1xcy+eck0pnQYxuuuV0maB/phqAfm7sNX+Qs4CBSHU3i9R?=
 =?us-ascii?Q?oFh/jC7MgJGZ1GPt60Dqp68OruRuyCyX+iUOAqmiXnpQgd26a4PxTBIolSjj?=
 =?us-ascii?Q?92ITvO20gWu9GP+SE539UZH2p9qEUg7OgurpX0VeN0/gc4KpCs+56qzLO1K/?=
 =?us-ascii?Q?Xrh9dXagNitT1ku+F1ps0J5JPWsQRW0pk3n8r47kcgjZQ5pujGV8adZcmfvE?=
 =?us-ascii?Q?B63mLsKO7ZZ/uCtqnNN6rEJMTR//Ts/UhqqAXws2caiLucbvO+n/pPL4sIP2?=
 =?us-ascii?Q?exdYwRAb+ch8j3SEoCGEHMiGjEbVM/o1Pr5PqfCyxnayf8com/GXRAjfRqVV?=
 =?us-ascii?Q?CihLhACV31b5u1SfiSUtqKd6hiLeFZU83eO0CNDK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20db4db-6458-4d67-22bd-08ddda797fe3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:55:53.0264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS0UGTugPiFDLEh0b7Bj48iE0bp+HUjCrHtKRfUnic/poYP4YABPqaUvjqvK4NnaSq9vvIRcm31qiQccic5IjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7312

On Wed, Aug 13, 2025 at 02:17:46AM +0000, Wei Fang wrote:
> > On Tue, Aug 12, 2025 at 05:46:32PM +0800, Wei Fang wrote:
> > > Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
> > > mainly as follows.
> > >
> > > 1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
> > > different from LS1028A. Therefore, enetc_get_ts_info() has been modified
> > > appropriately to be compatible with ENETC v1 and v4.
> > >
> > > 2. The hardware of ENETC v4 does not support "dma-coherent", therefore,
> > > to support PTP one-step, the PTP sync packets must be modified before
> > > calling dma_map_single() to map the DMA cache of the packets. Otherwise,
> > > the modification is invalid, the originTimestamp and correction fields
> > > of the sent packets will still be the values before the modification.
> >
> > In patch, I have not find dma_map_single(), is it in enetc_map_tx_buffs()?
> >
>
> Yes, see below code snippet.
>
> static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
> {
> 	[...]
> 	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> 		do_onestep_tstamp = true;
> 		tstamp = enetc_update_ptp_sync_msg(priv, skb, csum_offload);
> 	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> 		do_twostep_tstamp = true;
> 	}
>
> 	i = tx_ring->next_to_use;
> 	txbd = ENETC_TXBD(*tx_ring, i);
> 	prefetchw(txbd);
>
> 	dma = dma_map_single(tx_ring->dev, skb->data, len, DMA_TO_DEVICE);
> 	if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
> 		goto dma_err;
>
> 	temp_bd.addr = cpu_to_le64(dma);
> 	temp_bd.buf_len = cpu_to_le16(len);
> 	[...]
> }
>
> > This move should be fix, even dma-coherent, it also should be before
> > dma_map_single().  just hardware dma-coherent hidden the problem.
> >
>
> There are no visible issues with enetc v1, if it is considered a fix, it is only
> a logical fix and have no effect on v1 . So this patch is fine to target to
> net-next tree.

I agree, is below more clear?

Move sync package content modification before dma_map_single() to follow
correct DMA usage process, even though the previous sequence worked due
to hardware DMA-coherence support.

Frank

>
> > >
> > > 3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
> > > register offset, but also some register fields. Therefore, two helper
> > > functions are added, enetc_set_one_step_ts() for ENETC v1 and
> > > enetc4_set_one_step_ts() for ENETC v4.
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > >
> > > ---
> > > v2 changes:
> > > 1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
> > > errors.
> > > 2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
> > > Timer.
> > > v3 changes:
> > > 1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
> > > 2. Change "nxp,netc-timer" to "ptp-timer"
> > > ---
> > >  drivers/net/ethernet/freescale/enetc/enetc.c  | 55 +++++++----
> > >  drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
> > >  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
> > >  .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
> > >  .../ethernet/freescale/enetc/enetc_ethtool.c  | 92 ++++++++++++++++---
> > >  5 files changed, 135 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > index 4325eb3d9481..6dbc9cc811a0 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > @@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct
> > enetc_bdr *tx_ring, int count, int i)
> > >  	}
> > >  }
> > >
> > > +static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
> > > +{
> > > +	u32 val = ENETC_PM0_SINGLE_STEP_EN;
> > > +
> > > +	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
> > > +	if (udp)
> > > +		val |= ENETC_PM0_SINGLE_STEP_CH;
> > > +
> > > +	/* The "Correction" field of a packet is updated based on the
> > > +	 * current time and the timestamp provided
> > > +	 */
> > > +	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
> > > +}
> > > +
> > > +static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
> > > +{
> > > +	u32 val = PM_SINGLE_STEP_EN;
> > > +
> > > +	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
> > > +	if (udp)
> > > +		val |= PM_SINGLE_STEP_CH;
> > > +
> > > +	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
> > > +}
> > > +
> > >  static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> > >  				     struct sk_buff *skb)
> > >  {
> > > @@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct
> > enetc_ndev_priv *priv,
> > >  	u32 lo, hi, nsec;
> > >  	u8 *data;
> > >  	u64 sec;
> > > -	u32 val;
> > >
> > >  	lo = enetc_rd_hot(hw, ENETC_SICTR0);
> > >  	hi = enetc_rd_hot(hw, ENETC_SICTR1);
> > > @@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct
> > enetc_ndev_priv *priv,
> > >  	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
> > >
> > >  	/* Configure single-step register */
> > > -	val = ENETC_PM0_SINGLE_STEP_EN;
> > > -	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> > > -	if (enetc_cb->udp)
> > > -		val |= ENETC_PM0_SINGLE_STEP_CH;
> > > -
> > > -	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> > > +	if (is_enetc_rev1(si))
> > > +		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
> > > +	else
> > > +		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
> > >
> > >  	return lo & ENETC_TXBD_TSTAMP;
> > >  }
> > > @@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> > >  	unsigned int f;
> > >  	dma_addr_t dma;
> > >  	u8 flags = 0;
> > > +	u32 tstamp;
> > >
> > >  	enetc_clear_tx_bd(&temp_bd);
> > >  	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> > > @@ -327,6 +350,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> > >  		}
> > >  	}
> > >
> > > +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> > > +		do_onestep_tstamp = true;
> > > +		tstamp = enetc_update_ptp_sync_msg(priv, skb);
> > > +	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> > > +		do_twostep_tstamp = true;
> > > +	}
> > > +
> > >  	i = tx_ring->next_to_use;
> > >  	txbd = ENETC_TXBD(*tx_ring, i);
> > >  	prefetchw(txbd);
> > > @@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> > >  	count++;
> > >
> > >  	do_vlan = skb_vlan_tag_present(skb);
> > > -	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> > > -		do_onestep_tstamp = true;
> > > -	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
> > > -		do_twostep_tstamp = true;
> > > -
> > >  	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
> > >  	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
> > >  	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
> > > @@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> > >  		}
> > >
> > >  		if (do_onestep_tstamp) {
> > > -			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
> > > -
> > >  			/* Configure extension BD */
> > >  			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
> > >  			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
> > > @@ -3314,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
> > >  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > >  	int err, new_offloads = priv->active_offloads;
> > >
> > > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> > >  		return -EOPNOTSUPP;
> > >
> > >  	switch (config->tx_type) {
> > > @@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
> > >  {
> > >  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > >
> > > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> > >  		return -EOPNOTSUPP;
> > >
> > >  	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > index c65aa7b88122..815afdc2ec23 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > @@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct
> > enetc_si *si, int size,
> > >  void enetc_reset_ptcmsdur(struct enetc_hw *hw);
> > >  void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
> > >
> > > +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
> > > +{
> > > +	if (is_enetc_rev1(si))
> > > +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> > > +
> > > +	return IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER);
> > > +}
> > > +
> > >  #ifdef CONFIG_FSL_ENETC_QOS
> > >  int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
> > >  int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > > index aa25b445d301..a8113c9057eb 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > > @@ -171,6 +171,12 @@
> > >  /* Port MAC 0/1 Pause Quanta Threshold Register */
> > >  #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
> > >
> > > +#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
> > > +#define  PM_SINGLE_STEP_CH		BIT(6)
> > > +#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
> > > +#define   PM_SINGLE_STEP_OFFSET_SET(o)
> > FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
> > > +#define  PM_SINGLE_STEP_EN		BIT(31)
> > > +
> > >  /* Port MAC 0 Interface Mode Control Register */
> > >  #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
> > >  #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > index b3dc1afeefd1..107f59169e67 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > @@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops
> > = {
> > >  	.ndo_set_features	= enetc4_pf_set_features,
> > >  	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
> > >  	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
> > > +	.ndo_eth_ioctl		= enetc_ioctl,
> > > +	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
> > > +	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
> > >  };
> > >
> > >  static struct phylink_pcs *
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > > index 961e76cd8489..b6014b1069de 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > > @@ -2,8 +2,11 @@
> > >  /* Copyright 2017-2019 NXP */
> > >
> > >  #include <linux/ethtool_netlink.h>
> > > +#include <linux/fsl/netc_global.h>
> > >  #include <linux/net_tstamp.h>
> > >  #include <linux/module.h>
> > > +#include <linux/of.h>
> > > +
> > >  #include "enetc.h"
> > >
> > >  static const u32 enetc_si_regs[] = {
> > > @@ -877,23 +880,49 @@ static int enetc_set_coalesce(struct net_device
> > *ndev,
> > >  	return 0;
> > >  }
> > >
> > > -static int enetc_get_ts_info(struct net_device *ndev,
> > > -			     struct kernel_ethtool_ts_info *info)
> > > +static struct pci_dev *enetc4_get_default_timer_pdev(struct enetc_si *si)
> > >  {
> > > -	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > > -	int *phc_idx;
> > > -
> > > -	phc_idx = symbol_get(enetc_phc_index);
> > > -	if (phc_idx) {
> > > -		info->phc_index = *phc_idx;
> > > -		symbol_put(enetc_phc_index);
> > > +	struct pci_bus *bus = si->pdev->bus;
> > > +	int domain = pci_domain_nr(bus);
> > > +	int bus_num = bus->number;
> > > +	int devfn;
> > > +
> > > +	switch (si->revision) {
> > > +	case ENETC_REV_4_1:
> > > +		devfn = PCI_DEVFN(24, 0);
> > > +		break;
> > > +	default:
> > > +		return NULL;
> > >  	}
> > >
> > > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
> > > -		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
> > > +	return pci_dev_get(pci_get_domain_bus_and_slot(domain, bus_num,
> > devfn));
> > > +}
> > >
> > > -		return 0;
> > > -	}
> > > +static struct pci_dev *enetc4_get_timer_pdev(struct enetc_si *si)
> > > +{
> > > +	struct device_node *np = si->pdev->dev.of_node;
> > > +	struct fwnode_handle *timer_fwnode;
> > > +	struct device_node *timer_np;
> > > +
> > > +	if (!np)
> > > +		return enetc4_get_default_timer_pdev(si);
> > > +
> > > +	timer_np = of_parse_phandle(np, "ptp-timer", 0);
> > > +	if (!timer_np)
> > > +		return enetc4_get_default_timer_pdev(si);
> > > +
> > > +	timer_fwnode = of_fwnode_handle(timer_np);
> > > +	of_node_put(timer_np);
> > > +	if (!timer_fwnode)
> > > +		return NULL;
> > > +
> > > +	return pci_dev_get(to_pci_dev(timer_fwnode->dev));
> > > +}
> > > +
> > > +static void enetc_get_ts_generic_info(struct net_device *ndev,
> > > +				      struct kernel_ethtool_ts_info *info)
> > > +{
> > > +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > >
> > >  	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
> > >  				SOF_TIMESTAMPING_RX_HARDWARE |
> > > @@ -908,6 +937,42 @@ static int enetc_get_ts_info(struct net_device *ndev,
> > >
> > >  	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
> > >  			   (1 << HWTSTAMP_FILTER_ALL);
> > > +}
> > > +
> > > +static int enetc_get_ts_info(struct net_device *ndev,
> > > +			     struct kernel_ethtool_ts_info *info)
> > > +{
> > > +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > > +	struct enetc_si *si = priv->si;
> > > +	struct pci_dev *timer_pdev;
> > > +	int *phc_idx;
> > > +
> > > +	if (!enetc_ptp_clock_is_enabled(si))
> > > +		goto timestamp_tx_sw;
> > > +
> > > +	if (is_enetc_rev1(si)) {
> > > +		phc_idx = symbol_get(enetc_phc_index);
> > > +		if (phc_idx) {
> > > +			info->phc_index = *phc_idx;
> > > +			symbol_put(enetc_phc_index);
> > > +		}
> > > +	} else {
> > > +		timer_pdev = enetc4_get_timer_pdev(si);
> > > +		if (!timer_pdev)
> > > +			goto timestamp_tx_sw;
> > > +
> > > +		info->phc_index = netc_timer_get_phc_index(timer_pdev);
> > > +		pci_dev_put(timer_pdev);
> > > +		if (info->phc_index < 0)
> > > +			goto timestamp_tx_sw;
> > > +	}
> > > +
> > > +	enetc_get_ts_generic_info(ndev, info);
> > > +
> > > +	return 0;
> > > +
> > > +timestamp_tx_sw:
> > > +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
> > >
> > >  	return 0;
> > >  }
> > > @@ -1296,6 +1361,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
> > >  	.get_rxfh = enetc_get_rxfh,
> > >  	.set_rxfh = enetc_set_rxfh,
> > >  	.get_rxfh_fields = enetc_get_rxfh_fields,
> > > +	.get_ts_info = enetc_get_ts_info,
> > >  };
> > >
> > >  void enetc_set_ethtool_ops(struct net_device *ndev)
> > > --
> > > 2.34.1
> > >

