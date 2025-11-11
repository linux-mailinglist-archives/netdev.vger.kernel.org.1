Return-Path: <netdev+bounces-237536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA76C4CED1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B75564FE956
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8130AAD2;
	Tue, 11 Nov 2025 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZaQiBOF6"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866B2FDC50;
	Tue, 11 Nov 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855327; cv=fail; b=sk9m2SNSIy9TD0XkPYry+E2pB/C/BtHjFpn35Ns+IGfqPc5vusXihjBxzDX8PbTiC1b+M1ykhzlqm3NOQ7B74FdAgtaupgvL8C64Vg0w/TlMWJIVwQH/iy5gwQ9OKGg7VfHxCS4pdpuU1F0oYDphiWkpwA6cMd+kSG/oScWTMGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855327; c=relaxed/simple;
	bh=oHRjnwqEsIjDTbt8E/Vin2qdp6SmSqn4cID4iMmmbZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sH9qpTLq5y6P/F4Zx1wpFDknQCqbqaKG1oqEPSMix5ms3+H/xfVE/+hgQJKppOhXuXGIsuw5KsHVlwQuUVAXbLSB70EZj1bAS9uRoohug2/mIYDxgWAJOuultRdnNfMjWbBl0z3ibLMPlH60CoPlhkeQ5RU9v1dHsQKYiXtBT2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZaQiBOF6; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBIuYKQyi/GgujQc3DfMgoabJ1FvBLUnq0chKmY5TxUi3EDD4tsgfuLPxzREbvh16t9VWf12Iybw/2SZsFHWzVu4aH4PjEgeVCKvczEQDBdR9DH22TBrTPZS+jz15nKL9wXSRXfM7NKJUKemfXAGYwRO7sB+Fy4UALOkV2lamFyD5gVD4ahsN1HICzpmtM4WbGHHMkCbokWrcrjRrxOLl9adJHXkSYpgCPUpjj8jYUlQqaDwSQdzAjHjvY8QPce9U6+qRWP9whHF3YQi0q+N3MzcJvwe8N2RLhoyt2KZhgnW6yIast+Wl8dL9Je4QWtaEUCapxV50KqGdYOKHq0fVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okP+b4RF2lhV5I+n8PwqhfwBxjhzfCIyztFSELWFqsU=;
 b=LBd0F5j1aoI0tJy96vtGyhQMWQ2LWFKyjLkH2ZJeBotIw6CX7hHB+tL6ReCb5IbT6mgoOksN/H5wacjPxiDC2MqUSHTxTKr8zMjFaxVu6YzATTdZvzIsl2G2/tDRxzkpiNrar08G1leUyIqTGhCknA0s/gHe0pwxc7EnWhBdBqCYIfjK+C9xjU874cKXxFDahxwyU6+s7Zs6ttyaLMnvq4jtzdM7tis//1YTDZ50e5Gei7nxsYLIsvadf3Ew0eU5qaBk5HDtzWbOWknxrWMw+oEC8aI8RKWg3q3pUDySfxlMsois/F20eaWQQB7zZ+zm3o0edlcf37xY/RkjerPGHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okP+b4RF2lhV5I+n8PwqhfwBxjhzfCIyztFSELWFqsU=;
 b=ZaQiBOF6HKBUcVTTzgPxwtVvbzmB5AIKhUm1hlb7VL4792Ect2hDy28ZVKSyNnKWAo8IWu6n7pokon516WiYLffXRsJFeRoDmJJv9IKHabMO8B5Vl5ltkcCsAzk0tfe/splmyr+W0eUCl12nEzs1cZHhWmN1xFV1obDdBt4WrM49TudvAegFObfUilNIeUS1iHsEUO/eOzZkxyPrzma/iE+rnCDUf2UtJNL9retx22hCZ/Cxag8PXgrmb6oiYcToqRmv7C4chMwW5OWa7L5VTuNknNmtfRZvG28PurpEKQtiGGLykIGJwRnaACseWToD5qzythFm4Aw5Lohrhi4BtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7545.eurprd04.prod.outlook.com (2603:10a6:10:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 10:00:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 10:00:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] net: fec: remove duplicate macros of the BD status
Date: Tue, 11 Nov 2025 18:00:57 +0800
Message-Id: <20251111100057.2660101-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111100057.2660101-1-wei.fang@nxp.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: a231d254-0ae9-4b3b-8609-08de210930ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nch3eGtzR/ZN/yLHisqokn71fa5VWCmFFQgxkdLXB70VQ9aaDiNk9qHc0PfB?=
 =?us-ascii?Q?hbU/Qe3zQZ5EgO/yfEWDG5lH8xW4J7BnbTR93YwI/CIf9PW8fUKssVRIdFL+?=
 =?us-ascii?Q?M0G3mo+AWbcc8QPg3LAnx0vcCGSrDYVGwcY628JuHSct9TOZPx/7ZMWGAq6f?=
 =?us-ascii?Q?v4I+6T9IiHdpFygiKD7/MxpmgtY6iBXSz9Af2tIpHJWU6qrubISo+nM5aKqf?=
 =?us-ascii?Q?izmMZ+GHk76Xf2ywlzG/M4BwKJA/lHlLspXfwysqkgTG7wCRHoBXsWjDidLS?=
 =?us-ascii?Q?Xz0UzUCvefL1a8EV3ydoWIv0yNn9B2lNxjP2Yc4jk/IQnnUwSMfhPYKalo2r?=
 =?us-ascii?Q?F3OnXJDwId3c4GgcMB3nLnzeL6biPkU2/5knbF6d/7YYHi2QMZzdcIJ2XCZC?=
 =?us-ascii?Q?YVLlnsD2Kqr9cjX8Vm6S+wR3iOed+H3qfdvD7lM7t/93dr5mEOBmM1ZVNYbB?=
 =?us-ascii?Q?6HTFVGTLepQ3planJUUk8ujxGfNP+owxY/LaVCVl9Q7sh1ocqdPCEGYCUIRI?=
 =?us-ascii?Q?XxnmApG7AuUPT98X2299acL7j1HUzVC5mvvLm6K8ZxUDq05QUTcSD5J3FwoY?=
 =?us-ascii?Q?ThKLL1JUH4gWrv/iC9e7DHU8Mv2xbJgWHxUlUMRRzxp7RBEhVLe8IgSNxdnm?=
 =?us-ascii?Q?x3080OL+tN/s7N8BrDp16GAawNaHkjjufzP0fPMAwO2/hO/qUsjKCUI9PpbU?=
 =?us-ascii?Q?8d1d3grdg6+QKV6IibQbcbGUJjj9N0dkgShukyMg2B4mVVZgIOQjGzC8dNKT?=
 =?us-ascii?Q?2+lqkaBVGzkwQwLolBAdSYv2xC0L/3NHK0ewN1MxMPCx1vy0yoUwGL6SoxYu?=
 =?us-ascii?Q?wBcwISWjPP3Smp1CkcBbKWDFMdqAyBY5iQF3QSdAvpb+BzhCekgFYX07gn3d?=
 =?us-ascii?Q?bKMA08uqXlc8EjNZBg30/JVARj7dl2OIfZiJ6+HTa85bu09tAD4B1UTa88rI?=
 =?us-ascii?Q?H5k9qvsyCOPCBDIWGm+iSG3aP3x28CtXRDQIDTNEoNlG39jGShY2X+pBOS6M?=
 =?us-ascii?Q?QnmV/3hHDZNN27FZjmBxHOzlZwhRgs0uvGNRhJ3W33jFRd19gjMz+2vfyja+?=
 =?us-ascii?Q?A6wkdQEVcr8J7FdHfOrWCnZieGUs4S7KJtrYkDCDiciiG5bOCNZLYGVPt/hh?=
 =?us-ascii?Q?JyDWI90k+eqaBUaUa7seC2eRXNn6snPdfKGEYmhQQov6DREzI4813zqxRVa7?=
 =?us-ascii?Q?hXECcZRezrtJ9+ruzEbKhxIQf/7gJ918k2Zy9jMnndcq2yocVp5szpd2kOnQ?=
 =?us-ascii?Q?pKv7Q3KUVh4gEN0f5skNAkEUwvVQHAe+I0ZM1d/+WOQHo5kJxqkSxFrlQ3kx?=
 =?us-ascii?Q?WtdRCemNh3YzIn+U1L9sXc4pOMPHe44u6tYnREXe5ZDViHXUDnJl59o1qkAq?=
 =?us-ascii?Q?V31TdxVrI4InPsUrhIqtYK5daNbcyKquQ/uS1QKmYtrqkWFdWZLthCTXijJ3?=
 =?us-ascii?Q?QkkP1pzKk7eayl+YeFJwiuv1awjypZzEY5vEhFd8GLwtw933kEb3mJq+v1kN?=
 =?us-ascii?Q?QwUBbr3+c0nKYpgLis6jVb9oKe5+NEEi71/7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWStw0bH41/y/mWF8WPxXQcG7YSgAujiYgTxalNQ8+hdg4belEC7PFVacSAu?=
 =?us-ascii?Q?TM7qHE1yjT++2chbS0R5KpAefOBQG0ZONSsAWC1SIPdfmwuX9sMITPJtEmWK?=
 =?us-ascii?Q?hhOYVCMDctLRsuFsBo7oTOfTFO5MYrgE8qlPY0ZWeuC5mj+0m5Y2ZuYz92Dh?=
 =?us-ascii?Q?6rWk73vFnrpqF0kVLzS2nTsURreMw/kSXna/jmnBHpPATJZcraOH7vAhEnqr?=
 =?us-ascii?Q?cbcDB6uZmVI74fr/ZFQAuvLQ0mW7+G7D250HXofzcwKTCRG8jjd3VsWFZyh8?=
 =?us-ascii?Q?Y3yiLzcSX9Zax60CRj1gvo4QjT+7KYuluMmuBlpq3gERwPOOcioHHbcYDcXO?=
 =?us-ascii?Q?dGWiYCQoLH6fR65z7uh3yNCs+tTB/QOe+WjND6XxRsVHV9Oo1L42q3A5jnRD?=
 =?us-ascii?Q?lm4ionKibrK4CGncv5d1+lhw6BVMvwsq+EYt6o8qDsZToN0Fk7MtF8PQ16b+?=
 =?us-ascii?Q?iUxblnI/x1o5WpIJNXrZnYCSfKLePCbBIVi759QxoX05+fkf2+DbrRwlY6nD?=
 =?us-ascii?Q?xScpuRzAgr7oJxqgY2SygE5KWVyrEDhELUVm3115AznSvOy4PYM6y6NWtjlH?=
 =?us-ascii?Q?/2AaVs+3dObO00HekPLB8EVuFFvuyaFgr4kbAkbRRBAvaV4tigh/NlMTqmt7?=
 =?us-ascii?Q?7ikcZbA8elZVrN4nLsuOZruKBoJnegEeI1nnjQXIyZTmzm2aaQx84fPFU1Sb?=
 =?us-ascii?Q?UEPi9AbF+u9t5RpvOylPqer7BVJG2CsSMa7uYdqtALYfS9Hg9YtV93sNe6rh?=
 =?us-ascii?Q?x3rAHt+B+VcqyH77C5UauRL9pC0XqoMkyxTy37G5+kEkVUyPvmwMEM3jfhpx?=
 =?us-ascii?Q?EqC/8vUoqvU4K8ITstmODyHyycSLM5rCp5lePQb7K3IOGqWF/DIXFUe+21qV?=
 =?us-ascii?Q?bepea2QUrCxrIlR81ULv144+EcnOfWhDtsdP+7A03qYx0GD7sldYWIeUBo9I?=
 =?us-ascii?Q?eh6h/ZQ3SPuVbPOPE7z+hx39a7Qyc9jHSm05davgmA+agjovqrlrhj4wFGAd?=
 =?us-ascii?Q?yKjwi72el8YvpteSVMJIksIsAWt0jt3rRDu0eKImWu5Ddt58hyWRNRVoiLIH?=
 =?us-ascii?Q?oPCiWngHIPRJDp0WF5xvNZeIl50/ab1Tuua+xr/NBo+46Q/GQS4qWV55RNq2?=
 =?us-ascii?Q?aPPTSzoE3HLR7oPX+1r/9se2Jqccra0v66SbKl2N6iheN20cOPshWVEDIger?=
 =?us-ascii?Q?1SnWxTgKHNYndvj9W7BTBbIYxVqFf499RQT80VEWM90AuBrN0hHw9xCH2+gb?=
 =?us-ascii?Q?In2Q5tOVqQI/+Fw16AKXj6B0qQr0Kf68gAKq6oaGgHK5osCwzVzmxmfv2Tt3?=
 =?us-ascii?Q?5BqhGjTgCY4PxEEMbGSyzZpN2ANy5ux88qTYVp607OKorrgC2fEwgEh79p2t?=
 =?us-ascii?Q?f8eO6fwzc4UA+x7S18eDhRjhl3OnxJjcV86iC/yaJJROj91oUy7U97EPZqXH?=
 =?us-ascii?Q?3aMRlyYPsJQR1xQkYDx9ug1BIXcOnZixNzd6KCiEwdbtSrqYtpx1SbxDtdGd?=
 =?us-ascii?Q?HfNd8iiMb/eXYYIluWGTFRpIJlROh+fl2qCsv7+qJ+RKoXNTSki6EoO9c7fx?=
 =?us-ascii?Q?vsgHlNMqRaiP/BMzOlVbU2V54T5nG1yIAJzwyLfF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a231d254-0ae9-4b3b-8609-08de210930ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:00:50.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSKJym2f/TNQEzdOPZ7OKsecCQZ9NbiMLBC3f2hs29NMPVQxU/1Bnqf62kpF5izo8pNYeesrM/pj16ZKEaa5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7545

There are two sets of macros used to define the status bits of TX and RX
BDs, one is the BD_SC_xx macros, the other one is the BD_ENET_xx macros.
For the BD_SC_xx macros, only BD_SC_WRAP is used in the driver. But the
BD_ENET_xx macros are more widely used in the driver, and they define
more bits of the BD status. Therefore, let us remove the BD_SC_xx macros
from now on.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 17 -----------------
 drivers/net/ethernet/freescale/fec_main.c |  8 ++++----
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index a25dca9c7d71..7b4d1fc8e7eb 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -240,23 +240,6 @@ struct bufdesc_ex {
 	__fec16 res0[4];
 };
 
-/*
- *	The following definitions courtesy of commproc.h, which where
- *	Copyright (c) 1997 Dan Malek (dmalek@jlc.net).
- */
-#define BD_SC_EMPTY	((ushort)0x8000)	/* Receive is empty */
-#define BD_SC_READY	((ushort)0x8000)	/* Transmit is ready */
-#define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
-#define BD_SC_INTRPT	((ushort)0x1000)	/* Interrupt on change */
-#define BD_SC_CM	((ushort)0x0200)	/* Continuous mode */
-#define BD_SC_ID	((ushort)0x0100)	/* Rec'd too many idles */
-#define BD_SC_P		((ushort)0x0100)	/* xmt preamble */
-#define BD_SC_BR	((ushort)0x0020)	/* Break received */
-#define BD_SC_FR	((ushort)0x0010)	/* Framing error */
-#define BD_SC_PR	((ushort)0x0008)	/* Parity error */
-#define BD_SC_OV	((ushort)0x0002)	/* Overrun */
-#define BD_SC_CD	((ushort)0x0001)	/* ?? */
-
 /* Buffer descriptor control/status used by Ethernet receive.
  */
 #define BD_ENET_RX_EMPTY	((ushort)0x8000)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index cf598d5260fb..3d227c9c5ba5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1010,7 +1010,7 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 		/* Set the last buffer to wrap */
 		bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-		bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+		bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
 
 		rxq->bd.cur = rxq->bd.base;
 	}
@@ -1060,7 +1060,7 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 		/* Set the last buffer to wrap */
 		bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
-		bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+		bdp->cbd_sc |= cpu_to_fec16(BD_ENET_TX_WRAP);
 		txq->dirty_tx = bdp;
 	}
 }
@@ -3456,7 +3456,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-	bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
 	return 0;
 
  err_alloc:
@@ -3492,7 +3492,7 @@ fec_enet_alloc_txq_buffers(struct net_device *ndev, unsigned int queue)
 
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
-	bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_TX_WRAP);
 
 	return 0;
 
-- 
2.34.1


