Return-Path: <netdev+bounces-216236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6947B32B86
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733935A8596
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA212EA175;
	Sat, 23 Aug 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VWvdjCxK"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882381FF1AD;
	Sat, 23 Aug 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755975715; cv=fail; b=o0M/s5KafIFr7Pqa1z4NFy1ENIUMYsO5CBoY8/rawiuR2LqheKtroIBJaWG6vcyYrUX+/5mZP/4TxRkfiwMTX4TY7n1J5aad1hUXen7GnEp09sCM3kbviBpMrb+yzt21Zt3/dQlaBQIcQ1+Pbh0imQEjrixTCSHxtWWp6HmEvPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755975715; c=relaxed/simple;
	bh=VARuYgElrUyMokxUsitNWETVC2WYmIgQ70PoW3SdHnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WcPidRZF0R48iOm3SFcWFwQhZ0HpKhEsbTTM0ePLpTo85ZLPqlCEQRzjj5BBI4DdULNhLgZhGyV+mtyIeIsFx5Ry3duZIds81HGWCBZEbTEod0FQNAClu0WPAB/3aT+GhTrS0dm45sL7X8jDSlZ5gWshV01MMVB4mHV7h/BuWJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VWvdjCxK; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ+ZKPGJhBzgYo6bYpdwJbTF+h/uViZ7XkEEkFATU+xgm3Av5VrCwSM6xJthLktf6OEq+aF4y9tS13q0QvmCnOT2EQyEMkxoGYtzXIDgigkpITJQUE9cIXdVVohS2DkmY1MMR0ai5f8pM09l8lZhXXZfcGHPa2ZyDR5I8AY8jvdneazFafnGYOg3oQ6cprTM6Cg5kGgaETZDLmJTLbAv+4zcCM7eWnIhiTiiPrKuyxwkbuFGBk90hNKeMXR/NmLJwcLgVQc8lmvvk/5mloy6NVsxMaBRMjIbUvuoUNYWUAdGTWdWu//LYtRgZAmITKzD19/SrDhNv3mlbzBJoE0q5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiagW6D4aGpx1PhusPKbLii1IuJtF0WG3h7RbsZyf4g=;
 b=Ffaa8aQnBUEdN/U9tx+GMeXmRJz3tscRR4Z7+oFjIessBP4WcFjV9enuEgDhHjM2a4tWpeoFsji75zeKZgQ7mm7L1epYUZeWBaSmT/cST/fC5WW2OWUetMuiOyU0Mf7Y1ASKw96mG/DRICfmmvrc1T4dGgALaEeGTAFi5JhLVBn30q5ri/brmbyjKWW34M5R6hAt7IebGRXbbC4dw+0GJyQo4co9YZXw57XgMo7Zi1Aw7br5tuIR0AMxaEoXKWG/PB6yqRgeBCR3vV54EF6MOCKVNstIiqZWTGbOW7Z0BTxgBYkJXRAAcnLDPe3zRj3mILddWynPRuvZpyIoPCfhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiagW6D4aGpx1PhusPKbLii1IuJtF0WG3h7RbsZyf4g=;
 b=VWvdjCxKO/ZDUYRpsR1W2NEWbg34PJ1F3qug01oKu72RnHe55x1nIg2D5ytoguA+mk0LY1rKPbiCt54spk4XkuYAAfEqmxK9oPJ4Fl6rbMJ1o8a/y5xBakaSA4num/HO2biTwPFjFPYOwoHQCXUAFYoaahai3gcyW+K4KHiHliwpbDGwYwtIn2uYtHvGSu1Y1tADJqJHq91cVaY0GyxkzkUIIRGuypudl/IyeQpJeXyv7Ctd+KMgF6vlcpr0jpulEFNGQlTeiT5VXN0RcJcVDEOFjUy89Og9iL1RqEnlcpKwvWThEkSmUHlYZ7v8y52W0utYEzl3oHGgyff21abkRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 19:01:51 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 19:01:51 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v3 net-next 1/5] net: fec: use a member variable for maximum buffer size
Date: Sat, 23 Aug 2025 14:01:06 -0500
Message-ID: <20250823190110.1186960-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823190110.1186960-1-shenwei.wang@nxp.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:510:e::9) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: e86b5234-b254-4646-909b-08dde2778503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hdz5pmz1JZYo2G8hBehGcIIYF2f6AbW2CeGBPQd3m/Z2zGAcjIWj+iDapBZA?=
 =?us-ascii?Q?Ur+NuSk3mJyyv865XFnP6u9hE8KZhUfI32O88XwT25zdG+YOliepLzy6Cfc3?=
 =?us-ascii?Q?a9137za+kw2oI8us0eZTAJzgQU4Us8tlNRVtEkmTnv7BdlD4ffUPgZu0uFri?=
 =?us-ascii?Q?xgUyRgK9ch86422Bnib00DltWPt8GsLtggbrUq+UDXehRGmLUXfdzXPfrJcn?=
 =?us-ascii?Q?m4EUHSe/DY27NxBZvFvPNdJW1IzleTd4m4TTkRhBmj1DSG5XypUkmTLeelxx?=
 =?us-ascii?Q?pS+4AfUqW1SmuooWCPzXDPnaYLFOobEfG+Hhv0OnHjzm/IcuvY1Lcs+CpT5J?=
 =?us-ascii?Q?t0w2hbNtbZk0XtmHFF2REoSd4BsoeiKEeumhecA4P/y35mbusSDxfjVHsGu4?=
 =?us-ascii?Q?qN0SObZiv52DbJ3rhs9XL6+JI9Srsph4U6KSG/LvFcgZTS0xctdVoOj+dacl?=
 =?us-ascii?Q?u+brlmsILyMGsu9ue6SqRo9FhHUGTo1y9xIL/nus6cFF4gp567CVSHZSe09M?=
 =?us-ascii?Q?BeRhj9UeCUkwjZu7Jg+rENQGLA9ZxZEmyArraDWbBb+eTWVtQCCpiZVXSy+m?=
 =?us-ascii?Q?AQtSqYjZW6Ov1RRXcqmo5WqY2XucAdqtfzIbt3Dl2/u7Sgy5RK9F/1PDjre5?=
 =?us-ascii?Q?a6wwbLmsS1dX8xDOFDIZAdiXqk8hl6FeyPO9iZNkrSv3n/keMPAruXa3/pwI?=
 =?us-ascii?Q?tEOwwB5SieJSwKXRY4fvfRJZQEtV73sKnVkD4ivEX5fsMJZvWvrM1DTTFmtF?=
 =?us-ascii?Q?oNG0tQmadCRxo45ZyScTM3LOyiNFWg4npTkiACMedgqXut0pxs4wzrYLaDLI?=
 =?us-ascii?Q?eiKBxMIv7LAwowuPoRU2UIDlCmy/VMEFbYMpzYUm5FufWyEew5YftEu0UBYc?=
 =?us-ascii?Q?uVfBbfZ0LwlrGxWme8KgYPEyhwutIIhxagiJrq1jpenvqVcdIrTD5nDWcslc?=
 =?us-ascii?Q?Z9F9fD0W6JSbeAwaTLAZ69Q99C7nhk3+IIewvFlR9hduaMRSYRg+VSXUMpwJ?=
 =?us-ascii?Q?pn1CvqXV4d1RHcixc2tQMgZVdQKEhaUGbfkehzkfecQo3SqsG6xBvS2ERav6?=
 =?us-ascii?Q?iWnMiuKVtFvIuI98PHHMogCmWDvXaIcFmzEOQ9xX+FO+PcSbx94WXIG7N+4q?=
 =?us-ascii?Q?VqMXKyFki1EPvi9kzekp/K7T8JE2Yb4dqvp0zpTv7vrOR7u53TOwPUa0KXXN?=
 =?us-ascii?Q?0y+GrIVkKROl/zBKFAzFh8cqvDkncMDAoeSUZAkExDw7nW4TWuD7u6j1M0UQ?=
 =?us-ascii?Q?Z7BpSyKWT/yCnTx/WJ8h4GCKaKTmXmd5hFeQ8akuzs9CEtX4fehP+/ArLvbx?=
 =?us-ascii?Q?fMrrFA7DikFG3Sboxp4Jq77dXMYEBlq7/uMRDvzOY0qewFE5sbv+nNDgIlPu?=
 =?us-ascii?Q?RZa6eZOqETwdk7mMQJLA6qNa0kc2F6w/TRrYwgnRFJlV3MAR5lDjAFR7+tU3?=
 =?us-ascii?Q?GHVvHb0b5II9P3KrJj5tD4wlNJTOnvP7wMjDAO5gLHjkIpIIGYBj7cB5a7Y2?=
 =?us-ascii?Q?1wf2pJu69X4Ndd0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HGG2+YfDbgzSpDKjxJ/5nFDV6MFDcJKE239kgj7oV6+dWNbZytn6x+mC4Rjv?=
 =?us-ascii?Q?7o1E841Kc87QdDnF9WzpQQlCSDNpxONjOG5GWoKM+U+/Hh2eFq+cqBTeyJAC?=
 =?us-ascii?Q?Wko0fNWnqc+ORdDzeit3Yeh18TVj2Fy/ZEpwHWDpq7ffyJBWowxH7x7Y0dxt?=
 =?us-ascii?Q?+gm6B1nAcgfQueSeyNRFjyvVZ8DjYXKU2Gov5PCXj70qR0ePVYtGBlCp75xW?=
 =?us-ascii?Q?xK2PwN4nO5j6twgtSHE5Zn/J1xu04aj0tIaMXhsH6ASqGIibfH3qqHEged2a?=
 =?us-ascii?Q?WVqpl4N9XIx3pQ/yNKARQUDqx/q5vOYXTS0QYAzHa+oUgFcYBeE4sCJsyQJ0?=
 =?us-ascii?Q?cTdDqcgXkd6MVwkz4jPxlBSEcjJGSFFzGfSn7mx9uv4DkvugJplGHhfI3D1W?=
 =?us-ascii?Q?wuWu+iRJdzbiwetT3HoCwWM5mZ0sRKfYTUXcwcrZ9QhL9r06kCczmZh1fpNT?=
 =?us-ascii?Q?iWjHEI50Q2KvSO3eCxr2TXxcyYpuxfmTW/Cr8x0oQnJNqBsRAEmypgQbheuo?=
 =?us-ascii?Q?Ro8P9ztzwmK84NvRfOFvrAgBLhLpNmPA8QkKHblLrLhOfLkly52AgzoZpQee?=
 =?us-ascii?Q?s0vLuPgIkAf06TpRE5IyGBzpgAPYaAMrWNII1DlQ8t79s0m0g8vEc+sIBC7W?=
 =?us-ascii?Q?EfGsO59jLMrkfNzkQFzm2RMS6thCDPFUGH7EYW8NttRU/+SvscgA4BVO1dxY?=
 =?us-ascii?Q?uGcoKC+e9flLgu4ir9ze4zJIR/jYFFrRX3Xxit40b6PN6diO7bOUou/xelKf?=
 =?us-ascii?Q?yHqGmVsCeTIGzeUwfaBbYWrd6RBeEN/PwiG1OeaZkZgjIwG8R8FPNBnV8N5W?=
 =?us-ascii?Q?SbfBDyqiHiByA79z5wp/l0udt5UpQPLyyKw3+/GjXdPwwsxz/SQ0ROa450Kd?=
 =?us-ascii?Q?Q05cvZdldPYEEFQTz0fbknkfFFMRqjIwjTm7OvE38PxmREofx62oYzewkjhB?=
 =?us-ascii?Q?+VM0mTCEf8hOkgPMO1pp43MuodLbartUYZLdjJSP1j764zopxWITz8yX42cL?=
 =?us-ascii?Q?ZdoheSoididFCIYFAnt3Loq4pKzhGzaR1whG8NNAJmokwSLBHNWaoGFhJkcx?=
 =?us-ascii?Q?45i7viRZxeUqlb9EenXW0mGb9Vg4buW2C/arKNPKSXHg4mUntmJmWMEif4JS?=
 =?us-ascii?Q?dtMZRIl78QUznKyFW8tPgb6oXv1SswNJtE9jRomKkQpu3/9mLG/6o1zvXWGt?=
 =?us-ascii?Q?w6SdBp3qE/tjHIF4GcpRsGOJh1Vp+xeO0YSDDi8dlb9M2udaAdMq2yAnoJpt?=
 =?us-ascii?Q?xvPF+nMIKa6RoT2fAxFZZWrkBqESDR0pB+WI/JQp1ECGDIY4cC1cQbhJf6bS?=
 =?us-ascii?Q?a9UihGxPFQ7vIBhfS2hYSQrEgvW12VPnZF1HG6P9+Uia4fhUkfGu6IPlUfYd?=
 =?us-ascii?Q?oy5ayG3lv8qZmiJwnbsY9OO4C9R4JeaTIyLliC3OlJwUya48aKk7fseGAigZ?=
 =?us-ascii?Q?qvWOOBttah4LPm4LdeZldU88YojYOJFwQPc+1wn4G2Oh3n3A8u6GigVo2IYo?=
 =?us-ascii?Q?gJ+4hsOh33oH5f7Xd4x9O+yxcPVyjJkiWmKk4NPHdINFMtTii3qOxzxnO9sT?=
 =?us-ascii?Q?5MvCiRWiVnJaKre1xMuZPrIP2fOKSIPsBATw8mn+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86b5234-b254-4646-909b-08dde2778503
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 19:01:51.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOh08YeDfJa8EmSa3Epql3RyVNiXc/o/lIzoWG6jAXqC8mjBHGtbRdug44w8Wanrhmu+PamuykkdlONBuFDL2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301

Refactor code to support Jumbo frame functionality by adding a member
variable in the fec_enet_private structure to store PKT_MAXBUF_SIZE.

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5c8fdcef759b..2969088dda09 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -619,6 +619,7 @@ struct fec_enet_private {
 
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
+	unsigned int max_buf_size;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1383918f8a3f..5a21000aca59 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -253,7 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
     defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
     defined(CONFIG_ARM64)
-#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
+#define	OPT_FRAME_SIZE	(fep->max_buf_size << 16)
 #else
 #define	OPT_FRAME_SIZE	0
 #endif
@@ -1083,7 +1083,7 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	for (i = 0; i < fep->num_rx_queues; i++) {
 		rxq = fep->rx_queue[i];
 		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_R_BUFF_SIZE(i));
+		writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));
 
 		/* enable DMA1/2 */
 		if (i)
@@ -1191,7 +1191,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
+		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -4559,7 +4559,8 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
-	ndev->max_mtu = PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN;
+	fep->max_buf_size = PKT_MAXBUF_SIZE;
+	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
 	ret = register_netdev(ndev);
 	if (ret)
-- 
2.43.0


