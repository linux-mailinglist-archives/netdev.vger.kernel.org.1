Return-Path: <netdev+bounces-144015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2109C5208
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7781F22DE0
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73E20E337;
	Tue, 12 Nov 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WG5EW1Jf"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9420E31F;
	Tue, 12 Nov 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403826; cv=fail; b=pJfjycEWGnLGQfSwJajwku9UjLXpo9LSXk1+pnBW8VjdNkdVLeSjO8QsRhQudKMgVZCGB1oO6YPnN/FgCJz2TADPSlVHxRfeVJq3sF8gWiJFZram5Jq6VUrhdR5TksFM1pJN6jNlhAAWbQeZeZ3ad6H3vzhUZNpzT88JckUGvj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403826; c=relaxed/simple;
	bh=XyucMni2+AgKc6fANwmKum4vQ9QsOp5KBJGK+wF+NQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABXgLrXdITSNZ4S0SGas2tTzsuNyHS7mZmQyHKWkhSE1OB1er7xL3Xp+F0BwaqZ+2WN0BIiHYxL3r7R4yNvJIQBPyNb9fF8AfC4+1AYghVLcxZrt4ZucQczVgysKjMiRh8UUIRFE9arQdA2svmgzYlyw2yVK2i4lOFwLCOEl5tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WG5EW1Jf; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvE+Bioyy6RA6a5otcJG8pqALGHzqFqYDiYRnyP5+xP6/MjC8Hz5m0o2wwvoPC7WdI+4+AFtLpvZSzdNXv78KcVwKROv5z3pkSfU2hrTyRrQA9/TmthvI79CQzQF3PzQnQDYOqAWsagu0ZRhvC+g2hH5BYW/5gaXF5+qG4cqfYscLOvA4IVXor/X5mB/ZWkBnY+Kht/lF3OI02yOOnjREQ27byimJ/b1o7IxicmQ2XWc0WSUvmpvHekUjcFXqibWT+cjcYnW9Gwuc0tVm4km8zHm4XbRl/M2ryu0suPrh5MfJmECiBf4gbFcc3UXkGYa361kDM0k1kBTJdC5PL1mfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy6EgeEjot1tcShDqpHwFSDynpXVxx3eJaHQo9TSYCU=;
 b=yatkihnRx6u3D17KHZiR/JNo2iyJIcaZqK8V05UKKGcK8QQ5UMy/9eJrk+Zi3pOgqdmKAGvKVmvqSywUhYdjWVF+Jal8uiDA0iMXcQT5prpnD03VCU1ELdAb3QzrMdSLVtXHfNzSJ2Rmm1NfnlTYCVHl24gEQblvv+SVVhzYAEOYQ7lABdkBoy1SjhON3OliV1JoqhBurdH6S8/RwEfu9Q7w0tELDXF4p9zLl+MftJvgAcCcsuefI/trUdsGc7RWN34+EgHi//pb699KUW9M8XjPBXgFm6qFDgY3VmB4cB3pbyybhPb4f0oJ5VPb+tlFAx/0HzYvVe7pxggeuLgSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy6EgeEjot1tcShDqpHwFSDynpXVxx3eJaHQo9TSYCU=;
 b=WG5EW1JfWRO2cr4mq8TI/hwvuHd8Bmx0ZZJsGxjmRlvY8bxaVp6Gp6i5MdOJD1oJ6hQ4yQfnlMlVpSVtf0h2pgmS8T/oON59VyP/hMjHeVVF5TWbGi6FqWfwq8wPM40FV/zXbOXXETylmPxgKOQ57dpJRjKiP6KwpSVhUbu+dhgWBg/tKKbco8V3ZXztq6ShJGAA7dm/40lH4OybGkow7nIx/10KKiSxNj4R1qwUXvNr335wprasHTAgVFZ2np2Wob9hdDLpjdh2XaHyC/1bUB9h9jDGZFogEbA7ggNex4+uY1m9KBKLlbUD+7LYaLiakJr09IQqnhYUdx5XvLV3Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7892.eurprd04.prod.outlook.com (2603:10a6:20b:235::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:30:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:30:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 1/5] net: enetc: add Rx checksum offload for i.MX95 ENETC
Date: Tue, 12 Nov 2024 17:14:43 +0800
Message-Id: <20241112091447.1850899-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112091447.1850899-1-wei.fang@nxp.com>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: de5255a4-7b6f-40a1-f2dd-08dd02fca0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IQKLNQD7AClN8OtuQuwOqiwibAw+juPjxU77a/1Io7ud2tMXktS0dQHzNQ1X?=
 =?us-ascii?Q?slxtWfWk+msbnAJOA7KGWNs4LDzlFJqKbRzEY04i4ItigYNuRY0xqnjidD7P?=
 =?us-ascii?Q?G+XixzIV5lUaxNieXZPcQj6rGbzyLK0XwyNio26K9TiA/x0l1f1kLJPmd7Ml?=
 =?us-ascii?Q?9TgReN+JjHb5OaCcINhmYpQgdZCbsHEcB0zZdhWiycalXAyeooDMjMOPA1Iq?=
 =?us-ascii?Q?hlVF0UCSoyged8nJ8ddLvK9/4A8CZLhA8PU6LTaChUJByzKjjeb5qgnHxvol?=
 =?us-ascii?Q?Drc3QFgSLct66SPdJIYqnrdqyTfEaxo5Xnha7MP49bAL03ZKYy4qxcnq/+aY?=
 =?us-ascii?Q?8IA9hEwhZ/twkUiDr9Y4nLxeJnn+02qRNGost+SceVDCSNfjLcLDe3rV3Q3u?=
 =?us-ascii?Q?d5hCVpdhCl3bOm2UKAMyDlw0+5ps5PMuDGjiJjzf2ndztXH1Ql/9varPnjrJ?=
 =?us-ascii?Q?ZJ7yzQvmMmwGDTCYM5hEgIwtv3T2lNimuxh7NMIpN5dDrM+pOvDvdehZaGOa?=
 =?us-ascii?Q?f3RPEJAgLWOqAcp5pv+j/FwvvN72Heyp+GwFq7KsL163TEOCBp1weIiXaoOh?=
 =?us-ascii?Q?thp7zrnj8WCnu8uaH/R4JQDv57VeDowHWuEqVN9whRHSJHt4hXYBxrOw5NHo?=
 =?us-ascii?Q?912wRXXDtBYsceiC2BCXnOuTKTW08yraQ9cm9GPiKJ8Ynwtrti7msnlnmYYs?=
 =?us-ascii?Q?8tnS2sjNKBNNqW/zMHNhbk503McH/2eVmV0dcx6DmSgb/f7/pu0rr1OKHo/v?=
 =?us-ascii?Q?zP8lYTH5R+2yHI74mhR8ttDKUDCaM/bP0Fm3wkg6CJUVoFbq0C0owa9Iu+C7?=
 =?us-ascii?Q?YDmR3TNigQoZlCJ3Cz4UqujHHubPirnszUqFPgiji23VJSZO3h86Tcjr5HGv?=
 =?us-ascii?Q?3kELAh6jIQ6vSwIfzDSFSM631dXKyCZ1bRjAwagrK1taVuxPFFwqAcMcmuAz?=
 =?us-ascii?Q?ciaqT7zWyNtB1hGMjlB4szprCxoDw9pBk9aChW5UUr6kYWKaCUoUhKw+n6K4?=
 =?us-ascii?Q?hkWxF0J4BD45MhsXeXI88i9vj1+ER7yPvxJae63hz7DoQ90VBdTpq7a5BJ7v?=
 =?us-ascii?Q?SJaTi43b3JVsL2L61aMTTKD65gJMt4owFnQyQgZ+qYo2pHfHTKrHrVuMKUcn?=
 =?us-ascii?Q?UBYJoahPcpNCfXh6YuJ6cWjCeQUOKBKI34DQU9BQU9sEjDTMurYHQhTX6S7f?=
 =?us-ascii?Q?Yt/RXDjazTIVFbXWa9sBIK0Fs1n1zv847/m7BOgI5uX6yT7O0uOnQ5A1WBTR?=
 =?us-ascii?Q?P3u7L7UC9xQwps8MFEheY6PiE5/wD+ytIwlFOOXnZK6Scqm8XgErIh+46m0v?=
 =?us-ascii?Q?I3gNsl/HJ8B/8gqZscA0lV9vA3en/1EfWJpYmVfKQpCzEElauiy3h1FPR7y3?=
 =?us-ascii?Q?IWTWa2o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q3Wv44H3LYc/9TbwVirZw2siG1z1kqEuxELYAWnf3SIdnF+c60Iji5gxl71o?=
 =?us-ascii?Q?KbfKrGxAvEKl5iDXV+3NqLARPrUy/AUdoDu9/Rt0D59sI/56Ydvd5Yz4v88G?=
 =?us-ascii?Q?n2scE/SvP40AFZv/n+gJ2Vyy7e74QBe+2+hRT60XDN0mFVEnmxPorf36k1Hu?=
 =?us-ascii?Q?ZPQjsjTyL0KuEa3XCvAhNxhgJEfapWEupkpkYwaBFnJRA9lZoEQ0QuD8aGUB?=
 =?us-ascii?Q?juByFWxrN9gQevlKN2WvIjSzLPhmkAwtkUK559iNNE1g2Pkw2hiYVNjbY7Ad?=
 =?us-ascii?Q?e38qvS/oQ4FgXhny9m5rHIu8Dp2w4JA0o/ei2jkket5tWQ+EfuT2MBP9PRaS?=
 =?us-ascii?Q?HX909+x1C0lQ4U+WP6KfkPqkW1a0QSdL/AZA2p/AtfyjK84/9KJOxX1CBRIj?=
 =?us-ascii?Q?Uuyn5YaOEJRkmKueCQWyQzbxmvNdKiEYheNXFU/6WIL9F09HvR4vu1r48SLi?=
 =?us-ascii?Q?ofSzE8Tl6BTkJ0ppQ01AdR3sd2RrSNRsWm2pBGxCgBVuUheeIwALoI2XJ0Mx?=
 =?us-ascii?Q?lyBZaeFlZGvnMWOc7TdFjquyWmMXPtxH5kty/DtY5gj/5o5q/u/4xpm/QpJA?=
 =?us-ascii?Q?Hc1uDEhD5xoPXJjUYi0xuNfh3hMfSaVlbVdSmL3Xe8hoJS8qAYog46i15z2w?=
 =?us-ascii?Q?9xFF6DI2X43JlRD7QlUgHePBFGu5tNvOOPNbOqOxTTpQehJraseAcJiuc5kN?=
 =?us-ascii?Q?xwxnmHI28LC4HwBifv4N7Whr4RC4HObklLy6euDIW1Kj+AyZE8uBPdMnNHNl?=
 =?us-ascii?Q?bAFCnKuWAIG9OtTuT8As9byGsFL1z0pgoCiYYcUbl0rd534uOfQ761GeQkjY?=
 =?us-ascii?Q?F4ru/wie0JlKQZOhXYXOTzhmYA8rRwGmVgXuA5SXjwwfQFWYUCEc2RYwf6pc?=
 =?us-ascii?Q?0DX7Ob5Jae7BXZsyU87uPEsu1Rforn7eh9Zsfu63+qCAU+E2iyp9+DMBpEGe?=
 =?us-ascii?Q?Vs4GnoBXSCObm1ZfIp487E3HtXLc58qK1RHACUeEf7H3Jc9GXWaOlBl8BJuc?=
 =?us-ascii?Q?5pjI1DUpxb5xuoBvBon4g6YjJ2O+a1Vseo1NndgqbAZ7jLGXs5vVXtLhZ95J?=
 =?us-ascii?Q?G3TvHM6b61Xk0r10ISRHl9lbot2CQtMFBtj/CpSOCWmpo8oWqgLGLc2Vvoa/?=
 =?us-ascii?Q?oMLbzkHIOf+Iv+tGilIjSTfPSRTAhZdAbZy3w0a0JCgE9SOoxlpbAGaYapGZ?=
 =?us-ascii?Q?fZbfolxC456jnUbYG7orPHRLWxyPLGcyw3CyOGj/REZns5GTpbZ62QqAPzYi?=
 =?us-ascii?Q?RAWF+9g48V5evahML9YSdfFwQmdgXonxEJCfZuazNqbvEhGGrm0ziUF6hNdq?=
 =?us-ascii?Q?ejjALOthZLIG5bVv+8CWnH9Gqtc/QMhZo7aOK+6E5QEaMo0zccTerD7Tq15B?=
 =?us-ascii?Q?bKb2fDWfEV+0rYK9cca+5prRIz1vYREkEYmh7BziYeU3sx/tectlKKMKQpay?=
 =?us-ascii?Q?jR1Mi20m+N7QfTKWjK4OsV4/OofR6UVoc1HBipHbLW+Ofzx2th2mlRb+gQHv?=
 =?us-ascii?Q?e2uekv6FOg6JgibfUXvhlQYDiH/sdVnoPdp3eXc97jpfj8MKPMGg1XIVYehv?=
 =?us-ascii?Q?4plDg1nuAMKo7fiedIwvVu4Xkbwf7T2FHdmRKNPS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5255a4-7b6f-40a1-f2dd-08dd02fca0a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:30:20.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+bs40YMVYjdUhrtbi2XtkmmXZ+mTNRGKzlYVP7FujL9ITxKPsFvpnCZdK6YSI/bkB6xKRSpxaz+z8uEd+iuKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7892

ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
this capability is not defined in register, the rx_csum bit is added to
struct enetc_drvdata to indicate whether the device supports Rx checksum
offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c       | 14 ++++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 35634c516e26..3137b6ee62d3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 
 	/* TODO: hashing */
 	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
-		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
-
-		skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
-		skb->ip_summed = CHECKSUM_COMPLETE;
+		if (priv->active_offloads & ENETC_F_RXCSUM &&
+		    le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_L4_CSUM_OK) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
+
+			skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
+			skb->ip_summed = CHECKSUM_COMPLETE;
+		}
 	}
 
 	if (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_VLAN) {
@@ -3281,6 +3286,7 @@ static const struct enetc_drvdata enetc_pf_data = {
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
+	.rx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 72fa03dbc2dd..5b65f79e05be 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -234,6 +234,7 @@ enum enetc_errata {
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u8 rx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -341,6 +342,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBV			= BIT(9),
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
+	ENETC_F_RXCSUM			= BIT(12),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7c3285584f8a..4b8fd1879005 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -645,6 +645,8 @@ union enetc_rx_bd {
 #define ENETC_RXBD_LSTATUS(flags)	((flags) << 16)
 #define ENETC_RXBD_FLAG_VLAN	BIT(9)
 #define ENETC_RXBD_FLAG_TSTMP	BIT(10)
+/* UDP and TCP checksum offload, for ENETC 4.1 and later */
+#define ENETC_RXBD_FLAG_L4_CSUM_OK	BIT(12)
 #define ENETC_RXBD_FLAG_TPID	GENMASK(1, 0)
 
 #define ENETC_MAC_ADDR_FILT_CNT	8 /* # of supported entries per port */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 0eecfc833164..91e79582a541 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -119,6 +119,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->priv_flags |= IFF_UNICAST_FLT;
 
+	if (si->drvdata->rx_csum)
+		priv->active_offloads |= ENETC_F_RXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


