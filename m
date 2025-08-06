Return-Path: <netdev+bounces-211918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22366B1C789
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 16:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1125C7A2A0D
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9894928A71E;
	Wed,  6 Aug 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FGqSUVS/"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20A23CB;
	Wed,  6 Aug 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489972; cv=fail; b=BygkRFlY1XiGqeTeXu8VzPOR5y75bP00m7t1OGgYucH8V9kyVX7/KW9u4Rx9dkFu5oXP7AZE6yVjUK/fo3/qYkuhS4oZWUY3UtDb5tVp/HGjw7guG8NTtfQb9+sDKjJYePqPR4bXiMPXbID1HFIT3G4Xh4elu5ElxBh6/J0KJSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489972; c=relaxed/simple;
	bh=a21syyz0SXD5wXc9lfeHxkm5P9P7A/BkM0Tp6JHYF9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JVPx1vE1OHbCK2zLOKZLYQQoZ37A5J/CU9JdlCgSIkyasc5CbF+XJgHRtFwnZ8wJX/v3U2nS+ytdZdwg65Vm2599yv6bdGbeSEVK5Vw1eqF/b5iukZaik1Jmfgrvhha41q9Cojo/5FUaxGfopseIq2vSFQeNTHn7EMjPkmmWxC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FGqSUVS/; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbkXDuSA5E1GzzfsfhbNkxZ4OwU/7S5nRBLHu3kfY6TaHuSI7H7CelsmmcQ7sPldvL+0EJLcIrIEucS/H1A+l+JMMwlNb2v1OBoM7YqzoaIiSpnb2Khp83et0aY2PEquNokfUs0DCRmq7CsTuQC8cP1nWSBpp6TDQ0k1Sk4FFBzxm9hjPUMxXW3CT87Lmvd5OEzA1jDDb2Mdq8/BboN6Na57qRnEmDFwVQ7FXyEd+ls2Hhll19FS8wXKaKlH1Y0dxQncRKQOFStaVYGfz8iHBQKLvni8jM+4crVciJyW8hx0ALT3NIliusmdzmD8ZHmTfdK7WmHqb/ynhJCM8qrBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2oMegg6FdjdCGsJzrtEe3eRTP6aHczC3fVhucY9wv4=;
 b=ftGNJKdOpBAw7kYd6kKyh+PoFh2uQitBpb4HQQDTrA4HlbpXaz2gSi/+si8j8X0YGM4xPB8pKOir4ltO8xGs2ftOGqbS+Qep5HKFs5LF+uVuKO76IgfZjNSqqBRUnofyBvFH659bTVfE8aMH6ZZV8yfWLkALaBRiDuhO+eM8SOej4nWwa9/S3rPlTSXGviE2dO+lDKpxAX4HOZlZXXyqW/R5kmo1Zvt6ULbhYuyu0wysv+RIK17LVhy5od2E4YTmbuxtlIAP/17xbTbIa1GHZhm+swcW99v7Ws8TdlrgTAm6e4Te8NJm+GR8wIGybiVYdKVMb3clXlMcNjE6d0rlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2oMegg6FdjdCGsJzrtEe3eRTP6aHczC3fVhucY9wv4=;
 b=FGqSUVS/QUWPWyxyh92uQz3rEvNU4Sthljg6xRc9OjLKvofhvgW+J75jRmF9EsWlRS75eIgS9/1fvytzmQJUEeFRy7kNC0DSlEXVGxFfvKGIwguDtdLlUhLQn6qIWYimWEO0/CGKtIm06eFpKapMK91FVQI0bFrOkQ5AKvxuIc7WzJrCyvZTiTxLddc/h6f2qkr728ry14qmKl7Uw1SpxHGI+lT+jwUumpwb85vUaQ5p5UpkYg1EvZL3ffqBLu1oAJKgxVinDk7NB/XKu3dQDnqxadYjf3ZNqndB/PgnE3VePwyZ7Kcqg0+M4CWPf0O/rlW+pLJjohwpU6CyoyYS2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GVXPR04MB10947.eurprd04.prod.outlook.com (2603:10a6:150:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 14:19:25 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 14:19:25 +0000
Date: Wed, 6 Aug 2025 22:14:03 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, o.rempel@pengutronix.de, 
	pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GVXPR04MB10947:EE_
X-MS-Office365-Filtering-Correlation-Id: f54bf43c-6620-45c0-1ff8-08ddd4f43f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XAl14thYUdCBV4wgAPdKYF0s7Mp+04yxEmyhKX3kO5GFPcOq2F+WeZ3zDU1X?=
 =?us-ascii?Q?U4OvPvjY7FdqAMq4HywVhiE1kwTD863BKM75gLCRxufbCzFWBLjGkSboTMmf?=
 =?us-ascii?Q?L3jLVS68Uy7vDnNZV6jMOZE7lUZ7AI9jBd7lDLeJ8jxvnJmfYCCBrmb+2jlt?=
 =?us-ascii?Q?jiB5NQJK+y/bYG0d6y/DYt1l4lnBhIaUJZdKf/VC/3jJZ7MuYvXUd8/ZNB/h?=
 =?us-ascii?Q?x7d/UHQpB/+u0HV3hUIo937lmKyw9YerCNLJVySCwbKhG50RBw9OHSlv1GK8?=
 =?us-ascii?Q?ABSms984x7JBQgy2pSLAecdbWu7wS35twJY7Lrg0ja6lkcfkQU50yIe/8/uQ?=
 =?us-ascii?Q?bc/LftYHr80jthFg880F8S2EhRO70UFpejDovywOdXlMQgB8hSvF9VkNbDCy?=
 =?us-ascii?Q?bifXvwpZGL/ewFOqDvw7tjcxtQHX4G8YluUR/RJL2URctrDLtH1/fREfcMha?=
 =?us-ascii?Q?1tRGzYPyvHWiJ25I7c5HVxqNq3VJXK3+O4hJ55LWwci8u863mBtJuvSkkMFw?=
 =?us-ascii?Q?dYRPZaLT75NPklShzaFv7pdKHJ5nPYVrF61DXkdesA1yXZK1ZaxblViOWllM?=
 =?us-ascii?Q?eg1APvFoYRci5jf8ESYZQtJljfHMMjajxq9l9403nDv+LcQw1cHJ3/nrMy+P?=
 =?us-ascii?Q?1LnqleCMUUksWP1YciBHMMdLJRcSzTNaUtuTQbavCbc4ANIwIvwKXY5td3no?=
 =?us-ascii?Q?8nWXheE2GQhVymgHUHp62OYZVrpPhi+a9xD9ftoVTOACWW1f/f25k8H1P/Wb?=
 =?us-ascii?Q?vDnsH+rmLy2EeOHzG7Q0V3tAywdRZJYSRxEr2HYce0oU/iUiNq5sSprJqnLc?=
 =?us-ascii?Q?a/Pk4WVxBktl4qSyBCkghCAkXHwWwk6i9M4wUHFZkjcgrlCHMTw5Ur58vFc/?=
 =?us-ascii?Q?zsW5AZ+ZrFZtMWfEeGCLV2jyah3ysee6/vQlA9Xvvw2heQTqIGkFitkQXDva?=
 =?us-ascii?Q?vM6IhppideyLY1Tp9XncY8m2v8BvRin0AgOJTckSTQ8LbGy2Wxdw9RJ9j+q8?=
 =?us-ascii?Q?/7y+/WzATZJf6TbH8HyAuQ80IK9Q06H6+aM0PQV4vljQMdrOYlzkNsq359fX?=
 =?us-ascii?Q?T/3wJwARzDjczYgnqlSAPI54riAqNIJAgDKsZrGxQt2qZNhcwdx2JgwyxNCD?=
 =?us-ascii?Q?pll+B4+90Ngj3M8B7LO1it0xWERF4JCCESamDocZvv3igwwUiko+uUTlgkbi?=
 =?us-ascii?Q?yyYhjEleNYWh+pWPXh6/1UJcOmNxtc89cnXCqNyymnqgLgzERjboAJhSlwGr?=
 =?us-ascii?Q?FDJwgbtQqaO7972zTkByIHsB2ubg174o5/aDtSqi9Jbe3M4XY1NPSzfrUEbp?=
 =?us-ascii?Q?9Vg/QiL/ocPO/FumD6GxlWWzLm4BE0h2LmvgIzwVx+1/pPOCNRWv/WK7hu0q?=
 =?us-ascii?Q?LeZzl7Vjq4LG0LHlcIuBETdibNmCHjL8xBcp1Rrj+FRdXKAHfcwgCi9qe9/s?=
 =?us-ascii?Q?tcMgaiSKSOuO8RpU5Ki7NR+E4yD6PYj1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDLCGyo7wUMxQYXnZAcSGzjdenvOpVv7Gw0u2ZyRAANtq+UAvFk8mmca4qmp?=
 =?us-ascii?Q?Gf/7/u+nmGzOoAeKmWxA43HU20G/gZ/FoMQ9Hp8VfcnL7VVvaEUe0n7Yp/wQ?=
 =?us-ascii?Q?fZpTXhG47xnhPkbUykEt45MLJAn9UcqDskMrdueqb0XDMm+CTWW/BFFm/3Ul?=
 =?us-ascii?Q?F2R/J/KMQddzwoIV1IxlcCLBf5bj2HvvZrhiFjrOKfmu1KGU6qYFaI9rUV+6?=
 =?us-ascii?Q?ub3SLEfe09aatSDA/11l4xnHZRzNfdcGguaxu2Q6zsMcLUwy3JSo6FKb0qVH?=
 =?us-ascii?Q?Czx0I7enIC9fI1fx06aF2hPOhb42qHakV06XWq4wo2c/qXJ6D41K/m+Ttk5q?=
 =?us-ascii?Q?OmLTZ2r1eGJb/ijkPHO93neWUGwB9MHWLczYNZmrZ4N8yoV9oRkmEyPirzDg?=
 =?us-ascii?Q?EV5tUO3tRGddhcLs4kSFYOR1/WpJqNCjH67tuMs6xpDp2gnilvJOQU/Fe714?=
 =?us-ascii?Q?eqRpCGEEMi0yNhrCG99ACGPteeWHHH6gXfXIKCfdhAOzUs2rAtj02g+0dAM+?=
 =?us-ascii?Q?/0fkebToK3oFDquyl6PEQiNSuYa9wybD8Sg2RUl04wrLtuGqG5IZkIcDswTL?=
 =?us-ascii?Q?33TjcrprJ6k+g311avWlhAHgF5h28B4v8hvqW4KKV7xnFV7VhS2ig0nP4KLV?=
 =?us-ascii?Q?l0Jwm5UPeCCAVr3D/nX6iAiNYcxnEweM1xrQ153Mn1PFZAFYaZ4OsQcFl7oC?=
 =?us-ascii?Q?PTQKbnYM0+VobeCzIW/lAZYX7iYFcY05an+V7xzp2Y6QekoEQ1EFAZtnDh/L?=
 =?us-ascii?Q?XsNc/XQA0IRN6m8j8w9kaRFtzwwive11y4MX/0K3yBPhMjRVnck4Xc0y3f9g?=
 =?us-ascii?Q?Q+75BBVZA9GkTBx1Ektv7SCXWaF3s28Osp4VjzZpwUSXl8GMSpwLw3+mYK4V?=
 =?us-ascii?Q?AJheF/Gr1Bcv/pLY+0sEVSG66ZfKsRH/AvSfkDKU1RuFUD9rde4SptcJrQ67?=
 =?us-ascii?Q?ryeAws3xUBeWSGjSPSLMZOCHeayHXIheTb0ZOBq+1CjUVkJokBfNfULXs78x?=
 =?us-ascii?Q?ZsZszqbJvmP3o3d3cYTv3I2/f6jxAeFn/oBCM4ehH7K910ypvkLx/t95/BgZ?=
 =?us-ascii?Q?Fj0Pe/w+rCniddH6TFUj4IOno2zNm/NE9Tq56t5GhatqdMIxRRzqZZSA07r1?=
 =?us-ascii?Q?aBbtpvn4ziVR4knxyJGF9ZohmJB0KvtZ0WTPxlGtD8eM+/4gU0wVgnrN96B8?=
 =?us-ascii?Q?duYtn/aK+32Nhq0DCJPL78yrYZ1E29H3C8Xa1bEKE90mPAr2WzCpIXrk6Ars?=
 =?us-ascii?Q?inkqORWw75tx+uDuFaXDo99M9QFViu1EKSNIz6kOjx2VSvR8Bhu/r0HjFQ97?=
 =?us-ascii?Q?9eAeWO765a6cMdS/WDXCL2YszAVq/ex/wP5BGvHZvwWZcJR4b8SZipVnyyra?=
 =?us-ascii?Q?dbzz59f9pPuLt3/i/z/Vsjq3vJ7cG1BPfHhYQwqE+hrdHjKbtBjMT7BWdq6Q?=
 =?us-ascii?Q?qq1SgZax3/gr4Apk+g2kOeB0MeA61bYT6xvqP5AMaRk9QYg/b6d2OLkRXhFD?=
 =?us-ascii?Q?j6An+QAVrVNptDM/gSjvOKmMNFiIHBynEz7vGhY757ZkA5iHDqQeV40VbgOk?=
 =?us-ascii?Q?AdAqmPo/1OF/tHQ4t8Ul3zLEOcx1Clu0Tvkqxf7w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54bf43c-6620-45c0-1ff8-08ddd4f43f15
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:19:25.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVBC6loQfl7dEMlhwvYw/kQjbm6CxYD2VfY5FXBevsCRhcxKVSuNo+MBNxWCW1JTnbKxnQFBF7rvzmbnXsXsrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10947

Hi Russell,

On Wed, Aug 06, 2025 at 02:01:01PM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 06, 2025 at 04:56:58PM +0800, Xu Yang wrote:
> > Hi Russell,
> > 
> > On Wed, Aug 06, 2025 at 09:45:01AM +0100, Russell King (Oracle) wrote:
> > > On Wed, Aug 06, 2025 at 04:29:31PM +0800, Xu Yang wrote:
> > > > Not all phy devices have phy driver attached, so fix the NULL pointer
> > > > dereference issue in phy_polling_mode() which was observed on USB net
> > > > devices.
> > > 
> > > See my comments in response to your first posting.
> > 
> > Thanks for the comments!
> > 
> > Reproduce step is simple:
> > 
> > 1. connect an USB to Ethernet device to USB port, I'm using "D-Link Corp.
> >    DUB-E100 Fast Ethernet Adapter".
> > 2. the asix driver (drivers/net/usb/asix_devices.c) will bind to this USB
> >    device.
> > 
> > root@imx95evk:~# lsusb -t
> > /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=ci_hdrc/1p, 480M
> >     |__ Port 001: Dev 003, If 0, Class=Vendor Specific Class, Driver=asix, 480M
> > 
> > 3. then the driver will create many mdio devices. 
> > 
> > root@imx95evk:/sys/bus/mdio_bus# ls -d devices/usb*
> > devices/usb-001:005:00  devices/usb-001:005:04  devices/usb-001:005:08  devices/usb-001:005:0c  devices/usb-001:005:10  devices/usb-001:005:14  devices/usb-001:005:18  devices/usb-001:005:1c
> > devices/usb-001:005:01  devices/usb-001:005:05  devices/usb-001:005:09  devices/usb-001:005:0d  devices/usb-001:005:11  devices/usb-001:005:15  devices/usb-001:005:19  devices/usb-001:005:1d
> > devices/usb-001:005:02  devices/usb-001:005:06  devices/usb-001:005:0a  devices/usb-001:005:0e  devices/usb-001:005:12  devices/usb-001:005:16  devices/usb-001:005:1a  devices/usb-001:005:1e
> > devices/usb-001:005:03  devices/usb-001:005:07  devices/usb-001:005:0b  devices/usb-001:005:0f  devices/usb-001:005:13  devices/usb-001:005:17  devices/usb-001:005:1b  devices/usb-001:005:1f
> 
> This looks broken - please check what
> /sys/bus/mdio_bus/devices/usb*/phy_id contains.

root@imx95evk:~# cat /sys/bus/mdio_bus/devices/usb*/phy_id
0x00000000
0x00000000
0x00000000
0x02430c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54
0x0c540c54

> 
> However, this patch should stop the oops. Please test and let me know
> whether it works. Thanks.
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 7556aa3dd7ee..e6a673faabe6 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -288,7 +288,7 @@ static bool phy_uses_state_machine(struct phy_device *phydev)
>  		return phydev->attached_dev && phydev->adjust_link;
>  
>  	/* phydev->phy_link_change is implicitly phylink_phy_change() */
> -	return true;
> +	return !!phydev->phy_link_change;
>  }
>  
>  static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)

It works for me.

Thanks,
Xu Yang

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

