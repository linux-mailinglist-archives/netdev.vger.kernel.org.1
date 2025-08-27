Return-Path: <netdev+bounces-217175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FA8B37AEE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6026822EF
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC7314B8A;
	Wed, 27 Aug 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bR9eyrdF"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0F314B7D;
	Wed, 27 Aug 2025 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277713; cv=fail; b=XbI9TTtaUTyUqs2LB84jhCxD2O7ByZkd7qNSu7EVUgi+A3CllZ8bZy2eV4NeumusDAjmGOY6/yQBAZ6JsdTqs2S+hPf/j1R7EALRYdF4IHkaruEhvb+tH2dOi5qbLFcSk1vwlMsPPDrUVcf1fwjn9GDsKOehUw0M6DMmkP8HZHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277713; c=relaxed/simple;
	bh=+eL/Nm6j1hcb8rF3gfXMdzBQBQbR4SQLxw5aEIhCNzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/xSMDuBK6F291wxvpuYSqBx//j8xnR/bbee7o/GXqNsvdHk9LBj33u7J6mCpx+tSfzYzcw4RenxRJ3B1d3uGpEX7CSsTaD9qORRwyU7cydVvxkG+qEvJQQ6NeJALzuzzMq0DtiqhV4tyaFVpMFtAQpiZ2Vc4s6I8YXcl3fWzVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bR9eyrdF; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4XwaPBmUZDTqQd9gwRA7u3oyLeyT+L0jSvsjPZMRtA7OX9YRyluVKhlUDlfxdAFJNr8V/3ZWyGSl6f8okIqpPyYnD3HDMgfHfTlDIv5HokVrHEwGzgb5gxw6J5rDHZ26YXBC+Egize9vEkNol+BCwTrH0CQibq85+HDfg2kZqwdQmA+TN3t8yOd3/fDMtrRVX/Hm+JeuH1o4sAvn5hqvf48y+qpwAy0Qr8d02SU8sHOoQKBSZ8/0KE+y+YMExykjnwaZY+d7N12yDhMo+OoC8ihwMmDfpvByb3f/lwqxsCDhVhU4JUs8re4DYhEm5+atfxylywXdj9lxH9LFs4zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBMkF+boKbT0owI8NmRSpuPaenL3b6ZeliLOIgLVOyg=;
 b=LI7BgBPQ+yOhnCgkQk/G762OMIxGVSCg9azqABKtF304+hfsB1JwQOFyesU9YYE1DqPoSFzirxkW1rnNX6fF/1L+g8kRiT9k662Opu9xuXOjEg12tUNT92ZuovE7onwn8j7OMhWqfrBrWValm+rbXb6NT1tnhaq3NWUaNYPlMkZWOvh8ZXZr6JvPLqOrL7awFwKio6BocDDsL3WFSbXS+eLBgSFtWGEcFqqUGgln9LUkwisVFYl2nuXJvV9SYcNgBBXYVvShzke5wbM075e9y7C+VBh6iamxIGYEh82ErJxEmzq/gBvxlFBnfV3ARiIL2TpeRJu+//eN/pE0h2QJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBMkF+boKbT0owI8NmRSpuPaenL3b6ZeliLOIgLVOyg=;
 b=bR9eyrdFx7BjjMrLU0MDERcuBRFbnLaLKL7IFoV32yLKUfPUUM3QoHQsnqePo1ZXvboVGAr2N/H5wTLRejdVgDAHhSzdhs5qF0lZBzC9zA4kUc6/kDaQRpIk5AIvMrd1TZQmgzsC9wSwLxa7l6V2RO5XMnc33B7O1h0VVl3uqMEhS/hP6A6PGS05ClA6mwr/uo6rPZe1B6ywDyJvNU/NLLTBrvjYfi6P0DjKbBmvAPMNZG7EJn2aHmCJEnvhcvvkWu+hgMWD9GM5RgSNkOTtFszcBNLu1Jsce70jFeBGtYlcg2buYbQ3R/v/8HPj75kdRh34d3kHjBeb7UDEuzdW8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 06:55:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:55:08 +0000
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
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 03/17] ptp: add helpers to get the phc_index by of_node or dev
Date: Wed, 27 Aug 2025 14:33:18 +0800
Message-Id: <20250827063332.1217664-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a8c9ac-7405-4220-a153-08dde536a8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pzv6/Hz5PZhWWCJW0Hgz7VGCmfb4am+sl8l87Qf17FO5//6DkEiv1YW9Ya9S?=
 =?us-ascii?Q?D7I9J7e/4GFRQMT5M3A1dpRVh09JnlZIELj9BN+gsaCcOn05MW6Fjel2X3+h?=
 =?us-ascii?Q?mcR0n0IuMTuHTsOeZ5yxl3SFLJ2kN0JcMxOur3oKrzzOE32bV9+O1TVAMbfC?=
 =?us-ascii?Q?ssplY2Oqy/HSem2CRm95JXcaeD0Gdc2rSQUymLUMznGxj3Lb/WSM6ThDI0S6?=
 =?us-ascii?Q?3e7w0jix6ZhL26c+6nFOxYCeLAfITDjrn1HRFJXBlFc2uINbQwEr3rXhoav+?=
 =?us-ascii?Q?6nd4ZThX1G0wBhRbAv4xAqaekF8Dc9p1bVpCTG3whtGMA1amKK+zOhEO9w3T?=
 =?us-ascii?Q?tFJUSCKvPdQp8w9phP/iLewYd3sWkHMHRAkou1zM/ZyyC07bjAAvaeqtOV9l?=
 =?us-ascii?Q?FIcacFms9OOr0eOhzRx5A+gKm+DU1S6pdhxhbEEIjZUn/N9VxnklQB49SV4p?=
 =?us-ascii?Q?bDFrfHG7oqmIfV6N0XSk/EvztY8HT+AtUq+tT2A9HlZ8tlj1pl1J4q/q5i2W?=
 =?us-ascii?Q?SrREH94FdoD6OwhIlDBRiVll1u4JioAykBW5f1NT/hVUSsKZwgxSWDUjhfpg?=
 =?us-ascii?Q?BWESThH9mo+9DRbyskQ+3fd+6SFCnMQQGHBfkxo1IwrT7VuLO29U5uK+PO01?=
 =?us-ascii?Q?075YayIpICRx/uWwP3OKU3yZLXfpSsdtLqTb165JpXFeLbNC97sO/5fZIFXU?=
 =?us-ascii?Q?Oi3vvz7ZNvlnVRS8TBTYn+vBmfZqbjyg71mfcI+lL4yvOUYOUCdrCAvhxJSt?=
 =?us-ascii?Q?areutbZmCjRK4bGfeaAr0soP5dq6VXyijB1e2o2/ttgsendW4JvOtPPPfsN1?=
 =?us-ascii?Q?7kNokpPZuILoR8cENFZqEJD2yIx878+zCfvO3/kDe6pUVmsPY5/yHHic7Sey?=
 =?us-ascii?Q?40IjomlipvE3KSKdw0Wizi8N1k88HveQPlhpW7JMX+8tLJ0rIk0X0Vg79SUW?=
 =?us-ascii?Q?xFRe4waFtMHZVzbBXNliRg49S6W2xYUAaihBwBzWgrlpu1WoT9MHfSKjlff0?=
 =?us-ascii?Q?f+NYrWoeE3vEt/FnPIxiD/3QA7iz6UGrDpN1qaJkbU6tpYWTor1oVJRdyX8c?=
 =?us-ascii?Q?UuYrDFWoB1oce5oUqzbFzIdTEVKQW5l8W5yZtVXbgUhQn3JNqD4rr9iuq4oK?=
 =?us-ascii?Q?WGyH8rs8TSHAebscRzpBKdHzGNrvAzSfxyXjv830NrP1Yo7il3L6IYyoGF6W?=
 =?us-ascii?Q?2ZPfAZbTMCSM35bhZTSNiJFWyiMqTCLVl2FMX27a6c4RcTFTUEusHJntSiUO?=
 =?us-ascii?Q?V7v80WrMswKEqINVC3jTx6VVLsjumpvx3Fk/ERZcF6DmHtoHaq16U0ecBFg2?=
 =?us-ascii?Q?x6DR7VwpK2KqkGJXSIZjz6hUzWL4LKVAPD3/91ibuB+WD6tg7e6bvKNmsDwd?=
 =?us-ascii?Q?FZs9AXh59uOODOApLI8RbIjv1a7EQI2lS9lsQaO2jntTojzlAYG5Ey36/UCG?=
 =?us-ascii?Q?79a0foeVu3HmayhiXel12xctRc8+AKdvJxyD4Nogt6C6yVb6JMav2xu2EknG?=
 =?us-ascii?Q?/eWcIBF4Yx6MrP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OdB4j4S++HAepx2Gx4xjJmlVESvdquCDtKTIstt8K93sGbVfKtsKuSwRvan1?=
 =?us-ascii?Q?AaTTcTVAanjc7xEn0omktqd3tby9PpCOpUJ7UHBiG8fSuXRTGgxOPjs6Ph9M?=
 =?us-ascii?Q?31klKvGl2Qkbs2W5oxeiXxati6y3WCLNrYRo0MFuk/Trh0MKG7RKqxJu5lRY?=
 =?us-ascii?Q?pWTSinZ7a5jIDKt12xCVnB+WcvollT1FIGELrVzHo7v5iKxwPbvf7MsG73PF?=
 =?us-ascii?Q?fnrmDDTFerEZ6ag2zmN4/jXe0njDfqYf1CrehGe+FQgne0VU6GrqUGllKqx6?=
 =?us-ascii?Q?DBfUOnQ2TgYn5MqWQEPjTV9nUn6rMUzho79ARvObrW/Hou4PX6V+2paWQe9i?=
 =?us-ascii?Q?6MQTncrlosWudB7t9Rv9xng8VWZyPGX5Gl+i+0kFB5ns7RpXxSpnGKsgiOXb?=
 =?us-ascii?Q?b1fziiBZElsUT5pLNaGyqnhIkv74Y14vsDklM7C4Y7a0TLb2PUYHzMihKPoB?=
 =?us-ascii?Q?XDkXJe7jgx0jFXMa/p73TCJa3Mzcd1JnllKEUxozkktEUHSU62FDblEeADyq?=
 =?us-ascii?Q?bp4Ri5doNhuSLzcFFsuYfAjGghviQYe3ErY+FJyF9lYHIEuN1bzFJAmdpr/V?=
 =?us-ascii?Q?QOYfnxEKKikS4WZYTXX1Fm94BZxYzffsCMQMAfgowDBqZ6eG4tJXdPxql7mk?=
 =?us-ascii?Q?l3KXRpL5bnpwS8/04SVITjlv2xj8LPHyc6Av6zoBzD+Qd2OpoqNYbcXfbiQ9?=
 =?us-ascii?Q?9YjRzWKGVbvlKDqG3LAwksGsk3XliKtexKQE+YmCP1Hur5/bFJHf8syHDPmj?=
 =?us-ascii?Q?hwVYMGwB2FmxjVCote/uRN1x3o0EUamiM8cbB7l00isX34DJpSWYGZ1IkXOo?=
 =?us-ascii?Q?V/lqI2/ESKlkmw/0ulZ9D1g9WY7Lv0KL6VOuqa2jdrDP1/h5Haz7OhAaIL3I?=
 =?us-ascii?Q?jQFIwlJ5QW4CMXCPnrkXGKhTooRMz2u4Oc+xHRKMMJih4SLZ9vL1GNw+BORZ?=
 =?us-ascii?Q?Hw4fWJS2pQVyoUS/35ng4E5VrLdIFvKfiPdemanYFdy067BJrb1RlEGR86uG?=
 =?us-ascii?Q?gB6myQloCJJO1+oxHRORU9CKqL3iGIsbgK3SnAmHLUXNyUQwW31HQ2ueCkOh?=
 =?us-ascii?Q?8IBErZltfFFvm6jqyP8CpbwwtOwCqL1JkKh1gaEkPUDsHfChfciv6BV2OlYc?=
 =?us-ascii?Q?TetZEO2an0y/VpHj5SDt8evckLMS4nRlhXuaORve/UHtTkuO45Zar0QfTzhZ?=
 =?us-ascii?Q?wEZqCvKWSHEHZmiyde8tKts3CyQmz4YA6Bhl2msWge9liDabGYQebgQnMIP2?=
 =?us-ascii?Q?3qM3n9+z0EomG6UTf5T/spF0j1T196d9xpkrX6zoHLcO8wPrV78FSF28Jn/V?=
 =?us-ascii?Q?wbBz0Q4rwoxMbkb2VLA6KsQRcZDdq622DyP4ZUXzq7niUAziUN5kP6soIyT8?=
 =?us-ascii?Q?pHs9fj6b7pdCE2UwbJrvBwGhS50igXOUG5OTDqoWew5SDEQkGSY39IDG23e7?=
 =?us-ascii?Q?Hti/E14WUg0oSFHScaJuNl/OWPbzgRd30/LrH/wNMHWphly0+Z7iZq3YI5XP?=
 =?us-ascii?Q?gG2OcIAkpSr7BJCssRhDGrj4sN5WyHPhSgzCIKjFtVpOTd1Eg9Eit96iVguL?=
 =?us-ascii?Q?DKhXs6cZZB6Bevd0LmbUdkcX4GZt2N5Sv38rXTO3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a8c9ac-7405-4220-a153-08dde536a8fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:55:08.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szQDxQpi9BYh1FjX9IC+OVV4Ry6614PFnEd+1WxImUD4Y/Qh/JSXAqDnhAbGTvFjqrhWvNLIb8S2UCwmtvVoSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449

Some Ethernet controllers do not have an integrated PTP timer function.
Instead, the PTP timer is a separated device and provides PTP hardware
clock to the Ethernet controller to use. Therefore, the Ethernet
controller driver needs to obtain the PTP clock's phc_index in its
ethtool_ops::get_ts_info(). Currently, most drivers implement this in
the following ways.

1. The PTP device driver adds a custom API and exports it to the Ethernet
controller driver.
2. The PTP device driver adds private data to its device structure. So
the private data structure needs to be exposed to the Ethernet controller
driver.

When registering the ptp clock, ptp_clock_register() always saves the
ptp_clock pointer to the private data of ptp_clock::dev. Therefore, as
long as ptp_clock::dev is obtained, the phc_index can be obtained. So
the following generic APIs can be added to the ptp driver to obtain the
phc_index.

1. ptp_clock_index_by_dev(): Obtain the phc_index by the device pointer
of the PTP device.
2.ptp_clock_index_by_of_node(): Obtain the phc_index by the of_node
pointer of the PTP device.

Also, we can add another API like ptp_clock_index_by_fwnode() to get the
phc_index by fwnode of PTP device. However, this API is not used in this
patch set, so it is better to add it when needed.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v5 changes:
1. Remove the last paragrah of the commit message in v4, which is not
necessary, and collect Reviewed-by tag
v4 changes:
New patch
---
 drivers/ptp/ptp_clock.c          | 53 ++++++++++++++++++++++++++++++++
 include/linux/ptp_clock_kernel.h | 22 +++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 1cc06b7cb17e..2b0fd62a17ef 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/posix-clock.h>
 #include <linux/pps_kernel.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
@@ -477,6 +478,58 @@ int ptp_clock_index(struct ptp_clock *ptp)
 }
 EXPORT_SYMBOL(ptp_clock_index);
 
+static int ptp_clock_of_node_match(struct device *dev, const void *data)
+{
+	const struct device_node *parent_np = data;
+
+	return (dev->parent && dev_of_node(dev->parent) == parent_np);
+}
+
+int ptp_clock_index_by_of_node(struct device_node *np)
+{
+	struct ptp_clock *ptp;
+	struct device *dev;
+	int phc_index;
+
+	dev = class_find_device(&ptp_class, NULL, np,
+				ptp_clock_of_node_match);
+	if (!dev)
+		return -1;
+
+	ptp = dev_get_drvdata(dev);
+	phc_index = ptp_clock_index(ptp);
+	put_device(dev);
+
+	return phc_index;
+}
+EXPORT_SYMBOL_GPL(ptp_clock_index_by_of_node);
+
+static int ptp_clock_dev_match(struct device *dev, const void *data)
+{
+	const struct device *parent = data;
+
+	return dev->parent == parent;
+}
+
+int ptp_clock_index_by_dev(struct device *parent)
+{
+	struct ptp_clock *ptp;
+	struct device *dev;
+	int phc_index;
+
+	dev = class_find_device(&ptp_class, NULL, parent,
+				ptp_clock_dev_match);
+	if (!dev)
+		return -1;
+
+	ptp = dev_get_drvdata(dev);
+	phc_index = ptp_clock_index(ptp);
+	put_device(dev);
+
+	return phc_index;
+}
+EXPORT_SYMBOL_GPL(ptp_clock_index_by_dev);
+
 int ptp_find_pin(struct ptp_clock *ptp,
 		 enum ptp_pin_function func, unsigned int chan)
 {
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 3d089bd4d5e9..7dd7951b23d5 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -360,6 +360,24 @@ extern void ptp_clock_event(struct ptp_clock *ptp,
 
 extern int ptp_clock_index(struct ptp_clock *ptp);
 
+/**
+ * ptp_clock_index_by_of_node() - obtain the device index of
+ * a PTP clock based on the PTP device of_node
+ *
+ * @np:    The device of_node pointer of the PTP device.
+ * Return: The PHC index on success or -1 on failure.
+ */
+int ptp_clock_index_by_of_node(struct device_node *np);
+
+/**
+ * ptp_clock_index_by_dev() - obtain the device index of
+ * a PTP clock based on the PTP device.
+ *
+ * @parent:    The parent device (PTP device) pointer of the PTP clock.
+ * Return: The PHC index on success or -1 on failure.
+ */
+int ptp_clock_index_by_dev(struct device *parent);
+
 /**
  * ptp_find_pin() - obtain the pin index of a given auxiliary function
  *
@@ -425,6 +443,10 @@ static inline void ptp_clock_event(struct ptp_clock *ptp,
 { }
 static inline int ptp_clock_index(struct ptp_clock *ptp)
 { return -1; }
+static inline int ptp_clock_index_by_of_node(struct device_node *np)
+{ return -1; }
+static inline int ptp_clock_index_by_dev(struct device *parent)
+{ return -1; }
 static inline int ptp_find_pin(struct ptp_clock *ptp,
 			       enum ptp_pin_function func, unsigned int chan)
 { return -1; }
-- 
2.34.1


