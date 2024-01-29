Return-Path: <netdev+bounces-66855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B146E841318
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9301F24D07
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A713C068;
	Mon, 29 Jan 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DJzyx2Df"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E276C85
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555495; cv=fail; b=d9lOfvE/E2pYpD9O9mEJaUC7wLmYW0tBPJpbhbDlzvhVH0rh2Z94/A6YPzxzvl8qThgsBbo3vHjW8XBTiVuizhn7tjt5gMr0pihWYFwTPxL1UIHm3Jz6og499r//X62Rzw38vXr87B9dfN31Ma4MiJ502JSqzXljni7hO4Wb/7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555495; c=relaxed/simple;
	bh=M2TlnsjoVf+MlwM/rGXYdOv/hmpwA0d4aUIYWiJZsOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jfcqh1Q4wwq2+1YPhT9pyYMS0BXcHvB5MwSmv10dri/ML2MiBAGG90rIvqog0XOieO6bP3Z+sAUkNElvyPgLGbsWiNs2ZyXsbClo9EkfbaDzt3XiW3t9iEkj2GfAH6LiXoTGr1RXF+ZLVWG6fpj6eZo4yP5e+9e1GqhpMlaFQz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DJzyx2Df; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEXhoPc7SAiE5fG9AFe2m8a/goCoR/cfx2pF6EAc9IQTmDz7egPbF6PEbYHKtAblJcLO2SmFmfcoPtfkGjVPoeyL2IiQDehl/T4oNRtp7t2EFs1achAicQWiw2I7FZDl8lFJ+wAJvi819N7gAAz4Og7Ag/bgrLo9R+/7wD/+ewNoYILsWA8tfZ4vjF1ADW3rLDRzpzovN65WvUsGS4G5+vBqJKoKMH0U2GXCG9ti1m580n0lWLMj8h7QkZVxYY2Nj53KDBc4mdwZqau8onnOcojclHmYBRBKQubHNa5xaJRVBq5rHr1dpvmZ5bZO4+Xi5GeSKAT7wXoIaaTf1R/Ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP2UMNb3ctTOYfgbBOPYbsG19JcckZVIpbOYtE+txp4=;
 b=NUanx5eaW2CA0iY4wn1YCrwcv1MaD/8M9HCByjMIvCFm1OdApSktXCQJagSiMoqNWwMTBqQTuzsm7qRTs618bum1O5Iqoft/M9BKNzpqkii0hPtGrJPs9cn2xAenlpQj2SPqOngK1R154T8TV8GCYfU+v1eMBN6WDYwqJDGvC1QXl7TjkA/XlVabyTnmlIvbv4nJCseMnRCZHSPbxYQTqaN4HVaYrcTbxNWnRA6XcASlRfyu9/h/L9RME43QlYtjaBvJNgk6FaJaAGofo4roWQphY0mGB0PtPNo4BDuRkC6rOH1pwmw0O18vscaN+MYsWqJiGtuaG1exYiLzXZewjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP2UMNb3ctTOYfgbBOPYbsG19JcckZVIpbOYtE+txp4=;
 b=DJzyx2DfXa35X77Bzw6DU3p4/G65qZpBS+wMp3zPsPhoyaKLgvRPeCuF5DLSP+toXk6TsLClwbxmwJBfZbGLg2BJYB3lhUhM0ZAktsjt3pRCICShTzFuq7HyPwxds2yFEy4S/hwZk8UZuip0+ymY+97nMe4+4MTFZz8ANnxsd+izuPffafjOvfJCF/lM/leXgf6T5tWpkto4eU6uEeuM41nN7vIlRO3YT9qb2boMcKhNH+Iyj+/HMvOMof4ncI4Pc0S+D2+FkJPGowYeuUaBfzKh2dlIAN4HR2DxASmLOOGf1OIzGZtTD8wMI0DJAIofTW1WiDVZ1Mm+E2yq86+/RQ==
Received: from BN9PR03CA0294.namprd03.prod.outlook.com (2603:10b6:408:f5::29)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Mon, 29 Jan
 2024 19:11:31 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::5) by BN9PR03CA0294.outlook.office365.com
 (2603:10b6:408:f5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 19:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 19:11:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 29 Jan
 2024 11:11:16 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 29 Jan 2024 11:11:15 -0800
From: Parav Pandit <parav@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shayd@nvidia.com>, <netdev@vger.kernel.org>
CC: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net] devlink: Fix referring to hw_addr attribute during state validation
Date: Mon, 29 Jan 2024 21:10:59 +0200
Message-ID: <20240129191059.129030-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH0PR12MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb0d0cc-2636-429a-ca4c-08dc20fe19cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PMRsqCOkraq83W0ojtll1jd/5G6Ob06648RrhsyEXUtPG4C2ch0BCetGwIeFRy096AJOpge/4g1WkS+tynz/bOjYJjKaPIk/7RzePjnOdportXuGGmpwta1c4CNCsUO+LL684DiqLxy6RzXw29jlRTx9HruN97YqPIcnFJBV8+8/owVrjmEF8XstZlvBjIwAmOj7npAv5TRcGjfMuTtELgFjuNtsZGEN9JiWE1gvLmmATRh/bT7Yyk6KSgi+byCXO4eR0/9sEjc0jL1jdQrokAkZCUQ/dioGIN9S8IAaSMppnwKuwb2FHqq24FQJsso9jeOOsmIEkvILQ6GHVsgFzmwhsGdxqRa9sTLSayfS6q3vTyxKLuswylh/H66m6ZdDbzsSW/c+Qd2+X/dEBz/LwP85GtQg5CKta9u+kgoeyZgfb3DuaVkrmwL3AYKbPjkMRjDaDcW+zL63bhzYcpzPOVsbICfb9nyqHfqYec3sni950jz+/SEey2oZYB+GtU9BDDY6pC22ygKdYoqeEUCaPwRtmTYc83chq+2q/ZGNTiE7Uams0AnGMfCuAcRUTigb5CeyTHoy+UPQLkSizs83BKWwYQgUFiPS8BgxtMZ0+neg82u6jo5KQGLFHoHaZiCydLKn85lGQPFnJA2fgCFdEmn0VOg4M5DK/GuIFlWEKUggWnLOJqPV+5wDgmKbOQsKgT4RSkqOfuCOA5zCHlXPPZ9Dmw+ZQF1uRXgKIhOOLwHkCnbxIxfNfejlvMxSG4wI
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(26005)(40460700003)(40480700001)(16526019)(426003)(83380400001)(6666004)(336012)(1076003)(36756003)(86362001)(82740400003)(356005)(7636003)(8676002)(8936002)(41300700001)(4326008)(5660300002)(36860700001)(478600001)(107886003)(316002)(47076005)(110136005)(70206006)(54906003)(2616005)(2906002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 19:11:30.4566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb0d0cc-2636-429a-ca4c-08dc20fe19cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385

When port function state change is requested, and when the driver
does not support it, it refers to the hw address attribute instead
of state attribute. Seems like a copy paste error.

Fix it by referring to the port function state attribute.

Fixes: c0bea69d1ca7 ("devlink: Validate port function request")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 62e54e152ecf..78592912f657 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -674,7 +674,7 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
 		return -EOPNOTSUPP;
 	}
 	if (tb[DEVLINK_PORT_FN_ATTR_STATE] && !ops->port_fn_state_set) {
-		NL_SET_ERR_MSG_ATTR(extack, tb[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR],
+		NL_SET_ERR_MSG_ATTR(extack, tb[DEVLINK_PORT_FN_ATTR_STATE],
 				    "Function does not support state setting");
 		return -EOPNOTSUPP;
 	}
-- 
2.26.2


