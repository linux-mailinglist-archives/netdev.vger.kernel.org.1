Return-Path: <netdev+bounces-116547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0DC94ADD6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39DBB2D48F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E6313B58E;
	Wed,  7 Aug 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PpAYUZ5T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7213DBA7
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046833; cv=fail; b=Khl7LQrM8eGhEiSu2cH+MeM0w/W1cDX9uiFwUTCvVWby8YUDrByB0DVo6N3xCEMho5bFkhA/xT8w31Iwg0BbTE36DNeSL7/NXuRMIUEIBHF8N3SqaY+gMV/mSeB3xIQrt4MJLaJF7qxr99sl421hRG+c2yKk9szJ3wTwKrFZVFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046833; c=relaxed/simple;
	bh=Ovheq94mjdMTrxQBr0Vq6mSPay+HXzi9EjlbQeb1q/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCvsDcvF3xpcNi4edL969k1FPlmx+CrdthkZHvk7smz866DALKfBVHWT+54LvpTHa6KQsKmbvzTezHtFYcfHSK1XXwtq83v5UbljAgPoU9UVOgvhJ0wy87R749iPFXt1Ad/Zf3KFPRzdAbaAXKeLZoD568NBCWmHenaNky14VV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PpAYUZ5T; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hx+mzZMMgFxgpKwLSlBmWwEEH4F2ix5SU4DZGgkIEJAlYB8uHPTABs0Yo6YiSCrZKm57mHqQTAFtT3gjKya+6EOezorBPU16z4TGtF4UXbWkWuXCfjiLo/w1BrIAaUsyjvCkcS6mJ0xfKu63eEUV7MnIl+s4I5U0hxRuoM7UXOIcR0M9WmgOlyPq0bBO2sy1scBSOnyz1KWs+WDf97ITEuBde+eOnbJh7nEmuqYH9QBYJHbOpkHSLtC4VBbJpTcD60aZSuVzrO9SH1yDV4UmFGLhcHfdSSeYX20j/1MND0hhkz2nzvj7pKzh5VW/JivSPX4EStlcGzML7eKjElnVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5DdQ65MeH007xEL2asjCl22eEoBUDK1g0zUpUQlEVs=;
 b=LjZIkQukpFHn9OneO47gc+eiDA1BEGMPELg7QOj/VbzNKGNJWLxsaWgEtc4sK06cU9t9UFzO1GL1Ct3wTPuhPRFu9D994MnoIpSXHUUWjYjOd/4a/Vjt7ypoeTfOiMnAhLF7bvxbaP17T4yFRz5Ee35DkFL0M9xn89WSACpNpo1XLv1eXUIDHtLrdeYvNoBr98gmV1rJvaJOwlbH+KUKUTPSx7qcbq3+1o8ykJpBSyW9h6U1yja+wnr02EHKLY+DA0lSvpTOq0Lr33llhxi/jQSgSCN2XjE9POYuJgvqsLroW4bt52wiPnjXbPE3dXchQ+BD7kSC+2hQ4g2zOHWmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5DdQ65MeH007xEL2asjCl22eEoBUDK1g0zUpUQlEVs=;
 b=PpAYUZ5T7XDDMvWXMSqSfWCNEnQTsUXJLD84MBbu1GGOLweowOnTGo58Ce3OcNzS4ccvfak3VnhTGV6peC9OgJ8YX7ntS1YG8/zqOlI9hhEYQ8yzxxNG1yoQJI1o5cTHRAjX/6abVSpCH5jBbXSiTrqr+oTV8jKq1+ATRrgvPrM=
Received: from DS7PR03CA0341.namprd03.prod.outlook.com (2603:10b6:8:55::23) by
 PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 16:06:58 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::af) by DS7PR03CA0341.outlook.office365.com
 (2603:10b6:8:55::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Wed, 7 Aug 2024 16:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 16:06:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 11:06:56 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 11:06:56 -0500
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 2/2] net: ethtool: check rxfh_max_num_contexts != 1 at register time
Date: Wed, 7 Aug 2024 17:06:13 +0100
Message-ID: <c07725b3a3d0b0a63b85e230f9c77af59d4d07f8.1723045898.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1723045898.git.ecree.xilinx@gmail.com>
References: <cover.1723045898.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 087147b0-bda3-4084-d9e9-08dcb6faf6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gf0Wh6h0VDx3j4abDT6/Er5OjkAYEwWVOiHrthh6QxuC8fzTF8CS3Ki5jAMh?=
 =?us-ascii?Q?uEn4UJ8S9XKPVcaa+HbA1IYN92MQopeYfYWAZjNglFmc+G3yBYjcSBzZfAgH?=
 =?us-ascii?Q?lBlDqLjBTFlF+TxJaJcS9mvTIkvNJdlUVAKBSOeR3Ggaqg9udqN9lPMaIIjQ?=
 =?us-ascii?Q?3BMCKo1gqSw36OHYL7b7112Vql0Vef0qx/6+4j2lUDv2u2wQ7la/pzSjSvrq?=
 =?us-ascii?Q?ypx2qFIYLUHxHpP1Q7uy2+snWULNq/DJ8PNC6d4js3KYUJtyjh20DdGp/rh7?=
 =?us-ascii?Q?GAP0kx8ZqqIZhb3/KCimolSS4rvfqJWqDxbfKRNM+wOxuZX9fFsXqJx/2p73?=
 =?us-ascii?Q?Tmkj+1Cy4tp3QlgpoZjllvpRXI7w04FiMJMVoNpFwn4w2+PBwk1cJkmMdcrM?=
 =?us-ascii?Q?g6U2VBgWRDVfj0yjpON6yY/pdSOiwFnJJuXoc2SSKjMF5WWwn58TxtD5/RYr?=
 =?us-ascii?Q?j8FPjj2uhTqWz2aaOkym/7pzbnvOVaVNFQwxv9r5RpJv3C8BWpcOiLYm0fiR?=
 =?us-ascii?Q?qPoQLj4IlEqtms9sHU5XZMrWJeRAOqY33dpEjKmv8WzXO96gvyKsWOK4t8it?=
 =?us-ascii?Q?W4r0ee6ol0rzDCNLR8HNZM5zWwJ+x81GtOrCVgjE/7OLiaPCpKyWUWtSrvC2?=
 =?us-ascii?Q?AJ5AYRHX18kDYnj1LEJjBHDFYRRLMp1Fe5NEbcheInXjdRhTqk5EZeawJ4lB?=
 =?us-ascii?Q?eS5zRTRCbQkp0QR+6gVgtpHsMuNEYqAwqAqfJxRpnX1WLfteJkI2z/0ZoqxY?=
 =?us-ascii?Q?o5kU+yoeHbbCfoaK1RtviponCZ7XQbPpidf+ZK+OsJJp/KJ49mnTd18rWmPr?=
 =?us-ascii?Q?MsVDbVtwsX4JCfsK4M2sPeGWxNgCTIm60+ES8N24OFl93xjKt/o1XPzD1jSQ?=
 =?us-ascii?Q?cHcsAFwt6d5MVA8h9XwaJsGwEsTCWDqjNiPQ2Z7OqY/drQyQF8QpHWauviFN?=
 =?us-ascii?Q?mVAQC09Ja3ciGMw9w8ut2o+t5xjNK3nxGC6F4XH8efI2/+6rjDskp79U/yLl?=
 =?us-ascii?Q?69CDGWUfDfI7Muf7aqam5xiyrIfr7D1tdDRWfQPK8IbrJqmxpU58zpw9QZ6S?=
 =?us-ascii?Q?XDZcgpq2jORmg8Zjgw7OkMDgOFBrcj18uw8lIrvgg9+AADBpsEX1RFGRIJHc?=
 =?us-ascii?Q?VxChlpYqwObNpPVdbkFYvPe2+ZEJuqXN3EsAEcmIhNP9sssBNHzeXxpT3lXG?=
 =?us-ascii?Q?MY4Grhxn81971G7+PqA/sTXu0bkUIXq6/IXKcXIZ7mZCp7UL7H6n2D0SgHID?=
 =?us-ascii?Q?YIbeD6r2pGy3Qtgb1N7DR5mLSNBa0V6uMXuNcMGoqjA7Y9Q7nuXe4RpLGIlY?=
 =?us-ascii?Q?IK0AGLMUbV1BUOJjFB5yL/uaeztTiSAR1+cj7xCbjOBFhYTNat8L3vdJocbK?=
 =?us-ascii?Q?XEcJAKhVRhcPNY5ayzoFXMye2BeuDl0SwHUC4FRpQto136Fpliu+HXpKPso0?=
 =?us-ascii?Q?gb4CMV0gVN9PwhIgsxgsDVLvs6VUKb1S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 16:06:57.6153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087147b0-bda3-4084-d9e9-08dcb6faf6b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564

From: Edward Cree <ecree.xilinx@gmail.com>

A value of 1 doesn't make sense, as it implies the only allowed
 context ID is 0, which is reserved for the default context - in
 which case the driver should just not claim to support custom
 RSS contexts at all.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 net/ethtool/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 07032babd1b6..5f714bbbef19 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -654,6 +654,8 @@ int ethtool_check_ops(const struct ethtool_ops *ops)
 {
 	if (WARN_ON(ops->set_coalesce && !ops->supported_coalesce_params))
 		return -EINVAL;
+	if (WARN_ON(ops->rxfh_max_num_contexts == 1))
+		return -EINVAL;
 	/* NOTE: sufficiently insane drivers may swap ethtool_ops at runtime,
 	 * the fact that ops are checked at registration time does not
 	 * mean the ops attached to a netdev later on are sane.

