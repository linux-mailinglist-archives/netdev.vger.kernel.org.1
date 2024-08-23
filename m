Return-Path: <netdev+bounces-121221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8247895C39A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 05:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9435E1C21C2E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9EA26AC6;
	Fri, 23 Aug 2024 03:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QL89FLGp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE779C2
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382684; cv=fail; b=k6hmwSUNqihHlp0kR1B4FqMJiJIO0QHPAI3fjnmgis02ioHZnWbk02aKitsHDJQPpFbgec/qaa1rwV7HXQ3xLozkTAvgO8/hSFLNy423sYR9IBaOvLn8iDi7pzQJ4z9UeuVR/JAOARFHfdBC6wLKHR1YuNrClbdwOF7ZDnSJrLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382684; c=relaxed/simple;
	bh=f79C9oDzFpjwrRYexsLQKbROlUZMeIzKjH5Lin56JTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozopyfzbUwnBxMqKyobAKx3bqmCcpkyj+mmusT34tOM379VGtsTxWZWy7dih7HqiWBpCaPTAbnfaVydAOUTsHG9QA+kqMZFB9hvHmOmJoomGEI1WTBcqgD3XGmm0UGMTrw30E8Yez5sCPJxuzYIiWgjC0A4mWacnjcCyHmpnBpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QL89FLGp; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqATBsOxS14LxrUqeEbK4os+h+ZN/qBapyw5gf0gLEBZ5xkDkvdTEBR6Agurtt2BfNUZKd5VG1YfpeihLtUlL8dkyzuk0vVl9pSV0uTOs59mzTcmgqX9ZaflSGPscuVHWXctVazYF1IbxeZyxjiV1OcvfPOKBw0arfUbV8ZQunz870A+nCZc6ibisLLep5Pjb6BwbtusATaYPMFYn2nn5WwRw4C5LnSjZMnR1GUh/WtjKAyh2auyW3Lq3pkdMFcu86V188Hulxey7SR2F914ly+DY8ApCE9KlGtOUhg1uCbN9iwiVQ3I/ak/qk7sI0ldqm2etmKX9MzuyHITamvkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7d08GM5/URHa8M8uJdlew0gJhovW/gva1B4nFNmtiU=;
 b=C0SgFsCmOhtyzeTU4TJw0VvmLd2Bvry/+mSGB5idz/aG9hFBEK5jOj8oXKGeVo84qniD/rM3X2kU1j54dJcATWKdmKBM+2vFDfeFW8yULgYa+VjiroL93wDNpKjtHzLOfOdfAvQlNBGFZzt83LtNibkVX6cVKH+v44m2pwXkDOCwPbj9BGWR6CRP/EjTb5jHVwpUocH2tQmwRUh6ZpwQzzaNlJcUSi/62IDTlHHaC63NCpdLh6KxCJDwzpdi6wKZq83UDJoEqEC1fZYfRlnZb10evH453jMqtPFFDowGPx4MiDsuO+MCSoq3w87aCn9SI1uuf5hNyix8Ev6MZHTq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7d08GM5/URHa8M8uJdlew0gJhovW/gva1B4nFNmtiU=;
 b=QL89FLGpz9oErqjmyCRxdCPJC6z0J5MmvDUvs+5/rvVz5sgigvmSpWw4JoJRCEVczxbsrQMEuMp6TGmZjrfE3dmLVZEB6vTQKP4ZMPn/1wl5UX7Lufd/OPjN1JjGBIPrOxcC1G5Ke48lV7XxrLnwT6jfnorghhgrAASNwCABMuXk6vIl2FrM1Qkfj5FtRQdMTLcGox9hw0HHicQqKyrRiNXoO/upoiERJx0OZyDjsE2uJPh27oIpmOscY4fCti+2REYepH6jZIfJ2TnJtRwTw8i6TZbhrjdZSZiCKLIF+GDni1ELuzqrAVQxeIE1riiTXTI5zFPMA3raKFsjrtgvpQ==
Received: from SJ0PR13CA0112.namprd13.prod.outlook.com (2603:10b6:a03:2c5::27)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 03:11:18 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::ab) by SJ0PR13CA0112.outlook.office365.com
 (2603:10b6:a03:2c5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 03:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 03:11:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 20:11:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 Aug 2024 20:11:14 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 Aug 2024 20:11:11 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <jv@jvosburgh.net>,
	<andy@greyhouse.net>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<liuhangbin@gmail.com>, <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net V6 1/3] bonding: implement xdo_dev_state_free and call it after deletion
Date: Fri, 23 Aug 2024 06:10:54 +0300
Message-ID: <20240823031056.110999-2-jianbol@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240823031056.110999-1-jianbol@nvidia.com>
References: <20240823031056.110999-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fb639e-cfb2-4e3f-9050-08dcc32141c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Chmvr/dtJVEO5Y+lhhvsx88KUEgOqecWXh5An3V67wYO/CWM99A1XCDXcfOD?=
 =?us-ascii?Q?g/AqDMYXmct8QpLAHyaz+uK5ZT9bdh4LEEpGx3PlcjnMTHRShy5ca0W9BhEF?=
 =?us-ascii?Q?Bguiyv+j7TjMWmqyjaDdBsCqb558/ZGkx3816xxcx3vN1nPrnVp6cGx1B4Yf?=
 =?us-ascii?Q?pmPSr6nsd9gnA8FKvJ2p/L6kRHsJ8U3tZD/RZ7KBo1J67HtsA30I89JWRJBa?=
 =?us-ascii?Q?S5Cu4xzJP9phZzif4DmZJ2zRMD9RzzJsLnpcPOh/vkm7rKLr90JZgaY/bJGs?=
 =?us-ascii?Q?qR2QSMUJtiE7c1aAol5MOj14Pu+IQwuxl4Xe6i1O1Cwot9Dlznw2vxbNG3SH?=
 =?us-ascii?Q?tUJmHDcrjNkFbzOf5J0jq54OJi63MraeRzSpJrNbF7AR2SUcnL7sLKXAiabp?=
 =?us-ascii?Q?w5C/FaszJtj/XMunQxUPLlSHiwzg/JCsZI5FnPbqTdIgHxIeytsGCtXGcKCi?=
 =?us-ascii?Q?pIgJJZ83deaN4o2Cfmy8Hk+6GIY24+z1LWi01teBL9eQc023aDYZpnEf1aIZ?=
 =?us-ascii?Q?9D+a+Asju6sI3QMuXIBBtUZcD6XqqhXT6ge7SJApDyPMsTml8EGELMxS9Z5m?=
 =?us-ascii?Q?g+NTpm2Yv/L6vEvzW5e/4fHST9d7KDbqy0JkxJLKq57ib5NGYrHDX5PC7SfW?=
 =?us-ascii?Q?TfG9YBuFuOJftEy8imEcR6wF8Tmtj0jBxjFPLzPqqvLnUezUDtQHAhNJ6YAa?=
 =?us-ascii?Q?nIwpBHXuK7Y2xJc+vvXCKUGA3mVkHnf25gscHwmilm7czgElqp4TUs4748qa?=
 =?us-ascii?Q?kJLtBMPMfjWMwkgvidVLp8rPX1tuSXvEvCvBj13I+GBKrGdteNLa72/LeSiQ?=
 =?us-ascii?Q?qhV+KJETwOEiGXE/+kAJ88T6M/L2lp9hdP9g6cX3aAFXFUNrGaIbFkqe5GuP?=
 =?us-ascii?Q?5z9xLKsx8rdjV+/qUjMQGmWo4OxqLlnYDE6tnsyAumhZRG8kCkQpYriceaR9?=
 =?us-ascii?Q?Wc6WwRyw0LIuZx2l4OtNDWWacO9Clhq9dVoA0u93hS+zNIWs/GfV0Dk4/znM?=
 =?us-ascii?Q?EdKb6ntw5ldNGg5wDzo9BQVGJGss71fy37D3bMOOK9JMOkNYaIuimaP6OXjg?=
 =?us-ascii?Q?0QYEu/ffQVMC+cyADwXLmBZNoWPFUgMcOlUUO9jXMsD0PPwCDbM9rjDv/ogZ?=
 =?us-ascii?Q?3x0bE2Y+odneB0n//zWjcONOaIp29UTFj8vdO3HrD4FDTNiYmCXNPxMXxKx1?=
 =?us-ascii?Q?WSr7n0eWN/gGv92kzrs/W+jDBymNaxk9FaJydhcp1T+5DBl/C+rdN/kz8U5F?=
 =?us-ascii?Q?eC1vNWM5ix226ytzOHnmFlpxzb2mxBFBZT/3xiNY+8rwMz0u/L7Z/qoSjCYK?=
 =?us-ascii?Q?cWdiKUnDWxk3Lvzyfi8vxrno9gRyZukHZDSPK/LfZS7cyBUiKqKNEoSct9n+?=
 =?us-ascii?Q?NHQzPAKG6ups3WZjGeVNE2etnDealw55R23Ms+JlEXhNpDSKLQCsRGFA8eNy?=
 =?us-ascii?Q?AgZgglk6xICJx1Oj47KYEotRXKHjiFRU?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 03:11:18.4415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fb639e-cfb2-4e3f-9050-08dcc32141c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818

Add this implementation for bonding, so hardware resources can be
freed from the active slave after xfrm state is deleted. The netdev
used to invoke xdo_dev_state_free callback, is saved in the xfrm state
(xs->xso.real_dev), which is also the bond's active slave. To prevent
it from being freed, acquire netdev reference before leaving RCU
read-side critical section, and release it after callback is done.

And call it when deleting all SAs from old active real interface while
switching current active slave.

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f74bacf071fc..2b4b7ad9cd2d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -581,12 +581,47 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 		} else {
 			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
+			if (slave->dev->xfrmdev_ops->xdo_dev_state_free)
+				slave->dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 		}
 	}
 	spin_unlock_bh(&bond->ipsec_lock);
 	rcu_read_unlock();
 }
 
+static void bond_ipsec_free_sa(struct xfrm_state *xs)
+{
+	struct net_device *bond_dev = xs->xso.dev;
+	struct net_device *real_dev;
+	netdevice_tracker tracker;
+	struct bonding *bond;
+	struct slave *slave;
+
+	if (!bond_dev)
+		return;
+
+	rcu_read_lock();
+	bond = netdev_priv(bond_dev);
+	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	if (!slave)
+		goto out;
+
+	if (!xs->xso.real_dev)
+		goto out;
+
+	WARN_ON(xs->xso.real_dev != real_dev);
+
+	if (real_dev && real_dev->xfrmdev_ops &&
+	    real_dev->xfrmdev_ops->xdo_dev_state_free)
+		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
+out:
+	netdev_put(real_dev, &tracker);
+}
+
 /**
  * bond_ipsec_offload_ok - can this packet use the xfrm hw offload
  * @skb: current data packet
@@ -627,6 +662,7 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
+	.xdo_dev_state_free = bond_ipsec_free_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
-- 
2.21.0


