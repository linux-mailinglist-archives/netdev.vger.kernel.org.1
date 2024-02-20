Return-Path: <netdev+bounces-73218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4485B675
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BC028A247
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C45FDA4;
	Tue, 20 Feb 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RK5Ax9D0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC45FBB6
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419616; cv=fail; b=WTPgddJ8dqlMnAi/Zc1VNo6uoCzKLCkqSDzUFuwtNDo+ACJekomCHioQ4Gmoy7XLstB/LYGm/IMJ2DfNI2DOQA/HrmG1ddf3cotOX4K0Z6JtMnPi6CxM/X3+kMcV0We6PzyQZS2DZHKgyk6/lrUIWozuPAiAjQN6Xd3WMbpU5VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419616; c=relaxed/simple;
	bh=6pmMSi9rNVCUK13KIn4Es4nYs+/aKClizhn/RGm/PtQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VWyf2djm0Ij44kIUEVZgxGQPYg5rM3iRbYiANw+7MXH0cafDNmkpxV/khGLH/9pkUt9QyuWB3v9+K8IqbpIWiiR8kECOs6S7h+ATymU5Ij4Td0WEGKoI29vAf4kyqmAdi4vQWreHt6zPU/71Gt/pQsh3w2PTqj6RM95XSSYPmXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RK5Ax9D0; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIeOeL+71+fJdlvycdbTEonH4vaErLZxqHn42itUjdlTrl5OFppk5iwA3qPob+VG4ULhQpBiGZ8On0uoV3/ocsiBOswO+A4G0qaYmXh1FVIJPZa1l8hCCUuKUnlN/NB8ljulaoiS21/o/9qYvEd85TYS1GN/7Wd1o6ykTECbqviU9WaBUS9ml0PFuN3UY8dZj9KHEQ1MioQKNEETjK6kY6O7NPIrJC4ddy1PDvohoUCjnLFwn50topI5X8YNfOkNLGAzgXALD7hI4nDeP9VyZ8Xo3qBw6Qxyd1Al7p9vggv/NVGCEL3NpeIyu83XBAx8hpqtinGNpdGgcy4xF6FuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5r/A6lPAtSyFcGkRgKaf/L/mblU52SB39eOfECKTOAA=;
 b=he/xIhP8Gyi1ZVpbIFMy+sk1QaNWmddU1zliroY+kBxI9fOFQdofiVMVCoxFJ78jXYwaDSUhw4BZxweqe3rzlLULLLNN3fRmMAObIZp8kdNZ8Z6h3DvTWfW4zMGhDWdSiAfCMd6HN8k69CoInxoX1NcYDNjLi45Hkw9Fr9R2jz3ujKCMWO6/BHGF7VZnULZy7ptgrc5pV+9/xAFWvalo2yZdYodP7pXr9JHNmptBUBzeKddL4gajlTlPbjgIP0ZnM2yFcoSDeJJAA7KxTIOo42ZG80y6JsvUPxHGOIsOu3Z4Nm2ymgrEiF7UMI+nr1aOyvAWtXkllSBjxxC3tpH2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r/A6lPAtSyFcGkRgKaf/L/mblU52SB39eOfECKTOAA=;
 b=RK5Ax9D0HysKmzbvhACriTxEb1buMu3F8RwCYyD9SmYgg6CKGqPyYWqdtJPdJKtX5oKocASR1dZI3hmbClRU5w4PrrgezYwQkZrOtQAx1fuvl0dB/WBgKCSb2XXBsOLUwOLop3cEVswIArs4fi8jCEKyVznjsHN7fytCCCgC3d7kuZk2wXIVfqLR7onuJ62qWns/G6Hm/ZjUbcDBsFS9A6oUDilp7IlEPDLaXEQNef1FFZ97LycgDxv6uIje3eHlJY2r/Y/HKITopDjS8zi0K6xQ9k6PnZDIOmXPnyBLknE80GqgTxcKCoRgqBWvfYumWwysQ24m2Er0t+WW/QTPtQ==
Received: from DS7PR03CA0346.namprd03.prod.outlook.com (2603:10b6:8:55::9) by
 DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.21; Tue, 20 Feb 2024 09:00:12 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::56) by DS7PR03CA0346.outlook.office365.com
 (2603:10b6:8:55::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 09:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 09:00:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 20 Feb
 2024 01:00:01 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 20 Feb
 2024 01:00:00 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 20
 Feb 2024 00:59:57 -0800
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, "Gal
 Pressman" <gal@nvidia.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Paul Blakey
	<paulb@nvidia.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] net/sched: flower: Add lock protection when remove filter handle
Date: Tue, 20 Feb 2024 08:59:28 +0000
Message-ID: <20240220085928.9161-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.26.2
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DM8PR12MB5495:EE_
X-MS-Office365-Filtering-Correlation-Id: 62027024-7756-42ec-09f8-08dc31f258b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ooVVBLiAjCEM0zjgJB45U5wPYQ6U5Mk0Cp1smMD+7HLmRoVOMjvN1LeSdxx1CtyuiHF7/lN8N9yrX3LEluj5RBbYqNb2JiYT4Eu3JMAfk3eEw6vfiVS/l2mZSnptysapKvyujn+/uJTtH/t77EL6lX1GhTYbsYJPY3apDatIqDk/PLPJczksHPk8B0Nwm89cMRCE4Q5uuuo4cRe+37ixYa0mybmGkpfsrSNcQ6cWLindvvbVqKCVLWkv1QaqSwnwSV+kYE8+yg4udnAdIjGhGQuMUe3/GMEu0P291obh+75nZnL7zDy8W+qgSkKhJvGWAIkn5NuodD+QB+jA58ppwEwZdRG1szI9rbH6nlBb7V4mija2Iwg+zL/x6sIpL2o0WYOp710eZ7xASkYISUdsQXf4fQimZQKA5NJHldoTu+NAH5ff9vL8UIir18fV1Dcqsf8eisrbwsJYbTMgGoDwBHZW7lhlN69ffD4v1tr/4o91C7uE0OPy3UjDCqvsFTxph1PjYDeh6I/EQZuqMfiV/Q07srvvDxoCZw4iozpd4PEquxGikUHeVRQV8ZuMz2UZxCEPTxNY5HV+Spv0/MAf4n/doIA7MKMgW7B6K0fXUaPO2J/KD0i8EwNRvBt50cU/bWwkCUEZc41JiACuN+cdlwML5adjQvx7IxthTwN4Jvk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:00:11.7776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62027024-7756-42ec-09f8-08dc31f258b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495

As IDR can't protect itself from the concurrent modification, place
idr_remove() under the protection of tp->lock.

Fixes: 08a0063df3ae ("net/sched: flower: Move filter handle initialization earlier")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 net/sched/cls_flower.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index bfedc3d4423d..e1314674b4a9 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2460,8 +2460,11 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	}
 
 errout_idr:
-	if (!fold)
+	if (!fold) {
+		spin_lock(&tp->lock);
 		idr_remove(&head->handle_idr, fnew->handle);
+		spin_unlock(&tp->lock);
+	}
 	__fl_put(fnew);
 errout_tb:
 	kfree(tb);
-- 
2.26.2


