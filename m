Return-Path: <netdev+bounces-214468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571E6B29B7D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EB93A4DE9
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381529CB41;
	Mon, 18 Aug 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D3ZGuXOF"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37A2376EB;
	Mon, 18 Aug 2025 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503871; cv=fail; b=hzJls5W4p6s3GhouZNxBU5xzvE5Bw99PCt3cE4g8xH4pmf/4gnZ50tew2jLeL/Vxwd+sxDAxnJZ30H581hzBsymGqwnjByMHpyNcxEOiIA/B/+8rJp/dFUNfz2BUQjwbvzID1JIahSdmcfGlCH1Fna0a9HSdtppfwbfYAo8GwRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503871; c=relaxed/simple;
	bh=Vy2Hpdszoabzxi/81H60Ep8PjnqazVH3XV35dtRE6FA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z90+TROiTHL7J9u0CqyecsAGUqgIvlSc7sLtnTqzzj+zGi6qq+LI5N7MUsuEnxwSq6dnREIHYPIgsr+GLnu6ADj2/SBt8dou2O/cTWO0C1BI0L8DB9/VxCB/tS2cqAdYzCkeAnV39kIIdKg+hob2Eu85UeN4gLlyVSy2npfZe94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D3ZGuXOF; arc=fail smtp.client-ip=52.101.84.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjDzVz0XKg/WP3CbMAHPm9+aPMbG1Ex6ej5kXAeM8NjDMXaS7Sl4y+H0T2ZdzTVIIVwQRa2n7vXLgJoJgQWP5HQ+wVPW1yxnTKncMpiUAK8O6IlERs83sLUhO3PQzvyqn7PFgpMTLkC7RRWZG2xfC9h6dURxnilVZHdvGvsdCRuDaadDO6Y6o6tUL9SvuBSvTuAM1OcyUxvr2yJMGwphIPAm3cK83sc8iYnRbzEoDXtNLjCIfaX1Hvh6qe20I0OTZEV+sT4oyZjSpJLE6hqmbkab/f8QZHtY2+2UyvlgqV0e9YhsQMk3CMACypsDeD6I0fnS/dOd5mjW1PaLRKYY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwMmBU5/01WR99sZlSQOj2u7lESa06UXkpMFAV9+Vp4=;
 b=PPMNKPSvV/y88YXFR4JGehcZdLOi0zPQ7/s36o3XehkpjIUh1Hm6rHZf0ZqOaQlMJKU4iewelcmKsXcMF6hyM/u14CCG9FHuAw+vcls+Uvrwgkxzaf5LEBhpLBu4KMiVEA2UXmlEBoVdp990x0eZCbAP3pnZvqCJrF4JbS1NLtWYHsT9glX6vagj3oqN/UuJJi0ALP+sDwFjJPrSpY07zZHUaqoj9zoG6byZLyMB60qVZK3LQhElCoYBxlKuQ/Y/fPn9EjD3Q7wTmxFqa25lJs7+/uQeZtDd/CeTjV6PsVrR81i7EO09uP6lmABr9icGcCPrPC4P1tVvD+n58btMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwMmBU5/01WR99sZlSQOj2u7lESa06UXkpMFAV9+Vp4=;
 b=D3ZGuXOFVh5xDaZPCG4PMVHbQ+9O9Ifk1AMuQ624W+cIRprpKBETcWGFhXQ9HZWZ0Jh+TOi5a+84xjKfL8R0TyJdQyPNYTLNUMiMn9vHLQ1tZTG6kc4l8mAAU3lx5+mrxjsOoiyhCbDGPSexIyv5lGrkI79euUAiwPzTlSnHHlw6rVyDGGXQdl6HiMQRmqsXejDnJVIIDRIGG960R0339sdjDFC/BhFWNoocSubvkFQHTi0daRV0QII7avoyK6THnBfThvZv7kYabodUdiXAejeiSg/tpAz3PubnQaotJCxi1u9yeIAuq+evAEzzLeWqpUd4z5pwVX826dQCq/zEYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9144.eurprd04.prod.outlook.com (2603:10a6:20b:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 07:57:45 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 07:57:45 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: [PATCH] net: usbnet: skip info->stop() callback if suspend_count is not 0
Date: Mon, 18 Aug 2025 15:57:22 +0800
Message-Id: <20250818075722.2575543-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a872db-d0db-499a-3ac9-08ddde2ceab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j8HUOV+LSTyq6GaVMQcll1KyCu7pYFubrnygv9i/Wbdcy+zeiHmrytpj5GtN?=
 =?us-ascii?Q?MW7FpiXzRzgu6RmC7Z1xy8zaJa+7JjQnR2jLRRVRrR8Lkpni8XPGekRtESUh?=
 =?us-ascii?Q?3pazgBL1Zr7fvRhFyDXLOWuKj/Bc3YwMcrBJoYu5cnqD56a0E/Hs13prl1QE?=
 =?us-ascii?Q?ZgzyTmtfXQck6t+FYkiOTbfLKgkT5i9jCyGEyFQLKq9zA7Up96I3UMMfFQaV?=
 =?us-ascii?Q?l90W5f1sQpxkwDma7hOszbBtEp003vdpyZf/UnCEPpKifej3nU701yUZENoM?=
 =?us-ascii?Q?f/pjibQ7jLZfDEZaK8dD68qz5JDjC1ZuDazcYU5117RZwGnSF34PAI9qkZbW?=
 =?us-ascii?Q?aL6Q5KQiVoh8x5vV0P/kaX/z26ok4L4z+nckTlr/EKTM5UcRM32pbjrErmOq?=
 =?us-ascii?Q?/Elp31IYtZQ/RFsSBP7r1hOXt+QRucRUwnZRBRjB2sznDRXu5+JSE/34K2w9?=
 =?us-ascii?Q?KVG57fW6XkFCoY6k68boJtA6CsSMH6lFgPBOICq50IB8Dix9MkJ/T5zrIp2Z?=
 =?us-ascii?Q?o7xy0uKRiP/Fj3s9qqZGL6IFWvYZ4yxsjlGmeOcyu2RAjlyjH6zaFY2kR3LY?=
 =?us-ascii?Q?wL/QBFmAxu+Wvw4EAH+XH4ImLdN6a6vDUaJzarTbuXuP1V6rh+86Vj8LSk70?=
 =?us-ascii?Q?hkwR3qBxwD2rcMOSgCu7OVdbkumHi1jHv5HAU6WlHgfh8CuFkll3tO6/wxYm?=
 =?us-ascii?Q?kcrs11wiSYyNqFCnLMA59LrEEiUq1y13+Dn7notztTGgKdVwxxxAHlrfmgv6?=
 =?us-ascii?Q?xhx3AYyiDSSBBcdpDJ9b7Z5GgbfA9sWGbnhTwBGQzDgelZyX4b3NEAKmjd32?=
 =?us-ascii?Q?B5AOyX589iQRzcd8oQw8Ynbc03B8qCUXJ8a/MCGGYEYh19fSUpYpN29wJNrH?=
 =?us-ascii?Q?mGUDmJTmjEW/6ngCRwoW46hRrdI9/HIKWefzFKWeE5a9v/bxnUglu1uR+JcH?=
 =?us-ascii?Q?Wk4heD5v21Dbd0H7KD+6Mh0FN+KRNoBgawqII9hN63Vt30vs7DWrmdYNyQ4G?=
 =?us-ascii?Q?s/M74oKf7ma6ryvd8q5Wr+wDAxiYPy2UfjLLkWJHNcYVU48y8xEf7J49C1Ix?=
 =?us-ascii?Q?PDhU1ScLZfOQK0kT/AiWIqxYBmpbdSrU8v2Vh3eiJ9vSQaRJskOJWd2368H4?=
 =?us-ascii?Q?ZkaAy/mtJJTX2ONfhz9s+CvlcT52GV5aUkX3rjNdzddvmqC5ppYcjJ9jW8Ha?=
 =?us-ascii?Q?GTDiY2a48NQ/TJ6HCQd9hP78KqWX9+wc8Xyc5xXTdCXsUh3DTKnC8AJbEzGJ?=
 =?us-ascii?Q?hCyGaJs99lSjWDLkZIeAzVSRkbDNVUtMcOGe/igX2tlkubonnv7cyB8TfmKu?=
 =?us-ascii?Q?IG+ExA3afqz2Pu9wFXtucQUX06zEl4fA3253SzQ+0rD9g3NdPrGfe6Rk6lLC?=
 =?us-ascii?Q?unKYRFqy3T1E69xHmGUfrHzlpX29FUI7d9zExWEo1bGwzLYnqbAEZ2GF9chS?=
 =?us-ascii?Q?3QhrUOE3MtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XmGdHI9fdWzJGCHOVqAffWl4jlvlpNJFJ7wTeDz69cFCgJW3Q31MWZ6x2dqT?=
 =?us-ascii?Q?KIQEFD9R/u2SK9xwU9bso96v5eNB7eMbG2b4Yc9UgYGNe+qo7g1UFlEU1yAk?=
 =?us-ascii?Q?KRIPlWgPJr04H1jEyuW3pKoSTT7ztozKWy+lqje2SWDQ8L2Kjv18ksJr/3hd?=
 =?us-ascii?Q?dWsalAwmKgCLwM1XgQsEmfPO7/KAux0YjhsxIv7Tos2Aw4/4LS248x6trJYp?=
 =?us-ascii?Q?SoYr3zrZjwHomLcyzGs6BRhrnSluydiJgGgxITGXkkcKPiqmol5Yp6imMfeE?=
 =?us-ascii?Q?g2tAdA7qdSMlIpWsd0CALaHf8sPNXAXMhdQbe6aLi/OTLgws0JDGXtOu8H2n?=
 =?us-ascii?Q?dEFbg6YcQvHyzCLYRm2D/Z0P6BfkdyQW9WHzrZCRsa+Xnsl6kic60dGee4lS?=
 =?us-ascii?Q?kqi1h0QUpQHDnvZBhV7AEnwTbkHeu5eT/DV2SnuNPupP6cgWvzrSVfmiXXxE?=
 =?us-ascii?Q?vEDg3fPrTUl2eGVgEPML1K0XYXeDQynwxmdkHXukftTBb6ZalbKlSmwlICAF?=
 =?us-ascii?Q?Kl0oy86r5fR7LTCO1WDdmmU7Ge3uBTvv0wNlttoov2ZGb1bC65r/oSMZQ71P?=
 =?us-ascii?Q?GysFeeskWaCPjOX7vFBL5isY5kc1Aj2ckx8YP3w/HLQg78GdvErhpgn8iFN0?=
 =?us-ascii?Q?Q+DrGkThtVmF7jyFw67f4jHiF7lBGi4KNmN0RwYyUJw/VmeNnJqi/Y8UU+D4?=
 =?us-ascii?Q?Lxs0L9wh3nOIkJI8bTO4qf/41zU+guxRiPVYfZ4Mow9/l/5xEQg3mscPmRHv?=
 =?us-ascii?Q?vzAiGfRD8T2NBxFkNiQjo0WpnCvH/We1ix1BwV9JdAxTk8RxpeZ9/HeO/cJe?=
 =?us-ascii?Q?Gr3O+hI9kFhOFS6u0wSh6bp/M/lrUHLJs3y/EyMPBf/256j1uxVZDQVbddZA?=
 =?us-ascii?Q?8IlHdGTgN2egkMdCNM1RTpIbDVmNEXPCSH5ygAJ28yIa0mLjptL4XigMbVQB?=
 =?us-ascii?Q?VOE6AS8GgtHTBbiaVnY542nscVwOgiRgIhxyMGHASlsSV0M/wV35ElbXxJDy?=
 =?us-ascii?Q?OP3d4JDbzuUPP2ZYfkfEwe2Iyv+zxgzIRlbmQhHOzNZS9x5LG9jy9EJvy9Ev?=
 =?us-ascii?Q?hhDL8ysb6y9Cjz9euiQhoROWylni8wKcXem/t37fVVz7YkQWMF6/jWPghUgd?=
 =?us-ascii?Q?nZE30PVS2UShcuqjnRFC3BA/Xjf5q7NlHZdyI8l6j0z8Uzw3jXfgnORNenNw?=
 =?us-ascii?Q?iICLyLo/7irhixWw4pXHPF0dbabptj4tOT2M483ln7e3KnllzxCFeoHr0EWq?=
 =?us-ascii?Q?zQLHPbeEPOuRf8+2WAbwwwALfzDhAOJupdS4U8XqPbKUwtXbTjEVvGN5G5wy?=
 =?us-ascii?Q?zXNGqv18qASFI+xbSs1juOTdbIYi9YaFvKkn9i02Yn5XX+joKwiFpMCroeVZ?=
 =?us-ascii?Q?dCArXb9CDfpCiPPzqIRcdD7rPMgGFr6aZQ1UbCI6KmMyduN40Xly8Cf0183i?=
 =?us-ascii?Q?/D48GGHrLiaaujRpAYLHe9aof5FbMnW3NBBdiuASUjuScuv7fOX7116pX96s?=
 =?us-ascii?Q?ZSjgXacpFNLlOAaO1hztVeRKHq33FQbPflGCB4aO2DN5+sPGNkeyr+orGRaI?=
 =?us-ascii?Q?75G8GoynfEaK2tDpTvIMbxiTh4v8F0fvkXuiaW7M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a872db-d0db-499a-3ac9-08ddde2ceab9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:57:45.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNpAxLwvFeKqj4TB8QguUCZNgCk6WoELm6e8GvPFklg05Ti+w6m1oIhLygGU0p1ndQupJzIzKdmDYjvSa3oxDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9144

Once suspend_count is greater than 0, it means the USB device is
already suspended. Before calling usbnet_stop(), normally the USB
device should be in working state or already be resumed. If not,
the USB device may be already disconnected. In this case, we should
skip info->stop() callback to avoid abnormal behaviors.

Closes: https://lore.kernel.org/netdev/20250806083017.3289300-1-xu.yang_2@nxp.com/
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/net/usb/usbnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 511c4154cf74..27642b76a3eb 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -839,7 +839,7 @@ int usbnet_stop (struct net_device *net)
 	pm = usb_autopm_get_interface(dev->intf);
 	/* allow minidriver to stop correctly (wireless devices to turn off
 	 * radio etc) */
-	if (info->stop) {
+	if (info->stop && !dev->suspend_count) {
 		retval = info->stop(dev);
 		if (retval < 0)
 			netif_info(dev, ifdown, dev->net,
-- 
2.34.1


