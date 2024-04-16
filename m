Return-Path: <netdev+bounces-88275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44EB8A684A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6071D281CBC
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102AD127E0F;
	Tue, 16 Apr 2024 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HqMgqXzH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A26127E05
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263225; cv=fail; b=u833boYBoMvrqtkQpRcJ2z2ysDkgOr+9hNQpKflN2jgX7E95DMO8526aRSGyUCL6XNNxPoAuj4dWm52uxiY7OCSxXq4ip0HzkC+B+B3+4+fxghYjy+dlkZySaYxqSAoh3kzxQVgqnzoBy3bu8CY9+lRh/wsIWhOPBM8fVG9DT/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263225; c=relaxed/simple;
	bh=aZDt/74D3hkNT29skr/+pA5sZUZ07IYPyeccLC244vA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XeAG8L9GLrxy/4SgqfWw5DOKBmH7H2YnGUDFlefZ2hzDpWIWXigVQwevcS59ofPEP4/NC+SO/VAD6FSt5N3lraZKHGxO025I51ieacsZ8OE53nctodArc06IRnxi7auXOAHleNKtFgmcN80MEP73T4y3TSHaV2xGraR9CPIzF7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HqMgqXzH; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbtUQsj2wlYXRAYGbCIanpHjutJO7ulX6+1Th2DeRMfKFUY+UhMtqcKuaXSYBR6cV7KgYv5wu05cS1STKm0jfqt3Nb5Y/NRy+c2oss6vGyFJxmLAZ5+fYBM5zVHKb5TJyyEEPwuS0VX+nZQCXKx88fo1Fz6mYa7nWfOWkRqa0Ry8Y2ojb5IVvOw0L8paFxoKvfKRa6LF2AHRIOD7e3Wg4MLleEEcqdVhSxYS9YTcRPJQ16dXG43KzUBjrdSJMFxijwDCAdPf/QvmPzmrfAv+7tV+Pt8Q/zrQQElkbqk5oSzZgvZBJjz5sDhbgzybFPQF/ayx7PoArPKS1GekXEAfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAIlGc41xWO93zGue3pZTyNNDCSt0ctH1w4S4nlNZnM=;
 b=BgYV5r/NoCRpYGTzmFIEP5ZPY9R5OlGvTkddUtLnWnpaBbKK63Nm65XyJgCG+BKjFkRtpXmn5bXprBNv4PjAdnrd10GMdZazF3NXHZtuKf506YGxeestQ+NnKpAsUj497KFQbloPySWiX7EZOh/y2hHZpnpj2vFe1oxV8Z0oJu4v0XDEsTaWDTnGIusZo2hvYhove793KNucvb6/7nWBUM/OgYcAjH/pe4NixqIN5Uv4WqwkwfqRvfnjnmcBE53JKpeFgAo1gZ0JU4GzMnrsV726G3oPXSJBRI3yI/qXkGnzQCsHniWs+/N3x2rsLVtpLGe7IT6fBnMZOEpSAk3vzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAIlGc41xWO93zGue3pZTyNNDCSt0ctH1w4S4nlNZnM=;
 b=HqMgqXzHgSf1qhZoHB7R/ZEHc5Fa0/iCgjfb4t9DqfO5JGKoP6r2mKZumJ+d+MRxxCVg+W6Eg0YHrQxOozeY3dlIzGHBSCS7cAlnXtPhzpdLoSqgrq1V9gbg6obR1aqoKoVRJNQ9GelWPQyrTtQe4DIVZV80nXof/gsUQaGKPHWD54Zkc94/6y8lkVUKWr7gLPJQxDoXeVzS92MSSaUJY42MnnoWIrxBY+tKTdxNnoTQ+53nAiEPEeNWJu+teCs+HEz+LXNZKiCYrN0k8V2vi/5Sz4cJvujmUgCz+p8Hnl/X1s0vqkUYtEiVCEro85ajuVeDAWkckJfmQ0bTK2SN0Q==
Received: from DM6PR07CA0070.namprd07.prod.outlook.com (2603:10b6:5:74::47) by
 DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.43; Tue, 16 Apr 2024 10:26:56 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::6d) by DM6PR07CA0070.outlook.office365.com
 (2603:10b6:5:74::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 10:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 10:26:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Apr
 2024 03:26:42 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 03:26:37 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen
	<amcohen@nvidia.com>
Subject: [PATCH net 1/3] mlxsw: core: Unregister EMAD trap using FORWARD action
Date: Tue, 16 Apr 2024 12:24:14 +0200
Message-ID: <bb8f06c1644f0d3dfb3a488f625f27476d9b8a01.1713262810.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713262810.git.petrm@nvidia.com>
References: <cover.1713262810.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb89957-2f1e-4e02-02c5-08dc5dffbd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Owur/vghonY1ss/KG+cZ2DYD6Os9cy4FoPtV8HbM9gAnz4ANaEyfb8oh5NpXEdozY6eX39Kx0JXWVx1wA40Bedchr2wI8/NN90E5onDdDeOTitEIUDKzSLexSdNFmsV3tUj1DmniLYnKYgMc+gnp1U3oStJPRkQp1pzY2TS38zyNVugClke7+iHsVLfCABOa/4F+P+zR4OE/oca7Lj84xRccEYpPBVc7ob1s6LX7Ir41SrXU4zEPScguu6488iJXADifbT/oLYiJtmpvmkPM9ECiOy1vB/nOhGLp2A/hOTL9hOxOoDEFYYa/743gSz6lKawUP31f1oIqxC7FMUIcdm0PRsyhiKIblK6BQ2+68ObRLSps5kzOUbA3rN+e/OYY8eW7LVPp2YUzz/89L6rrt8cWPZhtLy4fxmoxvkX9WstH2Iu8OrN4Mov66FTrH1Hl6QGQlCOVvK5vgxrqu0vAJhYjkhhlELp/75IPOlen1Ytf5+pr6VYYuWCtE4Biv15w8qR+AFmyilqiBbEtZdYi6PG/Amd66FCqdYXxDWTR8Posa7exmeAzNk6ii2AGezbafvvCKn9RndloXhJWeuo0jI8g+PbVQvglmXoxsNsM1BlhJPJAAeDnDWJdpg1s5tTrqJ+4yHWi/1RTZPvRi+13onyFCFTOTKKMqYR7KdY5jHqplb2SOVNxXp/d9mCSrVCFSzrtvic1r0Gdo5AM5B9dIdd3JzHQANjHkQ7i0Z7/8mFVnStp0A33kOorm5cqky4o
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:26:55.7195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb89957-2f1e-4e02-02c5-08dc5dffbd97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376

From: Ido Schimmel <idosch@nvidia.com>

The device's manual (PRM - Programmer's Reference Manual) classifies the
trap that is used to deliver EMAD responses as an "event trap". Among
other things, it means that the only actions that can be associated with
the trap are TRAP and FORWARD (NOP).

Currently, during driver de-initialization the driver unregisters the
trap by setting its action to DISCARD, which violates the above
guideline. Future firmware versions will prevent such misuses by
returning an error. This does not prevent the driver from working, but
an error will be printed to the kernel log during module removal /
devlink reload:

mlxsw_spectrum 0000:03:00.0: Reg cmd access status failed (status=7(bad parameter))
mlxsw_spectrum 0000:03:00.0: Reg cmd access failed (reg_id=7003(hpkt),type=write)

Suppress the error message by aligning the driver to the manual and use
a FORWARD (NOP) action when unregistering the trap.

Fixes: 4ec14b7634b2 ("mlxsw: Add interface to access registers and process events")
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index e4d7739bd7c8..4a79c0d7e7ad 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -849,7 +849,7 @@ static void mlxsw_emad_rx_listener_func(struct sk_buff *skb, u16 local_port,
 
 static const struct mlxsw_listener mlxsw_emad_rx_listener =
 	MLXSW_RXL(mlxsw_emad_rx_listener_func, ETHEMAD, TRAP_TO_CPU, false,
-		  EMAD, DISCARD);
+		  EMAD, FORWARD);
 
 static int mlxsw_emad_tlv_enable(struct mlxsw_core *mlxsw_core)
 {
-- 
2.43.0


