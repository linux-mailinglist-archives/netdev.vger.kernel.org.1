Return-Path: <netdev+bounces-103247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDDB9074BA
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6574D283E19
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78B4145FE2;
	Thu, 13 Jun 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gv41Lj13"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD01145B07
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287867; cv=fail; b=Jvz2n3EfOLhLjEl4Qt5b73yFsWpSw7GNA83zWqkkKv3jzsZiIsMsA8b92F6k0yFhlmkp3czmHqJHjv6eEREXUy/H+lCNsOHSfBX4SylQIs73FDVYtXWGjH1Oy+Qp7YL9KaZkwS5JxZ3krvBlO53bVTU9w0rbYYYsHROL0nrr1jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287867; c=relaxed/simple;
	bh=szRxb0MBAlTxq4Ik5exYYv8w3e5HxrnfWZPM53Py9Xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3BUzfGuaD85dTJ8AfSnSzjH/ipxVbM9tm/cEXR1JYPYFUr4j1a8HRyCBhBEuOSsx1D3DcLZpcAKNyKUVx5A8mgxYZWwp0fM4C2u89sW+BBpqB2iBwPRH93w7xDwmEgg6O0CWkF1N8YuCGXEtSLv2ocfGOSnTvRmu3ioNQtCtWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gv41Lj13; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1WVD6K96/4llXMXo+AaDChDrK+xhVToSrjfQigsjRSgqks5tyg6jGNjv91GN0wYeS/UzttvQG46hUICotAvXSKX/KeD2wCw/SpZfkog3tdG/nRPLqSnilvPCQ7o2PV44qUKO1sTmeBeySUOSOKIFhcAr3CrtSMhJKQZAWlZYOXnDYplZhAf8N6Louhgx5oaz2cHaKMFikj+YrnW9UU4ij7B/azXnTAqjM3/CNiJlv3SLkc8kUb3OPTq05ytNGM/8O4fG+elgEfJV6LdtMeirYO+H1rsBMEykPFeYDyGhsQ8suTuP8y2/ex4EPC7KrQOzNnW8hTZCLKoJL9haEB4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXfmUURTI6Gpr9oOrOz+sWmxZ+WUrxy30ckEqgpKFeQ=;
 b=ZeyNI3XzfDg7yhTaIQsrENtz0Rkb0wO2rxkuJ33GtJKcPN4JftJ8mkovenK9/wldcgLGyUmfw8n5kxkeTwSDK3rAF0DDKRBGV5aeHKPLzipgZ+5GV9e6Cu7tEhG0IUEfyGZuNjg5ibz8HnK1Cr9q7aC6QDlPbraLyPWq830xApt+lvDQGu8moMBoFSJq1dm10fyKfEZOJkFwFPQfjZWz2TbUJQN5y0Wo5RqrRcH1uL44GY4ZaDGrW+/vKGm12HAkz8xzLJw6JhJ5agsVy/1fQFjIG5B+wupCiNYFUthd+9VobjQ9dh8p9ixgaT0Y3ljNJxvqmculQ+eY7zUfnrpf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXfmUURTI6Gpr9oOrOz+sWmxZ+WUrxy30ckEqgpKFeQ=;
 b=Gv41Lj132tKXl3WdlMcbZmWEiVlQvJEHrey2TY4SQdyKG6P+KOpCzBbEsm1e6y8dRNMO5PZ/KHvKYwU/KDL8WUipwvKjRkSppZNAl1vNJb1kcNk198Pw2lZgLqS/4+lusNNhTJN4+QtP1oADq1BwpBqdlMyI6lvlIlQRni9SwPqz75+XI0KRUbJygteUlXvpegVAJbtwKmeCzIO6l1CarrbT7OnPgt56sScbKLmNa5JHWmZKJznQLbRDEnlJCJJsDzMeshv0hgKNylUmE+jumHA2TXonbEUznCjezvu9Oj5aBCZo75wqNSfv1C9T82GG2WB1sOrryIyWFuAjyNTOFQ==
Received: from PH7P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::6)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 14:10:59 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::ad) by PH7P221CA0020.outlook.office365.com
 (2603:10b6:510:32a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 14:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 14:10:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:34 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:29 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/5] mlxsw: port: Edit maximum MTU value
Date: Thu, 13 Jun 2024 16:07:54 +0200
Message-ID: <666f51681234aeef09d771833ccb6e94bd323c88.1718275854.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718275854.git.petrm@nvidia.com>
References: <cover.1718275854.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 750d9e1a-4b1d-4bef-2a09-08dc8bb2a600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TpM70tb/2++rfqAFziG05CECQfoIHRVUlzEWNdPlutWQtSzt+6zf56jLpTAX?=
 =?us-ascii?Q?FcKF28+TtE5eojDdcgXT4t0ycxYxi/+EUsB/cPBaoASmThR/kHWWN/KXzVtJ?=
 =?us-ascii?Q?0nqCEZPbr7m5eidaYDmIs/bkJfaIkWpjWfRuGJlq0Pt78afcCgXvnRL2tlnd?=
 =?us-ascii?Q?rSyFtc1MitGOxyp9h1Tq8AECXkoefJTYHbShogZAq2fSeHaoSuBAY0lpKsHK?=
 =?us-ascii?Q?ZFBDUXuNEba9cOx6yqFGv9ejNeE3hJP4Aph1t2ACq9VNJnVgN7R9gGqy6NlP?=
 =?us-ascii?Q?cMrdT3AEhwO2ORUN5mD7uPHVRsNzTqCPhGA0z0MEIt0//z4HXYQSfq3TKM5V?=
 =?us-ascii?Q?WRW6adDTom/PKj5ZwdR2Nh3Fph7DHXBkmh5aqkKhOTFs75Od++NGnWi/rOQL?=
 =?us-ascii?Q?o+3TtPFB5Yq5jSerrs/zGhFV1L3HfnRxgwsVLuM0IfFXd2DrFrjQ6X29HFe2?=
 =?us-ascii?Q?lY+ksVdcVDHgYaVzHdbh78Rw6bn+KXONoPFvKtJweZPyQAMJlu16hVlHwADE?=
 =?us-ascii?Q?uce3wVrPazo3l9Rf5LgUpeH9rRwV2TIySErflC68hR4JUtqWVc2VXzH8SNrz?=
 =?us-ascii?Q?wLAB4rqTo5ABhwsL83GUMETwNd4MRH0KPJX2VCd/ho5L6sIhM1bbfVQGdf0A?=
 =?us-ascii?Q?aRgydyaXNTQgThLlq6/2xESCDJqN2A8/GFcWf+Jg+CHVxxipQrcVhMy7f7eR?=
 =?us-ascii?Q?icrc2YIx03IW6syCFIWv1XRaMy0osy+ek+CJGWu1ekF4YLhN0FnFcDUhOKtE?=
 =?us-ascii?Q?5KKFiV5y2viB1bYQ4NTxR3AEJthVoL8ZPbx4iAAfGXbABx+9WYiB7NYk5Qvm?=
 =?us-ascii?Q?9aqR/wYDJIkzEvbccUgUM5p1k6iDyv+qp6EuZEK3/J32h7XkvIUFTV3dKTy7?=
 =?us-ascii?Q?NXH2Ulsk1Hgcz3jzQn3tbMIxhpFI8C/ABcAfs26Q3OfcXJsTWdbwMbqcV0/5?=
 =?us-ascii?Q?ioOHQ4J5dxKNomCjujpJrhdNBOl6Cs+PpVVGzscq1++1+HkVDu9VUuQFJaHt?=
 =?us-ascii?Q?wj0DFh6V09EvUE7KVZt66a97Ds/LZGgWe3DclAtEHHLxyBCJa+LemFOa38Ww?=
 =?us-ascii?Q?lnYsbbEEG0Dw/+rtyX/mmkwvOVCI/asGV3IeOCfrxTYFEcDoAPmQ3z8Y30kn?=
 =?us-ascii?Q?tvT9QALroeq1xtbUEEKb6HIs+yhhTrSNyoTzKCgPWinweQgbCGHr8ECq4dB0?=
 =?us-ascii?Q?UIlOAKHe4ltoVRJo8bw5S9pzoiFJ5XoJNJoSM6OeZ0DHbx3kSIfI49tbUYul?=
 =?us-ascii?Q?EzCtkquy8My4rUM/chbClV8CVrETOQfemzKpuE2/tfoDRcf5ZVDwGnaYH0ix?=
 =?us-ascii?Q?J0eOrd1PcgrDlzlJABb6kyRiFKd30Ou9zyG4laccpY9MybJ8uvb2is8K/C3s?=
 =?us-ascii?Q?b0j1AONEHc+ksF64b0p8YMM+DImDl7uK1DMKoGRl48/ExN8dpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:10:58.4142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 750d9e1a-4b1d-4bef-2a09-08dc8bb2a600
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044

From: Amit Cohen <amcohen@nvidia.com>

Currently mlxsw driver supports up to 10000 bytes for maximum MTU, this
value is not accurate, we can support up to 10K bytes. Change the value to
the maximum supported MTU by firmware.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/port.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/port.h b/drivers/net/ethernet/mellanox/mlxsw/port.h
index ac4d4ea51597..aa309615eff3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/port.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/port.h
@@ -6,7 +6,7 @@
 
 #include <linux/types.h>
 
-#define MLXSW_PORT_MAX_MTU		10000
+#define MLXSW_PORT_MAX_MTU		(10 * 1024)
 
 #define MLXSW_PORT_DEFAULT_VID		1
 
-- 
2.45.0


