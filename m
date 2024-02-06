Return-Path: <netdev+bounces-69556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFB684BABC
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF041F24A91
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D944134CCD;
	Tue,  6 Feb 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ak+DxJTw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122412D150;
	Tue,  6 Feb 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236281; cv=fail; b=sfi0o+Q167WghjpNMU20Hv9QU/xx98P/oWggY9RbxVO8uiBCmeTLbF7prp0iPlnTFitWNkbk1Mj3uevCjaFIUPeUTj1djLbtIwndWDz1TrovaEQiOOfWqUYHkc0CssgrxP+L63oYYZxdZ618E743ymNhIy384Yhup9RrNbw7iHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236281; c=relaxed/simple;
	bh=QR6Ifefif4+ZmasBFcu2VouJHPKdMvKvnLVNDNaUngY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g9wBszC2B+gy7wu6TLmrFLME/wtk9RG9jDQW27MeKLzzcPq9vwnw3cs8vxfOiVoytr2FQB1ibNVFduYExNW8D15yyC+PDcr/fpcRbCaHaX36YqMumd7BJhU1QW60CWCRlSMfhtd8ANozE/IfLgLoSsNJK9tzbtplmgesDWjUvcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ak+DxJTw; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8aeBkOTEGZR7QoMDeV/iO8QHvqg4+FXNBGZTLjqczy2l6CTATOTncuj5M5t1VmSD141RLevtToZ04CGE/erLiPEz5XFr2mX8yBYbJXFk+CSsDb81eWLOnO4DPoGbJzZabkqk9E04lfl3imhG5v0Q0PdstPk6RFJZUC/8W4mvHOD6S7nUHAYM5v3wCkyEzXf3NOKRwo4DrJB2Dq7q4X6pNd6XCTREh3KwnPUBaizxwLKcASBsHa1XjmfNL6+N3saq2t+8XUv0Wm6R0KtL1hJZrBu0/LVt61ZTHbYe3325hd/CLcdxxdH0Cib+Wx8bmIdTazI9NZLxLAUUG2aWTw9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fWEbHYC+Rk9+oNJUWzMUX9NoMaPLgrU44y3vZNIU1c=;
 b=FfH+t/EQy/sM6EWbij2LYAY2khNBRlbrA98Qx9qE+7KGPrj7xfhqY6NR2h2jIgW99cxUquPY7O1J5YrTO3dvRu/+fmt3986b/UfjMOtdzFIhKrqGAxYxvzgpmTXewogDUvnlAAkJoZVeh7SxKLfJArQfisTa/qx8wn8l929vHvZDo0fWYn8FtWOGfxL/9V4T40Ey5UoYgJat1GPz66uG9fVrWBYVF2yNRtU0plmemvo3spRz+BB34OHCwT3lNb02dBwVdYAl5lhC+qzkfYO7nQpY4tJgmh2r4psPDxgpcaOQtDSBfFu3iEuebvspGtE74kWrvPVdHbEhhRKFHB3pBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fWEbHYC+Rk9+oNJUWzMUX9NoMaPLgrU44y3vZNIU1c=;
 b=ak+DxJTwr6WKgHhq0cgVsYV633+HSGrRr1JYdwP8x3iOX7ZsyVbJb7AAXZ8K3NbzOPvN4LmSBHM78KRawMxmR91Mx05Vwf9SAfHgfYNLcc30v+y2OabuSmnfiNC8vnaDhVUGIhJOCdAC8F6wjB5/5gg8s5mD1dCiGiJmvO+IruLvRCnSyuDdTmPRQ+wPiB/Lm74upoOD0NDxoliUagxcAX/BAGQVOME5q1jEZnXpX0h3Sh4hQFkrIS5Y0wjm7Flsizu3aByX3dXn1gKbkOBV5CRqaHbLhK4msFX0tihj7LeYsyph8apF16Ojmy7hDm48oHkbWq15Dn/9p7lrRKJOzQ==
Received: from BN9PR03CA0288.namprd03.prod.outlook.com (2603:10b6:408:f5::23)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 16:17:55 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::d1) by BN9PR03CA0288.outlook.office365.com
 (2603:10b6:408:f5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 16:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 16:17:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 6 Feb 2024
 08:17:32 -0800
Received: from vr-arch-host06.mtvr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 6 Feb 2024 08:17:30 -0800
From: Parav Pandit <parav@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
CC: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net] devlink: Fix command annotation documentation
Date: Tue, 6 Feb 2024 18:17:17 +0200
Message-ID: <20240206161717.466653-1-parav@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a0c3d2-5143-4989-4ce5-08dc272f2bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iI6c99t97klrBScRtczrFsuWkgNwyKnKmjBNZihZeglbqAUjGksLOfpu955df5SyQmVCOoNnUfXr/J0Kbicr9M7Gf9NJe0FsdAdn6muMHp9Dlqr91Zs0AgAKXnVBZKqPmCWyH975TorEImJEbHvKB9Eh9/Pbgr6rft0t7spbO8BOcv3VxF11zMzxJ4rgpXkuWDwIiqqPoOoqZc45JISLERbPsmithLryQssmqZZrA73IAe+ujvftSvRPwH6/Zq64kBlWUZjBanlgit9a5Wr6Q6FLXYMM2jCP4CqVo5FLv+dpqrhEb+5ajx+JiA65qtUK/klfH8iWcUXTHvdSZbiP+lVEHL2cEKNLrxhKqCv4jfvF7XqPoayjZKPHhYh961tf3dq1jQJOMaTB3meCfoL+w89WwFeiv4JRJvogYsuMeTKHhrDueUzuWY617S7GANu5bduxAMoWcDSJyULqtsew4DG9koR5nFXlzQJEEHOEIiBu/UpqijEkSODAiiK3AiZUeXZF/uPDHlWobsEWWF6HaoRpoh6JIO1aAqV/q8wA8tMpNc8zVMwkUxplMenrj5AvbTRI5sUsAC7P/0b0H12X2smLiFmT9DUD83xZBuG4sooOrhFtW0LyoVBbOR9M3VKQJfXeslHshBlLiu6AQd3LN3DI8lWqA6p1VrhvY7vkEJIKUzbsGlTXEEGawAxUCNzJXgVMe6lyceeb5aT0khvDGkmRiA1u/NewC5ml6VfuIrg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(41300700001)(478600001)(36756003)(7636003)(83380400001)(336012)(356005)(426003)(1076003)(16526019)(82740400003)(47076005)(26005)(2616005)(107886003)(8676002)(5660300002)(2906002)(70206006)(36860700001)(86362001)(6666004)(8936002)(4326008)(110136005)(70586007)(54906003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 16:17:52.7867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a0c3d2-5143-4989-4ce5-08dc272f2bb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465

Command example string is not read as command.
Fix command annotation.

Fixes: a8ce7b26a51e ("devlink: Expose port function commands to control migratable")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/networking/devlink/devlink-port.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index e33ad2401ad7..562f46b41274 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -126,7 +126,7 @@ Users may also set the RoCE capability of the function using
 `devlink port function set roce` command.
 
 Users may also set the function as migratable using
-'devlink port function set migratable' command.
+`devlink port function set migratable` command.
 
 Users may also set the IPsec crypto capability of the function using
 `devlink port function set ipsec_crypto` command.
-- 
2.34.1


