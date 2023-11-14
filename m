Return-Path: <netdev+bounces-47618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0177EAB1A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 08:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302622810BF
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 07:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAAC125A2;
	Tue, 14 Nov 2023 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jkmnlyyw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B678111C90
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 07:56:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99215195
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:56:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfnMe/yHwX+HRYeEfdkoD7x4UPIRruvw5yzJ2QVXZGA0+jc/rZhtIHCByy5/trIaMhD6HWmCspNqFLrhP6uA3bw5FCOtCiZCIgb8JAhfSIxTxCFqnGvXNjSDSaTmt2Y2R7ANp9aAKLp35+ZwKPGAw1SgC6brCBnLhaEkZnQ4ZIo1D4CjOF1rbS8jLuZpb+LJ4KTXJn99Bhr2trsRnC+qv8v+yeZ1xILqzh1bemt8MkBy5wLNtH6dQ7YNPk0DlW6P0RTcvtvWGrMN6nEZCj0wTC1VO4xDIRWGgR6+hGxeqMPZfR9KwTB/95SRg6beFkXN/k73v7wxoxra1yP0ZG9jyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjWccpywgZH0Hb2C2F4Ri5XLOBqX1qIrKhainxmd78I=;
 b=T0s2EJMw14UNwhH2f9vEjL96rSWdxbbKdVRz6ZPnVS5E+t4g+qOxwFijc0JqzvcGT1YsMaENjqGRGjVwvpL2nNRLutJFE46DUJAW6fKBp062uHRzi5kna2CeOmAhjD/rAPmSdxXdfwEZGW/YAnbYeaN+JDErvQ/uluz088qQClBJwBSAHTvRWLLKaWcGhBzh7PA4dkTK/oEQ2iTPG7/xDSP2dAaX0cpiPyRXQpfxRJKiPbX6xG1aP2+EoIsRL+ZavcqssWRQwOsvomh3hXRfpWpP8pZkkJm6na26hFpyPwEJrq5lyeoAGUOL8LImUCyBy/4ir2KyMJ2ZOOSr7rsqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjWccpywgZH0Hb2C2F4Ri5XLOBqX1qIrKhainxmd78I=;
 b=jkmnlyyw3NAiw9qZnFbbkzjMNzk0KcVtUEUmq7/A1zTvKTGf//Fwo19GohV7EPPcT78oU4KEFLF29CBnFgnnYfp4J73/FsUYuEIUmTngsSCB25UiYAHbeV5nl/6w3c6LZFpcFGGFw0YznY+odE+4m3sYtMoHOVgVYQYMk6XsjDYg5PsBOy42dNojpcAugvr7htUO9cp5NGKjsZmgFoz3DJN5iMRr8HXpmbZ9dWBUYeZcvI6nxF6y5UEV/+GBPLQGny5BQSMtx6krd5To43V34PK97mVmyx0LYuVmGpf0gt4qs2djE5eFseS/yTEzrBXa4sGuFXQjWXxjztPEpqbY9g==
Received: from BL0PR0102CA0003.prod.exchangelabs.com (2603:10b6:207:18::16) by
 DM4PR12MB5280.namprd12.prod.outlook.com (2603:10b6:5:39d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 07:56:37 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::b9) by BL0PR0102CA0003.outlook.office365.com
 (2603:10b6:207:18::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 07:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 07:56:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Nov
 2023 23:56:22 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Nov
 2023 23:56:22 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Mon, 13 Nov
 2023 23:56:19 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jiri
 Pirko" <jiri@resnulli.us>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Gal Pressman <gal@nvidia.com>, Vlad Buslov
	<vladbu@nvidia.com>
Subject: [PATCH net v2] net: Fix undefined behavior in netdev name allocation
Date: Tue, 14 Nov 2023 09:56:18 +0200
Message-ID: <20231114075618.1698547-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DM4PR12MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: 33317e82-aaff-4cd2-5a84-08dbe4e73a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y4wqsUjovPMPnzRUwD5nkHRpXYkkAHJruhH4OMKyXNgeW6hdnawjTQ5EmOT+veTGUzYjocE8whdw9MzNttuGkIcsuImsOKUk6kCHDqLDt7ivLAPllI37FIp81yRMXMPVtyxZq8XQ6Vbj+XVRyerXEy5B9tVGdOo6WZZuZXbiBQefEbbmSe5LEm6T005YQnJK7+bX3kOe1bl0wSAvvA7/4yagnB3nhC/su+rPw3fvooXsWRsKvJ6jdVmObCp/6YPnMB98dsUYS8SKVOjTOtcbm9Zd9kDoEzfgPyaM257Lvhh7069EN44sTIgyOIgpdCCsmgGKcdWqet+xdBOEo03b7VLC5mgBJaKltmoCsytHrEymcbnbR5uNAWRYEiL6+49nZrCT2lvPgXjnul7A05PKSghfKl24QrT151snRkoTgf/0z1Yv68bLD2nPyIBD+nuVCq93XyOst8ZuABjpLqwJSkVegO5+kADsFrgdO66PGVNSOnWBRRWc4WFhkfK8cMNF93lzrbqasV2QO5nv37R93UxRCFn2+IBDEiBYXXSyu0/R2wQHWMdHma3mMtTg63S2xgTzElzNxHnCTabygWiXJ48O5toDnf/Wcy/+Gal8WzBUZ1GZGrY0CD0Qc6CziLuxwYbyLSsT8ZfS4M64Hltuc/ulIKBtCl/l2q2xjHV06MkmDmXPWyNebgDyYZZTb0k39yXY07h747pe8rvDu04QNRyCo5/FmZI634xkFcKCfa1i0eS3UTFhzM6i1GsEwDL/QvhfwZDMjzrOfhpkX/LVh3H7dKr+YlIPN4zEXVv/XEc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(8936002)(8676002)(40480700001)(40460700003)(54906003)(2906002)(5660300002)(4326008)(83380400001)(966005)(426003)(7636003)(36860700001)(356005)(82740400003)(70206006)(86362001)(316002)(36756003)(41300700001)(478600001)(7696005)(47076005)(336012)(70586007)(110136005)(2616005)(107886003)(26005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 07:56:36.7031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33317e82-aaff-4cd2-5a84-08dbe4e73a42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5280

Cited commit removed the strscpy() call and kept the snprintf() only.

It is common to use 'dev->name' as the format string before a netdev is
registered, this results in 'res' and 'name' pointers being equal.
According to POSIX, if copying takes place between objects that overlap
as a result of a call to sprintf() or snprintf(), the results are
undefined.

Add back the strscpy() and use 'buf' as an intermediate buffer.

Fixes: 7ad17b04dc7b ("net: trust the bitmap in __dev_alloc_name()")
Cc: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
Changelog -
v1->v2: https://lore.kernel.org/all/20231113083544.1685919-1-gal@nvidia.com/
* Mention that dev->name is usually used as the format string in the
  commit message (Jakub).
* Put the right commit in the Fixes tag (Simon).
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..af53f6d838ce 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1119,7 +1119,9 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 	if (i == max_netdevices)
 		return -ENFILE;
 
-	snprintf(res, IFNAMSIZ, name, i);
+	/* 'res' and 'name' could overlap, use 'buf' as an intermediate buffer */
+	strscpy(buf, name, IFNAMSIZ);
+	snprintf(res, IFNAMSIZ, buf, i);
 	return i;
 }
 
-- 
2.40.1


