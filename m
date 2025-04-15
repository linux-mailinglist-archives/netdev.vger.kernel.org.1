Return-Path: <netdev+bounces-182750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34459A89D40
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF851189FD72
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4DA2951BD;
	Tue, 15 Apr 2025 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a3OZZUqX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B12951B2
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719154; cv=fail; b=QdN99K9yBGT9/0IUQH5JGuOm++AdCMsfbTTRyfRSAjTMvTz14UeOfL2D5URk2Wxa7WWY7QhUJb+v2oOQ3FAG8xumUA3ysGTx4+5oONndX+tePRfiz9e+945/RbvPwcoQuq8EMTgELl8FM+H/W5p5NAf6ggARDvG2DGpeZljhWCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719154; c=relaxed/simple;
	bh=yJJupirSlolL2KPsdxg6ykFweFrR09/wRzT/89lw7ns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IG3Q3w3nDRLfTMos9FsGN+cd/gYdww+yZBaZlZOrUgY0JNY/1jg+NwdWld8FVR1Sbb5F7SB4Sq9R5zEGJViUXwBxxJDTV+aXXN2LjLRaDdRqic2AM3rxH0v+0Yq5uMfHeRKkUS5c4ddVxm2p5R+Jr8/MR4junO2QbfaaC+XF0PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a3OZZUqX; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pjyx+Gkec36zHsX6BJ3pr4lgAXMjEqpEnI7OBeAuyzeihDzVUkNA7LspHEpmYYkSLmehrY7G/xNOsupiscChlUsnuqWXbIuS8gA2aS43ReaDgtMuAkL/zGCcFhikwhaklhyGZIDAGE0+Wefrndr7pNe9H/IbP+EWP55dBtLHhUJAqoPDzLyZ88tRGjoArMuefRHZA1CYVgs2Irv15mNXXt6hykZpXngdS+GcKHnGROhUA6k0Z4NV7vbWhLjH8z1jPxFCq9zMH6a6dyEt4uP1Z4sXwQcRN7Vv/c1y8STOOdtsFjQdkNfwpCI4oXo7Grgo2/cU6b8tFnt+FK6t2qf5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5X52xqMCxrm7U7N0E87qmY4aBnejKgBx/paEmo40CU=;
 b=chvLUmfwJVJKMbnJuuOb+Ubw1rmTvgz69S3AB8IcSm/K5I6WdAaUJLqCDMImmiQjVUiDEaIonTHH8keesz9Ql7Dl+yHjfeNQ8z0fK0EfcHdeh0Ann0hHHrwblaMRkxfsBLa1xvF8e07Mt6d9YI8GLsa8NR2vJS8i9zuA90A3Dy6VD2CUAWc9fyQovszk1D7KWjFrh3BZnDUCja91qEqaoUa2q9BXSmS9qMz6NFyq2272zBsDBmti88aFwzDWzjRbuoDexv0B/+6xr8ctWF2e84gMcxLB41kTQWeETQ1aYhuBl3U5yXF0q5FAoLOIitA/DnxfFLdOIXG5lUKxNxFSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5X52xqMCxrm7U7N0E87qmY4aBnejKgBx/paEmo40CU=;
 b=a3OZZUqX7f5eRlrGKBpPGkIQrfQZo8QoJ1ZSqn0VJ4Xsb/yPlmzE9e0tXd6EEq0fsuxj4R2/kxGXTFxoIDfkIisavYaB8fvVfmlpGbaasdF4bLZvNcKq1WxO192fp0nWE9cF/nKB0d71cxTZva7T5Uonrz6Wpe7mWA1zaY3TrH068SSbABvNhSlT1mcli+DJ1xldzqdjOrLII4naDRI1zwZ3z26uccCEXdyoHxGUhxpzrtRCOG2C0Q1Zh7Lj5XzRZIEauNX9xqQuuF4VznzHyawYLm4rz56O4xH9EgIro0LNBSnPjdr527LrJLbG1FW/BXoUSQU3DNal749kVdLIZw==
Received: from CY5PR18CA0003.namprd18.prod.outlook.com (2603:10b6:930:5::10)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 12:12:28 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::4a) by CY5PR18CA0003.outlook.office365.com
 (2603:10b6:930:5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 12:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:15 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:12 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 04/15] vxlan: Unsplit default FDB entry creation and notification
Date: Tue, 15 Apr 2025 15:11:32 +0300
Message-ID: <20250415121143.345227-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
References: <20250415121143.345227-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7060a6-173c-417c-93eb-08dd7c16ca6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wsF96lmqLYXB29FUorxXuBy684idTLtOC4Jxq4UBRBSZpx9x4U0Po/fzZXky?=
 =?us-ascii?Q?WGfPPg9E9+v4xsBugK5FS4D8JuoeOZmb3GgkO4YDxpoeP5JC24D3gM9lFq6h?=
 =?us-ascii?Q?36FsI0rgnDfxuiTFRQJc3gGyAoD1rEGIoB9/hEdJl2jtn/ob2GXo/cBJzPy2?=
 =?us-ascii?Q?7qrI8xl77BDYKL6eRIpa4WItKUJDHkb3q3cINeWR/MOcfh9tJjiG5F3AZD3J?=
 =?us-ascii?Q?sn5qcvlkMo8PMlIUYnLZ6EebCiJ666Top4/iD4UlsQz+CBpSZd8jR85ksJx5?=
 =?us-ascii?Q?I0kR5QCCc9BKZqOcYfc46VMrAbsDMFKhTRzgSvoBpJqE8Rv9qAGEqMxK8/9z?=
 =?us-ascii?Q?DwcHjtAlqOjmPPuwQzlAwlI6l+Gaj81RWc+/yiLDLpWqCy8NuK1f/W9nhP1d?=
 =?us-ascii?Q?uYBeLfLWjP32e3TNYw1oLNkh4kJL7sKoggrLexIzNf8rDQxkG6KwsOIZkc8n?=
 =?us-ascii?Q?bQQtZb/KK3yrW+LQYKHOBb+yuO/L3vqGLucHCzD+9Y72LOWNp/bn6YcSatFw?=
 =?us-ascii?Q?EGGmaULPhRu9jo2flSpZht0VAOfYMAUTl3pSU5HFXJsAuInnvXuQILtz9N7v?=
 =?us-ascii?Q?/y9AjhJ3LQUHjdWSnH1/fPEuFjM/9PZUvXVYnPxZmfTADtMD3sSvuvoVO2S9?=
 =?us-ascii?Q?1i0FrBef4zemwR7e6S878y/XQvkOgxOmfTDSUaHNJVHZ6l+p+7xcOV+qhyfz?=
 =?us-ascii?Q?MhbpXx0uBdscusj6+mUYK+CxHzl06IugsAXzwF0M9r7u7yR4xlfDXQ7eC139?=
 =?us-ascii?Q?uV0dKr4AEvaBgJUGSflMFnMTzMC7FffOwqAaOWs1sGwrFDBawTiRkbIhMMna?=
 =?us-ascii?Q?Dw/nuH3nKMivq36EATr1g05ZxOVGuaxCuZ8+ZAPqoItW4wxE0tyPifBuLj7L?=
 =?us-ascii?Q?+ppm+NLWSuYAi0tsFBZ3R0xnHaj5xUEi74N+bSG903yki7DU+eZNl4q8FQgl?=
 =?us-ascii?Q?Xe0TImAUnJ1t7h42Cx+ft3ZiG9XL0HZxE7uxPrSc3IkUgt1QJANQShqE9G56?=
 =?us-ascii?Q?cy8WM7rcsdLrIZFt4u//XBhne5NMZN7i0wbYGrawH1iY8fJ3IJtoqnLQNNEy?=
 =?us-ascii?Q?MepErzIJmRwPyE9Nm0ewqqUw92YnwwfGw4hXBGvGry7Xr5ksoEa704aeisXW?=
 =?us-ascii?Q?Wqeu1NqNXm9acNfcBnRtS9vzCmC13lI5Ugdsmb3z6CUukh7e66NvQxDT+fIE?=
 =?us-ascii?Q?fLZEdVz/Sxhv//lnKvlwN+aOQc3AThH/nHbVZnC8ikabHamNrP03sqcEsdNI?=
 =?us-ascii?Q?WtfQ/5DOxfbLF49yedhq1iHsTw3+kgVV9QHW0Ppdffr1lGbYIrIYzGRs+F91?=
 =?us-ascii?Q?EWOnDvgl1TlBrXiSB+U95dGl19AM/b+LzVPNLuAIJQC9l7B9ad0uXSGjF7Zd?=
 =?us-ascii?Q?I+oZmf1ZtWOwbsCToat6FacEU55oh+njW+wFVrdzIO+/FF72ZwpvP4a9hr1q?=
 =?us-ascii?Q?ctJNY4Qx7LPwUANDcdpVS1Lpvix7LruJxAAi875BfX0+cKYwtvZw7LWojkFG?=
 =?us-ascii?Q?KQG0X+oLDCNBKZkjZQEXaEc8CZTw9RSjbFRF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:28.2038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7060a6-173c-417c-93eb-08dd7c16ca6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951

Commit 0241b836732f ("vxlan: fix default fdb entry netlink notify
ordering during netdev create") split the creation of the default FDB
entry from its notification to avoid sending a RTM_NEWNEIGH notification
before RTM_NEWLINK.

Previous patches restructured the code so that the default FDB entry is
created after registering the VXLAN device and the notification about
the new entry immediately follows its creation.

Therefore, simplify the code and revert back to vxlan_fdb_update() which
takes care of both creating the FDB entry and notifying user space
about it.

Hold the FDB hash lock when calling vxlan_fdb_update() like it expects.
A subsequent patch will add a lockdep assertion to make sure this is
indeed the case.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 915ce73f0c87..d3dfc4af9556 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3943,7 +3943,6 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct net_device *remote_dev = NULL;
-	struct vxlan_fdb *f = NULL;
 	struct vxlan_rdst *dst;
 	int err;
 
@@ -3976,33 +3975,29 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 
 	/* create an fdb entry for a valid default destination */
 	if (!vxlan_addr_any(&dst->remote_ip)) {
-		err = vxlan_fdb_create(vxlan, all_zeros_mac,
+		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac,
+						dst->remote_vni);
+
+		spin_lock_bh(&vxlan->hash_lock[hash_index]);
+		err = vxlan_fdb_update(vxlan, all_zeros_mac,
 				       &dst->remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
+				       NLM_F_EXCL | NLM_F_CREATE,
 				       vxlan->cfg.dst_port,
 				       dst->remote_vni,
 				       dst->remote_vni,
 				       dst->remote_ifindex,
-				       NTF_SELF, 0, &f, extack);
+				       NTF_SELF, 0, true, extack);
+		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
 		if (err)
 			goto unlink;
 	}
 
-	if (f) {
-		/* notify default fdb entry */
-		err = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f),
-				       RTM_NEWNEIGH, true, extack);
-		if (err)
-			goto fdb_destroy;
-	}
-
 	list_add(&vxlan->next, &vn->vxlan_list);
 	if (remote_dev)
 		dst->remote_dev = remote_dev;
 	return 0;
 
-fdb_destroy:
-	vxlan_fdb_destroy(vxlan, f, false, false);
 unlink:
 	if (remote_dev)
 		netdev_upper_dev_unlink(remote_dev, dev);
-- 
2.49.0


