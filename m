Return-Path: <netdev+bounces-206078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C36B0144A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0D2188CEE5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692721F5423;
	Fri, 11 Jul 2025 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SfkVdooN"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285B1F4613;
	Fri, 11 Jul 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218265; cv=fail; b=fA0vZTTGe0BX2wcsFdWJPVhB7kqACUDD1t1QfLWN8FcrHdm2+JUpyCkjyMl6UuSwkBAyX5yoU7t8rE+UM9kLsvDpLCf5J1qOZ3uCjPziqqZTx43CmA22I82IsH3ql5YnICsHNHTouU01I1IJEv/ZaAYT7IlyX0P7AOwHVDYWl6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218265; c=relaxed/simple;
	bh=33vH1PkvKGkAiGFcmGy+jKe0gmF9U7wG09qn5yIlCxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mKEiJNYWpyB+qJQJI2diKiJ3NRZsMWthhldG5EVZeVQohWg9Lv5HW/ggUy1PCxS0IYAaoYaOO+eoYGKdBx6/BS3vdpo7QduiwEdhK/wWjXBino15cHktmtmIaqQELM4JrORn5xjtsIX9IMRVXjf3s33BaSnAVmwuVO4LdZPJw3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SfkVdooN; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRIjZ+u0y57bAgCuQ9mJuaZj57rCqR2swhJvH2brOS9hksXp0OD4jqZk/xOXYdixb0RD5INtzJEvhoPyzmYtFoEp3xPd4L9kE/osVOhGQS+1snMnTJEs9r4fCVLpSJuLrPUuOXnkCv4WRZ1XdWHqgopnZcMfrwj7o8HqSeho0H0o5/2sK6dVIbINSyaUinAEqwAHtMFDi8J7E09RCRUMqTVDOqftAtcGYe+VTRpzImYPJbhXCWQW7dyfXLSrj/lzEyZiDeTNHa8bAPMRPYYo6fIe0YxQXZZN+2qCvxvfMRkhfhYFpF/6ZkDw4dMFNgevLn0XPXIxdOWyKl2xVt2VEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjL+1KMZDnR1AQm1Z4wpDBpvywaFN7bTD+im2lRAYUI=;
 b=jK5zu4gXKCifqWONOaweZNawsMpTQhuRwOLLL4mpYAXEL6j3IRzTw7UfBAf/GPE0DU3sZ5lmDDZBowc6QS8OK14NS4gsqEfdE3gkdXQNKeEcSEbc83y6edNV8DrQerapWf9fp7Fz4uU6FkqtPQoR4FzkBfhgq462tF5ZL/iZNPBO+IcCZDAvhBdifwA9LjSrSPHdbsAIeiY8Vn7JxZIXzXHV4fvucucdg2atMUNQTL7pNITln3h03cYQyGyKJ4wkUaoVOqdLYxds3mp73f+jCie7rVVljSIIjaLfWKEpI52XbztrgreK9Jf2VgRy8zRF9QHTnSz+ZQvm60fCUhoO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjL+1KMZDnR1AQm1Z4wpDBpvywaFN7bTD+im2lRAYUI=;
 b=SfkVdooNVaiSMghs2tKPXpj0MTjrqLLyy7zCNco4DU9iUzqq1lwEcRDT72KUYLY4ohiJf1U8cgTPw5oXYKWUiNSTjuIRIUW3KBsRxk4TApaP2Gz+kaZWK1wO523Tqumebfa4FOoKCelK4gjVqG1CCX8xc8AbjC+dIHdDYR9PQYmd8dkVzfkfcunywU7kCZ7rqWk7Z+dwLtR7uz3BFLqOHVXWuM0JXxSKfTcuElm5sir1MHSfVAC7AZbrrbHt4LDyOa0oqmJG5ShNx/BYMwynr3EyzyntjKRp+3AQ6uEgEEEYMVaQ6vsMz3GEGZ5+wEjBkR5PnkJNl0eU9cu2yWytcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11361.eurprd04.prod.outlook.com (2603:10a6:10:5cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:17:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:17:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 05/12] ptp: netc: add external trigger stamp support
Date: Fri, 11 Jul 2025 14:57:41 +0800
Message-Id: <20250711065748.250159-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711065748.250159-1-wei.fang@nxp.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11361:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdf9e75-be46-4c01-8d07-08ddc04b0602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sUAPYKTTB+CAl9Gkwwfmqu40H0ajmpuYvIK2fZSzDZpnkbl8cJ6A6gTGrU4Y?=
 =?us-ascii?Q?mwo2p6YItYTeJiw/Gm4cJ3fksFXCYF4eS3rOhmvnDzkE6quTrWgrm0XnNM2b?=
 =?us-ascii?Q?s0kvMZ93dQScsaB86aRzI15HlX+N99qoW0kgi8iSiqpA98gKtMaovRu8eWk3?=
 =?us-ascii?Q?y7pM/l273waGBz/swZSqHQ2Ml0oXO4AljN/moiE6uRxUi/n/g37G8CL7zfCR?=
 =?us-ascii?Q?2j+a1SgunRk3yL9IdN8Ae0MSTGoNIxHHoxAXks6xkG8KRboCFU7/dXtszRHg?=
 =?us-ascii?Q?Il/Mc2lmxNQSzwxUT8Q722IHUbgmB41/XbYjx2xq+qwjKrmmHusWspeVObPm?=
 =?us-ascii?Q?I7ogK7e1NGj8bbMJu3RlFidRCAtsZJUNrb09dIWBCtElOiSb7pwqgxEahyCH?=
 =?us-ascii?Q?2xpJIjwL36WC9nh3BxuoU4SHzcV6qFP1FSXtXWlMtxXg+nx/3cFPawWZki98?=
 =?us-ascii?Q?G2611ZYc2ug59VZ4/L95pSg9FgHSptBMHycqX6xO7gDxY7Ys9Mxg7JXo6W64?=
 =?us-ascii?Q?ANPcbAlMREEFFOY47E4HiHhpf9liwuoSX+j+2brLkg4T6TY5RSlJMik/1fQe?=
 =?us-ascii?Q?NIlQtQLIlDQ70wSIFuLfGKdqjlk3GyeKnf69JlXbGNxobBsmBuozTBhFWCgf?=
 =?us-ascii?Q?wyTwZLBc715cuxiKKTQidvMvx8rgt2HtHj/BSbssSx1DpBshEJUlZb9FqwhF?=
 =?us-ascii?Q?O8bJSxyIZs2Cg+hzGbsCnHkYUE3OGZDgf3mCEdDR8ZoYnabAGotfVhZv2jpj?=
 =?us-ascii?Q?qOd5Z+Ei0WTNC0qw5dseqM5YmeyromSrySPtiKpUuRxIxRHyUX/bUFLTrhfV?=
 =?us-ascii?Q?Hw2QRZvyjctQEVyoAhn7aYEI6fH4m11cUkZ+ywQHjfrlIcqu4Ndupo8if3sc?=
 =?us-ascii?Q?o+Zq8pL85TayBut+YfHIOweVblI6WhFqBFwOKcy2hZ1PBkluqrmICdEOgxJa?=
 =?us-ascii?Q?eQqrbw7v2ptXHFLAyvsI4yIanv4oYbqNPV64uLtzFmmwMbcvNv1ZjRPI10oj?=
 =?us-ascii?Q?8/iDX7BqRdL8JOEe55+ALIEi1mE7SvJSExSYbv0zSQqnSpcaCfF/RllAkYTJ?=
 =?us-ascii?Q?IXRL8e0R/twavTca8IeoLJdnbTDW7afPL4qrBQGdvwRFYLJac1sEf0bLEvJa?=
 =?us-ascii?Q?iKnE09ErpWYadilxH/2MVnAZzZoHi7sTwPlOf/31uZBzLe1Bws8D1Sct0+DC?=
 =?us-ascii?Q?3+kLHrgv7/5Zp4Y01ufxF3lfeZxhlnmdL269fHQsTLY15kWrPP7TtTUF1ja+?=
 =?us-ascii?Q?xi87urHKzFmMnlphVEuzT89OzpQIBKriNXR8uJaABVfCtHn6pIoaW9iXuYsB?=
 =?us-ascii?Q?Kl40C+jCKf5+gRDerGhWQKuAFG4fJFpWdMZdYiwXZfpwDESNwN/LOcM11+tg?=
 =?us-ascii?Q?fUzYR9TMpEmkYyTDD8t750qUWeEEMAM0/wjr21soZjI7C3bj4ALVo7xmtVNL?=
 =?us-ascii?Q?VzJvqtuC1zlaRMwZZE4NTOcZU9NoemcusXtRmGjhHoc3nIv+7JdNC9jaHIjL?=
 =?us-ascii?Q?UZfgdUc60BN86A8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kakie3Hj44doorMJeGcYfe7dEinooK32T/rxPXjR3wtU1RPHxf1y8gKuydtz?=
 =?us-ascii?Q?yNjeM+8xBDbpLKrDRj/MhZu3pO4VYdI/t0uHf0xDogEOzZAGTAK2piw3EKTE?=
 =?us-ascii?Q?xoFq9EY80zZA2W2T6mQJCtZuAVHNqHWQu3/SBDI6rDI4WhY9adw7Lc4Asql1?=
 =?us-ascii?Q?zWhL4SSqJxEnhXTzHSy+c/8QV10cRSSUaXDolrrtQosvqZOx+FcrY/1fa1US?=
 =?us-ascii?Q?QZOCbJAx5ADTJBpI/wbEGJ0zGzA6P9Y/3KayK8RZ2RuIenE7pcj8Wo+PgRhF?=
 =?us-ascii?Q?ZiqH9U0kIzhbCB7F3NRkatlpdP9pyOfcaqO0SYpzlgtfJXvCOMWE/pL3Cca6?=
 =?us-ascii?Q?I5G7sWom7qQ21XW/TlZfoZ1oZXIUtfgR4BOd4xhEfrBTMU/aR50b9OKUsVpj?=
 =?us-ascii?Q?vV/G6GyMmqnxIikMTTDtw9cIuxg3MH1KDp0FFdHToJHVDSBESjAvDQTvSFdA?=
 =?us-ascii?Q?Azq8ls6aS68+CPXt4T2Nht5mHnN8F1+9gAggzjJZrlJduPQtGjGONHD9+L8P?=
 =?us-ascii?Q?xxwTIt2/4HopKy2pXxm7q0Pju/5ROB8EnKqn4wXnYoko4CjC3CX8H+OYcdR6?=
 =?us-ascii?Q?LTaNsHHIPZeIpaXy8Ww/OO5h+7fuVaCqZ3qLumpEzr/toWrFPf7UZFrFCtlc?=
 =?us-ascii?Q?ia+9JwUSS0WryZSM2iw8AKe6tuyfGPELCDF5MOaE7GCdbRHwPBbhNNeYo+6c?=
 =?us-ascii?Q?2rB6uyjDqf9snUAWTKIkBN8fLFHOZcrFwk1ET1VzebS+CsMQvNGJMwVztr+m?=
 =?us-ascii?Q?8FD9lxsY0fzKaQ4meNq7BTncZvcYGELcSVp1HCAM2bqhtNdnHwy1kCLKy1rR?=
 =?us-ascii?Q?qZ4NSBBjbjTtx+9D34zACDPpuJROBZEQMEl6WAeJFE7VYjflkB55mgHwEzVf?=
 =?us-ascii?Q?EL1OPOmtgVesSwvHs8FkqjLLeTzfNFffJ/ixbFpc2Mm7dinRdk0gXXb4mAv9?=
 =?us-ascii?Q?xKPET9A7pKCx9FXi2iHgUBbDOQMQfjcWsp9oqmza5qwSOUtV1odoH6u4C0Fg?=
 =?us-ascii?Q?R760MlwBIdPuhPDD7M9QB/3B/QfNOhrhe2MbbQgEoLdneLE0gqsdffY22zUf?=
 =?us-ascii?Q?yTBJeR/iJUtB7dGaHHyT3FBbKb009PlquhPWMGmIHX6yjaV1nJ4FXgb+dC+b?=
 =?us-ascii?Q?ND0rs6gX4bBjjlOaULAvTd46Tl4me4N5Wgyro1efPpJOYseSTPRPcO5Cg7so?=
 =?us-ascii?Q?NrFZfCRyNIDDMtx85ugdmtd9B+TFWR15Kkbi+8gqAGyJbZrtavG55TbNQx49?=
 =?us-ascii?Q?dXRF2vnj2hRfaUiNnvzHEd6R4FRU1RfjDNpC0KDCeB/XzgqAipyIoByU+XMY?=
 =?us-ascii?Q?bOn/V/7+XmulSBlZ1CO75tE4ajkQn3flS02P+de9NRcLq6KJInAfPgAd4jkU?=
 =?us-ascii?Q?4QVhveAModCnF2c7ESrXRFT23jI2EDDNWf4YryrGpcTV43dZkznUEIt/nmv+?=
 =?us-ascii?Q?eqSiwA3F7pSm31TNfSo0Uk6vLQ54wWlsK4yCShxfxVj/Zy4gYzdlcX7kYMBr?=
 =?us-ascii?Q?TuxmVYqWpB1dZxKX3FcuqxZ0J9Mki8EqsRb3eyRZprxRqVZX724Su7SEhEnd?=
 =?us-ascii?Q?nE4yS9Ycx6DE5dl1ig1eUGd3uhW3Z3HfJQH+5Cpq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdf9e75-be46-4c01-8d07-08ddc04b0602
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:17:41.7190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxJHwhLPcSj/grXHl4LeFM8v0XRDUWBgIqdIuytTUVoSoJryMt0CfFKYZT7MMwkrNXK2vOlc/XvFrWj3HfCbPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11361

From: "F.S. Peng" <fushi.peng@nxp.com>

The NETC Timer is capable of recording the timestamp on receipt of an
external pulse on a GPIO pin. It supports two such external triggers.
The recorded value is saved in a 16 entry FIFO accessed by
TMR_ETTSa_H/L. An interrupt can be generated when the trigger occurs,
when the FIFO reaches a threshold, and if the FIFO overflows.

Signed-off-by: F.S. Peng <fushi.peng@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 118 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 5ea59bb20371..b4c2f206752e 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -17,6 +17,8 @@
 #define NETC_TMR_CTRL			0x0080
 #define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
 #define  TMR_CTRL_TE			BIT(2)
+#define  TMR_ETEP1			BIT(8)
+#define  TMR_ETEP2			BIT(9)
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
 #define  TMR_CTRL_FS			BIT(28)
@@ -27,12 +29,26 @@
 #define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
 #define  TMR_TEVENT_ALM1EN		BIT(16)
 #define  TMR_TEVENT_ALM2EN		BIT(17)
+#define  TMR_TEVENT_ETS1_THREN		BIT(20)
+#define  TMR_TEVENT_ETS2_THREN		BIT(21)
+#define  TMR_TEVENT_ETS1EN		BIT(24)
+#define  TMR_TEVENT_ETS2EN		BIT(25)
+#define  TMR_TEVENT_ETS1_OVEN		BIT(28)
+#define  TMR_TEVENT_ETS2_OVEN		BIT(29)
+#define  TMR_TEVENT_ETS1		(TMR_TEVENT_ETS1_THREN | \
+					 TMR_TEVENT_ETS1EN | TMR_TEVENT_ETS1_OVEN)
+#define  TMR_TEVENT_ETS2		(TMR_TEVENT_ETS2_THREN | \
+					 TMR_TEVENT_ETS2EN | TMR_TEVENT_ETS2_OVEN)
 
 #define NETC_TMR_TEMASK			0x0088
+#define NETC_TMR_STAT			0x0094
+#define  TMR_STAT_ETS1_VLD		BIT(24)
+#define  TMR_STAT_ETS2_VLD		BIT(25)
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
 #define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_ECTRL			0x00ac
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
@@ -50,6 +66,10 @@
 #define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
 #define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
+#define NETC_TMR_ETTS1_L		0x00e0
+#define NETC_TMR_ETTS1_H		0x00e4
+#define NETC_TMR_ETTS2_L		0x00e8
+#define NETC_TMR_ETTS2_H		0x00ec
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
@@ -66,6 +86,7 @@
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 #define NETC_TMR_ALARM_NUM		2
+#define NETC_TMR_DEFAULT_ETTF_THR	7
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -441,6 +462,91 @@ static int net_timer_enable_perout(struct netc_timer *priv,
 	return err;
 }
 
+static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
+					 bool update_event)
+{
+	u32 regoff_l, regoff_h, etts_l, etts_h, ets_vld;
+	struct ptp_clock_event event;
+
+	switch (index) {
+	case 0:
+		ets_vld = TMR_STAT_ETS1_VLD;
+		regoff_l = NETC_TMR_ETTS1_L;
+		regoff_h = NETC_TMR_ETTS1_H;
+		break;
+	case 1:
+		ets_vld = TMR_STAT_ETS2_VLD;
+		regoff_l = NETC_TMR_ETTS2_L;
+		regoff_h = NETC_TMR_ETTS2_H;
+		break;
+	default:
+		return;
+	}
+
+	if (!(netc_timer_rd(priv, NETC_TMR_STAT) & ets_vld))
+		return;
+
+	do {
+		etts_l = netc_timer_rd(priv, regoff_l);
+		etts_h = netc_timer_rd(priv, regoff_h);
+	} while (netc_timer_rd(priv, NETC_TMR_STAT) & ets_vld);
+
+	if (update_event) {
+		event.type = PTP_CLOCK_EXTTS;
+		event.index = index;
+		event.timestamp = (u64)etts_h << 32;
+		event.timestamp |= etts_l;
+		ptp_clock_event(priv->clock, &event);
+	}
+}
+
+static int netc_timer_enable_extts(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	u32 ets_emask, tmr_emask, tmr_ctrl, ettp_bit;
+	unsigned long flags;
+
+	/* Reject requests to enable time stamping on both edges */
+	if ((rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
+		return -EOPNOTSUPP;
+
+	switch (rq->extts.index) {
+	case 0:
+		ettp_bit = TMR_ETEP1;
+		ets_emask = TMR_TEVENT_ETS1;
+		break;
+	case 1:
+		ettp_bit = TMR_ETEP2;
+		ets_emask = TMR_TEVENT_ETS2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_handle_etts_event(priv, rq->extts.index, false);
+	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
+	if (on) {
+		tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+		if (rq->extts.flags & PTP_FALLING_EDGE)
+			tmr_ctrl |= ettp_bit;
+		else
+			tmr_ctrl &= ~ettp_bit;
+
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		tmr_emask |= ets_emask;
+	} else {
+		tmr_emask &= ~ets_emask;
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
 static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
 	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
@@ -496,6 +602,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 		return netc_timer_enable_pps(priv, rq, on);
 	case PTP_CLK_REQ_PEROUT:
 		return net_timer_enable_perout(priv, rq, on);
+	case PTP_CLK_REQ_EXTTS:
+		return netc_timer_enable_extts(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -632,6 +740,9 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_pins		= 0,
 	.pps		= 1,
 	.n_per_out	= 3,
+	.n_ext_ts	= 2,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_FALLING_EDGE |
+				 PTP_STRICT_FLAGS,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -664,6 +775,7 @@ static void netc_timer_init(struct netc_timer *priv)
 		fiper_ctrl &= ~FIPER_CTRL_PG(i);
 	}
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
 
 	ktime_get_real_ts64(&now);
 	ns = timespec64_to_ns(&now);
@@ -834,6 +946,12 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 		ptp_clock_event(priv->clock, &event);
 	}
 
+	if (tmr_event & TMR_TEVENT_ETS1)
+		netc_timer_handle_etts_event(priv, 0, true);
+
+	if (tmr_event & TMR_TEVENT_ETS2)
+		netc_timer_handle_etts_event(priv, 1, true);
+
 	/* Clear interrupts status */
 	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
 
-- 
2.34.1


