Return-Path: <netdev+bounces-229320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE7BDA973
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 936894E17FE
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E792DC766;
	Tue, 14 Oct 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bm5An0O2"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD629BDAD;
	Tue, 14 Oct 2025 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458620; cv=fail; b=CdMqb4QCKwrlgzgEpy/D5dQAfe3lnFO5bmOL5+S78R0mFWuTn3WoAJTubtVBbMalvI7rwZNB4L/WM2Dhrf8gEKbdhrbu7pN7TYW6uyfziD/BSq3CRZZV5xVrapXvb5HTL0acXHXZ8X7eBnAIJvMwv8wK+yowOqiD00mgBuzHSEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458620; c=relaxed/simple;
	bh=DiHrymMnDW6VRW3gmYLqGHWiVZ/Qx5EoIc7Z6XO89FY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hqS0dHGUXAqFRakKlF3Jum6n9ifNOnZXCad+MtEB5cWdyinj8lG8eAiHiJ0PcIu1pqZf2vVTUAYdvtFl2aXeH7649yQrxRINRvEX3RGyvBAnLfkWIlnTbq5toS4sYux5f2QXtBXM3ulyDL5lWE9SHkaBzNSiyv5v3v/QtTF0Hus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bm5An0O2; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDaBYgXTGOjikzRt090x08R9dLJqhB675+mTs8FMgySGwOZDx5HRsmUDTTrvkuy38GpoBUCYEwIyI2/a7X6qTWx0lArOicvNTAW3AvK8RbwH7s/CK0tJI9BIzjM5lVn1+7oKLjXgZ2UwD85x9OY3d5Tba2Fl4RsxjyQGDSqIDxnFjhyFuWZyOTn8i/u00ueY0zE5Id6+kgA4Ksf0HQybuDTDyDZ+eNq0Qk9Ru6LzST6kV49LljxO26NqFH1BTQYWB3Rj5q0MYXGUshL+Gxvcun7D0HPT+hDAdyYjm6/8wwqE5rlqKyash4+UDXLtw9Nyb0x6cbCkrkDRd9FmeCfGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97+vnZakj4YnOyFwuwyLdCcmCkAjaS3sppnU9mU7aWs=;
 b=Ta9BWZdJmeXdw27vDTPNv3JZhmqXfwgdf5sU+DDAv2+2F1kBm0flaW5oFGDGMNmHGGgkcRUpGX9wYQ0+BwK+7A5Af+mcgWZyWVkbyRAxFsWcsE2U9jWuwyZEWXzzbF5q42VBA3ttIfyxLXR/zdVWUeXrB2vLfrOcehgHIWFHMXiDVugmFlIyrypxmgpIH73EbGzWQrdbuxBFkcqKCXrd0Y6ltj7BhWFrR/NVhhSqdMtMOsscR0aYY+HrUTpEbFLo1r48rXBfWQWbL4FnlGVYLKx9VL8jfx63+8ImXAkC32x/mdsSkZQN9UufCrN58LJ+JsyKLu7iBLrvpTkSWjL/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97+vnZakj4YnOyFwuwyLdCcmCkAjaS3sppnU9mU7aWs=;
 b=bm5An0O2A/7f7Qi+Dh6VG3KJqydOKJ+dBrIHss2WblFE7Fg/JtcccQeQENMETyS9MeenaMoa0oNX+9UX1sRXRjfsrgSg/SLO8zJOdT/DwdppIaLud7v0DCyAoar/d44NH3F+UmUu+r73k79DelyR1KwVRcb3nUjP1zxEvB3OWpFSG1J7bov+uUqSiZ8iqjF3cYBqCe7Fo+dmcKJ7G5dJXpPjeZKM6hp+KqRu8rq/JDG11JBlNJ8J6Y0QolzcXyZLjAusQl0m3tMgDqZtuTYK5de1mX8Gwx1POXHHOxLUxu1kxiFG+m/OtEx6UJWmDrPPEgji+1TF+Tget+FOtUB+gw==
Received: from DS7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:3b8::26)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Tue, 14 Oct 2025 16:16:50 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::46) by DS7PR03CA0021.outlook.office365.com
 (2603:10b6:5:3b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 14 Oct 2025 16:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 16:16:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 14 Oct
 2025 09:16:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 09:16:31 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 14
 Oct 2025 09:16:29 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <cbabroski@nvidia.com>, <davthompson@nvidia.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
Subject: [PATCH net-next v2] mlxbf_gige: report unknown speed and duplex when link is down
Date: Tue, 14 Oct 2025 12:16:31 -0400
Message-ID: <20251014161631.769596-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd41047-7126-4658-3053-08de0b3d14ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhTo+ODyZUkkP+S2KbEwc/hLYbirQCAmCOVoaYie9OKm4zDOfoRuKJL+vrdM?=
 =?us-ascii?Q?DTsYv+vQnp07+JmqbGIFChcDTMNbsrPm6a0EsEQYYKhtOwOm5wXGUdCtgeap?=
 =?us-ascii?Q?b3iMJvRrOGpm7N5QCLkONBH0w8nadiSwaOUmqci8W4gcYlc2NQG1N0QXvjk8?=
 =?us-ascii?Q?QLNYT6VKsngfVZukrv8SW5Xs2ucVlCOVTJzDRUAUKX8ERna83+axtoj3hq/R?=
 =?us-ascii?Q?cCigsgjNh4I2efFM64LNrswvQ+nfKx5daKrNbqbGl9O0QCKxulwAzXcj/uQB?=
 =?us-ascii?Q?IqMQOJkGmxSCFtQQAI5B2bWcTtsAz5drLIWwGnx7HRzV1RnC8LOuj/3KDyIe?=
 =?us-ascii?Q?lWdXFwu0eVicq2X4wKtrx7Q881irRxfDMR2B8O99vUjdKw+maWGzLVJbspPY?=
 =?us-ascii?Q?gHjfUxemWl26XGc1Qw3V5urSA1TsZ0KfPxpl06aQeJTmMdpGUWcgCJ74U5eN?=
 =?us-ascii?Q?zIa5II+Rts5t7jQPLiXcCCrWbNOhqktf1laXdY3botjuQmHsh99E8ZbKl8z8?=
 =?us-ascii?Q?BZRJlZhFLkd7mvNaogtt+IbZEjdG5DaKFyyqSDY9K1G5eMWumWSkzB99ZMG6?=
 =?us-ascii?Q?JY6fjHz7xxUtvRDYW4s9ZjdHcvSXIZFFL/SoK806P+mIjpekeXcNxkpOY1Tp?=
 =?us-ascii?Q?4bbax6KMNuut4Y80E7Jk2g7o2QZ4qBm9iHfoYbS+GVYfRVGK5XDMEjSnq81e?=
 =?us-ascii?Q?zr48bC7i6M8sL0sEzxsRfPcflqwncYYEKhnbZigNEDDIGTOAu8Zhj0Jx4SU7?=
 =?us-ascii?Q?aOz29orKgOBiJQ3av6WbnM808TIuA2yYljCcgw7UyJFWfGPEf5hxL4AmK2/0?=
 =?us-ascii?Q?XrZGVWT7t4+Q/G3UzK+wngdNXiY8rzCME3i2hAyqH+v/pF65Z/H2MbHeyuQP?=
 =?us-ascii?Q?vc4gDHKkWvOXYMfHkv6/MVxASDC3aIuzSFuIpBT4oe96rinyCTrSTps+eupu?=
 =?us-ascii?Q?KlJxAb/OxtOqp91IbohJ0TAUlvqqr/87+tJrkoB4/i3bqNZNlKRlNLPvkpBq?=
 =?us-ascii?Q?0hUZNXZnKbwToP/LnmI2fs47RZiUEbs+QH9Tx1zQuHRfK5O5twEe5557b4nW?=
 =?us-ascii?Q?Awo9/JBvS3mfA80g1MJC59JNw20wBZVWK8pCi3d+gqv4gexGZiIXLvrImLo8?=
 =?us-ascii?Q?H5ZqBSJhL+lpHx1azxQ4rS9FQGGOK1tfjaK3Gpu516oeRos63gfuZIyWr2A/?=
 =?us-ascii?Q?Nk+EgH+4GzQCsir4fhm/I3p4Az7y1gCNebAwvu+lPGIlTIDO0mCqMi3iDUD3?=
 =?us-ascii?Q?8jHTVsXTIpZ72wGZ3H5cev/q7xUScSNBlmHjdiYjhKnkw1cYMU6El/6wv1zb?=
 =?us-ascii?Q?E+gvmblKpZNLpemmZTP+JhDPE0Q3kRQbkbKV0cHtlO0uwBlJsX0ODdCTvDEB?=
 =?us-ascii?Q?lVC+n3mlK56iDG6SLl6OldbGjnrM/mNmadkV9u1M4mLiG6moE5MrHg7ZeAj/?=
 =?us-ascii?Q?sxVPPAvrmYT3ML0AUXZgw8uNkwby9pW9FXMR740p3LrhngyUBqTADp/E3Ehe?=
 =?us-ascii?Q?8JrNcMbRgKsTAL3afqO9zIP2MgcHIRFRgJ6mVnjyR2eISB3igG+7PDqIOpFD?=
 =?us-ascii?Q?lPbmsN+6EYfAl5Bfuw4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:16:50.0661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd41047-7126-4658-3053-08de0b3d14ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837

The "Speed" and "Duplex" fields displayed by ethtool for the OOB
interface should report "Unknown" when the link is down to match the
behavior of other network interfaces on BlueField (implemented by the
mlx5 driver). Currently, the mlxbf_gige driver always reports the
initially configured link speed and duplex, regardless of the actual
link state.

The link speed and duplex are not updated for two reasons:
  1. On BlueField the OOB phy is internally hardwired to a three port
     switch. This means the physical link between the phy and link
     partner is always up, regardless of the administrative link state
     configured with ifconfig.
  2. phy_ethtool_get_link_ksettings() reads cached values that are only
     updated when phy_read_status() is called by the phy state machine.
     Doing "ifconfig down" will trigger phy_stop() in the
     ndo_stop() handler. This halts the phy state machine and sets
     phydev->link without calling phy_read_status() or explicitly
     updating other values, so the speed and duplex returned by
     future phy_ethtool_get_link_ksettings() calls will be stale.

While #2 could potentially be fixed (assuming this is even an issue for
other devices), #1 is unique to BlueField.

Implement a custom get_link_ksettings() handler in mlxbf_gige that calls
phy_ethtool_get_link_ksettings() and updates the speed and duplex based
on the link state. When the link is brought down with ifconfig, the
driver now reports unknown speed and duplex to ethtool as expected.

Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
v2:
  - Update commit message to clarify why phy_ethtool_get_link_ksettings()
    does not return unknown link speed and duplex when the link is down
    on BlueField.
v1: https://lore.kernel.org/netdev/20250813163346.302186-1-cbabroski@nvidia.com/#t

 .../mellanox/mlxbf_gige/mlxbf_gige_ethtool.c  | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
index 8b63968bbee9..c519eeb8ec48 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
@@ -159,6 +159,30 @@ static void mlxbf_gige_get_pause_stats(struct net_device *netdev,
 	}
 }
 
+static int mlxbf_gige_get_link_ksettings(struct net_device *ndev,
+					 struct ethtool_link_ksettings *cmd)
+{
+	struct phy_device *phydev;
+	int ret;
+
+	ret = phy_ethtool_get_link_ksettings(ndev, cmd);
+	if (ret)
+		return ret;
+
+	phydev = ndev->phydev;
+	if (!phydev)
+		return -ENODEV;
+
+	mutex_lock(&phydev->lock);
+	if (!phydev->link) {
+		cmd->base.speed = SPEED_UNKNOWN;
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+	}
+	mutex_unlock(&phydev->lock);
+
+	return 0;
+}
+
 const struct ethtool_ops mlxbf_gige_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_ringparam		= mlxbf_gige_get_ringparam,
@@ -170,6 +194,6 @@ const struct ethtool_ops mlxbf_gige_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_pauseparam		= mlxbf_gige_get_pauseparam,
 	.get_pause_stats	= mlxbf_gige_get_pause_stats,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.get_link_ksettings	= mlxbf_gige_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
-- 
2.34.1


