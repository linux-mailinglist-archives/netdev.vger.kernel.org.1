Return-Path: <netdev+bounces-114884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AD9448C9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38941281956
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30D9170A1D;
	Thu,  1 Aug 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WRthjJdn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CEC170A02
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505863; cv=fail; b=E2MQWo3IRca6KiKOXJLhG8bgxm4QFnx+WLwZoQ87JxOG6oyphPAs6UU0z2BSv4xwNATBCYCsP2UABoPtZ/X4Ujoh50MfonUUPQAjgdh2XqysfWcnvNpG5Jua7SEG1XYNncNY//zpCGJU4d998Rz7qcn7A+5Xi9ulRPjXTdUNm/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505863; c=relaxed/simple;
	bh=yS4yEl6yR4cmHuNyWfRi3rAllVyFFxl6jiFhTFQlaV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSXObX39p96cao+4WydjtMi64VaPRfE/iiATXwG2+DH6SZSYqPDURqRsJWiYiaanSbY8gbJFd2VX4BPNj9WeWdxuykJelmwMDTYAjY3W6ey9Uu8P4i7qzKcXGbRo+dqYS2gDxBQ/KEIrLCG84+gOflC4wYIk09Xj1/NdQ24B70E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WRthjJdn; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdcnQUWyxLKA6eHqgS8/Nr2h6O8T5jC7k38h7UZ0vBtrU0t8v1wF4ACJAuL7egaXna9XbWCTYHli6pBXR9JH7p0CjWm4yHEQpGVixARYzG14NOsv/Y30ohptKSiXv36nu2nfQliQhMGFCB+BKW8+DcrK5wuQ7gqZytFAWfj3P25AItasUUBhN6av5cNC27ZQ/Y/k6yJdcO7emdEiWvimN1zETxev4pt8QJ4Z6MTkNCDj6BdqDVa2kBJHxg8vbrh8xxzTUh52b0BjXtE9txIp2ZHzXYEfCQcYywBpk0vhZDk8HwqiBePksiE/0L4mywnLLAjtKFIoKkoaQbDMSMY1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZMdjvihJ0DhEGw5Z9U6qUM6UQBN/SuN70SZJI1bjiI=;
 b=oEd6gSaXQRP9p1mGYUWGKPo8oIxTWpNd8KaXVBgdhmn9QZfhusgkAU/B5U8hwgI5vSGbdK9wSDlV7uzriSlrcHveVDHCiWMbfVknl7xFBGxwy2yuHtL4nsAuMDRjmm7pgOaI89KrrBHKJf/wT73sRbTC+DoP++Hkj4FLbgXZFdmJMMeXR8eckRPSkDfgH6EOnqbpsgmoe4Ptedtqq0AiFzw25WI5PLcZ3j1iB+jRl+TOTB50KEuuGe/j0O5dcz5cztqzrK+/YUYoI9JAtYueXEwyLx4RnzIkFsrRBo+NGiFDFa/ZTe9EaO2vYIYmSbtVIBSxBEJUJWjctAcyxKdQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZMdjvihJ0DhEGw5Z9U6qUM6UQBN/SuN70SZJI1bjiI=;
 b=WRthjJdnU1k3zKlzBbg1yGlq8SC99T1E5/3v08O3vAhsa+N+vcKLuLfgUvqR4CEOeacLLWNGPq7RmYuSFhSVBIHxiH+nlaNhwFZr99p47gXXgxecisrHu0hM+Ur1KcHhYOuYdFR/Cr8WNmpAH/kuMqtNVvsfrsw7BDT9b4G0Z3900ohlyR7tPUFaa/MQx8zm8zXZuw/7IZA2lW9S8W/9tI4sZU+OYUZzM4yjkdAaJYfSBfcAYguIfJe1jZvQ18R5EhgEPbpmBU30pDT0ZSnDw3aow94TddN1UX5bdoCRy1qWYeAjQeCSG7hoPVE/NUTeLf/LGOIT0NFYZA9aMIfb+w==
Received: from BN0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:e5::9)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Thu, 1 Aug
 2024 09:50:58 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::5b) by BN0PR02CA0034.outlook.office365.com
 (2603:10b6:408:e5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Thu, 1 Aug 2024 09:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.11 via Frontend Transport; Thu, 1 Aug 2024 09:50:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 02:50:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 1 Aug 2024 02:50:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 1 Aug 2024 02:50:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 1/3] bonding: implement xdo_dev_state_free and call it after deletion
Date: Thu, 1 Aug 2024 12:49:12 +0300
Message-ID: <20240801094914.1928768-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240801094914.1928768-1-tariqt@nvidia.com>
References: <20240801094914.1928768-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 729f2a5e-4d56-4437-d753-08dcb20f71b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qv2KeRVwDF6YO1AMO4SR9JDN2QCJ2mDbC45cHq3NwePVM3U8+e6EJiS7QCv/?=
 =?us-ascii?Q?uZp7JjiL5LF93Ev32j0eS4cfaskoAdFuj9tZR9g/wiFlmE2akqwEYeJcgxA3?=
 =?us-ascii?Q?Tl/rQjKOEFxBzMl9IXv6MVZ/kOWp8gWOvx4yheitMPpHqrKwcCrTtn05+c7W?=
 =?us-ascii?Q?/s34bPLOmZuIVimNkKpsG4ZITWUn3hQ3tWKMZXrty4nipbeaoAvvf59G6uYL?=
 =?us-ascii?Q?NX16ed/JEusz1PKMh+uiOlJpOt/FDjW/+YMd7DFwiMB5ZWbrzkc5nQA3P5LS?=
 =?us-ascii?Q?4YRisvJN58f3y57ruU5xyv7njRlJAHtZkX4hSsBwkPenvmQFNsQ3spF1gSeB?=
 =?us-ascii?Q?uvrXLZ3kT2GZ2xlKKYdEN6XiEIJWto67OOmhG2qZXpGT9YiL8bIFaA0w5+ZJ?=
 =?us-ascii?Q?3vao03jCUaTSn77C1A76nTCEafwEhLg6lKfshnyMhn0MxrUH2JWeCbL78omr?=
 =?us-ascii?Q?ybkg8Ddoh7RgA2mLoQC4POSh/SHqBPylAPHduwXI0Gq00UerrRRpCNTNgqvF?=
 =?us-ascii?Q?NehIXClkFF+WgjotgPSrQArMgbheyZ0DZGNnSXdJQLvtHTsN4JwHtJjNlS3F?=
 =?us-ascii?Q?tPr1PP8PljjHf5Tg2juEjdn3U4nyYzM3Z7IWFsQt0sjbUD8g7u9ktrq0X1Tx?=
 =?us-ascii?Q?wsRhw5JEcuQLfHsmXUaJRe0MDh0bbZEKbOMD5E9zMTrd8b+cdzZm8OgfxR0N?=
 =?us-ascii?Q?a2rTilFvTsxJ9TgRXnuLzm5NLczlatIXmB0KJONLB0VIRzr1e/n92X6yaBqv?=
 =?us-ascii?Q?ydzM89i/Q841YPAajW8n1jnc3y/XLU0rbPARlST7aAaKPIZQ7lBNLgDcqUXU?=
 =?us-ascii?Q?KaQvzETo6I16iBKOairSbtf0DiQOdLlELKY5ZQ2ufUT11H3aTjcB5pQtWVnl?=
 =?us-ascii?Q?36qKm5goh/vERxS1aH44h8NYFTKUXcsJZonzU8AqSQtv/7K9NIgHfr2NERfQ?=
 =?us-ascii?Q?vz+GCgs35ED1q3fTYWXAq+uKAnMErMr2VCaaohYpR6pVHwO+zkbHoAJttMlK?=
 =?us-ascii?Q?AcNlJxZvx4k01t+DU5qYP+0OAGdgHyFyjkQAeOhSjOAVOwpqFkIsrW2e1ra1?=
 =?us-ascii?Q?e86npcLulFR3o55ZRYUMLDLmNZdOBtmNzfCcviDFP38Qaog+S9bDbG6H1E2Z?=
 =?us-ascii?Q?d0X5f511OvAMqt6xhdgH+AbWgLX+SO+yoWpi5jITvL9TaADipU//8gcn6LMY?=
 =?us-ascii?Q?hFw6EP3DBYUoGu+zkI99EcMMBsaOtRBFL6B8i5jjFo1neFc72zMcKMXBHMKR?=
 =?us-ascii?Q?bQOXU91HFQGBrYVCqekxZ5wgcBQpcUjYqEw/oSrGiJ5naemhMRn++1MchAyE?=
 =?us-ascii?Q?PQiSu9MzDpKOQdhH1AZrq5rYKFx3j6/xdAqly1mOOg2yYRJr3hBsn4wibYo1?=
 =?us-ascii?Q?9CwfaQjvs3GiScsPgxqf++vSD3w/OfU/4C1eZbsSf8qEl7Q590YfYpXSEwDY?=
 =?us-ascii?Q?Qa/XoLFPp9UyaaxMKkthub8CK50xjnm9?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:50:57.9954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729f2a5e-4d56-4437-d753-08dcb20f71b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

From: Jianbo Liu <jianbol@nvidia.com>

Add this implementation for bonding, so hardware resources can be
freed after xfrm state is deleted.

And call it when deleting all SAs from old active real interface.

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 1cd92c12e782..774d7a39723f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -581,6 +581,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 		} else {
 			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
+			if (slave->dev->xfrmdev_ops->xdo_dev_state_free)
+				slave->dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 		}
 		ipsec->xs->xso.real_dev = NULL;
 	}
@@ -588,6 +590,33 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 	rcu_read_unlock();
 }
 
+static void bond_ipsec_free_sa(struct xfrm_state *xs)
+{
+	struct net_device *bond_dev = xs->xso.dev;
+	struct net_device *real_dev;
+	struct bonding *bond;
+	struct slave *slave;
+
+	if (!bond_dev)
+		return;
+
+	bond = netdev_priv(bond_dev);
+	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+
+	if (!slave)
+		return;
+
+	if (!xs->xso.real_dev)
+		return;
+
+	WARN_ON(xs->xso.real_dev != real_dev);
+
+	if (real_dev && real_dev->xfrmdev_ops &&
+	    real_dev->xfrmdev_ops->xdo_dev_state_free)
+		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
+}
+
 /**
  * bond_ipsec_offload_ok - can this packet use the xfrm hw offload
  * @skb: current data packet
@@ -632,6 +661,7 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
+	.xdo_dev_state_free = bond_ipsec_free_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
-- 
2.44.0


