Return-Path: <netdev+bounces-205722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D47AEAFFDA2
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86237BE1A7
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC4B295D85;
	Thu, 10 Jul 2025 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E5I8Mp9R"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38728E581;
	Thu, 10 Jul 2025 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138403; cv=fail; b=ONRBeA2ZdDG5dHHep+88Yr4JlXUt3z512O9ttWhm9BTyfkpE2fE7jbhagbuNHmox+JpcoZ+lvFgvMNNsOY+2PF+K1Ie/IMxL9/Fbtdt0qYXJoL6EpoPNW/nU7DgXG+suBw15kXOLKHz4yuVqe6uNXwYQQ/tgdSrvSl34zmOgGVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138403; c=relaxed/simple;
	bh=cyB1baLfL68f59ww/lvrXZO8O0ZsWNOEkwGdJT5O9D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JoRODTQC6EhHq5iMoG8O9Ezwo9OYhvB1/1IuWgrkRTpoSBbqWTyNegB82F1e70XH2PF0+maJIW7Q7pu7L1QzaHSFDYUzoweliups1Ezw15e+J7SD3SEBBSCeT/DTKa9QjbwvYTf67QEIB2SCzy3TH27aO/gn7v0FP+npv7KLVag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E5I8Mp9R; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD4ZFzuux4G11Vk9A5Dg2I9N2id0H5AzZJDJtKJSfQahTfb7y+ER8yONq1I6BRCfvtVIgEtOvuoarD1B+fX6yWT7T7CkUfqlBKiGL2ABwu+NC6NqXY9El+JbjFzY8f5uWh631Fr+nURgTFARfjnY7AsPlXRmor7xKgz7YZ/7Ll+EEUf3yVq0Mq+OqgLk8nFEs9bbX2Gea1/2nVqhMacXLCAm8LmK04hfW8j9GWRHKAtqQDVp6BQNjld2JLqJFrbAtvxrZyhUzHcwQfKsxD4u61Qbw3sJHA4DIdOAV5x6tA34o5NvxVUxpg9SkHaF7BhTJHlCzpC/a19/HR4ahiKeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vmz0+X0910LeOtiZM+Jt/HOz1ZTU27YT5sS7X5IvCLI=;
 b=DKhZi9KibNV9N/7Gj53Uy7munhdZLNzfpANgozJIa1MfgCH6vnkwPYNlP4t4cCNiNKWX4IWL728YayDSguPpIhW417XmJ2piL7GxwO6UbtIubwU903e3TTIkaDUwEe3RzRmDGQUUqtFwnNhjdr+KKzUUzI2yMI9Mv0A6HRKU0fhY0uBd3/fD2qyc0VmM/W1+nFana1W+fiIBxpTXeEWl3wZtDN35CSOjqzA2N7OkLLDvvWyU+QYzEMfFk7oQngsFhxwpbq4L8ze/ogujwu1m2t2BNQqXXwb31l2l/jN+rfPT7oFzpkFJbQdlYwXFS74HReemonuZ2rFSqRJlG24HzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vmz0+X0910LeOtiZM+Jt/HOz1ZTU27YT5sS7X5IvCLI=;
 b=E5I8Mp9RaZuZGCjT/uaeTdI8LpsYaeWTfnsb5I9KSs/Vo0jqo4kMqdWHfTzS6yKvGoHL4LWjwxEd+KYzSzf5lVDXgWWgOffXrvQeD114O6IKrdHnq3Yo9Q38JqQIIreICEOuPxkT1IDaB7jRau/m3I0dH/Lew4vvjyW3cjx5w3Tmu+4BgWAtEJOR/Kr1IOSBzr+JP6zJ8bTfrsKEiUtwbJkRIrtYw371Xw31R82OxqtILxOKWnHc6Vwrg/HngsTnBQGCRyYXf9mOxtZ8o53/EJypcxwsHSTxhb8LOe7nV0dwgfG8SzyBnmCsYi23c/GU1MaePo9cv9x0mo9DvK/Gfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Thu, 10 Jul
 2025 09:06:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 09:06:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 3/3] net: fec: add fec_set_hw_mac_addr() helper function
Date: Thu, 10 Jul 2025 17:09:02 +0800
Message-Id: <20250710090902.1171180-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710090902.1171180-1-wei.fang@nxp.com>
References: <20250710090902.1171180-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d4f013-ed37-438e-cf6b-08ddbf91140e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|19092799006|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UnOwh1cU99ci1Pue2yAok5FkEAncy1Et5CON1pMFgfI905MdNwmI7s/7nQQI?=
 =?us-ascii?Q?Edk0NFHMcih21ubrVUuwpgPwBuQr6u1cabS9k2/8OXlw9H/39gzadLD13mIj?=
 =?us-ascii?Q?QqgPzJmqmMVUUOAFEslzQM8wcIiX4Uk4CuUvTDP1g5SL5X4/kXT5VkzOR1rX?=
 =?us-ascii?Q?LD7wO5fwnqFksDHTTRiEj22eFS9QTapdu0q3qZWTtW9wTgWlobQ/9pIiOwJ9?=
 =?us-ascii?Q?e+Lwn5Wvm0naow4+Fk5j2HfBjv98dBsMbbkcJyz8ERIcmVDFBz1h0WmPRtn/?=
 =?us-ascii?Q?cN/O+fDudBoUJgj6zZXFIGMle7cNhJGy8Xxedo1u2bvYQGttTezW+aOnag8t?=
 =?us-ascii?Q?uetGvnFe1rNPWwrvBLpmMgmmhDG7YT+XMHOROVfddnvbszNJQ5B52GMM8FW1?=
 =?us-ascii?Q?oILEQq9Nhas3NQfKBcs4x4G/teyud7i28uu1I4LBP2ggOXHscRzhCfK+lMcP?=
 =?us-ascii?Q?IfjeUbXkWwblRjpg8jUhGstp/oc3xG5G8WU7pxLl7XJ8qpjmQ/ml7z3+hShi?=
 =?us-ascii?Q?Od1E3xThkWir1MPBHqqLoEg8rMOxD+IJv6lkvcOFWYO1Ex9mHvlkYZ4pIjnA?=
 =?us-ascii?Q?6HMl+CkVc4p2uupACz5aCAjw2L0+tl1lT5bw/dSn8WFzS24kXnWMx8eS93Pj?=
 =?us-ascii?Q?UKZ5A8FIxF4RvT318xv9fr4kjdg/bvkbiP/QmhfZ51R692C20FdVpfobDoHR?=
 =?us-ascii?Q?w2qpuWDuzOBPES8oSYd/r/30pVfU3xd1Cg0i8xJ2f8XeM6pnew7AYfYqgxAJ?=
 =?us-ascii?Q?So0ldw/hDf2xxf85ezl2aqFz+KJwmGmHu34qsgeCQ0+WUTHX98ISNLi4O1eZ?=
 =?us-ascii?Q?tXef5KQPuZcyVZFnqEirmAfUS9r3j5o063iaoiSzPEpzvgy+HRa3bqM/O+Cg?=
 =?us-ascii?Q?6c6HYLibhiu2vhq4cabG/qFkX/8q7QrPcjjKvEFhsG4D6mwKRONuO6nNAlS+?=
 =?us-ascii?Q?Oq/hlvRj8PWm6JUv3OVu94sUqj9ix+RZ/j/zkdTCYSBr71W9LLKfqtVtfv0D?=
 =?us-ascii?Q?my4xX2e7a3U+xnU/vWuyVlmmjP4gIhrqSId1PAaN9H8Gp5Rv2AQiLrrnD/lw?=
 =?us-ascii?Q?0PzIkcRQJO8gVrn6vpmm8GsqZnHj9jmT8vxB+I4DcNad9pYhyxN2tGWNOgU6?=
 =?us-ascii?Q?+NiOxPO1fwvVpeXkdHrS7FUladfi0rMqZpfUk+RC4Z4tVujCfeBnwwUIwRXj?=
 =?us-ascii?Q?nOsRslenozbGq/LqIxYruD6Ut3Hv6gH61uC9hlcIn9+u8J+lK1Gu5X99iWTS?=
 =?us-ascii?Q?J76n52VIWJiNWpgyfmFiwRQTsmrPWnlh/xqyLgcmAWVWDGnCynTjOXGncE3M?=
 =?us-ascii?Q?E4h/cIaqGM8wK1UTisAYm/1kyefCaVyLdFK34BCe5zsyN7GPLaUV3YMfWJXe?=
 =?us-ascii?Q?uKFcalrA3vWxydRpUpJCFjAk9T7ZhxxJLSs0HxqQiYTd7mOGKvJso7GVVmgg?=
 =?us-ascii?Q?qmYIQsJIKVvFOKPYUlB8I9F5qL/LG+3ZQjcN2Y+eDL+M0zb1LDe3Qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(19092799006)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dUK0RHao72RvLEEfC+7RO9PiU0soZwbM7mEebXLZRuzaEaeVSdimKk6nJ+Hx?=
 =?us-ascii?Q?qJzun2cEYfL4B2R5hYJuWk9g3j+93fYqpRbVV5gXOLIwQbQEDp6cnn5uFoKN?=
 =?us-ascii?Q?fL6OBJOBwAc5RQROH3BJQWBguyeljcUVCKqOH4AW7rS90oJXlCsTmTRUkFhX?=
 =?us-ascii?Q?aPjWlKUm+HtKRxIJULYRwZqGJRKnMGUnlnrJKa7jT4we/KLGAJjBNT0Ytscl?=
 =?us-ascii?Q?pAj0miWklX3CcdAKPJ+MmpYBEv4u9WsVdhHFKrdWbylcVwXhMWd+VSq/Is4i?=
 =?us-ascii?Q?6I3jtXFE2Sx2GIngSuuVhvgdtf3YdokPql3mR+sIAjj0fltc3dqE/dt7rxpc?=
 =?us-ascii?Q?yIVK1i8NeHVVZcwBZ7EPLpJo8Q6Z8XJTtnrXQr9++foGCtq0OXnesUZSoK9Q?=
 =?us-ascii?Q?2lBAz34nmM7xcaK2+XAG7cl8RF+TOvxiHI1yjLRmhUTmn1HgLRmXi0eNCTuQ?=
 =?us-ascii?Q?1VpqUjmuPhDJesAYaDzGFmroajTFWtPfyoJeOm8eDvksCpYMF2tg+nO64sNW?=
 =?us-ascii?Q?J0ZOiWIYk9LMxWDSiC9cBMWJrZh3wUxLEpdOSCnkqQ4kyeJO+qL6Ui1T3xD9?=
 =?us-ascii?Q?luY3eolmvxBuPOfqeamscwHTNXhBKlWGD/rsxJ0FqO9vD28zhFlQ+U9RC43b?=
 =?us-ascii?Q?+VPn14HNEs8bnyOrfsPHO7KMOngzJXOBFh1TsjsaEHXUiIX6z2EslZpXyfSz?=
 =?us-ascii?Q?4dtK+iwt0jiOapobs/hfAgVUg6nB1nJ3doCZqYj+lVbH/ue9mAStNlVw/XxJ?=
 =?us-ascii?Q?E6Bgeigj25f4F1PKJZxgrYhPC3EuBS+A6hWfJtt40jpu2fssb4pM7OPFV3Mk?=
 =?us-ascii?Q?yKdo1ACtw5wBiGXe4hZKMK0T7dDYAqxe2A4+cctuLiI2G66tXFdBX5a6SkMK?=
 =?us-ascii?Q?ojEkUpYbw7khilK17vGLvupCmNexNKdNU0oUzeTzqtfAtocKqkL+/j5gBX2H?=
 =?us-ascii?Q?/xuYwlEg2dSS8UzM2IgbG2sFSRzqsLHKjHOL5GHaWrA+6OWhg6lGZXuQ+QHR?=
 =?us-ascii?Q?CX4LTg5yye3crDWcmBD6tNNn0oDRUO4mMpsQZUDdKp5Yutr7Ph4GG/ruvhpJ?=
 =?us-ascii?Q?ZPSt6k1J5gsIQw2F6bfA2LOfJppbNtYY6u/M80bO3hCjWqV5Jh0Gr2YX4wc3?=
 =?us-ascii?Q?5VWGZ2SKyyTYKMFHfYsI8teTJnMiKO/eOujPr9Tz1rooLY0UVbBHw19TU1tR?=
 =?us-ascii?Q?Clp7MHQhXMkdrp5odZmtmjMs9qKosruSPLa1uWtR1LM8kPFnQQo7y1BqqZLy?=
 =?us-ascii?Q?twa1OwhN+Q482e838JvYiwfv82Ka1IzhHpcxwU3x/aD42H/5q6twKa6KWiFf?=
 =?us-ascii?Q?ulpM38dYmZfk2z2p8qAAbjGa7/LeddkgxnCkvXCj+Oz1rjkKAmn1k8kysZZV?=
 =?us-ascii?Q?L5EgMEhTkxd4xBHMXZJ5w3Uxph6dIk6WO4XKF7+aESm4cVsteaBn2sZ2+Lyx?=
 =?us-ascii?Q?hVY/TdNuml+VuAA/RvxlSvCeHStyDBbygVOHLzV/m7NGjJbn084UumMZRF78?=
 =?us-ascii?Q?TCWrKKR17QATTBiu7w+2Feu5YX8lCgxxfvbscS7myjZy4wM2BP0kUuO3U/71?=
 =?us-ascii?Q?IDKDAIipXzqXfBNnrc7jbcnQUk6wL/F+d0cFpcS2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d4f013-ed37-438e-cf6b-08ddbf91140e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 09:06:38.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajVmCrZ2VmwZ7MAhV6EC5xSNyM8N8OR9paOnclghelMIyrRr/E5/7oNzsi1+bKB/GaW6oGkFwKnavZmE2gz7KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

In the current driver, the MAC address is set in both fec_restart() and
fec_set_mac_address(), so a generic helper function fec_set_hw_mac_addr()
is added to set the hardware MAC address to make the code more compact.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 27 +++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 00f8be4119ed..883b28e59a3c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1123,6 +1123,18 @@ static void fec_ctrl_reset(struct fec_enet_private *fep, bool allow_wol)
 	}
 }
 
+static void fec_set_hw_mac_addr(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	u32 temp_mac[2];
+
+	memcpy(temp_mac, ndev->dev_addr, ETH_ALEN);
+	writel((__force u32)cpu_to_be32(temp_mac[0]),
+	       fep->hwp + FEC_ADDR_LOW);
+	writel((__force u32)cpu_to_be32(temp_mac[1]),
+	       fep->hwp + FEC_ADDR_HIGH);
+}
+
 /*
  * This function is called to start or restart the FEC during a link
  * change, transmit timeout, or to reconfigure the FEC.  The network
@@ -1132,7 +1144,6 @@ static void
 fec_restart(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 temp_mac[2];
 	u32 rcntl = OPT_FRAME_SIZE | FEC_RCR_MII;
 	u32 ecntl = FEC_ECR_ETHEREN;
 
@@ -1145,11 +1156,7 @@ fec_restart(struct net_device *ndev)
 	 * enet-mac reset will reset mac address registers too,
 	 * so need to reconfigure it.
 	 */
-	memcpy(&temp_mac, ndev->dev_addr, ETH_ALEN);
-	writel((__force u32)cpu_to_be32(temp_mac[0]),
-	       fep->hwp + FEC_ADDR_LOW);
-	writel((__force u32)cpu_to_be32(temp_mac[1]),
-	       fep->hwp + FEC_ADDR_HIGH);
+	fec_set_hw_mac_addr(ndev);
 
 	/* Clear any outstanding interrupt, except MDIO. */
 	writel((0xffffffff & ~FEC_ENET_MII), fep->hwp + FEC_IEVENT);
@@ -3693,7 +3700,6 @@ static void set_multicast_list(struct net_device *ndev)
 static int
 fec_set_mac_address(struct net_device *ndev, void *p)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct sockaddr *addr = p;
 
 	if (addr) {
@@ -3710,11 +3716,8 @@ fec_set_mac_address(struct net_device *ndev, void *p)
 	if (!netif_running(ndev))
 		return 0;
 
-	writel(ndev->dev_addr[3] | (ndev->dev_addr[2] << 8) |
-		(ndev->dev_addr[1] << 16) | (ndev->dev_addr[0] << 24),
-		fep->hwp + FEC_ADDR_LOW);
-	writel((ndev->dev_addr[5] << 16) | (ndev->dev_addr[4] << 24),
-		fep->hwp + FEC_ADDR_HIGH);
+	fec_set_hw_mac_addr(ndev);
+
 	return 0;
 }
 
-- 
2.34.1


