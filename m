Return-Path: <netdev+bounces-233054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A20C0BABA
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA7F3BC9A5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D942F2D0C89;
	Mon, 27 Oct 2025 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LteybDmu"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3922C11D0;
	Mon, 27 Oct 2025 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530876; cv=fail; b=aOGKXkQPIpnejG++akiduT3GPuyD/XFzQL/wGX3DrvFrbx0MbR1dmLMtL/2dkqFUuue/eqVJEC22u4eciKbryjkTrpxYy7x0zpWgPWU8Ddy7ICinY6+gHYRg8jLMKZfsDUhauqnlg6XunWTB/q+Oy4bjGRrseXYEvpYtzLAyuqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530876; c=relaxed/simple;
	bh=MXtwaHRnFKMHEO3ilJ4mj3s0pmH2YlsQuOcpGYl0AzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gsNrCWNQB88LtF6VDpy5bMymNKeGRw0xRwsqQ2w428a8mpjKVBwHh98NroRvtPxE+NwRmCELxgpilIdROmRBqzYlOpUNVIiu+iw9S+p9BR6zq1g928fKEqF97Fu6IY9ydKU7AF7HqNJmhSFZC4w+MIbezmCZZ0OgyRxd18gws/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LteybDmu; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijtjeRmClLTFqlbMJWjVo3RNcXVFuO+dIcGRYLtgH/mymbfQLXuC53FPZd2RxpMMmDiYo/gYQQGPReDt+q0nBGJGKTsVUh/hmEp5yivrrMnD0a817WVGJIlDkzl26RNIdLOcNHI7KmYTukPP79egKDpbYUSsr87U5prg/kVKibU5drUGJ+V1Cl9TeUV7Vm8xHoFRu+2lW4nd98z3DevhZCvObDF4/jfh6/JgPjGOjJsmb27wyih2wWFV1SLRLmwulNrSu5nrbXEHhXVuRVp8fSNDF9Rsn5VQw3C6uAA+21SU2HXnm9vTUVX9FlwEZ/fCENWQ7NW67MUcYdiURmDhig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHcgbVAl/STlwywDG6DBlKWJb0MrwrwTjoolby1gt60=;
 b=GGmqx0wfeuTkt2UZUBfGJgCLj+fshQIoiKkFWdRvjPGyNkcNGNvaWSw7cvBbVUJB3NnHvoo16PkJweTP1biV5ESI9XCcCACvicM78RNEaYfnmIxj7KjZMSK/ltBOVtisgOwLRvG6Rr21wKXVzE6bNpx+8kRswk6eH++SzFVy/eceJCaFYHyPdXZMVUIGW5zTg9xdqo0XOjoiOW1qTCOJo9a0JLR4oRJNSYQjXgQ9RbxFQsPPQr9cTq5MOUjhdmqfLprHbYuZRc5n87LdXgzhYwWJfr/T/2q3Av/5G/8LOly8R8aFvZ06NSKCWBZEO77q5KAOYznuaQA/E+h2JDo3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHcgbVAl/STlwywDG6DBlKWJb0MrwrwTjoolby1gt60=;
 b=LteybDmuVwOHjgVl0SY6th66rT/WMR9dsPusJbc6Jw4n3lpC756WOBZxjrMQ9UkH8p408JhjAd1Bj8W71hqQJkom2wQJT2lU6qk57V4h6M4v4Ymck0SzDQ5WFYtaQb8nN7oO2OsXiN5uYta4K1d7+Q87O+1z46XvvBIORNr9mXLtXlf+ZoH+sxcFM96knrS4hho7lQb/11emWlCcKH8FGV7exUIG25leBEWmdhb7/TVCNfFwcQ0LrQQcywkhs0GBwekEC9MRm9ZcAqIJObQOSzcGOQAyqZlZmMphIOeH9WtD5H8QK3SCWtb7ZccwnY0ZZdblgLjoLezbM6wdcvxNHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8942.eurprd04.prod.outlook.com (2603:10a6:102:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 02:07:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 02:07:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 net-next 4/6] net: enetc: add ptp timer binding support for i.MX94
Date: Mon, 27 Oct 2025 09:45:01 +0800
Message-Id: <20251027014503.176237-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027014503.176237-1-wei.fang@nxp.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfecfe0-837f-4d0a-ea6f-08de14fda282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ImF72GU6cGvuWbuWGfnbn+4d6NxX7gOj+PNRHYWopl+FnBLxaj4l9wf0dPw0?=
 =?us-ascii?Q?EU9rb4VMKL0vGI9DNt7cJOOFhTSkNUno9YShEoJcV/yRFTZt4C4PYI6Min1D?=
 =?us-ascii?Q?nG5mp8O5ErLiWLF74l7w6ht6T2Nvmcsar4gMQQUt72a+pKItqVRId6gE8EI0?=
 =?us-ascii?Q?teoERi6lxVXygdi/+lXTuC6xjKHlOr3YOf4Aqgo+XQKVjdhekklzfBktsibI?=
 =?us-ascii?Q?iTItqJW/P7HlyGXjXX1OVw1I9eo0lTx0Wro6A3C/lzRhEfHMpyM2gx4IeM+q?=
 =?us-ascii?Q?4V0JYcMSZ7YdMEHNfzmvghyPGg7armOWKiPCuW/SpgooCIqBEAf6rajRE8C7?=
 =?us-ascii?Q?vHlgD6lFY7MkUBdIsMQ3BYhon9+uYfa2F4UuxxnyQK9Ii3gSZpBRRMhCp/6H?=
 =?us-ascii?Q?n+9NtdTnqCoLxJllyUqbMmG2cCZ3xWBKcL6/ZCWKn9gJolaOTpcpf6Aszg9+?=
 =?us-ascii?Q?acM+EFh0Nmv24NmbNSDBn9GSv2px9QJi31OwtE9GwALyGZtO+pIVLnKN1zJR?=
 =?us-ascii?Q?2r8JJE2jvnqEhi6IX54tE/nf8yEKNqzwBkJLGlOl5TAj9baLzSfC4MVLIkJA?=
 =?us-ascii?Q?Ub/tJvyo7A0cs5uuRPuQbH/JcSDvj3o8yx4tHE59TdqhoWtawUub36kYUL0r?=
 =?us-ascii?Q?DmI9R+QanBaHF1YcIMeZ1RKwOUS6CfAaLWmLFsI1ijJgOyOqQmaBR4P/xE5k?=
 =?us-ascii?Q?kFWpFBQ8XgqUwjRuObxoBH2QxkwQl+ZYd5fHb9GU3bWGr3PdEtSulRXF6KNk?=
 =?us-ascii?Q?r909WEZTuiYPL+S6wOqKI4tHlrb0+7oKVOuIP7MM+KhoDTt7Sjs8fQQxi8S+?=
 =?us-ascii?Q?frsCbS/2pMCGdJKMyvmCJ6q6PZ73i+826q1SWtjVIsPffJcsk2XriRT7tg+4?=
 =?us-ascii?Q?o1tR9dg72fBpRgPxr5PpssZXxenLB0WITz8wQ8f/1LJRAjyxIsY8i9xHh+Q6?=
 =?us-ascii?Q?lIYDnkLjCzgG3HABRLWJL5TRPiwwq9rL5IXik28aXlat1GAC1sQWtsU3xnL1?=
 =?us-ascii?Q?Ml93u91s013HrfvkQzpIrcDlKUJ+M2LOuyOl2FiSAVgBKA7zwuMFZfpk+AGN?=
 =?us-ascii?Q?sAJH2WfZaucO/kybzLR5Iun3gP4hqVQX16lOQhmuG9F20vmxWepiyU6QouPg?=
 =?us-ascii?Q?aYd3hAfD3+ybd4M4NN15BlsbqFnoIqXR3emFtEskd6YFwMs11mzJbpNe5yXL?=
 =?us-ascii?Q?4n5fnzlIfaqQvyAKhsZrAouUG5WWWnr6R9wcHujlvBF9Tp8TZB5Aa9JW7K2n?=
 =?us-ascii?Q?3iCTPW9Po5HrBfSPXyG84BD+Bh00IkwlzJ44Jn2laA5Uz2Cv4SoI8IGifBOy?=
 =?us-ascii?Q?0NHhMW55mm886xzWgwZ2+4w9bycaTnzyNi3EE1S3WjKvJrfJCuqNCGZt0QAL?=
 =?us-ascii?Q?l0YdER4UHKfzoMQ1pUxnBty9irVVnzrqdHqsixoGyEWzCspAa3LWlWe4fs5+?=
 =?us-ascii?Q?aOaTogEA+lgumSFk7pgn6Leu9CZy13xzuiKwXUJVnixqDF6nyJ8UwGnYIl9h?=
 =?us-ascii?Q?Thvx8L8TqwL76pK0ACfj+bx6diogX6expom0h8pr85tN7ba0ZGErwMG1vw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dmOlsbeSqutBm4vwAWnmrwJJnGlangqh/0yUUSmSXddsCiLxHXl9Ihp7/1Cx?=
 =?us-ascii?Q?Fpuf+SIwuWF9tM2uhPYrkOpn0UwBpKW1frV4OSsRYEt3Nfx2puy92GqIeldN?=
 =?us-ascii?Q?Ogd/ZGUqJoHRx3trmZdkagfHQWzYHFsCsPTiAuo+8XppqbrRwsEge/In9DXw?=
 =?us-ascii?Q?J3eP8S4sK9zLM+fHexkl4E4sZxv8dr3cqo9jO1l7pRN0wqWjkJ5VGJXXLuwh?=
 =?us-ascii?Q?MCYOJRX949w6uLEwkOd0dxmIMakrFisZFnbMxptFDlo5fKnlYSjzym6Wai4D?=
 =?us-ascii?Q?9w97yoJ0jkn0MFSXPEjHqu7WISvkBVrM10PjVKAZMBy8AGI+41Nl2bEr8GFn?=
 =?us-ascii?Q?bUZEtdGkgdNF+PM9da7D7QuZakEK+VlsqxLEqi+6vtLgzgx8HmE6Ztxu/mdy?=
 =?us-ascii?Q?iKHyZ64pRr0o44KcLp1wDz2pUSYXrOh51D9apSAE71ldlJLO1eFQ2H0wattV?=
 =?us-ascii?Q?jnzawP0ThyoHT7cppMfBqWixw78kFgLM7wzaKAPQprYqJ6YYMOGNk58B69Kc?=
 =?us-ascii?Q?qlGogKjzT8DoF9syNaDTLAXdG+cH8n3ulNYpbAbPd/TobHneN2YMgVGvseJt?=
 =?us-ascii?Q?c7L8+tsnBw8WGR4MthECYpaPpF/mSAEEVq6WE+nWGyy4JG8wSw3SMmny857q?=
 =?us-ascii?Q?24+2Ld/ro91xiMA6VwEMrTov/UM3Y7rxIM8RuoSBXTftBY8R2howHVRlOmmD?=
 =?us-ascii?Q?qJ69TO/NQiiMBqci5A7SBt+wxvWrbH4zdQhmF/DG1xnzySusriZsLIQChJ7f?=
 =?us-ascii?Q?XQ2UNOPoMCcGRoeHV3JNNQjK0csWAsZ/GcjczjD/XwFZqKXnadgt9gbp+jRy?=
 =?us-ascii?Q?Insr5dI/mOUGagfc5f6K9OMsAiVc1R2yD0Gquy6C/gPtK0YcFP1Vcg+MwGbn?=
 =?us-ascii?Q?CtpmoGHBFf6b1e7u6ZDOkp3c6kHVdzJDh0YIvvZ4g+esbTul/d3325czc4II?=
 =?us-ascii?Q?UERuJ/QC9FG1sfn6FbLa+0WWT+l1I3aTrgFuTTWmWg7H+RXKmBvY/4X1f4f8?=
 =?us-ascii?Q?seSTyL9iABEhP/raqZbCsejc/3SZzEd8dgA5rsD4Y/pmVtqQZJcNS3E4AU6w?=
 =?us-ascii?Q?8lJFtmNkvHYgvOSysYL3HAM8RKcDvXxOpDGz7N+eQJAe237yRqiF7UgI67IF?=
 =?us-ascii?Q?XKMwdkEu4wT1Uxya7oKNQulbDPaQzJDoVf9Azbf44osqk5swevO90uvO02D2?=
 =?us-ascii?Q?MwxvL9zFAVImRMI/Iov+pBe6p63vXx2O+1A2BS4BIXr9LU8+kgLGTfv6A3rO?=
 =?us-ascii?Q?okKGeug1GQBNwwgU1fP34HTSwWmbc5fRnXaIiaD9HjfDt0Tl8BMZ9JWUd2Jg?=
 =?us-ascii?Q?QQUS2Z8xMfefDGXnvc77LVtpO7vH8IKv94KudZ2XEwLEEjB1Gf18bnLHMHZp?=
 =?us-ascii?Q?zKLSEXq2l0BeRiKrYN+4I/aV0SrUVHIv2CO/bExstTTUST65sdOjBk27pTHE?=
 =?us-ascii?Q?ncYMJtK8BiSnT1RNxPLibICi/2tcK5Uz03cEYvd9As+QNfHhcXoUELuIsTb1?=
 =?us-ascii?Q?ytzVvsbMRyMwzsOikKlAiIf7D7OlwDodyEUOGPNlMRMFruq0UnvKNuAHycY4?=
 =?us-ascii?Q?hd2uz42fMFLLTd9FY4FfZAL5v0IplLo9IqXrzBF3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfecfe0-837f-4d0a-ea6f-08de14fda282
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:07:52.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Su28E72dA0bskm/cRdJaXlr7yrLpb+wSBOlN1AAZl0cLwmBSsGZY3xf6/IOGifqoOdsxOhfWyDfLdoqH+UW9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8942

From: Clark Wang <xiaoning.wang@nxp.com>

The i.MX94 has three PTP timers, and all standalone ENETCs can select
one of them to bind to as their PHC. The 'ptp-timer' property is used
to represent the PTP device of the Ethernet controller. So users can
add 'ptp-timer' to the ENETC node to specify the PTP timer. The driver
parses this property to bind the two hardware devices.

If the "ptp-timer" property is not present, the first timer of the PCIe
bus where the ENETC is located is used as the default bound PTP timer.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 5978ea096e80..3fe8f864bcf4 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -66,6 +66,7 @@
 /* NETC integrated endpoint register block register */
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
+#define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -78,10 +79,16 @@
 #define IMX94_ENETC0_BUS_DEVFN		0x100
 #define IMX94_ENETC1_BUS_DEVFN		0x140
 #define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_TIMER0_BUS_DEVFN		0x1
+#define IMX94_TIMER1_BUS_DEVFN		0x101
+#define IMX94_TIMER2_BUS_DEVFN		0x181
 #define IMX94_ENETC0_LINK		3
 #define IMX94_ENETC1_LINK		4
 #define IMX94_ENETC2_LINK		5
 
+#define NETC_ENETC_ID(a)		(a)
+#define NETC_TIMER_ID(a)		(a)
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -345,6 +352,97 @@ static int imx95_ierb_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx94_get_enetc_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse ENETC offset */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return NETC_ENETC_ID(0);
+	case IMX94_ENETC1_BUS_DEVFN:
+		return NETC_ENETC_ID(1);
+	case IMX94_ENETC2_BUS_DEVFN:
+		return NETC_ENETC_ID(2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_get_timer_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse NETC PTP timer ID, the timer0 is on bus 0,
+	 * the timer 1 and timer2 is on bus 1.
+	 */
+	switch (bus_devfn) {
+	case IMX94_TIMER0_BUS_DEVFN:
+		return NETC_TIMER_ID(0);
+	case IMX94_TIMER1_BUS_DEVFN:
+		return NETC_TIMER_ID(1);
+	case IMX94_TIMER2_BUS_DEVFN:
+		return NETC_TIMER_ID(2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv,
+				  struct device_node *np)
+{
+	struct device_node *timer_np __free(device_node) = NULL;
+	struct device *dev = &priv->pdev->dev;
+	int eid, tid;
+
+	eid = imx94_get_enetc_id(np);
+	if (eid < 0) {
+		dev_err(dev, "Failed to get ENETC ID\n");
+		return eid;
+	}
+
+	timer_np = of_parse_phandle(np, "ptp-timer", 0);
+	if (!timer_np) {
+		/* If 'ptp-timer' is not present, the timer1 is the default
+		 * timer of all standalone ENETCs, which is on the same PCIe
+		 * bus as these ENETCs.
+		 */
+		tid = NETC_TIMER_ID(1);
+		goto end;
+	}
+
+	tid = imx94_get_timer_id(timer_np);
+	if (tid < 0) {
+		dev_err(dev, "Failed to get NETC Timer ID\n");
+		return tid;
+	}
+
+end:
+	netc_reg_write(priv->ierb, IERB_ETBCR(eid), tid);
+
+	return 0;
+}
+
+static int imx94_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	int err;
+
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			err = imx94_enetc_update_tid(priv, gchild);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int netc_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -441,6 +539,7 @@ static const struct netc_devinfo imx95_devinfo = {
 static const struct netc_devinfo imx94_devinfo = {
 	.flags = NETC_HAS_NETCMIX,
 	.netcmix_init = imx94_netcmix_init,
+	.ierb_init = imx94_ierb_init,
 };
 
 static const struct of_device_id netc_blk_ctrl_match[] = {
-- 
2.34.1


