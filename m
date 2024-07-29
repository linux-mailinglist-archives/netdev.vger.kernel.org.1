Return-Path: <netdev+bounces-113637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0E93F5C7
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7544E282FF5
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA2A148FF8;
	Mon, 29 Jul 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OHeNxLTJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB31148FF5
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257147; cv=fail; b=rKaQo7j0hPl2Dj40Ed9yQy59tZHvVIE125Ys0dENDAqh45J/xJblkEDlw7NEHX2oLGaOdhpMVXvSYHFppmF3ycWfmDfv/ZDXIiLg8NL3PdDPMwjSwqiD3rVrztpG+hPvMZ/OV2YdD2opUj0BwOOIxKdooFJCsAojVIaPZZgIqY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257147; c=relaxed/simple;
	bh=9UKFk8UEOcqTXXP5Xnb4XWs0ONT93jAn6RVyay3XQTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGZkazWr5FLQlr+98c7Gl9Ms5qAHpGzvK7xNpgcOMyuEvX005rZKBj81FJ054m/wmXRESVpUe6WYmYMv4ozD2wzbcEhpfNpX4Bu8WQQwPsPxcQa0+lYbuu5+epYzPNPk5D9CwB9ecPKQPKf8XrSQolwvO1d5PDxq/rGOTn8989k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OHeNxLTJ; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaDFqfF0MY5zMZAFK04dQioUyyTi7DJcpTwRGz2+blfjuHC84FbISnAcOSxGxe+/cwmvfYqBKWOa7Rr8G4LYGqVaTioFMIczqPOgPsuUDuMk/qaJgHFFai+1DJJUCSv9rGl06HlGbCTOo7ftkaaCfLhH9Uz4QicIgd+/M2V15HTdAplyk3thHFkd4wXk2t5ilV3SZV/JZ7+z2v5xldBJBHBSXikq66HFQ/zz6IcgFawEF1TD8h+BBsIkNFldESbOaJnAv86/CB/7O0U4Em3Jox+NN4GJ2g21I2Q2qOzgfqUvxD4Xu7I5HPUTNf3BIdbuAoBgqo+VGPZe9YAwY1Dc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cet6yDtfpTBdv3Ic9HVolbXCkWrJP5qONs/jW7cd+U=;
 b=BW8ieCDV/Ka18/1QS+UCxLD/4Mnd/l32au5bGF7HF9DNcqybA+c030k/yfdnopqvtd9gc9GfZZhQGs1pvyh+dGgKyX1y9xQQGZJemhfL9K+RAV+WHLeIXiKvS8hPD/KDIIxp5KkPBAV4PykANxqxFHd4B57o9DbBJAiG2s3ajmqOukPKpSJSU3dZqoFCFYOv5SQDt6dbqV7H8kzDcZliNAykbL3GQ2iiPCBCe7dn47Y+gaPgHhJhQkXdudp2OGKrbfnmwuOfu6eygtX8i1bDMZ5TcRys4zkBatOVs+a3NjaWgIyZdmPTrjnTrm5Qa7aommbPHWErJMADmGRDoTNuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cet6yDtfpTBdv3Ic9HVolbXCkWrJP5qONs/jW7cd+U=;
 b=OHeNxLTJdSQrPolT7BLInnBCF9yCrBmOyiGJkwLuJl3oDOp17uEZLnShffAspDfqJOTUNTfPhuaNtkqB41GFr4pUjzf9b1aBV2T+mKOLS0CnLbaWQSyIDHihOxo5w609ympqWEKs/295ko+QYvxFFki2DGxmsCGxLDpLwfRZGmiR67BULP0LZ9Gd1bE66GVMnfrSLlzRtNR+RyQzW+uKS1OYxPoEuTBfpbRaAMlck6QAQLoBkZKRrKckl+6I6YysllKoqzBPi3uUGR68bMxUNYxA0z7gjj7i0eTsK+v6S/d3uAaw5kprSnU9PEw7HCcAyLzLFiHqQo3bJpDQFFrEfg==
Received: from SA0PR11CA0039.namprd11.prod.outlook.com (2603:10b6:806:d0::14)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 12:45:43 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::f2) by SA0PR11CA0039.outlook.office365.com
 (2603:10b6:806:d0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Mon, 29 Jul 2024 12:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 29 Jul 2024 12:45:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 05:45:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 05:45:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 05:45:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 1/4] bonding: implement xfrm state xdo_dev_state_free API
Date: Mon, 29 Jul 2024 15:44:02 +0300
Message-ID: <20240729124406.1824592-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729124406.1824592-1-tariqt@nvidia.com>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 929ee853-a0b1-438c-606a-08dcafcc5bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6FT0yAeSEvQNZHsh1rgGAmu5kHwGA+n3kPYe0DuHRMWzcUbljPnFXCJLB3n3?=
 =?us-ascii?Q?evp/ixUxJs0EVPlGJ+JFnE99S/LNt9vKPev4iLiVyG8bbWmpFCZpgtlpBwj2?=
 =?us-ascii?Q?toL26ciXh0cJauQTv9FdIXciPu2bTBUpvoD0bSULcDq4L2UHnjPCwrrMtfFg?=
 =?us-ascii?Q?N1IUs4yr1l3uABU5Q8ts8cK1rGmbh363m5OJFQ7hwNwIzfbe793qMBHsGDHX?=
 =?us-ascii?Q?8n2QSUgMUuBN0wk47uB14GBxk4xNLmQe8w8psz3LXSpa+LYhXvu7Wx2IcP6a?=
 =?us-ascii?Q?DxzJkEjA/mio3x5Mn+NcxbT3kYKAk8pKQIJeda+JReLe58YB/ETF79YVJfln?=
 =?us-ascii?Q?rnb3/NcPseYQ9l42Ds78Li6Ckeic08+dB3Y62V7HgMnW+lNriwFjJejQJmfA?=
 =?us-ascii?Q?nCSpuc/Fu/xqxANAcM+4IptIEqFuTBf/X696lT2cvUU78sc6rdFI7OPeFWSn?=
 =?us-ascii?Q?++/R39G+n2bnLtuqFaaolAMY+RZYuK9D4dHjIob+OVKjMKokf63cuQOW4ITG?=
 =?us-ascii?Q?/FxA4gIdSg2c0+LNcnIkyJHMzN4rwbBFuwhJBdwF6Rub7ULypfFJ05DQt3Py?=
 =?us-ascii?Q?5BDbpZo7hSRt9iV/fD2lsgIijjV8MiQW6Tl0mA+SZcOgXeJo5kKgHplssFb0?=
 =?us-ascii?Q?A8QrxsOQXdrzk2ZusZe2npGwri4/VeO62vs0RqHpxpMw7vRn/pPCY58AlAIP?=
 =?us-ascii?Q?oW+k3okQ1QAPuuxBGQVHM8K3rx7kkCJ4MghUJtzmQlP/miUmbjLnfrsXKNBA?=
 =?us-ascii?Q?bpp3lGCSQmOW9lF32krFGxUkKjEgZtd+vyEeLFd9byUoJpqhkilmIMu42FOe?=
 =?us-ascii?Q?fOou7Gy7Y1ifVkP8kKtUMbghWXhJA1PMlmJ41TQ34sTiFxs/3XT1qculpyMy?=
 =?us-ascii?Q?2HJ2hcD4vKltqnJ/dUgXCOZMvAUFBebTrZDAZWnLxvQqVVldWN7e63f79lLr?=
 =?us-ascii?Q?RIG0cZLK7eR4aAH7tmZdgJt7xa3iN6u5AzWPrpsAJe4NAwa7Rpe+1z5xo1//?=
 =?us-ascii?Q?5tKkMBjWmQWdrigyAy+5X7tkibqZ5W0pAH/Cjb69wQC6O4fKxyQLkashc8Tm?=
 =?us-ascii?Q?vls4Hx33mYaHZxQqHAlsDKgbNJSjSmpMXOXQ3Z70PqpO/AjqUzpnXde9dE2y?=
 =?us-ascii?Q?tEqH8kZXGcf16xNhW45cLL2ktboBEU5Idtw7LcL99gP0/ZReRhMOFQ8LtupT?=
 =?us-ascii?Q?jFQYhrWpJTy/IuLnPmQRX+6UxSq2P6xKOEnrL8gc0baCS6qm5fdEXp2+d/g6?=
 =?us-ascii?Q?9ANHcI5wSKRYj76jqipRqzpRTpF+6yDnnpBEJ9m4For7od9RNmONWfVOj2v7?=
 =?us-ascii?Q?0AT9sW2Ir1OVVdRuw0Va91fQ/ly9av+cpw9aagizNVHruNUTZZIwnSpu12DA?=
 =?us-ascii?Q?YvbMDQ57PHd3FDhCeIbV7UX5GWHBgsm9RdcuczDeIhJI/XqzbWRV/PpnOIcE?=
 =?us-ascii?Q?Fusb9VvQW23WGLbu3y3c4IGk3cKr8/l3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 12:45:42.4862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929ee853-a0b1-438c-606a-08dcafcc5bae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

From: Jianbo Liu <jianbol@nvidia.com>

Add this implementation for bonding, so hardware resources can be
freed after xfrm state is deleted.

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 1cd92c12e782..3b880ff2b82a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -588,6 +588,15 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 	rcu_read_unlock();
 }
 
+static void bond_ipsec_free_sa(struct xfrm_state *xs)
+{
+	struct net_device *real_dev = xs->xso.real_dev;
+
+	if (real_dev && real_dev->xfrmdev_ops &&
+	    real_dev->xfrmdev_ops->xdo_dev_state_free)
+		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
+}
+
 /**
  * bond_ipsec_offload_ok - can this packet use the xfrm hw offload
  * @skb: current data packet
@@ -632,6 +641,7 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
+	.xdo_dev_state_free = bond_ipsec_free_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
-- 
2.44.0


